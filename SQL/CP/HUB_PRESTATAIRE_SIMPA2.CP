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

Update	sysadm.w_commande 
Set		info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'HP_IDENTITY', convert ( VarChar ( 20) , @alIdentityHubPresta ), RTRIM ( ltrim ( info_spb_frn_cplt )), ';')
Where   id_sin = @adcIdSin
And		id_seq = @alIdSeq

Go


-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_SU_S2_MOTEUR_TRT_RETOUR_HUB
-- Auteur               :       JFF
-- Date                 :       24/04/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Mets à jour la prestation sur SIMPA2 en retour du HUB
--                              /!\ A COMPILER SUR LA BASE SIMPA2 /!\
--
-- Retourne             :       rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_SU_S2_MOTEUR_TRT_RETOUR_HUB' AND type = 'P' )
        DROP procedure sysadm.PS_HP276_SU_S2_MOTEUR_TRT_RETOUR_HUB
GO

CREATE procedure sysadm.PS_HP276_SU_S2_MOTEUR_TRT_RETOUR_HUB
AS

Declare  @TbFourn TABLE (
	id_work						int IDENTITY (1,1)			NOT NULL, -- Id Local Tempo
	marquage					int							Null,
	id_four						VarChar ( 3 )				NULL,
	id_work_row_min				int							Null,
	id_work_row_max				int							Null
)

Declare  @TbHubToSimpa2Work TABLE (
	id_work						int IDENTITY (1,1)			NOT NULL, -- Id Local Tempo
	marquage					int							Null,
	id_depot_hub				int							NOT NULL, -- Identifiant non modifiable de dépot, contrôle des trou/blanc si Delete Malveillant
	depose_le					DateTime					NULL,	-- Enregistrement déposé par Simpa2 le 
	id_sin						Decimal ( 10 )				NULL,  
	id_seq						int							NULL,  
	id_four						VarChar ( 3 )				NULL,
	id_hub_presta				VarChar ( 20 )			NOT NULL,   -- Identifiant sur le Hub Prestataire de la prestation
	num_cmd_frn					VarChar ( 50 )				NULL,   -- Numéro de la prestation chez le prestataire
	status_code					VarChar ( 2 )				NULL,   -- Code HUB
	return_code					Varchar ( 50 )				NULL,	-- Code HUB
	reason_code					Varchar ( 50 )				NULL,	-- Code HUB
	typ_ba_aller				Varchar ( 35 )				NULL,	-- RPICKUP ou BPPAYE, voire de nouveaux CODE
	perte_aller					VarChar ( 1  )				NULL,   -- O/N Perte du colis à l'aller
	diag_video_engage			VarChar ( 1  )				NULL,   -- O/N Diag vidéo engagé
	resolu_diag_video			VarChar ( 1  )				NULL,   -- O/N résolu par Diag vidéo 
	dte_rdv_conf				DateTime					NULL,   -- Date de rdv confirmé pour déplacement à domicile 
	assure_en_prox				VarChar ( 1  )				NULL,   -- O/N Confirmation du prestataire, l'assuré s'est réellement rendu en proximité
	nom_prox					VarChar ( 40 )				NULL,   -- Si assure_en_prox='O' alors, le prestataire donne le nom de la boutique de proximité
	code_prox					VarChar ( 35 )  			NULL,   -- Code (numéro) de la boutique de proximité
	assure_env_central			VarChar ( 1  )				NULL,   -- O/N Confirmation du prestataire, l'assuré a envoyé son colis en centralisation
	dte_rcp_frn					DateTime					NULL,   -- Date de réception de l'appareil chez le prestataire
	site_action					VarChar ( 20 )				NULL,   -- STATION/DOMICILE
	app_incomplet				VarChar ( 1  )				NULL,   -- O/N si appareil incomplet
	num_imei_rempl				VarChar ( 20 )				NULL,	-- Numéro IMEI de remplacement (pour TEL)
	num_serie_rempl				VarChar ( 60 )				NULL,	-- Numéro SERIE de remplacement (pour autre que TEL)
	dte_fin_trait				DateTime					NULL,   -- Date de fin de traitement/Date d'envoi colis retour vers assuré
	comment_frn					VarChar ( 255 )				NULL,   -- Commentaire fournisseur
	num_bon_trp					VarChar ( 35 )				NULL,   -- Numéro de colis retour 
	nom_transporteur			VarChar ( 35 )				NULL,   -- NOm du transporteur
	dte_rcp_app_cli				DateTime					NULL,   -- Date de réception de l'appareil par l'assuré
	app_swap					VarChar ( 1  )				NULL,   -- O/N swap sur réparation (app irrep couvert et le presta redonne auto un app de rempl)
	marque_rempl				VarChar ( 35 )				NULL,   -- Marque de remplacement (sur SWAP ou Cmde Manuelle)
	modele_rempl				VarChar ( 35 )				NULL,   -- Modele de remplacement (sur SWAP ou Cmde Manuelle)
	couleur_rempl				VarChar ( 35 )				NULL,   -- Couleur de remplacement (sur SWAP ou Cmde Manuelle)
	cap_stk_rempl				VarChar ( 35 )				NULL,   -- Capacité de stockage de remplacement (sur SWAP ou Cmde Manuelle)
	neuf_recond_rempl			VarChar ( 10 )				NULL,	-- NEU/REC app de remplacement (sur SWAP ou Cmde Manuelle) Neuf ou Reconditionné
	prix_ttc_public				Decimal ( 11, 2 )			NULL,   -- Prix TTC de l'app de remplacement qui sera facturé par le prestataire et réglé par spb
	prble_livraison				VarChar ( 35 )				NULL,   -- après une dte_fin_trait renseigné, Code du problème de livraison
	pec_prble_livraison			VarChar ( 1  )				NULL,   -- O/N OUI si le presta prend la prble de livrasion à sa charge
	info_frn_spb_cplt			VarChar ( 800 )				NULL    -- Chaine sérialisée contenant de multiples informations pour de nouvelles données "exotiques" liées à un prestataire précis.
)

Declare @sInstanceHub		VarChar ( 100 ) 
Declare @sSql				Varchar ( 2000 )
Declare @sEnv				VarChar ( 10 )
Declare @iIdLotTrc			Int
Declare @iRowCountData		Int	
Declare	@iIdWorkFrn			Int
Declare	@iAMUerrRowTrt		Int
Declare	@iAMUerrFrn			Int
Declare	@iAMUunRowEcrFrn	Int
Declare	@idWorkRowMin		Int
Declare	@idWorkRowMax		Int
Declare	@iCptIdWorkRow		Int
Declare	@sChaineIdFour		Varchar ( 250 )
Declare	@iHandleObjet		Int 
Declare @sDestErrTech  VarChar ( 200 ) 
Declare @sDestErrCoherenceHub  VarChar ( 200 ) 
Declare @sMailBody VarChar ( 8000 )
Declare @sObjet VarChar ( 255 ) 
Declare @sMsgTrc varchar ( 255 ) 
Declare @sRetourErrMail VarChar ( 255 )
Declare @sFicOut VarChar ( 255 )
Declare @sDateHeureDebTrt VarChar ( 30 )
Declare @iRet Int
Declare @sCheminDepotFichierMPR VarChar ( 255 )
Declare @sInfoFrnSpbCpltCree VarChar ( 800 )
Declare @sEnregistrementFicMPR VarChar ( max )
Declare @sSepChampsFinMPR VarChar ( 10 )
Declare @iStatusGC Int
Declare @sDestCc VarChar ( 200 )
Declare @sNomFicMPRwork VarChar ( 255 ) 
Declare @sChemFicWork VarChar ( 255 ) 
Declare @iCptIndice Int
Declare @iFileExists Int

Set @iAMUerrRowTrt = 0 
Set @iAMUunRowEcrFrn = 0
Set @iAMUerrFrn = 0
Set @sInfoFrnSpbCpltCree = ''
Set @sEnregistrementFicMPR = ''
Set @sSepChampsFinMPR = CHAR ( 9 ) -- Tabulation
Set @sCheminDepotFichierMPR = ''

Declare @iIdWorkRow			int,
		@iIdDepotHub		int,
		@dtDeposeLe			DateTime,
		@dcIdSin			Decimal ( 10 ),
		@iIdSeq				int,
		@sIdFour			VarChar ( 10 ),
		@sIdHubPresta		VarChar ( 20 ),
		@sNumCmdFrn			VarChar ( 50 ),
		@sStatusCode		VarChar ( 2 ),
		@sReturnCode		Varchar ( 50 ),
		@sReasonCode		Varchar ( 50 ),
		@sTypBaAller		Varchar ( 35 ),
		@sPerteAller		VarChar ( 1  ),
		@sDiagVideoEngage	VarChar ( 1  ),
		@sResoluDiagVideo	VarChar ( 1  ),
		@dtDteRdvConf		DateTime,
		@sAssureEnProx		VarChar ( 1  ),
		@sNomProx			VarChar ( 40 ),
		@sCodeProx			VarChar ( 35 ),
		@sAssureEnvCentral	VarChar ( 1  ),
		@dtDteRcpFrn		DateTime,
		@sSiteAction		VarChar ( 20 ),
		@sAppIncomplet		VarChar ( 1  ),
		@sNumImeiRempl		VarChar ( 20 ),
		@sNumSerieRempl		VarChar ( 60 ),
		@dtDteFinTrait		DateTime,
		@sCommentFrn		VarChar ( 255 ),
		@sNumBonTrp			VarChar ( 35 ),
		@sNomTransporteur	VarChar ( 35 ),
		@dtDteRcpAppCli		DateTime,
		@sAppSwap			VarChar ( 1  ),
		@sMarqueRempl		VarChar ( 35 ),
		@sModeleRempl		VarChar ( 35 ),
		@sCouleurRempl		VarChar ( 35 ),
		@sCapStkRempl		VarChar ( 35 ),
		@sNeufRecondRempl	VarChar ( 10 ),
		@dcPrixTtcPublic	Decimal ( 11, 2 ),
		@sPrbleLivraison	VarChar ( 35 ),
		@sPecPrbleLivraison	VarChar ( 1  ),
		@sInfoFrnSpbCpltlu	VarChar ( 800 )

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Set @sInstanceHub = '[LS-SAGA2].[PRESTATAIRE].'
		Set @sEnv = 'PROD'
		Set @sCheminDepotFichierMPR = '\\F4T\SIMPA2\'
	END 
ELSE
	BEGIN
		Set @sInstanceHub = '[S2SQL14PP1\PPRSAGA2].[PRESTATAIRE].'
		Set @sEnv = 'SIM'
		Set @sCheminDepotFichierMPR = '\\SPB.LAN\APPLIS\SPB\RECCMD\'
	END 

---------------------------------
-- Initialisation de la Trace  --
---------------------------------
If @sEnv = 'PROD'
	Begin 
		Exec [LS-SAGA2].[PRESTATAIRE].edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 'OBTENTION_ID_LOT_TRC', -1, '-1', '', '', @iIdLotTrc output
		Set @sDestErrTech = 'cbourdoiseau@spb.eu,cfrappat@spb.eu,VANDRE@spb.eu,BKHELIFA_ext@spb.eu'
		Set @sDestErrCoherenceHub = 'VANDRE@spb.eu,BKHELIFA_ext@spb.eu'
		Set @sDestCc = 'jff@spb.fr'
	End 
Else
	Begin 
		Exec [S2SQL14PP1\PPRSAGA2].[PRESTATAIRE].edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 'OBTENTION_ID_LOT_TRC', -1, '-1', '', '', @iIdLotTrc output
		Set @sDestErrTech = 'jff@spb.fr'
		Set @sDestErrCoherenceHub = 'jff@spb.fr'
		Set @sDestCc = 'jff@spb.fr'
	End

Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''-1'', -1, ''-1'', ''OK'', '''+ 
			'Lancement du traitement le ' + Convert ( VarChar ( 10), Getdate(), 103 ) + ' à ' + CONVERT (varchar(8), getdate(), 108) + 
			''', ' + Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )

Set @sDateHeureDebTrt = Convert ( varchar ( 10 ), GETDATE(), 103 ) + ' ' + Left ( Convert ( varchar ( 30 ), GETDATE(), 114 ), 6 ) + '00'

-------------------------------
-- Récupération des données  --
-------------------------------
Set @sSql = 
'Select ' + 
'		0, '+
'		dhs.id_depot_hub, '+
'		dhs.depose_le, '+
'		dsh.id_sin, '+
'		dsh.id_seq, '+
'		dsh.id_four, '+
'		dhs.id_hub_presta, '+
'		dhs.num_cmd_frn, '+
'		dhs.status_code, '+
'		dhs.return_code, '+
'		dhs.reason_code, '+
'		dhs.typ_ba_aller, '+
'		dhs.perte_aller, '+
'		dhs.diag_video_engage, '+
'		dhs.resolu_diag_video, '+
'		dhs.dte_rdv_conf, '+
'		dhs.assure_en_prox, '+
'		dhs.nom_prox, '+
'		dhs.code_prox, '+
'		dhs.assure_env_central, '+
'		dhs.dte_rcp_frn, '+
'		dhs.site_action, '+
'		dhs.app_incomplet, '+
'		dhs.num_imei_rempl, '+
'		dhs.num_serie_rempl, '+
'		dhs.dte_fin_trait, '+
'		dhs.comment_frn, '+
'		dhs.num_bon_trp, '+
'		dhs.nom_transporteur, '+
'		dhs.dte_rcp_app_cli, '+
'		dhs.app_swap, '+
'		dhs.marque_rempl, '+
'		dhs.modele_rempl, '+
'		dhs.couleur_rempl, '+
'		dhs.cap_stk_rempl, '+
'		dhs.neuf_recond_rempl, '+
'		dhs.prix_ttc_public, '+
'		dhs.prble_livraison, '+
'		dhs.pec_prble_livraison, '+
'		dhs.info_frn_spb_cplt '+
'From	' + @sInstanceHub + 'edi.DepotHubToSimpa2Presta dhs ' + 
'		Left Outer Join ' + @sInstanceHub + 'edi.DepotSimpa2ToHubPresta dsh on dhs.id_hub_presta = dsh.id_hub_presta ' +
'Where   dhs.alt_trt = ''N'' ' +
'Order by dsh.id_four, dhs.depose_le '

Insert into @TbHubToSimpa2Work Exec ( @sSql ) -- ;Select * from @TbHubToSimpa2Work
Set @iRowCountData = @@ROWCOUNT

Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''-1'', -1, ''-1'', ''OK'', ''' + 
			'Récupération par SIMPA2 de ' + Convert ( Varchar ( 20 ), @iRowCountData  ) + ' enregistrements de suivi/retour provenant du HUB.' +
			''', ' + Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )

---------------------------------------
-- Pas de données, fin de traitement --
---------------------------------------
IF @iRowCountData <= 0 
	Begin
		Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''-1'', -1, ''-1'', ''OK'', ''' +
		'Fin du traitement le ' + Convert ( VarChar ( 10), Getdate(), 103 ) + ' à ' + CONVERT (varchar(8), getdate(), 108) + 
		''', ' + Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )
		Return 
	End 

-----------------------------
-- Trace des frn concernés --
-----------------------------
Insert into @TbFourn 
Select Distinct 
		0, 
		T1.id_four,
		IsNull ( ( Select MIN ( id_work ) From @TbHubToSimpa2Work T2 where T2.id_four = T1.id_four ) , 0 ),
		IsNull ( ( Select MAX ( id_work ) From @TbHubToSimpa2Work T2 where T2.id_four = T1.id_four ) , 0 )
From @TbHubToSimpa2Work T1
Set @iRowCountData = @@ROWCOUNT

If @iRowCountData > 0 
	Begin
		Select @sChaineIdFour = Stuff ( ( SELECT CAST(rtrim ( id_four) + ', ' AS VARCHAR(250)) FROM @TbFourn For XML PATH ('') ) , 1, 2, '' )
		Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''-1'', -1, ''-1'', ''OK'', ''' + 
		Convert ( Varchar ( 20 ), @iRowCountData  ) + ' Prestataire(s) concerné(s) : ' + @sChaineIdFour + 
		''', ' + Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )
	End 

---------------------------
-- Moteur de traitement  --
---------------------------
Exec @iHandleObjet = sysadm.PS_INSTANCIER_UN_OBJET_SQL_SERVER 'ADODB.Stream'

-- Traitement d'une Erreur pontentiel d'instanciation
If @iHandleObjet < 0 
	Begin
		Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', -1, ''-1'', ''ERR'', ''' +
		'Erreur lors de l''instanciation de l''objet SqlServer ADODB.Stream, le traitement est arrêté à ' + Convert ( VarChar ( 10), Getdate(), 103 ) + ' à ' + CONVERT (varchar(8), getdate(), 108) + 
		''', ' + Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )

		Set @sObjet = '[ALERTE] [Traitement_SIMPA2_HUB_PRESTATAIRE] => Instanciation objet ADODB.Stream impossible'

		Set @sObjet = Left ( @sObjet + space ( 255 ), 255 )
		Exec sysadm.PS_CASSER_REGLE_CHAINE @sObjet Output, '_', ' ' 

		Set @sMailBody = 'Bonjour ' + char (10)
		Set @sMailBody = @sMailBody + char (10)
		Set @sMailBody = @sMailBody + 'Serveur : ' + @@SERVERNAME 
		If @@SERVERNAME = 'SQL14SINISTRES\SINISTRES' Set @sMailBody = @sMailBody + ' (Alias [LS-SINISTRES])' + char (10)		
		Set @sMailBody = @sMailBody + 'base SIMPA2 : ' + DB_NAME () + char (10)
		Set @sMailBody = @sMailBody + 'Instance et base HUB PRESTATAIRE : ' + @sInstanceHub + char (10)
		Set @sMailBody = @sMailBody + char (10)
		Set @sMailBody = @sMailBody + 'Contexte de l''erreur : L''objet SqlServer ADODB.Stream ne peut plus s''intancier, la conséquence est que les retours de prestations du Hub Prestataires ne peuvent plus traités par SIMPA2.' + char (10)
		Set @sMailBody = @sMailBody + char (10)
		Set @sMailBody = @sMailBody + 'Une des causes possibles :' + char (10)
		Set @sMailBody = @sMailBody + '- Une soirée patch la veille a pu faire sauter le droit d''instanciation de cet objet OLE SqlServer lors d''un reboot du serveur qui s''est mal terminé (par exemple).' + char (10)
		Set @sMailBody = @sMailBody + '  Le code suivant peut rétablir ce droit, à jouer par INFRA.' + char (10)
		Set @sMailBody = @sMailBody + '    exec sp_configure ''Ole Automation Procedures'', 1 ' + char (10)
		Set @sMailBody = @sMailBody + '    RECONFIGURE' + char (10)
		Set @sMailBody = @sMailBody + char (10)
		Set @sMailBody = @sMailBody + 'Vérifier l''action en jouant : '+ char (10)
		Set @sMailBody = @sMailBody + 'exec sp_configure ''Ole Automation Procedures'''+ char (10)
		Set @sMailBody = @sMailBody + 'la valeur config_value doit être à 1 (activée) à présent' + char (10)
		Set @sMailBody = @sMailBody + CHAR ( 10 )
		Set @sMailBody = @sMailBody + '- Sinon vérifiez les actions SQL récemment engagées par l''équipe INFRA sur ' + @@Servername  
		If @@SERVERNAME = 'SQL14SINISTRES\SINISTRES' Set @sMailBody = @sMailBody + ' (Alias [LS-SINISTRES])'
		Set @sMailBody = @sMailBody + ' .' + CHAR ( 10 )
		Set @sMailBody = @sMailBody + '  Consultez la trace du traitement avec ces 2 Select pour voir depuis quand le problème se produit ' + CHAR ( 10 )
		Set @sMailBody = @sMailBody + CHAR ( 10 )
		Set @sMailBody = @sMailBody + '  Select * from ' + @sInstanceHub + 'edi.TraceRecupRetourParSimpa2  where cod_etat = ''ERR'' and cree_le > ''' + @sDateHeureDebTrt + ''' order by 1' + CHAR ( 10 )
		Set @sMailBody = @sMailBody + '  Select * from ' + @sInstanceHub + 'edi.TraceRecupRetourParSimpa2  where cree_le > ''' + @sDateHeureDebTrt + ''' order by 1 desc' + CHAR ( 10 )
		Set @sMailBody = @sMailBody + CHAR ( 10 )
		Set @sMailBody = @sMailBody + 'L''alerte reviendra au prochain traitement tant que le problème ne sera pas résolu.' + CHAR ( 10 )
		Set @sMailBody = @sMailBody + CHAR ( 10 )
		Set @sMailBody = @sMailBody + 'Cordialement,'
		Set @sMailBody = @sMailBody + CHAR ( 10 )
		Set @sMailBody = @sMailBody + CHAR ( 10 )
		Set @sMailBody = @sMailBody + 'Fabry Jean-François'
		Set @sMailBody = @sMailBody + CHAR ( 10 )
		Set @sMailBody = @sMailBody + 'DSI Team SIMPA2' + CHAR ( 10 )
		Set @sMailBody = @sMailBody + 'Legacy Application Tech Lead' + CHAR ( 10 )


		EXEC master.dbo.SPB_PS_MAIL 
				@sRetourErrMail OUTPUT, 
				@sDestErrTech ,
				@sMailBody, 
				@sObjet, 
				null, 
				@sDestCc, 
				@sFicOut, 
				NULL, 
				NULL, 
				NULL, 
				NULL

		Return
	End 

-- Pour tout fournisseur....
While Exists ( Select Top 1 1 From @TbFourn where marquage = 0 )
 Begin
	Select Top 1 
		@iIdWorkFrn = id_work,
		@sIdFour	= id_four,
		@idWorkRowMin = id_work_row_min,
		@idWorkRowMax = id_work_row_max
	From  @TbFourn where marquage = 0

	Set @iAMUerrFrn = 0
	Set @iAMUunRowEcrFrn = 0
	Set @iCptIdWorkRow = @idWorkRowMin


	-- Le code fournisseur existe-t-il sur SIMPA2 ?
	If Not Exists ( 
			Select Top 1 1 
			From sysadm.code_car cc
			Where cc.id_typ_code = '-FR'
			And   cc.id_code = @sIdFour
		)
		Begin
			Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''' + ISNULL ( @sIdFour, '(vide)') + ''', -1, ''-1'', ''ERR'', ''' + 
			'Le code fournisseur ' + ISNULL ( @sIdFour, '(vide)') + ' donné par le Hub Prestataire n''''existe pas sur SIMPA2.' + ''', ' + 
			Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )

			Set @iAMUerrFrn = 1
			Update @TbFourn Set marquage = -1 Where id_work = @iIdWorkFrn			
			Continue
		End 

	-- Le nom du répertoire fournisseur existe-t-il sur SIMPA2 ?
	If Not Exists ( 
			Select Top 1 1 
			From sysadm.code_car cc
			Where cc.id_typ_code = '-FL'
			And   cc.id_code = @sIdFour
		)
		Begin
			Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''' + ISNULL ( @sIdFour, '(vide)') + ''', -1, ''-1'', ''ERR'', ''' + 
			'Le répertoire du fournisseur ' + ISNULL ( @sIdFour, '(vide)') + ' n''''existe pas sur SIMPA2.' + ''', ' + 
			Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )

			Set @iAMUerrFrn = 1
			Update @TbFourn Set marquage = -1 Where id_work = @iIdWorkFrn			
			Continue
		End 

	-- Construction du chemin de dépôt
	Select @sCheminDepotFichierMPR = @sCheminDepotFichierMPR + LTRIM ( rtrim ( cc.lib_code )) + '\fic_cmd\'
	From sysadm.code_car cc
	Where cc.id_typ_code = '-FL'
	And   cc.id_code = @sIdFour

	-- Compléter le chemin avec le nom du fichier MPR
	Set @iCptIndice = 1
	While 1=1
		Begin
			Set @sNomFicMPRwork = 'MPR' + Replace ( Convert ( Varchar ( 10 ), Getdate (), 103 ), '/', '') + '.' + Right ( REPLICATE ( '0', 3 ) + CONVERT ( VarChar ( 3 ), @iCptIndice ), 3 )
			Set @sChemFicWork = @sCheminDepotFichierMPR + @sNomFicMPRwork
			
			EXECUTE xp_fileexist @sChemFicWork, @iFileExists OUTPUT
			
			If @iFileExists > 0 
				Begin 
					Set @iCptIndice = @iCptIndice + 1
					Continue
				End 

			Set @sCheminDepotFichierMPR = @sCheminDepotFichierMPR + @sNomFicMPRwork
			Break
		End 

	-- Ouverture du fichier de charset ISO-8859-1
	Exec @iRet = sysadm.PS_ECRIRE_UN_ENREGISTREMENT_ADODB_STREAM_V03 @iHandleObjet, 1, 0, 2, 3, 'ISO-8859-1', 13, null, null

	If @iRet <> 0 
		Begin
			Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''' + ISNULL ( @sIdFour, '(vide)') + ''', -1, ''-1'', ''ERR'', ''' + 
			'Erreur lors de l''''ouverture/création (open) du fichier (' + IsNull ( @sIdFour, '(vide)') + ', Handle objet ' + CONVERT ( Varchar ( 20 ), @iHandleObjet ) +'.' + 
			''', ' +  Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )

			Set @iAMUerrFrn = 1
			Update @TbFourn Set marquage = -1 Where id_work = @iIdWorkFrn			
			Continue
		End 

	-- Pour tout enregistrement de ce fournisseur
	While Exists ( Select Top 1 1 From @TbHubToSimpa2Work where marquage = 0 And id_four = @sIdFour And @iCptIdWorkRow between @idWorkRowMin and @idWorkRowMax )
	 Begin
		Set @iAMUerrRowTrt = 0

		Select 	Top 1 
			@iIdWorkRow = id_work,
			@iIdDepotHub = id_depot_hub,
			@dtDeposeLe = depose_le,
			@dcIdSin = id_sin,
			@iIdSeq = id_seq,
			@sIdHubPresta = ltrim ( rtrim ( id_hub_presta )),
			@sNumCmdFrn = ltrim ( rtrim ( num_cmd_frn )),
			@sStatusCode = ltrim ( rtrim ( status_code )),
			@sReturnCode = ltrim ( rtrim ( return_code )),
			@sReasonCode = ltrim ( rtrim ( reason_code )),
			@sTypBaAller = ltrim ( rtrim ( typ_ba_aller )),
			@sPerteAller = ltrim ( rtrim ( perte_aller )),
			@sDiagVideoEngage = ltrim ( rtrim ( diag_video_engage )),
			@sResoluDiagVideo = ltrim ( rtrim ( resolu_diag_video )),
			@dtDteRdvConf = dte_rdv_conf,
			@sAssureEnProx = ltrim ( rtrim ( assure_en_prox )),
			@sNomProx = ltrim ( rtrim ( nom_prox )),
			@sCodeProx = ltrim ( rtrim ( code_prox )),
			@sAssureEnvCentral = ltrim ( rtrim ( assure_env_central )),
			@dtDteRcpFrn = dte_rcp_frn,
			@sSiteAction = ltrim ( rtrim ( site_action )),
			@sAppIncomplet = ltrim ( rtrim ( app_incomplet )),
			@sNumImeiRempl = ltrim ( rtrim ( num_imei_rempl )),
			@sNumSerieRempl = ltrim ( rtrim ( num_serie_rempl )),
			@dtDteFinTrait = dte_fin_trait,
			@sCommentFrn = ltrim ( rtrim ( comment_frn )),
			@sNumBonTrp = ltrim ( rtrim ( num_bon_trp )),
			@sNomTransporteur = ltrim ( rtrim ( nom_transporteur )),
			@dtDteRcpAppCli = dte_rcp_app_cli,
			@sAppSwap = ltrim ( rtrim ( app_swap )),
			@sMarqueRempl = ltrim ( rtrim ( marque_rempl )),
			@sModeleRempl = ltrim ( rtrim ( modele_rempl )),
			@sCouleurRempl = ltrim ( rtrim ( couleur_rempl )),
			@sCapStkRempl = ltrim ( rtrim ( cap_stk_rempl )),
			@sNeufRecondRempl = ltrim ( rtrim ( neuf_recond_rempl )),
			@dcPrixTtcPublic = prix_ttc_public,
			@sPrbleLivraison = ltrim ( rtrim ( prble_livraison )),
			@sPecPrbleLivraison = ltrim ( rtrim ( pec_prble_livraison )),
			@sInfoFrnSpbCpltlu = ltrim ( rtrim ( info_frn_spb_cplt ))
		From	@TbHubToSimpa2Work
		Where	marquage = 0
		And		id_work = @iCptIdWorkRow

		------------------------------------
		-- Contrôle principal des données --
		------------------------------------
		While 1=1
			Begin
				-- Le binôme id_sin/id_seq existe-il sur SIMPA2 ?
				If Not Exists ( 
						Select Top 1 1 
						From sysadm.commande c
						Where c.id_sin = @dcIdSin
						And   c.id_seq = @iIdSeq
					) And @iAMUerrRowTrt = 0
					Begin
						Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''' + ISNULL ( @sIdFour, '(vide)') + ''', ' + Convert ( VarChar (20), @iIdDepotHub) + ', ''' + @sIdHubPresta + ''', ''ERR'', ''' + 
						'La prestation ' + IsNull ( Convert ( Varchar ( 10 ), @dcIdSin ), '(vide)') + '-' + IsNull ( Convert ( Varchar ( 10 ), @iIdSeq ), '(vide)' ) + ' n''existe pas sur SIMPA2 (IdHubPresta=' + IsNull ( Convert ( Varchar ( 10 ), @sIdHubPresta ), '(vide) )') + '.' + 
						''', ' + Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )

						Set @iAMUerrRowTrt = 1
						Break
					End 

				-- Détermination du statut SIMPA2 de la prestation
				Set @iStatusGC = 0 -- [TODO] Fct ( @sStatusCode, @sReturnCode, @sReasonCode ) 
				If @iStatusGC <= 0 -- Au minimum 159 ou un statut 'en cours à créer' si non existant
					Begin
						Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''' + ISNULL ( @sIdFour, '(vide)') + ''', ' + Convert ( VarChar (20), @iIdDepotHub) + ', ''' + @sIdHubPresta + ''', ''ERR'', ''' + 
									'Les 3 données @sStatusCode, @sReturnCode, @sReasonCode ne permettent pas de déterminer/mapper un statut pour la prestation SIMPA2.' +
									''', ' + Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )

						Set @iAMUerrRowTrt = 1
						Break
					End 

				-- Détermination du problème de livraison
				-- Modifier la tableau pour mettre les 3 valeurs
				-- Supp de la zone de table prble_livraison
				-- Ajout des 3 autres zone activity_code, activity_return_code, activity_reason_code
				-- [TODO] @sPrbleLivraison = Fct ( activity_code, activity_return_code, activity_reason_code )
				Set @sPrbleLivraison = ''
				/*
				If Si @sPrbleLivraison = '' ET ( activity_code, activity_return_code, activity_reason_code ) no vide alors ERREUR
					Begin
						Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''' + ISNULL ( @sIdFour, '(vide)') + ''', ' + Convert ( VarChar (20), @iIdDepotHub) + ', ''' + @sIdHubPresta + ''', ''ERR'', ''' + 
									'Les 3 données @sStatusCode, @sReturnCode, @sReasonCode ne permettent pas de déterminer/mapper un statut pour la prestation SIMPA2.' +
									''', ' + Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )

						Set @iAMUerrRowTrt = 1
						Break
					End 
				*/

				Break
			End 
		------------------------------------------------------------------------
		-- Traitement principal des données, construction de l'enregistrement --
		------------------------------------------------------------------------
		If @iAMUerrRowTrt = 0
			Begin
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + Convert ( Varchar ( 10 ), @dcIdSin ) + '-' + Convert ( Varchar ( 10 ), @iIdSeq ) + @sSepChampsFinMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + @sIdFour + @sSepChampsFinMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sNumCmdFrn, '') + @sSepChampsFinMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @iStatusGC, '0') + @sSepChampsFinMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sTypBaAller, '') + @sSepChampsFinMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sPerteAller, '') + @sSepChampsFinMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sDiagVideoEngage, '') + @sSepChampsFinMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sResoluDiagVideo, '') + @sSepChampsFinMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( convert ( varchar(10), @dtDteRdvConf, 103 ) + ' ' + CONVERT (varchar(8), @dtDteRdvConf, 108), '') + @sSepChampsFinMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sAssureEnProx, '') + @sSepChampsFinMPR
				
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sNomProx, '') + @sSepChampsFinMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sCodeProx, '') + @sSepChampsFinMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sAssureEnvCentral, '') + @sSepChampsFinMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( convert ( varchar(10), @dtDteRcpFrn, 103 ) + ' ' + CONVERT (varchar(8), @dtDteRcpFrn, 108), '') + @sSepChampsFinMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sSiteAction, '') + @sSepChampsFinMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sAppIncomplet, '') + @sSepChampsFinMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sNumImeiRempl, '') + @sSepChampsFinMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sNumSerieRempl, '') + @sSepChampsFinMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( convert ( varchar(10), @dtDteFinTrait, 103 ) + ' ' + CONVERT (varchar(8), @dtDteFinTrait, 108), '') + @sSepChampsFinMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sCommentFrn, '') + @sSepChampsFinMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sNumBonTrp, '') + @sSepChampsFinMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sNomTransporteur, '') + @sSepChampsFinMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( convert ( varchar(10), @dtDteRcpAppCli, 103 ) + ' ' + CONVERT (varchar(8), @dtDteRcpAppCli, 108), '') + @sSepChampsFinMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sAppSwap, '') + @sSepChampsFinMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sMarqueRempl, '') + @sSepChampsFinMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sModeleRempl, '') + @sSepChampsFinMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sCouleurRempl, '') + @sSepChampsFinMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sCapStkRempl, '') + @sSepChampsFinMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sNeufRecondRempl, '') + @sSepChampsFinMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( convert ( varchar(20), @dcPrixTtcPublic ), '') + @sSepChampsFinMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sPrbleLivraison, '') + @sSepChampsFinMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sPecPrbleLivraison, '') + @sSepChampsFinMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sInfoFrnSpbCpltlu, '') + @sSepChampsFinMPR
			
			End 
		
		----------------------------------------
		-- Trt des erreurs                    --
		----------------------------------------

		-- AMU une erreur sur un row de ce fournisseur
		If @iAMUerrRowTrt = 1 
			Begin
		  		Update @TbHubToSimpa2Work Set marquage = -1 Where id_work = @iIdWorkRow
				Set @iAMUerrFrn = 1
				Set @iCptIdWorkRow = @iCptIdWorkRow + 1
				Continue
			End 

		-- Ecriture du row dans fichier
		Exec @iRet = sysadm.PS_ECRIRE_UN_ENREGISTREMENT_ADODB_STREAM_V03 @iHandleObjet, 0, 1, null, null, null, null, @sEnregistrementFicMPR, null

		If @iRet <> 0 
			Begin
				Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''' + ISNULL ( @sIdFour, '(vide)') + ''', ' + Convert ( VarChar (20), @iIdDepotHub) + ', ''' + @sIdHubPresta + ''', ''ERR'', ''' + 
				'Erreur lors de l''''écriture (writetexte) dans le fichier (' + IsNull ( @sIdFour, '(vide)') + ', Handle objet ' + CONVERT ( Varchar ( 20 ), @iHandleObjet ) +'.' + 
				''', ' +  Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )

		  		Update @TbHubToSimpa2Work Set marquage = -1 Where id_work = @iIdWorkRow
				Set @iAMUerrFrn = 1
				Set @iCptIdWorkRow = @iCptIdWorkRow + 1
				Continue
			End 

		---------------------------------------------
		-- Fin Trt de l'enregistrement sans erreur -- 
		---------------------------------------------
		Set @iAMUunRowEcrFrn = 1

		Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''' + ISNULL ( @sIdFour, '(vide)') + ''', ' + Convert ( VarChar (20), @iIdDepotHub) + ', ''' + @sIdHubPresta + ''', ''OK'', ''' + 
		'Enregistrement traité SOUS RESERVE de l''''écriture du fichier ' + @sCheminDepotFichierMPR + '.' +
		''', ' + Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )


		Update @TbHubToSimpa2Work Set marquage = 1 Where id_work = @iIdWorkRow
		Set @iCptIdWorkRow = @iCptIdWorkRow + 1

	 End -- Fin de "Pour tout enregistrement de ce fournisseur"

	 If @iAMUunRowEcrFrn = 1 And @iAMUerrFrn = 0
		Begin
			-- Sauvegarde et fermeture du fichier sur disque
			Exec @iRet = sysadm.PS_SAUVEGARDER_ET_FERMER_UN_FICHER_ADODB_STREAM @iHandleObjet, @sCheminDepotFichierMPR, 2

			If @iRet <> 0 
				Begin
					Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''' + ISNULL ( @sIdFour, '(vide)') + ''', -1, ''-1'', ''ERR'', ''' + 
					'Erreur lors de la sauvegarde et fermeture du fichier ' + IsNull ( @sCheminDepotFichierMPR, '(vide)') + ', Handle objet ' + CONVERT ( Varchar ( 20 ), @iHandleObjet ) +'.' + 
					''', ' +  Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )

					Set @iAMUerrFrn = 1
				End 
		End 

	 If @iAMUunRowEcrFrn = 1 And @iAMUerrFrn = 0
		Begin

			-- Pour tout enregistrement traités (et sav fic succès) de ce fournisseur 
			While Exists ( Select Top 1 1 From @TbHubToSimpa2Work where marquage = 1 And id_four = @sIdFour )
				Begin
					Select 	Top 1 
						@iIdWorkRow = id_work,
						@iIdDepotHub = id_depot_hub
					From	@TbHubToSimpa2Work
					Where	marquage = 1
					And		id_four = @sIdFour

					Set @sSql = 'Update ' + @sInstanceHub + 'edi.DepotHubToSimpa2Presta Set alt_trt = ''O'' where id_depot_hub = ' +  CONVERT ( Varchar ( 20 ), @iIdWorkRow ) ; Exec ( @sSql )

					Update @TbHubToSimpa2Work Set marquage = 2 Where id_work = @iIdWorkRow
				End 
		End 

	 If @iAMUerrFrn = 1
		Begin
			Set @sObjet = '[Traitement_SIMPA2_HUB_PRESTATAIRE] => Erreur dans le traitement lot ' + CONVERT ( Varchar ( 20 ), @iIdLotTrc )

			Set @sObjet = Left ( @sObjet + space ( 255 ), 255 )
			Exec sysadm.PS_CASSER_REGLE_CHAINE @sObjet Output, '_', ' ' 

			Set @sMailBody = 'Bonjour ' + char (10)
			Set @sMailBody = @sMailBody + char (10)
			Set @sMailBody = @sMailBody + 'Serveur : ' + @@SERVERNAME 
			If @@SERVERNAME = 'SQL14SINISTRES\SINISTRES' Set @sMailBody = @sMailBody + ' (Alias [LS-SINISTRES])' + char (10)		
			Set @sMailBody = @sMailBody + 'base SIMPA2 : ' + DB_NAME () + char (10)
			Set @sMailBody = @sMailBody + 'Instance et base HUB PRESTATAIRE : ' + @sInstanceHub + char (10)
			Set @sMailBody = @sMailBody + char (10) 
			Set @sMailBody = @sMailBody + 'Au moins une erreur s''est produite dans le traitement numéro ' + CONVERT ( Varchar ( 20 ), @iIdLotTrc ) + '.' + char (10) 
			Set @sMailBody = @sMailBody + char (10) 
			Set @sMailBody = @sMailBody + 'Consultez la trace du traitement avec ces 4 Select pour voir depuis quand le problème se produit ' + CHAR ( 10 )
			Set @sMailBody = @sMailBody + '  Select * from ' + @sInstanceHub + 'edi.TraceRecupRetourParSimpa2 where id_lot_trc = '+ CONVERT (VarChar ( 20), @iIdLotTrc ) + ' order by 1' + CHAR ( 10 ) 
			Set @sMailBody = @sMailBody + '  Select * from ' + @sInstanceHub + 'edi.TraceRecupRetourParSimpa2 where id_lot_trc = '+ CONVERT (VarChar ( 20), @iIdLotTrc ) + ' and cod_etat = ''ERR'' order by 1' + CHAR ( 10 ) 
			Set @sMailBody = @sMailBody + '  Select * from ' + @sInstanceHub + 'edi.TraceRecupRetourParSimpa2 where cod_etat = ''ERR'' and cree_le > ''' + @sDateHeureDebTrt + ''' order by 1' + CHAR ( 10 )
			Set @sMailBody = @sMailBody + '  Select * from ' + @sInstanceHub + 'edi.TraceRecupRetourParSimpa2 where cree_le > ''' + @sDateHeureDebTrt + ''' order by 1 desc' + CHAR ( 10 )
			Set @sMailBody = @sMailBody + CHAR ( 10 )
			Set @sMailBody = @sMailBody + 'Aucune n''a été perdue mais les mêmes erreurs reviendront au prochain traitement si vous ne les corrigez pas dans la table de dépôt edi.DepotHubToSimpa2Presta se trouvant sur le HUB, base PRESTATAIRE.' + CHAR ( 10 )
			Set @sMailBody = @sMailBody + CHAR ( 10 )
			Set @sMailBody = @sMailBody + 'Cordialement,'
			Set @sMailBody = @sMailBody + CHAR ( 10 )
			Set @sMailBody = @sMailBody + CHAR ( 10 )
			Set @sMailBody = @sMailBody + 'Fabry Jean-François'
			Set @sMailBody = @sMailBody + CHAR ( 10 )
			Set @sMailBody = @sMailBody + 'DSI Team SIMPA2' + CHAR ( 10 )
			Set @sMailBody = @sMailBody + 'Legacy Application Tech Lead' + CHAR ( 10 )

		EXEC master.dbo.SPB_PS_MAIL 
				@sRetourErrMail OUTPUT, 
				@sDestErrCoherenceHub ,
				@sMailBody, 
				@sObjet, 
				null, 
				@sDestCc, 
				@sFicOut, 
				NULL, 
				NULL, 
				NULL, 
				NULL

			Update @TbFourn Set marquage = -1 Where id_work = @iIdWorkFrn
			Continue
		End 

	 Update @TbFourn Set marquage = 1 Where id_work = @iIdWorkFrn

End -- Fin de "Pour tout fournisseur...."

-- Détruction de l'objet ADODB
If @iHandleObjet > 0 Exec @iRet = sysadm.PS_DETRUIRE_UN_OBJET_SQL_SERVER @iHandleObjet

Go

