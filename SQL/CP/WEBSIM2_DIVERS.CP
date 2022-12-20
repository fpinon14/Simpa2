-------------------------------------------------------------------
--
-- Fichier              :       WEBSIM2_DIVERS.CP
-- Auteur               :       FABRY JF
-- Date                 :       04/2010
--
-- Commentaires         :       Fonction/PS diverses interne aus PS ES
--				Ces procédures ne sont pas visibles depuis les Web Services du site.
--				[WEBSIM2].[FRANCE]
-------------------------------------------------------------------
-- PS_WEBSIM2_AUTHENT_CTRL_GENERAL	JFF 13/04/2010 Procédure d'authentification (Contrôle général à tous les produits)
-- PS_WEBSIM2_VALIDATION_CTRL_GENERAL	JFF 13/04/2010 Procédure d'authentification (Contrôle général à tous les produits)
--  PS_WEBSIM2_MAJ_CMDE			FPI	19/07/2010 Procédure de mise à jour de commande
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSIM2_AUTHENT_CTRL_GENERAL
-- Auteur               :       FABRY JF
-- Date                 :       13/04/2010 
-- Libelle              :        
-- Commentaires         :       Procédure d'authentification du sinistre  
--				(Contrôle général à tous les produits)
--                               
-- References           :       
--
-- Arguments            :       @asIdSin               VarChar(7)        	(Val) Identifiant de sinistre
--				@asNom			Varchar(50)		(Val) Nom du souscripteur
--				@asSKU			Varchar(100)		(Val) Numéro de SKU
--                              @asCas                  VarChar ( 40   )        (Val) Cas de Trt : 
--                                                                              CNX = Connexion + contrôle de validité du dossier
--										CTRL = contrôle de validité du dossier
--				@asLangage              VarChar (  3 )          (Val) Code de la Langue utilisé pour les mess de retour ( -LG/CodeCar )
--                              @asRetourMess           VarChar (  2000 )       (Réf) Message à afficher en retour
--
--
-- Retourne             :       Integer                 >0 = OK
--                                                      -1 = NOK
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSIM2_AUTHENT_CTRL_GENERAL' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSIM2_AUTHENT_CTRL_GENERAL
GO


CREATE PROCEDURE sysadm.PS_WEBSIM2_AUTHENT_CTRL_GENERAL
		@asIdSin                VarChar(50),
		@asMdp			VarChar(50),
		@asNom			Varchar(50),
		@asSKU			Varchar(50),
		@asCodeVendeur		Varchar(50),
		@asCodeMagasin		Varchar(50),
		@asCas                  VarChar(50),
		@asIdSession     	varchar(50),
		@asBrowser       	varchar(200),
	        @asLangage              VarChar (3),
		@aiCodeMsg		Integer OUTPUT,
	        @asRetourMess           VarChar ( 2000 ) OUTPUT

AS
DECLARE @iRet		integer
DECLARE @dcIdSin 	Decimal ( 10 ) -- [PI062]
DECLARE @dcCodeEtat     DECIMAL ( 7, 0 )
DECLARE @sCWE           VARCHAR ( 3 )
DECLARE @dcIdGti        DECIMAL ( 7, 0)
DECLARE @dtFinValMdp    DATETIME
DECLARE @sMdpPresent    VARCHAR ( 3 )
DECLARE @sMdpBase	VARCHAR ( 50 )
DECLARE @dtMajle        DATETIME

Set @dcIdSin = Convert ( Decimal ( 10 ),  @asIdSin ) -- [PI062]

Set @iRet=1


/*----------------------------*/
/* Test Existance du sinistre */
/*----------------------------*/
IF      Not Exists ( Select * From sysadm.sinistre s where s.id_sin = @dcIdSin )
        BEGIN
                -- Sinistre inexistant chez SPB
                Select @asRetourMess = sysadm.FN_MESS ( 100, @asLangage )
		Set @aiCodeMsg = 100


		--[TRACE_4] 

		EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			null,		-- @asCasProduit    varchar(50),
			@dcIdSin,	-- @adcIdSin	Decimal (10), -- [PI062]
			@asMdp,		-- @asMdp	    VarChar(50),
			@asNom,		-- @asNom	    Varchar(50),
			@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
			@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
			4,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'CNX',		-- @asEtape         varchar(20),
			100,		-- @aiIdMess        integer
			null,		-- @asValCar	 VarChar(254),
			null		-- @asMajPar	 VarChar ( 4 )


                RETURN ( -1 )
        END

/*----------------------------*/
/* Test existance travail     */
/*----------------------------*/
IF      Exists ( Select * From sysadm.w_queue wq where Convert ( Decimal ( 10), wq.id_sin ) = @dcIdSin ) -- [PI062]
        BEGIN
                -- Dossier en cours de gestion, présence travail.

                Select @asRetourMess = sysadm.FN_MESS ( 107, @asLangage )
		Set @aiCodeMsg = 107

		--[TRACE_5] 
		EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			null,		-- @asCasProduit    varchar(50),
			@dcIdSin,	-- @adcIdSin	Decimal (10), -- [PI062]
			@asMdp,		-- @asMdp	    VarChar(50),
			@asNom,		-- @asNom	    Varchar(50),
			@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
			@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
			5,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'CNX',		-- @asEtape         varchar(20),
			107, 		-- @aiIdMess        integer
			null,		-- @asValCar	 VarChar(254),
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )
        END


/*--------------------------------*/
/* Test etat dossier              */
/*--------------------------------*/
Select @dcCodeEtat = s.cod_etat  From sysadm.sinistre s where s.id_sin = @dcIdSin 
IF      @dcCodeEtat Not in ( 100, 550 ) 
        BEGIN
                -- dossier clos !
                Select @asRetourMess = sysadm.FN_MESS ( 101, @asLangage )
		Set @aiCodeMsg = 101

		--[TRACE_8]
		EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			null,		-- @asCasProduit    varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asMdp,		-- @asMdp	    VarChar(50),
			@asNom,		-- @asNom	    Varchar(50),
			@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
			@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
			8,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'CNX',		-- @asEtape         varchar(20),
			101, 		-- @aiIdMess        integer
			null,		-- @asValCar	 VarChar(254),
			null		-- @asMajPar	 VarChar ( 4 )


                RETURN ( -1 )
        END 


-- Contrôle préparatoire : y a-t-il une cmde Web à dispo pour choix par l'assuré ?
BEGIN
	Set     @sCWE = 'NON'

	Select  @sCWE = 'OUI',
		@dcIdGti = c.id_gti,
		@dtFinValMdp = Convert ( DateTime, sysadm.FN_TRIM ( sysadm.FN_CLE_VAL ( 'DTE_FIN_VAL_MDP_BTQ', IsNull ( c.info_spb_frn_cplt, '' ), ';' ) )) 
	From    sysadm.sinistre s,
		sysadm.commande c
	Where   s.id_sin = @dcIdSin
	and     c.id_sin = s.id_sin
	and     c.id_four = 'WBB'
	and     c.cod_etat = 'CWE'
	and     c.id_seq = (    Select max ( c2.id_seq ) 
				From sysadm.commande c2
				Where c2.id_sin = c.id_sin
				and   c2.id_four = c.id_four
				and   c2.cod_etat = c.cod_etat )
END

IF      @sCWE = 'NON'
        BEGIN
                -- Pas de commande
                Select @asRetourMess = sysadm.FN_MESS ( 102, @asLangage )
		Set @aiCodeMsg = 102


		--[TRACE_9]
		EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			null,		-- @asCasProduit    varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asMdp,		-- @asMdp	    VarChar(50),
			@asNom,		-- @asNom	    Varchar(50),
			@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
			@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
			9,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'CNX',		-- @asEtape         varchar(20),
			102, 		-- @aiIdMess        integer
			null,		-- @asValCar	 VarChar(254),
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )
        END


-- Récupération du mdp, avec dern date de maj
BEGIN
        Select  @sMdpPresent = 'OUI',   
                @sMdpBase = IsNull ( sysadm.FN_TRIM ( d.val_car ), '' ),
                @dtMajle = d.maj_le
        From    sysadm.div_sin d 
        where   d.id_sin = @dcIdSin 
        and     d.nom_zone = 'mdp_net_boutique'
	and     sysadm.FN_TRIM ( d.val_car ) <> ''
END

-- [ERR1]
IF      @sMdpPresent = 'NON' 
        BEGIN
                -- Mode passe absent sur dossier sinistre
                Select @asRetourMess = sysadm.FN_MESS ( 103, @asLangage )
		Set @aiCodeMsg = 103

		--[TRACE_11]
		EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			null,		-- @asCasProduit    varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asMdp,		-- @asMdp	    VarChar(50),
			@asNom,		-- @asNom	    Varchar(50),
			@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
			@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
			11,		-- @adcIdCodeTrc    Decimal(7),
			'ERREUR', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'CNX',		-- @asEtape         varchar(20),
			103, 		-- @aiIdMess        integer
			null,		-- @asValCar	 VarChar(254),
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )
        END 

IF      @sMdpPresent = 'OUI' And @dtFinValMdp <= Getdate()
        BEGIN
                -- Mode passe présent mais durée validité dépassée
                Select @asRetourMess = sysadm.FN_MESS ( 104, @asLangage )
		Set @aiCodeMsg = 104

		--[TRACE_12]
		EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			null,		-- @asCasProduit    varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asMdp,		-- @asMdp	    VarChar(50),
			@asNom,		-- @asNom	    Varchar(50),
			@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
			@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
			12,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'CNX',		-- @asEtape         varchar(20),
			104, 		-- @aiIdMess        integer
			null,		-- @asValCar	 VarChar(254),
			null		-- @asMajPar	 VarChar ( 4 )

                RETURN ( -1 )
        END

-- Test du code d'accès
IF      Upper ( sysadm.FN_TRIM ( @asMdp ) ) <> Upper ( sysadm.FN_TRIM ( @sMdpBase ) )
        BEGIN
                -- Mode passe présent, valide, mais érroné
                Select @asRetourMess = sysadm.FN_MESS ( 105, @asLangage )
		Set @aiCodeMsg = 105

		--[TRACE_13]
		EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			null,		-- @asCasProduit    varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asMdp,		-- @asMdp	    VarChar(50),
			@asNom,		-- @asNom	    Varchar(50),
			@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
			@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
			13,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'CNX',		-- @asEtape         varchar(20),
			105,		-- @aiIdMess        integer
			null,		-- @asValCar	 VarChar(254),
			null		-- @asMajPar	 VarChar ( 4 )


                RETURN ( -1 )
        END 

Return @iRet

Go

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSIM2_VALIDATION_CTRL_GENERAL
-- Auteur               :       FABRY JF
-- Date                 :       13/04/2010 
-- Libelle              :        
-- Commentaires         :       Procédure d'authentification du sinistre  
--				(Contrôle général à tous les produits)
--                               
-- References           :       
--
-- Arguments            :       @asIdSin               VarChar(7)        	(Val) Identifiant de sinistre
--				@asNom			Varchar(50)		(Val) Nom du souscripteur
--				@asSKU			Varchar(100)		(Val) Numéro de SKU
--                              @asCas                  VarChar ( 40   )        (Val) Cas de Trt : 
--                                                                              CNX = Connexion + contrôle de validité du dossier
--										CTRL = contrôle de validité du dossier
--				@asLangage              VarChar (  3 )          (Val) Code de la Langue utilisé pour les mess de retour ( -LG/CodeCar )
--                              @asRetourMess           VarChar (  2000 )       (Réf) Message à afficher en retour
--
--
-- Retourne             :       Integer                 >0 = OK
--                                                      -1 = NOK
--
-------------------------------------------------------------------
-- 22/07/2010 - FPI - [PC321] - SAV Carrefour
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSIM2_VALIDATION_CTRL_GENERAL' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSIM2_VALIDATION_CTRL_GENERAL
GO

CREATE PROCEDURE sysadm.PS_WEBSIM2_VALIDATION_CTRL_GENERAL
		@asIdSin                VarChar(50),
		@aiIdSeq		Integer 	OUTPUT,
		@asMdp			VarChar(50),
		@asNom			Varchar(50),
		@asSKU			Varchar(50),
		@asCodeVendeur		Varchar(50),
		@asCodeMagasin		Varchar(50),
		@asCas                  VarChar(50),
		@asIdSession     	varchar(50),
		@asBrowser       	varchar(200),
	        @asMarqRempl		varchar(50),
	        @asModlRempl		varchar(50),
	        @asNumSerieRempl	varchar(50),
	        @asMtPrixAchatRempl	varchar(50),
	        @asLangage              VarChar (3),
		@aiCodeMsg		Integer OUTPUT,
	        @asRetourMess           VarChar ( 2000 ) OUTPUT

AS

DECLARE @dcIdSin 	Decimal ( 10 ) 
DECLARE @iRet		integer
DECLARE @sCWE           VARCHAR ( 3 )


Set @iRet=1
Set @dcIdSin = Convert ( Decimal ( 10 ),  @asIdSin ) -- [PI062]

If @asCas = 1 
	Begin 
		-- Recherche de la séquence en cours, avec en plus un contrôle sur la validité du dossier (qui ne coûte rien)
		BEGIN
			Set     @sCWE = 'NON'

			Select  @sCWE = 'OUI',
				@aiIdSeq = c.id_seq
			From    sysadm.sinistre s,
				sysadm.commande c
			Where   s.id_sin = @dcIdSin
			and     c.id_sin = s.id_sin
			and     c.id_four in ('WBB')
			and     c.cod_etat = 'CWE'
			and     c.id_seq = (    Select max ( c2.id_seq ) 
						From sysadm.commande c2
						Where c2.id_sin = c.id_sin
						and   c2.id_four = c.id_four
						and   c2.cod_etat = c.cod_etat )
		END

		IF      @sCWE = 'NON'
			BEGIN
				-- Pas de commande
				Select @asRetourMess = sysadm.FN_MESS ( 102, @asLangage )
				Set @aiCodeMsg = 102

				--[TRACE_9]
				EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
					@asIdSession,	-- @asIdSession     varchar(30),
					@asBrowser,	-- @asBrowser       varchar(50),
					null,		-- @asCasProduit    varchar(50),
					@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
					@asMdp,		-- @asMdp	    VarChar(50),
					@asNom,		-- @asNom	    Varchar(50),
					@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
					@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
					9,		-- @adcIdCodeTrc    Decimal(7),
					'INFO_BLOQ', 	-- @asGravite       varchar(10),
					'WEB',		-- @asIdAppli       varchar(5),
					'VALIDATION',	-- @asEtape         varchar(20),
					102, 		-- @aiIdMess        integer
					null,		-- @asValCar	 VarChar(254),
					null		-- @asMajPar	 VarChar ( 4 )

				RETURN ( -1 )
			END


		-- Vérification des données entrante (format/valeur)
		If @iRet > 0 And ( @asMarqRempl is null Or Len ( @asMarqRempl ) <= 0 )
			Begin
				Select @asRetourMess = sysadm.FN_MESS ( 109, @asLangage )
				Set @iRet = -1
				Set @aiCodeMsg = 109

				--[TRACE_24]
				EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
					@asIdSession,	-- @asIdSession     varchar(30),
					@asBrowser,	-- @asBrowser       varchar(50),
					null,		-- @asCasProduit    varchar(50),
					@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
					@asMdp,		-- @asMdp	    VarChar(50),
					@asNom,		-- @asNom	    Varchar(50),
					@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
					@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
					24,		-- @adcIdCodeTrc    Decimal(7),
					'INFO_BLOQ', 	-- @asGravite       varchar(10),
					'WEB',		-- @asIdAppli       varchar(5),
					'VALIDATION',	-- @asEtape         varchar(20),
					109, 		-- @aiIdMess        integer
					null,		-- @asValCar	 VarChar(254),
					null		-- @asMajPar	 VarChar ( 4 )
				
			End

		If @iRet > 0 And ( @asModlRempl	is null Or Len ( @asModlRempl ) <= 0 )
			Begin
				Select @asRetourMess = sysadm.FN_MESS ( 110, @asLangage )
				Set @iRet = -1
				Set @aiCodeMsg = 110

				--[TRACE_24]
				EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
					@asIdSession,	-- @asIdSession     varchar(30),
					@asBrowser,	-- @asBrowser       varchar(50),
					null,		-- @asCasProduit    varchar(50),
					@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
					@asMdp,		-- @asMdp	    VarChar(50),
					@asNom,		-- @asNom	    Varchar(50),
					@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
					@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
					24,		-- @adcIdCodeTrc    Decimal(7),
					'INFO_BLOQ', 	-- @asGravite       varchar(10),
					'WEB',		-- @asIdAppli       varchar(5),
					'VALIDATION',	-- @asEtape         varchar(20),
					110, 		-- @aiIdMess        integer
					null,		-- @asValCar	 VarChar(254),
					null		-- @asMajPar	 VarChar ( 4 )				
			End

		If @iRet > 0 And ( @asNumSerieRempl is null Or Len ( @asNumSerieRempl ) <= 0 )
			Begin
				Select @asRetourMess = sysadm.FN_MESS ( 111, @asLangage )
				Set @iRet = -1
				Set @aiCodeMsg = 111
				
				--[TRACE_24]
				EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
					@asIdSession,	-- @asIdSession     varchar(30),
					@asBrowser,	-- @asBrowser       varchar(50),
					null,		-- @asCasProduit    varchar(50),
					@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
					@asMdp,		-- @asMdp	    VarChar(50),
					@asNom,		-- @asNom	    Varchar(50),
					@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
					@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
					24,		-- @adcIdCodeTrc    Decimal(7),
					'INFO_BLOQ', 	-- @asGravite       varchar(10),
					'WEB',		-- @asIdAppli       varchar(5),
					'VALIDATION',	-- @asEtape         varchar(20),
					111, 		-- @aiIdMess        integer
					null,		-- @asValCar	 VarChar(254),
					null		-- @asMajPar	 VarChar ( 4 )				
			End

		If @iRet > 0 And ( IsNumeric ( @asMtPrixAchatRempl ) = 0 )
			Begin
				Select @asRetourMess = sysadm.FN_MESS ( 112, @asLangage )
				Set @iRet = -1
				Set @aiCodeMsg = 112
				
				--[TRACE_24]
				EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
					@asIdSession,	-- @asIdSession     varchar(30),
					@asBrowser,	-- @asBrowser       varchar(50),
					null,		-- @asCasProduit    varchar(50),	
					@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
					@asMdp,		-- @asMdp	    VarChar(50),
					@asNom,		-- @asNom	    Varchar(50),
					@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
					@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
					24,		-- @adcIdCodeTrc    Decimal(7),
					'INFO_BLOQ', 	-- @asGravite       varchar(10),
					'WEB',		-- @asIdAppli       varchar(5),
					'VALIDATION',	-- @asEtape         varchar(20),
					112, 		-- @aiIdMess        integer
					null,		-- @asValCar	 VarChar(254),				
					null		-- @asMajPar	 VarChar ( 4 )				
			End


	End 
	
If @asCas = 2  -- [PC321] - SAV Carrefour
	Begin 
		-- Recherche de la séquence en cours, avec en plus un contrôle sur la validité du dossier (qui ne coûte rien)
		BEGIN
			Set     @sCWE = 'NON'

			Select  @sCWE = 'OUI',
				@aiIdSeq = c.id_seq
			From    sysadm.sinistre s,
				sysadm.commande c
			Where   s.id_sin = @dcIdSin
			and     c.id_sin = s.id_sin
			and     c.id_four in ('SCR')
			and     c.cod_etat = 'ECT'
			and     c.id_seq = (    Select max ( c2.id_seq ) 
						From sysadm.commande c2
						Where c2.id_sin = c.id_sin
						and   c2.id_four = c.id_four
						and   c2.cod_etat = c.cod_etat )
		END

		IF      @sCWE = 'NON'
			BEGIN
				-- Pas de commande
				Select @asRetourMess = sysadm.FN_MESS ( 102, @asLangage )
				Set @aiCodeMsg = 102

				--[TRACE_9]
				EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
					@asIdSession,	-- @asIdSession     varchar(30),
					@asBrowser,	-- @asBrowser       varchar(50),
					null,		-- @asCasProduit    varchar(50),
					@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
					@asMdp,		-- @asMdp	    VarChar(50),
					@asNom,		-- @asNom	    Varchar(50),
					@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
					@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
					9,		-- @adcIdCodeTrc    Decimal(7),
					'INFO_BLOQ', 	-- @asGravite       varchar(10),
					'WEB',		-- @asIdAppli       varchar(5),
					'VALIDATION',	-- @asEtape         varchar(20),
					102, 		-- @aiIdMess        integer
					null,		-- @asValCar	 VarChar(254),
					null		-- @asMajPar	 VarChar ( 4 )

				RETURN ( -1 )
			END


		

	End 
Return @iRet
	
Go

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSIM2_MAJ_CMDE
-- Auteur               :       F. Pinon
-- Date                 :       19/07/2010 
-- Libelle              :        
-- Commentaires         :       Procédure de mise à jour de commande
--                               
-- References           :       
--
-- Arguments            :       @asIdSin               VarChar(7)        	(Val) Identifiant de sinistre
--				@asNom			Varchar(50)		(Val) Nom du souscripteur
--				@asSKU			Varchar(100)		(Val) Numéro de SKU
--                              @asCas                  VarChar ( 40   )        (Val) Cas de Trt : 
--                                                                              CNX = Connexion + contrôle de validité du dossier
--										CTRL = contrôle de validité du dossier
--				@asLangage              VarChar (  3 )          (Val) Code de la Langue utilisé pour les mess de retour ( -LG/CodeCar )
--                              @asRetourMess           VarChar (  2000 )       (Réf) Message à afficher en retour
--
--
-- Retourne             :       Integer                 >0 = OK
--                                                      -1 = NOK
--
-------------------------------------------------------------------
-- FPI - 14/10/2016 - [PC151255] Ajout de zones
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSIM2_MAJ_CMDE' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSIM2_MAJ_CMDE
GO


CREATE PROCEDURE sysadm.PS_WEBSIM2_MAJ_CMDE
		@asIdSin                VarChar(50),
		@aiIdSeq		Integer ,
		@asCommentFrn1	Varchar(255),
		@asCommentFrn2	Varchar(255),
		@asVarSeria		VarChar(500),
		@asLangage              VarChar (3),
		@aiCodeMsg		Integer OUTPUT,
	        @asRetourMess           VarChar ( 2000 ) OUTPUT
As
Declare	@sInfoFrnSpbCplt  varchar (1600)
Declare @sInfoSpbFrnCplt varchar (800)
Declare @iRech1			Integer 	
Declare @iRech2			Integer 	
Declare @sCle1			VarChar ( 50 ) 	
Declare @sVal1			VarChar ( 300 ) 	
Declare @iCas			Integer
DECLARE @dcIdSin 	Decimal ( 10 ) -- [PI062]
Declare @sIdProcess	Varchar(5)
Declare @dcMtDevis	Decimal(11,2)
Declare @dtEnvCli	Datetime

Set @dcIdSin = Convert ( Decimal ( 10 ),  @asIdSin ) -- [PI062]
select @sIdProcess=sysadm.FN_CLE_VAL('ETAT',@asVarSeria,';')

Select  @sInfoFrnSpbCplt = rtrim ( c.info_frn_spb_cplt ), 
	@sInfoSpbFrnCplt = rtrim(c.info_spb_frn_cplt),
	@sIdProcess=case when @sIdProcess='' then convert(varchar(5), info_spb_frn) 
		else @sIdProcess end
From	sysadm.commande c,
	sysadm.sinistre s
Where   c.id_sin = @dcIdSin
And 	c.id_seq = @aiIdSeq
And     s.id_sin = c.id_sin

If @sInfoSpbFrnCplt is null Set @sInfoSpbFrnCplt = ''
If @sInfoFrnSpbCplt is null Set @sInfoFrnSpbCplt = '' 

Set @iRech1 = 1 
Set @iRech2 = CharIndex ( '=', @asVarSeria, @iRech1 ) -- On recherche la clé (qu'on en connait pas à ce moment)
While ( @iRech1 > 0 And @iRech2 > 0 )
 Begin
	Set @iCas = 1 -- Par défaut, on insère dans @sInfoSpbFrnCplt
	
	-- On isole la clé
	Set @sCle1 = Upper( Substring ( @asVarSeria, @iRech1, @iRech2 - @iRech1 ))
	
	-- On en recherche la valeur associée
	Set @sVal1 = sysadm.FN_CLE_VAL ( @sCle1, @asVarSeria, ';')
	
	-- Sur quel champ l'affecter
	If CharIndex ( @sCle1 + '=', @sInfoSpbFrnCplt) <= 0
	Begin
		If CharIndex ( @sCle1 + '=', @sInfoFrnSpbCplt) > 0 Set @iCas = 2
		Else
		Begin
			If Len(@sInfoSpbFrnCplt) + Len(@sCle1) + Len(@sVal1) + 2 > 800 Set @iCas = 2
		End 
	End
	 
	If @iCas=1 
	Begin
		Set @sInfoSpbFrnCplt = sysadm.FN_CLE_VAL_E ( @sCle1, @sVal1, @sInfoSpbFrnCplt, ';')
	End
	Else
	Begin
		Set @sInfoFrnSpbCplt = sysadm.FN_CLE_VAL_E ( @sCle1, @sVal1, @sInfoFrnSpbCplt, ';')
	End
		
	-- On passe à la clé suivante
	Set @iRech1 = @iRech2 + 1
	Set @iRech1 = CharIndex ( ';', @asVarSeria, @iRech1 ) 
	If @iRech1 > 0
	  Begin
 	   Set @iRech1 = @iRech1 + 1
	   Set @iRech2 = CharIndex ( '=', @asVarSeria, @iRech1 ) -- On recherche la prochaine clé (qu'on en connait pas à ce moment)
	  End
 End
 
 If CharIndex ('MT_REP', @asVarSeria) > 0
 Begin
	Set @sVal1=sysadm.FN_CLE_VAL('MT_REP',@asVarSeria,';')
	If isNumeric(@sVal1) = 1
	Begin
	  Set @dcMtDevis=convert(decimal(11,2), @sVal1)
	  
	  Update sysadm.commande
	  set mt_devis=@dcMtDevis,
		maj_le=getdate()
	  Where id_sin = @dcIdSin
	    And id_seq = @aiIdSeq
	
	Update sysadm.w_commande
	  set mt_devis=@dcMtDevis,
		maj_le=getdate()
	  Where id_sin = @dcIdSin
	    And id_seq = @aiIdSeq
	End
End

If CharIndex ('DTE_APP_DISPO', @asVarSeria) > 0
 Begin
	Set @sVal1=sysadm.FN_CLE_VAL('DTE_APP_DISPO',@asVarSeria,';')
	If isDate(@sVal1) = 1
	Begin
	  Set @dtEnvCli=convert(datetime, @sVal1)
	  
	  Update sysadm.commande
	  set dte_env_cli=@dtEnvCli,
		maj_le=getdate()
	  Where id_sin = @dcIdSin
	    And id_seq = @aiIdSeq
	
	Update sysadm.w_commande
	  set dte_env_cli=@dtEnvCli,
		maj_le=getdate()
	  Where id_sin = @dcIdSin
	    And id_seq = @aiIdSeq
	End
End
	
-- [PC151255]
If CharIndex ('DTE_RCP_APP', @asVarSeria) > 0
 Begin
	Set @sVal1=sysadm.FN_CLE_VAL('DTE_RCP_APP',@asVarSeria,';')
	If isDate(@sVal1) = 1
	Begin
	  Set @dtEnvCli=convert(datetime, @sVal1,103)
	  
	  Update sysadm.commande
	  set dte_rcp_frn=@dtEnvCli,
		maj_le=getdate()
	  Where id_sin = @dcIdSin
	    And id_seq = @aiIdSeq
	
	Update sysadm.w_commande
	  set dte_rcp_frn=@dtEnvCli,
		maj_le=getdate()
	  Where id_sin = @dcIdSin
	    And id_seq = @aiIdSeq
	End
End

 Update sysadm.commande
 set info_frn_spb_cplt = @sInfoFrnSpbCplt, 
	info_spb_frn_cplt = @sInfoSpbFrnCplt,
	probleme=isnull(@asCommentFrn1,probleme),
	comment_frn=@asCommentFrn2,
	info_spb_frn=convert(integer,@sIdProcess),
	maj_le=getdate()
 Where   id_sin = @dcIdSin
 And 	id_seq = @aiIdSeq
 
 Update sysadm.w_commande
 set info_frn_spb_cplt = @sInfoFrnSpbCplt, 
	info_spb_frn_cplt = @sInfoSpbFrnCplt,
	probleme=isnull(@asCommentFrn1,probleme),
	comment_frn=@asCommentFrn2,
	info_spb_frn=convert(integer,@sIdProcess),
	maj_le=getdate()
 Where   id_sin = @dcIdSin
 And 	id_seq = @aiIdSeq
 
 Return 1
Go

grant execute on sysadm.PS_WEBSIM2_MAJ_CMDE to rolebddsinistres
Go