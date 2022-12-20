-------------------------------------------------------------------
--
-- Fichier              :       Motif.cp
-- Auteur               :       La Recrue
-- Date                 :       22/07/97 13:17:39
--
-- Commentaires         :       Liste des procédures stockées afférant à la table MOTIF
--
-- Procédures           :	
--                              DW_S01_MOTIF
--                              DW_S02_MOTIF
--                              DW_S03_MOTIF
--                              DW_S04_MOTIF
--                              DW_I01_MOTIF
--                              DW_U01_MOTIF
--                              DW_D01_MOTIF
--                              IM_S03_MOTIF
--                              IM_D01_MOTIF
--                              IM_D03_MOTIF
--                              IM_D02_MOTIF
--                              IM_S01_MOTIF
--                              IM_I01_MOTIF
--                              DW_S04_MOTIF_SIN
-------------------------------------------------------------------



--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_MOTIF
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 13:49:38
-- Libellé              :       Sélection de touts les motifs de refus pour un produit
-- Commentaires         :       d'une révision donnée.
-- Références           :       w_td_sp_code_condition, uo_refus, dw_source, D_SP_PROD_REF
--
-- Arguments            :       @dcIdProduit      decimal ( 7,0 ) ( Val )
--                              @dcIdRev          decimal ( 7,0 ) ( Val )
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_MOTIF' AND type = 'P' )
            DROP procedure sysadm.DW_S01_MOTIF
GO

CREATE PROC sysadm.DW_S01_MOTIF
       @dcIdProduit      decimal ( 7,0 ),
       @dcIdRev          decimal ( 7,0 )
AS
 SELECT sysadm.motif.id_prod,
        sysadm.motif.id_rev,
        sysadm.motif.id_gti,
        sysadm.motif.id_motif,
        sysadm.code.lib_code,
        sysadm.motif.id_para,
        sysadm.motif.cod_typ_motif,
        sysadm.motif.cod_nat_motif,
        sysadm.motif.cree_le,
        sysadm.motif.maj_le,
        sysadm.motif.maj_par,
	sysadm.motif.cpt_tri
   FROM sysadm.motif,
        sysadm.code
  WHERE sysadm.motif.id_prod    = @dcIdProduit		AND
        sysadm.motif.id_motif   = sysadm.code.id_code	AND
        sysadm.motif.id_rev     = @dcIdRev		AND
        sysadm.code.id_typ_code = '+RE' 

GO


--------------------------------------------------------------------
--
-- Procédure            :   DW_S02_MOTIF
-- Auteur               :   V.Capelle
-- Date                 :   20/11/1997 09:51:05
-- Libellé              :   Sélection des motifs de refus n'étant pas 
--                          déjà paramétrés au niveau des conditions 
--                          générales d'un produit.
-- Commentaires         :   
-- Références           :   w_t_condition_gti, uo_refus, dw_recherche 
--
-- Arguments            :   @dcIdProduit      decimal ( 7,0 ) ( Val )
--                          @dcIdGti          decimal ( 7,0 ) ( Val )
--
-- Retourne             :   
--                          
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_MOTIF' AND type = 'P' )
            DROP procedure sysadm.DW_S02_MOTIF
GO

CREATE PROC sysadm.DW_S02_MOTIF
       @dcIdProduit      decimal ( 7,0 ),
       @dcIdGti          decimal ( 7,0 )
AS
 SELECT CONVERT ( Decimal ( 7 ), Null ),
        CONVERT ( Decimal ( 7 ), Null ),
        CONVERT ( Decimal ( 7 ), Null ),
        sysadm.code.id_code,
        sysadm.code.lib_code,
        '',
        'G',
        'R',
        CONVERT ( DateTime, Null ),
        CONVERT ( DateTime, Null ),
        '',
	0
   FROM sysadm.code
  WHERE sysadm.code.id_typ_code = '+RE' AND
        sysadm.code.id_code NOT IN ( SELECT sysadm.motif.id_motif 
                                       FROM sysadm.motif   
                                      WHERE sysadm.motif.id_prod = @dcIdProduit  AND
                                            sysadm.motif.id_rev  = -1            AND
                                            sysadm.motif.id_gti  = @dcIdGti )

GO


--------------------------------------------------------------------
--
-- Procédure            :   DW_S03_MOTIF
-- Auteur               :   V.Capelle
-- Date                 :   20/11/1997 09:51:05
-- Libellé              :   Sélection des motifs de refus affectées à 
--                          une garantie pour une révision sur un produit.
-- Commentaires         :   
-- Références           :   w_t_condition_gti, uo_refus, dw_source 
--
-- Arguments            :   @dcIdProduit      decimal ( 7,0 ) 
--                          @dcIdRev          decimal ( 7,0 ) 
--                          @dcIdGti          decimal ( 7,0 ) 
--
-- Retourne             :   
--                          
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_MOTIF' AND type = 'P' )
            DROP procedure sysadm.DW_S03_MOTIF
GO

CREATE PROC sysadm.DW_S03_MOTIF
       @dcIdProduit      decimal ( 7,0 ),
       @dcIdRev          decimal ( 7,0 ),
       @dcIdGti          decimal ( 7,0 )
AS
 SELECT sysadm.motif.id_prod,
        sysadm.motif.id_rev,
        sysadm.motif.id_gti,
        sysadm.motif.id_motif,
        sysadm.code.lib_code,
        sysadm.motif.id_para,
        sysadm.motif.cod_typ_motif,
        sysadm.motif.cod_nat_motif,
        sysadm.motif.cree_le,
        sysadm.motif.maj_le,
        sysadm.motif.maj_par,
	sysadm.motif.cpt_tri
   FROM sysadm.motif,
        sysadm.code
  WHERE sysadm.motif.id_prod    = @dcIdProduit  AND
        sysadm.motif.id_rev     = @dcIdRev      AND
        sysadm.motif.id_gti     = @dcIdGti      AND 
        sysadm.code.id_typ_code = '+RE'         AND
        sysadm.code.id_code     = sysadm.motif.id_motif 

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_MOTIF
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 18:36:13
-- Libellé              :       Insertion d'un motif de refus affecté à une garantie
-- Commentaires         :
-- Références           :       W_TM_SP_PRODUIT , dw_refus, SqlPreview
--			
--
-- Arguments            :       @dcIdProd       decimal ( 7,0 ),
--                              @dcIdrev        decimal ( 7,0 ),
--                              @dcIdGti        decimal ( 7,0 ),
--                              @dcIdMotif      decimal ( 7,0 ),
--                              @sIdPara        Varchar(4),
--                              @sCodTypMotif   Varchar(1),
--                              @sCodNatMotif   Varchar(1),
--                              @dtCreeLe       DateTime,
--                              @dtMajLe        DateTime,
--                              @sMajPar        Varchar(4)
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_MOTIF' AND type = 'P' )
            DROP procedure sysadm.DW_I01_MOTIF
GO

CREATE PROC sysadm.DW_I01_MOTIF
@dcIdProd       decimal ( 7,0 ),
@dcIdRev        decimal ( 7,0 ),
@dcIdGti        decimal ( 7,0 ),
@dcIdMotif      decimal ( 7,0 ),
@sIdPara        Varchar(4),
@sCodTypMotif   Varchar(1),
@sCodNatMotif   Varchar(1),
@dtCreeLe       DateTime,
@dtMajLe        DateTime,
@sMajPar        Varchar(4),
@dcCptTri	    decimal ( 2,0 )
AS
 INSERT INTO sysadm.motif
             ( sysadm.motif.id_prod,
               sysadm.motif.id_rev,
               sysadm.motif.id_gti,
               sysadm.motif.id_motif,
               sysadm.motif.id_para,
               sysadm.motif.cod_typ_motif,
               sysadm.motif.cod_nat_motif,
               sysadm.motif.cree_le,
               sysadm.motif.maj_le,
               sysadm.motif.maj_par,
	       sysadm.motif.cpt_tri )
      VALUES ( @dcIdProd,
               @dcIdRev,
               @dcIdGti,
               @dcIdMotif,
               @sIdPara,
               @sCodTypMotif,
               @sCodNatMotif,
               @dtCreeLe,
               @dtMajLe,
               @sMajPar,
	       @dcCptTri )
GO


--------------------------------------------------------------------
--
-- Procédure            :   DW_U01_MOTIF
-- Auteur               :   V.Capelle
-- Date                 :   20/11/1997 10:48:07
-- Libellé              :   Mise à jour de la table motif
-- Commentaires         :   
-- Références           :   
-- Arguments            :   @dcIdProd       decimal ( 7,0 ),
--                          @dcIdrev        decimal ( 7,0 ),
--                          @dcIdGti        decimal ( 7,0 ),
--                          @dcIdMotif      decimal ( 7,0 ),
--                          @sIdPara        Varchar(4),
--                          @sCodTypMotif   Varchar(1),
--                          @sCodNatMotif   Varchar(1),
--                          @dtMajLe        DateTime,
--                          @sMajPar        Varchar(4)
-- Retourne             :   
--                          
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_U01_MOTIF' AND type = 'P' )
            DROP procedure sysadm.DW_U01_MOTIF
GO

CREATE PROC sysadm.DW_U01_MOTIF
            @dcIdProd       decimal ( 7,0 ),
            @dcIdRev        decimal ( 7,0 ),
            @dcIdGti        decimal ( 7,0 ),
            @dcIdMotif      decimal ( 7,0 ),
            @sIdPara        Varchar(4),
            @sCodTypMotif   Varchar(1),
            @sCodNatMotif   Varchar(1),
            @dtMajLe        DateTime,
            @sMajPar        Varchar(4),
            @dcCptTri       decimal ( 2,0 )
AS

UPDATE     sysadm.motif
   SET     sysadm.motif.id_para       = @sIdPara,
           sysadm.motif.cod_typ_motif = @sCodTypMotif,
           sysadm.motif.cod_nat_motif = @sCodNatMotif,
           sysadm.motif.maj_le        = @dtMajLe,
           sysadm.motif.maj_par       = @sMajPar,
	   sysadm.motif.cpt_tri	      = @dcCptTri
 WHERE     sysadm.motif.id_prod       = @dcIdProd   AND
           sysadm.motif.id_rev        = @dcIdRev    AND
           sysadm.motif.id_gti        = @dcIdGti    AND
           sysadm.motif.id_motif      = @dcIdMotif

GO
--------------------------------------------------------------------
--
-- Procédure            :       DW_D01_MOTIF
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 18:44:53
-- Libellé              :       Destruction d'un motif
-- Commentaires         :
-- Références           :       W_TM_SP_PRODUIT , Dw_Refus, SqlPreview
--
-- Arguments            :       @dcIdProd     decimal ( 7,0 ),
--                              @dcIdRev      decimal ( 7,0 ),
--                              @dcIdGti      decimal ( 7,0 ),
--                              @dcIdMotif    decimal ( 7,0 )
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_MOTIF' AND type = 'P' )
            DROP procedure sysadm.DW_D01_MOTIF
GO

CREATE PROC sysadm.DW_D01_MOTIF
            @dcIdProd      decimal ( 7,0 ),
            @dcIdRev       decimal ( 7,0 ),
            @dcIdGti       decimal ( 7,0 ),
            @dcIdMotif     decimal ( 7,0 )
AS

DELETE FROM sysadm.motif
       WHERE sysadm.motif.id_prod = @dcIdProd And
             sysadm.motif.id_rev = @dcIdRev And
             sysadm.motif.id_gti = @dcIdGti And
             sysadm.motif.id_motif = @dcIdMotif
GO


--------------------------------------------------------------------
--
-- Procédure            :       IM_S03_MOTIF
-- Auteur               :       La Recrue
-- Date                 :       22/07/97 14:47:51
-- Libellé              :       permet de savoir le paragraphe que l'on désire supprimer n'est 
--                              pas lié à une nature d'exclusion.
-- Commentaires         :
-- Références           :       U_SP_GS_PARAGRAPHE, Uf_Gs_Sup_Para ()
--
-- Arguments            :
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_S03_MOTIF' AND type = 'P' )
            DROP procedure sysadm.IM_S03_MOTIF
GO

CREATE PROC sysadm.IM_S03_MOTIF
            @sIdPara    Varchar ( 4 ),
            @iNbRefus   Integer OUTPUT
AS

  SELECT motif.id_para
    FROM sysadm.motif
   WHERE motif.id_para = @sIdPara

  SELECT @iNbRefus = @@ROWCOUNT

GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_D01_MOTIF
-- Auteur               :       La Recrue
-- Date                 :       22/07/97 16:57:53
-- Libellé              :       Delete sur table MOTIF.
-- Commentaires         :
-- Références           :       PS_SUPREVISION 
--
-- Arguments            :       @dcIdProd  decimal ( 7,0 ),
--                              @dcIdRev   decimal ( 7,0 )
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D01_MOTIF' AND type = 'P' )
            DROP procedure sysadm.IM_D01_MOTIF
GO

CREATE PROC sysadm.IM_D01_MOTIF
            @dcIdProd  decimal ( 7,0 ),
            @dcIdRev   decimal ( 7,0 )
AS

 DELETE FROM sysadm.motif
       WHERE motif.id_prod = @dcIdProd AND
             motif.id_rev  = @dcIdRev

GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_D03_MOTIF
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 17:24:49
-- Libellé              :       Delete sur table MOTIF.
-- Commentaires         :
-- Références           :       PS_SUPPRODUIT
--
-- Arguments            :       @dcIdProd  decimal ( 7,0 )
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D03_MOTIF' AND type = 'P' )
            DROP procedure sysadm.IM_D03_MOTIF
GO

CREATE PROC sysadm.IM_D03_MOTIF
            @dcIdProd  decimal ( 7,0 )
AS

 DELETE FROM sysadm.motif
       WHERE motif.id_prod = @dcIdProd

GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_D02_MOTIF
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 17:04:55
-- Libellé              :       Delete sur table MOTIF.
-- Commentaires         :
-- Références           :       PS_SUPCODEGARANTIE
--
-- Arguments            :       @dcIdProd  decimal ( 7,0 ),
--                              @dcIdRev   decimal ( 7,0 ),
--                              @dcIdGti   decimal ( 7,0 )
--
-- Retourne             :
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D02_MOTIF' AND type = 'P' )
            DROP procedure sysadm.IM_D02_MOTIF
GO

CREATE PROC sysadm.IM_D02_MOTIF
            @dcIdProd  decimal ( 7,0 ),
            @dcIdRev   decimal ( 7,0 ),
            @dcIdGti   decimal ( 7,0 )
AS

 DELETE FROM sysadm.motif
       WHERE motif.id_prod = @dcIdProd AND
             motif.id_rev  = @dcIdRev  AND
             motif.id_gti  = @dcIdGti

GO

--------------------------------------------------------------------
--
-- Procédure            :     IM_S01_MOTIF
-- Auteur               :     YP
-- Date                 :     14/08/97 15:28:42
-- Libellé              :     permet de savoir si le code que l'on désire supprimer n'est 
--                            pas lié a un motif de refus.
-- Commentaires         :
-- Références           :     U_SPB_GS_CODES_NUM, Uf_Gs_Sup_Code
--
-- Arguments            :     @dcIdCode  decimal ( 7,0 )         Id_Code
--                            @iNbCode   Integer OUTPUT  Nombre trouvé
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_S01_MOTIF' AND type = 'P' )
            DROP procedure sysadm.IM_S01_MOTIF
GO

CREATE PROC sysadm.IM_S01_MOTIF
       @dcIdCode    decimal ( 7,0 ),
       @iNbCode     Integer OUTPUT
AS

SELECT  motif.id_motif
FROM    sysadm.motif
WHERE   motif.id_motif = @dcIdCode

SELECT  @iNbCode = @@ROWCOUNT

GO


--------------------------------------------------------------------
--
-- Procédure            :       IM_I01_MOTIF
-- Auteur               :       La Recrue
-- Date                 :       22/07/97 15:44:28
-- Libellé              :       Utilise dupliquer les MOTIFS de la derniere REVISION lors de
--                              la creation d'une nouvelle REVISION.
-- Commentaires         :
-- Références           :       W_Tm_Sp_Produit, Wf_TerminerValider (), U_SP_GS_REV_PROD, uf_terminer_valider ()
--
-- Arguments            :       @dcIdProd        decimal ( 7,0 ),
--                              @dcIdRev         decimal ( 7,0 ),
--                              @dcIdRevAnc      decimal ( 7,0 ),
--                              @dtCreeLe        DateTime,
--                              @dtMajLe         DateTime,
--                              @sMajPar         Varchar ( 4 )
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_I01_MOTIF' AND type = 'P' )
            DROP procedure sysadm.IM_I01_MOTIF
GO

CREATE PROC sysadm.IM_I01_MOTIF
@dcIdProd       decimal ( 7,0 ),
@dcIdRev        decimal ( 7,0 ),
@dcIdRevAnc     decimal ( 7,0 ),
@dtCreeLe       DateTime,
@dtMajLe        DateTime,
@sMajPar        Varchar ( 4 )
AS

 INSERT INTO sysadm.motif
           ( motif.id_prod,
             motif.id_rev,
             motif.id_gti,
             motif.id_motif,
             motif.id_para,
             motif.cod_typ_motif,
             motif.cod_nat_motif,
             motif.cree_le,
             motif.maj_le,
             motif.maj_par,
	     motif.cpt_tri )
      SELECT motif.id_prod,
             @dcIdRev,
             motif.id_gti,
             motif.id_motif,
             motif.id_para,
             motif.cod_typ_motif,
             motif.cod_nat_motif,
             @dtCreeLe,
             @dtMajLe,
             @sMajPar,
	     motif.cpt_tri
        FROM sysadm.motif
       WHERE motif.id_prod = @dcIdProd   AND
             motif.id_rev  = @dcIdRevAnc

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S04_MOTIF_SIN
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Sélect sur la table MOTIF
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdProd       decimal ( 7,0 )                 (Val)
--                              @dcIdRev        decimal ( 7,0 )                 (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S04_MOTIF_SIN' AND type = 'P' )
        DROP procedure sysadm.DW_S04_MOTIF_SIN
GO

CREATE procedure sysadm.DW_S04_MOTIF_SIN
        @dcIdProd       decimal ( 7,0 )         ,
        @dcIdRev        decimal ( 7,0 )       
AS
 SELECT motif.id_prod,
        motif.id_rev,
        motif.id_gti,
        motif.id_motif,
        motif.cpt_tri,
        code.lib_code,
        motif.id_para,
        motif.cod_typ_motif,
        motif.cod_nat_motif,
        paragraphe.cpt_ver
   FROM sysadm.motif,
        sysadm.code,
        sysadm.paragraphe
  WHERE motif.id_prod           = @dcIdProd             AND
        ( motif.id_rev          = @dcIdRev              OR
          motif.id_rev          = -1        )           AND
        motif.id_motif          = code.id_code          AND
        code.id_typ_code        = '+RE'                 AND
        motif.id_para           = paragraphe.id_para
        
                
GO

