-------------------------------------------------------------------
--
-- Fichier              :       PM234_7.CP
-- Auteur               :       Fabry JF
-- Date                 :       03/08/2016
--
-- Commentaires         :       PS afférants aux PM234-7, automatisation Orange V3
--
-- sysadm.PS_D_PM234_7_CTRLE_PRESTA
-- sysadm.PS_I_PM234_7_AUTOMATISATION_ORV3
-- sysadm.PS_I_PM234_7_CAS_DF005_EN_ATT_PCE_SANS_TRV
-- sysadm.PS_I_PM234_7_CREATION_PRESTA_V01
-- sysadm.PS_I_PM234_7_CTRL_APRES_VALIDATION
-- sysadm.PS_I_PM234_7_DOSSIER_ELIGIBLE
-- sysadm.PS_I_PM234_7_DOSSIER_INTEGRE
-- sysadm.PS_I_PM234_7_ETAT_VALIDATION_V02
-- sysadm.PS_I_PM234_7_PLAFOND_PEC
-- sysadm.PS_I_PM234_7_REFUS_1676
-- sysadm.PS_I_PM234_7_REFUS_601_V01
-- sysadm.PS_I_PM234_7_REFUS_602_V01
-- sysadm.PS_I_PM234_7_REFUS_603
-- sysadm.PS_I_PM234_7_REFUS_604_V01
-- sysadm.PS_I_PM234_7_REFUS_611_V01
-- sysadm.PS_I_PM234_7_REFUS_612_V01
-- sysadm.PS_I_PM234_7_REFUS_613_V01
-- sysadm.PS_I_PM234_7_REFUS_641_V01
-- sysadm.PS_I_PM234_7_REFUS_642_V01
-- sysadm.PS_I_PM234_7_REFUS_643_V01
-- sysadm.PS_I_PM234_7_REFUS_REVISION
-- sysadm.PS_I_PM234_7_REGLE_SPEC_ET_REFUS
-- sysadm.PS_I_PM234_7_REJET
-- sysadm.PS_I_PM234_7_TAG_COURRIER_PEC
-- sysadm.PS_I_PM234_7_TAG_COURRIER_REFUS
-- sysadm.PS_S_PM234_7_COUR_PEC
-- sysadm.PS_S_PM234_7_COUR_REFUS
-- sysadm.PS_U_PM234_7_COUR_PEC
-- sysadm.PS_U_PM234_7_COUR_REFUS
-------------------------------------------------------------------

--------------------------------------------------------------------
-- Procédure            :       PS_I_PM234_7_AUTOMATISATION_ORV3
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
-- JFF      04/07/2017   [DF005]
-- JFF      26/09/2017   [DF006]
-- JFF      14/12/2017   [DF005-1-LOT2]
-- JFF      15/06/2018   [DF005-1-LOT3]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_AUTOMATISATION_ORV3' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_AUTOMATISATION_ORV3
GO

CREATE procedure sysadm.PS_I_PM234_7_AUTOMATISATION_ORV3
	@adcIdSin   Decimal (10)
AS
	Declare @iRet Integer 
	Declare @iLigneSecondaire Integer 

-- [DEBUG]
-- Return -1

-- [PM234-7]
/*
Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Le PM234-7 est hors production', 'Le PM234-7 est hors production pour l''instant, l''automatisation du process Orange V3 via ATLAS/SIMPA2 est donc impossible pour le moment.'
Return -1
*/

-- [DF006]
-- Rejet normal cas aujourd'hui Orange Entreprise ne transmet pas l'information impayé ni la DDU.
If Exists ( 
	Select Top 1 1 
	From sysadm.w_sin ws
	Where ws.id_sin = @adcIdSin
	And   ws.id_prod in ( 
	32702,
	96200,
	96201,
	96202,
	96203,
	96204,
	96205)
	)
	Begin
		Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Rejet normal DF006 en prod.partiel.', 'Le DF006 en production partielle pour l''instant, ce rejet est donc normal, l''automatisation du process Orange V3 via ATLAS/SIMPA2 est donc impossible pour le moment.'
		Return -1
	End 

	-- Audit Assureur (Fraude)
	Exec @iRet = sysadm.PS_S_PM234_7_AUDIT_ASSUREUR_ELSA @adcIdSin
	If @iRet = -1 Return @iRet

-- Je n'ai pas besoin d'être sous transaction, en effet, personne ne peut écrire ni lire ces données fraîchement écrites par ATLAS.
-- Set Transaction Isolation level Read UnCommitted

-- Dossier éligible à l'automatisme
	Exec @iRet = sysadm.PS_I_PM234_7_DOSSIER_ELIGIBLE @adcIdSin
	If @iRet = -1 Return @iRet

-- Le dossier est-il intègre ? les données minimum nécessaire sont-elles présentes ?
	Exec @iRet = sysadm.PS_I_PM234_7_DOSSIER_INTEGRE @adcIdSin
	If @iRet = -1 Return @iRet

-- Contrôle des régles spéciales/refus
	Exec @iRet = sysadm.PS_I_PM234_7_REGLE_SPEC_ET_REFUS @adcIdSin
	If @iRet = -1 Return @iRet

	-- [DF005-1-LOT2]
	If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
		Begin
		 If @iRet = 2
		   Begin
				Exec sysadm.PS_I_PM234_7_TAG_COURRIER_REFUS @adcIdSin, 'REFUS_AUTO'

				If @iRet = -1 Return @iRet

				Exec @iRet = sysadm.PS_I_PM234_7_ETAT_VALIDATION_V02 @adcIdSin, -1, 'CAS=REFUS_AUTO'  -- -1 car la ligne n'est pas traité sur le refus
				If @iRet = -1 Return @iRet

				Return
		   End 
		End 

-- Création de la pec/Plafond (Refus plafond)
	Exec @iRet = sysadm.PS_I_PM234_7_PLAFOND_PEC @adcIdSin
	If @iRet = -1 Return @iRet

-- [DF005] Détection ligne secondaire
	
	Select  @iLigneSecondaire = count (* )
	From	sysadm.det_pro dp94,
			sysadm.w_sin ws
	Where   ws.id_sin = @adcIdSin
	And     dp94.id_prod = ws.id_prod
	And		dp94.id_code_dp = 94
	And		sysadm.FN_CLE_VAL ( 'COD_DW', rtrim ( dp94.val_car ) + rtrim ( dp94.val_car2), ';' ) = 'ORANGE_LIGNE_SECONDAIRE'

	If @iLigneSecondaire is null Set @iLigneSecondaire = 0 

-- Création de la prestation
	-- [DT288]
	If @iLigneSecondaire > 0 
		Begin
			Exec @iRet = sysadm.PS_I_PM234_7_CAS_DF005_EN_ATT_PCE_SANS_TRV @adcIdSin
			If @iRet = -1 Return @iRet
		End 
	Else
		Begin
			Exec @iRet = sysadm.PS_I_PM234_7_CREATION_PRESTA_V01 @adcIdSin
			If @iRet = -1 Return @iRet
		End 

-- Création de l'état/status/validation.
-- [DF005]
-- [DF005-1-LOT3]
	Exec @iRet = sysadm.PS_I_PM234_7_ETAT_VALIDATION_V02 @adcIdSin, @iLigneSecondaire, ''
	If @iRet = -1 Return @iRet

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_PM234_7_DOSSIER_ELIGIBLE
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
-- JFF	26/12/2016 [MANTIS23199]
-- JFF	28/04/2017 [PM369-2_MANTIS24885]
-- JFF  04/05/2017 [DT288-1_LOT2]
-- JFF  01/12/2017 [VDOC25272]
-- JFF  25/05/2018 [DF005-2]
-- JFF  24/03/2020 [DT492]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_DOSSIER_ELIGIBLE' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_DOSSIER_ELIGIBLE
GO

CREATE procedure sysadm.PS_I_PM234_7_DOSSIER_ELIGIBLE
	@adcIdSin   Decimal (10)
AS

	-- [PM369-2_MANTIS24885]
	Declare @dtValideLe DateTime
	Set @dtValideLe = GetDate()
	Exec sysadm.PS_IU_PIECE_HISTO @adcIdSin, @dtValideLe

	-- Si présence d'un travail, rejet
	If Exists ( Select Top 1 1 From sysadm.w_queue where id_sin = Convert ( VarChar ( 10 ), @adcIdSin ) )
		Begin
/*
			Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Présence d''un travail', 'La présence d''un travail a été détectée, or pour que ce système fonctionne, ATLAS ne doit pas créer le travail. Cas non éligible à l''automatisation du process Orange V3 via ATLAS/SIMPA2.'
			Return -1
*/
			-- [MANTIS23199]
			Delete sysadm.w_queue Where id_sin = @adcIdSin
			Update sysadm.routage Set alt_queue = 'N' Where id_sin = @adcIdSin
		End 

	-- Option -dp/303 absente
	If Not Exists ( 
			Select	Top 1 1 
			From	sysadm.w_sin ws,
					sysadm.det_pro dp
			Where	ws.id_sin = @adcIdSin
			And		dp.id_prod = ws.id_prod
			And		dp.id_code_dp = 303
		) 
		Begin
			Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Produit non éligible, dp303 absente', 'Ce produit de sinistre n''est pas éligible à l''automatisation du process Orange V3 via ATLAS/SIMPA2.'
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
			Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'cpt_valide > 0', 'Ce dossier a déjà subi une validation, il n''est donc pas éligible à l''automatisation du process Orange V3 via ATLAS/SIMPA2.'
			Return -1
		End		

	-- Option -dp/239 absente
	If Not Exists ( 
			Select	Top 1 1 
			From	sysadm.w_sin ws,
					sysadm.det_pro dp
			Where	ws.id_sin = @adcIdSin
			And		dp.id_prod = ws.id_prod
			And		dp.id_code_dp = 239
		) 
		Begin
			Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Produit non éligible, dp239 absente', 'Ce produit de sinistre n''est pas éligible à l''automatisation du process Orange V3 via ATLAS/SIMPA2.'
			Return -1
		End		

	-- Garantie autorisée au système
	If Not Exists ( 
			Select	Top 1 1 
			From	sysadm.w_gar_sin wg,
					sysadm.w_sin ws,
					sysadm.code_garantie cg
			Where	wg.id_sin = @adcIdSin
			And		wg.id_gti in ( 11, 24 )
			And		ws.id_sin = wg.id_sin
			And     cg.id_prod = ws.id_prod
			And		cg.id_gti = wg.id_gti
		) 
		Begin
			-- ajouté le 06/07 JF (sinon le GT est bloqué pour mettre sans suite si GTI absente du param)

			If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
			 Begin
				
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

					Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Garantie non éligible', 'La garantie déclarée sur ce sinistre n''est pas éligible à l''automatisation du process Orange V3 via ATLAS/SIMPA2.'
					Return -1
				End
			End 
		   Else
		    Begin

				Delete sysadm.w_div_det where id_sin = @adcIdSin 
				Delete sysadm.w_refus where id_sin = @adcIdSin
				Delete sysadm.w_piece where id_sin = @adcIdSin
				Delete sysadm.w_detail where id_sin = @adcIdSin
				Delete sysadm.w_gar_sin where id_sin = @adcIdSin

				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Garantie non éligible', 'La garantie déclarée sur ce sinistre n''est pas éligible à l''automatisation du process Orange V3 via ATLAS/SIMPA2.'
				Return -1
				-- /ajouté le 06/07 JF
			End 


		End		

	-- Une seule Garantie.
	If ( 
			Select	count (*)
			From	sysadm.w_gar_sin wg
			Where	wg.id_sin = @adcIdSin
		) <> 1
		Begin
			Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Trop de garantie (1 max)', 'Le sinistre ne doit avoir qu''une seule garantie pour être éligible au système de l''automatisation du process Orange V3 via ATLAS/SIMPA2.'
			Return -1
		End		

	-- [VDOC25272]
	If ( Select Top 1 count (*)
			From   sysadm.w_detail d
			Where  d.id_sin = @adcIdSin
			group  by id_evt
			Order  by count (*) desc 
		) > 1 
		Begin
			Delete sysadm.w_detail Where id_sin = @adcIdSin and id_detail > 0
		End 

	-- Une seul Détail.
	If ( 
			Select	count (*)
			From	sysadm.w_detail wd
			Where	wd.id_sin = @adcIdSin
		) <> 1
		Begin
			Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Nbre de détail (1 max)', 'Le sinistre ne doit avoir qu''un seul détail de garantie (ni plus ni moins) pour être éligible au système de l''automatisation du process Orange V3 via ATLAS/SIMPA2.'
			Return -1
		End		

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
			Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Règle spécifique dp/290', 'Le modèle de l''appareil n''est pas éligible au système, voir VDOC18734 et DT200. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
			Return -1
		End		

	-- Garantie autorisée au système
	-- [DF005-1-LOT2]
	If Not sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
		Begin
			If Exists ( 
					Select	Top 1 1 
					From	sysadm.w_sin ws
					Where	ws.id_sin = @adcIdSin
					And		ws.id_natsin in ( 11, 12, 28 )
				) 
				Begin
					Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Nature de sinistre non éligible', 'La nature de sinistre déclarée sur ce sinistre n''est pas éligible à l''automatisation du process Orange V3 via ATLAS/SIMPA2.'
					Return -1
				End		
		End 

	-- [DT288-1_LOT2]
	If Exists ( 
			Select	top 1 1 
			From	sysadm.det_pro dp315,
					sysadm.det_pro dp94,
					sysadm.w_sin ws,
					sysadm.w_div_sin wdsTypeApp,
					sysadm.w_div_sin wdsGeolocAtlas
			Where   ws.id_sin = @adcIdSin
			And		ws.marq_port = 'APPLE'
			And		wdsTypeApp.id_sin = ws.id_sin
			And		wdsTypeApp.nom_zone = 'type_app'
			And		wdsTypeApp.val_car = 'TEL'
			And		wdsGeolocAtlas.id_sin = ws.id_sin
			And		wdsGeolocAtlas.nom_zone = 'geoloc_atlas'
			And		wdsGeolocAtlas.val_car = 'O'
			And		dp315.id_prod = ws.id_prod
			And		dp315.id_code_dp = 315
			And		ws.cree_le >= Convert ( DateTime, sysadm.FN_CLE_VAL ( 'DTE_PIVOT_DT288_1_LOT2', rtrim ( dp315.val_car ) + rtrim ( dp315.val_car2), ';' ) )
			And		dp94.id_prod = ws.id_prod
			And		dp94.id_code_dp = 94
			And		sysadm.FN_CLE_VAL ( 'COD_DW', rtrim ( dp94.val_car ) + rtrim ( dp94.val_car2), ';' ) in ( 'ORANGE_V3BIS', 'ORANGE_V3TER' )
		)
		Begin
			Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'V3BIS APPLE Géolocalisé', 'Les dossiers V3BIS APPLE géolocalisés ne sont pas éligibles à l''automatisation du process Orange V3 via ATLAS/SIMPA2.'
			Return -1
		End		

-- [DT492]
If sysadm.FN_CLE_NUMERIQUE ( 'DT492') > 0 
 Begin
	If Exists ( Select Top 1 1 From sysadm.w_sin where id_sin = @adcIdSin and marq_port = 'APPLE' )
	  Begin
	  	Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'APPLE vers COR>PSM : COVID19 DT492', 'Suite DT492 de DPG, durant la période du COVID19, les APPLE sont redirigés de CORDON vers PSM, à faire à la main par l''application SIMPA2. Ce cas n''est donc pas éligibles à l''automatisation du process Orange V3 via ATLAS/SIMPA2.'
		Return -1
	  End 
 End 
 
 Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_PM234_7_DOSSIER_INTEGRE
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
-- JFF      21/02/2107   [DT288]
-- JFF      01/12/2107   [VDOC25254]
-- JFF      19/01/2107   [VDOC25528]
-- FPI		09/02/2018	 [PI056] Suppression du nom de serveur
-- JFF		22/05/2018   Contrôle du texte de déclaration (22/05/2018 JFF)
-- JFF      11/05/2022   [RS2980_IFR]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_DOSSIER_INTEGRE' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_DOSSIER_INTEGRE
GO

CREATE procedure sysadm.PS_I_PM234_7_DOSSIER_INTEGRE
	@adcIdSin   Decimal (10)
AS

	Declare @iInterL Integer 
	Declare @sTypLivrAtlas VarChar ( 3 )
	Declare @sCodLivrAtlas VarChar ( 50 )
	Declare @sCodPSMCentreAtlas VarChar ( 50 )
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
	Declare @sMarqueAppSin Varchar ( 35 ) 
	Declare @sModlAppSin Varchar ( 35 ) 
	Declare @sCodeRetIfr Varchar ( 20 )

	-- Présence ligne dans w_sin
	If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin )
		Begin
			Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Le sinistre n''existe pas', 'La référence sinistre n''existe pas. La référence transmise à l''automate SIMPA2 par ATLAS ne réfère aucun sinistre dans la base de données SIMPA2. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
			Return -1
		End		
		
		-- Présence donnée dans id_natsin
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And id_natsin is not null And id_natsin <> 0 )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Nature de sinistre non renseignée', 'La nature de sinistre n''a pas été renseignée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End		

		-- Présence donnée dans id_territ
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And id_territ is not null And id_territ <> 0 )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Territorialité non renseignée', 'La territorialité n''a pas été renseignée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans id_detail
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And id_detsin is not null And id_detsin <> 0 )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Détail de sinistre non renseigné', 'Le détail de sinistre n''a pas été renseigné par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans dte_surv
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And dte_surv is not null )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Date de survenance non renseignée', 'La date de survenance n''a pas été renseignée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans dte_decl
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And dte_decl is not null )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Date de déclaration non renseignée', 'La date de déclaration n''a pas été renseignée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans id_ets, contrôle présence table établissement
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And id_ets is not null )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'ETS adhésion non renseignée', 'L''établissement adhésion n''a pas été renseigné par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
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
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'ETS non paramétré ', 'L''établissement adhésion transmis pas ATLAS n''existe sur SIMPA2 pour ce produit. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans dte_adh
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And dte_adh is not null )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Date adhésion non renseignée', 'La date d''adhésion n''a pas été renseignée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
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
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Texte de déclaration non renseigné', 'Le texte de déclaration n''a pas été renseigné par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End 
		 		 
		-- Présence donnée dans id_sdos
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And id_sdos is not null And id_sdos <> 0 )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Co-adhérent non renseigné', 'Le co-adhérent n''a pas été renseigné par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans civ
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And cod_civ is not null And cod_civ <> 0 )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Civilité non renseignée (w_sin)', 'La civilité de l''assuré n''a pas été renseignée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans nom
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And nom is not null And ltrim ( nom ) <> '' )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Nom non renseignée (w_sin)', 'Le nom de l''assuré n''a pas été renseigné par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
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
					Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Prénom non renseignée (w_sin)', 'Le prénom de l''assuré n''a pas été renseigné par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
					Return -1
				 End
			End	

		-- Présence donnée dans adr_1
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And adr_1 is not null And ltrim ( adr_1 ) <> '' )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Adresse non renseignée (w_sin)', 'L''adresse de l''assuré n''a pas été renseignée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans adr_cp
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And adr_cp is not null And ltrim ( adr_cp ) <> '' )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'CP non renseignée (w_sin)', 'Le code postal de l''assuré n''a pas été renseigné par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans adr_ville
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And adr_ville is not null And ltrim ( adr_ville ) <> '' )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Ville non renseignée (w_sin)', 'La ville de l''assuré n''a pas été renseignée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
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
					Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Cohér. CP/Ville incorrect (w_sin)', 'La cohérence code postal/ville de l''assuré par rapport au référentiel, n''est pas respectée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
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
					Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Cohér. CP/Ville incorrect (w_sin)', 'La cohérence code postal/ville de l''assuré par rapport au référentiel, n''est pas respectée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
					Return -1
				End	
		End

		-- [VDOC25254]
		If Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And upper ( adr_ville ) like '%MONACO%' and id_prod in ( 9132, 9133, 51600, 51602, 51603, 51605 ))
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Ville MONACO (w_sin)', 'La ville de l''assuré est MONACO, pas d''automatisation pour cette ville. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	

		-- [VDOC25528]
		If Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And left ( adr_cp, 3 ) in ( '971', '972', '973', '974', '975', '976', '984', '986', '987', '988' ))
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'DOM-TOM Trait. Manuel.(w_sin)', 'Les départements DOM-TOM sont à traiter en manuel, pas d''automatisation pour ce cas. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans num_port ( 10 chiffre 06, 07)
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And num_port is not null And ltrim ( num_port ) <> '' And Left ( num_port, 2 ) in ( '06', '07') )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'NumTelSin non valide/rens. (w_sin)', 'Le numéro de téléphone portable de l''assuré n''a pas été renseignée (ou n''est pas valide) par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans num_imei_port (num imei valide et 15)
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
					And wds.val_car in ( 'TEL', 'PC1', 'PC2', 'PC3' )
				  )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'IMEI/Série non valide/renseignée', 'Le numéro IMEI/Série de l''assuré n''a pas été renseignée (ou n''est pas valide) par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	



		-- Présence donnée dans marq_port et modl_port
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And marq_port is not null And ltrim ( marq_port ) <> '' )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Marque non renseignée', 'La marque de l''appareil sinistré de l''assuré n''a pas été renseignée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	

		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And modl_port is not null And ltrim ( modl_port ) <> '' )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Modèle non renseignée', 'Le modèle de l''appareil sinistré de l''assuré n''a pas été renseigné par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	

		-- binome marque/modèle doit appartenir à IFR
		If Not Exists ( 
				Select Top 1 1 
				From sysadm.w_sin ws,
					 sysadm.w_div_sin wds,
					 sysadm.ifr i
				Where ws.id_sin = @adcIdSin 
				And   i.marque = ws.marq_port
				And   i.reference = ws.modl_port
				And   wds.id_sin = ws.id_sin
				And   wds.nom_zone = 'type_app'
				And   wds.val_car in ( 'TEL', 'TPC' )
				And   ( Left ( i.sku_saga, 3 ) = wds.val_car
						Or 
						i.sku_saga is null )
				)
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Marque/Modèle incohérent Réf IFR', 'Le binôme marque/modèle de l''appareil sinistre de l''assuré transmis par ATLAS, n''est pas valide sous le référentiel IFR ou bien le type ne correspond pas au modèle. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	

		-- [RS2980_IFR] -- Ctrle Validité prix IFR
		If sysadm.FN_CLE_NUMERIQUE ( 'RS2980_IFR') > 0 
			Begin
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
			End 

		-- [DT288] Présence typ_livraison PXM et marque APPLE
		-- [DT288]
		If Exists ( Select Top 1 1 
					From sysadm.w_div_sin wds,
							sysadm.w_sin ws,
							sysadm.det_pro dp
					Where ws.id_sin = @adcIdSin 
					And	  wds.id_sin = ws.id_sin
					And   wds.nom_zone = 'type_livraison_atlas' 
					And	  wds.val_car = 'PXM' 
					And   ws.marq_port = 'APPLE'
					And   dp.id_prod = ws.id_prod
					And   dp.id_code_dp = 315 )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'DT288 : PXM avec APPLE interdit', 'Le mode de livraison PXM transmis par ATLAS n''est plus autorisé avec un matériel APPLE depuis la mise en place du DT288. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End

		-- Présence donnée dte_ach_port
		If Not Exists ( Select Top 1 1 From sysadm.w_sin Where id_sin = @adcIdSin And dte_ach_port is not null )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Date achat non renseignée', 'La date d''achat de l''appareil sinistré de l''assuré n''a pas été renseigné par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	

	-- Présence ligne dans w_gar_sin
		-- Déjà contrôle dans l'éligibilité

	-- Présence ligne dans w_detail
		-- Présence evt 937, 1377, 932
		If Not Exists ( Select Top 1 1 From sysadm.w_detail Where id_sin = @adcIdSin And id_evt in ( 937, 1377, 932 ) )
		Begin
			Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Evt absent/non valide', 'L''évènement du détail de garantie transmis par ATLAS est absent ou non valide. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
			Return -1
		End	

		-- [DT288] Présence typ_livraison PXM et marque APPLE
		If Exists ( Select Top 1 1 
					From sysadm.w_detail wd,
							sysadm.w_sin ws,
							sysadm.det_pro dp
					Where ws.id_sin = @adcIdSin 
					And   ws.marq_port = 'APPLE'
					And	  wd.id_sin = ws.id_sin
					And   wd.id_evt = 1377
					And   dp.id_prod = ws.id_prod
					And   dp.id_code_dp = 315 )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'DT288 : Evènement 1377 interdit', 'L''évènement 1377 du détail de garantie transmis par ATLAS n''est plus autorisé avec un matériel APPLE depuis la mise en place du DT288. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End

		-- Présence alt_att = 'O'
		Update sysadm.w_detail Set alt_att = 'O' Where id_sin = @adcIdSin
		Update sysadm.w_detail Set lib_det = 'de votre appareil' Where id_sin = @adcIdSin


	-- Présence ligne dans w_inter 
		-- Présence ligne A
		If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' )
		Begin
			Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Inter Assuré absent', 'L''interlocuteur Assuré est absent, il n''a pas été créé par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
			Return -1
		End	

		-- Présence donnée dans civ
		If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And cod_civ is not null And cod_civ <> 0 )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Civilité non renseignée (w_interA)', 'La civilité de l''assuré n''a pas été renseignée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans nom
		If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And nom is not null And ltrim ( nom ) <> '' )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Nom non renseignée (w_interA)', 'Le nom de l''assuré n''a pas été renseigné par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans adr_1
		If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And adr_1 is not null And ltrim ( adr_1 ) <> '' )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Adresse non renseignée (w_interA)', 'L''adresse de l''assuré n''a pas été renseignée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans adr_cp
		If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And adr_cp is not null And ltrim ( adr_cp ) <> '' )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'CP non renseignée (w_interA)', 'Le code postal de l''assuré n''a pas été renseigné par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	

		-- Présence donnée dans adr_ville
		If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And adr_ville is not null And ltrim ( adr_ville ) <> '' )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Ville non renseignée (w_interA)', 'La ville de l''assuré n''a pas été renseignée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
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
					Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Cohé. CP/Ville incorrect (w_interA)', 'La cohérence code postal/ville de l''assuré par rapport au référentiel, n''est pas respectée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
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
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Cohé. CP/Ville incorrect (w_interA)', 'La cohérence code postal/ville de l''assuré par rapport au référentiel, n''est pas respectée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	

		End

		-- Présence adresse mail
		If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And adr_mail is not null And ltrim ( adr_mail ) <> '' )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Adresse mail absente (w_interA)', 'L''adresse mail de l''assuré n''a pas été renseignée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End
		
		Select @sAdrMailInterAss = adr_mail	From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'A' And adr_mail is not null And ltrim ( adr_mail ) <> ''
		Set @sAdrMailInterAss = sysadm.FN_EPURE_CHAINE ( @sAdrMailInterAss ) 
		If sysadm.FN_CTRLE_ADR_MAIL ( @sAdrMailInterAss ) < 0
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Adresse mail non valide (w_interA)', 'L''adresse mail de l''assuré renseignée par ATLAS, n''est pas valide. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End 

		Update sysadm.w_inter 
		Set adr_mail = @sAdrMailInterAss
		Where id_sin = @adcIdSin

		-- Présence ligne L sauf pour PXM
		If Not Exists ( 
				Select Top 1 1 
				From sysadm.w_inter wi
				Where wi.id_sin = @adcIdSin 
				And   wi.cod_inter = 'L'
				)
		   And
		   Exists ( 
				Select Top 1 1 
				From sysadm.w_div_sin wds
				Where wds.id_sin = @adcIdSin 
				And   wds.nom_zone = 'type_livraison_atlas'
				And	  wds.val_car <> 'PXM'
				And	  Len ( wds.val_car ) > 0 
				)
		Begin
			Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Inter Livraison absent', 'L''interlocuteur de livraison est absent, il n''a pas été créé par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
			Return -1
		End	
		Else
		Begin
			If Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'L'  )
				Begin
					-- Présence donnée dans civ
					If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'L' And cod_civ is not null And cod_civ <> 0 )
						Begin
							Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Civilité non renseignée (w_interL)', 'La civilité de l''interlocuteur de livraison n''a pas été renseignée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
							Return -1
						End	

					-- Présence donnée dans nom
					If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'L' And nom is not null And ltrim ( nom ) <> '' )
						Begin
							Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Nom non renseigné (w_interL)', 'Le nom de l''interlocuteur de livraison n''a pas été renseigné par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
							Return -1
						End	

					-- Présence donnée dans adr_1
					If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'L' And adr_1 is not null And ltrim ( adr_1 ) <> '' )
						Begin
							Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Adresse non renseignée (w_interL)', 'L''adresse de l''interlocuteur de livraison n''a pas été renseignée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
							Return -1
						End	

					-- Présence donnée dans adr_cp
					If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'L' And adr_cp is not null And ltrim ( adr_cp ) <> '' )
						Begin
							Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'CP non renseignée (w_interL)', 'Le code postal l''interlocuteur de livraison n''a pas été renseigné par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
							Return -1
						End	

					-- Présence donnée dans adr_ville
					If Not Exists ( Select Top 1 1 From sysadm.w_inter Where id_sin = @adcIdSin And cod_inter = 'L' And adr_ville is not null And ltrim ( adr_ville ) <> '' )
						Begin
							Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Ville non renseignée (w_interL)', 'La ville de l''interlocuteur de livraison n''a pas été renseignée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
							Return -1
						End	

					-- Avant le contrôle, le bourre à gauche avec des 0 ITSM59144, ITSM592136
					Update sysadm.w_inter 
					Set    adr_cp = Right ( replicate ( '0', 5 ) + rtrim ( ltrim ( adr_cp )), 5 ) 
					Where  id_sin = @adcIdSin
					And    cod_inter = 'L'

					-- Contrôle cohérence cp/ville (on ne pas contrôle la cohérence sur le RPU)
					IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
					Begin
						If Not Exists ( 
								Select	Top 1 1 
								From	SESAME_PRO.sysadm.commune c,
										sysadm.w_inter wi
								Where	wi.id_sin = @adcIdSin
								And		cod_inter = 'L'
								And     c.code_postal = wi.adr_cp
								And		c.nom_commune = wi.adr_ville
								)
							And Exists ( 
									Select Top 1 1 
									From   sysadm.w_div_sin wds
									Where  wds.id_sin = @adcIdSin
									And		wds.nom_zone = 'type_livraison_atlas'
									And		wds.val_car not in ( 'RPU', 'PXM' )
								)

							Begin
								Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Cohé. CP/Ville incorrect (w_interL)', 'La cohérence code postal/ville de l''interlocuteur de livraison par rapport au référentiel, n''est pas respectée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
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
								And		cod_inter = 'L'
								And     c.code_postal = wi.adr_cp
								And		c.nom_commune = wi.adr_ville
								)
							And Exists ( 
									Select Top 1 1 
									From   sysadm.w_div_sin wds
									Where  wds.id_sin = @adcIdSin
									And		wds.nom_zone = 'type_livraison_atlas'
									And		wds.val_car not in ( 'RPU', 'PXM' )
								)

							Begin
								Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Cohé. CP/Ville incorrect (w_interL)', 'La cohérence code postal/ville de l''interlocuteur de livraison par rapport au référentiel, n''est pas respectée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
								Return -1
							End	
						End

					-- Epuration des caractères gênant
					Update sysadm.w_inter
					Set nom =   sysadm.FN_EPURE_CHAINE (
								Upper ( 
								Replace ( Replace ( Replace ( Replace ( Replace ( 
								Replace ( rtrim ( nom), '''', '' ), 
								char ( 13 ), '' ),
								char ( 10 ), '' ),
								char ( 9 ), '' ),
								char ( 11 ), '' ),
								'"', '' )
								)), 
						adr_1 = sysadm.FN_EPURE_CHAINE (
								Upper ( 
								Replace ( Replace ( Replace ( Replace ( Replace ( 
								Replace ( rtrim ( adr_1), '''', '' ), 
								char ( 13 ), '' ),
								char ( 10 ), '' ),
								char ( 9 ), '' ),
								char ( 11 ), '' ),
								'"', '' )
								)), 
						adr_2 = sysadm.FN_EPURE_CHAINE (
								Upper ( 
								Replace ( Replace ( Replace ( Replace ( Replace ( 
								Replace ( rtrim ( adr_2), '''', '' ), 
								char ( 13 ), '' ),
								char ( 10 ), '' ),
								char ( 9 ), '' ),
								char ( 11 ), '' ),
								'"', '' )
								)), 
						adr_cp = sysadm.FN_EPURE_CHAINE (
								Upper ( 
								Replace ( Replace ( Replace ( Replace ( Replace ( 
								Replace ( rtrim ( adr_cp), '''', '' ), 
								char ( 13 ), '' ),
								char ( 10 ), '' ),
								char ( 9 ), '' ),
								char ( 11 ), '' ),
								'"', '' )
								)), 

						adr_ville = sysadm.FN_EPURE_CHAINE (
								Upper ( 
								Replace ( Replace ( Replace ( Replace ( Replace ( 
								Replace ( rtrim ( adr_ville), '''', '' ), 
								char ( 13 ), '' ),
								char ( 10 ), '' ),
								char ( 9 ), '' ),
								char ( 11 ), '' ),
								'"', '' )
								))

					Where id_sin = @adcIdSin And cod_inter = 'L'
				End

		End

	-- Présence ligne dans w_div_sin
		-- Manque Info Atlas
		If Exists ( Select Top 1 1 From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'manque_info_atlas' And val_car is not null And val_car = 'O' )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Manque_info_atlas', 'La zone technique manque_info_atlas a été cochée par ATLAS, cela arrête donc le processus d''automatisation. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
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
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Typ Mat Sin absent/non param', 'Le type de matériel sinistré transmis par ATLAS est absent ou non paramétré  pour ce produit. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End	


		-- Présence mt_val_ach_adh !!
/* Je coupe, vu avec Marin, ATLAS ne la passera jamais.
   -- Vu avec Marin, ATLAS ne la passant jamais, on mets la valeur publique, mail du 03/10/2016 10h58 voir RepPcc
		If Not Exists ( Select Top 1 1 From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'mt_val_achat_adh' And val_mt is not null And val_mt > 0 )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Valeur d''achat non renseignée', 'La valeur d''achat n''a pas été renseignée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End
*/

		-- Présence app_sin coché
		If Not Exists ( Select Top 1 1 From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'app_sin' And val_car is not null And val_car = 'O' )
			Begin
				Insert into w_div_sin Values ( @adcIdSin, 'app_sin', 'Sinistre sur appareil/Batt. Interne', -1, 'N', 'X', 'N', 'N', 113, null, null, null, 'O', 0, getdate(), getdate(), 'WEB')                             
/*
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'zone app_sin non renseignée', 'La zone technique app_sin n''a pas été renseignée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
*/
			End

		-- Présence alt_decla_web cochée
		If Not Exists ( Select Top 1 1 From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'alt_decla_web' And val_car is not null And val_car = 'O' )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'zone alt_decla_web non renseignée', 'La zone technique alt_decla_web n''a pas été renseignée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End

		-- Présence alt_decla_atlas cochée
		If Not Exists ( Select Top 1 1 From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'decla_atlas' And val_car is not null And val_car = 'O' )
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'zone decla_atlas non renseignée', 'La zone technique decla_atlas n''a pas été renseignée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End

		-- Présence info_suppl_si_iphone val lib 'Foncti.+Maj'
/* Plus nécessaire
		If Exists ( Select Top 1 1 From w_sin Where CharIndex ( 'IPHONE', modl_port ) > 0 )
			Begin
				If Not Exists ( Select Top 1 1 From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'info_iphone_atlas' And val_car is not null And val_car = 'FMJ' )
					Begin
						Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'zone info_iphone_atlas non renseignée', 'La zone technique info_iphone_atlas n''a pas été renseignée par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
						Return -1
					End
			End 
*/

		-- Présence typ_livraison BPP, RPU, PXM
		If Not Exists ( Select Top 1 1 From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'type_livraison_atlas' And val_car is not null And val_car in (  'RPU', 'BPP', 'PXM' ))
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Mode de livraison non renseigné', 'Le mode de livraison n''a pas été renseigné par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End

		-- Ajout le 31/10/2016 JFF
		-- Si PXM Alors on Contrôle que le code livr atlas doive être un nombre encadrer de #, et existait dans la ma boutique PSM.
		If Exists ( Select Top 1 1 From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'type_livraison_atlas' And val_car is not null And val_car in ( 'PXM' ))
			Begin
	   			Select @sCodLivrAtlas = val_car From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'code_livraison_atlas'
				If @sCodLivrAtlas is null Set @sCodLivrAtlas = ''
				
				Set @sCodLivrAtlas = Replace ( @sCodLivrAtlas, '#', '' )
				If IsNumeric (@sCodLivrAtlas) = 1 
				 Begin
					Set @iVal = Convert ( Integer, @sCodLivrAtlas  )
					Set @sCodLivrAtlas  = Convert ( Varchar, @iVal )
				 End	

				If Not Exists ( Select Top 1 1 From sysadm.boutique Where id_prod = 9133 And cod_mag = @sCodLivrAtlas )
				  Begin
					Set @sMsgTemp = 'Le code boutique PSM ' + @sCodLivrAtlas +' n''existe pas (même sans ces #). Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
					Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Boutique PSM Proxi non valide', @sMsgTemp 
					Return -1
				  End
			End

		-- Si différent de RPU alors Contrôler que le code_psm_centra_atlas, doit être un nombre, et existait dans la mes boutiques PSM.
		If Exists ( Select Top 1 1 From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'type_livraison_atlas' And val_car is not null And val_car not in ( 'RPU' ))
			Begin
	   			Select @sCodPSMCentreAtlas  = val_car From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'code_psm_centra_atlas'
				If @sCodPSMCentreAtlas  is null Set @sCodPSMCentreAtlas  = ''

				If IsNumeric (@sCodPSMCentreAtlas) = 1 
				 Begin
					Set @iVal = Convert ( Integer, @sCodPSMCentreAtlas  )
					Set @sCodPSMCentreAtlas  = Convert ( Varchar, @iVal )
				 End	
				
				If Not Exists ( Select Top 1 1 From sysadm.boutique Where id_prod = 9133 And cod_mag = @sCodPSMCentreAtlas  )
				  Begin
				    Set @sMsgTemp = 'Le code boutique PSM ' + @sCodPSMCentreAtlas  + '. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
					Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Boutique PSM Centra non valide', @sMsgTemp 
					Return -1
				  End
			End

		-- Présence code_livraison_Atlas pour RPU, PXM
		If Exists ( 
				Select Top 1 1 
				From sysadm.w_div_sin wds
				Where wds.id_sin = @adcIdSin 
				And wds.nom_zone = 'type_livraison_atlas' And wds.val_car in (  'RPU', 'PXM' )
				)
			Begin 
				If Not Exists ( 
				Select Top 1 1 
				From sysadm.w_div_sin wds
				Where wds.id_sin = @adcIdSin 
				And wds.nom_zone = 'code_livraison_atlas'
				And wds.val_car is not null
				And lTrim ( wds.val_car ) <> '' 
				)
				Begin
					Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Code de livraison non renseigné', 'Le mode de livraison choisi impose un code de livraison que n''a pas été renseigné par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
					Return -1
				End
			End 

			-- Coder la régle du bug atlas
			Set @iInterL = 0
			If Exists ( 
					Select Top 1 1 
					From sysadm.w_inter wi
					Where wi.id_sin = @adcIdSin 
					And   wi.cod_inter = 'L'
					)
			Begin
				Set @iInterL = 1
			End 

			Select @sTypLivrAtlas = val_car From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'type_livraison_atlas'
			If @sTypLivrAtlas  is null Set @sTypLivrAtlas = ''
			Select @sCodLivrAtlas = val_car From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'code_livraison_atlas'
			If @sCodLivrAtlas is null Set @sCodLivrAtlas = ''

			If ( @iInterL <= 0 And @sTypLivrAtlas in ( 'RPU', 'BPP' ) ) Or 
			   @sTypLivrAtlas = '' Or 
			   ( @sTypLivrAtlas in ( 'RPU', 'PXM') And @sCodLivrAtlas = '' )
			   Begin
			    Set @sMsgMail = 'Bug ATLAS à l''instant sur dossier :  ' + Convert ( VarChar ( 10), @adcIdSin ) + ', GT : WEB ATLAS AUTOMATISATION (rejeté donc), Base ' + ( Upper ( sysadm.FN_TRIM ( db_name ( db_id () ) ) ) )
				Set @sObjMail = 'Bug ATLAS : Dossier ' + Convert ( VarChar ( 10), @adcIdSin )

				EXEC master.dbo.SPB_PS_MAIL 
						@sRetourErrMail OUTPUT, 
						--'jff@spb.fr',
						'mpotrel@spb.fr,jff@spb.fr,hforjonel@spb.fr',
						@sMsgMail, 
						@sObjMail, 
						'Bug ATLAS !', 
						'', 
						@sFicOut, 
						NULL, 
						NULL, 
						NULL, 
						NULL

				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Bug ATLAS', 'Données incohérentes (inexploitables) transmises par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			   End 

		-- [VDOC18196] 02/11
		If Exists ( 
				Select Top 1 1 
				From   sysadm.det_pro dp,
					   sysadm.w_sin ws
				Where  ws.id_sin = @adcIdSin
				And	   dp.id_prod = ws.id_prod
				And    dp.id_code_dp = 283
				And	   CharIndex ( rtrim ( val_car ), ws.modl_port ) > 0 
			) 
		   And Exists ( Select Top 1 1 From sysadm.w_div_sin Where id_sin = @adcIdSin And nom_zone = 'type_livraison_atlas' And val_car is not null And val_car in ( 'PXM' ))
		  Begin
			Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Proxi PSM interdite pour ce modèle', 'Proximité PSM interdite pour ce modèle (-dp/283), ce doit être PSM en centralisation absolument. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
			Return -1
		  End 


	-- Ecriture
		-- Ecriture valeur d'achat
	/* -- Vu avec Marin, ATLAS ne la passant jamais, on mets la valeur publique, mail du 03/10/2016 10h58 voir RepPcc
		Update	sysadm.w_detail 
		Set		mt_val_achat = wds.val_mt
		From	sysadm.w_div_sin wds,
				sysadm.w_detail wd
		Where	wds.id_sin = @adcIdSin
		And		wds.nom_zone = 'mt_val_achat_adh'
		And		wd.id_sin = wds.id_sin
	*/
		-- Ecriture valeur publique & -- Ecriture valeur d'achat
		Select @sMarqApp = rtrim ( marq_port), @sModlApp = rtrim ( modl_port) From sysadm.w_sin Where id_sin = @adcIdSin
		Exec sysadm.PS_S_SAGA2_INTERRO_IFR @sMarqApp, @sModlApp , @dcPrixPublic OUTPUT

		If @dcPrixPublic is null Set @dcPrixPublic = 0 

		If @dcPrixPublic > 0 
		  Begin 
			Update	sysadm.w_detail 
			Set		mt_val_publique = @dcPrixPublic,
					mt_val_achat = @dcPrixPublic -- Vu avec Marin, ATLAS ne la passant jamais, on mets la valeur publique, mail du 03/10/2016 10h58 voir RepPcc
			From	sysadm.w_detail wd
			Where	wd.id_sin = @adcIdSin

			Insert into w_div_sin Values ( @adcIdSin, 'mt_val_publique', 'Valeur publique de l''appareil', '-XX', 'N', 'S', 'N', 'O', 500, null, @dcPrixPublic , null, null, 0, getdate(), getdate(), 'WEB')                             
		  End
		Else
		   Begin
			Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Marq/Modl non dispo sur IFR', 'La marque et le modèle ne sont plus dispo sur IFR, contactez Sébastien Loison pour la réactiver. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
			Return -1
		   End 
			
Go

grant execute on sysadm.PS_I_PM234_7_DOSSIER_INTEGRE to rolebddsinistres
Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_PM234_7_REGLE_SPEC_ET_REFUS
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
-- JFF   09/11/2017 [VDOC25048] Retrait de la marque HP de l'interdiction, PA TASSEL / MYRELIS
-- JFF   14/12/2017   [DF005-1-LOT2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_REGLE_SPEC_ET_REFUS' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_REGLE_SPEC_ET_REFUS
GO

CREATE procedure sysadm.PS_I_PM234_7_REGLE_SPEC_ET_REFUS
	@adcIdSin   Decimal (10)
AS

Declare @iRet Integer
Declare @sRefus VarChar ( 100 )
Declare @sChaine VarChar ( 255 )
Declare @iRefusAutoAutorise Integer
Declare @sChaineBcv VarChar ( 255 )

Set @sChaineBcv = ''

-- [DF005-1-LOT2]
If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
 Begin
    Select @iRefusAutoAutorise = 
		Case 
			When sysadm.FN_CLE_VAL ( 'DF005_2_REFUS_AUTO', rtrim ( dp.val_car ) + rtrim ( dp.val_car2 ), ';' ) = 'OUI' Then 1
			Else 0
		End 
	From	sysadm.w_sin ws,
			sysadm.det_pro dp
	Where	ws.id_sin = @adcIdSin
	And		dp.id_prod = ws.id_prod
	And		dp.id_code_dp = 303
	If @iRefusAutoAutorise is null Set @iRefusAutoAutorise = 0
 End
Else
 Begin
	Set @iRefusAutoAutorise = 0
 End 

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
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Règle spécifique dp/290', 'Le modèle de l''appareil n''est pas éligible au système, voir VDOC18734 et DT200. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End		
		
		-- Forfait de réparation -dp/110
		If Exists ( 
			Select Top 1 1 
			From	sysadm.w_detail wd,
					sysadm.w_sin ws,
					sysadm.det_pro dp
			Where	ws.id_sin = @adcIdSin 
			And		wd.id_sin = ws.id_sin
			And		dp.id_prod = ws.id_prod
			And		dp.id_code_dp = 110
			And		wd.mt_val_publique <= Convert ( Decimal ( 11, 2 ), sysadm.FN_CLE_VAL ( 'FORFAIT', val_car, ';'))
			)
			Begin
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Forfait dépassé dp/110', 'Le forfait de réparation n''autorise pas la réparation de ce modèle ayant une valeur publique inférieure au forfait. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End		

		-- Marque interdite de réparation
		-- [VDOC25048] retrait 'HP' 
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
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Marque interdite en réparation', 'La marque sinistrée est interdite en réparation. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1
			End		

	-- Refus
		-- Si AMU un refus opérateur venant d'ATLAS => Rejet.
		If Exists ( Select Top 1 1 From sysadm.w_refus Where id_sin = @adcIdSin And alt_ope = 'O' ) 
		 Begin
			-- [DF005-1-LOT2]
			If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
			 Begin
				If @iRefusAutoAutorise > 0 
				  Begin
					Return 2 -- Cas du refus géré avec courrier et validation
				  End 
				Else
				  Begin
					Select @sRefus = stuff ( ( SELECT Distinct ', ' + CAST(rtrim ( id_motif ) AS VARCHAR(250)) FROM sysadm.w_refus Where id_sin = @adcIdSin And alt_ope = 'O' For XML PATH ('') ), 1, 2, '' )
					If @sRefus is null Set @sRefus = ''
					Set @sChaine = 'Un ou plusieurs opérateur refus ou coché(s) par ATLAS sont présent (code refus : ' + @sRefus + '). Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'

					Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus opérateur ATLAS présent', @sChaine 
					Return -1
				  End
			 End
			Else
			 Begin
				Select @sRefus = stuff ( ( SELECT Distinct ', ' + CAST(rtrim ( id_motif ) AS VARCHAR(250)) FROM sysadm.w_refus Where id_sin = @adcIdSin And alt_ope = 'O' For XML PATH ('') ), 1, 2, '' )
				If @sRefus is null Set @sRefus = ''
				Set @sChaine = 'Un ou plusieurs opérateur refus ou coché(s) par ATLAS sont présent (code refus : ' + @sRefus + '). Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'

				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus opérateur ATLAS présent', @sChaine 
				Return -1
			 End
		 End 

		-- Refus Revision
		Exec @iRet = sysadm.PS_I_PM234_7_REFUS_REVISION @adcIdSin
		If @iRet = -1 Return @iRet

		-- [DF005-1-LOT2]
		If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
			Begin
				If @iRefusAutoAutorise > 0 
				  Begin
					Set @sChaineBcv = 'REFUS_AUTO=' + 
							Case @iRefusAutoAutorise 
								When 1 Then 'OUI'
								Else 'NON'
							End 
				  End

				-- Refus 601
				Exec @iRet = sysadm.PS_I_PM234_7_REFUS_601_V01 @adcIdSin, @sChaineBcv
				If @iRet in ( -1, 2 ) Return @iRet

				-- Refus 602
				Exec @iRet = sysadm.PS_I_PM234_7_REFUS_602_V01 @adcIdSin, @sChaineBcv
				If @iRet in ( -1, 2 ) Return @iRet

				-- Refus 604
				Exec @iRet = sysadm.PS_I_PM234_7_REFUS_604_V01 @adcIdSin, @sChaineBcv
				If @iRet in ( -1, 2 ) Return @iRet

				-- Refus 611
				Exec @iRet = sysadm.PS_I_PM234_7_REFUS_611_V01 @adcIdSin, @sChaineBcv
				If @iRet in ( -1, 2 ) Return @iRet

				-- Refus 612
				Exec @iRet = sysadm.PS_I_PM234_7_REFUS_612_V01 @adcIdSin, @sChaineBcv
				If @iRet in ( -1, 2 ) Return @iRet

				-- Refus 613
				Exec @iRet = sysadm.PS_I_PM234_7_REFUS_613_V01 @adcIdSin, @sChaineBcv
				If @iRet in ( -1, 2 ) Return @iRet

				-- Refus 641
				Exec @iRet = sysadm.PS_I_PM234_7_REFUS_641_V01 @adcIdSin, @sChaineBcv
				If @iRet in ( -1, 2 ) Return @iRet

				-- Refus 642
				Exec @iRet = sysadm.PS_I_PM234_7_REFUS_642_V01 @adcIdSin, @sChaineBcv
				If @iRet in ( -1, 2 ) Return @iRet

				-- Refus 643
				Exec @iRet = sysadm.PS_I_PM234_7_REFUS_643_V01 @adcIdSin, @sChaineBcv
				If @iRet in ( -1, 2 ) Return @iRet
			End
		Else
			Begin
				Exec @iRet = sysadm.PS_I_PM234_7_REFUS_601 @adcIdSin
				If @iRet = -1 Return @iRet

				-- Refus 602
				Exec @iRet = sysadm.PS_I_PM234_7_REFUS_602 @adcIdSin
				If @iRet = -1 Return @iRet

				-- Refus 604
				Exec @iRet = sysadm.PS_I_PM234_7_REFUS_604 @adcIdSin
				If @iRet = -1 Return @iRet

				-- Refus 611
				Exec @iRet = sysadm.PS_I_PM234_7_REFUS_611 @adcIdSin
				If @iRet = -1 Return @iRet

				-- Refus 612
				Exec @iRet = sysadm.PS_I_PM234_7_REFUS_612 @adcIdSin
				If @iRet = -1 Return @iRet

				-- Refus 613
				Exec @iRet = sysadm.PS_I_PM234_7_REFUS_613 @adcIdSin
				If @iRet = -1 Return @iRet

				-- Refus 641
				Exec @iRet = sysadm.PS_I_PM234_7_REFUS_641 @adcIdSin
				If @iRet = -1 Return @iRet

				-- Refus 642
				Exec @iRet = sysadm.PS_I_PM234_7_REFUS_642 @adcIdSin
				If @iRet = -1 Return @iRet

				-- Refus 643
				Exec @iRet = sysadm.PS_I_PM234_7_REFUS_643 @adcIdSin
				If @iRet = -1 Return @iRet
			End

		-- Refus 603
		Exec @iRet = sysadm.PS_I_PM234_7_REFUS_603 @adcIdSin
		If @iRet = -1 Return @iRet

		-- Refus 1676
		-- Demandé par Marin pour de ne pas déclencher ce contrôle en SIM
		If @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		 Begin
			Exec @iRet = sysadm.PS_I_PM234_7_REFUS_1676 @adcIdSin
			If @iRet = -1 Return @iRet
		 End 
Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_PM234_7_REFUS_REVISION
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
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_REFUS_REVISION' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_REFUS_REVISION
GO

CREATE procedure sysadm.PS_I_PM234_7_REFUS_REVISION
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
		Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Avenant/Révision non déterminé', 'Le système n''a pas pu déterminer d''avenant (de révision) sur ce dossier. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
		Return -1				
	End
Else
	Begin
		Update sysadm.w_sin Set id_rev = Convert ( Decimal ( 7 ), @sRev ) Where id_sin = @adcIdSin
	End

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_PM234_7_REFUS_601
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
-- JFF   14/12/2017   [DF005-1-LOT2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_REFUS_601_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_REFUS_601_V01
GO

CREATE procedure sysadm.PS_I_PM234_7_REFUS_601_V01
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

-- [DF005-1-LOT2]
If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
 Begin
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
			-- [DF005-1-LOT2]
				If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
				  Begin
					If @iCasRefus > 0 
					  Begin
						Insert into sysadm.w_refus Values ( @adcIdSin, @dcIdGti, -1, 601, 'O', 'N', 0, @sPara, @iCptTri, GetDate(), GetDate (), 'JFF' ) 
						Return 2
					  End
					Else
					  Begin
						Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus machine 601', 'Le refus machine 601 s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
						Return -1				
					  End
	 			  End
				Else
				  Begin
					Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus machine 601', 'Le refus machine 601 s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
					Return -1				
				  End
			End 
	End
Go



--------------------------------------------------------------------
-- Procédure            :       PS_I_PM234_7_REFUS_602
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
-- JFF   14/12/2017   [DF005-1-LOT2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_REFUS_602_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_REFUS_602_V01
GO

CREATE procedure sysadm.PS_I_PM234_7_REFUS_602_V01
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
If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
 Begin
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

			-- [DF005-1-LOT2]
				If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
				  Begin
					If @iCasRefus > 0 
					  Begin
						Insert into sysadm.w_refus Values ( @adcIdSin, @dcIdGti, -1, 602, 'O', 'N', 0, @sPara, @iCptTri, GetDate(), GetDate (), 'JFF' ) 
						Return 2
					  End
					Else
					  Begin
						Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus machine 602', 'Le refus machine 602 s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
						Return -1				
					  End
	 			  End
				Else
				  Begin
					Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus machine 602', 'Le refus machine 602 s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
					Return -1				
				  End
			End
	End
Go


--------------------------------------------------------------------
-- Procédure            :       PS_I_PM234_7_REFUS_603
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
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_REFUS_603' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_REFUS_603
GO

CREATE procedure sysadm.PS_I_PM234_7_REFUS_603
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
				Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus machine 603', 'Le refus machine 603 s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
				Return -1				
			End 
	End
Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_PM234_7_REFUS_604
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
-- JFF   14/12/2017   [DF005-1-LOT2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_REFUS_604_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_REFUS_604_V01
GO

CREATE procedure sysadm.PS_I_PM234_7_REFUS_604_V01
	@adcIdSin   Decimal (10),
	@asChaineBcv VarChar (255)
AS

Declare @iCasRefus Integer
Declare @sPara VarChar ( 4 )
Declare @iCptTri Integer
Declare @dcIdGti Decimal ( 7 )

Set @iCasRefus = 0

-- [DF005-1-LOT2]
If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
 Begin
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
			If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
				Begin
					If @iCasRefus > 0 
						Begin
							Insert into sysadm.w_refus Values ( @adcIdSin, @dcIdGti, -1, 604, 'O', 'N', 0, @sPara, @iCptTri, GetDate(), GetDate (), 'JFF' ) 
							Return 2
						End
					Else
						Begin
							Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus machine 604', 'Le refus machine 604 s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
							Return -1
						End
	 			End
			Else
				Begin
					Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus machine 604', 'Le refus machine 604 s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
					Return -1
				End
	End 

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_PM234_7_REFUS_611
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
-- JFF   14/12/2017   [DF005-1-LOT2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_REFUS_611_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_REFUS_611_V01
GO

CREATE procedure sysadm.PS_I_PM234_7_REFUS_611_V01
	@adcIdSin   Decimal (10),
	@asChaineBcv VarChar (255)
AS

Declare @iCasRefus Integer
Declare @sPara VarChar ( 4 )
Declare @iCptTri Integer
Declare @dcIdGti Decimal ( 7 )

Set @iCasRefus = 0

-- [DF005-1-LOT2]
If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
 Begin
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
		-- [DF005-1-LOT2]
			If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
				Begin
				If @iCasRefus > 0 
					Begin
						Insert into sysadm.w_refus Values ( @adcIdSin, @dcIdGti, -1, 611, 'O', 'N', 0, @sPara, @iCptTri, GetDate(), GetDate (), 'JFF' ) 
						Return 2
					End
				Else
					Begin
						Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus machine 611', 'Le refus machine 611 s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
						Return -1				
					End
	 			End
			Else
				Begin
					Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus machine 611', 'Le refus machine 611 s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
					Return -1				
				End
	End 

Go


--------------------------------------------------------------------
-- Procédure            :       PS_I_PM234_7_REFUS_612
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
-- JFF   14/12/2017   [DF005-1-LOT2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_REFUS_612_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_REFUS_612_V01
GO

CREATE procedure sysadm.PS_I_PM234_7_REFUS_612_V01
	@adcIdSin   Decimal (10),
	@asChaineBcv VarChar (255)
AS

Declare @iCasRefus Integer
Declare @sPara VarChar ( 4 )
Declare @iCptTri Integer
Declare @dcIdGti Decimal ( 7 )

Set @iCasRefus = 0

-- [DF005-1-LOT2]
If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
 Begin
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
			-- [DF005-1-LOT2]
				If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
				  Begin
					If @iCasRefus > 0 
					  Begin
						Insert into sysadm.w_refus Values ( @adcIdSin, @dcIdGti, -1, 612, 'O', 'N', 0, @sPara, @iCptTri, GetDate(), GetDate (), 'JFF' ) 
						Return 2
					  End
					Else
					  Begin
						Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus machine 612', 'Le refus machine 612 s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
						Return -1				
					  End
	 			  End
				Else
				  Begin
					Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus machine 612', 'Le refus machine 612 s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
					Return -1				
				  End
	End 

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_PM234_7_REFUS_613
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
-- JFF   14/12/2017   [DF005-1-LOT2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_REFUS_613_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_REFUS_613_V01
GO

CREATE procedure sysadm.PS_I_PM234_7_REFUS_613_V01
	@adcIdSin   Decimal (10),
	@asChaineBcv VarChar (255)
AS

Declare @iCasRefus Integer
Declare @sPara VarChar ( 4 )
Declare @iCptTri Integer
Declare @dcIdGti Decimal ( 7 )

Set @iCasRefus = 0

-- [DF005-1-LOT2]
If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
 Begin
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
				If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
				  Begin
					If @iCasRefus > 0 
					  Begin
						Insert into sysadm.w_refus Values ( @adcIdSin, @dcIdGti, -1, 613, 'O', 'N', 0, @sPara, @iCptTri, GetDate(), GetDate (), 'JFF' ) 
						Return 2
					  End
					Else
					  Begin
						Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus machine 613', 'Le refus machine 613 s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
						Return -1				
					  End
	 			  End
				Else
				  Begin
					Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus machine 613', 'Le refus machine 613 s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
					Return -1				
				  End
	End 

Go


--------------------------------------------------------------------
-- Procédure            :       PS_I_PM234_7_REFUS_641
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
-- JFF   14/12/2017   [DF005-1-LOT2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_REFUS_641_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_REFUS_641_V01
GO

CREATE procedure sysadm.PS_I_PM234_7_REFUS_641_V01
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

-- [DF005-1-LOT2]
If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
 Begin
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

			-- [DF005-1-LOT2]
				If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
				  Begin
					If @iCasRefus > 0 
					  Begin
						Insert into sysadm.w_refus Values ( @adcIdSin, @dcIdGti, -1, 641, 'O', 'N', 0, @sPara, @iCptTri, GetDate(), GetDate (), 'JFF' ) 
						Return 2
					  End
					Else
					  Begin
						Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus machine 641', 'Le refus machine 641 s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
						Return -1
					  End
	 			  End
				Else
				  Begin
					Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus machine 641', 'Le refus machine 641 s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
					Return -1
				  End
			
	End 

Go


--------------------------------------------------------------------
-- Procédure            :       PS_I_PM234_7_REFUS_642
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
-- JFF   14/12/2017   [DF005-1-LOT2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_REFUS_642_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_REFUS_642_V01
GO

CREATE procedure sysadm.PS_I_PM234_7_REFUS_642_V01
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

-- [DF005-1-LOT2]
If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
 Begin
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
			-- [DF005-1-LOT2]
				If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
				  Begin
					If @iCasRefus > 0 
					  Begin
						Insert into sysadm.w_refus Values ( @adcIdSin, @dcIdGti, -1, 642, 'O', 'N', 0, @sPara, @iCptTri, GetDate(), GetDate (), 'JFF' ) 
						Return 2
					  End
					Else
					  Begin
						Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus machine 642', 'Le refus machine 642 s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
						Return -1	
					  End
	 			  End
				Else
				  Begin
					Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus machine 642', 'Le refus machine 642 s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
					Return -1	
				  End
	End 

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_PM234_7_REFUS_643
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
-- JFF   14/12/2017   [DF005-1-LOT2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_REFUS_643_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_REFUS_643_V01
GO

CREATE procedure sysadm.PS_I_PM234_7_REFUS_643_V01
	@adcIdSin   Decimal (10),
	@asChaineBcv VarChar (255)
AS

Declare @iCasRefus Integer
Declare @sPara VarChar ( 4 )
Declare @iCptTri Integer
Declare @dcIdGti Decimal ( 7 )

Set @iCasRefus = 0

-- [DF005-1-LOT2]
If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
 Begin
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
			-- [DF005-1-LOT2]
				If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
				  Begin
					If @iCasRefus > 0 
					  Begin
						Insert into sysadm.w_refus Values ( @adcIdSin, @dcIdGti, -1, 643, 'O', 'N', 0, @sPara, @iCptTri, GetDate(), GetDate (), 'JFF' ) 
						Return 2
					  End
					Else
					  Begin
						Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus machine 643', 'Le refus machine 643 s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
						Return -1
					  End
	 			  End
				Else
				  Begin
					Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus machine 643', 'Le refus machine 643 s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
					Return -1
				  End
	End 

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_PM234_7_REFUS_1676
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
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_REFUS_1676' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_REFUS_1676
GO

CREATE procedure sysadm.PS_I_PM234_7_REFUS_1676
	@adcIdSin   Decimal (10)
AS

Declare @sTypApp VarChar ( 10 )
Declare @sCtrlImeiSucces VarChar ( 10 )
Declare @iDp263 Integer
Declare @iDp239 Integer
Declare @iDp249 Integer
Declare @iDpRetenue Integer
Declare @iOrangeCaraibe VarChar ( 10)
Declare @sVal Varchar ( 255 )
Declare @sNumPort VarChar ( 35 )
Declare @sIMEI VarChar ( 35 )
Declare @dtDteSurv DateTime
Declare @lRet Integer
Declare @dtDerTrans DateTime
Declare @iRenseignerDDU Integer
Declare @dtDteAdh DateTime

If Not Exists ( 
		Select Top 1 1 
		From sysadm.det_pro dp,
				sysadm.w_sin ws
		Where ws.id_sin = @adcIdSin
		And   dp.id_prod = ws.id_prod
		And	  dp.id_code_dp = 239 )
   And
	Not Exists ( 
		Select Top 1 1 
		From sysadm.det_pro dp,
				sysadm.w_sin ws
		Where ws.id_sin = @adcIdSin
		And   dp.id_prod = ws.id_prod
		And	  dp.id_code_dp = 249 )
   And
	Not Exists ( 
		Select Top 1 1 
		From sysadm.det_pro dp,
				sysadm.w_sin ws
		Where ws.id_sin = @adcIdSin
		And   dp.id_prod = ws.id_prod
		And	  dp.id_code_dp = 263 )
	Begin
		Return 1 -- Pas de contrôle 
	End 

Set @iOrangeCaraibe = 0
Set @sVal = ''

Select	@sTypApp = ds.val_car
From	sysadm.div_sin ds
Where   ds.id_sin = @adcIdSin
And		ds.nom_zone = 'type_app'

Set @iDp263 = 0
If Exists ( 
		Select Top 1 1 
		From sysadm.det_pro dp,
			 sysadm.w_sin ws
		Where ws.id_sin = @adcIdSin
		And   dp.id_prod = ws.id_prod
		And	  dp.id_code_dp = 263 )
	Begin
		Set @iDp263 = 1
	End 

If @sTypApp = 'PC2' And @iDp263 = 0 Return 1 -- Pas de contrôle 
If @sTypApp <> 'TEL' Return 1 -- Pas de contrôle 

Set @iDpRetenue = 0

Set @iDp239 = 0
Select Top 1 @sVal = sysadm.FN_CLE_VAL ( 'VARIANTE', val_car, ';' ) 
From sysadm.det_pro dp,
		sysadm.w_sin ws
Where ws.id_sin = @adcIdSin
And   dp.id_prod = ws.id_prod
And	  dp.id_code_dp = 239 
If @@RowCount > 0
	Begin
		Set @iDp239 = 1
		Set @iDpRetenue = 1
	End 

If @iDpRetenue <= 0 
	Begin
		Set @iDp263 = 0
		Select Top 1 @sVal = sysadm.FN_CLE_VAL ( 'VARIANTE', val_car, ';' ) 
		From sysadm.det_pro dp,
				sysadm.w_sin ws
		Where ws.id_sin = @adcIdSin
		And   dp.id_prod = ws.id_prod
		And	  dp.id_code_dp = 263
		If @@RowCount > 0
			Begin
				Set @iDp263 = 1
				Set @iDpRetenue = 1
			End 
	End 

If @iDpRetenue <= 0 
	Begin
		Set @iDp249 = 0
		Select Top 1 @sVal = sysadm.FN_CLE_VAL ( 'VARIANTE', val_car, ';' ) 
		From sysadm.det_pro dp,
			 sysadm.w_sin ws
		Where ws.id_sin = @adcIdSin
		And   dp.id_prod = ws.id_prod
		And	  dp.id_code_dp = 249
		If @@RowCount > 0
			Begin
				Set @iDp249 = 1
				Set @iDpRetenue = 1
				Set @iOrangeCaraibe = 1
			End 	
	End 

If @iDpRetenue > 0 And @sVal = ''
  Begin
	Select  @sNumPort = Replace ( rtrim ( ws.num_port ), ' ', '' ),
			@sIMEI = rtrim ( ws.num_imei_port ),
			@dtDteSurv = ws.dte_surv,
			@dtDteAdh = dte_adh

	From	sysadm.w_sin ws
	Where	ws.id_sin = @adcIdSin

	If @sNumPort is null Set @sNumPort = ''
	If @sIMEI is null Set @sIMEI = ''

	If @sNumPort = '' Or @sIMEI = '' 
	 Begin
		Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus machine 1676', 'Le refus machine 1676 s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
		Return -1				
	 End 

	If @iOrangeCaraibe > 0 
		Begin
			Exec @lRet = sysadm.PS_S01_CTL_IMEI_ORANGECARAIBE  @sNumPort, @sIMEI, @dtDteSurv 
		End 
	Else
		Begin
			Exec @lRet = sysadm.PS_S01_CTL_IMEI_ORANGEV3_V02 @sNumPort, @sIMEI, @dtDteSurv, @dtDerTrans OutPut 

			If  @dtDerTrans is not null  Set @iRenseignerDDU = 1 
			IF @lRet > 0 And @dtDerTrans < @dtDteAdh Set @lRet = 0
		End 

	If @lRet > 0 
		Begin
			Insert into sysadm.w_div_sin Values ( @adcIdSin, 'ctrl_imei_succes', 'Imei controlé avec succès', -1, 'N', 'X', 'N', 'O', 700, null, null ,null, 'O', 0,getdate(), getdate(), 'WEB' )
		End 

	If @lRet > 0 Or @iRenseignerDDU > 0 
		Begin
			Insert into sysadm.w_div_sin Values ( @adcIdSin, 'cra_last_dte', 'Date Dernière Utilisation', -1, 'N', 'D', 'N', 'O', 40, null, null ,@dtDerTrans, null, 0,getdate(), getdate(), 'WEB' )
		End 

	If @lRet <= 0 
	 Begin
		Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus machine 1676', 'Le refus machine 1676 s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
		Return -1				
	 End 		

  End 

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_PM234_7_PLAFOND_PEC
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
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_PLAFOND_PEC' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_PLAFOND_PEC
GO

CREATE procedure sysadm.PS_I_PM234_7_PLAFOND_PEC
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

-- Select '@dcMtPec', @dcMtPec

DECLARE @tb TABLE 
	( id_seq		integer identity,
	  id_ref_plaf	decimal (7 ),
	  id_typ_plaf	integer,
	  mt_plaf		decimal ( 11,2 ),
	  marquage		integer null 
	)

-- Stockage de données et pré-calcul
Select  @dcIdProd = ws.id_prod,
		@dcIdEts = ws.id_ets,
		@sIdAdh = rtrim ( ws.id_adh ),
		@sNumPort = rtrim ( ws.num_port ) ,
		@dtDteSurv = dte_surv,
		@dcIdEvt = wd.id_evt,
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
				-- Plafond 752
				If @sIdTypPlaf = 752 
				  Begin
					Set @iNbAutreSin = 0
				  	Exec sysadm.PS_S_W_GTI_NBSIN_NUM_PORT_ANN_ADH 
						@adcIdSin, 
						@dcIdProd,
						@dcIdEts,
						@sIdAdh,
						@sNumPort,
						@dtDteSurv,
						@dtDteRenouv,
						@iNbAutreSin OutPut

					Set @iSinEnCours = 1
					If @iNbAutreSin is null Set @iNbAutreSin = 0

					If @iSinEnCours + @iNbAutreSin > @dcMtPlaf
					 Begin
						Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Refus machine 1483', 'Le refus machine 1483 (Plafond 752) s''est déclenché. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
						Return -1				
					 End 		
				  End 
				  -- /Plafond 752
			  End 
			  -- /Plafond de garantie

			-- Plafond d'évènement (détail de garantie)
			If @dcIdRefPlaf <> -1
			  Begin
				-- Plafond 680
				If @sIdTypPlaf = 680 And @dcIdRefPlaf = @dcIdEvt 
				  Begin
					If @dcMtPec > @dcMtPlaf Set @dcMtPec = @dcMtPlaf
				  End 
				-- /Plafond 680

				-- Plafond 671
				If @sIdTypPlaf = 671 And @dcIdRefPlaf = @dcIdEvt 
				  Begin
					If @dcMtPec > @dcMtValAchat Set @dcMtPec = @dcMtValAchat
				  End 
				-- /Plafond 671

				-- Plafond 675
				If @sIdTypPlaf = 675 And @dcIdRefPlaf = @dcIdEvt 
				  Begin
					If @dcMtPec > @dcMtValPublique Set @dcMtPec = @dcMtValPublique
				  End 
				-- /Plafond 675

			  End 
			-- /Plafond d'évènement (détail de garantie)

			Update @tb
			Set marquage = 1
			Where id_seq = @iIdSeq
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
	And   ap.id_sin = 5612096 -- modèle
	And   ap.id_gti = 11 -- modèle
	And   ap.id_detail = 0 -- modèle

Go

--------------------------------------------------------------------
-- Procédure            :       PS_I_PM234_7_CREATION_PRESTA
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
-- JFF      21/02/2107   [DT288] passage à V01
-- JFF      25/03/2019   [DT398]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_CREATION_PRESTA_V01' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_CREATION_PRESTA_V01
GO

CREATE procedure sysadm.PS_I_PM234_7_CREATION_PRESTA_V01
	@adcIdSin   Decimal (10)
AS

Declare @sMarqPort VarChar ( 35 )
Declare @sModlPort VarChar ( 35 )
Declare @sIdFourModif VarChar ( 35 )
Declare @dcIdEvt Decimal ( 7 )
Declare @sIdFourDp200 VarChar ( 10 )
Declare @iFinTrt Integer
Declare @sTypLivrAtlas VarChar ( 10 )
Declare @sSkuIFR VarChar ( 50 )
Declare @sCodeVerrou VarChar ( 50 )
Declare @sCodeLivraisonAtlas VarChar ( 50 )
Declare @sAction VarChar ( 50 )
Declare @sCodeBtqPSMCentr VarChar ( 50 )
Declare @sCodeCourrier VarChar ( 10 )
Declare @sMailIOS7 VarChar ( 50 )
Declare @dcIdProd Decimal ( 7 )


Set @iFinTrt = 0
Set @sAction = 'A_REPARER'
Set @sCodeCourrier = ''
Set @sMailIOS7 = 'NON'

-- Stockage de données et pré-calcul
Select  @sMarqPort = rtrim ( ws.marq_port ),
		@sModlPort = rtrim ( ws.modl_port ),
		@dcIdEvt   = wd.id_evt,
		@sTypLivrAtlas = wds.val_car,
		@dcIdProd = ws.id_prod  -- [DT288]
From	sysadm.w_sin ws,
		sysadm.w_detail wd,
		sysadm.w_div_sin wds
Where	ws.id_sin = @adcIdSin
And		wd.id_sin = ws.id_sin
And		wds.id_sin = ws.id_sin
And		wds.nom_zone = 'type_livraison_atlas'

Select Top 1 @sSkuIFR = rtrim ( i.sku_saga )
From sysadm.w_sin ws,
		sysadm.w_div_sin wds,
		sysadm.ifr i
Where ws.id_sin = @adcIdSin 
And   i.marque = ws.marq_port
And   i.reference = ws.modl_port
And   wds.id_sin = ws.id_sin
And   wds.nom_zone = 'type_app'
And   wds.val_car in ( 'TEL', 'TPC' )
And   ( Left ( i.sku_saga, 3 ) = wds.val_car
		Or 
		i.sku_saga is null )

If @sSkuIFR is null Set @sSkuIFR = ''

Select	@sCodeVerrou = rtrim ( wds.val_car )
From	sysadm.w_div_sin wds
Where	wds.id_sin = @adcIdSin
And		wds.nom_zone = 'code_verrou_sherpa_script'

If @sCodeVerrou is null Set @sCodeVerrou = 'Pas de code verrou'

Select	@sCodeLivraisonAtlas = rtrim ( wds.val_car )
From	sysadm.w_div_sin wds
Where	wds.id_sin = @adcIdSin
And		wds.nom_zone = 'code_livraison_atlas'

If @sCodeLivraisonAtlas is null Set @sCodeLivraisonAtlas = ''

Select	@sCodeBtqPSMCentr = rtrim ( wds.val_car )
From	sysadm.w_div_sin wds
Where	wds.id_sin = @adcIdSin
And		wds.nom_zone = 'code_psm_centra_atlas'

If @sCodeBtqPSMCentr is null Set @sCodeBtqPSMCentr = ''



-- Détermination du fournisseur
Set @sIdFourModif = 'PSM'

If  CharIndex ( 'APPLE', @sMarqPort ) > 0 And 
	CharIndex ( 'IPHONE', @sModlPort ) > 0 And
	@dcIdEvt = 1377 And 
	@iFinTrt = 0
 Begin
	Set @iFinTrt = 1
	Set @sAction = 'A_DESOXYDER'

	If Exists ( 
			Select Top 1 1 
			From   sysadm.det_pro dp,
				   sysadm.w_sin ws,
				   sysadm.w_div_sin wds
			Where  ws.id_sin = @adcIdSin
			And	   wds.id_sin = ws.id_sin
			And    wds.nom_zone = 'type_app'
			And	   dp.id_prod = ws.id_prod
			And    dp.id_code_dp = 209
			And	   sysadm.FN_CLE_VAL ( 'TYP_APP', dp.val_car, ';') = wds.val_car
			And	   sysadm.FN_CLE_VAL ( 'DESOX_IPHONE', dp.val_car, ';') = 'OUI'
		) 
		Begin 
			Set @sIdFourModif = 'PSM'
		End 
	Else
		Begin 
			Set @sIdFourModif = 'O2M'
		End 
 End

If  CharIndex ( 'APPLE', @sMarqPort ) > 0 And 
	CharIndex ( 'IPHONE', @sModlPort ) > 0 And
	@dcIdEvt <> 1377 And
	@iFinTrt = 0
 Begin 
	Set @iFinTrt = 1

	If Exists ( 
			Select Top 1 1 
			From   sysadm.det_pro dp,
				   sysadm.w_sin ws
			Where  ws.id_sin = @adcIdSin
			And	   dp.id_prod = ws.id_prod
			And    dp.id_code_dp = 200
			And	   CharIndex ( sysadm.FN_CLE_VAL ( 'MODELE', val_car, ';') , ws.modl_port ) > 0 
		) 
	  Begin
		Set @sIdFourModif = 'O2M'
	  End 
	  
	-- [VDOC18196]
	If Exists ( 
			Select Top 1 1 
			From   sysadm.det_pro dp,
				   sysadm.w_sin ws
			Where  ws.id_sin = @adcIdSin
			And	   dp.id_prod = ws.id_prod
			And    dp.id_code_dp = 283
			And	   CharIndex ( rtrim ( val_car ), ws.modl_port ) > 0 
		) 
	  Begin
		Set @sIdFourModif = 'PSM'
	  End 

	Select Top 1 @sIdFourDp200 = sysadm.FN_CLE_VAL ( 'ID_FOUR', val_car, ';') 
	From   sysadm.det_pro dp,
			sysadm.w_sin ws
	Where  ws.id_sin = @adcIdSin
	And	   dp.id_prod = ws.id_prod
	And    dp.id_code_dp = 200
	And	   CharIndex ( sysadm.FN_CLE_VAL ( 'MODELE', dp.val_car, ';') , ws.modl_port ) > 0 

	If @sIdFourDp200 is not null And Len ( @sIdFourDp200 ) > 0 
	  Begin
		Set @sIdFourModif = @sIdFourDp200
	  End 
 End 

If  CharIndex ( 'APPLE', @sMarqPort ) > 0 And 
	CharIndex ( 'IPAD', @sModlPort ) > 0 And
	@dcIdEvt <> 1377 And
	@iFinTrt = 0
 Begin 
	Set @iFinTrt = 1

	If Exists ( 
			Select Top 1 1 
			From   sysadm.det_pro dp,
				   sysadm.w_sin ws
			Where  ws.id_sin = @adcIdSin
			And	   dp.id_prod = ws.id_prod
			And    dp.id_code_dp = 200
			And	   CharIndex ( sysadm.FN_CLE_VAL ( 'MODELE', val_car, ';') , ws.modl_port ) > 0 
		) 
	  Begin
		Set @sIdFourModif = 'O2M'
	  End 
	  
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
 End 
 
 -- Le 31/10/2016 Bug
 If  CharIndex ( 'APPLE', @sMarqPort ) > 0 
  Begin 
	Set @sMailIOS7 = 'OUI'
  End 

 -- Préparation insertion presta
 Set @iFinTrt = 0


 -- WTE596
 If @sIdFourModif = 'O2M' And 
	@sTypLivrAtlas = 'BPP' And 
	@sAction = 'A_REPARER' And 
	@iFinTrt = 0
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
			Left ( ltrim ( rTrim ( Right ( rtrim ( wiL.nom ) , Len( rtrim ( wiL.nom ) ) - ( CharIndex ( '[#]', rtrim ( wiL.nom ) ) + 2 )))), 35 ),
			Left ( ltrim ( rTrim ( Left ( rtrim ( wiL.nom ), (CharIndex ( '[#]', rtrim ( wiL.nom )) - 1 )))), 35 ),
			rtrim ( wiL.adr_1 ),
			rtrim ( wiL.adr_2 ),
			prs.adr_livr_cpl,
			rtrim ( wiL.adr_cp ),
			rtrim ( wiL.adr_ville ),
			IsNull ( IsNull ( rtrim (wiA.num_teld), rtrim (wiA.num_telb )), rtrim (ws.num_port )),
			IsNull ( IsNull ( rtrim (wiA.num_telb), rtrim (wiA.num_teld )), rtrim (ws.num_port )),
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
			'Automate ATLAS/SIMPA2',
			Getdate(),
			Getdate(),
			'WEB',
			prs.id_zone,
			prs.id_bsp,
			prs.dte_ret_pret,
			rtrim ( wiL.cod_civ ),
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
				sysadm.FN_CLE_VAL_E ( 'MAIL_IOS7', @sMailIOS7,
				sysadm.FN_CLE_VAL_E ( 'AUTO_ATLAS', 'OUI' , 
				sysadm.FN_CLE_VAL_E ( 'MAIL_ASSURE', rtrim ( wiA.adr_mail ) , 
				sysadm.FN_CLE_VAL_E ( 'CODE_VERROU_ORIG', @sCodeVerrou,
				sysadm.FN_CLE_VAL_E ( 'SKU_IFR', @sSkuIFR, 
				sysadm.FN_CLE_VAL_E ( 'MT_PEC', Convert ( VarChar ( 20 ), wdd.val_mt ), rtrim ( prs.info_spb_frn_cplt ), ';' )
				, ';' )
				, ';' )
				, ';' )
				, ';' )
				, ';' ),
			prs.info_frn_spb_cplt

		From sysadm.pm234_7_automate_prs prs,
			 sysadm.w_detail wdt,
			 sysadm.w_inter wiL,
			 sysadm.w_inter wiA,
			 sysadm.w_sin ws,
			 sysadm.w_div_det wdd

		Where prs.id_sin = 5614271 -- Modèle
		And	  prs.id_seq = 1 -- Modèle
		And	  wdt.id_sin = @adcIdSin
		And   wdt.id_detail = 0
		And   wiL.id_sin = wdt.id_sin 
		And	  wiL.cod_inter = 'L'
		And   wiA.id_sin = wdt.id_sin 
		And	  wiA.cod_inter = 'A'
		And	  ws.id_sin = wdt.id_sin
		And   wdd.id_sin = wdt.id_sin
		And   wdd.id_gti = wdt.id_gti
		And   wdd.id_detail = wdt.id_detail
		And   wdd.nom_zone = 'mt_pec'

		If @@ROWCOUNT = 1 
		  Begin
			Exec sysadm.PS_I_PM234_7_TAG_COURRIER_PEC @adcIdSin, 'WTE596'
		  End 

   End 


-- WTE598
 If @sIdFourModif = 'O2M' And 
	@sTypLivrAtlas = 'RPU' And 
	@sAction = 'A_REPARER' And 
	@iFinTrt = 0
   Begin
   
--   Select comment_frn, * from sysadm.pm234_7_automate_prs where id_sin = 5616659
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
			Left ( ltrim ( rTrim ( wiL.nom )), 35 ),
			Left ( Convert ( Varchar ( 10), wdt.id_sin ) + ' ' + rtrim ( ws.nom ) + ' ' + IsNull ( rtrim ( ws.prenom ), '' ), 35 ),
			rtrim ( wiL.adr_1 ),
			rtrim ( wiL.adr_2 ),
			prs.adr_livr_cpl,
			rtrim ( wiL.adr_cp ),
			rtrim ( wiL.adr_ville ),
			IsNull ( IsNull ( rtrim (wiA.num_teld), rtrim (wiA.num_telb )), rtrim (ws.num_port )),
			IsNull ( IsNull ( rtrim (wiA.num_telb), rtrim (wiA.num_teld )), rtrim (ws.num_port )),
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
			'Automate ATLAS/SIMPA2',
			Getdate(),
			Getdate(),
			'WEB',
			prs.id_zone,
			prs.id_bsp,
			prs.dte_ret_pret,
			rtrim ( wiL.cod_civ ),
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
				sysadm.FN_CLE_VAL_E ( 'MAIL_IOS7', @sMailIOS7,
				sysadm.FN_CLE_VAL_E ( 'AUTO_ATLAS', 'OUI' , 
				sysadm.FN_CLE_VAL_E ( 'CODE_PICK_UP', @sCodeLivraisonAtlas,
				sysadm.FN_CLE_VAL_E ( 'CODE_VERROU_ORIG', @sCodeVerrou,
				sysadm.FN_CLE_VAL_E ( 'SKU_IFR', @sSkuIFR, 
				sysadm.FN_CLE_VAL_E ( 'MT_PEC', Convert ( VarChar ( 20 ), wdd.val_mt ), rtrim ( prs.info_spb_frn_cplt ), ';' )
				, ';' )
				, ';' )
				, ';' )
				, ';' )
				, ';' ),
			prs.info_frn_spb_cplt

		From sysadm.pm234_7_automate_prs prs,
			 sysadm.w_detail wdt,
			 sysadm.w_inter wiL,
			 sysadm.w_inter wiA,
			 sysadm.w_sin ws,
			 sysadm.w_div_det wdd

		Where prs.id_sin = 5616659 -- Modèle
		And	  prs.id_seq = 1 -- Modèle
		And	  wdt.id_sin = @adcIdSin
		And   wdt.id_detail = 0
		And   wiL.id_sin = wdt.id_sin 
		And	  wiL.cod_inter = 'L'
		And   wiA.id_sin = wdt.id_sin 
		And	  wiA.cod_inter = 'A'
		And	  ws.id_sin = wdt.id_sin
		And   wdd.id_sin = wdt.id_sin
		And   wdd.id_gti = wdt.id_gti
		And   wdd.id_detail = wdt.id_detail
		And   wdd.nom_zone = 'mt_pec'

		Insert into sysadm.w_detail
		Select 
			wdt1.id_sin,
			wdt1.id_gti,
			wdt.id_detail,
			wdt.id_evt,
			wdt.lib_det,
			wdt.dte_det,
			wdt.heu_det,
			wdt.num_carte,
			wdt.mt_prej,
			wdt.mt_fran,
			wdt.mt_nplaf,
			wdt.mt_plaf,
			wdt.id_i_reg,
			wdt.alt_bloc,
			wdt.alt_cour,
			wdt.alt_plaf,
			wdt.alt_reg,
			wdt.alt_att,
			wdt.alt_valide,
			wdt.cpt_valide,
			wdt.alt_ssui,
			wdt.cod_mot_ssui,
			wdt.cod_dec_mac,
			wdt.cod_dec_ope,
			wdt.cod_etat,
			wdt.id_carte,
			wdt.id_type_carte,
			getdate(),
			getdate(),
			'WEB',
			wdt.dte_cmd,
			wdt.dte_livr,
			wdt1.mt_val_achat,
			wdt1.mt_val_publique,
			wdt.num_facture
		From	sysadm.pm234_7_automate_wdt wdt,
				sysadm.w_detail wdt1
		Where   wdt.id_sin = 5616670 -- Modèle
		And		wdt.id_gti = 11	-- modèle
		And		wdt.id_detail = 1 -- modèle
		And		wdt1.id_sin = @adcIdSin
		And		wdt1.id_detail = 0 

		Insert into sysadm.w_div_det
		Select 
			wd.id_sin,
			wd.id_gti,
			ap.id_detail,
			ap.nom_zone,
			ap.lib_label,
			ap.id_typ_liste,
			ap.alt_liste_codecar,
			ap.id_typ_zone,
			ap.alt_oblig,
			ap.alt_prot,
			ap.cpt_tri,
			ap.val_nbre,
			ap.val_mt,
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
		And   wd.id_detail = 0 
		And   ap.id_sin = 5616670 -- modèle
		And   ap.id_gti = 11 -- modèle
		And   ap.id_detail = 1 -- modèle

		Insert into sysadm.w_commande 
		Select 
			wdt.id_sin,
			2,
			wdt.id_gti,
			wdt.id_detail,
			prs.id_four,
			prs.id_typ_art,
			@sMarqPort,
			@sModlPort,
			prs.mt_ttc_cmde,
			Left ( ltrim ( rTrim ( wiL.nom )), 35 ),
			Left ( Convert ( Varchar ( 10), wdt.id_sin ) + ' ' + rtrim ( ws.nom ) + ' ' + IsNull ( rtrim ( ws.prenom ), '' ), 35 ),
			rtrim ( wiL.adr_1 ),
			rtrim ( wiL.adr_2 ),
			prs.adr_livr_cpl,
			rtrim ( wiL.adr_cp ),
			rtrim ( wiL.adr_ville ),
			IsNull ( IsNull ( rtrim (wiA.num_teld), rtrim (wiA.num_telb )), rtrim (ws.num_port )),
			IsNull ( IsNull ( rtrim (wiA.num_telb), rtrim (wiA.num_teld )), rtrim (ws.num_port )),
			prs.adr_tel3,
			prs.adr_mail,
			prs.dte_rdv_cli,
			prs.hrdv_cli_min,
			prs.hrdv_cli_max,
			ws.num_imei_port,
			prs.probleme,
			prs.id_cmd_frn,
			prs.id_serie_nouv,
			prs.id_bon_transp,
			prs.dte_rcp_frn,
			prs.dte_env_cli,
			prs.cod_etat,
			null,
			prs.cpt_valide,
			'Automate ATLAS/SIMPA2',
			Getdate(),
			Getdate(),
			'WEB',
			prs.id_zone,
			prs.id_bsp,
			prs.dte_ret_pret,
			rtrim ( wiL.cod_civ ),
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
				sysadm.FN_CLE_VAL_E ( 'MAIL_IOS7', @sMailIOS7,
				sysadm.FN_CLE_VAL_E ( 'AUTO_ATLAS', 'OUI' , 
				sysadm.FN_CLE_VAL_E ( 'CODE_PICK_UP', @sCodeLivraisonAtlas,
				sysadm.FN_CLE_VAL_E ( 'CODE_VERROU_ORIG', @sCodeVerrou,
				sysadm.FN_CLE_VAL_E ( 'MAIL_ASSURE', rtrim ( wiA.adr_mail ) , 
				sysadm.FN_CLE_VAL_E ( 'MT_PEC', Convert ( VarChar ( 20 ), wdd.val_mt ), rtrim ( prs.info_spb_frn_cplt ), ';' )
				, ';' )
				, ';' )
				, ';' )
				, ';' )
				, ';' ),
			prs.info_frn_spb_cplt

		From sysadm.pm234_7_automate_prs prs,
			 sysadm.w_detail wdt,
			 sysadm.w_inter wiL,
			 sysadm.w_inter wiA,
			 sysadm.w_sin ws,
			 sysadm.w_div_det wdd

		Where prs.id_sin = 5616659 -- Modèle
		And	  prs.id_seq = 2 -- Modèle
		And	  wdt.id_sin = @adcIdSin
		And   wdt.id_detail = 1
		And   wiL.id_sin = wdt.id_sin 
		And	  wiL.cod_inter = 'L'
		And   wiA.id_sin = wdt.id_sin 
		And	  wiA.cod_inter = 'A'
		And	  ws.id_sin = wdt.id_sin
		And   wdd.id_sin = wdt.id_sin
		And   wdd.id_gti = wdt.id_gti
		And   wdd.id_detail = wdt.id_detail
		And   wdd.nom_zone = 'mt_pec'

		If @@ROWCOUNT = 1 
		  Begin
			Exec sysadm.PS_I_PM234_7_TAG_COURRIER_PEC @adcIdSin, 'WTE598'
		  End 

   End 


-- WTE594
 If @sIdFourModif = 'PSM' And 
	@sTypLivrAtlas = 'BPP' And 
	@sAction = 'A_REPARER' And 	
	@iFinTrt = 0
   Begin

		If @sCodeBtqPSMCentr = '' 
		 Begin
			Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Code PSM Central. non renseigné', 'Le code boutique PSM de centralisation n''a pas été transmis par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
			Return -1				
		 End 		

		Set @iFinTrt = 1

-- Select comment_frn, * from sysadm.pm234_7_automate_prs where id_sin = 5617666

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
			Left ( ltrim ( rTrim ( Right ( rtrim ( wiL.nom ) , Len( rtrim ( wiL.nom ) ) - ( CharIndex ( '[#]', rtrim ( wiL.nom ) ) + 2 )))), 35 ),
			Left ( ltrim ( rTrim ( Left ( rtrim ( wiL.nom ), (CharIndex ( '[#]', rtrim ( wiL.nom )) - 1 )))), 35 ),
			rtrim ( wiL.adr_1 ),
			rtrim ( wiL.adr_2 ),
			prs.adr_livr_cpl,
			rtrim ( wiL.adr_cp ),
			rtrim ( wiL.adr_ville ),
			IsNull ( IsNull ( rtrim (wiA.num_teld), rtrim (wiA.num_telb )), rtrim (ws.num_port )),
			IsNull ( IsNull ( rtrim (wiA.num_telb), rtrim (wiA.num_teld )), rtrim (ws.num_port )),
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
			'Automate ATLAS/SIMPA2',
			Getdate(),
			Getdate(),
			'WEB',
			prs.id_zone,
			prs.id_bsp,
			prs.dte_ret_pret,
			rtrim ( wiL.cod_civ ),
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
			Case -- [DT398]
				When sysadm.FN_CLE_NUMERIQUE ( 'DT398') > 0 
				  Then 2110 -- [DT398]
				Else prs.info_spb_frn
			End info_spb_frn, 
			prs.id_marq_art_ifr,
			prs.id_modl_art_ifr,
				sysadm.FN_CLE_VAL_E ( 'MAIL_IOS7', @sMailIOS7,
				sysadm.FN_CLE_VAL_E ( 'AUTO_ATLAS', 'OUI' , 
				sysadm.FN_CLE_VAL_E ( 'CODE_VERROU_ORIG', @sCodeVerrou,
				sysadm.FN_CLE_VAL_E ( 'CODE_BTQ_PSM_CENTRALE', @sCodeBtqPSMCentr,
				sysadm.FN_CLE_VAL_E ( 'MAIL_ASSURE', rtrim ( wiA.adr_mail ) , 
				sysadm.FN_CLE_VAL_E ( 'SKU_IFR', @sSkuIFR, 
				sysadm.FN_CLE_VAL_E ( 'MT_PEC', Convert ( VarChar ( 20 ), wdd.val_mt ), rtrim ( prs.info_spb_frn_cplt ), ';' )
				, ';' )
				, ';' )
				, ';' )
				, ';' )
				, ';' )
				, ';' ),
			prs.info_frn_spb_cplt

		From sysadm.pm234_7_automate_prs prs,
			 sysadm.w_detail wdt,
			 sysadm.w_inter wiL,
			 sysadm.w_inter wiA,
			 sysadm.w_sin ws,
			 sysadm.w_div_det wdd

		Where prs.id_sin = 5617666 -- Modèle
		And	  prs.id_seq = 1 -- Modèle
		And	  wdt.id_sin = @adcIdSin
		And   wdt.id_detail = 0
		And   wiL.id_sin = wdt.id_sin 
		And	  wiL.cod_inter = 'L'
		And   wiA.id_sin = wdt.id_sin 
		And	  wiA.cod_inter = 'A'
		And	  ws.id_sin = wdt.id_sin
		And   wdd.id_sin = wdt.id_sin
		And   wdd.id_gti = wdt.id_gti
		And   wdd.id_detail = wdt.id_detail
		And   wdd.nom_zone = 'mt_pec'

		If @@ROWCOUNT = 1 
		  Begin
			Exec sysadm.PS_I_PM234_7_TAG_COURRIER_PEC @adcIdSin, 'WTE594'
		  End 
   End 

-- WTE595
 If @sIdFourModif = 'PSM' And 
	@sTypLivrAtlas = 'RPU' And 
	@sAction = 'A_REPARER' And 
	@iFinTrt = 0
   Begin
   
--   Select comment_frn, * from sysadm.pm234_7_automate_prs where id_sin = 5618494
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
			Left ( ltrim ( rTrim ( wiL.nom )), 35 ),
			Left ( Convert ( Varchar ( 10), wdt.id_sin ) + ' ' + rtrim ( ws.nom ) + ' ' + IsNull ( rtrim ( ws.prenom ), '' ), 35 ),
			rtrim ( wiL.adr_1 ),
			rtrim ( wiL.adr_2 ),
			prs.adr_livr_cpl,
			rtrim ( wiL.adr_cp ),
			rtrim ( wiL.adr_ville ),
			IsNull ( IsNull ( rtrim (wiA.num_teld), rtrim (wiA.num_telb )), rtrim (ws.num_port )),
			IsNull ( IsNull ( rtrim (wiA.num_telb), rtrim (wiA.num_teld )), rtrim (ws.num_port )),
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
			'Automate ATLAS/SIMPA2',
			Getdate(),
			Getdate(),
			'WEB',
			prs.id_zone,
			prs.id_bsp,
			prs.dte_ret_pret,
			rtrim ( wiL.cod_civ ),
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
				sysadm.FN_CLE_VAL_E ( 'MAIL_IOS7', @sMailIOS7,
				sysadm.FN_CLE_VAL_E ( 'AUTO_ATLAS', 'OUI' , 
				sysadm.FN_CLE_VAL_E ( 'CODE_BTQ_PSM_CENTRALE', @sCodeBtqPSMCentr,
				sysadm.FN_CLE_VAL_E ( 'MAIL_ASSURE', rtrim ( wiA.adr_mail ) , 
				sysadm.FN_CLE_VAL_E ( 'CODE_PICK_UP', @sCodeLivraisonAtlas,
				sysadm.FN_CLE_VAL_E ( 'CODE_VERROU_ORIG', @sCodeVerrou,
				sysadm.FN_CLE_VAL_E ( 'SKU_IFR', @sSkuIFR, 
				sysadm.FN_CLE_VAL_E ( 'MT_PEC', Convert ( VarChar ( 20 ), wdd.val_mt ), rtrim ( prs.info_spb_frn_cplt ), ';' )
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
			 sysadm.w_inter wiL,
			 sysadm.w_inter wiA,
			 sysadm.w_sin ws,
			 sysadm.w_div_det wdd

		Where prs.id_sin = 5618849 -- Modèle
		And	  prs.id_seq = 1 -- Modèle
		And	  wdt.id_sin = @adcIdSin
		And   wdt.id_detail = 0
		And   wiL.id_sin = wdt.id_sin 
		And	  wiL.cod_inter = 'L'
		And   wiA.id_sin = wdt.id_sin 
		And	  wiA.cod_inter = 'A'
		And	  ws.id_sin = wdt.id_sin
		And   wdd.id_sin = wdt.id_sin
		And   wdd.id_gti = wdt.id_gti
		And   wdd.id_detail = wdt.id_detail
		And   wdd.nom_zone = 'mt_pec'

		If @@ROWCOUNT = 1 
		  Begin
			Exec sysadm.PS_I_PM234_7_TAG_COURRIER_PEC @adcIdSin, 'WTE595'
		  End 

   End 

-- WTE344
 If @sIdFourModif = 'PSM' And 
	@sTypLivrAtlas = 'PXM' And 
	@sAction = 'A_REPARER' And 	
	@iFinTrt = 0
   Begin

		Set @iFinTrt = 1

-- Select comment_frn, * from sysadm.pm234_7_automate_prs where id_sin = 5618494

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
			ws.nom,
			ws.prenom,
			rtrim ( wiA.adr_1 ),
			rtrim ( wiA.adr_2 ),
			prs.adr_livr_cpl,
			rtrim ( wiA.adr_cp ),
			rtrim ( wiA.adr_ville ),
			IsNull ( IsNull ( rtrim (wiA.num_teld), rtrim (wiA.num_telb )), rtrim (ws.num_port )),
			IsNull ( IsNull ( rtrim (wiA.num_telb), rtrim (wiA.num_teld )), rtrim (ws.num_port )),
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
			'Automate ATLAS/SIMPA2',
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
			Case -- [DT398]
				When sysadm.FN_CLE_NUMERIQUE ( 'DT398') > 0 
				  Then 2110 -- [DT398]
				Else prs.info_spb_frn
			End info_spb_frn, 
			prs.id_marq_art_ifr,
			prs.id_modl_art_ifr,
				sysadm.FN_CLE_VAL_E ( 'MAIL_IOS7', @sMailIOS7,
				sysadm.FN_CLE_VAL_E ( 'AUTO_ATLAS', 'OUI' , 
				sysadm.FN_CLE_VAL_E ( 'CODE_BTQ_PSM_PROXIMITE', @sCodeLivraisonAtlas,				
				sysadm.FN_CLE_VAL_E ( 'CODE_VERROU_ORIG', @sCodeVerrou,
				sysadm.FN_CLE_VAL_E ( 'CODE_BTQ_PSM_CENTRALE', @sCodeBtqPSMCentr,
				sysadm.FN_CLE_VAL_E ( 'SKU_IFR', @sSkuIFR, 
				sysadm.FN_CLE_VAL_E ( 'MT_PEC', Convert ( VarChar ( 20 ), wdd.val_mt ), rtrim ( prs.info_spb_frn_cplt ), ';' )
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

		Where prs.id_sin = 5618494 -- Modèle
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

		If @@ROWCOUNT = 1 
		  Begin
			Exec sysadm.PS_I_PM234_7_TAG_COURRIER_PEC @adcIdSin, 'WTE344'
		  End 

   End 

-- WTE594
 If @sIdFourModif = 'PSM' And 
	@sTypLivrAtlas = 'BPP' And 
	@sAction = 'A_DESOXYDER' And 	
	@iFinTrt = 0
   Begin

		If @sCodeBtqPSMCentr = '' 
		 Begin
			Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Code PSM Central. non renseigné', 'Le code boutique PSM de centralisation n''a pas été transmis par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
			Return -1				
		 End 		

		Set @iFinTrt = 1

-- Select comment_frn, * from sysadm.pm234_7_automate_prs where id_sin = 5618145

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
			Left ( ltrim ( rTrim ( Right ( rtrim ( wiL.nom ) , Len( rtrim ( wiL.nom ) ) - ( CharIndex ( '[#]', rtrim ( wiL.nom ) ) + 2 )))), 35 ),
			Left ( ltrim ( rTrim ( Left ( rtrim ( wiL.nom ), (CharIndex ( '[#]', rtrim ( wiL.nom )) - 1 )))), 35 ),
			rtrim ( wiL.adr_1 ),
			rtrim ( wiL.adr_2 ),
			prs.adr_livr_cpl,
			rtrim ( wiL.adr_cp ),
			rtrim ( wiL.adr_ville ),
			IsNull ( IsNull ( rtrim (wiA.num_teld), rtrim (wiA.num_telb )), rtrim (ws.num_port )),
			IsNull ( IsNull ( rtrim (wiA.num_telb), rtrim (wiA.num_teld )), rtrim (ws.num_port )),
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
			'Automate ATLAS/SIMPA2',
			Getdate(),
			Getdate(),
			'WEB',
			prs.id_zone,
			prs.id_bsp,
			prs.dte_ret_pret,
			rtrim ( wiL.cod_civ ),
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
				sysadm.FN_CLE_VAL_E ( 'MAIL_IOS7', @sMailIOS7,
				sysadm.FN_CLE_VAL_E ( 'AUTO_ATLAS', 'OUI' , 
				sysadm.FN_CLE_VAL_E ( 'CODE_VERROU_ORIG', @sCodeVerrou,
				sysadm.FN_CLE_VAL_E ( 'CODE_BTQ_PSM_CENTRALE', @sCodeBtqPSMCentr,
				sysadm.FN_CLE_VAL_E ( 'SKU_IFR', @sSkuIFR, 
				sysadm.FN_CLE_VAL_E ( 'MT_PEC', Convert ( VarChar ( 20 ), wdd.val_mt ), rtrim ( prs.info_spb_frn_cplt ), ';' )
				, ';' )
				, ';' )
				, ';' )
				, ';' )
				, ';' ),
			prs.info_frn_spb_cplt

		From sysadm.pm234_7_automate_prs prs,
			 sysadm.w_detail wdt,
			 sysadm.w_inter wiL,
			 sysadm.w_inter wiA,
			 sysadm.w_sin ws,
			 sysadm.w_div_det wdd

		Where prs.id_sin = 5618145 -- Modèle
		And	  prs.id_seq = 1 -- Modèle
		And	  wdt.id_sin = @adcIdSin
		And   wdt.id_detail = 0
		And   wiL.id_sin = wdt.id_sin 
		And	  wiL.cod_inter = 'L'
		And   wiA.id_sin = wdt.id_sin 
		And	  wiA.cod_inter = 'A'
		And	  ws.id_sin = wdt.id_sin
		And   wdd.id_sin = wdt.id_sin
		And   wdd.id_gti = wdt.id_gti
		And   wdd.id_detail = wdt.id_detail
		And   wdd.nom_zone = 'mt_pec'

		If @@ROWCOUNT = 1 
		  Begin
			Exec sysadm.PS_I_PM234_7_TAG_COURRIER_PEC @adcIdSin, 'WTE594'
		  End 

   End 

-- WTE595
    If @sIdFourModif = 'PSM' And 
	@sTypLivrAtlas = 'RPU' And 
	@sAction = 'A_DESOXYDER' And 
	@iFinTrt = 0
   Begin
   
-- Select comment_frn, * from sysadm.pm234_7_automate_prs where id_sin = 5618083

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
			Left ( ltrim ( rTrim ( wiL.nom )), 35 ),
			Left ( Convert ( Varchar ( 10), wdt.id_sin ) + ' ' + rtrim ( ws.nom ) + ' ' + IsNull ( rtrim ( ws.prenom ), '' ), 35 ),
			rtrim ( wiL.adr_1 ),
			rtrim ( wiL.adr_2 ),
			prs.adr_livr_cpl,
			rtrim ( wiL.adr_cp ),
			rtrim ( wiL.adr_ville ),
			IsNull ( IsNull ( rtrim (wiA.num_teld), rtrim (wiA.num_telb )), rtrim (ws.num_port )),
			IsNull ( IsNull ( rtrim (wiA.num_telb), rtrim (wiA.num_teld )), rtrim (ws.num_port )),
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
			'Automate ATLAS/SIMPA2',
			Getdate(),
			Getdate(),
			'WEB',
			prs.id_zone,
			prs.id_bsp,
			prs.dte_ret_pret,
			rtrim ( wiL.cod_civ ),
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
				sysadm.FN_CLE_VAL_E ( 'MAIL_IOS7', @sMailIOS7,
				sysadm.FN_CLE_VAL_E ( 'AUTO_ATLAS', 'OUI' , 
				sysadm.FN_CLE_VAL_E ( 'CODE_BTQ_PSM_CENTRALE', @sCodeBtqPSMCentr,
				sysadm.FN_CLE_VAL_E ( 'MAIL_ASSURE', rtrim ( wiA.adr_mail ) , 
				sysadm.FN_CLE_VAL_E ( 'CODE_PICK_UP', @sCodeLivraisonAtlas,
				sysadm.FN_CLE_VAL_E ( 'CODE_VERROU_ORIG', @sCodeVerrou,
				sysadm.FN_CLE_VAL_E ( 'SKU_IFR', @sSkuIFR, 
				sysadm.FN_CLE_VAL_E ( 'MT_PEC', Convert ( VarChar ( 20 ), wdd.val_mt ), rtrim ( prs.info_spb_frn_cplt ), ';' )
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
			 sysadm.w_inter wiL,
			 sysadm.w_inter wiA,
			 sysadm.w_sin ws,
			 sysadm.w_div_det wdd

		Where prs.id_sin = 5618083 -- Modèle
		And	  prs.id_seq = 1 -- Modèle
		And	  wdt.id_sin = @adcIdSin
		And   wdt.id_detail = 0
		And   wiL.id_sin = wdt.id_sin 
		And	  wiL.cod_inter = 'L'
		And   wiA.id_sin = wdt.id_sin 
		And	  wiA.cod_inter = 'A'
		And	  ws.id_sin = wdt.id_sin
		And   wdd.id_sin = wdt.id_sin
		And   wdd.id_gti = wdt.id_gti
		And   wdd.id_detail = wdt.id_detail
		And   wdd.nom_zone = 'mt_pec'

		If @@ROWCOUNT = 1 
		  Begin
			Exec sysadm.PS_I_PM234_7_TAG_COURRIER_PEC @adcIdSin, 'WTE595'
		  End 
   End 

 --[DT288]
 -- WDE188  -- BPP COR
 If @sIdFourModif = 'COR' And 
	@sTypLivrAtlas = 'BPP' And 
	@sAction = 'A_REPARER' And 
	@iFinTrt = 0
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
			Left ( ltrim ( rTrim ( Right ( rtrim ( wiL.nom ) , Len( rtrim ( wiL.nom ) ) - ( CharIndex ( '[#]', rtrim ( wiL.nom ) ) + 2 )))), 35 ),
			Left ( ltrim ( rTrim ( Left ( rtrim ( wiL.nom ), (CharIndex ( '[#]', rtrim ( wiL.nom )) - 1 )))), 35 ),
			rtrim ( wiL.adr_1 ),
			rtrim ( wiL.adr_2 ),
			prs.adr_livr_cpl,
			rtrim ( wiL.adr_cp ),
			rtrim ( wiL.adr_ville ),
			IsNull ( IsNull ( rtrim (wiA.num_teld), rtrim (wiA.num_telb )), rtrim (ws.num_port )),
			IsNull ( IsNull ( rtrim (wiA.num_telb), rtrim (wiA.num_teld )), rtrim (ws.num_port )),
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
			'Automate ATLAS/SIMPA2',
			Getdate(),
			Getdate(),
			'WEB',
			prs.id_zone,
			prs.id_bsp,
			prs.dte_ret_pret,
			rtrim ( wiL.cod_civ ),
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
				sysadm.FN_CLE_VAL_E ( 'MAIL_IOS7', @sMailIOS7,
				sysadm.FN_CLE_VAL_E ( 'AUTO_ATLAS', 'OUI' , 
				sysadm.FN_CLE_VAL_E ( 'MAIL_ASSURE', rtrim ( wiA.adr_mail ) , 
				sysadm.FN_CLE_VAL_E ( 'CODE_VERROU_ORIG', @sCodeVerrou, rtrim ( prs.info_spb_frn_cplt ), ';' )
				, ';' )
				, ';' )
				, ';' ),
			prs.info_frn_spb_cplt

		From sysadm.pm234_7_automate_prs prs,
			 sysadm.w_detail wdt,
			 sysadm.w_inter wiL,
			 sysadm.w_inter wiA,
			 sysadm.w_sin ws,
			 sysadm.w_div_det wdd

		Where prs.id_sin = 5950735 -- Modèle
		And	  prs.id_seq = 1 -- Modèle
		And	  wdt.id_sin = @adcIdSin
		And   wdt.id_detail = 0
		And   wiL.id_sin = wdt.id_sin 
		And	  wiL.cod_inter = 'L'
		And   wiA.id_sin = wdt.id_sin 
		And	  wiA.cod_inter = 'A'
		And	  ws.id_sin = wdt.id_sin
		And   wdd.id_sin = wdt.id_sin
		And   wdd.id_gti = wdt.id_gti
		And   wdd.id_detail = wdt.id_detail
		And   wdd.nom_zone = 'mt_pec'

		If @@ROWCOUNT = 1 
		  Begin
			Exec sysadm.PS_I_PM234_7_TAG_COURRIER_PEC @adcIdSin, 'WDE188'
		  End 

   End 

-- [DT288]
-- WDE189 -- RPU COR
 If @sIdFourModif = 'COR' And 
	@sTypLivrAtlas = 'RPU' And 
	@sAction = 'A_REPARER' And 
	@iFinTrt = 0
   Begin
   
--   Select comment_frn, * from sysadm.pm234_7_automate_prs where id_sin = 5616659
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
			Left ( ltrim ( rTrim ( wiL.nom )), 35 ),
			Left ( Convert ( Varchar ( 10), wdt.id_sin ) + ' ' + rtrim ( ws.nom ) + ' ' + IsNull ( rtrim ( ws.prenom ), '' ), 35 ),
			rtrim ( wiL.adr_1 ),
			rtrim ( wiL.adr_2 ),
			prs.adr_livr_cpl,
			rtrim ( wiL.adr_cp ),
			rtrim ( wiL.adr_ville ),
			IsNull ( IsNull ( rtrim (wiA.num_teld), rtrim (wiA.num_telb )), rtrim (ws.num_port )),
			IsNull ( IsNull ( rtrim (wiA.num_telb), rtrim (wiA.num_teld )), rtrim (ws.num_port )),
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
			'Automate ATLAS/SIMPA2',
			Getdate(),
			Getdate(),
			'WEB',
			prs.id_zone,
			prs.id_bsp,
			prs.dte_ret_pret,
			rtrim ( wiL.cod_civ ),
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
				sysadm.FN_CLE_VAL_E ( 'MAIL_IOS7', @sMailIOS7,
				sysadm.FN_CLE_VAL_E ( 'AUTO_ATLAS', 'OUI' , 
				sysadm.FN_CLE_VAL_E ( 'CODE_PICK_UP', @sCodeLivraisonAtlas,
				sysadm.FN_CLE_VAL_E ( 'MAIL_ASSURE', rtrim ( wiA.adr_mail ) , 
				sysadm.FN_CLE_VAL_E ( 'CODE_VERROU_ORIG', @sCodeVerrou, rtrim ( prs.info_spb_frn_cplt ), ';' )
				, ';' )
				, ';' )
				, ';' )
				, ';' ),
			prs.info_frn_spb_cplt

		From sysadm.pm234_7_automate_prs prs,
			 sysadm.w_detail wdt,
			 sysadm.w_inter wiL,
			 sysadm.w_inter wiA,
			 sysadm.w_sin ws,
			 sysadm.w_div_det wdd

		Where prs.id_sin = 5950740 -- Modèle
		And	  prs.id_seq = 1 -- Modèle
		And	  wdt.id_sin = @adcIdSin
		And   wdt.id_detail = 0
		And   wiL.id_sin = wdt.id_sin 
		And	  wiL.cod_inter = 'L'
		And   wiA.id_sin = wdt.id_sin 
		And	  wiA.cod_inter = 'A'
		And	  ws.id_sin = wdt.id_sin
		And   wdd.id_sin = wdt.id_sin
		And   wdd.id_gti = wdt.id_gti
		And   wdd.id_detail = wdt.id_detail
		And   wdd.nom_zone = 'mt_pec'


		If @@ROWCOUNT = 1 
		  Begin
			Exec sysadm.PS_I_PM234_7_TAG_COURRIER_PEC @adcIdSin, 'WDE189'
		  End 

   End 


If @iFinTrt = 0
	Begin
		Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Pas de cas prestation détectée', 'Le système n''a pas pu détecter de cas de prestation à envoyer en fonction des données transmises par ATLAS. Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
		Return -1				
	End 
Go

--------------------------------------------------------------------
-- Procédure            :       sysadm.PS_I_PM234_7_CTRL_APRES_VALIDATION
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
-- JFF      14/12/2017   [DF005-1-LOT2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_CTRL_APRES_VALIDATION' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_CTRL_APRES_VALIDATION
GO

CREATE procedure sysadm.PS_I_PM234_7_CTRL_APRES_VALIDATION
	@adcIdSin   Decimal (10)
AS

Exec sysadm.PS_CORRIGE_CPT_VALIDE @adcIdSin

-- [DF005-1-LOT2]
If Not Exists ( Select top 1 1 From sysadm.w_sin where id_sin = @adcIdSin ) Return 1

If ( ( Select count ( * ) From sysadm.w_div_sin Where id_sin = @adcIdSin ) + 
     ( Select count ( * ) From sysadm.w_div_sin Where id_sin = @adcIdSin and cpt_valide > 0 ) +
     ( Select count ( * ) From sysadm.div_sin Where id_sin = @adcIdSin ) ) / 3 
	 <>
	 ( Select count ( * ) From sysadm.w_div_sin Where id_sin = @adcIdSin )
	 Begin
		Return -1
	 End 

If ( ( Select count ( * ) From sysadm.w_div_det Where id_sin = @adcIdSin ) + 
     ( Select count ( * ) From sysadm.w_div_det Where id_sin = @adcIdSin and cpt_valide > 0 ) +
     ( Select count ( * ) From sysadm.div_det Where id_sin = @adcIdSin ) ) / 3 
	 <>
	 ( Select count ( * ) From sysadm.w_div_det Where id_sin = @adcIdSin )
	 Begin
		Return -1
	 End 

If ( ( Select count ( * ) From sysadm.w_detail Where id_sin = @adcIdSin ) + 
     ( Select count ( * ) From sysadm.w_detail Where id_sin = @adcIdSin and cpt_valide > 0 ) +
     ( Select count ( * ) From sysadm.detail Where id_sin = @adcIdSin ) ) / 3 
	 <>
	 ( Select count ( * ) From sysadm.w_detail Where id_sin = @adcIdSin )
	 Begin
		Return -1
	 End 

If ( ( Select count ( * ) From sysadm.w_inter Where id_sin = @adcIdSin ) + 
     ( Select count ( * ) From sysadm.w_inter Where id_sin = @adcIdSin and cpt_valide > 0 ) +
     ( Select count ( * ) From sysadm.inter Where id_sin = @adcIdSin ) ) / 3 
	 <>
	 ( Select count ( * ) From sysadm.w_inter Where id_sin = @adcIdSin )
	 Begin
		Return -1
	 End 

If ( ( Select count ( * ) From sysadm.w_gar_sin Where id_sin = @adcIdSin ) + 
     ( Select count ( * ) From sysadm.w_gar_sin Where id_sin = @adcIdSin and cpt_valide > 0 ) +
     ( Select count ( * ) From sysadm.gar_sin Where id_sin = @adcIdSin ) ) / 3 
	 <>
	 ( Select count ( * ) From sysadm.w_gar_sin Where id_sin = @adcIdSin )
	 Begin
		Return -1
	 End 

If ( ( Select count ( * ) From sysadm.w_commande Where id_sin = @adcIdSin ) + 
     ( Select count ( * ) From sysadm.w_commande Where id_sin = @adcIdSin and cpt_valide > 0 ) +
     ( Select count ( * ) From sysadm.commande Where id_sin = @adcIdSin ) ) / 3 
	 <>
	 ( Select count ( * ) From sysadm.w_commande Where id_sin = @adcIdSin )
	 Begin
		Return -1
	 End 

If ( ( Select count ( * ) From sysadm.w_sin Where id_sin = @adcIdSin ) + 
     ( Select count ( * ) From sysadm.w_sin Where id_sin = @adcIdSin and cpt_valide > 0 ) +
     ( Select count ( * ) From sysadm.sinistre Where id_sin = @adcIdSin ) ) / 3 
	 <>
	 ( Select count ( * ) From sysadm.w_sin Where id_sin = @adcIdSin )
	 Begin
		Return -1
	 End 


Return 1

Go


--------------------------------------------------------------------
-- Procédure            :       sysadm.PS_I_PM234_7_ETAT_VALIDATION
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
-- JFF      14/12/2017   [DF005-1-LOT2]
-- JFF      15/06/2018   [DF005-1-LOT3]
-- JFF      22/10/2019   [PI087_PM473_2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_ETAT_VALIDATION_V02' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_ETAT_VALIDATION_V02
GO

CREATE procedure sysadm.PS_I_PM234_7_ETAT_VALIDATION_V02
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
			Set @sMsgTemp = 'Problème lors de la validation automatique, code (' + Convert ( VarChar ( 10 ), @iRet ) + '). Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
			Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Problème validation auto 1', @sMsgTemp 
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

-- Contrôle ICI
	Exec @iCtrle = sysadm.PS_I_PM234_7_CTRL_APRES_VALIDATION @adcIdSin

	If @iCtrle < 0 
	  Begin
		Delete sysadm.commande Where id_sin = @adcIdSin
		Delete sysadm.w_commande Where id_sin = @adcIdSin


		Set @sMsgTemp = 'Problème lors de la validation automatique, (nbre lignes/cpt_valide). Automatisation du process Orange V3 via ATLAS/SIMPA2 impossible donc.'
		Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Problème validation auto 2', @sMsgTemp 

		Return -1

	  End 
	
	If @iCtrle > 0 
	  Begin

	  Set @sMsgSucces = 'Succès automatisation ATLAS'

	  -- [DF005-1-LOT2]
		If @iCasRefus > 0 
			Begin
				Set @sMsgSucces = 'Succès automatisation ATLAS (Refus)'
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
			'pm234_7_auto_ok',
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
		'pm234_7_auto_ok',
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
-- Procédure            :       PS_I_PM234_7_REJET
-- Auteur               :       Fabry JF
-- Date                 :       03/08/2016
-- Libellé              :
-- Commentaires         :      [PS_REJET]
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-- 22/11/2016	JFF		[MANTIS22772]
-- JFF      14/12/2017   [DF005-1-LOT2]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_REJET' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_REJET
GO

CREATE procedure sysadm.PS_I_PM234_7_REJET
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

	-- [DF005-1-LOT2]
	If NOT sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
	Begin
		Set @iPresenceW = 1
		Set @iPresenceS = 0
	End 

	-- [DF005-1-LOT2]
	If sysadm.FN_CLE_NUMERIQUE ( 'DF005-2') > 0 
	Begin
		If Exists ( Select top 1 1 From sysadm.w_sin where id_sin = @adcIdSin )
			Begin
				Set @iPresenceW = 1
			End 

		If Exists ( Select top 1 1 From sysadm.sinistre where id_sin = @adcIdSin )
			Begin
				Set @iPresenceS = 1
			End 
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
			'rejet_pm234_7_cac',
			'Rejet automatisation ATLAS',
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
		'rejet_pm234_7_msg',
		'Rejet automatisation ATLAS (Msg)',
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
		'dcnx_decla_atlas',
		'Déconnexion définitive décla Atlas',
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
			'rejet_pm234_7_cac',
			'Rejet automatisation ATLAS',
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
		'rejet_pm234_7_msg',
		'Rejet automatisation ATLAS (Msg)',
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
		'dcnx_decla_atlas',
		'Déconnexion définitive décla Atlas',
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
		EXEC SHERPA_PRO.sysadm.[Atlas_Orange_Get_Oper_V101]  @iIdProd ,@sOper OUTPUT
		If @sOper is null Set @sOper = 'WEB'
		Set @sOper = rtrim ( ltrim ( @sOper )) 

		EXEC SHERPA_PRO.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @adcIdSin, 2, @asMsg2, @sOper , @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'E'
	END
	ELSE
	BEGIN
		-- [MANTIS22772]
		EXEC SHERPA_SIM.sysadm.[Atlas_Orange_Get_Oper_V101]  @iIdProd ,@sOper OUTPUT
		If @sOper is null Set @sOper = 'WEB'
		Set @sOper = rtrim ( ltrim ( @sOper )) 

		EXEC SHERPA_SIM.sysadm.PS_I04_CONTACT_TRAVAIL_V01 @adcIdSin, 2, @asMsg2, @sOper, @sErr OUTPUT , @iIdCt OUTPUT , NULL, 'E'
	END


Go


--------------------------------------------------------------------
-- Procédure            :       PS_I_PM234_7_TAG_COURRIER_PEC
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
-- JFF      26/04/2023   [RS5045_REF_MATP]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_TAG_COURRIER_PEC' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_TAG_COURRIER_PEC
GO

CREATE procedure sysadm.PS_I_PM234_7_TAG_COURRIER_PEC
	@adcIdSin   Decimal (10),
	@asCodeCourrier	VarChar (10)
AS

Declare
  @iIdXml integer,  -- [RS5045_REF_MATP]
  @dcIdInter Decimal ( 2 ), -- [RS5045_REF_MATP]
  @sCodeMaquette VarChar ( 255 ), -- [RS5045_REF_MATP]
  @sErrOutPut VarChar ( 255 ), -- [RS5045_REF_MATP]
  @sXMLVar     	VarChar ( max ), -- [RS5045_REF_MATP]
  @sTypMail   VarChar ( 6 ), -- [RS5045_REF_MATP]
  @sIdAppli   VarChar ( 6 ), -- [RS5045_REF_MATP]
  @iIdProd    Integer,  -- [RS5045_REF_MATP]
  @iIdSin     Integer,  -- [RS5045_REF_MATP]
  @iIdEts     Integer,  -- [RS5045_REF_MATP]
  @iOptionDP  Integer,
  @dcIdProd     Decimal (7), 
  @dcIdEts 	Decimal (7), 
  @sLibProd     VarChar (255),
  @sNumProd     VarChar (20),
  @sCiv		VarChar (20), 
  @sNom		VarChar ( 71 ),
  @sMailFrom	VarChar (128), 
  @sMailSend	VarChar (128), 
  @sMailCc	VarChar (128),
  @sAltQuarant  VarChar (1),
  @sBoiteMail   VarChar (35),
  @iRet  Integer,
  @sTypApp VarChar ( 10 ),
  @sAdrMail VarChar ( 255 ),
  @sNomLivraison VarChar ( 71 ), 
  @sAdresse1Livraison VarChar ( 50 ),
  @sAdresse2Livraison VarChar ( 50 ),
  @sCpVilleLivraison  VarChar ( 70 ),
  @sAdrMailCC VarChar ( 255 ),
  @sMailObjet	VarChar ( 255 ),
  @sMailBody	VarChar ( 7000 )

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 
Declare @sAdrMailErr VarChar ( 150 )

Set  @sIdAppli = 'SIMPA2'
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

Set @iIdSin  = Convert ( integer, @adcIdSin )
Set @iIdProd = Convert ( integer, @dcIdProd )
Set @iIdEts  = Convert ( integer, @dcIdEts )
Set @asCodeCourrier = rTrim ( lTrim ( @asCodeCourrier ))
Set @sTypMail = @asCodeCourrier 

Set @sMailObjet = 'Corps de l''Objet construit par KSL'
Set @sMailBody  = 'Corps du mail construit par KSL'

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


-- Lecture des variables de sysadm.PS_S_PM234_7_COUR_PEC
Set @sTypApp = 
	Case When Exists (select * from sysadm.w_commande w where w.id_sin=@adcIdSin and w.id_typ_art='PRS'	and w.cod_etat <> 'ANN') Then 'repa' 
			Else 'rempl' 
	End 

Set @sAdrMail = 
	Case -- [DT346]
		When Exists ( 
				Select Top 1 1 
				From   sysadm.w_div_sin ds,
					   sysadm.det_pro dp,
					   sysadm.w_sin s
				Where  ds.id_sin = @adcIdSin
				And	   ds.nom_zone = 'client_vip'
				And	   ds.val_car = 'VIPPAR'
				And	   s.id_sin = ds.id_sin 
				And	   dp.id_prod = s.id_prod
				And    dp.id_code_dp = 272
			)	Then 'laura.naulot@orange.com,desk@parnasse.fr'
		Else null
	End 

Set @sNomLivraison = 
	Case 
		When @asCodeCourrier ='WTE344' -- PXM
			Then ( 
				Select	Left ( IsNull ( rtrim( b.adr_nom ), ''), 100 )
				From sysadm.boutique b
				Where b.id_prod = 9133
				And   b.cod_mag = 
						(
							Select Convert ( VarChar (20), Convert ( integer, rtrim ( ltrim ( replace ( dsCodeLivr.val_car, '#', '')))))
							From sysadm.div_sin dsCodeLivr
							Where dsCodeLivr.id_sin = @adcIdSin
							And	  dsCodeLivr.nom_zone = 'code_livraison_atlas'
						)
				And	  b.region = 'FRN=PSM'

				)
		When @asCodeCourrier in ( 'WTE595', 'WTE598', 'WDE188', 'WDE189' ) -- RPU
			Then ( 
				Select Top 1 rtrim ( ltrim ( Replace ( i.nom, '[#]', ' ')))
				From sysadm.inter i
				Where i.id_sin = @adcIdSin
				And   i.cod_inter = 'L'
				)
	End 

Set @sAdresse1Livraison = 
	Case 
		When @asCodeCourrier = 'WTE344' -- PXM
			Then ( 
				Select	Left ( IsNull ( rtrim( b.adr_1 ), ''), 100 )
				From sysadm.boutique b
				Where b.id_prod = 9133
				And   b.cod_mag  = 
						(
							Select Convert ( VarChar (20), Convert ( integer, rtrim ( ltrim ( replace ( dsCodeLivr.val_car, '#', '')))))
							From sysadm.div_sin dsCodeLivr
							Where dsCodeLivr.id_sin = @adcIdSin
							And	  dsCodeLivr.nom_zone = 'code_livraison_atlas'
						)
				And	  b.region = 'FRN=PSM'

				)
		When @asCodeCourrier in ( 'WTE595', 'WTE598', 'WDE188', 'WDE189' ) -- RPU
			Then ( 
				Select Top 1 rtrim ( ltrim ( i.adr_1 ))
				From sysadm.inter i
				Where i.id_sin = @adcIdSin
				And   i.cod_inter = 'L'
				)
	End

Set @sAdresse2Livraison = 
	Case 
		When @asCodeCourrier = 'WTE344' -- PXM
			Then ( 
				Select	Left ( IsNull ( rtrim( b.adr_2 ), ''), 100 )
				From sysadm.boutique b
				Where b.id_prod = 9133
				And   b.cod_mag  = 
						(
							Select Convert ( VarChar (20), Convert ( integer, rtrim ( ltrim ( replace ( dsCodeLivr.val_car, '#', '')))))
							From sysadm.div_sin dsCodeLivr
							Where dsCodeLivr.id_sin = @adcIdSin
							And	  dsCodeLivr.nom_zone = 'code_livraison_atlas'
						)
				And	  b.region = 'FRN=PSM'

				)
		When @asCodeCourrier in ( 'WTE595', 'WTE598', 'WDE188', 'WDE189' ) -- RPU
			Then ( 
				Select Top 1 rtrim ( ltrim ( i.adr_2 ))
				From sysadm.inter i
				Where i.id_sin = @adcIdSin
				And   i.cod_inter = 'L'
				)
	End

Set @sCpVilleLivraison = 
	Case 
		When @asCodeCourrier = 'WTE344'  -- PXM
			Then ( 
				Select	Left ( IsNull ( rtrim( b.adr_cp ), '') + ' ' + IsNull ( rtrim( b.adr_ville ), ''), 100 )
				From sysadm.boutique b
				Where b.id_prod = 9133
				And   b.cod_mag  = 
						(
							Select Convert ( VarChar (20), Convert ( integer, rtrim ( ltrim ( replace ( dsCodeLivr.val_car, '#', '')))))
							From sysadm.div_sin dsCodeLivr
							Where dsCodeLivr.id_sin = @adcIdSin
							And	  dsCodeLivr.nom_zone = 'code_livraison_atlas'
						)
				And	  b.region = 'FRN=PSM'

				)
		When @asCodeCourrier in ( 'WTE595', 'WTE598', 'WDE188', 'WDE189' ) -- RPU
			Then ( 
				Select Top 1 rtrim ( ltrim ( i.adr_cp )) + ' ' + rtrim ( ltrim ( i.adr_ville ))
				From sysadm.inter i
				Where i.id_sin = @adcIdSin
				And   i.cod_inter = 'L'
				)
	End 

Set @sAdrMailCC = 
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
			   sysadm.det_pro dp,
			   sysadm.sinistre s
		Where  ds.id_sin = @adcIdSin
		And	   ds.nom_zone = 'client_vip'
		And	   s.id_sin = ds.id_sin 
		And	   dp.id_prod = s.id_prod
		And    dp.id_code_dp = 272
	) -- [VDOC17642][DF006]



-- [RS5045_REF_MATP]
If sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') > 0 
 Begin
	If @@servername = master.dbo.SPB_FN_ServerName ('PRO')

		Begin  -- TRACE_MAIL_PRO : Début écriture
			-- Appel Obligatoire pour déclarer le XML
			Exec @iIdXml = TRACE_MAIL_PRO.sysadm.PS_RS5045_I_CREATION_CHAINE_DATA_XML_KSL_A_VIDE
			Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER_SIMPA2 @adcIdSin, @dcIdInter, @iIdXml
			Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_OPTIMISER_CHAINE_DATA_XML_KSL @iIdXml, 'OUI', 'OUI', 'OUI'
			Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_S_RECUPERER_CODE_MAQUETTE_KSL_A_PARTIR_TYP_MAIL @sTypMail, @sCodeMaquette OutPut
			
			-- Ajout personnalisé du client appelant le système 
			Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'code_maquette', @sCodeMaquette
			Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'type_appareil', @sTypApp
			If @sAdrMail is not null Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'adr_mail', @sAdrMail
			Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'nom_livraison', @sNomLivraison
			Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'adresse1_livraison', @sAdresse1Livraison
			Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'adresse2_livraison', @sAdresse2Livraison
			Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'cp_ville_livraison', @sCpVilleLivraison 
			Exec TRACE_MAIL_PRO.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'adr_mail_cc', @sAdrMailCC 
			

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
				@sErrOutPut OutPut	
		End 
	Else
		Begin  -- TRACE_MAIL_TRT : Début écriture
			-- Appel Obligatoire pour déclarer le XML
			Exec @iIdXml = TRACE_MAIL_TRT.sysadm.PS_RS5045_I_CREATION_CHAINE_DATA_XML_KSL_A_VIDE
			Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_I_PRE_ARMEMENT_CHAINE_DATA_XML_KSL_AVEC_DATA_SIN_ET_INTER_SIMPA2 @adcIdSin, @dcIdInter, @iIdXml
			Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_OPTIMISER_CHAINE_DATA_XML_KSL @iIdXml, 'OUI', 'OUI', 'OUI'
			Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_S_RECUPERER_CODE_MAQUETTE_KSL_A_PARTIR_TYP_MAIL @sTypMail, @sCodeMaquette OutPut

			-- Ajout personnalisé du client appelant le système
			Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'code_maquette', @sCodeMaquette
			Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'type_appareil', @sTypApp
			If @sAdrMail is not null Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'adr_mail', @sAdrMail
			Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'nom_livraison', @sNomLivraison
			Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'adresse1_livraison', @sAdresse1Livraison
			Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'adresse2_livraison', @sAdresse2Livraison
			Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'cp_ville_livraison', @sCpVilleLivraison 
			Exec TRACE_MAIL_TRT.sysadm.PS_RS5045_U_ARMER_UNE_VALEUR_DANS_CHAINE_DATA_XML_KSL @iIdXml, 'adr_mail_cc', @sAdrMailCC 

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
				@sErrOutPut OutPut		
		End 

		-- dte_cour_pec_envksl_pm234_7
		If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
		  Begin
			If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_cour_pec_envksl_pm234_7')
			 Begin
			   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_cour_pec_envksl_pm234_7'
			 End 
			Else
			 Begin	 
			   Insert into sysadm.w_div_sin values ( @adcIdSin, 'dte_cour_pec_envksl_pm234_7', 'Date envoi cour. PEC KSL PM234-7', '-1', 'N', 'D', 'N', 'N', 770, null, null, GETDATE(), null, 1, getdate(), getdate(), 'EDS' ) 
			 End
		  End


		If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
		  Begin
			If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_cour_pec_envksl_pm234_7')
			 Begin
			   Update sysadm.div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_cour_pec_envksl_pm234_7'
			 End 
			Else
			 Begin	 
			   Insert into sysadm.div_sin values ( @adcIdSin, 'dte_cour_pec_envksl_pm234_7', 'Date envoi cour. PEC KSL PM234-7', '-1', 'N', 'D', 'N', 'N', 770, null, null, GETDATE(), null, getdate(), getdate(), 'EDS', getdate(), 'EDS' ) 
			 End
		  End

		Set @sMess = 'Suite automatisation de la déclaration via ATLAS/SIMPA2 (PM234-7), le courrier de prise en charge a été envoyé par KSL.'

		IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO'
		BEGIN
			Exec  SHERPA_PRO.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'EDS', 300, @iIdCt OUTPUT, 760
		END
		ELSE
		BEGIN
			Exec  SHERPA_SIM.sysadm.PS_I01_CONTACT_V01 	-1, 2, 4, 'C', @adcIdSin, 2, @sMess,	'EDS', 300, @iIdCt OUTPUT, 760
		END


 End 
Else 
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
	'cour_pec_a_envksl_pm234_7',
	'Cour. PEC à envoyer par KSL PM234-7',
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
 End
Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM234_7_COUR_PEC
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
-- JFF      22/09/2016   [PM234-7][M21970]
-- JFF		26/04/2017   [DT288]
-- JFF      03/08/2017   [DF006]
-- JFF      12/02/2018   [DT346]
-- JFF      06/11/2018   [PM451-1]
-- JFF      26/04/2023   [RS5045_REF_MATP]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM234_7_COUR_PEC' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM234_7_COUR_PEC 
GO

CREATE procedure sysadm.PS_S_PM234_7_COUR_PEC
AS

-- [RS5045_REF_MATP]
If sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') > 0 
 Begin
	-- Fin de cette méthode
	Return
 End 

SET NOCOUNT ON

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
	Case 	When pers.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
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
	IsNull ( rtrim ( ds.val_car ), '') as code_maquette,
	Case -- [DT346]
		When Exists ( 
				Select Top 1 1 
				From   sysadm.div_sin ds,
					   sysadm.det_pro dp 
				Where  ds.id_sin = s.id_sin
				And	   ds.nom_zone = 'client_vip'
				And	   ds.val_car = 'VIPPAR'
				And	   s.id_sin = ds.id_sin 
				And	   dp.id_prod = s.id_prod
				And    dp.id_code_dp = 272
			)	Then 'laura.naulot@orange.com,desk@parnasse.fr'
		Else i.adr_mail
	End 'adr_mail',
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
And		ds.nom_zone = 'cour_pec_a_envksl_pm234_7'
And		len ( rtrim ( ds.val_car ) ) > 0 
And		Not Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'dte_cour_pec_envksl_pm234_7' )
And		Not Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'cour_pec_envkslok_pm234_7' )
And		Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'pm234_7_auto_ok' )
And		p.id_prod=s.id_prod
And		i.id_sin=s.id_sin
And 	i.cod_inter='A'

Exec sysadm.PS_MAJ_XML_COUR_ORANGEV3

Select no_dossier_sinistre, 
	xml_data 
From sysadm.w_cour_xml_orangev3

Go


--------------------------------------------------------------------
--
-- Procédure            :       PS_U_PM234_7_COUR_PEC
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
-- JFF      26/04/2023   [RS5045_REF_MATP]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_PM234_7_COUR_PEC' AND type = 'P' )
        DROP procedure sysadm.PS_U_PM234_7_COUR_PEC 
GO

CREATE procedure sysadm.PS_U_PM234_7_COUR_PEC
        @adcIdSin     Decimal (  10,0 ),
        @asCas 	VarChar (35) = null
AS

-- [RS5045_REF_MATP]
If sysadm.FN_CLE_NUMERIQUE ( 'RS5045_REF_MATP') > 0 
 Begin
	-- Fin de cette méthode
	Return
 End 

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 
Declare @sAdrMailErr VarChar ( 150 )

-- dte_cour_pec_envksl_pm234_7
If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_cour_pec_envksl_pm234_7')
	 Begin
	   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_cour_pec_envksl_pm234_7'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_sin values ( @adcIdSin, 'dte_cour_pec_envksl_pm234_7', 'Date envoi cour. PEC KSL PM234-7', '-1', 'N', 'D', 'N', 'N', 770, null, null, GETDATE(), null, 1, getdate(), getdate(), 'EDS' ) 
	 End

	Update sysadm.w_div_sin Set nom_zone = 'cour_pec_envkslok_pm234_7', lib_label = 'Cour. PEC envoyé par KSL PM234-7' Where id_sin = @adcIdSin And nom_zone = 'cour_pec_a_envksl_pm234_7'
  End


If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_cour_pec_envksl_pm234_7')
	 Begin
	   Update sysadm.div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_cour_pec_envksl_pm234_7'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.div_sin values ( @adcIdSin, 'dte_cour_pec_envksl_pm234_7', 'Date envoi cour. PEC KSL PM234-7', '-1', 'N', 'D', 'N', 'N', 770, null, null, GETDATE(), null, getdate(), getdate(), 'EDS', getdate(), 'EDS' ) 
	 End

	Update sysadm.div_sin Set nom_zone = 'cour_pec_envkslok_pm234_7' , lib_label = 'Cour. PEC envoyé par KSL PM234-7' Where id_sin = @adcIdSin And nom_zone = 'cour_pec_a_envksl_pm234_7'

  End


Set @sMess = 'Suite automatisation de la déclaration via ATLAS/SIMPA2 (PM234-7), le courrier de prise en charge a été envoyé par KSL.'

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

--------------------------------------------------------------------
--
-- Procédure            :       PS_D_PM234_7_CTRLE_PRESTA
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
-- JFF      18/01/2019   [PC151379]
-- JFF      05/09/2019   [DT386]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_D_PM234_7_CTRLE_PRESTA' AND type = 'P' )
        DROP procedure sysadm.PS_D_PM234_7_CTRLE_PRESTA 
GO

CREATE procedure sysadm.PS_D_PM234_7_CTRLE_PRESTA
        @sIdFour VarChar ( 10 )
AS

Set Transaction Isolation level Read UnCommitted

DECLARE @tb TABLE 
	( id_seq	integer identity,
	  id_sin	decimal (10 ),
	  id_projet varchar ( 20 ),
	  marquage	integer null 
	)

Declare @dcIdSin decimal (10 )
Declare @iIdSeq integer
Declare @iCtrle integer
Declare @sMsgTemp VarChar ( 255 )
Declare @sIdProjet VarChar ( 50 )

Insert into @tb
select distinct 
	   c.id_sin, 
	   0 'marquage',
	   'AUTO_ATLAS'
From   sysadm.commande c
Where  c.id_four = @sIdFour
And    c.id_lot_cmd = 0
And    c.id_typ_art = 'PRS'
And    sysadm.FN_CLE_VAL ( 'AUTO_ATLAS', info_spb_frn_cplt, ';') = 'OUI'

-- [PC151379]
Insert into @tb
select distinct 
	   c.id_sin, 
	   0 'marquage',
	   'AUTO_ATM'
From   sysadm.commande c
Where  c.id_four = @sIdFour
And    c.id_lot_cmd = 0
And    c.id_typ_art = 'PRS'
And    sysadm.FN_CLE_VAL ( 'AUTO_ATM', info_spb_frn_cplt, ';') = 'OUI'

-- [DT386]
Insert into @tb
select distinct 
	   c.id_sin, 
	   0 'marquage',
	   'AUTO_AXA'
From   sysadm.commande c
Where  c.id_four = @sIdFour
And    c.id_lot_cmd = 0
And    c.id_typ_art = 'PRS'
And    sysadm.FN_CLE_VAL ( 'AUTO_AXA', info_spb_frn_cplt, ';') = 'OUI'

While Exists ( Select Top 1 1 From @tb where marquage = 0 )
 Begin
	Select 	Top 1 
		@iIdSeq = id_seq,
		@dcIdSin = id_sin,
		@sIdProjet = id_projet
	From	@tb
	Where	marquage = 0

	Exec @iCtrle = sysadm.PS_I_PM234_7_CTRL_APRES_VALIDATION @dcIdSin

	If @iCtrle < 0 
	  Begin
		Delete sysadm.commande Where id_sin = @dcIdSin
		Delete sysadm.w_commande Where id_sin = @dcIdSin

		-- [PC151379]
		Delete sysadm.div_sin Where id_sin = @dcIdSin And nom_zone in ( 
			 'pm234_7_auto_ok',
			 'pc151379_auto_ok',
			 'dt386_auto_ok'
			 )
		Delete sysadm.w_div_sin Where id_sin = @dcIdSin And nom_zone in ( 
			 'pm234_7_auto_ok',
			 'pc151379_auto_ok',
			 'dt386_auto_ok'
			 )

		Select @sIdProjet = 
			   Case @sIdProjet
					When 'AUTO_ATLAS' Then 'Orange V3 via ATLAS/SIMPA2'
					When 'AUTO_ATM'   Then 'CRCA via EXTR_ATM/SIMPA2' -- [PC151379]
					When 'AUTO_AXA'   Then 'AXA via EXTR_AXA/SIMPA2' -- [DT386]
					Else ''
			   End 

		Set @sMsgTemp = 'Problème lors de la validation automatique, (nbre lignes/cpt_valide). Automatisation du process ' + @sIdProjet + ' impossible donc.'
		Exec sysadm.PS_I_PM234_7_REJET @dcIdSin, 'Problème validation auto 3', @sMsgTemp 
	  End 

	Update @tb Set marquage = 1 Where id_seq = @iIdSeq
 End
 
Go


--------------------------------------------------------------------
-- Procédure            :       PS_I_PM234_7_CAS_DF005_EN_ATT_PCE_SANS_TRV
-- Auteur               :       Fabry JF
-- Date                 :       04/07/2017
-- Libellé              :		[DF005]
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF	02/11/2017	[VDOC25039]
-- JFF      15/06/2018   [DF005-1-LOT3]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_CAS_DF005_EN_ATT_PCE_SANS_TRV' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_CAS_DF005_EN_ATT_PCE_SANS_TRV
GO

CREATE procedure sysadm.PS_I_PM234_7_CAS_DF005_EN_ATT_PCE_SANS_TRV
	@adcIdSin   Decimal (10)
AS

Declare @iIdSeq integer
Declare @dcTriPce decimal ( 2 )
Declare @sIdParaPce VarChar ( 4 ) 
Declare @dDteRecu DateTime
Declare @dDteFinGti DateTime
Declare @sCodOper       Varchar (  4   )
Declare @sNoBoite       Varchar ( 10   )
Declare @sProc          Varchar ( 60   )
Declare @dtValideLe     DateTime        
Declare @sMethode	VarChar ( 3 )  	
Declare @iRet Integer
Declare @sMsgTemp VarChar ( 255 )
Declare @iIdCt Integer
Declare @sErr varchar(60)
Declare @dcIdCorb Decimal ( 3 )
Declare @dtCreeLeDos DateTime

Declare @dtDteAdh DateTime
Declare @dtDteSurv DateTime
Declare @dcIdProd Decimal ( 7 )
Declare @sRev     VarChar ( 10 )

Declare @dcIdGti  Decimal ( 7 )

Select Top 1 @dcIdGti = g.id_gti
From   sysadm.w_gar_sin g
Where  g.id_sin = @adcIdSin

/* [VDOC25039]
If Not Exists ( 
	Select Top 1 1 
	From    sysadm.w_piece wp
	Where   wp.id_sin = @adcIdSin
	And     wp.id_gti = @dcIdGti
	And     wp.id_pce = 17
	) 
	Begin
		Select Top 1 
				@dcTriPce =p.cpt_tri,
				@sIdParaPce = p.id_para
		From   sysadm.piece p,
			   sysadm.w_sin ws
		Where  ws.id_sin = @adcIdSin
		And	   p.id_prod = ws.id_prod
		And    p.id_pce = 17

		If @dcTriPce is not null 
		 Begin
			Insert into sysadm.w_piece Values ( @adcIdSin, @dcIdGti, 0, 17, 0, @sIdParaPce , @dcTriPce, getdate(), getdate(), 'WEB' ) 			
		 End 

	End 
*/

If Not Exists ( 
	Select Top 1 1 
	From    sysadm.w_piece wp
	Where   wp.id_sin = @adcIdSin
	And     wp.id_gti = @dcIdGti
	And     wp.id_pce = 639
	) 
	Begin
		Select Top 1 
				@dcTriPce =p.cpt_tri,
				@sIdParaPce = p.id_para
		From   sysadm.piece p,
			   sysadm.w_sin ws
		Where  ws.id_sin = @adcIdSin
		And	   p.id_prod = ws.id_prod
		And    p.id_pce = 639

		If @dcTriPce is not null 
		 Begin
			Insert into sysadm.w_piece Values ( @adcIdSin, @dcIdGti, -1, 639, 0, @sIdParaPce , @dcTriPce, getdate(), getdate(), 'WEB' ) 			
		 End 

	End 

If ( Select Count (*)
	 From   sysadm.w_piece wp
	 Where  wp.id_sin = @adcIdSin
	 And	wp.id_gti = @dcIdGti
--	 And    wp.id_pce in ( 17, 639 ) [VDOC25039]
	 And    wp.id_pce in ( 639 )
--	) = 2  [VDOC25039]
	) = 1
  Begin 

	-- [DF005-1-LOT3]
	If sysadm.FN_CLE_NUMERIQUE ( 'DF005-1-LOT3') > 0 
	 Begin
		Exec sysadm.PS_I_PM234_7_TAG_COURRIER_PIECE @adcIdSin, 'Z00338'	
	 End     

	Return 1
  End 
  Else
  Begin
    Return -1
  End 
Go


--------------------------------------------------------------------
-- Procédure            :       PS_I_PM234_7_TAG_COURRIER_REFUS
-- Auteur               :       Fabry JF
-- Date                 :       14/12/2017
-- Libellé              :		[DF005-1-LOT2]
-- Commentaires         :      
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_TAG_COURRIER_REFUS' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_TAG_COURRIER_REFUS
GO

CREATE procedure sysadm.PS_I_PM234_7_TAG_COURRIER_REFUS
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
	'cour_refus_a_envksl_df005_2',
	'Cour.Refus à envoyer pr KSL DF005-2',
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

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM234_7_COUR_REFUS
-- Auteur               :       Fabry JF
-- Date                 :       14/12/2017
-- Libellé              :
-- Commentaires         :       
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      22/09/2016   [PM234-7][M21970]
-- JFF		26/04/2017   [DT288]
-- JFF      03/08/2017   [DF006]
-- JFF      12/02/2018   [DT346]
-- JFF      06/11/2018   [PM451-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM234_7_COUR_REFUS' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM234_7_COUR_REFUS 
GO

CREATE procedure sysadm.PS_S_PM234_7_COUR_REFUS
AS

SET NOCOUNT ON

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
	  imei, -- [PM234-7][M21970]
	  maj_par, -- [PM234-7][M21970]
	  adr_mail_cc, -- [DF006]
	  code_refus, -- [DF005-1-LOT2]
	  nature -- [DF005-1-LOT2]
	  )
Select	
	s.id_sin, 
	sysadm.FN_CODE_NUM(pers.cod_civ,'-CI') as civilite, 
	Case 	When pers.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
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
	IsNull ( rtrim ( ds.val_car ), '') as code_maquette,
	Case -- [DT346]
		When Exists ( 
				Select Top 1 1 
				From   sysadm.div_sin ds,
					   sysadm.det_pro dp 
				Where  ds.id_sin = s.id_sin
				And	   ds.nom_zone = 'client_vip'
				And	   ds.val_car = 'VIPPAR'
				And	   s.id_sin = ds.id_sin 
				And	   dp.id_prod = s.id_prod
				And    dp.id_code_dp = 272
			)	Then 'laura.naulot@orange.com,desk@parnasse.fr'
		Else i.adr_mail
	End 'adr_mail',
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
	), -- [VDOC17642][DF006]
	(
		Select Top 1 Convert ( Varchar, id_motif )
		From sysadm.refus r
		Where r.id_sin = s.id_sin
	) as code_refus, -- [DF005-1-LOT2]
	Convert ( Varchar, s.id_natsin ) as nature -- [DF005-1-LOT2]
	  
From	sysadm.sinistre s,
		sysadm.personne pers,
		sysadm.det_pro dp,
		sysadm.produit p,
		sysadm.inter i,
		sysadm.div_sin ds
Where   dp.id_prod = s.id_prod and dp.id_code_dp = 239
And		pers.id_ordre = s.id_ordre
And		ds.id_sin = s.id_sin
And		ds.nom_zone = 'cour_refus_a_envksl_df005_2'
And		len ( rtrim ( ds.val_car ) ) > 0 
And		Not Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'dte_cour_refus_envksl_df005_2' )
And		Not Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'cour_refus_envkslok_df005_2' )
And		Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'pm234_7_auto_ok' )
And		p.id_prod=s.id_prod
And		i.id_sin=s.id_sin
And 	i.cod_inter='A'

Exec sysadm.PS_MAJ_XML_COUR_ORANGEV3

Select no_dossier_sinistre, 
	xml_data 
From sysadm.w_cour_xml_orangev3

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_U_PM234_7_COUR_REFUS
-- Auteur               :       Fabry JF
-- Date                 :       14/12/2017
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
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_PM234_7_COUR_REFUS' AND type = 'P' )
        DROP procedure sysadm.PS_U_PM234_7_COUR_REFUS 
GO

CREATE procedure sysadm.PS_U_PM234_7_COUR_REFUS
        @adcIdSin     Decimal (  10,0 ),
        @asCas 	VarChar (35) = null
AS

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 
Declare @sAdrMailErr VarChar ( 150 )

-- dte_cour_pec_envksl_pm234_7
If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_cour_refus_envksl_df005_2')
	 Begin
	   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_cour_refus_envksl_df005_2'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_sin values ( @adcIdSin, 'dte_cour_refus_envksl_df005_2', 'Date envoi cour. REFUS KSL DF005-2', '-1', 'N', 'D', 'N', 'N', 770, null, null, GETDATE(), null, 1, getdate(), getdate(), 'EDS' ) 
	 End

	Update sysadm.w_div_sin Set nom_zone = 'cour_refus_envkslok_df005_2', lib_label = 'Cour. Refus envoyé par KSL DF005-2' Where id_sin = @adcIdSin And nom_zone = 'cour_refus_a_envksl_df005_2'
  End


If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_cour_refus_envksl_df005_2')
	 Begin
	   Update sysadm.div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_cour_refus_envksl_df005_2'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.div_sin values ( @adcIdSin, 'dte_cour_refus_envksl_df005_2', 'Date envoi cour. REFUS KSL DF005-2', '-1', 'N', 'D', 'N', 'N', 770, null, null, GETDATE(), null, getdate(), getdate(), 'EDS', getdate(), 'EDS' ) 
	 End

	Update sysadm.div_sin Set nom_zone = 'cour_refus_envkslok_df005_2' , lib_label = 'Cour. Refus envoyé par KSL DF005-2' Where id_sin = @adcIdSin And nom_zone = 'cour_refus_a_envksl_df005_2'

  End


Set @sMess = 'Suite automatisation de la déclaration via ATLAS/SIMPA2 (PM234-7/DF005-2), le courrier de refus a été envoyé par KSL.'

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

--------------------------------------------------------------------
-- Procédure            :       PS_I_PM234_7_TAG_COURRIER_PIECE
-- Auteur               :       Fabry JF
-- Date                 :       15/06/2018
-- Libellé              :
-- Commentaires         :      [DF005-1-LOT3]
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_I_PM234_7_TAG_COURRIER_PIECE' AND type = 'P' )
        DROP procedure sysadm.PS_I_PM234_7_TAG_COURRIER_PIECE
GO

CREATE procedure sysadm.PS_I_PM234_7_TAG_COURRIER_PIECE
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
	'cour_piece_a_envksl_df005_1l3',
	'Cour.PIECE à envoyer pr KSL DF005',
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

--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM234_7_COUR_PIECE
-- Auteur               :       Fabry JF
-- Date                 :       15/06/2018
-- Libellé              :
-- Commentaires         :       [DF005-1-LOT3]
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      22/09/2016   [PM234-7][M21970]
-- JFF		26/04/2017   [DT288]
-- JFF      03/08/2017   [DF006]
-- JFF      12/02/2018   [DT346]
-- JFF      06/11/2018   [PM451-1]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM234_7_COUR_PIECE' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM234_7_COUR_PIECE 
GO

CREATE procedure sysadm.PS_S_PM234_7_COUR_PIECE
AS

SET NOCOUNT ON

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
	  imei, -- [PM234-7][M21970]
	  maj_par, -- [PM234-7][M21970]
	  adr_mail_cc, -- [DF006]
	  nature, -- [DF005-1-LOT2]
	  var_enum1 -- [DF005-1-LOT3]
	  )
Select	
	s.id_sin, 
	sysadm.FN_CODE_NUM(pers.cod_civ,'-CI') as civilite, 
	Case 	When pers.cod_civ=5 Then sysadm.FN_CODE_NUM( 4 ,'-CL') -- [PM451-1]
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
	IsNull ( rtrim ( ds.val_car ), '') as code_maquette,
	Case -- [DT346]
		When Exists ( 
				Select Top 1 1 
				From   sysadm.div_sin ds,
					   sysadm.det_pro dp 
				Where  ds.id_sin = s.id_sin
				And	   ds.nom_zone = 'client_vip'
				And	   ds.val_car = 'VIPPAR'
				And	   s.id_sin = ds.id_sin 
				And	   dp.id_prod = s.id_prod
				And    dp.id_code_dp = 272
			)	Then 'laura.naulot@orange.com,desk@parnasse.fr'
		Else i.adr_mail
	End 'adr_mail',
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
	), -- [VDOC17642][DF006]
	Convert ( Varchar, s.id_natsin ) as nature, -- [DF005-1-LOT2]
	(
		Select Top 1 Convert ( Varchar, id_pce )
		From sysadm.w_piece wp
		Where wp.id_sin = s.id_sin
	) as var_enum1 -- [DF005-1-LOT3]
	  
From	sysadm.sinistre s,
		sysadm.personne pers,
		sysadm.det_pro dp,
		sysadm.produit p,
		sysadm.inter i,
		sysadm.div_sin ds
Where   dp.id_prod = s.id_prod and dp.id_code_dp = 239
And		pers.id_ordre = s.id_ordre
And		ds.id_sin = s.id_sin
And		ds.nom_zone = 'cour_piece_a_envksl_df005_1l3'
And		len ( rtrim ( ds.val_car ) ) > 0 
And		Not Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'dte_cour_piece_envksl_df005_1l3' )
And		Not Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'cour_piece_envkslok_df005_1l3' )
And		Exists ( Select * From sysadm.div_sin ds Where ds.id_sin = s.id_sin and ds.nom_zone = 'pm234_7_auto_ok' )
And		p.id_prod=s.id_prod
And		i.id_sin=s.id_sin
And 	i.cod_inter='A'

Exec sysadm.PS_MAJ_XML_COUR_ORANGEV3

Select no_dossier_sinistre, 
	xml_data 
From sysadm.w_cour_xml_orangev3

Go

--------------------------------------------------------------------
--
-- Procédure            :       PS_U_PM234_7_COUR_PIECE
-- Auteur               :       Fabry JF
-- Date                 :       15/06/2018
-- Libellé              :
-- Commentaires         :        [DF005-1-LOT3]
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_U_PM234_7_COUR_PIECE' AND type = 'P' )
        DROP procedure sysadm.PS_U_PM234_7_COUR_PIECE 
GO

CREATE procedure sysadm.PS_U_PM234_7_COUR_PIECE
        @adcIdSin     Decimal (  10,0 ),
        @asCas 	VarChar (35) = null
AS

Declare @sMess			VarChar ( 2000 )
Declare @sErr			Varchar(60)
Declare @iIdCt			integer	
Declare @iVal			integer 
Declare @sAdrMailErr VarChar ( 150 )

-- dte_cour_pec_envksl_pm234_7
If Exists ( Select * From sysadm.w_sin ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.w_div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_cour_piece_envksl_df005_1l3')
	 Begin
	   Update sysadm.w_div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_cour_piece_envksl_df005_1l3'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.w_div_sin values ( @adcIdSin, 'dte_cour_piece_envksl_df005_1l3', 'Date envoi cour.PIECE KSL DF005-1L3', '-1', 'N', 'D', 'N', 'N', 770, null, null, GETDATE(), null, 1, getdate(), getdate(), 'EDS' ) 
	 End

	Update sysadm.w_div_sin Set nom_zone = 'cour_piece_envkslok_df005_1l3', lib_label = 'Cour.PIECE envoyé par KSL DF005-1L3' Where id_sin = @adcIdSin And nom_zone = 'cour_piece_a_envksl_df005_1l3'

  End


If Exists ( Select * From sysadm.sinistre ws Where ws.id_sin = @adcIdSin  )	
  Begin
	If Exists ( Select * From sysadm.div_sin wds Where wds.id_sin = @adcIdSin And nom_zone = 'dte_cour_piece_envksl_df005_1l3')
	 Begin
	   Update sysadm.div_sin Set val_dte = GETDATE(), maj_le = GETDATE(), maj_par = 'EDS' Where id_sin = @adcIdSin And nom_zone = 'dte_cour_piece_envksl_df005_1l3'
	 End 
	Else
	 Begin	 
	   Insert into sysadm.div_sin values ( @adcIdSin, 'dte_cour_piece_envksl_df005_1l3', 'Date envoi cour.PIECE KSL DF005-1L3', '-1', 'N', 'D', 'N', 'N', 770, null, null, GETDATE(), null, getdate(), getdate(), 'EDS', getdate(), 'EDS' ) 
	 End

	Update sysadm.div_sin Set nom_zone = 'cour_piece_envkslok_df005_1l3' , lib_label = 'Cour.PIECE envoyé par KSL DF005-1L3' Where id_sin = @adcIdSin And nom_zone = 'cour_piece_a_envksl_df005_1l3'

  End


Set @sMess = 'Suite automatisation de la déclaration via ATLAS/SIMPA2 (PM234-7/DF005-1-LOT3), le courrier de demande de pièce a été envoyé par KSL.'

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


--------------------------------------------------------------------
--
-- Procédure            :       PS_S_PM234_7_AUDIT_ASSUREUR_ELSA
-- Auteur               :       Fabry JF
-- Date                 :       14/08/2018
-- Libellé              :
-- Commentaires         :        [AUDIT_ASSUREUR_ELSA]
-- Références           :
--
-- Arguments            :       @dcIdSin        Decimal (  10,0 )        (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------
-- JFF      12/02/2016   [PI062]
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_S_PM234_7_AUDIT_ASSUREUR_ELSA' AND type = 'P' )
        DROP procedure sysadm.PS_S_PM234_7_AUDIT_ASSUREUR_ELSA 
GO

CREATE procedure sysadm.PS_S_PM234_7_AUDIT_ASSUREUR_ELSA
        @adcIdSin     Decimal (  10,0 )
AS

If Exists ( 
	Select	Top 1 1
	From	sysadm.w_sin ws,
			sysadm.produit p
	Where   ws.id_sin = @adcIdSin
	And		p.id_prod = ws.id_prod
	And		p.id_grp Not in ( 254, 678, 669 )
   )
   Begin 
	Return 0
   End

If Exists ( 
		Select Top 1 1 
		From	sysadm.w_inter wi
		Where	wi.id_sin = @adcIdSin
		And		wi.adr_mail in ( 
		'actacomts',
		'actacom',
		'actacomps',
		'actacomtl',
		'gaia.martine',
		'lebasketteur46',
		'roybanque@gmail.com',
		'r.osei@orange.fr',
		'yeb-boa@orange.fr',
		'roybanque@hotmail.fr',
		'ri.osei8989@gmail.com',
		'r.oseiyeb@gmail.com',
		'oseiye@gmail.com',
		'oseiyeboah89@gmail.com'
		)
	)
	Begin
		Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Dossier en audit assureur', 'Le dossier est en audit assureur, rapprochez-vous du DR. Automatisation du process Extranet/SIMPA2 impossible donc.'
		Return -1
	End 


If Exists ( 
		Select Top 1 1 
		From	sysadm.w_inter wi
		Where	wi.id_sin = @adcIdSin
		And		wi.rib_cpt in ( 
		'50010602750',
		'1330785X037',
		'00085215245',
		'00012441101',
		'32219024257',
		'0828525J025',
		'1025517F025',
		'00000335045',
		'00000335142'
		)
	)
	Begin
		Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Dossier en audit assureur', 'Le dossier est en audit assureur, rapprochez-vous du DR. Automatisation du process Extranet/SIMPA2 impossible donc.'
		Return -1
	End 

If Exists ( 
		Select Top 1 1 
		From	sysadm.w_inter wi
		Where	wi.id_sin = @adcIdSin
		And		wi.num_teld in ( 
		'0603989798',
		'0640081877',
		'0673300168'
		)
	)
	Begin
		Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Dossier en audit assureur', 'Le dossier est en audit assureur, rapprochez-vous du DR. Automatisation du process Extranet/SIMPA2 impossible donc.'
		Return -1
	End 


If Exists ( 
		Select Top 1 1 
		From	sysadm.w_inter wi
		Where	wi.id_sin = @adcIdSin
		And		wi.num_telb in ( 
		'0603989798',
		'0640081877',
		'0673300168'
		)
	)
	Begin
		Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Dossier en audit assureur', 'Le dossier est en audit assureur, rapprochez-vous du DR. Automatisation du process Extranet/SIMPA2 impossible donc.'
		Return -1
	End 

If Exists ( 
		Select Top 1 1 
		From	sysadm.w_inter wi
		Where	wi.id_sin = @adcIdSin
		And		wi.num_fax in ( 
		'0603989798',
		'0640081877',
		'0673300168'
		)
	)
	Begin
		Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Dossier en audit assureur', 'Le dossier est en audit assureur, rapprochez-vous du DR. Automatisation du process Extranet/SIMPA2 impossible donc.'
		Return -1
	End 

If Exists ( 
		Select Top 1 1 
		From	sysadm.w_sin ws
		Where	ws.id_sin = @adcIdSin
		And		ws.num_port in ( 
		'0603989798',
		'0640081877',
		'0673300168'
		)
	)
	Begin
		Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Dossier en audit assureur', 'Le dossier est en audit assureur, rapprochez-vous du DR. Automatisation du process Extranet/SIMPA2 impossible donc.'
		Return -1
	End 

If Exists ( 
		Select Top 1 1 
		From	sysadm.w_sin ws
		Where	ws.id_sin = @adcIdSin
		And		CharIndex ( 'JEAN', Upper ( IsNull ( ws.adr_1, '') + ' ' + IsNull ( ws.adr_2, '') ) ) > 0 
		And		CharIndex ( 'JAUR', Upper ( IsNull ( ws.adr_1, '') + ' ' + IsNull ( ws.adr_2, '') ) ) > 0
		And		CharIndex ( 'CAHORS', Upper ( IsNull ( ws.adr_ville, ''))) > 0
	)
	Begin
		Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Dossier en audit assureur', 'Le dossier est en audit assureur, rapprochez-vous du DR. Automatisation du process Extranet/SIMPA2 impossible donc.'
		Return -1
	End 

If Exists ( 
		Select Top 1 1 
		From	sysadm.w_inter wi
		Where	wi.id_sin = @adcIdSin
		And		CharIndex ( 'JEAN', Upper ( IsNull ( wi.adr_1, '') + ' ' + IsNull ( wi.adr_2, '') ) ) > 0 
		And		CharIndex ( 'JAUR', Upper ( IsNull ( wi.adr_1, '') + ' ' + IsNull ( wi.adr_2, '') ) ) > 0
		And		CharIndex ( 'CAHORS', Upper ( IsNull ( wi.adr_ville, ''))) > 0
	)
	Begin
		Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Dossier en audit assureur', 'Le dossier est en audit assureur, rapprochez-vous du DR. Automatisation du process Extranet/SIMPA2 impossible donc.'
		Return -1
	End 


If Exists ( 
		Select Top 1 1 
		From	sysadm.w_sin ws
		Where	ws.id_sin = @adcIdSin
		And		CharIndex ( '46', Upper ( IsNull ( ws.adr_1, '') + ' ' + IsNull ( ws.adr_2, '') ) ) > 0 
		And		CharIndex ( 'SOUGER', Upper ( IsNull ( ws.adr_1, '') + ' ' + IsNull ( ws.adr_2, '') ) ) > 0
		And		CharIndex ( 'AUXERRE', Upper ( IsNull ( ws.adr_ville, ''))) > 0
	)
	Begin
		Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Dossier en audit assureur', 'Le dossier est en audit assureur, rapprochez-vous du DR. Automatisation du process Extranet/SIMPA2 impossible donc.'
		Return -1
	End 

If Exists ( 
		Select Top 1 1 
		From	sysadm.w_inter wi
		Where	wi.id_sin = @adcIdSin
		And		CharIndex ( '46', Upper ( IsNull ( wi.adr_1, '') + ' ' + IsNull ( wi.adr_2, '') ) ) > 0 
		And		CharIndex ( 'SOUGER', Upper ( IsNull ( wi.adr_1, '') + ' ' + IsNull ( wi.adr_2, '') ) ) > 0
		And		CharIndex ( 'AUXERRE', Upper ( IsNull ( wi.adr_ville, ''))) > 0
	)
	Begin
		Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Dossier en audit assureur', 'Le dossier est en audit assureur, rapprochez-vous du DR. Automatisation du process Extranet/SIMPA2 impossible donc.'
		Return -1
	End 


If Exists ( 
		Select Top 1 1 
		From	sysadm.w_sin ws
		Where	ws.id_sin = @adcIdSin
		And		CharIndex ( '3', Upper ( IsNull ( ws.adr_1, '') + ' ' + IsNull ( ws.adr_2, '') ) ) > 0 
		And		CharIndex ( 'PROM', Upper ( IsNull ( ws.adr_1, '') + ' ' + IsNull ( ws.adr_2, '') ) ) > 0
		And		CharIndex ( 'CHAP', Upper ( IsNull ( ws.adr_1, '') + ' ' + IsNull ( ws.adr_2, '') ) ) > 0
		And		CharIndex ( 'JOIGNY', Upper ( IsNull ( ws.adr_ville, ''))) > 0
	)
	Begin
		Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Dossier en audit assureur', 'Le dossier est en audit assureur, rapprochez-vous du DR. Automatisation du process Extranet/SIMPA2 impossible donc.'
		Return -1
	End 

If Exists ( 
		Select Top 1 1 
		From	sysadm.w_inter wi
		Where	wi.id_sin = @adcIdSin
		And		CharIndex ( '3', Upper ( IsNull ( wi.adr_1, '') + ' ' + IsNull ( wi.adr_2, '') ) ) > 0 
		And		CharIndex ( 'PROM', Upper ( IsNull ( wi.adr_1, '') + ' ' + IsNull ( wi.adr_2, '') ) ) > 0
		And		CharIndex ( 'CHAP', Upper ( IsNull ( wi.adr_1, '') + ' ' + IsNull ( wi.adr_2, '') ) ) > 0
		And		CharIndex ( 'JOIGNY', Upper ( IsNull ( wi.adr_ville, ''))) > 0
	)
	Begin
		Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Dossier en audit assureur', 'Le dossier est en audit assureur, rapprochez-vous du DR. Automatisation du process Extranet/SIMPA2 impossible donc.'
		Return -1
	End 


If Exists ( 
		Select Top 1 1 
		From	sysadm.w_sin ws
		Where	ws.id_sin = @adcIdSin
		And		CharIndex ( ' OSEI ', Upper ( IsNull ( ws.nom, '')) ) > 0 
	)
	Begin
		Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Dossier en audit assureur', 'Le dossier est en audit assureur, rapprochez-vous du DR. Automatisation du process Extranet/SIMPA2 impossible donc.'
		Return -1
	End 

If Exists ( 
		Select Top 1 1 
		From	sysadm.w_inter wi
		Where	wi.id_sin = @adcIdSin
		And		CharIndex ( ' OSEI ', Upper ( IsNull ( wi.nom, '')) ) > 0 
	)
	Begin
		Exec sysadm.PS_I_PM234_7_REJET @adcIdSin, 'Dossier en audit assureur', 'Le dossier est en audit assureur, rapprochez-vous du DR. Automatisation du process Extranet/SIMPA2 impossible donc.'
		Return -1
	End 


Return 0

Go

