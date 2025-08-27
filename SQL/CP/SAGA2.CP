-------------------------------------------------------------------
--
-- Fichier              :       SAGA2.CP
-- Auteur               :       FABRY JF
-- Date                 :       23/05/2012
--
-- Commentaires         :       PS affèrant à SAGA2
--
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_SAGA2_REF_IFR
-- Auteur               :       FABRY JF
-- Date                 :       23/05/2012
-- Libellé              :        
-- Commentaires         :       
-- Références           :       
--
-- sysadm.PS_S_SAGA2_MARQUE_IFR
-- sysadm.PS_S_SAGA2_MODELE_IFR
-- sysadm.PS_S_EXTRANET_STATUT_DOSSIER_SIMPA2
-- sysadm.PS_S_SAGA2_INTERRO_ARTICLE_REF_EXTERNE
-- sysadm.PS_S_SAGA2_INTERRO_AUTRE_REF
-- sysadm.PS_S_SAGA2_INTERRO_ID_REF_FOUR_BOUYGUES
-- sysadm.PS_S_SAGA2_INTERRO_IFR
-- sysadm.PS_S_SAGA2_INTERRO_IFR_V100
-- sysadm.PS_S_SAGA2_REF_IFR
-- sysadm.PS_S_SAGA2_STOCK_FOURN
-- sysadm.PS_SI_SAGA2_BYG_CREATION_ADHESION_SINISTRE
-- sysadm.PS_SI_SAGA2_BYG_RECUPERER_GENCODE_DEPUIS_VALEUR_IFR
-- sysadm.PS_SI_SAGA2_LIEN_REF_EXTERNE_AVEC_IFR_V02
-- sysadm.PS_SI_SAGA2_RECUP_REF_SPBIFR_EN_LIEN_AVEC_REF_EXTERNE
-- sysadm.PS_SI_SAGA2_RECUPERER_GENCODE_DEPUIS_VALEUR_IFR
-- sysadm.PS_U_SAGA2_STOCK_FOURN
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_SAGA2_REF_IFR' AND type = 'P' )
        DROP procedure sysadm.PS_S_SAGA2_REF_IFR
GO

CREATE procedure sysadm.PS_S_SAGA2_REF_IFR
AS

SET NOCOUNT ON

Select	Distinct
		i.marque 'Marque',
		i.reference 'Modele',
		i.frequence 'Prix_Public'
from	sysadm.ifr i
Where   i.id_trait = ( Select MAX (id_trait)
					   From   sysadm.ifr i2
					   Where  i2.marque = i.marque
					   And    i2.reference = i.reference )
And	i.alt_dispo = 'O'					   
Order by i.marque, i.reference

Go

grant execute on sysadm.PS_S_SAGA2_REF_IFR to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_SAGA2_INTERRO_IFR_V100
-- Auteur               :       FABRY JF
-- Date                 :       04/01/2016
-- Libellé              :        
-- Commentaires         :       Sur Demande Thomas suite problème Technique.
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_SAGA2_INTERRO_IFR_V100' AND type = 'P' )
        DROP procedure sysadm.PS_S_SAGA2_INTERRO_IFR_V100
GO

CREATE procedure sysadm.PS_S_SAGA2_INTERRO_IFR_V100
	@sMarque	VarChar ( 35 ),
	@sModele	VarChar ( 35 ),
	@dcPrixPublic Decimal ( 11, 2 ) OutPut
AS

SET NOCOUNT ON

Set @sMarque = UPPER  ( lTrim ( rtrim (  @sMarque ) ))
Set @sModele = UPPER  ( lTrim ( rtrim (  @sModele ) ))

Select	@dcPrixPublic = i.frequence 
from	sysadm.ifr i
Where   i.marque = @sMarque
And		i.reference = @sModele
And		i.id_trait = ( Select MAX (id_trait)
					   From   sysadm.ifr i2
					   Where  i2.marque = i.marque
					   And    i2.reference = i.reference )
And	i.alt_dispo = 'O'					   					   

SELECT @dcPrixPublic AS dcPrixPublic  -- La modif

Go

grant execute on sysadm.PS_S_SAGA2_INTERRO_IFR_V100 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_SAGA2_INTERRO_IFR
-- Auteur               :       FABRY JF
-- Date                 :       23/05/2012
-- Libellé              :        
-- Commentaires         :       
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_SAGA2_INTERRO_IFR' AND type = 'P' )
        DROP procedure sysadm.PS_S_SAGA2_INTERRO_IFR
GO

CREATE procedure sysadm.PS_S_SAGA2_INTERRO_IFR
	@sMarque	VarChar ( 35 ),
	@sModele	VarChar ( 35 ),
	@dcPrixPublic Decimal ( 11, 2 ) OutPut
AS

SET NOCOUNT ON

Set @sMarque = UPPER  ( lTrim ( rtrim (  @sMarque ) ))
Set @sModele = UPPER  ( lTrim ( rtrim (  @sModele ) ))

Select	@dcPrixPublic = i.frequence 
from	sysadm.ifr i
Where   i.marque = @sMarque
And		i.reference = @sModele
And		i.id_trait = ( Select MAX (id_trait)
					   From   sysadm.ifr i2
					   Where  i2.marque = i.marque
					   And    i2.reference = i.reference )
And	i.alt_dispo = 'O'					   					   

Go

grant execute on sysadm.PS_S_SAGA2_INTERRO_IFR to rolebddsinistres
Go

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_SAGA2_MARQUE_IFR' AND type = 'P' )
        DROP procedure sysadm.PS_S_SAGA2_MARQUE_IFR
GO

CREATE procedure [sysadm].[PS_S_SAGA2_MARQUE_IFR]
AS

SET NOCOUNT ON

Select	Distinct
		i.marque 'Marque'
from	sysadm.ifr i
Where   i.id_trait = ( Select MAX (id_trait)
					   From   sysadm.ifr i2
					   Where  i2.marque = i.marque
					   And    i2.reference = i.reference )
And	i.alt_dispo = 'O'					   
Order by i.marque

Go



grant execute on sysadm.PS_S_SAGA2_MARQUE_IFR to rolebddsinistres
Go

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_SAGA2_MODELE_IFR' AND type = 'P' )
        DROP procedure sysadm.PS_S_SAGA2_MODELE_IFR
GO


CREATE procedure [sysadm].[PS_S_SAGA2_MODELE_IFR]
@sMarque varchar(35)

AS

SET NOCOUNT ON

Select	Distinct		
		i.reference 'Modele'
from	sysadm.ifr i
Where   i.id_trait = ( Select MAX (id_trait)
					   From   sysadm.ifr i2
					   Where  i2.marque = i.marque
					   And    i2.reference = i.reference )
And	i.alt_dispo = 'O'					   
And i.marque = @sMarque
Order by i.reference

Go





grant execute on sysadm.PS_S_SAGA2_MODELE_IFR to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_SAGA2_INTERRO_AUTRE_REF
-- Auteur               :       FABRY JF
-- Date                 :       05/10/2015
-- Libellé              :        
-- Commentaires         :       [PM319-2]
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_SAGA2_INTERRO_AUTRE_REF' AND type = 'P' )
        DROP procedure sysadm.PS_S_SAGA2_INTERRO_AUTRE_REF
GO

CREATE procedure sysadm.PS_S_SAGA2_INTERRO_AUTRE_REF
	@sMarqueIFR	VarChar ( 35 ),
	@sModeleIFR	VarChar ( 35 ),
	@sIdFourRef	VarChar ( 10),
	@dcPrixPublic Decimal ( 11, 2 ) OutPut
AS

	SET NOCOUNT ON

	Set @sMarqueIFR = LTRIM ( RTRIM ( UPPER  ( @sMarqueIFR )))
	Set @sModeleIFR = LTRIM ( RTRIM ( UPPER  ( @sModeleIFR )))
	Set @sIdFourRef = LTRIM ( RTRIM ( UPPER  ( @sIdFourRef )))
	    
	Select 	@dcPrixPublic = Min ( Round ( mt_prix_ht * ( 1 + tva/100 ), 2 ) )
	From   	sysadm.article a
	Where   a.id_four = @sIdFourRef
	and		a.id_marq_art_ifr = @sMarqueIFR
	and 	a.id_modl_art_ifr = @sModeleIFR
	and 	a.alt_dispo = 'O'

	If @dcPrixPublic is null Set @dcPrixPublic = 0

	SELECT @dcPrixPublic AS dcPrixPublic 
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_SAGA2_INTERRO_ID_REF_FOUR_BOUYGUES
-- Auteur               :       FABRY JF
-- Date                 :       07/06/2017
-- Libellé              :        
-- Commentaires         :       Réalisé sur demande de Franck
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_SAGA2_INTERRO_ID_REF_FOUR_BOUYGUES' AND type = 'P' )
        DROP procedure sysadm.PS_S_SAGA2_INTERRO_ID_REF_FOUR_BOUYGUES
GO

CREATE procedure sysadm.PS_S_SAGA2_INTERRO_ID_REF_FOUR_BOUYGUES
	@sIdRefFour	VarChar ( 20 )
AS

	SET NOCOUNT ON

	Set @sIdRefFour	= lTrim ( rTrim ( @sIdRefFour	)) 

	Select 	a.id_marq_art_ifr,
			a.id_modl_art_ifr,
			Round ( Convert ( money, mt_prix_ht * ( 1 + tva/100 )), 2 ) 'mt_prix_ttc'
	From   	sysadm.article a
	Where   a.id_four = 'RTB'
	And		Left ( a.id_ref_four, 13 ) = @sIdRefFour
	And 	a.alt_dispo = 'O'

Go

grant execute on sysadm.PS_S_SAGA2_INTERRO_ID_REF_FOUR_BOUYGUES to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_EXTRANET_STATUT_DOSSIER_SIMPA2
-- Auteur               :       FABRY JF
-- Date                 :       23/05/2012
-- Libellé              :        
-- Commentaires         :       
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_EXTRANET_STATUT_DOSSIER_SIMPA2' AND type = 'P' )
        DROP procedure sysadm.PS_S_EXTRANET_STATUT_DOSSIER_SIMPA2
GO

CREATE procedure sysadm.PS_S_EXTRANET_STATUT_DOSSIER_SIMPA2
	@adcIdSin		Decimal ( 10 ),
	@aiIdCodeStatut	Integer OUTPUT,
	@asLibCodeStatut VarChar ( 35 ) OUTPUT
AS

SET NOCOUNT ON

Select	Top 1
		@aiIdCodeStatut = ds.val_nbre,
		@asLibCodeStatut = sysadm.FN_CODE_NUM ( ds.val_nbre, '-ET')
from	sysadm.div_sin ds
Where   ds.id_sin = @adcIdSin
And		ds.nom_zone = 'etat_vu_assure'

If @aiIdCodeStatut is null Set @aiIdCodeStatut = 0
If @asLibCodeStatut is null Set @asLibCodeStatut = ''

Go

grant execute on sysadm.PS_S_EXTRANET_STATUT_DOSSIER_SIMPA2 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_SAGA2_STOCK_FOURN
-- Auteur               :       FABRY JF
-- Date                 :       12/07/2019
-- Libellé              :       [PM462-2]
-- Commentaires         :       
-- Références           :       
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_SAGA2_STOCK_FOURN' AND type = 'P' )
        DROP procedure sysadm.PS_S_SAGA2_STOCK_FOURN
GO

CREATE procedure sysadm.PS_S_SAGA2_STOCK_FOURN
	@asIdFour VarChar ( 3 ),
	@asIdTypArt VarChar ( 3 ),
	@asLibRetour VarChar ( 255 ) OUTPUT
AS

SET NOCOUNT ON

Set @asIdFour = rTrim ( lTrim ( Upper ( @asIdFour ) ) ) 
If @asIdFour is null Set @asIdFour = ''
Set @asIdTypArt = Upper ( @asIdTypArt )

If Not Exists ( 
	Select Top 1 1 
	From    sysadm.code_car c
	Where   c.id_typ_code = '-FR'
	And     c.id_code = @asIdFour
	)
	Begin
		Set @asLibRetour = 'ERREUR : Fournisseur inexistant'
		Return -1
	End 

If Not Exists ( 
	Select Top 1 1 
	From    sysadm.code_car c
	Where   c.id_typ_code = '-AR'
	And     c.id_code = @asIdTypArt
	)
	Begin
		Set @asLibRetour = 'ERREUR : Type article inexistant'
		Return -2
	End 

If @asIdTypArt not in ( 'TEL' ) 
  Begin
	Set @asLibRetour = 'ERREUR : Type article interdit'
	Return -3
  End 

Select  id_four,
		id_ref_four,
		id_typ_art,
		id_marq_art	'id_marq_art_fourn',
		id_modl_art	'id_modl_art_fourn',
		Convert ( money, mt_prix_ht * ( 1 + ( tva / 100 ) )) 'mt_prix_ttc',
		qt_disp,
		id_marq_art_ifr,
		id_modl_art_ifr
From	sysadm.article a
Where   a.id_four = @asIdFour
And     a.id_typ_art = @asIdTypArt
And     a.alt_dispo = 'O'
And     a.id_marq_art_ifr is not null
And     a.id_modl_art_ifr is not null
And     a.qt_disp > 0 
And     rtrim ( a.id_four ) + rtrim ( a.id_marq_art ) <> 'O2MAPPLE' -- [PM166_URGENCE] 01/06/2011


Set @asLibRetour = 'Retour Valide'

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_U_SAGA2_STOCK_FOURN
-- Auteur               :       FABRY JF
-- Date                 :       12/07/2019
-- Libellé              :       [PM462-2]
-- Commentaires         :       
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_SAGA2_STOCK_FOURN' AND type = 'P' )
        DROP procedure sysadm.PS_U_SAGA2_STOCK_FOURN
GO

CREATE procedure sysadm.PS_U_SAGA2_STOCK_FOURN
	@aiIdSinSaga2 Int,
	@aiIdSeqSaga2 Int,
	@asIdFour VarChar ( 3 ),
	@asIdRefFour VarChar ( 20 ),
	@asLibRetour VarChar ( 255 ) OUTPUT
AS

SET NOCOUNT ON

Set @asIdFour = ltrim ( rtrim ( Upper ( @asIdFour )))
Set @asIdRefFour = ltrim ( rtrim ( @asIdRefFour ))

-- Lecture stock avant maj
If ( Select qt_disp
	 From   sysadm.article a
	 Where  a.id_four = @asIdFour
	 And    a.id_ref_four = @asIdRefFour
   ) <= 0 
   Begin
	 Set @asLibRetour = 'ERR : Quantité stock insuffisante, ne pas valider la commande !'
	 Return -1
   End 

-- Si Ok, maj
Update sysadm.article
Set    qt_disp = qt_disp - 1 
Where  id_four = @asIdFour
And    id_ref_four = @asIdRefFour

If @@ROWCOUNT <> 1 
  Begin
	 Set @asLibRetour = 'ERR : Problème de maj sur la clé id_four/id_ref_four, ne pas valider la commande !'
	 Return -2
  End 

-- Trace cmde SAGA²
Insert into sysadm.trace_cmde_saga2_site_choix_mobile
Select  @aiIdSinSaga2,
		@aiIdSeqSaga2,
		id_four,
		id_ref_four,
		id_typ_art,
		id_marq_art,
		id_modl_art,	
		Convert ( money, mt_prix_ht * ( 1 + ( tva / 100 ) )) 'mt_prix_ttc',
		qt_disp,
		id_marq_art_ifr,
		id_modl_art_ifr,
		GetDate(),
		Getdate(),
		'SAGA'

From sysadm.article a
Where  id_four = @asIdFour
And    id_ref_four = @asIdRefFour

Set @asLibRetour = 'Retour Valide'

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_SI_SAGA2_BYG_CREATION_ADHESION_SINISTRE
-- Auteur               :       FABRY JF
-- Date                 :       14/06/2021
-- Libellé              :       [BTRUN_344_REF_BYGUES]
-- Commentaires         :       
-- Références           :       
--
-- JFF 25/09/2023 [REF_EXT_SAGA2] Gérer l'appel en mode SINISTRE d'un marque modèle à injecter dans le Ref Externe
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SI_SAGA2_BYG_CREATION_ADHESION_SINISTRE' AND type = 'P' )
        DROP procedure sysadm.PS_SI_SAGA2_BYG_CREATION_ADHESION_SINISTRE
GO

CREATE procedure sysadm.PS_SI_SAGA2_BYG_CREATION_ADHESION_SINISTRE
	@asCasInterro					VarChar ( 10 ),    -- (Obligatoire) Cas d'interrogation : ADHESION (Création d'adhésion) / SINISTRE (Création de sinistre)
	@asMarqueBouyguesOuIfr			VarChar ( 500 ),   -- (Obligatoire) Marque Bouygues Ou IFR à rechercher , 35 Car Max => si plus, accepté mais sera rejeté
	@asModeleDescripBouyguesOuIfr	VarChar ( 500 ),   -- (Obligatoire) Modèle Bouygues Ou IFR à rechercher, 105 car Max => si plus, accepté mais sera rejeté
	@asGenCodeBouygues			VarChar ( 500 ),       -- (Obligatoire si ADHESION / Facultatif si SINISTRE) 16 numérique Max => si plus, accepté mais sera rejeté. GENCODE Bouygues à stocker si présent, mais ne sert pas dans la recherche, vu avec Lisette le 11/06/21.
	@asMarqueIfrRetour			VarChar ( 35 ) OutPut, -- (Retour) Marque IFR en retour si un lien BYG/IFR existe Ou si la marque est directement une marque IFR
	@asModeleIfrRetour			VarChar ( 35 ) OutPut  -- (Retour) Modèle IFR en retour si un lien BYG/IFR existe Ou si le Modèle est directement une modèle IFR
AS

-- Code Retour de la PS
--  1 : Succès de recherche, à savoir : une marque et un modèle IFR sont retournés, non vide, non null
--  2 : Echec de recherche, à savoir  : une marque et un modèle IFR sont retournés vide (pas null), ce qui engendre automatiquement une demande de création par mail à Sébastien Loison (EPSIN)
--  3 : Echec de recherche mais pas de mail envoyé à Sébastien car le lien est en cours d'affectation chez Sébastien, un mail lui a déjà été envoyé sur un précédent appel, non traité encore
-- -2 : cas d'interrogation non valide
-- -3 : marque Bouygues ou IFR non valide
-- -4 : modèle Bouygues ou IFR non valide
-- -5 : GENCODE manquant pour cas Adhésion
-- -6 : GENCODE non valide pour création en cas Adhésion

SET NOCOUNT ON

/*
Set @asMarqueIfrRetour = 'MARQUE_TEST_IFR_BTRUN344'
Set @asModeleIfrRetour = 'MODELE_TEST_IFR_BTRUN344'
Return 1
*/

Declare @sObjet VarChar ( 255 )
Declare @sMessage VarChar ( 8000 )
Declare @sRetourErrMail VarChar ( 255 )
Declare @sFicOut VarChar ( 255 )
Declare @iCpt integer 
Declare @sGenCodeWrk VarChar ( 16 ) 
Declare @iEnvoiMail Integer

Set @asMarqueIfrRetour = ''
Set @asModeleIfrRetour = ''
Set @iEnvoiMail = 0 

If @asCasInterro is null Set @asCasInterro = ''
Set @asCasInterro = rTrim ( ltrim ( upper ( @asCasInterro )))
If @asCasInterro = '' Or ( @asCasInterro <> 'ADHESION' And @asCasInterro <> 'SINISTRE' ) Return -2

If @asGenCodeBouygues is null Set @asGenCodeBouygues = ''
Set @asGenCodeBouygues = sysadm.FN_EPURE_CHAINE_V01 ( @asGenCodeBouygues , 'EXCL_SLASHX2' )
Set @asGenCodeBouygues = rTrim ( ltrim ( upper ( @asGenCodeBouygues )))
If @asGenCodeBouygues = '' And @asCasInterro = 'ADHESION' Return -5
If Len ( @asGenCodeBouygues ) > 16 And @asCasInterro = 'ADHESION' Return -6
If CharIndex ( '_', @asGenCodeBouygues ) > 0 Return -6
Set @asGenCodeBouygues = Left ( @asGenCodeBouygues , 16 )

If @asMarqueBouyguesOuIfr is null Set @asMarqueBouyguesOuIfr = ''
Set @asMarqueBouyguesOuIfr = sysadm.FN_EPURE_CHAINE_V01 ( @asMarqueBouyguesOuIfr, 'EXCL_SLASHX2' )
Set @asMarqueBouyguesOuIfr = rTrim ( ltrim ( upper ( @asMarqueBouyguesOuIfr )))
If @asMarqueBouyguesOuIfr = '' Or Len ( @asMarqueBouyguesOuIfr ) > 35 Return -3

If @asModeleDescripBouyguesOuIfr is null Set @asModeleDescripBouyguesOuIfr = ''
Set @asModeleDescripBouyguesOuIfr = sysadm.FN_EPURE_CHAINE_V01 ( @asModeleDescripBouyguesOuIfr, 'EXCL_SLASHX2' )
Set @asModeleDescripBouyguesOuIfr = rTrim ( ltrim ( upper ( @asModeleDescripBouyguesOuIfr )))
If @asModeleDescripBouyguesOuIfr = '' Or Len ( @asModeleDescripBouyguesOuIfr ) > 105 Return -4

-- 2ème recherche lien IFR
Select Top 1 
		@asMarqueIfrRetour = ltrim ( rtrim ( a.id_marq_art_ifr )),
		@asModeleIfrRetour = ltrim ( rtrim ( a.id_modl_art_ifr ))
From sysadm.article a with (nolock)
Where a.id_four = 'BYG'
And   a.alt_dispo = 'O'
And   a.id_marq_art = @asMarqueBouyguesOuIfr
And   Left ( a.id_modl_art, Len (a.id_modl_art) -1 ) + isnull ( a.observ_frn, '' ) = @asModeleDescripBouyguesOuIfr

If @asMarqueIfrRetour is null Set @asMarqueIfrRetour = ''
If @asModeleIfrRetour is null Set @asModeleIfrRetour = ''

If @asMarqueIfrRetour <> '' And @asModeleIfrRetour <> ''
  Begin
	Return 1 -- Trouvé, succès
  End 

-- non trouvé, mais il peut être présent dans sysadm.article, et pas encore affecté.
If Not Exists ( 
		Select Top 1 1
		From sysadm.article a with (nolock)
		Where a.id_four = 'BYG'
		And   a.id_marq_art = @asMarqueBouyguesOuIfr
		And   Left ( a.id_modl_art, Len (a.id_modl_art) -1 ) + isnull ( a.observ_frn, '' ) = @asModeleDescripBouyguesOuIfr
	) 
  Begin -- Vraiment pas trouvé, donc on le créé
	
	-- Si ADHESION, Le GEN doit être valide, numérique 16 max
	If @asCasInterro = 'ADHESION' And ISNUMERIC ( @asGenCodeBouygues ) = 0 Return -6

	-- Si SINISTRE, Le GENCODE peut être non valide ou vide, pas obligatoire, j'en recréé un interne SIMPA2
	If @asCasInterro = 'SINISTRE' And ISNUMERIC ( @asGenCodeBouygues ) = 0 Set @asGenCodeBouygues = ''

	-- Génération d'un GENCODE interne SIMPA2
	If @asGenCodeBouygues = '' Set @asGenCodeBouygues = '9_9_9_9'

	Set @iCpt = 1
	Set @sGenCodeWrk = @asGenCodeBouygues 

	Set @asGenCodeBouygues = @sGenCodeWrk + '_' + convert ( varchar (5), @iCpt )
	While Exists ( Select Top 1 1
				   From sysadm.article a with (nolock)
				   Where a.id_four = 'BYG'
				   And   a.id_ref_four = @asGenCodeBouygues )
		Begin
			Set @iCpt = @iCpt + 1
			Set @asGenCodeBouygues = @sGenCodeWrk + '_' + convert ( varchar (5), @iCpt )
		End 

	Insert into sysadm.article 
	Select	'BYG',
			Left ( @asGenCodeBouygues, 20),
			'TEL',
			Left ( @asMarqueBouyguesOuIfr, 35),
			Left ( @asModeleDescripBouyguesOuIfr, 34) + '#',
			0,
			0,
			20000,
			Case 
				When len ( @asModeleDescripBouyguesOuIfr ) - 34 > 0 
					Then SUBSTRING ( @asModeleDescripBouyguesOuIfr, 35, len ( @asModeleDescripBouyguesOuIfr ) - 34 )
				Else ''
			End,
			'N',
			null,
			null,
			200,
			1,
			getdate(),
			getdate(),
			'JFF'

		Set @iEnvoiMail = 1 

		-- [REF_EXT_SAGA2]
		-- Recherche si Marqe/modl donné est une marque IFR auquel cas on fait le lien immédiatement
		If LEn ( @asMarqueBouyguesOuIfr ) <= 35 And Len ( @asModeleDescripBouyguesOuIfr ) <= 35
			Begin
				If Exists ( 
						Select	top 1 1 
						from	sysadm.ifr i with (nolock)
						Where   i.marque = @asMarqueBouyguesOuIfr
						And		i.reference = @asModeleDescripBouyguesOuIfr
						And		i.alt_dispo = 'O'		
					)
				Begin
					Set @iEnvoiMail = 0
					Set @asMarqueIfrRetour = @asMarqueBouyguesOuIfr
					Set @asModeleIfrRetour = @asModeleDescripBouyguesOuIfr

					Update sysadm.article 
					Set   id_marq_art_ifr = @asMarqueBouyguesOuIfr,
							id_modl_art_ifr = @asModeleDescripBouyguesOuIfr,
							alt_dispo		  = 'O'
					Where id_four = 'BYG'
					And   id_marq_art = @asMarqueBouyguesOuIfr
					And   Left ( id_modl_art, Len (id_modl_art) -1 ) + isnull ( observ_frn, '' ) = @asModeleDescripBouyguesOuIfr

					Return 1	
				End
			End
  End 

 If @iEnvoiMail > 0 
 Begin 
	-- Envoi du mail à Sébastien en production 
	Set @sObjet = '[BTRUN_344_REFBYGIFR] Demande de création de référence Bouygues<=>IFR'

	IF @@servername <> master.dbo.SPB_FN_ServerName ('PRO')	
		Begin 
			Set @sObjet = '[RECETTE] ' + @sObjet 
		End 

	Set @sMessage = @sMessage + ''

	Set @sMessage = 'Bonjour, ' + CHAR ( 10 ) 
	Set @sMessage = @sMessage + CHAR ( 10 )
	Set @sMessage = @sMessage + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Une nouvelle référence Bouygues est à relier à IFR.'
	Set @sMessage = @sMessage + CHAR ( 10 )
	Set @sMessage = @sMessage + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Type interrogation : En création ' + @asCasInterro + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Interrogation faite le ' + Convert ( varchar ( 10), GetDate(), 103 ) + ' à ' + Convert ( varchar ( 10), GetDate(), 108 ) + CHAR ( 10 )
	Set @sMessage = @sMessage + 'GenCode Bouygues : ' + IIF ( Left ( @sGenCodeWrk, 3 ) = '9_9', 'Aucun', @sGenCodeWrk ) + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Marque Bouygues : ' + @asMarqueBouyguesOuIfr + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Modèle Bouygues : ' + @asModeleDescripBouyguesOuIfr + CHAR ( 10 )
	Set @sMessage = @sMessage + CHAR ( 10 )	  
	Set @sMessage = @sMessage + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Cordialement,' + CHAR ( 10 )
	Set @sMessage = @sMessage + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Jean-François FABRY' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'DSI/DEI Equipe SIMPA2' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Legacy Application Tech Lead ' + CHAR ( 10 )
	Set @sMessage = @sMessage + '71, Quai Colbert - 76600 Le Havre - France' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Tél. : +33 (0)2 32 74 22 05' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'www.spb.eu' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'SAS au capital de 1 000 000 euros soumise au contrôle de l’ACPR.' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Siège social : 71, quai Colbert - CS 90000 - 76600 Le Havre. Tél. : +33 (0)2 32 74 20 20' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'N° RCS 305 109 779 (Le Havre) – N°ORIAS 07 002 642 (www.orias.fr).' + CHAR ( 10 )

	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			'ntonnetot@spb.eu,cmathe@spb.eu,ayvon@spb.eu', -- 'jff@spb.fr', -- 
			@sMessage, 
			@sObjet, 
			'[BTRUN_344_REFBYGIFR]', 
			'cbourdoiseau@spb.eu',
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL	
	Return 2
  End 

Return 3

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_SI_SAGA2_BYG_RECUPERER_GENCODE_DEPUIS_VALEUR_IFR
-- Auteur               :       FABRY JF
-- Date                 :       14/06/2021
-- Libellé              :       [BTRUN_344_REF_BYGUES]
-- Commentaires         :       
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SI_SAGA2_BYG_RECUPERER_GENCODE_DEPUIS_VALEUR_IFR' AND type = 'P' )
        DROP procedure sysadm.PS_SI_SAGA2_BYG_RECUPERER_GENCODE_DEPUIS_VALEUR_IFR
GO

CREATE procedure sysadm.PS_SI_SAGA2_BYG_RECUPERER_GENCODE_DEPUIS_VALEUR_IFR
	@asMarqueIfr			VarChar ( 500 ),		-- (Obligatoire) Marque Bouygues Ou IFR à rechercher, 30 car max => si plus, accepté mais sera rejeté
	@asModeleIfr			VarChar ( 500 ),		-- (Obligatoire) Modèle Bouygues Ou IFR à rechercher, 30 car max => si plus, accepté mais sera rejeté
	@asGenCodeBouygues		VarChar ( 16 ) OutPut	-- (Retour) GENCODE Bouygues si existant
AS

-- Code Retour de la PS
--  1 : Succès de recherche : à savoir un GENCODE Bouygues est retourné, non vide, non null
--  2 : Echec de recherche  : à savoir un GENCODE est retourné vide (pas null) parce qu’aucun GENCODE n’a été trouvé
--  3 : Echec de recherche  : à savoir un GENCODE est retourné vide (pas null) parce plusieurs ont été trouvés (au moins 2)
-- -1 : Marque IFR non valide
-- -2 : Modèle IFR non valide

SET NOCOUNT ON

/*
Set @asGenCodeBouygues = 'GC_TEST_BTRUN344'
Return 1
*/

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  gencode   varchar ( 20 )
	)

Declare @iNbreGC Integer

If @asMarqueIfr is null Set @asMarqueIfr = ''
Set @asMarqueIfr = sysadm.FN_EPURE_CHAINE_V01 ( @asMarqueIfr, 'EXCL_SLASHX2' )
Set @asMarqueIfr = rTrim ( ltrim ( upper ( @asMarqueIfr )))
If @asMarqueIfr = '' Or Len ( @asMarqueIfr ) > 30 Return -1

If @asModeleIfr is null Set @asModeleIfr = ''
Set @asModeleIfr = sysadm.FN_EPURE_CHAINE_V01 ( @asModeleIfr, 'EXCL_SLASHX2' )
Set @asModeleIfr = rTrim ( ltrim ( upper ( @asModeleIfr )))
If @asModeleIfr = '' Or Len ( @asModeleIfr ) > 30 Return -2

Set @asGenCodeBouygues = ''		

Insert into @tb
Select	Distinct
		Left ( a.id_ref_four, IIF ( CharIndex ( '_', a.id_ref_four ) > 0, CharIndex ( '_', a.id_ref_four ) -1 , Len ( a.id_ref_four ) )) 'gencode'
From	sysadm.article a with (nolock)
Where   a.id_four = 'BYG'
And		a.alt_dispo = 'O'
And		left ( a.id_ref_four, 3 ) <> '9_9'
And		a.id_marq_art_ifr = @asMarqueIfr
And		a.id_modl_art_ifr = @asModeleIfr

If ( Select count (*) From @tb ) <= 0 Return 2 -- Aucun GC
If ( Select count (*) From @tb ) > 1 Return 3 -- Au moins 2 GC différent

Select	@asGenCodeBouygues = Left ( a.id_ref_four, IIF ( CharIndex ( '_', a.id_ref_four ) > 0, CharIndex ( '_', a.id_ref_four ) -1 , Len ( a.id_ref_four ) )) 
From	sysadm.article a with (nolock)
Where   a.id_four = 'BYG'
And		a.alt_dispo = 'O'
And		left ( a.id_ref_four, 3 ) <> '9_9'
And		a.id_marq_art_ifr = @asMarqueIfr
And		a.id_modl_art_ifr = @asModeleIfr

If @asGenCodeBouygues is null Set @asGenCodeBouygues = ''

Return 1

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_SI_SAGA2_LIEN_REF_EXTERNE_AVEC_IFR
-- Auteur               :       FABRY JF
-- Date                 :       30/06/2022
-- Libellé              :       [RS_A_VENIR]
-- Commentaires         :       
-- Références           :       
--
-------------------------------------------------------------------
--  JFF  21/10/2022  RS3917 l'info de reconditionné doit se retrouver à partir du terme "recondit" dans le modèle transmis par Free
--  JFF  25/05/2023  HP-174 Ajout -CAPACITE, -COULEUR, -DUALSIM
-- JFF 25/09/2023 [REF_EXT_SAGA2] Gérer l'appel en mode SINISTRE d'un marque modèle à injecter dans le Ref Externe
-- JFF 24/01/2023 Ne plus rendre obligatoire le GEN CODE sur l'adhésion
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SI_SAGA2_LIEN_REF_EXTERNE_AVEC_IFR_V02' AND type = 'P' )
        DROP procedure sysadm.PS_SI_SAGA2_LIEN_REF_EXTERNE_AVEC_IFR_V02
GO

CREATE procedure sysadm.PS_SI_SAGA2_LIEN_REF_EXTERNE_AVEC_IFR_V02
	@asCasInterro					VarChar ( 10 ),    -- (Obligatoire) Cas d'interrogation et éventuellement demande de création de lien : ADHESION (Création d'adhésion) / SINISTRE (Création de sinistre) , dans les 2 cas, pensez toujours à COMMITER votre appel, la PS ne fait pas qu’interroger, elle écrit aussi
	@asCodeSpbPrestaExterne		    VarChar ( 3 ),     -- (Obligatoire) Code Spb (donné par JFF) référençant le prestataire extérieur chez Spb. Voir avec JFF pour avoir ce code.
	@asMarqueExterneOuIfr			VarChar ( 500 ),   -- (Obligatoire) Marque Externe Ou IFR à rechercher , tronqué à 35 caractères max automatiquement, non rejeté
	@asModeleDescripExterneOuIfr	VarChar ( 500 ),   -- (Obligatoire) Modèle Externe Ou IFR à rechercher, tronqué à 105 caractères max automatiquement, non rejeté
	@asGenCodeExterne			VarChar ( 500 ),       -- (Obligatoire si ADHESION Bouygues/ Facultatif si SINISTRE) 16 numérique Max => si plus, accepté mais sera rejeté. GENCODE Externe à stocker si présent, mais ne sert pas dans la recherche, vu avec Lisette le 11/06/21.  ,Passez ce que vous voulez ou rien du tout, je m’en arrangerai dans tout les cas, aucun rejet
	@asMarqueIfrRetour			VarChar ( 35 ) OutPut, -- (Retour) Marque IFR en retour si un lien EXT/IFR existe Ou si la marque est directement une marque IFR
	@asModeleIfrRetour			VarChar ( 35 ) OutPut, -- (Retour) Modèle IFR en retour si un lien EXT/IFR existe Ou si le Modèle est directement une modèle IFR
	@adcMtPrixPublicIFR			Decimal (11,2) OutPut, -- (Retour) Montant de la valeur Publique IFR de l'appareil.
	@asCapacite					Varchar ( 25 ) output, -- (Retour) Capacité de stockage de l'appareil [HP-174]
	@asDualSim					Varchar ( 25 ) output, -- (Retour) Fonction DualSim de l'appareil [HP-174]
	@asCouleur					Varchar ( 25 ) output -- (Retour) couleur de l'appareil [HP-174]
AS

-- Code Retour de la PS
--  1 : Succès de recherche, à savoir : une marque et un modèle IFR sont retournés, non vide, non null
--  2 : Echec de recherche, à savoir  : une marque et un modèle IFR sont retournés vide (pas null), ce qui engendre automatiquement une demande de création par mail à Sébastien Loison (EPSIN)
--  3 : Echec de recherche mais pas de mail envoyé à Sébastien car le lien est en cours d'affectation chez Sébastien, un mail lui a déjà été envoyé sur un précédent appel, non traité encore
-- -2 : cas d'interrogation non valide (@asCasInterro)
-- -3 : marque Externe ou IFR non valide
-- -4 : modèle Externe ou IFR non valide
-- -5 : GENCODE manquant pour cas Adhésion
-- -6 : GENCODE non valide pour création en cas Adhésion
-- -7 : @asCodeSpbPrestaExterne : Le code prestataire externe n'est pas valide pour cette fonctionnalité ou bien n'existe pas

SET NOCOUNT ON


Declare @sObjet VarChar ( 255 )
Declare @sMessage VarChar ( 8000 )
Declare @sRetourErrMail VarChar ( 255 )
Declare @sFicOut VarChar ( 255 )
Declare @iCpt integer 
Declare @sGenCodeWrk VarChar ( 16 ) 
Declare @iEnvoiMail Integer
Declare @sLibPrestaExterne VarChar ( 35 ) 
Declare @sFrom varchar ( 50 )

Set @asMarqueIfrRetour = ''
Set @asModeleIfrRetour = ''
Set @iEnvoiMail = 0 

Set @asCodeSpbPrestaExterne = lTrim ( rtrim ( UPPER ( @asCodeSpbPrestaExterne ) ) )

If Not Exists (
	Select Top 1 1 
	From sysadm.code_car cc with (nolock),
		 sysadm.code_car cc1 with (nolock)
	Where cc.id_typ_code = '-FR'
	And   cc.id_code = @asCodeSpbPrestaExterne
	And   cc1.id_typ_code = '-WM' -- Liste autorisant les fonctionnalités proposées par cette PS
	And   cc1.id_code = cc.id_code
) Begin
	Return -7
End 

Select @sLibPrestaExterne = lTrim ( rtrim ( cc.lib_code ) ) From sysadm.code_car cc where cc.id_typ_code = '-FR' and id_code = @asCodeSpbPrestaExterne

If @asCasInterro is null Set @asCasInterro = ''
Set @asCasInterro = rTrim ( ltrim ( upper ( @asCasInterro )))
If @asCasInterro = '' Or ( @asCasInterro <> 'ADHESION' And @asCasInterro <> 'SINISTRE' ) Return -2

If @asGenCodeExterne is null Set @asGenCodeExterne = ''
Set @asGenCodeExterne = sysadm.FN_EPURE_CHAINE_V01 ( @asGenCodeExterne , 'EXCL_SLASHX2' ) 
Set @asGenCodeExterne = rTrim ( ltrim ( upper ( @asGenCodeExterne )))

-- Plus la peine 24/01/2023
-- If @asGenCodeExterne = '' And @asCasInterro = 'ADHESION' Return -5

-- Modif 24/01/2023
-- If Len ( @asGenCodeExterne ) > 16 And @asCasInterro = 'ADHESION' Return -6
If Len ( @asGenCodeExterne ) > 16 Set @asGenCodeExterne = ''

-- Modif 24/01/2023
-- If CharIndex ( '_', @asGenCodeExterne ) > 0 Return -6
--Set @asGenCodeExterne = Left ( @asGenCodeExterne , 16 )
If CharIndex ( '_', @asGenCodeExterne ) > 0 Set @asGenCodeExterne = ''

If @asMarqueExterneOuIfr is null Set @asMarqueExterneOuIfr = ''
Set @asMarqueExterneOuIfr = sysadm.FN_EPURE_CHAINE_V01 ( @asMarqueExterneOuIfr, 'EXCL_SLASHX2' ) 
Set @asMarqueExterneOuIfr = rTrim ( ltrim ( upper ( @asMarqueExterneOuIfr )))

-- Modif 24/01/2023
--If @asMarqueExterneOuIfr = '' Or Len ( @asMarqueExterneOuIfr ) > 35 Return -3
If @asMarqueExterneOuIfr = '' Return -3
Set @asMarqueExterneOuIfr = LEFT ( @asMarqueExterneOuIfr, 35 )

If @asModeleDescripExterneOuIfr is null Set @asModeleDescripExterneOuIfr = ''
Set @asModeleDescripExterneOuIfr = sysadm.FN_EPURE_CHAINE_V01 ( @asModeleDescripExterneOuIfr, 'EXCL_SLASHX2' ) 
--RS3917
Set @asModeleDescripExterneOuIfr = REPLACE ( @asModeleDescripExterneOuIfr, '[REC]', '' ) 
Set @asModeleDescripExterneOuIfr = rTrim ( ltrim ( upper ( @asModeleDescripExterneOuIfr )))

-- Modif 24/01/2023
-- If @asModeleDescripExterneOuIfr = '' Or Len ( @asModeleDescripExterneOuIfr ) > 105 Return -4
If @asModeleDescripExterneOuIfr = '' Return -4
Set @asModeleDescripExterneOuIfr = LEFT ( @asModeleDescripExterneOuIfr, 105 )

-- 2ème recherche lien IFR
Select Top 1 
		@asMarqueIfrRetour = ltrim ( rtrim ( a.id_marq_art_ifr )),
		@asModeleIfrRetour = ltrim ( rtrim ( a.id_modl_art_ifr )),
		@adcMtPrixPublicIFR = i.frequence,
		@asCapacite = i.java, -- [HP-174]
		@asDualSim	= IIF ( IsNull ( i.stndby, 'NON') <> 'DUALSIM', 'NON', IsNull ( i.stndby, 'NON') ), -- [HP-174]
		@asCouleur  = i.packtype -- [HP-174]

From sysadm.article a with (nolock),
	 sysadm.ifr i with (nolock)
Where a.id_four = @asCodeSpbPrestaExterne
And   a.alt_dispo = 'O'
--And   sysadm.FN_EPURE_CHAINE_V01 ( a.id_marq_art, 'EXCL_SLASHX2') = @asMarqueExterneOuIfr
--And   sysadm.FN_EPURE_CHAINE_V01 ( Left ( a.id_modl_art, Len (a.id_modl_art) -1 ) + isnull ( a.observ_frn, '' ), 'EXCL_SLASHX2') = @asModeleDescripExterneOuIfr
And   a.id_marq_art = @asMarqueExterneOuIfr
And   Left ( a.id_modl_art, Len (a.id_modl_art) -1 ) + isnull ( a.observ_frn, '' ) = @asModeleDescripExterneOuIfr
And   i.marque = a.id_marq_art_ifr
And   i.reference = a.id_modl_art_ifr

If @asMarqueIfrRetour is null Set @asMarqueIfrRetour = ''
If @asModeleIfrRetour is null Set @asModeleIfrRetour = ''
If @adcMtPrixPublicIFR is null Set @adcMtPrixPublicIFR = 0

--RS3917 Particularité FREE
If @asCodeSpbPrestaExterne = 'FRE' And @asModeleIfrRetour <> '' And CharIndex ( 'RECONDITIONN', @asModeleDescripExterneOuIfr ) > 0 Set @asModeleIfrRetour = @asModeleIfrRetour + ' [REC]'

If @asMarqueIfrRetour <> '' And @asModeleIfrRetour <> ''
  Begin
	Return 1 -- Trouvé, succès
  End 

-- non trouvé, mais il peut être présent dans sysadm.article, et pas encore affecté.
If Not Exists ( 
		Select Top 1 1
		From sysadm.article a with (nolock)
		Where a.id_four = @asCodeSpbPrestaExterne
		And   a.id_marq_art = @asMarqueExterneOuIfr
		And   Left ( a.id_modl_art, Len (a.id_modl_art) -1 ) + isnull ( a.observ_frn, '' ) = @asModeleDescripExterneOuIfr
	) 
  Begin -- Vraiment pas trouvé, donc on le créé
	
	-- Si ADHESION, Le GEN doit être valide, numérique 16 max
	-- Modif 24/01/2023 - Trop restrictif
	-- If @asCasInterro = 'ADHESION' And ISNUMERIC ( @asGenCodeExterne ) = 0 Return -6

	-- Si SINISTRE, Le GENCODE peut être non valide ou vide, pas obligatoire, j'en recréé un interne SIMPA2
	-- Modif 24/01/2023 - Trop restrictif	
	--If @asCasInterro = 'SINISTRE' And ISNUMERIC ( @asGenCodeExterne ) = 0 Set @asGenCodeExterne = ''

	-- Génération d'un GENCODE interne SIMPA2
	If @asGenCodeExterne = '' Set @asGenCodeExterne = '9_9_9_'

	Set @iCpt = 1
	Set @sGenCodeWrk = @asGenCodeExterne 

	Set @asGenCodeExterne = @sGenCodeWrk + right ( replicate ( '0', 5 ) + convert ( varchar (5), @iCpt ), 5)
	While Exists ( Select Top 1 1
				   From sysadm.article a with (nolock)
				   Where a.id_four = @asCodeSpbPrestaExterne
				   And   a.id_ref_four = @asGenCodeExterne )
		Begin
			Set @iCpt = @iCpt + 1
			Set @asGenCodeExterne = @sGenCodeWrk + right ( replicate ( '0', 5 ) + convert ( varchar (5), @iCpt ), 5)
		End 

	Insert into sysadm.article 
	Select	@asCodeSpbPrestaExterne,
			Left ( @asGenCodeExterne, 20),
			'TEL',
			Left ( @asMarqueExterneOuIfr, 35),
			Left ( @asModeleDescripExterneOuIfr, 34) + '#',
			0,
			0,
			20000,
			Case 
				When len ( @asModeleDescripExterneOuIfr ) - 34 > 0 
					Then SUBSTRING ( @asModeleDescripExterneOuIfr, 35, len ( @asModeleDescripExterneOuIfr ) - 34 )
				Else ''
			End,
			'N',
			null,
			null,
			200,
			1,
			getdate(),
			getdate(),
			'JFF'
			
		Set @iEnvoiMail = 1 
		-- [REF_EXT_SAGA2]
		-- Recherche si Marqe/modl donné est une marque IFR auquel cas on fait le lien immédiatement
		If LEn ( @asMarqueExterneOuIfr ) <= 35 And Len ( @asModeleDescripExterneOuIfr ) <= 35
			Begin
				If Exists ( 
						Select	top 1 1 
						from	sysadm.ifr i with (nolock)
						Where   i.marque = @asMarqueExterneOuIfr
						And		i.reference = @asModeleDescripExterneOuIfr
						And		i.alt_dispo = 'O'		
					)
				Begin
					Set @iEnvoiMail = 0
					Set @asMarqueIfrRetour = @asMarqueExterneOuIfr
					Set @asModeleIfrRetour = @asModeleDescripExterneOuIfr

					Update sysadm.article 
					Set   id_marq_art_ifr = @asMarqueExterneOuIfr,
							id_modl_art_ifr = @asModeleDescripExterneOuIfr,
							alt_dispo		  = 'O'
					Where id_four = @asCodeSpbPrestaExterne
					And   id_marq_art = @asMarqueExterneOuIfr
					And   Left ( id_modl_art, Len (id_modl_art) -1 ) + isnull ( observ_frn, '' ) = @asModeleDescripExterneOuIfr

					Return 1	
				End
			End
  End 

 If @iEnvoiMail > 0 
 Begin 
	-- Envoi du mail à Sébastien en production 
	Set @sObjet = 'Demande de création de référence (lien) Externe<=>IFR'

	IF @@servername <> master.dbo.SPB_FN_ServerName ('PRO')	
		Begin 
			Set @sObjet = '[RECETTE] ' + @sObjet 
		End 

	Set @sMessage = @sMessage + ''

	Set @sMessage = 'Bonjour,' + CHAR ( 10 ) 
	Set @sMessage = @sMessage + CHAR ( 10 )
	Set @sMessage = @sMessage + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Une nouvelle référence Externe du prestataire ' + @sLibPrestaExterne + ' est à relier à IFR.'
	Set @sMessage = @sMessage + CHAR ( 10 )
	Set @sMessage = @sMessage + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Prestataire externe : ' + @sLibPrestaExterne + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Type interrogation : En création ' + @asCasInterro + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Interrogation faite le ' + Convert ( varchar ( 10), GetDate(), 103 ) + ' à ' + Convert ( varchar ( 10), GetDate(), 108 ) + CHAR ( 10 )
	Set @sMessage = @sMessage + 'GenCode Externe : ' + IIF ( Left ( @sGenCodeWrk, 3 ) = '9_9', 'Aucun', @sGenCodeWrk ) + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Marque Externe : ' + @asMarqueExterneOuIfr + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Modèle Externe : ' + @asModeleDescripExterneOuIfr + CHAR ( 10 )
	Set @sMessage = @sMessage + CHAR ( 10 )	  
	Set @sMessage = @sMessage + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Cordialement,' + CHAR ( 10 )
	Set @sMessage = @sMessage + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Jean-François FABRY' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Leader technique' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Application sinistre SIMPA2' + CHAR ( 10 )
	Set @sMessage = @sMessage + '71, Quai Colbert - 76600 Le Havre - France' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Tél. : +33 (0)2 32 74 22 05' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Suivez-nous sur LinkedIn !  www.spb.eu' + CHAR ( 10 )
	Set @sMessage = @sMessage + '----------------------------------------------------------' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'SAS au capital de 1 000 000 euros soumise au contrôle de l’ACPR.' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'Siège social : 71, quai Colbert - CS 90000 - 76600 Le Havre. Tél. : +33 (0)2 32 74 20 20' + CHAR ( 10 )
	Set @sMessage = @sMessage + 'N° RCS 305 109 779 (Le Havre) – N°ORIAS 07 002 642 (www.orias.fr).' + CHAR ( 10 )

	Set @sFrom = 'Lien_IFR_' + @asCodeSpbPrestaExterne

	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			'ntonnetot@spb.eu,cmathe@spb.eu,ayvon@spb.eu', -- 'jff@spb.fr'
			@sMessage, 
			@sObjet, 
			@sFrom, 
			'cbourdoiseau@spb.eu',
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL	
	Return 2
  End 

Return 3

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_SI_SAGA2_RECUPERER_GENCODE_DEPUIS_VALEUR_IFR
-- Auteur               :       FABRY JF
-- Date                 :       30/06/2022
-- Libellé              :       [RS_A_VENIR]
-- Commentaires         :       
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SI_SAGA2_RECUPERER_GENCODE_DEPUIS_VALEUR_IFR' AND type = 'P' )
        DROP procedure sysadm.PS_SI_SAGA2_RECUPERER_GENCODE_DEPUIS_VALEUR_IFR
GO

CREATE procedure sysadm.PS_SI_SAGA2_RECUPERER_GENCODE_DEPUIS_VALEUR_IFR
	@asCodeSpbPrestaExterne	VarChar ( 3 ),			-- (Obligatoire) Code Spb (donné par JFF) référencant le prestataire Exterieur chez Spb. Voir avec JFF pour avoir ce code.
	@asMarqueIfr			VarChar ( 500 ),		-- (Obligatoire) Marque IFR à rechercher, 30 car max => si plus, accepté mais sera rejeté
	@asModeleIfr			VarChar ( 500 ),		-- (Obligatoire) Modèle IFR à rechercher, 30 car max => si plus, accepté mais sera rejeté
	@asGenCodeExterne		VarChar ( 16 ) OutPut	-- (Retour) GENCODE Externe si existant
AS

-- Code Retour de la PS
--  1 : Succès de recherche : à savoir un GENCODE Externe est retourné, non vide, non null
--  2 : Echec de recherche  : à savoir un GENCODE est retourné vide (pas null) parce qu’aucun GENCODE n’a été trouvé
--  3 : Echec de recherche  : à savoir un GENCODE est retourné vide (pas null) parce plusieurs ont été trouvés (au moins 2)
-- -1 : Marque IFR non valide
-- -2 : Modèle IFR non valide

SET NOCOUNT ON

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  gencode   varchar ( 20 )
	)

Declare @iNbreGC Integer


If Not Exists (
	Select Top 1 1 
	From sysadm.code_car cc,
		 sysadm.code_car cc1
	Where cc.id_typ_code = '-FR'
	And   cc.id_code = @asCodeSpbPrestaExterne
	And   cc1.id_typ_code = '-WM' -- Liste autorisant les fonctionnalités proposées par cette PS
	And   cc1.id_code = cc.id_code
) Begin
	Return -7
End 


If @asMarqueIfr is null Set @asMarqueIfr = ''
Set @asMarqueIfr = sysadm.FN_EPURE_CHAINE_V01 ( @asMarqueIfr, 'EXCL_SLASHX2' )
Set @asMarqueIfr = rTrim ( ltrim ( upper ( @asMarqueIfr )))
If @asMarqueIfr = '' Or Len ( @asMarqueIfr ) > 30 Return -1

If @asModeleIfr is null Set @asModeleIfr = ''
Set @asModeleIfr = sysadm.FN_EPURE_CHAINE_V01 ( @asModeleIfr, 'EXCL_SLASHX2' )
Set @asModeleIfr = rTrim ( ltrim ( upper ( @asModeleIfr )))
If @asModeleIfr = '' Or Len ( @asModeleIfr ) > 30 Return -2

Set @asGenCodeExterne = ''		

Insert into @tb
Select	Distinct
		Left ( a.id_ref_four, IIF ( CharIndex ( '_', a.id_ref_four ) > 0, CharIndex ( '_', a.id_ref_four ) -1 , Len ( a.id_ref_four ) )) 'gencode'
From	sysadm.article a with (nolock)
Where   a.id_four = @asCodeSpbPrestaExterne
And		a.alt_dispo = 'O'
And		left ( a.id_ref_four, 3 ) <> '9_9'
And		a.id_marq_art_ifr = @asMarqueIfr
And		a.id_modl_art_ifr = @asModeleIfr

If ( Select count (*) From @tb ) <= 0 Return 2 -- Aucun GC
If ( Select count (*) From @tb ) > 1 Return 3 -- Au moins 2 GC différent

Select	@asGenCodeExterne = Left ( a.id_ref_four, IIF ( CharIndex ( '_', a.id_ref_four ) > 0, CharIndex ( '_', a.id_ref_four ) -1 , Len ( a.id_ref_four ) )) 
From	sysadm.article a with (nolock)
Where   a.id_four = @asCodeSpbPrestaExterne
And		a.alt_dispo = 'O'
And		left ( a.id_ref_four, 3 ) <> '9_9'
And		a.id_marq_art_ifr = @asMarqueIfr
And		a.id_modl_art_ifr = @asModeleIfr

If @asGenCodeExterne is null Set @asGenCodeExterne = ''

Return 1

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_SI_SAGA2_RECUP_REF_SPBIFR_EN_LIEN_AVEC_REF_EXTERNE
-- Auteur               :       FABRY JF
-- Date                 :       12/06/2023
-- Libellé              :       [RS-5297-HP-178]
-- Commentaires         :       
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SI_SAGA2_RECUP_REF_SPBIFR_EN_LIEN_AVEC_REF_EXTERNE' AND type = 'P' )
        DROP procedure sysadm.PS_SI_SAGA2_RECUP_REF_SPBIFR_EN_LIEN_AVEC_REF_EXTERNE
GO

CREATE procedure sysadm.PS_SI_SAGA2_RECUP_REF_SPBIFR_EN_LIEN_AVEC_REF_EXTERNE
	@asLstCodeSpbPrestaExterne	VarChar ( 255 ),  -- (Obligatoire) Liste des Code Spb (donnés par JFF) référencant les prestataires Exterieur chez Spb à passer sous forme #BYG#FRE#...
	@asFormatRetour VarChar ( 50 ) -- (Obligatoire) 'DISTINCT' (défaut) ou 'PAR_FOURN'
AS

If Upper ( @asFormatRetour ) = 'PAR_FOURN'
  Begin
	Select  Distinct
			a.id_four 'Code_Fourn',
			ltrim ( rtrim ( a.id_marq_art_ifr )) 'Marque_spbifr',
			ltrim ( rtrim ( a.id_modl_art_ifr )) 'Modèle_spbifr',
			IsNull ( i.java, '')  'Capacité', 
			IIF ( IsNull ( i.stndby, 'NON') <> 'DUALSIM', 'NON', IsNull ( i.stndby, 'NON') ) 'DualSim', 
			IsNull ( i.packtype, '')  'Couleur'

	From sysadm.article a with (nolock),
			sysadm.ifr i with (nolock)
	Where CharIndex ( '#' + a.id_four + '#', @asLstCodeSpbPrestaExterne ) > 0 
	And   i.marque = a.id_marq_art_ifr
	And   i.reference = a.id_modl_art_ifr
	Order by 1,2,3
End 
Else 
Begin
	Select  Distinct
			ltrim ( rtrim ( a.id_marq_art_ifr )) 'Marque_spbifr',
			ltrim ( rtrim ( a.id_modl_art_ifr )) 'Modèle_spbifr',
			IsNull ( i.java, '')  'Capacité', 
			IIF ( IsNull ( i.stndby, 'NON') <> 'DUALSIM', 'NON', IsNull ( i.stndby, 'NON') ) 'DualSim', 
			IsNull ( i.packtype, '')  'Couleur'

	From sysadm.article a with (nolock),
			sysadm.ifr i with (nolock)
	Where CharIndex ( '#' + a.id_four + '#', @asLstCodeSpbPrestaExterne ) > 0 
	And   i.marque = a.id_marq_art_ifr
	And   i.reference = a.id_modl_art_ifr
	Order by 1,2
End 
Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_SAGA2_INTERRO_ARTICLE_REF_EXTERNE
-- Auteur               :       FABRY JF
-- Date                 :       21/09/2023
-- Libellé              :       
-- Commentaires         :       
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_SAGA2_INTERRO_ARTICLE_REF_EXTERNE' AND type = 'P' )
        DROP procedure sysadm.PS_S_SAGA2_INTERRO_ARTICLE_REF_EXTERNE
GO

CREATE procedure sysadm.PS_S_SAGA2_INTERRO_ARTICLE_REF_EXTERNE
	@asCodeSpbPrestaExterne	    VarChar ( 3 ),           -- (Obligatoire) Code prestataire externe interrogé
	@asMarqueExterne			VarChar ( 500 ),		 -- (Obligatoire) Marque externe 
	@asModeleDescripExterne		VarChar ( 500 ),		 -- (Obligatoire) Modèle externe 
	@asPresentSurSIMPA2			Varchar ( 10 ) output,   -- OUI si ref externe déclaré sur SIMPA2 par SAGA2, NON à défaut
	@asLienIFRsurSIMPA2			Varchar ( 10 ) output,   -- OUI si ref externe déclaré sur SIMPA2 par SAGA2 est bien lié à IFR, NON à défaut
	@asMarqueIfr				Varchar ( 35 ) output,   -- Si OUI à @asLienIFRsurSIMPA2 alors marque IFR renvoyée pour info
	@asModeleIfr				Varchar ( 35 ) output    -- Si OUI à @asLienIFRsurSIMPA2 alors modele IFR renvoyée pour info
AS

Set @asPresentSurSIMPA2 = 'NON'
Set @asLienIFRsurSIMPA2 = 'NON'
Set @asMarqueIfr = null
Set @asModeleIfr = null
Set @asMarqueExterne = LTRIM ( rtrim ( @asMarqueExterne ))
Set @asModeleDescripExterne = LTRIM ( rtrim ( @asModeleDescripExterne ))

Select  Top 1 
	    @asLienIFRsurSIMPA2 =
		Case 
			When a.id_marq_art_ifr is not null And a.id_modl_art_ifr is not null Then 'OUI'
			Else 'NON'
		End,
		@asMarqueIfr = a.id_marq_art_ifr,
		@asModeleIfr = a.id_modl_art_ifr

From sysadm.article a
Where a.id_four = @asCodeSpbPrestaExterne
And   a.id_marq_art = @asMarqueExterne
And   rtrim ( Left ( a.id_modl_art, len (  a.id_modl_art ) -1 )) + RTRIM ( a.observ_frn) = @asModeleDescripExterne

If @@Rowcount > 0 Set @asPresentSurSIMPA2= 'OUI'

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_SAGA2_MARQUE_IFR_V01
-- Auteur               :       FABRY JF
-- Date                 :       05/2025
-- Libellé              :       
-- Commentaires         :       
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_SAGA2_MARQUE_IFR_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S_SAGA2_MARQUE_IFR_V01
GO

CREATE procedure sysadm.PS_S_SAGA2_MARQUE_IFR_V01
  @asTypApp Varchar ( 3 ) 
AS

SET NOCOUNT ON

Set @asTypApp = LTRIM ( rTrim ( @asTypApp ))

Select	Distinct
		i.marque 'Marque'
from	sysadm.ifr i
Where   i.alt_dispo = 'O'					   
And     i.sku_saga = @asTypApp
Order by i.marque

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_SAGA2_MODELE_IFR_V01
-- Auteur               :       FABRY JF
-- Date                 :       05/2025
-- Libellé              :       
-- Commentaires         :       
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_SAGA2_MODELE_IFR_V01' AND type = 'P' )
        DROP procedure sysadm.PS_S_SAGA2_MODELE_IFR_V01
GO


CREATE procedure sysadm.PS_S_SAGA2_MODELE_IFR_V01
	@asMarque varchar(35),
	@asTypApp Varchar ( 3 ) 
AS

SET NOCOUNT ON

Set @asMarque = lTrim ( rTrim ( @asMarque ))
Set @asTypApp = LTRIM ( rTrim ( @asTypApp ))

Select	Distinct		
		i.reference 'Modele'
from	sysadm.ifr i
Where   i.alt_dispo = 'O'					   
And i.marque = @asMarque
And i.sku_saga = @asTypApp
Order by i.reference

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_SAGA2_EXTRANET_LST_MARQ_MODL_IFR_SUR_TYPE_APP
-- Auteur               :       FABRY JF
-- Date                 :       05/2025
-- Libellé              :       
-- Commentaires         :       
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_SAGA2_EXTRANET_LST_MARQ_MODL_IFR_SUR_TYPE_APP' AND type = 'P' )
        DROP procedure sysadm.PS_S_SAGA2_EXTRANET_LST_MARQ_MODL_IFR_SUR_TYPE_APP
GO

CREATE procedure sysadm.PS_S_SAGA2_EXTRANET_LST_MARQ_MODL_IFR_SUR_TYPE_APP
	@asLstTypApp Varchar ( 100 ) 
AS

Set nocount on

Set @asLstTypApp = LTRIM ( rTrim ( Upper ( @asLstTypApp  )))
If LEFT ( @asLstTypApp, 1 ) <> '#' Set @asLstTypApp = '#' + @asLstTypApp
If right ( @asLstTypApp, 1 ) <> '#' Set @asLstTypApp = @asLstTypApp + '#'

Select	i.sku_saga 'typ_app', 
		i.marque 'marque_ifr',
		i.reference 'modele_ifr'
from sysadm.ifr i
where CharIndex ( '#' + ltrim ( rtrim ( i.sku_saga )) + '#', @asLstTypApp , 1 )  > 0 
Order by 1, 2, 3

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_SAGA2_PLAFOND_PAR_ANNEE_SUR_SAGA2
-- Auteur               :       FABRY JF
-- Date                 :       05/2025
-- Libellé              :       
-- Commentaires         :       à appeler à partie de SIMPA2 !!!
-- Références           :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_SAGA2_PLAFOND_PAR_ANNEE_SUR_SAGA2' AND type = 'P' )
        DROP procedure sysadm.PS_S_SAGA2_PLAFOND_PAR_ANNEE_SUR_SAGA2
GO

CREATE procedure sysadm.PS_S_SAGA2_PLAFOND_PAR_ANNEE_SUR_SAGA2
	@adcIdSin Decimal ( 10 ),
	@asSubscriptionNumber VARCHAR(50)
AS

Declare @sEnv VarChar ( 10 )
Declare @dcIdProd Decimal ( 7 )
Declare @sSql Varchar ( 3000 )
Declare @sInstanceSaga2 Varchar ( 50 )

Declare @TbRetSaga2 Table ( 
	id_seq Integer identity (1, 1 ),
	id_sin integer,
	subscription_number varchar ( 50 ),
	indemnise VarChar ( 10 ),
	mt_reg_assure Decimal ( 11, 2 ),
	mode_indemnisation VarChar ( 50 ),
	mode_indemnisation_long VarChar ( 50 ),
	dte_adh DateTime,
	dte_decl DateTime,
	dte_surv DateTime
)

Set @asSubscriptionNumber = Right ( REPLICATE ( '0', 12 ) + LTRIM ( rtrim ( @asSubscriptionNumber ) ), 12 ) 

Select  @dcIdProd = ws.id_prod
From sysadm.w_sin ws
Where ws.id_sin = @adcIdSin

If @dcIdProd is null 
  Begin
	Select  @dcIdProd = ws.id_prod
	From sysadm.sinistre ws
	Where ws.id_sin = @adcIdSin
  End 

If @dcIdProd is null Return -1

If @@servername = master.dbo.SPB_FN_ServerName ('PRO') Set @sEnv = 'PRO' Else Set @sEnv = 'SIM'

If @sEnv = 'PRO' 
 Begin 
 	If NOT ( SHERPA_PRO.sysadm.FN_IS_SAGA ( @dcIdProd ) > 0 ) Return 1

	Set @sInstanceSaga2 = '[LS-SAGA2]'

 End 
Else
 Begin
	If NOT ( SHERPA_SIM.sysadm.FN_IS_SAGA ( @dcIdProd ) > 0 ) Return 1

	-- [INSTANCE]
	If sysadm.FN_CLE_NUMERIQUE ( 'INSTANCE_PPR_REC_HUB') = 1
		Begin 
			Set @sInstanceSaga2 = '[S2SQL14DEV\RECSAGA2]' 
		End 
	Else
		Begin 
			Set @sInstanceSaga2 = '[S2SQL14PP1\PPRSAGA2]'
		End 	

 End 

Set @sSql = 
' Select' +
'  c.spb_claim_number AS id_sin,' +
'  s.subscription_number, ' +
'  Case rcs.code' +
'    When 117 Then ''OUI''' +
'    ELSE ''NON''' +
'  End as indemnise,' +
'  ISNULL(SUM(pc.amount),0) as mt_reg_assure, ' +
'  Case ' +
'    When rcs.code = 117 ' +
'     Then coalesce(upper(rpm.short_label), ''REMP/REP'')' +
'    Else upper(rpm.short_label) ' +
'  End as mode_indemnisation ,' +
'  upper(rpm.long_label) as mode_indemnisation_long,' +
'  s.subscription_date as dte_adh,' +
'  c.declaration_date as dte_decl,' +
'  c.occurence_date as dte_surv' +
' ' +
'from ' + @sInstanceSaga2 + '.SAGA2_PVC.oth_cla.claim c ' +
'inner join ' + @sInstanceSaga2 + '.SAGA2_PVC.oth_sub.subscription s on s.id_subscription = c.id_subscription ' +
'inner join ' + @sInstanceSaga2 + '.SAGA2_PVC.ref.product p on p.id_product = s.id_product ' +
'inner join ' + @sInstanceSaga2 + '.SAGA2_PVC.ref.product_group pg on pg.id_product_group = p.id_product_group ' +
'inner join ' + @sInstanceSaga2 + '.SAGA2_PVC.ref.ref_claim_status rcs on rcs.id_ref_claim_status = c.id_ref_claim_status ' +
'left join ' + @sInstanceSaga2 + '.SAGA2_PVC.oth_cla.damaged_cover dc on dc.id_claim = c.id_claim ' +
'left join ' + @sInstanceSaga2 + '.SAGA2_PVC.ref.ref_benefit_type rbt on rbt.id_ref_benefit_type= dc.id_ref_benefit_type ' +
'left join ' + @sInstanceSaga2 + '.SAGA2_PVC.oth_cla.payment_claim pc on pc.id_claim = c.id_claim ' +
'left join ' + @sInstanceSaga2 + '.SAGA2_PVC.ref.ref_payment_type rpt on rpt.id_ref_payment_type = pc.id_ref_payment_type ' +
'LEFT join ' + @sInstanceSaga2 + '.SAGA2_PVC.ref.ref_payment_nature rpn on rpn.id_ref_payment_nature = pc.id_ref_payment_nature ' +
'left join ' + @sInstanceSaga2 + '.SAGA2_PVC.ref.ref_payment_status rps on rps.id_ref_payment_status = pc.ffl_ref_payment_status ' +
'LEFT join ' + @sInstanceSaga2 + '.SAGA2_PVC.ref.ref_payment_mode rpm on rpm.id_ref_payment_mode = pc.id_ref_payment_mode ' +
'LEFT join ' + @sInstanceSaga2 + '.SAGA2_PVC.ref.ref_payment_claim_status rpcs on rpcs.id_ref_payment_claim_status = pc.id_ref_payment_claim_status ' +
'where s.subscription_number = ''' + @asSubscriptionNumber + ''' ' +
' ' +
'group by c.spb_claim_number, ' +
's.subscription_number, ' +
'c.product_code, ' +
'p.long_label,pg.label,' +
'rps.long_label, ' +
'rpcs.long_label,' +
'rcs.code,' +
's.subscription_date ,' +
'c.declaration_date ,' +
'c.occurence_date ,' +
'c.id_claim , ' +
'rpm.long_label,rpm.short_label ' +
'order by dte_surv '

Exec ( @sSql ) 

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_MAJ_DES_BOUTIQUES_SAGA2_DANS_TABLE_BOUTIQUE_SIMPA2
-- Auteur               :       FABRY JF
-- Date                 :       25/06/2025
-- Libellé              :   [MIG147_KRYS]     
-- Commentaires         :       
-- Références           :       
--
-------------------------------------------------------------------
--  JFF   27/08/2025 [20250827140453367_MIG138]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_MAJ_DES_BOUTIQUES_SAGA2_DANS_TABLE_BOUTIQUE_SIMPA2' AND type = 'P' )
        DROP procedure sysadm.PS_MAJ_DES_BOUTIQUES_SAGA2_DANS_TABLE_BOUTIQUE_SIMPA2
GO

CREATE procedure sysadm.PS_MAJ_DES_BOUTIQUES_SAGA2_DANS_TABLE_BOUTIQUE_SIMPA2
	@asChaineSeria	VarChar ( 800 ) -- Si besoin
AS

Declare @sEnv VarChar ( 10 )
Declare @dcIdProd Decimal ( 7 )
Declare @sSql Varchar ( 3000 )
Declare @sInstanceSaga2 Varchar ( 50 )
Declare @iIdSeq integer
Declare @dcIdProdDp402 integer
Declare @sCodMagParentAlphaSaga2 VarChar ( 50 )
Declare @iNbreCtrle1 Integer
Declare @iNbreCtrle2 Integer
Declare @sMessage VarChar ( 500 )
Declare @sObjet VarChar ( 500 )
DECLARE      @return_value int,
             @asRetourErr varchar(255)


Set NoCount On;

Declare @TbTrt Table ( 
	id_seq Integer identity (1, 1 ),
	id_prod_dp402 integer,
	code_magasin_parent_alpha_saga2_dp402 VarChar ( 50 ),
	marquage int
)

If @@servername = master.dbo.SPB_FN_ServerName ('PRO') Set @sEnv = 'PRO' Else Set @sEnv = 'SIM'

If @sEnv = 'PRO' 
 Begin 
	Set @sInstanceSaga2 = '[LS-SAGA2]'
 End 
Else
 Begin
	-- [INSTANCE]
	If sysadm.FN_CLE_NUMERIQUE ( 'INSTANCE_PPR_REC_HUB') = 1
		Begin 
			Set @sInstanceSaga2 = '[S2SQL14DEV\RECSAGA2]' 
		End 
	Else
		Begin 
			Set @sInstanceSaga2 = '[S2SQL14PP1\PPRSAGA2]'
		End 	
 End 


-- Récup du param	
Insert into @TbTrt
Select	id_prod,
		sysadm.FN_CLE_VAL ( 'CODE_MAGASIN_PARENT_ALPHA_SAGA2', val_car, ';'),
		0
From sysadm.det_pro dp
Where dp.id_code_dp = 402

While Exists ( Select Top 1 1 From @TbTrt where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdProdDp402 = id_prod_dp402,
		@sCodMagParentAlphaSaga2 = code_magasin_parent_alpha_saga2_dp402
	From	@TbTrt
	Where	marquage = 0

	Set @sSql = 
	' Select s.id_selling_point ' +
	' from ' + @sInstanceSaga2 + '.saga2_pvc.crm.selling_point s ' +
	' inner join ' + @sInstanceSaga2 + '.saga2_pvc.crm.person p on p.id_person = s.id_person ' +
	' inner join ' + @sInstanceSaga2 + '.CRM_PRD.dbo.v_client c  on c.id_client = p.client_id ' +
	' left join ' + @sInstanceSaga2 + '.CRM_PRD.dbo.v_client_details c_email on c_email.id_client = c.id_client and c_email.ref_crm_client_details_type_code = 3 ' +
	' left join ' + @sInstanceSaga2 + '.CRM_PRD.dbo.v_client_details c_rib on c_rib.id_client = c.id_client and c_rib.ref_crm_client_details_type_code = 8 ' +
	' left join ' + @sInstanceSaga2 + '.CRM_PRD.dbo.v_client_details c_tel on c_tel.id_client = c.id_client and c_tel.ref_crm_client_details_type_code = 1 ' +
	' left join ' + @sInstanceSaga2 + '.CRM_PRD.dbo.v_address a on a.id_client = c.id_client  ' +
	' where s.id_parent in ( select id_selling_point from ' + @sInstanceSaga2 + '.SAGA2_PVC.crm.selling_point where code = ''' + @sCodMagParentAlphaSaga2 + ''' ) ' +
	' And s.is_active = 1 '

	Exec ( @sSql ) 
	Set @iNbreCtrle1 = @@ROWCOUNT

	Set @sSql = 
	' Select Distinct s.id_selling_point' +
	' from ' + @sInstanceSaga2 + '.saga2_pvc.crm.selling_point s ' +
	' inner join ' + @sInstanceSaga2 + '.saga2_pvc.crm.person p on p.id_person = s.id_person ' +
	' inner join ' + @sInstanceSaga2 + '.CRM_PRD.dbo.v_client c  on c.id_client = p.client_id ' +
	' left join ' + @sInstanceSaga2 + '.CRM_PRD.dbo.v_client_details c_email on c_email.id_client = c.id_client and c_email.ref_crm_client_details_type_code = 3 ' +
	' left join ' + @sInstanceSaga2 + '.CRM_PRD.dbo.v_client_details c_rib on c_rib.id_client = c.id_client and c_rib.ref_crm_client_details_type_code = 8 ' +
	' left join ' + @sInstanceSaga2 + '.CRM_PRD.dbo.v_client_details c_tel on c_tel.id_client = c.id_client and c_tel.ref_crm_client_details_type_code = 1 ' +
	' left join ' + @sInstanceSaga2 + '.CRM_PRD.dbo.v_address a on a.id_client = c.id_client  ' +
	' where s.id_parent in (select id_selling_point from ' + @sInstanceSaga2 + '.SAGA2_PVC.crm.selling_point where code = ''' + @sCodMagParentAlphaSaga2 + ''' ) ' +
	' And s.is_active = 1 '

	Exec ( @sSql ) 
	Set @iNbreCtrle2 = @@ROWCOUNT

	IF @iNbreCtrle1 > 0 And @iNbreCtrle1 <> @iNbreCtrle2
		Begin

			set @sObjet = @@SERVERNAME + ' problème maj boutique SAGA2 vers SIMPA2'
			Set @sMessage = 'PS_MAJ_DES_BOUTIQUES_SAGA2_DANS_TABLE_BOUTIQUE_SIMPA2, code ' + @sCodMagParentAlphaSaga2 + ', Problème de clé distinct'

			EXEC   @return_value = master.[dbo].[SPB_PS_MAIL]
						 @asRetourErr = @asRetourErr OUTPUT,
						 @asTo = N'jfabry@spb.eu',
						 @asTextBody = @sMessage,
						 @asSubject = @sObjet,
						 @asFrom = null,
						 @asCc = NULL,
						 @asFicAttach = NULL,
						 @asQuery = NULL,
						 @asFicQueryOut = NULL,
						 @aiTypeQuery = NULL,
						 @asNomBaseQuery = NULL,
						 @asBcc = NULL

			Update @TbTrt Set marquage = 1 Where id_seq = @iIdSeq
			Continue
		end 

	If	@iNbreCtrle1 <= 0
		Begin
			set @sObjet = @@SERVERNAME + ' problème maj boutique SAGA2 vers SIMPA2'
			Set @sMessage = 'PS_MAJ_DES_BOUTIQUES_SAGA2_DANS_TABLE_BOUTIQUE_SIMPA2, code ' + @sCodMagParentAlphaSaga2 + ', Pas de boutique provenant de SAGA2'

			EXEC   @return_value = master.[dbo].[SPB_PS_MAIL]
						 @asRetourErr = @asRetourErr OUTPUT,
						 @asTo = N'jfabry@spb.eu',
						 @asTextBody = @sMessage,
						 @asSubject = @sObjet,
						 @asFrom = null,
						 @asCc = NULL,
						 @asFicAttach = NULL,
						 @asQuery = NULL,
						 @asFicQueryOut = NULL,
						 @aiTypeQuery = NULL,
						 @asNomBaseQuery = NULL,
						 @asBcc = NULL

			Update @TbTrt Set marquage = 1 Where id_seq = @iIdSeq
			Continue
		End 

	-- Si pas ligne, on laisse ainsi, on ne delete pas, mieux d'ancienne boutique, que plus de boutique du tout.
	If @iNbreCtrle1 > 0  
		Begin 

			-- Delete Table boutique pour le produit ici
			-- Suppression de la boutiques
			Delete sysadm.boutique Where id_prod = @dcIdProdDp402

			Set @sSql = 
			' Select ' + Convert ( VarChar ( 10 ), @dcIdProdDp402) + ', ' + -- id_prod
			'    s.id_selling_point, ' +  -- id_boutique => id_magasin_saga2
			'    ''MAJ_AUTO_DP402_PAS_DE_MAJ_MANUELLE!'',' + -- region 
			'    Left ( ltrim ( rtrim ( a.city )), 35 ), ' + -- adr_ville
			'    Left ( ltrim ( rtrim ( a.zip_code )), 5 ) , ' +  -- adr_cp
			'    Left ( ltrim ( rtrim ( c_tel.value )), 20 ), ' + -- adr_tel, 
			'    null, ' + -- adr_fax
			'    Left ( ltrim ( rtrim ( c_email.value )), 250 ),' +   -- adr_mail
			'    null, ' + -- adr_mail_cc,
			'    Left ( ltrim ( rtrim ( s.name )), 35 ),' + -- adr_nom,
			'    Left ( ltrim ( rtrim ( s.code )), 20 ),' + -- cod_mag,
			'    Left ( Concat ( ltrim ( rtrim ( a.complement_adr1)), '' '' ,ltrim ( rtrim ( a.complement_adr2 )), '' '', ltrim ( rtrim ( a.complement_adr3 )), '' '', ltrim ( rtrim ( a.complement_adr4 ))), 40 ), ' +  -- adr_1,
			'    Substring ( Concat ( ltrim ( rtrim ( a.complement_adr1 )), '' '' , ltrim ( rtrim ( a.complement_adr2 )) , '' '', ltrim ( rtrim ( a.complement_adr3 )), '' '', ltrim ( rtrim ( a.complement_adr4 )) ), 41, 40 ), ' +   -- adr_2,
			'    null, ' + -- responsable,
			'    null, ' + -- adr_mail2,
			'    null, ' + -- adr_mail_cc2,
			'    substring ( c_rib.value, 5, 5 ), ' + -- rib_bq,
			'    substring ( c_rib.value, 10, 5 ), ' + -- rib_gui,
			'    substring ( c_rib.value, 15, 11 ), ' + -- rib_cpt,
			'    substring ( c_rib.value, 26, 2 ), ' + -- rib_cle,
			'    Getdate (), ' + -- cree_le,
			'    Getdate (), ' + -- maj_le,
			'    ''AUTO'', ' +  -- maj_par,
			'    null, ' + -- lib_police,
			'    null ' + -- id_four_fact
			' ' + 
			' from ' + @sInstanceSaga2 + '.saga2_pvc.crm.selling_point s ' + 
			' inner join ' + @sInstanceSaga2 + '.saga2_pvc.crm.person p on p.id_person = s.id_person ' +
			' inner join ' + @sInstanceSaga2 + '.CRM_PRD.dbo.v_client c  on c.id_client = p.client_id ' +
			' left join ' + @sInstanceSaga2 + '.CRM_PRD.dbo.v_client_details c_email on c_email.id_client = c.id_client and c_email.ref_crm_client_details_type_code = 3 ' +
			' left join ' + @sInstanceSaga2 + '.CRM_PRD.dbo.v_client_details c_rib on c_rib.id_client = c.id_client and c_rib.ref_crm_client_details_type_code = 8 ' +
			' left join ' + @sInstanceSaga2 + '.CRM_PRD.dbo.v_client_details c_tel on c_tel.id_client = c.id_client and c_tel.ref_crm_client_details_type_code = 1 ' +
			' left join ' + @sInstanceSaga2 + '.CRM_PRD.dbo.v_address a on a.id_client = c.id_client  ' +
			' where s.id_parent in (select id_selling_point from ' + @sInstanceSaga2 + '.SAGA2_PVC.crm.selling_point where code = ''' + @sCodMagParentAlphaSaga2 + ''' ) ' +
			' And s.is_active = 1 ' +
			' Order by 2 ' 
--			Exec ( @sSql ) 
			Insert into sysadm.boutique Exec ( @sSql ) 
			
			-- [20250827140453367_MIG138]
			Set @sSql = 'Update sysadm.boutique Set ' + 
						'adr_ville = Upper ( sysadm.FN_EPURE_CHAINE_V02 ( adr_ville , ''NATIF&RC_TAB_DQ'' )), ' +
						'adr_cp = Upper ( sysadm.FN_EPURE_CHAINE_V02 ( adr_cp, ''NATIF&RC_TAB_DQ'' )), ' +
						'adr_tel = sysadm.FN_EPURE_CHAINE_V02 ( adr_tel, ''NATIF&RC_TAB_DQ'' ), ' +
						'adr_mail = Lower ( sysadm.FN_EPURE_CHAINE_V02 ( adr_mail, ''NATIF&RC_TAB_DQ'' )), ' +
						'adr_nom = Upper ( sysadm.FN_EPURE_CHAINE_V02 ( adr_nom, ''NATIF&RC_TAB_DQ'' )), ' +
						'cod_mag = Upper ( sysadm.FN_EPURE_CHAINE_V02 ( cod_mag, ''NATIF&RC_TAB_DQ'' )), ' +
						'adr_1 = Upper ( sysadm.FN_EPURE_CHAINE_V02 ( adr_1, ''NATIF&RC_TAB_DQ'' )), ' +
						'adr_2 = Upper ( sysadm.FN_EPURE_CHAINE_V02 ( adr_2, ''NATIF&RC_TAB_DQ'' )), ' +
						'rib_bq = sysadm.FN_EPURE_CHAINE_V02 ( rib_bq, ''NATIF&RC_TAB_DQ'' ), ' +
						'rib_gui = sysadm.FN_EPURE_CHAINE_V02 ( rib_gui, ''NATIF&RC_TAB_DQ'' ), ' +
						'rib_cpt = Upper ( sysadm.FN_EPURE_CHAINE_V02 ( rib_cpt, ''NATIF&RC_TAB_DQ'' )), ' +
						'rib_cle = sysadm.FN_EPURE_CHAINE_V02 ( rib_cle, ''NATIF&RC_TAB_DQ'' ) ' +
						'Where id_prod = ' + Convert ( VarChar ( 10 ), @dcIdProdDp402)
			Exec ( @sSql ) 

		End

	Update @TbTrt Set marquage = 1 Where id_seq = @iIdSeq
 End

Go


