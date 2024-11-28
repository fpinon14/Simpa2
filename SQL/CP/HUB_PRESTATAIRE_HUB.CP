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
-- edi.PS_HP276_I_HP_INSERTION_ACTIVITY_HUB_TO_SIMPA2
-- edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2
-- edi.PS_HP276_I_HP_TRANSFERT_PRESTA_VERS_HUB_PRESTATAIRE
-- edi.PS_HP276_I_HP_VALIDATION_PRESTA_DANS_LE_HUB_PRESTATAIRE
-- edi.PS_HP276_S_HP_DONNEES_TRANSMISES_PAR_HUB_PRESTAIRE_A_SIMPA2
-- edi.PS_HP276_S_HP_DONNEES_TRANSMISES_PAR_SIMPA2_AU_HUB_PRESTAIRE
-- edi.PS_HP276_S_HP_POINT_DE_SERVICE
-- edi.PS_HP276_S_HP_PROCESS_ACHEMINEMENT
-- edi.PS_HP276_S_HP_RECUPERER_EN_MASSE_LES_PRESTATIONS_A_TRAITER
-- edi.PS_HP276_S_HP_TYPE_ACTION
-- edi.PS_HP276_S_HP_TYPE_DOMMAGE
-- edi.PS_HP276_U_HP_MARQUAGE_UNITAIRE_D_UNE_PRESTATION_TRAITEE
-- edi.PS_X_INCREMENTER
-------------------------------------------------------------------

Use PRESTATAIRE
Go

-----------------
-- LES SCHEMAS --
-----------------
-- create schema edi;
Go

-----------------
-- LES TABLES  --
-----------------


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
	point_service				VarChar ( 40 )				NULL,	-- Code du point de service	   
	mode_logis					VarChar ( 40 )				NULL,	-- Mode de logistique (CENTRALISATION / PROXIMITE )
	code_pickup					VarChar ( 20 )				NULL,	-- Code du relais si CENTRALISATION et Choix PickUp
	nom_pickup					VarChar ( 40 )				NULL,	-- Nom du relais si CENTRALISATION et Choix PickUp	
	ref_ass_pickup				VarChar ( 40 )				NULL,	-- référence du sinistre SPB et du nom de l'assuré à mettre sur le colis du Relais PickUp (dans le cas d'un renvoi)
	adr1_pickup					VarChar ( 40 )				NULL,   -- 1ère ligne adresse du relais pickup
	adr2_pickup					VarChar ( 40 )				NULL,   -- 2ème ligne adresse du relais pickup
	adr3_pickup					VarChar ( 40 )				NULL,   -- 3ème ligne adresse du relais pickup
	adr_cp_pickup				VarChar ( 5 )				NULL,   -- Code postal du relais pickup
	adr_ville_pickup			VarChar ( 40 )				NULL,   -- Ville du relais pickup
	code_process				Integer						NULL,   -- code process (-IF) 3510=Dépôt colis en bureau de poste, 3520=Dépôt colis en relais pickup, 3530=Dépôt en boutique de proximité
	lib_code_process			VarChar ( 35 )				NULL,   -- Libellé du code process
	id_gti						Integer						NULL,   -- ID de la garantie SIMPA2 (-GA )
	lib_perso_gti				VarChar ( 35 )				NULL,   -- Libellé personnalisé de la garantie pour le produit
	id_detail					Integer						NULL,   -- ID du détail de garantie SIMPA2 
	id_prod						Integer						NULL,   -- Code produit (Offre) sinistre SIMPA2 
	lib_prod					VarChar ( 35 )				NULL,   -- Libellé du produit (offre) sinistre SIMPA2 
	id_prod_adh					Integer						NULL,   -- Code produit adhésion 
	id_ets						Integer						NULL,   -- Code ets adhésion
	id_adh						VarChar ( 19 )				NULL,   -- Numéro adhésion
	id_sdos						Integer						NULL,   -- Numéro sous-dossier adhésion
	id_typ_art					varchar ( 3 )				NULL,   -- Code représentant le type de la prestation
	cod_civ_livr				Integer						NULL,   -- Code civilité de l'interlocuteur lié à la prestation
	lib_civ_livr_court			varchar ( 35 )				NULL,   -- Lib civilité court de l'interlocuteur lié à la prestation
	lib_civ_livr_long			varchar ( 35 )				NULL,   -- Lib civilité long de l'interlocuteur lié à la prestation
	id_contrat_abonne			VarChar ( 20 ) 				NULL,	-- Identifiant éventuel de l'assuré reconnu par le contractant
	nom_ass						VarChar ( 35 ) 				NULL,	-- Nom de l'assuré ayant souscrit l'adhésion
	prenom_ass					VarChar ( 35 ) 				NULL,	-- Prénom de l'assuré ayant souscrit l'adhésion
	nom_livr					varchar ( 35 )				NULL,   -- Nom de l'interlocuteur lié à la prestation
	prenom_livr					varchar ( 35 )				NULL,   -- Prénom de l'interlocuteur lié à la prestation
	adr1_livr					varchar ( 35 )				NULL,   -- Adresse ligne 1 de l'interlocuteur lié à la prestation
	adr2_livr					varchar ( 35 )				NULL,   -- Adresse ligne 2 de l'interlocuteur lié à la prestation
	adr3_livr					varchar ( 35 )				NULL,   -- Adresse ligne 3 de l'interlocuteur lié à la prestation
	adr_cp_livr					varchar ( 5 )				NULL,   -- Code postal de l'interlocuteur lié à la prestation
	adr_ville_livr				varchar ( 35 )				NULL,   -- Ville de l'interlocuteur lié à la prestation
	num_tel1_ass				varchar ( 20 ) 				NULL,   -- Numéro tel1 de l'interlocuteur lié à la prestation
	num_tel2_ass				varchar ( 20 ) 				NULL,   -- Numéro tel2 de l'interlocuteur lié à la prestation
	num_tel3_ass				varchar ( 20 ) 				NULL,   -- Numéro tel3 de l'interlocuteur lié à la prestation
	mail_assure					varchar ( 128 )				NULL,   -- Adresse mail de l'assuré
	num_imei_app_sin			varchar ( 20 )  			NULL,   -- Numéro de IMEI de l'appareil sinistré
	num_serie_app_sin			varchar ( 60 )  			NULL,   -- Numéro de série de l'appareil sinistré
	description_probleme		varchar ( 255 )  			NULL,   -- Description résumé du problème sur l'appareil écrit en français par le GT
	cod_etat					varchar ( 3 )   			NULL,   -- Etat de la prestation
	valide_le					DateTime					NULL,   -- Date de validation de la prestation par le GT
	valide_par					varchar ( 4 )				NULL,   -- Prestation validé par 
	cmd_gen_le					DateTime					NULL,   -- Date de génération de la prestation par le système
	id_ref_four					varchar ( 20 )  			NULL,   -- Pour une commande de remplacement, cela peut être ID du matériel chez le fournisseur, sinon l'ordre d'action
	ordre_action				varchar ( 20 )  			NULL,   -- Ordre d'action
	id_assureur					Integer						NULL,   -- ID officiel spb de l'assureur
	lib_assureur				Varchar ( 35 )				NULL,   -- Libellé de l'assureur
	lib_police					Varchar ( 35 )				NULL,   -- Libellé de la police
	typ_app_sin					VarChar ( 3 ) 				NULL,   -- Type de l'appareil sinistré (-AR)
	lib_typ_app_sin				Varchar ( 35 )				NULL,   -- Libellé de l'appareil sinistré (-AR)
	marq_app_sin				Varchar ( 35 )				NULL,   -- Marque de l'appareil sinistré
	modl_app_sin				Varchar ( 35 )				NULL,   -- Modèle de l'appareil sinistré
	ref_app_sin					Varchar ( 20 )				NULL,   -- référentiel de l'appareil sinistré IFR, DARTY, AUTRE (AUTRE=Marque contrôlé, saisie modèle libre)
	num_tel_sin					VarChar ( 25 )				NULL,   -- Numéro de téléphone de l'appareil sinistré (si c'est une téléphone/smartphone)
	mt_val_achat				decimal ( 11, 2 )			NULL,   -- Montant de la valeur d'achat
	mt_prise_en_charge			decimal ( 11, 2 )			NULL,   -- Montant de prise en max par spb (à respecter par le fournisseur )
	date_achat					DateTime					NULL,	-- Date achat du matériel sinistré
	etat_app_sin				varChar ( 20 )				NULL,	-- Etat de l'appareil sinistré, REConditionné ou NEUf
	code_verrou					VarChar ( 20 )				NULL,	-- Code verrou de l'appareil
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


If Exists ( Select Top 1 1 From sys.objects where name = 'DepotHubToSimpa2Presta' and type = 'U' ) Drop Table edi.DepotHubToSimpa2Presta

CREATE TABLE edi.DepotHubToSimpa2Presta(
	id_depot_hub				int IDENTITY(1,1)			NOT NULL,	-- Identifiant non modifiable de dépot, contrôle des trou/blanc si Delete Malveillant
	depose_le					DateTime default Getdate()	NULL,	-- Enregistrement déposé par Simpa2 le 
	depose_par					Char (4) default 'HUB'		NULL,	-- Enregistrement déposé par
	alt_trt						Char (1) default 'N'		NULL,	-- Répère alternatif N(on)/E(n cours)/O(ui) des enregistrement pris en compte et traité par le HubP.
	traite_le					DateTime					NULL,	-- Traité par le Hub le
	traite_par					Char (4)					NULL,	-- traité par
	id_hub_presta				VarChar ( 20 )			NOT NULL,   -- Identifiant sur le Hub Prestataire de la prestation
	num_cmd_frn					VarChar ( 50 )				NULL,   -- Numéro de la prestation chez le prestataire
	activity_code				VarChar ( 50 )				NULL,   -- Code HUB
	activity_return_code		Varchar ( 50 )				NULL,	-- Code HUB
	activity_reason_code		Varchar ( 50 )				NULL,	-- Code HUB
	typ_ba_aller				Varchar ( 35 )				NULL,	-- RPICKUP ou BPPAYE, voire de nouveaux CODE
	perte_aller					VarChar ( 3  )				NULL,   -- OUI/NON Perte du colis à l'aller
	diag_video_engage			VarChar ( 3  )				NULL,   -- OUI/NON Diag vidéo engagé
	resolu_diag_video			VarChar ( 3  )				NULL,   -- OUI/NON résolu par Diag vidéo 
	dte_rdv_conf				DateTime					NULL,   -- Date de rdv confirmé pour déplacement à domicile 
	mode_logis_ret				VarChar ( 40 )				NULL,   -- CENTRALISATION / PROXIMITE, Confirmation du prestataire sur le mode rééllement utilisé par l'assuré
	point_service_ret			VarChar ( 40 )				NULL,   -- Code du point de service où l'assuré s'est rééllement rendu ou bien a envoyé son appareil
	dte_rcp_frn					DateTime					NULL,   -- Date de réception de l'appareil chez le prestataire
	site_action					VarChar ( 20 )				NULL,   -- STATION/DOMICILE
	app_incomplet				VarChar ( 3  )				NULL,   -- OUI/NON si appareil incomplet
	dte_fin_trait				DateTime					NULL,   -- Date de fin de traitement/Date d'envoi colis retour vers assuré
	comment_frn					VarChar ( 255 )				NULL,   -- Commentaire fournisseur
	num_bon_trp					VarChar ( 35 )				NULL,   -- Numéro de colis retour 
	nom_transporteur			VarChar ( 35 )				NULL,   -- NOm du transporteur
	dte_rcp_app_cli				DateTime					NULL,   -- Date de réception de l'appareil par l'assuré
	app_swap					VarChar ( 3  )				NULL,   -- OUI/NON swap sur réparation (app irrep couvert et le presta redonne auto un app de rempl)
	autres_infos_rempl			VarChar ( 40 )              NULL,   -- null, renseigné par ces mot si la donnée est à l'extérieur du modèle COULEUR ou CAPACITE ou COULEUR_ET_CAPACITE, incohérent si ref_app_rempl = IFR
	marque_rempl				VarChar ( 35 )				NULL,   -- Marque de remplacement (sur SWAP ou Cmde Manuelle)
	modele_rempl				VarChar ( 35 )				NULL,   -- Modele de remplacement (sur SWAP ou Cmde Manuelle)
	num_imei_rempl				VarChar ( 20 )				NULL,	-- Numéro IMEI de remplacement (pour TEL)
	num_serie_rempl				VarChar ( 60 )				NULL,	-- Numéro SERIE de remplacement (pour autre que TEL)
	couleur_rempl				VarChar ( 35 )				NULL,   -- Couleur de remplacement (sur SWAP ou Cmde Manuelle)
	cap_stk_rempl				VarChar ( 35 )				NULL,   -- Capacité de stockage de remplacement (sur SWAP ou Cmde Manuelle)
	neuf_recond_rempl			VarChar ( 10 )				NULL,	-- NEU/REC app de remplacement (sur SWAP ou Cmde Manuelle) Neuf ou Reconditionné
	prix_ttc_rempl				Decimal ( 11, 2 )			NULL,   -- Prix TTC de l'app de remplacement qui sera facturé par le prestataire et réglé par spb
	prble_livraison				VarChar ( 35 )				NULL,   -- après une dte_fin_trait renseigné, Code du problème de livraison
	pec_prble_livraison			VarChar ( 3  )				NULL,   -- OUI/NON OUI si le presta prend la prble de livrasion à sa charge
	id_hub_presta_sav           VarChar ( 20 )			    NULL,   -- Identifiant sur le Hub Prestataire de la future prestation de SAV à venir
	info_frn_spb_cplt			VarChar ( 800 )				NULL,   -- Chaine sérialisée contenant de multiples informations pour de nouvelles données "exotiques" liées à un prestataire précis.
	chemin_fic					VarChar ( 255 )				NULL,   -- Chemin de dépôt du fichier produit par le moteur
	nom_fic						VarChar ( 255 )				NULL   -- Nom du fichier produit par le moteur
	
	CONSTRAINT pk_DepotHubToSimpa2Presta PRIMARY KEY CLUSTERED 

(
	id_depot_hub ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
GO

Create index idx1_DepotHubToSimpa2Presta on edi.DepotHubToSimpa2Presta ( id_hub_presta )
Create index idx2_DepotHubToSimpa2Presta on edi.DepotHubToSimpa2Presta ( depose_le )
Create index idx3_DepotHubToSimpa2Presta on edi.DepotHubToSimpa2Presta ( alt_trt )
Create index idx4_DepotHubToSimpa2Presta on edi.DepotHubToSimpa2Presta ( traite_le )

Go


If Exists ( Select Top 1 1 From sys.objects where name = 'TraceRecupRetourParSimpa2' and type = 'U' ) Drop table edi.TraceRecupRetourParSimpa2

CREATE TABLE edi.TraceRecupRetourParSimpa2 (
	[id_trc] [int] IDENTITY(1,1) NOT NULL,
	[id_lot_trc] int NOT NULL,
	[id_four] Varchar ( 10 ) NULL,
	[id_depot_hub] int NOT NULL,
	[id_hub_presta] Varchar ( 20 ) NULL,
	[cod_etat] varchar ( 6 ) NOT NULL,
	[commentaire] varchar ( 255 ) null,
	[cree_le] datetime NOT NULL,
	[maj_par] varchar(4) NOT NULL
	CONSTRAINT [pk_TraceRecupRetourParSimpa2] PRIMARY KEY CLUSTERED 
	( [id_trc] ASC ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

) ON [PRIMARY]
GO

Create index idx1_TraceRecupRetourParSimpa2 on edi.TraceRecupRetourParSimpa2 (cod_etat)
Create index idx2_TraceRecupRetourParSimpa2 on edi.TraceRecupRetourParSimpa2 (cree_le)
Create index idx3_TraceRecupRetourParSimpa2 on edi.TraceRecupRetourParSimpa2 (id_lot_trc)
Create index idx4_TraceRecupRetourParSimpa2 on edi.TraceRecupRetourParSimpa2 (id_four)

Delete edi.parametre where ref_cpt = 'ID_LOT_TRC'
Insert into edi.parametre Values ( 'ID_LOT_TRC', 0, 1 )


-----------------
-- LES PS      --
-----------------


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
	
	-- Select 'AUCUN', 'AUCUN'
  End

-------------------------------------------------------------------------------
-- Cas réél de retour pour Boulenouar, SELECT Réél sur la base  HUB Presta   --
-- à créer par BLN en respectant les formats des champs/colonnes du SELECT.  --
-------------------------------------------------------------------------------
If @aiCas = 3 
  Begin
		Exec edi.PS_HP276_S_HP_TYPE_DOMMAGE_HUB
			@aiCas				,
			@aiIdProd			,
			@aiIdGti			,
			@asMarqAppSin		,
			@asModlAppSin		,
			@asTypAppSin		
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
-- JFF  27/11/2024  [20241127082353640]
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
		@asTypDommage		VarChar ( 100 ),
		@asTypPrestation    VarChar ( 20 ),
		@asAdrCP			VarChar ( 5 ),  -- [20241127082353640]
		@asCodePays			VarChar ( 5 ), -- [20241127082353640]
		@adcMtValAchat		Decimal ( 11, 2 ) , -- [20241127082353640]
		@adcMtPriseEnCharge decimal ( 11, 2 ) , -- [20241127082353640]
		@asDateAchat		VarChar ( 10 ),  -- [20241127082353640]
		@asEtatAppSin		VarChar ( 20 ) -- [20241127082353640]
AS

Declare @dtDateAchat DateTime

Set @dtDateAchat = convert ( DateTime, @asDateAchat, 103 )

---------------------------------------------------------------------------------
-- Cas Test Pour JF sur la base SIMPA2 Et HUB PRESTA, Retour en dur (bouchon)  --
-- /!\ A laisser !													           --
---------------------------------------------------------------------------------
If @aiCas in ( 1, 2 )
  Begin
	-- WaitFor Delay '00:00:00'
	If @asTypPrestation = 'A_COMMANDER' 
		Select Left ( 'A_COMMANDER', 20) 'id_code_action_hp' , Left ( 'Commande de remplacement', 20 ) 'lib_action_hp'
		Union
		Select Left ( 'A_DIAGNOSTIQUER', 20) 'id_code_action_hp' , Left ( 'Diagnostic', 20 ) 'lib_action_hp'
		
	Else 
		Select Left ( 'A_REPARER', 20) 'id_code_action_hp' , Left ( 'Réparation', 20 ) 'lib_action_hp'
		Union
		Select Left ( 'A_DIAGNOSTIQUER', 20) 'id_code_action_hp' , Left ( 'Diagnostic', 20 ) 'lib_action_hp'
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
		Exec edi.PS_HP276_S_HP_TYPE_ACTION_HUB
			@adcIdProd			,
			@adcIdGti			,
			@asMarqAppSin		,
			@asModlAppSin		,
			@asTypAppSin		,
			@asTypDommage		,
			@asTypPrestation    ,
			@asAdrCP			,  
			@asCodePays			, 
			@adcMtValAchat		, 
			@adcMtPriseEnCharge , 
			@dtDateAchat 		,  
			@asEtatAppSin		
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
-- JFF  27/11/2024  [20241127082353640]
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
		@asCodePays			VarChar ( 5 ),
		@adcMtValAchat		Decimal ( 11, 2 ) , -- [20241127082353640]
		@adcMtPriseEnCharge decimal ( 11, 2 ) , -- [20241127082353640]
		@asDateAchat		VarChar ( 10 ),  -- [20241127082353640]
		@asEtatAppSin		VarChar ( 20 ) -- [20241127082353640]
AS

Declare @dtDateAchat DateTime

Set @dtDateAchat = convert ( DateTime, @asDateAchat, 103 )

---------------------------------------------------------------------------------
-- Cas Test Pour JF sur la base SIMPA2 Et HUB PRESTA, Retour en dur (bouchon)  --
-- /!\ A laisser !													           --
---------------------------------------------------------------------------------
If @aiCas in ( 1, 2 )
  Begin
	WaitFor Delay '00:00:00'

	If @asTypPrestation = 'A_COMMANDER' 
		Select	LEFT ( 'AUYPSQZMJB', 20 ) 'idHubPresta',
				Left ( 'ANV', 3 ) 'idFour', -- Code fournisseur SPB officiel SIMPA2/VOLCANES
				null,
				Left ( 'ANV0001', 40) 'idPointServ', 
				Left ( 'CENTRALIZATION', 40 ) 'idModeLogis', 
				Left ( 'Centralisation', 40 ) 'LibModeLogis', --  [A_REPRENDRE]
				Left ( 'Nom point de service ANV', 255 ) 'nomPointServ',
				Left ( 'Adresse1 point de service ANV', 255 ) 'adr1PointServ',
				Left ( 'Adresse2 point de service ANV', 255 ) 'adr2PointServ',
				Left ( 'Adresse3 point de service ANV', 255 ) 'adr3PointServ',
				Left ( 'Code postal ANV', 20) 'adrCpPointServ',
				Left ( 'Ville ANV', 50) 'adrVillePointServ',
				Left ( 'FR', 50) 'CodePaysPointServ',
				Left ( '595.65', 15 ) 'DistanceMetre',
				Left ( 'ACCEPTED', 20 ) 'statutPointServ' -- ACCEPTED, REJECTED, UNAVAILABLE, UNVERIFIED

	Else
	Select	LEFT ( 'AUYPSQZMJB', 20 ) 'idHubPresta',
			Left ( 'ANV', 3 ) 'idFour', -- Code fournisseur SPB officiel SIMPA2/VOLCANES
			null,
			Left ( 'ANV0001', 40) 'idPointServ', 
			Left ( 'CENTRALIZATION', 40 ) 'idModeLogis', 
			Left ( 'Centralisation', 40 ) 'LibModeLogis', --  [A_REPRENDRE]
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
			Left ( 'PROXIMITY', 40 ) 'idModeLogis', 
			Left ( 'Proximité', 40 ) 'LibModeLogis', --  [A_REPRENDRE]
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
			Left ( 'PROXI_CENTRALIZATION', 40 ) 'idModeLogis', 
			Left ( 'Proximité / Centralisation', 40 ) 'LibModeLogis', --  [A_REPRENDRE]
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
			Left ( 'AT_HOME', 40 ) 'idModeLogis', 
			Left ( 'À domicile', 40 ) 'LibModeLogis', --  [A_REPRENDRE]
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
			Left ( 'REMOTELY', 40 ) 'idModeLogis', 
			Left ( 'À distance', 40 ) 'LibModeLogis', --  [A_REPRENDRE]
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
			Left ( 'CENTRALIZATION', 20 ) 'idModeLogis', 
			Left ( 'Centralisation', 40 ) 'LibModeLogis', --  [A_REPRENDRE]
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
			Left ( 'PROXIMITY', 20 ) 'idModeLogis', 
			Left ( 'Proximité', 40 ) 'LibModeLogis', --  [A_REPRENDRE]
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
			Left ( 'PROXIMITY', 20 ) 'idModeLogis', 
			Left ( 'Proximité', 40 ) 'LibModeLogis', --  [A_REPRENDRE]
			Left ( 'Nom point de service ASF', 255 ) 'nomPointServ',
			Left ( 'Adresse1 point de service ASF', 255 ) 'adr1PointServ',
			Left ( 'Adresse2 point de service ASF', 255 ) 'adr2PointServ',
			Left ( 'Adresse3 point de service ASF', 255 ) 'adr3PointServ',
			Left ( 'Code postal ASF', 20) 'adrCpPointServ',
			Left ( 'Ville ASF', 50) 'adrVillePointServ',
			Left ( 'FR', 50) 'CodePaysPointServ',
			Left ( '595.65', 15 ) 'DistanceMetre',
			Left ( 'UNAVAILABLE', 20 ) 'statutPointServ' -- ACCEPTED, REJECTED, UNAVAILABLE, UNVERIFIED
/*
	Select	LEFT ( 'AUCUN', 20 ) 'idHubPresta',
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null
*/



  End

-------------------------------------------------------------------------------
-- Cas réél de retour pour Boulenouar, SELECT Réél sur la base  HUB Presta   --
-- à créer par BLN en respectant les formats des champs/colonnes du SELECT.  --
-------------------------------------------------------------------------------
If @aiCas = 3 
  Begin
	Exec edi.PS_HP276_S_HP_POINT_DE_SERVICE_HUB
		@adcIdProd			,
		@adcIdGti			,
		@asMarqAppSin		,
		@asModlAppSin		,
		@asTypAppSin		,
		@asTypDommage		,
		@asTypPrestation    ,
		@asIdAdh			,
		@aiIdSin			,
		@aiIdGrpContractant ,
		@asLibGrpContractant ,
		@aiCiv				,
		@asNom				,
		@asPrenom			,
		@asAdr1				,
		@asAdr2				,
		@asAdrCplt			,
		@asAdrCP			,
		@asAdrVille			,
		@asCodePays			,
		@adcMtValAchat		,
		@adcMtPriseEnCharge , 
		@dtDateAchat		,
		@asEtatAppSin		
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
	    @aiCas Tinyint,
		@iIdSin Integer ,
		@iIdSeq integer ,
		@sIdHubPresta VarChar ( 20 ) ,
		@sIdFour VarChar ( 3 ) ,
		@sTypDommage VarChar ( 100 ) ,
		@sPointService VarChar ( 40 ) ,
		@sModeLogis VarChar ( 40 ) ,
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

Declare @iError Integer
Declare @iRowCount Integer

Declare @sAltTrt VarChar ( 1 )
Declare @dtTraiteLe DateTime 
Declare @sTraitePar VarChar ( 4 )
Declare @iAReparerSav Integer

Set @iAReparerSav = IIF ( edi.FN_CLE_VAL ( 'A_REPARER_SAV', @sInfo_spb_frn_cplt, ';') = 'OUI', 1, 0)

Set @sAltTrt = 'N'
Set @dtTraiteLe = null 
Set @sTraitePar = null


If @iAReparerSav > 0 
	Begin
		Set @sAltTrt = 'O'
		Set @dtTraiteLe = GETDATE()
		Set @sTraitePar = 'SIM2'
	End 


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
			@sAltTrt,
			@dtTraiteLe,
			@sTraitePar,
			@sIdHubPresta,
			@sIdFour,
			@sTypDommage,
			@sPointService,
			@sModeLogis,
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

		Set @iError = @@Error
		Set @iRowCount = @@ROWCOUNT

		If @iError = 0 And @iRowCount <> 1 Set @iError = 1000

		Return @iError 

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
  
Go

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
		@iIdSeq		Integer,
		@iIdDepotS2 Integer
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
And   dps2.id_depot_simpa2 = @iIdDepotS2 

Go

-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_S_HP_RECUPERER_EN_MASSE_LES_PRESTATIONS_A_TRAITER
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Renvoie toutes les prestations présentes sur le HUB et donc A TRAITER
--                              /!\ A COMPILER SUR LA BASE PRESTATAIRE /!\
--
--								
--
-- Retourne             :       rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_S_HP_RECUPERER_EN_MASSE_LES_PRESTATIONS_A_TRAITER' AND type = 'P' )
        DROP procedure edi.PS_HP276_S_HP_RECUPERER_EN_MASSE_LES_PRESTATIONS_A_TRAITER
GO


CREATE procedure edi.PS_HP276_S_HP_RECUPERER_EN_MASSE_LES_PRESTATIONS_A_TRAITER
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
	edi.FN_CLE_VAL ( 'HP_ID_PROCESS_ACHEM', info_spb_frn_cplt, ';') process_achem,
	edi.FN_CLE_VAL ( 'COULEUR', info_spb_frn_cplt, ';') couleur,	
	edi.FN_CLE_VAL ( 'CAPACITE', info_spb_frn_cplt, ';') capacite,	
	edi.FN_CLE_VAL ( 'DUALSIM', info_spb_frn_cplt, ';') dualsim,
	Convert ( Datetime, edi.FN_CLE_VAL ( 'DTE_ADH', info_spb_frn_cplt , ';' ), 103 ) dte_adh,
	Convert ( Datetime, edi.FN_CLE_VAL ( 'DOS_CREE_LE', info_spb_frn_cplt , ';' ), 103 ) dos_cree_le,
	Convert ( Datetime, edi.FN_CLE_VAL ( 'DTE_SURV', info_spb_frn_cplt , ';' ), 103 )  dte_surv,
	Convert ( Datetime, edi.FN_CLE_VAL ( 'DTE_FIN_GTI', info_spb_frn_cplt , ';' ), 103 )  dte_fin_gti,
	edi.FN_CLE_VAL ( 'NUM_FAX_SPB', info_spb_frn_cplt , ';' ) num_fax_spb,
	edi.FN_CLE_VAL ( 'NUM_TEL_SPB', info_spb_frn_cplt , ';' ) num_tel_spb,
	info_spb_frn_cplt

From edi.DepotSimpa2ToHubPresta dps2
Where dps2.alt_trt in ( 'N', 'E' ) 
Order by id_depot_simpa2

Go

-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_U_HP_MARQUAGE_UNITAIRE_D_UNE_PRESTATION_TRAITEE
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Marque unitairement une prestation en mode tentative_uniquement ou tentive_générée
--                              /!\ A COMPILER SUR LA BASE PRESTATAIRE /!\
--
--								
--
-- Retourne             :       1 Succès / -1 Echec
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_U_HP_MARQUAGE_UNITAIRE_D_UNE_PRESTATION_TRAITEE' AND type = 'P' )
        DROP procedure edi.PS_HP276_U_HP_MARQUAGE_UNITAIRE_D_UNE_PRESTATION_TRAITEE
GO

CREATE procedure edi.PS_HP276_U_HP_MARQUAGE_UNITAIRE_D_UNE_PRESTATION_TRAITEE
	@asCas			VarChar ( 50 ),  -- Valeur possible de asCas
									 -- TENTATIVE_UNIQUEMENT : Tentative s'étant terminée en échec 
									 -- TENTATIVE_GENEREE    : Tentative s'étant terminée en succès et donc ayant réellement générée la prestation vers le prestataire
	@aiIdDepotSimpa2	Integer			 -- Clé primaire de l'enregistrement à mettre à mettre
AS

Set @asCas = Upper ( lTrim ( rTrim ( @asCas )))

If @asCas in ( 'TENTATIVE_UNIQUEMENT', 'TENTATIVE_GENEREE' ) 
  Begin
	Update	edi.DepotSimpa2ToHubPresta 
	Set		cpt_essai = cpt_essai + 1,
			essai_le  = GetDate(),
			alt_trt   = 'E'
	Where	id_depot_simpa2 = @aiIdDepotSimpa2
	And     alt_trt <> 'O'
  End 

If @asCas = 'TENTATIVE_GENEREE' 
  Begin
	Update	edi.DepotSimpa2ToHubPresta 
	Set		alt_trt   = 'O',
			traite_le = GetDate(),
			traite_par = 'HUB'
	Where	id_depot_simpa2 = @aiIdDepotSimpa2
	And     alt_trt <> 'O'
  End 

Go

-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Trace la récup des retour du HUB par SIMPA2
--                              /!\ A COMPILER SUR LA BASE PRESTATAIRE /!\
--
--								
--
-- Retourne             :       
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2' AND type = 'P' )
        DROP procedure edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2
GO

CREATE procedure edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2
	@asCas			Varchar ( 50 ),
	@asIdFour		VarChar ( 10 ),
	@aiIdDepotHub	Int,
	@asIdHubPresta  VarChar ( 20 ),
	@aiCodEtat		varchar ( 6 ),
	@asCommentaire	VarChar ( 255 ),
	@aiIdLotTrc		Integer OutPut
As

If @asCas = 'OBTENTION_ID_LOT_TRC'
  Begin
	EXEC edi.PS_X_INCREMENTER 'ID_LOT_TRC', @aiIdLotTrc OUTPUT 
	Return
  End 

Set @asCommentaire = lTrim ( rTrim ( @asCommentaire ) )

Insert into edi.TraceRecupRetourParSimpa2 
		(
		id_lot_trc,
		id_four,
		id_depot_hub,
		id_hub_presta,
		cod_etat,
		commentaire,
		cree_le,
		maj_par
		)
Values
		(
		@aiIdLotTrc,
		@asIdFour,
		@aiIdDepotHub,
		@asIdHubPresta,
		@aiCodEtat,
		@asCommentaire,
		Getdate(),
		'SQLS'
		)

Go

-------------------------------------------------------------------
--
-- Procédure            :       PS_X_INCREMENTER
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Incrémentation d'un compteur
--                              /!\ A COMPILER SUR LA BASE PRESTATAIRE /!\
--
--								
--
-- Retourne             :       
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_X_INCREMENTER' AND type = 'P' )
        DROP procedure edi.PS_X_INCREMENTER
GO
 
create procedure edi.PS_X_INCREMENTER
 @srefcpt  varchar(10),  
 @dccptval decimal(10,0) output -- [PI062]  
as  
  
-- JFF      12/02/2016   [PI062]  
  
/* mise a jour de la valeur du compteur dans la table. */  
update edi.parametre  
   set cpt_val = cpt_val + 1  
 where ref_cpt = @srefcpt  
  
if @@rowcount = 0  return -1  
  
/* acquisition de la derniere valeur du compteur */  
select  @dccptval = cpt_val  
  from  edi.parametre  
 where  ref_cpt = @srefcpt  
  
return 1  
Go

-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_I_HP_INSERTION_ACTIVITY_HUB_TO_SIMPA2
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Insertion une activité de retour du Hub vers SIMPA2
--                              /!\ A COMPILER SUR LA BASE PRESTATAIRE /!\
--
--								
--
-- Retourne             :       = 0 Succès, <> 0 Erreur
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_I_HP_INSERTION_ACTIVITY_HUB_TO_SIMPA2' AND type = 'P' )
        DROP procedure edi.PS_HP276_I_HP_INSERTION_ACTIVITY_HUB_TO_SIMPA2
GO

CREATE procedure edi.PS_HP276_I_HP_INSERTION_ACTIVITY_HUB_TO_SIMPA2
	@asIdHubPresta		VarChar ( 20 ),
	@asNumCmdFrn		VarChar ( 50 ),
	@asActivityCode		VarChar ( 50 ),
	@asActivityReturnCode		Varchar ( 50 ),
	@asActivityReasonCode		Varchar ( 50 ),
	@asDiagVideoEngage		VarChar ( 3  ),
	@asResoluDiagVideo		VarChar ( 3  ),
	@adtDteRdvConf		DateTime,
	@asModeLogisRet		VarChar ( 40 ),
	@asPointServiceRet	VarChar ( 40 ),
	@adtDteRcpFrn		DateTime,
	@asSiteAction		VarChar ( 20 ),
	@adtDteFinTrait		DateTime,
	@asCommentFrn		VarChar ( 255 ),
	@asNumBonTrp		VarChar ( 35 ),
	@asNomTransporteur		VarChar ( 35 ),
	@asAutresInfosRempl		VarChar ( 40 ),
	@asMarqueRempl		VarChar ( 35 ),
	@asModeleRempl		VarChar ( 35 ),
	@asNumImeiRempl		VarChar ( 20 ),
	@asNumSerieRempl		VarChar ( 60 ),
	@asCouleurRempl		VarChar ( 35 ),
	@asCapStkRempl		VarChar ( 35 ),
	@asNeufRecondRempl		VarChar ( 10 ),
	@adcPrixTtcRempl		Decimal ( 11, 2 ),
	@adtDteRcpAppCli		DateTime,
	@asIdHubPrestaSav		VarChar ( 20 ),
	@asInfoFrnSpbCplt		VarChar ( 800 )
As

---------------------------------------------------------------------------------------------------------------------------------------------
-- Retour à tester impérativement 
-- 	Si 0 Alors Succès, Ok
--	Si <> 0 Alors Erreur, le client appelant doit le géré dans son code, je n'ai pas l'information, l'enregistrement ne s'est pas inséré.
---------------------------------------------------------------------------------------------------------------------------------------------
DECLARE @DBID INT
DECLARE @DBNAME NVARCHAR(128)
Declare @iIdDepotHub Int
Declare @iIdentity Int
Declare @iError Int

SET @DBID = DB_ID()
SET @DBNAME = DB_NAME()

If @asIdHubPresta is null Or lTrim ( rTrim ( @asIdHubPresta )) = ''
  Begin
     RAISERROR ('La variable @asIdHubPresta doit absolument est renseignée.', 16, 1, @DBID, @DBNAME)
	 Return @@Error
  End 
/*
Select @iIdDepotHub = max ( id_depot_hub )
From edi.DepotHubToSimpa2Presta
Where id_hub_presta = @asIdHubPresta


-- 1ère Création
If @iIdDepotHub is null
  Begin*/
	Insert into edi.DepotHubToSimpa2Presta 
		( 
			id_hub_presta,
			num_cmd_frn,
			activity_code,
			activity_return_code,
			activity_reason_code,
			diag_video_engage,
			resolu_diag_video,
			dte_rdv_conf,
			mode_logis_ret,
			point_service_ret,
			dte_rcp_frn,
			site_action,
			dte_fin_trait,
			comment_frn,
			num_bon_trp,
			nom_transporteur,
			dte_rcp_app_cli,
			autres_infos_rempl,
			marque_rempl,
			modele_rempl,
			num_imei_rempl,
			num_serie_rempl,
			couleur_rempl,
			cap_stk_rempl,
			neuf_recond_rempl,
			prix_ttc_rempl,
			id_hub_presta_sav,
			info_frn_spb_cplt
		) 
	Values
		(
			@asIdHubPresta,
			@asNumCmdFrn,
			@asActivityCode,
			@asActivityReturnCode,
			@asActivityReasonCode,
			@asDiagVideoEngage,
			@asResoluDiagVideo,
			@adtDteRdvConf,
			@asModeLogisRet,
			@asPointServiceRet,
			@adtDteRcpFrn,
			@asSiteAction,
			@adtDteFinTrait,
			@asCommentFrn,
			@asNumBonTrp,
			@asNomTransporteur,
			@adtDteRcpAppCli,
			@asAutresInfosRempl,
			@asMarqueRempl,
			@asModeleRempl,
			@asNumImeiRempl,
			@asNumSerieRempl,
			@asCouleurRempl,
			@asCapStkRempl,
			@asNeufRecondRempl,
			@adcPrixTtcRempl,
			@asIdHubPrestaSav,
			@asInfoFrnSpbCplt
		)
	
	Return @@Error
/*
  End 

-- Maj (par insertion dern enrg source )
	Insert into edi.DepotHubToSimpa2Presta 
		( 
			id_hub_presta,
			num_cmd_frn,
			activity_code,
			activity_return_code,
			activity_reason_code,
			typ_ba_aller,
			perte_aller,
			diag_video_engage,
			resolu_diag_video,
			dte_rdv_conf,
			mode_logis_ret,
			point_service_ret,
			dte_rcp_frn,
			site_action,
			app_incomplet,
			dte_fin_trait,
			comment_frn,
			num_bon_trp,
			nom_transporteur,
			dte_rcp_app_cli,
			app_swap,
			autres_infos_rempl,
			marque_rempl,
			modele_rempl,
			num_imei_rempl,
			num_serie_rempl,
			couleur_rempl,
			cap_stk_rempl,
			neuf_recond_rempl,
			prix_ttc_rempl,
			prble_livraison,
			pec_prble_livraison,
			id_hub_presta_sav,
			info_frn_spb_cplt
		) 
Select		id_hub_presta,
			num_cmd_frn,
			activity_code=null,
			activity_return_code=null,
			activity_reason_code=null,
			typ_ba_aller,
			perte_aller,
			diag_video_engage,
			resolu_diag_video,
			dte_rdv_conf,
			mode_logis_ret,
			point_service_ret,
			dte_rcp_frn,
			site_action,
			app_incomplet,
			dte_fin_trait,
			comment_frn,
			num_bon_trp,
			nom_transporteur,
			dte_rcp_app_cli,
			app_swap='N',
			autres_infos_rempl,
			marque_rempl,
			modele_rempl,
			num_imei_rempl,
			num_serie_rempl,
			couleur_rempl,
			cap_stk_rempl,
			neuf_recond_rempl,
			prix_ttc_rempl,
			prble_livraison,
			pec_prble_livraison,
			id_hub_presta_sav, 
			info_frn_spb_cplt

From edi.DepotHubToSimpa2Presta
Where id_depot_hub = @iIdDepotHub

Set @iError = @@Error; If @iError <> 0 Return @iError 

Set @iIdentity = @@IDENTITY


-- Maj (des nouvelles données)
Update edi.DepotHubToSimpa2Presta Set num_cmd_frn = lTrim ( rtrim ( @asNumCmdFrn ))						Where id_depot_hub = @iIdentity And @asNumCmdFrn			is not null And lTrim ( rtrim ( @asNumCmdFrn )) <> ''
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set activity_code = lTrim ( rtrim ( @asActivityCode ))				Where id_depot_hub = @iIdentity And @asActivityCode			is not null And lTrim ( rtrim ( @asActivityCode )) <> ''
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set activity_return_code = lTrim ( rtrim ( @asActivityReturnCode ))	Where id_depot_hub = @iIdentity And @asActivityReturnCode	is not null And lTrim ( rtrim ( @asActivityReturnCode )) <> ''
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set activity_reason_code = lTrim ( rtrim ( @asActivityReasonCode ))	Where id_depot_hub = @iIdentity And @asActivityReasonCode	is not null And lTrim ( rtrim ( @asActivityReasonCode )) <> ''
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set diag_video_engage = lTrim ( rtrim ( @asDiagVideoEngage ))			Where id_depot_hub = @iIdentity And @asDiagVideoEngage		is not null And lTrim ( rtrim ( @asDiagVideoEngage )) <> ''
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set resolu_diag_video = lTrim ( rtrim ( @asResoluDiagVideo ))			Where id_depot_hub = @iIdentity And @asResoluDiagVideo		is not null And lTrim ( rtrim ( @asResoluDiagVideo )) <> ''
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set dte_rdv_conf = @adtDteRdvConf										Where id_depot_hub = @iIdentity And @adtDteRdvConf			is not null 
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set mode_logis_ret = lTrim ( rtrim ( @asModeLogisRet ))				Where id_depot_hub = @iIdentity And @asModeLogisRet			is not null And lTrim ( rtrim ( @asModeLogisRet )) <> ''
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set point_service_ret = lTrim ( rtrim ( @asPointServiceRet ))			Where id_depot_hub = @iIdentity And @asPointServiceRet		is not null And lTrim ( rtrim ( @asPointServiceRet )) <> ''
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set dte_rcp_frn = @adtDteRcpFrn										Where id_depot_hub = @iIdentity And @adtDteRcpFrn			is not null 
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set site_action = lTrim ( rtrim ( @asSiteAction ))					Where id_depot_hub = @iIdentity And @asSiteAction			is not null And lTrim ( rtrim (	@asSiteAction )) <> ''
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set dte_fin_trait = @adtDteFinTrait									Where id_depot_hub = @iIdentity And @adtDteFinTrait			is not null 
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set comment_frn = lTrim ( rtrim ( @asCommentFrn ))					Where id_depot_hub = @iIdentity And @asCommentFrn			is not null And lTrim ( rtrim (	@asCommentFrn )) <> ''
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set num_bon_trp = lTrim ( rtrim ( @asNumBonTrp ))						Where id_depot_hub = @iIdentity And @asNumBonTrp			is not null And lTrim ( rtrim (	@asNumBonTrp )) <> ''	
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set nom_transporteur = lTrim ( rtrim ( @asNomTransporteur ))			Where id_depot_hub = @iIdentity And @asNomTransporteur		is not null And lTrim ( rtrim (	@asNomTransporteur )) <> ''	
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set dte_rcp_app_cli = @adtDteRcpAppCli								Where id_depot_hub = @iIdentity And @adtDteRcpAppCli		is not null
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set autres_infos_rempl = lTrim ( rtrim ( @asAutresInfosRempl ))		Where id_depot_hub = @iIdentity And @asAutresInfosRempl		is not null And lTrim ( rtrim (	@asAutresInfosRempl )) <> ''	
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set marque_rempl = lTrim ( rtrim ( @asMarqueRempl ))					Where id_depot_hub = @iIdentity And @asMarqueRempl			is not null And lTrim ( rtrim (	@asMarqueRempl )) <> ''	
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set modele_rempl = lTrim ( rtrim ( @asModeleRempl ))					Where id_depot_hub = @iIdentity And @asModeleRempl			is not null And lTrim ( rtrim (	@asModeleRempl )) <> ''	
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set num_imei_rempl = lTrim ( rtrim ( @asNumImeiRempl ))				Where id_depot_hub = @iIdentity And @asNumImeiRempl			is not null And lTrim ( rtrim (	@asNumImeiRempl )) <> ''	
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set num_serie_rempl = lTrim ( rtrim ( @asNumSerieRempl ))				Where id_depot_hub = @iIdentity And @asNumSerieRempl		is not null And lTrim ( rtrim (	@asNumSerieRempl )) <> ''	
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set couleur_rempl = lTrim ( rtrim ( @asCouleurRempl ))				Where id_depot_hub = @iIdentity And @asCouleurRempl			is not null And lTrim ( rtrim (	@asCouleurRempl )) <> ''	
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set cap_stk_rempl = lTrim ( rtrim ( @asCapStkRempl ))					Where id_depot_hub = @iIdentity And @asCapStkRempl			is not null And lTrim ( rtrim (	@asCapStkRempl )) <> ''	
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set neuf_recond_rempl = lTrim ( rtrim ( @asNeufRecondRempl ))			Where id_depot_hub = @iIdentity And @asNeufRecondRempl		is not null And lTrim ( rtrim (	@asNeufRecondRempl )) <> ''	
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set prix_ttc_rempl = @adcPrixTtcRempl									Where id_depot_hub = @iIdentity And @adcPrixTtcRempl		is not null And @adcPrixTtcRempl >= 0
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set id_hub_presta_sav = @asIdHubPrestaSav								Where id_depot_hub = @iIdentity And @asIdHubPrestaSav		is not null And lTrim ( rtrim (	@asIdHubPrestaSav )) <> ''	
Set @iError = @@Error; If @iError <> 0 Return @iError 
Update edi.DepotHubToSimpa2Presta Set info_frn_spb_cplt = lTrim ( rtrim ( @asInfoFrnSpbCplt ))			Where id_depot_hub = @iIdentity And @asInfoFrnSpbCplt		is not null And lTrim ( rtrim (	@asInfoFrnSpbCplt )) <> ''	

Return @@Error
*/

Go

-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_I_HP_TRANSFERT_PRESTA_VERS_HUB_PRESTATAIRE
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
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_I_HP_TRANSFERT_PRESTA_VERS_HUB_PRESTATAIRE' AND type = 'P' )
        DROP procedure edi.PS_HP276_I_HP_TRANSFERT_PRESTA_VERS_HUB_PRESTATAIRE
GO

CREATE procedure edi.PS_HP276_I_HP_TRANSFERT_PRESTA_VERS_HUB_PRESTATAIRE
		@aiCas Tinyint,
		@iIdSin Integer ,
		@iIdSeq integer ,
		@sIdHubPresta VarChar ( 20 ) ,
		@sIdFour VarChar ( 3 ) ,
		@sTypDommage VarChar ( 100 ) ,
		@sPointService VarChar ( 40 ) ,
		@sModeLogis VarChar ( 40 ) ,
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
		@sInfo_spb_frn_cplt VarChar ( 800 ),
		@aiIdentity Integer OutPut,
		@aiRowCount Integer OutPut

As

Declare @iError Integer

		Exec @iError = edi.PS_HP276_I_HP_VALIDATION_PRESTA_DANS_LE_HUB_PRESTATAIRE
			@aiCas,
			@iIdSin,
			@iIdSeq,
			@sIdHubPresta,
			@sIdFour,
			@sTypDommage,
			@sPointService,
			@sModeLogis,
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

 
 If @@Error <> 0 and @iError = 0 Set @iError = @@ERROR

 Set @aiIdentity = @@IDENTITY
 Set @aiRowCount = @@ROWCOUNT
 return @iError

Go

--------------------------------------------------------------------
--
-- Fonction             :       FN_CLE_VAL
-- Auteur               :       Fabry JF
-- Date                 :       21/02/2007
-- Libellé              :
-- Commentaires         :       Pour un clé fournie, se trouve dans une chaîne de caractères, 
--				retourne la valeur liée, en précisant le séparateur
-- Références           :       Ex : Select sysadm.FN_CLE_VAL ( 'TOTO', 'XYXU=TOTO;TOTO=TUTU;TITI=TETE;XYXY=TOTO;RERE=;FRFR=', ';' )
--
-- Arguments            :       @asCle		VarChar ( 255 )  La clé à rechercher
--				@asChaine	VarChar ( 255 )  La clé à parcourir
--				@asSep		VarChar ( 1 )    Le séparateur
--
-- Retourne             :       @asVal	 	VarChar ( 255 )  La valeur en retour
--
-- JFF  19/12/2018   Ajout lTrim ( Rtrim ( sur le retour
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'FN_CLE_VAL' AND type = 'FN' )
        DROP function edi.FN_CLE_VAL
Go

CREATE  function edi.FN_CLE_VAL
   (
	@asCle		VarChar ( 255 ) , 
	@asChaine	VarChar ( 1000 ) ,
	@asSep		VarChar ( 1 )   
    )
RETURNS Varchar(1000)

AS

Begin

  Declare @iDeb Integer
  Declare @iFin Integer
  Declare @sVal VarChar ( 1000 )
  Declare @AltDebCleValide Integer
  Declare @AltFinCleValide Integer

  Set @iDeb = CharIndex ( @asCle + '=', @asChaine, 1 ) 
  Set @sVal = ''
  Set @AltDebCleValide = 0
  Set @AltFinCleValide = 0

  While @iDeb > 0 
   Begin
     If @iDeb = 1 
	Begin
	  Set @AltDebCleValide = 1
	End 

     If @iDeb > 1 
 	Begin
	  if Substring ( @asChaine, @iDeb - 1, 1 ) = @asSep
		Begin
			Set @AltDebCleValide = 1
		End 
	End 

     Set @iFin = CharIndex ( '=', @asChaine, @iDeb ) 
     If @iFin > 0 
	Begin 
		Set @AltFinCleValide = 1	
	End 

     -- Ce n'est pas une clé
     If @AltDebCleValide = 0 Or @AltFinCleValide = 0
	Begin
	        Set @iDeb = CharIndex ( @asCle + '=', @asChaine, @iDeb + 1 ) 
	End
     
     -- C'est bien une clé valide
     If @AltDebCleValide = 1 And @AltFinCleValide = 1
	Begin
	     Set @iDeb = @iFin + 1
	     Set @iFin = CharIndex ( @asSep, @asChaine, @iDeb ) - 1
	     if @iFin <= 0 Set @iFin = Len ( @asChaine )
	     
	     if @iFin > 0 
	      Begin
	        Set @sVal = Substring ( @asChaine, @iDeb, @iFin - @iDeb + 1 )
		Set @iDeb = 0
	      End
	End
   End

   If @sVal is null Set @sVal = ''

   Return  ltrim ( rTrim ( @sVal ))

End

Go

-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_S_HP_DONNEES_TRANSMISES_PAR_HUB_PRESTAIRE_A_SIMPA2
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
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_S_HP_DONNEES_TRANSMISES_PAR_HUB_PRESTAIRE_A_SIMPA2' AND type = 'P' )
        DROP procedure edi.PS_HP276_S_HP_DONNEES_TRANSMISES_PAR_HUB_PRESTAIRE_A_SIMPA2
GO

CREATE procedure edi.PS_HP276_S_HP_DONNEES_TRANSMISES_PAR_HUB_PRESTAIRE_A_SIMPA2
	    @sIdHubPresta VarChar ( 20 )
AS

Select 
	'N' alt_b_detail_presta,
	id_depot_hub,
	Convert ( VarChar ( 10 ), depose_le , 103 ) + ' ' + Convert ( VarChar ( 10 ), depose_le , 108 ) depose_le,
	depose_par,
	alt_trt,
	Convert ( VarChar ( 10 ), traite_le , 103 ) + ' ' + Convert ( VarChar ( 10 ), traite_le , 108 ) traite_le,
	traite_par,
	id_hub_presta,
	num_cmd_frn,
	activity_code,
	activity_return_code,
	activity_reason_code,
	null lib_activity,
	typ_ba_aller,
	perte_aller,
	diag_video_engage,
	resolu_diag_video,
	Convert ( VarChar ( 10 ), dte_rdv_conf , 103 ) dte_rdv_conf,
	mode_logis_ret,
	point_service_ret,
	Convert ( VarChar ( 10 ), dte_rcp_frn , 103 )  dte_rcp_frn,
	site_action,
	app_incomplet,
	Convert ( VarChar ( 10 ), dte_fin_trait , 103 )  dte_fin_trait,
	comment_frn,
	num_bon_trp,
	nom_transporteur,
	Convert ( VarChar ( 10 ), dte_rcp_app_cli , 103 ) dte_rcp_app_cli,
	app_swap,
	autres_infos_rempl,
	marque_rempl,
	modele_rempl,
	num_imei_rempl,
	num_serie_rempl,
	couleur_rempl,
	cap_stk_rempl,
	neuf_recond_rempl,
	prix_ttc_rempl,
	prble_livraison,
	pec_prble_livraison,
	id_hub_presta_sav,
	info_frn_spb_cplt,
	chemin_fic,
	nom_fic

From edi.DepotHubToSimpa2Presta dhs
Where dhs.id_hub_presta = @sIdHubPresta
Order by id_depot_hub

Go


-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_S_HP_PROCESS_ACHEMINEMENT
-- Auteur               :       JFF
-- Date                 :       12/09/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Renvoie vers SIMPA2, à partir du HUB, les process d'acheminement possibles que propose le HUB selon "n" critères
--                              /!\ A COMPILER SUR LA BASE PRESTATAIRE /!\
--
--								Prévoir de changer le schéma sysdam en [edi] pour la compil sur la base du HUB
--
-- Retourne             :       rien
-------------------------------------------------------------------
-- JFF  27/11/2024  [20241127082353640]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_S_HP_PROCESS_ACHEMINEMENT' AND type = 'P' )
        DROP procedure edi.PS_HP276_S_HP_PROCESS_ACHEMINEMENT
GO

CREATE procedure edi.PS_HP276_S_HP_PROCESS_ACHEMINEMENT
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
		@asCodePays			VarChar ( 5 ),
		@asIdFour			Varchar ( 3 ), -- Ajout pour Acheminement
		@asIdPointService   VarChar ( 40 ), -- Ajout pour Acheminement
		@asIdModeLogistique	VarChar ( 40 ), -- Ajout pour Acheminement
		@adcMtValAchat		Decimal ( 11, 2 ) , -- [20241127082353640]
		@adcMtPriseEnCharge decimal ( 11, 2 ) , -- [20241127082353640]
		@asDateAchat		VarChar ( 10 ),  -- [20241127082353640]
		@asEtatAppSin		VarChar ( 20 ) -- [20241127082353640]

AS

Declare @dtDateAchat DateTime

Set @dtDateAchat = convert ( DateTime, @asDateAchat, 103 )

---------------------------------------------------------------------------------
-- Cas Test Pour JF sur la base SIMPA2 Et HUB PRESTA, Retour en dur (bouchon)  --
-- /!\ A laisser !													           --
---------------------------------------------------------------------------------
If @aiCas in ( 1, 2 )
  Begin
	WaitFor Delay '00:00:00'

	-- Select 'AUCUN', null
	-- Select null, null from edi.DepotHubToSimpa2Presta

	
	Select	LEFT ( 'POST_OFFICE', 30 ) 'Id_Process_Achem_Hp',
			Left ( 'Bureau de poste', 40 ) 'Lib_Process_Achem_Hp' --  [A_REPRENDRE]
	Union
	Select	LEFT ( 'PICK_UP_POINT', 30 ), 
			Left ( 'Point relais', 40 ) 
	Union
	Select	LEFT ( 'PICK_UP_TRANSPORTATION', 30 ),
			Left ( 'Enlèvement transporteur', 40 ) 
/*
	Union
	Select	REPLICATE ( 'A', 29 ) + 'B',
			REPLICATE ( 'a', 39 ) + 'b'


	Union
	Select	LEFT ( 'PICK_UP_POIjjjjNT', 30 ), 
			Left ( 'Point relais', 40 ) 
	Union
	Select	LEFT ( 'PICK_UP_TRANSPeeeORTATION', 30 ),
			Left ( 'Enlèvement transporteur', 40 ) 
	Union
	Select	REPLICATE ( 'A', 29 ) + 'B',
			REPLICATE ( 'a', 39 ) + 'b'
	Union
	Select	LEFT ( 'PICK_ffffUP_POINT', 30 ), 
			Left ( 'Point relais', 40 ) 
	Union
	Select	LEFT ( 'PICK_UP_TRANzzzSPORTATION', 30 ),
			Left ( 'Enlèvement transporteur', 40 ) 
	Union
	Select	REPLICATE ( 'A', 29 ) + 'B',
			REPLICATE ( 'a', 39 ) + 'b'			

*/

  End

-------------------------------------------------------------------------------
-- Cas réél de retour pour Boulenouar, SELECT Réél sur la base  HUB Presta   --
-- à créer par BLN en respectant les formats des champs/colonnes du SELECT.  --
-------------------------------------------------------------------------------
If @aiCas = 3 
  Begin
		Exec edi.PS_HP276_S_HP_PROCESS_ACHEMINEMENT_HUB
			@adcIdProd			,
			@adcIdGti			,
			@asMarqAppSin		,
			@asModlAppSin		,
			@asTypAppSin		,
			@asTypDommage		,
			@asTypPrestation    ,
			@asIdAdh			,
			@aiIdSin			,
			@aiIdGrpContractant ,
			@asLibGrpContractant ,
			@aiCiv				,
			@asNom				,
			@asPrenom			,
			@asAdr1				,
			@asAdr2				,
			@asAdrCplt			,
			@asAdrCP			,
			@asAdrVille			,
			@asCodePays			,
			@asIdFour			,
			@asIdPointService   ,
			@asIdModeLogistique	,
			@adcMtValAchat		,
			@adcMtPriseEnCharge ,
			@dtDateAchat		,
			@asEtatAppSin		
  End
Go

