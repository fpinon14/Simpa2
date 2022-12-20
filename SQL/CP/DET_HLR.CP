-------------------------------------------------------------------
--
-- Fichier              :       DET_HLR.CP
-- Auteur               :       Abdmeziem C.
-- Date                 :       11/09/02
--
-- Commentaires         :       Gestion de la table DET_HLR
--
-- Procédures           :       DW_S01_DET_HLR
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_DET_HLR
-- Auteur               :       Abdmeziem C.
-- Date                 :       11/09/02
-- Libellé              :        
-- Commentaires         :       Select sur la table DET_HLR
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_DET_HLR' AND type = 'P' )
        DROP procedure sysadm.DW_S01_DET_HLR
GO

CREATE procedure sysadm.DW_S01_DET_HLR
AS
 SELECT id_four,
 	id_kit,
 	id_hlr,
 	id_article,
 	cree_le,
 	maj_le,
 	maj_par
 FROM   sysadm.det_hlr

GO

