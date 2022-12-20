-------------------------------------------------------------------
--
-- Fichier              :       W_PIECE.CP
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
--
-- Commentaires         :       Gestion des pieces dans SIMPA2
--
-- Procédures           :       DW_S01_W_PIECE
--                              DW_I01_W_PIECE
--                              DW_D01_W_PIECE
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_W_PIECE
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Sélect sur la table W_PIECE
-- Références           :       Utilisé dans W_TM_SP_SINISTRE 
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_PIECE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_PIECE
GO

CREATE procedure sysadm.DW_S01_W_PIECE
        @dcIdSin        Decimal (  10,0 ) -- [PI062]
AS
 SELECT w_piece.id_sin,
        w_piece.id_gti,
        w_piece.id_detail,
        w_piece.id_pce,
        w_piece.id_i,
        w_piece.id_para,
        w_piece.cpt_tri,
        w_piece.cree_le,
        w_piece.maj_le,
        w_piece.maj_par,
        paragraphe.cpt_ver,
        'O',
        code.lib_code,
        'O',
        w_piece.id_i
 FROM   sysadm.w_piece,
        sysadm.paragraphe,
        sysadm.code
 WHERE  w_piece.id_sin          = @dcIdSin              AND
        w_piece.id_para         = paragraphe.id_para    AND
        w_piece.id_pce          = code.id_code          AND
        code.id_typ_code        = '+PC'

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_W_PIECE
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Insertion sur table W_PIECE
-- Références           :       W_TM_SP_SINISTE, SqlPreview
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                      :       @dcIdGti        Decimal (  7,0 )        (Val)
--                      :       @dcIdDetail     Decimal (  7,0 )        (Val)
--                      :       @dcIdPce        Decimal (  7,0 )        (Val)
--                      :       @dcIdI          Decimal (  7,0 )        (Val)
--                      :       @sIdPara        Varchar (  1 )          (Val)
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

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_W_PIECE' AND type = 'P' )
        DROP procedure sysadm.DW_I01_W_PIECE
GO

CREATE procedure sysadm.DW_I01_W_PIECE
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdGti        Decimal (  7,0 ),
        @dcIdDetail     Decimal (  7,0 ),
        @dcIdPce        Decimal (  7,0 ),
        @dcIdI          Decimal (  7,0 ),
        @sIdPara        Varchar (  4 )  ,
        @dcCptTri       Decimal (  2,0 ),
        @dtCreeLe       DateTime        ,
        @dtMajLe        DateTime        ,
        @sMajPar        Varchar (  4 )
AS
 INSERT INTO    sysadm.w_piece
        (       w_piece.id_sin,
                w_piece.id_gti,
                w_piece.id_detail,
                w_piece.id_pce,
                w_piece.id_i,
                w_piece.id_para,
                w_piece.cpt_tri,
                w_piece.cree_le,
                w_piece.maj_le,
                w_piece.maj_par         )
 VALUES (       @dcIdSin,
                @dcIdGti,
                @dcIdDetail,
                @dcIdPce,
                @dcIdI,
                @sIdPara,
                @dcCptTri,
                @dtCreeLe,
                @dtMajLe,
                @sMajPar                )


GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_W_PIECE
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :       
-- Commentaires         :       Suppression de la liste des pieces d'une garantie
-- Références           :       W_TM_SP_SINISTE, SqlPreview
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--                              @dcIdGti        Decimal (  7,0 )        (Val)
--                              @dcIdDetail     Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien            
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_W_PIECE' AND type = 'P' )
        DROP procedure sysadm.DW_D01_W_PIECE
GO

CREATE procedure sysadm.DW_D01_W_PIECE
        @dcIdSin        Decimal (  10,0 ), -- [PI062]
        @dcIdGti        Decimal (  7,0 ),
        @dcIdDetail     Decimal (  7,0 )
AS
 DELETE FROM    sysadm.w_piece
 WHERE          w_piece.id_sin          = @dcIdSin  AND
                w_piece.id_gti          = @dcIdGti  AND        
                w_piece.id_detail       = @dcIdDetail

GO


