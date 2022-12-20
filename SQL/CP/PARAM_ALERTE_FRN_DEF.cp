-------------------------------------------------------------------
--
-- Fichier              :       PARAM_ALERTE_FRN_DEF.CP
-- Auteur               :       FPI
-- Date                 :       17/11/2011
--
-- Commentaires         :       [PM95]
-------------------------------------------------------------------
-- DW_S01_PARAM_ALERTE_FRN_DEF	FPI 17/11/2011 
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_PARAM_ALERTE_FRN_DEF
-- Auteur               :       Fabien PINON
-- Date                 :       17/11/2011
-- Libellé              :        
-- Commentaires         :       Select sur la table PARAM_ALERTE_FRN_DEF
-- Références           :       Pour la fenêtre accueil des PARAM_ALERTE_FRN_DEF
--
-- Arguments            :      
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_PARAM_ALERTE_FRN_DEF' AND type = 'P' )
        DROP PROCEDURE sysadm.DW_S01_PARAM_ALERTE_FRN_DEF
GO

CREATE procedure sysadm.DW_S01_PARAM_ALERTE_FRN_DEF
    
AS
SELECT id_alerte,
      nat_alerte,
      lib_alerte,
      cree_le,
      maj_le,
      maj_par
  FROM sysadm.param_alerte_frn_def
GO
