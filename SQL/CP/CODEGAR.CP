-------------------------------------------------------------------
--
-- Fichier              :       codegar.cp
-- Auteur               :       La Recrue
-- Date                 :       18/07/97 11:45:39
--
-- Commentaires         :       Liste des procédure afférant à la tables CODE_GARANTIE
--
-- Procédures           :       DD_S01_CODE_GARANTIE
--                              DW_S01_CODE_GARANTIE
--                              DW_I01_CODE_GARANTIE
--                              IM_D01_CODE_GARANTIE
--                              IM_D02_CODE_GARANTIE
--                              IM_S01_CODE_GARANTIE
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DD_S01_CODE_GARANTIE
-- Auteur               :       YP
-- Date                 :       08/09/97 12:06:31
-- Libellé              :       Sélection des garanties définies pour un produit
--                              donné toute révision confondue
-- Commentaires         :
-- Références           :       dddw_sp_code_garantie
--
-- Arguments            :       @DcIdProd      decimal ( 7, 0 )     Produit.
--
-- Retourne             :       ResultSet
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S01_CODE_GARANTIE' AND type = 'P' )
            DROP procedure sysadm.DD_S01_CODE_GARANTIE
GO

CREATE PROC sysadm.DD_S01_CODE_GARANTIE
            @dcIdProd    decimal ( 7, 0 )
AS

SELECT  code_garantie.id_gti,
        code_garantie.lib_gti
FROM    sysadm.code_garantie
WHERE   code_garantie.id_prod = @dcIdProd

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_CODE_GARANTIE
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 13:39:57
-- Libellé              :       Select sur les tables CODE_GARANTIE.
-- Commentaires         :       Liste des Garantie associees à un produit.
-- Références           :       W_TM_SP_PRODUIT, UO_GARANTIE, D_SP_PROD_GAR
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_CODE_GARANTIE' AND type = 'P' )
            DROP procedure sysadm.DW_S01_CODE_GARANTIE
GO

CREATE PROC sysadm.DW_S01_CODE_GARANTIE
            @dcIdProd  decimal ( 7, 0 )
AS

 SELECT code_garantie.id_prod,
        code_garantie.id_gti,
        code_garantie.lib_gti,
        code_garantie.mt_cmt,
        code_garantie.cod_rgpt_stat,    
        code_garantie.cree_le,
        code_garantie.maj_le,
        code_garantie.maj_par
   FROM sysadm.code_garantie
  WHERE code_garantie.id_prod = @dcIdProd

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_CODE_GARANTIE
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 15:47:55
-- Libellé              :       Insert sur la table CODE_GARANTIE.
-- Commentaires         :
-- Références           :       W_TM_SP_PRODUIT, UO_GARANTIE, UE_DWSOURCE_SQLPREVIEW 
--
-- Arguments            :       @dcIdProd      decimal ( 7, 0 ),
--                              @dcIdGti       decimal ( 7, 0 ),
--                              @sLibGti       Varchar ( 35 ),
--                              @dcMtCmt       Decimal(11,2),
--                              @dcCodRgptStat decimal ( 7, 0 ),
--                              @dtCreeLe      DateTime,
--                              @dtMajLe       DateTime,
--                              @sMajPar       Varchar ( 4 )
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_CODE_GARANTIE' AND type = 'P' )
            DROP procedure sysadm.DW_I01_CODE_GARANTIE
GO

CREATE PROC sysadm.DW_I01_CODE_GARANTIE
            @dcIdProd      decimal ( 7, 0 ),
            @dcIdGti       decimal ( 7, 0 ),
            @sLibGti       Varchar ( 35 ),
            @dcMtCmt       Decimal(11,2),
            @dcCodRgptStat decimal ( 7, 0 ),
            @dtCreeLe      DateTime,
            @dtMajLe       DateTime,
            @sMajPar       Varchar ( 4 )

AS

 INSERT INTO sysadm.code_garantie
           ( code_garantie.id_prod,
             code_garantie.id_gti,
             code_garantie.lib_gti,
             code_garantie.mt_cmt,
             code_garantie.cod_rgpt_stat,
             code_garantie.cree_le,
             code_garantie.maj_le,
             code_garantie.maj_par )
      VALUES
           ( @dcIdProd, @dcIdGti, @sLibGti, @dcMtCmt, @dcCodRgptStat,
             @dtCreeLe, @dtMajLe, @sMajPar )

GO


--------------------------------------------------------------------
--
-- Procédure            :       IM_D01_CODE_GARANTIE
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 15:53:44
-- Libellé              :       Delete sur la table CODE_GARANTIE.
-- Commentaires         :
-- Références           :       PS_SUPCODEGARANTIE
--
-- Arguments            :       @dcIdProd     decimal ( 7, 0 ),
--                              @dcIdGti      decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D01_CODE_GARANTIE' AND type = 'P' )
            DROP procedure sysadm.IM_D01_CODE_GARANTIE
GO

CREATE PROC sysadm.IM_D01_CODE_GARANTIE
            @dcIdProd     decimal ( 7, 0 ),
            @dcIdGti      decimal ( 7, 0 )
AS

 DELETE FROM sysadm.code_garantie
 WHERE       code_garantie.id_prod = @dcIdProd AND
             code_garantie.id_gti  = @dcIdGti

GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_D02_CODE_GARANTIE
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 17:34:49
-- Libellé              :       Delete sur table CODE_GARANTIE.
-- Commentaires         :
-- Références           :       PS_SUPPRODUIT 
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D02_CODE_GARANTIE' AND type = 'P' )
            DROP procedure sysadm.IM_D02_CODE_GARANTIE
GO

CREATE PROC sysadm.IM_D02_CODE_GARANTIE
            @dcIdProd  decimal ( 7, 0 )
AS

 DELETE FROM sysadm.code_garantie
       WHERE code_garantie.id_prod = @dcIdProd

GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_S01_CODE_GARANTIE
-- Auteur               :       N°6
-- Date                 :       12/08/97 09:52:50
-- Libellé              :       permet de savoir si la garantie que l'on desire parametrer 
--                              existe toujours pour ce produit.
--
-- Commentaires         :       U_SP_GS_GARANTIE, Uf_PreparerValider ()
-- Références           :
--
-- Arguments            :       @dcIdProd    decimal ( 7, 0 ),        Id produit
--                              @dcIdGti     decimal ( 7, 0 ),        Id garantie
--                              @iNbGarantie Integer OUTPUT  Nombre trouvé
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_S01_CODE_GARANTIE' AND type = 'P' )
            DROP procedure sysadm.IM_S01_CODE_GARANTIE
GO

CREATE PROC sysadm.IM_S01_CODE_GARANTIE
            @dcIdProd     decimal ( 7, 0 ),
            @dcIdGti      decimal ( 7, 0 ),
            @iNbGarantie  Integer OUTPUT
AS

 SELECT code_garantie.id_gti
   FROM sysadm.code_garantie
  WHERE code_garantie.id_prod = @dcIdProd AND
        code_garantie.id_gti  = @dcIdGti

SELECT	@iNbGarantie = @@ROWCOUNT

GO

