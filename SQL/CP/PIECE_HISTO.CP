-------------------------------------------------------------------
--
-- Fichier              :       PIECE_HISTO.CP
-- Auteur               :       Fabry JF
-- Date                 :       22/09/2016
--
-- Commentaires         :       Table permanente des pièces pour memoire dem/recp.
--
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_IU_PIECE_HISTO
-- Auteur               :       JFFPS_U_MAJ_ETAT_PCE_SHERPA
-- Date                 :       22/04/2016
-- Libelle              : 	[VDOC21884]
-- Commentaires         :       
-- References           :  (Non appelé, pas prod, car reportée en TRIGGER sur w_piece)
--
-------------------------------------------------------------------
-- [20251024135148363][JFF][MIG165_BOUYGUES]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_IU_PIECE_HISTO' AND type = 'P' )
        DROP procedure sysadm.PS_IU_PIECE_HISTO
GO

CREATE procedure sysadm.PS_IU_PIECE_HISTO
  @adcIdSin     Decimal (10),
  @dtValideLe   DateTime -- [PI062]
AS

-- Piece reçues : Présence dans sysadm.piece_histo et absence dans w_piece
Update	sysadm.piece_histo
Set		dte_reception = @dtValideLe,
		maj_le = @dtValideLe,
		@dtValideLe= @dtValideLe
From	sysadm.piece_histo ph
Where	ph.id_sin = @adcIdSin
And		ph.dte_reception is null
And		Not exists ( 
			Select	Top 1 1 
			From	sysadm.w_piece wp
			Where	wp.id_sin = ph.id_sin
			And		wp.id_gti = ph.id_gti
			And		wp.id_detail = ph.id_detail
			And		wp.id_pce = ph.id_pce
		)

-- Piece demandées : Absence dans sysadm.piece_histo et présence dans w_piece
Insert into sysadm.piece_histo ( -- [20251024135148363][JFF][MIG165_BOUYGUES]
	   [id_sin]
      ,[id_gti]
      ,[id_detail]
      ,[id_pce]
      ,[id_i]
      ,[id_para]
      ,[dte_demande]
      ,[dte_reception]
      ,[cree_le]
      ,[maj_le]
      ,[maj_par]
      ,[valide_le]
      ,[valide_par]
) -- [20251024135148363][JFF][MIG165_BOUYGUES]
Select	wp.id_sin,
		wp.id_gti,
		wp.id_detail,
		wp.id_pce,
		wp.id_i,
		wp.id_para,      
		wp.cree_le,
		null,
		wp.cree_le,     
		wp.maj_le,      
		wp.maj_par,     
		@dtValideLe,    
		wp.maj_par
 
From	sysadm.w_piece wp
Where   wp.id_sin = @adcIdSin
And		Not exists ( 
			Select	Top 1 1 
			From	sysadm.piece_histo ph
			Where	ph.id_sin = wp.id_sin
			And		ph.id_gti = wp.id_gti
			And		ph.id_detail = wp.id_detail
			And		ph.id_pce = wp.id_pce
			And     ph.dte_reception is null
		)

Go



--------------------------------------------------------------------
--
-- Procedure            :       PS_REDRESS_PIECE_HISTO
-- Auteur               :       Fabry JF
-- Date                 :       28/04/2017
-- Libelle              :       
-- Commentaires         :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_REDRESS_PIECE_HISTO' AND type = 'P' )
        DROP procedure sysadm.PS_REDRESS_PIECE_HISTO
GO

CREATE procedure sysadm.PS_REDRESS_PIECE_HISTO
AS

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_sin	decimal (10 ),
	  marquage	integer null 
	)

Declare @dcIdSin decimal (10 )
Declare @dtValideLe DateTime
Declare @iIdSeq integer

Set @dtValideLe = GetDate()

Insert into @tb
Select distinct 
	   id_sin,
	   0  
from sysadm.w_piece wp
where not exists ( 
		Select top 1 1 from sysadm.piece_histo ph 
		where ph.id_sin = wp.id_sin
	)


While Exists ( Select Top 1 1 From @tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdSin = id_sin
	From	@tb
	Where	marquage = 0

	Exec sysadm.PS_IU_PIECE_HISTO @dcIdSin, @dtValideLe

	Update @tb Set marquage = 1 Where id_seq = @iIdSeq
 End
Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_U_MAJ_ETAT_PCE_SHERPA
-- Auteur               :       Fabry JF
-- Date                 :       06/01/2020
-- Libelle              :       
-- Commentaires         :       [PC192290]
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
-- [20251020094815167][JFF][MIG147]
-- [20251024135148363][JFF][MIG165_BOUYGUES]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_MAJ_ETAT_PCE_SHERPA' AND type = 'P' )
        DROP procedure sysadm.PS_U_MAJ_ETAT_PCE_SHERPA
GO

CREATE procedure sysadm.PS_U_MAJ_ETAT_PCE_SHERPA
	@adcIdSin Decimal ( 10 ),
	@asChaineTrt1 VarChar ( 255 ),
	@asChaineTrt2 VarChar ( 255 ),
	@asChaineTrt3 VarChar ( 255 )
AS

Declare @sChaineTrt Varchar ( 765 ) 
Declare @iIdSin Int
Declare @dcIdProd Decimal ( 7 )
Declare @iIdCli Integer 
Declare @sZnDS_pceSherpaRacine Varchar ( 50 )
Declare @sZnDS_pceSherpa Varchar ( 50 )
Declare @iZnDS_pceSherpa integer 
Declare @sPceReclAvecPrecision VarChar ( 508 )
Declare @iIdCt Integer

Set @iIdSin = Convert ( Integer, @adcIdSin )

Select @dcIdProd = id_prod From sysadm.w_sin where id_sin = @adcIdSin  
If @dcIdProd is null Select @dcIdProd = id_prod From sysadm.sinistre where id_sin = @adcIdSin  

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		EXEC SHERPA_PRO.sysadm.PS_U_ARCHIVE_PIECE @iIdSin, @asChaineTrt1, @asChaineTrt2, @asChaineTrt3

		-- [20251020094815167][JFF][MIG147] Maj particulière.
		-- Si dp/345 présente ET présence de la sur piece histo avec dte_recption à null 
		-- ET présence dans Archive de la piece avec un état non null
		-- Alors on maj dte_demande= Getdate()
		If sysadm.FN_CLE_NUMERIQUE ( 'EVOL_MODUL_PCE_WEB') > 0 
		 Begin

			 Select @iIdCli = id_cli From SHERPA_PRO.sysadm.sinistre where id_sin = @iIdSin and id_appli = 2  
 
			 Update ph
			 Set dte_demande = Getdate()
			 From SHERPA_PRO.sysadm.archive a,  
				  SHERPA_PRO.sysadm.contact c,
				  sysadm.piece_histo ph,
				  sysadm.det_pro dp
			 Where ph.id_sin = @adcIdSin
			 And   dp.id_prod = @dcIdProd
			 And   dp.id_code_dp = 345
			 And   c.id_cli = @iIdCli  
			 And   c.id_sin = @iIdSin  
			 And   a.id_cli = c.id_cli 
			 And   a.id_contact = c.id_contact 
			 And   a.id_pce = convert ( integer, ph.id_pce)  
			 And   a.etat_pce is not null -- Traité (analysé conf ou non conf)
		 End 
	END
ELSE
	BEGIN
		EXEC SHERPA_SIM.sysadm.PS_U_ARCHIVE_PIECE @iIdSin, @asChaineTrt1, @asChaineTrt2, @asChaineTrt3

		-- [20251020094815167][JFF][MIG147] Maj particulière.
		-- Si dp/345 présente ET présence de la sur piece histo avec dte_recption à null 
		-- ET présence dans Archive de la piece avec un état non null
		-- Alors on maj dte_demande= Getdate()
		If sysadm.FN_CLE_NUMERIQUE ( 'EVOL_MODUL_PCE_WEB') > 0 
		 Begin

			 Select @iIdCli = id_cli From SHERPA_SIM.sysadm.sinistre where id_sin = @iIdSin and id_appli = 2  
 
			 Update ph
			 Set dte_demande = Getdate()
			 From SHERPA_SIM.sysadm.archive a,  
				  SHERPA_SIM.sysadm.contact c,
				  sysadm.piece_histo ph,
				  sysadm.det_pro dp
			 Where ph.id_sin = @adcIdSin
			 And   dp.id_prod = @dcIdProd
			 And   dp.id_code_dp = 345
			 And   c.id_cli = @iIdCli  
			 And   c.id_sin = @iIdSin  
			 And   a.id_cli = c.id_cli 
			 And   a.id_contact = c.id_contact 
			 And   a.id_pce = convert ( integer, ph.id_pce)  
			 And   a.etat_pce is not null -- Traité (analysé conf ou non conf)
		 End 

	END	

-- [MIG165_BOUYGUES]
If sysadm.FN_CLE_NUMERIQUE ( 'MIG165_BOUYGUES') > 0 
 Begin
	-- Maj précision sur sysadm.piece_histo
 	Set @sChaineTrt = CONCAT ( @asChaineTrt1, @asChaineTrt2, @asChaineTrt3 ) 
	Set @sChaineTrt = Replace ( @sChaineTrt, '@', '' )
	;With tb1 
	As ( 
		Select valeur 
		from sysadm.FN_STRING_SPLIT ( @sChaineTrt, '#' ) 
		Where valeur <> ''
	)
	Update ph
	Set id_precision = sysadm.FN_CLE_VAL ( 'PR', tb1.valeur, ';' ) 
	From tb1, 
		 sysadm.piece_histo ph
	Where ph.id_pce = convert ( Decimal ( 7 ), sysadm.FN_CLE_VAL ( 'IP', tb1.valeur, ';' )  )
	and ph.id_sin = @adcIdSin

	-- trace par un contact des pièces réclamées avec précision
	;With tb1 
	As ( 
		Select valeur 
		from sysadm.FN_STRING_SPLIT ( @sChaineTrt, '#' ) 
		Where valeur <> ''
	)
	SELECT @sPceReclAvecPrecision =
		( SELECT 
			   '(' + sysadm.FN_CLE_VAL ( 'IP', valeur, ';' ) + ') '  +
			   Trim ( sysadm.FN_CODE_NUM ( sysadm.FN_CLE_VAL ( 'IP', valeur, ';' ), '+PC' )) + ' ' +
			   '(précision : ' + sysadm.FN_CODE_CAR ( sysadm.FN_CLE_VAL ( 'PR', valeur, ';' ), '-WS' ) + ')' +
			   char ( 10 )
		FROM tb1 
 		WHERE len ( sysadm.FN_CLE_VAL ( 'PR', valeur, ';' )) > 0
		FOR XML PATH(''))

	If @sPceReclAvecPrecision is not null and @sPceReclAvecPrecision <> '' 
	Begin
		Set @sPceReclAvecPrecision  = 'Certaines pièces ont été réclamées avec une précision qui apparaîtra sur l''extranet : ' + Char ( 10 ) + @sPceReclAvecPrecision  
	End 

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
			Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @adcIdSin, 2, @sPceReclAvecPrecision, 'AUTO', 300, @iIdCt OUTPUT							
	END
	ELSE
	BEGIN
			Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @adcIdSin, 2, @sPceReclAvecPrecision, 'AUTO', 300, @iIdCt OUTPUT							
	END	
 End 

Set @sZnDS_pceSherpaRacine = 'sznds_pcesherpa_'
Set @iZnDS_pceSherpa = 1 
Set @sZnDS_pceSherpa = @sZnDS_pceSherpaRacine + Convert ( varchar ( 10),  @iZnDS_pceSherpa ) 

While Exists ( Select Top 1 1 From sysadm.div_sin Where id_sin = @adcIdSin and nom_zone = @sZnDS_pceSherpa ) Or 
	  Exists ( Select Top 1 1 From sysadm.w_div_sin Where id_sin = @adcIdSin and nom_zone = @sZnDS_pceSherpa ) 
 Begin
	Delete sysadm.div_sin Where id_sin = @adcIdSin and nom_zone = @sZnDS_pceSherpa
	Delete sysadm.w_div_sin Where id_sin = @adcIdSin and nom_zone = @sZnDS_pceSherpa

	Set @iZnDS_pceSherpa = @iZnDS_pceSherpa  + 1 
	Set @sZnDS_pceSherpa = @sZnDS_pceSherpaRacine + Convert ( varchar ( 10),  @iZnDS_pceSherpa ) 
 End 

Go


