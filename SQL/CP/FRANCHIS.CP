-------------------------------------------------------------------
--
-- Fichier              :       franchis.cp
-- Auteur               :       YP
-- Date                 :       03/09/97 16:03:49
--
-- Commentaires         :       Liste des procédures stockées afférent à la table franchise
--
-- Procédures           :       DW_S01_FRANCHISE
--                              DW_S02_FRANCHISE
--                              DW_I01_FRANCHISE
--                              DW_U01_FRANCHISE
--                              IM_D01_FRANCHISE
--                              IM_D02_FRANCHISE
--                              IM_I01_FRANCHISE
--                              IM_D03_FRANCHISE
--                              DW_S03_FRANCHISE_SIN
-------------------------------------------------------------------


--------------------------------------------------------------------
--
-- Procédure            :   DW_S01_FRANCHISE
--
-- Auteur               :   V.Capelle
--
-- Date                 :   25/11/1997 15:40:24
--                          
-- Libellé              :   Recherche des franchises à proposer pour une garantie,
--                          ou une condition de garantie.
--
-- Commentaires         :   
-- Références           :   w_t_sp_condition_gti, uo_franchises, dw_recherche
-- Arguments            :   
-- Retourne             :   
--                          
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_FRANCHISE' AND type = 'P' )
            DROP procedure sysadm.DW_S01_FRANCHISE

GO

CREATE PROC sysadm.DW_S01_FRANCHISE

AS 

	SELECT CONVERT ( Decimal(7), Null ),
          CONVERT ( Decimal(7), Null ),
          CONVERT ( Decimal(7), Null ),
          ''                          ,
          CONVERT ( Decimal(7), Null ),
          sysadm.code.id_code         ,
          sysadm.code.lib_code        ,
          0                           ,
          0                           ,
          ''                          ,
          0                           ,
          0                           ,
          'J'                         ,
          CONVERT ( Datetime  , Null ),
          CONVERT ( Datetime  , Null ),
          ''
    FROM  sysadm.code
   WHERE  sysadm.code.id_typ_code = '-FR' AND 
          sysadm.code.id_code     > 0 

GO


--------------------------------------------------------------------
--
-- Procédure            :   DW_S02_FRANCHISE
--
-- Auteur               :   V.Capelle
--
-- Date                 :   25/11/1997 15:49:24
--                          
-- Libellé              :   Recherche des Franchises associés à une garantie,
--                          ou une condition de garantie pour une révision 
--                          et un produit.
--
-- Commentaires         :   
-- Références           :   w_t_sp_condition_gti, uo_franchises, dw_source
-- Arguments            :   @dcIdProd   decimal ( 7, 0 ),
--                          @dcIdRev    decimal ( 7, 0 ),
--                          @dcIdGti    decimal ( 7, 0 )
-- Retourne             :   
--                          
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_FRANCHISE' AND type = 'P' )
            DROP procedure sysadm.DW_S02_FRANCHISE

GO

CREATE PROC sysadm.DW_S02_FRANCHISE
            @dcIdProd   decimal ( 7, 0 ),
            @dcIdRev    decimal ( 7, 0 ),
            @dcIdGti    decimal ( 7, 0 )

AS 

	SELECT sysadm.franchise.id_prod,
          sysadm.franchise.id_rev,
          sysadm.franchise.id_gti,
          sysadm.franchise.id_niv_fra,
          sysadm.franchise.id_ref_fra,
          sysadm.franchise.id_typ_fra,
          sysadm.code.lib_code,
          sysadm.franchise.id_cpt_fra,
          sysadm.franchise.mt_fra,
          sysadm.franchise.id_para,
          sysadm.franchise.dur_min,
          sysadm.franchise.dur_max,
          sysadm.franchise.unt_del,
          sysadm.franchise.cree_le,
          sysadm.franchise.maj_le,
          sysadm.franchise.maj_par
    FROM  sysadm.code,
          sysadm.franchise
   WHERE  sysadm.code.id_typ_code = '-FR'                       AND
          sysadm.code.id_code     = sysadm.franchise.id_typ_fra AND
          sysadm.franchise.id_prod    = @dcIdProd               AND
          sysadm.franchise.id_rev     = @dcIdRev                AND
          sysadm.franchise.id_gti     = @dcIdGti                  
GO


--------------------------------------------------------------------
--
-- Procédure            :   DW_I01_FRANCHISE
--
-- Auteur               :   V.Capelle
--
-- Date                 :   25/11/1997 15:58:24
--                          
-- Libellé              :   Insertion d'une franchise pour une garantie
--
-- Commentaires         :   
-- Références           :   w_tm_sp_garantie, Dw_franchise
-- Arguments            :   @dcIdProd    decimal ( 7, 0 ),
--                          @dcIdRev     decimal ( 7, 0 ),
--                          @dcIdGti     decimal ( 7, 0 ),
--                          @sIdNivFra   Varchar ( 3 ),
--                          @dcIdRefFra  decimal ( 7, 0 ),
--                          @dcIdTypFra  decimal ( 7, 0 ),
--                          @dcIdCptFra  decimal ( 4, 0 ),
--                          @dcMtFra     Decimal ( 11, 2 ),
--                          @IdPara      Varchar ( 4 ),
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
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_FRANCHISE' AND type = 'P' )
            DROP procedure sysadm.DW_I01_FRANCHISE

GO

CREATE PROC sysadm.DW_I01_FRANCHISE
            @dcIdProd    decimal ( 7, 0 ),
            @dcIdRev     decimal ( 7, 0 ),
            @dcIdGti     decimal ( 7, 0 ),
            @sIdNivFra   Varchar ( 3 ),
            @dcIdRefFra  decimal ( 7, 0 ),
            @dcIdTypFra  decimal ( 7, 0 ),
            @dcIdCptFra  decimal ( 4, 0 ),
            @dcMtFra     Decimal ( 11, 2 ),
            @IdPara      Varchar ( 4 ),
            @dcDurMin    decimal ( 5, 0 ),
            @dcDurMax    decimal ( 5, 0 ),
            @sUntDel     VarChar ( 1 ),
            @dtCreeLe    Datetime,       
            @dtMajLe     Datetime,      
            @sMajPar     VarChar ( 4 )  

AS 

	INSERT INTO  sysadm.franchise

               ( id_prod,   
                 id_rev,   
                 id_gti,   
                 id_niv_fra,
                 id_ref_fra,
                 id_typ_fra,
                 id_cpt_fra,
                 mt_fra,
                 id_para,
                 dur_min,
                 dur_max,
                 unt_del,
                 cree_le,
                 maj_le,
                 maj_par )
     VALUES (  @dcIdProd,    @dcIdRev,  @dcIdGti, @sIdNivFra, @dcIdRefFra, @dcIdTypFra,
               @dcIdCptFra,  @dcMtFra,  @IdPara,  @dcDurMin,  @dcDurMax ,  @sUntDel,       
               @dtCreeLe,    @dtMajLe,  @sMajPar )
GO


--------------------------------------------------------------------
--
-- Procédure            :   DW_U01_FRANCHISE
--
-- Auteur               :   V.Capelle
--
-- Date                 :   25/11/1997 16:18:24
--                          
-- Libellé              :   Modification d'une franchise pour une garantie
--
-- Commentaires         :   
-- Références           :   w_tm_sp_garantie, Dw_franchise
--
-- Arguments            :   @dcIdProd    decimal ( 7, 0 ),
--                          @dcIdRev     decimal ( 7, 0 ),
--                          @dcIdGti     decimal ( 7, 0 ),
--                          @sIdNivFra   Varchar ( 3 ),
--                          @dcIdRefFra  decimal ( 7, 0 ),
--                          @dcIdTypFra  decimal ( 7, 0 ),
--                          @dcIdCptFra  decimal ( 4, 0 ),
--                          @dcMtFra     Decimal ( 11, 2 ),
--                          @IdPara      Varchar ( 4 ),
--                          @dcDurMin    decimal ( 5, 0 ),
--                          @dcDurMax    decimal ( 5, 0 ),
--                          @sUntDel     VarChar ( 1 )
--                          @dtMajLe     Datetime,      
--                          @sMajPar     VarChar ( 4 )  
--
-- Retourne             :   
--                          
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_U01_FRANCHISE' AND type = 'P' )
            DROP procedure sysadm.DW_U01_FRANCHISE

GO

CREATE PROC sysadm.DW_U01_FRANCHISE
            @dcIdProd    decimal ( 7, 0 ),
            @dcIdRev     decimal ( 7, 0 ),
            @dcIdGti     decimal ( 7, 0 ),
            @sIdNivFra   Varchar ( 3 ),
            @dcIdRefFra  decimal ( 7, 0 ),
            @dcIdTypFra  decimal ( 7, 0 ),
            @dcIdCptFra  decimal ( 4, 0 ),
            @dcMtFra     Decimal ( 11, 2 ),
            @IdPara      Varchar ( 4 ),
            @dcDurMin    decimal ( 5, 0 ),
            @dcDurMax    decimal ( 5, 0 ),
            @sUntDel     VarChar ( 1 ),
            @dtMajLe     Datetime,      
            @sMajPar     VarChar ( 4 )
AS 
   UPDATE  sysadm.franchise
      SET  sysadm.franchise.mt_fra  = @dcMtFra,
           sysadm.franchise.id_para = @IdPara,
           sysadm.franchise.dur_min = @dcDurMin,
           sysadm.franchise.dur_max = @dcDurMax,
           sysadm.franchise.unt_del = @sUntDel,
           sysadm.franchise.maj_le  = @dtMajLe,
           sysadm.franchise.maj_par = @sMajPar
    WHERE  sysadm.franchise.id_prod    = @dcIdProd    AND
           sysadm.franchise.id_rev     = @dcIdRev     AND   
           sysadm.franchise.id_gti     = @dcIdGti     AND
           sysadm.franchise.id_niv_fra = @sIdNivFra   AND 
           sysadm.franchise.id_ref_fra = @dcIdRefFra  AND
           sysadm.franchise.id_typ_fra = @dcIdTypFra   AND
           sysadm.franchise.id_cpt_fra = @dcIdCptFra
                            
     
GO


--------------------------------------------------------------------
--
-- Procédure            :       IM_D01_FRANCHISE
-- Auteur               :       YP
-- Date                 :       03/09/97 16:03:37
-- Libellé              :       Delete sur table FRANCHISE.
-- Commentaires         :
-- Références           :       PS_SUPREVISION 
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 ),
--                              @dcIdRev   decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D01_FRANCHISE' AND type = 'P' )
            DROP procedure sysadm.IM_D01_FRANCHISE
GO

CREATE PROC sysadm.IM_D01_FRANCHISE
            @dcIdProd  decimal ( 7, 0 ),
            @dcIdRev   decimal ( 7, 0 )
AS

 DELETE FROM sysadm.franchise
       WHERE franchise.id_prod = @dcIdProd AND
             franchise.id_rev  = @dcIdRev


GO


--------------------------------------------------------------------
--
-- Procédure            :       IM_D02_FRANCHISE
-- Auteur               :       YP
-- Date                 :       03/09/97 16:03:37
-- Libellé              :       Delete sur table FRANCHISE.
-- Commentaires         :
-- Références           :       PS_SUPPRODUIT
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 ),
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D02_FRANCHISE' AND type = 'P' )
            DROP procedure sysadm.IM_D02_FRANCHISE
GO

CREATE PROC sysadm.IM_D02_FRANCHISE
            @dcIdProd  decimal ( 7, 0 )
AS

 DELETE FROM sysadm.franchise
       WHERE franchise.id_prod = @dcIdProd


GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_I01_FRANCHISE
-- Auteur               :       YP
-- Date                 :       03/09/97 16:23:45
-- Libellé              :       Utiliser pour dupliquer les FRANCHISES de la derniere REVISION lors de
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

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_I01_FRANCHISE' AND type = 'P' )
            DROP procedure sysadm.IM_I01_FRANCHISE
GO

CREATE PROC sysadm.IM_I01_FRANCHISE
            @dcIdProd        decimal ( 7, 0 ),
            @dcIdRev         decimal ( 7, 0 ),
            @dcIdRevAnc      decimal ( 7, 0 ),
            @dtCreeLe        DateTime,
            @dtMajLe         DateTime,
            @sMajPar         Varchar ( 4 )
AS

 INSERT INTO sysadm.franchise
           ( franchise.id_prod,
             franchise.id_rev,
             franchise.id_gti,
             franchise.id_niv_fra,
             franchise.id_ref_fra,
             franchise.id_typ_fra,
             franchise.id_cpt_fra,
             franchise.mt_fra,
             franchise.id_para,
             franchise.dur_min,
             franchise.dur_max,
             franchise.unt_del,
             franchise.cree_le,
             franchise.maj_le,
             franchise.maj_par )
      SELECT franchise.id_prod,
             @dcIdRev,
             franchise.id_gti,
             franchise.id_niv_fra,
             franchise.id_ref_fra,
             franchise.id_typ_fra,
             franchise.id_cpt_fra,
             franchise.mt_fra,
             franchise.id_para,
             franchise.dur_min,
             franchise.dur_max,
             franchise.unt_del,
             @dtCreeLe,
             @dtMajLe,
             @sMajPar
        FROM sysadm.franchise
       WHERE franchise.id_prod = @dcIdProd   AND
             franchise.id_rev  = @dcIdRevAnc

GO



--------------------------------------------------------------------
--
-- Procédure     : IM_D03_FRANCHISE
-- Auteur        : V.CAPELLE
-- Date          : 07/11/97 15:27:55
-- Libellé       : Delete sur table FRANCHISE.
-- Commentaires  : 
-- Références    : 
--
-- Arguments     : @dcIdProd  decimal ( 7, 0 ),
--                 @dcIdRev   decimal ( 7, 0 ),
--                 @dcIdGti   decimal ( 7, 0 )
--
-- Retourne      : 
--
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D03_FRANCHISE' AND type = 'P' )
 DROP procedure sysadm.IM_D03_FRANCHISE
GO

CREATE PROC sysadm.IM_D03_FRANCHISE
 @dcIdProd  decimal ( 7, 0 ),
 @dcIdRev   decimal ( 7, 0 ),
 @dcIdGti   decimal ( 7, 0 )
AS

 DELETE FROM sysadm.franchise
       WHERE sysadm.franchise.id_prod = @dcIdProd AND
             sysadm.franchise.id_rev  = @dcIdRev  AND
             sysadm.franchise.id_gti  = @dcIdGti

GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S03_FRANCHISE_SIN
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Sélect sur la table FRANCHISE
-- Références           :       Utilisé dans W_TM_SP_SINISTRE (Liste détail)
--
-- Arguments            :       @dcIdProd       decimal ( 7, 0 )                 (Val)
--                              @dcIdRev        decimal ( 7, 0 )                 (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_FRANCHISE_SIN' AND type = 'P' )
        DROP procedure sysadm.DW_S03_FRANCHISE_SIN
GO

/*-------------------------------------------------------------------
[DATABASE] SIMPA2_PRO
[DESCRIPTION] 
[MAJ PAR] DATAFLY - AFX
[DATEMAJ] 15/10/2009

[VARIABLES]
    @dcIdProd DECIMAL(7, 0),
    @dcIdRev DECIMAL(7, 0)
-------------------------------------------------------------------*/
CREATE PROCEDURE [sysadm].[DW_S03_FRANCHISE_SIN]
    @dcIdProd DECIMAL(7, 0),
    @dcIdRev DECIMAL(7, 0)
AS 
    SELECT  franchise.id_prod,
            franchise.id_rev,
            franchise.id_gti,
            franchise.id_niv_fra,
            franchise.id_ref_fra,
            franchise.id_typ_fra,
            franchise.id_cpt_fra,
            franchise.mt_fra,
            franchise.id_para,
            franchise.dur_min,
            franchise.dur_max,
            franchise.unt_del,
            code.lib_code,
            paragraphe.cpt_ver
    FROM    sysadm.franchise
            LEFT OUTER JOIN sysadm.paragraphe ON sysadm.franchise.id_para = sysadm.paragraphe.id_para
            INNER JOIN sysadm.code ON sysadm.franchise.id_typ_fra = sysadm.code.id_code
    WHERE   franchise.id_prod = @dcIdProd
            AND franchise.id_rev = @dcIdRev
            AND code.id_typ_code = '-FR'

GO
