-------------------------------------------------------------------
--
-- Fichier              :       Etat_Stat.cp
-- Auteur               :       JFF
-- Date                 :       01/03/99 17:06:18
--
-- Commentaires         :       Liste des procédures afférent à la table Etat_Stat
--
-- Procédures           :
--                              DW_S01_ETAT_STAT
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_ETAT_STAT
-- Auteur               :       JFF
-- Date                 :       23/07/97 11:16:09
-- Libellé              :       Sélection des états
-- Commentaires         :	Ne ramène que les états dont le ALT_DDE = 'O'. l'emplacement du '' à la fin servira à afficher EN COURS
-- Références           :       Utilisée dans D_ETAT_DDE, fenetre W_SP_GS_TRAIT_ETAT_DDE
--
-- Arguments            :       
--
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_ETAT_STAT' AND type = 'P' )
            DROP procedure sysadm.DW_S01_ETAT_STAT
GO

CREATE PROC sysadm.DW_S01_ETAT_STAT
AS

 SELECT et.id_etat,
        et.lib_etat,
	et.alt_dte_deb,
	et.alt_dte_fin,
	et.alt_arg1,
	et.alt_arg2,
	et.cod_dw,
	et.cod_typ_etat,
	et.cod_typ_adh,
	''

   FROM sysadm.etat_stat et
   
   WHERE alt_dde = 'O'


GO
