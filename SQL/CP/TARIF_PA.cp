-------------------------------------------------------------------
--
-- Fichier              :       TARIF_PA.CP
-- Auteur               :       FABRY JF
-- Date                 :       28/11/01 
--
-- Commentaires         :       Liste des procédure de la table des tarif_papier
--
-- Procédures           :	DW_S01_TARIF_PAPIER
--                              
--                              
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_TARIF_PAPIER
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Sélect sur la table AIDE_PAPIER
-- Références           :       Utilisé dans W_TRT_POPUP_AIDE_PAPIER
--
-- Arguments            :       Aucun
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_TARIF_PAPIER' AND type = 'P' )
        DROP procedure sysadm.DW_S01_TARIF_PAPIER
GO

CREATE procedure sysadm.DW_S01_TARIF_PAPIER
AS
 SELECT tarif_papier.id_seq,
        tarif_papier.id_typ_papier,
        tarif_papier.mt_eur,
        tarif_papier.mt_frf,
        tarif_papier.id_dept,
        tarif_papier.dte_tarif,
        tarif_papier.validite,
        tarif_papier.information,
        tarif_papier.cree_le,
        tarif_papier.maj_le,
        tarif_papier.maj_par,
        c1.lib_code,
        c2.lib_code
 FROM   sysadm.tarif_papier

 LEFT OUTER JOIN sysadm.code_car c2
 ON     sysadm.tarif_papier.id_dept             = c2.id_code    AND
        c2.id_typ_code                          = '-DP'

 LEFT OUTER JOIN sysadm.code_car c1
 ON     sysadm.tarif_papier.id_typ_papier       = c1.id_code    AND
        c1.id_typ_code                          = '-TP'

GO

