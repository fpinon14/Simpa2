-------------------------------------------------------------------
--
-- Fichier              :       ZONE_FRN.CP
-- Auteur               :       Erick John Stark
-- Date                 :       17/07/2002
--
-- Commentaires         :       Gestion de la table ZONE_FRN
--
-- Procédures           :       DW_S01_ZONE_FOURNISSEUR
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_ZONE_FOURNISSEUR
-- Auteur               :       Erick John Stark
-- Date                 :       17/07/2002
-- Libellé              :
-- Commentaires         :       Select sur la table zone_fournisseur
-- Références           :       Utilis‚ dans W_TM_SP_SINISTRE
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_ZONE_FOURNISSEUR' AND type = 'P' )
        DROP procedure sysadm.DW_S01_ZONE_FOURNISSEUR
GO

CREATE procedure sysadm.DW_S01_ZONE_FOURNISSEUR
AS
 SELECT zone_fournisseur.id_prod,
 	zone_fournisseur.id_four,
 	zone_fournisseur.code_postal,
 	zone_fournisseur.code_action,
        zone_fournisseur.ville,
        zone_fournisseur.cree_le,
        zone_fournisseur.maj_le,
        zone_fournisseur.maj_par
 FROM   sysadm.zone_fournisseur
GO
