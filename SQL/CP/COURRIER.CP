-------------------------------------------------------------------
--
-- Fichier              :       courrier.cp
-- Auteur               :       La Recrue
-- Date                 :       22/07/97 14:07:27
--
-- Commentaires         :       Liste des proc afférant à la table courrier
--
-- Procédures           :
--                              DW_S01_COURRIER
--                              DW_I01_COURRIER
--                              DW_D01_COURRIER
--                              IM_D01_COURRIER
--                              DW_S02_COURRIER
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_COURRIER
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 13:35:17
-- Libellé              :       Select sur les tables COURRIER ET CODE.
-- Commentaires         :       Liste des Codes Courriers affectes a un Produit.
-- Références           :       W_TM_SP_PRODUIT, UO_COURRIER, D_SP_PROD_COUR
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_COURRIER' AND type = 'P' )
            DROP procedure sysadm.DW_S01_COURRIER
GO

CREATE PROC sysadm.DW_S01_COURRIER
            @dcIdProd  decimal ( 7, 0 )
AS

 SELECT courrier.id_prod,
        courrier.id_nat_cour,
        code_car.lib_code,
        courrier.id_cour,
        courrier.id_conf_deb,
        courrier.id_conf_n,
        courrier.id_conf_fin,
        courrier.alt_conf,
        courrier.cree_le,
        courrier.maj_le,
        courrier.maj_par
   FROM sysadm.courrier,
        sysadm.code_car
  WHERE courrier.id_prod     = @dcIdProd        AND
        code_car.id_typ_code = '-CC'            AND
        courrier.id_nat_cour = code_car.id_code

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_COURRIER
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 15:34:49
-- Libellé              :       Insert sur la table COURRIER.
-- Commentaires         :
-- Références           :       W_TM_SP_PRODUIT, UO_COURRIER, UE_DWSOURCE_SQLPREVIEW
--
-- Arguments            :       @dcIdProd       decimal ( 7, 0 ),
--                              @sIdNatCour     Varchar ( 6 ),
--                              @sIdCour        Varchar ( 6 ),
--                              @sIdConfDeb     Varchar ( 6 ),
--                              @sIdConfN       Varchar ( 6 ),
--                              @sIdConfFin     Varchar ( 6 ),
--                              @sAltConf       Varchar ( 1 ),
--                              @dtCreeLe       DateTime,
--                              @dtMajLe        DateTime,
--                              @sMajPar        Varchar ( 4 )
--
-- Retourne           :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_COURRIER' AND type = 'P' )
            DROP procedure sysadm.DW_I01_COURRIER
GO

CREATE PROC sysadm.DW_I01_COURRIER
  @dcIdProd       decimal ( 7, 0 ),
  @sIdNatCour     Varchar ( 6 ),
  @sIdCour        Varchar ( 6 ),
  @sIdConfDeb     Varchar ( 6 ),
  @sIdConfN       Varchar ( 6 ),
  @sIdConfFin     Varchar ( 6 ),
  @sAltConf       Varchar ( 1 ),
  @dtCreeLe       DateTime,
  @dtMajLe        DateTime,
  @sMajPar        Varchar ( 4 )
AS

 INSERT INTO sysadm.courrier
           ( courrier.id_prod,
             courrier.id_nat_cour,
             courrier.id_cour,
             courrier.id_conf_deb,
             courrier.id_conf_n,
             courrier.id_conf_fin,
             courrier.alt_conf,
             courrier.cree_le,
             courrier.maj_le,
             courrier.maj_par )
      VALUES
           ( @dcIdProd,
             @sIdNatCour,
             @sIdCour,
             @sIdConfDeb,
             @sIdConfN,
             @sIdConfFin,
             @sAltConf,
             @dtCreeLe,
             @dtMajLe,
             @sMajPar )

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_COURRIER
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 15:41:50
-- Libellé              :       Delete sur la table COURRIER.
-- Commentaires         :
-- Références           :       W_TM_SP_PRODUIT, UO_COURRIER, UE_DWSOURCE_SQLPREVIEW 
--
-- Arguments            :       @dcIdProd     decimal ( 7, 0 ),
--                              @sIdNatCour   Varchar ( 6 )
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_COURRIER' AND type = 'P' )
            DROP procedure sysadm.DW_D01_COURRIER
GO

CREATE PROC sysadm.DW_D01_COURRIER
            @dcIdProd     decimal ( 7, 0 ),
            @sIdNatCour   Varchar ( 6 )
AS

 DELETE FROM sysadm.courrier
       WHERE courrier.id_prod     = @dcIdProd    AND
             courrier.id_nat_cour = @sIdNatCour

GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_D01_COURRIER
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 17:47:07
-- Libellé              :
-- Commentaires         :
-- Références           :       (Datawindow, Objet, Fenêtre Script ... )
--
-- Arguments            :
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D01_COURRIER' AND type = 'P' )
            DROP procedure sysadm.IM_D01_COURRIER
GO

CREATE PROC sysadm.IM_D01_COURRIER
            @dcIdProd  decimal ( 7, 0 )
AS

 DELETE FROM sysadm.courrier
        WHERE courrier.id_prod = @dcIdProd

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_COURRIER
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       S‚lect sur les tables COURRIER et CODE
--                              Permet de r‚cup‚rer les courriers … joindre ...
-- Références           :       Utilis‚ dans W_TM_SP_INTER
--
-- Arguments            :       @dcIdProd       decimal ( 7, 0 )                 (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_COURRIER' AND type = 'P' )
        DROP procedure sysadm.DW_S02_COURRIER
GO

CREATE procedure sysadm.DW_S02_COURRIER
        @dcIdProd        decimal ( 7, 0 )      
AS
 SELECT courrier.id_prod,
        courrier.id_nat_cour,
        code_car.lib_code,
        courrier.id_cour
   FROM sysadm.courrier,
        sysadm.code_car
  WHERE courrier.id_prod     = @dcIdProd        AND
        code_car.id_typ_code = '-CC'            AND
        courrier.id_nat_cour = code_car.id_code AND
        courrier.id_nat_cour like 'Z%'

GO


