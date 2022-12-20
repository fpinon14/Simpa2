-------------------------------------------------------------------
--
-- Fichier              :       Code.cp
-- Auteur               :       La Recrue
-- Date                 :       18/07/97 12:00:33
--
-- Commentaires         :       Liste des proc‚dures aff‚rentes … la table des codes
--
-- Proc‚dures           :	
--                              DW_S02_CODE
--                              DW_S03_CODE
--                              DW_S05_CODE
--                              DW_S06_CODE
--                              DW_S07_CODE
-------------------------------------------------------------------



--------------------------------------------------------------------
--
-- Procédure            :       DW_S02_CODE
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 11:57:38
-- Libell‚              :       S‚lection des codes condition possibles pour 
--                              les garanties d'un produit
-- Commentaires         :
-- R‚f‚rences           :       w_td_sp_code_condition
--
-- Arguments            :       @dcIdGti         decimal ( 7, 0 ) : code garantie.
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_CODE' AND type = 'P' )
            DROP procedure sysadm.DW_S02_CODE
GO

CREATE PROC sysadm.DW_S02_CODE
            @dcIdGti         decimal ( 7, 0 )
AS

 SELECT convert ( decimal(7) , null ),
        @dcIdGti,
        sysadm.code.id_typ_code, 
        sysadm.code.id_code,
        sysadm.code.lib_code,
	convert ( varchar  , null ),
        convert ( datetime , null ),
        convert ( datetime , null ),
        ''
   FROM sysadm.code
  WHERE sysadm.code.id_typ_code IN ( '+NS', '+TR', '+DT', '+EV' ) 

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S03_CODE
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 12:56:19
-- Libellé              :       Select sur les tables CODE
--
-- Commentaires         :       Liste des Garanties possibles non affect‚es … un Produit.
--                              Utilise dans D_SP_LST_COD_GAR_RCH, objet Uo_Garantie, fenˆtre W_TM_SP_PRODUIT.
--
-- Références           :       W_TM_SP_PRODUIT, D_SP_LST_COD_GAR_RCH
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_CODE' AND type = 'P' )
            DROP procedure sysadm.DW_S03_CODE
GO

/*-------------------------------------------------------------------
[DATABASE] SIMPA2_PRO
[DESCRIPTION] 
[MAJ PAR] DATAFLY - AFX
[DATEMAJ] 15/10/2009

[VARIABLES]
    @sNumCarte VARCHAR(19) = NULL
-------------------------------------------------------------------*/
CREATE PROC [sysadm].[DW_S03_CODE] @dcIdProd DECIMAL(7, 0)
AS 
    SELECT  CONVERT (DECIMAL(7), NULL),
            codeGA.id_code,
            codeGA.lib_code,
            0,
            codeGS.id_code,
            CONVERT (DATETIME, NULL),
            CONVERT (DATETIME, NULL),
            ''
    FROM    sysadm.code AS codeGA
            LEFT OUTER JOIN sysadm.code AS codeGS ON codeGA.id_code = codeGS.id_code AND codeGS.id_typ_code = '-GS'
    WHERE   codeGA.id_typ_code = '-GA'
            AND codeGA.id_code NOT IN (
            SELECT  code_garantie.id_gti
            FROM    sysadm.code_garantie
            WHERE   code_garantie.id_prod = @dcIdProd )

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S05_CODE
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 13:11:44
-- Libellé              :       Select sur la table des codes des piŠces non utilis‚es
-- Commentaires         :       par un code garantie d'un produit.
-- Références           :       w_td_sp_code_condition, dw_pieces, D_SP_LST_PCE_PRO
--
-- Arguments            :       @dcIdProduit     decimal ( 7, 0 ),
--                              @dcIdGti         decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S05_CODE' AND type = 'P' )
        DROP procedure sysadm.DW_S05_CODE
GO

/*-------------------------------------------------------------------
[DATABASE] SIMPA2_PRO
[DESCRIPTION] 
[MAJ PAR] DATAFLY - AFX
[DATEMAJ] 15/10/2009

[VARIABLES]
    @dcIdProduit DECIMAL(7, 0),
    @dcIdGti DECIMAL(7, 0)
-------------------------------------------------------------------*/
CREATE PROC [sysadm].[DW_S05_CODE]
    @dcIdProduit DECIMAL(7, 0),
    @dcIdGti DECIMAL(7, 0)
AS 
    SELECT  CONVERT (DECIMAL(7), NULL),
            CONVERT (DECIMAL(7), NULL),
            @dcIdGti,
            sysadm.code.id_code,
            sysadm.code.lib_code,
            sysadm.paragraphe.id_para,
            'G',
            CONVERT (DATETIME, NULL),
            CONVERT (DATETIME, NULL),
            ''
--ajout Migration PB4 PB8 WYNIWYG 03/2006
            ,
            CAST(NULL AS DECIMAL(9, 0))
    FROM    sysadm.code
            LEFT OUTER JOIN sysadm.paragraphe ON 'P' + RIGHT('000'
                                                             + CONVERT(CHAR(4), sysadm.code.id_code),
                                                             4) = sysadm.paragraphe.id_para
    WHERE   sysadm.code.id_typ_code = '+PC'
            AND sysadm.code.id_code NOT IN (
            SELECT  sysadm.piece.id_pce
            FROM    sysadm.piece
            WHERE   sysadm.piece.id_prod = @dcIdProduit
                    AND sysadm.piece.id_gti = @dcIdGti
                    AND sysadm.piece.id_rev <> -1 )

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S06_CODE
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 13:16:02
-- Libellé              :       Select sur la table des codes des motifs non utilis‚s
-- Commentaires         :       par un code garantie d'un produit.
-- Références           :       w_td_sp_code_condition, dw_refus, D_SP_LST_REf_PRO
--
-- Arguments            :       @dcIdProduit     decimal ( 7, 0 ),
--                              @dcIdGti         decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S06_CODE' AND type = 'P' )
        DROP procedure sysadm.DW_S06_CODE
GO

/*-------------------------------------------------------------------
[DATABASE] SIMPA2_PRO
[DESCRIPTION] 
[MAJ PAR] DATAFLY - AFX
[DATEMAJ] 15/10/2009

[VARIABLES]
    @dcIdProduit DECIMAL(7, 0),
    @dcIdGti DECIMAL(7, 0)
-------------------------------------------------------------------*/
CREATE PROC [sysadm].[DW_S06_CODE]
    @dcIdProduit DECIMAL(7, 0),
    @dcIdGti DECIMAL(7, 0)
AS 
    SELECT  CONVERT (DECIMAL(7), NULL),
            CONVERT (DECIMAL(7), NULL),
            @dcIdGti,
            sysadm.code.id_code,
            sysadm.code.lib_code,
            sysadm.paragraphe.id_para,
            'G',
            'X',
            CONVERT (DATETIME, NULL),
            CONVERT (DATETIME, NULL),
--Migration PB4 PB8 WYNIWYG 03/2006
--        ''
            CAST('' AS VARCHAR(4)),
            CAST(NULL AS DECIMAL(9, 0))
--fin Migration PB4 PB8 WYNIWYG 03/2006
    FROM    sysadm.code
            LEFT OUTER JOIN sysadm.paragraphe ON 'R' + RIGHT('000'
                                                             + CONVERT(CHAR(4), sysadm.code.id_code),
                                                             4) = sysadm.paragraphe.id_para
    WHERE   sysadm.code.id_typ_code = '+RE'
            AND sysadm.code.id_code NOT IN (
            SELECT  sysadm.motif.id_motif
            FROM    sysadm.motif
            WHERE   sysadm.motif.id_prod = @dcIdProduit
                    AND sysadm.motif.id_gti = @dcIdGti
                    AND sysadm.motif.id_rev <> -1 )

GO

--------------------------------------------------------------------
--
-- Procédure            :       DW_S07_CODE
-- Auteur               :       Catherine Abdmeziem
-- Date                 :       01/10/02
-- Libellé              :       Select sur la table des codes correspondant aux gammes
-- Commentaires         :       comprenant le fournisseur
-- Références           :       dddw_liste_gammes
--
-- Arguments            :       @sIdTypCode     Char ( 3 )
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S07_CODE' AND type = 'P' )
            DROP procedure sysadm.DW_S07_CODE
GO

CREATE PROC sysadm.DW_S07_CODE
            @IdTypCode        Char ( 3 )
AS

 SELECT id_code,
        lib_code,
        SUBSTRING ( lib_code, 1, 3 )
   FROM sysadm.code
  WHERE sysadm.code.id_typ_code	=	'-GM'


GO

--------------------------------------------------------------------
--
-- Procédure            :       DD_S01_CODE_DIVSIN
-- Auteur               :       FMO - WYNIWYG
-- Date                 :       31/03/2006
-- Libellé              :       Sélection des codes d'un type donné
-- Commentaires         :
-- Références           :       dddw_spb_code
--
-- Arguments            :       @sIdTypeCode    Varchar(3)
--
-- Retourne             :       RésultSet
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S01_CODE_DIVSIN' AND type = 'P' )
            DROP procedure sysadm.DD_S01_CODE_DIVSIN
GO

CREATE PROC sysadm.DD_S01_CODE_DIVSIN
            @sIdTypCode   Varchar ( 3 )
AS
--Migration PB4 PB8 WYNIWYG 03/2006
--créé sur le modèle de DD_S01_CODE

SELECT   sysadm.code.id_code,
         sysadm.code.lib_code
--ajout de 2 colonnes par rapport à DD_S01_CODE
,	cast(null as varchar(35)) as 'nom_zone',
	cast(null as int) as 'alt_visible'
FROM     sysadm.code
WHERE    sysadm.code.id_typ_code = @sIdTypCode And
         sysadm.code.id_code    >=0
GO


--------------------------------------------------------------------
--
-- Procédure            :       DD_S02_CODE
-- Auteur               :       FPI
-- Date                 :       10/03/2010
-- Libell‚              :       S‚lection des codes <> -1
-- Commentaires         :
-- R‚f‚rences           :       [PM02]
--
-- Arguments            :       @sTypCode
--
-- Retourne             :
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S02_CODE' AND type = 'P' )
            DROP procedure sysadm.DD_S02_CODE
GO

CREATE PROC sysadm.DD_S02_CODE
            @sTypCode         varchar(3)
AS

 SELECT convert ( decimal(7) , null ),
        sysadm.code.id_typ_code, 
        sysadm.code.id_code,
        sysadm.code.lib_code
   FROM sysadm.code
  WHERE sysadm.code.id_typ_code = @sTypCode

GO
