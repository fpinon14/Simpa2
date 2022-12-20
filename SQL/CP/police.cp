-------------------------------------------------------------------
--
-- Fichier              :       POLICE.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       Gestion des polices dans SIMPA2
--
-- Procédures           :       DW_S02_POLICE_W_SIN
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_POLICE_W_SIN
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Sélect sur la table POLICE et COMPAGNIE
-- Références           :       Utilisé dans W_TM_SP_SINISTRE (Determine DATA)
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_POLICE_W_SIN' AND type = 'P' )
        DROP procedure sysadm.DW_S02_POLICE_W_SIN
GO

CREATE procedure sysadm.DW_S02_POLICE_W_SIN

AS
 SELECT police.id_police,
        police.lib_police,
        compagnie.id_cie,
        compagnie.lib_cie
 FROM   sysadm.police,
        sysadm.compagnie
 WHERE  police.id_cie           = compagnie.id_cie

GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_POLICE
-- Auteur               :       FPI
-- Date                 :       24/10/2011
-- Libellé              :       [VDoc4274]
-- Commentaires         :       Sélect sur la table POLICE
-- Références           :       Utilisé dans W_TD_SP_W_DETAIL 
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_POLICE' AND type = 'P' )
        DROP procedure sysadm.PS_S01_POLICE
GO

CREATE procedure sysadm.PS_S01_POLICE
	@dcIdProd Decimal(7,0),
	@dcIdRev Decimal(7,0),
	@dcIdGti Decimal(7,0),
	@dcIdCie Decimal(7,0) OUTPUT
AS
 SELECT @dcIdCie=id_cie
 FROM 	sysadm.garantie g
  inner join sysadm.police p on p.id_police=g.id_police
 WHERE  g.id_prod=@dcIdProd 
	and g.id_rev=@dcIdRev
	and g.id_gti=@dcIdGti
	
Return @@RowCount

GO


