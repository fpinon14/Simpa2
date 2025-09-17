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

If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin ) 
	Begin
		Set @asMessRet = 'Le sinistre n''existe pas'
		Return -10
	End 

If Not Exists ( Select Top 1 1 From sysadm.w_gar_sin Where id_sin = @adcIdSin and id_gti = @adcIdGti ) 
	Begin
		Set @asMessRet = 'La garantie n''existe pas sur le sinistre'
		Return -20
	End 

Set @asIdHubPresta = UPPER ( Trim ( @asIdHubPresta ) )
If @asIdHubPresta is null Or @asIdHubPresta = ''
	Begin
		Set @asMessRet = 'L''identifiant de la prestation doit être renseigné (VarChar ( 10 ))'
		Return -370
	End 

If Len ( @asIdHubPresta ) <> 10 Or @asIdHubPresta <> UPPER ( @asIdHubPresta )
	Begin
		Set @asMessRet = 'L''identifiant de la prestation n''est pas valide )'
		Return -380
	End 


Set @asIdFour = UPPER ( Trim ( @asIdFour ))
If @asIdFour is null Or @asIdFour = ''
	Begin
		Set @asMessRet = 'le Code fournisseur SIMPA2 (code fournisseur officiel SPB) doit être renseigné (VarChar ( 3 )), voir avec le HUB qui a une table PRESTATAIRE.edi.ProviderSimpa2 pour la correspondance des codes'
		Return -140
	End 

If LEN ( @asIdFour ) > 0 
	Begin

		Exec @iRet = sysadm.PS_S_CODE_DANS_FAMILLE_CAR  1, asIdFour 
		If @iRet <= 0 
			Begin 
				Set @asMessRet = 'le Code fournisseur SIMPA2 (code fournisseur officiel SPB) n''est pas valide, ce n''est pas CODE fournisseur officiel SPB ou bien il n''a aucun lien avec SIMPA2'
				Return -150
			End 
	End 

Set @asPointService = UPPER ( Trim ( @asPointService ))
If @asPointService is null Or @asPointService = ''
	Begin
		Set @asMessRet = 'Le point de service doit être renseigné (VarChar ( 40 )), exemple : SPAREKA_AT_HOME ou SAVE_REUNION ou ITANCIA ou SPAREKA_REMOTELY etc...'
		Return -50
	End 


Set @asTypDommage = UPPER ( Trim ( @asTypDommage ))
If @asTypDommage is not null 
	Begin 
		If LEFT ( @asTypDommage, 1 ) <> '#' OR Right ( @asTypDommage, 1 ) <> '#' 
			Begin 
				Set @asMessRet = 'Type Dommage non valide, s''il est non null, ce doit être une chaine concaténée (VarChar ( 100 )) séparées par un #, et il doit y avoir un # en début et fin de chaine, exemple : #BROKEN_SCREEN#DEVICE_BROKEN#REAR_BROKEN# ou #OXIDATION# etc...'
				Return -40
			End 
	End 

Set @asOrdreAction = UPPER ( Trim ( @asOrdreAction ))
If @asOrdreAction is null Or @asOrdreAction = ''
	Begin
		Set @asMessRet = 'L''ordre d''action doit être renseigné (VarChar ( 20 )), exemple : A_DIAGNOSTIQUER ou A_REPARER ou A_COMMANDER'
		Return -90
	End 

Set @asTypAppSin = UPPER ( Trim ( @asTypAppSin ))
If @asTypAppSin is null Or @asTypAppSin = ''
	Begin
		Set @asMessRet = 'Le type de l''appareil doit être renseigné (VarChar ( 3 )) en code SIMPA2, exemple : TEL ou TPC ou MCS, etc....'
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
			Return -165
		End 
	End 

Set @asMarqAppSin = UPPER ( Trim ( @asMarqAppSin ))
If @asMarqAppSin is null Or @asMarqAppSin = ''
	Begin
		Set @asMessRet = 'La marque de l''appareil doit être renseigné (VarChar ( 35 ))'
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
			Return -185
		End 

	End 

Set @asModlAppSin = UPPER ( Trim ( @asModlAppSin ))
If @asModlAppSin is null Or @asModlAppSin = ''
	Begin
		Set @asMessRet = 'La modèle de l''appareil doit être renseigné (VarChar ( 35 ))'
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
			Return -200
		End 
	End 

Set @asNumImeiAppSin = UPPER ( Trim ( @asNumImeiAppSin ))
If ( @asNumImeiAppSin is null Or @asNumImeiAppSin = '' ) And @asTypAppSin = 'TEL'
	Begin
		Set @asMessRet = 'Le numéro d''IMEI doit être renseigné (VarChar ( 20 )) pour un type d''appareil ' + @asTypAppSin 
		Return -320
	End 

If  @asNumImeiAppSin is Not null And @asNumImeiAppSin <> '' And @asTypAppSin = 'TEL'
	Begin
		IF sysadm.FN_CORR_IMEI ( @asNumImeiAppSin, GETDATE() ) <> @asNumImeiAppSin
		Begin 
			Set @asMessRet = 'Le numéro d''IMEI n''est pas valide'
			Return -330
		End 
	End 

Set @asNumSerieAppSin = UPPER ( Trim ( @asNumSerieAppSin ))
If ( @asNumSerieAppSin is null Or @asNumSerieAppSin = '' ) And @asTypAppSin <> 'TEL'
	Begin
		Set @asMessRet = 'Le numéro de série doit être renseigné (VarChar ( 20 ))' 
		Return -340
	End 

Set @asDescriptionProbleme = UPPER ( Trim ( @asDescriptionProbleme  ))
If ( @asDescriptionProbleme is null Or @asDescriptionProbleme = '' ) 
	Begin
		Set @asMessRet = 'La description du problème doit être renseignée (VarChar ( 255 ))' 
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
		Return -220
	End 

If ( @adtDateAchat is null ) 
	Begin
		Set @asMessRet = 'La date date d''achat doit être renseigné (DateTime)'
		Return -230
	End 

Set @asEtatAppSin = UPPER ( Trim ( @asEtatAppSin ))
If @asEtatAppSin is not null And @asEtatAppSin <> ''
Begin
	If @asEtatAppSin Not in ( 'ANEU', 'AREC' ) 
		Begin
			Set @asMessRet = 'Si l''état de l''appareil est connu et obligatoire pour ce contrat, dans ce cas seules 2 valeurs sont acceptées : ANEU pour << Acheté Neuf>> ou AREC pour << Acheté reconditionné >> (Varchar (20))'
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
			Return -250
		End 
End 


Set @asPointService = UPPER ( Trim ( @asPointService ))
If @asPointService is null Or @asPointService = ''
	Begin
		Set @asMessRet = 'Le point de service doit être renseigné (VarChar ( 40 )), exemple : SPAREKA_AT_HOME ou SAVE_REUNION ou ITANCIA ou SPAREKA_REMOTELY etc...'
		Return -50
	End 

Set @asModeLogis = UPPER ( Trim ( @asModeLogis ))
If @asModeLogis is null Or @asModeLogis = ''
	Begin
		Set @asMessRet = 'Le mode logistique doit être renseigné (VarChar ( 40 )), exemple : PROXIMITY ou AT_HOME ou REMOTELY ou CENTRALIZATION etc...'
		Return -60
	End 

Set @asCodePickup = UPPER ( Trim ( @asCodePickup ))
IF @asCodePickup is not null 
	Begin
		If len ( @asCodePickup ) <> 5
			Begin
				Set @asMessRet = 'Un code de relais PickUp doit avoir une longueur de 5 caractères alpha-numérique, exemple : 8624S ou 3600Y ou 950AL etc...'
				Return -70
			End 

		Set @asNomPickup = Trim ( @asNomPickup )
		IF @asNomPickup is null Or @asNomPickup = ''
			Begin
				Set @asMessRet = 'Le nom du relais PickUp doit être renseigné (VarChar ( 40 ))'
				Return -80
			End 

		Set @asAdr1Pickup = Trim ( @asAdr1Pickup )
		IF @asAdr1Pickup is null Or @asAdr1Pickup = ''
			Begin
				Set @asMessRet = 'L''adresse du relais PickUp doit être renseignée (@asAdr1Pickup VarChar ( 40 ) elle est obligatoire, mais @asAdr2Pickup et @asAdr3Pickup sont facultatives)'
				Return -100
			End 
		
		Set @asAdrCpPickup = Trim ( @asAdrCpPickup )
		IF @asAdrCpPickup is null Or @asAdrCpPickup = '' Or LEN ( @asAdrCpPickup ) <> 5 
			Begin
				Set @asMessRet = 'Le code postal du relais PickUp doit être renseigné (VarChar (5))'
				Return -110
			End 

		Set @asAdrVillePickup = Upper ( Trim ( @asAdrVillePickup ))
		IF @asAdrVillePickup is null Or @asAdrVillePickup = '' 
			Begin
				Set @asMessRet = 'La ville du relais PickUp doit être renseignée'
				Return -120
			End 

	End 

If @aiCodCivLivr is null Or @aiCodCivLivr <= 0
	Begin
		Set @asMessRet = 'Interlocuteur lié à la prestation : code civilité (en code SIMPA2) obligatoire (1=Monsieur, 2=Madame, 4=Madame, Monsieur, 5=Société)'
		Return -260

		If Not Exists ( 
			Select Top 1 1 
			From sysadm.code_car
			Where id_typ_code = '-IN'
			And   id_code = CONVERT ( Varchar (2), @aiCodCivLivr ) 
		)
		Begin
			Set @asMessRet = 'Interlocuteur lié à la prestation : code civilité non valide (1=Monsieur, 2=Madame, 4=Madame, Monsieur, 5=Société)'
			Return -270
		End 
	End 

Set @asNomLivr = UPPER ( Trim ( @asNomLivr ))
If @asNomLivr is null Or @asNomLivr = ''
	Begin
		Set @asMessRet = 'Interlocuteur lié à la prestation : Le nom de l''interlocuteur doit être renseigné (varchar (35 ))'
		Return -280
	End 

Set @asPrenomLivr = UPPER ( Trim ( @asPrenomLivr ))
If @asPrenomLivr is null Or @asPrenomLivr = ''
	Begin
		Set @asMessRet = 'Interlocuteur lié à la prestation : Le prénom de l''interlocuteur doit être renseigné (varchar (35 ))'
		Return -290
	End 

Set @asAdr1Livr = UPPER ( Trim ( @asAdr1Livr ))
If @asAdr1Livr is null Or @asAdr1Livr = ''
	Begin
		Set @asMessRet = 'Interlocuteur lié à la prestation : La 1ère ligne d''adresse de l''interlocuteur doit être renseignée (varchar (35 ))'
		Return -290
	End 

-- @asAdr2Livr VarChar ( 35 ), pas contrôle
-- @asAdr3Livr VarChar ( 35 ), pas contrôle
-- @asAdrCpLivr VarChar ( 35 ), pas contrôle

Set @asAdrVilleLivr = UPPER ( Trim ( @asAdrVilleLivr ))
If @asAdrVilleLivr is null Or @asAdrVilleLivr = ''
	Begin
		Set @asMessRet = 'Interlocuteur lié à la prestation : La ville de l''adresse de l''interlocuteur doit être renseignée (varchar (35 ))'
		Return -300
	End 

Set @asNumTelLivr = UPPER ( Trim ( @asNumTelLivr ))
If @asNumTelLivr is null Or @asNumTelLivr = ''
	Begin
		Set @asMessRet = 'Interlocuteur lié à la prestation : Le numéro de téléphone où joindre l''interlocuteur doit être renseignée (varchar (35 ))'
		Return -310
	End 

If Left ( @asNumTelLivr, 2 ) not in ( '06', '07' )
	Begin
		Set @asMessRet = 'Interlocuteur lié à la prestation : Le numéro de téléphone où joindre l''interlocuteur doit être numéro de protable 06 ou 07)'
		Return -310
	End 



Set @asProcessAcheminement = UPPER ( Trim ( @asProcessAcheminement ))
If @asProcessAcheminement is null 
	Begin 
		Set @asMessRet = 'Le process d''acheminement est obligatoire (VarChar (100)) et en l''absence de process d''acheminement, passez AUCUN. Sinon en exemple de process : PICK_UP_POINT ou POST_OFFICE ou PICK_UP_TRANSPORTATION etc...'
		Return -130
	End 

--------------------------
-- Traitement			--
--------------------------
Insert into sysadm.stk_data_hub_automate ( 
       [id_sin]
      ,[id_gti]
      ,[id_hub_presta]
	  ,[id_four]
      ,[typ_dommage]
      ,[ordre_action]
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
	@asPointService,
	@asModeLogis,
	@asCodePickup,
	@asNomPickup,
	null,
	@asAdr1Pickup,
	@asAdr2Pickup,
	@asAdr3Pickup,
	@asAdrCpPickup,
	@asAdrVillePickup,
	@asProcessAcheminement,
	null,
	@asChaineSeria,
	GETDATE(),
	GETDATE(),
	'JFF'
)




Set @asMessRet = 'Stockage des informations liées à la prestation effectué avec succès sur SIMPA2' 
Return 1

Go

