-------------------------------------------------------------------
--
-- Fichier              :       W_REG_GT.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       Gestion de la table W_REG_GTI
--
-- Procédures           :       DW_I01_W_REG_GTI
--                      :       DW_D01_W_REG_GTI
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_W_REG_GTI
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion sur table W_REG_GTI
-- Références           :       W_TM_SP_SINISTE, SqlPreview
--
-- Arguments            :       @dcIdsin        Decimal (  7,0 )        (Val)
--                      :       @dcIdI          Decimal (  7,0 )        (Val)
--                      :       @dcIdGti        Decimal (  7,0 )        (Val)
--                      :       @dcIdRgpt       Decimal (  7,0 )        (Val)
--                      :       @dcIdReg        Decimal (  2,0 )        (Val)
--                      :       @dcMtReg        Decimal ( 11,2 )        (Val)
--                      :       @dcMtRgpt       Decimal ( 11,2 )        (Val)
--                      :       @dtCreeLe       DateTime                (Val)
--                      :       @dtMajLe        DateTime                (Val)
--                      :       @sMajPar        Varchar (  4 )          (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_W_REG_GTI' AND type = 'P' )
        DROP procedure sysadm.DW_I01_W_REG_GTI
GO


CREATE procedure sysadm.DW_I01_W_REG_GTI
        @dcIdsin        Decimal (  10,0 ), -- [PI062]
        @dcIdI          Decimal (  7,0 ),
        @dcIdGti        Decimal (  7,0 ),
        @dcIdRgpt       Decimal (  7,0 ),
        @dcIdReg        Decimal (  2,0 ),
        @dcMtReg        Decimal ( 11,2 ),
        @dcMtRgpt       Decimal ( 11,2 ),
        @dtCreeLe       DateTime        ,
        @dtMajLe        DateTime        ,
        @sMajPar        Varchar (  4 )
AS
 INSERT INTO    sysadm.w_reg_gti
        (       w_reg_gti.id_sin,
                w_reg_gti.id_i,
                w_reg_gti.id_gti,
                w_reg_gti.id_rgpt,
                w_reg_gti.id_reg,
                w_reg_gti.mt_reg,
                w_reg_gti.mt_rgpt,
                w_reg_gti.cree_le,
                w_reg_gti.maj_le,
                w_reg_gti.maj_par               )
 VALUES (       @dcIdsin,
                @dcIdI,
                @dcIdGti,
                @dcIdRgpt,
                @dcIdReg,
                @dcMtReg,
                @dcMtRgpt,
                @dtCreeLe,
                @dtMajLe,
                @sMajPar                )


GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_W_REG_GTI
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Suppression d'un ligne dans W_REG_GTI
-- Références           :       W_TM_SP_SINISTE, SqlPreview
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_W_REG_GTI' AND type = 'P' )
        DROP procedure sysadm.DW_D01_W_REG_GTI
GO

CREATE procedure sysadm.DW_D01_W_REG_GTI
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS

 DELETE FROM    sysadm.w_reg_gti
 WHERE          w_reg_gti.id_sin        = @dcIdSin


GO

