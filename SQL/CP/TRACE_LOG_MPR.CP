-------------------------------------------------------------------
--
-- Fichier              :       TRACE_LOG_MPR.CP
-- Auteur               :       Fabry JF
-- Date                 :       21/03/2017
--
-- Commentaires         :       
-------------------------------------------------------------------
-- sysadm.PS_I_TRACE_LOG_MPR
-- sysadm.PS_S_ENVOI_MAIL_LOG_PRESTA
-------------------------------------------------------------------

--------------------------------------------------------------------
-- Procédure            :       PS_I_TRACE_LOG_MPR
-- Auteur               :       Fabry JF
-- Date                 :       21/03/2017
-- Libellé              :		[PI065]
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_TRACE_LOG_MPR' AND type = 'P' )
        DROP procedure sysadm.PS_I_TRACE_LOG_MPR
GO

CREATE procedure sysadm.PS_I_TRACE_LOG_MPR
	@asIdFour  varchar (3),
	@alIdLotLog  decimal ( 10 ),
	@asTypMvt   varchar(3),
	@asLogMvt   varchar ( 255 ),
	@asCodOper	Varchar ( 4 )
AS

Set @asIdFour = ltrim ( rtrim ( @asIdFour ))
Set @asLogMvt = ltrim ( rtrim ( @asLogMvt ))

Insert into sysadm.trace_log_mpr
			( 
				id_four,
				id_lot,
				typ_mvt,
				log_mvt,
				cree_le,
				maj_le,
				maj_par
			)
		values 
			(
				@asIdFour,
				@alIdLotLog,
				@asTypMvt,
				@asLogMvt,
				Getdate(),
				getdate(),
				@asCodOper
			)

Go

--------------------------------------------------------------------
-- Procédure            :       PS_S_ENVOI_MAIL_LOG_PRESTA
-- Auteur               :       Fabry JF
-- Date                 :       21/03/2017
-- Libellé              :		[PI065]
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      07/03/2024   [HP252_276_HUB_PRESTA]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_ENVOI_MAIL_LOG_PRESTA' AND type = 'P' )
        DROP procedure sysadm.PS_S_ENVOI_MAIL_LOG_PRESTA
GO


CREATE procedure sysadm.PS_S_ENVOI_MAIL_LOG_PRESTA
	@asIdFour  varchar (3),
	@alIdLotLog  decimal ( 10 ),
	@asTypMvt   varchar(3),
	@asNomFicOrig varchar(100)
AS

-- If Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) ) <> 'SIMPA2_PRO' Return  [HP252_276_HUB_PRESTA]

declare @sRetourErrMail varchar (255) 
declare @sAdrMail varchar (255) 
declare @sAdrMailCc varchar (255) 
declare @sAliasFrom varchar (255) 
declare @sMailFrom varchar (255) 
declare @sMailObjet varchar (255) 
declare @sMailBody varchar (8000) 
declare @asNomFicOrigCourt varchar (100) 
declare @sSaut	VarChar (10)
declare @sAppliEnv VarChar (30)
declare @iErrImpFile integer

Set @sSaut = Char (10)
Set @iErrImpFile = 0

Set @asIdFour = ltrim ( rtrim ( @asIdFour ))
Set @asNomFicOrigCourt = reverse ( @asNomFicOrig ) 
Set @asNomFicOrigCourt = Left ( @asNomFicOrigCourt , Charindex ( '\', @asNomFicOrigCourt ) -1 )
Set @asNomFicOrigCourt = reverse ( @asNomFicOrigCourt ) 
If @asNomFicOrigCourt is null Set @asNomFicOrigCourt = ''

If Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) ) <> 'SIMPA2_PRO' -- [HP252_276_HUB_PRESTA]
	Begin
		-- Hors Production
		Set @sAdrMail = 'jff@spb.fr,VANDRE@spb.eu,BKHELIFA_ext@spb.eu,OCHAOUACHI@spb.eu'
		Set @sAdrMailCc = null
	End 
Else
	Begin
		-- Production
		Select @sAdrMail = pm.adr_mail,
			   @sAdrMailCc = pm.adr_mail_cc
		From   sysadm.param_mail_presta pm
		Where  pm.id_four = @asIdFour
	End 
/*
If Exists ( 
	SELECT Top 1  1
	FROM sysadm.trace_log_mpr mp
	Where mp.id_lot = @alIdLotLog
	And	  CharIndex ( 'ERREUR IMPORTFILE', mp.log_mvt ) > 0 
   )
   Begin 
     Set @iErrImpFile = 1
   End 
*/

IF @sAdrMail is null Set @sAdrMail = ''
IF @sAdrMailCc is null Set @sAdrMailCc = ''
Set @sMailObjet = ''

IF @sAdrMail = ''
 Begin
	Set @sAdrMail = 'GG_DSI-DO-PI@spb.eu'
	Set @sAdrMailCc = 'rpo@spb.eu,etudessimpa@spb.eu'
	Set @sMailObjet = '[A_TRAITER_MANUELLEMENT_PAR_PI] => '
 End 

Set @sAppliEnv = 'SPB(S2)'
Set @sMailFrom = '<GG_DSI-DO-PI@spb.eu>'
If Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) ) <> 'SIMPA2_PRO'
 Begin 
	Set @sAppliEnv = 'SPB(S2/REC7)'
	Set @sMailFrom = '<jff@spb.fr>'
	Set @sMailObjet = '[RECETTE] '
 End 
 
Set @sAliasFrom = @sAppliEnv + '=> Erreur Intrg. ' + sysadm.FN_CODE_CAR ( @asIdFour, '-FR' ) 
Exec sysadm.PS_CASSER_REGLE_CHAINE @sAliasFrom Output, '_', ' ' 
Set @sAliasFrom = @sAliasFrom + @sMailFrom

Set @sMailObjet = @sMailObjet +
					Case @iErrImpFile
						When 1 Then ' [ERREUR IMPORTFILE] '
						Else ''
					End + 
					'Problème intégration fichier ' +
					Case @asTypMvt
						When 'ART' Then 'article'
						When 'MPR' Then 'suivi'
						Else ''
					End + ' ' +
					IsNull ( @asNomFicOrigCourt , '' ) + ' ' + 
					'( ' + sysadm.FN_CODE_CAR ( @asIdFour, '-FR' ) + ' )'  

Set @sMailBody = 'Bonjour,' + @sSaut 
Set @sMailBody = @sMailBody + @sSaut 
Set @sMailBody = @sMailBody + 'Le fichier ' +
					Case @asTypMvt
						When 'ART' Then 'article'
						When 'MPR' Then 'suivi'
						Else ''
					End + ' ' +
				 @asNomFicOrigCourt + ' ne passe pas à l''intégration, pouvez-vous le corriger svp.'+ @sSaut 
Set @sMailBody = @sMailBody + @sSaut 

Set @sMailBody = @sMailBody + 
		(  
		Select 
				IsNull ( 
					stuff ( 
					( SELECT @sSaut + CAST(
								convert ( varchar ( 30), mp.cree_le, 103 ) + ' ' + convert ( varchar ( 30), mp.cree_le, 108 )
								+ Char ( 9 )
								+ mp.maj_par
								+ Char ( 9 )
								+ rtrim ( mp.log_mvt ) 
								AS VARCHAR(8000)) 
						FROM sysadm.trace_log_mpr mp
						Where mp.id_lot = @alIdLotLog
						And   Left ( mp.log_mvt, 10 ) <> Replicate ( '*', 10 )
						Order by mp.id_seq
						For XML PATH ('')
				   )
				, 1, 1, '' ), '')
		)
Set @sMailBody = @sMailBody + @sSaut 
Set @sMailBody = @sMailBody + @sSaut 
Set @sMailBody = @sMailBody + 'Cordialement,' + @sSaut 
Set @sMailBody = @sMailBody + @sSaut 
Set @sMailBody = @sMailBody + 'SPB Département production informatique' + @sSaut 
Set @sMailBody = @sMailBody + '71 quai Colbert 76600 Le Havre France' + @sSaut 
Set @sMailBody = @sMailBody + 'Tél. : +33 (0)2 32 74 20 31' + @sSaut 
Set @sMailBody = @sMailBody + 'ORIAS n° 07 002 642 (www.orias.fr)' + @sSaut

-- On casse la chaine objet et la chaine expediteur
Set @sMailObjet = Left ( @sMailObjet + space ( 255 ), 255 )
Exec sysadm.PS_CASSER_REGLE_CHAINE @sMailObjet Output, '_', ' ' 

Set @sAliasFrom = Left ( @sAliasFrom + space ( 128 ), 128)

EXEC master.dbo.SPB_PS_MAIL_OUTLOOK 
		@sRetourErrMail OUTPUT, 
		@sAdrMail,
		@sMailBody,
		@sMailObjet, 
		@sAliasFrom, 
		@sAdrMailCc, 
		null, 
		NULL, 
		NULL, 
		NULL, 
		NULL
Go

