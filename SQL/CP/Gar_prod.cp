-------------------------------------------------------------------
--
-- Fichier              :       Gar_prod.cp
-- Auteur               :       La Recrue
-- Date                 :       18/07/97 10:29:52
--
-- Commentaires         :       Liste des procédures stokées afférant à la 
--                              table des garanties
--
-- Procédures           :
--                              IM_I01_GARANTIE
--                              IM_D01_GARANTIE
--                              IM_D02_GARANTIE
--                              IM_S03_GARANTIE
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       IM_I01_GARANTIE
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 14:54:08
-- Libellé              :       Insert sur la table GARANTIE.
-- Commentaires         :       Utilise pou dupliquer les GARANTIES de la derniere REVISION lors de
--                              la création d'une nouvelle REVISION.
-- Références           :       W_Tm_Sp_Produit, Wf_TerminerValider () U_SP_GS_REV_PROD, Uf_TerminerValider ()
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 ),
--                              @dcIdRev         decimal ( 7, 0 ),
--                              @dcIdRevAnc      decimal ( 7, 0 ),
--                              @dtCreeLe        DateTime,
--                              @dtMajLe         DateTime,
--                              @sMajPar         Varchar ( 4 )
--
-- Retourne             :
--
-------------------------------------------------------------------
-- MAJ	PAR	LE		Description
-- #1	PHG	11/08/2008	Correction Bug Id_prefixe non dupliqué.
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_I01_GARANTIE' AND type = 'P' )
            DROP procedure sysadm.IM_I01_GARANTIE
GO

CREATE PROC sysadm.IM_I01_GARANTIE
       @dcIdProd        decimal ( 7, 0 ),
       @dcIdRev         decimal ( 7, 0 ),
       @dcIdRevAnc      decimal ( 7, 0 ),
       @dtCreeLe        DateTime,
       @dtMajLe         DateTime,
       @sMajPar         Varchar ( 4 )
AS

INSERT INTO sysadm.garantie  
          ( sysadm.garantie.id_prod,   
           sysadm.garantie.id_rev,   
           sysadm.garantie.id_gti,   
           sysadm.garantie.id_police,   
           sysadm.garantie.cod_typ_fra,
           sysadm.garantie.cod_radical,
           sysadm.garantie.alt_plaf,
           sysadm.garantie.alt_del,
           sysadm.garantie.alt_fran,
           sysadm.garantie.cree_le,
           sysadm.garantie.maj_le,
           sysadm.garantie.maj_par,
           sysadm.garantie.id_prefixe ) -- #1
SELECT     sysadm.garantie.id_prod,   
           @dcIdRev,
           sysadm.garantie.id_gti,   
           sysadm.garantie.id_police,   
           sysadm.garantie.cod_typ_fra,
           sysadm.garantie.cod_radical,
           sysadm.garantie.alt_plaf,
           sysadm.garantie.alt_del,
           sysadm.garantie.alt_fran,
           @dtCreeLe,
           @dtMajLe,
           @sMajPar,
           sysadm.garantie.id_prefixe -- #1
FROM       sysadm.garantie
WHERE      garantie.id_prod = @dcIdProd   AND
           garantie.id_rev  = @dcIdRevAnc

GO
  
--------------------------------------------------------------------
--
-- Procédure            :       IM_D01_GARANTIE
-- Auteur               :       La Recrue
-- Date                 :       22/07/97 17:10:23
-- Libellé              :       Delete sur table GARANTIE.
-- Commentaires         :
-- Références           :       PS_SUPREVISION
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 ),
--                              @dcIdRev   decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D01_GARANTIE' AND type = 'P' )
            DROP procedure sysadm.IM_D01_GARANTIE
GO

CREATE PROC sysadm.IM_D01_GARANTIE
            @dcIdProd  decimal ( 7, 0 ),
            @dcIdRev   decimal ( 7, 0 )
AS

 DELETE FROM sysadm.garantie
       WHERE garantie.id_prod = @dcIdProd AND
             garantie.id_rev  = @dcIdRev

GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_D02_GARANTIE
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 17:44:59
-- Libellé              :       Delete sur table GARANTIE.
-- Commentaires         :
-- Références           :       PS_SUPPRODUIT 
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D02_GARANTIE' AND type = 'P' )
            DROP procedure sysadm.IM_D02_GARANTIE
GO

CREATE PROC sysadm.IM_D02_GARANTIE
            @dcIdProd  decimal ( 7, 0 )
AS

 DELETE FROM sysadm.garantie
       WHERE garantie.id_prod = @dcIdProd

GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_S03_GARANTIE
-- Auteur               :       La Recrue
-- Date                 :       22/07/97 13:47:50
-- Libellé              :       permet de savoir si le code garantie que l'on desire supprimer n'est
--                              pas lie à une garantie.
--
-- Commentaires         :       U_SP_GS_CODE_GARANTIE, Uf_SuppLigne ()
-- Références           :
--
-- Arguments            :       @dcIdProd     decimal ( 7, 0 ),        Id produit
--                              @dcIdGti      decimal ( 7, 0 ),        id garantie
--                              @iNbGarantie  Integer OUTPUT  Nombre trouvé
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_S03_GARANTIE' AND type = 'P' )
            DROP procedure sysadm.IM_S03_GARANTIE
GO

CREATE PROC sysadm.IM_S03_GARANTIE
            @dcIdProd       decimal ( 7, 0 ),
            @dcIdGti        decimal ( 7, 0 ),
            @iNbGarantie    Integer OUTPUT
AS

SELECT  garantie.id_gti
FROM    sysadm.garantie
WHERE   garantie.id_prod = @dcIdProd AND
        garantie.id_gti  = @dcIdGti

SELECT	@iNbGarantie = @@ROWCOUNT

GO


