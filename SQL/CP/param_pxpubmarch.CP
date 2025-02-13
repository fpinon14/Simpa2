-------------------------------------------------------------------
--
-- Fichier              :       PARAM_PXPUBMARCH.CP
-- Auteur               :       FPI
-- Date                 :       25/09/2012
--
-- Commentaires         :       Gestion de la table PARAM_PXPUBMARCH
--
-- Procedures           :       DW_S01_PARAM_PXPUBMARCH
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       DW_S01_PARAM_PXPUBMARCH
-- Auteur               :       FPI
-- Date                 :       25/09/2012	
-- Libell‚              :       Renvoie le contenu de la table DW_S01_PARAM_PXPUBMARCH
-- Commentaires         :       [VDOC8841]
-- R‚f‚rences           :       d_trt_param_pxpubmarch
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_PARAM_PXPUBMARCH' AND type = 'P' )
        DROP procedure sysadm.DW_S01_PARAM_PXPUBMARCH
GO

CREATE procedure sysadm.DW_S01_PARAM_PXPUBMARCH
As
	SELECT p.id_seq,
      p.alt_actif,
      p.id_four,
      p.id_marq_fourn,
      p.id_modl_fourn,
      p.id_ref_four,
      a.id_marq_art_ifr,
      a.id_modl_art_ifr,
      p.taux,
      p.alt_exclu_si_pas_mv_px,
      p.cree_le,
      p.maj_le,
      p.maj_par
  FROM sysadm.param_pxpubmarch p
  left outer join sysadm.article a on a.id_four=p.id_four and a.id_ref_four=p.id_ref_four

Go

--------------------------------------------------------------------
--
-- Procedure            :       DW_I01_PARAM_PXPUBMARCH
-- Auteur               :       FPI
-- Date                 :       25/09/2012	
-- Libell‚              :       Insertion dans la table DW_S01_PARAM_PXPUBMARCH
-- Commentaires         :       [VDOC8841]
-- R‚f‚rences           :       d_trt_param_pxpubmarch
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_PARAM_PXPUBMARCH' AND type = 'P' )
        DROP procedure sysadm.DW_I01_PARAM_PXPUBMARCH
GO

CREATE procedure sysadm.DW_I01_PARAM_PXPUBMARCH
	@iIdSeq			int	OUTPUT,
	@sAltActif		varchar(1),
    @sIdFour 		varchar(3),
    @sIdMarqFourn 	varchar(35),
    @sIdModlFourn 	varchar(35),
    @sIdRefFour 	varchar(20),
    @dcTaux 		decimal(11,5),
    @sAltExclu 		varchar(1),
	@sMajPar		varchar(4)
As
	INSERT INTO sysadm.param_pxpubmarch
           (alt_actif,
           id_four,
           id_marq_fourn,
           id_modl_fourn,
           id_ref_four,
           taux,
           mt_prix_gross,
           mt_prix_ifr,
           alt_exclu_si_pas_mv_px,
           cree_le,
           maj_le,
           maj_par)
     VALUES (
		@sAltActif,
		@sIdFour,
		@sIdMarqFourn,
		@sIdModlFourn,
		@sIdRefFour,
		@dcTaux,
		0,
		0,
		@sAltExclu,
		getdate(),
		getdate(),
		@sMajPar)
		
		Select @iIdSeq=@@IDENTITY
		
GO

--------------------------------------------------------------------
--
-- Procedure            :       DW_U01_PARAM_PXPUBMARCH
-- Auteur               :       FPI
-- Date                 :       25/09/2012	
-- Libell‚              :       Mise à jour dans la table DW_S01_PARAM_PXPUBMARCH
-- Commentaires         :       [VDOC8841]
-- R‚f‚rences           :       d_trt_param_pxpubmarch
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_U01_PARAM_PXPUBMARCH' AND type = 'P' )
        DROP procedure sysadm.DW_U01_PARAM_PXPUBMARCH
GO

CREATE procedure sysadm.DW_U01_PARAM_PXPUBMARCH
	@iIdSeq			int,
	@sAltActif		varchar(1),
    @sIdFour 		varchar(3),
    @sIdMarqFourn 	varchar(35),
    @sIdModlFourn 	varchar(35),
    @sIdRefFour 	varchar(20),
    @dcTaux 		decimal(11,5),
    @sAltExclu 		varchar(1),
	@sMajPar		varchar(4)
As
	Update sysadm.param_pxpubmarch
	Set alt_actif = @sAltActif,
        id_four = @sIdFour,
        id_marq_fourn = @sIdMarqFourn,
        id_modl_fourn = @sIdModlFourn,
        id_ref_four = @sIdRefFour,
        taux = @dcTaux,
        alt_exclu_si_pas_mv_px = @sAltExclu,
        maj_le=getdate(),
        maj_par = @sMajPar
  FROM sysadm.param_pxpubmarch p
  Where p.id_seq=@iIdSeq

Go

--------------------------------------------------------------------
--
-- Procedure            :       DW_D01_PARAM_PXPUBMARCH
-- Auteur               :       FPI
-- Date                 :       25/09/2012	
-- Libell‚              :       Suppression dans la table DW_S01_PARAM_PXPUBMARCH
-- Commentaires         :       [VDOC8841]
-- R‚f‚rences           :       d_trt_param_pxpubmarch
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_PARAM_PXPUBMARCH' AND type = 'P' )
        DROP procedure sysadm.DW_D01_PARAM_PXPUBMARCH
GO

CREATE procedure sysadm.DW_D01_PARAM_PXPUBMARCH
	@iIdSeq			int
As
  Delete
  FROM sysadm.param_pxpubmarch 
  Where id_seq=@iIdSeq
Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_ALERTE_PX_PUB_MARCHE
-- Auteur               :       JFF
-- Date                 :       27/09/2012	
-- Libell‚              :       
-- Commentaires         :       [VDOC8841]
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       
-- JFF		19/12/2012		[VDOC9319]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_ALERTE_PX_PUB_MARCHE' AND type = 'P' )
        DROP procedure sysadm.PS_ALERTE_PX_PUB_MARCHE
GO

CREATE procedure sysadm.PS_ALERTE_PX_PUB_MARCHE
AS

Set NoCount On

DECLARE @tbParam TABLE 
	(  id_seq   integer,
	   marquage	integer 
	)

DECLARE @tbAlerte TABLE 
	(  id_seq	integer identity,
	   id_four  VarChar (3),
	   lib_four VarChar ( 35 ),
	   id_ref_four  VarChar (20),
	   id_marq_art_frn VarChar ( 35 ),
	   id_modl_art_frn VarChar ( 35 ),
	   id_marq_art_ifr VarChar ( 35 ),
	   id_modl_art_ifr VarChar ( 35 ),
	   mt_prix_ttc_ifr VarChar ( 20),
	   mt_prix_ttc_frn VarChar ( 20),
	   mt_depassant VarChar ( 20),
	   pct_depassement VarChar ( 20),
	   pct_param_alerte VarChar ( 20),
	   dte_trt VarChar ( 30)
	)


Declare @iIdSeq integer,
		@sIdFour VarChar ( 3 ),
		@sIdRefFour VarChar ( 20 ),
		@sIdMarqFour VarChar ( 35 ),
		@sIdModlFour VarChar ( 35 ),
		@sIdMarqIfr VarChar ( 35 ),
		@sIdMarqModl VarChar ( 35 ),
		@mtPrixTTCPublic Decimal ( 11, 2 ),
		@mtPrixTTCFrn Decimal ( 11, 2 ),
		@mtPrixTTCPublicMem Decimal ( 11, 2 ),
		@mtPrixTTCFrnMem Decimal ( 11, 2 ),
		@sAltExcluSiPasMvt VarChar ( 1 ),
		@dcTaux decimal(11,5) 

-- vDoc9319
Exec sysadm.PS_INSERTION_AUTO_MASSE

Insert into @tbParam
Select id_seq , 0
From   sysadm.param_pxpubmarch
Where  alt_actif = 'O'

While Exists ( Select * From @tbParam where marquage = 0 )
 Begin
	Select 	Top 1 
			@iIdSeq = id_seq
	From	@tbParam
	Where	marquage = 0

	Select  @sIdFour = px.id_four,
			@sIdRefFour = px.id_ref_four,
			@sIdMarqFour = px.id_marq_fourn,
			@sIdModlFour =  px.id_modl_fourn,
			@sIdMarqIfr = i.marque,
			@sIdMarqModl = i.reference,
			@mtPrixTTCPublic = i.frequence,
			@mtPrixTTCFrn = Round ( a.mt_prix_ht * ( 1 + ( a.tva/100 ) ), 2 ),
			@mtPrixTTCPublicMem =px.mt_prix_ifr,
			@mtPrixTTCFrnMem =  px.mt_prix_gross,
			@dcTaux = px.taux

	From	sysadm.article a, 
			sysadm.param_pxpubmarch px,
			sysadm.ifr i
	Where   px.id_seq = @iIdSeq
	And		a.id_four = px.id_four	
	And		a.id_ref_four = px.id_ref_four
	And		a.id_marq_art = px.id_marq_fourn
	And		a.id_modl_art = px.id_modl_fourn
	And     i.marque = a.id_marq_art_ifr
	And     i.reference = a.id_modl_art_ifr
	And     i.id_trait = ( Select MAX ( i2.id_trait ) 
						   From sysadm.ifr i2
						   Where i2.marque = i.marque
						   And   i2.reference = i.reference )

	-- Exclusion si pas de mvt sur les deux prix par rapport au précédent traitement						   
	IF  @sAltExcluSiPasMvt = 'O' 
		And @mtPrixTTCPublic = @mtPrixTTCPublicMem 
		And @mtPrixTTCFrn = @mtPrixTTCFrnMem
		
		Begin 
			Update @tbParam
			Set marquage = 1
			Where id_seq = @iIdSeq

			CONTINUE 
		End 

	-- Alerte
	If @mtPrixTTCFrn > Round ( @mtPrixTTCPublic + ( @mtPrixTTCPublic * @dcTaux ) , 2 ) 
		Begin 
		
			-- Insertion table virtuel alerte

			Insert into @tbAlerte 
			Select	@sIdFour 'id_four',
					sysadm.FN_CODE_CAR ( @sIdFour, '-FR' ) 'lib_four',
					@sIdRefFour 'id_ref_four',
					@sIdMarqFour 'Marque_Fournisseur',
					@sIdModlFour 'Modele_Fournisseur',
					@sIdMarqIfr 'Marque_IFR_associee',
					@sIdMarqModl 'Modele_IFR_associee',
					Convert ( VarChar ( 20 ), @mtPrixTTCPublic  ) + '€' 'Prix_TTC_IFR',
					Convert ( VarChar ( 20 ), @mtPrixTTCFrn  ) + '€' 'Prix_TTC_Fournisseur',
					Convert ( VarChar ( 20 ), @mtPrixTTCFrn - @mtPrixTTCPublic ) + '€' 'Montant_depassement_Frn',
					Convert ( VarChar ( 20 ), Convert ( Decimal (11,2) , Round ( ( ( @mtPrixTTCFrn - @mtPrixTTCPublic ) / @mtPrixTTCPublic ) * 100, 2 ))) + '%' '%_depassement_frn',
					Convert ( VarChar ( 20 ), Convert ( Decimal (11,2) , Round ( @dcTaux * 100, 2 ))) + '%' '%_param_alerte',
					convert ( varchar(10), GETDATE(), 103 ) + ' ' + CONVERT (varchar(8), GETDATE(), 108)  'Date_Traitement'
		End 

	-- Maj table param pour prix mémoire
	Update sysadm.param_pxpubmarch
	Set mt_prix_gross = isnull(@mtPrixTTCFrn,0),
		mt_prix_ifr = isnull(@mtPrixTTCPublic,0)
	Where id_seq = @iIdSeq

	Update @tbParam
	Set marquage = 1
	Where id_seq = @iIdSeq
 End

Select id_four, lib_four, id_ref_four, id_marq_art_frn, id_modl_art_frn, id_marq_art_ifr, id_modl_art_ifr, mt_prix_ttc_ifr, mt_prix_ttc_frn, mt_depassant, pct_depassement, pct_param_alerte, dte_trt From @tbAlerte

Go

grant execute on sysadm.PS_ALERTE_PX_PUB_MARCHE to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Procedure            :       PS_ALERTE_PX_PUB_MARCHE_MAIL
-- Auteur               :       JFF
-- Date                 :       27/09/2012	
-- Libell‚              :       
-- Commentaires         :       [VDOC8841]
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_ALERTE_PX_PUB_MARCHE_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_ALERTE_PX_PUB_MARCHE_MAIL
GO

CREATE procedure sysadm.PS_ALERTE_PX_PUB_MARCHE_MAIL
AS

Declare @sNomServeur VarChar(255)
Declare @sOsqlOption VarChar(255)
Declare @iRetOsql    int	
Declare @sFicOut     VarChar(255)		
Declare @sBase		 VarChar ( 15 )
Declare @sRequete	 VarChar ( 100 )
Declare @sCommande	 VarChar ( 255 )
Declare @sMessage    Varchar(800)
Declare @sObjet      VarChar(255)
Declare @sRetourErrMail VarChar(255)
Declare @sChemin    VarChar ( 255 )
Declare @sFichierExcel VarChar ( 255 )

Set NoCount On

Set @sChemin = master.sysadm.SPB_FN_GET_ROOT() + '\Sinistre\Extraction_vDoc8841_Alerte_pxpubmarche\'
Set @sFichierExcel = 'vDoc8841_Alerte_pxpubmarche.xls'
Set @sNomServeur = @@servername

-- Options additionelles pour osql
-- /s"	" 	=> Separateur Tabulation
-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
-- /u	=> Unicode
Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'

IF @@servername = master.dbo.SPB_FN_ServerName ('PRO') Set @sBase = 'SIMPA2_PRO' Else Set @sBase = 'SIMPA2_TRT'

Set @sFicOut = @sChemin + @sFichierExcel

Set @sRequete = 'PS_ALERTE_PX_PUB_MARCHE'

SET @sCommande = 'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
		 @sBase + '.sysadm.' + @sRequete + ' ' + 
		 '" /o' + @sFicOut + ' -w5000' + @sOsqlOption


EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

Set @sObjet    = '(vDoc8841) : Alerte Prix Fourn > Prix IFR'
set @sMessage  = 'Bonjour,'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
set @sMessage  = @sMessage + 'Vous trouverez ci-joint l''extraction demandée par la vDoc8841, alertant des prix fournisseurs supérieurs aux prix IFR pour le même modèle, et cela en fonction d''un paramètrage.'
set @sMessage  = @sMessage + char ( 10) + char ( 10)
set @sMessage  = @sMessage + 'Bonne réception.'

if @iRetOsql = 0
 BEGIN
	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			'ntonnetot@spb.eu,cmathe@spb.eu,ayvon@spb.eu,cbourdoiseau@spb.eu',
			@sMessage, 
			@sObjet, 
			'', 
			'', 
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL
 END


Go

grant execute on sysadm.PS_ALERTE_PX_PUB_MARCHE_MAIL to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Procedure            :       PS_MAJ_TAUX_MASSE
-- Auteur               :       JFF
-- Date                 :       19/12/2012	
-- Libell‚              :       
-- Commentaires         :       [VDOC8841][VDOC9319]
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_MAJ_TAUX_MASSE' AND type = 'P' )
        DROP procedure sysadm.PS_MAJ_TAUX_MASSE
GO

CREATE procedure sysadm.PS_MAJ_TAUX_MASSE
@asIdFour	VarChar ( 3 ),
@adcOldTaux	decimal(11,5),
@adcNewTaux	decimal(11,5),
@asCodOper  varChar ( 4 )
AS

Update sysadm.param_pxpubmarch
Set taux = @adcNewTaux, maj_le = GETDATE(), maj_par = @asCodOper
Where id_four = @asIdFour
And   taux = @adcOldTaux
 
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_INSERTION_AUTO_MASSE
-- Auteur               :       JFF
-- Date                 :       19/12/2012	
-- Libell‚              :       
-- Commentaires         :       [VDOC8841][VDOC9319]
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_INSERTION_AUTO_MASSE' AND type = 'P' )
        DROP procedure sysadm.PS_INSERTION_AUTO_MASSE
GO

CREATE procedure sysadm.PS_INSERTION_AUTO_MASSE
AS

Insert into param_pxpubmarch
Select  'O',
		a.id_four,
		a.id_marq_art,
		a.id_modl_art,
		a.id_ref_four,
		pm.taux,
		Round ( a.mt_prix_ht * ( 1 + ( a.tva/100 ) ), 2 ),
		i.frequence,
		'N',
		GETDATE(),
		GETDATE(),
		'JFF'
From   sysadm.article a,
	   sysadm.param_pxpubmarch_masse pm,
	   sysadm.ifr i
Where  pm.alt_actif = 'O'
And    pm.id_four = a.id_four
And    a.id_typ_art not in ( 'EDI', 'PRS', 'SMS', 'MAI', 'DEV', 'ACC', 'CAF', 'PCM' )
And    a.id_marq_art_ifr is not null
And    a.id_modl_art_ifr is not null
And    i.marque = a.id_marq_art_ifr
And    i.reference = a.id_modl_art_ifr
And    i.id_trait = ( Select MAX ( i2.id_trait ) 
					   From sysadm.ifr i2
					   Where i2.marque = i.marque
					   And   i2.reference = i.reference )
And    Not Exists ( 
		Select *
		From   sysadm.param_pxpubmarch pm1
		Where  pm1.id_four = a.id_four
		And    pm1.id_ref_four = a.id_ref_four
		And    pm1.id_marq_fourn = a.id_marq_art
		And    pm1.id_modl_fourn = a.id_modl_art		
		)

Go

--------------------------------------------------------------------
--
-- Procédure     :   DW_S01_PARAM_PXPUBMARCH_MASSE
-- Auteur        :   FPI
-- Date          :   19/12/2012
-- Libellé       :   Sélection dans param_pxpubmarch_masse
-- Commentaires  :	[VDoc9319]
-- Références    :   
--
-- Arguments     :  
--
-- Retourne      :  
--				  
--------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_PARAM_PXPUBMARCH_MASSE' AND type = 'P' )
            DROP procedure sysadm.DW_S01_PARAM_PXPUBMARCH_MASSE
GO

CREATE PROCEDURE DW_S01_PARAM_PXPUBMARCH_MASSE 
AS
	Select id_seq, alt_actif, id_four, taux, cree_le, maj_le, maj_par
	From sysadm.param_pxpubmarch_masse
Go

--------------------------------------------------------------------
--
-- Procedure            :       DW_I01_PARAM_PXPUBMARCH_MASSE 
-- Auteur               :       FPI
-- Date                 :       19/12/2012	
-- Libell‚              :       Insertion dans la table PARAM_PXPUBMARCH_MASSE 
-- Commentaires         :       [VDOC9319]
-- R‚f‚rences           :       d_trt_param_pxpubmarch
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_PARAM_PXPUBMARCH_MASSE' AND type = 'P' )
        DROP procedure sysadm.DW_I01_PARAM_PXPUBMARCH_MASSE
GO

CREATE procedure sysadm.DW_I01_PARAM_PXPUBMARCH_MASSE
	@iIdSeq			int	OUTPUT,
	@sAltActif		varchar(1),
    @sIdFour 		varchar(3),
    @dcTaux 		decimal(11,5),
    @sMajPar		varchar(4)
As
	INSERT INTO sysadm.param_pxpubmarch_masse
           ( alt_actif, id_four, taux, cree_le, maj_le, maj_par)
     VALUES (
		@sAltActif,
		@sIdFour,
		@dcTaux,
		getdate(),
		getdate(),
		@sMajPar)
		
		Select @iIdSeq=@@IDENTITY
		
GO

--------------------------------------------------------------------
--
-- Procedure            :       DW_U01_PARAM_PXPUBMARCH_MASSE
-- Auteur               :       FPI
-- Date                 :       19/12/2012	
-- Libell‚              :       Mise à jour dans la table PARAM_PXPUBMARCH_MASSE 
-- Commentaires         :       [VDOC9319]
-- R‚f‚rences           :       d_trt_param_pxpubmarch
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_U01_PARAM_PXPUBMARCH_MASSE' AND type = 'P' )
        DROP procedure sysadm.DW_U01_PARAM_PXPUBMARCH_MASSE
GO

CREATE procedure sysadm.DW_U01_PARAM_PXPUBMARCH_MASSE
	@iIdSeq			int,
	@sAltActif		varchar(1),
    @sIdFour 		varchar(3),
    @dcTaux 		decimal(11,5),
    @sMajPar		varchar(4)
As
	Update sysadm.param_pxpubmarch_masse
	Set alt_actif = @sAltActif,
        id_four = @sIdFour,
        taux = @dcTaux,
        maj_le=getdate(),
        maj_par = @sMajPar
  FROM sysadm.param_pxpubmarch_masse p
  Where p.id_seq=@iIdSeq

Go

--------------------------------------------------------------------
--
-- Procedure            :       DW_D01_PARAM_PXPUBMARCH_MASSE
-- Auteur               :       FPI
-- Date                 :       19/12/2012	
-- Libell‚              :       Suppression dans la table PARAM_PXPUBMARCH_MASSE 
-- Commentaires         :       [VDOC9319]
-- R‚f‚rences           :       d_trt_param_pxpubmarch
--
-- Arguments            :       
--
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_PARAM_PXPUBMARCH_MASSE' AND type = 'P' )
        DROP procedure sysadm.DW_D01_PARAM_PXPUBMARCH_MASSE
GO

CREATE procedure sysadm.DW_D01_PARAM_PXPUBMARCH_MASSE
	@iIdSeq			int
As
  Delete
  FROM sysadm.param_pxpubmarch_masse
  Where id_seq=@iIdSeq
Go
