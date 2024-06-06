-------------------------------------------------------------------
--
-- Fichier              :       HUB_PRESTATAIRE_SIMPA2.CP
-- Auteur               :       JFF
-- Date                 :       11/03/2024
--
-- Commentaires         :       Gestion des PS SQL 
--
-- Procédures           :       
-------------------------------------------------------------------
-- sysadm.PS_HP276_S_S2_DATA_DOSSIER
-- sysadm.PS_HP276_S_S2_OBTENTION_DONNEES_PRESTA_SIMPA2_POUR_PREPARATION_CREATION_HUB_PRESTATAIRE
-- sysadm.PS_HP276_S_S2_RECUPERER_ID_SEQ_ORIG
-- sysadm.PS_HP276_S_S2_RECUPERER_ID_SEQ_SAV
-- sysadm.PS_HP276_SU_S2_MOTEUR_TRT_RETOUR_HUB
-- sysadm.PS_HP276_SU_S2_MOTEUR_TRT_RETOUR_HUB_DETERMINATION_STATUT
-- sysadm.PS_HP276_U_S2_MAJ_GEN_PRESTA
-- sysadm.PS_HP276_I_S2_ATTENTE_TRANSFERT_VERS_HP
-- sysadm.PS_HP276_SI_S2_MOTEUR_TRANSFERT_PARTICULIER_VERS_HUB
-------------------------------------------------------------------

-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_S_S2_DATA_DOSSIER
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Renvoie vers SIMPA2, à partir du HUB,  les points de services  possibles que propose le HUB selon "n" critères
--                              /!\ A COMPILER SUR LA BASE SIMPA2 /!\
--								Cette est la PS d'appel SIMPA2 qui appel le HUB selon l'environnement
--
-- Retourne             :       rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_S_S2_DATA_DOSSIER' AND type = 'P' )
        DROP procedure sysadm.PS_HP276_S_S2_DATA_DOSSIER
GO

CREATE procedure sysadm.PS_HP276_S_S2_DATA_DOSSIER
		@adcIdSin				Decimal ( 10 ),
		@asIdAdh				VarChar ( 50 ) OutPut,
		@aiIdGrpContractant		Integer OutPut,
		@asLibGrpContractant	VarChar ( 35 ) OutPut

AS

Select	@asIdAdh =	Convert ( Varchar ( 20 ), pr.cod_prod_dms ) + '-' +
					Convert ( Varchar ( 20 ), ws.id_ets) + '-' +
					ltrim ( rtrim ( ws.id_adh )) + '-' +
					Convert ( Varchar ( 20 ), ws.id_sdos) + '-',
		@aiIdGrpContractant = gr.id_grp,
		@asLibGrpContractant = ltrim ( rtrim ( gr.lib_grp ))
From	sysadm.w_sin ws,
	    sysadm.produit pr,
		sysadm.groupe gr
Where   ws.id_sin = @adcIdSin
And     pr.id_prod = ws.id_prod
And     gr.id_grp = pr.id_grp

Set @asIdAdh = LTRIM ( rTrim ( @asIdAdh ))
If  @asIdAdh = '' Set @asIdAdh = null

Go

-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_S_S2_OBTENTION_DONNEES_PRESTA_SIMPA2_POUR_PREPARATION_CREATION_HUB_PRESTATAIRE
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       
--                              /!\ A COMPILER SUR LA BASE SIMPA2 /!\
--								
--
-- Retourne             :       rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_S_S2_OBTENTION_DONNEES_PRESTA_SIMPA2_POUR_PREPARATION_CREATION_HUB_PRESTATAIRE' AND type = 'P' )
        DROP procedure sysadm.PS_HP276_S_S2_OBTENTION_DONNEES_PRESTA_SIMPA2_POUR_PREPARATION_CREATION_HUB_PRESTATAIRE
GO

CREATE procedure sysadm.PS_HP276_S_S2_OBTENTION_DONNEES_PRESTA_SIMPA2_POUR_PREPARATION_CREATION_HUB_PRESTATAIRE
		@aiCas				Integer,
	    @adcIdsin			Decimal ( 10 ),
		@aiIdSeq			Integer
AS

Declare @iRet Integer
Declare @dcIdProd Decimal ( 7 )

Declare 
	@iIdSin						Integer					,   -- Référence sinistre
	@dtDeposeLe					DateTime				,	-- Enregistrement déposé par Simpa2 le 
	@sDeposePar					VarChar (4)				,	-- Enregistrement déposé par
	@sAltTrt					VarChar (1)				,	-- Répère alternatif O/N des enregistrement pris en compte et traité par le HubP.
	@dtTraiteLe					DateTime				,	-- Traité par le Hub le
	@sTraitePar					VarChar (4)				,	-- traité par
	@sIdHubPresta				VarChar ( 20 )			,   -- Identifiant sur le Hub Prestataire de la prestation
	@sIdFour					VarChar ( 3 )			,   -- /!\ IMPORTANT : Code Fournisseur officiel SPB, ce code sera associé à un RIB de règlement du fournisseur chez Volcanes
	@sTypDommage				VarChar ( 100 )			,	-- Chaine contenant les codes des types de dommage sous la forme '#TD1#TD4#TD5#'
	@sPointService				VarChar ( 20 )			,	-- Code du point de service	   
	@sModeProcess				VarChar ( 20 )			,	-- Mode de logistique (CENTRALISATION / PROXIMITE )
	@sCodePickUp				VarChar ( 20 )			,	-- Code du relais si CENTRALISATION et Choix PickUp
	@sAdrNomPickUp				VarChar ( 40 )			,	-- Nom du relais si CENTRALISATION et Choix PickUp	
	@sAdrReferenceAssPickUp		VarChar ( 40 )			,	-- référence du sinistre SPB et du nom de l'assuré à mettre sur le colis du Relais PickUp (dans le cas d'un renvoi)
	@sAdr1PickUp				VarChar ( 40 )			,   -- 1ère ligne adresse du relais pickup
	@sAdr2PickUp				VarChar ( 40 )			,   -- 2ème ligne adresse du relais pickup
	@sAdrCpltPickUp				VarChar ( 40 )			,   -- 3ème ligne adresse du relais pickup
	@sAdrCpPickUp				VarChar ( 5 )			,   -- Code postal du relais pickup
	@sAdrVillePickUp			VarChar ( 40 )			,   -- Ville du relais pickup
	@iCodeProcess				Integer					,   -- code process (-IF) 3510=Dépôt colis en bureau de poste, 3520=Dépôt colis en relais pickup, 3530=Dépôt en boutique de proximité
	@sLibCodeProcess			VarChar ( 35 )			,   -- Libellé du code process
	@iIdGti						Integer					,   -- ID de la garantie SIMPA2 (-GA )
	@sLibPersoGti				VarChar ( 35 )			,   -- Libellé personnalisé de la garantie pour le produit
	@iIdDetail					Integer					,   -- ID du détail de garantie SIMPA2 
	@iIdProd					Integer					,   -- Code produit (Offre) sinistre SIMPA2 
	@sLibProd					VarChar ( 35 )			,   -- Libellé du produit (offre) sinistre SIMPA2 
	@sIdProdAdh					Integer					,   -- Code produit adhésion 
	@iIdEts						Integer					,   -- Code ets adhésion
	@sIdAdh						VarChar ( 19 )			,   -- Numéro adhésion
	@iIdSdos					Integer					,   -- Numéro sous-dossier adhésion
	@sIdTypArt					varchar ( 3 )			,   -- Code représentant le type de la prestation
	@iCodCivLivr				Integer					,   -- Code civilité de l'interlocuteur lié à la prestation
	@sLibCivLivrCourt			varchar ( 35 )			,   -- Lib civilité court de l'interlocuteur lié à la prestation
	@sLibCivLivrLong			varchar ( 35 )			,   -- Lib civilité long de l'interlocuteur lié à la prestation
	@IdContratAbonne			VarChar ( 20 ) 			,	-- Identifiant éventuel de l'assuré reconnu par le contractant
	@NomAss						VarChar ( 35 ) 			,	-- Nom de l'assuré ayant souscrit l'adhésion
	@PrenomAss					VarChar ( 35 ) 			,	-- Prénom de l'assuré ayant souscrit l'adhésion
	@NomLivr					varchar ( 35 )			,   -- Nom de l'interlocuteur lié à la prestation
	@PrenomLivr					varchar ( 35 )			,   -- Prénom de l'interlocuteur lié à la prestation
	@sAdr1Livr					varchar ( 35 )			,   -- Adresse ligne 1 de l'interlocuteur lié à la prestation
	@sAdr2Livr					varchar ( 35 )			,   -- Adresse ligne 2 de l'interlocuteur lié à la prestation
	@sAdr3Livr					varchar ( 35 )			,   -- Adresse ligne 3 de l'interlocuteur lié à la prestation
	@sAdrCpLivr					varchar ( 5 )			,   -- Code postal de l'interlocuteur lié à la prestation
	@sAdrVilleLivr				varchar ( 35 )			,   -- Ville de l'interlocuteur lié à la prestation
	@sNumTel1Ass				varchar ( 20 ) 			,   -- Numéro tel1 de l'interlocuteur lié à la prestation
	@sNumTel2Ass				varchar ( 20 ) 			,   -- Numéro tel1 de l'interlocuteur lié à la prestation
	@sNumTel3Ass				varchar ( 20 ) 			,   -- Numéro tel1 de l'interlocuteur lié à la prestation
	@sMailAssure				varchar ( 128 )			,   -- Adresse mail de l'assuré
	@sNumImeiAppSin				varchar ( 20 )  		,   -- Numéro de IMEI de l'appareil sinistré
	@sNumSerieAppSin			varchar ( 20 )  		,   -- Numéro de série de l'appareil sinistré
	@sDescriptionProbleme		varchar ( 255 )  		,   -- Déscription résumé du probleme sur l'appareil écrit en français par le GT
	@sCodEtat					varchar ( 3 )   		,   -- Etat de la prestation
	@dtValideLe					DateTime				,   -- Date de validation de la prestation par le GT
	@sValidePar					varchar ( 4 )			,   -- Prestation validé par 
	@dtCmdGenLe					DateTime				,   -- Date de génération de la prestation par le système
	@sIdRefFour					varchar ( 20 )  		,   -- Pour une commande de remplacement, cela peut être ID du matériel chez le fournisseur, sinon l'ordre d'action
	@sOrdreAction				varchar ( 20 )  		,   -- Ordre d'action
	@iIdAssureur				Integer					,   -- ID officiel spb de l'assureur
	@sLibAssureur				Varchar ( 35 )			,   -- Libellé de l'assureur
	@sLibPolice					Varchar ( 35 )			,   -- Libellé de la police
	@sTypAppSin					VarChar ( 3 ) 			,   -- Type de l'appareil sinistré (-AR)
	@sLibTypAppSin				Varchar ( 35 )			,   -- Libellé de l'appareil sinistré (-AR)
	@sMarqAppSin				Varchar ( 35 )			,   -- Marque de l'appareil sinistré
	@sModlAppSin				Varchar ( 35 )			,   -- Modèle de l'appareil sinistré
	@sRefAppSin					Varchar ( 20 )			,   -- référence de l'appareil sinistré IFR, DARTY, AUTRE (AUTRE=Marque contrôlé, saisie modèle libre)
	@sNumTelSin					VarChar ( 25 )			,   -- Numéro de téléphone de l'appareil sinistré (si c'est une téléphone/smartphone)
	@mtValAchat					decimal ( 11, 2 )		,   -- Montant de la valeur d'achat
	@mtPriseEnCharge			decimal ( 11, 2 )		,   -- Montant de prise en max par spb (à respecter par le fournisseur )
	@dtDateAchat				DateTime				,	-- Date achat du matériel sinistré
	@sEtatAppSin				varChar ( 20 )			,	-- Etat de l'appareil sinistré, REConditionné ou NEUf
	@sCodeVerrou				VarChar ( 20 )			,	-- Code vérou de l'appareil
	@sDesimlocke				VarChar( 20 )			,	-- Appareil désimlocké OUI/NON
	@sInfo_spb_frn_cplt			VarChar ( 800 )				-- Chaîne sérialisée contenant de multiples informations


Select	@iIdSin			= Convert ( integer, @adcIdsin),
		@sLibPersoGti	= cg.lib_gti,
		@iIdProd		= s.id_prod,
		@sLibProd		= rtrim ( lTrim ( pr.lib_long )),
		@sIdProdAdh		= pr.cod_prod_dms,
		@iIdEts			= s.id_ets,
		@sIdAdh			= rtrim ( lTrim ( s.id_adh )),
		@iIdSdos		= s.id_sdos,
		@IdContratAbonne = rtrim ( lTrim ( s.id_contrat_abonne )),
		@sMarqAppSin	=  rtrim ( lTrim ( s.marq_port ) ),
		@sModlAppSin	=  rtrim ( lTrim ( s.modl_port ) ),
		@sNumTelSin		= s.num_port,
		@NomAss			= rtrim ( lTrim ( pe.nom )),
		@PrenomAss		= rtrim ( lTrim ( pe.prenom )),
		@sTypAppSin		= nullif ( sysadm.FN_GET_DIV_SIN ( @adcIdsin, 'TYPE_APP', 'P',  'RETOUR=CODE'  ) , ''), 
		@sLibTypAppSin  = nullif ( sysadm.FN_CODE_CAR ( @sTypAppSin, '-AR' ), '') ,
		@sEtatAppSin	= nullif ( sysadm.FN_GET_DIV_SIN ( @adcIdsin, 'TYPAPP_REC_NEU', 'P',  'RETOUR=CODE'  ), ''),
		@sCodeVerrou	= IsNull ( nullif ( sysadm.FN_CLE_VAL ( 'CODE_VERROU', c.info_spb_frn_cplt, ';' ), ''), 
						   		   nullif ( sysadm.FN_GET_DIV_SIN ( @adcIdsin, 'CODE_VERROU_SHERPA_SCRIPT', 'P', '' ), '' )),
		@sDesimlocke	= nullif ( sysadm.FN_GET_DIV_SIN ( @adcIdsin, 'DESIMLOCKE', 'P', '' ), '' ),
		@dtDateAchat	= s.dte_ach_port,
		@iIdAssureur	= sysadm.FN_ID_CIE (s.id_sin),
		@sLibAssureur   = sysadm.FN_LIB_CIE (s.id_sin),
		@sLibPolice		= sysadm.FN_LIB_POLICE (s.id_sin)

From	sysadm.sinistre s with ( nolock ), 
		sysadm.commande c with ( nolock ),
		sysadm.code_garantie cg with ( nolock ),
		sysadm.produit pr with ( nolock ),
		sysadm.personne pe with ( nolock )
Where	s.id_sin = @adcIdsin
And		c.id_sin = s.id_sin
And		c.id_seq = @aiIdSeq
And		cg.id_prod = s.id_prod
And		cg.id_gti = c.id_gti
And		pr.id_prod = s.id_prod
And		pe.id_ordre = s.id_ordre

Set @dcIdProd = CONVERT ( Decimal ( 7 ), @iIdProd ) 

Select 	@dtDeposeLe		= GETDATE(),
		@sDeposePar		= 'SIM2',
		@sAltTrt		= 'N',
		@dtTraiteLe		= null,
		@sTraitePar		= null,
		@sIdHubPresta	= sysadm.FN_CLE_VAL ('HP_ID_HUB_PRESTA' , c.info_spb_frn_cplt, ';'),
		@sTypDommage    = nullif ( sysadm.FN_CLE_VAL ('HP_TYP_DOM' , c.info_spb_frn_cplt, ';'), ''),
		@sIdFour		= c.id_four,
		@sPointService	= nullif ( sysadm.FN_CLE_VAL ('HP_ID_POINT_SERV' , c.info_spb_frn_cplt, ';'), ''),
		@sModeProcess	= nullif ( sysadm.FN_CLE_VAL ('HP_ID_MODE_PROCESS' , c.info_spb_frn_cplt, ';'), ''),
		@sCodePickUp	= nullif ( sysadm.FN_CLE_VAL ('CODE_PICK_UP' , c.info_spb_frn_cplt, ';'), ''),
		@sAdrNomPickUp	= nullif ( sysadm.FN_CLE_VAL ('NOM_PICK_UP' , c.info_spb_frn_cplt, ';'), ''),
		@sAdrReferenceAssPickUp= nullif ( sysadm.FN_CLE_VAL ('REFASS_PICK_UP' , c.info_spb_frn_cplt, ';'), ''),
		@sAdr1PickUp	= nullif ( sysadm.FN_CLE_VAL ('ADR1_PICK_UP' , c.info_spb_frn_cplt, ';'), ''),
		@sAdr2PickUp	= nullif ( sysadm.FN_CLE_VAL ('ADR2_PICK_UP' , c.info_spb_frn_cplt, ';'), ''),
		@sAdrCpltPickUp	= nullif ( sysadm.FN_CLE_VAL ('ADR3_PICK_UP' , c.info_spb_frn_cplt, ';'), ''),
		@sAdrCpPickUp	= nullif ( sysadm.FN_CLE_VAL ('ADRCP_PICK_UP' , c.info_spb_frn_cplt, ';'), ''),
		@sAdrVillePickUp= nullif ( sysadm.FN_CLE_VAL ('ADRVILLE_PICK_UP' , c.info_spb_frn_cplt, ';'), ''),
		@iCodeProcess	= c.info_spb_frn,
		@sLibCodeProcess= sysadm.FN_CODE_NUM ( c.info_spb_frn, '-IF' ), 
		@iIdGti			= c.id_gti,
		@iIdDetail		= c.id_detail,
		@sIdTypArt		= rtrim ( lTrim ( c.id_typ_art )),
		@iCodCivLivr	= c.adr_cod_civ,
		@sLibCivLivrCourt = sysadm.FN_CODE_NUM ( c.adr_cod_civ, '-CI' ),
		@sLibCivLivrLong = IIF ( c.adr_cod_civ = 5, 'Messieurs', sysadm.FN_CODE_NUM ( c.adr_cod_civ, '-CL' )),
		@NomLivr		= rtrim ( lTrim ( c.adr_nom )),
		@PrenomLivr		= rtrim ( lTrim ( c.adr_prenom )),
		@sAdr1Livr		= rtrim ( lTrim ( c.adr_livr1 )),
		@sAdr2Livr		= rtrim ( lTrim ( c.adr_livr2 )),
		@sAdr3Livr		= rtrim ( lTrim ( c.adr_livr_cpl )),
		@sAdrCpLivr		= rtrim ( lTrim ( c.adr_cp )),
		@sAdrVilleLivr	= rtrim ( lTrim ( c.adr_ville )),
		@sNumTel1Ass	= rtrim ( lTrim ( c.adr_tel1 )),
		@sNumTel2Ass	= rtrim ( lTrim ( c.adr_tel2 )),
		@sNumTel3Ass	= rtrim ( lTrim ( c.adr_tel3 )),
		@sMailAssure	= ( Select Top 1 rtrim ( lTrim ( i.adr_mail )) From sysadm.inter i with ( nolock ) Where i.id_sin = @adcIdsin And i.cod_inter = 'A' ),
		@sNumImeiAppSin = rtrim ( lTrim ( IIF ( @sTypAppSin	= 'TEL', c.id_serie_anc, null ))), 
		@sNumSerieAppSin = rtrim ( lTrim ( IIF ( @sTypAppSin <> 'TEL', c.id_serie_anc, null ))),
		@sDescriptionProbleme = rtrim ( lTrim ( c.probleme )),
		@sCodEtat = rtrim ( lTrim ( c.cod_etat )),
		@dtValideLe = c.valide_le, 
		@sValidePar = rtrim ( lTrim ( c.valide_par )), 
		@dtCmdGenLe = getdate(),
		@sIdRefFour = rtrim ( lTrim ( c.id_ref_four )),
		@sOrdreAction = rtrim ( lTrim ( IIF ( id_typ_art not in ( 'PRS', 'EDI' ), 'A_COMMANDER', c.id_ref_four ) )),
		@sRefAppSin  = 
			ISNULL ( 
			NullIf ( 
				(	Select  Top 1 LEFT ( dp.id_code_car, 3 )
					From	sysadm.det_pro dp with ( nolock )
					Where   dp.id_prod = @dcIdProd
					and		dp.id_code_dp = 28
					and		RIGHT ( dp.id_code_car, 3 ) = @sTypAppSin
				), ''), 'SPB' ),
		@mtValAchat = 
			( Select Top 1 IsNull ( d.mt_val_achat, 0 )
			  From sysadm.detail d with (nolock) 
			  where d.id_sin = c.id_sin
			  And   d.id_gti = c.id_gti
			  And   d.id_detail = c.id_detail ),
		@mtPriseEnCharge = 
			( Select Top 1 IsNull ( dd.val_mt, 0 )
			  From sysadm.div_det dd with (nolock) 
			  where dd.id_sin = c.id_sin
			  And   dd.id_gti = c.id_gti
			  And   dd.id_detail = c.id_detail 
			  And   dd.nom_zone = 'mt_pec' ),
		@dtDateAchat =
			Case 
				When ( 	Select 	count (*) 
					From 	sysadm.det_pro dp  with (nolock) 
		       			Where 	dp.id_prod = @dcIdProd
		       			And 	dp.id_code_dp = 42 
		       			and 	dp.id_code_car = 'A' 
		       			and 	dp.id_code_num = c.id_gti ) > 0 Then
		       				IsNull ( Convert ( VarChar ( 10 ) , 
								(select d.dte_det 
								from sysadm.detail d  with (nolock) 
								where d.id_sin = c.id_sin 
								and d.id_gti = c.id_gti 
								and d.id_detail = c.id_detail ) 
								, 103),
							 '' )
				Else IsNull ( Convert ( VarChar ( 10 ) , @dtDateAchat , 103), '' )
			End,
		@sInfo_spb_frn_cplt = rtrim ( lTrim ( c.info_spb_frn_cplt ))

From sysadm.commande c with ( nolock ) -- [DBG]
Where c.id_sin = @adcIdsin
And   c.id_seq = @aiIdSeq


Select 
	@aiCas	'iCas',
	@iIdSin	'iIdSin',
	@aiIdSeq	'iIdSeq',
	@sIdHubPresta	'sIdHubPresta',
	@sIdFour	'sIdFour',
	@sTypDommage	'sTypDommage',
	@sPointService	'sPointService',
	@sModeProcess	'sModeProcess',
	@sCodePickUp	'sCodePickUp',
	@sAdrNomPickUp	'sAdrNomPickUp',
	@sAdrReferenceAssPickUp	'sAdrReferenceAssPickUp',
	@sAdr1PickUp	'sAdr1PickUp',
	@sAdr2PickUp	'sAdr2PickUp',
	@sAdrCpltPickUp	'sAdrCpltPickUp',
	@sAdrCpPickUp	'sAdrCpPickUp',
	@sAdrVillePickUp	'sAdrVillePickUp',
	@iCodeProcess	'iCodeProcess',
	@sLibCodeProcess	'sLibCodeProcess',
	@iIdGti	'iIdGti',
	@sLibPersoGti	'sLibPersoGti',
	@iIdDetail	'iIdDetail',
	@iIdProd	'iIdProd',
	@sLibProd	'sLibProd',
	@sIdProdAdh	'sIdProdAdh',
	@iIdEts	'iIdEts',
	@sIdAdh	'sIdAdh',
	@iIdSdos	'iIdSdos',
	@sIdTypArt	'sIdTypArt',
	@iCodCivLivr	'iCodCivLivr',
	@sLibCivLivrCourt	'sLibCivLivrCourt',
	@sLibCivLivrLong	'sLibCivLivrLong',
	@IdContratAbonne	'IdContratAbonne',
	@NomAss	'NomAss',
	@PrenomAss	'PrenomAss',
	@NomLivr	'NomLivr',
	@PrenomLivr	'PrenomLivr',
	@sAdr1Livr	'sAdr1Livr',
	@sAdr2Livr	'sAdr2Livr',
	@sAdr3Livr	'sAdr3Livr',
	@sAdrCpLivr	'sAdrCpLivr',
	@sAdrVilleLivr	'sAdrVilleLivr',
	@sNumTel1Ass	'sNumTel1Ass',
	@sNumTel2Ass	'sNumTel2Ass',
	@sNumTel3Ass	'sNumTel3Ass',
	@sMailAssure	'sMailAssure',
	@sNumImeiAppSin	'sNumImeiAppSin',
	@sNumSerieAppSin	'sNumSerieAppSin',
	@sDescriptionProbleme	'sDescriptionProbleme',
	@sCodEtat	'sCodEtat',
	@dtValideLe	'dtValideLe',
	@sValidePar	'sValidePar',
	@dtCmdGenLe	'dtCmdGenLe',
	@sIdRefFour	'sIdRefFour',
	@sOrdreAction	'sOrdreAction',
	@iIdAssureur	'iIdAssureur',
	@sLibAssureur	'sLibAssureur',
	@sLibPolice	'sLibPolice',
	@sTypAppSin	'sTypAppSin',
	@sLibTypAppSin	'sLibTypAppSin',
	@sMarqAppSin	'sMarqAppSin',
	@sModlAppSin	'sModlAppSin',
	@sRefAppSin	'sRefAppSin',
	@sNumTelSin	'sNumTelSin',
	@mtValAchat	'mtValAchat',
	@mtPriseEnCharge	'mtPriseEnCharge',
	@dtDateAchat	'dtDateAchat',
	@sEtatAppSin	'sEtatAppSin',
	@sCodeVerrou	'sCodeVerrou',
	@sDesimlocke	'sDesimlocke',
	@sInfo_spb_frn_cplt	'sInfo_spb_frn_cplt'

Go


-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_U_S2_MAJ_GEN_PRESTA
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Mets à jour la prestation sur SIMPA2
--                              /!\ A COMPILER SUR LA BASE SIMPA2 /!\
--
-- Retourne             :       rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_U_S2_MAJ_GEN_PRESTA' AND type = 'P' )
        DROP procedure sysadm.PS_HP276_U_S2_MAJ_GEN_PRESTA
GO

CREATE procedure sysadm.PS_HP276_U_S2_MAJ_GEN_PRESTA
		@adcIdSin				Decimal ( 10 ),
		@alIdSeq				Integer,
		@alIdentityHubPresta	Integer

AS

Update	sysadm.commande 
Set		id_lot_cmd  = 999800, 
		cmd_gen_le = GETDATE(), 
		cmd_gen_par = 'HUB',
		info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'HP_IDENTITY', convert ( VarChar ( 20) , @alIdentityHubPresta ), RTRIM ( ltrim ( info_spb_frn_cplt )), ';')
Where   id_sin = @adcIdSin
And		id_seq = @alIdSeq

Update	sysadm.w_commande 
Set		info_spb_frn_cplt = sysadm.FN_CLE_VAL_E ( 'HP_IDENTITY', convert ( VarChar ( 20) , @alIdentityHubPresta ), RTRIM ( ltrim ( info_spb_frn_cplt )), ';')
Where   id_sin = @adcIdSin
And		id_seq = @alIdSeq

Go


-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_SU_S2_MOTEUR_TRT_RETOUR_HUB
-- Auteur               :       JFF
-- Date                 :       24/04/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Mets à jour la prestation sur SIMPA2 en retour du HUB
--                              /!\ A COMPILER SUR LA BASE SIMPA2 /!\
--
-- Retourne             :       rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_SU_S2_MOTEUR_TRT_RETOUR_HUB' AND type = 'P' )
        DROP procedure sysadm.PS_HP276_SU_S2_MOTEUR_TRT_RETOUR_HUB
GO

CREATE procedure sysadm.PS_HP276_SU_S2_MOTEUR_TRT_RETOUR_HUB
AS

If NOT ( sysadm.FN_CLE_NUMERIQUE ( 'HP252_276_HUB_PRESTA') > 0 ) Return -- Moteur coupé
 
Declare  @TbFourn TABLE (
	id_work						int IDENTITY (1,1)			NOT NULL, -- Id Local Tempo
	marquage					int							Null,
	id_four						VarChar ( 3 )				NULL,
	id_work_row_min				int							Null,
	id_work_row_max				int							Null
)

Declare  @TbHubToSimpa2Work TABLE (
	id_work						int IDENTITY (1,1)			NOT NULL, -- Id Local Tempo
	marquage					int							Null,
	id_depot_hub				int							NOT NULL, -- Identifiant non modifiable de dépot, contrôle des trou/blanc si Delete Malveillant
	depose_le					DateTime					NULL,	-- Enregistrement déposé par Simpa2 le 
	id_sin						Decimal ( 10 )				NULL,  
	id_seq						int							NULL,  
	id_four						VarChar ( 3 )				NULL,
	ordre_action				VarChar ( 20 )				NULL,
	id_hub_presta				VarChar ( 20 )			NOT NULL,   -- Identifiant sur le Hub Prestataire de la prestation
	num_cmd_frn					VarChar ( 50 )				NULL,   -- Numéro de la prestation chez le prestataire
	activity_code				VarChar ( 50 )				NULL,   -- Code HUB
	activity_return_code		Varchar ( 50 )				NULL,	-- Code HUB
	activity_reason_code		Varchar ( 50 )				NULL,	-- Code HUB
	typ_ba_aller				Varchar ( 35 )				NULL,	-- RPICKUP ou BPPAYE, voire de nouveaux CODE
	perte_aller					VarChar ( 1  )				NULL,   -- O/N Perte du colis à l'aller
	diag_video_engage			VarChar ( 1  )				NULL,   -- O/N Diag vidéo engagé
	resolu_diag_video			VarChar ( 1  )				NULL,   -- O/N résolu par Diag vidéo 
	dte_rdv_conf				DateTime					NULL,   -- Date de rdv confirmé pour déplacement à domicile 
	mode_logis_ret				VarChar ( 20 )				NULL,   -- CENTRALISATION / PROXIMITE, Confirmation du prestataire sur le mode rééllement utilisé par l'assuré
	point_service_ret			VarChar ( 20 )				NULL,   -- Code du point de service où l'assuré s'est rééllement rendu ou bien a envoyé son appareil
	dte_rcp_frn					DateTime					NULL,   -- Date de réception de l'appareil chez le prestataire
	site_action					VarChar ( 20 )				NULL,   -- STATION/DOMICILE
	app_incomplet				VarChar ( 1  )				NULL,   -- O/N si appareil incomplet
	dte_fin_trait				DateTime					NULL,   -- Date de fin de traitement/Date d'envoi colis retour vers assuré
	comment_frn					VarChar ( 255 )				NULL,   -- Commentaire fournisseur
	num_bon_trp					VarChar ( 35 )				NULL,   -- Numéro de colis retour 
	nom_transporteur			VarChar ( 35 )				NULL,   -- NOm du transporteur
	dte_rcp_app_cli				DateTime					NULL,   -- Date de réception de l'appareil par l'assuré
	app_swap					VarChar ( 1  )				NULL,   -- O/N swap sur réparation (app irrep couvert et le presta redonne auto un app de rempl)
	autres_infos_rempl			VarChar ( 40 )              NULL,   -- COULEUR ou CAPACITE ou COULEUR_ET_CAPACITE, incohérent si ref_app_rempl = IFR
	marque_rempl				VarChar ( 35 )				NULL,   -- Marque de remplacement (sur SWAP ou Cmde Manuelle)
	modele_rempl				VarChar ( 35 )				NULL,   -- Modele de remplacement (sur SWAP ou Cmde Manuelle)
	num_imei_rempl				VarChar ( 20 )				NULL,	-- Numéro IMEI de remplacement (pour TEL)
	num_serie_rempl				VarChar ( 60 )				NULL,	-- Numéro SERIE de remplacement (pour autre que TEL)
	couleur_rempl				VarChar ( 35 )				NULL,   -- Couleur de remplacement (sur SWAP ou Cmde Manuelle)
	cap_stk_rempl				VarChar ( 35 )				NULL,   -- Capacité de stockage de remplacement (sur SWAP ou Cmde Manuelle)
	neuf_recond_rempl			VarChar ( 10 )				NULL,	-- NEU/REC app de remplacement (sur SWAP ou Cmde Manuelle) Neuf ou Reconditionné
	prix_ttc_public				Decimal ( 11, 2 )			NULL,   -- Prix TTC de l'app de remplacement qui sera facturé par le prestataire et réglé par spb
	prble_livraison				VarChar ( 35 )				NULL,   -- après une dte_fin_trait renseigné, Code du problème de livraison
	pec_prble_livraison			VarChar ( 1  )				NULL,   -- O/N OUI si le presta prend la prble de livrasion à sa charge
	id_hub_presta_sav           VarChar ( 20 )			    NULL,   -- Identifiant sur le Hub Prestataire de la future prestation de SAV à venir
	info_frn_spb_cplt			VarChar ( 800 )				NULL    -- Chaine sérialisée contenant de multiples informations pour de nouvelles données "exotiques" liées à un prestataire précis.
)

Declare @sInstanceHub		VarChar ( 100 ) 
Declare @sSql				Varchar ( 2000 )
Declare @sEnv				VarChar ( 10 )
Declare @iIdLotTrc			Int
Declare @iRowCountData		Int	
Declare	@iIdWorkFrn			Int
Declare	@iAMUerrRowTrt		Int
Declare	@iAMUerrFrn			Int
Declare	@iAMUerrGen			Int
Declare	@iAMUunRowEcrFrn	Int
Declare	@idWorkRowMin		Int
Declare	@idWorkRowMax		Int
Declare	@iCptIdWorkRow		Int
Declare	@sChaineIdFour		Varchar ( 250 )
Declare	@iHandleObjet		Int 
Declare @sDestErrTech  VarChar ( 200 ) 
Declare @sDestErrCoherenceHub  VarChar ( 200 ) 
Declare @sMailBody VarChar ( 8000 )
Declare @sObjet VarChar ( 255 ) 
Declare @sMsgTrc varchar ( 255 ) 
Declare @sRetourErrMail VarChar ( 255 )
Declare @sFicOut VarChar ( 255 )
Declare @sDateHeureDebTrt VarChar ( 30 )
Declare @iRet Int
Declare @sCheminDepotFichierMPRRacine VarChar ( 255 )
Declare @sCheminDepotFichierMPRFrn VarChar ( 255 )
Declare @sInfoFrnSpbCpltCree VarChar ( 800 )
Declare @sEnregistrementFicMPR VarChar ( max )
Declare @sSepChampsFicMPR VarChar ( 10 )
Declare @iStatusGC Int
Declare @sDestCc VarChar ( 200 )
Declare @sNomFicMPRwork VarChar ( 255 ) 
Declare @sChemFicWork VarChar ( 255 ) 
Declare @iCptIndice Int
Declare @iFileExists Int
Declare @iAMUenrMarqBase Int
Declare @iError Int
Declare @sChaineBCVretourDetStatut VarChar ( 255 ) 

Set @iAMUerrRowTrt = 0 
Set @iAMUunRowEcrFrn = 0
Set @iAMUerrFrn = 0
Set @iAMUerrGen = 0
Set @sInfoFrnSpbCpltCree = ''
Set @sEnregistrementFicMPR = ''
Set @sSepChampsFicMPR = CHAR ( 9 ) -- Tabulation

Declare @iIdWorkRow			int,
		@iIdDepotHub		int,
		@dtDeposeLe			DateTime,
		@dcIdSin			Decimal ( 10 ),
		@iIdSeq				int,
		@sIdFour			VarChar ( 10 ),
		@sOrdreAction		VarChar ( 20 ),
		@sIdHubPresta		VarChar ( 20 ),
		@sNumCmdFrn			VarChar ( 50 ),
		@sActivityCode		VarChar ( 50 ),
		@sActivityReturnCode Varchar ( 50 ),
		@sActivityReasonCode Varchar ( 50 ),
		@sTypBaAller		Varchar ( 35 ),
		@sPerteAller		VarChar ( 1  ),
		@sDiagVideoEngage	VarChar ( 1  ),
		@sResoluDiagVideo	VarChar ( 1  ),
		@dtDteRdvConf		DateTime,
		@sModeLogisRet		VarChar ( 20 ),
		@sPointServiceRet	VarChar ( 20 ),
		@dtDteRcpFrn		DateTime,
		@sSiteAction		VarChar ( 20 ),
		@sAppIncomplet		VarChar ( 1  ),
		@dtDteFinTrait		DateTime,
		@sCommentFrn		VarChar ( 255 ),
		@sNumBonTrp			VarChar ( 35 ),
		@sNomTransporteur	VarChar ( 35 ),
		@dtDteRcpAppCli		DateTime,
		@sAppSwap			VarChar ( 1  ),
		@sAutresInfosRempl	VarChar ( 40 ),
		@sMarqueRempl		VarChar ( 35 ),
		@sModeleRempl		VarChar ( 35 ),
		@sNumImeiRempl		VarChar ( 20 ),
		@sNumSerieRempl		VarChar ( 60 ),
		@sCouleurRempl		VarChar ( 35 ),
		@sCapStkRempl		VarChar ( 35 ),
		@sNeufRecondRempl	VarChar ( 10 ),
		@dcPrixTtcRempl		Decimal ( 11, 2 ),
		@sPrbleLivraison	VarChar ( 35 ),
		@sPecPrbleLivraison	VarChar ( 1  ),
		@sIdHubPrestaSav	VarChar ( 20 ),
		@sInfoFrnSpbCpltlu	VarChar ( 800 )

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO' Set @sEnv = 'PROD' ELSE Set @sEnv = 'SIM'

---------------------------------
-- Initialisation de la Trace  --
---------------------------------
If @sEnv = 'PROD'
	Begin 
		Set @sInstanceHub = '[LS-SAGA2].[PRESTATAIRE].'
		Set @sCheminDepotFichierMPRRacine  = '\\F4T\SIMPA2\'
		Exec [LS-SAGA2].[PRESTATAIRE].edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 'OBTENTION_ID_LOT_TRC', '-1', -1, '-1', '', '', @iIdLotTrc output
		Set @sDestErrTech = 'cbourdoiseau@spb.eu,cfrappat@spb.eu,VANDRE@spb.eu,BKHELIFA_ext@spb.eu,OCHAOUACHI@spb.eu'
		Set @sDestErrCoherenceHub = 'VANDRE@spb.eu,BKHELIFA_ext@spb.eu,OCHAOUACHI@spb.eu'
		Set @sDestCc = 'jff@spb.fr'
	End 
Else
	Begin 
		Set @sInstanceHub = '[S2SQL14PP1\PPRSAGA2].[PRESTATAIRE].'
		Set @sCheminDepotFichierMPRRacine  = '\\SPB.LAN\APPLIS\SPB\RECCMD\'
		Exec [S2SQL14PP1\PPRSAGA2].[PRESTATAIRE].edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 'OBTENTION_ID_LOT_TRC', '-1', -1, '-1', '', '', @iIdLotTrc output
		Set @sDestErrTech = 'jff@spb.fr'
		Set @sDestErrCoherenceHub = 'jff@spb.fr'
		Set @sDestCc = 'jff@spb.fr'
	End

Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''-1'', -1, ''-1'', ''OK'', '''+ 
			'Lancement du traitement le ' + Convert ( VarChar ( 10), Getdate(), 103 ) + ' à ' + CONVERT (varchar(8), getdate(), 108) + 
			''', ' + Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )


Set @sDateHeureDebTrt = Convert ( varchar ( 10 ), GETDATE(), 112 ) + ' ' + Left ( Convert ( varchar ( 30 ), GETDATE(), 114 ), 6 ) + '00'

-------------------------------
-- Récupération des données  --
-------------------------------
Set @sSql = 
'Select ' + 
'		0, '+
'		dhs.id_depot_hub, '+
'		dhs.depose_le, '+
'		dsh.id_sin, '+
'		dsh.id_seq, '+
'		dsh.id_four, '+
'		dsh.ordre_action, ' +
'		dhs.id_hub_presta, '+
'		dhs.num_cmd_frn, '+
'		dhs.activity_code, '+
'		dhs.activity_return_code, '+
'		dhs.activity_reason_code, '+
'		Case ' +
'			When dsh.mode_logis = ''CENTRALISATION'' and code_pickup is not null ' +
'				Then ''RPICKUP''' +
'			When dsh.mode_logis = ''CENTRALISATION'' and code_pickup is null ' +
'				Then ''BPPAYE''' +
'			Else null ' + 
'		End typ_ba_aller, ' +	
'		dhs.perte_aller, '+
'		dhs.diag_video_engage, '+
'		dhs.resolu_diag_video, '+
'		dhs.dte_rdv_conf, '+
'		dhs.mode_logis_ret, '+
'		dhs.point_service_ret, '+
'		dhs.dte_rcp_frn, '+
'		dhs.site_action, '+
'		dhs.app_incomplet, '+
'		dhs.dte_fin_trait, '+
'		dhs.comment_frn, '+
'		dhs.num_bon_trp, '+
'		dhs.nom_transporteur, '+
'		dhs.dte_rcp_app_cli, '+
'		dhs.app_swap, '+
'		dhs.autres_infos_rempl, '+
'		dhs.marque_rempl, '+
'		dhs.modele_rempl, '+
'		dhs.num_imei_rempl, '+
'		dhs.num_serie_rempl, '+
'		dhs.couleur_rempl, '+
'		dhs.cap_stk_rempl, '+
'		dhs.neuf_recond_rempl, '+
'		dhs.prix_ttc_rempl, '+
'		dhs.prble_livraison, '+
'		dhs.pec_prble_livraison, '+
'		dhs.id_hub_presta_sav, '+
'		dhs.info_frn_spb_cplt '+
'From	' + @sInstanceHub + 'edi.DepotHubToSimpa2Presta dhs ' + 
'		Left Outer Join ' + @sInstanceHub + 'edi.DepotSimpa2ToHubPresta dsh on dhs.id_hub_presta = dsh.id_hub_presta ' +
'Where   dhs.alt_trt = ''N'' ' +
'Order by dsh.id_four, dhs.depose_le ' -- Tri extrêmement important, ne jamais le changer, le reste ne fonctionnerait plus.

Insert into @TbHubToSimpa2Work Exec ( @sSql )
Set @iRowCountData = @@ROWCOUNT


Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''-1'', -1, ''-1'', ''OK'', ''' + 
			'Récupération par SIMPA2 de ' + Convert ( Varchar ( 20 ), @iRowCountData  ) + ' enregistrement(s) de suivi/retour provenant du HUB.' +
			''', ' + Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )

---------------------------------------
-- Pas de données, fin de traitement --
---------------------------------------
IF @iRowCountData <= 0 
	Begin
		Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''-1'', -1, ''-1'', ''OK'', ''' +
		'Fin du traitement le ' + Convert ( VarChar ( 10), Getdate(), 103 ) + ' à ' + CONVERT (varchar(8), getdate(), 108) + 
		''', ' + Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )
		Return 
	End 

--------------------------------------
-- Récup distinct des frn concernés --
--------------------------------------
Insert into @TbFourn 
Select Distinct 
		0, 
		ltrim ( rtrim ( T1.id_four)),
		IsNull ( ( Select MIN ( id_work ) From @TbHubToSimpa2Work T2 where T2.id_four = T1.id_four ) , 0 ),
		IsNull ( ( Select MAX ( id_work ) From @TbHubToSimpa2Work T2 where T2.id_four = T1.id_four ) , 0 )
From @TbHubToSimpa2Work T1

Set @iRowCountData = @@ROWCOUNT

If @iRowCountData > 0 
	Begin
		Select @sChaineIdFour = Stuff ( ( SELECT ', ' + CAST(rtrim ( id_four)  AS VARCHAR(250)) FROM @TbFourn For XML PATH ('') ) , 1, 2, '' )
		Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''-1'', -1, ''-1'', ''OK'', ''' + 
		Convert ( Varchar ( 20 ), @iRowCountData  ) + ' Prestataire(s) concerné(s) : ' + @sChaineIdFour + 
		''', ' + Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )
	End 

---------------------------
-- Moteur de traitement  --
---------------------------
Exec @iHandleObjet = sysadm.PS_INSTANCIER_UN_OBJET_SQL_SERVER 'ADODB.Stream'

-- Traitement d'une Erreur pontentiel d'instanciation
If @iHandleObjet < 0 
	Begin
		Set @iAMUerrGen = 1 

		Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''-1'', -1, ''-1'', ''ERR'', ''' +
		'Erreur lors de l''''instanciation de l''''objet SqlServer ADODB.Stream, le traitement est arrêté à ' + Convert ( VarChar ( 10), Getdate(), 103 ) + ' à ' + CONVERT (varchar(8), getdate(), 108) + 
		''', ' + Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )

		Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''-1'', -1, ''-1'', ''' + IIF ( @iAMUerrGen =1, 'ERR', 'OK') + ''', ''' +
		'Fin du traitement ' + IIF ( @iAMUerrGen =1, ' avec ERREUR ', '' ) + 'le ' + Convert ( VarChar ( 10), Getdate(), 103 ) + ' à ' + CONVERT (varchar(8), getdate(), 108) + 
		''', ' + Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )
		
		Set @sObjet = '[ALERTE][Traitement SIMPA2 HUB PRESTATAIRE] => Instanciation objet ADODB.Stream impossible'

		Set @sObjet = Left ( @sObjet + space ( 255 ), 255 )
		Exec sysadm.PS_CASSER_REGLE_CHAINE @sObjet Output, '_', ' ' 

		Set @sMailBody = 'Bonjour ' + char (10)
		Set @sMailBody = @sMailBody + char (10)
		Set @sMailBody = @sMailBody + 'Serveur : ' + @@SERVERNAME 
		If @@SERVERNAME = 'SQL14SINISTRES\SINISTRES' Set @sMailBody = @sMailBody + ' (Alias [LS-SINISTRES])' + char (10)		
		Set @sMailBody = @sMailBody + 'base SIMPA2 : ' + DB_NAME () + char (10)
		Set @sMailBody = @sMailBody + 'Instance et base HUB PRESTATAIRE : ' + @sInstanceHub + char (10)
		Set @sMailBody = @sMailBody + char (10)
		Set @sMailBody = @sMailBody + 'Contexte de l''erreur : L''objet SqlServer ADODB.Stream ne peut plus s''intancier, la conséquence est que les retours de prestations du Hub Prestataires ne peuvent plus traités par SIMPA2.' + char (10)
		Set @sMailBody = @sMailBody + char (10)
		Set @sMailBody = @sMailBody + 'Une des causes possibles :' + char (10)
		Set @sMailBody = @sMailBody + '- Une soirée patch la veille a pu faire sauter le droit d''instanciation de cet objet OLE SqlServer lors d''un reboot du serveur qui s''est mal terminé (par exemple).' + char (10)
		Set @sMailBody = @sMailBody + '  Le code suivant peut rétablir ce droit, à jouer par INFRA.' + char (10)
		Set @sMailBody = @sMailBody + '    exec sp_configure ''Ole Automation Procedures'', 1 ' + char (10)
		Set @sMailBody = @sMailBody + '    RECONFIGURE' + char (10)
		Set @sMailBody = @sMailBody + char (10)
		Set @sMailBody = @sMailBody + 'Vérifier l''action en jouant : '+ char (10)
		Set @sMailBody = @sMailBody + 'exec sp_configure ''Ole Automation Procedures'''+ char (10)
		Set @sMailBody = @sMailBody + 'la valeur config_value doit être à 1 (activée) à présent' + char (10)
		Set @sMailBody = @sMailBody + CHAR ( 10 )
		Set @sMailBody = @sMailBody + '- Sinon vérifiez les actions SQL récemment engagées par l''équipe INFRA sur ' + @@Servername  
		If @@SERVERNAME = 'SQL14SINISTRES\SINISTRES' Set @sMailBody = @sMailBody + ' (Alias [LS-SINISTRES])'
		Set @sMailBody = @sMailBody + ' .' + CHAR ( 10 )
		Set @sMailBody = @sMailBody + '  Consultez la trace du traitement avec ces 2 Select pour voir depuis quand le problème se produit ' + CHAR ( 10 )
		Set @sMailBody = @sMailBody + CHAR ( 10 )
		Set @sMailBody = @sMailBody + '  Select * from ' + @sInstanceHub + 'edi.TraceRecupRetourParSimpa2  where cod_etat = ''ERR'' and cree_le > ''' + @sDateHeureDebTrt + ''' order by 1' + CHAR ( 10 )
		Set @sMailBody = @sMailBody + '  Select * from ' + @sInstanceHub + 'edi.TraceRecupRetourParSimpa2  where cree_le > ''' + @sDateHeureDebTrt + ''' order by 1 desc' + CHAR ( 10 )
		Set @sMailBody = @sMailBody + CHAR ( 10 )
		Set @sMailBody = @sMailBody + 'L''alerte reviendra au prochain traitement tant que le problème ne sera pas résolu.' + CHAR ( 10 )
		Set @sMailBody = @sMailBody + CHAR ( 10 )
		Set @sMailBody = @sMailBody + 'Cordialement,'
		Set @sMailBody = @sMailBody + CHAR ( 10 )
		Set @sMailBody = @sMailBody + CHAR ( 10 )
		Set @sMailBody = @sMailBody + 'Fabry Jean-François'
		Set @sMailBody = @sMailBody + CHAR ( 10 )
		Set @sMailBody = @sMailBody + 'DSI Team SIMPA2' + CHAR ( 10 )
		Set @sMailBody = @sMailBody + 'Legacy Application Tech Lead' + CHAR ( 10 )


		EXEC master.dbo.SPB_PS_MAIL 
				@sRetourErrMail OUTPUT, 
				@sDestErrTech ,
				@sMailBody, 
				@sObjet, 
				null, 
				@sDestCc, 
				@sFicOut, 
				NULL, 
				NULL, 
				NULL, 
				NULL

		Return
	End 

-- Pour tout fournisseur....
While Exists ( Select Top 1 1 From @TbFourn where marquage = 0 )
 Begin
	Select Top 1 
		@iIdWorkFrn = id_work,
		@sIdFour	= id_four,
		@idWorkRowMin = id_work_row_min,
		@idWorkRowMax = id_work_row_max
	From  @TbFourn where marquage = 0

	Set @iAMUerrFrn = 0
	Set @iAMUunRowEcrFrn = 0
	Set @iCptIdWorkRow = @idWorkRowMin


	-- Le code fournisseur existe-t-il sur SIMPA2 ?
	If Not Exists ( 
			Select Top 1 1 
			From sysadm.code_car cc
			Where cc.id_typ_code = '-FR'
			And   cc.id_code = @sIdFour
		)
		Begin
			Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''' + ISNULL ( @sIdFour, '(vide)') + ''', -1, ''-1'', ''ERR'', ''' + 
			'Le code fournisseur ' + ISNULL ( @sIdFour, '(vide)') + ' donné par le Hub Prestataire n''''existe pas sur SIMPA2 (-FR).' + ''', ' + 
			Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )

			Set @iAMUerrFrn = 1
			Set @iAMUerrGen = 1
			Update @TbFourn Set marquage = -1 Where id_work = @iIdWorkFrn			
			Continue
		End 

	-- Le nom du répertoire fournisseur existe-t-il sur SIMPA2 ?
	If Not Exists ( 
			Select Top 1 1 
			From sysadm.code_car cc
			Where cc.id_typ_code = '-FL'
			And   cc.id_code = @sIdFour
		)
		Begin
			Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''' + ISNULL ( @sIdFour, '(vide)') + ''', -1, ''-1'', ''ERR'', ''' + 
			'Le répertoire du fournisseur ' + ISNULL ( @sIdFour, '(vide)') + ' n''''existe pas sur SIMPA2 (-FL).' + ''', ' + 
			Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )

			Set @iAMUerrFrn = 1
			Set @iAMUerrGen = 1
			Update @TbFourn Set marquage = -1 Where id_work = @iIdWorkFrn			
			Continue
		End 

	-- Construction du chemin de dépôt
	Select @sCheminDepotFichierMPRFrn = @sCheminDepotFichierMPRRacine + LTRIM ( rtrim ( cc.lib_code )) + '\fic_mov\'
	From sysadm.code_car cc
	Where cc.id_typ_code = '-FL'
	And   cc.id_code = @sIdFour

	-- Compléter le chemin avec le nom du fichier MPR
	Set @iCptIndice = 1
	While 1=1
		Begin
			Set @sNomFicMPRwork = 'MPR' + Replace ( Convert ( Varchar ( 10 ), Getdate (), 103 ), '/', '') + '.' + Right ( REPLICATE ( '0', 3 ) + CONVERT ( VarChar ( 3 ), @iCptIndice ), 3 )
			Set @sChemFicWork = @sCheminDepotFichierMPRFrn + @sNomFicMPRwork
			
			EXECUTE xp_fileexist @sChemFicWork, @iFileExists OUTPUT
			
			If @iFileExists > 0 
				Begin 
					Set @iCptIndice = @iCptIndice + 1
					Continue
				End 

			Set @sCheminDepotFichierMPRFrn = @sCheminDepotFichierMPRFrn + @sNomFicMPRwork
			Break
		End 

	-- Ouverture du fichier de charset ISO-8859-1
	Exec sysadm.PS_FERMER_UN_FICHER_ADODB_STREAM @iHandleObjet -- Fermeture d'un précédent fichier pour être sûr
	Exec @iRet = sysadm.PS_ECRIRE_UN_ENREGISTREMENT_ADODB_STREAM_V03 @iHandleObjet, 1, 0, 2, 3, 'ISO-8859-1', 13, null, null

	If @iRet <> 0 
		Begin
			Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''' + ISNULL ( @sIdFour, '(vide)') + ''', -1, ''-1'', ''ERR'', ''' + 
			'Erreur lors de l''''ouverture/création (open) du fichier (' + IsNull ( @sIdFour, '(vide)') + '), Handle objet ' + CONVERT ( Varchar ( 20 ), @iHandleObjet ) +'.' + 
			''', ' +  Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )

			Set @iAMUerrFrn = 1
			Set @iAMUerrGen = 1
			Update @TbFourn Set marquage = -1 Where id_work = @iIdWorkFrn			
			Continue
		End 

	-- Pour tout enregistrement de ce fournisseur
	While Exists ( Select Top 1 1 From @TbHubToSimpa2Work where marquage = 0 And id_four = @sIdFour And @iCptIdWorkRow between @idWorkRowMin and @idWorkRowMax )
	 Begin
		Set @iAMUerrRowTrt = 0

		Select 	Top 1 
			@iIdWorkRow = id_work,
			@iIdDepotHub = id_depot_hub,
			@dtDeposeLe = depose_le,
			@dcIdSin = id_sin,
			@iIdSeq = id_seq,
			@sOrdreAction = ltrim ( rtrim ( ordre_action )),
			@sIdHubPresta = ltrim ( rtrim ( id_hub_presta )),
			@sNumCmdFrn = ltrim ( rtrim ( num_cmd_frn )),
			@sActivityCode = ltrim ( rtrim ( activity_code )),
			@sActivityReturnCode = ltrim ( rtrim ( activity_return_code )),
			@sActivityReasonCode = ltrim ( rtrim ( activity_reason_code )),
			@sTypBaAller = ltrim ( rtrim ( typ_ba_aller )),
			@sPerteAller = ltrim ( rtrim ( perte_aller )),
			@sDiagVideoEngage = ltrim ( rtrim ( diag_video_engage )),
			@sResoluDiagVideo = ltrim ( rtrim ( resolu_diag_video )),
			@dtDteRdvConf = dte_rdv_conf,
			@sModeLogisRet = ltrim ( rtrim ( mode_logis_ret )),
			@sPointServiceRet = ltrim ( rtrim ( point_service_ret )),
			@dtDteRcpFrn = dte_rcp_frn,
			@sSiteAction = ltrim ( rtrim ( site_action )),
			@sAppIncomplet = ltrim ( rtrim ( app_incomplet )),
			@dtDteFinTrait = dte_fin_trait,
			@sCommentFrn = ltrim ( rtrim ( comment_frn )),
			@sNumBonTrp = ltrim ( rtrim ( num_bon_trp )),
			@sNomTransporteur = ltrim ( rtrim ( nom_transporteur )),
			@dtDteRcpAppCli = dte_rcp_app_cli,
			@sAppSwap = ltrim ( rtrim ( app_swap )),
			@sAutresInfosRempl = ltrim ( rtrim ( autres_infos_rempl )),
			@sMarqueRempl = ltrim ( rtrim ( marque_rempl )),
			@sModeleRempl = ltrim ( rtrim ( modele_rempl )),
			@sNumImeiRempl = ltrim ( rtrim ( num_imei_rempl )),
			@sNumSerieRempl = ltrim ( rtrim ( num_serie_rempl )),
			@sCouleurRempl = ltrim ( rtrim ( couleur_rempl )),
			@sCapStkRempl = ltrim ( rtrim ( cap_stk_rempl )),
			@sNeufRecondRempl = ltrim ( rtrim ( neuf_recond_rempl )),
			@dcPrixTtcRempl = prix_ttc_public,
			@sPrbleLivraison = ltrim ( rtrim ( prble_livraison )),
			@sPecPrbleLivraison = ltrim ( rtrim ( pec_prble_livraison )),
			@sInfoFrnSpbCpltlu = ltrim ( rtrim ( info_frn_spb_cplt ))
		From	@TbHubToSimpa2Work
		Where	marquage = 0
		And		id_work = @iCptIdWorkRow

		------------------------------------
		-- Contrôle principal des données --
		------------------------------------
		While 1=1
			Begin
				-- Le binôme id_sin/id_seq existe-il sur SIMPA2 ?
				If Not Exists ( 
						Select Top 1 1 
						From sysadm.commande c
						Where c.id_sin = @dcIdSin
						And   c.id_seq = @iIdSeq
					) And @iAMUerrRowTrt = 0
					Begin
						Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''' + ISNULL ( @sIdFour, '(vide)') + ''', ' + Convert ( VarChar (20), @iIdDepotHub) + ', ''' + @sIdHubPresta + ''', ''ERR'', ''' + 
						'La prestation ' + IsNull ( Convert ( Varchar ( 10 ), @dcIdSin ), '(vide)') + '-' + IsNull ( Convert ( Varchar ( 10 ), @iIdSeq ), '(vide)' ) + ' n''''existe pas sur SIMPA2 ( IdHubPresta=' + IsNull ( Convert ( Varchar ( 10 ), @sIdHubPresta ), '(vide) )') + ' ).' + 
						''', ' + Convert ( VarChar ( 20 ), @iIdLotTrc ); Exec ( @sSql )

						Set @iAMUerrRowTrt = 1
						Set @iAMUerrGen = 1
						Break
					End 

				-- Transformation données
					-- Le numéro de commande fournisseur fait 20 sur SIMPA2 et 50 sur le Hub
				If Len ( @sNumCmdFrn ) > 20 Set @sNumCmdFrn = LEFT ( @sNumCmdFrn, 17 ) + '...'
					
					-- mode_log_ret
				If UPPER ( @sModeLogisRet ) = 'PROXIMITY' Set @sModeLogisRet = 'PROXIMITE'
				If UPPER ( @sPointServiceRet ) = 'CENTRALIZATION' Set @sPointServiceRet = 'CENTRALISATION'

				-- Détermination du statut SIMPA2 de la prestation
				Set @sChaineBCVretourDetStatut = SPACE ( 255 )
				Set @sChaineBCVretourDetStatut = sysadm.FN_CLE_VAL_E ( 'TYP_BA_ALLER', Upper ( @sTypBaAller ), @sChaineBCVretourDetStatut, ';' ) 
				Set @sCommentFrn = Left ( ISNULL ( @sCommentFrn, '' ) + SPACE ( 255 ), 255)

				Exec @iRet = sysadm.PS_HP276_SU_S2_MOTEUR_TRT_RETOUR_HUB_DETERMINATION_STATUT 
								@sActivityCode, 
								@sActivityReturnCode, 
								@sActivityReasonCode,
								@sOrdreAction,
								@sInstanceHub,
								@iIdDepotHub,
								@sCommentFrn OutPut,
								@sChaineBCVretourDetStatut OutPut

				If @iRet <= 0 -- Au minimum 159 ou un statut 'en cours à créer' si non existant
					Begin
						Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''' + ISNULL ( @sIdFour, '(vide)') + ''', ' + Convert ( VarChar (20), @iIdDepotHub) + ', ''' + @sIdHubPresta + ''', ''ERR'', ''' + 
									'Les 3 données @sActivityCode, @sActivityReturnCode, @sActivityReasonCode ne permettent pas de déterminer/mapper un statut pour la prestation SIMPA2.' +
									''', ' + Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )

						Set @iAMUerrRowTrt = 1
						Set @iAMUerrGen = 1
						Break
					End 

				Set @iStatusGC = convert ( Integer, sysadm.FN_CLE_VAL ( 'STATUS_GC', @sChaineBCVretourDetStatut, ';' ))
				If @iStatusGC IS NULL Set @iStatusGC = 0 

				Set @sCommentFrn = ltrim ( sysadm.FN_CLE_VAL ( 'MOT_CLE_CPLT', @sChaineBCVretourDetStatut, ';' ) + ' ' + @sCommentFrn )
				
				Set @sPerteAller = sysadm.FN_CLE_VAL ( 'PERTE_ALLER', @sChaineBCVretourDetStatut, ';' )
				Set @sPrbleLivraison = sysadm.FN_CLE_VAL ( 'PRBLE_LIVRAISON', @sChaineBCVretourDetStatut, ';' )
				Set @sPecPrbleLivraison = sysadm.FN_CLE_VAL ( 'PEC_PRBLE_LIVRAISON', @sChaineBCVretourDetStatut, ';' )

				Set @sAppSwap = sysadm.FN_CLE_VAL ( 'APP_SWAP', @sChaineBCVretourDetStatut, ';' )

				If sysadm.FN_CLE_VAL ( 'DDE_SAV', @sChaineBCVretourDetStatut, ';' ) = 'Oui' 
					Begin
						Set @sInfoFrnSpbCpltlu = sysadm.FN_CLE_VAL_E ( 'DDE_SAV', sysadm.FN_CLE_VAL ( 'DDE_SAV', @sChaineBCVretourDetStatut, ';' ), @sInfoFrnSpbCpltlu, ';' )
					End 

				Break
			End 

		------------------------------------------------------------------------
		-- Traitement principal des données, construction de l'enregistrement --
		------------------------------------------------------------------------
		If @iAMUerrRowTrt = 0
			Begin
				Set @sEnregistrementFicMPR = ''
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + Convert ( Varchar ( 10 ), @dcIdSin ) + '-' + Convert ( Varchar ( 10 ), @iIdSeq ) + @sSepChampsFicMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + Convert ( Varchar ( 20 ), @iIdDepotHub ) + @sSepChampsFicMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + @sIdHubPresta + @sSepChampsFicMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + 'HUB' + @sSepChampsFicMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + @sIdFour + @sSepChampsFicMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sNumCmdFrn, '') + @sSepChampsFicMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( Convert ( Varchar ( 20 ), @iStatusGC), '0') + @sSepChampsFicMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sTypBaAller, '') + @sSepChampsFicMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sPerteAller, '') + @sSepChampsFicMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sDiagVideoEngage, '') + @sSepChampsFicMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sResoluDiagVideo, '') + @sSepChampsFicMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( convert ( varchar(10), @dtDteRdvConf, 103 ) + ' ' + CONVERT (varchar(8), @dtDteRdvConf, 108), '') + @sSepChampsFicMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sModeLogisRet, '') + @sSepChampsFicMPR
				
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sPointServiceRet, '') + @sSepChampsFicMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( convert ( varchar(10), @dtDteRcpFrn, 103 ) + ' ' + CONVERT (varchar(8), @dtDteRcpFrn, 108), '') + @sSepChampsFicMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sSiteAction, '') + @sSepChampsFicMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sAppIncomplet, '') + @sSepChampsFicMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( convert ( varchar(10), @dtDteFinTrait, 103 ) + ' ' + CONVERT (varchar(8), @dtDteFinTrait, 108), '') + @sSepChampsFicMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sCommentFrn, '') + @sSepChampsFicMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sNumBonTrp, '') + @sSepChampsFicMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sNomTransporteur, '') + @sSepChampsFicMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( convert ( varchar(10), @dtDteRcpAppCli, 103 ) + ' ' + CONVERT (varchar(8), @dtDteRcpAppCli, 108), '') + @sSepChampsFicMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sAppSwap, '') + @sSepChampsFicMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sAutresInfosRempl, '') + @sSepChampsFicMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sMarqueRempl, '') + @sSepChampsFicMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sModeleRempl, '') + @sSepChampsFicMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sCouleurRempl, '') + @sSepChampsFicMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sNumImeiRempl, '') + @sSepChampsFicMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sNumSerieRempl, '') + @sSepChampsFicMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sCapStkRempl, '') + @sSepChampsFicMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sNeufRecondRempl, '') + @sSepChampsFicMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( convert ( varchar(20), @dcPrixTtcRempl ), '') + @sSepChampsFicMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sPrbleLivraison, '') + @sSepChampsFicMPR
				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sPecPrbleLivraison, '') + @sSepChampsFicMPR

				Set @sEnregistrementFicMPR = @sEnregistrementFicMPR + ISNULL ( @sInfoFrnSpbCpltlu, '') + @sSepChampsFicMPR
			
			End 
		
		----------------------------------------
		-- Trt des erreurs                    --
		----------------------------------------

		-- AMU une erreur sur un row de ce fournisseur
		If @iAMUerrRowTrt = 1 
			Begin
		  		Update @TbHubToSimpa2Work Set marquage = -1 Where id_work = @iIdWorkRow
				Set @iCptIdWorkRow = @iCptIdWorkRow + 1
				Continue
			End 

		-- Ecriture du row dans fichier
		Exec @iRet = sysadm.PS_ECRIRE_UN_ENREGISTREMENT_ADODB_STREAM_V03 @iHandleObjet, 0, 1, null, null, null, null, @sEnregistrementFicMPR, null

		If @iRet <> 0 
			Begin
				Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''' + ISNULL ( @sIdFour, '(vide)') + ''', ' + Convert ( VarChar (20), @iIdDepotHub) + ', ''' + @sIdHubPresta + ''', ''ERR'', ''' + 
				'Erreur lors de l''''écriture (writetexte) dans le fichier (' + IsNull ( @sIdFour, '(vide)') + '), Handle objet ' + CONVERT ( Varchar ( 20 ), @iHandleObjet ) +'.' + 
				''', ' +  Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )

		  		Update @TbHubToSimpa2Work Set marquage = -1 Where id_work = @iIdWorkRow
				Set @iCptIdWorkRow = @iCptIdWorkRow + 1
				Set @iAMUerrRowTrt = 1
				Set @iAMUerrGen = 1
				Continue
			End 

		---------------------------------------------
		-- Fin Trt de l'enregistrement sans erreur -- 
		---------------------------------------------
		Set @iAMUunRowEcrFrn = 1

		Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''' + ISNULL ( @sIdFour, '(vide)') + ''', ' + Convert ( VarChar (20), @iIdDepotHub) + ', ''' + @sIdHubPresta + ''', ''OK'', ''' + 
		'Enregistrement traité SOUS RESERVE de l''''écriture du fichier ' + @sCheminDepotFichierMPRFrn + '.' +
		''', ' + Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )


		Update @TbHubToSimpa2Work Set marquage = 1 Where id_work = @iIdWorkRow
		Set @iCptIdWorkRow = @iCptIdWorkRow + 1

	 End -- Fin de "Pour tout enregistrement de ce fournisseur"


	 If @iAMUunRowEcrFrn = 0
		Begin
			-- Aucun row écrit pour ce fournisseur, on ferme simplement le fichier sans écriture
			Exec sysadm.PS_FERMER_UN_FICHER_ADODB_STREAM @iHandleObjet
		End  

	 If @iAMUunRowEcrFrn = 1 
		Begin
			-- au moins un row écrit pour ce fournisseur
			-- Sauvegarde et fermeture du fichier sur disque
			Exec @iRet = sysadm.PS_SAUVEGARDER_ET_FERMER_UN_FICHER_ADODB_STREAM @iHandleObjet, @sCheminDepotFichierMPRFrn, 2

			If @iRet <> 0 
				Begin
					Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''' + ISNULL ( @sIdFour, '(vide)') + ''', -1, ''-1'', ''ERR'', ''' + 
					'Erreur lors de la sauvegarde et fermeture du fichier ' + IsNull ( @sCheminDepotFichierMPRFrn, '(vide)') + '), Handle objet ' + CONVERT ( Varchar ( 20 ), @iHandleObjet ) +'. Aucune donnée du prestataire n''''est perdue et aucune donnée du prestataire ' + ISNULL ( @sIdFour, '(vide)') + ' n''''est marquée en base.' +
					''', ' +  Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )

					Set @iAMUerrFrn = 1 
					Set @iAMUerrGen = 1
					Exec sysadm.PS_FERMER_UN_FICHER_ADODB_STREAM @iHandleObjet
					Update @TbFourn Set marquage = -1 Where id_work = @iIdWorkFrn			
					Continue
				End 

			Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''' + ISNULL ( @sIdFour, '(vide)') + ''', -1, ''-1'', ''OK'', ''' + 
			'Sauvegarde et fermeture du fichier ' + IsNull ( @sCheminDepotFichierMPRFrn, '(vide)') + ') (Handle objet ' + CONVERT ( Varchar ( 20 ), @iHandleObjet ) +') avec succès pour le prestataire ' + ISNULL ( @sIdFour, '(vide)') +
			''', ' +  Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )

		End 

	 If @iAMUunRowEcrFrn = 1 And @iAMUerrFrn = 0
		Begin

			-- Pour tout enregistrement traités (et sav fic succès) de ce fournisseur 
			Set @iAMUenrMarqBase = 0
			While Exists ( Select Top 1 1 From @TbHubToSimpa2Work where marquage = 1 And id_four = @sIdFour )
				Begin
					Select 	Top 1 
						@iIdWorkRow = id_work,
						@iIdDepotHub = id_depot_hub
					From	@TbHubToSimpa2Work
					Where	marquage = 1
					And		id_four = @sIdFour

					Set @sSql = 
					'Update ' + @sInstanceHub + 'edi.DepotHubToSimpa2Presta '  +
					'Set alt_trt = ''O'', ' +
					'    traite_le = ''' + Convert ( varchar ( 10 ), GETDATE(), 112 ) + ' ' + Convert ( varchar ( 30 ), GETDATE(), 114 ) + ''', ' +
					'    traite_par = ''SIM2'',' + 
					'	 chemin_fic = Reverse ( Right ( reverse ( ''' + @sCheminDepotFichierMPRFrn + ''' ), Len ( ''' + @sCheminDepotFichierMPRFrn + ''' ) - CharIndex ( ''\'', reverse (  ''' + @sCheminDepotFichierMPRFrn + ''' )) + 1 )),' +
					'	 nom_fic = Reverse ( Left (  reverse (  ''' + @sCheminDepotFichierMPRFrn + ''' ), CharIndex ( ''\'', reverse (  '''+ @sCheminDepotFichierMPRFrn + ''' )) - 1 ))' +
					'    where id_depot_hub = ' +  CONVERT ( Varchar ( 20 ), @iIdDepotHub )  
					Exec ( @sSql )
					Set @iError = @@ERROR 

					If @iError <> 0 
						Begin
							Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''' + ISNULL ( @sIdFour, '(vide)') + ''', -1, ''-1'', ''ERR'', ''' + 
							'Enregistrement(s) @iIdDepotHub=' + Convert ( VarChar ( 20), @iIdDepotHub ) + ' du prestataire ' + ISNULL ( @sIdFour, '(vide)') + ' NON marqué en base, erreur ' + CONVERT( VarChar ( 30 ) , @iError ) + '.' +
							''', ' +  Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )							

							Set @iAMUerrFrn = 1 
							Set @iAMUerrGen = 1
						End 
					Else
						Begin
							Set @iAMUenrMarqBase = 1
						End 

					Update @TbHubToSimpa2Work Set marquage = 2 Where id_work = @iIdWorkRow
				End 
			
			If @iAMUenrMarqBase = 1 And @iAMUerrFrn = 0
				Begin 
					Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''' + ISNULL ( @sIdFour, '(vide)') + ''', -1, ''-1'', ''OK'', ''' + 
					'TOUS les Enregistrement(s) du prestataire ' + ISNULL ( @sIdFour, '(vide)') + ' ont été marqué(s) en base.' +
					''', ' +  Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )
				End 

			If @iAMUenrMarqBase = 1 And @iAMUerrFrn = 1
				Begin 
					Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''' + ISNULL ( @sIdFour, '(vide)') + ''', -1, ''-1'', ''ERR'', ''' + 
					'les Enregistrement(s) du prestataire ' + ISNULL ( @sIdFour, '(vide)') + ' ont été PARTIELLEMENT marqué(s) en base.' +
					''', ' +  Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )
				End 

			If @iAMUenrMarqBase = 0 
				Begin 
					Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''' + ISNULL ( @sIdFour, '(vide)') + ''', -1, ''-1'', ''ERR'', ''' + 
					'AUCUN Enregistrement du prestataire ' + ISNULL ( @sIdFour, '(vide)') + ' n''''a été marqué en base.' +
					''', ' +  Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )
				End 

		End 

	 Update @TbFourn Set marquage = 1 Where id_work = @iIdWorkFrn

End -- Fin de "Pour tout fournisseur...."

-- Détruction de l'objet ADODB
If @iHandleObjet > 0 Exec @iRet = sysadm.PS_DETRUIRE_UN_OBJET_SQL_SERVER @iHandleObjet

Set @sSql = 'Exec ' + @sInstanceHub + 'edi.PS_HP276_I_HP_TRACE_RECUP_RETOUR_PAR_SIMPA2 '''', ''-1'', -1, ''-1'', ''' + IIF ( @iAMUerrGen =1, 'ERR', 'OK') + ''', ''' +
'Fin du traitement ' + IIF ( @iAMUerrGen =1, ' avec ERREUR ', '' ) + 'le ' + Convert ( VarChar ( 10), Getdate(), 103 ) + ' à ' + CONVERT (varchar(8), getdate(), 108) + 
''', ' + Convert ( VarChar ( 20 ), @iIdLotTrc ) ; Exec ( @sSql )

If @iAMUerrGen = 1
Begin
	Set @sObjet = '[Traitement SIMPA2 HUB PRESTATAIRE] => Erreur dans le traitement lot ' + CONVERT ( Varchar ( 20 ), @iIdLotTrc )

	Set @sObjet = Left ( @sObjet + space ( 255 ), 255 )
	Exec sysadm.PS_CASSER_REGLE_CHAINE @sObjet Output, '_', ' ' 

	Set @sMailBody = 'Bonjour ' + char (10)
	Set @sMailBody = @sMailBody + char (10)
	Set @sMailBody = @sMailBody + 'Serveur : ' + @@SERVERNAME 
	If @@SERVERNAME = 'SQL14SINISTRES\SINISTRES' Set @sMailBody = @sMailBody + ' (Alias [LS-SINISTRES])' 
	Set @sMailBody = @sMailBody + char (10) + 'base SIMPA2 : ' + DB_NAME () + char (10)
	Set @sMailBody = @sMailBody + 'Instance et base HUB PRESTATAIRE : ' + @sInstanceHub + char (10)
	Set @sMailBody = @sMailBody + char (10) 
	Set @sMailBody = @sMailBody + 'Au moins une erreur s''est produite dans le traitement numéro ' + CONVERT ( Varchar ( 20 ), @iIdLotTrc ) + '.' + char (10) 
	Set @sMailBody = @sMailBody + char (10) 
	Set @sMailBody = @sMailBody + 'Consultez la trace du traitement avec ces 4 Select pour voir depuis quand le problème se produit ' + CHAR ( 10 )
	Set @sMailBody = @sMailBody + '  Select * from ' + @sInstanceHub + 'edi.TraceRecupRetourParSimpa2 where id_lot_trc = '+ CONVERT (VarChar ( 20), @iIdLotTrc ) + ' order by 1' + CHAR ( 10 ) 
	Set @sMailBody = @sMailBody + '  Select * from ' + @sInstanceHub + 'edi.TraceRecupRetourParSimpa2 where id_lot_trc = '+ CONVERT (VarChar ( 20), @iIdLotTrc ) + ' and cod_etat = ''ERR'' order by 1' + CHAR ( 10 ) 
	Set @sMailBody = @sMailBody + '  Select * from ' + @sInstanceHub + 'edi.TraceRecupRetourParSimpa2 where cod_etat = ''ERR'' and cree_le > ''' + @sDateHeureDebTrt + ''' order by 1' + CHAR ( 10 )
	Set @sMailBody = @sMailBody + '  Select * from ' + @sInstanceHub + 'edi.TraceRecupRetourParSimpa2 where cree_le > ''' + @sDateHeureDebTrt + ''' order by 1 desc' + CHAR ( 10 )
	Set @sMailBody = @sMailBody + CHAR ( 10 )
	Set @sMailBody = @sMailBody + 'Aucune prestation n''a été perdue mais les mêmes erreurs reviendront au prochain traitement si vous ne les corrigez pas dans la table de dépôt edi.DepotHubToSimpa2Presta se trouvant sur le HUB, base PRESTATAIRE.' + CHAR ( 10 )
	Set @sMailBody = @sMailBody + CHAR ( 10 )
	Set @sMailBody = @sMailBody + 'Cordialement,'
	Set @sMailBody = @sMailBody + CHAR ( 10 )
	Set @sMailBody = @sMailBody + CHAR ( 10 )
	Set @sMailBody = @sMailBody + 'Fabry Jean-François'
	Set @sMailBody = @sMailBody + CHAR ( 10 )
	Set @sMailBody = @sMailBody + 'DSI Team SIMPA2' + CHAR ( 10 )
	Set @sMailBody = @sMailBody + 'Legacy Application Tech Lead' + CHAR ( 10 )

	EXEC master.dbo.SPB_PS_MAIL 
			@sRetourErrMail OUTPUT, 
			@sDestErrCoherenceHub ,
			@sMailBody, 
			@sObjet, 
			null, 
			@sDestCc, 
			@sFicOut, 
			NULL, 
			NULL, 
			NULL, 
			NULL

End 

Go

-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_SU_S2_MOTEUR_TRT_RETOUR_HUB_DETERMINATION_STATUT
-- Auteur               :       JFF
-- Date                 :       24/04/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Mets à jour la prestation sur SIMPA2 en retour du HUB
--                              /!\ A COMPILER SUR LA BASE SIMPA2 /!\
--
-- Retourne             :       rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_SU_S2_MOTEUR_TRT_RETOUR_HUB_DETERMINATION_STATUT' AND type = 'P' )
        DROP procedure sysadm.PS_HP276_SU_S2_MOTEUR_TRT_RETOUR_HUB_DETERMINATION_STATUT
GO

CREATE procedure sysadm.PS_HP276_SU_S2_MOTEUR_TRT_RETOUR_HUB_DETERMINATION_STATUT
	@asActivityCode				VarChar ( 50 ), 
	@asActivityReturnCode 		VarChar ( 50 ), 
	@asActivityReasonCode 		VarChar ( 50 ),
	@asActionOrigine			VarChar ( 50 ),
	@asInstanceHub				VarChar ( 100 ),
	@aiIdDepotHub				Integer,
	@asCommentFrn				VarChar ( 255 ) OutPut,
	@asChaineBCVretour			VarChar ( 255 ) OutPut
AS

Declare @iStatut Integer
Declare @sMotClecplt varChar ( 100 )
Declare @sBCVserial  varChar ( 100 )
Declare @sSql		Varchar ( 2000 )
Declare @sTypBaAller VarChar ( 35 ) 
Declare @sLibActivity VarChar( 255 )
Declare @iRowCount Integer

Set @sTypBaAller = sysadm.FN_CLE_VAL ( 'TYP_BA_ALLER', @asChaineBCVretour, ';' )

Set @asActivityCode = Upper ( @asActivityCode )
Set @asActivityReturnCode = Upper ( @asActivityReturnCode )
Set @asActivityReasonCode = Upper ( @asActivityReasonCode )
Set @asActionOrigine = Upper ( @asActionOrigine )

-- Recherche sur les 4 critères
Select @iStatut = mrh.statut,
	   @sMotClecplt = lTrim ( rTrim ( mrh.mot_cle_cplt )),
	   @sBCVserial  = lTrim ( rTrim ( mrh.bcv_serial )),
	   @sLibActivity = lTrim ( rTrim ( lib_activity ))
From sysadm.mapping_retour_hub mrh with ( nolock )
Where mrh.activity_code = @asActivityCode
And   mrh.activity_return_code = @asActivityReturnCode
And   mrh.activity_reason_code = @asActivityReasonCode
And   mrh.action_origine = @asActionOrigine

Set @iRowCount = @@ROWCOUNT

-- Recherche sur 3 critères, sans @asActionOrigine
If @iRowCount <= 0 
	Begin
		Select @iStatut = mrh.statut,
			   @sMotClecplt = lTrim ( rTrim ( mrh.mot_cle_cplt )),
			   @sBCVserial  = lTrim ( rTrim ( mrh.bcv_serial )),
			   @sLibActivity = lTrim ( rTrim ( lib_activity ))
		From sysadm.mapping_retour_hub mrh with ( nolock )
		Where mrh.activity_code = @asActivityCode
		And   mrh.activity_return_code = @asActivityReturnCode
		And   mrh.activity_reason_code = @asActivityReasonCode

		Set @iRowCount = @@ROWCOUNT

	End 

-- Recherche sur 2 critères, avec @asActionOrigine
If @iRowCount <= 0 
	Begin
		Select @iStatut = mrh.statut,
			   @sMotClecplt = lTrim ( rTrim ( mrh.mot_cle_cplt )),
			   @sBCVserial  = lTrim ( rTrim ( mrh.bcv_serial )),
			   @sLibActivity = lTrim ( rTrim ( lib_activity ))
		From sysadm.mapping_retour_hub mrh with ( nolock )
		Where mrh.activity_code = @asActivityCode
		And   mrh.activity_return_code = @asActivityReturnCode
		And   mrh.action_origine = @asActionOrigine

		Set @iRowCount = @@ROWCOUNT

	End 

-- Recherche sur 2 critères, sans @asActionOrigine
If @iRowCount <= 0 
	Begin
		Select @iStatut = mrh.statut,
			   @sMotClecplt = lTrim ( rTrim ( mrh.mot_cle_cplt )),
			   @sBCVserial  = lTrim ( rTrim ( mrh.bcv_serial )),
			   @sLibActivity = lTrim ( rTrim ( lib_activity ))
		From sysadm.mapping_retour_hub mrh with ( nolock )
		Where mrh.activity_code = @asActivityCode
		And   mrh.activity_return_code = @asActivityReturnCode

		Set @iRowCount = @@ROWCOUNT

	End 

If @iRowCount<= 0 
	Begin
		Return -1 -- Pas de statut déterminé
	End 

If @iStatut is null Set @iStatut = 0
If @sMotClecplt is null Set @sMotClecplt = ''
If @sBCVserial is null Set @sBCVserial = ''
If @sLibActivity is null Set @sLibActivity = ''
If @asCommentFrn is null Set @asCommentFrn = ''
Set @asCommentFrn = LTRIM ( rTrim ( @asCommentFrn ))

Set @asChaineBCVretour = sysadm.FN_CLE_VAL_E ( 'STATUS_GC', CONVERT( Varchar (10), @iStatut ), @asChaineBCVretour, ';')
Set @asChaineBCVretour = sysadm.FN_CLE_VAL_E ( 'MOT_CLE_CPLT', CONVERT( Varchar (10), @sMotClecplt ), @asChaineBCVretour, ';')
If RIGHT ( rTrim ( @asChaineBCVretour), 1 )<> ';' Set @asChaineBCVretour = rTrim ( @asChaineBCVretour) + ';'
Set @asChaineBCVretour = rTrim ( @asChaineBCVretour + @sBCVserial )
Set @asCommentFrn = rTrim ( @asCommentFrn ) + IIF ( ISNULL ( Rtrim ( @asCommentFrn ), '' ) <> '', '. ', '' ) + @sLibActivity 

-------------------------------------------------------------------------------------------
-- Cas particulier de redressement de données dans la table de dépot pour être cohérent, --
-- Cela évite des règles sur le HUB à donner au développeur.                             --
-------------------------------------------------------------------------------------------
-- Cas de la perte à l'aller
If	@asActivityCode = 'DEVICE_RECEPTION' And 
	@asActivityReturnCode = 'KO' 
	Begin
		Set @sSql = 
		'Update ' + @asInstanceHub + 'edi.DepotHubToSimpa2Presta '  +
		'Set perte_aller = '''+ sysadm.FN_CLE_VAL ( 'PERTE_ALLER', @sBCVserial, ';') + ''', ' +
		'    typ_ba_aller = ''' + @sTypBaAller + ''', ' +
		'    prble_livraison = '''+ sysadm.FN_CLE_VAL ( 'PRBLE_LIVRAISON', @sBCVserial, ';') + '''' + 
		'    pec_prble_livraison = '''+ sysadm.FN_CLE_VAL ( 'PEC_PRBLE_LIVRAISON', @sBCVserial, ';') + '''' + 
		'    where id_depot_hub = ' +  CONVERT ( Varchar ( 20 ), @aiIdDepotHub )  
		Exec ( @sSql )
	End 

-- Cas de l'incomplet
If	@asActivityCode = 'RETURN_OF_CONFORMITY' And 
	@asActivityReturnCode = 'KO' And
	@asActivityReasonCode = 'INCOMPLETE_DEVICE'
	Begin
		Set @sSql = 
		'Update ' + @asInstanceHub + 'edi.DepotHubToSimpa2Presta '  +
		'Set app_incomplet = '''+ sysadm.FN_CLE_VAL ( 'APP_INCOMPLET', @sBCVserial, ';') + ''', ' +
		'    where id_depot_hub = ' +  CONVERT ( Varchar ( 20 ), @aiIdDepotHub )  
		Exec ( @sSql )
	End 

-- Cas du swap
If	@asActivityCode in ( 'DEVICE_MANUFACTURER_ACTIONS', 'SERVICE_PROVIDER_ACTIONS' ) And 
	@asActivityReturnCode = 'SWAPPED'
	Begin
		Set @sSql = 
		'Update ' + @asInstanceHub + 'edi.DepotHubToSimpa2Presta '  +
		'Set app_swap = '''+ sysadm.FN_CLE_VAL ( 'APP_SWAP', @sBCVserial, ';') + ''', ' +
		'    where id_depot_hub = ' +  CONVERT ( Varchar ( 20 ), @aiIdDepotHub )  
		Exec ( @sSql )
	End 

-- Cas des problème de livraison sur le retour
If	@asActivityCode in ( 'CUSTOMER_ACKNOWLEDGMENT', 'CARRIER_ACKNOWLEDGMENT' ) And 
	@asActivityReturnCode in ( 'NOT_RECEIVED_BY_CUSTOMER', 'NOT_RECEIVED_LOSS_OF_TRANSPORT' )
	Begin
		Set @sSql = 
		'Update ' + @asInstanceHub + 'edi.DepotHubToSimpa2Presta '  +
		'Set prble_livraison = '''+ sysadm.FN_CLE_VAL ( 'PRBLE_LIVRAISON', @sBCVserial, ';') + '''' + 
		'    where id_depot_hub = ' +  CONVERT ( Varchar ( 20 ), @aiIdDepotHub )  
		Exec ( @sSql )
	End 

Return 1

GO

-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_S_S2_RECUPERER_ID_SEQ_SAV
-- Auteur               :       JFF
-- Date                 :       24/04/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Récupère le dernier Id Seq (cas du SAV donc)
--                              /!\ A COMPILER SUR LA BASE SIMPA2 /!\
--
-- Retourne             :       rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_S_S2_RECUPERER_ID_SEQ_SAV' AND type = 'P' )
        DROP procedure sysadm.PS_HP276_S_S2_RECUPERER_ID_SEQ_SAV
GO

CREATE procedure sysadm.PS_HP276_S_S2_RECUPERER_ID_SEQ_SAV
	    @adcIdsin			Decimal ( 10 ),
		@aiIdSeqSavRet		Integer  Output
AS

Select @aiIdSeqSavRet = MAX ( id_seq ) 
From   sysadm.commande c with ( nolock )
Where  c.id_sin = @adcIdsin

If @aiIdSeqSavRet is null Set @aiIdSeqSavRet = 0

Go

-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_S_S2_RECUPERER_ID_SEQ_ORIG
-- Auteur               :       JFF
-- Date                 :       24/04/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :       Récupère le dernier Id Seq (cas du SAV donc)
--                              /!\ A COMPILER SUR LA BASE SIMPA2 /!\
--
-- Retourne             :       rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_S_S2_RECUPERER_ID_SEQ_ORIG' AND type = 'P' )
        DROP procedure sysadm.PS_HP276_S_S2_RECUPERER_ID_SEQ_ORIG
GO

CREATE procedure sysadm.PS_HP276_S_S2_RECUPERER_ID_SEQ_ORIG
	    @adcIdsin			Decimal ( 10 ),
		@aiIdSeqOrig		Integer  Output,
		@asIdHubPrestaOrig  VarChar ( 20 ) OutPut,
		@asIdFourOrig		VarChar ( 3 ) OutPut
AS

Select @aiIdSeqOrig = Max ( id_seq )
From sysadm.commande c with ( nolock )
Where c.id_sin = @adcIdsin
And   c.id_ref_four in ( 'A_DIAGNOSTIQUER', 'A_REPARER' ) 
And   Len ( sysadm.FN_CLE_VAL ( 'HP_ID_HUB_PRESTA', c.info_spb_frn_cplt, ';' ) ) > 0 
And   sysadm.FN_CLE_VAL ( 'HP_ID_HUB_PRESTA', c.info_spb_frn_cplt, ';' ) <> 'FICTIVE'

If @aiIdSeqOrig > 0 
	Begin 
		Select @asIdHubPrestaOrig = sysadm.FN_CLE_VAL ( 'HP_ID_HUB_PRESTA', c.info_spb_frn_cplt, ';' ),
			   @asIdFourOrig = c.id_four
		From sysadm.commande c with ( nolock )
		Where c.id_sin = @adcIdsin
		And	  c.id_seq = @aiIdSeqOrig
	End 

If @aiIdSeqOrig is null Set @aiIdSeqOrig = -1
If @aiIdSeqOrig = 0 Set @aiIdSeqOrig = -1
If @asIdHubPrestaOrig is null Set @asIdHubPrestaOrig = ''
If @asIdFourOrig is null Set @asIdFourOrig = ''
Set @asIdHubPrestaOrig = LTRIM ( rtrim ( @asIdHubPrestaOrig ))
Set @asIdFourOrig = LTRIM ( rtrim ( @asIdFourOrig ))

Go



-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_I_S2_ATTENTE_TRANSFERT_VERS_HP
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :      
--                              /!\ A COMPILER SUR LA BASE SIMPA2 /!\
--
-- Retourne             :       rien / NON UTILISEE
-------------------------------------------------------------------
/*
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_I_S2_ATTENTE_TRANSFERT_VERS_HP' AND type = 'P' )
        DROP procedure sysadm.PS_HP276_I_S2_ATTENTE_TRANSFERT_VERS_HP
GO

CREATE procedure sysadm.PS_HP276_I_S2_ATTENTE_TRANSFERT_VERS_HP
		@aiCas	Integer,
		@iIdSin Integer ,
		@iIdSeq integer ,
		@sIdHubPresta VarChar ( 20 ) ,
		@sIdFour VarChar ( 3 ) ,
		@sTypDommage VarChar ( 100 ) ,
		@sPointService VarChar ( 20 ) ,
		@sModeProcess VarChar ( 20 ) ,
		@sCodePickUp VarChar ( 20 ) ,
		@sAdrNomPickUp VarChar ( 40 ) ,
		@sAdrReferenceAssPickUp VarChar ( 40 ) ,
		@sAdr1PickUp VarChar ( 40 ) ,
		@sAdr2PickUp VarChar ( 40 ) ,
		@sAdrCpltPickUp VarChar ( 40 ) ,
		@sAdrCpPickUp VarChar ( 5 ) ,
		@sAdrVillePickUp VarChar ( 40 ) ,
		@sCodeProcess Integer ,
		@sLibCodeProcess VarChar ( 35 ) ,
		@iIdGti Integer ,
		@sLibPersoGti VarChar ( 35 ) ,
		@iIdDetail Integer ,
		@iIdProd Integer ,
		@sLibProd VarChar ( 35 ) ,
		@sIdProdAdh Integer ,
		@iIdEts Integer ,
		@sIdAdh VarChar ( 19 ) ,
		@iIdSdos Integer ,
		@sIdTypArt varchar ( 3 ) ,
		@iCodCivLivr Integer ,
		@sLibCivLivrCourt varchar ( 35 ) ,
		@sLibCivLivrLong varchar ( 35 ) ,
		@IdContratAbonne VarChar ( 20 )  ,
		@NomAss VarChar ( 35 )  ,
		@PrenomAss VarChar ( 35 )  ,
		@NomLivr varchar ( 35 ) ,
		@PrenomLivr varchar ( 35 ) ,
		@sAdr1Livr varchar ( 35 ) ,
		@sAdr2Livr varchar ( 35 ) ,
		@sAdr3Livr varchar ( 35 ) ,
		@sAdrCpLivr varchar ( 5 ) ,
		@sAdrVilleLivr varchar ( 35 ) ,
		@sNumTel1Ass varchar ( 20 )  ,
		@sNumTel2Ass varchar ( 20 )  ,
		@sNumTel3Ass varchar ( 20 )  ,
		@sMailAssure varchar ( 128 ) ,
		@sNumImeiAppSin varchar ( 20 )  ,
		@sNumSerieAppSin varchar ( 20 )  ,
		@sDescriptionProbleme varchar ( 255 ) ,
		@sCodEtat varchar ( 3 )   ,
		@dtValideLe DateTime ,
		@sValidePar varchar ( 4 ) ,
		@dtCmdGenLe DateTime ,
		@sIdRefFour varchar ( 20 )  ,
		@sOrdreAction varchar ( 20 )   ,
		@iIdAssureur Integer ,
		@sLibAssureur Varchar ( 35 ) ,
		@sLibPolice Varchar ( 35 ) ,
		@sTypAppSin VarChar ( 3 )  ,
		@sLibTypAppSin Varchar ( 35 ) ,
		@sMarqAppSin Varchar ( 35 ) ,
		@sModlAppSin Varchar ( 35 ) ,
		@sRefAppSin Varchar ( 20 ) ,
		@sNumTelSin VarChar ( 25 ) ,
		@mtValAchat decimal ( 11, 2 ) ,
		@mtPriseEnCharge decimal ( 11, 2 ) ,
		@dtDateAchat DateTime ,
		@sEtatAppSin varChar ( 20 ) ,
		@sCodeVerrou VarChar ( 20 ) ,
		@sDesimlocke VarChar( 20 ) ,
		@sInfo_spb_frn_cplt VarChar ( 800 ) 

AS

Declare @iError Integer
Declare @iRowCount Integer

Declare @sAltTrt VarChar ( 1 )
Declare @dtTraiteLe DateTime 
Declare @sTraitePar VarChar ( 4 )
Declare @iAReparerSav Integer

Set @iAReparerSav = IIF ( sysadm.FN_CLE_VAL ( 'A_REPARER_SAV', @sInfo_spb_frn_cplt, ';') = 'OUI', 1, 0)

Set @sAltTrt = 'N'
Set @dtTraiteLe = null 
Set @sTraitePar = null

If @iAReparerSav > 0 
	Begin
		Set @sAltTrt = 'O'
		Set @dtTraiteLe = GETDATE()
		Set @sTraitePar = 'SIM2'
	End 


-- Traitement réél des données 
Insert into sysadm.en_attente_transfert_vers_hp
( 
	id_sin,
	id_seq,
	depose_le,
	depose_par,
	cpt_essai,
	essai_le,
	alt_trt,
	traite_le,
	traite_par,
	id_hub_presta,
	id_four,
	typ_dommage,
	point_service,
	mode_logis,
	code_pickup,
	nom_pickup,
	ref_ass_pickup,
	adr1_pickup,
	adr2_pickup,
	adr3_pickup,
	adr_cp_pickup,
	adr_ville_pickup,
	code_process,
	lib_code_process,
	id_gti,
	lib_perso_gti,
	id_detail,
	id_prod,
	lib_prod,
	id_prod_adh,
	id_ets,
	id_adh,
	id_sdos,
	id_typ_art,
	cod_civ_livr,
	lib_civ_livr_court,
	lib_civ_livr_long,
	id_contrat_abonne,
	nom_ass,
	prenom_ass,
	nom_livr,
	prenom_livr,
	adr1_livr,
	adr2_livr,
	adr3_livr,
	adr_cp_livr,
	adr_ville_livr,
	num_tel1_ass,
	num_tel2_ass,
	num_tel3_ass,
	mail_assure,
	num_imei_app_sin,
	num_serie_app_sin,
	description_probleme,
	cod_etat,
	valide_le,
	valide_par,
	cmd_gen_le,
	id_ref_four,
	ordre_action,
	id_assureur,
	lib_assureur,
	lib_police,
	typ_app_sin,
	lib_typ_app_sin,
	marq_app_sin,
	modl_app_sin,
	ref_app_sin,
	num_tel_sin,
	mt_val_achat,
	mt_prise_en_charge,
	date_achat,
	etat_app_sin,
	code_verrou,
	desimlocke,
	info_spb_frn_cplt

)

Values 

(
	@iIdSin,
	@iIdSeq,
	GETDATE(),
	'SIM2',
	0,
	null,
	@sAltTrt,
	@dtTraiteLe,
	@sTraitePar,
	@sIdHubPresta,
	@sIdFour,
	@sTypDommage,
	@sPointService,
	@sModeProcess,
	@sCodePickUp,
	@sAdrNomPickUp,
	@sAdrReferenceAssPickUp,
	@sAdr1PickUp,
	@sAdr2PickUp,
	@sAdrCpltPickUp,
	@sAdrCpPickUp,
	@sAdrVillePickUp,
	@sCodeProcess,
	@sLibCodeProcess,
	@iIdGti,
	@sLibPersoGti,
	@iIdDetail,
	@iIdProd,
	@sLibProd,
	@sIdProdAdh,
	@iIdEts,
	@sIdAdh,
	@iIdSdos,
	@sIdTypArt,
	@iCodCivLivr,
	@sLibCivLivrCourt,
	@sLibCivLivrLong,
	@IdContratAbonne,
	@NomAss,
	@PrenomAss,
	@NomLivr,
	@PrenomLivr,
	@sAdr1Livr,
	@sAdr2Livr,
	@sAdr3Livr,
	@sAdrCpLivr,
	@sAdrVilleLivr,
	@sNumTel1Ass,
	@sNumTel2Ass,
	@sNumTel3Ass,
	@sMailAssure,
	@sNumImeiAppSin,
	@sNumSerieAppSin,
	@sDescriptionProbleme,
	@sCodEtat,
	@dtValideLe,
	@sValidePar,
	@dtCmdGenLe,
	@sIdRefFour,
	@sOrdreAction,
	@iIdAssureur,
	@sLibAssureur,
	@sLibPolice,
	@sTypAppSin,
	@sLibTypAppSin,
	@sMarqAppSin,
	@sModlAppSin,
	@sRefAppSin,
	@sNumTelSin,
	@mtValAchat,
	@mtPriseEnCharge,
	@dtDateAchat,
	@sEtatAppSin,
	@sCodeVerrou,
	@sDesimlocke,
	@sInfo_spb_frn_cplt
)

Go
*/

-------------------------------------------------------------------
--
-- Procédure            :       PS_HP276_SI_S2_MOTEUR_TRANSFERT_PARTICULIER_VERS_HUB
-- Auteur               :       JFF
-- Date                 :       11/03/2024
-- Libell‚              :       [HP252_276_HUB_PRESTA]
-- Commentaires         :      
--                              /!\ A COMPILER SUR LA BASE SIMPA2 /!\
--
-- Retourne             :       rien
-------------------------------------------------------------------
IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'PS_HP276_SI_S2_MOTEUR_TRANSFERT_PARTICULIER_VERS_HUB' AND type = 'P' )
        DROP procedure sysadm.PS_HP276_SI_S2_MOTEUR_TRANSFERT_PARTICULIER_VERS_HUB
GO

CREATE procedure sysadm.PS_HP276_SI_S2_MOTEUR_TRANSFERT_PARTICULIER_VERS_HUB
AS

If NOT ( sysadm.FN_CLE_NUMERIQUE ( 'HP252_276_HUB_PRESTA') > 0 ) Return -- Moteur coupé

Declare @TB_EnAttenteTransfertVersHpWork Table (
	id_depot					int						NOT NULL,	-- Identifiant non modifiable de dépot, contrôle des trou/blanc si Delete Malveillant
	id_sin						int						NOT NULL,	-- Référence sinistre
	id_seq						int						NOT NULL,	-- numéro de la commande simpa2 pour ce sinistre
	depose_le					DateTime				NOT NULL,	-- Enregistrement déposé par Simpa2 le 
	depose_par					Char (4)				NOT NULL,	-- Enregistrement déposé par
	cpt_essai					integer					NOT NULL,   -- Compteur d'essai, à renseigner par le HUB
	essai_le					DateTime					NULL,   -- Date du dernier essai, à renseigner par le HUB
	alt_trt						Char (1)				NOT NULL,	-- Répère alternatif N(on)/E(n cours)/O(ui) des enregistrement pris en compte et traité par le HubP.
	traite_le					DateTime					NULL,	-- Traité par le Hub le
	traite_par					Char (4)					NULL,	-- traité par
	id_hub_presta				VarChar ( 20 )			NOT NULL,   -- Identifiant sur le Hub Prestataire de la prestation
	id_four						Char (3)				NOT NULL,   -- /!\ IMPORTANT : Code Fournisseur officiel SPB, ce code sera associé à un RIB de règlement du fournisseur chez Volcanes
	typ_dommage					VarChar ( 100 )				NULL,	-- Chaine contenant les codes des types de dommage sous la forme '#TD1#TD4#TD5#'
	point_service				VarChar ( 20 )				NULL,	-- Code du point de service	   
	mode_logis					VarChar ( 20 )				NULL,	-- Mode de logistique (CENTRALISATION / PROXIMITE )
	code_pickup					VarChar ( 20 )				NULL,	-- Code du relais si CENTRALISATION et Choix PickUp
	nom_pickup					VarChar ( 40 )				NULL,	-- Nom du relais si CENTRALISATION et Choix PickUp	
	ref_ass_pickup				VarChar ( 40 )				NULL,	-- référence du sinistre SPB et du nom de l'assuré à mettre sur le colis du Relais PickUp (dans le cas d'un renvoi)
	adr1_pickup					VarChar ( 40 )				NULL,   -- 1ère ligne adresse du relais pickup
	adr2_pickup					VarChar ( 40 )				NULL,   -- 2ème ligne adresse du relais pickup
	adr3_pickup					VarChar ( 40 )				NULL,   -- 3ème ligne adresse du relais pickup
	adr_cp_pickup				VarChar ( 5 )				NULL,   -- Code postal du relais pickup
	adr_ville_pickup			VarChar ( 40 )				NULL,   -- Ville du relais pickup
	code_process				Integer						NULL,   -- code process (-IF) 3510=Dépôt colis en bureau de poste, 3520=Dépôt colis en relais pickup, 3530=Dépôt en boutique de proximité
	lib_code_process			VarChar ( 35 )				NULL,   -- Libellé du code process
	id_gti						Integer						NULL,   -- ID de la garantie SIMPA2 (-GA )
	lib_perso_gti				VarChar ( 35 )				NULL,   -- Libellé personnalisé de la garantie pour le produit
	id_detail					Integer						NULL,   -- ID du détail de garantie SIMPA2 
	id_prod						Integer						NULL,   -- Code produit (Offre) sinistre SIMPA2 
	lib_prod					VarChar ( 35 )				NULL,   -- Libellé du produit (offre) sinistre SIMPA2 
	id_prod_adh					Integer						NULL,   -- Code produit adhésion 
	id_ets						Integer						NULL,   -- Code ets adhésion
	id_adh						VarChar ( 19 )				NULL,   -- Numéro adhésion
	id_sdos						Integer						NULL,   -- Numéro sous-dossier adhésion
	id_typ_art					varchar ( 3 )				NULL,   -- Code représentant le type de la prestation
	cod_civ_livr				Integer						NULL,   -- Code civilité de l'interlocuteur lié à la prestation
	lib_civ_livr_court			varchar ( 35 )				NULL,   -- Lib civilité court de l'interlocuteur lié à la prestation
	lib_civ_livr_long			varchar ( 35 )				NULL,   -- Lib civilité long de l'interlocuteur lié à la prestation
	id_contrat_abonne			VarChar ( 20 ) 				NULL,	-- Identifiant éventuel de l'assuré reconnu par le contractant
	nom_ass						VarChar ( 35 ) 				NULL,	-- Nom de l'assuré ayant souscrit l'adhésion
	prenom_ass					VarChar ( 35 ) 				NULL,	-- Prénom de l'assuré ayant souscrit l'adhésion
	nom_livr					varchar ( 35 )				NULL,   -- Nom de l'interlocuteur lié à la prestation
	prenom_livr					varchar ( 35 )				NULL,   -- Prénom de l'interlocuteur lié à la prestation
	adr1_livr					varchar ( 35 )				NULL,   -- Adresse ligne 1 de l'interlocuteur lié à la prestation
	adr2_livr					varchar ( 35 )				NULL,   -- Adresse ligne 2 de l'interlocuteur lié à la prestation
	adr3_livr					varchar ( 35 )				NULL,   -- Adresse ligne 3 de l'interlocuteur lié à la prestation
	adr_cp_livr					varchar ( 5 )				NULL,   -- Code postal de l'interlocuteur lié à la prestation
	adr_ville_livr				varchar ( 35 )				NULL,   -- Ville de l'interlocuteur lié à la prestation
	num_tel1_ass				varchar ( 20 ) 				NULL,   -- Numéro tel1 de l'interlocuteur lié à la prestation
	num_tel2_ass				varchar ( 20 ) 				NULL,   -- Numéro tel2 de l'interlocuteur lié à la prestation
	num_tel3_ass				varchar ( 20 ) 				NULL,   -- Numéro tel3 de l'interlocuteur lié à la prestation
	mail_assure					varchar ( 128 )				NULL,   -- Adresse mail de l'assuré
	num_imei_app_sin			varchar ( 20 )  			NULL,   -- Numéro de IMEI de l'appareil sinistré
	num_serie_app_sin			varchar ( 60 )  			NULL,   -- Numéro de série de l'appareil sinistré
	description_probleme		varchar ( 255 )  			NULL,   -- Description résumé du problème sur l'appareil écrit en français par le GT
	cod_etat					varchar ( 3 )   			NULL,   -- Etat de la prestation
	valide_le					DateTime					NULL,   -- Date de validation de la prestation par le GT
	valide_par					varchar ( 4 )				NULL,   -- Prestation validé par 
	cmd_gen_le					DateTime					NULL,   -- Date de génération de la prestation par le système
	id_ref_four					varchar ( 20 )  			NULL,   -- Pour une commande de remplacement, cela peut être ID du matériel chez le fournisseur, sinon l'ordre d'action
	ordre_action				varchar ( 20 )  			NULL,   -- Ordre d'action
	id_assureur					Integer						NULL,   -- ID officiel spb de l'assureur
	lib_assureur				Varchar ( 35 )				NULL,   -- Libellé de l'assureur
	lib_police					Varchar ( 35 )				NULL,   -- Libellé de la police
	typ_app_sin					VarChar ( 3 ) 				NULL,   -- Type de l'appareil sinistré (-AR)
	lib_typ_app_sin				Varchar ( 35 )				NULL,   -- Libellé de l'appareil sinistré (-AR)
	marq_app_sin				Varchar ( 35 )				NULL,   -- Marque de l'appareil sinistré
	modl_app_sin				Varchar ( 35 )				NULL,   -- Modèle de l'appareil sinistré
	ref_app_sin					Varchar ( 20 )				NULL,   -- référentiel de l'appareil sinistré IFR, DARTY, AUTRE (AUTRE=Marque contrôlé, saisie modèle libre)
	num_tel_sin					VarChar ( 25 )				NULL,   -- Numéro de téléphone de l'appareil sinistré (si c'est une téléphone/smartphone)
	mt_val_achat				decimal ( 11, 2 )			NULL,   -- Montant de la valeur d'achat
	mt_prise_en_charge			decimal ( 11, 2 )			NULL,   -- Montant de prise en max par spb (à respecter par le fournisseur )
	date_achat					DateTime					NULL,	-- Date achat du matériel sinistré
	etat_app_sin				varChar ( 20 )				NULL,	-- Etat de l'appareil sinistré, REConditionné ou NEUf
	code_verrou					VarChar ( 20 )				NULL,	-- Code verrou de l'appareil
	desimlocke					VarChar( 20 )				NULL,	-- Appareil désimlocké OUI/NON
	info_spb_frn_cplt			VarChar ( 800 )				NULL	-- Chaîne sérialisée contenant de multiples informations
)

Declare 
		@iIdDepot Integer,
		@iIdSin Integer ,
		@iIdSeq integer ,
		@sIdHubPresta VarChar ( 20 ) ,
		@sIdFour VarChar ( 3 ) ,
		@sTypDommage VarChar ( 100 ) ,
		@sPointService VarChar ( 20 ) ,
		@sModeProcess VarChar ( 20 ) ,
		@sCodePickUp VarChar ( 20 ) ,
		@sAdrNomPickUp VarChar ( 40 ) ,
		@sAdrReferenceAssPickUp VarChar ( 40 ) ,
		@sAdr1PickUp VarChar ( 40 ) ,
		@sAdr2PickUp VarChar ( 40 ) ,
		@sAdrCpltPickUp VarChar ( 40 ) ,
		@sAdrCpPickUp VarChar ( 5 ) ,
		@sAdrVillePickUp VarChar ( 40 ) ,
		@sCodeProcess Integer ,
		@sLibCodeProcess VarChar ( 35 ) ,
		@iIdGti Integer ,
		@sLibPersoGti VarChar ( 35 ) ,
		@iIdDetail Integer ,
		@iIdProd Integer ,
		@sLibProd VarChar ( 35 ) ,
		@sIdProdAdh Integer ,
		@iIdEts Integer ,
		@sIdAdh VarChar ( 19 ) ,
		@iIdSdos Integer ,
		@sIdTypArt varchar ( 3 ) ,
		@iCodCivLivr Integer ,
		@sLibCivLivrCourt varchar ( 35 ) ,
		@sLibCivLivrLong varchar ( 35 ) ,
		@IdContratAbonne VarChar ( 20 )  ,
		@NomAss VarChar ( 35 )  ,
		@PrenomAss VarChar ( 35 )  ,
		@NomLivr varchar ( 35 ) ,
		@PrenomLivr varchar ( 35 ) ,
		@sAdr1Livr varchar ( 35 ) ,
		@sAdr2Livr varchar ( 35 ) ,
		@sAdr3Livr varchar ( 35 ) ,
		@sAdrCpLivr varchar ( 5 ) ,
		@sAdrVilleLivr varchar ( 35 ) ,
		@sNumTel1Ass varchar ( 20 )  ,
		@sNumTel2Ass varchar ( 20 )  ,
		@sNumTel3Ass varchar ( 20 )  ,
		@sMailAssure varchar ( 128 ) ,
		@sNumImeiAppSin varchar ( 20 )  ,
		@sNumSerieAppSin varchar ( 20 )  ,
		@sDescriptionProbleme varchar ( 255 ) ,
		@sCodEtat varchar ( 3 )   ,
		@dtValideLe DateTime ,
		@sValidePar varchar ( 4 ) ,
		@dtCmdGenLe DateTime ,
		@sIdRefFour varchar ( 20 )  ,
		@sOrdreAction varchar ( 20 )   ,
		@iIdAssureur Integer ,
		@sLibAssureur Varchar ( 35 ) ,
		@sLibPolice Varchar ( 35 ) ,
		@sTypAppSin VarChar ( 3 )  ,
		@sLibTypAppSin Varchar ( 35 ) ,
		@sMarqAppSin Varchar ( 35 ) ,
		@sModlAppSin Varchar ( 35 ) ,
		@sRefAppSin Varchar ( 20 ) ,
		@sNumTelSin VarChar ( 25 ) ,
		@mtValAchat decimal ( 11, 2 ) ,
		@mtPriseEnCharge decimal ( 11, 2 ) ,
		@dtDateAchat DateTime ,
		@sEtatAppSin varChar ( 20 ) ,
		@sCodeVerrou VarChar ( 20 ) ,
		@sDesimlocke VarChar( 20 ) ,
		@sInfo_spb_frn_cplt VarChar ( 800 ) 

Declare @isProdOuSim VarChar ( 10 )
Declare @iIdentity Integer
Declare @iRowCount Integer
Declare @iError Integer

IF @@SERVERNAME = master.dbo.SPB_FN_ServerName('PRO') and RIGHT( db_name( db_id() ), 3 ) ='PRO' Set @isProdOuSim = 'PROD' ELSE Set @isProdOuSim = 'SIM'

Insert into @TB_EnAttenteTransfertVersHpWork 
Select 
	id_depot,
	id_sin,
	id_seq,
	depose_le,
	depose_par,
	cpt_essai,
	essai_le,
	alt_trt,
	traite_le,
	traite_par,
	id_hub_presta,
	id_four,
	typ_dommage,
	point_service,
	mode_logis,
	code_pickup,
	nom_pickup,
	ref_ass_pickup,
	adr1_pickup,
	adr2_pickup,
	adr3_pickup,
	adr_cp_pickup,
	adr_ville_pickup,
	code_process,
	lib_code_process,
	id_gti,
	lib_perso_gti,
	id_detail,
	id_prod,
	lib_prod,
	id_prod_adh,
	id_ets,
	id_adh,
	id_sdos,
	id_typ_art,
	cod_civ_livr,
	lib_civ_livr_court,
	lib_civ_livr_long,
	id_contrat_abonne,
	nom_ass,
	prenom_ass,
	nom_livr,
	prenom_livr,
	adr1_livr,
	adr2_livr,
	adr3_livr,
	adr_cp_livr,
	adr_ville_livr,
	num_tel1_ass,
	num_tel2_ass,
	num_tel3_ass,
	mail_assure,
	num_imei_app_sin,
	num_serie_app_sin,
	description_probleme,
	cod_etat,
	valide_le,
	valide_par,
	cmd_gen_le,
	id_ref_four,
	ordre_action,
	id_assureur,
	lib_assureur,
	lib_police,
	typ_app_sin,
	lib_typ_app_sin,
	marq_app_sin,
	modl_app_sin,
	ref_app_sin,
	num_tel_sin,
	mt_val_achat,
	mt_prise_en_charge,
	date_achat,
	etat_app_sin,
	code_verrou,
	desimlocke,
	info_spb_frn_cplt

From sysadm.en_attente_transfert_vers_hp
Where alt_trt = 'N'

While Exists ( Select Top 1 1 From @TB_EnAttenteTransfertVersHpWork where alt_trt = 'N' )
 Begin
	Select 	Top 1 
		  @iIdDepot = id_depot,
		  @iIdSin = id_sin,
		  @iIdSeq = id_seq,
		  @sIdHubPresta = id_hub_presta,
		  @sIdFour = id_four,
		  @sTypDommage = typ_dommage,
		  @sPointService = point_service,
		  @sModeProcess = mode_logis,
		  @sCodePickUp = code_pickup,
		  @sAdrNomPickUp = nom_pickup,
		  @sAdrReferenceAssPickUp = ref_ass_pickup,
		  @sAdr1PickUp = adr1_pickup,
		  @sAdr2PickUp = adr2_pickup,
		  @sAdrCpltPickUp = adr3_pickup,
		  @sAdrCpPickUp = adr_cp_pickup,
		  @sAdrVillePickUp = adr_ville_pickup,
		  @sCodeProcess = code_process,
		  @sLibCodeProcess = lib_code_process,
		  @iIdGti = id_gti,
		  @sLibPersoGti = lib_perso_gti,
		  @iIdDetail = id_detail,
		  @iIdProd = id_prod,
		  @sLibProd = lib_prod,
		  @sIdProdAdh = id_prod_adh,
		  @iIdEts = id_ets,
		  @sIdAdh = id_adh,
		  @iIdSdos = id_sdos,
		  @sIdTypArt = id_typ_art,
		  @iCodCivLivr = cod_civ_livr,
		  @sLibCivLivrCourt = lib_civ_livr_court,
		  @sLibCivLivrLong = lib_civ_livr_long,
		  @IdContratAbonne = id_contrat_abonne,
		  @NomAss = nom_ass,
		  @PrenomAss = prenom_ass,
		  @NomLivr = nom_livr,
		  @PrenomLivr = prenom_livr,
		  @sAdr1Livr = adr1_livr,
		  @sAdr2Livr = adr2_livr,
		  @sAdr3Livr = adr3_livr,
		  @sAdrCpLivr = adr_cp_livr,
		  @sAdrVilleLivr = adr_ville_livr,
		  @sNumTel1Ass = num_tel1_ass,
		  @sNumTel2Ass = num_tel2_ass,
		  @sNumTel3Ass = num_tel3_ass,
		  @sMailAssure = mail_assure,
		  @sNumImeiAppSin = num_imei_app_sin,
		  @sNumSerieAppSin = num_serie_app_sin,
		  @sDescriptionProbleme = description_probleme,
		  @sCodEtat = cod_etat,
		  @dtValideLe = valide_le,
		  @sValidePar = valide_par,
		  @dtCmdGenLe = cmd_gen_le,
		  @sIdRefFour = id_ref_four,
		  @sOrdreAction = ordre_action,
		  @iIdAssureur = id_assureur,
		  @sLibAssureur = lib_assureur,
		  @sLibPolice = lib_police,
		  @sTypAppSin = typ_app_sin,
		  @sLibTypAppSin = lib_typ_app_sin,
		  @sMarqAppSin = marq_app_sin,
		  @sModlAppSin = modl_app_sin,
		  @sRefAppSin = ref_app_sin,
		  @sNumTelSin = num_tel_sin,
		  @mtValAchat = mt_val_achat,
		  @mtPriseEnCharge = mt_prise_en_charge,
		  @dtDateAchat = date_achat,
		  @sEtatAppSin = etat_app_sin,
		  @sCodeVerrou = code_verrou,
		  @sDesimlocke = desimlocke,
		  @sInfo_spb_frn_cplt = info_spb_frn_cplt

	From	@TB_EnAttenteTransfertVersHpWork
	Where	alt_trt = 'N'


	If @isProdOuSim = 'PROD' 
		Begin 
			Exec @iError = [LS-SAGA2].[PRESTATAIRE].edi.PS_HP276_I_HP_TRANSFERT_PRESTA_VERS_HUB_PRESTATAIRE 
				2, -- 2 ou 3, c'est pareil
				@iIdSin,
				@iIdSeq,
				@sIdHubPresta,
				@sIdFour,
				@sTypDommage,
				@sPointService,
				@sModeProcess,
				@sCodePickUp,
				@sAdrNomPickUp,
				@sAdrReferenceAssPickUp,
				@sAdr1PickUp,
				@sAdr2PickUp,
				@sAdrCpltPickUp,
				@sAdrCpPickUp,
				@sAdrVillePickUp,
				@sCodeProcess,
				@sLibCodeProcess,
				@iIdGti,
				@sLibPersoGti,
				@iIdDetail,
				@iIdProd,
				@sLibProd,
				@sIdProdAdh,
				@iIdEts,
				@sIdAdh,
				@iIdSdos,
				@sIdTypArt,
				@iCodCivLivr,
				@sLibCivLivrCourt,
				@sLibCivLivrLong,
				@IdContratAbonne,
				@NomAss,
				@PrenomAss,
				@NomLivr,
				@PrenomLivr,
				@sAdr1Livr,
				@sAdr2Livr,
				@sAdr3Livr,
				@sAdrCpLivr,
				@sAdrVilleLivr,
				@sNumTel1Ass,
				@sNumTel2Ass,
				@sNumTel3Ass,
				@sMailAssure,
				@sNumImeiAppSin,
				@sNumSerieAppSin,
				@sDescriptionProbleme,
				@sCodEtat,
				@dtValideLe,
				@sValidePar,
				@dtCmdGenLe,
				@sIdRefFour,
				@sOrdreAction,
				@iIdAssureur,
				@sLibAssureur,
				@sLibPolice,
				@sTypAppSin,
				@sLibTypAppSin,
				@sMarqAppSin,
				@sModlAppSin,
				@sRefAppSin,
				@sNumTelSin,
				@mtValAchat,
				@mtPriseEnCharge,
				@dtDateAchat,
				@sEtatAppSin,
				@sCodeVerrou,
				@sDesimlocke,
				@sInfo_spb_frn_cplt,
				@iIdentity Output,
				@iRowCount Output

		End 
	Else
		Begin
			Exec @iError = [S2SQL14PP1\PPRSAGA2].[PRESTATAIRE].edi.PS_HP276_I_HP_TRANSFERT_PRESTA_VERS_HUB_PRESTATAIRE 
				2, -- 2 ou 3, c'est pareil
				@iIdSin,
				@iIdSeq,
				@sIdHubPresta,
				@sIdFour,
				@sTypDommage,
				@sPointService,
				@sModeProcess,
				@sCodePickUp,
				@sAdrNomPickUp,
				@sAdrReferenceAssPickUp,
				@sAdr1PickUp,
				@sAdr2PickUp,
				@sAdrCpltPickUp,
				@sAdrCpPickUp,
				@sAdrVillePickUp,
				@sCodeProcess,
				@sLibCodeProcess,
				@iIdGti,
				@sLibPersoGti,
				@iIdDetail,
				@iIdProd,
				@sLibProd,
				@sIdProdAdh,
				@iIdEts,
				@sIdAdh,
				@iIdSdos,
				@sIdTypArt,
				@iCodCivLivr,
				@sLibCivLivrCourt,
				@sLibCivLivrLong,
				@IdContratAbonne,
				@NomAss,
				@PrenomAss,
				@NomLivr,
				@PrenomLivr,
				@sAdr1Livr,
				@sAdr2Livr,
				@sAdr3Livr,
				@sAdrCpLivr,
				@sAdrVilleLivr,
				@sNumTel1Ass,
				@sNumTel2Ass,
				@sNumTel3Ass,
				@sMailAssure,
				@sNumImeiAppSin,
				@sNumSerieAppSin,
				@sDescriptionProbleme,
				@sCodEtat,
				@dtValideLe,
				@sValidePar,
				@dtCmdGenLe,
				@sIdRefFour,
				@sOrdreAction,
				@iIdAssureur,
				@sLibAssureur,
				@sLibPolice,
				@sTypAppSin,
				@sLibTypAppSin,
				@sMarqAppSin,
				@sModlAppSin,
				@sRefAppSin,
				@sNumTelSin,
				@mtValAchat,
				@mtPriseEnCharge,
				@dtDateAchat,
				@sEtatAppSin,
				@sCodeVerrou,
				@sDesimlocke,
				@sInfo_spb_frn_cplt,
				@iIdentity Output,
				@iRowCount Output

		End 
	
	-- Echec
	If @iError <> 0 
		Begin
			Update @TB_EnAttenteTransfertVersHpWork Set alt_trt = 'O' Where id_depot = @iIdDepot
			Continue
		End


	-- Succès
		
	Update @TB_EnAttenteTransfertVersHpWork Set alt_trt = 'O' Where id_depot = @iIdDepot
	Exec sysadm.PS_HP276_U_S2_MAJ_GEN_PRESTA @iIdSin, @iIdSeq, @iIdentity
	Update sysadm.en_attente_transfert_vers_hp Set alt_trt = 'O', traite_le = GETDATE(), traite_par = 'SIM2' Where id_depot = @iIdDepot
			
 End

Go