-------------------------------------------------------------------
--
-- Fichier              :       MAILPUSH.CP
-- Auteur               :       Fabry JF
-- Date                 :       19/05/2006
--
-- Commentaires         :       PS rattachées au projet MAILPUSH
--
-- Proc‚dures           :       
-- sysadm.PS_AGENT_MAIL_CASTO_DT133
-- sysadm.PS_ENVOI_MAILPUSH_SMS_PSM_1
-- sysadm.PS_I_MAIL_CASTO_DT133
-- sysadm.PS_I_MAIL_CASTO_DT133_REL
-- sysadm.PS_I_MAIL_COLI_SIN_FICHE_16
-- sysadm.PS_I_MAIL_DEM_PIECE_SBE
-- sysadm.PS_I_MAIL_IOS7_VDOC12443
-- sysadm.PS_I_MAIL_PRET_FICHE_15
-- sysadm.PS_I_MAIL_RETOUR_PRET_FICHE_14
-- sysadm.PS_I_MAIL_SWAP_FICHE_19
-- sysadm.PS_I01_MAILPUSH  
-- sysadm.PS_I01_SMSPUSH
-- sysadm.PS_I02_MAILPUSH
-- sysadm.PS_I02_MAILPUSH_V01
-- sysadm.PS_LIRE_UTILISATEUR_SITE
-- sysadm.PS_S_MAILPUSH_ADVISE_RN_XA
-- sysadm.PS_S_MAILPUSH_APP_IRREPARABLE
-- sysadm.PS_S_MAILPUSH_APP_NON_RECP_EN_CTR
-- sysadm.PS_S_MAILPUSH_ARR_PLATFORM
-- sysadm.PS_S_MAILPUSH_CODE_ERR_LIVR_CHRONOPOST
-- sysadm.PS_S_MAILPUSH_DEP_CENTRDISTRIB
-- sysadm.PS_S_MAILPUSH_ENV_APP_REMPL
-- sysadm.PS_S_MAILPUSH_MAIL_AXALOT
-- sysadm.PS_S_MAILPUSH_ORANGE_CTL_IMEI
-- sysadm.PS_S_MAILPUSH_PM95_ALERTE_14
-- sysadm.PS_S_MAILPUSH_PTL_CTL_IMEI
-- sysadm.PS_S_MAILPUSH_REFUSE_A_REEXP_RET_PICK_UP
-- sysadm.PS_S_MAILPUSH_RELANCE_PCE_DT262
-- sysadm.PS_S_TRT_MAIL_CMD
-- sysadm.PS_S01_MAILPUSH_RECP_PIEC
-- sysadm.PS_S01_RECUP_DONNEES_MAIL
-- sysadm.PS_S01_RECUP_DONNEES_MAIL_XML
-- sysadm.PS_S02_MAILPUSH_RECP_APP_EN_CTR
-- sysadm.PS_S03_MAILPUSH_ENVTEL_REMP_REPAR_V03
-- sysadm.PS_S04_MAILPUSH_INFO_REPAR_PASSE
-- sysadm.PS_S05_MAILPUSH_URL_MDP_SITE_CMDE
-- sysadm.PS_S06_MAILPUSH_REGEN_MDP_SITE_CMDE
-- sysadm.PS_S07_MAILPUSH_CONF_CMDE_WEB_ASS
-- sysadm.PS_S08_MAILPUSH_CORPS_MAIL_FNAC_900
-- sysadm.PS_S09_MAILPUSH_NOTIF_COURRIER
-- sysadm.PS_S10_MAILPUSH_DECLARATION
-- sysadm.PS_S10_MAILPUSH_ENVOI_CRT
-- sysadm.PS_S11_MAILPUSH_SAV_CARREFOUR
-- sysadm.PS_S11_SMSPUSH_ENVOI_BGE
-- sysadm.PS_S12_MAILPUSH_LDE
-- sysadm.PS_S13_MAILPUSH_FRAIS_PRESTA
-- sysadm.PS_S14_MAILPUSH_CONVERLANCE
-- sysadm.PS_S15_MAILPUSH_DIAGOK_ASSURE
-- sysadm.PS_S16_MAILPUSH_ORANGE_REUNION
-- sysadm.PS_S17_MAILPUSH_ORE_CTL_IMEI
-- sysadm.PS_S18_MAILPUSH_OUTREMER_TELECOM
-- sysadm.PS_S19_MAILPUSH_SAV_OUTREMER_TELECOM
-- sysadm.PS_S20_MAILPUSH_OOP_CTL_IMEI
-- TRIGGER TR_U01_DIV_SIN_PUSH_S06
-------------------------------------------------------------------


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S01_RECUP_DONNEES_MAIL_XML
-- Auteur               :       Fabry JF reprise de F. PINON de l'espagne
-- Date                 :       09/04/2010
-- Libelle              : 	[PM159]
-- Commentaires         :       Récupère toutes les données commune aux procédures PUSH
-- References           :
--
-- Arguments            :       @adcIdSin       Decimal (  7,0 )        (Val)
--  				@asBase 	VarChar (20)		(Val)
--				@aiOptionDP   	Integer			(Val)
--  				@adcIdProd     	Decimal (7)  		(Ref)
--  				@asLibProd    VarChar (255) 		(Ref)
--				@adcIdEts 	Decimal (7)  		(Ref)
--  				@asCiv		VarChar (100) 		(Ref)
--  				@asNom		VarChar (50) 		(Ref)
--  				@asMailFrom	VarChar (128) 		(Ref)
--				@asMailSend	VarChar (128) 		(Ref)
--				@asMailCc	VarChar (128) 		(Ref)
--				@asAltQuarant	VarChar (1) 		(Ref)
--				@asBoiteMail    VarChar (35) 		(Ref)
--				@asXMLVar	Varchar (541)		(Ref)
--
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée
--
-------------------------------------------------------------------
-- Exemple XML : <commun id_sin="6742" id_prod="3103" lib_prod="Internity Moviles" num_tel_prod="90 21 33 17 7"  id_ets="1001"  civilite="M."  nom="Gamero Colchado" />
-- JFF  17/10/2011 [PM159][&]
--	FPI	08/06/2012 [20120608.FPI] Suppr de la , pour Messieurs
-- JFF      29/02/2016   [DT191-1]
-- JFF      12/02/2016   [PI062]
-- JFF      06/11/2018   [PM451-1]
-- JFF      26/12/2018   [PM421-2]
-- JFF      26/01/2021   [VDOC30089] problème d'envoi par mail suite absence de numtelprod
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_RECUP_DONNEES_MAIL_XML' AND type = 'P' )
        DROP procedure sysadm.PS_S01_RECUP_DONNEES_MAIL_XML
GO

CREATE procedure sysadm.PS_S01_RECUP_DONNEES_MAIL_XML
  @adcIdSin     Decimal (10), -- [PI062]
  @aiOptionDP   Integer,
  @adcIdProd    Decimal (7)  OUTPUT,
  @asLibProd    VarChar (255) OUTPUT,
  @adcIdEts 	Decimal (7) OUTPUT,
  @asNumTelProd    VarChar (20) OUTPUT,
  @asCiv	VarChar (100) OUTPUT,
  @asNom	VarChar (50) OUTPUT,
  @asMailFrom	VarChar (128) OUTPUT,
  @asMailSend	VarChar (128) OUTPUT,
  @asMailCc	VarChar (128) OUTPUT,
  @asAltQuarant	VarChar (1) OUTPUT,
  @asBoiteMail    VarChar (50) OUTPUT,
  @asXMLVar	VarChar (2000) OUTPUT 
AS
  Declare @iRet	 Integer
  Declare @iTbPerm Integer
  Declare @iDeb Integer
  Declare @iFin Integer
  Declare @sRechBoiteMail VarChar ( 50 ) -- #1
  Declare @dcIdI Decimal ( 7 ) -- [PM421-2]
  Declare @sCodInter VarChar ( 1 ) -- [PM421-2]

  -- [PM421-2]
	/*
	Explication de cet armement de variables horrible :-)
	J'ai besoin pour le PM421-2 d'avoir le l'inter sur la PS_S01_RECUP_DONNEES_MAIL_XML.
	Cette PS ramenant le XML étant appelé à beaucoup d'endroit, je n'ai pas envie de modifier la signature de la PS et tous les appel.
	De ce fait j'utilise la chaine de caractère @sMailCc pour transmettre la donnée en bcv.
	*/
	Set @dcIdI = 0
	Set @sCodInter = 'A'
	If @asMailCc is not null
	Begin
		If IsNumeric ( sysadm.FN_CLE_VAL ( 'ID_I', rtrim ( @asMailCc), ';')) > 0 
		Begin
			Set @dcIdI = sysadm.FN_CLE_VAL ( 'ID_I', rtrim ( @asMailCc), ';')
		End 

		Set @sCodInter = sysadm.FN_CLE_VAL ( 'COD_INTER', rtrim ( @asMailCc), ';')

		If @sCodInter is null Or rtrim ( ltrim ( @sCodInter )) = '' Set @sCodInter = 'A'

		Set @asMailCc = ''
	End  

  -- #1
  Set @sRechBoiteMail = 'BOITE_MAIL'

  Select @iTbPerm = Count (*)
  From   sysadm.sinistre s
  Where  s.id_sin = @adcIdSin

  Set @iRet = 0

  -- Cas de l'option 173 où l'on force le select sur les table de travail
  If @aiOptionDP not in ( 51, 173 )
  Begin
	  Select @adcIdProd = sysadm.FN_TRIM ( s.id_prod ),
		 @asLibProd = sysadm.FN_TRIM ( p.lib_long ),
		 @adcIdEts  = s.id_ets,
		 @asNumTelProd =
			sysadm.FN_TRIM (
			Case Left ( p.num_tel, 2 )
				When '08' Then Left ( p.num_tel, 1 ) + ' ' + SubString ( p.num_tel, 2, 3 ) + ' ' + SubString ( p.num_tel, 5, 3 ) + ' ' + SubString ( p.num_tel, 8, 3 )
				Else Left ( p.num_tel, 2 ) + ' ' + SubString ( p.num_tel, 3, 2 ) + ' ' + SubString ( p.num_tel, 5, 2 ) + ' ' + SubString ( p.num_tel, 7, 2 ) + ' ' + SubString ( p.num_tel, 9, 2 )
			End
			)
	  From   sysadm.sinistre s,
		 sysadm.produit  p
	  Where  s.id_sin = @adcIdSin
	  and    p.id_prod = s.id_prod
  End
  Else
  Begin
  	  Select @adcIdProd = sysadm.FN_TRIM ( s.id_prod ),
  		 @asLibProd = sysadm.FN_TRIM ( p.lib_long ),
  		 @adcIdEts  = s.id_ets,
  		 @asNumTelProd =
  			sysadm.FN_TRIM (
  			Case Left ( p.num_tel, 2 )
  				When '08' Then Left ( p.num_tel, 1 ) + ' ' + SubString ( p.num_tel, 2, 3 ) + ' ' + SubString ( p.num_tel, 5, 3 ) + ' ' + SubString ( p.num_tel, 8, 3 )
  				Else Left ( p.num_tel, 2 ) + ' ' + SubString ( p.num_tel, 3, 2 ) + ' ' + SubString ( p.num_tel, 5, 2 ) + ' ' + SubString ( p.num_tel, 7, 2 ) + ' ' + SubString ( p.num_tel, 9, 2 )
  			End
  			)
  	  From   sysadm.w_sin s,
  		 sysadm.produit  p
  	  Where  s.id_sin = @adcIdSin
	  and    p.id_prod = s.id_prod

	  -- [DT191-1]
		If @adcIdProd is null
		Begin
			Select @adcIdProd = sysadm.FN_TRIM ( s.id_prod ),
				@asLibProd = sysadm.FN_TRIM ( p.lib_long ),
				@adcIdEts  = s.id_ets,
				@asNumTelProd =
				sysadm.FN_TRIM (
				Case Left ( p.num_tel, 2 )
					When '08' Then Left ( p.num_tel, 1 ) + ' ' + SubString ( p.num_tel, 2, 3 ) + ' ' + SubString ( p.num_tel, 5, 3 ) + ' ' + SubString ( p.num_tel, 8, 3 )
					Else Left ( p.num_tel, 2 ) + ' ' + SubString ( p.num_tel, 3, 2 ) + ' ' + SubString ( p.num_tel, 5, 2 ) + ' ' + SubString ( p.num_tel, 7, 2 ) + ' ' + SubString ( p.num_tel, 9, 2 )
				End
				)
			From   sysadm.sinistre s,
				sysadm.produit  p
			Where  s.id_sin = @adcIdSin
			and    p.id_prod = s.id_prod
		End
  End

  --DCMP 060532 - Lib produit destiné au client.
  Select @asLibProd = sysadm.FN_TRIM ( dp.val_car )
  From   sysadm.det_pro dp
  Where  dp.id_prod = @adcIdProd
  And 	 dp.id_typ_code_dp = '-DP'
  And 	 dp.id_code_dp = 66
  And 	 dp.val_car is not null
  And 	 sysadm.FN_TRIM ( dp.val_car ) <> ''

  --DCMP 060532 - Lib produit destiné au client.
  Select @asLibProd = @asLibProd + ' / ' + sysadm.FN_TRIM ( dp.val_car )
  From   sysadm.det_pro dp
  Where  dp.id_prod = @adcIdProd
  And 	 dp.id_typ_code_dp = '-DP'
  And 	 dp.id_code_dp = 67
  And 	 dp.val_car is not null
  And    Exists (
	  Select *
	  From   sysadm.det_pro dp2
	  Where  dp2.id_prod = @adcIdProd
	  And 	 dp2.id_typ_code_dp = '-DP'
	  And 	 dp2.id_code_dp = 66
	  And 	 dp2.val_car is not null
	  And 	 sysadm.FN_TRIM ( dp2.val_car ) <> ''
	  )


  Set    @asMailFrom = ''

-- [PM421-2] Nouveau Fonctionnement PM421-2
	If @aiOptionDP not in ( 51, 173 )
	Begin
		Select @asMailSend = IsNull ( sysadm.FN_TRIM ( i.adr_mail ), '' )
		From   sysadm.inter i
		Where  i.id_sin = @adcIdSin
		and    id_i = @dcIdI
	End
	Else
	Begin
  		Select @asMailSend = IsNull ( sysadm.FN_TRIM ( i.adr_mail ), '' )
  		From   sysadm.w_inter i
  		Where  i.id_sin = @adcIdSin
		and    id_i = @dcIdI

		-- [DT191-1]
		If @asMailSend is null
		Begin
			Select @asMailSend = IsNull ( sysadm.FN_TRIM ( i.adr_mail ), '' )
			From   sysadm.inter i
			Where  i.id_sin = @adcIdSin
			and    id_i = @dcIdI
		End
	End

	If @aiOptionDP not in ( 51, 173 )
	Begin
		If @dcIdI = 0 
		Begin
			Select @asCiv = Case
							When p.cod_civ in ( 4, 5 ) Then sysadm.FN_TRIM ( IsNull ( sysadm.FN_CODE_NUM ( 4, '-CL' ), '' )) -- [PM451-1] Civ Long
							Else sysadm.FN_TRIM ( IsNull ( sysadm.FN_CODE_NUM ( sysadm.FN_TRIM (p.cod_civ), '-CI' ), '' ))
							End,
					@asNom = Case
							When p.cod_civ in ( 4, 5 ) Then ''
							Else sysadm.SPB_FN_INIT_CAP ( p.nom, null )
							End
			From   sysadm.sinistre s,
				sysadm.personne p
			Where  s.id_sin = @adcIdSin
			and    s.id_ordre = p.id_ordre
		End
		Else
		Begin
			Select @asCiv = Case
							When i.cod_civ in ( 4, 5 ) Then sysadm.FN_TRIM ( IsNull ( sysadm.FN_CODE_NUM ( 4, '-CL' ), '' )) -- [PM451-1] Civ Long
							Else sysadm.FN_TRIM ( IsNull ( sysadm.FN_CODE_NUM ( sysadm.FN_TRIM (i.cod_civ), '-CI' ), '' ))
							End,
					@asNom = Case
							When i.cod_civ in ( 4, 5 ) Then ''
							Else Upper ( i.nom ) 
							End
			From   sysadm.inter i
			Where  i.id_sin = @adcIdSin
			and    i.id_i = @dcIdI
		End 

	End
	Else
	Begin
		If @dcIdI = 0 				
		Begin
			Select @asCiv = Case
								When s.cod_civ in ( 4, 5 ) Then sysadm.FN_TRIM ( IsNull ( sysadm.FN_CODE_NUM ( 4, '-CL' ), '' )) -- [PM451-1] Civ Long
								Else sysadm.FN_TRIM ( IsNull ( sysadm.FN_CODE_NUM ( sysadm.FN_TRIM (s.cod_civ), '-CI' ), '' ))
							End,
					@asNom = Case
								When s.cod_civ in ( 4, 5 ) Then ''
								Else sysadm.SPB_FN_INIT_CAP
										(
										sysadm.FN_TRIM ( IsNull ( Upper ( Left  ( sysadm.FN_TRIM ( s.nom ), 1) ), '' )) +
										sysadm.FN_TRIM ( IsNull ( Lower ( Right ( sysadm.FN_TRIM ( s.nom ), Len ( s.nom ) - 1 ) ), '' )),
										null
										)
							End
			From   sysadm.w_sin s
			Where  s.id_sin = @adcIdSin
		End 
		Else
		Begin
			Select @asCiv = Case
								When i.cod_civ in ( 4, 5 )  Then sysadm.FN_TRIM ( IsNull ( sysadm.FN_CODE_NUM ( 4, '-CL' ), '' )) -- [PM451-1] Civ Long
								Else sysadm.FN_TRIM ( IsNull ( sysadm.FN_CODE_NUM ( sysadm.FN_TRIM (i.cod_civ), '-CI' ), '' ))
							End,
					@asNom = Case
								When i.cod_civ in ( 4, 5 ) Then ''
								Else Upper ( i.nom )
							End
			From   sysadm.w_inter i
			Where  i.id_sin = @adcIdSin
			And    i.id_i = @dcIdI
		End 

		-- [DT191-1]
		If @asCiv is null 
			Begin
			If @dcIdI = 0
				Begin
					Select @asCiv = Case
										When p.cod_civ in ( 4, 5 ) Then sysadm.FN_TRIM ( IsNull ( sysadm.FN_CODE_NUM ( 4, '-CL' ), '' )) -- [PM451-1] Civ Long
										Else sysadm.FN_TRIM ( IsNull ( sysadm.FN_CODE_NUM ( sysadm.FN_TRIM (p.cod_civ), '-CI' ), '' ))
									End,
							@asNom = Case
										When p.cod_civ in ( 4, 5 ) Then ''
										Else sysadm.SPB_FN_INIT_CAP
												(
												sysadm.FN_TRIM ( IsNull ( Upper ( Left  ( sysadm.FN_TRIM ( p.nom ), 1) ), '' )) +
												sysadm.FN_TRIM ( IsNull ( Lower ( Right ( sysadm.FN_TRIM ( p.nom ), Len ( p.nom ) - 1 ) ), '' )),
												null
												)
							End
					From   sysadm.sinistre s,
						sysadm.personne p
					Where  s.id_sin = @adcIdSin
					and    s.id_ordre = p.id_ordre
				End 
				Else
				Begin
					Select @asCiv = Case
										When i.cod_civ in ( 4, 5 ) Then sysadm.FN_TRIM ( IsNull ( sysadm.FN_CODE_NUM ( 4, '-CL' ), '' )) -- [PM451-1] Civ Long
										Else sysadm.FN_TRIM ( IsNull ( sysadm.FN_CODE_NUM ( sysadm.FN_TRIM (i.cod_civ), '-CI' ), '' ))
									End,
							@asNom = Case
										When i.cod_civ in ( 4, 5 ) Then ''
										Else Upper ( i.nom ) 
									End
					From   sysadm.inter i
					Where  i.id_sin = @adcIdSin
					and    i.id_i = @dcIdI
				End 
			End
	End

	Set    @asMailCc = ''

	-- #1 Armement de la boite mail
	If @aiOptionDP = 173
	Begin
		Select Top 1  @asBoiteMail = IsNull ( dp.val_car, '' ),
					@asMailFrom = sysadm.FN_CLE_VAL ( 'MAIL_FROM', IsNull ( dp.val_car, '' ), ';' )
		From   sysadm.det_pro dp
		Where  dp.id_prod = @adcIdProd
		and    dp.id_typ_code_dp = '-DP'
		and    dp.id_code_dp = @aiOptionDP
		and    sysadm.FN_CLE_VAL ( 'COD_INTER', rtrim ( val_car ) + rtrim ( val_car2 ), ';' ) = @sCodInter 
	End 
	Else
	Begin
		Select Top 1  @asBoiteMail = IsNull ( dp.val_car, '' ),
					@asMailFrom = sysadm.FN_CLE_VAL ( 'MAIL_FROM', IsNull ( dp.val_car, '' ), ';' )
		From   sysadm.det_pro dp
		Where  dp.id_prod = @adcIdProd
		and    dp.id_typ_code_dp = '-DP'
		and    dp.id_code_dp = @aiOptionDP
	End 		    

  Select @asBoiteMail = sysadm.FN_CLE_VAL ( @sRechBoiteMail, @asBoiteMail, ';' ) -- [SITE_CMDE]
  
  If @asMailFrom='' Set @asMailFrom=@asBoiteMail
  -- Code produit erroné
  If ( @adcIdProd Is Null Or @adcIdProd <= 0 ) Set @iRet = -1
  -- Lib produit erroné
  If @asLibProd Is Null Or sysadm.FN_TRIM ( @asLibProd ) = '' Set @iRet = -2
  -- Code ets erroné
  If @adcIdEts Is Null Or @adcIdEts <= 0 Set @iRet = -3
  --  Civilité erroné
  If @asCiv Is Null Or sysadm.FN_TRIM ( @asCiv ) = '' Set @iRet = -5
  
  --  Nom erroné
  -- [PM451-1]
  If ( @asNom Is Null Or sysadm.FN_TRIM ( @asNom ) = '') And ( @asCiv <> 'Madame, Monsieur') Set @iRet = -6

  --  E-mail erroné
  If @asMailSend Is Null Or sysadm.FN_TRIM ( @asMailSend ) = '' Set @iRet = -7
  --  Numéro du produit erroné
  -- If @asNumTelProd Is Null Or sysadm.FN_TRIM ( @asNumTelProd ) = '' set @iRet = -8
  If @asNumTelProd Is Null Or sysadm.FN_TRIM ( @asNumTelProd ) = '' set @asNumTelProd = '0232742020'  -- Suite souci d'envoi par mail... il faut un num_tel [VDOC30089]
  -- #1 Boite mail
  If @asBoiteMail Is Null Or Len ( sysadm.FN_TRIM ( @asBoiteMail ) ) <= 0 Set @iRet = -11

  -- [PM159][&]
  Set @asLibProd = Replace ( @asLibProd, ' & ', ' et ')
  Set @asLibProd = Replace ( @asLibProd, '& ', ' et ')
  Set @asLibProd = Replace ( @asLibProd, ' &', ' et ')
  Set @asLibProd = Replace ( @asLibProd, '&', ' et ')
  Set @asLibProd = REPLACE(@asLibProd, '"','&quot;')
  
  Set @asNom = Replace ( @asNom, ' & ', ' et ')
  Set @asNom = Replace ( @asNom, '& ', ' et ')
  Set @asNom = Replace ( @asNom, ' &', ' et ')
  Set @asNom = Replace ( @asNom, '&', ' et ')
  -- [PM159][&]

  Set @asXMLVar = '<commun id_sin="' + convert(varchar(10),@adcIdSin) + '" id_prod="' + convert(varchar(7), @adcIdProd) + '" code_produit="' + convert(varchar(7), @adcIdProd) + '" ' -- [PI062]
  Set @asXMLVar = @asXMLVar + 'lib_prod="' + sysadm.FN_TRIM ( REPLACE(@asLibProd, '"','&quot;') ) +'" '
  Set @asXMLVar = @asXMLVar + 'num_tel_prod="' + sysadm.FN_TRIM (@asNumTelProd)+ '" '
  Set @asXMLVar = @asXMLVar + ' id_ets="' + convert(varchar(7),@adcIdEts) +'" '
  Set @asXMLVar = @asXMLVar + ' civilite="' + sysadm.FN_TRIM (@asCiv) +'" '
  Set @asXMLVar = @asXMLVar + ' nom="' + sysadm.FN_TRIM (@asNom) +'" />'

  If @@Error <> 0 Return @@Error

  Return @iRet

Go


--------------------------------------------------------------------
--
-- Proc‚dure            :        PS_S01_RECUP_DONNEES_MAIL
-- Auteur               :       Fabry JF
-- Date                 :       19/05/2006
-- Libelle              :
-- Commentaires         :       Récupère toutes les données commune aux procédures PUSH
-- References           :
--
-- Arguments            :       @adcIdSin       Decimal (  7,0 )        (Val)
--  				@asBase 	VarChar (20)		(Val)
--				@aiOptionDP   	Integer			(Val)
--  				@adcIdProd     	Decimal (7)  		(Ref)
--  				@asLibProd     	VarChar (255) 		(Ref)
--  				@asIdEts 	Decimal (7)  		(Ref)
--  				@asCiv		VarChar (100) 		(Ref)
--  				@asNom		VarChar (50) 		(Ref)
--  				@asMailFrom	VarChar (128) 		(Ref)
--				@asMailSend	VarChar (128) 		(Ref)
--				@asMailCc	VarChar (128) 		(Ref)
--				@asAltQuarant	VarChar (1) 		(Ref)
--				@asBoiteMail    VarChar (35) 		(Ref)
--
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-------------------------------------------------------------------
-- #1	JFF	23/11/2006	Lot modification pour gestion de boîte différente + quelques autres modifs
-- #2	JFF	20/10/2008	[FNAC_PROD_ECH_TECH].[SMS]
-- #3 SBA	14/04/2010	[NUM_TEL_07]
-- 	FPI	13/10/2010	[VDoc1416] Modif texte libellé civité longue 4
-- JFF      29/02/2016   [DT191-1]
-- JFF      12/02/2016   [PI062]
-- JFF      06/11/2018   [PM451-1]
-- JFF      26/01/2021   [VDOC30089] problème d'envoi par mail suite absence de numtelprod
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_RECUP_DONNEES_MAIL' AND type = 'P' )
        DROP procedure sysadm.PS_S01_RECUP_DONNEES_MAIL
GO

CREATE procedure sysadm.PS_S01_RECUP_DONNEES_MAIL
  @adcIdSin     Decimal (10),  -- [PI062]
  @asBase 	VarChar (20),
  @aiOptionDP   Integer,
  @adcIdProd    Decimal (7)  OUTPUT, 
  @asLibProd    VarChar (255) OUTPUT, 
  @asNumTelProd    VarChar (20) OUTPUT,   
  @adcIdEts 	Decimal (7)  OUTPUT, 
  @asCiv	VarChar (100) OUTPUT, 
  @asNom	VarChar (50) OUTPUT, 
  @asMailFrom	VarChar (128) OUTPUT, 
  @asMailSend	VarChar (128) OUTPUT, 
  @asMailCc	VarChar (128) OUTPUT,
  @asAltQuarant	VarChar (1) OUTPUT,
  @asBoiteMail    VarChar (50) OUTPUT,
  @asAltSuiviSMS Varchar (1) OUTPUT, -- #2 [FNAC_PROD_ECH_TECH].[SMS]
  @asNumGsmSMS  Varchar (20) OUTPUT -- #2 [FNAC_PROD_ECH_TECH].[SMS]
  
AS  
  Declare @iRet	 Integer
  Declare @iTbPerm Integer
  Declare @iDeb Integer
  Declare @iFin Integer
  Declare @sRechBoiteMail VarChar ( 14 ) -- #1
  
  -- #1
  Set @sRechBoiteMail = 'BOITE_MAIL'

  Select @iTbPerm = Count (*)
  From   sysadm.sinistre s
  Where  s.id_sin = @adcIdSin
 
  Set @iRet = 0

  -- L'option permettant l'envoi est-elle défini dans det_pro ?
  If ( Select count (*) 
	   From sysadm.det_pro 
	   where id_prod = Case @iTbPerm
				When 1 Then IsNull ( ( Select id_prod From sysadm.sinistre s Where s.id_sin = @adcIdSin ), -1 )
				Else        IsNull ( ( Select id_prod From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  ), -1 )
				   End  
	   and id_typ_code_dp = '-DP' 
	   and id_code_dp = @aiOptionDP ) <= 0 
  Begin
	Return -9
  End 

  -- L'option de quarantaine pour le produit est-elle présente ?
  -- Le code de l'option de quarantaine est lié à l'option de déclenchement du mail.
  Select @asAltQuarant = 
	 Case 
	  When ( Select count (*)
		 From  sysadm.det_pro d2
		 where  d2.id_prod = d.id_prod
	  	 and    d2.id_typ_code_dp = d.id_typ_code_dp 
	  	 and    d2.id_code_dp = d.val_num
	  	 And    d2.id_code_car = '-1' -- Hors fournisseur
		) > 0 Then 'O'
	   Else 'N'
	 End 
  From   sysadm.det_pro d
  where  d.id_prod = Case @iTbPerm
       			When 1 Then IsNull ( ( Select id_prod From sysadm.sinistre s Where s.id_sin = @adcIdSin ), -1 )
       			Else        IsNull ( ( Select id_prod From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  ), -1 )
       		     End  
  and    d.id_typ_code_dp = '-DP' 
  and    d.id_code_dp = @aiOptionDP 

  -- Sommes-nous sur un serveur de production ?
  If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
    If Upper ( Right ( sysadm.FN_TRIM ( @asBase) , 4 ) ) <> '_PRO' Return -10

  -- Cas de l'option 51 où l'on force le select sur les table de travail
  If @aiOptionDP not in ( 51 )
  Begin 
	  Select @adcIdProd = sysadm.FN_TRIM ( s.id_prod ),
		 @asLibProd = sysadm.FN_TRIM ( p.lib_long ),
		 @adcIdEts  = s.id_ets,
		 @asNumTelProd = 
			sysadm.FN_TRIM (
			Case Left ( p.num_tel, 2 )
				When '08' Then Left ( p.num_tel, 1 ) + ' ' + SubString ( p.num_tel, 2, 3 ) + ' ' + SubString ( p.num_tel, 5, 3 ) + ' ' + SubString ( p.num_tel, 8, 3 )
				Else Left ( p.num_tel, 2 ) + ' ' + SubString ( p.num_tel, 3, 2 ) + ' ' + SubString ( p.num_tel, 5, 2 ) + ' ' + SubString ( p.num_tel, 7, 2 ) + ' ' + SubString ( p.num_tel, 9, 2 )
			End 
			)
	  From   sysadm.sinistre s,
		 sysadm.produit  p
	  Where  s.id_sin = @adcIdSin
	  and    p.id_prod = s.id_prod
  End 
  Else
  Begin
  	  Select @adcIdProd = sysadm.FN_TRIM ( s.id_prod ),
  		 @asLibProd = sysadm.FN_TRIM ( p.lib_long ),
  		 @adcIdEts  = s.id_ets,
  		 @asNumTelProd = 
  			sysadm.FN_TRIM (
  			Case Left ( p.num_tel, 2 )
  				When '08' Then Left ( p.num_tel, 1 ) + ' ' + SubString ( p.num_tel, 2, 3 ) + ' ' + SubString ( p.num_tel, 5, 3 ) + ' ' + SubString ( p.num_tel, 8, 3 )
  				Else Left ( p.num_tel, 2 ) + ' ' + SubString ( p.num_tel, 3, 2 ) + ' ' + SubString ( p.num_tel, 5, 2 ) + ' ' + SubString ( p.num_tel, 7, 2 ) + ' ' + SubString ( p.num_tel, 9, 2 )
  			End 
  			)
  	  From   sysadm.w_sin s,
  		 sysadm.produit  p
  	  Where  s.id_sin = @adcIdSin
	  and    p.id_prod = s.id_prod

	  -- [DT191-1]
		If @adcIdProd is null
		Begin
			Select @adcIdProd = sysadm.FN_TRIM ( s.id_prod ),
				@asLibProd = sysadm.FN_TRIM ( p.lib_long ),
				@adcIdEts  = s.id_ets,
				@asNumTelProd = 
				sysadm.FN_TRIM (
				Case Left ( p.num_tel, 2 )
					When '08' Then Left ( p.num_tel, 1 ) + ' ' + SubString ( p.num_tel, 2, 3 ) + ' ' + SubString ( p.num_tel, 5, 3 ) + ' ' + SubString ( p.num_tel, 8, 3 )
					Else Left ( p.num_tel, 2 ) + ' ' + SubString ( p.num_tel, 3, 2 ) + ' ' + SubString ( p.num_tel, 5, 2 ) + ' ' + SubString ( p.num_tel, 7, 2 ) + ' ' + SubString ( p.num_tel, 9, 2 )
				End 
				)
			From   sysadm.sinistre s,
				sysadm.produit  p
			Where  s.id_sin = @adcIdSin
			and    p.id_prod = s.id_prod
		End
  End 
  
  --DCMP 060532 - Lib produit destiné au client.
  Select @asLibProd = sysadm.FN_TRIM ( dp.val_car )
  From   sysadm.det_pro dp
  Where  dp.id_prod = @adcIdProd
  And 	 dp.id_typ_code_dp = '-DP' 
  And 	 dp.id_code_dp = 66
  And 	 dp.val_car is not null
  And 	 sysadm.FN_TRIM ( dp.val_car ) <> ''

  --DCMP 060532 - Lib produit destiné au client.
  Select @asLibProd = @asLibProd + ' / ' + sysadm.FN_TRIM ( dp.val_car )
  From   sysadm.det_pro dp
  Where  dp.id_prod = @adcIdProd
  And 	 dp.id_typ_code_dp = '-DP' 
  And 	 dp.id_code_dp = 67
  And 	 dp.val_car is not null
  And    Exists (
	  Select *
	  From   sysadm.det_pro dp2
	  Where  dp2.id_prod = @adcIdProd
	  And 	 dp2.id_typ_code_dp = '-DP' 
	  And 	 dp2.id_code_dp = 66 
	  And 	 dp2.val_car is not null
	  And 	 sysadm.FN_TRIM ( dp2.val_car ) <> ''
	  )

  
  Set    @asMailFrom = ''

  If @aiOptionDP not in ( 51 )
  Begin
	  Select @asMailSend = IsNull ( sysadm.FN_TRIM ( i.adr_mail ), '' ), 
		 @asAltSuiviSMS = IsNull ( sysadm.FN_TRIM ( i.alt_suivi_sms ), '' ), -- #2 [FNAC_PROD_ECH_TECH].[SMS]
  		 @asNumGsmSMS  = IsNull ( sysadm.FN_TRIM ( i.num_port_sms ), '' )-- #2	[FNAC_PROD_ECH_TECH].[SMS]
	  From   sysadm.inter i
	  Where  i.id_sin = @adcIdSin
	  and    cod_inter = 'A'
  End 
  Else
  Begin
  	  Select @asMailSend = IsNull ( sysadm.FN_TRIM ( i.adr_mail ), '' ),
		 @asAltSuiviSMS = IsNull ( sysadm.FN_TRIM ( i.alt_suivi_sms ), '' ), -- #2 [FNAC_PROD_ECH_TECH].[SMS]
  		 @asNumGsmSMS  = IsNull ( sysadm.FN_TRIM ( i.num_port_sms ), '' )-- #2	[FNAC_PROD_ECH_TECH].[SMS]
  	  From   sysadm.w_inter i
  	  Where  i.id_sin = @adcIdSin
	  and    cod_inter = 'A'

	  -- [DT191-1]
		If @asMailSend is null
		Begin
			Select @asMailSend = IsNull ( sysadm.FN_TRIM ( i.adr_mail ), '' ), 
				@asAltSuiviSMS = IsNull ( sysadm.FN_TRIM ( i.alt_suivi_sms ), '' ), -- #2 [FNAC_PROD_ECH_TECH].[SMS]
  				@asNumGsmSMS  = IsNull ( sysadm.FN_TRIM ( i.num_port_sms ), '' )-- #2	[FNAC_PROD_ECH_TECH].[SMS]
			From   sysadm.inter i
			Where  i.id_sin = @adcIdSin
			and    cod_inter = 'A'
		End 
  End 
	
  If @aiOptionDP not in ( 51 )
  Begin
	  Select @asCiv = Case 
				When p.cod_civ in ( 4, 5 ) Then sysadm.FN_TRIM ( IsNull ( sysadm.FN_CODE_NUM ( 4, '-CL' ), '' )) -- [PM451-1] Civ Long
				Else sysadm.FN_TRIM ( IsNull ( sysadm.FN_CODE_NUM ( sysadm.FN_TRIM (p.cod_civ), '-CI' ), '' ))  
			  End,
		 @asNom = Case
				When p.cod_civ in ( 4, 5 ) Then '' 
				Else sysadm.SPB_FN_INIT_CAP
				     (
				     sysadm.FN_TRIM ( IsNull ( Upper ( Left  ( sysadm.FN_TRIM ( p.nom ), 1) ), '' )) +
				     sysadm.FN_TRIM ( IsNull ( Lower ( Right ( sysadm.FN_TRIM ( p.nom ), Len ( p.nom ) - 1 ) ), '' )),
				     null
				     )
			  End 
	  From   sysadm.sinistre s,
		 sysadm.personne p
	  Where  s.id_sin = @adcIdSin
	  and    s.id_ordre = p.id_ordre
  End 
  Else
  Begin
	  Select @asCiv = Case 
				When s.cod_civ in ( 4, 5 ) Then sysadm.FN_TRIM ( IsNull ( sysadm.FN_CODE_NUM ( 4, '-CL' ), '' )) -- [PM451-1] Civ Long
				Else sysadm.FN_TRIM ( IsNull ( sysadm.FN_CODE_NUM ( sysadm.FN_TRIM (s.cod_civ), '-CI' ), '' ))  
			  End,
		 @asNom = Case
				When s.cod_civ in ( 4, 5 ) Then '' 
				Else sysadm.SPB_FN_INIT_CAP
				     (
				     sysadm.FN_TRIM ( IsNull ( Upper ( Left  ( sysadm.FN_TRIM ( s.nom ), 1) ), '' )) +
				     sysadm.FN_TRIM ( IsNull ( Lower ( Right ( sysadm.FN_TRIM ( s.nom ), Len ( s.nom ) - 1 ) ), '' )),
				     null
				     )
			  End 
	  From   sysadm.w_sin s
	  Where  s.id_sin = @adcIdSin

	  -- [DT191-1]
		If @asCiv is null
		Begin
			Select @asCiv = Case 
					When p.cod_civ in ( 4, 5 ) Then sysadm.FN_TRIM ( IsNull ( sysadm.FN_CODE_NUM ( 4, '-CL' ), '' )) -- [PM451-1] Civ Long
					Else sysadm.FN_TRIM ( IsNull ( sysadm.FN_CODE_NUM ( sysadm.FN_TRIM (p.cod_civ), '-CI' ), '' ))  
					End,
				@asNom = Case
					When p.cod_civ in ( 4, 5 ) Then '' 
					Else sysadm.SPB_FN_INIT_CAP
							(
							sysadm.FN_TRIM ( IsNull ( Upper ( Left  ( sysadm.FN_TRIM ( p.nom ), 1) ), '' )) +
							sysadm.FN_TRIM ( IsNull ( Lower ( Right ( sysadm.FN_TRIM ( p.nom ), Len ( p.nom ) - 1 ) ), '' )),
							null
							)
					End 
			From   sysadm.sinistre s,
				sysadm.personne p
			Where  s.id_sin = @adcIdSin
			and    s.id_ordre = p.id_ordre
		End
  End 
  
  
  Set    @asMailCc = ''

  -- #1 Armement de la boite mail
  Select @asBoiteMail = IsNull ( dp.val_car, '' ),
	@asMailFrom = sysadm.FN_CLE_VAL ( 'MAIL_FROM', IsNull ( dp.val_car, '' ), ';' )
  From   sysadm.det_pro dp
  Where  dp.id_prod = @adcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = @aiOptionDP 

  Select @asBoiteMail = sysadm.FN_CLE_VAL ( @sRechBoiteMail, @asBoiteMail, ';' ) -- [SITE_CMDE]
  
/*
  Set @iDeb = CharIndex ( @sRechBoiteMail, @asBoiteMail, 1 ) 

  if @iDeb > 0 
   Begin
     Set @iDeb = @iDeb + Len ( @sRechBoiteMail )
     Set @iFin = CharIndex ( ';', @asBoiteMail, @iDeb ) - 1
     if @iFin <= 0 Set @iFin = Len ( @asBoiteMail )
     
     if @iFin > 0 
      Begin
        Set @asBoiteMail = Substring ( @asBoiteMail, @iDeb, @iFin - @iDeb + 1 )
      End
   End 
*/
  -- Fin #1
  
  -- Code produit erroné
  If ( @adcIdProd Is Null Or @adcIdProd <= 0 ) Set @iRet = -1
  -- Lib produit erroné
  If @asLibProd Is Null Or sysadm.FN_TRIM ( @asLibProd ) = '' Set @iRet = -2  
  -- Code ets erroné
  If @adcIdEts Is Null Or @adcIdEts <= 0 Set @iRet = -3  
  --  Civilité erroné
  If @asCiv Is Null Or sysadm.FN_TRIM ( @asCiv ) = '' Set @iRet = -5  
  
  --  Nom erroné
	   -- [PM451-1]
  If ( @asNom Is Null Or sysadm.FN_TRIM ( @asNom ) = '') And ( @asCiv <> 'Madame, Monsieur') Set @iRet = -6

 --  E-mail erroné
  If @asMailSend Is Null Or sysadm.FN_TRIM ( @asMailSend ) = '' Set @iRet = -7
  --  Numéro du produit erroné
  -- If @asNumTelProd Is Null Or sysadm.FN_TRIM ( @asNumTelProd ) = '' set @iRet = -8
  If @asNumTelProd Is Null Or sysadm.FN_TRIM ( @asNumTelProd ) = '' set @asNumTelProd = '0232742020'  -- Suite souci d'envoi par mail... il faut un num_tel [VDOC30089]
    -- #1 Boite mail
  If @asBoiteMail Is Null Or Len ( sysadm.FN_TRIM ( @asBoiteMail ) ) <= 0 Set @iRet = -11
  -- #2	[FNAC_PROD_ECH_TECH].[SMS]
  -- [NUM_TEL_07]	
  If Len ( @asNumGsmSMS ) <> 10 And Left ( @asNumGsmSMS, 2 ) not in ('06','07') Set @asNumGsmSMS = ''
  -- #2	[FNAC_PROD_ECH_TECH].[SMS]
  -- [NUM_TEL_07]
  If Len ( @asNumGsmSMS ) = 10 And Left ( @asNumGsmSMS, 2 ) in ('06','07') Set @asNumGsmSMS = '+33' + Right ( @asNumGsmSMS, 9 )


  If @@Error <> 0 Return @@Error

  Return @iRet

Go   

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S02_MAILPUSH_RECP_APP_EN_CTR
-- Auteur               :       Fabry JF
-- Date                 :       19/05/2006
-- Libelle              :
-- Commentaires         :       Détection de l'arrivée de l'appareil endommagé chez le CTR et préparation du mail.
--				C'est au client appelant cette PS de déterminer s'il y a ou pas réception d'appareil chez le CTR.
--
--						SQL Agent : SIMPA2_PRO : Extraction PM254 Label FG2A Relance Non Rcpt Mat
--
--
-- References           :
--
-- Arguments            :       @asIdAppli	varchar (20)		(val) Nom de l'application mère éxécutant la PS
--				@asBase		varchar (20)		(val) Nom de la base de données SHERPA ou SIMPA2
--				@adcIdSin       Decimal (  7,0 )        (Val)
--				@aiIdSeq	Integer		        (Val)
--				@adtDteRcpFrn   DateTime		(val)
--				@asCasRetour    VarChar (50)		(ref) Cas : MAIL_ENVOYE
--										    OPTION_DP_NON_PARAM
--										    HORS_BASE_DE_PRODUCTION
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-- #1	JFF  	03/07/2006  suite mail de C.Rigal le 30/06/2006
-- #2	JCA	23/10/2006  DCMP 060778 changement adresse Cordon
-- #3   JFF	23/11/2006  Lot modification pour gestion de boîte différente + quelques autres modifs
-- #4   JFF     28/04/2008  [DCMP080202]
-- #5	JFF	21/01/2008  [FNAC_PROD_ECH_TECH].[SMS]
-- #6	JFF	20/10/2008  [FNAC_PROD_ECH_TECH].[20090127140540720]
-- #7	JFF	20/10/2008  [FNAC_PROD_ECH_TECH].[20090223142259343]
-- #8	JFF	20/10/2008  [CAMARA].[SMS]
-- #9   JFF     02/09/2009  [DCMP090327].[SBETV]
-- #10  JFF     24/09/2009  [GOSPORT].[SMS]
-- #11  JFF     11/12/2009  [MSS_DIAG]
-- #12  JFF     02/03/2010  [MSS_LOT2]
--      JFF     03/06/2010  [PC397/443_IPAD]
--      JFF     10/06/2010  [PC419/440/418/439_MICROMANIA]
-- 	JFF	12/07/2010  [PC363_AUCHAN]
-- 	JFF	26/07/2011  [PC292][AUCHAN]
--      JFF     21/08/2011  [BLCODE]
--      JFF     26/11/2012  [PC877]
--      JFF     14/12/2012  [MANTIS6204]
--      JFF     20/02/2013  [PC913]
--      JFF     07/05/2013  [PC938_ORANGE_V3]
--      JFF     13/01/2014  [PM246]
--      JFF     05/02/2014  [PC13348][MANTIS9976]
--      JFF     01/07/2014  [PM246-2_GPS_OV3]
--      JFF     16/09/2014  [PM250-2]
--      JFF     09/04/2015  [DT141]
--      JFF     19/05/2015  [PC13442-1][MANTIS15247]
--      JFF     13/07/2015  [PC151270_ORANGE_V3]
--      JFF     13/04/2016  [DT200][MANTIS20301]
--      JFF     17/05/2016  [PM280-2]
--		JFF     12/02/2016  [PI062]
--      JFF     17/05/2016  [VDOC21599]
--		JFF     28/09/2016  [DT262]
--		JFF     06/10/2016  [PC13321]
--      JFF     15/05/2019  [DT386_EXTR_AXA]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S02_MAILPUSH_RECP_APP_EN_CTR' AND type = 'P' ) 
        DROP procedure sysadm.PS_S02_MAILPUSH_RECP_APP_EN_CTR
GO


CREATE procedure sysadm.PS_S02_MAILPUSH_RECP_APP_EN_CTR
	@asIdAppli	varchar (20),
	@asBase		varchar (20),
	@adcIdSin      	Decimal (10), -- [PI062]
	@aiIdSeq      	Integer,
	@adtDteRcpFrn   DateTime,
	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @sSaut	VarChar (10), 
  @sMarque	VarChar (35),
  @sModele	VarChar (35),  
  @sIdFour	VarChar (10),
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @iPRS		Integer,
  @iOptionDP    Integer,
  @dtDteRcpFrnActuel DateTime,
  @dtDteGenCmde DateTime,
  @sBoiteMail    VarChar (35),
  @iVarianteMail Integer, -- #4 [DCMP080202]
  @iVarianteSMS  Integer, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  @iInfoSpbFrn   Integer, -- #4 [DCMP080202]
  @sIdRefFour    VarChar ( 35 ), -- #4 [DCMP080202]
  @sSmsBody     VarChar ( 255 ), -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  @sTopSMS	Integer, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  @sVal		VarChar ( 70 ), -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  @sAltSuiviSMS VarChar ( 1 ),  -- #5 [FNAC_PROD_ECH_TECH].[SMS]  
  @sNumGsmSMS   VarChar ( 20 ),  -- #5 [FNAC_PROD_ECH_TECH].[SMS]  
  @sLogin VarChar ( 10 ),  -- #5 [FNAC_PROD_ECH_TECH].[SMS]  
  @sMdPasse VarChar ( 10 ),  -- #5 [FNAC_PROD_ECH_TECH].[SMS]  
  @sCodeTrt VarChar ( 10 ),  -- #5 [FNAC_PROD_ECH_TECH].[SMS]  
  @iLongMaxSMS Integer, -- #5 [FNAC_PROD_ECH_TECH].[SMS]  
  @iIdBoutique 	Integer, -- #6 [FNAC_PROD_ECH_TECH].[20090127140540720]
  @iOrangeV3	Integer, -- [PM246]
  @sIdTypArt	VarChar ( 3 ), -- [PM246]
  @sInfoSpbFrnCplt VarChar ( 800 ), -- [PM250-2]
  @PiedDePage_SiVotreContratDispo VarChar (20 ) -- [DT386_EXTR_AXA]
    
  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  Set @iPRS = 0
  Set @asIdAppli = Upper ( @asIdAppli )
  Set @sTopSMS = 0 -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  Set @sVal = ''
  Set @sSmsBody = ''
  Set @iLongMaxSMS = 160 -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  Set @PiedDePage_SiVotreContratDispo = 'A_AFFICHER' -- [DT386_EXTR_AXA]
  
  -- Option de déclenchement du mail -DP
  Set @iOptionDP = 49

  If @adtDteRcpFrn is null
   Begin
		Set @asCasRetour = 'PARAM_NON_RENSEIGNES'
		Return 0
   End 

  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@asBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT,  
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #3
	@sAltSuiviSMS OUTPUT, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #5 [FNAC_PROD_ECH_TECH].[SMS]

-- [PC13442-1][MANTIS15247]
If Exists ( 
	Select  Top 1 1
	From	sysadm.det_pro dp,
			sysadm.sinistre s
	Where   s.id_sin = @adcIdSin
	And		dp.id_prod = s.id_prod
	And     dp.id_code_dp = 274
)
Begin
	Set @asCasRetour = 'CAS_MOBILZEN2'
	Return 0
End
  

-- [PM246]
-- [PC151270_ORANGE_V3]
	Select @iOrangeV3 = COUNT ( * ) 
	From   sysadm.det_pro d,
		   sysadm.sinistre s
	where  s.id_sin = @adcIdSin
	And    d.id_prod = s.id_prod
	And    d.id_code_dp = 94
	And    sysadm.FN_CLE_VAL ( 'COD_DW', rtrim ( val_car ), ';') in ( 'ORANGE_V3', 'ORANGE_V2BIS', 'ORANGE_V3BIS', 'ORANGE_V3TER')

	If @iOrangeV3 is null Set @iOrangeV3 = 0

-- #5 [FNAC_PROD_ECH_TECH].[SMS] On ne plus gère cette erreur à ce moment (il peut y avoir du SMS à envoyer). 
  If @iRet = -7 
    Begin
		If @iOrangeV3 > 0 
		 Begin
			-- Le but pour Orange V3 et de toujours mettre une adresse mail si l'adresse réél n'est pas là, pour justement
			-- déclencher l'échec de distribution et donc envoyer le courrier en automatique.
			Set @sMailSend = 'DeclEchecDistrib@spb.fr'
			Set @iRet = 0			
		 End
		Else
		 Begin
--				 Set @iRet = 0
			 Set @asCasRetour = 'ADRESSE_MAIL_ABSENTE'
			 Return 0
		 End 
	End
   
  -- Cas de retour n'étant pas des erreurs
  If @iRet in ( -9, -10 )
   Begin
	Select @asCasRetour =
	Case @iRet
--		When -7 Then 'ADRESSE_MAIL_ABSENTE' -- #5 [FNAC_PROD_ECH_TECH].[SMS] ne plus retourner cette erreur à ce moment
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

  -- Problème suite éxécution
  If @iRet <> 0 Return @iRet

  -- de quel fournisseur s'agit-il ?
  -- S'agit d'une réparation ?
  Select @sIdFour = sysadm.FN_TRIM ( c.id_four ),
	 @iPRS = 
	 Case c.id_typ_art
		When 'PRS' Then 1  -- #4 [DCMP080202]
		When 'EDI' Then 1  -- #4 [DCMP080202]
		When 'REL' Then 1  -- #4 [DCMP080202]		
		When 'PST' Then 1  -- [PM250-2]
		Else 0 
 	 End,
 	 @dtDteGenCmde = c.cmd_gen_le,
 	 @sIdTypArt = c.id_typ_art, -- [PM246]
 	 @sInfoSpbFrnCplt = c.info_spb_frn_cplt -- [PM250-2]
  From   sysadm.commande c
  Where  c.id_sin = @adcIdSin
  And    c.id_seq = @aiIdSeq
  -- Sécurité pour forcer la recherche sur une réparation -- #4 [DCMP080202] -- [PC938_ORANGE_V3]
  And    ( c.id_typ_art in ( 'PRS', 'EDI', 'REL' )  
		  Or -- [PM250-2]
		   ( c.id_typ_art in ( 'PST' ) And sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim ( c.info_spb_frn_cplt), ';'  ) = 'PRET' )
		  )

  -- Recherche supplèmentaire pour détection de a quarantaine par fournisseur.  
  If @sAltQuarant = 'N' 
   Begin
	  -- Le code de l'option de quarantaine est lié à l'option de déclenchement du mail.
	  Select @sAltQuarant = 
		 Case 
		   When d2.id_prod > 0 Then 'O'
		   Else 'N'
		 End 
	  From   sysadm.det_pro d,
		 sysadm.det_pro d2
	  where  d.id_prod = @dcIdProd
	  and    d.id_typ_code_dp = '-DP' 
	  and    d.id_code_dp = @iOptionDP 
	  and    d2.id_prod = d.id_prod
	  and    d2.id_typ_code_dp = '-DP'  
	  and    d2.id_code_dp = d.val_num
	  And    d2.id_code_car = @sIdFour 
   End 

 -- Est-ce une réparation
  If @iPRS is null Set @iPRS = 0
  If @iPRS = 0 
   Begin
     Set @asCasRetour = 'HORS_REPARATION'
     Return 0
   End   

 -- DCMP 060454 -- [PC938_ORANGE_V3]
  If @adtDteRcpFrn <= DateAdd ( day, -1, @dtDteGenCmde )
   Begin
     Set @asCasRetour = 'DATE_INCOHERENTE'
     Return 0
   End

  -- Sommes-nous dans le cas d'une réception fournisseur ?
  Select @dtDteRcpFrnActuel = c.dte_rcp_frn,
	 --@sMarque = IsNull ( sysadm.FN_TRIM ( c.id_marq_art ), '') , -- #4 [DCMP080202] lu plus loin
	 --@sModele = IsNull ( sysadm.FN_TRIM ( c.id_modl_art ), '')   -- #4 [DCMP080202] lu plus loin
  	 @iInfoSpbFrn = c.info_spb_frn, -- #4 [DCMP080202]
  	 @sIdRefFour = c.id_ref_four, -- #4 [DCMP080202]
     @sAltQuarant = Convert ( Varchar (5), c.id_seq) -- [PM246]  	 

  From   sysadm.commande c
  Where  c.id_sin = @adcIdSin
  And    c.id_seq = @aiIdSeq
  -- Sécurité pour forcer la recherche sur une réparation -- #4 [DCMP080202] -- [PC938_ORANGE_V3]
  And    ( c.id_typ_art in ( 'PRS', 'EDI', 'REL' )  
		  Or -- [PM250-2]
		   ( c.id_typ_art in ( 'PST' ) And sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim ( c.info_spb_frn_cplt), ';'  ) = 'PRET' )
		  )


  Select   @sMarque = IsNull ( sysadm.FN_TRIM ( s.marq_port ), '') , -- #4 [DCMP080202]
	   @sModele = IsNull ( sysadm.FN_TRIM ( s.modl_port ), '') ,  -- #4 [DCMP080202]
	   @iIdBoutique = s.id_orian_boutique -- #6 [FNAC_PROD_ECH_TECH].[20090127140540720]	   
  From     sysadm.sinistre s
  Where   s.id_sin = @adcIdSin

  -- La date actuelle lu de la base n'est pas nulle, donc le téléphon a déjà été réceptionner.
  -- Même si la date passée en paramètre est différente de celle lu en base, on ne revoit pas d'e-mail
  If @dtDteRcpFrnActuel is not null 
   Begin
	Set @asCasRetour = 'DTE_RCP_FRN_DEJA_PRESENTE'
	Return 0
   End 

  -- #4 #5 [FNAC_PROD_ECH_TECH].[SMS]
  -- Rappel des variantes mail :
  --> Variante 1 : Cas pour toute la téléphonie, réception chez répateur.
  --> Variante 2 : Cas pour O2M, réception chez CTDiagnostic (réponse vers l'assuré)
  --> Variante 3 : Cas pour O2M, réception chez CTDiagnostic (réponse vers FNAC)
  
  -- Rappel des variantes SMS :
  --> Variante 1 : Cas pour O2M, réception chez CTDiagnostic avec envoi SMS

 
  Select @iVarianteMail = Case  -- #9 [DCMP090327].[SBETV] 1110
  				-- #11 [MSS_DIAG]
  				-- #12 [MSS_LOT2] supp 1238, 1256, 1235
  				-- [PC363_AUCHAN]
  				-- [PC419/440/418/439_MICROMANIA]
  				-- [BLCODE]
  				-- [PC913]

				WHen @sIdFour in ( 'O2M' ) And @sIdRefFour = 'A_DIAGNOSTIQUER' And sysadm.FN_CLE_VAL ( 'BUYBACK', @sInfoSpbFrnCplt, ';' ) = 'OUI' And @iInfoSpbFrn in ( 912) Then 9 -- -- JFF      15/05/2019   [DT386_EXTR_AXA] BUYBACK

  				When @sIdRefFour = 'CONTEST_SUR_REMPL' -- [PM280-2]
  				     Then 8 

				 -- [DT200][MANTIS20301]
  				When Exists (	Select Top 1 1
								From   sysadm.commande c
								Where	c.id_sin = @adcIdSin
								And		c.id_seq = @aiIdSeq
								And     sysadm.FN_CLE_VAL ( 'NE_PAS_REPARER', c.info_spb_frn_cplt, ';' ) = 'OUI' 
							)
						Then 3
				   

  				-- [PM246] Je mets OrangeV3 en premier !
  				When ( @iOrangeV3 > 0 And @sIdTypArt = 'PRS' And @iInfoSpbFrn not in ( 984 ) ) -- [DT290]
  					  Then 6

  				-- [PM250-2] Je mets OrangeV3 en premier !
  				When ( @iOrangeV3 > 0 And @sIdTypArt = 'PST' And sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim ( @sInfoSpbFrnCplt ), ';'  ) = 'PRET' ) 
  					  Then 7
  					  
  				-- [PC13348][MANTIS9976]
  				-- [DT141]
  				When @sIdFour in ( 'O2M', 'SB1', 'MS1', 'BLC', 'MTT', 'SBE' )
  				     And ( @iInfoSpbFrn in ( 410, 415, 905, 907, 910, 912, 915, 920, 925, 
  				     			     930, 935, 936, 937, 940, 941, 942, 955, 1110, 
  				     			     1234, 1236, 1237, 1255, 961, 962, 963, 964, 956,
  				     			     908, 913, 938, 943, 909, 914, 939, 944, 951, 952, 953, 967, 968, 976, 977, 981)) -- [PM250-2]
  				     			     
  				     And @sIdRefFour in ( 'A_DIAGNOSTIQUER' ) 
  				     Then 2

				-- #9 [DCMP090327].[SBETV] 1115  				     
  				-- #11 [MSS_DIAG]		
  				-- #12 [MSS_LOT2] supp 1261
  				When @sIdFour in ( 'O2M', 'SB1', 'MS1' ) -- #6 [FNAC_PROD_ECH_TECH].[20090127140540720]
  				     And ( @iInfoSpbFrn in ( 945, 950, 960, 906, 911, 1115,
  				     			     1240, 1260, 1261  ) ) ---#7	[FNAC_PROD_ECH_TECH].[20090223142259343]
  				     And @sIdRefFour = 'A_DIAGNOSTIQUER' 
  				     Then 3
  				     
				-- #10 [GOSPORT].[SMS]  				
  				When @sIdFour in ( 'O2M') 
  				     And ( @iInfoSpbFrn between 402 and 429 ) 
  				     And @sIdRefFour = 'A_DIAGNOSTIQUER' 
  				     And (Select count (*) from sysadm.det_pro d where d.id_prod = @dcIdProd 
  				     and d.id_code_dp in ( 120 ) ) > 0 
  				     Then 4
  	
  				-- [PC938_ORANGE_V3]			     
  				When @sIdFour in ( 'PSM') 
  				     And @iInfoSpbFrn in ( 2135, 2136 )   
  				     Then 5
  				
  				-- [BLCODE]
				-- [PC13321] 957 suite retour Julien JZQ.
				-- [DT290] 984
  				When @iInfoSpbFrn in ( 902, 1102, 1202, 1502, 957, 984 ) 
  				     Then 0
  				
  				Else 1
  			  End   

  If @iVarianteMail = 0 
   Begin
	Set @asCasRetour = 'MAIL_ENVOYE'
	Return 0
   End 

  Select @iVarianteSMS  = Case
  				When @sIdFour in ( 'O2M') 
  				     And ( @iInfoSpbFrn between 402 and 429 ) -- #10 [GOSPORT].[SMS]
  				     And @sIdRefFour = 'A_DIAGNOSTIQUER' 
  				     And (Select count (*) from sysadm.det_pro d where d.id_prod = @dcIdProd 
  				     and d.id_code_dp in ( 120 ) ) > 0 
  				     Then 2 
  				
  				When @sIdFour in ( 'O2M', 'SB1', 'MS1' ) 
  				     And ( ( @iInfoSpbFrn between 903 and 989 ) 
  				     	Or ( @iInfoSpbFrn between 1103 and 1189 ) -- #9 [DCMP090327].[SBETV]
  				     	Or ( @iInfoSpbFrn between 1203 and 1289 ) -- #11 [MSS_DIAG]
  				     	Or ( @iInfoSpbFrn between 402 and 429 )
  				     	) 
  				     And @sIdRefFour = 'A_DIAGNOSTIQUER' 
  				     Then 1 
				
				-- [PC397/443_IPAD]  				     
				When @sIdFour in ( 'O2M')  -- Réparation
				     And ( @iInfoSpbFrn between 1002 and 1098 ) -- 
  				     Then 3
  				     
  				-- [PC938_ORANGE_V3]			     
  				When @sIdFour in ( 'PSM') 
  				     And @iInfoSpbFrn in ( 2135, 2136 )   
  				     Then 4  				     
  				     
  				Else 3 -- [PC877] 3 ald 0
  			  End   

--------------------------------------------------------------------------------------------------------------------
-- Construction du mail.
--------------------------------------------------------------------------------------------------------------------


  -- Gestion de la civilité "Madame, Monsieur"
  If @sNom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sNom + ','
   End 

--------------------------------------------------------------------------------------------------------------------
  -- Armement de l'objet du mail
  If @iVarianteMail in ( 3 ) -- #6 [FNAC_PROD_ECH_TECH].[20090127140540720] (SAV FNAC !!)
   Begin
    Set @sMailObjet = 'Dossier de sinistre SPB n°' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) + ' ' + @sLibProd  -- [PI062]
   End
  Else
   Begin  
    Set @sMailObjet = 'Votre dossier n°' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) + ' ' + @sLibProd -- [PI062]
   End 

--------------------------------------------------------------------------------------------------------------------
  -- Armement du corps du mail
  If @iVarianteMail in ( 1 ) 
   Begin
	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	
	Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer de la réception de votre appareil ' + @sMarque + ' ' + @sModele + ' dans notre centre de réparation concernant votre dossier de sinistre.' --  dommage accidentel [MANTIS6204]
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Votre appareil est actuellement en réparation, nous vous informerons du diagnostic du réparateur ultérieurement.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d''agréer, ' + @sCiv + ' nos salutations distinguées.'
   End

  If @iVarianteMail in ( 2 ) -- #4 [DCMP080202] 
   Begin
	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer de la réception de votre appareil ' + @sMarque + ' ' + @sModele + ' dans notre centre de diagnostic concernant votre sinistre.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous vous informerons du résultat ultérieurement.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d''agréer, ' + @sCiv + ' nos salutations distinguées.'
   End

  If @iVarianteMail in ( 8 ) -- [PM280-2]
   Begin
	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer de la réception de votre appareil ' + @sMarque + ' ' + @sModele + ' concernant votre contestation suite à votre remplacement.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous vous informerons ultérieurement.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
   End


  If @iVarianteMail in ( 3 ) -- #6 [FNAC_PROD_ECH_TECH].[20090127140540720] (Destiné  à la boutique).
   Begin
	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer de la réception de l''appareil ' + @sMarque + ' ' + @sModele + ' dans notre centre de diagnostic concernant le sinistre cité en objet.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut

   End

-- #10 [GOSPORT].[SMS]
  If @iVarianteMail in ( 4 ) 
   Begin
	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer de la réception de votre vêtement ' + @sMarque + ' ' + @sModele + ' dans notre centre de diagnostic concernant votre sinistre.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous vous informerons du résultat ultérieurement.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
   End
  
  
  If @iVarianteMail in ( 5 ) -- [PC938_ORANGE_V3]
   Begin
	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer de la réception de votre appareil de remplacement dans la boutique PSM dont l''adresse vous a été donnée sur notre précédent mail.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Vous pouvez venir le chercher quand vous le souhaitez.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
   End
 
  -- [PM246]
  If @iVarianteMail in ( 6 ) 
   Begin
	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	
	Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer de la réception de votre appareil ' + @sMarque + ' ' + @sModele + ' dans notre centre de réparation concernant votre dossier de sinistre.' --  dommage accidentel [MANTIS6204]
	
	-- [PM246-2_GPS_OV3]
	Set @sMailBody  = @sMailBody  + ' Votre dossier est considéré complet si toutes les pièces demandées ont bien été adressées et l''appareil est conforme aux références dans nos bases.'
	-- [PM246-2_GPS_OV3]
	
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Sauf indication contraire de notre part suite au diagnostic du réparateur, nous procéderons à la réparation de votre appareil.'

	-- [PM246-2_GPS_OV3]
	-- [VDOC21599]
	Set @sMailBody  = @sMailBody  + ' Cette réparation est généralement effectuée sous 10 jours au plus.'

	-- [PM246-2_GPS_OV3]
		
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
   End

  -- [PM250-2]
  If @iVarianteMail in ( 7 ) 
   Begin
	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	
	Set @sMailBody  = @sMailBody  + 'Nous vous confirmons la réception de votre appareil de prêt dans notre centre, clôturant ainsi votre dossier ' + Convert ( VarChar ( 20 ), @adcIdSin ) + '.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
   End

-- [DT386_EXTR_AXA]
  If @iVarianteMail in ( 9 ) 
   Begin

    Set @PiedDePage_SiVotreContratDispo = 'A_NE_PAS_AFFICHER' -- [DT386_EXTR_AXA]    

	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	
	Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer de la réception de votre bien de marque ' + @sMarque + ' dans notre centre de diagnostic concernant votre sinistre.' + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous vous informerons du résultat ultérieurement.' + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
   End

  
--------------------------------------------------------------------------------------------------------------------
-- Pied du mail

  If @PiedDePage_SiVotreContratDispo = 'A_AFFICHER' -- [DT386_EXTR_AXA]
    Begin
	  Set @sMailBody  = @sMailBody  + @sSaut
	  Set @sMailBody  = @sMailBody  + @sSaut
	  Set @sMailBody  = @sMailBody  + 'Si votre contrat d''assurance dispose d''un site web de gestion de sinistre, vous pouvez à tout moment consulter et télécharger la ou les pièce(s) de votre dossier sur ce site communiqué par notre gestionnaire lors de votre déclaration.'
    End 
  
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'
  
/* -- #1  JFF  03/07/2006  suite mail de C.Rigal le 30/06/2006
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Pour joindre SPB, composez le ' + @sNumProd + '.' 
*/  

--------------------------------------------------------------------------------------------------------------------
-- Modification adresse spéciale selon variantes mail
  If @iVarianteMail in ( 3 ) -- #6 [FNAC_PROD_ECH_TECH].[20090127140540720]
   Begin
     -- On change le mail Send pour cette variante
     -- NB : adr_mail est bien le mail SAV, pour le mail des remplacement, c'est adr_mail2 à ne pas utiliser ici
     
     Select @sMailSend = sysadm.FN_TRIM ( b.adr_mail )
     From   sysadm.boutique b
     Where  b.id_prod = @dcIdProd
     And    b.id_boutique = @iIdBoutique 

     If @sMailSend is null or @sMailSend = ''
     	Begin 
     		Set @asCasRetour = 'ADRESSE_MAIL_ABSENTE'
     		Return 0
     	End 
   End 

--------------------------------------------------------------------------------------------------------------------
-- Gestion des SMS.
--------------------------------------------------------------------------------------------------------------------
  If @iVarianteSMS between 1 and 100 -- #5 [FNAC_PROD_ECH_TECH].[SMS]
   Begin
	Set @sTopSMS = 1 

	-- 1/ Confirmation réception appareil en atelier : 
	-- Récup lib produit -DP/66
	Select @sVal = IsNull ( sysadm.FN_TRIM ( d.val_car ), '')
	From   sysadm.det_pro d
	Where  d.id_prod = @dcIdProd
	And    d.id_code_dp = 228 -- [PC877] 228 ald 66

	If @sVal is null Or sysadm.FN_TRIM (@sVal) = '' Set @sVal = ''
	If Len ( @sVal ) > 0 Set @sVal = @sVal + '.'

	If @iVarianteSMS = 1
	  Begin
	    Set @sSmsBody = @sVal + 'Nous avons reçu votre appareil ' + @sMarque + ' ' + @sModele + ' et allons procéder au diagnostic.'
	  End

	-- #10 [GOSPORT].[SMS]
	If @iVarianteSMS = 2
	  Begin
	    Set @sSmsBody = @sVal + 'Nous avons reçu votre vêtement ' + @sMarque + ' ' + @sModele + ' et allons procéder au diagnostic.'
	  End

	-- [PC397/443_IPAD]  		  
	If @iVarianteSMS = 3
	  Begin
	    Set @sSmsBody = @sVal + 'Nous avons reçu votre appareil ' + @sMarque + ' ' + @sModele + ' et allons procéder à sa réparation.'
	  End	  

    -- [PC938_ORANGE_V3]
	If @iVarianteSMS = 4
	  Begin
	    Set @sSmsBody = @sVal + 'Vous pouvez passer en boutique PSM chercher votre appareil de remplacement.'
	  End	  

	
   End


--------------------------------------------------------------------------------------------------------------------
-- Préparation et envoi des données.
--------------------------------------------------------------------------------------------------------------------

  -- On convertit pour l'appel de la PS
  Set @iIdSin  = Convert ( integer, @adcIdSin )
  Set @iIdProd = Convert ( integer, @dcIdProd )
  Set @iIdEts  = Convert ( integer, @dcIdEts )

  -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  If @sTopSMS = 1 
    Begin
	 -- [PC877] -- [PC938_ORANGE_V3]
		If @sNumGsmSMS is null Or sysadm.FN_TRIM ( @sNumGsmSMS ) = '' 
		 Begin
	 		Select @sNumGsmSMS = Case 
	 					When i.num_teld is not null Then i.num_teld
	 					When s.num_port is not null Then s.num_port
	 					 End
		 	      
	 		From   	sysadm.sinistre s, 
	 	 		sysadm.inter i
	 		Where   s.id_sin = @adcIdSin
	 		And     i.id_sin = s.id_sin
	 		And     i.cod_inter = 'A'
		 End 
		 
		If @sNumGsmSMS is null Or sysadm.FN_TRIM ( @sNumGsmSMS ) = '' Set @sTopSMS = 0
		If ( Select count (*) From sysadm.det_pro d where d.id_prod = @dcIdProd and d.id_code_dp = 104 ) <= 0 Set @sTopSMS = 0
    End 

  If @sTopSMS = 1 
    Begin
	If @iVarianteSMS between 1 and 100
 	  Begin
	   -- Param lié à la variante
		Set @sLogin   = 'spbCD'
		Set @sMdPasse = 'i3m2i2d2'
		Set @sCodeTrt = 'NETSIZE'
	  End 
    End


  If @@servername = master.dbo.SPB_FN_ServerName ('PRO')

   Begin  -- TRACE_MAIL_PRO : Début écriture

	  If @asCasRetour <> 'ADRESSE_MAIL_ABSENTE'
	    Begin 	
		  Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
			@asIdAppli,
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			@sAltQuarant,
			@sBoiteMail, -- #3
			'M2', -- #3
			2 -- #3
	    End
		
          If @sTopSMS = 1 -- #5 [FNAC_PROD_ECH_TECH].[SMS]  
            Begin
		  
		  -- Au tout dernier moment avant l'envoi, on tronque par la gauche et on
		  -- ne conserve la partie pertinente sur le droite.
		  Set @sSmsBody = Right ( @sSmsBody, @iLongMaxSMS ) -- #5 [FNAC_PROD_ECH_TECH].[SMS]  
		  
		  Exec TRACE_MAIL_PRO.sysadm.PS_I01_SMS_PUSH_V00 
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sNumGsmSMS,
			@sLogin,
			@sMdPasse,
			@sSmsBody,
			@sCodeTrt,
			'M2', 
			2
            End 
		

   End    -- TRACE_MAIL_PRO : Fin écriture

  Else

   Begin  -- TRACE_MAIL_TRT : Début écriture
	  If @asCasRetour <> 'ADRESSE_MAIL_ABSENTE'
	    Begin 	
		  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			@asIdAppli,
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			@sAltQuarant,
			@sBoiteMail, -- #3
			'M2', -- #3
			2 -- #3	
	    End
		
          If @sTopSMS = 1 -- #5 [FNAC_PROD_ECH_TECH].[SMS]  
            Begin

		  -- Au tout dernier moment avant l'envoi, on tronque par la gauche et on
		  -- ne conserve la partie pertinente sur le droite.
		  Set @sSmsBody = Right ( @sSmsBody, @iLongMaxSMS ) -- #5 [FNAC_PROD_ECH_TECH].[SMS]  


		  Exec TRACE_MAIL_TRT.sysadm.PS_I01_SMS_PUSH_V00 
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sNumGsmSMS,
			@sLogin,
			@sMdPasse,
			@sSmsBody,
			@sCodeTrt,
			'M2', 
			2
                  
            End 
		

   End    -- TRACE_MAIL_TRT : Fin écriture

  -- Problème suite éxécution
  If @iRet <> 0 
    Begin 
      Set @asCasRetour = ''
      Return -20
    End

  -- #5 [FNAC_PROD_ECH_TECH].[SMS] à Ce moment le cas de retour ne sert plus pour une erreur SQL. il n'est utilisé en amont que pour du retour immédiat sans erreur. 
  If @asCasRetour = 'ADRESSE_MAIL_ABSENTE' Return 0

  -- Fin de traitement
  Set @asCasRetour = 'MAIL_ENVOYE'
  Return 0

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S03_MAILPUSH_ENVTEL_REMP_REPAR
-- Auteur               :       Fabry JF
-- Date                 :       19/05/2006
-- Libelle              :
-- Commentaires         :       Détection de l'envoi d'un appareil de remplacement
--				C'est au client appelant cette PS de déterminer s'il y a ou pas réception d'appareil chez le CTR.
-- References           :
--
-- Arguments            :       @asIdAppli	varchar (20)		(val) Nom de l'application mère éxécutant la PS
--				@asBase		varchar (20)		(val) Nom de la base de données SHERPA ou SIMPA2
--				@adcIdSin       Decimal (  7,0 )        (Val)
--				@aiIdSeq	Integer		        (Val)
--				@adtDteEnvCli   DateTime		(val)
--				@asDestCli	VarChar	(20)		(val)
--				@asNumBonTrsp   VarChar	(50)		(val)
--				@asCasRetour    VarChar (50)		(ref) Cas : MAIL_ENVOYE
--										    OPTION_DP_NON_PARAM
--										    HORS_BASE_DE_PRODUCTION
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-- #1  JFF  03/07/2006  suite mail de C.Rigal le 30/06/2006
-- #2  JFF  23/11/2006  Lot modification pour gestion de boîte différente + quelques autres modifs
-- #3  PHG  07/08/2008  [DCMP080399] PRise en compte du transporteur UPS, et changment mobile => appareil.
-- #4  JFF  21/01/2008  [FNAC_PROD_ECH_TECH].[SMS]
--     JFF  26/11/2012  [PC877]
--     JFF  07/05/2013  [PC938_ORANGE_V3]
--     JFF  13/01/2014  [PM246]
--     JFF  08/04/2014  [PM255]
--     JFF  12/06/2014  [MANTIS11464]
--     JFF  25/08/2014  [DT100]
--     JFF  05/09/2014  [DT94][MANTIS12366]
--     JFF  16/09/2014  [PM250-2]
--     JFF	22/04/2015	[VDOC16311]
--     JFF  09/04/2015  [DT141][MANTIS15361]
--     JFF  29/02/2016  [DT191-1]
--     JFF  29/02/2016  [VDOC20992]
--     JFF  12/02/2016   [PI062]
--     JFF  28/09/2016   [DT262]
--	   JFF  20/03/2017   [DDE_HELENE_20170320] modif url chronopost
--     JFF  17/04/2018   [DT288-4] 
--     JFF  25/01/2019   [VDOC27477] Stéph. Delesque
--     JFF  21/08/2019   [DT361-1]
--     JFF  31/01/2023   [ISM344831] On n'envoie pas si CAF
--     JFF  03/02/2023   [RS4521] Modif Push mail BA Physique RDC-Carrefour
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S03_MAILPUSH_ENVTEL_REMP_REPAR_V03' AND type = 'P' )
        DROP procedure sysadm.PS_S03_MAILPUSH_ENVTEL_REMP_REPAR_V03
GO

  
CREATE procedure sysadm.PS_S03_MAILPUSH_ENVTEL_REMP_REPAR_V03  
 @asIdAppli varchar (20),  
 @asBase  varchar (20),  
 @adcIdSin       Decimal (10), -- [PI062]  
 @aiIdSeq       Integer,  
 @adtDteEnvCli   DateTime,  
 @asDestCli VarChar (20),   
 @asNumBonTrsp   VarChar (50),  
 @aiStatusGc   Integer,  
 @asCommentFrn VarChar ( 255), -- [DT100]  
 @asChaine  VarChar ( 255 ), -- [DT141]  
 @asCasRetour    VarChar (50) OUTPUT  
AS  
Declare   
  @dcIdProd     Decimal (7),   
  @dcIdEts  Decimal (7),   
  @sNumProd     VarChar (20),     
  @sLibProd     VarChar (255),   
  @sCiv  VarChar (100),   
  @sNom  VarChar (50),   
  @sMailFrom VarChar (128),   
  @sMailSend VarChar (128),   
  @sMailCc VarChar (128),  
  @sMailObjet VarChar ( 255 ),  
  @sMailBody VarChar ( 7000 ),  
  @sAltQuarant  VarChar (1),   
  @asHREFURL VarChar (300),    
  @sSaut VarChar (10),   
  @sMarque VarChar (35),  
  @sModele VarChar (35),    
  @sCodeEtat VarChar (10),  
  @sIdFour VarChar (10),  
  @iRet  Integer,  
  @iIdSin  Integer,  
  @iIdProd  Integer,  
  @iIdEts  Integer,  
  @iOptionDP    Integer,  
  @dtDteEnvCliActuel DateTime,  
  @sBoiteMail   VarChar (35),  
  @sNomTrsp VarChar (35), -- #3 [DCMP080399]   
  @sAltSuiviSMS VarChar ( 1 ),  -- #5 [FNAC_PROD_ECH_TECH].[SMS]    
  @sNumGsmSMS   VarChar ( 20 ),  -- #5 [FNAC_PROD_ECH_TECH].[SMS]    
  @iVarianteSMS Integer,  
  @sTopSMS Integer,  
  @iLongMaxSMS  Integer,  
  @sVal VarChar ( 255 ),  
  @sLogin VarChar ( 255 ),  
  @sMdPasse VarChar ( 255 ),  
  @sCodeTrt VarChar ( 255 ),  
  @sSmsBody VarChar ( 255 ),  
  @sIdTypArt VarChar ( 3 ),  
  @MailRep Integer, -- [PM246]  
  @sAdrCodCiv VarChar ( 35 ),  
  @sAdrNom VarChar ( 35 ),  
  @sAdrPrenom VarChar ( 35 ),  
  @sAdrLivr1 VarChar ( 35 ),  
  @sAdrLivr2 VarChar ( 35 ),  
  @sAdrLivrCpl VarChar ( 35 ),  
  @sAdrCp VarChar ( 35 ),  
  @sAdrVille VarChar ( 35 ),  
  @sCodePickUp VarChar ( 35 ), -- [PM255]  
  @sInfoSpbFrnCplt VarChar ( 255 ),  
  @iIrreparable Integer, -- [DT100]  
  @iPresencePret Integer, -- [PM250-2]  
  @iCasSwapDiagPrincipeV3 Integer, -- [PM250-2]  
  @iSwap Integer, -- [PM250-2]  
  @sMarqApp VarChar ( 35), -- [DT288-4]   
  @sModlApp VarChar ( 35), -- [PM250-2]  
  @iInfoSpbFrn Integer , -- [MANTIS14477]  
  @sIdRefFour VarChar ( 20 ), -- [DT141]  
  @sNumBonTrspActuel VarChar ( 50 ), -- [DT288-4]  
  @sNumImeiNouv VarChar ( 30 ), -- [DT361-1]  
  @dcMtTTCcmde Decimal ( 11, 2 ), -- [RS4521]
  @sBA_PhysiqueCMA VarChar ( 30 ) -- [RS4521]

  Set @asCasRetour = ''  
  Set @sMailBody = ''  
  Set @asHREFURL = ''  
  Set @sSaut = Char (10)  
  Set @iRet = 0  
  Set @asIdAppli = Upper ( @asIdAppli )  
  Set @sTopSMS = 0 -- [PC877]  
  Set @iLongMaxSMS = 160  
  Set @iVarianteSMS = 0  
  Set @iSwap = 0 -- [PM250-2]  
   
  Set @sNumImeiNouv = sysadm.FN_CLE_VAL ( 'NUM_IMEI_NOU', @asChaine, ';' ) -- [DT361-1]  
  
  -- Option de déclenchement du mail -DP  
  Set @iOptionDP = 50  
  
  If ( @adtDteEnvCli is null ) Or ( @asDestCli is null ) Or ( sysadm.FN_TRIM ( @asDestCli ) = '' )  
   Begin  
 Set @asCasRetour = 'PARAM_NON_RENSEIGNES'  
 Return 0  
   End  
  
  -- Récupération des données standard nécessaires à l'envoi du mail  
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL   
 @adcIdSin,  
 @asBase,  
  @iOptionDP,  
 @dcIdProd   OUTPUT,   
 @sLibProd   OUTPUT,   
 @sNumProd   OUTPUT,     
 @dcIdEts    OUTPUT,   
 @sCiv     OUTPUT,   
 @sNom     OUTPUT,   
    @sMailFrom  OUTPUT,   
 @sMailSend  OUTPUT,   
 @sMailCc    OUTPUT,  
 @sAltQuarant OUTPUT,  
 @sBoiteMail OUTPUT, -- #2  
 @sAltSuiviSMS OUTPUT, -- #4 [FNAC_PROD_ECH_TECH].[SMS]  
 @sNumGsmSMS  OUTPUT -- #4 [FNAC_PROD_ECH_TECH].[SMS]  
  
   
 Set @MailRep = 1   
  
  
  -- [PM246]  
  If @iRet = -7   
    Begin  
  If @MailRep > 0   
   Begin  
   -- Le but pour Orange V3 et de toujours mettre une adresse mail si l'adresse réél n'est pas là, pour justement  
   -- déclencher l'échec de distribution et donc envoyer le courrier en automatique.  
   Set @sMailSend = 'DeclEchecDistrib@spb.fr'  
   Set @iRet = 0     
   End  
  Else  
   Begin  
    Set @asCasRetour = 'ADRESSE_MAIL_ABSENTE'  
    Return 0       
   End   
 End  
  
  
  -- Cas de retour n'étant pas des erreurs  
  If @iRet in ( -9, -10 )  
   Begin  
 Select @asCasRetour =  
 Case @iRet  
--  When -7 Then 'ADRESSE_MAIL_ABSENTE'  
  When -9 Then 'OPTION_DP_NON_PARAM'  
  When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'  
 End   
 Return 0  
   End  
  
  -- Problème suite éxécution  
  If @iRet <> 0 Return @iRet  
  
  -- Si ce n'est pas un envoi au client, il n'y a pas de mail à envoyer  
  If Upper ( sysadm.FN_TRIM ( @asDestCli ) ) <> 'CLIENT'  
   Begin  
 Set @asCasRetour = 'ENVOI_AUTRE_QUE_CLIENT'  
 Return 0  
   End  
  
  
  -- [MANTIS11464]  
  -- [DT100]  
  
  If Not Exists (  
     Select 1  
     from sysadm.commande c1  
     Where c1.id_sin = @adcIdSin  
     and   c1.id_seq = @aiIdSeq  
     and ( c1.id_typ_art not in ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' )    
        Or   
        ( c1.id_typ_art in ( 'RST' ) And sysadm.FN_CLE_VAL ( 'RST_CMDE+SUIVI', rtrim ( c1.info_spb_frn_cplt), ';'  ) = 'OUI' )  
        Or   
        ( @MailRep > 0 And c1.id_typ_art = 'PRS' And @aiStatusGc = 2 )  
        Or   
        ( c1.id_typ_art in ( 'PST' ) And sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim ( c1.info_spb_frn_cplt), ';'  ) = 'PRET' )  
        Or   
        ( c1.id_ref_four = 'REFUSE_A_REEXP' and @aiStatusGc = 155 ) -- [DT288-4]  
        Or   
        (     sysadm.FN_CLE_VAL ( 'APP_SWAP', @asChaine, ';' )= 'OUI' ) -- [DT288-4]  
      )  
     and   @aiStatusGc not in ( 176, 239 ) -- [DT94][MANTIS12366)  
    )  
 Begin  
  Set @asCasRetour = 'CAS_NON_ELIGIBLE'  
  Return 0  
 End   
 
  -- y a-t-il eu déjà un envoi à l'assuré  
  Select @dtDteEnvCliActuel = c.dte_env_cli,  
  @sIdFour = c.id_four,  
  @sIdRefFour = IsNull ( sysadm.FN_TRIM (c.id_ref_four ), ''), -- [DT141]  
  @sMarque = IsNull ( sysadm.FN_TRIM ( c.id_marq_art ), ''), -- [DT141]  
  @sModele = IsNull ( sysadm.FN_TRIM ( c.id_modl_art ), ''), -- [DT141]  
  @sCodeEtat = sysadm.FN_TRIM ( c.cod_etat ),  
  @sNomTrsp  = sysadm.FN_TRIM ( c.adrfc_nom ), -- #3 [DCMP080399] Le nom de transporteur est dans adrfc_nom  
  @sIdTypArt = c.id_typ_art,  
  @sAdrCodCiv = IsNull ( sysadm.FN_CODE_NUM ( c.adr_cod_civ, '-CI'), '') ,  
  @sAdrNom = IsNull ( c.adr_nom, ''),  
  @sAdrPrenom = IsNull ( c.adr_prenom, ''),  
  @sAdrLivr1 = IsNull ( c.adr_livr1, ''),  
  @sAdrLivr2 = IsNull ( c.adr_livr2, ''),    
  @sAdrLivrCpl = IsNull ( c.adr_livr_cpl, ''),  
  @sAdrCp =IsNull ( c.adr_cp, ''),  
  @sAdrVille = IsNull ( c.adr_ville, ''),  
  @sAltQuarant = Convert ( Varchar (5), c.id_seq), -- [PM246]  
  @sCodePickUp = sysadm.FN_CLE_VAL ( 'CODE_PICK_UP', RTRIM( c.info_spb_frn_cplt ), ';' ), -- [PM255]  
  @sInfoSpbFrnCplt = c.info_spb_frn_cplt,  
  @iInfoSpbFrn = c.info_spb_frn, -- [MANTIS14477]  
  @iIrreparable = 0,  
  @sMarqApp = s.marq_port, -- [DT288-4]  
  @sModlApp = s.modl_port, -- [PM250-2]  
  @sNumBonTrspActuel = c.id_bon_transp, -- [DT288-4]  
  @dcMtTTCcmde = c.mt_ttc_cmde, -- [RS4521]
  @sBA_PhysiqueCMA = sysadm.FN_CLE_VAL ( 'TYPE_ENVOI', rtrim ( c.info_spb_frn_cplt ), ';') -- [RS4521]
  
  From   sysadm.commande c,  
   sysadm.sinistre s  
  Where  c.id_sin = @adcIdSin  
  And    c.id_seq = @aiIdSeq  
  And    s.id_sin = c.id_sin  

  -- [ISM344831] @sBA_PhysiqueCMA 
  If  @sIdTypArt = 'CAF' 
	  And Not ( @sIdFour = 'CMA' and @sBA_PhysiqueCMA = 'PHYSIQUE' ) 
	  And Not ( @sIdFour in ( 'TLS', 'SBE' ) and @sIdRefFour = 'CMDE_A_CPLTER' ) 
   Begin
	  -- On n'envoie pas le mail dans ce cas car il se formate mal par rapport au contexte.
	  -- Mais on simule que l'envoi ait bien fonctionné pour ne rien faire dysfonctionner derrière
	  Set @asCasRetour = 'MAIL_ENVOYE'  
	  Return 0  
   End 
   

 -- [PC202553_SELECTRA][CDCSINV3][MANTIS33658]  
  If Exists (   
  Select Top 1 1   
  From sysadm.det_pro dp  
  Where dp.id_prod = @dcIdProd  
  And dp.id_code_dp = 356  
  And sysadm.FN_CLE_VAL ( 'ID_FOUR', rtrim ( val_car ) + rtrim ( val_car2 ), ';' ) = @sIdFour  
  And sysadm.FN_CLE_VAL ( 'ID_TYP_ART', rtrim ( val_car ) + rtrim ( val_car2 ), ';' ) = @sIdTypArt   
   )  
   Begin  
	  Set @asCasRetour = 'DP356_BLOQUANTE'  
	  Return 0  
   End   

  
  If sysadm.FN_CLE_VAL ( 'APP_SWAP', @asChaine, ';' )= 'OUI'   
 Begin   
  Set @sMarque = sysadm.FN_CLE_VAL ( 'MARQSW', @asChaine, ';' )  
  Set @sModele = sysadm.FN_CLE_VAL ( 'MODLSW', @asChaine, ';' )  
 End   
  
  If CharIndex ( 'STOCK', @sMarque, 1 ) > 0 Set @sMarque = ''  
  If CharIndex ( 'STOCK', @sModele, 1 ) > 0 Set @sModele = ''    
  
  -- [DT141][MANTIS15361]  
  If @sIdRefFour = 'CMDE_A_CPLTER'  
   Begin  
  Set @sMarque = sysadm.FN_CLE_VAL ( 'MARQ_REMPL', rtrim ( @asChaine ) , ';')  
  Set @sModele = sysadm.FN_CLE_VAL ( 'MODL_REMPL', rtrim ( @asChaine ) , ';')  
 End          
    
  -- [DT361]  
  -- Pour les fournisseurs qui remette la marque dans leur modele, on vire la marque du modèle  
  Set @sModele = Replace ( @sModele, @sMarque, '' )   
     
  -- [PM250-2]  
   Set @iPresencePret = 0  
 If Exists (   
  Select 1  
  From   sysadm.commande c  
  Where  c.id_sin = @adcIdSin  
  And c.id_typ_art = 'PST'  
  And Len ( sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', RTRIM( c.info_spb_frn_cplt ), ';' )) > 0   
  And c.cod_etat <> 'ANN'  
  )  
  Begin   
   Set @iPresencePret = 1  
  End   
  
  -- [PM250-2]  
  Set @iCasSwapDiagPrincipeV3 = 0  
 If Exists (   
  Select 1  
  From   sysadm.commande c,  
      sysadm.commande c1,  
      sysadm.sinistre s,  
      sysadm.det_pro dp  
  Where  s.id_sin = @adcIdSin  
  And    dp.id_prod = s.id_prod  
  And    dp.id_code_dp = 239  
  And    c.id_sin = s.id_sin  
  And    c.id_ref_four = 'A_DIAGNOSTIQUER'  
  And    c.cod_etat <> 'ANN'  
  And    c1.id_sin = s.id_sin  
  And    sysadm.FN_A_COMMANDER ( c1.id_sin, c1.id_seq, 'P' ) = 'A_COMMANDER'  
  And    c1.cod_etat <> 'ANN'  
  And    Not Exists (   
    Select 1  
    From sysadm.commande c2  
    Where   c2.id_sin = s.id_sin  
    And  c2.id_typ_art = 'PRS'  
      )  
  )  
  Begin   
   Set @iCasSwapDiagPrincipeV3 = 1  
  End     
    
-- [PC938_ORANGE_V3]  
  If Upper ( @sIdTypArt ) in ( 'REL' )  
   Begin  
 Set @asCasRetour = 'TYP_ART_NON_AUTORISE'  
 Return 0  
   End  
   
  -- La date actuelle lu de la base n'est pas nulle et l'état est différent de RSP, donc le mobile a déjà été envoyé au client.  
  -- [DT288-4]
 If ( @dtDteEnvCliActuel is not null ) And ( @sCodeEtat <> 'RSP' ) And ( ( @asNumBonTrsp = @sNumBonTrspActuel And @asNumBonTrsp is not null and @sNumBonTrspActuel is not null ) )  
  Begin  
	  Set @asCasRetour = 'MOB_DEJA_ENVOYE'  
	  Return 0  
  End   

  -- Gestion de la civilité "Madame, Monsieur"  
  If @sNom <> ''  
   Begin  
    Set @sCiv = @sCiv + ' ' + @sNom + ','  
   End   
  
  -- Armement de l'objet du mail  
 Set @sMailObjet = 'Votre dossier n°' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) + ' ' + @sLibProd -- [PI062]  
  
  -- Armement du corps du mail  
  Set @sMailBody  = @sMailBody  + @sCiv  
  Set @sMailBody  = @sMailBody  + @sSaut  
  Set @sMailBody  = @sMailBody  + @sSaut  
  -- #3 [DCMP080399] Le nom de transporteur est dans adr_fc_nom  
  -- Set @sMailBody  = @sMailBody  + 'Votre mobile ' + @sMarque + ' ' + @sModele + ' vous a été envoyé le ' + Convert ( VarChar, @adtDteEnvCli, 103 ) + '.'  
  -- remplacé par :  
  
   If @MailRep > 0 And @sIdTypArt = 'PRS' And @aiStatusGc = 2  
  Begin  
       
   -- [MANTIS14477]       
   If @iInfoSpbFrn = 957  
    Begin  
      Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer que votre appareil ' + @sMarque + ' ' + @sModele + ' a été réparé à l''adresse suivante :'  
    End   
   Else
    Begin  
      Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer que votre appareil ' + @sMarque + ' ' + @sModele + ' réparé va vous être renvoyé à l''adresse suivante :'  
	End 
       
   Set @sMailBody  = @sMailBody  + @sSaut  
   Set @sMailBody  = @sMailBody  + @sSaut     
   Set @sMailBody  = @sMailBody  + rtrim ( @sAdrCodCiv ) + ' ' + rtrim( @sAdrNom )  
     
   --[DT191-2][MANTIS20745]  
   If Len ( @sCodePickUp ) > 0   
    Begin  
    Set @sMailBody  = @sMailBody  + @sSaut  
    End  
   Else  
    Begin  
    Set @sMailBody  = @sMailBody  + ' '   
    End   
  
   Set @sMailBody  = @sMailBody  + rTrim ( @sAdrPrenom ) + @sSaut  
   --/[DT191-2][MANTIS20745]  
  
   Set @sMailBody  = @sMailBody  + rtrim ( @sAdrLivr1 ) + @sSaut  
     
   If @sAdrLivr2 is not null and LEN ( sysadm.FN_TRIM (  @sAdrLivr2 ) ) > 0   
    Begin  
    Set @sMailBody  = @sMailBody  + rtrim (@sAdrLivr2 )  + @sSaut  
    End  
     
   If  @sAdrLivrCpl is not null and LEN ( sysadm.FN_TRIM (  @sAdrLivrCpl ) ) > 0   
    Begin  
    Set @sMailBody  = @sMailBody  + rtrim (@sAdrLivrCpl) + @sSaut  
    End  
      
   Set @sMailBody  = @sMailBody  + @sAdrCp + @sSaut  
   Set @sMailBody  = @sMailBody  + @sAdrVille + @sSaut    
     
   -- [PM255]  
   If Len ( @sCodePickUp ) > 0   
    Begin  
    Set @sMailBody  = @sMailBody  + @sSaut  
    Set @sMailBody  = @sMailBody  + @sSaut       
    Set @sMailBody  = @sMailBody  + 'Cette adresse correspond à un point relais Pick Up.'  
    Set @sMailBody  = @sMailBody  + @sSaut  
    Set @sMailBody  = @sMailBody  + 'Il vous sera demandé de présenter une pièce d''identité.'  
    End   
      
   If @iPresencePret > 0   
    Begin  
    -- [PM250-2]  
    Set @sMailBody  = @sMailBody  + @sSaut  
    Set @sMailBody  = @sMailBody  + @sSaut  
    Set @sMailBody  = @sMailBody  + 'En échange, vous devrez redonner l''appareil de prêt (et ses accessoires) dont vous avez bénéficié dans le cadre de votre contrat.'          
    Set @sMailBody  = @sMailBody  + @sSaut  
    Set @sMailBody  = @sMailBody  + 'Pour cela vous recevrez dans un second mail une fiche d''instruction - bon d''échange.'      
    Set @sMailBody  = @sMailBody  + @sSaut  
    Set @sMailBody  = @sMailBody  + 'Nous vous demandons de bien vouloir l''imprimer, la signer et la remettre au chauffeur Chronopost lors de l''échange des appareils.'  
    Set @sMailBody  = @sMailBody  + @sSaut      
  
    -- [PM250-2]  
    Exec sysadm.PS_I_MAIL_RETOUR_PRET_FICHE_14 @asIdAppli, @asBase, @iOptionDP, @adcIdSin  
      
    End       
  End   
   Else  
     Begin  
  
   -- [DT100]  
   If @sIdTypArt = 'PST' And Len ( sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', RTRIM( @sInfoSpbFrnCplt ), ';' )) > 0   
    Begin  
     -- [PM250-2]  
     Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer que votre appareil de prêt vous a été envoyé le ' + Convert ( VarChar, @adtDteEnvCli, 103 ) + ' à l''adresse suivante :'      
    End   
   Else  
    Begin  
     -- [DT288-4]  
      If @sIdRefFour = 'REFUSE_A_REEXP'  
        Begin  
       Set @sMailBody  = @sMailBody  + 'Nous vous informons que votre appareil sinistré ' + @sMarqApp + ' ' + @sModlApp + ' vous a été renvoyé le ' + Convert ( VarChar, @adtDteEnvCli, 103 ) + ' à l''adresse suivante :'  
        End   
      Else
        Begin
		  -- [RS4521]
		  If @sIdTypArt = 'CAF' And @sIdFour = 'CMA'  
		   Begin
				Set @sMailBody = @sMailBody + 'Nous allons vous faire parvenir d''ici quelques jours par courrier votre/vos bon(s) d''achat Carrefour pour un '
				Set @sMailBody = @sMailBody + 'montant total de ' + convert ( VarChar ( 20 ), @dcMtTTCcmde ) + '€, correspondant au montant de l’indemnité qui vous est due au titre du contrat GARANTIE ' 
				Set @sMailBody = @sMailBody + @sLibProd + ' à l''adresse suivante :'
		   End 
		  Else
		   Begin
			   Set @iSwap = 1 -- [PM250-2]  
			   Set @sMailBody  = @sMailBody + 'Nous avons le plaisir de vous informer que votre appareil de remplacement ' + @sMarque + ' ' + @sModele + ' vous a été envoyé le ' + Convert ( VarChar, @adtDteEnvCli, 103 ) + ' à l''adresse suivante :'  
  
			  -- Gestion SAMSUNG ? => Trt part  
			  If Exists ( Select *   
				 from sysadm.det_pro dp,  
				   sysadm.w_sin s  
				 Where s.id_sin = @adcIdSin   
				 And   dp.id_prod = s.id_prod  
				 And   dp.id_code_dp = 294  
			   )  
			   Begin  
				Exec sysadm.PS_S_MAILPUSH_DT361_INFO_REMPL @adcIdSin, @aiIdSeq, @sMarque, @sModele, @sNumImeiNouv, @asCasRetour OUTPUT  
			   End   
			End
		ENd   
    End   
  
      
   Set @sMailBody  = @sMailBody  + @sSaut  
   Set @sMailBody  = @sMailBody  + @sSaut     
   Set @sMailBody  = @sMailBody  + rtrim ( @sAdrCodCiv ) + ' ' + rtrim( @sAdrNom ) + ' '   
     
   -- [DT191-1]  
   If Len ( @sCodePickUp ) > 0   
    Begin     
    Set @sMailBody  = @sMailBody  + @sSaut  
    End   
  
   Set @sMailBody  = @sMailBody  + rTrim ( @sAdrPrenom ) + @sSaut  
   Set @sMailBody  = @sMailBody  + rtrim ( @sAdrLivr1 ) + @sSaut  
     
   If @sAdrLivr2 is not null and LEN ( sysadm.FN_TRIM (  @sAdrLivr2 ) ) > 0   
    Begin  
    Set @sMailBody  = @sMailBody  + rtrim (@sAdrLivr2 )  + @sSaut  
    End  
     
   If  @sAdrLivrCpl is not null and LEN ( sysadm.FN_TRIM (  @sAdrLivrCpl ) ) > 0   
    Begin  
    Set @sMailBody  = @sMailBody  + rtrim (@sAdrLivrCpl) + @sSaut  
    End  
      
   Set @sMailBody  = @sMailBody  + @sAdrCp + @sSaut  
   Set @sMailBody  = @sMailBody  + @sAdrVille + @sSaut        
     
      
   -- [PM255]  
   If Len ( @sCodePickUp ) > 0   
    Begin     
    Set @sMailBody  = @sMailBody  + @sSaut  
    Set @sMailBody  = @sMailBody  + @sSaut       
    Set @sMailBody  = @sMailBody  + 'Cette adresse correspond à un point relais Pick Up.'  
    Set @sMailBody  = @sMailBody  + @sSaut  
    Set @sMailBody  = @sMailBody  + 'Il vous sera demandé de présenter une pièce d''identité.'  
    Set @sMailBody  = @sMailBody  + @sSaut  
  
    End  
      
   If @sIdTypArt = 'PST' And Len ( sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', RTRIM( @sInfoSpbFrnCplt ), ';' )) > 0   
    Begin  
    -- [PM250-2]  
    Set @sMailBody  = @sMailBody  + @sSaut  
    Set @sMailBody  = @sMailBody  + 'Vous recevrez dans un second mail une fiche d''instruction - bon d''échange.'      
    Set @sMailBody  = @sMailBody  + @sSaut  
    Set @sMailBody  = @sMailBody  + 'Nous vous demandons de bien vouloir l''imprimer, la signer et la remettre au chauffeur Chronopost lors de l''échange des appareils.'  
    Set @sMailBody  = @sMailBody  + @sSaut      
  
    -- [PM250-2]  
    Exec sysadm.PS_I_MAIL_PRET_FICHE_15 @asIdAppli, @asBase, @iOptionDP, @adcIdSin  
      
    End   
  
   -- [PM250-2]  
   If @iCasSwapDiagPrincipeV3 > 0 And @iSwap > 0 And CHARINDEX ( 'IPHONE', Upper( @sModlApp ) ) > 0  
     Begin  
    -- [PM250-2]  
    Set @sMailBody  = @sMailBody  + @sSaut  
    Set @sMailBody  = @sMailBody  + 'Vous recevrez dans un second mail une fiche d''instruction - bon d''échange.'      
    Set @sMailBody  = @sMailBody  + @sSaut  
    Set @sMailBody  = @sMailBody  + 'Nous vous demandons de bien vouloir l''imprimer, la signer et la remettre au chauffeur Chronopost lors de l''échange des appareils.'  
    Set @sMailBody  = @sMailBody  + @sSaut      
         
    Exec sysadm.PS_I_MAIL_SWAP_FICHE_19 @asIdAppli, @asBase, @iOptionDP, @adcIdSin  
     End   
	
	-- [RS4521]
	If @sIdTypArt = 'CAF' And @sIdFour = 'CMA'  
	  Begin
		Set @sMailBody  = @sMailBody  + @sSaut      
		Set @sMailBody  = @sMailBody  + 'Votre/Vos bons d''achat est/sont valable(s) 1 (un) an dans tous les magasins Carrefour situés en France métropolitaine (Corse comprise).' 
		Set @sMailBody  = @sMailBody  + @sSaut      
		Set @sMailBody  = @sMailBody  + @sSaut      
		Set @sMailBody  = @sMailBody  + 'Nous vous rappelons que suite au sinistre garanti de l''appareil assuré cette indemnité vous est versée en vue de son remplacement.'

	  End
   End  
      
  Set @sMailBody  = @sMailBody  + @sSaut  
   
  Select @asHREFURL = @asHREFURL +   
 Case  
  
  -- #3 [DCMP080399] UPS => Lien non directement clickable, l'utilisateur saisira son N° de colis.  
  -- [PM255]  
  /* [DDE_HELENE_20170320] modif url chronopost  
  When Len ( @sCodePickUp ) > 0   
   Then 'http://www.chronopost.fr/transport-express/livraison-colis/searchChronoRelais?pid=' + RTRIM ( @sCodePickUp )  
   */  
  
  When @sNomTrsp = 'UPS'  
   Then 'http://www.ups.com/content/fr/fr/index.jsx + ( N° Colis : ' + @asNumBonTrsp + ' )'  
  
  -- ChronoPost AA931798942FR  
  -- [DT288-4]  
  When IsNumeric ( Left (@asNumBonTrsp, 2) ) = 0 And IsNumeric ( Right (@asNumBonTrsp, 2) ) = 0 And Len ( @asNumBonTrsp ) = 13  
   Then 'https://www.chronopost.fr/fr/chrono_suivi_search?listeNumerosLT=' + @asNumBonTrsp  
  
  -- Coliposte 8L41585398663  
  When IsNumeric ( Left (@asNumBonTrsp, 2) ) = 0 And IsNumeric ( Right (@asNumBonTrsp, 2) ) = 1 And Len ( @asNumBonTrsp ) = 13  
   -- Then 'http://www.coliposte.net/gp/services/main.jsp?m=10003005&amp;colispart=' + @asNumBonTrsp  
   Then 'https://www.laposte.fr/outils/suivre-vos-envois?code=' + @asNumBonTrsp  
  
  -- Ciblex 24955001116149  
  When isNumeric ( @asNumBonTrsp ) = 1 And Len ( @asNumBonTrsp ) = 14  
   Then 'http://www.ciblex.fr/extranet/client/corps.php?module=colis&amp;colis=' + @asNumBonTrsp  
  
  Else null  
 End   
  
  If ( @asHREFURL is not null ) And sysadm.FN_TRIM ( @asHREFURL ) <> ''   
   Begin   

	If @sIdTypArt = 'CAF' And @sIdFour = 'CMA'  
	  Begin
		Set @sMailBody  = @sMailBody  + 'Pour suivre l''envoi de votre/vos bon(s) d''achat Carrefour, cliquez sur le lien ci-dessous : '   
	  End 
	Else
	  Begin
		Set @sMailBody  = @sMailBody  + 'Pour suivre l''envoi de votre appareil, cliquez sur le lien ci-dessous : '   
	  End 

    Set @sMailBody  = @sMailBody  + @sSaut  
    Set @sMailBody  = @sMailBody  + @sSaut      
    Set @sMailBody  = @sMailBody  + @asHREFURL   
    Set @sMailBody  = @sMailBody  + @sSaut  
    Set @sMailBody  = @sMailBody  + @sSaut          
   End   
  
	If @sIdTypArt = 'CAF' And @sIdFour = 'CMA'  
	  Begin
	   Set @sMailBody  = @sMailBody + 'Nous vous souhaitons bonne réception de la présente et vous remercions de la confiance que vous nous accordez.'
	   Set @sMailBody  = @sMailBody  + @sSaut  
	   Set @sMailBody  = @sMailBody  + @sSaut          
	   Set @sMailBody  = @sMailBody  + @sSaut          
	   Set @sMailBody  = @sMailBody  + 'Votre gestionnaire'

	  End 
	Else 
	  Begin
		  -- [VDOC27477] Stéph. Delesque  
		  If @iInfoSpbFrn not in ( 957 ) 
		    Begin
				Set @sMailBody  = @sMailBody + 'Prenez le temps d''ouvrir votre colis, d''examiner et de vérifier l''état de votre appareil lors de la remise de celui-ci. En cas d''anomalie (colis vide, appareil endommagé….) refusez le aussitôt en présence du transporteur ou en point relais puis contactez-nous dans les 48h. Si vous avez accepté le colis sans émettre de réserve sur le bon de transport, aucune anomalie de transport ne pourra être prise en charge.'   
				Set @sMailBody  = @sMailBody  + @sSaut  
				Set @sMailBody  = @sMailBody  + @sSaut          
			End 
			
		  Set @sMailBody  = @sMailBody  + @sSaut  
		  Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'  
		  Set @sMailBody  = @sMailBody  + @sSaut  
  
		 -- [DT262]  
		  Set @sMailBody  = @sMailBody  + @sSaut  
		  Set @sMailBody  = @sMailBody  + @sSaut  
		  Set @sMailBody  = @sMailBody  + 'Si votre contrat d''assurance dispose d''un site web de gestion de sinistre, vous pouvez à tout moment consulter et télécharger la ou les pièce(s) de votre dossier sur ce site communiqué par notre gestionnaire lors de votre déclaration.'  
	  End   

  Set @sMailBody  = @sMailBody  + @sSaut  
  Set @sMailBody  = @sMailBody  + @sSaut  
  Set @sMailBody  = @sMailBody  + '****************************************************************'  
  Set @sMailBody  = @sMailBody  + @sSaut  
  Set @sMailBody  = @sMailBody  + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL'  
  Set @sMailBody  = @sMailBody  + @sSaut  
  Set @sMailBody  = @sMailBody  + '****************************************************************'  
  Set @sMailBody  = @sMailBody  + @sSaut  
  Set @sMailBody  = @sMailBody  + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'  
  
  
--------------------------------------------------------------------------------------------------------------------  
-- Gestion des SMS.  
--------------------------------------------------------------------------------------------------------------------  
  If @iVarianteSMS between 1 and 100 -- #5 [FNAC_PROD_ECH_TECH].[SMS]  
   Begin  
 Set @sTopSMS = 1   
  
 -- 1/ Confirmation réception appareil en atelier :   
 -- Récup lib produit -DP/66  
 Select @sVal = IsNull ( sysadm.FN_TRIM ( d.val_car ), '')  
 From   sysadm.det_pro d  
 Where  d.id_prod = @dcIdProd  
 And    d.id_code_dp = 228 -- [PC877]  
  
 If @sVal is null Or sysadm.FN_TRIM (@sVal) = '' Set @sVal = ''  
 If Len ( @sVal ) > 0 Set @sVal = @sVal + '.'  
  
 If @iVarianteSMS = 1  
   Begin  
     Set @sSmsBody = @sVal + 'Bonjour, votre appareil a été envoyé à votre adresse ce jour. Nous vous en souhaitons d’avance bonne réception. SPB'  
   End  
   End  
  
  
  -- On convertit pour l'appel de la PS  
  Set @iIdSin  = Convert ( integer, @adcIdSin )  
  Set @iIdProd = Convert ( integer, @dcIdProd )  
  Set @iIdEts  = Convert ( integer, @dcIdEts )  
     
  If @sTopSMS = 1   
    Begin  
 If @iVarianteSMS between 1 and 100  
    Begin  
    -- Param lié à la variante  
  Set @sLogin   = 'spbCD'  
  Set @sMdPasse = 'i3m2i2d2'  
  Set @sCodeTrt = 'NETSIZE'  
   End   
    End  
  
  
  If @@servername = master.dbo.SPB_FN_ServerName ('PRO')  
  
   Begin  -- TRACE_MAIL_PRO : Début écriture  
  
   Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00   
  @asIdAppli,  
  @iIdSin,   
  @iIdProd,   
  @sLibProd,   
  @iIdEts,   
     @sMailFrom,   
  @sMailSend,   
  @sMailCc,  
  @sMailObjet,  
  @sMailBody,  
  @sAltQuarant,  
  @sBoiteMail, --#2  
  'M3', -- #2  
  2 -- #2    
    
    
          If @sTopSMS = 1 -- [PC877]  
            Begin  
      
    -- Au tout dernier moment avant l'envoi, on tronque par la gauche et on  
    -- ne conserve la partie pertinente sur le droite.  
    Set @sSmsBody = Right ( @sSmsBody, @iLongMaxSMS )   
      
    Exec TRACE_MAIL_PRO.sysadm.PS_I01_SMS_PUSH_V00   
   @asIdAppli,  
   @iIdSin,  
   @iIdProd,  
   @sLibProd,  
   @iIdEts,  
   @sNumGsmSMS,  
   @sLogin,  
   @sMdPasse,  
   @sSmsBody,  
   @sCodeTrt,  
   'M3',   
   2  
            End   
    
  
   End    -- TRACE_MAIL_PRO : Fin écriture  
  
  Else  
  
   Begin  -- TRACE_MAIL_TRT : Début écriture  
  
   Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00   
  @asIdAppli,  
  @iIdSin,   
  @iIdProd,   
  @sLibProd,   
  @iIdEts,   
  @sMailFrom,   
  @sMailSend,   
  @sMailCc,  
  @sMailObjet,  
  @sMailBody,  
  @sAltQuarant,  
  @sBoiteMail, --#2  
  'M3', -- #2  
  2 -- #2  
    
    
          If @sTopSMS = 1 -- [PC877]  
            Begin  
  
    -- Au tout dernier moment avant l'envoi, on tronque par la gauche et on  
    -- ne conserve la partie pertinente sur le droite.  
    Set @sSmsBody = Right ( @sSmsBody, @iLongMaxSMS ) -- #5 [FNAC_PROD_ECH_TECH].[SMS]    
  
  
    Exec TRACE_MAIL_TRT.sysadm.PS_I01_SMS_PUSH_V00   
   @asIdAppli,  
   @iIdSin,  
   @iIdProd,  
   @sLibProd,  
   @iIdEts,  
   @sNumGsmSMS,  
   @sLogin,  
   @sMdPasse,  
   @sSmsBody,  
   @sCodeTrt,  
   'M3',   
   2  
     End  
  
   End    -- TRACE_MAIL_TRT : Fin écriture  
  
  -- Problème suite éxécution  
  If @iRet <> 0 Return -20  
  
  -- Fin de traitement  
  Set @asCasRetour = 'MAIL_ENVOYE'  
  Return 0  

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S04_MAILPUSH_INFO_REPAR_PASSE
-- Auteur               :       Fabry JF
-- Date                 :       12/06/2006
-- Libelle              :
-- Commentaires         :       ENvoi d'un résumé de la commande de réparation vers l'assuré lors de la déclaration.
--
-- References           :
--
-- Arguments            :       @asIdAppli	varchar (20)		(val) Nom de l'application mère éxécutant la PS
--				@asBase		varchar (20)		(val) Nom de la base de données SHERPA ou SIMPA2
--				@adcIdSin       Decimal (  7,0 )        (Val)
--				@aiIdSeq	Integer		        (Val)
--				@asCasRetour    VarChar (50)		(ref) Cas : MAIL_ENVOYE
--										    OPTION_DP_NON_PARAM
--										    HORS_BASE_DE_PRODUCTION
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-- #1  JFF  03/07/2006  suite mail de C.Rigal le 30/06/2006
-- #2  JFF  23/11/2006  Lot modification pour gestion de boîte différente + quelques autres modifs
-- #3  JCA  29/05/2007  DCMP 070335 - Modification de l'adresse de SBE
-- #4  JFF  26/03/2008  [SURCOUF_ECH_EXPRESS]
-- #5  JFF  28/04/2008  [DCMP080202]
-- #6  PHG  29/09/2008  Correction : Modification adresse ANOVO BRIVE
-- #7  JFF  21/01/2008  [FNAC_PROD_ECH_TECH].[SMS]
-- #8  JFF  06/03/2009  [FNAC_PROD_ECH_TECH].[20090224144248310]
-- #9  JFF  30/03/2009  [FNAC_PROD_ECH_TECH].[20090330152547023]
-- #10 JFF  02/09/2009  [DCMP090327].[SBETV]
-- #11 JFF  16/10/2009  [DCMP090421]
-- #12 JFF  02/12/2009  [DCMP090678]
-- #12 JFF  10/12/2009  [20091210115141760]
-- #13 JFF  11/12/2009  [MSS_DIAG]
-- #14 JFF  02/03/2010  [MSS_LOT2]
--     JFF  13/04/2010  [ADRESSE_O2M]
--     JFF  10/06/2010  [PC419/440/418/439_MICROMANIA]
--     JFF  12/07/2010  [PC363_AUCHAN]
--     JFF  20/01/2011  [GROSBILL].[PC398-403-479]
--     JFF  20/01/2011  [PC363].[MAIL_ASS_BC]
--     JFF  20/01/2011  [PC363].[MAIL_ASS_MATRMP]
-- 	FPI 19/05/2011	[PC442]
--	FPI 09/11/2011  [PC403] Variante Mail 7  n'existe plus suite au PM 159 - Mails à tout prix
-- 	JFF 05/01/2012  [RECUP_DONNEE_O2M]
--  JFF   13/02/2012   [PM200][PSM]
--  JFF   27/04/2012   [MANTIS3281]
--  JFF   23/05/2012 [PM103][1]
--  JFF   19/06/2012 [VDOC7793]
--  JFF   06/08/2012 [BLCODE]
--  JFF   26/11/2012 [PC877]
--  JFF   14/12/2012 [PM200_LOT3_V3]
--  JFF   17/01/2014 [PC913]
--  JFF   25/03/2013 [PC801_LOT1_V2]
--  JFF   02/04/2013 [PC929_CDISCOUNT]
--  FPI   25/04/2013 [VDOC11025] - 07/10/2013 - Annulé
--  JFF   07/05/2013 [PC938_ORANGE_V3]
--  JFF   07/05/2013 [PC929-1]
--  JFF   09/09/2013 [PM222-1]
--  JFF   14/10/2013 [VDOC12443]
--  JFF   12/12/2013 [PC947&977]
--  JFF   30/12/2013 [PC13348&13408]
--  JFF   18/02/2014 [PM246][MANTIS10233]
--  JFF   08/04/2014 [PM255]
--	FPI	  19/04/2014 [PM261-1]
--  JFF   02/06/2014 [PC929_CDISCOUNT][PC929-2-V3]
--  JFF   17/06/2014 [DT87][MANTIS11453]
--	FPI	  13/11/2014 [VDoc14882] Changement d'adresse O2M (PS_I01_MAIL_PUSH_V01)
--  JFF   12/12/2014 [PC13321]
--  JFF   02/01/2015 [PC801_6_TAMET]
--  JFF   11/03/2015 [PM250-2][MANTIS14550]
--  JFF   24/03/2015 [DT139]
--  JFF   09/04/2015 [DT141]
--  JFF   09/04/2015 [VDOC17717]
--  JFF   02/06/2015 [ITSM296798]
--  JFF   03/06/2015 [DT145_V4]
--  JFF   05/06/2015 [VDOC17642]
--  JFF   10/06/2015 [PM280-1][MANTIS15456]
--  JFF   13/10/2015 [ITSM332188]
--  JFF   07/12/2015 [DT153-1]
--  JFF   15/12/2015 [DT191]
--  JFF   11/01/2016 [DT188]
--  JFF   26/01/2016 [VDOC19724]
--  JFF   08/03/2016 [VDOC20167]
--  JFF   24/03/2016 [VDOC20329]
-- JFF    17/05/2016 [PM280-2]
-- JFF    12/02/2016 [PI062]
-- JFF    28/09/2016 [DT262]
-- JFF    10/10/2016 [PC151549][MANTIS21978]
-- JFF    12/02/2018 [DT346]
-- JFF    31/12/2018 [DT361]
-- JFF    25/01/2019 [PC151379]
-- JFF    25/03/2019 [DT398]
-- JFF    15/05/2019 [DT386_EXTR_AXA]
-- JFF    23/06/2020 [PC202553_SELECTRA]
-- JFF    16/11/2020 [PC202553_SELECTRA][CDCSINV3]
-- JFF    15/01/2021 [DT517]  
-- JFF    26/04/2023 [RS5045_REF_MATP]
------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S04_MAILPUSH_INFO_REPAR_PASSE' AND type = 'P' )
        DROP procedure sysadm.PS_S04_MAILPUSH_INFO_REPAR_PASSE
GO

CREATE procedure sysadm.PS_S04_MAILPUSH_INFO_REPAR_PASSE
	@asIdAppli	varchar (20),
	@asBase		varchar (20),
	@adcIdSin      	Decimal (10), -- [PI062]
	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @dcIdDetail   Decimal (7), -- #4 [SURCOUF_ECH_EXPRESS]
  @dcIdGti      Decimal (7), -- #4 [SURCOUF_ECH_EXPRESS]
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @asHREFURL	VarChar (300),		
  @sSaut	VarChar (10), 
  @sMarque	VarChar (35),
  @sModele	VarChar (35),  
  @sIdFour	VarChar (10),
  @sCodeEtat	VarChar (10),
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @iIdSeq 	Integer,
  @iOptionDP    Integer,
  @dtDteEnvCliActuel DateTime,
  @sBoiteMail   VarChar (35),
  @sNomLigne1	VarChar ( 35 ), -- [ADRESSE_O2M]
  @sNomLigne2	VarChar ( 35 ), -- [ADRESSE_O2M]
  @sAdrLigne1	VarChar ( 40 ),	-- [ADRESSE_O2M]
  @sAdrLigne2	VarChar ( 40 ),	-- [ADRESSE_O2M]	
  @sCP		VarChar ( 35 ), -- [ADRESSE_O2M]
  @sVille	VarChar ( 35 ),  -- [ADRESSE_O2M]
  @sAdressO2M	VarChar ( 200 ),  -- [ADRESSE_O2M]
  @sAdressCentralePSM VarChar ( 200 ), -- [PM200][PSM]
  @sAdressBLC   VarChar ( 200 ), -- [BLCODE]
  @iVarianteMail Integer, -- #4 [SURCOUF_ECH_EXPRESS]
  @sValCarDetPro VarChar ( 100 ), -- #4 [SURCOUF_ECH_EXPRESS]
  @sMagasin 	VarChar ( 50 ),  -- #4 [SURCOUF_ECH_EXPRESS]
  @sIdSin	VarChar ( 10 ),   -- #4 [SURCOUF_ECH_EXPRESS]  -- [PI062]
  @sNumPanier   VarChar ( 35 ),  -- #4 [SURCOUF_ECH_EXPRESS] 
  @sSKU		VarChar ( 35 ),  -- #4 [SURCOUF_ECH_EXPRESS] 
  @sNumSerie    VarChar ( 35 ),  -- #4 [SURCOUF_ECH_EXPRESS] 
  @sValAchat    VarChar ( 35 ),  -- #4 [SURCOUF_ECH_EXPRESS] 
  @sDteAchat    VarChar ( 10 ),  -- #4 [SURCOUF_ECH_EXPRESS] 
  @sNumFaxProd  VarChar ( 20 ),  -- #4 [SURCOUF_ECH_EXPRESS] 
  @sNumTelProd  VarChar ( 20 ), -- [GROSBILL].[PC398-403-479]
  @sHoraireOuv  VarChar ( 50 ),  -- #4 [SURCOUF_ECH_EXPRESS]  
  @sCoutTel     VarChar ( 35 ), -- #4 [SURCOUF_ECH_EXPRESS]  
  @iInfoSpbFrn  Integer, -- #5 [DCMP080202]
  @sIdRefFour   VarChar ( 35 ), -- #5 [DCMP080202]
  @sAltSuiviSMS VarChar ( 1 ),  -- #7 [FNAC_PROD_ECH_TECH].[SMS]  
  @sNumGsmSMS   VarChar ( 20 ),  -- #7 [FNAC_PROD_ECH_TECH].[SMS]  
  @sTypApp 	VarChar ( 3 ), -- #12 [DCMP090678]
  @sVarianteDiagDP129 VarChar ( 30 ), -- #12 [DCMP090678]
  @sDP66	Varchar ( 70 ), -- [GROSBILL].[PC398-403-479]
  @sDP67	Varchar ( 70 ), -- [GROSBILL].[PC398-403-479]
  @sLibPolice	Varchar ( 35 ), -- [GROSBILL].[PC398-403-479]
  @smtPec	VarChar ( 15 ), -- [PC363].[MAIL_ASS_BC]
  @MarqueRemplO2M VarChar ( 35 ), -- [PC363].[MAIL_ASS_MATRMP]
  @ModeleRemplO2M VarChar ( 35 ),  -- [PC363].[MAIL_ASS_MATRMP]
  @sPropo1	Varchar(35), -- [PC403]
  @sPropo2	Varchar(35), -- [PC403]
  @sDP205	VarChar (70 ), -- [RECUP_DONNEE_O2M]
  @sInfoSpbFrnCplt VarChar ( 255 ), -- [RECUP_DONNEE_O2M]
  @sXMLVar     	VarChar ( max ), -- [RECUP_DONNEE_O2M]
  @sDteDecl		VarChar ( 15 ), -- [RECUP_DONNEE_O2M]
  @sLstAdresse	VarChar ( 255 ), -- [PM200][PSM]
  @sCodeBtqPSM_Proximite VarChar ( 255 ), -- [PM200][PSM]
  @iPos integer, -- [PM200][PSM]
  @sCodeBoutique VarChar ( 5 ), -- [PM200][PSM]
  @iCpt  Integer, -- [PM200][PSM]
  @sPremBtqProxPSM VarChar ( 35 ), -- [PM200_LOT3_V3]
  @iOrangeV3 Integer,
  @iStatusGc Integer, -- [VDOC12845]
  @iDp260 Integer, -- [PM261-1]
  @sVarianteRepaDP235_TVSUP32P VarChar ( 30 ), -- [PC929_CDISCOUNT][PC929-2-V3]
  @sIdTypArt VarChar ( 3 ), -- [PC929_CDISCOUNT][PC929-2-V3]
  @sFraisDP76 VarChar ( 20 ), -- [PC801_6_TAMET]
  @sClientVip Varchar ( 10 ), -- [DT139]
  @sMailCcOrangeVIP Varchar ( 255 ),-- [DT139]
  @iDp279_DT145 Integer, -- [DT145_V4]
  @sNumImeiAnc Varchar ( 50 ), -- [DT145_V4]
  @sARepGarantie Varchar ( 10 ), -- [PM280-1][MANTIS15456]
  @iMobZen3Express Integer , -- [PC151549][MANTIS21978]
  @sIdContratAbonne VarChar ( 20 ), -- [DT361] 
  @sTrigrammeOpe VarChar ( 4 ), -- [DT361] 
  @sLibCie	Varchar ( 35 ), -- [DT361] 
  @sIdAdh	VarChar ( 19 ), -- [DT361] 
  @PiedDePage_SiVotreContratDispo VarChar (20 ), -- [DT386_EXTR_AXA]
  @sNumImeiNouv Varchar ( 50 ), -- [DT361-1]
  @iIdXml integer,
  @dcIdInter Decimal ( 2 ),
  @sCodeMaquette VarChar ( 255 ),
  @sErrOutPut VarChar ( 255 )

  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @asHREFURL = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  Set @asIdAppli = Upper ( @asIdAppli )
  Set @sTypApp = '' -- #12 [DCMP090678]
  Set @sVarianteDiagDP129 = '' -- #12 [DCMP090678]
  Set @sVarianteRepaDP235_TVSUP32P = '' -- [PC929_CDISCOUNT][PC929-2-V3]
  Set @PiedDePage_SiVotreContratDispo = 'A_AFFICHER' -- [DT386_EXTR_AXA]
 
  -- Option de déclenchement du mail -DP
  Set @iOptionDP = 51

  -- [PM103][1]	
  If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
   Begin
	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
	Return 0
   End
  -- :[PM103][1]


  -- Récupération des données standard nécessaires à l'envoi du mail
  
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@asBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT, 
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #2
	@sAltSuiviSMS OUTPUT, -- #7 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #7 [FNAC_PROD_ECH_TECH].[SMS]
	
  
  -- Cas de retour n'étant pas des erreurs
  If @iRet in ( -7, -9, -10 )
   Begin
	Select @asCasRetour =
	Case @iRet
		When -7 Then 'ADRESSE_MAIL_ABSENTE'
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

-- Problème suite éxécution
  If @iRet <> 0 Return @iRet

  -- On mémorise la zone val_car de det_pro -- #4 [SURCOUF_ECH_EXPRESS]
  Select @sValCarDetPro = IsNull ( rtrim ( dp.val_car) + rtrim ( dp.val_car2) , '' )
  From   sysadm.det_pro dp
  Where  dp.id_prod = @dcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = @iOptionDP

	-- [PC151379]
  If sysadm.FN_CLE_VAL ( 'WEB_UNIQUEMENT', @sValCarDetPro, ';' ) = 'OUI' 
	Begin
	 If Not Exists ( 
			Select top 1 1 
			From   sysadm.w_div_sin wds
			Where  wds.id_sin = @adcIdSin
			And    wds.nom_zone = 'alt_decla_web'
			And    wds.val_car = 'O'
		)
		Begin
		  Return 0
		End 
	 End 

-- [RECUP_DONNEE_O2M]
  Select @sDteDecl = CONVERT ( VarChar ( 10 ), ws.dte_decl, 103 )
  From   sysadm.w_sin ws
  Where  ws.id_sin = @adcIdSin
  If @sDteDecl is null Set @sDteDecl = ''

-- #12 JFF  02/12/2009  [DCMP090678]
  Select @sVarianteDiagDP129 = sysadm.FN_CLE_VAL ( 'VARIANTE_DIAG', rtrim ( dp.val_car ), ';' )
  From   sysadm.det_pro dp
  Where  dp.id_prod = @dcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = 129
 
  Select @sTypApp = Upper ( rtrim ( ds.val_car ) )
  From   sysadm.w_div_sin ds
  Where  ds.id_sin = @adcIdSin
  And    ds.nom_zone = 'type_app'
-- :#12 JFF  02/12/2009  [DCMP090678]

-- [PC929_CDISCOUNT][PC929-2-V3]
  Select @sVarianteRepaDP235_TVSUP32P = Upper ( sysadm.FN_CLE_VAL ( 'TVSUP32P', rtrim ( dp.val_car ), ';' ))
  From   sysadm.det_pro dp
  Where  dp.id_prod = @dcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = 235
-- [PC929_CDISCOUNT][PC929-2-V3]

-- [PC151549][MANTIS21978]
If Exists ( 
	Select Top 1 1 
	From   sysadm.det_pro dp,
			sysadm.w_div_sin ds,
			sysadm.w_commande wc
	Where  dp.id_prod = @dcIdProd
	and    dp.id_typ_code_dp = '-DP' 
	and    dp.id_code_dp = 302
	and	 ds.id_sin = @adcIdSin
	And	 ds.nom_zone = 'ech_express_48h'
	And	 ds.val_car = 'O'
	And    wc.id_sin = ds.id_sin
	And	 wc.id_four = 'O2M'
	And    wc.id_ref_four = 'A_DIAGNOSTIQUER'
	And	 wc.cod_etat = 'CNV'
)
Begin 
Set @iMobZen3Express = 1
Set @asCasRetour = 'AUCUNE_PRS_SUR_CRITERE'
Return 0
End 

  -- Sommes-nous dans le cas d'une Réparation non validée ?
  Select @sIdFour = IsNull (c.id_four, '' ),
  	 @iInfoSpbFrn = c.info_spb_frn, -- #5 [DCMP080202]
  	 @sIdRefFour = c.id_ref_four, -- #5 [DCMP080202]
	 @iIdSeq  = c.id_seq, 
	 @dcIdGti = c.id_gti, -- #4 [SURCOUF_ECH_EXPRESS]
	 @dcIdDetail = c.id_detail, -- #4 [SURCOUF_ECH_EXPRESS]
	 @sInfoSpbFrnCplt=c.info_spb_frn_cplt, -- [RECUP_DONNEE_O2M]
	 @iStatusGc = c.status_gc, -- [VDOC12845]
	 @sIdTypArt = c.id_typ_art, -- [PC929_CDISCOUNT][PC929-2-V3]
	 @sNumImeiAnc = IsNull ( rtrim ( c.id_serie_anc ), '' ), -- [DT145_V4]
     @sARepGarantie = IsNull ( sysadm.FN_CLE_VAL ( 'A_REP_GARANTIE', RTRIM ( c.info_spb_frn_cplt), ';' ), '' ), -- [PM280-1][MANTIS15456]
	 @sTrigrammeOpe = rtrim ( c.maj_par ) -- [DT361]
  From   sysadm.w_commande c
  Where  c.id_sin = @adcIdSin
  And 	 c.cod_etat = 'CNV'
-- #14 [MSS_LOT2]
  And Upper ( IsNull ( ( sysadm.FN_CLE_VAL ( 'NO_MAIL', rtrim ( c.info_spb_frn_cplt ), ';' ) ), '' ) ) <> 'OUI'
  And    ( 
 	    ( c.id_four = 'ANV' And c.info_spb_frn in ( 110, 610 ) )  
	 Or ( c.id_four = 'SBE' And c.info_spb_frn = 210 )  
	 Or ( c.id_four = 'SBE' And c.info_spb_frn in ( 910, 961, 982 )) -- [DT141] -- 982 [PC202553_SELECTRA] 
	 Or ( c.id_four = 'COR' And c.info_spb_frn = 310 )  
	 Or ( c.id_four = 'SCF' And c.info_spb_frn = 510 ) -- #4 [SURCOUF_ECH_EXPRESS]
	 Or ( c.id_four = 'O2M' And c.info_spb_frn in ( 410, 415) )  -- #5 [DCMP080202]
	 Or ( c.id_four = 'O2M' And c.info_spb_frn in ( 905, 906, 910, 911, 915, 920, 
	 						925, 930, 935, 936, 940, 941, 945, 
	 						950, 955, 960, 903, 907, 912, 937, 942, 961, 962, 963, 970, 967, 968, 972,
	 						951, 952, 953, 973, 974, 975, 976, 977, 978, 979, 981, 982, 983, 957 ) ) -- [PC929_CDISCOUNT][PC877] #8 [FNAC_PROD_ECH_TECH].[20090224144248310] [FNAC_PROD_ECH_TECH].[20090330152547023] [DCMP090421] -- [PC419/440/418/439_MICROMANIA] -- [PC363].[MAIL_ASS_MATRMP] -- [PC913] -- [PC13321]
	 Or ( c.id_four = 'O2M' And c.info_spb_frn in ( 1010) )  -- Réparation IPHONE 
	 Or ( c.id_four = 'SB1' And c.info_spb_frn in ( 1110, 1115, 1112 ) )  -- #10 [DCMP090327].[SBETV] [PC929-1]
	 Or ( c.id_four = 'MS1' And c.info_spb_frn in ( 1234, 1236, 1237, 1240,
							1255, 1260 ) )  -- #13 [MSS_DIAG] -- #14 [MSS_LOT2] supp 1238, 1256, 1261, 1235
         Or ( c.id_four = 'AXA' And c.info_spb_frn in ( 1710 ) ) -- [GROSBILL].[PC398-403-479]
         Or ( c.id_four = 'AUC' And c.info_spb_frn in ( 1910 ) ) -- [PC363].[MAIL_ASS_BC]
	 Or ( c.id_four = 'PSM' And c.info_spb_frn in ( 2110, 2115, 2116, 2120, 2125, 2130, 2137, 2138, 2139, 2140, 2141, 2142  ) ) -- [PM200][PSM][PC877] [PC801_LOT1_V2] [PC938_ORANGE_V3] [PM255]
	 Or ( c.id_four = 'BLC' And c.info_spb_frn in ( 903,905, 910, 915, 920,908, 913, 938,943,909,914,939,944,907, 912, 937, 942,955, 956, 967, 968,957 ) ) -- [BLCODE]-- [DT148]      
	 Or ( c.id_four = 'MTT' And c.info_spb_frn in ( 910 )) -- [PC13348&13408]
	 Or ( c.id_four = 'TMT' And c.info_spb_frn in ( 2510, 2516 )) -- [PC801_6_TAMET]
	 Or ( c.id_four = 'CEA' And c.info_spb_frn in ( 3110, 3120 )) -- [DT361]
	 )

  If @sIdFour is null Or @sIdFour = '' 
   Begin
	Set @asCasRetour = 'AUCUNE_PRS_SUR_CRITERE'
	Return 0
   End 
 
	If @iStatusGc = 232
	  Begin
		Set @asCasRetour = 'ENVOI_BLOQUE_CAS_NORMAL'
		Return 0		  
	  End 

	--  [PM246][MANTIS10233]
	If sysadm.FN_CLE_VAL ( 'MAJ_ADRESSE', @sInfoSpbFrnCplt, ';') = 'OUI' 
		Begin
			Set @asCasRetour = 'CAS_MAJ_ADRESSE'
			Return 0
		End 
		
	If Len ( sysadm.FN_CLE_VAL ( 'MAJ_PRS', @sInfoSpbFrnCplt, ';')) > 0 
		Begin
			Set @asCasRetour = 'CAS_MAJ_PRS'
			Return 0
		End 

 -- [PC202553_SELECTRA][CDCSINV3]
    If Exists ( 
		Select Top 1 1 
		From sysadm.det_pro dp
		Where dp.id_prod = @dcIdProd
		And dp.id_code_dp = 356
		And sysadm.FN_CLE_VAL ( 'ID_FOUR', rtrim ( val_car ) + rtrim ( val_car2 ), ';' ) = @sIdFour
		And sysadm.FN_CLE_VAL ( 'ID_TYP_ART', rtrim ( val_car ) + rtrim ( val_car2 ), ';' ) = @sIdTypArt 
	  )
	  Begin
		Set @asCasRetour = 'DP356_BLOQUANTE'
		Return 0
	  End 
  
  -- [ADRESSE_O2M]
  If @sIdFour = 'O2M'
    Begin
	    Exec sysadm.PS_S01_ADRESSE_O2M_V01
		@adcIdSin	,
		'',
		@sNomLigne1	OUTPUT,
		@sNomLigne2	OUTPUT,
		@sAdrLigne1	OUTPUT,
		@sAdrLigne2	OUTPUT,
		@sCP		OUTPUT,
		@sVille		OUTPUT
		
		Set @sAdressO2M = ''
		If @sNomLigne1 is not null And Len ( @sNomLigne1 ) > 0 Set @sAdressO2M = @sAdressO2M  + @sNomLigne1 
		
		-- [PM222-1]
		If Exists ( 
			Select Top 1 1
			From   sysadm.w_commande c
			Where  c.id_sin = @adcIdSin
			And    sysadm.FN_CLE_VAL ( 'A_CONTROLER_SAV', RTRIM ( c.info_spb_frn_cplt ), ';' ) = 'OUI'
		  )
		  Begin
			Set @sAdressO2M = rTrim ( @sAdressO2M ) + ' - SAV'
		  End

		If @sAdressO2M is not null And Len ( @sAdressO2M ) > 0 Set @sAdressO2M = @sAdressO2M + @sSaut 
		
		If @sNomLigne2 is not null And Len ( @sNomLigne2 ) > 0 Set @sAdressO2M = @sAdressO2M  + @sNomLigne2 + @sSaut 
		If @sAdrLigne1 is not null And Len ( @sAdrLigne1 ) > 0 Set @sAdressO2M = @sAdressO2M  + @sAdrLigne1 + @sSaut 
		If @sAdrLigne2 is not null And Len ( @sAdrLigne2 ) > 0 Set @sAdressO2M = @sAdressO2M  + @sAdrLigne2 + @sSaut 		
		If @sCP is not null And Len ( @sCP ) > 0 Set @sAdressO2M = @sAdressO2M  + @sCP 
		If @sVille is not null And Len ( @sVille ) > 0 Set @sAdressO2M = @sAdressO2M  + ' ' + @sVille + @sSaut 		
		
    End 
  -- [ADRESSE_O2M]
 
 --  [PM200][PSM]
  If @sIdFour = 'PSM'
    Begin
	    Exec sysadm.PS_S_ADRESSE_CENTRALE_PSM
		@adcIdSin,
		'',
		'MAIL',
		@sNomLigne1	OUTPUT,
		@sNomLigne2	OUTPUT,
		@sAdrLigne1	OUTPUT,
		@sAdrLigne2	OUTPUT,
		@sCP		OUTPUT,
		@sVille		OUTPUT
		
		Set @sAdressCentralePSM = ''
		If @sNomLigne1 is not null And Len ( @sNomLigne1 ) > 0 Set @sAdressCentralePSM = @sAdressCentralePSM  + @sNomLigne1 
		
		-- [PM222-1]
		If Exists ( 
			Select Top 1 1
			From   sysadm.w_commande c
			Where  c.id_sin = @adcIdSin
			And    sysadm.FN_CLE_VAL ( 'A_CONTROLER_SAV', RTRIM ( c.info_spb_frn_cplt ), ';' ) = 'OUI'
		  )
		  Begin
			Set @sAdressCentralePSM = rTrim ( @sAdressCentralePSM ) + ' - Contrôle SAV'
		  End

		If @sAdressCentralePSM is not null And Len ( @sAdressCentralePSM ) > 0 Set @sAdressCentralePSM = @sAdressCentralePSM + @sSaut 
	
		If @sNomLigne2 is not null And Len ( @sNomLigne2 ) > 0 Set @sAdressCentralePSM = @sAdressCentralePSM  + @sNomLigne2 + @sSaut 
		If @sAdrLigne1 is not null And Len ( @sAdrLigne1 ) > 0 Set @sAdressCentralePSM = @sAdressCentralePSM  + @sAdrLigne1 + @sSaut 
		If @sAdrLigne2 is not null And Len ( @sAdrLigne2 ) > 0 Set @sAdressCentralePSM = @sAdressCentralePSM  + @sAdrLigne2 + @sSaut 		
		If @sCP is not null And Len ( @sCP ) > 0 Set @sAdressCentralePSM = @sAdressCentralePSM  + @sCP 
		If @sVille is not null And Len ( @sVille ) > 0 Set @sAdressCentralePSM = @sAdressCentralePSM  + ' ' + @sVille + @sSaut 		
		
		Select @sCodeBtqPSM_Proximite = sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_PROXIMITE', @sInfoSpbFrnCplt, ';')
		
		If Len ( rTrim ( @sCodeBtqPSM_Proximite ) ) > 0 
		 Begin
		   -- J'enlève le premier #
		   Set @sCodeBtqPSM_Proximite = RIGHT ( @sCodeBtqPSM_Proximite, Len ( @sCodeBtqPSM_Proximite ) -1 )
		 End 

		Set @iCpt = 0
		Set @sLstAdresse = ''
		Set @sPremBtqProxPSM = ''
		While Len ( rTrim ( @sCodeBtqPSM_Proximite ) ) > 0
		 begin
			Set @iPos = CharIndex ( '#', @sCodeBtqPSM_Proximite ) 
			If @iPos = 0 Break
			Set @sCodeBoutique = SUBSTRING ( @sCodeBtqPSM_Proximite, 1, @iPos -1 )
			Set @sCodeBtqPSM_Proximite = RIGHT ( @sCodeBtqPSM_Proximite, Len ( @sCodeBtqPSM_Proximite ) - @iPos )

			 Exec sysadm.PS_S_ADRESSE_CENTRALE_PSM
					@adcIdSin,
					@sCodeBoutique,
					'SEL_BOUTIQUE',
					@sNomLigne1	OUTPUT,
					@sNomLigne2	OUTPUT,
					@sAdrLigne1	OUTPUT,
					@sAdrLigne2	OUTPUT,
					@sCP		OUTPUT,
					@sVille		OUTPUT
			If 	@iCpt > 0
			  Begin
				Set @sLstAdresse = @sLstAdresse + @sSaut
				Set @sLstAdresse = @sLstAdresse + @sSaut
			  End
			
			-- [PM200_LOT3_V3]			  			  
			If @iCpt = 0 
			  Begin
				Set @sPremBtqProxPSM = @sNomLigne1
				If @sPremBtqProxPSM is null set @sPremBtqProxPSM = ''
				Set @sPremBtqProxPSM = rTrim ( @sPremBtqProxPSM )
			  End 
			-- [PM200_LOT3_V3]			  			  				 
			  
			If @sNomLigne1 is not null And Len ( @sNomLigne1 ) > 0 Set @sLstAdresse = @sLstAdresse  + @sNomLigne1 + ' '
			If @sNomLigne2 is not null And Len ( @sNomLigne2 ) > 0 Set @sLstAdresse = @sLstAdresse  + @sNomLigne2 
			Set @sLstAdresse = @sLstAdresse + @sSaut 
			If @sAdrLigne1 is not null And Len ( @sAdrLigne1 ) > 0 Set @sLstAdresse = @sLstAdresse  + @sAdrLigne1 + ' '
			If @sAdrLigne2 is not null And Len ( @sAdrLigne2 ) > 0 Set @sLstAdresse = @sLstAdresse  + @sAdrLigne2 
			Set @sLstAdresse = @sLstAdresse + @sSaut 		
			If @sCP is not null And Len ( @sCP ) > 0 Set @sLstAdresse = @sLstAdresse  + @sCP + ' '
			If @sVille is not null And Len ( @sVille ) > 0 Set @sLstAdresse = @sLstAdresse + @sVille 
			
			Set @iCpt = @iCpt + 1

		 End 		
		 
		 -- [MANTIS3281]
		 If @iCpt > 0 
		  Begin
		   Set @sLstAdresse = @sLstAdresse + @sSaut
		  End  
	
    End 
 --  [PM200][PSM]
 
  -- On récupère la variante du mail (1,2,3...)
  -- Rappel des variantes :
  --> Variante 1 : Cas pour toute la téléphonie, envoi vers répateur.
  --> Variante 2 : Cas surcouf échange express, dépose de l'appareil en boutique, code 510
  --> Variante 3 : Cas O2M, cas 410, 415, envoi pour diag sur A_DIAGNOSTIQUER uniquement
  
  -- #5 Variante en dur dans la requête, trop complexe à gérer du det_pro avec l'arrivée des push O2M.
  -- Select @iVarianteMail = Convert ( Integer, sysadm.FN_CLE_VAL ( 'VARIANTE_MAIL', @sValCarDetPro, ';' ) ) -- #4 [SURCOUF_ECH_EXPRESS]

  Select @iVarianteMail = Case
  				When @sIdFour in ( 'SCF' ) And @iInfoSpbFrn in ( 510 ) Then 2
  				When @sIdFour in ( 'O2M' ) And @iInfoSpbFrn in ( 410, 415 ) And @sIdRefFour in ('A_DIAGNOSTIQUER', 'DONNEES_A_RECUPERER' ) Then 3 --[RECUP_DONNEE_O2M]
  				When @sVarianteRepaDP235_TVSUP32P = 'OUI' And @sIdTypArt = 'PRS' And @sIdFour in ( 'O2M' ) And @iInfoSpbFrn in ( 955 ) Then 22 -- JFF      02/06/2014   [PC929_CDISCOUNT][PC929-2-V3]
				WHen @sIdFour in ( 'O2M' ) And @sIdRefFour = 'A_DIAGNOSTIQUER' And sysadm.FN_CLE_VAL ( 'BUYBACK', @sInfoSpbFrnCplt, ';' ) = 'OUI' And @iInfoSpbFrn in ( 912) Then 27 -- -- JFF      15/05/2019   [DT386_EXTR_AXA] BUYBACK
  				When @sIdFour in ( 'O2M' ) And @iInfoSpbFrn in ( 905, 906, 910, 911, 915, 920,
	 									 925, 930, 935, 936, 940, 941, 945,
	 									 950, 955, 960, 903, 907, 912, 937, 942, 961, 962, 963, 967, 968, 972,
	 									 951, 952, 953, 957 ) 
	 									 And ( @sIdRefFour = 'A_DIAGNOSTIQUER' Or @sIdRefFour = 'A_REPARER' ) Then 5 -- [PC929_CDISCOUNT] [PC877] #8  [FNAC_PROD_ECH_TECH].[20090224144248310] [FNAC_PROD_ECH_TECH].[20090330152547023] [DCMP090421] [PC419/440/418/439_MICROMANIA] [PC913] 
-- [PC13321]
  				When @sIdFour in ( 'O2M' ) And @iInfoSpbFrn in ( 973, 974, 975, 976, 977, 978, 979, 981, 982, 983 ) Then 5 --[PC938_ORANGE_V3]
 				When @sIdFour in ( 'ANV' ) And @iInfoSpbFrn in ( 610 ) Then 4
				-- #10 [DCMP090327].[SBETV]  				
  				When @sIdFour in ( 'SB1' ) And @iInfoSpbFrn in ( 1110, 1115, 1112 ) And ( @sIdRefFour = 'A_DIAGNOSTIQUER' Or @sIdRefFour = 'A_REPARER' ) Then 5 -- #8 [FNAC_PROD_ECH_TECH].[20090224144248310] [FNAC_PROD_ECH_TECH].[20090330152547023] [PC929-1]
  				-- #14 [MSS_LOT2] supp 1238, 1256, 1261, 1235
  				When @sIdFour in ( 'MS1' ) And @iInfoSpbFrn in ( 1234, 1236, 1237, 1240,
										 1255, 1260 ) And @sIdRefFour = 'A_DIAGNOSTIQUER' Then 5 -- #13 [MSS_DIAG]
  				When @sIdFour in ( 'AXA' ) And @iInfoSpbFrn in ( 1710 ) Then 6 -- [GROSBILL].[PC398-403-479]
  				--When @sIdFour in ( 'GRB' ) And @iInfoSpbFrn in ( 1810 ) Then 7 -- [GROSBILL].[PC398-403-479]
  				When @sIdFour in ( 'AUC' ) And @iInfoSpbFrn in ( 1910 ) Then 8 -- [PC363].[MAIL_ASS_BC]
  				When @sIdFour in ( 'O2M' ) And @iInfoSpbFrn in ( 970 ) Then 9  -- [PC363].[MAIL_ASS_MATRMP]
  				When @sIdFour in ( 'PSM' ) And @iInfoSpbFrn in ( 2110, 2115 ) Then 10  -- [PM200][PSM][PC877]
 				When @sIdFour in ( 'PSM' ) And @iInfoSpbFrn in ( 2116 ) Then 15  -- [PC801_LOT1_V2]
  				When @sIdFour in ( 'PSM' ) And @iInfoSpbFrn in ( 2120 ) Then 12  -- [PM200][PSM][PC877]
  				When @sIdFour in ( 'PSM' ) And @iInfoSpbFrn in ( 2125 ) Then 13 -- [PM200][PSM][PC877]
  				When @sIdFour in ( 'PSM' ) And @iInfoSpbFrn in ( 2130 ) Then 14 -- [PM200][PSM][PC877]  	
  				When @sIdFour in ( 'PSM' ) And @iInfoSpbFrn in ( 2137 ) Then 16 -- [PC938_ORANGE_V3]
  				When @sIdFour in ( 'PSM' ) And @iInfoSpbFrn in ( 2138 ) Then 17 -- [PC938_ORANGE_V3]  				
  				When @sIdFour in ( 'PSM' ) And @iInfoSpbFrn in ( 2139 ) Then 18 -- [PC938_ORANGE_V3]  				  				
  				When @sIdFour in ( 'PSM' ) And @iInfoSpbFrn in ( 2140 ) Then 19 -- [PC938_ORANGE_V3]  				  				  				
  				When @sIdFour in ( 'PSM' ) And @iInfoSpbFrn in ( 2141 ) Then 20 -- [PC938_ORANGE_V3][PM255] Attention ! mail jamais développé car pour V3, on shunt les mails.
  				When @sIdFour in ( 'PSM' ) And @iInfoSpbFrn in ( 2142 ) Then 21 -- [PC938_ORANGE_V3][PM255]	Attention ! mail jamais développé car pour V3, on shunt les mails.
  				When @sIdFour in ( 'BLC' ) And @iInfoSpbFrn in ( 903,905, 910, 915, 920,908, 913, 938,
  										 943,909,914,939,944,907, 912, 937, 942,955, 956, 967, 968, 957 ) And @sIdRefFour = 'A_DIAGNOSTIQUER' Then 11 -- [BLCODE]-- [DT148]      
				When @sIdFour in ( 'MTT' ) And @iInfoSpbFrn in ( 910 ) Then 5 -- [PC13348&13408]
				When @sIdFour in ( 'TMT' ) And @iInfoSpbFrn in ( 2510 ) Then 24  -- [PC801_6_TAMET]
				When @sIdFour in ( 'TMT' ) And @iInfoSpbFrn in ( 2516 ) Then 23  -- [PC801_6_TAMET]
				When @sIdFour in ( 'SBE' ) And @iInfoSpbFrn in ( 910, 961, 982 ) Then 5 -- [DT141] -- 982 [PC202553_SELECTRA] 
				When @sIdFour in ( 'CEA' ) And @iInfoSpbFrn in ( 3110 ) Then 25 -- [DT361]
				When @sIdFour in ( 'CEA' ) And @iInfoSpbFrn in ( 3120 ) Then 26 -- [DT361]
  				Else 1
  			  End

  -- Recherche supplèmentaire pour détection de a quarantaine par fournisseur.  
  If @sAltQuarant = 'N' 
   Begin
	  -- Le code de l'option de quarantaine est lié à l'option de déclenchement du mail.
	  Select @sAltQuarant = 
		 Case 
		   When d2.id_prod > 0 Then 'O'
		   Else 'N'
		 End 
	  From   sysadm.det_pro d,
		 sysadm.det_pro d2
	  where  d.id_prod = @dcIdProd
	  and    d.id_typ_code_dp = '-DP' 
	  and    d.id_code_dp = @iOptionDP 
	  and    d2.id_prod = d.id_prod
	  and    d2.id_typ_code_dp = '-DP'  
	  and    d2.id_code_dp = d.val_num
	  And    d2.id_code_car = @sIdFour 
   End 

-- Initialisation d'autres variables nécessaire en fonction des variantes possible du mail
-- #4 [SURCOUF_ECH_EXPRESS]
   Select  @sMagasin = ( 
   			Select  sysadm.FN_TRIM (
   					Convert ( VarChar ( 20 ), b.id_boutique) + ' ' + 
   					sysadm.FN_TRIM ( IsNull ( adr_ville , '' ) ) + ' ' + 
   					sysadm.FN_TRIM ( IsNull ( adr_cp , '' )) + ' ' + 
   					sysadm.FN_TRIM ( IsNull ( adr_nom , '' )) 
   				)
   			from 	sysadm.boutique b
   			Where   b.id_prod = ws.id_prod
   			And     b.id_boutique = ws.id_orian_boutique
   			),
   	   @sIdSin = sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, ws.id_sin ), 10 ) ), -- [PI062]
   	   @sNumSerie = IsNull ( sysadm.FN_TRIM (ws.num_imei_port), '' ),
	   @sDteAchat = Case 
	   			When ( Select count (*) from sysadm.det_pro dp 
	   			       where dp.id_prod = @dcIdProd And dp.id_code_dp = 42 and dp.id_code_car = 'A' ) > 0 Then
	   			       		IsNull ( Convert ( VarChar ( 10 ) , wd.dte_det , 103), '' ) 

	   			Else IsNull ( Convert ( VarChar ( 10 ) , ws.dte_ach_port , 103), '' )
	   		End,
	   @sValAchat = IsNull ( Convert ( VarChar ( 15), wd.mt_val_achat ), '0.00' ) + '€',
	   @sMarque = IsNull ( sysadm.FN_TRIM ( ws.marq_port ), '') , -- #4 [SURCOUF_ECH_EXPRESS]
	   @sModele = IsNull ( sysadm.FN_TRIM ( ws.modl_port ), ''),   -- #4 [SURCOUF_ECH_EXPRESS]
	   @sIdContratAbonne = IsNull ( rTrim ( ws.id_contrat_abonne ), '' ),  -- [DT361]
	   @sIdAdh = IsNull ( rTrim ( ws.id_adh ) , '' )   -- [DT361]

   From    sysadm.w_sin ws,
   	   sysadm.w_detail wd
   Where   ws.id_sin = @adcIdSin
   And 	   wd.id_sin = ws.id_sin
   And     wd.id_gti = @dcIdGti 
   And     wd.id_detail = @dcIdDetail

-- #4 [SURCOUF_ECH_EXPRESS]
   Select  @sSKU = IsNull ( sysadm.FN_TRIM ( wds.val_car ), '' )
   From	   sysadm.w_div_sin wds
   Where   wds.id_sin = @adcIdSin
   And     wds.nom_zone = 'sku_ident_appareil'
-- #12 [20091210115141760]
   If @sSKU is null Set @sSKU = ''

-- #4 [SURCOUF_ECH_EXPRESS]
   Select  @sNumPanier = IsNull ( Convert ( VarChar ( 20 ), wds.val_nbre ), '' )
   From	   sysadm.w_div_sin wds
   Where   wds.id_sin = @adcIdSin
   And     wds.nom_zone = 'num_panier'
-- #12 [20091210115141760]
   If @sNumPanier is null Set @sNumPanier = ''


-- #4 [SURCOUF_ECH_EXPRESS]
   Select  @sNumFaxProd = sysadm.FN_TRIM (
  			Case Left ( p.num_fax, 2 )
  				When '08' Then Left ( p.num_fax, 1 ) + ' ' + SubString ( p.num_fax, 2, 3 ) + ' ' + SubString ( p.num_fax, 5, 3 ) + ' ' + SubString ( p.num_fax, 8, 3 )
  				Else Left ( p.num_fax, 2 ) + ' ' + SubString ( p.num_fax, 3, 2 ) + ' ' + SubString ( p.num_fax, 5, 2 ) + ' ' + SubString ( p.num_fax, 7, 2 ) + ' ' + SubString ( p.num_fax, 9, 2 )
  			End 
  			),
	   @sNumTelProd = sysadm.FN_TRIM (
  			Case Left ( p.num_tel, 2 )
  				When '08' Then Left ( p.num_tel, 1 ) + ' ' + SubString ( p.num_tel, 2, 3 ) + ' ' + SubString ( p.num_tel, 5, 3 ) + ' ' + SubString ( p.num_tel, 8, 3 )
  				Else Left ( p.num_tel, 2 ) + ' ' + SubString ( p.num_tel, 3, 2 ) + ' ' + SubString ( p.num_tel, 5, 2 ) + ' ' + SubString ( p.num_tel, 7, 2 ) + ' ' + SubString ( p.num_tel, 9, 2 )
  			End 
  			)  			
   From	   sysadm.produit p
   Where   p.id_prod = @dcIdProd
-- #12 [20091210115141760]
   If @sNumFaxProd is null Set @sNumFaxProd = ''


-- #4 [SURCOUF_ECH_EXPRESS]   
   Select @sHoraireOuv = sysadm.FN_TRIM ( IsNull ( dp.val_car, '' ) )
   From   sysadm.det_pro dp
   Where  dp.id_prod = @dcIdProd
   and    dp.id_typ_code_dp = '-DP' 
   and    dp.id_code_dp = 84   
-- #12 [20091210115141760]
   If @sHoraireOuv is null Set @sHoraireOuv = ''


-- #4 [SURCOUF_ECH_EXPRESS]   
   Select @sCoutTel = sysadm.FN_TRIM ( IsNull ( dp.val_car, '' ) )
   From   sysadm.det_pro dp
   Where  dp.id_prod = @dcIdProd
   and    dp.id_typ_code_dp = '-DP' 
   and    dp.id_code_dp = 70   
-- #12 [20091210115141760]
   If @sCoutTel is null Set @sCoutTel = ''

-- [GROSBILL].[PC398-403-479]   
   Select @sDP66 = sysadm.FN_TRIM ( IsNull ( dp.val_car, '' ) )
   From   sysadm.det_pro dp
   Where  dp.id_prod = @dcIdProd
   and    dp.id_typ_code_dp = '-DP' 
   and    dp.id_code_dp = 66 
   If @sDP66 is null Set @sDP66 = ''
   If @sDP66 = ''
     Begin
     	Select @sDP66 = rtrim ( lower ( p.lib_long ))
     	From sysadm.produit p
     	where p.id_prod = @dcIdProd
     End 

   Select @sDP67 = sysadm.FN_TRIM ( IsNull ( dp.val_car, '' ) )
   From   sysadm.det_pro dp
   Where  dp.id_prod = @dcIdProd
   and    dp.id_typ_code_dp = '-DP' 
   and    dp.id_code_dp = 67 
   If @sDP67 is null Set @sDP67 = ''
   If @sDP67 = ''
     Begin
     	Select @sDP67 = rtrim ( lower ( p.lib_long ))
     	From sysadm.produit p
     	where p.id_prod = @dcIdProd
     End 

   Select @sLibPolice = rTrim ( p.lib_police ),
		  @sLibCie = rTrim ( cie.lib_cie) -- [DT361]
   From	sysadm.sinistre s,
   	sysadm.garantie g,
   	sysadm.police p,
	sysadm.compagnie cie
   Where s.id_sin = @adcIdSin
   And   g.id_prod = s.id_prod
   And   g.id_rev = s.id_rev
   And   g.id_gti = @dcIdGti
   And   p.id_police = g.id_police
   And   cie.id_cie = p.id_cie -- [DT361]
   If @sLibPolice is null Set @sLibPolice = ''

   Select @sPropo1 = val_car
   From sysadm.w_div_det d
   where d.id_sin=@adcIdSin
   And d.id_gti = @dcIdGti
   And d.id_detail=@dcIdDetail
   And d.nom_zone='propo_app_1'
   
   Select @sPropo2 = val_car
   From sysadm.w_div_det d
   where d.id_sin=@adcIdSin
   And d.id_gti = @dcIdGti
   And d.id_detail=@dcIdDetail
   And d.nom_zone='propo_app_2'
   
   If @sPropo1 is null Set @sPropo1 = ''
   If @sPropo2 is null Set @sPropo2 = ''
  
-- :[GROSBILL].[PC398-403-479]

-- [PC363].[MAIL_ASS_BC]
  Select @smtPec = Convert ( varchar ( 15 ), wd.val_mt )
  From   sysadm.w_div_det wd
  Where  wd.id_sin = @adcIdSin
  And 	 wd.id_gti = @dcIdGti 
  And 	 wd.id_detail= @dcIdDetail 
  And 	 wd.nom_zone = 'mt_pec'
  If @smtPec is null Set @smtPec = '0.00'
  Set @smtPec = @smtPec + ' €'
-- [PC363].[MAIL_ASS_BC]

-- [PC363].[MAIL_ASS_MATRMP]
  Select @MarqueRemplO2M = sysadm.FN_CLE_VAL ( 'MARQUE_REMPL', rtrim ( c.info_frn_spb_cplt ), ';' ),
  	 @ModeleRemplO2M = sysadm.FN_CLE_VAL ( 'MODELE_REMPL', rtrim ( c.info_frn_spb_cplt ), ';' )
  From   sysadm.w_commande c
  Where  c.id_sin = @adcIdSin
  And    c.id_typ_art in ( 'EDI' ) 
  And    c.id_four = 'O2M'
  And    Upper ( IsNull ( sysadm.FN_CLE_VAL ( 'MARQUE_REMPL', rtrim ( c.info_frn_spb_cplt ), ';' ) , '' ) ) <> ''
-- [PC363].[MAIL_ASS_MATRMP]
  If @MarqueRemplO2M is null Set @MarqueRemplO2M = ''
  If @ModeleRemplO2M is null Set @ModeleRemplO2M = ''

  -- [RECUP_DONNEE_O2M]  
  Select @sDP205 = sysadm.FN_TRIM ( IsNull ( dp.val_car, '' ) )
  From   sysadm.det_pro dp
  Where  dp.id_prod = @dcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = 205 
  If @sDP205 is null Set @sDP205 = ''  
  
-- [PM261-1]
	select @iDp260=COUNT(*)
	From   sysadm.det_pro dp
	  Where  dp.id_prod = @dcIdProd
	  and    dp.id_typ_code_dp = '-DP' 
	  and    dp.id_code_dp = 260 

-- [PC801_6_TAMET]
  Select @sFraisDP76 = Convert ( VarChar ( 20 ) , dp.val_num )
  From   sysadm.det_pro dp
  Where  dp.id_prod = @dcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = 76 
  and    dp.id_code_num = @iInfoSpbFrn
  And    dp.id_typ_calc = '-IF'
  If @sFraisDP76  is null Set @sFraisDP76  = '' 
  If Len ( @sFraisDP76 ) > 0 Set @sFraisDP76 = @sFraisDP76 + '€'
  
	-- [DT139]
	-- [VDOC17642]
	Select @sClientVip = rtrim ( ds.val_car )
	From   sysadm.w_div_sin ds,
		   sysadm.w_sin s,
		   sysadm.det_pro dp 
	Where  ds.id_sin = @adcIdSin
	And	   ds.nom_zone = 'client_vip'
	And	   s.id_sin = ds.id_sin 
	And	   dp.id_prod = s.id_prod
	And    dp.id_code_dp = 272
	
	If @sClientVip is null Set @sClientVip = ''
	
	If @sClientVip In ( 'SEN', 'SEM' ) 
	 Begin
		Set @sMailCcOrangeVIP = 'vip@orange.com,franck.bonnard@orange.com' -- [VDOC17642] [VDOC20329]
	 End 

	If @sClientVip In ( 'ASN' ) 
	 Begin
		-- [VDOC19724]
		Set @sMailCcOrangeVIP = 't.munier@senat.fr,franck.bonnard@orange.com' -- [VDOC17642] [VDOC20329]
	 End 

	 -- [DT346]
	If @sClientVip In ( 'VIPPAR' ) 
		Begin
			-- le MailSend n'est pas une erreur, on n'envoie rien à l'assuré.
			Set @sMailSend = 'laura.naulot@orange.com,desk@parnasse.fr' -- [DT346]	 
		End 


-- [DT145_V4]
-- [DT19-2][MANTIS20753]
select @iDp279_DT145 = COUNT(*)
From   sysadm.det_pro dp,
	   sysadm.commande c
Where   dp.id_prod = @dcIdProd
and     dp.id_typ_code_dp = '-DP' 
and     dp.id_code_dp = 279 
And		c.id_sin = @adcIdSin
And		c.id_seq = @iIdSeq
And		c.id_ref_four in ( 'A_REPARER', 'A_DIAGNOSTIQUER', 'A_DESOXYDER' )


  
--  [VDOC12443]
Exec sysadm.PS_I_MAIL_IOS7_VDOC12443 @asIdAppli, @asBase, @iOptionDP, @adcIdSin
--  [VDOC12443]

--------------------------------------------------------------------------------------------------------------------
-- Construction du mail.
--------------------------------------------------------------------------------------------------------------------
  
  -- Mail Send
  If @iVarianteMail = 2 -- #4 [SURCOUF_ECH_EXPRESS]
   Begin
	Set @sMailSend = @sMailSend + ',surcoufechangeexpress@spb.fr'
   End     	  
  
  -- Gestion de la civilité "Madame, Monsieur"
  If @sNom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sNom + ','
   End 

--------------------------------------------------------------------------------------------------------------------
  -- Armement de l'objet du mail
  If @iVarianteMail in ( 1,3,4,5,6,10,11,12,13,14,15,16,17,18,19,22,23,24, 27 ) -- #4 [PC801_LOT1_V2][SURCOUF_ECH_EXPRESS] -- #5 [DCMP080202] -- #8 [FNAC_PROD_ECH_TECH].[20090224144248310] -- [BLCODE]
   Begin
  	Set @sMailObjet = 'Votre dossier n°' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) + ' ' + @sLibProd -- [PI062]
   End     	

  If @iVarianteMail = 2 -- #4 [SURCOUF_ECH_EXPRESS]
   Begin
	Set @sMailObjet = 'Assurance Echange Express SURCOUF - Dépôt de votre appareil pour diagnostic - '
   End     	

  If @iVarianteMail in (25, 26) -- [DT361]
   Begin
	Set @sMailObjet = 'Assurance Garanties Dommages Smartphone & Tablette – SPB - ' + Convert ( VarChar, @adcIdSin ) + ' - Certificat n°' + @sIdContratAbonne 
   End     	
 
   If @iVarianteMail in (27) -- [DT386_EXTR_AXA]
   Begin
	Set @sMailObjet = @sMailObjet + ' - Imprimez votre bon Chronopost prépayé'
   End  

--------------------------------------------------------------------------------------------------------------------
  -- Corps du mail

  If @iVarianteMail in (27) -- [DT386_EXTR_AXA]
   Begin
    Set @PiedDePage_SiVotreContratDispo = 'A_NE_PAS_AFFICHER' -- [DT386_EXTR_AXA]

   	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Une demande de reprise concernant votre bien de marque ' + @sMarque + ' vient d''être transmise à notre centre de diagnostic. '
	Set @sMailBody  = @sMailBody  + 'Afin de nous transmettre votre bien, merci de vous connecter à l''adresse mail suivante : www.monbondetransport.fr, pour télécharger et imprimer un bon prépayé Chronopost.' + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Pour vous connecter, télécharger et imprimer le bon prépayé, vous devrez indiquer votre numéro de dossier: ' + Convert ( VarChar, @adcIdSin ) + '. Le bon prépayé devra être collé de façon visible sur l’emballage.' + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Veillez à nous envoyer votre bien, en respectant les consignes qui vous ont été données dans le précédent mail pour le transport de l''appareil et (la ou les) pièce(s) à joindre, à l''adresse qui figurera sur l''étiquette.' + @sSaut
	Set @sMailBody  = @sMailBody  + 'Vous devez mettre dans l''emballage, votre appareil accompagné impérativement de tous les accessoires d''origine (manuel, batterie amovible, alimentation externe, etc).' + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Pour toute demande d''information concernant le bon prépayé, merci de nous contacter à l''adresse suivante : poleclient@spb-services.eu' + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous attirons votre attention sur les risques que court votre matériel lors de son transport vers nos ateliers : vibrations, chocs, manipulations rapides. Les éventuelles détériorations ou dommages subis pendant le transport pouvant vous empêcher de faire valoir votre garantie d’assurance, nous vous demandons de respecter notamment les consignes ci-dessous :' + @sSaut
	Set @sMailBody  = @sMailBody  + '-    Autant que possible, laissez votre appareil dans son emballage d’origine ou mettez l’emballage d’origine dans l’emballage que vous utiliserez pour l’envoi, pour plus de sécurité.' + @sSaut
	Set @sMailBody  = @sMailBody  + '-    Ne laissez pas l’appareil que vous envoyez en contact direct avec le carton d’envoi. Calez-le pour éviter tout mouvement dans ce carton (papier journal, papier-bulles, chiffons…)' + @sSaut
	Set @sMailBody  = @sMailBody  + '-    En cas de casse survenue lors du transport en raison d’une protection de l’appareil insuffisante de votre part, votre dossier de sinistre ne sera pas pris en charge et votre appareil vous sera restitué en l’état.'+ @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
 
   End 

  If @iVarianteMail in (25, 26) -- [DT361]
   Begin
	Set @sMailBody  = @sMailBody  + 'Dossier n°' + Convert ( VarChar, @adcIdSin ) + '/' + @sTrigrammeOpe + @sSaut
	Set @sMailBody  = @sMailBody  + @sDP66 + ' ' + @sDP67 + @sSaut
	Set @sMailBody  = @sMailBody  + 'Assureur : ' + @sLibCie + @sSaut
	Set @sMailBody  = @sMailBody  + 'Police n°' + @sLibPolice + @sSaut
	Set @sMailBody  = @sMailBody  + 'N° de certificat SAMSUNG : ' + @sIdContratAbonne + @sSaut
	Set @sMailBody  = @sMailBody  + 'N° adhésion : ' + @sIdAdh + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sCiv + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut

    If @iVarianteMail in ( 25 ) -- RPUp
	 Begin
		Set @sMailCc = 'sef-pack@samsung.com,svc.pro@samsung.com'

		Set @sMailBody  = @sMailBody  + 'Lors de votre déclaration de sinistre dans le cadre de la Garantie SAMSUNG - Dommages Smartphone & Tablette option Pick Up, vous avez été mis en relation avec la Hotline Samsung pour définir les modalités d''enlèvement de votre matériel sinistré.' + @sSaut
		Set @sMailBody  = @sMailBody  + @sSaut
		Set @sMailBody  = @sMailBody  + 'La Hotline Samsung vous confirmera alors par mail les détails de l’enlèvement de votre matériel sinistré.' + @sSaut
		Set @sMailBody  = @sMailBody  + @sSaut
		Set @sMailBody  = @sMailBody  + 'Dans l''éventualité où vous n''auriez pas été mis en relation avec la Hotline Samsung ou si vous avez besoin de la contacter pour obtenir des détails sur l''enlèvement de votre matériel sinistré, nous vous rappelons les modalités de contact : ' + @sSaut
		Set @sMailBody  = @sMailBody  + 'Par téléphone : 0825 022 062 (0.15€ TTC/min) du lundi au vendredi de 09h à 18h' + @sSaut
		Set @sMailBody  = @sMailBody  + 'Par mail : sef-pack@samsung.com' + @sSaut
	 End 

    If @iVarianteMail in ( 26 ) -- Carry In
	 Begin
		Set @sMailBody  = @sMailBody + 'Vous nous avez déclaré un sinistre le ' + @sDteDecl + ' dans le cadre de votre contrat ' + @sDP66 + ' ' + @sDP67 + ' qui couvre votre appareil ' + @sMarque + ' ' + @sModele + '.' + @sSaut
		Set @sMailBody  = @sMailBody + @sSaut
		Set @sMailBody  = @sMailBody + 'Afin d''étudier votre dossier dans son intégralité, nous vous remercions de bien vouloir envoyer au plus tôt votre appareil endommagé (sans les accessoires, ni carte SIM car ceux-ci ne vous seront pas restitués) par le biais d’un colissimo de la Poste adapté à la taille de celui-ci, à l’adresse suivante :' + @sSaut
		Set @sMailBody  = @sMailBody + @sSaut
		Set @sMailBody  = @sMailBody + 'CEAT' + @sSaut
		Set @sMailBody  = @sMailBody + 'SEF PACK' + @sSaut
		Set @sMailBody  = @sMailBody + '13 Rue du 19 Mars 1962'+ @sSaut
		Set @sMailBody  = @sMailBody + '21600 LONGVIC' + @sSaut
		Set @sMailBody  = @sMailBody + @sSaut
		Set @sMailBody  = @sMailBody + 'Merci d''indiquer obligatoirement à l''intérieur votre colis les références suivantes :' + @sSaut
		Set @sMailBody  = @sMailBody + '- Numéro de certificat d’adhésion SAMSUNG : ' + @sIdContratAbonne + @sSaut
		Set @sMailBody  = @sMailBody + '- Numéro de dossier de sinistre SPB : ' + Convert ( VarChar, @adcIdSin ) + @sSaut
		Set @sMailBody  = @sMailBody + @sSaut
		Set @sMailBody  = @sMailBody + 'Afin de protéger vos données personnelles, vous devez impérativement sauvegarder, puis effacer le contenu (photos, contacts, mails…) et réglages de votre appareil avant l''envoi à notre centre technique. Nous ne pourrons en aucun cas être tenus responsables de tout dommage qui résulterait de la perte ou du vol de vos données personnelles et/ou de leur utilisation par des tiers à quelque fin que ce soit.' + @sSaut
		Set @sMailBody  = @sMailBody + @sSaut
		Set @sMailBody  = @sMailBody + 'Si votre appareil est protégé par un code verrou, merci de le désactiver ou bien, à défaut, de l''apposer à votre appareil.' + @sSaut
		Set @sMailBody  = @sMailBody + @sSaut
		Set @sMailBody  = @sMailBody + 'Veiller à faire signer et/ou tamponner votre preuve de dépôt ou d''envoi et la conserver. En cas de litige avec le transporteur, ce document peut vous être demandé.' + @sSaut
		Set @sMailBody  = @sMailBody + @sSaut
		Set @sMailBody  = @sMailBody + 'Si votre téléphone mobile s''avère irréparable, celui-ci fera l''objet d''un remplacement (**) qui peut s''avérer iso-fonctionnel c''est-à-dire possédant les mêmes caractéristiques techniques principales que l''appareil garanti, dans la limite de ' + @smtPec + ' correspondant à la valeur de votre appareil à la date du sinistre.' + @sSaut
		Set @sMailBody  = @sMailBody + @sSaut
		Set @sMailBody  = @sMailBody + '** : Selon la définition mentionnée dans la Notice d''information' + @sSaut
	 End 

	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Sincères salutations' + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Votre gestionnaire d''assurance' + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'SPB - ' + @sDP66 + ' ' + @sDP67 + @sSaut
	Set @sMailBody  = @sMailBody  + 'CS 9000 - ' + @sSaut
	Set @sMailBody  = @sMailBody  + '76095 Le Havre Cedex' + @sSaut
	Set @sMailBody  = @sMailBody  + 'Tél. : ' + @sNumTelProd + @sSaut
	Set @sMailBody  = @sMailBody  + @sCoutTel + ' ' + @sHoraireOuv + @sSaut
   End     	



  If @iVarianteMail in ( 8, 9 ) -- [PC363].[MAIL_ASS_BC] -- [PC363].[MAIL_ASS_MATRMP]
   Begin
	Set @sMailObjet = @sDP66 + ' - Votre demande d''indemnisation'
	
	Set @sMailBody  = @sMailBody  + 'Bonjour,'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Nous faisons suite à votre dossier sinistre '+ @sDP66 + ' ' + @sLibPolice + ' ouvert dans nos services.'	
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	
	If @iVarianteMail in ( 8 ) 
	 Begin 	
		Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer qu''une Carte cadeau d''un montant de ' + @smtPec 
		Set @sMailBody  = @sMailBody  + ' vous parviendra par courrier séparé afin de vous permettre de remplacer votre appareil.'
	 End

	If @iVarianteMail in ( 9 ) 
	 Begin 	
		Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer de la commande ce jour d''un ' + @MarqueRemplO2M + ' ' +  @ModeleRemplO2M + ' en règlement de votre sinistre.'
		Set @sMailBody  = @sMailBody  + @sSaut	
		Set @sMailBody  = @sMailBody  + @sSaut	
		set @sMailBody  = @sMailBody  + 'Cet appareil vous sera livré dans les jours à venir par colis à votre domicile et nous vous en souhaitons bonne réception.'
	 End
 
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Pour tout renseignement, vous pouvez nous contacter au ' + @sNumTelProd + ' (*)'
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Cordialement.'
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Votre gestionnaire.'	
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + '(*)Numéro facturé au prix d''une communication locale, régionale ou nationale, selon les offres de chaque opérateur'
	
   End     	

  If @iVarianteMail in ( 7 ) -- [GROSBILL].[PC398-403-479]
   Begin
	Set @sMailObjet = 'Garantie ' + @sDP66 + ' - Prise en charge'
	
	Set @sMailBody  = @sMailBody  + 'Contrat ' + @sLibPolice 
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Bonjour,'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer de la prise en charge de votre dossier concernant le remplacement de votre '
	Set @sMailBody  = @sMailBody  + @sMarque + ' ' + @sModele + '.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'A cet effet, nous vous proposons de remplacer cet appareil, par un des appareils suivants :'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sPropo1
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'ou'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sPropo2
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Vous pouvez visualiser ces appareils en consultant le site www.grosbill.com.'
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Afin de valider cette proposition et de nous permettre de procéder rapidement à la commande de l’appareil, nous vous invitons à nous contacter par téléphone au ' 
	Set @sMailBody  = @sMailBody  + @sNumTelProd + ', du lundi au samedi de 8H à 20H, ou de nous donner votre accord par retour de mail (assurancesgrosbill@spb.eu) en nous précisant l’appareil retenu.'
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Pour tout renseignement, vous pouvez nous contacter au Tél. : '+ @sNumTelProd + ' '
	Set @sMailBody  = @sMailBody  + @sSaut		
	Set @sMailBody  = @sMailBody  + 'Fax : ' + @sNumFaxProd + ' '
	Set @sMailBody  = @sMailBody  + @sSaut		
	Set @sMailBody  = @sMailBody  + 'Mail : assurancesgrosbill@spb.eu'
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Cordialement.'
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Assurances GrosBill.com'	
	
   End     	

  
    -- [PC929_CDISCOUNT][PC929-2-V3]
  If @iVarianteMail in ( 22 ) 
   Begin
	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut

	Set @sMailBody  = @sMailBody  + 'Notre centre de réparation va prendre contact avec vous pour fixer un rendez-vous à votre domicile pour tenter de réparer l''appareil sinistré.'
	Set @sMailBody  = @sMailBody  + @sSaut
	
	If @sIdFour = 'O2M'
		Begin 
			Set @sMailBody  = @sMailBody  + 'Si cela est possible, un diagnostic vidéo pourra également vous être proposé.'
			Set @sMailBody  = @sMailBody  + @sSaut
		End 

	Set @sMailBody  = @sMailBody  + 'Si cette réparation n''est pas possible à domicile, un transporteur enlèvera l''appareil pour tenter de réparer celui-ci en station.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Le transporteur utilisera un emballage spécial pour transporter votre appareil.'

	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Joignez à votre appareil :'
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + '- La facture d''achat de votre appareil'
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + '- Une copie du bulletin d''adhésion'
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + '- Les accessoires d’origine'


	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Veuillez indiquer obligatoirement au transporteur votre numéro d''intervention SPB.'
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Le n° de Référence SPB : ' + @sIdSin + '-' + Convert ( Varchar (3), @iIdSeq )
--	Set @sMailBody  = @sMailBody  + 'Information à fournir obligatoirement : Le n° de commande SPB : ' + @sIdSin + '-' + Convert ( Varchar (3), @iIdSeq )
	-- :#12 [DCMP090678]	 

	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
   	
   End 
	-- [PC929_CDISCOUNT][PC929-2-V3]
  
  -- [GROSBILL].[PC398-403-479]
  If @iVarianteMail in ( 6 ) 
   Begin
	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Une demande de réparation de votre matériel vient d''être envoyée à AXA.'
   	Set @sMailBody  = @sMailBody  + @sSaut
   	Set @sMailBody  = @sMailBody  + 'AXA prendra contact avec vous pour fixer une date et heure de rendez-vous.'

	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Veuillez indiquer obligatoirement au transporteur votre numéro d''intervention SPB.'
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Le n° de Référence SPB : ' + @sIdSin + '-' + Convert ( Varchar (3), @iIdSeq )
--	Set @sMailBody  = @sMailBody  + 'Information à fournir obligatoirement : Le n° de commande SPB : ' + @sIdSin + '-' + Convert ( Varchar (3), @iIdSeq )
	-- :#12 [DCMP090678]	 

	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
   	
   End 


  -- [PC877]
  If @iVarianteMail in ( 13 ) 
   Begin
	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut

	-- [PC929-1]
	If @sIdRefFour = 'A_DIAGNOSTIQUER' 
	  Begin
		Set @sMailBody  = @sMailBody  + 'A la suite de votre déclaration de sinistre du ' + @sDteDecl + ', vous pouvez bénéficier d''un diagnostic de votre ' + @sMarque + ' ' + @sModele + ' dans le réseau national « Point Service Mobiles »'   	  
	  End 
  	Else
	  Begin  	
  		Set @sMailBody  = @sMailBody  + 'A la suite de votre déclaration de sinistre du ' + @sDteDecl + ', vous pouvez bénéficier d''une réparation de votre ' + @sMarque + ' ' + @sModele + ' dans le réseau national « Point Service Mobiles »'   
	  End 
	    		
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
  	
	Set @sMailBody  = @sMailBody  + 'Notre réparateur prendra prochainement contact avec vous une intervention à votre domicile.'

	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	
	If @iDp260 > 0 
    Begin
		Set @sMailBody  = @sMailBody  + 'Nous vous rappelons que l''appareil devient la propriété de l''assurance si celui-ci est irréparable. ' + @sSaut
		Set @sMailBody  = @sMailBody  + @sSaut
    End 

	If @iDp279_DT145 > 0 And 
	   @sIdFour in ('O2M','PSM') And 
	   @dcIdGti in ( 11, 24 )
		Begin
			Set @sMailBody  = @sMailBody  + 'Le n° IMEI attendu pour votre appareil sinistré est le : ' + @sNumImeiAnc + '. Si à réception et lors du contrôle de votre appareil par notre centre technique le n° IMEI s''avère différent, votre demande de prise en charge ne pourra pas recevoir une suite positive. Nous vous remercions de bien vouloir le vérifier avant votre envoi.' 
			Set @sMailBody  = @sMailBody  + @sSaut + @sSaut
		End 

	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
   End 
 
  If @iVarianteMail in (  16, 17, 18, 19 )
   Begin
	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut

	-- [PC929-1]
	If @sIdRefFour = 'A_DIAGNOSTIQUER' 
	  Begin
  		Set @sMailBody  = @sMailBody  + 'A la suite de votre déclaration de sinistre du ' + @sDteDecl + ', vous pouvez bénéficier d''un diagnostic de votre ' + @sMarque + ' ' + @sModele + ' dans le réseau national « Point Service Mobiles »'
  	  End
  	Else
	  Begin
  		Set @sMailBody  = @sMailBody  + 'A la suite de votre déclaration de sinistre du ' + @sDteDecl + ', vous pouvez bénéficier d''une réparation de votre ' + @sMarque + ' ' + @sModele + ' dans le réseau national « Point Service Mobiles »' 
	  End
	    	 
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	
    If @iVarianteMail in ( 16 ) -- O2M>LProAssPret+RecupAppSin>PSM
     Begin
		Set @sMailBody  = @sMailBody  + 'Pour cela, un transporteur viendra sur votre lieu professionnel vous apporter un appareil de prêt et il récupérera votre appareil sinistré, pensez donc à l''avoir avec vous.'
     End 

    If @iVarianteMail in ( 17 ) -- O2M>DomAssPret+RecupAppSin>PSM
     Begin
		Set @sMailBody  = @sMailBody  + 'Pour cela, un transporteur viendra à votre domicile vous apporter un appareil de prêt et il récupérera votre appareil sinistré, pensez donc à l''avoir avec vous.'
     End 
    
    If @iVarianteMail in ( 18 ) -- O2M>LProAss+RecupAppSin>PSM
     Begin
		Set @sMailBody  = @sMailBody  + 'Pour cela, un transporteur viendra sur votre lieu professionnel récupérer votre appareil sinistré, pensez donc à l''avoir avec vous.'
     End 

    If @iVarianteMail in ( 19 ) -- O2M>DomAss+RecupAppSin>PSM
     Begin
		Set @sMailBody  = @sMailBody  + 'Pour cela, un transporteur viendra à votre domicile récupérer votre appareil sinistré, pensez donc à l''avoir avec vous.'
     End 


	If @sTypApp = 'TEL'
		Begin
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Votre appareil doit être remis au transporteur :'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + '- avec sa batterie'
			Set @sMailBody  = @sMailBody  + @sSaut			
			Set @sMailBody  = @sMailBody  + '- sans carte SIM ni carte Mémoire'
			Set @sMailBody  = @sMailBody  + @sSaut			
		End

	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	
	If @iDp260 > 0
    Begin
		Set @sMailBody  = @sMailBody  + 'Nous vous rappelons que l''appareil devient la propriété de l''assurance si celui-ci est irréparable. ' + @sSaut
		Set @sMailBody  = @sMailBody  + @sSaut
    End 

	If @iDp279_DT145 > 0 And 
	   @sIdFour in ('O2M','PSM') And 
	   @dcIdGti in ( 11, 24 )
		Begin
			Set @sMailBody  = @sMailBody  + 'Le n° IMEI attendu pour votre appareil sinistré est le : ' + @sNumImeiAnc + '. Si à réception et lors du contrôle de votre appareil par notre centre technique le n° IMEI s''avère différent, votre demande de prise en charge ne pourra pas recevoir une suite positive. Nous vous remercions de bien vouloir le vérifier avant votre envoi.' 
			Set @sMailBody  = @sMailBody  + @sSaut + @sSaut
		End 

	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
        
   End  
 
 
  -- [PM200][PSM]
  If @iVarianteMail in ( 1, 4, 10, 12, 14, 15, 23, 24  ) -- #4 [SURCOUF_ECH_EXPRESS] [PC801_LOT1_V2] [PC938_ORANGE_V3]
   Begin
	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut

	
	-- [PM200][PSM]
	-- [PC801_6_TAMET]
	If @iVarianteMail in ( 10, 14, 24 )
	  Begin

		If @iVarianteMail in ( 10, 14 )		
		 Begin
			-- [PC929-1]
			If @sIdRefFour = 'A_DIAGNOSTIQUER' 
			  Begin
				Set @sMailBody  = @sMailBody  + 'A la suite de votre déclaration de sinistre du ' + @sDteDecl + ', vous pouvez bénéficier d''un diagnostic de votre ' + @sMarque + ' ' + @sModele + ' dans le réseau national « Point Service Mobiles »'
			  End
			Else
			  Begin
				Set @sMailBody  = @sMailBody  + 'A la suite de votre déclaration de sinistre du ' + @sDteDecl + ', vous pouvez bénéficier d''une réparation de votre ' + @sMarque + ' ' + @sModele + ' dans le réseau national « Point Service Mobiles »'
			  End
		 End

		If @iVarianteMail in ( 24 )		
		 Begin
			-- [PC929-1]
			If @sIdRefFour = 'A_DIAGNOSTIQUER' 
			  Begin
				Set @sMailBody  = @sMailBody  + 'A la suite de votre déclaration de sinistre du ' + @sDteDecl + ', vous pouvez bénéficier d''un diagnostic de votre ' + @sMarque + ' ' + @sModele
			  End
			Else
			  Begin
				Set @sMailBody  = @sMailBody  + 'A la suite de votre déclaration de sinistre du ' + @sDteDecl + ', vous pouvez bénéficier d''une réparation de votre ' + @sMarque + ' ' + @sModele
			  End
		 End 
				  
		If @sLstAdresse is not null And @sLstAdresse <> ''
		 Begin
			Set @sMailBody  = @sMailBody  + ' en vous rendant dans l''un de ses points d''accueil avec votre facture d''achat.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut				

			If @iCpt = 1 
			  Begin	
				Set @sMailBody  = @sMailBody  + 'L''adresse du << Point Service Mobiles >> le plus proche de chez vous est :'
			  End 

			If @iCpt > 1 
			  Begin	
				Set @sMailBody  = @sMailBody  + 'L''adresse des ' + Convert ( VarChar ( 5 ), @iCpt) + ' << Point Service Mobiles >> les plus proches de chez vous sont :'
			  End 

			If @iCpt > 0
			  Begin
				Set @sMailBody  = @sMailBody  + @sSaut -- MANTIS3605
				Set @sMailBody  = @sMailBody  + @sSaut -- MANTIS3605
				Set @sMailBody  = @sMailBody  + @sLstAdresse
			  End

			-- [PC929-1]
			If @sIdRefFour = 'A_REPARER' 
			 Begin				
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut								
				Set @sMailBody  = @sMailBody  + 'Nous vous rappelons qu''en vous rendant dans un Point Service Mobiles, vous pourrez bénéficier, dans 80% des cas, d''une réparation dans l''heure (selon horaires d''ouverture) ou, si besoin, du prêt d''un téléphone mobile pendant la durée de la réparation.'				 
			End
			
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut	

			Set @sMailBody  = @sMailBody  + 'Pour retrouver toutes les adresses des Point Service Mobiles, les plans d''accès et les horaires, connectez-vous à www.allopsm.fr .'
			
			-- [PC877]
			If @iVarianteMail not in ( 14 ) 
			 begin
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut				
				Set @sMailBody  = @sMailBody  + 'Si vous ne pouvez pas vous déplacer, merci d''envoyer votre appareil,'
			 End 

		 End 
		Else 
		 Begin
			Set @sMailBody  = @sMailBody  + '.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Merci d''envoyer votre appareil, '	  
		 End 

	
	  End
	Else
	  Begin
	  	-- [PC877][PC801_LOT1_V2]
	  	-- [PC801_6_TAMET]
		If @iVarianteMail in ( 12, 15, 23)
		 Begin
		 
			If @iVarianteMail in ( 12, 15 )
			 Begin
				-- [PC929-1]
				If @sIdRefFour = 'A_DIAGNOSTIQUER' 
				 Begin
					Set @sMailBody  = @sMailBody  + 'A la suite de votre déclaration de sinistre du ' + @sDteDecl + ', vous pouvez bénéficier d''un diagnostic de votre ' + @sMarque + ' ' + @sModele + ' dans le réseau national « Point Service Mobiles »'
				 End
				Else
				 Begin
					Set @sMailBody  = @sMailBody  + 'A la suite de votre déclaration de sinistre du ' + @sDteDecl + ', vous pouvez bénéficier d''une réparation de votre ' + @sMarque + ' ' + @sModele + ' dans le réseau national « Point Service Mobiles »'
				 End
			 End
			 
			-- [PC801_6_TAMET]
			If @iVarianteMail in ( 23 )
			 Begin
				If @sIdRefFour = 'A_DIAGNOSTIQUER' 
				 Begin
					Set @sMailBody  = @sMailBody  + 'A la suite de votre déclaration de sinistre du ' + @sDteDecl + ', vous pouvez bénéficier d''un diagnostic de votre ' + @sMarque + ' ' + @sModele + '.'
				 End
				Else
				 Begin
					Set @sMailBody  = @sMailBody  + 'A la suite de votre déclaration de sinistre du ' + @sDteDecl + ', vous pouvez bénéficier d''une réparation de votre ' + @sMarque + ' ' + @sModele + '.'
				 End
			 End 				
 		 End 
	  	Else
	  	 Begin
			-- [PC929-1]
			If @sIdRefFour = 'A_DIAGNOSTIQUER' 
			 Begin
				Set @sMailBody  = @sMailBody  + 'Une demande de diagnostic concernant votre ' + @sMarque + ' ' + @sModele + ' vient d''être transmise à notre centre technique.' -- #12 [DCMP090678]	
			 End
			Else If @sIdRefFour = 'CONTEST_SUR_REMPL' -- [PM280-2]
			 Begin
				Set @sMailBody  = @sMailBody  + 'Une demande de contestation sur remplacement concernant votre ' + @sMarque + ' ' + @sModele + ' vient d''être transmise à notre centre technique.' -- #12 [DCMP090678]	
			 End
			Else
			 Begin
				Set @sMailBody  = @sMailBody  + 'Une demande de réparation concernant votre ' + @sMarque + ' ' + @sModele + ' vient d''être transmise à notre centre technique.' -- #12 [DCMP090678]	
			 End
			 
		 End
		 
		Set @sMailBody  = @sMailBody  + @sSaut
		Set @sMailBody  = @sMailBody  + @sSaut
		Set @sMailBody  = @sMailBody  + 'Merci d''envoyer votre appareil, '	  


	  End 

	-- #12 [DCMP090678]	
	-- [PC877]
	If @iVarianteMail not in ( 14 ) 
	 Begin
		If @sTypApp = 'TEL'
			Begin
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + '- avec sa batterie'
				Set @sMailBody  = @sMailBody  + @sSaut			
				Set @sMailBody  = @sMailBody  + '- sans carte SIM ni carte Mémoire'
				Set @sMailBody  = @sMailBody  + @sSaut			
			End
		Else
			Begin
				Set @sMailBody  = @sMailBody  + ' '
			End 


		-- [PM200][PSM]PM200_LOT3_V3 [PC801_LOT1_V2]
		-- [PC801_6_TAMET]
		If @iVarianteMail in ( 12, 15, 23 )
		 Begin
			If @iVarianteMail in ( 12, 15 )
			 Begin
				 -- PM200_LOT3_V3
				If @sPremBtqProxPSM <> '' 				
				 Begin
					Set @sMailBody  = @sMailBody  + 'par le biais du colis prépayé que vous avez reçu, à l''adresse du « Point Service Mobiles » proche de chez vous soit ' + @sPremBtqProxPSM + '.'
				 End 
				Else				 
				 Begin		 	 
					If @iVarianteMail = 12
					 Begin
						Set @sMailBody  = @sMailBody  + 'par le biais du colis prépayé que vous avez reçu, à l''adresse suivante : '
					 End

					If @iVarianteMail = 15 -- [PC801_LOT1_V2]
					 Begin
						Set @sMailBody  = @sMailBody  + 'par le biais du bon prépayé que vous avez reçu, ou bien que vous allez recevoir, de notre service technique.'
						Set @sMailBody  = @sMailBody  + @sSaut	
						Set @sMailBody  = @sMailBody  + 'Celui-ci doit être collé sur l’emballage d’origine ou un emballage similaire.'
						Set @sAdressCentralePSM = '' -- [PC947&977]
					 End
				 End				
			 End

			-- [PC801_6_TAMET]
			If @iVarianteMail in ( 23 )
			 Begin			 
				Set @sMailBody  = @sMailBody  + 'par le biais du bon prépayé que vous avez reçu, ou bien que vous allez recevoir, de notre service technique.'
				Set @sMailBody  = @sMailBody  + @sSaut	
				Set @sMailBody  = @sMailBody  + 'Celui-ci doit être collé sur l’emballage d’origine ou un emballage similaire.'
			 End 
		 End
		Else
		 Begin

			-- [DT398]
			If sysadm.FN_CLE_NUMERIQUE ( 'DT398') > 0 
			 Begin
				Set @sMailBody  = @sMailBody  + 'en téléchargeant un bon prépayé en vous connectant à l''adresse suivante https://extranet.trepidai.biz/ puis en l''imprimant et en le collant sur votre colis, ou enfin '
			 End 

		     -- PM200_LOT3_V3		 
			If @sPremBtqProxPSM <> '' 
			 Begin		 	 
				Set @sMailBody  = @sMailBody  + 'par le biais d''un colissimo de la Poste adapté à la taille de celui-ci, à l''adresse du « Point Service Mobiles » proche de chez vous soit, ' + @sPremBtqProxPSM + '.'
			 End 
			Else
			 Begin		 	 
				Set @sMailBody  = @sMailBody  + 'par le biais d''un colissimo de la Poste adapté à la taille de celui-ci, à l''adresse suivante : '
				-- [PM280-1][MANTIS15456]
				If Len ( @sFraisDP76 ) > 0 And @sARepGarantie <> 'OUI'
				 Begin
					Set @sMailBody  = @sMailBody  + @sSaut
					Set @sMailBody  = @sMailBody  + '(Vous serez remboursé d''un montant de ' + @sFraisDP76 + ')'
				 End 
			 End				
		 End 
		-- :#12 [DCMP090678]	 

	     -- PM200_LOT3_V3		 
		Set @sMailBody  = @sMailBody  + @sSaut
		Set @sMailBody  = @sMailBody  + @sSaut

		Select @sMailBody  = @sMailBody  +
			Case 
				When @sIdFour = 'ANV' And @iVarianteMail = 4 Then 'ANOVO ANGERS' + @sSaut + 'LOGISTIQUE SPB' + @sSaut +'Parc d''Activité d''Angers-Beaucouzé' + @sSaut + '49070 ANGERS BEAUCOUZE'
				When @sIdFour = 'ANV' Then 'ANOVO-SPB' + @sSaut + 'BP561' + @sSaut + '19107 BRIVE' -- #6 PHG Modificiation de la BP
				When @sIdFour = 'SBE' Then 'ACEAN-SPB' + @sSaut + 'BP439' + @sSaut + '62206 Boulogne sur Mer' -- #3
--				When @sIdFour = 'COR' Then 'CORDON ELECTRONICS - SPB' + @sSaut + '32, Rue du Bas Village' + @sSaut + '35510 CESSON-SEVIGNE' -- [PC442]
				When @sIdFour = 'COR' Then 'Assurance C/O Cordon Electronics' + @sSaut + 'ZI de la Lande' + @sSaut + '10 à 14 Chemin de Barateau' + @sSaut + '33999 Saint-Loubès' -- SmaPin le 05/04/2017
				When @sIdFour = 'O2M' Then @sAdressO2M
				When @sIdFour = 'PSM' And @sPremBtqProxPSM = '' Then @sAdressCentralePSM  -- PM200_LOT3_V3
				When @sIdFour = 'TMT' Then 'JUCLAN' + @sSaut + 'SPB AUCHAN' + @sSaut + 'Immeuble SOPRANO' + @sSaut + '5 rue de Maidstone' + @sSaut + '60000 Beauvais' -- [PC801_6_TAMET] -- [VDOC17717]
				Else ''
			End 
		
		-- [DT87][MANTIS11453]
		If 	Not (( @sIdFour = 'O2M' And @sAdressO2M = '' ) Or ( @sIdFour = 'PSM' And @sPremBtqProxPSM = '' And @sAdressCentralePSM = '' ))
		 Begin
			 Set @sMailBody  = @sMailBody  + @sSaut
			 Set @sMailBody  = @sMailBody  + @sSaut
		 End 
		 
		-- #12 [DCMP090678]	 
		Set @sMailBody  = @sMailBody  + 'Veuillez indiquer obligatoirement sur votre colis et à l''intérieur de celui-ci :'
		Set @sMailBody  = @sMailBody  + @sSaut	
		Set @sMailBody  = @sMailBody  + 'Le n° de Référence SPB : ' + @sIdSin + '-' + Convert ( Varchar (3), @iIdSeq )
	--	Set @sMailBody  = @sMailBody  + 'Information à fournir obligatoirement : Le n° de commande SPB : ' + @sIdSin + '-' + Convert ( Varchar (3), @iIdSeq )
		-- :#12 [DCMP090678]	 

		-- [DT398]
		If sysadm.FN_CLE_NUMERIQUE ( 'DT398') > 0 
		  Begin
			If @sPremBtqProxPSM = '' 
			  Begin
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Si vous ne souhaitez pas envoyer votre appareil par colis à cette adresse, vous pouvez vous déplacer en boutique PSM de proximité. Retrouvez toutes les informations sur www.allopsm.fr.'

			  End 

		  End 
		-- #12 [DCMP090678]	 
		If @sTypApp = 'TEL'
			Begin	
			  -- [MANTIS3024][RECUP_DONNEE_O2M]  
			  If sysadm.FN_CLE_VAL ( 'RECUP_DONNEES', @sInfoSpbFrnCplt, ';') <> 'OUI'
			    Begin	
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut

	-- Mantis 2744 [PM200][PSM] Vu verbalement avec Hélène, on ne contextualise pas à PSM, c'est pour tout le monde.
				Set @sMailBody  = @sMailBody  + 'Nous vous informons que les données stockées sur votre appareil pourront être effacées par l''intervention du technicien.'
			    End
			End 		
		-- :#12 [DCMP090678]	 		
	
		End

	-- [DT188]
	If @sIdRefFour in ( 'A_REPARER', 'A_DIAGNOTIQUER' ) 
		Begin
		Set @sMailBody  = @sMailBody  + @sSaut
		Set @sMailBody  = @sMailBody  + @sSaut
		Set @sMailBody  = @sMailBody  + 'Afin de protéger vos données personnelles, vous devez impérativement sauvegarder, puis effacer le contenu (photos, contacts, mails…) de votre appareil avant l''envoi à notre centre technique. Nous ne pourrons en aucun cas être tenus responsables de tout dommage qui résulterait de la perte ou du vol de vos données personnelles et/ou de leur utilisation par des tiers à quelque fin que ce soit.'
		End 

	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	
	If @iDp260 > 0
		Begin
			If @sIdFour in ('O2M','PSM', 'TMT')
			Begin
				Set @sMailBody  = @sMailBody  + 'Nous vous rappelons que l''appareil devient la propriété de l''assurance si celui-ci est irréparable. ' + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
			End
		End 

	If @iDp279_DT145 > 0 And 
	   @sIdFour in ('O2M','PSM') And 
	   @dcIdGti in ( 11, 24 )
		Begin
			Set @sMailBody  = @sMailBody  + 'Le n° IMEI attendu pour votre appareil sinistré est le : ' + @sNumImeiAnc + '. Si à réception et lors du contrôle de votre appareil par notre centre technique le n° IMEI s''avère différent, votre demande de prise en charge ne pourra pas recevoir une suite positive. Nous vous remercions de bien vouloir le vérifier avant votre envoi.' 
			Set @sMailBody  = @sMailBody  + @sSaut + @sSaut
		End 

	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'

   End

  If @iVarianteMail = 2 -- #4 [SURCOUF_ECH_EXPRESS]
   Begin
	-- Armement du corps du mail
	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous vous invitons à déposer votre appareil au Service Après-vente SURCOUF - magasin : ' + @sMagasin + ' - afin de procéder au diagnostic « Panne » de celui-ci.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + '-----------------------------------------------------------------------------------'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Numéro SPB de dossier de sinistre : ' + @sIdSin
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nom de l''assuré : ' + @sNom
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'REFERENCES de l''APPAREIL :'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Numéro de panier : ' + @sNumPanier
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'SKU : ' + @sSKU
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Marque : ' + @sMarque
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Modèle : ' + @sModele
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Numéro de série : ' + @sNumSerie
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Valeur d''achat TTC : ' + @sValAchat
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Date d''achat : ' + @sDteAchat
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + '-----------------------------------------------------------------------------------'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'SPB'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Finaref Assurances / Echange Express Surcouf'
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + '76095 LE HAVRE Cedex'
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Tel :' + @sNumProd + ' (*)'
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Fax :' + @sNumFaxProd
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'E-mail : surcoufechangeexpress@spb.fr'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'L''accueil téléphonique est ouvert ' + @sHoraireOuv + '. (**)'
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + '* Tarif au 01/11/2007 : ' + @sCoutTel + ' depuis un poste fixe hors surcoût éventuel de l''opérateur.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + '** Hors jours légalement chômés ou sauf interdictions légales ou réglementaires.'

   End


  If @iVarianteMail = 3 -- #5 [DCMP080202]
   Begin

	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	
	-- :#12 [DCMP090678]	 
--	Set @sMailBody  = @sMailBody  + 'Une demande de diagnostic concernant votre ' + @sMarque + ' ' + @sModele + ' vient d''être transmise à notre centre de diagnostic.'
	Set @sMailBody  = @sMailBody  + 'Une demande de diagnostic concernant votre ' + @sMarque + ' ' + @sModele + ' vient d''être transmise à notre centre technique.'

	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut	

	Set @sMailBody  = @sMailBody  + 'Merci d''envoyer votre appareil,'

	-- #12 [DCMP090678]	
	If @sTypApp = 'TEL'
		If @sVarianteDiagDP129 = 'ORANGE/SFR'	
			Begin
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + '- avec sa batterie'
				Set @sMailBody  = @sMailBody  + @sSaut			
				Set @sMailBody  = @sMailBody  + '- sans carte SIM ni carte mémoire'
				Set @sMailBody  = @sMailBody  + @sSaut			
			End

		If @sVarianteDiagDP129 = 'DISTRIB/BAC'	
			Begin
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + '- avec sa batterie et les pièces demandées'
				Set @sMailBody  = @sMailBody  + @sSaut			
				Set @sMailBody  = @sMailBody  + '- sans carte SIM ni carte mémoire'
				Set @sMailBody  = @sMailBody  + @sSaut			
			End
	Else
		Begin
			Set @sMailBody  = @sMailBody  + ' '
		End

	Set @sMailBody  = @sMailBody  + 'par le biais d''un colissimo de la Poste adapté à la taille de celui-ci, à l''adresse suivante : '
	-- :#12 [DCMP090678]	 

	Set @sMailBody  = @sMailBody  + @sSaut			
	Set @sMailBody  = @sMailBody  + @sSaut				

	Select @sMailBody  = @sMailBody  +
		Case @sIdFour
-- [ADRESSE_O2M]
			When 'O2M' Then @sAdressO2M
 -- [ADRESSE_O2M]
			Else null
		End 

	Set @sMailBody  = @sMailBody  + @sSaut

	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	
	-- #12 [DCMP090678]	 
	Set @sMailBody  = @sMailBody  + 'Veuillez indiquer obligatoirement sur votre colis et à l''intérieur de celui-ci :'
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'Le n° de Référence SPB : ' + @sIdSin + '-' + Convert ( Varchar (3), @iIdSeq )
--	Set @sMailBody  = @sMailBody  + 'Information à fournir obligatoirement : Le n° de commande SPB : ' + @sIdSin + '-' + Convert ( Varchar (3), @iIdSeq )
	-- :#12 [DCMP090678]	 

	-- #12 [DCMP090678]	 
	If @sTypApp = 'TEL'
		Begin	
		  -- [MANTIS3024][RECUP_DONNEE_O2M]  
		  If sysadm.FN_CLE_VAL ( 'RECUP_DONNEES', @sInfoSpbFrnCplt, ';') <> 'OUI'
		    Begin	
		
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			
-- Mantis 2744 [PM200][PSM] Vu verbalement avec Hélène, on ne contextualise pas à PSM, c'est pour tout le monde.
			Set @sMailBody  = @sMailBody  + 'Nous vous informons que les données stockées sur votre appareil pourront être effacées par l''intervention du technicien.'
		    End			
		End 		
	-- :#12 [DCMP090678]	 		

	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	
	If @iDp260 > 0
		Begin
			If @sIdFour in ('O2M','PSM')
			Begin
				Set @sMailBody  = @sMailBody  + 'Nous vous rappelons que l''appareil devient la propriété de l''assurance si celui-ci est irréparable. ' + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
			End
		End 

	If @iDp279_DT145 > 0 And 
	   @sIdFour in ('O2M','PSM') And 
	   @dcIdGti in ( 11, 24 )
		Begin
			Set @sMailBody  = @sMailBody  + 'Le n° IMEI attendu pour votre appareil sinistré est le : ' + @sNumImeiAnc + '. Si à réception et lors du contrôle de votre appareil par notre centre technique le n° IMEI s''avère différent, votre demande de prise en charge ne pourra pas recevoir une suite positive. Nous vous remercions de bien vouloir le vérifier avant votre envoi.' 
			Set @sMailBody  = @sMailBody  + @sSaut + @sSaut
		End 

	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'

   End

   
  -- #8 [FNAC_PROD_ECH_TECH].[20090224144248310]
  If @iVarianteMail in ( 5, 11 )
   Begin
   	Exec sysadm.PS_S08_MAILPUSH_CORPS_MAIL_FNAC_900 @adcIdSin, @iIdSeq, @sCiv, @sMarque, @sModele, @iInfoSpbFrn, @sMailBody OUTPUT 
   End 
   
	
--------------------------------------------------------------------------------------------------------------------
-- Pied du mail
	-- [DT262]
  If @PiedDePage_SiVotreContratDispo = 'A_AFFICHER' -- [DT386_EXTR_AXA]
    Begin
	  Set @sMailBody  = @sMailBody  + @sSaut
	  Set @sMailBody  = @sMailBody  + @sSaut
	  Set @sMailBody  = @sMailBody  + 'Si votre contrat d''assurance dispose d''un site web de gestion de sinistre, vous pouvez à tout moment consulter et télécharger la ou les pièce(s) de votre dossier sur ce site communiqué par notre gestionnaire lors de votre déclaration.'
    End 

  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'

	Select @iOrangeV3 = COUNT ( * ) 
	From   sysadm.det_pro d,
		   sysadm.sinistre s
	where  s.id_sin = @adcIdSin
	And    d.id_prod = s.id_prod
	And    d.id_code_dp = 239
	If @iOrangeV3 is null Set @iOrangeV3 = 0
	
	-- [PM255]
	-- [DT153-1]
	-- [DT191] 2116
    If @iOrangeV3 > 0 And @iInfoSpbFrn in ( 912, 976, 977, 978, 979, 981, 982, 2137, 2138, 2139, 2140, 2130, 2141, 2142, 2116 ) 
     Begin
		
		-- [PM250-2][MANTIS14550]
		-- [ITSM296798]
		-- [ITSM300566]
		-- [VDOC20167]
		/* coupé par la vDoc20167
  			If	Not Exists ( 
					Select 1
					From   sysadm.commande c
					Where  c.id_sin = @adcIdSin
					And c.id_typ_art = 'PST'
					And Len ( sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', RTRIM( c.info_spb_frn_cplt ), ';' )) > 0 
					And c.cod_etat <> 'ANN'
				)
			And 
				Not Exists ( 		-- [ITSM300566] 17/06/2015 JFF
					Select 1
					From   sysadm.commande c
					Where  c.id_sin = @adcIdSin
					And    c.id_gti = 10
				)
			And @iInfoSpbFrn Not in	(  973, 974, 975 ) -- ITSM332188 
			Begin 
				Exec sysadm.PS_I_MAIL_COLI_SIN_FICHE_16 @asIdAppli, @asBase, @iOptionDP, @adcIdSin
			End 
		 */

		-- shunté par Hélène le 11/06/2013, cause : les courriers suffiront.	
		Return 0
	 End
   
  -- On convertit pour l'appel de la PS
  Set @iIdSin  = Convert ( integer, @adcIdSin )
  Set @iIdProd = Convert ( integer, @dcIdProd )
  Set @iIdEts  = Convert ( integer, @dcIdEts )

  -- [RS5045_REF_MATP]
  If Exists ( Select Top 1 1 From sysadm.w_sin where id_sin = @adcIdSin ) 
   Begin
	 Select @dcIdInter = id_i From sysadm.w_inter where id_sin = @adcIdSin and cod_inter = 'A'
   End 
  Else
   Begin
	 Select @dcIdInter = id_i From sysadm.inter where id_sin = @adcIdSin and cod_inter = 'A'
   End 

   If @dcIdInter is null Set @dcIdInter = 0 

  -- /[RS5045_REF_MATP]
	-- [DT139]
	If Len ( @sMailCcOrangeVIP ) > 0 
	 Begin
	   Set @sMailCc = @sMailCcOrangeVIP 
	 End  

  If @@servername = master.dbo.SPB_FN_ServerName ('PRO')

   Begin  -- TRACE_MAIL_PRO : Début écriture

  	-- [RS5045_REF_MATP] Nouvelle et future Méthode unique à utiliser !!
	If sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') > 0 
		Begin
			-- Appel Obligatoire pour déclarer le XML
			Exec @iIdXml = TRACE_MAIL_PRO.sysadm.PS_RS5045_I_CREATION_CHAINE_DATA_XML_KSL_A_VIDE
			Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER @iIdSin, @dcIdInter, @iIdXml
			Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_OPTIMISER_CHAINE_DATA_XML_KSL @iIdXml, 'OUI', 'OUI', 'OUI'
			Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_S_RECUPERER_CODE_MAQUETTE_KSL_A_PARTIR_TYP_MAIL 'M4', @sCodeMaquette OutPut

			-- Ajout personnalisé du client appelant le système
			Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'code_maquette', @sCodeMaquette

			Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_TRANSFORMATION_DES_CRLF_FORMAT_XML_UTF8 @sMailBody OutPut, @sSaut
			Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'mail_subject', @sMailObjet
			Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'mail_body', @sMailBody

			-- Appel pour construire et récupérer le XML dans @xmlResult
			Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_I_CONSTRUCTION_CHAINE_XML_KSL_DEFINITIVE @iIdXml, @sCodeMaquette, @sXMLVar OUTPUT

			Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_RS5045_I_MAIL_PUSH_KSL
				@asIdAppli,
				@iIdSin,
				@iIdProd,
				@sLibProd,
				@iIdEts,
				@sMailFrom,
				@sMailSend,
				@sMailCc,
				null,
				@sMailObjet,
				@sMailBody,
				@sBoiteMail,
				'M4',
				2,
				-1,
				@sXMLVar,
				null, -- id_chem, peut être forcé mais si null, sera pris par défaut sysadm.code_maquette_ksl_rs5045
				null, -- dteh_exec
				@sErrOutPut OutPut

				Set @asCasRetour = Left ( @sErrOutPut, 50 )

		End 
	Else
		Begin
		  Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
			@asIdAppli,
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
		  @sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			@sAltQuarant,
			@sBoiteMail, --#2
			'M4', -- #2
			2 -- #2
		End 
   End    -- TRACE_MAIL_PRO : Fin écriture

  Else

   Begin  -- TRACE_MAIL_TRT : Début écriture

  	-- [RS5045_REF_MATP] Nouvelle et future Méthode unique à utiliser !!
	If sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') > 0 
		Begin
			-- Appel Obligatoire pour déclarer le XML
			Exec @iIdXml = TRACE_MAIL_TRT.sysadm.PS_RS5045_I_CREATION_CHAINE_DATA_XML_KSL_A_VIDE
			Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER @iIdSin, @dcIdInter, @iIdXml
			Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_OPTIMISER_CHAINE_DATA_XML_KSL @iIdXml, 'OUI', 'OUI', 'OUI'
			Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_S_RECUPERER_CODE_MAQUETTE_KSL_A_PARTIR_TYP_MAIL 'M4', @sCodeMaquette OutPut

			-- Ajout personnalisé du client appelant le système
			Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'code_maquette', @sCodeMaquette

			Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_TRANSFORMATION_DES_CRLF_FORMAT_XML_UTF8 @sMailBody OutPut, @sSaut
			Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'mail_subject', @sMailObjet
			Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'mail_body', @sMailBody

			-- Appel pour construire et récupérer le XML dans @xmlResult
			Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_I_CONSTRUCTION_CHAINE_XML_KSL_DEFINITIVE @iIdXml, @sCodeMaquette, @sXMLVar OUTPUT

			Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_RS5045_I_MAIL_PUSH_KSL
				@asIdAppli,
				@iIdSin,
				@iIdProd,
				@sLibProd,
				@iIdEts,
				@sMailFrom,
				@sMailSend,
				@sMailCc,
				null,
				@sMailObjet,
				@sMailBody,
				@sBoiteMail,
				'M4',
				2,
				-1,
				@sXMLVar,
				null, -- id_chem, peut être forcé mais si null, sera pris par défaut sysadm.code_maquette_ksl_rs5045
				null, -- dteh_exec
				@sErrOutPut OutPut

				Set @asCasRetour = Left ( @sErrOutPut, 50 )

		End 
	Else
		Begin
		  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			@asIdAppli,
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
        		@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			@sAltQuarant,
			@sBoiteMail, --#2
			'M4', -- #2
			2 -- #2
		End

   End    -- TRACE_MAIL_TRT : Fin écriture
	

  -- Problème suite éxécution
  If @iRet <> 0 Return -20

  -- Fin de traitement
  Set @asCasRetour = 'MAIL_ENVOYE'
  
  -- [RECUP_DONNEE_O2M]  
  -- En parallèle, je dépose un enregistrement (mail) pour KSL, pour un cas particulier
  If @iVarianteMail in (1, 3 )
  Begin
   If sysadm.FN_CLE_VAL ( 'METHODE', @sDP205, ';') = '2' And 
      sysadm.FN_CLE_VAL ( 'ENVOI_MAIL_PDF_DECL', @sDP205, ';') = 'OUI' And
      sysadm.FN_CLE_VAL ( 'RECUP_DONNEES', @sInfoSpbFrnCplt, ';') = 'OUI'
    Begin
	-- Récupération des données standard nécessaires à l'envoi du mail
	Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL_XML
		@iIdSin,
		@iOptionDP,
		@dcIdProd   OUTPUT,
		@sLibProd   OUTPUT,
		@dcIdEts    OUTPUT,
		@sNumProd   OUTPUT,
		@sCiv	    OUTPUT,
		@sNom	    OUTPUT,
		@sMailFrom  OUTPUT,
		@sMailSend  OUTPUT,
		@sMailCc    OUTPUT,
		@sAltQuarant OUTPUT,
		@sBoiteMail  OUTPUT,
		@sXMLVar     OUTPUT

	-- Armement du corps du mail 
	Set @sMailObjet = 'SPB Sinistre numéro ' + Convert ( Varchar ( 10 ), @adcIdSin ) + ' ' + @sLibProd

	-- Armement du corps du mail
	Set @sXMLVar = @sXMLVar + '<courrier '
	Set @sXMLVar = @sXMLVar + 'code_courrier_SIMPA2="AUTORISATION_CGU_1" '
	Set @sXMLVar = @sXMLVar + 'code_produit_SIMPA2="' + Convert ( VarChar ( 15 ), @dcIdProd  ) + '" '
	Set @sXMLVar = @sXMLVar + 'info_pour_EW="joindre un PDF pour envoyer ce mail" '
	Set @sXMLVar = @sXMLVar + 'date_declaration="' + @sDteDecl + '" '
	Set @sXMLVar = @sXMLVar + 'adr_O2M_nom1="' + @sNomLigne1 + '" '
	Set @sXMLVar = @sXMLVar + 'adr_O2M_nom2="' + @sNomLigne2 + '" '	
	Set @sXMLVar = @sXMLVar + 'adr_O2M_adr1="' + @sAdrLigne1 + '" '
	Set @sXMLVar = @sXMLVar + 'adr_O2M_adr2="' + @sAdrLigne2 + '" '	
	Set @sXMLVar = @sXMLVar + 'adr_O2M_cp="' + @sCP + '" '	
	Set @sXMLVar = @sXMLVar + 'adr_O2M_ville="' + @sVille + '" '	
	Set @sXMLVar = @sXMLVar + '/>'

	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	Set @sAltQuarant = 'N'

	-- [DT139]
	If Len ( @sMailCcOrangeVIP ) > 0 
	 Begin
	   Set @sMailCc = @sMailCcOrangeVIP 
	 End  

	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin
	       Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V01 
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sMailFrom,
			@sMailSend,
			@sMailCc,
			@sMailObjet,
			'Corps du mail construit par KSL',
			@sAltQuarant,
			@sBoiteMail,
			'M17',
			2,
			'KSL',
			-1,
			@sXMLVar

	   End    -- TRACE_MAIL_PRO : Fin écriture

	Else
	 Begin
		 Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V01 
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sMailFrom,
			@sMailSend,
			@sMailCc,
			@sMailObjet,
			'Corps du mail construit par KSL',
			@sAltQuarant,
			@sBoiteMail,
			'M17',
			2,
			'KSL',
			-1,
			@sXMLVar
	 End	

    End 
  End 
  -- :[RECUP_DONNEE_O2M]  
  
  
  Return 0
Go

grant execute on sysadm.PS_S04_MAILPUSH_INFO_REPAR_PASSE to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I01_MAILPUSH
-- Auteur               :       Fabry JF 
-- Date                 :       13/11/2006
-- Libelle              :
-- Commentaires         :       Envoi vers du mail vers TRACE_MAIL.
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-- #1  JFF  03/07/2006  suite mail de C.Rigal le 30/06/2006
--	FPI 19/07/2011 [PC469] - mail de refus
--  JFF   23/05/2012 [PM103][1]
--	FPI	  18/04/2013 [PM191-4] 
--  JFF   12/02/2016 [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_MAILPUSH' AND type = 'P' )
        DROP procedure sysadm.PS_I01_MAILPUSH
GO

CREATE procedure sysadm.PS_I01_MAILPUSH  
	@adcIdSin      	Decimal (10),  -- [PI062]
	@asBase		varchar (20),
	@asMailSend	VarChar (128), 
	@asMailObjet	VarChar ( 255 ),
  	@asMailBody	VarChar ( 7000 ),
	@asBoiteMail    VarChar ( 35 ),
	@asTypMail	VarChar ( 10),
	@aiIdAppli	Integer
AS
Declare 
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @sLibProd	VarChar ( 35 ),
  @iRet		Integer,
  @sMailFrom VarChar ( 128 ) -- [PM191-4] 


  -- [PM103][1]	
  If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
   Begin
	Return 0
   End
  -- :[PM103][1]


  Set    @iIdSin  = Convert ( integer, @adcIdSin )
  Set    @asBoiteMail = Upper ( @asBoiteMail )
  Set 	 @asTypMail   = Upper ( @asTypMail )
  Set 	 @sMailFrom='' -- [PM191-4] 
  
  Select @iIdProd  = Convert ( integer, id_prod ),
	 @sLibProd = sysadm.FN_LIB_PROD ( id_prod ),
	 @iIdEts   = Convert ( integer, id_ets )
  From   sysadm.w_sin ws
  where  ws.id_sin = @adcIdSin

  -- [PC469] - mail de refus
  If @@ROWCOUNT = 0 
  Begin
   Select @iIdProd  = Convert ( integer, id_prod ),
	 @sLibProd = sysadm.FN_LIB_PROD ( id_prod ),
	 @iIdEts   = Convert ( integer, id_ets )
	From   sysadm.sinistre s
	where  s.id_sin = @adcIdSin
  End

  -- [PM191-4] 
  If CharIndex ( '@', @asBoiteMail ) > 0 set @sMailFrom=@asBoiteMail
    
  -- Sommes-nous sur un serveur de production ?
  If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
    If Upper ( Right ( sysadm.FN_TRIM ( @asBase) , 4 ) ) <> '_PRO' Return -20


  If @@servername = master.dbo.SPB_FN_ServerName ('PRO')

   Begin  -- TRACE_MAIL_PRO : Début écriture

	  Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
		'SIMPA2',
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	    @sMailFrom, 
		@asMailSend, 
		'',
		@asMailObjet,
		@asMailBody,
		'N',
	        @asBoiteMail,
	        @asTypMail,
	        @aiIdAppli


   End    -- TRACE_MAIL_PRO : Fin écriture

  Else

   Begin  -- TRACE_MAIL_TRT : Début écriture

	  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
		'SIMPA2',
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	    @sMailFrom, 
		@asMailSend, 
		'',
		@asMailObjet,
		@asMailBody,
		'N',
	        @asBoiteMail,
	        @asTypMail,
	        @aiIdAppli

   End    -- TRACE_MAIL_TRT : Fin écriture

  -- Problème suite éxécution
  If @iRet <> 0 Return -20

  Return 0
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S05_MAILPUSH_URL_MDP_SITE_CMDE
-- Auteur               :       Fabry JF
-- Date                 :       21/06/2007
-- Libelle              :	[SITE_CMDE]
-- Commentaires         :       Envoi de Mail sur création commande virtuel WEB
--
-- References           :
--
-- Arguments            :       @asIdAppli	varchar (20)		(val) Nom de l'application mère éxécutant la PS
--				@asBase		varchar (20)		(val) Nom de la base de données SHERPA ou SIMPA2
--				@adcIdSin       Decimal (  7,0 )        (Val)
--				@aiIdSeq	Integer		        (Val)
--				@asCasRetour    VarChar (50)		(ref) Cas : MAIL_ENVOYE
--										    OPTION_DP_NON_PARAM
--										    HORS_BASE_DE_PRODUCTION
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-------------------------------------------------------------------
-- #1	JFF	21/01/2008  [FNAC_PROD_ECH_TECH].[SMS]
-- #2	PHG	20/10/2009  [20091020].[PHG] On modifie pour les mails de type M7 le sujet.
--      JFF     05/01/2011  [VDOC2614]
--      JFF   23/05/2012 [PM103][1]
-- JFF      12/02/2016   [PI062]
-- JFF      23/05/2018   [PM373-2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S05_MAILPUSH_URL_MDP_SITE_CMDE' AND type = 'P' )
        DROP procedure sysadm.PS_S05_MAILPUSH_URL_MDP_SITE_CMDE
GO


CREATE procedure sysadm.PS_S05_MAILPUSH_URL_MDP_SITE_CMDE
	@asIdAppli	varchar (20),
	@asBase		varchar (20),
	@adcIdSin      	Decimal (10), -- [PI062]
	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @dcIdGti 	Decimal (7),
  @sNumProd     VarChar (50),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @sSaut	VarChar (10), 
  @sMarque	VarChar (35),
  @sModele	VarChar (35),  
  @sIdFour	VarChar (10),
  @sCodeEtat	VarChar (10),
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @iIdSeq 	Integer,
  @iOptionDP    Integer,
  @dtDteEnvCliActuel DateTime,
  @dtFinValideMdp DateTime,
  @dtMajle DateTime,
  @sBoiteMail   VarChar (35),
  @sURL		VarChar (300),
  @sDEL_MDP	VarChar (5),
  @sChoixServVoc VarChar ( 10 ),
  @sHoraireOuv VarChar (255),
  @sMdpNet VarChar ( 10 ),
  @sIdTypArt VarChar ( 3 ),
  @sFinValideMdp VarChar ( 30 ),
  @sAltSuiviSMS VarChar ( 1 ),  -- #1 [FNAC_PROD_ECH_TECH].[SMS]  
  @sNumGsmSMS   VarChar ( 20 ),  -- #1 [FNAC_PROD_ECH_TECH].[SMS]  
  @iOption164   Integer -- [VDOC2614]
    

  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  Set @asIdAppli = Upper ( @asIdAppli )

  -- Option de déclenchement du mail -DP
  Set @iOptionDP = 82

  -- [PM103][1]	
	If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
 	 Begin
	 	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
 		Return 0
	 End

  -- :[PM103][1]

  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@asBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
        @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT, 
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #2
	@sAltSuiviSMS OUTPUT, -- #1 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #1 [FNAC_PROD_ECH_TECH].[SMS]
	
	

  -- Cas de retour n'étant pas des erreurs
  If @iRet in ( -7, -9, -10 )
   Begin
	Select @asCasRetour =
	Case @iRet
		When -7 Then 'ADRESSE_MAIL_ABSENTE'
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

  -- Problème suite éxécution
  If @iRet <> 0 Return @iRet

  -- Sommes-nous dans le cas d'une commande WEB ?
  Select @sIdFour = IsNull (c.id_four, '' ),
	 @iIdSeq  = c.id_seq,
	 @dcIdGti = c.id_gti,
	 @sIdTypArt = c.id_typ_art,
	 @sMarque = IsNull ( sysadm.FN_TRIM ( ws.marq_port ), '') ,
	 @sModele = IsNull ( sysadm.FN_TRIM ( ws.modl_port ), '')
  From   sysadm.w_commande c, 
  	 sysadm.w_sin ws
  Where  c.id_sin = @adcIdSin
  And    c.id_typ_art = 'TEL'  
  And 	 c.cod_etat = 'CNV'
  And    c.id_four  = 'WBA'
  And    ws.id_sin = c.id_sin
  And 	 c.id_seq = ( Select max (c1.id_seq )
		      From sysadm.w_commande c1
		      Where c1.id_sin = c.id_sin
		      And   c1.id_typ_art = 'TEL'  
		      And   c1.cod_etat = 'CNV'
		     )

  If @sIdFour is null Or @sIdFour = '' 
   Begin
	Set @asCasRetour = 'AUCUNE_CMDE_SUR_CRITERE'
	Return 0
   End 

  -- Report de l'adr_mail sur la prestation
  /*
  If @sMailSend is not null And @sMailSend <> ''
   Begin
    Update sysadm.commande 
    Set    adr_mail = @sMailSend 
    Where  id_sin = @adcIdSin
    And    id_seq = @iIdSeq

    Update sysadm.w_commande 
    Set    adr_mail = @sMailSend 
    Where  id_sin = @adcIdSin
    And    id_seq = @iIdSeq
   End
*/
/* -- Pas utilse dans ce cas de cmde WEB
  -- Recherche supplèmentaire pour détection de a quarantaine par fournisseur.  
  If @sAltQuarant = 'N' 
   Begin
	  -- Le code de l'option de quarantaine est lié à l'option de déclenchement du mail.
	  Select @sAltQuarant = 
		 Case 
		   When d2.id_prod > 0 Then 'O'
		   Else 'N'
		 End 
	  From   sysadm.det_pro d,
		 sysadm.det_pro d2
	  where  d.id_prod = @dcIdProd
	  and    d.id_typ_code_dp = '-DP' 
	  and    d.id_code_dp = @iOptionDP 
	  and    d2.id_prod = d.id_prod
	  and    d2.id_typ_code_dp = '-DP'  
	  and    d2.id_code_dp = d.val_num
	  And    d2.id_code_car = @sIdFour 
   End 
*/

-- [PM373-2]
If Left ( @sNumProd, 5 ) not in ( '0 800', '0 825' )
	Begin
		Set @sNumProd = @sNumProd + ' (numéro non surtaxé)'
	End 

  Select @sURL = sysadm.FN_TRIM ( sysadm.FN_CLE_VAL ( 'URL', IsNull ( dp.val_car, '' ), ';' ) ),
  	 @sDEL_MDP = Upper ( sysadm.FN_TRIM ( sysadm.FN_CLE_VAL ( 'DEL_MDP', IsNull ( dp.val_car, '' ), ';' ) ))
  From   sysadm.det_pro dp
  Where  dp.id_prod = @dcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = 80
  and    dp.id_code_num = @dcIdGti 
  and    dp.id_code_car = @sIdTypArt

  Select @sChoixServVoc = sysadm.FN_TRIM ( IsNull ( dp.val_car, '' ) )
  From   sysadm.det_pro dp
  Where  dp.id_prod = @dcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = 58

  Select @sHoraireOuv = sysadm.FN_TRIM ( IsNull ( dp.val_car, '' ) )
  From   sysadm.det_pro dp
  Where  dp.id_prod = @dcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = 84

  -- [VDOC2614]
  Select @iOption164 = count (*)
  From   sysadm.det_pro dp
  Where  dp.id_prod = @dcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = 164
  If @iOption164 is null Set @iOption164 = 0
  -- [VDOC2614]

  Select @sMdpNet = sysadm.FN_TRIM ( dd.val_car ),
  	 @dtMajle = dd.maj_le
  From   sysadm.w_div_sin dd
  Where  dd.id_sin = @adcIdSin
  and    dd.nom_zone = 'mdp_net'

  IF     IsNumeric ( Left ( @sDEL_MDP, Len ( @sDEL_MDP ) -1 )) = 0 OR Right ( @sDEL_MDP, 1 ) Not in ( 'J', 'M', 'A' )
  	Begin
	  Set  @sFinValideMdp = '[PROBLEME PARAM SUR DEL_MDP -DP/80]'
	  Set  @sMailSend = 'jff@spb.fr'
	  Set  @sMailObjet = @sMailObjet  + ' [PROBLEME PARAM SUR DEL_MDP -DP/80]'
  	End 
  Else
  	Begin
	  Select  @dtFinValideMdp  = 
		  Case Right ( @sDEL_MDP, 1 )
			When 'J' Then DateAdd ( day, convert ( integer, Left ( @sDEL_MDP, Len ( @sDEL_MDP ) - 1 ) ), @dtMajle )
			When 'M' Then DateAdd ( Month, convert ( integer, Left ( @sDEL_MDP, Len ( @sDEL_MDP ) - 1 ) ), @dtMajle )
			When 'A' Then DateAdd ( Year, convert ( integer, Left ( @sDEL_MDP, Len ( @sDEL_MDP ) - 1 ) ), @dtMajle )
		  End

	  Select  @sFinValideMdp = Convert ( VarChar ( 2 ), Datepart ( day, @dtFinValideMdp )) + ' ' + 
				   dateName ( month, @dtFinValideMdp  ) + ' ' +
				   convert ( VarChar (4) , Datepart ( year, @dtFinValideMdp  ) )
 	End 

  If @sURL is null or @sURL = '' 
   Begin
        Set  @sMailSend = 'EPG_Sinistre@spb.fr'
	Set  @sMailObjet = @sMailObjet  + ' [PROBLEME PARAM SUR URL -DP/80]'
	Set  @sURL = '[PROBLEME PARAM SUR URL -DP/80]'
   End 

  If @sChoixServVoc is null or @sChoixServVoc = ''
   Begin
        Set  @sMailSend = 'EPG_Sinistre@spb.fr'
	Set  @sMailObjet = @sMailObjet  + ' [PROBLEME PARAM SUR SERV_VOCAL -DP/80]'
	Set  @sChoixServVoc = '[PROBLEME PARAM SUR SERV_VOCAL -DP/80]'
   End 

  If @sMdpNet is null or @sMdpNet = ''
   Begin
        Set  @sMailSend = 'jff@spb.fr'
	Set  @sMailObjet = @sMailObjet  + ' [PROBLEME MDP_NET ABSENT]'
	Set  @sMdpNet = '[PROBLEME MDP_NET ABSENT]'
   End 


  -- Gestion de la civilité "Madame, Monsieur"
  If @sNom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sNom + ','
   End 

  -- Armement de l'objet du mail
-- [PM373-2]
  Set @sMailObjet = @sLibProd + '-CONFIRMATION DE PRISE EN CHARGE'

  -- Armement du corps du mail
  Set @sMailBody  = @sMailBody  + @sCiv
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer de la prise en charge de votre dossier concernant votre ' + @sMarque + ' ' + @sModele + '.'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Cependant ce modèle n''est plus disponible.'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut

-- [PM373-2]
  Set @sMailBody  = @sMailBody  + 'Nous vous invitons à vous connecter sur notre site ' + @sURL + @sSaut

-- [PM373-2]
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Vous pourrez y choisir un appareil équivalent * !' + @sSaut

-- [PM373-2]
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Vous aurez besoin de :' + @sSaut

-- [PM373-2]
  Set @sMailBody  = @sMailBody  + '- Votre numéro de sinistre : ' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) -- [PI062]
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '- Du code d''accès qui vous sera adressé dans un second e-mail.'

  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut

-- [PM373-2]
  Set @sMailBody  = @sMailBody  + 'En cas de difficulté, vous pouvez nous contacter au ' + @sNumProd
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sHoraireOuv + '.'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  
  -- [VDOC2614]
  If @iOption164 <= 0 
   Begin
	Set @sMailBody  = @sMailBody  + 'Nous vous remercions de taper le choix ' + @sChoixServVoc + ' sur notre serveur vocal, afin d''accéder directement à notre équipe spécialisée.'
	Set @sMailBody  = @sMailBody  + @sSaut
  	Set @sMailBody  = @sMailBody  + @sSaut
   End
  -- [VDOC2614]

-- [PM373-2]
  Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire.' + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Cordialement,' + @sSaut
  Set @sMailBody  = @sMailBody  + 'Votre gestionnaire SPB' + @sSaut

  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'IMPORTANT : Pour toute livraison à l''étranger ou dans les DOM-TOM, merci de nous contacter' + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut

-- [PM373-2]
  Set @sMailBody  = @sMailBody + '* possédant au minimum les mêmes caractéristiques techniques à l''exception du poids, de la taille, du coloris ou du design.' + @sSaut

  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'


  -- On convertit pour l'appel de la PS
  Set @iIdSin  = Convert ( integer, @adcIdSin )
  Set @iIdProd = Convert ( integer, @dcIdProd )
  Set @iIdEts  = Convert ( integer, @dcIdEts )

  If @@servername = master.dbo.SPB_FN_ServerName ('PRO')

   Begin  -- TRACE_MAIL_PRO : Début écriture

	  Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
		@asIdAppli,
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	        @sMailFrom, 
		@sMailSend, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail, --#2
		'M6', -- #2
		2 -- #2

   End    -- TRACE_MAIL_PRO : Fin écriture

  Else

   Begin -- TRACE_MAIL_TRT : Début écriture

	  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
		@asIdAppli,
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	        @sMailFrom, 
		@sMailSend, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail, --#2
		'M6', -- #2
		2 -- #2

   End    -- TRACE_MAIL_TRT : Fin écriture
	

  -- Problème suite éxécution
  If @iRet <> 0 Return -20

  -- #2	PHG	20/10/2009  [20091020].[PHG] On modifie pour les mails de type M7 le sujet.
  -- [PM373-2]
  Set @sMailObjet = @sLibProd + '-VOTRE CODE D''ACCES'

  --

  Set @sMailBody = ''

  -- Armement du corps du mail
  Set @sMailBody  = @sMailBody  + @sCiv
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  -- [PM373-2]
	Set @sMailBody  = @sMailBody  + 'Suite à l''acceptation de prise en charge de votre dossier concernant votre ' + @sMarque + ' ' + @sModele + ' veuillez trouver ci-dessous votre code d''accès afin d''accéder à notre site ' + @sURL + ' afin de choisir votre nouvel appareil.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Vous aurez également besoin de votre numéro de sinistre indiqué dans un précédent e-mail.' + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Votre code d''accès :' + @sSaut
	Set @sMailBody  = @sMailBody  + @sMdpNet
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'En cas de difficulté, vous pouvez nous contacter au ' + @sNumProd
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sHoraireOuv + '.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous vous informons que ce code d''accès expirera le ' + @sFinValideMdp +'.'+ @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Passé ce délai, il faudra nous contacter par téléphone afin d’activer un nouveau code ou bien choisir un appareil avec l''un de nos conseillers.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Cordialement,' + @sSaut
	Set @sMailBody  = @sMailBody  + 'Votre gestionnaire SPB' + @sSaut

  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'

If @@servername = master.dbo.SPB_FN_ServerName ('PRO')

   Begin  -- TRACE_MAIL_PRO : Début écriture

	  Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
		@asIdAppli,
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	        @sMailFrom, 
		@sMailSend, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail, --#2
		'M7', -- #2
		2 -- #2

   End    -- TRACE_MAIL_PRO : Fin écriture

  Else

   Begin  -- TRACE_MAIL_TRT : Début écriture

	  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
		@asIdAppli,
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	        @sMailFrom, 
		@sMailSend, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail, --#2
		'M7', -- #2
		2 -- #2

   End    -- TRACE_MAIL_TRT : Fin écriture
	

  -- Problème suite éxécution
  If @iRet <> 0 Return -20

  -- Fin de traitement
  Set @asCasRetour = 'MAIL_ENVOYE'
  Return 0
Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S06_MAILPUSH_REGEN_MDP_SITE_CMDE
-- Auteur               :       Fabry JF
-- Date                 :       01/03/2007
-- Libelle              :	[SITE_CMDE]
-- Commentaires         :       Envoi de Mail regéné pour commande virtuel WEB
--
-- References           :
--
-- Arguments            :       @asIdAppli	varchar (20)		(val) Nom de l'application mère éxécutant la PS
--				@asBase		varchar (20)		(val) Nom de la base de données SHERPA ou SIMPA2
--				@adcIdSin       Decimal (  7,0 )        (Val)
--				@asCasRetour    VarChar (50)		(ref) Cas : MAIL_ENVOYE
--										    OPTION_DP_NON_PARAM
--										    HORS_BASE_DE_PRODUCTION
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-------------------------------------------------------------------
-- #1	JFF	21/01/2008  [FNAC_PROD_ECH_TECH].[SMS]
--      JFF 23/05/2012  [PM103][1]
-- JFF      12/02/2016   [PI062]
-- JFF      23/05/2018   [PM373-2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S06_MAILPUSH_REGEN_MDP_SITE_CMDE' AND type = 'P' )
        DROP procedure sysadm.PS_S06_MAILPUSH_REGEN_MDP_SITE_CMDE
GO


CREATE procedure sysadm.PS_S06_MAILPUSH_REGEN_MDP_SITE_CMDE
	@asIdAppli	varchar (20),
	@asBase		varchar (20),
	@adcIdSin      	Decimal (10), -- [PI062]
	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @dcIdGti 	Decimal (7),
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @sSaut	VarChar (10), 
  @sMarque	VarChar (35),
  @sModele	VarChar (35),  
  @sIdFour	VarChar (10),
  @sCodeEtat	VarChar (10),
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @iIdSeq 	Integer,
  @iOptionDP    Integer,
  @dtDteEnvCliActuel DateTime,
  @dtFinValideMdp DateTime,
  @dtMajle DateTime,
  @sBoiteMail   VarChar (35),
  @sURL		VarChar (300),
  @sDEL_MDP	VarChar (5),
  @sChoixServVoc VarChar ( 10 ),
  @sHoraireOuv VarChar (255),
  @sMdpNet VarChar ( 10 ),
  @sIdTypArt VarChar ( 3 ),
  @sFinValideMdp VarChar ( 30 ),
  @sAltSuiviSMS VarChar ( 1 ),  -- #1 [FNAC_PROD_ECH_TECH].[SMS]  
  @sNumGsmSMS   VarChar ( 20 )  -- #1 [FNAC_PROD_ECH_TECH].[SMS]  
  
  

  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  Set @asIdAppli = Upper ( @asIdAppli )

  -- Option de déclenchement du mail -DP
  Set @iOptionDP = 82

  -- [PM103][1]	
  	If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
		Begin
	 	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
 		Return 0
		End
  -- :[PM103][1]

  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@asBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
        @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT, 
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #2
	@sAltSuiviSMS OUTPUT, -- #1 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #1 [FNAC_PROD_ECH_TECH].[SMS]


  -- Cas de retour n'étant pas des erreurs
  If @iRet in ( -7, -9, -10 )
   Begin
	Select @asCasRetour =
	Case @iRet
		When -7 Then 'ADRESSE_MAIL_ABSENTE'
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

  -- Problème suite éxécution
  If @iRet <> 0 Return @iRet

  -- si nous sommes dans cette PS, c'est que nous sommes dans le cas d'une, le trigger l'a déterminé en amont.
  Select @sIdFour = IsNull (c.id_four, '' ),
	 @iIdSeq  = c.id_seq,
	 @dcIdGti = c.id_gti,
	 @sIdTypArt = c.id_typ_art,
	 @sMarque = IsNull ( sysadm.FN_TRIM ( ws.marq_port ), '') ,
	 @sModele = IsNull ( sysadm.FN_TRIM ( ws.modl_port ), '')
  From   sysadm.w_commande c, 
  	 sysadm.w_sin ws
  Where  c.id_sin = @adcIdSin
  And    c.id_typ_art = 'TEL'  
  And 	 c.cod_etat = 'CWE'
  And    c.id_four  = 'WBA'
  And    ws.id_sin = c.id_sin
  And 	 c.id_seq = ( Select max (c1.id_seq )
		      From sysadm.w_commande c1
		      Where c1.id_sin = c.id_sin
		      And   c1.id_typ_art = 'TEL'  
		      And   c1.cod_etat = 'CWE'
		     )

  If @sIdFour is null Or @sIdFour = '' 
   Begin
	Set @asCasRetour = 'AUCUNE_CMDE_SUR_CRITERE'
	Return 0
   End 

  -- Report de l'adr_mail sur la prestation
  /*
  If @sMailSend is not null And @sMailSend <> ''
   Begin
    Update sysadm.commande 
    Set    adr_mail = @sMailSend 
    Where  id_sin = @adcIdSin
    And    id_seq = @iIdSeq

    Update sysadm.w_commande 
    Set    adr_mail = @sMailSend 
    Where  id_sin = @adcIdSin
    And    id_seq = @iIdSeq
   End
*/
/* -- Pas utilse dans ce cas de cmde WEB
  -- Recherche supplèmentaire pour détection de a quarantaine par fournisseur.  
  If @sAltQuarant = 'N' 
   Begin
	  -- Le code de l'option de quarantaine est lié à l'option de déclenchement du mail.
	  Select @sAltQuarant = 
		 Case 
		   When d2.id_prod > 0 Then 'O'
		   Else 'N'
		 End 
	  From   sysadm.det_pro d,
		 sysadm.det_pro d2
	  where  d.id_prod = @dcIdProd
	  and    d.id_typ_code_dp = '-DP' 
	  and    d.id_code_dp = @iOptionDP 
	  and    d2.id_prod = d.id_prod
	  and    d2.id_typ_code_dp = '-DP'  
	  and    d2.id_code_dp = d.val_num
	  And    d2.id_code_car = @sIdFour 
   End 
*/

-- [PM373-2]
If Left ( @sNumProd, 5 ) not in ( '0 800', '0 825' )
	Begin
		Set @sNumProd = @sNumProd + ' (numéro non surtaxé)'
	End 

  Select @sURL = sysadm.FN_TRIM ( sysadm.FN_CLE_VAL ( 'URL', IsNull ( dp.val_car, '' ), ';' ) ),
  	 @sDEL_MDP = Upper ( sysadm.FN_TRIM ( sysadm.FN_CLE_VAL ( 'DEL_MDP', IsNull ( dp.val_car, '' ), ';' ) ))
  From   sysadm.det_pro dp
  Where  dp.id_prod = @dcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = 80
  and    dp.id_code_num = @dcIdGti 
  and    dp.id_code_car = @sIdTypArt

  Select @sChoixServVoc = sysadm.FN_TRIM ( IsNull ( dp.val_car, '' ) )
  From   sysadm.det_pro dp
  Where  dp.id_prod = @dcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = 58

  Select @sHoraireOuv = sysadm.FN_TRIM ( IsNull ( dp.val_car, '' ) )
  From   sysadm.det_pro dp
  Where  dp.id_prod = @dcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = 84

  Select @sMdpNet = sysadm.FN_TRIM ( dd.val_car ),
  	 @dtMajle = dd.maj_le
  From   sysadm.w_div_sin dd
  Where  dd.id_sin = @adcIdSin
  and    dd.nom_zone = 'mdp_net'

  IF     IsNumeric ( Left ( @sDEL_MDP, Len ( @sDEL_MDP ) -1 )) = 0 OR Right ( @sDEL_MDP, 1 ) Not in ( 'J', 'M', 'A' )
  	Begin
	  Set  @sFinValideMdp = '[PROBLEME PARAM SUR DEL_MDP -DP/80]'
	  Set  @sMailSend = 'epg_sinistre@spb.fr'
	  Set  @sMailObjet = @sMailObjet  + ' [PROBLEME PARAM SUR DEL_MDP -DP/80]'
  	End 
  Else
  	Begin
	  Select  @dtFinValideMdp  = 
		  Case Right ( @sDEL_MDP, 1 )
			When 'J' Then DateAdd ( day, convert ( integer, Left ( @sDEL_MDP, Len ( @sDEL_MDP ) - 1 ) ), @dtMajle )
			When 'M' Then DateAdd ( Month, convert ( integer, Left ( @sDEL_MDP, Len ( @sDEL_MDP ) - 1 ) ), @dtMajle )
			When 'A' Then DateAdd ( Year, convert ( integer, Left ( @sDEL_MDP, Len ( @sDEL_MDP ) - 1 ) ), @dtMajle )
		  End

	  Select  @sFinValideMdp = Convert ( VarChar ( 2 ), Datepart ( day, @dtFinValideMdp )) + ' ' + 
				   dateName ( month, @dtFinValideMdp  ) + ' ' +
				   convert ( VarChar (4) , Datepart ( year, @dtFinValideMdp  ) )
 	End 


  If @sURL is null or @sURL = '' 
   Begin
        Set  @sMailSend = 'EPG_Sinistre@spb.fr'
	Set  @sMailObjet = @sMailObjet  + ' [PROBLEME PARAM SUR URL -DP/80]'
	Set  @sURL = '[PROBLEME PARAM SUR URL -DP/80]'
   End 

  If @sChoixServVoc is null or @sChoixServVoc = ''
   Begin
        Set  @sMailSend = 'EPG_Sinistre@spb.fr'
	Set  @sMailObjet = @sMailObjet  + ' [PROBLEME PARAM SUR SERV_VOCAL -DP/80]'
	Set  @sChoixServVoc = '[PROBLEME PARAM SUR SERV_VOCAL -DP/80]'
   End 

  If @sMdpNet is null or @sMdpNet = ''
   Begin
        Set  @sMailSend = 'jff@spb.fr'
	Set  @sMailObjet = @sMailObjet  + ' [PROBLEME MDP_NET ABSENT]'
	Set  @sMdpNet = '[PROBLEME MDP_NET ABSENT]'
   End 

  -- Gestion de la civilité "Madame, Monsieur"
  If @sNom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sNom + ','
   End 

  -- Armement de l'objet du mail
-- [PM373-2]
  Set @sMailObjet = @sLibProd + '-CONFIRMATION DE PRISE EN CHARGE'
 
  Set @sMailBody = ''

  Set @sMailBody  = @sMailBody  + @sCiv
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut

  -- [PM373-2]
  -- Armement du corps du mail
	Set @sMailBody  = @sMailBody  + 'Suite à l''acceptation de prise en charge de votre dossier concernant votre ' + @sMarque + ' ' + @sModele + ' veuillez trouver ci-dessous votre code d''accès afin d''accéder à notre site ' + @sURL + ' afin de choisir votre nouvel appareil.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Vous aurez également besoin de votre numéro de sinistre indiqué dans un précédent e-mail.' + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Votre code d''accès :' + @sSaut
	Set @sMailBody  = @sMailBody  + @sMdpNet
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'En cas de difficulté, vous pouvez nous contacter au ' + @sNumProd
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sHoraireOuv + '.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous vous informons que ce code d''accès expirera le ' + @sFinValideMdp +'.' + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Passé ce délai, il faudra nous contacter par téléphone afin d’activer un nouveau code ou bien choisir un appareil avec l''un de nos conseillers.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Cordialement,' + @sSaut
	Set @sMailBody  = @sMailBody  + 'Votre gestionnaire SPB' + @sSaut

  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'


  -- On convertit pour l'appel de la PS
  Set @iIdSin  = Convert ( integer, @adcIdSin )
  Set @iIdProd = Convert ( integer, @dcIdProd )
  Set @iIdEts  = Convert ( integer, @dcIdEts )


If @@servername = master.dbo.SPB_FN_ServerName ('PRO')

   Begin  -- TRACE_MAIL_PRO : Début écriture

	  Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
		@asIdAppli,
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	        @sMailFrom, 
		@sMailSend, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail, --#2
		'M8', -- #2
		2 -- #2

   End    -- TRACE_MAIL_PRO : Fin écriture

  Else

   Begin  -- TRACE_MAIL_TRT : Début écriture

	  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
		@asIdAppli,
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	        @sMailFrom, 
		@sMailSend, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail, --#2
		'M8', -- #2
		2 -- #2

   End    -- TRACE_MAIL_TRT : Fin écriture
	

  -- Problème suite éxécution
  If @iRet <> 0 Return -20

  -- Fin de traitement
  Set @asCasRetour = 'MAIL_ENVOYE'
  Return 0
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       TR_U01_DIV_SIN_PUSH_S06
-- Auteur               :       Fabry JF
-- Date                 :       01/03/2007
-- Libelle              :	[SITE_CMDE]
-- Commentaires         :       Déclencheur de l'envoi du Mail regéné pour commande virtuelle WEB
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'TR_U01_DIV_SIN_PUSH_S06' AND type = 'TR' )
        DROP trigger sysadm.TR_U01_DIV_SIN_PUSH_S06
GO

CREATE TRIGGER sysadm.TR_U01_DIV_SIN_PUSH_S06
            ON sysadm.div_sin
    FOR UPDATE 
AS 

Declare @sDbName  	VarChar ( 20 )
Declare @sCasRetour     VarChar (50)
Declare @dcIdSin	Decimal ( 10 ) -- [PI062]
Declare @sMajPar  	VarChar( 4 )

If Update ( maj_le )


   Begin 
	-- Pré-select pour optimiser 
	If  ( 	Select count (*)
		From   inserted i, deleted d
		Where  i.nom_zone = 'mdp_net'
		And    i.nom_zone = d.nom_zone
		And    d.val_car is not null
		And    i.val_car is not null
		And    sysadm.FN_TRIM ( d.val_car ) <> ''
		And    sysadm.FN_TRIM ( i.val_car ) <> ''
		And    sysadm.FN_TRIM ( d.val_car ) <> sysadm.FN_TRIM ( i.val_car ) 
	     ) > 0

	  Begin 
		  -- Sommes-nous dans le cas d'une REgénération de mot passe donnant accès à l'extranet ?
		  Select @sMajPar = i.maj_par
		  From   sysadm.w_commande wc, 
		  	 sysadm.w_sin ws,
			 deleted d,
			 inserted i
		  Where  wc.id_sin = i.id_sin
		  And    wc.id_typ_art = 'TEL'  
		  And 	 wc.cod_etat = 'CWE'
		  And    wc.id_four  = 'WBA'
		  And	 ws.id_sin = wc.id_sin
		  And    ws.cod_etat in ( 100, 550 ) -- Sécurité !
		  And 	 i.nom_zone = 'mdp_net'
		  And    i.nom_zone = d.nom_zone
		  And	 d.val_car is not null
		  And	 i.val_car is not null
		  And    sysadm.FN_TRIM ( d.val_car ) <> ''
		  And    sysadm.FN_TRIM ( i.val_car ) <> ''
		  And    sysadm.FN_TRIM ( d.val_car ) <> sysadm.FN_TRIM ( i.val_car )
		If @@RowCount > 0 
			Begin
				Select Top 1 @dcIdSin = convert ( Decimal ( 10 ), i.id_sin ) From inserted i -- [PI062]

			        /* ... Envoi Mail regen mdp WBA/TEL/CWE via MAILPUSH JFF LE 01/03/2007 ...*/
					Set @sDbName = Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) )
			                EXEC sysadm.PS_S06_MAILPUSH_REGEN_MDP_SITE_CMDE 'SIMPA2', @sDbName, @dcIdSin, @sCasRetour OUTPUT


				-- [TRACE_21]
				EXEC sysadm.PS_I01_TRACE_CMDE_V01
					null,		-- @asIdSession     varchar(30),
					null,		-- @asBrowser       varchar(50),
					@dcIdSin,	-- @adcIdSin	    Decimal (7),
					null,		-- @asNumTel        varchar(10),
					null,		-- @asMdp           varchar(6),
					21,		-- @adcIdCodeTrc    Decimal(7),
					'TRACE', 	-- @asGravite       varchar(10),
					'SIM8',		-- @asIdAppli       varchar(5),
					'VALIDATION',	-- @asEtape         varchar(20),
					null,		-- @aiIdMess        integer
			                @sMajPar    -- @asMajPar        VarChar (4)

			End 

	  End 
   End 
GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S07_MAILPUSH_CONF_CMDE_WEB_ASS
-- Auteur               :       Fabry JF
-- Date                 :       27/03/2007
-- Libelle              :	[SITE_CMDE]
-- Commentaires         :       Envoi de Mail suite validation de la cmde Web par l'assuré sur le site
--
-- References           :
--
-- Arguments            :       @asIdAppli	varchar (20)		(val) Nom de l'application mère éxécutant la PS
--				@asBase		varchar (20)		(val) Nom de la base de données SHERPA ou SIMPA2
--				@adcIdSin       Decimal (  7,0 )        (Val)
--				@aiIdSeq	Integer		        (Val)
--				@asCasRetour    VarChar (50)		(ref) Cas : MAIL_ENVOYE
--										    OPTION_DP_NON_PARAM
--										    HORS_BASE_DE_PRODUCTION
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-------------------------------------------------------------------
-- #1	JFF	21/01/2008  [FNAC_PROD_ECH_TECH].[SMS]
-- JFF      12/02/2016   [PI062]
-- JFF      23/05/2018   [PM373-2]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S07_MAILPUSH_CONF_CMDE_WEB_ASS' AND type = 'P' )
        DROP procedure sysadm.PS_S07_MAILPUSH_CONF_CMDE_WEB_ASS
GO


CREATE procedure sysadm.PS_S07_MAILPUSH_CONF_CMDE_WEB_ASS
	@asIdAppli	varchar (20),
	@asBase		varchar (20),
	@adcIdSin      	Decimal (10), -- [PI062]
	@aiIdSeq	Integer,
	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @dcIdGti 	Decimal (7),
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @sSaut	VarChar (10), 
  @sMarque	VarChar (35),
  @sModele	VarChar (35),  
  @sIdFour	VarChar (10),
  @sCodeEtat	VarChar (10),
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @iOptionDP    Integer,
  @dtDteEnvCliActuel DateTime,
  @dtFinValideMdp DateTime,
  @dtMajle DateTime,
  @sBoiteMail   VarChar (35),
  @sURL		VarChar (300),
  @sDEL_MDP	VarChar (5),
  @sChoixServVoc VarChar ( 10 ),
  @sHoraireOuv VarChar (255),
  @sMdpNet VarChar ( 10 ),
  @sIdTypArt VarChar ( 3 ),
  @sFinValideMdp VarChar ( 30 ),
  @sAltSuiviSMS VarChar ( 1 ),  -- #1 [FNAC_PROD_ECH_TECH].[SMS]  
  @sNumGsmSMS   VarChar ( 20 )  -- #1 [FNAC_PROD_ECH_TECH].[SMS]  

  

  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  Set @asIdAppli = Upper ( @asIdAppli )

  -- Option de déclenchement du mail -DP
  Set @iOptionDP = 82

  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@asBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
        @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT, 
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #2
	@sAltSuiviSMS OUTPUT, -- #1 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #1 [FNAC_PROD_ECH_TECH].[SMS]


  -- Cas de retour n'étant pas des erreurs
  If @iRet in ( -7, -9, -10 )
   Begin
	Select @asCasRetour =
	Case @iRet
		When -7 Then 'ADRESSE_MAIL_ABSENTE'
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

  -- Problème suite éxécution
  If @iRet <> 0 Return @iRet

  -- si nous sommes dans cette PS, c'est que nous sommes dans le cas d'une, le trigger l'a déterminé en amont.
  Select @sIdFour = IsNull (c.id_four, '' ),
	 @sMarque = IsNull ( sysadm.FN_TRIM ( c.id_marq_art_ifr ), '') ,
	 @sModele = IsNull ( sysadm.FN_TRIM ( c.id_modl_art_ifr ), '')
  From   sysadm.commande c, 
  	 sysadm.sinistre s
  Where  c.id_sin = @adcIdSin
  And 	 c.id_seq = @aiIdSeq
  And    s.id_sin = c.id_sin
  And	 s.cod_etat in ( 100, 550 ) 

  If @sIdFour is null Or @sIdFour = '' 
   Begin
	Set @asCasRetour = 'AUCUNE_CMDE_SUR_CRITERE'
	Return 0
   End 


  -- Gestion de la civilité "Madame, Monsieur"
  If @sNom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sNom + ','
   End 

  -- Armement de l'objet du mail
  -- [PM373-2]
  Set @sMailObjet = @sLibProd + '-CONFIRMATION DE COMMANDE'
  Set @sMailBody = ''

  -- Armement du corps du mail
  Set @sMailBody  = @sMailBody  + @sCiv
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut

  -- [PM373-2]
  Set @sMailBody  = @sMailBody  + 'Nous vous confirmons que la commande de votre ' + @sMarque + ' ' + @sModele + ' a bien été prise en compte.'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Vous recevrez votre nouvel appareil dans les jours prochains.'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire.'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Cordialement,' + @sSaut
  Set @sMailBody  = @sMailBody  + 'Votre gestionnaire SPB' + @sSaut

  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'

  -- On convertit pour l'appel de la PS
  Set @iIdSin  = Convert ( integer, @adcIdSin )
  Set @iIdProd = Convert ( integer, @dcIdProd )
  Set @iIdEts  = Convert ( integer, @dcIdEts )


If @@servername = master.dbo.SPB_FN_ServerName ('PRO')

   Begin  -- TRACE_MAIL_PRO : Début écriture

	  Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
		@asIdAppli,
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	        @sMailFrom, 
		@sMailSend, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail, --#2
		'M9', -- #2
		2 -- #2

   End    -- TRACE_MAIL_PRO : Fin écriture

  Else

   Begin  -- TRACE_MAIL_TRT : Début écriture

	  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
		@asIdAppli,
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	        @sMailFrom, 
		@sMailSend, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail, --#2
		'M9', -- #2
		2 -- #2

   End    -- TRACE_MAIL_TRT : Fin écriture
	

  -- Problème suite éxécution
  If @iRet <> 0 Return -20

  -- Fin de traitement
  Set @asCasRetour = 'MAIL_ENVOYE'
  Return 0
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I01_SMSPUSH
-- Auteur               :       Fabry JF
-- Date                 :       19/01/2009
-- Libelle              :
-- Commentaires         :       Envoi du SMS vers TRACE_MAIL_xxx.sms_push.
--
-- References           : 	[FNAC_PROD_ECH_TECH].[SMS]
--
-- Arguments            :       
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-------------------------------------------------------------------
--      JFF   23/05/2012 [PM103][1]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I01_SMSPUSH' AND type = 'P' )
        DROP procedure sysadm.PS_I01_SMSPUSH
GO

CREATE procedure sysadm.PS_I01_SMSPUSH
	@adcIdSin      	Decimal (10), -- [PI062]
	@asBase		varchar (20),
	@asNumGsm	VarChar ( 20 ),
	@asLogin	VarChar ( 10 ),
	@asMdPasse	VarChar( 10 ),
        @asSmsBody      VarChar ( 255 ),
	@asCodeTrt	VarChar( 10 ),
	@asTypSms	VarChar ( 10),
	@aiIdAppli	Integer

AS
Declare 
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @sLibProd	VarChar ( 35 ),
  @iRet		Integer

  -- [PM103][1]	
	If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
	  Begin
		Return 0
	  End
  -- :[PM103][1]

  Set    @iIdSin  = Convert ( integer, @adcIdSin )
  Set 	 @asTypSms    = Upper ( @asTypSms )
  
  Select @iIdProd  = Convert ( integer, id_prod ),
	 @sLibProd = sysadm.FN_LIB_PROD ( id_prod ),
	 @iIdEts   = Convert ( integer, id_ets )
  From   sysadm.w_sin ws
  where  ws.id_sin = @adcIdSin

  -- Sommes-nous sur un serveur de production ?
  If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
    If Upper ( Right ( sysadm.FN_TRIM ( @asBase) , 4 ) ) <> '_PRO' Return -20


  If @@servername = master.dbo.SPB_FN_ServerName ('PRO')

   Begin  -- TRACE_MAIL_PRO : Début écriture

	  Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_SMS_PUSH_V00 
		'SIMPA2',
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	        @asNumGsm,
		@asLogin,
		@asMdPasse,
        	@asSmsBody,
		@asCodeTrt,
		@asTypSms,
		@aiIdAppli

   End    -- TRACE_MAIL_PRO : Fin écriture

  Else

   Begin  -- TRACE_MAIL_TRT : Début écriture

	  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_SMS_PUSH_V00 
		'SIMPA2',
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	        @asNumGsm,
		@asLogin,
		@asMdPasse,
        	@asSmsBody,
		@asCodeTrt,
		@asTypSms,
		@aiIdAppli

   End    -- TRACE_MAIL_TRT : Fin écriture

  -- Problème suite éxécution
  If @iRet <> 0 Return -20

  Return 0

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S08_MAILPUSH_CORPS_MAIL_FNAC_900
-- Auteur               :       Fabry JF
-- Date                 :       06/03/2009
-- Libelle              :	[FNAC_PROD_ECH_TECH].[20090224144248310]
-- Commentaires         :       Construction de toutes les variantes de corps de mail FNAC
-- References           :
--
-- Arguments            :         @adcIdSin     Decimal (7), 
--				  @aiIdSeq 	Integer,
--				  @aiInfoSpbFrn Integer,
--				  @asMailBody	VarChar ( 7000 )  OUTPUT
--
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-------------------------------------------------------------------
-- #1	JFF	30/03/2009	[FNAC_PROD_ECH_TECH].[20090330152547023]
-- #2	JFF	18/05/2009	[DCMP09172]
-- #3   JFF     05/05/2009      [RUEDUCOMMERCE]
-- #4   JFF     05/05/2009      [DCMP090298]
-- #5   JFF     02/09/2009  	[DCMP090327].[SBETV]
-- #7   JFF     07/10/2009      [DCMP090421]
-- #8   JFF     30/10/2009      [DCMP090421].[20091102140141080] maim d'aurélien le 30/10/2009 17h37
-- #9   JFF     25/11/2009      [MSS_DIAG]
-- #10  JFF     02/03/2010      [MSS_LOT2]
-- #11	FPI	06/04/2010	[DMDI28280] Colissimo S->M
--      JFF     13/04/2010      [ADRESSE_O2M]
-- -- 	JFF	06/04/2010	[MSS_LOT2].[20100506155536700]
--      JFF     10/06/2010      [PC419/440/418/439_MICROMANIA]
--	JFF     05/01/2011      [PC202].[DOM_COM]
--	FPI	26/04/2011	[VDoc3929]
--	JFF	20/06/2011	[PC545].[RR7255]
--	JFF	07/07/2011	[PC292]
--      JFF     05/07/2011      [AUCHAN].[AUCH_SITCOL_NVFRONT]
--      JFF     06/08/2012      [BLCODE]
--      JFF     29/08/2012      [VDOC7524]
--      JFF     26/11/2012      [PC877]
--      JFF     17/01/2013      [PC913]
--      JFF     02/04/2013      [PC929_CDISCOUNT]
--      JFF      07/05/2013   [PC938_ORANGE_V3]
--      JFF      07/05/2013   [PC929-1]
--      JFF      03/10/2013   [VDOC12339]
--      JFF      06/11/2013   [ITSM182630]
--      JFF      08/01/2014   [VDOC13009]
--		FPI		 20/05/2014	  [PM261-1]
--		FPI		 25/07/2014	  [VDOC14922]
--		FPI		 13/11/2014	  [VDoc14882] Changement d'adresse O2M (PS_I01_MAIL_PUSH_V01)
--		JFF      02/02/2015   [DT122]
--      JFF      09/04/2015   [DT141]
--      JFF      12/05/2015   [DT141][MANTIS15452]
--		FPI		 01/06/2015	  [VDOC17736] Correction adresse BLC
--      JFF      09/06/2015   [DT148]
--      JFF      10/06/2015   [PM280-1][MANTIS15456]
--      JFF      03/07/2015   [VDOC18066]
--		JFF      22/07/2015   [DT168]
--      JFF      07/12/2015   [DT153-1]
--      JFF      11/01/2016   [DT188]
--      JFF      29/02/2016   [DT191-1]
--      JFF      29/03/2016   [DT200]
--      JFF      19/04/2016   [DT153-2]
--		JFF      25/05/2016   [DT191-2][MANTIS20753]
--      FPI      15/07/2016   [VDOC21247]
--      JFF      12/02/2016   [PI062]
--		JFF      07/11/2016   [PC151259]
--		JFF      23/06/2017   [DT287][M24755] modif demandé par Pierre-Antoine.
--		JFF		 31/08/2017   [VDOC24508]
--      JFF      23/06/2020   [PC202553_SELECTRA]
--      JFF      15/01/2021   [DT517]
--      JFF      27/10/2021   [RS1218-RS1259-ADRO2M]
--      JFF      14/06/2023   [PMO139][RS4926]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S08_MAILPUSH_CORPS_MAIL_FNAC_900' AND type = 'P' )
        DROP procedure sysadm.PS_S08_MAILPUSH_CORPS_MAIL_FNAC_900
GO

CREATE procedure sysadm.PS_S08_MAILPUSH_CORPS_MAIL_FNAC_900
  @adcIdSin     Decimal (10), -- [PI062]
  @aiIdSeq 	Integer,
  @asCiv	Varchar ( 30 ),
  @asMarque	VarChar ( 35 ), 
  @asModele	VarChar ( 35 ), 
  @aiInfoSpbFrn Integer,
  @asMailBody	VarChar ( 7000 ) OUTPUT
  
AS
Declare 
@sSaut		VarChar (10),
@iAlimSin	Integer,
@iBattSin	Integer,
@iAppSin	Integer,
@iAccSin	Integer, -- #10[MSS_LOT2].[P3]
@sVar1		VarChar ( 200 ),
@sVar2		VarChar ( 10 ),
@sFrais		VarChar ( 100 ),
@sLibTyp106	VarChar ( 100 ),
@sPce441	VarChar ( 500 ),
@sPce74		VarChar ( 500 ), -- #1 [FNAC_PROD_ECH_TECH].[20090330152547023]
@sRdv		VarChar ( 150 ),
@sTailleCarton  VarChar ( 150 ),
@sBoutique 	VarChar ( 250 ),
@CpltAdrFrnProd VarChar ( 100 ), 
@sNomContractant VarChar ( 100 ), -- #2 [DCMP09172]
@iRDCommerce     Integer, -- #3 [RUEDUCOMMERCE]
@iAuchan		 Integer, -- [AUCH_SITCOL_NVFRONT]
@iMicromania     Integer, -- [VDoc3929]
@iFNACEpt        Integer, -- #4 [DCMP090298]
@sTypApp	Varchar ( 3 ), -- #4 [DCMP090298]
@sMarqApp	Varchar (35), -- #4 [DCMP090298]
@sBoiteMail     VarChar (35),
@sNomLigne1	VarChar ( 35 ), -- [ADRESSE_O2M]
@sNomLigne2	VarChar ( 35 ), -- [ADRESSE_O2M]
@sAdrLigne1	VarChar ( 35 ),	-- [ADRESSE_O2M]
@sAdrLigne2	VarChar ( 35 ),	-- [ADRESSE_O2M]	
@sCP		VarChar ( 35 ), -- [ADRESSE_O2M]
@sVille	VarChar ( 35 ),  -- [ADRESSE_O2M]
@sAdressO2M	VarChar ( 200 ),  -- [ADRESSE_O2M]
@iPacifica      Integer, -- [PC202].[DOM_COM]
@iDomCom        Integer, -- [PC202].[DOM_COM]
@sValDepotAgence VarChar(10), -- [PC491]
@FNAC_RR7PC545  Integer, -- [PC545].[RR7255]
@sIdFour	VarChar (3), -- [BLCODE]
@dcIdProd   Decimal (7 ), -- [PC938_ORANGE_V3]
@lCodeBtqRelaiPSM Integer, -- [PC938_ORANGE_V3]
@sAdressPSM	VarChar ( 200 ),  -- [PC938_ORANGE_V3]
@sTypRelai  VarChar ( 50 ),  -- [PC938_ORANGE_V3]
@sVar3  VarChar ( 50 ),  -- [PC938_ORANGE_V3]
@iOrangeV3 Integer, -- [PC938_ORANGE_V3]
@sIdRefFour VarChar  ( 50 ), -- [PC929-1]
@sVarianteDiagDP129 VarChar ( 30 ), -- [VDOC12339]
@iDp260 Integer, -- [PM261-1]
@iElectroDepot Integer, -- [PC13321]
@iElectroDepotBrun Integer, -- [PC13321]
@iSouplessePacifia Integer, -- [DT122]
@iDiagSBE Integer, -- [DT141]
@iRepaSBE Integer, -- [DT168]
@iDp279_DT145 Integer, -- [DT145_V4]
@sNumImeiAnc Varchar ( 50 ), -- [DT145_V4]
@dcIdGti      Decimal (7), -- [DT145_V4]
@iDP212CarrefourGRBB Integer, -- [DT148]
@iDP61Leclerc Integer, -- [DT148]
@sARepGarantie Varchar ( 10 ), -- [PM280-1][MANTIS15456]
@iRSTsuivicmde Integer -- [DT153]

Set @sSaut = Char (10)
Set @asMailBody = ''
Set @sVar1 = ''
Set @sVar2 = ''
Set @sPce441 = ''
Set @sPce74 = ''
Set @sFrais = ''
Set @sLibTyp106 = ''
Set @sRdv = ''
Set @sTailleCarton = ''
Set @sNomContractant = '' -- #2 [DCMP09172]



-- [PC938_ORANGE_V3]
Select @dcIdProd = s.id_prod
From   sysadm.sinistre s
Where s.id_sin = @adcIdSin

-- [DT153-1]
Select @lCodeBtqRelaiPSM = convert ( Integer, Replace ( sysadm.FN_CLE_VAL ( 'CODE_BTQ_RELAI_PSM', c.info_spb_frn_cplt, ';'), '#', '') ),
		@sTypRelai=sysadm.FN_CLE_VAL ( 'TYP_RELAI', c.info_spb_frn_cplt, ';')
From   sysadm.w_commande c
Where  c.id_sin = @adcIdSin
And    c.id_seq = @aiIdSeq

-- [PC896][V4]
if @asMarque = 'PAS_DE_MARQUE'
	Begin
		Set @asMarque = ''
	End 

-- [BLCODE]
-- [PC929-1]
Select  @sIdFour = c.id_four,
		@sIdRefFour = c.id_ref_four,
		@dcIdGti = c.id_gti, -- [DT145_V4]
		@sNumImeiAnc = IsNull ( rtrim ( c.id_serie_anc ), '' ), -- [DT145_V4]
		@sARepGarantie = IsNull ( sysadm.FN_CLE_VAL ( 'A_REP_GARANTIE', RTRIM ( c.info_spb_frn_cplt), ';' ), '' ) -- [PM280-1][MANTIS15456]	
From    sysadm.w_commande c
Where   c.id_sin = @adcIdSin
And     c.id_seq = @aiIdSeq 	

Set @sVar3 = ''
-- [DT191-1]
Set @sVar3 = 'de remplacement'
    
If @sIdRefFour = 'REFUSE_A_REEXP'
	Begin
	Set @sVar3 = 'sinistré'
	End
		 

If @sTypRelai = 'PRET' 
 Begin 
	Set @sVar3 = 'de remplacement anticipé'
 End 

If @sTypRelai = 'REMPL' 
 Begin 
	Set @sVar3 = 'de remplacement'	 
 End 


-- [ADRESSE_O2M] Récup Adresse O2M en fonction du contexte.
Exec sysadm.PS_S01_ADRESSE_O2M_V01
@adcIdSin	,
'',
@sNomLigne1	OUTPUT,
@sNomLigne2	OUTPUT,
@sAdrLigne1	OUTPUT,
@sAdrLigne2	OUTPUT,
@sCP		OUTPUT,
@sVille		OUTPUT

Set @sAdressO2M = ''
If @sNomLigne1 is not null And Len ( @sNomLigne1 ) > 0 Set @sAdressO2M = @sAdressO2M  + @sNomLigne1 + @sSaut 
If @sNomLigne2 is not null And Len ( @sNomLigne2 ) > 0 Set @sAdressO2M = @sAdressO2M  + @sNomLigne2 + @sSaut 
If @sAdrLigne1 is not null And Len ( @sAdrLigne1 ) > 0 Set @sAdressO2M = @sAdressO2M  + @sAdrLigne1 + @sSaut 
If @sAdrLigne2 is not null And Len ( @sAdrLigne2 ) > 0 Set @sAdressO2M = @sAdressO2M  + @sAdrLigne2 + @sSaut 		
If @sCP is not null And Len ( @sCP ) > 0 Set @sAdressO2M = @sAdressO2M  + @sCP 
If @sVille is not null And Len ( @sVille ) > 0 Set @sAdressO2M = @sAdressO2M  + ' ' + @sVille + @sSaut 		

If @sIdFour = 'BLC'
  Begin 
   -- [VDOC13009]
   -- [VDOC17736]
	-- [RS3337]
	If sysadm.FN_CLE_NUMERIQUE ( 'RS3337') > 0 
		Begin
			Set @sAdressO2M = 'LOXY' + @sSaut
			Set @sAdressO2M = @sAdressO2M + '21-23 Rue Saint-Hilaire' + @sSaut
			Set @sAdressO2M = @sAdressO2M + 'Saint-Ouen l''Aumône' + @sSaut
			Set @sAdressO2M = @sAdressO2M + '95041 CERGY-PONTOISE CEDEX 1' + @sSaut
		End 
	Else
	  Begin
		-- [RS1218-RS1259-ADRO2M]
		Set @sAdressO2M = 'SPB PEM' + @sSaut
		Set @sAdressO2M = @sAdressO2M + '124, rue Salvador Allende' + @sSaut
		Set @sAdressO2M = @sAdressO2M + '95870 BEZONS' + @sSaut
	  End
  End 

-- [PC13348&13408]
If @sIdFour = 'MTT'
  Begin 
	Set @sAdressO2M = 'ADAR' + @sSaut
	Set @sAdressO2M = @sAdressO2M + 'Générale Télécom Services' + @sSaut
	Set @sAdressO2M = @sAdressO2M + 'SAV' + @sSaut 	
	Set @sAdressO2M = @sAdressO2M + '15, Allée Jean Jaurès' + @sSaut 		
	Set @sAdressO2M = @sAdressO2M + '31000 TOULOUSE - France' + @sSaut 			
  End 

-- [DT141]
If @sIdFour = 'SBE'
  Begin 
	Set @sAdressO2M = 'SBE France' + @sSaut
	Set @sAdressO2M = @sAdressO2M + 'Assurance SPB-AIG' + @sSaut 	
	Set @sAdressO2M = @sAdressO2M + '1 bd de la Liane' + @sSaut 		
	Set @sAdressO2M = @sAdressO2M + '62360 SAINT LEONARD' + @sSaut 			
  End 

-- [ADRESSE_O2M]

-- Chargement des variables
Select @iAlimSin = IsNull( count (*) , 0 )
From   sysadm.div_sin ds
where  ds.id_sin = @adcIdSin
And    ds.nom_zone = 'alim_sin'
and    ds.val_car = 'O'
If @iAlimSin is null Set @iAlimSin = 0

Select @iBattSin = IsNull( count (*) , 0 )
From   sysadm.div_sin ds
where  ds.id_sin = @adcIdSin
And    ds.nom_zone = 'batt_sin'
and    ds.val_car = 'O'
If @iBattSin is null Set @iBattSin = 0

-- #10 [MSS_LOT2].[P3]
Select @iAccSin = IsNull( count (*) , 0 )
From   sysadm.div_sin ds
where  ds.id_sin = @adcIdSin
And    ds.nom_zone = 'aut_acc_sin'
and    ds.val_car = 'O'
If @iAccSin is null Set @iAccSin = 0
-- :#10 [MSS_LOT2].[P3]

Select @iAppSin = IsNull( count (*) , 0 )
From   sysadm.div_sin ds
where  ds.id_sin = @adcIdSin
And    ds.nom_zone = 'app_sin'
and    ds.val_car = 'O'
If @iAppSin is null Set @iAppSin = 0

-- #2 [DCMP09172]
Select 	@sNomContractant = IsNull ( sysadm.FN_TRIM ( dp.val_car ), '' ) 
From	sysadm.det_pro dp,
	sysadm.sinistre s
Where	s.id_sin = @adcIdSin
And 	dp.id_prod = s.id_prod
And	dp.id_code_dp = 59
If @sNomContractant is null Set @sNomContractant = ''
-- :#2 [DCMP09172]

-- #3 [RUEDUCOMMERCE]
Select @iRDCommerce = IsNull ( count ( * ), 0 )
From	sysadm.det_pro dp,
	sysadm.sinistre s
Where	s.id_sin = @adcIdSin
And 	dp.id_prod = s.id_prod
And	dp.id_code_dp = 114
If @iRDCommerce is null Set @iRDCommerce = 0
-- :#3 [RUEDUCOMMERCE]

-- [AUCHAN].[AUCH_SITCOL_NVFRONT]
Select @iAuchan = IsNull ( count ( * ), 0 )
From	sysadm.det_pro dp,
	sysadm.sinistre s
Where	s.id_sin = @adcIdSin
And 	dp.id_prod = s.id_prod
And	dp.id_code_dp = 140
If @iAuchan is null Set @iAuchan = 0
-- [AUCHAN].[AUCH_SITCOL_NVFRONT]

-- [PC13321][MANTIS14046]
Select @iElectroDepot = IsNull ( count ( * ), 0 )
From	sysadm.det_pro dp,
	sysadm.sinistre s
Where	s.id_sin = @adcIdSin
And 	dp.id_prod = s.id_prod
And	dp.id_code_dp = 266
If @iElectroDepot is null Set @iElectroDepot = 0

Select @iElectroDepotBrun = 
			Case 
				When sysadm.FN_CLE_VAL ( 'VARIANTE', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';' ) = 'BRUN' Then 1
				Else 0
			End 

From	sysadm.det_pro dp,
	sysadm.sinistre s
Where	s.id_sin = @adcIdSin
And 	dp.id_prod = s.id_prod
And	dp.id_code_dp = 266
If @iElectroDepotBrun is null Set @iElectroDepotBrun = 0
-- [PC13321]

-- [PC202].[DOM_COM]
Select @iPacifica = IsNull ( count ( * ), 0 )
From	sysadm.det_pro dp,
	sysadm.sinistre s
Where	s.id_sin = @adcIdSin
And 	dp.id_prod = s.id_prod
And	dp.id_code_dp = 138
If @iPacifica is null Set @iPacifica = 0

If @iPacifica > 0 
 Begin
  Select @iDomCom = IsNull ( count ( * ), 0 )
  From	 sysadm.w_div_sin dp,
	 sysadm.w_sin s
  Where	 s.id_sin = @adcIdSin
  And 	 dp.id_sin = s.id_sin
  And    dp.nom_zone = 'id_cli_bq'
  And    dp.val_nbre in ( 900, 902, 903 )
 End 
-- [PC202].[DOM_COM]

-- #4 [DCMP090298]
Select @iFNACEpt = IsNull ( count ( * ), 0 )
From	sysadm.det_pro dp,
	sysadm.sinistre s
Where	s.id_sin = @adcIdSin
And 	dp.id_prod = s.id_prod
And	dp.id_code_dp = 105
If @iFNACEpt is null Set @iFNACEpt = 0

-- [VDoc3929] - [PC491]
Select @sValDepotAgence=sysadm.FN_CLE_VAL('DEPOT_EN_AGENCE',val_car,'')
From	sysadm.det_pro dp,
	sysadm.sinistre s
Where	s.id_sin = @adcIdSin
And 	dp.id_prod = s.id_prod
And	dp.id_code_dp = 137
select @iMicromania=@@RowCount
If @sValDepotAgence is null or rtrim(@sValDepotAgence) = '' Set @sValDepotAgence = 'OUI'

Select @sMarqApp = Upper( s.marq_port )
From   sysadm.sinistre s
Where  s.id_sin = @adcIdSin 
If @sMarqApp is null Set @sMarqApp = ''

Select @sTypApp = Upper ( ds.val_car )
From   sysadm.div_sin ds
where  ds.id_sin = @adcIdSin
And    ds.nom_zone = 'type_app'
If @sTypApp is null Set @sTypApp = ''
-- :#4 [DCMP090298]

-- [VDOC12339]	
Select @sVarianteDiagDP129 = sysadm.FN_CLE_VAL ( 'VARIANTE_DIAG', rtrim ( dp.val_car ), ';' )
From   sysadm.det_pro dp
Where  dp.id_prod = @dcIdProd
and    dp.id_typ_code_dp = '-DP' 
and    dp.id_code_dp = 129
 
-- [PM261-1]
select @iDp260=COUNT(*)
From   sysadm.det_pro dp
Where  dp.id_prod = @dcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = 260 

-- [DCMP090421]
Select  @CpltAdrFrnProd = IsNull ( sysadm.FN_CLE_VAL ( 'CPLT_ADR_FRN_PROD', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';' ), '' )
From	sysadm.det_pro dp,
	sysadm.sinistre s,
	sysadm.div_sin ds
Where s.id_sin = @adcIdSin
And	 dp.id_prod = s.id_prod
And   dp.id_code_dp = 95
And   ds.id_sin = s.id_sin
And   ds.nom_zone = 'type_app'
And   CharIndex ( sysadm.FN_TRIM ( 'TYP_APP=' + IsNull ( Upper ( ds.val_car), '')), rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), 1 ) > 0
And   CharIndex ( 'ACTION=A_DIAGNOSTIQUER', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), 1 ) > 0
If @CpltAdrFrnProd is null Set @CpltAdrFrnProd = ''
-- :[DCMP090421]

-- [DT122]
Select @iSouplessePacifia = IsNull ( count ( * ), 0 )
From	sysadm.det_pro dp,
	sysadm.sinistre s
Where	s.id_sin = @adcIdSin
And 	dp.id_prod = s.id_prod
And	dp.id_code_dp = 269
If @iSouplessePacifia is null Set @iSouplessePacifia = 0
-- [DT122]

-- [DT141]
Select @iDiagSBE = IsNull ( count ( * ), 0 )
From	sysadm.commande c
Where	c.id_sin = @adcIdSin
And		c.id_seq = @aiIdSeq
And		c.id_ref_four = 'A_DIAGNOSTIQUER'
And		c.id_four = 'SBE'
If @iDiagSBE is null Set @iDiagSBE = 0
-- [DT141]

-- [DT168]
Select @iRepaSBE = IsNull ( count ( * ), 0 )
From	sysadm.commande c
Where	c.id_sin = @adcIdSin
And		c.id_seq = @aiIdSeq
And		c.id_ref_four = 'A_REPARER'
And		c.id_four = 'SBE'
If @iRepaSBE is null Set @iRepaSBE = 0
-- [DT141]

-- [DT145_V4]
-- [DT19-2][MANTIS20753]
select @iDp279_DT145 = COUNT(*)
From   sysadm.det_pro dp,
	   sysadm.commande c
Where   dp.id_prod = @dcIdProd
and     dp.id_typ_code_dp = '-DP' 
and     dp.id_code_dp = 279 
And		c.id_sin = @adcIdSin
And		c.id_seq = @aiIdSeq
And		c.id_ref_four in ( 'A_REPARER', 'A_DIAGNOSTIQUER', 'A_DESOXYDER' )
-- [DT145_V4]

-- [DT148]
select @iDP212CarrefourGRBB = COUNT(*)
From   sysadm.det_pro dp
Where  dp.id_prod = @dcIdProd
and    dp.id_typ_code_dp = '-DP' 
and    dp.id_code_dp = 212 

select @iDP61Leclerc = COUNT(*)
From   sysadm.det_pro dp
Where  dp.id_prod = @dcIdProd
and    dp.id_typ_code_dp = '-DP' 
and    dp.id_code_dp = 61 -- 267 changé en 61 
    
-- Précision sur L'appareil
-- #8 [DCMP090421].[20091102140141080] maim d'aurélien le 30/10/2009 17h37 "accompagné impérativement"
If @iAppSin > 0 
 Begin 
-- #8 [DCMP090421].[20091102140141080] mail d'aurélien le 30/10/2009 17h37 	
-- 	Set @sVar1 = 'votre appareil et tous les accessoires d''origine (manuel, batterie amovible, alimentation externe, etc)'
 	Set @sVar1 = 'votre appareil accompagné impérativement de tous les accessoires d''origine (manuel, batterie amovible, alimentation externe, etc)'

	-- [VDOC12339]	
	If 	@aiInfoSpbFrn in ( 910 ) And @sTypApp = 'TEL'
	Begin
		Set @sVar1 = 'votre appareil'
	End 
	-- [VDOC12339]				

		
	If 	@aiInfoSpbFrn in ( 912 ) And @sTypApp = 'TEL' -- -- [VDOC14922]
	Begin
		Set @sVar1 = 'votre appareil sans ses accessoires d''origine'
	End 
	
	-- [ITSM182630]
	If 	@sTypApp in ( 'LIT', 'MEU', 'CRS', 'SIE' )
	Begin
		Set @sVar1 = 'votre appareil accompagné impérativement de tous les accessoires d''origine'
	End 
	-- [ITSM182630]	 

	-- [DT122]
	If @iSouplessePacifia > 0 And @sTypApp = 'TEL'
	 Begin
		Set @sVar1 = 'votre appareil'	 
	 End 

--  [VDoc3929] 
	If @sTypApp in ('CJL','GCJ','PCJ','CJP') And @iMicromania=1
	Begin
		Set @sVar1 = 'votre appareil accompagné impérativement des accessoires d''origine suivants : '
		If @sTypApp in ('CJL','GCJ','PCJ') 
		Begin
			Set @sVar1  = @sVar1  + @sSaut + '- 1 manette de jeux ' 
			Set @sVar1  = @sVar1  + @sSaut + '- le câble d’alimentation ' 
			Set @sVar1  = @sVar1  + @sSaut + '- le disque dur externe (uniquement pour les XBOX 360) ' 
			Set @sVar1  = @sVar1  + @sSaut + '- le câble vidéo' + @sSaut 
		End 
		Else
		Begin
			Set @sVar1  = @sVar1  + @sSaut + '- le bloc d’alimentation ' 
			Set @sVar1  = @sVar1  + @sSaut + '- la batterie' + @sSaut 
		End
	End
 End 

If @iAlimSin > 0 And @iBattSin > 0 And @sVar1 = ''
 Begin 
-- #8 [DCMP090421].[20091102140141080] maim d'aurélien le 30/10/2009 17h37 	
-- 	Set @sVar1 = 'votre batterie amovible, votre alimentation externe et tous les accessoires d''origine (manuel, etc)' 	
-- 	Set @sVar1 = 'votre batterie amovible et votre câble d''alimentation accompagnés impérativement de tous les accessoires d''origine (manuel, etc)' 	 	

	--  [PC545].[RR7255]
	Set @sVar1 = 'votre batterie amovible et votre câble d''alimentation'	 
 End 

If @iBattSin > 0 And @sVar1 = ''
 Begin 
-- #8 [DCMP090421].[20091102140141080] maim d'aurélien le 30/10/2009 17h37 	
-- 	Set @sVar1 = 'votre batterie amovible et tous les accessoires d''origine (manuel, etc)' 	
-- 	Set @sVar1 = 'votre batterie amovible accompagnée impérativement de tous les accessoires d''origine (manuel, etc)' 	

	--  [PC545].[RR7255]
	Set @sVar1 = 'votre batterie amovible'	 

 End 

If @iAlimSin > 0 And @sVar1 = ''
 Begin 
-- #8 [DCMP090421].[20091102140141080] maim d'aurélien le 30/10/2009 17h37 	
-- 	Set @sVar1 = 'votre alimentation externe et tous les accessoires d''origine (manuel, etc)' 	
 	Set @sVar1 = 'votre câble d''alimentation accompagné impérativement de tous les accessoires d''origine (manuel, etc)' 	 	 	

	--  [PC545].[RR7255]
	Set @sVar1 = 'votre câble d''alimentation'	 

 End 

-- #10 [MSS_LOT2].[P3]
If @iAccSin > 0 And @sVar1 = '' 
 Begin 
-- [MSS_LOT2].[20100506155536700]
--	Set @sVar1 = 'votre ou vos accessoire(s) sinistré(s) accompagné(s) impérativement de tous les accessoires d''origine (manuel, etc)' 	 	

--	[PC545].[RR7255]
--	Set @sVar1 = 'votre ou vos accessoire(s) sinistré(s) accompagné(s)' 	 	
	Set @sVar1 = 'votre ou vos accessoire(s) sinistré(s)' 	 	

-- :[MSS_LOT2].[20100506155536700]	

 End 
If @sVar1 is null Set @sVar1 = ''
-- #10 [MSS_LOT2].[P3]


-- Précision colissimo
If @aiInfoSpbFrn = 905
 Begin
	--Set @sVar2 = 'S'  
	Set @sVar2 = 'M'  -- [DMDI28280] Colissimo S->M
 End 

-- #9 [MSS_DIAG]
If @aiInfoSpbFrn in ( 910, 1234 )
 Begin
	Set @sVar2 = 'M'  
	
	-- [PC202].[DOM_COM]	
	If @iPacifica >0 And @iDomCom > 0
	 Begin
		Set @sVar2 = 'L'  	 
	 End 
 End 

-- [PC419/440/418/439_MICROMANIA]
If @aiInfoSpbFrn in ( 961 )
 Begin
	Set @sVar2 = 'L'  
 End 

If @aiInfoSpbFrn in ( 962 )
 Begin
	Set @sVar2 = 'XL'  
 End 
-- [PC419/440/418/439_MICROMANIA]

If @sVar2 is null Set @sVar2 = ''

/*
If @aiInfoSpbFrn = 1235
 Begin
	Set @sVar2 = 'XL'  
 End 
*/ 
-- :#9 [MSS_DIAG]

-- Le rdv
-- #9 [MSS_DIAG]
-- #10 [MSS_LOT2] supp 1238, 1256
If @aiInfoSpbFrn in ( 955, 1237, 1255 )
 Begin
   Select  @sRdv= IsNull ( sysadm.FN_CLE_VAL ( 'DTE_HEU_RDV', sysadm.FN_TRIM ( c.info_spb_frn_cplt ), ';' ), '' )
   From    sysadm.commande c
   Where   c.id_sin = @adcIdSin
   And     c.id_seq = @aiIdSeq 	
   
   --   [16/03/2009 13:00-17:00][17/03/2009 13:00-17:00]
   Select @sRdv = Replace ( @sRdv, '][', ', ' )
   Select @sRdv = Replace ( @sRdv, '[', '' )
   Select @sRdv = Replace ( @sRdv, ']', '' )   
   
 End
If @sRdv is null Set @sRdv = ''

-- Pièce 441
If ( Select Count (*) 
     From sysadm.w_piece g
     Where g.id_sin = @adcIdSin
     And   g.id_detail = -1
     And   g.id_pce = 441 ) > 0 
     
     Begin
	Set @sPce441 = '- La facture ' + @sNomContractant + ' où figure le montant d''achat de votre appareil et du règlement de la cotisation'
     End 

-- Pièce 74 -- #1 [FNAC_PROD_ECH_TECH].[20090330152547023]
If ( Select Count (*) 
     From sysadm.w_piece g
     Where g.id_sin = @adcIdSin
     And   g.id_detail = -1
     And   g.id_pce = 74 ) > 0 
     
     Begin
	Set @sPce74 = '- Le bulletin d''adhésion'
	If @iRDCommerce > 0 
		  Begin
		  	Set @sPce74 = '- La copie du certificat d''adhésion'
		  End 
     End 
If @sPce441 is null Set @sPce441 = ''
If @sPce74  is null Set @sPce74 = ''

-- Frais ?
-- #9 [MSS_DIAG]
-- #10 [MSS_LOT2] supp 1238, 1256, 1235
-- [PC419/440/418/439_MICROMANIA]
-- [PC913] 951
If @aiInfoSpbFrn in ( 905, 910, 915, 920, 936, 941, 1234, 961, 962, 951)
 Begin

   If @iAccSin = 0 And @iAlimSin = 0 And @iBattSin = 0 
	Begin
	   -- [DT168][MANTIS16641]
	   Select  @sFrais = IsNull ( sysadm.FN_CLE_VAL ( 'MT_FRAIS', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';' ), '' )
	   From	sysadm.det_pro dp,
		sysadm.sinistre s,
		sysadm.div_sin ds
	   Where s.id_sin = @adcIdSin
	   And	 dp.id_prod = s.id_prod
	   And   dp.id_code_dp = 95
	   And   ds.id_sin = s.id_sin
	   And   ds.nom_zone = 'type_app'
	   And	 sysadm.FN_CLE_VAL ( 'TYP_APP', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';' ) = IsNull ( Upper ( ds.val_car), '')
	   And	 sysadm.FN_CLE_VAL ( 'ACTION', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';' ) In ( 'A_DIAGNOSTIQUER', 'A_REPARER', 'A_DESOXYDER' ) 
	End 
   Else
   	Begin
	   -- [DT168][MANTIS16641]
	   Select Top 1 @sFrais = IsNull ( sysadm.FN_CLE_VAL ( 'MT_FRAIS', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';' ), '' )
	   From	sysadm.det_pro dp,
		sysadm.sinistre s
	   Where s.id_sin = @adcIdSin
	   And	 dp.id_prod = s.id_prod
	   And   dp.id_code_dp = 95
	   And	 sysadm.FN_CLE_VAL ( 'CTG', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';' ) = 'B'
	   And	 sysadm.FN_CLE_VAL ( 'ACTION', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';' ) In ( 'A_DIAGNOSTIQUER', 'A_REPARER', 'A_DESOXYDER' ) 
   	End 
   
   If @sFrais is null Set @sFrais = ''
   
   If @sFrais <> '' 
    Begin
    	Set @sFrais = 'Vous serez remboursé de vos frais d''envoi d''un montant de ' + @sFrais + '€.'
    	
    	If @iRDCommerce > 0 
	  Begin
		Set @sFrais = @sFrais + ' (Si envoi depuis la France)'
	  End 

	-- [PC202].[DOM_COM]	
	If @iPacifica >0 And @iDomCom > 0
	 Begin
    		Set @sFrais = 'Vous serez remboursé de vos frais d''envoi d''un montant de 27€ maximum.'	 
	 End 
    	
    End 
   
 End 

If @sFrais is null Set @sFrais = ''

If @sARepGarantie = 'OUI' Set @sFrais = '' -- [PM280-1][MANTIS15456]

-- Taille carton + boutique
-- #9 [MSS_DIAG]
-- #10 [MSS_LOT2] supp 1261
-- [PC292] ajout 963
If @aiInfoSpbFrn in ( 945, 950, 960, 906, 911, 1240, 1115, 1260, 963 )
 Begin
	/*
	Set @sTailleCarton = '(inconnu)'
	If @aiInfoSpbFrn = 906 Set @sTailleCarton = '20x20x20 cm'
	If @aiInfoSpbFrn = 911 Set @sTailleCarton = '30x30x30 cm'
	If @aiInfoSpbFrn = 945 Set @sTailleCarton = '50x50x25 cm'
	If @aiInfoSpbFrn = 950 Set @sTailleCarton = '50x50x50 cm'
	If @aiInfoSpbFrn = 960 Set @sTailleCarton = 'adaptée'
	*/
	Set @sTailleCarton = 'emballage'
	
	If @aiInfoSpbFrn in ( 1240 ) 
	Begin
		Set @sTailleCarton = 'un emballage prépayé CHONO 13'
	End 

	If @aiInfoSpbFrn in ( 1260 ) 
	Begin
		Set @sTailleCarton = 'emballage spécial'
	End 

	Select @sBoutique = IsNull ( sysadm.FN_TRIM ( b.adr_nom ), '') + ', ' + IsNull ( sysadm.FN_TRIM ( b.adr_ville ), '' ) + ' (' + IsNull ( sysadm.FN_TRIM ( b.adr_cp ), '' ) + ') ' + IsNull ( sysadm.FN_TRIM ( b.adr_1 ), '' ) + ' ' + IsNull ( sysadm.FN_TRIM ( b.adr_2 ), '' )  
	From	sysadm.boutique b,
		sysadm.sinistre s
	Where	s.id_sin = @adcIdSin
	and 	b.id_prod = s.id_prod
	and     b.id_boutique = s.id_orian_boutique
	-- and     b.region <> 'FRN=PSM' -- ITSM214014
	And ( b.region is null Or CHARINDEX ( '=', b.region ) = 0 ) -- [PC151259]

	
 End
 
 If @sTailleCarton is null Set @sTailleCarton = ''
 If @sBoutique is null Set @sBoutique = ''
 
 
-- Libellé appareil -DP/106
   Select @sLibTyp106 = IsNull ( sysadm.FN_TRIM ( dp.val_car ), '' )
   From	sysadm.det_pro dp,
   	sysadm.sinistre s,
   	sysadm.div_sin ds
   Where s.id_sin = @adcIdSin
   And	 dp.id_prod = s.id_prod
   And   dp.id_code_dp = 106
   And   ds.id_sin = s.id_sin
   And   ds.nom_zone = 'type_app'
   And   dp.id_code_car = ds.val_car

   If @sLibTyp106 is null Set @sLibTyp106 = ''   

-- [PC938_ORANGE_V3]   
If @aiInfoSpbFrn in ( 973 )
	Begin
	
		Set @sNomLigne1	= ''
		Set @sNomLigne2	= ''
		Set @sAdrLigne1	= ''
		Set @sAdrLigne2	= ''
		Set @sCP		= ''
		Set @sVille		= ''

		Exec sysadm.PS_S_BOUTIQUE_ADRESSE 
		@dcIdProd, 
		@lCodeBtqRelaiPSM, 
		@sNomLigne1 OUTPUT,
		@sAdrLigne1 OUTPUT,
		@sAdrLigne2 OUTPUT,
		@sVille OUTPUT,
		@sCP  OUTPUT

		Set @sAdressPSM = ''
		If @sNomLigne1 is not null And Len ( @sNomLigne1 ) > 0 Set @sAdressPSM = @sAdressPSM + @sNomLigne1 + @sSaut 
		If @sAdrLigne1 is not null And Len ( @sAdrLigne1 ) > 0 Set @sAdressPSM = @sAdressPSM + @sAdrLigne1 + @sSaut 
		If @sAdrLigne2 is not null And Len ( @sAdrLigne2 ) > 0 Set @sAdressPSM = @sAdressPSM  + @sAdrLigne2 + @sSaut 		
		If @sCP is not null And Len ( @sCP ) > 0 Set @sAdressPSM = @sAdressPSM  + @sCP 
		If @sVille is not null And Len ( @sVille ) > 0 Set @sAdressPSM = @sAdressPSM + ' ' + @sVille + @sSaut 		

	End    
   
-- [DT153-1]				
Select  @iRSTsuivicmde = IsNull ( count ( * ), 0 )
From	sysadm.w_commande c
Where	c.id_sin = @adcIdSin
And		c.id_seq = @aiIdSeq
And		c.id_four = 'O2M' 
And		c.id_typ_art in ( 'RST' ) 
And		sysadm.FN_CLE_VAL ( 'RST_CMDE+SUIVI', rtrim ( c.info_spb_frn_cplt), ';'  ) = 'OUI' 
And		( c.info_spb_frn in ( 973, 974, 975, 983) or c.info_spb_frn is null )
If @iRSTsuivicmde is null Set @iRSTsuivicmde = 0
-- [DT153-1]				
   
-- Construction du mail

-- Entête
Set @asMailBody  = @asMailBody  + @asCiv
Set @asMailBody  = @asMailBody  + @sSaut
Set @asMailBody  = @asMailBody  + @sSaut

-- [929-1]
If @sIdRefFour in ( 'A_REPARER', 'A_DESOXYDER' ) -- [DT168]
   And Not Exists ( Select Top 1 1
					From   sysadm.commande c
					Where	c.id_sin = @adcIdSin
					And		c.id_seq = @aiIdSeq
					And     sysadm.FN_CLE_VAL ( 'NE_PAS_REPARER', c.info_spb_frn_cplt, ';' ) = 'OUI' 
				   ) -- [DT200]
 Begin
  Set @asMailBody  = @asMailBody  + 'Une demande de réparation concernant votre ' + @sLibTyp106 + ' ' + @asMarque + ' ' + @asModele + ' vient d''être transmise à notre centre de réparation.'
 End
Else
 Begin
  Set @asMailBody  = @asMailBody  + 'Une demande de diagnostic concernant votre ' + @sLibTyp106 + ' ' + @asMarque + ' ' + @asModele + ' vient d''être transmise à notre centre de diagnostic.'
 End  
 
Set @asMailBody  = @asMailBody  + @sSaut

-- Corps du mail selon le process.
-- #9 [MSS_DIAG]
-- #10 [MSS_LOT2] supp 1238, 1256, 1235
-- [PC419/440/418/439_MICROMANIA]
If @aiInfoSpbFrn in ( 905, 910, 903, 1234, 961, 962, 951)
	Begin
		-- #9 [MSS_DIAG]
		-- #10 [MSS_LOT2] supp 1238, 1256, 1235
		-- [PC419/440/418/439_MICROMANIA]
		-- [PC913]
		If @aiInfoSpbFrn in ( 905, 910, 1234, 961, 962, 951 )
			Begin
				-- [VDoc3929]
				--Set @asMailBody  = @asMailBody  + 'Merci d''envoyer ' + @sVar1 + ' à l''adresse suivante : '
				Set @asMailBody  = @asMailBody  + 'Merci d''envoyer ' + @sVar1 
				If @iMicromania=0 Set @asMailBody  = @asMailBody  + ' à l''adresse suivante : '
				Else 
				Begin
				  If Right(@asMailBody,1) <> @sSaut Set @asMailBody  = @asMailBody + '.' 
				  Set @asMailBody  = @asMailBody + @sSaut + @sSaut + 'Adresse d''envoi :'
				End
			End 

		-- #1 [FNAC_PROD_ECH_TECH].[20090330152547023]
		If @aiInfoSpbFrn in ( 903 )
			Begin
				Set @asMailBody  = @asMailBody  + 'Merci de déposer ' + @sVar1 + ' à l''adresse suivante : '
			End 
			
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut


		-- #9 [MSS_DIAG]
		-- [PC419/440/418/439_MICROMANIA]
		-- [PC951]
		If @aiInfoSpbFrn in ( 903, 905, 910, 961, 962, 951)
			Begin 
-- [ADRESSE_O2M]				
				Set @asMailBody  = @asMailBody  + @sAdressO2M
-- [ADRESSE_O2M]
			End 
			
		-- #9 [MSS_DIAG]
		-- #10 [MSS_LOT2] supp 1235
		If @aiInfoSpbFrn in ( 1234 )
			Begin 
				Set @asMailBody  = @asMailBody  + 'MSS - SPB' + @CpltAdrFrnProd + @sSaut + 'Centre technique de diagnostic' + @sSaut + 'Fnac Garantie Echange' + @sSaut + '1 rue des Frères Lumière ' + @sSaut +  '93160 NOISY LE GRAND'			
			End 			

		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut

		-- #9 [MSS_DIAG]
		-- #10 [MSS_LOT2] supp 1235
		-- [PC419/440/418/439_MICROMANIA]
		If @aiInfoSpbFrn in ( 905, 910, 1234, 961, 962)
			Begin
				-- [VDOC7524]
				If @iAppSin > 0 
			     Begin
					Set @asMailBody  = @asMailBody  + 'Vous pouvez pour cela utiliser l''emballage d''origine de votre appareil ou un Colissimo de taille ' + @sVar2 + '.'
				 End					
				Else
			     Begin
					Set @asMailBody  = @asMailBody  + 'Vous pouvez pour cela utiliser un Colissimo de taille ' + @sVar2 + '.'
				 End					
				 
			End 

		-- [PC913]
		If @aiInfoSpbFrn in ( 951 )
		    Begin
				Set @asMailBody  = @asMailBody  + 'Vous pouvez pour cela utiliser l''emballage d''origine de votre appareil ou un emballage Colissimo.'		    
		    End
			
			
		-- #1 [FNAC_PROD_ECH_TECH].[20090330152547023]
		If @aiInfoSpbFrn in ( 903 )
			Begin
				-- [VDOC7524]
				If @iAppSin > 0 
			     Begin
					Set @asMailBody  = @asMailBody  + 'Vous pouvez pour cela utiliser l''emballage d''origine de votre appareil ou un autre emballage.'
				 End
				Else
			     Begin
					Set @asMailBody  = @asMailBody  + 'Vous pouvez pour cela utiliser un emballage de votre choix.'
				 End
			End 
	 
		Set @asMailBody  = @asMailBody  + @sSaut

		-- #3 [RUEDUCOMMERCE]
		If @iRDCommerce > 0 
		  Begin
		  	Set @asMailBody  = @asMailBody  + 'L''envoi doit se faire par la Poste depuis la France ou par colis depuis l''étranger (en prenant soin de bien protéger l''appareil).'
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sSaut
		  End

		
		-- :#3 [RUEDUCOMMERCE]

		-- [VDOC12339]	
		Set @asMailBody  = @asMailBody  + 'Mettez dans l''emballage :'		  
		Set @asMailBody  = @asMailBody  + @sSaut

		If @sPce441 <> '' 
		  Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sPce441
		  End 

		If @sPce74 <> '' 
		  Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sPce74
		  End 

		-- #4 [DCMP090298]
		If @iFNACEpt > 0 And @sMarqApp = 'NIKON' And @sTypApp = 'APN'
		  Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + '- La carte de garantie de l''appareil (sur laquelle apparaît le numéro de série ). Si vous ne la possédez plus, redemandez en une à votre magasin FNAC, sans cette carte, le diagnostic de votre appareil sera plus long.'
		  End
		-- :#4 [DCMP090298]

		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + '- Le n° de commande SPB : ' + Convert ( Varchar (10), @adcIdSin ) + '-' + Convert ( Varchar (3), @aiIdSeq ) -- [PI062]

		-- [DT141]
		If @iDiagSBE > 0 
		 Begin
		  Set @asMailBody  = @asMailBody  + @sSaut
--		  Set @asMailBody  = @asMailBody  + '- La copie de la facture d’achat de ce dernier.' [VDOC24508]
		  Set @asMailBody  = @asMailBody  + '- La copie de la facture d’achat de votre appareil.' -- [VDOC24508]
		  Set @asMailBody  = @asMailBody  + @sSaut
		  Set @asMailBody  = @asMailBody  + '- La copie de ce mail, nécessaire à l''identification de votre appareil par le centre technique.' -- [VDOC18066]
		 End

		-- [DT168]
		If @iRepaSBE > 0 
		 Begin
		  Set @asMailBody  = @asMailBody  + @sSaut
		  Set @asMailBody  = @asMailBody  + '- La copie de ce mail, nécessaire à l''identification de votre appareil par le centre technique.' -- [VDOC18066]
		 End


		-- [VDOC12339]	
		If @sTypApp = 'TEL'
		 Begin
			If @sVarianteDiagDP129 = 'ORANGE/SFR'	
				Begin
					Set @asMailBody  = @asMailBody  + @sSaut
					Set @asMailBody  = @asMailBody  + '- La batterie'
					Set @asMailBody  = @asMailBody  + @sSaut			
					Set @asMailBody  = @asMailBody  + @sSaut			
					Set @asMailBody  = @asMailBody  + 'Merci de ne pas mettre dans l''emballage, ni la carte SIM, ni carte mémoire'
					Set @asMailBody  = @asMailBody  + @sSaut			
				End

			If @sVarianteDiagDP129 = 'DISTRIB/BAC'	
				Begin
					Set @asMailBody  = @asMailBody  + @sSaut
					Set @asMailBody  = @asMailBody  + '- La batterie et les pièces demandées'
					Set @asMailBody  = @asMailBody  + @sSaut			
					Set @asMailBody  = @asMailBody  + @sSaut			
					Set @asMailBody  = @asMailBody  + 'Merci de ne pas mettre dans l''emballage, ni la carte SIM, ni carte mémoire'
					Set @asMailBody  = @asMailBody  + @sSaut			
				End
		End
		
		-- [DT141]
		If @iDiagSBE > 0 Or @iRepaSBE > 0 -- [DT168]
		 Begin
		  Set @asMailBody  = @asMailBody  + @sSaut					
		  Set @asMailBody  = @asMailBody  + 'Nous vous remercions de prendre les mesures nécessaires à la sauvegarde de l''ensemble des données enregistrées sur le produit assuré préalablement à son envoi.' 
		  Set @asMailBody  = @asMailBody  + @sSaut					
		 End 
		 
		If @iDiagSBE > 0 -- [DT168]
		 Begin
		  Set @asMailBody  = @asMailBody  + @sSaut					
		  Set @asMailBody  = @asMailBody  + 'De plus, pour traiter votre demande il est nécessaire que la fonction de localisation de votre mobile soit désactivée. Sans la désactivation de cette fonction nous ne pourrons pas intervenir sur votre appareil qui vous sera alors renvoyé en l''état.'
		  Set @asMailBody  = @asMailBody  + @sSaut
--		  Set @asMailBody  = @asMailBody  + 'Si vous ne parvenez pas à désactiver l''application << Localiser mon iPhone >> sur l''appareil sinistré, merci de suivre la procédure suivante :' -- [VDOC24508]
		  Set @asMailBody  = @asMailBody  + 'Si vous ne parvenez pas à désactiver l''application << Localiser mon iPhone >> sur l''appareil sinistré, veuillez cliquer sur http://www.degeoloc.com et suivre la procédure.' -- [VDOC24508]
		  Set @asMailBody  = @asMailBody  + @sSaut

/* -- [VDOC24508]
		  Set @asMailBody  = @asMailBody  + '1 Eteignez l''appareil sur lequel vous souhaitez désactiver l''application << Localiser mon iPhone >>.'
		  Set @asMailBody  = @asMailBody  + @sSaut
		  Set @asMailBody  = @asMailBody  + '2 Sur un ordinateur, connectez-vous sur le site internet icloud.com/#find avec votre identifiant Apple (celui que vous utilisez avec iCloud).'
		  Set @asMailBody  = @asMailBody  + @sSaut
		  Set @asMailBody = @asMailBody  + '3 Dans << Icloud Réglages >>, sélectionner l''application << Localiser mon Iphone >> (<< Find my Iphone >>).'
		  Set @asMailBody  = @asMailBody  + @sSaut
		  Set @asMailBody  = @asMailBody  + '4 Cliquez sur << Tous mes appareils >>, sélectionnez votre appareil hors ligne, puis cliquez sur << Supprimer >> de Localiser mon iPhone. Si cette option ne s''affiche pas, cliquez une nouvelle fois sur << Tous mes appareils >>, puis sur le bouton << Supprimer (x) >> en regard de l''appareil.'
		  Set @asMailBody  = @asMailBody  + @sSaut					  
*/
		 End
		
	End

-- #7   JFF     07/10/2009      [DCMP090421]
-- [PC877] [PC913] 952 [PC929_CDISCOUNT]
If @aiInfoSpbFrn in ( 907, 912, 937, 942, 908, 913, 938, 943, 909, 914, 939, 944, 967, 968, 952, 972  )
	Begin


		-- [PC877]
		If @aiInfoSpbFrn in ( 909, 914, 939, 944, 968 )
		 Begin
			Set @asMailBody  = @asMailBody + 'Vous recevrez prochainement un emballage vide avec un bon prépayé à l''intérieur.' 
			Set @asMailBody  = @asMailBody + @sSaut  
			Set @asMailBody  = @asMailBody + @sSaut  
			--	[DT287][M24755]
		    Set @asMailBody  = @asMailBody + 'Merci de coller le bon prépayé sur le colis et de l''envoyer vers notre centre de diagnostic à l''adresse indiquée sur le bon prépayé.'
		 End

		-- [PC877]
		If @aiInfoSpbFrn in ( 908, 913, 938, 943 )
		 Begin
			Set @asMailBody  = @asMailBody + 'Vous recevrez prochainement par courrier ou par mail un bon prépayé à imprimer.' 
			Set @asMailBody  = @asMailBody + @sSaut  
			Set @asMailBody  = @asMailBody + @sSaut  

			--	[DT287][M24755]
		    Set @asMailBody  = @asMailBody + 'Lorsque vous l''aurez imprimé, merci de coller le bon prépayé sur le colis et de l''envoyer vers notre centre de diagnostic à l''adresse indiquée sur le bon prépayé.'
		 End

		-- [PC913] [PC929_CDISCOUNT]
		If @aiInfoSpbFrn in ( 907, 912, 937, 942, 967, 952, 972 )
		 Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + 'Vous avez choisi de télécharger et d''imprimer un bon prépayé.'
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sSaut

			Set @asMailBody  = @asMailBody  + 'Vous allez recevoir prochainement de notre centre de diagnostic un mail sur lequel se trouvera l''adresse du site extranet où télécharger le bon prépayé, ainsi que votre login pour y accéder.'
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sSaut
			
			--	[DT287][M24755]
		    Set @asMailBody  = @asMailBody + 'Lorsque vous l''aurez imprimé, merci de coller le bon prépayé sur le colis et de l''envoyer vers notre centre de diagnostic à l''adresse indiquée sur le bon prépayé.'
		 End
	

		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut

		-- [AUCHAN].[AUCH_SITCOL_NVFRONT]
		-- [MANTIS6127] déplacé en dessous l'adresse.
		IF @iAuchan > 0 
		  Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + 'Attention, pour les frontaliers uniquement, il faut déposer les colis ayant une vignette pré-payée (téléchargée), dans une poste FRANCAISE.' 
		  End 
		-- [AUCHAN].[AUCH_SITCOL_NVFRONT]

		-- [VDOC7667] on enlève "Dans tous les cas" dans "Dans tous les cas, vous devez"
		/*
		If @sValDepotAgence = 'OUI' -- [PC491]
		Begin
			Set @asMailBody  = @asMailBody  + 'Vous avez aussi, si vous le souhaitez, la possibilité de retourner votre colis vers notre centre de diagnostic par UPS en le déposant en agence, ou bien en prenant rendez-vous à votre domicile (ou votre lieu de travail).' 

			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sSaut		
		End -- [PC491]
		*/
		
		-- [PC175]
		If @iMicromania=1 and @sTypApp in ('GCJ','PCJ','CJP')
		Begin
			Set @asMailBody  = @asMailBody  + 'Mettez dans l''emballage, avec les accessoires :'
		End
		Else 
		-- [VDOC7667] on enlève "Dans tous les cas" dans "Dans tous les cas, vous devez"
		Begin
			Set @asMailBody  = @asMailBody  + 'Vous devez mettre dans l''emballage, ' + @sVar1 + ', ainsi que :'
		End
		-- :[PC175]
		
		Set @asMailBody  = @asMailBody  + @sSaut

		If @sPce441 <> '' 
		  Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sPce441
		  End 

		If @sPce74 <> '' 
		  Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sPce74
		  End 

		-- #4 [DCMP090298]
		If @iFNACEpt > 0 And @sMarqApp = 'NIKON' And @sTypApp = 'APN'
		  Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + '- La carte de garantie de l''appareil (sur laquelle apparaît le numéro de série ). Si vous ne la possédez plus, redemandez en une à votre magasin FNAC, sans cette carte, le diagnostic de votre appareil sera plus long.
'
		  End
		-- :#4 [DCMP090298]

		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + '- Le n° de commande SPB : ' + Convert ( Varchar (10), @adcIdSin ) + '-' + Convert ( Varchar (3), @aiIdSeq ) -- [PI062]

	End
-- :#7   JFF     07/10/2009      [DCMP090421]

If @aiInfoSpbFrn in ( 915, 920 )
	Begin
		Set @asMailBody  = @asMailBody  + 'Merci d''envoyer ' + @sVar1 + ' à l''adresse suivante : '
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sAdressO2M

		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut


		-- [DT122]
		If @iSouplessePacifia > 0 
		  Begin
			Set @asMailBody  = @asMailBody  + 'Placez votre ' + @sLibTyp106 + ' dans un emballage solide et protégez le.'		
		  End 
		Else
		 Begin 
			 Set @asMailBody  = @asMailBody  + 'Comme vous nous l''avez précisé lors de votre déclaration, vous possédez l''emballage d''origine de votre ' + @sLibTyp106 + '.Vous devez adresser votre appareil dans cet emballage.'
		 End

		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sFrais
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut

		-- #3 [RUEDUCOMMERCE]
		If @iRDCommerce > 0 
		  Begin
		  	Set @asMailBody  = @asMailBody  + 'L''envoi doit se faire par la Poste depuis la France ou par colis depuis l''étranger (en prenant soin de bien protéger l''appareil).'
		  End

		
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut
		-- :#3 [RUEDUCOMMERCE]

		Set @asMailBody  = @asMailBody  + 'Mettez dans l''emballage, avec les accessoires :'
		Set @asMailBody  = @asMailBody  + @sSaut

		If @sPce441 <> '' 
		  Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sPce441
		  End 

		If @sPce74 <> '' 
		  Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sPce74
		  End 

		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + '- Le n° de commande SPB : ' + Convert ( Varchar (10), @adcIdSin ) + '-' + Convert ( Varchar (3), @aiIdSeq ) -- [PI062]

	End

-- [PC913] 953
If @aiInfoSpbFrn in ( 935, 940, 953 )
	Begin
		Set @asMailBody  = @asMailBody  + 'Notre centre de diagnostic va vous envoyer par transporteur un emballage adapté à votre ' + @sLibTyp106 + '.'
		
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut		
		
		Set @asMailBody  = @asMailBody  + 'Selon le mode d''emploi se trouvant dans l''emballage, vous devrez directement contacter le transporteur pour l''enlèvement de votre appareil. Ce retrait ne se fera pas au moment du dépôt de l''emballage, mais au plus tôt le lendemain.'

		Set @asMailBody  = @asMailBody  + @sSaut
		
		Set @asMailBody  = @asMailBody  + 'Les frais de transport seront à la charge de notre centre de diagnostic, vous n''aurez aucun règlement à effectuer.'

		Set @asMailBody  = @asMailBody  + @sSaut
		-- [VDoc3929] Enlever la virgule avant "ainsi" si en début de ligne
		--Set @asMailBody  = @asMailBody  + 'Placez dans l''emballage ' + @sVar1 + ', ainsi que :'
		Set @asMailBody  = @asMailBody  + 'Placez dans l''emballage ' + @sVar1 
		If Right(@asMailBody,1) = @sSaut Set @asMailBody  = @asMailBody+ 'ainsi que :'
		Else Set @asMailBody  = @asMailBody+ ', ainsi que :'
		
		Set @asMailBody  = @asMailBody  + @sSaut

		If @sPce441 <> '' 
		  Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sPce441
		  End 

		If @sPce74 <> '' 
		  Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sPce74
		  End 

		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + '- Le n° de commande SPB : ' + Convert ( Varchar (10), @adcIdSin ) + '-' + Convert ( Varchar (3), @aiIdSeq ) -- [PI062]

	End

-- [PC363_AUCHAN] [PC292]
If @aiInfoSpbFrn in ( 963 )
	Begin
		Set @asMailBody  = @asMailBody  + 'Merci de laisser votre ' + @sLibTyp106 + ' chez ' + @sNomContractant + ' ' + sysadm.FN_TRIM ( @sBoutique )
		
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut		

		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + 'Laissez ' + @sVar1 + ', ainsi que :'
		Set @asMailBody  = @asMailBody  + @sSaut

		If @sPce441 <> '' 
		  Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sPce441
		  End 

		If @sPce74 <> '' 
		  Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sPce74
		  End 

		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + '- Le n° de commande SPB : ' + Convert ( Varchar (10), @adcIdSin ) + '-' + Convert ( Varchar (3), @aiIdSeq ) -- [PI062]
	
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut		
		Set @asMailBody  = @asMailBody  + 'La SAV se chargera d''acheminer votre appareil vers notre centre technique de diagnostic.'
	
	End

If @aiInfoSpbFrn in ( 936, 941 )
	Begin
		Set @asMailBody  = @asMailBody  + 'Notre centre de diagnostic va vous envoyer par transporteur un emballage adapté à votre ' + @sLibTyp106 + '.'
		
		Set @asMailBody  = @asMailBody  + @sSaut

		Set @asMailBody  = @asMailBody  + 'Merci d''envoyer ' + @sVar1 + ' par Colissimo à l''adresse suivante : '
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut
-- [ADRESSE_O2M]
		Set @asMailBody  = @asMailBody  + @sAdressO2M
-- [ADRESSE_O2M]

		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sFrais
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut

		Set @asMailBody  = @asMailBody  + 'Mettez dans l''emballage, avec les accessoires :'
		Set @asMailBody  = @asMailBody  + @sSaut

		If @sPce441 <> '' 
		  Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sPce441
		  End 

		If @sPce74 <> '' 
		  Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sPce74
		  End 

		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + '- Le n° de commande SPB : ' + Convert ( Varchar (10), @adcIdSin ) + '-' + Convert ( Varchar (3), @aiIdSeq )-- [PI062]

	End

-- #9 [MSS_DIAG]
If @aiInfoSpbFrn in ( 1236 )
	Begin
		Set @asMailBody  = @asMailBody  + 'Notre centre de diagnostic va vous envoyer un emballage CHRONO 13 prépayé adapté à votre ' + @sLibTyp106 + '.'
		
		Set @asMailBody  = @asMailBody  + @sSaut

		Set @asMailBody  = @asMailBody  + 'Merci d''envoyer ' + @sVar1 + ' dans cet emballage CHRONO 13 prépayé à l''adresse suivante : '
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + 'MSS - SPB' + @CpltAdrFrnProd + @sSaut + 'Centre technique de diagnostic' + @sSaut + 'Fnac Garantie Echange' + @sSaut + '1 rue des Frères Lumière ' + @sSaut +  '93160 NOISY LE GRAND'
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut

		Set @asMailBody  = @asMailBody  + 'Mettez dans l''emballage, avec les accessoires :'
		Set @asMailBody  = @asMailBody  + @sSaut

		If @sPce441 <> '' 
		  Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sPce441
		  End 

		If @sPce74 <> '' 
		  Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sPce74
		  End 

		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + '- Le n° de commande SPB : ' + Convert ( Varchar (10), @adcIdSin ) + '-' + Convert ( Varchar (3), @aiIdSeq ) -- [PI062]

	End

-- #9 [DCMP090327].[SBETV]
-- #9 [MSS_DIAG]
-- #10 [MSS_LOT2] supp 1238, 1256
-- [PC929-1]
-- [PC13321]
If @aiInfoSpbFrn in ( 955, 1110, 1237, 1255, 956, 1112, 957 )
	Begin
		-- [PC13321]
		If @aiInfoSpbFrn in ( 957 ) 
		  Begin
		    -- [DT148]
		    If @iDP212CarrefourGRBB > 0 Or @iDP61Leclerc > 0 
		      Begin
				Set @asMailBody  = @asMailBody  + 'Notre centre de diagnostic va prendre contact avec vous pour fixer un rendez-vous à votre domicile pour tenter de réparer l''appareil sinistré.'
				Set @asMailBody  = @asMailBody  + @sSaut

				-- [DT517]
					If @sIdFour = 'O2M'
						Begin 
							Set @asMailBody  = @asMailBody  + 'Si cela est possible, un diagnostic vidéo pourra également vous être proposé.'
							Set @asMailBody  = @asMailBody  + @sSaut
						End 

				Set @asMailBody  = @asMailBody  + 'Si cette réparation n''est pas possible à domicile, nous reviendrons vers vous pour la suite donnée à votre dossier.'
		      End
		    Else
		      Begin
				Set @asMailBody  = @asMailBody  + 'Notre centre de réparation va prendre contact avec vous pour fixer un rendez-vous à votre domicile pour tenter de réparer l''appareil sinistré.'
				Set @asMailBody  = @asMailBody  + @sSaut

				-- [DT517]
				If @sIdFour = 'O2M'
					Begin 
						Set @asMailBody  = @asMailBody  + 'Si cela est possible, un diagnostic vidéo pourra également vous être proposé.'
						Set @asMailBody  = @asMailBody  + @sSaut
					End 

				Set @asMailBody  = @asMailBody  + 'Si cette réparation n''est pas possible à domicile, mais que le matériel sinistré est couvert par le contrat d''assurance, le transporteur n''enlèvera pas l''appareil sinistré, qui restera votre propriété.'
		      End 
		  
		  End 
	
		-- [PC13321]
		If @aiInfoSpbFrn in ( 955 ) -- ITSM191057 supp ,956
		  IF @iElectroDepot > 0 
		    Begin
				If @iElectroDepotBrun > 0
				  Begin
					Set @asMailBody  = @asMailBody  + 'Notre centre de technique va prendre contact avec vous pour fixer un rendez-vous à votre domicile afin d''enlever votre appareil sinistré.'
					Set @asMailBody  = @asMailBody  + @sSaut

					-- [DT517]
					If @sIdFour = 'O2M'
						Begin 
							Set @asMailBody  = @asMailBody  + 'Si cela est possible, un diagnostic vidéo pourra également vous être proposé.'
							Set @asMailBody  = @asMailBody  + @sSaut
						End 


					Set @asMailBody  = @asMailBody  + 'Ce matériel sera diagnostiqué en station.'
				  End
				Else
				  Begin
					Set @asMailBody  = @asMailBody  + 'Notre centre de réparation va prendre contact avec vous pour fixer un rendez-vous à votre domicile pour tenter de réparer l''appareil sinistré.'
					Set @asMailBody  = @asMailBody  + @sSaut

					-- [DT517]
					If @sIdFour = 'O2M'
						Begin 
							Set @asMailBody  = @asMailBody  + 'Si cela est possible, un diagnostic vidéo pourra également vous être proposé.'
							Set @asMailBody  = @asMailBody  + @sSaut
						End 

					Set @asMailBody  = @asMailBody  + 'Si cette réparation n''est pas possible à domicile, le transporteur enlèvera l''appareil pour tenter de réparer en station.'
				  End
		    End 
		  Else
		    Begin 
			  -- [DT153-2]
		      Set @asMailBody  = @asMailBody  + 'Notre centre de diagnostic va prendre contact avec vous pour fixer un rendez-vous d''enlèvement.'
				-- [DT517]
				If @sIdFour = 'O2M'
					Begin 
						Set @asMailBody  = @asMailBody  + @sSaut
						Set @asMailBody  = @asMailBody  + 'Si cela est possible, un diagnostic vidéo pourra également vous être proposé.'
					End 
		    End 

		If @aiInfoSpbFrn in ( 1110, 956 ) -- ITSM191057 ajout ,956
		  Begin 
			Set @asMailBody  = @asMailBody  + 'Notre centre de diagnostic va prendre contact avec vous pour fixer un rendez-vous d''enlèvement.'

			-- [DT517]
			If @sIdFour = 'O2M'
				Begin 
					Set @asMailBody  = @asMailBody  + @sSaut
					Set @asMailBody  = @asMailBody  + 'Si cela est possible, un diagnostic vidéo pourra également vous être proposé.'
				End 
		  End 
		  
		-- [PC929-1]
		If @aiInfoSpbFrn = 1112
		  Begin 
			Set @asMailBody  = @asMailBody  + 'Notre centre de réparation va prendre contact avec vous pour fixer un rendez-vous à votre domicile pour tenter de réparer l''appareil sinistré.'
			Set @asMailBody  = @asMailBody  + @sSaut

			-- [DT517]
			If @sIdFour = 'O2M'
				Begin 
					Set @asMailBody  = @asMailBody  + 'Si cela est possible, un diagnostic vidéo pourra également vous être proposé.'
					Set @asMailBody  = @asMailBody  + @sSaut
				End 

			Set @asMailBody  = @asMailBody  + 'Si cette réparation n''est pas possible à domicile, SBE TV enlèvera l''appareil pour tenter de réparer en station.'
		  End 
		  
		  
-- :#9 [DCMP090327].[SBETV]
-- #10 [MSS_LOT2] supp 1238, 1256
-- [PC13321] 957
		If @aiInfoSpbFrn not in (  1112, 957 )
		 Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sSaut		
			Set @asMailBody  = @asMailBody  + 'Notre centre de diagnostic enverra donc un transporteur chez vous pour l''enlèvement de ' + @sVar1 + '.'
		 End
1237, 1255 )
		If @aiInfoSpbFrn in (  
		Begin
			Set @asMailBody  = @asMailBody  + @sSaut		
			Set @asMailBody  = @asMailBody  + 'Le rendez-vous avec le transporteur pour l''enlèvement aura lieu à la date suivante, sur le créneau horaire suivant : '  + @sRdv + '.'
		End 

		If @aiInfoSpbFrn in (  1237, 1255)
		Begin
			Set @asMailBody  = @asMailBody  + @sSaut		
			Set @asMailBody  = @asMailBody  + 'Le transporteur utilisera un emballage spécial pour transporter votre appareil.'
		End
/* #10 [MSS_LOT2] supp 1256
		If @aiInfoSpbFrn in (  1256 )
		Begin
			Set @asMailBody  = @asMailBody  + @sSaut		
			Set @asMailBody  = @asMailBody  + 'Comme vous nous l''avez précisé, vous possédez encore votre emballage d''origine ou un emballage similaire, le transporteur l''utilisera donc pour transporter votre appareil.'
		End
*/		

		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut

		If @aiInfoSpbFrn in (  957 )  -- [PMO139][RS4926]
		 Begin
			Set @asMailBody  = @asMailBody  + 'Merci de préparer les pièces/informations suivantes :'
         End
		Else
		 Begin
			Set @asMailBody  = @asMailBody  + 'Joignez à votre appareil :'
         End

		Set @asMailBody  = @asMailBody  + @sSaut

		If @sPce441 <> '' 
			Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sPce441
			End 

		If @sPce74 <> '' 
			Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sPce74
			End 

		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + '- Le n° de commande SPB : ' + Convert ( Varchar (10), @adcIdSin ) + '-' + Convert ( Varchar (3), @aiIdSeq ) -- [PI062]

	End


-- [PC938_ORANGE_V3] 		-- [PC202553_SELECTRA]
If @aiInfoSpbFrn in ( 973, 974, 975, 982, 983) 
	Begin
		If @aiInfoSpbFrn in ( 973 )
			Begin 
				Set @asMailBody  = ''
				Set @asMailBody  = @asMailBody  + @asCiv
				Set @asMailBody  = @asMailBody  + @sSaut
				Set @asMailBody  = @asMailBody  + @sSaut
				Set @asMailBody  = @asMailBody  + 'Votre appareil ' + @sVar3 + ' va être envoyé vers la boutique PSM suivante : '
				Set @asMailBody  = @asMailBody  + @sSaut
				Set @asMailBody  = @asMailBody  + @sSaut
				Set @asMailBody  = @asMailBody  + @sAdressPSM
				Set @asMailBody  = @asMailBody  + @sSaut
				Set @asMailBody  = @asMailBody  + @sSaut							
				Set @asMailBody  = @asMailBody  + 'Vous devrez attendre la réception d''un second mail qui vous indiquera que l''appareil est bien arrivé dans la boutique, vous pourrez alors vous y rendre pour récupérer votre appareil ' + @sVar3 + '.'
				Set @asMailBody  = @asMailBody  + @sSaut
				
			End 
			
		If @aiInfoSpbFrn in ( 974 )
			Begin 
				Set @asMailBody  = ''
				Set @asMailBody  = @asMailBody  + @asCiv
				Set @asMailBody  = @asMailBody  + @sSaut
				Set @asMailBody  = @asMailBody  + @sSaut
				Set @asMailBody  = @asMailBody  + 'Votre appareil ' + @sVar3 + ' va vous être envoyé sur votre lieu professionnel.'
				Set @asMailBody  = @asMailBody  + @sSaut
				Set @asMailBody  = @asMailBody  + @sSaut
			End 
		
		If @aiInfoSpbFrn in ( 975 )
			Begin 			
				Set @asMailBody  = ''
				Set @asMailBody  = @asMailBody  + @asCiv
				Set @asMailBody  = @asMailBody  + @sSaut
				Set @asMailBody  = @asMailBody  + @sSaut
				Set @asMailBody  = @asMailBody  + 'Votre appareil ' + @sVar3 + ' va vous être envoyé à domicile.'
				Set @asMailBody  = @asMailBody  + @sSaut
				Set @asMailBody  = @asMailBody  + @sSaut
			End 

		-- [PC202553_SELECTRA]
 		If @aiInfoSpbFrn in ( 982)
			Begin 			
/*					Set @asMailBody  = ''
				Set @asMailBody  = @asMailBody  + @asCiv
				Set @asMailBody  = @asMailBody  + @sSaut */
				Set @asMailBody  = @asMailBody  + @sSaut
				Set @asMailBody  = @asMailBody  + 'Notre prestataire vous enverra un mail avec un bon à télécharger pour le dépôt de votre appareil dans le relais pick up que vous avez choisi avec notre conseiller.'
				Set @asMailBody  = @asMailBody  + @sSaut
				Set @asMailBody  = @asMailBody  + @sSaut
			End 
		
		-- [DT153-1]				
		If @aiInfoSpbFrn in ( 983 )
			Begin 
				Set @asMailBody  = ''
				Set @asMailBody  = @asMailBody  + @asCiv
				Set @asMailBody  = @asMailBody  + @sSaut
				Set @asMailBody  = @asMailBody  + @sSaut
				Set @asMailBody  = @asMailBody  + 'Votre appareil ' + @sVar3 + ' va être envoyé vers le relais PickUp suivant : '
				Set @asMailBody  = @asMailBody  + @sSaut
				Set @asMailBody  = @asMailBody  + @sSaut
				Set @asMailBody  = @asMailBody  +
							IsNull ( 
									(
									Select Isnull ( rtrim ( adr_nom ), '' ) + @sSaut + Isnull ( rtrim ( adr_prenom), '' ) + @sSaut +
											Isnull ( rtrim ( adr_livr1), '' ) + @sSaut +
											Isnull ( rtrim ( adr_livr2), '' ) + @sSaut +
											Isnull ( rtrim ( adr_livr_cpl), '' ) + @sSaut +
											Isnull ( rtrim ( adr_cp ), '' ) + ' ' + Isnull ( rtrim ( adr_ville), '' ) + @sSaut 
									From   sysadm.w_commande c
									Where   c.id_sin = @adcIdSin
									And     c.id_seq = @aiIdSeq 
								), '')

				Set @asMailBody  = @asMailBody  + @sSaut
				Set @asMailBody  = @asMailBody  + @sSaut							
			End 
		 
		 
		 
		If @iRSTsuivicmde > 0 
			Begin
			Set @asMailBody  = @asMailBody  + @sSaut	
				
			Set @asMailBody  = @asMailBody  + 'Toutefois, nous accusons actuellement un léger retard dans l''approvisionnement de votre appareil dû à une rupture de stock.'
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sSaut	

			-- [DT153-2]
			If @aiInfoSpbFrn in ( 983 )
			Begin 
				Set @asMailBody  = @asMailBody  + 'Vous devrez attendre la réception d''un second mail qui vous indiquera que l''appareil est bien arrivé dans la boutique, vous pourrez alors vous y rendre pour récupérer votre appareil ' + @sVar3 + '.'
				Set @asMailBody  = @asMailBody  + @sSaut
				Set @asMailBody  = @asMailBody  + @sSaut
			End 

			Set @asMailBody  = @asMailBody  + 'Dans le cas où le remplacement ne pourrait aboutir, un règlement numéraire, sur la base de la valeur de votre appareil à la date du sinistre chez Orange, pourra exceptionnellement être effectué.'
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sSaut	

			Set @asMailBody  = @asMailBody  + 'Nous vous présentons toutes nos excuses pour le désagrément occasionné et mettons tout en oeuvre pour une livraison rapide.'
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sSaut	
			End
		
	End 
 
 If @aiInfoSpbFrn in ( 976, 977, 978, 979 )			
	Begin
		Set @asMailBody  = ''
		Set @asMailBody  = @asMailBody  + @asCiv
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + 'Une demande de réparation concernant votre ' + @asMarque + ' ' + @asModele + ' vient d''être transmise à notre centre de réparation.'	
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut

		If @aiInfoSpbFrn in ( 976 )
		Begin 			
			Set @asMailBody  = @asMailBody  + 'Un transporteur viendra sur votre lieu professionnel vous apporter un appareil de prêt et il récupérera votre appareil sinistré, pensez donc à l''avoir avec vous.'
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sSaut
		End 
		
		If @aiInfoSpbFrn in ( 977 )
		Begin 			
			Set @asMailBody  = @asMailBody  + 'Un transporteur viendra à votre domicile vous apporter un appareil de prêt et il récupérera votre appareil sinistré, pensez donc à l''avoir avec vous.'
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sSaut
		End 

		If @aiInfoSpbFrn in ( 978 )
		Begin 			
			Set @asMailBody  = @asMailBody  + 'Un transporteur viendra sur votre lieu professionnel récupérer votre appareil sinistré, pensez donc à l''avoir avec vous.'
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sSaut
		End 

		If @aiInfoSpbFrn in ( 979 )
		Begin 			
			Set @asMailBody  = @asMailBody  + 'Un transporteur viendra à votre domicile récupérer votre appareil sinistré, pensez donc à l''avoir avec vous.'
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sSaut
		End 
	End 


-- #9 [DCMP090327].[SBETV]
-- #9 [MSS_DIAG]
-- #10 [MSS_LOT2] supp 1261
If @aiInfoSpbFrn in ( 945, 950, 960, 906, 911, 1115, 1240, 1260 )

	Begin
		If @aiInfoSpbFrn in ( 1240)
		Begin
			Set @asMailBody  = @asMailBody  + 'Nous vous invitons à déposer votre appareil au SAV.'
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + 'Notre centre de diagnostic enverra vers le magasin ' + @sNomContractant + ' ' + sysadm.FN_TRIM ( @sBoutique ) + ', '+ @sTailleCarton + ' pour l''enlèvement de ' + @sVar1 + '.'
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sNomContractant + ' se charge d''envoyer le colis vers notre centre de diagnostic.'
		End 

		If @aiInfoSpbFrn in ( 945, 950, 960, 906, 911, 1115, 1260 )
		Begin
			Set @asMailBody  = @asMailBody  + 'Nous vous invitons à déposer votre appareil au SAV.'
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + 'Notre centre de diagnostic enverra un transporteur vers le magasin ' + @sNomContractant + ' ' + sysadm.FN_TRIM ( @sBoutique ) + ', pour le dépôt d''un '+ @sTailleCarton + ' et enlèvement de ' +@sVar1 + ' afin de l''expédier vers notre centre de diagnostic.'
		End 			

		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut

		Set @asMailBody  = @asMailBody  + 'Merci de joindre à votre appareil :'
		Set @asMailBody  = @asMailBody  + @sSaut

		If @sPce441 <> '' 
		  Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sPce441
		  End 

		If @sPce74 <> '' 
		  Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + @sPce74
		  End 

		-- #4 [DCMP090298]
		If @iFNACEpt > 0 And @sMarqApp = 'NIKON' And @sTypApp = 'APN'
		  Begin
			Set @asMailBody  = @asMailBody  + @sSaut
			Set @asMailBody  = @asMailBody  + '- La carte de garantie de l''appareil (sur laquelle apparaît le numéro de série ). Si vous ne la possédez plus, redemandez en une à votre magasin FNAC, sans cette carte, le diagnostic de votre appareil sera plus long.'
		  End
		-- :#4 [DCMP090298]

		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + '- Le n° de commande SPB : ' + Convert ( Varchar (10), @adcIdSin ) + '-' + Convert ( Varchar (3), @aiIdSeq ) -- [PI062]


	End


-- Partie commune à tous les process
-- [PC913]
-- [VDOC7667] [PC929_CDISCOUNT]

	-- [PC929_CDISCOUNT][MANTIS7212]
	If @aiInfoSpbFrn in ( 972 )
	 Begin

		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + 'Nous attirons votre attention sur les risques que court votre matériel lors de son transport vers nos ateliers : vibrations, chocs, manipulations rapides…Les éventuelles détériorations ou dommages subis pendant le transport pouvant vous empêcher de faire valoir votre garantie d’assurance, nous vous demandons de respecter notamment les consignes ci-dessous :'
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + '-    L''emballage dans lequel vous mettrez votre appareil doit être l''emballage d''ORIGINE de votre matériel.'
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + '-    Si vous vous êtes trompé lors de l''entretien avec le gestionnaire téléphonique, reprenez contact avec SPB, mais n''utilisez pas un emballage de votre choix.'			
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + '-    Ne laissez pas l’appareil que vous envoyez en contact direct avec le carton d’envoi. Calez-le pour éviter tout mouvement dans ce carton (papier journal, papier-bulles, chiffons…)'
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + '-    En cas de casse survenue lors du transport en raison d’une protection de l’appareil insuffisante de votre part, votre dossier de sinistre ne sera pas pris en charge et votre appareil vous sera restitué en l’état.'

			
	 End 

If @aiInfoSpbFrn in ( 907, 912, 937, 942, 967, 952 )
	Begin
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + 'Nous attirons votre attention sur les risques que court votre matériel lors de son transport vers nos ateliers : vibrations, chocs, manipulations rapides…Les éventuelles détériorations ou dommages subis pendant le transport pouvant vous empêcher de faire valoir votre garantie d’assurance, nous vous demandons de respecter notamment les consignes ci-dessous :'
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + '-    Autant que possible, laissez votre appareil dans son emballage d’origine ou mettez l’emballage d’origine dans l’emballage que vous utiliserez pour l’envoi, pour plus de sécurité.'
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + '-    Ne laissez pas l’appareil que vous envoyez en contact direct avec le carton d’envoi. Calez-le pour éviter tout mouvement dans ce carton (papier journal, papier-bulles, chiffons…)'
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + '-    En cas de casse survenue lors du transport en raison d’une protection de l’appareil insuffisante de votre part, votre dossier de sinistre ne sera pas pris en charge et votre appareil vous sera restitué en l’état.'
	End

If @aiInfoSpbFrn in ( 905, 910, 915, 920, 961, 962, 951 )
	Begin
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + 'Nous attirons votre attention sur les risques que court votre matériel lors de son transport vers nos ateliers : vibrations, chocs, manipulations rapides…Les éventuelles détériorations ou dommages subis pendant le transport pouvant vous empêcher de faire valoir votre garantie d''assurance, nous vous demandons de respecter notamment les consignes ci-dessous :'
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + '-    Autant que possible, envoyez votre appareil dans son emballage d’origine ou mettez l''emballage d’origine dans l’emballage Colissimo utilisé, pour plus de sécurité.'
		Set @asMailBody  = @asMailBody  + @sSaut			
		Set @asMailBody  = @asMailBody  + '-    Ne laissez pas l’appareil que vous envoyez en contact direct avec le carton d’envoi. Calez-le pour éviter tout mouvement dans ce carton (papier journal, papier-bulles, chiffons…)'
		Set @asMailBody  = @asMailBody  + @sSaut			
		Set @asMailBody  = @asMailBody  + 'En cas de casse survenue lors du transport en raison d''une protection de l’appareil insuffisante de votre part, votre dossier de sinistre ne sera pas pris en charge et votre appareil vous sera restitué en l’état.'
	End	

If @aiInfoSpbFrn in ( 935, 940, 936, 941, 953 )
	Begin
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + 'Nous attirons votre attention sur les risques que court votre matériel lors de son transport vers nos ateliers : vibrations, chocs, manipulations rapides…Les éventuelles détériorations ou dommages subis pendant le transport pouvant vous empêcher de faire valoir votre garantie d''assurance, nous vous demandons de respecter notamment les consignes ci-dessous :'    
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + '-   Autant que possible, laissez votre appareil dans son emballage d’origine avant de le mettre dans le carton d’envoi qui vous est fourni.'
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + '-   Ne laissez pas l’appareil que vous envoyez en contact direct avec le carton d’envoi. Calez-le pour éviter tout mouvement dans ce carton (papier journal, papier-bulles, chiffons…)'				    
		Set @asMailBody  = @asMailBody  + @sSaut			
		Set @asMailBody  = @asMailBody  + 'En cas de casse survenue lors du transport en raison d’une protection de l’appareil insuffisante de votre part, votre dossier de sinistre ne sera pas pris en charge et votre appareil vous sera restitué en l’état.'
	End
-- /[VDOC7667]

-- [DT188]
If @sIdRefFour in ( 'A_REPARER', 'A_DIAGNOTIQUER' ) 
	Begin
		Set @asMailBody  = @asMailBody  + @sSaut
		Set @asMailBody  = @asMailBody  + @sSaut
	
		-- [DT517]
		Set @asMailBody  = @asMailBody  + 'Si votre matériel est concerné et afin de protéger vos données personnelles, vous devez impérativement sauvegarder, puis effacer le contenu (photos, contacts, mails…) de votre appareil avant l''envoi à notre centre technique. Nous ne pourrons en aucun cas être tenus responsables de tout dommage qui résulterait de la perte ou du vol de vos données personnelles et/ou de leur utilisation par des tiers à quelque fin que ce soit.'
	End 

Set @asMailBody  = @asMailBody  + @sSaut
Set @asMailBody  = @asMailBody  + @sSaut

-- [PM261-1]
-- [DT153-1]
If @iDp260 > 0 And @sIdFour in ( 'O2M','PSM' ) And @aiInfoSpbFrn Not in ( 973, 974, 975, 983 )
    Begin
		Set @asMailBody  = @asMailBody  + 'Nous vous rappelons que l''appareil devient la propriété de l''assurance si celui-ci est irréparable. '
		Set @asMailBody  = @asMailBody  + @sSaut + @sSaut
    End 

If @iDp279_DT145 > 0 And 
   @sIdFour in ('O2M','PSM') And 
   @dcIdGti in ( 11, 24 )
	Begin
		Set @asMailBody  = @asMailBody  + 'Le n° IMEI attendu pour votre appareil sinistré est le : ' + @sNumImeiAnc + '. Si à réception et lors du contrôle de votre appareil par notre centre technique le n° IMEI s''avère différent, votre demande de prise en charge ne pourra pas recevoir une suite positive. Nous vous remercions de bien vouloir le vérifier avant votre envoi.' 
		Set @asMailBody  = @asMailBody  + @sSaut + @sSaut
	End 


Set @asMailBody  = @asMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @asCiv + ' nos salutations distinguées.'

Go


grant execute on sysadm.PS_S08_MAILPUSH_CORPS_MAIL_FNAC_900 to rolebddsinistres
Go

-------------------------------------------------------------------
-- Proc‚dure            :       PS_LIRE_UTILISATEUR_SITE
-- Auteur               :       FPI
-- Date                 :       23/06/2009
-- Libell‚              :        
-- Commentaires         :       Appel de la procédure PS_S02_UTILISATEUR_SITE sur Sherpa
--                               
-- R‚f‚rences           :       Validation des sinistres SAVANE
--
-- Arguments            :       @sIdSin         Integer  ( Val )
--
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_LIRE_UTILISATEUR_SITE' AND type = 'P' )
        DROP procedure sysadm.PS_LIRE_UTILISATEUR_SITE
GO

CREATE procedure sysadm.PS_LIRE_UTILISATEUR_SITE
   @dcIdSin	Decimal(7) ,				-- Identifiant sinistre
   @sCanal	 varchar(2) output,		-- canal choisi
   @sEMail	 varchar(60) output,		-- adresse e-mail   
   @sIdentifiant varchar(60) output  -- identifiant
AS
	
	declare @iRet   integer
	Declare @iIdSin integer

	set @iRet=0
	Set @iIdSin = convert(integer,@dcIdSin)

	If @@servername = master.dbo.SPB_FN_ServerName ('PRO') 
	Begin
		Exec @iRet =SHERPA_PRO.sysadm.PS_S02_UTILISATEUR_SITE_V01 @iIdSin, 1, @sCanal OUTPUT, @sEMail OUTPUT, @sIdentifiant OUTPUT
	End 
	else
	Begin
		Exec @iRet =SHERPA_SIM.sysadm.PS_S02_UTILISATEUR_SITE_V01 @iIdSin, 1, @sCanal OUTPUT, @sEMail OUTPUT, @sIdentifiant OUTPUT
	End
	
	Return @iRet
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S09_MAILPUSH_NOTIF_COURRIER
-- Auteur               :       F. Pinon
-- Date                 :       29/06/2009
-- Libelle              :	[Atlas].Courrier
-- Commentaires         :       Envoi de Mail relatif à la mise à dispo d'un courrier
--
-- References           :
--
-- Arguments            :       @asIdAppli	varchar (20)		(val) Nom de l'application mère éxécutant la PS
--								@asBase		varchar (20)		(val) Nom de la base de données SHERPA ou SIMPA2
--								@adcIdSin       Decimal (  7,0 )        (Val)
--								@asCasRetour    VarChar (50)		(ref) Cas : MAIL_ENVOYE
--										    OPTION_DP_NON_PARAM
--										    HORS_BASE_DE_PRODUCTION
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-------------------------------------------------------------------
--      JFF   23/05/2012 [PM103][1]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S09_MAILPUSH_NOTIF_COURRIER' AND type = 'P' )
        DROP procedure sysadm.PS_S09_MAILPUSH_NOTIF_COURRIER
GO


CREATE procedure sysadm.PS_S09_MAILPUSH_NOTIF_COURRIER
	@asIdAppli	varchar (20),
	@asBase		varchar (20),
	@adcIdSin      	Decimal (10), -- [PI062]
	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @sSaut	VarChar (10), 
  @iRet		Integer,
  @iCpt		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @iOptionDP    Integer,
  @sBoiteMail   VarChar (35),
  @sURL		VarChar (255),
  @sLibSite	VarChar (255),
  @sURLAtlas	Varchar(255),
  @sAltSuiviSMS VarChar ( 1 ),  
  @sNumGsmSMS   VarChar ( 20 ) 
  
  Declare @sIdCanal	Varchar(2) 	
  Declare @sEMail	 	varchar(60)	
  Declare @sIdentifiant 	varchar(60)	
  Declare @iDelaiAtlas    Integer	
  Declare @sCasRetour    VarChar (50)
  Declare @dteEditVide	datetime

  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  Set @asIdAppli = Upper ( @asIdAppli )

  Set @dteEditVide=convert(datetime,'01/01/1900')

  -- [PM103][1]	
  	If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
	 Begin
	 	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
 		Return 0
	 End

  -- :[PM103][1]

  -- Option de déclenchement du mail -DP
  Set @iOptionDP = 117

  -- Contrôle de présence d'un nouveau courrier pour l'assuré
  Select @iCpt = count(*)
  From sysadm.archive a, 
		sysadm.inter i
  Where a.id_sin=@adcIdSin and 
	a.dte_edit= @dteEditVide and 
	a.dte_atlas_notif is null and 
	i.id_sin = a.id_sin and 
	a.id_inter = i.id_i and
	i.cod_inter = 'A'


  If @iCpt = 0 Return 0
  
  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@asBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT, 
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #2
	@sAltSuiviSMS OUTPUT, -- #1 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #1 [FNAC_PROD_ECH_TECH].[SMS]
	
	
  -- Cas de retour n'étant pas des erreurs
  If @iRet in ( -9, -10 )
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

   -- L'absence d'adresse email n'est pas une erreur car reprise depuis Sherpa
   If @iRet in (-7,-11) Set @iRet = 0

   -- Problème suite éxécution
  If @iRet <> 0 Return @iRet

	/* ... Récupération du canal et de l'adresse mail ...*/
  Exec @iRet = sysadm.PS_LIRE_UTILISATEUR_SITE @adcIdSin, @sIdCanal OUTPUT, @sEMail OUTPUT, @sIdentifiant OUTPUT

  -- Mise à jour le canal pour l'assuré 
  If @sEMail is null or sysadm.FN_TRIM(@sEMail) = '' 
  begin
	Set @asCasRetour = 'ADRESSE_MAIL_ABSENTE'
	
	update sysadm.archive 
	set id_canal = @sIdCanal
	from sysadm.inter
	Where archive.id_sin=@adcIdSin and 
		archive.dte_edit= @dteEditVide and 
		archive.dte_atlas_notif is null and 
		inter.id_sin = archive.id_sin and 
		archive.id_inter = inter.id_i and
		inter.cod_inter = 'A'

	Return 0
  End 
  
 Select @sURL = sysadm.FN_TRIM ( sysadm.FN_CLE_VAL ( 'URL_ATLAS', IsNull ( dp.val_car, '' ), ';' ) ),
  	 @sLibSite = Upper ( sysadm.FN_TRIM ( sysadm.FN_CLE_VAL ( 'LIB', IsNull ( dp.val_car, '' ), ';' ) ))
  From   sysadm.det_pro dp
  Where  dp.id_prod = @dcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = 117
  
 --------------------------------------------------------------------------------------------------------------------
  -- Armement de l'objet du mail
  Set @sMailObjet = 'SPB - Assurance ' + @sLibProd  

--------------------------------------------------------------------------------------------------------------------
-- Corps du mail

 Set @sMailBody  = @sMailBody  + 'Madame, Monsieur,'
 Set @sMailBody  = @sMailBody  + @sSaut
 Set @sMailBody  = @sMailBody  + 'De nouvelles informations relatives à votre demande d''indemnisation sont disponibles sur le site '
 Set @sMailBody  = @sMailBody  + @sMailObjet
 Set @sMailBody  = @sMailBody  + @sSaut
 Set @sMailBody  = @sMailBody  + 'Pour consulter ces informations sur l''espace qui vous est réservé, vous pouvez y accéder en allant sur le site http://' + @sURLAtlas + '.'
 Set @sMailBody  = @sMailBody  + @sSaut
 Set @sMailBody  = @sMailBody  + 'Utilisez l''identifiant suivant : ' + @sIdentifiant 
 Set @sMailBody  = @sMailBody  + ' ainsi que votre mot de passe.'
 Set @sMailBody  = @sMailBody  + @sSaut
 Set @sMailBody  = @sMailBody  + 'Cordialement.'
 Set @sMailBody  = @sMailBody  + @sSaut
 Set @sMailBody  = @sMailBody  + 'Le Service Clientèle de SPB'

  
  --------------------------------------------------------------------------------------------------------------------
-- Pied du mail
  
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Ce message vous est délivré automatiquement. Merci de ne pas y répondre.'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'


  -- On convertit pour l'appel de la PS
  Set @iIdSin  = Convert ( integer, @adcIdSin )
  Set @iIdProd = Convert ( integer, @dcIdProd )
  Set @iIdEts  = Convert ( integer, @dcIdEts )

  If @@servername = master.dbo.SPB_FN_ServerName ('PRO')

   Begin  -- TRACE_MAIL_PRO : Début écriture

	  Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
		@asIdAppli,
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	        @sMailFrom, 
		@sEMail, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail, 
		'M6',
		2 

   End    -- TRACE_MAIL_PRO : Fin écriture

  Else

   Begin  -- TRACE_MAIL_TRT : Début écriture
	  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
		@asIdAppli,
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	        @sMailFrom, 
		@sEMail, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail, 
		'M6', 
		2 

   End    -- TRACE_MAIL_TRT : Fin écriture

	Select @iDelaiAtlas=Convert(integer,cpt_val)
	From sysadm.parametre
	where ref_cpt='ATLAS_DL1'

	-- Maj canal + dates Atlas
	update sysadm.archive 
	set id_canal = @sIdCanal,
		dte_atlas_notif = GetDate(), 
		dte_atlas_rappel = DateAdd(day, @iDelaiAtlas, getdate())
	from sysadm.inter
	Where archive.id_sin=@adcIdSin and 
		archive.dte_edit= @dteEditVide and 
		archive.dte_atlas_notif is null and 
		inter.id_sin = archive.id_sin and 
		archive.id_inter = inter.id_i and
		inter.cod_inter = 'A'

	Select @iRet = @@Error
	If @iRet <> 0 Return -20  
	
	--maj mail de l'inter 
	-- On suppose qu'il n'y a toujours qu'un interlocuteur assuré par sinistre
	Update sysadm.inter
	Set adr_mail = @sEMail
	Where 	id_sin = @adcIdSin And
		cod_inter = 'A'
	
	Select @iRet = @@Error
	If @iRet <> 0 Return -20  


  -- Problème suite éxécution
  If @iRet <> 0 Return -20

  -- Fin de traitement
  Set @asCasRetour = 'MAIL_ENVOYE'
  Return 0

Go

-------------------------------------------------------------------
-- Proc‚dure            :       PS_S01_MAILPUSH_RECP_PIEC
-- Auteur               :       ???
-- Date                 :       ???
-- Libell‚              :        
-- Commentaires         :       
--                               
-- R‚f‚rences           :       
--
-- Arguments            :       
--
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S01_MAILPUSH_RECP_PIEC' AND type = 'P' )
        DROP procedure sysadm.PS_S01_MAILPUSH_RECP_PIEC
GO

CREATE procedure sysadm.PS_S01_MAILPUSH_RECP_PIEC
	@asIdAppli	varchar (20),
	@asBase		varchar (20),
	@adcIdSin      	Decimal (10), -- [PI062]
	@adtDteRcpPiec  DateTime,
	@asCasRetour    VarChar (50) OUTPUT
AS

Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (10), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @sSaut	VarChar (10), 
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer

  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @sAltQuarant = 'N'
  Set @sSaut = '[#]'
  Set @iRet = 0
  Set @asIdAppli = Upper ( @asIdAppli )

  If @adtDteRcpPiec is null
   Begin
	Set @asCasRetour = 'PARAM_NON_RENSEIGNES'
	Return 0
   End

  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@asBase,
 	48,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
        @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT, 
	@sMailCc    OUTPUT 

  -- Cas de retour n'étant pas des erreurs
  If @iRet in ( -7, -9, -10 )
   Begin
	Select @asCasRetour =
	Case @iRet
		When -7 Then 'ADRESSE_MAIL_ABSENTE'
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'HORS_BASE_DE_PRODUCTION'
	End 
	Return 0
   End

  -- Problème suite éxécution
  If @iRet <> 0 Return @iRet

  -- Armement de l'objet du mail
  Set @sMailObjet = 'Votre dossier ' + @sLibProd + ' ' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) -- [PI062]

  -- Armement du corps du mail
  Set @sMailBody  = @sMailBody  + @sCiv + ' ' + @sNom + ','
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Nous accusons réception de vos pièces en date du ' + Convert ( VarChar, @adtDteRcpPiec, 103 ) + '.'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Votre demande est en cours d''analyse. Vous serez informé(e) ultérieurement du suivi de votre dossier.'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' ' + @sNom + ', nos salutations distinguées.'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Avertissement: Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse '
  Set @sMailBody  = @sMailBody  + 'd''origine pour nous contacter, votre message ne pouvant être traité en retour.'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Pour joindre la SPB, composez le ' + @sNumProd + '.' 

  -- On convertit pour l'appel de la PS
  Set @iIdSin  = Convert ( integer, @adcIdSin )
  Set @iIdProd = Convert ( integer, @dcIdProd )
  Set @iIdEts  = Convert ( integer, @dcIdEts )

  Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
	@asIdAppli,
	@iIdSin, 
	@iIdProd, 
	@sLibProd, 
	@iIdEts, 
        @sMailFrom, 
	@sMailSend, 
	@sMailCc,
	@sMailObjet,
	@sMailBody,
	@sAltQuarant

  -- Problème suite éxécution
  If @iRet <= 0 Return -20

  -- Fin de traitement
  Set @asCasRetour = 'MAIL_ENVOYE'
  Return 0

GO

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S10_MAILPUSH_ENVOI_CRT
-- Auteur               :       F. Pinon
-- Date                 :       20/08/2010
-- Libelle              :	[PC482]
-- Commentaires         :       Envoi de Mail relatif à l'envoi d'un carton prépayé à l'assuré
--
-- References           :
--
-- Arguments            :       @asIdAppli	varchar (20)		(val) Nom de l'application mère éxécutant la PS
--				@asBase		varchar (20)		(val) Nom de la base de données SHERPA ou SIMPA2
--				@adcIdSin       Decimal (  7,0 )        (Val)
--				@aiIdSeq 	int			(Val) Identifiant de commande
--				@asCasRetour    VarChar (50)		(ref) Cas : MAIL_ENVOYE
--										    OPTION_DP_NON_PARAM
--										    HORS_BASE_DE_PRODUCTION
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
--      JFF   23/05/2012 [PM103][1]
--	   FPI 13/09/2012 [VDOC8537] Allongement de la colonne id_bon_transp de 20 à 35
--	   FPI 07/02/2013 [VDOC10293] Pour certains process nous n'envoyons pas de mail
--	   JFF      12/02/2016   [PI062]
--	   JFF      20/03/2017   [DDE_HELENE_20170320] modif url chronopost
--   JFF      17/04/2018   [DT288-4] Modif URL Chronopost
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S10_MAILPUSH_ENVOI_CRT' AND type = 'P' )
        DROP procedure sysadm.PS_S10_MAILPUSH_ENVOI_CRT
GO


CREATE procedure sysadm.PS_S10_MAILPUSH_ENVOI_CRT
	@asIdAppli	varchar (20),
	@asBase		varchar (20),
	@adcIdSin      	Decimal (10), -- [PI062]
	@aiIdSeq 	int,
	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @sSaut	VarChar (10), 
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @iOptionDP    Integer,
  @sBoiteMail   VarChar (35),
  @sMarque	VarChar (35),
  @sLibApp	VarChar (255),
  @sIdBonTrsp	Varchar (35), -- [VDOC8537]
  @sAltSuiviSMS VarChar ( 1 ),  
  @sNumGsmSMS   VarChar ( 20 ),
  @sLogin 	VarChar ( 10 ),  
  @sMdPasse 	VarChar ( 10 ), 
  @sCodeTrt 	VarChar ( 10 ), 
  @sSmsBody	VarChar(255),
  @iInfoSpbFrn Integer -- [VDOC10293]
  
  Declare @sIdCanal	Varchar(2) 	
  Declare @sEMail	 	varchar(60)	
  Declare @sIdentifiant 	varchar(60)	
  Declare @iDelaiAtlas    Integer	
  Declare @sCasRetour    VarChar (50)
  Declare @dteEditVide	datetime

  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  Set @asIdAppli = Upper ( @asIdAppli )

  Set @dteEditVide=convert(datetime,'01/01/1900')

  -- [PM103][1]	
  If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
   Begin
	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
	Return 0
   End
  -- :[PM103][1]

  -- Option de déclenchement du mail -DP
  Set @iOptionDP = 144

  -- Contrôle de présence de la commande
  Set @sIdBonTrsp=NULL
  
  Select @sIdBonTrsp = id_bon_transp,
	@iInfoSpbFrn=info_spb_frn -- [VDOC10293]
  From sysadm.commande
  Where id_sin=@adcIdSin and 
	id_seq=@aiIdSeq


  If @@RowCount = 0 or @sIdBonTrsp is null Return 0
  
  if @iInfoSpbFrn in (906, 911, 945, 950, 960, 1240, 1260) Return 0 -- VDOC10293
  
  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@asBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
        @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT, 
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, 
	@sAltSuiviSMS OUTPUT,
	@sNumGsmSMS  OUTPUT 
	
	
  -- Cas de retour n'étant pas des erreurs
  If @iRet in ( -9, -10 )
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

   -- L'absence d'adresse email n'est pas une erreur car envoi sms
   If @iRet in (-7,-11) Set @iRet = 0

   -- Absence de mail & tel gsm
   If @sMailSend Is Null Set @sMailSend=''
   Else Set @sMailSend = sysadm.FN_TRIM ( @sMailSend )
   
   If @sNumGsmSMS Is Null Set @sNumGsmSMS=''
   Else Set @sNumGsmSMS = sysadm.FN_TRIM ( @sNumGsmSMS)
   
   If @sMailSend='' and @sNumGsmSMS=''  return 0
   
   -- Problème suite éxécution
  If @iRet <> 0 Return @iRet

  Select   @sMarque = IsNull ( sysadm.FN_TRIM ( s.marq_port ), '') 
  From     sysadm.sinistre s
  Where   s.id_sin = @adcIdSin
  
  Set @sLibApp='appareil'
  
  Select @sLibApp=dp.val_car
  From sysadm.sinistre s
  Inner join sysadm.div_sin d on s.id_sin=d.id_sin
  Inner Join sysadm.det_pro dp on dp.id_prod=s.id_prod
  Where   d.id_sin = @adcIdSin And d.nom_zone='type_app'
  and dp.id_code_dp=106 and dp.id_code_car=d.val_car
  
  If @sMailSend <> ''
  Begin
	 --------------------------------------------------------------------------------------------------------------------
	 -- Armement de l'objet du mail
	 Set @sMailObjet = 'SUIVI DE VOTRE EMBALLAGE GARANTIE '  + @sLibProd

	 --------------------------------------------------------------------------------------------------------------------
	 -- Corps du mail

	 Set @sMailBody  = @sCiv + ' ' + @sNom + ','
	 Set @sMailBody  = @sMailBody  + @sSaut + @sSaut
	 Set @sMailBody  = @sMailBody  + 'Vous nous avez contactés afin de déclarer la panne de votre ' + sysadm.FN_TRIM(@sLibApp)  + ' de marque ' + sysadm.FN_TRIM(@sMarque) +'.'
	 Set @sMailBody  = @sMailBody  + @sSaut + @sSaut
	 Set @sMailBody  = @sMailBody  + 'Afin d’effectuer l’expertise de votre appareil, vous allez recevoir dans les prochains jours un emballage Chrono 13 accompagné d’un bon prépayé.'
	 Set @sMailBody  = @sMailBody  + @sSaut + @sSaut
	 Set @sMailBody  = @sMailBody  + 'Vous trouverez à l’intérieur de ce colis les instructions pour l’emballage de votre appareil'
	 Set @sMailBody  = @sMailBody  + @sSaut + @sSaut

--	 [DDE_HELENE_20170320] modif url chronopost
-- [DT288-4]
--	 Set @sMailBody  = @sMailBody  + 'Le suivi de votre Chrono 13 n° ' + sysadm.FN_TRIM(@sIdBonTrsp) + ' est visualisable sur le site www.chronopost.fr/transport-express/livraison-colis/suivi.'
	 Set @sMailBody  = @sMailBody  + 'Suivez votre Chrono 13 sur ce lien https://www.chronopost.fr/fr/chrono_suivi_search?listeNumerosLT=' + sysadm.FN_TRIM(@sIdBonTrsp)
	 Set @sMailBody  = @sMailBody  + @sSaut + @sSaut
	 Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tous renseignements complémentaires, et vous prions d’agréer nos salutations distinguées.'
	 Set @sMailBody  = @sMailBody  + @sSaut + @sSaut
	 Set @sMailBody  = @sMailBody  + 'SPB'
	 Set @sMailBody  = @sMailBody  + @sSaut + @sSaut
	 Set @sMailBody  = @sMailBody  + 'Finaref Assurance / GARANTIE ' + @sLibProd

	  
	  --------------------------------------------------------------------------------------------------------------------
	 -- Pied du mail
	  
	 Set @sMailBody  = @sMailBody  + @sSaut
	 Set @sMailBody  = @sMailBody  + @sSaut
	 Set @sMailBody  = @sMailBody  + @sSaut
	 Set @sMailBody  = @sMailBody  + '****************************************************************'
	 Set @sMailBody  = @sMailBody  + @sSaut
	 Set @sMailBody  = @sMailBody  + 'Ce message vous est délivré automatiquement. Merci de ne pas y répondre.'
	 Set @sMailBody  = @sMailBody  + @sSaut
	 Set @sMailBody  = @sMailBody  + '****************************************************************'


	 -- On convertit pour l'appel de la PS
	 Set @iIdSin  = Convert ( integer, @adcIdSin )
	 Set @iIdProd = Convert ( integer, @dcIdProd )
	 Set @iIdEts  = Convert ( integer, @dcIdEts )

	 If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	   Begin  -- TRACE_MAIL_PRO : Début écriture
		  Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
			@asIdAppli,
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			@sAltQuarant,
			@sBoiteMail, 
			'M12',
			2 

	   End    -- TRACE_MAIL_PRO : Fin écriture

	  Else

	   Begin  -- TRACE_MAIL_TRT : Début écriture
		  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			@asIdAppli,
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			@sAltQuarant,
			@sBoiteMail, 
			'M12', 
			2 

	   End    -- TRACE_MAIL_TRT : Fin écriture
	End
	Else 
	If @sAltSuiviSMS='O'
	Begin
		-- SMS
--	    [DDE_HELENE_20170320] modif url chronopost
--		Set @sSmsBody='Fnac EPT - Chrono 13 n° ' + sysadm.FN_TRIM(@sIdBonTrsp) + ' pour suivi acheminement emballage sur www.chronopost.fr/transport-express/livraison-colis/suivi'
-- [DT288-4]
		Set @sSmsBody='Fnac EPT - Chrono 13 : Suivez votre Chrono 13 sur ce lien https://www.chronopost.fr/fr/chrono_suivi_search?listeNumerosLT=' + sysadm.FN_TRIM(@sIdBonTrsp)		

		-- On convertit pour l'appel de la PS
		Set @iIdSin  = Convert ( integer, @adcIdSin )
		Set @iIdProd = Convert ( integer, @dcIdProd )
		Set @iIdEts  = Convert ( integer, @dcIdEts )
		
		-- Param lié à la variante
		Set @sLogin   = 'spbCD'
		Set @sMdPasse = 'i3m2i2d2'
		Set @sCodeTrt = 'NETSIZE'
	 
		If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
		Begin  -- TRACE_MAIL_PRO : Début écriture
			Exec TRACE_MAIL_PRO.sysadm.PS_I01_SMS_PUSH_V00 
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sNumGsmSMS,
			@sLogin,
			@sMdPasse,
			@sSmsBody,
			@sCodeTrt,
			'M12', 
			2
		End
		Else
		Begin
		Exec TRACE_MAIL_TRT.sysadm.PS_I01_SMS_PUSH_V00 
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sNumGsmSMS,
			@sLogin,
			@sMdPasse,
			@sSmsBody,
			@sCodeTrt,
			'M12', 
			2		
		End
	End

  -- Problème suite éxécution
  If @iRet <> 0 Return -20

  -- Fin de traitement
  Set @asCasRetour = 'MAIL_ENVOYE'
  Return 0
Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S10_MAILPUSH_DECLARATION
-- Auteur               :       Fabry JF
-- Date                 :       12/06/2010
-- Libelle              :
-- Commentaires         :       ENvoi d'un lors de la déclaration.
--
-- References           :       [PC106_ECONOCOM]
--
-- Arguments            :       @asIdAppli	varchar (20)		(val) Nom de l'application mère éxécutant la PS
--				@asBase		varchar (20)		(val) Nom de la base de données SHERPA ou SIMPA2
--				@adcIdSin       Decimal (  7,0 )        (Val)
--				@aiIdSeq	Integer		        (Val)
--				@asCasRetour    VarChar (50)		(ref) Cas : MAIL_ENVOYE
--										    OPTION_DP_NON_PARAM
--										    HORS_BASE_DE_PRODUCTION
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
--      JFF   23/05/2012 [PM103][1]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S10_MAILPUSH_DECLARATION' AND type = 'P' )
        DROP procedure sysadm.PS_S10_MAILPUSH_DECLARATION
GO


CREATE procedure sysadm.PS_S10_MAILPUSH_DECLARATION
	@asIdAppli	varchar (20),
	@asBase		varchar (20),
	@adcIdSin      	Decimal (10),  -- [PI062]
	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @dcIdDetail   Decimal (7), -- #4 [SURCOUF_ECH_EXPRESS]
  @dcIdGti      Decimal (7), -- #4 [SURCOUF_ECH_EXPRESS]
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @asHREFURL	VarChar (300),		
  @sSaut	VarChar (10), 
  @sMarque	VarChar (35),
  @sModele	VarChar (35),  
  @sIdFour	VarChar (10),
  @sCodeEtat	VarChar (10),
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @iIdSeq 	Integer,
  @iOptionDP    Integer,
  @dtDteEnvCliActuel DateTime,
  @sBoiteMail   VarChar (35),
  @sNomLigne1	VarChar ( 35 ), -- [ADRESSE_O2M]
  @sNomLigne2	VarChar ( 35 ), -- [ADRESSE_O2M]
  @sAdrLigne1	VarChar ( 35 ),	-- [ADRESSE_O2M]
  @sAdrLigne2	VarChar ( 35 ),	-- [ADRESSE_O2M]	
  @sCP		VarChar ( 35 ), -- [ADRESSE_O2M]
  @sVille	VarChar ( 35 ),  -- [ADRESSE_O2M]
  @sAdressO2M	VarChar ( 200 )  -- [ADRESSE_O2M]

Declare
  @iVarianteMail Integer, -- #4 [SURCOUF_ECH_EXPRESS]
  @sValCarDetPro VarChar ( 100 ), -- #4 [SURCOUF_ECH_EXPRESS]
  @sMagasin 	VarChar ( 50 ),  -- #4 [SURCOUF_ECH_EXPRESS]
  @sIdSin	VarChar ( 10 ),   -- #4 [SURCOUF_ECH_EXPRESS] -- [PI062]
  @sNumPanier   VarChar ( 35 ),  -- #4 [SURCOUF_ECH_EXPRESS] 
  @sSKU		VarChar ( 35 ),  -- #4 [SURCOUF_ECH_EXPRESS] 
  @sNumSerie    VarChar ( 35 ),  -- #4 [SURCOUF_ECH_EXPRESS] 
  @sValAchat    VarChar ( 35 ),  -- #4 [SURCOUF_ECH_EXPRESS] 
  @sDteAchat    VarChar ( 10 ),  -- #4 [SURCOUF_ECH_EXPRESS] 
  @sNumFaxProd  VarChar ( 20 ),  -- #4 [SURCOUF_ECH_EXPRESS] 
  @sHoraireOuv  VarChar ( 50 ),  -- #4 [SURCOUF_ECH_EXPRESS]  
  @sCoutTel     VarChar ( 35 ), -- #4 [SURCOUF_ECH_EXPRESS]  
  @iInfoSpbFrn  Integer, -- #5 [DCMP080202]
  @sIdRefFour   VarChar ( 35 ), -- #5 [DCMP080202]
  @sAltSuiviSMS VarChar ( 1 ),  -- #7 [FNAC_PROD_ECH_TECH].[SMS]  
  @sNumGsmSMS   VarChar ( 20 ),  -- #7 [FNAC_PROD_ECH_TECH].[SMS]  
  @sTypApp 	VarChar ( 3 ), -- #12 [DCMP090678]
  @sVarianteDiagDP129 VarChar ( 30 ), -- #12 [DCMP090678]
  @iCasECONOCOM integer, 
  @sPrenom Varchar ( 35 ),
  @sDteDecl Varchar ( 10 ),
  @NomPrenomAssure Varchar ( 80 ),
  @sMarqApp Varchar ( 35 ),
  @sModlApp Varchar ( 35 )  

  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @asHREFURL = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  Set @asIdAppli = Upper ( @asIdAppli )
  Set @sTypApp = '' -- #12 [DCMP090678]
  Set @sVarianteDiagDP129 = '' -- #12 [DCMP090678]
  Set @iCasECONOCOM = 0
  
  -- Option de déclenchement du mail -DP
  Set @iOptionDP = 146

  -- [PM103][1]	
	If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
	  Begin
 		Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
		Return 0
	  End
  -- :[PM103][1]

    -- Récupération des données standard nécessaires à l'envoi du mail
  
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@asBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
        @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT, 
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #2
	@sAltSuiviSMS OUTPUT, -- #7 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #7 [FNAC_PROD_ECH_TECH].[SMS]
	

  -- Cas de retour n'étant pas des erreurs
  If @iRet in ( -7, -9, -10 )
   Begin
	Select @asCasRetour =
	Case @iRet
		When -7 Then 'ADRESSE_MAIL_ABSENTE'
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End
	
  -- Problème suite éxécution
  If @iRet <> 0 Return @iRet

  -- On mémorise la zone val_car de det_pro -- #4 [SURCOUF_ECH_EXPRESS]
  Select @sValCarDetPro = IsNull ( dp.val_car, '' )
  From   sysadm.det_pro dp
  Where  dp.id_prod = @dcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = @iOptionDP 


  -- Quel cas de gestion ? => ECONOCOM CG60.
  Select @iCasECONOCOM = Case 
		  		When count (*) > 0 Then 1
  				Else 0
		  	 End 
  From   sysadm.det_pro dp
  Where  dp.id_prod = @dcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = 145

  -- Mail déjà envoyé ?
  If @iCasECONOCOM > 0  
   Begin
   	If Exists ( Select *
   		    From sysadm.w_div_sin wd
   		    Where wd.id_sin = @adcIdSin
   		    And nom_zone = 'mail_decl'
   		    And val_car = 'O' )
   	Begin
		Set @asCasRetour = 'MAIL_DEJA_ENVOYE'
		Return 0
   	
   	End 
   		
   End

  -- Prenom de l'assuré
  Select @sNom    = sysadm.FN_TRIM ( IsNull ( s.nom, '')), 
  	 @sPrenom = Case
			When s.cod_civ in ( 4, 5 ) Then '' 
			Else sysadm.SPB_FN_INIT_CAP
			     (
			     sysadm.FN_TRIM ( IsNull ( Upper ( Left  ( sysadm.FN_TRIM ( s.prenom ), 1) ), '' )) +
			     sysadm.FN_TRIM ( IsNull ( Lower ( Right ( sysadm.FN_TRIM ( s.prenom ), Len ( s.prenom ) - 1 ) ), '' )),
			     null
			     )
		     End,
	 @sDteDecl = IsNull ( Convert ( VarChar ( 10 ) , cree_le  , 103 )  , '' ),
	 @sMarqApp  = IsNull ( s.marq_port, '' ),
	 @sModlApp  = IsNull ( s.modl_port, '' ),
	 @sNumSerie = IsNull ( s.num_imei_port, '' )
  From   sysadm.w_sin s
  Where  s.id_sin = @adcIdSin
  
  Set @NomPrenomAssure = @sCiv + ' ' + @sNom + ' ' + @sPrenom

--------------------------------------------------------------------------------------------------------------------
-- Construction du mail.
--------------------------------------------------------------------------------------------------------------------
  
  -- Mail Send
  If @iCasECONOCOM > 0  
   Begin
	Set @sMailSend = sysadm.FN_CLE_VAL ( 'ADR_MAIL', @sValCarDetPro, ';' )
   End     	  
  
--------------------------------------------------------------------------------------------------------------------
  -- Armement de l'objet du mail
  If @iCasECONOCOM > 0  
  Begin
	Set @sMailObjet = 'Déclaration de sinistre,'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
  End 

--------------------------------------------------------------------------------------------------------------------
  -- corps du mail
  If @iCasECONOCOM > 0  
  Begin
	Set @sMailBody  = @sMailBody  + 'Madame, Monsieur,'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut

	Set @sMailBody  = @sMailBody  + 'Nous vous informons que ' + @NomPrenomAssure + ', nous a déclaré un sinistre en date du ' + @sDteDecl + ' sur son appareil ' + @sMarqApp + ' ' + @sModlApp + ' dont le numéro de série est ' + @sNumSerie + '.'

	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut	  
	Set @sMailBody  = @sMailBody  + 'Cordialement,'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Pour SPB'
  End 
	
--------------------------------------------------------------------------------------------------------------------
-- Pied du mail
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'


  -- On convertit pour l'appel de la PS
  Set @iIdSin  = Convert ( integer, @adcIdSin )
  Set @iIdProd = Convert ( integer, @dcIdProd )
  Set @iIdEts  = Convert ( integer, @dcIdEts )

  If @@servername = master.dbo.SPB_FN_ServerName ('PRO')

   Begin  -- TRACE_MAIL_PRO : Début écriture

	  Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
		@asIdAppli,
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	        @sMailFrom, 
		@sMailSend, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail, --#2
		'M13', -- #2
		2 -- #2

   End    -- TRACE_MAIL_PRO : Fin écriture

  Else

   Begin  -- TRACE_MAIL_TRT : Début écriture

	  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
		@asIdAppli,
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	        @sMailFrom, 
		@sMailSend, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail, --#2
		'M13', -- #2
		2 -- #2

   End    -- TRACE_MAIL_TRT : Fin écriture

  -- Problème suite éxécution
  If @iRet <> 0 Return -20

  -- Si Succès ET Econocom, alors on l'envoi du mail
  If @iCasECONOCOM > 0  
   Begin
     If Exists ( Select * From sysadm.sinistre s Where s.id_sin = @adcIdSin )
       Begin 
        Insert into sysadm.div_sin values ( @adcIdSin, 'mail_decl', 'Mail déclaration envoyé', '-1', 'N', 'X', 'N', 'O', 80, null, null, null, 'O', getdate(), getdate(), 'SQL', getdate(), 'SQL' )        
       End

     If Exists ( Select * From sysadm.w_sin s Where s.id_sin = @adcIdSin )
       Begin 
        Insert into sysadm.w_div_sin values ( @adcIdSin, 'mail_decl', 'Mail déclaration envoyé', '-1', 'N', 'X', 'N', 'O', 80, null, null, null, 'O', 1, getdate(), getdate(), 'SQL' )        
       End        
   End 

  -- Fin de traitement
  Set @asCasRetour = 'MAIL_ENVOYE'
  Return 0
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S11_SMSPUSH_ENVOI_BGE
-- Auteur               :       F. Pinon
-- Date                 :       22/09/2010
-- Libelle              :	[PC282]
-- Commentaires         :       Envoi de SMS relatif à l'envoi d'un BGE
--				Le contrôle de position des DP 104 et 105 est fait dans le code PB
--
-- References           :
--
-- Arguments            :       @adcIdSin       Decimal (  7,0 )        (Val)
--				@asCasRetour    VarChar (50)		(ref) Cas : SMS_ENVOYE
--										    OPTION_DP_NON_PARAM
--										    HORS_BASE_DE_PRODUCTION
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
--      JFF   23/05/2012 [PM103][1]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S11_SMSPUSH_ENVOI_BGE' AND type = 'P' )
        DROP procedure sysadm.PS_S11_SMSPUSH_ENVOI_BGE
GO


CREATE procedure sysadm.PS_S11_SMSPUSH_ENVOI_BGE
	@adcIdSin       Decimal (  10,0 ), -- [PI062]
	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @iRet		Integer,
  @iIdProd 	Integer,
  @sAltSuiviSMS VarChar ( 1 ),  
  @sNumGsmSMS   VarChar ( 20 ),
  @sLogin 	VarChar ( 10 ),  
  @sMdPasse 	VarChar ( 10 ), 
  @sSmsBody	VarChar(255),
  @sLibProd     VarChar (255), 
  @sCodeTrt 	VarChar ( 10 ), 
  @iIdEts	Integer

  -- [PM103][1]	
	If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
	 Begin
	 	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
 		Return 0
	 End

  -- :[PM103][1]
  
  Set @iRet = 0
  Select @sAltSuiviSMS = NULL, @sNumGsmSMS=NULL
		 
   Select @sAltSuiviSMS = IsNull ( sysadm.FN_TRIM ( i.alt_suivi_sms ), '' ),
  		 @sNumGsmSMS  = IsNull ( sysadm.FN_TRIM ( i.num_port_sms ), '' )
   From   sysadm.inter i
   Where  i.id_sin = @adcIdSin
   and    cod_inter = 'A'
	  
   -- Absence de tel gsm ou alt_suivi_sms décoché
   If @sNumGsmSMS Is Null Set @sNumGsmSMS=''
   Else Set @sNumGsmSMS = sysadm.FN_TRIM ( @sNumGsmSMS)
   
   If @sAltSuiviSMS Is Null Set @sNumGsmSMS=''
   
   If @sNumGsmSMS=''  or @sAltSuiviSMS <> 'O' return 0
   
   -- Récupération de id_prod et lib_prod
    Select @iIdProd = sysadm.FN_TRIM ( s.id_prod ),
           @sLibProd = sysadm.FN_TRIM ( p.lib_long ),
	   @iIdEts = s.id_ets
    From   sysadm.sinistre s,
	   sysadm.produit  p
    Where  s.id_sin = @adcIdSin
    and    p.id_prod = s.id_prod
	  
   -- SMS
   Set @sSmsBody='Fnac Echange Produits Techniques. Nous vous informons de l’envoi ce jour de votre bon d’échange'

   -- Param lié à la variante
   Set @sLogin   = 'spbCD'
   Set @sMdPasse = 'i3m2i2d2'
   Set @sCodeTrt = 'NETSIZE'

   If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
   Begin  
	Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_SMS_PUSH_V00 
	2,
	@adcIdSin  ,
	@iIdProd,
	@sLibProd,
	@iIdEts,
	@sNumGsmSMS,
	@sLogin,
	@sMdPasse,
	@sSmsBody,
	@sCodeTrt,
	'M14', 
	2
   End   
   Else
   Begin
      Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_SMS_PUSH_V00 
	2,
	@adcIdSin,
	@iIdProd,
	@sLibProd,
	@iIdEts,
	@sNumGsmSMS,
	@sLogin,
	@sMdPasse,
	@sSmsBody,
	@sCodeTrt,
	'M14', 
	2		
   End


  -- Problème suite éxécution
  If @iRet <> 0 Return -20

  -- Fin de traitement
  Set @asCasRetour = 'SMS_ENVOYE'
  Return 0
Go

--   JFF   23/05/2012 [PM103][1]
-- JFF      12/02/2016   [PI062]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S11_MAILPUSH_SAV_CARREFOUR' AND type = 'P' )
        DROP procedure sysadm.PS_S11_MAILPUSH_SAV_CARREFOUR
GO

CREATE procedure sysadm.PS_S11_MAILPUSH_SAV_CARREFOUR
	@adcIdSin      	Decimal (10), -- [PI062]
	@aiIdSeq	Integer
AS
Declare 
  @dcIdProd	Decimal(7,0), 
  @iIdProd     	Integer, 
  @sNom		VarChar (71), 
  @sCiv		VarChar (101), 
  @iIdEts 	Integer, 
  @sLibProd     VarChar (255), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @sSaut	VarChar (10), 
  @iRet		Integer,
  @sBoiteMail   VarChar (35),
  @iIdSin	Integer,
  @iIdBoutique	Integer
	
  
  Set @sMailBody = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  Set @sMailFrom='carrefourcassevol@spb.eu'
  Set @sSaut = Char (10)
  Set @sAltQuarant='N'
  
    -- [PM103][1]	
	If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
	 Begin
 		Return 0
	 End

  -- :[PM103][1]
  
  -- Récupération des données standard nécessaires à l'envoi du mail
  Select @sBoiteMail=sysadm.FN_CLE_VAL('BOITE_MAIL',d.val_car,';'),
	@dcIdProd=s.id_prod, @sLibProd=sysadm.FN_LIB_PROD(s.id_prod),
	@iIdEts=s.id_ets, @sCiv=sysadm.FN_TRIM ( IsNull ( sysadm.FN_CODE_NUM ( sysadm.FN_TRIM (p.cod_civ), '-CI' ), '' )),
	@sNom=RTrim(p.nom) + isnull(' ' + RTrim(p.prenom),''),
	@iIdBoutique=s.id_orian_boutique
  From sysadm.det_pro d
  Inner join sysadm.sinistre s on s.id_prod=d.id_prod
  Inner join sysadm.personne p on s.id_ordre=p.id_ordre
  where d.id_code_dp=141 and s.id_sin=@adcIdSin
  
  -- Retour - pas de mail envoyé
  If @@RowCount=0 Set @iRet=-9
  
  If @sBoiteMail Is Null Or Len ( sysadm.FN_TRIM ( @sBoiteMail ) ) <= 0 Set @iRet = -11
  
  If @iRet <> 0 Return @iRet   
  
   -- Recup mail
  Select @sMailSend=adr_mail2
  from sysadm.boutique where id_prod=@dcIdProd and id_boutique=@iIdBoutique
 
  If @sMailSend Is Null Or sysadm.FN_TRIM ( @sMailSend ) = '' Return -7
  
  -- Gestion de la civilité "Madame, Monsieur"
  If @sNom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sNom
   End 

  -- Armement de l'objet du mail
  Set @sMailObjet = 'Dossier n° ' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) + ' - Garantie Carrefour casse vol' -- [PI062]

  Set @sMailBody = ''

  -- Armement du corps du mail
  Set @sMailBody  = @sMailBody  + 'Bonjour,'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'SPB est intervenu sur le dossier n° '+ sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) + ' de ' + @sCiv + ', merci de consulter ce dossier sur l''extranet.' -- [PI062]
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Cordialement'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Votre gestionnaire'
  
  -- On convertit pour l'appel de la PS
  Set @iIdSin  = Convert ( integer, @adcIdSin )
  Set @iIdProd = Convert ( integer, @dcIdProd )
  
  If @@servername = master.dbo.SPB_FN_ServerName ('PRO')

   Begin  -- TRACE_MAIL_PRO : Début écriture

	  Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
		'SIMPA2',
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	        @sMailFrom, 
		@sMailSend, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail, 
		'SAVCAR',
		2 

   End    -- TRACE_MAIL_PRO : Fin écriture

  Else

   Begin  -- TRACE_MAIL_TRT : Début écriture

	  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
		'SIMPA2',
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	        @sMailFrom, 
		@sMailSend, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail,
		'SAVCAR', 
		2 

   End    -- TRACE_MAIL_TRT : Fin écriture
	

  -- Problème suite éxécution
  If @iRet <> 0 Return -20

  -- Fin de traitement
  Return 0
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S12_MAILPUSH_LDE
-- Auteur               :       F. Pinon
-- Date                 :       14/09/2011
-- Libelle              :	[PC19]
-- Commentaires         :       Envoi de mailpush vers lyonnaise des eaux
--
-- References           :
--
-- Arguments            :       @adcIdSin       Decimal (  7,0 )        (Val)
--				@asCasRetour    VarChar (50)		(ref) Cas : SMS_ENVOYE
--										    OPTION_DP_NON_PARAM
--										    HORS_BASE_DE_PRODUCTION
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
--      JFF   23/05/2012 [PM103][1]
--		JFF   12/02/2016 [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S12_MAILPUSH_LDE' AND type = 'P' )
        DROP procedure sysadm.PS_S12_MAILPUSH_LDE
GO

CREATE procedure sysadm.PS_S12_MAILPUSH_LDE
	@adcIdSin      	Decimal (10), -- [PI062]
	@aiIdMail	Integer,
	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @dcIdProd	Decimal(7,0), 
  @iIdProd     	Integer, 
  @sNom		VarChar (71),
  @sPrenom	Varchar( 35),
  @sCiv		VarChar (101), 
  @iIdEts 	Integer, 
  @sLibProd     VarChar (255), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @sSaut	VarChar (10), 
  @iRet		Integer,
  @sBoiteMail   VarChar (35),
  @iIdSin	Integer,
  @iIdBoutique	Integer,
  @iOptionDP    Integer,
  @sAltSuiviSMS VarChar ( 1 ), 
  @sNumGsmSMS   VarChar ( 20 ),
  @sNumProd     VarChar (20),
  @sBase		Varchar(20),
  @sRefLDE		Varchar(60),
  @sDateAdh		Varchar(10),
  @sFactRecue	Varchar(1),
  @sRibBq		Varchar(5), 
  @sRibGui		Varchar(5), 
  @sRibCpt		Varchar(11),
  @sRibCle		Varchar(2),
  @sMtAReg		Varchar(20)
  
  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
   Set @sBase=db_name( db_id() )
  -- Option de déclenchement du mail -DP
  Set @iOptionDP = 185
  Set @sMailSend=''
  Set @sFactRecue='N'

  -- [PM103][1]	
	If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
	 Begin
	 	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
 		Return 0
	 End
  -- :[PM103][1]
  
    -- Récupération des données standard nécessaires à l'envoi du mail
  
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@sBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@iIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
        @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT, 
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #2
	@sAltSuiviSMS OUTPUT, -- #7 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #7 [FNAC_PROD_ECH_TECH].[SMS]
	

  -- Cas de retour n'étant pas des erreurs
  If @iRet = -9 
   Begin
	Select @asCasRetour ='OPTION_DP_NON_PARAM'
	Return 0
  End
  Else
  Begin
   Select @iRet =
    Case @iRet
    When -7 Then 0
    When -10 Then 0
    Else @iRet End
  End 


-- Problème suite éxécution
  If @iRet <> 0 Return @iRet
  
  Select  @sPrenom = Case When p.cod_civ in ( 5 ) Then '' 
		Else sysadm.SPB_FN_INIT_CAP
		     (
		     sysadm.FN_TRIM ( IsNull ( Upper ( Left  ( sysadm.FN_TRIM ( p.prenom ), 1) ), '' )) +
				     sysadm.FN_TRIM ( IsNull ( Lower ( Right ( sysadm.FN_TRIM ( p.prenom ), Len ( p.prenom ) - 1 ) ), '' )),
				     null)
	  End 
  From   sysadm.sinistre s,
	 sysadm.personne p
  Where  s.id_sin = @adcIdSin
  and    s.id_ordre = p.id_ordre
	  
  -- Récupération des données standard nécessaires à l'envoi du mail
  Select @sMailSend=sysadm.FN_CLE_VAL('ADR_MAIL',d.val_car,';'),
	@sDateAdh=RIGHT('0' + Convert(varchar(2),DATEPART(day,s.dte_adh)),2) + '/' +
		 RIGHT('0' + Convert(varchar(2),DATEPART(month,s.dte_adh)),2) + '/' +
		 convert(varchar(4),DATEPART(year,s.dte_adh)),
	@sFactRecue=Case When exists (select * from sysadm.div_sin  
		where id_sin=@adcIdSin and nom_zone='fact_recue' and val_car='O') Then 'O'
		Else 'N' End
  From sysadm.det_pro d
  Inner join sysadm.sinistre s on s.id_prod=d.id_prod
  where d.id_code_dp=185 and s.id_sin=@adcIdSin
  
  -- Retour - pas de mail envoyé
  If @sBoiteMail Is Null Or Len ( sysadm.FN_TRIM ( @sBoiteMail ) ) <= 0 Set @iRet = -11
  If @sMailSend Is Null Or sysadm.FN_TRIM ( @sMailSend ) = '' Set @iRet=-7
  If @iRet <> 0 Return @iRet   

  -- Infos de règlement
  If @aiIdMail = 3
  Begin
	Select @sRibBq=rib_bq, @sRibGui=rib_gui, @sRibCpt=rib_cpt, @sRibCle=rib_cle,
		@sMtAReg=str(r.mt_reg,11,2) 
	From sysadm.inter i
	Inner join sysadm.reg_gti r on i.id_sin=r.id_sin and i.id_i=r.id_i
	inner join sysadm.w_a_virer w  on i.id_sin=w.id_sin and i.id_i=w.id_i and w.id_reg=r.id_reg
	where i.id_sin=@adcIdSin and i.cod_inter='T' and i.cod_bq is not null
	and w.cod_pos='0'
	
	If @@ROWCOUNT = 0 Return 0 -- mail déjà envoyé
  End 
    
  -- Récupération de la Ref ORCC ou ORCE
  If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
  Begin
	Select @sRefLDE=lib_info
	From SHERPA_PRO.sysadm.sinistre s
	Inner join SHERPA_PRO.sysadm.info_client ic on ic.id_cli=s.id_cli
	Where s.id_sin=@adcIdSin and ic.id_info=41 
  End
  else
  Begin 
	Select @sRefLDE=lib_info
	From SHERPA_SIM.sysadm.sinistre s
	Inner join SHERPA_SIM.sysadm.info_client ic on ic.id_cli=s.id_cli
	Where s.id_sin=@adcIdSin and ic.id_info=41 
  End
  
  If @sRefLDE Is Null Set @sRefLDE = ''
  
  -- Gestion de la civilité "Madame, Monsieur"
  If @sNom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sNom
   End 

   If @sPrenom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sPrenom
   End 

  Set @iIdSin  = Convert ( integer, @adcIdSin )
  Set @iIdProd = Convert ( integer, @dcIdProd )
  
  -- Armement de l'objet du mail
  Select @sMailObjet=Case @aiIdMail 
	When 1 Then 'Refus de prise en charge'
	When 2 Then 'Surconsommation'
	When 3 Then 'Indemnisation de surconsommation'
	End
  
  Set @sMailObjet = @sMailObjet + ' - ' + @sRefLDE
  Set @sMailObjet = @sMailObjet + ' - dossier SPB ' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) -- [PI062]

  Set @sMailBody = ''

  -- Armement du corps du mail
  Set @sMailBody  = @sMailBody  + 'Bonjour,'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  
  If @aiIdMail = 1 
  Begin
    Set @sMailBody  = @sMailBody  + @sCiv + ' - ' + @sRefLDE + ' a souscrit un contrat ' + @sLibProd + ' en date du ' + @sDateAdh + '.'
    Set @sMailBody  = @sMailBody  + @sSaut
    Set @sMailBody  = @sMailBody  + @sSaut
    Set @sMailBody  = @sMailBody  + 'Nous vous informons que nous venons d''émettre un refus de prise en charge sur ce dossier. '
    Set @sMailBody  = @sMailBody  + @sSaut
    Set @sMailBody  = @sMailBody  + @sSaut
    Set @sMailBody  = @sMailBody  + 'Vous souhaitant bonne réception'
  End
  
  If @aiIdMail = 2
  Begin
     Set @sMailBody  = @sMailBody  + @sCiv + ' - ' + @sRefLDE + ' nous a contacté pour une fuite accidentelle et un dossier SPB a été ouvert sous le numéro '
     Set @sMailBody  = @sMailBody  + CONVERT(varchar(10), @iIdSin) + ' pour une éventuelle prise en charge de la surconsommation d’eau.'
     Set @sMailBody  = @sMailBody  + @sSaut
     Set @sMailBody  = @sMailBody  + @sSaut
    
     If @sFactRecue = 'O' 
     Begin
	   Set @sMailBody  = @sMailBody  + 'Nous vous remercions de bloquer les relances dans l’attente de la suite donnée à ce dossier.'
       Set @sMailBody  = @sMailBody  + @sSaut
       Set @sMailBody  = @sMailBody  + @sSaut
     End
    
     Set @sMailBody  = @sMailBody  + 'Restant à votre disposition pour tout renseignement complémentaire.'
  End
  
  If @aiIdMail = 3
  Begin
     Set @sMailBody  = @sMailBody  + 'Nous vous informons de la prise en charge de la surconsommation d’eau suite à la fuite accidentelle concernant '
     Set @sMailBody  = @sMailBody  + @sCiv + ' - ' + @sRefLDE + ' - dossier SPB ' + CONVERT(varchar(10), @iIdSin) + '.'
     Set @sMailBody  = @sMailBody  + @sSaut
     Set @sMailBody  = @sMailBody  + 'Nous avons émis un virement en votre faveur d’un montant de ' + lTrim(@sMtAReg) + '€ '
     Set @sMailBody  = @sMailBody  + 'en règlement de cette surconsommation sur le compte suivant :  ' 
	 Set @sMailBody  = @sMailBody+ sysadm.FN_TRIM(@sRibBq) + ' ' + sysadm.FN_TRIM(@sRibGui) + ' ' + sysadm.FN_TRIM(@sRibCpt) + ' ' + sysadm.FN_TRIM(@sRibCle) + '.'
     Set @sMailBody  = @sMailBody  + @sSaut
     Set @sMailBody  = @sMailBody  + @sSaut
     Set @sMailBody  = @sMailBody  + 'Restant à votre disposition pour tout renseignement complémentaire.'
  End
  
  Set @sMailBody  = @sMailBody  + @sSaut + @sSaut
  Set @sMailBody  = @sMailBody  + 'Le Service Assurance et Assistance Fuite' + @sSaut
  Set @sMailBody  = @sMailBody  + 'SPB' + @sSaut
  Set @sMailBody  = @sMailBody  + 'Service Assurance et Assistance Fuite' + @sSaut
  Set @sMailBody  = @sMailBody  + '76095 Le Havre Cedex' 
  
  If @@servername = master.dbo.SPB_FN_ServerName ('PRO')

   Begin  -- TRACE_MAIL_PRO : Début écriture

	  Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
		'SIMPA2',
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	    @sMailFrom, 
		@sMailSend, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail, 
		'C_LDE',
		2 

   End    -- TRACE_MAIL_PRO : Fin écriture

  Else

   Begin  -- TRACE_MAIL_TRT : Début écriture

	  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
		'SIMPA2',
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	        @sMailFrom, 
		@sMailSend, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail,
		'C_LDE', 
		2 

   End    -- TRACE_MAIL_TRT : Fin écriture
	

  -- Problème suite éxécution
  If @iRet <> 0 Return -20

  -- Fin de traitement
  Return 0

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_MAILPUSH_MAIL_AXALOT
-- Auteur               :       Fabry JF
-- Date                 :       11/01/2012
-- Libelle              :
-- Commentaires         :       
-- References           :
--
-- Arguments            :       @asIdAppli	varchar (20)		(val) Nom de l'application mère éxécutant la PS
--				@asBase		varchar (20)		(val) Nom de la base de données SHERPA ou SIMPA2
--				@adcIdSin       Decimal (  7,0 )        (Val)
--				@aiIdSeq	Integer		        (Val)
--				@asCasRetour    VarChar (50)		(ref) Cas : MAIL_ENVOYE
--										    OPTION_DP_NON_PARAM
--										    HORS_BASE_DE_PRODUCTION
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MAILPUSH_MAIL_AXALOT' AND type = 'P' )
        DROP procedure sysadm.PS_S_MAILPUSH_MAIL_AXALOT
GO


CREATE procedure sysadm.PS_S_MAILPUSH_MAIL_AXALOT
	@asIdAppli	varchar (20),
	@asBase		varchar (20),
	@adcIdSin      	Decimal (10), -- [PI062]
	@aiIdSeq      	Integer,
	@asCas		VarChar (20),
	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @sSaut	VarChar (10), 
  @sMarque	VarChar (35),
  @sModele	VarChar (35),  
  @sIdFour	VarChar (10),
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @iPRS		Integer,
  @iOptionDP    Integer,
  @dtDteRcpFrnActuel DateTime,
  @dtDteGenCmde DateTime,
  @sBoiteMail    VarChar (35),
  @iVarianteMail Integer, -- #4 [DCMP080202]
  @iVarianteSMS  Integer, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  @iInfoSpbFrn   Integer, -- #4 [DCMP080202]
  @sIdRefFour    VarChar ( 35 ), -- #4 [DCMP080202]
  @sSmsBody     VarChar ( 255 ), -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  @sTopSMS	Integer, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  @sVal		VarChar ( 70 ), -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  @sAltSuiviSMS VarChar ( 1 ),  -- #5 [FNAC_PROD_ECH_TECH].[SMS]  
  @sNumGsmSMS   VarChar ( 20 ),  -- #5 [FNAC_PROD_ECH_TECH].[SMS]  
  @sLogin VarChar ( 10 ),  -- #5 [FNAC_PROD_ECH_TECH].[SMS]  
  @sMdPasse VarChar ( 10 ),  -- #5 [FNAC_PROD_ECH_TECH].[SMS]  
  @sCodeTrt VarChar ( 10 ),  -- #5 [FNAC_PROD_ECH_TECH].[SMS]  
  @iLongMaxSMS Integer, -- #5 [FNAC_PROD_ECH_TECH].[SMS]  
  @iIdBoutique 	Integer, -- #6 [FNAC_PROD_ECH_TECH].[20090127140540720]
  @sDP205	VarChar (205 ), -- [RECUP_DONNEE_O2M]
  @sTypMail VarChar ( 20 ),
  @sMethode VarChar ( 20 ),
  @sMdp VarChar ( 20 ),
  @sInfoFrnSpbCplt VarChar ( 800 ),
  @sHoraireOuv VarChar ( 70 ),
  @sPctDonneeRecup VarChar ( 10 ),
  @sDelaiDispoDonneesJ VarChar ( 10 ),
  @sDteMax VarChar ( 15 ),
  @sDonneesRecuperees Varchar ( 10 )
  
  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  Set @iPRS = 0
  Set @asIdAppli = Upper ( @asIdAppli )
  Set @sTopSMS = 0 -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  Set @sVal = ''
  Set @sSmsBody = ''
  Set @iLongMaxSMS = 160 -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  
  If @asCas is null Set @asCas = ''

  Set @sTypMail = 'M18'
  If @asCas = '2EME_MAIL' Set @sTypMail = 'M19'

  -- Option de déclenchement du mail -DP
  Set @iOptionDP = 205

  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@asBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
        @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT,  
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #3
	@sAltSuiviSMS OUTPUT, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #5 [FNAC_PROD_ECH_TECH].[SMS]

-- #5 [FNAC_PROD_ECH_TECH].[SMS] On ne plus gère cette erreur à ce moment (il peut y avoir du SMS à envoyer). 
  If @iRet = -7 
   Begin
  	Set @iRet = 0
	Set @asCasRetour = 'ADRESSE_MAIL_ABSENTE'
   End 
   
  -- Cas de retour n'étant pas des erreurs
  If @iRet in ( -9, -10 )
   Begin
	Select @asCasRetour =
	Case @iRet
--		When -7 Then 'ADRESSE_MAIL_ABSENTE' -- #5 [FNAC_PROD_ECH_TECH].[SMS] ne plus retourner cette erreur à ce moment
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

  -- Problème suite éxécution
  If @iRet <> 0 Return @iRet

  -- Sommes-nous dans le cas d'une réception fournisseur ?
  Select @dtDteRcpFrnActuel = c.dte_rcp_frn,
	 --@sMarque = IsNull ( sysadm.FN_TRIM ( c.id_marq_art ), '') , -- #4 [DCMP080202] lu plus loin
	 --@sModele = IsNull ( sysadm.FN_TRIM ( c.id_modl_art ), '')   -- #4 [DCMP080202] lu plus loin
  	 @iInfoSpbFrn = c.info_spb_frn, -- #4 [DCMP080202]
  	 @sIdRefFour = c.id_ref_four, -- #4 [DCMP080202]
	 @sInfoFrnSpbCplt=c.info_frn_spb_cplt -- [RECUP_DONNEE_O2M]
  From   sysadm.commande c
  Where  c.id_sin = @adcIdSin
  And    c.id_seq = @aiIdSeq

  Select @sDonneesRecuperees = sysadm.FN_CLE_VAL ( 'DONNEES_RECUPEREES', @sInfoFrnSpbCplt, ';') 
  If @sDonneesRecuperees is null Set @sDonneesRecuperees =''

 -- Est-ce une réparation
  If @sDonneesRecuperees = ''
   Begin
     Set @asCasRetour = 'HORS_RECUP_DONNEES'
     Return 0
   End   

  Select   @sMarque = IsNull ( sysadm.FN_TRIM ( s.marq_port ), '') , -- #4 [DCMP080202]
	   @sModele = IsNull ( sysadm.FN_TRIM ( s.modl_port ), '') ,  -- #4 [DCMP080202]
	   @iIdBoutique = s.id_orian_boutique -- #6 [FNAC_PROD_ECH_TECH].[20090127140540720]	   
  From     sysadm.sinistre s
  Where   s.id_sin = @adcIdSin

  -- [RECUP_DONNEE_O2M]  
  Select @sDP205 = sysadm.FN_TRIM ( IsNull ( dp.val_car, '' ) )
  From   sysadm.det_pro dp
  Where  dp.id_prod = @dcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = 205 
  If @sDP205 is null Set @sDP205 = ''  

  Select @sDelaiDispoDonneesJ = sysadm.FN_CLE_VAL ( 'DELAI_DISPO_DONNEES_J', @sDP205, ';')
  If @sDelaiDispoDonneesJ is null Set @sDelaiDispoDonneesJ = ''

  Set @sDteMax = Convert ( VarChar ( 10 ), 
  		 DateAdd (day, Convert ( Integer , @sDelaiDispoDonneesJ  ), Getdate() )
  		, 103 )
  If @sDteMax is null Set @sDteMax = ''

  Select @sLogin = sysadm.FN_CLE_VAL ( 'LOGIN_AXALOT', @sInfoFrnSpbCplt, ';')
  If @sLogin is null Set @sLogin = ''

  Select @sMdp = sysadm.FN_CLE_VAL ( 'MDP_AXALOT', @sInfoFrnSpbCplt, ';')
  If @sMdp is null Set @sMdp = ''

  Select @sPctDonneeRecup = sysadm.FN_CLE_VAL ( 'PCT_DONNEES_RECUP', @sInfoFrnSpbCplt, ';')
  If @sPctDonneeRecup is null Set @sPctDonneeRecup = ''

  Select @sMethode = sysadm.FN_CLE_VAL ( 'METHODE', @sDP205 , ';')
  If @sMethode is null Set @sMethode = ''


   Select @sHoraireOuv = sysadm.FN_TRIM ( IsNull ( dp.val_car, '' ) )
   From   sysadm.det_pro dp
   Where  dp.id_prod = @dcIdProd
   and    dp.id_typ_code_dp = '-DP' 
   and    dp.id_code_dp = 84   
   If @sHoraireOuv is null Set @sHoraireOuv = ''


   If @sMethode <> '' And 
      ( sysadm.FN_CLE_VAL ( 'DONNEES_RECUPEREES', @sInfoFrnSpbCplt, ';') = 'NON' 
      Or 
        @sPctDonneeRecup= '0')
    Begin
		Set @iVarianteMail = 1
	--7.5
    End 

   If  ( @sMethode = '2' And 
        sysadm.FN_CLE_VAL ( 'DONNEES_RECUPEREES', @sInfoFrnSpbCplt, ';') = 'OUI' And
        sysadm.FN_CLE_VAL ( 'DONNEES_TRANSFEREES_SUR_NOUVEL_APP', @sInfoFrnSpbCplt, ';') = 'NON' )
      Or 
      ( @sMethode = '1' And 
        sysadm.FN_CLE_VAL ( 'DONNEES_RECUPEREES', @sInfoFrnSpbCplt, ';') = 'OUI')
    Begin
    	If @sMethode = '2' --7.3 + 7.4 PC512
    	Begin
    		Set @iVarianteMail = 2
    	End 
    	
    	If @sMethode = '1'  -- PC260
		 Begin    		
    		If @sPctDonneeRecup = '100'
    		 Begin
    		 	Set @iVarianteMail = 4
    		 End
    		Else
   			 Begin
    		 	Set @iVarianteMail = 5
    		 End
    	 End 
    End 

   If sysadm.FN_CLE_VAL ( 'METHODE', @sDP205, ';') = '2' And 
      sysadm.FN_CLE_VAL ( 'DONNEES_RECUPEREES', @sInfoFrnSpbCplt, ';') = 'OUI' And
      sysadm.FN_CLE_VAL ( 'DONNEES_TRANSFEREES_SUR_NOUVEL_APP', @sInfoFrnSpbCplt, ';') = 'OUI'
    Begin
	Set @iVarianteMail = 3
	-- 7.2
    End 

  -- Fin de traitement
  If @iVarianteMail is null Or @iVarianteMail = 0
	Begin	
		Set @asCasRetour = 'PAS_DE_VARIANTE_MAIL'
		Return 0
	End
 
 
--------------------------------------------------------------------------------------------------------------------
-- Construction du mail.
--------------------------------------------------------------------------------------------------------------------


  -- Gestion de la civilité "Madame, Monsieur"
  If @sNom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sNom + ','
   End 

--------------------------------------------------------------------------------------------------------------------
  -- Armement de l'objet du mail
  If @iVarianteMail in ( 1,2,3,4,5 ) 
   Begin
    Set @sMailObjet = 'Dossier de sinistre SPB n°' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) + ' ' + @sLibProd  -- [PI062]
   End

--------------------------------------------------------------------------------------------------------------------
  -- Armement du corps du mail
  If @iVarianteMail in ( 1 ) -- 7.5
   Begin
	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	
	Set @sMailBody  = @sMailBody  + 'Nous sommes au regret de vous informer que nous n’avons pu récupérer les données de votre appareil ' + @sMarque + ' ' + @sModele + '.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	-- V6 PC512-2
	Set @sMailBody  = @sMailBody  + 'Nous vous informons que le traitement de récupération de données est indépendant de la prise en charge de votre dossier de sinistre pour votre appareil.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'

   End  


  If @iVarianteMail in ( 2 ) And @asCas = '1ER_MAIL' -- 7.3
   Begin
	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	
	Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer que nous avons procédé à la récupération des données de votre appareil ' + @sMarque + ' ' + @sModele + '.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'En conséquence, nous vous invitons à vous connecter sur notre site https://orange.axalot.com/?mail=' + @sLogin + ' afin de récupérer vos données.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Votre login et mot de passe vous seront adressés par un autre mail.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
   End
   

  If @iVarianteMail in ( 2,4,5) And @asCas = '2EME_MAIL' -- 7.4
   Begin
	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	
	Set @sMailBody  = @sMailBody  + 'Nous nous référons à la récupération des données de votre appareil ' + @sMarque + ' ' + @sModele + '.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Vous trouverez ci-dessous votre login et mot de passe qui vous permettront d’accéder à notre site internet où vous pourrez récupérer vos données.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Login : ' + @sLogin
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Mot de passe : ' + @sMdp
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'En cas de problème, vous pouvez nous contacter au '+ @sNumProd + ' ' + @sHoraireOuv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous vous informons que vous disposez d''un délai de ' + @sDelaiDispoDonneesJ + ' jours, soit jusqu''au ' + @sDteMax + ' pour récupérer vos données.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'

   End


  If @iVarianteMail in ( 4 ) And @asCas = '1ER_MAIL'
   Begin
	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	
	Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer que nous avons procédé à la récupération des données sur le disque dur de votre ' + @sMarque + ' ' + @sModele + '.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'En conséquence, nous vous invitons à vous connecter sur notre site https://orange.axalot.com/?mail=' + @sLogin + ' afin de récupérer vos données dans la limite de 20 Go.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Votre login et mot de passe vous seront adressés par un autre mail.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Si les données dépassent 20 Go, vous aurez la possibilité de sélectionner sur le site le contenu des données que vous souhaitez récupérer. En parallèle, une prestation complémentaire payante vous sera proposée par notre p
restataire.' 
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
   End

  If @iVarianteMail in ( 5 ) And @asCas = '1ER_MAIL'
   Begin
	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	
	Set @sMailBody  = @sMailBody  + 'Nous vous informons que nous avons procédé à la récupération des données sur le disque dur de votre ' + @sMarque + ' ' + @sModele + '.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Votre disque étant endommagé, nous avons pu récupérer ' + @sPctDonneeRecup + '% de vos données.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous vous invitons à vous connecter sur notre site https://orange.axalot.com/?mail=' + @sLogin + ' afin de récupérer vos données dans la limite de 20 Go.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Votre login et mot de passe vous seront adressés par un autre mail.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Si les données dépassent 20 Go, vous aurez la possibilité de sélectionner sur le site le contenu des données que vous souhaitez récupérer. En parallèle, une prestation complémentaire payante vous sera proposée par notre p
restataire.' 
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
   End

  If @iVarianteMail in ( 3 ) And @asCas = '1ER_MAIL'
   Begin
	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer que nous avons procédé à la récupération des données de votre appareil ' + @sMarque + ' ' + @sModele + '.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Ces données seront transférées sur l''appareil de remplacement qui vous sera adressé dans les plus brefs délais.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Votre appareil de remplacement comportera un code verrou correspondant aux 4 derniers chiffres de votre n° de dossier de sinistre.' -- PC512-2
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
   End
  
  --------------------------------------------------------------------------------------------------------------------
-- Pied du mail
  
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'
  


--------------------------------------------------------------------------------------------------------------------
-- Préparation et envoi des données.
--------------------------------------------------------------------------------------------------------------------

  -- On convertit pour l'appel de la PS
  Set @iIdSin  = Convert ( integer, @adcIdSin )
  Set @iIdProd = Convert ( integer, @dcIdProd )
  Set @iIdEts  = Convert ( integer, @dcIdEts )

  If @@servername = master.dbo.SPB_FN_ServerName ('PRO')

   Begin  -- TRACE_MAIL_PRO : Début écriture

	  If @asCasRetour <> 'ADRESSE_MAIL_ABSENTE'
	    Begin 	
		  Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
			@asIdAppli,
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			@sAltQuarant,
			@sBoiteMail, -- #3
			@sTypMail , -- #3
			2 -- #3
	    End

   End    -- TRACE_MAIL_PRO : Fin écriture

  Else

   Begin  -- TRACE_MAIL_TRT : Début écriture
	  If @asCasRetour <> 'ADRESSE_MAIL_ABSENTE'
	    Begin 	
		  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			@asIdAppli,
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			@sAltQuarant,
			@sBoiteMail, -- #3
			@sTypMail , -- #3
			2 -- #3	
	    End

   End    -- TRACE_MAIL_TRT : Fin écriture

  -- Problème suite éxécution
  If @iRet <> 0 
    Begin 
      Set @asCasRetour = ''
      Return -20
    End

  -- #5 [FNAC_PROD_ECH_TECH].[SMS] à Ce moment le cas de retour ne sert plus pour une erreur SQL. il n'est utilisé en amont que pour du retour immédiat sans erreur. 
  If @asCasRetour = 'ADRESSE_MAIL_ABSENTE' Return 0


  If @iVarianteMail in ( 2,4,5 ) And @asCas = '1ER_MAIL'
   Begin
	Exec sysadm.PS_S_MAILPUSH_MAIL_AXALOT
		@asIdAppli,
		@asBase,
		@adcIdSin,
		@aiIdSeq,
		'2EME_MAIL',
		@asCasRetour OUTPUT
   End
   
  -- Fin de traitement
  Set @asCasRetour = 'MAIL_ENVOYE'
  Return 0
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S13_MAILPUSH_FRAIS_PRESTA
-- Auteur               :       FPI
-- Date                 :       24/05/2012
-- Libelle              :
-- Commentaires         :       
-- References           :		[VDOC7806]
--
-- Arguments            :       @asIdAppli	varchar (20)		(val) Nom de l'application mère éxécutant la PS
--				@adcIdSin       Decimal (  7,0 )        (Val)
--				@asCasRetour    VarChar (50)		(ref) Cas : MAIL_ENVOYE
--										    OPTION_DP_NON_PARAM
--										    HORS_BASE_DE_PRODUCTION
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S13_MAILPUSH_FRAIS_PRESTA' AND type = 'P' )
        DROP procedure sysadm.PS_S13_MAILPUSH_FRAIS_PRESTA
GO


CREATE procedure sysadm.PS_S13_MAILPUSH_FRAIS_PRESTA
	@asIdAppli	varchar (20),
	@adcIdSin      	Decimal (10), -- [PI062]
	@asMontant		Varchar(20),
	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @asHREFURL	VarChar (300),		
  @sSaut	VarChar (10), 
  @sMarque	VarChar (35),
  @sModele	VarChar (35),  
  @sCodeEtat	VarChar (10),
  @sIdFour	VarChar (10),
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @iOptionDP    Integer,
  @dtDteEnvCliActuel DateTime,
  @sBoiteMail   VarChar (35),
  @sNomTrsp	VarChar (35), 
  @sAltSuiviSMS VarChar ( 1 ),
  @sNumGsmSMS   VarChar ( 20 ),
  @sLogin   VarChar ( 20 ),
  @sMdPasse   VarChar ( 20 ),
  @sCodeTrt   VarChar ( 20 ),
  @sBase	  Varchar(100),
  @sToday	  Varchar(10)
  
  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  
  Set @sLogin   = 'spbCD'
  Set @sMdPasse = 'i3m2i2d2'
  Set @sCodeTrt = 'NETSIZE'
  Set @sBase=DB_NAME(db_id())
  Set @sToday=Convert ( varchar(10), getdate() , 103 )
  
  -- Option de déclenchement du mail -DP
  Set @iOptionDP = 213

  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@sBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT, 
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail OUTPUT, 
	@sAltSuiviSMS OUTPUT, 
	@sNumGsmSMS  OUTPUT 



  -- Cas de retour n'étant pas des erreurs
  If @iRet in (-9, -10 )
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

   If @iRet = -7  Set @iRet=0 -- adr_mail absente
   
  -- Problème suite éxécution
  If @iRet <> 0 Return @iRet

  If rtrim(@sMailSend) = '' Set @sMailSend=NULL
  
   If @sMailSend is not null
   Begin
	-- Envoi de mail
   
	-- Armement de l'objet du mail
	Set @sMailObjet = 'REMBOURSEMENT DES FRAIS D’ENVOI FNAC ' + @sLibProd

	-- Armement du corps du mail
	Set @sMailBody  = @sMailBody  + @sCiv + ',' + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous vous remercions d’avoir adressé votre appareil en diagnostic à notre Centre Technique.' + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous vous informons que nous procédons, ce jour, au remboursement des frais d’envoi pour un montant de ' + @asMontant + '€.' + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tous renseignements complémentaires, et vous prions d’agréer nos salutations distinguées.' + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'SPB / Service FNAC ' + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + '****************************************************************'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + '****************************************************************'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'
	
	  -- On convertit pour l'appel de la PS
    Set @iIdSin  = Convert ( integer, @adcIdSin )
    Set @iIdProd = Convert ( integer, @dcIdProd )
    Set @iIdEts  = Convert ( integer, @dcIdEts )

    If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	Begin  -- TRACE_MAIL_PRO : Début écriture

	  Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
		@asIdAppli,
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	        @sMailFrom, 
		@sMailSend, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail, 
		'M20',
		2 		

    End    -- TRACE_MAIL_PRO : Fin écriture
	Else
	Begin  -- TRACE_MAIL_TRT : Début écriture

	 Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
		@asIdAppli,
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	    @sMailFrom, 
		@sMailSend, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail, 
		'M20', 
		2 

    End    -- TRACE_MAIL_TRT : Fin écriture

    -- Problème suite éxécution
    If @iRet <> 0 Return -20

    -- Fin de traitement
    Set @asCasRetour = 'MAIL_ENVOYE'

  End
  Else
  Begin
    Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	 
	If rtrim(@sNumGsmSMS) = '' Set @sNumGsmSMS=NULL
  
    if @sNumGsmSMS is null
	Begin
	
		select @sNumGsmSMS=Case When i.num_teld is not null Then i.num_teld Else s.num_port End
		from sysadm.sinistre s
		  inner join sysadm.inter i on s.id_sin=i.id_sin
		Where s.id_sin=@adcIdSin and i.cod_inter='A'
		
		if @sNumGsmSMS is null Return 0
	End	
	
    -- Envoi du SMS
    Set @sMailBody='Fnac ' + @sLibProd + '. '
	Set @sMailBody=@sMailBody + 'Nous vous confirmons le remboursement des frais d’envoi en date du ' + @sToday
	Set @sMailBody=@sMailBody + ' pour un montant de ' + @asMontant + ' €.'

	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	Begin  -- TRACE_MAIL_PRO : Début écriture
		Exec TRACE_MAIL_PRO.sysadm.PS_I01_SMS_PUSH_V00 
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sNumGsmSMS,
			@sLogin,
			@sMdPasse,
			@sMailBody,
			@sCodeTrt,
			'M20', 
			2
    End 
	Else
	Begin
	  Exec TRACE_MAIL_TRT.sysadm.PS_I01_SMS_PUSH_V00 
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sNumGsmSMS,
			@sLogin,
			@sMdPasse,
			@sMailBody,
			@sCodeTrt,
			'M20', 
			2
	End
  End
  
  Return 0
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S14_MAILPUSH_CONVERLANCE
-- Auteur               :       FPI 
-- Date                 :       08/06/2012
-- Libelle              :		[PC10-2]
-- Commentaires         :       ENvoi de mail de commande à Converlance Communication
--
-- References           :
--
-- Arguments            :       @asIdAppli	varchar (20)		(val) Nom de l'application mère éxécutant la PS
--				@asBase		varchar (20)		(val) Nom de la base de données SHERPA ou SIMPA2
--				@adcIdSin       Decimal (  7,0 )        (Val)
--				@aiIdSeq	Integer		        (Val)
--				@asCasRetour    VarChar (50)		(ref) Cas : MAIL_ENVOYE
--										    OPTION_DP_NON_PARAM
--										    HORS_BASE_DE_PRODUCTION
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-------------------------------------------------------------------
-- FPI - 05/12/2014 - [VDOC16132] - CHARTIS devient AIG dans l'objet mail
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S14_MAILPUSH_CONVERLANCE' AND type = 'P' )
        DROP procedure sysadm.PS_S14_MAILPUSH_CONVERLANCE
GO


CREATE procedure sysadm.PS_S14_MAILPUSH_CONVERLANCE
	@asIdAppli	varchar (20),
	@asBase		varchar (20),
	@adcIdSin      	Decimal (10),-- [PI062]
	@aiIdSeq 	Integer,
 	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @dcIdDetail   Decimal (7),
  @dcIdGti      Decimal (7),
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sPrenom Varchar(35),
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @sNumTelProd  VarChar ( 20 ),
  @iIdEts 	Integer,
  @iOptionDP    Integer,
  @sBoiteMail   VarChar (35),
  @sAdrLigne1	VarChar ( 35 ),
  @sAdrLigne2	VarChar ( 35 ),		
  @sAdrLigne3	VarChar ( 35 ),
  @sCP		VarChar ( 35 ),
  @sVille	VarChar ( 35 ),
  @iVarianteMail Integer,
  @sValCarDetPro VarChar ( 100 ),
  @sMtTtcCmde	Varchar(35),
  @sMtValPublique	Varchar(35),
  @sTypApp 	VarChar ( 3 ),
  @sMarqueRempl VarChar ( 35 ),
  @sModeleRempl VarChar ( 35 ),
  @sIdRefFour   VarChar ( 35 ),
  @sMarqueSin VarChar ( 35 ),
  @sModeleSin VarChar ( 35 ),
  @sXMLVar     	VarChar ( 2000 ),
  @sDteSurv		VarChar ( 15 ),
  @sDteAchPort		VarChar ( 15 ),
  @sAdresseFacturation Varchar(255), 
  @sCodeBoutique VarChar ( 5 ),
  @sTelBoutique Varchar(20),  
  @sMailBoutique Varchar(255),  
  @sMailEmetteur Varchar(255)
  
  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @iRet = 0
  Set @asIdAppli = Upper ( @asIdAppli )
  Set @sTypApp = ''
  Select @sAdresseFacturation='SPB Mobistore Assurance Téléphonie Mobile 76095 LE HAVRE CEDEX',
	@sMailEmetteur='assurancemobistore@spb.fr' -- TODO : à revoir
  

  -- Option de déclenchement du mail -DP
  Set @iOptionDP = 51 -- TODO : affecter la DP

  -- [PM103][1]	
  If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
   Begin
	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
	Return 0
   End
  -- :[PM103][1]


  -- Récupération des données standard nécessaires à l'envoi du mail
  
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL_XML
		@iIdSin,
		@iOptionDP,
		@dcIdProd   OUTPUT,
		@sLibProd   OUTPUT,
		@dcIdEts    OUTPUT,
		@sNumProd   OUTPUT,
		@sCiv	    OUTPUT,
		@sNom	    OUTPUT,
		@sMailFrom  OUTPUT,
		@sMailSend  OUTPUT,
		@sMailCc    OUTPUT,
		@sAltQuarant OUTPUT,
		@sBoiteMail  OUTPUT,
		@sXMLVar     OUTPUT
	
  
  -- Cas de retour n'étant pas des erreurs
  If @iRet < 0 and @iRet <> -7
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

  -- On mémorise la zone val_car de det_pro -- TODO : est-ce utile ?
  Select @sValCarDetPro = IsNull ( dp.val_car, '' )
  From   sysadm.det_pro dp
  Where  dp.id_prod = @dcIdProd
  and    dp.id_typ_code_dp = '-DP' 
  and    dp.id_code_dp = @iOptionDP 

  Select @sDteSurv = CONVERT ( VarChar ( 10 ), ws.dte_surv, 103 ),
	@sDteAchPort =  CONVERT ( VarChar ( 10 ), ws.dte_ach_port, 103 ),
	@sMarqueSin = IsNull ( sysadm.FN_TRIM ( ws.marq_port ), ''), 
	@sModeleSin=IsNull ( sysadm.FN_TRIM ( ws.modl_port ), ''),
	@sTelBoutique=IsNull ( sysadm.FN_TRIM ( b.adr_tel),''),
	@sMailBoutique=IsNull ( sysadm.FN_TRIM ( b.adr_mail),''),
	@sCodeBoutique=IsNull ( sysadm.FN_TRIM ( b.cod_mag),''),
	@sNumTelProd=IsNull ( sysadm.FN_TRIM ( p.num_tel),'')
  From   sysadm.w_sin ws,
		 sysadm.boutique b,
		 sysadm.produit p
  Where  ws.id_sin = @adcIdSin
	And b.id_prod = ws.id_prod
   	And b.id_boutique = ws.id_orian_boutique
    And p.id_prod = ws.id_prod
   	
  If @sDteSurv is null Set @sDteSurv = ''
  If @sDteAchPort is null Set @sDteSurv = ''

  Select  @sIdRefFour = c.id_ref_four, -- #5 [DCMP080202]
	 @dcIdGti = c.id_gti,
	 @dcIdDetail = c.id_detail,
	 @sMarqueRempl = IsNull ( sysadm.FN_TRIM ( c.id_marq_art ), '') , 
	 @sModeleRempl = IsNull ( sysadm.FN_TRIM ( c.id_modl_art ), ''),
	 @sMtTtcCmde=IsNull ( Convert ( VarChar ( 15), c.mt_ttc_cmde ), '0.00' ),
	 @sNom=IsNull ( sysadm.FN_TRIM ( c.adr_nom ), ''),
	 @sPrenom=IsNull ( sysadm.FN_TRIM ( c.adr_prenom ), ''),
	 @sAdrLigne1=IsNull ( sysadm.FN_TRIM ( c.adr_livr1 ), ''),
	 @sAdrLigne2=IsNull ( sysadm.FN_TRIM (
 c.adr_livr2 ), ''),
	 @sAdrLigne3=IsNull ( sysadm.FN_TRIM ( c.adr_livr_cpl ), ''),
	 @sCP=IsNull ( sysadm.FN_TRIM ( c.adr_cp ), ''),
	 @sVille=IsNull ( sysadm.FN_TRIM ( c.adr_ville ), ''),
	 @sTypApp=c.id_typ_art
  From   sysadm.w_commande c
  Where  c.id_sin = @adcIdSin
	and c.id_seq=@aiIdSeq

  -- On récupère la variante du mail (1,2,3...)
  Select @iVarianteMail = Case @sTypApp
  				When 'TEL' Then 1
  				When 'CAF' Then 2
  				When 'AEF' Then 3
  				Else 4 -- Nomade
  			  End

  
   Select  @sMtValPublique=IsNull ( Convert ( VarChar ( 15), wd.mt_val_publique ), '0.00' )
   From    sysadm.w_detail wd
   Where   wd.id_sin = @adcIdSin
   And     wd.id_gti = @dcIdGti 
   And     wd.id_detail = @dcIdDetail

--------------------------------------------------------------------------------------------------------------------
-- Construction du mail.
--------------------------------------------------------------------------------------------------------------------
  
  -- Mail Send
 Set @sMailSend =@sMailBoutique
	
	Select @sMailObjet = Case @iVarianteMail
		When 1 Then 
			'AIG SPB_CONVERLANCE_ASSURANCE_N°' + Convert ( Varchar ( 10 ), @adcIdSin ) + ' (Proposition de remplacement Téléphone)'
		When 2 Then 
			'AIG SPB_CONVERLANCE_ASSURANCE_N°' + Convert
 ( Varchar ( 10 ), @adcIdSin ) + ' (Choix remplacement)'
		When 3 Then 
			'AIG SPB_CONVERLANCE_ASSURANCE_N°' + Convert ( Varchar ( 10 ), @adcIdSin ) + ' (Diagnostic/Expertise)'
		Else
			'AIG SPB_CONVERLANCE_ASSURANCE_N°' + Convert ( Varchar ( 10 ), @adcIdSin ) + ' (Proposition de remplacement Nomade)'
		End
			
	-- Armement du corps du mail
	Set @sXMLVar = @sXMLVar + '<boutique code_boutique="' + @sCodeBoutique + '" '
	Set @sXMLVar = @sXMLVar + 'num_tel="' + @sTelBoutique + '" '
	Set @sXMLVar = @sXMLVar + 'adr_mail="' + @sMailBoutique + '"/>'
	
	Set @sXMLVar = @sXMLVar + '<sinistre adresse_facturation="' + @sAdresseFacturation + '" '
	Set @sXMLVar = @sXMLVar + 'dte_surv="' + @sDteSurv + '" '
	Set @sXMLVar = @sXMLVar + 'dte_achat="' + @sDteAchPort + '" '

	Set @sXMLVar = @sXMLVar + 'mt_val_publique="' + @sMtValPublique + '" '
	Set @sXMLVar = @sXMLVar + 'marque_sin="' + @sMarqueSin + '" '
	Set @sXMLVar = @sXMLVar + 'modele_sin="' + @sModeleSin + '"/>'
	
	Set @sXMLVar = @sXMLVar + '<commande ref_fournisseur="' + @sIdRefFour + '" '
	Set @sXMLVar = @sXMLVar + 'mt_ttc_cmde="' + @sMtTtcCmde + '" '
	Set @sXMLVar = @sXMLVar + 'marque_rempl="' + @sMarqueRempl + '" '
	Set @sXMLVar = @sXMLVar + 'modele_rempl="' + @sModeleRempl + '" '
	Set @sXMLVar = @sXMLVar + 'nom_assure="' + @sNom + '" '
	Set @sXMLVar = @sXMLVar + 'prenom_assure="' + @sPrenom + '" '
	Set @sXMLVar = @sXMLVar + 'adr_client1="' + @sAdrLigne1 + '" '
	Set @sXMLVar = @sXMLVar + 'adr_client2="' + @sAdrLigne2 + '" '
	Set @sXMLVar = @sXMLVar + 'adr_client3="' + @sAdrLigne3 + '" '
	Set @sXMLVar = @sXMLVar + 'code_postal="' + @sCP + '" '
	Set @sXMLVar = @sXMLVar + 'ville="' + @sVille + '"/> '
	
	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	Set @sAltQuarant = 'N'

	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin
	       Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V01 
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sMailFrom,
			@sMailSend,
			@sMailCc,
			@sMailObjet,
			'Corps du mail construit par KSL',
			@sAltQuarant,
			@sBoiteMail,
			'M17',
			2,
			'KSL',
			-1,
			@sXMLVar

	   End    -- TRACE_MAIL_PRO : Fin écriture

	Else

	 Begin
		 Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V01 
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sMailFrom,
			@sMailSend,
			@sMailCc,
			@sMailObjet,
			'Corps du mail construit par KSL',
			@sAltQuarant,
			@sBoiteMail,
			'M17', -- TODO : à changer + ajouter la variante mail
			2,
			'KSL',
			-1,
			@sXMLVar
	 End	
  
  
  Return 0
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I02_MAILPUSH
-- Auteur               :       FPI
-- Date                 :       12/06/2012
-- Libelle              :
-- Commentaires         :       Envoi vers du mail vers TRACE_MAIL.
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
-- JFF 14/10/2013 [VDOC12443]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I02_MAILPUSH' AND type = 'P' )
        DROP procedure sysadm.PS_I02_MAILPUSH
GO

CREATE procedure sysadm.PS_I02_MAILPUSH
	@adcIdSin      	Decimal (10), -- [PI062]
	@asBase		varchar (20),
	@asMailFrom	VarChar (128), 
	@asMailSend	VarChar (128), 
	@asMailCc	VarChar (128), 
	@asMailCci	VarChar (128), 
	@asMailObjet	VarChar ( 255 ),
  	@asMailBody	VarChar ( 7000 ),
	@asBoiteMail    VarChar ( 35 ),
	@asTypMail	VarChar ( 10),
	@aiIdAppli	Integer,
	@asMethode varchar(6),
	@aiIdArch	Integer,
	@asXMLData Varchar(2000)
AS

  Declare @iRet		Integer
 
  If @asBoiteMail='' Set @asBoiteMail=@asMailFrom
  
  Exec @iRet = sysadm.PS_I02_MAILPUSH_V01
	@adcIdSin,
	@asBase,
	@asMailFrom, 
	@asMailSend, 
	@asMailCc, 
	@asMailCci, 
	@asMailObjet,
  	@asMailBody,
	@asBoiteMail,
	@asTypMail,
	@aiIdAppli,
	'KSL', -- ald @asMethode [ITSM266837]
	'PM191', -- [VDOC12443]
	@aiIdArch,
	@asXMLData

 Return @iRet

Go

grant execute on sysadm.PS_I02_MAILPUSH to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I02_MAILPUSH_V01
-- Auteur               :       FPI
-- Date                 :       12/06/2012
-- Libelle              :
-- Commentaires         :       Envoi vers du mail vers TRACE_MAIL.
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
-- JFF 14/10/2013 [VDOC12443]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I02_MAILPUSH_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I02_MAILPUSH_V01
GO

CREATE procedure sysadm.PS_I02_MAILPUSH_V01
	@adcIdSin      	Decimal (10), -- [PI062]
	@asBase		varchar (20),
	@asMailFrom	VarChar (128), 
	@asMailSend	VarChar (128), 
	@asMailCc	VarChar (128), 
	@asMailCci	VarChar (128), 
	@asMailObjet	VarChar ( 255 ),
  	@asMailBody	VarChar ( 7000 ),
	@asBoiteMail    VarChar ( 35 ),
	@asTypMail	VarChar ( 10),
	@aiIdAppli	Integer,
	@asMethode varchar(6),
	@asMethodeKSL varchar(50), -- [VDOC12443]
	@aiIdArch	Integer,
	@asXMLData Varchar(2000)
AS
Declare 
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @sLibProd	VarChar ( 35 ),
  @iRet		Integer


  -- [PM103][1]	
  If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
   Begin
	Return 0
   End
  -- :[PM103][1]


  Set    @iIdSin  = Convert ( integer, @adcIdSin )
  Set    @asBoiteMail = Upper ( @asBoiteMail )
  Set 	 @asTypMail   = Upper ( @asTypMail )
  
  Select @iIdProd  = Convert ( integer, id_prod ),
	 @sLibProd = sysadm.FN_LIB_PROD ( id_prod ),
	 @iIdEts   = Convert ( integer, id_ets )
  From   sysadm.w_sin ws
  where  ws.id_sin = @adcIdSin

  -- [PC469] - mail de refus
  If @@ROWCOUNT = 0 
  Begin
   Select @iIdProd  = Convert ( integer, id_prod ),
	 @sLibProd = sysadm.FN_LIB_PROD ( id_prod ),
	 @iIdEts   = Convert ( integer, id_ets )
	From   sysadm.sinistre s
	where  s.id_sin = @adcIdSin
  End
  
  -- Sommes-nous sur un serveur de production ?
  If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
    If Upper ( Right ( sysadm.FN_TRIM ( @asBase) , 4 ) ) <> '_PRO' Return -20


  If @@servername = master.dbo.SPB_FN_ServerName ('PRO')

   Begin  -- TRACE_MAIL_PRO : Début écriture

	  Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V02
		'SIMPA2',
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	    @asMailFrom, 
		@asMailSend, 
		@asMailCc, 
		@asMailCci, 
		@asMailObjet,
		@asMailBody,
		'N',
        @asBoiteMail,
        @asTypMail,
        @aiIdAppli,
		@asMethode,
		@asMethodeKSL, -- [VDOC12443]
		@aiIdArch,
		@asXMLData


   End    -- TRACE_MAIL_PRO : Fin écriture

  Else

   Begin  -- TRACE_MAIL_TRT : Début écriture

	  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V02 
		'SIMPA2',
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	    @asMailFrom, 
		@asMailSend, 
		@asMailCc, 
		@asMailCci, 
		@asMailObjet,
		@asMailBody,
		'N',
	    @asBoiteMail,
	    @asTypMail,
	    @aiIdAppli,
		@asMethode,
		@asMethodeKSL, -- [VDOC12443]
		@aiIdArch,
		@asXMLData

   End    -- TRACE_MAIL_TRT : Fin écriture

  -- Problème suite éxécution
  If @iRet <> 0 Return -20

  Return 0

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_TRT_MAIL_CMD
-- Auteur               :       FPI
-- Date                 :       04/07/2012
-- Libelle              :		[DT011]
-- Commentaires         :       Renvoie le trigramme du dernier valideur de commande d'un dossier
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_TRT_MAIL_CMD' AND type = 'P' )
        DROP procedure sysadm.PS_S_TRT_MAIL_CMD
GO

CREATE procedure sysadm.PS_S_TRT_MAIL_CMD
  @iIdSeq		Integer ,     --  l’id_seq de mail_push
  @dcIdSin	Decimal (10,0),  -- [PI062] --  Le numéro du sinistre
  @sCodOper	VarChar ( 4 ) OUTPUT -- Le trigramme
AS

  Select top 1 @sCodOper = maj_par
  From sysadm.commande
  Where id_sin=@dcIdSin
  order by id_seq desc
  
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S15_MAILPUSH_DIAGOK_ASSURE
-- Auteur               :       FPI
-- Date                 :       04/07/2012
-- Libelle              :		[DT011]
-- Commentaires         :       Envoie le mail ou SMS de diag OK à l'assuré pour qu'il rappelle
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       0 si rien n'est parti, 1 un mail/sms parti, autre = erreur
--
--       JFF    26/11/2012  [PC877]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S15_MAILPUSH_DIAGOK_ASSURE' AND type = 'P' )
        DROP procedure sysadm.PS_S15_MAILPUSH_DIAGOK_ASSURE
GO


CREATE procedure sysadm.PS_S15_MAILPUSH_DIAGOK_ASSURE
  @adcIdSin	Decimal (10,0), -- [PI062]--  Le numéro du sinistre
  @aiIdSeq		Integer ,     --  l’id_seq de la commande
  @asIdFour	Varchar(3),
  @aiStatusGc	Integer
		
As

	Declare  @nb 	Integer,
		@sNumSmsPort Varchar(25),
		@sAdrMail Varchar(120),
		@iRet	Integer,
		@sLogin 	VarChar ( 10 ),  
		@sMdPasse 	VarChar ( 10 ), 
		@sSmsBody	VarChar(255),
		@sCodeTrt	Varchar(10),
		@sBase		Varchar(20),
		@sNumTelProd	Varchar(20),
		@dcIdProd 	Decimal(7,0),
		@iIdProd	integer,
		@sLibProd	Varchar(60),
		@iIdSin 	integer,
		@iIdEts 	integer,
		@dcIdEts	Decimal(7,0),
		@sBoiteMail   VarChar (35),
		@sMailFrom	VarChar (128), 
		@sMailSend	VarChar (128), 
		@sMailCc	VarChar (128),
		@sMailObjet	VarChar ( 255 ),
		@sMailBody	VarChar ( 7000 ),
		@sSaut	VarChar (10), 
		@sCasRetour	Varchar(255),
		@sTypeApp	Varchar(255),
		@sVal   VarChar ( 255 )
  
		
		
  	Set @iRet=0
	Set @sBase = DB_NAME(db_id())
	Set @sMailFrom = 'noreply@spb.eu'
	Set @sMailCc = ''
	Set @sSaut = Char (10)
  	
	
	-- Exclusions
	Select @nb=Count(*)
	From sysadm.sinistre s
	Inner Join sysadm.det_pro d on s.id_prod=d.id_prod
	Where s.id_sin=@adcIdSin and id_code_dp=214
	
	If @nb = 0 Return 0
	
	If @asIdFour <> 'O2M' or @aiStatusGc not in (151,179) Return 0
		
	If @aiStatusGc = 179
	Begin
		select @nb=count(*)
		From sysadm.commande 
		where id_sin=@adcIdSin 
			and status_gc in(151,171)
			and id_four='SB1'
			
		If @nb = 0 Return 0
	End 
	
	-- Récupération de l'adresse mail & num_portable, et autres
	Select @sAdrMail=IsNull(i.adr_mail,''),
		   @sNumSmsPort=Case When i.num_port_sms is not null Then i.num_port_sms
				When i.num_teld is not null Then i.num_teld
				Else s.num_port End,
			@sNumTelProd = RTrim(p.num_tel),
			@dcIdProd = s.id_prod,
			@sLibProd = RTrim(sysadm.FN_LIB_PROD(s.id_prod)),
			@dcIdEts = s.id_ets,
			@sBoiteMail=sysadm.FN_CLE_VAL('BOITE_MAIL',dp.val_car,';'),
			@sTypeApp = Rtrim(dp2.val_car)
	From sysadm.sinistre s
	Inner join sysadm.inter i on s.id_sin=i.id_sin
	Inner join sysadm.produit p on p.id_prod=s.id_prod
	Inner join sysadm.det_pro dp on dp.id_prod=s.id_prod
	Inner join sysadm.div_sin d on s.id_sin=d.id_sin
	Inner join sysadm.det_pro dp2 on s.id_prod=dp2.id_prod and dp2.id_code_car=d.val_car
	where s.id_sin=@adcIdSin 
		and i.cod_inter='A' 
		and d.nom_zone='type_app' 
		and dp.id_code_dp=214
		and dp2.id_code_dp=106
	
	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	
	If @sAdrMail<> ''
	Begin
	
		Set @sMailObjet = @sLibProd + ' - Retour de diagnostic'
		
		Set @sMailBody = 'Nous vous informons de la réception par nos services du résultat de diagnostic de votre ' + @sTypeApp + '.' + @sSaut
		Set @sMailBody = @sMailBody + @sSaut
		
		Set @sMailBody = @sMailBody + 'Afin de poursuivre l’instruction de votre dossier, nous vous remercions de bien vouloir nous contacter au plus tôt 48h après réception de ce mail au : ' + @sNumTelProd + '. '
		
		Set @sMailBody = @sMailBody + 'Vous pouvez nous joindre du lundi au samedi, de 9h00 à 20h00.' + @sSaut
		Set @sMailBody = @sMailBody + @sSaut
		Set @sMailBody = @sMailBody + 'Cordialement' + @sSaut
		Set @sMailBody = @sMailBody + @sSaut
		Set @sMailBody = @sMailBody + 'Votre gestionnaire' + @sSaut
		Set @sMailBody = @sMailBody + @sSaut
		Set @sMailBody = @sMailBody + @sSaut
		Set @sMailBody = @sMailBody + '*Numéro facturé au prix d’une communication locale, régionale ou nationale, selon les offres de chaque opérateur'
		
		
		If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
		Begin  -- TRACE_MAIL_PRO : Début écriture

			Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
				'SIMPA2',
				@iIdSin, 
				@iIdProd, 
				@sLibProd, 
				@iIdEts, 
				@sMailFrom, 
				@sAdrMail, 
				@sMailCc,
				@sMailObjet,
				@sMailBody,
				'N',
				@sBoiteMail, 
				'M21',
				2 		

			-- Problème suite éxécution
			If @iRet <> 0 Return -20
			
			Set @iRet=1
		End    -- TRACE_MAIL_PRO : Fin écriture
		Else
		Begin  -- TRACE_MAIL_TRT : Début écriture

		 Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sAdrMail, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'M21', 
			2 

		End    -- TRACE_MAIL_TRT : Fin écriture

		-- Problème suite éxécution
		If @iRet <> 0 Return -20

		Set @iRet=1
	End 
	Else
	Begin 
	
		
		If @sNumSmsPort is Null Return 0
		
		Set @sLogin   = 'spbCD'
		Set @sMdPasse = 'i3m2i2d2'
		Set @sCodeTrt = 'NETSIZE'

		-- [PC877]
		
		Select @sVal = IsNull ( rtrim ( d.val_car ), '')
		From   sysadm.det_pro d
		Where  d.id_prod = @dcIdProd
		And    d.id_code_dp = 228
		
		If @sVal is null Set @sVal = ''
		Set @sSmsBody = rtrim ( @sVal )
		
		If Right ( rTrim ( @sSmsBody ), 1 ) <> '.' 
		  Begin 
		    Set @sSmsBody = @sSmsBody + '.'
		  End
		
		
/* Laideur totale ! la 228 pilote tout ça maintenant
		Set @sSmsBody= Case When @dcIdProd between 41100 and 41199 Then 'Auchan PC. '
			When @dcIdProd between 41000 and 41099 Then 'Auchan TV/Vidéo. '
			When @dcIdProd between 46000 and 46099 Then 'Auchan Tablette Tactile. '
			When @dcIdProd between 32400 and 32499 Then 'Auchan PEM. '
			When @dcIdProd between 45100 and 45199 Then 'Auchan Nomade. '
			Else ''
				End
*/
		
		Set @sSmsBody=@sSmsBody + 'Nous avons reçu le diagnostic de votre appareil. Merci de nous contacter au plus tôt sous 48h au ' + @sNumTelProd + ' lundi au samedi 9h/20h.'
		
		Set @sSmsBody = Right ( @sSmsBody, 160 )
		  
		If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
		Begin  -- TRACE_MAIL_PRO : Début écriture

			Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_SMS_PUSH_V00 
				'SIMPA2',
				@iIdSin, 
				@iIdProd, 
				@sLibProd, 
				@iIdEts, 
				@sNumSmsPort,
				@sLogin,
				@sMdPasse,
        		@sSmsBody,
				@sCodeTrt,
				'M21', 
				2

		End    -- TRACE_MAIL_PRO : Fin écriture
		Else
		Begin  -- TRACE_MAIL_TRT : Début écriture

			Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_SMS_PUSH_V00 
				'SIMPA2',
				@iIdSin, 
				@iIdProd, 
				@sLibProd, 
				@iIdEts, 
				@sNumSmsPort,
				@sLogin,
				@sMdPasse,
        		@sSmsBody,
				@sCodeTrt,
				'M21', 
				2

		End    -- TRACE_MAIL_TRT : Fin écriture

		If @iRet = 0 Set @iRet=1
	End
	
	Return @iRet
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S16_MAILPUSH_ORANGE_REUNION
-- Auteur               :       FPI 
-- Date                 :       21/08/2012
-- Libelle              :		[PC767]
-- Commentaires         :       ENvoi de mail d'envoi en réparation à Orange Réunion pour l'assuré
--
-- References           :
--
-- Arguments            :      
--				@adcIdSin       Decimal (  7,0 )        (Val)
--				@aiIdSeq	Integer		        (Val)
--				@asCasRetour Varchar(50)
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S16_MAILPUSH_ORANGE_REUNION' AND type = 'P' )
        DROP procedure sysadm.PS_S16_MAILPUSH_ORANGE_REUNION
GO


CREATE procedure sysadm.PS_S16_MAILPUSH_ORANGE_REUNION
	@adcIdSin      	Decimal (10), -- [PI062]
	@aiIdSeq 	Integer,
 	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sPrenom Varchar(35),
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @sNumTelProd  VarChar ( 20 ),
  @iIdEts 	Integer,
  @iOptionDP    Integer,
  @sBoiteMail   VarChar (35),
  @sMarqueRempl VarChar ( 35 ),
  @sModeleRempl VarChar ( 35 ),
  @sDteSurv		VarChar ( 15 ),
  @sSaut	Varchar(2) ,
  @sAltSuiviSMS VarChar ( 1 ),  
  @sNumGsmSMS   VarChar ( 20 ),
  @sBase	Varchar(100)
 
  
  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @iRet = 0
  Set @sSaut = Char (10)
  Set @sBase=DB_NAME() 
  
  -- Option de déclenchement du mail -DP
  Set @iOptionDP = 217

  -- [PM103][1]	
  If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
   Begin
	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
	Return 0
   End
  -- :[PM103][1]

  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@sBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
        @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT,  
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #3
	@sAltSuiviSMS OUTPUT, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  
  -- Cas de retour n'étant pas des erreurs
  If @iRet < 0 and @iRet <> -7
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

  Select @sDteSurv = CONVERT ( VarChar ( 10 ), ws.dte_surv, 103 ),
	 @sMarqueRempl = IsNull ( sysadm.FN_TRIM ( c.id_marq_art ), '') , 
	 @sModeleRempl = IsNull ( sysadm.FN_TRIM ( c.id_modl_art ), '')
	
  From   sysadm.w_sin ws
		 INNER Join sysadm.w_commande c on c.id_sin=ws.id_sin
  Where  ws.id_sin = @adcIdSin
	And c.id_seq=@aiIdSeq
  
--------------------------------------------------------------------------------------------------------------------
-- Construction du mail.
--------------------------------------------------------------------------------------------------------------------
  If @sNom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sNom + ','
   End 

 	Set @sMailObjet = 'Votre dossier n°' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) + ' ' + @sLibProd -- [PI062]
	
	Set @sMailBody=@sCiv + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	
	Set @sMailBody=@sMailBody + 'A la suite de votre déclaration de sinistre du ' + @sDteSurv
	Set @sMailBody=@sMailBody + ', vous pouvez bénéficier d''une réparation de votre ' + @sMarqueRempl + ' ' + @sModeleRempl
	Set @sMailBody=@sMailBody + ' auprès du SAV Orange Réunion.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Merci d''envoyer votre appareil, ' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + '- avec sa batterie' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + '- sans carte SIM ni carte Mémoire' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'par le biais d''un colissimo de la Poste adapté à la taille de celui-ci, à l''adresse suivante : ' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'SPB – Centre de réparation Orange Réunion' + @sSaut
	Set @sMailBody=@sMailBody + '1er étage – Option assurance mobile' + @sSaut
	Set @sMailBody=@sMailBody + '112 rue Jean chatel' + @sSaut
	Set @sMailBody=@sMailBody + '97 400 St Denis' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Veuillez indiquer obligatoirement sur votre colis et à l''intérieur de celui-ci :' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Le n° de Référence SPB : N° de dossier' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Nous vous informons que les données stockées sur votre appareil seront systématiquement effacées lors de l''intervention du technicien.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + '****************************************************************' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + '****************************************************************' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	
	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	Set @sAltQuarant = 'N'

	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin
	     Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
				'SIMPA2',
				@iIdSin, 
				@iIdProd, 
				@sLibProd, 
				@iIdEts, 
				@sMailFrom, 
				@sMailSend, 
				@sMailCc,
				@sMailObjet,
				@sMailBody,
				'N',
				@sBoiteMail, 
				'M22',
				2 

	   End    -- TRACE_MAIL_PRO : Fin écriture

	Else
	 Begin
		  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'M22', 
			2 
	 End	
  
  
  Return 0
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S17_MAILPUSH_ORE_CTL_IMEI
-- Auteur               :       FPI 
-- Date                 :       21/08/2012
-- Libelle              :		[PC767] / [PC864] [PC920_PRIXTEL] utilisé aussi pour PRIXTEL !!!
-- Commentaires         :       ENvoi de mail de contrôle IMEI
--
-- References           :
--
-- Arguments            :      
--				@adcIdSin       Decimal (  7,0 )        (Val)
--
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      02/01/2018   [PC874-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S17_MAILPUSH_ORE_CTL_IMEI' AND type = 'P' )
        DROP procedure sysadm.PS_S17_MAILPUSH_ORE_CTL_IMEI
GO


CREATE procedure sysadm.PS_S17_MAILPUSH_ORE_CTL_IMEI
	@adcIdSin      	Decimal (10), -- [PI062]
	@aiOptionDP		integer
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sPrenom Varchar(35),
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @sNumTelProd  VarChar ( 20 ),
  @iIdEts 	Integer,
  @sBoiteMail   VarChar (35),
  @sNumImeiPort VarChar ( 35 ),
  @sNumPort VarChar ( 35 ),
  @sDteSurv		VarChar ( 15 ),
  @sSaut	Varchar(2) ,
  @sAltSuiviSMS VarChar ( 1 ),  
  @sNumGsmSMS   VarChar ( 20 ),
  @asCasRetour  varchar (255),
  @iCptDmde		integer,
  @sBase	Varchar(100)
  
  Set @sMailBody = ''
  Set @iRet = 0
  Set @sSaut = Char (10)
  set @sBase=DB_NAME() 
  
   -- [PM103][1]	
  If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
   Begin
	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
	Return 0
   End
  -- :[PM103][1]

   Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@sBase,
 	@aiOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT,  
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #3
	@sAltSuiviSMS OUTPUT, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  
  -- Cas de retour n'étant pas des erreurs
  If @iRet < 0 and @iRet <> -7
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End
   
  Set @iCptDmde=NULL
  
  Select @sMailSend=sysadm.FN_CLE_VAL('ADR_MAIL_IMEI',rtrim( d.val_car ) + rtrim( d.val_car2 ),';'),
    @sMailCc =sysadm.FN_CLE_VAL('ADR_MAIL_IMEI_CC',rtrim( d.val_car ) + rtrim( d.val_car2 ),';'), -- [PC874-1]
	@sNumImeiPort=s.num_imei_port,
	@sNumPort=s.num_port,
	@iCptDmde=ds.val_nbre,
	@sDteSurv=Convert(varchar(10),s.dte_surv,103)
  From sysadm.w_sin s
	inner join sysadm.det_pro d on s.id_prod=d.id_prod
	left outer join sysadm.w_div_sin ds on ds.id_sin=s.id_sin and ds.nom_zone='cra_cpt_dmde'
  Where s.id_sin=@adcIdSin
	and d.id_code_dp=@aiOptionDP
  
  If @@RowCount =0 -- [ITSM219270]
  Begin
	   Select @sMailSend=sysadm.FN_CLE_VAL('ADR_MAIL_IMEI',rtrim( d.val_car ) + rtrim( d.val_car2 ),';'),
	    @sMailCc =sysadm.FN_CLE_VAL('ADR_MAIL_IMEI_CC',rtrim( d.val_car ) + rtrim( d.val_car2 ),';'), -- [PC874-1]
		@sNumImeiPort=s.num_imei_port,
		@sNumPort=s.num_port,
		@iCptDmde=ds.val_nbre,
		@sDteSurv=Convert(varchar(10),s.dte_surv,103)
	  From sysadm.sinistre s
		inner join sysadm.det_pro d on s.id_prod=d.id_prod
		left outer join sysadm.div_sin ds on ds.id_sin=s.id_sin and ds.nom_zone='cra_cpt_dmde'
	  Where s.id_sin=@adcIdSin
		and d.id_code_dp=@aiOptionDP
   End
  
--------------------------------------------------------------------------------------------------------------------
-- Construction du mail.
--------------------------------------------------------------------------------------------------------------------
  If @sNom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sNom + ','
   End 

 	Set @sMailObjet = 'Demande de Contrôle IMEI - Dossier n°' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) + '– '-- [PI062]
	If @aiOptionDP = 217 Set @sMailObjet =  @sMailObjet + 'ORANGE REUNION'
	If @aiOptionDP = 218 Set @sMailObjet =  @sMailObjet + 'Garantie OUTREMER TELECOM Téléphonie Mobile '
	
	Set @sMailBody='Bonjour,' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Suite à la déclaration de sinistre de ' + @sCiv + ' nous vous remercions d’effectuer le contrôle IMEI.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	
	Set @sMailBody=@sMailBody + 'Veuillez trouver ci-dessous les informations nécessaires pour nous communiquer la dernière date d''utilisation '
	Set @sMailBody=@sMailBody + 'de la ligne assurée avec l''appareil sinistré déclaré:' + @sSaut
	Set @sMailBody=@sMailBody + '- N° de ligne assuré : ' + IsNull(@sNumPort,'') + @sSaut
	Set @sMailBody=@sMailBody + '- N° IMEI de l''appareil sinistré : ' + IsNull(@sNumImeiPort,'') + @sSaut
	
	If @aiOptionDP = 218 Set @sMailBody=@sMailBody + '- Date de survenance du sinistre : ' + @sDteSurv + @sSaut
	
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, nos salutations distinguées.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + '****************************************************************' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + '****************************************************************' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
		
	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	Set @sAltQuarant = 'N'

	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin
	     Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
				'SIMPA2',
				@iIdSin, 
				@iIdProd, 
				@sLibProd, 
				@iIdEts, 
				@sMailFrom, 
				@sMailSend, 
				@sMailCc,
				@sMailObjet,
				@sMailBody,
				'N',
				@sBoiteMail, 
				'M23',
				2 

	   End    -- TRACE_MAIL_PRO : Fin écriture

	Else
	 Begin
		  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'M23', 
			2 
	 End	
  
  -- maj des compteurs
  update sysadm.w_div_sin set val_car='N' where id_sin=@adcIdSin and nom_zone='cra_ctrl_imei'
  update sysadm.div_sin set val_car='N' where id_sin=@adcIdSin and nom_zone='cra_ctrl_imei'
 
  If @iCptDmde is null
  Begin
    INSERT	sysadm.div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_nbre, cree_le, maj_le, maj_par, valide_le, valide_par )
		SELECT	@adcIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N', dp.cpt_tri, 0, GETDATE(), GETDATE(), 'SQL', GETDATE(), 'SQL'
		FROM	sysadm.div_pro dp
		WHERE	dp.id_prod	=	@iIdProd
			AND	dp.nom_zone	in ('cra_cpt_dmde','cra_dat_gen', 'cra_suivi_imei' )
			And not exists (select * from sysadm.div_sin d where d.id_sin=@adcIdSin and d.nom_zone=dp.nom_zone)
			
	INSERT	sysadm.w_div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_nbre, cpt_valide, cree_le, maj_le, maj_par )
		SELECT	@adcIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N', dp.cpt_tri, 0, 1, GETDATE(), GETDATE(), 'SQL'
		FROM	div_pro dp
		WHERE	dp.id_prod	=	@iIdProd
			AND	dp.nom_zone	in ('cra_cpt_dmde','cra_dat_gen', 'cra_suivi_imei' )
			And not exists (select * from sysadm.w_div_sin d where d.id_sin=@adcIdSin and d.nom_zone=dp.nom_zone)
			And exists (select * from sysadm.w_sin where id_sin=@adcIdSin)
			
  End
  
  update sysadm.w_div_sin set val_dte=GETDATE() where id_sin=@adcIdSin and nom_zone='cra_dat_gen'
  update sysadm.div_sin set val_dte=GETDATE() where id_sin=@adcIdSin and nom_zone='cra_dat_gen'
  update sysadm.w_div_sin set val_nbre=val_nbre + 1 where id_sin=@adcIdSin and nom_zone='cra_cpt_dmde'
  update sysadm.div_sin set val_nbre=val_nbre + 1 where id_sin=@adcIdSin and nom_zone='cra_cpt_dmde'

 
  Return @iRet

Go

grant execute on sysadm.PS_S17_MAILPUSH_ORE_CTL_IMEI to rolebddsinistres
go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S18_MAILPUSH_OUTREMER_TELECOM
-- Auteur               :       FPI 
-- Date                 :       21/08/2012
-- Libelle              :		[PC767]
-- Commentaires         :       ENvoi de mail de commande Outremer Telecom
--
-- References           :
--
-- Arguments            :      
--				@adcIdSin       Decimal (  7,0 )        (Val)
--				@aiIdSeq	Integer		        (Val)
--				@asCasRetour Varchar(50)
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      26/11/2018   [PC874_2_V1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S18_MAILPUSH_OUTREMER_TELECOM' AND type = 'P' )
        DROP procedure sysadm.PS_S18_MAILPUSH_OUTREMER_TELECOM
GO


CREATE procedure sysadm.PS_S18_MAILPUSH_OUTREMER_TELECOM
	@adcIdSin      	Decimal (10), -- [PI062]
	@aiIdSeq 	Integer,
	@asMtIndemn	Varchar(20),
 	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sPrenom Varchar(35),
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailSendCompl VarChar (128), -- [PC874_2_V1]
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @sNumTelProd  VarChar ( 20 ),
  @iIdEts 	Integer,
  @iOptionDP    Integer,
  @sBoiteMail   VarChar (35),
  @sMarqueRempl VarChar ( 35 ),
  @sModeleRempl VarChar ( 35 ),
  @sSaut	Varchar(2) ,
  @sAltSuiviSMS VarChar ( 1 ),  
  @sNumGsmSMS   VarChar ( 20 ),
  @sBase	Varchar(100)
  
  
  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @iRet = 0
  Set @sSaut = Char (10)
  set @sBase=DB_NAME()
   
  -- Option de déclenchement du mail -DP
  Set @iOptionDP = 218

  -- [PM103][1]	
  If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
   Begin
	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
	Return 0
   End
  -- :[PM103][1]

  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@sBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT,  
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #3
	@sAltSuiviSMS OUTPUT, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  
  -- Cas de retour n'étant pas des erreurs
  If @iRet < 0 and @iRet <> -7
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

  Select @sMarqueRempl = IsNull ( sysadm.FN_TRIM ( ws.marq_port ), '') , 
		@sModeleRempl = IsNull ( sysadm.FN_TRIM ( ws.modl_port ), ''),
		@sMailSend=sysadm.FN_CLE_VAL('ADR_MAIL_CMD',dp.val_car,';'),
		@sMailSendCompl=sysadm.FN_CLE_VAL('ADR_MAIL_CMD2',dp.val_car,';')
  From   sysadm.w_sin ws
		 INNER Join sysadm.w_commande c on c.id_sin=ws.id_sin
		 INNER join sysadm.det_pro dp on dp.id_prod=ws.id_prod
  Where  ws.id_sin = @adcIdSin
	And c.id_seq=@aiIdSeq
	And dp.id_code_dp=@iOptionDP
  
-- [PC874_2_V1]
If @dcIdEts in ( 1004, 1005 ) 
 Begin
	Set @sMailSend = @sMailSend + ',' + @sMailSendCompl
 End 


--------------------------------------------------------------------------------------------------------------------
-- Construction du mail.
--------------------------------------------------------------------------------------------------------------------
  If @sNom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sNom 
   End 

 	Set @sMailObjet = 'Prise en charge - Dossier n°' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) + ' ' + @sLibProd -- [PI062]
	
	Set @sMailBody='Bonjour,' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	
	Set @sMailBody=@sMailBody + 'Nous vous informons de la prise en charge du dossier de ' + @sCiv + '.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	
	Set @sMailBody=@sMailBody + 'Le client se présentera dans un point de vente accompagné de son courrier de prise en charge afin d’effectuer le remplacement de son appareil sinistré.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	
	Set @sMailBody=@sMailBody + 'Veuillez trouver ci-dessous les renseignements vous permettant d’effectuer le remplacement :' + @sSaut
	Set @sMailBody=@sMailBody + '-	Marque et modèle de l’appareil sinistré : ' + @sMarqueRempl + ' ' + @sModeleRempl + @sSaut
	Set @sMailBody=@sMailBody + '-	Montant maximum d’indemnisation : ' + @asMtIndemn + @sSaut
	Set @sMailBody=@sMailBody + '-	Validité : 3 mois à compter de la date du présent courrier.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, nos salutations distinguées.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + '****************************************************************' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + '****************************************************************' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	
	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	Set @sAltQuarant = 'N'

	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin
	     Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
				'SIMPA2',
				@iIdSin, 
				@iIdProd, 
				@sLibProd, 
				@iIdEts, 
				@sMailFrom, 
				@sMailSend, 
				@sMailCc,
				@sMailObjet,
				@sMailBody,
				'N',
				@sBoiteMail, 
				'M24',
				2 

	   End    -- TRACE_MAIL_PRO : Fin écriture

	Else
	 Begin
		  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'M24', 
			2 
	 End	
  
  
  Return 0
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S19_MAILPUSH_SAV_OUTREMER_TELECOM
-- Auteur               :       FPI 
-- Date                 :       23/11/2012
-- Libelle              :		[PC874]
-- Commentaires         :       ENvoi de mail d'envoi en réparation à Outremer Telecom
--
-- References           :
--
-- Arguments            :      
--				@adcIdSin       Decimal (  7,0 )        (Val)
--				@aiIdSeq	Integer		        (Val)
--				@asCasRetour Varchar(50)
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S19_MAILPUSH_SAV_OUTREMER_TELECOM' AND type = 'P' )
        DROP procedure sysadm.PS_S19_MAILPUSH_SAV_OUTREMER_TELECOM
GO

CREATE procedure sysadm.PS_S19_MAILPUSH_SAV_OUTREMER_TELECOM
	@adcIdSin      	Decimal (10), -- [PI062]
	@aiIdSeq 	Integer,
	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sPrenom Varchar(35),
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @dcIdGti Decimal(7),
  @sNumTelProd  VarChar ( 20 ),
  @iIdEts 	Integer,
  @iOptionDP    Integer,
  @sBoiteMail   VarChar (35),
  @sMarque VarChar ( 35 ),
  @sModele VarChar ( 35 ),
  @sNumImei VarChar ( 60 ),
  @sSaut	Varchar(2) ,
  @sAltSuiviSMS VarChar ( 1 ),  
  @sNumGsmSMS   VarChar ( 20 ),
  @sBase	Varchar(100)
 
  
  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @iRet = 0
  Set @sSaut = Char (10)
  set @sBase=DB_NAME()
  
  -- Option de déclenchement du mail -DP
  Set @iOptionDP = 218

  -- [PM103][1]	
  If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
   Begin
	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
	Return 0
   End
  -- :[PM103][1]

  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@sBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT,  
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #3
	@sAltSuiviSMS OUTPUT, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  
  -- Cas de retour n'étant pas des erreurs
  If @iRet < 0 and @iRet <> -7
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

  Select @sMarque = IsNull ( sysadm.FN_TRIM ( ws.marq_port ), '') , 
	 @sModele = IsNull ( sysadm.FN_TRIM ( ws.modl_port ), ''),
	 @sNumImei = IsNull ( sysadm.FN_TRIM ( ws.num_imei_port ), '') , 
		@sMailSend=sysadm.FN_CLE_VAL('ADR_MAIL_PRS',rtrim( dp.val_car) + rtrim ( val_car2) ,';'),
		@dcIdGti=c.id_gti
  From   sysadm.w_sin ws
		 INNER Join sysadm.w_commande c on c.id_sin=ws.id_sin
		 INNER join sysadm.det_pro dp on dp.id_prod=ws.id_prod
  Where  ws.id_sin = @adcIdSin
	And c.id_seq=@aiIdSeq
	And dp.id_code_dp=@iOptionDP
  
--------------------------------------------------------------------------------------------------------------------
-- Construction du mail.
--------------------------------------------------------------------------------------------------------------------
  If @sNom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sNom 
   End 

 	Set @sMailObjet = 'Demande de réparation - Dossier n°' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) + '/' + @sNom + ' Assurance OUTREMER TELECOM' -- [PI062]
	
	Set @sMailBody='Bonjour,' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	
	Set @sMailBody=@sMailBody + 'Nous vous informons de la déclaration de sinistre de ' + @sCiv + ' concernant le dommage / l''oxydation de son appareil :' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	
	Set @sMailBody=@sMailBody + '- Marque : ' + @sMarque + @sSaut
	Set @sMailBody=@sMailBody + '- Modèle : ' + @sModele + @sSaut
	Set @sMailBody=@sMailBody + '- IMEI : ' + @sNumImei + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Nous avons demandé à l’Assuré  le dépôt de son appareil auprès de vos services.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'A réception de celui-ci, nous vous remercions de nous adresser le diagnostic de l''appareil ainsi que la confirmation de la marque, du modèle et du n° IMEI.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, nos salutations distinguées.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + '****************************************************************' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + '****************************************************************' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.' + @sSaut

	
	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	Set @sAltQuarant = 'N'

	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin
	     Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
				'SIMPA2',
				@iIdSin, 
				@iIdProd, 
				@sLibProd, 
				@iIdEts, 
				@sMailFrom, 
				@sMailSend, 
				@sMailCc,
				@sMailObjet,
				@sMailBody,
				'N',
				@sBoiteMail, 
				'M25',
				2 

	   End    -- TRACE_MAIL_PRO : Fin écriture

	Else
	 Begin
		  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'M25', 
			2 
	 End	
  
  
  Return 0
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_ENVOI_MAILPUSH_SMS_PSM_1
-- Auteur               :       Fabry JF
-- Date                 :       05/12/2012
-- Libelle              :	[PC877]
-- Commentaires         :       
--
-- References           :
--
-- Arguments            :       @asIdAppli	varchar (20)		(val) Nom de l'application mère éxécutant la PS
--				@asBase		varchar (20)		(val) Nom de la base de données SHERPA ou SIMPA2
--				@adcIdSin       Decimal (  7,0 )        (Val)
--				@aiIdSeq 	int			(Val) Identifiant de commande
--				@asCasRetour    VarChar (50)		(ref) Cas : MAIL_ENVOYE
--										    OPTION_DP_NON_PARAM
--										    HORS_BASE_DE_PRODUCTION
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
--      JFF   23/05/2012 [PM103][1]
--	   FPI 13/09/2012 [VDOC8537] Allongement de la colonne id_bon_transp de 20 à 35
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_ENVOI_MAILPUSH_SMS_PSM_1' AND type = 'P' )
        DROP procedure sysadm.PS_ENVOI_MAILPUSH_SMS_PSM_1
GO

CREATE procedure sysadm.PS_ENVOI_MAILPUSH_SMS_PSM_1
	@asIdAppli	varchar (20),
	@asBase		varchar (20),
	@adcIdSin      	Decimal (10),  -- [PI062]
	@aiIdSeq 	int,
	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @sSaut	VarChar (10), 
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @iOptionDP    Integer,
  @sBoiteMail   VarChar (35),
  @sMarque	VarChar (35),
  @sLibApp	VarChar (255),
  @sIdBonTrsp	Varchar (35), -- [VDOC8537]
  @sAltSuiviSMS VarChar ( 1 ),  
  @sNumGsmSMS   VarChar ( 20 ),
  @sLogin 	VarChar ( 10 ),  
  @sMdPasse 	VarChar ( 10 ), 
  @sCodeTrt 	VarChar ( 10 ), 
  @sSmsBody	VarChar(255),
  @sVal VarChar(255)
  
  Declare @sIdCanal	Varchar(2) 	
  Declare @sEMail	 	varchar(60)	
  Declare @sIdentifiant 	varchar(60)	
  Declare @sCasRetour    VarChar (50)

  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  Set @asIdAppli = Upper ( @asIdAppli )

  Set @iOptionDP = 229
  
  -- [PM103][1]	
  If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
   Begin
	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
	Return 0
   End
  -- :[PM103][1]
  
  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@asBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
        @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT, 
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, 
	@sAltSuiviSMS OUTPUT,
	@sNumGsmSMS  OUTPUT 
	
	
  -- Cas de retour n'étant pas des erreurs
  If @iRet in ( -9, -10 )
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

   -- L'absence d'adresse email n'est pas une erreur car envoi sms
   If @iRet in (-7,-11) Set @iRet = 0

   -- Absence de mail & tel gsm
   If @sMailSend Is Null Set @sMailSend=''
   Else Set @sMailSend = sysadm.FN_TRIM ( @sMailSend )
   
   If @sNumGsmSMS Is Null Set @sNumGsmSMS=''
   Else Set @sNumGsmSMS = sysadm.FN_TRIM ( @sNumGsmSMS)
   
   If @sMailSend='' and @sNumGsmSMS=''  return 0
   
   -- Problème suite éxécution
  If @iRet <> 0 Return @iRet

  If @sMailSend <> ''
  Begin
	 --------------------------------------------------------------------------------------------------------------------
	 -- Armement de l'objet du mail
	Set @sMailObjet = 'Dossier de sinistre SPB n°' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 7 ) + Convert ( VarChar, @adcIdSin ), 7 ) ) + ' ' + @sLibProd  

	 --------------------------------------------------------------------------------------------------------------------
	 -- Corps du mail
	Set @sCiv = @sCiv + ' ' + @sNom

	Set @sMailBody  = @sMailBody  + @sCiv 
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	
	Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer que votre appareil réparé est disponible dès aujourd''hui dans votre point PSM.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous vous en souhaitons d''avance bonne réception.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
	  
	  --------------------------------------------------------------------------------------------------------------------
	 -- Pied du mail
	  
	 Set @sMailBody  = @sMailBody  + @sSaut
	 Set @sMailBody  = @sMailBody  + @sSaut
	 Set @sMailBody  = @sMailBody  + @sSaut
	 Set @sMailBody  = @sMailBody  + '****************************************************************'
	 Set @sMailBody  = @sMailBody  + @sSaut
	 Set @sMailBody  = @sMailBody  + 'Ce message vous est délivré automatiquement. Merci de ne pas y répondre.'
	 Set @sMailBody  = @sMailBody  + @sSaut
	 Set @sMailBody  = @sMailBody  + '****************************************************************'
	 Set @sMailBody  = @sMailBody  + @sSaut
	 Set @sMailBody  = @sMailBody  + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'


	 -- On convertit pour l'appel de la PS
	 Set @iIdSin  = Convert ( integer, @adcIdSin )
	 Set @iIdProd = Convert ( integer, @dcIdProd )
	 Set @iIdEts  = Convert ( integer, @dcIdEts )

	 If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	   Begin  -- TRACE_MAIL_PRO : Début écriture
		  Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
			@asIdAppli,
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			@sAltQuarant,
			@sBoiteMail, 
			'M25',
			2 

	   End    -- TRACE_MAIL_PRO : Fin écriture

	  Else

	   Begin  -- TRACE_MAIL_TRT : Début écriture
		  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			@asIdAppli,
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			@sAltQuarant,
			@sBoiteMail, 
			'M25', 
			2 

	   End    -- TRACE_MAIL_TRT : Fin écriture
	End
	 
	If @sAltSuiviSMS='O'
	Begin

		Select @sVal = IsNull ( sysadm.FN_TRIM ( d.val_car ), '')
		From   sysadm.det_pro d
		Where  d.id_prod = @dcIdProd
		And    d.id_code_dp = 228 -- [PC877] 228 ald 66

		If @sVal is null Or sysadm.FN_TRIM (@sVal) = '' Set @sVal = ''
		If Len ( @sVal ) > 0 Set @sVal = @sVal + '.'

		-- SMS
		Set @sSmsBody= @sVal + 'Votre appareil réparé est disponible dès aujourd''hui dans votre point PSM.'
		
		-- On convertit pour l'appel de la PS
		Set @iIdSin  = Convert ( integer, @adcIdSin )
		Set @iIdProd = Convert ( integer, @dcIdProd )
		Set @iIdEts  = Convert ( integer, @dcIdEts )
		
		-- Param lié à la variante
		Set @sLogin   = 'spbCD'
		Set @sMdPasse = 'i3m2i2d2'
		Set @sCodeTrt = 'NETSIZE'
	 
		If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
		Begin  -- TRACE_MAIL_PRO : Début écriture
			Exec TRACE_MAIL_PRO.sysadm.PS_I01_SMS_PUSH_V00 
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sNumGsmSMS,
			@sLogin,
			@sMdPasse,
			@sSmsBody,
			@sCodeTrt,
			'M25', 
			2
		End
		Else
		Begin
		Exec TRACE_MAIL_TRT.sysadm.PS_I01_SMS_PUSH_V00 
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sNumGsmSMS,
			@sLogin,
			@sMdPasse,
			@sSmsBody,
			@sCodeTrt,
			'M25', 
			2		
		End
	End

  -- Problème suite éxécution
  If @iRet <> 0 Return -20

  -- Fin de traitement
  Set @asCasRetour = 'MAIL_ENVOYE'
  Return 0

Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_MAILPUSH_PTL_CTL_IMEI
-- Auteur               :       JFF
-- Date                 :       08/04/2012
-- Libelle              :		[PC920_PRIXTEL]
-- Commentaires         :       ENvoi de mail de contrôle IMEI
--
-- References           :
--
-- Arguments            :      
--				@adcIdSin       Decimal (  7,0 )        (Val)
--
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MAILPUSH_PTL_CTL_IMEI' AND type = 'P' )
        DROP procedure sysadm.PS_S_MAILPUSH_PTL_CTL_IMEI
GO


CREATE procedure sysadm.PS_S_MAILPUSH_PTL_CTL_IMEI
	@adcIdSin      	Decimal (10), -- [PI062]
	@aiOptionDP		integer
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sPrenom Varchar(35),
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @sNumTelProd  VarChar ( 20 ),
  @iIdEts 	Integer,
  @sBoiteMail   VarChar (35),
  @sNumImeiPort VarChar ( 35 ),
  @sNumPort VarChar ( 35 ),
  @sDteSurv		VarChar ( 15 ),
  @sSaut	Varchar(2) ,
  @sAltSuiviSMS VarChar ( 1 ),  
  @sNumGsmSMS   VarChar ( 20 ),
  @asCasRetour  varchar (255),
  @iCptDmde		integer,
  @sBase	Varchar(100)
  
  Set @sMailBody = ''
  Set @iRet = 0
  Set @sSaut = Char (10)
  set @sBase=DB_NAME()
  
   -- [PM103][1]	
  If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
   Begin
	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
	Return 0
   End
  -- :[PM103][1]

   Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@sBase,
 	@aiOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT,  
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #3
	@sAltSuiviSMS OUTPUT, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  
  -- Cas de retour n'étant pas des erreurs
  If @iRet < 0 and @iRet <> -7
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End
   
  Select @sMailSend=sysadm.FN_CLE_VAL('ADR_MAIL_IMEI',d.val_car,';'),
	@sNumImeiPort=s.num_imei_port,
	@sNumPort=s.num_port,
	@iCptDmde=ds.val_nbre,
	@sDteSurv=convert(varchar(10), s.dte_surv,103)
  From sysadm.w_sin s
	inner join sysadm.det_pro d on s.id_prod=d.id_prod
	left outer join sysadm.w_div_sin ds on ds.id_sin=s.id_sin and ds.nom_zone='cra_cpt_dmde'
  Where s.id_sin=@adcIdSin
	and d.id_code_dp=@aiOptionDP
  
  
--------------------------------------------------------------------------------------------------------------------
-- Construction du mail.
--------------------------------------------------------------------------------------------------------------------
  If @sNom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sNom + ','
   End 

 	Set @sMailObjet = 'Demande de Contrôle IMEI - Dossier n°' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) + '– ' -- [PI062]
	If @aiOptionDP = 217 Set @sMailObjet =  @sMailObjet + 'ORANGE REUNION'
	If @aiOptionDP = 218 Set @sMailObjet =  @sMailObjet + 'Garantie OUTREMER TELECOM Téléphonie Mobile '
	
	Set @sMailBody='Bonjour,' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Suite à la déclaration de sinistre de ' + @sCiv + ' nous vous remercions d’effectuer le contrôle IMEI.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	
	Set @sMailBody=@sMailBody + 'Veuillez trouver ci-dessous les informations nécessaires pour nous communiquer la dernière date d''utilisation '
	Set @sMailBody=@sMailBody + 'de la ligne assurée avec l''appareil sinistré déclaré:' + @sSaut
	Set @sMailBody=@sMailBody + '- N° de ligne assuré : ' + IsNull(@sNumPort,'') + @sSaut
	Set @sMailBody=@sMailBody + '- N° IMEI de l''appareil sinistré : ' + IsNull(@sNumImeiPort,'') + @sSaut
	
	If @aiOptionDP = 218 Set @sMailBody=@sMailBody + '- Date de survenance du sinistre : ' + @sDteSurv + @sSaut
	
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, nos salutations distinguées.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + '****************************************************************' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + '****************************************************************' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
		
	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	Set @sAltQuarant = 'N'

	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin
	     Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
				'SIMPA2',
				@iIdSin, 
				@iIdProd, 
				@sLibProd, 
				@iIdEts, 
				@sMailFrom, 
				@sMailSend, 
				@sMailCc,
				@sMailObjet,
				@sMailBody,
				'N',
				@sBoiteMail, 
				'M23',
				2 

	   End    -- TRACE_MAIL_PRO : Fin écriture

	Else
	 Begin
		  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'M23', 
			2 
	 End	
  
  -- maj des compteurs
  update sysadm.w_div_sin set val_car='N' where id_sin=@adcIdSin and nom_zone='cra_ctrl_imei'
  update sysadm.div_sin set val_car='N' where id_sin=@adcIdSin and nom_zone='cra_ctrl_imei'
 
  If @iCptDmde is null
  Begin
    INSERT	sysadm.div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_nbre, cree_le, maj_le, maj_par, valide_le, valide_par )
		SELECT	@adcIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N', dp.cpt_tri, 0, GETDATE(), GETDATE(), 'SQL', GETDATE(), 'SQL'
		FROM	sysadm.div_pro dp
		WHERE	dp.id_prod	=	@iIdProd
			AND	dp.nom_zone	in ('cra_cpt_dmde','cra_dat_gen')
			
	INSERT	sysadm.w_div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_nbre, cpt_valide, cree_le, maj_le, maj_par )
		SELECT	@adcIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N', dp.cpt_tri, 0, 1, GETDATE(), GETDATE(), 'SQL'
		FROM	div_pro dp
		WHERE	dp.id_prod	=	@iIdProd
			AND	dp.nom_zone	in ('cra_cpt_dmde','cra_dat_gen')
			
  End
  
  update sysadm.w_div_sin set val_dte=GETDATE() where id_sin=@adcIdSin and nom_zone='cra_dat_gen'
  update sysadm.div_sin set val_dte=GETDATE() where id_sin=@adcIdSin and nom_zone='cra_dat_gen'
  update sysadm.w_div_sin set val_nbre=val_nbre + 1 where id_sin=@adcIdSin and nom_zone='cra_cpt_dmde'
  update sysadm.div_sin set val_nbre=val_nbre + 1 where id_sin=@adcIdSin and nom_zone='cra_cpt_dmde'
  
  
  Return @iRet
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S20_MAILPUSH_OOP_CTL_IMEI
-- Auteur               :       FPI 
-- Date                 :       22/04/2013
-- Libelle              :		[PC472-1]
-- Commentaires         :       ENvoi de mail de contrôle IMEI
--
-- References           :
--
-- Arguments            :      
--				@adcIdSin       Decimal (  7,0 )        (Val)
--
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-- JFF 21/06/2013 [PC946_ORANGE_OPPRO][V4]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S20_MAILPUSH_OOP_CTL_IMEI' AND type = 'P' )
        DROP procedure sysadm.PS_S20_MAILPUSH_OOP_CTL_IMEI
GO


CREATE procedure sysadm.PS_S20_MAILPUSH_OOP_CTL_IMEI
	@adcIdSin      	Decimal (10) -- [PI062]
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sPrenom Varchar(35),
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @sNumTelProd  VarChar ( 20 ),
  @iIdEts 	Integer,
  @sBoiteMail   VarChar (35),
  @sNumImeiPort VarChar ( 35 ),
  @sNumPort VarChar ( 35 ),
  @sDteSurv		VarChar ( 15 ),
  @sDteAdh		VarChar ( 15 ),
  @sSaut	Varchar(2) ,
  @sAltSuiviSMS VarChar ( 1 ),  
  @sNumGsmSMS   VarChar ( 20 ),
  @asCasRetour  varchar (255),
  @iCptDmde		integer,
  @iOptionDP		integer,
  @sBase	Varchar(100)
  
  Set @sMailBody = ''
  Set @iRet = 0
  Set @sSaut = Char (10)
  Set @iOptionDP=231
  set @sBase=DB_NAME()
  
   -- [PM103][1]	
  If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
   Begin
	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
	Return 0
   End
  -- :[PM103][1]

   Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@sBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT,  
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #3
	@sAltSuiviSMS OUTPUT, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  
  -- Cas de retour n'étant pas des erreurs
  If @iRet < 0 and @iRet <> -7
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End
   
  Select @sMailSend=sysadm.FN_CLE_VAL('ADR_MAIL_IMEI',d.val_car,';'),
	@sNumImeiPort=s.num_imei_port,
	@sNumPort=s.num_port,
	@sDteSurv=convert(varchar(10),s.dte_surv,103),
	@sDteAdh=convert(varchar(10),s.dte_adh,103),
	@iCptDmde=ds.val_nbre
  From sysadm.w_sin s
	inner join sysadm.det_pro d on s.id_prod=d.id_prod
	left outer join sysadm.w_div_sin ds on ds.id_sin=s.id_sin and ds.nom_zone='cra_cpt_dmde'
  Where s.id_sin=@adcIdSin
	and d.id_code_dp=@iOptionDP
  
  If @@rowCount=0 Return 0 -- [ITSM164268] dossier clos : on n'envoie pas de mail
--------------------------------------------------------------------------------------------------------------------
-- Construction du mail.
--------------------------------------------------------------------------------------------------------------------
	Select @sCiv = sysadm.FN_TRIM ( IsNull ( sysadm.FN_CODE_NUM ( sysadm.FN_TRIM (p.cod_civ), '-CI' ), '' )),
		 @sNom = sysadm.SPB_FN_INIT_CAP
				     (
				     sysadm.FN_TRIM ( IsNull ( Upper ( Left  ( sysadm.FN_TRIM ( p.nom ), 1) ), '' )) +
				     sysadm.FN_TRIM ( IsNull ( Lower ( Right ( sysadm.FN_TRIM ( p.nom ), Len ( p.nom ) - 1 ) ), '' )),
				     null
				     ),
		@sPrenom=Case When Len ( p.prenom ) <= 1 Then sysadm.FN_TRIM(p.prenom)
				Else sysadm.SPB_FN_INIT_CAP
				     (
				     sysadm.FN_TRIM ( IsNull ( Upper ( Left  ( sysadm.FN_TRIM ( p.prenom ), 1) ), '' )) +
				     sysadm.FN_TRIM ( IsNull ( Lower ( Right ( sysadm.FN_TRIM ( p.prenom ), Len ( p.prenom ) - 1 ) ), '' )),
				     null
				     ) End
	  From   sysadm.sinistre s,
		 sysadm.personne p
	  Where  s.id_sin = @adcIdSin
	  and    s.id_ordre = p.id_ordre
	  
  If @sNom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sNom
   End 

 If @sPrenom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sPrenom
   End 

 	Set @sMailObjet = 'Contrôle IMEI N° tél ' + sysadm.FN_TRIM ( @sNumPort)
	
	Set @sMailBody='Bonjour,' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Le client ' + @sCiv + ' nous a déclaré un sinistre pour le N° IMEI suivant ' + IsNull(@sNumImeiPort,'') + '.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	
	-- [PC946_ORANGE_OPPRO][V4]
	Set @sMailBody=@sMailBody + 'Nous vous remercions de bien vouloir nous faire un retour sur les points suivants :' + @sSaut
	
	Set @sMailBody=@sMailBody + '- L’assurance Orange Open Pro est mise en place sur la ligne ' + @sNumPort + ' depuis le : ……/……/………   .' + @sSaut
	
	Set @sMailBody=@sMailBody + '- L''IMEI a-t-il été utilisé avec le N° de téléphone '+ IsNull(@sNumPort,'') + ' dans les 30 jours précédant le '	+ @sDteSurv +', date de survenance du sinistre : ' + @sSaut
	Set @sMailBody=@sMailBody + '- date .../..../.... de dernière utilisation.' + @sSaut
	Set @sMailBody=@sMailBody + 'Si cet appareil a fait l''objet d''un SAVEE auprès de vos services, merci de nous indiquer:' + @sSaut
	Set @sMailBody=@sMailBody + '- la date de l''échange SAVEE : .../..../....' + @sSaut
	Set @sMailBody=@sMailBody + '- la marque, modèle et IMEI de l''appareil fourni : ..................  ....................  .......................' + @sSaut
	Set @sMailBody=@sMailBody + '- la marque, modèle et IMEI de l''appareil d''origine : ..................  ....................  .......................' + @sSaut
	Set @sMailBody=@sMailBody + 'Si cet appareil a été volé, merci de nous confirmer la date et l''heure de suspension de la ligne '+ IsNull(@sNumPort,'')  + ' : ' + @sSaut
	Set @sMailBody=@sMailBody + '- date .../..../....  heure  ......h.......' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Vous remerciant par avance de votre retour.' + @sSaut
	Set @sMailBody=@sMailBody + 'Cordialement,' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'L’Assurance Orange Open Pro'
	
	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	Set @sAltQuarant = 'N'

	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin
	     Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
				'SIMPA2',
				@iIdSin, 
				@iIdProd, 
				@sLibProd, 
				@iIdEts, 
				@sMailFrom, 
				@sMailSend, 
				@sMailCc,
				@sMailObjet,
				@sMailBody,
				'N',
				@sBoiteMail, 
				'M26',
				2 

	   End    -- TRACE_MAIL_PRO : Fin écriture

	Else
	 Begin
		  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'M26', 
			2 
	 End	
  
  -- maj des compteurs
  update sysadm.w_div_sin set val_car='N' where id_sin=@adcIdSin and nom_zone='cra_ctrl_imei'
  update sysadm.div_sin set val_car='N' where id_sin=@adcIdSin and nom_zone='cra_ctrl_imei'
 
  If @iCptDmde is null
  Begin
    INSERT	sysadm.div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_nbre, cree_le, maj_le, maj_par, valide_le, valide_par )
		SELECT	@adcIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N', dp.cpt_tri, 0, GETDATE(), GETDATE(), 'SQL', GETDATE(), 'SQL'
		FROM	sysadm.div_pro dp
		WHERE	dp.id_prod	=	@iIdProd
			AND	dp.nom_zone	in ('cra_cpt_dmde','cra_dat_gen', 'cra_suivi_imei' )
			
	INSERT	sysadm.w_div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_nbre, cpt_valide, cree_le, maj_le, maj_par )
		SELECT	@adcIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N', dp.cpt_tri, 0, 1, GETDATE(), GETDATE(), 'SQL'
		FROM	div_pro dp
		WHERE	dp.id_prod	=	@iIdProd
			AND	dp.nom_zone	in ('cra_cpt_dmde','cra_dat_gen', 'cra_suivi_imei' )
			
  End
  
  update sysadm.w_div_sin set val_dte=GETDATE() where id_sin=@adcIdSin and nom_zone='cra_dat_gen'
  update sysadm.div_sin set val_dte=GETDATE() where id_sin=@adcIdSin and nom_zone='cra_dat_gen'
  update sysadm.w_div_sin set val_nbre=val_nbre + 1 where id_sin=@adcIdSin and nom_zone='cra_cpt_dmde'
  update sysadm.div_sin set val_nbre=val_nbre + 1 where id_sin=@adcIdSin and nom_zone='cra_cpt_dmde'

  update sysadm.w_div_sin set val_nbre = 1 where id_sin=@adcIdSin and nom_zone='cra_suivi_imei'
  update sysadm.div_sin set val_nbre = 1 where id_sin=@adcIdSin and nom_zone='cra_suivi_imei'
	 
  
  Return @iRet
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_MAILPUSH_ENV_APP_REMPL
-- Auteur               :       JFF 
-- Date                 :       03/07/2013
-- Libelle              :		[VDOC9908]
-- Commentaires         :       
--
-- References           :
--
-- Arguments            :      
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MAILPUSH_ENV_APP_REMPL' AND type = 'P' )
        DROP procedure sysadm.PS_S_MAILPUSH_ENV_APP_REMPL
GO


CREATE procedure sysadm.PS_S_MAILPUSH_ENV_APP_REMPL
	@asIdAppli	varchar (20),
	@asBase		varchar (20),
	@adcIdSin      	Decimal (10), -- [PI062]
	@aiIdSeq      	Integer,
	@adtDteEnvCli   DateTime,
	@alStatusGc   Integer,
	@asDestCli      VarChar	(35),
	@asCommentFrn  Varchar ( 255 ),
	@asNumBonTrsp   VarChar	(50),
	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @asHREFURL	VarChar (300),		
  @sSaut	VarChar (10), 
  @sMarque	VarChar (35),
  @sModele	VarChar (35),  
  @sCodeEtat	VarChar (10),
  @sIdFour	VarChar (10),
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @iOptionDP    Integer,
  @dtDteEnvCliActuel DateTime,
  @sBoiteMail   VarChar (35),
  @sNomTrsp	VarChar (35), -- #3 [DCMP080399] 
  @sAltSuiviSMS VarChar ( 1 ),  -- #5 [FNAC_PROD_ECH_TECH].[SMS]  
  @sNumGsmSMS   VarChar ( 20 ),  -- #5 [FNAC_PROD_ECH_TECH].[SMS]  
  @iVarianteSMS Integer,
  @sTopSMS	Integer,
  @iLongMaxSMS  Integer,
  @sVal VarChar ( 255 ),
  @sLogin VarChar ( 255 ),
  @sMdPasse VarChar ( 255 ),
  @sCodeTrt VarChar ( 255 ),
  @sSmsBody VarChar ( 255 ),
  @sIdTypArt VarChar ( 3 ),
  @sNomAss VarChar ( 35 ),
  @sPrenomAss VarChar ( 35 ),
  @sAdr1 VarChar ( 35 ),
  @sAdr2 VarChar ( 35 ),
  @sAdrCplt VarChar ( 35 ),
  @sAdrCp VarChar ( 5 ),
  @sAdrVille VarChar ( 35 )



  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @asHREFURL = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  Set @asIdAppli = Upper ( @asIdAppli )
  Set @sTopSMS	= 0 -- [PC877]
  Set @iLongMaxSMS = 160
  Set @iVarianteSMS = 0

  -- Option de déclenchement du mail -DP
  Set @iOptionDP = 50

  If ( @adtDteEnvCli is null ) Or ( @asDestCli is null ) Or ( sysadm.FN_TRIM ( @asDestCli ) = '' )
   Begin
	Set @asCasRetour = 'PARAM_NON_RENSEIGNES'
	Return 0
   End

  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@asBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
        @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT, 
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail OUTPUT, -- #2
	@sAltSuiviSMS OUTPUT, -- #4 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #4 [FNAC_PROD_ECH_TECH].[SMS]



  -- Cas de retour n'étant pas des erreurs
  If @iRet in ( -7, -9, -10 )
   Begin
	Select @asCasRetour =
	Case @iRet
		When -7 Then 'ADRESSE_MAIL_ABSENTE'
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

  -- Problème suite éxécution
  If @iRet <> 0 Return @iRet

  -- Si ce n'est pas un envoi au client, il n'y a pas de mail à envoyer
  If Upper ( sysadm.FN_TRIM ( @asDestCli ) ) <> 'CLIENT'
   Begin
	Set @asCasRetour = 'ENVOI_AUTRE_QUE_CLIENT'
	Return 0
   End

  -- y a-t-il eu déjà un envoi à l'assuré
  Select @dtDteEnvCliActuel = c.dte_env_cli,
	 @sIdFour = c.id_four,
	 @sMarque = IsNull ( sysadm.FN_TRIM ( c.id_marq_art ), ''),
	 @sModele = IsNull ( sysadm.FN_TRIM ( c.id_modl_art ), ''),
	 @sCodeEtat = sysadm.FN_TRIM ( c.cod_etat ),
	 @sNomTrsp  = sysadm.FN_TRIM ( c.adrfc_nom ), -- #3 [DCMP080399] Le nom de transporteur est dans adrfc_nom
	 @sIdTypArt = c.id_typ_art,
	 @sNomAss = c.adr_nom,
	 @sPrenomAss = c.adr_prenom,
	 @sAdr1 = c.adr_livr1,
	 @sAdr2 = c.adr_livr2,
	 @sAdrCplt = c.adr_livr_cpl,
	 @sAdrCp = c.adr_cp,
	 @sAdrVille = c.adr_ville
  From   sysadm.commande c
  Where  c.id_sin = @adcIdSin
  And    c.id_seq = @aiIdSeq

-- [PC938_ORANGE_V3]
  If Upper ( @sIdTypArt ) in ( 'DEV', 'CAF', 'AEF', 'CAS', 'SMS', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'EDI', 'PRS', 'REA' )
   Begin
	Set @asCasRetour = 'TYP_ART_NON_AUTORISE'
	Return 0
   End

  If @adtDteEnvCli is null OR @alStatusGc <> 238 Or CharIndex ( '[INSTANCE]', @asCommentFrn ) = 0 
	Begin
		Set @asCasRetour = 'VALEUR_NON_AUTORISEE'
		Return 0
	End 

   -- La date actuelle lu de la base n'est pas nulle et l'état est différent de RSP, donc le mobile a déjà été envoyé au client.
  If ( @dtDteEnvCliActuel is not null ) And ( @sCodeEtat <> 'RSP' )
   Begin
	Set @asCasRetour = 'MOB_DEJA_ENVOYE'
	Return 0
   End 
 
  -- Gestion de la civilité "Madame, Monsieur"
  If @sNom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sNom + ','
   End 

  -- Armement de l'objet du mail
 Set @sMailObjet = 'Votre dossier n°' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) + ' ' + @sLibProd -- [PI062]

  -- Armement du corps du mail
  Set @sMailBody  = @sMailBody  + @sCiv
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Nous vous informons, dans le cadre de votre dossier de sinistre n°' +  sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) + ', que l''article suivant qui vous a été expédié le ' -- [PI062]
  Set @sMailBody  = @sMailBody  + convert ( varchar(10), @adtDteEnvCli, 103 ) + ' est actuellement en instance dans votre bureau de Poste :' 
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Numéro de dossier : ' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) -- [PI062]
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Marque : ' + @sMarque
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Modèle : ' + @sModele
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Numéro de suivi : ' + @asNumBonTrsp
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Adresse de livraison : '
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + rTrim ( IsNull ( @sPrenomAss, '')) + ' ' +  rTrim ( IsNull ( @sNomAss, '') )
  Set @sMailBody  = @sMailBody  + @sSaut  
  Set @sMailBody  = @sMailBody  + rTrim ( IsNull ( @sAdr1, '' ))
  Set @sMailBody  = @sMailBody  + @sSaut  
  Set @sMailBody  = @sMailBody  + rTrim ( IsNull ( @sAdr2, '' )) + ' ' + rTrim ( IsNull ( @sAdrCplt, '' ) )
  Set @sMailBody  = @sMailBody  + @sSaut  
  Set @sMailBody  = @sMailBody  + rTrim ( IsNull ( @sAdrCp, '' )) + ' ' + rTrim ( IsNull ( @sAdrVille , '' ) )
  Set @sMailBody  = @sMailBody  + @sSaut  
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Attention, vous devez aller retirer votre colis (muni d''une pièce d''identité) dans les 14 jours qui suivent, car au-delà de ce délai, le colis fera automatiquement retour à l''expéditeur.'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'


--------------------------------------------------------------------------------------------------------------------
-- Gestion des SMS.
--------------------------------------------------------------------------------------------------------------------
  If @iVarianteSMS between 1 and 100 -- #5 [FNAC_PROD_ECH_TECH].[SMS]
   Begin
	Set @sTopSMS = 1 

	-- 1/ Confirmation réception appareil en atelier : 
	-- Récup lib produit -DP/66
	Select @sVal = IsNull ( sysadm.FN_TRIM ( d.val_car ), '')
	From   sysadm.det_pro d
	Where  d.id_prod = @dcIdProd
	And    d.id_code_dp = 228 -- [PC877]

	If @sVal is null Or sysadm.FN_TRIM (@sVal) = '' Set @sVal = ''
	If Len ( @sVal ) > 0 Set @sVal = @sVal + '.'

	If @iVarianteSMS = 1
	  Begin
	    Set @sSmsBody = @sVal + 'Bonjour, votre appareil a été envoyé à votre adresse ce jour. Nous vous en souhaitons d’avance bonne réception. SPB'
	  End
   End


  -- On convertit pour l'appel de la PS
  Set @iIdSin  = Convert ( integer, @adcIdSin )
  Set @iIdProd = Convert ( integer, @dcIdProd )
  Set @iIdEts  = Convert ( integer, @dcIdEts )

  If @sTopSMS = 1 
    Begin
	If @iVarianteSMS between 1 and 100
 	  Begin
	   -- Param lié à la variante
		Set @sLogin   = 'spbCD'
		Set @sMdPasse = 'i3m2i2d2'
		Set @sCodeTrt = 'NETSIZE'
	  End 
    End


  If @@servername = master.dbo.SPB_FN_ServerName ('PRO')

   Begin  -- TRACE_MAIL_PRO : Début écriture

	  Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
		@asIdAppli,
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	        @sMailFrom, 
		@sMailSend, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail, --#2
		'M3', -- #2
		2 -- #2		
		
		
          If @sTopSMS = 1 -- [PC877]
            Begin
		  
		  -- Au tout dernier moment avant l'envoi, on tronque par la gauche et on
		  -- ne conserve la partie pertinente sur le droite.
		  Set @sSmsBody = Right ( @sSmsBody, @iLongMaxSMS ) 
		  
		  Exec TRACE_MAIL_PRO.sysadm.PS_I01_SMS_PUSH_V00 
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sNumGsmSMS,
			@sLogin,
			@sMdPasse,
			@sSmsBody,
			@sCodeTrt,
			'M3', 
			2
            End 
		

   End    -- TRACE_MAIL_PRO : Fin écriture

  Else

   Begin  -- TRACE_MAIL_TRT : Début écriture

	  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
		@asIdAppli,
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	        @sMailFrom, 
		@sMailSend, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail, --#2
		'M3', -- #2
		2 -- #2
		
		
          If @sTopSMS = 1 -- [PC877]
            Begin

		  -- Au tout dernier moment avant l'envoi, on tronque par la gauche et on
		  -- ne conserve la partie pertinente sur le droite.
		  Set @sSmsBody = Right ( @sSmsBody, @iLongMaxSMS ) -- #5 [FNAC_PROD_ECH_TECH].[SMS]  


		  Exec TRACE_MAIL_TRT.sysadm.PS_I01_SMS_PUSH_V00 
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sNumGsmSMS,
			@sLogin,
			@sMdPasse,
			@sSmsBody,
			@sCodeTrt,
			'M3', 
			2
	    End

   End    -- TRACE_MAIL_TRT : Fin écriture

  -- Problème suite éxécution
  If @iRet <> 0 Return -20

  -- Fin de traitement
  Set @asCasRetour = 'MAIL_ENVOYE'
  Return 0
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_MAIL_IOS7_VDOC12443
-- Auteur               :       Fabry JF
-- Date                 :       14/10/2013
-- Libelle              :
-- Commentaires         :       
--
-- References           :
--
--   JFF  24/03/2015  [DT139]
--   JFF  05/06/2015  [VDOC17642]
--   JFF  26/01/2016  [VDOC19724]
--   JFF  24/03/2016  [VDOC20329]
--   JFF  12/02/2016   [PI062]
--   JFF  12/02/2018   [DT346]
--   JFF  23/06/2023   Stoppé car n'est plus envoyé depuis la migration SQL 2014 du 01/01/2020
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_MAIL_IOS7_VDOC12443' AND type = 'P' )
        DROP procedure sysadm.PS_I_MAIL_IOS7_VDOC12443
GO

CREATE procedure sysadm.PS_I_MAIL_IOS7_VDOC12443
	@asIdAppli	varchar (20),
	@asBase		varchar (20),
	@aiOptionDP  	Integer,
	@adcIdSin      	Decimal (10) -- [PI062]
AS

Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @dcIdDetail   Decimal (7), -- #4 [SURCOUF_ECH_EXPRESS]
  @dcIdGti      Decimal (7), -- #4 [SURCOUF_ECH_EXPRESS]
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @asHREFURL	VarChar (300),		
  @sSaut	VarChar (10), 
  @sMarque	VarChar (35),
  @sModele	VarChar (35),  
  @sIdFour	VarChar (10),
  @sCodeEtat	VarChar (10),
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @sBoiteMail   VarChar (35),
  @iInfoSpbFrn  Integer, 
  @sIdRefFour   VarChar ( 35 ), 
  @sInfoSpbFrnCplt VarChar ( 255 ), 
  @sXMLVar     	VarChar ( 2000 ), 
  @sTypApp 		VarChar ( 3 ),
  @sProduitOrange VarChar ( 3 ),
  @sMarqPort	VarChar(35),
  @sModlPort	VarChar(35),
  @sImei		Varchar(60),
  @sLibPolice	Varchar(35),
  @sLibCie	Varchar(35),
  @sMajPar	VarChar(4),
  @sEmailProduit Varchar(256),
  @sCivLongue Varchar(35),
  @sClientVip Varchar ( 10 ) -- [DT139]

--   JFF  23/06/2023   Stoppé car n'est plus envoyé depuis la migration SQL 2014 du 01/01/2020  
Return 0   

  Set @sMailBody = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  Set @asIdAppli = Upper ( @asIdAppli )
  Set @sTypApp = '' 

/*
Il y a aura 2 modèles de mail push (paramétré par KSL) : 1 pour les produits Orange et 1 hors Orange 
Prévoir 2 flux vers KSL, 1 pour Orange (codes produit 091XX - 096XX - 962XX) et 1 pour les autres produits. 
*/


	If 	Not Exists ( 
		Select c.info_spb_frn_cplt
		From   sysadm.w_commande c
		Where  c.id_sin = @adcIdSin
		And    c.cod_etat = 'CNV'
		And    sysadm.FN_CLE_VAL ( 'MAIL_IOS7', c.info_spb_frn_cplt, ';' ) = 'OUI'
		)
		Begin
			Return
		End 

	-- Produit Orange ?
	Set @sProduitOrange = 'NON'
	If Exists ( 
			Select	*
			From	sysadm.produit p,
					sysadm.sinistre s
			Where   s.id_sin = @adcIdSin
			And     p.id_prod = s.id_prod
			And		p.id_grp in ( 254, 475 ) )
		Begin
			Set @sProduitOrange = 'OUI'
		End 



	Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL_XML
		@adcIdSin,
		@aiOptionDP,
		@dcIdProd   OUTPUT,
		@sLibProd   OUTPUT,
		@dcIdEts    OUTPUT,
		@sNumProd   OUTPUT,
		@sCiv	    OUTPUT,
		@sNom	    OUTPUT,
		@sMailFrom  OUTPUT,
		@sMailSend  OUTPUT,
		@sMailCc    OUTPUT,
		@sAltQuarant OUTPUT,
		@sBoiteMail  OUTPUT,
		@sXMLVar     OUTPUT


	Select top 1 @sMarqPort=RTrim(IsNull(marq_port,'')),
		@sModlPort=RTrim(IsNull(modl_port,'')),
		@sImei=RTrim(IsNull(num_imei_port,'')),
		@sLibPolice=rtrim(p.lib_police),
		@sLibCie=RTrim(c.lib_cie),
		@sMajPar=Rtrim(s.maj_par),
		@sEmailProduit=IsNull(sysadm.FN_CLE_VAL('ADR_MAIL_PROD',dp.val_car,';') ,''),
		@sCivLongue=sysadm.FN_CODE_NUM(i.cod_civ,'-CL')
	From sysadm.w_sin s
		left outer join sysadm.det_pro dp on dp.id_prod=s.id_prod and dp.id_code_dp=136,
		sysadm.w_inter i,
		sysadm.w_gar_sin wg,
		sysadm.garantie g,
		sysadm.police p,
		sysadm.compagnie c
   Where s.id_sin = @adcIdSin
	And  s.id_sin = wg.id_sin
	And  g.id_prod = s.id_prod
	And  g.id_rev = s.id_rev
	and  g.id_gti = wg.id_gti
	And   p.id_police = g.id_police
	And c.id_cie=p.id_cie
	And i.id_sin=s.id_sin
	And i.cod_inter='A'

	-- [DT139]
	-- [VDOC17642]	 
	Select @sClientVip = rtrim ( ds.val_car )
	From   sysadm.div_sin ds,
		   sysadm.sinistre s,
		   sysadm.det_pro dp 
	Where  ds.id_sin = @adcIdSin
	And	   ds.nom_zone = 'client_vip'
	And	   s.id_sin = ds.id_sin 
	And	   dp.id_prod = s.id_prod
	And    dp.id_code_dp = 272
	
	If @sClientVip is null Set @sClientVip = ''
	
	If @sClientVip In ( 'SEN', 'SEM' ) 
	 Begin
		Set @sMailCc = 'vip@orange.com,franck.bonnard@orange.com'	 -- [VDOC17642]	 
	 End 

	If @sClientVip In ( 'ASN' ) 
	 Begin
		--  [VDOC19724]
		Set @sMailCc = 't.munier@senat.fr,franck.bonnard@orange.com'	-- [VDOC17642]	  
	 End 

	 -- [DT346]
	If @sClientVip In ( 'VIPPAR' ) 
		Begin
			-- le MailSend n'est pas une erreur, on n'envoie rien à l'assuré.
			Set @sMailSend = 'laura.naulot@orange.com,desk@parnasse.fr' -- [DT346]	 
		End 

	
	-- Armement du corps du mail 
	Set @sMailObjet = 'SPB Sinistre numéro ' + Convert ( Varchar ( 10 ), @adcIdSin ) + ' ' + @sLibProd

	-- Armement du corps du mail
	Set @sXMLVar = @sXMLVar + '<courrier '
	Set @sXMLVar = @sXMLVar + 'code_courrier_SIMPA2="MAIL_IOS7_APPLE" '
	Set @sXMLVar = @sXMLVar + 'code_produit="' + Convert ( VarChar ( 15 ), @dcIdProd  ) + '" '
	Set @sXMLVar = @sXMLVar + 'info_pour_EW="joindre un PDF pour envoyer ce mail" '
	Set @sXMLVar = @sXMLVar + 'produit_orange="' + @sProduitOrange + '" '	
	Set @sXMLVar = @sXMLVar + 'code_maquette="MIOS7" '	
	Set @sXMLVar = @sXMLVar + 'nom_produit_cpl="' + @sLibProd + '" '
	Set @sXMLVar = @sXMLVar + 'no_dossier_sinistre ="' + convert(varchar(10), @adcIdSin) + '" ' -- [PI062]
	Set @sXMLVar = @sXMLVar + 'civ="' + @sCivLongue + '" '
	Set @sXMLVar = @sXMLVar + 'email="' + @sMailSend + '" '
	Set @sXMLVar = @sXMLVar + 'app_marque="' + @sMarqPort + '" '
	Set @sXMLVar = @sXMLVar + 'app_modele="' + @sModlPort + '" '
	Set @sXMLVar = @sXMLVar + 'imei="' + @sImei + '" '
	Set @sXMLVar = @sXMLVar + 'police="' + @sLibPolice + '" '
	Set @sXMLVar = @sXMLVar + 'assureur="' + @sLibCie + '" '
	Set @sXMLVar = @sXMLVar + 'maj_par="' + @sMajPar + '" '
	Set @sXMLVar = @sXMLVar + 'email_produit="' + @sEmailProduit + '" '
	Set @sXMLVar = @sXMLVar + '/>'


	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	Set @sAltQuarant = 'N'




	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin
		   Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V02
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sMailFrom,
			@sMailSend,
			@sMailCc,
			null,
			@sMailObjet,
			'Corps du mail construit par KSL',
			@sAltQuarant,
			@sBoiteMail,
			'MIOS7',
			2,
			'KSL',
			'KSL_EDS',
			-1,
			@sXMLVar

	   End    -- TRACE_MAIL_PRO : Fin écriture

	Else
	 Begin
		 Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V02
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sMailFrom,
			@sMailSend,
			@sMailCc,
			null,			
			@sMailObjet,
			'Corps du mail construit par KSL',
			@sAltQuarant,
			@sBoiteMail,
			'MIOS7',
			2,
			'KSL',
			'KSL_EDS',			
			-1,
			@sXMLVar
	 End	
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_MAILPUSH_ADVISE_RN_XA
-- Auteur               :       JFF
-- Date                 :       16/12/2013
-- Libelle              :		[PC947&977]
-- Commentaires         :       Envoi un mail vers Advise si RN & XA
--
-- References           :
--
-- Arguments            :      
--				@adcIdSin       Decimal (  7,0 )        (Val)
--
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-- JFF      12/12/2013   [PC947&977]
-- JFF      12/02/2016   [PI062]
-- JFF      07/11/2016   [PC151259]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MAILPUSH_ADVISE_RN_XA' AND type = 'P' )
        DROP procedure sysadm.PS_S_MAILPUSH_ADVISE_RN_XA
GO


CREATE procedure sysadm.PS_S_MAILPUSH_ADVISE_RN_XA
	@adcIdSin      	Decimal (10), -- [PI062]
	@dcMtReg		Decimal ( 11, 2 ),
	@dcIdReg		Decimal ( 2, 0 )
	
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sPrenom Varchar(35),
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @sNumTelProd  VarChar ( 20 ),
  @iIdEts 	Integer,
  @sBoiteMail   VarChar (35),
  @sNumImeiPort VarChar ( 35 ),
  @sNumPort VarChar ( 35 ),
  @sDteSurv		VarChar ( 15 ),
  @sDteAdh		VarChar ( 15 ),
  @sSaut	Varchar(2) ,
  @sAltSuiviSMS VarChar ( 1 ),  
  @sNumGsmSMS   VarChar ( 20 ),
  @asCasRetour  varchar (255),
  @iCptDmde		integer,
  @iOptionDP		integer,
  @sBase	Varchar(100),
  @sIdContratAbonne VarChar ( 20 ),
  @dcMtFranchise Decimal (11,2 ),
  @sLibFrais VarChar ( 30 ),
  @iRowCount Integer
  
  Set @sMailBody = ''
  Set @iRet = 0
  Set @sSaut = Char (10)
  Set @iOptionDP=252
  set @sBase=DB_NAME()
  
  Set @sLibFrais = '' 

   -- [PM103][1]	
  If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
   Begin
	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
	Return 0
   End
  -- :[PM103][1]

   Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@sBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT,  
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #3
	@sAltSuiviSMS OUTPUT, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  
  -- Cas de retour n'étant pas des erreurs
  If @iRet < 0 and @iRet <> -7
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End
   
  Select Top 1
		 @sMailSend=rtrim ( sysadm.FN_CLE_VAL('ADR_MAIL_ADVISE', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ),';')),
		 @sIdContratAbonne  = IsNull ( rtrim ( s.id_contrat_abonne ), '' ),
		 @sPrenom = IsNull ( rtrim ( s.prenom ), '' ),
		 @sNom = IsNull ( rtrim ( s.nom ), '' ),
		 @dcMtFranchise = dt.mt_fran,
		 @sNumImeiPort=s.num_imei_port
  From sysadm.w_sin s,
       sysadm.det_pro dp,
       sysadm.detail dt
  Where s.id_sin=@adcIdSin
	and dp.id_code_dp=@iOptionDP
	And dp.id_prod = s.id_prod
	And dt.id_sin = s.id_sin
	And dt.id_reg = @dcIdReg
 
 Set @iRowCount = @@rowCount

  -- [PC151259]
If @iRowCount =0 -- (si 0, jointure dt ne ramène rien, donc on essaie le frais)
	Begin
		Select Top 1
				@sMailSend=rtrim ( sysadm.FN_CLE_VAL('ADR_MAIL_ADVISE', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ),';')),
				@sIdContratAbonne  = IsNull ( rtrim ( s.id_contrat_abonne ), '' ),
				@sPrenom = IsNull ( rtrim ( s.prenom ), '' ),
				@sNom = IsNull ( rtrim ( s.nom ), '' ),
				@dcMtFranchise = 0,
				@sLibFrais = '(règlement de Frais)',
				@sNumImeiPort=s.num_imei_port
		From sysadm.w_sin s,
			sysadm.det_pro dp,
			sysadm.frais fr
		Where s.id_sin=@adcIdSin
		and dp.id_code_dp=@iOptionDP
		And dp.id_prod = s.id_prod
		And fr.id_sin = s.id_sin
		And fr.id_reg = @dcIdReg

		Set @iRowCount = @@rowCount

		If @iRowCount =0 Return 0 -- [ITSM164268] dossier clos : on n'envoie pas de mail
	End 
--------------------------------------------------------------------------------------------------------------------
-- Construction du mail.
--------------------------------------------------------------------------------------------------------------------
 	Set @sMailObjet = 'SPB Indemnisation pécuniaire ' + @sLibFrais + ' - ' + @sLibProd + ' - Dossier ' + CONVERT ( VarChar ( 10), @adcIdSin )
	
	Set @sMailBody='Bonjour,' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Merci de procéder au règlement du dossier sinistre ci-dessous.'+ @sSaut
	Set @sMailBody=@sMailBody + @sLibFrais + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	
	Set @sMailBody=@sMailBody + '-  Réf adhésion : ' + @sIdContratAbonne
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + '-  Nom de l''assuré : ' + @sNom
	Set @sMailBody=@sMailBody + @sSaut	
	Set @sMailBody=@sMailBody + '-  Prénom de l''assuré : ' + @sPrenom	
	Set @sMailBody=@sMailBody + @sSaut	
	Set @sMailBody=@sMailBody + '-  Réf dossier de sinistre : ' + CONVERT ( VarChar ( 10), @adcIdSin )
	Set @sMailBody=@sMailBody + @sSaut	
	Set @sMailBody=@sMailBody + '-  Montant du règlement ' + @sLibFrais + ' : ' + Convert ( VarChar ( 20 ), Round(CONVERT(money,@dcMtReg),2)) + ' €'
	Set @sMailBody=@sMailBody + @sSaut	
	Set @sMailBody=@sMailBody + '-  Montant de la Franchise (déduite du montant ci-dessus) : ' + Convert ( VarChar ( 20 ), Round(CONVERT(money, @dcMtFranchise),2))  + ' €'
	Set @sMailBody=@sMailBody + @sSaut	
	Set @sMailBody=@sMailBody + '-  numéro IMEI/Série de l''appareil sinistré : ' + CONVERT ( VarChar ( 20), @sNumImeiPort ) 

	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut

	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer nos salutations distinguées.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + '****************************************************************'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + '****************************************************************'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'

	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	Set @sAltQuarant = 'N'

	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin
	     Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
				'SIMPA2',
				@iIdSin, 
				@iIdProd, 
				@sLibProd, 
				@iIdEts, 
				@sMailFrom, 
				@sMailSend, 
				@sMailCc,
				@sMailObjet,
				@sMailBody,
				'N',
				@sBoiteMail, 
				'ADVRNX',
				2 

	   End    -- TRACE_MAIL_PRO : Fin écriture

	Else
	 Begin
		  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'ADVRNX', 
			2 
	 End	
  
  Return @iRet
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_MAILPUSH_ARR_PLATFORM
-- Auteur               :       JFF 
-- Date                 :       05/05/2014
-- Libelle              :		[PM250-1]
-- Commentaires         :       
--
-- References           :
--
-- Arguments            :      
-- JFF      13/07/2015   [PC151270_ORANGE_V3]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MAILPUSH_ARR_PLATFORM' AND type = 'P' )
        DROP procedure sysadm.PS_S_MAILPUSH_ARR_PLATFORM
GO


CREATE procedure sysadm.PS_S_MAILPUSH_ARR_PLATFORM
	@asIdAppli	varchar (20),
	@asBase		varchar (20),
	@adcIdSin      	Decimal (10), -- [PI062]
	@aiIdSeq      	Integer,
	@adtDteArrPlatForm   DateTime,
	@alStatusGc   Integer,
	@asCommentFrn  Varchar ( 255 ),
	@asNumBonTrsp   VarChar	(50),
	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @asHREFURL	VarChar (300),		
  @sSaut	VarChar (10), 
  @sMarque	VarChar (35),
  @sModele	VarChar (35),  
  @sCodeEtat	VarChar (10),
  @sIdFour	VarChar (10),
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @iOptionDP    Integer,
  @dtDteArrPlatFormActuel DateTime,
  @sBoiteMail   VarChar (35),
  @sNomTrsp	VarChar (35), -- #3 [DCMP080399] 
  @sAltSuiviSMS VarChar ( 1 ),  -- #5 [FNAC_PROD_ECH_TECH].[SMS]  
  @sNumGsmSMS   VarChar ( 20 ),  -- #5 [FNAC_PROD_ECH_TECH].[SMS]  
  @iVarianteSMS Integer,
  @sTopSMS	Integer,
  @iLongMaxSMS  Integer,
  @sVal VarChar ( 255 ),
  @sLogin VarChar ( 255 ),
  @sMdPasse VarChar ( 255 ),
  @sCodeTrt VarChar ( 255 ),
  @sSmsBody VarChar ( 255 ),
  @sIdTypArt VarChar ( 3 ),
  @sNomAss VarChar ( 35 ),
  @sPrenomAss VarChar ( 35 ),
  @sAdr1 VarChar ( 35 ),
  @sAdr2 VarChar ( 35 ),
  @sAdrCplt VarChar ( 35 ),
  @sAdrCp VarChar ( 5 ),
  @sAdrVille VarChar ( 35 ),
  @iOrangeV3 Integer,
  @sInfoSpbFrnCplt VarChar ( 255 )



  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @asHREFURL = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  Set @asIdAppli = Upper ( @asIdAppli )
  Set @sTopSMS	= 0 -- [PC877]
  Set @iLongMaxSMS = 160
  Set @iVarianteSMS = 0

  -- Option de déclenchement du mail -DP
  -- Cette option sert pour un autre déclenchement mais afin de ne pas recreer d'option, je m'appuie sur la même option,
  -- De ce fait, si elle est paramètrée, ce mail partira aussi.
  Set @iOptionDP = 50

  If ( @adtDteArrPlatForm is null Or @adtDteArrPlatForm = '01/01/1900' )
   Begin
	Set @asCasRetour = 'PARAM_NON_RENSEIGNES'
	Return 0
   End

  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@asBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT, 
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail OUTPUT, -- #2
	@sAltSuiviSMS OUTPUT, -- #4 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #4 [FNAC_PROD_ECH_TECH].[SMS]

  If @iRet = -7 
    Begin
		If @iOrangeV3 > 0 
		 Begin
			-- Le but pour Orange V3 et de toujours mettre une adresse mail si l'adresse réél n'est pas là, pour justement
			-- déclencher l'échec de distribution et donc envoyer le courrier en automatique.
			Set @sMailSend = 'DeclEchecDistrib@spb.fr'
			Set @iRet = 0			
		 End
		Else
		 Begin
			 --Set @iRet = 0
			 Set @asCasRetour = 'ADRESSE_MAIL_ABSENTE'
			 Return 0
		 End 
	End

  -- Cas de retour n'étant pas des erreurs
  If @iRet in (-9, -10 )
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

  -- Problème suite éxécution
  If @iRet <> 0 Return @iRet

  -- y a-t-il eu déjà un envoi à l'assuré
  Select @dtDteArrPlatFormActuel = Convert( Datetime, nullif ( sysadm.FN_CLE_VAL ( 'DTE_ARR_PLATFORM', RTRIM ( c.info_frn_spb_cplt), ';' ), '')),
	 @sIdFour = c.id_four,
	 @sMarque = IsNull ( sysadm.FN_TRIM ( c.id_marq_art ), ''),
	 @sModele = IsNull ( sysadm.FN_TRIM ( c.id_modl_art ), ''),
	 @sCodeEtat = sysadm.FN_TRIM ( c.cod_etat ),
	 @sNomTrsp  = sysadm.FN_TRIM ( c.adrfc_nom ), -- #3 [DCMP080399] Le nom de transporteur est dans adrfc_nom
	 @sIdTypArt = c.id_typ_art,
	 @sNomAss = c.adr_nom,
	 @sPrenomAss = c.adr_prenom,
	 @sAdr1 = c.adr_livr1,
	 @sAdr2 = c.adr_livr2,
	 @sAdrCplt = c.adr_livr_cpl,
	 @sAdrCp = c.adr_cp,
	 @sAdrVille = c.adr_ville,
	 @sAltQuarant = Convert ( Varchar (5), c.id_seq), -- [PM250-1]  	
	 @sInfoSpbFrnCplt = c.info_spb_frn_cplt
 
  From   sysadm.commande c
  Where  c.id_sin = @adcIdSin
  And    c.id_seq = @aiIdSeq

	-- [PC151270_ORANGE_V3]
 	Select @iOrangeV3 = COUNT ( * ) 
	From   sysadm.det_pro d,
		   sysadm.sinistre s
	where  s.id_sin = @adcIdSin
	And    d.id_prod = s.id_prod
	And    d.id_code_dp = 94
	And    sysadm.FN_CLE_VAL ( 'COD_DW', rtrim ( val_car ), ';') in ( 'ORANGE_V3', 'ORANGE_V2BIS', 'ORANGE_V3BIS', 'ORANGE_V3TER' )
	
	If @iOrangeV3 is null Set @iOrangeV3 = 0

    If @iOrangeV3 <= 0
      Begin
		Set @asCasRetour = 'NON_PARAM_PRODUIT'
		Return 0
      End
     

-- [PC938_ORANGE_V3]
  If ( @dtDteArrPlatFormActuel is not null ) 
   Begin
	Set @asCasRetour = 'MOB_DEJA_ENVOYE'
	Return 0
   End 
 
  -- Gestion de la civilité "Madame, Monsieur"
  If @sNom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sNom + ','
   End 

  -- Armement de l'objet du mail
 Set @sMailObjet = 'Votre dossier n°' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) + ' ' + @sLibProd -- [PI062]

  -- Armement du corps du mail
  Set @sMailBody  = @sMailBody  + @sCiv
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut

  If @sIdTypArt = 'PRS' And @alStatusGc = 2
	Begin
		Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer que votre appareil ' + @sMarque + ' ' + @sModele + ' a été réparé et se trouve actuellement en cours de livraison.'
	End 
  Else
	Begin

		If @sIdTypArt = 'PST' And Len ( sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', RTRIM( @sInfoSpbFrnCplt ), ';' )) > 0 
		 Begin
			Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer que votre appareil de prêt se trouve actuellement en cours de livraison.'
		 End 
		Else
		 Begin
			Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer que votre appareil ' + @sMarque + ' ' + @sModele + ' se trouve actuellement en cours de livraison.'
		 End 
		
	End 

  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut			
  Set @sMailBody  = @sMailBody  + 'Votre appareil est arrivé sur la plateforme logistique le ' + CONVERT ( Varchar ( 10 ), @adtDteArrPlatForm, 103 )
	
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'

  -- On convertit pour l'appel de la PS
  Set @iIdSin  = Convert ( integer, @adcIdSin )
  Set @iIdProd = Convert ( integer, @dcIdProd )
  Set @iIdEts  = Convert ( integer, @dcIdEts )

  If @@servername = master.dbo.SPB_FN_ServerName ('PRO')

   Begin  -- TRACE_MAIL_PRO : Début écriture

	  Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
		@asIdAppli,
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	        @sMailFrom, 
		@sMailSend, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail, --#2
		'M27', -- #2
		2 -- #2		
		
   End    -- TRACE_MAIL_PRO : Fin écriture

  Else

   Begin  -- TRACE_MAIL_TRT : Début écriture

	  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
		@asIdAppli,
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	    @sMailFrom, 
		@sMailSend, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail, --#2
		'M27', -- #2
		2 -- #2
		
   End    -- TRACE_MAIL_TRT : Fin écriture

  -- Problème suite éxécution
  If @iRet <> 0 Return -20

  -- Fin de traitement
  Set @asCasRetour = 'MAIL_ENVOYE'
  Return 0

Go

grant execute on sysadm.PS_S_MAILPUSH_ARR_PLATFORM to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_MAILPUSH_DEP_CENTRDISTRIB
-- Auteur               :       JFF 
-- Date                 :       05/05/2014
-- Libelle              :		[PM250-1]
-- Commentaires         :       
--
-- References           :
--
-- Arguments            :      
-- JFF      13/07/2015   [PC151270_ORANGE_V3]
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MAILPUSH_DEP_CENTRDISTRIB' AND type = 'P' )
        DROP procedure sysadm.PS_S_MAILPUSH_DEP_CENTRDISTRIB
GO


CREATE procedure sysadm.PS_S_MAILPUSH_DEP_CENTRDISTRIB
	@asIdAppli	varchar (20),
	@asBase		varchar (20),
	@adcIdSin      	Decimal (10), -- [PI062]
	@aiIdSeq      	Integer,
	@adtDteDepCentrDistrib   DateTime,
	@alStatusGc   Integer,
	@asCommentFrn  Varchar ( 255 ),
	@asNumBonTrsp   VarChar	(50),
	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @asHREFURL	VarChar (300),		
  @sSaut	VarChar (10), 
  @sMarque	VarChar (35),
  @sModele	VarChar (35),  
  @sCodeEtat	VarChar (10),
  @sIdFour	VarChar (10),
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @iOptionDP    Integer,
  @dtDteDepCentrDistribActuel DateTime,
  @sBoiteMail   VarChar (35),
  @sNomTrsp	VarChar (35), -- #3 [DCMP080399] 
  @sAltSuiviSMS VarChar ( 1 ),  -- #5 [FNAC_PROD_ECH_TECH].[SMS]  
  @sNumGsmSMS   VarChar ( 20 ),  -- #5 [FNAC_PROD_ECH_TECH].[SMS]  
  @iVarianteSMS Integer,
  @sTopSMS	Integer,
  @iLongMaxSMS  Integer,
  @sVal VarChar ( 255 ),
  @sLogin VarChar ( 255 ),
  @sMdPasse VarChar ( 255 ),
  @sCodeTrt VarChar ( 255 ),
  @sSmsBody VarChar ( 255 ),
  @sIdTypArt VarChar ( 3 ),
  @sNomAss VarChar ( 35 ),
  @sPrenomAss VarChar ( 35 ),
  @sAdr1 VarChar ( 35 ),
  @sAdr2 VarChar ( 35 ),
  @sAdrCplt VarChar ( 35 ),
  @sAdrCp VarChar ( 5 ),
  @sAdrVille VarChar ( 35 ),
  @iOrangeV3 Integer,
  @sInfoSpbFrnCplt VarChar ( 255 )

  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @asHREFURL = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  Set @asIdAppli = Upper ( @asIdAppli )
  Set @sTopSMS	= 0 -- [PC877]
  Set @iLongMaxSMS = 160
  Set @iVarianteSMS = 0

  -- Option de déclenchement du mail -DP
  -- Cette option sert pour un autre déclenchement mais afin de ne pas recreer d'option, je m'appuie sur la même option,
  -- De ce fait, si elle est paramètrée, ce mail partira aussi.
  Set @iOptionDP = 50

  If ( @adtDteDepCentrDistrib is null Or @adtDteDepCentrDistrib = '01/01/1900')
   Begin
	Set @asCasRetour = 'PARAM_NON_RENSEIGNES'
	Return 0
   End

  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@asBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT, 
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail OUTPUT, -- #2
	@sAltSuiviSMS OUTPUT, -- #4 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #4 [FNAC_PROD_ECH_TECH].[SMS]

  If @iRet = -7 
    Begin
		If @iOrangeV3 > 0 
		 Begin
			-- Le but pour Orange V3 et de toujours mettre une adresse mail si l'adresse réél n'est pas là, pour justement
			-- déclencher l'échec de distribution et donc envoyer le courrier en automatique.
			Set @sMailSend = 'DeclEchecDistrib@spb.fr'
			Set @iRet = 0			
		 End
		Else
		 Begin
			 --Set @iRet = 0
			 Set @asCasRetour = 'ADRESSE_MAIL_ABSENTE'
			 Return 0
		 End 
	End

  -- Cas de retour n'étant pas des erreurs
  If @iRet in ( -9, -10 )
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

  -- Problème suite éxécution
  If @iRet <> 0 Return @iRet

  -- y a-t-il eu déjà un envoi à l'assuré
  Select @dtDteDepCentrDistribActuel = Convert( Datetime, nullif ( sysadm.FN_CLE_VAL ( 'DTE_DEP_CENTR_DISTRIB', RTRIM ( c.info_frn_spb_cplt), ';' ), '')),
	 @sIdFour = c.id_four,
	 @sMarque = IsNull ( sysadm.FN_TRIM ( c.id_marq_art ), ''),
	 @sModele = IsNull ( sysadm.FN_TRIM ( c.id_modl_art ), ''),
	 @sCodeEtat = sysadm.FN_TRIM ( c.cod_etat ),
	 @sNomTrsp  = sysadm.FN_TRIM ( c.adrfc_nom ), -- #3 [DCMP080399] Le nom de transporteur est dans adrfc_nom
	 @sIdTypArt = c.id_typ_art,
	 @sNomAss = c.adr_nom,
	 @sPrenomAss = c.adr_prenom,
	 @sAdr1 = c.adr_livr1,
	 @sAdr2 = c.adr_livr2,
	 @sAdrCplt = c.adr_livr_cpl,
	 @sAdrCp = c.adr_cp,
	 @sAdrVille = c.adr_ville,
	 @sAltQuarant = Convert ( Varchar (5), c.id_seq), -- [PM250-1]  	
	 @sInfoSpbFrnCplt = c.info_spb_frn_cplt
  From   sysadm.commande c
  Where  c.id_sin = @adcIdSin
  And    c.id_seq = @aiIdSeq

	-- [PC151270_ORANGE_V3]
 	Select @iOrangeV3 = COUNT ( * ) 
	From   sysadm.det_pro d,
		   sysadm.sinistre s
	where  s.id_sin = @adcIdSin
	And    d.id_prod = s.id_prod
	And    d.id_code_dp = 94
	And    sysadm.FN_CLE_VAL ( 'COD_DW', rtrim ( val_car ), ';') in ( 'ORANGE_V3', 'ORANGE_V2BIS', 'ORANGE_V3BIS', 'ORANGE_V3TER' )
	
	If @iOrangeV3 is null Set @iOrangeV3 = 0

    If @iOrangeV3 <= 0
      Begin
		Set @asCasRetour = 'NON_PARAM_PRODUIT'
		Return 0
      End
     

-- [PC938_ORANGE_V3]
  If ( @dtDteDepCentrDistribActuel is not null ) 
   Begin
	Set @asCasRetour = 'MOB_DEJA_ENVOYE'
	Return 0
   End 
 
  -- Gestion de la civilité "Madame, Monsieur"
  If @sNom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sNom + ','
   End 

  -- Armement de l'objet du mail
 Set @sMailObjet = 'Votre dossier n°' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) + ' ' + @sLibProd -- [PI062]

  -- Armement du corps du mail
  Set @sMailBody  = @sMailBody  + @sCiv
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut

  If @sIdTypArt = 'PRS' And @alStatusGc = 2
	Begin
		Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer que votre appareil ' + @sMarque + ' ' + @sModele + ' a été réparé et se trouve actuellement en cours de livraison.'
	End 
  Else
	Begin
		If @sIdTypArt = 'PST' And Len ( sysadm.FN_CLE_VAL ( 'TYP_APP_PRET', RTRIM( @sInfoSpbFrnCplt ), ';' )) > 0 
		 Begin
			Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer que votre appareil de prêt se trouve actuellement en cours de livraison.'
		 End 
		Else
		 Begin
			Set @sMailBody  = @sMailBody  + 'Nous avons le plaisir de vous informer que votre appareil ' + @sMarque + ' ' + @sModele + ' se trouve actuellement en cours de livraison.'
		 End 	
	End 

  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut			
  Set @sMailBody  = @sMailBody  + 'Votre appareil est parti du centre de distribution le ' + CONVERT ( Varchar ( 10 ), @adtDteDepCentrDistrib, 103 )
	
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + '****************************************************************'
  Set @sMailBody  = @sMailBody  + @sSaut
  Set @sMailBody  = @sMailBody  + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'

  -- On convertit pour l'appel de la PS
  Set @iIdSin  = Convert ( integer, @adcIdSin )
  Set @iIdProd = Convert ( integer, @dcIdProd )
  Set @iIdEts  = Convert ( integer, @dcIdEts )


  If @@servername = master.dbo.SPB_FN_ServerName ('PRO')

   Begin  -- TRACE_MAIL_PRO : Début écriture

	  Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
		@asIdAppli,
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	        @sMailFrom, 
		@sMailSend, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail, --#2
		'M28', -- #2
		2 -- #2		
		
   End    -- TRACE_MAIL_PRO : Fin écriture

  Else

   Begin  -- TRACE_MAIL_TRT : Début écriture

	  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
		@asIdAppli,
		@iIdSin, 
		@iIdProd, 
		@sLibProd, 
		@iIdEts, 
	    @sMailFrom, 
		@sMailSend, 
		@sMailCc,
		@sMailObjet,
		@sMailBody,
		@sAltQuarant,
		@sBoiteMail, --#2
		'M28', -- #2
		2 -- #2
		
   End    -- TRACE_MAIL_TRT : Fin écriture

  -- Problème suite éxécution
  If @iRet <> 0 Return -20

  -- Fin de traitement
  Set @asCasRetour = 'MAIL_ENVOYE'
  Return 0

Go

grant execute on sysadm.PS_S_MAILPUSH_DEP_CENTRDISTRIB to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_MAILPUSH_APP_NON_RECP_EN_CTR
-- Auteur               :       Fabry JF
-- Date                 :       18/08/2014
-- Libelle              :
-- Commentaires         :       
-- References           :		[PM254_V1]
--
-- Arguments            :       
-- Retourne             :       
-------------------------------------------------------------------
-- JFF      13/07/2015   [PC151270_ORANGE_V3]
-- JFF      21/06/2016   [PM284-2]
-- JFF      12/02/2016   [PI062]
-- JFF      28/09/2016   [DT262]
-- JFF      01/02/2016   [DT290]
-- JFF      13/08/2018   [DT364]
-- JFF      26/02/2019   [VDOC27607]
-- JFF      08/04/2019   [DT414] ajout SBE, SRR
-- JFF      10/08/2020   [PM519-1]
-- JFF      22/08/2022   [RS3179_SHUNT_RECLA]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MAILPUSH_APP_NON_RECP_EN_CTR' AND type = 'P' )
        DROP procedure sysadm.PS_S_MAILPUSH_APP_NON_RECP_EN_CTR
GO

CREATE procedure sysadm.PS_S_MAILPUSH_APP_NON_RECP_EN_CTR
AS
DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_sin	decimal (10 ), -- [PI062]
	  id_seq_cmde integer,
	  type_rel  VarChar ( 10 ), -- [DT364]
	  dte_decl  VarChar ( 10 ), -- [DT364]
	  marque varchar ( 35 ),
	  modele varchar ( 35 ),
	  variante  varchar ( 35 ), -- [DT364]
	  proxi      varchar ( 30 ) , -- [DT364]
	  marquage	integer null 
	)

DECLARE @det_pro TABLE 
	( id_seq	integer identity,
	  id_prod	decimal (7 ), -- [PI062]
	  variante_mail varchar ( 35),
	  dte_delai_j   datetime,
	  dte_pivot datetime,
	  dte_pivot_dt364 datetime,
	  z2eme_rel  Varchar ( 5 ),
	  dte_del_2eme_rel_j datetime,
	  z3eme_rel Varchar ( 5 ),
	  dte_del_3eme_rel_j datetime,
	  cloture_dos Varchar ( 5 ),
	  dte_del_cloture_dos_j datetime
	)

Declare @dcIdSin decimal (10 ) -- [PI062]
Declare @iIdSeq  Integer
Declare @iIdSeqCmde integer
Declare @sBase VarChar ( 100 )
Declare @iIdSin 	Integer
Declare @iIdProd 	Integer
Declare @iIdEts 	Integer
Declare @dcIdProd     Decimal (7) 
Declare @dcIdEts 	Decimal (7) 
Declare @sNumProd     VarChar (20)  
Declare @sLibProd     VarChar (255) 
Declare @sCiv		VarChar (100)
Declare @sNom		VarChar (50) 
Declare @sMailFrom	VarChar (128) 
Declare @sMailSend	VarChar (128) 
Declare @sMailCc	VarChar (128)
Declare @sMailObjet	VarChar ( 255 )
Declare @sMailBody	VarChar ( 7000 )
Declare @sAltQuarant  VarChar (1)	
Declare @sSaut	VarChar (10) 
Declare @sBoiteMail    VarChar (35)
Declare @sAltSuiviSMS VarChar ( 1 )
Declare @sNumGsmSMS   VarChar ( 20 )
Declare @iOrangeV3 Integer
Declare @iRet Integer
Declare @sMarque VarChar (35)
Declare @sModele VarChar (35)
Declare @sMess	VarChar ( 2000 )
Declare @iIdCt	integer	
Declare @sTypRel Varchar ( 10 )
Declare @sCodeMail VarChar ( 10 )
Declare @sNomZoneDivPro VarChar ( 35 )
Declare @sLibZoneDivPro VarChar ( 35 )
Declare @iIdNatTache integer
Declare @iIdTypContact Integer
Declare @sVariante varchar ( 35 ) -- [DT364]
Declare @sProxi varchar ( 10 ) -- [DT364]
Declare @sAltQueue VarChar ( 1 )
Declare @dtDateJour DateTime
Declare @sDteDecl Varchar ( 10 )
Declare @iCptTri Integer
Declare @sNumTelProd VarChar ( 20 )
Declare @sAltRecla VarChar ( 1 )

Set @dtDateJour = GetDate()

Set @sBase = Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) )
Set @sMailBody = ''
Set @sSaut = Char (10)
Set @iRet = 0

Insert into @det_pro
Select dp.id_prod,
	   sysadm.FN_CLE_VAL ( 'VARIANTE_MAIL', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';'),
	   DATEADD ( day, (-1)* Convert ( integer, sysadm.FN_CLE_VAL ( 'DELAI_J', dp.val_car, ';')) , Getdate() ),
	   Convert ( DateTime,  sysadm.FN_CLE_VAL ( 'DTE_PIVOT', dp.val_car, ';')),
	   Convert ( DateTime,  sysadm.FN_CLE_VAL ( 'DTE_PIVOT_DT364', dp.val_car, ';')),
	   sysadm.FN_CLE_VAL ( '2EME_REL', dp.val_car, ';'),
	   DATEADD ( day, (-1)* Convert ( integer, sysadm.FN_CLE_VAL ( 'DEL_2EME_REL_J', dp.val_car, ';')) , Getdate() ),
	   sysadm.FN_CLE_VAL ( '3EME_REL', dp.val_car, ';'),
	   DATEADD ( day, (-1)* Convert ( integer, sysadm.FN_CLE_VAL ( 'DEL_3EME_REL_J', dp.val_car, ';')) , Getdate() ),
	   sysadm.FN_CLE_VAL ( 'CLOTURE_DOS', dp.val_car, ';'),
	   DATEADD ( day, (-1)* Convert ( integer, sysadm.FN_CLE_VAL ( 'DEL_CLOTURE_DOS_J', dp.val_car, ';')) , Getdate() )
From sysadm.det_pro dp with (nolock)
Where dp.id_code_dp = 301



-- [PM284-2]
-- [DT364]
Insert into @tb
select distinct 
		c.id_sin, 
		c.id_seq,
		'REL1', -- [DT364]
		sysadm.FN_AFF_DATE ( s.dte_decl, 'SH' ),  -- [DT364]
		IsNull ( ltrim ( rtrim (  s.marq_port )), ''),
		IsNull ( ltrim ( rtrim (  s.modl_port )), ''),
		dp.variante_mail, -- [DT364]
		Case 
			When Len ( sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_PROXIMITE', rtrim ( info_spb_frn_cplt ), ';' )) > 0 
				Then sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_PROXIMITE', rtrim ( info_spb_frn_cplt ), ';' )
			When c.info_spb_frn in ( 981, 982, 2141, 2142, 2143 ) 
				Then 'PICKUP'
			Else ''
		End, -- [DT364]
		0 'marquage'
From	sysadm.commande c with (nolock),
		sysadm.sinistre s with (nolock),
		@det_pro dp,
		sysadm.div_sin ds with (nolock)
Where	c.id_ref_four in ( 'A_DIAGNOSTIQUER', 'A_REPARER', 'A_DESOXYDER' )
And		c.dte_rcp_frn is null
And		c.cod_etat not in (  'ANN', 'RFO', 'RPC' )
And		c.cree_le < dp.dte_delai_j
And		(
			( c.cree_le > dp.dte_pivot And c.id_four in ( 'O2M', 'PSM', 'SBE', 'SRR' ) )
			Or 
			( c.cree_le > dp.dte_pivot_dt364 And c.id_four in ( 'COR', 'SBE', 'SRR' ) ) -- [DT364] Ajout CORDON
		)
And		ds.id_sin = c.id_sin
And     ds.nom_zone = 'etat_vu_assure'
And     ds.val_nbre not in ( 1500, 1510, 1520, 1530 )
And		s.id_sin = c.id_sin
And		dp.id_prod = s.id_prod
And		Not Exists ( Select Top 1 1 From sysadm.div_sin ds  with (nolock) Where ds.id_sin = s.id_sin and ds.nom_zone = 'dte_rel_mail_app_non_rcp_en_ctr' )
And		Not Exists ( 
			Select	top 1 1  
			From	sysadm.commande c1 with (nolock)
			Where   c1.id_sin = c.id_sin
			And		c1.id_typ_art = 'PST'
			And     sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim ( c1.info_spb_frn_cplt ) , ';' )= 'PRET'
		)

Insert into @tb
select distinct 
		c.id_sin, 
		c.id_seq,
		'REL2', -- [DT364]
		sysadm.FN_AFF_DATE ( s.dte_decl, 'SH' ),  -- [DT364]
		IsNull ( ltrim ( rtrim (  s.marq_port )), ''),
		IsNull ( ltrim ( rtrim (  s.modl_port )), ''),
		dp.variante_mail, -- [DT364]
		Case 
			When Len ( sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_PROXIMITE', rtrim ( info_spb_frn_cplt ), ';' )) > 0 
				Then sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_PROXIMITE', rtrim ( info_spb_frn_cplt ), ';' )
			When c.info_spb_frn in ( 981, 982, 2141, 2142, 2143 ) 
				Then 'PICKUP'
			Else ''
		End, -- [DT364]
		0 'marquage'
From	sysadm.commande c with (nolock),
		sysadm.sinistre s with (nolock),
		@det_pro dp,
		sysadm.div_sin ds with (nolock),
		sysadm.div_sin ds2 with (nolock)
Where	c.id_ref_four in ( 'A_DIAGNOSTIQUER', 'A_REPARER', 'A_DESOXYDER' )
And		c.dte_rcp_frn is null
And		c.cod_etat not in (  'ANN', 'RFO', 'RPC' )
And		c.id_four in ( 'O2M', 'PSM', 'COR', 'SBE', 'SRR' ) -- [DT364] Ajout CORDON
And		c.cree_le > dp.dte_pivot_dt364
And		ds2.id_sin = c.id_sin
And     ds2.nom_zone = 'dte_rel_mail_app_non_rcp_en_ctr'
And		ds2.val_dte < dp.dte_del_2eme_rel_j
And		ds.id_sin = c.id_sin
And     ds.nom_zone = 'etat_vu_assure'
And     ds.val_nbre not in ( 1500, 1510, 1520, 1530 )
And		s.id_sin = c.id_sin
And		dp.id_prod = s.id_prod
And     dp.z2eme_rel = 'OUI'
And		Not Exists ( Select Top 1 1 From sysadm.div_sin ds  with (nolock) Where ds.id_sin = s.id_sin and ds.nom_zone = 'dte_rel2_mail_app_non_rcp_en_ctr' )
And		Not Exists ( 
			Select	top 1 1  
			From	sysadm.commande c1 with (nolock)
			Where   c1.id_sin = c.id_sin
			And		c1.id_typ_art = 'PST'
			And     sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim ( c1.info_spb_frn_cplt ) , ';' )= 'PRET'
		)


Insert into @tb
select distinct 
		c.id_sin, 
		c.id_seq,
		'REL3', -- [DT364]
		sysadm.FN_AFF_DATE ( s.dte_decl, 'SH' ),  -- [DT364]
		IsNull ( ltrim ( rtrim (   s.marq_port )), ''),
		IsNull ( ltrim ( rtrim (   s.modl_port )), ''),
		dp.variante_mail, -- [DT364]
		Case 
			When Len ( sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_PROXIMITE', rtrim ( info_spb_frn_cplt ), ';' )) > 0 
				Then sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_PROXIMITE', rtrim ( info_spb_frn_cplt ), ';' )
			When c.info_spb_frn in ( 981, 982, 2141, 2142, 2143 ) 
				Then 'PICKUP'
			Else ''
		End, -- [DT364]
		0 'marquage'
From	sysadm.commande c with (nolock),
		sysadm.sinistre s with (nolock),
		@det_pro dp,
		sysadm.div_sin ds with (nolock),
		sysadm.div_sin ds2 with (nolock)
Where	c.id_ref_four in ( 'A_DIAGNOSTIQUER', 'A_REPARER', 'A_DESOXYDER' )
And		c.dte_rcp_frn is null
And		c.cod_etat not in (  'ANN', 'RFO', 'RPC' )
And		c.id_four in ( 'O2M', 'PSM', 'COR', 'SBE', 'SRR' ) -- [DT364] Ajout CORDON
And		ds2.id_sin = c.id_sin
And     ds2.nom_zone = 'dte_rel2_mail_app_non_rcp_en_ctr'
And		ds2.val_dte < dp.dte_del_3eme_rel_j
And		c.cree_le > dp.dte_pivot_dt364
And		ds.id_sin = c.id_sin
And     ds.nom_zone = 'etat_vu_assure'
And     ds.val_nbre not in ( 1500, 1510, 1520, 1530 )
And		s.id_sin = c.id_sin
And		dp.id_prod = s.id_prod
And     dp.z3eme_rel = 'OUI'
And		Not Exists ( Select Top 1 1 From sysadm.div_sin ds  with (nolock) Where ds.id_sin = s.id_sin and ds.nom_zone = 'dte_rel3_mail_app_non_rcp_en_ctr' )
And		Not Exists ( 
			Select	top 1 1  
			From	sysadm.commande c1 with (nolock)
			Where   c1.id_sin = c.id_sin
			And		c1.id_typ_art = 'PST'
			And     sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim ( c1.info_spb_frn_cplt ) , ';' )= 'PRET'
		)

Insert into @tb
select distinct 
		c.id_sin, 
		c.id_seq,
		'REL4', -- [DT364]
		sysadm.FN_AFF_DATE ( s.dte_decl, 'SH' ),  -- [DT364]
		IsNull ( ltrim ( rtrim ( s.marq_port )), ''),
		IsNull ( ltrim ( rtrim ( s.modl_port )), ''),
		dp.variante_mail, -- [DT364]
		Case 
			When Len ( sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_PROXIMITE', rtrim ( info_spb_frn_cplt ), ';' )) > 0 
				Then sysadm.FN_CLE_VAL ( 'CODE_BTQ_PSM_PROXIMITE', rtrim ( info_spb_frn_cplt ), ';' )
			When c.info_spb_frn in ( 981, 982, 2141, 2142, 2143 ) 
				Then 'PICKUP'
			Else ''
		End, -- [DT364]
		0 'marquage'
From	sysadm.commande c with (nolock),
		sysadm.sinistre s with (nolock),
		@det_pro dp ,
		sysadm.div_sin ds with (nolock),
		sysadm.div_sin ds2 with (nolock)
Where	c.id_ref_four in ( 'A_DIAGNOSTIQUER', 'A_REPARER', 'A_DESOXYDER' )
And		c.dte_rcp_frn is null
And		c.cod_etat not in (  'ANN', 'RFO', 'RPC' )
And		c.id_four in ( 'O2M', 'PSM', 'COR', 'SBE', 'SRR' ) -- [DT364] Ajout CORDON
And		ds2.id_sin = c.id_sin
-- [PM519-1]
--And     ds2.nom_zone = 'dte_rel3_mail_app_non_rcp_en_ctr'
And		ds2.nom_zone =  Case 
							When dp.z3eme_rel = 'OUI' Then 'dte_rel3_mail_app_non_rcp_en_ctr'
							When dp.z2eme_rel = 'OUI' Then 'dte_rel2_mail_app_non_rcp_en_ctr'
							Else 'dte_rel1_mail_app_non_rcp_en_ctr'
					   End 
-- /[PM519-1]
And		ds2.val_dte < dp.dte_del_cloture_dos_j
And		c.cree_le > dp.dte_pivot_dt364
And		ds.id_sin = c.id_sin
And     ds.nom_zone = 'etat_vu_assure'
And     ds.val_nbre not in ( 1500, 1510, 1520, 1530 )
And		s.id_sin = c.id_sin
And		dp.id_prod = s.id_prod
And     dp.cloture_dos = 'OUI'
And		Not Exists ( Select Top 1 1 From sysadm.div_sin ds  with (nolock) Where ds.id_sin = s.id_sin and ds.nom_zone = 'dte_rel4_mail_app_non_rcp_en_ctr' )
And		Not Exists ( 
			Select	top 1 1  
			From	sysadm.commande c1 with (nolock)
			Where   c1.id_sin = c.id_sin
			And		c1.id_typ_art = 'PST'
			And     sysadm.FN_CLE_VAL ( 'TYP_RELAI', rtrim ( c1.info_spb_frn_cplt ) , ';' )= 'PRET'
		)

While Exists ( Select Top 1 1 From @tb where marquage = 0 )
 Begin
	-- [DT364]
	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdSin = id_sin,
		@iIdSeqCmde = id_seq_cmde,
		@sTypRel =  type_rel,
		@sDteDecl = dte_decl,
		@sMarque = marque,
		@sModele = modele,
		@sVariante = variante, -- [DT364]
		@sProxi = proxi -- [DT364]
	From	@tb
	Where	marquage = 0

	-- [RS3179_SHUNT_RECLA]
	If sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 
	 Begin
		Set @iIdSin = CONVERT ( Integer,  @dcIdSin )
		Set @sAltRecla = 'N'

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec SHERPA_PRO.sysadm.Recla_Verifier_Sinistre @iIdSin, 2, @sAltRecla OUTPUT		
		END
		ELSE
		BEGIN
			Exec SHERPA_SIM.sysadm.Recla_Verifier_Sinistre @iIdSin, 2, @sAltRecla OUTPUT		
		END	

		If @sAltRecla = 'O'
		  Begin
			Update @tb Set marquage = 1	Where id_seq = @iIdSeq
			Continue
		  End
	 End 

	If @sVariante is null Set @sVariante = ''

	-- [PM519-1]
	Select  @sNumTelProd =
			sysadm.FN_TRIM (
			Case Left ( p.num_tel, 2 )
				When '08' Then Left ( p.num_tel, 1 ) + ' ' + SubString ( p.num_tel, 2, 3 ) + ' ' + SubString ( p.num_tel, 5, 3 ) + ' ' + SubString ( p.num_tel, 8, 3 )
				Else Left ( p.num_tel, 2 ) + ' ' + SubString ( p.num_tel, 3, 2 ) + ' ' + SubString ( p.num_tel, 5, 2 ) + ' ' + SubString ( p.num_tel, 7, 2 ) + ' ' + SubString ( p.num_tel, 9, 2 )
			End
			)
	From   sysadm.sinistre s with (nolock),
		   sysadm.produit p with (nolock) 
	Where  s.id_sin = @dcIdSin
	And    p.id_prod = s.id_prod
	-- /[PM519-1]

	If @sTypRel = 'REL1' 
		Begin
			Set @sCodeMail = 'M29'
			Set @sNomZoneDivPro = 'dte_rel_mail_app_non_rcp_en_ctr'
			Set @sLibZoneDivPro = 'Date 1ère rel mail ApNoRcpCTR'
			Set @iIdNatTache = 919
			Set @sMess = '1ère Relance vers le client suite appareil non réceptionné(s) en CTR.'
			Set @iIdTypContact = 1576
			Set @iCptTri = 760
		End 

	If @sTypRel = 'REL2' 
		Begin
			Set @sCodeMail = 'M32'
			Set @sNomZoneDivPro = 'dte_rel2_mail_app_non_rcp_en_ctr'
			Set @sLibZoneDivPro = 'Date 2ème rel mail ApNoRcpCTR'
			Set @iIdNatTache = 920
			Set @sMess = '2ème Relance vers le client suite appareil non réceptionné(s) en CTR.'
			Set @iIdTypContact = 1604
			Set @iCptTri = 761
		End 

 	If @sTypRel = 'REL3' 
		Begin
			Set @sCodeMail = 'M33'
			Set @sNomZoneDivPro = 'dte_rel3_mail_app_non_rcp_en_ctr'
			Set @sLibZoneDivPro = 'Date 3ème rel mail ApNoRcpCTR'
			Set @iIdNatTache = 921
			Set @sMess = '3ème Relance vers le client suite appareil non réceptionné(s) en CTR.'
			Set @iIdTypContact = 1605
			Set @iCptTri = 762
		End 

 	If @sTypRel = 'REL4' 
		Begin
			Set @sCodeMail = 'M34'
			Set @sNomZoneDivPro = 'dte_rel4_mail_app_non_rcp_en_ctr'
			Set @sLibZoneDivPro = 'Date Clôture rel mail ApNoRcpCTR'
			Set @iIdNatTache = 926
			Set @sMess = 'Dernière Relance vers le client suite appareil non réceptionné(s) en CTR. Cloture automatique du dossier.'
			Set @iIdTypContact = 1606
			Set @iCptTri = 763
		End 


	Set @sMailBody = ''

	  -- Récupération des données standard nécessaires à l'envoi du mail
	Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@dcIdSin,
	@sBase,
 	49,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT,  
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #3
	@sAltSuiviSMS OUTPUT, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #5 [FNAC_PROD_ECH_TECH].[SMS]

	
	-- Le but pour Orange V3 et de toujours mettre une adresse mail si l'adresse réél n'est pas là, pour justement
	-- déclencher l'échec de distribution et donc envoyer le courrier en automatique.
	If @iRet = -7 
    Begin
		Set @sMailSend = 'DeclEchecDistrib@spb.fr'
	End
	
	-- Gestion de la civilité "Madame, Monsieur"
	If @sNom <> ''
	Begin
		Set @sCiv = @sCiv + ' ' + @sNom + ','
	End 

	Set @sMailObjet = 'Dossier de sinistre SPB n°' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @dcIdSin ), 10 ) ) + ' ' + @sLibProd + ' - Gestion en cours' -- [PI062]

	-- [PM519-1]
	If @sVariante = 'MOBILEO' 
	  Begin
		If @sTypRel = 'REL1'
		  Begin
			Set @sMailObjet = 'Demande de prise en charge – appareil non reçu ' + @sLibProd + ' Référence client : ' + Convert ( VarChar, @dcIdSin ) 
		  End 

		If @sTypRel = 'REL2'
		  Begin
			Set @sMailObjet = 'Demande de prise en charge – appareil non reçu ' + @sLibProd + ' Référence client : ' + Convert ( VarChar, @dcIdSin ) + ' - relance'
		  End 

		If @sTypRel = 'REL4'
		  Begin
			Set @sMailObjet = 'Demande de prise en charge – appareil non reçu ' + @sLibProd + ' Référence client : ' + Convert ( VarChar, @dcIdSin ) + ' - dernière relance'
		  End 

	  End 


	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut

	-- [DT364]
	-- [DT364]
	IF @sTypRel in ( 'REL1') 
	  Begin

		-- [PM519-1]
		If @sVariante = 'MOBILEO' And @sTypRel = 'REL1'
		  Begin
			Set @sMailBody  = @sMailBody  + 'A ce jour, nous vous informons que nous n''avons pas reçu votre ' + @sMarque + ' ' + @sModele + ' dans notre centre de réparation.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous vous remercions de nous le faire parvenir afin que nous puissions l''examiner et vous répondre dans les meilleurs délais.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Si vous venez de nous l''envoyer, ne tenez pas compte de ce mail, nos correspondances ont dû se croiser.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour toute question complémentaire au ' + @sNumTelProd + '.'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Cordialement,'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Votre gestionnaire d''assurance,'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
		  End 

		-- [ORANGE]
		If @sVariante = 'ORANGE'
		  Begin
			Set @sMailBody  = @sMailBody  + 'Nous n''avons à ce jour pas reçu votre appareil ' + @sMarque + ' ' + @sModele + ' dans notre centre technique.' 
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut

			-- [VDOC27607]
			Set @sMailBody  = @sMailBody  + 'Nous vous rappelons par ailleurs que nous pouvons être amenés à vous demander toute pièce objectivement et strictement nécessaire permettant de démontrer que les conditions de la garantie sont réunies.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut

			Set @sMailBody  = @sMailBody  + 'Si vous nous avez transmis votre appareil récemment, nos envois ont pu se croiser, nous vous remercions donc d’ignorer ce mail.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'

			-- [DT262]
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Si votre contrat d''assurance dispose d''un site web de gestion de sinistre, vous pouvez à tout moment consulter et télécharger la ou les pièce(s) de votre dossier sur ce site communiqué par notre gestionnaire lors de votre déclaration.'


			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Sincères salutations.'
		  End


		-- Le défaut en dehors de toute variante
		If @sVariante = ''
		  Begin
			Set @sMailBody  = @sMailBody  + 'Nous n''avons à ce jour pas reçu votre appareil ' + @sMarque + ' ' + @sModele + ' dans notre centre technique.' 
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut

			-- [VDOC27607]
			Set @sMailBody  = @sMailBody  + 'Nous vous rappelons par ailleurs que nous pouvons être amenés à vous demander toute pièce objectivement et strictement nécessaire permettant de démontrer que les conditions de la garantie sont réunies.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut

			Set @sMailBody  = @sMailBody  + 'Si vous nous avez transmis votre appareil récemment, nos envois ont pu se croiser, nous vous remercions donc d’ignorer ce mail.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'

			-- [DT262]
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Si votre contrat d''assurance dispose d''un site web de gestion de sinistre, vous pouvez à tout moment consulter et télécharger la ou les pièce(s) de votre dossier sur ce site communiqué par notre gestionnaire lors de votre déclaration.'


			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Sincères salutations.'
		  End
		End 

	-- [DT364]
	IF @sTypRel in ( 'REL2', 'REL3' ) 
		Begin
		-- [PM519-1]
		If @sVariante = 'MOBILEO' And @sTypRel = 'REL2'
		  Begin
			Set @sMailBody  = @sMailBody  + 'Dans le cadre de votre demande de prise en charge au titre de votre contrat ' + @sLibProd+ ', et malgré notre relance, nous n’avons toujours pas reçu votre '+ @sMarque + ' ' + @sModele + ' dans notre centre de réparation.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous vous rappelons que pouvez consulter, sur votre espace assuré dans la rubrique « suivre mon dossier », les démarches à suivre pour nous faire parvenir votre appareil.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Si nous ne recevons pas votre appareil dans un délai de 35 jours, nous serons dans l''obligation de clôturer votre dossier.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour toute question complémentaire au ' + @sNumTelProd + '.'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Cordialement,'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Votre gestionnaire d''assurance,'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut			
		  End


		-- [ORANGE]
		If @sVariante = 'ORANGE'
		  Begin
			Set @sMailBody  = @sMailBody  + 'Dans le cadre de votre demande de prise en charge au titre de votre contrat ' + @sLibProd + ', vous avez été invité'
			
			If @sProxi is null Set @sProxi = ''
			If @sProxi <> '' Set @sMailBody  = @sMailBody  + ' à déposer '
			If @sProxi = '' Set @sMailBody  = @sMailBody  + ' à adresser '			 
			 
			Set @sMailBody  = @sMailBody  + 'votre appareil ' + @sMarque + ' ' + @sModele + ' dans notre centre de réparation.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Cependant, malgré nos relances, nous constatons que votre appareil n’a pas été réceptionné par notre centre technique.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut

			If @sProxi <> ''
				Begin 
					Set @sMailBody  = @sMailBody  + 'Vous pouvez consulter les modalités de dépôt de votre appareil sur votre espace assuré https://orange.spb.eu dans la rubrique « suivre mon dossier ».'
					Set @sMailBody  = @sMailBody  + @sSaut
					Set @sMailBody  = @sMailBody  + @sSaut
				End 

			If @sProxi = ''
				Begin 
					Set @sMailBody  = @sMailBody  + 'Afin de vous permettre de procéder à l’envoi de votre appareil, un bon de transport a été mis à votre disposition sur votre espace assuré https://orange.spb.eu dans la rubrique « suivre mon dossier ».'
					Set @sMailBody  = @sMailBody  + @sSaut
					Set @sMailBody  = @sMailBody  + @sSaut
					Set @sMailBody  = @sMailBody  + 'Attention la validité de ce bon de transport est limitée dans le temps, il est impératif de nous adresser votre terminal avant son échéance (information disponible sur le bon de transport).'
					Set @sMailBody  = @sMailBody  + @sSaut
					Set @sMailBody  = @sMailBody  + @sSaut
				End 

			-- [VDOC27607]
			Set @sMailBody  = @sMailBody  + 'Nous vous rappelons par ailleurs que nous pouvons être amenés à vous demander toute pièce objectivement et strictement nécessaire permettant de démontrer que les conditions de la garantie sont réunies.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut

			Set @sMailBody  = @sMailBody  + 'Si vous avez procédé récemment '  

			If @sProxi is null Set @sProxi = ''
			If @sProxi <> '' Set @sMailBody  = @sMailBody  + ' au dépôt '
			If @sProxi = '' Set @sMailBody  = @sMailBody  + ' à l''envoi '			 

			Set @sMailBody  = @sMailBody  + ' de votre appareil, nos correspondances ont pu se croiser, nous vous remercions de ne pas tenir compte de ce message.'

			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Sincères salutations.'
		  End


		-- Le défaut en dehors de toute variante
		If @sVariante = ''
		  Begin
			Set @sMailBody  = @sMailBody  + 'Dans le cadre de votre demande de prise en charge au titre de votre contrat ' + @sLibProd + ', vous avez été invité'
			
			If @sProxi is null Set @sProxi = ''
			If @sProxi <> '' Set @sMailBody  = @sMailBody  + ' à déposer '
			If @sProxi = '' Set @sMailBody  = @sMailBody  + ' à adresser '			 
			 
			Set @sMailBody  = @sMailBody  + 'votre appareil ' + @sMarque + ' ' + @sModele + ' dans notre centre de réparation.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Cependant, malgré nos relances, nous constatons que votre appareil n’a pas été réceptionné par notre centre technique.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut

			-- [VDOC27607]
			Set @sMailBody  = @sMailBody  + 'Nous vous rappelons par ailleurs que nous pouvons être amenés à vous demander toute pièce objectivement et strictement nécessaire permettant de démontrer que les conditions de la garantie sont réunies.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut

			Set @sMailBody  = @sMailBody  + 'Si vous avez procédé récemment '  

			If @sProxi is null Set @sProxi = ''
			If @sProxi <> '' Set @sMailBody  = @sMailBody  + ' au dépôt '
			If @sProxi = '' Set @sMailBody  = @sMailBody  + ' à l''envoi '			 

			Set @sMailBody  = @sMailBody  + ' de votre appareil, nos correspondances ont pu se croiser, nous vous remercions de ne pas tenir compte de ce message.'

			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Sincères salutations.'
		  End
		End 

	IF @sTypRel in ( 'REL4') 
		Begin

		-- [PM519-1]
		If @sVariante = 'MOBILEO' And @sTypRel = 'REL4'
		  Begin
			Set @sMailBody  = @sMailBody  + 'Vous nous avez déclaré un sinistre le ' + @sDteDecl + ', au titre de votre contrat ' + @sLibProd + ' concernant votre appareil ' + @sMarque + ' ' + @sModele + '.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Malgré nos relances nous n''avons pas reçu l''appareil sinistré et n''avons pas pu étudier votre dossier.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous vous informons donc de la clôture de votre demande.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Si vous souhaitez que votre demande d’indemnisation soit rouverte, nous vous remercions de nous appeler au '+ @sNumTelProd + '.'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour toute question complémentaire.'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Cordialement,'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Votre gestionnaire d''assurance,'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
		  End 

		-- [ORANGE]
		If @sVariante = 'ORANGE'
		  Begin
			Set @sMailBody  = @sMailBody  + 'Vous nous avez déclaré un sinistre le ' + @sDteDecl + ' dans le cadre de votre contrat ' + @sLibProd + ' qui couvre votre appareil ' + @sMarque + ' ' + @sModele + '.' 
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Malgré nos relances et en l''absence de réception de l''appareil sinistré, nous n''avons pas pu procéder à l''examen de votre dossier.' 
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous vous informons donc de la clôture de votre demande.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Si vous souhaitez que votre demande d''indemnisation soit rouverte, nous vous remercions de bien vouloir prendre contact avec nos services.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Sincères salutations.'
		  End

		-- Le défaut en dehors de toute variante
		If @sVariante = ''
		  Begin
			Set @sMailBody  = @sMailBody  + 'Vous nous avez déclaré un sinistre le ' + @sDteDecl + ' dans le cadre de votre contrat ' + @sLibProd + ' qui couvre votre appareil ' + @sMarque + ' ' + @sModele + '.' 
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Malgré nos relances et en l''absence de réception de l''appareil sinistré, nous n''avons pas pu procéder à l''examen de votre dossier.' 
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous vous informons donc de la clôture de votre demande.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Si vous souhaitez que votre demande d''indemnisation soit rouverte, nous vous remercions de bien vouloir prendre contact avec nos services.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Sincères salutations.'
		  End
		End 

	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + '****************************************************************'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + '****************************************************************'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'

	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @dcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
    Set @sAltQuarant = Convert ( Varchar (5), @iIdSeqCmde )

	-- [DT364]
	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
		Begin  -- TRACE_MAIL_PRO : Début écriture
			Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			@sAltQuarant,
			@sBoiteMail, -- #3
			@sCodeMail, -- #3 -- [DT364]
			2 -- #3
		End
	Else
		Begin  -- TRACE_MAIL_TRT : Début écriture
			Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			@sAltQuarant,
			@sBoiteMail, -- #3
			@sCodeMail, -- #3 -- [DT364]
			2 -- #3	
		End

	If Exists ( Select Top 1 1 From sysadm.w_sin ws with (nolock) Where ws.id_sin = @dcIdSin  )	
		Begin
		If Exists ( Select Top 1 1 From sysadm.w_div_sin wds with (nolock) Where wds.id_sin = @dcIdSin And nom_zone = @sNomZoneDivPro )
			Begin
			Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = @sNomZoneDivPro
			End 
		Else
			Begin	 
			Insert into sysadm.w_div_sin values ( @dcIdSin, @sNomZoneDivPro, @sLibZoneDivPro, '-1', 'N', 'D', 'N', 'N', @iCptTri, null, null, GETDATE(), null, 1, getdate(), getdate(), 'AUTO' ) 
			End
		End


	If Exists ( Select Top 1 1 From sysadm.sinistre ws with (nolock) Where ws.id_sin = @dcIdSin  )	
		Begin
		If Exists ( Select Top 1 1 From sysadm.div_sin wds with (nolock) Where wds.id_sin = @dcIdSin And nom_zone = @sNomZoneDivPro)
			Begin
			Update sysadm.div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = @sNomZoneDivPro
			End 
		Else
			Begin	 
			Insert into sysadm.div_sin values ( @dcIdSin, @sNomZoneDivPro, @sLibZoneDivPro, '-1', 'N', 'D', 'N', 'N', @iCptTri, null, null, GETDATE(), null, getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 
			End
		End

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, @iIdTypContact, 'C', @dcIdSin, 2, @sMess,	'AUTO', 300, @iIdCt OUTPUT, @iIdNatTache
	END
	ELSE
	BEGIN
		Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, @iIdTypContact, 'C', @dcIdSin, 2, @sMess,	'AUTO', 300, @iIdCt OUTPUT, @iIdNatTache
	END

	IF @sTypRel in ( 'REL4') 
		Begin
			Set @sAltQueue = space (1)
			Exec sysadm.PS_D01_ARCHIVE_SOLDAGE @dcIdSin, 'SQLS', @dtDateJour, @sAltQueue Output, 'CENTRALISE'
			Exec sysadm.PS_I_DIV_SIN_ETAT_ASS @dcIdSin, 'SQLS'
		End

	-- [PI087_PM473_2]
	Exec sysadm.PS_I_PI087_TRACE_DOSSIER @dcIdSin, 'VALIDATION', 'SQLS'

	Update @tb
	Set marquage = 1
	Where id_seq = @iIdSeq
 End

Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_MAIL_PRET_FICHE_15
-- Auteur               :       Fabry JF
-- Date                 :       17/09/2014
-- Libelle              :		mail 15 et 19 si Iphone
-- Commentaires         :       [PM250-2]
--
-- References           :
--
--------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_MAIL_PRET_FICHE_15' AND type = 'P' )
        DROP procedure sysadm.PS_I_MAIL_PRET_FICHE_15
GO

CREATE procedure sysadm.PS_I_MAIL_PRET_FICHE_15
	@asIdAppli	varchar (20),
	@asBase		varchar (20),
	@aiOptionDP  	Integer,
	@adcIdSin      	Decimal (10) -- [PI062]
AS

Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @dcIdDetail   Decimal (7), -- #4 [SURCOUF_ECH_EXPRESS]
  @dcIdGti      Decimal (7), -- #4 [SURCOUF_ECH_EXPRESS]
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @asHREFURL	VarChar (300),		
  @sSaut	VarChar (10), 
  @sMarque	VarChar (35),
  @sModele	VarChar (35),  
  @sIdFour	VarChar (10),
  @sCodeEtat	VarChar (10),
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @sBoiteMail   VarChar (35),
  @iInfoSpbFrn  Integer, 
  @sIdRefFour   VarChar ( 35 ), 
  @sInfoSpbFrnCplt VarChar ( 255 ), 
  @sXMLVar     	VarChar ( 2000 ), 
  @sTypApp 		VarChar ( 3 ),
  @sProduitOrange VarChar ( 3 ),
  @sMarqPort	VarChar(35),
  @sModlPort	VarChar(35),
  @sImei		Varchar(60),
  @sLibPolice	Varchar(35),
  @sLibCie	Varchar(35),
  @sMajPar	VarChar(4),
  @sEmailProduit Varchar(256),
  @sCivLongue Varchar(35),
  @dcIdProdAdh Decimal (7)
  
  
  Set @sMailBody = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  Set @asIdAppli = Upper ( @asIdAppli )
  Set @sTypApp = '' 


	-- Produit Orange ?
	Set @sProduitOrange = 'NON'
	If Exists ( 
			Select	*
			From	sysadm.produit p,
					sysadm.sinistre s
			Where   s.id_sin = @adcIdSin
			And     p.id_prod = s.id_prod
			And		p.id_grp in ( 254, 475 ) )
		Begin
			Set @sProduitOrange = 'OUI'
		End 




	Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL_XML
		@adcIdSin,
		@aiOptionDP,
		@dcIdProd   OUTPUT,
		@sLibProd   OUTPUT,
		@dcIdEts    OUTPUT,
		@sNumProd   OUTPUT,
		@sCiv	    OUTPUT,
		@sNom	    OUTPUT,
		@sMailFrom  OUTPUT,
		@sMailSend  OUTPUT,
		@sMailCc    OUTPUT,
		@sAltQuarant OUTPUT,
		@sBoiteMail  OUTPUT,
		@sXMLVar     OUTPUT

	Select top 1 @sMarqPort=RTrim(IsNull(marq_port,'')),
		@sModlPort=RTrim(IsNull(modl_port,'')),
		@sImei=RTrim(IsNull(num_imei_port,'')),
		@sLibPolice=rtrim(p.lib_police),
		@sLibCie=RTrim(c.lib_cie),
		@sMajPar=Rtrim(s.maj_par),
		@sEmailProduit=IsNull(sysadm.FN_CLE_VAL('ADR_MAIL_PROD',dp.val_car,';') ,''),
		@sCivLongue=sysadm.FN_CODE_NUM(i.cod_civ,'-CL'),
		@dcIdProdAdh = pr.cod_prod_dms
	From sysadm.w_sin s
		left outer join sysadm.det_pro dp on dp.id_prod=s.id_prod and dp.id_code_dp=136,
		sysadm.w_inter i,
		sysadm.w_gar_sin wg,
		sysadm.garantie g,
		sysadm.police p,
		sysadm.compagnie c,
		sysadm.produit pr
   Where s.id_sin = @adcIdSin
	And  s.id_sin = wg.id_sin
	And  g.id_prod = s.id_prod
	And  g.id_rev = s.id_rev
	and  g.id_gti = wg.id_gti
	And   p.id_police = g.id_police
	And c.id_cie=p.id_cie
	And i.id_sin=s.id_sin
	And i.cod_inter='A'
	and pr.id_prod = s.id_prod
	
	-- Armement du corps du mail 
	Set @sMailObjet = 'SPB Sinistre numéro ' + Convert ( Varchar ( 10 ), @adcIdSin ) + ' ' + @sLibProd

	-- Armement du corps du mail
	Set @sXMLVar = @sXMLVar + '<courrier '
	Set @sXMLVar = @sXMLVar + 'code_courrier_SIMPA2="FICHE_PRET_ET_BE_15" '
	Set @sXMLVar = @sXMLVar + 'code_produit="' + Convert ( VarChar ( 15 ), @dcIdProdAdh  ) + '" '
	Set @sXMLVar = @sXMLVar + 'info_pour_EW="joindre un PDF pour envoyer ce mail" '
	Set @sXMLVar = @sXMLVar + 'produit_orange="' + @sProduitOrange + '" '	
	Set @sXMLVar = @sXMLVar + 'code_maquette="FICHE_PRET_ET_BE_15" '	
	Set @sXMLVar = @sXMLVar + 'nom_produit_cpl="' + @sLibProd + '" '
	Set @sXMLVar = @sXMLVar + 'no_dossier_sinistre ="' + convert(varchar(10), @adcIdSin) + '" ' -- [PI062]
	Set @sXMLVar = @sXMLVar + 'civ="' + @sCivLongue + '" '
	Set @sXMLVar = @sXMLVar + 'email="' + @sMailSend + '" '
	Set @sXMLVar = @sXMLVar + 'app_marque="' + @sMarqPort + '" '
	Set @sXMLVar = @sXMLVar + 'app_modele="' + @sModlPort + '" '
	Set @sXMLVar = @sXMLVar + 'imei="' + @sImei + '" '
	Set @sXMLVar = @sXMLVar + 'police="' + @sLibPolice + '" '
	Set @sXMLVar = @sXMLVar + 'assureur="' + @sLibCie + '" '
	Set @sXMLVar = @sXMLVar + 'maj_par="' + @sMajPar + '" '
	Set @sXMLVar = @sXMLVar + 'email_produit="' + @sEmailProduit + '" '
	Set @sXMLVar = @sXMLVar + 'mail_cci="chrono-spb@spb-services.net" '	
	Set @sXMLVar = @sXMLVar + '/>'


	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	Set @sAltQuarant = 'N'


	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin
		   Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V02
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sMailFrom,
			@sMailSend,
			@sMailCc,
			null,
			@sMailObjet,
			'Corps du mail construit par KSL',
			@sAltQuarant,
			@sBoiteMail,
			'O2M15',
			2,
			'KSL',
			'KSL_EDS',
			-1,
			@sXMLVar

	   End    -- TRACE_MAIL_PRO : Fin écriture

	Else
	 Begin
		 Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V02
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sMailFrom,
			@sMailSend,
			@sMailCc,
			null,			
			@sMailObjet,
			'Corps du mail construit par KSL',
			@sAltQuarant,
			@sBoiteMail,
			'O2M15',
			2,
			'KSL',
			'KSL_EDS',			
			-1,
			@sXMLVar
	 End	
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_MAIL_COLI_SIN_FICHE_16
-- Auteur               :       Fabry JF
-- Date                 :       17/09/2014
-- Libelle              :		Fiche 16 
-- Commentaires         :       [PM250-2][MANTIS14550]
--
-- References           :
--
--------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_MAIL_COLI_SIN_FICHE_16' AND type = 'P' )
        DROP procedure sysadm.PS_I_MAIL_COLI_SIN_FICHE_16
GO

CREATE procedure sysadm.PS_I_MAIL_COLI_SIN_FICHE_16
	@asIdAppli	varchar (20),
	@asBase		varchar (20),
	@aiOptionDP  	Integer,
	@adcIdSin      	Decimal (10) -- [PI062]
AS

Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @dcIdDetail   Decimal (7), -- #4 [SURCOUF_ECH_EXPRESS]
  @dcIdGti      Decimal (7), -- #4 [SURCOUF_ECH_EXPRESS]
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @asHREFURL	VarChar (300),		
  @sSaut	VarChar (10), 
  @sMarque	VarChar (35),
  @sModele	VarChar (35),  
  @sIdFour	VarChar (10),
  @sCodeEtat	VarChar (10),
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @sBoiteMail   VarChar (35),
  @iInfoSpbFrn  Integer, 
  @sIdRefFour   VarChar ( 35 ), 
  @sInfoSpbFrnCplt VarChar ( 255 ), 
  @sXMLVar     	VarChar ( 2000 ), 
  @sTypApp 		VarChar ( 3 ),
  @sProduitOrange VarChar ( 3 ),
  @sMarqPort	VarChar(35),
  @sModlPort	VarChar(35),
  @sImei		Varchar(60),
  @sLibPolice	Varchar(35),
  @sLibCie	Varchar(35),
  @sMajPar	VarChar(4),
  @sEmailProduit Varchar(256),
  @sCivLongue Varchar(35),
  @dcIdProdAdh Decimal (7)
  
  
  Set @sMailBody = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  Set @asIdAppli = Upper ( @asIdAppli )
  Set @sTypApp = '' 


	-- Produit Orange ?
	Set @sProduitOrange = 'NON'
	If Exists ( 
			Select	*
			From	sysadm.produit p,
					sysadm.sinistre s
			Where   s.id_sin = @adcIdSin
			And     p.id_prod = s.id_prod
			And		p.id_grp in ( 254, 475 ) )
		Begin
			Set @sProduitOrange = 'OUI'
		End 




	Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL_XML
		@adcIdSin,
		@aiOptionDP,
		@dcIdProd   OUTPUT,
		@sLibProd   OUTPUT,
		@dcIdEts    OUTPUT,
		@sNumProd   OUTPUT,
		@sCiv	    OUTPUT,
		@sNom	    OUTPUT,
		@sMailFrom  OUTPUT,
		@sMailSend  OUTPUT,
		@sMailCc    OUTPUT,
		@sAltQuarant OUTPUT,
		@sBoiteMail  OUTPUT,
		@sXMLVar     OUTPUT

	Select top 1 @sMarqPort=RTrim(IsNull(marq_port,'')),
		@sModlPort=RTrim(IsNull(modl_port,'')),
		@sImei=RTrim(IsNull(num_imei_port,'')),
		@sLibPolice=rtrim(p.lib_police),
		@sLibCie=RTrim(c.lib_cie),
		@sMajPar=Rtrim(s.maj_par),
		@sEmailProduit=IsNull(sysadm.FN_CLE_VAL('ADR_MAIL_PROD',dp.val_car,';') ,''),
		@sCivLongue=sysadm.FN_CODE_NUM(i.cod_civ,'-CL'),
		@dcIdProdAdh = pr.cod_prod_dms
	From sysadm.w_sin s
		left outer join sysadm.det_pro dp on dp.id_prod=s.id_prod and dp.id_code_dp=136,
		sysadm.w_inter i,
		sysadm.w_gar_sin wg,
		sysadm.garantie g,
		sysadm.police p,
		sysadm.compagnie c,
		sysadm.produit pr
   Where s.id_sin = @adcIdSin
	And  s.id_sin = wg.id_sin
	And  g.id_prod = s.id_prod
	And  g.id_rev = s.id_rev
	and  g.id_gti = wg.id_gti
	And   p.id_police = g.id_police
	And c.id_cie=p.id_cie
	And i.id_sin=s.id_sin
	And i.cod_inter='A'
	and pr.id_prod = s.id_prod
	
	-- Armement du corps du mail 
	Set @sMailObjet = 'SPB Sinistre numéro ' + Convert ( Varchar ( 10 ), @adcIdSin ) + ' ' + @sLibProd

	-- Armement du corps du mail
	Set @sXMLVar = @sXMLVar + '<courrier '
	Set @sXMLVar = @sXMLVar + 'code_courrier_SIMPA2="FICHE_COLI_SIN_16" '
	Set @sXMLVar = @sXMLVar + 'code_produit="' + Convert ( VarChar ( 15 ), @dcIdProdAdh  ) + '" '
	Set @sXMLVar = @sXMLVar + 'info_pour_EW="joindre un PDF pour envoyer ce mail" '
	Set @sXMLVar = @sXMLVar + 'produit_orange="' + @sProduitOrange + '" '	
	Set @sXMLVar = @sXMLVar + 'code_maquette="FICHE_COLI_SIN_16" '	
	Set @sXMLVar = @sXMLVar + 'nom_produit_cpl="' + @sLibProd + '" '
	Set @sXMLVar = @sXMLVar + 'no_dossier_sinistre ="' + convert(varchar(10), @adcIdSin) + '" ' -- [PI062]
	Set @sXMLVar = @sXMLVar + 'civ="' + @sCivLongue + '" '
	Set @sXMLVar = @sXMLVar + 'email="' + @sMailSend + '" '
	Set @sXMLVar = @sXMLVar + 'app_marque="' + @sMarqPort + '" '
	Set @sXMLVar = @sXMLVar + 'app_modele="' + @sModlPort + '" '
	Set @sXMLVar = @sXMLVar + 'imei="' + @sImei + '" '
	Set @sXMLVar = @sXMLVar + 'police="' + @sLibPolice + '" '
	Set @sXMLVar = @sXMLVar + 'assureur="' + @sLibCie + '" '
	Set @sXMLVar = @sXMLVar + 'maj_par="' + @sMajPar + '" '
	Set @sXMLVar = @sXMLVar + 'email_produit="' + @sEmailProduit + '" '
	Set @sXMLVar = @sXMLVar + 'mail_cci="chrono-spb@spb-services.net" '	
	Set @sXMLVar = @sXMLVar + '/>'


	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	Set @sAltQuarant = 'N'


	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin
		   Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V02
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sMailFrom,
			@sMailSend,
			@sMailCc,
			null,
			@sMailObjet,
			'Corps du mail construit par KSL',
			@sAltQuarant,
			@sBoiteMail,
			'O2M16',
			2,
			'KSL',
			'KSL_EDS',
			-1,
			@sXMLVar

	   End    -- TRACE_MAIL_PRO : Fin écriture

	Else
	 Begin
		 Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V02
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sMailFrom,
			@sMailSend,
			@sMailCc,
			null,			
			@sMailObjet,
			'Corps du mail construit par KSL',
			@sAltQuarant,
			@sBoiteMail,
			'O2M16',
			2,
			'KSL',
			'KSL_EDS',			
			-1,
			@sXMLVar
	 End	

Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_MAIL_RETOUR_PRET_FICHE_14
-- Auteur               :       Fabry JF
-- Date                 :       17/09/2014
-- Libelle              :		mail 14
-- Commentaires         :       [PM250-2]
--
-- References           :
--
--------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_MAIL_RETOUR_PRET_FICHE_14' AND type = 'P' )
        DROP procedure sysadm.PS_I_MAIL_RETOUR_PRET_FICHE_14
GO

CREATE procedure sysadm.PS_I_MAIL_RETOUR_PRET_FICHE_14
	@asIdAppli	varchar (20),
	@asBase		varchar (20),
	@aiOptionDP  	Integer,
	@adcIdSin      	Decimal (10) -- [PI062]
AS

Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @dcIdDetail   Decimal (7), -- #4 [SURCOUF_ECH_EXPRESS]
  @dcIdGti      Decimal (7), -- #4 [SURCOUF_ECH_EXPRESS]
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @asHREFURL	VarChar (300),		
  @sSaut	VarChar (10), 
  @sMarque	VarChar (35),
  @sModele	VarChar (35),  
  @sIdFour	VarChar (10),
  @sCodeEtat	VarChar (10),
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @sBoiteMail   VarChar (35),
  @iInfoSpbFrn  Integer, 
  @sIdRefFour   VarChar ( 35 ), 
  @sInfoSpbFrnCplt VarChar ( 255 ), 
  @sXMLVar     	VarChar ( 2000 ), 
  @sTypApp 		VarChar ( 3 ),
  @sProduitOrange VarChar ( 3 ),
  @sMarqPort	VarChar(35),
  @sModlPort	VarChar(35),
  @sImei		Varchar(60),
  @sLibPolice	Varchar(35),
  @sLibCie	Varchar(35),
  @sMajPar	VarChar(4),
  @sEmailProduit Varchar(256),
  @sCivLongue Varchar(35),
  @dcIdProdAdh Decimal (7)
  
  
  Set @sMailBody = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  Set @asIdAppli = Upper ( @asIdAppli )
  Set @sTypApp = '' 


	-- Produit Orange ?
	Set @sProduitOrange = 'NON'
	If Exists ( 
			Select	*
			From	sysadm.produit p,
					sysadm.sinistre s
			Where   s.id_sin = @adcIdSin
			And     p.id_prod = s.id_prod
			And		p.id_grp in ( 254, 475 ) )
		Begin
			Set @sProduitOrange = 'OUI'
		End 


	Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL_XML
		@adcIdSin,
		@aiOptionDP,
		@dcIdProd   OUTPUT,
		@sLibProd   OUTPUT,
		@dcIdEts    OUTPUT,
		@sNumProd   OUTPUT,
		@sCiv	    OUTPUT,
		@sNom	    OUTPUT,
		@sMailFrom  OUTPUT,
		@sMailSend  OUTPUT,
		@sMailCc    OUTPUT,
		@sAltQuarant OUTPUT,
		@sBoiteMail  OUTPUT,
		@sXMLVar     OUTPUT

	If @sXMLVar is null Set @sXMLVar = ''

	Select top 1 @sMarqPort=RTrim(IsNull(marq_port,'')),
		@sModlPort=RTrim(IsNull(modl_port,'')),
		@sImei=RTrim(IsNull(num_imei_port,'')),
		@sLibPolice=rtrim(p.lib_police),
		@sLibCie=RTrim(c.lib_cie),
		@sMajPar=Rtrim(s.maj_par),
		@sEmailProduit=IsNull(sysadm.FN_CLE_VAL('ADR_MAIL_PROD',dp.val_car,';') ,''),
		@sCivLongue=IsNull ( sysadm.FN_CODE_NUM(i.cod_civ,'-CL'), 5 ),
		@dcIdProdAdh = IsNull ( pr.cod_prod_dms, 0 )
	From sysadm.w_sin s
		left outer join sysadm.det_pro dp on dp.id_prod=s.id_prod and dp.id_code_dp=136,
		sysadm.w_inter i,
		sysadm.w_gar_sin wg,
		sysadm.garantie g,
		sysadm.police p,
		sysadm.compagnie c,
		sysadm.produit pr
   Where s.id_sin = @adcIdSin
	And  s.id_sin = wg.id_sin
	And  g.id_prod = s.id_prod
	And  g.id_rev = s.id_rev
	and  g.id_gti = wg.id_gti
	And   p.id_police = g.id_police
	And c.id_cie=p.id_cie
	And i.id_sin=s.id_sin
	And i.cod_inter='A'
	and pr.id_prod = s.id_prod
	
	-- Armement du corps du mail 
	Set @sMailObjet = 'SPB Sinistre numéro ' + Convert ( Varchar ( 10 ), @adcIdSin ) + ' ' + @sLibProd

	-- Armement du corps du mail
	Set @sXMLVar = @sXMLVar + '<courrier '
	Set @sXMLVar = @sXMLVar + 'code_courrier_SIMPA2="FICHE_RETOUR_PRET_ET_BE_14" '
	Set @sXMLVar = @sXMLVar + 'code_produit="' + Convert ( VarChar ( 15 ), @dcIdProdAdh  ) + '" '
	Set @sXMLVar = @sXMLVar + 'info_pour_EW="joindre un PDF pour envoyer ce mail" '
	Set @sXMLVar = @sXMLVar + 'produit_orange="' + @sProduitOrange + '" '	
	Set @sXMLVar = @sXMLVar + 'code_maquette="FICHE_RETOUR_PRET_ET_BE_14" '	
	Set @sXMLVar = @sXMLVar + 'nom_produit_cpl="' + IsNull ( @sLibProd, '' )  + '" '
	Set @sXMLVar = @sXMLVar + 'no_dossier_sinistre ="' + convert(varchar(10), @adcIdSin) + '" ' -- [PI062]
	Set @sXMLVar = @sXMLVar + 'civ="' + IsNull ( @sCivLongue, '' ) + '" '
	Set @sXMLVar = @sXMLVar + 'email="' + IsNull ( @sMailSend, '' ) + '" '
	Set @sXMLVar = @sXMLVar + 'app_marque="' + IsNull ( @sMarqPort, '' ) + '" '
	Set @sXMLVar = @sXMLVar + 'app_modele="' + IsNull ( @sModlPort, '' ) + '" '
	Set @sXMLVar = @sXMLVar + 'imei="' + IsNull ( @sImei, '' ) + '" '
	Set @sXMLVar = @sXMLVar + 'police="' + IsNull ( @sLibPolice, '' ) + '" '
	Set @sXMLVar = @sXMLVar + 'assureur="' + IsNull ( @sLibCie, '' ) + '" '
	Set @sXMLVar = @sXMLVar + 'maj_par="' + IsNull ( @sMajPar, '' ) + '" '
	Set @sXMLVar = @sXMLVar + 'email_produit="' + IsNull ( @sEmailProduit, '' )  + '" '
	Set @sXMLVar = @sXMLVar + 'mail_cci="chrono-spb@spb-services.net" '	
	Set @sXMLVar = @sXMLVar + '/>'


	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	Set @sAltQuarant = 'N'


	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin
		   Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V02
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sMailFrom,
			@sMailSend,
			@sMailCc,
			null,
			@sMailObjet,
			'Corps du mail construit par KSL',
			@sAltQuarant,
			@sBoiteMail,
			'O2M14',
			2,
			'KSL',
			'KSL_EDS',
			-1,
			@sXMLVar

	   End    -- TRACE_MAIL_PRO : Fin écriture

	Else
	 Begin
		 Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V02
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sMailFrom,
			@sMailSend,
			@sMailCc,
			null,			
			@sMailObjet,
			'Corps du mail construit par KSL',
			@sAltQuarant,
			@sBoiteMail,
			'O2M14',
			2,
			'KSL',
			'KSL_EDS',			
			-1,
			@sXMLVar
	 End	

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_MAIL_SWAP_FICHE_19
-- Auteur               :       Fabry JF
-- Date                 :       17/09/2014
-- Libelle              :		mail 14
-- Commentaires         :       [PM250-2]
--
-- References           :
--
--------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_MAIL_SWAP_FICHE_19' AND type = 'P' )
        DROP procedure sysadm.PS_I_MAIL_SWAP_FICHE_19
GO

CREATE procedure sysadm.PS_I_MAIL_SWAP_FICHE_19
	@asIdAppli	varchar (20),
	@asBase		varchar (20),
	@aiOptionDP  	Integer,
	@adcIdSin      	Decimal (10) -- [PI062]
AS

Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @dcIdDetail   Decimal (7), -- #4 [SURCOUF_ECH_EXPRESS]
  @dcIdGti      Decimal (7), -- #4 [SURCOUF_ECH_EXPRESS]
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @asHREFURL	VarChar (300),		
  @sSaut	VarChar (10), 
  @sMarque	VarChar (35),
  @sModele	VarChar (35),  
  @sIdFour	VarChar (10),
  @sCodeEtat	VarChar (10),
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @sBoiteMail   VarChar (35),
  @iInfoSpbFrn  Integer, 
  @sIdRefFour   VarChar ( 35 ), 
  @sInfoSpbFrnCplt VarChar ( 255 ), 
  @sXMLVar     	VarChar ( 2000 ), 
  @sTypApp 		VarChar ( 3 ),
  @sProduitOrange VarChar ( 3 ),
  @sMarqPort	VarChar(35),
  @sModlPort	VarChar(35),
  @sImei		Varchar(60),
  @sLibPolice	Varchar(35),
  @sLibCie	Varchar(35),
  @sMajPar	VarChar(4),
  @sEmailProduit Varchar(256),
  @sCivLongue Varchar(35),
  @dcIdProdAdh Decimal (7)
  
  
  Set @sMailBody = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  Set @asIdAppli = Upper ( @asIdAppli )
  Set @sTypApp = '' 


	-- Produit Orange ?
	Set @sProduitOrange = 'NON'
	If Exists ( 
			Select	*
			From	sysadm.produit p,
					sysadm.sinistre s
			Where   s.id_sin = @adcIdSin
			And     p.id_prod = s.id_prod
			And		p.id_grp in ( 254, 475 ) )
		Begin
			Set @sProduitOrange = 'OUI'
		End 




	Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL_XML
		@adcIdSin,
		@aiOptionDP,
		@dcIdProd   OUTPUT,
		@sLibProd   OUTPUT,
		@dcIdEts    OUTPUT,
		@sNumProd   OUTPUT,
		@sCiv	    OUTPUT,
		@sNom	    OUTPUT,
		@sMailFrom  OUTPUT,
		@sMailSend  OUTPUT,
		@sMailCc    OUTPUT,
		@sAltQuarant OUTPUT,
		@sBoiteMail  OUTPUT,
		@sXMLVar     OUTPUT

	Select top 1 @sMarqPort=RTrim(IsNull(marq_port,'')),
		@sModlPort=RTrim(IsNull(modl_port,'')),
		@sImei=RTrim(IsNull(num_imei_port,'')),
		@sLibPolice=rtrim(p.lib_police),
		@sLibCie=RTrim(c.lib_cie),
		@sMajPar=Rtrim(s.maj_par),
		@sEmailProduit=IsNull(sysadm.FN_CLE_VAL('ADR_MAIL_PROD',dp.val_car,';') ,''),
		@sCivLongue=sysadm.FN_CODE_NUM(i.cod_civ,'-CL'),
		@dcIdProdAdh = pr.cod_prod_dms
		
	From sysadm.w_sin s
		left outer join sysadm.det_pro dp on dp.id_prod=s.id_prod and dp.id_code_dp=136,
		sysadm.w_inter i,
		sysadm.w_gar_sin wg,
		sysadm.garantie g,
		sysadm.police p,
		sysadm.compagnie c,
		sysadm.produit pr
   Where s.id_sin = @adcIdSin
	And  s.id_sin = wg.id_sin
	And  g.id_prod = s.id_prod
	And  g.id_rev = s.id_rev
	and  g.id_gti = wg.id_gti
	And   p.id_police = g.id_police
	And c.id_cie=p.id_cie
	And i.id_sin=s.id_sin
	And i.cod_inter='A'
	and pr.id_prod = s.id_prod
	
	-- Armement du corps du mail 
	Set @sMailObjet = 'SPB Sinistre numéro ' + Convert ( Varchar ( 10 ), @adcIdSin ) + ' ' + @sLibProd

	-- Armement du corps du mail
	Set @sXMLVar = @sXMLVar + '<courrier '
	Set @sXMLVar = @sXMLVar + 'code_courrier_SIMPA2="FICHE_SWAP_FICHE_19" '
	Set @sXMLVar = @sXMLVar + 'code_produit="' + Convert ( VarChar ( 15 ), @dcIdProdAdh ) + '" '
	Set @sXMLVar = @sXMLVar + 'info_pour_EW="joindre un PDF pour envoyer ce mail" '
	Set @sXMLVar = @sXMLVar + 'produit_orange="' + @sProduitOrange + '" '	
	Set @sXMLVar = @sXMLVar + 'code_maquette="FICHE_RETOUR_SWAP_FICHE_19" '	
	Set @sXMLVar = @sXMLVar + 'nom_produit_cpl="' + @sLibProd + '" '
	Set @sXMLVar = @sXMLVar + 'no_dossier_sinistre ="' + convert(varchar(10), @adcIdSin) + '" ' -- [PI062]
	Set @sXMLVar = @sXMLVar + 'civ="' + @sCivLongue + '" '
	Set @sXMLVar = @sXMLVar + 'email="' + @sMailSend + '" '
	Set @sXMLVar = @sXMLVar + 'app_marque="' + @sMarqPort + '" '
	Set @sXMLVar = @sXMLVar + 'app_modele="' + @sModlPort + '" '
	Set @sXMLVar = @sXMLVar + 'imei="' + @sImei + '" '
	Set @sXMLVar = @sXMLVar + 'police="' + @sLibPolice + '" '
	Set @sXMLVar = @sXMLVar + 'assureur="' + @sLibCie + '" '
	Set @sXMLVar = @sXMLVar + 'maj_par="' + @sMajPar + '" '
	Set @sXMLVar = @sXMLVar + 'email_produit="' + @sEmailProduit + '" '
	Set @sXMLVar = @sXMLVar + 'mail_cci="chrono-spb@spb-services.net" '		
	Set @sXMLVar = @sXMLVar + '/>'


	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	Set @sAltQuarant = 'N'


	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin
		   Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V02
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sMailFrom,
			@sMailSend,
			@sMailCc,
			null,
			@sMailObjet,
			'Corps du mail construit par KSL',
			@sAltQuarant,
			@sBoiteMail,
			'O2M19',
			2,
			'KSL',
			'KSL_EDS',
			-1,
			@sXMLVar

	   End    -- TRACE_MAIL_PRO : Fin écriture

	Else
	 Begin
		 Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V02
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sMailFrom,
			@sMailSend,
			@sMailCc,
			null,			
			@sMailObjet,
			'Corps du mail construit par KSL',
			@sAltQuarant,
			@sBoiteMail,
			'O2M19',
			2,
			'KSL',
			'KSL_EDS',			
			-1,
			@sXMLVar
	 End	

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_MAILPUSH_ORANGE_CTL_IMEI
-- Auteur               :       FPI 
-- Date                 :       26/01/2015
-- Libelle              :		[DT129]
-- Commentaires         :       ENvoi de mail de contrôle IMEI
--
-- References           :
--
-- Arguments            :      
--				@adcIdSin       Decimal (  7,0 )        (Val)
--
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-------------------------------------------------------------------
-- JFF      14/06/2016   [PC161703]
-- JFF      12/02/2016   [PI062]
-- JFF		16/05/2018   [VDOC26156]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MAILPUSH_ORANGE_CTL_IMEI' AND type = 'P' )
        DROP procedure sysadm.PS_S_MAILPUSH_ORANGE_CTL_IMEI
GO

CREATE procedure sysadm.PS_S_MAILPUSH_ORANGE_CTL_IMEI
	@adcIdSin      	Decimal (10) -- [PI062]
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sPrenom Varchar(35),
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @sNumTelProd  VarChar ( 20 ),
  @sNumFaxProd  VarChar ( 20 ),
  @iIdEts 	Integer,
  @sBoiteMail   VarChar (35),
  @sNumImeiPort VarChar ( 35 ),
  @sNumPort VarChar ( 35 ),
  @sDteSurv		VarChar ( 15 ),
  @sDteAdh		VarChar ( 15 ),
  @sSaut	Varchar(2) ,
  @sAltSuiviSMS VarChar ( 1 ),  
  @sNumGsmSMS   VarChar ( 20 ),
  @asCasRetour  varchar (255),
  @iCptDmde		integer,
  @iOptionDP		integer,
  @sBase	Varchar(100)
  
  Set @sMailBody = ''
  Set @iRet = 0
  Set @sSaut = Char (10)
  Set @iOptionDP=268
  set @sBase=DB_NAME()
  
  If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
   Begin
	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
	Return 0
   End

   Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@sBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumTelProd OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT,  
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #3
	@sAltSuiviSMS OUTPUT, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  
  -- Cas de retour n'étant pas des erreurs
  If @iRet < 0 and @iRet <> -7
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	print @asCasRetour
	Return 0
   End
  
  Select @sMailSend=sysadm.FN_CLE_VAL('ADR_MAIL_IMEI',d.val_car,';'),
	@sMailCc=sysadm.FN_CLE_VAL('ADR_MAIL_CC',d.val_car,';'),
	@sNumImeiPort=s.num_imei_port,
	@sNumPort=s.num_port,
	@sDteSurv=convert(varchar(10),s.dte_surv,103),
	@sDteAdh=convert(varchar(10),s.dte_adh,103),
	@iCptDmde=ds.val_nbre,
	@sNumFaxProd=p.num_fax
  From sysadm.w_sin s
	inner join sysadm.det_pro d on s.id_prod=d.id_prod
	inner join sysadm.produit p on p.id_prod=s.id_prod
	left outer join sysadm.w_div_sin ds on ds.id_sin=s.id_sin and ds.nom_zone='cra_cpt_dmde'
  Where s.id_sin=@adcIdSin
	and d.id_code_dp=@iOptionDP
  

  If @@rowCount=0 -- dossier clos 
  Begin
	   Select @sMailSend=sysadm.FN_CLE_VAL('ADR_MAIL_IMEI',d.val_car,';'),
		@sMailCc=sysadm.FN_CLE_VAL('ADR_MAIL_CC',d.val_car,';'),
		@sNumImeiPort=s.num_imei_port,
		@sNumPort=s.num_port,
		@sDteSurv=convert(varchar(10),s.dte_surv,103),
		@sDteAdh=convert(varchar(10),s.dte_adh,103),
		@iCptDmde=ds.val_nbre,
		@sNumFaxProd=p.num_fax
	  From sysadm.sinistre s
		inner join sysadm.det_pro d on s.id_prod=d.id_prod
		inner join sysadm.produit p on p.id_prod=s.id_prod
		left outer join sysadm.div_sin ds on ds.id_sin=s.id_sin and ds.nom_zone='cra_cpt_dmde'
	  Where s.id_sin=@adcIdSin
		and d.id_code_dp=@iOptionDP
  End

  if @sMailCc <> '' Set @sMailSend=@sMailSend + ',' + @sMailCc -- Correction FPI 01/04/2015
  
--------------------------------------------------------------------------------------------------------------------
-- Construction du mail.
--------------------------------------------------------------------------------------------------------------------
	Select @sCiv = sysadm.FN_TRIM ( IsNull ( sysadm.FN_CODE_NUM ( sysadm.FN_TRIM (p.cod_civ), '-CI' ), '' )),
		 @sNom = sysadm.SPB_FN_INIT_CAP
				     (
				     sysadm.FN_TRIM ( IsNull ( Upper ( Left  ( sysadm.FN_TRIM ( p.nom ), 1) ), '' )) +
				     sysadm.FN_TRIM ( IsNull ( Lower ( Right ( sysadm.FN_TRIM ( p.nom ), Len ( p.nom ) - 1 ) ), '' )),
				     null
				     ),
		@sPrenom=Case When Len ( p.prenom ) <= 1 Then sysadm.FN_TRIM(p.prenom)
				Else sysadm.SPB_FN_INIT_CAP
				     (
				     sysadm.FN_TRIM ( IsNull ( Upper ( Left  ( sysadm.FN_TRIM ( p.prenom ), 1) ), '' )) +
				     sysadm.FN_TRIM ( IsNull ( Lower ( Right ( sysadm.FN_TRIM ( p.prenom ), Len ( p.prenom ) - 1 ) ), '' )),
				     null
				     ) End
	  From   sysadm.sinistre s,
		 sysadm.personne p
	  Where  s.id_sin = @adcIdSin
	  and    s.id_ordre = p.id_ordre
	  
  If @sNom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sNom
   End 

 If @sPrenom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sPrenom
   End 

 	Set @sMailObjet = 'Contrôle assurance IMEI - dossier ' + convert(varchar(10), @adcIdSin) -- [PI062]
	
	Set @sMailBody='Bonjour,' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Nous vous remercions d’effectuer le contrôle IMEI ci-dessous :' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut

	If @sNom = 'AUCUN_NOM_TRANSMIS_PAR_SHERPA' Set @sNom = ''
	If @sPrenom = 'AUCUN_PRENOM_TRANSMIS_PAR_SHERPA' Set @sPrenom = ''
	
	Set @sMailBody=@sMailBody + 'Nom : ' + @sNom + @sSaut
	Set @sMailBody=@sMailBody + 'Prénom : ' +  @sPrenom + @sSaut
	Set @sMailBody=@sMailBody + 'N° IMEI : ' +  @sNumImeiPort + @sSaut
	Set @sMailBody=@sMailBody + 'N° mobile : ' +  @sNumPort + @sSaut
	
	-- [PC161703]
	Set @sMailBody=@sMailBody + @sSaut + @sSaut
	Set @sMailBody=@sMailBody + '================= Section réponse pour ORANGE ====================' + @sSaut + @sSaut
	Set @sMailBody=@sMailBody + 'Date d''adhésion :    /    /' + @sSaut	-- [VDOC26156]
	Set @sMailBody=@sMailBody + 'Date de dernière utilisation :    /    /' + @sSaut + @sSaut	
	Set @sMailBody=@sMailBody + '=> Si SAVEE' + @sSaut
	Set @sMailBody=@sMailBody + '     Date de l''échange :     /    /' + @sSaut
	Set @sMailBody=@sMailBody + '     Marque appareil fourni: ' + @sSaut
	Set @sMailBody=@sMailBody + '     Modèle appareil fourni: ' + @sSaut
	Set @sMailBody=@sMailBody + '     N° IMEI appareil fourni : ' + @sSaut
	Set @sMailBody=@sMailBody + '     Marque appareil d''origine : ' + @sSaut
	Set @sMailBody=@sMailBody + '     Modèle appareil d''origine : ' + @sSaut
	Set @sMailBody=@sMailBody + '     N° IMEI appareil d''origine : ' + @sSaut + @sSaut
	Set @sMailBody=@sMailBody + '=> Si appareil volé ' + @sSaut
	Set @sMailBody=@sMailBody + '     Date de suspension de la ligne : ' + @sSaut
	Set @sMailBody=@sMailBody + '     Heure de suspension de la ligne : ' + @sSaut + @sSaut
	Set @sMailBody=@sMailBody + '===================== Fin Section réponse ========================' + @sSaut + @sSaut + @sSaut

	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Sincères salutations.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Votre gestionnaire d''assurance' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'SPB - ' + @sLibProd + @sSaut
	Set @sMailBody=@sMailBody + 'CS 90000' + @sSaut
	Set @sMailBody=@sMailBody + '76095 Le Havre Cedex' + @sSaut
	Set @sMailBody=@sMailBody + 'Tél. : ' + @sNumTelProd + @sSaut
	Set @sMailBody=@sMailBody + 'Fax : ' + @sNumFaxProd + @sSaut
	Set @sMailBody=@sMailBody + @sBoiteMail
	
	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	Set @sAltQuarant = 'N'

	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin
	     Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
				'SIMPA2',
				@iIdSin, 
				@iIdProd, 
				@sLibProd, 
				@iIdEts, 
				@sMailFrom, 
				@sMailSend, 
				@sMailCc,
				@sMailObjet,
				@sMailBody,
				'N',
				@sBoiteMail, 
				'M30',
				2 

	   End    -- TRACE_MAIL_PRO : Fin écriture

	Else
	 Begin
		  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'M30', 
			2 
	 End	
  
  -- maj des compteurs
  update sysadm.w_div_sin set val_car='N' where id_sin=@adcIdSin and nom_zone='cra_ctrl_imei'
  update sysadm.div_sin set val_car='N' where id_sin=@adcIdSin and nom_zone='cra_ctrl_imei'
 
  If @iCptDmde is null or @iCptDmde=0
  Begin
    INSERT	sysadm.div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_nbre, cree_le, maj_le, maj_par, valide_le, valide_par )
		SELECT	@adcIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N', dp.cpt_tri, 0, GETDATE(), GETDATE(), 'SQL', GETDATE(), 'SQL'
		FROM	sysadm.div_pro dp
		WHERE	dp.id_prod	=	@iIdProd
			AND	dp.nom_zone	in ('cra_cpt_dmde','cra_dat_gen', 'cra_suivi_imei' )
			And not Exists (select * from sysadm.div_sin d where d.id_sin=@adcIdSin and d.nom_zone=dp.nom_zone)
			
	INSERT	sysadm.w_div_sin ( id_sin, nom_zone, lib_label, id_typ_liste, alt_liste_codecar, id_typ_zone, alt_oblig, alt_prot, cpt_tri, val_nbre, cpt_valide, cree_le, maj_le, maj_par )
		SELECT	@adcIdSin, dp.nom_zone, dp.lib_label,  dp.id_typ_liste, dp.alt_liste_codecar, dp.id_typ_zone, dp.alt_oblig, 'N', dp.cpt_tri, 0, 1, GETDATE(), GETDATE(), 'SQL'
		FROM	div_pro dp
		WHERE	dp.id_prod	=	@iIdProd
			AND	dp.nom_zone	in ('cra_cpt_dmde','cra_dat_gen', 'cra_suivi_imei' )
			And not Exists (select * from sysadm.w_div_sin d where d.id_sin=@adcIdSin and d.nom_zone=dp.nom_zone)
			And Exists (select * from sysadm.w_sin s where s.id_sin=@adcIdSin)
  End
  
  update sysadm.w_div_sin set val_dte=GETDATE() where id_sin=@adcIdSin and nom_zone='cra_dat_gen'
  update sysadm.div_sin set val_dte=GETDATE() where id_sin=@adcIdSin and nom_zone='cra_dat_gen'
  update sysadm.w_div_sin set val_nbre=val_nbre + 1 where id_sin=@adcIdSin and nom_zone='cra_cpt_dmde'
  update sysadm.div_sin set val_nbre=val_nbre + 1 where id_sin=@adcIdSin and nom_zone='cra_cpt_dmde'

  update sysadm.w_div_sin set val_nbre = 1 where id_sin=@adcIdSin and nom_zone='cra_suivi_imei'
  update sysadm.div_sin set val_nbre = 1 where id_sin=@adcIdSin and nom_zone='cra_suivi_imei'
	 
  
  Return @iRet

Go

grant execute on sysadm.PS_S_MAILPUSH_ORANGE_CTL_IMEI to rolebddsinistres
Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_I_MAIL_CASTO_DT133
-- Auteur               :       Fabry JF
-- Date                 :       11/02/2015
-- Libelle              :	[DT133_CASTO]
-- Commentaires         :       
--
-- References           :
--
--------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      17/11/2016   J'arme le mailsend par l'email boutique
-- JFF      26/04/2023   [RS5045_REF_MATP]
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_MAIL_CASTO_DT133' AND type = 'P' )
        DROP procedure sysadm.PS_I_MAIL_CASTO_DT133
GO

CREATE procedure sysadm.PS_I_MAIL_CASTO_DT133
	@adcIdSin      	Decimal (10)  -- [PI062]
AS

Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @dcIdDetail   Decimal (7), -- #4 [SURCOUF_ECH_EXPRESS]
  @dcIdGti      Decimal (7), -- #4 [SURCOUF_ECH_EXPRESS]
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @asHREFURL	VarChar (300),		
  @sSaut	VarChar (10), 
  @sMarque	VarChar (35),
  @sModele	VarChar (35),  
  @sIdFour	VarChar (10),
  @sCodeEtat	VarChar (10),
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @sBoiteMail   VarChar (35),
  @iInfoSpbFrn  Integer, 
  @sIdRefFour   VarChar ( 35 ), 
  @sInfoSpbFrnCplt VarChar ( 255 ), 
  @sXMLVar     	VarChar ( 2000 ), 
  @sTypApp 		VarChar ( 3 ),
  @sProduitOrange VarChar ( 3 ),
  @sMarqPort	VarChar(35),
  @sModlPort	VarChar(35),
  @sImei		Varchar(60),
  @sLibPolice	Varchar(35),
  @sLibCie	Varchar(35),
  @sMajPar	VarChar(4),
  @sEmailProduit Varchar(256),
  @sCivLongue Varchar(35),
  @sNomPrenom Varchar(71),
  @sMarqApp	VarChar ( 35 ),
  @sModlApp	VarChar ( 35 ),
  @sCasPceIllisible VarChar ( 35 ),
  @sErrOutPut VarChar ( 255 ) 

Declare @sChaine VarChar ( 50 )
Declare @iNbre  Integer
Declare @iIdSeq integer

Declare @sNomZone VarChar ( 35 )
Declare @sLibZone VarChar ( 35 )

Declare @sIdAppli	varchar (20)
Declare @sBase		varchar (20)
Declare @iOptionDP  	Integer
Declare @iDernIdentity  Integer
Declare @sNumticket VarChar ( 10 )
Declare @dcIdProdAdh Decimal ( 7 )

Declare @iNbrePce integer
Declare @iCpt integer
Declare @iNbrAjout integer
Declare @iNbrPieceTot integer
  
  Set @iOptionDP = -1
  Set @sBase = Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) )
  Set @sIdAppli	= 'SIMPA2'
  
  Set @sMailBody = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  Set @sIdAppli = Upper ( @sIdAppli )
  Set @sTypApp = '' 
  Set @sCasPceIllisible = 'NON'

	If 	Not Exists ( 
		Select wds.val_car
		From   sysadm.w_div_sin wds
		Where  wds.id_sin = @adcIdSin
		And	   wds.nom_zone = 'pce_mail_casto'
		And	   wds.val_car = 'O'
		)
		Begin
			Return
		End 

	DECLARE @tbDT133 TABLE 
		( id_seq	integer identity,
		  chaine 	Varchar ( 50 ),
		  marquage	integer null 
		)

	Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL_XML
		@adcIdSin,
		@iOptionDP,
		@dcIdProd   OUTPUT,
		@sLibProd   OUTPUT,
		@dcIdEts    OUTPUT,
		@sNumProd   OUTPUT,
		@sCiv	    OUTPUT,
		@sNom	    OUTPUT,
		@sMailFrom  OUTPUT,
		@sMailSend  OUTPUT,
		@sMailCc    OUTPUT,
		@sAltQuarant OUTPUT,
		@sBoiteMail  OUTPUT,
		@sXMLVar     OUTPUT

	Select top 1 
		@sMajPar=Rtrim(s.maj_par),
		@sEmailProduit= rtrim ( b.adr_mail ),
		@sCivLongue=sysadm.FN_CODE_NUM(i.cod_civ,'-CL'),
		@sNomPrenom = RTRIM (i.nom),
		@sNumticket = IsNull ( ( Select CONVERT ( VarChar ( 10 ) , ds.val_nbre )
						From sysadm.div_sin ds
						Where ds.id_sin = s.id_sin
						And   ds.nom_zone = 'num_ticket' ), ''),
		@dcIdProdAdh = p.cod_prod_dms,
		@sMarqApp = RTrim(IsNull(s.marq_port,'')),
		@sModlApp = RTrim(IsNull(s.modl_port,''))
			
	From sysadm.w_sin s,
		 sysadm.det_pro dp,
		 sysadm.w_inter i,
		 sysadm.boutique b,
		 sysadm.produit p
   Where s.id_sin = @adcIdSin
    And dp.id_prod = s.id_prod
	And dp.id_code_dp = 43
	And i.id_sin = s.id_sin
	And i.cod_inter = 'A'
	And b.id_prod = s.id_prod
	and b.id_boutique = s.id_orian_boutique
	and p.id_prod = s.id_prod

	-- 17/11/2016 JFF
	If @sEmailProduit is not null And @sEmailProduit <> '' Set @sMailSend = @sEmailProduit

	If @@ROWCOUNT <> 1 
		Begin
			Update sysadm.w_div_sin
			Set val_car = 'N'
			Where id_sin = @adcIdSin
			And   nom_zone in ( 'pce_mail_casto', 'pce_illisible_casto' ) -- [DT330]
			
			Update sysadm.div_sin
			Set val_car = 'N'
			Where id_sin = @adcIdSin
			And   nom_zone in ( 'pce_mail_casto', 'pce_illisible_casto' ) -- [DT330]
			
			Return 0
		End 
	
	
	If @sEmailProduit is null Set @sEmailProduit = ''
	If @sEmailProduit = '' 
		Begin
			Update sysadm.w_div_sin
			Set val_car = 'N'
			Where id_sin = @adcIdSin
			And   nom_zone in ( 'pce_mail_casto', 'pce_illisible_casto' ) -- [DT330]
			
			Update sysadm.div_sin
			Set val_car = 'N'
			Where id_sin = @adcIdSin
			And   nom_zone in ( 'pce_mail_casto', 'pce_illisible_casto' ) -- [DT330]
			
			Return 0
		End 
	
	-- [DT330]
	If 	Exists ( 
		Select wds.val_car
		From   sysadm.w_div_sin wds
		Where  wds.id_sin = @adcIdSin
		And	   wds.nom_zone = 'pce_illisible_casto'
		And	   wds.val_car = 'O'
		)
		Begin
			Set @sCasPceIllisible = 'OUI'
		End 

	-- Armement du corps du mail 
	Set @sMailObjet = 'SPB Sinistre numéro ' + Convert ( Varchar ( 10 ), @adcIdSin ) + ' ' + @sLibProd

	-- Armement du corps du mail
	Set @sXMLVar = @sXMLVar + '<courrier '
	Set @sXMLVar = @sXMLVar + 'code_courrier_SIMPA2="MAIL_CASTO_DT133_ORIG" '
	Set @sXMLVar = @sXMLVar + 'code_produit="' + Convert ( VarChar ( 15 ), @dcIdProdAdh ) + '" '

	-- [DT330]
	Set @sXMLVar = @sXMLVar + 'cas_piece_illisible="' + @sCasPceIllisible + '" '

	Set @sXMLVar = @sXMLVar + 'app_marque="' + @sMarqApp + '" '
	Set @sXMLVar = @sXMLVar + 'app_modele="' + @sModlApp + '" '
	Set @sXMLVar = @sXMLVar + 'code_maquette="MAIL_CASTO_DT133_ORIG" '	
	Set @sXMLVar = @sXMLVar + 'nom_produit_cpl="' + @sLibProd + '" '
	Set @sXMLVar = @sXMLVar + 'no_dossier_sinistre ="' + convert(varchar(10), @adcIdSin) + '" '  -- [PI062]
	Set @sXMLVar = @sXMLVar + 'civ="' + @sCivLongue + '" '
	Set @sXMLVar = @sXMLVar + 'email="' + @sEmailProduit + '" '
	Set @sXMLVar = @sXMLVar + 'maj_par="' + @sMajPar + '" '
	Set @sXMLVar = @sXMLVar + 'Nom_Prenom="' + @sNomPrenom + '" '
	Set @sXMLVar = @sXMLVar + 'Num_ticket="' + @sNumticket + '" '
	Set @sXMLVar = @sXMLVar + ' >'
	
	-- Insertion des pièces
	Set @sXMLVar = @sXMLVar	+ '<tableaux>'
	Set @sXMLVar = @sXMLVar	+ '<T1>'	

	-- [DT330]
	Set @iNbrPieceTot = 7

	Insert into @tbDT133
	Select '<t1Lig col' + convert ( varchar, row_number() over (partition by wp.id_sin order by wp.id_pce)) + '="' + convert ( varchar ( 20), wp.id_pce ) + '" />',
		0
	From sysadm.w_piece wp,
			sysadm.w_inter i
	Where i.id_sin = @adcIdSin
	And   i.cod_inter = 'B'
	And   wp.id_sin = i.id_sin
	And   wp.id_pce in ( 316, 314, 48, 315, 385, 386, 588 )
	And   wp.id_i = i.id_i

	Select @iNbrePce = Count (*) 
	From sysadm.w_piece wp,
			sysadm.w_inter i
	Where i.id_sin = @adcIdSin
	And   i.cod_inter = 'B'
	And   wp.id_sin = i.id_sin
	And   wp.id_pce in ( 316, 314, 48, 315, 385, 386, 588 )
	And   wp.id_i = i.id_i

	Set @iNbrAjout = @iNbrPieceTot - @iNbrePce

	set @iCpt = @iNbrePce + 1
	While @iCpt <= @iNbrPieceTot 
		Begin
		Insert into @tbDT133	
		Select '<t1Lig col' + convert ( varchar, @iCpt ) + '="" />', 0		
		Set @iCpt = @iCpt + 1
		End 


	While Exists ( Select * From @tbDT133 where marquage = 0 )
	 Begin
		Select 	Top 1 
			@iIdSeq = id_seq,
			@sChaine = rtrim ( chaine )
		From	@tbDT133
		Where	marquage = 0
		
		Set @sXMLVar = @sXMLVar + @sChaine

		Update @tbDT133
		Set marquage = 1
		Where id_seq = @iIdSeq
	 End


	
	Set @sXMLVar = @sXMLVar + '</T1>'	
	Set @sXMLVar = @sXMLVar + '</tableaux>'
	Set @sXMLVar = @sXMLVar + '</courrier>'


	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	Set @sAltQuarant = 'N'


	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin
		-- [RS5045_REF_MATP]
		If sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') > 0 
		  Begin
			Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_RS5045_I_MAIL_PUSH_KSL
				@sIdAppli,
				@iIdSin,
				@iIdProd,
				@sLibProd,
				@iIdEts,
				@sMailFrom,
				@sMailSend,
				@sMailCc,
				null,
				@sMailObjet,
				'Corps du mail construit par KSL',
				@sBoiteMail,
				'CAST1M',
				2,
				-1,
				@sXMLVar,
				null, -- id_chem, peut être forcé mais si null, sera pris par défaut sysadm.code_maquette_ksl_rs5045
				null, -- dteh_exec
				@sErrOutPut OutPut

		  End 
		Else
		  Begin
			   Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V02
				@sIdAppli,
				@iIdSin,
				@iIdProd,
				@sLibProd,
				@iIdEts,
				@sMailFrom,
				@sMailSend,
				@sMailCc,
				null,
				@sMailObjet,
				'Corps du mail construit par KSL',
				@sAltQuarant,
				@sBoiteMail,
				'CAST1M',
				2,
				'KSL',
				'KSL_EDS',     
				-1,
				@sXMLVar
		  End
		  
			Set @iDernIdentity = @@IDENTITY

	   End    -- TRACE_MAIL_PRO : Fin écriture

	Else
	 Begin
		-- [RS5045_REF_MATP]
		If sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') > 0 
		  Begin
			Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_RS5045_I_MAIL_PUSH_KSL
				@sIdAppli,
				@iIdSin,
				@iIdProd,
				@sLibProd,
				@iIdEts,
				@sMailFrom,
				@sMailSend,
				@sMailCc,
				null,
				@sMailObjet,
				'Corps du mail construit par KSL',
				@sBoiteMail,
				'CAST1M',
				2,
				-1,
				@sXMLVar,
				null, -- id_chem, peut être forcé mais si null, sera pris par défaut sysadm.code_maquette_ksl_rs5045
				null, -- dteh_exec
				@sErrOutPut OutPut

		  End 
		Else
		  Begin
			   Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V02
				@sIdAppli,
				@iIdSin,
				@iIdProd,
				@sLibProd,
				@iIdEts,
				@sMailFrom,
				@sMailSend,
				@sMailCc,
				null,
				@sMailObjet,
				'Corps du mail construit par KSL',
				@sAltQuarant,
				@sBoiteMail,
				'CAST1M',
				2,
				'KSL',
				'KSL_EDS',     
				-1,
				@sXMLVar
		  End
		  
			Set @iDernIdentity = @@IDENTITY

			
	 End	


	If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
	  Begin
		If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'id_seq_pce_mail_casto')
		 Begin
		   Update sysadm.w_div_sin Set val_nbre = @iDernIdentity , maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @adcIdSin And nom_zone = 'id_seq_pce_mail_casto'
		 End 
		Else
		 Begin	 
		   Insert into sysadm.w_div_sin values ( @adcIdSin, 'id_seq_pce_mail_casto', 'Identifiant mail pièce casto orig', '-1', 'N', 'N', 'N', 'N', 200, @iDernIdentity, null, null, null, 1, getdate(), getdate(), 'AUTO' ) 
		 End
	  End


	If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
	  Begin
		If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'id_seq_pce_mail_casto')
		 Begin
		   Update sysadm.div_sin Set val_nbre = @iDernIdentity , maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @adcIdSin And nom_zone = 'id_seq_pce_mail_casto'
		 End 
		Else
		 Begin	 
		   Insert into sysadm.div_sin values ( @adcIdSin, 'id_seq_pce_mail_casto', 'Identifiant mail pièce casto orig', '-1', 'N', 'N', 'N', 'N', 200, @iDernIdentity, null, null, null, getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 
		 End
	  End

	Set @sNomZone = 'dte_mail_casto_orig'
	Set @sLibZone = 'Date mail casto original'

	If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
	  Begin
		If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = @sNomZone )
		 Begin
		   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @adcIdSin And nom_zone = @sNomZone
		 End 
		Else
		 Begin	 
		   Insert into sysadm.w_div_sin values ( @adcIdSin, @sNomZone, @sLibZone, '-1', 'N', 'D', 'N', 'N', 210, null, null, getdate(), null, 1, getdate(), getdate(), 'AUTO' ) 
		 End
	  End

	If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
	  Begin
		If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = @sNomZone)
		 Begin
		   Update sysadm.div_sin Set val_dte = GETDATE() , maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @adcIdSin And nom_zone = @sNomZone
		 End 
		Else
		 Begin	 
		   Insert into sysadm.div_sin values ( @adcIdSin, @sNomZone, @sLibZone, '-1', 'N', 'D', 'N', 'N', 210, null, null, GETDATE(), null, getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 
		 End
	  End


	Update sysadm.w_div_sin
	Set val_car = 'N'
	Where id_sin = @adcIdSin
	And   nom_zone in ( 'pce_mail_casto', 'pce_illisible_casto' ) -- [DT330]
				
	Update sysadm.div_sin
	Set val_car = 'N'
	Where id_sin = @adcIdSin
	And   nom_zone in ( 'pce_mail_casto', 'pce_illisible_casto' ) -- [DT330]

Go

grant execute on sysadm.PS_I_MAIL_CASTO_DT133 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_I_MAIL_CASTO_DT133_REL
-- Auteur               :       Fabry JF
-- Date                 :       11/02/2015
-- Libelle              :	[DT133_CASTO]
-- Commentaires         :       
--
-- References           :
--
-- JFF   22/12/2015 [ITSM351580]
-- JFF      12/02/2016   [PI062]
-- JFF      26/04/2023   [RS5045_REF_MATP]
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_MAIL_CASTO_DT133_REL' AND type = 'P' )
        DROP procedure sysadm.PS_I_MAIL_CASTO_DT133_REL
GO

CREATE procedure sysadm.PS_I_MAIL_CASTO_DT133_REL
	@adcIdSin      	Decimal (10), -- [PI062]
	@asCas			VarChar ( 35)
AS

Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @dcIdDetail   Decimal (7), -- #4 [SURCOUF_ECH_EXPRESS]
  @dcIdGti      Decimal (7), -- #4 [SURCOUF_ECH_EXPRESS]
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @asHREFURL	VarChar (300),		
  @sSaut	VarChar (10), 
  @sMarque	VarChar (35),
  @sModele	VarChar (35),  
  @sIdFour	VarChar (10),
  @sCodeEtat	VarChar (10),
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @sBoiteMail   VarChar (35),
  @iInfoSpbFrn  Integer, 
  @sIdRefFour   VarChar ( 35 ), 
  @sInfoSpbFrnCplt VarChar ( 255 ), 
  @sXMLVar     	VarChar ( 2000 ), 
  @sTypApp 		VarChar ( 3 ),
  @sProduitOrange VarChar ( 3 ),
  @sMarqPort	VarChar(35),
  @sModlPort	VarChar(35),
  @sImei		Varchar(60),
  @sLibPolice	Varchar(35),
  @sLibCie	Varchar(35),
  @sMajPar	VarChar(4),
  @sEmailProduit Varchar(256),
  @sCivLongue Varchar(35),
  @sNomPrenom Varchar(71),
  @sMarqApp	VarChar ( 35 ),
  @sModlApp	VarChar ( 35 ),
  @dcIdProdAdh Decimal (7),
  @sNumticket VarChar ( 35 ),
  @sErrOutPut VarChar ( 255 ) 

Declare @sChaine VarChar ( 50 )
Declare @iNbre  Integer
Declare @iIdSeq integer

Declare @sIdAppli	varchar (20)
Declare @sBase		varchar (20)
Declare @iOptionDP  	Integer
Declare @iDernIdentity  Integer
Declare @sTypMail   VarChar ( 10 )
Declare @sIdSeqMailOrig VarChar ( 20 )  
Declare @sNomZone VarChar ( 35 )
Declare @sLibZone VarChar ( 35 )
Declare @iTri Integer
  
  Set @iOptionDP = -1
  Set @sBase = Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) )
  Set @sIdAppli	= 'SIMPA2'
  
  Set @sMailBody = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  Set @sIdAppli = Upper ( @sIdAppli )
  Set @sTypApp = '' 


	Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL_XML
		@adcIdSin,
		@iOptionDP,
		@dcIdProd   OUTPUT,
		@sLibProd   OUTPUT,
		@dcIdEts    OUTPUT,
		@sNumProd   OUTPUT,
		@sCiv	    OUTPUT,
		@sNom	    OUTPUT,
		@sMailFrom  OUTPUT,
		@sMailSend  OUTPUT,
		@sMailCc    OUTPUT,
		@sAltQuarant OUTPUT,
		@sBoiteMail  OUTPUT,
		@sXMLVar     OUTPUT

	Select top 1 
		@sMajPar=Rtrim(s.maj_par),
		@sEmailProduit= rtrim ( b.adr_mail ),
		@sCivLongue=sysadm.FN_CODE_NUM(i.cod_civ,'-CL'),
		@sNomPrenom = RTRIM (i.nom),
		@sNumticket = IsNull ( ( Select CONVERT ( VarChar ( 10 ) , ds.val_nbre )
						From sysadm.div_sin ds
						Where ds.id_sin = s.id_sin
						And   ds.nom_zone = 'num_ticket' ), ''),		
		@sIdSeqMailOrig = Convert ( Varchar ( 20 ), ds.val_nbre ) ,
		@dcIdProdAdh = p.cod_prod_dms,
		@sMarqApp = RTrim(IsNull(s.marq_port,'')),
		@sModlApp = RTrim(IsNull(s.modl_port,''))
				
	From sysadm.sinistre s,
		 sysadm.det_pro dp,
		 sysadm.inter i,
		 sysadm.boutique b,
		 sysadm.produit p,
		 sysadm.div_sin ds
   Where s.id_sin = @adcIdSin
    And dp.id_prod = s.id_prod
	And dp.id_code_dp = 43
	And i.id_sin = s.id_sin
	And i.cod_inter = 'A'
	And b.id_prod = s.id_prod
	and b.id_boutique = s.id_orian_boutique
	and ds.id_sin = s.id_sin
	and ds.nom_zone = 'id_seq_pce_mail_casto'
	and p.id_prod = s.id_prod
	

	If @@ROWCOUNT <> 1 Return 0
	
	If @sEmailProduit is null Set @sEmailProduit = ''
	If @sEmailProduit = '' Return 0
	
	-- Armement du corps du mail 
	Set @sMailObjet = 'SPB Sinistre numéro ' + Convert ( Varchar ( 10 ), @adcIdSin ) + ' ' + @sLibProd

	-- Armement du corps du mail
	Set @sXMLVar = @sXMLVar + '<courrier '
	
	If @asCas = '1REL'
	 Begin
		Set @sXMLVar = @sXMLVar + 'code_courrier_SIMPA2="MAIL_CASTO_DT133_1REL" '	 
	 End 
	
	If @asCas = '2REL'
	 Begin
		Set @sXMLVar = @sXMLVar + 'code_courrier_SIMPA2="MAIL_CASTO_DT133_2REL" '	 
	 End 


	Set @sXMLVar = @sXMLVar + 'code_produit="' + Convert ( VarChar ( 15 ), @dcIdProd  ) + '" '

	If @asCas = '1REL'
	 Begin
		Set @sXMLVar = @sXMLVar + 'code_maquette="MAIL_CASTO_DT133_1REL" '	
	 End
	 
	If @asCas = '2REL'
	 Begin
		Set @sXMLVar = @sXMLVar + 'code_maquette="MAIL_CASTO_DT133_2REL" '	
	 End
	
	Set @sXMLVar = @sXMLVar + 'nom_produit_cpl="' + @sLibProd + '" '
	Set @sXMLVar = @sXMLVar + 'no_dossier_sinistre ="' + convert(varchar(10), @adcIdSin) + '" ' -- [PI062]
--	Set @sXMLVar = @sXMLVar + 'code_produit="' + Convert ( VarChar ( 15 ), @dcIdProdAdh ) + '" ' shunt sur [ITSM351580]
	Set @sXMLVar = @sXMLVar + 'app_marque="' + @sMarqApp + '" '
	Set @sXMLVar = @sXMLVar + 'app_modele="' + @sModlApp + '" '	
	Set @sXMLVar = @sXMLVar + 'civ="' + @sCivLongue + '" '
	Set @sXMLVar = @sXMLVar + 'email="' + @sEmailProduit + '" '
	Set @sXMLVar = @sXMLVar + 'maj_par="' + @sMajPar + '" '
	Set @sXMLVar = @sXMLVar + 'Nom_Prenom="' + @sNomPrenom + '" '
	Set @sXMLVar = @sXMLVar + 'IdSeq_Mail_Orig="' + @sIdSeqMailOrig + '" '  -- [ITSM351580] esp en +
	Set @sXMLVar = @sXMLVar + 'Num_ticket="' + @sNumticket + '" '	
	Set @sXMLVar = @sXMLVar + '/>'


	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	Set @sAltQuarant = 'N'

	If @asCas = '1REL'
	 Begin
		set @sTypMail = 'CAST1R'
	 End 

	If @asCas = '2REL'
	 Begin
		set @sTypMail = 'CAST2R'
	 End 


	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin
		-- [RS5045_REF_MATP]
		If sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') > 0 
		  Begin
			Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_RS5045_I_MAIL_PUSH_KSL
				@sIdAppli,
				@iIdSin,
				@iIdProd,
				@sLibProd,
				@iIdEts,
				@sMailFrom,
				@sMailSend,
				@sMailCc,
				null,
				@sMailObjet,
				'Corps du mail construit par KSL',
				@sBoiteMail,
				@sTypMail,
				2,
				-1,
				@sXMLVar,
				null, -- id_chem, peut être forcé mais si null, sera pris par défaut sysadm.code_maquette_ksl_rs5045
				null, -- dteh_exec
				@sErrOutPut OutPut

		  End 
		Else
		  Begin

		   Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V02
			@sIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sMailFrom,
			@sMailSend,
			@sMailCc,
			null,
			@sMailObjet,
			'Corps du mail construit par KSL',
			@sAltQuarant,
			@sBoiteMail,
			@sTypMail,
			2,
			'KSL',
			'KSL_EDS',
			-1,
			@sXMLVar
		 End
		
		Set @iDernIdentity = @@IDENTITY

	   End    -- TRACE_MAIL_PRO : Fin écriture

	Else
	 Begin
		-- [RS5045_REF_MATP]
		If sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') > 0 
		  Begin
			Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_RS5045_I_MAIL_PUSH_KSL
				@sIdAppli,
				@iIdSin,
				@iIdProd,
				@sLibProd,
				@iIdEts,
				@sMailFrom,
				@sMailSend,
				@sMailCc,
				null,
				@sMailObjet,
				'Corps du mail construit par KSL',
				@sBoiteMail,
				@sTypMail,
				2,
				-1,
				@sXMLVar,
				null, -- id_chem, peut être forcé mais si null, sera pris par défaut sysadm.code_maquette_ksl_rs5045
				null, -- dteh_exec
				@sErrOutPut OutPut

		  End 
		Else
		  Begin

		   Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V02
			@sIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sMailFrom,
			@sMailSend,
			@sMailCc,
			null,
			@sMailObjet,
			'Corps du mail construit par KSL',
			@sAltQuarant,
			@sBoiteMail,
			@sTypMail,
			2,
			'KSL',
			'KSL_EDS',
			-1,
			@sXMLVar
		 End
		
		Set @iDernIdentity = @@IDENTITY
			
	 End	

	If @asCas = '1REL'
	 Begin
		Set @sNomZone = 'dte_mail_casto_1rel'
		Set @sLibZone = 'Date mail 1ère relance casto'
		Set @iTri = 220
     End		

	If @asCas = '2REL'
	 Begin
		Set @sNomZone = 'dte_mail_casto_2rel'
		Set @sLibZone = 'Date mail 2ème relance casto'		
		Set @iTri = 230		
     End

	If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
	  Begin
		If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = @sNomZone )
		 Begin
		   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @adcIdSin And nom_zone = @sNomZone
		 End 
		Else
		 Begin	 
		   Insert into sysadm.w_div_sin values ( @adcIdSin, @sNomZone, @sLibZone, '-1', 'N', 'D', 'N', 'N', @iTri, null, null, getdate(), null, 1, getdate(), getdate(), 'AUTO' ) 
		 End
	  End

	If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
	  Begin
		If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = @sNomZone)
		 Begin
		   Update sysadm.div_sin Set val_dte = GETDATE() , maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @adcIdSin And nom_zone = @sNomZone
		 End 
		Else
		 Begin	 
		   Insert into sysadm.div_sin values ( @adcIdSin, @sNomZone, @sLibZone, '-1', 'N', 'D', 'N', 'N', @iTri, null, null, GETDATE(), null, getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 
		 End
	  End

Go

grant execute on sysadm.PS_I_MAIL_CASTO_DT133_REL to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_AGENT_MAIL_CASTO_DT133
-- Auteur               :       Fabry JF
-- Date                 :       11/02/2015
-- Libelle              :	[DT133_CASTO]
-- Commentaires         :       
--
-- References           :
--------------------------------------------------------------------
-- JFF  27/04/2016  [VDOC20710]
-- JFF      12/02/2016   [PI062]
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_AGENT_MAIL_CASTO_DT133' AND type = 'P' )
        DROP procedure sysadm.PS_AGENT_MAIL_CASTO_DT133
GO

CREATE procedure sysadm.PS_AGENT_MAIL_CASTO_DT133

As

--1 ère relance

DECLARE @tbDT133_1 TABLE 
	( id_seq	integer identity,
	  id_sin	decimal ( 10 ), -- [PI062]
	  marquage	integer null 
	)

Declare @dcIdSin decimal ( 10 ) -- [PI062]
Declare @iNbre  Integer
Declare @iIdSeq integer

Insert into @tbDT133_1
Select	ds.id_sin,
		0
from	sysadm.div_sin ds,
		sysadm.sinistre s
where   ds.nom_zone = 'dte_mail_casto_orig'
And		ds.val_dte is not null
And		s.id_sin = ds.id_sin
And		Not Exists ( 
			Select * 
			From sysadm.div_sin ds1
			Where ds1.id_sin = ds.id_sin
			And	  ds1.nom_zone = 'dte_mail_casto_1rel'
		) 
And		ds.val_dte < DATEADD ( DAY, -30, GETDATE() )
And     -- [VDOC20710]
Exists ( Select Top 1 1
			From   sysadm.w_piece wp,
					sysadm.w_inter i
			Where  wp.id_sin = s.id_sin
			And    wp.id_pce in ( 316, 314, 48, 315, 385, 386, 588 )
			And    wp.id_i = i.id_i
			And    i.id_sin = wp.id_sin 
			And    i.cod_inter = 'B'
		) -- qu'il reste encore au moins une pièce éligible : 316;314;48;315; 386; 385;588 
And 
Not Exists ( Select Top 1 1 
				From sysadm.reglement r,
					sysadm.w_inter i
				Where r.id_sin = s.id_sin
				And   r.cod_inter = 'F'
				And   i.id_sin = r.id_sin
				And   i.cod_inter = r.cod_inter
				And   i.id_four = 'CAS'
			) -- si il n'y a aucun règlement fait à CASTO 
					   



While Exists ( Select * From @tbDT133_1 where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdSin = id_sin
	From	@tbDT133_1
	Where	marquage = 0


	Exec sysadm.PS_I_MAIL_CASTO_DT133_REL @dcIdSin, '1REL'

	Update @tbDT133_1
	Set marquage = 1
	Where id_seq = @iIdSeq
 End

Delete @tbDT133_1

Insert into @tbDT133_1
Select	ds.id_sin,
		0
from	sysadm.div_sin ds,
		sysadm.sinistre s
where   ds.nom_zone = 'dte_mail_casto_1rel'
And		ds.val_dte is not null
And		s.id_sin = ds.id_sin
And		Not Exists ( 
			Select * 
			From sysadm.div_sin ds1
			Where ds1.id_sin = ds.id_sin
			And	  ds1.nom_zone = 'dte_mail_casto_2rel'
		) 
And		ds.val_dte < DATEADD ( DAY, -30, GETDATE() )
And     -- [VDOC20710]
	(
	Exists ( Select Top 1 1
				From   sysadm.w_piece wp,
					 	sysadm.w_inter i
				Where  wp.id_sin = s.id_sin
				And    wp.id_pce in ( 316, 314, 48, 315, 385, 386, 588 )
				And    wp.id_i = i.id_i
				And    i.id_sin = wp.id_sin 
				And    i.cod_inter = 'B'
			) -- qu'il reste encore au moins une pièce éligible : 316;314;48;315; 386; 385;588 
	And 
	Not Exists ( Select Top 1 1 
					From sysadm.reglement r,
						sysadm.w_inter i
					Where r.id_sin = s.id_sin
					And   r.cod_inter = 'F'
					And   i.id_sin = r.id_sin
					And   i.cod_inter = r.cod_inter
					And   i.id_four = 'CAS'
				) -- si il n'y a aucun règlement fait à CASTO 
					   
	)


While Exists ( Select * From @tbDT133_1 where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdSin = id_sin
	From	@tbDT133_1
	Where	marquage = 0

	Exec sysadm.PS_I_MAIL_CASTO_DT133_REL @dcIdSin, '2REL'

	Update @tbDT133_1
	Set marquage = 1
	Where id_seq = @iIdSeq
 End
 
Go
 
grant execute on sysadm.PS_AGENT_MAIL_CASTO_DT133 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_MAIL_DEM_PIECE_SBE
-- Auteur               :       Fabry JF
-- Date                 :       14/04/2015
-- Libelle              :		
-- Commentaires         :       [DT141]
--
-- References           :		N'est plus appeler, code obsolète suivant passage à la mode OV3/KSL.
--
--------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_MAIL_DEM_PIECE_SBE' AND type = 'P' )
        DROP procedure sysadm.PS_I_MAIL_DEM_PIECE_SBE
GO

CREATE procedure sysadm.PS_I_MAIL_DEM_PIECE_SBE
	@asIdAppli	varchar (20),
	@asBase		varchar (20),
	@aiOptionDP  	Integer,
	@adcIdSin      	Decimal (10) -- [PI062]
AS

-- shunt définitif.
Return

Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @dcIdDetail   Decimal (7), -- #4 [SURCOUF_ECH_EXPRESS]
  @dcIdGti      Decimal (7), -- #4 [SURCOUF_ECH_EXPRESS]
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @asHREFURL	VarChar (300),		
  @sSaut	VarChar (10), 
  @sMarque	VarChar (35),
  @sModele	VarChar (35),  
  @sIdFour	VarChar (10),
  @sCodeEtat	VarChar (10),
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @iIdEts 	Integer,
  @sBoiteMail   VarChar (35),
  @iInfoSpbFrn  Integer, 
  @sIdRefFour   VarChar ( 35 ), 
  @sInfoSpbFrnCplt VarChar ( 255 ), 
  @sXMLVar     	VarChar ( 2000 ), 
  @sTypApp 		VarChar ( 3 ),
  @sProduitOrange VarChar ( 3 ),
  @sMarqPort	VarChar(35),
  @sModlPort	VarChar(35),
  @sImei		Varchar(60),
  @sLibPolice	Varchar(35),
  @sLibCie	Varchar(35),
  @sMajPar	VarChar(4),
  @sEmailProduit Varchar(256),
  @sCivLongue Varchar(35),
  @dcIdProdAdh Decimal (7),
  @sDteDecl VarChar ( 20 ),
  @sNomAss VarChar ( 35 ),
  @sPrenomAss VarChar ( 35 ),
  @sAdr1 VarChar ( 71 ),
  @sAdrCP VarChar ( 5 ),
  @sAdrVille VarChar ( 35 ),
  @sIdProdSin VarChar ( 10 ),
  @sNumTelProd VarChar ( 20 ),
  @sNumFaxProd VarChar ( 20 ),
  @sNumLigneAssu VarChar ( 20 ),
  @sCodeGest VarChar ( 4 )
  
  Set @sMailBody = ''
  Set @sSaut = Char (10)
  Set @iRet = 0
  Set @asIdAppli = Upper ( @asIdAppli )
  Set @sTypApp = '' 


	Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL_XML
		@adcIdSin,
		@aiOptionDP,
		@dcIdProd   OUTPUT,
		@sLibProd   OUTPUT,
		@dcIdEts    OUTPUT,
		@sNumProd   OUTPUT,
		@sCiv	    OUTPUT,
		@sNom	    OUTPUT,
		@sMailFrom  OUTPUT,
		@sMailSend  OUTPUT,
		@sMailCc    OUTPUT,
		@sAltQuarant OUTPUT,
		@sBoiteMail  OUTPUT,
		@sXMLVar     OUTPUT

	Select top 1 @sMarqPort=RTrim(IsNull(marq_port,'')),
		@sModlPort=RTrim(IsNull(modl_port,'')),
		@sImei=RTrim(IsNull(num_imei_port,'')),
		@sLibPolice=rtrim(p.lib_police),
		@sLibCie=RTrim(c.lib_cie),
		@sMajPar=Rtrim(s.maj_par),
		@sCivLongue=sysadm.FN_CODE_NUM(i.cod_civ,'-CL'),
		@dcIdProdAdh = pr.cod_prod_dms,
		@sDteDecl = convert(varchar(10),s.dte_decl,20), 
		@sNomAss = RTRIM ( IsNull (s.nom, '')),
		@sPrenomAss = RTRIM ( IsNull (s.prenom, '') ),
		@sAdr1 = RTRIM ( IsNull ( i.adr_1, '' ) ) + ' ' + RTRIM ( IsNull ( i.adr_2, '' ) ),
		@sAdrCP = RTRIM ( IsNull ( i.adr_cp, '' ) ),
		@sAdrVille = RTRIM ( IsNull ( i.adr_ville, '' ) ),
		@sIdProdSin = CONVERT ( Varchar ( 10 ), s.id_prod ),
		@sNumTelProd = RTRIM ( IsNull ( pr.num_tel, '' )),
		@sNumFaxProd = RTRIM ( IsNull ( pr.num_fax, '' )),	
		@sNumLigneAssu = RTRIM ( IsNull ( i.num_teld, '' ) ),
		@sCodeGest = RTRIM ( IsNull ( s.maj_par, '' ) )
		
	From sysadm.w_sin s,
		sysadm.w_inter i,
		sysadm.w_gar_sin wg,
		sysadm.garantie g,
		sysadm.police p,
		sysadm.compagnie c,
		sysadm.produit pr
   Where s.id_sin = @adcIdSin
	And  s.id_sin = wg.id_sin
	And  g.id_prod = s.id_prod
	And  g.id_rev = s.id_rev
	and  g.id_gti = wg.id_gti
	And   p.id_police = g.id_police
	And c.id_cie=p.id_cie
	And i.id_sin=s.id_sin
	And i.cod_inter='A'
	and pr.id_prod = s.id_prod
	
	-- Armement du corps du mail 
	Set @sMailObjet = 'SPB Sinistre numéro ' + Convert ( Varchar ( 10 ), @adcIdSin ) + ' ' + @sLibProd

	-- Armement du corps du mail
	Set @sXMLVar = '<?xml version="1.0" encoding="UTF-8"?>'
	Set @sXMLVar = @sXMLVar + '<liste_demande>'
	Set @sXMLVar = @sXMLVar + '<demande>'
	Set @sXMLVar = @sXMLVar + '<tech '
	Set @sXMLVar = @sXMLVar + 'canal="C" '	
	Set @sXMLVar = @sXMLVar + 'code_maquette="MAIL_DEM_PIECE_SBE" '	
	Set @sXMLVar = @sXMLVar + 'civ="' + @sCivLongue + '" '
	Set @sXMLVar = @sXMLVar + 'nom="' + @sNomAss + '" '
	Set @sXMLVar = @sXMLVar + 'prenom="' + @sPrenomAss + '" '
	Set @sXMLVar = @sXMLVar + 'adresse1="' + @sAdr1 + '" '
	Set @sXMLVar = @sXMLVar + 'code_postal="' + @sAdrCP + '" '
	Set @sXMLVar = @sXMLVar + 'ville="' + @sAdrVille + '" '
	Set @sXMLVar = @sXMLVar + 'code_produit_sinistre="' + @sIdProdSin + '" '
	Set @sXMLVar = @sXMLVar + 'nom_produit="' + @sLibProd + '" '
	Set @sXMLVar = @sXMLVar + 'nom_produit_cpl="' + @sLibProd + '" '
	Set @sXMLVar = @sXMLVar + 'lib_opt_produit="' + @sLibProd + '" '
	Set @sXMLVar = @sXMLVar + 'no_tel_spb="' + @sNumTelProd + '" '
	Set @sXMLVar = @sXMLVar + 'no_fax_spb="' + @sNumFaxProd + '" '	
	Set @sXMLVar = @sXMLVar + 'assureur="' + @sLibCie + '" '
	Set @sXMLVar = @sXMLVar + 'no_police="' + @sLibPolice + '" '	
	Set @sXMLVar = @sXMLVar + 'no_ligne_assuree="' + @sNumLigneAssu + '" '
	Set @sXMLVar = @sXMLVar + 'code_produit="' + Convert ( VarChar ( 15 ), @dcIdProdAdh  ) + '" '	
	Set @sXMLVar = @sXMLVar + 'code_gestionnaire="' + @sCodeGest +'" '
	Set @sXMLVar = @sXMLVar + 'no_dossier_sinistre ="' + convert(varchar(10), @adcIdSin) + '" ' -- [PI062]
	Set @sXMLVar = @sXMLVar + '/>'
	
	Set @sXMLVar = @sXMLVar + '<courrier '
	Set @sXMLVar = @sXMLVar + 'email="' + @sMailSend + '" '
	Set @sXMLVar = @sXMLVar + 'app_marque="' + @sMarqPort + '" '
	Set @sXMLVar = @sXMLVar + 'app_modele="' + @sModlPort + '" '
	Set @sXMLVar = @sXMLVar + 'imei="' + @sImei + '" '
	Set @sXMLVar = @sXMLVar + 'maj_par="' + @sMajPar + '" '
	Set @sXMLVar = @sXMLVar + 'date_de_declaration="' + @sDteDecl + '" '

	Set @sXMLVar = @sXMLVar + '<tableaux><T1></T1><T2></T2><T3></T3><T4></T4><T5></T5><T6></T6></tableaux>'

	Set @sXMLVar = @sXMLVar + '</courrier>'
	Set @sXMLVar = @sXMLVar + '</demande>'
	Set @sXMLVar = @sXMLVar + '</liste_demande>'

	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	Set @sAltQuarant = 'N'


	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin
		   Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V02
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sMailFrom,
			@sMailSend,
			@sMailCc,
			null,
			@sMailObjet,
			'Corps du mail construit par KSL',
			@sAltQuarant,
			@sBoiteMail,
			'PCESBE',
			2,
			'KSL',
			'KSL_EDS',
			-1,
			@sXMLVar

	   End    -- TRACE_MAIL_PRO : Fin écriture

	Else
	 Begin
		 Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V02
			@asIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sMailFrom,
			@sMailSend,
			@sMailCc,
			null,			
			@sMailObjet,
			'Corps du mail construit par KSL',
			@sAltQuarant,
			@sBoiteMail,
			'PCESBE',
			2,
			'KSL',
			'KSL_EDS',			
			-1,
			@sXMLVar
	 End	

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_MAILPUSH_PM95_ALERTE_14
-- Auteur               :       JFF
-- Date                 :       15/06/2015
-- Libelle              :		[DT154]
-- Commentaires         :       Envoi push sur déclenchement 1ère alerte 14.
--
-- References           :
--
-- Arguments            :      
--				@adcIdSin       Decimal (  7,0 )        (Val)
--				@aiIdSeq	Integer		        (Val)
--				@asCasRetour Varchar(50)
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      23/06/2023   Ce mail n'est pas ramassé je l'arrête.
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MAILPUSH_PM95_ALERTE_14' AND type = 'P' )
        DROP procedure sysadm.PS_S_MAILPUSH_PM95_ALERTE_14
GO


CREATE procedure sysadm.PS_S_MAILPUSH_PM95_ALERTE_14
	@adcIdSin      	Decimal (10), -- [PI062]
	@aiIdSeq 	Integer,
 	@asCasRetour    VarChar (50) OUTPUT
AS

Return 0


Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sPrenom Varchar(35),
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @sNumTelProd  VarChar ( 20 ),
  @iIdEts 	Integer,
  @iOptionDP    Integer,
  @sBoiteMail   VarChar (35),
  @sMarqueRempl VarChar ( 35 ),
  @sModeleRempl VarChar ( 35 ),
  @sDteSurv		VarChar ( 15 ),
  @sSaut	Varchar(2) ,
  @sAltSuiviSMS VarChar ( 1 ),  
  @sNumGsmSMS   VarChar ( 20 ),
  @sBase	Varchar(100),
  @sXMLVar     	VarChar ( 2000 )
  
  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @iRet = 0
  Set @sSaut = Char (10)
  Set @sBase=DB_NAME() 
  
  -- Option de déclenchement du mail -DP
  Set @iOptionDP = -1

  -- [PM103][1]	
  If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
   Begin
	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
	Return 0
   End
  -- :[PM103][1]

  -- Récupération des données standard nécessaires à l'envoi du mail
	Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL_XML
		@adcIdSin,
		@iOptionDP,
		@dcIdProd   OUTPUT,
		@sLibProd   OUTPUT,
		@dcIdEts    OUTPUT,
		@sNumProd   OUTPUT,
		@sCiv	    OUTPUT,
		@sNom	    OUTPUT,
		@sMailFrom  OUTPUT,
		@sMailSend  OUTPUT,
		@sMailCc    OUTPUT,
		@sAltQuarant OUTPUT,
		@sBoiteMail  OUTPUT,
		@sXMLVar     OUTPUT

  
  -- Cas de retour n'étant pas des erreurs
  If @iRet < 0 and @iRet Not in (-11)
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

--------------------------------------------------------------------------------------------------------------------
-- Construction du mail.
--------------------------------------------------------------------------------------------------------------------
  If @sNom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sNom + ','
   End 

 	Set @sMailObjet = 'Votre dossier n°' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) + ' ' + @sLibProd -- [PI062]
	
	Set @sMailBody=@sCiv + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Nous vous informons que nous accusons un léger retard dans la réparation de votre appareil.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Nous vous présentons toutes nos excuses pour le désagrément occasionné.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Nous revenons rapidement vers vous pour vous informer de la suite donnée à votre dossier.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut	
	Set @sMailBody=@sMailBody + 'Votre gestionnaire d''assurance.'+ @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + '****************************************************************' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + '****************************************************************' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	
	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	Set @sAltQuarant = 'N'

	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin
	     Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
				'SIMPA2',
				@iIdSin, 
				@iIdProd, 
				@sLibProd, 
				@iIdEts, 
				@sMailFrom, 
				@sMailSend, 
				@sMailCc,
				@sMailObjet,
				@sMailBody,
				'N',
				@sBoiteMail, 
				'M95A14',
				2 

	   End    -- TRACE_MAIL_PRO : Fin écriture

	Else
	 Begin
		  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'M95A14', 
			2 
	 End	
  
  
  Return 0

Go

grant execute on sysadm.PS_S_MAILPUSH_PM95_ALERTE_14 to rolebddsinistres
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_MAILPUSH_CODE_ERR_LIVR_CHRONOPOST
-- Auteur               :       JFF
-- Date                 :       15/06/2015
-- Libelle              :		[DT154]
-- Commentaires         :       Envoi push sur déclenchement erreur chronopost
--
-- References           :
--
-- Arguments            :      
--				@adcIdSin       Decimal (  7,0 )        (Val)
--				@aiIdSeq	Integer		        (Val)
--				@asCasRetour Varchar(50)
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
--	   JFF      20/03/2017   [DDE_HELENE_20170320] modif url chronopost
--  JFF      17/04/2018   [DT288-4] Modif URL Chronopost
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MAILPUSH_CODE_ERR_LIVR_CHRONOPOST' AND type = 'P' )
        DROP procedure sysadm.PS_S_MAILPUSH_CODE_ERR_LIVR_CHRONOPOST
GO


CREATE procedure sysadm.PS_S_MAILPUSH_CODE_ERR_LIVR_CHRONOPOST
	@adcIdSin      	Decimal (10), -- [PI062]
	@aiIdSeq 	Integer,
	@asNumBonTrsp varchar ( 35),
	@sNomTrsp varchar ( 35),
 	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sPrenom Varchar(35),
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @sNumTelProd  VarChar ( 20 ),
  @iIdEts 	Integer,
  @iOptionDP    Integer,
  @sBoiteMail   VarChar (35),
  @sMarqueRempl VarChar ( 35 ),
  @sModeleRempl VarChar ( 35 ),
  @sDteSurv		VarChar ( 15 ),
  @sSaut	Varchar(2) ,
  @sAltSuiviSMS VarChar ( 1 ),  
  @sNumGsmSMS   VarChar ( 20 ),
  @sBase	Varchar(100),
  @sXMLVar     	VarChar ( 2000 ),
  @sCodePickUp VarChar ( 35 ),
  @asHREFURL	VarChar (300)	  
  
  Set @asCasRetour = ''
  Set @asHREFURL = ''
  Set @sMailBody = ''
  Set @iRet = 0
  Set @sSaut = Char (10)
  Set @sBase=DB_NAME() 
  
  -- Option de déclenchement du mail -DP
  Set @iOptionDP = -1

  -- [PM103][1]	
  If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
   Begin
	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
	Return 0
   End
  -- :[PM103][1]

  -- Récupération des données standard nécessaires à l'envoi du mail
	Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL_XML
		@adcIdSin,
		@iOptionDP,
		@dcIdProd   OUTPUT,
		@sLibProd   OUTPUT,
		@dcIdEts    OUTPUT,
		@sNumProd   OUTPUT,
		@sCiv	    OUTPUT,
		@sNom	    OUTPUT,
		@sMailFrom  OUTPUT,
		@sMailSend  OUTPUT,
		@sMailCc    OUTPUT,
		@sAltQuarant OUTPUT,
		@sBoiteMail  OUTPUT,
		@sXMLVar     OUTPUT

  
  -- Cas de retour n'étant pas des erreurs
  If @iRet < 0 and @iRet Not in (-11)
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

 Select @sCodePickUp = sysadm.FN_CLE_VAL ( 'CODE_PICK_UP', RTRIM( c.info_spb_frn_cplt ), ';' )
 From   sysadm.commande c
  Where  c.id_sin = @adcIdSin
  And    c.id_seq = @aiIdSeq


--------------------------------------------------------------------------------------------------------------------
-- Construction du mail.
--------------------------------------------------------------------------------------------------------------------
  If @sNom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sNom + ','
   End 

 	Set @sMailObjet = 'Votre dossier n°' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) + ' ' + @sLibProd -- [PI062]
	
	Set @sMailBody=@sCiv + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Nous vous informons que nous accusons un léger retard dans l''acheminement de votre appareil.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Nous vous présentons toutes nos excuses pour le désagrément occasionné.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut

	  Select @asHREFURL = @asHREFURL + 
		Case

			-- #3 [DCMP080399] UPS => Lien non directement clickable, l'utilisateur saisira son N° de colis.
			-- [PM255]
			/* [DDE_HELENE_20170320] modif url chronopost
			When Len ( @sCodePickUp ) > 0 
			 Then 'http://www.chronopost.fr/transport-express/livraison-colis/searchChronoRelais?pid=' + RTRIM ( @sCodePickUp )
			 */

			When @sNomTrsp = 'UPS'
			 Then 'http://www.ups.com/content/fr/fr/index.jsx + ( N° Colis : ' + @asNumBonTrsp + ' )'

			-- ChronoPost AA931798942FR
			-- [DT288-4]
			When IsNumeric ( Left (@asNumBonTrsp, 2) ) = 0 And IsNumeric ( Right (@asNumBonTrsp, 2) ) = 0 And Len ( @asNumBonTrsp ) = 13
			 Then 'https://www.chronopost.fr/fr/chrono_suivi_search?listeNumerosLT=' + @asNumBonTrsp

			-- Coliposte 8L41585398663
			When IsNumeric ( Left (@asNumBonTrsp, 2) ) = 0 And IsNumeric ( Right (@asNumBonTrsp, 2) ) = 1 And Len ( @asNumBonTrsp ) = 13
			 Then 'http://www.coliposte.net/gp/services/main.jsp?m=10003005&amp;colispart=' + @asNumBonTrsp

			-- Ciblex 24955001116149
			When isNumeric ( @asNumBonTrsp ) = 1 And Len ( @asNumBonTrsp ) = 14
			 Then 'http://www.ciblex.fr/extranet/client/corps.php?module=colis&amp;colis=' + @asNumBonTrsp

			Else null
		End 

	  If ( @asHREFURL is not null ) And sysadm.FN_TRIM ( @asHREFURL ) <> '' 
	   Begin 
		Set @sMailBody  = @sMailBody  + 'Pour suivre l''envoi de votre appareil, cliquez sur le lien ci-dessous : ' 
		Set @sMailBody  = @sMailBody  + @sSaut
		Set @sMailBody  = @sMailBody  + @sSaut    
		Set @sMailBody  = @sMailBody  + @asHREFURL 
		Set @sMailBody  = @sMailBody  + @sSaut
		Set @sMailBody  = @sMailBody  + @sSaut        
	   End 
	
	
	Set @sMailBody=@sMailBody + 'Nous revenons rapidement vers vous pour vous informer de la suite donnée à votre dossier.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut	
	Set @sMailBody=@sMailBody + 'Votre gestionnaire d''assurance.'+ @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + '****************************************************************' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + '****************************************************************' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	
	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	Set @sAltQuarant = 'N'

	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin
	     Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
				'SIMPA2',
				@iIdSin, 
				@iIdProd, 
				@sLibProd, 
				@iIdEts, 
				@sMailFrom, 
				@sMailSend, 
				@sMailCc,
				@sMailObjet,
				@sMailBody,
				'N',
				@sBoiteMail, 
				'ANOCHR',
				2 

	   End    -- TRACE_MAIL_PRO : Fin écriture

	Else
	 Begin
		  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'ANOCHR', 
			2 
	 End	
  
  
  Return 0
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_MAILPUSH_REFUSE_A_REEXP_RET_PICK_UP
-- Auteur               :       JFF
-- Date                 :       04/03/2016
-- Libelle              :		[DT191-1]
-- Commentaires         :       Je ne peux pas utiliser dans mon cas PS_S04_MAILPUSH_INFO_REPAR_PASSE
--								Obligé de faire une PS à part car à ce moment les table tempo ne sont plus renseigné.
--								Je garde l'option 51 comme déclencheur et le type mail 
--
-- References           :
--
-- Arguments            :      
--				@adcIdSin       Decimal (  7,0 )        (Val)
--				@aiIdSeq	Integer		        (Val)
--				@asCasRetour Varchar(50)
-- Retourne             :       Integer : 0 	Ok
--					  >0 	Erreur SQL SERVER
--					  <0 	Erreur SPB gérée 
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MAILPUSH_REFUSE_A_REEXP_RET_PICK_UP' AND type = 'P' )
        DROP procedure sysadm.PS_S_MAILPUSH_REFUSE_A_REEXP_RET_PICK_UP
GO

CREATE procedure sysadm.PS_S_MAILPUSH_REFUSE_A_REEXP_RET_PICK_UP
	@adcIdSin      	Decimal (10),
	@aiIdSeq 	Integer,
 	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sPrenom Varchar(35),
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @sNumTelProd  VarChar ( 20 ),
  @iIdEts 	Integer,
  @iOptionDP    Integer,
  @sBoiteMail   VarChar (35),
  @sMarqueRempl VarChar ( 35 ),
  @sModeleRempl VarChar ( 35 ),
  @sSaut	Varchar(2) ,
  @sAltSuiviSMS VarChar ( 1 ),  
  @sNumGsmSMS   VarChar ( 20 ),
  @sBase	Varchar(100)
 
  
  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @iRet = 0
  Set @sSaut = Char (10)
  set @sBase=DB_NAME()
   
  -- Option de déclenchement du mail -DP
  Set @iOptionDP = 51

  -- [PM103][1]	
  If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
   Begin
	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
	Return 0
   End
  -- :[PM103][1]

  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@sBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT,  
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #3
	@sAltSuiviSMS OUTPUT, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  
  -- Cas de retour n'étant pas des erreurs
  If @iRet < 0 and @iRet <> -7
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End
  
--------------------------------------------------------------------------------------------------------------------
-- Construction du mail.
--------------------------------------------------------------------------------------------------------------------
  If @sNom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sNom 
   End 

 	Set @sMailObjet = 'Votre dossier n°' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 7 ) + Convert ( VarChar, @adcIdSin ), 7 ) ) + ' ' + @sLibProd
	
	Set @sMailBody= @sCiv + ',' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	
	Set @sMailBody=@sMailBody + 'Votre appareil sinistré va être envoyé vers le relais PickUp suivant : '

	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  +
				IsNull ( 
						(
						Select Isnull ( rtrim ( adr_nom ), '' ) + @sSaut + Isnull ( rtrim ( adr_prenom), '' ) + @sSaut +
								Isnull ( rtrim ( adr_livr1), '' ) + @sSaut +
								Isnull ( rtrim ( adr_livr2), '' ) + @sSaut +
								Isnull ( rtrim ( adr_livr_cpl), '' ) + @sSaut +
								Isnull ( rtrim ( adr_cp ), '' ) + ' ' + Isnull ( rtrim ( adr_ville), '' ) + @sSaut 
						From   sysadm.commande c
						Where   c.id_sin = @adcIdSin
						And     c.id_seq = @aiIdSeq 
					), '')

	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut	

	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ', nos salutations distinguées.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + '****************************************************************' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + '****************************************************************' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	
	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	Set @sAltQuarant = 'N'

	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin
	     Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
				'SIMPA2',
				@iIdSin, 
				@iIdProd, 
				@sLibProd, 
				@iIdEts, 
				@sMailFrom, 
				@sMailSend, 
				@sMailCc,
				@sMailObjet,
				@sMailBody,
				'N',
				@sBoiteMail, 
				'M4',
				2 

	   End    -- TRACE_MAIL_PRO : Fin écriture

	Else
	 Begin
		  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'M4', 
			2 
	 End	
  
  
  Return 0

Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_MAILPUSH_APP_IRREPARABLE
-- Auteur               :       Fabry JF
-- Date                 :       21/06/2014
-- Libelle              :
-- Commentaires         :       
-- References           :		[PM284-2]
--
-- Arguments            :       
-- Retourne             :       
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-- JFF      01/12/2020   [VDOC29875]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MAILPUSH_APP_IRREPARABLE' AND type = 'P' )
        DROP procedure sysadm.PS_S_MAILPUSH_APP_IRREPARABLE
GO

CREATE procedure sysadm.PS_S_MAILPUSH_APP_IRREPARABLE
	@adcIdSin  	Decimal (10), -- [PI062]
	@aiIdSeq 	Integer,
 	@asCasRetour    VarChar (50) OUTPUT
AS
Declare 
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sNumProd     VarChar (20),   
  @sLibProd     VarChar (255), 
  @sCiv		VarChar (100), 
  @sNom		VarChar (50), 
  @sPrenom Varchar(35),
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 ),
  @sAltQuarant  VarChar (1),	
  @iRet		Integer,
  @iIdSin 	Integer,
  @iIdProd 	Integer,
  @sNumTelProd  VarChar ( 20 ),
  @iIdEts 	Integer,
  @iOptionDP    Integer,
  @sBoiteMail   VarChar (35),
  @sMarqueRempl VarChar ( 35 ),
  @sModeleRempl VarChar ( 35 ),
  @sSaut	Varchar(2) ,
  @sAltSuiviSMS VarChar ( 1 ),  
  @sNumGsmSMS   VarChar ( 20 ),
  @sBase	Varchar(100),
  @iProduitEligible Integer 
  
  Set @asCasRetour = ''
  Set @sMailBody = ''
  Set @iRet = 0
  Set @sSaut = Char (10)
  set @sBase=DB_NAME()
   
  -- Option de déclenchement du mail -DP
  Set @iOptionDP = 300

  -- [PM103][1]	
  If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
   Begin
	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
	Return 0
   End
  -- :[PM103][1]

  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@sBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT,  
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #3
	@sAltSuiviSMS OUTPUT, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #5 [FNAC_PROD_ECH_TECH].[SMS]
  
  -- Cas de retour n'étant pas des erreurs
  If @iRet < 0 and @iRet <> -7
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

	-- Le cas déclencheur est traité en amont par le client dans PS_U01_COMMANDE.
	-- Ici, on envoit le mail, c'est tout.
	-- On juste que le produit soit éligible à ce mail.

   Select @iProduitEligible = Count ( * )
   From   sysadm.sinistre s,
		  sysadm.det_pro dp
   Where  s.id_sin = @adcIdSin
   And	  dp.id_prod = s.id_prod
   And	  dp.id_code_dp = 300

   If @iProduitEligible <= 0 Return 0

--------------------------------------------------------------------------------------------------------------------
-- Construction du mail.
--------------------------------------------------------------------------------------------------------------------
  If @sNom <> ''
   Begin
    Set @sCiv = @sCiv + ' ' + @sNom 
   End 

 	Set @sMailObjet = 'Dossier n°' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) + ' - Retour du centre technique.' -- [PI062]
	
	Set @sMailBody='Bonjour,' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	
	Set @sMailBody=@sMailBody + 'Votre appareil étant diagnostiqué irréparable par notre centre technique, votre dossier est actuellement en cours de traitement.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	
	-- [VDOC29875] ELodie Duboc
	-- Set @sMailBody=@sMailBody + 'Notre service de gestion vous contactera par mail dans un délai maximum de 3 jours ouvrés.' + @sSaut
	Set @sMailBody=@sMailBody + 'Notre service de gestion vous contactera par e-mail dans les plus brefs délais.' + @sSaut
	-- /[VDOC29875]

	Set @sMailBody=@sMailBody + @sSaut

	Set @sMailBody=@sMailBody + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, nos salutations distinguées.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + '****************************************************************' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + '****************************************************************' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	Set @sMailBody=@sMailBody + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.' + @sSaut
	Set @sMailBody=@sMailBody + @sSaut
	
	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	Set @sAltQuarant = 'N'

	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin
	     Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
				'SIMPA2',
				@iIdSin, 
				@iIdProd, 
				@sLibProd, 
				@iIdEts, 
				@sMailFrom, 
				@sMailSend, 
				@sMailCc,
				@sMailObjet,
				@sMailBody,
				'N',
				@sBoiteMail, 
				'M31',
				2 

	   End    -- TRACE_MAIL_PRO : Fin écriture

	Else
	 Begin
		  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'M31', 
			2 
	 End	
  
  
  Return 0
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_MAILPUSH_RELANCE_PCE_DT262
-- Auteur               :       Fabry JF
-- Date                 :       29/09/2016
-- Libelle              :
-- Commentaires         :       
-- References           :		[DT262] [RELANCE]
--							Agent SQL : SIMPA2_PRO : DT262 Relances Dde Pces Orange V3
-- Arguments            :       
-- Retourne             :       
-------------------------------------------------------------------
-- JFF      06/03/2018   [DT341]
-- JFF      13/08/2018   [DT364]
-- JFF      26/02/2019   [VDOC27607]
-- JFF      21/08/2019   [DT361-1]
-- JFF      10/08/2020   [PM519-1]
-- JFF      18/01/2020   [VDOC30069] BPCE IOM
-- JFF      11/06/2021   [RS-536] ajout regard si présence w_queue
-- JFF      03/08/2021   On ne relance pas non plus un dossier réglé, refusée etc...
-- JFF      12/08/2021   [RS398][RS905] Relance MyPanguee
-- JFF      22/08/2022   [RS3179_SHUNT_RECLA]
-- JFF      03/07/2023   [RS5124_ATM_ATP]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MAILPUSH_RELANCE_PCE_DT262' AND type = 'P' )
        DROP procedure sysadm.PS_S_MAILPUSH_RELANCE_PCE_DT262
GO

CREATE procedure sysadm.PS_S_MAILPUSH_RELANCE_PCE_DT262
AS
DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_sin	decimal (10 ), -- [PI062]
	  type_rel  VarChar ( 10 ),
	  dte_decl  VarChar ( 10 ),
	  nom_contrat VarChar ( 150 ),
	  marque varchar ( 35 ),
	  modele varchar ( 35 ),
	  variante  varchar ( 35 ), -- [DT364)
	  adr_mail_prod varchar ( 50 ), -- [RS398][RS905]
	  adr_adrpostale_prod varchar ( 100 ), -- [RS5124_ATM_ATP]
	  url_extranet_spb varchar ( 100 ), -- [RS5124_ATM_ATP]
	  marquage	integer null 
	)

DECLARE @det_pro TABLE 
	( id_seq	integer identity,
	  id_prod	decimal (7 ), -- [PI062]
	  dte_pivot datetime,
	  dte_del_1ere_rel_j   datetime,
	  z2eme_rel  Varchar ( 5 ),
	  dte_del_2eme_rel_j datetime,
	  dte_pivot_dt364 datetime,
	  z3eme_rel Varchar ( 5 ),
	  dte_del_3eme_rel_j datetime,
	  z4eme_rel Varchar ( 5 ),
	  dte_del_4eme_rel_j datetime,
	  cloture_dos Varchar ( 5 ),
	  dte_del_cloture_dos_j datetime,
	  variante_mail varchar ( 35),
	  lib_prod_dp66_Et_dp67 Varchar ( 71 ),
	  adr_mail_prod_dp136 varchar ( 70 ),
	  adr_adrpostale_prod varchar ( 100 ), -- [RS5124_ATM_ATP]
	  url_extranet_spb varchar ( 100 ) -- [RS5124_ATM_ATP]
	)

DECLARE @tbPce TABLE 
	( id_seq	integer identity,
	  txt_para  VarChar ( 8000 ),
	  marquage	integer null 
	)


Declare @sDteDecl Varchar ( 10 )
Declare @sTypRel Varchar ( 10 )
Declare @dcIdSin decimal (10 ) -- [PI062]
Declare @iIdSeq  Integer
Declare @iIdSeqCmde integer
Declare @sBase VarChar ( 100 )
Declare @iIdSin 	Integer
Declare @iIdProd 	Integer
Declare @iIdEts 	Integer
Declare @dcIdProd     Decimal (7) 
Declare @dcIdEts 	Decimal (7) 
Declare @sNumProd     VarChar (20)  
Declare @sLibProd     VarChar (255) 
Declare @sCiv		VarChar (100)
Declare @sNom		VarChar (50) 
Declare @sMailFrom	VarChar (128) 
Declare @sMailSend	VarChar (128) 
Declare @sMailCc	VarChar (128)
Declare @sMailObjet	VarChar ( 255 )
Declare @sMailBody	VarChar ( 7000 )
Declare @sAltQuarant  VarChar (1)	
Declare @sSaut	VarChar (10) 
Declare @sBoiteMail    VarChar (35)
Declare @sAltSuiviSMS VarChar ( 1 )
Declare @sNumGsmSMS   VarChar ( 20 )
Declare @iOrangeV3 Integer
Declare @iRet Integer
Declare @sMarque VarChar (35)
Declare @sModele VarChar (35)
Declare @sMess	VarChar ( 2000 )
Declare @iIdCt	integer	
Declare @iIdSeqPce integer	
Declare @sTxtPara VarChar ( 8000 )
Declare @sCodeMail VarChar ( 10 )
Declare @sNomZoneDivPro VarChar ( 35 )
Declare @sLibZoneDivPro VarChar ( 35 )
Declare @iIdNatTache integer
Declare @sVal VarChar ( 20 )
Declare @iIdTypContact Integer
Declare @sVariante varchar ( 35 ) -- [DT364]
Declare @sAltQueue VarChar ( 1 )
Declare @dtDateJour DateTime
Declare @iCptTri Integer
Declare @sNumCertificat VarChar ( 50 )
Declare @sDteSurv VarChar ( 10 )
Declare @sZVAS20 VarChar ( 255 )
Declare @sNumTelProd VarChar ( 20 )
Declare @sAdrMailProd VarChar ( 50 )
Declare @sAdrAdPostaleProd VarChar ( 100 )
Declare @sUrlEctranetSpb VarChar ( 100 )
Declare @sAltRecla VarChar ( 1 )

Set @dtDateJour = GetDate()

Set @sBase = Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) )
Set @sMailBody = ''
Set @sSaut = Char (10)
Set @iRet = 0

Insert into @det_pro
Select dp.id_prod,
	   Convert ( DateTime,  sysadm.FN_CLE_VAL ( 'DTE_PIVOT', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';')),
       DATEADD ( day, (-1)* Convert ( integer, sysadm.FN_CLE_VAL ( 'DEL_1ERE_REL_J', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';')) , Getdate() ),
	   sysadm.FN_CLE_VAL ( '2EME_REL', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';'),
	   DATEADD ( day, (-1)* Convert ( integer, sysadm.FN_CLE_VAL ( 'DEL_2EME_REL_J', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';')) , Getdate() ),
	   Convert ( DateTime, sysadm.FN_CLE_VAL ( 'DTE_PIVOT_DT364', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';')),
	   sysadm.FN_CLE_VAL ( '3EME_REL', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';'),
	   DATEADD ( day, (-1)* Convert ( integer, sysadm.FN_CLE_VAL ( 'DEL_3EME_REL_J', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';')) , Getdate() ),
	   sysadm.FN_CLE_VAL ( '4EME_REL', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';'),
	   DATEADD ( day, (-1)* Convert ( integer, sysadm.FN_CLE_VAL ( 'DEL_4EME_REL_J', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';')) , Getdate() ),
	   sysadm.FN_CLE_VAL ( 'CLOTURE_DOS', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';'),
	   DATEADD ( day, (-1)* Convert ( integer, sysadm.FN_CLE_VAL ( 'DEL_CLOTURE_DOS_J', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';')) , Getdate() ),
	   sysadm.FN_CLE_VAL ( 'VARIANTE_MAIL', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';'),
		IsNull (
		(select rtrim(dp66.val_car) 
			from sysadm.det_pro dp66  with (nolock)
			where dp66.id_prod=dp.id_prod 
			and dp66.id_code_dp=66) , '' ) + ' ' + 
		IsNull (	
		(select rtrim(dp67.val_car) 
			from sysadm.det_pro dp67  with (nolock)
			where dp67.id_prod=dp.id_prod 
			and dp67.id_code_dp=67) , '' ),
		IsNull (	
		(select sysadm.FN_CLE_VAL ( 'ADR_MAIL_PROD', rtrim ( dp136.val_car ) + rtrim ( dp136.val_car2 ), ';')
		 from sysadm.det_pro dp136 with (nolock)
		 where dp136.id_prod=dp.id_prod 
		 and dp136.id_code_dp=136) , '' ),
		IsNull (	
		(select sysadm.FN_CLE_VAL ( 'ADR_ADPOSTALE_PROD', rtrim ( dp366.val_car ) + rtrim ( dp366.val_car2 ), ';')
		 from sysadm.det_pro dp366 with (nolock)
		 where dp366.id_prod=dp.id_prod 
		 and dp366.id_code_dp=366) , '' ), -- [RS5124_ATM_ATP]
		IsNull (	
		(select sysadm.FN_CLE_VAL ( 'URL_ATLAS', rtrim ( dp119.val_car ) + rtrim ( dp119.val_car2 ), ';')
		 from sysadm.det_pro dp119 with (nolock)
		 where dp119.id_prod=dp.id_prod 
		 and dp119.id_code_dp=119) , '' ) -- [RS5124_ATM_ATP]
From sysadm.det_pro dp with (nolock)
Where dp.id_code_dp = 309


Insert into @tb
select  Distinct 
		s.id_sin, 
		'REL1', 
		sysadm.FN_AFF_DATE ( s.dte_decl, 'SH' ), 
		dp.lib_prod_dp66_Et_dp67, 
		IsNull ( ltrim ( rtrim ( s.marq_port )), ''),
		IsNull ( ltrim ( rtrim ( s.modl_port )), ''),
		dp.variante_mail, -- [DT364]
		dp.adr_mail_prod_dp136,
		dp.adr_adrpostale_prod, -- [RS5124_ATM_ATP]
		dp.url_extranet_spb, -- [RS5124_ATM_ATP]
		0 'marquage'
From	sysadm.sinistre s with (nolock),
		@det_pro dp,
		sysadm.div_sin ds with (nolock),
		sysadm.archive a  with (nolock),
		sysadm.w_piece wp  with (nolock),
		sysadm.inter i  with (nolock)
Where	a.id_prod = dp.id_prod 
And		Substring ( a.id_cour_orig, 4, 1 ) = 'P'
And		a.id_arch = ( 
			select Max ( a1.id_arch ) 
			From sysadm.archive a1  with (nolock)
			Where a1.id_sin = a.id_sin
			And	  Substring ( a1.id_cour_orig, 4, 1 ) = 'P'
		)
And		a.dte_edit < dp.dte_del_1ere_rel_j 
And		a.dte_edit > dte_pivot
And		Not Exists ( Select Top 1 1 From sysadm.div_sin ds3  with (nolock) Where ds3.id_sin = s.id_sin and ds3.nom_zone = 'dte_rel1_mail_ddepce_dt262' )
And		wp.id_sin = a.id_sin -- cette jointure suffit à la présence d'une pièce toujours cochée
And		wp.id_i = 0 -- assuré
And     i.id_sin = wp.id_sin
And     i.id_i = wp.id_i
And     i.adr_mail is not null
And     s.id_sin = a.id_sin
And		ds.id_sin = s.id_sin
And     ds.nom_zone = 'etat_vu_assure'
And     ds.val_nbre not in ( 1500, 1510, 1520, 1530 )
And     Not Exists ( Select Top 1 1 From sysadm.w_queue wq where wq.id_sin = s.id_sin ) -- [RS-536]

Insert into @tb
select Distinct
		s.id_sin, 
		'REL2', 
		sysadm.FN_AFF_DATE ( s.dte_decl, 'SH' ), 
		dp.lib_prod_dp66_Et_dp67, 
		IsNull ( ltrim ( rtrim ( s.marq_port )), ''),
		IsNull ( ltrim ( rtrim ( s.modl_port )), ''),
		dp.variante_mail, -- [DT364]
		dp.adr_mail_prod_dp136, 
		dp.adr_adrpostale_prod, -- [RS5124_ATM_ATP]
		dp.url_extranet_spb, -- [RS5124_ATM_ATP]
		0 'marquage'
From	sysadm.sinistre s with (nolock),
		@det_pro dp,
		sysadm.div_sin ds with (nolock),
		sysadm.div_sin ds2 with (nolock),
		sysadm.w_piece wp with (nolock),
		sysadm.inter i with (nolock)
Where	dp.z2eme_rel = 'OUI' -- [DT341]
And		s.id_prod = dp.id_prod 
And     i.id_sin = s.id_sin
And     i.id_i = 0
And     i.adr_mail is not null
And		ds2.id_sin = s.id_sin
And     ds2.nom_zone = 'etat_vu_assure'
And     ds2.val_nbre not in ( 1500, 1510, 1520, 1530 )
And		ds.id_sin = s.id_sin
And		ds.nom_zone = 'dte_rel1_mail_ddepce_dt262'
And		ds.val_dte < dp.dte_del_2eme_rel_j
And		Not Exists ( Select Top 1 1  From sysadm.div_sin ds3 with (nolock) Where ds3.id_sin = s.id_sin and ds3.nom_zone = 'dte_rel2_mail_ddepce_dt262' )
And		wp.id_sin = s.id_sin -- cette jointure suffit à la présence d'une pièce toujours cochée
And		wp.id_i = 0 -- assuré
And     Not Exists ( Select Top 1 1 From sysadm.w_queue wq where wq.id_sin = s.id_sin ) -- [RS-536]

-- [DT364]
Insert into @tb
select Distinct
		s.id_sin, 
		'REL3', 
		sysadm.FN_AFF_DATE ( s.dte_decl, 'SH' ), 
		dp.lib_prod_dp66_Et_dp67, 
		IsNull ( ltrim ( rtrim ( s.marq_port )), ''),
		IsNull ( ltrim ( rtrim ( s.modl_port )), ''),
		dp.variante_mail, -- [DT364]
		dp.adr_mail_prod_dp136, 
		dp.adr_adrpostale_prod, -- [RS5124_ATM_ATP]
		dp.url_extranet_spb, -- [RS5124_ATM_ATP]
		0 'marquage'
From	sysadm.sinistre s with (nolock),
		@det_pro dp,
		sysadm.div_sin ds with (nolock),
		sysadm.div_sin ds2 with (nolock),
		sysadm.w_piece wp with (nolock),
		sysadm.inter i  with (nolock)
Where	dp.z3eme_rel = 'OUI' -- [DT341]
And		s.id_prod = dp.id_prod 
And     i.id_sin = s.id_sin
And     i.id_i = 0
And     i.adr_mail is not null
And		ds2.id_sin = s.id_sin
And     ds2.nom_zone = 'etat_vu_assure'
And     ds2.val_nbre not in ( 1500, 1510, 1520, 1530 )
And		ds.id_sin = s.id_sin
And		ds.nom_zone = 'dte_rel2_mail_ddepce_dt262'
And		ds.val_dte < dp.dte_del_3eme_rel_j
And		s.cree_le > dp.dte_pivot_dt364
And		Not Exists ( Select Top 1 1 From sysadm.div_sin ds3  with (nolock) Where ds3.id_sin = s.id_sin and ds3.nom_zone = 'dte_rel3_mail_ddepce_dt262' )
And		wp.id_sin = s.id_sin -- cette jointure suffit à la présence d'une pièce toujours cochée
And		wp.id_i = 0 -- assuré
And     Not Exists ( Select Top 1 1 From sysadm.w_queue wq where wq.id_sin = s.id_sin ) -- [RS-536]

Insert into @tb
select Distinct
		s.id_sin, 
		'REL4', 
		sysadm.FN_AFF_DATE ( s.dte_decl, 'SH' ), 
		dp.lib_prod_dp66_Et_dp67, 
		IsNull ( ltrim ( rtrim ( s.marq_port )), ''),
		IsNull ( ltrim ( rtrim ( s.modl_port )), ''),
		dp.variante_mail, -- [DT364]
		dp.adr_mail_prod_dp136,  
		dp.adr_adrpostale_prod, -- [RS5124_ATM_ATP]
		dp.url_extranet_spb, -- [RS5124_ATM_ATP]
		0 'marquage'
From	sysadm.sinistre s with (nolock),
		@det_pro dp,
		sysadm.div_sin ds with (nolock),
		sysadm.div_sin ds2 with (nolock),
		sysadm.w_piece wp with (nolock),
		sysadm.inter i  with (nolock)
Where	dp.z4eme_rel = 'OUI' -- [DT341]
And		s.id_prod = dp.id_prod 
And     i.id_sin = s.id_sin
And     i.id_i = 0
And     i.adr_mail is not null
And		ds2.id_sin = s.id_sin
And     ds2.nom_zone = 'etat_vu_assure'
And     ds2.val_nbre not in ( 1500, 1510, 1520, 1530 )
And		ds.id_sin = s.id_sin
And		ds.nom_zone = 'dte_rel3_mail_ddepce_dt262'
And		ds.val_dte < dp.dte_del_4eme_rel_j
And		s.cree_le > dp.dte_pivot_dt364
And		Not Exists ( Select Top 1 1 From sysadm.div_sin ds3  with (nolock) Where ds3.id_sin = s.id_sin and ds3.nom_zone = 'dte_rel4_mail_ddepce_dt262' )
And		wp.id_sin = s.id_sin -- cette jointure suffit à la présence d'une pièce toujours cochée
And		wp.id_i = 0 -- assuré
And     Not Exists ( Select Top 1 1 From sysadm.w_queue wq where wq.id_sin = s.id_sin ) -- [RS-536]

Insert into @tb
select Distinct
		s.id_sin, 
		'REL5', 
		sysadm.FN_AFF_DATE ( s.dte_decl, 'SH' ), 
		dp.lib_prod_dp66_Et_dp67, 
		IsNull ( ltrim ( rtrim ( s.marq_port )), ''),
		IsNull ( ltrim ( rtrim ( s.modl_port )), ''),
		dp.variante_mail, -- [DT364]
		dp.adr_mail_prod_dp136, 
		dp.adr_adrpostale_prod, -- [RS5124_ATM_ATP]
		dp.url_extranet_spb, -- [RS5124_ATM_ATP]
		0 'marquage'
From	sysadm.sinistre s with (nolock),
		@det_pro dp,
		sysadm.div_sin ds with (nolock),
		sysadm.div_sin ds2 with (nolock),
		sysadm.w_piece wp with (nolock),
		sysadm.inter i with (nolock)
Where	dp.cloture_dos = 'OUI' -- [DT341]
And		s.id_prod = dp.id_prod 
And     i.id_sin = s.id_sin
And     i.id_i = 0
And     i.adr_mail is not null
And		ds2.id_sin = s.id_sin
And     ds2.nom_zone = 'etat_vu_assure'
And     ds2.val_nbre not in ( 1500, 1510, 1520, 1530 )
And		ds.id_sin = s.id_sin
And		ds.nom_zone =  Case 
							When dp.z4eme_rel = 'OUI' Then 'dte_rel4_mail_ddepce_dt262'
							When dp.z3eme_rel = 'OUI' Then 'dte_rel3_mail_ddepce_dt262'
							When dp.z2eme_rel = 'OUI' Then 'dte_rel2_mail_ddepce_dt262'
							Else 'dte_rel1_mail_ddepce_dt262'
					   End 
And		ds.val_dte < dp.dte_del_cloture_dos_j
And		s.cree_le > dp.dte_pivot_dt364
And		Not Exists ( Select Top 1 1  From sysadm.div_sin ds3  with (nolock) Where ds3.id_sin = s.id_sin and ds3.nom_zone = 'dte_rel5_mail_ddepce_dt262' )
And		wp.id_sin = s.id_sin -- cette jointure suffit à la présence d'une pièce toujours cochée
And		wp.id_i = 0 -- assuré
And     Not Exists ( Select Top 1 1 From sysadm.w_queue wq where wq.id_sin = s.id_sin ) -- [RS-536]

While Exists ( Select * From @tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdSin = id_sin,
		@sTypRel =  type_rel,
		@sDteDecl = dte_decl,
		@sLibProd = nom_contrat,
		@sMarque = marque,
		@sModele = modele,
		@sVariante = variante, -- [DT364]
		@sAdrMailProd = adr_mail_prod, -- [RS398][RS905]
		@sAdrAdPostaleProd = adr_adrpostale_prod, -- [RS5124_ATM_ATP]
	    @sUrlEctranetSpb = url_extranet_spb -- [RS5124_ATM_ATP]
	From	@tb
	Where	marquage = 0

	-- [RS3179_SHUNT_RECLA]
	If sysadm.FN_CLE_NUMERIQUE ( 'RS3179_SHUNT_RECLA') > 0 
	 Begin
		Set @iIdSin = CONVERT ( Integer,  @dcIdSin )
		Set @sAltRecla = 'N'

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec SHERPA_PRO.sysadm.Recla_Verifier_Sinistre @iIdSin, 2, @sAltRecla OUTPUT		
		END
		ELSE
		BEGIN
			Exec SHERPA_SIM.sysadm.Recla_Verifier_Sinistre @iIdSin, 2, @sAltRecla OUTPUT		
		END	

		If @sAltRecla = 'O'
		  Begin
			Update @tb Set marquage = 1	Where id_seq = @iIdSeq
			Continue
		  End
	 End 

	If @sVariante is null Set @sVariante = ''

	-- [PM519-1]
	Select  @sNumTelProd =
			sysadm.FN_TRIM (
			Case Left ( p.num_tel, 2 )
				When '08' Then Left ( p.num_tel, 1 ) + ' ' + SubString ( p.num_tel, 2, 3 ) + ' ' + SubString ( p.num_tel, 5, 3 ) + ' ' + SubString ( p.num_tel, 8, 3 )
				Else Left ( p.num_tel, 2 ) + ' ' + SubString ( p.num_tel, 3, 2 ) + ' ' + SubString ( p.num_tel, 5, 2 ) + ' ' + SubString ( p.num_tel, 7, 2 ) + ' ' + SubString ( p.num_tel, 9, 2 )
			End
			)
	From   sysadm.w_sin ws with (nolock),
		   sysadm.produit p  with (nolock)
	Where  ws.id_sin = @dcIdSin
	And    p.id_prod = ws.id_prod
	-- /[PM519-1]

	Set @sMailBody = ''

	If @sTypRel = 'REL1' 
	 Begin
		Set @sCodeMail = 'OV3RL1'
		Set @sNomZoneDivPro = 'dte_rel1_mail_ddepce_dt262'
		Set @sLibZoneDivPro = 'Date 1ère relance mail DdePce'
		Set @iIdNatTache = 864
		Set @sMess = '1ère Relance vers le client suite pièce(s) non réceptionnée(s) chez SPB.'
		Set @iIdTypContact = 1591
		Set @iCptTri = 760
	 End 
	If @sTypRel = 'REL2' 
	 Begin
		Set @sCodeMail = 'OV3RL2'
		Set @sNomZoneDivPro = 'dte_rel2_mail_ddepce_dt262'
		Set @sLibZoneDivPro = 'Date 2ème relance mail DdePce'
		Set @iIdNatTache = 865
		Set @sMess = '2ème Relance vers le client suite pièce(s) non réceptionnée(s) chez SPB.'
		Set @iIdTypContact = 1592
		Set @iCptTri = 761
	 End 

-- [DT364]
 	If @sTypRel = 'REL3' 
	 Begin
		Set @sCodeMail = 'OV3RL3'
		Set @sNomZoneDivPro = 'dte_rel3_mail_ddepce_dt262'
		Set @sLibZoneDivPro = 'Date 3ème relance mail DdePce'
		Set @iIdNatTache = 916
		Set @sMess = '3ème Relance vers le client suite pièce(s) non réceptionnée(s) chez SPB.'
		Set @iIdTypContact = 1601
		Set @iCptTri = 762
	 End 

 	If @sTypRel = 'REL4' 
	 Begin
		Set @sCodeMail = 'OV3RL4'
		Set @sNomZoneDivPro = 'dte_rel4_mail_ddepce_dt262'
		Set @sLibZoneDivPro = 'Date 4ème relance mail DdePce'
		Set @iIdNatTache = 917
		Set @sMess = '4ème Relance vers le client suite pièce(s) non réceptionnée(s) chez SPB.'
		Set @iIdTypContact = 1602
		Set @iCptTri = 763
	 End 

 	If @sTypRel = 'REL5' 
	 Begin
		Set @sCodeMail = 'OV3RL5'
		Set @sNomZoneDivPro = 'dte_rel5_mail_ddepce_dt262'
		Set @sLibZoneDivPro = 'Date relance clôture mail DdePce'
		Set @iIdNatTache = 918
		Set @sMess = 'Dernière Relance vers le client suite pièce(s) non réceptionnée(s) chez SPB et clôture automatique du dossier.'
		Set @iIdTypContact = 1603
		Set @iCptTri = 764
	 End 

 
    -- Récupération des données standard nécessaires à l'envoi du mail
	Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@dcIdSin,
	@sBase,
 	49,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT,  
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #3
	@sAltSuiviSMS OUTPUT, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #5 [FNAC_PROD_ECH_TECH].[SMS]

	
	-- Le but pour Orange V3 et de toujours mettre une adresse mail si l'adresse réél n'est pas là, pour justement
	-- déclencher l'échec de distribution et donc envoyer le courrier en automatique.
	If @iRet = -7 
    Begin
		Set @sMailSend = 'DeclEchecDistrib@spb.fr'
	End
	
	-- Gestion de la civilité "Madame, Monsieur"
	If @sNom <> ''
	Begin
		Set @sCiv = @sCiv + ' ' + @sNom + ','
	End 

	Set @sMailObjet = 'Votre dossier n°' + Convert ( VarChar, @dcIdSin ) + ' - ' + @sLibProd 

	-- Gestion SAMSUNG ? => Trt part
	/* -- [PM519-1]
	If Exists (	Select * 
				from sysadm.det_pro dp,
						sysadm.w_sin s
				Where s.id_sin = @dcIdSin 
				And   dp.id_prod = s.id_prod
				And   dp.id_code_dp = 294
		)*/
	If @sVariante = 'SAMSUNG'
		Begin
		    Select @sNumCertificat = IsNull ( ltrim ( rtrim ( ws.id_contrat_abonne ) ), '' ) 
			From   sysadm.w_sin ws with (nolock) 
			Where ws.id_sin = @dcIdSin

			If @sNumCertificat is null Set @sNumCertificat = ''

			Set @sMailObjet = 'Votre dossier n°' + Convert ( VarChar, @dcIdSin ) + ' - ' + @sLibProd + ' - Certificat n°' + @sNumCertificat

		End 

	-- [PM519-1][RS5124]
	If @sVariante in ( 'MOBILEO', 'ATM', 'ATP') 
	  Begin
		If @sTypRel = 'REL1'
		  Begin
			Set @sMailObjet = 'Demande de prise en charge – document(s) manquant(s) ' + @sLibProd + ' Référence client : ' + Convert ( VarChar, @dcIdSin ) 
		  End 

		If @sTypRel in ( 'REL2', 'REL3', 'REL4' )
		  Begin
			Set @sMailObjet = 'Demande de prise en charge – document(s) manquant(s) ' + @sLibProd + ' Référence client : ' + Convert ( VarChar, @dcIdSin ) + ' - relance'
		  End 

		If @sTypRel = 'REL5'
		  Begin
			Set @sMailObjet = 'Demande de prise en charge – document(s) manquant(s) ' + @sLibProd + ' Référence client : ' + Convert ( VarChar, @dcIdSin ) + ' - dernière relance'
		  End 
	  End 



	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut


	-- [DT364]
	IF @sTypRel in ( 'REL1', 'REL2') 
	  Begin
		-- [PM519-1]
		If @sVariante in ( 'MOBILEO', 'ATM', 'ATP') And @sTypRel = 'REL1'
		  Begin
			Set @sMailBody  = @sMailBody  + 'Vous avez déclaré un sinistre le ' + @sDteDecl + ', au titre de votre contrat ' + @sLibProd + ' concernant votre appareil ' + @sMarque + ' ' + @sModele + '.' 
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'A ce jour, nous n''avons pas reçu le(s) document(s) demandé(s) nous permettant d’étudier votre dossier :'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
		  End 

		-- [PM519-1]
		If @sVariante in ( 'MOBILEO', 'ATM', 'ATP') And @sTypRel = 'REL2'
		  Begin
			Set @sMailBody  = @sMailBody  + 'Nous faisons suite à votre demande de prise en charge, au titre de votre contrat ' + @sLibProd + '. Sauf erreur de notre part, nous n’avons toujours pas reçu le ou les documents suivant(s) : ' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
		  End 

		-- [RS398][RS905]
		If @sVariante in ( 'BPCE_IOM', 'MY_PANGEE')
		  Begin
			Set @sMailBody  = @sMailBody  + 'Vous avez déclaré un sinistre le ' + @sDteDecl + ', au titre de votre contrat ' + @sLibProd + '.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'A ce jour, nous n''avons pas reçu le(s) document(s) demandé(s) nous permettant d’étudier votre dossier :'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
		  End 

		-- [ORANGE]
		If @sVariante in ( 'ORANGE', 'SAMSUNG' )
		  Begin
			Set @sMailBody  = @sMailBody  + 'Vous nous avez déclaré un sinistre le ' + @sDteDecl + ' dans le cadre de votre contrat ' + @sLibProd + ' qui couvre votre appareil ' + @sMarque + ' ' + @sModele + '.' 
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous n''avons à ce jour pas reçu la ou les pièces suivante(s):'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
		  End 

		-- Le défaut en dehors de toute variante
		If @sVariante = ''
		  Begin
			Set @sMailBody  = @sMailBody  + 'Vous nous avez déclaré un sinistre le ' + @sDteDecl + ' dans le cadre de votre contrat ' + @sLibProd + ' qui couvre votre appareil ' + @sMarque + ' ' + @sModele + '.' 
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous n''avons à ce jour pas reçu la ou les pièces suivante(s):'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
		  End 
	  End

	-- [DT364]
	IF @sTypRel in ( 'REL3', 'REL4') 
		Begin
			Set @sMailBody  = @sMailBody  + 'Dans le cadre de votre demande de prise en charge au titre de votre contrat ' + @sLibProd + ', vous avez été invité à nous retourner les documents nécessaires à l''étude de votre dossier :' 
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
		End 

	IF @sTypRel in ( 'REL5') 
		Begin
			-- [PM519-1]
			If @sVariante in ( 'MOBILEO', 'ATM', 'ATP' )
			  Begin
				Set @sMailBody  = @sMailBody  + 'Vous avez déclaré un sinistre le ' + @sDteDecl + ' concernant votre appareil ' + @sMarque + ' ' + @sModele + ', au titre de votre contrat ' + @sLibProd + '.' + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Malgré nos relances nous n''avons pas reçu le(s) document(s) demandé(s) pour procéder à l''étude de votre dossier.'+ @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Nous vous informons donc de la clôture de votre dossier.'+ @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Si vous souhaitez que votre demande d’indemnisation soit rouverte, nous vous remercions de nous appeler au '+ @sNumTelProd + '.'+ @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour toute question complémentaire.'+ @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Cordialement,'+ @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Votre gestionnaire d''assurance,'+ @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
			  End 
			
			-- [ORANGE]
			If @sVariante in ( 'ORANGE', 'SAMSUNG' )
			  Begin
				Set @sMailBody  = @sMailBody  + 'Vous nous avez déclaré un sinistre le ' + @sDteDecl + ' dans le cadre de votre contrat ' + @sLibProd + ' qui couvre votre appareil ' + @sMarque + ' ' + @sModele + '.' 
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Malgré nos relances et en l''absence de réception des pièces justificatives demandées nous n''avons pas pu procéder à l''examen de votre dossier.' 
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Nous vous informons donc de la clôture de votre demande.'
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Si vous souhaitez que votre demande d''indemnisation soit rouverte, nous vous remercions de bien vouloir prendre contact avec nos services.'
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour toute question complémentaire.'+ @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Cordialement,'+ @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Votre gestionnaire d''assurance,'+ @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
			End 
			
			-- [RS398][RS905]
			If @sVariante in (  'BPCE_IOM', 'MY_PANGEE' )
			  Begin
				Set @sMailBody  = @sMailBody  + 'Vous nous avez déclaré un sinistre le ' + @sDteDecl + ' dans le cadre de votre contrat ' + @sLibProd + '.' 
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Malgré nos relances et en l''absence de réception des pièces justificatives demandées nous n''avons pas pu procéder à l''examen de votre dossier.' 
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Nous vous informons donc de la clôture de votre demande.'
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Si vous souhaitez que votre demande d''indemnisation soit rouverte, nous vous remercions de bien vouloir prendre contact avec nos services : ' + @sAdrMailProd
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour toute question complémentaire.'+ @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Cordialement,'+ @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Votre gestionnaire d''assurance,'+ @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
			  End 

			-- Le défaut en dehors de toute variante
			If @sVariante = ''
			  Begin
				Set @sMailBody  = @sMailBody  + 'Vous nous avez déclaré un sinistre le ' + @sDteDecl + ' dans le cadre de votre contrat ' + @sLibProd + ' qui couvre votre appareil ' + @sMarque + ' ' + @sModele + '.' 
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Malgré nos relances et en l''absence de réception des pièces justificatives demandées nous n''avons pas pu procéder à l''examen de votre dossier.' 
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Nous vous informons donc de la clôture de votre demande.'
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Si vous souhaitez que votre demande d''indemnisation soit rouverte, nous vous remercions de bien vouloir prendre contact avec nos services.'
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour toute question complémentaire.'+ @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Cordialement,'+ @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + 'Votre gestionnaire d''assurance,'+ @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
				Set @sMailBody  = @sMailBody  + @sSaut
			End 
		End 


	IF @sTypRel Not in ( 'REL5') 
	  Begin
		Insert into @tbPce
		Select	Convert ( Varchar ( 8000), pa.txt_para) ,
				0
		From	sysadm.w_piece wp with (nolock),
				sysadm.paragraphe pa with (nolock)
		Where   wp.id_sin = @dcIdSin
		And		wp.id_i = 0 -- assuré
		And		pa.id_para = wp.id_para
		And     Left ( pa.id_para, 1 ) <> 'L'

		-- Cas des CPLxxx (paragraphe Lxxx)
		Insert into @tbPce
		Select	Replace ( Convert ( Varchar ( 8000), pa.txt_para), 'CP' + pa.id_para, IsNull ( wdt.lib_det, '' ) ),
				0
		From	sysadm.w_piece wp with (nolock),
				sysadm.w_detail wdt with (nolock),
				sysadm.paragraphe pa with (nolock)
		Where   wp.id_sin = @dcIdSin
		And		wp.id_i = 0 -- assuré
		And     wdt.id_sin = wp.id_sin 
		And     wdt.id_gti = wp.id_gti
		And     wdt.id_detail = wp.id_detail
		And		pa.id_para = wp.id_para
		And     Left ( pa.id_para, 1 ) = 'L'

		Select @sDteSurv = Convert ( Varchar ( 10), s.dte_surv, 103 ) From sysadm.sinistre s where id_sin = @dcIdSin
		If @sDteSurv is null Set @sDteSurv = ''

		Select @sZVAS20 = sysadm.FN_CLE_VAL ( 'URL_PAYBOX', rtrim ( val_car ) + rtrim ( val_car2 ), ';')
		From sysadm.det_pro dp
		Where dp.id_code_dp = 291
		Set @sZVAS20 = Replace ( @sZVAS20, '#ID_SIN#', Convert ( varchar ( 10), @dcIdSin ))
		If @sZVAS20 is null Set @sZVAS20 = ''

		While Exists ( Select * From @tbPce where marquage = 0 )
		 Begin
			Select 	Top 1 
				@iIdSeqPce = id_seq,
				@sTxtPara = ltrim ( rtrim ( txt_para )) 
			From @tbPce
			Where marquage = 0

			Set @sVal = Left ( @sTxtPara, 1 )
			Set @sTxtPara = Substring ( @sTxtPara, 2, Len ( @sTxtPara ) )
			Set @sVal = Ltrim ( Replace ( @sVal, '-', '' ) )
			Set @sTxtPara = @sVal + @sTxtPara 
			Set @sTxtPara = Replace ( @sTxtPara, '"', '' )
/*			Set @sTxtPara = Replace ( @sTxtPara, '«', '' )
			Set @sTxtPara = Replace ( @sTxtPara, '»', '' ) */

			-- Traitement pour fusionner les variables Word
			Set @sTxtPara = Replace ( @sTxtPara, 'SDTESU', @sDteSurv  )
			Set @sTxtPara = Replace ( @sTxtPara, 'ZVAS20', @sZVAS20  )
			Set @sTxtPara = Replace ( @sTxtPara, 'CPL014', ''  )

			Set @sMailBody  = @sMailBody  + ' - ' + rtrim ( ltrim ( @sTxtPara ))  + @sSaut

			Update @tbPce
			Set marquage = 1
			Where id_seq = @iIdSeqPce
		 End
	 End 

	-- [DT364]
	IF @sTypRel in ( 'REL1', 'REL2') 
	  Begin
		-- [PM519-1]
		If @sVariante = 'MOBILEO' And @sTypRel = 'REL1'
		  Begin
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Sans ce(s) document(s) nous ne pouvons étudier votre dossier.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut

			Set @sMailBody  = @sMailBody  + 'Vous pouvez nous le(s) transmettre :' + @sSaut
			Set @sMailBody  = @sMailBody  + '- soit en ligne, depuis le site sécurisé de votre banque, dans votre espace assurance, sélectionnez votre contrat, rubrique « déclarer et suivre un sinistre » et laissez-vous guider pour compléter votre dossier.' + @sSaut
			Set @sMailBody  = @sMailBody  + '- soit par courrier à l''adresse postale suivante : ' + @sAdrAdPostaleProd + '.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous étudierons votre demande dès la réception du ou des documents et nous vous communiquerons notre décision.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour toute question complémentaire au ' + @sNumTelProd + '.'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Cordialement,'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Votre gestionnaire d''assurance,'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
		  End 


		-- [RS5124]
		If @sVariante = 'ATP' And @sTypRel = 'REL1'
		  Begin
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Sans ce(s) document(s) nous ne pouvons étudier votre dossier.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut

			Set @sMailBody  = @sMailBody  + 'Vous pouvez nous le(s) transmettre :' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + '- soit par mail à l''adresse suivante : ' + @sAdrMailProd + @sSaut 
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + '- soit par courrier à l''adresse postale suivante : ' + @sAdrAdPostaleProd + '.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous étudierons votre demande dès la réception du ou des documents et nous vous communiquerons notre décision.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour toute question complémentaire au ' + @sNumTelProd + '.'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Cordialement,'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Votre gestionnaire d''assurance,'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
		  End 

		-- [RS5124]
		If @sVariante = 'ATM' And @sTypRel = 'REL1'
		  Begin
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Sans ce(s) document(s) nous ne pouvons étudier votre dossier.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut

			Set @sMailBody  = @sMailBody  + 'Vous pouvez nous le(s) transmettre :' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + '- soit en ligne, depuis votre espace assurance : ' + @sUrlEctranetSpb + ' rubrique « compléter mon dossier ». Pour vous connecter, munissez-vous de votre demande d''adhésion à l''Assurance Tous Mobiles afin d’y retrouver votre numéro de contrat.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + '- soit par mail à l''adresse suivante : ' + @sAdrMailProd + @sSaut 
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + '- soit par courrier à l''adresse postale suivante : ' + @sAdrAdPostaleProd + '.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous étudierons votre demande dès la réception du ou des documents et nous vous communiquerons notre décision.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour toute question complémentaire au ' + @sNumTelProd + '.'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Cordialement,'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Votre gestionnaire d''assurance,'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
		  End 


		If @sVariante = 'MOBILEO' And @sTypRel = 'REL2'
		  Begin
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Sans ce(s) document(s) nous ne pouvons étudier votre dossier.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut

			Set @sMailBody  = @sMailBody  + 'Vous pouvez nous le(s) transmettre :' + @sSaut
			Set @sMailBody  = @sMailBody  + '- soit en ligne, depuis le site sécurisé de votre banque, dans votre espace assurance, sélectionnez votre contrat, rubrique « déclarer et suivre un sinistre » et laissez-vous guider pour compléter votre dossier.' + @sSaut
			Set @sMailBody  = @sMailBody  + '- soit par courrier à l''adresse postale suivante : ' + @sAdrAdPostaleProd + '.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Dès réception, nous étudierons votre demande et vous informerons de la suite donnée.' + @sSaut
			Set @sMailBody  = @sMailBody  + 'Si nous n’avons pas de réponse de votre part dans un délai de 40 jours, nous serons dans l''obligation de clôturer votre dossier.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour toute question complémentaire au ' + @sNumTelProd + '.'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Cordialement,'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Votre gestionnaire d''assurance,'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
		  End 

		If @sVariante = 'ATP' And @sTypRel = 'REL2'
		  Begin
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Sans ce(s) document(s) nous ne pouvons étudier votre dossier.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut

			Set @sMailBody  = @sMailBody  + 'Vous pouvez nous le(s) transmettre :' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + '- soit par mail à l''adresse suivante : ' + @sAdrMailProd + @sSaut 
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + '- soit par courrier à l''adresse postale suivante : ' + @sAdrAdPostaleProd + '.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Dès réception, nous étudierons votre demande et vous informerons de la suite donnée.' + @sSaut
			Set @sMailBody  = @sMailBody  + 'Si nous n’avons pas de réponse de votre part dans un délai de 60 jours, nous serons dans l''obligation de clôturer votre dossier.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour toute question complémentaire au ' + @sNumTelProd + '.'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Cordialement,'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Votre gestionnaire d''assurance,'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
		  End 

		If @sVariante = 'ATM' And @sTypRel = 'REL2'
		  Begin
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Sans ce(s) document(s) nous ne pouvons étudier votre dossier.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut

			Set @sMailBody  = @sMailBody  + 'Vous pouvez nous le(s) transmettre :' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + '- soit en ligne, depuis votre espace assurance : ' + @sUrlEctranetSpb + ' rubrique « compléter mon dossier ». Pour vous connecter, munissez-vous de votre demande d''adhésion à l''Assurance Tous Mobiles afin d’y retrouver votre numéro de contrat.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + '- soit par mail à l''adresse suivante : ' + @sAdrMailProd + @sSaut 
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + '- soit par courrier à l''adresse postale suivante : ' + @sAdrAdPostaleProd + '.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Dès réception, nous étudierons votre demande et vous informerons de la suite donnée.' + @sSaut
			Set @sMailBody  = @sMailBody  + 'Si nous n’avons pas de réponse de votre part dans un délai de 60 jours, nous serons dans l''obligation de clôturer votre dossier.' + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour toute question complémentaire au ' + @sNumTelProd + '.'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Cordialement,'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Votre gestionnaire d''assurance,'+ @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
		  End 


		-- [ORANGE]
		If @sVariante in ( 'ORANGE', 'SAMSUNG' )
		  Begin	  
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous portons votre attention sur le fait que, tant que vous ne nous transmettez pas vos documents, nous ne pourrons pas instruire votre dossier.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Dès réception, nous ne manquerons pas de vous informer de la suite donnée à votre dossier.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut

			-- [VDOC27607]
			Set @sMailBody  = @sMailBody  + 'Nous vous rappelons par ailleurs que nous pouvons être amenés à vous demander toute pièce objectivement et strictement nécessaire permettant de démontrer que les conditions de la garantie sont réunies.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut

			Set @sMailBody  = @sMailBody  + 'Si vous nous avez transmis récemment cette/ces pièce(s), nos envois ont pu se croiser, nous vous remercions donc d’ignorer ce courrier.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Votre gestionnaire d''assurance' 
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Si votre contrat d''assurance dispose d''un site web de gestion de sinistre, vous pouvez à tout moment consulter et télécharger la ou les pièce(s) de votre dossier sur ce site communiqué par notre gestionnaire lors de votre déclaration.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Sincères salutations.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
		End 		

		-- [RS398][RS905]
		If @sVariante in ( 'BPCE_IOM', 'MY_PANGEE' )
		  Begin
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous portons votre attention sur le fait que, tant que vous ne nous transmettez pas vos documents, nous ne pourrons pas instruire votre dossier.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Vous pouvez nous le(s) transmettre par mail à l''adresse suivante : ' + @sAdrMailProd
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Dès réception, nous ne manquerons pas de vous informer de la suite donnée à votre dossier.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut

			-- [VDOC27607]
			Set @sMailBody  = @sMailBody  + 'Nous vous rappelons par ailleurs que nous pouvons être amenés à vous demander toute pièce objectivement et strictement nécessaire permettant de démontrer que les conditions de la garantie sont réunies.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut

			Set @sMailBody  = @sMailBody  + 'Si vous nous avez transmis récemment cette/ces pièce(s), nos envois ont pu se croiser, nous vous remercions donc d’ignorer ce courrier.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire au ' + @sNumTelProd + ' et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Cordialement,'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Votre gestionnaire d''assurance' 
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
		  End 

		-- Le défaut en dehors de toute variante
		If @sVariante = ''
		  Begin	  
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous portons votre attention sur le fait que, tant que vous ne nous transmettez pas vos documents, nous ne pourrons pas instruire votre dossier.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Dès réception, nous ne manquerons pas de vous informer de la suite donnée à votre dossier.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut

			-- [VDOC27607]
			Set @sMailBody  = @sMailBody  + 'Nous vous rappelons par ailleurs que nous pouvons être amenés à vous demander toute pièce objectivement et strictement nécessaire permettant de démontrer que les conditions de la garantie sont réunies.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut

			Set @sMailBody  = @sMailBody  + 'Si vous nous avez transmis récemment cette/ces pièce(s), nos envois ont pu se croiser, nous vous remercions donc d’ignorer ce courrier.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Votre gestionnaire d''assurance' 
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Si votre contrat d''assurance dispose d''un site web de gestion de sinistre, vous pouvez à tout moment consulter et télécharger la ou les pièce(s) de votre dossier sur ce site communiqué par notre gestionnaire lors de votre déclaration.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Sincères salutations.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
		End 
	End

	-- [DT364]
	IF @sTypRel in ( 'REL3', 'REL4') 
		Begin
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Cependant, malgré nos relances, nous constatons que vos documents n’ont pas été réceptionnés par notre service de gestion.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Nous portons votre attention sur le fait que, tant que vous ne nous transmettez pas vos documents, nous ne pourrons pas instruire votre dossier.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			
--			If @sVariante <> '1'
			If @sVariante = 'ORANGE' -- [PM519-1]
				Begin 
					Set @sMailBody  = @sMailBody  + 'Vous pouvez à tout moment consulter et télécharger la ou les pièce(s) de votre dossier depuis votre espace assuré https://orange.spb.eu rubrique « compléter votre dossier ».'
					Set @sMailBody  = @sMailBody  + @sSaut
					Set @sMailBody  = @sMailBody  + @sSaut
				End 

			Set @sMailBody  = @sMailBody  + 'Dès réception, nous ne manquerons pas de vous informer de la suite donnée à votre dossier.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut

			-- [VDOC27607]
			Set @sMailBody  = @sMailBody  + 'Nous vous rappelons par ailleurs que nous pouvons être amenés à vous demander toute pièce objectivement et strictement nécessaire permettant de démontrer que les conditions de la garantie sont réunies.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut

			Set @sMailBody  = @sMailBody  + 'Si vous nous avez transmis récemment cette/ces pièce(s), nos envois ont pu se croiser, nous vous remercions donc d''ignorer ce courrier.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + 'Sincères salutations.'
			Set @sMailBody  = @sMailBody  + @sSaut
			Set @sMailBody  = @sMailBody  + @sSaut
		End 


	Set @sMailBody  = @sMailBody  + '****************************************************************'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + '****************************************************************'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'

	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @dcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
    Set @sAltQuarant = 'N'

	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
		Begin  -- TRACE_MAIL_PRO : Début écriture
		  Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			@sAltQuarant,
			@sBoiteMail, -- #3
			@sCodeMail, -- #3
			2 -- #3
		End
	Else
	    Begin  -- TRACE_MAIL_TRT : Début écriture
		  Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			@sAltQuarant,
			@sBoiteMail, -- #3
			@sCodeMail, -- #3
			2 -- #3	
		End

		If Exists ( Select Top 1 1 From sysadm.w_sin ws with (nolock) Where ws.id_sin = @dcIdSin  )	
		  Begin
			If Exists ( Select Top 1 1 From sysadm.w_div_sin wds with (nolock) Where wds.id_sin = @dcIdSin And nom_zone = @sNomZoneDivPro)
			 Begin
			   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = @sNomZoneDivPro
			 End 
			Else
			 Begin	 
			   Insert into sysadm.w_div_sin values ( @dcIdSin, @sNomZoneDivPro, @sLibZoneDivPro, '-1', 'N', 'D', 'N', 'N', @iCptTri, null, null, GETDATE(), null, 1, getdate(), getdate(), 'AUTO' ) 
			 End
		  End


		If Exists ( Select Top 1 1 From sysadm.sinistre ws with (nolock) Where ws.id_sin = @dcIdSin  )	
		  Begin
			If Exists ( Select Top 1 1 From sysadm.div_sin wds with (nolock) Where wds.id_sin = @dcIdSin And nom_zone = @sNomZoneDivPro)
			 Begin
			   Update sysadm.div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'AUTO' Where id_sin = @dcIdSin And nom_zone = @sNomZoneDivPro
			 End 
			Else
			 Begin	 
			   Insert into sysadm.div_sin values ( @dcIdSin, @sNomZoneDivPro, @sLibZoneDivPro, '-1', 'N', 'D', 'N', 'N', @iCptTri, null, null, GETDATE(), null, getdate(), getdate(), 'AUTO', getdate(), 'AUTO' ) 
			 End
		  End

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, @iIdTypContact, 'C', @dcIdSin, 2, @sMess,	'AUTO', 300, @iIdCt OUTPUT, @iIdNatTache
		END
		ELSE
		BEGIN
			Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, @iIdTypContact, 'C', @dcIdSin, 2, @sMess,	'AUTO', 300, @iIdCt OUTPUT, @iIdNatTache
		END


	-- [DT364]
	IF @sTypRel in ( 'REL5') 
		Begin
			Set @sAltQueue = space (1)
			Exec sysadm.PS_D01_ARCHIVE_SOLDAGE @dcIdSin, 'SQLS', @dtDateJour, @sAltQueue Output, 'CENTRALISE'
			Exec sysadm.PS_I_DIV_SIN_ETAT_ASS @dcIdSin, 'SQLS'
		End

	-- [PI087_PM473_2]
	Exec sysadm.PS_I_PI087_TRACE_DOSSIER @dcIdSin, 'VALIDATION', 'SQLS'

	Update @tb Set marquage = 1	Where id_seq = @iIdSeq
 End

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_MAILPUSH_CONFORME_611
-- Auteur               :       JFF
-- Date                 :       07/03/2017
-- Libelle              :		[DT288]
-- Commentaires         :       
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       0 si rien n'est parti, 1 un mail/sms parti, autre = erreur
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MAILPUSH_CONFORME_611' AND type = 'P' )
        DROP procedure sysadm.PS_S_MAILPUSH_CONFORME_611
GO

CREATE procedure sysadm.PS_S_MAILPUSH_CONFORME_611
  @adcIdSin	Decimal (10,0), -- [PI062]--  Le numéro du sinistre
  @aiIdSeq		Integer ,     --  l’id_seq de la commande
  @asIdFour	Varchar(3),
  @aiStatusGc	Integer,
  @asCasRetour VarChar ( 50 ) OUTPUT
As

	Declare  @nb 	Integer,
		@sNumSmsPort Varchar(25),
		@sAdrMail Varchar(120),
		@iRet	Integer,
		@sLogin 	VarChar ( 10 ),  
		@sMdPasse 	VarChar ( 10 ), 
		@sSmsBody	VarChar(255),
		@sCodeTrt	Varchar(10),
		@sBase		Varchar(20),
		@sNumTelProd	Varchar(20),
		@dcIdProd 	Decimal(7,0),
		@iIdProd	integer,
		@sLibProd	Varchar(60),
		@iIdSin 	integer,
		@iIdEts 	integer,
		@dcIdEts	Decimal(7,0),
		@sBoiteMail   VarChar (35),
		@sMailFrom	VarChar (128), 
		@sMailSend	VarChar (128), 
		@sMailCc	VarChar (128),
		@sMailObjet	VarChar ( 255 ),
		@sMailBody	VarChar ( 7000 ),
		@sSaut	VarChar (10), 
		@sCasRetour	Varchar(255),
		@sTypeApp	Varchar(255),
		@sVal   VarChar ( 255 ),
		@iOptionDP Integer,
		@sNumProd     VarChar (20), 
		@sCiv		VarChar (100), 
		@sNom		VarChar (50),
		@sAltQuarant  VarChar (1),
		@sAltSuiviSMS VarChar ( 1 ),
		@sNumGsmSMS   VarChar ( 20 ),
		@iOrangeV3 Integer,
		@sMarque VarChar ( 35 ), 
		@sModele VarChar ( 35 )

  	Set @iRet=0
	Set @sBase = DB_NAME()
	Set @sMailFrom = 'noreply@spb.eu'
	Set @sMailCc = ''
	Set @sSaut = Char (10)
  	  -- Option de déclenchement du mail -DP
	Set @iOptionDP = 49

  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@sBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT,  
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #3
	@sAltSuiviSMS OUTPUT, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #5 [FNAC_PROD_ECH_TECH].[SMS]

	Select   @sMarque = IsNull ( sysadm.FN_TRIM ( s.marq_port ), '') ,
			 @sModele = IsNull ( sysadm.FN_TRIM ( s.modl_port ), '')
	From     sysadm.sinistre s
	Where   s.id_sin = @adcIdSin

	Select @iOrangeV3 = COUNT ( * ) 
	From   sysadm.det_pro d,
		   sysadm.sinistre s
	where  s.id_sin = @adcIdSin
	And    d.id_prod = s.id_prod
	And    d.id_code_dp = 94
	And    sysadm.FN_CLE_VAL ( 'COD_DW', rtrim ( val_car ), ';') in ( 'ORANGE_V3', 'ORANGE_V2BIS', 'ORANGE_V3BIS', 'ORANGE_V3TER' )

	If @iOrangeV3 is null Set @iOrangeV3 = 0


  If @iRet = -7 
    Begin
		If @iOrangeV3 > 0 
		 Begin
			-- Le but pour Orange V3 et de toujours mettre une adresse mail si l'adresse réél n'est pas là, pour justement
			-- déclencher l'échec de distribution et donc envoyer le courrier en automatique.
			Set @sMailSend = 'DeclEchecDistrib@spb.fr'
			Set @iRet = 0			
		 End
		Else
		 Begin
			 Set @asCasRetour = 'ADRESSE_MAIL_ABSENTE'
			 Return 0
		 End 
	End

  -- Cas de retour n'étant pas des erreurs
  If @iRet in ( -9, -10 )
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

  -- Problème suite éxécution
  If @iRet <> 0 Return @iRet

	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	
	-- Gestion de la civilité "Madame, Monsieur"
	If @sNom <> ''
	Begin
		Set @sCiv = @sCiv + ' ' + @sNom + ','
	End 
	
	Set @sMailObjet = 'Votre dossier n°' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) + ' ' + @sLibProd -- [PI062]

	Set @sMailBody  = ''
	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut

	-- Modif mail Mantis 24707
	Set @sMailBody = @sMailBody + 'Nous avons le plaisir de vous informer de la prise en charge de votre appareil ' + @sMarque + ' ' + @sModele + ' au titre de votre contrat.' + @sSaut
	Set @sMailBody = @sMailBody + @sSaut
	Set @sMailBody = @sMailBody + 'Nous procéderons à la réparation de votre appareil.' + @sSaut
	Set @sMailBody = @sMailBody + 'Sous réserve du diagnostic du technicien, une remise en état de votre appareil sera effectuée dans les 10 jours ouvrés qui suivent (si aucune sécurité, telle que la fonction « Localiser mon Iphone/Ipad », n’est activée sur votre appareil).' + @sSaut
	Set @sMailBody = @sMailBody + @sSaut
	Set @sMailBody = @sMailBody + 'Si votre appareil s''avère irréparable, celui si fera l’objet d''un remplacement (**) qui peut s’avérer iso-fonctionnel (c''est-à-dire possédant les mêmes caractéristiques techniques principales que l''appareil garanti) ou d''une indemnisation financière correspondant au plafond des garanties prévues par votre contrat.' + @sSaut
	Set @sMailBody = @sMailBody + @sSaut
	Set @sMailBody = @sMailBody + 'Selon les procédures propres à chaque constructeur, ce dernier peut décider, à sa seule discrétion, de la réparation ou du remplacement du produit assuré endommagé.' + @sSaut	
	Set @sMailBody = @sMailBody + @sSaut
	Set @sMailBody = @sMailBody + @sSaut
	Set @sMailBody = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
	Set @sMailBody = @sMailBody + @sSaut
	Set @sMailBody = @sMailBody  + '** : Selon la définition mentionnée dans la Notice d’information.'
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + '****************************************************************'
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL'
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + '****************************************************************'
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'
		
	
		
	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	Begin  -- TRACE_MAIL_PRO : Début écriture

		Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'CONFRP',
			2 		

		-- Problème suite éxécution
		If @iRet <> 0 Return -20
			
		Set @iRet=1
	End    -- TRACE_MAIL_PRO : Fin écriture
	Else
	Begin  -- TRACE_MAIL_TRT : Début écriture

		Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'CONFRP',
			2 	

	End    -- TRACE_MAIL_TRT : Fin écriture

	-- Problème suite éxécution
	If @iRet <> 0 Return -20

	Set @iRet=1
	
	Return @iRet
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_MAILPUSH_DT288_4_INFO_REGL
-- Auteur               :       JFF
-- Date                 :       18/04/2018
-- Libelle              :		[DT288-4]
-- Commentaires         :       
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MAILPUSH_DT288_4_INFO_REGL' AND type = 'P' )
        DROP procedure sysadm.PS_S_MAILPUSH_DT288_4_INFO_REGL
GO

CREATE procedure sysadm.PS_S_MAILPUSH_DT288_4_INFO_REGL
  @adcIdSin	Decimal (10,0), -- [PI062]--  Le numéro du sinistre
  @adcIdReg	Decimal (2,0),
  @sCodModeReg    Varchar (  2   ),
  @dcMtAReg       Decimal ( 11,2 ),
  @asCasRetour VarChar ( 50 ) OUTPUT
As

	Declare  @nb 	Integer,
		@sNumSmsPort Varchar(25),
		@sAdrMail Varchar(120),
		@iRet	Integer,
		@sLogin 	VarChar ( 10 ),  
		@sMdPasse 	VarChar ( 10 ), 
		@sSmsBody	VarChar(255),
		@sCodeTrt	Varchar(10),
		@sBase		Varchar(20),
		@sNumTelProd	Varchar(20),
		@dcIdProd 	Decimal(7,0),
		@iIdProd	integer,
		@sLibProd	Varchar(60),
		@iIdSin 	integer,
		@iIdEts 	integer,
		@dcIdEts	Decimal(7,0),
		@sBoiteMail   VarChar (35),
		@sMailFrom	VarChar (128), 
		@sMailSend	VarChar (128), 
		@sMailCc	VarChar (128),
		@sMailObjet	VarChar ( 255 ),
		@sMailBody	VarChar ( 7000 ),
		@sSaut	VarChar (10), 
		@sCasRetour	Varchar(255),
		@sTypeApp	Varchar(255),
		@sVal   VarChar ( 255 ),
		@iOptionDP Integer,
		@sNumProd     VarChar (20), 
		@sCiv		VarChar (100), 
		@sNom		VarChar (50),
		@sAltQuarant  VarChar (1),
		@sAltSuiviSMS VarChar ( 1 ),
		@sNumGsmSMS   VarChar ( 20 ),
		@iOrangeV3 Integer,
		@sMarque VarChar ( 35 ), 
		@sModele VarChar ( 35 )

  	Set @iRet=0
	Set @sBase = DB_NAME()
	Set @sMailFrom = 'noreply@spb.eu'
	Set @sMailCc = ''
	Set @sSaut = Char (10)
  	  -- Option de déclenchement du mail -DP
	Set @iOptionDP = 48 -- Je m'appuie volontairement sur la 48 pour éviter de recréer un nouvelle option

  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@sBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT,  
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #3
	@sAltSuiviSMS OUTPUT, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #5 [FNAC_PROD_ECH_TECH].[SMS]

  If @iRet = -7 
    Begin
		Set @asCasRetour = 'ADRESSE_MAIL_ABSENTE'
		Return 0
	End

  -- Cas de retour n'étant pas des erreurs
  If @iRet in ( -9, -10 )
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

  -- Problème suite éxécution
  If @iRet <> 0 Return @iRet

	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	
	-- Gestion de la civilité "Madame, Monsieur"
	If @sNom <> ''
	Begin
		Set @sCiv = @sCiv + ' ' + @sNom + ','
	End 
	
	Set @sMailObjet = 'Votre dossier n°' + sysadm.FN_TRIM ( Right ( Replicate ( '0', 10 ) + Convert ( VarChar, @adcIdSin ), 10 ) ) + ' ' + @sLibProd -- [PI062]

	Set @sMailBody  = ''
	Set @sMailBody  = @sMailBody  + @sCiv
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut

	-- Modif mail Mantis 24707
	Set @sMailBody = @sMailBody + 'Nous avons le plaisir de vous informer que vous allez recevoir prochainement un chèque en règlement de votre sinistre.' 
	Set @sMailBody = @sMailBody + @sSaut
	Set @sMailBody = @sMailBody + @sSaut
	Set @sMailBody = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions d’agréer, ' + @sCiv + ' nos salutations distinguées.'
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + '****************************************************************'
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL'
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + '****************************************************************'
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'
		
	
		
	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	Begin  -- TRACE_MAIL_PRO : Début écriture

		Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'INFRGL',
			2 		

		-- Problème suite éxécution
		If @iRet <> 0 Return -20
			
		Set @iRet=1
	End    -- TRACE_MAIL_PRO : Fin écriture
	Else
	Begin  -- TRACE_MAIL_TRT : Début écriture

		Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'INFRGL',
			2 	

	End    -- TRACE_MAIL_TRT : Fin écriture

	-- Problème suite éxécution
	If @iRet <> 0 Return -20

	Set @iRet=1
	
	Return @iRet
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_MAILPUSH_DT363_REMPL_AAS
-- Auteur               :       JFF
-- Date                 :       31/07/2018
-- Libelle              :		[DT363]
-- Commentaires         :       
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       
--
-------------------------------------------------------------------
-- JFF	13/09/2018	[VDOC26690]
-- JFF	16/04/2019	[VDOC27852]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_MAILPUSH_DT363_REMPL_AAS' AND type = 'P' )
        DROP procedure sysadm.PS_I_MAILPUSH_DT363_REMPL_AAS
GO

CREATE procedure sysadm.PS_I_MAILPUSH_DT363_REMPL_AAS
  @adcIdSin	Decimal (10,0), -- [PI062]--  Le numéro du sinistre
  @aiIdSeq  Integer ,
  @adcIdProd Decimal ( 7 ),
  @adcIdGti Decimal ( 7 ),
  @asMtPec VarChar ( 30 )
As

	Declare  @nb 	Integer,
		@sNumSmsPort Varchar(25),
		@sAdrMail Varchar(120),
		@iRet	Integer,
		@sLogin 	VarChar ( 10 ),  
		@sMdPasse 	VarChar ( 10 ), 
		@sSmsBody	VarChar(255),
		@sCodeTrt	Varchar(10),
		@sBase		Varchar(20),
		@sNumTelProd	Varchar(20),
		@dcIdProd 	Decimal(7,0),
		@iIdProd	integer,
		@sLibProd	Varchar(60),
		@iIdSin 	integer,
		@iIdEts 	integer,
		@dcIdEts	Decimal(7,0),
		@sBoiteMail   VarChar (35),
		@sMailFrom	VarChar (128), 
		@sMailSend	VarChar (128), 
		@sMailCc	VarChar (128),
		@sMailObjet	VarChar ( 255 ),
		@sMailBody	VarChar ( 7000 ),
		@sSaut	VarChar (10), 
		@sCasRetour	Varchar(255),
		@sTypeApp	Varchar(255),
		@sVal   VarChar ( 255 ),
		@iOptionDP Integer,
		@sNumProd     VarChar (20), 
		@sCiv		VarChar (100), 
		@sNom		VarChar (50),
		@sAltQuarant  VarChar (1),
		@sAltSuiviSMS VarChar ( 1 ),
		@sNumGsmSMS   VarChar ( 20 ),
		@iOrangeV3 Integer,
		@sMarque VarChar ( 35 ), 
		@sModele VarChar ( 35 ),
		@sMailAasRetour VarChar ( 128 ),
		@dcIdGti Decimal ( 7 ),
		@asCasRetour varchar ( 50 )

  Declare @sTypApp	Varchar ( 35 )
  Declare @sMarqApp Varchar ( 35 )
  Declare @sModlApp Varchar ( 35 )
  Declare @sImei	Varchar ( 35 )
  Declare @sGti		Varchar ( 35 )
  Declare @sPrenom	varchar ( 35 )
  Declare @sAdresse	varchar ( 500 )
  Declare @sAdrCp	varchar ( 35 )
  Declare @sAdrVille  VarChar ( 20 )
  Declare @sMtPec   varchar ( 35 )
  Declare @sNumTel  Varchar ( 35 )
  Declare @sNumPort  VarChar ( 20 )
  Declare @sDteAchPort VarChar ( 20 )
  Declare @sMtValAchat VarChar ( 20 )
  Declare @sDteSurv VarChar ( 20 )
  Declare @sProbleme VarChar ( 20 )

  	Set @iRet=0
	Set @sBase = DB_NAME ()
	Set @sMailFrom = 'noreply@spb.eu'
	Set @sMailCc = ''
	Set @sSaut = Char (10)
  	  -- Option de déclenchement du mail -DP
	Set @iOptionDP = 48 -- Je m'appuie volontairement sur la 48 pour éviter de recréer un nouvelle option

  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@sBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT,  
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #3
	@sAltSuiviSMS OUTPUT, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #5 [FNAC_PROD_ECH_TECH].[SMS]

  If @iRet = -7 Set @iRet = 0

  -- Cas de retour n'étant pas des erreurs
  If @iRet in ( -9, -10 )
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

  -- [DT401]
	Select @sMailFrom = sysadm.FN_CLE_VAL ( 'BOITE_MAIL', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';' ) 
	From   sysadm.det_pro dp
	Where  dp.id_prod = @adcIdProd
	And    dp.id_code_dp = 252


  Select @sMailSend = sysadm.FN_CLE_VAL ( 'ADR_MAIL_AAS', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';' ) 
  From   sysadm.det_pro dp
  Where  dp.id_prod = @adcIdProd
  And    dp.id_code_dp = 252

  Select @sMailAasRetour = sysadm.FN_CLE_VAL ( 'ADR_MAIL_AAS_RETOUR', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';' ) 
  From   sysadm.det_pro dp
  Where  dp.id_prod = @adcIdProd
  And    dp.id_code_dp = 252

  If @aiIdSeq > 0 
    Begin
	  Select @sTypApp  = ltrim ( rtrim ( IsNull (  sysadm.FN_GET_DIV_SIN  ( s.id_sin, 'TYPE_APP', 'P', ''), '') )),
			 @sMarqApp = ltrim ( rtrim ( IsNull ( s.marq_port, ''))),
			 @sModlApp = ltrim ( rtrim ( IsNull ( s.modl_port, '' ))),
			 @sImei	   = ltrim ( rtrim ( IsNull ( s.num_imei_port, ''))),
			 @sGti     = ltrim ( rtrim ( IsNull ( sysadm.FN_CODE_NUM ( c.id_gti, '-GA' ), ''))),
			 @dcIdGti  = c.id_gti,
			 @sNom	   = ltrim ( rtrim ( IsNull ( c.adr_nom, '' ))),
			 @sPrenom  = ltrim ( rtrim ( IsNull ( c.adr_prenom, '' ))),
			 @sAdresse = ltrim ( rtrim ( IsNull ( c.adr_livr1, '' ))) + ' ' + ltrim ( rtrim ( IsNull ( c.adr_livr2, '') )) + ' ' + ltrim ( rtrim ( IsNull ( c.adr_livr_cpl, '' )))  ,
			 @sAdrCp   = ltrim ( rtrim ( IsNull ( c.adr_cp, '' ) )),
			 @sAdrVille =  ltrim ( rtrim ( IsNull ( c.adr_ville, '' ) )),
			 @sAdrMail = ltrim ( rtrim ( IsNull ( i.adr_mail, '' ) )),
			 @sMtPec   = IsNull ( Convert ( varchar, c.mt_ttc_cmde ), ''),
			 @sNumTel  = IsNull ( rtrim ( i.num_teld ), '' ), -- [VDOC26690]
			 @sNumPort = IsNull ( rtrim ( s.num_port ), '' ),  -- [VDOC27852]
			 @sDteAchPort = IsNull ( Convert ( varchar, s.dte_ach_port, 103 ), '' ), -- [VDOC27852]
			 @sMtValAchat = Convert  ( Varchar, dt.mt_val_achat ), -- [VDOC27852]
			 @sDteSurv    = Convert ( varchar, s.dte_surv, 103 ), 
			 @sProbleme   = IsNull ( rtrim ( c.probleme), '' ) 

	  From	 sysadm.sinistre s,
			 sysadm.commande c,
			 sysadm.inter i,
			 sysadm.detail dt
	  Where  s.id_sin = @adcIdSin	
	  And    c.id_sin = s.id_sin
	  And    c.id_seq = @aiIdSeq
	  And    i.id_sin = s.id_sin
	  And    i.cod_inter = 'A'
	  And    dt.id_sin = c.id_sin
	  And    dt.id_gti = c.id_gti
	  And    dt.id_detail = c.id_detail 
    End 
  Else
    Begin
	  Select @sTypApp  = ltrim ( rtrim ( IsNull ( sysadm.FN_GET_DIV_SIN  ( s.id_sin, 'TYPE_APP', 'P', ''), '') )),
			 @sMarqApp = ltrim ( rtrim ( IsNull ( s.marq_port, '' ))),
			 @sModlApp = ltrim ( rtrim ( IsNull ( s.modl_port, '' ) )),
			 @sImei	   = ltrim ( rtrim ( IsNull ( s.num_imei_port , '' ))),
			 @sGti     = ltrim ( rtrim ( IsNull ( sysadm.FN_CODE_NUM ( @adcIdGti, '-GA' ), '' ))),
			 @dcIdGti  = @adcIdGti,
			 @sNom	   = ltrim ( rtrim ( IsNull ( p.nom, '' ) )),
			 @sPrenom  = ltrim ( rtrim ( IsNull ( p.prenom, '' ) )),
			 @sAdresse = ltrim ( rtrim ( IsNull ( p.adr_1, '' ) )) + ' ' + ltrim ( rtrim ( IsNull ( p.adr_2, '') )),
			 @sAdrCp   = ltrim ( rtrim ( IsNull ( p.adr_cp, '' ) )),
			 @sAdrVille =  ltrim ( rtrim ( IsNull ( p.adr_ville, '' ) )),
			 @sAdrMail = ltrim ( rtrim ( IsNull ( i.adr_mail, ''))),
			 @sMtPec   = ltrim ( rtrim ( IsNull ( @asMtPec, '' ))),
			 @sNumTel  = IsNull ( rtrim ( i.num_teld ), '' ), -- [VDOC26690]
			 @sNumPort = IsNull ( rtrim ( s.num_port ), '' ),  -- [VDOC27852]
			 @sDteAchPort = IsNull ( Convert ( varchar, s.dte_ach_port, 103 ), '' ), -- [VDOC27852]
			 @sMtValAchat = Convert  (Varchar,
										IsNull ( 
										 ( Select max ( dt.mt_val_achat )
														  From   sysadm.detail dt
			 											  Where  dt.id_sin = s.id_sin
														  And    dt.id_gti = @adcIdGti )
										, 0 )), -- [VDOC27852]
			 @sDteSurv    = Convert ( varchar, s.dte_surv, 103 ), 
			 @sProbleme   = ''

	  From	 sysadm.sinistre s,
			 sysadm.inter i,
			 sysadm.personne p
	  Where  s.id_sin = @adcIdSin	
	  And    p.id_ordre = s.id_ordre
	  And    i.id_sin = s.id_sin
	  And    i.cod_inter = 'A'

    End 

  -- Problème suite éxécution
  If @iRet <> 0 Return @iRet

	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	
	-- Gestion de la civilité "Madame, Monsieur"
	If @sNom <> ''
	Begin
		Set @sCiv = @sCiv + ' ' + @sNom + ' ' + @sPrenom
	End 
	
	Set @sMailObjet = 'Commande de remplacement - Dossier n°' + Convert ( VarChar, @adcIdSin ) + ' / ' + @sCiv + ' - ' + @sLibProd + ' / ' + sysadm.FN_CODE_CAR ( 'AAS', '-FR' )
	
	Set @sMailBody  = 'Bonjour,' + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous vous informons de la déclaration de sinistre de ' + @sCiv + ' ' + ' concernant '
	
	If @dcIdGti = 10 Set @sMailBody  = @sMailBody  + 'le vol'
	If @dcIdGti = 12 Set @sMailBody  = @sMailBody  + 'la perte'
	If @dcIdGti not in ( 10, 12 ) Set @sMailBody  = @sMailBody  + 'le dommage'

	Set @sMailBody  = @sMailBody  + ' de son appareil.' + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Type : ' + @sTypApp + @sSaut
	Set @sMailBody  = @sMailBody  + 'Marque : ' + @sMarqApp + @sSaut
	Set @sMailBody  = @sMailBody  + 'Modèle : ' + @sModlApp + @sSaut
	Set @sMailBody  = @sMailBody  + 'IMEI/SERIE : ' + @sImei + @sSaut

	Set @sMailBody  = @sMailBody + 'Tél : ' + @sNumPort + @sSaut
	Set @sMailBody  = @sMailBody + 'Date d''achat de l''appareil sinistré : ' + @sDteAchPort + @sSaut
	Set @sMailBody  = @sMailBody + 'Montant de la valeur d''achat : ' + @sMtValAchat + @sSaut
	Set @sMailBody  = @sMailBody + 'Date de survenance du sinistre  : ' + @sDteSurv + @sSaut

	Set @sMailBody  = @sMailBody  + 'Garantie : ' + @sGti + @sSaut

	Set @sMailBody  = @sMailBody + 'Description du problème : ' + @sProbleme + @sSaut

	Set @sMailBody  = @sMailBody  + @sSaut

	If @dcIdGti in ( 10, 12 ) Set @sMailBody  = @sMailBody  + 'De ce fait, nous vous remercions d’adresser un appareil de remplacement en règlement du sinistre à l''adresse suivante : ' + @sSaut
	If @dcIdGti not in ( 10, 12 ) Set @sMailBody  = @sMailBody  + 'Le diagnostic de l''appareil, réalisé par notre centre technique agréé indique que celui-ci est économiquement irréparable. De ce fait, nous vous remercions d’adresser un appareil de remplacement en règlement du sinistre à l''adresse suivante : ' + @sSaut

	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nom : ' + @sNom + @sSaut
	Set @sMailBody  = @sMailBody  + 'Prénom : ' + @sPrenom + @sSaut
	Set @sMailBody  = @sMailBody  + 'Adresse postale : ' + @sAdresse + @sSaut
	Set @sMailBody  = @sMailBody  + 'Code postal : ' + @sAdrCp + @sSaut
	Set @sMailBody  = @sMailBody  + 'Ville : ' + @sAdrVille + @sSaut

	Set @sMailBody  = @sMailBody  + 'Adresse mail client : ' + @sAdrMail + @sSaut
	Set @sMailBody  = @sMailBody  + 'N° de tél de l''assuré: ' + @sNumTel + @sSaut -- [VDOC26690]
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Merci également de prendre en compte conformément aux conditions contractuelles, le montant du plafond d''indemnisation ci-dessous auquel le client peut prétendre pour le remplacement de son appareil : ' + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Montant du plafond : ' + @sMtPec + ' Euros TTC.'  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Pour une mise à jour du dossier dans nos outils vous devrez adresser impérativement votre retour ci-dessous à l’adresse mail ' + @sMailAasRetour + ', l’objet du mail précisera obligatoirement la mention « Libellé Produit » et la référence du dossier sinistre : Dossier n° « N° de dossier » / « Nom Prénom » - « Libellé Produit » / « code prestataire »' + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'Nous restons à votre entière disposition pour tout renseignement complémentaire et vous prions	d''agréer, nos salutations distinguées.'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + '=================================================================='
	Set @sMailBody  = @sMailBody  + '       ZONE RESERVEE AU PRESTATAIRE ADVISE AFFINITY SERVICES      '
	Set @sMailBody  = @sMailBody  + '=================================================================='
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + 'NUM_INTERVENTION : |____________________________________________________________|' + @sSaut
	Set @sMailBody  = @sMailBody  + 'DATE_DE_TRAITEMENT/DATE_ENVOI_CLIENT : _ _ / _ _ / _ _ _ _' + @sSaut
	Set @sMailBody  = @sMailBody  + 'BON_CHRONO (SI ENVOI) : |________________________________________________________|' + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'ETAT_PRESTATION_1 : |_| Commande non honorée' + @sSaut
	Set @sMailBody  = @sMailBody  + 'Les zones ci-dessous doivent être obligatoirement renseignées :' + @sSaut
	Set @sMailBody  = @sMailBody  + '      MOTIF/COMMENTAIRES : |____________________________________________________|' + @sSaut
	Set @sMailBody  = @sMailBody  + '      Accord pour indemnisation pécuniaire : |_|' + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut	
	Set @sMailBody  = @sMailBody  + 'ETAT_PRESTATION_2 : |_| Commande honorée' + @sSaut
	Set @sMailBody  = @sMailBody  + 'Les zones ci-dessous doivent être obligatoirement renseignées :' + @sSaut
	Set @sMailBody  = @sMailBody  + '      Marque de remplacement : |____________________________________________________|' + @sSaut
	Set @sMailBody  = @sMailBody  + '      Modèle de remplacement : |____________________________________________________|' + @sSaut
	Set @sMailBody  = @sMailBody  + '      Numéro IMEI/SERIE appareil de remplacement : |___________________________________|' + @sSaut
	Set @sMailBody  = @sMailBody  + '      Prix TTC de l’appareil de remplacement : _______________________________________€|' + @sSaut
	Set @sMailBody  = @sMailBody  + '      Etat de l’appareil de remplacement : NEUF |_| RECONDITIONNE |_|'

	
		
	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	Begin  -- TRACE_MAIL_PRO : Début écriture

		Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'FRNAAS',
			2 		

		-- Problème suite éxécution
		If @iRet <> 0 Return -20
			
		Set @iRet=1
	End    -- TRACE_MAIL_PRO : Fin écriture
	Else
	Begin  -- TRACE_MAIL_TRT : Début écriture

		Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'FRNAAS',
			2 	

	End    -- TRACE_MAIL_TRT : Fin écriture

	-- Problème suite éxécution
	If @iRet <> 0 Return -20

	Set @iRet=1
	
	Return @iRet
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_MAILPUSH_DT339_VIRTUEL_SAGA2
-- Auteur               :       JFF
-- Date                 :       12/03/2019
-- Libelle              :		[DT339]
-- Commentaires         :       
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_MAILPUSH_DT339_VIRTUEL_SAGA2' AND type = 'P' )
        DROP procedure sysadm.PS_I_MAILPUSH_DT339_VIRTUEL_SAGA2
GO

CREATE procedure sysadm.PS_I_MAILPUSH_DT339_VIRTUEL_SAGA2
  @adcIdSin	Decimal (10,0) -- [PI062]--  Le numéro du sinistre
As

	Declare  @nb 	Integer,
		@sNumSmsPort Varchar(25),
		@sAdrMail Varchar(120),
		@iRet	Integer,
		@sLogin 	VarChar ( 10 ),  
		@sMdPasse 	VarChar ( 10 ), 
		@sSmsBody	VarChar(255),
		@sCodeTrt	Varchar(10),
		@sBase		Varchar(20),
		@sNumTelProd	Varchar(20),
		@dcIdProd 	Decimal(7,0),
		@iIdProd	integer,
		@sLibProd	Varchar(60),
		@iIdSin 	integer,
		@iIdEts 	integer,
		@dcIdEts	Decimal(7,0),
		@sBoiteMail   VarChar (35),
		@sMailFrom	VarChar (128), 
		@sMailSend	VarChar (128), 
		@sMailCc	VarChar (128),
		@sMailObjet	VarChar ( 255 ),
		@sMailBody	VarChar ( 7000 ),
		@sSaut	VarChar (10), 
		@sCasRetour	Varchar(255),
		@sTypeApp	Varchar(255),
		@sVal   VarChar ( 255 ),
		@iOptionDP Integer,
		@sNumProd     VarChar (20), 
		@sCiv		VarChar (100), 
		@sNom		VarChar (50),
		@sAltQuarant  VarChar (1),
		@sAltSuiviSMS VarChar ( 1 ),
		@sNumGsmSMS   VarChar ( 20 ),
		@iOrangeV3 Integer,
		@sMarque VarChar ( 35 ), 
		@sModele VarChar ( 35 ),
		@sMailAasRetour VarChar ( 128 ),
		@dcIdGti Decimal ( 7 ),
		@asCasRetour varchar ( 50 )

  Declare @sTypApp	Varchar ( 35 )
  Declare @sMarqApp Varchar ( 35 )
  Declare @sModlApp Varchar ( 35 )
  Declare @sImei	Varchar ( 35 )
  Declare @sGti		Varchar ( 35 )
  Declare @sPrenom	varchar ( 35 )
  Declare @sAdresse	varchar ( 500 )
  Declare @sAdrCp	varchar ( 35 )
  Declare @sMtPec   varchar ( 35 )
  Declare @sNumTel  Varchar ( 35 )
  Declare @iDernIdentity Integer

  	Set @iRet=0
	Set @sBase = DB_NAME ()
	Set @sMailFrom = 'noreply@spb.eu'
	Set @sMailCc = ''
	Set @sSaut = Char (10)
  	  -- Option de déclenchement du mail -DP
	Set @iOptionDP = 333 

  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@sBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT,  
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #3
	@sAltSuiviSMS OUTPUT, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #5 [FNAC_PROD_ECH_TECH].[SMS]

  If @iRet = -7 Set @iRet = 0

  -- Cas de retour n'étant pas des erreurs
  If @iRet in ( -9, -10 )
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End


  -- Problème suite éxécution
  If @iRet <> 0 Return @iRet

	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )
	
	-- Gestion de la civilité "Madame, Monsieur"
	If @sNom <> ''
	Begin
		Set @sCiv = @sCiv + ' ' + @sNom 
	End 
	
	Set @sMailObjet = 'Mail Commande de remplacement CARMA envoyé par WS SAGA2 - Dossier n°' + Convert ( VarChar, @adcIdSin ) + ' / ' + @sCiv + ' - ' + @sLibProd + ' / ' + sysadm.FN_CODE_CAR ( 'CMA', '-FR' )
	
	Set @sMailBody  = 'Ce mail n''est pas stocké sur KSL, ni parti avec KSL, Cette ligne est ici juste pour mémoire et pour indiquer que ce mail est parti par un autre système, il est parti avec le WS SAGA2 appelé directement à partir de SIMPA2.' + @sSaut
	Set @sMailBody  = @sMailBody + 'Ce présent mail technique n''est par envoyé à l''assuré en production, il est juste envoyé en Recette.' + @sSaut
	Set @sMailBody  = @sMailBody + @sSaut
			
	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	Begin  -- TRACE_MAIL_PRO : Début écriture

		Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'CWSSG2',
			2 		

		-- Problème suite éxécution
		If @iRet <> 0 Return -20
			
		Set @iRet=1

		Select @iDernIdentity = max ( id_seq ) 
		From   TRACE_MAIL_PRO.sysadm.mail_push
		Where  id_sin = @iIdSin
		And    typ_mail = 'CWSSG2'

		Update TRACE_MAIL_PRO.sysadm.mail_push
		Set    mail_dte_trt = Getdate(),
			   mail_trt_ok = 'O'
		Where  id_seq = @iDernIdentity



	End    -- TRACE_MAIL_PRO : Fin écriture
	Else
	Begin  -- TRACE_MAIL_TRT : Début écriture

		Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'CWSSG2',
			2 	

		-- Problème suite éxécution
		If @iRet <> 0 Return -20
		
		Set @iRet=1

		Select @iDernIdentity = max ( id_seq ) 
		From   TRACE_MAIL_TRT.sysadm.mail_push
		Where  id_sin = @iIdSin
		And    typ_mail = 'CWSSG2'

		Update TRACE_MAIL_TRT.sysadm.mail_push
		Set    mail_dte_trt = Getdate(),
			   mail_trt_ok = 'O'
		Where  id_seq = @iDernIdentity


	End    -- TRACE_MAIL_TRT : Fin écriture

	Return @iRet
Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_MAILPUSH_DT361_INFO_REGL
-- Auteur               :       JFF
-- Date                 :       21/08/2019
-- Libelle              :		[DT361-1]
-- Commentaires         :       
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MAILPUSH_DT361_INFO_REGL' AND type = 'P' )
        DROP procedure sysadm.PS_S_MAILPUSH_DT361_INFO_REGL
GO

CREATE procedure sysadm.PS_S_MAILPUSH_DT361_INFO_REGL
  @adcIdSin	Decimal (10,0), -- [PI062]--  Le numéro du sinistre
  @adcIdReg	Decimal (2,0),
  @sCodModeReg    Varchar (  2   ),
  @dcMtAReg       Decimal ( 11,2 ),
  @asCasRetour VarChar ( 50 ) OUTPUT
As

	Declare  @nb 	Integer,
		@sNumSmsPort Varchar(25),
		@sAdrMail Varchar(120),
		@iRet	Integer,
		@sLogin 	VarChar ( 10 ),  
		@sMdPasse 	VarChar ( 10 ), 
		@sSmsBody	VarChar(255),
		@sCodeTrt	Varchar(10),
		@sBase		Varchar(20),
		@sNumTelProd	Varchar(20),
		@dcIdProd 	Decimal(7,0),
		@iIdProd	integer,
		@sLibProd	Varchar(60),
		@iIdSin 	integer,
		@iIdEts 	integer,
		@dcIdEts	Decimal(7,0),
		@sBoiteMail   VarChar (35),
		@sMailFrom	VarChar (128), 
		@sMailSend	VarChar (128), 
		@sMailCc	VarChar (128),
		@sMailObjet	VarChar ( 255 ),
		@sMailBody	VarChar ( 7000 ),
		@sSaut	VarChar (10), 
		@sCasRetour	Varchar(255),
		@sTypeApp	Varchar(255),
		@sVal   VarChar ( 255 ),
		@iOptionDP Integer,
		@sNumProd     VarChar (20), 
		@sCiv		VarChar (100), 
		@sNom		VarChar (50),
		@sAltQuarant  VarChar (1),
		@sAltSuiviSMS VarChar ( 1 ),
		@sNumGsmSMS   VarChar ( 20 ),
		@iOrangeV3 Integer,
		@sMarque VarChar ( 35 ), 
		@sModele VarChar ( 35 ),
		@sNumCertificat VarChar ( 35 ),
		@sLibGti VarChar ( 35 ),
		@sPrenom VarChar ( 35 ),
		@sNom2 VarChar ( 35 ),
		@sAdr1 VarChar ( 35 ),
		@sAdr2 VarChar ( 35 ),
		@sAdrCP VarChar ( 35 ),
		@sAdrVille VarChar ( 35 ),
		@sMarqPortSin VarChar ( 35 ),
		@sModlPortSin VarChar ( 35 ),
		@sIMEIport VarChar ( 35 )

  -- [PM103][1]	
  If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
   Begin
	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
	Return 0
   End
  -- :[PM103][1]

  	Set @iRet=0
	Set @sBase = DB_NAME()
	Set @sMailFrom = 'noreply@spb.eu'
	Set @sMailCc = ''
	Set @sSaut = Char (10)
  	  -- Option de déclenchement du mail -DP
	Set @iOptionDP = 48 -- Je m'appuie volontairement sur la 48 pour éviter de recréer un nouvelle option

  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@sBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT,  
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #3
	@sAltSuiviSMS OUTPUT, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #5 [FNAC_PROD_ECH_TECH].[SMS]

  If @iRet = -7 
    Begin
		Set @asCasRetour = 'ADRESSE_MAIL_ABSENTE'
		Return 0
	End

  -- Cas de retour n'étant pas des erreurs
  If @iRet in ( -9, -10 )
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

  -- Problème suite éxécution
  If @iRet <> 0 Return @iRet

	Select Top 1
		   @sNumCertificat = IsNull ( ltrim ( rtrim ( ws.id_contrat_abonne ) ), '' ) ,
		   @sLibGti = 
			  Case wrg.id_gti
			    When 11 Then 'Dommages'
			    When 24 Then 'Oxydation'
			  Else 'Dommages'
		   End,
		   @sPrenom = IsNull ( ltrim ( rtrim ( ws.prenom ) ), '' ),
		   @sNom2 = IsNull ( ltrim ( rtrim ( ws.nom ) ), '' ),
		   @sAdr1 = IsNull ( ltrim ( rtrim ( ws.adr_1) ), '' ),
		   @sAdr2 = IsNull ( ltrim ( rtrim ( ws.adr_2) ), '' ),
		   @sAdrCP = IsNull ( ltrim ( rtrim ( ws.adr_cp) ), '' ),
		   @sAdrVille = IsNull ( ltrim ( rtrim ( ws.adr_ville ) ), '' ),
		   @sMarqPortSin = IsNull ( ltrim ( rtrim ( ws.marq_port ) ), '' ),
		   @sModlPortSin = IsNull ( ltrim ( rtrim ( ws.modl_port ) ), '' ),
		   @sIMEIport = IsNull ( ltrim ( rtrim ( ws.num_imei_port ) ), '' )
	From   sysadm.w_sin ws,
		   sysadm.w_reg_gti wrg
	Where  ws.id_sin = @adcIdSin
	And    wrg.id_sin = ws.id_sin

	-- Modification du MailSend
	Select @sMailSend = sysadm.FN_CLE_VAL ( 'ADR_MAIL_INFO_PEC', rtrim ( val_car ) , ';' ) 
	From sysadm.det_pro dp
	Where dp.id_prod = @dcIdProd
	And   dp.id_code_dp = 294

	If @sLibGti is null Set @sLibGti = 'Dommages' -- Défaut

	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )

	Set @sMailObjet = 'Dossier n°' + Convert ( VarChar, @adcIdSin ) + ' - ' + @sLibProd + ' - '
	Set @sMailObjet = @sMailObjet  + @sCiv + ' ' + @sNom + ' - n° certificat ' + @sNumCertificat

	Set @sMailBody  = ''
	Set @sMailBody  = @sMailBody  + 'Bonjour,'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut

	-- Modif mail Mantis 24707
	Set @sMailBody = @sMailBody + 'Dans le cadre de la garantie SAMSUNG - ' + @sLibGti + ' Smartphone & Tablette, nous vous informons que nous procédons à une indemnisation financière dans la limite du plafond d''indemnisation prévu au contrat en règlement du sinistre pour le dossier suivant :' + @sSaut
	Set @sMailBody = @sMailBody + @sSaut
	Set @sMailBody = @sMailBody + 'Dossier n°' + Convert ( VarChar, @adcIdSin ) + @sSaut
	Set @sMailBody = @sMailBody + 'N° de certificat SAMSUNG : ' + @sNumCertificat + @sSaut
	Set @sMailBody = @sMailBody + 'Civilité : ' + @sCiv + @sSaut
	Set @sMailBody = @sMailBody + 'Nom : ' + @sNom2 + @sSaut
	Set @sMailBody = @sMailBody + 'Prénom : ' + @sPrenom + @sSaut
	Set @sMailBody = @sMailBody + 'Adresse postale : ' + @sAdr1 + @sAdr2 + @sSaut
	Set @sMailBody = @sMailBody + 'Code postal : ' + @sAdrCP + @sSaut
	Set @sMailBody = @sMailBody + 'Ville : ' + @sAdrVille + @sSaut
	Set @sMailBody = @sMailBody + 'Marque appareil sinistré : ' + @sMarqPortSin + @sSaut
	Set @sMailBody = @sMailBody + 'Modèle appareil sinistré : ' + @sModlPortSin + @sSaut
	Set @sMailBody = @sMailBody + 'N° IMEI/Série appareil sinistré : ' + @sIMEIport + @sSaut
	Set @sMailBody = @sMailBody + 'Montant d''indemnisation : ' + Convert ( varchar, Convert ( money, @dcMtAReg ) ) + ' Euros' + @sSaut
	Set @sMailBody = @sMailBody + @sSaut
	Set @sMailBody = @sMailBody + @sSaut
	Set @sMailBody = @sMailBody  + 'Sincères salutations.' + @sSaut
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + 'SPB - ' + sysadm.FN_LIB_PROD_ASS ( @dcIdProd )  + @sSaut  
	Set @sMailBody = @sMailBody  + 'CS 90000' + @sSaut
	Set @sMailBody = @sMailBody  + '76095 Le Havre Cedex' + @sSaut
	Set @sMailBody = @sMailBody  + 'Tel : ' + @sNumProd + @sSaut 
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + '****************************************************************'
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL'
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + '****************************************************************'
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'
		
	
		
	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	Begin  -- TRACE_MAIL_PRO : Début écriture

		Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'INFRGL',
			2 		

		-- Problème suite éxécution
		If @iRet <> 0 Return -20
			
		Set @iRet=1
	End    -- TRACE_MAIL_PRO : Fin écriture
	Else
	Begin  -- TRACE_MAIL_TRT : Début écriture

		Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'INFRGL',
			2 	

	End    -- TRACE_MAIL_TRT : Fin écriture

	-- Problème suite éxécution
	If @iRet <> 0 Return -20

	Set @iRet=1
	
	Return @iRet
Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_S_MAILPUSH_DT361_INFO_REMPL
-- Auteur               :       JFF
-- Date                 :       21/08/2019
-- Libelle              :		[DT361-1]
-- Commentaires         :       
--
-- References           :
--
-- Arguments            :       Exec sysadm.PS_S_MAILPUSH_DT361_INFO_REMPL @dcIdSin, @aiIdSeq, @sMarque, @sModele, @sNumImeiNouv, @sCasRetour OUTPUT
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_MAILPUSH_DT361_INFO_REMPL' AND type = 'P' )
        DROP procedure sysadm.PS_S_MAILPUSH_DT361_INFO_REMPL
GO

CREATE procedure sysadm.PS_S_MAILPUSH_DT361_INFO_REMPL
  @adcIdSin	Decimal (10,0), -- [PI062]--  Le numéro du sinistre
  @aiIdSeq	Integer,
  @asMarqueRempl Varchar ( 35 ),
  @asModeleRempl Varchar ( 35 ),
  @asNumImeiNouvRempl Varchar ( 35 ),
  @asCasRetour VarChar ( 50 ) OUTPUT
As

	Declare  @nb 	Integer,
		@sNumSmsPort Varchar(25),
		@sAdrMail Varchar(120),
		@iRet	Integer,
		@sLogin 	VarChar ( 10 ),  
		@sMdPasse 	VarChar ( 10 ), 
		@sSmsBody	VarChar(255),
		@sCodeTrt	Varchar(10),
		@sBase		Varchar(20),
		@sNumTelProd	Varchar(20),
		@dcIdProd 	Decimal(7,0),
		@iIdProd	integer,
		@sLibProd	Varchar(60),
		@iIdSin 	integer,
		@iIdEts 	integer,
		@dcIdEts	Decimal(7,0),
		@sBoiteMail   VarChar (35),
		@sMailFrom	VarChar (128), 
		@sMailSend	VarChar (128), 
		@sMailCc	VarChar (128),
		@sMailObjet	VarChar ( 255 ),
		@sMailBody	VarChar ( 7000 ),
		@sSaut	VarChar (10), 
		@sCasRetour	Varchar(255),
		@sTypeApp	Varchar(255),
		@sVal   VarChar ( 255 ),
		@iOptionDP Integer,
		@sNumProd     VarChar (20), 
		@sCiv		VarChar (100), 
		@sNom		VarChar (50),
		@sAltQuarant  VarChar (1),
		@sAltSuiviSMS VarChar ( 1 ),
		@sNumGsmSMS   VarChar ( 20 ),
		@iOrangeV3 Integer,
		@sMarque VarChar ( 35 ), 
		@sModele VarChar ( 35 ),
		@sNumCertificat VarChar ( 35 ),
		@sLibGti VarChar ( 35 ),
		@sPrenom VarChar ( 35 ),
		@sNom2 VarChar ( 35 ),
		@sAdr1 VarChar ( 35 ),
		@sAdr2 VarChar ( 35 ),
		@sAdrCP VarChar ( 35 ),
		@sAdrVille VarChar ( 35 ),
		@sMarqPortSin VarChar ( 35 ),
		@sModlPortSin VarChar ( 35 ),
		@sIMEIport VarChar ( 35 )

  -- [PM103][1]	
  If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
   Begin
	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
	Return 0
   End
  -- :[PM103][1]

    -- Pour les fournisseurs qui remette la marque dans leur modele, on vire la marque du modèle
    Set @asModeleRempl = Replace ( @asModeleRempl, @asMarqueRempl, '' ) 

  	Set @iRet=0
	Set @sBase = DB_NAME()
	Set @sMailFrom = 'noreply@spb.eu'
	Set @sMailCc = ''
	Set @sSaut = Char (10)
  	  -- Option de déclenchement du mail -DP
	Set @iOptionDP = 48 -- Je m'appuie volontairement sur la 48 pour éviter de recréer un nouvelle option

  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@sBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT,  
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #3
	@sAltSuiviSMS OUTPUT, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #5 [FNAC_PROD_ECH_TECH].[SMS]

  If @iRet = -7 
    Begin
		Set @asCasRetour = 'ADRESSE_MAIL_ABSENTE'
		Return 0
	End

  -- Cas de retour n'étant pas des erreurs
  If @iRet in ( -9, -10 )
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

  -- Problème suite éxécution
  If @iRet <> 0 Return @iRet

	Select Top 1
		   @sNumCertificat = IsNull ( ltrim ( rtrim ( ws.id_contrat_abonne ) ), '' ) ,
		   @sLibGti = 
			  Case wc.id_gti
			    When 11 Then 'Dommages'
			    When 24 Then 'Oxydation'
			  Else 'Dommages'
		   End,
		   @sPrenom = IsNull ( ltrim ( rtrim ( ws.prenom ) ), '' ),
		   @sNom2 = IsNull ( ltrim ( rtrim ( ws.nom ) ), '' ),
		   @sAdr1 = IsNull ( ltrim ( rtrim ( ws.adr_1) ), '' ),
		   @sAdr2 = IsNull ( ltrim ( rtrim ( ws.adr_2) ), '' ),
		   @sAdrCP = IsNull ( ltrim ( rtrim ( ws.adr_cp) ), '' ),
		   @sAdrVille = IsNull ( ltrim ( rtrim ( ws.adr_ville ) ), '' ),
		   @sMarqPortSin = IsNull ( ltrim ( rtrim ( ws.marq_port ) ), '' ),
		   @sModlPortSin = IsNull ( ltrim ( rtrim ( ws.modl_port ) ), '' ),
		   @sIMEIport = IsNull ( ltrim ( rtrim ( ws.num_imei_port ) ), '' )
	From   sysadm.w_sin ws,
		   sysadm.w_commande wc
			
	Where  ws.id_sin = @adcIdSin
	And    wc.id_sin = ws.id_sin
	And    wc.id_seq = @aiIdSeq

	-- Modification du MailSend
	Select @sMailSend = sysadm.FN_CLE_VAL ( 'ADR_MAIL_INFO_PEC', rtrim ( val_car ) , ';' ) 
	From sysadm.det_pro dp
	Where dp.id_prod = @dcIdProd
	And   dp.id_code_dp = 294

	If @sLibGti is null Set @sLibGti = 'Dommages' -- Défaut

	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )


	Set @sMailObjet = 'Dossier n°' + Convert ( VarChar, @adcIdSin ) + ' - ' + @sLibProd + ' - '
	Set @sMailObjet = @sMailObjet  + @sCiv + ' ' + @sNom + ' - n° certificat ' + @sNumCertificat

	Set @sMailBody  = ''
	Set @sMailBody  = @sMailBody  + 'Bonjour,'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut

	-- Modif mail Mantis 24707
	Set @sMailBody = @sMailBody + 'Dans le cadre de la garantie SAMSUNG - ' + @sLibGti + ' Smartphone & Tablette, nous vous informons que nous procédons à l''envoi d’un appareil de remplacement en règlement du sinistre pour le dossier suivant :' + @sSaut
	Set @sMailBody = @sMailBody + @sSaut
	Set @sMailBody = @sMailBody + 'Dossier n°' + Convert ( VarChar, @adcIdSin ) + @sSaut
	Set @sMailBody = @sMailBody + 'N° de certificat SAMSUNG : ' + @sNumCertificat + @sSaut
	Set @sMailBody = @sMailBody + 'Civilité : ' + @sCiv + @sSaut
	Set @sMailBody = @sMailBody + 'Nom : ' + @sNom2 + @sSaut
	Set @sMailBody = @sMailBody + 'Prénom : ' + @sPrenom + @sSaut
	Set @sMailBody = @sMailBody + 'Adresse postale : ' + @sAdr1 + @sAdr2 + @sSaut
	Set @sMailBody = @sMailBody + 'Code postal : ' + @sAdrCP + @sSaut
	Set @sMailBody = @sMailBody + 'Ville : ' + @sAdrVille + @sSaut
	Set @sMailBody = @sMailBody + 'Marque appareil sinistré : ' + @sMarqPortSin + @sSaut
	Set @sMailBody = @sMailBody + 'Modèle appareil sinistré : ' + @sModlPortSin + @sSaut
	Set @sMailBody = @sMailBody + 'N° IMEI/Série appareil sinistré : ' + @sIMEIport + @sSaut
	Set @sMailBody = @sMailBody + 'Marque appareil de remplacement : ' + @asMarqueRempl + @sSaut
	Set @sMailBody = @sMailBody + 'Modèle appareil de remplacement : ' + @asModeleRempl + @sSaut
	Set @sMailBody = @sMailBody + 'N° IMEI/Série appareil de remplacement : ' + @asNumImeiNouvRempl + @sSaut
	Set @sMailBody = @sMailBody + @sSaut
	Set @sMailBody = @sMailBody + @sSaut
	Set @sMailBody = @sMailBody  + 'Sincères salutations.' + @sSaut
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + 'SPB - ' + sysadm.FN_LIB_PROD_ASS ( @dcIdProd )  + @sSaut  
	Set @sMailBody = @sMailBody  + 'CS 90000' + @sSaut
	Set @sMailBody = @sMailBody  + '76095 Le Havre Cedex' + @sSaut
	Set @sMailBody = @sMailBody  + 'Tel : ' + @sNumProd + @sSaut 
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + '****************************************************************'
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL'
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + '****************************************************************'
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'
		
	
		
	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	Begin  -- TRACE_MAIL_PRO : Début écriture

		Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'SAMRMP',
			2 		

		-- Problème suite éxécution
		If @iRet <> 0 Return -20
			
		Set @iRet=1
	End    -- TRACE_MAIL_PRO : Fin écriture
	Else
	Begin  -- TRACE_MAIL_TRT : Début écriture

		Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'SAMRMP',
			2 	

	End    -- TRACE_MAIL_TRT : Fin écriture

	-- Problème suite éxécution
	If @iRet <> 0 Return -20

	Set @iRet=1
	
	Return @iRet
Go


--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_MAILPUSH_VDOC28556_BVI
-- Auteur               :       JFF
-- Date                 :       21/10/2019
-- Libelle              :		[VDOC28556]
-- Commentaires         :       
--
-- References           :
--
-- Arguments            :       
-- Retourne             :       
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_MAILPUSH_VDOC28556_BVI' AND type = 'P' )
        DROP procedure sysadm.PS_I_MAILPUSH_VDOC28556_BVI
GO

CREATE procedure sysadm.PS_I_MAILPUSH_VDOC28556_BVI
  @adcIdSin	Decimal (10,0), -- [PI062]--  Le numéro du sinistre
  @sQualifcationIrrep VarChar ( 50 ),
  @asCasRetour VarChar ( 50 ) OUTPUT
As

Declare @iRet	Integer,
		@sBase	Varchar(20),
		@sMailFrom	VarChar (128), 
		@sMailCc	VarChar (128),
		@sSaut	VarChar (10),
		@iOptionDP Integer,
		@dcIdProd 	Decimal(7,0),
		@sLibProd	Varchar(60),
		@sNumProd   VarChar (20), 
		@dcIdEts	Decimal(7,0),
		@sCiv		VarChar (100),
		@sNom		VarChar (50),
		@sMailSend	VarChar (128), 
		@sAltQuarant  VarChar (1),
		@sBoiteMail   VarChar (35),
		@sAltSuiviSMS VarChar ( 1 ),
		@sNumGsmSMS   VarChar ( 20 ),
		@sMarqPortSin VarChar ( 35 ),
		@sModlPortSin VarChar ( 35 ),
		@sDteDecl VarChar ( 10 ),
		@iIdSin 	integer,
		@iIdEts 	integer,
		@sMailObjet	VarChar ( 255 ),
		@sMailBody	VarChar ( 7000 ),
		@iIdProd	integer


  -- Ticket 143300 suite incident mail à tort sur un [BRIS] (ça aurait pu être sur un [BNV] etc...).
  If @sQualifcationIrrep Not In ( '[BVIE]', '[BVIEOX]', '[PIE]', '[BVID]', '[BVIP]', '[BVIT]' ) Return

  -- [PM103][1]	
  If Exists ( Select * From sysadm.w_div_sin wd where wd.id_sin = @adcIdSin and wd.nom_zone = 'zn_tmp_PM103_1' and wd.val_car = 'O' )
   Begin
	Set @asCasRetour = 'CAS_DE_REPRISE_DE_BASE_MANUELLE'
	Return 0
   End
  -- :[PM103][1]

  	Set @iRet=0
	Set @sBase = DB_NAME()
	Set @sMailFrom = 'noreply@spb.eu'
	Set @sMailCc = ''
	Set @sSaut = Char (10)
  	  -- Option de déclenchement du mail -DP
	Set @iOptionDP = 48 -- Je m'appuie volontairement sur la 48 pour éviter de recréer un nouvelle option

  -- Récupération des données standard nécessaires à l'envoi du mail
  Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL 
	@adcIdSin,
	@sBase,
 	@iOptionDP,
	@dcIdProd   OUTPUT, 
	@sLibProd   OUTPUT, 
	@sNumProd   OUTPUT,   
	@dcIdEts    OUTPUT, 
	@sCiv	    OUTPUT, 
	@sNom	    OUTPUT, 
    @sMailFrom  OUTPUT, 
	@sMailSend  OUTPUT,  
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT, -- #3
	@sAltSuiviSMS OUTPUT, -- #5 [FNAC_PROD_ECH_TECH].[SMS]
	@sNumGsmSMS  OUTPUT -- #5 [FNAC_PROD_ECH_TECH].[SMS]

  If @iRet = -7 
    Begin
		Set @asCasRetour = 'ADRESSE_MAIL_ABSENTE'
		Return 0
	End

  -- Cas de retour n'étant pas des erreurs
  If @iRet in ( -9, -10 )
   Begin
	Select @asCasRetour =
	Case @iRet
		When -9 Then 'OPTION_DP_NON_PARAM'
		When -10 Then 'BASE_NON_PRO_SUR_SERVEUR_PRO'
	End 
	Return 0
   End

  -- Problème suite éxécution
  If @iRet <> 0 Return @iRet

	If Exists ( Select Top 1 1 From sysadm.w_sin where id_sin = @adcIdSin ) 
	  Begin 
		Select Top 1
			   @sMarqPortSin = IsNull ( ltrim ( rtrim ( ws.marq_port ) ), '' ),
			   @sModlPortSin = IsNull ( ltrim ( rtrim ( ws.modl_port ) ), '' ),
			   @sDteDecl     = sysadm.FN_AFF_DATE ( ws.dte_decl, 'SH' )
		From   sysadm.w_sin ws
		Where  ws.id_sin = @adcIdSin
	  End 
	Else
	  Begin 
		Select Top 1
			   @sMarqPortSin = IsNull ( ltrim ( rtrim ( s.marq_port ) ), '' ),
			   @sModlPortSin = IsNull ( ltrim ( rtrim ( s.modl_port ) ), '' ),
			   @sDteDecl     = sysadm.FN_AFF_DATE ( s.dte_decl, 'SH' )
		From   sysadm.sinistre s
		Where  s.id_sin = @adcIdSin
	  End 

	-- On convertit pour l'appel de la PS
	Set @iIdSin  = Convert ( integer, @adcIdSin )
	Set @iIdProd = Convert ( integer, @dcIdProd )
	Set @iIdEts  = Convert ( integer, @dcIdEts )


	Set @sMailObjet = 'Dossier n°' + Convert ( VarChar, @adcIdSin ) + ' - ' + @sLibProd + ' - '
	Set @sMailObjet = @sMailObjet  + @sCiv + ' ' + @sNom 

	Set @sMailBody  = ''
	Set @sMailBody  = @sMailBody  + 'Bonjour,'
	Set @sMailBody  = @sMailBody  + @sSaut
	Set @sMailBody  = @sMailBody  + @sSaut

	Set @sMailBody = @sMailBody + 'Nous faisons suite à votre déclaration de sinistre du ' + @sDteDecl + '. Après diagnostic, nous vous informons que votre appareil ' + @sMarqPortSin + ' ' + @sModlPortSin + ' est '
	Set @sMailBody = @sMailBody + Case 
										When @sQualifcationIrrep In ( '[BVIE]', '[BVIEOX]', '[PIE]' ) Then 'économiquement'
										When @sQualifcationIrrep In ( '[BVID]', '[BVIP]', '[BVIT]' ) Then 'techniquement'
										Else 'techniquement'
								  End 
	Set @sMailBody = @sMailBody + ' irréparable.'
	Set @sMailBody = @sMailBody + @sSaut
	Set @sMailBody = @sMailBody + @sSaut
	Set @sMailBody = @sMailBody + 'Vous recevrez rapidement un message, vous informant de la suite qui sera donnée à ce sinistre : échange ou indemnisation en euros, selon votre contrat.' + @sSaut
	Set @sMailBody = @sMailBody + 'Nous nous permettons de vous rappeler que, conformément aux conditions contractuelles, l''appareil sinistré devient la propriété de l''assureur et ne pourra plus vous être restitué.'+ @sSaut
	Set @sMailBody = @sMailBody + @sSaut
	Set @sMailBody = @sMailBody  + 'Sincères salutations.' 
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + 'SPB - ' + sysadm.FN_LIB_PROD_ASS ( @dcIdProd )  + @sSaut  
	Set @sMailBody = @sMailBody  + 'CS 90000' + @sSaut
	Set @sMailBody = @sMailBody  + '76095 Le Havre Cedex' + @sSaut
	Set @sMailBody = @sMailBody  + 'Tel : ' + @sNumProd + @sSaut 
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + '****************************************************************'
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + 'AVERTISSEMENT : NE PAS REPONDRE A CE MAIL'
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + '****************************************************************'
	Set @sMailBody = @sMailBody  + @sSaut
	Set @sMailBody = @sMailBody  + 'Cet e-mail étant généré de façon automatique, nous vous remercions de ne pas utiliser l''adresse d''origine pour nous contacter, votre message ne pouvant être traité en retour.'

		
	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	Begin  -- TRACE_MAIL_PRO : Début écriture

		Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'SAMRMP',
			2 		

		-- Problème suite éxécution
		If @iRet <> 0 Return -20
			
		Set @iRet=1
	End    -- TRACE_MAIL_PRO : Fin écriture
	Else
	Begin  -- TRACE_MAIL_TRT : Début écriture

		Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_I01_MAIL_PUSH_V00 
			'SIMPA2',
			@iIdSin, 
			@iIdProd, 
			@sLibProd, 
			@iIdEts, 
			@sMailFrom, 
			@sMailSend, 
			@sMailCc,
			@sMailObjet,
			@sMailBody,
			'N',
			@sBoiteMail, 
			'SAMRMP',
			2 	

	End    -- TRACE_MAIL_TRT : Fin écriture

Go

--------------------------------------------------------------------
--
-- Proc‚dure            :       PS_I_RS5045_MAIL_COUR_CARTE_CADEAU_ELD_KSL
-- Auteur               :       Fabry JF
-- Date                 :       25/04/2023
-- Libelle              :		RS5045
-- Commentaires         :       
--
-- References           :
--
--------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
--------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_RS5045_MAIL_COUR_CARTE_CADEAU_ELD_KSL' AND type = 'P' )
        DROP procedure sysadm.PS_I_RS5045_MAIL_COUR_CARTE_CADEAU_ELD_KSL
GO

CREATE procedure sysadm.PS_I_RS5045_MAIL_COUR_CARTE_CADEAU_ELD_KSL
	@adcIdSin      	Decimal (10), -- [PI062]
	@aiIdSeq	integer
AS
  -- @asErrOutPut VarChar ( 255 ) Output
Declare @asErrOutPut VarChar ( 255 ) 

  Declare 
	@sSaut		VarChar (10), 
    @iRet		Integer,
	@sIdAppli	VarChar ( 6 ),
	@sTypApp 	VarChar ( 3 ),
	@iOptionDP  Integer,
	@sXMLVar    VarChar (max),
	@dcIdProd     Decimal (7), 
	@dcIdEts 	Decimal (7), 
    @iIdSin 	Integer,
	@sLibProd     VarChar (255), 
    @iIdProd 	Integer,
	@iIdEts 	Integer,
	@sAltQuarant  VarChar (1),
	@sNumProd     VarChar (20),   
	@dcIdInter  Decimal ( 2 ),
	@sTypMail   VarChar ( 6 ),
	@sCiv		VarChar (20), 
	@sCodeMaquette VarChar ( 255 ),
	@sNom		VarChar ( 71 ),
	@sRefIdem   VarChar ( 50 ),
	@sMailFrom	VarChar (128), 
	@sMailSend	VarChar (128), 
	@sMailCc	VarChar (128),
	@sMailObjet	VarChar ( 255 ),
	@sMailBody	VarChar ( 7000 ),
	@sBoiteMail   VarChar (35),
	@sCodeSecu  VarChar ( 10 ),
	@sNumCCELD VarChar ( 35 ),
	@sMtCC	   VarChar ( 20 ),
	@sIdSeq    VarChar ( 15 ),
	@iIdXml    Integer

Declare @sMess			VarChar ( 2000 ),
		@sErr			Varchar(60),
		@iIdCt			integer,	
		@iVal			integer, 
		@sAdrMailErr VarChar ( 150 )

Set @sSaut = Char (10)
Set @iRet = 0
Set @sIdAppli = 'SIMPA2'
Set @sTypApp = '' 
Set @iOptionDP = -1

Exec @iRet = sysadm.PS_S01_RECUP_DONNEES_MAIL_XML
	@adcIdSin,
	@iOptionDP,
	@dcIdProd   OUTPUT,
	@sLibProd   OUTPUT,
	@dcIdEts    OUTPUT,
	@sNumProd   OUTPUT,
	@sCiv	    OUTPUT,
	@sNom	    OUTPUT,
	@sMailFrom  OUTPUT,
	@sMailSend  OUTPUT,
	@sMailCc    OUTPUT,
	@sAltQuarant OUTPUT,
	@sBoiteMail  OUTPUT,
	@sXMLVar     OUTPUT

-- On néglige le sXMLVar retourné, on en construit un autre à la nouvelle méthode 5 [RS5045]
Set @sXMLVar = ''    

-- Armement du corps du mail 
Set @sMailObjet = 'Corps de l''Objet construit par KSL'
Set @sMailBody  = 'Corps du mail construit par KSL'

-- On convertit pour l'appel de la PS
Set @iIdSin  = Convert ( integer, @adcIdSin )
Set @iIdProd = Convert ( integer, @dcIdProd )
Set @iIdEts  = Convert ( integer, @dcIdEts )
Set @sAltQuarant = 'N'

Select @dcIdInter = id_i From sysadm.inter where id_sin = @adcIdSin and cod_inter = 'A'
If @dcIdInter is null Set @dcIdInter = 0 
Set @sTypMail = 'CC_ELD' -- (-TM) code_car sur TRACE_MAIL

Select @sMtCC = Convert ( VarChar ( 20), c.mt_ttc_cmde ), --  As montant_carte_cadeau,
		@sRefIdem = sysadm.FN_CLE_VAL ( 'REF_INDEM', rtrim(c.info_spb_frn_cplt), ';' ), -- As ref_indemnisation,
	   	@sNumCCELD = sysadm.FN_CLE_VAL ( 'NUM_CC_ELD', rtrim( c.info_spb_frn_cplt), ';' ), -- As code_chq_cadeau,
		@sCodeSecu = sysadm.FN_CLE_VAL ( 'CODE_SECURITE', rtrim( c.info_frn_spb_cplt), ';' ), -- As code_acces_securise, -- [RS4093_EVOL_ELD]
		@sIdSeq    = Convert ( VarChar ( 15 ), c.id_seq )
From sysadm.commande c
Where c.id_sin = @adcIdSin
And   c.id_seq = @aiIdSeq

If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	Begin
		-- Appel Obligatoire pour déclarer le XML
		Exec @iIdXml = TRACE_MAIL_PRO.sysadm.PS_RS5045_I_CREATION_CHAINE_DATA_XML_KSL_A_VIDE
		Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER @iIdSin, @dcIdInter, @iIdXml
		Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_OPTIMISER_CHAINE_DATA_XML_KSL @iIdXml, 'OUI', 'OUI', 'OUI'
		Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_S_RECUPERER_CODE_MAQUETTE_KSL_A_PARTIR_TYP_MAIL @sTypMail, @sCodeMaquette OutPut

		-- Ajout personnalisé du client appelant le système
		Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'code_maquette', @sCodeMaquette
		Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'montant_carte_cadeau', @sMtCC
		Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'ref_indemnisation', @sRefIdem
		Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'id_seq_cmde', sIdSeq
		Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'code_chq_cadeau', @sNumCCELD
		Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'code_acces_securise',@sCodeSecu

		-- Appel pour construire et récupérer le XML dans @xmlResult
		Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_I_CONSTRUCTION_CHAINE_XML_KSL_DEFINITIVE @iIdXml, @sCodeMaquette, @sXMLVar OUTPUT

		Exec @iRet = TRACE_MAIL_PRO.sysadm.PS_RS5045_I_MAIL_PUSH_KSL
			@sIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sMailFrom,
			@sMailSend,
			@sMailCc,
			null,
			@sMailObjet,
			@sMailBody,
			@sBoiteMail,
			@sTypMail,
			2,
			-1,
			@sXMLVar,
			null, -- id_chem, peut être forcé mais si null, sera pris par défaut sysadm.code_maquette_ksl_rs5045
			null, -- dteh_exec
			@asErrOutPut OutPut

	End    -- TRACE_MAIL_PRO : Fin écriture

Else
	Begin
		-- Appel Obligatoire pour déclarer le XML
		Exec @iIdXml = TRACE_MAIL_TRT.sysadm.PS_RS5045_I_CREATION_CHAINE_DATA_XML_KSL_A_VIDE
		Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER @iIdSin, @dcIdInter, @iIdXml
		Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_OPTIMISER_CHAINE_DATA_XML_KSL @iIdXml, 'OUI', 'OUI', 'OUI'
		Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_S_RECUPERER_CODE_MAQUETTE_KSL_A_PARTIR_TYP_MAIL @sTypMail, @sCodeMaquette OutPut

		-- Ajout personnalisé du client appelant le système
		Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'code_maquette', @sCodeMaquette
		Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'montant_carte_cadeau', @sMtCC
		Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'ref_indemnisation', @sRefIdem
		Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'id_seq_cmde', sIdSeq
		Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'code_chq_cadeau', @sNumCCELD
		Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'code_acces_securise',@sCodeSecu

		-- Appel pour construire et récupérer le XML dans @xmlResult
		Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_I_CONSTRUCTION_CHAINE_XML_KSL_DEFINITIVE @iIdXml, @sCodeMaquette, @sXMLVar OUTPUT

		Exec @iRet = TRACE_MAIL_TRT.sysadm.PS_RS5045_I_MAIL_PUSH_KSL
			@sIdAppli,
			@iIdSin,
			@iIdProd,
			@sLibProd,
			@iIdEts,
			@sMailFrom,
			@sMailSend,
			@sMailCc,
			null,
			@sMailObjet,
			@sMailBody,
			@sBoiteMail,
			@sTypMail,
			2,
			-1,
			@sXMLVar,
			null, -- id_chem, peut être forcé mais si null, sera pris par défaut sysadm.code_maquette_ksl_rs5045
			null, -- dteh_exec
			@asErrOutPut OutPut
	End	

	-- MAJ du dossier, à partir de ce moment pour moi je considère que le BA a été envoyé (ce qui n'est pas rééllement le cas)

If @iRet <> 0 
  Begin
	Return @iRet
  End 

Set @sMess = 'Courrier lié à la carte cadeau, envoyé '
	
Update	sysadm.commande
Set	    info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'DTE_BGE', CONVERT ( VarChar ( 10 ), getdate(), 103 ), RTRIM( c.info_spb_frn_cplt ), ';')
From	sysadm.commande c 
Where  	c.id_sin = @adcIdSin
And		c.id_seq = @aiIdSeq

Update	sysadm.w_commande
Set	    info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'DTE_BGE', CONVERT ( VarChar ( 10 ), getdate(), 103 ), RTRIM( c.info_spb_frn_cplt ), ';')
From	sysadm.w_commande c 
Where  	c.id_sin = @adcIdSin
And		c.id_seq = @aiIdSeq

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT
END
ELSE
BEGIN
	Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'', 300, @iIdCt OUTPUT
END


Go
