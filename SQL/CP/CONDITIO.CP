-------------------------------------------------------------------
--
-- Fichier              :       conditio.cp
-- Auteur               :       La Recrue
-- Date                 :       22/07/97 15:54:38
--
-- Commentaires         :       Liste des procs afférent à la table CONDITION
--
-- Procédures           :       IM_S01_CONDITION
--                              IM_I01_CONDITION
--                              IM_D01_CONDITION
--                              IM_D02_CONDITION
--                              IM_D03_CONDITION
--                              DW_S01_CONDITION
--                              DW_S02_CONDITION
--                              DW_I01_CONDITION
--                              DW_U01_CONDITION
--                              DW_S03_CONDITION_SIN
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       IM_S01_CONDITION
-- Auteur               :       YP
-- Date                 :       20/11/97 15:22:00
-- Libellé              :       permet de savoir si le code condition que l'on desire supprimer n'est
--                              pas lie à une condition de garantie.
--
-- Commentaires         :       W_TD_SP_CODE_CONDITION ; UO_CODCON ; Ue_DwSource_Supprime
-- Références           :
--
-- Arguments            :       @dcIdProd     decimal ( 7, 0 ),        Id produit
--                              @dcIdGti      decimal ( 7, 0 ),        id garantie
--                              @sIdTypCode   Varchar(3),     Id Type Code
--                              @dcIdCode     decimal ( 7, 0 ),        Id Code
--                              @iNbCondition integer ( 7, 0 ) OUTPUT  Nombre trouvé
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_S01_CONDITION' AND type = 'P' )
            DROP procedure sysadm.IM_S01_CONDITION
GO

CREATE PROC sysadm.IM_S01_CONDITION
            @dcIdProd       decimal ( 7, 0 ),
            @dcIdGti        decimal ( 7, 0 ),
            @sIdTypCode     Varchar(3),
            @dcIdCode       decimal ( 7, 0 ),
            @iNbCondition   Integer OUTPUT
AS

SELECT  condition.id_gti
FROM    sysadm.condition
WHERE   condition.id_prod     = @dcIdProd   AND
        condition.id_gti      = @dcIdGti    AND
        condition.id_typ_code = @sIdTypCode AND
        condition.id_code     = @dcIdCode

SELECT	@iNbCondition = @@ROWCOUNT

GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_I01_CONDITION
-- Auteur               :       La Recrue
-- Date                 :       22/07/97 15:56:36
-- Libellé              :       Utiliser pour dupliquer les CONDITIONS de la dernière REVISION lors de
--                              la création d'une nouvelle REVISION.
-- Commentaires         :
-- Références           :       W_Tm_Sp_Produit, Wf_TerminerValider (), U_SP_GS_REV_PROD, Uf_TerminerValider ()
--
-- Arguments            :       @dcIdProd    decimal ( 7, 0 ),
--                              @dcIdRev     decimal ( 7, 0 ),
--                              @dcIdRevAnc  decimal ( 7, 0 ),
--                              @dtCreeLe    DateTime,
--                              @dtMajLe     DateTime,
--                              @sMajPar     Varchar ( 4 )
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_I01_CONDITION' AND type = 'P' )
            DROP procedure sysadm.IM_I01_CONDITION
GO

CREATE PROC sysadm.IM_I01_CONDITION
            @dcIdProd        decimal ( 7, 0 ),
            @dcIdRev         decimal ( 7, 0 ),
            @dcIdRevAnc      decimal ( 7, 0 ),
            @dtCreeLe        DateTime,
            @dtMajLe         DateTime,
            @sMajPar         Varchar ( 4 )

AS

 INSERT INTO sysadm.condition
           ( condition.id_prod,
             condition.id_rev,
             condition.id_gti,
             condition.id_code,
             condition.id_typ_code,
             condition.alt_reg,
             condition.alt_plaf,
             condition.alt_del,
             condition.alt_fran,
             condition.cree_le,
             condition.maj_le,
             condition.maj_par )
      SELECT condition.id_prod,
             @dcIdRev,
             condition.id_gti,
             condition.id_code,
             condition.id_typ_code,
             condition.alt_reg,
             condition.alt_plaf,
             condition.alt_del,
             condition.alt_fran,
             @dtCreeLe,
             @dtMajLe,
             @sMajPar
        FROM sysadm.condition
       WHERE condition.id_prod = @dcIdProd   AND
             condition.id_rev  = @dcIdRevAnc

GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_D01_CONDITION
-- Auteur               :       La Recrue
-- Date                 :       22/07/97 17:07:02
-- Libellé              :       Delete sur table CONDITION.
-- Commentaires         :       PS_SUPREVISION 
-- Références           :
--
-- Arguments            : 
--
-- Retourne             :
--
-------------------------------------------------------------------


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D01_CONDITION' AND type = 'P' )
            DROP procedure sysadm.IM_D01_CONDITION
GO

CREATE PROC sysadm.IM_D01_CONDITION
            @dcIdProd  decimal ( 7, 0 ),
            @dcIdRev   decimal ( 7, 0 )
AS

 DELETE FROM sysadm.condition
       WHERE condition.id_prod = @dcIdProd AND
             condition.id_rev  = @dcIdRev


GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_D02_CONDITION
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 17:42:04
-- Libellé              :       Delete sur table CONDITION.
-- Commentaires         :
-- Références           :       PS_SUPPRODUIT 
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D02_CONDITION' AND type = 'P' )
            DROP procedure sysadm.IM_D02_CONDITION
GO

CREATE PROC sysadm.IM_D02_CONDITION
            @dcIdProd  decimal ( 7, 0 )
AS

 DELETE FROM sysadm.condition
       WHERE condition.id_prod = @dcIdProd

GO


--------------------------------------------------------------------
--
-- Procedure    : IM_D03_CONDITION
-- Auteur       : V.CAPELLE
-- Date         : 24/07/97 11:41:44
-- Libelle      : Delete sur la table Condition
-- Commentaires :	
-- References   : 
--
-- Arguments    : @dcIdProd  decimal ( 7, 0 )
--                @dcIdRev   decimal ( 7, 0 )
--                @dcIdGti   decimal ( 7, 0 )
--
-- Retourne     :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D03_CONDITION' AND type = 'P' )
            DROP procedure sysadm.IM_D03_CONDITION
GO

CREATE PROC sysadm.IM_D03_CONDITION
            @dcIdProd     decimal ( 7, 0 ),
            @dcIdRev      decimal ( 7, 0 ),
            @dcIdGti      decimal ( 7, 0 )
AS

 DELETE FROM sysadm.condition
       WHERE condition.id_prod = @dcIdProd	AND
             condition.id_rev  = @dcIdRev    AND
             condition.id_gti  = @dcIdGti

GO



--------------------------------------------------------------------
--
-- Procédure     :   DW_S01_CONDITION
-- Auteur        :   V.Capelle
-- Date          :   10/11/1997 11:14:31
-- Libellé       :   Sélection sur la table code_condition pour la 
--                   recherche des conditions de garantie à 
--                   paramétrer pour une garantie, d'une révision
--                   de produit
-- Commentaires  :
-- Références    :   w_tm_sp_garantie , uo_Condition ( Recherche )
-- Arguments     :	
-- Retourne      :	
--				  
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_CONDITION' AND type = 'P' )
            DROP procedure sysadm.DW_S01_CONDITION
GO


CREATE PROC sysadm.DW_S01_CONDITION
            @dcIdProd decimal ( 7, 0 ),
            @dcIdGti  decimal ( 7, 0 )

AS


 SELECT Convert ( decimal (7),  null )   ,
        Convert ( decimal (7),  null )   ,
        Convert ( decimal (7),  null )   ,
        sysadm.code_condition.id_code    ,
        sysadm.code_condition.id_typ_code,
        sysadm.code.lib_code             ,
        'N'                              ,
        'N'                              ,
        'N'                              ,
        'N'                              ,
        GetDate()                        ,
        GetDate()                        ,
        ''
   FROM sysadm.code,
        sysadm.code_condition
  WHERE code.id_typ_code       = code_condition.id_typ_code AND
        code.id_code           = code_condition.id_code     AND
        code_condition.id_prod = @dcIdProd                  AND
        ( code_condition.id_gti  = @dcIdGti                 OR
          code_condition.id_gti  = -1 )

GO

--------------------------------------------------------------------
--
-- Procédure     :   DW_S02_CONDITION
-- Auteur        :   V.Capelle
-- Date          :   10/11/1997 11:31:22
-- Libellé       :   Sélection des conditions de garantie déjà 
--                   affectées à une garantie, pour la révision 
--                   d'un produit
-- Commentaires  :	
-- Références    :   w_tm_sp_garantie , uo_Condition ( Source )
--
-- Arguments     :   @dcIdProd decimal ( 7, 0 ), 
--                   @dcIdRev  decimal ( 7, 0 ), 
--                   @dcIdGti  decimal ( 7, 0 )
--
-- Retourne      :   ResultSet
--				  
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_CONDITION' AND type = 'P' )
            DROP procedure sysadm.DW_S02_CONDITION

GO


CREATE PROC sysadm.DW_S02_CONDITION
            @dcIdProd decimal ( 7, 0 ), 
            @dcIdRev  decimal ( 7, 0 ), 
            @dcIdGti  decimal ( 7, 0 )
  
AS

 SELECT sysadm.condition.id_prod    ,
        sysadm.condition.id_rev     ,
        sysadm.condition.id_gti     ,
        sysadm.condition.id_code    ,
        sysadm.condition.id_typ_code,
        sysadm.code.lib_code        ,
        sysadm.condition.alt_reg    ,
        sysadm.condition.alt_plaf   ,
        sysadm.condition.alt_del    ,
        sysadm.condition.alt_fran   ,
        sysadm.condition.cree_le    ,
        sysadm.condition.maj_le     ,
        sysadm.condition.maj_par
   FROM sysadm.condition,
        sysadm.code
  WHERE sysadm.condition.id_prod     = @dcIdProd               AND
        sysadm.condition.id_rev      = @dcIdRev                AND
        sysadm.condition.id_gti      = @dcIdGti                AND
        sysadm.condition.id_typ_code = sysadm.code.id_typ_code AND
        sysadm.condition.id_code     = sysadm.code.id_code 

GO


--------------------------------------------------------------------
--
-- Procédure     :   DW_I01_CONDITION
-- Auteur        :   V.Capelle
-- Date          :   10/11/1997 11:55:04
-- Libellé       :   Insert sur la table condition
-- Commentaires  :	
-- Références    :   w_tm_sp_garantie , uo_Condition ( Source )
--
-- Arguments     :   @dcIdProd     decimal ( 7, 0 ),
--                   @dcIdRev      decimal ( 7, 0 ),
--                   @dcIdGti      decimal ( 7, 0 ),
--                   @dcIdCode     decimal ( 7, 0 ),
--                   @sIdTypCode   Varchar(3),
--                   @AltReg       Varchar(1),
--                   @dtCreeLe     DateTime,
--                   @dtMajLe      DateTime,
--                   @sMajPar      Varchar(4)
--
-- Retourne      :   Rien
--				  
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_CONDITION' and type = 'P' )
            DROP procedure sysadm.DW_I01_CONDITION
GO

CREATE PROC sysadm.DW_I01_CONDITION
       @dcIdProd     decimal ( 7, 0 ),
       @dcIdRev      decimal ( 7, 0 ),
       @dcIdGti      decimal ( 7, 0 ),
       @dcIdCode     decimal ( 7, 0 ),
       @dcIdTypCode  Varchar(3),
       @AltReg       Varchar(1),
       @AltPlaf      Varchar(1),
       @AltDel       Varchar(1),
       @AltFran      Varchar(1),
       @dtCreeLe     DateTime,
       @dtMajLe      DateTime,
       @sMajPar      Varchar(4)

AS

 INSERT INTO sysadm.condition
 ( id_prod , id_rev , id_gti  , id_code, id_typ_code, alt_reg, 
   alt_plaf, alt_del, alt_fran, cree_le, maj_le     , maj_par )
 VALUES
 (     @dcIdProd,
       @dcIdRev,
       @dcIdGti,
       @dcIdCode,
       @dcIdTypCode,
       @AltReg,
       @AltPlaf,
       @AltDel,
       @AltFran,
       @dtCreeLe,
       @dtMajLe,
       @sMajPar ) 

GO


--------------------------------------------------------------------
--
-- Procédure     :   DW_U01_CONDITION
-- Auteur        :   V.Capelle
-- Date          :   10/11/1997 12:07:04
-- Libellé       :   Update sur la table condition
-- Commentaires  :	
-- Références    :   w_tm_sp_garantie , uo_Condition ( Source )
--
-- Arguments     :   @dcIdProd     decimal ( 7, 0 ),
--                   @dcIdRev      decimal ( 7, 0 ),
--                   @dcIdGti      decimal ( 7, 0 ),
--                   @dcIdCode     decimal ( 7, 0 ),
--                   @sIdTypCode   Varchar(3),
--                   @AltReg       Varchar(1),
--                   @AltPlaf      Varchar(1),
--                   @AltDel       Varchar(1),
--                   @AltFran      Varchar(1),
--                   @dtMajLe      DateTime,
--                   @sMajPar      Varchar(4)
--
-- Retourne      :   Rien
--				  
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_U01_CONDITION' AND type = 'P' )
            DROP procedure sysadm.DW_U01_CONDITION
GO

CREATE PROC sysadm.DW_U01_CONDITION
            @dcIdProd     decimal ( 7, 0 ),
            @dcIdRev      decimal ( 7, 0 ),
            @dcIdGti      decimal ( 7, 0 ),
            @dcIdCode     decimal ( 7, 0 ),
            @sIdTypCode   Varchar(3),
            @sAltReg      Varchar(1),
            @sAltPlaf     Varchar(1),
            @sAltDel      Varchar(1),
            @sAltFran     Varchar(1),
            @dtMajLe      DateTime,
            @sMajPar      Varchar(4)

AS

  UPDATE sysadm.condition
     SET sysadm.condition.alt_reg     = @sAltReg     ,
         sysadm.condition.alt_plaf    = @sAltPlaf    ,
         sysadm.condition.alt_del     = @sAltDel     ,
         sysadm.condition.alt_fran    = @sAltFran    ,
         sysadm.condition.maj_le      = @dtMajLe     ,
         sysadm.condition.maj_par     = @sMajPar
   WHERE sysadm.condition.id_prod     = @dcIdProd AND
         sysadm.condition.id_rev      = @dcIdRev  AND
         sysadm.condition.id_gti      = @dcIdGti  AND
         sysadm.condition.id_code     = @dcIdCode AND
         sysadm.condition.id_typ_code = @sIdTypCode 

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S03_CONDITION_SIN
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Sélect sur la table CONDITION
-- Références           :       Utilisé dans W_TM_SP_SINISTRE
--
-- Arguments            :       @dcIdProd       decimal ( 7, 0 )                 (Val)
--                              @dcIdRev        decimal ( 7, 0 )                 (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_CONDITION_SIN' AND type = 'P' )
        DROP procedure sysadm.DW_S03_CONDITION_SIN
GO

CREATE procedure sysadm.DW_S03_CONDITION_SIN
        @dcIdProd       decimal ( 7, 0 )         ,
        @dcIdRev        decimal ( 7, 0 )       
AS
 SELECT condition.id_prod,
        condition.id_rev,
        condition.id_gti,
        condition.id_code,
        condition.id_typ_code,
        condition.alt_reg,
        condition.alt_plaf,
        condition.alt_del,
        condition.alt_fran,
        code.lib_code
 FROM   sysadm.condition,
        sysadm.code
 WHERE  condition.id_prod       = @dcIdProd             AND
        condition.id_rev        = @dcIdRev              AND
        condition.id_typ_code   = code.id_typ_code      AND
        condition.id_code       = code.id_code

GO
