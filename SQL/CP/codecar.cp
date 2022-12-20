-------------------------------------------------------------------
--
-- Fichier              :       Codecar.cp
-- Auteur               :       La Recrue
-- Date                 :       18/07/97 12:00:33
--
-- Commentaires         :       Liste des procédure afférent à la table des codes
--
-- Procédures           :
--                              DW_S04_CODE
--                              DD_S01_CODE_CAR
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procédure            :       DW_S04_CODE
-- Auteur               :       La Recrue
-- Date                 :       23/07/97 13:01:46
-- Libellé              :       Select sur les tables Code et Courrier.
-- Commentaires         :       Liste des Codes Courriers possibles non affectés à un Produit.
--
-- Références           :       W_TM_SP_PRODUIT, UO_COURRIER, D_SP_LST_COUR_RCH
--
-- Arguments            :       @dcIdProd  decimal ( 7, 0 )
--
-- Retourne             :
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S04_CODE' AND type = 'P' )
            DROP procedure sysadm.DW_S04_CODE
GO

/*-------------------------------------------------------------------
[DATABASE] SIMPA2_PRO
[DESCRIPTION] 
[MAJ PAR] DATAFLY - AFX
[DATEMAJ] 15/10/2009

[VARIABLES]
    @dcIdProd DECIMAL(7, 0)
-------------------------------------------------------------------*/
CREATE PROC [sysadm].[DW_S04_CODE] @dcIdProd DECIMAL(7, 0)
AS 
    SELECT  CONVERT (DECIMAL(7), NULL),
            sysadm.code_car.id_code,
            sysadm.code_car.lib_code,
            sysadm.cour_type.id_cour,
            '',
            '',
            '',
            'N',
            CONVERT (DATETIME, NULL),
            CONVERT (DATETIME, NULL),
            ''
    FROM    sysadm.code_car
            LEFT OUTER JOIN sysadm.cour_type ON sysadm.code_car.id_code = sysadm.cour_type.id_cour
    WHERE   code_car.id_typ_code = '-CC'
            AND code_car.id_code NOT IN (
            SELECT  courrier.id_nat_cour
            FROM    sysadm.courrier
            WHERE   courrier.id_prod = @dcIdProd )

GO

--------------------------------------------------------------------
--
-- Procédure            :       DD_S01_CODE_CAR
-- Auteur               :       YP
-- Date                 :       18/07/97 12:01:07
-- Libellé              :       Sélection des codes alphanum.d'un type donné
-- Commentaires         :
-- Références           :       dddw_sp_code_car
--
-- Arguments            :       @sIdTypeCode    Varchar(3)
--
-- Retourne             :       RésultSet
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S01_CODE_CAR' AND type = 'P' )
            DROP procedure sysadm.DD_S01_CODE_CAR
GO

CREATE PROC sysadm.DD_S01_CODE_CAR
            @sIdTypCode   Varchar ( 3 )
AS

SELECT   code_car.id_code,
         code_car.lib_code
FROM     sysadm.code_car
WHERE    id_typ_code = @sIdTypCode

GO

--------------------------------------------------------------------
--
-- Procédure            :       DD_S01_CODE_CAR_DIVSIN
-- Auteur               :       FMO - WYNIWYG
-- Date                 :       31/03/2006
-- Libellé              :       Sélection des codes alphanum.d'un type donné
-- Commentaires         :
-- Références           :       dddw_sp_code_car
--
-- Arguments            :       @sIdTypeCode    Varchar(3)
--
-- Retourne             :       RésultSet
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S01_CODE_CAR_DIVSIN' AND type = 'P' )
            DROP procedure sysadm.DD_S01_CODE_CAR_DIVSIN
GO

CREATE PROC sysadm.DD_S01_CODE_CAR_DIVSIN
            @sIdTypCode   Varchar ( 3 )
AS
--Migration PB4 PB8 WYNIWYG 03/2006
--créé sur le modèle de DD_S01_CODE_CAR
SELECT   code_car.id_code,
         code_car.lib_code
--ajout de 2 colonnes par rapport à DD_S01_CODE_CAR
,	cast(null as varchar(35)) as 'nom_zone',
	cast(null as int) as 'alt_visible'
--suppression du préfixe 
FROM     sysadm.code_car
WHERE    id_typ_code = @sIdTypCode
GO

--------------------------------------------------------------------
--
-- Procédure            :       PS_S01_CODE_CAR
-- Auteur               :       FPI
-- Date                 :       12/12/2008
-- Libellé              :       Test d'existence d'un code d'un type donné
-- Commentaires         :
-- Références           :       
--
-- Arguments            :       @sIdCode    Varchar(6)
--								@sIdTypeCode    Varchar(3)
--
-- Retourne             :       0/1
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_CODE_CAR' AND type = 'P' )
            DROP procedure sysadm.PS_S01_CODE_CAR
GO

CREATE PROC sysadm.PS_S01_CODE_CAR
	@sIdCode    Varchar(6),
	@sIdTypCode   Varchar ( 3 )
AS
	Select *
	From sysadm.code_car
	Where id_code = @sIdCode And id_typ_code=@sIdTypCode
	
	Return @@RowCount
GO

--------------------------------------------------------------------
--
-- Procédure            :       DD_S02_CODE_CAR
-- Auteur               :       FPI
-- Date                 :       10/03/2011
-- Libellé              :       Sélection des codes alphanum.d'un type donné (-1 exclus)
-- Commentaires         :	[PM02]
-- Références           :       dddw_sp_code_car
--
-- Arguments            :       @sIdTypeCode    Varchar(3)
--
-- Retourne             :       RésultSet
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DD_S02_CODE_CAR' AND type = 'P' )
            DROP procedure sysadm.DD_S02_CODE_CAR
GO

CREATE PROC sysadm.DD_S02_CODE_CAR
            @sIdTypCode   Varchar ( 3 )
AS

SELECT   code_car.id_code,
         code_car.lib_code
FROM     sysadm.code_car
WHERE    id_typ_code = @sIdTypCode
  and id_code <> '-1'
GO