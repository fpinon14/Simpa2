-------------------------------------------------------------------
--
-- Fichier              :       DT386_EXTR_AXA.CP
-- Auteur               :       Fabry JF
-- Date                 :       15/05/2019
--
-- Commentaires         :       PS afférants aux DT386, automatisation AXA 6908, 6909 pour le BuyBack
--
-- sysadm.NI_PS_I_PC151379_TAG_COURRIER_PEC
-- sysadm.NI_PS_I_PC151379_TAG_COURRIER_REFUS
-- sysadm.NI_PS_S_PC151379_COUR_PEC
-- sysadm.NI_PS_U_PC151379_COUR_PEC
-- sysadm.PS_I_DT386_AUTOMATISATION_AXA
-- sysadm.PS_I_DT386_CREATION_PRESTA
-- sysadm.PS_I_DT386_DOSSIER_ELIGIBLE
-- sysadm.PS_I_DT386_DOSSIER_INTEGRE
-- sysadm.PS_I_DT386_ETAT_VALIDATION
-- sysadm.PS_I_DT386_PLAFOND_PEC
-- sysadm.PS_I_DT386_REFUS_601_V01
-- sysadm.PS_I_DT386_REFUS_602_V01
-- sysadm.PS_I_DT386_REFUS_603
-- sysadm.PS_I_DT386_REFUS_604_V01
-- sysadm.PS_I_DT386_REFUS_611_V01
-- sysadm.PS_I_DT386_REFUS_612_V01
-- sysadm.PS_I_DT386_REFUS_613_V01
-- sysadm.PS_I_DT386_REFUS_641_V01
-- sysadm.PS_I_DT386_REFUS_642_V01
-- sysadm.PS_I_DT386_REFUS_643_V01
-- sysadm.PS_I_DT386_REFUS_REVISION
-- sysadm.PS_I_DT386_REFUS_REVISION
-- sysadm.PS_I_DT386_REGLE_SPEC_ET_REFUS
-- sysadm.PS_I_DT386_REJET
-------------------------------------------------------------------

--------------------------------------------------------------------
-- Procédure            :       PS_I_DT386_AUTOMATISATION_AXA
-- Auteur               :       Fabry JF
-- Date                 :       15/05/2019
-- Libellé              :
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DT386_AUTOMATISATION_AXA' AND type = 'P' )
        DROP procedure sysadm.PS_I_DT386_AUTOMATISATION_AXA
GO

CREATE procedure sysadm.PS_I_DT386_AUTOMATISATION_AXA
	@adcIdSin   Decimal (10)
AS
	Declare @iRet Integer 
	Declare @iLigneSecondaire Integer 

-- [DEBUG]
-- Return -1

/*
Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Le DT386 est hors production', 'Le DT386 est hors production pour l''instant, l''automatisation du process AXA via EXTR_AXA/SIMPA2 est donc impossible pour le moment.'
Return -1
*/

-- Audit Assureur (Fraude)
-- On laisse exprès l'appel de la PS du PM234
Exec @iRet = sysadm.PS_S_PM234_7_AUDIT_ASSUREUR_ELSA @adcIdSin
If @iRet = -1 Return @iRet

-- Je n'ai pas besoin d'être sous transaction, en effet, personne ne peut écrire ni lire ces données fraîchement écrites par ATLAS.
-- Set Transaction Isolation level Read UnCommitted

-- Dossier éligible à l'automatisme
	Exec @iRet = sysadm.PS_I_DT386_DOSSIER_ELIGIBLE @adcIdSin
	If @iRet = -1 Return @iRet

-- Le dossier est-il intègre ? les données minimum nécessaire sont-elles présentes ?
	Exec @iRet = sysadm.PS_I_DT386_DOSSIER_INTEGRE @adcIdSin
	If @iRet = -1 Return @iRet

-- Contrôle des régles spéciales/refus
	Exec @iRet = sysadm.PS_I_DT386_REGLE_SPEC_ET_REFUS @adcIdSin
	If @iRet = -1 Return @iRet

	-- [DF005-1-LOT2]
	If @iRet = 2
	 Begin
	   /* A débloquer s'il y avait un jour des courrier de refus auto avec validation
		Exec sysadm.PS_I_PC151379_TAG_COURRIER_REFUS @adcIdSin, 'REFUS_AUTO'

		If @iRet = -1 Return @iRet

		Exec @iRet = sysadm.PS_I_PC151379_ETAT_VALIDATION @adcIdSin, -1, 'CAS=REFUS_AUTO'  -- -1 car la ligne n'est pas traité sur le refus
		If @iRet = -1 Return @iRet
	  */
		Return

	 End 

-- Création de la pec/Plafond (Refus plafond)
	Exec @iRet = sysadm.PS_I_DT386_PLAFOND_PEC @adcIdSin
	If @iRet = -1 Return @iRet

-- Création de la prestation
	Exec @iRet = sysadm.PS_I_DT386_CREATION_PRESTA @adcIdSin
	If @iRet = -1 Return @iRet

-- Création de l'état/status/validation.
-- [DF005]
-- [DF005-1-LOT3]
	Exec @iRet = sysadm.PS_I_DT386_ETAT_VALIDATION @adcIdSin, @iLigneSecondaire, ''
	If @iRet = -1 Return @iRet

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_DT386_DOSSIER_ELIGIBLE
-- Auteur               :       Fabry JF
-- Date                 :       15/05/2019
-- Libellé              :
-- Commentaires         :      
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DT386_DOSSIER_ELIGIBLE' AND type = 'P' )
        DROP procedure sysadm.PS_I_DT386_DOSSIER_ELIGIBLE
GO

CREATE procedure sysadm.PS_I_DT386_DOSSIER_ELIGIBLE
	@adcIdSin   Decimal (10)
AS

	-- [PM369-2_MANTIS24885]
	Declare @dtValideLe DateTime
	Set @dtValideLe = GetDate()
	Exec sysadm.PS_IU_PIECE_HISTO @adcIdSin, @dtValideLe

	-- Suite cas de décla en minuscule
	Update sysadm.w_sin 
	Set marq_port = Upper ( marq_port ),
		modl_port = Upper ( modl_port) 
	Where id_sin = @adcIdSin

	-- Si présence d'un travail, rejet
	If Exists ( Select Top 1 1 From sysadm.w_queue where id_sin = Convert ( VarChar ( 10 ), @adcIdSin ) )
		Begin
/*
			Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Présence d''un travail', 'La présence d''un travail a été détectée, or pour que ce système fonctionne, ATLAS ne doit pas créer le travail. Cas non éligible à l''automatisation du process AXA via EXTR_AXA/SIMPA2.'
			Return -1
*/
			-- [MANTIS23199]
			Delete sysadm.w_queue Where id_sin = @adcIdSin
			Update sysadm.routage Set alt_queue = 'N' Where id_sin = @adcIdSin
		End 

	-- Option -dp/332 absente
	If Not Exists ( 
			Select	Top 1 1 
			From	sysadm.w_sin ws,
					sysadm.det_pro dp
			Where	ws.id_sin = @adcIdSin
			And		dp.id_prod = ws.id_prod
			And		dp.id_code_dp = 335
		) 
		Begin
			Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Produit non éligible, dp335 absente', 'Ce produit de sinistre n''est pas éligible à l''automatisation du process AXA via EXTR_AXA/SIMPA2.'
			Return -1
		End		

	-- Cpt_Valide w_sin > 0
	If Exists ( 
			Select	Top 1 1 
			From	sysadm.w_sin ws
			Where	ws.id_sin = @adcIdSin
			And		ws.cpt_valide > 0
		) 
		Begin
			Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'cpt_valide > 0', 'Ce dossier a déjà subi une validation, il n''est donc pas éligible à l''automatisation du process AXA via EXTR_AXA/SIMPA2.'
			Return -1
		End		

	-- Garantie autorisée au système
	If Not Exists ( 
			Select	Top 1 1 
			From	sysadm.w_gar_sin wg,
					sysadm.w_sin ws,
					sysadm.code_garantie cg
			Where	wg.id_sin = @adcIdSin
			And		wg.id_gti in ( 54 )
			And		ws.id_sin = wg.id_sin
			And     cg.id_prod = ws.id_prod
			And		cg.id_gti = wg.id_gti
		) 
		Begin
			-- sinon le GT est bloqué pour mettre sans suite si GTI absente du param
			
			-- [DF005-2]
			If Not Exists ( 
				Select  Top 1 1 
				From	sysadm.w_refus wr,
						sysadm.w_sin ws,
						sysadm.code_garantie cg
				Where   wr.id_sin = @adcIdSin
				And     wr.alt_ope = 'O'
				And     ws.id_sin = wr.id_sin
				And     cg.id_prod = ws.id_prod
				And		cg.id_gti = wr.id_gti
			)
			Begin
				Delete sysadm.w_div_det 
				From   sysadm.w_sin s,
						sysadm.w_div_det w
				where s.id_sin = @adcIdSin 
				And   w.id_sin = s.id_sin
				And   Not Exists ( 
					Select Top 1 1 
					From   sysadm.code_garantie cg
					Where  cg.id_prod = s.id_prod
					And    cg.id_gti  = w.id_gti
				)

				Delete sysadm.w_refus 
				From   sysadm.w_sin s,
						sysadm.w_refus w
				where s.id_sin = @adcIdSin 
				And   w.id_sin = s.id_sin
				And   Not Exists ( 
					Select Top 1 1 
					From   sysadm.code_garantie cg
					Where  cg.id_prod = s.id_prod
					And    cg.id_gti  = w.id_gti
				)


				Delete sysadm.w_piece 
				From   sysadm.w_sin s,
						sysadm.w_piece w
				where s.id_sin = @adcIdSin 
				And   w.id_sin = s.id_sin
				And   Not Exists ( 
					Select Top 1 1 
					From   sysadm.code_garantie cg
					Where  cg.id_prod = s.id_prod
					And    cg.id_gti  = w.id_gti
				)

				Delete sysadm.w_detail 
				From   sysadm.w_sin s,
						sysadm.w_detail w
				where s.id_sin = @adcIdSin 
				And   w.id_sin = s.id_sin
				And   Not Exists ( 
					Select Top 1 1 
					From   sysadm.code_garantie cg
					Where  cg.id_prod = s.id_prod
					And    cg.id_gti  = w.id_gti
				)

				Delete sysadm.w_detail 
				From   sysadm.w_sin s,
						sysadm.w_detail w
				where s.id_sin = @adcIdSin 
				And   w.id_sin = s.id_sin
				And   Not Exists ( 
					Select Top 1 1 
					From   sysadm.code_garantie cg
					Where  cg.id_prod = s.id_prod
					And    cg.id_gti  = w.id_gti
				)


				Delete sysadm.w_gar_sin 
				From   sysadm.w_sin s,
						sysadm.w_gar_sin w
				where s.id_sin = @adcIdSin 
				And   w.id_sin = s.id_sin
				And   Not Exists ( 
					Select Top 1 1 
					From   sysadm.code_garantie cg
					Where  cg.id_prod = s.id_prod
					And    cg.id_gti  = w.id_gti
				)

				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Garantie non éligible', 'La garantie déclarée sur ce sinistre n''est pas éligible à l''automatisation du process AXA via EXTR_AXA/SIMPA2.'
				Return -1
			End

		End		

	-- Une seule Garantie.
	If ( 
			Select	count (*)
			From	sysadm.w_gar_sin wg
			Where	wg.id_sin = @adcIdSin
		) <> 1
		Begin
			Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Trop de garantie (1 max)', 'Le sinistre ne doit avoir qu''une seule garantie pour être éligible au système de l''automatisation du process AXA via EXTR_AXA/SIMPA2.'
			Return -1
		End		

	/*
	Sur ATLAS/ORANGE, nous étions toujours dans un cas de réparation, donc ATLAS (via les PS de Fred) allait jusqu’à créé de détail garantie « Réparation appareil garantie ».
	Mais ici, cela peut déboucher sur du diag (evt 1083) ou de la réparation (evt 937).
	De ce fait, je n’attends la création d’aucun détail de la part de l’extranert ATM, je le créerai moi-même en fonction du contexte.
	Donc si le dossier arrive avec un ou plusieurs détails de garantie créés, je les supprimerai tous.
	*/
	Delete sysadm.w_detail Where id_sin = @adcIdSin 

	-- Règle venu par les projets [VDOC18734][DT200] : Si modèle non éligible => Rejet.
	If Exists ( 
		Select Top 1 1 
		From	sysadm.w_sin ws,
				sysadm.det_pro dp
		Where	ws.id_sin = @adcIdSin 
		And		dp.id_prod = ws.id_prod
		And		dp.id_code_dp = 290
		And		CharIndex ( sysadm.FN_CLE_VAL ( 'MODL', val_car, ';'), ws.modl_port ) > 0 
		)
		Begin
			Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Règle spécifique dp/290', 'Le modèle de l''appareil n''est pas éligible au système, voir VDOC18734 et DT200. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
			Return -1
		End		

	-- nature de autorisée au système
	-- [DT386_EXTR_AXA]
	If Not Exists ( 
			Select	Top 1 1 
			From	sysadm.w_sin ws
			Where	ws.id_sin = @adcIdSin
			And		ws.id_natsin in ( 114 )
		) 
		Begin
			Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Nature de sinistre non éligible', 'La nature de sinistre déclarée sur ce sinistre n''est pas éligible à l''automatisation du process AXA via EXTR_AXA/SIMPA2.'
			Return -1
		End		
Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_DT386_DOSSIER_INTEGRE
-- Auteur               :       Fabry JF
-- Date                 :       15/05/2019
-- Libellé              :
-- Commentaires         :      
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      25/09/2019   [DT386_EXTR_AXA_V8]
-- JFF      11/05/2022   [RS2980_IFR]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DT386_DOSSIER_INTEGRE' AND type = 'P' )
        DROP procedure sysadm.PS_I_DT386_DOSSIER_INTEGRE
GO

CREATE procedure sysadm.PS_I_DT386_DOSSIER_INTEGRE
	@adcIdSin   Decimal (10)
AS

	Declare @iInterL Integer 
	Declare @sTypLivrExtrATM VarChar ( 3 )
	Declare @sCodLivrExtrATM VarChar ( 50 )
	Declare @sCodPSMCentreExtrATM VarChar ( 50 )
	Declare @sRetourErrMail VarChar ( 255 )
	Declare	@sMsgMail VarChar ( 255 )
	Declare	@sObjMail VarChar ( 255 )
	Declare	@sFicOut  VarChar ( 255 )
	Declare @dcPrixPublic Decimal (11,2)
	Declare @sMarqApp VarChar ( 35 )
	Declare @sModlApp VarChar ( 35 )
	Declare @sMsgTemp VarChar ( 500 )
	Declare @iVal Integer
	Declare @sAdrMailInterAss Varchar ( 200 )
	Declare @sVal Varchar ( 200 )
	Declare @sTypApp VarChar ( 10 )
	Declare @dtDteDelivr DateTime
	Declare @dtDteFinValid DateTime
	Declare @sMarqueAppSin Varchar ( 35 ) 
	Declare @sModlAppSin Varchar ( 35 ) 
	Declare @sCodeRetIfr Varchar ( 20 )

	Select @sTypApp = Upper ( rtrim ( sysadm.FN_GET_DIV_SIN (@adcIdSin, 'type_app', 'W', 'RETOUR=CODE' ) ))
	If @sTypApp is null set @sTypApp = ''

	-- Présence ligne dans w_sin
	If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin )
		Begin
			Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Le sinistre n''existe pas', 'La référence sinistre n''existe pas. La référence transmise à l''automate SIMPA2 par l''Extranet AXA ne réfère aucun sinistre dans la base de données SIMPA2. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
			Return -1
		End		
		
		-- Présence donnée dans id_natsin
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And id_natsin is not null And id_natsin <> 0 )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Nature de sinistre non renseignée', 'La nature de sinistre n''a pas été renseignée par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End		

		-- Présence donnée dans id_territ
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And id_territ is not null And id_territ <> 0 )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Territorialité non renseignée', 'La territorialité n''a pas été renseignée par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans id_detail
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And id_detsin is not null And id_detsin <> 0 )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Détail de sinistre non renseigné', 'Le détail de sinistre n''a pas été renseigné par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans dte_surv
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And dte_surv is not null )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Date de survenance non renseignée', 'La date de survenance n''a pas été renseignée par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans dte_decl
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And dte_decl is not null )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Date de déclaration non renseignée', 'La date de déclaration n''a pas été renseignée par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans id_ets, contrôle présence table établissement
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And id_ets is not null )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'ETS adhésion non renseignée', 'L''établissement adhésion n''a pas été renseigné par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		If Not Exists ( Select Top 1 1 
						From sysadm.w_sin ws,
							 sysadm.etablissement ets
						Where ws.id_sin = @adcIdSin 
						And	  ets.id_prod = ws.id_prod
						And	  ets.id_rev = ws.id_rev
						And   ets.id_ets = ws.id_ets  )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'ETS non paramétré ', 'L''établissement adhésion transmis pas l''Extranet AXA n''existe pas sur SIMPA2 pour ce produit. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans dte_adh
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And dte_adh is not null )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Date adhésion non renseignée', 'La date d''adhésion n''a pas été renseignée par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Contrôle du texte de déclaration (22/05/2018 JFF)
		Select @sVal = 
				Upper ( 
				Replace ( Replace ( Replace ( Replace ( Replace ( 
				Replace ( ltrim ( rtrim ( ws.txt_mess)), '''', '' ), 
				char ( 13 ), '' ),
				char ( 10 ), '' ),
				char ( 9 ), '' ),
				char ( 11 ), '' ),
				'"', '' )
				) 
		From  sysadm.w_sin ws
		Where ws.id_sin = @adcIdSin

		If @sVal is null Set @sVal = ''
		If @sVal = ''
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Texte de déclaration non renseigné', 'Le texte de déclaration n''a pas été renseigné par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End 
		 		 
		-- Présence donnée dans id_sdos
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And id_sdos is not null And id_sdos <> 0 )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Co-adhérent non renseigné', 'Le co-adhérent n''a pas été renseigné par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans civ
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And cod_civ is not null And cod_civ <> 0 )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Civilité non renseignée (w_sin)', 'La civilité de l''assuré n''a pas été renseignée par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans nom
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And nom is not null And ltrim ( nom ) <> '' )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Nom non renseignée (w_sin)', 'Le nom de l''assuré n''a pas été renseigné par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans prénom (si absente, mettre un point)
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And prenom is not null And ltrim ( prenom ) <> '' )
			Begin
				If ( Select cod_civ From sysadm.w_sin Where id_sin = @adcIdSin ) = 5
				 Begin
					Update sysadm.w_sin Set prenom = '.' Where id_sin = @adcIdSin 
				 End
				Else
				 Begin
					Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Prénom non renseignée (w_sin)', 'Le prénom de l''assuré n''a pas été renseigné par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
					Return -1
				 End
			End	

		-- Présence donnée dans adr_1
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And adr_1 is not null And ltrim ( adr_1 ) <> '' )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Adresse non renseignée (w_sin)', 'L''adresse de l''assuré n''a pas été renseignée par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans adr_cp
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And adr_cp is not null And ltrim ( adr_cp ) <> '' )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'CP non renseignée (w_sin)', 'Le code postal de l''assuré n''a pas été renseigné par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans adr_ville
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And adr_ville is not null And ltrim ( adr_ville ) <> '' )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Ville non renseignée (w_sin)', 'La ville de l''assuré n''a pas été renseignée par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Contrôle cohérence cp/ville
		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			If Not Exists ( 
					Select	Top 1 1 
					From	SESAME_PRO.sysadm.commune c,
							sysadm.w_sin ws
					Where	ws.id_sin = @adcIdSin
					And     c.code_postal = ws.adr_cp
					And		c.nom_commune = ws.adr_ville
					)
				Begin
					Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Cohér. CP/Ville incorrect (w_sin)', 'La cohérence code postal/ville de l''assuré par rapport au référentiel, n''est pas respectée par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
					Return -1
				End	
		END
		ELSE
		Begin
			If Not Exists ( 
					Select	Top 1 1 
					From	SESAME_SIM.sysadm.commune c,
							sysadm.w_sin ws
					Where	ws.id_sin = @adcIdSin
					And     c.code_postal = ws.adr_cp
					And		c.nom_commune = ws.adr_ville
					)
				Begin
					Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Cohér. CP/Ville incorrect (w_sin)', 'La cohérence code postal/ville de l''assuré par rapport au référentiel, n''est pas respectée par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
					Return -1
				End	
		End

		
		-- [VDOC25528]
		-- [TODO][DOM]
		If Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And left ( adr_cp, 3 ) in ( '971', '972', '973', '974', '975', '976', '984', '986', '987', '988' ))
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'DOM-TOM Trait. Manuel.(w_sin)', 'Les départements DOM-TOM sont à traiter en manuel, pas d''automatisation pour ce cas. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Contrôle de la présence de pièce
		If Exists ( Select Top 1 1 From sysadm.w_piece Where id_sin = @adcIdSin  )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Présence de pièce(s) cochée(s)', 'l''Extranet AXA a au moins coché une pièce. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End


		-- Vu avec Marin, on automatise juste les type_app IFR, donc TEL, TPC, MCS
		/*
		If @sTypApp Not In ( 'TEL', 'TPC', 'MCS' ) 
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'TypApp non éligible à l''automate', 'Le type d''appareil déclaré par l''Extranet AXA n''est pas éligible à une automatisation totale. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	
		*/

		-- Type <=> code produit (dp/25)
		If Not Exists ( 
			Select Top 1 1 
			From sysadm.w_sin ws,
				 sysadm.det_pro dp
			Where ws.id_sin = @adcIdSin
			And   dp.id_prod = ws.id_prod
			And   dp.id_code_dp = 25
			And   dp.id_code_car = @sTypApp
		) 
		  Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'TypApp non éligible au produit', 'Le type d''appareil déclaré par l''Extranet AXA n''est pas éligible au code produit sinistre. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
		  End 


		-- Présence donnée dans num_port ( 10 chiffre 06, 07)
		-- [DT386_EXTR_AXA]
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And num_port is not null And ltrim ( num_port ) <> '' And Left ( num_port, 2 ) in ( '06', '07') )
		   And 
		   @sTypApp = 'TEL'
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'NumTelSin non valide/rens. (w_sin)', 'Le numéro de téléphone portable de l''assuré n''a pas été renseignée (ou n''est pas valide) par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans num_imei_port (num imei valide et 15)
		-- [DT386_EXTR_AXA]
		If  Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And num_imei_port is not null And ltrim ( num_imei_port ) <> '' )
		    Or 
		    Exists ( Select Top 1 1 
					From sysadm.w_sin ws,
						 sysadm.w_div_sin wds
					Where ws.id_sin = @adcIdSin 
					And   ws.num_imei_port is not null 
					And ltrim ( ws.num_imei_port ) <> ''  
					And sysadm.FN_CORR_IMEI ( ws.num_imei_port, Getdate()) <> ws.num_imei_port 
					And wds.id_sin = ws.id_sin
					And wds.nom_zone = 'type_app'
					And wds.val_car in ( 'TEL' )
				  )
			Begin
				If @sTypApp In ( 'MDE', 'AUT', 'JEV', 'BRI'  ) 
				  Begin
					Update sysadm.w_sin Set num_imei_port = 'X' where id_sin = @adcIdSin
				  End 
				Else
				  Begin
					Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'IMEI/Série non valide/renseignée', 'Le numéro IMEI/Série de l''assuré n''a pas été renseignée (ou n''est pas valide) par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
					Return -1
				  End 
			End	



		-- Présence donnée dans marq_port et modl_port
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And marq_port is not null And ltrim ( marq_port ) <> '' )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Marque non renseignée', 'La marque de l''appareil sinistré de l''assuré n''a pas été renseignée par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And modl_port is not null And ltrim ( modl_port ) <> '' )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Modèle non renseignée', 'Le modèle de l''appareil sinistré de l''assuré n''a pas été renseigné par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		-- binome marque/modèle doit appartenir à IFR
		-- [DT386_EXTR_AXA]
		If @sTypApp in ( 'TEL', 'TPC', 'MCS' )
		 Begin
			If Not Exists ( 
					Select Top 1 1 
					From sysadm.w_sin ws,
						 sysadm.ifr i
					Where ws.id_sin = @adcIdSin 
					And   i.marque = ws.marq_port
					And   i.reference = ws.modl_port
					And   ( Left ( i.sku_saga, 3 ) = @sTypApp
							Or 
							i.sku_saga is null )
					)
				Begin
					Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Marque/Modèle incohérent Réf IFR', 'Le binôme marque/modèle de l''appareil sinistré de l''assuré transmis par l''Extranet AXA, n''est pas valide sous le référentiel IFR ou bien le type ne correspond pas au modèle. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
					Return -1
				End	
		  End

		-- [RS2980_IFR] -- Ctrle Validité prix IFR
		Select	@sMarqueAppSin = ws.marq_port,
				@sModlAppSin = ws.modl_port
		From sysadm.w_sin ws
		Where ws.id_sin = @adcIdSin

		Exec sysadm.PS_U_MARQUAGE_PRIX_IFR_A_REVOIR @sMarqueAppSin, @sModlAppSin, @sCodeRetIfr OutPut

		If @sCodeRetIfr = 'URGE'
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Prix public IFR obsolète', 'Le prix IFR de l''appareil est obsolète, ce contact vient d''alerter automatiquement notre équipe lui demandant de revoir le prix de cet appareil en priorité, ce qui sera fait sous 24h.@Durant ce délai, toute validation du dossier est impossible. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End 



		/*  -- [DT386_EXTR_AXA] On prend toute marques sans contrôle.
		Else
		  Begin
			If Not Exists ( 
					Select Top 1 1 
					From sysadm.w_sin ws,
						 sysadm.code cd
					Where ws.id_sin = @adcIdSin 
					And   cd.id_typ_code = '-MB'
					And   cd.lib_code = ws.marq_port
					)
				Begin
					Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Marque incohérente Réf code -MB', 'La marque de l''appareil sinistré de l''assuré transmis par l''Extranet AXA, n''est pas valide sous le référentiel code/-MB. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
					Return -1
				End	
		  End 
        */ 
		-- Présence donnée dte_ach_port
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And dte_ach_port is not null )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Date achat non renseignée', 'La date d''achat de l''appareil sinistré de l''assuré n''a pas été renseigné par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence alt_att = 'O'
		Update sysadm.w_detail Set alt_att = 'O' Where id_sin = @adcIdSin
		
		-- à Supprimer [A_SUPP]
		-- Update sysadm.w_detail Set lib_det = 'de votre appareil' Where id_sin = @adcIdSin

	-- Présence ligne dans w_inter 
		-- Présence ligne A
		If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' )
		Begin
			Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Inter Assuré absent', 'L''interlocuteur Assuré est absent, il n''a pas été créé par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
			Return -1
		End	

		-- Présence donnée dans civ
		If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And cod_civ is not null And cod_civ <> 0 )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Civilité non renseignée (w_interA)', 'La civilité de l''assuré n''a pas été renseignée par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans nom
		If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And nom is not null And ltrim ( nom ) <> '' )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Nom non renseignée (w_interA)', 'Le nom de l''assuré n''a pas été renseigné par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans adr_1
		If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And adr_1 is not null And ltrim ( adr_1 ) <> '' )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Adresse non renseignée (w_interA)', 'L''adresse de l''assuré n''a pas été renseignée par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans adr_cp
		If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And adr_cp is not null And ltrim ( adr_cp ) <> '' )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'CP non renseignée (w_interA)', 'Le code postal de l''assuré n''a pas été renseigné par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans adr_ville
		If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And adr_ville is not null And ltrim ( adr_ville ) <> '' )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Ville non renseignée (w_interA)', 'La ville de l''assuré n''a pas été renseignée par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Contrôle cohérence cp/ville
		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		Begin
					
			If Not Exists ( 
					Select	Top 1 1 
					From	SESAME_PRO.sysadm.commune c,
							sysadm.w_inter wi
					Where	wi.id_sin = @adcIdSin
					And		wi.cod_inter = 'A'
					And     c.code_postal = wi.adr_cp
					And		c.nom_commune = wi.adr_ville
					)
				Begin
					Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Cohé. CP/Ville incorrect (w_interA)', 'La cohérence code postal/ville de l''assuré par rapport au référentiel, n''est pas respectée par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
					Return -1
				End	
		End
		Else
		Begin
			If Not Exists ( 
				Select	Top 1 1 
				From	SESAME_SIM.sysadm.commune c,
						sysadm.w_inter wi
				Where	wi.id_sin = @adcIdSin
				And		wi.cod_inter = 'A'
				And     c.code_postal = wi.adr_cp
				And		c.nom_commune = wi.adr_ville
				)
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Cohé. CP/Ville incorrect (w_interA)', 'La cohérence code postal/ville de l''assuré par rapport au référentiel, n''est pas respectée par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	

		End

		-- Présence adresse mail
		If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And adr_mail is not null And ltrim ( adr_mail ) <> '' )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Adresse mail absente (w_interA)', 'L''adresse mail de l''assuré n''a pas été renseignée par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End
		
		Select @sAdrMailInterAss = adr_mail	From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And adr_mail is not null And ltrim ( adr_mail ) <> ''
		Set @sAdrMailInterAss = sysadm.FN_EPURE_CHAINE ( @sAdrMailInterAss ) 
		If sysadm.FN_CTRLE_ADR_MAIL ( @sAdrMailInterAss ) < 0
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Adresse mail non valide (w_interA)', 'L''adresse mail de l''assuré renseignée par l''Extranet AXA, n''est pas valide. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End 

		Update sysadm.w_inter 
		Set adr_mail = @sAdrMailInterAss
		Where id_sin = @adcIdSin


	-- Présence ligne dans w_div_sin
		-- Manque Info sur l'Extranet ATM
		-- [DT386_EXTR_AXA]
		If Exists ( Select Top 1 1 From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'manque_info_extr_axa' And val_car is not null And val_car = 'O' )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Manque info Extranet AXA', 'La zone technique manque_info_extr_axa a été cochée par l''Extranet AXA, cela arrête donc le processus d''automatisation. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End


		-- Présence typ_app existant dans -dp/25
		If Not Exists ( 
				Select Top 1 1 
				From	sysadm.w_div_sin wds,
						sysadm.w_sin ws,
						sysadm.det_pro dp
				Where  ws.id_sin = @adcIdSin 
				And	   wds.id_sin = wds.id_sin
				And	   wds.nom_zone = 'type_app'
				And    dp.id_prod = ws.id_prod
				And    dp.id_code_dp = 25
				And    dp.id_code_car = wds.val_car
				)
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Typ Mat Sin absent/non param', 'Le type de matériel sinistré transmis par l''Extranet AXA est absent ou non paramétré  pour ce produit. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End	


		-- Présence app_sin coché
		If Not Exists ( Select Top 1 1 From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'app_sin' And val_car is not null And val_car = 'O' )
			Begin
				Insert into w_div_sin Values ( @adcIdSin, 'app_sin', 'Sinistre sur appareil/Batt. Interne', -1, 'N', 'X', 'N', 'N', 113, null, null, null, 'O', 0, getdate(), getdate(), 'WEB')                             
/*
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'zone app_sin non renseignée', 'La zone technique app_sin n''a pas été renseignée par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
*/
			End

		-- Présence alt_decla_l''Extranet AXA cochée
		If Not Exists ( Select Top 1 1 From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'decla_extr_axa' And val_car is not null And val_car = 'O' )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'zone decla_extr_axa non renseignée', 'La zone technique decla_extr_axa n''a pas été renseignée par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End

		-- Contrôle de la présence de la valeur d'achat
		If Not Exists ( Select Top 1 1 From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'mt_val_achat_extr_axa' And val_mt is not null And val_mt > 0 )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Valeur d''achat absente', 'La valeur d''achat n''a pas été transmise par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End

		-- [DT386_EXTR_AXA_V8]
		If sysadm.FN_CLE_NUMERIQUE ( 'DT386_EXTR_AXA') >= 2  
		 Begin
			-- Contrôle de la présence du type de la pièce d'identité
			-- [DT386_EXTR_AXA_V8]
			If Not Exists ( Select Top 1 1 From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'num_pce_identite' And val_car is not null And Len ( val_car ) > 0 )
				Begin
					Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Numéro de la pièce d''identité', 'Le numéro de la pièce d''identité n''a pas été transmis par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
					Return -1
				End

			-- Contrôle de la date de délivrance de la pièce d'identité
			-- [DT386_EXTR_AXA_V8]
			If Not Exists ( Select Top 1 1 From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'dte_delivrance_pi' And val_dte is not null )
				Begin
					Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Date délivrance pièce identité', 'La date de délivrance de la pièce d''identité n''a pas été transmis par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
					Return -1
				End
			Else
				Begin
					Select @dtDteDelivr = Convert ( DateTime, ( sysadm.FN_GET_DIV_SIN (@adcIdSin, 'dte_delivrance_pi', 'W', 'RETOUR=CODE' ) ))
				End 

			-- Contrôle de la date de fin de validité de la pièce d'identité
			-- [DT386_EXTR_AXA_V8]
			If Not Exists ( Select Top 1 1 From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'dte_fin_val_pi' And val_dte is not null )
				Begin
					Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Date de fin validité pièce identité', 'La date de fin validité de la pièce d''identité n''a pas été transmis par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
					Return -1
				End
			Else
				Begin  
					Select @dtDteFinValid = Convert ( DateTime, ( sysadm.FN_GET_DIV_SIN (@adcIdSin, 'dte_fin_val_pi', 'W', 'RETOUR=CODE' ) ))
				End 

			If @dtDteDelivr >= @dtDteFinValid
				Begin
					Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Incoh. Dte délivr PI et Fin valid.', 'La date de délivrance de la pièce d''identité est incohérente avec la date de fin de validité. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
					Return -1
				End
		 End

		-- Contrôle de la présence du type de la pièce d'identité
		-- [DT386_EXTR_AXA]
		If Not Exists ( Select Top 1 1 From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'type_pce_identite' And val_car is not null And Len ( val_car ) > 0 )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Type pièce identité', 'Le type de la pièce d''identité n''a pas été transmis par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End

		-- Contrôle de la présence de l'autorité ayant délivrée la pièce d'identité
		-- [DT386_EXTR_AXA]
		If Not Exists ( Select Top 1 1 From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'autorite_pce_identite' And val_car is not null And Len ( val_car ) > 0 )
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Autorité ayant délivr. pce d''ident.', 'L''autorité ayant délivrée la pièce d''identité n''a pas été transmise par l''Extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End

		-- [DT386_EXTR_AXA]
		-- Contrôle de la validité du type de la pièce d'identité
		If Not Exists ( 
				Select Top 1 1 
				From sysadm.w_div_sin ws,
					 sysadm.code_car cc
				Where	ws.id_sin = @adcIdSin 
				And		ws.nom_zone = 'type_pce_identite' 
				And		cc.id_typ_code = '-WG'
				And     cc.id_code = ws.val_car
			 )
			Begin
				Select @sMsgTemp = rtrim ( ws.val_car )
				From sysadm.w_div_sin ws
				Where	ws.id_sin = @adcIdSin 
				And		ws.nom_zone = 'type_pce_identite' 

			    Set @sMsgTemp = 'Le type de la pièce d''identité (' + @sMsgTemp + ') transmis par l''Extranet AXA n''est pas valide. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Type pièce identité non valide', @sMsgTemp 				
				Return -1
			End

		-- [DT386_EXTR_AXA]
		-- Contrôle de la validité de de l'autorité ayant délivrée la pièce d'identité
		If Not Exists ( 
				Select Top 1 1 
				From sysadm.w_div_sin ws,
					 sysadm.code_car cc
				Where	ws.id_sin = @adcIdSin 
				And		ws.nom_zone = 'autorite_pce_identite' 
				And		cc.id_typ_code = '-WH'
				And     cc.id_code = ws.val_car
			 )
			Begin
				Select @sMsgTemp = rtrim ( ws.val_car )
				From sysadm.w_div_sin ws
				Where	ws.id_sin = @adcIdSin 
				And		ws.nom_zone = 'autorite_pce_identite' 

			    Set @sMsgTemp = 'L''autorité ayant délivrée la pièce d''identité (' + @sMsgTemp + ') transmise par l''Extranet AXA n''est pas valide. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Autorité pce ident. non valide', @sMsgTemp 				
				Return -1
			End

		-- [DT386_EXTR_AXA]
		-- Ecriture valeur d'achat
		Update	sysadm.w_detail 
		Set		mt_val_achat = wds.val_mt,
				mt_val_publique = wds.val_mt  -- Vu avec Maryline
		From	sysadm.w_div_sin wds,
				sysadm.w_detail wd
		Where	wds.id_sin = @adcIdSin
		And		wds.nom_zone = 'mt_val_achat_extr_axa'
		And		wd.id_sin = wds.id_sin

		-- [DT386_EXTR_AXA]
		-- Ecriture Date d'achat
		Update	sysadm.w_detail 
		Set		dte_det = ws.dte_ach_port
		From	sysadm.w_sin ws,
				sysadm.w_detail wd
		Where	ws.id_sin = @adcIdSin
		And     wd.id_sin = ws.id_sin
			
Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_DT386_REGLE_SPEC_ET_REFUS
-- Auteur               :       Fabry JF
-- Date                 :       15/05/2019
-- Libellé              :
-- Commentaires         :      
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DT386_REGLE_SPEC_ET_REFUS' AND type = 'P' )
        DROP procedure sysadm.PS_I_DT386_REGLE_SPEC_ET_REFUS
GO

CREATE procedure sysadm.PS_I_DT386_REGLE_SPEC_ET_REFUS
	@adcIdSin   Decimal (10)
AS

Declare @iRet Integer
Declare @sRefus VarChar ( 100 )
Declare @sChaine VarChar ( 255 )
Declare @iRefusAutoAutorise Integer
Declare @sChaineBcv VarChar ( 255 )
Declare @sTypApp VarChar ( 10 )


Set @sChaineBcv = ''
Select @sTypApp = Upper ( rtrim ( sysadm.FN_GET_DIV_SIN (@adcIdSin, 'type_app', 'W', 'RETOUR=CODE' ) ))
If @sTypApp is null set @sTypApp = ''

-- [DT386_EXTR_AXA]
Select @iRefusAutoAutorise = 
	Case 
		When sysadm.FN_CLE_VAL ( 'DF005_2_REFUS_AUTO', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';' ) = 'OUI' Then 1
		Else 0
	End 
From	sysadm.w_sin ws,
		sysadm.det_pro dp
Where	ws.id_sin = @adcIdSin
And		dp.id_prod = ws.id_prod
And		dp.id_code_dp = 335
If @iRefusAutoAutorise is null Set @iRefusAutoAutorise = 0

	-- Règles Particulières
		-- Règle venu par les projets [VDOC18734][DT200] : Si modèle non éligible => Rejet.
		If Exists ( 
			Select Top 1 1 
			From	sysadm.w_sin ws,
					sysadm.det_pro dp
			Where	ws.id_sin = @adcIdSin 
			And		dp.id_prod = ws.id_prod
			And		dp.id_code_dp = 290
			And		CharIndex ( sysadm.FN_CLE_VAL ( 'MODL', val_car, ';'), ws.modl_port ) > 0 
			)
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Règle spécifique dp/290', 'Le modèle de l''appareil n''est pas éligible au système, voir VDOC18734 et DT200. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End		

		-- Marque interdite de réparation
		-- [VDOC25048] retrait 'HP' 
		-- [DT386_EXTR_AXA] Ce contrôle n'est pas nécéssaire sur le BuyBack
		/* 
		If Exists ( 
			Select Top 1 1 
			From	sysadm.w_sin ws
			Where	ws.id_sin = @adcIdSin 
			And		ws.marq_port in ( 'SENDO', 'VK', 'MIO', 'BENQ SIEMENS', 'APPLE', 'BENQ', 'DIRLAND', 'DREAMPHONE', 'GRUNDIG', 'HANDSPRING', 'MALATA', 'MITAC', 'MITSUBISHI ELECTRIC', 'MYWAY', 'OPTION', 'WONU', 'XCUTE', 'SIEMENS', 'PANASONIC', 'CECT', 'SAGEM' )
			And     Not Exists ( 
						Select Top 1 1 
						From   sysadm.det_pro dp
						Where  dp.id_prod = ws.id_prod
						And    dp.id_code_dp = 200
						And	   ( ( CharIndex ( 'IPHONE', ws.modl_port ) > 0 And	sysadm.FN_CLE_VAL ( 'MODELE', dp.val_car, ';') = 'IPHONE')
								  Or  
								 ( CharIndex ( 'IPAD', ws.modl_port ) > 0 And	sysadm.FN_CLE_VAL ( 'MODELE', dp.val_car, ';') = 'IPAD')
							   )
					)
			)
		

			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Marque interdite en réparation', 'La marque sinistrée est interdite en réparation. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End		
		*/

	-- Refus
		-- Si AMU un refus opérateur venant d'ATLAS => Rejet.
		If Exists ( Select Top 1 1 From sysadm.w_refus Where id_sin = @adcIdSin And alt_ope = 'O' ) 
		 Begin
			-- [DF005-1-LOT2]

			If @iRefusAutoAutorise > 0 
				Begin
					Return 2 -- Cas du refus géré avec courrier et validation
				End 
			Else
				Begin
					Select @sRefus = stuff ( ( SELECT Distinct ', ' + CAST(rtrim ( id_motif ) AS VARCHAR(250)) FROM sysadm.w_refus Where id_sin = @adcIdSin And alt_ope = 'O' For XML PATH ('') ), 1, 2, '' )
					If @sRefus is null Set @sRefus = ''
					Set @sChaine = 'Un ou plusieurs opérateur refus ou coché(s) par l''Extranet AXA sont présent (code refus : ' + @sRefus + '). Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'

					Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Refus opérateur Extr. AXA présent', @sChaine 
					Return -1
				End
		 End 

		-- Refus Revision
		Exec @iRet = sysadm.PS_I_DT386_REFUS_REVISION @adcIdSin
		If @iRet = -1 Return @iRet

		If @iRefusAutoAutorise > 0 
			Begin
			Set @sChaineBcv = 'REFUS_AUTO=' + 
					Case @iRefusAutoAutorise 
						When 1 Then 'OUI'
						Else 'NON'
					End 
			End

		-- Refus 601
		Exec @iRet = sysadm.PS_I_DT386_REFUS_601_V01 @adcIdSin, @sChaineBcv
		If @iRet in ( -1, 2 ) Return @iRet

		-- Refus 602
		Exec @iRet = sysadm.PS_I_DT386_REFUS_602_V01 @adcIdSin, @sChaineBcv
		If @iRet in ( -1, 2 ) Return @iRet

		-- Refus 604
		Exec @iRet = sysadm.PS_I_DT386_REFUS_604_V01 @adcIdSin, @sChaineBcv
		If @iRet in ( -1, 2 ) Return @iRet

		-- Refus 611
		Exec @iRet = sysadm.PS_I_DT386_REFUS_611_V01 @adcIdSin, @sChaineBcv
		If @iRet in ( -1, 2 ) Return @iRet

		-- Refus 612
		Exec @iRet = sysadm.PS_I_DT386_REFUS_612_V01 @adcIdSin, @sChaineBcv
		If @iRet in ( -1, 2 ) Return @iRet

		-- Refus 613
		Exec @iRet = sysadm.PS_I_DT386_REFUS_613_V01 @adcIdSin, @sChaineBcv
		If @iRet in ( -1, 2 ) Return @iRet

		-- Refus 641
		Exec @iRet = sysadm.PS_I_DT386_REFUS_641_V01 @adcIdSin, @sChaineBcv
		If @iRet in ( -1, 2 ) Return @iRet

		-- Refus 642
		Exec @iRet = sysadm.PS_I_DT386_REFUS_642_V01 @adcIdSin, @sChaineBcv
		If @iRet in ( -1, 2 ) Return @iRet

		-- Refus 643
		Exec @iRet = sysadm.PS_I_DT386_REFUS_643_V01 @adcIdSin, @sChaineBcv
		If @iRet in ( -1, 2 ) Return @iRet

		-- Refus 603
		Exec @iRet = sysadm.PS_I_DT386_REFUS_603 @adcIdSin
		If @iRet = -1 Return @iRet

Go



--------------------------------------------------------------------
-- Procédure            :       PS_I_DT386_REFUS_REVISION
-- Auteur               :       Fabry JF
-- Date                 :       15/05/2019
-- Libellé              :
-- Commentaires         :      
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DT386_REFUS_REVISION' AND type = 'P' )
        DROP procedure sysadm.PS_I_DT386_REFUS_REVISION
GO

CREATE procedure sysadm.PS_I_DT386_REFUS_REVISION
	@adcIdSin   Decimal (10)
AS

Declare @dtDteAdh DateTime
Declare @dtDteSurv DateTime
Declare @dcIdProd Decimal ( 7 )
Declare @sRev     VarChar ( 10 )

Select @dtDteSurv = dte_surv,
	   @dtDteAdh = dte_adh,
	   @dcIdProd = id_prod
From   sysadm.w_sin Where id_sin = @adcIdSin

Set @sRev = Space ( 10 )

Exec sysadm.PS_X_CALC_REVISION @dcIdProd, @dtDteSurv, @dtDteAdh, @sRev OUTPUT

If	@sRev is null Or @sRev = '-1'
	Begin
		Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Avenant/Révision non déterminé', 'Le système n''a pas pu déterminer d''avenant (de révision) sur ce dossier. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
		Return -1				
	End
Else
	Begin
		Update sysadm.w_sin Set id_rev = Convert ( Decimal ( 7 ), @sRev ) Where id_sin = @adcIdSin
	End

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_DT386_REFUS_601
-- Auteur               :       Fabry JF
-- Date                 :       16/01/2016
-- Libellé              :
-- Commentaires         :      
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DT386_REFUS_601_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_DT386_REFUS_601_V01
GO

CREATE procedure sysadm.PS_I_DT386_REFUS_601_V01
	@adcIdSin   Decimal (10),
	@asChaineBcv VarChar (255)
AS

Declare @dtDteFinGti DateTime
Declare @dtDteResil DateTime
Declare @dtDteSurv DateTime
Declare @iCasRefus Integer
Declare @sPara VarChar ( 4 )
Declare @iCptTri Integer
Declare @dcIdGti Decimal ( 7 )

Set @iCasRefus = 0

If ( Select sysadm.FN_CLE_VAL ( 'REFUS_AUTO', @asChaineBcv, ';') ) = 'OUI' 
	Begin
		Set @iCasRefus = 1 

		Select Top 1 @sPara = m.id_para,
						@iCptTri  = m.cpt_tri,
						@dcIdGti = wg.id_gti
		From sysadm.motif m,
				sysadm.w_sin ws,
				sysadm.w_gar_sin wg
		Where ws.id_sin = @adcIdSin
		And   wg.id_sin = ws.id_sin
		And   m.id_prod = ws.id_prod
		And   m.id_motif = 601

		If @@RowCount = 0 Set @iCasRefus = 0

		If @sPara is null Set @sPara = ''
		If @iCptTri is null Set @iCptTri = 1
	End 


Select @dtDteFinGti = dte_fin_gti From sysadm.w_sin Where id_sin = @adcIdSin
Select @dtDteResil = dte_resil From sysadm.w_sin Where id_sin = @adcIdSin
Select @dtDteSurv = dte_surv From sysadm.w_sin Where id_sin = @adcIdSin

If	@dtDteFinGti is not null And 
	@dtDteResil is not null And
	@dtDteSurv is not null 
	Begin
		If @dtDteFinGti < @dtDteSurv
			Begin
				If @iCasRefus > 0 
					Begin
						Insert into sysadm.w_refus Values ( @adcIdSin, @dcIdGti, -1, 601, 'O', 'N', 0, @sPara, @iCptTri, GetDate(), GetDate (), 'JFF' ) 
						Return 2
					End
				Else
					Begin
						Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Refus machine 601', 'Le refus machine 601 s''est déclenché. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
						Return -1				
					End
			End 
	End
Go



--------------------------------------------------------------------
-- Procédure            :       PS_I_DT386_REFUS_602
-- Auteur               :       Fabry JF
-- Date                 :       15/05/2019
-- Libellé              :
-- Commentaires         :      
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DT386_REFUS_602_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_DT386_REFUS_602_V01
GO

CREATE procedure sysadm.PS_I_DT386_REFUS_602_V01
	@adcIdSin   Decimal (10),
	@asChaineBcv VarChar (255)
AS

Declare @dtDteAdh DateTime
Declare @dtDteSurv DateTime
Declare @iCasRefus Integer
Declare @sPara VarChar ( 4 )
Declare @iCptTri Integer
Declare @dcIdGti Decimal ( 7 )

Set @iCasRefus = 0

-- [DF005-1-LOT2]
If ( Select sysadm.FN_CLE_VAL ( 'REFUS_AUTO', @asChaineBcv, ';') ) = 'OUI' 
	Begin
		Set @iCasRefus = 1 

		Select Top 1 @sPara = m.id_para,
						@iCptTri  = m.cpt_tri,
						@dcIdGti = wg.id_gti
		From sysadm.motif m,
				sysadm.w_sin ws,
				sysadm.w_gar_sin wg
		Where ws.id_sin = @adcIdSin
		And   wg.id_sin = ws.id_sin
		And   m.id_prod = ws.id_prod
		And   m.id_motif = 602

		If @@RowCount = 0 Set @iCasRefus = 0

		If @sPara is null Set @sPara = ''
		If @iCptTri is null Set @iCptTri = 1
	End 


If Exists ( 
	Select Top 1 1 
	From sysadm.produit p ,
		 sysadm.sinistre s 
	where s.id_sin = @adcIdSin
	And   p.id_prod = s.id_prod
	And   p.cod_adh in ( 1, 2, 3, 4 )
   )
	Begin 
		Select @dtDteAdh = dte_adh From sysadm.w_sin Where id_sin = @adcIdSin
		Select @dtDteSurv = dte_surv From sysadm.w_sin Where id_sin = @adcIdSin


		If	@dtDteAdh > @dtDteSurv 
			Begin

				If @iCasRefus > 0 
					Begin
						Insert into sysadm.w_refus Values ( @adcIdSin, @dcIdGti, -1, 602, 'O', 'N', 0, @sPara, @iCptTri, GetDate(), GetDate (), 'JFF' ) 
						Return 2
					End
				Else
					Begin
						Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Refus machine 602', 'Le refus machine 602 s''est déclenché. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
						Return -1				
					End
			End
	End
Go


--------------------------------------------------------------------
-- Procédure            :       PS_I_DT386_REFUS_603
-- Auteur               :       Fabry JF
-- Date                 :       15/05/2019
-- Libellé              :
-- Commentaires         :      
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
-- 
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DT386_REFUS_603' AND type = 'P' )
        DROP procedure sysadm.PS_I_DT386_REFUS_603
GO

CREATE procedure sysadm.PS_I_DT386_REFUS_603
	@adcIdSin   Decimal (10)
AS

Declare @dtDteFinGti DateTime
Declare @dtDteResil DateTime
Declare @dtDteSurv DateTime

Select @dtDteFinGti = dte_fin_gti From sysadm.w_sin Where id_sin = @adcIdSin
Select @dtDteResil = dte_resil From sysadm.w_sin Where id_sin = @adcIdSin
Select @dtDteSurv = dte_surv From sysadm.w_sin Where id_sin = @adcIdSin

If	@dtDteFinGti is not null And 
	@dtDteSurv is not null And
	@dtDteResil is null
	Begin
		If @dtDteFinGti < @dtDteSurv 
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Refus machine 603', 'Le refus machine 603 s''est déclenché. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1				
			End 
	End
Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_DT386_REFUS_604
-- Auteur               :       Fabry JF
-- Date                 :       16/01/2016
-- Libellé              :
-- Commentaires         :      
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DT386_REFUS_604_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_DT386_REFUS_604_V01
GO

CREATE procedure sysadm.PS_I_DT386_REFUS_604_V01
	@adcIdSin   Decimal (10),
	@asChaineBcv VarChar (255)
AS

Declare @iCasRefus Integer
Declare @sPara VarChar ( 4 )
Declare @iCptTri Integer
Declare @dcIdGti Decimal ( 7 )

Set @iCasRefus = 0

If ( Select sysadm.FN_CLE_VAL ( 'REFUS_AUTO', @asChaineBcv, ';') ) = 'OUI' 
	Begin
		Set @iCasRefus = 1 

		Select Top 1 @sPara = m.id_para,
						@iCptTri  = m.cpt_tri,
						@dcIdGti = wg.id_gti
		From sysadm.motif m,
				sysadm.w_sin ws,
				sysadm.w_gar_sin wg
		Where ws.id_sin = @adcIdSin
		And   wg.id_sin = ws.id_sin
		And   m.id_prod = ws.id_prod
		And   m.id_motif = 604

		If @@RowCount = 0 Set @iCasRefus = 0

		If @sPara is null Set @sPara = ''
		If @iCptTri is null Set @iCptTri = 1
	End 


If Exists ( 
		Select	Top 1 1
		From	sysadm.det_pro dp,
				sysadm.w_gar_sin g,
				sysadm.w_sin s
		Where	s.id_sin = @adcIdSin
		And		g.id_sin = s.id_sin
		And		dp.id_prod = s.id_prod
		And		dp.id_code_dp = 111
		And		sysadm.FN_CLE_VAL ( 'ID_CODE_NUM', val_car, ';') = g.id_gti
		And		Not Exists ( 
				 Select Top 1 1
				 From	sysadm.w_gar_sin g1
				 Where  g1.id_sin = g.id_sin
				 And    g1.id_gti not in ( 10,11 )
				) 
	)
	Begin
		-- [DF005-1-LOT2]
		If @iCasRefus > 0 
			Begin
				Insert into sysadm.w_refus Values ( @adcIdSin, @dcIdGti, -1, 604, 'O', 'N', 0, @sPara, @iCptTri, GetDate(), GetDate (), 'JFF' ) 
				Return 2
			End
		Else
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Refus machine 604', 'Le refus machine 604 s''est déclenché. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End
	End 

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_DT386_REFUS_611
-- Auteur               :       Fabry JF
-- Date                 :       16/01/2016
-- Libellé              :
-- Commentaires         :      
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DT386_REFUS_611_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_DT386_REFUS_611_V01
GO

CREATE procedure sysadm.PS_I_DT386_REFUS_611_V01
	@adcIdSin   Decimal (10),
	@asChaineBcv VarChar (255)
AS

Declare @iCasRefus Integer
Declare @sPara VarChar ( 4 )
Declare @iCptTri Integer
Declare @dcIdGti Decimal ( 7 )

Set @iCasRefus = 0

-- [DF005-1-LOT2]
If ( Select sysadm.FN_CLE_VAL ( 'REFUS_AUTO', @asChaineBcv, ';') ) = 'OUI' 
	Begin
		Set @iCasRefus = 1 

		Select Top 1 @sPara = m.id_para,
						@iCptTri  = m.cpt_tri,
						@dcIdGti = wg.id_gti
		From sysadm.motif m,
				sysadm.w_sin ws,
				sysadm.w_gar_sin wg
		Where ws.id_sin = @adcIdSin
		And   wg.id_sin = ws.id_sin
		And   m.id_prod = ws.id_prod
		And   m.id_motif = 611

		If @@RowCount = 0 Set @iCasRefus = 0

		If @sPara is null Set @sPara = ''
		If @iCptTri is null Set @iCptTri = 1
	End 


If Not Exists ( 
		Select	Top 1 1
		From	sysadm.condition c,
				sysadm.w_sin ws,
				sysadm.w_gar_sin wg
		Where	ws.id_sin = @adcIdSin
		And		wg.id_sin = ws.id_sin
		And		c.id_prod = ws.id_prod
		And		c.id_gti = wg.id_gti
		And		c.id_typ_code = '+NS'
		And		c.id_code = ws.id_natsin
		And		c.alt_reg = 'O'
	)
	Begin
		If @iCasRefus > 0 
			Begin
				Insert into sysadm.w_refus Values ( @adcIdSin, @dcIdGti, -1, 611, 'O', 'N', 0, @sPara, @iCptTri, GetDate(), GetDate (), 'JFF' ) 
				Return 2
			End
		Else
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Refus machine 611', 'Le refus machine 611 s''est déclenché. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1				
			End
	End 

Go


--------------------------------------------------------------------
-- Procédure            :       PS_I_DT386_REFUS_612
-- Auteur               :       Fabry JF
-- Date                 :       16/01/2016
-- Libellé              :
-- Commentaires         :      
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DT386_REFUS_612_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_DT386_REFUS_612_V01
GO

CREATE procedure sysadm.PS_I_DT386_REFUS_612_V01
	@adcIdSin   Decimal (10),
	@asChaineBcv VarChar (255)
AS

Declare @iCasRefus Integer
Declare @sPara VarChar ( 4 )
Declare @iCptTri Integer
Declare @dcIdGti Decimal ( 7 )

Set @iCasRefus = 0

-- [DF005-1-LOT2]
If ( Select sysadm.FN_CLE_VAL ( 'REFUS_AUTO', @asChaineBcv, ';') ) = 'OUI' 
	Begin
		Set @iCasRefus = 1 

		Select Top 1 @sPara = m.id_para,
						@iCptTri  = m.cpt_tri,
						@dcIdGti = wg.id_gti
		From sysadm.motif m,
				sysadm.w_sin ws,
				sysadm.w_gar_sin wg
		Where ws.id_sin = @adcIdSin
		And   wg.id_sin = ws.id_sin
		And   m.id_prod = ws.id_prod
		And   m.id_motif = 612

		If @@RowCount = 0 Set @iCasRefus = 0

		If @sPara is null Set @sPara = ''
		If @iCptTri is null Set @iCptTri = 1
	End 


If Not Exists ( 
		Select	Top 1 1
		From	sysadm.condition c,
				sysadm.w_sin ws,
				sysadm.w_gar_sin wg
		Where	ws.id_sin = @adcIdSin
		And		wg.id_sin = ws.id_sin
		And		c.id_prod = ws.id_prod
		And		c.id_gti = wg.id_gti
		And		c.id_typ_code = '+DT'
		And		c.id_code = ws.id_detsin
		And		c.alt_reg = 'O'
	)
	Begin
		If @iCasRefus > 0 
			Begin
				Insert into sysadm.w_refus Values ( @adcIdSin, @dcIdGti, -1, 612, 'O', 'N', 0, @sPara, @iCptTri, GetDate(), GetDate (), 'JFF' ) 
				Return 2
			End
		Else
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Refus machine 612', 'Le refus machine 612 s''est déclenché. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1				
			End
	End 

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_DT386_REFUS_613
-- Auteur               :       Fabry JF
-- Date                 :       16/01/2016
-- Libellé              :
-- Commentaires         :      
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DT386_REFUS_613_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_DT386_REFUS_613_V01
GO

CREATE procedure sysadm.PS_I_DT386_REFUS_613_V01
	@adcIdSin   Decimal (10),
	@asChaineBcv VarChar (255)
AS

Declare @iCasRefus Integer
Declare @sPara VarChar ( 4 )
Declare @iCptTri Integer
Declare @dcIdGti Decimal ( 7 )

Set @iCasRefus = 0

-- [DF005-1-LOT2]
If ( Select sysadm.FN_CLE_VAL ( 'REFUS_AUTO', @asChaineBcv, ';') ) = 'OUI' 
	Begin
		Set @iCasRefus = 1 

		Select Top 1 @sPara = m.id_para,
						@iCptTri  = m.cpt_tri,
						@dcIdGti = wg.id_gti
		From sysadm.motif m,
				sysadm.w_sin ws,
				sysadm.w_gar_sin wg
		Where ws.id_sin = @adcIdSin
		And   wg.id_sin = ws.id_sin
		And   m.id_prod = ws.id_prod
		And   m.id_motif = 613

		If @@RowCount = 0 Set @iCasRefus = 0

		If @sPara is null Set @sPara = ''
		If @iCptTri is null Set @iCptTri = 1
	End 


If Not Exists ( 
		Select	Top 1 1
		From	sysadm.condition c,
				sysadm.w_sin ws,
				sysadm.w_gar_sin wg
		Where	ws.id_sin = @adcIdSin
		And		wg.id_sin = ws.id_sin
		And		c.id_prod = ws.id_prod
		And		c.id_gti = wg.id_gti
		And		c.id_typ_code = '+TR'
		And		c.id_code = ws.id_territ
		And		c.alt_reg = 'O'
	)
	Begin
			-- [DF005-1-LOT2]
		If @iCasRefus > 0 
			Begin
				Insert into sysadm.w_refus Values ( @adcIdSin, @dcIdGti, -1, 613, 'O', 'N', 0, @sPara, @iCptTri, GetDate(), GetDate (), 'JFF' ) 
				Return 2
			End
		Else
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Refus machine 613', 'Le refus machine 613 s''est déclenché. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1				
			End
	End 

Go


--------------------------------------------------------------------
-- Procédure            :       PS_I_DT386_REFUS_641
-- Auteur               :       Fabry JF
-- Date                 :       15/05/2019
-- Libellé              :
-- Commentaires         :      
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DT386_REFUS_641_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_DT386_REFUS_641_V01
GO

CREATE procedure sysadm.PS_I_DT386_REFUS_641_V01
	@adcIdSin   Decimal (10),
	@asChaineBcv VarChar (255)
AS

Declare @sValCar VarChar ( 10 )
Declare @iDp20 integer
Declare @iCasRefus Integer
Declare @sPara VarChar ( 4 )
Declare @iCptTri Integer
Declare @dcIdGti Decimal ( 7 )

Set @iCasRefus = 0

If ( Select sysadm.FN_CLE_VAL ( 'REFUS_AUTO', @asChaineBcv, ';') ) = 'OUI' 
	Begin
		Set @iCasRefus = 1 

		Select Top 1 @sPara = m.id_para,
						@iCptTri  = m.cpt_tri,
						@dcIdGti = wg.id_gti
		From sysadm.motif m,
				sysadm.w_sin ws,
				sysadm.w_gar_sin wg
		Where ws.id_sin = @adcIdSin
		And   wg.id_sin = ws.id_sin
		And   m.id_prod = ws.id_prod
		And   m.id_motif = 641

		If @@RowCount = 0 Set @iCasRefus = 0

		If @sPara is null Set @sPara = ''
		If @iCptTri is null Set @iCptTri = 1
	End 


Set @iDp20 = 0

Select @sValCar = dp.val_car, @iDp20 = 1
From sysadm.det_pro dp,
	 sysadm.w_sin ws
Where ws.id_sin = @adcIdSin
And   dp.id_prod = ws.id_prod
And	  dp.id_code_dp = 20

If Exists ( 
		Select	Top 1 1
		From	sysadm.w_sin ws,
				sysadm.produit p
		Where	ws.id_sin = @adcIdSin
		And		p.id_prod = ws.id_prod
		And		p.cod_tel > 0
		And		( @sValCar = '642' Or @iDp20 = 0 )
		And		( ws.dte_surv < ws.dte_ach_port Or ws.dte_surv < ws.dte_ouvlig_port )
	)
	Begin

		If @iCasRefus > 0 
			Begin
				Insert into sysadm.w_refus Values ( @adcIdSin, @dcIdGti, -1, 641, 'O', 'N', 0, @sPara, @iCptTri, GetDate(), GetDate (), 'JFF' ) 
				Return 2
			End
		Else
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Refus machine 641', 'Le refus machine 641 s''est déclenché. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End
		
	End 

Go


--------------------------------------------------------------------
-- Procédure            :       PS_I_DT386_REFUS_642
-- Auteur               :       Fabry JF
-- Date                 :       15/05/2019
-- Libellé              :
-- Commentaires         :      
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DT386_REFUS_642_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_DT386_REFUS_642_V01
GO

CREATE procedure sysadm.PS_I_DT386_REFUS_642_V01
	@adcIdSin   Decimal (10),
	@asChaineBcv VarChar (255)
AS

Declare @sValCar VarChar ( 10 )
Declare @iDp20 integer
Declare @iCasRefus Integer
Declare @sPara VarChar ( 4 )
Declare @iCptTri Integer
Declare @dcIdGti Decimal ( 7 )

Set @iCasRefus = 0

If ( Select sysadm.FN_CLE_VAL ( 'REFUS_AUTO', @asChaineBcv, ';') ) = 'OUI' 
	Begin
		Set @iCasRefus = 1 

		Select Top 1 @sPara = m.id_para,
						@iCptTri  = m.cpt_tri,
						@dcIdGti = wg.id_gti
		From sysadm.motif m,
				sysadm.w_sin ws,
				sysadm.w_gar_sin wg
		Where ws.id_sin = @adcIdSin
		And   wg.id_sin = ws.id_sin
		And   m.id_prod = ws.id_prod
		And   m.id_motif = 642

		If @@RowCount = 0 Set @iCasRefus = 0

		If @sPara is null Set @sPara = ''
		If @iCptTri is null Set @iCptTri = 1
	End 


Set @iDp20 = 0

Select @sValCar = dp.val_car, @iDp20 = 1
From sysadm.det_pro dp,
	 sysadm.w_sin ws
Where ws.id_sin = @adcIdSin
And   dp.id_prod = ws.id_prod
And	  dp.id_code_dp = 20

If Exists ( 
		Select	Top 1 1
		From	sysadm.w_sin ws,
				sysadm.produit p
		Where	ws.id_sin = @adcIdSin
		And		p.id_prod = ws.id_prod
		And		p.cod_tel > 0
		And		( @sValCar = '641' Or @iDp20 = 0 )
		And		( ws.dte_adh < ws.dte_ach_port Or ws.dte_adh < ws.dte_ouvlig_port )
	)
	Begin
		If @iCasRefus > 0 
			Begin
				Insert into sysadm.w_refus Values ( @adcIdSin, @dcIdGti, -1, 642, 'O', 'N', 0, @sPara, @iCptTri, GetDate(), GetDate (), 'JFF' ) 
				Return 2
			End
		Else
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Refus machine 642', 'Le refus machine 642 s''est déclenché. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1	
			End
	End 

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_DT386_REFUS_643
-- Auteur               :       Fabry JF
-- Date                 :       15/05/2019
-- Libellé              :
-- Commentaires         :      
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DT386_REFUS_643_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_DT386_REFUS_643_V01
GO

CREATE procedure sysadm.PS_I_DT386_REFUS_643_V01
	@adcIdSin   Decimal (10),
	@asChaineBcv VarChar (255)
AS

Declare @iCasRefus Integer
Declare @sPara VarChar ( 4 )
Declare @iCptTri Integer
Declare @dcIdGti Decimal ( 7 )

Set @iCasRefus = 0

-- [DF005-1-LOT2]
If ( Select sysadm.FN_CLE_VAL ( 'REFUS_AUTO', @asChaineBcv, ';') ) = 'OUI' 
	Begin
		Set @iCasRefus = 1 

		Select Top 1 @sPara = m.id_para,
						@iCptTri  = m.cpt_tri,
						@dcIdGti = wg.id_gti
		From sysadm.motif m,
				sysadm.w_sin ws,
				sysadm.w_gar_sin wg
		Where ws.id_sin = @adcIdSin
		And   wg.id_sin = ws.id_sin
		And   m.id_prod = ws.id_prod
		And   m.id_motif = 643

		If @@RowCount = 0 Set @iCasRefus = 0

		If @sPara is null Set @sPara = ''
		If @iCptTri is null Set @iCptTri = 1
	End 

If Exists ( 
		Select	Top 1 1
		From	sysadm.w_sin ws,
				sysadm.produit p,
				sysadm.det_pro dp
		Where	ws.id_sin = @adcIdSin
		And		p.id_prod = ws.id_prod
		And		p.cod_tel > 0
		And		dp.id_prod = ws.id_prod
		And		dp.id_code_dp = 131
		And		( ws.dte_adh > ws.dte_ach_port Or ws.dte_adh > ws.dte_ouvlig_port )
	)
	Begin
		If @iCasRefus > 0 
			Begin
				Insert into sysadm.w_refus Values ( @adcIdSin, @dcIdGti, -1, 643, 'O', 'N', 0, @sPara, @iCptTri, GetDate(), GetDate (), 'JFF' ) 
				Return 2
			End
		Else
			Begin
				Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Refus machine 643', 'Le refus machine 643 s''est déclenché. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
				Return -1
			End
	End 

Go

--------------------------------------------------------------------
-- Procédure            :       NI_PS_I_PC151379_TAG_COURRIER_REFUS
-- Auteur               :       Fabry JF
-- Date                 :       16/01/2019
-- Libellé              :		[PC151379]
-- Commentaires         :      
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
/* -- [DT386_EXTR_AXA]
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'NI_PS_I_PC151379_TAG_COURRIER_REFUS' AND type = 'P' )
        DROP procedure sysadm.NI_PS_I_PC151379_TAG_COURRIER_REFUS
GO

CREATE procedure sysadm.NI_PS_I_PC151379_TAG_COURRIER_REFUS
	@adcIdSin   Decimal (10),
	@asCodeCourrier	VarChar (10)
AS

	Insert into sysadm.w_div_sin 
	(
	id_sin,
	nom_zone,
	lib_label,
	id_typ_liste,
	alt_liste_codecar,
	id_typ_zone,
	alt_oblig,
	alt_prot,
	cpt_tri,
	val_nbre,
	val_mt,
	val_dte,
	val_car,
	cpt_valide,
	cree_le,
	maj_le,
	maj_par
	)
	Values 
	(
	@adcIdSin,
	'cour_refus_a_envksl_pc151379',
	'Cour.Refus à envoyer / KSL PC151379',
	-1,
	'N',
	'C',
	'N',
	'O',
	800,
	null,
	null,
	null,
	@asCodeCourrier,
	0,
	getdate (),
	Getdate (),
	'WEB'
	)

Go
*/

--------------------------------------------------------------------
-- Procédure            :       PS_I_DT386_PLAFOND_PEC
-- Auteur               :       Fabry JF
-- Date                 :       15/05/2019
-- Libellé              :
-- Commentaires         :      
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DT386_PLAFOND_PEC' AND type = 'P' )
        DROP procedure sysadm.PS_I_DT386_PLAFOND_PEC
GO

CREATE procedure sysadm.PS_I_DT386_PLAFOND_PEC
	@adcIdSin   Decimal (10)
AS

Declare @iRet Integer
Declare @iIdSeq Integer
Declare @dcIdRefPlaf decimal (7 )
Declare @sIdTypPlaf Integer
Declare @dcMtPlaf decimal ( 11,2 )
Declare @dcIdProd Decimal (7)
Declare @dcIdEts Decimal (7)
Declare @sIdAdh VarChar ( 19 )
Declare @sNumPort VarChar ( 25 ) 
Declare @dtDteSurv Datetime
Declare @dtDteRenouv DateTime
Declare @iNbAutreSin Integer
Declare @iSinEnCours Integer
Declare @dcIdEvt Decimal ( 7 )
Declare @dcMtPec Decimal ( 11, 2 )
Declare @dcMtValAchat Decimal ( 11, 2 )
Declare @dcMtValPublique Decimal ( 11, 2 )
Declare @sMarqApp VarChar ( 35 )
Declare @sModlApp VarChar ( 35 )
Declare @dcPrixPublic Decimal (11,2)
Declare @sTypApp varchar ( 10 )
Declare @iRefIfr Integer
Declare @dtDteAchPort DateTime
Declare @dcMtPlafReg Decimal ( 11, 2 )
Declare @dcIdGti Decimal (7 )
Declare @sMess VarChar ( 2000 )
Declare @sMtForfait varchar ( 20 )
Declare @dcMtValAchatMinMaj Decimal ( 11, 2 )
Declare @dcMtValPubliqueMinMaj Decimal ( 11, 2 )

-- Select '@dcMtPec', @dcMtPec

DECLARE @tb TABLE 
	( id_seq		integer identity,
	  id_ref_plaf	decimal (7 ),
	  id_typ_plaf	integer,
	  mt_plaf		decimal ( 11,2 ),
	  marquage		integer null 
	)


-- Ecriture valeur publique & -- Ecriture valeur d'achat
Select	@sMarqApp = rtrim ( marq_port), 
		@sModlApp = rtrim ( modl_port), 
		@dtDteAchPort = dte_ach_port 
From sysadm.w_sin Where id_sin = @adcIdSin

Select @sTypApp = Upper ( rtrim ( sysadm.FN_GET_DIV_SIN (@adcIdSin, 'type_app', 'W', 'RETOUR=CODE' ) ))
Select @dcMtValAchat = Convert ( decimal (11,2), sysadm.FN_GET_DIV_SIN (@adcIdSin, 'mt_val_achat_extr_axa', 'W', '' ) )

Select  @iRefIfr = Count ( * ) 
From	sysadm.w_sin ws,
		sysadm.det_pro dp
Where   ws.id_sin = @adcIdSin
And     dp.id_prod = ws.id_prod
And     dp.id_code_dp = 28
And     dp.id_code_car = 'IFR' + @sTypApp 

If @iRefIfr > 0 
  Begin 
	Exec sysadm.PS_S_SAGA2_INTERRO_IFR @sMarqApp, @sModlApp , @dcPrixPublic OUTPUT

	If @dcPrixPublic is null Set @dcPrixPublic = 0 

	If @dcPrixPublic > 0 
		Begin 
			Insert into w_div_sin Values ( @adcIdSin, 'mt_val_publique', 'Valeur publique de l''appareil', '-XX', 'N', 'S', 'N', 'O', 500, null, @dcPrixPublic , null, null, 0, getdate(), getdate(), 'WEB')
		End
	Else
		Begin
			Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Marq/Modl non dispo sur IFR', 'La marque et le modèle ne sont plus dispo sur IFR, contactez Sébastien Loison pour la réactiver. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
			Return -1
		End 
  End 

If @iRefIfr <= 0 
 Begin 
	Set @dcPrixPublic = 0 
 End 

If @dcPrixPublic = 0 Set @dcPrixPublic = @dcMtValAchat 

-- Insertion du détail.
Insert into w_detail 
Select 
@adcIdSin,
id_gti,
id_detail,
id_evt,
lib_det,
@dtDteAchPort,
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
@dcMtValAchat,
@dcPrixPublic,
num_facture
from sysadm.pm234_7_automate_wdt 
where id_sin = 7125418
And   id_gti = 54
And   id_detail = 0 



-- Stockage de données et pré-calcul
Select  @dcIdProd = ws.id_prod,
		@dcIdEts = ws.id_ets,
		@sIdAdh = rtrim ( ws.id_adh ),
		@sNumPort = rtrim ( ws.num_port ) ,
		@dtDteSurv = dte_surv,
		@dcIdEvt = wd.id_evt,
		@dcIdGti  = wd.id_gti, 
		@dcMtValAchat = wd.mt_val_achat,
		@dcMtValPublique = wd.mt_val_publique
From	sysadm.w_sin ws,
		sysadm.w_detail wd
Where	ws.id_sin = @adcIdSin
And		wd.id_sin = ws.id_sin 


Set @sNumPort = Replace ( rtrim ( @sNumPort ), ' ', '' )
Set @dtDteRenouv = sysadm.FN_DTE_RNV ( @adcIdSin )
Set @dcMtPec = @dcMtValAchat

-- /Stockage de données et pré-calcul

	-- Plafond et Détermination mt_pec.
		Insert into @tb
		Select	p.id_ref_plaf,
				p.id_typ_plaf,
				p.mt_plaf,
				0
				
		From	sysadm.plafond p,
				sysadm.w_sin ws,
				sysadm.w_detail wd
		where	ws.id_sin = @adcIdSin
		and		p.id_prod = ws.id_prod 
		and		p.id_rev  = ws.id_rev
		And		wd.id_sin = ws.id_sin
		and		p.id_gti = wd.id_gti 
		and		( p.id_ref_plaf = wd.id_evt or id_niv_plaf = '-GA' ) 
	

		While Exists ( Select Top 1 1 From @tb where marquage = 0 )
		 Begin
			Select 	Top 1 
				@iIdSeq = id_seq,
				@dcIdRefPlaf = id_ref_plaf,
				@sIdTypPlaf = id_typ_plaf,
				@dcMtPlaf = mt_plaf
			From	@tb
			Where	marquage = 0

			-- Plafond de garantie
			If @dcIdRefPlaf = -1
			  Begin
				-- Seuil d'intervention 747
				If @sIdTypPlaf = 747 And @dcMtValAchat < @dcMtPlaf
				  Begin
					Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Refus1765 déclenché', 'Seuil d''intervention déclenché, refus 1765 déclenché. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
					Return -1  
				  End 

				-- Plafond 751
				If @sIdTypPlaf = 751
				  Begin
					Set @iNbAutreSin = 0
				  	Exec sysadm.PS_S751_W_GTI_NBSIN_DTE_SURV 
						@adcIdSin, 
						@dcIdProd,
						@dcIdEts,
						@sIdAdh,
						@dtDteSurv,
						@dtDteRenouv,
						@iNbAutreSin OutPut

					Set @iSinEnCours = 1
					If @iNbAutreSin is null Set @iNbAutreSin = 0

					If @iSinEnCours + @iNbAutreSin > @dcMtPlaf
					 Begin
						Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Plafond 751 déclenché', 'Le plafond 751 s''est déclenché. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
						Return -1				
					 End 	
				  End 

				-- Plafond 697
				If @sIdTypPlaf = 697
				  Begin
					Set @iNbAutreSin = 0
				  	Exec sysadm.PS_S03_W_GTI_NBSIN 
						@adcIdSin, 
						@dcIdProd,
						@dcIdEts,
						@sIdAdh,
						@dtDteSurv,
						@dtDteRenouv,
						@iNbAutreSin OutPut

					Set @iSinEnCours = 1
					If @iNbAutreSin is null Set @iNbAutreSin = 0

					If @iSinEnCours + @iNbAutreSin > @dcMtPlaf
					 Begin
						Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Plafond 697 déclenché', 'Le plafond 697 s''est déclenché. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
						Return -1				
					 End 	
				  End 

				-- Plafond 750
				If @sIdTypPlaf = 750 
				  Begin
					Set @dcMtPlafReg = 0
				  	Exec sysadm.PS_S750_W_GTI_MT_PLAF 
						@adcIdSin, 
						@dcIdProd,
						@dcIdEts,
						@sIdAdh,
						@dtDteSurv,
						@dtDteRenouv,
						@dcMtPlafReg OutPut

					If @dcMtPlafReg is null Set @dcMtPlafReg = 0
					
					If @dcMtPec + @dcMtPlafReg > @dcMtPlaf And @dcMtPlaf > 0 Set @dcMtPec = @dcMtPlaf - @dcMtPlafReg
				  End 

				-- Plafond 693
				If @sIdTypPlaf = 693 
				  Begin
					Set @dcMtPlafReg = 0
				  	Exec sysadm.PS_S03_W_GTI_MT_PLAF 
						@adcIdSin, 
						@dcIdProd,
						@dcIdEts,
						@sIdAdh,
						@dcIdGti,
						@dtDteSurv,
						@dtDteRenouv,
						@dcMtPlafReg OutPut

					If @dcMtPlafReg is null Set @dcMtPlafReg = 0

					If @dcMtPec + @dcMtPlafReg > @dcMtPlaf And @dcMtPlaf > 0 Set @dcMtPec = @dcMtPlaf - @dcMtPlafReg

				  End 

			  End 
			  -- /Plafond de garantie

			-- Plafond d'évènement (détail de garantie)
			If @dcIdRefPlaf <> -1
			  Begin
				-- Plafond 704
				If @sIdTypPlaf = 704
				  Begin
					Set @iNbAutreSin = 0
				  	Exec sysadm.PS_S09_W_DETAIL_NBEVT 
						@adcIdSin, 
						@dcIdProd,
						@dcIdEts,
						@sIdAdh,
						@dcIdGti,
						@dcIdEvt,
						@dtDteSurv,
						@dtDteRenouv,
						@iNbAutreSin OutPut

					Set @iSinEnCours = 1
					If @iNbAutreSin is null Set @iNbAutreSin = 0

					If @iSinEnCours + @iNbAutreSin > @dcMtPlaf
					 Begin
						Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Plafond 704 déclenché', 'Le plafond 704 s''est déclenché. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
						Return -1				
					 End 	
				  End 

				-- Plafond 693
				If @sIdTypPlaf = 693 
				  Begin
					Set @dcMtPlafReg = 0
				  	Exec sysadm.PS_S03_W_DETAIL_MT_PLAF 
						@adcIdSin, 
						@dcIdProd,
						@dcIdEts,
						@sIdAdh,
						@dcIdGti,
						@dcIdEvt,
						@dtDteSurv,
						@dtDteRenouv,
						@dcMtPlafReg OutPut

					If @dcMtPlafReg is null Set @dcMtPlafReg = 0
					
					If @dcMtPec + @dcMtPlafReg > @dcMtPlaf And @dcMtPlaf > 0 Set @dcMtPec = @dcMtPlaf - @dcMtPlafReg
				  End 

				-- Plafond 680
				If @sIdTypPlaf = 680 And @dcIdRefPlaf = @dcIdEvt 
				  Begin
					If @dcMtPec > @dcMtPlaf And @dcMtPlaf > 0 Set @dcMtPec = @dcMtPlaf
				  End 
				-- /Plafond 680


				-- Plafond 671
				If @sIdTypPlaf = 671 And @dcIdRefPlaf = @dcIdEvt 
				  Begin
				    Set @dcMtValAchatMinMaj = @dcMtValAchat + ( @dcMtValAchat * @dcMtPlaf ) 
					If @dcMtPec > @dcMtValAchatMinMaj And @dcMtValAchatMinMaj > 0 Set @dcMtPec = @dcMtValAchatMinMaj
				  End 
				-- /Plafond 671

				-- Plafond 675
				If @sIdTypPlaf = 675 And @dcIdRefPlaf = @dcIdEvt 
				  Begin
				    Set @dcMtValPubliqueMinMaj = @dcMtValPublique + ( @dcMtValPublique * @dcMtPlaf ) 
					If @dcMtPec > @dcMtValPubliqueMinMaj And @dcMtValPubliqueMinMaj > 0 Set @dcMtPec = @dcMtValPubliqueMinMaj
				  End 
				-- /Plafond 675

			  End 
			-- /Plafond d'évènement (détail de garantie)

			Update @tb
			Set marquage = 1
			Where id_seq = @iIdSeq
		 End

	If @dcMtPec <= 0
		Begin
			Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Montant PEC à 0', 'Le plafond de prise déterminé par le système est de 0€. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
			Return -1				
		End 

	-- Forfait de réparation -dp/110
	If Exists ( 
		Select  Top 1 1
		From	sysadm.w_sin ws,
				sysadm.det_pro dp
		Where	ws.id_sin = @adcIdSin 
		And		dp.id_prod = ws.id_prod
		And		dp.id_code_dp = 110
		And     dp.id_code_car = @sTypApp
		And		@dcMtPec <= Convert ( Decimal ( 11, 2 ), sysadm.FN_CLE_VAL ( 'FORFAIT', dp.val_car, ';'))
		)
		Begin
			
			Select  Top 1 @sMtForfait = sysadm.FN_CLE_VAL ( 'FORFAIT', dp.val_car, ';')
			From	sysadm.w_sin ws,
					sysadm.det_pro dp
			Where	ws.id_sin = @adcIdSin 
			And		dp.id_prod = ws.id_prod
			And		dp.id_code_dp = 110
			And     dp.id_code_car = @sTypApp

			Set @sMess = 'Le montant de prise en charge (' + Convert ( varchar, @dcMtPec ) + '€) étant inférieur au forfait de réparation (' + @sMtForfait + '€), celle-ci n''est donc pas autorisée. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
			Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Forfait dépassé dp/110', @sMess
			Return -1
		End	

	-- Ecriture mt_pec (et autres données onglets Divers détail).
	Insert into sysadm.w_div_det
	Select 
		wd.id_sin,
		wd.id_gti,
		wd.id_detail,
		ap.nom_zone,
		ap.lib_label,
		ap.id_typ_liste,
		ap.alt_liste_codecar,
		ap.id_typ_zone,
		ap.alt_oblig,
		ap.alt_prot,
		ap.cpt_tri,
		ap.val_nbre,
		Case ap.nom_zone 
			When 'mt_pec' Then @dcMtPec
			Else ap.val_mt
		End,
		Case ap.nom_zone 
			When 'dte_pec' Then Convert ( VarChar ( 10 ) , Getdate(), 103 )
			Else ap.val_dte
		End,
		ap.val_car,
		ap.cpt_valide,
		Getdate(),
		Getdate(),
		'WEB'
	From sysadm.pm234_7_automate_pec ap,
		 sysadm.w_detail wd
	Where wd.id_sin = @adcIdSin
	And   ap.id_sin = 7125418 -- modèle
	And   ap.id_gti = 54 -- modèle
	And   ap.id_detail = 0 -- modèle

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_DT386_CREATION_PRESTA
-- Auteur               :       Fabry JF
-- Date                 :       21/05/2019
-- Libellé              :
-- Commentaires         :      
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      25/09/2019   [DT386_EXTR_AXA_V8]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DT386_CREATION_PRESTA' AND type = 'P' )
        DROP procedure sysadm.PS_I_DT386_CREATION_PRESTA
GO

CREATE procedure sysadm.PS_I_DT386_CREATION_PRESTA
	@adcIdSin   Decimal (10)
AS

Declare @sMarqPort VarChar ( 35 )
Declare @sModlPort VarChar ( 35 )
Declare @sIdFourModif VarChar ( 35 )
Declare @dcIdEvt Decimal ( 7 )
Declare @sIdFourDp200 VarChar ( 10 )
Declare @iFinTrt Integer
--Declare @sTypLivrExtrAtm VarChar ( 10 )
Declare @sSkuIFR VarChar ( 50 )
Declare @sCodeVerrou VarChar ( 50 )
--Declare @sCodeLivraisonExtrAtm VarChar ( 50 )
Declare @sAction VarChar ( 50 )
--Declare @sCodeBtqPSMCentr VarChar ( 50 )
Declare @sCodeCourrier VarChar ( 10 )
Declare @dcIdProd Decimal ( 7 )
Declare @sIdCour VarChar ( 20 )
Declare @sVal VarChar ( 20 )

Set @iFinTrt = 0
Set @sAction = 'A_REPARER'
Set @sCodeCourrier = ''

-- [DT386_EXTR_AXA]
-- Stockage de données et pré-calcul
Select  @sMarqPort = rtrim ( ws.marq_port ),
		@sModlPort = rtrim ( ws.modl_port ),
		@dcIdEvt   = wd.id_evt,
		@dcIdProd = ws.id_prod  -- [DT288]
From	sysadm.w_sin ws,
		sysadm.w_detail wd
Where	ws.id_sin = @adcIdSin
And		wd.id_sin = ws.id_sin

Select Top 1 @sSkuIFR = rtrim ( i.sku_saga )
From sysadm.w_sin ws,
		sysadm.w_div_sin wds,
		sysadm.ifr i
Where ws.id_sin = @adcIdSin 
And   i.marque = ws.marq_port
And   i.reference = ws.modl_port
And   wds.id_sin = ws.id_sin
And   wds.nom_zone = 'type_app'
And   wds.val_car in ( 'TEL' )
And   ( Left ( i.sku_saga, 3 ) = wds.val_car
		Or 
		i.sku_saga is null )

If @sSkuIFR is null Set @sSkuIFR = ''

Select	@sCodeVerrou = rtrim ( wds.val_car )
From	sysadm.w_div_sin wds
Where	wds.id_sin = @adcIdSin
And		wds.nom_zone = 'code_verrou_sherpa_script'

If @sCodeVerrou is null Set @sCodeVerrou = 'Pas de code verrou'

/* -- [DT386_EXTR_AXA]
Select	@sCodeLivraisonExtrAtm = rtrim ( wds.val_car )
From	sysadm.w_div_sin wds
Where	wds.id_sin = @adcIdSin
And		wds.nom_zone = 'code_livraison_extr_atm'


If @sCodeLivraisonExtrAtm is null Set @sCodeLivraisonExtrAtm = ''

Select	@sCodeBtqPSMCentr = rtrim ( wds.val_car )
From	sysadm.w_div_sin wds
Where	wds.id_sin = @adcIdSin
And		wds.nom_zone = 'code_psm_centra_extr_atm'

If @sCodeBtqPSMCentr is null Set @sCodeBtqPSMCentr = ''
*/


-- Détermination du fournisseur
Set @sIdFourModif = 'O2M'

/* -- [DT386_EXTR_AXA]
If  CharIndex ( 'APPLE', @sMarqPort ) > 0 And 
	( CharIndex ( 'IPAD', @sModlPort ) > 0 Or CharIndex ( 'IPHONE', @sModlPort ) > 0 ) And
	@iFinTrt = 0
 Begin 
	Set @iFinTrt = 1
  
	Select Top 1 @sIdFourDp200 = sysadm.FN_CLE_VAL ( 'ID_FOUR', val_car, ';') 
	From   sysadm.det_pro dp,
			sysadm.w_sin ws
	Where  ws.id_sin = @adcIdSin
	And	   dp.id_prod = ws.id_prod
	And    dp.id_code_dp = 200
	And	   CharIndex ( sysadm.FN_CLE_VAL ( 'MODELE', val_car, ';') , ws.modl_port ) > 0 

	If @sIdFourDp200 is not null And Len ( @sIdFourDp200 ) > 0 
	  Begin
		Set @sIdFourModif = @sIdFourDp200
	  End 

	If @sIdFourModif <> 'PSM'
	  Begin
		Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Problème dp/200 Fourn Répa APPLE', 'Problème de paramétrage de l''option dp/200, le fournisseur réparant la APPLE a changé. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
		Return -1	
	  End
 End 
 */ 
 -- Préparation insertion presta
 Set @iFinTrt = 0

 -- [DT386_EXTR_AXA]
 If @sIdFourModif = 'O2M'
	And @iFinTrt = 0
   Begin

		Set @iFinTrt = 1

		Insert into sysadm.w_commande 
		Select 
			wdt.id_sin,
			1,
			wdt.id_gti,
			wdt.id_detail,
			prs.id_four,
			prs.id_typ_art,
			@sMarqPort,
			@sModlPort,
			prs.mt_ttc_cmde,
			rTrim ( ws.nom ),
			rTrim ( ws.prenom ),
			rtrim ( wiA.adr_1 ),
			rtrim ( wiA.adr_2 ),
			prs.adr_livr_cpl,
			rtrim ( wiA.adr_cp ),
			rtrim ( wiA.adr_ville ),
			IsNull ( IsNull ( IsNull ( rtrim (wiA.num_teld), rtrim (wiA.num_telb )), rtrim (ws.num_port )), ''),
			IsNull ( IsNull ( IsNull ( rtrim (wiA.num_telb), rtrim (wiA.num_teld )), rtrim (ws.num_port )), ''),
			prs.adr_tel3,
			prs.adr_mail,
			prs.dte_rdv_cli,
			prs.hrdv_cli_min,
			prs.hrdv_cli_max,
			ws.num_imei_port,
				Upper ( 
				Replace ( Replace ( Replace ( Replace ( Replace ( 
				Replace ( rtrim ( ws.txt_mess), '''', '' ), 
				char ( 13 ), '' ),
				char ( 10 ), '' ),
				char ( 9 ), '' ),
				char ( 11 ), '' ),
				'"', '' )
				),  
			prs.id_cmd_frn,
			prs.id_serie_nouv,
			prs.id_bon_transp,
			prs.dte_rcp_frn,
			prs.dte_env_cli,
			prs.cod_etat,
			null,
			prs.cpt_valide,
			'Automate AXA/SIMPA2',
			Getdate(),
			Getdate(),
			'WEB',
			prs.id_zone,
			prs.id_bsp,
			prs.dte_ret_pret,
			rtrim ( wiA.cod_civ ),
			prs.id_ref_four,
			prs.id_orian_marque,
			prs.id_orian_modele,
			prs.dte_elv_mobile,
			prs.status_gc,
			prs.dte_emis_devis,
			prs.mt_devis,
			prs.alt_dev_acp,
			prs.dte_dev_acp,
			prs.adrfc_cod_civ,
			prs.adrfc_nom,
			prs.adrfc_prenom,
			prs.adrfc_livr1,
			prs.adrfc_livr2,
			prs.adrfc_livr_cpl,
			prs.adrfc_cp,
			prs.adrfc_ville,
			prs.dte_ret_logis,
			prs.dte_ret_pret_min,
			prs.dte_ret_pret_max,
			prs.id_ann,
			prs.dte_env_bte_frn,
			prs.dte_rcp_bte_cli,
			prs.dte_dep_bte_cli,
			prs.dte_env_st,
			prs.dte_rcp_mob_cli,
			prs.info_spb_frn,
			prs.id_marq_art_ifr,
			prs.id_modl_art_ifr,
				sysadm.FN_CLE_VAL_E ( 'MAIL_ASSURE', rtrim ( wiA.adr_mail ) ,
				sysadm.FN_CLE_VAL_E ( 'TYP_PCE_IDENT', sysadm.FN_GET_DIV_SIN ( @adcIdSin, 'type_pce_identite', 'W', 'RETOUR=CODE'), 
				sysadm.FN_CLE_VAL_E ( 'AUTOR_PCE_IDENT', sysadm.FN_GET_DIV_SIN ( @adcIdSin, 'autorite_pce_identite', 'W', 'RETOUR=CODE'), 
				sysadm.FN_CLE_VAL_E ( 'NUM_PCE_IDENT', sysadm.FN_GET_DIV_SIN ( @adcIdSin, 'num_pce_identite', 'W', 'RETOUR=CODE'), 
				sysadm.FN_CLE_VAL_E ( 'DTE_DELIVR_PI', sysadm.FN_GET_DIV_SIN ( @adcIdSin, 'dte_delivrance_pi', 'W', 'RETOUR=CODE'), 
				sysadm.FN_CLE_VAL_E ( 'DTE_FIN_VAL_PI', sysadm.FN_GET_DIV_SIN ( @adcIdSin, 'dte_fin_val_pi', 'W', 'RETOUR=CODE'), 
				sysadm.FN_CLE_VAL_E ( 'AUTO_AXA', 'OUI', 
				sysadm.FN_CLE_VAL_E ( 'SKU_IFR', @sSkuIFR, 
				sysadm.FN_CLE_VAL_E ( 'MT_PEC', Convert ( VarChar ( 20 ), wdd.val_mt ), rtrim ( prs.info_spb_frn_cplt ), ';' )
				, ';' )
				, ';' )
				, ';' )
				, ';' )
				, ';' )
				, ';' )
				, ';' )
				, ';' ),
			prs.info_frn_spb_cplt

		From sysadm.pm234_7_automate_prs prs,
			 sysadm.w_detail wdt,
			 sysadm.w_inter wiA,
			 sysadm.w_sin ws,
			 sysadm.w_div_det wdd

		Where prs.id_sin = 7125418 -- Modèle
		And	  prs.id_seq = 1 -- Modèle
		And	  wdt.id_sin = @adcIdSin
		And   wdt.id_detail = 0
		And   wiA.id_sin = wdt.id_sin 
		And	  wiA.cod_inter = 'A'
		And	  ws.id_sin = wdt.id_sin
		And   wdd.id_sin = wdt.id_sin
		And   wdd.id_gti = wdt.id_gti
		And   wdd.id_detail = wdt.id_detail
		And   wdd.nom_zone = 'mt_pec'

		/*  -- [DT386_EXTR_AXA]  Vu avec Maryline, pas de courrier KSL, juste le mailpush SIMPA2.
		If @@ROWCOUNT = 1 
		  Begin
			Set @sIdCour = 'WTE223'

			-- acutellement 'WTE615'...
			Select @sVal = sysadm.FN_CLE_VAL ( 'WTE223_MODIFIE_EN', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';' ) 
			From  sysadm.w_sin ws,
				  sysadm.det_pro dp
			Where ws.id_sin = @adcIdSin
			And   dp.id_prod = ws.id_prod
			And   dp.id_code_dp = 209

			If @sVal is null Set @sVal = ''
			If @sVal <> '' Set @sIdCour = @sVal

			/* Pas de KSL pour l'instant, vu avec Marin/Maryline
			Exec sysadm.PS_I_PC151379_TAG_COURRIER_PEC @adcIdSin, @sIdCour
			*/
		  End 
		  */

   End 


If @iFinTrt = 0
	Begin
		Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Pas de cas prestation détectée', 'Le système n''a pas pu détecter de cas de prestation à envoyer en fonction des données transmises par l''extranet AXA. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
		Return -1				
	End 

Go


--------------------------------------------------------------------
-- Procédure            :       sysadm.PS_I_DT386_ETAT_VALIDATION
-- Auteur               :       Fabry JF
-- Date                 :       15/05/2019
-- Libellé              :
-- Commentaires         :      
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      22/10/2019   [PI087_PM473_2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DT386_ETAT_VALIDATION' AND type = 'P' )
        DROP procedure sysadm.PS_I_DT386_ETAT_VALIDATION
GO

CREATE procedure sysadm.PS_I_DT386_ETAT_VALIDATION
	@adcIdSin   Decimal (10),
	@aiLigneSecondaire Integer,
	@asChaineBcv	VarChar ( 255)
AS

Declare @dcIdGti Decimal ( 7 )
Declare @sCodOper       Varchar (  4   )
Declare @sNoBoite       Varchar ( 10   )
Declare @sProc          Varchar ( 60   )
Declare @dtValideLe     DateTime        
Declare @sMethode	VarChar ( 3 )      
Declare @iRet Integer
Declare @sMsgTemp VarChar ( 500 ) 
Declare @iIdCt Integer
Declare @dDteRecu Datetime
Declare @dDteFinGti Datetime
Declare @sErr varchar(60)
Declare @dcIdCorb Decimal ( 3 )
Declare @dtCreeLeDos DateTime
Declare @iCtrle Integer
Declare @iCasRefus Integer 
Declare @iCodeEtat Integer 
Declare @sMsgSucces VarChar ( 35)
Declare @iPresenceW Integer 

-- [DF005-1-LOT2]
Set @iPresenceW = 0
Set @iCodeEtat = 100
Set @iCasRefus = 0 

-- [DF005-1-LOT2]
If ( Select sysadm.FN_CLE_VAL ( 'CAS', @asChaineBcv, ';') ) = 'REFUS_AUTO' 
	Begin
		Set @iCasRefus = 1 
		Set @iCodeEtat = 200
	End 

Select	@dcIdGti = wg.id_gti
From	sysadm.w_gar_sin wg
Where	wg.id_sin = @adcIdSin

-- Détermination des codes états.
-- [DF005-1-LOT2]
	Update sysadm.w_detail
	Set cod_dec_mac = @iCodeEtat, 
		cod_dec_ope = @iCodeEtat, 
		cod_etat = @iCodeEtat, 
		alt_att = 'O',
		maj_le = getdate(),
		maj_par = 'WEB'
	Where id_sin = 	@adcIdSin
	And   id_gti =  @dcIdGti

	Update sysadm.w_gar_sin 
	Set cod_dec_mac = sysadm.FN_GET_ETAT_GARANTIE_PM251 ( @adcIdSin , @dcIdGti, 'W') 
	Where id_sin = 	@adcIdSin
	And   id_gti =  @dcIdGti

	Update sysadm.w_gar_sin
	set	cod_dec_ope = cod_dec_mac,
		cod_etat = cod_dec_mac,
		maj_le = getdate(),
		maj_par = 'WEB'
	Where  id_sin = @adcIdSin
	And    id_gti = @dcIdGti

	Update sysadm.w_sin
	Set	cod_dec_mac = sysadm.FN_GET_ETAT_DOSSIER_PM251 ( @adcIdSin, 'W' )
	Where  id_sin = @adcIdSin

	Update sysadm.w_sin
	Set	cod_dec_ope = cod_dec_mac,
		cod_etat = cod_dec_mac,
		maj_le = getdate(),
		maj_par = 'WEB'
	Where  id_sin = @adcIdSin	


	If Not Exists ( 
			Select Top 1 1 
			From sysadm.routage r
			Where r.id_sin = @adcIdSin
		)
		Begin
			Select @dcIdCorb = p.id_corb,
				   @dtCreeLeDos = ws.cree_le
			From   sysadm.w_sin ws,
				   sysadm.produit p
			Where  ws.id_sin = @adcIdSin
			And    p.id_prod = ws.id_prod

			Insert into sysadm.routage values  ( @adcIdSin, 'N', @dcIdCorb, 'X', 'DEC', 'N', @dtCreeLeDos , @dtCreeLeDos , 'WEB', null, null, null, null,null )
		End 

--  Obligé de recreer un travail avant de validation, sinon problème technique

	Select  @dDteRecu=getdate(),
			@dDteFinGti=s.dte_fin_gti
	From sysadm.w_sin s
	Where s.id_sin = @adcIdSin

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		exec SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V03
					@adcIdSin
					,2
					,''
					,'WEB'
					,@sErr OUTPUT
					,@iIdCt OUTPUT
					,@dDteFinGti
					,'C'
					,@dDteRecu
					,0
	END
	ELSE
	BEGIN
		exec SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V03
					@adcIdSin
					,2
					,''
					,'WEB'
					,@sErr OUTPUT
					,@iIdCt OUTPUT
					,@dDteFinGti
					,'C'
					,@dDteRecu
					,0
	END

	-- Le travail doit être occupé !!
	Update w_queue set alt_occupe = 'O' where id_sin = @adcIdSin


--  Validation
	Set @sCodOper = 'WEB'
	Set @sNoBoite = ''
	Set @sProc = Space ( 35 )
	Set @dtValideLe = getdate()
	set @sMethode = 'SVE'


	Exec @iRet = sysadm.PS_VALIDATION
			@adcIdSin,
			@sCodOper,
			@sNoBoite,
			@sProc OUTPUT,
			@dtValideLe OUTPUT,
			@sMethode

	If @iRet < 0 
		Begin
			Set @sMsgTemp = 'Problème lors de la validation automatique, code (' + Convert ( VarChar ( 10 ), @iRet ) + '). Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
			Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Problème validation auto 1', @sMsgTemp 
			Return -1				
		End 

	Delete sysadm.w_queue Where id_sin = @adcIdSin
	Update sysadm.routage Set alt_queue = 'N', cod_travail = 'CPL' Where id_sin = @adcIdSin

-- Finalisation validation
	Delete sysadm.w_div_sin where id_sin = @adcIdSin and nom_zone in ( 'zn_tmp_cas_gestion', 'zn_tmp_PM103_1', 'ctl_sepa')
	Exec sysadm.PS_I_DIV_SIN_ETAT_ASS @adcIdSin, 'WEB'


	-- [DF005-1-LOT2]
	If Exists ( Select top 1 1 From sysadm.w_sin where id_sin = @adcIdSin )
		Begin
			Set @iPresenceW = 1
		End 

-- Je laisse exprès la PS du PM234, pas la peine de la doubler.
	Exec @iCtrle = sysadm.PS_I_PM234_7_CTRL_APRES_VALIDATION @adcIdSin

	If @iCtrle < 0 
	  Begin
		Delete sysadm.commande Where id_sin = @adcIdSin
		Delete sysadm.w_commande Where id_sin = @adcIdSin


		Set @sMsgTemp = 'Problème lors de la validation automatique, (nbre lignes/cpt_valide). Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
		Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Problème validation auto 2', @sMsgTemp 

		Return -1

	  End 
	
	If @iCtrle > 0 
	  Begin

	  Set @sMsgSucces = 'Succès automatisation AXA/SIMPA2'

	  -- [DF005-1-LOT2]
		If @iCasRefus > 0 
			Begin
				Set @sMsgSucces = 'Succès automatisation AXA/SIMPA2 (Refus)'
			End 

		If @iPresenceW > 0 
		  Begin

		-- Taguer que le dossier a subi l'automatisation avec succès + contact (sans travail bien sûr)
			Insert into sysadm.w_div_sin 
			(
			id_sin,
			nom_zone,
			lib_label,
			id_typ_liste,
			alt_liste_codecar,
			id_typ_zone,
			alt_oblig,
			alt_prot,
			cpt_tri,
			val_nbre,
			val_mt,
			val_dte,
			val_car,
			cpt_valide,
			cree_le,
			maj_le,
			maj_par
			)
			Values 
			(
			@adcIdSin,
			'dt386_auto_ok',
			@sMsgSucces,
			-1,
			'N',
			'X',
			'N',
			'O',
			800,
			null,
			null,
			null,
			'O',
			1,
			getdate (),
			Getdate (),
			'WEB'
			)
		  End 

		Insert into sysadm.div_sin 
		(
		id_sin,
		nom_zone,
		lib_label,
		id_typ_liste,
		alt_liste_codecar,
		id_typ_zone,
		alt_oblig,
		alt_prot,
		cpt_tri,
		val_nbre,
		val_mt,
		val_dte,
		val_car,
		cree_le,
		maj_le,
		maj_par,
		valide_le,
		valide_par
		)
		Values 
		(
		@adcIdSin,
		'dt386_auto_ok',
		@sMsgSucces,
		-1,
		'N',
		'X',
		'N',
		'O',
		800,
		null,
		null,
		null,
		'O',
		getdate (),
		Getdate (),
		'WEB',
		Getdate (),
		'WEB'
		)


		Set @sMsgTemp = 'Automatisation de la déclaration réussie, la prestation est créée et le dossier est validé.'
	
		-- [DF005]
		If @aiLigneSecondaire > 0 
			Begin
				Set @sMsgTemp = 'Automatisation de la déclaration réussie, dossier en attente de pièces.'
			End 

	    -- [DF005-1-LOT2]
		If @iCasRefus > 0 
			Begin
			Set @sMsgSucces = 'Automatisation de la déclaration réussie, le dossier est refusé et validé.'
			End 

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @adcIdSin, 2, @sMsgTemp,	'WEB', 300, @iIdCt OUTPUT							
		END
		ELSE
		BEGIN
			Exec SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 -1, 2, 4, 'C', @adcIdSin, 2, @sMsgTemp,	'WEB', 300, @iIdCt OUTPUT							
		END	
	End 

	-- [PI087_PM473_2]
	Exec sysadm.PS_I_PI087_TRACE_DOSSIER @adcIdSin, 'VALIDATION', 'WEB'
Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_DT386_REJET
-- Auteur               :       Fabry JF
-- Date                 :       15/05/2019
-- Libellé              :
-- Commentaires         :      [PS_REJET]
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DT386_REJET' AND type = 'P' )
        DROP procedure sysadm.PS_I_DT386_REJET
GO

CREATE procedure sysadm.PS_I_DT386_REJET
	@adcIdSin   Decimal (10),
	@asMsg1		VarChar (35),
	@asMsg2		VarChar (500)
AS

	Declare @sErr  Varchar(60)
	Declare @iIdCt integer	
	DECLARE @sOper varchar(4)
	DECLARE @dcIdProd Decimal ( 7 )
	DECLARE @iIdProd Integer 
	Declare @dcIdCorb Decimal ( 3 )
	Declare @dtCreeLeDos DateTime
	Declare @iPresenceW Integer 
	Declare @iPresenceS Integer 

	-- [DF005-1-LOT2]
	Set @iPresenceW = 0
	Set @iPresenceS = 0

	If Exists ( Select top 1 1 From sysadm.w_sin where id_sin = @adcIdSin )
		Begin
			Set @iPresenceW = 1
		End 

	If Exists ( Select top 1 1 From sysadm.sinistre where id_sin = @adcIdSin )
		Begin
			Set @iPresenceS = 1
		End 

	IF @iPresenceW > 0 
	  Begin
		Select @dcIdProd = ws.id_prod
		From   sysadm.w_sin ws
		Where  id_sin = @adcIdSin
	  End 
	Else
	  Begin
		Select @dcIdProd = ws.id_prod
		From   sysadm.sinistre ws
		Where  id_sin = @adcIdSin
	  End 

	Set @iIdProd = Convert ( Integer, @dcIdProd ) 

	Set @asMsg1 = lTrim ( rtrim ( Left ( @asMsg1, 35)))
	If @asMsg1 is null set @asMsg1 = ''

	Set @asMsg2 = lTrim ( rtrim ( Left ( @asMsg2, 500)))
	If @asMsg2 is null set @asMsg2 = ''

	Set @asMsg2 = 'ERREUR / Rejet Automatisation :' + @asMsg2 

	IF @iPresenceW > 0 
	  Begin
			Insert into sysadm.w_div_sin 
			(
			id_sin,
			nom_zone,
			lib_label,
			id_typ_liste,
			alt_liste_codecar,
			id_typ_zone,
			alt_oblig,
			alt_prot,
			cpt_tri,
			val_nbre,
			val_mt,
			val_dte,
			val_car,
			cpt_valide,
			cree_le,
			maj_le,
			maj_par
			)
			Values 
			(
			@adcIdSin,
			'rejet_dt386_cac',
			'Rejet automatisation AXA',
			-1,
			'N',
			'X',
			'N',
			'O',
			800,
			null,
			null,
			null,
			'O',
			@iPresenceS,
			getdate (),
			Getdate (),
			'WEB'
			)

		Insert into sysadm.w_div_sin 
		(
		id_sin,
		nom_zone,
		lib_label,
		id_typ_liste,
		alt_liste_codecar,
		id_typ_zone,
		alt_oblig,
		alt_prot,
		cpt_tri,
		val_nbre,
		val_mt,
		val_dte,
		val_car,
		cpt_valide,
		cree_le,
		maj_le,
		maj_par
		)
		Values 
		(
		@adcIdSin,
		'rejet_dt386_msg',
		'Rejet automatisation AXA (Msg)',
		-1,
		'N',
		'C',
		'N',
		'O',
		801,
		null,
		null,
		null,
		@asMsg1,
		@iPresenceS,
		getdate (),
		Getdate (),
		'WEB'
		)

		Insert into sysadm.w_div_sin 
		(
		id_sin,
		nom_zone,
		lib_label,
		id_typ_liste,
		alt_liste_codecar,
		id_typ_zone,
		alt_oblig,
		alt_prot,
		cpt_tri,
		val_nbre,
		val_mt,
		val_dte,
		val_car,
		cpt_valide,
		cree_le,
		maj_le,
		maj_par
		)
		Values 
		(
		@adcIdSin,
		'dcnx_decla_extr_axa',
		'Déconnexion définitive décla AXA',
		-1,
		'N',
		'X',
		'N',
		'O',
		907,
		null,
		null,
		null,
		'O',
		@iPresenceS,
		getdate (),
		Getdate (),
		'WEB'
		)
  
	  End 

	IF @iPresenceS > 0 
	  Begin
			Insert into sysadm.div_sin 
			(
			id_sin,
			nom_zone,
			lib_label,
			id_typ_liste,
			alt_liste_codecar,
			id_typ_zone,
			alt_oblig,
			alt_prot,
			cpt_tri,
			val_nbre,
			val_mt,
			val_dte,
			val_car,
			cree_le,
			maj_le,
			maj_par,
			valide_le,
			valide_par
			)
			Values 
			(
			@adcIdSin,
			'rejet_dt386_cac',
			'Rejet automatisation AXA',
			-1,
			'N',
			'X',
			'N',
			'O',
			800,
			null,
			null,
			null,
			'O',
			getdate (),
			Getdate (),
			'WEB',
			Getdate (),
			'WEB'
			)

		Insert into sysadm.div_sin 
		(
		id_sin,
		nom_zone,
		lib_label,
		id_typ_liste,
		alt_liste_codecar,
		id_typ_zone,
		alt_oblig,
		alt_prot,
		cpt_tri,
		val_nbre,
		val_mt,
		val_dte,
		val_car,
		cree_le,
		maj_le,
		maj_par,
		valide_le,
		valide_par
		)
		Values 
		(
		@adcIdSin,
		'rejet_dt386_msg',
		'Rejet automatisation AXA (Msg)',
		-1,
		'N',
		'C',
		'N',
		'O',
		801,
		null,
		null,
		null,
		@asMsg1,
		getdate (),
		Getdate (),
		'WEB',
		Getdate (),
		'WEB'
		)

		Insert into sysadm.div_sin 
		(
		id_sin,
		nom_zone,
		lib_label,
		id_typ_liste,
		alt_liste_codecar,
		id_typ_zone,
		alt_oblig,
		alt_prot,
		cpt_tri,
		val_nbre,
		val_mt,
		val_dte,
		val_car,
		cree_le,
		maj_le,
		maj_par,
		valide_le,
		valide_par
		)
		Values 
		(
		@adcIdSin,
		'dcnx_decla_extr_axa',
		'Déconnexion définitive décla AXA',
		-1,
		'N',
		'X',
		'N',
		'O',
		906,
		null,
		null,
		null,
		'O',
		getdate (),
		Getdate (),
		'WEB',
		Getdate (),
		'WEB'
		)
  
	  End 


	If Not Exists ( 
			Select Top 1 1 
			From sysadm.routage r
			Where r.id_sin = @adcIdSin
		)
		Begin
			Select @dcIdCorb = p.id_corb,
				   @dtCreeLeDos = ws.cree_le
			From   sysadm.w_sin ws,
				   sysadm.produit p
			Where  ws.id_sin = @adcIdSin
			And    p.id_prod = ws.id_prod

			Insert into sysadm.routage values  ( @adcIdSin, 'N', @dcIdCorb, 'X', 'DEC', 'N', @dtCreeLeDos , @dtCreeLeDos , 'WEB', null, null, null, null,null )
		End 

	IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
	BEGIN
		-- [MANTIS22772]
		/*
		EXEC SHERPA_PRO.sysadm.[Atlas_Orange_Get_Oper_V101]  @iIdProd ,@sOper OUTPUT
		If @sOper is null Set @sOper = 'WEB'
		Set @sOper = rtrim ( ltrim ( @sOper )) 
		*/

		Set @sOper = 'WEB'

		EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @adcIdSin, 2, @asMsg2, @sOper , @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'E'
	END
	ELSE
	BEGIN
		/*
		-- [MANTIS22772]
		EXEC SHERPA_SIM.sysadm.[Atlas_Orange_Get_Oper_V101]  @iIdProd ,@sOper OUTPUT
		If @sOper is null Set @sOper = 'WEB'
		Set @sOper = rtrim ( ltrim ( @sOper )) 
		*/

		Set @sOper = 'WEB'

		EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @adcIdSin, 2, @asMsg2, @sOper, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'E'
	END


Go

--------------------------------------------------------------------
-- Procédure            :       NI_PS_I_PC151379_TAG_COURRIER_PEC
-- Auteur               :       Fabry JF
-- Date                 :       18/01/2019
-- Libellé              :
-- Commentaires         :      
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
/*
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'NI_PS_I_PC151379_TAG_COURRIER_PEC' AND type = 'P' )
        DROP procedure sysadm.NI_PS_I_PC151379_TAG_COURRIER_PEC
GO

CREATE procedure sysadm.NI_PS_I_PC151379_TAG_COURRIER_PEC
	@adcIdSin   Decimal (10),
	@asCodeCourrier	VarChar (10)
AS

	Insert into sysadm.w_div_sin 
	(
	id_sin,
	nom_zone,
	lib_label,
	id_typ_liste,
	alt_liste_codecar,
	id_typ_zone,
	alt_oblig,
	alt_prot,
	cpt_tri,
	val_nbre,
	val_mt,
	val_dte,
	val_car,
	cpt_valide,
	cree_le,
	maj_le,
	maj_par
	)
	Values 
	(
	@adcIdSin,
	'cour_pec_a_envksl_pc151379',
	'Cour. PEC à envoyer / KSL PC151379',
	-1,
	'N',
	'C',
	'N',
	'O',
	800,
	null,
	null,
	null,
	@asCodeCourrier,
	0,
	getdate (),
	Getdate (),
	'WEB'
	)

Go
*/

--------------------------------------------------------------------
-- Procédure            :       PS_I_DT386_REFUS_REVISION
-- Auteur               :       Fabry JF
-- Date                 :       15/05/2019
-- Libellé              :
-- Commentaires         :      
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_DT386_REFUS_REVISION' AND type = 'P' )
        DROP procedure sysadm.PS_I_DT386_REFUS_REVISION
GO

CREATE procedure sysadm.PS_I_DT386_REFUS_REVISION
	@adcIdSin   Decimal (10)
AS

Declare @dtDteAdh DateTime
Declare @dtDteSurv DateTime
Declare @dcIdProd Decimal ( 7 )
Declare @sRev     VarChar ( 10 )

Select @dtDteSurv = dte_surv,
	   @dtDteAdh = dte_adh,
	   @dcIdProd = id_prod
From   sysadm.w_sin Where id_sin = @adcIdSin

Set @sRev = Space ( 10 )

Exec sysadm.PS_X_CALC_REVISION @dcIdProd, @dtDteSurv, @dtDteAdh, @sRev OUTPUT

If	@sRev is null Or @sRev = '-1'
	Begin
		Exec sysadm.PS_I_DT386_REJET @adcIdSin, 'Avenant/Révision non déterminé', 'Le système n''a pas pu déterminer d''avenant (de révision) sur ce dossier. Automatisation du process AXA via EXTR_AXA/SIMPA2 impossible donc.'
		Return -1				
	End
Else
	Begin
		Update sysadm.w_sin Set id_rev = Convert ( Decimal ( 7 ), @sRev ) Where id_sin = @adcIdSin
	End

Go


--------------------------------------------------------------------
--
-- Procédure            :       NI_PS_S_PC151379_COUR_PEC
-- Auteur               :       Fabry JF
-- Date                 :       03/08/2016
-- Libellé              :
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
/*
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'NI_PS_S_PC151379_COUR_PEC' AND type = 'P' )
        DROP procedure sysadm.NI_PS_S_PC151379_COUR_PEC 
GO

CREATE procedure sysadm.NI_PS_S_PC151379_COUR_PEC
AS

SET NOCOUNT ON

-- [TODO_PC151379] On fait comment pour les adresse PSM ?? il y en a 2 ici, adresse de de proximité et adresse de centralisation

Delete from sysadm.w_cour_xml_orangev3

Insert into sysadm.w_cour_xml_orangev3 (
	  no_dossier_sinistre,
      civilite_courte,
      civilite_longue,
      nom,
      prenom,
      adresse1,
      adresse2,
      code_postal,
      ville,
      code_produit_sinistre,
      nom_produit,
      lib_opt_produit,
      no_tel_spb,
      no_fax_spb,
      assureur,
      no_police,
      no_ligne_assuree,
      app_marque,
      app_modele,
      cout_telephonique,
      date_de_declaration,
      code_operateur,
      type_appareil,
	  code_maquette,
	  adr_mail,
	  nom_livraison,
	  adresse1_livraison,
	  adresse2_livraison,
	  cp_ville_livraison,
	  imei, -- [PM234-7][M21970]
	  maj_par, -- [PM234-7][M21970]
	  adr_mail_cc -- [DF006]
	  )
Select	
	s.id_sin, 
	sysadm.FN_CODE_NUM(pers.cod_civ,'-CI') as civilite, 
	Case When pers.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
		 Else sysadm.FN_CODE_NUM(pers.cod_civ,'-CL') 
	End as civilite_longue,
	pers.nom,
	pers.prenom,
	pers.adr_1, 
	pers.adr_2, 
	Case pers.adr_cp When '00000' then '' Else pers.adr_cp End as adr_cp, 
	pers.adr_ville,
	p.id_prod,
	(select rtrim(dp66.val_car) 
	 from sysadm.det_pro dp66 
	 where dp66.id_prod=s.id_prod 
	   and dp66.id_code_dp=66) as lib_produit_assure,
	(select rtrim(dp67.val_car) 
	 from sysadm.det_pro dp67 
	 where dp67.id_prod=s.id_prod 
	   and dp67.id_code_dp=67) as lib_option_produit,
	p.num_tel as num_tel_produit,
	p.num_fax,
	rtrim ( sysadm.FN_LIB_CIE (s.id_sin)) as lib_compagnie,
	rtrim ( sysadm.FN_LIB_POLICE (s.id_sin)) as lib_police,
	s.num_port as num_tel_assure,
	s.marq_port,
	s.modl_port,
	(select rtrim(dp70.val_car) 
	 from sysadm.det_pro dp70 
	 where dp70.id_prod=s.id_prod 
	   and dp70.id_code_dp=70) as cout_telephonique,
	convert(varchar(10),s.dte_decl,20) as dte_decl,
	s.maj_par as code_operateur,
	Case When Exists (select * from sysadm.w_commande w
		where w.id_sin=s.id_sin and 
			w.id_typ_art='PRS'	and w.cod_etat <> 'ANN') Then 'repa' 
		Else 'rempl' End as type_appareil,
	IsNull ( rtrim ( ds.val_car ), '') as 'code_maquette',
	i.adr_mail 'adr_mail',
	Case 
		When rtrim ( ds.val_car ) in  ('WTE344' ) -- PXM
			Then ( 
				Select	Left ( IsNull ( rtrim( b.adr_nom ), ''), 100 )
				From sysadm.boutique b
				Where b.id_prod = 9133
				And   b.cod_mag = 
						(
							Select Convert ( VarChar (20), Convert ( integer, rtrim ( ltrim ( replace ( dsCodeLivr.val_car, '#', '')))))
							From sysadm.div_sin dsCodeLivr
							Where dsCodeLivr.id_sin = s.id_sin
							And	  dsCodeLivr.nom_zone = 'code_livraison_atlas'
						)
				And	  b.region = 'FRN=PSM'

				)
		When rtrim ( ds.val_car ) in ( 'WTE595', 'WTE598', 'WDE188', 'WDE189' ) -- RPU
			Then ( 
				Select Top 1 rtrim ( ltrim ( i.nom ))
				From sysadm.inter i
				Where i.id_sin = s.id_sin
				And   i.cod_inter = 'L'
				)
	End nom_livraison,
	Case 
		When rtrim ( ds.val_car ) in  ('WTE344' ) -- PXM
			Then ( 
				Select	Left ( IsNull ( rtrim( b.adr_1 ), ''), 100 )
				From sysadm.boutique b
				Where b.id_prod = 9133
				And   b.cod_mag  = 
						(
							Select Convert ( VarChar (20), Convert ( integer, rtrim ( ltrim ( replace ( dsCodeLivr.val_car, '#', '')))))
							From sysadm.div_sin dsCodeLivr
							Where dsCodeLivr.id_sin = s.id_sin
							And	  dsCodeLivr.nom_zone = 'code_livraison_atlas'
						)
				And	  b.region = 'FRN=PSM'

				)
		When rtrim ( ds.val_car ) in ( 'WTE595', 'WTE598', 'WDE188', 'WDE189' ) -- RPU
			Then ( 
				Select Top 1 rtrim ( ltrim ( i.adr_1 ))
				From sysadm.inter i
				Where i.id_sin = s.id_sin
				And   i.cod_inter = 'L'
				)
	End adresse1_livraison,
	Case 
		When rtrim ( ds.val_car ) in  ('WTE344' ) -- PXM
			Then ( 
				Select	Left ( IsNull ( rtrim( b.adr_2 ), ''), 100 )
				From sysadm.boutique b
				Where b.id_prod = 9133
				And   b.cod_mag  = 
						(
							Select Convert ( VarChar (20), Convert ( integer, rtrim ( ltrim ( replace ( dsCodeLivr.val_car, '#', '')))))
							From sysadm.div_sin dsCodeLivr
							Where dsCodeLivr.id_sin = s.id_sin
							And	  dsCodeLivr.nom_zone = 'code_livraison_atlas'
						)
				And	  b.region = 'FRN=PSM'

				)
		When rtrim ( ds.val_car ) in ( 'WTE595', 'WTE598', 'WDE188', 'WDE189' ) -- RPU
			Then ( 
				Select Top 1 rtrim ( ltrim ( i.adr_2 ))
				From sysadm.inter i
				Where i.id_sin = s.id_sin
				And   i.cod_inter = 'L'
				)
	End adresse2_livraison,
	Case 
		When rtrim ( ds.val_car ) in  ('WTE344' ) -- PXM
			Then ( 
				Select	Left ( IsNull ( rtrim( b.adr_cp ), '') + ' ' + IsNull ( rtrim( b.adr_ville ), ''), 100 )
				From sysadm.boutique b
				Where b.id_prod = 9133
				And   b.cod_mag  = 
						(
							Select Convert ( VarChar (20), Convert ( integer, rtrim ( ltrim ( replace ( dsCodeLivr.val_car, '#', '')))))
							From sysadm.div_sin dsCodeLivr
							Where dsCodeLivr.id_sin = s.id_sin
							And	  dsCodeLivr.nom_zone = 'code_livraison_atlas'
						)
				And	  b.region = 'FRN=PSM'

				)
		When rtrim ( ds.val_car ) in ( 'WTE595', 'WTE598', 'WDE188', 'WDE189' ) -- RPU
			Then ( 
				Select Top 1 rtrim ( ltrim ( i.adr_cp )) + ' ' + rtrim ( ltrim ( i.adr_ville ))
				From sysadm.inter i
				Where i.id_sin = s.id_sin
				And   i.cod_inter = 'L'
				)
	End cp_ville_livraison,
	rtrim ( s.num_imei_port ), -- [PM234-7][M21970]
	rtrim ( s.maj_par ), -- [PM234-7][M21970]
	(
		Select Top 1
			   Case 
				  When rtrim ( ds.val_car ) in ( 'SEN', 'SEM' ) 
					Then 'vip@orange.com,franck.bonnard@orange.com' -- [VDOC17642] [VDOC20329]	 
				  When rtrim ( ds.val_car ) in ( 'ASN' ) 
					Then 't.munier@senat.fr,franck.bonnard@orange.com' -- [VDOC17642]	 [VDOC20329]	 
				  Else ''
			   End

		From   sysadm.div_sin ds,
			   sysadm.det_pro dp 
		Where  ds.id_sin = s.id_sin
		And	   ds.nom_zone = 'client_vip'
		And	   s.id_sin = ds.id_sin 
		And	   dp.id_prod = s.id_prod
		And    dp.id_code_dp = 272
	) -- [VDOC17642][DF006]

	  
From	sysadm.sinistre s,
		sysadm.personne pers,
		sysadm.det_pro dp,
		sysadm.produit p,
		sysadm.inter i,
		sysadm.div_sin ds
Where   dp.id_prod = s.id_prod and dp.id_code_dp = 239
And		pers.id_ordre = s.id_ordre
And		ds.id_sin = s.id_sin
And		ds.nom_zone = 'cour_pec_a_envksl_Pc151379'
And		len ( rtrim ( ds.val_car ) ) > 0 
And		Not Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'dte_cour_pec_envksl_Pc151379' )
And		Not Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'cour_pec_envkslok_Pc151379' )
And		Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'Pc151379_auto_ok' )
And		p.id_prod=s.id_prod
And		i.id_sin=s.id_sin
And 	i.cod_inter='A'

Exec sysadm.PS_MAJ_XML_COUR_ORANGEV3

Select no_dossier_sinistre, 
	   xml_data 
From sysadm.w_cour_xml_orangev3

Go
*/

--------------------------------------------------------------------
--
-- Procédure            :       NI_PS_U_PC151379_COUR_PEC
-- Auteur               :       Fabry JF
-- Date                 :       03/08/2016
-- Libellé              :
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
/*
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'NI_PS_U_PC151379_COUR_PEC' AND type = 'P' )
        DROP procedure sysadm.NI_PS_U_PC151379_COUR_PEC 
GO

CREATE procedure sysadm.NI_PS_U_PC151379_COUR_PEC
        @adcIdSin     Decimal (  7,0 ),
        @asCas 	VarChar (35) = null
AS

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 
Declare @sAdrMailErr VarChar ( 150 )

-- dte_cour_pec_envksl_PC151379
If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_cour_pec_envksl_pc151379')
	 Begin
	   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_cour_pec_envksl_pc151379'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_sin values ( @adcIdSin, 'dte_cour_pec_envksl_pc151379', 'Date envoi cour. PEC KSL PC151379', '-1', 'N', 'D', 'N', 'N', 770, null, null, GETDATE(), null, 1, getdate(), getdate(), 'EDS' ) 
	 End

	Update sysadm.w_div_sin Set nom_zone = 'cour_pec_envkslok_pc151379', lib_label = 'Cour. PEC envoyé par KSL PC151379' Where id_sin = @adcIdSin And nom_zone = 'cour_pec_a_envksl_pc151379'
  End


If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_cour_pec_envksl_pc151379')
	 Begin
	   Update sysadm.div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_cour_pec_envksl_pc151379'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.div_sin values ( @adcIdSin, 'dte_cour_pec_envksl_pc151379', 'Date envoi cour. PEC KSL PC151379', '-1', 'N', 'D', 'N', 'N', 770, null, null, GETDATE(), null, getdate(), getdate(), 'EDS', getdate(), 'EDS' ) 
	 End

	Update sysadm.div_sin Set nom_zone = 'cour_pec_envkslok_pc151379' , lib_label = 'Cour. PEC envoyé par KSL PC151379' Where id_sin = @adcIdSin And nom_zone = 'cour_pec_a_envksl_pc151379'

  End


Set @sMess = 'Suite automatisation de la déclaration via AXA/SIMPA2 (PC151379), le courrier de prise en charge a été envoyé par KSL.'

If @asCas = 'ECHEC_DISTRIB'
	Begin

		Select	@sAdrMailErr = i.adr_mail
		From	sysadm.inter i
		Where   i.id_sin = @adcIdSin
		And		i.cod_inter = 'A'

		Set @sMess = @sMess + Char (13) + 'Echec distribution dû à une adresse mail erronée : ' + @sAdrMailErr 
		Set @sMess = @sMess + Char (13) + 'L''adresse a été effacée du dossier SIMPA2 et marquée sur SHERPA pour ne plus être utiliser sur SIMPA2.'		
	End 

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
BEGIN
	Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'EDS', 300, @iIdCt OUTPUT, 760
END
ELSE
BEGIN
	Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'EDS', 300, @iIdCt OUTPUT, 760
END


If @asCas = 'ECHEC_DISTRIB'
  Begin
	Update sysadm.inter 
	Set adr_mail = null
	Where id_sin = @adcIdSin
	And   cod_inter = 'A'
	
	Update sysadm.w_inter 
	Set adr_mail = null
	Where id_sin = @adcIdSin
	And   cod_inter = 'A'
	
	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')
	 Begin  
		Update 	SHERPA_PRO.sysadm.info_client
		Set	id_info = 53
		From	SHERPA_PRO.sysadm.sinistre s,
			SHERPA_PRO.sysadm.info_client i
		Where	s.id_sin = @adcIdSin
		And	s.id_appli = 2
		And	i.id_cli = s.id_cli
		And	i.id_info = 5
		And	lib_info = @sAdrMailErr
	 End 	 	
	 Else
	 Begin  
		Update 	SHERPA_SIM.sysadm.info_client
		Set	id_info = 53
		From	SHERPA_SIM.sysadm.sinistre s,
			SHERPA_SIM.sysadm.info_client i
		Where	s.id_sin = @adcIdSin
		And	s.id_appli = 2
		And	i.id_cli = s.id_cli
		And	i.id_info = 5
		And	lib_info = @sAdrMailErr
	 End 		
	
  End 

Go
*/