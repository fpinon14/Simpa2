-------------------------------------------------------------------
--
-- Fichier              :       WEBSIM2_VALIDATION.CP
-- Auteur               :       FPI
-- Date                 :       04/2010
--
-- Commentaires         :       Gestion de validation de l'échange depuis le sitre intranet Simpa2 Web
--				Ces procédures ne sont pas visibles depuis les Web Services du site.
--				[WEBSIM2].[FRANCE]
-------------------------------------------------------------------
-- PS_WEBSIM2_VALIDATION_FNAC_SUISSE  	JFF 13/04/2010 Procédure de validation de l'échange pour le cas produit FNAC Suisse
-------------------------------------------------------------------

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSIM2_VALIDATION_EXP5_FRANCE
-- Auteur               :       FABRY JF
-- Date                 :       13/04/2010 
-- Libelle              :        
-- Commentaires         :       Procédure de validation de l'échange pour le cas produit FNAC Suisse
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
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSIM2_VALIDATION_EXP5_FRANCE' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSIM2_VALIDATION_EXP5_FRANCE
GO


CREATE PROCEDURE sysadm.PS_WEBSIM2_VALIDATION_EXP5_FRANCE
	@asIdSin                VarChar(50),
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
Declare @iRet	integer
Declare @iIdSeq integer
DECLARE @dcIdSin 	Decimal ( 10 ) -- [PI062]


Set @iIdSeq = -1
Set @iRet=1
Set @dcIdSin = Convert ( Decimal ( 10),  @asIdSin ) -- [PI062]

Exec @iRet = sysadm.PS_WEBSIM2_VALIDATION_CTRL_GENERAL
		@asIdSin,
		@iIdSeq	OUTPUT,
		@asNom,
		@asNom,
		@asSKU,
		@asCodeVendeur,
		@asCodeMagasin,
		1,
		@asIdSession,
		@asBrowser,
	        @asMarqRempl,
	        @asModlRempl,
	        @asNumSerieRempl,
	        @asMtPrixAchatRempl,
	        @asLangage,
		@aiCodeMsg OUTPUT,
	        @asRetourMess OUTPUT

If @iRet > 0 
	Begin 


		If @iRet > 0 And ( @asCodeMagasin is null Or Len ( @asCodeMagasin ) <= 0 )
			Begin
				Select @asRetourMess = sysadm.FN_MESS ( 113, @asLangage )
				Set @iRet = -1
				Set @aiCodeMsg = 113

				-- [TRACE_15]
				EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
					@asIdSession,	-- @asIdSession     varchar(30),
					@asBrowser,	-- @asBrowser       varchar(50),
					null,		-- @asCasProduit    varchar(50),
					@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
					@asNom,		--	VarChar(50),
					@asNom,		--	Varchar(50),
					@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
					@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
					15,		-- @adcIdCodeTrc    Decimal(7),
					'ERREUR', 	-- @asGravite       varchar(10),
					'WEB',		-- @asIdAppli       varchar(5),
					'VALIDATION',	-- @asEtape         varchar(20),
					113,		-- @aiIdMess        integer
					null,		-- @asValCar	 VarChar(254),
					null		-- @asMajPar	 VarChar ( 4 )
					
			End

		If @iRet > 0 And ( @asCodeVendeur is null Or Len ( @asCodeVendeur ) <= 0 )
			Begin
				Select @asRetourMess = sysadm.FN_MESS ( 114 , @asLangage )
				Set @iRet = -1
				Set @aiCodeMsg = 114
				
				-- [TRACE_15]
				EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
					@asIdSession,	-- @asIdSession     varchar(30),
					@asBrowser,	-- @asBrowser       varchar(50),
					null,		-- @asCasProduit    varchar(50),
					@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
					@asNom,		--	VarChar(50),
					@asNom,		--	Varchar(50),
					@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
					@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
					15,		-- @adcIdCodeTrc    Decimal(7),
					'ERREUR', 	-- @asGravite       varchar(10),
					'WEB',		-- @asIdAppli       varchar(5),
					'VALIDATION',	-- @asEtape         varchar(20),
					114,		-- @aiIdMess        integer
					null,		-- @asValCar	 VarChar(254),
					null		-- @asMajPar	 VarChar ( 4 )				
			End
	End 

If @iRet = 1 
	Begin
		Update 	sysadm.commande
		Set
			cod_etat	= 'RPC',
			id_marq_art	= Left ( @asMarqRempl, 35 ),
			id_modl_art	= Left ( @asModlRempl, 35 ),
			id_serie_nouv   = Left ( @asNumSerieRempl, 20),
			mt_ttc_cmde	= Round ( Convert ( Decimal (11,2), @asMtPrixAchatRempl), 2 ),
			info_spb_frn_cplt = 
				  sysadm.FN_CLE_VAL_E ( 'DTE_FIN_VAL_MDP_BTQ', '01/01/1980', rtrim ( IsNull ( info_spb_frn_cplt, '' ) ) , ';'),
			info_frn_spb_cplt =  
				  sysadm.FN_CLE_VAL_E ( 'CODE_VENDEUR', @asCodeVendeur, 
				   sysadm.FN_CLE_VAL_E ( 'CODE_MAGASIN', @asCodeMagasin, rtrim ( IsNull ( info_frn_spb_cplt, '' ) ) , ';')
				  , ';'),
			id_orian_marque = 1  -- Repère cmde Web

		From 	sysadm.commande c

		Where  	c.id_sin = @dcIdSin
		And	c.id_seq = @iIdSeq
		And	c.id_four = 'WBB'
		And     c.cod_etat = 'CWE'


		If	@@RowCount <> 1
			Begin
				Select @asRetourMess = sysadm.FN_MESS ( 102, @asLangage )
				Set @iRet = -1
				Set @aiCodeMsg = 102

				-- [TRACE_15]
				EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
					@asIdSession,	-- @asIdSession     varchar(30),
					@asBrowser,	-- @asBrowser       varchar(50),
					null,		-- @asCasProduit    varchar(50),
					@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
					@asNom,		--	VarChar(50),
					@asNom,		--	Varchar(50),
					@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
					@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
					15,		-- @adcIdCodeTrc    Decimal(7),
					'ERREUR', 	-- @asGravite       varchar(10),
					'WEB',		-- @asIdAppli       varchar(5),
					'VALIDATION',	-- @asEtape         varchar(20),
					102,		-- @aiIdMess        integer
					null,		-- @asValCar	 VarChar(254),
					null		-- @asMajPar	 VarChar ( 4 )				
			End 
		
		If @iRet = 1 
			Begin 		
				Update 	sysadm.div_sin
				Set	val_car = null
				Where  	id_sin = @dcIdSin
				And	nom_zone = 'mdp_net_boutique'			

				If	@@RowCount <> 1
					Begin
						Select @asRetourMess = sysadm.FN_MESS ( 102, @asLangage )
						Set @iRet = -1
						Set @aiCodeMsg = 102
						
						-- [TRACE_15]
						EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
							@asIdSession,	-- @asIdSession     varchar(30),
							@asBrowser,	-- @asBrowser       varchar(50),
							null,		-- @asCasProduit    varchar(50),
							@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
							@asNom,		--	VarChar(50),
							@asNom,		--	Varchar(50),
							@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
							@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
							15,		-- @adcIdCodeTrc    Decimal(7),
							'ERREUR', 	-- @asGravite       varchar(10),
							'WEB',		-- @asIdAppli       varchar(5),
							'VALIDATION',	-- @asEtape         varchar(20),
							102,		-- @aiIdMess        integer
							null,		-- @asValCar	 VarChar(254),
							null		-- @asMajPar	 VarChar ( 4 )						
					End 				
			End 
		
	End 
	
If @iRet = 1 	
	Begin
		If 	Exists ( 	Select 	*
					From 	sysadm.w_commande
					Where	id_sin = @dcIdSin
					And 	id_seq = @iIdSeq )
			Begin    		
				Update 	sysadm.w_commande
				Set	
					cod_etat	= 'RPC',
					id_marq_art	= Left ( @asMarqRempl, 35 ),
					id_modl_art	= Left ( @asModlRempl, 35 ),
					id_serie_nouv   = Left ( @asNumSerieRempl, 20),
					mt_ttc_cmde	= Round ( Convert ( Decimal (11,2), @asMtPrixAchatRempl) , 2 ),
					info_spb_frn_cplt = 
						sysadm.FN_CLE_VAL_E ( 'DTE_FIN_VAL_MDP_BTQ', '01/01/1980', rtrim ( IsNull ( info_spb_frn_cplt, '' )) , ';'),
					info_frn_spb_cplt = 
						 sysadm.FN_CLE_VAL_E ( 'CODE_VENDEUR', @asCodeVendeur, 
						  sysadm.FN_CLE_VAL_E ( 'CODE_MAGASIN', @asCodeMagasin, rtrim ( IsNull ( info_frn_spb_cplt, '' ) ) , ';')
						 , ';'),
					id_orian_marque = 1  -- Repère cmde Web
				Where  	id_sin = @dcIdSin
				And	id_seq = @iIdSeq
				And	id_four = 'WBB'
				And     cod_etat = 'CWE'

				If	@@RowCount <> 1
					Begin
						Select @asRetourMess = sysadm.FN_MESS ( 102, @asLangage )
						Set @iRet = -1
						Set @aiCodeMsg = 102
						
						-- [TRACE_15]
						EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
							@asIdSession,	-- @asIdSession     varchar(30),
							@asBrowser,	-- @asBrowser       varchar(50),
							null,		-- @asCasProduit    varchar(50),
							@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
							@asNom,		--	VarChar(50),
							@asNom,		--	Varchar(50),
							@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
							@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
							15,		-- @adcIdCodeTrc    Decimal(7),
							'ERREUR', 	-- @asGravite       varchar(10),
							'WEB',		-- @asIdAppli       varchar(5),
							'VALIDATION',	-- @asEtape         varchar(20),
							102,		-- @aiIdMess        integer
							null,		-- @asValCar	 VarChar(254),
							null		-- @asMajPar	 VarChar ( 4 )						
					End 

				If @iRet = 1 
					Begin 		
						Update 	sysadm.w_div_sin
						Set	val_car = null
						Where  	id_sin = @dcIdSin
						And	nom_zone = 'mdp_net_boutique'			

						If	@@RowCount <> 1
							Begin
								Select @asRetourMess = sysadm.FN_MESS ( 102, @asLangage )
								Set @iRet = -1
								Set @aiCodeMsg = 102
								
								-- [TRACE_15]
								EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
									@asIdSession,	-- @asIdSession     varchar(30),
									@asBrowser,	-- @asBrowser       varchar(50),
									null,		-- @asCasProduit    varchar(50),
									@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
									@asNom,		--	VarChar(50),
									@asNom,		--	Varchar(50),
									@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
									@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
									15,		-- @adcIdCodeTrc    Decimal(7),
									'ERREUR', 	-- @asGravite       varchar(10),
									'WEB',		-- @asIdAppli       varchar(5),
									'VALIDATION',	-- @asEtape         varchar(20),
									102,		-- @aiIdMess        integer
									null,		-- @asValCar	 VarChar(254),
									null		-- @asMajPar	 VarChar ( 4 )								
							End 				
					End 

			End 
	End
	

Return @iRet
Go

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSIM2_VALIDATION_SAV_CARR
-- Auteur               :       Pinon Fabien
-- Date                 :       19/07/2010 
-- Libelle              :        
-- Commentaires         :       Procédure de validation de l'échange pour le cas produit CARREFOUR_CASSE_VOL_SAV
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
-- FPI - 14/12/2011 - maj de w_commande & commande pour éviter un "entre 2 états"
-- FPI - 03/03/2016 - [VDOC20044] forçage du maj_par à PRS pour la création du travail
-- FPI - 13/10/2016 - [PC151255] - ajout des process 28xx
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSIM2_VALIDATION_SAV_CARR' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSIM2_VALIDATION_SAV_CARR
GO

CREATE PROCEDURE sysadm.PS_WEBSIM2_VALIDATION_SAV_CARR
	@asIdSin                VarChar(50),
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
	@asCommentFrn1	Varchar(255),
	@asCommentFrn2	Varchar(255),
	@asVarSeria		VarChar(500),
	@asLangage              VarChar (3),
	@aiCodeMsg		Integer OUTPUT,
        @asRetourMess           VarChar ( 2000 ) OUTPUT

AS
Declare @iRet	integer
Declare @iIdSeq integer
DECLARE @dcIdSin 	Decimal ( 10 ) -- [PI062]
Declare @sIdProcess	varchar(50)
Declare @sErr 	  Varchar(60)
Declare @sMajPar	Varchar(4)
Declare @sMess	VarChar ( 2000 )
Declare @iIdCt	integer		

Set @iIdSeq = -1
Set @iRet=1
Set @asRetourMess = 'OK'

Set @dcIdSin = Convert ( Decimal ( 10 ),  @asIdSin ) -- [PI062]

If @asMtPrixAchatRempl is not null Set @asMtPrixAchatRempl=Replace(@asMtPrixAchatRempl,',','.')

if @asMarqRempl is null Set @asMarqRempl='AUCUNE MARQUE SPECIFIEE'
if @asModlRempl is null Set @asModlRempl='AUCUN MODELE SPECIFIE'

Exec @iRet = sysadm.PS_WEBSIM2_VALIDATION_CTRL_GENERAL
		@asIdSin,
		@iIdSeq	OUTPUT,
		@asNom,
		@asNom,
		@asSKU,
		@asCodeVendeur,
		@asCodeMagasin,
		2,
		@asIdSession,
		@asBrowser,
	        @asMarqRempl,
	        @asModlRempl,
	        @asNumSerieRempl,
	        @asMtPrixAchatRempl,
	        @asLangage,
		@aiCodeMsg OUTPUT,
	        @asRetourMess OUTPUT

select @sIdProcess=sysadm.FN_CLE_VAL('ETAT',@asVarSeria,';')

if @sIdProcess in ('2821','2822')
Begin
	Select top 1 @iRet=1,
		@aiCodeMsg=NULL,
		@asRetourMess='OK',
		@iIdSeq=c.id_seq
	From sysadm.commande c
	Where   c.id_sin = @dcIdSin
	and     c.id_four = 'SCR'
	and     c.cod_etat = 'RFO'
	and		c.info_spb_frn between 2800 and 2899
	Order by c.id_seq
End

If @iRet > 0 
	Begin 


		If @iRet > 0 And ( @asCodeMagasin is null Or Len ( @asCodeMagasin ) <= 0 )
			Begin
				Select @asRetourMess = sysadm.FN_MESS ( 113, @asLangage )
				Set @iRet = -1
				Set @aiCodeMsg = 113

				-- [TRACE_15]
				EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
					@asIdSession,	-- @asIdSession     varchar(30),
					@asBrowser,	-- @asBrowser       varchar(50),
					null,		-- @asCasProduit    varchar(50),
					@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
					@asNom,		--	VarChar(50),
					@asNom,		--	Varchar(50),
					@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
					@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
					15,		-- @adcIdCodeTrc    Decimal(7),
					'ERREUR', 	-- @asGravite       varchar(10),
					'WEB',		-- @asIdAppli       varchar(5),
					'VALIDATION',	-- @asEtape         varchar(20),
					113,		-- @aiIdMess        integer
					null,		-- @asValCar	 VarChar(254),
					null		-- @asMajPar	 VarChar ( 4 )
					
			End

		If @iRet > 0 And ( @asCodeVendeur is null Or Len ( @asCodeVendeur ) <= 0 )
			Begin
				Select @asRetourMess = sysadm.FN_MESS ( 114 , @asLangage )
				Set @iRet = -1
				Set @aiCodeMsg = 114
				
				-- [TRACE_15]
				EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
					@asIdSession,	-- @asIdSession     varchar(30),
					@asBrowser,	-- @asBrowser       varchar(50),
					null,		-- @asCasProduit    varchar(50),
					@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
					@asNom,		--	VarChar(50),
					@asNom,		--	Varchar(50),
					@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
					@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
					15,		-- @adcIdCodeTrc    Decimal(7),
					'ERREUR', 	-- @asGravite       varchar(10),
					'WEB',		-- @asIdAppli       varchar(5),
					'VALIDATION',	-- @asEtape         varchar(20),
					114,		-- @aiIdMess        integer
					null,		-- @asValCar	 VarChar(254),
					null		-- @asMajPar	 VarChar ( 4 )				
			End
	End 

-- Mise à jour de la commande
If @iRet > 0 
Begin
exec @iRet=sysadm.PS_WEBSIM2_MAJ_CMDE @asIdSin , @iIdSeq,
		@asCommentFrn1,	@asCommentFrn2,	@asVarSeria,
		@asLangage, @aiCodeMsg OUTPUT, @asRetourMess OUTPUT
End

-- Création d'un travail
If @iRet = 1  and @sIdProcess in ('1415' , '1442','1443','2811') -- [PC151255] - ajout de 2811
Begin
	If @sIdProcess='1415' 
	Begin
		If IsNumeric ( @asCodeMagasin ) = 0 
		Begin
			Select @asRetourMess = sysadm.FN_MESS ( 113, @asLangage )
			Set @aiCodeMsg = 113
			
			--[TRACE_24]
			EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
				@asIdSession,	-- @asIdSession     varchar(30),
				@asBrowser,	-- @asBrowser       varchar(50),
				null,		-- @asCasProduit    varchar(50),
				@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
				@asNom,		--	VarChar(50),
				@asNom,		--	Varchar(50),
				@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
				@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
				15,		-- @adcIdCodeTrc    Decimal(7),
				'ERREUR', 	-- @asGravite       varchar(10),
				'WEB',		-- @asIdAppli       varchar(5),
				'VALIDATION',	-- @asEtape         varchar(20),
				113,		-- @aiIdMess        integer
				null,		-- @asValCar	 VarChar(254),
				null		-- @asMajPar	 VarChar ( 4 )				
		End 
		
		Update sysadm.sinistre set id_orian_boutique=convert(int, @asCodeMagasin) where id_sin=@dcIdSin
	End
	
	Select @sMajPar = maj_par from sysadm.commande where id_sin=@dcIdSin and id_seq=@iIdSeq
	
	Set @sMajPar='PRS' -- [VDOC20044]

	Select @sMess = sysadm.FN_CODE_NUM( convert(integer,@sIdProcess), '-IF')
	If @sMess is null Set @sMess='Changement d''état de la commande : ' + @sIdProcess
	
	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sMajPar, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
	END
	ELSE
	BEGIN
		EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sMajPar, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
	END
	
	
End

-- Cloture de la commande
If @iRet = 1  and @sIdProcess = '1450' 
	Begin
		Update 	sysadm.commande
		Set
			cod_etat	= 'RPC',
			id_marq_art	= Left ( @asMarqRempl, 35 ),
			id_modl_art	= Left ( @asModlRempl, 35 ),
			id_serie_nouv   = Left ( @asNumSerieRempl, 20),
			mt_ttc_cmde	= Round ( Convert ( Decimal (11,2), @asMtPrixAchatRempl), 2 ),
			info_frn_spb_cplt =  
				  sysadm.FN_CLE_VAL_E ( 'CODE_VENDEUR', @asCodeVendeur, 
				   sysadm.FN_CLE_VAL_E ( 'CODE_MAGASIN', @asCodeMagasin, rtrim ( IsNull ( info_frn_spb_cplt, '' ) ) , ';')
				  , ';'),
			id_orian_marque = 1  -- Repère cmde Web

		From 	sysadm.commande c

		Where  	c.id_sin = @dcIdSin
		And	c.id_seq = @iIdSeq
		And	c.id_four = 'SCR'
		And     c.cod_etat = 'ECT'


		If	@@RowCount <> 1
			Begin
				Select @asRetourMess = sysadm.FN_MESS ( 120, @asLangage )
				Set @iRet = -1
				Set @aiCodeMsg = 120

				-- [TRACE_15]
				EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
					@asIdSession,	-- @asIdSession     varchar(30),
					@asBrowser,	-- @asBrowser       varchar(50),
					null,		-- @asCasProduit    varchar(50),
					@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
					@asNom,		--	VarChar(50),
					@asNom,		--	Varchar(50),
					@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
					@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
					15,		-- @adcIdCodeTrc    Decimal(7),
					'ERREUR', 	-- @asGravite       varchar(10),
					'WEB',		-- @asIdAppli       varchar(5),
					'VALIDATION',	-- @asEtape         varchar(20),
					120,		-- @aiIdMess        integer
					null,		-- @asValCar	 VarChar(254),
					null		-- @asMajPar	 VarChar ( 4 )				
			End 
		-- FPI - 14/12/2011
		Update 	sysadm.w_commande
		Set
			cod_etat	= 'RPC',
			id_marq_art	= Left ( @asMarqRempl, 35 ),
			id_modl_art	= Left ( @asModlRempl, 35 ),
			id_serie_nouv   = Left ( @asNumSerieRempl, 20),
			mt_ttc_cmde	= Round ( Convert ( Decimal (11,2), @asMtPrixAchatRempl), 2 ),
			info_frn_spb_cplt =  
				  sysadm.FN_CLE_VAL_E ( 'CODE_VENDEUR', @asCodeVendeur, 
				   sysadm.FN_CLE_VAL_E ( 'CODE_MAGASIN', @asCodeMagasin, rtrim ( IsNull ( info_frn_spb_cplt, '' ) ) , ';')
				  , ';'),
			id_orian_marque = 1  -- Repère cmde Web

		From 	sysadm.w_commande c

		Where  	c.id_sin = @dcIdSin
		And	c.id_seq = @iIdSeq
		And	c.id_four = 'SCR'
		And     c.cod_etat = 'ECT'

		
End
	
If @iRet = 1 and @sIdProcess = '1455' 
	Begin
		If 	Exists ( 	Select 	*
					From 	sysadm.w_commande
					Where	id_sin = @dcIdSin
					And 	id_seq = @iIdSeq )
			Begin    		
				Update 	sysadm.w_commande
				Set	
					cod_etat	= 'RPC',
					id_marq_art	= Left ( @asMarqRempl, 35 ),
					id_modl_art	= Left ( @asModlRempl, 35 ),
					id_serie_nouv   = Left ( @asNumSerieRempl, 20),
					mt_ttc_cmde	= Round ( Convert ( Decimal (11,2), @asMtPrixAchatRempl) , 2 ),
					info_frn_spb_cplt = 
						 sysadm.FN_CLE_VAL_E ( 'CODE_VENDEUR', @asCodeVendeur, 
						  sysadm.FN_CLE_VAL_E ( 'CODE_MAGASIN', @asCodeMagasin, rtrim ( IsNull ( info_frn_spb_cplt, '' ) ) , ';')
						 , ';'),
					id_orian_marque = 1  -- Repère cmde Web
				Where  	id_sin = @dcIdSin
				And	id_seq = @iIdSeq
				And	id_four = 'SCR'
				And     cod_etat = 'ECT'

				If	@@RowCount <> 1
					Begin
						Select @asRetourMess = sysadm.FN_MESS ( 120, @asLangage )
						Set @iRet = -1
						Set @aiCodeMsg = 120
						
						-- [TRACE_15]
						EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
							@asIdSession,	-- @asIdSession     varchar(30),
							@asBrowser,	-- @asBrowser       varchar(50),
							null,		-- @asCasProduit    varchar(50),
							@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
							@asNom,		--	VarChar(50),
							@asNom,		--	Varchar(50),
							@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
							@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
							15,		-- @adcIdCodeTrc    Decimal(7),
							'ERREUR', 	-- @asGravite       varchar(10),
							'WEB',		-- @asIdAppli       varchar(5),
							'VALIDATION',	-- @asEtape         varchar(20),
							120,		-- @aiIdMess        integer
							null,		-- @asValCar	 VarChar(254),
							null		-- @asMajPar	 VarChar ( 4 )						
					End 
			End 
			
		-- FPI - 14/12/2011
		Update 	sysadm.commande
		Set	
			cod_etat	= 'RPC',
			id_marq_art	= Left ( @asMarqRempl, 35 ),
			id_modl_art	= Left ( @asModlRempl, 35 ),
			id_serie_nouv   = Left ( @asNumSerieRempl, 20),
			mt_ttc_cmde	= Round ( Convert ( Decimal (11,2), @asMtPrixAchatRempl) , 2 ),
			info_frn_spb_cplt = 
				 sysadm.FN_CLE_VAL_E ( 'CODE_VENDEUR', @asCodeVendeur, 
				  sysadm.FN_CLE_VAL_E ( 'CODE_MAGASIN', @asCodeMagasin, rtrim ( IsNull ( info_frn_spb_cplt, '' ) ) , ';')
				 , ';'),
			id_orian_marque = 1  -- Repère cmde Web
		Where  	id_sin = @dcIdSin
		And	id_seq = @iIdSeq
		And	id_four = 'SCR'
		And     cod_etat = 'ECT'

		If	@@RowCount <> 1
			Begin
				Select @asRetourMess = sysadm.FN_MESS ( 120, @asLangage )
				Set @iRet = -1
				Set @aiCodeMsg = 120
				
				-- [TRACE_15]
				EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
					@asIdSession,	-- @asIdSession     varchar(30),
					@asBrowser,	-- @asBrowser       varchar(50),
					null,		-- @asCasProduit    varchar(50),
					@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
					@asNom,		--	VarChar(50),
					@asNom,		--	Varchar(50),
					@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
					@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
					15,		-- @adcIdCodeTrc    Decimal(7),
					'ERREUR', 	-- @asGravite       varchar(10),
					'WEB',		-- @asIdAppli       varchar(5),
					'VALIDATION',	-- @asEtape         varchar(20),
					120,		-- @aiIdMess        integer
					null,		-- @asValCar	 VarChar(254),
					null		-- @asMajPar	 VarChar ( 4 )						
			End 
	End

If @iRet = 1 and @sIdProcess in ('1442','1443','2811')
Begin
	If 	Exists ( 	Select 	*
				From 	sysadm.w_commande
				Where	id_sin = @dcIdSin
				And 	id_seq = @iIdSeq )
		Begin    		
			Update 	sysadm.w_commande
			Set	cod_etat	= 'RFO'
			Where  	id_sin = @dcIdSin
			  And	id_seq = @iIdSeq
			  And	id_four = 'SCR'
				And     cod_etat = 'ECT'	
		End
		
		Update 	sysadm.commande
		Set	cod_etat	= 'RFO'
		Where  	id_sin = @dcIdSin
		  And	id_seq = @iIdSeq
		  And	id_four = 'SCR'
		And     cod_etat = 'ECT'	
		
		If	@@RowCount <> 1
			Begin
				Select @asRetourMess = sysadm.FN_MESS ( 120, @asLangage )
				Set @iRet = -1
				Set @aiCodeMsg = 120

				-- [TRACE_15]
				EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
					@asIdSession,	-- @asIdSession     varchar(30),
					@asBrowser,	-- @asBrowser       varchar(50),
					null,		-- @asCasProduit    varchar(50),
					@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
					@asNom,		--	VarChar(50),
					@asNom,		--	Varchar(50),
					@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
					@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
					15,		-- @adcIdCodeTrc    Decimal(7),
					'ERREUR', 	-- @asGravite       varchar(10),
					'WEB',		-- @asIdAppli       varchar(5),
					'VALIDATION',	-- @asEtape         varchar(20),
					120,		-- @aiIdMess        integer
					null,		-- @asValCar	 VarChar(254),
					null		-- @asMajPar	 VarChar ( 4 )				
			End 
End 

-- [PC151255]
If @iRet = 1 and @sIdProcess in ('2822')
Begin
	If 	Exists ( 	Select 	*
				From 	sysadm.w_commande
				Where	id_sin = @dcIdSin
				And 	id_seq = @iIdSeq )
		Begin    		
			Update 	sysadm.w_commande
			Set	cod_etat	= 'RPC'
			Where  	id_sin = @dcIdSin
			  And	id_seq = @iIdSeq
			  And	id_four = 'SCR'
				And     cod_etat = 'RFO'	
		End
		
	Update 	sysadm.commande
	Set	cod_etat	= 'RPC'
	Where  	id_sin = @dcIdSin
		And	id_seq = @iIdSeq
		And	id_four = 'SCR'
	And     cod_etat = 'RFO'	
		
	If	@@RowCount <> 1
		Begin
			Select @asRetourMess = sysadm.FN_MESS ( 120, @asLangage )
			Set @iRet = -1
			Set @aiCodeMsg = 120

			-- [TRACE_15]
			EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
				@asIdSession,	-- @asIdSession     varchar(30),
				@asBrowser,	-- @asBrowser       varchar(50),
				null,		-- @asCasProduit    varchar(50),
				@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
				@asNom,		--	VarChar(50),
				@asNom,		--	Varchar(50),
				@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
				@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
				15,		-- @adcIdCodeTrc    Decimal(7),
				'ERREUR', 	-- @asGravite       varchar(10),
				'WEB',		-- @asIdAppli       varchar(5),
				'VALIDATION',	-- @asEtape         varchar(20),
				120,		-- @aiIdMess        integer
				null,		-- @asValCar	 VarChar(254),
				null		-- @asMajPar	 VarChar ( 4 )				
		End 
		
End

Return @iRet

Go

grant execute on sysadm.PS_WEBSIM2_VALIDATION_SAV_CARR to rolebddsinistres
Go

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSIM2_VALIDATION_SAV_CARR_PEM
-- Auteur               :       Pinon Fabien
-- Date                 :       15/10/2012 
-- Libelle              :        
-- Commentaires         :       Procédure de validation du diag pour le cas produit CARREFOUR_PEM_SAV
--				 
-- References           :       [PC846/864]
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
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSIM2_VALIDATION_SAV_CARR_PEM' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSIM2_VALIDATION_SAV_CARR_PEM
GO


CREATE PROCEDURE sysadm.PS_WEBSIM2_VALIDATION_SAV_CARR_PEM
	@asIdSin                VarChar(50),
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
	@asCommentFrn1	Varchar(255),
	@asCommentFrn2	Varchar(255),
	@asVarSeria		VarChar(500),
	@asLangage              VarChar (3),
	@aiCodeMsg		Integer OUTPUT,
        @asRetourMess           VarChar ( 2000 ) OUTPUT

AS
Declare @iRet	integer
Declare @iIdSeq integer
DECLARE @dcIdSin 	Decimal ( 10 ) -- [PI062]
Declare @sStatusGC	varchar(50)
Declare @sErr 	  Varchar(60)
Declare @sMajPar	Varchar(4)
Declare @sMess	VarChar ( 2000 )
Declare @iIdCt	integer		

Set @iIdSeq = -1
Set @iRet=1
Set @asRetourMess = 'OK'

Set @dcIdSin = Convert ( Decimal ( 10 ),  @asIdSin ) -- [PI062]

If @asMtPrixAchatRempl is not null Set @asMtPrixAchatRempl=Replace(@asMtPrixAchatRempl,',','.')

Exec @iRet = sysadm.PS_WEBSIM2_VALIDATION_CTRL_GENERAL
		@asIdSin,
		@iIdSeq	OUTPUT,
		@asNom,
		@asNom,
		@asSKU,
		@asCodeVendeur,
		@asCodeMagasin,
		2,
		@asIdSession,
		@asBrowser,
        @asMarqRempl,
        @asModlRempl,
        @asNumSerieRempl,
        @asMtPrixAchatRempl,
        @asLangage,
		@aiCodeMsg OUTPUT,
        @asRetourMess OUTPUT

If @iRet > 0 
Begin 
	If ( @asCodeMagasin is null Or Len ( @asCodeMagasin ) <= 0 )
	Begin
		Select @asRetourMess = sysadm.FN_MESS ( 113, @asLangage )
		Set @iRet = -1
		Set @aiCodeMsg = 113

		-- [TRACE_15]
		EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			null,		-- @asCasProduit    varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNom,		--	VarChar(50),
			@asNom,		--	Varchar(50),
			@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
			@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
			15,		-- @adcIdCodeTrc    Decimal(7),
			'ERREUR', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'VALIDATION',	-- @asEtape         varchar(20),
			113,		-- @aiIdMess        integer
			null,		-- @asValCar	 VarChar(254),
			null		-- @asMajPar	 VarChar ( 4 )
				
	End

	If @iRet > 0 And ( @asCodeVendeur is null Or Len ( @asCodeVendeur ) <= 0 )
	Begin
		Select @asRetourMess = sysadm.FN_MESS ( 114 , @asLangage )
		Set @iRet = -1
		Set @aiCodeMsg = 114
		
		-- [TRACE_15]
		EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			null,		-- @asCasProduit    varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNom,		--	VarChar(50),
			@asNom,		--	Varchar(50),
			@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
			@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
			15,		-- @adcIdCodeTrc    Decimal(7),
			'ERREUR', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'VALIDATION',	-- @asEtape         varchar(20),
			114,		-- @aiIdMess        integer
			null,		-- @asValCar	 VarChar(254),
			null		-- @asMajPar	 VarChar ( 4 )				
	End
End 

select @sStatusGC=sysadm.FN_CLE_VAL('RESULTAT_DIAG',@asVarSeria,';')

-- Mise à jour de la commande
If @iRet > 0 and @sStatusGC in ('241', '242')
Begin
	If IsNumeric ( @asCodeMagasin ) = 0 
	Begin
		Select @asRetourMess = sysadm.FN_MESS ( 113, @asLangage )
		Set @aiCodeMsg = 113
			
			--[TRACE_24]
		EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
			@asIdSession,	-- @asIdSession     varchar(30),
			@asBrowser,	-- @asBrowser       varchar(50),
			null,		-- @asCasProduit    varchar(50),
			@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
			@asNom,		--	VarChar(50),
			@asNom,		--	Varchar(50),
			@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
			@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
			15,		-- @adcIdCodeTrc    Decimal(7),
			'ERREUR', 	-- @asGravite       varchar(10),
			'WEB',		-- @asIdAppli       varchar(5),
			'VALIDATION',	-- @asEtape         varchar(20),
			113,		-- @aiIdMess        integer
			null,		-- @asValCar	 VarChar(254),
			null		-- @asMajPar	 VarChar ( 4 )				
	End 
		
	Update sysadm.sinistre set id_orian_boutique=convert(int, @asCodeMagasin) where id_sin=@dcIdSin
	Update sysadm.w_sin set id_orian_boutique=convert(int, @asCodeMagasin) where id_sin=@dcIdSin
	
	Update 	sysadm.commande
		Set
			cod_etat	= 'RFO',
			info_frn_spb_cplt =  
				  sysadm.FN_CLE_VAL_E ( 'CODE_VENDEUR', @asCodeVendeur, 
				   sysadm.FN_CLE_VAL_E ( 'CODE_MAGASIN', @asCodeMagasin, rtrim ( IsNull ( info_frn_spb_cplt, '' ) ) , ';')
				  , ';'),
			id_orian_marque = 1,  -- Repère cmde Web
			status_gc=convert(int,@sStatusGC),
			comment_frn=@asCommentFrn1
		From 	sysadm.commande c

		Where  	c.id_sin = @dcIdSin
		And	c.id_seq = @iIdSeq
		And	c.id_four = 'SCR'
		And     c.cod_etat = 'ECT'
	
	Update 	sysadm.w_commande
		Set
			cod_etat	= 'RFO',
			info_frn_spb_cplt =  
				  sysadm.FN_CLE_VAL_E ( 'CODE_VENDEUR', @asCodeVendeur, 
				   sysadm.FN_CLE_VAL_E ( 'CODE_MAGASIN', @asCodeMagasin, rtrim ( IsNull ( info_frn_spb_cplt, '' ) ) , ';')
				  , ';'),
			id_orian_marque = 1,  -- Repère cmde Web
			status_gc=convert(int,@sStatusGC),
			comment_frn=@asCommentFrn1
		From 	sysadm.w_commande c

		Where  	c.id_sin = @dcIdSin
		And	c.id_seq = @iIdSeq
		And	c.id_four = 'SCR'
		And     c.cod_etat = 'ECT'
		
	Select @sMajPar = maj_par from sysadm.commande where id_sin=@dcIdSin and id_seq=@iIdSeq
	
	Select @sMess = sysadm.FN_CODE_NUM( convert(integer,@sStatusGC), '-GC')
	If @sMess is null Set @sMess='Résultat de diagnostic : ' + @sStatusGC
	
	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sMajPar, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
	END
	ELSE
	BEGIN
		EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @dcIdSin, 2, @sMess, @sMajPar, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'C'
	END
	
	
End

Return @iRet
Go

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSIM2_VALIDATION_MC_PROTECT
-- Auteur               :       Pinon Fabien
-- Date                 :       30/11/2012 
-- Libelle              :        
-- Commentaires         :       Procédure de validation de commande pour le cas produit MC_PROTECT
--				 
-- References           :       [PC853]
--
-- Arguments            :       @asIdSin               VarChar(7)        	(Val) Identifiant de sinistre
--              @asCas                  VarChar ( 40   )        (Val) Cas de Trt 
--				@asLangage              VarChar (  3 )          (Val) Code de la Langue utilisé pour les mess de retour ( -LG/CodeCar )
--                              @asRetourMess           VarChar (  2000 )       (Réf) Message à afficher en retour
--
--
-- Retourne             :       Integer                 >0 = OK
--                                                      -1 = NOK
--
-------------------------------------------------------------------
-- VAR_SERIA = NUM_FACTURE=555;DTE_REMPL=25/11/2012
-- JFF      12/12/2013   [PC947&977]
-- JFF      18/03/2014   [DT076_ADVISE]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSIM2_VALIDATION_MC_PROTECT' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSIM2_VALIDATION_MC_PROTECT
GO


CREATE PROCEDURE sysadm.PS_WEBSIM2_VALIDATION_MC_PROTECT
	@asIdSin                VarChar(50),
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
	@asCommentFrn1	Varchar(255),
	@asCommentFrn2	Varchar(255),
	@asVarSeria		VarChar(500),
	@asLangage              VarChar (3),
	@aiCodeMsg		Integer OUTPUT,
        @asRetourMess           VarChar ( 2000 ) OUTPUT

AS
Declare @iRet	integer
Declare @iIdSeq integer
DECLARE @dcIdSin 	Decimal ( 10 ) -- [PI062]
Declare @sNumFact	varchar(50),
	@sDteRempl		varchar(10)
Declare @sErr 	  Varchar(60)
Declare @sMajPar	Varchar(4)
Declare @sMess	VarChar ( 2000 )
Declare @iIdCt	integer	
Declare @sCWE	Varchar(3)	

Set @iIdSeq = -1
Set @iRet=1
Set @asRetourMess = 'OK'

Set @dcIdSin = Convert ( Decimal ( 10 ),  @asIdSin ) -- [PI062]

Set     @sCWE = 'NON'

Select  @sCWE = 'OUI'
From    sysadm.sinistre s,
		sysadm.commande c
Where   s.id_sin = @dcIdSin
	and     c.id_sin = s.id_sin
	and     c.id_four in ('ACU', 'CYT', 'FPC','MCY', 'ADV' ) -- [PC947&977]
	and     c.cod_etat = 'ECT'
	and     c.id_seq = (    Select max ( c2.id_seq ) 
				From sysadm.commande c2
				Where c2.id_sin = c.id_sin
				and   c2.id_four = c.id_four
				and   c2.cod_etat = c.cod_etat )


IF      @sCWE = 'NON'
BEGIN
	-- Pas de commande
	Select @asRetourMess = sysadm.FN_MESS ( 102, @asLangage )
	Set @aiCodeMsg = 102

	Set @iRet=-1
End


If @iRet > 0 
Begin 
	
	select @sNumFact=rtrim(sysadm.FN_CLE_VAL('NUM_FACTURE',@asVarSeria,';')),
		@sDteRempl=rtrim(sysadm.FN_CLE_VAL('DTE_REMPL',@asVarSeria,';'))
		
	If ( @sDteRempl is null Or Len ( @sDteRempl ) <= 0)
	Begin
		Select @asRetourMess = sysadm.FN_MESS ( 121, @asLangage )
		Set @iRet = -1
		Set @aiCodeMsg = 121
	End
	
	If ( @iRet > 0 and isdate(@sDteRempl) = 0)
	Begin
		Select @asRetourMess = sysadm.FN_MESS ( 1, @asLangage )
		Set @iRet = -1
		Set @aiCodeMsg = 1
	End
	
	If ( @sNumFact is null Or Len ( @sNumFact ) <= 0)
	Begin
		Select @asRetourMess = sysadm.FN_MESS ( 122, @asLangage )
		Set @iRet = -1
		Set @aiCodeMsg = 122
	End
	
	If ( @asNumSerieRempl is null Or Len ( @asNumSerieRempl ) <= 0)
	Begin
		Select @asRetourMess = sysadm.FN_MESS ( 111, @asLangage )
		Set @iRet = -1
		Set @aiCodeMsg = 111
	End

End
	
If @iRet <= 0 
Begin
	-- [TRACE_15]
	EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
		@asIdSession,	-- @asIdSession     varchar(30),
		@asBrowser,	-- @asBrowser       varchar(50),
		null,		-- @asCasProduit    varchar(50),
		@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
		@asNom,		--	VarChar(50),
		@asNom,		--	Varchar(50),
		@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
		@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
		15,		-- @adcIdCodeTrc    Decimal(7),
		'ERREUR', 	-- @asGravite       varchar(10),
		'WEB',		-- @asIdAppli       varchar(5),
		'VALIDATION',	-- @asEtape         varchar(20),
		113,		-- @aiIdMess        integer
		null,		-- @asValCar	 VarChar(254),
		null		-- @asMajPar	 VarChar ( 4 )
			
End


-- Mise à jour de la commande
If @iRet > 0 
Begin
	
	Update 	sysadm.commande
		Set
			cod_etat	= 'RPC',
			dte_env_cli=CONVERT(datetime,@sDteRempl),
			id_serie_nouv= @asNumSerieRempl,
			id_cmd_frn=@sNumFact,
			comment_frn=@asCommentFrn1

		From 	sysadm.commande c

		Where  	c.id_sin = @dcIdSin
		And	c.id_four in ('ACU','FPC','CYT','MCY', 'ADV') -- [PC947&977]
		And     c.cod_etat = 'ECT'

	Update 	sysadm.w_commande
		Set
			cod_etat	= 'RPC',
			dte_env_cli=CONVERT(datetime,@sDteRempl),
			id_serie_nouv= @asNumSerieRempl,
			id_cmd_frn=@sNumFact,
			comment_frn=@asCommentFrn1
		From 	sysadm.w_commande c
		Where  	c.id_sin = @dcIdSin
			And	c.id_four in ('ACU','FPC','CYT','MCY', 'ADV') -- [PC947&977]
			And c.cod_etat = 'ECT'


	-- [DT076_ADVISE] ensuite remonter les lignes dans les updates ci-dessus
	Update 	sysadm.commande
		Set	info_frn_spb_cplt = sysadm.FN_CLE_VAL_E ( 'MT_SAISI_EXTRANET', @asMtPrixAchatRempl, rtrim ( c.info_frn_spb_cplt ), ';')

		From 	sysadm.commande c

		Where  	c.id_sin = @dcIdSin
		And	c.id_four in ('ACU','FPC','CYT','MCY', 'ADV') -- [PC947&977]
		And     c.cod_etat = 'ECT'
		
	Update 	sysadm.w_commande
		Set	info_frn_spb_cplt = sysadm.FN_CLE_VAL_E ( 'MT_SAISI_EXTRANET', @asMtPrixAchatRempl, rtrim ( c.info_frn_spb_cplt ), ';')

		From 	sysadm.w_commande c

		Where  	c.id_sin = @dcIdSin
		And	c.id_four in ('ACU','FPC','CYT','MCY', 'ADV') -- [PC947&977]
		And     c.cod_etat = 'ECT'

End

Return @iRet
Go

-------------------------------------------------------------------
-- Procedure            :       PS_WEBSIM2_VALIDATION_OMEA_TELECOM
-- Auteur               :       Pinon Fabien
-- Date                 :       22/09/2014
-- Libelle              :        
-- Commentaires         :       Procédure de validation de commande pour le cas produit OMEA_TELECOM
--				 
-- References           :       [PC13447-1]
--
-- Arguments            :       @asIdSin               VarChar(7)        	(Val) Identifiant de sinistre
--              @asCas                  VarChar ( 40   )        (Val) Cas de Trt 
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
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_WEBSIM2_VALIDATION_OMEA_TELECOM' AND type = 'P' )
        DROP PROCEDURE sysadm.PS_WEBSIM2_VALIDATION_OMEA_TELECOM
GO

CREATE PROCEDURE sysadm.PS_WEBSIM2_VALIDATION_OMEA_TELECOM
	@asIdSin                VarChar(50),
	@asCodeVendeur		Varchar(50),
	@asCodeMagasin		Varchar(50),
	@asCas                  VarChar(50),
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
Declare @iIdSeq integer
DECLARE @dcIdSin 	Decimal ( 10 ) -- [PI062]
Declare @sNumFact	varchar(50),
	@sDteRempl		varchar(10)
Declare @sErr 	  Varchar(60)
Declare @sMajPar	Varchar(4)
Declare @sMess	VarChar ( 2000 )
Declare @iIdCt	integer	
Declare @sCWE	Varchar(3)	

Set @iIdSeq = -1
Set @iRet=1
Set @asRetourMess = 'OK'

Set @dcIdSin = Convert ( Decimal ( 10 ),  @asIdSin ) -- [PI062]

Set     @sCWE = 'NON'

Select  @sCWE = 'OUI'
From    sysadm.sinistre s,
		sysadm.commande c
Where   s.id_sin = @dcIdSin
	and     c.id_sin = s.id_sin
	and     c.id_four in ('OME' ) -- [PC947&977]
	and     c.cod_etat = 'ECT'
	and     c.id_seq = (    Select max ( c2.id_seq ) 
				From sysadm.commande c2
				Where c2.id_sin = c.id_sin
				and   c2.id_four = c.id_four
				and   c2.cod_etat = c.cod_etat )


IF      @sCWE = 'NON'
BEGIN
	-- Pas de commande
	Select @asRetourMess = sysadm.FN_MESS ( 102, @asLangage )
	Set @aiCodeMsg = 102

	Set @iRet=-1
End


If @iRet > 0 
Begin 
	
	select @sNumFact=rtrim(sysadm.FN_CLE_VAL('NUM_FACTURE',@asVarSeria,';')),
		@sDteRempl=rtrim(sysadm.FN_CLE_VAL('DTE_REMPL',@asVarSeria,';'))
		
	If ( @sDteRempl is null Or Len ( @sDteRempl ) <= 0)
	Begin
		Select @asRetourMess = sysadm.FN_MESS ( 121, @asLangage )
		Set @iRet = -1
		Set @aiCodeMsg = 121
	End
	
	If ( @iRet > 0 and isdate(@sDteRempl) = 0)
	Begin
		Select @asRetourMess = sysadm.FN_MESS ( 1, @asLangage )
		Set @iRet = -1
		Set @aiCodeMsg = 1
	End
	
	If ( @sNumFact is null Or Len ( @sNumFact ) <= 0)
	Begin
		Select @asRetourMess = sysadm.FN_MESS ( 122, @asLangage )
		Set @iRet = -1
		Set @aiCodeMsg = 122
	End
	
	If ( @asNumSerieRempl is null Or Len ( @asNumSerieRempl ) <= 0)
	Begin
		Select @asRetourMess = sysadm.FN_MESS ( 111, @asLangage )
		Set @iRet = -1
		Set @aiCodeMsg = 111
	End

	if ( @asMtPrixAchatRempl	is null Or Len ( @asMtPrixAchatRempl ) <= 0)
	Begin
		Select @asRetourMess = sysadm.FN_MESS ( 111, @asLangage )
		Set @iRet = -1
		Set @aiCodeMsg = 112
	End
End
	
	
If @iRet <= 0 
Begin
	-- [TRACE_15]
	EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01
		@asIdSession,	-- @asIdSession     varchar(30),
		@asBrowser,	-- @asBrowser       varchar(50),
		null,		-- @asCasProduit    varchar(50),
		@dcIdSin,	-- @adcIdSin	    Decimal (10), -- [PI062]
		NULL,		--	VarChar(50),
		NULL,		--	Varchar(50),
		@asCodeVendeur,	-- @asCodeVendeur   Varchar(50),
		@asCodeMagasin,	-- @asCodeMagasin   Varchar(50),
		15,		-- @adcIdCodeTrc    Decimal(7),
		'ERREUR', 	-- @asGravite       varchar(10),
		'WEB',		-- @asIdAppli       varchar(5),
		'VALIDATION',	-- @asEtape         varchar(20),
		@aiCodeMsg,		-- @aiIdMess        integer
		null,		-- @asValCar	 VarChar(254),
		null		-- @asMajPar	 VarChar ( 4 )
			
End


-- Mise à jour de la commande
If @iRet > 0 
Begin

	Update 	sysadm.commande
		Set
			cod_etat	= 'RPC',
			id_marq_art	= Left ( @asMarqRempl, 35 ),
			id_modl_art	= Left ( @asModlRempl, 35 ),
			dte_env_cli=CONVERT(datetime,@sDteRempl),
			id_serie_nouv= @asNumSerieRempl,
			id_cmd_frn=@sNumFact,
			mt_ttc_cmde	= Round ( Convert ( Decimal (11,2), @asMtPrixAchatRempl) , 2 ),
			comment_frn=@asCommentFrn1,
			info_frn_spb_cplt = 
				sysadm.FN_CLE_VAL_E ( 'CODE_VENDEUR', @asCodeVendeur, 
				 sysadm.FN_CLE_VAL_E ( 'CODE_MAGASIN', @asCodeMagasin, 
				 sysadm.FN_CLE_VAL_E ( 'MT_SAISI_EXTRANET', @asMtPrixAchatRempl,  rtrim ( IsNull ( info_frn_spb_cplt, '' ) ) , ';')
				 , ';'), ';'),
			id_orian_marque = 1  -- Repère cmde Web
		From 	sysadm.commande c

		Where  	c.id_sin = @dcIdSin
		And	c.id_four in ('OME')
		And     c.cod_etat = 'ECT'

	Update 	sysadm.w_commande
		Set
			cod_etat	= 'RPC',
			id_marq_art	= Left ( @asMarqRempl, 35 ),
			id_modl_art	= Left ( @asModlRempl, 35 ),
			dte_env_cli=CONVERT(datetime,@sDteRempl),
			id_serie_nouv= @asNumSerieRempl,
			id_cmd_frn=@sNumFact,
			mt_ttc_cmde	= Round ( Convert ( Decimal (11,2), @asMtPrixAchatRempl) , 2 ),
			comment_frn=@asCommentFrn1,
			info_frn_spb_cplt = 
				sysadm.FN_CLE_VAL_E ( 'CODE_VENDEUR', @asCodeVendeur, 
				 sysadm.FN_CLE_VAL_E ( 'CODE_MAGASIN', @asCodeMagasin, 
				 sysadm.FN_CLE_VAL_E ( 'MT_SAISI_EXTRANET', @asMtPrixAchatRempl,  rtrim ( IsNull ( info_frn_spb_cplt, '' ) ) , ';')
				 , ';'), ';'),
			id_orian_marque = 1  -- Repère cmde Web
		From 	sysadm.w_commande c
		Where  	c.id_sin = @dcIdSin
			And	c.id_four in ('OME')
			And c.cod_etat = 'ECT'


	

End

Return @iRet

Go

grant execute on sysadm.PS_WEBSIM2_VALIDATION_OMEA_TELECOM to rolebddsinistres
go