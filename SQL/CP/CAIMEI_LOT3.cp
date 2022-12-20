----------------------------------------------------------------------------------------------------------------------------------------
-- Fichier Procédure Lot 3 : Traitement d'exception
-- Procedure			:	DW_S01_EXTRACTION_ENCOURS_IMEI
-- Commentaires 		:	Result de l'extraction de l'encours
-- Procedure			:	PS_U01_EXCEPTION_FORCAGE_OK
-- Commentaires 		:	Forcage à OK du sinistre passé en paramètre
----------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------
-- Procedure			:	DW_S01_EXTRACTION_ENCOURS_IMEI
-- Commentaires 		:	Result de l'extraction de l'encours
-------------------------------------------------------------------
--  JFF		12/02/2016		[PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_EXTRACTION_ENCOURS_IMEI' AND type = 'P' )
	DROP PROCEDURE sysadm.DW_S01_EXTRACTION_ENCOURS_IMEI
GO

CREATE PROCEDURE sysadm.DW_S01_EXTRACTION_ENCOURS_IMEI
	@sCtImei		varchar(3),
	@iCraSuiviImei		integer,
	@dcIdProd		Decimal(7,0), 
	@dcIdSinDeb		Decimal(10,0), -- [PI062]
	@dcIdSinFin		Decimal(10,0), -- [PI062]
	@dteDatValDeb		datetime,
	@dteDatValFin		datetime
AS

SELECT
	(Select ds1.val_dte from div_sin ds1
	 where  ds1.nom_zone = 'cra_dat_gen' 
	and 	ds1.id_sin = s.id_sin) as 'date_envoi', -- Date d'envoi
	p.nom + ' '+ p.prenom as 'nom_prenom', -- nom prenom,
	s.dte_surv,	-- Date de Surv
	s.id_sin,	-- Sinistre,
	left(s.num_imei_port, 25) as 'num_imei_port',-- num_imei_port -- [DCMP100420]
	s.num_port,	-- num_tel
	(Select ds2.val_dte from div_sin ds2
	 where  ds2.nom_zone = 'cra_last_dte' 
	and 	ds2.id_sin = s.id_sin) as 'Ddu', -- Date Dernière Utilisation
	sysadm.FN_CODE_NUM
	(
		cast 	(
				(Select	ds3.val_nbre from div_sin ds3
				where	ds3.nom_zone = 'cra_suivi_imei' 
				and	ds3.id_sin = s.id_sin )
			as varchar(12)
			) 
		,
		'-CR'
	) as 'suivi_imei' -- Suivi IMEI
from 	sysadm.sinistre s, 
	sysadm.personne p
where	( ( @dcIdSinDeb IS NULL OR @dcIdSinFin IS NULL )	OR ( s.id_sin between @dcIdSinDeb and @dcIdSinFin ) )
and	( ( @dteDatValDeb IS NULL OR @dteDatValFin IS NULL )	OR ( s.valide_le between @dteDatValDeb and @dteDatValFin ) )
and	( ( @dcIdProd = 0 ) OR ( @dcIdProd = s.id_prod ) )
and	( 
		( @iCraSuiviImei = 0 ) OR 
		( @iCraSuiviImei = 
			(	Select	ds4.val_nbre from div_sin ds4
				where	ds4.nom_zone = 'cra_suivi_imei' 
				and	ds4.id_sin = s.id_sin
			)
		)
	)
and 	s.id_ordre = p.id_ordre
and	s.id_prod in 	(	select	distinct (dp.id_prod)
				from	det_pro dp
				where 	dp.id_typ_code_dp = '-DP'
				and	dp.id_code_dp = 75
				and 	dp.id_code_car = 'CTIMEI'
				and	dp.val_car = @sCtImei
			)
order by 1 DESC

GO

----------------------------------------------------------------------------------------------------------------------------------------
-- Procedure		:	PS_U01_EXCEPTION_FORCAGE_OK
-- Commentaires 		:	Forcage à OK du sinistre passé en paramètre
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U01_EXCEPTION_FORCAGE_OK' AND type = 'P' )
	DROP PROCEDURE sysadm.PS_U01_EXCEPTION_FORCAGE_OK
GO



CREATE PROCEDURE sysadm.PS_U01_EXCEPTION_FORCAGE_OK
	@dcIdSin	Decimal(10,0), -- [PI062]
	@sIdOper	varchar(4),
	@sTraite	VarChar(1) OUTPUT
AS

DECLARE @iOkTrt	integer,
	@sMessErreur	varchar(50),
	@sIdCodeAction	varchar(6),
	@dcIdProd	decimal(7,0),
	@iIdAppli	integer,
	@sNumImeiPort	varchar(25),
	@sNumPort	varchar(25),
	@sMess		varchar(254),
	@sErr		varchar(60),
	@sCrao		varchar(4),
	@sValAction	varchar(25),
	@dtNow		datetime,
	@iIdCt		integer, -- Non utilisé, sert juste pour le parametre de reour de la creation de contact
	@iErr		integer,
	@iIdSin		integer	 -- Version integer de l'idsin

-- Initialisation
Set 	@sTraite 	= 'N'
Set 	@iOkTrt 	= 0 -- 1 Ok pour traiter, 0 non
Set 	@iIdAppli 	= 2 -- Appli Simpa 2 pour sherpa
Set 	@sMess		= 'Controle IMEI OK.'
Set 	@sErr		= space(60)
Set 	@sCrao		= 'CRAO'

-- On vérifie que le sinistre a un produit avec option det_pro 75
Select	@iOkTrt = ( 	Select	distinct 1 
			from	sysadm.det_pro dp,
				sysadm.sinistre s
			Where	s.id_sin = @dcIdSin
			and	dp.id_prod = s.id_prod
			and	dp.id_typ_code_dp = '-DP'
			and	dp.id_code_dp = 75 )
			IF @@ERROR <> 0 return @@ERROR

-- On teste l'existence de CRA_SUIVI_IMEI different de 2
if @iOkTrt = 1
BEGIN
Select	@iOkTrt = ( 	Select	distinct 1 
			from	sysadm.div_sin ds
			Where	ds.id_sin = @dcIdSin
			and	ds.nom_zone = 'cra_suivi_imei'
			and	( ds.val_nbre IS NOT NULL ) and ds.val_nbre <> 2 )
			IF @@ERROR <> 0 return @@ERROR
END 

if @iOkTrt = 1
BEGIN
	Select 	@dcIdProd	= s.id_prod, 
		@sNumImeiPort 	= left(s.num_imei_port, 25), -- [DCMP100420]
		@sNumPort 	= s.num_port
	from	sysadm.sinistre s
	where s.id_sin = @dcIdSin
	IF @@ERROR <> 0 return @@ERROR

	IF (SELECT Count(id_sin) FROM sysadm.div_sin ds where ds.id_sin = @dcIdSin ) = 0
	BEGIN
		-- Insertion de la zone cra_suivi_imei à "controle IMEI Ok"
		insert into sysadm.div_sin
		select @dcIdSin, dp.nom_zone, dp.lib_label,dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N',dp.cpt_tri, 2, null, null, null, GetDate(),GetDate(), @sIdOper, GetDate(), @sIdOper
		from sysadm.div_pro dp
		where dp.nom_zone = 'cra_suivi_imei' and id_prod = @dcIdProd
		IF @@ERROR <> 0 return @@ERROR

		insert into sysadm.w_div_sin
		select @dcIdSin, dp.nom_zone, dp.lib_label,dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N',dp.cpt_tri, 2, null, null, null, 1, GetDate(),GetDate(), @sIdOper
		from sysadm.div_pro dp
		where dp.nom_zone = 'cra_suivi_imei' and id_prod = @dcIdProd
		and   EXISTS ( select * from sysadm.w_sin where id_sin = @dcIdSin )
		IF @@ERROR <> 0 return @@ERROR

		-- [CRAO_LOT2.004] Erreur !!! C'est la ddu que l'on force à null, et pas la datègen !!!
		-- Insertion de la zone cra_dat_gen à Null
/*		insert into sysadm.div_sin
		select @dcIdSin, dp.nom_zone, dp.lib_label,dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N',dp.cpt_tri, null, null, null, null, GetDate(),GetDate(), @sIdOper, GetDate(), @sIdOper
		from sysadm.div_pro dp
		where dp.nom_zone = 'cra_dat_gen' and id_prod = @dcIdProd
		IF @@ERROR <> 0 return @@ERROR

		insert into sysadm.w_div_sin
		select @dcIdSin, dp.nom_zone, dp.lib_label,dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N',dp.cpt_tri, null, null, null, null, 1, GetDate(),GetDate(), @sIdOper
		from sysadm.div_pro dp
		where dp.nom_zone = 'cra_dat_gen' and id_prod = @dcIdProd
		and   EXISTS ( select * from sysadm.w_sin where id_sin = @dcIdSin )
		IF @@ERROR <> 0 return @@ERROR*/

		-- [CRAO_LOT2.003] On force aussi la DDu a null
		-- Insertion de la zone cra_last_dte à Null
		insert into sysadm.div_sin
		select @dcIdSin, dp.nom_zone, dp.lib_label,dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N',dp.cpt_tri, null, null, null, null, GetDate(),GetDate(), @sIdOper, GetDate(), @sIdOper
		from sysadm.div_pro dp
		where dp.nom_zone = 'cra_last_dte' and id_prod = @dcIdProd
		IF @@ERROR <> 0 return @@ERROR

		insert into sysadm.w_div_sin
		select @dcIdSin, dp.nom_zone, dp.lib_label,dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N',dp.cpt_tri, null, null, null, null, 1, GetDate(),GetDate(), @sIdOper
		from sysadm.div_pro dp
		where dp.nom_zone = 'cra_last_dte' and id_prod = @dcIdProd
		and   EXISTS ( select * from sysadm.w_sin where id_sin = @dcIdSin )
		IF @@ERROR <> 0 return @@ERROR

	END
	ELSE
	BEGIN
		-- Mise à jour de la zone cra_suivi_imei à "controle IMEI Ok"
		UPDATE	sysadm.div_sin
		SET	val_nbre	=	2,
			maj_le		=	getdate(),
			maj_par		=	@sIdOper
		WHERE	id_sin		=	@dcIdSin
		AND	nom_zone	=	'cra_suivi_imei'
		
		IF @@ERROR <> 0 return @@ERROR
		
		UPDATE	sysadm.w_div_sin
		SET	cpt_valide	=	1,
			val_nbre	=	2,
			maj_le		=	getdate(),
			maj_par		=	@sIdOper
		WHERE	id_sin		=	@dcIdSin
		AND	nom_zone	=	'cra_suivi_imei'

		IF @@ERROR <> 0 return @@ERROR

		-- [CRAO_LOT2.004] Erreur !!! C'est la ddu que l'on force à null, et pas la datègen !!!
		-- Mise à jour de la zone cra_dat_gen à Null
/*		UPDATE	sysadm.div_sin
		SET	val_dte		=	null,
			maj_le		=	getdate(),
			maj_par		=	@sIdOper
		WHERE	id_sin		=	@dcIdSin
		AND	nom_zone	=	'cra_dat_gen'
		
		IF @@ERROR <> 0 return @@ERROR
		
		UPDATE	sysadm.w_div_sin
		SET	cpt_valide	=	1,
			val_dte		=	null,
			maj_le		=	getdate(),
			maj_par		=	@sIdOper
		WHERE	id_sin		=	@dcIdSin
		AND	nom_zone	=	'cra_dat_gen'

		IF @@ERROR <> 0 return @@ERROR*/

		-- [CRAO_LOT2.003] On force aussi la DDu a null
		-- Mise à jour de la zone cra_last_dte à Null
		UPDATE	sysadm.div_sin
		SET	val_dte		=	null,
			maj_le		=	getdate(),
			maj_par		=	@sIdOper
		WHERE	id_sin		=	@dcIdSin
		AND	nom_zone	=	'cra_last_dte'
		
		IF @@ERROR <> 0 return @@ERROR
		
		UPDATE	sysadm.w_div_sin
		SET	cpt_valide	=	1,
			val_dte		=	null,
			maj_le		=	getdate(),
			maj_par		=	@sIdOper
		WHERE	id_sin		=	@dcIdSin
		AND	nom_zone	=	'cra_last_dte'

		IF @@ERROR <> 0 return @@ERROR

	END	
	
	-- Création d'un contact avec travail
	-- EXEC sysadm.PS_I04_CONTACT_TRAVAIL @dcIdSin, @iIdAppli, @sMess, @sCrao, @sErr OUTPUT
	Set @iIdSin = cast ( @dcIdSin as Integer )
	IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
		EXEC @iErr = SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @iIdSin, @iIdAppli, @sMess, @sCrao, @sErr OUTPUT, @iIdCt OUTPUT
	ELSE
		EXEC @iErr = SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @iIdSin, @iIdAppli, @sMess, @sCrao, @sErr OUTPUT, @iIdCt OUTPUT
	IF @@ERROR <> 0 return @@ERROR
	IF upper(@sErr) <> 'OK' or @iErr <> 0 return -1

	-- GESTION DE LA TRACE
	Set @sValAction = CONVERT ( varchar(25), getdate(), 121 )

	Set @dtNow	= GetDate()
	EXEC sysadm.PS_I01_TRACE_CRA_IMEI @dcIdSin, @dtNow, @sNumImeiPort, @sNumPort, '-SC', 'FOR_OK', @sValAction
	IF @@ERROR <> 0 return @@ERROR
	
	Set @dtNow	= GetDate()
	EXEC sysadm.PS_I01_TRACE_CRA_IMEI @dcIdSin, @dtNow, @sNumImeiPort, @sNumPort, '-SC', 'CTOK', '00/00/0000'
	IF @@ERROR <> 0 return @@ERROR

	Set @sTraite = 'O'

	return @@ERROR

END

GO
