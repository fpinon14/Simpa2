-------------------------------------------------------------------
--
-- Fichier              :       DT432.CP
-- Auteur               :       FABRY JF
-- Date                 :       06/10/2020
--								[DT432]
-- Commentaires         :       
--
-- sysadm.PS_I_DT432_CREATION_DOSSIER_AUTO
-- sysadm.PS_I_DT432_INSERT_PROV_ETL
-- sysadm.PS_S_DT432_ENVOI_MAIL_LOG_ERREUR
-- sysadm.PS_S_DT432_ETAT_MENSUEL
-- sysadm.PS_S_DT432_LECT_LOG_PAR_ETL_APRES_TRT
-- sysadm.PS_SU_DT432_ETAT_QUOTIDIEN_REGLES 
-- sysadm.PS_SU_DT432_RECUP_ID_INTEGRATION
-- sysadm.PS_U_DT432_CONTROLE_DONNEES
-- sysadm.PS_U_DT432_ERREUR_TRT
-- sysadm.PS_U_DT432_MARQUAGE_LOG_PAR_ETL_APRES_TRT
-- sysadm.PS_U_DT432_TRAITEMENT
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure            :       PS_SU_DT432_RECUP_ID_INTEGRATION
-- Auteur               :       JFF
-- Date                 :       06/10/2020
-- Libelle              :       
-- Commentaires         :       [DT432]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Integer : ID intégration
-------------------------------------------------------------------
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SU_DT432_RECUP_ID_INTEGRATION' AND type = 'P' )
        DROP procedure sysadm.PS_SU_DT432_RECUP_ID_INTEGRATION
GO

CREATE procedure sysadm.PS_SU_DT432_RECUP_ID_INTEGRATION
As 

Declare @dcCptVal   Decimal ( 10 )
Declare @iIdLotIntgr  Integer

Exec sysadm.PS_X_INCREMENTER 'IDINTDT432', @dcCptVal OUTPUT
Set @iIdLotIntgr = @dcCptVal 
	
Return @iIdLotIntgr 

Go 


--------------------------------------------------------------------
--
-- Procedure            :       PS_I_DT432_INSERT_PROV_ETL
-- Auteur               :       JFF
-- Date                 :       06/10/2020
-- Libelle              :       
-- Commentaires         :       [DT432]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Integer : 1 succès d'intégration / -1 Echec d'intégration
-------------------------------------------------------------------
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DT432_INSERT_PROV_ETL' AND type = 'P' )
        DROP procedure sysadm.PS_I_DT432_INSERT_PROV_ETL
GO

CREATE procedure sysadm.PS_I_DT432_INSERT_PROV_ETL
@asIdProjet		varchar(35),
@aiIdLotIntegr   integer,
@asIdSinEmetteur varchar(35),
@asIdNumFicEmetteur varchar(20),
@adcIdProd		decimal(7),
@adcIdEts		decimal(7),
@asIdAdh		char(19),  
@adcIdsDos		decimal(2),
@adcCoptOpt     decimal (2),
@adtDteOpt        varchar (20),
@adcIdNatSin		varchar(20),
@adcIdTerrit		varchar(20),
@adcIdDetSin		varchar(20),
@adtDteDecl		varchar(20),
@adtDteSurv		varchar(20),
@asHeuSurv		varchar(4),   
@adtDteOppo		varchar(20),
@adtDteUtil		varchar(20),
@adtDteAdh		varchar(20),
@adtDteResil		varchar(20),
@adtDteFinGti		varchar(20),
@asCodCiv		varchar(1),   
@asNom			varchar(35),  
@asPrenom		varchar(35),  
@adtDteNais		varchar (20),
@asAdr1			varchar(35),  
@asAdr2			varchar(35),  
@asAdrCp		varchar(5),   
@asAdrVille		varchar(35),  
@asNumTeld		varchar(20),  
@adcIdGti		decimal(7),
@asIban			varchar (50),
@asAdrMail		varchar(200),
@adcIdEvt		varchar(20),
@adcMtPrej		varchar(20),
@asStatutEmetteur	varchar (35),
@adcMtUfChargeSpb	varchar(20),
@adcMtFranChargeAssure	varchar(20),
@aiMotifRefusEmetteur	varchar(20)
As

Declare @sEtatTrt  VarChar ( 30 )
Declare @sEtatLog  VarChar ( 30 )

Set @sEtatTrt = 'INTEGRATION_PROV_ETL'
Set @sEtatLog = 'NON_LU_PAR_ETL'

-- On intègre en l'état les données provenant de l'ETL
Insert into sysadm.dossier_auto_DT432 ( 
	id_projet,
	id_lot_intrg,
	id_sin_emetteur,
	id_num_fic_emetteur,
	id_prod,
	id_ets,
	id_adh,
	id_sdos,
	cod_opt,
	dte_opt,
	id_natsin,
	id_territ,
	id_detsin,
	dte_decl,
	dte_surv,
	heu_surv,
	dte_oppo,
	dte_util,
	dte_adh,
	dte_resil,
	dte_fin_gti,
	cod_civ,
	nom,
	prenom,
	dte_nais,
	adr_1,
	adr_2,
	adr_cp,
	adr_ville,
	num_teld,
	id_gti,
	iban,
	adr_mail,
	id_evt,
	mt_prej,
	statut_emetteur,
	mt_uf_charge_spb,
	mt_fran_charge_assure,
	motif_refus_emetteur,
	id_sin,
	dte_integr,
	mt_reg_spb,
	motif_refus_spb,
	comment_refus_spb,
	etat_trt,
    cree_le,
    cree_par,
    traite_le,
    traite_par,
	etat_log,
    log_lu_le
	)

	Values 
	
	(
	rtrim ( ltrim ( @asIdProjet )),
	@aiIdLotIntegr,
	rtrim ( ltrim ( @asIdSinEmetteur )),
	rtrim ( ltrim ( @asIdNumFicEmetteur )),
	rtrim ( ltrim ( @adcIdProd )),
	rtrim ( ltrim ( @adcIdEts )),
	rtrim ( ltrim ( @asIdAdh )),
	rtrim ( ltrim ( @adcIdsDos )),
	rtrim ( ltrim ( @adcCoptOpt )),
	rtrim ( ltrim ( @adtDteOpt )),
	rtrim ( ltrim ( @adcIdNatSin )),
	rtrim ( ltrim ( @adcIdTerrit )),
	rtrim ( ltrim ( @adcIdDetSin )),
	rtrim ( ltrim ( @adtDteDecl )),
	rtrim ( ltrim ( @adtDteSurv )),
	rtrim ( ltrim ( @asHeuSurv )),
	rtrim ( ltrim ( @adtDteOppo )),
	rtrim ( ltrim ( @adtDteUtil )),
	rtrim ( ltrim ( @adtDteAdh )),
	rtrim ( ltrim ( @adtDteResil )),
	rtrim ( ltrim ( @adtDteFinGti )),
	rtrim ( ltrim ( @asCodCiv )),
	rtrim ( ltrim ( @asNom )),
	rtrim ( ltrim ( @asPrenom )),
	rtrim ( ltrim ( @adtDteNais)),
	rtrim ( ltrim ( @asAdr1 )),
	rtrim ( ltrim ( @asAdr2 )),
	rtrim ( ltrim ( @asAdrCp )),
	rtrim ( ltrim ( @asAdrVille )),
	rtrim ( ltrim ( @asNumTeld )),
	rtrim ( ltrim ( @adcIdGti )),
	rtrim ( ltrim ( @asIban )),
	rtrim ( ltrim ( @asAdrMail )),
	rtrim ( ltrim ( @adcIdEvt )),
	rtrim ( ltrim ( @adcMtPrej )),
	rtrim ( ltrim ( @asStatutEmetteur )),
	rtrim ( ltrim ( @adcMtUfChargeSpb )),
	rtrim ( ltrim ( @adcMtFranChargeAssure )),
	rtrim ( ltrim ( @aiMotifRefusEmetteur )),
	null,
	Getdate(),
	0,
	0,
	null,
	rtrim ( ltrim ( @sEtatTrt )),
	Getdate(),
	'ETL',
	null,
	null,
	rtrim ( ltrim ( @sEtatLog )),
	null
	)

If @@ROWCOUNT <> 1 Return -1

Return 1

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_U_DT432_TRAITEMENT
-- Auteur               :       JFF
-- Date                 :       06/10/2020
-- Libelle              :       
-- Commentaires         :       [DT432]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- [DT432_ISM261862]  JFF 12/04/2022
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_DT432_TRAITEMENT' AND type = 'P' )
        DROP procedure sysadm.PS_U_DT432_TRAITEMENT
GO

CREATE procedure sysadm.PS_U_DT432_TRAITEMENT

AS 

-- Moteur de traitement qui créé les dossiers du DT432 BRED

Declare 
@iIdSeq     Integer,
@iRet		Integer,	
@dcCptVal   Decimal ( 10 ),
@iIdLotTrt  Integer

-- Les lignes à traiter sont en état INTEGRATION_PROV_ETL
-- Je les passe en EN_COURS_TRT

Update sysadm.dossier_auto_DT432 Set etat_trt = 'EN_COURS_TRT' Where id_projet = 'DT432' And etat_trt = 'INTEGRATION_PROV_ETL'

Exec sysadm.PS_X_INCREMENTER 'IDLOTDT432', @dcCptVal OUTPUT
Set @iIdLotTrt = @dcCptVal 

Update sysadm.dossier_auto_DT432 Set id_lot_trt = @iIdLotTrt where etat_trt = 'EN_COURS_TRT' and id_projet = 'DT432' 

-- Le moteur de traitement démarre
While Exists ( Select Top 1 1 From sysadm.dossier_auto_DT432 where etat_trt = 'EN_COURS_TRT' )
 Begin
	-- On pioche un dossier  (dans l'ordre d'arrivée)
	Select 	Top 1 @iIdSeq = da.id_seq
	From sysadm.dossier_auto_DT432 da 
	where da.etat_trt = 'EN_COURS_TRT'
	And   da.id_seq = ( Select MIN ( da2.id_seq ) From sysadm.dossier_auto_DT432 da2 where da2.etat_trt = da.etat_trt )

	---------------------------------
	--     Contrôle des données    --
	---------------------------------
	Exec @iRet = sysadm.PS_U_DT432_CONTROLE_DONNEES @iIdSeq
	If @iRet < 0 Continue

	-----------------------------------------------------
	-- Traitement de la demande de création de dossier --
	-----------------------------------------------------
	-- [DT432_ISM261862]
	Exec @iRet = sysadm.PS_I_DT432_CREATION_DOSSIER_AUTO_V01 @iIdSeq  

	If @iRet < 0 Continue

	-- Mise à jour de l'enregistrement en TRAITE_SUCCES
	Update sysadm.dossier_auto_DT432 Set etat_trt = 'TRAITE_SUCCES', traite_le = GETDATE(), traite_par = 'SQLS' Where id_seq = @iIdSeq
 End

Exec sysadm.PS_S_DT432_ENVOI_MAIL_LOG_ERREUR

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_DT432_CONTROLE_DONNEES
-- Auteur               :       JFF
-- Date                 :       06/10/2020
-- Libelle              :       
-- Commentaires         :       [DT432]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- 05/08/2021 JFF [RS882]
-- 07/12/2021 JFF [20211207163000] Suppression des zéros devant les données numériques
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_DT432_CONTROLE_DONNEES' AND type = 'P' )
        DROP procedure sysadm.PS_U_DT432_CONTROLE_DONNEES
GO

CREATE procedure sysadm.PS_U_DT432_CONTROLE_DONNEES
	@aiIdSeq	integer
AS 

Declare 
@sIdProjet		varchar(35),
@sIdSinEmetteur varchar(35),
@sIdNumFicEmetteur varchar(20),
@dcIdProd		decimal(7),
@dcIdEts		decimal(7),
@sIdAdh		char(19),  
@dcIdsDos		decimal(2),
@dcCodOpt		decimal(2),
@dtDteOpt        varchar (20),
@dcIdNatSin		varchar(20),
@dcIdTerrit		varchar(20),
@dcIdDetSin		varchar(20),
@dtDteDecl		varchar(20),
@dtDteSurv		varchar(20),
@sHeuSurv		char(4),   
@dtDteOppo		varchar(20),
@dtDteUtil		varchar(20),
@dtDteAdh		varchar(20),
@dtDteResil		varchar(20),
@dtDteFinGti	varchar(20),
@sCodCiv		varchar(1),   
@sNom			varchar(35),  
@sPrenom		varchar(35),  
@sAdr1			varchar(35),  
@sAdr2			varchar(35),  
@sAdrCp		varchar(5),   
@sAdrVille		varchar(35),  
@sNumTeld		varchar(20),  
@dcIdGti		decimal(7),
@sIban			varchar (50),
@sAdrMail		varchar(200),
@dcIdEvt		varchar(20),
@dcMtPrej		varchar(20),
@sStatutEmetteur	varchar (35),
@dcMtUfChargeSpb	varchar(20),
@dcMtFranChargeAssure	varchar(20),
@iMotifRefusEmetteur	varchar(20),
@sCommentRefusSpb  VarChar ( 255 ),
@sValWrk  Varchar ( 50 ),
@sRibBq Varchar ( 5 ),
@sRibGui Varchar ( 5 ),
@sRibCpt Varchar ( 11),
@sRibCle Varchar ( 2 ),
@sNbreIdFiBred Varchar ( 250 )

-- On récupère les données de l'ID_SEQ de référence.
Select 	Top 1 
	@sIdProjet = rtrim( ltrim ( id_projet )),
	@sIdSinEmetteur = rtrim( ltrim ( id_sin_emetteur )),
	@sIdNumFicEmetteur = rtrim( ltrim ( id_num_fic_emetteur )),
	@dcIdProd = rtrim( ltrim ( id_prod )),
	@dcIdEts = rtrim( ltrim ( id_ets )),
	@sIdAdh = rtrim( ltrim ( id_adh )),
	@dcIdsDos = rtrim( ltrim ( id_sdos )),
	@dcCodOpt = rtrim( ltrim ( cod_opt )),
	@dtDteOpt = rtrim( ltrim ( dte_opt )),
	@dcIdNatSin = rtrim( ltrim ( id_natsin )),
	@dcIdTerrit = rtrim( ltrim ( id_territ )),
	@dcIdDetSin = rtrim( ltrim ( id_detsin )),
	@dtDteDecl = rtrim( ltrim ( dte_decl )),
	@dtDteSurv = rtrim( ltrim ( dte_surv )),
	@sHeuSurv = rtrim( ltrim ( heu_surv )),
	@dtDteOppo = rtrim( ltrim ( dte_oppo )),
	@dtDteUtil = rtrim( ltrim ( dte_util )),
	@dtDteAdh = rtrim( ltrim ( dte_adh )),
	@dtDteResil = rtrim( ltrim ( dte_resil )),
	@dtDteFinGti = rtrim( ltrim ( dte_fin_gti )),
	@sCodCiv = rtrim( ltrim ( cod_civ )),
	@sNom = rtrim( ltrim ( nom )),
	@sPrenom = rtrim( ltrim ( prenom )),
	@sAdr1 = rtrim( ltrim ( adr_1 )),
	@sAdr2 = rtrim( ltrim ( adr_2 )),
	@sAdrCp = rtrim( ltrim ( adr_cp )),
	@sAdrVille = rtrim( ltrim ( adr_ville )),
	@sNumTeld = rtrim( ltrim ( num_teld )),
	@dcIdGti = rtrim( ltrim ( id_gti )),
	@sIban = rtrim( ltrim ( iban )),
	@sAdrMail = rtrim( ltrim ( adr_mail )),
	@dcIdEvt = rtrim( ltrim ( id_evt )),
	@dcMtPrej = rtrim( ltrim ( mt_prej )),
	@sStatutEmetteur = rtrim( ltrim ( statut_emetteur )),
	@dcMtUfChargeSpb = rtrim( ltrim ( mt_uf_charge_spb )),
	@dcMtFranChargeAssure = rtrim( ltrim ( mt_fran_charge_assure )),
	@iMotifRefusEmetteur  = rtrim( ltrim ( motif_refus_emetteur )) 
From sysadm.dossier_auto_DT432 da 
where da.id_seq = @aiIdSeq

-- En premier contrôle, s'il existe dans la table au moins un id_fic_emmeteur déjà traité, c
-- c'est que ce fichier a déjà été traité et je rejette.
   IF Exists ( 
		Select Tb.id_num_fic_emetteur,
			   Count (*)
		From ( 							
 				Select Distinct
						da.id_num_fic_emetteur,
						da.id_lot_intrg
				From sysadm.dossier_auto_DT432 da 
			) as Tb
		Group By Tb.id_num_fic_emetteur
		Having Count (*) > 1
   )
		Begin
			Select @sNbreIdFiBred = 
				stuff ( ( SELECT Distinct ', IdFicBRED=' + CAST(rtrim ( Tb.id_num_fic_emetteur ) AS VARCHAR(250)) + '/NbreFois=' + CAST(rtrim ( Tb.Nbre ) AS VARCHAR(250) ) 
							 From  (
									Select Tb.id_num_fic_emetteur,
										   Count (*) Nbre
									From ( 							
 											Select Distinct
													da.id_num_fic_emetteur,
													da.id_lot_intrg
											From sysadm.dossier_auto_DT432 da 
										) as Tb
									Group By Tb.id_num_fic_emetteur
									Having Count (*) > 1
									) as Tb
							 For XML PATH ('') ), 1, 2, '' 
						 )  
			If @sNbreIdFiBred is null Set @sNbreIdFiBred = ''
			If @sNbreIdFiBred = '' Set @sNbreIdFiBred = 'Faux problème'

			Set @sCommentRefusSpb = 'L''identifiant de fichier BRED a déjà été intégré sur un précédent traitement (Valeur erreur à décoder : '+ @sNbreIdFiBred + ').'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 

-- L'identifiant sinistre emetteur est-il présent
	If @sIdSinEmetteur is null Or LTRIM ( rtrim ( @sIdSinEmetteur )) = ''
		Begin
			Set @sCommentRefusSpb = 'L''identifiant sinistre assuré provenant de l''émetteur est une donnée obligatoire.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 4, @sCommentRefusSpb 
			Return -1
		End 

-- L'identifiant du fichier emetteur est-il présent
	If @sIdNumFicEmetteur is null Or LTRIM ( rtrim ( @sIdNumFicEmetteur )) = ''
		Begin
			Set @sCommentRefusSpb = 'L''identifiant de fichier (le numéro de fichier) provenant de l''émetteur est une donnée obligatoire.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 4, @sCommentRefusSpb 
			Return -1
		End

-- L'identifiant du fichier emetteur est-il bien un numérique ?
	If ISNUMERIC ( @sIdNumFicEmetteur ) = 0 
		Begin
			Set @sCommentRefusSpb = 'L''identifiant de fichier (le numéro de fichier) provenant de l''émetteur doit être une donnée numérique.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 

-- Le code produit a-t-il l'option pilote 354
	If Not Exists ( 
		Select top 1 1 From sysadm.det_pro with (nolock) where id_prod = @dcIdProd and id_code_dp = 354
	)
		Begin
			Set @sCommentRefusSpb = 'Le produit ' + Convert ( Varchar ( 20), @dcIdProd ) + ' n''a pas l''option 354, il ne fait pas parti de ce traitement.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 101, @sCommentRefusSpb 
			Return -1
		End 


-- l'ETS donné est-il paramétré sur le produit
	If Not Exists ( 
		Select Top 1 1 From sysadm.etablissement with (nolock) Where id_prod = @dcIdProd and id_ets = @dcIdEts
	)
		Begin
			Set @sCommentRefusSpb = 'L''établissement ' + Convert ( Varchar ( 20), @dcIdEts ) + ' n''est pas paramétré sur le produit ' + Convert ( Varchar ( 20), @dcIdProd ) + '.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 102, @sCommentRefusSpb 
			Return -1
		End 

-- L'adhésion est-elle bien un numérique (donc provenant de FFM)
	If ISNUMERIC ( @sIdAdh ) = 0 Or @sIdAdh is null Or LTRIM ( rtrim ( @sIdAdh )) = ''
		Begin
			If @sIdAdh is null Set @sIdAdh = ''
			Set @sCommentRefusSpb = 'L''adhésion (' + @sIdAdh + ') provenant de FFM doit être une donnée numérique.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 201, @sCommentRefusSpb 
			Return -1
		End
	Else -- [20211207163000]
	    Begin
			Update sysadm.dossier_auto_DT432 Set id_adh = Convert ( Varchar (19), convert ( integer, @sIdAdh )) where id_seq = @aiIdSeq
		End  

-- Le sous-dossier doit être positif
	If @dcIdsDos <=0 
		Begin
			Set @sCommentRefusSpb = 'Le sous-dossier provenant de FFM doit être une donnée numérique positive.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 202, @sCommentRefusSpb 
			Return -1
		End 

-- Le code option doit être positif
	If @dcCodOpt <=0 
		Begin
			Set @sCommentRefusSpb = 'Le code option provenant de FFM doit être une donnée numérique positive.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 206, @sCommentRefusSpb 
			Return -1
		End 

-- La date d'option
	-- La date d'option est-elle une date valide ? si elle est renseignée
	If @dtDteOpt is not Null And LTRIM ( rtrim ( @dtDteOpt )) <> ''
	  Begin
		If sysadm.FN_IS_DATE ( @dtDteOpt ) = 0 
			Begin
				If @dtDteAdh is null Set @dtDteAdh = ''
				Set @sCommentRefusSpb = 'La date d''option (' + @dtDteOpt + ') de l''adhésion provenant de FFM doit être une date valide.'
				Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 207, @sCommentRefusSpb 
				Return -1
			End 
	  End

-- La nature de sinistre 
	-- La nature de sinistre doit être une donnée numérique.
	If @dcIdNatSin is null Or LTRIM ( rtrim ( @dcIdNatSin )) = ''
		Begin
			If @dcIdNatSin is null Set @dcIdNatSin = ''
			Set @sCommentRefusSpb = 'La nature de sinistre (' + @dcIdNatSin + ') provenant de l''émetteur est une donnée obligatoire.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 4, @sCommentRefusSpb 
			Return -1
		End 

	If ISNUMERIC ( @dcIdNatSin ) = 0
		Begin
			If @dcIdNatSin is null Set @dcIdNatSin = ''
			Set @sCommentRefusSpb = 'La nature de sinistre (' + @dcIdNatSin + ') provenant de l''émetteur doit être une donnée numérique positive.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 

	-- La nature de sinistre doit être une donnée positive.
	If CONVERT ( decimal ( 7), @dcIdNatSin ) <= 0 
		Begin
			If @dcIdNatSin is null Set @dcIdNatSin = ''
			Set @sCommentRefusSpb = 'La nature de sinistre (' + @dcIdNatSin + ') provenant de l''émetteur doit être une donnée numérique positive.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 

	-- La nature de sinistre doit exister chez SPB
	If Not Exists ( 
		Select top 1 1 From sysadm.code where id_typ_code = '+NS' and id_code = CONVERT ( decimal ( 7), @dcIdNatSin ) 
	)
		Begin
			If @dcIdNatSin is null Set @dcIdNatSin = ''
			Set @sCommentRefusSpb = 'La nature de sinistre (' + @dcIdNatSin + ') provenant de l''émetteur n''existe pas chez spb.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 

	-- La nature de sinistre doit exister sur le paramètrage du produit
	If Not Exists ( 
		Select Top 1 1 From sysadm.code_condition with (nolock) Where id_prod = @dcIdProd and id_typ_code = '+NS' and id_code = CONVERT ( decimal ( 7), @dcIdNatSin )
	)
		Begin
			Set @sCommentRefusSpb = 'La nature de sinistre ' + @dcIdNatSin + ' n''est pas paramétrée sur le produit ' + Convert ( Varchar ( 20), @dcIdProd ) + '.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 103, @sCommentRefusSpb 
			Return -1
		End 

-- La territorialité 
	-- La territorialité doit être une donnée numérique.
	If @dcIdTerrit is null Or LTRIM ( rtrim ( @dcIdTerrit )) = ''
		Begin
			If @dcIdTerrit is null Set @dcIdTerrit = ''
			Set @sCommentRefusSpb = 'La territorialité (' + @dcIdTerrit + ') provenant de l''émetteur est une donnée obligatoire.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 4, @sCommentRefusSpb 
			Return -1
		End 

	-- La territorialité doit être une donnée numérique.
	If ISNUMERIC ( @dcIdTerrit ) = 0 
		Begin
			If @dcIdTerrit is null Set @dcIdTerrit = ''
			Set @sCommentRefusSpb = 'La territorialité (' + @dcIdTerrit + ') provenant de l''émetteur doit être une donnée numérique positive.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 

	-- La territorialité doit être une donnée positive.
	If CONVERT ( decimal ( 7), @dcIdTerrit ) <= 0 
		Begin
			If @dcIdTerrit is null Set @dcIdTerrit = ''
			Set @sCommentRefusSpb = 'La territorialité (' + @dcIdTerrit + ') provenant de l''émetteur doit être une donnée numérique positive.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 

	-- La territorialité doit exister chez SPB
	If Not Exists ( 
		Select top 1 1 From sysadm.code with (nolock) where id_typ_code = '+TR' and id_code = CONVERT ( decimal ( 7), @dcIdTerrit ) 
	)
		Begin
			If @dcIdTerrit is null Set @dcIdTerrit = ''
			Set @sCommentRefusSpb = 'La territorialité (' + @dcIdTerrit + ') provenant de l''émetteur n''existe pas chez spb.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 

	-- La territorialité doit exister sur le paramètrage du produit
	If Not Exists ( 
		Select Top 1 1 From sysadm.code_condition with (nolock) Where id_prod = @dcIdProd and id_typ_code = '+TR' and id_code = CONVERT ( decimal ( 7), @dcIdTerrit )
	)
		Begin
			Set @sCommentRefusSpb = 'La territorialité ' + @dcIdTerrit + ' doit être paramétrée sur le produit ' + Convert ( Varchar ( 20), @dcIdProd ) + '.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 103, @sCommentRefusSpb 
			Return -1
		End 

-- Le détail sinistre
	-- Le détail sinistre doit être une donnée numérique.
	If @dcIdDetSin is null Or LTRIM ( rtrim ( @dcIdDetSin )) = ''
		Begin
			If @dcIdDetSin is null Set @dcIdDetSin = ''
			Set @sCommentRefusSpb = 'Le détail sinistre (' + @dcIdDetSin + ') provenant de l''émetteur est une donnée obligatoire.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 4, @sCommentRefusSpb 
			Return -1
		End 
			 
 	-- Le détail sinistre doit être une donnée numérique.
	If  ISNUMERIC ( @dcIdDetSin ) = 0 
		Begin
			If @dcIdDetSin is null Set @dcIdDetSin = ''
			Set @sCommentRefusSpb = 'Le détail sinistre (' + @dcIdDetSin + ') provenant de l''émetteur doit être une donnée numérique positive.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 

	-- Le détail sinistre doit être une donnée positive.
	If CONVERT ( decimal ( 7), @dcIdDetSin ) <= 0 
		Begin
			If @dcIdDetSin is null Set @dcIdDetSin = ''
			Set @sCommentRefusSpb = 'Le détail sinistre (' + @dcIdDetSin + ') provenant de l''émetteur doit être une donnée numérique positive.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 

	-- Le détail sinistre doit exister chez SPB
	If Not Exists ( 
		Select top 1 1 From sysadm.code where id_typ_code = '+DT' and id_code = CONVERT ( decimal ( 7), @dcIdDetSin ) 
	)
		Begin
			If @dcIdDetSin is null Set @dcIdDetSin = ''
			Set @sCommentRefusSpb = 'Le détail sinistre (' + @dcIdDetSin + ') provenant de l''émetteur n''existe pas chez spb.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 

	-- Le détail sinistre doit exister sur le paramètrage du produit
	If Not Exists ( 
		Select Top 1 1 From sysadm.code_condition with (nolock) Where id_prod = @dcIdProd and id_typ_code = '+DT' and id_code = CONVERT ( decimal ( 7), @dcIdDetSin )
	)
		Begin
			Set @sCommentRefusSpb = 'Le détail sinistre ' + @dcIdDetSin + ' doit être paramétré sur le produit ' + Convert ( Varchar ( 20), @dcIdProd ) + '.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 105, @sCommentRefusSpb 
			Return -1
		End 
		
-- La date de déclaration 
	-- La date de déclaration est-elle une date valide ?
	If @dtDteDecl is null Or LTRIM ( rtrim ( @dtDteDecl )) = ''
		Begin
			If @dtDteDecl is null Set @dtDteDecl = ''
			Set @sCommentRefusSpb = 'La date de déclaration (' + @dtDteDecl + ') provenant de l''émetteur est une donnée obligatoire.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 4, @sCommentRefusSpb 
			Return -1
		End 

	-- La date de déclaration est-elle une date valide ?
	If 	sysadm.FN_IS_DATE ( @dtDteDecl ) = 0 
		Begin
			If @dtDteDecl is null Set @dtDteDecl = ''
			Set @sCommentRefusSpb = 'La date de déclaration (' + @dtDteDecl + ') provenant de l''émetteur doit être une date valide.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 


-- La date de survenance 
	-- La date de survenance est-elle une date valide ?
	If @dtDteSurv is null Or LTRIM ( rtrim ( @dtDteSurv )) = ''
		Begin
			If @dtDteSurv is null Set @dtDteSurv = ''
			Set @sCommentRefusSpb = 'La date de survenance (' + @dtDteSurv + ') provenant de l''émetteur est une donnée obligatoire.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 4, @sCommentRefusSpb 
			Return -1
		End 

	-- La date de survenance est-elle une date valide ?
	If sysadm.FN_IS_DATE ( @dtDteSurv ) = 0
		Begin
			If @dtDteSurv is null Set @dtDteSurv = ''
			Set @sCommentRefusSpb = 'La date de survenance (' + @dtDteSurv + ') provenant de l''émetteur doit être une date valide.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 

-- Heure de survenance, non obligatoire, mais si non, alors elle doit être correcte
If @sHeuSurv is not null 
	Begin
		If ISNUMERIC ( @dcIdDetSin ) = 0 Or LEN ( @sHeuSurv ) <> 4
			Begin
				Set @sCommentRefusSpb = 'L''heure du sinistre (' + @sHeuSurv + ') provenant de l''émetteur doit être une donnée numérique positive répresentant une heure au format HHMM.'
				Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
				Return -1
			End 
	End 

-- La date d'opposition 
	-- La date d'opposition  est-elle une date valide ?
	If @dtDteOppo is null Or LTRIM ( rtrim ( @dtDteOppo )) = ''
		Begin
			If @dtDteOppo is null Set @dtDteOppo = ''
			Set @sCommentRefusSpb = 'La date d''opposition (' + @dtDteOppo + ') provenant de l''émetteur est une donnée obligatoire.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 4, @sCommentRefusSpb 
			Return -1
		End 

	-- La date d'opposition est-elle une date valide ?
	If sysadm.FN_IS_DATE ( @dtDteOppo ) = 0
		Begin
			If @dtDteOppo is null Set @dtDteOppo = ''
			Set @sCommentRefusSpb = 'La date d''opposition (' + @dtDteOppo + ') provenant de l''émetteur doit être une date valide.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 

-- La date d'utilisation
	-- La date d'utilisation est-elle une date valide ?
	If @dtDteUtil is null Or LTRIM ( rtrim ( @dtDteUtil )) = ''
		Begin
			If @dtDteUtil is null Set @dtDteUtil = ''
			Set @sCommentRefusSpb = 'La date d''utilisation  (' + @dtDteUtil + ') provenant de l''émetteur est une donnée obligatoire.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 4, @sCommentRefusSpb 
			Return -1
		End 

	-- La date d'utilisation est-elle une date valide ?
	If sysadm.FN_IS_DATE ( @dtDteUtil ) = 0
		Begin
			If @dtDteUtil is null Set @dtDteUtil = ''
			Set @sCommentRefusSpb = 'La date d''utilisation  (' + @dtDteUtil + ') provenant de l''émetteur doit être une date valide.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 

-- La date d'adhésion
	-- La date d'adhésion est-elle une date valide ?
	If sysadm.FN_IS_DATE ( @dtDteAdh ) = 0 Or @dtDteAdh is null Or LTRIM ( rtrim ( @dtDteAdh )) = ''
		Begin
			If @dtDteAdh is null Set @dtDteAdh = ''
			Set @sCommentRefusSpb = 'La date d''adhésion (' + @dtDteAdh + ') provenant de FFM doit être une date valide.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 203, @sCommentRefusSpb 
			Return -1
		End 

-- La date de résiliation
	-- La date de résiliation est-elle une date valide si elle est présente ?
	If @dtDteResil is not null 
		Begin
			If sysadm.FN_IS_DATE ( @dtDteResil ) = 0 Or @dtDteResil is null Or LTRIM ( rtrim ( @dtDteResil )) = ''
				Begin
					If @dtDteResil is null Set @dtDteResil = ''
					Set @sCommentRefusSpb = 'La date d''adhésion (' + @dtDteResil + ') provenant de FFM doit être une date valide si elle est présente.'
					Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 204, @sCommentRefusSpb 
					Return -1
				End 
		End 
		
-- La date de fin de garantie 
	If	@dtDteFinGti is null 
		And Exists ( Select Top 1 1 From sysadm.produit with (nolock) where id_prod = @dcIdProd And cod_adh = '1' )
		And Not Exists ( Select Top 1 1 From sysadm.det_pro with (nolock) where id_prod = @dcIdProd and id_code_dp = 29 )
		Begin
			Set @sCommentRefusSpb = 'La date de fin de garantie provenant de FFM est obligatoire pour le produit ' + Convert ( varchar ( 10), @dcIdProd ) + ' par rapport au paramètrage sinistre.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 208, @sCommentRefusSpb 
			Return -1
		End 

	-- La date de garantie est-elle une date valide  ?
	If @dtDteFinGti is not null 
		Begin
			If sysadm.FN_IS_DATE ( @dtDteFinGti ) = 0 Or @dtDteFinGti is null Or LTRIM ( rtrim ( @dtDteFinGti )) = ''
				Begin
					If @dtDteFinGti is null Set @dtDteFinGti = ''
					Set @sCommentRefusSpb = 'La date de fin de garantie (' + @dtDteFinGti + ') provenant de FFM doit être une date valide.'
					Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 205, @sCommentRefusSpb 
					Return -1
				End 
		End 

-- Le code civilité
	-- Le code civilité doit être un numéric
	If @sCodCiv is null Or LTRIM ( rtrim ( @sCodCiv )) = ''
		Begin
			If @sCodCiv is null Set @sCodCiv = ''
			Set @sCommentRefusSpb = 'Le code civilité (' + @sCodCiv + ') provenant de l''émetteur est une donnée obligatoire.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 4, @sCommentRefusSpb 
			Return -1
		End 

	-- Le code civilité doit être un numéric
	If ISNUMERIC ( @sCodCiv ) = 0 
		Begin
			If @sCodCiv is null Set @sCodCiv = ''
			Set @sCommentRefusSpb = 'Le code civilité (' + @sCodCiv + ') provenant de l''émetteur doit être une donnée numérique positive de valeur 1,2,4,5,6.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End

	-- Le code civilité doit être compris entre 1 et 2 ou 4 et 6
	If CONVERT ( decimal ( 7), @sCodCiv ) not in ( 1, 2, 4, 5, 6 )
		Begin
			Set @sCommentRefusSpb = 'Le code civilité (' + @sCodCiv + ') provenant de l''émetteur doit être une donnée numérique positive de valeur 1,2,4,5,6.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 

-- Le nom
If @sNom is null Or LTRIM ( rtrim ( @sNom )) = ''
	Begin
		Set @sCommentRefusSpb = 'Le nom de l''assuré provenant de l''émetteur est une donnée obligatoire.'
		Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 4, @sCommentRefusSpb 
		Return -1
	End 

-- Le prénom
If @sPrenom is null Or LTRIM ( rtrim ( @sPrenom )) = '' And @sCodCiv <> 5
	Begin
		Set @sCommentRefusSpb = 'Le prénom de l''assuré provenant de l''émetteur est une donnée obligatoire (si la civilité n''est pas une société).'
		Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 4, @sCommentRefusSpb 
		Return -1
	End 

-- L'adresse ligne 1 doit être renseignée
If @sAdr1 is null Or LTRIM ( rtrim ( @sAdr1 )) = ''
	Begin
		Set @sCommentRefusSpb = 'La première ligne d''adresse de l''assuré provenant de l''émetteur est une donnée obligatoire.'
		Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 4, @sCommentRefusSpb 
		Return -1
	End 

-- L'adresse ligne 2 doit être renseignée si elle n'est pas null
	-- Pas de contrôle

-- Le code postal de l'assuré
	-- Le code postal de l'assuré doit être une donnée numèrique
	If @sAdrCp is null Or LTRIM ( rtrim ( @sAdrCp )) = ''
		Begin
			If @sAdrCp is null Set @sAdrCp = ''
			Set @sCommentRefusSpb = 'Le code postal (' + @sAdrCp + ') provenant de l''émetteur est une donnée obligatoire.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 4, @sCommentRefusSpb 
			Return -1
		End
			 
	-- Le code postal de l'assuré doit être une donnée numèrique
	If ISNUMERIC ( @sAdrCp ) = 0 
		Begin
			If @sAdrCp is null Set @sAdrCp = ''
			Set @sCommentRefusSpb = 'Le code postal (' + @sAdrCp + ') provenant de l''émetteur doit être une donnée numérique positive correspondant à une code postal français.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 			  

-- La ville de l'assuré
	-- La ville de l'assuré doit être une donnée numèrique
	If @sAdrVille is null Or LTRIM ( rtrim ( @sAdrVille )) = ''
		Begin 
			If @sAdrVille is null Set @sAdrVille = ''
			Set @sCommentRefusSpb = 'La ville de l''assuré (' + @sAdrVille + ') provenant de l''émetteur est une donnée obligatoire.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 4, @sCommentRefusSpb 
			Return -1
		End 

-- Le numéro de téléphone de l'assuré
	-- Le numéro de téléphone de l'assuré doit être numérique et de longueur 10
	If @sNumTeld is not null and LTRIM ( rtrim ( @sNumTeld )) <> '' 
		Begin 
			If ISNUMERIC ( @sNumTeld ) = 0 Or LEN ( @sNumTeld ) <> 10
				Begin
					-- Avant de rejeter, vu avec la BRED, on regarde si j'en ai au moins 9 et si oui, je mets un Zéro devant et je passe.
					If ISNUMERIC ( @sNumTeld ) = 1 And LEN ( @sNumTeld ) >= 9 
						Begin
							Update sysadm.dossier_auto_DT432 Set num_teld = '0' + Right ( @sNumTeld, 9 ) where id_seq = @aiIdSeq
						End
					Else
						Begin
						If @sNumTeld is null Set @sNumTeld = ''
							Set @sCommentRefusSpb = 'Le numéro de téléphone (' + @sNumTeld + ') provenant de l''émetteur doit être une donnée numérique positive de longueur 10.'
							Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
							Return -1
						End 
				End 
		End 
-- La garantie 
	-- La garantie doit être un donnée numérique
	If ISNUMERIC ( @dcIdGti ) = 0 Or @dcIdGti is null Or LTRIM ( rtrim ( @dcIdGti )) = '' 
		Begin
			If @dcIdGti is null Set @dcIdGti = ''
			Set @sCommentRefusSpb = 'Le garantie (' + @dcIdGti + ') provenant de l''ETL doit être une donnée numérique positive appartenant au paramètrage du produit.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 301, @sCommentRefusSpb 
			Return -1
		End 

	-- La garantie doit être un donnée numérique
	If Not Exists ( 
		Select Top 1 1
		From sysadm.code_garantie cg
		Where cg.id_prod = CONVERT ( decimal ( 7), @dcIdProd ) 
		And   cg.id_gti = CONVERT ( decimal ( 7), @dcIdGti) 
	)
		Begin
			Set @sCommentRefusSpb = 'Le garantie (' + @dcIdGti + ') provenant de l''ETL doit être une donnée numérique positive appartenant au paramètrage du produit.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 301, @sCommentRefusSpb 
			Return -1
		End 

-- L'IBAN
		-- L'IBAN doit être de longueur 27 FRKKBBBBBGGGGGCCCCCCCCCCCKK
		Set @sIban = LTRIM ( rtrim ( @sIban )) 
			If @sIban is null Or @sIban = ''
			Begin
				Set @sCommentRefusSpb = 'L''IBAN (' + @sIban + ') doit est une obligatoire.'
				Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 4, @sCommentRefusSpb 
				Return -1
			End 			 

		If LEN ( @sIban ) <> 27 
		Begin
			Set @sCommentRefusSpb = 'L''IBAN (' + @sIban + ') doit contenir 27 caractères.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 	

		-- je compose un RIB à partir de l'IBAN et je le contrôle par sysadm.SPB_FN_RIB_V01
		Set @sRibBq = SUBSTRING ( Upper ( @sIban ), 5, 5 )
		Set @sRibGui = SUBSTRING ( Upper ( @sIban ), 10, 5 )
		Set @sRibCpt = SUBSTRING ( Upper ( @sIban ), 15, 11 )
		Set @sRibCle = SUBSTRING ( Upper ( @sIban ), 26, 2 )

		If sysadm.SPB_FN_RIB_V01 ( @sRibBq, @sRibGui, @sRibCpt, @sRibCle ) < 0 
		Begin
			Set @sCommentRefusSpb = 'Le RIB extrait de l''IBAN ( ' + @sIban + ') n''est pas valide.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 			 

-- L'adresse mail doit être valide
If @sAdrMail is not null And @sAdrMail <> ''
	Begin 
		If sysadm.FN_CTRLE_ADR_MAIL ( @sAdrMail ) < 0
			Begin
				Set @sCommentRefusSpb = 'L''adresse mail (' + @sAdrMail + ') provenant de l''émetteur doit être une donnée adresse mail valide si elle est transmise.'
				Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
				Return -1
			End 
	End 
-- le montant de préjudice 
	-- le montant de préjudice doit être numérique valide
	If @dcMtPrej is null Or LTRIM ( rtrim ( @dcMtPrej )) = '' 
		Begin
			Set @sCommentRefusSpb = 'Le montant de préjudice (' + @dcMtPrej + ') provenant de l''émetteur est une donnée donnée obligatoire.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 4, @sCommentRefusSpb 
			Return -1
		End 

	-- le montant de préjudice doit être numérique valide
	If ISNUMERIC ( @dcMtPrej ) = 0 Or CharIndex ( '.', @dcMtPrej ) > 0 Or CharIndex ( ',', @dcMtPrej ) > 0 Or CharIndex ( '-', @dcMtPrej ) > 0
		Begin
			Set @sCommentRefusSpb = 'Le montant de préjudice (' + @dcMtPrej + ') provenant de l''émetteur doit être une donnée numérique positive sans point virgule en centimes d''euros.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 
		

-- Le statut emetteur
Set @sStatutEmetteur = UPPER ( @sStatutEmetteur )
	-- LE statut emetteur est obligatoire
	If @sStatutEmetteur is null Or LTRIM ( rtrim ( @sStatutEmetteur )) = '' 
		Begin
			Set @sCommentRefusSpb = 'Le statut emetteur (' + @sStatutEmetteur + ') provenant de l''émetteur est une données obligatoire'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 4, @sCommentRefusSpb 
			Return -1
		End 

	-- LE statut emetteur doit être valide
	If @sStatutEmetteur Not in ( 'ACCEPTE', 'REFUSE', 'PARTIEL' )
		Begin
			Set @sCommentRefusSpb = 'Le statut emetteur (' + @sStatutEmetteur + ') provenant de l''émetteur doit être une de ces 3 données : ACCEPTE, REFUSE, PARTIEL'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 

    -- Contrôle cohérence etat Bred avec le statut
	If @sStatutEmetteur = 'ACCEPTE' And @iMotifRefusEmetteur is not null And  LTRIM ( rtrim ( @iMotifRefusEmetteur )) <> ''
		Begin
			Set @sCommentRefusSpb = 'Le statut emetteur ' + @sStatutEmetteur + ' provenant de l''émetteur est incohérent avec la présence d''un code refus (' + @iMotifRefusEmetteur + ') de l''emetteur.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 

	-- Contrôle cohérence etat Bred avec le statut
	If @sStatutEmetteur = 'REFUSE' And ( @iMotifRefusEmetteur is null Or LTRIM ( rtrim ( @iMotifRefusEmetteur )) = '' )
		Begin
			Set @sCommentRefusSpb = 'Le statut emetteur ' + @sStatutEmetteur + ' provenant de l''émetteur est incohérent avec l''absence d''un code refus de l''emetteur.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 


-- le montant Uf à charge SPB
	-- le montant Uf à charge SPB doit être numérique valide
	If @dcMtUfChargeSpb is null Or LTRIM ( rtrim ( @dcMtUfChargeSpb )) = '' 
		Begin
			Set @sCommentRefusSpb = 'Le montant Uf à charge SPB (' + @dcMtUfChargeSpb + ') provenant de l''émetteur est une donnée obligatoire.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 4, @sCommentRefusSpb 
			Return -1
		End 

	-- le montant Uf à charge SPB doit être numérique valide
	-- [RS882] Autoriser 0 mais en fait c'est déjà le cas, aucune modifi donc
	If ISNUMERIC ( @dcMtUfChargeSpb ) = 0 Or CharIndex ( '.', @dcMtUfChargeSpb ) > 0 Or CharIndex ( ',', @dcMtUfChargeSpb ) > 0 Or CharIndex ( '-', @dcMtUfChargeSpb ) > 0
		Begin
			Set @sCommentRefusSpb = 'Le montant Uf à charge SPB (' + @dcMtUfChargeSpb + ') provenant de l''émetteur doit être une donnée numérique positive sans point virgule en centimes d''euros.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 
	

-- le montant de franchise à charge de l'assuré
	-- le montant de franchise à charge de l'assuré doit être numérique valide
	If @dcMtFranChargeAssure is null Or LTRIM ( rtrim ( @dcMtFranChargeAssure )) = '' 
		Begin
			Set @sCommentRefusSpb = 'Le montant de franchise à charge de l''assuré (' + @dcMtFranChargeAssure + ') provenant de l''émetteur est une donnée obligatoire.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 4, @sCommentRefusSpb 
			Return -1
		End 

	-- le montant de franchise à charge de l'assuré doit être numérique valide
	If ISNUMERIC ( @dcMtFranChargeAssure ) = 0 Or CharIndex ( '.', @dcMtFranChargeAssure ) > 0 Or CharIndex ( ',', @dcMtFranChargeAssure ) > 0 Or CharIndex ( '-', @dcMtFranChargeAssure ) > 0
		Begin
			Set @sCommentRefusSpb = 'Le montant de franchise à charge de l''assuré (' + @dcMtFranChargeAssure + ') provenant de l''émetteur doit être une donnée numérique positive sans point virgule en centimes d''euros.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
			Return -1
		End 

		
-- le Refus émetteur doit être valide
	-- le Refus émetteur doit être valide une donnée numérique entre 1 et 5
	If @iMotifRefusEmetteur is not null and LTRIM ( rtrim ( @iMotifRefusEmetteur )) <> ''
	  Begin
		-- le Refus émetteur doit être valide une donnée numérique entre 1 et 5
		If ISNUMERIC ( @iMotifRefusEmetteur ) = 0 
			Begin
				If @iMotifRefusEmetteur is null Set @iMotifRefusEmetteur = ''
				Set @sCommentRefusSpb = 'Le motif de refus émetteur (' + @iMotifRefusEmetteur + ') provenant de l''émetteur doit être une donnée numérique positive de entre 1 et 10.'
				Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
				Return -1
			End 

		-- Le Refus émetteur doit être compris entre 1 et 12. Pensez à l'ajouter en -WI !!! sur code_car, voir le libellés avec CHARLINE (ou le demandeur).
		If CONVERT ( decimal ( 7), @iMotifRefusEmetteur ) not between 1 and 12 
			Begin
				Set @sCommentRefusSpb = 'Le motif de refus émetteur (' + @iMotifRefusEmetteur + ') provenant de l''émetteur doit être une donnée numérique positive de valeur entre 1 et 12.'
				Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 5, @sCommentRefusSpb 
				Return -1
			End 
	  End
Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_U_DT432_ERREUR_TRT
-- Auteur               :       JFF
-- Date                 :       06/10/2020
-- Libelle              :       
-- Commentaires         :       [DT432]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_DT432_ERREUR_TRT' AND type = 'P' )
        DROP procedure sysadm.PS_U_DT432_ERREUR_TRT
GO

CREATE procedure sysadm.PS_U_DT432_ERREUR_TRT
	@aiIdSeq integer,
	@aiCodeErreur integer,
	@asCommentRefusSpb VarChar ( 255 )
AS 

Update sysadm.dossier_auto_DT432
Set motif_refus_spb = @aiCodeErreur,
    comment_refus_spb = @asCommentRefusSpb,
	etat_trt = Case 
					When @aiCodeErreur < 100 Then 'TRAITE_ERREUR_EMETTEUR'
					When @aiCodeErreur between 100 and 199 Then 'TRAITE_ERREUR_SPB_SIN'
					When @aiCodeErreur between 200 and 299 Then 'TRAITE_ERREUR_SPB_FFM'
					When @aiCodeErreur between 300 and 399 Then 'TRAITE_ERREUR_SPB_ETL'
					Else 'TRAITE_ERREUR_??'
			   End,
	traite_le = Getdate(),
	traite_par = 'SQLS'
Where id_seq = @aiIdSeq

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_I_DT432_CREATION_DOSSIER_AUTO
-- Auteur               :       JFF
-- Date                 :       06/10/2020
-- Libelle              :       
-- Commentaires         :       [DT432]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- [DT432_ISM261862]  JFF 12/04/2022
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DT432_CREATION_DOSSIER_AUTO_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_DT432_CREATION_DOSSIER_AUTO_V01
GO

CREATE procedure sysadm.PS_I_DT432_CREATION_DOSSIER_AUTO_V01
	@aiIdSeq	integer
AS 

Declare 
@sIdProjet		varchar(35),
@sIdSinEmetteur varchar(35),
@dcIdProd		decimal(7),
@dcIdEts		decimal(7),
@sIdAdh		char(19),  
@dcIdsDos		decimal(2),
@dcCodOpt		decimal(2),
@dtDteOpt       DateTime,
@dcIdNatSin		decimal(7),
@dcIdTerrit		decimal(7),
@dcIdDetSin		decimal(7),
@dtDteDecl		DateTime,
@dtDteSurv		DateTime,
@sHeuSurv		char(4), 
@dtDteOppo		DateTime,  
@dtDteUtil		DateTime,  
@dtDteAdh		DateTime,
@dtDteResil		DateTime,
@dtDteFinGti		DateTime,
@sCodCiv		char(1),   
@sNom			char(35),  
@sPrenom		char(35),  
@sAdr1			char(35),  
@sAdr2			char(35),  
@sAdrCp		char(5),   
@sAdrVille		char(35),  
@sNumTeld		char(20),  
@dcIdGti		decimal(7),
@sIban			varchar (50),
@sAdrMail		varchar(200),
@dcIdEvt		decimal(7),
@dcMtPrej		decimal(11,2),
@sStatutEmetteur	varchar (35),
@dcMtUfChargeSpb	decimal(11,2),
@dcMtFranChargeAssure	decimal(11,2),
@iMotifRefusEmetteur	integer,
@sCommentRefusSpb  VarChar ( 255 ),
@sValWrk  Varchar ( 50 ),
@sRibBq Varchar ( 5 ),
@sRibGui Varchar ( 5 ),
@sRibCpt Varchar ( 11),
@sRibCle Varchar ( 2 ),
@iIdSin integer,
@iIdProd integer,
@iIdEts  integer,
@iIdsDos integer,
@iIdNatSin Integer,
@iIdTerrit Integer,
@iIdDetSin Integer,
@iOption Integer,
@iRet Integer,
@sMsgDecla VarChar ( 5000 ),
@sMsgMajDossier VarChar ( 5000 ),
@sMsgWrk VarChar ( 5000 ),
@sRetour  Varchar(60),
@iDossierSinExiste Integer,
@iDossierWSinExiste Integer,
@dcIdSin Decimal ( 10 ),
@iNbreTotContact integer,
@iNumContact integer,
@sVal VarChar ( 50 ),
@iIdGti integer,
@iIdCli integer,
@sErr varchar ( 60),
@iIdCt integer,
@dcNewIdDetail Decimal (7),
@iIdEvt integer,
@iIdDetail integer,
@iIdProdAdh integer,
@iValMx Integer,
@iRowcount Integer

Set @iDossierSinExiste = 0
Set @iDossierWSinExiste = 0
Set @sMsgDecla = ''
Set @sMsgMajDossier = ''
Set @sMsgWrk = ''
Set @sRetour = Space ( 60 )


Set @iRet = 1

-- Selection des données dans leur format définitif avec Convert/Trim
Select 	Top 1 
	@sIdProjet = Upper ( lTrim ( rTrim ( id_projet ))),
	@sIdSinEmetteur = lTrim ( rTrim ( id_sin_emetteur )),
	@dcIdProd = id_prod,
	@dcIdEts = id_ets,
	@sIdAdh =  lTrim ( rTrim ( id_adh )),
	@dcIdsDos = id_sdos,
	@dcCodOpt = cod_opt,
	@dtDteOpt = Convert ( DateTime, dte_opt ),
	@dcIdNatSin = Convert ( decimal (7), id_natsin ),
	@dcIdTerrit = Convert ( decimal (7), id_territ ),
	@dcIdDetSin = Convert ( decimal (7), id_detsin ),
	@dtDteDecl = Convert ( DateTime, dte_decl ),
	@dtDteSurv = Convert ( DateTime, dte_surv ),
	@sHeuSurv = lTrim ( rTrim ( heu_surv )),
	@dtDteOppo = Convert ( DateTime, dte_oppo ),
	@dtDteUtil = Convert ( DateTime, dte_util ),
	@dtDteAdh = Convert ( DateTime, dte_adh ),
	@dtDteResil = Convert ( DateTime, dte_resil ),
	@dtDteFinGti = Convert ( DateTime, dte_fin_gti ),
	@sCodCiv = lTrim ( rTrim ( cod_civ)),
	@sNom = sysadm.FN_EPURE_CHAINE_V01 ( Upper ( lTrim ( rTrim ( nom ))), ''),
	@sPrenom = sysadm.FN_EPURE_CHAINE_V01 ( Upper ( lTrim ( rTrim ( prenom ))), ''),
	@sAdr1 = sysadm.FN_EPURE_CHAINE_V01 ( Upper ( lTrim ( rTrim ( adr_1 ))), ''),
	@sAdr2 = sysadm.FN_EPURE_CHAINE_V01 ( Upper ( lTrim ( rTrim ( adr_2 ))), ''),
	@sAdrCp =  lTrim ( rTrim ( adr_cp )),
	@sAdrVille = sysadm.FN_EPURE_CHAINE_V01 ( Upper ( lTrim ( rTrim ( adr_ville ))), ''),
	@sNumTeld = lTrim ( rTrim ( num_teld )),
	@dcIdGti = id_gti,
	@sIban = Upper ( lTrim ( rTrim ( iban ))),
	@sAdrMail = nullif ( Lower ( lTrim ( rTrim ( adr_mail ))), ''),
	@dcIdEvt = Convert ( decimal (7) , id_evt ),
	@dcMtPrej = Convert ( decimal (11,2) , mt_prej) / 100,
	@sStatutEmetteur = Upper ( lTrim ( rTrim ( statut_emetteur ))),
	@dcMtUfChargeSpb = Convert ( decimal (11,2) , mt_uf_charge_spb ) / 100,
	@dcMtFranChargeAssure = Convert ( decimal (11,2) ,mt_fran_charge_assure ) / 100,
	@iMotifRefusEmetteur  = Convert ( Integer, motif_refus_emetteur ) 
From sysadm.dossier_auto_DT432 da 
where da.id_seq = @aiIdSeq


-- Le code projet
If @sIdProjet is null Or ltrim ( rtrim ( @sIdProjet )) <> 'DT432' Set @sIdProjet = 'DT432'

-- Conversion de certaines données au format SHERPA
Set @iIdProd = CONVERT ( Integer, @dcIdProd )
Set @iIdEts  = CONVERT ( Integer, @dcIdEts )
Set @iIdsDos = CONVERT ( Integer, @dcIdsDos )
Set @iIdNatSin = CONVERT ( Integer, @dcIdNatSin )
Set @iIdTerrit = CONVERT ( Integer, @dcIdTerrit )
Set @iIdDetSin = CONVERT ( Integer, @dcIdDetSin )
Set @iOption = CONVERT ( Integer, @dcCodOpt ) 
Set @iIdGti = CONVERT ( Integer, @dcIdGti ) 
Set @iIdEvt = CONVERT ( Integer, @dcIdEvt ) 

-- Initialisation de certaines données
	-- Le message
	Set @sMsgDecla = 'Déclaration ' + @sStatutEmetteur + ' de la Banque. Montant UF restant à charge SPB : ' + Convert ( Varchar (20), @dcMtUfChargeSpb ) + '€, '
	Set @sMsgDecla = @sMsgDecla + 'Montant franchise à charge assuré : ' + Convert ( Varchar (20), @dcMtFranChargeAssure ) + '€. '
	-- [RS882] Mettre phrase explicative si @dcMtUfChargeSpb = 0. Dire au GT de référer à l'autre contact et de ne pas règler sur les 2 détails/évt que le montant donné sur l'autre contact.
	If @dcMtUfChargeSpb = 0 Or @dcMtFranChargeAssure = 0 Set @sMsgDecla = @sMsgDecla + 'Attention si le/les montant(s) des UF à charge SPB et/ou à charge assuré sont à 0 sur cet évènement c''est que les montants totaux des deux évènements se trouvent additionnés sur l''autre évènement, que vous trouverez donc sur l''autre contact.'
	-- /[RS882]

	Set @sMsgDecla = @sMsgDecla + 'Identifiant sinistre Bred : ' + @sIdSinEmetteur + ' . '

	-- Le motis de refus emetteur
	If @iMotifRefusEmetteur is not null and @iMotifRefusEmetteur > 0 
	  Begin
		  Set @sMsgDecla = @sMsgDecla + 'Cause refus BRED : ' +
				Case @iMotifRefusEmetteur
					When 1 Then 'Mise en opposition tardive = délai > 72 H si le Client utilise régulièrement sa carte, Art.L133-17, Art.11.1 de CG. ' 
					When 2 Then 'Mise en opposition tardive = délai > 5 Jours ouvrables (voire plus en fonction de la fréquence d''utilisation) en cas d''utilisation irrégulière de la carte, Art.L133-17, Art.11.1 de CG. ' 
					When 3 Then 'Client ayant donné ou prêté sa carte et son code à un tiers ou un membre de la famille (information expressément confirmée par le client), Art.L133-16 et 19, Art.2 de CG. ' 
					When 4 Then 'Opérations contestées antérieures de plus de 13 mois, Art.L133-24, Art.16.1 de CG. '
					When 5 Then 'Opérations contestées antérieures de plus de 70 jours, Art.L133-24, Art.16.1 de CG. '
					When 6 Then 'Client ayant communiqué son code confidentiel à un tiers (information expressément confirmée par le client), Art.L133-16 et 19, Art.3.3 de CG. ' 
					When 7 Then 'Client ayant inscrit son code sur un document (agression) (information expressément confirmée par le client), Art.L133-16 et 19, Art.3.3 de CG. ' 
					When 8 Then 'Carte et code laissés sans surveillance dans le véhicule ou au domicile (information expressément confirmée par le client), Art.L133-16 et 19, Art.2 de CG. ' 
					When 9 Then 'Contestations d''opérations de retrait avec effraction au GAB / Extorsion par la menace ou avec un acte de violence. ' 
					When 10 Then 'Carte utilisée physiquement sans perte ni  vol declares (le client confirme être toujours resté en possession de sa cb), Art.L133-16 et 19, Art.2 de CG. '
					When 11 Then 'Refus banque mais prise en charge assureur si agression. '
					When 12 Then 'Refus banque mais prise en charge assureur si perte ou vol de la carte. ' 
					Else 'Motif de refus non décodable. '
				End 
	  End 
	Else
	  Begin
		 If @sStatutEmetteur = 'ACCEPTE' Set @sMsgDecla = @sMsgDecla + 'Règlement franchise à effectuer par SPB. '
	  End 


	-- je compose un RIB à partir de l'IBAN (IBAN déjà contrôle et donc Valide à ce stade du trt)
	Set @sRibBq  = SUBSTRING ( Upper ( @sIban ), 5, 5 )
	Set @sRibGui = SUBSTRING ( Upper ( @sIban ), 10, 5 )
	Set @sRibCpt = SUBSTRING ( Upper ( @sIban ), 15, 11 )
	Set @sRibCle = SUBSTRING ( Upper ( @sIban ), 26, 2 )	  

-- Recherche si Sinistre Existant ou pas ?
If Exists ( 
		Select Top 1 1 
		From sysadm.sinistre s with (nolock)
		Where id_prod = @dcIdProd  
		And   id_ets  = @dcIdEts 
		And   id_adh  = @sIdAdh 
		And   id_sdos = @dcIdsDos 
		And   convert ( VarChar ( 10 ), dte_surv, 103 ) = convert ( VarChar ( 10 ), @dtDteSurv, 103 )
		-- And   id_natsin = @dcIdNatSin   Vu avec CHarline et DGRC, on ne recherche pas jusqu'à la nature mail du 12/10/220 10h02
	)
	Begin
		Set @iDossierSinExiste = 1
	End 

If Exists ( 
		Select Top 1 1 
		From sysadm.w_sin s with (nolock)
		Where id_prod = @dcIdProd  
		And   id_ets  = @dcIdEts 
		And   id_adh  = @sIdAdh 
		And   id_sdos = @dcIdsDos 
		And   convert ( VarChar ( 10 ), dte_surv, 103 ) = convert ( VarChar ( 10 ), @dtDteSurv, 103 )
		-- And   id_natsin = @dcIdNatSin  Vu avec CHarline et DGRC, on ne recherche pas jusqu'à la nature mail du 12/10/2020 10h02
	)
	Begin
		Set @iDossierWSinExiste = 1
	End 


-- 1er grand Cas, le dossier existe et est donc à mettre à jour.
-- Le dossier existe
If @iDossierSinExiste > 0 Or @iDossierWSinExiste > 0
  Begin
	-- Récupération du numéro de sinistre
	If @iDossierSinExiste > 0 
	 Begin
		Select @dcIdSin = s.id_sin
		From sysadm.sinistre s with (nolock)
		Where id_prod = @dcIdProd  
		And   id_ets  = @dcIdEts 
		And   id_adh  = @sIdAdh 
		And   id_sdos = @dcIdsDos 
		And   convert ( VarChar ( 10 ), dte_surv, 103 ) = convert ( VarChar ( 10 ), @dtDteSurv, 103 )
		-- And   id_natsin = @dcIdNatSin Vu avec CHarline et DGRC, on ne recherche pas jusqu'à la nature mail du 12/10/220 10h02
	 End

	If @iDossierSinExiste <= 0  
	 Begin
		Select @dcIdSin = s.id_sin
		From sysadm.w_sin s with (nolock)
		Where id_prod = @dcIdProd  
		And   id_ets  = @dcIdEts 
		And   id_adh  = @sIdAdh 
		And   id_sdos = @dcIdsDos 
		And   convert ( VarChar ( 10 ), dte_surv, 103 ) = convert ( VarChar ( 10 ), @dtDteSurv, 103 )
		-- And   id_natsin = @dcIdNatSin Vu avec CHarline et DGRC, on ne recherche pas jusqu'à la nature mail du 12/10/220 10h02
	 End

	Update sysadm.dossier_auto_DT432 Set id_sin = @dcIdSin Where id_seq = @aiIdSeq

	Set @sMsgMajDossier = @sMsgMajDossier + 'Un dossier de sinistre (' + CONVERT ( Varchar ( 10 ), @dcIdSin ) + ') existe déjà répondant à cette adhésion et cette date de survenance ' +  convert ( VarChar ( 10 ), @dtDteSurv, 103 ) + '. '

	-- Traitement table de travail (même si table permanente existe, on ne maj que les table W, car la validation fera le reste)
	If @iDossierWSinExiste > 0 
	 Begin
	 	-- Le garantie UF existe-t-elle ?
	    If Exists ( 
			Select Top 1 1
			From sysadm.w_gar_sin g with (nolock)
			Where g.id_sin = @dcIdSin
			And   g.id_gti = @dcIdGti
		) 
		 -- Oui, elle existe
		 Begin
			-- Maj date 1ère UF et dte_oppo si GTI UF non réglée
			Set @sMsgMajDossier = @sMsgMajDossier + 'La garantie UF existe déjà sur le dossier. '

			-- La GTI UF est-elle réglée/refusée ?
			If Not Exists (
				Select Top 1 1
				From sysadm.w_gar_sin g with (nolock)
				Where g.id_sin = @dcIdSin
				And   g.id_gti = @dcIdGti
				And   g.cod_etat in ( 550, 600, 500, 200 )
			)
			 -- Non, pas réglé ni refusé
			 Begin
				-- Tentative de Maj date oppo et date 1ère UF sur la GTI UF. Pour date 1ère UF, on prend la date d'utilisation, vu avec Charline.
				Update sysadm.w_gar_sin Set dte_oppo = @dtDteOppo, dte_1er_uf = @dtDteUtil Where id_sin = @dcIdSin and id_gti = @dcIdGti
				
				If @@ROWCOUNT > 0 
				 -- Réussi (même si dte oppo présente, on écrase tant que GTI non réglé, vu avec Charline)
				 Begin
					Set @sMsgMajDossier = @sMsgMajDossier + 'La date d''opposition ('+ Convert ( varchar (10), @dtDteOppo, 103 ) + ') et la date de 1ère UF (date utilisation ' + Convert ( varchar (10), @dtDteUtil, 103 ) + ') provenant de la banque ont été mise à jour sur le dossier. '
					
					-- On remet la GTI dans un état d'instruction.
					Update sysadm.w_gar_sin 
					Set cod_dec_mac = 100, 
						cod_dec_ope = 100,
						cod_etat = 100,
						alt_att = 'O',  -- [DT432_ISM261862]
						alt_ssui = 'N',
						cod_mot_ssui = 0
					Where id_sin = @dcIdSin 
					and id_gti = @dcIdGti

				 End 
				 Else 
				 -- Echoué
				 Begin
					Set @sMsgMajDossier = @sMsgMajDossier + 'Problème technique, la date d''opposition et la date de 1ère UF (date utilisation) provenant de la banque n''ont pas été mise à jour sur le dossier. '
				 End 
				 
			 End 
			Else
			 -- Oui, réglé
			 Begin
				Set @sMsgMajDossier = @sMsgMajDossier + 'La garantie UF est réglée ou partiellement réglée ou sur le point d''être réglée ou bien refusée, donc l''automate ne modifie plus rien au niveau date d''oppo et date de 1ère UF sur la garantie. '
			 End 

		 End 
		Else 
		 -- Non, elle n'existe pas
		 Begin
		 	Set @sMsgMajDossier = @sMsgMajDossier + 'La garantie UF n''existe pas sur le dossier, l''automate créé la garantie UF avec la date d''opposition ' + Convert ( varchar (10), @dtDteOppo, 103 ) + 'et la date de 1ère UF (date utilisation ' + Convert ( varchar (10), @dtDteUtil, 103 ) + ') . '

			-- Création garantie et Maj date 1ère UF et dte_oppo si GTI UF non réglée
			Insert into sysadm.w_gar_sin (
					id_sin,
					id_gti,
					dte_oppo,
					heu_oppo,
					dte_1er_uf,
					mt_tot_prej,
					mt_prej_areg,
					mt_fran_areg,
					mt_nplaf_areg,
					mt_plaf_areg,
					mt_dedu_areg,
					mt_prej_reg,
					mt_dedu_reg,
					mt_fran_reg,
					mt_nplaf_reg,
					mt_plaf_reg,
					mt_prov,
					cod_dec_mac,
					cod_dec_ope,
					cod_etat,
					txt_mess,
					alt_bloc,
					alt_att,
					alt_plaf,
					alt_ssui,
					cod_mot_ssui,
					alt_valide,
					cpt_valide,
					cpt_i_areg,
					cree_le,
					maj_le,
					maj_par
				)
				Values 
				(
					@dcIdSin,  
					@dcIdGti,  
					@dtDteOppo,  
					null,  
					@dtDteUtil,  
					0,  
					0,  
					0,  
					0,  
					0,  
					0,  
					0,  
					0,  
					0,  
					0,  
					0,  
					0,  
					100,  -- [DT432_ISM261862]
					100,  -- [DT432_ISM261862]
					100,  -- [DT432_ISM261862]
					'Voir les contacts pour les infos provenant de la banque. ',  
					'N',  
					'O',  -- [DT432_ISM261862]
					'N',  
					'N',  
					0,  
					'O',  -- [DT432_ISM261862]
					0,  
					0,  
					getdate(),  
					getdate(),  
					'SQLS'  
				)

				If @@ROWCOUNT <= 0 
				 Begin
					Set @sCommentRefusSpb = 'Problème technique, la mise à jour du dossier SIMPA2 (création de la garantie (W) ) a échoué. '
					Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 122, @sCommentRefusSpb 
					Return -1
				 End 

		 End 

	 	-- Le détail de garantie existe-t-il pour cet évènement ?
	    If Exists ( 
			Select Top 1 1
			From sysadm.w_detail d with (nolock)
			Where d.id_sin = @dcIdSin
			And   d.id_gti = @dcIdGti
			And   d.id_evt = @dcIdEvt
		) 
		 -- Oui, il existe
		 Begin

			Set @sMsgMajDossier = @sMsgMajDossier + 'Le détail de garantie ' + CONVERT ( VarChar (10), @dcIdEvt ) + ' existe déjà sur la Garantie UF. '

			-- Le détail est-il réglé/réfusé ?
			If Exists (
				Select Top 1 1
				From sysadm.w_detail d with (nolock)
				Where d.id_sin = @dcIdSin
				And   d.id_gti = @dcIdGti
				And   d.id_evt = @dcIdEvt
				And   d.cod_etat in ( 0, 1, 100, 900 )
			)
			 -- Non, pas réglé/réfusé
			 Begin
				Set @sMsgMajDossier = @sMsgMajDossier + 'Il n''est pas réglé ni refusé, l''automate met donc à jour le détail de garantie avec le montant de préjudice (' + Convert ( varchar (15), @dcMtPrej) +'€), et la date d''utilisation (' + Convert ( Varchar (10), @dtDteUtil, 103) + '). '

				Update sysadm.w_detail
				set mt_prej = @dcMtPrej,
					dte_det = @dtDteUtil,
					cod_dec_mac = 100, 
					cod_dec_ope = 100,
					cod_etat = 100,
					alt_att = 'O', -- [DT432_ISM261862]
					alt_ssui = 'N',
					cod_mot_ssui = 0
				Where id_sin = @dcIdSin
				And   id_gti = @dcIdGti
				And   id_evt = @dcIdEvt
				And   cod_etat in ( 0, 1, 100, 900 )

			 End 
			Else
			-- Oui, réglé/réfusé
			 Begin
			 	Set @sMsgMajDossier = @sMsgMajDossier + 'Il est déjà réglé ou refusé, l''automate ne met donc pas à jour le détail. '

			 End 


		 End 
		Else
		 -- Non, il n'existe pas
		 Begin
			Set @sMsgMajDossier = @sMsgMajDossier + 'Le détail de garantie ' + CONVERT ( VarChar (10), @dcIdEvt ) + ' n''existe pas sur la Garantie UF, l''automate créé le détail avec le montant de préjudice (' + Convert ( varchar (15), @dcMtPrej) +'€), et la date d''utilisation (' + Convert ( Varchar (10), @dtDteUtil, 103) + '). '

			Select @dcNewIdDetail = MAX ( id_detail )
			From sysadm.w_detail d with (nolock)
			Where d.id_sin = @dcIdSin
			And   d.id_gti = @dcIdGti

			If @dcNewIdDetail is null Set @dcNewIdDetail = 0
			Set @dcNewIdDetail = @dcNewIdDetail + 1

			Insert into sysadm.w_detail 
			(
				id_sin,
				id_gti,
				id_detail,
				id_evt,
				lib_det,
				dte_det,
				heu_det,
				num_carte,
				mt_prej,
				mt_fran,
				mt_nplaf,
				mt_plaf,
				id_i_reg,
				alt_bloc,
				alt_cour,
				alt_plaf,
				alt_reg,
				alt_att,
				alt_valide,
				cpt_valide,
				alt_ssui,
				cod_mot_ssui,
				cod_dec_mac,
				cod_dec_ope,
				cod_etat,
				id_carte,
				id_type_carte,
				cree_le,
				maj_le,
				maj_par,
				dte_cmd,
				dte_livr,
				mt_val_achat,
				mt_val_publique,
				num_facture
			)
			Values
			(
				@dcIdSin,  
				@dcIdGti,  
				@dcNewIdDetail,  
				@dcIdEvt,  
				null,  
				@dtDteUtil,  
				null,  
				null,  
				@dcMtPrej,  
				0,  
				0,  
				0,  
				null,  
				'N',  
				'N',  
				'N',  
				'N',  
				'O',  -- [DT432_ISM261862]
				'O',  -- [DT432_ISM261862]
				0,  
				'N',  
				0,  
				100,  -- [DT432_ISM261862]
				100,  -- [DT432_ISM261862]
				100,  -- [DT432_ISM261862]
				0,  
				'00',  
				GetDate(),  
				GetDate(),  
				'SQLS',  
				null,  
				null,  
				0,  
				0,  
				null  
			)

			If @@ROWCOUNT <= 0 
			 Begin
				Set @sCommentRefusSpb = 'Problème technique, la mise à jour du dossier SIMPA2 (création du détail (W) ) a échoué.'
				Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 107, @sCommentRefusSpb 
				Return -1
			 End 

		 End 

		 -- Mise à jour ou intsertion du Refus SCB (le cas échéant)
		 If @iMotifRefusEmetteur > 0 Or @sStatutEmetteur = 'ACCEPTE'
		   Begin
				Set @iValMx = @iMotifRefusEmetteur
				If @sStatutEmetteur = 'ACCEPTE' Set @iValMx = 99

				Update sysadm.w_div_det
				set maj_le = getdate(),
					maj_par = 'SQLS',
					val_car = 'M' + Convert ( varchar ( 5 ), @iValMx ) 
				From sysadm.w_div_det wdd,
					 sysadm.w_detail wd
				Where wd.id_sin = @dcIdSin
				And   wd.id_gti = @dcIdGti
				And   wd.id_evt = @dcIdEvt
				And   wd.cod_etat in ( 0, 1, 100, 900 )
				And   wdd.id_sin = wd.id_sin
				And   wdd.id_gti = wd.id_gti
				And   wdd.id_detail = wd.id_detail
				And   wdd.nom_zone = 'refus_scb'
			  
			    Set @iRowcount = @@RowCount

			    If @iRowcount > 0 
				  Begin
					 If @iValMx = 99  Set @sMsgMajDossier = @sMsgMajDossier + 'L''automate met à jour ' + Convert ( varchar ( 5), @iRowcount ) + ' notification(s) SCB (M' + Convert ( varchar ( 5 ), @iValMx ) + ' : ' + sysadm.FN_CODE_CAR ( 'M' + Convert ( varchar ( 5 ), @iValMx ), '-WI') + ') sur l''onglet divers du détail de l''évènement ' + Convert ( varchar ( 5), @dcIdEvt) + '. '
					 Else Set @sMsgMajDossier = @sMsgMajDossier + 'L''automate met à jour ' + Convert ( varchar ( 5), @iRowcount ) + ' refus SCB (M' + Convert ( varchar ( 5 ), @iValMx ) + ' : ' + sysadm.FN_CODE_CAR ( 'M' + Convert ( varchar ( 5 ), @iValMx ), '-WI') + ') sur l''onglet divers du détail de l''évènement ' + Convert ( varchar ( 5), @dcIdEvt) + '. '
				  End 

			   Insert into sysadm.w_div_det
			   Select wd.id_sin,
					  wd.id_gti,
					  wd.id_detail,
					  dpd.nom_zone,
					  dpd.lib_label, 
					  dpd.id_typ_liste,
					  dpd.alt_liste_codecar,
					  dpd.id_typ_zone,
					  dpd.alt_oblig,
					  'N',
					  dpd.cpt_tri,
					  null,
					  null,
					  null,
					  'M' + Convert ( varchar ( 5 ), @iValMx ) ,
					  0,
					  Getdate(),
					  getdate(),
					  'SQLS'

			   From sysadm.div_pdet dpd with (nolock),
					sysadm.w_detail wd with (nolock)
			   Where wd.id_sin = @dcIdSin
			   And   wd.id_gti = @dcIdGti
			   And   wd.id_evt = @dcIdEvt
			   And   wd.cod_etat in ( 0, 1, 100, 900 )
			   And   dpd.id_prod = @dcIdProd
			   And   dpd.id_gti = @dcIdGti
			   And   dpd.nom_zone = 'refus_scb'
			   And Not exists ( 
					Select Top 1 1 
					From sysadm.w_div_det wdd with (nolock)
					Where wdd.id_sin = wd.id_sin
					And   wdd.id_gti = wd.id_gti
					And   wdd.id_detail = wd.id_detail
					And   wdd.nom_zone = 'refus_scb'
					And   wdd.val_car = 'M' + Convert ( varchar ( 5 ), @iValMx ) 
			   )

			   Set @iRowcount = @@RowCount

			   If @iRowcount > 0 
				 Begin
					If @iValMx = 99  Set @sMsgMajDossier = @sMsgMajDossier + 'L''automate créé ' + Convert ( varchar ( 5), @iRowcount ) + ' notification(s) SCB (M' + Convert ( varchar ( 5 ), @iValMx ) + ' : ' + sysadm.FN_CODE_CAR ( 'M' + Convert ( varchar ( 5 ), @iValMx ), '-WI') + ') sur l''onglet divers du détail de l''évènement ' + Convert ( varchar ( 5), @dcIdEvt) + '. '
					Else Set @sMsgMajDossier = @sMsgMajDossier + 'L''automate créé ' + Convert ( varchar ( 5), @iRowcount ) + ' refus SCB (M' + Convert ( varchar ( 5 ), @iValMx ) + ' : ' + sysadm.FN_CODE_CAR ( 'M' + Convert ( varchar ( 5 ), @iValMx ), '-WI') + ') sur l''onglet divers du détail de l''évènement ' + Convert ( varchar ( 5), @dcIdEvt) + '. '
				 End 
		   End 

		 -- On marque l'id_seq de la table sysadm.dossier_auto_DT432 sur w_div_sin pour mémoire
		 If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'dt432_id_seq_batch')
			Begin
				Select @sVal = lTrim ( rTrim ( wdv.val_car ))
				From sysadm.w_div_sin wdv with (nolock)
				Where wdv.id_sin = @dcIdSin
				And   wdv.nom_zone = 'dt432_id_seq_batch'

				If @sVal is null Set @sVal = ''
				Set @sVal = @sVal + '#' + CONVERT ( varchar ( 50), @aiIdSeq ) + '#'
				Set @sVal = Left ( REPLACE ( @sVal, '##', '#' ), 35 )

				Update sysadm.w_div_sin Set val_car = @sVal, maj_le = GETDATE(), maj_par = 'SQLS' Where id_sin = @dcIdSin And nom_zone = 'dt432_id_seq_batch'
			End 
		 Else
			Begin
				Set @sVal = Left ( '#' + CONVERT ( varchar ( 50), @aiIdSeq ) + '#', 35 )
				Insert into sysadm.w_div_sin values ( @dcIdSin, 'dt432_id_seq_batch', 'ID batch auto utilisé', '-1', 'N', 'C', 'N', 'N', 120, null, null, null, @sVal, 0, getdate(), getdate(), 'SQLS' ) 

				If @@ROWCOUNT <= 0 
				 Begin
					Set @sCommentRefusSpb = 'La mise à jour du dossier SIMPA2 (création dt432_id_seq_batch (W) ) a échoué.'
					Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 108, @sCommentRefusSpb 
					Return -1
				 End 
			End

		-- On marque l'id_sin_emetteur de la table sysadm.dossier_auto_DT432 sur div_sin pour mémoire
		 If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'dt432_id_sin_emetteur')
			Begin
				Select @sVal = lTrim ( rTrim ( wdv.val_car ))
				From sysadm.w_div_sin wdv with (nolock)
				Where wdv.id_sin = @dcIdSin
				And   wdv.nom_zone = 'dt432_id_sin_emetteur'

				If @sVal is null Set @sVal = ''
				Set @sVal = @sVal + '#' + @sIdSinEmetteur + '#'
				Set @sVal = Left ( REPLACE ( @sVal, '##', '#' ), 35 )

				Update sysadm.w_div_sin Set val_car = @sVal, maj_le = GETDATE(), maj_par = 'SQLS' Where id_sin = @dcIdSin And nom_zone = 'dt432_id_sin_emetteur'
			End 
		 Else
			Begin
				Set @sVal = Left ( '#' + @sIdSinEmetteur + '#', 35 ) 
				Insert into sysadm.w_div_sin values ( @dcIdSin, 'dt432_id_sin_emetteur', 'Identifiant sinistre Bred', '-1', 'N', 'C', 'N', 'N', 121, null, null, null, @sVal, 0, getdate(), getdate(), 'SQLS' ) 

				If @@ROWCOUNT <= 0 
				 Begin
					Set @sCommentRefusSpb = 'La mise à jour du dossier SIMPA2 (création dt432_id_sin_emetteur (W) ) a échoué.'
					Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 109, @sCommentRefusSpb 
					Return -1
				 End 
			End
		 
		 -- [DT432_ISM261862] 
		 Update sysadm.w_gar_sin Set cod_etat = sysadm.FN_GET_ETAT_GARANTIE_PM251 ( id_sin, id_gti, 'W') where id_sin = @dcIdSin and id_gti = @dcIdGti 
		 Update sysadm.w_sin Set cod_etat = sysadm.FN_GET_ETAT_DOSSIER_PM251 ( id_sin, 'W') where id_sin = @dcIdSin 
		 -- [DT432_ISM261862] 
		  
	 End 	

	-- Traitement table permanente uniquement dans le cas il n'y a pas de dossier en table de travail, le rappatriement fera le reste.
	If @iDossierSinExiste > 0 And @iDossierWSinExiste <= 0 
	 Begin
	 	-- Le garantie UF existe-t-elle ?
	    If Exists ( 
			Select Top 1 1
			From sysadm.gar_sin g
			Where g.id_sin = @dcIdSin
			And   g.id_gti = @dcIdGti
		) 
		 -- Oui, elle existe
		 Begin
			Set @sMsgMajDossier = @sMsgMajDossier + 'La garantie UF existe déjà sur le dossier. '

			-- Maj date 1ère UF et dte_oppo si GTI UF non réglée
			-- La GTI UF est-elle réglée/refusée ?
			If Not Exists (
				Select Top 1 1
				From sysadm.gar_sin g
				Where g.id_sin = @dcIdSin
				And   g.id_gti = @dcIdGti
				And   g.cod_etat in ( 550, 600, 200 )
			)
			 -- Non, pas réglé, ni refusé
			 Begin
				-- Tentative de Maj date oppo et date 1ère UF sur le GTI UF
				Update sysadm.gar_sin Set dte_oppo = @dtDteOppo, dte_1er_uf = @dtDteUtil Where id_sin = @dcIdSin and id_gti = @dcIdGti
				
				If @@ROWCOUNT > 0 
				 -- Réussi (même si dte oppo présente, on écrase tant que GTI non réglé, vu avec Charline)
				 Begin
					Set @sMsgMajDossier = @sMsgMajDossier + 'La date d''opposition ('+ Convert ( varchar (10), @dtDteOppo, 103 ) + ') et la date de 1ère UF (date utilisation ' + Convert ( varchar (10), @dtDteUtil, 103 ) + ') provenant de la banque ont été mise à jour sur le dossier. '

					-- On remet la GTI dans un état d'instruction.
					Update sysadm.gar_sin 
					Set cod_dec_mac = 100, 
						cod_dec_ope = 100,
						cod_etat = 100,
						alt_ssui = 'N',
						cod_mot_ssui = 0
					Where id_sin = @dcIdSin 
					and id_gti = @dcIdGti

				 End 
				Else 
				 -- Echoué
				 Begin
					Set @sMsgMajDossier = @sMsgMajDossier + 'Problème technique, la date d''opposition et la date de 1ère UF (date utilisation) provenant de la banque n''ont pas été mise à jour sur le dossier. '
				 End 
			 End 
			Else
			 -- Oui, réglé
			 Begin
				Set @sMsgMajDossier = @sMsgMajDossier + 'La garantie UF est réglée ou partiellement réglée, donc l''automate ne modifie plus rien au niveau date d''oppo et date de 1ère UF sur la garantie. '
			 End 

		 End 
		Else 
		 -- Non, elle n'existe pas
		 Begin
		 	Set @sMsgMajDossier = @sMsgMajDossier + 'La garantie UF n''existe pas sur le dossier, l''automate créé la garantie UF avec la date d''opposition ' + Convert ( varchar (10), @dtDteOppo, 103 ) + 'et la date de 1ère UF (date utilisation ' + Convert ( varchar (10), @dtDteUtil ) + ') . '

			-- Création garantie et Maj date 1ère UF et dte_oppo si GTI UF non réglée
			Insert into sysadm.gar_sin (
					id_sin,
					id_gti,
					dte_oppo,
					heu_oppo,
					dte_1er_uf,
					mt_tot_prej,
					mt_prej_reg,
					mt_fran_reg,
					mt_nplaf_reg,
					mt_plaf_reg,
					mt_dedu_reg,
					mt_prov,
					cod_dec_mac,
					cod_dec_ope,
					cod_etat,
					dte_ouv,
					txt_mess,
					alt_plaf,
					alt_ssui,
					cod_mot_ssui,
					valide_le,
					valide_par,
					cree_le,
					maj_le,
					maj_par
				)
				Values 
				(
					@dcIdSin,
					@dcIdGti,
					@dtDteOppo,
					null,
					@dtDteUtil,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					100,
					100,
					100,
					Convert ( varchar ( 10), getdate(), 103 ),
					'Voir les contacts pour les infos provenant de la banque. ',
					'N',
					'N',
					0,
					getdate(),
					'SQLS',
					getdate(),
					getdate(),
					'SQLS'
				)

				If @@ROWCOUNT <= 0 
				 Begin
					Set @sCommentRefusSpb = 'Problème technique, la mise à jour du dossier SIMPA2 (création de la garantie (P) ) a échoué.'
					Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 110, @sCommentRefusSpb 
					Return -1
				 End 

		 End 

	 	-- Le détail de garantie existe-t-il pour cet évènement ?
	    If Exists ( 
			Select Top 1 1
			From sysadm.detail d with (nolock)
			Where d.id_sin = @dcIdSin
			And   d.id_gti = @dcIdGti
			And   d.id_evt = @dcIdEvt
		) 
		 -- Oui, il existe
		 Begin
			Set @sMsgMajDossier = @sMsgMajDossier + 'Le détail de garantie ' + CONVERT ( VarChar (10), @dcIdEvt ) + ' existe déjà sur la Garantie UF. '

			-- Le détail est-il réglé/réfusé ?
			If Exists (
				Select Top 1 1
				From sysadm.detail d with (nolock)
				Where d.id_sin = @dcIdSin
				And   d.id_gti = @dcIdGti
				And   d.id_evt = @dcIdEvt
				And   d.cod_etat in ( 100, 900 )
			)
			 -- Non, pas réglé/réfusé
			 Begin
				Set @sMsgMajDossier = @sMsgMajDossier + 'Il n''est pas réglé ni refusé, l''automate met donc à jour le détail de garantie avec le montant de préjudice (' + Convert ( varchar (15), @dcMtPrej) +'€), et la date d''utilisation (' + Convert ( Varchar (10), @dtDteUtil) + ').'

				Update sysadm.detail
				set mt_prej = @dcMtPrej,
					dte_det = @dtDteUtil,
					cod_dec_mac = 100, 
					cod_dec_ope = 100,
					cod_etat = 100,
					alt_ssui = 'N',
					cod_mot_ssui = 0
				Where id_sin = @dcIdSin
				And   id_gti = @dcIdGti
				And   id_evt = @dcIdEvt
				And   cod_etat in ( 100, 900 )

			 End 
			Else
			-- Oui, réglé/réfusé
			 Begin
			 	Set @sMsgMajDossier = @sMsgMajDossier + 'Il est déjà réglé ou refusé, l''automate ne met donc pas à jour le détail.'

			 End 
		 End 
		Else
		 -- Non, il n'existe pas
		 Begin
			Set @sMsgMajDossier = @sMsgMajDossier + 'Le détail de garantie ' + CONVERT ( VarChar (10), @dcIdEvt ) + ' n''existe pas sur la Garantie UF, l''automate créé le détail avec le montant de préjudice (' + Convert ( varchar (15), @dcMtPrej) +'€), et la date d''utilisation (' + Convert ( Varchar (10), @dtDteUtil, 103) + '). '

			Select @dcNewIdDetail = MAX ( id_detail )
			From sysadm.detail d with (nolock)
			Where d.id_sin = @dcIdSin
			And   d.id_gti = @dcIdGti

			If @dcNewIdDetail is null Set @dcNewIdDetail = 0
			Set @dcNewIdDetail = @dcNewIdDetail + 1

			Insert into sysadm.detail 
			(
				id_sin,
				id_gti,
				id_detail,
				id_evt,
				id_reg,
				id_i_reg,
				lib_det,
				dte_det,
				heu_det,
				num_carte,
				mt_prej,
				mt_fran,
				mt_nplaf,
				mt_plaf,
				alt_plaf,
				alt_reg,
				alt_att,
				alt_ssui,
				cod_mot_ssui,
				cod_dec_mac,
				cod_dec_ope,
				cod_etat,
				id_carte,
				id_type_carte,
				valide_le,
				valide_par,
				cree_le,
				maj_le,
				maj_par,
				dte_cmd,
				dte_livr,
				mt_val_achat,
				mt_val_publique,
				num_facture
			)
			Values
			(
				@dcIdSin,
				@dcIdGti,
				@dcNewIdDetail,
				@dcIdEvt,
				null,
				null,
				null,
				@dtDteUtil,
				null,
				null,
				@dcMtPrej,
				0,
				0,
				0,
				'N',
				'N',
				'O',
				'N',
				0,
				100,
				100,
				100,
				0,
				'00',
				GetDate(),
				'SQLS',
				GetDate(),
				GetDate(),
				'SQLS',
				null,
				null,
				0,
				0,
				null
			)

			If @@ROWCOUNT <= 0 
			 Begin
				Set @sCommentRefusSpb = 'Problème technique, la mise à jour du dossier SIMPA2 (création du détail (P) ) a échoué.'
				Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 111, @sCommentRefusSpb 
				Return -1
			 End 

		 End 

		 -- Mise à jour ou intsertion du Refus SCB (le cas échéant)
		 If @iMotifRefusEmetteur > 0 Or @sStatutEmetteur = 'ACCEPTE'
		   Begin
				Set @iValMx = @iMotifRefusEmetteur
				If @sStatutEmetteur = 'ACCEPTE' Set @iValMx = 99

				Update sysadm.div_det
				set maj_le = getdate(),
					maj_par = 'SQLS',
					valide_le = getdate(),
					valide_par = 'SQLS',
					val_car = 'M' + Convert ( varchar ( 5 ), @iValMx ) 
				From sysadm.div_det wdd,
					 sysadm.detail wd
				Where wd.id_sin = @dcIdSin
				And   wd.id_gti = @dcIdGti
				And   wd.id_evt = @dcIdEvt
				And   wd.cod_etat in ( 0, 1, 100, 900 )
				And   wdd.id_sin = wd.id_sin
				And   wdd.id_gti = wd.id_gti
				And   wdd.id_detail = wd.id_detail
				And   wdd.nom_zone = 'refus_scb'

				Set @iRowcount = @@RowCount
			  
			    If @iRowcount > 0 
				  Begin
					 If @iValMx = 99  Set @sMsgMajDossier = @sMsgMajDossier + 'L''automate met à jour ' + Convert ( varchar ( 5), @iRowcount ) + ' notification(s) SCB (M' + Convert ( varchar ( 5 ), @iValMx ) + ' : ' + sysadm.FN_CODE_CAR ( 'M' + Convert ( varchar ( 5 ), @iValMx ), '-WI') + ') sur l''onglet divers du détail de l''évènement ' + Convert ( varchar ( 5), @dcIdEvt) + '. '
					 Else Set @sMsgMajDossier = @sMsgMajDossier + 'L''automate met à jour ' + Convert ( varchar ( 5), @iRowcount ) + ' refus SCB (M' + Convert ( varchar ( 5 ), @iValMx ) + ' : ' + sysadm.FN_CODE_CAR ( 'M' + Convert ( varchar ( 5 ), @iValMx ), '-WI') + ') sur l''onglet divers du détail de l''évènement ' + Convert ( varchar ( 5), @dcIdEvt) + '. '
				  End 

			   Insert into sysadm.div_det
			   Select wd.id_sin,
					  wd.id_gti,
					  wd.id_detail,
					  dpd.nom_zone,
					  dpd.lib_label, 
					  dpd.id_typ_liste,
					  dpd.alt_liste_codecar,
					  dpd.id_typ_zone,
					  dpd.alt_oblig,
					  'N',
					  dpd.cpt_tri,
					  null,
					  null,
					  null,
					  'M' + Convert ( varchar ( 5 ), @iValMx ) ,
					  Getdate(),
					  getdate(),
					  'SQLS',
					  getdate(),
					  'SQLS'

			   From sysadm.div_pdet dpd with (nolock),
					sysadm.detail wd with (nolock)
			   Where wd.id_sin = @dcIdSin
			   And   wd.id_gti = @dcIdGti
			   And   wd.id_evt = @dcIdEvt
			   And   wd.cod_etat in ( 0, 1, 100, 900 )
			   And   dpd.id_prod = @dcIdProd
			   And   dpd.id_gti = @dcIdGti
			   And   dpd.nom_zone = 'refus_scb'
			   And Not exists ( 
					Select Top 1 1 
					From sysadm.div_det wdd
					Where wdd.id_sin = wd.id_sin
					And   wdd.id_gti = wd.id_gti
					And   wdd.id_detail = wd.id_detail
					And   wdd.nom_zone = 'refus_scb'
					And   wdd.val_car = 'M' + Convert ( varchar ( 5 ), @iValMx ) 
			   )

				Set @iRowcount = @@RowCount

			   If @iRowcount > 0 
				 Begin
					If @iValMx = 99  Set @sMsgMajDossier = @sMsgMajDossier + 'L''automate créé ' + Convert ( varchar ( 5), @iRowcount ) + ' notification(s) SCB (M' + Convert ( varchar ( 5 ), @iValMx ) + ' : ' + sysadm.FN_CODE_CAR ( 'M' + Convert ( varchar ( 5 ), @iValMx ), '-WI') +  ') sur l''onglet divers du détail de l''évènement ' + Convert ( varchar ( 5), @dcIdEvt) + '. '
					Else Set @sMsgMajDossier = @sMsgMajDossier + 'L''automate créé ' + Convert ( varchar ( 5), @iRowcount ) + ' refus SCB (M' + Convert ( varchar ( 5 ), @iValMx ) + ' : ' + sysadm.FN_CODE_CAR ( 'M' + Convert ( varchar ( 5 ), @iValMx ), '-WI') + ') sur l''onglet divers du détail de l''évènement ' + Convert ( varchar ( 5), @dcIdEvt) + '. '
				 End 
		   End 

		-- On marque l'id_seq de la table sysadm.dossier_auto_DT432 sur div_sin pour mémoire
		If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'dt432_id_seq_batch')
			Begin
				Select @sVal = lTrim ( rTrim ( wdv.val_car ))
				From sysadm.w_div_sin wdv with (nolock)
				Where wdv.id_sin = @dcIdSin
				And   wdv.nom_zone = 'dt432_id_seq_batch'

				If @sVal is null Set @sVal = ''
				Set @sVal = @sVal + '#' + CONVERT ( varchar ( 50), @aiIdSeq ) + '#'
				Set @sVal = Left ( REPLACE ( @sVal, '##', '#' ), 35 )

				Update sysadm.div_sin Set val_car = @sVal, maj_le = GETDATE(), maj_par = 'SQLS' Where id_sin = @dcIdSin And nom_zone = 'dt432_id_seq_batch'
			End 
		Else
			Begin	 
				Set @sVal = Left ( '#' + CONVERT ( varchar ( 50), @aiIdSeq ) + '#', 35 ) 
				Insert into sysadm.div_sin values ( @dcIdSin, 'dt432_id_seq_batch', 'ID batch auto utilisé', '-1', 'N', 'C', 'N', 'N', 120, null, null, null, @sVal, getdate(), getdate(), 'SQLS', getdate(), 'SQLS' ) 

				If @@ROWCOUNT <= 0 
				 Begin
					Set @sCommentRefusSpb = 'La mise à jour du dossier SIMPA2 (création dt432_id_seq_batch (P) ) a échoué.'
					Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 112, @sCommentRefusSpb 
					Return -1
				 End 
			End

		-- On marque l'id_sin_emetteur de la table sysadm.dossier_auto_DT432 sur div_sin pour mémoire
		If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @dcIdSin And nom_zone = 'dt432_id_sin_emetteur')
			Begin
				Select @sVal = lTrim ( rTrim ( wdv.val_car ))
				From sysadm.w_div_sin wdv with (nolock)
				Where wdv.id_sin = @dcIdSin
				And   wdv.nom_zone = 'dt432_id_sin_emetteur'

				If @sVal is null Set @sVal = ''
				Set @sVal = @sVal + '#' + @sIdSinEmetteur + '#'
				Set @sVal = Left ( REPLACE ( @sVal, '##', '#' ), 35 )

				Update sysadm.div_sin Set val_car = @sVal, maj_le = GETDATE(), maj_par = 'SQLS' Where id_sin = @dcIdSin And nom_zone = 'dt432_id_sin_emetteur'
			End 
		Else
			Begin	 
				Set @sVal = Left ( '#' + @sIdSinEmetteur + '#', 35 )
				Insert into sysadm.div_sin values ( @dcIdSin, 'dt432_id_sin_emetteur', 'Identifiant sinistre Bred', '-1', 'N', 'C', 'N', 'N', 121, null, null, null, @sVal, getdate(), getdate(), 'SQLS', getdate(), 'SQLS' ) 

				If @@ROWCOUNT <= 0 
				 Begin
					Set @sCommentRefusSpb = 'Problème technique, la mise à jour du dossier SIMPA2 (création dt432_id_sin_emetteur (P) ) a échoué.'
					Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 113, @sCommentRefusSpb 
					Return -1
				 End 
			End


	 End 	

	-- Dans les deux cas traités ci-dessus, on créé un Contact/travail et des contacts supplèmentaires si texte contacts trop long
	Set @sMsgMajDossier = @sMsgDecla + @sMsgMajDossier

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Set @iNbreTotContact = 0
		Set @iNumContact = 0
		Set @sMsgMajDossier = lTrim ( rtrim ( @sMsgMajDossier ) )
		Set @sMsgWrk = @sMsgMajDossier 

		If LEN ( @sMsgMajDossier ) <= 508 
		  Begin
			Set @iNbreTotContact = 1
			Set @iNumContact = 1
		  End 

		If LEN ( @sMsgMajDossier ) > 508 
		  Begin
			Set @iNumContact = 1
			Set @iNbreTotContact = Ceiling ( LEN ( @sMsgMajDossier ) / 471 ) + 1

			Set @sMsgWrk = Left ( @sMsgMajDossier, 471) + '...(suite sur prochain contact (' + Convert ( varchar ( 5 ), @iNumContact ) + '/' + Convert ( varchar ( 5 ), @iNbreTotContact ) + '))'
		  End 

		-- Contact/Travail
		EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMsgWrk, 'SQLS' , @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'B'
		Set @iNumContact = @iNumContact + 1

		While @iNumContact <= @iNbreTotContact
 		 Begin
	 		Set @sMsgMajDossier = Right ( @sMsgMajDossier, LEN ( @sMsgMajDossier ) - 471 )
			If @iNumContact = @iNbreTotContact 
			 Begin
				Set @sMsgWrk = Left ( @sMsgMajDossier, 471) + '(Fin message (' + Convert ( varchar ( 5 ), @iNumContact ) + '/' + Convert ( varchar ( 5 ), @iNbreTotContact ) + '))'
			 End 
			Else
			 Begin
				Set @sMsgWrk = Left ( @sMsgMajDossier, 471) + '...(suite sur prochain contact (' + Convert ( varchar ( 5 ), @iNumContact ) + '/' + Convert ( varchar ( 5 ), @iNbreTotContact ) + '))'
			 End 
			Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'B', @dcIdSin, 2, @sMsgWrk,	'SQLS', 300, @iIdCt OUTPUT							
	 		Set @iNumContact = @iNumContact + 1
		 End

	END
	ELSE
	BEGIN
		Set @iNbreTotContact = 0
		Set @iNumContact = 0
		Set @sMsgMajDossier = lTrim ( rtrim ( @sMsgMajDossier ) )
		Set @sMsgWrk = @sMsgMajDossier 

		If LEN ( @sMsgMajDossier ) <= 508 
		  Begin
			Set @iNbreTotContact = 1
			Set @iNumContact = 1
		  End 

		If LEN ( @sMsgMajDossier ) > 508 
		  Begin
			Set @iNumContact = 1
			Set @iNbreTotContact = Ceiling ( LEN ( @sMsgMajDossier ) / 471 ) + 1

			Set @sMsgWrk = Left ( @sMsgMajDossier, 471) + '...(suite sur prochain contact (' + Convert ( varchar ( 5 ), @iNumContact ) + '/' + Convert ( varchar ( 5 ), @iNbreTotContact ) + '))'
		  End 

		-- Contact/Travail
		EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMsgWrk, 'SQLS' , @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'B'
		Set @iNumContact = @iNumContact + 1

		While @iNumContact <= @iNbreTotContact
 		 Begin
	 		Set @sMsgMajDossier = Right ( @sMsgMajDossier, LEN ( @sMsgMajDossier ) - 471 )
			If @iNumContact = @iNbreTotContact 
			 Begin
				Set @sMsgWrk = Left ( @sMsgMajDossier, 471) + '(Fin message (' + Convert ( varchar ( 5 ), @iNumContact ) + '/' + Convert ( varchar ( 5 ), @iNbreTotContact ) + '))'
			 End 
			Else
			 Begin
				Set @sMsgWrk = Left ( @sMsgMajDossier, 471) + '...(suite sur prochain contact (' + Convert ( varchar ( 5 ), @iNumContact ) + '/' + Convert ( varchar ( 5 ), @iNbreTotContact ) + '))'
			 End 
			Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'B', @dcIdSin, 2, @sMsgWrk,	'SQLS', 300, @iIdCt OUTPUT							
	 		Set @iNumContact = @iNumContact + 1
		 End
	END
  End 

-- 2ème grand Cas, le dossier n'existe pas et est donc à créer.
-- Le dossier n'existe pas
If @iDossierSinExiste <= 0 And @iDossierWSinExiste <= 0
  Begin
  
	Set @sMsgDecla = LTRIM ( Rtrim ( @sMsgDecla ))

	If LEN ( @sMsgDecla ) > 254
	  Begin
		Set @sMsgWrk = Left ( @sMsgDecla, 223 ) + '...(voir contact pour la suite)'
	  End 

	-- Création du dossier sur SIMPA2 
	Exec @iRet = sysadm.Atlas_Sinistre_Creer_Dossier_V201 
			@iIdSin = @iIdSin OutPut,
			@iIdProd = @iIdProd,
			@iIdEts = @iIdEts,
			@sLibEts = null,
			@sIdAdh = @sIdAdh,
			@iIdsDos = @iIdsDos,
			@iOption = @iOption,
			@iIdNatSin = @iIdNatSin,
			@iIdTerrit = @iIdTerrit,
			@iIdDetSin = @iIdDetSin,
			@dtDteDec = @dtDteDecl,
			@dtDteSurv = @dtDteSurv,
			@dtDteAdh = @dtDteAdh,
			@dtDteSous = @dtDteAdh,
			@dtDteOpt = @dtDteOpt,
			@dtDteResil = @dtDteResil,
			@dtDteFinGti = @dtDteFinGti,
			@sCodCiv = @sCodCiv,
			@sNom = @sNom,
			@sPrenom = @sPrenom,
			@sAdr1 = @sAdr1,
			@sAdr2 = @sAdr2,
			@sAdrCp = @sAdrCp,
			@sAdrVille = @sAdrVille,
			@sNumTelD = @sNumTeld,
			@sNumTelB = null,
			@sNumFax = null,
			@sNumSms = null,
			@sAdrMail = @sAdrMail,
			@sIdCanal = 'B',
			@sCodiProv = 'B',
			@sMsg = @sMsgWrk,
			@sCodOper = 'SQLS',
			@sNumPort = null,
			@sNumImeiPort = null,
			@sMarqPort = null,
			@sModlPort = null,
			@dtAchPort = null,
			@dtOuvLigPort = null,
			@sIdContratAbonne = null,
			@iIdHlr = null,
			@iIdOrianMarque = null,
			@iIdOrianModele = null,
			@lIdBoutique = null,
			@idCodIc = null,
			@sRibBq = @sRibBq,
			@sRibGui = @sRibGui,
			@sRibCpt = @sRibCpt,
			@sRibCle = @sRibCle,
			@sRetour = @sRetour OutPut

	If @iRet < 1 
	  Begin
		If @sRetour is null Set @sRetour = ''
			Set @sCommentRefusSpb = Left ( 'La création du dossier SIMPA2 (sysadm.Atlas_Sinistre_Creer_Dossier_V201 ) a échoué. Message Retour : ' + @sRetour, 255 )
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 114, @sCommentRefusSpb 
		Return -1	  
	  End 				

	Set @dcIdSin = @iIdSin
	
	Set @sMsgMajDossier = @sMsgMajDossier + 'Aucun dossier répondant aux critères de déclaration n''existait, un dossier de sinistre (' + CONVERT ( Varchar ( 10 ), @dcIdSin ) + ') est donc créé. '


	Update sysadm.dossier_auto_DT432 Set id_sin = @dcIdSin Where id_seq = @aiIdSeq

	-- Création de la garantie UF
	Exec @iRet = sysadm.Atlas_Sinistre_Creer_Garantie_V100 
			@iIdSin = @iIdSin,          -- Numéro de sinistre
			@iIdGti = @iIdGti,          -- Numéro de la garantie à créer
			@sCodOper = 'SQLS',   -- Opérateur de déclaration 'WEB'
			@sRetour = @sRetour  Output -- Valeur de retour 'OK/ erreur'

	If @iRet < 0 -- et pas < 1 !! 
	  Begin
		If @sRetour is null Set @sRetour = ''
		Set @sCommentRefusSpb = Left ( 'La création du dossier SIMPA2 (sysadm.Atlas_Sinistre_Creer_Garantie_V100 ) a échoué. Message Retour : ' + @sRetour, 255 )
		Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 115, @sCommentRefusSpb 
		Return -1	  
	  End 

	Update sysadm.w_gar_sin Set dte_oppo = @dtDteOppo, dte_1er_uf = @dtDteUtil Where id_sin = @dcIdSin and id_gti = @dcIdGti

	Set @sMsgMajDossier = @sMsgMajDossier + 'La garantie UF est créée sur le dossier avec La date d''opposition ('+ Convert ( varchar (10), @dtDteOppo, 103 ) + ') et la date de 1ère UF (date utilisation ' + Convert ( varchar (10), @dtDteUtil, 103 ) + ') provenant de la banque. '
	
	-- Création du détail de garantie
	Exec @iRet = sysadm.Atlas_Gar_Sin_Creer_Detail_V101 
		@iIdSin = @iIdSin,  -- Numéro de sinistre  
		@iIdGti = @iIdGti,  -- Numéro de la garantie  
		@iIdEvt = @iIdEvt,  -- Numéro de l'évènement
		@dDteEvt = @dtDteUtil,  -- Date du détail (UF)
		@sLibDet = null, 
		@dcMtValAchat = 0, 
		@iIdDetail = @iIdDetail OUTPUT  

	Set @dcNewIdDetail = @iIdDetail

	If @iRet < 0 -- et pas < 1 !! 
	  Begin
		If @sRetour is null Set @sRetour = ''
		Set @sCommentRefusSpb = 'Problème technique, la création du dossier SIMPA2 (sysadm.Atlas_Gar_Sin_Creer_Detail_V101 ) a échoué.'
		Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 116, @sCommentRefusSpb 
		Return -1	  
	  End 

	-- On complète le détail
	Update sysadm.w_detail set mt_prej = @dcMtPrej Where id_sin = @dcIdSin And id_gti = @dcIdGti And id_detail = @dcNewIdDetail

	Set @sMsgMajDossier = @sMsgMajDossier + 'La détail de garantie avec l''évènement ' + Convert ( varchar (10), @iIdEvt) + ' est créé avec la date de 1ère UF ( date utilisation ' + Convert ( varchar (10), @dtDteUtil, 103 ) + ') et le montant de préjudice ' + convert ( varchar (15), @dcMtPrej) + '€. '

	-- Mise à jour ou intsertion du Refus SCB (le cas échéant)
	If @iMotifRefusEmetteur > 0 Or @sStatutEmetteur = 'ACCEPTE'
		Begin
			Set @iValMx = @iMotifRefusEmetteur
			If @sStatutEmetteur = 'ACCEPTE' Set @iValMx = 99

			Insert into sysadm.w_div_det
			Select  wd.id_sin,
					wd.id_gti,
					wd.id_detail,
					dpd.nom_zone,
					dpd.lib_label, 
					dpd.id_typ_liste,
					dpd.alt_liste_codecar,
					dpd.id_typ_zone,
					dpd.alt_oblig,
					'N',
					dpd.cpt_tri,
					null,
					null,
					null,
					'M' + Convert ( varchar ( 5 ), @iValMx ) ,
					0,
					Getdate(),
					getdate(),
					'SQLS'

			From sysadm.div_pdet dpd with (nolock),
				 sysadm.w_detail wd with (nolock)
			Where wd.id_sin = @dcIdSin
			And   wd.id_gti = @dcIdGti
			And   wd.id_evt = @dcIdEvt
			And   wd.cod_etat in ( 0, 1, 100, 900 )
			And   dpd.id_prod = @dcIdProd
			And   dpd.id_gti = @dcIdGti
			And   dpd.nom_zone = 'refus_scb'

			Set @iRowcount = @@RowCount

			If @@RowCount > 0 
				Begin
					If @iValMx = 99  Set @sMsgMajDossier = @sMsgMajDossier + 'L''automate créé ' + Convert ( varchar ( 5), @iRowcount ) + ' notification(s) SCB (M' + Convert ( varchar ( 5 ), @iValMx ) + ' : ' + sysadm.FN_CODE_CAR ( 'M' + Convert ( varchar ( 5 ), @iValMx ), '-WI') +  ') sur l''onglet divers du détail de l''évènement ' + Convert ( varchar ( 5), @dcIdEvt) + '. '
					Else Set @sMsgMajDossier = @sMsgMajDossier + 'L''automate créé ' + Convert ( varchar ( 5), @iRowcount ) + ' refus SCB (M' + Convert ( varchar ( 5 ), @iValMx ) + ' : ' + sysadm.FN_CODE_CAR ( 'M' + Convert ( varchar ( 5 ), @iValMx ), '-WI') + ') sur l''onglet divers du détail de l''évènement ' + Convert ( varchar ( 5), @dcIdEvt) + '. '
				End 
		End 

	-- On marque l'id_seq de la table sysadm.dossier_auto_DT432 sur w_div_sin pour mémoire
	Set @sVal = Left ( '#' + CONVERT ( varchar ( 50), @aiIdSeq ) + '#' , 35 )
	Insert into sysadm.w_div_sin values ( @dcIdSin, 'dt432_id_seq_batch', 'ID batch auto utilisé', '-1', 'N', 'C', 'N', 'N', 120, null, null, null, @sVal, 0, getdate(), getdate(), 'SQLS' ) 
	
	If @@ROWCOUNT <= 0 
	 Begin
		Set @sCommentRefusSpb = 'Problème technique, la création du dossier SIMPA2 (création dt432_id_seq_batch (W) ) a échoué.'
		Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 117, @sCommentRefusSpb 
		Return -1
	 End 

	-- On marque l'id_sin_emetteur de la table sysadm.dossier_auto_DT432 sur div_sin pour mémoire
	Set @sVal = Left ( '#' + @sIdSinEmetteur + '#' , 35 )
	Insert into sysadm.w_div_sin values ( @dcIdSin, 'dt432_id_sin_emetteur', 'Identifiant sinistre Bred', '-1', 'N', 'C', 'N', 'N', 121, null, null, null, @sVal, 0, getdate(), getdate(), 'SQLS' ) 

	If @@ROWCOUNT <= 0 
	 Begin
		Set @sCommentRefusSpb = 'Problème technique, la création du dossier SIMPA2 (création dt432_id_sin_emetteur (W) ) a échoué.'
		Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 117, @sCommentRefusSpb 
		Return -1
	 End 

	-- Création de la déclaration sur SHERPA
	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Select @iIdProdAdh = p.cod_prod_dms
		From   sysadm.produit p with (nolock)
		Where  p.id_prod = @dcIdProd

		Select @iIdCli = adh.id_cli
		From   SHERPA_PRO.sysadm.adhesion adh with (nolock)
		Where  adh.id_prod_adh = @iIdProdAdh
		And    adh.id_ets = @dcIdEts
		And    adh.id_adh = @sIdAdh
		And    adh.id_sdos = @dcIdsDos

		If @iIdCli is Null Set @iIdCli = 0

		If @iIdCli <= 0 
		  Begin
			If @sRetour is null Set @sRetour = ''
			Set @sCommentRefusSpb = 'Problème technique, la création du dossier SIMPA2 (récup ID_CLIENT sur sysadm.adhesion adh ) a échoué.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 118, @sCommentRefusSpb 
			Return -1	  
		  End 

		Set @sMsgDecla = @sMsgDecla + @sMsgMajDossier	

		Set @iNbreTotContact = 0
		Set @iNumContact = 0
		Set @sMsgWrk = @sMsgDecla 

		If LEN ( @sMsgDecla ) <= 508 
		  Begin
			Set @iNbreTotContact = 1
			Set @iNumContact = 1
		  End 

		If LEN ( @sMsgDecla ) > 508 
		  Begin
			Set @iNumContact = 1
			Set @iNbreTotContact = Ceiling ( LEN ( @sMsgDecla ) / 471 ) + 1

			Set @sMsgWrk = Left ( @sMsgDecla, 471) + '...(suite sur prochain contact (' + Convert ( varchar ( 5 ), @iNumContact ) + '/' + Convert ( varchar ( 5 ), @iNbreTotContact ) + '))'
		  End 


		Exec @iRet = SHERPA_PRO.sysadm.Atlas_Contact_Creer_Declaration_V200
				@iIdCli      = @iIdCli,      -- Le n° de client
				@iIdSin      = @iIdSin,      -- Le n° de sinistre
				@iIdAppli    = 2,      -- Le code application
				@sMess       = 'Déclaration provenant de la BRED par Batch automatique, voir les contacts suivant pour le détail.', --@sMsgWrk, 
				@iIdCt       = @iIdCt OUTPUT , 
				@iIdNatTache = 0,     -- Le code résultat de contact
				@sIdAdh      = @sIdAdh,   -- Le n° d'adhésion / de carte
				@iIdProd     = @iIdProd,       -- Le code produit
				@iIdEts      = @iIdEts,       -- Le code ets
				@iIdsDos     = @iIdsDos  ,     -- Le sous dossier
				@sCodInter   = 'A',   -- L'interlocuteur de déclaration
				@sCanal      = 'B',   -- Le canal de déclaration (Batch)
				@dtDteSurv	 = @dtDteSurv,	    -- La date de survenance
				@dtDteDec	 = @dtDteDecl,       -- La date de déclaration
				@dtCourCli	 = @dtDteDecl, 		 -- Date de l'acte de déclaration
				@dtRecu      = @dtDteDecl       -- Date de réception de la déclaration

		If @iRet <> 0 
		  Begin
			If @sRetour is null Set @sRetour = ''
			Set @sCommentRefusSpb = 'Problème technique, la création du dossier SIMPA2 (sysadm.Atlas_Contact_Creer_Declaration_V200 ) a échoué.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 119, @sCommentRefusSpb 
			Return -1	  
		  End 

		Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'B', @dcIdSin, 2, @sMsgWrk,	'SQLS', 300, @iIdCt OUTPUT							
		Set @iNumContact = @iNumContact + 1

	
		While @iNumContact <= @iNbreTotContact
 		 Begin
	 		Set @sMsgDecla = Right ( @sMsgDecla, LEN ( @sMsgDecla ) - 470 )
			If @iNumContact = @iNbreTotContact 
			 Begin
				Set @sMsgWrk = Left ( @sMsgDecla, 471) + '(Fin message (' + Convert ( varchar ( 5 ), @iNumContact ) + '/' + Convert ( varchar ( 5 ), @iNbreTotContact ) + '))'
			 End 
			Else
			 Begin
				Set @sMsgWrk = Left ( @sMsgDecla, 471) + '...(suite sur prochain contact (' + Convert ( varchar ( 5 ), @iNumContact ) + '/' + Convert ( varchar ( 5 ), @iNbreTotContact ) + '))'
			 End 
			Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'B', @dcIdSin, 2, @sMsgWrk,	'SQLS', 300, @iIdCt OUTPUT							
	 		Set @iNumContact = @iNumContact + 1
		 End

	END
	Else
	Begin
		Select @iIdProdAdh = p.cod_prod_dms
		From   sysadm.produit p with (nolock)
		Where  p.id_prod = @dcIdProd

		Select @iIdCli = adh.id_cli
		From   SHERPA_SIM.sysadm.adhesion adh with (nolock)
		Where  adh.id_prod_adh = @iIdProdAdh
		And    adh.id_ets = @dcIdEts
		And    adh.id_adh = @sIdAdh
		And    adh.id_sdos = @dcIdsDos

		If @iIdCli is Null Set @iIdCli = 0

		If @iIdCli <= 0 
		  Begin
			If @sRetour is null Set @sRetour = ''
			Set @sCommentRefusSpb = 'Problème technique, la création du dossier SIMPA2 (récup ID_CLIENT sur sysadm.adhesion adh ) a échoué.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 120, @sCommentRefusSpb 
			Return -1	  
		  End 

		Set @sMsgDecla = @sMsgDecla + @sMsgMajDossier	

		Set @iNbreTotContact = 0
		Set @iNumContact = 0
		Set @sMsgWrk = @sMsgDecla 

		If LEN ( @sMsgDecla ) <= 508 
		  Begin
			Set @iNbreTotContact = 1
			Set @iNumContact = 1
		  End 

		If LEN ( @sMsgDecla ) > 508 
		  Begin
			Set @iNumContact = 1
			Set @iNbreTotContact = Ceiling ( LEN ( @sMsgDecla ) / 471 ) + 1

			Set @sMsgWrk = Left ( @sMsgDecla, 471) + '...(suite sur prochain contact (' + Convert ( varchar ( 5 ), @iNumContact ) + '/' + Convert ( varchar ( 5 ), @iNbreTotContact ) + '))'

		  End 

		Exec @iRet = SHERPA_SIM.sysadm.Atlas_Contact_Creer_Declaration_V200
				@iIdCli      = @iIdCli,      -- Le n° de client
				@iIdSin      = @iIdSin,      -- Le n° de sinistre
				@iIdAppli    = 2,      -- Le code application
				@sMess       = 'Déclaration provenant de la BRED par Batch automatique, voir les contacts suivant pour le détail.', --@sMsgWrk, , 
				@iIdCt       = @iIdCt OUTPUT , 
				@iIdNatTache = 0,     -- Le code résultat de contact
				@sIdAdh      = @sIdAdh,   -- Le n° d'adhésion / de carte
				@iIdProd     = @iIdProd,       -- Le code produit
				@iIdEts      = @iIdEts,       -- Le code ets
				@iIdsDos     = @iIdsDos  ,     -- Le sous dossier
				@sCodInter   = 'A',   -- L'interlocuteur de déclaration
				@sCanal      = 'B',   -- Le canal de déclaration (Batch)
				@dtDteSurv	 = @dtDteSurv,	    -- La date de survenance
				@dtDteDec	 = @dtDteDecl,       -- La date de déclaration
				@dtCourCli	 = @dtDteDecl, 		 -- Date de l'acte de déclaration
				@dtRecu      = @dtDteDecl       -- Date de réception de la déclaration

		If @iRet <> 0 
		  Begin
			If @sRetour is null Set @sRetour = ''
			Set @sCommentRefusSpb = 'La création du dossier SIMPA2 (sysadm.Atlas_Contact_Creer_Declaration_V200 ) a échoué.'
			Exec sysadm.PS_U_DT432_ERREUR_TRT @aiIdSeq, 121, @sCommentRefusSpb 
			Return -1	  
		  End 

		Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'B', @dcIdSin, 2, @sMsgWrk,	'SQLS', 300, @iIdCt OUTPUT							
		Set @iNumContact = @iNumContact + 1


		While @iNumContact <= @iNbreTotContact
 		 Begin
	 		Set @sMsgDecla = Right ( @sMsgDecla, LEN ( @sMsgDecla ) - 470 )
			If @iNumContact = @iNbreTotContact 
			 Begin
				Set @sMsgWrk = Left ( @sMsgDecla, 471) + '(Fin message (' + Convert ( varchar ( 5 ), @iNumContact ) + '/' + Convert ( varchar ( 5 ), @iNbreTotContact ) + '))'
			 End 
			Else
			 Begin
				Set @sMsgWrk = Left ( @sMsgDecla, 471) + '...(suite sur prochain contact (' + Convert ( varchar ( 5 ), @iNumContact ) + '/' + Convert ( varchar ( 5 ), @iNbreTotContact ) + '))'
			 End 
			Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'B', @dcIdSin, 2, @sMsgWrk,	'SQLS', 300, @iIdCt OUTPUT							
	 		Set @iNumContact = @iNumContact + 1
		 End
	
	End 
  End 

Return @iRet

Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_S_DT432_LECT_LOG_PAR_ETL_APRES_TRT
-- Auteur               :       JFF
-- Date                 :       06/10/2020
-- Libelle              :       
-- Commentaires         :       [DT432]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Integer : 1 succès d'intégration / -1 Echec d'intégration
-------------------------------------------------------------------
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_DT432_LECT_LOG_PAR_ETL_APRES_TRT' AND type = 'P' )
        DROP procedure sysadm.PS_S_DT432_LECT_LOG_PAR_ETL_APRES_TRT
GO

CREATE procedure sysadm.PS_S_DT432_LECT_LOG_PAR_ETL_APRES_TRT
	@asFiltre VarChar ( 100 )
AS

Declare @dtMinTraiteLe DateTime

Set @asFiltre = UPPER ( LTRIM ( RTRIM ( @asFiltre )))

If @asFiltre = 'TOUS'
 Begin
	Select @dtMinTraiteLe = Min ( traite_le ) 
	From sysadm.dossier_auto_DT432
	Where etat_trt not in ( 'INTEGRATION_PROV_ETL', 'EN_COURS_TRT' )
	And   etat_log = 'NON_LU_PAR_ETL'
	
	Select 
		id_seq,
		id_projet,
		id_sin_emetteur,
		id_num_fic_emetteur,
		id_prod,
		id_ets,
		id_adh,
		id_sdos,
		cod_opt,
		dte_opt,
		id_natsin,
		id_territ,
		id_detsin,
		dte_decl,
		dte_surv,
		heu_surv,
		dte_oppo,
		dte_util,
		dte_adh,
		dte_resil,
		dte_fin_gti,
		cod_civ,
		nom,
		prenom,
		dte_nais,
		adr_1,
		adr_2,
		adr_cp,
		adr_ville,
		num_teld,
		id_gti,
		iban,
		adr_mail,
		id_evt,
		mt_prej,
		statut_emetteur,
		mt_uf_charge_spb,
		mt_fran_charge_assure,
		motif_refus_emetteur,
		id_sin,
		dte_integr,
		0 mt_reg_spb, -- Je force à 0 si jamais l'extraction des réglés avait déjà posé un réglement
		motif_refus_spb,
		comment_refus_spb,
		etat_trt,
		traite_le,
		traite_par,
		Case 
			When motif_refus_spb <= 99 Then
				convert( varchar ( 10), CONVERT ( Datetime, @dtMinTraiteLe , 103 ), 112 )  + '_' + 
				replace ( Convert ( varchar (30), @dtMinTraiteLe, 114 ), ':', '' ) + '_REJETS_ET_SUCCES_SINISTRES_LOT_SPB_' + Convert ( varchar ( 10), id_lot_trt) + '_ID_FIC_BRED_' + id_num_fic_emetteur + '_LOG_BRED'
			Else 
				convert( varchar ( 10), CONVERT ( Datetime, @dtMinTraiteLe , 103 ), 112 )  + '_' + 
				replace ( Convert ( varchar (30), @dtMinTraiteLe, 114 ), ':', '' ) + '_REJETS_SINISTRES_LOT_SPB_' + Convert ( varchar ( 10), id_lot_trt ) + '_ID_FIC_BRED_' +  id_num_fic_emetteur + '_LOG_AUTRES_DEST'
		End 'nom_fic_log'

	From sysadm.dossier_auto_DT432
	Where etat_trt not in ( 'INTEGRATION_PROV_ETL', 'EN_COURS_TRT' )
	And   etat_log = 'NON_LU_PAR_ETL'
	Order By
		Case 
			When motif_refus_spb <= 99 Then
				convert( varchar ( 10), CONVERT ( Datetime, @dtMinTraiteLe , 103 ), 112 )  + '_' + 
				replace ( Convert ( varchar (30), @dtMinTraiteLe, 114 ), ':', '' ) + '_REJETS_ET_SUCCES_SINISTRES_LOT_SPB_' + Convert ( varchar ( 10), id_lot_trt) + '_ID_FIC_BRED_' +  id_num_fic_emetteur + '_LOG_BRED'
			Else 
				convert( varchar ( 10), CONVERT ( Datetime, @dtMinTraiteLe , 103 ), 112 )  + '_' + 
				replace ( Convert ( varchar (30), @dtMinTraiteLe, 114 ), ':', '' ) + '_REJETS_SINISTRES_LOT_SPB_' + Convert ( varchar ( 10), id_lot_trt) + '_ID_FIC_BRED_' +  id_num_fic_emetteur + '_LOG_AUTRES_DEST'
		End,
		id_seq
 End 

If @asFiltre <> 'TOUS'
 Begin
	Select @dtMinTraiteLe = Min ( traite_le ) 
	From sysadm.dossier_auto_DT432
	Where etat_trt not in ( 'INTEGRATION_PROV_ETL', 'EN_COURS_TRT' )
	And   etat_trt = @asFiltre
	And   etat_log = 'NON_LU_PAR_ETL'

	Select 
		id_seq,
		id_projet,
		id_sin_emetteur,
		id_num_fic_emetteur,
		id_prod,
		id_ets,
		id_adh,
		id_sdos,
		cod_opt,
		dte_opt,
		id_natsin,
		id_territ,
		id_detsin,
		dte_decl,
		dte_surv,
		heu_surv,
		dte_oppo,
		dte_util,
		dte_adh,
		dte_resil,
		dte_fin_gti,
		cod_civ,
		nom,
		prenom,
		dte_nais,
		adr_1,
		adr_2,
		adr_cp,
		adr_ville,
		num_teld,
		id_gti,
		iban,
		adr_mail,
		id_evt,
		mt_prej,
		statut_emetteur,
		mt_uf_charge_spb,
		mt_fran_charge_assure,
		motif_refus_emetteur,
		id_sin,
		dte_integr,
		0 mt_reg_spb, -- Je force à 0 si jamais l'extraction des réglés avait déjà posé un réglement
		motif_refus_spb,
		comment_refus_spb,
		etat_trt,
		traite_le,
		traite_par,
		Case 
			When motif_refus_spb <= 99 Then
				convert( varchar ( 10), CONVERT ( Datetime, @dtMinTraiteLe , 103 ), 112 )  + '_' + 
				replace ( Convert ( varchar (30), @dtMinTraiteLe, 114 ), ':', '' ) + '_REJETS_ET_SUCCES_SINISTRES_LOT_SPB_' + Convert ( varchar ( 10), id_lot_trt) + '_ID_FIC_BRED_' +  id_num_fic_emetteur + '_LOG_BRED'
			Else 
				convert( varchar ( 10), CONVERT ( Datetime, @dtMinTraiteLe , 103 ), 112 )  + '_' + 
				replace ( Convert ( varchar (30), @dtMinTraiteLe, 114 ), ':', '' ) + '_REJETS_SINISTRES_LOT_SPB_' + Convert ( varchar ( 10), id_lot_trt) + '_ID_FIC_BRED_' +  id_num_fic_emetteur + '_LOG_AUTRES_DEST'
		End 'nom_fic_log'

	From sysadm.dossier_auto_DT432
	Where etat_trt not in ( 'INTEGRATION_PROV_ETL', 'EN_COURS_TRT' )
	And   etat_trt = @asFiltre
	And   etat_log = 'NON_LU_PAR_ETL'
	Order By
		Case 
			When motif_refus_spb <= 99 Then
				convert( varchar ( 10), CONVERT ( Datetime, @dtMinTraiteLe , 103 ), 112 )  + '_' + 
				replace ( Convert ( varchar (30), @dtMinTraiteLe, 114 ), ':', '' ) + '_REJETS_ET_SUCCES_SINISTRES_LOT_SPB_' + Convert ( varchar ( 10), id_lot_trt) + '_ID_FIC_BRED_' +  id_num_fic_emetteur + '_LOG_BRED'
			Else 
				convert( varchar ( 10), CONVERT ( Datetime, @dtMinTraiteLe , 103 ), 112 )  + '_' + 
				replace ( Convert ( varchar (30), @dtMinTraiteLe, 114 ), ':', '' ) + '_REJETS_SINISTRES_LOT_SPB_' + Convert ( varchar ( 10), id_lot_trt) + '_ID_FIC_BRED_' +  id_num_fic_emetteur + '_LOG_AUTRES_DEST'
		End,
		id_seq

 End 
 
Go

--------------------------------------------------------------------
--
-- Procedure            :       PS_U_DT432_MARQUAGE_LOG_PAR_ETL_APRES_TRT
-- Auteur               :       JFF
-- Date                 :       06/10/2020
-- Libelle              :       
-- Commentaires         :       [DT432]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       Integer : 1 succès d'intégration / -1 Echec d'intégration
-------------------------------------------------------------------
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_DT432_MARQUAGE_LOG_PAR_ETL_APRES_TRT' AND type = 'P' )
        DROP procedure sysadm.PS_U_DT432_MARQUAGE_LOG_PAR_ETL_APRES_TRT
GO

CREATE procedure sysadm.PS_U_DT432_MARQUAGE_LOG_PAR_ETL_APRES_TRT
	@aiIdSeq Integer
AS

Declare @iRet Integer

If @aiIdSeq > 0 
 Begin
	Update sysadm.dossier_auto_DT432 
	Set etat_log = 'LU_PAR_ETL', 
		log_lu_le = GETDATE() 
	Where id_seq = @aiIdSeq 
	and   etat_log = 'NON_LU_PAR_ETL' 
	and   etat_trt not in ( 'INTEGRATION_PROV_ETL', 'EN_COURS_TRT' )

	Set @iRet = @@ROWCOUNT

	IF @iRet > 0 Return @iRet 

 End

If @aiIdSeq < 0 
 Begin
	Update sysadm.dossier_auto_DT432 
	Set etat_log = 'LU_PAR_ETL', 
		log_lu_le = GETDATE() 
	Where etat_log = 'NON_LU_PAR_ETL' 
	and	  etat_trt not in ( 'INTEGRATION_PROV_ETL', 'EN_COURS_TRT' )

	Set @iRet = @@ROWCOUNT

	IF @iRet > 0 Return @iRet 

 End

 Return -1

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_S_DT432_ETAT_MENSUEL
-- Auteur               :       JFF
-- Date                 :       06/10/2020
-- Libelle              :       
-- Commentaires         :       [DT432]
-- References           :       
-- Arguments            :       
--
-- Retourne             :       
-------------------------------------------------------------------
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_DT432_ETAT_MENSUEL' AND type = 'P' )
        DROP procedure sysadm.PS_S_DT432_ETAT_MENSUEL
GO

CREATE procedure sysadm.PS_S_DT432_ETAT_MENSUEL
	@dtDteDeb       DateTime,
    @dtDteFin       DateTime
As

Select	da.id_seq,
		da.id_projet,
		da.id_sin_emetteur,
		da.id_prod,
		da.id_ets,
		da.id_adh,
		da.id_sdos,
		da.cod_opt,
		da.dte_opt,
		da.id_natsin,
		da.id_territ,
		da.id_detsin,
		da.dte_decl,
		da.dte_surv,
		da.heu_surv,
		da.dte_oppo,
		da.dte_util,
		da.dte_adh,
		da.dte_resil,
		da.dte_fin_gti,
		da.cod_civ,
		da.nom,
		da.prenom,
		da.adr_1,
		da.adr_2,
		da.adr_cp,
		da.adr_ville,
		da.num_teld,
		da.id_gti,
		da.iban,
		da.adr_mail,
		da.id_evt,
		da.mt_prej,
		da.statut_emetteur,
		da.mt_uf_charge_spb,
		da.mt_fran_charge_assure,
		da.motif_refus_emetteur,
		da.id_sin,
		da.dte_integr,
		da.mt_reg_spb,
		da.motif_refus_spb,
		da.comment_refus_spb,
		da.etat_trt,
		da.cree_le,
		da.cree_par,
		da.traite_le,
		da.traite_par,
		da.etat_log,
		da.log_lu_le

From   sysadm.dossier_auto_DT432 da
Where  da.traite_le between @dtDteDeb and @dtDteFin

Go


--------------------------------------------------------------------
-- Procédure            :       PS_S_DT432_ENVOI_MAIL_LOG_ERREUR
-- Auteur               :       Fabry JF
-- Date                 :       30/12/2020
-- Libellé              :		[DT432]
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF		10/09/2024   [20240910162546267] Changement chemin UNC Serveur fichier prod
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_DT432_ENVOI_MAIL_LOG_ERREUR' AND type = 'P' )
        DROP procedure sysadm.PS_S_DT432_ENVOI_MAIL_LOG_ERREUR
GO

CREATE procedure sysadm.PS_S_DT432_ENVOI_MAIL_LOG_ERREUR
AS

declare @sRetourErrMail varchar (255) 
declare @sAdrMail varchar (255) 
declare @sAdrMailCc varchar (255) 
declare @sAliasFrom varchar (255) 
declare @sMailFrom varchar (255) 
declare @sMailObjet varchar (255) 
declare @sMailBody varchar (8000) 
declare @asNomFicOrigCourt varchar (100) 
declare @sSaut	VarChar (10)
declare @sAppliEnv VarChar (30)
declare @iErrImpFile integer

Declare @iIdSeqTtp integer
Declare @iNbreRefusTtp integer
Declare @iMotifRefusSpbTtp integer
Declare @sCommentRefusSpbTtp VarChar (255)
Declare @sAdrMailLogTtp VarChar ( 128 )
Declare @sAdrMailLogTtpSav VarChar ( 128 )
Declare @sAdrMailCcLogTtp VarChar ( 128 )
Declare @sAdrMailCcLogTtpSav VarChar ( 128 )
Declare @dtMinTraiteLe Datetime
Declare @iIdLotTtp Integer
Declare @iIdNumFicEmetteur Integer 
Declare @sNomFicLog VarChar ( 255 )

Set @sSaut = Char (10)
Set @iErrImpFile = 0
Set @sMailObjet = @sMailObjet + ''

DECLARE @tb TABLE 
	( id_seq_ttp integer identity,
	  id_lot_ttp integer,
	  id_num_fic_emetteur integer,
	  nbre_refus_ttp	integer,
	  motif_refus_spb_ttp integer,
	  comment_refus_spb_ttp varchar ( 255 ),
	  adr_mail_log_ttp varchar ( 128 ),
	  adr_mail_cc_log_ttp varchar ( 128 ),
	  marquage_ttp	integer null 
	)


Insert into @tb
Select	id_lot_trt, 
		id_num_fic_emetteur,
		count (*),
		motif_refus_spb, 
		rtrim ( ltrim ( comment_refus_spb) ),
		Case
			When motif_refus_spb >0 And motif_refus_spb <= 99 Then 'clemarchand@spb.eu,sdelesque@spb.eu'
			When motif_refus_spb >99 And motif_refus_spb <= 199 Then 'ntonnetot@spb.eu,cmathe@spb.eu,ayvon@spb.eu,jff@spb.fr,cbourdoiseau@spb.eu'
			When motif_refus_spb >199 And motif_refus_spb <= 299 Then 'ilegall@spb.eu'
			When motif_refus_spb >299 And motif_refus_spb <= 399 Then 'sbarthelemy@spb.eu,cbourdoiseau@spb.eu'
			Else 'jff@spb.fr'
		End 'adr_mail_log',
		Case 
			When motif_refus_spb >0 And motif_refus_spb <= 99 Then 'jff@spb.fr,sbarthelemy@spb.eu'
			When motif_refus_spb >99 And motif_refus_spb <= 199 Then 'clemarchand@spb.eu,sdelesque@spb.eu,jff@spb.fr,sbarthelemy@spb.eu'
			When motif_refus_spb >199 And motif_refus_spb <= 299 Then 'clemarchand@spb.eu,sdelesque@spb.eu,jff@spb.fr,sbarthelemy@spb.eu'
			When motif_refus_spb >299 And motif_refus_spb <= 399 Then 'clemarchand@spb.eu,sdelesque@spb.eu,jff@spb.fr,sbarthelemy@spb.eu'
			Else ''
		End 'adr_mail_cc_log',
		0
From sysadm.dossier_auto_DT432
Where motif_refus_spb > 0 
And   etat_log = 'NON_LU_PAR_ETL'
Group By 
		id_lot_trt,
		id_num_fic_emetteur,
		motif_refus_spb, 
		comment_refus_spb,
		Case
			When motif_refus_spb >0 And motif_refus_spb <= 99 Then 'clemarchand@spb.eu,sdelesque@spb.eu'
			When motif_refus_spb >99 And motif_refus_spb <= 199 Then 'ntonnetot@spb.eu,cmathe@spb.eu,ayvon@spb.eu,jff@spb.fr,cbourdoiseau@spb.eu'
			When motif_refus_spb >199 And motif_refus_spb <= 299 Then 'ilegall@spb.eu'
			When motif_refus_spb >299 And motif_refus_spb <= 399 Then 'sbarthelemy@spb.eu,cbourdoiseau@spb.eu'
			Else 'jff@spb.fr'
		End,
		Case 
			When motif_refus_spb >0 And motif_refus_spb <= 99 Then 'jff@spb.fr,sbarthelemy@spb.eu'
			When motif_refus_spb >99 And motif_refus_spb <= 199 Then 'clemarchand@spb.eu,sdelesque@spb.eu,jff@spb.fr,sbarthelemy@spb.eu'
			When motif_refus_spb >199 And motif_refus_spb <= 299 Then 'clemarchand@spb.eu,sdelesque@spb.eu,jff@spb.fr,sbarthelemy@spb.eu'
			When motif_refus_spb >299 And motif_refus_spb <= 399 Then 'clemarchand@spb.eu,sdelesque@spb.eu,jff@spb.fr,sbarthelemy@spb.eu'
			Else ''
		End
Order by adr_mail_log

-- Insert de la ligne d'arrêt
If Exists ( Select Top 1 1 From @tb ) 
  Begin
	Insert into @tb Values ( -1, -1, -1, -1, '', 'xx_fin_xx@spb.fr', '', 0 ) 
  End 

Set @sAdrMailLogTtpSav = ''
Set @sAdrMailCcLogTtpSav = ''

Select @dtMinTraiteLe = Min ( traite_le )
From sysadm.dossier_auto_DT432
Where etat_trt not in ( 'INTEGRATION_PROV_ETL', 'EN_COURS_TRT' )
And   etat_log = 'NON_LU_PAR_ETL'


While Exists ( Select Top 1 1 From @tb where marquage_ttp = 0 )
 Begin
	Select 	Top 1 
		@iIdSeqTtp = id_seq_ttp,
		@iIdLotTtp = id_lot_ttp,
		@iIdNumFicEmetteur = id_num_fic_emetteur,
		@iNbreRefusTtp = nbre_refus_ttp,
		@iMotifRefusSpbTtp = motif_refus_spb_ttp,
		@sCommentRefusSpbTtp = comment_refus_spb_ttp,
		@sAdrMailLogTtp = adr_mail_log_ttp,
		@sAdrMailCcLogTtp = adr_mail_cc_log_ttp
	From	@tb t1
	Where	t1.marquage_ttp = 0
	And     t1.id_seq_ttp = ( Select MIN ( t2.id_seq_ttp ) From @tb t2 where t2.marquage_ttp = t1.marquage_ttp )

	IF @sAdrMailLogTtp is null Set @sAdrMailLogTtp = ''
	IF @sAdrMailCcLogTtp is null Set @sAdrMailCcLogTtp = ''

	If @sAdrMailLogTtpSav <> @sAdrMailLogTtp And @sAdrMailLogTtpSav <> ''
	  Begin
		-- Faire partir le précédent mail		
		Set @sMailBody = @sMailBody + @sSaut 
		Set @sMailBody = @sMailBody + @sSaut 
		Set @sMailBody = @sMailBody + 'Le traitement de l''ETL qui génère les fichiers LOG étant décalé par rapport à la réception de ce mail, ces fichiers LOG n''existent pas encore au moment où vous recevez ce mail.' + @sSaut 
		Set @sMailBody = @sMailBody + @sSaut 
		Set @sMailBody = @sMailBody + @sSaut 
		Set @sMailBody = @sMailBody + 'Cordialement,' + @sSaut 
		Set @sMailBody = @sMailBody + @sSaut 
		Set @sMailBody = @sMailBody + 'Fabry Jean-François'
		Set @sMailBody = @sMailBody + @sSaut 
		Set @sMailBody = @sMailBody + 'DSI/Etudes SIMPA2'

		-- On casse la chaine objet et la chaine expediteur
		
		Set @sMailObjet = Left ( @sMailObjet + space ( 255 ), 255 )
		Exec sysadm.PS_CASSER_REGLE_CHAINE @sMailObjet Output, '_', ' ' 

		Set @sAliasFrom = Left ( @sAliasFrom + space ( 128 ), 128)
		Exec sysadm.PS_CASSER_REGLE_CHAINE @sAliasFrom Output, '_', ' ' 

		Set @sMailFrom = '<jff@spb.fr>'
		Set @sAliasFrom = @sAliasFrom + @sMailFrom
		
		-- Set @sMailBody = 'A : ' + @sAdrMailLogTtpSav + @sSaut + 'CC : ' + @sAdrMailCcLogTtpSav + @sSaut + '----[REC7] n''apparaîtra pas dans le mail de production [REC7]----'+ @sSaut + @sSaut + @sMailBody-- [DBG]

		EXEC master.dbo.SPB_PS_MAIL_OUTLOOK 
				@sRetourErrMail OUTPUT, 
				@sAdrMailLogTtpSav,  -- 'jff@spb.fr',
				@sMailBody,
				@sMailObjet, 
				@sAliasFrom, 
				@sAdrMailCcLogTtpSav,  -- '',  
				null, 
				NULL, 
				NULL, 
				NULL, 
				NULL

		Set @sAdrMailLogTtpSav  = ''
		Set @sAdrMailCcLogTtpSav  = ''

		If @sAdrMailLogTtp = 'xx_fin_xx@spb.fr' Break

	  End 

	-- Construire le nouveau mail
	-- Select 			@iIdSeqTtp, @IdLotTtp,@iNbreRefusTtp ,@iMotifRefusSpbTtp ,@sCommentRefusSpbTtp,@sAdrMailLogTtp,@sAdrMailCcLogTtp -- [DBG]

	If @sAdrMailLogTtpSav <> @sAdrMailLogTtp And @sAdrMailLogTtpSav = '' 
	  Begin
	  
		Set @sMailBody = ''
		Set @sMailObjet = ''
		Set @sAdrMailLogTtpSav = @sAdrMailLogTtp
		Set @sAdrMailCcLogTtpSav = @sAdrMailCcLogTtp

		Set @sAppliEnv = 'DT432'
		-- Set @sMailFrom = '<jff@spb.fr>'

 
		If Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) ) <> 'SIMPA2_PRO' 
			Begin
			-- SIM
				Set @sAppliEnv = @sAppliEnv + '/REC7' 
				Set @sMailObjet = @sMailObjet + '[!RECETTE!] '
			End 

		Set @sAppliEnv = @sAppliEnv + '-ERREUR INTRG.'
		Set @sAliasFrom = @sAppliEnv -- + @sMailFrom

		Set @sMailObjet = @sMailObjet + 'Erreur(s) d''intégration vous concernant'

		Set @sMailBody = 'Bonjour,' + @sSaut 
		Set @sMailBody = @sMailBody + @sSaut 
		Set @sMailBody = @sMailBody + 'Le traitement lié au DT432 permettant la création automatique des sinistres SHERPA/SIMPA2 en provenance de la BRED, a généré des erreur(s) vous concernant.'+ @sSaut 
		Set @sMailBody = @sMailBody + 'En voici la liste ci-dessous :' + @sSaut 
		Set @sMailBody = @sMailBody + @sSaut 
	  End

	-- Adjonction des lignes si c'est même mail
	Select @sNomFicLog = 
		Case 
			When @iMotifRefusSpbTtp <= 99 Then '\\SPB.LAN\PRODUCTION\FLUX_APPLIS\BI\BRED\BREDUF\OUT\' +
				convert( varchar ( 10), CONVERT ( Datetime, @dtMinTraiteLe , 103 ), 112 )  + '_' + 
				replace ( Convert ( varchar (30), @dtMinTraiteLe, 114 ), ':', '' ) + '_REJETS_ET_SUCCES_SINISTRES_LOT_SPB_' + Convert ( varchar ( 10), @iIdLotTtp) + '_ID_FIC_BRED_' + Convert ( varchar ( 10), @iIdNumFicEmetteur) + '_LOG_BRED.TXT'
			Else 
				-- [20240910162546267]
				-- '\\SPB.LAN\APPLIS\SPB\SIMPA2\XLS\AUTRES\DT432_LOG_REJET_AUTRES_DEST\' + 
				sysadm.FN_GET_CHEMIN ( 'SERV_FIC_PROD' ) + 'SIMPA2\XLS\AUTRES\DT432_LOG_REJET_AUTRES_DEST\' + 
				convert( varchar ( 10), CONVERT ( Datetime, @dtMinTraiteLe , 103 ), 112 )  + '_' + 
				replace ( Convert ( varchar (30), @dtMinTraiteLe, 114 ), ':', '' ) + '_REJETS_SINISTRES_LOT_SPB_' + Convert ( varchar ( 10), @iIdLotTtp) + '_ID_FIC_BRED_' +  Convert ( varchar ( 10), @iIdNumFicEmetteur) + '_LOG_AUTRES_DEST.TXT'
		End


	If @sAdrMailLogTtpSav = @sAdrMailLogTtp And @sAdrMailLogTtpSav <> ''
	  Begin
		Set @sMailBody = @sMailBody + 'Lot ' + Convert ( Varchar ( 10 ), @iIdLotTtp) + ', Code erreur ' + Convert ( Varchar ( 10 ), @iMotifRefusSpbTtp ) +', ' 
		Set @sMailBody = @sMailBody + 'Libellé erreur : <' + Convert ( varchar (255), @sCommentRefusSpbTtp ) + '>, se trouve dans le fichier Log : ' + @sNomFicLog 
		Set @sMailBody = @sMailBody + @sSaut
	  End 

	Update @tb Set marquage_ttp = 1 Where id_seq_ttp = @iIdSeqTtp
 End

Go


--------------------------------------------------------------------
--
-- Procedure            :       PS_SU_DT432_ETAT_QUOTIDIEN_REGLES
-- Auteur               :       JFF
-- Date                 :       06/10/2020
-- Libelle              :       
-- Commentaires         :       [DT432]  Update donc nécessite un commit par l'appelant.
-- References           :       
-- Arguments            :       
--
-- Retourne             :       
-------------------------------------------------------------------
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SU_DT432_ETAT_QUOTIDIEN_REGLES' AND type = 'P' )
        DROP procedure sysadm.PS_SU_DT432_ETAT_QUOTIDIEN_REGLES
GO

CREATE procedure sysadm.PS_SU_DT432_ETAT_QUOTIDIEN_REGLES 
	@aiIdExtracParam Integer = null
As

-- Pour un traitement normal, tu exécutes la PS sans argument 
-- La PS peut être exécuté n'importe quand, aucune contrainte horaire avant ou après minuit, mais de préférence la nuit.
-- Elle peut ne pas tourner pendant plusieurs jours, c’est géré, en la relançant normalement, elle retrouve "ses petits" toute seule par un point d’arrêt, aucune perte de donnée pour BRED, ils auront les règlement même apès 5 jours d’arrêt.
-- Toujours l’exécuter sur la base de production [LS-SINISTRES].SIMPA2_PRO 
-- Tu dois COMMITER ton appel à cette PS pour un trt normal (sans argument), en effet, elle écrit en base.
-- Le Return de la PS te renvoie un id_extraction, stocke le temps de ta génération de fichier, si tu as un problème, tu pourras retrouver ton extraction par cet id_extract (voir pourquoi à la ligne suivante).
-- On peut ressortir une précédente extraction "des réglés" déjà faite par un traitement « normal », en connaissant l'ID_Extraction, le passer alors en paramètre, la PS n'écrit rien, juste un SELECT, pas besoin de COMMIT, et elle ressort la même extraction.


If @aiIdExtracParam <= 0 Set @aiIdExtracParam = null

-- Passer null aux 2 dates pour un traitement normal, la PS se charge du reste.
-- La stat doit impérativement tourner à J la première fois, dans la journée de production, avant minuit.
-- Ensuite peu importe, car je repars s'une date pivot que je sauvegarde.
-- Pour du rattrage, passer ses propres date début et de fin, avec les heures, attention, dans un tel cas, le client appelant est responsable du fichier qu'il sort.
-- eploiter le retour de la PS. Si négatif => Problème, si Ok retour 1
-- !!! Le client appelant doit absolument COMMITER son appel car il y a de l'écriture dans cette PS !!!

Declare @dtDteDeb  DateTime
Declare @dtDteFin  DateTime
Declare @dtDteDernTrt DateTime
Declare @dtDteSysteme DateTime
Declare @dcIdSin Decimal ( 10 )
Declare @dcIdGti Decimal ( 7 )
Declare @dcIdReg Decimal ( 7 )
Declare @dcMtRegGti Decimal ( 11,2 )
Declare @sChIdEvts VarChar ( 50 )
Declare @iIdSeqTb Integer 
Declare @iIdSeqMinEvt702 Integer 
Declare @iIdSeqMinEvt711 Integer 
Declare @MinEvt702Regle  Integer 
Declare @MinEvt711Regle  Integer 
Declare @dcCptVal   Decimal ( 10 )
Declare @iIdExtrac integer

Select @dtDteSysteme = GetDate()

-- Si aucune date transmise par le client appelant, alors je les détermine.
If @aiIdExtracParam is null 
  Begin
	-- Y a-t-il une date sauvegardée d'un précedent traitement ?
	Select @dtDteDernTrt = dte_2
	From sysadm.date_pivot with (nolock)
	Where id_cle = 'DT432_STAT1'

	-- Si Oui on l'exploite pour créer le DteDeb en ajoutant une seconde
	If @dtDteDernTrt is not null 
	  Begin
		Set @dtDteDeb =  DateAdd ( second, 1, @dtDteDernTrt )
		Set @dtDteFin =  Getdate ()
	  End 
	Else 
	  Begin
		Select @dtDteDeb = min ( traite_le ) From sysadm.dossier_auto_DT432 with ( nolock )
		Set    @dtDteDernTrt = @dtDteDeb 
		Set    @dtDteFin =  Getdate ()
	  End 
	/*
	Set @adtDteDeb = Convert ( DateTime, Convert(Varchar(10),Getdate(), 103)+ ' 0:00' )
	Set @adtDteFin = Convert ( DateTime, Convert(Varchar(10),Getdate(), 103)+ ' 23:59' )
	*/
	Update sysadm.date_pivot Set dte_2 = @dtDteFin Where id_cle = 'DT432_STAT1'

	Exec sysadm.PS_X_INCREMENTER 'IDEXTDT432', @dcCptVal OUTPUT
	Set @iIdExtrac = @dcCptVal 

  End  
Else 
  Begin
	Set @iIdExtrac = @aiIdExtracParam 
  End 

DECLARE @tb TABLE 
	( id_seqTb	integer identity,
	  id_sin	decimal (10 ),
	  id_reg    decimal ( 7),
	  id_gti    decimal ( 7 ),
	  mt_reg_gti decimal ( 11, 2 ),
	  id_evts    varchar ( 50 ),
	  marquage	integer null 
	)

-- Ebauche d'ALGO en Français
-- Lire table reglement date à date avec reg_gti et croisement id_sin avec da., stocker au reg_gti près, avec un stocke des id_evt concernés par l'idreg sous forme #702#711# trié sur id_sin, id_reg
-- Boucle sur la tb tempo rempli dans l'ordre d'insertion
--    stocker minIdSeqEvt 702 pour l'id_sin
--    stocker minIdSeqEvt 711 pour l'id_sin
--    Si IdReg a #702# Et que minIdSeqEvt 702 est réglé sur da. alors on ne traite pas on passe au cas suivant dessous
--    Si IdReg a #702# Et que minIdSeqEvt 702 non réglé sur da.mt_reg = mt_reg CONTINUE
--    Si IdReg a #711# Et IdReg a #702# alors Continue (on ne traite pas, c'est mis sur le 702)
--    Si IdReg a #711# Et IdReg n'a pas #702# Et que minIdSeqEvt 711 non réglé alors da.mt_reg = mt_reg  (on est sur un rglt seul du 711)
-- fBoucle

If @aiIdExtracParam is null 
  Begin
	Insert into @tb
	Select	r.id_sin,
			r.id_reg,
			rg.id_gti,
			rg.mt_reg,
			( SELECT Distinct '#' + CAST(rtrim ( dt.id_evt ) AS VARCHAR(250)) 
			  FROM sysadm.detail dt 
			  Where dt.id_sin = rg.id_sin 
			  And   dt.id_gti = rg.id_gti
			  And	dt.id_reg = rg.id_reg 
			  For XML PATH ('') ) + '#', -- en path XML #702#711#
			0

	From	sysadm.sinistre s with (nolock),
			sysadm.reglement r with (nolock),
			sysadm.reg_gti rg with (nolock)
	Where  r.cree_le between @dtDteDeb and @dtDteFin
	And    r.id_sin = s.id_sin
	And    rg.id_sin = r.id_sin
	And    rg.id_reg = r.id_reg
	And    Exists ( Select Top 1 1 From sysadm.dossier_auto_DT432 da where da.id_sin = s.id_sin and rg.id_gti = da.id_gti)
	Order by 1,2

	While Exists ( Select Top 1 1 From @tb where marquage = 0 )
	 Begin
		Select 	Top 1 
		  @dcIdSin = t.id_sin,
		  @dcIdReg = t.id_reg,
		  @dcIdGti = t.id_gti,
		  @dcMtRegGti = t.mt_reg_gti,
		  @sChIdEvts = t.id_evts,
		  @iIdSeqTb = t.id_seqTb
		From	@tb t
		Where	t.marquage = 0
		And     t.id_seqTb = ( Select MIN ( t2.id_seqTb ) From @tb t2 where t.marquage = t2.marquage )

		-- stocker minIdSeqEvt 702 pour l'id_sin	
		Select	@iIdSeqMinEvt702 = min ( da.id_seq ) 
		From	sysadm.dossier_auto_DT432 da 
		Where	da.id_sin = @dcIdSin and id_evt = 702

		If @iIdSeqMinEvt702 is null Set @iIdSeqMinEvt702 = 0

		Select	@MinEvt702Regle  =	
					Case 	
						When da.id_reg > 0 Then 1
						Else 0
					End 
		From	sysadm.dossier_auto_DT432 da 
		Where	da.id_seq = @iIdSeqMinEvt702

		If @MinEvt702Regle is null Set @MinEvt702Regle = 0


		-- stocker minIdSeqEvt 711 pour l'id_sin
		Select	@iIdSeqMinEvt711 = min ( da.id_seq ) 
		From	sysadm.dossier_auto_DT432 da 
		Where	da.id_sin = @dcIdSin and id_evt = 711

		If @iIdSeqMinEvt711 is null Set @iIdSeqMinEvt711 = 0

		Select	@MinEvt711Regle  =	
					Case 	
						When da.id_reg > 0 Then 1
						Else 0
					End 
		From	sysadm.dossier_auto_DT432 da 
		Where	da.id_seq = @iIdSeqMinEvt711

		If @MinEvt711Regle is null Set @MinEvt711Regle = 0

		-- Si IdReg a #702# Et que minIdSeqEvt 702 est réglé sur da. alors on ne traite pas on pas au cas suivant dessous. Cette règle n'induit pas de code.

		-- Si IdReg a #702# Et que minIdSeqEvt 702 non réglé sur da.mt_reg = mt_reg CONTINUE
		If CharIndex ( '#702#', @sChIdEvts ) > 0 And @MinEvt702Regle <= 0 And @iIdSeqMinEvt702 > 0
		  Begin 
			Update sysadm.dossier_auto_DT432 
			Set	mt_reg_spb = @dcMtRegGti, 
				id_reg = @dcIdReg, 
				id_extract_reg = @iIdExtrac,
				dte_extract_reg = @dtDteSysteme,
				nom_fic_extract_reg = 
					convert( varchar ( 10), CONVERT ( Datetime, @dtDteSysteme, 103 ), 112 )  + '_' + replace ( Convert ( varchar (30), @dtDteSysteme , 114 ), ':', '' ) + 
					'_ID_EXTRACT_' + Convert ( varchar (20), @iIdExtrac ) + 
					'_REGLTS_GTIE_UF_BRED_DU_' + convert( varchar ( 10), CONVERT ( Datetime, @dtDteDeb , 103 ), 112 )  + '_' + 
					replace ( Convert ( varchar (30), @dtDteDeb, 114 ), ':', '' ) + 
					'_AU_' + convert( varchar ( 10), CONVERT ( Datetime, @dtDteFin , 103 ), 112 )  + '_' + replace ( Convert ( varchar (30), @dtDteFin, 114 ), ':', '' ) 
			Where id_seq = @iIdSeqMinEvt702  -- On mémorise défintivement le montant sur da. et l'id_reg lié
			
			Update sysadm.dossier_auto_DT432 
			Set	mt_reg_spb = 0, 
				id_reg = @dcIdReg, 
				id_extract_reg = @iIdExtrac,  
				dte_extract_reg = @dtDteSysteme,
				nom_fic_extract_reg = 
					convert( varchar ( 10), CONVERT ( Datetime, @dtDteSysteme, 103 ), 112 )  + '_' + replace ( Convert ( varchar (30), @dtDteSysteme , 114 ), ':', '' ) + 
					'_ID_EXTRACT_' + Convert ( varchar (20), @iIdExtrac ) + 
					'_REGLTS_GTIE_UF_BRED_DU_' + convert( varchar ( 10), CONVERT ( Datetime, @dtDteDeb , 103 ), 112 )  + '_' + 
					replace ( Convert ( varchar (30), @dtDteDeb, 114 ), ':', '' ) + 
					'_AU_' + convert( varchar ( 10), CONVERT ( Datetime, @dtDteFin , 103 ), 112 )  + '_' + replace ( Convert ( varchar (30), @dtDteFin, 114 ), ':', '' ) 
			Where id_sin = @dcIdSin And id_evt = 702 And id_seq <> @iIdSeqMinEvt702 -- On mémorise défintivement l'id_reg lié sur les autres 702 avec un mt_teg = 0

		  End 

		-- Si IdReg a #711# Et IdReg a #702# alors on mets da.mt_reg à 0€ et on marque l'id_reg et l'id_extract_reg quand même (le montant est mis sur le 702, le 702 a la priorité pour prendre le montant seul dans ce cas, vu avec BRED (cause plafond GTI)) Cette règle n'induit pas de code.
		If CharIndex ( '#711#', @sChIdEvts ) > 0 And CharIndex ( '#702#', @sChIdEvts ) > 0 And @MinEvt702Regle <= 0 And @MinEvt711Regle <= 0 And @iIdSeqMinEvt702 > 0 And @iIdSeqMinEvt711 > 0
		  Begin 
			Update sysadm.dossier_auto_DT432 
			Set mt_reg_spb = 0, 
				id_reg = @dcIdReg, 
				id_extract_reg = @iIdExtrac,
				dte_extract_reg = @dtDteSysteme,
				nom_fic_extract_reg = 
					convert( varchar ( 10), CONVERT ( Datetime, @dtDteSysteme, 103 ), 112 )  + '_' + replace ( Convert ( varchar (30), @dtDteSysteme , 114 ), ':', '' ) + 
					'_ID_EXTRACT_' + Convert ( varchar (20), @iIdExtrac ) + 
					'_REGLTS_GTIE_UF_BRED_DU_' + convert( varchar ( 10), CONVERT ( Datetime, @dtDteDeb , 103 ), 112 )  + '_' + 
					replace ( Convert ( varchar (30), @dtDteDeb, 114 ), ':', '' ) + 
					'_AU_' + convert( varchar ( 10), CONVERT ( Datetime, @dtDteFin , 103 ), 112 )  + '_' + replace ( Convert ( varchar (30), @dtDteFin, 114 ), ':', '' ) 
			Where id_seq = @iIdSeqMinEvt711  -- On mémorise défintivement le montant sur da. et l'id_reg lié

			Update sysadm.dossier_auto_DT432 
			Set	mt_reg_spb = 0, 
				id_reg = @dcIdReg, 
				id_extract_reg = @iIdExtrac,
				dte_extract_reg = @dtDteSysteme,
				nom_fic_extract_reg = 
					convert( varchar ( 10), CONVERT ( Datetime, @dtDteSysteme, 103 ), 112 )  + '_' + replace ( Convert ( varchar (30), @dtDteSysteme , 114 ), ':', '' ) + 
					'_ID_EXTRACT_' + Convert ( varchar (20), @iIdExtrac ) + 
					'_REGLTS_GTIE_UF_BRED_DU_' + convert( varchar ( 10), CONVERT ( Datetime, @dtDteDeb , 103 ), 112 )  + '_' + 
					replace ( Convert ( varchar (30), @dtDteDeb, 114 ), ':', '' ) + 
					'_AU_' + convert( varchar ( 10), CONVERT ( Datetime, @dtDteFin , 103 ), 112 )  + '_' + replace ( Convert ( varchar (30), @dtDteFin, 114 ), ':', '' ) 
			Where id_sin = @dcIdSin And id_evt = 711 And id_seq <> @iIdSeqMinEvt711 -- On mémorise défintivement l'id_reg lié sur les autres 702 avec un mt_teg = 0

		  End 

		-- Si IdReg a #711# Et IdReg n'a pas #702# Et que minIdSeqEvt 711 non réglé alors da.mt_reg = mt_reg  (on est sur un rglt seul du 711)
		If CharIndex ( '#711#', @sChIdEvts ) > 0 And CharIndex ( '#702#', @sChIdEvts ) <= 0 And @MinEvt711Regle <= 0 And @iIdSeqMinEvt711 > 0 
		  Begin 
			Update sysadm.dossier_auto_DT432 
			Set mt_reg_spb = @dcMtRegGti, 
				id_reg = @dcIdReg, 
				id_extract_reg = @iIdExtrac, 
				dte_extract_reg = @dtDteSysteme,
				nom_fic_extract_reg = 
					convert( varchar ( 10), CONVERT ( Datetime, @dtDteSysteme, 103 ), 112 )  + '_' + replace ( Convert ( varchar (30), @dtDteSysteme , 114 ), ':', '' ) + 
					'_ID_EXTRACT_' + Convert ( varchar (20), @iIdExtrac ) + 
					'_REGLTS_GTIE_UF_BRED_DU_' + convert( varchar ( 10), CONVERT ( Datetime, @dtDteDeb , 103 ), 112 )  + '_' + 
					replace ( Convert ( varchar (30), @dtDteDeb, 114 ), ':', '' ) + 
					'_AU_' + convert( varchar ( 10), CONVERT ( Datetime, @dtDteFin , 103 ), 112 )  + '_' + replace ( Convert ( varchar (30), @dtDteFin, 114 ), ':', '' ) 
			Where id_seq = @iIdSeqMinEvt711  -- On mémorise défintivement le montant sur da. et l'id_reg lié

			Update sysadm.dossier_auto_DT432 
			Set mt_reg_spb = 0, 
				id_reg = @dcIdReg, 
				id_extract_reg = @iIdExtrac,
				dte_extract_reg = @dtDteSysteme,
				nom_fic_extract_reg = 
					convert( varchar ( 10), CONVERT ( Datetime, @dtDteSysteme, 103 ), 112 )  + '_' + replace ( Convert ( varchar (30), @dtDteSysteme , 114 ), ':', '' ) + 
					'_ID_EXTRACT_' + Convert ( varchar (20), @iIdExtrac ) + 
					'_REGLTS_GTIE_UF_BRED_DU_' + convert( varchar ( 10), CONVERT ( Datetime, @dtDteDeb , 103 ), 112 )  + '_' + 
					replace ( Convert ( varchar (30), @dtDteDeb, 114 ), ':', '' ) + 
					'_AU_' + convert( varchar ( 10), CONVERT ( Datetime, @dtDteFin , 103 ), 112 )  + '_' + replace ( Convert ( varchar (30), @dtDteFin, 114 ), ':', '' ) 
			Where id_sin = @dcIdSin And id_evt = 711 And id_seq <> @iIdSeqMinEvt711 -- On mémorise défintivement l'id_reg lié sur les autres 702 avec un mt_teg = 0

		  End 

		Update @tb Set marquage = 1 Where id_seqTb = @iIdSeqTb
	 End
  End 

If Not Exists ( Select Top 1 1 From sysadm.dossier_auto_DT432 da Where da.id_extract_reg = @iIdExtrac ) And @aiIdExtracParam is null
  Begin 
	Select 
		null 	id_seq,
		null 	id_projet,
		-1	id_sin_emetteur,
		null 	id_num_fic_emetteur,
		null 	id_prod,
		null 	id_ets,
		null 	id_adh,
		null 	id_sdos,
		null 	cod_opt,
		null 	dte_opt,
		null 	id_natsin,
		null 	id_territ,
		null 	id_detsin,
		null 	dte_decl,
		null 	dte_surv,
		null 	heu_surv,
		null 	dte_oppo,
		null 	dte_util,
		null 	dte_adh,
		null 	dte_resil,
		null 	dte_fin_gti,
		null 	cod_civ,
		null 	nom,
		null 	prenom,
		null 	dte_nais,
		null 	adr_1,
		null 	adr_2,
		null 	adr_cp,
		null 	adr_ville,
		null 	num_teld,
		null 	id_gti,
		null 	iban,
		null 	adr_mail,
		null 	id_evt,
		null 	mt_prej,
		null 	statut_emetteur,
		null 	mt_uf_charge_spb,
		null 	mt_fran_charge_assure,
		null 	motif_refus_emetteur,
		null 	id_sin,
		null 	dte_integr,
		null 	mt_reg_spb,
		null 	motif_refus_spb,
		null 	comment_refus_spb,
		null 	etat_trt,
		null 	traite_le,
		null 	traite_par,
		@iIdExtrac 'id_extrac',
			convert( varchar ( 10), CONVERT ( Datetime, @dtDteSysteme, 103 ), 112 )  + '_' + replace ( Convert ( varchar (30), @dtDteSysteme , 114 ), ':', '' ) + 
					'_ID_EXTRACT_' + Convert ( varchar (20), @iIdExtrac ) + 
					'_REGLTS_GTIE_UF_BRED_DU_' + convert( varchar ( 10), CONVERT ( Datetime, @dtDteDeb , 103 ), 112 )  + '_' + 
					replace ( Convert ( varchar (30), @dtDteDeb, 114 ), ':', '' ) + 
					'_AU_' + convert( varchar ( 10), CONVERT ( Datetime, @dtDteFin , 103 ), 112 )  + '_' + replace ( Convert ( varchar (30), @dtDteFin, 114 ), ':', '' )  	nom_fic_extract_reg
  End 
Else 
  Begin 

	-- Extraction finale de sortie
	Select	da.id_seq,
			da.id_projet,
			da.id_sin_emetteur,
			da.id_num_fic_emetteur,
			da.id_prod,
			da.id_ets,
			da.id_adh,
			da.id_sdos,
			da.cod_opt,
			da.dte_opt,
			da.id_natsin,
			da.id_territ,
			da.id_detsin,
			da.dte_decl,
			da.dte_surv,
			da.heu_surv,
			da.dte_oppo,
			da.dte_util,
			da.dte_adh,
			da.dte_resil,
			da.dte_fin_gti,
			da.cod_civ,
			da.nom,
			da.prenom,
			da.dte_nais,
			da.adr_1,
			da.adr_2,
			da.adr_cp,
			da.adr_ville,
			da.num_teld,
			da.id_gti,
			da.iban,
			da.adr_mail,
			da.id_evt,
			da.mt_prej,
			da.statut_emetteur,
			da.mt_uf_charge_spb,
			da.mt_fran_charge_assure,
			da.motif_refus_emetteur,
			da.id_sin,
			da.dte_integr,
			da.mt_reg_spb,
			da.motif_refus_spb,
			da.comment_refus_spb,
			da.etat_trt,
			da.traite_le,
			da.traite_par,
			@iIdExtrac 'id_extrac',
			da.nom_fic_extract_reg

	From	sysadm.dossier_auto_DT432 da
	Where   da.id_extract_reg = @iIdExtrac
	Order By
			nom_fic_extract_reg,
			id_sin,
			id_seq
  End

Return @iIdExtrac

Go

