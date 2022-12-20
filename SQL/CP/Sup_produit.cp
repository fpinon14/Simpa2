-------------------------------------------------------------------
--
-- Fichier              :       Sup_Produit.cp
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 17:55:46
--
-- Commentaires         :       Destruction des tables satellite de produit
--
-- Procédures           :       PS_SUPPRODUIT
-------------------------------------------------------------------
--------------------------------------------------------------------
--
-- Procédure            :       PS_SUPPRODUIT
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 17:56:19
-- Libellé              :
-- Commentaires         :       Procedure appellée pour supprimer toutes les lignes dans les tables
--
--                              DELAI
--                              PLAFOND
--                              FRANCHISE
--                              CODE_CONDITION
--                              MOTIF
--                              PIECE
--                              CODE_GARANTIE
--                              CONDITION
--                              AFFILIER
--                              GARANTIE
--                              REVISION
--                              COURRIER
--                              ETABLISSEMENT
--                              PARA_PROD
--
--                              Lors de la suppression d'un produit.
--
-- Références           :       Wf_PreparerSupprimer (),
--
-- Arguments            :       @dcIdProd       Decimal (  7,0 )        (Val)
--
-- Retourne             :
--
-------------------------------------------------------------------
-- FPI - 05/05/2010 - [SUPPR_PRODUIT] Corrections tables manquantes (suite à DMDI 28524)
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SUPPRODUIT' AND type = 'P' )
            DROP procedure sysadm.PS_SUPPRODUIT
GO

CREATE PROC sysadm.PS_SUPPRODUIT 
        @dcIdProd       Decimal (  7,0 )

AS

   -- [SUPPR_PRODUIT]
   /* Suppression des lignes dans la table BOUTIQUE */
   DELETE FROM sysadm.boutique WHERE id_prod = @dcIdProd

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END
   
   /* Suppression des lignes dans la table DIV_PDET */
   DELETE FROM sysadm.div_pdet WHERE id_prod = @dcIdProd

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END
   
   /* Suppression des lignes dans la table AUTORISATION */
   DELETE FROM sysadm.autorisation WHERE id_prod = @dcIdProd

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table COMMANDE_TYPE */
   DELETE FROM sysadm.commande_type WHERE id_prod = @dcIdProd

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

    /* Suppression des lignes dans la table DELAI */
   EXECUTE sysadm.IM_D02_DELAI @dcIdProd

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END
   -- Fin [SUPPR_PRODUIT]
   
   /* Suppression des lignes dans la table PLAFOND */
   EXECUTE sysadm.IM_D02_PLAFOND @dcIdProd

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table FRANCHISE */
   EXECUTE sysadm.IM_D02_FRANCHISE @dcIdProd

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table CODE_CONDITION */
   EXECUTE sysadm.IM_D02_CODE_CONDITION @dcIdProd

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table MOTIF */
   EXECUTE sysadm.IM_D03_MOTIF @dcIdProd

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table PIECE */
   EXECUTE sysadm.IM_D03_PIECE @dcIdProd

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table CODE_GARANTIE */
   EXECUTE sysadm.IM_D02_CODE_GARANTIE @dcIdProd

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table CONDITION */
   EXECUTE sysadm.IM_D02_CONDITION @dcIdProd

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table AFFILIER */
   DELETE FROM sysadm.affilier WHERE id_prod = @dcIdProd

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table GARANTIE */
   EXECUTE sysadm.IM_D02_GARANTIE @dcIdProd

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table REVISION */
   EXECUTE sysadm.IM_D01_REVISION @dcIdProd

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table COURRIER */
   EXECUTE sysadm.IM_D01_COURRIER @dcIdProd

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table ETABLISSEMENT */
   EXECUTE sysadm.IM_D02_ETABLISSEMENT @dcIdProd

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table PARA_PROD */
   EXECUTE sysadm.IM_D01_PARA_PROD @dcIdProd

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

     -- [SUPPR_PRODUIT]
   /* Suppression des lignes dans la table OPTION_ADH */
   DELETE FROM sysadm.option_adh WHERE id_prod = @dcIdProd

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END
   
   /* Suppression des lignes dans la table DET_PRO */
   DELETE FROM sysadm.det_pro WHERE id_prod = @dcIdProd

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END
     
   /* Suppression des lignes dans la table DIV_PRO */
   DELETE FROM sysadm.div_pro WHERE id_prod = @dcIdProd

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END
   
   -- Fin [SUPPR_PRODUIT]

GO
