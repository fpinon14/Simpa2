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
	@asTypDommage VarChar ( 100 ),
	@asOrdreAction VarChar ( 20 ),
	@asPointService VarChar ( 40 ),
	@asModeLogis VarChar ( 40 ),
	@asCodePickup VarChar ( 20 ),
	@asNomPickup VarChar ( 40 ),
	@asAdr1Pickup VarChar ( 40 ),
	@asAdr2Pickup VarChar ( 40 ),
	@asAdr3Pickup VarChar ( 40 ),
	@asAdrCpPickup VarChar ( 40 ),
	@asAdrVillePickup VarChar ( 40 ),
	@asProcessAcheminement VarChar ( 100 ),
	@asChaineSeria VarChar ( 1000 ),
	@asMessRet VarChar ( 255 ) OutPut
AS

--------------------------
-- Contrôle des données --
--------------------------
--	@asRefAssPickup VarChar ( 40 ), Je le ferai moi-même

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

Set @asIdHubPresta = UPPER ( Trim ( @asIdHubPresta ))
If LEN ( @asIdHubPresta ) < 10 
	Begin
		Set @asMessRet = 'IdHubPresta (idBenefit) non valide (VarChar ( 20 ))'
		Return -30
	End 

Set @asTypDommage = UPPER ( Trim ( @asTypDommage ))
If @asTypDommage is not null 
	Begin 
		If LEFT ( @asTypDommage, 1 ) <> '#' OR Right ( @asTypDommage, 1 ) <> '#' 
			Begin 
				Set @asMessRet = 'Type Dommage non valide, s''il est non null, ce doit être une chaine de concaténée (VarChar ( 100 )) séparées par un #, et il doit y avoir un # en début et fin de chaine, exemple : #BROKEN_SCREEN#DEVICE_BROKEN#REAR_BROKEN# ou #OXIDATION# etc...'
				Return -40
			End 
	End 

Set @asOrdreAction = UPPER ( Trim ( @asOrdreAction ))
If @asOrdreAction is null Or @asOrdreAction = ''
	Begin
		Set @asMessRet = 'L''ordre d''action doit être renseigné (VarChar ( 20 )), exemple : A_DIAGNOSTIQUER ou A_REPARER ou A_COMMANDER'
		Return -90
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
				Set @asMessRet = 'Un code de relais PickUp doit avoir un longueur de 5 caractères alpha-numérique, exemple : 8624S ou 3600Y ou 950AL etc...'
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
				Set @asMessRet = 'L''adresse du relais PickUp doit être renseignée (@asAdr1Pickup VarChar ( 40 ) obligatoire, @asAdr2Pickup et @asAdr3Pickup facultative)'
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

Set @asProcessAcheminement = UPPER ( Trim ( @asProcessAcheminement ))
If @asProcessAcheminement is null 
	Begin 
		Set @asMessRet = 'Le process d''acheminement est obligatoire (VarChar (100)) et en l''absence de process d''acheminement, passez AUCUN. Sinon en exemple de process : PICK_UP_POINT ou POST_OFFICE ou PICK_UP_TRANSPORTATION etc...'
		Return -130
	End 

--------------------------
-- Traitement			--
--------------------------






Set @asMessRet = 'Stockage des informations liées à la prestation effectué avec succès sur SIMPA2' 
Return 1

Go

