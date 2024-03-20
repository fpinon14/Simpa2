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
	WaitFor Delay '00:00:00'
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
	WaitFor Delay '00:00:00'
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
	WaitFor Delay '00:00:00'
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



