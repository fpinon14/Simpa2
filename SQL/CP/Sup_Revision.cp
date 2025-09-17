-------------------------------------------------------------------
--
-- Fichier              :       SUP_REVISION.CP
-- Auteur               :       La Recrue
-- Date                 :       22/07/97 16:46:15
--
-- Commentaires         :       Suppression d'une révision.
--
-- Procédures           :       PS_SUPREVISION
--------------------------------------------------------------------
--------------------------------------------------------------------
--
-- Procédure            :       PS_SUPREVISION 
-- Auteur               :       La Recrue
-- Date                 :       22/07/97 16:47:26
-- Libellé              : 
-- Commentaires         :       Procedure appelle pour supprimer toutes les lignes dans les tables
--
--                              CONDITION
--                              PIECE
--                              MOTIF
--                              GARANTIE
--                              ETABLISSEMENT
--                              DELAI + PLAFOND + FRANCHISE
--                              AFFILIER
--
--                              Lors de la suppression d'une revision
--
-- Références           :       W_Tm_Sp_Produit, Wf_TerminerValider (), U_SP_GS_REV_PROD, Uf_TerminerValider ()
--
-- Arguments            :       @dcIdProd  Decimal (7,0),
--                              @dcIdRev   Decimal (7,0)
--
-- Retourne             :
--
-------------------------------------------------------------------
-- FPI - 10/09/2025 - ajout de la table souplesse
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SUPREVISION' AND type = 'P' )
            DROP procedure sysadm.PS_SUPREVISION
GO

CREATE PROC sysadm.PS_SUPREVISION
            @dcIdProd  Decimal (7,0),
            @dcIdRev   Decimal (7,0)

AS

   /* Suppression des lignes dans la table DELAI */
   EXECUTE sysadm.IM_D01_DELAI @dcIdProd, @dcIdRev

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table PLAFOND */
   EXECUTE sysadm.IM_D01_PLAFOND @dcIdProd, @dcIdRev

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table FRANCHISE */
   EXECUTE sysadm.IM_D01_FRANCHISE @dcIdProd, @dcIdRev

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table CONDITION */
   EXECUTE sysadm.IM_D01_CONDITION @dcIdProd, @dcIdRev

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table MOTIF */
   EXECUTE sysadm.IM_D01_MOTIF @dcIdProd, @dcIdRev

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table PIECE */
   EXECUTE sysadm.IM_D01_PIECE @dcIdProd, @dcIdRev

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table GARANTIE */
   EXECUTE sysadm.IM_D01_GARANTIE @dcIdProd, @dcIdRev

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table ETABLISSEMENT */
   EXECUTE sysadm.IM_D01_ETABLISSEMENT @dcIdProd, @dcIdRev

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table AFFILIER      */
   EXECUTE sysadm.IM_D02_AFFILIER @dcIdProd, @dcIdRev

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

 /* Suppression des lignes dans la table SOUPLESSE      */
   EXECUTE sysadm.IM_D01_SOUPLESSE @dcIdProd, @dcIdRev

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END
GO