----------------------------------------------------------------------------------------------------------------------------------------
-- Fichier	:	CAIMEI_LOT1.CP
-- Commentaires	: 	Comprends toutes les procedures servant à la gestion de contrôle de l'imei
-- Procédure	:	PS_S01_CAIMEI
--		:	PS_S02_CAIMEI
--		:	PS_S01_CRA_IMEI_TRT
--		:	PS_I01_CRA_IMEI_TRT
--		:	PS_CRA_IMEI
--		:	PS_I01_TRACE_CRA_IMEI
--		:	TR_I01_DIV_SIN
-------------------------------------------------------------------
-- Modif : 
-- [CRAO_LOT1.005]	PHG	20/02/2007	Gestion de la précédence des traitement : Demande de CTRL est prioritaire sur Relance/forcage
-- [CRAO_LOT1.006]	PHG	21/02/2007	Correction gestion code retour traitement 1 et gestion exclusion numero portable mal formé.
-- [CRAO_LOT1.009]	PHG	07/03/2007	Modification des @ mail pour les rejet, et correctino du message pour être moins alarmiste.
----------------------------------------------------------------------------------------------------------------------------------------
-- Procedure	:	PS_S01_CAIMEI
-- Commentaires	: 	Procedure principale appele tous les jours
-------------------------------------------------------------------
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_CAIMEI' AND type = 'P' )
	DROP PROCEDURE sysadm.PS_S01_CAIMEI
GO

CREATE PROCEDURE sysadm.PS_S01_CAIMEI
	@sCcimei	varchar(35)
AS

/* */
/* @sCcimei varchar(35)  - centre de controle imei */
/* */

DECLARE @dDate		varchar(10),
	@sRep		varchar(250),
	@sAdrMail	varchar(250),
        @sQuery		varchar(500),
        @sCommande	varchar(250),
        @sMessage	varchar(1000), --[I027] Augmentation de la taille du message
	@sOsqlOption	varchar(255),
        @sObjet      	varChar(255),
        @sFicOut	varchar(255),
        @sNomServeur	varchar(255),
	@sRetourErrMail	varchar(255),
	@sBcp		varchar(500),
	@sNomFicRejetFonc	varchar(255),
	@sOption	varchar(255),
	@sConnex	varchar(255),
	@sBase		varchar(255),
	
	/* */
	/* Variable permettant la gestion des erreurs */
	/* */
	@iOsql		integer,
	@iFile		integer,
	@iRet		integer,
	@sMessErreur	varchar(255),
	@sMailInformatique	varchar(255),
	@sMailGestion	varchar(255)

/* */
/* on positionne l'option pour ne pas avoir d'affichage des resultats */
/* */
SET NOCOUNT ON

SET @dDate	= CONVERT ( varchar (10), GETDATE (), 103 )

SET @iFile = 0
SET @iOsql = 0

SET @sMessErreur = SPACE(255)

/* */
/* Option pour osql */
/* */
SET @sOsqlOption = ' -h-1 -n -w5000 /s"	" /b /u'

/* */
/* On crée une table temporaire pour la procédure stockée étendue xp_fileexist. */
/* */
IF      ( SELECT object_id ( 'tempdb.dbo.#TblFileExistsExportCra' ) ) > 0
        BEGIN
                EXEC ( 'Drop table #TblFileExistsExportCra' )
        END

CREATE TABLE #TblFileExistsExportCra
(
	FileExists		TINYINT	NULL,
	FileIsDirectory		TINYINT	NULL,
	ParentDirectoryExists   TINYINT NULL
)

/* */
/* construction de la query en fonction du serveur */
/* */
IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
BEGIN
	EXEC @iRet = SIMPA2_PRO.sysadm.PS_S02_CAIMEI @sCcimei, @sMessErreur OUTPUT
	SET @sQuery = 'EXEC SIMPA2_PRO.sysadm.PS_S01_CRA_IMEI_TRT'
END

ELSE
BEGIN
	EXEC @iRet = SIMPA2_TRT.sysadm.PS_S02_CAIMEI @sCcimei, @sMessErreur OUTPUT
	SET @sQuery = 'EXEC SIMPA2_TRT.sysadm.PS_S01_CRA_IMEI_TRT'
END

IF @iRet = 0
BEGIN
	/* */
	/* récupération du nom du répertoire de dépose du serveur */
	/* */
	SELECT	@sRep = val_car
	FROM	sysadm.det_pro dp
	WHERE	dp.id_prod	=	( SELECT TOP 1 id_prod FROM sysadm.det_pro dp
						WHERE	dp.id_typ_code_dp	=	'-DP'
						AND	dp.id_code_dp		=	75
						AND	dp.id_typ_calc		=	'-PC'
						AND	dp.id_code_car		=	'CTIMEI'
						AND	dp.val_car		=	@sCcimei
					)
	AND	dp.id_typ_code_dp	=	'-DP'
	AND	dp.id_code_dp		=	75
	AND	dp.id_typ_calc		=	'-PC'
	AND	dp.id_code_car		=	'PATHEX'

	/* */
	/* construction du nom du fichier */
	/* Au format CON_[centre de controle imei]_JJMMAAAA_HHMMSS.TXT */
	/* ex : CON_ORV_01012007_121200.txt */
	/* */
	SET @sFicOut	=	RTRIM(@sRep) +
				'CON_' + @sCcimei + '_' +
				RIGHT ( '00' + CONVERT ( varchar(2), DatePart ( day,getdate()	) ),  2 ) +
				RIGHT ( '00' + CONVERT ( varchar(2), DatePart ( month,getdate() ) ),  2 ) +
				CONVERT (char(4), DatePart (year,getdate()) ) + '_' +
				RIGHT ( '00' + CONVERT ( varchar(2), DatePart ( hour,getdate()	) ),  2 ) +
				RIGHT ( '00' + CONVERT ( varchar(2), DatePart ( minute,getdate() ) ),  2 ) +
				RIGHT ( '00' + CONVERT ( varchar(2), DatePart ( second,getdate() ) ),  2 ) +
				+ '.TXT'
			
	SET @sNomFicRejetFonc = RTRIM(@sRep) +
				'CON_' + @sCcimei + '_' +
				RIGHT ( '00' + CONVERT ( varchar(2), DatePart ( day,getdate()	) ),  2 ) +
				RIGHT ( '00' + CONVERT ( varchar(2), DatePart ( month,getdate() ) ),  2 ) +
				CONVERT (char(4), DatePart (year,getdate()) ) + '_' +
				RIGHT ( '00' + CONVERT ( varchar(2), DatePart ( hour,getdate()	) ),  2 ) +
				RIGHT ( '00' + CONVERT ( varchar(2), DatePart ( minute,getdate() ) ),  2 ) +
				RIGHT ( '00' + CONVERT ( varchar(2), DatePart ( second,getdate() ) ),  2 ) +
				+ '.REJ'

	SET @sNomServeur	=	@@servername
	SET @sCommande = 'sqlcmd /S ' + @sNomServeur + ' /E /Q "' + @sQuery + '" /o "' + @sFicOut + '"' + @sOsqlOption

	EXEC @iOsql = master.dbo.xp_cmdshell @sCommande, no_output

	-- est ce que le fichier à bien été créé sur le serveur
	INSERT INTO #TblFileExistsExportCra EXEC master.dbo.xp_fileexist @sFicOut

	IF ( SELECT FileExists FROM #TblFileExistsExportCra ) <> 1
	BEGIN
		SET @sMessErreur = 'Le fichier ' + @sFicOut + ' n''as pas été créé. Le traitement est impossible.'
		SET @iFile = -1
	END
END

-- email des services à mettre au courant en cas d'erreur
-- Modif : PHG, 02/03/2007 => Erreur Informatique : On bascule dans le cas de production
-- Cas de debuggage :
-- SET @sMailInformatique = 'dga@spb.fr; phg@spb.fr; jca@spb.fr'
-- Cas de production :
SET @sMailInformatique = 'productioninformatique@spb.fr; etudessinistres@spb.fr'

-- email des services à mettre au courant en cas de rejet de type fonctionnel
SET @sMailGestion = 'supportDNT@spb.fr' -- [CRAO_LOT1.009] au lieu de 'dga@spb.fr; phg@spb.fr; jca@spb.fr'

-- Il y a eu un problème pas d'envoi de mail à orange, avertissement à DEI
IF @iOsql <> 0 OR @iFile <> 0 OR @iRet <> 0
BEGIN
	SET @iRet = -1
	
	SET @sMessage  = 'ATTENTION : Contacter le service DEI.' + char(13) + 'ERREUR : ' + @sMessErreur + char(13) + 'ERREUR Osql: ' + cast(@iOsql as varchar(5)) + char(13) + char(10)
	EXEC master.dbo.SPB_PS_MAIL @sRetourErrMail OUTPUT, @sMailInformatique, @sMessage, 'Erreur traitement export fichier CRA', '', '', @sFicOut
END
ELSE
BEGIN
	-- Tout c'est bien passé
	-- on vide la table de taitement pour le traitement suivant
	-- [I027] - France - Suppression instruction incompatible réplication transactionelle
	-- TRUNCATE TABLE sysadm.cra_imei_trt_export
	DELETE FROM sysadm.cra_imei_trt_export

END

IF ( SELECT count(*) FROM sysadm.cra_imei_rejet WHERE type_trait = 'E' AND type_rejet = 'F' AND date_rejet >= convert( varchar(8), getdate(), 112 ) ) > 0 -- Correction Date ISO
BEGIN

	-- print 'Rejet fonctionnel'
	
	-- option bcp -m : nombre erreurs autorisé, -c : importe les données au format caractère
	SET @sOption	=	' -m9999 -c'

	-- paramètre d'authentification sur le serveur
    -- Modif le 14/03/2011 - Datafly
	--SET @sConnex	=	' -Usysadm -P' + lower ( @@servername ) + '_sysadm -S' + @@servername
	SET @sConnex	=	' -T -S' + @@servername -- [I027] En sql 2008, la connexion approuvee passe de -E à-T

	-- on regarde si le serveur utilisé est un serveur de production
	IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
		SET @sBase	=	'SIMPA2_PRO'
	ELSE
		SET @sBase	=	'SIMPA2_TRT'

	-- [I027] - Correction Date ISO
	--SET @sQuery = ' "SELECT dte_envoi, nom_prenom, id_sin, dte_surv_fic, num_imei_port, num_port, reponse, message_rejet FROM ' + @sBase + '.sysadm.cra_imei_rejet WHERE type_trait = ''E'' AND type_rejet = ''F'' AND date_rejet >= convert( varchar(10), getdate(), 103 ) " '
	SET @sQuery = ' "SELECT dte_envoi, nom_prenom, id_sin, dte_surv_fic, num_imei_port, num_port, reponse, message_rejet FROM ' + @sBase + '.sysadm.cra_imei_rejet WHERE type_trait = ''E'' AND type_rejet = ''F'' AND date_rejet >= convert( varchar(8), getdate(), 112 ) " '
	SET @sBcp = 'bcp ' + @sQuery + ' queryout "' + @sNomFicRejetFonc + '"' + @sOption + @sConnex
	
	-- print '@sBcp : ' + @sBcp
	
	EXEC @iRet = master.dbo.xp_cmdshell @sBcp
	IF @@ERROR <> 0 OR @iRet <> 0
	BEGIN

		-- print 'Error : master.dbo.xp_cmdshell'
		
		SET @iRet = -1

		SET @sMessage  = 'ATTENTION : Contacter le service DEI.' + char(13) + 'ERREUR de l''execution de : ' + @sBcp
		EXEC master.dbo.SPB_PS_MAIL @sRetourErrMail OUTPUT, @sMailInformatique, @sMessage, 'Erreur traitement export fichier CRA'
	END
	ELSE
	BEGIN
	
		-- print 'Envoi du fichier de rejet fonctionnel'
		SET @iRet = 0
		-- [CRAO_LOT1.009] On met "Avertissement" au lieu de "Attention, !! contacter service DEI !!" -> ce type d'entete est pour les erreurs infos.
		SET @sMessage  = 'AVERTISSEMENT : ' + char(13) + 'Un fichier de rejet a été généré lors du traitement de l''import du fichier de controle IMEI.' + char(13) + 'Fichier : ' + @sNomFicRejetFonc + char(13) + char(10)
		EXEC master.dbo.SPB_PS_MAIL @sRetourErrMail OUTPUT, @sMailGestion, @sMessage, 'Export fichier CRA : Fichier de rejet Généré.', '', '', @sNomFicRejetFonc
	END
END

IF ( SELECT count(*) FROM sysadm.cra_imei_rejet WHERE type_trait = 'E' AND type_rejet = 'I' AND date_rejet >= convert( varchar(8), getdate(), 112 ) ) > 0 -- [I027] Correction Date ISO
BEGIN

	-- print '!! Envoi du fichier de rejet informatique'
	SET @iRet = -1
	
	SET @sMessage  = 'ATTENTION : Contacter le service DEI.' + char(13) + 'Il y a des erreurs de type informatique lors de la génération du fichier : ' + @sFicOut + char(13) + 'Vérifier la table de rejet [cra_imei_rejet] avec le select suivant: ' + char(13) + 'SELECT count(*) FROM cra_imei_rejet WHERE type_trait = ''E'' AND type_rejet = ''I'' AND date_rejet >= ''' + convert( varchar(8), getdate(), 112 ) + '''' -- [I027] Correction Date ISO
	EXEC master.dbo.SPB_PS_MAIL @sRetourErrMail OUTPUT, @sMailInformatique, @sMessage, 'Erreur traitement export fichier CRA'
END

RETURN @iRet

GO

----------------------------------------------------------------------------------------------------------------------------------------
-- Procedure	:	PS_S02_CAIMEI
-- Commentaires	:	Procedure de création des lignes à traiter
-------------------------------------------------------------------
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_CAIMEI' AND type = 'P' )
	DROP PROCEDURE sysadm.PS_S02_CAIMEI
GO

CREATE PROCEDURE sysadm.PS_S02_CAIMEI
	@sCcimei	varchar(35),
	@sMessErreur	varchar(255) OUTPUT
AS

/* */
/* commenter ici les argument de la procedure */
/* */

DECLARE @iRet integer

-- Pas d'affichage des resultats
SET NOCOUNT ON

SET @sMessErreur = SPACE(255)

SET @iRet = 0

--	Vérification si [cra_imei_trt_export] est vide
IF ( SELECT COUNT(id_sin)
	FROM	sysadm.cra_imei_trt_export
	WHERE	code_pos IS NULL
	) = 0

--	Process standard
BEGIN
	EXEC sysadm.PS_I01_CRA_IMEI_TRT @sCcimei, @sMessErreur OUTPUT

	IF ( SELECT COUNT ( id_sin ) FROM cra_imei_trt_export ) = 0
	BEGIN
		SET @sMessErreur = 'Aucun dossiers ne correspondent aux critères de contrôle, de relance ou de forçage'
		SET @iRet = -1
	END
	ELSE
		EXEC @iRet = sysadm.PS_CRA_IMEI @sMessErreur OUTPUT
END

ELSE
BEGIN
	-- Process reprise en erreur
	EXEC @iRet = sysadm.PS_CRA_IMEI @sMessErreur OUTPUT
END

RETURN @iRet

GO


----------------------------------------------------------------------------------------------------------------------------------------
-- Procedure	:	PS_S01_CRA_IMEI_TRT
-- Commentaires	:	Procedure de selection des traitements effectués
-------------------------------------------------------------------
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_CRA_IMEI_TRT' AND type = 'P' )
	DROP PROCEDURE sysadm.PS_S01_CRA_IMEI_TRT
GO

CREATE PROCEDURE sysadm.PS_S01_CRA_IMEI_TRT
AS

-- Pas d'affichage des resultat
SET NOCOUNT ON

SELECT	cast(priorite as varchar(2)),
	convert(varchar(10), cra_dat_gen, 103) + ' ' + convert(varchar(8), cra_dat_gen, 108),
	nom_prenom,
	id_sin,
	convert(varchar(10), dte_surv, 103),
	num_imei_port,
	num_port
FROM	sysadm.cra_imei_trt_export
/* */
/* on ne prends que les cas de demande de controle (1), et les cas de relance (2) */
/* pour contruire le fichier à destination du centre de controle imei */
/* */
WHERE 	traitement in ('1','2')
ORDER BY	priorite,
		dte_surv DESC

GO

----------------------------------------------------------------------------------------------------------------------------------------
-- Procedure	:	PS_I01_CRA_IMEI_TRT
-- Commentaires	:	Procedure de récupération des traitements à effectuer
-------------------------------------------------------------------
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_CRA_IMEI_TRT' AND type = 'P' )
	DROP PROCEDURE sysadm.PS_I01_CRA_IMEI_TRT
GO

CREATE PROCEDURE sysadm.PS_I01_CRA_IMEI_TRT
	-- Centre de controle
	@sCcimei	varchar(35),
	@sMessErreur	varchar(255) OUTPUT
AS

DECLARE @dtMEP	datetime

-- gestion erreur
SET 	@sMessErreur = 'OK'

-- Pas d'affichage des resultat
SET NOCOUNT ON

-- Date de mise en production
SET @dtMEP = cast ( '14/02/2007' as datetime )

-- début de la transaction
--print 'BEGIN TRAN PS_I01_CRA_IMEI_TRT'
BEGIN TRAN

INSERT	sysadm.cra_imei_trt_export
-- SI CRA_CTRL_IMEI = 'O' -- demande de contrôle
SELECT	s.id_sin,
	dp_priorite.val_num,
	s.id_prod,
	ds_cra_ctrl_imei.val_car,
	ds_cra_suivi_imei.val_nbre,
	ds_cra_cpt_dmde.val_nbre,
	ds_cra_dat_gen.val_dte,
	dp_del1.val_num,
	dp_del2.val_num,
	dp_delok.val_num,
	RTRIM ( p.nom ) + ' ' + RTRIM ( p.prenom ),
	s.dte_surv,
	left(s.num_imei_port, 25), -- [DCMP100420]
	s.num_port,
	'1', -- traitement premier controle
	NULL

	FROM	sysadm.sinistre	 AS s

	INNER JOIN sysadm.personne AS p
	ON s.id_ordre = p.id_ordre

	INNER JOIN sysadm.div_sin AS ds_cra_ctrl_imei
	ON s.id_sin = ds_cra_ctrl_imei.id_sin
	-- les sinistre dont le cra_ctrl_imei est à oui
	AND	ds_cra_ctrl_imei.val_car	=	'O'
	AND	ds_cra_ctrl_imei.nom_zone	=	'cra_ctrl_imei'

	INNER JOIN sysadm.det_pro AS dp_ctimei
	ON s.id_prod = dp_ctimei.id_prod
	-- le paramétrage pour le centre de controle
	AND	dp_ctimei.id_typ_code_dp	=	'-DP'
	AND	dp_ctimei.id_code_dp		=	75
	AND	dp_ctimei.id_typ_calc		=	'-PC'
	AND	dp_ctimei.id_code_car		=	'CTIMEI'
	AND	dp_ctimei.val_car		=	@sCcimei

	INNER JOIN sysadm.det_pro AS dp_del1
	ON s.id_prod = dp_del1.id_prod
	-- le 1er delai
	AND	dp_del1.id_typ_code_dp		=	'-DP'
	AND	dp_del1.id_code_dp		=	75
	AND	dp_del1.id_typ_calc		=	'-PC'
	AND	dp_del1.id_code_car		=	'DEL1'

	INNER JOIN sysadm.det_pro AS dp_del2
	ON s.id_prod = dp_del2.id_prod
	-- le 2eme delai
	AND	dp_del2.id_typ_code_dp		=	'-DP'
	AND	dp_del2.id_code_dp		=	75
	AND	dp_del2.id_typ_calc		=	'-PC'
	AND	dp_del2.id_code_car		=	'DEL2'

	INNER JOIN sysadm.det_pro AS dp_delok
	ON s.id_prod = dp_delok.id_prod
	-- le delai de forçage à OK
	AND	dp_delok.id_typ_code_dp		=	'-DP'
	AND	dp_delok.id_code_dp		=	75
	AND	dp_delok.id_typ_calc		=	'-PC'
	AND	dp_delok.id_code_car		=	'DELOK'

	INNER JOIN sysadm.det_pro AS dp_priorite
	ON s.id_prod = dp_priorite.id_prod
	-- la priorité
	AND	dp_priorite.id_typ_code_dp	=	'-DP'
	AND	dp_priorite.id_code_dp		=	75
	AND	dp_priorite.id_typ_calc		=	'-XX'

	LEFT OUTER JOIN sysadm.div_sin AS ds_cra_suivi_imei
	ON s.id_sin = ds_cra_suivi_imei.id_sin
	-- la zone de suivi n'est pas à OK
	AND	ds_cra_suivi_imei.nom_zone	=	'cra_suivi_imei'
	AND	ds_cra_suivi_imei.val_nbre	<>	2

	LEFT OUTER JOIN sysadm.div_sin AS ds_cra_cpt_dmde
	ON s.id_sin = ds_cra_cpt_dmde.id_sin
	-- le compteur de demande est inférieur à 4
	AND	ds_cra_cpt_dmde.nom_zone	=	'cra_cpt_dmde'
	AND	ds_cra_cpt_dmde.val_nbre	<=	4

	LEFT OUTER JOIN sysadm.div_sin AS ds_cra_dat_gen
	ON s.id_sin = ds_cra_dat_gen.id_sin
	-- la date de génération du fichier
	AND	ds_cra_dat_gen.nom_zone		=	'cra_dat_gen'

	--	CONTROLE	COMPLEMENTAIRE
	WHERE	s.num_port	IS	NOT NULL
	AND	s.num_imei_port	IS	NOT NULL
	-- 1	Bloqué	/	200	Refusé	/	600	Réglé	/	900	Sans	suite
	AND	s.cod_etat	NOT IN	( 1,	900,	600,	200 )
	-- [CRAO_LOT1.005] Si le sisnitre est DEJA dans la table de traitement, on l'exclu.
	AND	s.id_sin NOT IN 
		(
			select cite.id_sin 
			from cra_imei_trt_export cite
		)

IF @@ERROR <> 0
BEGIN
	ROLLBACK TRAN
	SET @sMessErreur = 'ERREUR - INSERT cra_imei_trt_export'
END

ELSE
BEGIN
	INSERT	sysadm.cra_imei_trt_export
	-- SI CRA_SUIVI_IMEI = '1' AND ( CRA_DAT_GEN + DEL_1 = DATE_JOUR OR CRA_DAT_GEN + DEL_2 = DATE_JOUR	) //relance
		SELECT	s.id_sin,
			dp_priorite.val_num as dp_priorite,
			s.id_prod,
			ds_cra_ctrl_imei.val_car as ds_cra_ctrl_imei,
			ds_cra_suivi_imei.val_nbre as ds_cra_suivi_imei,
			ds_cra_cpt_dmde.val_nbre as ds_cra_cpt_dmde,
			ds_cra_dat_gen.val_dte as ds_cra_dat_gen,
			dp_del1.val_num as dp_del1,
			dp_del2.val_num as dp_del2,
			dp_delok.val_num as dp_delok,
			RTRIM ( p.nom ) + ' ' + RTRIM ( p.prenom )as nom_prenom,
			s.dte_surv,
			left(s.num_imei_port, 25), -- [DCMP100420]
			s.num_port,
			'2', -- traitement relance
			NULL
		
			FROM	sysadm.sinistre AS s
		
			INNER JOIN sysadm.personne AS p
			ON s.id_ordre =	p.id_ordre
		
			INNER JOIN sysadm.div_sin AS ds_cra_ctrl_imei
			ON s.id_sin = ds_cra_ctrl_imei.id_sin
			-- IMEI à controler
			AND	ds_cra_ctrl_imei.nom_zone	=	'cra_ctrl_imei'
		
			INNER JOIN sysadm.det_pro AS dp_ctimei
			ON s.id_prod = dp_ctimei.id_prod
			-- le centre de contrôle
			AND	dp_ctimei.id_typ_code_dp	=	'-DP'
			AND	dp_ctimei.id_code_dp		=	75
			AND	dp_ctimei.id_typ_calc		=	'-PC'
			AND	dp_ctimei.id_code_car		=	'CTIMEI'
			AND	dp_ctimei.val_car		=	@sCcimei
		
			INNER JOIN sysadm.det_pro AS dp_del1
			ON s.id_prod = dp_del1.id_prod
			-- 1er delai
			AND	dp_del1.id_typ_code_dp		=	'-DP'
			AND	dp_del1.id_code_dp		=	75
			AND	dp_del1.id_typ_calc		=	'-PC'
			AND	dp_del1.id_code_car		=	'DEL1'
		
			INNER JOIN sysadm.det_pro AS dp_del2
			ON s.id_prod = dp_del2.id_prod
			-- 2nd delai
			AND	dp_del2.id_typ_code_dp		=	'-DP'
			AND	dp_del2.id_code_dp		=	75
			AND	dp_del2.id_typ_calc		=	'-PC'
			AND	dp_del2.id_code_car		=	'DEL2'
		
			INNER JOIN sysadm.det_pro AS dp_delok
			ON s.id_prod = dp_delok.id_prod
			-- delai de forçage à OK
			AND	dp_delok.id_typ_code_dp		=	'-DP'
			AND	dp_delok.id_code_dp		=	75
			AND	dp_delok.id_typ_calc		=	'-PC'
			AND	dp_delok.id_code_car		=	'DELOK'
		
			INNER JOIN sysadm.det_pro AS dp_priorite
			ON s.id_prod = dp_priorite.id_prod
			-- priorité
			AND	dp_priorite.id_typ_code_dp	=	'-DP'
			AND	dp_priorite.id_code_dp		=	75
			AND	dp_priorite.id_typ_calc		=	'-XX'
		
			INNER JOIN sysadm.div_sin AS ds_cra_suivi_imei
			ON s.id_sin = ds_cra_suivi_imei.id_sin
			-- controle IMEI en cours
			AND	ds_cra_suivi_imei.nom_zone	=	'cra_suivi_imei'
			AND	ds_cra_suivi_imei.val_nbre	=	1
		
			INNER JOIN sysadm.div_sin AS ds_cra_cpt_dmde
			ON s.id_sin = ds_cra_cpt_dmde.id_sin
			-- compteur de demande inférieur à 4
			AND	ds_cra_cpt_dmde.nom_zone	=	'cra_cpt_dmde'
			AND	ds_cra_cpt_dmde.val_nbre	<=	4
		
			INNER JOIN sysadm.div_sin AS ds_cra_dat_gen
			ON s.id_sin = ds_cra_dat_gen.id_sin
			-- date de génération du fichier
			AND	ds_cra_dat_gen.nom_zone		=	'cra_dat_gen'
		
			WHERE	s.num_port	IS	NOT NULL
			AND	s.num_imei_port	IS	NOT NULL
		
			-- 1 Bloqué	/	200	Refusé	/	600	Réglé	/	900	Sans suite
			AND	s.cod_etat	NOT IN	( 1,	900,	600,	200 )
		
			-- permets de savoir si les delais de relance sont respectés
			AND	(
				-- prends les sinistres dont le delai est compris entre le delai 1 et le ( delai 2 - 1 )
				( DATEDIFF ( day, ds_cra_dat_gen.val_dte + dp_del1.val_num, getdate() ) >= 0
					AND DATEDIFF ( day, ds_cra_dat_gen.val_dte + dp_del1.val_num, getdate() ) < dp_del2.val_num - dp_del1.val_num
					AND ( SELECT count(id_seq)
						FROM	sysadm.trace_cra_imei tci
						WHERE	tci.id_sin = s.id_sin
						AND	tci.num_imei_port	= s.num_imei_port
						AND	tci.num_port	= s.num_port
						AND	tci.id_code_action = 'REL' ) = 0
				)
				-- prends les sinistres dont le delai est compris entre le delai 2 et le ( delai forcage - 1 )
				OR ( DATEDIFF ( day, ds_cra_dat_gen.val_dte + dp_del2.val_num, getdate() ) >= 0
					AND DATEDIFF ( day, ds_cra_dat_gen.val_dte + dp_del2.val_num, getdate() ) < dp_delok.val_num - dp_del2.val_num
					AND ( SELECT count(id_seq)
						FROM	sysadm.trace_cra_imei tci
						WHERE	tci.id_sin = s.id_sin
						AND	tci.num_imei_port	= s.num_imei_port
						AND	tci.num_port	= s.num_port
						AND	tci.id_code_action	= 'REL' ) = 1
					)
				)
		
			-- prise en charge des dossiers dont la creation est superieure à la date de mise en production
			AND	s.cree_le	>=	@dtMEP
			-- [CRAO_LOT1.005] Si le sisnitre est DEJA dans la table de traitement, on l'exclu.
			AND	s.id_sin NOT IN 
				(
					select cite.id_sin 
					from cra_imei_trt_export cite
				)

	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRAN
		SET @sMessErreur = 'ERREUR - INSERT cra_imei_trt_export'
	END

	ELSE
	BEGIN

		INSERT	sysadm.cra_imei_trt_export
		-- SI CRA_SUIVI_IMEI = '1' AND CRA_DAT_GEN + DEL_OK <= DATE_JOUR -- forçage
			SELECT	s.id_sin,
				dp_priorite.val_num,
				s.id_prod,
				ds_cra_ctrl_imei.val_car,
				ds_cra_suivi_imei.val_nbre,
				ds_cra_cpt_dmde.val_nbre,
				ds_cra_dat_gen.val_dte,
				dp_del1.val_num,
				dp_del2.val_num,
				dp_delok.val_num,
				RTRIM ( p.nom ) + ' ' + RTRIM ( p.prenom ),
				s.dte_surv,
				left(s.num_imei_port, 25), --[DCMP100420]
				s.num_port,
				'3', -- traitement forçage
				NULL

			FROM	sysadm.sinistre AS s

			INNER JOIN sysadm.personne AS p
			ON s.id_ordre	=	p.id_ordre

			INNER JOIN sysadm.div_sin AS ds_cra_ctrl_imei
			ON s.id_sin = ds_cra_ctrl_imei.id_sin
			-- le controle IMEI est à "NON"
			AND	ds_cra_ctrl_imei.val_car	=	'N'
			AND	ds_cra_ctrl_imei.nom_zone	=	'cra_ctrl_imei'

			INNER JOIN sysadm.det_pro  AS dp_ctimei
			ON s.id_prod = dp_ctimei.id_prod
			-- le centre de controle
			AND	dp_ctimei.id_typ_code_dp	=	'-DP'
			AND	dp_ctimei.id_code_dp		=	75
			AND	dp_ctimei.id_typ_calc		=	'-PC'
			AND	dp_ctimei.id_code_car		=	'CTIMEI'
			AND	dp_ctimei.val_car		=	@sCcimei

			INNER JOIN sysadm.det_pro  AS dp_del1
			ON s.id_prod = dp_del1.id_prod
			-- 1er delai
			AND	dp_del1.id_typ_code_dp		=	'-DP'
			AND	dp_del1.id_code_dp		=	75
			AND	dp_del1.id_typ_calc		=	'-PC'
			AND	dp_del1.id_code_car		=	'DEL1'

			INNER JOIN sysadm.det_pro  AS dp_del2
			ON s.id_prod = dp_del2.id_prod
			-- 2nd delai
			AND	dp_del2.id_typ_code_dp		=	'-DP'
			AND	dp_del2.id_code_dp		=	75
			AND	dp_del2.id_typ_calc		=	'-PC'
			AND	dp_del2.id_code_car		=	'DEL2'

			INNER JOIN sysadm.det_pro  AS dp_delok
			ON s.id_prod = dp_delok.id_prod
			-- delai de forçage à OK
			AND	dp_delok.id_typ_code_dp		=	'-DP'
			AND	dp_delok.id_code_dp		=	75
			AND	dp_delok.id_typ_calc		=	'-PC'
			AND	dp_delok.id_code_car		=	'DELOK'

			INNER JOIN sysadm.det_pro	AS dp_priorite
			ON s.id_prod = dp_priorite.id_prod
			-- priorité
			AND	dp_priorite.id_typ_code_dp	=	'-DP'
			AND	dp_priorite.id_code_dp		=	75
			AND	dp_priorite.id_typ_calc		=	'-XX'

			INNER JOIN sysadm.div_sin AS ds_cra_suivi_imei
			ON s.id_sin = ds_cra_suivi_imei.id_sin
			-- demande de controle imei en cours
			AND	ds_cra_suivi_imei.nom_zone	=	'cra_suivi_imei'
			AND	ds_cra_suivi_imei.val_nbre	=	1

			INNER JOIN sysadm.div_sin AS ds_cra_cpt_dmde
			ON s.id_sin = ds_cra_cpt_dmde.id_sin
			-- compteur de demande inférieur à 4
			AND	ds_cra_cpt_dmde.nom_zone	=	'cra_cpt_dmde'
			AND	ds_cra_cpt_dmde.val_nbre	<=	4

			INNER JOIN sysadm.div_sin AS ds_cra_dat_gen
			ON s.id_sin = ds_cra_dat_gen.id_sin
			-- date de génération du fichier
			AND	ds_cra_dat_gen.nom_zone		=	'cra_dat_gen'

			WHERE	s.num_port	IS NOT NULL
			AND	s.num_imei_port	IS NOT NULL
			--1	Bloqué	/	200	Refusé	/	600	Réglé	/	900	Sans	suite
			AND	s.cod_etat	NOT IN	( 1,	900,	600,	200 )

			-- si la date du jour est supérieur ou égale à la date de génération du fichier + le delai de forcage
			AND	DATEDIFF ( day, ds_cra_dat_gen.val_dte + dp_delok.val_num, getdate() )	>=	0

			-- prise en charge des dossiers dont la creation est superieure à la date de mise en production
			AND	s.cree_le	>=	@dtMEP
			-- [CRAO_LOT1.005] Si le sisnitre est DEJA dans la table de traitement, on l'exclu.
			AND	s.id_sin NOT IN 
				(
					select cite.id_sin 
					from cra_imei_trt_export cite
				)

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
			SET @sMessErreur = 'ERREUR - INSERT cra_imei_trt_export'
		END
		ELSE
			COMMIT TRAN
	END
END

GO

----------------------------------------------------------------------------------------------------------------------------------------
-- Procedure	:	PS_CRA_IMEI
-- Commentaires	:	Procedure de récupération des traitements à effectuer
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CRA_IMEI' AND type = 'P' )
	DROP PROCEDURE sysadm.PS_CRA_IMEI
GO

CREATE PROCEDURE sysadm.PS_CRA_IMEI
	@sMessErreur	varchar(255) OUTPUT
AS

DECLARE
	-- Variable du curseur
	@sTraitement	varchar(1),
	@iIdSin		decimal(10,0),   -- [PI062]
	@iIdProd	decimal(7,0),
	@sNomPrenom	varchar(71),
	@dtDteSurv	datetime,
	@sNumImeiPort	varchar(25),
	@sNumPort	varchar(25),
	@iCraCptDmde	integer,

	-- Utilisateur
	@sCrao		varchar(4),
	@sSql		varchar(4),

	-- Variable de la trace
	@dtDate		datetime,
	@sIdTypCodeT	varchar(3),
	@sIdCodeAction	varchar(6),
	@sValAction	varchar(25),

	-- Paramétrage du sinistre (div_sin)
	@sAltProt	varchar(1),
	@dtCraDatGen	datetime,

	-- Variable pour la création du contact avec travail
	@iIdAppli	integer,
	@sMess		varchar(254),
	@iRet		integer,
	@sErr		varchar(60),
	@sMessContact	varchar(255),
	@iAltWSin	integer

-- gestion erreur
SET 	@sMessErreur = 'OK'

-- Utilisateur
SET	@sCrao	=	'CRAO'
SET	@sSql	=	'SQLS'

SET	@dtDate	=	getdate()

-- Affection des variables pour les traces
SET	@sIdTypCodeT	=	'-SC'
SET	@sValAction	=	CONVERT ( varchar(25), getdate(), 121 )

-- Affectation de création de contact
-- application SIMPA2
SET	@iIdAppli	=	2
SET	@sErr		=	SPACE(60)
SET	@sMess		=	'Travail créé par la procédure de controle IMEI'

-- Protection des champs dans div_sin
SET	@sAltProt	=	'O'
SET	@dtCraDatGen	=	getdate()

-- Pas d'affichage des resultat
SET NOCOUNT ON

-- Process standard
DECLARE	cursor_trt_cra	CURSOR	FOR
SELECT	traitement,
	id_sin,
	id_prod,
	nom_prenom,
	dte_surv,
	num_imei_port,
	num_port,
	cra_cpt_dmde
FROM	sysadm.cra_imei_trt_export
WHERE	code_pos IS NULL

OPEN cursor_trt_cra

FETCH NEXT FROM cursor_trt_cra
INTO	@sTraitement,
	@iIdSin,
	@iIdProd,
	@sNomPrenom,
	@dtDteSurv,
	@sNumImeiPort,
	@sNumPort,
	@iCraCptDmde

WHILE @@FETCH_STATUS = 0
BEGIN

	SET @iRet = 0
	
	SELECT @iAltWSin = count(*)
	FROM sysadm.w_sin
	WHERE id_sin = @iIdSin

	-- Début transaction ligne à ligne
	BEGIN TRAN

	-- demande de controle
	IF @sTraitement = '1'
	BEGIN

		-- [CRAO_LOT1.006] Correction de la gestion Iret + gestion rejet si numport erroné
		-- On vérifie que les numéro de portables sont bien formés: Longueur = 10 et numport commencant par '06'
		-- Si anomalie => rejet
		-- [NUM_TEL_07]
		IF LEN(LTRIM(RTRIM(@sNumPort))) <> 10 OR SUBSTRING(LTRIM(@sNumPort),1,2) not in ('06','07')
		BEGIN
			SET @sMessErreur = 'ATTENTION : Sinistre :' + cast(@iIdSin as varchar(10)) + ', No de portable errone ( '+ sysadm.FN_TRIM(@sNumPort) + ') => Dossier non envoye.'
			SET @iRet = -2 -- Code -2 => REJET, uniquement signalé dans le fichier de rejet, pas de mise en rejet dans div_sin/w_div_sin
		END

		-- Mise à jour de la zone cra_ctrl_imei à non
		UPDATE	sysadm.div_sin
		SET	val_car	=	'N',
			maj_le	=	@dtDate,
			maj_par =	@sSql
		WHERE	id_sin	=	@iIdSin
		AND	nom_zone	=	'cra_ctrl_imei'

		IF @@ROWCOUNT <> 1
		BEGIN
			SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_ctrl_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_car = N'
			SET @iRet = -1
		END

		-- Mise à jour de la zone cra_ctrl_imei à non
		IF @iAltWSin > 0 and @iRet = 0 -- [CRAO_LOT1.006] Correction de la gestion Iret + gestion rejet si numport erroné
		BEGIN
			UPDATE	sysadm.w_div_sin
			SET	cpt_valide	=	1,
				val_car		=	'N',
				maj_le		=	@dtDate,
				maj_par 	=	@sSql
			WHERE	id_sin		=	@iIdSin
			AND	nom_zone	=	'cra_ctrl_imei'

			IF @@ROWCOUNT <> 1
			BEGIN
				SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_ctrl_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_car = N'
				SET @iRet = -1
			END
		END

		-- Incrementation de la zone cra_cpt_dmde
		IF @iRet = 0 -- [CRAO_LOT1.006] Correction de la gestion Iret + gestion rejet si numport erroné
		BEGIN
			IF ( @iCraCptDmde ) IS NULL
			BEGIN
				INSERT	sysadm.div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_nbre, cree_le, maj_le, maj_par, valide_le, valide_par )
					SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, 1, @dtDate, @dtDate, @sSql, @dtDate, @sSql
					FROM	div_pro dp
					WHERE	dp.id_prod	=	@iIdProd
					AND	dp.nom_zone	=	'cra_cpt_dmde'
	
				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - INSERT div_sin pour nom_zone = cra_cpt_dmde et id_sin = ' + cast(@iIdSin as varchar(10))
					SET @iRet = -1
				END
	
				IF @iAltWSin > 0 and @iRet = 0 -- [CRAO_LOT1.006] Correction de la gestion Iret + gestion rejet si numport erroné
				BEGIN
					INSERT	sysadm.w_div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_nbre, cpt_valide, cree_le, maj_le, maj_par )
						SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, 1, 1, @dtDate, @dtDate, @sSql
						FROM	div_pro dp
						WHERE	dp.id_prod	=	@iIdProd
						AND	dp.nom_zone	=	'cra_cpt_dmde'
	
					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - INSERT w_div_sin pour nom_zone = cra_cpt_dmde et id_sin = ' + cast(@iIdSin as varchar(10))
						SET @iRet = -1
					END
				END
			END
			ELSE
			BEGIN
				UPDATE	sysadm.div_sin
				SET	val_nbre	=	val_nbre + 1,
					maj_le		=	@dtDate,
					maj_par 	=	@sSql
				WHERE	id_sin		=	@iIdSin
				AND	nom_zone	=	'cra_cpt_dmde'
	
				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_cpt_dmde et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_nbre = val_nbre + 1'
					SET @iRet = -1
				END
	
				IF @iAltWSin > 0 and @iRet = 0 -- [CRAO_LOT1.006] Correction de la gestion Iret + gestion rejet si numport erroné
				BEGIN
					UPDATE	sysadm.w_div_sin
					SET	cpt_valide	=	1,
						val_nbre	=	val_nbre + 1,
						maj_le		=	@dtDate,
						maj_par 	=	@sSql
					WHERE	id_sin		=	@iIdSin
					AND	nom_zone	=	'cra_cpt_dmde'
	
					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_cpt_dmde et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_nbre = val_nbre + 1'
						SET @iRet = -1
					END
				END
			END
		END
		-- Mise à jour de la zone cra_suivi_imei
		IF @iRet = 0 -- [CRAO_LOT1.006] Correction de la gestion Iret + gestion rejet si numport erroné
		BEGIN
			IF ( @iCraCptDmde ) IS NULL
			BEGIN
				INSERT	sysadm.div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_nbre, cree_le, maj_le, maj_par, valide_le, valide_par )
				SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, 1, @dtDate, @dtDate, @sSql, @dtDate, @sSql
				FROM	sysadm.div_pro dp
				WHERE	dp.id_prod	=	@iIdProd
				AND	dp.nom_zone	=	'cra_suivi_imei'
	
				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - INSERT div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10))
					SET @iRet = -1
				END
	
				IF @iAltWSin > 0 and @iRet = 0 -- [CRAO_LOT1.006] Correction de la gestion Iret + gestion rejet si numport erroné
				BEGIN
					INSERT	sysadm.w_div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_nbre, cpt_valide, cree_le, maj_le, maj_par )
						SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, 1, 1, @dtDate, @dtDate, @sSql
						FROM	sysadm.div_pro dp
						WHERE	dp.id_prod	=	@iIdProd
						AND	dp.nom_zone	=	'cra_suivi_imei'
	
					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - INSERT w_div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10))
						SET @iRet = -1
					END
				END
			END
			ELSE
			BEGIN
				UPDATE	sysadm.div_sin
				SET	val_nbre	=	1,
					maj_le		=	@dtDate,
					maj_par 	=	@sSql
				WHERE	id_sin		=	@iIdSin
				AND	nom_zone	=	'cra_suivi_imei'
	
				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_car = 1'
					SET @iRet = -1
				END
	
				IF @iAltWSin > 0 and @iRet = 0 -- [CRAO_LOT1.006] Correction de la gestion Iret + gestion rejet si numport erroné
				BEGIN
					UPDATE	sysadm.w_div_sin
					SET	cpt_valide	=	1,
						val_nbre	=	1,
						maj_le		=	@dtDate,
						maj_par 	=	@sSql
					WHERE	id_sin		=	@iIdSin
					AND	nom_zone	=	'cra_suivi_imei'
	
					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_car = 1'
						SET @iRet = -1
					END
				END
			END
		END

		/* */
		/* Mise à jour de la zone cra_dat_gen */
		/* Dans le cas de remise à NULL via PB et du fait de la jointure externe pour avoir les sinistres concerné */
		/* on ne sait pas faire le distingo entre la non existence de la ligne et la valeur de la zone [cra_dat_gen] à NULL dans la table de traitement */
		/* d'ou le controle sur la table [div_sin].*/
		/* */

		IF @iRet = 0 -- [CRAO_LOT1.006] Correction de la gestion Iret + gestion rejet si numport erroné
		BEGIN
			IF ( SELECT count(*) FROM sysadm.div_sin WHERE id_sin = @iIdSin AND nom_zone = 'cra_dat_gen' ) = 0
			BEGIN
				INSERT	sysadm.div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cree_le, maj_le, maj_par, valide_le, valide_par )
				SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, @dtCraDatGen, @dtDate, @dtDate, @sSql, @dtDate, @sSql
				FROM	sysadm.div_pro dp
				WHERE	dp.id_prod	=	@iIdProd
				AND	dp.nom_zone	=	'cra_dat_gen'
	
				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - INSERT div_sin pour nom_zone = cra_dat_gen et id_sin = ' + cast(@iIdSin as varchar(10))
					SET @iRet = -1
				END
	
				IF @iAltWSin > 0
				BEGIN
					INSERT	sysadm.w_div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cpt_valide, cree_le, maj_le, maj_par )
						SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, @dtCraDatGen, 1, @dtDate, @dtDate, @sSql
						FROM	sysadm.div_pro dp
						WHERE	dp.id_prod	=	@iIdProd
						AND	dp.nom_zone	=	'cra_dat_gen'
	
					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - INSERT w_div_sin pour nom_zone = cra_dat_gen et id_sin = ' + cast(@iIdSin as varchar(10))
						SET @iRet = -1
					END
				END
			END
			ELSE
			BEGIN
				UPDATE	sysadm.div_sin
				SET	val_dte		=	@dtCraDatGen,
					maj_le		=	@dtDate,
					maj_par 	=	@sSql
				WHERE	id_sin		=	@iIdSin
				AND	nom_zone	=	'cra_dat_gen'
	
				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_dat_gen et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = ' + cast(@dtCraDatGen as varchar(25))
					SET @iRet = -1
				END
	
				IF @iAltWSin > 0
				BEGIN
					UPDATE	sysadm.w_div_sin
					SET	cpt_valide	=	1,
						val_dte		=	@dtCraDatGen,
						maj_le		=	@dtDate,
						maj_par 	=	@sSql
					WHERE	id_sin		=	@iIdSin
					AND	nom_zone	=	'cra_dat_gen'
	
					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_dat_gen et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = ' + cast(@dtCraDatGen as varchar(25))
						SET @iRet = -1
					END
				END
			END
		END

		-- permet d'avoir la date de generation du fichier
		IF @iRet = 0 -- [CRAO_LOT1.006] Correction de la gestion Iret + gestion rejet si numport erroné
		BEGIN
			UPDATE	sysadm.cra_imei_trt_export
			SET	cra_dat_gen	=	@dtCraDatGen
			WHERE	id_sin		=	@iIdSin
	
			IF @@ROWCOUNT <> 1
			BEGIN
				SET @sMessErreur = 'ERREUR - UPDATE cra_imei_trt_export pour nom_zone = cra_dat_gen et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = ' + cast(@dtCraDatGen as varchar(25))
				SET @iRet = -1
			END
		END

		-- GESTION DE LA TRACE
		IF @iRet = 0 -- [CRAO_LOT1.006] Correction de la gestion Iret + gestion rejet si numport erroné
		BEGIN
			SET	@sIdCodeAction	=	'GENFIC'
			EXEC sysadm.PS_I01_TRACE_CRA_IMEI @iIdSin, @dtDate, @sNumImeiPort, @sNumPort, @sIdTypCodeT, @sIdCodeAction, @sValAction
			IF @@ERROR <> 0
			BEGIN
				SET @sMessErreur = 'ERREUR - PS_I01_TRACE_CRA_IMEI avec id_sin = ' + cast(@iIdSin as varchar(10)) + ' et id_code_action = ' + @sIdCodeAction
				SET @iRet = -1
			END
		END
	END

 	-- relance
	ELSE IF @sTraitement = '2'
	BEGIN
		-- GESTION DE LA TRACE
		SET	@sIdCodeAction	=	'REL'
		EXEC sysadm.PS_I01_TRACE_CRA_IMEI @iIdSin, @dtDate, @sNumImeiPort, @sNumPort, @sIdTypCodeT, @sIdCodeAction, @sValAction
		IF @@ERROR <> 0
		BEGIN
			SET @sMessErreur = 'ERREUR - PS_I01_TRACE_CRA_IMEI avec id_sin = ' + cast(@iIdSin as varchar(10)) + ' et id_code_action = ' + @sIdCodeAction
			SET @iRet = -1
		END
	END

	-- forçage
	ELSE IF @sTraitement = '3'
	BEGIN
		-- Création d'un contact avec travail
		SET	@sMessContact = 'Controle IMEI Ok.'
		EXEC @iRet = sysadm.PS_CRA_IMEI_CONTACT_TRAVAIL 'E', null, @iIdSin, null, @sMessContact, @sMessErreur OUTPUT
		IF @iRet <> 0
		BEGIN
			SET @sMessErreur = 'PS_I04_CONTACT_TRAVAIL id_sin = ' + cast(@iIdSin as varchar(10)) + ', message d''erreur : ' + @sMessErreur
			SET @iRet = -2
		END
		
		IF @iRet = 0
		BEGIN
			-- Mise à jour de la zone cra_suivi_imei
			UPDATE	sysadm.div_sin
			SET	val_nbre	=	2,
				maj_le		=	@dtDate,
				maj_par 	=	@sSql
			WHERE	id_sin		=	@iIdSin
			AND	nom_zone	=	'cra_suivi_imei'

			IF @@ROWCOUNT <> 1
			BEGIN
				SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_car = 2'
				SET @iRet = -1
			END
		END

		IF @iAltWSin > 0 AND @iRet = 0
		BEGIN
			UPDATE	sysadm.w_div_sin
			SET	cpt_valide	=	1,
				val_nbre	=	2,
				maj_le		=	@dtDate,
				maj_par 	=	@sSql
			WHERE	id_sin		=	@iIdSin
			AND	nom_zone	=	'cra_suivi_imei'

			IF @@ROWCOUNT <> 1
			BEGIN
				SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_car = 2'
				SET @iRet = -1
			END
		END

		IF @iRet = 0
		BEGIN
			-- GESTION DE LA TRACE
			SET	@sIdCodeAction	=	'FOR_OK'
			EXEC sysadm.PS_I01_TRACE_CRA_IMEI @iIdSin, @dtDate, @sNumImeiPort, @sNumPort, @sIdTypCodeT, @sIdCodeAction, @sValAction
			IF @@ERROR <> 0
			BEGIN
				SET @sMessErreur = 'ERREUR - PS_I01_TRACE_CRA_IMEI avec id_sin = ' + cast(@iIdSin as varchar(10)) + ' et id_code_action = ' + @sIdCodeAction
				SET @iRet = -1
			END
		END

		IF @iRet = 0
		BEGIN
			SET	@sIdCodeAction	=	'CTOK'
			EXEC sysadm.PS_I01_TRACE_CRA_IMEI @iIdSin, @dtDate, @sNumImeiPort, @sNumPort, @sIdTypCodeT, @sIdCodeAction, '00/00/0000'
			IF @@ERROR <> 0
			BEGIN
				SET @sMessErreur = 'ERREUR - PS_I01_TRACE_CRA_IMEI avec id_sin = ' + cast(@iIdSin as varchar(10)) + 'et id_code_action = ' + @sIdCodeAction
				SET @iRet = -1
			END
		END
	END
 
	IF @iRet = 0
	BEGIN
		UPDATE	sysadm.cra_imei_trt_export
		SET	code_pos	=	'*'
		WHERE	id_sin		=	@iIdSin

		IF @@ROWCOUNT <> 1
		BEGIN
			SET @sMessErreur = 'ERREUR - UPDATE cra_imei_trt_export pour code_pos = * et id_sin = ' + cast( @iIdSin as varchar(10) )
			SET @iRet = -3
			BREAK
		END

		COMMIT TRAN
	END

	ELSE IF @iRet = -1
	BEGIN
		ROLLBACK TRAN

		INSERT sysadm.cra_imei_rejet ( type_trait, id_sin, num_imei_port, num_port, date_rejet, message_rejet, type_rejet )
		VALUES ( 'E', @iIdSin, @sNumImeiPort, @sNumPort, @dtDate, @sMessErreur, 'I' )
		
		BREAK
	END

	ELSE IF @iRet = -2
	BEGIN
		ROLLBACK TRAN
		
		UPDATE	sysadm.cra_imei_trt_export
		SET	code_pos	=	'R'
		WHERE	id_sin		=	@iIdSin

		INSERT sysadm.cra_imei_rejet ( type_trait, id_sin, num_imei_port, num_port, date_rejet, message_rejet, type_rejet )
		VALUES ( 'E', @iIdSin, @sNumImeiPort, @sNumPort, @dtDate, @sMessErreur, 'F' )
	END

	FETCH NEXT FROM cursor_trt_cra
	INTO	@sTraitement,
		@iIdSin,
		@iIdProd,
		@sNomPrenom,
		@dtDteSurv,
		@sNumImeiPort,
		@sNumPort,
		@iCraCptDmde
END
-- Fin de boucle while

CLOSE cursor_trt_cra
DEALLOCATE cursor_trt_cra

IF @iRet = -3
	ROLLBACK TRAN


GO

----------------------------------------------------------------------------------------------------------------------------------------
-- Procedure	:	PS_I01_TRACE_CRA_IMEI
-- Commentaires     : 	Procedure principale appele tous les jours
-------------------------------------------------------------------
-- Gestion des traces du traitement de controle des IMEI
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_TRACE_CRA_IMEI' AND type = 'P' )
	DROP PROCEDURE sysadm.PS_I01_TRACE_CRA_IMEI
GO

CREATE PROCEDURE sysadm.PS_I01_TRACE_CRA_IMEI
	@dIdSin		decimal(10,0),  -- [PI062]
	@dtDatLog	datetime,
	@sNumImeiPort	varchar(25),
	@sNumPort	varchar(25),
	@sIdTypCode	varchar(3),
	@sIdCodeAction	varchar(6),
	@sValAction	varchar(25)

AS

-- Pas d'affichage des resultat
SET NOCOUNT ON

INSERT INTO sysadm.trace_cra_imei
VALUES	(	@dIdSin,
		@dtDatLog,
		@sNumImeiPort,
		@sNumPort,
		@sIdTypCode,
		@sIdCodeAction,
		@sValAction
	)
GO

----------------------------------------------------------------------------------------------------------------------------------------
-- Procedure	:	TR_I01_DIV_SIN
-- Commentaires	:	Trigger de mise à jour de la table trace
-------------------------------------------------------------------
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_I01_DIV_SIN' AND type = 'TR' )
        DROP trigger sysadm.TR_I01_DIV_SIN
GO

CREATE TRIGGER sysadm.TR_I01_DIV_SIN
            ON sysadm.div_sin
    FOR INSERT, UPDATE
AS

DECLARE
	@sNomZone	varchar(35),
	@sValCar	varchar(35),
	@iIdSin		decimal(10,0),
	@dtDate		datetime,
	@sNumImeiPort	varchar(25),
	@sNumPort	varchar(25),
	@sIdTypCodeT	varchar(3),
	@sIdCodeAction	varchar(6),
	@sValAction	varchar(25)

SET	@dtDate		=	getdate()
SET	@sIdCodeAction	=	'DCTRL'
SET 	@sIdTypCodeT	=	'-SC'

IF UPDATE ( val_car ) AND ( SELECT count(nom_zone) FROM inserted ds WHERE ds.nom_zone = 'cra_ctrl_imei'AND ds.val_car = 'O' ) = 1
BEGIN
	SELECT	@sNomZone	=	ds.nom_zone,
		@sValCar	=	ds.val_car,
		@iIdSin		=	s.id_sin,
		@sNumImeiPort	=	left(s.num_imei_port, 25), -- [DCMP100420]
		@sNumPort	=	s.num_port,
		@sValAction	=	ds.maj_par
	FROM	inserted	ds
	INNER JOIN sysadm.sinistre as s
	ON s.id_sin = ds.id_sin
	WHERE	ds.nom_zone	=	'cra_ctrl_imei'
	AND	ds.val_car	=	'O'

	IF @@ROWCOUNT > 0
		EXEC sysadm.PS_I01_TRACE_CRA_IMEI @iIdSin, @dtDate, @sNumImeiPort, @sNumPort, @sIdTypCodeT, @sIdCodeAction, @sValAction
END

GO
