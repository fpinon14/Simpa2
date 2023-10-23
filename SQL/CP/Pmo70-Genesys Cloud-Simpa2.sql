
/* Pmo070
   Objets Sql spécifiques pour Genesys Cloud Simpa2
   ------------------------------------------------

Iwd_Purge_Update_Iwd_Cloud
Iwd_Queue_Charger_Vue_Cloud
Iwd_Queue_Modifier_Etat_Cloud
Iwd_Update_Iwd_Charger			: Dédoublonage version engage
Iwd_Update_Iwd_Charger_Cloud	: Dédoublonage version cloud
Iwd_Update_Iwd_Mail_Cloud
Iwd_Update_Iwd_Modifier_flag_Cloud
Iwd_Update_Iwd_Niveau_Dbval_Cloud
Iwd_Update_Iwd_Router_Dossier_Cloud
Iwd_Update_Iwd_Supprimer_Cloud

--	[sysadm].[v_iwd_queue] Version engage modifiée pour exclure la famille 2172
--  [sysadm].[v_iwd_queue_cloud] Version cloud spécifique pour inclure la famille 2172

*/


USE [SIMPA2_TRT]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('sysadm.Iwd_Purge_Update_Iwd_Cloud') AND type in (N'P', N'PC'))
DROP PROCEDURE [sysadm].[Iwd_Purge_Update_Iwd_Cloud]
GO

-- [sysadm].[Iwd_Purge_Update_Iwd_Cloud] FS Pmo70 le 09/02/2023 Duplication de la procédure
CREATE procedure [sysadm].[Iwd_Purge_Update_Iwd_Cloud]
AS
	Declare @dtPivot datetime
	
	Set @dtPivot=DATEADD(day,-1,GETDATE())

	delete from sysadm.update_iwd
	where flag_update_iwd=4 and maj_le < @dtPivot
	
	update sysadm.update_iwd set alt_occupe='N'
	where alt_occupe='O' and maj_le < @dtPivot
GO

grant execute on [sysadm].[Iwd_Purge_Update_Iwd_Cloud] to rolebddsinistres
Go

----------------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('sysadm.Iwd_Queue_Charger_Vue_Cloud') AND type in (N'P', N'PC'))
DROP PROCEDURE [sysadm].[Iwd_Queue_Charger_Vue_Cloud]
GO

-- [sysadm].[Iwd_Queue_Charger_Vue] FS Pmo70 le 09/02/2023 Duplication de la procédure
-- [sysadm].[Iwd_Queue_Charger_Vue] FS Pmo70 le 19/09/2023 Ajout lib_departement
CREATE procedure [sysadm].[Iwd_Queue_Charger_Vue_Cloud] --PM217-2 : Procédure [Iwd_Queue_Charger_Vue]
		
	AS
  --------------------------------------------------------------------                  
  -- FS le 10/10/2013 : PM217-2 : Procédure Iwd_Queue_Charger_Vue chargement d'un élément
  --------------------------------------------------------------------
      SELECT TOP (50)
            ExternalId,
            claimNumber  ,
            IWD_ext_productSubtype,
            IWD_category, 
            LastName,
            cod_etat,
            alt_occupe, 
            [trv_cree_le],
            dos_maj_par,
            IWD_ext_sourceProcessType,
            IWD_channel,
            [etat_iwd],
            [id_iwd],
            'SIMPA2' as CRM,
            IWD_ext_sourceCreatedDateTime,
            claimNumber  ,
            departement,
			lib_departement,
            flagSC24,
            IWD_businessValue
            
        FROM 
            [sysadm].[v_iwd_queue_cloud] 
        where etat_iwd =1

GO

grant execute on [sysadm].[Iwd_Queue_Charger_Vue_Cloud] to rolebddsinistres
Go


----------------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('sysadm.Iwd_Queue_Modifier_Etat_Cloud') AND type in (N'P', N'PC'))
DROP PROCEDURE [sysadm].[Iwd_Queue_Modifier_Etat_Cloud]
GO

-- [sysadm].[Iwd_Queue_Modifier_Etat_Cloud] FS Pmo70 le 09/02/2023 Duplication de la procédure
CREATE procedure [sysadm].[Iwd_Queue_Modifier_Etat_Cloud] --PM217-2 : Procédure Iwd_Queue_Modifier_Etat
	    @iIdSin    integer,          -- Identifiant du sinistre
		@iEtat_iwd integer    = null,-- Nouveau code état / Null si pas d'update requis
		@sId_iwd   varchar(50)= null -- Nouveau id iwd / Null si pas d'update requis
	AS
		--------------------------------------------------------------------		      
		-- FS le 10/10/2013  : PM217-2 : Procédure Iwd_Queue_Modifier_Etat
		--------------------------------------------------------------------

	  Declare @sIdSin VarChar ( 10 ) -- [PI062]

	  Set @sIdSin = Convert ( VarChar ( 10 ), @iIdSin ) -- [PI062]

	  Update sysadm.w_queue set etat_iwd = @iEtat_iwd Where id_sin = @sIdSin And @iEtat_iwd is not null  -- [PI062]
	  
	  Update sysadm.w_queue set id_iwd = @sId_iwd Where id_sin = @sIdSin And @sId_iwd is not null  -- [PI062]
	  
GO

grant execute on [sysadm].[Iwd_Queue_Modifier_Etat_Cloud] to rolebddsinistres
Go


----------------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('sysadm.Iwd_Update_Iwd_Charger_Cloud') AND type in (N'P', N'PC'))
DROP PROCEDURE [sysadm].[Iwd_Update_Iwd_Charger_Cloud]
GO

-- [sysadm].[Iwd_Update_Iwd_Charger_Cloud] FS Pmo70 le 09/02/2023 Duplication de la procédure
CREATE procedure [sysadm].[Iwd_Update_Iwd_Charger_Cloud] --PM217-2 : Procédure Iwd_Update_Iwd_Charger
	AS
		
SELECT 
	id_iwd AS InteractionId,
	cod_etat,
	cast ([alt_occupe]as varchar(1)) as alt_occupe,
	queue as Queue,
	cast ([niveau_dbval_iwd] as int)           as responsable_iwd ,
	cast ([routage_iwd]      as varchar(50))   as routage_iwd, 
	cast ([txt_mess_iwd]     as varchar (254)) as txt_mess_iwd
FROM 
	sysadm.update_iwd 
WHERE 
	(flag_update_iwd = 1) and alt_occupe ='N'
	-- La corbeille doit être en famille 2172 ( f217bis)
	And	sysadm.FN_GET_ID_CORB (id_sin) in ( select id_code from sysadm.famille f217b Where f217b.id_fam = 2172 )
									   			
GO

grant execute on [sysadm].[Iwd_Update_Iwd_Charger_Cloud] to rolebddsinistres
Go


-- [sysadm].[Iwd_Update_Iwd_Charger] FS Pmo70 le 09/02/2023 Modification, exclusion famille 2172	
ALTER procedure [sysadm].[Iwd_Update_Iwd_Charger] --PM217-2 : Procédure Iwd_Update_Iwd_Charger
	AS
		
SELECT id_iwd AS InteractionId,
	cod_etat,
	cast ([alt_occupe]as varchar(1)) as alt_occupe,
	queue as Queue,
	cast ([niveau_dbval_iwd]as int) as responsable_iwd ,
	cast ([routage_iwd]     as varchar(50)) as routage_iwd, 
	cast ([txt_mess_iwd]   as varchar (254)) as txt_mess_iwd
FROM 
    sysadm.update_iwd 
WHERE 
	(flag_update_iwd = 1) and alt_occupe ='N'
	-- La corbeille ne doit pas être en famille 2172 ( f217bis)
	And sysadm.FN_GET_ID_CORB (id_sin) not in ( select id_code from sysadm.famille f217b Where f217b.id_fam = 2172 )
go


----------------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('sysadm.Iwd_Update_Iwd_Mail_Cloud') AND type in (N'P', N'PC'))
DROP PROCEDURE [sysadm].[Iwd_Update_Iwd_Mail_Cloud]
GO

-- [sysadm].[Iwd_Update_Iwd_Mail_Cloud] FS Pmo70 le 09/02/2023 Duplication de la procédure
CREATE procedure [sysadm].[Iwd_Update_Iwd_Mail_Cloud]
AS

declare 
	@sDestinataire       Varchar(255),
	@sCCi       Varchar(255),
	@dtDj	datetime,
	@dtDeb	datetime,
	@dtFin	datetime,
	@sDtj varchar(10),
        @sCommande   VarChar(250),
        @sMessage    Varchar(255),
        @sObjet      VarChar(255),
        @sFicOut     VarChar(255),
        @sNomServeur VarChar(255),
        @sPath  VarChar(255),
        @sFileName   VarChar(255),
        @sFileExt    VarChar(3),
	@sOsqlOption VarChar(255),
	@iRetOsql	int,
	@sRetourErrMail         VarChar(255)

Begin

	-- Definition des champs MailTo et Cci de l'eventuel mail à envoyer.
	Set @sDestinataire = 'cbourdoiseau@spb.eu,opons@spb.eu,mboudier@spb.eu'
	
	-- Pour debbugage et verif eventuelle, Mise en copie pour ES
	-- Set @sCCi = 'jff@spb.fr, phg@spb.fr'
	Set @sCCi = '' --'jff@spb.fr, phg@spb.fr'

	Set @sDtj = convert ( varchar(10), GetDate(),112 )


	-- chemin d'enregistrement du Result Set
	Set @sPath 	= master.sysadm.SPB_FN_GET_ROOT()+'Sinistre\Export_Iwd\'
	Set @sFileName	= 'update_iwd_' + @sDtj
	Set @sFileExt	= 'xls'

	SET @sFicOut = @sPath + @sFileName + '.' + @sFileExt

	SET @sNomServeur = @@servername
	-- Options additionelles pour osql
	-- /s"	" 	=> Separateur Tabulation
	-- /b 	=> Genere un code ERRORLEVEL exploitable par batch.
	-- /u	=> Unicode
	Set @sOsqlOption = ' ' + '/s"	"'+ ' /b' + ' /u'
	IF @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	-- [I027] Correction sysadm + date ISO	(112 au lieu de 113)
	   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
				'select * from SIMPA2_PRO.sysadm.update_iwd " /o' 
				+ @sFicOut + ' -w5000' + @sOsqlOption
	Else
	-- [I027] Correction sysadm + date ISO	(112 au lieu de 113)
	   SET @sCommande = 	'sqlcmd /S' + @sNomServeur + ' /E /Q"' + 
				'select * from SIMPA2_TRT.sysadm.update_iwd " /o' 
				+ @sFicOut + ' -w5000' + @sOsqlOption
				
	EXEC @iRetOsql = master.dbo.xp_cmdshell @sCommande, no_output

	Set @sObjet    = 'Extraction de la table update_iwd du ' + convert(varchar(10), getdate(), 103) 
	set @sMessage  = 'Veuillez trouver ci-joint le contenu de la table update_iwd au ' + + convert(varchar(10), getdate(), 103)  + '.' + Char(13)+ Char(10) +
         'Veuillez détacher sur votre disque le fichier pour pouvoir l''ouvrir.'+ Char(13)+ Char(10)

	if @iRetOsql <> 0
	BEGIN
		set @sMessage  = @sMessage + 'ATTENTION : Le fichier joint comporte des Erreurs SQL. Fichier non exploitable. Contacter Service DEI-ES.'
	END

	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			@sDestinataire, 
			@sMessage, 
			@sObjet, 
			'', 
			@sCCi, 
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL
End

GO

grant execute on [sysadm].[Iwd_Update_Iwd_Mail_Cloud] to rolebddsinistres
Go

----------------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('sysadm.Iwd_Update_Iwd_Modifier_flag_Cloud') AND type in (N'P', N'PC'))
DROP PROCEDURE [sysadm].[Iwd_Update_Iwd_Modifier_flag_Cloud]
GO

-- [sysadm].[Iwd_Update_Iwd_Modifier_flag_Cloud] FS Pmo70 le 09/02/2023 Duplication de la procédure
CREATE procedure [sysadm].[Iwd_Update_Iwd_Modifier_flag_Cloud] --PM217-2 : Procédure Iwd_Update_Iwd_Modifier_flag
	@sIdIwd varchar(50) -- Identifiant interactionId
	AS
	
	UPDATE sysadm.update_iwd SET [flag_update_iwd]=4 where id_iwd=@sIdIwd
	
GO

grant execute on [sysadm].[Iwd_Update_Iwd_Modifier_flag_Cloud] to rolebddsinistres
Go


----------------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('sysadm.Iwd_Update_Iwd_Niveau_Dbval_Cloud') AND type in (N'P', N'PC'))
DROP PROCEDURE [sysadm].[Iwd_Update_Iwd_Niveau_Dbval_Cloud]
GO

-- [sysadm].[Iwd_Update_Iwd_Niveau_Dbval_Cloud] FS Pmo70 le 09/02/2023 Duplication de la procédure
CREATE procedure [sysadm].[Iwd_Update_Iwd_Niveau_Dbval_Cloud] --PM217-2 : Procédure Iwd_Queue_Modifier_Responsable
	    @iIdSin    integer,           -- Identifiant du sinistre 
		@iNiveau_dbval integer=null -- Code du niveau requis pour double validation
		
	AS
		-------------------------------------------------------------------------		      
		-- FS le 20/11/2013  : PM217-2 : Procédure Iwd_Queue_Modifier_Responsable
		-- (Attention nom de paramétres déclarés dans n_cst_se_double_val::uf_maj_responsable_iwd)
		-------------------------------------------------------------------------
		
		Declare @sTxtMess varchar(508)
		Declare @sTxtPart1 varchar(254)
		Declare @sTxtPart2 varchar(254)
		Declare @sTxtdbval varchar(60)

		Declare @sIdSin VarChar ( 10 ) -- [PI062]

		Set @sIdSin = Convert ( VarChar ( 10 ), @iIdSin ) -- [PI062]
				
		Set @sTxtdbval = 'Double validation requise niveau ' + CONVERT ( varchar(10), @iNiveau_dbval )
		
			update sysadm.update_iwd set
			 	 [queue]            = 'iWD_Captured',
				 [niveau_dbval_iwd] = @iNiveau_dbval,
				 [maj_le]           = GETDATE(),
				 [txt_mess_iwd]     = @sTxtdbval
			Where id_sin = @iIdSin	
			
		-- Mise à jour sur w_queue avec @sTxtdbval		
					
			Select @sTxtMess = isnull(rtrim(txt_mess1),'') +
				   isnull(rtrim(txt_mess2),'') +
				   @sTxtdbval
			From sysadm.w_queue where id_sin = @sIdSin -- [PI062]
	 
			 Set @sTxtPart1 = nullif ( LEFT ( @sTxtMess, 254), '' )
			 Set @sTxtPart2 = nullif (SUBSTRING(@sTxtMess, 255, LEN(@sTxtMess) ), '')

			 update sysadm.w_queue set txt_mess1 = @sTxtPart1, txt_mess2 = @sTxtPart2 where id_sin = @sIdSin -- [PI062]	 
			
GO

grant execute on [sysadm].[Iwd_Update_Iwd_Niveau_Dbval_Cloud] to rolebddsinistres
Go


----------------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('sysadm.Iwd_Update_Iwd_Router_Dossier_Cloud') AND type in (N'P', N'PC'))
DROP PROCEDURE [sysadm].[Iwd_Update_Iwd_Router_Dossier_Cloud]
GO

-- [sysadm].[Iwd_Update_Iwd_Router_Dossier_Cloud] FS Pmo70 le 09/02/2023 Duplication de la procédure
CREATE procedure [sysadm].[Iwd_Update_Iwd_Router_Dossier_Cloud] --PM217-2 : Procédure Iwd_Queue_Modifier_Etat
    @sIdSin   varchar(10),  -- Identifiant du sinistre  -- [PI062]
	@sIdCorb  varchar(3),  -- Numéro de la corbeille
	@sOper    varchar(4),  -- Routé vers @sOper trigramme / RSP responsable / DRE département réclamation
	@sMess    varchar(508) -- Message de routage
AS
        --------------------------------------------------------------------              
        -- FS le 26/12/2013  : PM217-2 : Iwd_Update_Iwd_Router_Dossier
        --------------------------------------------------------------------
        -- [VDOC17582] FS le 29/06/2015 Si opérateur DR alors liste + DRSO ( support aux opérations )
        --------------------------------------------------------------------
        
        Declare @sTxtMess varchar(508)
        Declare @sTxtPart1 varchar(254)
        Declare @sTxtPart2 varchar(254)
        Declare @sTxtRoutage varchar(254)
        
        Set @sTxtRoutage = Left('-IWD travail routé à ' + @sOper + ' ' + @sMess,254)
  
        -- Cas 1 : Routé DRE,RSP + La ligne existe dans update_iwd
              
        update sysadm.update_iwd set
                    [queue]       = 'iWD_Captured',
                    [routage_iwd] = @sOper,
                    [maj_le]      = GETDATE(),
                    [alt_occupe]  = 'N',
                    [txt_mess_iwd] =       @sTxtRoutage                 
              Where id_sin       = CONVERT(integer, @sIdSin ) And  @sOper in ('RSP#','DRE#', 'DSA#', 'RDR#', 'DRS#' )
              
              
        -- Cas 2 : Routé DRE,RSP + La ligne n'existe pas dans update_iwd
        
        INSERT INTO [sysadm].[update_iwd]
                    ([id_sin]
                    ,[cod_etat]
                    ,[alt_occupe]
                    ,[flag_update_iwd]
                    ,[id_iwd]
                    ,[queue]
                    ,[routage_iwd]
                    ,[maj_le]
                    ,[txt_mess_iwd]
                    )
              Select
                    q.id_sin       , -- id_sin  
                     q.cod_etat     , -- cod_etat
                    'N',               -- alt_occupe
                    1              , -- flag update iwd
                    q.id_iwd       , -- id_iwd de w_queue
                    'iWD_Captured', -- queue
                    @sOper          , -- routage_iwd
                    GETDATE(), 
                     @sTxtRoutage
              From 
                    sysadm.w_queue q
              Where q.id_sin   = @sIdSin And
                      q.id_iwd   is not null And
                      q.etat_iwd = 2         And
                      @sOper in ('RSP#','DRE#', 'DSA#', 'RDR#', 'DRS#' ) And
                      not exists ( select * from sysadm.update_iwd v Where v.id_sin = q.id_sin )
                      
  -- Cas 3 : Routé à soi même = cloture de l'action = delete
  
  Delete from sysadm.update_iwd Where id_sin = CONVERT(integer, @sIdSin ) and @sOper not in ('RSP#','DRE#', 'DSA#', 'RDR#', 'DRS#' )
  
        
        -- Mise à jour sur w_queue avec @sTxtRoutage         
                          
              Select @sTxtMess = isnull(rtrim(txt_mess1),'') +
                       isnull(rtrim(txt_mess2),'') +
                       @sTxtRoutage
              From sysadm.w_queue where id_sin = @sIdSin
  
              Set @sTxtPart1 = nullif ( LEFT ( @sTxtMess, 254), '' )
              Set @sTxtPart2 = nullif (SUBSTRING(@sTxtMess, 255, LEN(@sTxtMess) ), '')

              update sysadm.w_queue set txt_mess1 = @sTxtPart1, txt_mess2 = @sTxtPart2 where id_sin = @sIdSin  

GO

grant execute on [sysadm].[Iwd_Update_Iwd_Router_Dossier_Cloud] to rolebddsinistres
Go


----------------------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('sysadm.Iwd_Update_Iwd_Supprimer_Cloud') AND type in (N'P', N'PC'))
DROP PROCEDURE [sysadm].[Iwd_Update_Iwd_Supprimer_Cloud]
GO

-- [sysadm].[xxxxxxxxxxxxxxx_Cloud] FS Pmo70 le 09/02/2023 Duplication de la procédure
CREATE PROCEDURE [sysadm].[Iwd_Update_Iwd_Supprimer_Cloud] --PM217-2 : Procédure Iwd_Update_Iwd_Supprimer
    @sIdIwd VARCHAR(50) -- Identifiant iwd du sinistre à supprimer

AS

-- A.PAPILLON le 12/06/2017 : Retrait du if exist
--                          : Modification indexe update_iwd_id_iwd
    SET NOCOUNT ON;

    -- Réinitialisation des flags sur w_queue

    UPDATE sysadm.w_queue
    SET    id_iwd = NULL
         , etat_iwd = 1
    FROM   sysadm.update_iwd u
    WHERE  CAST(u.id_sin AS CHAR(10)) = sysadm.w_queue.id_sin
           AND -- [PI062]
        u.queue = 'iWD_Completed'
           AND u.id_iwd = @sIdIwd;



    DELETE FROM sysadm.update_iwd
    WHERE id_iwd = @sIdIwd;

-- Suppression de la ligne dans update_iwd

GO

grant execute on [sysadm].[Iwd_Update_Iwd_Supprimer_Cloud] to rolebddsinistres
Go


----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- Vues
--	[sysadm].[v_iwd_queue] modifiée pour exclure la famille 2172
--  [sysadm].[v iwd_queue_cloud] spécifique pour inclure la famille 2172
----------------------------------------------------------------------------------------------------


ALTER view [sysadm].[v_iwd_queue]  -- Vue v_iwd_queue
	as
	      Select 
           rtrim (q.id_sin)  as ExternalId, 
           rtrim (q.id_sin)  as claimNumber  ,
           rtrim (q.id_corb) as IWD_ext_productSubtype, -- FS le 21/09/16 ; Attente Go de OLP pour remplacer par id_prod
           rtrim (q.id_corb) as IWD_category,		   -- OLP Vu avec FS le 21/09/16, remplacement de id_prod par id_corb
           rtrim (q.nom)as LastName,
           cast (q.cod_etat as int) as cod_etat,
           rtrim (q.alt_occupe)as alt_occupe,
           q.trv_cree_le,
           rtrim (q.cod_recu)as IWD_channel,
           q.etat_iwd,
           q.id_iwd,
           q.id_contact,
           rtrim (q.dos_maj_par) as dos_maj_par,
           rtrim (q.dos_maj_par) as IWD_ext_sourceProcessType,
           cast (q.cod_etat as int) as IWD_businessValue,
           q.dos_maj_le  as IWD_ext_sourceCreatedDateTime,
           dp.id_code_num  as departement,
           sysadm.FN_CODE_NUM ( dp.id_code_num, '-UO' ) as lib_departement,
           CASE
          WHEN upper(txt_mess1) like '%DEMANDE SC24 EST%' THEN 1 
          Else null -- Ald 0 Dde CBO le 19/09/2024
          END as flagSC24,
          rtrim(q.routage_iwd) as routage_iwd
        FROM   sysadm.w_queue q
            inner join sysadm.det_pro dp on dp.id_prod = q.id_prod and dp.id_code_dp = 99 and dp.id_typ_code_dp = '-DP' 
        Where 
			q.etat_iwd is not NULL 
			And
			  -- La corbeille ne doit pas être en famille 2172 ( f217bis)
			( q.id_corb not in ( select id_code from sysadm.famille f217b Where f217b.id_fam = 2172 )
			  -- ou bien La longueur des id_iwd engage est 16
			  Or len(q.id_iwd) =16 
			)
GO


IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[sysadm].[v_iwd_queue_cloud]'))
	DROP VIEW [sysadm].v_iwd_queue_cloud
GO

-- [sysadm].[v_iwd_queue_cloud] FS Pmo70 le 09/02/2023 Vue spécifique pour les corbeilles migrées sur CCO
CREATE view [sysadm].[v_iwd_queue_cloud]  -- Vue v_iwd_queue
	as
	      Select 
           rtrim (q.id_sin) as ExternalId, 
           rtrim (q.id_sin) as claimNumber  ,
           rtrim (q.id_corb)as IWD_ext_productSubtype, -- FS le 21/09/16 ; Attente Go de OLP pour remplacer par id_prod
           rtrim (q.id_corb) as IWD_category,		   -- OLP Vu avec FS le 21/09/16, remplacement de id_prod par id_corb
           rtrim (q.nom)as LastName,
           cast (q.cod_etat as int) as cod_etat,
           rtrim (q.alt_occupe)as alt_occupe,
           q.trv_cree_le,
           rtrim (q.cod_recu)as IWD_channel,
           q.etat_iwd,
           q.id_iwd,
           q.id_contact,
           rtrim (q.dos_maj_par) as dos_maj_par,
           rtrim (q.dos_maj_par) as IWD_ext_sourceProcessType,
           cast (q.cod_etat as int) as IWD_businessValue,
           q.dos_maj_le  as IWD_ext_sourceCreatedDateTime,
           dp.id_code_num  as departement,
           Upper ( sysadm.FN_EPURE_CHAINE_V02 ( sysadm.FN_CODE_NUM ( dp.id_code_num, '-UO' ), 'EXCL_SLASHX2' )) as lib_departement, -- JFF le 19/09 RS5900 CBO, pour mettre en majuscule sans accents sans modifier les données -UO de ma table que je veux laisser en minuscules.
           CASE
          WHEN upper(txt_mess1) like '%DEMANDE SC24 EST%' THEN 1 
          Else null -- Ald 0 Dde CBO le 19/09/2024
          END as flagSC24,
          rtrim(q.routage_iwd) as routage_iwd
       FROM   sysadm.w_queue q
            inner join sysadm.det_pro dp on dp.id_prod = q.id_prod and dp.id_code_dp = 99 and dp.id_typ_code_dp = '-DP'
       where 
			q.etat_iwd is not NULL
			-- La corbeille doit être en famille 2172 ( f217bis)
			And	( q.id_corb in ( select id_code from sysadm.famille f217b Where f217b.id_fam = 2172 )
			      -- ou La longueur des id_iwd engage est 16
			      OR len(q.id_iwd) > 16 )
GO

grant select, insert, delete, update on sysadm.v_iwd_queue_cloud to rolebddsinistres
go








