-------------------------------------------------------------------
--
-- Fichier              :       HUB_PRESTATAIRE_HUB.CP
-- Auteur               :       JFF
-- Date                 :       11/03/2024
--
-- Commentaires         :       Gestion des PS SQL à compiler sur le HUB prestataire
--
-- Procédures           :       
-------------------------------------------------------------------
Use PRESTATAIRE
Go

-- create schema edi;
Go

If Exists ( Select Top 1 1 From sys.objects where name = 'parametre' and type = 'U' ) Drop Table edi.parametre

CREATE TABLE edi.parametre(
	[ref_cpt] [char](10) NOT NULL,
	[cpt_val] [decimal](10, 0) NOT NULL,
	[num_maj] [int] NOT NULL,
 CONSTRAINT [pk_parametre] PRIMARY KEY CLUSTERED 
(
	[ref_cpt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

Insert into [edi].[parametre] Values ( 'CPT_HUB', 0, -1 ) 


If Exists ( Select Top 1 1 From sys.objects where name = 'DepotSimpa2ToHubPresta' and type = 'U' ) Drop Table edi.DepotSimpa2ToHubPresta

CREATE TABLE edi.DepotSimpa2ToHubPresta(
	id_depot_simpa2				int IDENTITY(1,1)		NOT NULL,	-- Identifiant non modifiable de dépot, contrôle des trou/blanc si Delete Malveillant
	id_sin						int						NOT NULL,	-- Référence sinistre
	id_seq						int						NOT NULL,	-- numéro de la commande simpa2 pour ce sinistre
	depose_le					DateTime				NOT NULL,	-- Enregistrement déposé par Simpa2 le 
	depose_par					Char (4)				NOT NULL,	-- Enregistrement déposé par
	cpt_essai					integer					NOT NULL,   -- Compteur d'essai, à renseigner par le HUB
	essai_le					DateTime					NULL,   -- Date du dernier essai, à renseigner par le HUB
	alt_trt						Char (1)				NOT NULL,	-- Répère alternatif N(on)/E(n cours)/O(ui) des enregistrement pris en compte et traité par le HubP.
	traite_le					DateTime					NULL,	-- Traité par le Hub le
	traite_par					Char (4)					NULL,	-- traité par
	id_hub_presta				VarChar ( 20 )			NOT NULL,   -- Identifiant sur le Hub Prestataire de la prestation
	id_four						Char (3)				NOT NULL,   -- /!\ IMPORTANT : Code Fournisseur officiel SPB, ce code sera associé à un RIB de règlement du fournisseur chez Volcanes
	typ_dommage					VarChar ( 100 )				NULL,	-- Chaine contenant les codes des types de dommage sous la forme '#TD1#TD4#TD5#'
	point_service				VarChar ( 20 )			NOT	NULL,	-- Code du point de service	   
	mode_logis					VarChar ( 20 )			NOT	NULL,	-- Mode de logistique (CENTRALISATION / PROXIMITE )
	code_pickup					VarChar ( 20 )				NULL,	-- Code du relais si CENTRALISATION et Choix PickUp
	nom_pickup					VarChar ( 40 )				NULL,	-- Nom du relais si CENTRALISATION et Choix PickUp	
	ref_ass_pickup				VarChar ( 40 )				NULL,	-- référence du sinistre SPB et du nom de l'assuré à mettre sur le colis du Relais PickUp (dans le cas d'un renvoi)
	adr1_pickup					VarChar ( 40 )				NULL,   -- 1ère ligne adresse du relais pickup
	adr2_pickup					VarChar ( 40 )				NULL,   -- 2ème ligne adresse du relais pickup
	adr3_pickup					VarChar ( 40 )				NULL,   -- 3ème ligne adresse du relais pickup
	adr_cp_pickup				VarChar ( 5 )				NULL,   -- Code postal du relais pickup
	adr_ville_pickup			VarChar ( 40 )				NULL,   -- Ville du relais pickup
	code_process				Integer					NOT NULL,   -- code process (-IF) 3510=Dépôt colis en bureau de poste, 3520=Dépôt colis en relais pickup, 3530=Dépôt en boutique de proximité
	lib_code_process			VarChar ( 35 )			NOT	NULL,   -- Libellé du code process
	id_gti						Integer					NOT NULL,   -- ID de la garantie SIMPA2 (-GA )
	lib_perso_gti				VarChar ( 35 )			NOT NULL,   -- Libellé personnalisé de la garantie pour le produit
	id_detail					Integer					NOT NULL,   -- ID du détail de garantie SIMPA2 
	id_prod						Integer					NOT NULL,   -- Code produit (Offre) sinistre SIMPA2 
	lib_prod					VarChar ( 35 )			NOT NULL,   -- Libellé du produit (offre) sinistre SIMPA2 
	id_prod_adh					Integer					NOT NULL,   -- Code produit adhésion 
	id_ets						Integer					NOT NULL,   -- Code ets adhésion
	id_adh						VarChar ( 19 )			NOT NULL,   -- Numéro adhésion
	id_sdos						Integer					NOT NULL,   -- Numéro sous-dossier adhésion
	id_typ_art					varchar ( 3 )			NOT NULL,   -- Code représentant le type de la prestation
	cod_civ_livr				Integer					NOT NULL,   -- Code civilité de l'interlocuteur lié à la prestation
	lib_civ_livr_court			varchar ( 35 )			NOT NULL,   -- Lib civilité court de l'interlocuteur lié à la prestation
	lib_civ_livr_long			varchar ( 35 )			NOT NULL,   -- Lib civilité long de l'interlocuteur lié à la prestation
	id_contrat_abonne			VarChar ( 20 ) 				NULL,	-- Identifiant éventuel de l'assuré reconnu par le contractant
	nom_ass						VarChar ( 35 ) 				NULL,	-- Nom de l'assuré ayant souscrit l'adhésion
	prenom_ass					VarChar ( 35 ) 				NULL,	-- Prénom de l'assuré ayant souscrit l'adhésion
	nom_livr					varchar ( 35 )			NOT NULL,   -- Nom de l'interlocuteur lié à la prestation
	prenom_livr					varchar ( 35 )			NOT NULL,   -- Prénom de l'interlocuteur lié à la prestation
	adr1_livr					varchar ( 35 )			NOT NULL,   -- Adresse ligne 1 de l'interlocuteur lié à la prestation
	adr2_livr					varchar ( 35 )				NULL,   -- Adresse ligne 2 de l'interlocuteur lié à la prestation
	adr3_livr					varchar ( 35 )				NULL,   -- Adresse ligne 3 de l'interlocuteur lié à la prestation
	adr_cp_livr					varchar ( 5 )			NOT NULL,   -- Code postal de l'interlocuteur lié à la prestation
	adr_ville_livr				varchar ( 35 )			NOT NULL,   -- Ville de l'interlocuteur lié à la prestation
	num_tel1_ass				varchar ( 20 ) 			NOT NULL,   -- Numéro tel1 de l'interlocuteur lié à la prestation
	num_tel2_ass				varchar ( 20 ) 				NULL,   -- Numéro tel1 de l'interlocuteur lié à la prestation
	num_tel3_ass				varchar ( 20 ) 				NULL,   -- Numéro tel1 de l'interlocuteur lié à la prestation
	mail_assure					varchar ( 128 )				NULL,   -- Adresse mail de l'assuré
	num_imei_app_sin			varchar ( 20 )  			NULL,   -- Numéro de IMEI de l'appareil sinistré
	num_serie_app_sin			varchar ( 20 )  			NULL,   -- Numéro de série de l'appareil sinistré
	description_probleme		varchar ( 255 )  			NULL,   -- Déscription résumé du probleme sur l'appareil écrit en français par le GT
	cod_etat					varchar ( 3 )   		NOT NULL,   -- Etat de la prestation
	valide_le					DateTime				NOT NULL,   -- Date de validation de la prestation par le GT
	valide_par					varchar ( 4 )			NOT NULL,   -- Prestation validé par 
	cmd_gen_le					DateTime				NOT NULL,   -- Date de génération de la prestation par le système
	id_ref_four					varchar ( 20 )  		NOT	NULL,   -- Pour une commande de remplacement, cela peut être ID du matériel chez le fournisseur, sinon l'ordre d'action
	ordre_action				varchar ( 20 )  		NOT	NULL,   -- Ordre d'action
	id_assureur					Integer					NOT	NULL,   -- ID officiel spb de l'assureur
	lib_assureur				Varchar ( 35 )			NOT	NULL,   -- Libellé de l'assureur
	lib_police					Varchar ( 35 )			NOT	NULL,   -- Libellé de la police
	typ_app_sin					VarChar ( 3 ) 			NOT	NULL,   -- Type de l'appareil sinistré (-AR)
	lib_typ_app_sin				Varchar ( 35 )			NOT	NULL,   -- Libellé de l'appareil sinistré (-AR)
	marq_app_sin				Varchar ( 35 )			NOT	NULL,   -- Marque de l'appareil sinistré
	modl_app_sin				Varchar ( 35 )			NOT	NULL,   -- Modèle de l'appareil sinistré
	ref_app_sin					Varchar ( 20 )			NOT	NULL,   -- référence de l'appareil sinistré IFR, DARTY, AUTRE (AUTRE=Marque contrôlé, saisie modèle libre)
	num_tel_sin					VarChar ( 25 )				NULL,   -- Numéro de téléphone de l'appareil sinistré (si c'est une téléphone/smartphone)
	mt_val_achat				decimal ( 11, 2 )		NOT	NULL,   -- Montant de la valeur d'achat
	mt_prise_en_charge			decimal ( 11, 2 )		NOT	NULL,   -- Montant de prise en max par spb (à respecter par le fournisseur )
	date_achat					DateTime					NULL,	-- Date achat du matériel sinistré
	etat_app_sin				varChar ( 20 )				NULL,	-- Etat de l'appareil sinistré, REConditionné ou NEUf
	code_verrou					VarChar ( 20 )				NULL,	-- Code vérou de l'appareil
	desimlocke					VarChar( 20 )				NULL,	-- Appareil désimlocké OUI/NON
	info_spb_frn_cplt			VarChar ( 800 )				NULL,	-- Chaîne sérialisée contenant de multiples informations

 CONSTRAINT pk_DepotSimpa2ToHubPresta PRIMARY KEY CLUSTERED 

(
	id_depot_simpa2 ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
GO


Create index idx1_DepotSimpa2ToHubPresta on edi.DepotSimpa2ToHubPresta ( id_sin )
Create index idx2_DepotSimpa2ToHubPresta on edi.DepotSimpa2ToHubPresta ( id_sin, id_seq )
Create index idx3_DepotSimpa2ToHubPresta on edi.DepotSimpa2ToHubPresta ( id_hub_presta )
Create index idx4_DepotSimpa2ToHubPresta on edi.DepotSimpa2ToHubPresta ( depose_le )
Create index idx5_DepotSimpa2ToHubPresta on edi.DepotSimpa2ToHubPresta ( point_service )
Create index idx6_DepotSimpa2ToHubPresta on edi.DepotSimpa2ToHubPresta ( id_four )
Create index idx7_DepotSimpa2ToHubPresta on edi.DepotSimpa2ToHubPresta ( alt_trt )
Create index idx8_DepotSimpa2ToHubPresta on edi.DepotSimpa2ToHubPresta ( traite_le)

Go

-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_S_HP_TYPE_DOMMAGE
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Renvoie vers SIMPA2, à partir du HUB, les type de dommages possibles que propose le HUB selon "n" critères
--                              /!\ A COMPILER SUR LA BASE PRESTATAIRE /!\
--
--								Prévoir de changer le schéma sysdam en [edi] pour la compil sur la base du HUB
--
-- Retourne             :       rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_S_HP_TYPE_DOMMAGE' AND type = 'P' )
        DROP procedure edi.PS_HP276_S_HP_TYPE_DOMMAGE
GO


CREATE procedure edi.PS_HP276_S_HP_TYPE_DOMMAGE
	    @aiCas				Tinyint,
		@aiIdProd			Integer,
		@aiIdGti			Integer,
		@asMarqAppSin		VarChar ( 35 ),
		@asModlAppSin		VarChar ( 35 ),
		@asTypAppSin		VarChar ( 35 )
AS

---------------------------------------------------------------------------------
-- Cas Test Pour JF sur la base SIMPA2 Et HUB PRESTA, Retour en dur (bouchon)  --
-- /!\ A laisser !													           --
---------------------------------------------------------------------------------
If @aiCas in ( 1, 2 )
  Begin
	-- Select TEST pour JFF
	-- WaitFor Delay '00:00:00'
	Select Left ( 'TD1', 30) 'id_code_td_hp' , Left ( 'Ecran cassé', 50 ) 'lib_td_hp'
	Union
	Select Left ( 'TD2', 30) , Left ( 'Arrière cassé', 50 ) 
	Union
	Select Left ( 'TD3', 30) , Left ( 'Cassé sur le côté', 50 ) 
	Union
	Select Left ( 'TD4', 30) , Left ( 'Objectif de la caméra avant cassé', 50 ) 
  End

-------------------------------------------------------------------------------
-- Cas réél de retour pour Boulenouar, SELECT Réél sur la base  HUB Presta   --
-- à créer par BLN en respectant les formats des champs/colonnes du SELECT.  --
-------------------------------------------------------------------------------
If @aiCas = 3 
  Begin
	Select 'TOTO'
	/*   ( SELECT exemple, fais ton propre SELECT )

	SELECT id_code_typ_dom 'id_code_td_hp',
		   lin_typ_dom 'lib_td_hp'

	FROM

	WHERE [produit_hub]=@adcIdProd
	And   [garantie_hub]=@adcIdGti
	And   [MarqAppSin_hub]=@asMarqAppSin
	And   [ModlAppSin_hub]=@asModlAppSin
	And   [TypAppSin_hub]=@asTypAppSin

	ORDER BY


	*/
  End
Go

-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_S_HP_TYPE_ACTION
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Renvoie vers SIMPA2, à partir du HUB, les type d'action possibles que propose le HUB selon "n" critères
--                              /!\ A COMPILER SUR LA BASE PRESTATAIRE /!\
--
--								Prévoir de changer le schéma sysdam en [edi]  la compil sur la base du HUB
--
-- Retourne             :       rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_S_HP_TYPE_ACTION' AND type = 'P' )
        DROP procedure edi.PS_HP276_S_HP_TYPE_ACTION
GO


CREATE procedure edi.PS_HP276_S_HP_TYPE_ACTION
	    @aiCas				Tinyint,
		@adcIdProd			Integer,
		@adcIdGti			Integer,
		@asMarqAppSin		VarChar ( 35 ),
		@asModlAppSin		VarChar ( 35 ),
		@asTypAppSin		VarChar ( 35 ),
		@asTypDommage		VarChar ( 100 )
AS

---------------------------------------------------------------------------------
-- Cas Test Pour JF sur la base SIMPA2 Et HUB PRESTA, Retour en dur (bouchon)  --
-- /!\ A laisser !													           --
---------------------------------------------------------------------------------
If @aiCas in ( 1, 2 )
  Begin
	-- WaitFor Delay '00:00:00'
	Select Left ( 'A_REPARER', 20) 'id_code_action_hp' , Left ( 'Réparation', 20 ) 'lib_action_hp'
	Union
	Select Left ( 'A_DIAGNOSTIQUER', 20) 'id_code_action_hp' , Left ( 'Diagnostic', 20 ) 'lib_action_hp'
	Union
	Select Left ( 'A_COMMANDER', 20) 'id_code_action_hp' , Left ( 'Commande de remplacement', 20 ) 'lib_action_hp'
	Union
	Select Left ( 'PEC_A_RECYCLER', 20) 'id_code_action_hp' , Left ( 'Prise en charge, à recycler', 20 ) 'lib_action_hp'
	Union
	Select Left ( 'REFUSE_A_REEXP', 20) 'id_code_action_hp' , Left ( 'Refusé, à réexpédier', 20 ) 'lib_action_hp'
  End

-------------------------------------------------------------------------------
-- Cas réél de retour pour Boulenouar, SELECT Réél sur la base  HUB Presta   --
-- à créer par BLN en respectant les formats des champs/colonnes du SELECT.  --
-------------------------------------------------------------------------------
If @aiCas = 3 
  Begin
	Select 'TOTO'
		/*

		( SELECT exemple, fais ton propre SELECT )

		SELECT id_code_action_hp 'id_code_action_hp',
			   lib_action_hp 'lib_action_hp'

		FROM

		WHERE [produit_hub]=@adcIdProd
		And   [garantie_hub]=@adcIdGti
		And   [MarqAppSin_hub]=@asMarqAppSin
		And   [ModlAppSin_hub]=@asModlAppSin
		And   [TypAppSin_hub]=@sTypAppSin
		And   [typDommangeHub]=@asTypDommage

		ORDER BY


		*/
  End

Go

-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_S_HP_POINT_DE_SERVICE
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Renvoie vers SIMPA2, à partir du HUB, les points de services possibles que propose le HUB selon "n" critères
--                              /!\ A COMPILER SUR LA BASE PRESTATAIRE /!\
--
--								Prévoir de changer le schéma sysdam en [edi] pour la compil sur la base du HUB
--
-- Retourne             :       rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_S_HP_POINT_DE_SERVICE' AND type = 'P' )
        DROP procedure edi.PS_HP276_S_HP_POINT_DE_SERVICE
GO


CREATE procedure edi.PS_HP276_S_HP_POINT_DE_SERVICE
	    @aiCas				Tinyint,
		@adcIdProd			Integer,
		@adcIdGti			Integer,
		@asMarqAppSin		VarChar ( 35 ),
		@asModlAppSin		VarChar ( 35 ),
		@asTypAppSin		VarChar ( 35 ),
		@asTypDommage		VarChar ( 100 ),
		@asTypPrestation    VarChar ( 20 ),
		@asIdAdh			VarChar ( 19 ),
		@aiIdSin			Integer,
		@aiIdGrpContractant Integer,
		@asLibGrpContractant Varchar ( 35 ),
		@aiCiv				Integer,
		@asNom				VarChar ( 35 ),
		@asPrenom			VarChar ( 35 ),
		@asAdr1				VarChar ( 35 ),
		@asAdr2				VarChar ( 35 ),
		@asAdrCplt			VarChar ( 35 ),
		@asAdrCP			VarChar ( 5 ),
		@asAdrVille			VarChar ( 35 ),
		@asCodePays			VarChar ( 5 )

AS

---------------------------------------------------------------------------------
-- Cas Test Pour JF sur la base SIMPA2 Et HUB PRESTA, Retour en dur (bouchon)  --
-- /!\ A laisser !													           --
---------------------------------------------------------------------------------
If @aiCas in ( 1, 2 )
  Begin
	-- WaitFor Delay '00:00:5'
	Select	LEFT ( 'AUYPSQZMJB', 20 ) 'idHubPresta',
			Left ( 'ANV', 3 ) 'idFour', -- Code fournisseur SPB officiel SIMPA2/VOLCANES
			null,
			Left ( 'ANV0001', 20) 'idPointServ', 
			Left ( 'CENTRALIZATION', 20 ) 'idModeProcess', 
			Left ( 'Nom point de service ANV', 255 ) 'nomPointServ',
			Left ( 'Adresse1 point de service ANV', 255 ) 'adr1PointServ',
			Left ( 'Adresse2 point de service ANV', 255 ) 'adr2PointServ',
			Left ( 'Adresse3 point de service ANV', 255 ) 'adr3PointServ',
			Left ( 'Code postal ANV', 20) 'adrCpPointServ',
			Left ( 'Ville ANV', 50) 'adrVillePointServ',
			Left ( 'FR', 50) 'CodePaysPointServ',
			Left ( '595.65', 15 ) 'DistanceMetre',
			Left ( 'ACCEPTED', 20 ) 'statutPointServ' -- ACCEPTED, REJECTED, UNAVAILABLE, UNVERIFIED
	Union
	Select	LEFT ( 'AUYPSQZMJB', 20 ) 'idHubPresta',
			Left ( 'ANV', 3 ) 'idFour', -- Code fournisseur SPB officiel SIMPA2/VOLCANES
			null,
			Left ( 'ANV0002', 20) 'idPointServ', 
			Left ( 'PROXIMITY', 20 ) 'idModeProcess', 
			Left ( 'Nom point de service ANV', 255 ) 'nomPointServ',
			Left ( 'Adresse1 point de service ANV', 255 ) 'adr1PointServ',
			Left ( 'Adresse2 point de service ANV', 255 ) 'adr2PointServ',
			Left ( 'Adresse3 point de service ANV', 255 ) 'adr3PointServ',
			Left ( 'Code postal ANV', 20) 'adrCpPointServ',
			Left ( 'Ville ANV', 50) 'adrVillePointServ',
			Left ( 'FR', 50) 'CodePaysPointServ',
			Left ( '595.65', 15 ) 'DistanceMetre',
			Left ( 'REJECTED', 20 ) 'statutPointServ' -- ACCEPTED, REJECTED, UNAVAILABLE, UNVERIFIED
	Union
	Select	LEFT ( 'AUYPSQZMJB', 20 ) 'idHubPresta',
			Left ( 'ANV', 3 ) 'idFour', -- Code fournisseur SPB officiel SIMPA2/VOLCANES
			null,
			Left ( 'ANV0003', 20) 'idPointServ', 
			Left ( 'PROXIMITY', 20 ) 'idModeProcess', 
			Left ( 'Nom point de service ANV', 255 ) 'nomPointServ',
			Left ( 'Adresse1 point de service ANV', 255 ) 'adr1PointServ',
			Left ( 'Adresse2 point de service ANV', 255 ) 'adr2PointServ',
			Left ( 'Adresse3 point de service ANV', 255 ) 'adr3PointServ',
			Left ( 'Code postal ANV', 20) 'adrCpPointServ',
			Left ( 'Ville ANV', 50) 'adrVillePointServ',
			Left ( 'FR', 50) 'CodePaysPointServ',
			Left ( '595.65', 15 ) 'DistanceMetre',
			Left ( 'UNAVAILABLE', 20 ) 'statutPointServ' -- ACCEPTED, REJECTED, UNAVAILABLE, UNVERIFIED
	Union
	Select	LEFT ( 'AUYPSQZMJB', 20 ) 'idHubPresta',
			Left ( 'ANV', 3 ) 'idFour', -- Code fournisseur SPB officiel SIMPA2/VOLCANES
			null,
			Left ( 'ANV0004', 20) 'idPointServ', 
			Left ( 'PROXIMITY', 20 ) 'idModeProcess', 
			Left ( 'Nom point de service ANV', 255 ) 'nomPointServ',
			Left ( 'Adresse1 point de service ANV', 255 ) 'adr1PointServ',
			Left ( 'Adresse2 point de service ANV', 255 ) 'adr2PointServ',
			Left ( 'Adresse3 point de service ANV', 255 ) 'adr3PointServ',
			Left ( 'Code postal ANV', 20) 'adrCpPointServ',
			Left ( 'Ville ANV', 50) 'adrVillePointServ',
			Left ( 'FR', 50) 'CodePaysPointServ',
			Left ( '595.65', 15 ) 'DistanceMetre',
			Left ( 'ACCEPTED', 20 ) 'statutPointServ' -- ACCEPTED, REJECTED, UNAVAILABLE, UNVERIFIED
	Union
	Select	LEFT ( 'AUYPSQZMJB', 20 ) 'idHubPresta',
			Left ( 'ANV', 3 ) 'idFour', -- Code fournisseur SPB officiel SIMPA2/VOLCANES
			null,
			Left ( 'ANV0005', 20) 'idPointServ', 
			Left ( 'PROXIMITY', 20 ) 'idModeProcess', 
			Left ( 'Nom point de service ANV', 255 ) 'nomPointServ',
			Left ( 'Adresse1 point de service ANV', 255 ) 'adr1PointServ',
			Left ( 'Adresse2 point de service ANV', 255 ) 'adr2PointServ',
			Left ( 'Adresse3 point de service ANV', 255 ) 'adr3PointServ',
			Left ( 'Code postal ANV', 20) 'adrCpPointServ',
			Left ( 'Ville ANV', 50) 'adrVillePointServ',
			Left ( 'FR', 50) 'CodePaysPointServ',
			Left ( '595.65', 15 ) 'DistanceMetre',
			Left ( 'UNVERIFIED', 20 ) 'statutPointServ' -- ACCEPTED, REJECTED, UNAVAILABLE, UNVERIFIED
	Union
	Select	LEFT ( 'AUYPSQZMJB', 20 ) 'idHubPresta',
			Left ( 'ASF', 3 ) 'idFour', -- Code fournisseur SPB officiel SIMPA2/VOLCANES
			null,
			Left ( 'ASF0001', 20) 'idPointServ', 
			Left ( 'CENTRALIZATION', 20 ) 'idModeProcess', 
			Left ( 'Nom point de service ASF', 255 ) 'nomPointServ',
			Left ( 'Adresse1 point de service ASF', 255 ) 'adr1PointServ',
			Left ( 'Adresse2 point de service ASF', 255 ) 'adr2PointServ',
			Left ( 'Adresse3 point de service ASF', 255 ) 'adr3PointServ',
			Left ( 'Code postal ASF', 20) 'adrCpPointServ',
			Left ( 'Ville ASF', 50) 'adrVillePointServ',
			Left ( 'FR', 50) 'CodePaysPointServ',
			Left ( '595.65', 15 ) 'DistanceMetre',
			Left ( 'ACCEPTED', 20 ) 'statutPointServ' -- ACCEPTED, REJECTED, UNAVAILABLE, UNVERIFIED
	Union
	Select	LEFT ( 'AUYPSQZMJB', 20 ) 'idHubPresta',
			Left ( 'ASF', 3 ) 'idFour', -- Code fournisseur SPB officiel SIMPA2/VOLCANES
			null,
			Left ( 'ASF0002', 20) 'idPointServ', 
			Left ( 'PROXIMITY', 20 ) 'idModeProcess', 
			Left ( 'Nom point de service ASF', 255 ) 'nomPointServ',
			Left ( 'Adresse1 point de service ASF', 255 ) 'adr1PointServ',
			Left ( 'Adresse2 point de service ASF', 255 ) 'adr2PointServ',
			Left ( 'Adresse3 point de service ASF', 255 ) 'adr3PointServ',
			Left ( 'Code postal ASF', 20) 'adrCpPointServ',
			Left ( 'Ville ASF', 50) 'adrVillePointServ',
			Left ( 'FR', 50) 'CodePaysPointServ',
			Left ( '595.65', 15 ) 'DistanceMetre',
			Left ( 'REJECTED', 20 ) 'statutPointServ' -- ACCEPTED, REJECTED, UNAVAILABLE, UNVERIFIED
	Union
	Select	LEFT ( 'AUYPSQZMJB', 20 ) 'idHubPresta',
			Left ( 'ASF', 3 ) 'idFour', -- Code fournisseur SPB officiel SIMPA2/VOLCANES
			null,
			Left ( 'ASF0003', 20) 'idPointServ', 
			Left ( 'PROXIMITY', 20 ) 'idModeProcess', 
			Left ( 'Nom point de service ASF', 255 ) 'nomPointServ',
			Left ( 'Adresse1 point de service ASF', 255 ) 'adr1PointServ',
			Left ( 'Adresse2 point de service ASF', 255 ) 'adr2PointServ',
			Left ( 'Adresse3 point de service ASF', 255 ) 'adr3PointServ',
			Left ( 'Code postal ASF', 20) 'adrCpPointServ',
			Left ( 'Ville ASF', 50) 'adrVillePointServ',
			Left ( 'FR', 50) 'CodePaysPointServ',
			Left ( '595.65', 15 ) 'DistanceMetre',
			Left ( 'UNAVAILABLE', 20 ) 'statutPointServ' -- ACCEPTED, REJECTED, UNAVAILABLE, UNVERIFIED
  End

-------------------------------------------------------------------------------
-- Cas réél de retour pour Boulenouar, SELECT Réél sur la base  HUB Presta   --
-- à créer par BLN en respectant les formats des champs/colonnes du SELECT.  --
-------------------------------------------------------------------------------
If @aiCas = 3 
  Begin
	Select 'TOTO'
	/*
	SELECT 

	FROM

	WHERE 

	ORDER BY


	*/
  End
Go

-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_I_HP_VALIDATION_PRESTA_DANS_LE_HUB_PRESTATAIRE
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :      Validation de la prestation dans le HUB
--                              /!\ A COMPILER SUR LA BASE PRESTATAIRE /!\
--
--								Prévoir de changer le schéma sysdam en [edi] pour la compil sur la base du HUB
--
-- Retourne             :       rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_I_HP_VALIDATION_PRESTA_DANS_LE_HUB_PRESTATAIRE' AND type = 'P' )
        DROP procedure edi.PS_HP276_I_HP_VALIDATION_PRESTA_DANS_LE_HUB_PRESTATAIRE
GO

CREATE procedure edi.PS_HP276_I_HP_VALIDATION_PRESTA_DANS_LE_HUB_PRESTATAIRE
	    @aiCas	Tinyint,
		@iIdSin Integer ,
		@iIdSeq integer ,
		@sIdHubPresta VarChar ( 20 ) ,
		@sIdFour VarChar ( 3 ) ,
		@sTypDommage VarChar ( 100 ) ,
		@sPointService VarChar ( 20 ) ,
		@sModeProcess VarChar ( 20 ) ,
		@sCodePickUp VarChar ( 20 ) ,
		@sAdrNomPickUp VarChar ( 40 ) ,
		@sAdrReferenceAssPickUp VarChar ( 40 ) ,
		@sAdr1PickUp VarChar ( 40 ) ,
		@sAdr2PickUp VarChar ( 40 ) ,
		@sAdrCpltPickUp VarChar ( 40 ) ,
		@sAdrCpPickUp VarChar ( 5 ) ,
		@sAdrVillePickUp VarChar ( 40 ) ,
		@sCodeProcess Integer ,
		@sLibCodeProcess VarChar ( 35 ) ,
		@iIdGti Integer ,
		@sLibPersoGti VarChar ( 35 ) ,
		@iIdDetail Integer ,
		@iIdProd Integer ,
		@sLibProd VarChar ( 35 ) ,
		@sIdProdAdh Integer ,
		@iIdEts Integer ,
		@sIdAdh VarChar ( 19 ) ,
		@iIdSdos Integer ,
		@sIdTypArt varchar ( 3 ) ,
		@iCodCivLivr Integer ,
		@sLibCivLivrCourt varchar ( 35 ) ,
		@sLibCivLivrLong varchar ( 35 ) ,
		@IdContratAbonne VarChar ( 20 )  ,
		@NomAss VarChar ( 35 )  ,
		@PrenomAss VarChar ( 35 )  ,
		@NomLivr varchar ( 35 ) ,
		@PrenomLivr varchar ( 35 ) ,
		@sAdr1Livr varchar ( 35 ) ,
		@sAdr2Livr varchar ( 35 ) ,
		@sAdr3Livr varchar ( 35 ) ,
		@sAdrCpLivr varchar ( 5 ) ,
		@sAdrVilleLivr varchar ( 35 ) ,
		@sNumTel1Ass varchar ( 20 )  ,
		@sNumTel2Ass varchar ( 20 )  ,
		@sNumTel3Ass varchar ( 20 )  ,
		@sMailAssure varchar ( 128 ) ,
		@sNumImeiAppSin varchar ( 20 )  ,
		@sNumSerieAppSin varchar ( 20 )  ,
		@sDescriptionProbleme varchar ( 255 ) ,
		@sCodEtat varchar ( 3 )   ,
		@dtValideLe DateTime ,
		@sValidePar varchar ( 4 ) ,
		@dtCmdGenLe DateTime ,
		@sIdRefFour varchar ( 20 )  ,
		@sOrdreAction varchar ( 20 )   ,
		@iIdAssureur Integer ,
		@sLibAssureur Varchar ( 35 ) ,
		@sLibPolice Varchar ( 35 ) ,
		@sTypAppSin VarChar ( 3 )  ,
		@sLibTypAppSin Varchar ( 35 ) ,
		@sMarqAppSin Varchar ( 35 ) ,
		@sModlAppSin Varchar ( 35 ) ,
		@sRefAppSin Varchar ( 20 ) ,
		@sNumTelSin VarChar ( 25 ) ,
		@mtValAchat decimal ( 11, 2 ) ,
		@mtPriseEnCharge decimal ( 11, 2 ) ,
		@dtDateAchat DateTime ,
		@sEtatAppSin varChar ( 20 ) ,
		@sCodeVerrou VarChar ( 20 ) ,
		@sDesimlocke VarChar( 20 ) ,
		@sInfo_spb_frn_cplt VarChar ( 800 ) 

AS

-----------------------------------------------------------------------
-- Cas Test Pour JF sur la base SIMPA2, Retour en dur (bouchon)      --
-- /!\ A laisser !													 --
-----------------------------------------------------------------------
/*
If @aiCas = 1
  Begin
		Insert into sysadm.DepotSimpa2ToHubPresta
		( 
			id_sin,
			id_seq,
			depose_le,
			depose_par,
			alt_trt,
			traite_le,
			traite_par,
			id_hub_presta,
			id_four,
			typ_dommage,
			point_service,
			mode_logis,
			code_pickup,
			nom_pickup,
			ref_ass_pickup,
			adr1_pickup,
			adr2_pickup,
			adr3_pickup,
			adr_cp_pickup,
			adr_ville_pickup,
			code_process,
			lib_code_process,
			id_gti,
			lib_perso_gti,
			id_detail,
			id_prod,
			lib_prod,
			id_prod_adh,
			id_ets,
			id_adh,
			id_sdos,
			id_typ_art,
			cod_civ_livr,
			lib_civ_livr_court,
			lib_civ_livr_long,
			id_contrat_abonne,
			nom_ass,
			prenom_ass,
			nom_livr,
			prenom_livr,
			adr1_livr,
			adr2_livr,
			adr3_livr,
			adr_cp_livr,
			adr_ville_livr,
			num_tel1_ass,
			num_tel2_ass,
			num_tel3_ass,
			mail_assure,
			num_imei_app_sin,
			num_serie_app_sin,
			description_probleme,
			cod_etat,
			valide_le,
			valide_par,
			cmd_gen_le,
			id_ref_four,
			ordre_action,
			id_assureur,
			lib_assureur,
			lib_police,
			typ_app_sin,
			lib_typ_app_sin,
			marq_app_sin,
			modl_app_sin,
			ref_app_sin,
			num_tel_sin,
			mt_val_achat,
			mt_prise_en_charge,
			date_achat,
			etat_app_sin,
			code_verrou,
			desimlocke,
			info_spb_frn_cplt


		)

		Values 

		(
			@iIdSin,
			@iIdSeq,
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
			@sCodeProcess,
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
		)

		If @@ROWCOUNT = 1 Return 1

		Return -1
  End
*/

-------------------------------------------------------------------
-- Cas réél pour Boulenouar, Insert Réél sur la base HUB Presta  --
-- Retour 1 si Traitement par BLN Ok							 --
-- Retour -1 si Traitement par BLN KO							 --
-------------------------------------------------------------------

If @aiCas in ( 2, 3 )
  Begin

	-- Traitement réél des données 
		Insert into edi.DepotSimpa2ToHubPresta
		( 
			id_sin,
			id_seq,
			depose_le,
			depose_par,
			cpt_essai,
			essai_le,
			alt_trt,
			traite_le,
			traite_par,
			id_hub_presta,
			id_four,
			typ_dommage,
			point_service,
			mode_logis,
			code_pickup,
			nom_pickup,
			ref_ass_pickup,
			adr1_pickup,
			adr2_pickup,
			adr3_pickup,
			adr_cp_pickup,
			adr_ville_pickup,
			code_process,
			lib_code_process,
			id_gti,
			lib_perso_gti,
			id_detail,
			id_prod,
			lib_prod,
			id_prod_adh,
			id_ets,
			id_adh,
			id_sdos,
			id_typ_art,
			cod_civ_livr,
			lib_civ_livr_court,
			lib_civ_livr_long,
			id_contrat_abonne,
			nom_ass,
			prenom_ass,
			nom_livr,
			prenom_livr,
			adr1_livr,
			adr2_livr,
			adr3_livr,
			adr_cp_livr,
			adr_ville_livr,
			num_tel1_ass,
			num_tel2_ass,
			num_tel3_ass,
			mail_assure,
			num_imei_app_sin,
			num_serie_app_sin,
			description_probleme,
			cod_etat,
			valide_le,
			valide_par,
			cmd_gen_le,
			id_ref_four,
			ordre_action,
			id_assureur,
			lib_assureur,
			lib_police,
			typ_app_sin,
			lib_typ_app_sin,
			marq_app_sin,
			modl_app_sin,
			ref_app_sin,
			num_tel_sin,
			mt_val_achat,
			mt_prise_en_charge,
			date_achat,
			etat_app_sin,
			code_verrou,
			desimlocke,
			info_spb_frn_cplt


		)

		Values 

		(
			@iIdSin,
			@iIdSeq,
			GETDATE(),
			'SIM2',
			0,
			null,
			'N',
			null,
			null,
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
			@sCodeProcess,
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
		)

		Return @@Error

  End

Go

-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_SIU_EXECUTE_SQL_CMDE
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Exécution d'SQL Immédiat
--                              /!\ A COMPILER SUR LA BASE PRESTATAIRE /!\
--
--
-- Retourne             :       rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_SIU_EXECUTE_SQL_CMDE' AND type = 'P' )
        DROP procedure edi.PS_HP276_SIU_EXECUTE_SQL_CMDE
GO
  
CREATE  PROCEDURE edi.PS_HP276_SIU_EXECUTE_SQL_CMDE   
		@asCmde varchar(2000),
		@aiIdentity Integer OutPut,
		@aiRowCount Integer OutPut
AS  

Begin  
 DECLARE @SQLString NVARCHAR(2000) -- #1  
  
 set @SQLString= N'' + @asCmde  
 execute sp_executesql @SQLString 
 
 Set @aiIdentity = @@IDENTITY
 Set @aiRowCount = @@ROWCOUNT
 return @@ERROR

End  
  
  
-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_S_HP_DONNEES_TRANSMISES_PAR_SIMPA2_AU_HUB_PRESTAIRE
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       
--                              /!\ A COMPILER SUR LA BASE PRESTATAIRE /!\
--
--								
--
-- Retourne             :       rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_S_HP_DONNEES_TRANSMISES_PAR_SIMPA2_AU_HUB_PRESTAIRE' AND type = 'P' )
        DROP procedure edi.PS_HP276_S_HP_DONNEES_TRANSMISES_PAR_SIMPA2_AU_HUB_PRESTAIRE
GO


CREATE procedure edi.PS_HP276_S_HP_DONNEES_TRANSMISES_PAR_SIMPA2_AU_HUB_PRESTAIRE
	    @iIdSin		Integer,
		@iIdSeq		Integer
AS

Select 
	id_depot_simpa2,
	id_sin,
	id_seq,
	depose_le,
	depose_par,
	cpt_essai,
	essai_le,
	alt_trt,
	traite_le,
	traite_par,
	id_hub_presta,
	id_four,
	typ_dommage,
	point_service,
	mode_logis,
	code_pickup,
	nom_pickup,
	ref_ass_pickup,
	adr1_pickup,
	adr2_pickup,
	adr3_pickup,
	adr_cp_pickup,
	adr_ville_pickup,
	code_process,
	lib_code_process,
	id_gti,
	lib_perso_gti,
	id_detail,
	id_prod,
	lib_prod,
	id_prod_adh,
	id_ets,
	id_adh,
	id_sdos,
	id_typ_art,
	cod_civ_livr,
	lib_civ_livr_court,
	lib_civ_livr_long,
	id_contrat_abonne,
	nom_ass,
	prenom_ass,
	nom_livr,
	prenom_livr,
	adr1_livr,
	adr2_livr,
	adr3_livr,
	adr_cp_livr,
	adr_ville_livr,
	num_tel1_ass,
	num_tel2_ass,
	num_tel3_ass,
	mail_assure,
	num_imei_app_sin,
	num_serie_app_sin,
	description_probleme,
	cod_etat,
	valide_le,
	valide_par,
	cmd_gen_le,
	id_ref_four,
	ordre_action,
	id_assureur,
	lib_assureur,
	lib_police,
	typ_app_sin,
	lib_typ_app_sin,
	marq_app_sin,
	modl_app_sin,
	ref_app_sin,
	num_tel_sin,
	mt_val_achat,
	mt_prise_en_charge,
	date_achat,
	etat_app_sin,
	code_verrou,
	desimlocke,
	info_spb_frn_cplt

From edi.DepotSimpa2ToHubPresta dps2
Where dps2.id_sin = @iIdSin
And   dps2.id_seq = @iIdSeq

Go
