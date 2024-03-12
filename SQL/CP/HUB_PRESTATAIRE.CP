-------------------------------------------------------------------
--
-- Fichier              :       HUB_PRESTATAIRE.CP
-- Auteur               :       JFF
-- Date                 :       11/03/2024
--
-- Commentaires         :       Gestion des PS SQL entre SIMPA2 et le HUB prestataire
--
-- Proc‚dures           :       
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
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_S_S2_TYPE_DOMMAGE' AND type = 'P' )
        DROP procedure sysadm.PS_HP276_S_S2_TYPE_DOMMAGE
GO

CREATE procedure sysadm.PS_HP276_S_S2_TYPE_DOMMAGE
	    @adcIdProd			decimal (7),
		@adcIdGti			decimal (7),
		@asMarqAppSin		VarChar ( 35 ),
		@asModlAppSin		VarChar ( 35 ),
		@asTypAppSin		VarChar ( 35 )
AS

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec [LS-SAGA2].[PRESTATAIRE].[edi].PS_HP276_S_HP_TYPE_DOMMAGE @adcIdProd, @adcIdGti, @asMarqAppSin, @asModlAppSin, @asTypAppSin
END
ELSE
BEGIN
	-- Exec [S2SQL14PP1\PPRSAGA2].[PRESTATAIRE].[edi].PS_HP276_S_HP_TYPE_DOMMAGE @adcIdProd, @adcIdGti, @asMarqAppSin, @asModlAppSin, @sTypAppSin
	
	-- test SIMPA2
	Exec sysadm.PS_HP276_S_HP_TYPE_DOMMAGE @adcIdProd, @adcIdGti, @asMarqAppSin, @asModlAppSin, @asTypAppSin

END 

Go

--------------------------------------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_S_HP_TYPE_DOMMAGE' AND type = 'P' )
        DROP procedure sysadm.PS_HP276_S_HP_TYPE_DOMMAGE
GO


CREATE procedure sysadm.PS_HP276_S_HP_TYPE_DOMMAGE
	    @adcIdProd			decimal (7),
		@adcIdGti			decimal (7),
		@asMarqAppSin		VarChar ( 35 ),
		@asModlAppSin		VarChar ( 35 ),
		@asTypAppSin			VarChar ( 35 )
AS
-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_S_TYPE_DOMMAGE
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Renvoie vers SIMPA2, à partir du HUB, les type de dommages possibles que propose le HUB selon 5 critères
--                              /!\ A COMPILER SUR LA BASE PRESTATAIRE /!\
--
--								Prévoir de changer le schéma sysdam en [xxx] que donnera BLN pour la compil sur la base du HUB
--
-- Retourne             :       rien
-------------------------------------------------------------------

-- Select TEST pour JFF
-- WaitFor Delay '00:00:04'
Select Left ( 'TD1', 30) 'id_code_td_hp' , Left ( 'Ecran cassé', 50 ) 'lib_td_hp'
Union
Select Left ( 'TD2', 30) , Left ( 'Arrière cassé', 50 ) 
Union
Select Left ( 'TD3', 30) , Left ( 'Cassé sur le côté', 50 ) 
Union
Select Left ( 'TD4', 30) , Left ( 'Objectif de la caméra avant cassé', 50 ) 

-- SCHEMA SELECT REEL pour BLN
/*
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
Go

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
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_S_S2_TYPE_ACTION' AND type = 'P' )
        DROP procedure sysadm.PS_HP276_S_S2_TYPE_ACTION
GO

CREATE procedure sysadm.PS_HP276_S_S2_TYPE_ACTION
	    @adcIdProd			decimal (7),
		@adcIdGti			decimal (7),
		@asMarqAppSin		VarChar ( 35 ),
		@asModlAppSin		VarChar ( 35 ),
		@asTypAppSin		VarChar ( 35 ),
		@asTypDommage		VarChar ( 500 )

AS

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec [LS-SAGA2].[PRESTATAIRE].[edi].PS_HP276_S_HP_TYPE_ACTION @adcIdProd, @adcIdGti, @asMarqAppSin, @asModlAppSin, @asTypAppSin, @asTypDommage
END
ELSE
BEGIN
	-- Exec [S2SQL14PP1\PPRSAGA2].[PRESTATAIRE].[edi].PS_HP276_S_HP_TYPE_ACTION @adcIdProd, @adcIdGti, @asMarqAppSin, @asModlAppSin, @sTypAppSin, @asTypDommage
	
	-- test SIMPA2
	Exec sysadm.PS_HP276_S_HP_TYPE_ACTION @adcIdProd, @adcIdGti, @asMarqAppSin, @asModlAppSin, @asTypAppSin, @asTypDommage

END 

Go

--------------------------------------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_S_HP_TYPE_ACTION' AND type = 'P' )
        DROP procedure sysadm.PS_HP276_S_HP_TYPE_ACTION
GO


CREATE procedure sysadm.PS_HP276_S_HP_TYPE_ACTION
	    @adcIdProd			decimal (7),
		@adcIdGti			decimal (7),
		@asMarqAppSin		VarChar ( 35 ),
		@asModlAppSin		VarChar ( 35 ),
		@asTypAppSin		VarChar ( 35 ),
		@asTypDommage		VarChar ( 500 )
AS
-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_S_HP_TYPE_ACTION
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Renvoie vers SIMPA2, à partir du HUB, les type d'action possibles que propose le HUB selon 5 critères
--                              /!\ A COMPILER SUR LA BASE PRESTATAIRE /!\
--
--								Prévoir de changer le schéma sysdam en [xxx] que donnera BLN pour la compil sur la base du HUB
--
-- Retourne             :       rien
-------------------------------------------------------------------

-- Select TEST pour JFF
--WaitFor Delay '00:00:04'

Select Left ( 'A_REPARER', 20) 'id_code_action_hp' , Left ( 'Réparation', 20 ) 'lib_action_hp'
Union
Select Left ( 'A_DIAGNOSTIQUER', 20) 'id_code_action_hp' , Left ( 'Diagnostic', 20 ) 'lib_action_hp'
Union
Select Left ( 'A_COMMANDER', 20) 'id_code_action_hp' , Left ( 'Commande de remplacement', 20 ) 'lib_action_hp'
Union
Select Left ( 'PEC_A_RECYCLER', 20) 'id_code_action_hp' , Left ( 'Prise en charge, à recycler', 20 ) 'lib_action_hp'
Union
Select Left ( 'REFUSE_A_REEXP', 20) 'id_code_action_hp' , Left ( 'Refusé, à réexpédier', 20 ) 'lib_action_hp'


-- SCHEMA SELECT REEL pour BLN
/*
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

Go


