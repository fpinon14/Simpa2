-------------------------------------------------------------------
--
-- Fichier              :       DET_PRO.CP
-- Auteur               :       Abdmeziem C.
-- Date                 :       06/02/2003
--
-- Commentaires         :       Gestion de la table DET_PRO
--
-- Procédures           :       DW_S01_DET_PRO_V01,
--				PS_DET_PRO
--	FPI le 20/08/2008 - [DCMP80334] PS_LIRE_UO_V01
--				DW_S02_DET_PRO
--
-------------------------------------------------------------------
-- sysadm.DW_S01_DET_PRO
-- sysadm.DW_S01_DET_PRO_V01
-- sysadm.PS_DET_PRO
-- sysadm.PS_LIRE_UO_V01
-- sysadm.PS_S01_VERIF_DET_PRO
-- sysadm.DW_S02_DET_PRO
-- sysadm.PS_S01_DET_PRO
-- sysadm.PS_S_MONTANT_CAUTION_PRODUIT
-- sysadm.PS_S_MONTANT_CAUTION_SINISTRE
-- sysadm.PS_S_MONTANT_CAUTION_V01
-- sysadm.PS_S_VRAI_ORANGE_V3
-- sysadm.PS_S_AUTRE_ORANGE_V3
-- unique index det_pro_uk1 on sysadm.det_pro (
-- CREATE TRIGGER sysadm.TR_I_DP_UNIQUE
-------------------------------------------------------------------


--------------------------------------------------------------------
--ORANGE_V3BIS
-- Procédure            :       DW_S01_DET_PRO
-- Auteur               :       Abdmeziem C.
-- Date                 :       06/02/2003
-- Libellé              :        
-- Commentaires         :       Select sur la table DET_PRO
--
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_DET_PRO' AND type = 'P' )
        DROP procedure sysadm.DW_S01_DET_PRO
GO

CREATE   procedure sysadm.DW_S01_DET_PRO
	@dcIdProd	Decimal (7) = -1
AS

-- FS pb du 25/08/2006 : Pb de code simpa je positionne default -1

if @dcIdProd = -1
 SELECT id_prod,
        id_typ_code_dp,
        id_code_dp,
        id_typ_calc,
        id_code_num,
        id_code_car,
        val_num,
        val_car,
        unt,
        tri,
        cree_le,
        maj_le,
        maj_par
 FROM   sysadm.det_pro
else
 SELECT id_prod,
        id_typ_code_dp,
        id_code_dp,
        id_typ_calc,
        id_code_num,
        id_code_car,
        val_num,
        val_car,
        unt,
        tri,
        cree_le,
        maj_le,
        maj_par
 FROM   sysadm.det_pro
 where 	id_prod = @dcIdProd



GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_DET_PRO_V01
-- Auteur               :       Abdmeziem C.
-- Date                 :       06/02/2003
-- Libellé              :        
-- Commentaires         :       Select sur la table DET_PRO
--
-- Arguments            :       
--
-- Retourne             :       Rien
-- 28/08/2006  JCA	Ajout param produit.
--  #1   JFF   02/09/2009 [DCMP090327].[SBETV]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_DET_PRO_V01' AND type = 'P' )
        DROP procedure sysadm.DW_S01_DET_PRO_V01
GO

CREATE procedure sysadm.DW_S01_DET_PRO_V01
	@dcIdProd	Decimal (7)
AS

if @dcIdProd = -1
 SELECT id_prod,
        id_typ_code_dp,
        id_code_dp,
        id_typ_calc,
        id_code_num,
        id_code_car,
        val_num,
        val_car,
        val_car2, --  #1   JFF   02/09/2009 [DCMP090327].[SBETV]
        unt,
        tri,
        cree_le,
        maj_le,
        maj_par
 FROM   sysadm.det_pro
else
 SELECT id_prod,
        id_typ_code_dp,
        id_code_dp,
        id_typ_calc,
        id_code_num,
        id_code_car,
        val_num,
        val_car,
        val_car2, --  #1   JFF   02/09/2009 [DCMP090327].[SBETV]        
        unt,
        tri,
        cree_le,
        maj_le,
        maj_par
 FROM   sysadm.det_pro
 WHERE 	id_prod = @dcIdProd

GO


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_DET_PRO
-- Auteur               :       Fabry JF
-- Date                 :       10/11/2005
-- Libell‚              :       
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-- #1   JFF   02/09/2009 [DCMP090327].[SBETV]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_DET_PRO' AND type = 'P' )
        DROP procedure sysadm.PS_DET_PRO
GO

CREATE procedure sysadm.PS_DET_PRO
	@dcIdProd	Decimal (7)
AS

Select 	dp.id_prod,
	dp.id_typ_code_dp,
	cDP.lib_code,
	dp.id_code_dp,
	dp.id_typ_calc,
	dp.id_code_num,
	dp.id_code_car,
	dp.val_num,
	dp.val_car,
        dp.val_car2, --  #1   JFF   02/09/2009 [DCMP090327].[SBETV]	
	dp.unt,
	dp.tri,
	dp.cree_le,
	dp.maj_le,
	dp.maj_par
From 	sysadm.det_pro dp,
	sysadm.code cDP
where 	cDP.id_typ_code = '-DP'
And 	cDP.id_code = dp.id_code_dp
And 	dp.id_prod = @dcIdProd
Order   by dp.id_code_dp

Go


--------------------------------------------------------------------
--
-- Proc‚dure            : PS_LIRE_UO_V01
-- Auteur               : FS
-- Date                 : 01/08/2008
-- Libell‚              : Lecture de l'unité opérationnelle associée au produit      
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- #1	FPI	18/12/2008 - Amélioration pour PS_HISTO_VALIDATION_CONF
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_LIRE_UO_V01' AND type = 'P' )
        DROP procedure sysadm.PS_LIRE_UO_V01
GO

CREATE procedure sysadm.PS_LIRE_UO_V01
 @iIdProd Integer -- Code du produit
AS
    Set nocount on -- #1
   Declare @iUo Integer
   
	/* Vdoc 5090 : Vérification de la présence de -DP,199 : Matrice alternative */
	
	Select 
		@iUo=convert(integer,id_code_num)
	From 
		sysadm.det_pro 
	Where
		id_typ_code_dp = '-DP' and id_code_dp = 199 and id_prod = @iIdProd

	If @iUo is null
	 Begin -- Début -DP 199 absent
	 
		Select @iUo=convert(integer,id_code_num)
		From 
			sysadm.det_pro 
		Where
			id_typ_code_dp = '-DP' and id_code_dp = 99 and id_prod = @iIdProd
	
	  End   -- Fin   -DP 199 absent
		

   	-- #1
	select @iUo as id_uo
	return @iUo
GO

grant execute on sysadm.PS_LIRE_UO_V01 to rolebddsinistres

Go


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_VERIF_DET_PRO' AND type = 'P' )
        DROP procedure sysadm.PS_S01_VERIF_DET_PRO
GO

CREATE procedure sysadm.PS_S01_VERIF_DET_PRO
 @aiCodeDP	integer,
 @aiIdScript	integer,
 @aiIdProd	integer,
 @aiPresent	integer OUTPUT
 AS

 Declare @iIdAppli Integer

 Set @aiPresent = -1

 If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
  Begin 
    Select @iIdAppli = sc.id_appli 
    From   SHERPA_PRO.sysadm.script sc 
    Where  sc.id_script = @aiIdScript
  End 
 Else
  Begin 
    Select @iIdAppli = sc.id_appli 
    From   SHERPA_SIM.sysadm.script sc 
    Where  sc.id_script = @aiIdScript
  End 
 
 -- SAVANE
 If @iIdAppli = 1 
  Begin
	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	Begin 
		Select @aiPresent = IsNull ( count (*), -1 ) 
		From   SAVANE_PRO.sysadm.det_pro dp 
		Where  dp.id_prod = Convert ( VarChar ( 10 ), @aiIdProd )
		And    dp.id_code_dp = @aiCodeDP
	End 
	Else
	Begin 
		Select @aiPresent = IsNull ( count (*), -1 ) 
		From   SAVANE_SIM.sysadm.det_pro dp 
		Where  dp.id_prod = Convert ( VarChar ( 10 ), @aiIdProd )
		And    dp.id_code_dp = @aiCodeDP
		
	End 
  End 
 
 -- SIMPA2
 If @iIdAppli = 2 
  Begin
	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	Begin 
		Select @aiPresent = IsNull ( count (*), -1 ) 
		From   SIMPA2_PRO.sysadm.det_pro dp 
		Where  dp.id_prod = Convert ( Decimal ( 7), @aiIdProd )
		And    dp.id_code_dp = @aiCodeDP
	End 
	Else
	Begin 
		Select @aiPresent = IsNull ( count (*), -1 ) 
		From   SIMPA2_TRT.sysadm.det_pro dp 
		Where  dp.id_prod = Convert ( Decimal ( 7), @aiIdProd )
		And    dp.id_code_dp = @aiCodeDP
	End 
  End 

  -- #1 SHERPA => Toute appli n'étant pas Savane ou Simpa est considérée comme sherpa 
 If @iIdAppli not in ( 1, 2 )
  Begin
	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	Begin 
		Select @aiPresent = IsNull ( count (*), -1 ) 
		From   SHERPA_PRO.sysadm.det_pro dp 
		Where  dp.id_prod = @aiIdProd -- IdProd sur Sherpa est un integer => paa ce conversion
		And    dp.id_code = @aiCodeDP
		And    id_typ_code   = '-DP'
	End 
	Else
	Begin 
		Select @aiPresent = IsNull ( count (*), -1 ) 
		From   SHERPA_SIM.sysadm.det_pro dp 
		Where  dp.id_prod = @aiIdProd -- IdProd sur Sherpa est un integer => paa ce conversion
		And    dp.id_code = @aiCodeDP
		And    id_typ_code   = '-DP'
	End 
  End
 
 If @aiPresent > 0 Set @aiPresent = 1
 Return @@Error

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_DET_PRO
-- Auteur               :       FPI
-- Date                 :       02/03/2011
-- Libellé              :       Sélection des matériels d'un Produit pour param_ftu_brk
-- Commentaires         :
-- Références           :       [PM02]
--
-- Arguments            :       @dcIdProd       Decimal (  7,0 )        (Val)
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_DET_PRO' AND type = 'P' )
        DROP procedure sysadm.DW_S02_DET_PRO
GO

CREATE procedure sysadm.DW_S02_DET_PRO
	@dcIdProd	Decimal (7)
AS

 SELECT d.id_prod,
        d.id_code_car,
	c.lib_code
 FROM   sysadm.det_pro d
 inner join code_car c on d.id_code_car=c.id_code
 where d.id_prod=@dcIdProd
 and d.id_code_dp=25
 and c.id_typ_code='-AR'
 Union
 Select @dcIdProd,'-1','Pour tout appareil'
GO

-------------------------------------------------------------------
--
-- Procédure            :       PS_S01_DET_PRO
-- Auteur               :       FPI
-- Date                 :       10/07/2013
-- Libellé              :       Test présence option
-- Commentaires         :
-- Références           :       [PC509-2]
--
-- Arguments            :       @dcIdProd       Decimal (  7,0 )        (Val)
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_DET_PRO' AND type = 'P' )
        DROP procedure sysadm.PS_S01_DET_PRO
GO

CREATE procedure sysadm.PS_S01_DET_PRO
	@dcIdProd	Decimal (7),
	@iIdCodeDP int
AS

 Declare @iRet int

 Set @iRet=0

 SELECT @iRet=count(*)
 FROM   sysadm.det_pro d
 where d.id_prod=@dcIdProd
 and d.id_code_dp=@iIdCodeDP
 
 Return @iRet
GO

-------------------------------------------------------------------
--
-- Procédure            :       PS_S_MONTANT_CAUTION_PRODUIT
-- Auteur               :       JFF
-- Date                 :       31/07/2014
-- Libellé              :       [PM234-4_V1]
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       'ENTREE_GAM', 'IPHONE', 'SMARTPHONE'
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MONTANT_CAUTION_PRODUIT' AND type = 'P' )
        DROP procedure sysadm.PS_S_MONTANT_CAUTION_PRODUIT
GO

CREATE procedure sysadm.PS_S_MONTANT_CAUTION_PRODUIT
	@dcIdProd	Decimal (7),
	@sTypApp    VarChar ( 50 ),
	@sMtCaution VarChar ( 100 ) OUTPUT
AS

Declare @iEligible Integer

Set @iEligible = 0
Set @sTypApp = UPPER ( @sTypApp )

Select  @sMtCaution = sysadm.FN_CLE_VAL ( 'MT_CAUTION', rtrim ( val_car ), ';'),
		@iEligible = 1
From	sysadm.det_pro dp
Where   dp.id_prod = @dcIdProd
And		dp.id_code_dp = 259
And		sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim ( val_car ), ';') = @sTypApp 

If @iEligible = 0 And @sTypApp = 'ENTREE_GAM'
  Begin
	Set @sMtCaution = '0'
	Return
  End 

If @iEligible = 0  
  Begin
	Set @sMtCaution = 'ERREUR_PRODUIT_NON_ELIGIBLE_A_LA_CAUTION'
	Return
  End
	
If rtrim ( @sMtCaution ) = '' 
  Begin
	Set @sMtCaution = '0'
	Return
  End

GO
grant execute on sysadm.PS_S_MONTANT_CAUTION_PRODUIT to rolebddsinistres
Go

-------------------------------------------------------------------
--
-- Procédure            :       PS_S_MONTANT_CAUTION_SINISTRE
-- Auteur               :       JFF
-- Date                 :       31/07/2014
-- Libellé              :       [PM234-4_V1]
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       'ENTREE_GAM', 'IPHONE', 'SMARTPHONE', 'IPHONE5'
--
-- Retourne             :
-- JFF      25/03/2015   [VDOC17204]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MONTANT_CAUTION_SINISTRE' AND type = 'P' )
        DROP procedure sysadm.PS_S_MONTANT_CAUTION_SINISTRE
GO


CREATE procedure sysadm.PS_S_MONTANT_CAUTION_SINISTRE
	@dcIdSin	Decimal ( 10 ), -- [PI062]
	@sMtCaution VarChar ( 100 ) OUTPUT,
	@sAdrMail   VarChar ( 128 ) OUTPUT
AS

Declare @iEligible Integer
Declare @sTypApp    VarChar ( 50 )
Declare @dcIdProd	Decimal (7)
Set @iEligible = 0

Select	@sTypApp = wds.val_car,
		@dcIdProd = ws.id_prod,
		@sAdrMail = ( Select i.adr_mail 
				   from   sysadm.w_inter i
				   Where  i.id_sin = ws.id_sin
				   And    i.cod_inter = 'A' )
		
From	sysadm.w_div_sin wds,
		sysadm.w_sin ws
Where   wds.id_sin = @dcIdSin
and		wds.nom_zone = 'typ_app_pret_atlas'
And     ws.id_sin = wds.id_sin

If @sTypApp is null Set @sTypApp = ''
If @sAdrMail is null Set @sAdrMail = ''

If LTRIM ( rTrim ( @sTypApp ) ) = ''
 Begin
	Select	@sTypApp = ds.val_car,
			@dcIdProd = s.id_prod,
			@sAdrMail = ( Select i.adr_mail 
					   from   sysadm.inter i
					   Where  i.id_sin = s.id_sin
					   And    i.cod_inter = 'A' )
	From	sysadm.div_sin ds,
			sysadm.sinistre s
	Where   ds.id_sin = @dcIdSin
	and		ds.nom_zone = 'typ_app_pret_atlas'	
	And     s.id_sin = ds.id_sin

	If @sTypApp is null Set @sTypApp = ''
	If LTRIM ( rTrim ( @sTypApp ) ) = ''
	 Begin
		Set @sMtCaution = 'MANQUE_TYPE_PRET_SUR_DOSSIER'
		Return
	 End
 End 

Set @sTypApp = UPPER ( @sTypApp )
If @sTypApp = 'ENG' Set @sTypApp = 'ENTREE_GAM'
If @sTypApp = 'SPH' Set @sTypApp = 'SMARTPHONE'
If @sTypApp = 'IPH' Set @sTypApp = 'IPHONE'
If @sTypApp = 'IP5' Set @sTypApp = 'IPHONE5' -- [VDOC17204]


Select  @sMtCaution = sysadm.FN_CLE_VAL ( 'MT_CAUTION', rtrim ( val_car ), ';'),
		@iEligible = 1
From	sysadm.det_pro dp
Where   dp.id_prod = @dcIdProd
And		dp.id_code_dp = 259
And		sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim ( val_car ), ';') = @sTypApp 

If @iEligible = 0 And @sTypApp = 'ENTREE_GAM'
  Begin
	Set @sMtCaution = '0'
	Return
  End 

If @iEligible = 0  
  Begin
	Set @sMtCaution = 'ERREUR_PRODUIT_NON_ELIGIBLE_A_LA_CAUTION'
	Return
  End
	
If rtrim ( @sMtCaution ) = '' 
  Begin
	Set @sMtCaution = '0'
	Return
  End

GO
grant execute on sysadm.PS_S_MONTANT_CAUTION_SINISTRE to rolebddsinistres
Go

-------------------------------------------------------------------
--
-- Procédure            :       PS_S_MONTANT_CAUTION_V01
-- Auteur               :       JFF
-- Date                 :       31/07/2014
-- Libellé              :       [PM234-4_V1]
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       'ENTREE_GAM', 'IPHONE', 'SMARTPHONE', 'IPHONE5'
--
-- Retourne             :
-- JFF      25/03/2015   [VDOC17204]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MONTANT_CAUTION_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S_MONTANT_CAUTION_V01
GO


CREATE procedure sysadm.PS_S_MONTANT_CAUTION_V01
	@dcIdSin	Decimal ( 10 ), -- [PI062]
	@sMtCaution VarChar ( 100 ) OUTPUT,
	@sAdrMail   VarChar ( 128 ) OUTPUT
AS

Declare @iEligible Integer
Declare @sTypApp    VarChar ( 50 )
Declare @dcIdProd	Decimal (7)
Set @iEligible = 0

Select	@sTypApp = wds.val_car,
		@dcIdProd = ws.id_prod,
		@sAdrMail = ( Select i.adr_mail 
				   from   sysadm.w_inter i
				   Where  i.id_sin = ws.id_sin
				   And    i.cod_inter = 'A' )
		
From	sysadm.w_div_sin wds,
		sysadm.w_sin ws
Where   wds.id_sin = @dcIdSin
and		wds.nom_zone = 'typ_app_pret_atlas'
And     ws.id_sin = wds.id_sin

If @sTypApp is null Set @sTypApp = ''
If @sAdrMail is null Set @sAdrMail = ''

If LTRIM ( rTrim ( @sTypApp ) ) = ''
 Begin
	Select	@sTypApp = ds.val_car,
			@dcIdProd = s.id_prod,
			@sAdrMail = ( Select i.adr_mail 
					   from   sysadm.inter i
					   Where  i.id_sin = s.id_sin
					   And    i.cod_inter = 'A' )
	From	sysadm.div_sin ds,
			sysadm.sinistre s
	Where   ds.id_sin = @dcIdSin
	and		ds.nom_zone = 'typ_app_pret_atlas'	
	And     s.id_sin = ds.id_sin

	If @sTypApp is null Set @sTypApp = ''
	If LTRIM ( rTrim ( @sTypApp ) ) = ''
	 Begin
		Set @sMtCaution = 'MANQUE_TYPE_PRET_SUR_DOSSIER'
		Return
	 End
 End 

Set @sTypApp = UPPER ( @sTypApp )
If @sTypApp = 'ENG' Set @sTypApp = 'ENTREE_GAM'
If @sTypApp = 'SPH' Set @sTypApp = 'SMARTPHONE'
If @sTypApp = 'IPH' Set @sTypApp = 'IPHONE'

Select  @sMtCaution = sysadm.FN_CLE_VAL ( 'MT_CAUTION', rtrim ( val_car ), ';'),
		@iEligible = 1
From	sysadm.det_pro dp
Where   dp.id_prod = @dcIdProd
And		dp.id_code_dp = 259
And		sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', rtrim ( val_car ), ';') = @sTypApp 

If @iEligible = 0 And @sTypApp = 'ENTREE_GAM'
  Begin
	Set @sMtCaution = '0'
	Return
  End 

If @iEligible = 0  
  Begin
	Set @sMtCaution = 'ERREUR_PRODUIT_NON_ELIGIBLE_A_LA_CAUTION'
	Return
  End
	
If rtrim ( @sMtCaution ) = '' 
  Begin
	Set @sMtCaution = '0'
	Return
  End

Go



-------------------------------------------------------------------
--
-- Procédure            :       PS_S_VRAI_ORANGE_V3
-- Auteur               :       JFF
-- Date                 :       31/07/2014
-- Libellé              :       [PM234-4_V1]
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       'ENTREE_GAM', 'IPHONE', 'SMARTPHONE'
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_VRAI_ORANGE_V3' AND type = 'P' )
        DROP procedure sysadm.PS_S_VRAI_ORANGE_V3
GO

CREATE procedure sysadm.PS_S_VRAI_ORANGE_V3
	@dcIdProd	Decimal (7),
	@sRetour VarChar ( 100 ) OUTPUT
AS

If Exists ( 
	Select  1
	From	sysadm.det_pro dp
	Where   dp.id_prod = @dcIdProd
	And		dp.id_code_dp = 239
	)
  Begin
	Set @sRetour = 'V3_DP239'
  End
  Else
  Begin
	Set @sRetour = 'NON_DP239'
  End 

GO

-------------------------------------------------------------------
--
-- Procédure            :       PS_S_AUTRE_ORANGE_V3
-- Auteur               :       JFF
-- Date                 :       24/11/2014
-- Libellé              :       [PM234-4_V1]
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       
--
-- Retourne             :
-- JFF      13/07/2015   [PC151270_ORANGE_V3]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_AUTRE_ORANGE_V3' AND type = 'P' )
        DROP procedure sysadm.PS_S_AUTRE_ORANGE_V3
GO

CREATE procedure sysadm.PS_S_AUTRE_ORANGE_V3
	@dcIdProd	Decimal (7),
	@sRetour VarChar ( 100 ) OUTPUT
AS

-- [PC151270_ORANGE_V3]
Select  @sRetour = sysadm.FN_CLE_VAL ( 'COD_DW', rtrim( val_car), ';' ) 
From	sysadm.det_pro dp
Where   dp.id_prod = @dcIdProd
And		dp.id_code_dp = 94
And     sysadm.FN_CLE_VAL ( 'COD_DW', rtrim( val_car), ';' ) in ( 'ORANGE_V3', 'ORANGE_V2', 'ORANGE_V2BIS', 'ORANGE_V3BIS', 'ORANGE_V3TER' )

If @sRetour is null Set @sRetour = 'AUCUN'

GO

-------------------------------------------------------------------
--
-- Procédure            :       det_pro_uk1
-- Auteur               :       JFF
-- Date                 :       11/01/2019
-- Libellé              :       
-- Commentaires         :
-- Références           :       N'EXISTE PLUS !!! je le garde pour mémoire du code
--
-- Arguments            :       
--
-- Retourne             :
-------------------------------------------------------------------
if exists (select 1
            from  sysindexes
           where  id    = object_id('sysadm.det_pro')
            and   name  = 'det_pro_uk1'
            and   indid > 0
            and   indid < 255)
   drop index sysadm.det_pro.det_pro_uk1
go

Set QUOTED_IDENTIFIER On
create unique index det_pro_uk1 on sysadm.det_pro (
id_prod,
id_code_dp
)
WHERE (id_code_dp in ( 
332, 330, 329, 328, 324, 322, 320, 314, 313, 312, 311, 310, 302, 300, 299, 298, 297, 296, 295, 294, 293, 291, 290, 287, 286, 285, 284, 282, 281, 280, 279, 278, 276, 275, 274, 273, 272, 271, 269, 268, 266, 265, 264, 262, 261, 260, 258, 256, 255, 253, 252, 249, 248, 247, 246, 245, 244, 243, 242, 241, 240, 238, 237, 236, 235, 234, 233, 231, 230, 229, 228, 227, 226, 225, 224, 223, 222, 221, 220, 219, 218, 217, 215, 214, 213, 212, 211, 210, 207, 206, 205, 203, 201, 199, 188, 187, 185, 179, 178, 177, 174, 172, 171, 169, 168, 167, 166, 165, 163, 162, 161, 159, 158, 157, 156, 155, 154, 153, 152, 151, 147, 146, 145, 144, 143, 142, 141, 140, 138, 137, 134, 133, 131, 130, 128, 127, 126, 125, 124, 123, 122, 121, 120, 118, 117, 116, 114, 113, 109, 108, 107, 105, 104, 102, 101, 97, 91, 90, 87, 83, 74, 73, 72, 71, 70, 69, 68, 65, 61, 60, 59, 47, 46, 44, 43, 38, 37, 36, 31, 29, 24, 22, 20, 17, 16, 12, 11, 9, 2, 10, 15, 27, 39, 40, 41, 48, 49, 50, 51, 52, 53, 54, 55, 56, 58, 66, 67, 82, 84, 88, 93, 98, 99, 119, 129, 136, 150, 164, 175, 176, 202, 216, 239, 263, 270, 292, 301, 303, 306, 308, 309, 315, 316, 318, 319, 331
))
go



--------------------------------------------------------------------
--
-- Procedure            :       TR_I_DP_UNIQUE
-- Auteur               :       Fabry JF
-- Date                 :       30/01/2019
-- Libelle              :       
-- Commentaires         :       contrôle pour certaines DP, qu'elle ne soit bien présente qu'une seule fois sur le produit
-- References           :       
--
--
-- Retourne             :       Rien
--      JFF    04/02/2014     [DROITS_SANDRINE]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_I_DP_UNIQUE' AND type = 'TR' )
        DROP trigger sysadm.TR_I_DP_UNIQUE
GO

CREATE TRIGGER sysadm.TR_I_DP_UNIQUE
            ON sysadm.det_pro 
    FOR INSERT
AS 

DECLARE @DBID INT
DECLARE @DBNAME NVARCHAR(128)

If Exists ( 
	Select Top 1 1 
	From   inserted i,
		   sysadm.famille f
	Where  f.id_fam = 13
	And    f.id_code = i.id_code_dp  
	And	   (   Select count (*) 
			   From  sysadm.det_pro dp  
			   Where dp.id_prod = i.id_prod
			   And   dp.id_code_dp = i.id_code_dp
			) > 1  -- Parce que le trigger se déclenche après l'insert dans sysadm.det_pro   
	
)
 Begin
	 Delete sysadm.det_pro 
	 From   inserted i,
			sysadm.det_pro dp
	 Where  dp.id_prod = i.id_prod
	 And    dp.id_typ_code_dp = i.id_typ_code_dp
	 And    dp.id_code_dp = i.id_code_dp
	 And	dp.id_typ_calc = i.id_typ_calc
	 And	dp.id_code_num = i.id_code_num
	 And    dp.id_code_car = i.id_code_car
	 And    dp.val_num = i.val_num
	 And	dp.val_car = i.val_car
	 And	dp.val_car2 = i.val_car2
	 And	dp.unt = i.unt

	 SET @DBID = DB_ID()
     SET @DBNAME = DB_NAME()
     RAISERROR ('Une des options existe déjà sur le produit où vous cherchez à l''insérer. Cette option est définie comme unique sur le produit -FA, 13', 16, 1, @DBID, @DBNAME)

 End 

Go

-------------------------------------------------------------------
--
-- Procédure            :       PS_S03_DET_PRO
-- Auteur               :       JFF
-- Date                 :       04/11/2019
-- Libellé              :       
-- Commentaires         :
-- Références           :       [VDOC28559]
--
-- Arguments            :       @dcIdProd       Decimal (  7,0 )        (Val)
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S03_DET_PRO' AND type = 'P' )
        DROP procedure sysadm.PS_S03_DET_PRO
GO

CREATE procedure sysadm.PS_S03_DET_PRO
	@dcIdProd	Decimal (7),
	@iIdCodeDP  int,
	@sIdTypCalc Varchar ( 3 ) Output,
	@iIdCodeNum Integer Output,
	@sIdCodeCar Varchar ( 6 ) Output,
	@iValNum    Integer Output,
	@sValCar    varchar ( 255 ) Output,
	@sValCar2   varchar ( 255 ) Output
AS

 Declare @iRet int

 SELECT Top 1 
		 @dcIdProd = dp.id_prod,
		 @iIdCodeDP = dp.id_code_dp,
		 @sIdTypCalc = IsNull ( dp.id_typ_calc, '' ),
		 @iIdCodeNum = dp.id_code_num,
		 @sIdCodeCar = IsNull ( dp.id_code_car, '' ),
		 @iValNum = dp.val_num,
		 @sValCar = IsNull ( dp.val_car, '' ),
		 @sValCar2 = IsNull ( dp.val_car2, '' )

 FROM   sysadm.det_pro dp,
		sysadm.famille fa -- pour m'assureur que je ne lise que les options uniques
 where dp.id_prod = @dcIdProd
 and   dp.id_code_dp = @iIdCodeDP
 and   fa.id_fam = 13
 and   fa.id_code = dp.id_code_dp 

 Return @@RowCount

GO

-------------------------------------------------------------------
--
-- Procédure            :       PS_S_DET_PRO_DP339_CHEM_EXTERN_EDITION
-- Auteur               :       JFF
-- Date                 :       06/03/2020
-- Libellé              :       
-- Commentaires         :
-- Références           :       [PM425]
--
-- Arguments            :       
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_DET_PRO_DP339_CHEM_EXTERN_EDITION' AND type = 'P' )
        DROP procedure sysadm.PS_S_DET_PRO_DP339_CHEM_EXTERN_EDITION
GO

CREATE procedure sysadm.PS_S_DET_PRO_DP339_CHEM_EXTERN_EDITION
AS

Select distinct sysadm.FN_CLE_VAL (  'CHEMIN', rtrim ( val_car ) + rtrim ( val_car2) , ';' ) 'chemin' from sysadm.det_pro where id_code_dp = 339

Go

