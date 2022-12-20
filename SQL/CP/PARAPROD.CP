-------------------------------------------------------------------
--
-- Fichier              :       Paraprod.cp
-- Auteur               :       YP
-- Date                 :       21/08/97 16:28:39
--
-- Commentaires         :       Liste des procédures stockées afférant à la table PARA_PROD
--
-- Procédures           :	
--                              IM_D01_PARA_PROD
--                              DW_S01_PARA_PROD
--                              DW_I01_PARA_PROD
--                              DW_D01_PARA_PROD
--                              DW_S02_PARA_PROD
--                              DW_S01_W_INTER_LST_PARA
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       IM_D01_PARA_PROD
-- Auteur               :       YP
-- Date                 :       21/08/97 16:29:55
-- Libellé              :       Delete sur table PARA_PROD
-- Commentaires         :
-- Références           :       PS_SUPPRODUIT
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 )
--
-- Retourne             :
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D01_PARA_PROD' AND type = 'P' )
            DROP procedure sysadm.IM_D01_PARA_PROD
GO

CREATE PROC sysadm.IM_D01_PARA_PROD
            @dcIdProd  decimal ( 7, 0 )

AS

  DELETE FROM sysadm.para_prod
        WHERE para_prod.id_prod = @dcIdProd

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_PARA_PROD
-- Auteur               :       YP
-- Date                 :       26/08/97 12:19:17
-- Libellé              :       Select sur la table PARA_PROD
-- Commentaires         :       Liste des paragraphes affectés à un Produit.
-- Références           :       W_TM_SP_PRODUIT, UO_INFO, D_SP_PROD_PARA
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_PARA_PROD' AND type = 'P' )
            DROP procedure sysadm.DW_S01_PARA_PROD
GO

CREATE PROC sysadm.DW_S01_PARA_PROD
            @dcIdProd  decimal ( 7, 0 )
AS

 SELECT para_prod.id_prod,
        para_prod.id_para,
        paragraphe.lib_para,
        para_prod.cree_le,
        para_prod.maj_le,
        para_prod.maj_par
   FROM sysadm.para_prod, sysadm.paragraphe
  WHERE para_prod.id_prod = @dcIdProd        AND
        para_prod.id_para = paragraphe.id_para


GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_PARA_PROD
-- Auteur               :       YP
-- Date                 :       26/08/97 12:23:49
-- Libellé              :       Insert sur la table PARA_PROD
-- Commentaires         :
-- Références           :       W_TM_SP_PRODUIT, UO_INFO, UE_DWSOURCE_SQLPREVIEW
--
-- Arguments            :       @dcIdProd       decimal ( 7, 0 ),
--                              @sIdPara        Varchar ( 4 ),
--                              @dtCreeLe       DateTime,
--                              @dtMajLe        DateTime,
--                              @sMajPar        Varchar ( 4 )
--
-- Retourne           :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_PARA_PROD' AND type = 'P' )
            DROP procedure sysadm.DW_I01_PARA_PROD
GO

CREATE PROC sysadm.DW_I01_PARA_PROD
  @dcIdProd       decimal ( 7, 0 ),
  @sIdPara        Varchar ( 4 ),
  @dtCreeLe       DateTime,
  @dtMajLe        DateTime,
  @sMajPar        Varchar ( 4 )
AS

 INSERT INTO sysadm.para_prod
           ( para_prod.id_prod,
             para_prod.id_para,
             para_prod.cree_le,
             para_prod.maj_le,
             para_prod.maj_par )
      VALUES
           ( @dcIdProd,
             @sIdPara,
             @dtCreeLe,
             @dtMajLe,
             @sMajPar )

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_PARA_PROD
-- Auteur               :       YP
-- Date                 :       26/08/97 12:26:50
-- Libellé              :       Delete sur la table PARA_PROD.
-- Commentaires         :
-- Références           :       W_TM_SP_PRODUIT, UO_INFO, UE_DWSOURCE_SQLPREVIEW 
--
-- Arguments            :       @dcIdProd     decimal ( 7, 0 ),
--                              @sIdPara      Varchar ( 4 )
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_PARA_PROD' AND type = 'P' )
            DROP procedure sysadm.DW_D01_PARA_PROD
GO

CREATE PROC sysadm.DW_D01_PARA_PROD
            @dcIdProd     decimal ( 7, 0 ),
            @sIdPara      Varchar ( 4 )
AS

 DELETE FROM sysadm.para_prod
       WHERE para_prod.id_prod = @dcIdProd    AND
             para_prod.id_para = @sIdPara

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_PARA_PROD
-- Auteur               :       YP
-- Date                 :       26/08/97 12:19:17
-- Libellé              :       Select sur la table PARA_PROD
-- Commentaires         :       Liste des paragraphes non affectés à un Produit.
-- Références           :       W_TM_SP_PRODUIT, UO_INFO, D_SP_LST_PAR_RCH
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_PARA_PROD' AND type = 'P' )
            DROP procedure sysadm.DW_S02_PARA_PROD
GO

CREATE PROC sysadm.DW_S02_PARA_PROD
            @dcIdProd  decimal ( 7, 0 )
AS

 SELECT convert ( decimal ( 7 ), null ),
        paragraphe.id_para,
        paragraphe.lib_para,
        convert ( datetime , null ),
        convert ( datetime , null ),
        ''
   FROM sysadm.paragraphe
  WHERE paragraphe.id_para NOT IN ( SELECT para_prod.id_para
                           FROM sysadm.para_prod
                          WHERE para_prod.id_prod = @dcIdProd )

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_W_INTER_LST_PARA
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Liste des paragraphes possibles pour un produit
-- Références           :       W_TD_SP_W_INTER
--
-- Arguments            :       @dcIdProd       decimal ( 7, 0 )                 (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_INTER_LST_PARA' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_INTER_LST_PARA
GO

CREATE procedure sysadm.DW_S01_W_INTER_LST_PARA
        @dcIdProd       decimal ( 7, 0 )
AS
 SELECT para_prod.id_para,
        paragraphe.lib_para,
        paragraphe.cpt_ver
 FROM   sysadm.paragraphe,
        sysadm.para_prod
 WHERE  para_prod.id_prod       = @dcIdProd     AND
        para_prod.id_para = paragraphe.id_para

GO
