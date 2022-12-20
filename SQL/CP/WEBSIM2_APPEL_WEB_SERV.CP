-------------------------------------------------------------------
--
-- Fichier              :       WEBSIM2_APPEL_WEB_SERV.CP
-- Auteur               :       FPI
-- Date                 :       04/2010
--
-- Commentaires         :       Gestion des sinistres en boutique
--				Ces procédures sont mises à disposition des web services pour le site Intranet Web Simpa2.
--				[WEBSIM2].[FRANCE]
-------------------------------------------------------------------
-- PS_WEBSIM2_WEBSERV_AUTHENTIFICATION	JFF 13/04/2010 Procédure d'authentification du sinistre et de vérification de la validité de l'échange
-- PS_WEBSIM2_WEBSERV_LECTURE_DONNEES	JFF 13/04/2010 Renvoie l'ensemble des données liés à la commande d'un sinistre
-- PS_WEBSIM2_WEBSERV_VALIDATION 	JFF 13/04/2010 Valide l'échange de produit
-- PS_WEBSIM2_WEBSERV_LECTURE_DONNEES_LISTE FPI 28/07/2010 [PC321] Liste des sinistres selon critères
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSIM2_WEBSERV_AUTHENTIFICATION
-- Auteur               :       FABRY JF
-- Date                 :       13/04/2010 
-- Libelle              :        
-- Commentaires         :       Procédure d'authentification du sinistre et 
--				de vérification de la validité de l'échange
--                               
-- References           :       
--
-- Arguments            :       @asIdSin               VarChar(7)        	(Val) Identifiant de sinistre
--				@asNom			Varchar(50)		(Val) Nom du souscripteur
--				@asSKU			Varchar(100)		(Val) Numéro de SKU
--                              @asCas                  VarChar ( 40   )        (Val) Cas de Trt : 
--                                                                              CNX = Connexion + contrôle de validité du dossier
--										CTRL = contrôle de validité du dossier
--				@asCasProduit		VarChar(50)		(Val) Cas Produit = FNAC_SUISSE
--                              @asLangage              VarChar (  3 )          (Val) Code de la Langue utilisé pour les mess de retour ( -LG/CodeCar )
--                              @asRetourMess           VarChar (  2000 )       (Réf) Message à afficher en retour
--
--
-- Retourne             :       Integer                 >0 = OK
--                                                      -1 = NOK
--
-------------------------------------------------------------------
-- FPI - 19/07/2010 - [PC321]
-- FPI - 22/09/2014 - [PC13447-1] Ajout OMEA_TELECOM
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSIM2_WEBSERV_AUTHENTIFICATION' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSIM2_WEBSERV_AUTHENTIFICATION
GO


CREATE PROCEDURE sysadm.PS_WEBSIM2_WEBSERV_AUTHENTIFICATION
	@asIdSin                VarChar(50),
	@asMdp			VarChar(50),
	@asNom			Varchar(50),
	@asSKU			Varchar(50),
	@asCodeVendeur		Varchar(50),
	@asCodeMagasin		Varchar(50),
	@asNifCifNie		VarChar(50),	
	@asCas                  VarChar(50),
	@asCasProduit		VarChar(50),
	@asIdSession     	varchar(50),
	@asBrowser       	varchar(200),
        @asLangage              VarChar (3),
	@aiCodeMsg		Integer OUTPUT,
        @asRetourMess           VarChar ( 2000 ) OUTPUT

AS
Declare @iRet	integer
DECLARE @dcIdSin 	Decimal ( 10 ) -- [PI062]
Declare @ValCarTrace  VarChar ( 254 )

Set @dcIdSin = Convert ( Decimal ( 10 ),  @asIdSin ) -- [PI062]

Set @iRet=-1

If @asCasProduit='EXPANSION5_FRANCE'
Begin
	Exec @iRet=sysadm.PS_WEBSIM2_AUTHENT_EXP5_FRANCE 
		@asIdSin,
		@asMdp,
		@asNom,
		@asSKU, 
		@asCodeVendeur,
		@asCodeMagasin,
		@asCas, 
		@asIdSession,
		@asBrowser,
		@asLangage, 
		@aiCodeMsg    OUTPUT,
		@asRetourMess OUTPUT
End

If @asCasProduit='CARREFOUR_CASSE_VOL_SAV'
Begin
	Exec @iRet=sysadm.PS_WEBSIM2_AUTHENT_CARREFOUR_CV_SAV 
		@asIdSin,
		@asMdp,
		@asNom,
		@asSKU, 
		@asCodeVendeur,
		@asCodeMagasin,
		@asCas, 
		@asIdSession,
		@asBrowser,
		@asLangage, 
		@aiCodeMsg    OUTPUT,
		@asRetourMess OUTPUT
End

If @asCasProduit='MC_PROTECT' Select @iRet=1, @asRetourMess='OK'
If @asCasProduit='OMEA_TELECOM' Select @iRet=1, @asRetourMess='OK'

If @asRetourMess is null Or Len ( @asRetourMess ) <= 0 And @iRet = 1 Set @asRetourMess = 'OK'

If @iRet > 0 And ( Upper ( @asCas )<> 'NO_TRACE' Or @asCas is null )
	Begin
		-- [TRACE_20]
		EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@asCasProduit,  -- @asCasProduit    varchar(50),
			@dcIdSin,	-- @dcIdSin	    Decimal (10), -- [PI062]
			@asMdp,		-- @asMdp	    VarChar(50),
			@asNom,		-- @asNom	    Varchar(50),
			@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
			@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
			20,		-- @adcIdCodeTrc    Decimal(7),
			'TRACE',	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'CNX',		-- @asEtape         varchar(20),
			null,		-- @aiIdMess        integer
			@ValCarTrace,	-- @asValCar	 VarChar(254),
			null		-- @asMajPar	 VarChar ( 4 )
	End

Return @iRet
Go

grant execute on sysadm.PS_WEBSIM2_WEBSERV_AUTHENTIFICATION to rolebddsinistres
go

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSIM2_WEBSERV_LECTURE_DONNEES  
-- Auteur               :       FABRY JF
-- Date                 :       13/04/2010 
-- Libelle              :        
-- Commentaires         :       Renvoie l'ensemble des données liés à la commande d'un sinistre
--                               
-- References           :       
--
-- Arguments            :       @asIdSin               VarChar(7)        	(Val) Identifiant de sinistre
--				@asNom			Varchar(50)		(Val) Nom du souscripteur
--				@asSKU			Varchar(100)		(Val) Numéro de SKU
--                              @asCasProduit		VarChar(50)		(Val) Cas Produit = FNAC_SUISSE
--                              @asLangage              VarChar (  3 )          (Val) Code de la Langue utilisé pour les mess de retour ( -LG/CodeCar )
--                              @asRetourMess           VarChar (  2000 )       (Réf) Message à afficher en retour
--
--
-- Retourne             :       la liste des données
--
-------------------------------------------------------------------
-- FPI - 19/07/2010 - [PC321] Ajout du cas CARREFOUR_CASSE_VOL_SAV
-- FPI - 05/04/2011 - [PC321] Pour SAV Carrefour, on ne contrôle pas l'accès
-- FPI - 30/11/2012 - [PC853] MC Protect
-- FPI - 23/09/2014 - [PC13447-1] OMEA_TELECOM
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSIM2_WEBSERV_LECTURE_DONNEES' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSIM2_WEBSERV_LECTURE_DONNEES
GO

CREATE PROCEDURE        sysadm.PS_WEBSIM2_WEBSERV_LECTURE_DONNEES
	@asIdSin                VarChar(50),
	@asMdp			VarChar(50),
	@asNom			Varchar(50),
	@asSKU			Varchar(50),
	@asCodeVendeur		Varchar(50),
	@asCodeMagasin		Varchar(50),
	@asNifCifNie		VarChar(50),
	@asCas                  VarChar(50),
	@asCasProduit		VarChar(50),
	@asIdSession     	varchar(50),
	@asBrowser       	varchar(200),
        @asLangage              VarChar (3),
	@aiCodeMsg		Integer OUTPUT,
        @asRetourMess           VarChar ( 2000 ) OUTPUT

AS
Declare @iRet	integer
DECLARE @dcIdSin 	Decimal ( 10 ) -- [PI062]

Set @dcIdSin = Convert ( Decimal ( 10 ),  @asIdSin ) -- [PI062]

Exec @iRet=sysadm.PS_WEBSIM2_WEBSERV_AUTHENTIFICATION 
	@asIdSin,
	@asMdp,
	@asNom,
	@asSKU,
	@asCodeVendeur,
	@asCodeMagasin,
	@asNifCifNie,
	'NO_TRACE',
	@asCasProduit,
	@asIdSession,
	@asBrowser,
        @asLangage,
	@aiCodeMsg    OUTPUT,
        @asRetourMess OUTPUT

--If @iRet < 0 Return @iRet -- [PC321]


If @asCasProduit = 'EXPANSION5_FRANCE'
Begin
	If @iRet < 0 Return @iRet -- [PC321]
	
	Exec @iRet=sysadm.PS_WEBSIM2_LECTDONN_EXP5_FRANCE  
		@asIdSin,
		@asNom, 
		@asSKU, 
		@asCodeVendeur,
		@asCodeMagasin,
		@asCas, 
		@asIdSession,
		@asBrowser,
		@asLangage, 
		@aiCodeMsg    OUTPUT,
		@asRetourMess OUTPUT
	
End

If @asCasProduit = 'CARREFOUR_CASSE_VOL_SAV'
Begin
	Exec @iRet=sysadm.PS_WEBSIM2_LECTDONN_SAV_CARR
		@asIdSin,
		@asNom, 
		@asSKU, 
		@asCodeVendeur,
		@asCodeMagasin,
		@asCas, 
		@asIdSession,
		@asBrowser,
		@asLangage, 
		@aiCodeMsg    OUTPUT,
		@asRetourMess OUTPUT
End

If @asCasProduit = 'MC_PROTECT'
Begin
	Exec @iRet=sysadm.PS_WEBSIM2_LECTDONN_MC_PROTECT
		@asIdSin,
		@asNom, 
		@asSKU, 
		@asCodeVendeur,
		@asCodeMagasin,
		@asCas, 
		@asIdSession,
		@asBrowser,
		@asLangage, 
		@aiCodeMsg    OUTPUT,
		@asRetourMess OUTPUT
End

If @asCasProduit = 'OMEA_TELECOM'
Begin
	Exec @iRet=sysadm.PS_WEBSIM2_LECTDONN_OMEA_TELECOM
		@asIdSin,
		@asNom, 
		@asSKU, 
		@asCodeVendeur,
		@asCodeMagasin,
		@asCas, 
		@asIdSession,
		@asBrowser,
		@asLangage, 
		@aiCodeMsg    OUTPUT,
		@asRetourMess OUTPUT
End

If @asRetourMess is null Or Len ( @asRetourMess ) <= 0 And @iRet = 1 Set @asRetourMess = 'OK'

If @iRet > 0 
	Begin
		-- [TRACE_26]
		EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@asCasProduit,  -- @asCasProduit    varchar(50),
			@dcIdSin,	-- @dcIdSin	    Decimal (10), -- [PI062]
			@asMdp,		-- @asMdp	    VarChar(50),
			@asNom,		-- @asNom	    Varchar(50),
			@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
			@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),			
			26,		-- @adcIdCodeTrc    Decimal(7),
			'TRACE', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'LECT_DONNEES',	-- @asEtape         varchar(20),
			null,		-- @aiIdMess        integer
			null,		-- @asValCar	 VarChar(254),			
			null		-- @asMajPar	 VarChar ( 4 )	
	End

Return @iRet

Go


grant execute on sysadm.PS_WEBSIM2_WEBSERV_LECTURE_DONNEES to rolebddsinistres
go

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSIM2_WEBSERV_VALIDATION   
-- Auteur               :       FABRY JF
-- Date                 :       13/04/2010 
-- Libelle              :        
-- Commentaires         :       Valide l'échange de produit
--                               
-- References           :       
--
-- Arguments            :       @asIdSin               VarChar(7)        	(Val) Identifiant de sinistre
--				@asNom			Varchar(50)		(Val) Nom du souscripteur
--				@asSKU			Varchar(100)		(Val) Numéro de SKU
--                              @asCasProduit		VarChar(50)		(Val) Cas Produit = FNAC_SUISSE
--                              @asLangage              VarChar (  3 )          (Val) Code de la Langue utilisé pour les mess de retour ( -LG/CodeCar )
--                              @asRetourMess           VarChar (  2000 )       (Réf) Message à afficher en retour
--
--
-- Retourne             :       Integer                 >0 = OK
--                                                      -1 = NOK
--
-------------------------------------------------------------------
-- FPI - 19/07/2010 - [PC321] Ajout des param CommentFrn & VarSeria + bPart
-- FPI - 19/07/2010 - [PC846/864] Ajout Carrefour PEM
-- FPI - 22/09/2014 - [PC13447-1] Ajout OMEA_TELECOM
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSIM2_WEBSERV_VALIDATION' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSIM2_WEBSERV_VALIDATION
GO

CREATE PROCEDURE        sysadm.PS_WEBSIM2_WEBSERV_VALIDATION
	@asIdSin                VarChar(50),
	@asMdp			VarChar(50),
	@asNom			Varchar(50),
	@asSKU			Varchar(50),
	@asCodeVendeur		Varchar(50),
	@asCodeMagasin		Varchar(50),
	@asNifCifNie		VarChar(50),
	@asCodeBanque		Varchar(50),
	@asCodeAgence		Varchar(50),
	@asNumcompte		Varchar(50),
	@asCleRib		Varchar(50),
	@asIban			Varchar(50),
	@asBic			Varchar(50),	
	@asIdArchive		Varchar(50),
	@asCas                  VarChar(50),
	@asCasProduit		VarChar(50),
	@asIdSession     	varchar(50),
	@asBrowser       	varchar(200),
	@asMarqRempl		varchar(50),
	@asModlRempl		varchar(50),
	@asNumSerieRempl	varchar(50),
	@asMtPrixAchatRempl	varchar(50),
	@asCommentFrn1	Varchar(255),
	@asCommentFrn2	Varchar(255),
	@asVarSeria		VarChar(500),
	@asLangage              VarChar (3),
	@aiCodeMsg		Integer OUTPUT,
    @asRetourMess           VarChar ( 2000 ) OUTPUT

AS
Declare @iRet	integer
DECLARE @dcIdSin 	Decimal ( 10 ) -- [PI062]
Declare @sType   Varchar(3)	
Declare @sMess	VarChar ( 2000 )
Declare @iIdCt	integer
Declare @bPart	integer
Set     @sType = master.dbo.SPB_FN_TYPEBASE( db_id() )

Set @dcIdSin = Convert ( Decimal ( 10 ),  @asIdSin ) -- [PI062]

Set @bPart = 0

Exec @iRet=sysadm.PS_WEBSIM2_WEBSERV_AUTHENTIFICATION 
	@asIdSin,
	@asMdp,
	@asNom,
	@asSKU,
	@asCodeVendeur,
	@asCodeMagasin,
	@asNifCifNie,
	'NO_TRACE',
	@asCasProduit,
	@asIdSession,
	@asBrowser,
        @asLangage,
	@aiCodeMsg    OUTPUT,
        @asRetourMess OUTPUT
        

If @iRet < 0 Return @iRet

If @asCasProduit='EXPANSION5_FRANCE'
Begin
	Exec @iRet=sysadm.PS_WEBSIM2_VALIDATION_EXP5_FRANCE  
		@asIdSin,
		@asNom, 
		@asSKU, 
		@asCodeVendeur,
		@asCodeMagasin,
		@asCas, 
		@asIdSession,
		@asBrowser,
		@asMarqRempl,
		@asModlRempl,
		@asNumSerieRempl,
		@asMtPrixAchatRempl,
		@asLangage, 
		@aiCodeMsg    OUTPUT,
		@asRetourMess OUTPUT
End

If @asCasProduit='CARREFOUR_CASSE_VOL_SAV'
Begin
	Exec @iRet=sysadm.PS_WEBSIM2_VALIDATION_SAV_CARR  
		@asIdSin,
		@asNom, 
		@asSKU, 
		@asCodeVendeur,
		@asCodeMagasin,
		@asCas, 
		@asIdSession,
		@asBrowser,
		@asMarqRempl,
		@asModlRempl,
		@asNumSerieRempl,
		@asMtPrixAchatRempl,
		@asCommentFrn1,
		@asCommentFrn2,
		@asVarSeria,
		@asLangage, 
		@aiCodeMsg    OUTPUT,
		@asRetourMess OUTPUT
	
	Set @bPart=1
End

If @asCasProduit='CARREFOUR_PEM_SAV'
Begin
	Exec @iRet=sysadm.PS_WEBSIM2_VALIDATION_SAV_CARR_PEM  
		@asIdSin,
		@asNom, 
		@asSKU, 
		@asCodeVendeur,
		@asCodeMagasin,
		@asCas, 
		@asIdSession,
		@asBrowser,
		@asMarqRempl,
		@asModlRempl,
		@asNumSerieRempl,
		@asMtPrixAchatRempl,
		@asCommentFrn1,
		@asCommentFrn2,
		@asVarSeria,
		@asLangage, 
		@aiCodeMsg    OUTPUT,
		@asRetourMess OUTPUT
	
	Set @bPart=1
End


If @asCasProduit='MC_PROTECT'
Begin
	Exec @iRet=sysadm.PS_WEBSIM2_VALIDATION_MC_PROTECT  
		@asIdSin,
		@asNom, 
		@asSKU, 
		@asCodeVendeur,
		@asCodeMagasin,
		@asCas, 
		@asIdSession,
		@asBrowser,
		@asMarqRempl,
		@asModlRempl,
		@asNumSerieRempl,
		@asMtPrixAchatRempl,
		@asCommentFrn1,
		@asCommentFrn2,
		@asVarSeria,
		@asLangage, 
		@aiCodeMsg    OUTPUT,
		@asRetourMess OUTPUT
	
	Set @bPart=1
End

If @asCasProduit='OMEA_TELECOM'
Begin
	Exec @iRet=sysadm.PS_WEBSIM2_VALIDATION_OMEA_TELECOM
		@asIdSin,
		@asCodeVendeur,
		@asCodeMagasin,
		@asCas, 
		@asIdSession,
		@asBrowser,
		@asMarqRempl,
		@asModlRempl,
		@asNumSerieRempl,
		@asMtPrixAchatRempl,
		@asCommentFrn1,
		@asCommentFrn2,
		@asVarSeria,
		@asLangage, 
		@aiCodeMsg    OUTPUT,
		@asRetourMess OUTPUT
	
	Set @bPart=1
End

If @iRet < 0 Return @iRet

Exec sysadm.PS_I_DIV_SIN_ETAT_ASS @dcIdSin, 'WEB'

-- Cas Particulier, on ne créé pas de contact
If @bPart=1
Begin
	If @asRetourMess is null Or Len ( @asRetourMess ) <= 0 And @iRet = 1 Set @asRetourMess = 'OK'
	Return @iRet
End

-- Cas général --
Set @sMess = 'Contact créé automatiquement, -> Commandes Web Boutique consommée en magasin par le client.'

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1,		/* Le Client est trouvé automatiquement par la proc */
						2,		/* Famille : Sinistre */
						4,		/* Type de Contact : Information */
						'C',		/* Canal : Courrier */
						@dcIdSin,	/* N° de Sinistre */
						2,		/* Application : Simpa2 */
						@sMess,		/* Le message du Contact */
						'AUTO',		/* Trig. Virtuel O2M */
						300, 		/* Etat : Contact Clos */
						@iIdCt OUTPUT	/* le N° de Ct crée, non utilisé */
END
ELSE
BEGIN
	Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1,		/* Le Client est trouvé automatiquement par la proc */
						2,		/* Famille : Sinistre */
						4,		/* Type de Contact : Information */
						'C',		/* Canal : Courrier */
						@dcIdSin,	/* N° de Sinistre */
						2,		/* Application : Simpa2 */
						@sMess,		/* Le message du Contact */
						'AUTO',		/* Trig. Virtuel O2M */
						300, 		/* Etat : Contact Clos */
						@iIdCt OUTPUT	/* le N° de Ct crée, non utilisé */

END


If @asRetourMess is null Or Len ( @asRetourMess ) <= 0 And @iRet = 1 Set @asRetourMess = 'OK'

If @iRet > 0 
	Begin
		-- [TRACE_22]
		EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			@asCasProduit,  -- @asCasProduit    varchar(50),
			@dcIdSin,	-- @dcIdSin	    Decimal (10), -- [PI062]
			@asMdp,		-- @asMdp	    VarChar(50),
			@asNom,		-- @asNom	    Varchar(50),
			@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
			@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
			22,		-- @adcIdCodeTrc    Decimal(7),
			'TRACE', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'VALIDATION',	-- @asEtape         varchar(20),
			null,		-- @aiIdMess        integer
			null,		-- @asValCar	 VarChar(254),
			null		-- @asMajPar	 VarChar ( 4 )	
	End 

Return @iRet

Go

grant execute on sysadm.PS_WEBSIM2_WEBSERV_VALIDATION to rolebddsinistres
go

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSIM2_WEBSERV_LECTURE_DONNEES_LISTE  
-- Auteur               :       FPI
-- Date                 :       28/07/2010
-- Libelle              :       [PC321]
-- Commentaires         :       Renvoie l'ensemble des sinistres selon des critères de recherche
--                               
-- References           :       
--
-- Arguments            :       @asVarSeria             VarChar(500)		(Val) Variable sérialisée contenant les critères de recherche
--				@asCas                  VarChar(50)		(Val) Cas de traitement
--				@asCasProduit		VarChar(50)		(Val) Cas Produit = FNAC_SUISSE
--				@asIdSession     	varchar(50)		(Val) Identifiant de session
--				@asBrowser       	varchar(200)		(Val) Identification du browser Web
--                              @asLangage              VarChar (  3 )          (Val) Code de la Langue utilisé pour les mess de retour ( -LG/CodeCar )
--				@aiCodeMsg		Integer			(Réf) Code message (table message)
--                              @asRetourMess           VarChar (  2000 )       (Réf) Message à afficher en retour
--
--
-- Retourne             :       la liste des données
--
-------------------------------------------------------------------
-- FPI - 30/11/2012 - [PC853] MC Protect
-- FPI - 22/09/2014 - [PC13447-1] Ajout OMEA_TELECOM
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSIM2_WEBSERV_LECTURE_DONNEES_LISTE' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSIM2_WEBSERV_LECTURE_DONNEES_LISTE
GO

CREATE PROCEDURE        sysadm.PS_WEBSIM2_WEBSERV_LECTURE_DONNEES_LISTE
	@asVarSeria             VarChar(500),
	@asCas                  VarChar(50),
	@asCasProduit		VarChar(50),
	@asIdSession     	varchar(50),
	@asBrowser       	varchar(200),
        @asLangage              VarChar (3),
	@aiCodeMsg		Integer OUTPUT,
        @asRetourMess           VarChar ( 2000 ) OUTPUT

AS
Declare @iRet	integer

Set @iRet=1

If @asCasProduit = 'CARREFOUR_CASSE_VOL_SAV'
Begin
	Exec @iRet=sysadm.PS_WEBSIM2_LECTDONN_LISTE_SAV_CARR
		@asVarSeria             ,
		@asCas                  ,
		@asIdSession     	,
		@asBrowser       	,
		@asLangage              ,
		@aiCodeMsg	OUTPUT	,
		@asRetourMess	OUTPUT
End

If @asCasProduit = 'MC_PROTECT'
Begin
	Exec @iRet=sysadm.PS_WEBSIM2_LECTDONN_LISTE_MC_PROTECT
		@asVarSeria             ,
		@asCas                  ,
		@asIdSession     	,
		@asBrowser       	,
		@asLangage              ,
		@aiCodeMsg	OUTPUT	,
		@asRetourMess	OUTPUT
End

If @asCasProduit = 'OMEA_TELECOM'
Begin
	Exec @iRet=sysadm.PS_WEBSIM2_LECTDONN_LISTE_OMEA_TELECOM
		@asVarSeria             ,
		@asCas                  ,
		@asIdSession     	,
		@asBrowser       	,
		@asLangage              ,
		@aiCodeMsg	OUTPUT	,
		@asRetourMess	OUTPUT
End

If @asRetourMess is null Or Len ( @asRetourMess ) <= 0 And @iRet = 1 Set @asRetourMess = 'OK'

Return @iRet

Go

grant execute on sysadm.PS_WEBSIM2_WEBSERV_LECTURE_DONNEES_LISTE to rolebddsinistres
go

