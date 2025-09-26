-------------------------------------------------------------------
--
-- Fichier              :       EXTRANET_AUTOMATISATION.CP
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
--
-- Commentaires         :       PS afférants à l'automatisation des déclaration SHERPA/SIMPA2 en liant avec un extranet
--
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__COCHAGE_DES_PIECES
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__CONTROLE_ELIGIBILITE_DOSSIER
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__CONTROLE_INTEGRITE_DOSSIER
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__CREATION_DE_LA_PRESTATION
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__CREATION_DETAIL_DE_GARANTIE
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__DECLENCHEMENT_AUTOMATISATION
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__DECLENCHEMENT_PLAFOND_ET_PEC
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__DECLENCHEMENT_REFUS
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__RECHERCHE_REFUS_AVANT_DECLENCHEMENT
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_601_ADHESION_RESILIEE
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_601_ADHESION_RESILIEE_RECHERCHE
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_602_ADHESION_NON_SOUSCRITE_A_DATE_SINISTRE
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_602_ADHESION_NON_SOUSCRITE_A_DATE_SINISTRE_RECHERCHE
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_603_PRIMES_NON_PERCUES
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_603_PRIMES_NON_PERCUES_RECHERCHE
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_611_NATURE_DE_SINISTRE_NON_COUVERT
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_611_NATURE_DE_SINISTRE_NON_COUVERT_RECHERCHE
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_612_DETAIL_DE_SINISTRE_NON_COUVERT
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_612_DETAIL_DE_SINISTRE_NON_COUVERT_RECHERCHE
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_613_TERRITORIALITE_NON_COUVERTE
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_613_TERRITORIALITE_NON_COUVERTE_RECHERCHE
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_641_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_SURVENANCE
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_641_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_SURVENANCE_RECHERCHE
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_642_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_ADHESION
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_642_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_ADHESION_RECHERCHE
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_643_DATE_ACHAT_OU_OUVLIG_ANTERIEURE_DTE_ADHESION_DP131
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_643_DATE_ACHAT_OU_OUVLIG_ANTERIEURE_DTE_ADHESION_DP131_RECHERCHE
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_REVISION
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_REVISION_RECHERCHE
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__STOCKAGE_INFOS_PRESTATION
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION
-- sysadm.PS_I_EXTRANET_AUTOMATISATION__VALIDATION_DU_DOSSIER

-------------------------------------------------------------------
--
-------------------------------------------------------------------

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC
	@adcIdSin Decimal ( 10 ),
	@asMsgSimpa2 	VarChar (35),
	@asMsg2Sherpa	VarChar (476)
AS

Declare @sMsgSherpa VarChar ( 508 )
Declare @dcIdCorb Decimal ( 3 )
Declare @dtCreeLeDos DateTime
DECLARE @sOper varchar(4)
Declare @sErr  Varchar(60)
Declare @iIdCt Integer 

Set @sOper = 'WEB'
Set @sMsgSherpa = Left ( 'ERREUR / Rejet Automatisation : ' + @asMsg2Sherpa, 508 )

Exec sysadm.PS_I_DIV_SIN_SANS_DIV_PRO
        @adcIdSin,
        'extrauto_rejet_decl', 
		'Rejet Automatis. Décla. Extranet',  
        @asMsgSimpa2,
		'O',
		'C',
		null,
        @sOper 

	If Not Exists ( 
			Select Top 1 1 
			From sysadm.routage r
			Where r.id_sin = @adcIdSin
		)
		Begin
			Select @dcIdCorb = p.id_corb,
				   @dtCreeLeDos = ws.cree_le
			From   sysadm.w_sin ws,
				   sysadm.produit p
			Where  ws.id_sin = @adcIdSin
			And    p.id_prod = ws.id_prod

			Insert into sysadm.routage values  ( @adcIdSin, 'N', @dcIdCorb, 'X', 'DEC', 'N', @dtCreeLeDos , @dtCreeLeDos , 'WEB', null, null, null, null,null )
		End 

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @adcIdSin, 2, @sMsgSherpa, @sOper , @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'E'
	END
	ELSE
	BEGIN
		EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @adcIdSin, 2, @sMsgSherpa, @sOper , @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'E'
	END

Go


--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__STOCKAGE_INFOS_PRESTATION
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__STOCKAGE_INFOS_PRESTATION' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__STOCKAGE_INFOS_PRESTATION
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__STOCKAGE_INFOS_PRESTATION
	@adcIdSin Decimal ( 10 ),
	@adcIdGti Decimal ( 7 ),
	@asIdHubPresta VarChar ( 20 ), 
	@asIdFour VarChar ( 3 ),
	@asTypDommage VarChar ( 100 ),
	@asOrdreAction VarChar ( 20 ),
	@asTypAppSin VarChar ( 3 ),
	@asMarqAppSin VarChar ( 35 ),
	@asModlAppSin VarChar ( 35 ),
	@asNumImeiAppSin VarChar ( 20 ),
	@asNumSerieAppSin VarChar ( 60 ),
	@asNumTelAppSin VarChar ( 25 ),
	@asDescriptionProbleme VarChar ( 255 ),
	@adcMtValAchat Decimal ( 11,2 ),
	@adtDateAchat DateTime,
	@asEtatAppSin VarChar ( 20 ),
	@asCodeVerrou VarChar ( 20 ),
	@asDesimlocke VarChar ( 20 ),
	@asPointService VarChar ( 40 ),
	@asModeLogis VarChar ( 40 ),
	@asCodePickup VarChar ( 20 ),
	@asNomPickup VarChar ( 40 ),
	@asAdr1Pickup VarChar ( 40 ),
	@asAdr2Pickup VarChar ( 40 ),
	@asAdr3Pickup VarChar ( 40 ),
	@asAdrCpPickup VarChar ( 40 ),
	@asAdrVillePickup VarChar ( 40 ),
	@aiCodCivLivr Integer,
	@asNomLivr VarChar ( 35 ),
	@asPrenomLivr VarChar ( 35 ),
	@asAdr1Livr VarChar ( 35 ),
	@asAdr2Livr VarChar ( 35 ),
	@asAdr3Livr VarChar ( 35 ),
	@asAdrCpLivr VarChar ( 35 ),
	@asAdrVilleLivr VarChar ( 35 ),
	@asNumTelLivr VarChar ( 20 ), 
	@asProcessAcheminement VarChar ( 100 ),
	@asChaineSeria VarChar ( 1000 ),
	@asMessRet VarChar ( 255 ) OutPut
AS

--------------------------
-- Contrôle des données --
--------------------------
--	@asRefAssPickup VarChar ( 40 ), Je le ferai moi-même

Declare @iRet Integer
Declare @sRefAssPickUp VarChar ( 40 )
Declare @sDataErreur VarChar ( 255 )

If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin ) 
	Begin
		Set @asMessRet = 'Le sinistre n''existe pas'
		Set @sDataErreur = Convert ( VarChar ( 255), @adcIdSin )
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -10, @asMessRet, @sDataErreur
		Return -10
	End 

If Not Exists ( Select Top 1 1 From sysadm.w_gar_sin Where id_sin = @adcIdSin and id_gti = @adcIdGti ) 
	Begin
		Set @asMessRet = 'La garantie n''existe pas sur le sinistre'
		Set @sDataErreur = Convert ( VarChar ( 255), @adcIdGti )
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -20, @asMessRet, @sDataErreur
		Return -20
	End 

Set @asIdHubPresta = UPPER ( Trim ( @asIdHubPresta ) )
If @asIdHubPresta is null Or @asIdHubPresta = ''
	Begin
		Set @asMessRet = 'L''identifiant de la prestation doit être renseigné (VarChar ( 10 ))'
		Set @sDataErreur = @asIdHubPresta
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -370, @asMessRet, @sDataErreur
		Return -370
	End 

If Len ( @asIdHubPresta ) <> 10 Or @asIdHubPresta <> UPPER ( @asIdHubPresta )
	Begin
		Set @asMessRet = 'L''identifiant de la prestation n''est pas valide )'
		Set @sDataErreur = @asIdHubPresta
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -380, @asMessRet, @sDataErreur
		Return -380
	End 


Set @asIdFour = UPPER ( Trim ( @asIdFour ))
If @asIdFour is null Or @asIdFour = ''
	Begin
		Set @asMessRet = 'le Code fournisseur SIMPA2 (code fournisseur officiel SPB) doit être renseigné (VarChar ( 3 )), voir avec le HUB qui a une table PRESTATAIRE.edi.ProviderSimpa2 pour la correspondance des codes'
		Set @sDataErreur = @asIdFour
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -140, @asMessRet, @sDataErreur
		Return -140
	End 

If LEN ( @asIdFour ) > 0 
	Begin

		Exec @iRet = sysadm.PS_S_CODE_DANS_FAMILLE_CAR  1, @asIdFour 
		If @iRet <= 0 
			Begin 
				Set @asMessRet = 'le Code fournisseur SIMPA2 (code fournisseur officiel SPB) n''est pas valide, ce n''est pas un CODE fournisseur officiel SPB ou bien il n''a aucun lien avec SIMPA2'
				Set @sDataErreur = @asIdFour
				Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -150, @asMessRet, @sDataErreur
				Return -150
			End 
	End 

Set @asPointService = UPPER ( Trim ( @asPointService ))
If @asPointService is null Or @asPointService = ''
	Begin
		Set @asMessRet = 'Le point de service doit être renseigné (VarChar ( 40 )), exemple : SPAREKA_AT_HOME ou SAVE_REUNION ou ITANCIA ou SPAREKA_REMOTELY etc...'
		Set @sDataErreur = @asPointService
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -50, @asMessRet, @sDataErreur
		Return -50
	End 


Set @asTypDommage = UPPER ( Trim ( @asTypDommage ))
If @asTypDommage is not null 
	Begin 
		If LEFT ( @asTypDommage, 1 ) <> '#' OR Right ( @asTypDommage, 1 ) <> '#' 
			Begin 
				Set @asMessRet = 'Type Dommage non valide, s''il est non null, ce doit être une chaine concaténée (VarChar ( 100 )) séparées par un #, et il doit y avoir un # en début et fin de chaine, exemple : #BROKEN_SCREEN#DEVICE_BROKEN#REAR_BROKEN# ou #OXIDATION# etc...'
				Set @sDataErreur = @asTypDommage
				Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -40, @asMessRet, @sDataErreur
				Return -40
			End 
	End 

Set @asOrdreAction = UPPER ( Trim ( @asOrdreAction ))
If @asOrdreAction is null Or @asOrdreAction = ''
	Begin
		Set @asMessRet = 'L''ordre d''action doit être renseigné (VarChar ( 20 )), exemple : A_DIAGNOSTIQUER ou A_REPARER ou A_COMMANDER'
		Set @sDataErreur = @asOrdreAction
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -90, @asMessRet, @sDataErreur
		Return -90
	End 

Set @asTypAppSin = UPPER ( Trim ( @asTypAppSin ))
If @asTypAppSin is null Or @asTypAppSin = ''
	Begin
		Set @asMessRet = 'Le type de l''appareil doit être renseigné (VarChar ( 3 )) en code SIMPA2, exemple : TEL ou TPC ou MCS, etc....'
		Set @sDataErreur = @asTypAppSin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -160, @asMessRet, @sDataErreur
		Return -160
	End 

If LEN ( @asTypAppSin ) > 0 
	Begin
		If Not Exists ( 
			Select Top 1 1
			From sysadm.w_sin ws,
				 sysadm.det_pro dp
			Where ws.id_sin = @adcIdSin
			And dp.id_prod = ws.id_prod
			And dp.id_code_dp = 25
			And dp.id_code_car = @asTypAppSin
		)
		Begin 
			Set @asMessRet = 'Le type l''appareil n''est pas valide en code SIMPA2 ou bien n''est pas géré sur le produit d''assurance liés à ce sinistre'
			Set @sDataErreur = @asTypAppSin
			Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -165, @asMessRet, @sDataErreur
			Return -165
		End 
	End 

Set @asMarqAppSin = UPPER ( Trim ( @asMarqAppSin ))
If @asMarqAppSin is null Or @asMarqAppSin = ''
	Begin
		Set @asMessRet = 'La marque de l''appareil doit être renseigné (VarChar ( 35 ))'
		Set @sDataErreur = @asMarqAppSin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -170, @asMessRet, @sDataErreur
		Return -170
	End 

If LEN ( @asMarqAppSin ) > 0 
	Begin
		If Exists ( 
			Select Top 1 1
			From sysadm.w_sin ws,
				 sysadm.det_pro dp
			Where ws.id_sin = @adcIdSin
			And dp.id_prod = ws.id_prod
			And dp.id_code_dp = 28
			And dp.id_code_car = 'IFR' + @asTypAppSin
		)
		And Not Exists ( 
			Select Top 1 1 
			From sysadm.ifr i
			Where i.marque = @asMarqAppSin
		)

		Begin 
			Set @asMessRet = 'le type de l''appareil est relié à IFR sur le paramètrage du produit, et la marque que vous donnez n''existe pas sur IFR, merci de transmettre une marque et modèle IFR pour ce type d''appareil, contactez EPSIN'
			Set @sDataErreur = @asMarqAppSin
			Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -180, @asMessRet, @sDataErreur
			Return -180
		End 

		If Not Exists ( 
			Select Top 1 1
			From sysadm.w_sin ws,
				 sysadm.det_pro dp
			Where ws.id_sin = @adcIdSin
			And dp.id_prod = ws.id_prod
			And dp.id_code_dp = 28
			And dp.id_code_car = 'IFR' + @asTypAppSin
		)
		And Not Exists ( 
			Select Top 1 1 
			From sysadm.code
			Where id_typ_code = '-MB'
			And   UPPER ( lib_code ) = @asMarqAppSin
		)

		Begin 
			Set @asMessRet = 'Le type de l''appareil est relié (pour la marque) au référentiel -MB et la marque que vous donnez n''existe pas sur ce référentiel, contactez EPSIN'
			Set @sDataErreur = @asMarqAppSin
			Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -185, @asMessRet, @sDataErreur
			Return -185
		End 

	End 

Set @asModlAppSin = UPPER ( Trim ( @asModlAppSin ))
If @asModlAppSin is null Or @asModlAppSin = ''
	Begin
		Set @asMessRet = 'La modèle de l''appareil doit être renseigné (VarChar ( 35 ))'
		Set @sDataErreur = @asModlAppSin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -190, @asMessRet, @sDataErreur
		Return -190
	End 

If LEN ( @asModlAppSin ) > 0 
	Begin
		If Exists ( 
			Select Top 1 1
			From sysadm.w_sin ws,
				 sysadm.det_pro dp
			Where ws.id_sin = @adcIdSin
			And dp.id_prod = ws.id_prod
			And dp.id_code_dp = 28
			And dp.id_code_car = 'IFR' + @asTypAppSin
		)
		And Not Exists ( 
			Select Top 1 1 
			From sysadm.ifr i
			Where i.marque = @asMarqAppSin
			And   i.reference = @asModlAppSin
		)

		Begin 
			Set @asMessRet = 'le type de l''appareil est relié à IFR sur le paramètrage du produit, et le modèle que vous donnez n''existe pas sur IFR, merci de transmettre une marque et modèle IFR pour ce type d''appareil'
			Set @sDataErreur = @asModlAppSin
			Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -200, @asMessRet, @sDataErreur
			Return -200
		End 
	End 

Set @asNumImeiAppSin = UPPER ( Trim ( @asNumImeiAppSin ))
If ( @asNumImeiAppSin is null Or @asNumImeiAppSin = '' ) And @asTypAppSin = 'TEL'
	Begin
		Set @asMessRet = 'Le numéro d''IMEI doit être renseigné (VarChar ( 20 )) pour un type d''appareil ' + @asTypAppSin 
		Set @sDataErreur = @asNumImeiAppSin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -320, @asMessRet, @sDataErreur
		Return -320
	End 

If  @asNumImeiAppSin is Not null And @asNumImeiAppSin <> '' And @asTypAppSin = 'TEL'
	Begin
		IF sysadm.FN_CORR_IMEI ( @asNumImeiAppSin, GETDATE() ) <> @asNumImeiAppSin
		Begin 
			Set @asMessRet = 'Le numéro d''IMEI n''est pas valide'
			Set @sDataErreur = @asNumImeiAppSin
			Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -330, @asMessRet, @sDataErreur
			Return -330
		End 
	End 

Set @asNumSerieAppSin = UPPER ( Trim ( @asNumSerieAppSin ))
If ( @asNumSerieAppSin is null Or @asNumSerieAppSin = '' ) And @asTypAppSin <> 'TEL'
	Begin
		Set @asMessRet = 'Le numéro de série doit être renseigné (VarChar ( 20 ))' 
		Set @sDataErreur = @asNumSerieAppSin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -340, @asMessRet, @sDataErreur
		Return -340
	End 

Set @asDescriptionProbleme = UPPER ( Trim ( @asDescriptionProbleme  ))
If ( @asDescriptionProbleme is null Or @asDescriptionProbleme = '' ) 
	Begin
		Set @asMessRet = 'La description du problème doit être renseignée (VarChar ( 255 ))' 
		Set @sDataErreur = @asDescriptionProbleme
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -350, @asMessRet, @sDataErreur
		Return -350
	End 

/*	Pas de contrôle vu avec Lisette, peut donc être null
Set @asNumTelAppSin = UPPER ( Trim ( @asNumTelAppSin ))
If ( @asNumTelAppSin is null Or @asNumTelAppSin = '' ) and @asTypAppSin = 'TEL'
	Begin
		Set @asMessRet = 'Le numéro de téléphone de la ligne sinistrée doit être renseigné (VarChar ( 25 )) pour le type d''appareil ' + @asTypAppSin
		Return -210
	End 
*/

If ( @adcMtValAchat is null Or @adcMtValAchat <= 0 ) 
	Begin
		Set @asMessRet = 'Le montant de valeur d''achat doit être renseigné (Decimal (11,2))'
		Set @sDataErreur = convert ( varchar ( 255), @adcMtValAchat )
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -220, @asMessRet, @sDataErreur
		Return -220
	End 

If ( @adtDateAchat is null ) 
	Begin
		Set @asMessRet = 'La date date d''achat doit être renseigné (DateTime)'
		Set @sDataErreur = convert ( varchar ( 255 ), @adtDateAchat, 103 )
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -230, @asMessRet, @sDataErreur
		Return -230
	End 

Set @asEtatAppSin = UPPER ( Trim ( @asEtatAppSin ))
If @asEtatAppSin is not null And @asEtatAppSin <> ''
Begin
	If @asEtatAppSin Not in ( 'ANEU', 'AREC' ) 
		Begin
			Set @asMessRet = 'Si l''état de l''appareil est connu et obligatoire pour ce contrat, dans ce cas seules 2 valeurs sont acceptées : ANEU pour << Acheté Neuf>> ou AREC pour << Acheté reconditionné >> (Varchar (20))'
			Set @sDataErreur = @asEtatAppSin
			Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -240, @asMessRet, @sDataErreur
			Return -240
		End 
End 

-- @asCodeVerrou => Pas de contrôle, pas obligatoire

Set @asDesimlocke = UPPER ( Trim ( @asDesimlocke ))
If @asDesimlocke is not null And @asDesimlocke <> ''
Begin
	If @asEtatAppSin Not in ( 'OUI', 'NON' ) 
		Begin
			Set @asMessRet = 'Si l''information de désimlockage est est connu et obligatoire pour ce contrat, dans ce cas seules 2 valeurs sont acceptées : OUI pour << désimlocké >> ou NON pour << non désimlocké >> (Varchar (20))'
			Set @sDataErreur = @asEtatAppSin
			Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -250, @asMessRet, @sDataErreur
			Return -250
		End 
End 


Set @asPointService = UPPER ( Trim ( @asPointService ))
If @asPointService is null Or @asPointService = ''
	Begin
		Set @asMessRet = 'Le point de service doit être renseigné (VarChar ( 40 )), exemple : SPAREKA_AT_HOME ou SAVE_REUNION ou ITANCIA ou SPAREKA_REMOTELY etc...'
		Set @sDataErreur = @asPointService
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -50, @asMessRet, @sDataErreur
		Return -50
	End 

Set @asModeLogis = UPPER ( Trim ( @asModeLogis ))
If @asModeLogis is null Or @asModeLogis = ''
	Begin
		Set @asMessRet = 'Le mode logistique doit être renseigné (VarChar ( 40 )), exemple : PROXIMITY ou AT_HOME ou REMOTELY ou CENTRALIZATION etc...'
		Set @sDataErreur = @asModeLogis
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -60, @asMessRet, @sDataErreur
		Return -60
	End 

Set @asNomLivr = UPPER ( Trim ( @asNomLivr ))
If @asNomLivr is null Or @asNomLivr = ''
	Begin
		Set @asMessRet = 'Interlocuteur lié à la prestation : Le nom de l''interlocuteur doit être renseigné (varchar (35 ))'
		Set @sDataErreur = @asNomLivr
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -280, @asMessRet, @sDataErreur
		Return -280
	End 

Set @asPrenomLivr = UPPER ( Trim ( @asPrenomLivr ))
If @asPrenomLivr is null Or @asPrenomLivr = ''
	Begin
		Set @asMessRet = 'Interlocuteur lié à la prestation : Le prénom de l''interlocuteur doit être renseigné (varchar (35 ))'
		Set @sDataErreur = @asPrenomLivr
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -290, @asMessRet, @sDataErreur
		Return -290
	End 

Set @asCodePickup = UPPER ( Trim ( @asCodePickup ))
IF @asCodePickup is not null 
	Begin
		If len ( @asCodePickup ) <> 5
			Begin
				Set @asMessRet = 'Un code de relais PickUp doit avoir une longueur de 5 caractères alpha-numérique, exemple : 8624S ou 3600Y ou 950AL etc...'
				Set @sDataErreur = @asCodePickup
				Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -70, @asMessRet, @sDataErreur
				Return -70
			End 

		Set @asNomPickup = Trim ( @asNomPickup )
		IF @asNomPickup is null Or @asNomPickup = ''
			Begin
				Set @asMessRet = 'Le nom du relais PickUp doit être renseigné (VarChar ( 40 ))'
				Set @sDataErreur = @asNomPickup
				Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -80, @asMessRet, @sDataErreur
				Return -80
			End 

		Set @asAdr1Pickup = Trim ( @asAdr1Pickup )
		IF @asAdr1Pickup is null Or @asAdr1Pickup = ''
			Begin
				Set @asMessRet = 'L''adresse du relais PickUp doit être renseignée (@asAdr1Pickup VarChar ( 40 ) elle est obligatoire, mais @asAdr2Pickup et @asAdr3Pickup sont facultatives)'
				Set @sDataErreur = @asAdr1Pickup
				Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -100, @asMessRet, @sDataErreur
				Return -100
			End 
		
		Set @asAdrCpPickup = Trim ( @asAdrCpPickup )
		IF @asAdrCpPickup is null Or @asAdrCpPickup = '' Or LEN ( @asAdrCpPickup ) <> 5 
			Begin
				Set @asMessRet = 'Le code postal du relais PickUp doit être renseigné (VarChar (5))'
				Set @sDataErreur = @asAdrCpPickup
				Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -110, @asMessRet, @sDataErreur
				Return -110
			End 

		Set @asAdrVillePickup = Upper ( Trim ( @asAdrVillePickup ))
		IF @asAdrVillePickup is null Or @asAdrVillePickup = '' 
			Begin
				Set @asMessRet = 'La ville du relais PickUp doit être renseignée'
				Set @sDataErreur = @asAdrVillePickup
				Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -120, @asMessRet, @sDataErreur
				Return -120
			End 

		Set @sRefAssPickUp = CONVERT ( Varchar ( 40 ), @adcIdSin ) + ' ' + @asNomLivr + ' ' + @asPrenomLivr

	End 

If @aiCodCivLivr is null Or @aiCodCivLivr <= 0
	Begin
		Set @asMessRet = 'Interlocuteur lié à la prestation : code civilité (en code SIMPA2) obligatoire (1=Monsieur, 2=Madame, 4=Madame, Monsieur, 5=Société)'
		Set @sDataErreur = Convert ( VarChar ( 255), @aiCodCivLivr )
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -260, @asMessRet, @sDataErreur
		Return -260

		If Not Exists ( 
			Select Top 1 1 
			From sysadm.code_car
			Where id_typ_code = '-CI'
			And   id_code = CONVERT ( Varchar (2), @aiCodCivLivr ) 
		)
		Begin
			Set @asMessRet = 'Interlocuteur lié à la prestation : code civilité non valide (1=Monsieur, 2=Madame, 4=Madame, Monsieur, 5=Société)'
			Set @sDataErreur = Convert ( VarChar ( 255), @aiCodCivLivr )
			Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -270, @asMessRet, @sDataErreur
			Return -270
		End 
	End 


Set @asAdr1Livr = UPPER ( Trim ( @asAdr1Livr ))
If @asAdr1Livr is null Or @asAdr1Livr = ''
	Begin
		Set @asMessRet = 'Interlocuteur lié à la prestation : La 1ère ligne d''adresse de l''interlocuteur doit être renseignée (varchar (35 ))'
		Set @sDataErreur = @asAdr1Livr
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -290, @asMessRet, @sDataErreur
		Return -290
	End 

-- @asAdr2Livr VarChar ( 35 ), pas contrôle
-- @asAdr3Livr VarChar ( 35 ), pas contrôle
-- @asAdrCpLivr VarChar ( 35 ), pas contrôle

Set @asAdrVilleLivr = UPPER ( Trim ( @asAdrVilleLivr ))
If @asAdrVilleLivr is null Or @asAdrVilleLivr = ''
	Begin
		Set @asMessRet = 'Interlocuteur lié à la prestation : La ville de l''adresse de l''interlocuteur doit être renseignée (varchar (35 ))'
		Set @sDataErreur = @asAdrVilleLivr
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -300, @asMessRet, @sDataErreur
		Return -300
	End 

Set @asNumTelLivr = UPPER ( Trim ( @asNumTelLivr ))
If @asNumTelLivr is null Or @asNumTelLivr = ''
	Begin
		Set @asMessRet = 'Interlocuteur lié à la prestation : Le numéro de téléphone où joindre l''interlocuteur doit être renseignée (varchar (35 ))'
		Set @sDataErreur = @asNumTelLivr
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -310, @asMessRet, @sDataErreur
		Return -310
	End 

If Left ( @asNumTelLivr, 2 ) not in ( '06', '07' )
	Begin
		Set @asMessRet = 'Interlocuteur lié à la prestation : Le numéro de téléphone où joindre l''interlocuteur doit être numéro de protable 06 ou 07)'
		Set @sDataErreur = @asNumTelLivr
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -315, @asMessRet, @sDataErreur
		Return -315
	End 

Set @asProcessAcheminement = UPPER ( Trim ( @asProcessAcheminement ))
If @asProcessAcheminement is null 
	Begin 
		Set @asMessRet = 'Le process d''acheminement est obligatoire (VarChar (100)) et en l''absence de process d''acheminement, passez AUCUN. Sinon en exemple de process : PICK_UP_POINT ou POST_OFFICE ou PICK_UP_TRANSPORTATION etc...'
		Set @sDataErreur = @asProcessAcheminement
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION @adcIdSin, -130, @asMessRet, @sDataErreur
		Return -130
	End 

--------------------------
-- Traitement			--
--------------------------

-- Epuration des caractères gênant

Set @asNomLivr =  UPPER ( sysadm.FN_EPURE_CHAINE_V02 (
			Upper ( 
			Replace ( Replace ( Replace ( Replace ( Replace ( 
			Replace ( trim ( @asNomLivr), '''', '' ), 
			char ( 13 ), '' ),
			char ( 10 ), '' ),
			char ( 9 ), '' ),
			char ( 11 ), '' ),
			'"', '' )
			), 'NATIF&RC_TAB_DQ' ))

Set @asPrenomLivr =  UPPER ( sysadm.FN_EPURE_CHAINE_V02 (
			Upper ( 
			Replace ( Replace ( Replace ( Replace ( Replace ( 
			Replace ( trim ( @asPrenomLivr), '''', '' ), 
			char ( 13 ), '' ),
			char ( 10 ), '' ),
			char ( 9 ), '' ),
			char ( 11 ), '' ),
			'"', '' )
			), 'NATIF&RC_TAB_DQ' ))

Set @asAdr1Livr = UPPER ( sysadm.FN_EPURE_CHAINE_V02 (
			Upper ( 
			Replace ( Replace ( Replace ( Replace ( Replace ( 
			Replace ( trim ( @asAdr1Livr), '''', '' ), 
			char ( 13 ), '' ),
			char ( 10 ), '' ),
			char ( 9 ), '' ),
			char ( 11 ), '' ),
			'"', '' )
			), 'NATIF&RC_TAB_DQ' ))


Set @asAdr2Livr =  UPPER ( sysadm.FN_EPURE_CHAINE_V02 (
			Upper ( 
			Replace ( Replace ( Replace ( Replace ( Replace ( 
			Replace ( rtrim ( @asAdr2Livr ), '''', '' ), 
			char ( 13 ), '' ),
			char ( 10 ), '' ),
			char ( 9 ), '' ),
			char ( 11 ), '' ),
			'"', '' )
			), 'NATIF&RC_TAB_DQ' ))


Set @asAdr3Livr =  UPPER ( sysadm.FN_EPURE_CHAINE_V02 (
			Upper ( 
			Replace ( Replace ( Replace ( Replace ( Replace ( 
			Replace ( rtrim ( @asAdr3Livr), '''', '' ), 
			char ( 13 ), '' ),
			char ( 10 ), '' ),
			char ( 9 ), '' ),
			char ( 11 ), '' ),
			'"', '' )
			), 'NATIF&RC_TAB_DQ' ))

Set @asAdrCpLivr =  UPPER (sysadm.FN_EPURE_CHAINE_V02 (
			Upper ( 
			Replace ( Replace ( Replace ( Replace ( Replace ( 
			Replace ( rtrim ( @asAdrCpLivr ), '''', '' ), 
			char ( 13 ), '' ),
			char ( 10 ), '' ),
			char ( 9 ), '' ),
			char ( 11 ), '' ),
			'"', '' )
			), 'NATIF&RC_TAB_DQ' ))

Set	@asAdrVilleLivr =  UPPER ( sysadm.FN_EPURE_CHAINE_V02 (
			Upper ( 
			Replace ( Replace ( Replace ( Replace ( Replace ( 
			Replace ( rtrim ( @asAdrVilleLivr), '''', '' ), 
			char ( 13 ), '' ),
			char ( 10 ), '' ),
			char ( 9 ), '' ),
			char ( 11 ), '' ),
			'"', '' )
			), 'NATIF&RC_TAB_DQ' ))

Set	@asDescriptionProbleme =  UPPER ( sysadm.FN_EPURE_CHAINE_V02 (
			Upper ( 
			Replace ( Replace ( Replace ( Replace ( Replace ( 
			Replace ( rtrim ( @asDescriptionProbleme ), '''', '' ), 
			char ( 13 ), '' ),
			char ( 10 ), '' ),
			char ( 9 ), '' ),
			char ( 11 ), '' ),
			'"', '' )
			), 'NATIF&RC_TAB_DQ' ))


Insert into sysadm.stk_data_hub_automate ( 
       [id_sin]
      ,[id_seq]
      ,[id_gti]
      ,[id_hub_presta]
      ,[id_four]
      ,[typ_dommage]
      ,[ordre_action]
      ,[typ_app_sin]
      ,[marq_app_sin]
      ,[modl_app_sin]
      ,[num_tel_app_sin]
      ,[mt_val_achat]
      ,[dte_achat]
      ,[etat_app_sin]
      ,[code_verrou]
      ,[desimlocke]
      ,[point_service]
      ,[mode_logis]
      ,[code_pickup]
      ,[nom_pickup]
      ,[ref_ass_pickup]
      ,[adr1_pickup]
      ,[adr2_pickup]
      ,[adr3_pickup]
      ,[adr_cp_pickup]
      ,[adr_ville_pickup]
      ,[cod_civ_livr]
      ,[nom_livr]
      ,[prenom_livr]
      ,[adr1_livr]
      ,[adr2_livr]
      ,[adr3_livr]
      ,[adr_cp_livr]
      ,[adr_ville_livr]
      ,[num_tel1_livr]
      ,[num_imei_app_sin]
      ,[num_serie_app_sin]
      ,[description_probleme]
      ,[process_acheminement]
      ,[id_depot_s2tohub]
      ,[chaine_seria]
      ,[cree_le]
      ,[maj_le]
      ,[maj_par]

)
Values  (
		@adcIdSin,
		null,
		@adcIdGti,
		@asIdHubPresta, 
		@asIdFour,
		@asTypDommage,
		@asOrdreAction,
		@asTypAppSin,
		@asMarqAppSin,
		@asModlAppSin,
		@asNumTelAppSin,
		@adcMtValAchat,
		@adtDateAchat,
		@asEtatAppSin,
		@asCodeVerrou,
		@asDesimlocke,
		@asPointService,
		@asModeLogis,
		@asCodePickup,
		@asNomPickup,
		@sRefAssPickUp,
		@asAdr1Pickup,
		@asAdr2Pickup,
		@asAdr3Pickup,
		@asAdrCpPickup,
		@asAdrVillePickup,
		@aiCodCivLivr,
		@asNomLivr,
		@asPrenomLivr,
		@asAdr1Livr,
		@asAdr2Livr,
		@asAdr3Livr,
		@asAdrCpLivr,
		@asAdrVilleLivr,
		@asNumTelLivr, 
		@asNumImeiAppSin,
		@asNumSerieAppSin,
		@asDescriptionProbleme,
		@asProcessAcheminement,
		null,
		@asChaineSeria,
		GETDATE(),
		GETDATE(),
		'WEB'
)

If @@ROWCOUNT = 1 And @@ERROR = 0
	Begin 
		Set @asMessRet = 'Stockage des informations liées à la prestation effectué avec succès sur SIMPA2' 
		Return 1
	End 
	Else
	Begin 
		Set @asMessRet = 'Error technique ' + CONVERT ( VarChar ( 30 ), @@ERROR )
		Return -1000
	End 

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__TRACE_STOCKAGE_INFOS_PRESTATION
	@adcIdSin Decimal ( 10 ),
	@aiIdErreur Integer,
	@asMessageErreur VarChar ( 255 ),
	@asDonneeEnErreur VarChar ( 255 )
As

Insert into  [sysadm].trace_stk_data_hub_automate (
	id_sin,
	id_erreur,
	message_erreur,
	donnee_en_erreur,
	cree_le,
	maj_le,
	maj_par
)
Values (
	@adcIdSin,
	@aiIdErreur,
	@asMessageErreur,
	@asDonneeEnErreur,
	GETDATE(),
	GETDATE(),
	'SQL'
)

Go


--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__DECLENCHEMENT_AUTOMATISATION
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__DECLENCHEMENT_AUTOMATISATION' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__DECLENCHEMENT_AUTOMATISATION
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__DECLENCHEMENT_AUTOMATISATION
	@adcIdSin Decimal ( 10 )
AS

Declare @iRet Integer 
Declare @dcIdGti Decimal ( 7 )
Declare @dcIdDetail Decimal ( 7 )
Declare @iIdSeqPresta Integer

-- [LGY38] afin que le CCO ne ramasse un éventuel travail présent
-- Même si DELETE ensuite, le Trv pourrait être affecté au CCO, donc le pus tôt possible il faut couper
Update sysadm.w_queue Set etat_iwd = 99 Where id_sin = @adcIdSin

-- Contrôle éligibilité dossier à l'automatisme
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__CONTROLE_ELIGIBILITE_DOSSIER @adcIdSin
If @iRet = -1 Return @iRet

-- Contrôle intégrité dossier
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__CONTROLE_INTEGRITE_DOSSIER @adcIdSin
If @iRet = -1 Return @iRet

-- Refus
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__DECLENCHEMENT_REFUS @adcIdSin
If @iRet = -1 Return @iRet

-- Piece
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__COCHAGE_DES_PIECES @adcIdSin
If @iRet = -1 Return @iRet

-- Détail de garantie
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__CREATION_DETAIL_DE_GARANTIE @adcIdSin, @dcIdGti OutPut, @dcIdDetail Output
If @iRet = -1 Return @iRet

-- Plafond et PEC
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__DECLENCHEMENT_PLAFOND_ET_PEC @adcIdSin, @dcIdGti, @dcIdDetail
If @iRet = -1 Return @iRet

-- Presta
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__CREATION_DE_LA_PRESTATION @adcIdSin, @dcIdGti, @dcIdDetail, @iIdSeqPresta OutPut
If @iRet = -1 Return @iRet

-- Validation
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__VALIDATION_DU_DOSSIER @adcIdSin, @dcIdGti, @dcIdDetail, @iIdSeqPresta
If @iRet = -1 Return @iRet

Return @iRet 

Go


--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__CONTROLE_ELIGIBILITE_DOSSIER
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__CONTROLE_ELIGIBILITE_DOSSIER' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__CONTROLE_ELIGIBILITE_DOSSIER
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__CONTROLE_ELIGIBILITE_DOSSIER
	@adcIdSin Decimal ( 10 )
AS
Declare @dtValideLe DateTime
Set @dtValideLe = GetDate()

-- Mise à jour de l'histo des pièces
Exec sysadm.PS_IU_PIECE_HISTO @adcIdSin, @dtValideLe

-- Je coupe le travail dans tous les cas, car je le remettrai (ou pas) selon la suite
Delete sysadm.w_queue Where id_sin = @adcIdSin
Update sysadm.routage Set alt_queue = 'N' Where id_sin = @adcIdSin

-- Le produit est-il éligible à une automatisation ?
If Not Exists ( 
	Select	Top 1 1 
	From	sysadm.w_sin ws,
			sysadm.det_pro dp
	Where	ws.id_sin = @adcIdSin
	And		dp.id_prod = ws.id_prod
	And		dp.id_code_dp = 406
) 
Begin
	Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Prod. non éligible dp406 absente', 'Ce produit de sinistre n''est pas éligible à l''automatisation d''une déclaration par extranet.'
	Return -1
End	

-- Cpt_Valide w_sin > 0
If Exists ( 
		Select	Top 1 1 
		From	sysadm.w_sin ws
		Where	ws.id_sin = @adcIdSin
		And		ws.cpt_valide > 0
	) 
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Déja validé une fois', 'Ce dossier a déjà subi une validation, il n''est donc pas éligible à l''automatisation d''une déclaration par extranet.'
		Return -1
	End	

-- Blocage sur Géoloc
If Exists ( 
		Select	top 1 1 
		From	sysadm.w_sin ws,
				sysadm.w_div_sin wdsTypeApp,
				sysadm.w_div_sin wdsGeolocAtlas
		Where   ws.id_sin = @adcIdSin
		And		ws.marq_port = 'APPLE'
		And		wdsTypeApp.id_sin = ws.id_sin
		And		wdsTypeApp.nom_zone = 'type_app'
		And		wdsTypeApp.val_car = 'TEL'
		And		wdsGeolocAtlas.id_sin = ws.id_sin
		And		wdsGeolocAtlas.nom_zone = 'geoloc_simpa2'
		And		wdsGeolocAtlas.val_car = 'O'
	)
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'APPLE Géolocalisé', 'Les dossiers avec un APPLE géolocalisé ne sont pas éligibles à l''automatisation d''une déclaration par extranet.'
		Return -1
	End		

Return 1

Go


--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__CONTROLE_INTEGRITE_DOSSIER
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__CONTROLE_INTEGRITE_DOSSIER' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__CONTROLE_INTEGRITE_DOSSIER
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__CONTROLE_INTEGRITE_DOSSIER
	@adcIdSin Decimal ( 10 )
AS

Declare @sVal Varchar ( 200 )
Declare @sMarqueAppSin Varchar ( 35 ) 
Declare @sModlAppSin Varchar ( 35 ) 
Declare @sCodeRetIfr Varchar ( 20 )
Declare @sAdrMailInterAss Varchar ( 120 )
Declare @sVarianteDp406 Varchar ( 50 )

Select @sVarianteDp406 = sysadm.FN_CLE_VAL ( 'VARIANTE', Trim ( dp.val_car ) + Trim ( dp.val_car2 ) , ';')
From sysadm.det_pro dp,
	 sysadm.w_sin ws
Where ws.id_sin = @adcIdSin
And dp.id_prod = ws.id_prod
	

-- absence ligne dans w_sin
If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Le sinistre n''existe pas', 'La référence sinistre n''existe pas. La référence transmise à l''automate par l''extranet ne réfère aucun sinistre dans la base de données SIMPA2. Automatisation impossible.'
		Return -1
	End		

-- Absence de date de fin de garantie
If Exists ( Select Top 1 1 
			From sysadm.w_sin ws,
				 sysadm.produit p 
			Where ws.id_sin = @adcIdSin
			And p.id_prod = ws.id_prod
			And ws.dte_fin_gti is null
			And p.cod_adh Not In ( 3, 6 )
		  )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Date de fin de gtie non renseignée', 'La date de fin de garantie est obligatoire pour la méthode d''adhésion paramétrée sur le produit. Automatisation impossible.'
		Return -1
	End		

-- absence de nature de sinistre (id_natsin)
If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And id_natsin is not null And id_natsin <> 0 )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Nature de sinistre non renseignée', 'La nature de sinistre n''a pas été renseignée par l''extranet. Automatisation impossible.'
		Return -1
	End	

-- Contrôle nature de siniste existe dans le param
If Not Exists ( 
		Select	Top 1 1
		From	sysadm.code_condition c,
				sysadm.w_sin ws
		Where	ws.id_sin = @adcIdSin
		And		c.id_prod = ws.id_prod
		And		c.id_typ_code = '+NS'
		And		c.id_code = ws.id_natsin
	)
	Begin
		Select @sVal = CONVERT ( Varchar ( 20 ), id_natsin ) From sysadm.w_sin Where id_sin = @adcIdSin 
		If @sVal is null Set @sVal = ''
		Set @sVal = 'La nature de sinistre (' + @sVal + ') transmise par l''extranet n''existe pas dans la paramètrage de ce contrat. Automatisation impossible.'
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Nature de sinistre non valide', @sVal 
		Update sysadm.w_sin Set id_natsin = null Where id_sin = @adcIdSin 
		Return -1
	End 


-- absence de territorialité de sinistre (id_territ)
If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And id_territ is not null And id_territ <> 0 )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Territorialité non renseignée', 'La territorialité n''a pas été renseignée par l''extranet. Automatisation impossible.'
		Return -1
	End	

-- Contrôle territorialité existe dans le param
If Not Exists ( 
		Select	Top 1 1
		From	sysadm.code_condition c,
				sysadm.w_sin ws
		Where	ws.id_sin = @adcIdSin
		And		c.id_prod = ws.id_prod
		And		c.id_typ_code = '+TR'
		And		c.id_code = ws.id_territ
	)
	Begin
		Select @sVal = CONVERT ( Varchar ( 20 ), id_territ ) From sysadm.w_sin Where id_sin = @adcIdSin 
		If @sVal is null Set @sVal = ''
		Set @sVal = 'La territorialité de sinistre (' + @sVal + ') transmise par l''extranet n''existe pas dans la paramètrage de ce contrat. Automatisation impossible.'
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Territ. de sinistre non valide', @sVal 
		Update sysadm.w_sin Set id_territ = null Where id_sin = @adcIdSin 
		Return -1
	End 

-- absence de détail de sinistre (id_detsin)
If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And id_detsin is not null And id_detsin <> 0 )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Détail de sinistre non renseigné', 'Le détail de sinistre n''a pas été renseigné par l''extranet. Automatisation impossible.'
		Return -1
	End	

-- Contrôle territorialité existe dans le param
If Not Exists ( 
		Select	Top 1 1
		From	sysadm.code_condition c,
				sysadm.w_sin ws
		Where	ws.id_sin = @adcIdSin
		And		c.id_prod = ws.id_prod
		And		c.id_typ_code = '+DT'
		And		c.id_code = ws.id_detsin
	)
	Begin
		Select @sVal = CONVERT ( Varchar ( 20 ), id_detsin ) From sysadm.w_sin Where id_sin = @adcIdSin 
		If @sVal is null Set @sVal = ''
		Set @sVal = 'Le détail de sinistre (' + @sVal + ') transmis par l''extranet n''existe pas dans la paramètrage de ce contrat. Automatisation impossible.'
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Detail de sinistre non valide', @sVal
		Update sysadm.w_sin Set id_detsin = null Where id_sin = @adcIdSin 
		Return -1
	End 


-- absence donnée dans dte_surv
If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And dte_surv is not null )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Date de survenance non renseignée', 'La date de survenance n''a pas été renseignée par l''extranet. Automatisation impossible.'
		Return -1
	End	

-- absence donnée dans dte_decl
If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And dte_decl is not null )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Date de déclaration non renseignée', 'La date de déclaration n''a pas été renseignée par l''extranet. Automatisation impossible.'
		Return -1
	End	

-- absence donnée dans id_ets..., 
If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And id_ets is not null )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'ETS adhésion non renseignée', 'L''établissement adhésion n''a pas été renseigné par l''extranet. Automatisation impossible.'
		Return -1
	End	
-- ...et contrôle présence table établissement
If Not Exists ( Select Top 1 1 
				From sysadm.w_sin ws,
						sysadm.etablissement ets
				Where ws.id_sin = @adcIdSin 
				And	  ets.id_prod = ws.id_prod
				And	  ets.id_rev = ws.id_rev
				And   ets.id_ets = ws.id_ets  )
	Begin
		Select @sVal = CONVERT ( Varchar ( 20 ), id_ets ) From sysadm.w_sin Where id_sin = @adcIdSin 
		If @sVal is null Set @sVal = ''
		Set @sVal = 'L''établissement adhésion (' + @sVal + ') transmis pas l''extranet n''existe pour ce produit. Automatisation impossible.'
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'ETS non paramétré ', @sVal
		Return -1
	End	

-- Absence donnée dans dte_adh
If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And dte_adh is not null )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Date adhésion non renseignée', 'La date d''adhésion n''a pas été renseignée par l''extranet. Automatisation impossible.'
		Return -1
	End	

-- Contrôle du texte de déclaration (22/05/2018 JFF)
Select @sVal = 
		Upper ( 
		Replace ( Replace ( Replace ( Replace ( Replace ( 
		Replace ( ltrim ( rtrim ( ws.txt_mess)), '''', '' ), 
		char ( 13 ), '' ),
		char ( 10 ), '' ),
		char ( 9 ), '' ),
		char ( 11 ), '' ),
		'"', '' )
		) 
From  sysadm.w_sin ws
Where ws.id_sin = @adcIdSin

If @sVal is null Set @sVal = ''
If @sVal = ''
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Texte de déclaration non renseigné', 'Le texte de déclaration n''a pas été renseigné par l''extranet. Automatisation impossible.'
		Return -1
	End 

-- absence donnée dans id_sdos
If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And id_sdos is not null And id_sdos <> 0 )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Co-adhérent non renseigné', 'Le co-adhérent n''a pas été renseigné par l''extranet. Automatisation impossible.'
		Return -1
	End	

-- Absence donnée dans civ
If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And cod_civ is not null And cod_civ <> 0 )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Civilité non renseignée (w_sin)', 'La civilité de l''assuré n''a pas été renseignée par l''extranet. Automatisation impossible.'
		Return -1
	End	

-- Présence donnée dans nom
If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And nom is not null And ltrim ( nom ) <> '' )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Nom non renseignée (w_sin)', 'Le nom de l''assuré n''a pas été renseigné par l''extranet. Automatisation impossible.'
		Return -1
	End	

-- Présence donnée dans prénom (si absente, mettre un point)
If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And prenom is not null And ltrim ( prenom ) <> '' )
	Begin
		If ( Select cod_civ From sysadm.w_sin Where id_sin = @adcIdSin ) = 5
			Begin
				Update sysadm.w_sin Set prenom = '.' Where id_sin = @adcIdSin 
			End
		Else
			Begin
				Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Prénom non renseignée (w_sin)', 'Le prénom de l''assuré n''a pas été renseigné par l''extranet. Automatisation impossible.'
				Return -1
			End
	End	

-- Présence donnée dans adr_1
If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And adr_1 is not null And ltrim ( adr_1 ) <> '' )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Adresse non renseignée (w_sin)', 'L''adresse de l''assuré n''a pas été renseignée par l''extranet. Automatisation impossible.'
		Return -1
	End	

-- Présence donnée dans adr_cp
If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And adr_cp is not null And ltrim ( adr_cp ) <> '' )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'CP non renseignée (w_sin)', 'Le code postal de l''assuré n''a pas été renseigné par l''extranet. Automatisation impossible.'
		Return -1
	End	

-- Présence donnée dans adr_ville
If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And adr_ville is not null And ltrim ( adr_ville ) <> '' )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Ville non renseignée (w_sin)', 'La ville de l''assuré n''a pas été renseignée par l''extranet. Automatisation impossible.'
		Return -1
	End	

-- Contrôle cohérence cp/ville
IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	If Not Exists ( 
			Select	Top 1 1 
			From	SESAME_PRO.sysadm.commune c,
					sysadm.w_sin ws
			Where	ws.id_sin = @adcIdSin
			And     c.code_postal = ws.adr_cp
			And		c.nom_commune = ws.adr_ville
			)
		Begin
			Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Cohér. CP/Ville incorrect (w_sin)', 'La cohérence code postal/ville de l''assuré par rapport au référentiel, n''est pas respectée par l''extranet. Automatisation impossible.'
			Return -1
		End	
END
ELSE
Begin
	If Not Exists ( 
			Select	Top 1 1 
			From	SESAME_SIM.sysadm.commune c,
					sysadm.w_sin ws
			Where	ws.id_sin = @adcIdSin
			And     c.code_postal = ws.adr_cp
			And		c.nom_commune = ws.adr_ville
			)
		Begin
			Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Cohér. CP/Ville incorrect (w_sin)', 'La cohérence code postal/ville de l''assuré par rapport au référentiel, n''est pas respectée par l''extranet. Automatisation impossible.'
			Return -1
		End	
End

-- MONACO
If Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And upper ( adr_ville ) like '%MONACO%' )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Ville MONACO (w_sin)', 'La ville de l''assuré est MONACO, pas d''automatisation pour cette ville. Automatisation impossible.'
		Return -1
	End	

-- DOM TOM
If Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And left ( adr_cp, 3 ) in ( '971', '972', '973', '974', '975', '976', '984', '986', '987', '988' ))
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'DOM-TOM Trait. Manuel.(w_sin)', 'Les départements DOM-TOM sont à traiter en manuel, pas d''automatisation pour ce cas. Automatisation impossible.'
		Return -1
	End	

-- Absence donnée dans num_port ( 10 chiffre 06, 07)
If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And num_port is not null And ltrim ( num_port ) <> '' And Left ( num_port, 2 ) in ( '06', '07') )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'NumTelSin non valide/rens. (w_sin)', 'Le numéro de téléphone portable de l''assuré n''a pas été renseignée (ou n''est pas valide) par l''extranet. Automatisation impossible.'
		Return -1
	End	


-- Absence donnée dans num_imei_port (num imei valide et 15)
If  Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And num_imei_port is not null And ltrim ( num_imei_port ) <> '' )
	Or 
	Exists ( Select Top 1 1 
			From sysadm.w_sin ws,
					sysadm.w_div_sin wds
			Where ws.id_sin = @adcIdSin 
			And   ws.num_imei_port is not null 
			And trim ( ws.num_imei_port ) <> ''  
			And sysadm.FN_CORR_IMEI ( ws.num_imei_port, Getdate()) <> ws.num_imei_port 
			And wds.id_sin = ws.id_sin
			And wds.nom_zone = 'type_app'
			And wds.val_car in ( 'TEL', 'PC1', 'PC2', 'PC3' )
			)
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'IMEI/Série non valide/renseignée', 'Le numéro IMEI/Série de l''appareil sinistré de l''assuré n''a pas été renseignée (ou n''est pas valide) par l''extranet. Automatisation impossible.'
		Return -1
	End	

-- Absence donnée dans marq_port et modl_port
If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And marq_port is not null And ltrim ( marq_port ) <> '' )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Marque non renseignée', 'La marque de l''appareil sinistré de l''assuré n''a pas été renseignée par l''extranet. Automatisation impossible.'
		Return -1
	End	

If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And modl_port is not null And ltrim ( modl_port ) <> '' )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Modèle non renseignée', 'Le modèle de l''appareil sinistré de l''assuré n''a pas été renseigné par l''extranet. Automatisation impossible.'
		Return -1
	End	

-- Présence typ_app existant dans -dp/25
If Not Exists ( 
		Select Top 1 1 
		From	sysadm.w_div_sin wds,
				sysadm.w_sin ws,
				sysadm.det_pro dp
		Where  ws.id_sin = @adcIdSin 
		And	   wds.id_sin = wds.id_sin
		And	   wds.nom_zone = 'type_app'
		And    dp.id_prod = ws.id_prod
		And    dp.id_code_dp = 25
		And    dp.id_code_car = wds.val_car
		)
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Typ Mat Sin absent/non param', 'Le type de matériel sinistré transmis par l''extranet est absent ou non paramétré pour ce produit. Automatisation impossible.'
		Return -1
	End	

-- Présence alt_decla_web cochée
If Not Exists ( Select Top 1 1 From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'alt_decla_web' And val_car is not null And val_car = 'O' )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'zone alt_decla_web non renseignée', 'La zone technique alt_decla_web n''a pas été renseignée par l''extranet. Automatisation impossible.'
		Return -1
	End

-- Contrôle particuluer qu'on pourra enlever par la suite mais avec de gros modif pour accueillir une valeur publique non ifr pour le détail de garantie
-- Si l'appareil n'est pas lié à IFR, on rejète pour l'instant
-- binome marque/modèle doit appartenir à IFR
If Not Exists ( 
	Select Top 1 1
	From sysadm.w_sin ws,
		 sysadm.w_div_sin wds,
		 sysadm.det_pro dp
	Where ws.id_sin = @adcIdSin
	And wds.id_sin = ws.id_sin
	And wds.nom_zone = 'type_app'
	And dp.id_prod = ws.id_prod
	And dp.id_code_dp = 28
	And dp.id_code_car = 'IFR' + trim ( wds.val_car )
)
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Appareil non lié à IFR', 'Pour l''instant, seul les déclarations de sinistre dont l''appareil est à IFR peuvent se faire. Automatisation impossible.'
		Return -1
	End

-- binome marque/modèle doit appartenir à IFR
If Exists ( 
	Select Top 1 1
	From sysadm.w_sin ws,
		 sysadm.w_div_sin wds,
		 sysadm.det_pro dp
	Where ws.id_sin = @adcIdSin
	And wds.id_sin = ws.id_sin
	And wds.nom_zone = 'type_app'
	And dp.id_prod = ws.id_prod
	And dp.id_code_dp = 28
	And dp.id_code_car = 'IFR' + trim ( wds.val_car )
)
And Not Exists ( 
	Select Top 1 1 
	From sysadm.ifr i,
		 sysadm.w_sin ws
	Where ws.id_sin = @adcIdSin
	And   i.marque = ws.marq_port
	And   i.reference = ws.modl_port
)
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Marque/Modèle incohérent Réf IFR', 'Le binôme marque/modèle de l''appareil sinistre de l''assuré transmis par l''extranet, n''est pas valide sous le référentiel IFR ou bien le type ne correspond pas au modèle. Automatisation impossible.'
		Return -1
	End	

-- [RS2980_IFR] -- Ctrle Validité prix IFR
Select	@sMarqueAppSin = ws.marq_port,
		@sModlAppSin = ws.modl_port
From sysadm.w_sin ws
Where ws.id_sin = @adcIdSin

Exec sysadm.PS_U_MARQUAGE_PRIX_IFR_A_REVOIR @sMarqueAppSin, @sModlAppSin, @sCodeRetIfr OutPut

If @sCodeRetIfr = 'URGE'
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Prix public IFR obsolète', 'Le prix IFR de l''appareil est obsolète, ce contact vient d''alerter automatiquement notre équipe lui demandant de revoir le prix de cet appareil en priorité, ce qui sera fait sous 24h.@Durant ce délai, toute validation du dossier est impossible. Automatisation impossible.'
		Return -1
	End 

-- Absence donnée dte_ach_port
If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And dte_ach_port is not null )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Date achat non renseignée', 'La date d''achat de l''appareil sinistré de l''assuré n''a pas été renseigné par l''extranet. Automatisation impossible.'
		Return -1
	End	

-- Absence de garantie
If Not Exists ( Select Top 1 1 From sysadm.w_gar_sin Where id_sin = @adcIdSin )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Absence de garantie', 'aucune garantie n''a pas été renseigné par l''extranet. Automatisation impossible.'
		Return -1
	End	

-- Absence de garantie
If ( Select COUNT ( * ) From sysadm.w_gar_sin Where id_sin = @adcIdSin ) > 1
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Plus d''une de garantie', 'L''extranet a créé plus d''une garantie. Automatisation impossible.'
		Return -1
	End	

-- Pour Bouygues GEN CODE obligatoire et valide au moins sur le format numx13
If @sVarianteDp406 = 'BOUYGUES'
	Begin
		Set @sVal = sysadm.FN_GET_DIV_SIN (@adcIdSin, 'code_ean', 'W', '' )
		If IsNumeric ( @sVal ) = 0 Or Len ( Trim ( @sVal ) ) <> 13
			Begin 
				Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Code EAN non valide', 'L''extranet a transmis un Code EAN non valide au niveau du format (doit comporter 13 chiffres). Automatisation impossible.'
				Return -1
			End 
	End 

-- La garantie doit être paramétré sur le contrat
If Not Exists ( 
		Select	Top 1 1
		From	sysadm.code_garantie c,
				sysadm.w_sin ws,
				sysadm.w_gar_sin wg
		Where	ws.id_sin = @adcIdSin
		And		wg.id_sin = ws.id_sin
		And		c.id_prod = ws.id_prod
		And		c.id_gti = wg.id_gti
	)
	Begin
		Select Top 1 @sVal = CONVERT ( Varchar ( 20 ), id_gti ) From sysadm.w_gar_sin Where id_sin = @adcIdSin 
		If @sVal is null Set @sVal = ''
		Set @sVal = 'Le garantie (' + @sVal + ') transmis par l''extranet n''existe pas dans la paramètrage de ce contrat. Automatisation impossible.'
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Detail de sinistre non valide', @sVal

		Delete sysadm.w_div_det 
		From   sysadm.w_sin s,
				sysadm.w_div_det w
		where s.id_sin = @adcIdSin 
		And   w.id_sin = s.id_sin
		And   Not Exists ( 
			Select Top 1 1 
			From   sysadm.code_garantie cg
			Where  cg.id_prod = s.id_prod
			And    cg.id_gti  = w.id_gti
		)

		Delete sysadm.w_refus 
		From   sysadm.w_sin s,
				sysadm.w_refus w
		where s.id_sin = @adcIdSin 
		And   w.id_sin = s.id_sin
		And   Not Exists ( 
			Select Top 1 1 
			From   sysadm.code_garantie cg
			Where  cg.id_prod = s.id_prod
			And    cg.id_gti  = w.id_gti
		)


		Delete sysadm.w_piece 
		From   sysadm.w_sin s,
				sysadm.w_piece w
		where s.id_sin = @adcIdSin 
		And   w.id_sin = s.id_sin
		And   Not Exists ( 
			Select Top 1 1 
			From   sysadm.code_garantie cg
			Where  cg.id_prod = s.id_prod
			And    cg.id_gti  = w.id_gti
		)

		Delete sysadm.w_detail 
		From   sysadm.w_sin s,
				sysadm.w_detail w
		where s.id_sin = @adcIdSin 
		And   w.id_sin = s.id_sin
		And   Not Exists ( 
			Select Top 1 1 
			From   sysadm.code_garantie cg
			Where  cg.id_prod = s.id_prod
			And    cg.id_gti  = w.id_gti
		)

		Delete sysadm.w_detail 
		From   sysadm.w_sin s,
				sysadm.w_detail w
		where s.id_sin = @adcIdSin 
		And   w.id_sin = s.id_sin
		And   Not Exists ( 
			Select Top 1 1 
			From   sysadm.code_garantie cg
			Where  cg.id_prod = s.id_prod
			And    cg.id_gti  = w.id_gti
		)


		Delete sysadm.w_gar_sin 
		From   sysadm.w_sin s,
				sysadm.w_gar_sin w
		where s.id_sin = @adcIdSin 
		And   w.id_sin = s.id_sin
		And   Not Exists ( 
			Select Top 1 1 
			From   sysadm.code_garantie cg
			Where  cg.id_prod = s.id_prod
			And    cg.id_gti  = w.id_gti
		)

		Return -1
	End 

-----------------------------------
-- Contrôle interlocuteur Assuré --
-----------------------------------
If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' )
Begin
	Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Inter Assuré absent', 'L''interlocuteur Assuré est absent, il n''a pas été créé par l''extranet. Automatisation impossible.'
	Return -1
End	

-- absence donnée dans civ
If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And cod_civ is not null And cod_civ <> 0 )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Civilité non renseignée (w_interA)', 'La civilité de l''assuré n''a pas été renseignée par l''extranet. Automatisation impossible.'
		Return -1
	End	

-- donnée dans civ non valide
If Not Exists ( Select Top 1 1 From sysadm.w_inter wi, sysadm.code c Where wi.id_sin = @adcIdSin And wi.cod_inter = 'A' And c.id_typ_code = '-CI' and c.id_code = Convert ( decimal (7), wi.cod_civ ) )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Civilité non valide (w_interA)', 'La civilité de l''assuré transmises par l''extranet n''est pas valide (-IN). Automatisation impossible.'
		Return -1
	End	

-- Présence donnée dans nom
If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And nom is not null And ltrim ( nom ) <> '' )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Nom non renseignée (w_interA)', 'Le nom de l''assuré n''a pas été renseigné par l''extranet. Automatisation impossible.'
		Return -1
	End	

-- Présence donnée dans adr_1
If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And adr_1 is not null And ltrim ( adr_1 ) <> '' )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Adresse non renseignée (w_interA)', 'L''adresse de l''assuré n''a pas été renseignée par l''extranet. Automatisation impossible.'
		Return -1
	End	

-- Présence donnée dans adr_cp
If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And adr_cp is not null And ltrim ( adr_cp ) <> '' )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'CP non renseignée (w_interA)', 'Le code postal de l''assuré n''a pas été renseigné par l''extranet. Automatisation impossible.'
		Return -1
	End	

Update sysadm.w_inter 
Set    adr_cp = Right ( replicate ( '0', 5 ) + rtrim ( ltrim ( adr_cp )), 5 ) 
Where  id_sin = @adcIdSin
And    cod_inter = 'A'

-- Présence donnée dans adr_ville
If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And adr_ville is not null And ltrim ( adr_ville ) <> '' )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Ville non renseignée (w_interA)', 'La ville de l''assuré n''a pas été renseignée par l''extranet. Automatisation impossible.'
		Return -1
	End	

-- MONACO
If Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And upper ( adr_ville ) like '%MONACO%' )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Ville MONACO (w_interA)', 'La ville de l''interlocuteur assuré est MONACO, pas d''automatisation pour cette ville. Automatisation impossible.'
		Return -1
	End	

-- DOM TOM
If Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And left ( adr_cp, 3 ) in ( '971', '972', '973', '974', '975', '976', '984', '986', '987', '988' ))
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'DOM-TOM Trait. Manuel.(w_interA)', 'Les départements DOM-TOM sont à traiter en manuel, pas d''automatisation pour ce cas. Automatisation impossible.'
		Return -1
	End	

-- Contrôle cohérence cp/ville
IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
Begin
					
	If Not Exists ( 
			Select	Top 1 1 
			From	SESAME_PRO.sysadm.commune c,
					sysadm.w_inter wi
			Where	wi.id_sin = @adcIdSin
			And		wi.cod_inter = 'A'
			And     c.code_postal = wi.adr_cp
			And		c.nom_commune = wi.adr_ville
			)
		Begin
			Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Cohé. CP/Ville incorrect (w_interA)', 'La cohérence code postal/ville de l''assuré par rapport au référentiel, n''est pas respectée par l''extranet. Automatisation impossible.'
			Return -1
		End	
End
Else
Begin
	If Not Exists ( 
		Select	Top 1 1 
		From	SESAME_SIM.sysadm.commune c,
				sysadm.w_inter wi
		Where	wi.id_sin = @adcIdSin
		And		wi.cod_inter = 'A'
		And     c.code_postal = wi.adr_cp
		And		c.nom_commune = wi.adr_ville
		)
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Cohé. CP/Ville incorrect (w_interA)', 'La cohérence code postal/ville de l''assuré par rapport au référentiel, n''est pas respectée par l''extranet. Automatisation impossible.'
		Return -1
	End	

End

-- Présence adresse mail
If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And adr_mail is not null And ltrim ( adr_mail ) <> '' )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Adresse mail absente (w_interA)', 'L''adresse mail de l''assuré n''a pas été renseignée par l''extranet. Automatisation impossible.'
		Return -1
	End

Select @sAdrMailInterAss = adr_mail	From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And adr_mail is not null And ltrim ( adr_mail ) <> ''
Set @sAdrMailInterAss = sysadm.FN_EPURE_CHAINE_V02 ( @sAdrMailInterAss, 'NATIF&RC_TAB_DQ' ) 
If sysadm.FN_CTRLE_ADR_MAIL ( @sAdrMailInterAss ) < 0
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Adresse mail non valide (w_interA)', 'L''adresse mail de l''assuré renseignée par l''extranet, n''est pas valide. Automatisation impossible.'
		Return -1
	End 

Update sysadm.w_inter Set adr_mail = @sAdrMailInterAss Where id_sin = @adcIdSin

-- Epuration des caractères gênant
Update sysadm.w_inter
Set nom =   UPPER ( sysadm.FN_EPURE_CHAINE_V02 (
			Upper ( 
			Replace ( Replace ( Replace ( Replace ( Replace ( 
			Replace ( rtrim ( nom), '''', '' ), 
			char ( 13 ), '' ),
			char ( 10 ), '' ),
			char ( 9 ), '' ),
			char ( 11 ), '' ),
			'"', '' )
			), 'NATIF&RC_TAB_DQ' )),
	adr_1 = UPPER ( sysadm.FN_EPURE_CHAINE_V02 (
			Upper ( 
			Replace ( Replace ( Replace ( Replace ( Replace ( 
			Replace ( rtrim ( adr_1), '''', '' ), 
			char ( 13 ), '' ),
			char ( 10 ), '' ),
			char ( 9 ), '' ),
			char ( 11 ), '' ),
			'"', '' )
			), 'NATIF&RC_TAB_DQ' )), 
	adr_2 = UPPER ( sysadm.FN_EPURE_CHAINE_V02 (
			Upper ( 
			Replace ( Replace ( Replace ( Replace ( Replace ( 
			Replace ( rtrim ( adr_2), '''', '' ), 
			char ( 13 ), '' ),
			char ( 10 ), '' ),
			char ( 9 ), '' ),
			char ( 11 ), '' ),
			'"', '' )
			), 'NATIF&RC_TAB_DQ' )), 
	adr_cp = UPPER ( sysadm.FN_EPURE_CHAINE_V02 (
			Upper ( 
			Replace ( Replace ( Replace ( Replace ( Replace ( 
			Replace ( rtrim ( adr_cp), '''', '' ), 
			char ( 13 ), '' ),
			char ( 10 ), '' ),
			char ( 9 ), '' ),
			char ( 11 ), '' ),
			'"', '' )
			), 'NATIF&RC_TAB_DQ' )), 

	adr_ville = UPPER ( sysadm.FN_EPURE_CHAINE_V02 (
			Upper ( 
			Replace ( Replace ( Replace ( Replace ( Replace ( 
			Replace ( rtrim ( adr_ville), '''', '' ), 
			char ( 13 ), '' ),
			char ( 10 ), '' ),
			char ( 9 ), '' ),
			char ( 11 ), '' ),
			'"', '' )
			), 'NATIF&RC_TAB_DQ' ))

Where id_sin = @adcIdSin And cod_inter = 'A'


Return 1

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__DECLENCHEMENT_REFUS
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__DECLENCHEMENT_REFUS' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__DECLENCHEMENT_REFUS
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__DECLENCHEMENT_REFUS
	@adcIdSin Decimal ( 10 )
AS

Declare @iRet Integer

-- Contrôle de la Révision/Avenant
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_REVISION @adcIdSin
If @iRet = -1 Return @iRet

-- Refus 601 : ADHESION RESILIEE
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_601_ADHESION_RESILIEE @adcIdSin
If @iRet = -1 Return @iRet

-- Refus 602 : ADHESION NON SOUSCRITE A DATE_SINISTRE
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_602_ADHESION_NON_SOUSCRITE_A_DATE_SINISTRE @adcIdSin
If @iRet = -1 Return @iRet

-- Refus 603 : PRIMES NON PERCUES
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_603_PRIMES_NON_PERCUES @adcIdSin
If @iRet = -1 Return @iRet

-- Refus 611 : NATURE DE SINISTRE NON COUVERT
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_611_NATURE_DE_SINISTRE_NON_COUVERT @adcIdSin
If @iRet = -1 Return @iRet

-- Refus 612 : DETAIL DE SINISTRE NON COUVERT
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_612_DETAIL_DE_SINISTRE_NON_COUVERT @adcIdSin
If @iRet = -1 Return @iRet

-- Refus 613 : TERRIT. NON COUVERTE
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_613_TERRITORIALITE_NON_COUVERTE @adcIdSin
If @iRet = -1 Return @iRet

-- Refus 641 : DTE ACHAT/OUVLIG > DTE SURVENANCE
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_641_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_SURVENANCE @adcIdSin
If @iRet = -1 Return @iRet

-- Refus 642 : DTE ACHAT/OUVLIG > DTE ADHESION
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_642_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_ADHESION @adcIdSin
If @iRet = -1 Return @iRet

-- Refus 643 : DTE ACHAT/OUVLIG < DTE ADHESION (sur option dp/131)
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_643_DATE_ACHAT_OU_OUVLIG_ANTERIEURE_DTE_ADHESION_DP131 @adcIdSin
If @iRet = -1 Return @iRet

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__REFUS_643_DATE_ACHAT_OU_OUVLIG_ANTERIEURE_DTE_ADHESION_DP131_RECHERCHE
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__REFUS_643_DATE_ACHAT_OU_OUVLIG_ANTERIEURE_DTE_ADHESION_DP131_RECHERCHE' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_643_DATE_ACHAT_OU_OUVLIG_ANTERIEURE_DTE_ADHESION_DP131_RECHERCHE
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_643_DATE_ACHAT_OU_OUVLIG_ANTERIEURE_DTE_ADHESION_DP131_RECHERCHE
	@adcIdProdSin		Decimal ( 7 ), -- Code produit sinistre
	@adtDteAdh			DateTime, -- date de survenance
	@adtDteAchat		DateTime, -- date d'achat
	@adtDteOuvLigne		DateTime, -- date ouverture de ligne
	@asChaineSeriaRetourRefus Varchar ( 500 ) OutPut
AS

If Exists (   
  Select Top 1 1  
  From sysadm.produit p,  
    sysadm.det_pro dp  
  Where p.id_prod = @adcIdProdSin
  And  p.cod_tel > 0  
  And  dp.id_prod = p.id_prod  
  And  dp.id_code_dp = 131  
  And  ( @adtDteAdh > @adtDteAchat Or @adtDteAdh > @adtDteOuvLigne )  
 )  
 Begin  
	Set @asChaineSeriaRetourRefus = sysadm.FN_CLE_VAL_E ( '643', sysadm.FN_CODE_NUM ( 643, '+RE' ), Trim ( @asChaineSeriaRetourRefus ), ';' )
 End   

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__REFUS_643_DATE_ACHAT_OU_OUVLIG_ANTERIEURE_DTE_ADHESION_DP131
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__REFUS_643_DATE_ACHAT_OU_OUVLIG_ANTERIEURE_DTE_ADHESION_DP131' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_643_DATE_ACHAT_OU_OUVLIG_ANTERIEURE_DTE_ADHESION_DP131
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_643_DATE_ACHAT_OU_OUVLIG_ANTERIEURE_DTE_ADHESION_DP131
	@adcIdSin   Decimal (10)/*,
	@asCas		VarChar ( 50 ),
	@asChaineSeriaCodeRefus Varchar ( 255 ) Output*/
AS

/*
Set @asChaineSeriaCodeRefus = Trim ( @asChaineSeriaCodeRefus )
If @asChaineSeriaCodeRefus is null Set @asChaineSeriaCodeRefus = ''
*/

If Exists (   
  Select Top 1 1  
  From sysadm.w_sin ws,  
    sysadm.produit p,  
    sysadm.det_pro dp  
  Where ws.id_sin = @adcIdSin  
  And  p.id_prod = ws.id_prod  
  And  p.cod_tel > 0  
  And  dp.id_prod = ws.id_prod  
  And  dp.id_code_dp = 131  
  And  ( ws.dte_adh > ws.dte_ach_port Or ws.dte_adh > ws.dte_ouvlig_port )  
 )  
 Begin  
	  Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Refus machine 643', 'Le refus machine 643 indiquant une date d''achat/Ouv. Ligne, antérieure à la date d''adhésion s''est déclenché. Automatisation impossible.'  
	  Return -1      
 End   

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__REFUS_642_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_ADHESION_RECHERCHE
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__REFUS_642_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_ADHESION_RECHERCHE' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_642_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_ADHESION_RECHERCHE
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_642_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_ADHESION_RECHERCHE
	@adcIdProdSin		Decimal ( 7 ), -- Code produit sinistre
	@adtDteAdh			DateTime, -- date de survenance
	@adtDteAchat		DateTime, -- date d'achat
	@adtDteOuvLigne		DateTime, -- date ouverture de ligne
	@asChaineSeriaRetourRefus Varchar ( 500 ) OutPut
AS

If Exists (   
  Select Top 1 1  
  From sysadm.produit p  
  Where p.id_prod = @adcIdProdSin
  And  p.cod_tel > 0  
  And  ( @adtDteAdh < @adtDteAchat Or @adtDteAdh < @adtDteOuvLigne )  
 )  
And Not Exists ( 
	Select Top 1 1
	From sysadm.det_pro dp
	Where dp.id_prod = @adcIdProdSin
	And   dp.id_code_dp = 20  
	And   dp.val_car in ( 642, -1 ) 
)
 Begin  
	Set @asChaineSeriaRetourRefus = sysadm.FN_CLE_VAL_E ( '642', sysadm.FN_CODE_NUM ( 642, '+RE' ), Trim ( @asChaineSeriaRetourRefus ), ';' )
 End   

Go


--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__REFUS_642_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_ADHESION
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__REFUS_642_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_ADHESION' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_642_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_ADHESION
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_642_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_ADHESION
	@adcIdSin   Decimal (10)
AS

If Exists (   
  Select Top 1 1  
  From sysadm.w_sin ws,  
    sysadm.produit p  
  Where ws.id_sin = @adcIdSin  
  And  p.id_prod = ws.id_prod  
  And  p.cod_tel > 0  
  And  ( ws.dte_adh < ws.dte_ach_port Or ws.dte_adh < ws.dte_ouvlig_port )  
 )  
And Not Exists ( 
	Select Top 1 1
	From sysadm.det_pro dp,  
	  sysadm.w_sin ws  
	Where ws.id_sin = @adcIdSin  
	And   dp.id_prod = ws.id_prod  
	And   dp.id_code_dp = 20  
	And   dp.val_car in ( 642, -1 ) 
)
 Begin  
	Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Refus machine 642', 'Le refus machine 642 indiquant une date d''achat/Ouv. Ligne, postérieure à la date d''adhésion s''est déclenché. Automatisation impossible.'  
	Return -1      
 End   

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__REFUS_641_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_SURVENANCE_RECHERCHE
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__REFUS_641_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_SURVENANCE_RECHERCHE' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_641_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_SURVENANCE_RECHERCHE
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_641_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_SURVENANCE_RECHERCHE
	@adcIdProdSin		Decimal ( 7 ), -- Code produit sinistre
	@adtDteSurv			DateTime, -- date de survenance
	@adtDteAchat		DateTime, -- date d'achat
	@adtDteOuvLigne		DateTime, -- date ouverture de ligne
	@asChaineSeriaRetourRefus Varchar ( 500 ) OutPut
AS
  
If Exists (   
  Select Top 1 1  
  From sysadm.produit p  
  Where p.id_prod = @adcIdProdSin
  And  p.cod_tel > 0  
  And  ( @adtDteSurv < @adtDteAchat Or @adtDteSurv < @adtDteOuvLigne )  
 )  
And Not Exists ( 
	Select Top 1 1
	From sysadm.det_pro dp
	Where dp.id_prod = @adcIdProdSin
	And   dp.id_code_dp = 20  
	And   dp.val_car in ( 641, -1 ) 
)
 Begin  
	Set @asChaineSeriaRetourRefus = sysadm.FN_CLE_VAL_E ( '641', sysadm.FN_CODE_NUM ( 641, '+RE' ), Trim ( @asChaineSeriaRetourRefus ), ';' )
 End   

Go


--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__REFUS_641_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_SURVENANCE
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__REFUS_641_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_SURVENANCE' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_641_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_SURVENANCE
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_641_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_SURVENANCE
	@adcIdSin   Decimal (10)
AS
  
If Exists (   
  Select Top 1 1  
  From sysadm.w_sin ws,  
    sysadm.produit p  
  Where ws.id_sin = @adcIdSin  
  And  p.id_prod = ws.id_prod  
  And  p.cod_tel > 0  
  And  ( ws.dte_surv < ws.dte_ach_port Or ws.dte_surv < ws.dte_ouvlig_port )  
 )  
And Not Exists ( 
	Select Top 1 1
	From sysadm.det_pro dp,  
	  sysadm.w_sin ws  
	Where ws.id_sin = @adcIdSin  
	And   dp.id_prod = ws.id_prod  
	And   dp.id_code_dp = 20  
	And   dp.val_car in ( 641, -1 ) 
)
 Begin  
	  Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Refus machine 641', 'Le refus machine 641 indiquant une date d''achat/Ouv. Ligne, postérieure à la date de survenance s''est déclenché. Automatisation impossible.'  
	  Return -1      
 End   
  

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__REFUS_613_TERRITORIALITE_NON_COUVERTE_RECHERCHE
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__REFUS_613_TERRITORIALITE_NON_COUVERTE_RECHERCHE' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_613_TERRITORIALITE_NON_COUVERTE_RECHERCHE
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_613_TERRITORIALITE_NON_COUVERTE_RECHERCHE
	@adcIdProdSin		Decimal ( 7 ),
	@adIdTerritSin 		Decimal ( 7 ),
	@adcIdGti			Decimal ( 7 ),
	@asChaineSeriaRetourRefus Varchar ( 500 ) OutPut
AS
  
If Not Exists (   
  Select Top 1 1  
  From sysadm.condition c
  Where c.id_prod = @adcIdProdSin
  And  c.id_gti = @adcIdGti 
  And  c.id_typ_code = '+DT'  
  And  c.id_code = @adIdTerritSin
  And  c.alt_reg = 'O'    
 )  
 Begin  
	Set @asChaineSeriaRetourRefus = sysadm.FN_CLE_VAL_E ( '613', sysadm.FN_CODE_NUM ( 613, '+RE' ), Trim ( @asChaineSeriaRetourRefus ), ';' )	
 End  

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__REFUS_613_TERRITORIALITE_NON_COUVERTE
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__REFUS_613_TERRITORIALITE_NON_COUVERTE' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_613_TERRITORIALITE_NON_COUVERTE
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_613_TERRITORIALITE_NON_COUVERTE
	@adcIdSin   Decimal (10)
AS
  
If Not Exists (   
  Select Top 1 1  
  From sysadm.condition c,  
    sysadm.w_sin ws,  
    sysadm.w_gar_sin wg  
  Where ws.id_sin = @adcIdSin  
  And  wg.id_sin = ws.id_sin  
  And  c.id_prod = ws.id_prod  
  And  c.id_gti = wg.id_gti  
  And  c.id_typ_code = '+TR'  
  And  c.id_code = ws.id_territ  
  And  c.alt_reg = 'O'  
 )  
 Begin  
	  Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Refus machine 613', 'Refus machine 613', 'Le refus machine 613 pour territorialité de sinistre non couverte s''est déclenché. Automatisation impossible.'  
	  Return -1      
 End   
  

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__REFUS_612_DETAIL_DE_SINISTRE_NON_COUVERT_RECHERCHE
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__REFUS_612_DETAIL_DE_SINISTRE_NON_COUVERT_RECHERCHE' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_612_DETAIL_DE_SINISTRE_NON_COUVERT_RECHERCHE
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_612_DETAIL_DE_SINISTRE_NON_COUVERT_RECHERCHE
	@adcIdProdSin		Decimal ( 7 ),
	@adcIdDetSin 		Decimal ( 7 ),
	@adcIdGti			Decimal ( 7 ),
	@asChaineSeriaRetourRefus Varchar ( 500 ) OutPut
AS

If Not Exists (   
  Select Top 1 1  
  From sysadm.condition c
  Where c.id_prod = @adcIdProdSin
  And  c.id_gti = @adcIdGti 
  And  c.id_typ_code = '+DT'  
  And  c.id_code = @adcIdDetSin
  And  c.alt_reg = 'O'    
 )  
 Begin  
	Set @asChaineSeriaRetourRefus = sysadm.FN_CLE_VAL_E ( '612', sysadm.FN_CODE_NUM ( 612, '+RE' ), Trim ( @asChaineSeriaRetourRefus ), ';' )	
 End   

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__REFUS_612_DETAIL_DE_SINISTRE_NON_COUVERT
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__REFUS_612_DETAIL_DE_SINISTRE_NON_COUVERT' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_612_DETAIL_DE_SINISTRE_NON_COUVERT
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_612_DETAIL_DE_SINISTRE_NON_COUVERT
	@adcIdSin   Decimal (10)
AS

If Not Exists (   
  Select Top 1 1  
  From sysadm.condition c,  
    sysadm.w_sin ws,  
    sysadm.w_gar_sin wg  
  Where ws.id_sin = @adcIdSin  
  And  wg.id_sin = ws.id_sin  
  And  c.id_prod = ws.id_prod  
  And  c.id_gti = wg.id_gti  
  And  c.id_typ_code = '+DT'  
  And  c.id_code = ws.id_detsin  
  And  c.alt_reg = 'O'  
 )  
 Begin  
  Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Refus machine 612', 'Le refus machine 612 pour détail de sinistre non couverte s''est déclenché. Automatisation impossible.'  
  Return -1      
 End   

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__REFUS_611_NATURE_DE_SINISTRE_NON_COUVERT_RECHERCHE
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__REFUS_611_NATURE_DE_SINISTRE_NON_COUVERT_RECHERCHE' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_611_NATURE_DE_SINISTRE_NON_COUVERT_RECHERCHE
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_611_NATURE_DE_SINISTRE_NON_COUVERT_RECHERCHE
	@adcIdProdSin		Decimal ( 7 ),
	@adcIdNatSin 		Decimal ( 7 ),
	@adcIdGti			Decimal ( 7 ),
	@asChaineSeriaRetourRefus Varchar ( 500 ) OutPut
AS

Declare @sVarianteDp406 Varchar ( 50 )

If Not Exists (   
  Select Top 1 1  
  From sysadm.condition c
  Where c.id_prod = @adcIdProdSin
  And  c.id_gti = @adcIdGti 
  And  c.id_typ_code = '+NS'  
  And  c.id_code = @adcIdNatSin
  And  c.alt_reg = 'O'  
 )  
 Begin  
	Set @asChaineSeriaRetourRefus = sysadm.FN_CLE_VAL_E ( '611', sysadm.FN_CODE_NUM ( 611, '+RE' ), Trim ( @asChaineSeriaRetourRefus ), ';' )

	  Select @sVarianteDp406 = sysadm.FN_CLE_VAL ( 'VARIANTE', Trim ( dp.val_car ) + Trim ( dp.val_car2 ) , ';')
	  From sysadm.det_pro dp
	  Where dp.id_prod = @adcIdProdSin
	
	  If @sVarianteDp406 = 'BOUYGUES'
		Begin 
			If @adcIdNatSin = 11 
				Begin 
					Set @asChaineSeriaRetourRefus = sysadm.FN_CLE_VAL_E ( '1713', sysadm.FN_CODE_NUM ( 1713, '+RE' ), Trim ( @asChaineSeriaRetourRefus ), ';' )
				End 

			If @adcIdNatSin = 28 
				Begin 
					Set @asChaineSeriaRetourRefus = sysadm.FN_CLE_VAL_E ( '1132', sysadm.FN_CODE_NUM ( 1132, '+RE' ), Trim ( @asChaineSeriaRetourRefus ), ';' )
				End 
		End 
 End  

GO


--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__REFUS_611_NATURE_DE_SINISTRE_NON_COUVERT
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__REFUS_611_NATURE_DE_SINISTRE_NON_COUVERT' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_611_NATURE_DE_SINISTRE_NON_COUVERT
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_611_NATURE_DE_SINISTRE_NON_COUVERT
	@adcIdSin   Decimal (10)
AS

Declare @sMsgSimpa2 Varchar ( 35 ) 
Declare @sMsgSherpa Varchar ( 500 ) 
Declare @sVarianteDp406 Varchar ( 50 )
Declare @iIdNatsin Integer

If Not Exists (   
  Select Top 1 1  
  From sysadm.condition c,  
    sysadm.w_sin ws,  
    sysadm.w_gar_sin wg  
  Where ws.id_sin = @adcIdSin  
  And  wg.id_sin = ws.id_sin  
  And  c.id_prod = ws.id_prod  
  And  c.id_gti = wg.id_gti  
  And  c.id_typ_code = '+NS'  
  And  c.id_code = ws.id_natsin  
  And  c.alt_reg = 'O'  
 )  
 Begin  
	  Set @sMsgSimpa2 = 'Refus machine 611'
	  Set @sMsgSherpa = 'Le refus machine 611 pour nature de sinistre non couverte s''est déclenché. Automatisation impossible.'

	  Select @sVarianteDp406 = sysadm.FN_CLE_VAL ( 'VARIANTE', Trim ( dp.val_car ) + Trim ( dp.val_car2 ) , ';'),
			 @iIdNatsin = ws.id_natsin
	  From sysadm.det_pro dp,
		   sysadm.w_sin ws
	  Where ws.id_sin = @adcIdSin  
	  And dp.id_prod = ws.id_prod
	
	  If @sVarianteDp406 = 'BOUYGUES'
		Begin 
			If @iIdNatsin = 11 
				Begin 
					Set @sMsgSimpa2 = 'Refus machine 611 et 1713'
					Set @sMsgSherpa = 'Les refus machine 611 et 1713 pour nature de sinistre non couverte se sont déclenchés. Automatisation impossible.'
				End 

			If @iIdNatsin = 28 
				Begin 
					Set @sMsgSimpa2 = 'Refus machine 611 et 1132'
					Set @sMsgSherpa = 'Les refus machine 611 et 1132 pour nature de sinistre non couverte se sont déclenchés. Automatisation impossible.'
				End 
		End 

	  Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, @sMsgSimpa2, @sMsgSherpa  
	  Return -1      
 End  

GO

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__REFUS_603_PRIMES_NON_PERCUES_RECHERCHE
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__REFUS_603_PRIMES_NON_PERCUES_RECHERCHE' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_603_PRIMES_NON_PERCUES_RECHERCHE
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_603_PRIMES_NON_PERCUES_RECHERCHE
	@adcIdProdSin		Decimal ( 7 ),
	@adtDteFinGti		DateTime,
	@adtDteResil		DateTime,
	@adtDteSurv			DateTime,
	@asChaineSeriaRetourRefus Varchar ( 500 ) OutPut
AS
  
  
If @adtDteFinGti is not null And   
 @adtDteSurv is not null And  
 @adtDteResil is null  
 Begin  
  If @adtDteFinGti < @adtDteSurv   
   Begin  
		Set @asChaineSeriaRetourRefus = sysadm.FN_CLE_VAL_E ( '603', sysadm.FN_CODE_NUM ( 603, '+RE' ), Trim ( @asChaineSeriaRetourRefus ), ';' )
   End   
 End  

GO


--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__REFUS_603_PRIMES_NON_PERCUES
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__REFUS_603_PRIMES_NON_PERCUES' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_603_PRIMES_NON_PERCUES
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_603_PRIMES_NON_PERCUES
	@adcIdSin   Decimal (10)
AS
Declare @dtDteFinGti DateTime  
Declare @dtDteResil DateTime  
Declare @dtDteSurv DateTime  
  
Select @dtDteFinGti = dte_fin_gti From sysadm.w_sin Where id_sin = @adcIdSin  
Select @dtDteResil = dte_resil From sysadm.w_sin Where id_sin = @adcIdSin  
Select @dtDteSurv = dte_surv From sysadm.w_sin Where id_sin = @adcIdSin  
  
If @dtDteFinGti is not null And   
 @dtDteSurv is not null And  
 @dtDteResil is null  
 Begin  
  If @dtDteFinGti < @dtDteSurv   
   Begin  
    Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Refus machine 603', 'Le refus machine 603 pour prime d''adhésion non perçues s''est déclenché. Automatisation impossible.'  
    Return -1      
   End   
 End  

GO

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__REFUS_602_ADH_NON_SOUSCRITE_A_DATE_SINISTRE_RECHERCHE
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__REFUS_602_ADHESION_NON_SOUSCRITE_A_DATE_SINISTRE_RECHERCHE' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_602_ADHESION_NON_SOUSCRITE_A_DATE_SINISTRE_RECHERCHE
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_602_ADHESION_NON_SOUSCRITE_A_DATE_SINISTRE_RECHERCHE
	@adcIdProdSin		Decimal ( 7 ),
	@adtDteAdh			DateTime,
	@adtDteSurv			DateTime,
	@asChaineSeriaRetourRefus Varchar ( 500 ) OutPut
AS

  
If Not Exists (   
 Select Top 1 1   
 From sysadm.produit p 
 where p.id_prod = @adcIdProdSin
 And   p.cod_adh in ( 3 )  
   )  
 Begin   
 
  If @adtDteAdh > @adtDteSurv   
   Begin  
		Set @asChaineSeriaRetourRefus = sysadm.FN_CLE_VAL_E ( '602', sysadm.FN_CODE_NUM ( 602, '+RE' ), Trim ( @asChaineSeriaRetourRefus ), ';' )
   End  
 End  

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__REFUS_602_ADH_NON_SOUSCRITE_A_DATE_SINISTRE
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__REFUS_602_ADHESION_NON_SOUSCRITE_A_DATE_SINISTRE' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_602_ADHESION_NON_SOUSCRITE_A_DATE_SINISTRE
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_602_ADHESION_NON_SOUSCRITE_A_DATE_SINISTRE
	@adcIdSin   Decimal (10)
AS

Declare @dtDteAdh DateTime  
Declare @dtDteSurv DateTime  
  
If Not Exists (   
 Select Top 1 1   
 From sysadm.produit p ,  
      sysadm.w_sin s   
 where s.id_sin = @adcIdSin  
 And   p.id_prod = s.id_prod  
 And   p.cod_adh in ( 3 )  
   )  
 Begin   
  Select @dtDteAdh = dte_adh From sysadm.w_sin Where id_sin = @adcIdSin  
  Select @dtDteSurv = dte_surv From sysadm.w_sin Where id_sin = @adcIdSin  
  
  
  If @dtDteAdh > @dtDteSurv   
   Begin  
    Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Refus machine 602', 'Le refus machine 602 pour adhésion non souscrite à date sinistre s''est déclenché impossible.'  
    Return -1      
   End  
 End  

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__REFUS_601_ADHESION_RESILIEE_RECHERCHE
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__REFUS_601_ADHESION_RESILIEE_RECHERCHE' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_601_ADHESION_RESILIEE_RECHERCHE
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_601_ADHESION_RESILIEE_RECHERCHE
	@adcIdProdSin		Decimal ( 7 ),
	@adtDteFinGti		DateTime,
	@adtDteResil		DateTime,
	@adtDteSurv			DateTime,
	@asChaineSeriaRetourRefus Varchar ( 500 ) OutPut
AS

  
If @adtDteFinGti is not null And   
 @adtDteResil is not null And  
 @adtDteSurv is not null   
 Begin  
  If @adtDteFinGti < @adtDteSurv  
   Begin  
		Set @asChaineSeriaRetourRefus = sysadm.FN_CLE_VAL_E ( '601', sysadm.FN_CODE_NUM ( 601, '+RE' ), Trim ( @asChaineSeriaRetourRefus ), ';' )
   End   
 End  

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__REFUS_601_ADHESION_RESILIEE
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__REFUS_601_ADHESION_RESILIEE' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_601_ADHESION_RESILIEE
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_601_ADHESION_RESILIEE
	@adcIdSin   Decimal (10)
AS

Declare @dtDteFinGti DateTime  
Declare @dtDteResil DateTime  
Declare @dtDteSurv DateTime  
  
Select @dtDteFinGti = dte_fin_gti From sysadm.w_sin Where id_sin = @adcIdSin  
Select @dtDteResil = dte_resil From sysadm.w_sin Where id_sin = @adcIdSin  
Select @dtDteSurv = dte_surv From sysadm.w_sin Where id_sin = @adcIdSin  
  
If @dtDteFinGti is not null And   
 @dtDteResil is not null And  
 @dtDteSurv is not null   
 Begin  
  If @dtDteFinGti < @dtDteSurv  
   Begin  
    Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Refus machine 601', 'Le refus machine 601 pour adhésion résiliée s''est déclenché. Automatisation impossible.'  

    Return -1      
   End   
 End  

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__REFUS_REVISION_RECHERCHE
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__REFUS_REVISION_RECHERCHE' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_REVISION_RECHERCHE
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_REVISION_RECHERCHE
	@adcIdProdSin	Decimal ( 7 ),
	@adtDteAdh		DateTime, 
	@adtDteSurv		DateTime, 
	@asChaineSeriaRetourRefus Varchar ( 500 ) OutPut

AS
Declare @sRev     VarChar ( 10 )

Set @sRev = Space ( 10 )

Exec sysadm.PS_X_CALC_REVISION @adcIdProdSin, @adtDteSurv, @adtDteAdh, @sRev OUTPUT

If	@sRev is null Or @sRev = '-1'
	Begin
		Set @asChaineSeriaRetourRefus = sysadm.FN_CLE_VAL_E ( '1945', sysadm.FN_CODE_NUM ( 1945, '+RE' ), Trim ( @asChaineSeriaRetourRefus ), ';' )
	End

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__REFUS_REVISION
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__REFUS_REVISION' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_REVISION
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_REVISION
	@adcIdSin   Decimal (10)
AS

Declare @dtDteAdh DateTime
Declare @dtDteSurv DateTime
Declare @dcIdProd Decimal ( 7 )
Declare @sRev     VarChar ( 10 )

Select @dtDteSurv = dte_surv,
	   @dtDteAdh = dte_adh,
	   @dcIdProd = id_prod
From   sysadm.w_sin Where id_sin = @adcIdSin

Set @sRev = Space ( 10 )

Exec sysadm.PS_X_CALC_REVISION @dcIdProd, @dtDteSurv, @dtDteAdh, @sRev OUTPUT

If	@sRev is null Or @sRev = '-1'
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Avenant/Révision non déterminé', 'Le système n''a pas pu déterminer d''avenant (de révision) sur ce dossier. Automatisation impossible.'
		Return -1				
	End
Else
	Begin
		Update sysadm.w_sin Set id_rev = Convert ( Decimal ( 7 ), @sRev ) Where id_sin = @adcIdSin
	End

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__COCHAGE_DES_PIECES
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__COCHAGE_DES_PIECES' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__COCHAGE_DES_PIECES
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__COCHAGE_DES_PIECES
	@adcIdSin Decimal ( 10 )
AS

Declare @sValCarDp406 VarChar ( 510 )
Declare @sVariante  VarChar ( 50 )
Declare @dcIdGti Decimal ( 7 )
Declare @iRet Integer 

Select	@sValCarDp406 = IsNull ( TRIM ( val_car ), '') + IsNull ( TRIM ( val_car2), '')
From	sysadm.w_sin ws,
		sysadm.det_pro dp
Where	ws.id_sin = @adcIdSin
And		dp.id_prod = ws.id_prod
And		dp.id_code_dp = 406

Set @sVariante = sysadm.FN_CLE_VAL ( 'VARIANTE', @sValCarDp406, ';')

If @sVariante = 'BOUYGUES' 
	Begin 
		-- Pièces 6 réclamée pour le VOL : DECL. DE VOL AUPRES AUTORITES
		Select Top 1 @dcIdGti = wg.id_gti From sysadm.w_sin ws, sysadm.w_gar_sin wg Where ws.id_sin = @adcIdSin and wg.id_sin = ws.id_sin
		If @dcIdGti = 10 
			Begin
				Exec @iRet = sysadm.Atlas_Sinistre_Cocher_Pieces_Unitaire_V102 @adcIdSin, @dcIdGti , null, 6
				If @iRet <= 0 
					Begin
						Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Demande de pièce impossible', 'Le système n''a pas pu cocher la pièce 6 (DECL. DE VOL AUPRES AUTORITES) sur ce dossier. Automatisation impossible.'
						Return -1
					End 
				Else
					Begin
						-- Et Sion on renvoit en gestion quand même
						Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Dossier en demande de pièce(s)', 'Le système a coché la pièce 6 (DECL. DE VOL AUPRES AUTORITES) sur ce dossier. Automatisation impossible.'
						Return -1
					End 
			End 
	End 


Return 1

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__CREATION_DETAIL_DE_GARANTIE
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__CREATION_DETAIL_DE_GARANTIE' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__CREATION_DETAIL_DE_GARANTIE
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__CREATION_DETAIL_DE_GARANTIE
	@adcIdSin Decimal ( 10 ),
	@adcIdGti Decimal ( 7 ) Output,
	@adcIdDetail Decimal ( 7 ) Output
AS

Declare @iRet Integer
Declare @iRefIFR Integer
Declare @dcPrixPublic Decimal ( 11, 2 )
Declare @sMarqAppSin VarChar ( 35 )
Declare @sModlAppSin VarChar ( 35 )
Declare @dcMtValAchat Decimal ( 11, 2 )
Declare @dtDteAchat DateTime


Select Top 1 @adcIdGti = wg.id_gti From sysadm.w_sin ws, sysadm.w_gar_sin wg Where ws.id_sin = @adcIdSin and wg.id_sin = ws.id_sin

-- Création Obtention d'un Id_Detail d'un id_seq
Exec @iRet = sysadm.Atlas_Gar_Sin_Creer_Detail_V102 @adcIdSin, @adcIdGti, 1491, null, 'de votre appareil', 0, @adcIdDetail OutPut
If @iRet < 0 Or Not ( @adcIdDetail >= 0 )
	Begin 
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Impossible de créér détail de gtie', 'Impossible de créer le détail de garantie 1491. Automatisation impossible.'
		Return -1
	End 

-- Obtention données sinistre
Select	@sMarqAppSin = ws.marq_port,
		@sModlAppSin = ws.modl_port,
		@iRefIFR = Case 
						When Exists ( 
							Select Top 1 1
							From sysadm.w_sin ws,
								 sysadm.w_div_sin wds,
								 sysadm.det_pro dp
							Where ws.id_sin = @adcIdSin
							And wds.id_sin = ws.id_sin
							And wds.nom_zone = 'type_app'
							And dp.id_prod = ws.id_prod
							And dp.id_code_dp = 28
							And dp.id_code_car = 'IFR' + trim ( wds.val_car )
						) Then 1
						Else 0
					End 

From sysadm.w_sin ws
Where id_sin = @adcIdSin

-- Obtention valeur IFR si App lié à IFR
if @iRefIFR > 0 
	Begin 
		Exec sysadm.PS_S_SAGA2_INTERRO_IFR_V100 @sMarqAppSin, @sModlAppSin, @dcPrixPublic OutPut
		If @dcPrixPublic <= 0 
			Begin
				Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Impossible de déterm. Val. publique', 'Impossible de détemriner la valeur publique de l''appareil (ref. IFR). Automatisation impossible.'
				Return -1
			End 
	End 
Else 
	Begin
		Begin
			Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Appareil non lié à IFR', 'Pour l''instant, seul les déclarations de sinistre dont l''appareil est à IFR peuvent se faire. Automatisation impossible.'
			Return -1
		End
	End 

If Not Exists ( 
		Select Top 1 1 
		From sysadm.stk_data_hub_automate stk
		Where stk.id_sin = @adcIdSin
		And   stk.id_gti = @adcIdGti
		And   stk.id_depot_s2tohub is null
		And   stk.id_seq is null
	)
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Aucune prestation disponible', 'L''extranet n''a donné aucun lien vers une prestation du HUB PRESTATAIRE. Automatisation impossible.'
		Return -1
	End 

-- Obtention de toutes les données stockées concernant les presta HUB
Select @dcMtValAchat   = IsNull ( stk.mt_val_achat, 0 ),
	   @dtDteAchat	   = stk.dte_achat
From sysadm.stk_data_hub_automate stk
Where stk.id_sin = @adcIdSin
And   stk.id_gti = @adcIdGti
And   stk.id_depot_s2tohub is null
And   stk.id_seq is null

If @dcMtValAchat is null Or @dcMtValAchat <= 0 
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Impossible récupérer valeur d''achat', 'Impossible de récupérer la valeur d''achat qui aurait normale dû être transmise avec les infos de stockage liées de la prestation. Automatisation impossible.'
		Return -1
	End 

If @dtDteAchat is null 
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Date d''achat non renseignée', 'Impossible de récupérer la date d''achat qui aurait normale dû être transmise avec les infos de stockage liées de la prestation. Automatisation impossible.'
		Return -1
	End 

-- Maj date d'achat sur le sinistre
Update sysadm.w_sin Set dte_ach_port = @dtDteAchat Where id_sin = @adcIdSin

-- Maj date achat sur Détail de garantie si dp/42 (A)achat
If Exists ( 
	Select 	Top 1 1 
	From 	sysadm.det_pro dp ,
			sysadm.w_sin ws
	Where 	ws.id_sin = @adcIdSin
	And     dp.id_prod = ws.id_prod
	And 	dp.id_code_dp = 42 
	and 	dp.id_code_car = 'A' 
	and 	dp.id_code_num = @adcIdGti ) 
Begin
	Update sysadm.w_detail Set dte_det = @dtDteAchat Where id_sin = @adcIdSin and id_gti = @adcIdGti
End 

-- On rédéclenche ces 3 plafonds qui sont liés à la Date d'achat

-- Refus 641 : DTE ACHAT/OUVLIG > DTE SURVENANCE
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_641_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_SURVENANCE @adcIdSin
If @iRet = -1 Return @iRet

-- Refus 642 : DTE ACHAT/OUVLIG > DTE ADHESION
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_642_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_ADHESION @adcIdSin
If @iRet = -1 Return @iRet

-- Refus 643 : DTE ACHAT/OUVLIG < DTE ADHESION (sur option dp/131)
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_643_DATE_ACHAT_OU_OUVLIG_ANTERIEURE_DTE_ADHESION_DP131 @adcIdSin
If @iRet = -1 Return @iRet

-- Mise à jour du détail avec les dernières valeurs
Update sysadm.w_detail
Set		mt_val_achat= @dcMtValAchat,
		mt_val_publique = @dcPrixPublic
Where	id_sin = @adcIdSin
and		id_gti = @adcIdGti
And		id_detail = @adcIdDetail

Return 1

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__DECLENCHEMENT_PLAFOND_ET_PEC
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__DECLENCHEMENT_PLAFOND_ET_PEC' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__DECLENCHEMENT_PLAFOND_ET_PEC
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__DECLENCHEMENT_PLAFOND_ET_PEC
	@adcIdSin Decimal ( 10 ),
	@adcIdGti Decimal ( 7 ),
	@adcIdDetail Decimal ( 7 )
AS

Declare @iRet Integer
Declare @iIdSeq Integer
Declare @dcIdRefPlaf decimal (7 )
Declare @sIdTypPlaf Integer
Declare @dcMtPlaf decimal ( 11,2 )
Declare @dcIdProd Decimal (7)
Declare @dcIdEts Decimal (7)
Declare @sIdAdh VarChar ( 19 )
Declare @sNumPort VarChar ( 25 ) 
Declare @dtDteSurv Datetime
Declare @dtDteRenouv DateTime
Declare @iNbAutreSin Integer
Declare @iSinEnCours Integer
Declare @dcIdEvt Decimal ( 7 )
Declare @dcMtPec Decimal ( 11, 2 )
Declare @dcMtValAchat Decimal ( 11, 2 )
Declare @dcMtValPublique Decimal ( 11, 2 )

DECLARE @tb TABLE 
	( id_seq		integer identity,
	  id_ref_plaf	decimal (7 ),
	  id_typ_plaf	integer,
	  mt_plaf		decimal ( 11,2 ),
	  marquage		integer null 
	)

-- Stockage des plafonds
Insert into @tb
Select	p.id_ref_plaf,
		p.id_typ_plaf,
		p.mt_plaf,
		0
				
From	sysadm.plafond p,
		sysadm.w_sin ws,
		sysadm.w_detail wd
where	ws.id_sin = @adcIdSin
and		p.id_prod = ws.id_prod 
and		p.id_rev  = ws.id_rev
And		wd.id_sin = ws.id_sin
and		p.id_gti = wd.id_gti 
and		( p.id_ref_plaf = wd.id_evt or id_niv_plaf = '-GA' ) 

-- Stockage de données 
Select  @dcIdProd = ws.id_prod,
		@dcIdEts = ws.id_ets,
		@sIdAdh = rtrim ( ws.id_adh ),
		@sNumPort = rtrim ( ws.num_port ) ,
		@dtDteSurv = dte_surv,
		@dcIdEvt = wd.id_evt,
		@dcMtValAchat = wd.mt_val_achat,
		@dcMtValPublique = wd.mt_val_publique
From	sysadm.w_sin ws,
		sysadm.w_detail wd
Where	ws.id_sin = @adcIdSin
And		wd.id_sin = ws.id_sin 
And		wd.id_gti = @adcIdGti
And		wd.id_detail = @adcIdDetail

Set @sNumPort = Replace ( rtrim ( @sNumPort ), ' ', '' )
Set @dtDteRenouv = sysadm.FN_DTE_RNV ( @adcIdSin )
Set @dcMtPec = @dcMtValAchat

While Exists ( Select Top 1 1 From @tb where marquage = 0 )
	Begin
		Select 	Top 1 
			@iIdSeq = id_seq,
			@dcIdRefPlaf = id_ref_plaf,
			@sIdTypPlaf = id_typ_plaf,
			@dcMtPlaf = mt_plaf
		From	@tb
		Where	marquage = 0

		-- Plafond de garantie
		If @dcIdRefPlaf = -1
			Begin
				-- Plafond 752
				If @sIdTypPlaf = 752 
					Begin
						Set @iNbAutreSin = 0
						Exec sysadm.PS_S_W_GTI_NBSIN_NUM_PORT_ANN_ADH 
							@adcIdSin, 
							@dcIdProd,
							@dcIdEts,
							@sIdAdh,
							@sNumPort,
							@dtDteSurv,
							@dtDteRenouv,
							@iNbAutreSin OutPut

						Set @iSinEnCours = 1
						If @iNbAutreSin is null Set @iNbAutreSin = 0

						If @iSinEnCours + @iNbAutreSin > @dcMtPlaf
							Begin
								Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Refus machine 1483', 'Le refus machine 1483 (Plafond 752) s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
								Return -1				
							End 		
					End 
					-- /Plafond 752

			End 
			-- /Plafond de garantie

		-- Plafond d'évènement (détail de garantie)
		If @dcIdRefPlaf <> -1
			Begin
				-- Plafond 680
				If @sIdTypPlaf = 680 And @dcIdRefPlaf = @dcIdEvt 
					Begin
						If @dcMtPec > @dcMtPlaf Set @dcMtPec = @dcMtPlaf
					End 
				-- /Plafond 680

				-- Plafond 671
				If @sIdTypPlaf = 671 And @dcIdRefPlaf = @dcIdEvt 
					Begin
						If @dcMtPec > @dcMtValAchat Set @dcMtPec = @dcMtValAchat
					End 
				-- /Plafond 671

				-- Plafond 675
				If @sIdTypPlaf = 675 And @dcIdRefPlaf = @dcIdEvt 
					Begin
						If @dcMtPec > @dcMtValPublique Set @dcMtPec = @dcMtValPublique
					End 
				-- /Plafond 675

			End 
			-- /Plafond d'évènement (détail de garantie)

		Update @tb Set marquage = 1	Where id_seq = @iIdSeq
	End

-- Ecriture mt_pec (et autres données onglets Divers détail).
Insert into sysadm.w_div_det
Select 
	wd.id_sin,
	wd.id_gti,
	wd.id_detail,
	ap.nom_zone,
	ap.lib_label,
	ap.id_typ_liste,
	ap.alt_liste_codecar,
	ap.id_typ_zone,
	ap.alt_oblig,
	ap.alt_prot,
	ap.cpt_tri,
	ap.val_nbre,
	Case ap.nom_zone 
		When 'mt_pec' Then @dcMtPec
		Else ap.val_mt
	End,
	Case ap.nom_zone 
		When 'dte_pec' Then Convert ( VarChar ( 10 ) , Getdate(), 103 )
		Else ap.val_dte
	End,
	ap.val_car,
	ap.cpt_valide,
	Getdate(),
	Getdate(),
	'WEB'
From sysadm.pm234_7_automate_pec ap,
		sysadm.w_detail wd
Where wd.id_sin = @adcIdSin
And	  wd.id_gti = @adcIdGti
And	  wd.id_detail = @adcIdDetail 
And   ap.id_sin = 5612096 -- modèle
And   ap.id_gti = 11 -- modèle
And   ap.id_detail = 0 -- modèle
And   ap.nom_zone in ( 'alt_plaf_pec', 'dte_pec', 'mt_pec', 'pec' )                                 

If @dcMtPec <= 0 
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Montant de prise en charge à 0€', 'Le montant de prise en charge est à 0€. Automatisation impossible.'
		Return -1
	End 

Return 1

Go


--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__CREATION_DE_LA_PRESTATION
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__CREATION_DE_LA_PRESTATION' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__CREATION_DE_LA_PRESTATION
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__CREATION_DE_LA_PRESTATION
	@adcIdSin Decimal ( 10 ),
	@adcIdGti Decimal ( 7 ),
	@adcIdDetail Decimal ( 7 ),
	@aiIdSeqPresta Integer OutPut
AS

DECLARE
    @dcIdSin decimal(10,0),
    @sIdFour char(3),
    @sIdTypArt char(3),
    @sIdMarqArt char(35),
    @sIdModlArt char(35),
    @dcMtTtcCmde decimal(11,2),
    @sAdrNom char(35),
    @sAdrPrenom char(35),
    @sAdrLivr1 char(35),
    @sAdrLivr2 char(35),
    @sAdrLivrCpl char(35),
    @sAdrCp char(5),
    @sAdrVille char(35),
    @sAdrTel1 char(20),
    @sAdrTel2 char(20),
    @sAdrTel3 char(20),
    @sAdrMail char(50),
    @dtDteRdvCli datetime,
    @sHrdvCliMin char(4),
    @sHrdvCliMax char(4),
    @sIdSerieAnc varchar(60),
    @sProbleme char(255),
    @sIdCmdFrn char(20),
    @sIdSerieNouv varchar(60),
    @sIdBonTransp char(35),
    @dtDteRcpFrn datetime,
    @dtDteEnvCli datetime,
    @sCodEtat char(3),
    @sCommentFrn char(255),
    @iCptValide int,
    @sNomGest char(40),
    @dtCreeLe datetime,
    @dtMajLe datetime,
    @sMajPar char(4),
    @sIdZone char(1),
    @iIdBsp int,
    @dtDteRetPret datetime,
    @sAdrCodCiv char(1),
    @sIdRefFour char(20),
    @iIdOrianMarque int,
    @iIdOrianModele int,
    @dtDteElvMobile datetime,
    @iStatusGc int,
    @dtDteEmisDevis datetime,
    @dcMtDevis decimal(11,2),
    @sAltDevAcp char(1),
    @dtDteDevAcp datetime,
    @sAdrfcCodCiv char(1),
    @sAdrfcNom char(35),
    @sAdrfcPrenom char(35),
    @sAdrfcLivr1 char(35),
    @sAdrfcLivr2 char(35),
    @sAdrfcLivrCpl char(35),
    @sAdrfcCp char(5),
    @sAdrfcVille char(35),
    @dtDteRetLogis datetime,
    @dtDteRetPretMin datetime,
    @dtDteRetPretMax datetime,
    @iIdAnn int,
    @dtDteEnvBteFrn datetime,
    @dtDteRcpBteCli datetime,
    @dtDteDepBteCli datetime,
    @dtDteEnvSt datetime,
    @dtDteRcpMobCli datetime,
    @iInfoSpbFrn int,
    @sIdMarqArtIfr varchar(35),
    @sIdModlArtIfr varchar(35),
    @sInfoSpbFrnCplt char(800),
    @sInfoFrnSpbCplt char(800)

Declare @iRet Integer
Declare @dcMtValAchat Decimal ( 11, 2 )
Declare @idSeqStkPresta Integer
Declare @sErrText VarChar ( 255 )

Select  @idSeqStkPresta = stk.id_stk
From sysadm.stk_data_hub_automate stk
Where stk.id_sin = @adcIdSin
And   stk.id_gti = @adcIdGti
And   stk.id_depot_s2tohub is null
And   stk.id_seq is null

If @idSeqStkPresta is null Or @idSeqStkPresta <= 0 
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Aucune prestation disponible', 'L''extranet n''a donné aucun lien vers une prestation du HUB PRESTATAIRE. Automatisation impossible.'
		Return -1
	End 

-- Obtention des données stockées liées à la prestation HUB pré-créée
Select	@sIdFour = stk.id_four,
		@sIdTypArt = Case stk.ordre_action
						When 'A_REPARER' Then 'PRS'
						When 'A_DIAGNOSTIQUER' Then 'EDI'
						-- When 'A_COMMANDER' Then stk.typ_app_sin
						Else '???'
					 End,
		@sIdMarqArt = Case stk.ordre_action
						When 'A_REPARER' Then stk.marq_app_sin
						When 'A_DIAGNOSTIQUER' Then 'APPAREIL A DIAGNOSTIQUER'
						-- When 'A_COMMANDER' Then 
						Else '???'
					 End,
		@sIdModlArt = Case stk.ordre_action
						When 'A_REPARER' Then stk.modl_app_sin
						When 'A_DIAGNOSTIQUER' Then ''
						-- When 'A_COMMANDER' Then 
						Else '???'
					 End,
		@dcMtTtcCmde = 0,
		@sAdrNom = stk.nom_livr,
		@sAdrPrenom = stk.prenom_livr,
		@sAdrLivr1 = stk.adr1_livr,
		@sAdrLivr2 = stk.adr2_livr,
		@sAdrLivrCpl = stk.adr3_livr,
		@sAdrCp = stk.adr_cp_livr,
		@sAdrVille = stk.adr_ville_livr,
		@sAdrTel1 = stk.num_tel1_livr,
		@sAdrTel2 = null,
		@sAdrTel3 = null,
		@sAdrMail = ( Select wi.adr_mail From sysadm.w_inter wi Where wi.id_sin = @adcIdSin and cod_inter = 'A' ),
		@dtDteRdvCli = null,
		@sHrdvCliMin = null,
		@sHrdvCliMax = null,
		@sIdSerieAnc =  Case	
							When stk.num_imei_app_sin is not null 
								Then stk.num_imei_app_sin
							Else stk.num_serie_app_sin
						End,
		@sProbleme = stk.description_probleme,
		@sIdCmdFrn = null,
		@sIdSerieNouv = null,
		@sIdBonTransp = null,
		@dtDteRcpFrn = null,
		@dtDteEnvCli = null,
		@sCodEtat = 'CNV',
		@sCommentFrn = null,
		@iCptValide = 0,
		@sNomGest = 'AUTOMATE EXTRANET',
		@dtCreeLe = GETDATE(),
		@dtMajLe = GETDATE(),
		@sMajPar = 'WEB',
		@sIdZone = null,
		@iIdBsp = null,
		@dtDteRetPret = null,
		@sAdrCodCiv = Convert ( VarChar ( 2 ), cod_civ_livr ),
		@sIdRefFour = stk.ordre_action,
		@iIdOrianMarque = 0,
		@iIdOrianModele = 2,
		@dtDteElvMobile = null,
		@iStatusGc = 0,
		@dtDteEmisDevis = null,
		@dcMtDevis = 0,
		@sAltDevAcp = 'N',
		@dtDteDevAcp = null,
		@sAdrfcCodCiv = 1,
		@sAdrfcNom = null,
		@sAdrfcPrenom = 'X',
		@sAdrfcLivr1  = 'X',
		@sAdrfcLivr2  = 'X',
		@sAdrfcLivrCpl = null,
		@sAdrfcCp = '00000',
		@sAdrfcVille = 'X',
		@dtDteRetLogis = null,
		@dtDteRetPretMin = null,
		@dtDteRetPretMax = null,
		@iIdAnn = 0,
		@dtDteEnvBteFrn = null,
		@dtDteRcpBteCli = null,
		@dtDteDepBteCli = null,
		@dtDteEnvSt = null,
		@dtDteRcpMobCli = null,
		@iInfoSpbFrn =  Case 
							When Not ( process_acheminement is null Or TRIM ( process_acheminement  ) = '' )
								Then 3510
							Else 3520
						End,
-- Select info_spb_frn_cplt from sysadm.commande where id_four = 'ITA' and id_ref_four = 'A_REPARER' 
-- Reprendre [ICI] avec les oublie dans PB, CODE_VERROU et autres.
		@sInfoSpbFrnCplt =	sysadm.FN_CLE_VAL_E ( 'CODE_VERROU', isnull ( stk.code_verrou, '' ),
							sysadm.FN_CLE_VAL_E ( 'HP_RDV_DIAG_VIDEO', IIF ( stk.mode_logis in ( 'AT_HOME', 'REMOTELY' ), 'OUI', 'NON' ),
							sysadm.FN_CLE_VAL_E ( 'HP_ID_ACTION', isnull ( stk.ordre_action, '' ),
							sysadm.FN_CLE_VAL_E ( 'ADRVILLE_PICK_UP', isnull ( stk.adr_ville_pickup, '' ),
							sysadm.FN_CLE_VAL_E ( 'ADRCP_PICK_UP', isnull ( stk.adr_cp_pickup, '' ),
							sysadm.FN_CLE_VAL_E ( 'ADR3_PICK_UP', isnull ( stk.adr3_pickup, '' ),
							sysadm.FN_CLE_VAL_E ( 'ADR2_PICK_UP', isnull ( stk.adr2_pickup, ''),
							sysadm.FN_CLE_VAL_E ( 'ADR1_PICK_UP', isnull ( stk.adr1_pickup, ''),
							sysadm.FN_CLE_VAL_E ( 'REFASS_PICK_UP', isnull ( stk.ref_ass_pickup, ''),
							sysadm.FN_CLE_VAL_E ( 'NOM_PICK_UP', isnull ( stk.nom_pickup, ''), 
							sysadm.FN_CLE_VAL_E ( 'CODE_PICK_UP', isnull ( stk.code_pickup, ''), 
							sysadm.FN_CLE_VAL_E ( 'HP_ID_PROCESS_ACHEM', isnull ( stk.process_acheminement, ''), 
							sysadm.FN_CLE_VAL_E ( 'HP_INFO_SPB_FRN', Convert ( Varchar ( 50 ), isnull ( @iInfoSpbFrn, 0 )), 
							sysadm.FN_CLE_VAL_E ( 'HP_ID_MODE_LOGIS', isnull ( stk.mode_logis, ''),
							sysadm.FN_CLE_VAL_E ( 'HP_ID_POINT_SERV', isnull ( stk.point_service, ''), 
							sysadm.FN_CLE_VAL_E ( 'HP_TYP_DOM', isnull ( stk.typ_dommage, ''),
							sysadm.FN_CLE_VAL_E ( 'HP_ID_FOUR', isnull ( stk.id_four, ''), 
							sysadm.FN_CLE_VAL_E ( 'HP_ID_HUB_PRESTA', isnull ( stk.id_hub_presta, '') , '', ';' )
							, ';' ), ';' ), ';' ), ';' ), ';' ), ';' ), ';' ), ';' ), ';' ), ';' ), ';' ), ';' ), ';' ), ';' ), ';' ), ';' ), ';' )

		, @sInfoFrnSpbCplt = null

From sysadm.stk_data_hub_automate stk
Where stk.id_stk = @idSeqStkPresta


Select	Top 1 
		@sIdMarqArtIfr = i.marque,
		@sIdModlArtIfr = i.reference  
From sysadm.w_sin ws,
	 sysadm.w_div_sin wds,
	 sysadm.det_pro dp,
	 sysadm.ifr i
Where ws.id_sin = @adcIdSin
And   i.marque = ws.marq_port
And   i.reference = ws.modl_port
And wds.id_sin = ws.id_sin
And wds.nom_zone = 'type_app'
And dp.id_prod = ws.id_prod
And dp.id_code_dp = 28
And dp.id_code_car = 'IFR' + trim ( wds.val_car )

-- On renseigne à présent la chaine sérialisé.
-- @sInfoSpbFrnCplt,

-- Obtention d'un id_seq
Set @aiIdSeqPresta = IsNull ( ( Select MAX ( id_seq ) From sysadm.w_commande where id_sin = @adcIdSin ), 0 ) + 1

----------------------------------------------------------
-- Pris en charge du détail, déclenchement des plafonds --
----------------------------------------------------------
-- Voir PS_I_PM234_7_PLAFOND_PEC

-------------------------------------------
-- Création de la prestation dans SIMPA2 -- 
-------------------------------------------
INSERT INTO sysadm.w_commande (
	id_sin,
	id_seq,
	id_gti,
	id_detail,
	id_four,
	id_typ_art,
	id_marq_art,
	id_modl_art,
	mt_ttc_cmde,
	adr_nom,
	adr_prenom,
	adr_livr1,
	adr_livr2,
	adr_livr_cpl,
	adr_cp,
	adr_ville,
	adr_tel1,
	adr_tel2,
	adr_tel3,
	adr_mail,
	dte_rdv_cli,
	hrdv_cli_min,
	hrdv_cli_max,
	id_serie_anc,
	probleme,
	id_cmd_frn,
	id_serie_nouv,
	id_bon_transp,
	dte_rcp_frn,
	dte_env_cli,
	cod_etat,
	comment_frn,
	cpt_valide,
	nom_gest,
	cree_le,
	maj_le,
	maj_par,
	id_zone,
	id_bsp,
	dte_ret_pret,
	adr_cod_civ,
	id_ref_four,
	id_orian_marque,
	id_orian_modele,
	dte_elv_mobile,
	status_gc,
	dte_emis_devis,
	mt_devis,
	alt_dev_acp,
	dte_dev_acp,
	adrfc_cod_civ,
	adrfc_nom,
	adrfc_prenom,
	adrfc_livr1,
	adrfc_livr2,
	adrfc_livr_cpl,
	adrfc_cp,
	adrfc_ville,
	dte_ret_logis,
	dte_ret_pret_min,
	dte_ret_pret_max,
	id_ann,
	dte_env_bte_frn,
	dte_rcp_bte_cli,
	dte_dep_bte_cli,
	dte_env_st,
	dte_rcp_mob_cli,
	info_spb_frn,
	id_marq_art_ifr,
	id_modl_art_ifr,
	info_spb_frn_cplt,
	info_frn_spb_cplt
)
VALUES (
	@adcIdSin,
	@aiIdSeqPresta,
	@adcIdGti,
	@adcIdDetail,
	@sIdFour,
	@sIdTypArt,
	@sIdMarqArt,
	@sIdModlArt,
	@dcMtTtcCmde,
	@sAdrNom,
	@sAdrPrenom,
	@sAdrLivr1,
	@sAdrLivr2,
	@sAdrLivrCpl,
	@sAdrCp,
	@sAdrVille,
	@sAdrTel1,
	@sAdrTel2,
	@sAdrTel3,
	@sAdrMail,
	@dtDteRdvCli,
	@sHrdvCliMin,
	@sHrdvCliMax,
	@sIdSerieAnc,
	@sProbleme,
	@sIdCmdFrn,
	@sIdSerieNouv,
	@sIdBonTransp,
	@dtDteRcpFrn,
	@dtDteEnvCli,
	@sCodEtat,
	@sCommentFrn,
	@iCptValide,
	@sNomGest,
	@dtCreeLe,
	@dtMajLe,
	@sMajPar,
	@sIdZone,
	@iIdBsp,
	@dtDteRetPret,
	@sAdrCodCiv,
	@sIdRefFour,
	@iIdOrianMarque,
	@iIdOrianModele,
	@dtDteElvMobile,
	@iStatusGc,
	@dtDteEmisDevis,
	@dcMtDevis,
	@sAltDevAcp,
	@dtDteDevAcp,
	@sAdrfcCodCiv,
	@sAdrfcNom,
	@sAdrfcPrenom,
	@sAdrfcLivr1,
	@sAdrfcLivr2,
	@sAdrfcLivrCpl,
	@sAdrfcCp,
	@sAdrfcVille,
	@dtDteRetLogis,
	@dtDteRetPretMin,
	@dtDteRetPretMax,
	@iIdAnn,
	@dtDteEnvBteFrn,
	@dtDteRcpBteCli,
	@dtDteDepBteCli,
	@dtDteEnvSt,
	@dtDteRcpMobCli,
	@iInfoSpbFrn,
	@sIdMarqArtIfr,
	@sIdModlArtIfr,
	@sInfoSpbFrnCplt,
	@sInfoFrnSpbCplt
)

If @@ROWCOUNT <> 1
	Begin
		Set @sErrText = '(1) L''automatisation n''a pas créé la prestation suite à une problème technique (' + IsNull ( Convert ( varchar (100 ), @@error), 'erreur non décodable') + '. Automatisation impossible.'
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Problème technique prestation', @sErrText 
		Return -1
	End 

Update sysadm.stk_data_hub_automate Set id_seq = @aiIdSeqPresta Where id_stk = @idSeqStkPresta

If @@ROWCOUNT <> 1
	Begin
		Set @sErrText = '(2) L''automatisation n''a pas créé la prestation suite à une problème technique (' + IsNull ( Convert ( varchar (100 ), @@error), 'erreur non décodable') + '. Automatisation impossible.'
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Problème technique prestation', @sErrText 
		Return -1
	End 

Else Return 1
Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__VALIDATION_DU_DOSSIER
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__VALIDATION_DU_DOSSIER' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__VALIDATION_DU_DOSSIER
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__VALIDATION_DU_DOSSIER
	@adcIdSin Decimal ( 10 ),
	@adcIdGti Decimal ( 7 ),
	@adcIdDetail Decimal ( 7 ),
	@aiIdSeqPresta Integer 
AS

Declare @iCodeEtat Integer 
Declare @dcIdCorb Decimal ( 3 )
Declare @dtCreeLeDos DateTime
Declare @dDteRecu Datetime
Declare @dDteFinGti Datetime
Declare @sErr varchar(60)
Declare @iIdCt Integer
Declare @sCodOper       Varchar (  4   )
Declare @sNoBoite       Varchar ( 10   )
Declare @sProc          Varchar ( 60   )
Declare @dtValideLe     DateTime        
Declare @sMethode	VarChar ( 3 )  
Declare @iRet Integer
Declare @sMsgTemp VarChar ( 500 ) 
Declare @iCtrle Integer
Declare @sMsgSucces VarChar ( 35)

Set @iCodeEtat = 100

-- Détermination des codes états.
Update sysadm.w_detail
Set cod_dec_mac = @iCodeEtat, 
	cod_dec_ope = @iCodeEtat, 
	cod_etat = @iCodeEtat, 
	alt_att = 'O',
	maj_le = getdate(),
	maj_par = 'WEB'
Where id_sin = 	@adcIdSin
And   id_gti =  @adcIdGti

Update sysadm.w_gar_sin 
Set cod_dec_mac = sysadm.FN_GET_ETAT_GARANTIE_PM251 ( @adcIdSin , @adcIdGti, 'W') 
Where id_sin = 	@adcIdSin
And   id_gti =  @adcIdGti

Update sysadm.w_gar_sin
set	cod_dec_ope = cod_dec_mac,
	cod_etat = cod_dec_mac,
	maj_le = getdate(),
	maj_par = 'WEB'
Where  id_sin = @adcIdSin
And    id_gti = @adcIdGti

Update sysadm.w_sin
Set	cod_dec_mac = sysadm.FN_GET_ETAT_DOSSIER_PM251 ( @adcIdSin, 'W' )
Where  id_sin = @adcIdSin

Update sysadm.w_sin
Set	cod_dec_ope = cod_dec_mac,
	cod_etat = cod_dec_mac,
	maj_le = getdate(),
	maj_par = 'WEB'
Where  id_sin = @adcIdSin	

If Not Exists ( 
		Select Top 1 1 
		From sysadm.routage r
		Where r.id_sin = @adcIdSin
	)
	Begin
		Select @dcIdCorb = p.id_corb,
				@dtCreeLeDos = ws.cree_le
		From   sysadm.w_sin ws,
				sysadm.produit p
		Where  ws.id_sin = @adcIdSin
		And    p.id_prod = ws.id_prod

		Insert into sysadm.routage values  ( @adcIdSin, 'N', @dcIdCorb, 'X', 'DEC', 'N', @dtCreeLeDos , @dtCreeLeDos , 'WEB', null, null, null, null,null )
	End 


--  Obligé de recreer un travail avant de validation, sinon problème technique

Select  @dDteRecu=getdate(),
		@dDteFinGti=s.dte_fin_gti
From sysadm.w_sin s
Where s.id_sin = @adcIdSin

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	exec SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V03
				@adcIdSin
				,2
				,''
				,'WEB'
				,@sErr OUTPUT
				,@iIdCt OUTPUT
				,@dDteFinGti
				,'C'
				,@dDteRecu
				,0
END
ELSE
BEGIN
	exec SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V03
				@adcIdSin
				,2
				,''
				,'WEB'
				,@sErr OUTPUT
				,@iIdCt OUTPUT
				,@dDteFinGti
				,'C'
				,@dDteRecu
				,0
END

-- [LGY38] pour ne pas que le CCO ramasse le travail
Update sysadm.w_queue Set etat_iwd = 99 Where id_sin = @adcIdSin

-- Le travail doit être occupé pour valider !!
Update w_queue set alt_occupe = 'O' where id_sin = @adcIdSin

--  Validation du dossier
Set @sCodOper = 'WEB'
Set @sNoBoite = ''
Set @sProc = Space ( 35 )
Set @dtValideLe = getdate()
set @sMethode = 'SVE'


Exec @iRet = sysadm.PS_VALIDATION
		@adcIdSin,
		@sCodOper,
		@sNoBoite,
		@sProc OUTPUT,
		@dtValideLe OUTPUT,
		@sMethode

If @iRet < 0 
	Begin
		Set @sMsgTemp = 'Problème lors de la validation automatique suite à la déclaration par l''extranet, code (' + Convert ( VarChar ( 10 ), @iRet ) + '). Automatisation impossible.'
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Problème validation automatisation', @sMsgTemp 
		Return -1				
	End 

Delete sysadm.w_queue Where id_sin = @adcIdSin
Update sysadm.routage Set alt_queue = 'N', cod_travail = 'CPL' Where id_sin = @adcIdSin

-- Finalisation validation
Exec sysadm.PS_I_DIV_SIN_ETAT_ASS @adcIdSin, 'WEB'

-- Contrôle Post validation ICI
Exec @iCtrle = sysadm.PS_I_PM234_7_CTRL_APRES_VALIDATION @adcIdSin

If @iCtrle < 0 
	Begin
		Set @sMsgTemp = 'Problème lors de la validation automatique, (nbre lignes/cpt_valide). Automatisation impossible.'
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Problème validation auto 2', @sMsgTemp 
		Return -1
	End 

-- Validation de la presta vers le HUB
Insert into sysadm.en_attente_transfert_vers_hp ( id_cas, id_sin, id_seq, id_hub_presta, id_four, typ_dommage, point_service, mode_logis, code_pickup, nom_pickup, ref_ass_pickup, adr1_pickup, adr2_pickup, adr3_pickup, adr_cp_pickup, adr_ville_pickup, code_process, lib_code_process, id_gti, lib_perso_gti, id_detail, id_prod, lib_prod, id_prod_adh, id_ets, id_adh, id_sdos, id_typ_art, cod_civ_livr, lib_civ_livr_court, lib_civ_livr_long, id_contrat_abonne, nom_ass, prenom_ass, nom_livr, prenom_livr, adr1_livr, adr2_livr, adr3_livr, adr_cp_livr, adr_ville_livr, num_tel1_ass, num_tel2_ass, num_tel3_ass, mail_assure, num_imei_app_sin, num_serie_app_sin, description_probleme, cod_etat, valide_le, valide_par, cmd_gen_le, id_ref_four, ordre_action, id_assureur, lib_assureur, lib_police, typ_app_sin, lib_typ_app_sin, marq_app_sin, modl_app_sin, ref_app_sin, num_tel_sin, mt_val_achat, mt_prise_en_charge, date_achat, etat_app_sin, code_verrou, desimlocke, info_spb_frn_cplt )
exec sysadm.PS_HP276_S_S2_OBTENTION_DONNEES_PRESTA_SIMPA2_POUR_PREPARATION_CREATION_HUB_PRESTATAIRE_SUR_TABLE_W 2, @adcIdSin, @aiIdSeqPresta

If @@ROWCOUNT <> 1
	Begin
		Set @sMsgTemp = 'Problème lors de la validation automatique de la prestation HUB. Automatisation impossible.'
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Problème validation prestation', @sMsgTemp 
		Return -1
	End 

Set @sMsgSucces = 'Succès automatisation déclaration'
Set @sMsgTemp = 'Automatisation de la déclaration réussie, la prestation est créée avec le HUB et le dossier est validé.'

Exec sysadm.PS_I_DIV_SIN_SANS_DIV_PRO
	@adcIdSin,
	'extrauto_succes_decl', 
	'Succès Automatis. Décla. Extranet',  
	@sMsgSucces,
	'O',
	'C',
	null,
	'WEB'

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @adcIdSin, 2, @sMsgTemp,	'WEB', 300, @iIdCt OUTPUT							
END
ELSE
BEGIN
	Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @adcIdSin, 2, @sMsgTemp,	'WEB', 300, @iIdCt OUTPUT							
END	

-- Journal pour l'extranet
Exec sysadm.PS_I_CAS_JOURNAL_EVT_SIN_SUR_VALIDATION @adcIdSin, 'WEB'

Return 1

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_EXTRANET_AUTOMATISATION__RECHERCHE_REFUS_AVANT_DECLENCHEMENT
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
-- Libellé              :
-- Commentaires         :       
-- Références           :
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_EXTRANET_AUTOMATISATION__RECHERCHE_REFUS_AVANT_DECLENCHEMENT' AND type = 'P' )
        DROP procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__RECHERCHE_REFUS_AVANT_DECLENCHEMENT
GO

CREATE procedure sysadm.PS_I_EXTRANET_AUTOMATISATION__RECHERCHE_REFUS_AVANT_DECLENCHEMENT
	@adcIdProdSin		Decimal ( 7 ), -- Code produit sinistre
	@adtDteAdh			DateTime, -- date d'adhésion
	@adtDteSurv			DateTime, -- date de survenance
	@adtDteAchat		DateTime, -- date d'achat
	@adtDteOuvLigne		DateTime, -- date ouverture de ligne
	@adtDteFinGti		DateTime, -- date de fin de garantie (date jusqu'à laquelle l'assuré est couvert en fonction du paiement de ses primes adhésion)
	@adtDteResil		DateTime, -- date de résilisation de l'adhésion ( le cas échéant )
	@adcIdGti			Decimal ( 7 ), -- code garantie
	@adIdTerritSin		Decimal ( 7 ), -- code territorialité
	@adcIdNatSin 		Decimal ( 7 ), -- code nature de sinistre
	@adcIdDetSin		Decimal ( 7 ), -- code détail sinistre
	@asChaineSeriaArgSuppl VarChar ( 255 ), -- Si besoin un jour
	@asChaineSeriaRetourRefus Varchar ( 500 ) OutPut, -- ex : 611=NATURE DE SINISTRE NON COUVERT;1713=DISPARITIONS PERTES OUBLIS;603=PRIMES NON PERCUES
	@asMessRetour VarChar ( 255 ) 
AS

-- 1 Arguments exploitable, retour @asChaineSeriaRetourRefus valide 
-- < 0 Arguments inexploitable, retour @asChaineSeriaRetourRefus non valide 

IF @adcIdProdSin is null or @adcIdProdSin <=0 Begin Set @asMessRetour = 'Code produit sinistre obligatoire' ; Return -10 End 
If Exists ( Select Top 1 1 From sysadm.produit p where p.id_prod = @adcIdProdSin and cod_adh <> 3 ) and @adtDteAdh is null Begin Set @asMessRetour = 'Date d''adhésion obligatoire selon la méthode d''adhésion paramétré sur ce produit' ; Return -20 End 
If @adtDteSurv is null Return -30 Begin Set @asMessRetour = 'Date de survenance obligatoire' ; Return -30 End 
If Exists ( Select Top 1 1 From sysadm.produit p where p.id_prod = @adcIdProdSin and cod_adh not in ( 3, 6 ) ) and @adtDteFinGti is null Begin Set @asMessRetour = 'Date de fin de garantie obligatoire selon la méthode d''adhésion paramétré sur ce produit' ; Return -40 End 
If @adcIdGti is null Or Not Exists ( Select Top 1 1 From sysadm.code_garantie cg Where cg.id_prod = @adcIdProdSin and cg.id_gti = @adcIdGti ) Begin Set @asMessRetour = 'Code garantie obligatoire et doit être paramétré sur produit ' + Convert ( Varchar ( 50 ), @adcIdProdSin) ; Return -50 End 
If @adIdTerritSin is null Or Not Exists ( Select Top 1 1 From sysadm.code_condition cc Where cc.id_prod = @adcIdProdSin and cc.id_typ_code = '+TR' and cc.id_code = @adIdTerritSin ) Begin Set @asMessRetour = 'Code territorialité obligatoire et doit être paramétré sur produit ' + Convert ( Varchar ( 50 ), @adcIdProdSin) ; Return -60 End 
If @adcIdNatSin is null Or Not Exists ( Select Top 1 1 From sysadm.code_condition cc Where cc.id_prod = @adcIdProdSin and cc.id_typ_code = '+NS' and cc.id_code = @adcIdNatSin ) Begin Set @asMessRetour = 'Code nature de sinistre obligatoire et doit être paramétré sur produit ' + Convert ( Varchar ( 50 ), @adcIdProdSin) ; Return -70 End 
If @adcIdDetSin is null Or Not Exists ( Select Top 1 1 From sysadm.code_condition cc Where cc.id_prod = @adcIdProdSin and cc.id_typ_code = '+DT' and cc.id_code = @adcIdDetSin ) Begin Set @asMessRetour = 'Code détails de sinistre obligatoire et doit être paramétré sur produit ' + Convert ( Varchar ( 50 ), @adcIdProdSin) ; Return -80 End 

Set @asChaineSeriaRetourRefus = ''

Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_REVISION_RECHERCHE @adcIdProdSin, @adtDteAdh, @adtDteSurv, @asChaineSeriaRetourRefus OutPut
Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_601_ADHESION_RESILIEE_RECHERCHE @adcIdProdSin, @adtDteFinGti, @adtDteResil, @adtDteSurv, @asChaineSeriaRetourRefus OutPut
Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_602_ADHESION_NON_SOUSCRITE_A_DATE_SINISTRE_RECHERCHE  @adcIdProdSin, @adtDteAdh, @adtDteSurv, @asChaineSeriaRetourRefus OutPut
Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_603_PRIMES_NON_PERCUES_RECHERCHE @adcIdProdSin, @adtDteFinGti, @adtDteResil, @adtDteSurv, @asChaineSeriaRetourRefus OutPut
Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_611_NATURE_DE_SINISTRE_NON_COUVERT_RECHERCHE @adcIdProdSin, @adcIdNatSin, @adcIdGti, @asChaineSeriaRetourRefus OutPut
Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_612_DETAIL_DE_SINISTRE_NON_COUVERT_RECHERCHE @adcIdProdSin, @adcIdDetSin, @adcIdGti, @asChaineSeriaRetourRefus OutPut
Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_613_TERRITORIALITE_NON_COUVERTE_RECHERCHE @adcIdProdSin, @adIdTerritSin, @adcIdGti, @asChaineSeriaRetourRefus OutPut
Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_641_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_SURVENANCE_RECHERCHE @adcIdProdSin, @adtDteSurv, @adtDteAchat, @adtDteOuvLigne, @asChaineSeriaRetourRefus OutPut
Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_642_DATE_ACHAT_OU_OUVLIG_POSTERIEURE_DTE_ADHESION_RECHERCHE @adcIdProdSin, @adtDteAdh, @adtDteAchat, @adtDteOuvLigne, @asChaineSeriaRetourRefus OutPut
Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REFUS_643_DATE_ACHAT_OU_OUVLIG_ANTERIEURE_DTE_ADHESION_DP131_RECHERCHE @adcIdProdSin, @adtDteAdh, @adtDteAchat, @adtDteOuvLigne, @asChaineSeriaRetourRefus OutPut

Return 1

Go

