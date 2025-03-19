-------------------------------------------------------------------
--
-- Fichier              :       TRACE_WEB_SERVICE.CP
-- Auteur               :       Fabry JF
-- Date                 :       17/03/2016
--
-- Commentaires         :       
--
-- Proc‚dures           :      
-- sysadm.PS_I_TRACE_WEB_SERVICE
-- sysadm.PS_I_CTL_BOUTIQUE_PSM
-------------------------------------------------------------------

--------------------------------------------------------------------
-- Proc‚dure            :       PS_I_TRACE_WEB_SERVICE
-- Auteur               :       Fabry JF
-- Date                 :       17/03/2016
-- Libell‚              :
-- Commentaires         :       Recherche d'écart et alerte par mail.
-- R‚f‚rences           :
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_TRACE_WEB_SERVICE' AND type = 'P' )
        DROP procedure sysadm.PS_I_TRACE_WEB_SERVICE
GO

CREATE PROCEDURE sysadm.PS_I_TRACE_WEB_SERVICE
@sNomWS			varchar(50),
@sUrlWs			varchar(150),
@dcIdSin		decimal(10),
@sCodeErr		integer,
@sLibErr		varchar(8000),
@sCommentaire	varchar(8000),
@sCodOper		varchar(4)
AS

Insert into sysadm.trace_web_service 
	 (
	 nom_ws,     
	 url_ws,     
	 id_sin,     
	 code_err,
	 lib_err,
	 commentaire,
	 cree_le,
	 maj_le,     
	 maj_par
	 )
Values
	 (
	 @sNomWS,
	 @sUrlWs,		
	 @dcIdSin,	
	 @sCodeErr,	
	 @sLibErr,	
	 @sCommentaire,	
	 Getdate(),
	 Getdate(),
	 @sCodOper		
	 )	     
Go

grant execute on sysadm.PS_I_TRACE_WEB_SERVICE to rolebddsinistres
Go

--------------------------------------------------------------------
-- Proc‚dure            :       PS_I_CTL_BOUTIQUE_PSM
-- Auteur               :       FPI
-- Date                 :       23/02/2018
-- Libell‚              :
-- Commentaires         :       Trace les retours PSM avec une boutique fermée
-- R‚f‚rences           :
--
-- Arguments            :       
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      19/03/2025   [LGY_40]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_CTL_BOUTIQUE_PSM' AND type = 'P' )
        DROP procedure sysadm.PS_I_CTL_BOUTIQUE_PSM
GO

CREATE PROCEDURE sysadm.PS_I_CTL_BOUTIQUE_PSM
	@dcIdSin decimal(10,0),
	@sCodeMag varchar(10),
	@sCodOper varchar(5),
	@sRequest varchar(8000),
	@sResponse varchar(8000)
As
	Declare @tbBoutiquesFermees TABLE (code_mag varchar(10))
	DECLARE @sBody VARCHAR(8000),
		@sObjet VARCHAR(200),
		@sRetourErrMail VarChar(255),
		@sCommande varchar(8000),
		@sFicOutRequest     VarChar(255),
		@sFicOutReponse     VarChar(255)

	DECLARE @sRoot VarChar(255)

	Insert into @tbBoutiquesFermees values ('79'),('FR79'),('FR079')

	if not exists (select 1 from @tbBoutiquesFermees where code_mag=@sCodeMag) return 1

	-- Création du fichier d'appel
	-- Set @sFicOutRequest=master.sysadm.SPB_FN_GET_ROOT() + 'Simpa2\Trace\Trace_Web\PSM_request_' + 
	-- [LGY_40]
	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO' Set @sRoot = sysadm.FN_GET_CHEMIN ( 'ROOT_PROD_EXTRACTION' ) Else Set @sRoot = sysadm.FN_GET_CHEMIN ( 'ROOT_SIM_EXTRACTION' )
	Set @sFicOutRequest=@sRoot + 'Simpa2\Trace\Trace_Web\PSM_request_' + 
		convert(varchar(10),getdate(), 112) + '_' + Replace(convert(varchar(10),getdate(), 108),':','') +
		'.xml'

	Set @sFicOutReponse=Replace(@sFicOutRequest,'PSM_request','PSM_reponse')

	SET @sCommande = 	'sqlcmd /S' + @@servername + ' /E /Q"SET NOCOUNT ON;select ''' + 
			Replace(Replace(@sRequest,'"','""'),'''','''''') + 
			''';" /h-1 /o' + @sFicOutRequest + ' -w5000' + ' /b /u'

	EXEC master.dbo.xp_cmdshell @sCommande, no_output

	-- Création du fichier de réponse
	SET @sCommande = 	'sqlcmd /S' + @@servername + ' /E /Q"SET NOCOUNT ON;select ''' + 
			Replace(Replace(@sResponse,'"','""'),'''','''''') + 
			''';"  /h-1 /o' + @sFicOutReponse + ' -w5000' + ' /b /u'

	EXEC master.dbo.xp_cmdshell @sCommande, no_output

	-- Mail
	Set @sFicOutRequest = @sFicOutRequest + ',' + @sFicOutReponse

	Set @sObjet='Retour PSM sur boutique fermée'
	set @sBody  = 'Le WebService PSM a renvoyé la boutique ' + @sCodeMag  + 
		' pour le dossier ' + convert(varchar(10), @dcIdSin) + '.' + char(13) 
	Set @sBody=@sBody +  'Cette boutique PSM est fermée.'  + char(13)  + char(13) 

	Set @sBody=@sBody +  'Informations :'  + char(13)
	Set @sBody=@sBody +  'N° de dossier : '  + convert(varchar(10), @dcIdSin) + char(13)
	Set @sBody=@sBody +  'Boutique renvoyée par le WebService PSM : '  + @sCodeMag + char(13)
	Set @sBody=@sBody +  'Trigramme du GT : '  + @sCodOper + char(13)
	Set @sBody=@sBody +  'Date heure : '  + convert(varchar(10), getdate(),103) + ' '  + convert(varchar(10),getdate(), 108) + char(13)
	Set @sBody=@sBody +  'Contenu de l''appel : (voir fichier PSM_request ci_joint)' + char(13) 
	Set @sBody=@sBody +  'Contenu du retour du webservice : (voir fichier PSM_reponse ci_joint)'

	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			'jff@spb.fr,fpi@spb.eu',
			@sBody, 
			@sObjet, 
			'', 
			'', 
			@sFicOutRequest, 
			NULL, 
			NULL, 
			NULL, 
			NULL

Go

grant execute on sysadm.PS_I_CTL_BOUTIQUE_PSM to rolebddsinistres
Go