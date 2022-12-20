-------------------------------------------------------------------
--
-- Fichier              :       courtype.cp
-- Auteur               :       YP
-- Date                 :       25/08/97 17:23:28
--
-- Commentaires         :       liste des proc afférant à la table COURRIER_TYPE
--
-- Procédures           :       
--                              DD_S02_COUR_TYPE
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DD_S02_COUR_TYPE
-- Auteur               :       YP
-- Date                 :       25/08/97 17:24:48
-- Libellé              :       Select sur table COUR_TYPE.
-- Commentaires         :
-- Références           :       DDDW_SP_COURCONF
--
-- Arguments            :
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S02_COUR_TYPE' AND type = 'P' )
            DROP procedure sysadm.DD_S02_COUR_TYPE
GO

CREATE PROC sysadm.DD_S02_COUR_TYPE
AS
 SELECT cour_type.id_cour,
        cour_type.lib_cour
   FROM sysadm.cour_type
   WHERE cour_type.id_cour like '_L%'

GO
