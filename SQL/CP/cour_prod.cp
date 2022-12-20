-------------------------------------------------------------------
--
-- Fichier              :       cour_prod.cp
-- Auteur               :       JCA
-- Date                 :       24/05/2007
--
-- Commentaires         :       Liste des procédures stockées afférentent à la table [COUR_PROD]
--									(souvent en remplacement des procédures stockées de la table [courrier]
--
-- Procédures           :       
-- DW_S01_COUR_PROD 
--******************************* -- DW_I01_COUR_PROD
--******************************* -- DW_D01_COUR_PROD
-- DW_S01_PARA_COUR_PROD 
-- DW_S01_COMPO_COUR_PROD 
--******************************* -- DW_I01_COUR_PROD_PARA 
--******************************* -- IM_D01_COUR_PROD
-- PS_S01_COUR_PROD
-- DW_S04_CODE_COUR_PROD 
-- DW_S01_COUR_PROD_PARA 
-- IM_S01_COUR_PROD
-- PS_S01_COMPO_PARA_COUR_PROD 
-- DW_S02_COUR_PROD 
-- DW_S03_COUR_PROD 
--------------------------------------------------------------------


--------------------------------------------------------------------
--
-- Procédure	:	DW_S01_COUR_PROD 
-- Auteur		:	JCA
-- Date		:	18/04/2007
-- Libellé		:	Select sur les tables COUR_PROD et COUR_TYPE
-- Commentaires	:	Liste des Codes Courriers affectes a un Produit.
-- Références	:	W_TM_SP_PRODUIT, UO_COURRIER, D_SP_PROD_COUR
--
-- Arguments	:	@dcIdProd  decimal ( 7, 0 )
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_COUR_PROD' AND type = 'P' )
            DROP procedure sysadm.DW_S01_COUR_PROD
GO

CREATE PROC sysadm.DW_S01_COUR_PROD
            @dcIdProd  decimal ( 7, 0 )
AS

SELECT	cp.id_prod,
		cp.id_nat_cour,
		ct.lib_cour,
		cp.id_cour
FROM	sysadm.cour_prod cp

INNER JOIN sysadm.cour_type ct
	ON cp.id_cour = ct.id_cour

WHERE	cp.id_prod	= @dcIdProd

GROUP BY	cp.id_prod,
			cp.id_nat_cour,
			ct.lib_cour,
			cp.id_cour
GO

/* 
--------------------------------------------------------------------
--
-- Procédure	:	DW_I01_COUR_PROD
-- Auteur		:	JCA
-- Date		:	25/04/2007
-- Libellé		:	Insert sur la table COURRIER.
-- Commentaires	:
-- Références	:	W_TM_SP_PRODUIT, UO_COURRIER, UE_DWSOURCE_SQLPREVIEW
--
-- Arguments	:	@dcIdProd       decimal ( 7, 0 ),
--				@sIdNatCour     Varchar ( 6 ),
--				@sIdCour        Varchar ( 6 ),
--				@sAltConf       Varchar ( 1 ),
--				@dtCreeLe       DateTime,
--				@dtMajLe        DateTime,
--				@sMajPar        Varchar ( 4 )
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_COUR_PROD' AND type = 'P' )
            DROP procedure sysadm.DW_I01_COUR_PROD
GO

CREATE PROC sysadm.DW_I01_COUR_PROD
  @dcIdProd       decimal ( 7, 0 ),
  @sIdNatCour     Varchar ( 6 ),
  @sIdCour        Varchar ( 6 ),
  @sAltConf       Varchar ( 1 ),
  @dtCreeLe       DateTime,
  @dtMajLe        DateTime,
  @sMajPar        Varchar ( 4 )
AS

INSERT sysadm.cour_prod (id_prod, id_nat_cour, id_cour, id_para, id_ordre, alt_conf, cree_le, maj_le, maj_par )
	SELECT	@dcIdProd, 
			@sIdNatCour, 
			@sIdCour,
			cp.id_para, 
			cp.id_ordre, 
			@sAltConf,
			@dtCreeLe, 
			@dtMajLe, 
			@sMajPar 
	FROM	sysadm.composition cp
	WHERE	cp.id_cour = @sIdCour

GO
*/
 
/*
--------------------------------------------------------------------
--
-- Procédure	:	DW_D01_COUR_PROD
-- Auteur		:	JCA
-- Date		:	19/04/2007
-- Libellé		:	Delete sur la table COUR_PROD
-- Commentaires	:
-- Références	:	W_TM_SP_PRODUIT, UO_COURRIER, UE_DWSOURCE_SQLPREVIEW 
--
-- Arguments	:	@dcIdProd     decimal ( 7, 0 ),
--				@sIdNatCour   Varchar ( 6 )
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_D01_COUR_PROD' AND type = 'P' )
            DROP procedure sysadm.DW_D01_COUR_PROD
GO

CREATE PROC sysadm.DW_D01_COUR_PROD
            @dcIdProd     decimal ( 7, 0 ),
            @sIdNatCour   Varchar ( 6 )
AS

DELETE	sysadm.cour_prod
WHERE	cour_prod.id_prod     = @dcIdProd
AND		cour_prod.id_nat_cour = @sIdNatCour

GO
*/

--------------------------------------------------------------------
--
-- Procédure	:	DW_S01_PARA_COUR_PROD
-- Auteur		:	JCA
-- Date		:	23/04/2007
-- Libellé		:	Select sur les tables COUR_PROD et PARAGRAPHE
-- Commentaires	:	Liste des Codes Paragraphe non affectes a un courrier.
-- Références	:	w_t_sp_paragraphe_cour_prod, uo_paragraphe, d_sp_lst_para_cour_prod_rch_jca
--
-- Arguments	:	@dcIdProd  decimal ( 7, 0 )
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_PARA_COUR_PROD' AND type = 'P' )
            DROP procedure sysadm.DW_S01_PARA_COUR_PROD
GO

CREATE PROC sysadm.DW_S01_PARA_COUR_PROD
            @dcIdProd  decimal ( 7, 0 ),
			@sIdCour  Varchar ( 6 )
AS

SELECT	convert ( decimal ( 7 ) , null ),
		'',
		'',
		paragraphe.id_para,
		convert ( decimal ( 7 ) , null ),
		paragraphe.lib_para,
		'',
		convert ( datetime , null ),
		convert ( datetime , null ),
		''
FROM	sysadm.paragraphe
WHERE	paragraphe.id_para NOT IN ( SELECT cour_prod.id_para
									FROM	sysadm.cour_prod
									WHERE	cour_prod.id_cour = @sIdCour
									AND		cour_prod.id_prod = @dcIdProd
									)

GO

--------------------------------------------------------------------
--
-- Procédure	:	DW_S01_COMPO_COUR_PROD
-- Auteur		:	JCA
-- Date		:	23/04/2007
-- Libellé		:	Select sur les tables COUR_PROD et PARAGRAPHE
-- Commentaires	:	Liste des Codes Paragraphe affectes a un courrier.
-- Références	:	w_t_sp_paragraphe_cour_prod, uo_paragraphe, d_sp_compo_para_cour_prod_jca
--
-- Arguments	:	@dcIdProd  decimal ( 7, 0 )
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_COMPO_COUR_PROD' AND type = 'P' )
            DROP procedure sysadm.DW_S01_COMPO_COUR_PROD
GO

CREATE PROC sysadm.DW_S01_COMPO_COUR_PROD
        @dcIdProd  decimal ( 7, 0 ) --,
-- chargement pour le produit dans le master (w_tm_sp_produit), puis trie sur le courrier dans le detail (w_t_sp_paragraphe_cour_prod)
--	@sIdCour  Varchar ( 6 )
AS

SELECT	cour_prod.id_prod,
		cour_prod.id_nat_cour,
		cour_prod.id_cour,
		cour_prod.id_para,
		cour_prod.id_ordre,
		paragraphe.lib_para,
		cour_prod.alt_conf,
		cour_prod.cree_le,
		cour_prod.maj_le,
		cour_prod.maj_par
FROM 	sysadm.cour_prod,
		sysadm.paragraphe
WHERE	cour_prod.id_para = paragraphe.id_para
AND		cour_prod.id_prod = @dcIdProd
-- AND		cour_prod.id_cour = @sIdCour

GO

/* 
--------------------------------------------------------------------
--
-- Procédure            :       DW_I01_COUR_PROD_PARA
-- Auteur               :       JCA
-- Date                 :       23/04/2007
-- Libellé              :       Insert sur la table Cour_prod
-- Commentaires         :
-- Références           :       W_T_SP_PARAGRAPHE_COUR_PROD, UE_DWSOURCE_SQLPREVIEW 
--
-- Arguments            :       @sIdCour       Varchar ( 6 ),
--                              @sIdPara       Varchar ( 4 ),
--                              @dcIdOrdre     decimal ( 4, 0 ),
--                              @dtCreeLe      DateTime,
--                              @dtMajLe       DateTime,
--                              @sMajPar       Varchar ( 4 )
--
-- Retourne             :
--
-------------------------------------------------------------------


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_I01_COUR_PROD_PARA' AND type = 'P' )
            DROP procedure sysadm.DW_I01_COUR_PROD_PARA
GO

CREATE PROC sysadm.DW_I01_COUR_PROD_PARA
	@dcIdProd	decimal ( 7, 0 ),
	@sIdCour	Varchar ( 6 ),
	@sIdPara	Varchar ( 4 ),
	@dcIdOrdre	decimal ( 4, 0 ),
	@sAltConf	varchar ( 1 ),
	@dtCreeLe   DateTime,
	@dtMajLe    DateTime,
	@sMajPar    Varchar ( 4 )
AS

INSERT INTO sysadm.cour_prod (
	cour_prod.id_prod,
	cour_prod.id_nat_cour,
	cour_prod.id_cour,
	cour_prod.id_para,
	cour_prod.id_ordre,
	cour_prod.alt_conf,
	cour_prod.cree_le,
	cour_prod.maj_le,
	cour_prod.maj_par
	)
VALUES ( 
	@dcIdProd, 
	@sIdCour, 
	@sIdCour, 
	@sIdPara, 
	@dcIdOrdre, 
	@sAltConf, 
	@dtCreeLe, 
	@dtMajLe, 
	@sMajPar 
	)

GO
*/

/* 
--------------------------------------------------------------------
--
-- Procédure	:	IM_D01_COUR_PROD
-- Auteur		:	JCA
-- Date			:	24/04/2007
-- Libellé		:	Delete sur la table cour_prod.
-- Commentaires	:
-- Références	:	W_T_SP_PARAGRAPHE_COUR_PROD, Wf_TerminerValider ()
--
-- Arguments	:	@dcIdProd      Decimal ( 7, 0 ),
--					@sIdCour   Varchar ( 6 )
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D01_COUR_PROD' AND type = 'P' )
            DROP procedure sysadm.IM_D01_COUR_PROD
GO

CREATE PROC sysadm.IM_D01_COUR_PROD
	@dcIdProd      Decimal ( 7, 0 ),
	@sIdCour       Varchar ( 6 )
AS

DELETE FROM sysadm.cour_prod
WHERE	cour_prod.id_prod = @dcIdProd
AND		cour_prod.id_cour = @sIdCour

GO
*/
 
--------------------------------------------------------------------
--
-- Procedure    : PS_S01_COUR_PROD
-- Auteur       : JCA
-- Date         : 15/05/2007
-- Libelle      : Select sur la table [cour_prod]
-- Commentaires :
-- References   : 
--
-- Arguments    :	@dcIdProd	Decimal ( 7 ) (val)
--					@sIdCour   Varchar ( 6   ) ( Val )
--					@sTxtCompo Varchar ( 240 ) ( Ref )
--
-- Retourne     : La chaine de composition.
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_COUR_PROD' AND type = 'P' )
            DROP procedure sysadm.PS_S01_COUR_PROD
GO

CREATE PROC sysadm.PS_S01_COUR_PROD
 @dcIdProd	Decimal ( 7 ),
 @sIdCour     Varchar ( 6 ),
 @sTxtCompo   Varchar ( 248 ) OUTPUT
AS

SET NOCOUNT ON

SELECT @sTxtCompo = RTRIM ( @sTxtCompo )

DECLARE @sIdPara  Varchar ( 4 )
DECLARE @sCptVer  Varchar ( 3 )
DECLARE @iIdOrdre  Decimal ( 4 )

DECLARE Curseur Cursor For

SELECT  DISTINCT
	cour_prod.id_para,
	paragraphe.cpt_ver,
	cour_prod.id_ordre
FROM
	sysadm.cour_prod,
	sysadm.paragraphe
WHERE
	paragraphe.id_para = cour_prod.id_para
AND
	cour_prod.id_cour = @sIdCour
AND
	cour_prod.id_prod = @dcIdProd
ORDER BY cour_prod.id_ordre ASC

OPEN Curseur

FETCH Curseur INTO @sIdPara, @sCptVer, @iIdOrdre

WHILE @@FETCH_STATUS <> -1

  BEGIN

    SELECT @sTxtCompo = @sTxtCompo + @sIdPara + '.' + @sCptVer

    FETCH Curseur INTO @sIdPara, @sCptVer, @iIdOrdre

  END

CLOSE Curseur

DEALLOCATE Curseur

GO

--------------------------------------------------------------------
--
-- Procedure    : PS_S01_COUR_PROD_V02
-- Auteur       : JFF
-- Date         : 02/07/2021
-- Libelle      : Select sur la table [cour_prod]
-- Commentaires :
-- References   : 
--
-- Arguments    :	@dcIdProd	Decimal ( 7 ) (val)
--					@sIdNatCour   Varchar ( 6   ) ( Val )
--					@sIdCour   Varchar ( 6   ) ( Val )
--					@sTxtCompo Varchar ( 240 ) ( Ref )
--
-- Retourne     : La chaine de composition.
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_COUR_PROD_V02' AND type = 'P' )
            DROP procedure sysadm.PS_S01_COUR_PROD_V02
GO

CREATE PROC sysadm.PS_S01_COUR_PROD_V02
 @dcIdProd	Decimal ( 7 ),
 @sIdNatCour  Varchar ( 6 ),
 @sIdCour     Varchar ( 6 ),
 @sTxtCompo   Varchar ( 248 ) OUTPUT
AS

SET NOCOUNT ON

SELECT @sTxtCompo = RTRIM ( @sTxtCompo )

DECLARE @sIdPara  Varchar ( 4 )
DECLARE @sCptVer  Varchar ( 3 )
DECLARE @iIdOrdre  Decimal ( 4 )

DECLARE Curseur Cursor For

SELECT  DISTINCT
	cour_prod.id_para,
	paragraphe.cpt_ver,
	cour_prod.id_ordre
FROM
	sysadm.cour_prod,
	sysadm.paragraphe
WHERE
	paragraphe.id_para = cour_prod.id_para
AND
	cour_prod.id_nat_cour = @sIdNatCour
AND
	cour_prod.id_cour = @sIdCour
AND
	cour_prod.id_prod = @dcIdProd
ORDER BY cour_prod.id_ordre ASC

OPEN Curseur

FETCH Curseur INTO @sIdPara, @sCptVer, @iIdOrdre

WHILE @@FETCH_STATUS <> -1

  BEGIN

    SELECT @sTxtCompo = @sTxtCompo + @sIdPara + '.' + @sCptVer

    FETCH Curseur INTO @sIdPara, @sCptVer, @iIdOrdre

  END

CLOSE Curseur

DEALLOCATE Curseur

GO


--------------------------------------------------------------------
--
-- Procédure	:	DW_S04_CODE_COUR_PROD
-- Auteur		:	JCA
-- Date		:	19/04/2007
-- Libellé		:	Select sur les tables [code_car] [cour_prod] [cour_type]
-- Commentaires	:	Liste des Codes Courriers possibles non affectés à un Produit.
--
-- Références	:	W_TM_SP_PRODUIT, UO_COURRIER, D_SP_LST_COUR_RCH
--
-- Arguments	:	@dcIdProd  decimal ( 7, 0 )
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S04_CODE_COUR_PROD' AND type = 'P' )
            DROP procedure sysadm.DW_S04_CODE_COUR_PROD
GO

CREATE PROC sysadm.DW_S04_CODE_COUR_PROD
            @dcIdProd  decimal ( 7, 0 )
AS

SELECT	CONVERT ( DECIMAL(7) , NULL ),
	cc.id_code,
	cc.lib_code,
	ct.id_cour
FROM	sysadm.code_car cc
INNER JOIN sysadm.cour_type ct
	ON cc.id_code = ct.id_cour 
WHERE	cc.id_typ_code = '-CC' 
AND	cc.id_code NOT IN ( SELECT cp.id_nat_cour
				FROM sysadm.cour_prod cp
				WHERE cp.id_prod = @dcIdProd  )

GO

--------------------------------------------------------------------
--
-- Procédure	:	IM_S01_COUR_PROD
-- Auteur		:	JCA
-- Date		:	16/05/2007
-- Libellé		:	permet de savoir si le code que l'on désire supprimer n'est pas lié a un courrier.
-- Commentaires	:
-- Références	:	U_SPB_GS_CODECAR, Uf_Gs_Sup_Code
--
-- Arguments	:	@dcIdProd Decimal (7)
--				@sIdCode   Varchar ( 6 )   Id_Code
--				@iNbCode   Integer OUTPUT  Nombre trouvé
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_S01_COUR_PROD' AND type = 'P' )
            DROP procedure sysadm.IM_S01_COUR_PROD
GO

CREATE PROC sysadm.IM_S01_COUR_PROD
		@sIdCode	Varchar,
		@iNbCode	Integer OUTPUT
AS

SELECT  cour_prod.id_cour
FROM    sysadm.cour_prod
WHERE   cour_prod.id_cour = @sIdCode

SELECT  @iNbCode = @@ROWCOUNT

GO

--------------------------------------------------------------------
--
-- Procédure	:	PS_S01_COMPO_PARA_COUR_PROD
-- Auteur		:	JCA
-- Date			:	23/05/2007
-- Libellé		:	Charge la composition d'un courrier
-- Commentaires	:
-- Références	:	w_tm_sp_produit, uo_courrier, ds_paragraphe
--
-- Arguments	:	  @sIdCour        Varchar ( 6 )
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_COMPO_PARA_COUR_PROD' AND type = 'P' )
            DROP procedure sysadm.PS_S01_COMPO_PARA_COUR_PROD
GO

CREATE PROC sysadm.PS_S01_COMPO_PARA_COUR_PROD
  @sIdCour        Varchar ( 6 )
AS

SELECT	convert ( decimal ( 7 ) , null ), 
	@sIdCour, 
	@sIdCour,
	cp.id_para, 
	cp.id_ordre,
	p.lib_para,
	convert ( char ( 1 ) , null ),
	cp.cree_le, 
	convert ( datetime , null ),
	convert ( char ( 4 ) , null )
FROM	sysadm.composition cp
INNER JOIN sysadm.paragraphe p
ON p.id_para = cp.id_para
WHERE	cp.id_cour = @sIdCour

GO

--------------------------------------------------------------------
--
-- Procédure	:	DW_S02_COUR_PROD
-- Auteur		:	JCA
-- Date		:	23/05/2007
-- Libellé		:	
-- Commentaires	:
-- Références	:	
--
-- Arguments	:	  @dcIdProd  decimal ( 7, 0 )
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S02_COUR_PROD' AND type = 'P' )
            DROP procedure sysadm.DW_S02_COUR_PROD
GO

CREATE PROC sysadm.DW_S02_COUR_PROD
	@dcIdProd  decimal ( 7, 0 )
AS

SELECT	distinct 
		cour_prod.id_prod,
		cour_prod.id_nat_cour,
		code_car.lib_code,
		cour_prod.id_cour,
		cour_prod.id_conf_deb,
		cour_prod.id_conf_n,
		cour_prod.id_conf_fin,
		cour_prod.alt_conf,
		convert(datetime, null), --cour_prod.cree_le,
		convert(datetime, null), --cour_prod.maj_le,
		convert(char(4), null)  --ccour_prod.maj_par
FROM	sysadm.cour_prod,
		sysadm.code_car
WHERE	cour_prod.id_prod     = @dcIdProd
AND		code_car.id_typ_code = '-CC'            
AND		cour_prod.id_nat_cour = code_car.id_code

GO

--------------------------------------------------------------------
--
-- Procédure	:	DW_S03_COUR_PROD
-- Auteur		:	JCA
-- Date		:	23/05/2007
-- Libellé		:	Charge la composition d'un courrier
-- Commentaires	:
-- Références	:	
--
-- Arguments	:	  @dcIdProd  decimal ( 7, 0 )
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S03_COUR_PROD' AND type = 'P' )
            DROP procedure sysadm.DW_S03_COUR_PROD
GO

CREATE PROC sysadm.DW_S03_COUR_PROD
	@dcIdProd  decimal ( 7, 0 )
AS
 SELECT distinct cour_prod.id_prod,
        cour_prod.id_nat_cour,
        code_car.lib_code,
        cour_prod.id_cour
   FROM sysadm.cour_prod,
        sysadm.code_car
  WHERE cour_prod.id_prod     = @dcIdProd        AND
        code_car.id_typ_code = '-CC'            AND
        cour_prod.id_nat_cour = code_car.id_code AND
        cour_prod.id_nat_cour like 'Z%'

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       DW_S01_COUR_PROD_PARA
-- Auteur               :       JCA
-- Date                 :       11/03/2004
-- Libell‚              :       Rappatriement des paragraphes pour la SVE
-- Commentaires         :       Si composition non existante on ramène un paragraphe
--				d'erreur
-- R‚f‚rences           :       
--
-- Arguments            :       @dcIdSin        Decimal (  7,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_COUR_PROD_PARA' And type = "P" )
DROP PROCEDURE sysadm.DW_S01_COUR_PROD_PARA
GO

CREATE PROCEDURE sysadm.DW_S01_COUR_PROD_PARA
	@sIdCour	VarChar( 6 ),
	@dcIdProd	Decimal( 7, 0 )
AS

Declare @iRet integer

SELECT	@iRet = Count(*) 
FROM	sysadm.cour_prod 
WHERE	id_cour = @sIdCour 
AND		id_prod = @dcIdProd

If @iRet > 0
 Begin

	SELECT  p.id_para,
	        p.lib_para,
	        p.cpt_ver,
	        p.maj_le,
	        p.maj_par,
	        c.id_ordre
	FROM 	sysadm.cour_prod c
		INNER JOIN sysadm.paragraphe p ON c.id_para = p.id_para 
	WHERE 	c.id_cour = @sIdCour
	AND		c.id_prod = @dcIdProd

 End

Else

   Begin  

	SELECT  p.id_para,
	        p.lib_para,
	        p.cpt_ver,
	        p.maj_le,
	        p.maj_par,
	        1
	FROM    sysadm.paragraphe p
        WHERE   p.id_para = 'NERR'
    
   End   
Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_COUR_PROD_PARA_APART1
-- Auteur               :       JFF
-- Date                 :       12/12/2011
-- Libell‚              :       VDOC5983
-- R‚f‚rences           :       
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_COUR_PROD_PARA_APART1' And type = 'P' )
DROP PROCEDURE sysadm.PS_S_COUR_PROD_PARA_APART1
GO

CREATE PROCEDURE sysadm.PS_S_COUR_PROD_PARA_APART1
	@dcIdProd	Decimal( 7, 0 ),
	@dcIdOrdre	Decimal( 4, 0 ),
	@sIdPara	VarChar ( 4 ) OUTPUT
AS

Select @sIdPara = c.id_para
From   sysadm.cour_prod c
where  c.id_prod = @dcIdProd
and    c.id_cour = 'APART1'
and    c.id_ordre = @dcIdOrdre

Go
