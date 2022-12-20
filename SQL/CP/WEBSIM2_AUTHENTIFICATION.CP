-------------------------------------------------------------------
--
-- Fichier              :       WEBSIM2_AUTHENTIFICATION.CP
-- Auteur               :       FPI
-- Date                 :       04/2010
--
-- Commentaires         :       Gestion de l'authentification depuis le sitre intranet Simpa2 Web
--				Ces procédures ne sont pas visibles depuis les Web Services du site.
--				[WEBSIM2].[FRANCE]
-------------------------------------------------------------------
-- PS_WEBSIM2_AUTHENT_FNAC_SUISSE	JFF 13/04/2010 Procédure d'authentification pour le cas produit 'FNAC_SUISSE'
-- PS_WEBSIM2_AUTHENT_CARREFOUR_CV_SAV 	FPI 17/09/2010 Procédure d'authentification pour le cas produit 'CARREFOUR_CASSE_VOL_SAV'
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSIM2_AUTHENT_EXP5_FRANCE
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
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSIM2_AUTHENT_EXP5_FRANCE' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSIM2_AUTHENT_EXP5_FRANCE
GO


CREATE PROCEDURE sysadm.PS_WEBSIM2_AUTHENT_EXP5_FRANCE
	@asIdSin                VarChar(50),
	@asMdp			Varchar(50),
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
Declare @iRet	integer
DECLARE @dcIdSin 	Decimal ( 10 ) -- [PI062]
Declare @sCodeMagBase	VarChar ( 50 )

Set @dcIdSin = Convert ( Decimal ( 10 ),  @asIdSin ) -- [PI062]

Set @iRet=-1

Exec @iRet=sysadm.PS_WEBSIM2_AUTHENT_CTRL_GENERAL
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

If @iRet > 0 
	Begin
		Select 	@sCodeMagBase = rTrim ( Convert ( VarChar ( 50 ), s.id_orian_boutique ) )
		From	sysadm.sinistre s
		Where   s.id_sin = @dcIdSin
		
		If @@RowCount <> 1 
			Begin 
				Set @iRet = -1
				Select @asRetourMess = sysadm.FN_MESS ( 108, @asLangage )
				Set @aiCodeMsg = 108

				--[TRACE_25]
				EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
					@asIdSession,	-- @asIdSession     varchar(30),
					@asBrowser,	-- @asBrowser       varchar(50),
					null,		-- @asCasProduit    varchar(50),
					@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
					@asNom,		-- @asMdp	    VarChar(50),
					@asNom,		-- @asNom	    Varchar(50),
					@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
					@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
					25,		-- @adcIdCodeTrc    Decimal(7),
					'INFO_BLOQ', 	-- @asGravite       varchar(10),
					'WEB',		-- @asIdAppli       varchar(5),
					'LECT_DONNEES',	-- @asEtape         varchar(20),
					108, 		-- @aiIdMess        integer
					null,		-- @asValCar	 VarChar(254),
					null		-- @asMajPar	 VarChar ( 4 )		
			End 		

	If @iRet > 0 
		Begin

			IF      Upper ( sysadm.FN_TRIM ( @asCodeMagasin ) ) <> Upper ( sysadm.FN_TRIM ( @sCodeMagBase ) )
				BEGIN
					-- Mode passe présent, valide, mais érroné
					Select @asRetourMess = sysadm.FN_MESS ( 115, @asLangage )
					Set @aiCodeMsg = 115

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
						28,		-- @adcIdCodeTrc    Decimal(7),
						'INFO_BLOQ', 	-- @asGravite       varchar(10),
						'WEB',		-- @asIdAppli       varchar(5),
						'CNX',		-- @asEtape         varchar(20),
						115,		-- @aiIdMess        integer
						null,		-- @asValCar	 VarChar(254),
						null		-- @asMajPar	 VarChar ( 4 )


					RETURN ( -1 )
				END 

			
		End
	
	End 

Return @iRet

Go

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSIM2_AUTHENT_CARREFOUR_CV_SAV
-- Auteur               :       PINON Fabien	
-- Date                 :       19/07/2010 
-- Libelle              :        
-- Commentaires         :       Procédure d'authentification du sinistre et 
--				de vérification de la validité de l'échange
--                               
-- References           :       [PC321]
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
-- FPI - 13/10/2016 - [PC151255] - ajout des process 28xx
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSIM2_AUTHENT_CARREFOUR_CV_SAV' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSIM2_AUTHENT_CARREFOUR_CV_SAV
GO


CREATE PROCEDURE [sysadm].[PS_WEBSIM2_AUTHENT_CARREFOUR_CV_SAV]
	@asIdSin                VarChar(50),
	@asMdp			Varchar(50),
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
Declare @iRet	integer
DECLARE @dcIdSin 	Decimal ( 10 ) -- [PI062]
Declare @sCodeMagBase	VarChar ( 50 )
DECLARE @dcCodeEtat     DECIMAL ( 7, 0 )
DECLARE @sCWE           VARCHAR ( 3 )
DECLARE @dcIdGti        DECIMAL ( 7, 0)
DECLARE @dtFinValMdp    DATETIME
DECLARE @sMdpPresent    VARCHAR ( 3 )
DECLARE @sMdpBase	VARCHAR ( 50 )
DECLARE @dtMajle        DATETIME
Declare @sSiteSAV	varchar(100)=''

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

Select @sSiteSAV = sysadm.FN_CLE_VAL('SITE_SAV',isnull(val_car,''),';')
from sysadm.sinistre s
	inner join sysadm.det_pro d on d.id_prod=s.id_prod
where s.id_sin = @dcIdSin 
	and d.id_code_dp=141

if rtrim(@sSiteSAV)='' Set @sSiteSAV='CV'

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
IF      @dcCodeEtat Not in ( 100, 550 )  and @sSiteSAV='CV'
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
	and     c.id_four = 'SCR'
	and     c.cod_etat = 'ECT'
	and     c.id_seq = (    Select max ( c2.id_seq ) 
				From sysadm.commande c2
				Where c2.id_sin = c.id_sin
				and   c2.id_four = c.id_four
				and   c2.cod_etat = c.cod_etat )
END

-- [PC151255]
If @sCWE = 'NON'
 BEGIN
	-- on bypass le contrôle d'après pour les commandes SCR / S2MI
	Select  @sCWE = 'OUI'
	From    sysadm.sinistre s,
		sysadm.commande c
	Where   s.id_sin = @dcIdSin
	and     c.id_sin = s.id_sin
	and     c.id_four = 'SCR'
	and     c.cod_etat = 'RFO'
	and		c.info_spb_frn between 2800 and 2899
End

-- [PC151255]
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


If @iRet > 0
Begin
	Select 	@sCodeMagBase = rTrim ( Convert ( VarChar ( 50 ), s.id_orian_boutique ) )
	From	sysadm.sinistre s
	Where   s.id_sin = @dcIdSin

	If @@RowCount <> 1 
	Begin 
		Set @iRet = -1
		Select @asRetourMess = sysadm.FN_MESS ( 108, @asLangage )
		Set @aiCodeMsg = 108

		--[TRACE_25]
		EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			null,		-- @asCasProduit    varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10),-- [PI062]
			@asNom,		-- @asMdp	    VarChar(50),
			@asNom,		-- @asNom	    Varchar(50),
			@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
			@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
			25,		-- @adcIdCodeTrc    Decimal(7),
			'INFO_BLOQ', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'LECT_DONNEES',	-- @asEtape         varchar(20),
			108, 		-- @aiIdMess        integer
			null,		-- @asValCar	 VarChar(254),
			null		-- @asMajPar	 VarChar ( 4 )		
	End 		
End

Return @iRet

Go

grant execute on sysadm.PS_WEBSIM2_AUTHENT_CARREFOUR_CV_SAV to rolebddsinistres
Go
