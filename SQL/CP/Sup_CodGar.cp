-------------------------------------------------------------------
--
-- Fichier              :       Sup_CodGar.cp
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 17:15:08
--
-- Commentaires         :       Suppression d'un code garantie.
--
-- Procédures           :       PS_SUPCODEGARANTIE
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       PS_SUPCODEGARANTIE
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 17:15:03
-- Libellé              :       Procedure appelée pour supprimer toutes les lignes dans les tables
--
--                              PIECE
--                              MOTIF
--                              CODE_CONDITION
--                              CODE_GARANTIE
--
--                              Lors de la suppression d'un code garantie
--
-- Commentaires         :
-- Références           :
--
-- Arguments            :       @dcIdProd       Decimal (  7,0 )        (Val)
--                              @dcIdRev        Decimal (  7,0 )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_SUPCODEGARANTIE' AND type = 'P' )
            DROP procedure sysadm.PS_SUPCODEGARANTIE
GO

CREATE PROC sysadm.PS_SUPCODEGARANTIE
        @dcIdProd       Decimal (  7,0 ),
        @dcIdRev        Decimal (  7,0 ),
        @dcIdGti        Decimal (  7,0 )

AS

   /* Suppression des lignes dans la table CONDITION */
   EXECUTE sysadm.IM_D01_CODE_CONDITION @dcIdProd, @dcIdGti

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table MOTIF */
   EXECUTE sysadm.IM_D02_MOTIF @dcIdProd, @dcIdRev, @dcIdGti

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table PIECE */
   EXECUTE sysadm.IM_D02_PIECE @dcIdProd, @dcIdRev, @dcIdGti

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

   /* Suppression des lignes dans la table CODE_GARANTIE */
   EXECUTE sysadm.IM_D01_CODE_GARANTIE @dcIdProd, @dcIdGti

   IF @@ERROR <> 0
     BEGIN
      RETURN
     END

GO
