-------------------------------------------------------------------
--
-- Fichier              :       EXTRANET_AUTOMATISATION.CP
-- Auteur               :       Fabry JF
-- Date                 :       16/09/2025
--
-- Commentaires         :       PS afférants à l'automatisation des déclaration SHERPA/SIMPA2 en liant avec un extranet
--
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


Set @sMsgSherpa = Left ( 'ERREUR / Rejet Automatisation : ' + @asMsg2Sherpa, 508 )

Exec sysadm.PS_I_DIV_SIN_SANS_DIV_PRO
        @adcIdSin,
        'extrauto_rejet_decl', 
		'Rejet Automatis. Décla. Extranet',  
        @asMsgSimpa2,
		'O',
		'C',
		null,
        'WEB'

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
		If @sOper = 'WEB'
		EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @adcIdSin, 2, @sMsgSherpa, @sOper , @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'E'
	END
	ELSE
	BEGIN
		If @sOper = 'WEB'
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
	@asNumSerieAppSin VarChar ( 20 ),
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

		Exec @iRet = sysadm.PS_S_CODE_DANS_FAMILLE_CAR  1, asIdFour 
		If @iRet <= 0 
			Begin 
				Set @asMessRet = 'le Code fournisseur SIMPA2 (code fournisseur officiel SPB) n''est pas valide, ce n''est pas CODE fournisseur officiel SPB ou bien il n''a aucun lien avec SIMPA2'
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
			Where id_typ_code = '-IN'
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

Insert into sysadm.stk_data_hub_automate ( 
       [id_sin]
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

-- [LGY38] afin que le CCO ne ramasse un éventuel travail présent
-- Même si DELETE ensuite, le Trv pourrait être affecté au CCO, donc le pus tôt possible il faut couper
Update sysadm.w_queue Set etat_iwd = 99 Where id_sin = @adcIdSin

-- Contrôle éligibilité dossier à l'automatisme
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__CONTROLE_ELIGIBILITE_DOSSIER @adcIdSin
If @iRet = -1 Return @iRet

-- Contrôle intégrité dossier
Exec @iRet = sysadm.PS_I_EXTRANET_AUTOMATISATION__CONTROLE_INTEGRITE_DOSSIER @adcIdSin
If @iRet = -1 Return @iRet

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
		And		wdsGeolocAtlas.nom_zone = 'geoloc_atlas'
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

-- absence ligne dans w_sin
If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Le sinistre n''existe pas', 'La référence sinistre n''existe pas. La référence transmise à l''automate par l''extranet ne réfère aucun sinistre dans la base de données SIMPA2. Automatisation impossible.'
		Return -1
	End		

-- absence de nature de sinistre (id_natsin)
If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And id_natsin is not null And id_natsin <> 0 )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Nature de sinistre non renseignée', 'La nature de sinistre n''a pas été renseignée par l''extranet. Automatisation impossible.'
		Return -1
	End	

-- absence de territorialité de sinistre (id_territ)
If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And id_territ is not null And id_territ <> 0 )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Territorialité non renseignée', 'La territorialité n''a pas été renseignée par l''extranet. Automatisation impossible.'
		Return -1
	End	

-- absence de détail de sinistre (id_detsin)
If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And id_detsin is not null And id_detsin <> 0 )
	Begin
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'Détail de sinistre non renseigné', 'Le détail de sinistre n''a pas été renseigné par l''extranet. Automatisation impossible.'
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
		Exec sysadm.PS_I_EXTRANET_AUTOMATISATION__REJET_VERS_DGRC @adcIdSin, 'ETS non paramétré ', 'L''établissement adhésion transmis pas l''extranet n''existe pour ce produit. Automatisation impossible.'
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
	And dp.id_code_car = 'IFR' + trim ( dp.val_car )
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
If Not Exists ( Select Top 1 1 From sysadm.w_inter wi, sysadm.code c Where wi.id_sin = @adcIdSin And wi.cod_inter = 'A' And c.id_typ_code = '-IN' and c.id_code = Convert ( decimal (7), wi.cod_civ ) )
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
Set @sAdrMailInterAss = sysadm.FN_EPURE_CHAINE_V02 ( @sAdrMailInterAss ) 
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


Return 1

Go