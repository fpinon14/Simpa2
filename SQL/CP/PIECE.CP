-------------------------------------------------------------------
--
-- Fichier              :       Piece.cp
-- Auteur               :       La Recrue
-- Date                 :       22/07/97 13:03:49
--
-- Commentaires         :       Liste des procédures stockées afférent à la table piece
--
-- Procédures           :
--                              DW_S01_PIECE
--                              DW_S02_PIECE
--                              DW_S03_PIECE
--                              DW_S04_PIECE_SIN
--                              DW_I01_PIECE
--                              DW_U01_PIECE
--                              DW_D01_PIECE
--                              IM_D01_PIECE
--                              IM_D03_PIECE
--                              IM_D02_PIECE
--                              IM_I01_PIECE
-------------------------------------------------------------------



--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_PIECE
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 13:42:38
-- Libellé              :       Sélection de toutes les pieces pour un produit
-- Commentaires         :       d'une révision donnée.
-- Références           :       w_td_sp_code_condition, uo_pieces, dw_source, D_SP_PROD_PCE
--
-- Arguments            :       @dcIdProduit     decimal ( 7, 0 ),
--                              @dcIdRev         decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_PIECE' AND type = 'P' )
            DROP procedure sysadm.DW_S01_PIECE
GO

CREATE PROC sysadm.DW_S01_PIECE
            @dcIdProduit    decimal ( 7, 0 ),
            @dcIdRev        decimal ( 7, 0 )
AS
 SELECT sysadm.piece.id_prod,
        sysadm.piece.id_rev,
        sysadm.piece.id_gti,
        sysadm.piece.id_pce,
        sysadm.code.lib_code,
        sysadm.piece.id_para,
        sysadm.piece.cod_typ_pce,
        sysadm.piece.cree_le,
        sysadm.piece.maj_le,
        sysadm.piece.maj_par,
	sysadm.piece.cpt_tri
   FROM sysadm.piece,
        sysadm.code
  WHERE sysadm.piece.id_prod    = @dcIdProduit         AND
        sysadm.piece.id_rev     = @dcIdRev             AND
        sysadm.piece.id_pce     = sysadm.code.id_code  AND
        sysadm.code.id_typ_code = '+PC'

GO


--------------------------------------------------------------------
--
-- Procédure            :   DW_S02_PIECE
-- Auteur               :   V.Capelle
-- Date                 :   18/11/1997 11:58:11
-- Libellé              :   Sélection des pieces non paramétrées dans 
--                          les conditions générales d'un produit 
--                          pour la gestion des garanties
-- Commentaires         :   
-- Références           :   w_t_sp_condition_gar, uo_pieces ( Recherche )
--
-- Arguments            :   @dcIdProduit     decimal ( 7, 0 ),
--                          @dcIdGti         decimal ( 7, 0 )
-- Retourne             :   
--                          
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_PIECE' AND type = 'P' )
            DROP procedure sysadm.DW_S02_PIECE
GO

CREATE PROC sysadm.DW_S02_PIECE
            @dcIdProduit    decimal ( 7, 0 ),
            @dcIdGti        decimal ( 7, 0 )
AS

 SELECT CONVERT ( decimal (7),  null ),
        CONVERT ( decimal (7),  null ),
        CONVERT ( decimal (7),  null ),
        sysadm.code.id_code,
        sysadm.code.lib_code,
        '',
        'G',
        CONVERT ( DateTime, Null ),
        CONVERT ( DateTime, Null ),
        '',
	0
   FROM sysadm.code
  WHERE sysadm.code.id_typ_code = '+PC' And
        id_code not in ( SELECT sysadm.piece.id_pce 
                           FROM sysadm.piece
                          WHERE sysadm.piece.id_prod = @dcIdProduit AND
                                sysadm.piece.id_gti  = @dcIdGti     AND
                                sysadm.piece.id_rev  = -1 )

GO

--------------------------------------------------------------------
--
-- Procédure            :   DW_S03_PIECE
-- Auteur               :   V.Capelle
-- Date                 :   18/11/1997 14:32:11
-- Libellé              :   Sélection des pieces non paramétrées dans 
--                          les conditions générales d'un produit 
--                          pour la gestion des garanties
-- Commentaires         :   
-- Références           :   w_t_sp_condition_gar, uo_pieces ( Source )
--
-- Arguments            :   @dcIdProduit     decimal ( 7, 0 ),
--                          @dcIdRev         decimal ( 7, 0 ),
--                          @dcIdGti         decimal ( 7, 0 )
-- Retourne             :   
--                          
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_PIECE' AND type = 'P' )
            DROP procedure sysadm.DW_S03_PIECE
GO

CREATE PROC sysadm.DW_S03_PIECE
            @dcIdProduit    decimal ( 7, 0 ),
            @dcIdRev        decimal ( 7, 0 ),
            @dcIdGti        decimal ( 7, 0 )
AS

 SELECT sysadm.piece.id_prod,
        sysadm.piece.id_rev,
        sysadm.piece.id_gti,
        sysadm.piece.id_pce,
        sysadm.code.lib_code,
        sysadm.piece.id_para,
        sysadm.piece.cod_typ_pce,
        sysadm.piece.cree_le,
        sysadm.piece.maj_le,
        sysadm.piece.maj_par,
        sysadm.piece.cpt_tri
   FROM sysadm.piece, sysadm.code
  WHERE sysadm.piece.id_prod    = @dcIdProduit AND
        sysadm.piece.id_rev     = @dcIdRev     AND
        sysadm.piece.id_gti     = @dcIdGti     AND
        sysadm.piece.id_pce     = sysadm.code.id_code AND
        sysadm.code.id_typ_code = '+PC' 
                               
GO
--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_PIECE
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 18:08:54
-- Libellé              :       Insertion d'une piece affectée à une garantie
-- Commentaires         :
-- Références           :       w_tm_sp_produit , dw_pieces, sqlpreview
--
-- Arguments            :       @dcIdProd      decimal ( 7, 0 ),
--                              @dcIdrev       decimal ( 7, 0 ),
--                              @dcIdGti       decimal ( 7, 0 ),
--                              @dcIdPce       decimal ( 7, 0 ),
--                              @sIdPara       Varchar(4),
--                              @sCodTypPce    Char(1),
--                              @dtCreeLe      DateTime,
--                              @dtMajLe       DateTime,
--                              @sMajPar       Varchar(4)
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_PIECE' AND type = 'P' )
            DROP procedure sysadm.DW_I01_PIECE
GO

CREATE PROC sysadm.DW_I01_PIECE
@dcIdProd      decimal ( 7, 0 ),
@dcIdRev       decimal ( 7, 0 ),
@dcIdGti       decimal ( 7, 0 ),
@dcIdPce       decimal ( 7, 0 ),
@sIdPara       Varchar(4),
@sCodTypPce    Char(1),
@dtCreeLe      DateTime,
@dtMajLe       DateTime,
@sMajPar       Varchar(4),
@dcCptTri      decimal ( 2, 0 )
AS
 INSERT INTO sysadm.piece
             ( sysadm.piece.id_prod,
               sysadm.piece.id_rev,
               sysadm.piece.id_gti,
               sysadm.piece.id_pce,
               sysadm.piece.id_para,
               sysadm.piece.cod_typ_pce,
               sysadm.piece.cree_le,
               sysadm.piece.maj_le,
               sysadm.piece.maj_par,
	       sysadm.piece.cpt_tri )
      VALUES ( @dcIdProd,
               @dcIdRev,
               @dcIdGti,
               @dcIdPce,
               @sIdPara,
               @sCodTypPce,
               @dtCreeLe,
               @dtMajLe,
               @sMajPar, 
	       @dcCptTri )
GO

--------------------------------------------------------------------
--
-- Procédure            :   DW_U01_PIECE
-- Auteur               :   V.Capelle
-- Date                 :   18/11/1997 16:14:54
-- Libellé              :   Update sur la table piece
-- Commentaires         :   
-- Références           :   w_t_sp_condition_gar, uo_pieces ( Source )
--
-- Arguments            :   @dcIdProd   decimal ( 7, 0 )
--                          @dcIdRev    decimal ( 7, 0 )
--                          @dcIdGti    decimal ( 7, 0 )
--                          @dcIdPce    decimal ( 7, 0 )
--                          @sIdPara    VarChar ( 4 )
--                          @sCodTypPce VarChar ( 1 )
--                          @dtMajLe    DateTime
--                          @sMajPar    VarChar ( 4 )
--
-- Retourne             :   
--                          
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_U01_PIECE' AND type = 'P' )
            DROP procedure sysadm.DW_U01_PIECE
GO

CREATE PROC sysadm.DW_U01_PIECE
            @dcIdProd     decimal ( 7, 0 ),
            @dcIdRev      decimal ( 7, 0 ),
            @dcIdGti      decimal ( 7, 0 ),
            @dcIdPce      decimal ( 7, 0 ),
            @sIdPara      VarChar ( 4 ),
            @sCodTypPce   VarChar ( 1 ),   
            @dtMajLe      DateTime,
            @sMajPar      Varchar(4),
	      @dcCptTri	  decimal ( 2, 0 )
AS

  UPDATE sysadm.piece
     SET sysadm.piece.id_para         = @sIdPara   ,
         sysadm.piece.cod_typ_pce     = @sCodTypPce,
         sysadm.piece.maj_le          = @dtMajLe   ,
         sysadm.piece.maj_par         = @sMajPar,
	 sysadm.piece.cpt_tri	      = @dcCptTri
   WHERE sysadm.piece.id_prod         = @dcIdProd AND
         sysadm.piece.id_rev          = @dcIdRev  AND
         sysadm.piece.id_gti          = @dcIdGti  AND
         sysadm.piece.id_pce          = @dcIdPce 

GO





--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_PIECE
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 18:33:02
-- Libellé              :       Destruction d'une pieces  
-- Commentaires         :
-- Références           :       w_tm_sp_produit , dw_pieces, SqlPreview
--
-- Arguments            :       @dcIdProd      decimal ( 7, 0 ),
--                              @dcIdRev       decimal ( 7, 0 ),
--                              @dcIdGti       decimal ( 7, 0 ),
--                              @dcIdPce       decimal ( 7, 0 )
--
-- Retourne		:	
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_PIECE' AND type = 'P' )
            DROP procedure sysadm.DW_D01_PIECE
GO

CREATE PROC sysadm.DW_D01_PIECE
@dcIdProd    decimal ( 7, 0 ),
@dcIdRev     decimal ( 7, 0 ),
@dcIdGti     decimal ( 7, 0 ),
@dcIdPce     decimal ( 7, 0 )
AS

 DELETE FROM sysadm.piece
       WHERE sysadm.piece.id_prod = @dcIdProd And
             sysadm.piece.id_rev  = @dcIdRev And
             sysadm.piece.id_gti  = @dcIdGti And
             sysadm.piece.id_pce  = @dcIdPce
GO


--------------------------------------------------------------------
--
-- Procédure            :       IM_D01_PIECE
-- Auteur               :       La Recrue
-- Date                 :       22/07/97 17:03:37
-- Libellé              :       Delete sur table PIECE.
-- Commentaires         :
-- Références           :       PS_SUPREVISION 
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 ),
--                              @dcIdRev   decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D01_PIECE' AND type = 'P' )
            DROP procedure sysadm.IM_D01_PIECE
GO

CREATE PROC sysadm.IM_D01_PIECE
            @dcIdProd  decimal ( 7, 0 ),
            @dcIdRev   decimal ( 7, 0 )
AS

 DELETE FROM sysadm.piece
       WHERE piece.id_prod = @dcIdProd AND
             piece.id_rev  = @dcIdRev


GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_D03_PIECE
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 17:29:10
-- Libellé              :       Delete sur table PIECE.
-- Commentaires         :
-- Références           :       PS_SUPPRODUIT
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D03_PIECE' AND type = 'P' )
            DROP procedure sysadm.IM_D03_PIECE
GO

CREATE PROC sysadm.IM_D03_PIECE
            @dcIdProd  decimal ( 7, 0 )
AS

 DELETE FROM sysadm.piece
       WHERE piece.id_prod = @dcIdProd

GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_D02_PIECE
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 17:07:42
-- Libellé              :       Delete sur table PIECE.
-- Commentaires         :
-- Références           :       PS_SUPCODEGARANTIE
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 ),
--                              @dcIdRev   decimal ( 7, 0 ),
--                              @dcIdGti   decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D02_PIECE' AND type = 'P' )
            DROP procedure sysadm.IM_D02_PIECE
GO

CREATE PROC sysadm.IM_D02_PIECE
            @dcIdProd  decimal ( 7, 0 ),
            @dcIdRev   decimal ( 7, 0 ),
            @dcIdGti   decimal ( 7, 0 )
AS

 DELETE FROM sysadm.piece
       WHERE piece.id_prod = @dcIdProd AND
             piece.id_rev  = @dcIdRev  AND
             piece.id_gti  = @dcIdGti

GO



--------------------------------------------------------------------
--
-- Procédure            :       IM_I01_PIECE
-- Auteur               :       La Recrue
-- Date                 :       22/07/97 16:31:45
-- Libellé              :       Utiliser pour dupliquer les PIECES de la derniere REVISION lors de
--                              la création d'une nouvelle REVISION.
-- Commentaires         :
-- Références           :       W_Tm_Sp_Produit,Wf_TerminerValider (),U_SP_GS_REV_PROD,Uf_TerminerValider () 
--
-- Arguments            :       @dcIdProd        decimal ( 7, 0 ),
--                              @dcIdRev         decimal ( 7, 0 ),
--                              @dcIdRevAnc      decimal ( 7, 0 ),
--                              @dtCreeLe        DateTime,
--                              @dtMajLe         DateTime,
--                              @sMajPar         Varchar ( 4 )
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_I01_PIECE' AND type = 'P' )
            DROP procedure sysadm.IM_I01_PIECE
GO

CREATE PROC sysadm.IM_I01_PIECE
            @dcIdProd        decimal ( 7, 0 ),
            @dcIdRev         decimal ( 7, 0 ),
            @dcIdRevAnc      decimal ( 7, 0 ),
            @dtCreeLe        DateTime,
            @dtMajLe         DateTime,
            @sMajPar         Varchar ( 4 )
AS

 INSERT INTO sysadm.piece
           ( piece.id_prod,
             piece.id_rev,
             piece.id_gti,
             piece.id_pce,
             piece.id_para,
             piece.cod_typ_pce,
             piece.cree_le,
             piece.maj_le,
             piece.maj_par,
	     piece.cpt_tri )
      SELECT piece.id_prod,
             @dcIdRev,
             piece.id_gti,
             piece.id_pce,
             piece.id_para,
             piece.cod_typ_pce,
             @dtCreeLe,
             @dtMajLe,
             @sMajPar,
	     piece.cpt_tri
        FROM sysadm.piece
       WHERE piece.id_prod = @dcIdProd   AND
             piece.id_rev  = @dcIdRevAnc

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S04_PIECE_SIN
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Sélect sur la table PIECE
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdProd       decimal ( 7, 0 )                 (Val)
--                              @dcIdRev        decimal ( 7, 0 )                 (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S04_PIECE_SIN' AND type = 'P' )
        DROP procedure sysadm.DW_S04_PIECE_SIN
GO

CREATE procedure sysadm.DW_S04_PIECE_SIN
        @dcIdProd       decimal ( 7, 0 )         ,
        @dcIdRev        decimal ( 7, 0 )       
AS
 SELECT piece.id_prod,
        piece.id_rev,
        piece.id_gti,
        piece.id_pce,
        piece.cpt_tri,
        code.lib_code,
        piece.id_para,
        piece.cod_typ_pce,
        paragraphe.cpt_ver
   FROM sysadm.piece,
        sysadm.code,
        sysadm.paragraphe
  WHERE piece.id_prod           = @dcIdProd             AND
        ( piece.id_rev          = @dcIdRev              OR
          piece.id_rev          = -1        )           AND
        piece.id_pce            = code.id_code          AND
        code.id_typ_code        = '+PC'                 AND
        piece.id_para           = paragraphe.id_para


GO
