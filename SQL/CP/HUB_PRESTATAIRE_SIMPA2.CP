-------------------------------------------------------------------
--
-- Fichier              :       HUB_PRESTATAIRE_SIMPA2.CP
-- Auteur               :       JFF
-- Date                 :       11/03/2024
--
-- Commentaires         :       Gestion des PS SQL 
--
-- Procédures           :       

-------------------------------------------------------------------

-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_S_S2_TYPE_DOMMAGE
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Renvoie vers SIMPA2, à partir du HUB, les type de dommages possibles que propose le HUB selon 5 critères
--                              /!\ A COMPILER SUR LA BASE SIMPA2 /!\
--								Cette est la PS d'appel SIMPA2 qui appel le HUB selon l'environnement
--
-- Retourne             :       rien
-------------------------------------------------------------------
/*
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_S_S2_TYPE_DOMMAGE' AND type = 'P' )
        DROP procedure sysadm.PS_HP276_S_S2_TYPE_DOMMAGE
GO

CREATE procedure sysadm.PS_HP276_S_S2_TYPE_DOMMAGE
	    @aiCas				Tinyint,
		@adcIdProd			decimal (7),
		@adcIdGti			decimal (7),
		@asMarqAppSin		VarChar ( 35 ),
		@asModlAppSin		VarChar ( 35 ),
		@asTypAppSin		VarChar ( 35 )
AS

Declare @iIdProd Integer
Declare @iIdGti Integer

Set @iIdProd = CONVERT ( Integer, @adcIdProd ) 
Set @iIdGti = CONVERT ( Integer, @adcIdGti ) 

Declare @Tb table ( 
	id_code_td_hp VarChar ( 30 ),
	lib_td_hp VarChar ( 30 )
	)


IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	If @aiCas > 0 Set @aiCas = 3
	Exec [LS-SAGA2].[PRESTATAIRE].[edi].PS_HP276_S_HP_TYPE_DOMMAGE @aiCas, @iIdProd, @iIdGti, @asMarqAppSin, @asModlAppSin, @asTypAppSin
END
ELSE
BEGIN
	-- [HP252_276_HUB_PRESTA]
	If @aiCas in ( 2, 3 )
	 Begin
---		Exec [S2SQL14DEV\RECSAGA2].[PRESTATAIRE].[edi].PS_HP276_S_HP_TYPE_DOMMAGE @aiCas, @iIdProd, @iIdGti, @asMarqAppSin, @asModlAppSin, @asTypAppSin
		Exec [S2SQL14PP1\PPRSAGA2].[PRESTATAIRE].[edi].PS_HP276_S_HP_TYPE_DOMMAGE @aiCas, @iIdProd, @iIdGti, @asMarqAppSin, @asModlAppSin, @asTypAppSin
--		Insert into @Tb Exec ( 'Exec [S2SQL14PP1\PPRSAGA2].[PRESTATAIRE].[edi].PS_HP276_S_HP_TYPE_DOMMAGE @aiCas, @iIdProd, @iIdGti, @asMarqAppSin, @asModlAppSin, @asTypAppSin' ) 

		Declare @s varchar ( 200 ) 
--		Set @s = 'Exec [S2SQL14DEV\RECSAGA2].[PRESTATAIRE].[edi].PS_HP276_S_HP_TYPE_DOMMAGE 2, 1, 1, ''1'', ''1'', ''1'''
--		Set @s = 'Begin Tran; Exec [S2SQL14PP1\PPRSAGA2].[PRESTATAIRE].[edi].PS_HP276_S_HP_TYPE_DOMMAGE 2, 1, 1, ''1'', ''1'', ''1''; commit tran'
--		Set @s = 'Select top 5 left( BenefitStatusCode, 30) , Left ( BenefitStatusLabel, 30)  From [S2SQL14PP1\PPRSAGA2].PRESTATAIRE.ref.benefitstatus'
--		Set @s = 'Select top 5 convert (varchar (10), id_sin) , convert (varchar (10), id_seq)   From [S2SQL14DEV\RECSAGA2].PRESTATAIRE.edi.DepotSimpa2ToHubPresta'		
--		Set @s = 'select Left ( benefittypecode, 30), Left( brandcode, 30 ) from [S2SQL14PP1\PPRSAGA2].PRESTATAIRE.[dbo].[SelectBenefitType](''993'', ''SAMSUNG'', '''', null, null, null)'		
--		select Left ( benefittypecode, 30), Left( brandcode, 30 ) from [S2SQL14PP1\PPRSAGA2].PRESTATAIRE.[dbo].[SelectBenefitType]('993', 'SAMSUNG', '', null, null, null)

--		Select @s
--		Insert into @Tb Exec ( @s ) 
--		Select * from @Tb 

	 End
	Else
	-- test SIMPA2
	 Begin
		Exec sysadm.PS_HP276_S_HP_TYPE_DOMMAGE @aiCas, @iIdProd, @iIdGti, @asMarqAppSin, @asModlAppSin, @asTypAppSin
	 End

END 

Go
*/


-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_S_S2_TYPE_ACTION
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Renvoie vers SIMPA2, à partir du HUB, les type d'action possibles que propose le HUB selon 5 critères
--                              /!\ A COMPILER SUR LA BASE SIMPA2 /!\
--								Cette est la PS d'appel SIMPA2 qui appel le HUB selon l'environnement
--
-- Retourne             :       rien
-------------------------------------------------------------------
/*
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_S_S2_TYPE_ACTION' AND type = 'P' )
        DROP procedure sysadm.PS_HP276_S_S2_TYPE_ACTION
GO

CREATE procedure sysadm.PS_HP276_S_S2_TYPE_ACTION
	    @aiCas				Tinyint,
		@adcIdProd			decimal (7),
		@adcIdGti			decimal (7),
		@asMarqAppSin		VarChar ( 35 ),
		@asModlAppSin		VarChar ( 35 ),
		@asTypAppSin		VarChar ( 35 ),
		@asTypDommage		VarChar ( 100 )

AS

Declare @iIdProd Integer
Declare @iIdGti Integer

Set @iIdProd = CONVERT ( Integer, @adcIdProd ) 
Set @iIdGti = CONVERT ( Integer, @adcIdGti ) 

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	If @aiCas > 0 Set @aiCas = 3
	Exec [LS-SAGA2].[PRESTATAIRE].[edi].PS_HP276_S_HP_TYPE_ACTION @aiCas, @iIdProd, @iIdGti, @asMarqAppSin, @asModlAppSin, @asTypAppSin, @asTypDommage
END
ELSE
BEGIN
	If @aiCas >= 2
	 Begin
		Exec [S2SQL14PP1\PPRSAGA2].[PRESTATAIRE].[edi].PS_HP276_S_HP_TYPE_ACTION @aiCas, @iIdProd, @iIdGti, @asMarqAppSin, @asModlAppSin, @asTypAppSin, @asTypDommage
	 End
	Else
	 Begin
		-- test SIMPA2
		Exec sysadm.PS_HP276_S_HP_TYPE_ACTION @aiCas, @iIdProd, @iIdGti, @asMarqAppSin, @asModlAppSin, @asTypAppSin, @asTypDommage
	 End

END 

Go
*/


-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_S_S2_DATA_DOSSIER
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Renvoie vers SIMPA2, à partir du HUB,  les points de services  possibles que propose le HUB selon "n" critères
--                              /!\ A COMPILER SUR LA BASE SIMPA2 /!\
--								Cette est la PS d'appel SIMPA2 qui appel le HUB selon l'environnement
--
-- Retourne             :       rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_S_S2_DATA_DOSSIER' AND type = 'P' )
        DROP procedure sysadm.PS_HP276_S_S2_DATA_DOSSIER
GO

CREATE procedure sysadm.PS_HP276_S_S2_DATA_DOSSIER
		@adcIdSin				Decimal ( 10 ),
		@asIdAdh				VarChar ( 50 ) OutPut,
		@aiIdGrpContractant		Integer OutPut,
		@asLibGrpContractant	VarChar ( 35 ) OutPut

AS

Select	@asIdAdh =	Convert ( Varchar ( 20 ), pr.cod_prod_dms ) + '-' +
					Convert ( Varchar ( 20 ), ws.id_ets) + '-' +
					ltrim ( rtrim ( ws.id_adh )) + '-' +
					Convert ( Varchar ( 20 ), ws.id_sdos) + '-',
		@aiIdGrpContractant = gr.id_grp,
		@asLibGrpContractant = ltrim ( rtrim ( gr.lib_grp ))
From	sysadm.w_sin ws,
	    sysadm.produit pr,
		sysadm.groupe gr
Where   ws.id_sin = @adcIdSin
And     pr.id_prod = ws.id_prod
And     gr.id_grp = pr.id_grp

Set @asIdAdh = LTRIM ( rTrim ( @asIdAdh ))
If  @asIdAdh = '' Set @asIdAdh = null

Go


-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_S_S2_POINT_DE_SERVICE
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Renvoie vers SIMPA2, à partir du HUB,  les points de services  possibles que propose le HUB selon "n" critères
--                              /!\ A COMPILER SUR LA BASE SIMPA2 /!\
--								Cette est la PS d'appel SIMPA2 qui appel le HUB selon l'environnement
--
-- Retourne             :       rien
-------------------------------------------------------------------
/*
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_S_S2_POINT_DE_SERVICE' AND type = 'P' )
        DROP procedure sysadm.PS_HP276_S_S2_POINT_DE_SERVICE
GO

CREATE procedure sysadm.PS_HP276_S_S2_POINT_DE_SERVICE
	    @aiCas				Tinyint,
		@adcIdProd			Decimal ( 7 ),
		@adcIdGti			Decimal ( 7 ),
		@asMarqAppSin		VarChar ( 35 ),
		@asModlAppSin		VarChar ( 35 ),
		@asTypAppSin		VarChar ( 35 ),
		@asTypDommage		VarChar ( 100 ),
		@asTypPrestation    VarChar ( 20 ),
		@adcIdSin			Decimal ( 10 ),
		@aiCiv				Decimal ( 2 ),
		@asNom				VarChar ( 35 ),
		@asPrenom			VarChar ( 35 ),
		@asAdr1				VarChar ( 35 ),
		@asAdr2				VarChar ( 35 ),
		@asAdrCplt			VarChar ( 35 ),
		@asAdrCP			VarChar ( 5 ),
		@asAdrVille			VarChar ( 35 )
AS

Declare @Tb Table (
	idHubPresta		VarChar ( 20 ),
	idFour			VarChar ( 3 ),
	libFour			VarChar ( 35 ),
	idPointServ		VarChar ( 20 ),
	idModeProcess	VarChar ( 20 ),
	nomPointServ	VarChar ( 255 ),
	adr1PointServ	VarChar ( 255 ),
	adr2PointServ	VarChar ( 255 ),
	adr3PointServ	VarChar ( 255 ),
	adrCpPointServ  Varchar ( 20 ),
	adrVillePointServ  Varchar ( 50 ),
	codePaysPointServ  Varchar ( 50 ),
	distanceMetre   Varchar ( 10 ),
	statutPointServ VarChar ( 20 )
)

Declare @iIdProd Integer
Declare @iIdGti Integer
Declare @iIdSin Integer
Declare @iCiv Integer
Declare @sIdAdh VarChar ( 50 ) 
Declare @iIdGrpContractant Integer
Declare @sLibGrpContractant VarChar ( 35 ) 
Declare @sCodePays VarChar ( 20 )

Set @iIdProd = CONVERT ( Integer, @adcIdProd ) 
Set @iIdGti = CONVERT ( Integer, @adcIdGti ) 
Set @iIdSin = CONVERT ( Integer, @iIdSin ) 
Set @iCiv = CONVERT ( Integer, @iCiv ) 

Select	@sIdAdh =	Convert ( Varchar ( 20 ), pr.cod_prod_dms ) + '-' +
					Convert ( Varchar ( 20 ), ws.id_ets) + '-' +
					ltrim ( rtrim ( ws.id_adh )) + '-' +
					Convert ( Varchar ( 20 ), ws.id_sdos) + '-',
		@iIdGrpContractant = gr.id_grp,
		@sLibGrpContractant = ltrim ( rtrim ( gr.lib_grp ))
From	sysadm.w_sin ws,
	    sysadm.produit pr,
		sysadm.groupe gr
Where   ws.id_sin = @adcIdSin
And     pr.id_prod = ws.id_prod
And     gr.id_grp = pr.id_grp

Set @sIdAdh = LTRIM ( rTrim ( @sIdAdh ))
If  @sIdAdh = '' Set @sIdAdh = null

Set @sCodePays = ''
If Len ( lTrim ( rTrim ( @asAdrCP )) ) = 5 And lTrim ( rTrim ( @asAdrCP )) <> '00000' Set @sCodePays = 'FR'

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	If @aiCas > 0 Set @aiCas = 3
	Insert into @Tb ( 
		idHubPresta,
		idFour, 
		idPointServ,
		idModeProcess,
		nomPointServ,
		adr1PointServ,
		adr2PointServ,
		adr3PointServ,
		adrCpPointServ,
		adrVillePointServ,
		codePaysPointServ,
		distanceMetre,
		statutPointServ
		)
	Exec [LS-SAGA2].[PRESTATAIRE].[edi].PS_HP276_S_HP_POINT_DE_SERVICE 
		@aiCas,
		@adcIdProd,
		@adcIdGti,
		@asMarqAppSin,
		@asModlAppSin,
		@asTypAppSin,
		@asTypDommage,
		@asTypPrestation,
		@sIdAdh,
		@iIdSin,
		@iIdGrpContractant,
		@sLibGrpContractant,
		@aiCiv,
		@asNom,
		@asPrenom,
		@asAdr1,
		@asAdr2,
		@asAdrCplt,
		@asAdrCP,
		@asAdrVille,
		@sCodePays
END
ELSE
BEGIN
	-- [HP252_276_HUB_PRESTA]
	If @aiCas >= 2
	 Begin
		Insert into @Tb ( 
			idHubPresta,
			idFour, 
			idPointServ,
			idModeProcess,
			nomPointServ,
			adr1PointServ,
			adr2PointServ,
			adr3PointServ,
			adrCpPointServ,
			adrVillePointServ,
			codePaysPointServ,
			distanceMetre,
			statutPointServ
			)
		Exec [S2SQL14PP1\PPRSAGA2].[PRESTATAIRE].[edi].PS_HP276_S_HP_POINT_DE_SERVICE 
			@aiCas,
			@adcIdProd,
			@adcIdGti,
			@asMarqAppSin,
			@asModlAppSin,
			@asTypAppSin,
			@asTypDommage,
			@asTypPrestation,
			@sIdAdh,
			@iIdSin,
			@iIdGrpContractant,
			@sLibGrpContractant,
			@aiCiv,
			@asNom,
			@asPrenom,
			@asAdr1,
			@asAdr2,
			@asAdrCplt,
			@asAdrCP,
			@asAdrVille,
			@sCodePays
	 End
	Else
	-- test SIMPA2
	 Begin
		Insert into @Tb ( 
			idHubPresta,
			idFour, 
			idPointServ,
			idModeProcess,
			nomPointServ,
			adr1PointServ,
			adr2PointServ,
			adr3PointServ,
			adrCpPointServ,
			adrVillePointServ,
			codePaysPointServ,
			distanceMetre,
			statutPointServ
			)
		Exec sysadm.PS_HP276_S_HP_POINT_DE_SERVICE 
			@aiCas,
			@adcIdProd,
			@adcIdGti,
			@asMarqAppSin,
			@asModlAppSin,
			@asTypAppSin,
			@asTypDommage,
			@asTypPrestation,
			@sIdAdh,
			@iIdSin,
			@iIdGrpContractant,
			@sLibGrpContractant,
			@aiCiv,
			@asNom,
			@asPrenom,
			@asAdr1,
			@asAdr2,
			@asAdrCplt,
			@asAdrCP,
			@asAdrVille,
			@sCodePays
	 End


Update @Tb Set libFour = sysadm.FN_CODE_CAR ( idFour, '-FR' ),
				idModeProcess =	Case idModeProcess
									When 'CENTRALIZATION' Then 'Centralisation'
									When 'PROXIMITY' Then 'Proximité'
									Else idModeProcess
								End,
				codePaysPointServ = Case codePaysPointServ
										When 'FR' Then 'France'
										Else codePaysPointServ
									End,
				statutPointServ	= Case statutPointServ
									When 'ACCEPTED' Then 'Accepté'
									When 'REJECTED' Then 'Rejeté'
									When 'UNAVAILABLE' then 'Indisponible'
									When 'UNVERIFIED' Then 'Non vérifié'
									Else statutPointServ
									End
Select * From @Tb


END 
Go
*/

-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_S_S2_OBTENTION_DONNEES_PRESTA_SIMPA2_POUR_PREPARATION_CREATION_HUB_PRESTATAIRE
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       
--                              /!\ A COMPILER SUR LA BASE SIMPA2 /!\
--								
--
-- Retourne             :       rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_S_S2_OBTENTION_DONNEES_PRESTA_SIMPA2_POUR_PREPARATION_CREATION_HUB_PRESTATAIRE' AND type = 'P' )
        DROP procedure sysadm.PS_HP276_S_S2_OBTENTION_DONNEES_PRESTA_SIMPA2_POUR_PREPARATION_CREATION_HUB_PRESTATAIRE
GO

CREATE procedure sysadm.PS_HP276_S_S2_OBTENTION_DONNEES_PRESTA_SIMPA2_POUR_PREPARATION_CREATION_HUB_PRESTATAIRE
		@aiCas				Integer,
	    @adcIdsin			Decimal ( 10 ),
		@aiIdSeq			Integer
AS

Declare @iRet Integer
Declare @dcIdProd Decimal ( 7 )

Declare 
	@iIdSin						Integer					,   -- Référence sinistre
	@dtDeposeLe					DateTime				,	-- Enregistrement déposé par Simpa2 le 
	@sDeposePar					VarChar (4)				,	-- Enregistrement déposé par
	@sAltTrt					VarChar (1)				,	-- Répère alternatif O/N des enregistrement pris en compte et traité par le HubP.
	@dtTraiteLe					DateTime				,	-- Traité par le Hub le
	@sTraitePar					VarChar (4)				,	-- traité par
	@sIdHubPresta				VarChar ( 20 )			,   -- Identifiant sur le Hub Prestataire de la prestation
	@sIdFour					VarChar ( 3 )			,   -- /!\ IMPORTANT : Code Fournisseur officiel SPB, ce code sera associé à un RIB de règlement du fournisseur chez Volcanes
	@sTypDommage				VarChar ( 100 )			,	-- Chaine contenant les codes des types de dommage sous la forme '#TD1#TD4#TD5#'
	@sPointService				VarChar ( 20 )			,	-- Code du point de service	   
	@sModeProcess				VarChar ( 20 )			,	-- Mode de logistique (CENTRALISATION / PROXIMITE )
	@sCodePickUp				VarChar ( 20 )			,	-- Code du relais si CENTRALISATION et Choix PickUp
	@sAdrNomPickUp				VarChar ( 40 )			,	-- Nom du relais si CENTRALISATION et Choix PickUp	
	@sAdrReferenceAssPickUp		VarChar ( 40 )			,	-- référence du sinistre SPB et du nom de l'assuré à mettre sur le colis du Relais PickUp (dans le cas d'un renvoi)
	@sAdr1PickUp				VarChar ( 40 )			,   -- 1ère ligne adresse du relais pickup
	@sAdr2PickUp				VarChar ( 40 )			,   -- 2ème ligne adresse du relais pickup
	@sAdrCpltPickUp				VarChar ( 40 )			,   -- 3ème ligne adresse du relais pickup
	@sAdrCpPickUp				VarChar ( 5 )			,   -- Code postal du relais pickup
	@sAdrVillePickUp			VarChar ( 40 )			,   -- Ville du relais pickup
	@iCodeProcess				Integer					,   -- code process (-IF) 3510=Dépôt colis en bureau de poste, 3520=Dépôt colis en relais pickup, 3530=Dépôt en boutique de proximité
	@sLibCodeProcess			VarChar ( 35 )			,   -- Libellé du code process
	@iIdGti						Integer					,   -- ID de la garantie SIMPA2 (-GA )
	@sLibPersoGti				VarChar ( 35 )			,   -- Libellé personnalisé de la garantie pour le produit
	@iIdDetail					Integer					,   -- ID du détail de garantie SIMPA2 
	@iIdProd					Integer					,   -- Code produit (Offre) sinistre SIMPA2 
	@sLibProd					VarChar ( 35 )			,   -- Libellé du produit (offre) sinistre SIMPA2 
	@sIdProdAdh					Integer					,   -- Code produit adhésion 
	@iIdEts						Integer					,   -- Code ets adhésion
	@sIdAdh						VarChar ( 19 )			,   -- Numéro adhésion
	@iIdSdos					Integer					,   -- Numéro sous-dossier adhésion
	@sIdTypArt					varchar ( 3 )			,   -- Code représentant le type de la prestation
	@iCodCivLivr				Integer					,   -- Code civilité de l'interlocuteur lié à la prestation
	@sLibCivLivrCourt			varchar ( 35 )			,   -- Lib civilité court de l'interlocuteur lié à la prestation
	@sLibCivLivrLong			varchar ( 35 )			,   -- Lib civilité long de l'interlocuteur lié à la prestation
	@IdContratAbonne			VarChar ( 20 ) 			,	-- Identifiant éventuel de l'assuré reconnu par le contractant
	@NomAss						VarChar ( 35 ) 			,	-- Nom de l'assuré ayant souscrit l'adhésion
	@PrenomAss					VarChar ( 35 ) 			,	-- Prénom de l'assuré ayant souscrit l'adhésion
	@NomLivr					varchar ( 35 )			,   -- Nom de l'interlocuteur lié à la prestation
	@PrenomLivr					varchar ( 35 )			,   -- Prénom de l'interlocuteur lié à la prestation
	@sAdr1Livr					varchar ( 35 )			,   -- Adresse ligne 1 de l'interlocuteur lié à la prestation
	@sAdr2Livr					varchar ( 35 )			,   -- Adresse ligne 2 de l'interlocuteur lié à la prestation
	@sAdr3Livr					varchar ( 35 )			,   -- Adresse ligne 3 de l'interlocuteur lié à la prestation
	@sAdrCpLivr					varchar ( 5 )			,   -- Code postal de l'interlocuteur lié à la prestation
	@sAdrVilleLivr				varchar ( 35 )			,   -- Ville de l'interlocuteur lié à la prestation
	@sNumTel1Ass				varchar ( 20 ) 			,   -- Numéro tel1 de l'interlocuteur lié à la prestation
	@sNumTel2Ass				varchar ( 20 ) 			,   -- Numéro tel1 de l'interlocuteur lié à la prestation
	@sNumTel3Ass				varchar ( 20 ) 			,   -- Numéro tel1 de l'interlocuteur lié à la prestation
	@sMailAssure				varchar ( 128 )			,   -- Adresse mail de l'assuré
	@sNumImeiAppSin				varchar ( 20 )  		,   -- Numéro de IMEI de l'appareil sinistré
	@sNumSerieAppSin			varchar ( 20 )  		,   -- Numéro de série de l'appareil sinistré
	@sDescriptionProbleme		varchar ( 255 )  		,   -- Déscription résumé du probleme sur l'appareil écrit en français par le GT
	@sCodEtat					varchar ( 3 )   		,   -- Etat de la prestation
	@dtValideLe					DateTime				,   -- Date de validation de la prestation par le GT
	@sValidePar					varchar ( 4 )			,   -- Prestation validé par 
	@dtCmdGenLe					DateTime				,   -- Date de génération de la prestation par le système
	@sIdRefFour					varchar ( 20 )  		,   -- Pour une commande de remplacement, cela peut être ID du matériel chez le fournisseur, sinon l'ordre d'action
	@sOrdreAction				varchar ( 20 )  		,   -- Ordre d'action
	@iIdAssureur				Integer					,   -- ID officiel spb de l'assureur
	@sLibAssureur				Varchar ( 35 )			,   -- Libellé de l'assureur
	@sLibPolice					Varchar ( 35 )			,   -- Libellé de la police
	@sTypAppSin					VarChar ( 3 ) 			,   -- Type de l'appareil sinistré (-AR)
	@sLibTypAppSin				Varchar ( 35 )			,   -- Libellé de l'appareil sinistré (-AR)
	@sMarqAppSin				Varchar ( 35 )			,   -- Marque de l'appareil sinistré
	@sModlAppSin				Varchar ( 35 )			,   -- Modèle de l'appareil sinistré
	@sRefAppSin					Varchar ( 20 )			,   -- référence de l'appareil sinistré IFR, DARTY, AUTRE (AUTRE=Marque contrôlé, saisie modèle libre)
	@sNumTelSin					VarChar ( 25 )			,   -- Numéro de téléphone de l'appareil sinistré (si c'est une téléphone/smartphone)
	@mtValAchat					decimal ( 11, 2 )		,   -- Montant de la valeur d'achat
	@mtPriseEnCharge			decimal ( 11, 2 )		,   -- Montant de prise en max par spb (à respecter par le fournisseur )
	@dtDateAchat				DateTime				,	-- Date achat du matériel sinistré
	@sEtatAppSin				varChar ( 20 )			,	-- Etat de l'appareil sinistré, REConditionné ou NEUf
	@sCodeVerrou				VarChar ( 20 )			,	-- Code vérou de l'appareil
	@sDesimlocke				VarChar( 20 )			,	-- Appareil désimlocké OUI/NON
	@sInfo_spb_frn_cplt			VarChar ( 800 )				-- Chaîne sérialisée contenant de multiples informations


Select	@iIdSin			= Convert ( integer, @adcIdsin),
		@sLibPersoGti	= cg.lib_gti,
		@iIdProd		= s.id_prod,
		@sLibProd		= rtrim ( lTrim ( pr.lib_long )),
		@sIdProdAdh		= pr.cod_prod_dms,
		@iIdEts			= s.id_ets,
		@sIdAdh			= rtrim ( lTrim ( s.id_adh )),
		@iIdSdos		= s.id_sdos,
		@IdContratAbonne = rtrim ( lTrim ( s.id_contrat_abonne )),
		@sMarqAppSin	=  rtrim ( lTrim ( s.marq_port ) ),
		@sModlAppSin	=  rtrim ( lTrim ( s.modl_port ) ),
		@sNumTelSin		= s.num_port,
		@NomAss			= rtrim ( lTrim ( pe.nom )),
		@PrenomAss		= rtrim ( lTrim ( pe.prenom )),
		@sTypAppSin		= nullif ( sysadm.FN_GET_DIV_SIN ( @adcIdsin, 'TYPE_APP', 'P',  'RETOUR=CODE'  ) , ''), 
		@sLibTypAppSin  = nullif ( sysadm.FN_CODE_CAR ( @sTypAppSin, '-AR' ), '') ,
		@sEtatAppSin	= nullif ( sysadm.FN_GET_DIV_SIN ( @adcIdsin, 'TYPAPP_REC_NEU', 'P',  'RETOUR=CODE'  ), ''),
		@sCodeVerrou	= nullif ( sysadm.FN_GET_DIV_SIN ( @adcIdsin, 'CODE_VERROU_SHERPA_SCRIPT', 'P', '' ), '' ),
		@sDesimlocke	= nullif ( sysadm.FN_GET_DIV_SIN ( @adcIdsin, 'DESIMLOCKE', 'P', '' ), '' ),
		@dtDateAchat	= s.dte_ach_port,
		@iIdAssureur	= sysadm.FN_ID_CIE (s.id_sin),
		@sLibAssureur   = sysadm.FN_LIB_CIE (s.id_sin),
		@sLibPolice		= sysadm.FN_LIB_POLICE (s.id_sin)

From	sysadm.sinistre s with ( nolock ), 
		sysadm.commande c with ( nolock ),
		sysadm.code_garantie cg with ( nolock ),
		sysadm.produit pr with ( nolock ),
		sysadm.personne pe with ( nolock )
Where	s.id_sin = @adcIdsin
And		c.id_sin = s.id_sin
And		c.id_seq = @aiIdSeq
And		cg.id_prod = s.id_prod
And		cg.id_gti = c.id_gti
And		pr.id_prod = s.id_prod
And		pe.id_ordre = s.id_ordre

Set @dcIdProd = CONVERT ( Decimal ( 7 ), @iIdProd ) 

Select 	@dtDeposeLe		= GETDATE(),
		@sDeposePar		= 'SIM2',
		@sAltTrt		= 'N',
		@dtTraiteLe		= null,
		@sTraitePar		= null,
		@sIdHubPresta	= nullif ( sysadm.FN_CLE_VAL ('HP_ID_HUB_PRESTA' , c.info_spb_frn_cplt, ';'), ''),
		@sTypDommage    = nullif ( sysadm.FN_CLE_VAL ('HP_TYP_DOM' , c.info_spb_frn_cplt, ';'), ''),
		@sIdFour		= c.id_four,
		@sPointService	= nullif ( sysadm.FN_CLE_VAL ('HP_ID_POINT_SERV' , c.info_spb_frn_cplt, ';'), ''),
		@sModeProcess	= nullif ( sysadm.FN_CLE_VAL ('HP_ID_MODE_PROCESS' , c.info_spb_frn_cplt, ';'), ''),
		@sCodePickUp	= nullif ( sysadm.FN_CLE_VAL ('CODE_PICK_UP' , c.info_spb_frn_cplt, ';'), ''),
		@sAdrNomPickUp	= nullif ( sysadm.FN_CLE_VAL ('NOM_PICK_UP' , c.info_spb_frn_cplt, ';'), ''),
		@sAdrReferenceAssPickUp= nullif ( sysadm.FN_CLE_VAL ('REFASS_PICK_UP' , c.info_spb_frn_cplt, ';'), ''),
		@sAdr1PickUp	= nullif ( sysadm.FN_CLE_VAL ('ADR1_PICK_UP' , c.info_spb_frn_cplt, ';'), ''),
		@sAdr2PickUp	= nullif ( sysadm.FN_CLE_VAL ('ADR2_PICK_UP' , c.info_spb_frn_cplt, ';'), ''),
		@sAdrCpltPickUp	= nullif ( sysadm.FN_CLE_VAL ('ADR3_PICK_UP' , c.info_spb_frn_cplt, ';'), ''),
		@sAdrCpPickUp	= nullif ( sysadm.FN_CLE_VAL ('ADRCP_PICK_UP' , c.info_spb_frn_cplt, ';'), ''),
		@sAdrVillePickUp= nullif ( sysadm.FN_CLE_VAL ('ADRVILLE_PICK_UP' , c.info_spb_frn_cplt, ';'), ''),
		@iCodeProcess	= c.info_spb_frn,
		@sLibCodeProcess= sysadm.FN_CODE_NUM ( c.info_spb_frn, '-IF' ), 
		@iIdGti			= c.id_gti,
		@iIdDetail		= c.id_detail,
		@sIdTypArt		= rtrim ( lTrim ( c.id_typ_art )),
		@iCodCivLivr	= c.adr_cod_civ,
		@sLibCivLivrCourt = sysadm.FN_CODE_NUM ( c.adr_cod_civ, '-CI' ),
		@sLibCivLivrLong = IIF ( c.adr_cod_civ = 5, 'Messieurs', sysadm.FN_CODE_NUM ( c.adr_cod_civ, '-CL' )),
		@NomLivr		= rtrim ( lTrim ( c.adr_nom )),
		@PrenomLivr		= rtrim ( lTrim ( c.adr_prenom )),
		@sAdr1Livr		= rtrim ( lTrim ( c.adr_livr1 )),
		@sAdr2Livr		= rtrim ( lTrim ( c.adr_livr2 )),
		@sAdr3Livr		= rtrim ( lTrim ( c.adr_livr_cpl )),
		@sAdrCpLivr		= rtrim ( lTrim ( c.adr_cp )),
		@sAdrVilleLivr	= rtrim ( lTrim ( c.adr_ville )),
		@sNumTel1Ass	= rtrim ( lTrim ( c.adr_tel1 )),
		@sNumTel2Ass	= rtrim ( lTrim ( c.adr_tel2 )),
		@sNumTel3Ass	= rtrim ( lTrim ( c.adr_tel3 )),
		@sMailAssure	= ( Select Top 1 rtrim ( lTrim ( i.adr_mail )) From sysadm.inter i with ( nolock ) Where i.id_sin = @adcIdsin And i.cod_inter = 'A' ),
		@sNumImeiAppSin = rtrim ( lTrim ( IIF ( @sTypAppSin	= 'TEL', c.id_serie_anc, null ))), 
		@sNumSerieAppSin = rtrim ( lTrim ( IIF ( @sTypAppSin <> 'TEL', c.id_serie_anc, null ))),
		@sDescriptionProbleme = rtrim ( lTrim ( c.probleme )),
		@sCodEtat = rtrim ( lTrim ( c.cod_etat )),
		@dtValideLe = c.valide_le, 
		@sValidePar = rtrim ( lTrim ( c.valide_par )), 
		@dtCmdGenLe = getdate(),
		@sIdRefFour = rtrim ( lTrim ( c.id_ref_four )),
		@sOrdreAction = rtrim ( lTrim ( IIF ( id_typ_art not in ( 'PRS', 'EDI' ), 'A_COMMANDER', c.id_ref_four ) )),
		@sRefAppSin  = 
			ISNULL ( 
			NullIf ( 
				(	Select  Top 1 LEFT ( dp.id_code_car, 3 )
					From	sysadm.det_pro dp with ( nolock )
					Where   dp.id_prod = @dcIdProd
					and		dp.id_code_dp = 28
					and		RIGHT ( dp.id_code_car, 3 ) = @sTypAppSin
				), ''), 'SPB' ),
		@mtValAchat = 
			( Select Top 1 IsNull ( d.mt_val_achat, 0 )
			  From sysadm.detail d with (nolock) 
			  where d.id_sin = c.id_sin
			  And   d.id_gti = c.id_gti
			  And   d.id_detail = c.id_detail ),
		@mtPriseEnCharge = 
			( Select Top 1 IsNull ( dd.val_mt, 0 )
			  From sysadm.div_det dd with (nolock) 
			  where dd.id_sin = c.id_sin
			  And   dd.id_gti = c.id_gti
			  And   dd.id_detail = c.id_detail 
			  And   dd.nom_zone = 'mt_pec' ),
		@dtDateAchat =
			Case 
				When ( 	Select 	count (*) 
					From 	sysadm.det_pro dp  with (nolock) 
		       			Where 	dp.id_prod = @dcIdProd
		       			And 	dp.id_code_dp = 42 
		       			and 	dp.id_code_car = 'A' 
		       			and 	dp.id_code_num = c.id_gti ) > 0 Then
		       				IsNull ( Convert ( VarChar ( 10 ) , 
								(select d.dte_det 
								from sysadm.detail d  with (nolock) 
								where d.id_sin = c.id_sin 
								and d.id_gti = c.id_gti 
								and d.id_detail = c.id_detail ) 
								, 103),
							 '' )
				Else IsNull ( Convert ( VarChar ( 10 ) , @dtDateAchat , 103), '' )
			End,
		@sInfo_spb_frn_cplt = rtrim ( lTrim ( c.info_spb_frn_cplt ))

From sysadm.commande c with ( nolock ) -- [DBG]
Where c.id_sin = @adcIdsin
And   c.id_seq = @aiIdSeq


Select 
	@aiCas 'iCas',
	@iIdSin	'iIdSin',
	@aiIdSeq 'iIdSeq',
	@sIdHubPresta	'sIdHubPresta',
	@sIdFour	'sIdFour',
	@sTypDommage	'sTypDommage',
	@sPointService	'sPointService',
	@sModeProcess	'sModeProcess',
	@sCodePickUp	'sCodePickUp',
	@sAdrNomPickUp	'sAdrNomPickUp',
	@sAdrReferenceAssPickUp	'sAdrReferenceAssPickUp',
	@sAdr1PickUp	'sAdr1PickUp',
	@sAdr2PickUp	'sAdr2PickUp',
	@sAdrCpltPickUp	'sAdrCpltPickUp',
	@sAdrCpPickUp	'sAdrCpPickUp',
	@sAdrVillePickUp	'sAdrVillePickUp',
	@iCodeProcess	'iCodeProcess',
	@sLibCodeProcess	'sLibCodeProcess',
	@iIdGti	'iIdGti',
	@sLibPersoGti	'sLibPersoGti',
	@iIdDetail	'iIdDetail',
	@iIdProd	'iIdProd',
	@sLibProd	'sLibProd',
	@sIdProdAdh	'sIdProdAdh',
	@iIdEts	'iIdEts',
	@sIdAdh	'sIdAdh',
	@iIdSdos	'iIdSdos',
	@sIdTypArt	'sIdTypArt',
	@iCodCivLivr	'iCodCivLivr',
	@sLibCivLivrCourt	'sLibCivLivrCourt',
	@sLibCivLivrLong	'sLibCivLivrLong',
	@IdContratAbonne	'IdContratAbonne',
	@NomAss	'NomAss',
	@PrenomAss	'PrenomAss',
	@NomLivr	'NomLivr',
	@PrenomLivr	'PrenomLivr',
	@sAdr1Livr	'sAdr1Livr',
	@sAdr2Livr	'sAdr2Livr',
	@sAdr3Livr	'sAdr3Livr',
	@sAdrCpLivr	'sAdrCpLivr',
	@sAdrVilleLivr	'sAdrVilleLivr',
	@sNumTel1Ass	'sNumTel1Ass',
	@sNumTel2Ass	'sNumTel2Ass',
	@sNumTel3Ass	'sNumTel3Ass',
	@sMailAssure	'sMailAssure',
	@sNumImeiAppSin	'sNumImeiAppSin',
	@sNumSerieAppSin	'sNumSerieAppSin',
	@sDescriptionProbleme	'sDescriptionProbleme',
	@sCodEtat	'sCodEtat',
	@dtValideLe	'dtValideLe',
	@sValidePar	'sValidePar',
	@dtCmdGenLe	'dtCmdGenLe',
	@sIdRefFour	'sIdRefFour',
	@sOrdreAction	'sOrdreAction',
	@iIdAssureur	'iIdAssureur',
	@sLibAssureur	'sLibAssureur',
	@sLibPolice	'sLibPolice',
	@sTypAppSin	'sTypAppSin',
	@sLibTypAppSin	'sLibTypAppSin',
	@sMarqAppSin	'sMarqAppSin',
	@sModlAppSin	'sModlAppSin',
	@sRefAppSin	'sRefAppSin',
	@sNumTelSin	'sNumTelSin',
	@mtValAchat	'mtValAchat',
	@mtPriseEnCharge	'mtPriseEnCharge',
	@dtDateAchat	'dtDateAchat',
	@sEtatAppSin	'sEtatAppSin',
	@sCodeVerrou	'sCodeVerrou',
	@sDesimlocke	'sDesimlocke',
	@sInfo_spb_frn_cplt	'sInfo_spb_frn_cplt'

Go



-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_I_S2_CREATION_PRESTA_DANS_LE_HUB_PRESTATAIRE
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Créer et valvier la prestation dans le HUB
--                              /!\ A COMPILER SUR LA BASE SIMPA2 /!\
--								Cette est la PS d'appel SIMPA2 qui appel le HUB selon l'environnement
--
-- Retourne             :       rien
-------------------------------------------------------------------
/*
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_I_S2_CREATION_PRESTA_DANS_LE_HUB_PRESTATAIRE' AND type = 'P' )
        DROP procedure sysadm.PS_HP276_I_S2_CREATION_PRESTA_DANS_LE_HUB_PRESTATAIRE
GO

CREATE procedure sysadm.PS_HP276_I_S2_CREATION_PRESTA_DANS_LE_HUB_PRESTATAIRE
		@aiCas				Integer,
	    @adcIdsin			Decimal ( 10 ),
		@aiIdSeq			Integer
AS

Declare @iRet Integer
Declare @dcIdProd Decimal ( 7 )

Declare 
	@iIdSin						Integer					,   -- Référence sinistre
	@dtDeposeLe					DateTime				,	-- Enregistrement déposé par Simpa2 le 
	@sDeposePar					VarChar (4)				,	-- Enregistrement déposé par
	@sAltTrt					VarChar (1)				,	-- Répère alternatif O/N des enregistrement pris en compte et traité par le HubP.
	@dtTraiteLe					DateTime				,	-- Traité par le Hub le
	@sTraitePar					VarChar (4)				,	-- traité par
	@sIdHubPresta				VarChar ( 20 )			,   -- Identifiant sur le Hub Prestataire de la prestation
	@sIdFour					VarChar ( 3 )			,   -- /!\ IMPORTANT : Code Fournisseur officiel SPB, ce code sera associé à un RIB de règlement du fournisseur chez Volcanes
	@sTypDommage				VarChar ( 100 )			,	-- Chaine contenant les codes des types de dommage sous la forme '#TD1#TD4#TD5#'
	@sPointService				VarChar ( 20 )			,	-- Code du point de service	   
	@sModeProcess				VarChar ( 20 )			,	-- Mode de logistique (CENTRALISATION / PROXIMITE )
	@sCodePickUp				VarChar ( 20 )			,	-- Code du relais si CENTRALISATION et Choix PickUp
	@sAdrNomPickUp				VarChar ( 40 )			,	-- Nom du relais si CENTRALISATION et Choix PickUp	
	@sAdrReferenceAssPickUp		VarChar ( 40 )			,	-- référence du sinistre SPB et du nom de l'assuré à mettre sur le colis du Relais PickUp (dans le cas d'un renvoi)
	@sAdr1PickUp				VarChar ( 40 )			,   -- 1ère ligne adresse du relais pickup
	@sAdr2PickUp				VarChar ( 40 )			,   -- 2ème ligne adresse du relais pickup
	@sAdrCpltPickUp				VarChar ( 40 )			,   -- 3ème ligne adresse du relais pickup
	@sAdrCpPickUp				VarChar ( 5 )			,   -- Code postal du relais pickup
	@sAdrVillePickUp			VarChar ( 40 )			,   -- Ville du relais pickup
	@iCodeProcess				Integer					,   -- code process (-IF) 3510=Dépôt colis en bureau de poste, 3520=Dépôt colis en relais pickup, 3530=Dépôt en boutique de proximité
	@sLibCodeProcess			VarChar ( 35 )			,   -- Libellé du code process
	@iIdGti						Integer					,   -- ID de la garantie SIMPA2 (-GA )
	@sLibPersoGti				VarChar ( 35 )			,   -- Libellé personnalisé de la garantie pour le produit
	@iIdDetail					Integer					,   -- ID du détail de garantie SIMPA2 
	@iIdProd					Integer					,   -- Code produit (Offre) sinistre SIMPA2 
	@sLibProd					VarChar ( 35 )			,   -- Libellé du produit (offre) sinistre SIMPA2 
	@sIdProdAdh					Integer					,   -- Code produit adhésion 
	@iIdEts						Integer					,   -- Code ets adhésion
	@sIdAdh						VarChar ( 19 )			,   -- Numéro adhésion
	@iIdSdos					Integer					,   -- Numéro sous-dossier adhésion
	@sIdTypArt					varchar ( 3 )			,   -- Code représentant le type de la prestation
	@iCodCivLivr				Integer					,   -- Code civilité de l'interlocuteur lié à la prestation
	@sLibCivLivrCourt			varchar ( 35 )			,   -- Lib civilité court de l'interlocuteur lié à la prestation
	@sLibCivLivrLong			varchar ( 35 )			,   -- Lib civilité long de l'interlocuteur lié à la prestation
	@IdContratAbonne			VarChar ( 20 ) 			,	-- Identifiant éventuel de l'assuré reconnu par le contractant
	@NomAss						VarChar ( 35 ) 			,	-- Nom de l'assuré ayant souscrit l'adhésion
	@PrenomAss					VarChar ( 35 ) 			,	-- Prénom de l'assuré ayant souscrit l'adhésion
	@NomLivr					varchar ( 35 )			,   -- Nom de l'interlocuteur lié à la prestation
	@PrenomLivr					varchar ( 35 )			,   -- Prénom de l'interlocuteur lié à la prestation
	@sAdr1Livr					varchar ( 35 )			,   -- Adresse ligne 1 de l'interlocuteur lié à la prestation
	@sAdr2Livr					varchar ( 35 )			,   -- Adresse ligne 2 de l'interlocuteur lié à la prestation
	@sAdr3Livr					varchar ( 35 )			,   -- Adresse ligne 3 de l'interlocuteur lié à la prestation
	@sAdrCpLivr					varchar ( 5 )			,   -- Code postal de l'interlocuteur lié à la prestation
	@sAdrVilleLivr				varchar ( 35 )			,   -- Ville de l'interlocuteur lié à la prestation
	@sNumTel1Ass				varchar ( 20 ) 			,   -- Numéro tel1 de l'interlocuteur lié à la prestation
	@sNumTel2Ass				varchar ( 20 ) 			,   -- Numéro tel1 de l'interlocuteur lié à la prestation
	@sNumTel3Ass				varchar ( 20 ) 			,   -- Numéro tel1 de l'interlocuteur lié à la prestation
	@sMailAssure				varchar ( 128 )			,   -- Adresse mail de l'assuré
	@sNumImeiAppSin				varchar ( 20 )  		,   -- Numéro de IMEI de l'appareil sinistré
	@sNumSerieAppSin			varchar ( 20 )  		,   -- Numéro de série de l'appareil sinistré
	@sDescriptionProbleme		varchar ( 255 )  		,   -- Déscription résumé du probleme sur l'appareil écrit en français par le GT
	@sCodEtat					varchar ( 3 )   		,   -- Etat de la prestation
	@dtValideLe					DateTime				,   -- Date de validation de la prestation par le GT
	@sValidePar					varchar ( 4 )			,   -- Prestation validé par 
	@dtCmdGenLe					DateTime				,   -- Date de génération de la prestation par le système
	@sIdRefFour					varchar ( 20 )  		,   -- Pour une commande de remplacement, cela peut être ID du matériel chez le fournisseur, sinon l'ordre d'action
	@sOrdreAction				varchar ( 20 )  		,   -- Ordre d'action
	@iIdAssureur				Integer					,   -- ID officiel spb de l'assureur
	@sLibAssureur				Varchar ( 35 )			,   -- Libellé de l'assureur
	@sLibPolice					Varchar ( 35 )			,   -- Libellé de la police
	@sTypAppSin					VarChar ( 3 ) 			,   -- Type de l'appareil sinistré (-AR)
	@sLibTypAppSin				Varchar ( 35 )			,   -- Libellé de l'appareil sinistré (-AR)
	@sMarqAppSin				Varchar ( 35 )			,   -- Marque de l'appareil sinistré
	@sModlAppSin				Varchar ( 35 )			,   -- Modèle de l'appareil sinistré
	@sRefAppSin					Varchar ( 20 )			,   -- référence de l'appareil sinistré IFR, DARTY, AUTRE (AUTRE=Marque contrôlé, saisie modèle libre)
	@sNumTelSin					VarChar ( 25 )			,   -- Numéro de téléphone de l'appareil sinistré (si c'est une téléphone/smartphone)
	@mtValAchat					decimal ( 11, 2 )		,   -- Montant de la valeur d'achat
	@mtPriseEnCharge			decimal ( 11, 2 )		,   -- Montant de prise en max par spb (à respecter par le fournisseur )
	@dtDateAchat				DateTime				,	-- Date achat du matériel sinistré
	@sEtatAppSin				varChar ( 20 )			,	-- Etat de l'appareil sinistré, REConditionné ou NEUf
	@sCodeVerrou				VarChar ( 20 )			,	-- Code vérou de l'appareil
	@sDesimlocke				VarChar( 20 )			,	-- Appareil désimlocké OUI/NON
	@sInfo_spb_frn_cplt			VarChar ( 800 )				-- Chaîne sérialisée contenant de multiples informations


DECLARE @DBID INT
DECLARE @DBNAME NVARCHAR(128)

Set @iIdSin = CONVERT ( Integer, @adcIdsin ) 
SET @DBID = DB_ID()
SET @DBNAME = DB_NAME()

-- Marquage de la génaration
Update  sysadm.commande
Set		id_lot_cmd = 999800, cmd_gen_le = GETDATE(), cmd_gen_par = 'HUB'
Where   id_sin = @adcIdsin
And		id_seq = @aiIdSeq

Select	@sLibPersoGti	= cg.lib_gti,
		@iIdProd		= s.id_prod,
		@sLibProd		= rtrim ( lTrim ( pr.lib_long )),
		@sIdProdAdh		= pr.cod_prod_dms,
		@iIdEts			= s.id_ets,
		@sIdAdh			= rtrim ( lTrim ( s.id_adh )),
		@iIdSdos		= s.id_sdos,
		@IdContratAbonne = rtrim ( lTrim ( s.id_contrat_abonne )),
		@sMarqAppSin	=  rtrim ( lTrim ( s.marq_port ) ),
		@sModlAppSin	=  rtrim ( lTrim ( s.modl_port ) ),
		@sNumTelSin		= s.num_port,
		@NomAss			= rtrim ( lTrim ( pe.nom )),
		@PrenomAss		= rtrim ( lTrim ( pe.prenom )),
		@sTypAppSin		= sysadm.FN_GET_DIV_SIN ( @adcIdsin, 'TYPE_APP', 'P',  'RETOUR=CODE'  ), 
		@sLibTypAppSin  = sysadm.FN_CODE_CAR ( @sTypAppSin, '-AR' ) ,
		@sEtatAppSin	= sysadm.FN_GET_DIV_SIN ( @adcIdsin, 'TYPAPP_REC_NEU', 'P',  'RETOUR=CODE'  ),
		@sCodeVerrou	= sysadm.FN_GET_DIV_SIN ( @adcIdsin, 'CODE_VERROU_SHERPA_SCRIPT', 'P', '' ),
		@sDesimlocke	= sysadm.FN_GET_DIV_SIN ( @adcIdsin, 'DESIMLOCKE', 'P', '' ),
		@dtDateAchat	= s.dte_ach_port,
		@iIdAssureur	= sysadm.FN_ID_CIE (s.id_sin),
		@sLibAssureur   = sysadm.FN_LIB_CIE (s.id_sin),
		@sLibPolice		= sysadm.FN_LIB_POLICE (s.id_sin)

From	sysadm.sinistre s with ( nolock ),
		sysadm.commande c with ( nolock ),
		sysadm.code_garantie cg with ( nolock ),
		sysadm.produit pr with ( nolock ),
		sysadm.personne pe with ( nolock )
Where	s.id_sin = @adcIdsin
And		c.id_sin = s.id_sin
And		c.id_seq = @aiIdSeq
And		cg.id_prod = s.id_prod
And		cg.id_gti = c.id_gti
And		pr.id_prod = s.id_prod
And		pe.id_ordre = s.id_ordre

Set @dcIdProd = CONVERT ( Decimal ( 7 ), @iIdProd ) 

Select 	@dtDeposeLe		= GETDATE(),
		@sDeposePar		= 'SIM2',
		@sAltTrt		= 'N',
		@dtTraiteLe		= null,
		@sTraitePar		= null,
		@sIdHubPresta	= sysadm.FN_CLE_VAL ('HP_ID_HUB_PRESTA' , c.info_spb_frn_cplt, ';'),
		@sTypDommage    = sysadm.FN_CLE_VAL ('HP_TYP_DOM' , c.info_spb_frn_cplt, ';'),
		@sIdFour		= c.id_four,
		@sPointService	= sysadm.FN_CLE_VAL ('HP_ID_POINT_SERV' , c.info_spb_frn_cplt, ';'),
		@sModeProcess	= sysadm.FN_CLE_VAL ('HP_ID_MODE_PROCESS' , c.info_spb_frn_cplt, ';'),
		@sCodePickUp	= sysadm.FN_CLE_VAL ('CODE_PICK_UP' , c.info_spb_frn_cplt, ';'),
		@sAdrNomPickUp	= sysadm.FN_CLE_VAL ('NOM_PICK_UP' , c.info_spb_frn_cplt, ';'),
		@sAdrReferenceAssPickUp= sysadm.FN_CLE_VAL ('REFASS_PICK_UP' , c.info_spb_frn_cplt, ';'),
		@sAdr1PickUp	= sysadm.FN_CLE_VAL ('ADR1_PICK_UP' , c.info_spb_frn_cplt, ';'),
		@sAdr2PickUp	= sysadm.FN_CLE_VAL ('ADR2_PICK_UP' , c.info_spb_frn_cplt, ';'),
		@sAdrCpltPickUp	= sysadm.FN_CLE_VAL ('ADR3_PICK_UP' , c.info_spb_frn_cplt, ';'),
		@sAdrCpPickUp	= sysadm.FN_CLE_VAL ('ADRCP_PICK_UP' , c.info_spb_frn_cplt, ';'),
		@sAdrVillePickUp= sysadm.FN_CLE_VAL ('ADRVILLE_PICK_UP' , c.info_spb_frn_cplt, ';'),
		@iCodeProcess	= c.info_spb_frn,
		@sLibCodeProcess= sysadm.FN_CODE_NUM ( c.info_spb_frn, '-IF' ), 
		@iIdGti			= c.id_gti,
		@iIdDetail		= c.id_detail,
		@sIdTypArt		= rtrim ( lTrim ( c.id_typ_art )),
		@iCodCivLivr	= c.adr_cod_civ,
		@sLibCivLivrCourt = sysadm.FN_CODE_NUM ( c.adr_cod_civ, '-CI' ),
		@sLibCivLivrLong = IIF ( c.adr_cod_civ = 5, 'Messieurs', sysadm.FN_CODE_NUM ( c.adr_cod_civ, '-CL' )),
		@NomLivr		= rtrim ( lTrim ( c.adr_nom )),
		@PrenomLivr		= rtrim ( lTrim ( c.adr_prenom )),
		@sAdr1Livr		= rtrim ( lTrim ( c.adr_livr1 )),
		@sAdr2Livr		= rtrim ( lTrim ( c.adr_livr2 )),
		@sAdr3Livr		= rtrim ( lTrim ( c.adr_livr_cpl )),
		@sAdrCpLivr		= rtrim ( lTrim ( c.adr_cp )),
		@sAdrVilleLivr	= rtrim ( lTrim ( c.adr_ville )),
		@sNumTel1Ass	= rtrim ( lTrim ( c.adr_tel1 )),
		@sNumTel2Ass	= rtrim ( lTrim ( c.adr_tel2 )),
		@sNumTel3Ass	= rtrim ( lTrim ( c.adr_tel3 )),
		@sMailAssure	= ( Select Top 1 rtrim ( lTrim ( i.adr_mail )) From sysadm.inter i with ( nolock ) Where i.id_sin = @adcIdsin And i.cod_inter = 'A' ),
		@sNumImeiAppSin = rtrim ( lTrim ( IIF ( @sTypAppSin	= 'TEL', c.id_serie_anc, null ))), 
		@sNumSerieAppSin = rtrim ( lTrim ( IIF ( @sTypAppSin <> 'TEL', c.id_serie_anc, null ))),
		@sDescriptionProbleme = rtrim ( lTrim ( c.probleme )),
		@sCodEtat = rtrim ( lTrim ( c.cod_etat )),
		@dtValideLe = c.valide_le,
		@sValidePar = rtrim ( lTrim ( c.valide_par )),
		@dtCmdGenLe = c.cmd_gen_le,
		@sIdRefFour = rtrim ( lTrim ( c.id_ref_four )),
		@sOrdreAction = rtrim ( lTrim ( IIF ( id_typ_art not in ( 'PRS', 'EDI' ), 'A_COMMANDER', c.id_ref_four ) )),
		@sRefAppSin  = 
			(	Select  Top 1 LEFT ( dp.id_code_car, 3 )
				From	sysadm.det_pro dp with ( nolock )
				Where   dp.id_prod = @dcIdProd
				and		dp.id_code_dp = 28
				and		RIGHT ( dp.id_code_car, 3 ) = @sTypAppSin
			),
		@mtValAchat = 
			( Select Top 1 IsNull ( d.mt_val_achat, 0 )
			  From sysadm.detail d with (nolock) 
			  where d.id_sin = c.id_sin
			  And   d.id_gti = c.id_gti
			  And   d.id_detail = c.id_detail ),
		@mtPriseEnCharge = 
			( Select Top 1 IsNull ( dd.val_mt, 0 )
			  From sysadm.div_det dd with (nolock) 
			  where dd.id_sin = c.id_sin
			  And   dd.id_gti = c.id_gti
			  And   dd.id_detail = c.id_detail 
			  And   dd.nom_zone = 'mt_pec' ),
		@dtDateAchat =
			Case 
				When ( 	Select 	count (*) 
					From 	sysadm.det_pro dp  with (nolock) 
		       			Where 	dp.id_prod = @dcIdProd
		       			And 	dp.id_code_dp = 42 
		       			and 	dp.id_code_car = 'A' 
		       			and 	dp.id_code_num = c.id_gti ) > 0 Then
		       				IsNull ( Convert ( VarChar ( 10 ) , 
								(select d.dte_det 
								from sysadm.detail d  with (nolock) 
								where d.id_sin = c.id_sin 
								and d.id_gti = c.id_gti 
								and d.id_detail = c.id_detail ) 
								, 103),
							 '' )
				Else IsNull ( Convert ( VarChar ( 10 ) , @dtDateAchat , 103), '' )
			End,
		@sInfo_spb_frn_cplt = rtrim ( lTrim ( c.info_spb_frn_cplt ))

From sysadm.commande c with ( nolock )
Where c.id_sin = @adcIdsin
And   c.id_seq = @aiIdSeq

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	If @aiCas > 0 Set @aiCas = 3
	Exec @iRet = [LS-SAGA2].[PRESTATAIRE].[edi].PS_HP276_I_HP_CREATION_PRESTA_DANS_LE_HUB_PRESTATAIRE 
	    @aiCas,
		@sIdHubPresta,
		@sPointService,
		@sModeProcess,
		@sCodePickUp,
		@sAdrNomPickUp,
		@sAdrReferenceAssPickUp,
		@sAdr1PickUp,
		@sAdr2PickUp,
		@sAdrCpltPickUp,
		@sAdrCpPickUp,
		@sAdrVillePickUp

	If @iRet = -1 
	  Begin
		Update  sysadm.commande
		Set		id_lot_cmd = -1, cmd_gen_le = GETDATE(), cmd_gen_par = 'HUB'
		Where   id_sin = @adcIdsin
		And		id_seq = @aiIdSeq

		 RAISERROR ('Retour erreur du Hub Prestataire PS_HP276_I_HP_CREATION_PRESTA_DANS_LE_HUB_PRESTATAIRE', 16, 1, @DBID, @DBNAME)
		 Return
	  End 

	Exec @iRet = [LS-SAGA2].[PRESTATAIRE].[edi].PS_HP276_I_HP_VALIDATION_PRESTA_DANS_LE_HUB_PRESTATAIRE 
			@aiCas,
			@iIdSin,
			@aiIdSeq,
			@dtDeposeLe,
			@sDeposePar,
			@sAltTrt,
			@dtTraiteLe,
			@sTraitePar,
			@sIdHubPresta,
			@sIdFour,
			@sTypDommage,
			@sPointService,
			@sModeProcess,
			@sCodePickUp,
			@sAdrNomPickUp,
			@sAdrReferenceAssPickUp,
			@sAdr1PickUp,
			@sAdr2PickUp,
			@sAdrCpltPickUp,
			@sAdrCpPickUp,
			@sAdrVillePickUp,
			@iCodeProcess,
			@sLibCodeProcess,
			@iIdGti,
			@sLibPersoGti,
			@iIdDetail,
			@iIdProd,
			@sLibProd,
			@sIdProdAdh,
			@iIdEts,
			@sIdAdh,
			@iIdSdos,
			@sIdTypArt,
			@iCodCivLivr,
			@sLibCivLivrCourt,
			@sLibCivLivrLong,
			@IdContratAbonne,
			@NomAss,
			@PrenomAss,
			@NomLivr,
			@PrenomLivr,
			@sAdr1Livr,
			@sAdr2Livr,
			@sAdr3Livr,
			@sAdrCpLivr,
			@sAdrVilleLivr,
			@sNumTel1Ass,
			@sNumTel2Ass,
			@sNumTel3Ass,
			@sMailAssure,
			@sNumImeiAppSin,
			@sNumSerieAppSin,
			@sDescriptionProbleme,
			@sCodEtat,
			@dtValideLe,
			@sValidePar,
			@dtCmdGenLe,
			@sIdRefFour,
			@sOrdreAction,
			@iIdAssureur,
			@sLibAssureur,
			@sLibPolice,
			@sTypAppSin,
			@sLibTypAppSin,
			@sMarqAppSin,
			@sModlAppSin,
			@sRefAppSin,
			@sNumTelSin,
			@mtValAchat,
			@mtPriseEnCharge,
			@dtDateAchat,
			@sEtatAppSin,
			@sCodeVerrou,
			@sDesimlocke,
			@sInfo_spb_frn_cplt

		If @iRet = -1 
		  Begin
			Update  sysadm.commande
			Set		id_lot_cmd = -1, cmd_gen_le = GETDATE(), cmd_gen_par = 'HUB'
			Where   id_sin = @adcIdsin
			And		id_seq = @aiIdSeq

			 RAISERROR ('Retour erreur du Hub Prestataire PS_HP276_I_HP_VALIDATION_PRESTA_DANS_LE_HUB_PRESTATAIRE', 16, 1, @DBID, @DBNAME)
			 Return
		  End 

END
ELSE
BEGIN
	-- [HP252_276_HUB_PRESTA]
	If @aiCas in ( 2, 3 )
	 Begin
		Exec @iRet = [S2SQL14PP1\PPRSAGA2].[PRESTATAIRE].[edi].PS_HP276_I_HP_CREATION_PRESTA_DANS_LE_HUB_PRESTATAIRE 
			@aiCas,
			@sIdHubPresta,
			@sPointService,
			@sModeProcess,
			@sCodePickUp,
			@sAdrNomPickUp,
			@sAdrReferenceAssPickUp,
			@sAdr1PickUp,
			@sAdr2PickUp,
			@sAdrCpltPickUp,
			@sAdrCpPickUp,
			@sAdrVillePickUp

			If @iRet = -1 
			  Begin
				Update  sysadm.commande
				Set		id_lot_cmd = -1, cmd_gen_le = GETDATE(), cmd_gen_par = 'HUB'
				Where   id_sin = @adcIdsin
				And		id_seq = @aiIdSeq

				 RAISERROR ('Retour erreur du Hub Prestataire PS_HP276_I_HP_CREATION_PRESTA_DANS_LE_HUB_PRESTATAIRE', 16, 1, @DBID, @DBNAME)
				 Return
			  End 

		Exec @iRet = [S2SQL14PP1\PPRSAGA2].[PRESTATAIRE].[edi].PS_HP276_I_HP_VALIDATION_PRESTA_DANS_LE_HUB_PRESTATAIRE 
			@aiCas,
			@iIdSin,
			@aiIdSeq,
			@dtDeposeLe,
			@sDeposePar,
			@sAltTrt,
			@dtTraiteLe,
			@sTraitePar,
			@sIdHubPresta,
			@sIdFour,
			@sTypDommage,
			@sPointService,
			@sModeProcess,
			@sCodePickUp,
			@sAdrNomPickUp,
			@sAdrReferenceAssPickUp,
			@sAdr1PickUp,
			@sAdr2PickUp,
			@sAdrCpltPickUp,
			@sAdrCpPickUp,
			@sAdrVillePickUp,
			@iCodeProcess,
			@sLibCodeProcess,
			@iIdGti,
			@sLibPersoGti,
			@iIdDetail,
			@iIdProd,
			@sLibProd,
			@sIdProdAdh,
			@iIdEts,
			@sIdAdh,
			@iIdSdos,
			@sIdTypArt,
			@iCodCivLivr,
			@sLibCivLivrCourt,
			@sLibCivLivrLong,
			@IdContratAbonne,
			@NomAss,
			@PrenomAss,
			@NomLivr,
			@PrenomLivr,
			@sAdr1Livr,
			@sAdr2Livr,
			@sAdr3Livr,
			@sAdrCpLivr,
			@sAdrVilleLivr,
			@sNumTel1Ass,
			@sNumTel2Ass,
			@sNumTel3Ass,
			@sMailAssure,
			@sNumImeiAppSin,
			@sNumSerieAppSin,
			@sDescriptionProbleme,
			@sCodEtat,
			@dtValideLe,
			@sValidePar,
			@dtCmdGenLe,
			@sIdRefFour,
			@sOrdreAction,
			@iIdAssureur,
			@sLibAssureur,
			@sLibPolice,
			@sTypAppSin,
			@sLibTypAppSin,
			@sMarqAppSin,
			@sModlAppSin,
			@sRefAppSin,
			@sNumTelSin,
			@mtValAchat,
			@mtPriseEnCharge,
			@dtDateAchat,
			@sEtatAppSin,
			@sCodeVerrou,
			@sDesimlocke,
			@sInfo_spb_frn_cplt

		If @iRet = -1 
		  Begin
			Update  sysadm.commande
			Set		id_lot_cmd = -1, cmd_gen_le = GETDATE(), cmd_gen_par = 'HUB'
			Where   id_sin = @adcIdsin
			And		id_seq = @aiIdSeq

			 RAISERROR ('Retour erreur du Hub Prestataire PS_HP276_I_HP_VALIDATION_PRESTA_DANS_LE_HUB_PRESTATAIRE', 16, 1, @DBID, @DBNAME)
			 Return
		  End 

	 End
	Else
	-- test SIMPA2
	 Begin
		Exec @iRet = sysadm.PS_HP276_I_HP_CREATION_PRESTA_DANS_LE_HUB_PRESTATAIRE 
			@aiCas,
			@sIdHubPresta,
			@sPointService,
			@sModeProcess,
			@sCodePickUp,
			@sAdrNomPickUp,
			@sAdrReferenceAssPickUp,
			@sAdr1PickUp,
			@sAdr2PickUp,
			@sAdrCpltPickUp,
			@sAdrCpPickUp,
			@sAdrVillePickUp

			If @iRet = -1 
			  Begin
				Update  sysadm.commande
				Set		id_lot_cmd = -1, cmd_gen_le = GETDATE(), cmd_gen_par = 'HUB'
				Where   id_sin = @adcIdsin
				And		id_seq = @aiIdSeq

				 RAISERROR ('Retour erreur du Hub Prestataire PS_HP276_I_HP_CREATION_PRESTA_DANS_LE_HUB_PRESTATAIRE', 16, 1, @DBID, @DBNAME)
				 Return
			  End 

		Exec @iRet = sysadm.PS_HP276_I_HP_VALIDATION_PRESTA_DANS_LE_HUB_PRESTATAIRE 
			@aiCas,
			@iIdSin,
			@aiIdSeq,
			@dtDeposeLe,
			@sDeposePar,
			@sAltTrt,
			@dtTraiteLe,
			@sTraitePar,
			@sIdHubPresta,
			@sIdFour,
			@sTypDommage,
			@sPointService,
			@sModeProcess,
			@sCodePickUp,
			@sAdrNomPickUp,
			@sAdrReferenceAssPickUp,
			@sAdr1PickUp,
			@sAdr2PickUp,
			@sAdrCpltPickUp,
			@sAdrCpPickUp,
			@sAdrVillePickUp,
			@iCodeProcess,
			@sLibCodeProcess,
			@iIdGti,
			@sLibPersoGti,
			@iIdDetail,
			@iIdProd,
			@sLibProd,
			@sIdProdAdh,
			@iIdEts,
			@sIdAdh,
			@iIdSdos,
			@sIdTypArt,
			@iCodCivLivr,
			@sLibCivLivrCourt,
			@sLibCivLivrLong,
			@IdContratAbonne,
			@NomAss,
			@PrenomAss,
			@NomLivr,
			@PrenomLivr,
			@sAdr1Livr,
			@sAdr2Livr,
			@sAdr3Livr,
			@sAdrCpLivr,
			@sAdrVilleLivr,
			@sNumTel1Ass,
			@sNumTel2Ass,
			@sNumTel3Ass,
			@sMailAssure,
			@sNumImeiAppSin,
			@sNumSerieAppSin,
			@sDescriptionProbleme,
			@sCodEtat,
			@dtValideLe,
			@sValidePar,
			@dtCmdGenLe,
			@sIdRefFour,
			@sOrdreAction,
			@iIdAssureur,
			@sLibAssureur,
			@sLibPolice,
			@sTypAppSin,
			@sLibTypAppSin,
			@sMarqAppSin,
			@sModlAppSin,
			@sRefAppSin,
			@sNumTelSin,
			@mtValAchat,
			@mtPriseEnCharge,
			@dtDateAchat,
			@sEtatAppSin,
			@sCodeVerrou,
			@sDesimlocke,
			@sInfo_spb_frn_cplt

		If @iRet = -1 
		  Begin
			Update  sysadm.commande
			Set		id_lot_cmd = -1, cmd_gen_le = GETDATE(), cmd_gen_par = 'HUB'
			Where   id_sin = @adcIdsin
			And		id_seq = @aiIdSeq

			 RAISERROR ('Retour erreur du Hub Prestataire PS_HP276_I_HP_VALIDATION_PRESTA_DANS_LE_HUB_PRESTATAIRE', 16, 1, @DBID, @DBNAME)
			 Return
		  End 

	 End
END 



Go
*/

-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_I_HP_CREATION_PRESTA_DANS_LE_HUB_PRESTATAIRE
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :      Créér la prestation dans le HUB
--                              /!\ A COMPILER SUR LA BASE PRESTATAIRE /!\
--
--								Prévoir de changer le schéma sysdam en [edi] pour la compil sur la base du HUB
--
-- Retourne             :       rien
-------------------------------------------------------------------
/*
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_I_HP_CREATION_PRESTA_DANS_LE_HUB_PRESTATAIRE' AND type = 'P' )
        DROP procedure sysadm.PS_HP276_I_HP_CREATION_PRESTA_DANS_LE_HUB_PRESTATAIRE
GO

CREATE procedure sysadm.PS_HP276_I_HP_CREATION_PRESTA_DANS_LE_HUB_PRESTATAIRE
	    @aiCas				Tinyint,
		@asIdHubPresta		VarChar ( 20 ),
		@asPointService		VarChar ( 20 ),
		@asModeProcess		VarChar ( 20 ),
		@asCodePickUp		VarChar ( 20 ),
		@asAdrNomPickUp		VarChar ( 40 ),
		@asAdrReferenceAssPickUp VarChar ( 40 ),
		@asAdr1PickUp VarChar ( 40 ),
		@asAdr2PickUp VarChar ( 40 ),
		@asAdrCpltPickUp VarChar ( 40 ),
		@asAdrCpPickUp VarChar ( 5 ),
		@asAdrVillePickUp VarChar ( 40 )
AS
-----------------------------------------------------------------------
-- Cas Test Pour JF sur la base SIMPA2, Retour en dur (bouchon)      --
-- /!\ A laisser !													 --
-----------------------------------------------------------------------
If @aiCas = 1
  Begin
	Select 'TOTO'
	Return 1
  End

-------------------------------------------------------------------
-- Cas réél pour Boulenouar, Insert Réél sur la base HUB Presta  --
-- Retour 1 si Traitement par BLN Ok							 --
-- Retour -1 si Traitement par BLN KO							 --
-------------------------------------------------------------------
If @aiCas in ( 2, 3 )
  Begin
	Select 'TOTO'

	Traitement réél des données par Boulenouar

	-- Return 1
	-- Return -1

  End
Go
*/

-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_U_S2_MAJ_GEN_PRESTA
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Mets à jour la prestation sur SIMPA2
--                              /!\ A COMPILER SUR LA BASE SIMPA2 /!\
--
-- Retourne             :       rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_U_S2_MAJ_GEN_PRESTA' AND type = 'P' )
        DROP procedure sysadm.PS_HP276_U_S2_MAJ_GEN_PRESTA
GO

CREATE procedure sysadm.PS_HP276_U_S2_MAJ_GEN_PRESTA
		@adcIdSin				Decimal ( 10 ),
		@alIdSeq				Integer,
		@alIdentityHubPresta	Integer

AS

Update	sysadm.commande 
Set		id_lot_cmd  = 999800, 
		cmd_gen_le = GETDATE(), 
		cmd_gen_par = 'HUB',
		info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'HP_IDENTITY', convert ( VarChar ( 20) , @alIdentityHubPresta ), RTRIM ( ltrim ( info_spb_frn_cplt )), ';')
Where   id_sin = @adcIdSin
And		id_seq = @alIdSeq

Go



