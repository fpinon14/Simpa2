-------------------------------------------------------------------
--
-- Fichier              :       PM357.CP
-- Auteur               :       Fabry JF
-- Date                 :       06/06/2017
--
-- Commentaires         :       
-- sysadm.PS_S_PM357_CREATION_SAV
-- sysadm.PS_S_PM357_CREATION_SAV_A_REP_GARANTIE
-- sysadm.PS_S_PM357_CREATION_SAV_REPA_ORIGINE
-- sysadm.PS_S_PM357_CTRLE_CONNEXION
-- sysadm.PS_S_PM357_LECTURE_POUR_CREATION_SAV
-- sysadm.PS_S_PM357_LECTURE_SAV_EXISTANT
-- sysadm.PS_S_PM357_MAJ_PARTIELLE
-------------------------------------------------------------------

--------------------------------------------------------------------
-- Procédure            :       PS_S_PM357_CTRLE_CONNEXION
-- Auteur               :       Fabry JF
-- Date                 :       09/06/2017
-- Libellé              :		[PM357]
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF	11/12/2017  [PM357-1][MANTIS27318]
-- JFF   15/12/2017   [PM357][MANTIS27369]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM357_CTRLE_CONNEXION' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM357_CTRLE_CONNEXION
GO

CREATE procedure sysadm.PS_S_PM357_CTRLE_CONNEXION
	@asdcIdSinOuSav	VarChar ( 20 ),
	@asNumLigne		VarChar ( 20 ),
	@asChaineBCV	VarChar ( 255 ) OUTPUT, -- armé toujours à 255 espaces.
	@asChaineRet	Varchar (255)  OUTPUT -- armé toujours à 255 espaces.
AS

Declare @iRet Integer 
Declare @dcIdSin Decimal ( 10 )
Declare @dcIdSav Decimal ( 10 )
Declare @sTemp VarChar ( 20 )
Declare @iIdSeqNumSav Integer
Declare @iARepGti Integer
Declare @iIdSeqRef Integer
Declare @dtDteEnvCliRef DateTime
Declare @iPeriodeSavEnMois Integer
Declare @iIdSeqSavEnCours Integer
Declare @iIdSeqDernSavFerme Integer
Declare @iAppelLect Integer
Declare @sAutoDiagPM357 VarChar ( 20 )
Declare @sMsgTemp VarChar ( 500 ) 
Declare @iIdCt Integer

Set @iAppelLect = 0
If sysadm.FN_CLE_VAL  ( 'APPEL_LECT', rtrim ( ltrim ( @asChaineBCV  )), ';') = 'OUI'
 Begin
	Set @iAppelLect = 1
 End 

Set @iRet = 10
Set @asChaineRet = ''
Set @dcIdSin = -1
Set @dcIdSav = -1
Set @iARepGti = 0
Set @iPeriodeSavEnMois = 12

Set @asdcIdSinOuSav = ltrim ( rtrim ( @asdcIdSinOuSav ))
Set @asNumLigne = ltrim ( rtrim ( @asNumLigne ))

-- Sinistre/n° Sav
If @asdcIdSinOuSav is null Or @asdcIdSinOuSav = ''
	Begin
		Set @iRet = -10
		Set @asChaineRet = 'Le N° de Sinistre ou de SAV doit être renseigné.'

		Return @iRet
	End	

If Len ( @asdcIdSinOuSav ) > 10 
		Begin
			Set @iRet = -11
			Set @asChaineRet = 'Le N° de Sinistre ou de SAV n''est pas valide (trop long).'
			Return @iRet
		End	

If IsNumeric ( @asdcIdSinOuSav ) = 1 Set @dcIdSin = Convert ( Decimal ( 10),  @asdcIdSinOuSav )
If IsNumeric ( @asdcIdSinOuSav ) = 0 
 Begin
	Set @sTemp = reverse ( @asdcIdSinOuSav ) 
	If Substring ( @sTemp, 4, 1 ) <> 'A'
		Begin
			Set @iRet = -12
			Set @asChaineRet = 'Le N° de SAV n''est pas valide.'
			Return @iRet
		End	

	Set @sTemp = Left( @sTemp, 3 ) + Substring ( @sTemp, 5, Len ( @sTemp ) ) 
	Set @asdcIdSinOuSav = reverse ( @sTemp ) 

	If IsNumeric ( @asdcIdSinOuSav ) = 0 
	 Begin
		Set @iRet = -13
		Set @asChaineRet = 'Le N° de SAV n''est pas valide (doit être alphanumérique).'
		Return @iRet
	 End 

	Set @sTemp = reverse ( @asdcIdSinOuSav ) 
	Set @dcIdSav = Convert ( Decimal ( 10),  @asdcIdSinOuSav )
 End

-- Num ligne
If @asNumLigne is null Or @asNumLigne = ''
	Begin
		Set @iRet = -20
		Set @asChaineRet = 'Le N° de ligne doit être renseigné.'
		Return @iRet
	End	

If Len ( @asNumLigne ) <> 10 
	Begin
		Set @iRet = -21
		Set @asChaineRet = 'Le N° de ligne n''est pas valide (doit contenir 10 chiffres).'
		Return @iRet
	End	

If IsNumeric ( @asNumLigne ) = 0 
	Begin
		Set @iRet = -22
		Set @asChaineRet = 'Le N° de ligne n''est pas valide (doit être numérique).'
		Return @iRet
	End	

If Left ( @asNumLigne, 2 ) Not in ( '06', '07' )
	Begin
		Set @iRet = -23
		Set @asChaineRet = 'Le N° de ligne doit commencer par 06 ou 07.'
		Return @iRet
	End	

-- Si SAV, je cherche l'id_sin
If @dcIdSav > 0 
	Begin
		Set @dcIdSin = Null
		Select	@dcIdSin = sf.id_sin,
				@iIdSeqNumSav = sf.id_seq
		From	sysadm.sav_frn sf
		Where   sf.id_sav = @dcIdSav

		If @dcIdSin is null 
			Begin
				Set @iRet = -30
				Set @asChaineRet = 'Le N° de SAV ne correspond à aucun N° de sinistre.'
				Return @iRet
			End	
	End 

-- Ctrle connexion id_sin/numligne.
If Not Exists ( 
		Select	Top 1 1
		From	sysadm.sinistre s
		Where   s.id_sin = @dcIdSin
		And     s.num_port = @asNumLigne
	)
	Begin
		Set @iRet = -40
		Set @asChaineRet = 'Aucun dossier n''a été trouvé ayant une correspondance entre N°Sinistre/N°Sav ET le numéro de ligne.'

		-- [PM357][MANTIS27369]
		Exec sysadm.PS_I_PM357_CREATION_CONTACT	@dcIdSin, @iRet, 42, @asChaineRet
		-- /[PM357][MANTIS27369]

		Return @iRet
	End	

-- Det_Pro Accès
If Not Exists ( 
		Select Top 1 1
		From	sysadm.det_pro dp,
				sysadm.sinistre s
		Where s.id_sin = @dcIdSin
		And   dp.id_prod = s.id_prod
		And   dp.id_code_dp = 318
	)
	Begin
		Set @iRet = -130
		Set @asChaineRet = 'Le produit de sinistre lié à ce dossier n''est pas éligible à une déclaration de SAV par le l''extranet SAV'

		-- [PM357][MANTIS27369]
		Exec sysadm.PS_I_PM357_CREATION_CONTACT	@dcIdSin, @iRet, 42, @asChaineRet
		-- /[PM357][MANTIS27369]

		Return @iRet
	End 


-- W_queue
If @iAppelLect = 0 And Exists ( Select Top 1 1 From sysadm.w_queue where id_sin = @dcIdSin ) 
  Begin
	Set @iRet = -35
	Set @asChaineRet = 'SPB est en train d''intervenir sur votre dossier, vous ne pouvez pas déclarer de SAV pour le moment.'

	-- [PM357][MANTIS27369]
	Exec sysadm.PS_I_PM357_CREATION_CONTACT	@dcIdSin, @iRet, 42, @asChaineRet
	-- /[PM357][MANTIS27369]

	Return @iRet				
  End 


-- SAV en cours, donc consultation uniquement
Select @iIdSeqSavEnCours = max ( c.id_seq ) 
From sysadm.commande c
Where c.id_sin = @dcIdSin
And   c.cod_etat not in ( 'RPC', 'RFO', 'ANN', 'RSP' )
And   ( sysadm.FN_CLE_VAL ( 'A_REP_GARANTIE', c.info_spb_frn_cplt, ';' ) = 'OUI'
		Or 
		sysadm.FN_CLE_VAL ( 'A_REPARER_SAV', c.info_spb_frn_cplt, ';' ) = 'OUI'
		Or 
		sysadm.FN_CLE_VAL ( 'A_DESOXYDER_SAV', c.info_spb_frn_cplt, ';' ) = 'OUI'
		Or 
		sysadm.FN_CLE_VAL ( 'A_CONTROLER_SAV', c.info_spb_frn_cplt, ';' ) = 'OUI'
		)

If @iIdSeqSavEnCours > 0
	Begin
		Set @iRet = -45
		Set @asChaineRet = 'Connexion valide pour consultation de sav en cours uniquement.'
		Set @asChaineBCV  = ''
		Set @asChaineBCV = sysadm.FN_CLE_VAL_E  ( 'ID_SIN', Convert ( Varchar, @dcIdSin ), rtrim ( ltrim ( @asChaineBCV )), ';')
		Set @asChaineBCV = sysadm.FN_CLE_VAL_E  ( 'ID_SEQ_SAV', Convert ( Varchar, @iIdSeqSavEnCours ), rtrim ( ltrim ( @asChaineBCV )), ';')

		-- [PM357][MANTIS27369]
		Exec sysadm.PS_I_PM357_CREATION_CONTACT	@dcIdSin, @iRet, 42, @asChaineRet
		-- /[PM357][MANTIS27369]

		Return @iRet
	End 

-- Cnx valide Lecture uniquement 
If @dcIdSav > 0 
	Begin
		Set @iRet = -47
		Set @asChaineRet = 'Connexion valide pour consultation de sav fermé uniquement.'
		Set @asChaineBCV = sysadm.FN_CLE_VAL_E  ( 'ID_SIN', Convert ( Varchar, @dcIdSin ), rtrim ( ltrim ( @asChaineBCV )), ';')
		Set @asChaineBCV = sysadm.FN_CLE_VAL_E  ( 'ID_SEQ_SAV', Convert ( Varchar, @iIdSeqNumSav ), rtrim ( ltrim ( @asChaineBCV )), ';')

		-- [PM357][MANTIS27369]
		Exec sysadm.PS_I_PM357_CREATION_CONTACT	@dcIdSin, @iRet, 42, @asChaineRet
		-- /[PM357][MANTIS27369]

		Return @iRet
	End 



-- Eligibilité DECLA.
-- Si Hors numéro SAV, décla possible si éligible.
-- [PM280] (pour browse)

-- Recherche d'un remplacement O2M en premier
If @iAppelLect = 0 
  Begin
	Select Top 1 
			@iIdSeqRef = c.id_seq,
			@dtDteEnvCliRef = c.dte_env_cli,
			@sAutoDiagPM357 = sysadm.FN_CLE_VAL ( 'AUTO_DIAG_PM357', c.info_spb_frn_cplt, ';')
	From sysadm.commande c
	Where c.id_sin = @dcIdSin
	And   c.id_four = 'O2M'
	And   c.status_gc <> 176
	And   c.cod_etat in ( 'RFO', 'RPC') 
	And	  sysadm.FN_A_COMMANDER ( c.id_sin, c.id_seq, 'P' ) = 'A_COMMANDER'
	And   c.id_seq = (  Select max ( id_seq ) 
						From sysadm.commande c1
						Where c1.id_sin = c.id_sin
						And   c1.id_four = c.id_four
						And   c1.status_gc <> 176
						And   c1.cod_etat in ( 'RFO', 'RPC') 
						And	  sysadm.FN_A_COMMANDER ( c1.id_sin, c1.id_seq, 'P' ) = 'A_COMMANDER'
						)

	If @iIdSeqRef > 0 
		Begin
			If DateAdd ( month, @iPeriodeSavEnMois, @dtDteEnvCliRef ) < GetDate() 
				Begin
					Set @iRet = -50
					Set @asChaineRet = 'SAV sur remplacement impossible, car le remplacement date de plus de ' + Convert ( varchar, @iPeriodeSavEnMois) + ' mois (' + convert ( VarChar, @dtDteEnvCliRef, 103 ) + ').'

					-- [PM357][MANTIS27369]
					Exec sysadm.PS_I_PM357_CREATION_CONTACT	@dcIdSin, @iRet, 42, @asChaineRet
					-- /[PM357][MANTIS27369]

					Return @iRet				
				End 

			Set @iARepGti = 1
			Set @iRet = 30 
			Set @asChaineRet = 'Eligible à une déclaration SAV sur l''appareil de remplacement fourni par SPB.'
			Exec @iRet = sysadm.PS_S_PM357_LECTURE_POUR_CREATION_SAV @dcIdSin, @iIdSeqRef, @dtDteEnvCliRef, @iRet OUTPUT, @asChaineRet OUTPUT
			Set @asChaineBCV = ''
			Set @asChaineBCV = sysadm.FN_CLE_VAL_E  ( 'ID_SIN', Convert ( Varchar, @dcIdSin ), rtrim ( ltrim ( @asChaineBCV  )), ';')
			Set @asChaineBCV = sysadm.FN_CLE_VAL_E  ( 'ID_SEQ_REF', Convert ( Varchar, @iIdSeqRef ), rtrim ( ltrim ( @asChaineBCV  )), ';')

			-- [PM357-1][MANTIS27318]
			Set @asChaineBCV = sysadm.FN_CLE_VAL_E  ( 'AUTO_DIAG_PM357', @sAutoDiagPM357, rtrim ( @asChaineBCV) , ';')

			-- [PM357][MANTIS27369]
			Exec sysadm.PS_I_PM357_CREATION_CONTACT	@dcIdSin, @iRet, 42, @asChaineRet
			-- /[PM357][MANTIS27369]

			Return @iRet
		End 
  End	
-- si pas ARepGti alors est-ce je trouve Des SAV possibles ?


If @iAppelLect = 0 
  Begin
	-- A_Controler_SAV Existant ?
	Select Top 1 
			@iIdSeqRef = c.id_seq,
			@dtDteEnvCliRef = c.dte_env_cli,
			@sAutoDiagPM357 = sysadm.FN_CLE_VAL ( 'AUTO_DIAG_PM357', c.info_spb_frn_cplt, ';')
	From sysadm.commande c
	Where c.id_sin = @dcIdSin
	And   c.id_typ_art = 'PRS'
	And	  c.id_four in ( 'O2M', 'PSM' ) -- Inclusion trt SAV  
	And   sysadm.FN_CLE_VAL ( 'A_CONTROLER_SAV', c.info_spb_frn_cplt, ';' ) = 'OUI'
	And   c.cod_etat in ( 'RPC', 'RFO' ) 
	And   c.id_seq = (  Select max ( id_seq ) 
						From sysadm.commande c1
						Where c1.id_sin = c.id_sin
						And   c1.id_four = c.id_four
						And   sysadm.FN_CLE_VAL ( 'A_CONTROLER_SAV', c1.info_spb_frn_cplt, ';' ) = 'OUI'
						And   c1.cod_etat = c.cod_etat
						)

	If @iIdSeqRef > 0 
		Begin
			Set @iRet = -60
			Set @asChaineRet = 'Déjà 2 SAV de créés sur ce dossier, impossible d''en déclarer un nouveau.'

			-- [PM357][MANTIS27369]
			Exec sysadm.PS_I_PM357_CREATION_CONTACT	@dcIdSin, @iRet, 42, @asChaineRet
			-- /[PM357][MANTIS27369]

			Return @iRet	
		End 


	-- A_Controler_SAV Possible ?
	Select Top 1 
			@iIdSeqRef = c.id_seq,
			@dtDteEnvCliRef = c.dte_env_cli,
			@sAutoDiagPM357 = sysadm.FN_CLE_VAL ( 'AUTO_DIAG_PM357', c.info_spb_frn_cplt, ';')
	From sysadm.commande c
	Where c.id_sin = @dcIdSin
	And   c.id_typ_art = 'PRS'
	And	  c.id_four in ( 'O2M', 'PSM' ) -- Inclusion trt SAV 
	And   c.cod_etat in ( 'RPC', 'RFO' ) 
	And   ( sysadm.FN_CLE_VAL ( 'A_DESOXYDER_SAV', c.info_spb_frn_cplt, ';' ) = 'OUI'
			Or 
			sysadm.FN_CLE_VAL ( 'A_REPARER_SAV', c.info_spb_frn_cplt, ';' ) = 'OUI'
		  )
	And   c.id_seq = (  Select max ( id_seq ) 
						From sysadm.commande c1
						Where c1.id_sin = c.id_sin
						And   c1.id_four = c.id_four
						And   c1.cod_etat = c.cod_etat
						And   ( sysadm.FN_CLE_VAL ( 'A_DESOXYDER_SAV', c1.info_spb_frn_cplt, ';' ) = 'OUI'
								Or 
								sysadm.FN_CLE_VAL ( 'A_REPARER_SAV', c1.info_spb_frn_cplt, ';' ) = 'OUI'
							  )
			 		)

	If @iIdSeqRef > 0 
		Begin
			If DateAdd ( month, @iPeriodeSavEnMois, @dtDteEnvCliRef ) < GetDate() 
				Begin
					Set @iRet = -65
					Set @asChaineRet = '2ème SAV impossible car la prestation du 1er SAV date de plus de ' + Convert ( varchar, @iPeriodeSavEnMois) + ' mois (' + convert ( VarChar, @dtDteEnvCliRef, 103 ) + ').'

					-- [PM357-1][MANTIS27318]
					Set @asChaineBCV = sysadm.FN_CLE_VAL_E  ( 'AUTO_DIAG_PM357', @sAutoDiagPM357, rtrim ( @asChaineBCV) , ';')

					-- [PM357][MANTIS27369]
					Exec sysadm.PS_I_PM357_CREATION_CONTACT	@dcIdSin, @iRet, 42, @asChaineRet
					-- /[PM357][MANTIS27369]

					Return @iRet				
				End 

			Set @iRet = 35 
			Set @asChaineRet = 'Eligible à une déclaration de 2ème SAV sur la prestation du 1er SAV.'
			Exec @iRet = sysadm.PS_S_PM357_LECTURE_POUR_CREATION_SAV @dcIdSin, @iIdSeqRef, @dtDteEnvCliRef, @iRet OUTPUT, @asChaineRet OUTPUT
			Set @asChaineBCV  = ''
			Set @asChaineBCV = sysadm.FN_CLE_VAL_E  ( 'ID_SIN', Convert ( Varchar, @dcIdSin ), rtrim ( ltrim ( @asChaineBCV  )), ';')
			Set @asChaineBCV = sysadm.FN_CLE_VAL_E  ( 'ID_SEQ_REF', Convert ( Varchar, @iIdSeqRef ), rtrim ( ltrim ( @asChaineBCV  )), ';')

			-- [PM357-1][MANTIS27318]
			Set @asChaineBCV = sysadm.FN_CLE_VAL_E  ( 'AUTO_DIAG_PM357', @sAutoDiagPM357, rtrim ( @asChaineBCV) , ';')

			-- [PM357][MANTIS27369]
			Exec sysadm.PS_I_PM357_CREATION_CONTACT	@dcIdSin, @iRet, 42, @asChaineRet
			-- /[PM357][MANTIS27369]

			Return @iRet
		End 

	-- A_desoxyder_SAV Possible ?
	Select Top 1 
			@iIdSeqRef = c.id_seq,
			@dtDteEnvCliRef = c.dte_env_cli,
			@sAutoDiagPM357 = sysadm.FN_CLE_VAL ( 'AUTO_DIAG_PM357', c.info_spb_frn_cplt, ';')
	From sysadm.commande c
	Where c.id_sin = @dcIdSin
	And   c.id_typ_art = 'PRS'
	And	  c.id_four in ( 'O2M', 'PSM' ) -- Inclusion trt SAV 
	And   c.cod_etat in ( 'RPC', 'RFO' ) 
	And   c.status_gc = 22 
	And   c.id_seq = (  Select max ( id_seq ) 
						From sysadm.commande c1
						Where c1.id_sin = c.id_sin
						And   c1.id_four = c.id_four
						And   c1.cod_etat = c.cod_etat
						And   c1.status_gc = 22 
						)

	If @iIdSeqRef > 0 
		Begin
			If DateAdd ( month, @iPeriodeSavEnMois, @dtDteEnvCliRef ) < GetDate() 
				Begin
					Set @iRet = -80
					Set @asChaineRet = 'SAV impossible car la prestation de désoxydation d''origine date de plus de ' + Convert ( varchar, @iPeriodeSavEnMois) + ' mois (' + convert ( VarChar, @dtDteEnvCliRef, 103 ) + ').'

					-- [PM357][MANTIS27369]
					Exec sysadm.PS_I_PM357_CREATION_CONTACT	@dcIdSin, @iRet, 42, @asChaineRet
					-- /[PM357][MANTIS27369]

					Return @iRet				
				End 

			Set @iRet = 40 
			Set @asChaineRet = 'Eligible à une déclaration SAV sur la prestation de désoxydation d''origine.'
			Exec @iRet = sysadm.PS_S_PM357_LECTURE_POUR_CREATION_SAV @dcIdSin, @iIdSeqRef, @dtDteEnvCliRef, @iRet OUTPUT, @asChaineRet OUTPUT
			Set @asChaineBCV  = ''
			Set @asChaineBCV  = sysadm.FN_CLE_VAL_E  ( 'ID_SEQ', Convert ( Varchar, @iIdSeqRef ), rtrim ( ltrim ( @asChaineBCV )), ';')

			-- [PM357-1][MANTIS27318]
			Set @asChaineBCV = sysadm.FN_CLE_VAL_E  ( 'AUTO_DIAG_PM357', @sAutoDiagPM357, rtrim ( @asChaineBCV) , ';')

			-- [PM357-1][MANTIS27318]
			Set @asChaineBCV = sysadm.FN_CLE_VAL_E  ( 'AUTO_DIAG_PM357', @sAutoDiagPM357, rtrim ( @asChaineBCV) , ';')

			Return @iRet
		End 

	-- A_Reparer_SAV Possible ?
	Select Top 1 
			@iIdSeqRef = c.id_seq,
			@dtDteEnvCliRef = c.dte_env_cli,
			@sAutoDiagPM357 = sysadm.FN_CLE_VAL ( 'AUTO_DIAG_PM357', c.info_spb_frn_cplt, ';')
	From sysadm.commande c
	Where c.id_sin = @dcIdSin
	And   c.id_typ_art = 'PRS'
	And	  c.id_four in ( 'O2M', 'PSM' ) -- Inclusion trt SAV 
	And   c.cod_etat in ( 'RPC', 'RFO' ) 
	And   c.status_gc = 2 
	And   c.id_seq = (  Select max ( id_seq ) 
						From sysadm.commande c1
						Where c1.id_sin = c.id_sin
						And   c1.id_four = c.id_four
						And   c1.cod_etat = c.cod_etat
						And   c1.status_gc = 2 
						)

	If @iIdSeqRef > 0 
		Begin
			If DateAdd ( month, @iPeriodeSavEnMois, @dtDteEnvCliRef ) < GetDate() 
				Begin
					Set @iRet = -100
					Set @asChaineRet = 'SAV impossible car la prestation de réparation d''origine date de plus de ' + Convert ( varchar, @iPeriodeSavEnMois) + ' mois (' + convert ( VarChar, @dtDteEnvCliRef, 103 ) + ').'

					-- [PM357][MANTIS27369]
					Exec sysadm.PS_I_PM357_CREATION_CONTACT	@dcIdSin, @iRet, 42, @asChaineRet
					-- /[PM357][MANTIS27369]

					Return @iRet				
				End 

			Set @iRet = 50 
			Set @asChaineRet = 'Eligible à une déclaration SAV sur la prestation de réparation d''origine.'
			Exec @iRet = sysadm.PS_S_PM357_LECTURE_POUR_CREATION_SAV @dcIdSin, @iIdSeqRef, @dtDteEnvCliRef, @iRet OUTPUT, @asChaineRet OUTPUT
			Set @asChaineBCV  = ''
			Set @asChaineBCV = sysadm.FN_CLE_VAL_E  ( 'ID_SIN', Convert ( Varchar, @dcIdSin ), rtrim ( ltrim ( @asChaineBCV  )), ';')
			Set @asChaineBCV = sysadm.FN_CLE_VAL_E  ( 'ID_SEQ_REF', Convert ( Varchar, @iIdSeqRef ), rtrim ( ltrim ( @asChaineBCV  )), ';')

			-- [PM357-1][MANTIS27318]
			Set @asChaineBCV = sysadm.FN_CLE_VAL_E  ( 'AUTO_DIAG_PM357', @sAutoDiagPM357, rtrim ( @asChaineBCV) , ';')

			-- [PM357][MANTIS27369]
			Exec sysadm.PS_I_PM357_CREATION_CONTACT	@dcIdSin, @iRet, 42, @asChaineRet
			-- /[PM357][MANTIS27369]

			Return @iRet
		End 
  End

Select @iIdSeqDernSavFerme = max ( c.id_seq ) 
From sysadm.commande c
Where c.id_sin = @dcIdSin
And   c.cod_etat in ( 'RPC', 'RFO', 'ANN', 'RSP' )
And   ( sysadm.FN_CLE_VAL ( 'A_REP_GARANTIE', c.info_spb_frn_cplt, ';' ) = 'OUI'
		Or 
		sysadm.FN_CLE_VAL ( 'A_REPARER_SAV', c.info_spb_frn_cplt, ';' ) = 'OUI'
		Or 
		sysadm.FN_CLE_VAL ( 'A_DESOXYDER_SAV', c.info_spb_frn_cplt, ';' ) = 'OUI'
		Or 
		sysadm.FN_CLE_VAL ( 'A_CONTOLER_SAV', c.info_spb_frn_cplt, ';' ) = 'OUI'
		)

If @iIdSeqDernSavFerme > 0
	Begin
		Set @iRet = -115
		Set @asChaineRet = 'Non éligible à la déclaration d''un SAV mais au moins un SAV fermé à consulter.'
		Set @asChaineBCV  = ''
		Set @asChaineBCV = sysadm.FN_CLE_VAL_E  ( 'ID_SIN', Convert ( Varchar, @dcIdSin ), rtrim ( ltrim ( @asChaineBCV )), ';')
		Set @asChaineBCV = sysadm.FN_CLE_VAL_E  ( 'ID_SEQ_SAV', Convert ( Varchar, @iIdSeqDernSavFerme ), rtrim ( ltrim ( @asChaineBCV )), ';')

		-- [PM357][MANTIS27369]
		Exec sysadm.PS_I_PM357_CREATION_CONTACT	@dcIdSin, @iRet, 42, @asChaineRet
		-- /[PM357][MANTIS27369]

		Return @iRet
	End 


Set @iRet = -110
Set @asChaineRet = 'Non éligible à la déclaration d''un SAV et aucun SAV à consulter.'

-- [PM357][MANTIS27369]
Exec sysadm.PS_I_PM357_CREATION_CONTACT	@dcIdSin, @iRet, 42, @asChaineRet
-- /[PM357][MANTIS27369]

Return @iRet				

Go


--------------------------------------------------------------------
-- Procédure            :       PS_S_PM357_LECTURE_POUR_CREATION_SAV
-- Auteur               :       Fabry JF
-- Date                 :       09/06/2017
-- Libellé              :		[PM357]
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- 22/12/2017   JFF  [PM357-1][MANTIS27327]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM357_LECTURE_POUR_CREATION_SAV' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM357_LECTURE_POUR_CREATION_SAV
GO

CREATE procedure sysadm.PS_S_PM357_LECTURE_POUR_CREATION_SAV
	@adcIdSin		Decimal ( 10 ), 
	@aiIdSeqRef		Integer, 
	@adtDteEnvCliRef DateTime, 
	@aiRet			Integer OUTPUT,
	@asChaineRet	VarChar ( 255 ) OUTPUT
AS

Declare @sMarqIfrAppRef VarChar ( 35 )
Declare @sModlIfrAppRef VarChar ( 35 )
Declare @sImeiAppRef    VarChar ( 35 )
Declare @iNumSavPrec	Integer
Declare @sNumSavPrec	Varchar ( 35 )
declare @iIdSeqPrecSav  Integer
declare @dtDateDeclaSavPrec Datetime
declare @iInfoSpbFrnRef Integer
declare @sIdFour Varchar ( 35 ) 
declare @sVal Varchar ( 100 ) 

declare 
@sNomLigne1	VarChar ( 35 ), -- [ADRESSE_O2M]
@sNomLigne2	VarChar ( 35 ), -- [ADRESSE_O2M]
@sAdrLigne1	VarChar ( 35 ),	-- [ADRESSE_O2M]
@sAdrLigne2	VarChar ( 35 ),	-- [ADRESSE_O2M]	
@sCP		VarChar ( 35 ), -- [ADRESSE_O2M]
@sVille	VarChar ( 35 ),  -- [ADRESSE_O2M]
@sAdresseFourn	VarChar ( 255 ),  -- [ADRESSE_O2M]
@sSaut		VarChar (10),
@sAdresseRecup VarChar ( 255 ),
@sAdressePickUp VarChar ( 255 ),
@sCodePickUp VarChar ( 30),
@iIdCli Integer

Set @sSaut = Char (10)

/* @iRet
30	'Eligible à une déclaration SAV sur l''appareil de remplacement fourni par SPB.'
35	'Eligible à une déclaration de 2ème SAV sur la prestation du 1er SAV.'
40 	'Eligible à une déclaration SAV sur la prestation de désoxydation d''origine.'
50	'Eligible à une déclaration SAV sur la prestation de réparation d''origine.'
*/

If @aiRet = 30 
  Begin
	Select  @sMarqIfrAppRef = rtrim ( c.id_marq_art_ifr ),
			@sModlIfrAppRef = rtrim ( c.id_modl_art_ifr ),
			@sImeiAppRef    = rtrim ( c.id_serie_nouv )
	From   sysadm.commande c
	Where  c.id_sin = @adcIdSin
	And    c.id_seq = @aiIdSeqRef

	-- [TODO]
	-- [ADRESSE_O2M] Récup Adresse O2M en fonction du contexte.
	Exec sysadm.PS_S01_ADRESSE_O2M_V01
	@adcIdSin	,
	'GENERATION',
	@sNomLigne1	OUTPUT,
	@sNomLigne2	OUTPUT,
	@sAdrLigne1	OUTPUT,
	@sAdrLigne2	OUTPUT,
	@sCP		OUTPUT,
	@sVille		OUTPUT

	Set @sAdresseFourn = ''
	If @sNomLigne1 is not null And Len ( @sNomLigne1 ) > 0 Set @sAdresseFourn = @sAdresseFourn  + @sNomLigne1 + ', '
	If @sNomLigne2 is not null And Len ( @sNomLigne2 ) > 0 Set @sAdresseFourn = @sAdresseFourn  + @sNomLigne2 + ', '
	If @sAdrLigne1 is not null And Len ( @sAdrLigne1 ) > 0 Set @sAdresseFourn = @sAdresseFourn  + @sAdrLigne1 + ', '
	If @sAdrLigne2 is not null And Len ( @sAdrLigne2 ) > 0 Set @sAdresseFourn = @sAdresseFourn  + @sAdrLigne2 + ', '
	If @sCP is not null And Len ( @sCP ) > 0 Set @sAdresseFourn = @sAdresseFourn  + @sCP 
	If @sVille is not null And Len ( @sVille ) > 0 Set @sAdresseFourn = @sAdresseFourn  + ' ' + @sVille 

	IF @sAdresseFourn is null Or ltrim ( @sAdresseFourn ) = ''
	  Begin
		Set @aiRet = -120
		Set @asChaineRet = 'Ce dossier est éligible au SAV mais ne peut être traité par l''extranet SAV, contactez SPB.'

		-- [PM357][MANTIS27369]
		Exec sysadm.PS_I_PM357_CREATION_CONTACT	@adcIdSin, @aiRet, 43, @asChaineRet
		-- /[PM357][MANTIS27369]

		Return @aiRet
	  End 

  End 

If @aiRet <> 30 
  Begin
	Select  @iInfoSpbFrnRef = c.info_spb_frn,
			@sIdFour = c.id_four
	From   sysadm.commande c
	Where  c.id_sin = @adcIdSin
	And    c.id_seq = @aiIdSeqRef
  End 

Select @iNumSavPrec = max ( sf.id_sav )
From   sysadm.sav_frn sf
Where  sf.id_sin = @adcIdSin

IF @iNumSavPrec > 0 
 Begin
	Set @sNumSavPrec = Convert ( Varchar, @iNumSavPrec )
	Set @sNumSavPrec = reverse ( @sNumSavPrec )
	Set @sNumSavPrec = Left ( @sNumSavPrec, 3 ) + 'A' + SUBSTRING ( @sNumSavPrec, 4, Len ( @sNumSavPrec ) )
	Set @sNumSavPrec = reverse ( @sNumSavPrec )

	Select @iIdSeqPrecSav  = sf.id_seq
	From   sysadm.sav_frn sf
	Where  sf.id_sav = @iNumSavPrec

	Select @dtDateDeclaSavPrec = c.cree_le 
	From   sysadm.commande c
	Where  id_sin = @adcIdSin
	And    id_seq = @iIdSeqPrecSav
 End 

If @aiRet <> 30 And @iInfoSpbFrnRef Not in ( 910, 1010, 912, 978, 979, 982, 2110, 2143, 2116, 2130 ) 
 Begin
	Set @aiRet = -120
	Set @asChaineRet = 'Ce dossier est éligible au SAV mais ne peut être traité par l''extranet SAV, contactez SPB.'

	-- [PM357][MANTIS27369]
	Exec sysadm.PS_I_PM357_CREATION_CONTACT	@adcIdSin, @aiRet, 43, @asChaineRet
	-- /[PM357][MANTIS27369]

	Return @aiRet
 End 

If @aiRet <> 30 And @iInfoSpbFrnRef in ( 910, 1010 ) 
 Begin
	-- [ADRESSE_O2M] Récup Adresse O2M en fonction du contexte.
	Exec sysadm.PS_S01_ADRESSE_O2M_V01
	@adcIdSin	,
	'GENERATION',
	@sNomLigne1	OUTPUT,
	@sNomLigne2	OUTPUT,
	@sAdrLigne1	OUTPUT,
	@sAdrLigne2	OUTPUT,
	@sCP		OUTPUT,
	@sVille		OUTPUT

	Set @sAdresseFourn = ''
	If @sNomLigne1 is not null And Len ( @sNomLigne1 ) > 0 Set @sAdresseFourn = @sAdresseFourn  + @sNomLigne1 + ', '
	If @sNomLigne2 is not null And Len ( @sNomLigne2 ) > 0 Set @sAdresseFourn = @sAdresseFourn  + @sNomLigne2 + ', '
	If @sAdrLigne1 is not null And Len ( @sAdrLigne1 ) > 0 Set @sAdresseFourn = @sAdresseFourn  + @sAdrLigne1 + ', '
	If @sAdrLigne2 is not null And Len ( @sAdrLigne2 ) > 0 Set @sAdresseFourn = @sAdresseFourn  + @sAdrLigne2 + ', '
	If @sCP is not null And Len ( @sCP ) > 0 Set @sAdresseFourn = @sAdresseFourn  + @sCP 
	If @sVille is not null And Len ( @sVille ) > 0 Set @sAdresseFourn = @sAdresseFourn  + ' ' + @sVille + @sSaut 		

	IF @sAdresseFourn is null Or ltrim ( @sAdresseFourn ) = ''
	  Begin
		Set @aiRet = -120
		Set @asChaineRet = 'Ce dossier est éligible au SAV mais ne peut être traité par l''extranet SAV, contactez SPB.'

		-- [PM357][MANTIS27369]
		Exec sysadm.PS_I_PM357_CREATION_CONTACT	@adcIdSin, @aiRet, 43, @asChaineRet
		-- /[PM357][MANTIS27369]

		Return @aiRet
	  End 
 End 

If @aiRet <> 30 And @iInfoSpbFrnRef in ( 912 ) 
 Begin
	Select @sVal = rtrim ( i.adr_mail)
	From sysadm.inter i
	Where i.id_sin = @adcIdSin
	And   i.cod_inter = 'A'

	If @sVal is null OR lTrim ( @sVal ) = ''
	  Begin
		Set @aiRet = -120
		Set @asChaineRet = 'Ce dossier est éligible au SAV mais ne peut être traité par l''extranet SAV, contactez SPB.'

		-- [PM357][MANTIS27369]
		Exec sysadm.PS_I_PM357_CREATION_CONTACT	@adcIdSin, @aiRet, 43, @asChaineRet
		-- /[PM357][MANTIS27369]

		Return @aiRet
	  End 

 End 


If @aiRet <> 30 And @iInfoSpbFrnRef in ( 978, 979 ) 
 Begin
	Select @sAdresseRecup = 
			IsNull ( rtrim ( c.adr_nom) , '' ) + ' ' +
			IsNull ( rtrim (c.adr_prenom ), '' ) + ', ' +
			IsNull ( rtrim (c.adr_livr1), '' ) + ', '+ 
			IsNull ( rtrim (c.adr_livr2), '' ) + ', '+ 
			IsNull ( rtrim (c.adr_livr_cpl), '' ) + ', '+ 
			IsNull ( rtrim (c.adr_cp), '' ) + ' ' + 
			IsNull ( rtrim (c.adr_ville), '' ) + @sSaut

	From  sysadm.commande c
	Where c.id_sin = @adcIdSin
	And   c.id_seq = @aiIdSeqRef

	IF @sAdresseRecup is null Or ltrim ( @sAdresseRecup ) = ''
	  Begin
		Set @aiRet = -120
		Set @asChaineRet = 'Ce dossier est éligible au SAV mais ne peut être traité par l''extranet SAV, contactez SPB.'

		-- [PM357][MANTIS27369]
		Exec sysadm.PS_I_PM357_CREATION_CONTACT	@adcIdSin, @aiRet, 43, @asChaineRet
		-- /[PM357][MANTIS27369]

		Return @aiRet
	  End 


 End 

If @aiRet <> 30 And @iInfoSpbFrnRef in ( 982, 2143 ) 
 Begin
	Select @sVal = rtrim ( i.adr_mail)
	From sysadm.inter i
	Where i.id_sin = @adcIdSin
	And   i.cod_inter = 'A'

	If @sVal is null OR lTrim ( @sVal ) = ''
	  Begin
		Set @aiRet = -120
		Set @asChaineRet = 'Ce dossier est éligible au SAV mais ne peut être traité par l''extranet SAV, contactez SPB.'

		-- [PM357][MANTIS27369]
		Exec sysadm.PS_I_PM357_CREATION_CONTACT	@adcIdSin, @aiRet, 43, @asChaineRet
		-- /[PM357][MANTIS27369]

		Return @aiRet
	  End 

	Select @sAdressePickUp = 
			IsNull ( rtrim ( c.adr_nom), '' ) + ' ' +
			IsNull ( rtrim ( c.adr_prenom), '' ) + ', '+ 
			IsNull ( rtrim ( c.adr_livr1), '' ) + ', '+ 
			IsNull ( rtrim ( c.adr_livr2), '' ) + ', '+ 
			IsNull ( rtrim ( c.adr_livr_cpl), '' ) + ', '+ 
			IsNull ( rtrim ( c.adr_cp), '' ) + ' ' + 
			IsNull ( rtrim ( c.adr_ville), '' ) 
	From  sysadm.commande c
	Where c.id_sin = @adcIdSin
	And   c.id_seq = @aiIdSeqRef

	Select Top 1
			@sCodePickUp = sysadm.FN_CLE_VAL ( 'CODE_PICK_UP', c.info_spb_frn_cplt, ';') 
	From  sysadm.commande c
	Where c.id_sin = @adcIdSin
	And   Len ( sysadm.FN_CLE_VAL ( 'CODE_PICK_UP', c.info_spb_frn_cplt, ';') ) > 0

	IF ( @sAdressePickUp is null Or ltrim ( @sAdressePickUp ) = '' ) Or 
	   ( @sCodePickUp is null Or ltrim ( @sCodePickUp ) = '' ) 
	  Begin
		Set @aiRet = -120
		Set @asChaineRet = 'Ce dossier est éligible au SAV mais ne peut être traité par l''extranet SAV, contactez SPB.'
		
		-- [PM357][MANTIS27369]
		Exec sysadm.PS_I_PM357_CREATION_CONTACT	@adcIdSin, @aiRet, 43, @asChaineRet
		-- /[PM357][MANTIS27369]

		Return @aiRet
	  End 
 End 

If @aiRet <> 30 And @iInfoSpbFrnRef in ( 2116 ) 
 Begin
	-- Rien besoin, en effet PSM envoie le BBP par mail ou par courrier si absence d'email.
	-- [TODO]
	Set @aiRet = @aiRet -- il faut amu une ligne dans le Begin/End et je tiens à laisser ce bloc test.
 End 

If @aiRet <> 30 And @iInfoSpbFrnRef in ( 2130 ) 
 Begin
	-- Lire Proxi PSM où l'assuré est allé.
	Select  @sVal = sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
	From	sysadm.commande c
	Where c.id_sin = @adcIdSin
	And   c.id_seq = @aiIdSeqRef
	And	  sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 

	IF ( @sVal is null Or ltrim ( @sVal ) = '' ) 
	  Begin
		Set @aiRet = -120
		Set @asChaineRet = 'Ce dossier est éligible au SAV mais ne peut être traité par l''extranet SAV, contactez SPB.'

		-- [PM357][MANTIS27369]
		Exec sysadm.PS_I_PM357_CREATION_CONTACT	@adcIdSin, @aiRet, 43, @asChaineRet
		-- /[PM357][MANTIS27369]

		Return @aiRet
	  End 

	Select @sAdresseFourn = 
		   IsNull ( rtrim (b.adr_nom), '' ) + ', '+ 
		   IsNull ( rtrim (b.adr_1), '' )+ ', '+ 
		   IsNull ( rtrim (b.adr_2), '' ) + ', '+ 
		   IsNull ( rtrim (b.adr_cp), '' ) + ', '+ 
		   IsNull ( rtrim (b.adr_ville), '' ) 
    From   sysadm.boutique b,
		   sysadm.sinistre s
    Where  s.id_sin = @adcIdSin
	And    b.id_prod = s.id_prod
    And isNumeric(b.cod_mag)=1 -- [ITSM171587]
	And Convert ( integer, b.cod_mag ) = Convert ( integer, @sVal )
    And sysadm.FN_CLE_VAL( 'FRN',b.region,  ';') = 'PSM'

	IF ( @sAdresseFourn is null Or ltrim ( @sAdresseFourn ) = '' ) 
	  Begin
		Set @aiRet = -120
		Set @asChaineRet = 'Ce dossier est éligible au SAV mais ne peut être traité par l''extranet SAV, contactez SPB.'

		-- [PM357][MANTIS27369]
		Exec sysadm.PS_I_PM357_CREATION_CONTACT	@adcIdSin, @aiRet, 43, @asChaineRet
		-- /[PM357][MANTIS27369]

		Return @aiRet
	  End 
 End 


If @aiRet <> 30 And @iInfoSpbFrnRef in ( 2110 ) 
 Begin
	-- Lire ce qu'à fait l'assuré et le ressortir sous forme 21101, 21102
	Select  @sVal = Case 
						When sysadm.FN_CLE_VAL ( 'ASSURE_EN_PDV', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
							Then '21101'
						When sysadm.FN_CLE_VAL ( 'ASSURE_ENVOIE_COLIS', rtrim( c.info_frn_spb_cplt) , ';' ) = 'OUI' 
							Then '21102'
				     End 
	From	sysadm.commande c
	Where c.id_sin = @adcIdSin
	And   c.id_seq = @aiIdSeqRef

	IF ( @sVal is null Or ltrim ( @sVal ) = '' ) 
	  Begin
		Set @aiRet = -120
		Set @asChaineRet = 'Ce dossier est éligible au SAV mais ne peut être traité par l''extranet SAV, contactez SPB.'

		-- [PM357][MANTIS27369]
		Exec sysadm.PS_I_PM357_CREATION_CONTACT	@adcIdSin, @aiRet, 43, @asChaineRet
		-- /[PM357][MANTIS27369]

		Return @aiRet
	  End 	

	Set @iInfoSpbFrnRef = Convert ( integer, @sVal ) 

	-- Lire Proxi PSM où l'assuré est allé.
	Select  @sVal = sysadm.FN_CLE_VAL ( 'NUM_PDV', rtrim( c.info_frn_spb_cplt) , ';' )
	From	sysadm.commande c
	Where c.id_sin = @adcIdSin
	And   c.id_seq = @aiIdSeqRef

	IF ( @sVal is null Or ltrim ( @sVal ) = '' ) 
	  Begin
		Set @aiRet = -120
		Set @asChaineRet = 'Ce dossier est éligible au SAV mais ne peut être traité par l''extranet SAV, contactez SPB.'

		-- [PM357][MANTIS27369]
		Exec sysadm.PS_I_PM357_CREATION_CONTACT	@adcIdSin, @aiRet, 43, @asChaineRet
		-- /[PM357][MANTIS27369]

		Return @aiRet
	  End 

	Select @sAdresseFourn = 
		   IsNull ( rtrim (b.adr_nom), '' ) + ', '+ 
		   IsNull ( rtrim (b.adr_1), '' ) + ', '+ 
		   IsNull ( rtrim (b.adr_2), '' ) + ', '+ 
		   IsNull ( rtrim (b.adr_cp), '' ) + ', '+ 
		   IsNull ( rtrim (b.adr_ville), '' ) 
    From   sysadm.boutique b,
		   sysadm.sinistre s
    Where  s.id_sin = @adcIdSin
	And    b.id_prod = s.id_prod
    And isNumeric(b.cod_mag)=1 -- [ITSM171587]
	And Convert ( integer, b.cod_mag ) = Convert ( integer, @sVal )
    And sysadm.FN_CLE_VAL( 'FRN',b.region,  ';') = 'PSM'

	IF ( @sAdresseFourn is null Or ltrim ( @sAdresseFourn ) = '' ) 
	  Begin
		Set @aiRet = -120
		Set @asChaineRet = 'Ce dossier est éligible au SAV mais ne peut être traité par l''extranet SAV, contactez SPB.'

		-- [PM357][MANTIS27369]
		Exec sysadm.PS_I_PM357_CREATION_CONTACT	@adcIdSin, @aiRet, 43, @asChaineRet
		-- /[PM357][MANTIS27369]

		Return @aiRet
	  End 
 End 

-- [PM357-1][MANTIS25852]
		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Select Top 1 @iIdCli = s.id_cli
			From   SHERPA_PRO.sysadm.sinistre s
			Where  s.id_sin = @adcIdSin
		END
		ELSE
		BEGIN
			Select Top 1 @iIdCli = s.id_cli
			From   SHERPA_SIM.sysadm.sinistre s
			Where  s.id_sin = @adcIdSin
		END
-- /[PM357-1][MANTIS25852]

-- Select Final pour le site, pas d'autres select dérrière.
Select	@aiRet 'Cas',
		Case @aiRet
			When 30	Then 'Eligible à une déclaration SAV sur l''appareil de remplacement fourni par SPB.'
			When 35	Then 'Eligible à une déclaration de 2ème SAV sur la prestation du 1er SAV.'
			When 40 Then 'Eligible à une déclaration SAV sur la prestation de désoxydation d''origine.'
			When 50	Then 'Eligible à une déclaration SAV sur la prestation de réparation d''origine.'
			Else ''
		End 'Lib_Cas',
		-- [PM357-1][MANTIS27327]
		sysadm.FN_CODE_NUM ( p.cod_civ, '-CI' ) 'Civilite_Courte',
		sysadm.FN_CODE_NUM ( p.cod_civ, '-CL' ) 'Civilite_Longue',
		-- /[PM357-1][MANTIS27327]
		rtrim ( p.nom ) 'Nom_assuré',
		rtrim ( p.prenom ) 'Prénom_assuré',
		rtrim ( p.adr_1 ) 'adr1_assure',
		rtrim ( p.adr_2 ) 'adr2_assure',
		rtrim ( p.adr_cp ) 'adr_cp_assure',
		rtrim ( p.adr_ville ) 'adr_ville_assure',
		s.num_port 'num_tel_app_sinistré',
		( Select rtrim ( i.num_teld )
		  From sysadm.inter i
		  Where i.id_sin = @adcIdSin
		  And   i.cod_inter = 'A'
		) 'Autre_num_tel_assuré',
		( Select rtrim ( i.adr_mail)
		  From sysadm.inter i
		  Where i.id_sin = @adcIdSin
		  And   i.cod_inter = 'A'
		) 'adr_mail_assuré',
		s.id_sin 'Référence_sinistre',
		c.id_seq 'Prestation_de_référence',
		(	Select rtrim ( dp.val_car )
			From sysadm.det_pro dp
			Where dp.id_prod = s.id_prod
			And   dp.id_code_dp = 66
		) 'Lib_prod_vu_assuré',
		(	Select rtrim ( dp.val_car )
			From sysadm.det_pro dp
			Where dp.id_prod = s.id_prod
			And   dp.id_code_dp = 67
		) 'Lib_opt_prod_vu_assuré',
		sysadm.FN_LIB_PROD ( s.id_prod ) 'Lib_prod_vu_SPB',
		( Select Top 1 rtrim ( cg.lib_gti )
		  From sysadm.code_garantie cg
		  Where cg.id_prod = s.id_prod
		  And   cg.id_gti = c.id_gti
		) 'Lib_garantie',
		Case @aiRet
			When 30 Then @sMarqIfrAppRef
			Else rtrim ( s.marq_port ) 
		End 'Marque_app_de_référence',
		Case @aiRet
			When 30 Then @sModlIfrAppRef
			Else rtrim ( s.modl_port ) 
		End 'Modèle_app_de_référence',
		Case @aiRet 
			When 30 Then @sImeiAppRef
			Else rtrim ( s.num_imei_port ) 
		End 'IMEI_app_de_référence',  -- [PM357-1][MANTIS25852]
		@iIdCli 'Id_Client_Sherpa', -- [PM357-1][MANTIS25852]
		s.dte_decl 'Date_Décla_sinistre',
		@adtDteEnvCliRef 'Date_fin_presta_de_référence',
		Case @aiRet
			When 30 Then 'Remplacement'
			Else 'Réparation'
		End 'Mode d''indenisation',
		@sNumSavPrec 'Numéro_précédent_sav',
		@dtDateDeclaSavPrec 'Date_décla_sav_précédent',
		Case 
			When @aiRet = 30 Then 1010
			Else @iInfoSpbFrnRef
		End 'Code_process_acheminement',
		@sAdresseFourn 'Adresse_fournisseur',
		@sAdresseRecup 'Adresse_de_récupération',
		@sAdressePickUp 'Adresse_relais_pick_up',
		@sCodePickUp 'Code_relais_pick_up'
		
From  sysadm.sinistre s,
	  sysadm.commande c,
	  sysadm.personne p 

Where c.id_sin = @adcIdSin
And   c.id_seq = @aiIdSeqRef
And	  s.id_sin = c.id_sin
And   p.id_ordre = s.id_ordre

Return @aiRet

Go

--------------------------------------------------------------------
-- Procédure            :       sysadm.PS_S_PM357_CREATION_SAV
-- Auteur               :       Fabry JF
-- Date                 :       09/06/2017
-- Libellé              :		[PM357]
-- Commentaires         :       Appelé par l'extranet
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM357_CREATION_SAV' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM357_CREATION_SAV
GO

CREATE procedure sysadm.PS_S_PM357_CREATION_SAV
	@adcIdSin		Decimal ( 10 ),
	@asNumLigne		VarChar ( 20 ),
	@asProbleme		VarChar ( 255 ),
	@asNumSav		VarChar ( 50 ) OUTPUT,
	@asChaineRet	Varchar (255)  OUTPUT
AS

Declare @iRet Integer 
Declare @sChaineBCV VarChar ( 255 )
Declare @iIdSeqRef Integer
Declare @sIdSin  VarChar ( 10 )

Set @sChaineBCV = Space ( 255 )
Set @asChaineRet = Space ( 255 ) 
Set @asNumSav = Space ( 50 ) 
Set @sIdSin = Convert ( VarChar ( 10 ), @adcIdSin ) 

IF @asProbleme is null Set @asProbleme = ''
If ltrim ( @asProbleme ) = '' 
 Begin
		Set @iRet = -150
		Set @asChaineRet = 'Le problème qui engendre le SAV doit être renseigné.'

		-- [PM357][MANTIS27369]
		Exec sysadm.PS_I_PM357_CREATION_CONTACT	@adcIdSin, @iRet, 43, @asChaineRet
		-- /[PM357][MANTIS27369]

		Return @iRet	
 End 

 Set @asProbleme = sysadm.FN_EPURE_CHAINE (
								Upper ( 
								Replace ( Replace ( Replace ( Replace ( Replace ( 
								Replace ( rtrim ( @asProbleme), '''', '' ), 
								char ( 13 ), '' ),
								char ( 10 ), '' ),
								char ( 9 ), '' ),
								char ( 11 ), '' ),
								'"', '' )
								))

Exec @iRet = sysadm.PS_S_PM357_CTRLE_CONNEXION @sIdSin, @asNumLigne, @sChaineBCV OUTPUT, @asChaineRet	OUTPUT

If @iRet Not in ( 30, 35, 40, 50 ) 
 Begin

 	-- [PM357][MANTIS27369]
	Exec sysadm.PS_I_PM357_CREATION_CONTACT	@adcIdSin, @iRet, 43, @asChaineRet
	-- /[PM357][MANTIS27369]
	Return @iRet

 End 

Set @iIdSeqRef = sysadm.FN_CLE_VAL ( 'ID_SEQ_REF', @sChaineBCV, ';' )

If @iRet = 30
  Begin
	Exec @iRet = sysadm.PS_S_PM357_CREATION_SAV_A_REP_GARANTIE @adcIdSin, @iIdSeqRef, @asProbleme, @asNumSav OUTPUT, @asChaineRet OUTPUT 

	-- [PM357][MANTIS27369]
	Exec sysadm.PS_I_PM357_CREATION_CONTACT	@adcIdSin, @iRet, 43, @asChaineRet
	-- /[PM357][MANTIS27369]

	Return @iRet
  End 


If @iRet in ( 35, 40, 50 )
  Begin
	Exec @iRet = sysadm.PS_S_PM357_CREATION_SAV_REPA_ORIGINE @adcIdSin, @iIdSeqRef, @asProbleme, @iRet, @asNumSav OUTPUT, @asChaineRet OUTPUT 

	-- [PM357][MANTIS27369]
	Exec sysadm.PS_I_PM357_CREATION_CONTACT	@adcIdSin, @iRet, 43, @asChaineRet
	-- /[PM357][MANTIS27369]

	Return @iRet
  End 


Go

--------------------------------------------------------------------
-- Procédure            :       sysadm.PS_S_PM357_CREATION_SAV_A_REP_GARANTIE
-- Auteur               :       Fabry JF
-- Date                 :       09/06/2017
-- Libellé              :		[PM357]
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF   15/12/2017   [PM357][MANTIS27369]
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM357_CREATION_SAV_A_REP_GARANTIE' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM357_CREATION_SAV_A_REP_GARANTIE
GO

CREATE procedure sysadm.PS_S_PM357_CREATION_SAV_A_REP_GARANTIE
	@adcIdSin	Decimal ( 10 ),
	@aiIdSeqRef	Integer,
	@asProbleme VarChar ( 255), 
	@asNumSav	VarChar ( 50 ) OUTPUT,
	@asChaineRet	Varchar (255)  OUTPUT
AS

Declare @iRet Integer
Declare @dcIdGti Decimal ( 7 )
Declare @dcIdDetailMax Decimal ( 7 )
Declare @dcMtValAchat Decimal ( 11, 2 )
Declare @dcMtValPublique Decimal ( 11, 2 )
Declare @iIdseqMax Integer
Declare @sNomAss VarChar (35)
Declare @sPrenomAss VarChar (35)
Declare @sAdr1Ass VarChar (35)
Declare @sAdr2Ass VarChar (35)
Declare @sAdrCpAss VarChar (5)
Declare @sAdrVilleAss VarChar (35)
Declare @sAdrMailAss VarChar ( 128 )
Declare @iTableW Integer
Declare @iOkTableW Integer
Declare @iOkTableP Integer
Declare @dcIdSav Decimal ( 10 )
Declare @sMsgTemp VarChar ( 500 ) 
Declare @iIdCt Integer

Set @iTableW = 0
Set @iOkTableW = 0
Set @iOkTableP = 0

If Not Exists ( 
		Select Top 1 1 
		From	sysadm.code_condition cc,
				sysadm.sinistre s,
				sysadm.commande c
		Where  s.id_sin = @adcIdSin
		And    c.id_sin = s.id_sin
		And    c.id_seq = @aiIdSeqRef
		And    cc.id_prod = s.id_prod
		And    cc.id_gti = c.id_gti
		And	   cc.id_typ_code = '+EV'
		And    cc.id_code = 1422
	)
	Begin
		Set @iRet = -140
		Set @asChaineRet = '[PROBLEME_TECHNIQUE] problème de paramétrage : évènement 1422 non paramétré sur ce produit.'

		-- [PM357][MANTIS27369]
		Exec sysadm.PS_I_PM357_CREATION_CONTACT	@adcIdSin, @iRet, 43, @asChaineRet
		-- /[PM357][MANTIS27369]

		Return @iRet 
	End 

Select  @dcIdGti = c.id_gti
From	sysadm.commande c
Where   c.id_sin = @adcIdSin
And		c.id_seq = @aiIdSeqRef

Select  Top 1
		@dcMtValAchat = dt.mt_val_achat,
		@dcMtValPublique = dt.mt_val_publique
From    sysadm.detail dt
Where   dt.id_sin = @adcIdSin
And		dt.id_gti = @dcIdGti
And		dt.mt_val_achat > 0
And		dt.mt_val_achat <> 9999
And		dt.mt_val_publique > 0

Select @iIdseqMax = Max ( id_seq ) 
From   sysadm.commande c
Where  c.id_sin = @adcIdSin

If @iIdseqMax is null Set @iIdseqMax = 0
Set @iIdseqMax = @iIdseqMax + 1

Select 	@sNomAss = p.nom,
		@sPrenomAss = p.prenom,
		@sAdr1Ass = p.adr_1,
		@sAdr2Ass = p.adr_2,
		@sAdrCpAss = p.adr_cp,
		@sAdrVilleAss = p.adr_ville
From	sysadm.sinistre s,
		sysadm.personne p
Where   s.id_sin = @adcIdSin
And		p.id_ordre = s.id_ordre

Select  @sAdrMailAss = ltrim ( rtrim ( i.adr_mail )) 
From	sysadm.inter i
Where   i.id_sin = @adcIdSin
And     i.cod_inter = 'A'

If @sAdrMailAss is null set @sAdrMailAss = ''

-- Création si prsence w_sin
If Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin ) 
 Begin

	Set @iTableW = 1

	Select @dcIdDetailMax = Max ( wd.id_detail  )
	From   sysadm.w_detail wd
	Where  wd.id_sin = @adcIdSin
	and    wd.id_gti = @dcIdGti 

	IF @dcIdDetailMax is null Set @dcIdDetailMax = 0
	Set @dcIdDetailMax = @dcIdDetailMax  + 1

	-- w_detail
	Insert into sysadm.w_detail
	(
	id_sin,
	id_gti,
	id_detail,
	id_evt,
	lib_det,
	dte_det,
	heu_det,
	num_carte,
	mt_prej,
	mt_fran,
	mt_nplaf,
	mt_plaf,
	id_i_reg,
	alt_bloc,
	alt_cour,
	alt_plaf,
	alt_reg,
	alt_att,
	alt_valide,
	cpt_valide,
	alt_ssui,
	cod_mot_ssui,
	cod_dec_mac,
	cod_dec_ope,
	cod_etat,
	id_carte,
	id_type_carte,
	cree_le,
	maj_le,
	maj_par,
	dte_cmd,
	dte_livr,
	mt_val_achat,
	mt_val_publique,
	num_facture
	)
	Values 
	(
	@adcIdSin,
	@dcIdGti,
	@dcIdDetailMax,
	1422,
	'de votre appareil',
	null,
	null,
	null,
	0,
	0,
	0,
	0,
	null,
	'N',
	'N',
	'N',
	'N',
	'O',
	'N',
	1,
	'N',
	0,
	100,
	100,
	100,
	0,
	'00',
	Getdate(),
	Getdate(),
	'AUTO',
	null,
	null,
	@dcMtValAchat,
	@dcMtValPublique,
	'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
	)

	-- w_div_det
	Insert into sysadm.w_div_det
	Select 
		@adcIdSin,
		@dcIdGti,
		@dcIdDetailMax,
		nom_zone,
		lib_label,
		id_typ_liste,
		alt_liste_codecar,
		id_typ_zone,
		alt_oblig,
		alt_prot,
		cpt_tri,
		val_nbre,
		Case nom_zone
			When 'mt_pec' Then 0
			Else val_mt
		End val_mt,
		Case nom_zone
			When 'dte_pec' Then Getdate()
			Else val_dte
		End val_dte,
		Case nom_zone
			When 'pec' Then 'O'
			Else val_car
		End val_car,
		1,
		Getdate(),
		Getdate(),
		'AUTO'
	from	sysadm.div_det 
	where	id_sin = 5277348 -- modèle
	and		id_gti = 24  -- modèle
	and		id_detail = 2  -- modèle

	-- Passé par un Insert/Select de la presta initiale
	Insert sysadm.w_commande 
	Select  
		id_sin,
		@iIdseqMax ,		
		id_gti,
		@dcIdDetailMax,
		id_four,
		'PRS',
		id_marq_art,
		id_modl_art,
		0,
		@sNomAss,
		@sPrenomAss,
		@sAdr1Ass,
		@sAdr2Ass,
		null,
		@sAdrCpAss,
		@sAdrVilleAss,
		adr_tel1,
		adr_tel2,
		adr_tel3,
		adr_mail,
		dte_rdv_cli,
		hrdv_cli_min,
		hrdv_cli_max,
		id_serie_nouv 'id_serie_anc',
		@asProbleme,
		null 'id_cmd_frn',
		null 'id_serie_nouv',
		null 'id_bon_transp',
		null 'dte_rcp_frn',
		null 'dte_env_cli',
		'ECT' 'cod_etat',
		null 'comment_frn',
		1 'cpt_valide',
		'AUTO' 'nom_gest',
		Getdate(),
		Getdate(),
		'AUTO',
		id_zone,
		id_bsp,
		dte_ret_pret,
		adr_cod_civ,
		'A_REPARER' 'id_ref_four',
		id_orian_marque,
		0 'id_orian_modele',
		dte_elv_mobile,
		0 'status_gc',
		dte_emis_devis,
		mt_devis,
		alt_dev_acp,
		dte_dev_acp,
		adrfc_cod_civ,
		null 'adrfc_nom',
		adrfc_prenom,
		adrfc_livr1,
		adrfc_livr2,
		adrfc_livr_cpl,
		adrfc_cp,
		adrfc_ville,
		dte_ret_logis,
		dte_ret_pret_min,
		dte_ret_pret_max,
		id_ann,
		dte_env_bte_frn,
		null 'dte_rcp_bte_cli',
		dte_dep_bte_cli,
		dte_env_st,
		dte_rcp_mob_cli,
		1010 'info_spb_frn',
		'' 'id_marq_art_ifr',
		'' 'id_modl_art_ifr',
		'A_REP_GARANTIE=OUI;MAIL_IOS7=NON;MT_PEC=0.00;SKU_IFR=;MAIL_ASSURE=' + @sAdrMailAss 'info_spb_frn_cplt',
		'' 'info_frn_spb_cplt'
	from	sysadm.w_commande 
	where	id_sin = @adcIdSin 
	And		id_seq = @aiIdSeqRef
 End


-- Pas de test pour la présence dans sinistre, car on ne serait pas arriver jusque là sinon.
Select @dcIdDetailMax = Max ( d.id_detail )
From   sysadm.detail d
Where  d.id_sin = @adcIdSin
and    d.id_gti = @dcIdGti 

IF @dcIdDetailMax is null Set @dcIdDetailMax = 0
Set @dcIdDetailMax = @dcIdDetailMax  + 1

-- detail

Insert into sysadm.detail
(
	id_sin,
	id_gti,
	id_detail,
	id_evt,
	id_reg,
	id_i_reg,
	lib_det,
	dte_det,
	heu_det,
	num_carte,
	mt_prej,
	mt_fran,
	mt_nplaf,
	mt_plaf,
	alt_plaf,
	alt_reg,
	alt_att,
	alt_ssui,
	cod_mot_ssui,
	cod_dec_mac,
	cod_dec_ope,
	cod_etat,
	id_carte,
	id_type_carte,
	valide_le,
	valide_par,
	cree_le,
	maj_le,
	maj_par,
	dte_cmd,
	dte_livr,
	mt_val_achat,
	mt_val_publique,
	num_facture
)
Values 
(
	@adcIdSin,
	@dcIdGti,
	@dcIdDetailMax,
	1422,
	0,
	null,
	'de votre appareil',
	null,
	null,
	null,
	0,
	0,
	0,
	0,
	'N',
	'N',
	'O',
	'N',
	0,
	100,
	100,
	100,
	0,
	'00',
	Getdate(),
	'AUTO',
	Getdate(),
	Getdate(),
	'AUTO',
	null,
	null,
	@dcMtValAchat,
	@dcMtValPublique,
	'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
)

-- div_det
Insert into sysadm.div_det
Select 
	@adcIdSin,
	@dcIdGti,
	@dcIdDetailMax,
	nom_zone,
	lib_label,
	id_typ_liste,
	alt_liste_codecar,
	id_typ_zone,
	alt_oblig,
	alt_prot,
	cpt_tri,
	val_nbre,
	Case nom_zone
		When 'mt_pec' Then 0
		Else val_mt
	End val_mt,
	Case nom_zone
		When 'dte_pec' Then Getdate()
		Else val_dte
	End val_dte,
	Case nom_zone
		When 'pec' Then 'O'
		Else val_car
	End val_car,
	Getdate(),
	Getdate(),
	'AUTO',
	Getdate(),
	'AUTO'

from	sysadm.div_det 
where	id_sin = 5277348 -- modèle
and		id_gti = 24  -- modèle
and		id_detail = 2  -- modèle

-- Passé par un Insert/Select de la presta initiale
Insert sysadm.commande 
Select  
	id_sin,
	@iIdseqMax ,		
	id_gti,
	@dcIdDetailMax,
	id_four,
	'PRS',
	id_marq_art,
	id_modl_art,
	0,
	@sNomAss,
	@sPrenomAss,
	@sAdr1Ass,
	@sAdr2Ass,
	null,
	@sAdrCpAss,
	@sAdrVilleAss,
	adr_tel1,
	adr_tel2,
	adr_tel3,
	adr_mail,
	dte_rdv_cli,
	hrdv_cli_min,
	hrdv_cli_max,
	id_serie_nouv 'id_serie_anc',
	@asProbleme,
	null 'id_cmd_frn',
	null 'id_serie_nouv',
	null 'id_bon_transp',
	null 'dte_rcp_frn',
	null 'dte_env_cli',
	'ECT' 'cod_etat',
	null 'comment_frn',
	'AUTO' 'nom_gest',
	0 'id_lot_cmd',
	null 'cmd_gen_le',
	null 'cmd_gen_par',
	Getdate(),
	Getdate(),
	'AUTO',
	Getdate(),
	'AUTO',
	id_zone,
	id_bsp,
	dte_ret_pret,
	adr_cod_civ,
	'A_REPARER' 'id_ref_four',
	id_orian_marque,
	0 'id_orian_modele',
	dte_elv_mobile,
	0 'status_gc',
	dte_emis_devis,
	mt_devis,
	alt_dev_acp,
	dte_dev_acp,
	adrfc_cod_civ,
	null 'adrfc_nom',
	adrfc_prenom,
	adrfc_livr1,
	adrfc_livr2,
	adrfc_livr_cpl,
	adrfc_cp,
	adrfc_ville,
	dte_ret_logis,
	dte_ret_pret_min,
	dte_ret_pret_max,
	id_ann,
	dte_env_bte_frn,
	null 'dte_rcp_bte_cli',
	dte_dep_bte_cli,
	dte_env_st,
	dte_rcp_mob_cli,
	1010 'info_spb_frn',
	'' 'id_marq_art_ifr',
	'' 'id_modl_art_ifr',
	'A_REP_GARANTIE=OUI;MAIL_IOS7=NON;MT_PEC=0.00;SKU_IFR=;MAIL_ASSURE=' + @sAdrMailAss 'info_spb_frn_cplt',
	'' 'info_frn_spb_cplt'
from	sysadm.commande 
where	id_sin = @adcIdSin 
And		id_seq = @aiIdSeqRef
 
-- Création du numéro SAV
EXEC sysadm.PS_X_INCREMENTER 'ID_SAV', @dcIdSav OUTPUT 
Insert into sysadm.sav_frn ( 
   id_sav,
   id_sin,
   id_seq,
   cree_le,
   maj_le,
   maj_par
   )
Values 
   (
   @dcIdSav,
   @adcIdSin,
   @iIdseqMax,
   GetDate(),
   Getdate(),
   'AUTO'
   )

Set @asNumSav = convert ( Varchar, @dcIdSav )
Set @asNumSav = reverse ( @asNumSav )
Set @asNumSav = Left ( @asNumSav, 3 ) + 'A' + Substring ( @asNumSav, 4, Len ( @asNumSav ) )
Set @asNumSav = reverse ( @asNumSav )

-- test de controle avant le renvoi OK
IF @iTableW = 1 
 Begin 
	If Exists ( 
		Select Top 1 1
		From  sysadm.w_detail d,
			  sysadm.w_div_det dd,
			  sysadm.w_commande c,
			  sysadm.sav_frn sf
		Where d.id_sin = @adcIdSin
		And	  d.id_gti = @dcIdGti
		And   d.id_detail = @dcIdDetailMax
		And   dd.id_sin = d.id_sin
		And   dd.id_gti = d.id_gti
		And   dd.id_detail = d.id_detail 
		And   c.id_sin = d.id_sin
		And   c.id_gti = d.id_gti
		And   c.id_detail = d.id_detail
		And   sf.id_sin = c.id_sin
		And   sf.id_seq  = c.id_seq
			) 
		Begin
			Set @iOkTableW = 1
		End 

 End 

If Exists ( 
		Select Top 1 1
		From  sysadm.detail d,
			  sysadm.div_det dd,
			  sysadm.commande c,
			  sysadm.sav_frn sf
		Where d.id_sin = @adcIdSin
		And	  d.id_gti = @dcIdGti
		And   d.id_detail = @dcIdDetailMax
		And   dd.id_sin = d.id_sin
		And   dd.id_gti = d.id_gti
		And   dd.id_detail = d.id_detail 
		And   c.id_sin = d.id_sin
		And   c.id_gti = d.id_gti
		And   c.id_detail = d.id_detail
		And   sf.id_sin = c.id_sin
		And   sf.id_seq  = c.id_seq
		) 
	Begin
		Set @iOkTableP = 1 
	End 

If @iOkTableP = 1 And ( @iTableW = 0 Or ( @iTableW = 1 And @iOkTableW = 1 ) )
  Begin
	Set @iRet = 60
	Set @asChaineRet = 'Le SAV est créé sous le numéro ' + @asNumSav + '.'

	Return @iRet	
  End 
Else 
  Begin
	Set @iRet = -160
	Set @asChaineRet = '[PROBLEME_TECHNIQUE] Problème technique lors de la création du SAV, contactez SPB.'

	Return @iRet	
  End 


Go

--------------------------------------------------------------------
-- Procédure            :       sysadm.PS_S_PM357_CREATION_SAV_REPA_ORIGINE
-- Auteur               :       Fabry JF
-- Date                 :       09/06/2017
-- Libellé              :		[PM357]
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF   15/12/2017   [PM357][MANTIS27369]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM357_CREATION_SAV_REPA_ORIGINE' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM357_CREATION_SAV_REPA_ORIGINE
GO

CREATE procedure sysadm.PS_S_PM357_CREATION_SAV_REPA_ORIGINE
	@adcIdSin	Decimal ( 10 ),
	@aiIdSeqRef	Integer,
	@asProbleme VarChar ( 255), 
	@aiRet		Integer,
	@asNumSav	VarChar ( 50 ) OUTPUT,
	@asChaineRet	Varchar (255)  OUTPUT
AS

Declare @iRet Integer
Declare @dcIdGti Decimal ( 7 )
Declare @dcIdDetailMax Decimal ( 7 )
Declare @dcMtValAchat Decimal ( 11, 2 )
Declare @dcMtValPublique Decimal ( 11, 2 )
Declare @iIdseqMax Integer
Declare @sNomAss VarChar (35)
Declare @sPrenomAss VarChar (35)
Declare @sAdr1Ass VarChar (35)
Declare @sAdr2Ass VarChar (35)
Declare @sAdrCpAss VarChar (5)
Declare @sAdrVilleAss VarChar (35)
Declare @sAdrMailAss VarChar ( 128 )
Declare @iTableW Integer
Declare @iOkTableW Integer
Declare @iOkTableP Integer
Declare @dcIdSav Decimal ( 10 )
Declare @sInfoSpbFrnClt VarChar ( 255 )
Declare @sMsgTemp VarChar ( 500 ) 
Declare @iIdCt Integer

Set @iTableW = 0
Set @iOkTableW = 0
Set @iOkTableP = 0

Select  @dcIdGti = c.id_gti
From	sysadm.commande c
Where   c.id_sin = @adcIdSin
And		c.id_seq = @aiIdSeqRef

Select  Top 1
		@dcMtValAchat = dt.mt_val_achat,
		@dcMtValPublique = dt.mt_val_publique
From    sysadm.detail dt
Where   dt.id_sin = @adcIdSin
And		dt.id_gti = @dcIdGti
And		dt.mt_val_achat > 0
And		dt.mt_val_achat <> 9999
And		dt.mt_val_publique > 0

Select @iIdseqMax = Max ( id_seq ) 
From   sysadm.commande c
Where  c.id_sin = @adcIdSin

Select  @sInfoSpbFrnClt = info_frn_spb_cplt
from	sysadm.commande 
where	id_sin = @adcIdSin 
And		id_seq = @aiIdSeqRef

If @sInfoSpbFrnClt is null Set @sInfoSpbFrnClt = ''
Set @sInfoSpbFrnClt = replace ( @sInfoSpbFrnClt, 'A_REPARER_SAV=OUI', '' )
Set @sInfoSpbFrnClt = replace ( @sInfoSpbFrnClt, 'A_DESOXYDER_SAV=OUI', '' )
Set @sInfoSpbFrnClt = replace ( @sInfoSpbFrnClt, 'A_CONTROLER_SAV=OUI', '' )
Set @sInfoSpbFrnClt = sysadm.FN_CLE_VAL_E ( 'CPT_REL_PM95', '0', rtrim ( ltrim ( @sInfoSpbFrnClt ) ), ';' )
Set @sInfoSpbFrnClt = replace ( @sInfoSpbFrnClt, 'CPT_REL_PM95=0', '' )
Set @sInfoSpbFrnClt = sysadm.FN_CLE_VAL_E ( 'ALERTE', '0', rtrim ( ltrim ( @sInfoSpbFrnClt ) ), ';' )
Set @sInfoSpbFrnClt = replace ( @sInfoSpbFrnClt, 'ALERTE=0', '' )
Set @sInfoSpbFrnClt = sysadm.FN_CLE_VAL_E ( 'MT_PREFACT', '0', rtrim ( ltrim ( @sInfoSpbFrnClt ) ), ';' )
Set @sInfoSpbFrnClt = replace ( @sInfoSpbFrnClt, 'MT_PREFACT=0', '' )

If @aiRet = 35 Set @sInfoSpbFrnClt = sysadm.FN_CLE_VAL_E ( 'A_CONTROLER_SAV', 'OUI', rtrim ( ltrim ( @sInfoSpbFrnClt ) ), ';' )
If @aiRet = 40 Set @sInfoSpbFrnClt = sysadm.FN_CLE_VAL_E ( 'A_DESOXYDER_SAV', 'OUI', rtrim ( ltrim ( @sInfoSpbFrnClt ) ), ';' )
If @aiRet = 50 Set @sInfoSpbFrnClt = sysadm.FN_CLE_VAL_E ( 'A_REPARER_SAV', 'OUI', rtrim ( ltrim ( @sInfoSpbFrnClt ) ), ';' )

-- En dernier absolument
While CharIndex ( ';;', @sInfoSpbFrnClt ) > 0 
 Begin
	Set @sInfoSpbFrnClt = replace ( @sInfoSpbFrnClt, ';;', ';' )
 End

If @iIdseqMax is null Set @iIdseqMax = 0
Set @iIdseqMax = @iIdseqMax + 1

Select 	@sNomAss = p.nom,
		@sPrenomAss = p.prenom,
		@sAdr1Ass = p.adr_1,
		@sAdr2Ass = p.adr_2,
		@sAdrCpAss = p.adr_cp,
		@sAdrVilleAss = p.adr_ville
From	sysadm.sinistre s,
		sysadm.personne p
Where   s.id_sin = @adcIdSin
And		p.id_ordre = s.id_ordre

Select  @sAdrMailAss = ltrim ( rtrim ( i.adr_mail )) 
From	sysadm.inter i
Where   i.id_sin = @adcIdSin
And     i.cod_inter = 'A'

If @sAdrMailAss is null set @sAdrMailAss = ''

-- Création si prsence w_sin
If Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin ) 
 Begin

	Set @iTableW = 1

	Select @dcIdDetailMax = Max ( wd.id_detail  )
	From   sysadm.w_detail wd
	Where  wd.id_sin = @adcIdSin
	and    wd.id_gti = @dcIdGti 

	IF @dcIdDetailMax is null Set @dcIdDetailMax = 0
	Set @dcIdDetailMax = @dcIdDetailMax  + 1

	-- w_detail
	Insert into sysadm.w_detail
	Select 
		wd.id_sin,
		wd.id_gti,
		@dcIdDetailMax,
		wd.id_evt,
		wd.lib_det,
		wd.dte_det,
		wd.heu_det,
		wd.num_carte,
		0 'wd.mt_prej',
		0 'wd.mt_fran',
		0 'wd.mt_nplaf',
		0 'wd.mt_plaf',
		null 'wd.id_i_reg',
		'N' 'wd.alt_bloc',
		'N' 'wd.alt_cour',
		'N' 'wd.alt_plaf',
		'N' 'wd.alt_reg',
		'O' 'wd.alt_att',
		'N' 'wd.alt_valide',
		1 'wd.cpt_valide',
		'N' 'wd.alt_ssui',
		0 'wd.cod_mot_ssui',
		100 'wd.cod_dec_mac',
		100 'wd.cod_dec_ope',
		100 'wd.cod_etat',
		wd.id_carte,
		wd.id_type_carte,
		Getdate () 'wd.cree_le',
		Getdate () 'wd.maj_le',
		'AUTO' 'wd.maj_par',
		null 'wd.dte_cmd',
		null 'wd.dte_livr',
		wd.mt_val_achat,
		wd.mt_val_publique,
		'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' 'wd.num_facture'
	From sysadm.w_detail wd,
		 sysadm.w_commande wc
	Where wc.id_sin = @adcIdSin
	And	  wc.id_seq = @aiIdSeqRef
	And   wd.id_sin = wc.id_sin
	And   wd.id_gti = wc.id_gti
	And   wd.id_detail = wc.id_detail

	-- w_div_det
	Insert into sysadm.w_div_det
	Select 
		wdd.id_sin,
		wdd.id_gti,
		@dcIdDetailMax,
		wdd.nom_zone,
		wdd.lib_label,
		wdd.id_typ_liste,
		wdd.alt_liste_codecar,
		wdd.id_typ_zone,
		wdd.alt_oblig,
		wdd.alt_prot,
		wdd.cpt_tri,
		wdd.val_nbre,
		wdd.val_mt,
		wdd.val_dte,
		wdd.val_car,
		1 'wdd.cpt_valide',
		Getdate() 'wdd.cree_le',
		Getdate() 'wdd.maj_le',
		'AUTO' 'wdd.maj_par'
	From sysadm.w_div_det wdd,
		 sysadm.w_commande wc
	Where wc.id_sin = @adcIdSin
	And	  wc.id_seq = @aiIdSeqRef
	And   wdd.id_sin = wc.id_sin
	And   wdd.id_gti = wc.id_gti
	And   wdd.id_detail = wc.id_detail


	-- Passé par un Insert/Select de la presta initiale
	Insert sysadm.w_commande 
	Select  
		id_sin,
		@iIdseqMax 'id_seq',
		id_gti,
		@dcIdDetailMax 'id_detail',
		id_four,
		id_typ_art,
		id_marq_art,
		id_modl_art,
		mt_ttc_cmde,
		adr_nom,
		adr_prenom,
		adr_livr1,
		adr_livr2,
		adr_livr_cpl,
		adr_cp,
		adr_ville,
		adr_tel1,
		adr_tel2,
		adr_tel3,
		adr_mail,
		dte_rdv_cli,
		hrdv_cli_min,
		hrdv_cli_max,
		id_serie_anc,
		@asProbleme 'probleme',
		null 'id_cmd_frn',
		null 'id_serie_nouv',
		null 'id_bon_transp',
		null 'dte_rcp_frn',
		null 'dte_env_cli',
		'ECT' 'cod_etat',
		null 'comment_frn',
		1 'cpt_valide',
		'AUTO' 'nom_gest',
		GetDate() 'cree_le',
		GetDate() 'maj_le',
		'AUTO' 'maj_par',
		id_zone,
		id_bsp,
		dte_ret_pret,
		adr_cod_civ,
		id_ref_four,
		id_orian_marque,
		0 'id_orian_modele',
		dte_elv_mobile,
		0 'status_gc',
		dte_emis_devis,
		mt_devis,
		alt_dev_acp,
		dte_dev_acp,
		adrfc_cod_civ,
		null 'adrfc_nom',
		adrfc_prenom,
		adrfc_livr1,
		adrfc_livr2,
		adrfc_livr_cpl,
		adrfc_cp,
		adrfc_ville,
		dte_ret_logis,
		dte_ret_pret_min,
		dte_ret_pret_max,
		id_ann,
		dte_env_bte_frn,
		dte_rcp_bte_cli,
		dte_dep_bte_cli,
		dte_env_st,
		dte_rcp_mob_cli,
		info_spb_frn,
		id_marq_art_ifr,
		id_modl_art_ifr,
		@sInfoSpbFrnClt 'info_spb_frn_cplt',
		''
	from	sysadm.w_commande 
	where	id_sin = @adcIdSin 
	And		id_seq = @aiIdSeqRef
 End


-- Pas de test pour la présence dans sinistre, car on ne serait pas arriver jusque là sinon.
Select @dcIdDetailMax = Max ( d.id_detail )
From   sysadm.detail d
Where  d.id_sin = @adcIdSin
and    d.id_gti = @dcIdGti 

IF @dcIdDetailMax is null Set @dcIdDetailMax = 0
Set @dcIdDetailMax = @dcIdDetailMax + 1

-- detail
Insert into sysadm.detail
Select 
	wd.id_sin,
	wd.id_gti,
	@dcIdDetailMax,
	wd.id_evt,
	0,
	null,
	wd.lib_det,
	wd.dte_det,
	wd.heu_det,
	wd.num_carte,
	0 'wd.mt_prej',
	0 'wd.mt_fran',
	0 'wd.mt_nplaf',
	0 'wd.mt_plaf',
	'N' 'wd.alt_plaf',
	'N' 'wd.alt_reg',
	'O' 'wd.alt_att',
	'N' 'wd.alt_ssui',
	0 'wd.cod_mot_ssui',
	100 'wd.cod_dec_mac',
	100 'wd.cod_dec_ope',
	100 'wd.cod_etat',
	wd.id_carte,
	wd.id_type_carte,
	Getdate () 'wd.valide_le',
	'AUTO' 'wd.valide_par',
	Getdate () 'wd.cree_le',
	Getdate () 'wd.maj_le',
	'AUTO' 'wd.maj_par',
	null 'wd.dte_cmd',
	null 'wd.dte_livr',
	wd.mt_val_achat,
	wd.mt_val_publique,
	'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' 'wd.num_facture'
From sysadm.detail wd,
		sysadm.commande wc
Where wc.id_sin = @adcIdSin
And	  wc.id_seq = @aiIdSeqRef
And   wd.id_sin = wc.id_sin
And   wd.id_gti = wc.id_gti
And   wd.id_detail = wc.id_detail

-- div_det
Insert into sysadm.div_det
Select 
	wdd.id_sin,
	wdd.id_gti,
	@dcIdDetailMax,
	wdd.nom_zone,
	wdd.lib_label,
	wdd.id_typ_liste,
	wdd.alt_liste_codecar,
	wdd.id_typ_zone,
	wdd.alt_oblig,
	wdd.alt_prot,
	wdd.cpt_tri,
	wdd.val_nbre,
	wdd.val_mt,
	wdd.val_dte,
	wdd.val_car,
	Getdate(),
	Getdate(),
	'AUTO',
	Getdate(),
	'AUTO'
From sysadm.div_det wdd,
		sysadm.commande wc
Where wc.id_sin = @adcIdSin
And	  wc.id_seq = @aiIdSeqRef
And   wdd.id_sin = wc.id_sin
And   wdd.id_gti = wc.id_gti
And   wdd.id_detail = wc.id_detail


-- Passé par un Insert/Select de la presta initiale
Insert sysadm.commande 
Select  
	id_sin,
	@iIdseqMax 'id_seq',
	id_gti,
	@dcIdDetailMax 'id_detail',
	id_four,
	id_typ_art,
	id_marq_art,
	id_modl_art,
	mt_ttc_cmde,
	adr_nom,
	adr_prenom,
	adr_livr1,
	adr_livr2,
	adr_livr_cpl,
	adr_cp,
	adr_ville,
	adr_tel1,
	adr_tel2,
	adr_tel3,
	adr_mail,
	dte_rdv_cli,
	hrdv_cli_min,
	hrdv_cli_max,
	id_serie_anc,
	@asProbleme 'probleme',
	null 'id_cmd_frn',
	null 'id_serie_nouv',
	null 'id_bon_transp',
	null 'dte_rcp_frn',
	null 'dte_env_cli',
	'ECT' 'cod_etat',
	null 'comment_frn',
	'AUTO' 'nom_gest',
	0 'id_lot_cmd',
	null 'cmd_gen_le',
	null 'cmd_gen_par',
	Getdate(),
	Getdate(),
	'AUTO',
	Getdate(),
	'AUTO',
	id_zone,
	id_bsp,
	dte_ret_pret,
	adr_cod_civ,
	id_ref_four,
	id_orian_marque,
	0 'id_orian_modele',
	dte_elv_mobile,
	0 'status_gc',
	dte_emis_devis,
	mt_devis,
	alt_dev_acp,
	dte_dev_acp,
	adrfc_cod_civ,
	null 'adrfc_nom',
	adrfc_prenom,
	adrfc_livr1,
	adrfc_livr2,
	adrfc_livr_cpl,
	adrfc_cp,
	adrfc_ville,
	dte_ret_logis,
	dte_ret_pret_min,
	dte_ret_pret_max,
	id_ann,
	dte_env_bte_frn,
	dte_rcp_bte_cli,
	dte_dep_bte_cli,
	dte_env_st,
	dte_rcp_mob_cli,
	info_spb_frn,
	id_marq_art_ifr,
	id_modl_art_ifr,
	@sInfoSpbFrnClt 'info_spb_frn_cplt',
	''
from	sysadm.commande 
where	id_sin = @adcIdSin 
And		id_seq = @aiIdSeqRef
 
-- Création du numéro SAV
EXEC sysadm.PS_X_INCREMENTER 'ID_SAV', @dcIdSav OUTPUT 
Insert into sysadm.sav_frn ( 
   id_sav,
   id_sin,
   id_seq,
   cree_le,
   maj_le,
   maj_par
   )
Values 
   (
   @dcIdSav,
   @adcIdSin,
   @iIdseqMax,
   GetDate(),
   Getdate(),
   'AUTO'
   )


Set @asNumSav = convert ( Varchar, @dcIdSav )
Set @asNumSav = reverse ( @asNumSav )
Set @asNumSav = Left ( @asNumSav, 3 ) + 'A' + Substring ( @asNumSav, 4, Len ( @asNumSav ) )
Set @asNumSav = reverse ( @asNumSav )

-- test de controle avant le renvoi OK
IF @iTableW = 1 
 Begin 
	If Exists ( 
		Select Top 1 1
		From  sysadm.w_detail d,
			  sysadm.w_div_det dd,
			  sysadm.w_commande c,
			  sysadm.sav_frn sf
		Where d.id_sin = @adcIdSin
		And	  d.id_gti = @dcIdGti
		And   d.id_detail = @dcIdDetailMax
		And   dd.id_sin = d.id_sin
		And   dd.id_gti = d.id_gti
		And   dd.id_detail = d.id_detail 
		And   c.id_sin = d.id_sin
		And   c.id_gti = d.id_gti
		And   c.id_detail = d.id_detail
		And   sf.id_sin = c.id_sin
		And   sf.id_seq  = c.id_seq
			) 
		Begin
			Set @iOkTableW = 1
		End 

 End 

If Exists ( 
		Select Top 1 1
		From  sysadm.detail d,
			  sysadm.div_det dd,
			  sysadm.commande c,
			  sysadm.sav_frn sf
		Where d.id_sin = @adcIdSin
		And	  d.id_gti = @dcIdGti
		And   d.id_detail = @dcIdDetailMax
		And   dd.id_sin = d.id_sin
		And   dd.id_gti = d.id_gti
		And   dd.id_detail = d.id_detail 
		And   c.id_sin = d.id_sin
		And   c.id_gti = d.id_gti
		And   c.id_detail = d.id_detail
		And   sf.id_sin = c.id_sin
		And   sf.id_seq  = c.id_seq
		) 
	Begin
		Set @iOkTableP = 1 
	End 

If @iOkTableP = 1 And ( @iTableW = 0 Or ( @iTableW = 1 And @iOkTableW = 1 ) )
  Begin
	Set @iRet = 60
	Set @asChaineRet = 'Le SAV est créé sous le numéro ' + @asNumSav + '.'

	Return @iRet	
  End 
Else 
  Begin
	Set @iRet = -160
	Set @asChaineRet = '[PROBLEME_TECHNIQUE] Problème technique lors de la création du SAV, contactez SPB.'

	Return @iRet	
  End 

Go


--------------------------------------------------------------------
-- Procédure            :       PS_S_PM357_LECTURE_SAV_EXISTANT
-- Auteur               :       Fabry JF
-- Date                 :       09/06/2017
-- Libellé              :		[PM357]
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-- 09/08/2017   JFF  [PM357-1][MANTIS25852]
-- 22/12/2017   JFF  [PM357-1][MANTIS27405]
-- 22/12/2017   JFF  [PM357-1][MANTIS27327]
-- 21/11/2018   JFF  [VDOC27123]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM357_LECTURE_SAV_EXISTANT' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM357_LECTURE_SAV_EXISTANT
GO

CREATE procedure sysadm.PS_S_PM357_LECTURE_SAV_EXISTANT
	@asdcIdSinOuSav	VarChar ( 20 ),
	@asNumLigne		VarChar ( 20 ),
	@asChaineBCV	VarChar ( 255 ) OUTPUT, -- armé toujours à 255 espaces.
	@asChaineRet	Varchar (255)  OUTPUT -- armé toujours à 255 espaces.
AS

Declare @iRet Integer 
Declare @sIdSin  VarChar ( 10 )
Declare @dcIdSin Decimal ( 10 )
Declare @sNumSav VarChar ( 50 )
Declare @sMarqIfrAppRef VarChar ( 35 )
Declare @sModlIfrAppRef VarChar ( 35 )
Declare @sImeiAppRef    VarChar ( 35 )
Declare @iIdSeqSav Integer 
Declare @iIdCli integer -- [PM357-1][MANTIS25852]

Set @asChaineBCV = sysadm.FN_CLE_VAL_E  ( 'APPEL_LECT', 'OUI', rtrim ( ltrim ( @asChaineBCV  )), ';')
Set @asChaineBCV = Left ( @asChaineBCV + Space ( 255 ), 255 ) 
Set @asChaineRet = Space ( 255 ) 

Exec @iRet = sysadm.PS_S_PM357_CTRLE_CONNEXION @asdcIdSinOuSav, @asNumLigne, @asChaineBCV OUTPUT, @asChaineRet OUTPUT

If @iRet Not in ( -45, -47, -115 ) 
  Begin
	Set @iRet = -40
	Set @asChaineRet = 'Aucun dossier n''a été trouvé ayant une correspondance entre N°Sinistre/N°Sav ET le numéro de ligne.'

	-- [PM357][MANTIS27369]
	Exec sysadm.PS_I_PM357_CREATION_CONTACT	@dcIdSin, @iRet, 42, @asChaineRet
	-- /[PM357][MANTIS27369]

	Return @iRet
  End 

Set @sIdSin = sysadm.FN_CLE_VAL ( 'ID_SIN', @asChaineBCV, ';' )
Set @dcIdSin = convert ( decimal ( 10 ), @sIdSin )
Set @iIdSeqSav = sysadm.FN_CLE_VAL ( 'ID_SEQ_SAV', @asChaineBCV, ';' )

Select @sNumSav = Convert( varchar, id_sav )
From sysadm.sav_frn
Where id_sin = @dcIdSin
And   id_seq = @iIdSeqSav

If @sNumSav is null Set @sNumSav = ''

Set @sNumSav = reverse ( @sNumSav )
Set @sNumSav = Left ( @sNumSav, 3 ) + 'A' + Substring ( @sNumSav, 4, Len ( @sNumSav ) )
Set @sNumSav = reverse ( @sNumSav )


If Exists ( 
		Select Top 1 1 
		From sysadm.commande c
		Where c.id_sin = @dcIdSin
		And   c.id_seq = @iIdSeqSav
		And   sysadm.FN_CLE_VAL ( 'A_REP_GARANTIE', c.info_spb_frn_cplt, ';' ) = 'OUI'
	) 
	Begin
		Select Top 1 
				@sMarqIfrAppRef = rtrim ( c.id_marq_art_ifr ),
				@sModlIfrAppRef = rtrim ( c.id_modl_art_ifr ),
				@sImeiAppRef    = rtrim ( c.id_serie_nouv )
		From sysadm.commande c
		Where c.id_sin = @dcIdSin
		And   c.id_four = 'O2M'
		And   c.status_gc <> 176
		And   c.cod_etat in ( 'RFO', 'RPC' )
		And	  sysadm.FN_A_COMMANDER ( c.id_sin, c.id_seq, 'P' ) = 'A_COMMANDER'
		And   c.id_seq = (  Select max ( id_seq ) 
							From sysadm.commande c1
							Where c1.id_sin = c.id_sin
							And   c1.id_four = c.id_four
							And   c1.status_gc <> 176
							And   c1.cod_etat in ( 'RFO', 'RPC' )
							And	  sysadm.FN_A_COMMANDER ( c1.id_sin, c1.id_seq, 'P' ) = 'A_COMMANDER'
							)
	End 
Else
	Begin
		Select  @sMarqIfrAppRef = s.marq_port,
				@sModlIfrAppRef = s.modl_port,
				@sImeiAppRef    = s.num_imei_port
		From   sysadm.sinistre s
		Where  s.id_sin = @dcIdSin
	End 


-- [PM357-1][MANTIS25852]
		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Select Top 1 @iIdCli = s.id_cli
			From   SHERPA_PRO.sysadm.sinistre s
			Where  s.id_sin = @dcIdSin
		END
		ELSE
		BEGIN
			Select Top 1 @iIdCli = s.id_cli
			From   SHERPA_SIM.sysadm.sinistre s
			Where  s.id_sin = @dcIdSin
		END
-- /[PM357-1][MANTIS25852]

-- Select Final pour le site, pas d'autres select dérrière.
Select	-- [PM357-1][MANTIS27327]
		sysadm.FN_CODE_NUM ( p.cod_civ, '-CI' ) 'Civilite_Courte',
		sysadm.FN_CODE_NUM ( p.cod_civ, '-CL' ) 'Civilite_Longue',
		-- /[PM357-1][MANTIS27327]
		rtrim ( p.nom ) 'Nom_assuré',
		rtrim ( p.prenom ) 'Prénom_assuré',
		rtrim ( p.adr_1 ) 'adr1_assure',
		rtrim ( p.adr_2 ) 'adr2_assure',
		rtrim ( p.adr_cp ) 'adr_cp_assure',
		rtrim ( p.adr_ville ) 'adr_ville_assure',
		s.num_port 'num_tel_app_sinistré',
		( Select rtrim ( i.num_teld )
		  From sysadm.inter i
		  Where i.id_sin = @dcIdSin
		  And   i.cod_inter = 'A'
		) 'Autre_num_tel_assuré',
		( Select rtrim ( i.adr_mail)
		  From sysadm.inter i
		  Where i.id_sin = @dcIdSin
		  And   i.cod_inter = 'A'
		) 'adr_mail_assuré',
		s.id_sin 'Référence_sinistre',
		c.id_seq 'Prestation_sav',
		@sNumSav 'Numéro_Sav',
		(	Select rtrim ( dp.val_car )
			From sysadm.det_pro dp
			Where dp.id_prod = s.id_prod
			And   dp.id_code_dp = 66
		) 'Lib_prod_vu_assuré',
		(	Select rtrim ( dp.val_car )
			From sysadm.det_pro dp
			Where dp.id_prod = s.id_prod
			And   dp.id_code_dp = 67
		) 'Lib_opt_prod_vu_assuré',
		sysadm.FN_LIB_PROD ( s.id_prod ) 'Lib_prod_vu_SPB',
		( Select Top 1 rtrim ( cg.lib_gti )
		  From sysadm.code_garantie cg
		  Where cg.id_prod = s.id_prod
		  And   cg.id_gti = c.id_gti
		) 'Lib_garantie',
		@sMarqIfrAppRef	'Marque_app_de_référence',
		@sModlIfrAppRef 'Modèle_app_de_référence',
		@sImeiAppRef 'IMEI_app_de_référence', -- [PM357-1][MANTIS25852]
		@iIdCli 'Id_Client_Sherpa', -- [PM357-1][MANTIS25852]
		s.dte_decl 'Date_Décla_sinistre',
		c.cree_le 'Date_Création_SAV', -- [PM357-1][MANTIS25852]
		c.dte_rcp_frn 'Date_Reception_app_SAV', -- [PM357-1][MANTIS25852]
		Case c.cod_etat 
			When 'ANN' Then c.maj_le
			Else c.dte_env_cli 
		End 'Date_cloture_sav',
		c.status_gc 'Statut_technique',
		Case c.status_gc
			When 0 Then 'En cours' 
			Else sysadm.FN_CODE_NUM ( c.status_gc, '-GC' ) 
		End 'Lib_statut_technique',
		Case 
			When c.cod_etat = 'ANN' Then 'Prestation annulée' 
			When c.cod_etat in ( 'RFO', 'RPC' ) Then 'Prestation fermée'
			When c.cod_etat in ( 'ECT', 'RCF', 'ECL' ) Then 'En cours'
			Else sysadm.FN_CODE_NUM ( c.status_gc, '-EC' ) 
		End 'Lib_état',
		-- [PM357-1][MANTIS27405]
		Case 
			-- [VDOC27123]BVID/BVIP/BVIT
			When c.status_gc = 21 And ( CHARINDEX ( '[BVIE]', c.comment_frn ) > 0 Or CHARINDEX ( '[BVID]', c.comment_frn ) > 0 Or CHARINDEX ( '[BVIP]', c.comment_frn ) > 0 Or CHARINDEX ( '[BVIT]', c.comment_frn ) > 0 ) 
				Then 'OUI'
			-- [VDOC27123]BVID/BVIP/BVIT
			When c.status_gc = 21 And ( CHARINDEX ( '[BVIE]', c.comment_frn ) > 0 Or CHARINDEX ( '[BVID]', c.comment_frn ) > 0 Or CHARINDEX ( '[BVIP]', c.comment_frn ) > 0 Or CHARINDEX ( '[BVIT]', c.comment_frn ) > 0 ) 
				Then 'SC'
			When c.status_gc <> 21  
				Then 'NC'
			Else 'NC'
		End 'Irrep_Couvert',
		s.id_prod 'Code_Produit'
		-- /[PM357-1][MANTIS27405]

From  sysadm.sinistre s,
	  sysadm.commande c,
	  sysadm.personne p 

Where c.id_sin = @dcIdSin
And   c.id_seq = @iIdSeqSav
And	  s.id_sin = c.id_sin
And   p.id_ordre = s.id_ordre


Set @iRet = 70
Set @asChaineRet = 'Consultation SAV Ok.'

-- [PM357][MANTIS27369]
Exec sysadm.PS_I_PM357_CREATION_CONTACT	@dcIdSin, @iRet, 42, @asChaineRet
-- /[PM357][MANTIS27369]

Return @iRet

Go


--------------------------------------------------------------------
-- Procédure            :       PS_S_PM357_MAJ_PARTIELLE
-- Auteur               :       Fabry JF
-- Date                 :       11/12/2017
-- Libellé              :		[PM357]
-- Commentaires         :       [PM357-1][MANTIS27318]
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM357_MAJ_PARTIELLE' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM357_MAJ_PARTIELLE
GO

CREATE procedure sysadm.PS_S_PM357_MAJ_PARTIELLE
	@asdcIdSinOuSav	VarChar ( 20 ),
	@asNumLigne		VarChar ( 20 ),
	@asChaineBCV	VarChar ( 255 ) OUTPUT, -- armé toujours à 255 espaces.
	@asChaineRet	Varchar (255)  OUTPUT -- armé toujours à 255 espaces.
AS

Declare @iRet Integer
Declare @iIdSeqRef Integer
Declare @dcIdSin Decimal ( 10 )
Declare @asChaineBCVOrig VarChar ( 255 )
Declare @iIdCt Integer
Declare @sMsgTemp VarChar ( 500 ) 

Set @asChaineBCVOrig = @asChaineBCV

Exec @iRet = sysadm.PS_S_PM357_CTRLE_CONNEXION @asdcIdSinOuSav, @asNumLigne, @asChaineBCV OUTPUT, @asChaineRet OUTPUT

If @iRet in ( 30, 35, 40, 50 ) 
 Begin
	Set @dcIdSin = sysadm.FN_CLE_VAL ( 'ID_SIN', @asChaineBCV, ';' )
	Set @iIdSeqRef = sysadm.FN_CLE_VAL ( 'ID_SEQ_REF', @asChaineBCV, ';' )

	If sysadm.FN_CLE_VAL ( 'AUTO_DIAG_PM357', @asChaineBCVOrig, ';' ) = 'FAIT'
	 Begin
		Update sysadm.commande 
		Set info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'AUTO_DIAG_PM357', 'FAIT', rtrim ( info_spb_frn_cplt ), ';')
		WHere id_sin = @dcIdSin
		And   id_seq = @iIdSeqRef

		If @@ROWCOUNT <> 1 
		 Begin
			Set @iRet = -170
			Set @asChaineRet = '[PROBLEME_TECHNIQUE] Impossible de faire la mise à jour partielle, contactez SPB.'

			-- [PM357][MANTIS27369]
			Exec sysadm.PS_I_PM357_CREATION_CONTACT	@dcIdSin, @iRet, 43, @asChaineRet
			-- /[PM357][MANTIS27369]

			Return @iRet
		 End  

		If Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @dcIdSin ) 
		  Begin

			Update sysadm.w_commande 
			Set info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'AUTO_DIAG_PM357', 'FAIT', rtrim ( info_spb_frn_cplt ), ';')
			WHere id_sin = @dcIdSin
			And   id_seq = @iIdSeqRef

			If @@ROWCOUNT <> 1 
			 Begin
				Set @iRet = -170
				Set @asChaineRet = '[PROBLEME_TECHNIQUE] Impossible de faire la mise à jour partielle, contactez SPB.'

				-- [PM357][MANTIS27369]
				Exec sysadm.PS_I_PM357_CREATION_CONTACT	@dcIdSin, @iRet, 43, @asChaineRet
				-- /[PM357][MANTIS27369]

				Return @iRet
			 End  
		  End

		Set @sMsgTemp = 'Attention, une tentative de création d''un SAV par l''assuré via l''extranet SAV a eu lieu.'
		Set @sMsgTemp = @sMsgTemp + ' Suite à l''auto-diagnostic l''assuré a stoppé sa déclaration de SAV.'

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, 42, 'C', @dcIdSin, 2, @sMsgTemp,	'WEB', 300, @iIdCt OUTPUT							
		END
		ELSE
		BEGIN
			Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, 42, 'C', @dcIdSin, 2, @sMsgTemp,	'WEB', 300, @iIdCt OUTPUT							
		END	

	 End 

 End 
Else
 Begin
	Set @iRet = -171
	Set @asChaineRet = 'Le dossier n''est pas éligible à la création d''un SAV, la mise à jour partielle n''est donc pas autorisée.'

	-- [PM357][MANTIS27369]
	Exec sysadm.PS_I_PM357_CREATION_CONTACT	@dcIdSin, @iRet, 43, @asChaineRet
	-- /[PM357][MANTIS27369]

	Return @iRet
 End 

Set @iRet = 80
Set @asChaineRet = 'Mise à jour partielle effectuée'

-- [PM357][MANTIS27369]
Exec sysadm.PS_I_PM357_CREATION_CONTACT	@dcIdSin, @iRet, 43, @asChaineRet
-- /[PM357][MANTIS27369]

Return @iRet

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_PM357_CREATION_CONTACT
-- Auteur               :       Fabry JF
-- Date                 :       15/12/2017
-- Libellé              :		[PM357]
-- Commentaires         :       [PM357-1][MANTIS27369]
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM357_CREATION_CONTACT' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM357_CREATION_CONTACT
GO

CREATE procedure sysadm.PS_I_PM357_CREATION_CONTACT
	@adcIdSin Decimal (10),
	@iRet     Integer,
	@iTypContact Integer,
	@asChaineRet VarChar (508)
As 

Declare @sMsgTemp VarChar ( 500 ) 
Declare @iIdCt Integer

-- [PM357][MANTIS27369]
Set @sMsgTemp = '[CODE=' + Convert ( VarChar, @iRet ) + '] : ' + @asChaineRet 
Set @sMsgTemp = LEFT ( @sMsgTemp, 508 )

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, @iTypContact, 'C', @adcIdSin, 2, @sMsgTemp,	'WEB', 300, @iIdCt OUTPUT							
END
ELSE
BEGIN
	Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, @iTypContact, 'C', @adcIdSin, 2, @sMsgTemp,	'WEB', 300, @iIdCt OUTPUT							
END	
-- /[PM357][MANTIS27369]

Go

