-------------------------------------------------------------------
--
-- Fichier              :       W_PARAIN.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       Gestion de la table W_PARA_INFO dans SIMPA2
--
-- Procédures           :       DW_S01_W_INTER_PARA_AFFECTE
--                              DW_I01_W_PARA_INFO
--                              DW_D01_W_PARA_INFO
-------------------------------------------------------------------


--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_W_INTER_PARA_AFFECTE
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Liste des paragraphes affectés à un interlocuteur
-- Références           :       W_TD_SP_W_INTER
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_INTER_PARA_AFFECTE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_INTER_PARA_AFFECTE
GO

CREATE procedure sysadm.DW_S01_W_INTER_PARA_AFFECTE
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS
 SELECT w_para_info.id_sin,
        w_para_info.id_i,
        w_para_info.id_para,
        w_para_info.cpt_tri,
        w_para_info.cree_le,
        w_para_info.maj_le,
        w_para_info.maj_par,
        paragraphe.lib_para,
        paragraphe.cpt_ver
 FROM   sysadm.w_para_info,
        sysadm.paragraphe
 WHERE  w_para_info.id_sin      = @dcIdSin      AND
        w_para_info.id_para     = paragraphe.id_para

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_W_PARA_INFO
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion sur table W_PARA_INFO
-- Références           :       W_TM_SP_SINISTE, SqlPreview
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdI          Decimal (  7,0 )        (Val)
--                      :       @sIdPara        Varchar (  4 )          (Val)
--                      :       @dcCptTri       Decimal (  2,0 )        (Val)
--                      :       @dtCreeLe       DateTime                (Val)
--                      :       @dtMajLe        DateTime                (Val)
--                      :       @sMajPar        Varchar (  4 )          (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_W_PARA_INFO' AND type = 'P' )
        DROP procedure sysadm.DW_I01_W_PARA_INFO
GO


CREATE procedure sysadm.DW_I01_W_PARA_INFO
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdI          Decimal (  7,0 ),
        @sIdPara        Varchar (  4 )  ,
        @dcCptTri       Decimal (  2,0 ),
        @dtCreeLe       DateTime        ,
        @dtMajLe        DateTime        ,
        @sMajPar        Varchar (  4 )
AS
 INSERT INTO    sysadm.w_para_info
        (       w_para_info.id_sin,
                w_para_info.id_i,
                w_para_info.id_para,
                w_para_info.cpt_tri,
                w_para_info.cree_le,
                w_para_info.maj_le,
                w_para_info.maj_par                 )
 VALUES (       @dcIdSin,
                @dcIdI,
                @sIdPara,
                @dcCptTri,
                @dtCreeLe,
                @dtMajLe,
                @sMajPar                        )       

    

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_W_PARA_INFO
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Suppression d'un paragraphe d'information
-- Références           :       W_TM_SP_SINISTE, SqlPreview
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdI          Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_W_PARA_INFO' AND type = 'P' )
        DROP procedure sysadm.DW_D01_W_PARA_INFO
GO
CREATE procedure sysadm.DW_D01_W_PARA_INFO  
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdI          Decimal (  7,0 )
AS
 DELETE FROM    sysadm.w_para_info
 WHERE          w_para_info.id_sin          = @dcIdSin  AND
                w_para_info.id_i            = @dcIdI


GO

