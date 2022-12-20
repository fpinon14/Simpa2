-------------------------------------------------------------------
--
-- Fichier              :       Delai.cp
-- Auteur               :       YP
-- Date                 :       03/09/97 16:03:49
--
-- Commentaires         :       Liste des procédures stockées afférent à la table delai
--
-- Procédures           :       DW_S01_DELAI
--                              DW_S02_DELAI
--                              DW_I01_DELAI
--                              DW_U01_DELAI
--                              IM_D01_DELAI
--                              IM_D02_DELAI
--                              IM_I01_DELAI
--                              IM_D03_DELAI
--                              DW_S03_DELAI_SIN
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :   DW_S01_DELAI
--
-- Auteur               :   V.Capelle
--
-- Date                 :   27/11/1997 17:50:24
--                          
-- Libellé              :   Recherche des delais à proposer pour une garantie,
--                          ou une condition de garantie.
--
-- Commentaires         :   
-- Références           :   w_t_sp_condition_gti, uo_delais, dw_recherche
-- Arguments            :   
-- Retourne             :   
--                          
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_DELAI' AND type = 'P' )
            DROP procedure sysadm.DW_S01_DELAI

GO

CREATE PROC sysadm.DW_S01_DELAI

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
          0                           ,
          'J'                         ,
          CONVERT ( Datetime  , Null ),
          CONVERT ( Datetime  , Null ),
          ''
    FROM  sysadm.code_car
   WHERE  sysadm.code_car.id_typ_code = '-DL' 

GO


--------------------------------------------------------------------
--
-- Procédure            :   DW_S02_DELAI
--
-- Auteur               :   V.Capelle
--
-- Date                 :   27/11/1997 17:49:24
--                          
-- Libellé              :   Recherche des delais associés à une garantie,
--                          ou une condition de garantie pour une révision 
--                          et un produit.
--
-- Commentaires         :   
-- Références           :   w_t_sp_condition_gti, uo_delais, dw_source
-- Arguments            :   @dcIdProd   decimal ( 7, 0 ),
--                          @dcIdRev    decimal ( 7, 0 ),
--                          @dcIdGti    decimal ( 7, 0 )
-- Retourne             :   
--                          
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_DELAI' AND type = 'P' )
            DROP procedure sysadm.DW_S02_DELAI

GO

CREATE PROC sysadm.DW_S02_DELAI
            @dcIdProd   decimal ( 7, 0 ),
            @dcIdRev    decimal ( 7, 0 ),
            @dcIdGti    decimal ( 7, 0 )

AS 

	SELECT sysadm.delai.id_prod,
          sysadm.delai.id_rev,
          sysadm.delai.id_gti,
          sysadm.delai.id_niv_del,
          sysadm.delai.id_ref_del,
          sysadm.delai.id_typ_del,
          sysadm.code_car.lib_code,
          sysadm.delai.id_cpt_del,
          sysadm.delai.dur_min,
          sysadm.delai.dur_max,
          sysadm.delai.unt_del,
          sysadm.delai.cree_le,
          sysadm.delai.maj_le,
          sysadm.delai.maj_par
    FROM  sysadm.code_car,
          sysadm.delai
   WHERE  sysadm.code_car.id_typ_code = '-DL'                    AND
          sysadm.code_car.id_code     = sysadm.delai.id_typ_del  AND
          sysadm.delai.id_prod        = @dcIdProd                AND
          sysadm.delai.id_rev         = @dcIdRev                 AND
          sysadm.delai.id_gti         = @dcIdGti                  
GO


--------------------------------------------------------------------
--
-- Procédure            :   DW_I01_DELAI
--
-- Auteur               :   V.Capelle
--
-- Date                 :   27/11/1997 17:58:24
--                          
-- Libellé              :   Insertion d'un delai pour une garantie
--
-- Commentaires         :   
-- Références           :   w_tm_sp_garantie, Dw_Delai
-- Arguments            :   @dcIdProd    decimal ( 7, 0 ),
--                          @dcIdRev     decimal ( 7, 0 ),
--                          @dcIdGti     decimal ( 7, 0 ),
--                          @sIdNivDel   Varchar ( 3 ),
--                          @dcIdRefDel  decimal ( 7, 0 ),
--                          @sIdTypDel   Varchar ( 4 ),
--                          @dcIdCptDel  decimal ( 4, 0 ),
--                          @dcDurMin    decimal ( 5, 0 ),
--                          @dcDurMax    decimal ( 5, 0 ),
--                          @sUntDel     VarChar ( 1 )
--                          @dtCreeLe    Datetime,       
--                          @dtMajLe     Datetime,      
--                          @sMajPar     VarChar ( 4 )  
--
-- Retourne             :   
--                          
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_DELAI' AND type = 'P' )
            DROP procedure sysadm.DW_I01_DELAI

GO

CREATE PROC sysadm.DW_I01_DELAI
            @dcIdProd    decimal ( 7, 0 ),
            @dcIdRev     decimal ( 7, 0 ),
            @dcIdGti     decimal ( 7, 0 ),
            @sIdNivDel   Varchar ( 3 ),
            @dcIdRefDel  decimal ( 7, 0 ),
            @sIdTypDel   VarChar ( 4 ),
            @dcIdCptDel  decimal ( 4, 0 ),
            @dcDurMin    decimal ( 5, 0 ),
            @dcDurMax    decimal ( 5, 0 ),
            @sUntDel     VarChar ( 1 ),
            @dtCreeLe    Datetime,       
            @dtMajLe     Datetime,      
            @sMajPar     VarChar ( 4 )  

AS 

	INSERT INTO  sysadm.delai

               ( id_prod,   
                 id_rev,   
                 id_gti,   
                 id_niv_del,
                 id_ref_del,
                 id_typ_del,
                 id_cpt_del,
                 dur_min,
                 dur_max,
                 unt_del,
                 cree_le,
                 maj_le,
                 maj_par )
     VALUES (  @dcIdProd,    @dcIdRev,  @dcIdGti,    @sIdNivDel,   @dcIdRefDel,  @sIdTypDel,
               @dcIdCptDel,  @dcDurMin, @dcDurMax ,  @sUntDel,     @dtCreeLe,    @dtMajLe,  
               @sMajPar )
GO


--------------------------------------------------------------------
--
-- Procédure            :   DW_U01_DELAI
--
-- Auteur               :   V.Capelle
--
-- Date                 :   27/11/1997 18:03:24
--                          
-- Libellé              :   Modification d'un delai pour une garantie
--
-- Commentaires         :   
-- Références           :   w_tm_sp_garantie, Dw_delai
--
-- Arguments            :   @dcIdProd    decimal ( 7, 0 ),
--                          @dcIdRev     decimal ( 7, 0 ),
--                          @dcIdGti     decimal ( 7, 0 ),
--                          @sIdNivDel   Varchar ( 3 ),
--                          @dcIdRefDel  decimal ( 7, 0 ),
--                          @sIdTypDel   VarChar ( 4 ),
--                          @dcIdCptDel  decimal ( 4, 0 ),
--                          @dcDurMin    decimal ( 5, 0 ),
--                          @dcDurMax    decimal ( 5, 0 ),
--                          @sUntDel     VarChar ( 1 )
--                          @dtMajLe     Datetime,      
--                          @sMajPar     VarChar ( 4 )  
--
-- Retourne             :   
--                          
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_U01_DELAI' AND type = 'P' )
            DROP procedure sysadm.DW_U01_DELAI

GO

CREATE PROC sysadm.DW_U01_DELAI
            @dcIdProd    decimal ( 7, 0 ),
            @dcIdRev     decimal ( 7, 0 ),
            @dcIdGti     decimal ( 7, 0 ),
            @sIdNivDel   Varchar ( 3 ),
            @dcIdRefDel  decimal ( 7, 0 ),
            @sIdTypDel   VarChar ( 4 ),
            @dcIdCptDel  decimal ( 4, 0 ),
            @dcDurMin    decimal ( 5, 0 ),
            @dcDurMax    decimal ( 5, 0 ),
            @sUntDel     VarChar ( 1 ),
            @dtMajLe     Datetime,      
            @sMajPar     VarChar ( 4 )
AS 
   UPDATE  sysadm.delai
      SET  sysadm.delai.dur_min = @dcDurMin,
           sysadm.delai.dur_max = @dcDurMax,
           sysadm.delai.unt_del = @sUntDel,
           sysadm.delai.maj_le  = @dtMajLe,
           sysadm.delai.maj_par = @sMajPar
    WHERE  sysadm.delai.id_prod    = @dcIdProd    AND
           sysadm.delai.id_rev     = @dcIdRev     AND   
           sysadm.delai.id_gti     = @dcIdGti     AND
           sysadm.delai.id_niv_del = @sIdNivDel   AND 
           sysadm.delai.id_ref_del = @dcIdRefDel  AND
           sysadm.delai.id_typ_del = @sIdTypDel   AND
           sysadm.delai.id_cpt_del = @dcIdCptDel
     
GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_D01_DELAI
-- Auteur               :       YP
-- Date                 :       03/09/97 16:03:37
-- Libellé              :       Delete sur table DELAI.
-- Commentaires         :
-- Références           :       PS_SUPREVISION 
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 ),
--                              @dcIdRev   decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D01_DELAI' AND type = 'P' )
            DROP procedure sysadm.IM_D01_DELAI
GO

CREATE PROC sysadm.IM_D01_DELAI
            @dcIdProd  decimal ( 7, 0 ),
            @dcIdRev   decimal ( 7, 0 )
AS

 DELETE FROM sysadm.delai
       WHERE delai.id_prod = @dcIdProd AND
             delai.id_rev  = @dcIdRev


GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_D02_DELAI
-- Auteur               :       YP
-- Date                 :       03/09/97 16:03:37
-- Libellé              :       Delete sur table DELAI.
-- Commentaires         :
-- Références           :       PS_SUPPRODUIT
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 ),
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D02_DELAI' AND type = 'P' )
            DROP procedure sysadm.IM_D02_DELAI
GO

CREATE PROC sysadm.IM_D02_DELAI
            @dcIdProd  decimal ( 7, 0 )
AS

 DELETE FROM sysadm.delai
       WHERE delai.id_prod = @dcIdProd


GO


--------------------------------------------------------------------
--
-- Procédure            :       IM_I01_DELAI
-- Auteur               :       YP
-- Date                 :       03/09/97 16:23:45
-- Libellé              :       Utiliser pour dupliquer les DELAIS de la derniere REVISION lors de
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

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_I01_DELAI' AND type = 'P' )
            DROP procedure sysadm.IM_I01_DELAI
GO

CREATE PROC sysadm.IM_I01_DELAI
            @dcIdProd        decimal ( 7, 0 ),
            @dcIdRev         decimal ( 7, 0 ),
            @dcIdRevAnc      decimal ( 7, 0 ),
            @dtCreeLe        DateTime,
            @dtMajLe         DateTime,
            @sMajPar         Varchar ( 4 )
AS

 INSERT INTO sysadm.delai
           ( delai.id_prod,
             delai.id_rev,
             delai.id_gti,
             delai.id_niv_del,
             delai.id_ref_del,
             delai.id_typ_del,
             delai.id_cpt_del,
             delai.dur_min,
             delai.dur_max,
             delai.unt_del,
             delai.cree_le,
             delai.maj_le,
             delai.maj_par )
      SELECT delai.id_prod,
             @dcIdRev,
             delai.id_gti,
             delai.id_niv_del,
             delai.id_ref_del,
             delai.id_typ_del,
             delai.id_cpt_del,
             delai.dur_min,
             delai.dur_max,
             delai.unt_del,
             @dtCreeLe,
             @dtMajLe,
             @sMajPar
        FROM sysadm.delai
       WHERE delai.id_prod = @dcIdProd   AND
             delai.id_rev  = @dcIdRevAnc

GO

--------------------------------------------------------------------
--
-- Procédure          : IM_D03_DELAI
-- Auteur             : V.Capelle
-- Date               : 07/11/1997 15:47:05
-- Libellé            : Delete sur table delai.
-- Commentaires       :	
-- Références         :	
-- Arguments          : @dcIdProd  decimal ( 7, 0 ),
--                      @dcIdRev   decimal ( 7, 0 ),
--                      @dcIdGti   decimal ( 7, 0 )
--
-- Retourne           :	
--				  
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D03_DELAI' AND type = 'P' )
            DROP procedure sysadm.IM_D03_DELAI
GO

CREATE PROC sysadm.IM_D03_DELAI
            @dcIdProd  decimal ( 7, 0 ),
            @dcIdRev   decimal ( 7, 0 ),
            @dcIdGti   decimal ( 7, 0 )
AS

 DELETE FROM sysadm.delai
       WHERE sysadm.delai.id_prod = @dcIdProd AND
             sysadm.delai.id_rev  = @dcIdRev  AND
             sysadm.delai.id_gti  = @dcIdGti

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S03_DELAI_SIN
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Sélect sur la table DELAI
-- Références           :       Utilisé dans W_TM_SP_SINISTRE (Liste détail)
--
-- Arguments            :       @dcIdProd       decimal ( 7, 0 )                 (Val)
--                              @dcIdRev        decimal ( 7, 0 )                 (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_DELAI_SIN' AND type = 'P' )
        DROP procedure sysadm.DW_S03_DELAI_SIN
GO

CREATE procedure sysadm.DW_S03_DELAI_SIN
        @dcIdProd       decimal ( 7, 0 )         ,
        @dcIdRev        decimal ( 7, 0 )       
AS
 SELECT delai.id_prod,
        delai.id_rev,
        delai.id_gti,
        delai.id_niv_del,
        delai.id_ref_del,
        delai.id_typ_del,
        delai.id_cpt_del,
        delai.dur_min,
        delai.dur_max,
        delai.unt_del,
        code_car.lib_code
 FROM   sysadm.delai,
        sysadm.code_car
 WHERE  delai.id_prod           = @dcIdProd             AND
        delai.id_rev            = @dcIdRev              AND
        delai.id_typ_del        = code_car.id_code      AND
        code_car.id_typ_code    = '-DL'

GO

