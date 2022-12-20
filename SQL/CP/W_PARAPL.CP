-------------------------------------------------------------------
--
-- Fichier              :       W_PARAPL.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       Gestion de la table W_PARA_PLAfOND dans SIMPA2
--
-- Procédures           :       DW_S01_W_PARA_PLAFOND
--                              DW_I01_W_PARA_PLAFOND
--                              DW_D01_W_PARA_PLAFOND
-------------------------------------------------------------------


--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_W_PARA_PLAFOND
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Liste des paragraphes de plafond
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_PARA_PLAFOND' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_PARA_PLAFOND
GO

CREATE procedure sysadm.DW_S01_W_PARA_PLAFOND
      @dcIdSin        Decimal (  10,0 )  -- [PI062]
AS
 SELECT w_para_plafond.id_sin,
        w_para_plafond.id_gti,
        w_para_plafond.id_detail,
        w_para_plafond.id_typ_plaf,
        w_para_plafond.id_para,
        w_para_plafond.id_i,
        w_para_plafond.cree_le,
        w_para_plafond.maj_le,
        w_para_plafond.maj_par,
        'N',
        paragraphe.cpt_ver
 FROM   sysadm.w_para_plafond
 LEFT OUTER JOIN sysadm.paragraphe
 ON     w_para_plafond.id_para          = paragraphe.id_para
 WHERE  w_para_plafond.id_sin           = @dcIdSin

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_W_PARA_PLAFOND
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion sur table W_PARA_PLAFOND
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdGti        Decimal (  7,0 )        (Val)
--                      :       @dcIdDetail     Decimal (  7,0 )        (Val)
--                      :       @sIdTypPlaf     Varchar (  4 )          (Val)
--                      :       @sIdPara        Varchar (  4 )          (Val)
--                      :       @dcIdI          Decimal (  7,0 )        (Val)
--                      :       @dtCreeLe       DateTime                (Val)
--                      :       @dtMajLe        DateTime                (Val)
--                      :       @sMajPar        Varchar (  4 )          (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_W_PARA_PLAFOND' AND type = 'P' )
        DROP procedure sysadm.DW_I01_W_PARA_PLAFOND
GO

CREATE procedure sysadm.DW_I01_W_PARA_PLAFOND
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdGti        Decimal (  7,0 ),
        @dcIdDetail     Decimal (  7,0 ),
        @sIdTypPlaf     Varchar (  4 )  ,
        @sIdPara        Varchar (  4 )  ,
        @dcIdI          Decimal (  7,0 ),
        @dtCreeLe       DateTime        ,
        @dtMajLe        DateTime        ,
        @sMajPar        Varchar (  4 )
AS
 INSERT INTO    sysadm.w_para_plafond
        (       w_para_plafond.id_sin,
                w_para_plafond.id_gti,
                w_para_plafond.id_detail,
                w_para_plafond.id_typ_plaf,
                w_para_plafond.id_para,
                w_para_plafond.id_i,
                w_para_plafond.cree_le,
                w_para_plafond.maj_le,
                w_para_plafond.maj_par                 )
 VALUES (       @dcIdSin,
                @dcIdGti,
                @dcIdDetail,
                @sIdTypPlaf,
                @sIdPara,
                @dcIdI,
                @dtCreeLe,
                @dtMajLe,
                @sMajPar                        )       


GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_W_PARA_PLAFOND
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Suppression des paragraphes de plafond
-- Références           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdDetail     Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_W_PARA_PLAFOND' AND type = 'P' )
        DROP procedure sysadm.DW_D01_W_PARA_PLAFOND
GO

CREATE procedure sysadm.DW_D01_W_PARA_PLAFOND
        @dcIdSin        Decimal (  10,0 ), --  [PI062]
        @dcIdGti        Decimal (  7,0 ),
        @dcIdDetail     Decimal (  7,0 )
AS
 DELETE FROM    sysadm.w_para_plafond
 WHERE          w_para_plafond.id_sin           = @dcIdSin      AND
                w_para_plafond.id_gti           = @dcIdGti      AND
                w_para_plafond.id_detail        = @dcIdDetail
GO

