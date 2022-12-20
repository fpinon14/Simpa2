 
----------------------------------------------------------------------------------------------------------------------------------------
-- Fichier	:	CAIMEI_LOT2.CP
-- Commentaires	: 	Comprends toutes les procedures servant à la gestion de l'import du contrôle imei
-- Procédure	:	PS_CRA_IMEI_CONTACT_TRAVAIL
--		:	PS_CRA_IMEI_TRT_RELICAT
--		:	PS_CRA_IMEI_IMPORT_TRT
--		:	PS_CRA_IMEI_IMPORT_FIC_V01
--		:	PS_CRA_IMEI_IMPORT_CTRL_FIC_V01
--		:	PS_CRA_IMEI_IMPORT
--		:	PS_CRA_IMEI_TRT_3X_REFUS
--      :   PS_I01_CRA_IMEI_REJET
-------------------------------------------------------------------
-- Modifications :
-- [CRAO_LOT2.007]	PHG	26/02/2007
--			La détermination de l'IdGti et de la date de survenance dans 
--			PS_CRA_IMEI_IMPORT_FIC est erronée.
--			-> Selection idépendante de dte_surv et d'indicateur de id_gti = 11
-- [DCMP070214]		PHG 	23/03/2007	Evolution : Gestion de la date de Souscription +
--						Optimisation : Créatino de deux tratiement générique 
--						- Demande de 2eme controle
--						- Refus.
--						
-------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------------------
-- Procedure	:	PS_CRA_IMEI_CONTACT_TRAVAIL
-- Commentaires	:	Procedure de création de travail et de contact
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CRA_IMEI_CONTACT_TRAVAIL' AND type = 'P' )
	DROP PROCEDURE sysadm.PS_CRA_IMEI_CONTACT_TRAVAIL
GO

CREATE PROCEDURE sysadm.PS_CRA_IMEI_CONTACT_TRAVAIL
	@sAction	varchar(1),
	@iIdTypTrait	integer,
	@iIdSin		decimal(10,0),  -- [PI062]
	@iIdProd	decimal(7,0),
	@sMessContact	varchar(254),
	@sMessErreur	varchar(255) OUTPUT
AS

DECLARE	@iIdAppli	integer,
	@sErr		varchar(60),
	@iErr		integer,
	@sCrao		varchar(4),
	@sOper		varchar(4),
	@iIdCt		integer

SET	@sMessErreur	= SPACE(255)
-- Utilisateur en export
SET	@sCrao		=	'CRAO'

-- Affectation de création de contact -- application SIMPA2
SET	@iIdAppli	=	2
SET	@sErr		=	SPACE(60)
SET	@iErr		=	0

-- Export
IF @sAction = 'E'
BEGIN

	-- on regarde si le serveur utilisé est un serveur de production
	IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
		EXEC @iErr = SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @iIdSin, @iIdAppli, @sMessContact, @sCrao, @sErr OUTPUT, @iIdCt OUTPUT
	ELSE
		EXEC @iErr = SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @iIdSin, @iIdAppli, @sMessContact, @sCrao, @sErr OUTPUT, @iIdCt OUTPUT
		
	IF UPPER ( @sErr ) <> 'OK'
	BEGIN
		SET @sMessErreur = 'ERREUR PS_I04_CONTACT_TRAVAIL - Echec de création de contact - message erreur : ' + @sErr
		SET @iErr = -1
	END
END

-- Import
ELSE IF @sAction = 'I'
BEGIN

	-- print 'PS_TRT_AFFECTATION_OPERATEUR_V01'
	
	-- on regarde si le serveur utilisé est un serveur de production
	IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
		-- réaffectation des travaux en relicat pour l'utilisateur CRAO
		EXEC @iErr = SHERPA_PRO.sysadm.PS_TRT_AFFECTATION_OPERATEUR_V01 @iIdTypTrait, @iIdProd, @sOper OUTPUT, @sMessErreur OUTPUT
	ELSE
		-- réaffectation des travaux en relicat pour l'utilisateur CRAO
		EXEC @iErr = SHERPA_SIM.sysadm.PS_TRT_AFFECTATION_OPERATEUR_V01 @iIdTypTrait, @iIdProd, @sOper OUTPUT, @sMessErreur OUTPUT

	IF @iErr = -1
	BEGIN
		-- print 'Erreur : PS_TRT_AFFECTATION_OPERATEUR_V01'
		
		SET @sMessErreur = 'ERREUR PS_TRT_AFFECTATION_OPERATEUR_V01 : ' + @sMessErreur
		SET @iErr = -1
	END

	ELSE
	BEGIN

		/* */
		/* on reinitialise le code retour de la procedure à 0 */
		/* car la proc PS_TRT_AFFECTATION_OPERATEUR_V01 retourne 1 si tout se passe bien */
		/* */
		SET @iErr = 0

		-- print 'PS_I04_CONTACT_TRAVAIL'
		
		-- on regarde si le serveur utilisé est un serveur de production
		IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
			EXEC @iErr = SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @iIdSin, @iIdAppli, @sMessContact, @sOper, @sErr OUTPUT, @iIdCt OUTPUT
		ELSE
			EXEC @iErr = SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @iIdSin, @iIdAppli, @sMessContact, @sOper, @sErr OUTPUT, @iIdCt OUTPUT
		
		-- print '@iErr  : ' + cast (@iErr as varchar(5)) + '@sErr  : ' + @sErr 

		IF UPPER ( @sErr ) <> 'OK'
		BEGIN
		
			-- print 'Erreur : PS_TRT_AFFECTATION_OPERATEUR_V01'
			
			SET @sMessErreur = 'ERREUR PS_I04_CONTACT_TRAVAIL : ' + @sErr
			SET @iErr = -1
		END
	END
END

RETURN @iErr
GO


----------------------------------------------------------------------------------------------------------------------------------------
-- Procedure		:	PS_CRA_IMEI_TRT_RELICAT
-- Commentaires		:	Procedure 
-------------------------------------------------------------------
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CRA_IMEI_TRT_RELICAT' AND type = 'P' )
	DROP PROCEDURE sysadm.PS_CRA_IMEI_TRT_RELICAT
GO

CREATE PROCEDURE sysadm.PS_CRA_IMEI_TRT_RELICAT
	@iIdTypTrait	integer,
	@sMessErreur	varchar(255) OUTPUT
AS

DECLARE	
	@iIdSin			integer,
	@iIdProd		integer,
	@iIdContact		integer,
	@iIdCli			integer,
	@sOper			varchar(4),
	@iRet			integer,
	@sDateRejet		varchar(23)

SET @sMessErreur	= SPACE(255)
SET @sOper		= SPACE(4)
SET @iRet		= 0
SET @sDateRejet		= cast(getdate() as varchar(23))

SET NOCOUNT ON

-- on regarde si le serveur utilisé est un serveur de production
IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	EXEC @iRet = SHERPA_PRO.sysadm.PS_INITIALISER_AFFECTATION_OPERATEUR_V01 @iIdTypTrait, @sMessErreur OUTPUT
ELSE
	EXEC @iRet = SHERPA_SIM.sysadm.PS_INITIALISER_AFFECTATION_OPERATEUR_V01 @iIdTypTrait, @sMessErreur OUTPUT

-- print @iRet
-- print @sMessErreur

IF @iRet = 1 and UPPER(SUBSTRING(@sMessErreur,1,2)) = 'OK' -- [CRAO_LOT2.003] Modification gestion du retour Erreur
BEGIN

	/* */
	/* on reinitialise le code retour de la procedure à 0 */
	/* car la proc PS_INITIALISER_AFFECTATION_OPERATEUR_V01 retourne 1 si tout se passe bien */
	/* */
	SET @iRet = 0

	DECLARE	cursor_cra_relicat	CURSOR	FOR
	SELECT	id_sin,
		id_prod,
		id_contact
	FROM	sysadm.w_queue
	WHERE	dos_maj_par	= 'CRAO'

	OPEN cursor_cra_relicat

	FETCH NEXT FROM cursor_cra_relicat
	INTO	@iIdSin,
		@iIdProd,
		@iIdContact

	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- print '@iIdSin : ' + cast ( @iIdSin as  varchar(10)) + '@iIdProd : ' + cast(@iIdProd as  varchar(10)) + '@iIdContact : ' + cast(@iIdContact as varchar(20))
		
		/* */
		/* on reinitialise le code retour de la procedure à 0 */
		/* pour chaque tour de boucle */
		/* */
		SET @iRet = 0

		-- début transaction
		BEGIN TRAN
		
		-- print 'PS_TRT_AFFECTATION_OPERATEUR_V01'
		-- on regarde si le serveur utilisé est un serveur de production
		IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
			-- réaffectation des travaux en relicat pour l'utilisateur CRAO
			EXEC @iRet = SHERPA_PRO.sysadm.PS_TRT_AFFECTATION_OPERATEUR_V01 @iIdTypTrait, @iIdProd, @sOper OUTPUT, @sMessErreur OUTPUT
		ELSE
			-- réaffectation des travaux en relicat pour l'utilisateur CRAO
			EXEC @iRet = SHERPA_SIM.sysadm.PS_TRT_AFFECTATION_OPERATEUR_V01 @iIdTypTrait, @iIdProd, @sOper OUTPUT, @sMessErreur OUTPUT
		
		-- print @iRet
		-- print @sMessErreur

		IF @iRet = -1
		BEGIN
			ROLLBACK TRAN
			
			INSERT sysadm.cra_imei_rejet ( type_trait, id_sin, date_rejet, message_rejet, type_rejet )
			VALUES ( 'I', @iIdSin, @sDateRejet, 'Réaffectation en erreur : ' + @sMessErreur, 'I' )
		END
		
		ELSE
		BEGIN
			/* */
			/* on reinitialise le code retour de la procedure à 0 */
			/* car la proc PS_TRT_AFFECTATION_OPERATEUR_V01 retourne 1 si tout se passe bien */
			/* */
			SET @iRet = 0

			IF @sOper <> 'CRAO'
			BEGIN
				
				-- print 'PS_U01_CONTACT_GED'

				-- mise à jour du travail de simpa et du contact de sherpa
				IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
					SELECT	@iIdCli	=	id_cli
					FROM	SHERPA_PRO.sysadm.sinistre ws
					WHERE	ws.id_sin = @iIdSin
				ELSE
					SELECT	@iIdCli	=	id_cli
					FROM	SHERPA_SIM.sysadm.sinistre ws
					WHERE	ws.id_sin = @iIdSin

				-- on regarde si le serveur utilisé est un serveur de production
				IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
					EXEC @iRet = SHERPA_PRO.sysadm.PS_U01_CONTACT_GED @iIdCli, @iIdContact, @iIdSin, @sOper, @sMessErreur OUTPUT
				ELSE
					EXEC @iRet = SHERPA_SIM.sysadm.PS_U01_CONTACT_GED @iIdCli, @iIdContact, @iIdSin, @sOper, @sMessErreur OUTPUT
				
				-- print @iRet
				-- print @sMessErreur
				
				IF @iRet <> 0 AND @@ERROR <> 0
				BEGIN
					ROLLBACK TRAN
					
					SET @iRet = -1
					
					INSERT sysadm.cra_imei_rejet ( type_trait, id_sin, date_rejet, message_rejet, type_rejet )
					VALUES ( 'I', cast(@iIdSin as varchar(10)), @sDateRejet, 'Mise à jour du contact/travail en erreur : ' + @sMessErreur, 'I' )
				END
			END
		END
		
		IF @iRet = 0
		BEGIN
			-- print 'COMMIT TRAN'
			COMMIT TRAN
		END
		
		FETCH NEXT FROM cursor_cra_relicat
		INTO	@iIdSin,
			@iIdProd,
			@iIdContact

	END
	-- Fin de boucle while

	CLOSE cursor_cra_relicat
	DEALLOCATE cursor_cra_relicat
END

RETURN @iRet

GO

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CRA_IMEI_IMPORT_TRT' AND type = 'P' )
	DROP PROCEDURE sysadm.PS_CRA_IMEI_IMPORT_TRT
GO

CREATE PROCEDURE sysadm.PS_CRA_IMEI_IMPORT_TRT
	@sCcimei		varchar(50),
	@sNomFic		varchar(35),
	@sMessErreur		varchar(255) OUTPUT
AS

--------------------------------------------------------------------
--
--        !!!! ATTENTION DEBUT DE LA PROCEDURE CI-DESSUS !!!!
--	  ( Les commentaires sont inclus dans la procédures )
--
-- Procédure            :   PS_CRA_IMEI_IMPORT_TRT
-- Auteur               :   
-- Date                 :   14/02/2007
-- Libellé              :   Procedure de traitement du fichier d'import 
-- Commentaires         :   Mise à jour des tables de gestion
-- Références           :   cra_imei_trt_import, div_sin, w_divsin
--
-- Arguments            :   @sCcimei		varchar(50)		Centre Technique de Controle IMEI
--			    @sNomFic		varchar(35)		Nom du Fichier Traité
--			    @sMessErreur	varchar(255) OUTPUT	byREf : Message d'erreur retourné.
--
-- Retourne             :   Code retour T-SQL Standard
--				  
--------------------------------------------------------------------
-- MAJ	PAR	LE		TAG		Description
-- #1	PHG	23/03/2007	[DCMP070214]	Refus sur Date de Sous > Date Dernière Utilisation.
--						Début d'optimisation de cette procédure :
--						- Création d'un traitement générique '21'
--							-> Dmde de 2eme Controle.
--						- Appel au traitement générique de refus
--						- Ajout de Commentaires d'optimisation.
-- JFF      12/02/2016   [PI062]
--------------------------------------------------------------------
-- Commentaire pour améliorer cette procédure :
-- Créer 2 traitements génériques paramétrable +
-- 2 groupe de Traitement, 1 pour refus , l'autre pour rejet, chacun des trt appelant une procedure 
-- générique de Refus pour L'un, de rejet pour l'autre : 	
-- '20' : Controle OK ( DDU )
-- '21' : Demande de deuxième Controle ( )
-- '3x' : 	30->39 => Refus
-- '4x' : 	40->49 => Rejet
-- 
-- Pour les traitements génériques 3x et 4x
-- - Inclure au moins les Parametres ( DDU/Code Reponse, Code en '-CR' du Refus )
-- - La détermintation de l'indice est libre
-- Une fois ces traitements réalisés, testés et éprouvés, rediriger les traitements 1 à 13, vers les traitement
-- 20 à 49 suivant les cas fonctionnels, avec les cas adéquats.
-- 
-- De plus, Les operations d'ecriture de champs #<nom de champ># peuvent être factorisé en une seule fonction
-- de mise à jour/insertion de champs div_sin/w_div_sin
--
--------------------------------------------------------------------
-- En cours de L'optimisation :
-- Fait : Analyse Globale : ci-dessus.
-- Fait : Procédure pour les traitement 3x crée : PS_CRA_IMEI_TRT_3X_REFUS
-- En cours : Rien.
-- Planifié : Rien.
--------------------------------------------------------------------


-- variables
DECLARE	@iRet		integer,
	@iIdSeq		integer,
	@sMessContact	varchar(255),
	@dtDate		datetime,
	@iCount		integer, -- #1 [DCMP070214]  PHG Variable de comptage pour detection existence w_div_sin
-- Variable de la trace
	@sIdTypCodeT	varchar(3),
	@sIdCodeAction	varchar(6),
	@sValAction	varchar(25),
-- gestion du curseur
	@iFetch		integer,
	@dtDteEnvoi	datetime,
	@sNomPrenom	varchar(71),	
	@iIdSin		decimal(10,0), -- [PI062]
	@iIdProd	decimal(7,0),
	@dtDteSurvFic	datetime,
	@sNumImeiPort	varchar(25),
	@sNumPort	varchar(25),
	@dtDteSurvBase	datetime,
	@iPeriode	integer,
	@iCodeReponse	integer,
	@dtDteLastUse	datetime,
	@sAltProt	varchar(1),
	@sSql		varchar(4),
	@sTraitement	varchar(2),
	@iAltWSin	integer,
-- Variable pour la gestion des erreurs fonctionelles
	@sReponse	varchar(10)

SET 	@sMessErreur 	= SPACE(255)

SET	@dtDate		= getdate()

/*					*/
/* Affection des variables pour les traces	*/
/*					*/
SET	@sIdTypCodeT	= '-SC'

SET	@sAltProt	= 'N'
SET	@sSql		= 'SQLS'

SET 	@iRet		= 0

SET 	@iCount		= 0 -- #1 [DCMP070214] PHG

SET NOCOUNT ON

	/*					*/ 
	/* Marquage des sinistres en doublons 	*/
	/* afin de les traiter manuellement		*/
	/* On positionne le code_pos à D pour doublon	*/
	/*					*/
BEGIN TRAN

UPDATE  sysadm.cra_imei_trt_import
SET     code_pos = 'D'
WHERE   nom_fic = @sNomFic
AND  	code_pos IS NULL
AND     id_sin IN ( SELECT citi.id_sin 
			FROM sysadm.cra_imei_trt_import AS citi 
			WHERE citi.nom_fic = @sNomFic
			AND   citi.code_pos IS NULL
			GROUP BY citi.id_sin 
			HAVING count ( citi.id_sin ) > 1 
		)
IF @@ERROR <> 0
BEGIN
	/*					*/ 
	/* Gros soucis sur la base		 	*/
	/* suite au retour négatif envoi d'un mail	*/
	/*					*/
	ROLLBACK TRAN
	SET @sMessErreur = 'Echec de la mise à jour de la table [cra_imei_trt_import] suite à la découverte de sinistres en doublons'
	RETURN -1
END
ELSE
BEGIN
	COMMIT TRAN
END

	/*					*/ 
	/* Modification du curseur afin d'ignorer	*/
	/* les sinistres en doublons		*/
	/*					*/
	/*					*/
	/* Définition du curseur			*/
	/*					*/
DECLARE	cursor_cra_trt	CURSOR	FOR
SELECT	citi.id_seq,
	citi.dte_envoi,
	citi.nom_prenom,	
	citi.id_sin,
	citi.dte_surv_fic,
	citi.num_imei_port,
	citi.num_port,
	citi.dte_surv_base,
	citi.periode,
	citi.code_reponse,
	citi.dte_last_use,
	citi.traitement
FROM	sysadm.cra_imei_trt_import citi
WHERE	citi.nom_fic = @sNomFic
AND	citi.code_pos IS NULL

OPEN cursor_cra_trt

FETCH NEXT FROM cursor_cra_trt
INTO	@iIdSeq,
	@dtDteEnvoi,
	@sNomPrenom,	
	@iIdSin,
	@dtDteSurvFic,
	@sNumImeiPort,
	@sNumPort,
	@dtDteSurvBase,
	@iPeriode,
	@iCodeReponse,
	@dtDteLastUse,
	@sTraitement

SET @iFetch = @@FETCH_STATUS

WHILE @@FETCH_STATUS = 0
BEGIN

	-- print  '@sTraitement : ' + @sTraitement + '@sNomFic : ' + @sNomFic + ', @dtDteEnvoi : ' + cast(@dtDteEnvoi as varchar(23)) + ', @sNomPrenom : ' + @sNomPrenom + ', @sIdSin : ' + cast(@iIdSin as varchar(7)) + ', @sDteSurvFic : ' + cast(@dtDteSurvFic as varchar(23)) + ', @sNumImeiPort : ' + @sNumImeiPort + ', @sNumPort : ' + @sNumPort + ', @sReponse : ' + cast(@iCodeReponse as varchar(23))
	
	SET @iRet = 0
	SET @sMessErreur = 'Initialisation du message d''erreur'

	SELECT @iAltWSin = count(*)
	FROM sysadm.w_sin
	WHERE id_sin = @iIdSin

	-- #1 [DCMP070214]  PHG
	SELECT @iCount = count(id_sin)
	FROM sysadm.w_div_sin
	WHERE id_sin = @iIdSin
	--

	/* Code ci-dessous déporté dans la boucle de constitution de la table traitement        
        -- Transaction Unitaire pour valider la réception du fichier dans la trace.
	-- Cette transaction n'est pas encapsulée dans la transaction de la boucle car elle se fait juste
	-- avant le begin tran global de la boucle.
        BEGIN TRAN

	SET	@sIdCodeAction	=	'RECEPT'
	SET	@sValAction	=	CONVERT ( varchar(25), @dtDate, 121 )
	EXEC sysadm.PS_I01_TRACE_CRA_IMEI @iIdSin, @dtDate, @sNumImeiPort, @sNumPort, @sIdTypCodeT, @sIdCodeAction, @sValAction
	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRAN
		SET @sMessErreur = 'ERREUR - PS_I01_TRACE_CRA_IMEI avec id_sin = ' + cast(@iIdSin as varchar(10)) + 'et id_code_action = ' + @sIdCodeAction
		SET @iRet = -1
	END
	ELSE
	BEGIN
		COMMIT TRAN
	END
	-- fin Transaction Unitaire
	*/

        -- Début transaction ligne à ligne        
        BEGIN TRAN

        IF @iRet = 0
        BEGIN
		-- controle de validité du sinistre traité
		SELECT	@iIdProd = s.id_prod
		FROM	sysadm.sinistre	AS s
		
		INNER JOIN sysadm.det_pro AS dp_ctimei
			ON	s.id_prod	=	dp_ctimei.id_prod
			AND	id_typ_code_dp	=	'-DP'		
			AND	id_code_dp	=	75		
			AND	id_typ_calc	=	'-PC'		
			AND	id_code_car	=	'CTIMEI'	
			AND	val_car		=	@sCcimei

		INNER JOIN sysadm.div_sin as ds_cra_suivi_imei
			ON	s.id_sin			=	ds_cra_suivi_imei.id_sin
			AND 	ds_cra_suivi_imei.nom_zone	=	'cra_suivi_imei'	
			AND	ds_cra_suivi_imei.val_nbre	<>	2

		INNER JOIN sysadm.div_sin as ds_cra_dat_gen
			ON	s.id_sin 		=	ds_cra_dat_gen.id_sin
			AND 	ds_cra_dat_gen.nom_zone	=	'cra_dat_gen'
			AND	DATEDIFF ( day, ds_cra_dat_gen.val_dte, @dtDteEnvoi ) >= 0
		
		WHERE	s.id_sin	=	@iIdSin

		IF @@ROWCOUNT <> 1
		BEGIN
			SET @sMessErreur = 'INFORMATION - Dossier n° ' + cast(@iIdSin as varchar(10)) + ', non traite (pas de parametrage, dossier deja traite a OK, date d''envoi anterieur a la generation du fichier)'
			SET @iRet = -2
		END
        END
	
	IF @iRet = 0
	BEGIN
		IF	(	SELECT	count(id_sin)
				FROM	sysadm.sinistre	AS s	
				WHERE	s.id_sin	=	@iIdSin
				-- 200	Refusé	/	600	Réglé	/	900	Sans	suite
				AND	s.cod_etat	NOT IN	( 900,	600, 200 )
			) <> 1
		BEGIN
			-- [CRAO_LOT2.003] On ignore les dossiers en code etat Refusé/Réglé/sans suite
			-- Nouveau Code Retour : - 3 : Traitement Ignoré : Marqué comme 'I' / pas de rejet
/*			SET @sMessErreur = 'AVERTISSEMENT - Dossier déjà traité sinistre n° ' + cast(@iIdSin as varchar(10))
			SET @iRet = -2

			INSERT sysadm.cra_imei_rejet ( type_trait, nom_fic, dte_envoi, nom_prenom, id_sin, dte_surv_fic, num_imei_port, num_port, reponse, date_rejet, message_rejet, type_rejet )
			VALUES ( 'I', @sNomFic, @dtDteEnvoi, @sNomPrenom, @iIdSin, @dtDteSurvFic, @sNumImeiPort, @sNumPort, @iCodeReponse, getdate(), @sMessErreur, 'F' )
*/
			-- remplacé par :
			SET @sMessErreur = 'SET @iRet = -3, sinistre : ' +  cast(@iIdSin as varchar(10))
			SET @iRet = -3
		END
	END

	IF @iRet = 0
	BEGIN
		-- traitement
		IF @sTraitement = '1'
		BEGIN

			-- print 'traitement 1'
			-- Création d’un contact pour travail sherpa, pour instruction, sur SHERPA_SIM/PRO avec PS_I04_CONTACT_TRAVAIL_V01 (trigramme à utiliser : trigramme générique crao)
			SET @sMessContact = 'Controle IMEI Ok'
			EXEC @iRet = sysadm.PS_CRA_IMEI_CONTACT_TRAVAIL 'I', 281, @iIdSin, @iIdProd, @sMessContact, @sMessErreur OUTPUT
			IF @iRet <> 0
			BEGIN
				SET @sMessErreur = 'ERREUR - PS_CRA_IMEI_CONTACT_TRAVAIL avec id_sin = ' + cast(@iIdSin as varchar(10)) + ', message d''erreur : ' + @sMessErreur
				SET @iRet = -2
			END
				
			IF @iRet = 0
			BEGIN
				-- #cra_suivi_imei# = 2
				UPDATE	sysadm.div_sin
				SET	val_nbre	=	2,
					maj_le		=	@dtDate,
					maj_par		=	@sSql
				WHERE	id_sin		=	@iIdSin
				AND	nom_zone	=	'cra_suivi_imei'

				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_car = 1'
					SET @iRet = -1
				END

				IF @iAltWSin > 0
				BEGIN
					UPDATE	sysadm.w_div_sin
					SET	cpt_valide	=	1,
						val_nbre	=	2,
						maj_le		=	@dtDate,
						maj_par		=	@sSql
					WHERE	id_sin		=	@iIdSin
					AND	nom_zone	=	'cra_suivi_imei'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_car = 1'
						SET @iRet = -1
					END
				END
				
				-- #cra_last_dte# = Date de Dernière Utilisation
				IF ( SELECT count(*) FROM sysadm.div_sin WHERE nom_zone = 'cra_last_dte' AND id_sin = @iIdSin ) = 0 AND @iRet = 0
				BEGIN
					INSERT	sysadm.div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cree_le, maj_le, maj_par, valide_le, valide_par )
						SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, @dtDteLastUse, @dtDate, @dtDate, @sSql, @dtDate, @sSql
						FROM	sysadm.div_pro dp
						WHERE	dp.id_prod	=	@iIdProd
						AND	dp.nom_zone	=	'cra_last_dte'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - INSERT div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10))
						SET @iRet = -1
					END

					IF @iAltWSin > 0
					BEGIN
						INSERT	sysadm.w_div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cpt_valide, cree_le, maj_le, maj_par )
							SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, @dtDteLastUse, 1, @dtDate, @dtDate, @sSql
							FROM	sysadm.div_pro dp
							WHERE	dp.id_prod	=	@iIdProd
							AND	dp.nom_zone	=	'cra_last_dte'

						IF @@ROWCOUNT <> 1
						BEGIN
							SET @sMessErreur = 'ERREUR - INSERT w_div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10))
							SET @iRet = -1
						END	
					END
				END
				ELSE
				BEGIN
					UPDATE	sysadm.div_sin
					SET	val_dte		=	@dtDteLastUse,
						maj_le		=	@dtDate,
						maj_par		=	@sSql
					WHERE	id_sin		=	@iIdSin
					AND	nom_zone	=	'cra_last_dte'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = ' + cast(@dtDteLastUse as varchar(25))
						SET @iRet = -1
					END

					IF @iAltWSin > 0
					BEGIN
						UPDATE	sysadm.w_div_sin
						SET	cpt_valide	=	1,
							val_dte		=	@dtDteLastUse,
							maj_le		=	@dtDate,
							maj_par		=	@sSql
						WHERE	id_sin		=	@iIdSin
						AND	nom_zone	=	'cra_last_dte'

						IF @@ROWCOUNT <> 1
						BEGIN
							SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = ' + cast(@dtDteLastUse as varchar(25))
							SET @iRet = -1
						END
					END
				END
				
				-- Insertion dans la table trace_cra_imei : Id_sin, datetime du jour, num_imei_port, num_port, ‘CTOK’, #cra_last_dte#
				SET	@sIdCodeAction	=	'CTOK'
				SET	@sValAction	=	CONVERT ( varchar(25), @dtDteLastUse, 121 )
				EXEC sysadm.PS_I01_TRACE_CRA_IMEI @iIdSin, @dtDate, @sNumImeiPort, @sNumPort, @sIdTypCodeT, @sIdCodeAction, @sValAction
				IF @@ERROR <> 0
				BEGIN
					SET @sMessErreur = 'ERREUR - PS_I01_TRACE_CRA_IMEI avec id_sin = ' + cast(@iIdSin as varchar(10)) + 'et id_code_action = ' + @sIdCodeAction
					SET @iRet = -1
				END
			END
		END

		IF @sTraitement = '2'
		BEGIN

			-- print 'traitement 2'

			-- #cra_ctrl_imei# = ‘O’
			UPDATE	sysadm.div_sin
			SET	val_car		=	'O',
				maj_le		=	@dtDate,
				maj_par		=	@sSql
			WHERE	id_sin		=	@iIdSin
			AND	nom_zone	=	'cra_ctrl_imei'

			IF @@ROWCOUNT <> 1
			BEGIN
				SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_ctrl_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_car = O'
				SET @iRet = -1
			END

			IF @iAltWSin > 0
			BEGIN
				UPDATE	sysadm.w_div_sin
				SET	cpt_valide	=	1,
					val_car		=	'O',
					maj_le		=	@dtDate,
					maj_par		=	@sSql
				WHERE	id_sin		=	@iIdSin
				AND	nom_zone	=	'cra_ctrl_imei'

				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_ctrl_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_car = O'
					SET @iRet = -1
				END
			END
		END
		-- fin traitement 2
		
		IF @sTraitement = '3'
		BEGIN
		
			-- print 'traitement 3'

			-- Création d’un contact pour travail sherpa, pour refus, sur SHERPA_SIM/PRO avec PS_I04_CONTACT_TRAVAIL_V01 (trigramme à utiliser : trigramme générique crao).
			SET @sMessContact = 'Controle IMEI Refuse : ' + sysadm.FN_CODE_NUM ( 5, '-CR' )
			EXEC @iRet = sysadm.PS_CRA_IMEI_CONTACT_TRAVAIL 'I', 281, @iIdSin, @iIdProd, @sMessContact, @sMessErreur OUTPUT
			IF @iRet <> 0
			BEGIN
				SET @sMessErreur = 'ERREUR - PS_CRA_IMEI_CONTACT_TRAVAIL avec id_sin = ' + cast(@iIdSin as varchar(10)) + ', message d''erreur : ' + @sMessErreur
				SET @iRet = -2
			END

			IF @iRet = 0
			BEGIN

				-- #cra_suivi_imei# = 5
				UPDATE	sysadm.div_sin
				SET	val_nbre	=	5,
					maj_le		=	@dtDate,
					maj_par		=	@sSql
				WHERE	id_sin		=	@iIdSin
				AND	nom_zone	=	'cra_suivi_imei'

				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_car = 1'
					SET @iRet = -1
				END

				IF @iAltWSin > 0
				BEGIN
					UPDATE	sysadm.w_div_sin
					SET	cpt_valide	=	1,
						val_nbre	=	5,
						maj_le		=	@dtDate,
						maj_par		=	@sSql
					WHERE	id_sin		=	@iIdSin
					AND	nom_zone	=	'cra_suivi_imei'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_car = 1'
						SET @iRet = -1
					END
				END

				-- #cra_last_dte# = Date de Dernière Utilisation
				IF ( SELECT count(*) FROM sysadm.div_sin WHERE nom_zone = 'cra_last_dte' AND id_sin = @iIdSin ) = 0
				BEGIN
					INSERT	sysadm.div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cree_le, maj_le, maj_par, valide_le, valide_par )
						SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, @dtDteLastUse, @dtDate, @dtDate, @sSql, @dtDate, @sSql
						FROM	sysadm.div_pro dp
						WHERE	dp.id_prod	=	@iIdProd
						AND	dp.nom_zone	=	'cra_last_dte'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - INSERT div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10))
						SET @iRet = -1
					END

					IF @iAltWSin > 0
					BEGIN
						INSERT	sysadm.w_div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cpt_valide, cree_le, maj_le, maj_par )
							SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, @dtDteLastUse, 1, @dtDate, @dtDate, @sSql
							FROM	sysadm.div_pro dp
							WHERE	dp.id_prod	=	@iIdProd
							AND	dp.nom_zone	=	'cra_last_dte'

						IF @@ROWCOUNT <> 1
						BEGIN
							SET @sMessErreur = 'ERREUR - INSERT w_div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10))
							SET @iRet = -1
						END
					END
				END
				ELSE
				BEGIN
					UPDATE	sysadm.div_sin
					SET	val_dte		=	@dtDteLastUse,
						maj_le		=	@dtDate,
						maj_par		=	@sSql
					WHERE	id_sin		=	@iIdSin
					AND	nom_zone	=	'cra_last_dte'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = ' + cast(@dtDteLastUse as varchar(25))
						SET @iRet = -1
					END

					IF @iAltWSin > 0
					BEGIN
						UPDATE	sysadm.w_div_sin
						SET	cpt_valide	=	1,
							val_dte		=	@dtDteLastUse,
							maj_le		=	@dtDate,
							maj_par		=	@sSql
						WHERE	id_sin		=	@iIdSin
						AND	nom_zone	=	'cra_last_dte'

						IF @@ROWCOUNT <> 1
						BEGIN
							SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = ' + cast(@dtDteLastUse as varchar(25))
							SET @iRet = -1
						END
					END
				END
				
				-- Insertion dans la table trace_cra_imei : Id_sin, datetime du jour, num_imei_port, num_port, ‘REFDEF’, #cra_last_dte#
				SET	@sIdCodeAction	=	'REFDEF'
				SET	@sValAction	=	CONVERT ( varchar(25), @dtDteLastUse, 121 )
				EXEC sysadm.PS_I01_TRACE_CRA_IMEI @iIdSin, @dtDate, @sNumImeiPort, @sNumPort, @sIdTypCodeT, @sIdCodeAction, @sValAction
				IF @@ERROR <> 0
				BEGIN
					SET @sMessErreur = 'ERREUR - PS_I01_TRACE_CRA_IMEI avec id_sin = ' + cast(@iIdSin as varchar(10)) + 'et id_code_action = ' + @sIdCodeAction
					SET @iRet = -1
				END
			END
		END
		-- fin traitement 3
		
		IF @sTraitement = '4'
		BEGIN
		
			-- print 'traitement 4'
			
			-- Création d’un contact pour travail sherpa, pour instruction, sur SHERPA_SIM/PRO avec PS_I04_CONTACT_TRAVAIL_V01 (trigramme à utiliser : trigramme générique crao)
			SET @sMessContact = 'Controle IMEI Ok'
			EXEC @iRet = sysadm.PS_CRA_IMEI_CONTACT_TRAVAIL 'I', 281, @iIdSin, @iIdProd, @sMessContact, @sMessErreur OUTPUT
			IF @iRet <> 0
			BEGIN
				SET @sMessErreur = 'ERREUR - PS_CRA_IMEI_CONTACT_TRAVAIL avec id_sin = ' + cast(@iIdSin as varchar(10)) + ', message d''erreur : ' + @sMessErreur
				SET @iRet = -2
			END

			IF @iRet = 0
			BEGIN
				-- #cra_suivi_imei# = 2
				UPDATE	sysadm.div_sin
				SET	val_nbre	=	2,
					maj_le		=	@dtDate,
					maj_par		=	@sSql
				WHERE	id_sin		=	@iIdSin
				AND	nom_zone	=	'cra_suivi_imei'

				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_car = 1'
					SET @iRet = -1
				END

				IF @iAltWSin > 0
				BEGIN
					UPDATE	sysadm.w_div_sin
					SET	cpt_valide	=	1,
						val_nbre	=	2,
						maj_le		=	@dtDate,
						maj_par		=	@sSql
					WHERE	id_sin		=	@iIdSin
					AND	nom_zone	=	'cra_suivi_imei'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_car = 1'
						SET @iRet = -1
					END
				END

				-- #cra_last_dte# = Date de Dernière Utilisation
				IF ( SELECT count(*) FROM sysadm.div_sin WHERE nom_zone = 'cra_last_dte' AND id_sin = @iIdSin ) = 0
				BEGIN
					INSERT	sysadm.div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cree_le, maj_le, maj_par, valide_le, valide_par )
						SELECT	@iIdSin, dp.nom_zone, dp.lib_label, dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, @dtDteLastUse, @dtDate, @dtDate, @sSql, @dtDate, @sSql
						FROM	sysadm.div_pro dp
						WHERE	dp.id_prod	=	@iIdProd
						AND	dp.nom_zone	=	'cra_last_dte'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - INSERT div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10))
						SET @iRet = -1
					END

					IF @iAltWSin > 0
					BEGIN
						INSERT	sysadm.w_div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cpt_valide, cree_le, maj_le, maj_par )
							SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, @dtDteLastUse, 1, @dtDate, @dtDate, @sSql
							FROM	sysadm.div_pro dp
							WHERE	dp.id_prod	=	@iIdProd
							AND	dp.nom_zone	=	'cra_last_dte'

						IF @@ROWCOUNT <> 1
						BEGIN
							SET @sMessErreur = 'ERREUR - INSERT w_div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10))
							SET @iRet = -1
						END		
					END
				END
				ELSE
				BEGIN
					UPDATE	sysadm.div_sin
					SET	val_dte		=	@dtDteLastUse,
						maj_le		=	@dtDate,
						maj_par		=	@sSql
					WHERE	id_sin		=	@iIdSin
					AND	nom_zone	=	'cra_last_dte'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = ' + cast(@dtDteLastUse as varchar(25))
						SET @iRet = -1
					END

					IF @iAltWSin > 0
					BEGIN
						UPDATE	sysadm.w_div_sin
						SET	cpt_valide	=	1,
							val_dte		=	@dtDteLastUse,
							maj_le		=	@dtDate,
							maj_par		=	@sSql
						WHERE	id_sin		=	@iIdSin
						AND	nom_zone	=	'cra_last_dte'

						IF @@ROWCOUNT <> 1
						BEGIN
							SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = ' + cast(@dtDteLastUse as varchar(25))
							SET @iRet = -1
						END
					END
				END
				
				-- Insertion dans la table trace_cra_imei : Id_sin, datetime du jour, num_imei_port, num_port, ‘CTOK’, #cra_last_dte#
				SET	@sIdCodeAction	=	'CTOK'
				SET	@sValAction	=	CONVERT ( varchar(25), @dtDteLastUse, 121 )
				
				EXEC sysadm.PS_I01_TRACE_CRA_IMEI @iIdSin, @dtDate, @sNumImeiPort, @sNumPort, @sIdTypCodeT, @sIdCodeAction, @sValAction
				IF @@ERROR <> 0
				BEGIN
					SET @sMessErreur = 'ERREUR - PS_I01_TRACE_CRA_IMEI avec id_sin = ' + cast(@iIdSin as varchar(10)) + 'et id_code_action = ' + @sIdCodeAction
					SET @iRet = -1
				END
			END
		END
		-- fin traitement 4
			
		IF @sTraitement = '5'
		BEGIN	
			-- print 'traitement 5'
			
			-- #cra_ctrl_imei# = ‘O’
			UPDATE	sysadm.div_sin
			SET	val_car		=	'O',
				maj_le		=	@dtDate,
				maj_par		=	@sSql
			WHERE	id_sin		=	@iIdSin
			AND	nom_zone	=	'cra_ctrl_imei'

			IF @@ROWCOUNT <> 1
			BEGIN
				SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_ctrl_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_car = O'
				SET @iRet = -1
			END

			IF @iAltWSin > 0
			BEGIN
				UPDATE	sysadm.w_div_sin
				SET	cpt_valide	=	1,
					val_car		=	'O',
					maj_le		=	@dtDate,
					maj_par		=	@sSql
				WHERE	id_sin		=	@iIdSin
				AND	nom_zone	=	'cra_ctrl_imei'

				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_ctrl_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_car = O'
					SET @iRet = -1
				END
			END
		END
		-- fin traitement 5

		IF @sTraitement = '6'
		BEGIN
		
			-- print 'traitement 6'
			
			-- Création d’un contact pour travail sherpa, pour refus, sur SHERPA_SIM/PRO avec PS_I04_CONTACT_TRAVAIL_V01 (trigramme à utiliser : trigramme générique crao).
			SET @sMessContact = 'Controle IMEI Refuse : ' + sysadm.FN_CODE_NUM ( 5, '-CR' )
			EXEC @iRet = sysadm.PS_CRA_IMEI_CONTACT_TRAVAIL 'I', 281, @iIdSin, @iIdProd, @sMessContact, @sMessErreur OUTPUT
			IF @iRet <> 0
			BEGIN
				SET @sMessErreur = 'ERREUR - PS_CRA_IMEI_CONTACT_TRAVAIL avec id_sin = ' + cast(@iIdSin as varchar(10)) + ', message d''erreur : ' + @sMessErreur
				SET @iRet = -2
			END

			IF @iRet = 0
			BEGIN
				-- #cra_suivi_imei# = 5
				UPDATE	sysadm.div_sin
				SET	val_nbre	=	5,
					maj_le		=	@dtDate,
					maj_par		=	@sSql
				WHERE	id_sin		=	@iIdSin
				AND	nom_zone	=	'cra_suivi_imei'

				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_nbre = 5'
					SET @iRet = -1
				END

				IF @iAltWSin > 0
				BEGIN
					UPDATE	sysadm.w_div_sin
					SET	cpt_valide	=	1,
						val_nbre	=	5,
						maj_le		=	@dtDate,
						maj_par		=	@sSql
					WHERE	id_sin		=	@iIdSin
					AND	nom_zone	=	'cra_suivi_imei'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_nbre = 5'
						SET @iRet = -1
					END
				END

				-- #cra_last_dte# = Date de Dernière Utilisation
				IF ( SELECT count(*) FROM sysadm.div_sin WHERE nom_zone = 'cra_last_dte' AND id_sin = @iIdSin ) = 0
				BEGIN
					INSERT	sysadm.div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cree_le, maj_le, maj_par, valide_le, valide_par )
						SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, @dtDteLastUse, @dtDate, @dtDate, @sSql, @dtDate, @sSql
						FROM	sysadm.div_pro dp
						WHERE	dp.id_prod	=	@iIdProd
						AND	dp.nom_zone	=	'cra_last_dte'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - INSERT div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10))
						SET @iRet = -1
					END

					IF @iAltWSin > 0
					BEGIN
						INSERT	sysadm.w_div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cpt_valide, cree_le, maj_le, maj_par )
							SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, @dtDteLastUse, 1, @dtDate, @dtDate, @sSql
							FROM	sysadm.div_pro dp
							WHERE	dp.id_prod	=	@iIdProd
							AND	dp.nom_zone	=	'cra_last_dte'

						IF @@ROWCOUNT <> 1
						BEGIN
							SET @sMessErreur = 'ERREUR - INSERT w_div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10))
							SET @iRet = -1
						END		
					END
				END
				ELSE
				BEGIN
					UPDATE	sysadm.div_sin
					SET	val_dte		=	@dtDteLastUse,
						maj_le		=	@dtDate,
						maj_par		=	@sSql
					WHERE	id_sin		=	@iIdSin
					AND	nom_zone	=	'cra_last_dte'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = ' + cast(@dtDteLastUse as varchar(25))
						SET @iRet = -1
					END

					IF @iAltWSin > 0
					BEGIN
						UPDATE	sysadm.w_div_sin
						SET	cpt_valide	=	1,
							val_dte		=	@dtDteLastUse,
							maj_le		=	@dtDate,
							maj_par		=	@sSql
						WHERE	id_sin		=	@iIdSin
						AND	nom_zone	=	'cra_last_dte'

						IF @@ROWCOUNT <> 1
						BEGIN
							SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = ' + cast(@dtDteLastUse as varchar(25))
							SET @iRet = -1
						END
					END
				END
				
				-- Insertion dans la table trace_cra_imei : Id_sin, datetime du jour, num_imei_port, num_port, ‘REFDEF’, #cra_last_dte#
				SET	@sIdCodeAction	=	'REFDEF'
				SET	@sValAction	=	CONVERT ( varchar(25), @dtDteLastUse, 121 )
				EXEC sysadm.PS_I01_TRACE_CRA_IMEI @iIdSin, @dtDate, @sNumImeiPort, @sNumPort, @sIdTypCodeT, @sIdCodeAction, @sValAction
				IF @@ERROR <> 0
				BEGIN
					SET @sMessErreur = 'ERREUR - PS_I01_TRACE_CRA_IMEI avec id_sin = ' + cast(@iIdSin as varchar(10)) + 'et id_code_action = ' + @sIdCodeAction
					SET @iRet = -1
				END
			END
		END
		-- fin traitement 6

		IF @sTraitement = '7'
		BEGIN
			
			-- print 'traitement 7'

			-- trace dans la table de rejet
			SET @sMessErreur = 'Autre Contrat/Orange'
			INSERT sysadm.cra_imei_rejet ( type_trait, nom_fic, dte_envoi, nom_prenom, id_sin, dte_surv_fic, num_imei_port, num_port, reponse, date_rejet, message_rejet, type_rejet )
			VALUES ( 'I', @sNomFic, CONVERT ( varchar(23), @dtDteEnvoi, 121), @sNomPrenom, @iIdSin, CONVERT ( varchar(23), @dtDteSurvFic, 121), @sNumImeiPort, @sNumPort, @iCodeReponse, getdate(), @sMessErreur, 'F' )
			
			-- #cra_suivi_imei# = 6
			UPDATE	sysadm.div_sin
			SET	val_nbre	=	6,
				maj_le		=	@dtDate,
				maj_par		=	@sSql
			WHERE	id_sin		=	@iIdSin
			AND	nom_zone	=	'cra_suivi_imei'

			IF @@ROWCOUNT <> 1
			BEGIN
				SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_nbre = 6'
				SET @iRet = -1
			END

			IF @iAltWSin > 0
			BEGIN
				UPDATE	sysadm.w_div_sin
				SET	cpt_valide	=	1,
					val_nbre	=	6,
					maj_le		=	@dtDate,
					maj_par		=	@sSql
				WHERE	id_sin		=	@iIdSin
				AND	nom_zone	=	'cra_suivi_imei'

				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_nbre = 6'
					SET @iRet = -1
				END
			END
			
			-- #cra_last_dte# = Null
			IF ( SELECT count(*) FROM sysadm.div_sin WHERE nom_zone = 'cra_last_dte' AND id_sin = @iIdSin ) = 0
			BEGIN
				INSERT	sysadm.div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cree_le, maj_le, maj_par, valide_le, valide_par )
					SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, NULL, @dtDate, @dtDate, @sSql, @dtDate, @sSql
					FROM	sysadm.div_pro dp
					WHERE	dp.id_prod	=	@iIdProd
					AND	dp.nom_zone	=	'cra_last_dte'

				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - INSERT div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10))
					SET @iRet = -1
				END

				IF @iAltWSin > 0
				BEGIN
					INSERT	sysadm.w_div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cpt_valide, cree_le, maj_le, maj_par )
						SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, NULL, 1, @dtDate, @dtDate, @sSql
						FROM	sysadm.div_pro dp
						WHERE	dp.id_prod	=	@iIdProd
						AND	dp.nom_zone	=	'cra_last_dte'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - INSERT w_div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10))
						SET @iRet = -1
					END		
				END
			END
			ELSE
			BEGIN
				UPDATE	sysadm.div_sin
				SET	val_dte		=	NULL,
					maj_le		=	@dtDate,
					maj_par		=	@sSql
				WHERE	id_sin		=	@iIdSin
				AND	nom_zone	=	'cra_last_dte'

				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = NULL'
					SET @iRet = -1
					-- BREAK -- *
				END

				IF @iAltWSin > 0
				BEGIN
					UPDATE	sysadm.w_div_sin
					SET	cpt_valide	=	1,
						val_dte		=	NULL,
						maj_le		=	@dtDate,
						maj_par		=	@sSql
					WHERE	id_sin		=	@iIdSin
					AND	nom_zone	=	'cra_last_dte'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = NULL'
						SET @iRet = -1
					END
				END
			END
			
			-- Insertion dans la table trace_cra_imei : Id_sin, datetime du jour, num_imei_port, num_port, ‘REJET’, #cra_last_dte#
			SET	@sIdCodeAction	=	'REJET'
			SET	@sValAction	=	NULL
			EXEC sysadm.PS_I01_TRACE_CRA_IMEI @iIdSin, @dtDate, @sNumImeiPort, @sNumPort, @sIdTypCodeT, @sIdCodeAction, @sValAction
			IF @@ERROR <> 0
			BEGIN
				SET @sMessErreur = 'ERREUR - PS_I01_TRACE_CRA_IMEI avec id_sin = ' + cast(@iIdSin as varchar(10)) + 'et id_code_action = ' + @sIdCodeAction
				SET @iRet = -1
			END
		END
		-- fin traitement 7

		IF @sTraitement = '8'
		BEGIN

			-- print 'traitement 8'

			-- trace dans la table de rejet
			SET @sMessErreur = 'Numero de ligne / numero IMEI errone'
			INSERT sysadm.cra_imei_rejet ( type_trait, nom_fic, dte_envoi, nom_prenom, id_sin, dte_surv_fic, num_imei_port, num_port, reponse, date_rejet, message_rejet, type_rejet )
			VALUES ( 'I', @sNomFic, CONVERT ( varchar(23), @dtDteEnvoi, 121 ), @sNomPrenom, @iIdSin, CONVERT ( varchar(23), @dtDteSurvFic, 121 ), @sNumImeiPort, @sNumPort, @iCodeReponse, getdate(), @sMessErreur, 'F' )
			
			-- #cra_suivi_imei# = 8
			UPDATE	sysadm.div_sin
			SET	val_nbre	=	8,
				maj_le		=	@dtDate,
				maj_par		=	@sSql
			WHERE	id_sin		=	@iIdSin
			AND	nom_zone	=	'cra_suivi_imei'

			IF @@ROWCOUNT <> 1
			BEGIN
				SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_nbre = 8'
				SET @iRet = -1
			END

			IF @iAltWSin > 0
			BEGIN
				UPDATE	sysadm.w_div_sin
				SET	cpt_valide	=	1,
					val_nbre	=	8,
					maj_le		=	@dtDate,
					maj_par		=	@sSql
				WHERE	id_sin		=	@iIdSin
				AND	nom_zone	=	'cra_suivi_imei'

				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_nbre = 8'
					SET @iRet = -1
				END
			END

			-- #cra_last_dte# = Null
			IF ( SELECT count(*) FROM sysadm.div_sin WHERE nom_zone = 'cra_last_dte' AND id_sin = @iIdSin ) = 0
			BEGIN
				INSERT	sysadm.div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cree_le, maj_le, maj_par, valide_le, valide_par )
					SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, NULL, @dtDate, @dtDate, @sSql, @dtDate, @sSql
					FROM	sysadm.div_pro dp
					WHERE	dp.id_prod	=	@iIdProd
					AND	dp.nom_zone	=	'cra_last_dte'

				IF @@ERROR <> 0
				BEGIN
					SET @sMessErreur = 'ERREUR - INSERT div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10))
					SET @iRet = -1
				END

				IF @iAltWSin > 0
				BEGIN
					INSERT	sysadm.w_div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cpt_valide, cree_le, maj_le, maj_par )
						SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, NULL, 1, @dtDate, @dtDate, @sSql
						FROM	sysadm.div_pro dp
						WHERE	dp.id_prod	=	@iIdProd
						AND	dp.nom_zone	=	'cra_last_dte'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - INSERT w_div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10))
						SET @iRet = -1
					END		
				END
			END
			ELSE
			BEGIN
				UPDATE	sysadm.div_sin
				SET	val_dte		=	NULL,
					maj_le		=	@dtDate,
					maj_par		=	@sSql
				WHERE	id_sin		=	@iIdSin
				AND	nom_zone	=	'cra_last_dte'

				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = ' + cast(@dtDteLastUse as varchar(25))
					SET @iRet = -1
				END

				IF @iAltWSin > 0
				BEGIN
					UPDATE	sysadm.w_div_sin
					SET	cpt_valide	=	1,
						val_dte		=	NULL,
						maj_le		=	@dtDate,
						maj_par		=	@sSql
					WHERE	id_sin		=	@iIdSin
					AND	nom_zone	=	'cra_last_dte'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = ' + cast(@dtDteLastUse as varchar(25))
						SET @iRet = -1
					END
				END
			END
			
			-- Insertion dans la table trace_cra_imei : Id_sin, datetime du jour, num_imei_port, num_port, ‘REJET’, #cra_last_dte#
			SET	@sIdCodeAction	=	'REJET'
			SET	@sValAction	=	NULL
			EXEC sysadm.PS_I01_TRACE_CRA_IMEI @iIdSin, @dtDate, @sNumImeiPort, @sNumPort, @sIdTypCodeT, @sIdCodeAction, @sValAction
			IF @@ERROR <> 0
			BEGIN
				SET @sMessErreur = 'ERREUR - PS_I01_TRACE_CRA_IMEI avec id_sin = ' + cast(@iIdSin as varchar(10)) + 'et id_code_action = ' + @sIdCodeAction
				SET @iRet = -1
			END
		END
		-- fin traitement 8

		IF @sTraitement = '9'
		BEGIN

			-- print 'traitement 9'

			-- #cra_ctrl_imei#= ‘O’
			UPDATE	sysadm.div_sin
			SET	val_car		=	'O',
				maj_le		=	@dtDate,
				maj_par		=	@sSql
			WHERE	id_sin		=	@iIdSin
			AND	nom_zone	=	'cra_ctrl_imei'

			IF @@ROWCOUNT <> 1
			BEGIN
				SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_ctrl_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_car = O'
				SET @iRet = -1
			END

			IF @iAltWSin > 0
			BEGIN
				UPDATE	sysadm.w_div_sin
				SET	cpt_valide	=	1,
					val_car		=	'O',
					maj_le		=	@dtDate,
					maj_par		=	@sSql
				WHERE	id_sin		=	@iIdSin
				AND	nom_zone	=	'cra_ctrl_imei'

				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_ctrl_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_car = O'
					SET @iRet = -1
				END
			END

			-- print 'fin traitement 9'

		END
		-- fin traitement 9

		IF @sTraitement = '10'
		BEGIN

			-- print 'traitement 10'

			-- Création d’un contact pour travail sherpa, pour instuction, sur SHERPA_SIM/PRO avec PS_I04_CONTACT_TRAVAIL_V01 (trigramme à utiliser : trigramme générique crao)
			SET @sMessContact 	= 'Controle IMEI Ok'
			EXEC @iRet = sysadm.PS_CRA_IMEI_CONTACT_TRAVAIL 'I', 281, @iIdSin, @iIdProd, @sMessContact, @sMessErreur OUTPUT
			IF @iRet <> 0
			BEGIN
				SET @sMessErreur = 'ERREUR - PS_CRA_IMEI_CONTACT_TRAVAIL avec id_sin = ' + cast(@iIdSin as varchar(10)) + ', message d''erreur : ' + @sMessErreur
				SET @iRet = -2
			END

			IF @iRet = 0
			BEGIN
				-- #cra_suivi_imei# = 2
				UPDATE	sysadm.div_sin
				SET	val_nbre	=	2,
					maj_le		=	@dtDate,
					maj_par		=	@sSql
				WHERE	id_sin		=	@iIdSin
				AND	nom_zone	=	'cra_suivi_imei'

				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_nbre = 2'
					SET @iRet = -1
				END

				IF @iAltWSin > 0
				BEGIN
					UPDATE	sysadm.w_div_sin
					SET	cpt_valide	=	1,
						val_nbre	=	2,
						maj_le		=	@dtDate,
						maj_par		=	@sSql
					WHERE	id_sin		=	@iIdSin
					AND	nom_zone	=	'cra_suivi_imei'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_nbre = 2'
						SET @iRet = -1
					END
				END

				-- #cra_last_dte# = NULL
				IF ( SELECT count(*) FROM sysadm.div_sin WHERE nom_zone = 'cra_last_dte' AND id_sin = @iIdSin ) = 0
				BEGIN
					INSERT	sysadm.div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cree_le, maj_le, maj_par, valide_le, valide_par )
						SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, NULL, @dtDate, @dtDate, @sSql, @dtDate, @sSql
						FROM	sysadm.div_pro dp
						WHERE	dp.id_prod	=	@iIdProd
						AND	dp.nom_zone	=	'cra_last_dte'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - INSERT div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10))
						SET @iRet = -1
					END

					IF @iAltWSin > 0
					BEGIN
						INSERT	sysadm.w_div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cpt_valide, cree_le, maj_le, maj_par )
							SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, NULL, 1, @dtDate, @dtDate, @sSql
							FROM	sysadm.div_pro dp
							WHERE	dp.id_prod	=	@iIdProd
							AND	dp.nom_zone	=	'cra_last_dte'

						IF @@ROWCOUNT <> 1
						BEGIN
							SET @sMessErreur = 'ERREUR - INSERT w_div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10))
							SET @iRet = -1
						END		
					END
				END
				ELSE
				BEGIN
					UPDATE	sysadm.div_sin
					SET	val_dte		=	NULL,
						maj_le		=	@dtDate,
						maj_par		=	@sSql
					WHERE	id_sin		=	@iIdSin
					AND	nom_zone	=	'cra_last_dte'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = NULL'
						SET @iRet = -1
					END

					IF @iAltWSin > 0
					BEGIN
						UPDATE	sysadm.w_div_sin
						SET	cpt_valide	=	1,
							val_dte		=	NULL,
							maj_le		=	@dtDate,
							maj_par		=	@sSql
						WHERE	id_sin		=	@iIdSin
						AND	nom_zone	=	'cra_last_dte'

						IF @@ROWCOUNT <> 1
						BEGIN
							SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = NULL'
							SET @iRet = -1
						END
					END
				END
				
				-- Insertion dans la table trace_cra_imei : Id_sin, datetime du jour, num_imei_port, num_port, ‘REFDEF’, #cra_last_dte#
				SET	@sIdCodeAction	=	'CTOK'
				SET	@sValAction	=	NULL
				EXEC sysadm.PS_I01_TRACE_CRA_IMEI @iIdSin, @dtDate, @sNumImeiPort, @sNumPort, @sIdTypCodeT, @sIdCodeAction, @sValAction
				IF @@ERROR <> 0
				BEGIN
					SET @sMessErreur = 'ERREUR - PS_I01_TRACE_CRA_IMEI avec id_sin = ' + cast(@iIdSin as varchar(10)) + 'et id_code_action = ' + @sIdCodeAction
					SET @iRet = -1
				END
			END
		END
		-- fin traitement 10

		IF @sTraitement = '11'
		BEGIN

			-- print 'traitement 11'

			-- trace dans la table de rejet
			SET @sMessErreur = 'Code reponse inconnu'
			INSERT sysadm.cra_imei_rejet ( type_trait, nom_fic, dte_envoi, nom_prenom, id_sin, dte_surv_fic, num_imei_port, num_port, reponse, date_rejet, message_rejet, type_rejet )
			VALUES ( 'I', @sNomFic, CONVERT ( varchar(23), @dtDteEnvoi, 121), @sNomPrenom, @iIdSin, CONVERT ( varchar(23), @dtDteSurvFic, 121), @sNumImeiPort, @sNumPort, @iCodeReponse, getdate(), @sMessErreur, 'F' )

			-- #cra_suivi_imei# = 7
			UPDATE	sysadm.div_sin
			SET	val_nbre	=	7,
				maj_le		=	@dtDate,
				maj_par		=	@sSql
			WHERE	id_sin		=	@iIdSin
			AND	nom_zone	=	'cra_suivi_imei'

			IF @@ROWCOUNT <> 1
			BEGIN
				SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_nbre = 7'
				SET @iRet = -1
			END

			IF @iAltWSin > 0
			BEGIN
				UPDATE	sysadm.w_div_sin
				SET	cpt_valide	=	1,
					val_nbre	=	7,
					maj_le		=	@dtDate,
					maj_par		=	@sSql
				WHERE	id_sin		=	@iIdSin
				AND	nom_zone	=	'cra_suivi_imei'

				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_nbre = 7'
					SET @iRet = -1
				END
			END

			-- #cra_last_dte# = NULL
			IF ( SELECT count(*) FROM sysadm.div_sin WHERE nom_zone = 'cra_last_dte' AND id_sin = @iIdSin ) = 0
			BEGIN
				INSERT	sysadm.div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cree_le, maj_le, maj_par, valide_le, valide_par )
					SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, NULL, @dtDate, @dtDate, @sSql, @dtDate, @sSql
					FROM	sysadm.div_pro dp
					WHERE	dp.id_prod	=	@iIdProd
					AND	dp.nom_zone	=	'cra_last_dte'

				IF @@ERROR <> 0
				BEGIN
					SET @sMessErreur = 'ERREUR - INSERT div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10))
					SET @iRet = -1
				END

				IF @iAltWSin > 0
				BEGIN
					INSERT	sysadm.w_div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cpt_valide, cree_le, maj_le, maj_par )
						SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, NULL, 1, @dtDate, @dtDate, @sSql
						FROM	sysadm.div_pro dp
						WHERE	dp.id_prod	=	@iIdProd
						AND	dp.nom_zone	=	'cra_last_dte'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - INSERT w_div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10))
						SET @iRet = -1
					END	
				END
			END
			ELSE
			BEGIN
				UPDATE	sysadm.div_sin
				SET	val_dte		=	NULL,
					maj_le		=	@dtDate,
					maj_par		=	@sSql
				WHERE	id_sin		=	@iIdSin
				AND	nom_zone	=	'cra_last_dte'

				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = NULL'
					SET @iRet = -1
				END

				IF @iAltWSin > 0
				BEGIN
					UPDATE	sysadm.w_div_sin
					SET	cpt_valide	=	1,
						val_dte		=	NULL,
						maj_le		=	@dtDate,
						maj_par		=	@sSql
					WHERE	id_sin		=	@iIdSin
					AND	nom_zone	=	'cra_last_dte'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = NULL'
						SET @iRet = -1
					END
				END
			END
			
			-- Insertion dans la table trace_cra_imei : Id_sin, datetime du jour, num_imei_port, num_port, ‘REJET’, datetime du jour
			SET	@sIdCodeAction	=	'REJET'
			SET	@sValAction	=	NULL
			EXEC sysadm.PS_I01_TRACE_CRA_IMEI @iIdSin, @dtDate, @sNumImeiPort, @sNumPort, @sIdTypCodeT, @sIdCodeAction, @sValAction
			IF @@ERROR <> 0
			BEGIN
				SET @sMessErreur = 'ERREUR - PS_I01_TRACE_CRA_IMEI avec id_sin = ' + cast(@iIdSin as varchar(10)) + 'et id_code_action = ' + @sIdCodeAction
				SET @iRet = -1
			END
		END
		-- fin traitement 11

		IF @sTraitement = '12'
		BEGIN

			-- print 'traitement 12'
		
			-- Création d’un contact pour travail sherpa, pour refus, sur SHERPA_SIM/PRO avec PS_I04_CONTACT_TRAVAIL_V01 (trigramme à utiliser : trigramme générique crao).
			SET @sMessContact = 'Controle IMEI Refuse : ' + sysadm.FN_CODE_NUM ( 3, '-CR' )
			EXEC @iRet = sysadm.PS_CRA_IMEI_CONTACT_TRAVAIL 'I', 281, @iIdSin, @iIdProd, @sMessContact, @sMessErreur OUTPUT
			IF @iRet <> 0
			BEGIN
				SET @sMessErreur = 'ERREUR - PS_CRA_IMEI_CONTACT_TRAVAIL avec id_sin = ' + cast(@iIdSin as varchar(10)) + ', message d''erreur : ' + @sMessErreur
				SET @iRet = -2
			END

			IF @iRet = 0
			BEGIN
				-- #cra_suivi_imei# = 3
				UPDATE	sysadm.div_sin
				SET	val_nbre	=	3,
					maj_le		=	@dtDate,
					maj_par		=	@sSql
				WHERE	id_sin		=	@iIdSin
				AND	nom_zone	=	'cra_suivi_imei'

				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_nbre = 3'
					SET @iRet = -1
				END

				IF @iAltWSin > 0
				BEGIN
					UPDATE	sysadm.w_div_sin
					SET	cpt_valide	=	1,
						val_nbre	=	3,
						maj_le		=	@dtDate,
						maj_par		=	@sSql
					WHERE	id_sin		=	@iIdSin
					AND	nom_zone	=	'cra_suivi_imei'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_nbre = 3'
						SET @iRet = -1
					END
				END

				-- #cra_last_dte# = NULL
				IF ( SELECT count(*) FROM div_sin WHERE nom_zone = 'cra_last_dte' AND id_sin = @iIdSin ) = 0
				BEGIN
					INSERT	sysadm.div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cree_le, maj_le, maj_par, valide_le, valide_par )
						SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, NULL, @dtDate, @dtDate, @sSql, @dtDate, @sSql
						FROM	sysadm.div_pro dp
						WHERE	dp.id_prod	=	@iIdProd
						AND	dp.nom_zone	=	'cra_last_dte'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - INSERT div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10))
						SET @iRet = -1
					END

					IF @iAltWSin > 0
					BEGIN
						INSERT	sysadm.w_div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cpt_valide, cree_le, maj_le, maj_par )
							SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, NULL, 1, @dtDate, @dtDate, @sSql
							FROM	sysadm.div_pro dp
							WHERE	dp.id_prod	=	@iIdProd
							AND	dp.nom_zone	=	'cra_last_dte'

						IF @@ROWCOUNT <> 1
						BEGIN
							SET @sMessErreur = 'ERREUR - INSERT w_div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10))
							SET @iRet = -1
						END		
					END
				END
				ELSE
				BEGIN
					UPDATE	sysadm.div_sin
					SET	val_dte		=	NULL,
						maj_le		=	@dtDate,
						maj_par		=	@sSql
					WHERE	id_sin		=	@iIdSin
					AND	nom_zone	=	'cra_last_dte'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = NULL'
						SET @iRet = -1
					END

					IF @iAltWSin > 0
					BEGIN
						UPDATE	sysadm.w_div_sin
						SET	cpt_valide	=	1,
							val_dte		=	NULL,
							maj_le		=	@dtDate,
							maj_par		=	@sSql
						WHERE	id_sin		=	@iIdSin
						AND	nom_zone	=	'cra_last_dte'

						IF @@ROWCOUNT <> 1
						BEGIN
							SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = NULL'
							SET @iRet = -1
						END
					END
				END
				
				-- Insertion dans la table trace_cra_imei : Id_sin, datetime du jour, num_imei_port, num_port, ‘REFDEF’, Code Réponse
				SET	@sIdCodeAction	=	'REFDEF'
				SET	@sValAction	=	cast ( @iCodeReponse as varchar(5) )
				EXEC sysadm.PS_I01_TRACE_CRA_IMEI @iIdSin, @dtDate, @sNumImeiPort, @sNumPort, @sIdTypCodeT, @sIdCodeAction, @sValAction
				IF @@ERROR <> 0
				BEGIN
					SET @sMessErreur = 'ERREUR - PS_I01_TRACE_CRA_IMEI avec id_sin = ' + cast(@iIdSin as varchar(10)) + 'et id_code_action = ' + @sIdCodeAction
					SET @iRet = -1
				END
			END
		END
		-- fin traitement 12

		IF @sTraitement = '13'
		BEGIN

			-- print 'traitement 13'

			-- Création d’un contact pour travail sherpa, pour refus, sur SHERPA_SIM/PRO avec PS_I04_CONTACT_TRAVAIL_V01 (trigramme à utiliser : trigramme générique crao).
			SET @sMessContact = 'Controle IMEI Refuse : ' + sysadm.FN_CODE_NUM ( 4, '-CR' )
			EXEC @iRet = sysadm.PS_CRA_IMEI_CONTACT_TRAVAIL 'I', 281, @iIdSin, @iIdProd, @sMessContact, @sMessErreur OUTPUT
			IF @iRet <> 0
			BEGIN
				SET @sMessErreur = 'ERREUR - PS_CRA_IMEI_CONTACT_TRAVAIL avec id_sin = ' + cast(@iIdSin as varchar(10)) + ', message d''erreur : ' + @sMessErreur
				SET @iRet = -2
			END

			IF @iRet = 0
			BEGIN
				-- #cra_suivi_imei# = 4
				UPDATE	sysadm.div_sin
				SET	val_nbre	=	4,
					maj_le		=	@dtDate,
					maj_par		=	@sSql
				WHERE	id_sin		=	@iIdSin
				AND	nom_zone	=	'cra_suivi_imei'

				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_nbre = 4'
					SET @iRet = -1
				END

				IF @iAltWSin > 0
				BEGIN
					UPDATE	sysadm.w_div_sin
					SET	cpt_valide	=	1,
						val_nbre	=	4,
						maj_le		=	@dtDate,
						maj_par		=	@sSql
					WHERE	id_sin		=	@iIdSin
					AND	nom_zone	=	'cra_suivi_imei'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_nbre = 4'
						SET @iRet = -1
					END
				END

				-- #cra_last_dte# = NULL
				IF ( SELECT count(*) FROM div_sin WHERE nom_zone = 'cra_last_dte' AND id_sin = @iIdSin ) = 0
				BEGIN
					INSERT	sysadm.div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cree_le, maj_le, maj_par, valide_le, valide_par )
						SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, NULL, @dtDate, @dtDate, @sSql, @dtDate, @sSql
						FROM	sysadm.div_pro dp
						WHERE	dp.id_prod	=	@iIdProd
						AND	dp.nom_zone	=	'cra_last_dte'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - INSERT div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10))
						SET @iRet = -1
					END

					IF @iAltWSin > 0
					BEGIN
						INSERT	sysadm.w_div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cpt_valide, cree_le, maj_le, maj_par )
							SELECT	@iIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, @sAltProt, dp.cpt_tri, NULL, 1, @dtDate, @dtDate, @sSql
							FROM	sysadm.div_pro dp
							WHERE	dp.id_prod	=	@iIdProd
							AND	dp.nom_zone	=	'cra_last_dte'

						IF @@ROWCOUNT <> 1
						BEGIN
							SET @sMessErreur = 'ERREUR - INSERT w_div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10))
							SET @iRet = -1
						END		
					END
				END
				ELSE
				BEGIN
					UPDATE	sysadm.div_sin
					SET	val_dte		=	NULL,
						maj_le		=	@dtDate,
						maj_par		=	@sSql
					WHERE	id_sin		=	@iIdSin
					AND	nom_zone	=	'cra_last_dte'

					IF @@ROWCOUNT <> 1
					BEGIN
						SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = NULL'
						SET @iRet = -1
					END

					IF @iAltWSin > 0
					BEGIN
						UPDATE	sysadm.w_div_sin
						SET	cpt_valide	=	1,
							val_dte		=	NULL,
							maj_le		=	@dtDate,
							maj_par		=	@sSql
						WHERE	id_sin		=	@iIdSin
						AND	nom_zone	=	'cra_last_dte'

						IF @@ROWCOUNT <> 1
						BEGIN
							SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_last_dte et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_dte = NULL'
							SET @iRet = -1
						END
					END
				END
				
				-- Insertion dans la table trace_cra_imei : Id_sin, datetime du jour, num_imei_port, num_port, ‘REFDEF’, Code Réponse
				SET	@sIdCodeAction	=	'REFDEF'
				SET	@sValAction	=	cast ( @iCodeReponse as varchar(5) )
				EXEC sysadm.PS_I01_TRACE_CRA_IMEI @iIdSin, @dtDate, @sNumImeiPort, @sNumPort, @sIdTypCodeT, @sIdCodeAction, @sValAction
				IF @@ERROR <> 0
				BEGIN
					SET @sMessErreur = 'ERREUR - PS_I01_TRACE_CRA_IMEI avec id_sin = ' + cast(@iIdSin as varchar(10)) + 'et id_code_action = ' + @sIdCodeAction
					SET @iRet = -1
				END
			END
		END
		-- fin traitement 13

		-- #1 [DCMP070214] PHG
		IF @sTraitement = '21' -- TRAITEMENT GENERIQUE DE DEMANDE DE DEUXIEME CONTROLE
				       -- RAF optimisation : utilisation d'une fonction generique insert/update div_sin/w_div_sin
		BEGIN

			-- print 'traitement 22'

			-- #cra_ctrl_imei# = ‘O’ -- On demande le deuxieme controle dans la table div_sin permanente
			UPDATE	sysadm.div_sin
			SET	val_car		=	'O',
				maj_le		=	@dtDate,
				maj_par		=	@sSql
			WHERE	id_sin		=	@iIdSin
			AND	nom_zone	=	'cra_ctrl_imei'

			IF @@ROWCOUNT <> 1
			BEGIN
				SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_ctrl_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_car = O'
				SET @iRet = -1
			END
			-- On demande le deuxieme controle dans la table w_div_sin temporaire
			-- si l'Occurence existe
			IF 	@iCount > 0
			BEGIN
				UPDATE	sysadm.w_div_sin
				SET	cpt_valide	=	1,
					val_car		=	'O',
					maj_le		=	@dtDate,
					maj_par		=	@sSql
				WHERE	id_sin		=	@iIdSin
				AND	nom_zone	=	'cra_ctrl_imei'

				IF @@ROWCOUNT <> 1
				BEGIN
					SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_ctrl_imei et id_sin = ' + cast(@iIdSin as varchar(10)) + ' avec val_car = O'
					SET @iRet = -1
				END
			END
		END

		-- #1 [DCMP070214] PHG 27/03/2007
		IF @sTraitement = '35' 	-- Refus pour date de dernière utilisation antérieure 
					-- à la date d'adhésion
				       	-- Utilisation de la procédure générique sysadm.PS_CRA_IMEI_TRT_3X_REFUS
		BEGIN
			-- print 'traitement 35'
			exec @iRet = sysadm.PS_CRA_IMEI_TRT_3X_REFUS
				@iIdSin,
				@iIdProd,
				@sNumImeiPort,
				@sNumPort,
				10, /* refus code 10  */
				@dtDteLastUse,
				NULL,
				@dtDate,
				@sMessErreur OUTPUT
				
		END

	END
	-- fin traitement

	-- print 'COMMIT TRAN'
	IF @iRet = 0
	BEGIN
		-- print 'marquage de la ligne traité'
		
		UPDATE sysadm.cra_imei_trt_import
		SET code_pos = '*'
		WHERE id_seq = @iIdSeq

		IF @@ROWCOUNT <> 1
		BEGIN
			SET @sMessErreur = 'ERREUR - UPDATE cra_imei_trt_import pour code_pos = * et id_sin = ' + cast( @iIdSin as varchar(10) )
			ROLLBACK TRAN
			BREAK
		END

		COMMIT TRAN
	END

	/* */
	/* Erreur SQL */
	/* */
	ELSE IF @iRet = -1
	BEGIN
		ROLLBACK TRAN
                
		BEGIN TRAN
		INSERT sysadm.cra_imei_rejet ( type_trait, id_sin, num_imei_port, num_port, date_rejet, message_rejet, type_rejet )
		VALUES ( 'I', @iIdSin, @sNumImeiPort, @sNumPort, @dtDate, @sMessErreur, 'I' )
		COMMIT TRAN
                
		BREAK
	END
	
	/* */
	/* Erreur fonctionnelle - creation contact/travail */
	/* */
	ELSE IF @iRet = -2
	BEGIN
		ROLLBACK TRAN
		
                BEGIN TRAN
		UPDATE	sysadm.cra_imei_trt_import
		SET	code_pos	=	'R'
		WHERE	id_seq		=	@iIdSeq

		IF @@ROWCOUNT <> 1
		BEGIN
			SET @sMessErreur = 'ERREUR - UPDATE cra_imei_trt_import pour code_pos = R et id_sin = ' + cast( @iIdSin as varchar(10) )
			ROLLBACK TRAN
			BREAK
		END
		-- [CRAO_LOT2.010] Correction de la determination de "réponse" pour le rejet
		IF @dtDteLastUse IS NULL Set @sReponse = cast ( @iCodeReponse as varchar(10) )
		IF @iCodeReponse IS NULL Set @sReponse = convert(varchar(10), @dtDteLastUse, 103 )

		INSERT sysadm.cra_imei_rejet ( type_trait, nom_fic, dte_envoi, nom_prenom, id_sin, dte_surv_fic, num_imei_port, num_port, reponse, date_rejet, message_rejet, type_rejet )
		VALUES ( 'I', @sNomFic, CONVERT ( varchar(23), @dtDteEnvoi, 121), @sNomPrenom, @iIdSin, CONVERT ( varchar(23), @dtDteSurvFic, 121), @sNumImeiPort, @sNumPort, @sReponse, @dtDate, @sMessErreur, 'F' )
		COMMIT TRAN
	END
	
	ELSE IF @iRet = -3
	BEGIN
		-- [CRAO_LOT2.003] On ignore les dossiers en code etat Refusé/Réglé/sans suite
		-- Nouveau Code Retour : - 3 : Traitement Ignoré : Marqué comme 'I' / pas de rejet
		-- print 'marquage de la ligne traité en Ignoré 'I' '
		
		UPDATE sysadm.cra_imei_trt_import
		SET code_pos = 'I'
		WHERE id_seq = @iIdSeq

		IF @@ROWCOUNT <> 1
		BEGIN
			SET @sMessErreur = 'ERREUR - UPDATE cra_imei_trt_import pour code_pos = I et id_sin = ' + cast( @iIdSin as varchar(10) )
			ROLLBACK TRAN
			BREAK
		END

		COMMIT TRAN
	END

	FETCH NEXT FROM cursor_cra_trt
	INTO	@iIdSeq,
		@dtDteEnvoi,
		@sNomPrenom,	
		@iIdSin,
		@dtDteSurvFic,
		@sNumImeiPort,
		@sNumPort,
		@dtDteSurvBase,
		@iPeriode,
		@iCodeReponse,
		@dtDteLastUse,
		@sTraitement

END
-- Fin de boucle while

CLOSE cursor_cra_trt
DEALLOCATE cursor_cra_trt

IF @iFetch = 0
BEGIN
	SET @sMessErreur = 'La table de traitement [cra_imei_trt_import] ne contient aucunes lignes pour le fichier ' + @sNomFic + ', le traitement du fichier a échoué'
	RETURN	@iFetch
END

RETURN @iRet

GO

-- ____________________________________________________________________________________________
-- Procedure	:	sysadm.PS_CRA_IMEI_IMPORT_FIC_V01
-- Auteur       :   JCA
-- Date         :   06/06/2007
-- Commentaires :   Maintenance de la procédure d'importation du fichier CRAO
--                  Tentative de tendre vers l'atomicité des opérations ( GOTO )
-- ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CRA_IMEI_IMPORT_FIC_V01' AND type = 'P' )
	DROP PROCEDURE sysadm.PS_CRA_IMEI_IMPORT_FIC_V01
GO

CREATE PROCEDURE sysadm.PS_CRA_IMEI_IMPORT_FIC_V01
	@sNomFic	  varchar(255),
	@sCcimei      varchar(50),
	@sMessErreur  varchar(255) OUTPUT
AS

--------------------------------------------------------------------
--
--        !!!! ATTENTION DEBUT DE LA PROCEDURE CI-DESSUS !!!!
--	  ( Les commentaires sont inclus dans la procédure )
--
-- Procédure            :   PS_CRA_IMEI_IMPORT_FIC_V01
-- Auteur               :   
-- Date                 :   14/02/2007
-- Libellé              :   Procedure de recopie du fichier importé dans la table temporaire 
--			    vers la table de traitement
-- Commentaires         :   Mise à jour des tables de gestion
-- Références           :   cra_imei_trt_import, div_sin, w_divsin
--
-- Arguments            :   @sCcimei		varchar(50)		Centre Technique de Controle IMEI
--			    @sNomFic		varchar(35)		Nom du Fichier Traité
--			    @sMessErreur	varchar(255) OUTPUT	byREf : Message d'erreur retourné.
--
-- Retourne             :   Code retour T-SQL Standard
--				  
--------------------------------------------------------------------
-- MAJ	PAR	LE		TAG		Description
-- #1	PHG	27/03/2007	[DCMP070214]	Refus sur Date de Sous > Date Dernière Utilisation.
--						- Création de 2 codes traitement : 21 et 35
-- #2   JCA 	05/06/2007  	DCMP 070360	Controle de validité du format des colonnes
-- #3	PHG	01/03/2010	[DCMP100115]	Ajout d'un délai de 48h pour accepter le controle IMEI
--------------------------------------------------------------------

DECLARE @sDteEnvoi	varchar(10),
	@sNomPrenom	varchar(71),
	@sIdSin		varchar(10),
	@sDteSurvFic	varchar(10),
	@sNumImeiPort	varchar(25),
	@sNumPort	varchar(25),
	@sReponse	varchar(10),
	
	-- Gestion boucle de vérification
	@iFetch		integer,
	@iRet		integer,
	@dtDteSurvBase	datetime,
	@dtDteAdh	datetime,	-- #1 [DCMP070214] Date de d'adhésion
	@iPeriode	integer,
	@iCodeReponse	integer,
	@dtDteLastUse	datetime,
--	@iGti		integer, -- [CRAO_LOT2.007] on ne lit plus IdGti, 
--				 -- mais un AltGti11 indiquant si Gti 11 ou pas
	@sAltGti11	varchar(1),-- [CRAO_LOT2.007] Indicateur de présence d'une garantie 11
	@sDateRejet	varchar(23),
	@sTraitement	varchar(2),
	
	-- Paramétrage
	@iCraCptDmde	integer,
	-- Trace
	@iIdSin		integer,
 	@dtDate		datetime,
	@sValAction varchar(25),
	@sCodePos   varchar(1)

-- initialisation de la valeur de retour des procédures appelées
SET @iRet	=	0

SET @sDateRejet	=	cast( getdate() as varchar(23))

SET NOCOUNT ON

DECLARE	cursor_cra_import	CURSOR	FOR
SELECT	dte_envoi,
	nom_prenom,
	id_sin,
	dte_surv_fic,
	num_imei_port,
	num_port,
	reponse
FROM	sysadm.tmp_cra_import_orv

OPEN cursor_cra_import

FETCH NEXT FROM cursor_cra_import
INTO	@sDteEnvoi,
	@sNomPrenom,
	@sIdSin,
	@sDteSurvFic,
	@sNumImeiPort,
	@sNumPort,
	@sReponse

SET @iFetch = @@FETCH_STATUS

WHILE @@FETCH_STATUS = 0
BEGIN

    -- ____________________
    -- #2
    -- ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    SET @sCodePos   = NULL

    -- ________________ --
    -- Controle de validité de la ligne en cours de traitement
    -- ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ --
    EXEC @iRet = sysadm.PS_CRA_IMEI_IMPORT_CTRL_FIC_V01 @sNomFic, @sDteEnvoi, @sNomPrenom, @sIdSin, @sDteSurvFic, @sNumImeiPort, @sNumPort, @sReponse, @sMessErreur

    -- ________________ --
    -- Si une des colonnes est en erreur on notifie la ligne en rejet fonctionnel 
    -- ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ --
    IF @iRet <> 0
    BEGIN

        SET @iRet = 0 -- le rejet fonctionnel ne doit pas stopper le traitement
        
		FETCH NEXT FROM cursor_cra_import
		INTO	@sDteEnvoi,
    			@sNomPrenom,
    			@sIdSin,
    			@sDteSurvFic,
    			@sNumImeiPort,
    			@sNumPort,
    			@sReponse
		
		CONTINUE
    END
    -- ____________________
    -- #2 - FIN
    -- ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯

	-- Code déporté et adapté de PS_CRA_IMEI_IMPORT_TRT
	-- On mémorise l'evenement réception du fichier pour le sinistre dans la table de trace
    BEGIN TRAN

	Set 	@iIdSin 	= cast (@sIdSin as decimal(10,0))  -- [PI062]
 	Set 	@dtDate 	= cast (@sDateRejet as datetime)
	SET	@sValAction	= CONVERT ( varchar(25), @dtDate, 121 )

	EXEC sysadm.PS_I01_TRACE_CRA_IMEI @iIdSin, @dtDate, @sNumImeiPort, @sNumPort, '-SC', 'RECEPT', @sValAction
	COMMIT TRAN -- Cette gestion des Commit/Rollback sera revue..
	--

	SET @sAltGti11	= 'N' -- [CRAO_LOT2.007] Du fait du curseur, on s'assure de l'initialisation de la variable  

	-- #1 [DCMP070214] PHG 27/03/2007 On lit la date de survenance et la date d'adhesion
		-- contrôle du sinistre et récupération de la date de survenance en base
		-- SELECT	@dtDteSurvBase = s.dte_surv/*,
		--	@iGti = gs.id_gti*/ -- [CRAO_LOT2.007] on ne lit que la date de surv
		-- FROM	sysadm.sinistre s
		-- /*INNER JOIN sysadm.gar_sin gs
		-- 	ON s.id_sin = gs.id_sin*/ -- [CRAO_LOT2.007] on ne lit que la date de surv
		-- WHERE	s.id_sin	=	cast ( @sIdSin as decimal(7,0) )
	-- Remplacé par ( pour lisibilité ) : 
	SELECT	@dtDteSurvBase = s.dte_surv, 
		@dtDteAdh = s.dte_adh -- #1 [DCMP070214] PHG 27/03/2007 : dte_sous n'est pas tjrs renseigné, on lit donc dte_adh
	FROM	sysadm.sinistre s
	WHERE	s.id_sin	=	cast ( @sIdSin as decimal(10,0) )  -- [PI062]
	
	IF @@ROWCOUNT <> 1
	BEGIN
		-- #1 [DCMP070214] PHG 27/03/2007 Suite ci-dessus, modification du message en conséquence
		-- SET @sMessErreur = 'Il n''y a pas de date de survenance pour le sinistre numéro : ' + @sIdSin
		-- Remplacé par :
		SET @sMessErreur = 'Pas de sinistre trouvé en base pour le sinistre numéro : ' + @sIdSin

		BEGIN TRAN
 		-- trace dans la table de rejet
		INSERT sysadm.cra_imei_rejet ( type_trait, nom_fic, dte_envoi, nom_prenom, id_sin, dte_surv_fic, num_imei_port, num_port, reponse, date_rejet, message_rejet, type_rejet )
		VALUES ( 'I', @sNomFic, @sDteEnvoi, @sNomPrenom, @sIdSin, @sDteSurvFic, @sNumImeiPort, @sNumPort, @sReponse, @sDateRejet, @sMessErreur, 'F' )
		COMMIT TRAN
 		
		FETCH NEXT FROM cursor_cra_import
		INTO	@sDteEnvoi,
			@sNomPrenom,
			@sIdSin,
			@sDteSurvFic,
			@sNumImeiPort,
			@sNumPort,
			@sReponse
		
		CONTINUE
	END

	-- [CRAO_LOT2.007] Détection de l'existence de la Garantie 11
	SELECT	@sAltGti11 = 	CASE sysadm.FN_TRIM(cast (count(gs.id_gti) as varchar(2)))
					WHEN '0' THEN 'N'
					ELSE 'O'
				END
	FROM	sysadm.sinistre s
	INNER JOIN sysadm.gar_sin gs
		ON s.id_sin = gs.id_sin
	WHERE	s.id_sin 	= cast ( @sIdSin as decimal(10,0) ) -- [PI062]
	and 	gs.id_gti	= 11 -- Garantie Bris
	
	IF @@ROWCOUNT <> 1
	BEGIN
		SET @sMessErreur = 'Identification des garanties ouvertes pour le sinistre numéro : ' + @sIdSin + ' impossible.'

		BEGIN TRAN
 		-- trace dans la table de rejet
		INSERT sysadm.cra_imei_rejet ( type_trait, nom_fic, dte_envoi, nom_prenom, id_sin, dte_surv_fic, num_imei_port, num_port, reponse, date_rejet, message_rejet, type_rejet )
		VALUES ( 'I', @sNomFic, @sDteEnvoi, @sNomPrenom, @sIdSin, @sDteSurvFic, @sNumImeiPort, @sNumPort, @sReponse, @sDateRejet, @sMessErreur, 'F' )
		COMMIT TRAN
 		
		FETCH NEXT FROM cursor_cra_import
		INTO	@sDteEnvoi,
			@sNomPrenom,
			@sIdSin,
			@sDteSurvFic,
			@sNumImeiPort,
			@sNumPort,
			@sReponse
		
		CONTINUE
	END
	-- [CRAO_LOT2.007] Fin Détection de l'existence de la Garantie 11

	-- Récupération des paramétres sur div_sin pour le sinistre en cours
	SELECT	@iCraCptDmde	=	val_nbre
	FROM	sysadm.div_sin
	WHERE	id_sin		=	cast ( @sIdSin as decimal(10,0) )  -- [PI062]
	AND	nom_zone	=	'cra_cpt_dmde'
	
	IF @@rowcount <> 1
	BEGIN

		SET @sMessErreur = 'Erreur dans le paramétrage, vérifier le compteur de demande pour le sinistre numéro : ' + @sIdSin
		
		BEGIN TRAN
		-- trace dans la table de rejet		
		INSERT cra_imei_rejet ( type_trait, nom_fic, dte_envoi, nom_prenom, id_sin, dte_surv_fic, num_imei_port, num_port, reponse, date_rejet, message_rejet, type_rejet )
		VALUES ( 'I', @sNomFic, @sDteEnvoi, @sNomPrenom, @sIdSin, @sDteSurvFic, @sNumImeiPort, @sNumPort, @sReponse, @sDateRejet, @sMessErreur, 'F' )
		COMMIT TRAN

		FETCH NEXT FROM cursor_cra_import
		INTO	@sDteEnvoi,
    			@sNomPrenom,
    			@sIdSin,
    			@sDteSurvFic,
    			@sNumImeiPort,
    			@sNumPort,
    			@sReponse
		
		CONTINUE
	END
    
	IF ISDATE ( @sReponse ) = 1
	BEGIN
		SET @iPeriode		=	datediff ( day, @sReponse, @dtDteSurvBase )
		SET @iCodeReponse	=	NULL
		SET @dtDteLastUse	=	@sReponse
	END

	ELSE
	BEGIN
		SET @iPeriode		=	NULL
		SET @iCodeReponse	=	cast ( @sReponse as integer )
		SET @dtDteLastUse	=	NULL
	END

	-- DEBUT - cas de traitement
	--Si Dte_last_use est renseignée
	IF @dtDteLastUse IS NOT NULL
	BEGIN
		-- [DCMP070214] TAg pour Analyse :
		-- Si DDU < date D'adhesion
		--	Si Compteur de Demande <= 1 alors
		--		Faire une deuxieme demande de controle
		--	Sinon
		--		Emettre un Refus 'Refus DDU < Date de Souscription : IMEI REFUSE'
		--	Fsi
		-- Fsi
		-- #1 [DCMP070214] PHG On effectue le test d'antériorité de la DDU par rapport à la date d'adhésion
		IF @dtDteLastUse < @dtDteAdh
		BEGIN
			IF @iCraCptDmde <= 1		-- Si 1 seul controle fait on effectue une deuxiemme dmde.
				SET @sTraitement = '21' -- Appel Traitement générique demande deuxieme controle.
			ELSE				-- Sinon, 2eme dmde déja faite => refus.
				SET @sTraitement = '35' -- Appel Traitement générique de refus.
		END 
		ELSE
		BEGIN -- Fin #1 reprise des cas existant.
			IF @iPeriode >= 0
			BEGIN
				IF  @iPeriode <= 30
					SET @sTraitement = '1'
				ELSE
				BEGIN
					IF @iCraCptDmde = 1
						SET @sTraitement = '2'
					ELSE
						SET @sTraitement = '3'
				END 
			END 
			ELSE
			BEGIN
				-- [CRAO_LOT2.007] Utilisation de la detection de la garantie 11
				-- IF @iGti = 11
				-- remplace par :
				IF @sAltGti11 = 'O'
					SET @sTraitement = '4'
				ELSE
				BEGIN
					-- [DCMP100115] Ajout d'un délai de 48h pour accepter le controle IMEI
					IF ABS(@iPeriode)<= 2
					BEGIN
						SET @sTraitement = '1'	-- Controle IMEI Ok 
									-- si DDU dans délai de 48h apres Sinistre
					END
					ELSE
					BEGIN
						IF @iCraCptDmde <= 1
							SET @sTraitement = '5'
						ELSE
							SET @sTraitement = '6'
					END
				END 
			END 
		END 
	END
	ELSE
	BEGIN
		IF @iCodeReponse = 3
			SET @sTraitement = '7'

		IF @iCodeReponse = 4
			SET @sTraitement = '8'

-- [CRAO_LOT2.003] Suite Retour MOA, Cas 11 déplacé hors demande 2 emme Controle
		IF @iCodeReponse = 9 OR ( SELECT count(*) FROM code WHERE id_typ_code = '-RC' AND id_code = @iCodeReponse ) = 0
			SET @sTraitement = '11'
-- [Fin CRA_LOT2.003] 
--		IF @iCodeReponse <> 3 AND @iCodeReponse <> 4 	-- ancien algo: @iCodeReponse = 0 OR @iCodeReponse = 1 OR @iCodeReponse = 2
						 		-- [CRAO_LOT2.003] PHG : L'equation doit être CodeRep <>3 *ET* CodeRep <>4 => Faux
								-- Reprise de l'ancient algo 
		IF @iCodeReponse = 0 OR @iCodeReponse = 1 OR @iCodeReponse = 2
		BEGIN
			IF @iCraCptDmde = 1 
				SET @sTraitement = '9'
			ELSE
			BEGIN
-- [CRAO_LOT2.003] Suite Retour MOA, Cas 11 déplacé hors demande 2 emme Controle
/*				IF @iCodeReponse = 1
					SET @sTraitement = '10'
				ELSE
				BEGIN	
					IF @iCodeReponse = 9 OR ( SELECT count(*) FROM code WHERE id_typ_code = '-RC' AND id_code = @iCodeReponse ) = 0
						SET @sTraitement = '11'
					ELSE
					BEGIN
						IF @iCodeReponse = 0
							SET @sTraitement = '12'

						IF @iCodeReponse = 2
							SET @sTraitement = '13'
					END
				END*/
-- REMPLACE PAR
				IF @iCodeReponse = 1
					SET @sTraitement = '10'
				IF @iCodeReponse = 0
					SET @sTraitement = '12'
				IF @iCodeReponse = 2
					SET @sTraitement = '13'
			END
		END
	END
	-- FIN - cas de traitement
	
	-- Début transaction ligne à ligne
	BEGIN TRAN

	INSERT sysadm.cra_imei_trt_import
	VALUES ( @sNomFic, @sDteEnvoi, @sNomPrenom, cast( @sIdSin as decimal(10,0) ), cast( @sDteSurvFic as datetime), @sNumImeiPort, @sNumPort, @dtDteSurvBase, @iPeriode, @iCodeReponse, @dtDteLastUse, @sTraitement, @sCodePos ) -- [PI062]

	IF @@ROWCOUNT <> 1
	BEGIN
		
		-- print 'Erreur : INSERT cra_imei_trt_import'
		
		SET @sMessErreur = 'L''insertion dans la table de traitement a échoué, sinistre numéro : ' + @sIdSin
		SET @iRet = -1
		
	END

	IF @iRet = 0
		COMMIT TRAN
	ELSE
	BEGIN
	
		-- print '@iRet <> 0; ROLLBACK TRAN'
		
		ROLLBACK TRAN
			
		BEGIN TRAN
		-- trace dans la table de rejet
		INSERT sysadm.cra_imei_rejet ( type_trait, nom_fic, dte_envoi, nom_prenom, id_sin, dte_surv_fic, num_imei_port, num_port, reponse, date_rejet, message_rejet, type_rejet )
		VALUES ( 'I', @sNomFic, @sDteEnvoi, @sNomPrenom, @sIdSin, @sDteSurvFic, @sNumImeiPort, @sNumPort, @sReponse, @sDateRejet, @sMessErreur, 'I' )
		COMMIT TRAN
		
		BREAK
	END
	
	FETCH NEXT FROM cursor_cra_import
	INTO	@sDteEnvoi,
		@sNomPrenom,
		@sIdSin,
		@sDteSurvFic,
		@sNumImeiPort,
		@sNumPort,
		@sReponse

END
-- Fin de boucle while

IF @iFetch <> 0
BEGIN
	SET	@sMessErreur	= 'La table temporaire est vide, l''importation du fichier a échouée'
	SET	@iRet		= -1

	-- trace dans la table de rejet
        BEGIN TRAN                        
	INSERT sysadm.cra_imei_rejet ( type_trait, nom_fic, dte_envoi, nom_prenom, id_sin, dte_surv_fic, num_imei_port, num_port, reponse, date_rejet, message_rejet, type_rejet )
	VALUES ( 'I', @sNomFic, @sDteEnvoi, @sNomPrenom, @sIdSin, @sDteSurvFic, @sNumImeiPort, @sNumPort, @sReponse, @sDateRejet, @sMessErreur, 'I' )
        COMMIT TRAN
END

CLOSE cursor_cra_import
DEALLOCATE cursor_cra_import

RETURN @iRet

GO


----------------------------------------------------------------------------------------------------------------------------------------
-- Procedure	:	PS_CRA_IMEI_IMPORT_CTRL_FIC_V01
-- Commentaires	:	Procedure de recopie du fichier importée dans la table temporaire vers la table de traitement
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CRA_IMEI_IMPORT_CTRL_FIC_V01' AND type = 'P' )
	DROP PROCEDURE sysadm.PS_CRA_IMEI_IMPORT_CTRL_FIC_V01
GO

CREATE PROCEDURE sysadm.PS_CRA_IMEI_IMPORT_CTRL_FIC_V01
    @sNomFic	varchar(255),
    @sDteEnvoi   varchar(23),
	@sNomPrenom   varchar(71),
	@sIdSin       varchar(10),
	@sDteSurvFic  varchar(23),
	@sNumImeiPort varchar(25),
	@sNumPort     varchar(25),
	@sReponse     varchar(10),	
    @sMessErreur varchar(255) OUTPUT
AS

DECLARE 
-- Gestion boucle de vérification
	@iFetch		integer,
	@iRet		integer,
	@dtDateRejet	datetime,
	@iIdSinDoublon	integer,
	@sTypeTraitement varchar(1),
    @sTypeRejet varchar(1)
    
SET @dtDateRejet	= getdate()

-- initialisation de la valeur de retour des procédures appelées
SET @iRet	= 0

SET NOCOUNT ON

-- controle si champs obligatoires sont bien renseignés dans le fichier
-- print '@sDteEnvoi : ' + @sDteEnvoi
IF @sDteEnvoi IS NULL
BEGIN
--	SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[dte_envoi] est nulle pour le sinistre numéro : ' + @sIdSin
	SET @sMessErreur = 'La donnée [dte_envoi] est nulle pour le sinistre numéro : ' + @sIdSin	SET @iRet = -1
END

IF ISDATE ( @sDteEnvoi ) = 0 AND @iRet = 0
BEGIN
--	SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[dte_envoi] n''est pas une date valide pour le sinistre numéro : ' + @sIdSin
    SET @sMessErreur = 'La donnée [dte_envoi] n''est pas une date valide pour le sinistre numéro : ' + @sIdSin	SET @iRet = -1
END

-- print '@sNomPrenom : ' + @sNomPrenom
IF @sNomPrenom IS NULL  AND @iRet = 0
BEGIN
--	SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[nom_prenom] est nulle pour le sinistre numéro : ' + @sIdSin
	SET @sMessErreur = 'La donnée [nom_prenom] est nulle pour le sinistre numéro : ' + @sIdSin	
    SET @iRet = -1
END

-- print '@sIdSin : ' + @sIdSin
IF @sIdSin IS NULL AND @iRet = 0
BEGIN
--	SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[id_sin] est nulle pour le sinistre numéro : ' + @sIdSin
	SET @sMessErreur = 'La donnée [id_sin] est nulle '
    SET @iRet = -1
END

IF LEN ( @sIdSin ) > 10 AND @iRet = 0  -- [PI062]
BEGIN
--	SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[id_sin] est supérieur d''une longueur à 7 pour le sinistre numéro : ' + @sIdSin
	SET @sMessErreur = 'La donnée [id_sin] est supérieur d''une longueur à 10 pour le sinistre numéro : ' + @sIdSin  -- [PI062]
	SET @iRet = -1
END

IF ISNUMERIC ( @sIdSin ) = 0 AND @iRet = 0
BEGIN
--	SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[id_sin] n''est pas un numérique pour le sinistre numéro : ' + @sIdSin
	SET @sMessErreur = 'La donnée [id_sin] n''est pas un numérique pour le sinistre numéro : ' + @sIdSin	
    SET @iRet = -1
END

-- print '@sDteSurvFic : ' + @sDteSurvFic
IF @sDteSurvFic IS NULL AND @iRet = 0
BEGIN
--	SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[dte_surv] est nulle pour le sinistre numéro : ' + @sIdSin
	SET @sMessErreur = 'La donnée [dte_surv] est nulle pour le sinistre numéro : ' + @sIdSin
	SET @iRet = -1
END

IF ISDATE ( @sDteSurvFic ) = 0 AND @iRet = 0
BEGIN
--	SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[dte_surv] n''est pas une date valide pour le sinistre numéro : ' + @sIdSin
	SET @sMessErreur = 'La donnée [dte_surv] n''est pas une date valide pour le sinistre numéro : ' + @sIdSin	SET @iRet = -1
END

-- print '@sNumImeiPort : ' + @sNumImeiPort
IF @sNumImeiPort IS NULL AND @iRet = 0
BEGIN
--	SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[num_imei_port] est nulle pour le sinistre numéro : ' + @sIdSin
	SET @sMessErreur = 'La donnée [num_imei_port] est nulle pour le sinistre numéro : ' + @sIdSin
	SET @iRet = -1
END

IF LEN ( @sNumImeiPort ) <> 15 AND @iRet = 0
BEGIN
--	SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[num_imei_port] est d''une longueur supérieure à 15 pour le sinistre numéro : ' + @sIdSin
	SET @sMessErreur = 'La donnée [num_imei_port] est d''une longueur supérieure à 15 pour le sinistre numéro : ' + @sIdSin
	SET @iRet = -1
END

IF ISNUMERIC ( @sNumImeiPort ) = 0 AND @iRet = 0
BEGIN
--	SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[num_imei_port] n''est pas un numérique pour le sinistre numéro : ' + @sIdSin
	SET @sMessErreur = 'La donnée [num_imei_port] n''est pas un numérique pour le sinistre numéro : ' + @sIdSin
	SET @iRet = -1
END

-- print '@sNumPort : ' + @sNumPort
IF @sNumPort IS NULL AND @iRet = 0
BEGIN
--	SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[num_port] est nulle pour le sinistre numéro : ' + @sIdSin
	SET @sMessErreur = 'La donnée [num_port] est nulle pour le sinistre numéro : ' + @sIdSin	
    SET @iRet = -1
END

IF LEN ( @sNumPort ) <> 10 AND @iRet = 0
BEGIN
--	SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[num_port] est d''une longueur supérieur à 10 pour le sinistre numéro : ' + @sIdSin
	SET @sMessErreur = 'La donnée [num_port] est d''une longueur supérieur à 10 pour le sinistre numéro : ' + @sIdSin	
    SET @iRet = -1
END	
	
IF ISNUMERIC ( @sNumPort ) = 0 AND @iRet = 0
BEGIN
--	SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[num_port] n''est pas un numérique pour le sinistre numéro : ' + @sIdSin
	SET @sMessErreur = 'La donnée [num_port] n''est pas un numérique pour le sinistre numéro : ' + @sIdSin
	SET @iRet = -1
END

-- print '@sReponse : ' + @sReponse
IF @sReponse IS NULL AND @iRet = 0
BEGIN
--	SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[reponse] est nulle pour le sinistre numéro : ' + @sIdSin
	SET @sMessErreur = 'La donnée [reponse] est nulle pour le sinistre numéro : ' + @sIdSin
	SET @iRet = -1
END

IF ( ISNUMERIC ( @sReponse ) = 0 AND ISDATE ( @sReponse ) = 0 ) AND @iRet = 0
BEGIN
--	SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[reponse] n''est ni une date ni un numérique pour le sinistre numéro : ' + @sIdSin
	SET @sMessErreur = 'La donnée [reponse] n''est ni une date ni un numérique pour le sinistre numéro : ' + @sIdSin
	SET @iRet = -1
END

-- trace dans la table de rejet
IF @iRet <> 0
BEGIN
    
--     print 'Erreur : ' + @sMessErreur
     
	-- print 'INSERT cra_imei_rejet'
	SET @sTypeTraitement = 'I'
	SET @sTypeRejet = 'F'
	SET @sDteEnvoi = CONVERT ( varchar(23), cast( @sDteEnvoi as datetime ), 121)
	SET @sDteSurvFic = CONVERT ( varchar(23), cast( @sDteSurvFic as datetime ), 121)
	
    BEGIN TRAN
	EXEC sysadm.PS_I01_CRA_IMEI_REJET @sTypeTraitement, @sNomFic, @sDteEnvoi, @sNomPrenom, @sIdSin, @sDteSurvFic, @sNumImeiPort, @sNumPort, @sReponse, @dtDateRejet, @sMessErreur, @sTypeRejet
    COMMIT TRAN
END

RETURN @iRet

GO


----------------------------------------------------------------------------------------------------------------------------------------
-- Procedure		:	PS_CRA_IMEI_IMPORT
-- Commentaires	:	Procedure d'import du fichier de contrôle IMEI
-------------------------------------------------------------------
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CRA_IMEI_IMPORT' AND type = 'P' )
	DROP PROCEDURE sysadm.PS_CRA_IMEI_IMPORT
GO

CREATE PROCEDURE sysadm.PS_CRA_IMEI_IMPORT
	@sCcimei		varchar(50)
AS

DECLARE
	@iErr			integer,
	@sBcp			varchar(500),
	@sOption		varchar(255),
	@sConnex		varchar(255),
	@sNomServeur		varchar(255),
	@sBase			varchar(255),
	@sTable			varchar(255),
	@sQueryout		varchar(500),
	@sFileExist		varchar(255),
	@sRep			varchar(255),
	@sNomFic		varchar(255),
	@sNomFicRejetBcp	varchar(255),
	@sNomFicRejetFonc	varchar(255),
	@sMailInformatique	varchar(255),
	@sMailGestion		varchar(255),
	@sRetourErrMail 	varchar(255),
	@sFicAttach		varchar(255),
	@sMessage		varchar(510),
	@sMessErreur		varchar(255),
	@sDateRejet		varchar(23),
	@dtDateTraitement	datetime, -- date de traitement fonctionnel
	@dtTrt			datetime  -- date de traitement réel

DECLARE @sStatCrao varchar(255)	
		
SET @sMessErreur	= SPACE(255)
SET @dtTrt		= getdate()
SET @sDateRejet		= cast( @dtTrt as varchar(23))
SET @dtDateTraitement	= @dtTrt - 1

SET NOCOUNT ON


-- On crée une table temporaire pour la procédure stockée étendue xp_fileexist.
IF	( SELECT object_id ( 'tempdb.dbo.#TblFileExistsImportCra' ) ) > 0
BEGIN
	EXEC ('Drop table #TblFileExistsImportCra' )
END

CREATE TABLE #TblFileExistsImportCra
(
	FileExists		TINYINT	NULL,
	FileIsDirectory		TINYINT	NULL,
	ParentDirectoryExists   TINYINT NULL
)

SELECT	@sRep = rtrim ( val_car )
FROM	sysadm.det_pro dp
WHERE	dp.id_prod	=	( SELECT TOP 1 id_prod 
 					FROM sysadm.det_pro dp
 					WHERE	dp.id_typ_code_dp	=	'-DP'
 					AND	dp.id_code_dp		=	75
 					AND	dp.id_typ_calc		=	'-PC'
					AND	dp.id_code_car		=	'CTIMEI'
					AND	dp.val_car		=	@sCcimei
				)
AND		dp.id_typ_code_dp	=	'-DP'
AND		dp.id_code_dp		=	75
AND		dp.id_typ_calc		=	'-PC'
AND		dp.id_code_car		=	'PATHIM'

-- !!!!! Uniquement pour les tests !!!!!
--       ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
-- écrit le fichier sur le serveur FIL
-- SET @sRep		=	'c:\temp\crao\'
-- FIN !!!!! Uniquement pour les tests !!!!!
-- ¯¯¯       ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯

-- definition des adresses email 
--¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
-- ** Mail Informatique
-- Modif : PHG, 02/03/2007 = Basculement en cas de production pour mail info
-- cas de debbugage
--¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
-- SET @sMailInformatique	=	'jca@spb.fr, phg@spb.fr, dga@spb.fr'
-- SET @sMailInformatique	=	'jca@spb.fr'

-- cas de production
--¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
SET @sMailInformatique	=	'productioninformatique@spb.fr, etudessinistres@spb.fr'

-- ** Mail de gestion
-- Cas de debbugage
--¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
-- SET @sMailGestion	=	'jca@spb.fr, phg@spb.fr, dga@spb.fr'
-- SET @sMailGestion	=	'jca@spb.fr, nid@spb.fr, phg@spb.fr'

-- cas de production
-- ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
SET @sMailGestion	=	'supportDNT@spb.fr'

-- construction du nom de fichier d'import
-- ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
SET @sNomFic	=	'CON_'	+
			@sCcimei	+ 	'_'	+
			RIGHT ( '00' + CONVERT (varchar(2), DatePart ( day, @dtDateTraitement ) ),  2 )	+
			RIGHT ( '00' + CONVERT ( varchar(2), DatePart ( month, @dtDateTraitement ) ),  2 )	+ 
			CONVERT ( varchar(4), DatePart ( year, @dtDateTraitement ) ) +
			'.txt'

SET @sFileExist = @sRep + @sNomFic

-- print '@sNomFic : ' + @sNomFic

-- __________________
-- vérification si le fichier à importer existe sur le serveur
-- ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
INSERT INTO #TblFileExistsImportCra EXEC master.dbo.xp_fileexist @sFileExist
IF ( SELECT FileExists FROM #TblFileExistsImportCra ) = 0
BEGIN
	SET @sMessErreur = 'Le fichier ' + @sFileExist + ' n''existe pas. Le traitement est impossible.'
	EXEC master.dbo.SPB_PS_MAIL @sRetourErrMail OUTPUT, @sMailInformatique, @sMessErreur, 'Erreur traitement import fichier CRA'
	RETURN -1
END

-- _________________
-- construction du nom de fichier de rejet de bcp
-- ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
SET @sNomFicRejetBcp	=	'CON_'		+
				@sCcimei	+ 	'_'	+
				RIGHT ( '00' + CONVERT (varchar(2), DatePart (day, @dtDateTraitement ) ),  2 )	+
				RIGHT ( '00' + CONVERT ( varchar(2), DatePart ( month, @dtDateTraitement ) ),  2 )	+ 
				CONVERT ( varchar(4), DatePart ( year, @dtDateTraitement ) )	+
				'.BAD'

-- print '@sNomFicRejetBcp : ' + @sNomFicRejetBcp

-- _________________
-- construction du nom de fichier de rejet de bcp
-- ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
SET @sNomFicRejetFonc	=	'CON_'		+
				@sCcimei	+ 	'_'	+
				RIGHT ( '00' + CONVERT (varchar(2), DatePart ( day, @dtDateTraitement ) ),  2 )	+
				RIGHT ( '00' + CONVERT ( varchar(2), DatePart ( month, @dtDateTraitement ) ),  2 )	+ 
				CONVERT ( varchar(4), DatePart ( year, @dtDateTraitement ) )	+
				'.REJ'

-- print '@sNomFicRejetFonc : ' + @sNomFicRejetFonc

-- __________________
-- option bcp -m : nombre erreurs autorisé, -c : importe les données au format caractère
-- ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯

-- __________________
-- [CRAO_LOT2.003] On ne sait pas lire la taille d'un fichier depuis SQL serveur.
-- On ne peut donc pas tester la taille du fichier .BAD
-- ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯

-- __________________
-- On sort donc sur la premiere erreur.
-- SET @sOption	=	' -m9999 -c'
-- remplacé par :
-- ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
SET @sOption	=	' -m1 -c'

-- paramètre d'authentification sur le serveur
-- Modif le 14/03/2011 - Datafly
--SET @sConnex	=	' -Usysadm -P' + lower ( @@servername ) + '_sysadm -S' + @@servername
SET @sConnex	=	' -T -S' + @@servername -- [I027] En sql 2008, la connexion approuvee passe de -E à-T

-- on regarde si le serveur utilisé est un serveur de production
IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	SET @sBase	=	'SIMPA2_PRO'
ELSE
	SET @sBase	=	'SIMPA2_TRT'

-- _________________	
-- table temporaire d'import en fonction du flux entrant
-- ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
SET @sTable	=	'sysadm.tmp_cra_import_orv'

-- _________________
-- on verifie si le traitement c'est bien passé
-- ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
IF ( SELECT count(*) FROM sysadm.cra_imei_trt_import WHERE code_pos IS NULL AND nom_fic = @sNomFic ) = 0
BEGIN
	-- print 'PS_CRA_IMEI_TRT_RELICAT'

	-- traitement des relicats sur w_queue pour l'opérateur CRAO
	EXEC @iErr = sysadm.PS_CRA_IMEI_TRT_RELICAT 281, @sMessErreur OUTPUT
	IF @iErr <> 0
	BEGIN
		
		-- print  'Error PS_CRA_IMEI_TRT_RELICAT'
		-- print  @sMessErreur

		INSERT sysadm.cra_imei_rejet ( type_trait, date_rejet, message_rejet, type_rejet )
		VALUES ( 'I', @sDateRejet, 'Relicat en erreur : ' + @sMessErreur, 'I' )
	END

	-- [I027] - France - Suppression instruction incompatible réplication transactionelle
	-- print 'EXEC ( ''TRUNCATE TABLE '' + @sTable )'
	-- print 'EXEC ( ''DELETE FROM '' + @sTable )'
	
	-- vidage de la table temporaire pour import du fichier via l'utilitaire bcp.
	--EXEC ( 'TRUNCATE TABLE ' + @sTable )
	EXEC ( 'DELETE FROM ' + @sTable )
	
	-- construction de la chaine de bcp passée à xp_cmdshell
	SET @sBcp = 'bcp ' + @sBase + '.' + @sTable + ' in "' + @sRep + @sNomFic + '" -e "' + @sRep + @sNomFicRejetBcp + '"' + @sOption + @sConnex
	
	-- print '@sBcp : ' + @sBcp 
	
	EXEC @iErr = master.dbo.xp_cmdshell @sBcp

	IF @@ERROR <> 0 OR @iErr <> 0
	BEGIN
	
		-- print 'Error master.dbo.xp_cmdshell @sBcp'

		SET @sMessage  = 'ATTENTION : Contacter le service DEI.' + char(13) + 'ERREUR de l''import du fichier : ' + @sNomFic + char(13) + char(10) + 'Erreur retournée par bcp : ' + cast(@iErr as varchar(10)) + ' Erreur @@error : ' + cast(@@ERROR as varchar(10)) + ' Chaine BCP : ' + @sBcp
		EXEC master.dbo.SPB_PS_MAIL @sRetourErrMail OUTPUT, @sMailInformatique, @sMessage, 'Erreur traitement import fichier CRA'
		
	END
	ELSE
	BEGIN
	
		-- print 'PS_CRA_IMEI_IMPORT_CTRL_FIC'
		
--		EXEC @iErr = sysadm.PS_CRA_IMEI_IMPORT_CTRL_FIC @sNomFic, @sMessErreur OUTPUT
		
--		IF @@ERROR <> 0 OR @iErr <> 0
--		BEGIN
		
			-- print 'Error PS_CRA_IMEI_IMPORT_CTRL_FIC'
			
--			SET @sMessage  = 'ATTENTION : Contacter le service DEI.' + char(13) + 'Erreur remontée : ' + @sMessErreur + char(13) + char(10)
--			EXEC master.dbo.SPB_PS_MAIL @sRetourErrMail OUTPUT, @sMailInformatique, @sMessage, 'Erreur traitement import fichier CRA'			
			
--		END
--		ELSE
--		BEGIN
		
			-- print 'PS_CRA_IMEI_IMPORT_FIC'

			EXEC @iErr = sysadm.PS_CRA_IMEI_IMPORT_FIC_V01 @sNomFic, @sCcimei, @sMessErreur OUTPUT
			
			IF @@ERROR <> 0 OR @iErr <> 0
			BEGIN
			
				-- print 'Error PS_CRA_IMEI_IMPORT_FIC'
				
				SET @sMessage  = 'ATTENTION : Contacter le service DEI.' + char(13) + 'Erreur remontée : ' + @sMessErreur + char(13) + char(10)
				EXEC master.dbo.SPB_PS_MAIL @sRetourErrMail OUTPUT, @sMailInformatique, @sMessage, 'Erreur traitement import fichier CRA'
			END
		 	ELSE
			BEGIN
			
				-- print 'PS_CRA_IMEI_IMPORT_TRT'
				
				EXEC @iErr = sysadm.PS_CRA_IMEI_IMPORT_TRT @sCcimei, @sNomFic, @sMessErreur OUTPUT
				IF @@ERROR <> 0 OR @iErr <> 0
				BEGIN
				
					-- print 'Error PS_CRA_IMEI_IMPORT_TRT'

					SET @sMessage  = 'ATTENTION : Contacter le service DEI.' + char(13) + 'Erreur remontée : ' + @sMessErreur + char(13) + char(10)
					EXEC master.dbo.SPB_PS_MAIL @sRetourErrMail OUTPUT, @sMailInformatique, @sMessage, 'Erreur traitement import fichier CRA'
				END
			END
--		END
	END
END

-- reprise en erreur
ELSE
BEGIN

	-- print 'Il reste des lignes non traité (null) dans la table de traitement pour le fichier : ' + @sNomFic
	-- print 'PS_CRA_IMEI_IMPORT_TRT'
	
	EXEC @iErr = sysadm.PS_CRA_IMEI_IMPORT_TRT @sCcimei, @sNomFic, @sMessErreur OUTPUT
	IF @@ERROR <> 0 OR @iErr <> 0
	BEGIN
		
		-- print 'Error : PS_CRA_IMEI_IMPORT_TRT'
		
		SET @sMessage  = 'ATTENTION : Contacter le service DEI.' + char(13) + 'Erreur remontée : ' + @sMessErreur + char(13) + char(10)
		EXEC master.dbo.SPB_PS_MAIL @sRetourErrMail OUTPUT, @sMailInformatique, @sMessage, 'Erreur traitement import fichier CRA'
	END
END

IF ( SELECT count(*) FROM sysadm.cra_imei_rejet WHERE type_trait = 'I' AND type_rejet = 'F' AND nom_fic = @sNomFic AND date_rejet >= @dtTrt ) > 0
BEGIN

	-- print 'Rejet fonctionnel'
	
	-- [I027].BUG1 - bcp n'accepte que les dates au format anglais.	-- [I027] Correction Date ISO
	--SET @sQueryout = ' "SELECT dte_envoi, nom_prenom, id_sin, dte_surv_fic, num_imei_port, num_port, reponse, message_rejet FROM ' + @sBase + '.sysadm.cra_imei_rejet WHERE type_trait = ''I'' AND type_rejet = ''F'' AND nom_fic = ''' + @sNomFic + ''' AND date_rejet >= ''' + convert( varchar(10), @dtTrt, 103) + ' ' + convert( varchar(12), @dtTrt, 114)  + '''" '
	SET @sQueryout = ' "SELECT dte_envoi, nom_prenom, id_sin, dte_surv_fic, num_imei_port, num_port, reponse, message_rejet FROM ' + @sBase + '.sysadm.cra_imei_rejet WHERE type_trait = ''I'' AND type_rejet = ''F'' AND nom_fic = ''' + @sNomFic + ''' AND date_rejet >= ''' + convert( varchar(8), @dtTrt, 112) + ' ' + convert( varchar(12), @dtTrt, 114)  + '''" '

-- 	print @sQueryout

	SET @sBcp = 'bcp ' + @sQueryout + ' queryout "' + @sRep + @sNomFicRejetFonc + '"' + @sOption + @sConnex
	
	-- print '@sBcp : ' + @sBcp
	
	EXEC @iErr = master.dbo.xp_cmdshell @sBcp
	IF @@ERROR <> 0 OR @iErr <> 0
	BEGIN

		-- print 'Error : master.dbo.xp_cmdshell'

		SET @sMessage  = 'ATTENTION : Contacter le service DEI.' + char(13) + 'ERREUR de l''execution de : ' + @sBcp
		EXEC master.dbo.SPB_PS_MAIL @sRetourErrMail OUTPUT, @sMailInformatique, @sMessage, 'Erreur traitement import fichier CRA'
	END
	ELSE
	BEGIN
	
		-- print 'Envoi du fichier de rejet fonctionnel'
		
		SET @sFicAttach = @sRep + @sNomFicRejetFonc
		SET @sMessage  = 'Un fichier de rejet a été généré lors du traitement de l''import du fichier de controle IMEI.' + char(13) + 'Fichier : ' + @sFicAttach + char(13) + char(10)
		EXEC master.dbo.SPB_PS_MAIL @sRetourErrMail OUTPUT, @sMailGestion, @sMessage, 'Traitement import fichier CRA : Fichier rejet généré.', '', '', @sFicAttach
	END
END

IF ( SELECT count(*) FROM sysadm.cra_imei_rejet WHERE type_trait = 'I' AND type_rejet = 'I' AND date_rejet >= @dtTrt ) > 0
BEGIN

	-- print '!! Envoi du fichier de rejet informatique'
	
	SET @sMessage  = 'ATTENTION : Contacter le service DEI.' + char(13) + 'Il y a des erreurs de type informatique lors du traitement du fichier : ' + @sNomFic + char(13) + 'Vérifier la table de rejet [cra_imei_rejet] avec le select suivant: ' + char(13) + 'SELECT count(*) FROM cra_imei_rejet WHERE type_trait = ''I'' AND type_rejet = ''I'' AND date_rejet >= ' + convert( varchar(10), getdate(), 103 )
	EXEC master.dbo.SPB_PS_MAIL @sRetourErrMail OUTPUT, @sMailInformatique, @sMessage, 'Erreur traitement import fichier CRA'
END

-- Envoi Automatique d'un rapport d'exploitation.
SET @sMessage  = 'Ci-joint le rapport d''exploitation des traitement CRAO :' + char(13) + char(10)
-- [I027] Correction Date ISO
--Set @sQueryout = 'Exec ' + @@SERVERNAME+'.'+@sBase+'.sysadm.PS_CRA_IMEI_STAT_EXPLOITATION '''+convert(varchar(23), @dtTrt, 103)+' '+convert(varchar(23), @dtTrt, 108)+''', '''+ @sNomFic + ''''
Set @sQueryout = 'Exec ' + @@SERVERNAME+'.'+@sBase+'.sysadm.PS_CRA_IMEI_STAT_EXPLOITATION '''+convert(varchar(8), @dtTrt, 103)+' '+convert(varchar(8), @dtTrt, 108)+''', '''+ @sNomFic + ''''
Set @sStatCrao = master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Export_Stat_Crao\STATCRAO.TXT'
EXEC master.dbo.SPB_PS_MAIL @sRetourErrMail OUTPUT, @sMailGestion, @sMessage, 'Traitement import fichier CRA : Rapport d''exploitation.', '', '', '', @sQueryout, @sStatCrao, 2
GO


--------------------------------------------------------------------
--
-- Procédure            :   PS_CRA_IMEI_TRT_3X_REFUS
-- Auteur               :   PHG
-- Date                 :   27/03/2007
-- Libellé              :   Procedure Générique de Formulation de 'Refus' du process CRAO
-- Commentaires         :   Procède à la création de contact, à la MAJ (w_)div_sin, à la trace
-- Références           :   [DCMP070214]
--
-- Arguments            :   	@dcIdSin	decimal(7,0) : n° sinistre
--				@dcIdProd	decimal(7,0) : n° produit
--				@sNumImeiPort	varchar(25)  : n° IMEI portable
--				@sNumPort	varchar(25)  : n° Portable
--				@iCodeRefus	integer	     : Code du refus ( issus de code, en '-CR' )
--				@dtDteLastUse	datetime     : DDU, peut être null si codereponse non null
--				@sCodeReponse	varchar(2)   : Code réponse, peut etre null si DDu non null.
--				@dtDateExec	datetime     : Datetime d'execution du traitement
--				@sMessErreur	varchar(255) : byRef : Message si erreur.
--
-- Retourne             :   0 : Ok
--			    -1: Erreur SQL, ou erreur non prévue.
--			    -2:	Erreur Fonctionnelle
--				  
--------------------------------------------------------------------
-- MAJ	PAR	LE		TAG		Description
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CRA_IMEI_TRT_3X_REFUS' AND type = 'P' )
	DROP PROCEDURE sysadm.PS_CRA_IMEI_TRT_3X_REFUS
GO

CREATE PROCEDURE sysadm.PS_CRA_IMEI_TRT_3X_REFUS
	@dcIdSin	decimal(10,0), -- [PI062]
	@dcIdProd	decimal(7,0),
	@sNumImeiPort	varchar(25),
	@sNumPort	varchar(25),
	@iCodeRefus	integer,
	@dtDteLastUse	datetime = NULL,
	@sCodeReponse	varchar(2) = NULL,
	@dtDateExec	datetime,
	@sMessErreur	varchar(255) OUTPUT

AS

DECLARE @sMessContact 	varchar(255),
	@iRet		integer,
	@sIdSin		varchar(10), -- [PI062]
	@sSql		varchar(4),
	@sIdCodeAction	varchar(6),
	@sValAction	varchar(25)

--***** Initialiations *****--

Set @sSql = 'SQLS' -- Trigramme Machine pour *.maj_par, *.cree_par

-- Initialisation en format varchar de IdSin, evite les cast multiple pour les message
Set @sIdSin	= cast ( @dcIdSin as varchar(10) )  -- [PI062]

-- Code retour à 0 par defaut.
Set @iRet = 0 

-- Initialisation de la variable de message d'erreur à NULL
Set @sMessErreur = NULL

--*****

-- 1/ Création d’un contact pour travail sherpa, pour refus, sur SHERPA_SIM/PRO avec PS_I04_CONTACT_TRAVAIL_V01 (trigramme à utiliser : trigramme générique crao).
SET @sMessContact = 'Controle IMEI Refuse : ' + sysadm.FN_CODE_NUM ( @iCodeRefus, '-CR' )
EXEC @iRet = sysadm.PS_CRA_IMEI_CONTACT_TRAVAIL 'I', 281, @dcIdSin, @dcIdProd, @sMessContact, @sMessErreur OUTPUT
IF @iRet <> 0
BEGIN
	SET @sMessErreur = 'ERREUR - PS_CRA_IMEI_CONTACT_TRAVAIL avec id_sin = ' + @sIdSin + ', message d''erreur : ' + @sMessErreur
	SET @iRet = -2
END
-- 2/ 	Mise à jour de div_sin/w_div_sin avec
-- 	#cra_suivi_imei# = Code refus Passé en parametre
--	#cra_last_dte#   = Date de dernière utilisation passée en parametre

IF @iRet = 0
BEGIN	

	-- #cra_suivi_imei# = Code Refus passé en parametre
	UPDATE	sysadm.div_sin
	SET	val_nbre	=	@iCodeRefus,
		maj_le		=	@dtDateExec,
		maj_par		=	@sSql
	WHERE	id_sin		=	@dcIdSin
	AND	nom_zone	=	'cra_suivi_imei'

	IF @@ROWCOUNT <> 1
	BEGIN
		SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + @sIdSin + ' avec val_car = 1'
		SET @iRet = -1
	END

	IF ( SELECT count(*) FROM sysadm.div_sin WHERE nom_zone = 'cra_suivi_imei' AND id_sin = @dcIdSin ) > 0
	BEGIN
		UPDATE	sysadm.w_div_sin
		SET	cpt_valide	=	1,
			val_nbre	=	@iCodeRefus,
			maj_le		=	@dtDateExec,
			maj_par		=	@sSql
		WHERE	id_sin		=	@dcIdSin
		AND	nom_zone	=	'cra_suivi_imei'

		IF @@ROWCOUNT <> 1
		BEGIN
			SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_suivi_imei et id_sin = ' + @sIdSin + ' avec val_car = 1'
			SET @iRet = -1
		END
	END

	-- #cra_last_dte# = Date de Dernière Utilisation
	IF ( SELECT count(*) FROM sysadm.div_sin WHERE nom_zone = 'cra_last_dte' AND id_sin = @dcIdSin ) = 0
	BEGIN
		INSERT	sysadm.div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cree_le, maj_le, maj_par, valide_le, valide_par )
			SELECT	@dcIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'O', dp.cpt_tri, @dtDteLastUse, @dtDateExec, @dtDateExec, @sSql, @dtDateExec, @sSql
			FROM	sysadm.div_pro dp
			WHERE	dp.id_prod	=	@dcIdProd
			AND	dp.nom_zone	=	'cra_last_dte'

		IF @@ROWCOUNT <> 1
		BEGIN
			SET @sMessErreur = 'ERREUR - INSERT div_sin pour nom_zone = cra_last_dte et id_sin = ' + @sIdSin
			SET @iRet = -1
		END

		IF 	( SELECT count(id_sin) FROM sysadm.w_div_sin WHERE nom_zone = 'cra_last_dte' AND id_sin = @dcIdSin ) = 0 AND
			( SELECT count(id_sin) FROM sysadm.w_sin WHERE id_sin = @dcIdSin ) > 0
		BEGIN
			INSERT	sysadm.w_div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_dte, cpt_valide, cree_le, maj_le, maj_par )
				SELECT	@dcIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'O', dp.cpt_tri, @dtDteLastUse, 1, @dtDateExec, @dtDateExec, @sSql
				FROM	sysadm.div_pro dp
				WHERE	dp.id_prod	=	@dcIdProd
				AND	dp.nom_zone	=	'cra_last_dte'

			IF @@ROWCOUNT <> 1
			BEGIN
				SET @sMessErreur = 'ERREUR - INSERT w_div_sin pour nom_zone = cra_last_dte et id_sin = ' + @sIdSin
				SET @iRet = -1
			END
		END
	END
	ELSE
	BEGIN
		UPDATE	sysadm.div_sin
		SET	val_dte		=	@dtDteLastUse,
			maj_le		=	@dtDateExec,
			maj_par		=	@sSql
		WHERE	id_sin		=	@dcIdSin
		AND	nom_zone	=	'cra_last_dte'

		IF @@ROWCOUNT <> 1
		BEGIN
			SET @sMessErreur = 'ERREUR - UPDATE div_sin pour nom_zone = cra_last_dte et id_sin = ' + @sIdSin + ' avec val_dte = ' + cast(@dtDteLastUse as varchar(25))
			SET @iRet = -1
		END

		IF ( SELECT count(id_sin) FROM sysadm.w_div_sin WHERE nom_zone = 'cra_last_dte' AND id_sin = @dcIdSin ) > 0
		BEGIN
			UPDATE	sysadm.w_div_sin
			SET	cpt_valide	=	1,
				val_dte		=	@dtDteLastUse,
				maj_le		=	@dtDateExec,
				maj_par		=	@sSql
			WHERE	id_sin		=	@dcIdSin
			AND	nom_zone	=	'cra_last_dte'

			IF @@ROWCOUNT <> 1
			BEGIN
				SET @sMessErreur = 'ERREUR - UPDATE w_div_sin pour nom_zone = cra_last_dte et id_sin = ' + @sIdSin + ' avec val_dte = ' + cast(@dtDteLastUse as varchar(25))
				SET @iRet = -1
			END
		END
	END
	
	-- Insertion dans la table trace_cra_imei : 
	-- 	Id_sin, datetime du jour, num_imei_port, num_port, ‘REFDEF’, 
	--	#cra_last_dte# ou @sCodeReponse si Code reponse précisé
	SET	@sIdCodeAction	=	'REFDEF'

	IF	@sCodeReponse IS NULL
		SET	@sValAction	=	CONVERT ( varchar(25), @dtDteLastUse, 121 )
	ELSE
		SET	@sValAction	=	@sCodeReponse

	EXEC sysadm.PS_I01_TRACE_CRA_IMEI @dcIdSin, @dtDateExec, @sNumImeiPort, @sNumPort, '-SC', @sIdCodeAction, @sValAction

	IF @@ERROR <> 0
	BEGIN
		SET @sMessErreur = 'ERREUR - PS_I01_TRACE_CRA_IMEI avec id_sin = ' + @sIdSin + 'et id_code_action = ' + @sIdCodeAction
		SET @iRet = -1
	END
END

RETURN @iRet

GO

----------------------------------------------------------------------------------------------------------------------------------------
-- Procedure	:	PS_I01_CRA_IMEI_REJET
-- Commentaires     : 	Procedure principale appele tous les jours
-------------------------------------------------------------------
-- Gestion des rejets du traitement de controle des IMEI
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_CRA_IMEI_REJET' AND type = 'P' )
	DROP PROCEDURE sysadm.PS_I01_CRA_IMEI_REJET
GO

CREATE PROCEDURE sysadm.PS_I01_CRA_IMEI_REJET
 @sTypeTrait   varchar(1),   
 @sNomFic      varchar(35),  
 @sDteEnvoi    varchar(23),  
 @sNomPrenom   varchar(71),  
 @sIdSin       varchar(10),  
 @sDteSurvFic  varchar(23),  
 @sNumImeiPort varchar(25),  
 @sNumPort     varchar(25),  
 @sReponse     varchar(10),  
 @sDateRejet   datetime,     
 @sMessErreur  varchar(255), 
 @sTypeRejet   varchar(1)    

AS

-- Pas d'affichage des resultat
SET NOCOUNT ON

INSERT sysadm.cra_imei_rejet 
VALUES ( 
    @sTypeTrait, 
    @sNomFic, 
    @sDteEnvoi, 
    @sNomPrenom, 
    @sIdSin, 
    @sDteSurvFic, 
    @sNumImeiPort, 
    @sNumPort, 
    @sReponse, 
    @sDateRejet, 
    @sMessErreur, 
    @sTypeRejet 
    )

GO

-- JFF      12/02/2016   [PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CRA_IMEI_IMPORT_CTRL_FIC' AND type = 'P' )
	DROP PROCEDURE sysadm.PS_CRA_IMEI_IMPORT_CTRL_FIC
GO

CREATE PROCEDURE sysadm.PS_CRA_IMEI_IMPORT_CTRL_FIC
	@sNomFic	varchar(255),
	@sMessErreur	varchar(255) OUTPUT
AS

DECLARE @sDteEnvoi	varchar(10),
	@sNomPrenom	varchar(71),
	@sIdSin		varchar(10),
	@sDteSurvFic	varchar(10),
	@sNumImeiPort	varchar(25),
	@sNumPort	varchar(25),
	@sReponse	varchar(10),
	
	-- Gestion boucle de vérification
	@iFetch		integer,
	@iRet		integer,
	@dtDateRejet	datetime,
	@iIdSinDoublon	integer

SET @dtDateRejet	= getdate()
SET @iRet	= 0

SET NOCOUNT ON

	/*							*/
	/* MODIFICATION TEMPORAIRE 					*/
	/* !!! Répercution sur la procédure de traitement :		*/
	/* !!! PS_CRA_IMEI_IMPORT_TRT				*/
	/* on ne sort plus du traitement si l'on trouve des doublons	*/
	/* dans la table temporaire					*/
	/* Le principe étant pour un durée courte de les marquer et de	*/
	/* les traiter manuelement					*/
	/* 							*/
-- SELECT	tcio.id_sin
-- FROM	sysadm.tmp_cra_import_orv as tcio
-- GROUP BY tcio.id_sin
-- HAVING count(tcio.id_sin) > 1

-- IF @@ROWCOUNT > 0
-- BEGIN
-- 	SET @sMessErreur = 'Il existe des doublons de sinistres dans le fichier d''import : ' + @sNomFic
-- 	INSERT sysadm.cra_imei_rejet ( type_trait, nom_fic, date_rejet, message_rejet, type_rejet )
-- 	VALUES ( 'I', @sNomFic, @dtDateRejet, @sMessErreur, 'I' )
-- 
-- 	SET @iRet = -1
-- END

IF @iRet = 0
BEGIN
	DECLARE	cursor_cra_ctrl_fic	CURSOR	FOR
	SELECT	dte_envoi,
		nom_prenom,
		id_sin,
		dte_surv_fic,
		num_imei_port,
		num_port,
		reponse
	FROM	sysadm.tmp_cra_import_orv

	OPEN cursor_cra_ctrl_fic

	FETCH NEXT FROM cursor_cra_ctrl_fic
	INTO	@sDteEnvoi,
		@sNomPrenom,
		@sIdSin,
		@sDteSurvFic,
		@sNumImeiPort,
		@sNumPort,
		@sReponse

	SET @iFetch = @@FETCH_STATUS

	WHILE @@FETCH_STATUS = 0
	BEGIN

	--	-- print '@sNomFic : ' + @sNomFic + ', @sDteEnvoi : ' + @sDteEnvoi + ', @sNomPrenom : ' + @sNomPrenom + ', @sIdSin : ' + @sIdSin + ', @sDteSurvFic : ' + @sDteSurvFic + ', @sNumImeiPort : ' + @sNumImeiPort + ', @sNumPort : ' + @sNumPort + ', @sReponse : ' + @sReponse + ', @sDateRejet : ' + @sDateRejet

		-- initialisation de la valeur de retour des procédures appelées
		SET @iRet = 0

		-- controle si champs obligatoires sont bien renseignés dans le fichier
		IF @sDteEnvoi IS NULL
		BEGIN
			SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[dte_envoi] est nulle pour le sinistre numéro : ' + @sIdSin
			SET @iRet = -1
		END
		
		IF ISDATE ( @sDteEnvoi ) = 0 AND @iRet = 0
		BEGIN
			SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[dte_envoi] n''est pas une date valide pour le sinistre numéro : ' + @sIdSin
			SET @iRet = -1
		END
		
		IF @sNomPrenom IS NULL  AND @iRet = 0
		BEGIN
			SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[nom_prenom] est nulle pour le sinistre numéro : ' + @sIdSin
			SET @iRet = -1
		END
		
		IF @sIdSin IS NULL AND @iRet = 0
		BEGIN
			SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[id_sin] est nulle pour le sinistre numéro : ' + @sIdSin
			SET @iRet = -1
		END
		
		IF LEN ( @sIdSin ) > 10 AND @iRet = 0 -- [PI062]
		BEGIN
			SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[id_sin] est supérieur d''une longueur à 10 pour le sinistre numéro : ' + @sIdSin -- [PI062]
			SET @iRet = -1
		END
		
		IF ISNUMERIC ( @sIdSin ) = 0 AND @iRet = 0
		BEGIN
			SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[id_sin] n''est pas un numérique pour le sinistre numéro : ' + @sIdSin
			SET @iRet = -1
		END
		
		IF @sDteSurvFic IS NULL AND @iRet = 0
		BEGIN
			SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[dte_surv] est nulle pour le sinistre numéro : ' + @sIdSin
			SET @iRet = -1
		END
		
		IF ISDATE ( @sDteSurvFic ) = 0 AND @iRet = 0
		BEGIN
			SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[dte_surv] n''est pas une date valide pour le sinistre numéro : ' + @sIdSin
			SET @iRet = -1
		END
		
		IF @sNumImeiPort IS NULL AND @iRet = 0
		BEGIN
			SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[num_imei_port] est nulle pour le sinistre numéro : ' + @sIdSin
			SET @iRet = -1
		END
		
		IF LEN ( @sNumImeiPort ) <> 15 AND @iRet = 0
		BEGIN
			SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[num_imei_port] est d''une longueur supérieure à 15 pour le sinistre numéro : ' + @sIdSin
			SET @iRet = -1
		END
		
		IF ISNUMERIC ( @sNumImeiPort ) = 0 AND @iRet = 0
		BEGIN
			SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[num_imei_port] n''est pas un numérique pour le sinistre numéro : ' + @sIdSin
			SET @iRet = -1
		END
		
		IF @sNumPort IS NULL AND @iRet = 0
		BEGIN
			SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[num_port] est nulle pour le sinistre numéro : ' + @sIdSin
			SET @iRet = -1
		END
		
		IF LEN ( @sNumPort ) <> 10 AND @iRet = 0
		BEGIN
			SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[num_port] est d''une longueur supérieur à 10 pour le sinistre numéro : ' + @sIdSin
			SET @iRet = -1
		END	
			
		IF ISNUMERIC ( @sNumPort ) = 0 AND @iRet = 0
		BEGIN
			SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[num_port] n''est pas un numérique pour le sinistre numéro : ' + @sIdSin
			SET @iRet = -1
		END

	-- TODO: A confirmer : [CRAO_LOT2.003] Le controle de la conne reponse doit etre déporté en rejet *F*onctionnel.
		
		IF @sReponse IS NULL AND @iRet = 0
		BEGIN
			SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[reponse] est nulle pour le sinistre numéro : ' + @sIdSin
			SET @iRet = -1
		END
		
		IF ( ISNUMERIC ( @sReponse ) = 0 AND ISDATE ( @sReponse ) = 0 ) AND @iRet = 0
		BEGIN
			SET @sMessErreur = 'La donnée dans la colonne [tmp_cra_import_orv].[reponse] n''est ni une date ni un numérique pour le sinistre numéro : ' + @sIdSin
			SET @iRet = -1
		END

		-- trace dans la table de rejet
		IF @iRet <> 0
		BEGIN
			-- print 'INSERT cra_imei_rejet'
			
			INSERT sysadm.cra_imei_rejet ( type_trait, nom_fic, dte_envoi, nom_prenom, id_sin, dte_surv_fic, num_imei_port, num_port, reponse, date_rejet, message_rejet, type_rejet )
			VALUES ( 'I', @sNomFic, @sDteEnvoi, @sNomPrenom, @sIdSin, @sDteSurvFic, @sNumImeiPort, @sNumPort, @sReponse, @dtDateRejet, @sMessErreur, 'I' )

			BREAK
		END

		FETCH NEXT FROM cursor_cra_ctrl_fic
		INTO	@sDteEnvoi,
			@sNomPrenom,
			@sIdSin,
			@sDteSurvFic,
			@sNumImeiPort,
			@sNumPort,
			@sReponse
	END

	IF @iFetch <> 0
	BEGIN
		SET @sMessErreur = 'La table temporaire est vide, l''importation du fichier ' + @sNomFic + ' a échouée.'
		-- trace dans la table de rejet
		INSERT sysadm.cra_imei_rejet ( type_trait, nom_fic, dte_envoi, nom_prenom, id_sin, dte_surv_fic, num_imei_port, num_port, reponse, date_rejet, message_rejet, type_rejet )
		VALUES ( 'I', @sNomFic, @sDteEnvoi,@sNomPrenom, @sIdSin, @sDteSurvFic, @sNumImeiPort, @sNumPort, @sReponse, @dtDateRejet, @sMessErreur, 'I' )
	END

	CLOSE cursor_cra_ctrl_fic
	DEALLOCATE cursor_cra_ctrl_fic
END

RETURN @iRet

GO


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CRA_IMEI_IMPORT_FIC' AND type = 'P' )
	DROP PROCEDURE sysadm.PS_CRA_IMEI_IMPORT_FIC
GO

CREATE PROCEDURE sysadm.PS_CRA_IMEI_IMPORT_FIC
	@sNomFic	varchar(255),
	@sCcimei	varchar(50),
	@sMessErreur	varchar(255) OUTPUT
AS

--------------------------------------------------------------------
--
--        !!!! ATTENTION DEBUT DE LA PROCEDURE CI-DESSUS !!!!
--	  ( Les commentaires sont inclus dans la procédure )
--
-- Procédure            :   PS_CRA_IMEI_IMPORT_FIC
-- Auteur               :   
-- Date                 :   14/02/2007
-- Libellé              :   Procedure de recopie du fichier importé dans la table temporaire 
--			    vers la table de traitement
-- Commentaires         :   Mise à jour des tables de gestion
-- Références           :   cra_imei_trt_import, div_sin, w_divsin
--
-- Arguments            :   @sCcimei		varchar(50)		Centre Technique de Controle IMEI
--			    @sNomFic		varchar(35)		Nom du Fichier Traité
--			    @sMessErreur	varchar(255) OUTPUT	byREf : Message d'erreur retourné.
--
-- Retourne             :   Code retour T-SQL Standard
--				  
--------------------------------------------------------------------
-- MAJ	PAR	LE		TAG		Description
-- #1	PHG	27/03/2007	[DCMP070214]	Refus sur Date de Sous > Date Dernière Utilisation.
--						- Création de 2 codes traitement : 21 et 35
-- JFF      12/02/2016   [PI062]
--------------------------------------------------------------------

DECLARE @sDteEnvoi	varchar(10),
	@sNomPrenom	varchar(71),
	@sIdSin		varchar(10),
	@sDteSurvFic	varchar(10),
	@sNumImeiPort	varchar(25),
	@sNumPort	varchar(25),
	@sReponse	varchar(10),
	
	-- Gestion boucle de vérification
	@iFetch		integer,
	@iRet		integer,
	@dtDteSurvBase	datetime,
	@dtDteAdh	datetime,	-- #1 [DCMP070214] Date de d'adhésion
	@iPeriode	integer,
	@iCodeReponse	integer,
	@dtDteLastUse	datetime,
--	@iGti		integer, -- [CRAO_LOT2.007] on ne lit plus IdGti, 
--				 -- mais un AltGti11 indiquant si Gti 11 ou pas
	@sAltGti11	varchar(1),-- [CRAO_LOT2.007] Indicateur de présence d'une garantie 11
	@sDateRejet	varchar(23),
	@sTraitement	varchar(2),
	
	-- Paramétrage
	@iCraCptDmde	integer,
	-- Trace
	@iIdSin		integer,
 	@dtDate		datetime,
	@sValAction	varchar(25)
-- initialisation de la valeur de retour des procédures appelées
SET @iRet	=	0

SET @sDateRejet	=	cast( getdate() as varchar(23))

SET NOCOUNT ON

DECLARE	cursor_cra_import	CURSOR	FOR
SELECT	dte_envoi,
	nom_prenom,
	id_sin,
	dte_surv_fic,
	num_imei_port,
	num_port,
	reponse
FROM	sysadm.tmp_cra_import_orv

OPEN cursor_cra_import

FETCH NEXT FROM cursor_cra_import
INTO	@sDteEnvoi,
	@sNomPrenom,
	@sIdSin,
	@sDteSurvFic,
	@sNumImeiPort,
	@sNumPort,
	@sReponse

SET @iFetch = @@FETCH_STATUS

WHILE @@FETCH_STATUS = 0
BEGIN
	-- Code déporté et adapté de PS_CRA_IMEI_IMPORT_TRT
	-- On mémorise l'evenement réception du fichier pour le sinistre dans la table de trace
        BEGIN TRAN

	Set 	@iIdSin 	= cast (@sIdSin as integer )-- A revoir !! car la proc ci-dessous prend est en decimal 7 )
 	Set 	@dtDate 	= cast (@sDateRejet as datetime)
	SET	@sValAction	= CONVERT ( varchar(25), @dtDate, 121 )

	EXEC sysadm.PS_I01_TRACE_CRA_IMEI @iIdSin, @dtDate, @sNumImeiPort, @sNumPort, '-SC', 'RECEPT', @sValAction
	COMMIT TRAN -- Cette gestion des Commit/Rollback sera revue..
	--

	SET @sAltGti11	= 'N' -- [CRAO_LOT2.007] Du fait du curseur, on s'assure de l'initialisation de la variable  

	-- #1 [DCMP070214] PHG 27/03/2007 On lit la date de survenance et la date d'adhesion
		-- contrôle du sinistre et récupération de la date de survenance en base
		-- SELECT	@dtDteSurvBase = s.dte_surv/*,
		--	@iGti = gs.id_gti*/ -- [CRAO_LOT2.007] on ne lit que la date de surv
		-- FROM	sysadm.sinistre s
		-- /*INNER JOIN sysadm.gar_sin gs
		-- 	ON s.id_sin = gs.id_sin*/ -- [CRAO_LOT2.007] on ne lit que la date de surv
		-- WHERE	s.id_sin	=	cast ( @sIdSin as decimal(7,0) )
	-- Remplacé par ( pour lisibilité ) : 
	SELECT	@dtDteSurvBase = s.dte_surv, 
		@dtDteAdh = s.dte_adh -- #1 [DCMP070214] PHG 27/03/2007 : dte_sous n'est pas tjrs renseigné, on lit donc dte_adh
	FROM	sysadm.sinistre s
	WHERE	s.id_sin	=	cast ( @sIdSin as decimal(10,0) )  -- [PI062]
	
	IF @@ROWCOUNT <> 1
	BEGIN
		-- #1 [DCMP070214] PHG 27/03/2007 Suite ci-dessus, modification du message en conséquence
		-- SET @sMessErreur = 'Il n''y a pas de date de survenance pour le sinistre numéro : ' + @sIdSin
		-- Remplacé par :
		SET @sMessErreur = 'Pas de sinistre trouvé en base pour le sinistre numéro : ' + @sIdSin

		BEGIN TRAN
 		-- trace dans la table de rejet
		INSERT sysadm.cra_imei_rejet ( type_trait, nom_fic, dte_envoi, nom_prenom, id_sin, dte_surv_fic, num_imei_port, num_port, reponse, date_rejet, message_rejet, type_rejet )
		VALUES ( 'I', @sNomFic, @sDteEnvoi, @sNomPrenom, @sIdSin, @sDteSurvFic, @sNumImeiPort, @sNumPort, @sReponse, @sDateRejet, @sMessErreur, 'F' )
		COMMIT TRAN
 		
		FETCH NEXT FROM cursor_cra_import
		INTO	@sDteEnvoi,
			@sNomPrenom,
			@sIdSin,
			@sDteSurvFic,
			@sNumImeiPort,
			@sNumPort,
			@sReponse
		
		CONTINUE
	END

	-- [CRAO_LOT2.007] Détection de l'existence de la Garantie 11
	SELECT	@sAltGti11 = 	CASE sysadm.FN_TRIM(cast (count(gs.id_gti) as varchar(2)))
					WHEN '0' THEN 'N'
					ELSE 'O'
				END
	FROM	sysadm.sinistre s
	INNER JOIN sysadm.gar_sin gs
		ON s.id_sin = gs.id_sin
	WHERE	s.id_sin 	= cast ( @sIdSin as decimal(10,0) ) -- [PI062]
	and 	gs.id_gti	= 11 -- Garantie Bris
	
	IF @@ROWCOUNT <> 1
	BEGIN
		SET @sMessErreur = 'Identification des garanties ouvertes pour le sinistre numéro : ' + @sIdSin + ' impossible.'

		BEGIN TRAN
 		-- trace dans la table de rejet
		INSERT sysadm.cra_imei_rejet ( type_trait, nom_fic, dte_envoi, nom_prenom, id_sin, dte_surv_fic, num_imei_port, num_port, reponse, date_rejet, message_rejet, type_rejet )
		VALUES ( 'I', @sNomFic, @sDteEnvoi, @sNomPrenom, @sIdSin, @sDteSurvFic, @sNumImeiPort, @sNumPort, @sReponse, @sDateRejet, @sMessErreur, 'F' )
		COMMIT TRAN
 		
		FETCH NEXT FROM cursor_cra_import
		INTO	@sDteEnvoi,
			@sNomPrenom,
			@sIdSin,
			@sDteSurvFic,
			@sNumImeiPort,
			@sNumPort,
			@sReponse
		
		CONTINUE
	END
	-- [CRAO_LOT2.007] Fin Détection de l'existence de la Garantie 11

	-- Récupération des paramétres sur div_sin pour le sinistre en cours
	SELECT	@iCraCptDmde	=	val_nbre
	FROM	sysadm.div_sin
	WHERE	id_sin		=	cast ( @sIdSin as decimal(10,0) )  -- [PI062]
	AND	nom_zone	=	'cra_cpt_dmde'
	
	IF @@rowcount <> 1
	BEGIN

		SET @sMessErreur = 'Erreur dans le paramétrage, vérifier le compteur de demande pour le sinistre numéro : ' + @sIdSin
		
		BEGIN TRAN
		-- trace dans la table de rejet		
		INSERT sysadm.cra_imei_rejet ( type_trait, nom_fic, dte_envoi, nom_prenom, id_sin, dte_surv_fic, num_imei_port, num_port, reponse, date_rejet, message_rejet, type_rejet )
		VALUES ( 'I', @sNomFic, @sDteEnvoi, @sNomPrenom, @sIdSin, @sDteSurvFic, @sNumImeiPort, @sNumPort, @sReponse, @sDateRejet, @sMessErreur, 'F' )
		COMMIT TRAN

		FETCH NEXT FROM cursor_cra_import
		INTO	@sDteEnvoi,
			@sNomPrenom,
			@sIdSin,
			@sDteSurvFic,
			@sNumImeiPort,
			@sNumPort,
			@sReponse
		
		CONTINUE
	END

	IF ISDATE ( @sReponse ) = 1
	BEGIN
		SET @iPeriode		=	datediff ( day, @sReponse, @dtDteSurvBase )
		SET @iCodeReponse	=	NULL
		SET @dtDteLastUse	=	@sReponse
	END

	ELSE
	BEGIN
		SET @iPeriode		=	NULL
		SET @iCodeReponse	=	cast ( @sReponse as integer )
		SET @dtDteLastUse	=	NULL
	END

	-- DEBUT - cas de traitement
	--Si Dte_last_use est renseignée
	IF @dtDteLastUse IS NOT NULL
	BEGIN
		-- [DCMP070214] TAg pour Analyse :
		-- Si DDU < date D'adhesion
		--	Si Compteur de Demande <= 1 alors
		--		Faire une deuxieme demande de controle
		--	Sinon
		--		Emettre un Refus 'Refus DDU < Date de Souscription : IMEI REFUSE'
		--	Fsi
		-- Fsi
		-- #1 [DCMP070214] PHG On effectue le test d'antériorité de la DDU par rapport à la date d'adhésion
		IF @dtDteLastUse < @dtDteAdh
		BEGIN
			IF @iCraCptDmde <= 1		-- Si 1 seul controle fait on effectue une deuxiemme dmde.
				SET @sTraitement = '21' -- Appel Traitement générique demande deuxieme controle.
			ELSE				-- Sinon, 2eme dmde déja faite => refus.
				SET @sTraitement = '35' -- Appel Traitement générique de refus.
		END 
		ELSE
		BEGIN -- Fin #1 reprise des cas existant.
			IF @iPeriode >= 0
			BEGIN
				IF  @iPeriode <= 30
					SET @sTraitement = '1'
				ELSE
				BEGIN
					IF @iCraCptDmde = 1
						SET @sTraitement = '2'
					ELSE
						SET @sTraitement = '3'
				END 
			END 
			ELSE
			BEGIN
				-- [CRAO_LOT2.007] Utilisation de la detection de la garantie 11
				-- IF @iGti = 11
				-- remplace par :
				IF @sAltGti11 = 'O'
					SET @sTraitement = '4'
				ELSE
				BEGIN
					IF @iCraCptDmde <= 1
						SET @sTraitement = '5'
					ELSE
						SET @sTraitement = '6'
				END 
			END 
		END 
	END
	ELSE
	BEGIN
		IF @iCodeReponse = 3
			SET @sTraitement = '7'

		IF @iCodeReponse = 4
			SET @sTraitement = '8'

-- [CRAO_LOT2.003] Suite Retour MOA, Cas 11 déplacé hors demande 2 emme Controle
		IF @iCodeReponse = 9 OR ( SELECT count(*) FROM code WHERE id_typ_code = '-RC' AND id_code = @iCodeReponse ) = 0
			SET @sTraitement = '11'
-- [Fin CRA_LOT2.003] 
--		IF @iCodeReponse <> 3 AND @iCodeReponse <> 4 	-- ancien algo: @iCodeReponse = 0 OR @iCodeReponse = 1 OR @iCodeReponse = 2
						 		-- [CRAO_LOT2.003] PHG : L'equation doit être CodeRep <>3 *ET* CodeRep <>4 => Faux
								-- Reprise de l'ancient algo 
		IF @iCodeReponse = 0 OR @iCodeReponse = 1 OR @iCodeReponse = 2
		BEGIN
			IF @iCraCptDmde = 1 
				SET @sTraitement = '9'
			ELSE
			BEGIN
-- [CRAO_LOT2.003] Suite Retour MOA, Cas 11 déplacé hors demande 2 emme Controle
/*				IF @iCodeReponse = 1
					SET @sTraitement = '10'
				ELSE
				BEGIN	
					IF @iCodeReponse = 9 OR ( SELECT count(*) FROM code WHERE id_typ_code = '-RC' AND id_code = @iCodeReponse ) = 0
						SET @sTraitement = '11'
					ELSE
					BEGIN
						IF @iCodeReponse = 0
							SET @sTraitement = '12'

						IF @iCodeReponse = 2
							SET @sTraitement = '13'
					END
				END*/
-- REMPLACE PAR
				IF @iCodeReponse = 1
					SET @sTraitement = '10'
				IF @iCodeReponse = 0
					SET @sTraitement = '12'
				IF @iCodeReponse = 2
					SET @sTraitement = '13'
			END
		END
	END
	-- FIN - cas de traitement
	
	-- Début transaction ligne à ligne
	BEGIN TRAN

	INSERT sysadm.cra_imei_trt_import
	VALUES ( @sNomFic, @sDteEnvoi, @sNomPrenom, cast( @sIdSin as decimal(10,0) ), cast( @sDteSurvFic as datetime), @sNumImeiPort, @sNumPort, @dtDteSurvBase, @iPeriode, @iCodeReponse, @dtDteLastUse, @sTraitement, NULL ) -- [PI062]

	IF @@ROWCOUNT <> 1
	BEGIN
		
		-- print 'Erreur : INSERT cra_imei_trt_import'
		
		SET @sMessErreur = 'L''insertion dans la table de traitement a échoué, sinistre numéro : ' + @sIdSin
		SET @iRet = -1
		
	END

	IF @iRet = 0
		COMMIT TRAN
	ELSE
	BEGIN
	
		-- print '@iRet <> 0; ROLLBACK TRAN'
		
		ROLLBACK TRAN
			
		BEGIN TRAN
		-- trace dans la table de rejet
		INSERT sysadm.cra_imei_rejet ( type_trait, nom_fic, dte_envoi, nom_prenom, id_sin, dte_surv_fic, num_imei_port, num_port, reponse, date_rejet, message_rejet, type_rejet )
		VALUES ( 'I', @sNomFic, @sDteEnvoi, @sNomPrenom, @sIdSin, @sDteSurvFic, @sNumImeiPort, @sNumPort, @sReponse, @sDateRejet, @sMessErreur, 'I' )
		COMMIT TRAN
		
		BREAK
	END
	
	FETCH NEXT FROM cursor_cra_import
	INTO	@sDteEnvoi,
		@sNomPrenom,
		@sIdSin,
		@sDteSurvFic,
		@sNumImeiPort,
		@sNumPort,
		@sReponse

END
-- Fin de boucle while

IF @iFetch <> 0
BEGIN
	SET	@sMessErreur	= 'La table temporaire est vide, l''importation du fichier a échouée'
	SET	@iRet		= -1

	-- trace dans la table de rejet
        BEGIN TRAN                        
	INSERT sysadm.cra_imei_rejet ( type_trait, nom_fic, dte_envoi, nom_prenom, id_sin, dte_surv_fic, num_imei_port, num_port, reponse, date_rejet, message_rejet, type_rejet )
	VALUES ( 'I', @sNomFic, @sDteEnvoi, @sNomPrenom, @sIdSin, @sDteSurvFic, @sNumImeiPort, @sNumPort, @sReponse, @sDateRejet, @sMessErreur, 'I' )
        COMMIT TRAN
END

CLOSE cursor_cra_import
DEALLOCATE cursor_cra_import

RETURN @iRet

GO


IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_CRA_REDRESSEMENT_DOSSIER' AND type = 'P' )
	DROP PROCEDURE sysadm.PS_CRA_REDRESSEMENT_DOSSIER
GO

CREATE PROC sysadm.PS_CRA_REDRESSEMENT_DOSSIER
AS

--------------------------------------------------------------------
--
--        !!!! ATTENTION DEBUT DE LA PROCEDURE CI-DESSUS !!!!
--	  ( Les commentaires sont inclus dans la procédure )
--
-- Procédure            :   PS_CRA_REDRESSEMENT_DOSSIER
-- Auteur               :   
-- Date                 :   14/02/2007
-- Libellé              :   Redressement des dossiers en corus avant MEP CRAO
-- Commentaires         :   
-- Références           :   div_sin, w_divsin
--
-- Arguments            :   
--
-- Retourne             :   Code retour T-SQL Standard
--				  
--------------------------------------------------------------------
-- MAJ	PAR	LE		TAG		Description
-- 	PHG	29/06/2010	[DCMP100420]	Passage de sinistre.num_imei_port à 60 char
-- JFF      12/02/2016   [PI062]
--------------------------------------------------------------------

SET NOCOUNT ON

ALTER TABLE sysadm.div_sin DISABLE TRIGGER TR_I01_DIV_SIN

DECLARE	
		@dcIdSin		decimal(10,0),  -- [PI062]
		@dcIdProd		decimal(7,0),
		@dteCreeLe		datetime,
		@dcCodEtat		decimal(7,0),
		@sNumImeiPort		varchar(15),
		@sRefCie		varchar(15),
		@iCraSuiviImei		integer,
		@iFetch			integer,
		@iError			integer,
		@sTextMsg		varchar(255)

BEGIN TRAN

DECLARE	cursor_sinistre_cra	CURSOR	FOR
	select id_sin, id_prod, cree_le, cod_etat, left(num_imei_port, 25), ref_cie  -- [DCMP100420]
	from sysadm.sinistre 
	where 	id_prod in (9104, 9105, 9106, 9107, 9108, 9109, 9110, 9111, 9112, 9120)
		and cree_le < '14/02/2007'

OPEN cursor_sinistre_cra

FETCH NEXT FROM cursor_sinistre_cra
INTO	@dcIdSin, 
	@dcIdProd, 
	@dteCreeLe,
	@dcCodEtat,
	@sNumImeiPort,
	@sRefCie

SET @iFetch = @@FETCH_STATUS
SET @sTextMsg = 'OK'

WHILE @@FETCH_STATUS = 0
BEGIN
	-- #cra_ctrl_imei# à 'N'
	insert into sysadm.div_sin
	select @dcIdSin, dp.nom_zone, dp.lib_label,dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N',dp.cpt_tri, null,   null,  null, 'N', GetDate(),GetDate(), 'SQLS', GetDate(), 'SQLS'
	from sysadm.div_pro dp
	where dp.nom_zone = 'cra_ctrl_imei' and id_prod = @dcIdProd
	IF @@ERROR <> 0
	BEGIN
		Set @sTextMsg = '#cra_ctrl_imei# à N : 1'
		BREAK
	END

	insert into sysadm.w_div_sin
	select @dcIdSin, dp.nom_zone, dp.lib_label,dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N',dp.cpt_tri, null,   null,  null, 'N', 1, GetDate(),GetDate(), 'SQLS'
	from sysadm.div_pro dp
	where dp.nom_zone = 'cra_ctrl_imei' and id_prod = @dcIdProd
	and   EXISTS ( select * from w_sin where id_sin = @dcIdSin )
	IF @@ERROR <> 0
	BEGIN
		Set @sTextMsg = '#cra_ctrl_imei# à N : 2'
		BREAK
	END
	
	-- #cra_cpt_dmde# à '1'
	insert into sysadm.div_sin
	select @dcIdSin, dp.nom_zone, dp.lib_label,dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'O',dp.cpt_tri, 1,   null,  null, null, GetDate(),GetDate(), 'SQLS', GetDate(), 'SQLS'
	from sysadm.div_pro dp
	where dp.nom_zone = 'cra_cpt_dmde' and id_prod = @dcIdProd
	IF @@ERROR <> 0
	BEGIN
		Set @sTextMsg = '#cra_cpt_dmde# à 1 : 1'
		BREAK
	END
	
	insert into sysadm.w_div_sin
	select @dcIdSin, dp.nom_zone, dp.lib_label,dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'O',dp.cpt_tri, 1,   null,  null, null, 1, GetDate(),GetDate(), 'SQLS'
	from sysadm.div_pro dp
	where dp.nom_zone = 'cra_cpt_dmde' and id_prod = @dcIdProd
	and   EXISTS ( select * from w_sin where id_sin = @dcIdSin )
	IF @@ERROR <> 0
	BEGIN
		Set @sTextMsg = '#cra_cpt_dmde# à 1 : 2'
		BREAK
	END

	-- #cra_dat_gen# à cree_le + 1'
	insert into sysadm.div_sin
	select @dcIdSin, dp.nom_zone, dp.lib_label,dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'O',dp.cpt_tri, null,   null,  @dteCreeLe + 1, null, GetDate(),GetDate(), 'SQLS', GetDate(), 'SQLS'
	from sysadm.div_pro dp
	where dp.nom_zone = 'cra_dat_gen' and id_prod = @dcIdProd
	IF @@ERROR <> 0
	BEGIN
		Set @sTextMsg = '#cra_dat_gen# à cree_le + 1 : 1'
		BREAK
	END
	
	insert into sysadm.w_div_sin
	select @dcIdSin, dp.nom_zone, dp.lib_label,dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'O',dp.cpt_tri, null,   null,  @dteCreeLe + 1, null, 1, GetDate(),GetDate(), 'SQLS'
	from sysadm.div_pro dp
	where dp.nom_zone = 'cra_dat_gen' and id_prod = @dcIdProd
	and   EXISTS ( select * from w_sin where id_sin = @dcIdSin )
	IF @@ERROR <> 0
	BEGIN
		Set @sTextMsg = '#cra_dat_gen# à cree_le + 1 : 2'
		BREAK
	END

	-- #cra_last_dte# à null
	insert into sysadm.div_sin
	select @dcIdSin, dp.nom_zone, dp.lib_label,dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'O',dp.cpt_tri, null,   null,  null, null, GetDate(),GetDate(), 'SQLS', GetDate(), 'SQLS'
	from sysadm.div_pro dp
	where dp.nom_zone = 'cra_last_dte' and id_prod = @dcIdProd
	IF @@ERROR <> 0
	BEGIN
		Set @sTextMsg = '#cra_last_dte# à null : 1 :'
		BREAK
	END
	
	insert into sysadm.w_div_sin
	select @dcIdSin, dp.nom_zone, dp.lib_label,dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'O',dp.cpt_tri, null,   null,  null, null, 1, GetDate(),GetDate(), 'SQLS'
	from sysadm.div_pro dp
	where dp.nom_zone = 'cra_last_dte' and id_prod = @dcIdProd
	and   EXISTS ( select * from w_sin where id_sin = @dcIdSin )
	IF @@ERROR <> 0
	BEGIN
		Set @sTextMsg = '#cra_last_dte# à null : 2 :'
		BREAK
	END

	-- On détermine le status du controle IMEI
	IF @sNumImeiPort = @sRefCie and @sNumImeiPort is not null and @sRefCie is not null
	BEGIN
		Set @iCraSuiviImei= 2 -- Controle IMEI OK
	END
	ELSE
	BEGIN
		IF @dcCodEtat = 100 
		BEGIN
			IF @sNumImeiPort is not null and @sRefCie is null
				Set @iCraSuiviImei	= 1 -- Controle en Cours
			IF @sNumImeiPort <> @sRefCie and @sNumImeiPort is not null and @sRefCie is not null
				Set @iCraSuiviImei	= 100 -- Refus Ancien Controle
		END
		ELSE
		BEGIN
			Set @iCraSuiviImei	= 100 -- Refus Ancien Controle
		END
	END

	-- #cra_suivi_imei# à la valeur determinée ci-dessus
	insert into sysadm.div_sin
	select @dcIdSin, dp.nom_zone, dp.lib_label,dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'O',dp.cpt_tri, @iCraSuiviImei,   null,  null, null, GetDate(),GetDate(), 'SQLS', GetDate(), 'SQLS'
	from sysadm.div_pro dp
	where dp.nom_zone = 'cra_suivi_imei' and id_prod = @dcIdProd
	IF @@ERROR <> 0
	BEGIN
		Set @sTextMsg = '#cra_suivi_imei# : 1 er etape ' + cast(@iCraSuiviImei as varchar(3))
		BREAK
	END
	
	insert into sysadm.w_div_sin
	select @dcIdSin, dp.nom_zone, dp.lib_label,dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'O',dp.cpt_tri, @iCraSuiviImei,   null,  null, null, 1, GetDate(),GetDate(), 'SQLS'
	from sysadm.div_pro dp
	where dp.nom_zone = 'cra_suivi_imei' and id_prod = @dcIdProd
	and   EXISTS ( select * from w_sin where id_sin = @dcIdSin )
	IF @@ERROR <> 0
	BEGIN
		Set @sTextMsg = '#cra_suivi_imei# : 2eme etape ' + cast(@iCraSuiviImei as varchar(3))
		BREAK
	END

	FETCH NEXT FROM cursor_sinistre_cra
	INTO	@dcIdSin, 
		@dcIdProd, 
		@dteCreeLe,
		@dcCodEtat,
		@sNumImeiPort,
		@sRefCie
	IF @@ERROR <> 0
	BEGIN
		Set @sTextMsg = 'Fecth cursor'
		BREAK
	END
	
END -- Fin de boucle while

CLOSE cursor_sinistre_cra
DEALLOCATE cursor_sinistre_cra

ALTER TABLE sysadm.div_sin ENABLE TRIGGER TR_I01_DIV_SIN

IF @iFetch <> 0 OR @sTextMsg <> 'OK'
BEGIN
	print @sTextMsg
	ROLLBACK TRAN
END
ELSE
BEGIN
	COMMIT TRAN
END

GO
