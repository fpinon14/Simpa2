if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[DD_S01_POLE_RELANCE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[DD_S01_POLE_RELANCE]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[DD_S01_PRODUIT_RELANCE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[DD_S01_PRODUIT_RELANCE]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[DW_S01_COURRIER_RELANCE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[DW_S01_COURRIER_RELANCE]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[DW_S01_EXIST_SINISTRE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[DW_S01_EXIST_SINISTRE]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[DW_S01_FLUX_ERISA_SIM2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[DW_S01_FLUX_ERISA_SIM2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[DW_S01_POLE_PRODUIT]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[DW_S01_POLE_PRODUIT]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[DW_S01_RELANCE_NORMALE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[DW_S01_RELANCE_NORMALE]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[DW_S01_RELANCE_PARTICULIERE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[DW_S01_RELANCE_PARTICULIERE]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[DW_S01_SECONDE_RELANCE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[DW_S01_SECONDE_RELANCE]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[DW_S01_STOCK_ERISA_SIM2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[DW_S01_STOCK_ERISA_SIM2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[DW_S01_W_RAPPEL_CLIENT]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[DW_S01_W_RAPPEL_CLIENT]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_ARCHIVER]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[PS_ARCHIVER]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_EXECUTE_SQL_CMDE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[PS_EXECUTE_SQL_CMDE]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_I01_TRACE_RECAP_RELANCE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[PS_I01_TRACE_RECAP_RELANCE]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_I01_TRACE_RELANCE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[PS_I01_TRACE_RELANCE]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_LECTURE_MAIL_SIMPA2_V00]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[PS_LECTURE_MAIL_SIMPA2_V00]
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_PATCH_SUPEDITIONINVALIDE_SELECT]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[PS_PATCH_SUPEDITIONINVALIDE_SELECT]
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_U01_TRACE_RECAP_RELANCE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[PS_U01_TRACE_RECAP_RELANCE]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_V01_REF_ASSUREUR]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[PS_V01_REF_ASSUREUR]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_VERIF_IBAN]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[PS_VERIF_IBAN]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_X_LIB]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[PS_X_LIB]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_X_RECETTE_090421]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[PS_X_RECETTE_090421]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_X_SIMPA_AIG]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[PS_X_SIMPA_AIG]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[IM_S01_DEPARTEMENT]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[IM_S01_DEPARTEMENT]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_I02_ARCHIVE_RELANCE_ORANGE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [sysadm].[PS_I02_ARCHIVE_RELANCE_ORANGE]
GO


CREATE PROC sysadm.DD_S01_POLE_RELANCE

AS

SELECT	c.id_code,
		c.lib_code

FROM sysadm.code c

WHERE	c.id_typ_code 	= '-PO'
AND		c.id_code		<> -1

ORDER BY c.id_code


GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE  PROC sysadm.DD_S01_PRODUIT_RELANCE
AS

SELECT	p.id_prod,
		p.lib_long
FROM	sysadm.produit p
WHERE	( p.alt_rl1 = 'O' OR p.alt_rl2 = 'O' )
AND		p.id_grp = 254 -- contractant produit orange
ORDER BY p.lib_long



GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROC sysadm.DW_S01_COURRIER_RELANCE
	@produit	as varchar(5),
	@typeRelance	as varchar(1)
AS

SELECT DISTINCT id_cour 
FROM	cour_prod 
WHERE	id_prod = @produit
AND	id_cour like '_LAX_' + @typeRelance


GO

create procedure sysadm.DW_S01_EXIST_SINISTRE(
	@sIdProd	varchar(7),
	@sIdRev		varchar(3),
	@sIdGti		varchar(7)
)
AS 
BEGIN
	Declare @iCount integer
	Declare @sAltExistSinistre char(1)
	
	Select 	@iCount = count(*)
	from	sysadm.w_sin ws
	Where	ws.id_prod = cast(@sIdProd as Decimal(7,0) )
		and ( 	ws.id_rev = cast(@sIdRev as Decimal(7,0) )
			or
			@sIdRev = '-1' )
		and
		( Exists (select wgs.id_sin
			from	sysadm.w_gar_sin wgs
			where 	wgs.id_sin = ws.id_sin
			and  	wgs.id_gti = cast(@sIdGti as Decimal(7,0) ) ) 
		  Or @sIdGti = '-1'
		)
	
	IF @iCount = 0
	BEGIN
		Select 	@iCount = count(*)
		from	sysadm.sinistre s
		Where	s.id_prod = cast(@sIdProd as Decimal(7,0) )
			and ( 	s.id_rev = cast(@sIdRev as Decimal(7,0) )
				or
				@sIdRev = '-1' )
			and
			( Exists (select gs.id_sin
				from	sysadm.gar_sin gs
				where 	gs.id_sin = s.id_sin
				and  	gs.id_gti = cast(@sIdGti as Decimal(7,0) ) ) 
			  Or @sIdGti = '-1'
			)
	END

	IF @iCount > 0 
		Set @sAltExistSinistre = 'O'
	ELSE
		Set @sAltExistSinistre = 'N'

	Select @sAltExistSinistre as alt_exist_sinistre

END

GO


-- JFF      12/05/2020   [PI085]
CREATE PROC sysadm.DW_S01_FLUX_ERISA_SIM2
@dtDeb		DateTime,
@dtFin   	DateTime		

AS

SELECT DISTINCT
       Case 
         WHEN sinistre.id_prod in ( 1500, 1502, 1503, 1504, 1505 ) THEN '30077'
         WHEN sinistre.id_prod in ( 11500, 11501 )                 THEN '30368'
         ELSE '00000'
       END                                                                                 AS 'CODE_BANQUE',

       -- Substring ( Right ( '0000' + Convert ( Varchar (5), sinistre.id_prod), 5), 1 , 3 )  AS 'ID_PROD', --  [PI085]
	   Substring ( Right ( '00000' + Convert ( Varchar (5), produit.cod_prod_dms), 5), 1 , 5 )  AS 'ID_PROD', --  [PI085]
	   produit.cod_prod_dms                                                                AS 'ID_PROD', -- [PI085]
       sinistre.id_ets                                                                     AS 'ID_ETS',
       sinistre.id_adh                                                                     AS 'ID_ADH',
       sinistre.id_sdos                                                                    AS 'ID_SDOS',

       sinistre.id_sin                                                                     AS 'ID_SIN',

       sinistre.dte_surv                                                                   AS 'DTE_SURV',
       sinistre.dte_decl                                                                   AS 'DTE_DECL',
       
       CONVERT ( Datetime, null )                                                          AS 'DTE_ADH',

       Case gar_sin.id_gti
         WHEN 1   THEN 'CL'
         WHEN 2   THEN 'ES'
         WHEN 4   THEN 'SA'
         WHEN 5   THEN 'PA'
         WHEN 6   THEN 'TF'         
         WHEN 7   THEN 'CA'
         WHEN 8   THEN 'UM'
         ELSE '  '
       END                                                                                 AS 'CODE_SECUR',

       CASE 
         WHEN sinistre.id_natsin = 0               THEN 'NP'
         WHEN sinistre.id_natsin = 1               THEN 'DE'
         WHEN sinistre.id_natsin in ( 11, 12 )     THEN 'PE'
         WHEN sinistre.id_natsin in ( 21, 22, 23)  THEN 'VO'
       END                                                                                 AS 'TYPE_SINISTRE',

       CONVERT ( decimal(11,2), null )                                                     AS 'MT_DECLARE',
       reg_gti.mt_reg                                                                      AS 'MT_REG',
       CONVERT ( decimal(11,2), null )                                                     AS 'MT_PROV',

       CASE reglement.id_reg
         WHEN 1 THEN 'PR'
         ELSE        'CO'
       END                                                                                 AS 'TYPE_REGLEMENT',

       reglement.dte_reg                                                                   AS 'DTE_REG',

       CASE gar_sin.cod_etat
         WHEN 100   THEN 'API'
         WHEN 200   THEN 'REF'
         WHEN 550   THEN 'ECR'
         WHEN 600   THEN 'REG'
         WHEN 900   THEN 'SSU'
         ELSE '   '
       END                                                                                 AS 'ETAT_GARANTIE',

       CASE sinistre.cod_etat
         WHEN 100   THEN 'API'
         WHEN 200   THEN 'REF'
         WHEN 550   THEN 'ECR'
         WHEN 600   THEN 'REG'
         WHEN 900   THEN 'SSU'
         ELSE '   '
       END                                                                                 AS 'ETAT_SINISTRE',

       gar_sin.maj_le                                                                      AS 'MAJ_LE',
       Case 
         WHEN sinistre.id_prod in ( 1500, 1502, 1503, 1504, 1505 ) THEN '30077'
         WHEN sinistre.id_prod in ( 11500, 11501 )                 THEN '30368'
         ELSE '00000'
       END                                                                                 AS 'CODE_APPORTEUR', -- JFF le 04/07/2006
       Case 
         WHEN sinistre.id_prod = 1500 THEN '015'
         WHEN sinistre.id_prod = 1502 THEN '016'
	 WHEN sinistre.id_prod = 1503 THEN '017'
         WHEN sinistre.id_prod = 1504 THEN '018'
	 WHEN sinistre.id_prod = 1505 THEN '014'
        WHEN sinistre.id_prod in ( 11500,  11501 )  THEN 'XAA'
         ELSE '000'
       END                                                                                 AS 'CODE_PROD_HSBC' -- JFF le 04/07/2006
	   
  FROM sysadm.sinistre  INNER JOIN sysadm.reglement  ON reglement.id_sin    = sinistre.id_sin

                        INNER JOIN sysadm.reg_gti    ON reg_gti.id_sin      = sinistre.id_sin    AND
                                                        reg_gti.id_reg      = reglement.id_reg

                        INNER JOIN sysadm.gar_sin    ON gar_sin.id_sin      = sinistre.id_sin    AND
                                                        gar_sin.id_gti      = 
										/* JFF le 28/02/2006 suite Bug Plj ramené par Valérie Vincent DFC */				
										(IsNull ( ( Select NullIf ( NullIf ( max ( a_reg_gti.id_gti ), 0), -1 )
											   From   sysadm.reg_gti a_reg_gti
											   Where  a_reg_gti.id_sin = reg_gti.id_sin
											   And    a_reg_gti.id_reg = reg_gti.id_reg ), 

											 ( Select max ( gar_sin.id_gti ) 
											   From   sysadm.gar_sin
											   Where  gar_sin.id_sin = sinistre.id_sin )))

                        INNER JOIN sysadm.garantie   ON garantie.id_prod    = sinistre.id_prod   AND
                                                        garantie.id_rev     = sinistre.id_rev    AND
                                                        garantie.id_gti     = gar_sin.id_gti

                        INNER JOIN sysadm.police     ON garantie.id_police  = police.id_police   
						INNER JOIN sysadm.produit    ON produit.id_prod     = sinistre.id_sin -- [PI085]
                 
 WHERE reglement.dte_reg between @dtDeb AND @dtFin                                 AND
       police.id_cie = 56   

GO


CREATE PROC sysadm.DW_S01_POLE_PRODUIT
		@iPole  	integer,
		@iTypeRel	integer
AS

SELECT	p.id_prod,
		p.id_dept,
		p.id_grp,
		p.lib_court,
		p.lib_long,
		p.cod_rev_surv,
		p.cod_rev_sous,
		p.cod_rev_rnv,
		p.cod_niv_ope,
		p.dur_perrnv_adh,
		p.unt_perrnv_adh,
		p.cod_mode_reg,
		p.lib_bq_debit,
		p.rib_bq,
		p.rib_gui,
		p.rib_cpt,
		p.rib_cle,
		p.cod_dest_reg,
		p.cod_adh,
		p.id_corb,
		p.id_police,
		p.num_tel,
		p.num_fax,
		p.id_depts,
		p.cree_le,
		p.maj_le,
		p.maj_par,
		p.cod_base_dms,
		p.cod_adr_dms,
		p.cod_prod_dms,
		p.alt_crebq_dms,
		p.nb_adherent,
		p.cod_euro,
		p.alt_info_prov,
		p.alt_rl1,
		p.dur_rl1_min,
		p.dur_rl1_max,
		p.unt_rl1,
		p.alt_rl2,
		p.dur_rl2,
		p.unt_rl2,
		p.alt_sold,
		p.dur_sold_rl,
		p.unt_sold_rl,
		p.dur_sold_pc,
		p.unt_sold_pc,
		p.alt_contact,
		p.cod_tel,
		p.alt_ouvfenval,
		p.alt_cmd_mobile,
		p.id_prod_client,
		p.alt_cod_boutique,
		g.id_grp_base

FROM 	sysadm.det_pro dp

INNER JOIN sysadm.produit p
	ON p.id_prod = dp.id_prod
	AND p.alt_rl1 LIKE
			CASE @iTypeRel WHEN 1 THEN 'O'
						ELSE '_'
			END
	ANd p.alt_rl2 LIKE
			CASE @iTypeRel WHEN 2 THEN 'O'
						ELSE '_'
			END

INNER JOIN	sysadm.groupe g
	ON p.id_grp = g.id_grp
	
WHERE	dp.id_typ_code_dp = '-DP'
AND		dp.id_code_dp     = 99
AND		dp.id_typ_calc    = '-PO'
AND		dp.id_code_num    = @iPole


GO


CREATE PROCEDURE sysadm.DW_S01_RELANCE_NORMALE
	@dcIdProd	Decimal (7,0),
	@dtDateMin	Datetime,
	@dtDateMax	DateTime
AS

SELECT	ID_SIN			= sin.id_sin,
		ID_REV			= sin.id_rev,
		ID_ORDRE		= sin.id_ordre,
		COD_INTER		= int.cod_inter,
		NOM_INTER		= int.nom,
		ID_COUR			= IsNull ( arch.id_cour_orig, arch.id_cour ),
		ID_I			= arch.id_inter,
		ID_DOC			= arch.id_doc,
		VALIDE_PAR		= arch.valide_par,
		VALIDE_LE		= arch.valide_le,
		TXT_COMPO		= arch.txt_compo1,
		ALT_PART		= arch.alt_part,
		ALT_PCE			= arch.alt_pce,
		ALT_PS			= arch.alt_ps,
		INT_CIVIL		= int.cod_civ,
		INT_ADR1		= int.adr_1,
		INT_ADR2		= int.adr_2,
		INT_ADR_CP		= int.adr_cp,
		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1		= int.v_ref1,
		INT_VREF2		= int.v_ref2,
		INT_RIB_BQ		= int.rib_bq,
		INT_RIB_CLE		= int.rib_cle,
		INT_RIB_CPT		= int.rib_cpt,
		INT_RIB_GUI		= int.rib_gui,
		PERS_CIVIL		= pers.cod_civ,
		PERS_NOM		= pers.nom,
		PERS_PRENOM		= pers.prenom,
		DTE_EDIT		= arch.dte_edit,
		INTASS_RIB_BQ	= int.rib_bq,
		INTASS_RIB_CLE	= int.rib_cle,
		INTASS_RIB_CPT	= int.rib_cpt,
		INTASS_RIB_GUI	= int.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD			= prod.id_prod,
		PROD_COURT		= prod.lib_court,
		PROD_LONG		= prod.lib_long,
		PROD_FAX		= prod.num_fax,
		PROD_TEL		= prod.num_tel,
		DTE_ADH			= sin.dte_adh,
		DTE_SURV		= sin.dte_surv,
		ID_ADH			= sin.id_adh,
		ID_ETS			= sin.id_ets,
		LIB_GRP			= grp.lib_grp

FROM 	sysadm.sinistre		sin,
		sysadm.archive		arch,
		sysadm.inter		int,
		sysadm.personne 	pers,
		sysadm.produit		prod,
		sysadm.groupe		grp,
		sysadm.etablissement	eta,
		sysadm.routage		rout

WHERE	sin.id_prod		= @dcIdProd
AND		rout.id_sin		= sin.id_sin
AND		rout.alt_queue	= 'N'
AND		sin.id_sin		= arch.id_sin
AND		sin.cod_etat	in ( 100, 550 )
AND		sin.valide_le	= arch.valide_le

-- il faut que ce ne soit pas un courrier particluier
AND		arch.id_cour	<>	'APART1'

-- courrier de demande de pièce
AND	Substring ( arch.id_cour_orig, 4, 1 ) = 'P'

-- pas un courrier comportant un refus
AND	Substring ( arch.id_cour_orig, 5, 1 ) <> 'R'

AND	(	
		CharIndex ( 'P001', arch.txt_compo1, 1 ) = 0
		AND CharIndex ( 'P118', arch.txt_compo1, 1 ) = 0
		AND CharIndex ( 'P119', arch.txt_compo1, 1 ) = 0
		AND CharIndex ( 'P037', arch.txt_compo1, 1 ) = 0
		AND CharIndex ( 'P107', arch.txt_compo1, 1 ) = 0
		AND CharIndex ( 'P120', arch.txt_compo1, 1 ) = 0
	)

AND	arch.valide_le		between @dtDateMin and @dtDateMax
AND	arch.cod_version	= 2
AND	arch.nbr_conf		= 0
AND	arch.id_sin			= int.id_sin
AND	arch.id_inter		= int.id_i
AND int.cod_inter		= 'A'
AND	pers.id_ordre		= sin.id_ordre
AND	prod.id_prod		= sin.id_prod
AND	eta.id_prod			= sin.id_prod
AND	eta.id_ets			= sin.id_ets
AND	eta.id_grp			= grp.id_grp
AND	eta.id_rev			= -1


GO

CREATE procedure sysadm.DW_S01_RELANCE_PARTICULIERE
	@dcIdProd	Decimal (7,0),
	@dtDateMin	Datetime,
	@dtDateMax	DateTime
AS

SELECT	cast(null as integer),
		ID_SIN			= sin.id_sin,
		ID_REV			= sin.id_rev,
		ID_ORDRE		= sin.id_ordre,
		COD_INTER		= int.cod_inter,
		NOM_INTER		= int.nom,
		ID_COUR			= IsNull ( arch.id_cour_orig, arch.id_cour ),
		ID_I			= arch.id_inter,
		ID_DOC			= arch.id_doc,
		VALIDE_PAR		= arch.valide_par,
		VALIDE_LE		= arch.valide_le,
		TXT_COMPO		= arch.txt_compo1,
		ALT_PART		= arch.alt_part,
		ALT_PCE			= arch.alt_pce,
		ALT_PS			= arch.alt_ps,
		INT_CIVIL		= int.cod_civ,
		INT_ADR1		= int.adr_1,
		INT_ADR2		= int.adr_2,
		INT_ADR_CP		= int.adr_cp,
		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1		= int.v_ref1,
		INT_VREF2		= int.v_ref2,
		INT_RIB_BQ		= int.rib_bq,
		INT_RIB_CLE		= int.rib_cle,
		INT_RIB_CPT		= int.rib_cpt,
		INT_RIB_GUI		= int.rib_gui,
		PERS_CIVIL		= pers.cod_civ,
		PERS_NOM		= pers.nom,
		PERS_PRENOM		= pers.prenom,
		DTE_EDIT		= arch.dte_edit,
		INTASS_RIB_BQ	= int.rib_bq,
		INTASS_RIB_CLE	= int.rib_cle,
		INTASS_RIB_CPT	= int.rib_cpt,
		INTASS_RIB_GUI	= int.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD			= prod.id_prod,
		PROD_COURT		= prod.lib_court,
		PROD_LONG		= prod.lib_long,
		PROD_FAX		= prod.num_fax,
		PROD_TEL		= prod.num_tel,
		DTE_ADH			= sin.dte_adh,
		DTE_SURV		= sin.dte_surv,
		ID_ADH			= sin.id_adh,
		ID_ETS			= sin.id_ets,
		LIB_GRP			= grp.lib_grp

FROM	sysadm.sinistre			sin,
		sysadm.archive			arch,
		sysadm.inter			int,
		sysadm.personne 		pers,
		sysadm.produit			prod,
		sysadm.groupe			grp,
		sysadm.etablissement	eta,
		sysadm.routage			rout

WHERE	sin.id_prod		= @dcIdProd
AND		rout.id_sin		= sin.id_sin
AND		rout.alt_queue	= 'N'
AND		sin.id_sin		= arch.id_sin
AND		sin.cod_etat	in ( 100, 550 )
AND		arch.valide_le	= sin.valide_le

-- il faut que ce soit un courrier particluier
AND		arch.id_cour	=	'APART1'

-- que le courrier soit une demande de pièces ou un questionnaire
AND		Substring ( arch.id_cour_orig, 4, 1 ) = 'P'

-- que ce ne soit pas un refus
AND		Substring ( arch.id_cour_orig, 5, 1 ) <> 'R'

-- que ce ne soit pas un courrier de relance
AND (
		Substring ( arch.id_cour, 2, 4 ) <> 'LAX0'
		AND arch.id_cour <> 'ALQ001'
	)

AND	arch.valide_le BETWEEN @dtDateMin AND @dtDateMax

-- le dernier courrier en cours
AND	arch.id_doc = (
			SELECT max (id_doc)
			FROM   sysadm.archive arch2
			WHERE  arch2.id_sin   = arch.id_sin
			AND    arch2.id_inter = arch.id_inter
		)

AND	arch.cod_version	= 2
AND	arch.nbr_conf		= 0
AND	arch.id_sin			= int.id_sin
AND	arch.id_inter		= int.id_i
AND int.cod_inter		= 'A'
AND pers.id_ordre		= sin.id_ordre
AND	prod.id_prod		= sin.id_prod
AND	eta.id_prod   		= sin.id_prod
AND	eta.id_ets  		= sin.id_ets
AND	eta.id_grp  		= grp.id_grp
AND	eta.id_rev    		= -1


GO



CREATE procedure sysadm.DW_S01_SECONDE_RELANCE
      @dcIdProd       Decimal (7,0),
      @dtDateMax      Datetime
AS

SELECT	ID_SIN 		= sin.id_sin,
		ID_REV		= sin.id_rev,
		ID_ORDRE	= sin.id_ordre,
		COD_INTER	= int.cod_inter,
		NOM_INTER	= int.nom,		
		ID_COUR		= IsNull ( arch.id_cour_orig, arch.id_cour ),
		ID_I		= arch.id_inter,
		ID_DOC		= arch.id_doc,
		VALIDE_PAR	= arch.valide_par,
		VALIDE_LE	= arch.valide_le,
		TXT_COMPO	= arch.txt_compo1,
		ALT_PART	= arch.alt_part,
		ALT_PCE		= arch.alt_pce,
		ALT_PS		= arch.alt_ps,
		INT_CIVIL	= int.cod_civ,       
		INT_ADR1	= int.adr_1,
		INT_ADR2	= int.adr_2,
		INT_ADR_CP	= int.adr_cp,
		INT_ADR_VILLE	= int.adr_ville,
		INT_VREF1	= int.v_ref1,
		INT_VREF2	= int.v_ref2,
		INT_RIB_BQ	= int.rib_bq,
		INT_RIB_CLE	= int.rib_cle,
		INT_RIB_CPT	= int.rib_cpt,
		INT_RIB_GUI	= int.rib_gui,
		PERS_CIVIL	= pers.cod_civ,
		PERS_NOM	= pers.nom,
		PERS_PRENOM	= pers.prenom,
		DTE_EDIT	= arch.dte_edit,
		INTASS_RIB_BQ	= int.rib_bq,
		INTASS_RIB_CLE	= int.rib_cle,
		INTASS_RIB_CPT	= int.rib_cpt,
		INTASS_RIB_GUI	= int.rib_gui,
		PROD_ID_DEPTS	= prod.id_depts,
		PROD_ID_DEPT	= prod.id_dept,
		ID_PROD		= prod.id_prod,
		PROD_COURT	= prod.lib_court,
		PROD_LONG	= prod.lib_long,
		PROD_FAX	= prod.num_fax,
		PROD_TEL	= prod.num_tel,
		DTE_ADH		= sin.dte_adh,
		DTE_SURV	= sin.dte_surv,
		ID_ADH		= sin.id_adh,
		ID_ETS		= sin.id_ets,
		LIB_GRP		= grp.lib_grp


FROM 	sysadm.sinistre 		sin,
		sysadm.archive  		arch,
		sysadm.inter			int,
		sysadm.personne 		pers,
		sysadm.produit			prod,
		sysadm.groupe			grp,
		sysadm.etablissement	eta,
		sysadm.routage			rout

WHERE	sin.id_prod   	= @dcIdProd
AND     rout.id_sin		= sin.id_sin
AND     rout.alt_queue	= 'N'
AND		sin.id_sin 		= arch.id_sin
AND    	sin.cod_etat    in ( 100, 550 )
AND    	sin.valide_le 	= arch.valide_le

AND     Substring ( arch.id_cour, 2, 5 ) = 'LAX01'

AND     arch.maj_le			<= @dtDateMax
AND     arch.cod_version  	= 2
AND     arch.nbr_conf       = 0
AND     arch.id_sin         = int.id_sin
AND     arch.id_inter       = int.id_i
AND 	int.cod_inter		= 'A'
AND 	pers.id_ordre		= sin.id_ordre
AND		prod.id_prod		= sin.id_prod
AND		eta.id_prod   		= sin.id_prod
AND		eta.id_ets  		= sin.id_ets
AND		eta.id_grp  		= grp.id_grp
AND		eta.id_rev    		= -1


GO






/****** Objet : procédure stockée sysadm.DW_S01_STOCK_ERISA_SIM2    Date du script : 08/06/2009 10:23:37 ******/

-- JFF      12/05/2020   [PI085]
CREATE  PROC sysadm.DW_S01_STOCK_ERISA_SIM2
AS

SELECT  
       CASE 
         WHEN sinistre.id_prod in ( 1500, 1502, 1503, 1504, 1505 ) THEN '30077'
         WHEN sinistre.id_prod in ( 11500, 11501 )                 THEN '30368'
         ELSE '00000'
       END                                                                                AS 'CODE_BANQUE',

--       Substring ( Right ( '0000' + Convert ( Varchar (5), sinistre.id_prod), 5), 1 , 3 ) AS 'ID_PROD', --  [PI085]
	   Substring ( Right ( '00000' + Convert ( Varchar (5), produit.cod_prod_dms), 5), 1 , 5 )  AS 'ID_PROD', --  [PI085]
       sinistre.id_ets                                                                    AS 'ID_ETS',
       sinistre.id_adh                                                                    AS 'ID_ADH',
       sinistre.id_sdos                                                                   AS 'ID_SDOS',

       sinistre.id_sin                                                                    AS 'ID_SIN',
       personne.nom                                                                       AS 'NOM_ASSURE',
       personne.prenom                                                                    AS 'NOM_PRENOM',
       CONVERT ( datetime, null )                                                         AS 'DTE_NAIS',

       produit.lib_court                                                                  AS 'LIB_PROD',
       CONVERT (Varchar(35), null )                                                       AS 'NOM_BANQUE',

       sinistre.dte_surv                                                                  AS 'DTE_SURV',
       sinistre.dte_decl                                                                  AS 'DTE_DECL',

       CONVERT ( Char (2) , null )                                                        AS 'CODE_SECUR',

       CONVERT ( decimal(11,2), null )                                                    AS 'MT_DECLARE',

       SUM ( gar_sin.mt_plaf_reg )                                                        AS 'MT_REG_CUM',

       CONVERT ( decimal(11,2), null )                                                    AS 'MT_PROV',

       CASE sinistre.cod_etat
         WHEN 100   THEN 'API'
         WHEN 200   THEN 'REF'
         WHEN 550   THEN 'ECR'
         WHEN 600   THEN 'REG'
         WHEN 900   THEN 'SSU'
         ELSE '   '
       END                                                                                AS 'ETAT_SINISTRE',

       sinistre.maj_le                                                                    AS 'MAJ_LE',
       Case 
         WHEN sinistre.id_prod in ( 1500, 1502, 1503, 1504, 1505 ) THEN '30077'
         WHEN sinistre.id_prod in ( 11500, 11501 )                 THEN '30368'
         ELSE '00000'
       END                                                                                AS 'CODE_APPORTEUR', -- JFF le 04/07/2006
       Case 
         WHEN sinistre.id_prod = 1500 THEN '015'
         WHEN sinistre.id_prod = 1502 THEN '016'
         WHEN sinistre.id_prod = 1503 THEN '017'
         WHEN sinistre.id_prod = 1504 THEN '018'
         WHEN sinistre.id_prod = 1505 THEN '014'
         WHEN sinistre.id_prod in ( 11500,  11501 )  THEN 'XAA'
         ELSE '000'
       END                                                                                AS 'CODE_PROD_HSBC' -- JFF le 04/07/2006	   

  FROM sysadm.sinistre  INNER JOIN sysadm.gar_sin    ON gar_sin.id_sin      = sinistre.id_sin 

                        INNER JOIN sysadm.produit    ON produit.id_prod     = sinistre.id_prod

                        INNER JOIN sysadm.garantie   ON garantie.id_prod    = sinistre.id_prod  AND
                                                        garantie.id_rev     = sinistre.id_rev   AND
                                                        garantie.id_gti     = gar_sin.id_gti

                        INNER JOIN sysadm.police  ON garantie.id_police  = police.id_police

                        INNER JOIN sysadm.personne   ON personne.id_ordre   = sinistre.id_ordre
                 
 WHERE police.id_cie = 56

GROUP  BY  Case 
             WHEN sinistre.id_prod in ( 1500, 1502, 1503, 1504, 1505 ) THEN '30077'
             WHEN sinistre.id_prod in ( 11500, 11501 )                 THEN '30368'
             ELSE '00000'
           END,

           -- Substring ( Right ( '0000' + Convert ( Varchar (5), sinistre.id_prod), 5), 1 , 3 ), --  [PI085]
		   Substring ( Right ( '00000' + Convert ( Varchar (5), produit.cod_prod_dms), 5), 1 , 5 ),  --  [PI085]
           sinistre.id_ets,
           sinistre.id_adh,
           sinistre.id_sdos,

           sinistre.id_sin,
           personne.nom,
           personne.prenom,
           produit.lib_court,

           sinistre.dte_surv,
           sinistre.dte_decl,

           CASE sinistre.cod_etat
             WHEN 100   THEN 'API'
             WHEN 200   THEN 'REF'
             WHEN 550   THEN 'ECR'
             WHEN 600   THEN 'REG'
             WHEN 900   THEN 'SSU'
             ELSE '   '
           END,

           sinistre.maj_le,

	  Case 
	    WHEN sinistre.id_prod in ( 1500, 1502, 1503, 1504, 1505 ) THEN '30077'
	    WHEN sinistre.id_prod in ( 11500, 11501 )                 THEN '30368'
	    ELSE '00000'
	  END,

          Case 
            WHEN sinistre.id_prod = 1500 THEN '015'
            WHEN sinistre.id_prod = 1502 THEN '016'
            WHEN sinistre.id_prod = 1503 THEN '017'
            WHEN sinistre.id_prod = 1504 THEN '018'
            WHEN sinistre.id_prod = 1505 THEN '014'
            WHEN sinistre.id_prod in ( 11500,  11501 )  THEN 'XAA'
            ELSE '000'
          END


order by sinistre.id_sin

Go


CREATE procedure sysadm.DW_S01_W_RAPPEL_CLIENT
	@sCas	VarChar ( 20 ),
	@iIdSeqDeb	Integer,
	@iIdSeqFin	Integer
	
AS

Select 
	id_seq,
	id_type,
	id_sin,
	id_seq_prs,
	id_gti,
	lib_gti,
	id_marq_art,
	id_modl_art,
	nom,
	adr_tel1,
	adr_tel2,
	adr_tel3,
	id_cmd_frn,
	delai,
	comment_frn,
	dte_rdv_cli,
	dte_elv_mobile,
	dte_emis_devis,
	mt_devis,
	alt_dev_acp,
	dte_dev_acp,
	id_res_appel,
	dte_reception_port,
	dte_reception_devis,
	txt_commentaire,
	id_cli,
	id_contact,
	cod_pos,
	cree_le,
	maj_le,
	maj_par,
	id_prod,
	nom_fic
From 	sysadm.w_rappel_client
Where   ( @sCas = 'GEN_FICHIER' And cod_pos = 0 )
Or	( @sCas = 'INT_FICHIER' And cod_pos = 1 
	And id_seq between @iIdSeqDeb And @iIdSeqFin )


GO

-- JFF      12/02/2016   [PI062]
CREATE procedure sysadm.PS_ARCHIVER
	@idsin		varchar(10),  -- [PI062]
	@oper		varchar(4),
	@noboite	varchar(7)
AS

DECLARE @ret integer
SET @ret = 0 

DELETE	sysadm.wkfs_w_queue
WHERE	id_sin = @idsin

UPDATE sysadm.sin_tel
SET 	maj_le		=	getdate(),
	maj_par		=	@oper,
	no_boite	=	@noboite
WHERE	id_sin		=	@idsin

RETURN @ret

GO


/****** Objet : procédure stockée sysadm.PS_EXECUTE_SQL_CMDE    Date du script : 10/12/2009 10:31:36 ******/

CREATE  PROCEDURE [sysadm].[PS_EXECUTE_SQL_CMDE] 
@sCmde varchar(1000)
AS
--------------------------------------------------------------------
--
-- Procédure            :       PS_EXECUTE_SQL_CMDE
-- Auteur               :       PHG, d'après Source Wyniwig
-- Date                 :       12/05/2009
-- Libellé              :        
-- Commentaires         :       Gestion de la propriété SQLNRows en PB 11.5 avec
--				le Client SQL SNC V9 pour les ordres SQL exécutés avec
--				EXECUTE IMMEDIATE au sein de PB.
--				En effet, La propriété SQLCA.SQLNRows n'est pas
--				mise à jours après EXECUTE IMMEDIATE en Client SNC V9.
--				Le "return @@rowcount" permet de la mettre à jour.
--				Du coup, redirection de l'execution de l'ordre SQL
--				au niveau du serveur, et non directement dans PB.
--
-- Références           :       [MIGPB115.LOT1], f_execute()
--
-- Arguments            :	@SQLString	NVARCHAR(500)			(Val)

--
-- Retourne             :       Le nombre de ligne affectée.
--
-------------------------------------------------------------------
-- MAJ	PAR	LE		Description
-- #1	PHG	10/12/2009	Augmentation à 1000 de la chaine SQL passable
--				pour execution.

begin
	DECLARE @SQLString NVARCHAR(1000) -- #1
	
	set @SQLString= N'' + @sCmde
	execute sp_executesql @SQLString
	return @@rowcount
end


GO


CREATE PROC sysadm.PS_I01_TRACE_RECAP_RELANCE
	@oper			varchar(4),
	@typTrt			varchar(4),
	@dtDate			datetime,
	@nbATraiter		integer
AS

DECLARE @idTrtRelance	integer

EXECUTE sysadm.PS_X_INCREMENTER 'ID_RELANCE', @idTrtRelance OUTPUT

INSERT sysadm.trace_recap_relance
VALUES	(	@idTrtRelance, 
			@oper, 
			@typTrt, 
			@dtDate, 
			@nbATraiter,
			null
		)

RETURN @idTrtRelance


GO

-- JFF      12/02/2016   [PI062]
CREATE PROC sysadm.PS_I01_TRACE_RELANCE
	@idTrt		integer,
	@idSin		decimal(10),  -- [PI062]
	@idInter	decimal(7),
	@idDocOri	decimal(7),
	@iddDocRel	decimal(7),
	@message	varchar(255)

AS

INSERT 	sysadm.trace_relance
VALUES	(	@idTrt, 
			@idSin, 
			@idInter, 
			@idDocOri, 
			@iddDocRel, 
			@message
		)
GO


CREATE PROCEDURE        sysadm.PS_LECTURE_MAIL_SIMPA2_V00
AS

SELECT  warc.id_arch,
        warc.id_sin,
        warc.id_inter,
        inte.cod_inter,
        sini.id_prod, 
        REPLACE ( pro.lib_court, '\', ' ' ),
        warc.cree_le

FROM    w_cour_blob_arch        AS      warc
INNER JOIN
        sinistre                AS      sini
ON      warc.id_sin = sini.id_sin

INNER JOIN      
        produit                 AS      pro
ON      sini.id_prod = pro.id_prod


INNER JOIN      
        inter                   AS      inte
ON      warc.id_sin     = inte.id_sin           AND
        warc.id_inter   = inte.id_i

WHERE   warc.dte_edit IS NULL   AND
        warc.id_lot = 0


GO





CREATE  PRocedure PS_PATCH_SUPEDITIONINVALIDE_SELECT
as
	Print 'Présence -1 ?'
        select  * from  w_cour_blob_arch where id_lot = -1

	Print 'Edité et blob absent de archive_blob'
	select * from archive a, w_cour_blob_arch wcb
	where a.valide_le > '15/11/2006' 
	and not exists 
		( select * 
		  from   archive_blob ab
		  where ab.id_sin = a.id_sin
		  and   ab.id_inter  = a.id_inter
		  and   ab.id_doc = a.id_doc )
	and wcb.id_arch = a.id_arch
	and wcb.id_lot > 0


	Print 'Absence archive'
	Select  *
	From   w_cour_blob_arch wcb,
		sinistre s,
		inter i
	Where   not exists ( 
			Select *
			From archive a
			where a.id_arch = wcb.id_arch ) 
	And     wcb.valide_le > '15/11/2006 06:00' 
	And     wcb.id_lot = 0
	and     s.id_sin = wcb.id_sin
	and     i.id_sin = wcb.id_sin
	and     i.id_i   = wcb.id_inter



GO


CREATE PROC sysadm.PS_U01_TRACE_RECAP_RELANCE
	@idTrt		integer,
	@iNbTraite	integer
AS

UPDATE	sysadm.trace_recap_relance
SET		dossiers_traites = @iNbTraite
WHERE	id_trt	= @idTrt


GO

-- JFF      12/02/2016   [PI062]
CREATE procedure PS_V01_REF_ASSUREUR
   @dcIdSin  Dec(10,0),  -- [PI062]  -- N° De sinistre à tester
   @dDteSurv datetime ,         -- Date de survenance
   @sMsg     Varchar(35) Output -- Message d'erreur / Ok
AS

Declare @iOk Integer
Declare @iNb Integer
Declare @iAn Integer

Set @iNb = 0
Set @iOk = 0
Set @sMsg = 'KO'

If  @@servername = master.dbo.SPB_FN_ServerName ('PRO')
Begin -- Début vérification sur le serveur de production

-- (1) L'indentifiant est-il référencé ?

	Select @iNb = count(*) From SESAME_PRO.sysadm.ref_assureur Where id_sin = @dcIdSin And id_appli = 2
	
	If @iNb = 0 Set @iOk = 1
	
-- (2) Oui : Y a t-il une référence pour une autre année de survenance ?

	If @iNb > 0
		Begin 

			Select @iNb = count(*), 
					 @iAn = Max( an_surv ) from SESAME_PRO.sysadm.ref_assureur Where id_sin = @dcIdSin And id_appli = 2 And an_surv <> Datepart( year, @dDteSurv )
			
			If @iNb = 0
 				 Set @iOk = 1
		End

-- (3) Interprétation des résultats

	If @iNb = 0
      Begin
			Set @iOk  = 1
			Set @sMsg = 'OK'
      End
	Else
		Begin
			Set @iOk = 0
			Set @sMsg = 'Référence AIG attribuée sur ' + Convert ( varchar(4), @iAn )
		End

End   -- Fin   vérification sur le serveur de production

-- #1
Else
Begin
			Set @iOk  = 1
			Set @sMsg = 'OK'
End 
-- :#1

Return @iOk

GO


CREATE PROCEDURE [sysadm].[PS_VERIF_IBAN]
	@asIban               VarChar	(38),
	@asAction	      Char	(1)
AS
--------------------------------------------------------------------
--
-- Procédure            :       PS_VERIF_IBAN
-- Auteur               :       PHG, d'après Source Wyniwig
-- Date                 :       12/05/2009
-- Libellé              :        
-- Commentaires         :       Appel de la fonction SPB_FN_IBAN située sur SESAME_PRO
--				L'appel originel en PB pur via RPC de SPB_FN_IBAN
--				ne fonctionnait plus avec le Client SNC V9.
--				=> Redirection faite au niveau de cette PS, et c'est
--				donc PS_VERIF_IBAN qui est appellé en PB.
--
-- Références           :       [MIGPB115.LOT1], n_cst_iban
--
-- Arguments            :	@asIban               VarChar	(38)		(Val)
--                      :       @sIdAg          Varchar (  5 )                  (Val)
--
-- Retourne             :       La Clé Calculée.
--
-------------------------------------------------------------------

BEGIN
Declare @iCle           Integer		-- Clé Iban Calculée

exec @iCle = [SQLSINISTRES\SINISTRES].[SESAME_PRO].[sysadm].[SPB_FN_IBAN] @asIban, @asAction

return @iCle
END


GO


CREATE procedure sysadm.PS_X_LIB
  @sIdTypCode Varchar(5),    -- Type de code
  @iIdCode    Integer = -1,  -- Identifiant code ( min )
  @iIdCodeMax Integer = -1	  -- identifiant code ( max pour lister une portion de codes )
AS

/*-------------------------------------------------*/
/* Selection de tous les groupe : Ordre par id_grp */
/*-------------------------------------------------*/

-- Affectation du code max 

	If @iIdCodeMax = -1 Set @iIdCodeMax = @iIdCode

If @iIdCode = -1
   Begin

     Select id_typ_code, id_code, Rtrim(lib_code) as lib_code,  cree_le, maj_le, maj_par 
       from sysadm.code 
      Where
           id_typ_code = @sIdTypCode  And
           id_code > -1 And
           ( @iIdCode >= 0 And id_code = @iIdCode Or @iIdCode <0 ) 
     Order by
           id_code asc

   End

Else

   Begin

     Select id_typ_code, id_code, rtrim(lib_code) as lib_code,  cree_le, maj_le, maj_par 
       from sysadm.code 
      Where
           id_typ_code = @sIdTypCode  And
           ( @iIdCode >= 0 And id_code Between @iIdCode and @iIdCodeMax Or @iIdCode <0 ) 
     Order by
           id_code asc

   End
GO

/***********************************************************/
/*   FPI - 14/08/2014 Refonte de PS_X_LIB				   */
/*   FPI - 24/07/2015 Ajout de l'aide    				   */
/***********************************************************/
if exists (select * from dbo.sysobjects where id = object_id(N'[sysadm].[PS_X_LIB_V01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	drop procedure [sysadm].[PS_X_LIB_V01]
GO

CREATE procedure sysadm.PS_X_LIB_V01
  @sIdTypCode Varchar(5),    -- Type de code
  @sIdCode    varchar(6)= '-1',  -- Identifiant code ( min )
  @sIdCodeMax varchar(6)='-1' -- identifiant code ( max pour lister une portion de codes )
AS
Declare @iCodeCar integer=1,
	@iCode integer=1
	
-- Aide	
If @sIdTypCode='?'
Begin
	print 'Syntaxe PS_X_LIB_V01'
	print '--------------------'
	print''
	print 'sysadm.PS_X_LIB_V01 <id_typ_code>[option] [,id_code_min] [,id_code_max]'
	print ''
	print 'avec'
	print ''
	print 'id_typ_code : l''id_typ_code ou ''?'' pour l''aide'
	print 'option (facultatif) : +C pour filtrer sur la table "code_car" ; +N sur la table "code"'
	print 'id_code_min (facultatif) : l''id_code minimum de la plage de recherche'
	print 'id_code_max (facultatif) : l''id_code maximum de la plage de recherche'
	print ''
	print 'Exemples :'
	print ''
	print 'exec sysadm.PS_X_LIB_V01 ''?'' => affiche l''aide'
	print 'exec sysadm.PS_X_LIB_V01 ''-FR'' => affiche les codes -FR numériques (franchises) et caractères (fournisseurs)'
	print 'exec sysadm.PS_X_LIB_V01 ''-FR+C'' => affiche uniquement les codes -FR caractères (fournisseurs)'
	print 'exec sysadm.PS_X_LIB_V01 ''-FR+N'' => affiche uniquement les codes -FR numériques (franchises)'
	print 'exec sysadm.PS_X_LIB_V01 ''-IF'',900 => affiche le code -IF avec id_code égal à 900'
	print 'exec sysadm.PS_X_LIB_V01 ''-IF'',900,999 => affiche les codes -IF avec id_code compris entre 900 et 999'
	print 'exec sysadm.PS_X_LIB_V01 ''-FR'',''C'',''D'' => affiche les codes -FR commençant par la lettre C'
	Return
End

-- Affectation du code max 
If @sIdCodeMax = '-1' Set @sIdCodeMax = @sIdCode

-- Décompo du id_typ_code
If @sIdTypCode like '%+[CN]'
Begin
  if @sIdTypCode like '%+C'	Set @iCode=0
  Else Set @iCodeCar=0
  
  Set @sIdTypCode=LEFT(@sIdTypCode,LEN(@sIdTypCode)-2)
  
End

If @sIdCode = '-1'
   Begin

     Select 'code' as origine,
		id_typ_code, Right('      ' + convert(varchar(6),id_code),6) as id_code, 
			Rtrim(lib_code) as lib_code,  cree_le, maj_le, maj_par 
      from sysadm.code 
      Where
			ISNUMERIC(@sIdCode)=1 and
           id_typ_code = @sIdTypCode  And
           id_code > -1 And
           (id_code = CONVERT(decimal(7,0), @sIdCode) Or @sIdCode='-1' ) 
           And @iCode=1
     union
	 Select 'code_car' as origine,
		id_typ_code, rtrim(id_code) as id_code , 
			Rtrim(lib_code) as lib_code,  cree_le, maj_le, maj_par 
      from sysadm.code_car
      Where
		 id_typ_code = @sIdTypCode  And
          id_code <> '-1' And
       (id_code = @sIdCode Or @sIdCode='-1' ) 
        And @iCodeCar=1
     Order by
          origine, id_code asc
	
   End

Else

   Begin

	if ISNUMERIC(@sIdCode)=1 
	Begin
	Select 'code' as origine,
		id_typ_code, Right('      ' + convert(varchar(6),id_code),6) as id_code, 
			Rtrim(lib_code) as lib_code,  cree_le, maj_le, maj_par 
      from sysadm.code 
      Where
			ISNUMERIC(@sIdCode)=1 and
           id_typ_code = @sIdTypCode  And
           id_code > -1 And
           (  id_code between CONVERT(decimal(7,0), @sIdCode)And CONVERT(decimal(7,0), @sIdCodeMax))
            And @iCode=1
     union
	 Select 'code_car' as origine,
		id_typ_code, rtrim(id_code) as id_code , 
			Rtrim(lib_code) as lib_code,  cree_le, maj_le, maj_par 
      from sysadm.code_car
      Where
		 id_typ_code = @sIdTypCode  And
          id_code <> '-1' And
       (id_code Between @sIdCode and @sIdCodeMax) 
        And @iCodeCar=1
     Order by
          origine, id_code asc
   End
   Else
   Begin
	 Select 'code_car' as origine,
		id_typ_code, rtrim(id_code) as id_code , 
			Rtrim(lib_code) as lib_code,  cree_le, maj_le, maj_par 
      from sysadm.code_car
      Where
		 id_typ_code = @sIdTypCode  And
          id_code <> '-1' And
       (id_code Between @sIdCode and @sIdCodeMax) 
        And @iCodeCar=1
     Order by
          origine, id_code asc
   End
End

GO


grant execute on sysadm.PS_X_LIB_V01 to rolebddsinistres
Go

CREATE procedure sysadm.PS_X_SIMPA_AIG
AS

	--> Liste des références à traiter

	If( Select object_id ( 'tempdb.dbo.#liste_sim' ) ) > 0 Exec ('Drop table #liste_sim' )

	Select 'Simpa' as application, g.id_prod, pdt.lib_long, g.id_gti,
	        sysadm.FN_CODE_NUM ( g.id_gti, '-GC' ) as lib_gtie,
	        g.id_rev,  c.id_cie, c.lib_cie, p.id_police, p.lib_police,
           g.id_prefixe

	into #liste_sim

	From 
	    SIMPA2_PRO.sysadm.compagnie c
	     inner join SIMPA2_PRO.sysadm.police   p on p.id_cie    = c.id_cie
	     inner join SIMPA2_PRO.sysadm.garantie g on g.id_police = p.id_police
		  inner join SIMPA2_PRO.sysadm.produit pdt on g.id_prod = pdt.id_prod
	Where
	    c.id_cie in (6,76,75,48 ) 

	Select getdate(), '--> Chargement des références à traiter OK'

   ---------------------------------------------------------------------------------
	Select getdate(), '--> Comptage des dossiers'
   ---------------------------------------------------------------------------------

	Select datepart ( year, sinistre.dte_surv ) as an_surv, count( gar_sin.id_sin ) as nb
    from SIMPA2_PRO.sysadm.sinistre, SIMPA2_PRO.sysadm.gar_sin, #liste_sim
   where
         sinistre.id_sin  = gar_sin.id_sin And
         sinistre.id_prod = #liste_sim.id_prod And
         sinistre.id_rev  = #liste_sim.id_rev  And
         gar_sin.id_gti   = #liste_sim.id_gti  
   group by 
		datepart ( year, sinistre.dte_surv )
	order by 
		an_surv

   ---------------------------------------------------------------------------------
	--> Commande pour le curseur
   ---------------------------------------------------------------------------------

	Set nocount on

	Declare @iAnSurv  Integer
	Declare @iIdSin   Integer
	Declare @iIdProd  Integer
	Declare @iIdRev   Integer
	Declare @iIdGti   Integer
	Declare @sIdPrefixe Varchar(5)
	
	Declare @iAnSurv0 Integer
	Declare @iCpt     Integer
   Declare @iRet     Integer

	-- NEW plus de sélection de la garantie + DISTINCT

	Declare cur Cursor for
	Select distinct
		datepart ( year, s.dte_surv ) as an_surv,
		s.id_sin,
   --  s.id_prod,
   --  s.id_rev,
   --  gar_sin.id_gti,
      #liste_sim.id_prefixe
    from
       SIMPA2_PRO.sysadm.sinistre s , SIMPA2_PRO.sysadm.gar_sin gs, #liste_sim
   where
         s.id_sin  = gs.id_sin And
         s.id_prod = #liste_sim.id_prod And
         s.id_rev  = #liste_sim.id_rev  And
         gs.id_gti   = #liste_sim.id_gti  And
         #liste_sim.id_prefixe is not null And
   not exists
         ( select * 
             from SESAME_PRO.sysadm.ref_assureur v 
            where
               s.id_sin = v.id_sin and
               datepart ( year, s.dte_surv ) = v.an_surv and
               #liste_sim.id_prefixe = v.id_prefixe 
           )

    order by datepart ( year, s.dte_surv ) desc,  #liste_sim.id_prefixe asc, s.id_sin asc

	Open cur

	Fetch cur into @iAnSurv, @iIdSin, @sIdPrefixe

	Set @iAnSurv0 = @iAnSurv
	Set @iCpt = 1

While @@fetch_status <> -1 
	Begin

		-- Gestion changement année de survenance
	
			If @iAnSurv0 <> @iAnSurv
	         Begin
					Select getdate(), 'Année de survenance ' + Convert ( varchar(4), @iAnSurv0 ) + ' : ' + Convert ( varchar(10), @iCpt )
					Set @iAnSurv0 = @iAnSurv
					Set @iCpt = 1
	         End

			-- NEW Insertion de la référence séquentielle + sécurité NOT EXITS

		INSERT INTO SESAME_PRO.sysadm.ref_assureur
			( id_sin, id_appli, an_surv, id_prefixe, cree_le, maj_le, maj_par,  id_seq )
		Select
          @iIdSin, 2       , @iAnSurv, @sIdPrefixe, getdate(), getdate(), 'AUTO', @iCpt 
      Where
			not exists 
					( select * from SESAME_PRO.sysadm.ref_assureur v
                   where
                         v.id_sin     = @iIdSin  And
                         v.id_appli   = 2        And
                         v.an_surv    = @iAnSurv And
                         v.id_prefixe = @sIdPrefixe )

			If @@rowcount = 1  -- Si 1 ligne insérée j'incrémente le compteur
            Begin
					 Set @iCpt = @iCpt + 1
            End
        
		-- Lecture suivant

			Fetch cur into @iAnSurv, @iIdSin, @sIdPrefixe

	End

	Close cur 
	Deallocate cur

	Select getdate(), 'Année de survenance ' + Convert ( varchar(4), @iAnSurv ) + ' : ' + Convert ( varchar(10), @iCpt )

	---------------------------------------------------------------------------------
	Select getdate(), '--> Compte rendu de la numérotation'
   ---------------------------------------------------------------------------------

	select an_surv, max( id_seq )  from ref_assureur group by an_surv order by an_surv


GO




CREATE PROC sysadm.IM_S01_DEPARTEMENT
                          @dcIdDept     decimal ( 7, 0 ),
                          @sLibDept     Varchar ( 35 ) OUTPUT
AS

  SELECT @sLibDept = lib_dept
    FROM sysadm.departement
   WHERE departement.id_dept = @dcIdDept


GO


-- JFF      12/02/2016   [PI062]
CREATE PROC sysadm.PS_I02_ARCHIVE_RELANCE_ORANGE
  @adtDateDuJour	DateTime,
  @adcId_Doc		Decimal ( 7, 0 ) OUTPUT,
  @adcId_Sin		Decimal ( 10, 0 ),  -- [PI062]
  @adcId_Inter		Decimal ( 7, 0 ),
  @asId_Cour		VarChar ( 6    ),
  @adcId_Prod		Decimal ( 7, 0 ),
  @adcId_Ordre		Decimal ( 7, 0 ),
  @asId_Adh			VarChar ( 19   ),
  @asCod_Inter 		VarChar ( 1    ),
  @asNom			VarChar ( 71   ),
  @asTextComp1		VarChar ( 248  ),
  @asValidePar		VarChar ( 4    ),
  @asMajPar			VarChar ( 4    ),
  @asTypBlob		VarChar ( 2 )

AS

Declare @dtValideLe	DateTime,
		@iCptArch	integer
----------------------------------------------------
-- On s‚lectionne ici (et non dans l'appli), la   --
-- date du pour un ‚viter un problŠme de format   --
-- de date avec les centiŠmes de secondes.        --
----------------------------------------------------
Select  @dtValideLe = valide_le
From    sysadm.archive
Where   id_sin   = @adcId_Sin
And     id_inter = @adcId_Inter
And		id_doc	 = @adcId_Doc

----------------------------------------------------
-- On met … jour ensuite le nouvel id_doc.        --
----------------------------------------------------
Select @adcId_Doc= max ( id_doc ) + 1
From   sysadm.archive
Where  id_sin   = @adcId_Sin
And    id_inter = @adcId_Inter

-------------------------------------------------------------------------
-- Récupération du nouvelle valeur d'archive --
-------------------------------------------------------------------------
EXEC sysadm.PS_X_INCREMENTER 'CPT_ARCH', @iCptArch OUTPUT

  INSERT INTO sysadm.archive
	(	archive.id_sin,					
		archive.id_inter,
		archive.id_doc,

		archive.id_cour,
		archive.id_prod,
		archive.id_ordre,

		archive.id_adh,
		archive.cod_version,
		archive.cod_inter,
	
		archive.nom,
		archive.dte_edit,
		archive.dte_conf,
	
		archive.dte_archiv,
		archive.dte_rep,
		archive.alt_part,

		archive.alt_pce,
		archive.alt_ps,
		archive.alt_rep,
	
		archive.txt_compo1,
		archive.txt_compo2,
		archive.ref_doc_dt,
	
		archive.ref_doc_cp,
		archive.ref_doc_pc,
		archive.ref_doc_ps,

		archive.nbr_conf,
		archive.valide_le,
		archive.valide_par,

		archive.cree_le,
		archive.maj_le,
		archive.maj_par,
		
		archive.id_arch,
		archive.id_cour_orig
	)

  VALUES
	(	@adcId_Sin,
		@adcId_Inter,
		@adcId_Doc, 
	
		@asId_Cour,
		@adcId_Prod,
		@adcId_Ordre,
	
		@asId_Adh,
		2,
		@asCod_Inter,
	
		@asNom,
		'01/01/1900',
		NULL,
	
		NULL,
		NULL,
		'N',
	
		'N',
		'N',
		'N',
	
		@asTextComp1,
		NULL,
		NULL,
	
		NULL,
		NULL,
		NULL,
	
		0,
		@dtValideLe,
		@asValidePar,

		@adtDateDuJour,
		@adtDateDuJour,
		@asMajPar,
		
		@iCptArch,
		@asId_Cour
	)

GO


