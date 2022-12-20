-------------------------------------------------------------------
--
-- Fichier              :       Plafond.cp
-- Auteur               :       YP
-- Date                 :       03/09/97 16:03:49
--
-- Commentaires         :       Liste des procédures stockées afférent à la table plafond
--
-- Procédures           :       DW_S01_PLAFOND
--                              DW_S02_PLAFOND
--                              DW_I01_PLAFOND
--                              DW_U01_PLAFOND
--                              IM_D01_PLAFOND
--                              IM_D02_PLAFOND
--                              IM_I01_PLAFOND
--                              IM_D03_PLAFOND  
--                              DW_S03_PLAFOND_SIN
------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :   DW_S01_PLAFOND
--
-- Auteur               :   V.Capelle
--
-- Date                 :   21/11/1997 14:19:24
--                          
-- Libellé              :   Recherche des plafonds à proposer pour une garantie,
--                          ou une condition de garantie.
--
-- Commentaires         :   
-- Références           :   w_t_sp_condition_gti, uo_plafonds, dw_recherche
-- Arguments            :   
-- Retourne             :   
--                          
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_PLAFOND' AND type = 'P' )
            DROP procedure sysadm.DW_S01_PLAFOND

GO

CREATE PROC sysadm.DW_S01_PLAFOND
AS 

	SELECT CONVERT ( Decimal(7), Null ),
          CONVERT ( Decimal(7), Null ),
          CONVERT ( Decimal(7), Null ),
          ''                          ,
          CONVERT ( Decimal(7), Null ),
          sysadm.code_car.id_code     ,
          sysadm.code_car.lib_code    ,
          0                           ,
          0                           ,
          ''                          ,
          CONVERT ( Datetime  , Null ),
          CONVERT ( Datetime  , Null ),
          ''
    FROM  sysadm.code_car
   WHERE  sysadm.code_car.id_typ_code = '-PL' 

GO


--------------------------------------------------------------------
--
-- Procédure            :   DW_S02_PLAFOND
--
-- Auteur               :   V.Capelle
--
-- Date                 :   21/11/1997 16:49:24
--                          
-- Libellé              :   Recherche des plafonds associés à une garantie,
--                          ou une condition de garantie pour une révision 
--                          et un produit.
--
-- Commentaires         :   
-- Références           :   w_t_sp_condition_gti, uo_plafonds, dw_source
-- Arguments            :   @dcIdProd   decimal ( 7, 0 ),
--                          @dcIdRev    decimal ( 7, 0 ),
--                          @dcIdGti    decimal ( 7, 0 )
-- Retourne             :   
--                          
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_PLAFOND' AND type = 'P' )
            DROP procedure sysadm.DW_S02_PLAFOND

GO

CREATE PROC sysadm.DW_S02_PLAFOND
            @dcIdProd   decimal ( 7, 0 ),
            @dcIdRev    decimal ( 7, 0 ),
            @dcIdGti    decimal ( 7, 0 )

AS 

	SELECT sysadm.plafond.id_prod,
          sysadm.plafond.id_rev,
          sysadm.plafond.id_gti,
          sysadm.plafond.id_niv_plaf,
          sysadm.plafond.id_ref_plaf,
          sysadm.plafond.id_typ_plaf,
          sysadm.code_car.lib_code,
          sysadm.plafond.id_cpt_plaf,
          sysadm.plafond.mt_plaf,
          sysadm.plafond.id_para,
          sysadm.plafond.cree_le,
          sysadm.plafond.maj_le,
          sysadm.plafond.maj_par
    FROM  sysadm.code_car,
          sysadm.plafond
   WHERE  sysadm.code_car.id_typ_code = '-PL'                      AND
          sysadm.code_car.id_code     = sysadm.plafond.id_typ_plaf AND
          sysadm.plafond.id_prod      = @dcIdProd                  AND
          sysadm.plafond.id_rev       = @dcIdRev                   AND
          sysadm.plafond.id_gti       = @dcIdGti                  
GO


--------------------------------------------------------------------
--
-- Procédure            :   DW_I01_PLAFOND
--
-- Auteur               :   V.Capelle
--
-- Date                 :   24/11/1997 16:25:24
--                          
-- Libellé              :   Insertion d'un plafond pour une garantie
--
-- Commentaires         :   
-- Références           :   w_tm_sp_garantie, Dw_plafond
-- Arguments            :   @dcIdProd    decimal ( 7, 0 ),
--                          @dcIdRev     decimal ( 7, 0 ),
--                          @dcIdGti     decimal ( 7, 0 ),
--                          @sIdNivPlaf  Varchar ( 3 ),
--                          @dcIdRefPlaf decimal ( 7, 0 ),
--                          @sIdTypPlaf  Varchar ( 4 ),
--                          @dcIdCptPlaf decimal ( 4, 0 ),
--                          @dcMtPlaf    Decimal ( 11, 2 ),
--                          @IdPara      Varchar ( 4 ),
--                          @dtCreeLe    Datetime,       
--                          @dtMajLe     Datetime,      
--                          @sMajPar     VarChar ( 4 )  
--
-- Retourne             :   
--                          
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_PLAFOND' AND type = 'P' )

            DROP procedure sysadm.DW_I01_PLAFOND

GO

CREATE PROC sysadm.DW_I01_PLAFOND
            @dcIdProd    decimal ( 7, 0 ),
            @dcIdRev     decimal ( 7, 0 ),
            @dcIdGti     decimal ( 7, 0 ),
            @sIdNivPlaf  Varchar ( 3 ),
            @dcIdRefPlaf decimal ( 7, 0 ),
            @sIdTypPlaf  Varchar ( 4 ),
            @dcIdCptPlaf decimal ( 4, 0 ),
            @dcMtPlaf    Decimal ( 11, 2 ),
            @IdPara      Varchar ( 4 ),
            @dtCreeLe    Datetime,       
            @dtMajLe     Datetime,      
            @sMajPar     VarChar ( 4 )  

AS 

	INSERT INTO  sysadm.plafond

               ( id_prod,   
                 id_rev,   
                 id_gti,   
                 id_niv_plaf,
                 id_ref_plaf,
                 id_typ_plaf,
                 id_cpt_plaf,
                 mt_plaf,
                 id_para,
                 cree_le,
                 maj_le,
                 maj_par )
     VALUES (  @dcIdProd,    @dcIdRev,  @dcIdGti, @sIdNivPlaf, @dcIdRefPlaf, @sIdTypPlaf,
               @dcIdCptPlaf, @dcMtPlaf, @IdPara,  @dtCreeLe,   @dtMajLe,     @sMajPar )
GO


--------------------------------------------------------------------
--
-- Procédure            :   DW_U01_PLAFOND
--
-- Auteur               :   V.Capelle
--
-- Date                 :   24/11/1997 17:18:24
--                          
-- Libellé              :   Modification d'un plafond pour une garantie
--
-- Commentaires         :   
-- Références           :   w_tm_sp_garantie, Dw_plafond
-- Arguments            :   @dcIdProd    decimal ( 7, 0 ),
--                          @dcIdRev     decimal ( 7, 0 ),
--                          @dcIdGti     decimal ( 7, 0 ),
--                          @sIdNivPlaf  Varchar ( 3 ),
--                          @dcIdRefPlaf decimal ( 7, 0 ),
--                          @sIdTypPlaf  Varchar ( 4 ),
--                          @dcIdCptPlaf decimal ( 4, 0 ),
--                          @dcMtPlaf    Decimal ( 11, 2 ),
--                          @IdPara      Varchar ( 4 ),
--                          @dtMajLe     Datetime,      
--                          @sMajPar     VarChar ( 4 )  
--
-- Retourne             :   
--                          
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_U01_PLAFOND' AND type = 'P' )
            DROP procedure sysadm.DW_U01_PLAFOND

GO

CREATE PROC sysadm.DW_U01_PLAFOND
            @dcIdProd    decimal ( 7, 0 ),
            @dcIdRev     decimal ( 7, 0 ),
            @dcIdGti     decimal ( 7, 0 ),
            @sIdNivPlaf  Varchar ( 3 ),
            @dcIdRefPlaf decimal ( 7, 0 ),
            @sIdTypPlaf  Varchar ( 4 ),
            @dcIdCptPlaf decimal ( 4, 0 ),
            @dcMtPlaf    Decimal ( 11, 2 ),
            @IdPara      Varchar ( 4 ),
            @dtMajLe     Datetime,      
            @sMajPar     VarChar ( 4 )  
AS 
   UPDATE  sysadm.plafond
      SET  sysadm.plafond.mt_plaf = @dcMtPlaf,
           sysadm.plafond.id_para = @IdPara,
           sysadm.plafond.maj_le  = @dtMajLe,
           sysadm.plafond.maj_par = @sMajPar
    WHERE  sysadm.plafond.id_prod     = @dcIdProd    AND
           sysadm.plafond.id_rev      = @dcIdRev     AND   
           sysadm.plafond.id_gti      = @dcIdGti     AND
           sysadm.plafond.id_niv_plaf = @sIdNivPlaf  AND 
           sysadm.plafond.id_ref_plaf = @dcIdRefPlaf AND
           sysadm.plafond.id_typ_plaf = @sIdTypPlaf  AND
           sysadm.plafond.id_cpt_plaf = @dcIdCptPlaf
                            
     
GO


--------------------------------------------------------------------
--
-- Procédure            :       IM_D01_PLAFOND
-- Auteur               :       YP
-- Date                 :       03/09/97 16:03:37
-- Libellé              :       Delete sur table PLAFOND.
-- Commentaires         :
-- Références           :       PS_SUPREVISION 
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 ),
--                              @dcIdRev   decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D01_PLAFOND' AND type = 'P' )
            DROP procedure sysadm.IM_D01_PLAFOND
GO

CREATE PROC sysadm.IM_D01_PLAFOND
            @dcIdProd  decimal ( 7, 0 ),
            @dcIdRev   decimal ( 7, 0 )
AS

 DELETE FROM sysadm.plafond
       WHERE plafond.id_prod = @dcIdProd AND
             plafond.id_rev  = @dcIdRev


GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_D02_PLAFOND
-- Auteur               :       YP
-- Date                 :       03/09/97 16:03:37
-- Libellé              :       Delete sur table PLAFOND.
-- Commentaires         :
-- Références           :       PS_SUPPRODUIT
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 ),
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D02_PLAFOND' AND type = 'P' )
            DROP procedure sysadm.IM_D02_PLAFOND
GO

CREATE PROC sysadm.IM_D02_PLAFOND
            @dcIdProd  decimal ( 7, 0 )
AS

 DELETE FROM sysadm.plafond
       WHERE plafond.id_prod = @dcIdProd

GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_I01_PLAFOND
-- Auteur               :       YP
-- Date                 :       03/09/97 16:23:45
-- Libellé              :       Utiliser pour dupliquer les PLAFONDS de la derniere REVISION lors de
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

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_I01_PLAFOND' AND type = 'P' )
            DROP procedure sysadm.IM_I01_PLAFOND
GO

CREATE PROC sysadm.IM_I01_PLAFOND
            @dcIdProd        decimal ( 7, 0 ),
            @dcIdRev         decimal ( 7, 0 ),
            @dcIdRevAnc      decimal ( 7, 0 ),
            @dtCreeLe        DateTime,
            @dtMajLe         DateTime,
            @sMajPar         Varchar ( 4 )
AS

 INSERT INTO sysadm.plafond
           ( plafond.id_prod,
             plafond.id_rev,
             plafond.id_gti,
             plafond.id_niv_plaf,
             plafond.id_ref_plaf,
             plafond.id_typ_plaf,
             plafond.id_cpt_plaf,
             plafond.mt_plaf,
             plafond.id_para,
             plafond.cree_le,
             plafond.maj_le,
             plafond.maj_par )
      SELECT plafond.id_prod,
             @dcIdRev,
             plafond.id_gti,
             plafond.id_niv_plaf,
             plafond.id_ref_plaf,
             plafond.id_typ_plaf,
             plafond.id_cpt_plaf,
             plafond.mt_plaf,
             plafond.id_para,
             @dtCreeLe,
             @dtMajLe,
             @sMajPar
        FROM sysadm.plafond
       WHERE plafond.id_prod = @dcIdProd   AND
             plafond.id_rev  = @dcIdRevAnc

GO



--------------------------------------------------------------------
--
-- Procédure    : IM_D03_PLAFOND
-- Auteur       : V.CAPELLE
-- Date         : 07/11/97 15:27:55
-- Libellé      : Delete sur table PLAFOND.
-- Commentaires : 
-- Références   : 
--
-- Arguments    : @dcIdProd  decimal ( 7, 0 ),
--                @dcIdRev   decimal ( 7, 0 ),
--                @dcIdGti   decimal ( 7, 0 )
--
-- Retourne  : 
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D03_PLAFOND' AND type = 'P' )
 DROP procedure sysadm.IM_D03_PLAFOND
GO

CREATE PROC sysadm.IM_D03_PLAFOND
 @dcIdProd  decimal ( 7, 0 ),
 @dcIdRev   decimal ( 7, 0 ),
 @dcIdGti   decimal ( 7, 0 )
AS

 DELETE FROM sysadm.plafond
       WHERE sysadm.plafond.id_prod = @dcIdProd AND
             sysadm.plafond.id_rev  = @dcIdRev  AND
             sysadm.plafond.id_gti  = @dcIdGti

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S03_PLAFOND_SIN
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Sélect sur la table PLAFOND
-- Références           :       Utilisé dans W_TM_SP_SINISTRE (Liste détail)
--
-- Arguments            :       @dcIdProd       decimal ( 7, 0 )                 (Val)
--                              @dcIdRev        decimal ( 7, 0 )                 (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_PLAFOND_SIN' AND type = 'P' )
        DROP procedure sysadm.DW_S03_PLAFOND_SIN
GO

CREATE procedure sysadm.DW_S03_PLAFOND_SIN
        @dcIdProd       decimal ( 7, 0 )         ,
        @dcIdRev        decimal ( 7, 0 )       
AS
 SELECT plafond.id_prod,
        plafond.id_rev,
        plafond.id_gti,
        plafond.id_niv_plaf,
        plafond.id_ref_plaf,
        plafond.id_typ_plaf,
        plafond.id_cpt_plaf,
        plafond.mt_plaf,
        plafond.id_para,
        code_car.lib_code,
        paragraphe.cpt_ver
 FROM   sysadm.plafond
 JOIN   sysadm.code_car
 ON     plafond.id_typ_plaf     = code_car.id_code
 LEFT OUTER JOIN sysadm.paragraphe
 ON     plafond.id_para         = paragraphe.id_para
 WHERE  plafond.id_prod         = @dcIdProd                     AND
        plafond.id_rev          = @dcIdRev                      AND
        code_car.id_typ_code    = '-PL'


GO
