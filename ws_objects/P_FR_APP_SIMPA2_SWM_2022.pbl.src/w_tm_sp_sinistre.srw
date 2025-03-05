$PBExportHeader$w_tm_sp_sinistre.srw
$PBExportComments$-} Fenêtre de traitement pour la saisie des sinistres. ( DCMP 990391 )
forward
global type w_tm_sp_sinistre from w_8_traitement_master
end type
type pb_routage from u_8_pbroutage within w_tm_sp_sinistre
end type
type uo_ong from u_onglets within w_tm_sp_sinistre
end type
type dw_produit from datawindow within w_tm_sp_sinistre
end type
type p_focus from picture within w_tm_sp_sinistre
end type
type dw_codegarantie from datawindow within w_tm_sp_sinistre
end type
type dw_paraprod from datawindow within w_tm_sp_sinistre
end type
type dw_wparainfo from datawindow within w_tm_sp_sinistre
end type
type dw_piece from datawindow within w_tm_sp_sinistre
end type
type dw_motif from datawindow within w_tm_sp_sinistre
end type
type dw_delai from datawindow within w_tm_sp_sinistre
end type
type dw_franchise from datawindow within w_tm_sp_sinistre
end type
type dw_plafond from datawindow within w_tm_sp_sinistre
end type
type dw_garantie from datawindow within w_tm_sp_sinistre
end type
type dw_condition from datawindow within w_tm_sp_sinistre
end type
type dw_wdetail from datawindow within w_tm_sp_sinistre
end type
type dw_wpiece from datawindow within w_tm_sp_sinistre
end type
type dw_wrefus from datawindow within w_tm_sp_sinistre
end type
type dw_codecondition from datawindow within w_tm_sp_sinistre
end type
type dw_wfrais from datawindow within w_tm_sp_sinistre
end type
type dw_wcourrier from datawindow within w_tm_sp_sinistre
end type
type uo_libelle from u_libelle_dga within w_tm_sp_sinistre
end type
type dw_police from datawindow within w_tm_sp_sinistre
end type
type uo_3d from u_bord3d within w_tm_sp_sinistre
end type
type dw_lst_inter from u_datawindow_detail within w_tm_sp_sinistre
end type
type dw_lst_gti from u_datawindow_detail within w_tm_sp_sinistre
end type
type dw_wparaplafond from datawindow within w_tm_sp_sinistre
end type
type dw_wreggti from datawindow within w_tm_sp_sinistre
end type
type dw_mot_rout from datawindow within w_tm_sp_sinistre
end type
type st_pochette from statictext within w_tm_sp_sinistre
end type
type dw_lst_contact from u_datawindow_detail within w_tm_sp_sinistre
end type
type dw_corb from datawindow within w_tm_sp_sinistre
end type
type dw_article from datawindow within w_tm_sp_sinistre
end type
type dw_w_commande from u_datawindow_detail within w_tm_sp_sinistre
end type
type dw_cmde_typ_frn from datawindow within w_tm_sp_sinistre
end type
type dw_cmde_typ_art from datawindow within w_tm_sp_sinistre
end type
type cb_aide from u_aidecontrat within w_tm_sp_sinistre
end type
type cb_notice from u_aidecontrat within w_tm_sp_sinistre
end type
type dw_horaire_rdv from datawindow within w_tm_sp_sinistre
end type
type dw_zone_fournisseur from datawindow within w_tm_sp_sinistre
end type
type dw_det_article from datawindow within w_tm_sp_sinistre
end type
type dw_det_hlr from datawindow within w_tm_sp_sinistre
end type
type dw_lst_gamme from datawindow within w_tm_sp_sinistre
end type
type dw_det_pro from datawindow within w_tm_sp_sinistre
end type
type cb_noboite from commandbutton within w_tm_sp_sinistre
end type
type dw_boutique from datawindow within w_tm_sp_sinistre
end type
type dw_commune from datawindow within w_tm_sp_sinistre
end type
type dw_tac_imei from datawindow within w_tm_sp_sinistre
end type
type dw_boitearchive from u_datawindow within w_tm_sp_sinistre
end type
type dw_mail from datawindow within w_tm_sp_sinistre
end type
type dw_autorisation from datawindow within w_tm_sp_sinistre
end type
type dw_gencourrier from datawindow within w_tm_sp_sinistre
end type
type dw_stk_w_cour_blob_sve from datawindow within w_tm_sp_sinistre
end type
type dddw_typedoc from datawindow within w_tm_sp_sinistre
end type
type lb_fichier from listbox within w_tm_sp_sinistre
end type
type dw_choixcourgen from datawindow within w_tm_sp_sinistre
end type
type dw_compo from datawindow within w_tm_sp_sinistre
end type
type pb_validation_dossier from u_8_pbvalider within w_tm_sp_sinistre
end type
type dw_div_pro from datawindow within w_tm_sp_sinistre
end type
type dw_w_div_sin from u_datawindow within w_tm_sp_sinistre
end type
type cb_polass from commandbutton within w_tm_sp_sinistre
end type
type dddw_codecar_wdivsin_charg_tempo from datawindow within w_tm_sp_sinistre
end type
type dddw_code_wdivsin_charg_tempo from datawindow within w_tm_sp_sinistre
end type
type dw_code_equivalence from datawindow within w_tm_sp_sinistre
end type
type dw_stk_ifr from datawindow within w_tm_sp_sinistre
end type
type dddw_ifr_marque from datawindow within w_tm_sp_sinistre
end type
type dw_code_mb from datawindow within w_tm_sp_sinistre
end type
type dddw_ifr_modele from datawindow within w_tm_sp_sinistre
end type
type cb_categ from commandbutton within w_tm_sp_sinistre
end type
type cb_excel from u_aidecontrat within w_tm_sp_sinistre
end type
type dddw_dty_modele from datawindow within w_tm_sp_sinistre
end type
type dddw_dty_marque from datawindow within w_tm_sp_sinistre
end type
type dw_code_rf from datawindow within w_tm_sp_sinistre
end type
type dw_stk_codic_darty from datawindow within w_tm_sp_sinistre
end type
type dw_div_pdet from datawindow within w_tm_sp_sinistre
end type
type dw_w_div_det from u_datawindow_detail within w_tm_sp_sinistre
end type
type cb_valid_factu from commandbutton within w_tm_sp_sinistre
end type
type dw_dossuivipar from u_datawindow within w_tm_sp_sinistre
end type
type st_mode_reprise from statictext within w_tm_sp_sinistre
end type
type cb_aide_mode_reprise from commandbutton within w_tm_sp_sinistre
end type
type cb_aide_base_manuelle from commandbutton within w_tm_sp_sinistre
end type
type cb_journal from commandbutton within w_tm_sp_sinistre
end type
type uo_consult_euro from u_consultation_euro within w_tm_sp_sinistre
end type
type st_pause_api_lab from statictext within w_tm_sp_sinistre
end type
type dw_wreg_frais_annexe_frn from datawindow within w_tm_sp_sinistre
end type
type st_attente_diverse from statictext within w_tm_sp_sinistre
end type
end forward

global type w_tm_sp_sinistre from w_8_traitement_master
integer x = 0
integer y = 0
integer width = 4046
integer height = 2116
string title = ""
boolean minbox = true
event ue_quitteronglet011 pbm_custom01
event ue_valider_dossier pbm_custom02
event ue_choix_garantie pbm_custom03
event ue_entreronglet041 pbm_custom04
event ue_taillefenetre ( )
pb_routage pb_routage
uo_ong uo_ong
dw_produit dw_produit
p_focus p_focus
dw_codegarantie dw_codegarantie
dw_paraprod dw_paraprod
dw_wparainfo dw_wparainfo
dw_piece dw_piece
dw_motif dw_motif
dw_delai dw_delai
dw_franchise dw_franchise
dw_plafond dw_plafond
dw_garantie dw_garantie
dw_condition dw_condition
dw_wdetail dw_wdetail
dw_wpiece dw_wpiece
dw_wrefus dw_wrefus
dw_codecondition dw_codecondition
dw_wfrais dw_wfrais
dw_wcourrier dw_wcourrier
uo_libelle uo_libelle
dw_police dw_police
uo_3d uo_3d
dw_lst_inter dw_lst_inter
dw_lst_gti dw_lst_gti
dw_wparaplafond dw_wparaplafond
dw_wreggti dw_wreggti
dw_mot_rout dw_mot_rout
st_pochette st_pochette
dw_lst_contact dw_lst_contact
dw_corb dw_corb
dw_article dw_article
dw_w_commande dw_w_commande
dw_cmde_typ_frn dw_cmde_typ_frn
dw_cmde_typ_art dw_cmde_typ_art
cb_aide cb_aide
cb_notice cb_notice
dw_horaire_rdv dw_horaire_rdv
dw_zone_fournisseur dw_zone_fournisseur
dw_det_article dw_det_article
dw_det_hlr dw_det_hlr
dw_lst_gamme dw_lst_gamme
dw_det_pro dw_det_pro
cb_noboite cb_noboite
dw_boutique dw_boutique
dw_commune dw_commune
dw_tac_imei dw_tac_imei
dw_boitearchive dw_boitearchive
dw_mail dw_mail
dw_autorisation dw_autorisation
dw_gencourrier dw_gencourrier
dw_stk_w_cour_blob_sve dw_stk_w_cour_blob_sve
dddw_typedoc dddw_typedoc
lb_fichier lb_fichier
dw_choixcourgen dw_choixcourgen
dw_compo dw_compo
pb_validation_dossier pb_validation_dossier
dw_div_pro dw_div_pro
dw_w_div_sin dw_w_div_sin
cb_polass cb_polass
dddw_codecar_wdivsin_charg_tempo dddw_codecar_wdivsin_charg_tempo
dddw_code_wdivsin_charg_tempo dddw_code_wdivsin_charg_tempo
dw_code_equivalence dw_code_equivalence
dw_stk_ifr dw_stk_ifr
dddw_ifr_marque dddw_ifr_marque
dw_code_mb dw_code_mb
dddw_ifr_modele dddw_ifr_modele
cb_categ cb_categ
cb_excel cb_excel
dddw_dty_modele dddw_dty_modele
dddw_dty_marque dddw_dty_marque
dw_code_rf dw_code_rf
dw_stk_codic_darty dw_stk_codic_darty
dw_div_pdet dw_div_pdet
dw_w_div_det dw_w_div_det
cb_valid_factu cb_valid_factu
dw_dossuivipar dw_dossuivipar
st_mode_reprise st_mode_reprise
cb_aide_mode_reprise cb_aide_mode_reprise
cb_aide_base_manuelle cb_aide_base_manuelle
cb_journal cb_journal
uo_consult_euro uo_consult_euro
st_pause_api_lab st_pause_api_lab
dw_wreg_frais_annexe_frn dw_wreg_frais_annexe_frn
st_attente_diverse st_attente_diverse
end type
global w_tm_sp_sinistre w_tm_sp_sinistre

type prototypes

end prototypes

type variables
Private :
	u_gs_sp_sinistre		iuoGsSpSinistre
	u_gs_sp_sinistre_contact_trace iuoGsSpContTrace
	N_Cst_Saisie_Validation_Sinistre	invSaisieValSin

	Boolean			ibSaisieValidation

	//JFF 10/04/2006 Migration PB8-SPB-04/2006 
	Boolean			bFenValAOuvrir
	
	String			isTypeTrt
	String			isDetailConsult
	String			isFicEssaiTrc
	String			isFicEssaiTrcRout

	String			isATraiterPar

	W_Tm_Sp_Interlocuteur	iW_Tm_Sp_Interlocuteur
	W_Tm_Sp_W_Gar_Sin	iW_Tm_Sp_W_Gar_Sin
	W_T_Sp_Message		iW_T_Sp_Message
	W_Tm_Sp_W_Contact	iW_Tm_Sp_W_Contact
	W_T_Sp_Cree_Travail	iW_T_Sp_Cree_Travail	
	W_Sp_Gs_W_Commande2	iW_Sp_Gs_W_Commande2

Protected :
	String			isCodEtat
	String			isCodAction
	String			isCodOper
	String			isIdCorb
	String			isTxtMess

	Boolean			ibAltContact
	Boolean			ibAltContactSherpa
	Boolean			ibAltCmdMobile
	Boolean			ibAltCommune   // DCMP 030362 Gestion des commune O/N

	Long			ilNoBoite // DCMP 020450

end variables

forward prototypes
public function boolean wf_preparermodifier ()
private subroutine wf_positionnerobjets ()
public function string wf_controlersaisie ()
public function boolean wf_terminervalider ()
public function boolean wf_suite_valider ()
private subroutine wf_tb_consultation ()
public function boolean wf_preparervalider ()
private subroutine wf_enabled_fenetre (string asmonnaie)
private function boolean wf_creationgti_sfr (long alidgti)
public subroutine wf_script_client_focus ()
private function boolean wf_creationgti_cle (long alidgti)
private function string wf_gti_panne_pgc_auchan (string asfiltre)
public subroutine wf_afficher_doc (string asnomfichier, string astitreerr)
public function boolean wf_blocage_ouv_gti ()
public function string wf_gti_denree_alim_auchan (string asfiltre)
public function string wf_gti_somme_forfaitaire (string asfiltre)
public subroutine wf_sav_bt_test_hub ()
end prototypes

event ue_quitteronglet011;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::Ue_QuitterOngler011
//* Evenement 		: Ue_QuitterOngler011
//* Auteur			: Erick John Stark
//* Date				: 05/02/1998 15:50:39
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On déclenche un ItemFocusChanged avant toute chose. Cela         */
/* concerne les zones COD_CIV, ID_ETS.                              */
/*------------------------------------------------------------------*/

If	dw_1.AcceptText () > 0 Then
	dw_1.TriggerEvent ( ItemFocusChanged! )
	
	If dw_w_Div_Sin.AcceptText () > 0 Then
		dw_w_Div_Sin.TriggerEvent ( ItemFocusChanged! )
	End If

Else
	uo_Ong.ibStop = True
End If

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event ue_valider_dossier;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::Ue_Valider_Dossier
//* Evenement 		: Ue_Valider_Dossier
//* Auteur			: Erick John Stark
//* Date				: 05/11/1998 11:04:08
//* Libellé			: 
//* Commentaires	: On vient de clicker sur le bouton pour valider le dossier
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

s_Pass stPass_Dga
String sNoBoite

//Migration PB8-WYNIWYG-03/2006 OR
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

/*------------------------------------------------------------------*/
/* On passe le nom du fichier de trace pour l'essai d'écriture en   */
/* paramêtre.                                                       */
/*------------------------------------------------------------------*/
stPass_Dga.sTab[1] = isFicEssaiTrc

iuoGsSpSinistre.Uf_Traitement ( 10, stPass_Dga )

If	stPass_Dga.bRetour Then

	If ibAltContact Then 
		iuoGsSpContTrace.uf_EcrireTrace ( 2 )
	End If

	isCodAction = "1"
//Migration PB8-WYNIWYG-03/2006 OR
//	TriggerEvent ( "Ue_Retour", 1, 1 )
	ll_ret = TriggerEvent ( "Ue_Retour", 1, 1 )
//Fin Migration PB8-WYNIWYG-03/2006 OR
End If

//Migration PB8-WYNIWYG-03/2006 OR
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event ue_choix_garantie;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::Ue_Choix_Garantie
//* Evenement 		: Ue_Choix_Garantie
//* Auteur			: Erick John Stark
//* Date				: 26/11/1998 17:33:12
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  CAG	06/02/2003  Ajout de la dw DET_PRO
//*			FPI	01/12/2010	[ITSM49138]
//*     JFF  26/06/2012 [CONFO][NV_PROCESS]
//      JFF  07/05/2013 [RS3552_REVCOUVGTI]
//      JFF  03/10/2024 [20241003154106547]
//      JFF  17/10/2024 [MON209_POPUP]
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On vient de la fenêtre W_T_SP_CHOIX_GARANTIE. L'utilisateur      */
/* vient soit de choisir une garantie, soit de faire retour. On va  */
/* récupérer ce choix. On va ensuite récupérer le cout moyen de la  */
/* garantie. Et pour finir, on ouvre la fenêtre de traitement des   */
/* GARANTIES.                                                       */
/*------------------------------------------------------------------*/
s_Pass	stPass_Dga
String sRech, sFiltre, sVal
Long lTotCodeGarantie, lLig, lIdProd, lIdRev
Boolean bRet, bFin
Long lDeb, lFin, lCptDetPro, lCpt360
n_cst_string lnvString

stPass_Dga.lTab[1] = Message.LongParm

// [RS3552_REVCOUVGTI]
lIdProd = dw_1.GetItemNumber ( 1, "ID_PROD" ) 
lIdRev  = dw_1.GetItemNumber ( 1, "ID_REV" ) 

// [20241003154106547]
If stPass_Dga.lTab[1] > 0 Then
	If lIdRev < 0 Then
		stMessage.sTitre		= "Dossier non couvert"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= False
		stMessage.bouton     = YesNo!
		stMessage.sCode = "WSIN883 "
		If f_Message ( stMessage )	= 2 Then 
			sFiltre = ""
			dw_CodeGarantie.SetFilter ( sFiltre )
			dw_CodeGarantie.Filter ()
			dw_CodeGarantie.Sort ()
			Return
		End If 
	Else 
		If SQLCA.PS_S_GTI_COUVERTE_SUR_REV ( lIdProd, lIdRev, stPass_Dga.lTab[1] ) <= 0 Then
			stMessage.sTitre		= "Garantie non couverte"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= False
			stMessage.bouton     = YesNo!			
			stMessage.sCode = "WSIN884"
			stMessage.sVar[1] = String ( lIdRev ) 
			If f_Message ( stMessage )	= 2 Then 
				sFiltre = ""
				dw_CodeGarantie.SetFilter ( sFiltre )
				dw_CodeGarantie.Filter ()
				dw_CodeGarantie.Sort ()
				Return
			End If 
		End If 
	End IF 
	
	// MON209_POPUP
	If F_CLE_A_TRUE ( "MON209_POPUP" ) Then
		If stPass_Dga.lTab[1] = 7 Then
			
			F_RechDetPro ( lDeb, lFin, dw_Det_Pro, dw_1.GetItemNumber ( 1, "ID_PROD" ), "-DP", 360 )
			For lCpt360 = lDeb To lFin 
				sVal = F_CLE_VAL ( "ID_CAS", dw_Det_Pro.GetItemString( lCpt360, "VAL_CAR"), ";")
				If sVal = "MON209_DECLA_UFS_LCL_CB" Then
					bFin = False
					Do While Not bFin
						stMessage.sTitre		= "déclaration UFs LCL CB"
						stMessage.Icon			= Exclamation!
						stMessage.bErreurG	= FALSE
						stMessage.Bouton		= YESNO!
						stMessage.sCode		= "WSIN906"
						If F_Message ( stMessage ) = 1 Then bFin = TRUE
					Loop
					Exit
				End If
			Next 
		End If 
	End If 
	
	
End If 

/*------------------------------------------------------------------*/
/* On teste la valeur de retour qui correspond à l'armement de      */
/* ID_GTI.                                                          */
/*------------------------------------------------------------------*/
If	stPass_Dga.lTab[1] <> -1 Then

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
// [ITSM49138]
//	If wf_CreationGti_SFR ( stPass_Dga.lTab[1] )	Then
bRet =  wf_CreationGti_SFR ( stPass_Dga.lTab[1] )
If bRet Then bRet= wf_creationgti_cle( stPass_Dga.lTab[1] )


if bRet Then
// :[ITSM49138]
/*------------------------------------------------------------------*/
/* On récupére le cout moyen. La DW sur le code garantie n'est      */
/* plus filtrée. Il faut donc faire une recherche sur l'ID_GTI.     */
/*------------------------------------------------------------------*/
		sRech 				= "ID_GTI = " + String ( stPass_Dga.lTab[1] )
		lTotCodeGarantie	= dw_CodeGarantie.RowCount ()
		lLig					= dw_CodeGarantie.Find ( sRech, 1, lTotCodeGarantie )
		stPass_Dga.lTab[2] 	= dw_CodeGarantie.GetItemNumber ( lLig, "MT_CMT" )

/*------------------------------------------------------------------*/
/* Les valeurs suivantes doivent être armées manuellement. Sinon,   */
/* la fonction F_OuvreTraitement ne peut pas marcher.               */
/*------------------------------------------------------------------*/
		stPass_Dga.wParent	= This
		stPass_Dga.trTrans	= itrTrans
		isDetailActif			= "dw_lst_gti"

/*------------------------------------------------------------------*/
/* On positionne ensuite les valeurs standards pour l'ouverture     */
/* d'un détail.                                                     */
/*------------------------------------------------------------------*/
		stPass_Dga.bInsert		= True
		stPass_Dga.bControl		= True

		stPass_Dga.sTab [ 1 ]	= This.Title
		stPass_Dga.sTab [ 2 ]	= isTypeTrt
		// stPass_Dga.sTab [ 3 ]	// Déjà utiliser sur ue_modifier
		stPass_Dga.sTab [ 4 ]	= dw_1.GetItemString ( 1, "NUM_IMEI_PORT" ) // n° IMEI provenant de l'adhésion (a pu être modifié depuis l'ouverture du sinistre)
		stPass_Dga.sTab [ 5 ]	= Trim ( Upper ( dw_1.GetItemString ( 1, "MARQ_PORT" ) ))
		stPass_Dga.sTab [ 6 ]	= dw_1.GetItemString ( 1, "MODL_PORT" )
		stPass_Dga.sTab [ 7 ]	= dw_1.GetItemString ( 1, "NUM_IMEI_PORT", Primary!, TRUE ) // DCMP 030407 n° IMEI provenant de l'adhésion (N'A PAS ETE modifié depuis l'ouverture du sinistre)
		stPass_Dga.sTab [ 8 ]	= iuoGsSpSinistre.uf_Determiner_Referentiel ( iuoGsSpSinistre.uf_GestOng_Divers_Trouver ( "TYPE_APP" )) // Référentiel utilisé en fct du type d'appareil (Téléphonie)

		stPass_Dga.bTab [ 1 ]	= ibAltCmdMobile
		stPass_Dga.bTab [ 2 ]	= ibAltCommune

		stPass_Dga.dwTab [ 1 ]	= Dw_Lst_Gti
		stPass_Dga.dwTab [ 2 ]	= Dw_Lst_Inter
		stPass_Dga.dwTab [ 3 ]	= Dw_w_commande

		stPass_Dga.udwTab [ 1 ]	= Dw_w_Div_Sin   // #3
		stPass_Dga.udwTab [ 2 ]	= dw_w_div_Det       // DataWindow Stockage Données onglet divers details

		stPass_Dga.dwMaster		= dw_1

		stPass_Dga.dwNorm [  1 ]	= dw_Produit			// DataWindow PRODUIT
		stPass_Dga.dwNorm [  2 ]	= dw_CodeGarantie		// DataWindow CODE_GARANTIE
		stPass_Dga.dwNorm [  3 ]	= dw_CodeCondition	// DataWindow CODE_CONDITION
		stPass_Dga.dwNorm [  4 ]	= dw_Piece				// DataWindow PIECE
		stPass_Dga.dwNorm [  5 ]	= dw_Motif				// DataWindow MOTIF
		stPass_Dga.dwNorm [  6 ]	= dw_Franchise			// DataWindow FRANCHISE
		stPass_Dga.dwNorm [  7 ]	= dw_Plafond			// DataWindow PLAFOND
		stPass_Dga.dwNorm [  8 ]	= dw_Delai				// DataWindow DELAI
		stPass_Dga.dwNorm [  9 ]	= dw_Garantie			// DataWindow GARANTIE
		stPass_Dga.dwNorm [ 10 ]	= dw_Condition			// DataWindow CONDITION
		stPass_Dga.dwNorm [ 11 ]	= dw_wDetail			// DataWindow W_DETAIL
		stPass_Dga.dwNorm [ 12 ]	= dw_wPiece				// DataWindow W_PIECE
		stPass_Dga.dwNorm [ 13 ]	= dw_wRefus				// DataWindow W_REFUS
		stPass_Dga.dwNorm [ 14 ]	= dw_wParaPlafond		// DataWindow W_PARA_PLAFOND
		stPass_Dga.dwNorm [ 15 ]	= dw_cmde_typ_frn		// DataWindow sur COMMANDE_TYPE, pour le choix des fournisseurs
		stPass_Dga.dwNorm [ 16 ]	= dw_cmde_typ_art		// DataWindow sur COMMANDE_TYPE, pour le choix des articles
		stPass_Dga.dwNorm [ 17 ]	= dw_Horaire_Rdv		// DataWindow pour les horaires de rendez-vous
		stPass_Dga.dwNorm [ 18 ]	= dw_Zone_Fournisseur // DataWindow sur la table ZONE_FOURNISSEUR

/*------------------------------------------------------------------*/
/* Modification SFR # Le 27/09/02                                   */
/*------------------------------------------------------------------*/
		stPass_Dga.dwNorm [ 19 ]	= dw_Lst_Gamme				// DataWindow sur la table GAMME
// CAG le 03/10/02
		stPass_Dga.dwNorm [ 20 ]	= dw_Det_Article			// DataWindow sur la table DET_ARTICLE
		stPass_Dga.dwNorm [ 21 ]	= dw_Det_Hlr				// DataWindow sur la table DET_HLR
/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
		stPass_Dga.dwNorm [ 22 ]	= dw_Det_Pro					// DataWindow DET_PRO
		stPass_Dga.dwNorm [ 23 ]	= dw_Commune
		stPass_Dga.dwNorm [ 24 ]	= dw_Tac_Imei

		stPass_Dga.dwNorm [ 25 ]	= dw_Stk_IFR			// DataWindow Stockage Données IFR 
		stPass_Dga.dwNorm [ 26 ]	= dw_Code_Equivalence	// DataWindow Stockage Libellés IFR Traduit 
		stPass_Dga.dwNorm [ 27 ]	= dw_autorisation    // Table autorisation
		stPass_Dga.dwNorm [ 28 ]	= dw_Stk_Codic_Darty	// DataWindow Stockage Données CODIC DARTY #3
		stPass_Dga.dwNorm [ 29 ]	= dw_code_mb         // DataWindow Stockage Données MARQUE diverses (-MB)
		stPass_Dga.dwNorm [ 30 ]	= dw_div_pDet        // DataWindow Stockage Données param onglet divers details
		stPass_Dga.dwNorm [ 31 ]	= dddw_codecar_wdivsin_charg_tempo // Chargement tempo des codes pour W_Div_Det
		stPass_Dga.dwNorm [ 32 ]	= dddw_code_wdivsin_charg_tempo // Chargement tempo des codes pour W_Div_Det
		stPass_Dga.dwNorm [ 33 ]	= dw_wdetail   // [CONFO][NV_PROCESS]

		F_OuvreTraitement ( iW_Tm_Sp_W_Gar_Sin, stPass_Dga )	
	End If
/*------------------------------------------------------------------*/
/* La fenêtre W_T_SP_CHOIX_GARANTIE ne va être fermée que           */
/* maintenant. En effet, on ne fait que des TriggerEvent dans la    */
/* fenêtre. Le CLOSE de la fenêtre se fait donc en dernier.         */
/*------------------------------------------------------------------*/
End If

/*------------------------------------------------------------------*/
/* On enleve le filtre sur CODE_GARANTIE.                           */
/*------------------------------------------------------------------*/
sFiltre = ""
dw_CodeGarantie.SetFilter ( sFiltre )
dw_CodeGarantie.Filter ()
dw_CodeGarantie.Sort ()

end event

event ue_entreronglet041;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::Ue_EntrerOngler041
//* Evenement 		: Ue_EntrerOngler041
//* Auteur			: Fabry JF
//* Date				: 29/04/2005 15:50:39
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

dw_w_div_sin.SetColumn ( 1 )
If dw_w_div_sin.Rowcount () > 0 Then dw_w_div_sin.SetRow (1)
dw_w_div_sin.SetFocus ()

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event ue_taillefenetre();//*-----------------------------------------------------------------
//*
//* Objet 			: Ue_TailleFenetre
//* Evenement 		: Ue_TailleFenetre
//* Auteur			: Fabry JF
//* Date				: 16/10/2019
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

// Je réajuste la hauteur pour W10


// [PB2022_TAILLE_FEN] je commente
// This.Height = 1810




end event

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Sinistre::Wf_PreparerModifier
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 18:25:09
//* Libellé			: 
//* Commentaires	: Opération avant modification
//*
//* Arguments		: Rien
//*
//* Retourne		: Boolean		Vrai = On peut continuer
//*										Faux = Il y a une erreur
//*
//*-----------------------------------------------------------------
//* MAJ 			PAR		Date		Modification
//* DCMP990451	JFF		29/09/99 Affichage du message d'ouverture de 
//*										de pochette				  
//* #1			JFF		24/04/2001 CONTACTDNT : Gestion contacts.
//* #2		   JFF		05/09/2002 Gestion de la gestion de contact uniquement pour Sherpa
//* #3	FPI	06/10/2009	[DCMP090595] Ajout du btn cb_valid_factu
//* #4	 FPI  09/02/2010 [DCMP090595.Correctif] Btn Valid_factu caché si pbcontroler caché
//      JFF   23/05/2012 [PM103][1]
//      JFF   12/05/2016 [MOTEUR_RECH_IFR]
//*-----------------------------------------------------------------

s_Pass	stPass_Dga
String	sMonnaie, sNoBoite
Long		lPochette, lDeb, lFin


// DCMP990451
st_Pochette.Hide()

//If	isTypeTrt = "V"	Then	Pb_Validation_Dossier.Enabled	= TRUE

isATraiterPar = ""

stPass_Dga.sTab [ 1 ] = istPass.sTab [ 1 ]			// ID_SIN en cours de traitement
stPass_Dga.sTab [ 2 ] = istPass.sTab [ 2 ]			// Nous sommes en saisie
stPass_Dga.sTab [ 3 ] = istPass.sTab [ 3 ]			// Provenance du courrier recu (A)ssuré, (B)anque
stPass_Dga.sTab [ 4 ] = istPass.sTab [ 4 ]			// Type de courrier recu (Q)uestionnaire, (F)ax, (T)éléphone, (C)ourrier
stPass_Dga.sTab [ 5 ] = istPass.sTab [ 5 ]			// Date du dernier courrier client (DTE_COUR_CLI)

If	isTypeTrt = "S"	Then
	stPass_Dga.sTab [ 6 ] = stGLB.sMonnaieFormatDesire			// On est en saisie, on arme le format de la monnaie pour le TreeView
Else
	sMonnaie = Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()
	stPass_Dga.sTab [ 6 ] = sMonnaie									// On est en consultation, on arme le format de la monnaie pour le TreeView
End If

iuoGsSpSinistre.Uf_Traitement ( 2, stPass_Dga )
/*------------------------------------------------------------------*/
/* Le 16/10/2001. Modif DGA                                         */
/* Gestion Saisie/Validation.                                       */
/*------------------------------------------------------------------*/
If Not stPass_Dga.bRetour Then
	Return ( stPass_Dga.bRetour )
End If 

If	ibSaisieValidation Then
	invSaisieValSin.uf_Preparer_Instance ( String ( dw_1.GetItemNumber ( 1, "ID_SIN" )), dw_Lst_Inter, isTypeTrt )
End If


/*------------------------------------------------------------------*/
/* DGA. Le 21/08/2003.                                              */
/* Gestion des boites archives.                                     */
/*------------------------------------------------------------------*/
If Not stPass_Dga.bTab[1]	Then 
	If	isTypeTrt = "V"	Then	Pb_Validation_Dossier.Enabled	= FALSE
	Cb_NoBoite.Enabled				= FALSE
Else
	If	isTypeTrt = "V"	Then	Pb_Validation_Dossier.Enabled	= TRUE
	Cb_NoBoite.Visible				= dw_BoiteArchive.Visible
	Cb_NoBoite.Enabled				= TRUE
End If

/*------------------------------------------------------------------*/
/* #1 : On mémorise la Gestion Contact.									  */
/*------------------------------------------------------------------*/
ibAltContact = dw_Produit.GetItemString ( 1, "ALT_CONTACT" ) = "O"
ibAltContactSherpa = False

/*------------------------------------------------------------------*/
/* #2 : JFF le 04/09/2002														  */
/*------------------------------------------------------------------*/
If Not ibAltContact Then
	ibAltContactSherpa = dw_Produit.GetItemString ( 1, "ALT_CONTACT" ) = "S"
End If
ibAltCmdMobile = dw_Produit.GetItemString ( 1, "ALT_CMD_MOBILE" ) = "O"

Uo_Ong.Uf_ActiverOnglet ( "04", dw_w_div_sin.RowCount () > 0 )
Uo_Ong.Uf_ActiverOnglet ( "05", ibAltCmdMobile )

/*------------------------------------------------------------------*/
/* Au retour, on arme le titre de l4a fenêtre de la manière          */
/* suivante.                                                        */
/* Code Produit + Libellé Produit + N° Dossier + Nom + Prénom.      */
/*------------------------------------------------------------------*/
If	stPass_Dga.bRetour Then
	This.Title = stPass_Dga.sTab [ 1 ]
End If

/*------------------------------------------------------------------*/
/* JFF le 29/08/01.																  */
/* Certaines erreurs arrivent à ce moment le retrieve a eu lieu,    */
/* mais la ligne n'est pas encore dans la dw_1. De cette façon on   */
/* boucle jusqu'à tant que la ligne soit présente.                  */
/*------------------------------------------------------------------*/
Do While Dw_1.RowCount () <= 0 
	Yield ()
Loop

If isTypeTrt = "S" Then
	/*------------------------------------------------------------------*/
	/* Modif suite DCMP990451                                           */
	/*------------------------------------------------------------------*/
	lPochette = -1

	iTrTrans.PS_S02_W_QUEUE_POCHETTE	( Dw_1.GetItemNumber ( 1, "ID_SIN"), "CONSULT" , lPochette )

	// << Veuillez ouvrir une pochette pour ce complément >>
	If lPochette = 1 Then
		/*------------------------------------------------------------------*/
		/* #4                                                               */
		/*------------------------------------------------------------------*/
//		st_Pochette.Text =  ProfileString ( stGlb.sFichierErreur, "MESSAGE", "WORK360", "Message Pochette Introuvable" )
		st_Pochette.Text = "Poch1"
		st_Pochette.Show()
	End If
End If

If	isTypeTrt = "C"	Then
	sMonnaie = Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()
	Uo_Consult_Euro.Uf_Changer_Monnaie ( sMonnaie )

	/*------------------------------------------------------------------*/
	/* Modif suite DCMP990451                                           */
	/*------------------------------------------------------------------*/
	lPochette = -1

	iTrTrans.PS_S02_W_QUEUE_POCHETTE	( Dw_1.GetItemNumber ( 1, "ID_SIN"), "CONSULT" , lPochette )

	/*------------------------------------------------------------------*/
	/* #4                                                               */
	/*------------------------------------------------------------------*/
	// << Veuillez ouvrir une pochette pour ce complément >>
	If lPochette = 1 Then

//		st_Pochette.Text =  ProfileString ( stGlb.sFichierErreur, "MESSAGE", "WORK360", "Message Pochette Introuvable" )
		st_Pochette.Text = "Poch1"
		st_Pochette.Show()

	// << Pochette à Ouvrir lors de la réception du prochain complément >>
	ElseIf lPochette = 2 Then

//		st_Pochette.Text =  ProfileString ( stGlb.sFichierErreur, "MESSAGE", "WORK370", "Message Pochette Introuvable" )
		st_Pochette.Text = "Poch2"
		st_Pochette.Show()
	End If
End If

cb_Aide.uf_SetIdProd ( dw_1.GetItemNumber ( 1, "ID_PROD" ) )
cb_Notice.uf_SetIdProd ( dw_1.GetItemNumber ( 1, "ID_PROD" ) )
cb_Excel.uf_SetIdProd ( dw_1.GetItemNumber ( 1, "ID_PROD" ) )

/*------------------------------------------------------------------*/
/* DMDI 7718 Ajout d'un message : ! Ets 01001 : vérifier si         */
/* souscription du SECURITE PLUS en inclusion"                      */
/*------------------------------------------------------------------*/
If dw_1.GetItemNumber ( 1, "ID_PROD" ) = 6700 And &
	dw_1.GetItemNumber ( 1, "ID_ETS" ) = 1001 Then 
	stMessage.sTitre		= "Information"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "GENE080"

	F_Message ( stMessage )
End If

// #12 - [DCMP090595] 
If iuogsspsinistre.uf_getautorisation2( 208) and pb_controler.Visible Then // #4 - [DCMP090595.Correctif] ajout de la 2ème condition
	cb_valid_factu.X=1687
	cb_valid_factu.Y=9
	cb_valid_factu.Enabled = TRUE
	cb_valid_factu.Visible=TRUE
	
	if istypetrt ="V" Then
		cb_valid_factu.X=1687
		cb_valid_factu.width=719
		cb_valid_factu.textsize=-8
		cb_valid_factu.text="Validation factu."
		cb_valid_factu.BringToTop = TRUE
	End if
Else
	cb_valid_factu.Visible=FALSE
	cb_valid_factu.Enabled=FALSE
End if

// [PM103][1]
// A supprimer quand ce sera en prod
cb_aide_mode_reprise.Visible = FALSE
cb_aide_base_manuelle.Visible=FALSE
st_mode_reprise.Visible = FALSE
gbModeReprise_223 = False
gbModeReprise_223 = iuoGsSpSinistre.uf_GetAutorisation2 ( 223 )
cb_aide_mode_reprise.Visible = gbModeReprise_223
st_mode_reprise.Visible = gbModeReprise_223
cb_aide_base_manuelle.Visible=gbModeReprise_223
// :[PM103][1]

// [MOTEUR_RECH_IFR]
dw_1.object.b_rech_ifr.visible = 0
If isTypeTrt = "S" Then	
	dw_1.object.b_rech_ifr.visible = 1
	If dw_produit.GetItemNumber ( 1, "COD_TEL" ) = 0 Then
		dw_1.object.b_rech_ifr.visible = 0
	End If
End If

// Couleur Bt journal
If SQLCA.PS_S_TRACE_JOURNAL_DELAI () = 1 Then
	cb_journal.weight = 700
Else 
	cb_journal.weight = 400
End If 

// [JOURNAL]
cb_journal.show ()

Return ( stPass_Dga.bRetour )

end function

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Sinistre::Wf_PositionnerObjets (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 15:27:47
//* Libellé			: 
//* Commentaires	: On positionne et on taille tous les objets
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* DCMP990451 JFF		29/09/99 On positionne le static text informant 
//*										de l'ouverture d'une pochette ou pas.
//* #1  CAG		08/07/2004 DCMP 030381 : Ajout d'un btn pour aff des
//*								polices-assurances des gti du produit du dr
//* #2  CAG		08/11/2004 DCMP 040366 : Ajout d'un btn pour aff la
//*								catégorie des courrier, uniquement en validation
//      JFF   23/05/2012 [PM103][1]
//      JFF   29/08/2023 [RS5666_DOS_SUIVI_PAR]
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne tous les objets nécessaires à la gestion, pour     */
/* faciliter le développement. (On peut bouger les objets).         */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Barre Onglet                                                     */
/*------------------------------------------------------------------*/
Uo_Ong.X			=   10
Uo_Ong.Y			=  157 + 1  // [PB2022_TAILLE_FEN] + 1
Uo_Ong.Width	=  109

/*------------------------------------------------------------------*/
/* Dw_1 et les autres comprises dans l'onglet.                      */
/*------------------------------------------------------------------*/
Dw_1.X			=   50
Dw_1.Y			=  310
Dw_1.Width		= 3480
Dw_1.Height		= 1320

/*------------------------------------------------------------------*/
/* Liste Interlocuteurs                                             */
/*------------------------------------------------------------------*/
Dw_Lst_Inter.X			= Dw_1.X + 350 
Dw_Lst_Inter.Y			= Dw_1.Y
Dw_Lst_Inter.Width	= Dw_1.Width - 350
Dw_Lst_Inter.Height	= Dw_1.Height

/*------------------------------------------------------------------*/
/* Liste des Garanties                                              */
/*------------------------------------------------------------------*/
Dw_Lst_Gti.X		= Dw_1.X
Dw_Lst_Gti.Y		= Dw_1.Y
Dw_Lst_Gti.Width	= Dw_1.Width
Dw_Lst_Gti.Height	= Dw_1.Height

/*------------------------------------------------------------------*/
/* Le static Text : St_Pochette DCMP990451								  */
/*------------------------------------------------------------------*/
/* #1 CAG 08/07/2004 : positionnement du btn => deplt de la poch.   */
/*------------------------------------------------------------------*/
/* #2 CAG 08/11/2004 : positionnement du btn => deplt de la poch.   */
/*------------------------------------------------------------------*/
st_Pochette.X			=  2203
st_Pochette.Y			=    8
st_Pochette.Width		=  201
st_Pochette.Height	=   60

/*------------------------------------------------------------------*/
/* Liste des Contacts                                               */
/*------------------------------------------------------------------*/
dw_lst_contact.X			= Dw_1.X
dw_lst_contact.Y			= Dw_1.Y
dw_lst_contact.Width		= Dw_1.Width
dw_lst_contact.Height	= Dw_1.Height

/*------------------------------------------------------------------*/
/* Dossier suivi par                                                */
/*------------------------------------------------------------------*/
dw_DosSuiviPar.X			= 2414
dw_DosSuiviPar.Y			=    1
dw_DosSuiviPar.width		= 1198
dw_DosSuiviPar.Height	=   89

// [RS5666_DOS_SUIVI_PAR]
dw_DosSuiviPar.Hide()

/*------------------------------------------------------------------*/
/* DGA. Le 21/08/2003.                                              */
/* Gestion des boites archives.                                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* N° boîte archive                                                 */
/*------------------------------------------------------------------*/
dw_BoiteArchive.X			= 2451
dw_BoiteArchive.Y			=   93
dw_BoiteArchive.Width	= 1020
dw_BoiteArchive.Height	=   89

Cb_NoBoite.X				= 3466
Cb_NoBoite.Y				=   97
Cb_NoBoite.Width			=   97
Cb_NoBoite.Height			=   69

/*------------------------------------------------------------------*/
/* Dw Commandes																	  */
/*------------------------------------------------------------------*/
dw_w_commande.X			= Dw_1.X + 350
dw_w_commande.Y			= Dw_1.Y
dw_w_commande.Width		= Dw_1.Width - 350
dw_w_commande.Height		= Dw_1.Height

/*------------------------------------------------------------------*/
/* Dw Divers Sinistres															  */
/*------------------------------------------------------------------*/
dw_w_div_sin.X			=   50
dw_w_div_sin.Y			=  310
dw_w_div_sin.Width		= 3480
dw_w_div_sin.Height		= 1320

/*------------------------------------------------------------------*/
/* #1 CAG 08/07/2004                                                */
/*------------------------------------------------------------------*/
Cb_PolAss.X				= 1413
Cb_PolAss.Y				= 9
Cb_PolAss.Width		= 275
Cb_PolAss.Height		= 69

/*------------------------------------------------------------------*/
/* #2 CAG 08/11/2004                                                */
/*------------------------------------------------------------------*/
Cb_Categ.X				= 1893
Cb_Categ.Y				= 9
Cb_Categ.Width			= 275
Cb_Categ.Height		= 69

// [PM103][1]
st_mode_reprise.X = 2459
st_mode_reprise.Y = 152
st_mode_reprise.Width = 800
st_mode_reprise.Height = 96

cb_aide_mode_reprise.X = 3273
cb_aide_mode_reprise.Y = 152
cb_aide_mode_reprise.Width = 251
cb_aide_mode_reprise.Height = 100
// :[PM103][1]

cb_Journal.X = 1687
cb_Journal.Y = 8
cb_Journal.Width = 210
cb_Journal.Height= 68



end subroutine

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_ControlerSaisie (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:50:46
//* Libellé			: 
//* Commentaires	: Contrôle de la saisie
//*
//* Arguments		: Aucun
//*
//* Retourne		: String			"" = Tout va bien
//*-----------------------------------------------------------------
//* MAJ 			PAR		Date		Modification
//* DCMP990451	JFF		29/09/99 Affichage du message d'ouverture de 
//*										de pochette				  

//*-----------------------------------------------------------------

Long		lPochette
s_Pass	stPass_Dga

// DCMP990451
st_Pochette.Hide()

iuoGsSpSinistre.Uf_Traitement ( 4, stPass_Dga )

If stPass_Dga.sTab [ 1 ] = ""	Then

	/*------------------------------------------------------------------*/
	/* Modif suite DCMP990451                                           */
	/*------------------------------------------------------------------*/
	lPochette = -1

	iTrTrans.PS_S02_W_QUEUE_POCHETTE	( Dw_1.GetItemNumber ( 1, "ID_SIN"), "ENCOURS" , lPochette )

	// << Veuillez ouvrir une pochette pour ce complément >>
	If lPochette = 1 Then

		/*------------------------------------------------------------------*/
		/* #4                                                               */
		/*------------------------------------------------------------------*/
//		st_Pochette.Text =  ProfileString ( stGlb.sFichierErreur, "MESSAGE", "WORK360", "Message Pochette Introuvable" )
		st_Pochette.Text = "Poch1"
		st_Pochette.Show()

//	// << Pochette à Ouvrir lors de la réception du prochain complément >>
//	ElseIf lPochette = 2 And Dw_Lst_Inter.Find ( "ALT_QUEST = 'O'", 1, Dw_Lst_Inter.RowCount () ) > 0 Then
//
//		st_Pochette.Text =  ProfileString ( stGlb.sFichierErreur, "MESSAGE", "WORK370", "Message Pochette Introuvable" )
//		st_Pochette.Show()
//
	End If

End If

Return ( stPass_Dga.sTab [ 1 ] ) 




end function

public function boolean wf_terminervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Sinistre::Wf_TerminerModifier
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 18:25:09
//* Libellé			: 
//* Commentaires	: Opération aprés Validation de dw_1
//*
//* Arguments		: Rien
//*
//* Retourne		: Boolean		Vrai = On peut continuer
//*										Faux = Il y a une erreur
//*
//*-----------------------------------------------------------------

s_Pass	stPass_Dga

iuoGsSpSinistre.Uf_Traitement ( 7, stPass_Dga )

Return ( stPass_Dga.bRetour )

end function

public function boolean wf_suite_valider ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Sinistre::Wf_Suite_Valider (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 25/06/1998 09:53:19
//* Libellé			: 
//* Commentaires	: On va maintenant valider les BLOBS
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		True 	= La validation est OK
//*										FAlse	= Problème de validation
//*-----------------------------------------------------------------
//* #1	JFF	16/03/2004	DCMP 040020 SVE
//* #2	JFF/DGA  06/04/2006 Migration PB8-SPB-04/2006
//       JFF   12/06/2014  [PI052]
//*-----------------------------------------------------------------

String	sTab[]
s_Pass stPass_Dga
Boolean	bOk, bVal
s_Pass	nvTrtAttribGenCour  // #2
s_Pass  TabVariable [] // [PI052]
string  TabCodeVar[]  // [PI052]

If Dw_1.GetItemString ( 1, "ALT_EDIT" ) = "N" Then
	stPass_Dga.bRetour = True
	bOk = stPass_Dga.bRetour
Else
	If ibSaisieValidation Then
		bOk = invSaisieValSin.uf_Generer_Courrier ( sTab, "SUITE_VALIDER", False, False, bVal, nvTrtAttribGenCour, TabVariable, TabCodeVar ) = "" // #2
	Else
		iuoGsSpSinistre.Uf_Traitement ( 9, stPass_Dga )
		bOk = stPass_Dga.bRetour		
	End If
End If

/*------------------------------------------------------------------*/
/* On vient de valider les BLOBS. Si tout se passe bien, la         */
/* fonction ancêtre déclenche un PostEvent de Ue_Retour. Dans le    */
/* cas contraire, il ne se passe rien.                              */
/*------------------------------------------------------------------*/

// [PI052]
/*
If F_CLE_A_TRUE ( "PI052" ) Then
	If invSaisieValSin.ibPI052_GenEdtKsl Then
		If ibSaisieValidation Then invSaisieValSin.uf_PI052_Verif_Presence_Courrier ()
	Else
		If ibSaisieValidation Then invSaisieValSin.uf_CourWord_PurgerTouslesCourriers ()		
	End If
Else */
	If ibSaisieValidation Then invSaisieValSin.uf_CourWord_PurgerTouslesCourriers ()
// End If


Return ( bOk )





////*-----------------------------------------------------------------
////*
////* Fonction		: W_Tm_Sp_Sinistre::Wf_Suite_Valider (PUBLIC)
////* Auteur			: Erick John Stark
////* Date				: 25/06/1998 09:53:19
////* Libellé			: 
////* Commentaires	: On va maintenant valider les BLOBS
////*
////* Arguments		: Aucun
////*
////* Retourne		: Boolean		True 	= La validation est OK
////*										FAlse	= Problème de validation
////*-----------------------------------------------------------------
////* #1	JFF	16/03/2004	DCMP 040020 SVE
////*-----------------------------------------------------------------
//
//String	sTab[]
//s_Pass stPass_Dga
//Boolean	bOk, bVal
////Migration PB8-WYNIWYG-03/2006 FM
//s_Pass	lst_pass
////Fin Migration PB8-WYNIWYG-03/2006 FM
//
//If Dw_1.GetItemString ( 1, "ALT_EDIT" ) = "N" Then
//	stPass_Dga.bRetour = True
//	bOk = stPass_Dga.bRetour
//Else
//	If ibSaisieValidation Then
////Migration PB8-WYNIWYG-03/2006 FM
////		bOk = invSaisieValSin.uf_Generer_Courrier ( sTab, "SUITE_VALIDER", False, False, bVal ) = "" 
//		bOk = invSaisieValSin.uf_Generer_Courrier ( sTab, "SUITE_VALIDER", False, False, bVal, lst_pass ) = "" 
////Fin Migration PB8-WYNIWYG-03/2006 FM
//	Else
//		iuoGsSpSinistre.Uf_Traitement ( 9, stPass_Dga )
//		bOk = stPass_Dga.bRetour		
//	End If
//End If
//
///*------------------------------------------------------------------*/
///* On vient de valider les BLOBS. Si tout se passe bien, la         */
///* fonction ancêtre déclenche un PostEvent de Ue_Retour. Dans le    */
///* cas contraire, il ne se passe rien.                              */
///*------------------------------------------------------------------*/
//
//If ibSaisieValidation Then invSaisieValSin.uf_CourWord_PurgerTouslesCourriers ()
//
//
//Return ( bOk )
//
//
end function

private subroutine wf_tb_consultation ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Sinistre::Wf_Tb_Consultation (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 23/07/1998 15:44:13
//* Libellé			: 
//* Commentaires	: On est en validation/Consultation, on rend les boutons invisibles
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ 	PAR		Date			Modification
//* #1	FPI		09/02/2010	[DCMP090595.Correctif] Btn Valid_factu caché
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 CP
//DataWindow	dwNorm[4]
DataWindow	dwNorm[]
//Fin Migration PB8-WYNIWYG-03/2006 CP

/*------------------------------------------------------------------*/
/* Cette fonction est appelée sur Ue_Initialiser de la fenêtre.     */
/*------------------------------------------------------------------*/

pb_Controler.Visible 	= False
pb_Controler.Enabled 	= False

pb_Valider.Visible 		= False
pb_Valider.Enabled 		= False

pb_Supprimer.Visible 	= False
pb_Supprimer.Enabled 	= False

pb_Imprimer.Visible 		= False
pb_Imprimer.Enabled 		= False

Uo_Consult_Euro.X			= 252
Uo_Consult_Euro.Y			= 9

Uo_Consult_Euro.Visible	= False // [SUISSE].LOT3 Bouton Invisible
Uo_Consult_Euro.Enabled	= False // [SUISSE].LOT3

/*------------------------------------------------------------------*/
/* On initialise le tableau de DW pour la consultation EURO.        */
/*------------------------------------------------------------------*/

dwNorm [ 1 ] = dw_1
dwNorm [ 2 ] = dw_Lst_Gti
dwNorm [ 3 ] = dw_Lst_Inter
dwNorm [ 4 ] = dw_w_Div_Sin

Uo_Consult_Euro.Uf_Initialiser ( dwNorm[] )

// #1 - [DCMP090595.Correctif] 
cb_valid_factu.Enabled=FALSE
cb_valid_factu.Visible=FALSE
end subroutine

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Sinistre::Wf_PreparerValider
//* Auteur			: Erick John Stark
//* Date				: 04/06/1999 11:19:52
//* Libellé			: 
//* Commentaires	: On va vérifier si on peut écrire une trace.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		True	= La validation est possible
//*										False = La validation est impossible
//*-----------------------------------------------------------------
//* MAJ 			PAR		Date		Modification
//* #1			JFF	16/03/2004	DCMP 040020 SVE
//             JFF   12/06/2014  [PI052]
//*-----------------------------------------------------------------

s_Pass stPass_Dga
String	sTab[]
Boolean  bAltEdit, bAltBloc, bVal
s_Pass	nvTrtAttribGenCour  // #2
s_Pass  TabVariable [] // [PI052]
string  TabCodeVar[]  // [PI052]

/*------------------------------------------------------------------*/
/* #1																					  */
/* Gestion Saisie/Validation.                                       */
/*------------------------------------------------------------------*/
If	ibSaisieValidation Then
	bAltEdit = dw_1.GetItemString ( 1, "ALT_EDIT" ) = "O"
	bAltBloc = dw_1.GetItemNumber ( 1 , "COD_ETAT" ) = 1

	If	invSaisieValSin.uf_Generer_Courrier ( sTab, "VALIDER", bAltEdit, bAltBloc, bVal, nvTrtAttribGenCour, TabVariable, TabCodeVar ) <> ""	Then Return ( FALSE )   // #2
End If

/*------------------------------------------------------------------*/
/* On va vérifier si on peut écrire une TRACE. Si ce n'est pas le   */
/* cas, on arrete tout.                                             */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* La variable isFicEssaiTrc est positionnée sur l'événement        */
/* Ue_Initialiser de la fenêtre.                                    */
/*------------------------------------------------------------------*/
stPass_Dga.sTab[1] = isFicEssaiTrc
iuoGsSpSinistre.Uf_Traitement ( 6, stPass_Dga )

Return ( stPass_Dga.bRetour )






////*-----------------------------------------------------------------
////*
////* Fonction		: W_Tm_Sp_Sinistre::Wf_PreparerValider
////* Auteur			: Erick John Stark
////* Date				: 04/06/1999 11:19:52
////* Libellé			: 
////* Commentaires	: On va vérifier si on peut écrire une trace.
////*
////* Arguments		: Aucun
////*
////* Retourne		: Boolean		True	= La validation est possible
////*										False = La validation est impossible
////*-----------------------------------------------------------------
////* MAJ 			PAR		Date		Modification
////* #1			JFF	16/03/2004	DCMP 040020 SVE
////*-----------------------------------------------------------------
//
//s_Pass stPass_Dga
//String	sTab[]
//Boolean  bAltEdit, bAltBloc, bVal
////Migration PB8-WYNIWYG-03/2006 FM
//s_Pass	lst_pass
////Fin Migration PB8-WYNIWYG-03/2006 FM
//
///*------------------------------------------------------------------*/
///* #1																					  */
///* Gestion Saisie/Validation.                                       */
///*------------------------------------------------------------------*/
//If	ibSaisieValidation Then
//	bAltEdit = dw_1.GetItemString ( 1, "ALT_EDIT" ) = "O"
//	bAltBloc = dw_1.GetItemNumber ( 1 , "COD_ETAT" ) = 1
//
////Migration PB8-WYNIWYG-03/2006 FM
////	If	invSaisieValSin.uf_Generer_Courrier ( sTab, "VALIDER", bAltEdit, bAltBloc, bVal ) <> ""	Then Return ( FALSE )
//	If	invSaisieValSin.uf_Generer_Courrier ( sTab, "VALIDER", bAltEdit, bAltBloc, bVal, lst_pass ) <> ""	Then Return ( FALSE )
////Fin Migration PB8-WYNIWYG-03/2006 FM
//End If
//
///*------------------------------------------------------------------*/
///* On va vérifier si on peut écrire une TRACE. Si ce n'est pas le   */
///* cas, on arrete tout.                                             */
///*------------------------------------------------------------------*/
///*------------------------------------------------------------------*/
///* La variable isFicEssaiTrc est positionnée sur l'événement        */
///* Ue_Initialiser de la fenêtre.                                    */
///*------------------------------------------------------------------*/
//stPass_Dga.sTab[1] = isFicEssaiTrc
//iuoGsSpSinistre.Uf_Traitement ( 6, stPass_Dga )
//
//Return ( stPass_Dga.bRetour )
//
end function

private subroutine wf_enabled_fenetre (string asmonnaie);//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_Enabled_Fenetre (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:50:46
//* Libellé			: 
//* Commentaires	: Contrôle de la saisie
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

s_Pass	stPass_Dga

stPass_Dga.sTab[1] = asMonnaie

iuoGsSpSinistre.Uf_Traitement ( 8, stPass_Dga )





end subroutine

private function boolean wf_creationgti_sfr (long alidgti);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Sinistre::wf_CreationGti_Sfr (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 21/07/2002 09:31:39
//* Libellé			: 
//* Commentaires	: Envoi d'un certain nombre de controles avant la création de la garantie.
//*
//* Arguments		: (Val)			Long		alIdGti
//*
//* Retourne		: Boolean			TRUE		= Création de la garantie autorisée
//*											FALSE		= Création de la garantie non autorisée
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
Boolean bRet
Long lLig, lTotGti, lCpt, lTotCommande, lIdGti, lIdBsp, lIdSeq, lCodEtat
String sRech, sCodEtat, sFiltre
DateTime dtDteRetPret

bRet				= TRUE
lTotGti			= Dw_Lst_Gti.RowCount ()
lTotCommande	= Dw_w_Commande.RowCount ()

/*------------------------------------------------------------------*/
/* On interdit la création de la garantie PANNE(18) si une          */
/* garantie BRIS(11) existe déjà.                                   */
/*------------------------------------------------------------------*/
If alIdGti = 18	Then
	sRech = "ID_GTI = 11"
	lLig	= Dw_Lst_Gti.Find ( sRech, 1, lTotGti )
	
	If	lLig > 0	Then
		stMessage.sTitre		= "Gestion SFR"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "SFRP001"

		bRet = FALSE
	End If
End If

/*------------------------------------------------------------------*/
/* On interdit la création de la garantie BRIS si la garantie       */
/* PANNE existe et qu'il n'existe pas de commande en cours pour     */
/* cette garantie PANNE. De plus, s'il existe une commande pour la  */
/* garantie PANNE la date de retour de prêt doit être renseignée.   */
/*------------------------------------------------------------------*/
If	alIdGti = 11	Then
	sRech = "ID_GTI = 18 And COD_ETAT <> 'ANN'"
	lLig	= Dw_w_Commande.Find ( sRech, 1, lTotCommande )

/*------------------------------------------------------------------*/
/* Pas de commande pour la garantie PANNE.                          */
/*------------------------------------------------------------------*/
	If	lLig = 0	And Dw_Lst_Gti.Find ( "ID_GTI = 18", 1, lTotGti ) > 0  And Not iuoGsSpSinistre.uf_GetAutorisation2 ( 201 ) Then

		stMessage.sTitre		= "Gestion SFR"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "SFRP002"

		bRet = FALSE
	End If
/*------------------------------------------------------------------*/
/* La garantie PANNE doit être close.                               */
/*------------------------------------------------------------------*/
	If	bRet	Then
		lLig = Dw_Lst_Gti.Find ( "ID_GTI = 18", 1, lTotGti )
		If	lLig > 0	Then
			lCodEtat = Dw_Lst_Gti.GetItemNumber ( lLig, "COD_ETAT" )
			If	lCodEtat <> 200 And lCodEtat <> 500 And lCodEtat <> 600 And lCodEtat <> 900	Then
				bRet = FALSE

				stMessage.sTitre		= "Gestion SFR"
				stMessage.Icon			= Exclamation!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "SFRP040"
			End If
		End If
	End If

/*------------------------------------------------------------------*/
/* On vérifie maintenant que la commande en cours posséde une date  */
/* de retour de prêt.                                               */
/*------------------------------------------------------------------*/
	If	bRet	Then
		For	lCpt = 1 To lTotCommande
				lIdGti			= dw_w_Commande.GetItemNumber ( lCpt, "ID_GTI" )
				sCodEtat			= dw_w_Commande.GetItemString ( lCpt, "COD_ETAT" )
				dtDteRetPret	= dw_w_Commande.GetItemDateTime ( lCpt, "DTE_RET_PRET" )
				lIdBsp			= dw_w_Commande.GetItemNumber ( lCpt, "ID_BSP" )
				lIdSeq			= dw_w_Commande.GetItemNumber ( lCpt, "ID_SEQ" )

				If	lIdGti = 18 And sCodEtat <> "ANN"	Then
					If	lIdBsp = 0	Then
								bRet = FALSE

								stMessage.sTitre		= "Gestion SFR"
								stMessage.Icon			= Exclamation!
								stMessage.bErreurG	= FALSE
								stMessage.sVar[1]		= String ( lIdSeq )
								stMessage.Bouton		= OK!
								stMessage.sCode		= "SFRP035"

								Exit	
					ElseIf	IsNull ( lIdBsp ) Then
								bRet = FALSE

								stMessage.sTitre		= "Gestion SFR"
								stMessage.Icon			= Exclamation!
								stMessage.bErreurG	= FALSE
								stMessage.sVar[1]		= String ( lIdSeq )
								stMessage.Bouton		= OK!
								stMessage.sCode		= "SFRP060"
					End If
				End If
		Next
	End If
End If

/*------------------------------------------------------------------*/
/* Problème d'affichage du Libellé Garantie. On affiche le message  */
/* d'erreur et avant on enléve le filtre.                           */
/*------------------------------------------------------------------*/
If	Not bRet	Then
	F_Message ( stMessage )
End If

Return ( bRet )
end function

public subroutine wf_script_client_focus ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Ancetre_Traitement::Wf_Script_Client_Focus		(PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 15/03/2004 11:10:01
//* Libellé			: 
//* Commentaires	: On utilise cette fonction à la fin de l'événément Ue_Controler
//*					  afin de positionner le focus sur une autre fenêtre
//*					  On utilise cette méthode dans le cas de Saisie/Validation/Edition
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*														
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification
//* #1		 JFF	 20/11/2006 Gestion du résultat du contrôle [JFF-RESCTRL-201106]
//*-----------------------------------------------------------------

Integer iRet

If	Not ibScriptClientFocus Or Not ibResultCtrl Then Return // #1

If	ibSaisieValidation And dw_wCourrier.RowCount () > 0 And dw_1.GetItemNumber ( 1 , "COD_ETAT" ) <> 1	Then

	iRet = invSaisieValSin.uf_Positionner_Focus ()

	If	iRet = 1	Then
		Pb_Valider.Enabled		= TRUE
		Pb_Controler.Enabled		= FALSE

		pb_Valider.SetFocus ()
	End If
End If

ibScriptClientFocus	= False

end subroutine

private function boolean wf_creationgti_cle (long alidgti);//*-----------------------------------------------------------------
//*
//* Fonction		: w_tm_sp_sinistre::wf_creationgti_cle
//* Auteur			: F. Pinon
//* Date				: 01/12/2010 14:22:38
//* Libellé			: 
//* Commentaires	:	[ITSM49138]
//*
//* Arguments		: value long lidgti	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
Long lIdProd, lCodOpt
Boolean bRet

bRet=TRUE

/*Pop up sur les contrats 201 et 202 déclenchée lors de l'ouverture d'une garantie clés, 
uniquement sur les options adhésions 21-22-23-71-73 (produit 201) ou option 75 ou 77 (produit 202).
Le texte de la pop up :
ATTENTION pour l'option famille la garantie clés est gérée par AXA ASSISTANCE et non SPB.
TEL  : 0800 42 80 71
ADRESSE : AXA IARD France 26 rue DROUOT 75458 Paris Cedex 09
*/

If alIdgti <> 1 Then Return TRUE

lIdProd = dw_1.GetItemNumber(1, "ID_PROD")
lCodOpt = dw_1.GetItemNumber(1, "COD_OPT")

Choose case lIdProd
	Case 201
		Choose case lCodOpt
			Case 21,22,23,71,73,24 // [VDoc3457] ajout de l'option 24
				bRet=FALSE
		End Choose
	Case 202
		Choose case lCodOpt
			Case 75,77
					bRet=FALSE
		End Choose
End Choose

If not bRet Then
	stMessage.sTitre		= "Ajout de garantie"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.sCode	= "WGAR375"
	f_message(stMessage)
End if

Return bRet
		





end function

private function string wf_gti_panne_pgc_auchan (string asfiltre);//*-----------------------------------------------------------------
//*
//* Fonction		: w_tm_sp_sinistre::wf_gti_panne_pgc_auchan
//* Auteur			: FABRY JF
//* Date				: 25/02/2011 
//* Libellé			: [PC363].[PANNE_PGC]
//* Commentaires	:	
//*
//* Arguments		: String 	asFiltre			Val
//*
//* Retourne		: String asFiltre	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF   12/10/2011   [AUCH_SITCOL_NVFRONT] 
//*       JFF   22/11/2023 [RS6175_GC_SCRP_SIM2]
//*-----------------------------------------------------------------

Decimal dcIdSin, dcIdProd, dcIdEts, dcIdGti
String  sIdAdh, GCO2M
Int iPresencePanne, iPresencePGC
Long lDeb, lFin, lRow, lRowDS 
n_cst_string 		lnvPFCString
DateTime dtDteRempl, dtMajLe
Date dDteRempl
Boolean bCHoixAutoGti15_18 

F_Rechdetpro(lDeb, lFin, dw_det_pro, dw_1.getItemNumber( 1, "ID_PROD"),"-DP",140)
If lDeb <= 0 Then Return asFiltre

GCO2M = lnvPFCString.of_getkeyvalue (dw_Det_Pro.GetItemString ( lDeb, "VAL_CAR" ), "GC_O2M_EN_MOIS", ";")
bCHoixAutoGti15_18 = lnvPFCString.of_getkeyvalue (dw_Det_Pro.GetItemString ( lDeb, "VAL_CAR" ), "CHOIX_AUTO_GTI_15_18", ";") = "OUI"

// [AUCH_SITCOL_NVFRONT] 
If Not bCHoixAutoGti15_18 Then Return asFiltre

If IsNull ( GCO2M ) Then GCO2M = ""
If Trim ( GCO2M ) <> "" Then
	If Not IsNumber ( GCO2M ) Then Return asFiltre
End If

dcIdSin		= dw_1.GetItemNumber ( 1, "ID_SIN" )
dcIdProd		= dw_1.GetItemNumber ( 1, "ID_PROD" )
dcIdEts		= dw_1.GetItemNumber ( 1, "ID_ETS" )
sIdAdh		= dw_1.GetItemString ( 1, "ID_ADH" )
iPresencePanne = 0
iPresencePGC = 0
SQLCA.PS_S01_RECH_PGC_PANNE ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, iPresencePanne, iPresencePGC, dtDteRempl )

// [AUCH_SITCOL_NVFRONT] 
If GCO2M <> "" Then
	dDteRempl = Date ( dtDteRempl )
End If 
// [AUCH_SITCOL_NVFRONT] 

If iPresencePanne > 0 Then
	If len ( asFiltre ) > 0 Then 
		asFiltre += " AND "
	Else
		asFiltre = ""
	End IF
	
	asFiltre += "ID_GTI <> 18"

	// [AUCH_SITCOL_NVFRONT] 
	If GCO2M <> "" Then
		
		// [RS6175_GC_SCRP_SIM2]
		lRow = dw_w_div_sin.Find("nom_zone = 'duree_gti_orig'", 1 , dw_w_div_sin.Rowcount()+1 )

		If lRow > 0 then 
			// [RS6175_GC_SCRP_SIM2]
			iuoGsSpSinistre.uf_gestong_divers_majzone( "DUREE_GTI_ORIG", lRow, 2, GCO2M )
		End If

		dw_1.SetItem ( 1, "DTE_ACH_PORT", dDteRempl )
		dw_1.SetItem ( 1, "DTE_OUVLIG_PORT", dDteRempl )

		// Marque PGC O2M
		lRow = dw_w_div_sin.Find("nom_zone = 'pgc_o2m'", 1 , dw_w_div_sin.Rowcount()+1 )
		If lRow > 0 Then
			iuoGsSpSinistre.uf_gestong_divers_majzone( "PGC_O2M", lRow, 2, "O" )
		Else 
			dtMajLe = DateTime ( Today (), Now () )
			lRowDS = dw_w_div_sin.InsertRow (0)
			dw_w_div_sin.SetItem ( lRowDS, "ID_SIN", dw_1.GetItemNumber ( 1, "ID_SIN" ) )
			dw_w_div_sin.SetItem ( lRowDS, "NOM_ZONE", "pgc_o2m" )
			dw_w_div_sin.SetItem ( lRowDS, "LIB_LABEL", "PGC O2M" )
			dw_w_div_sin.SetItem ( lRowDS, "ID_TYP_LISTE", "-1" )
			dw_w_div_sin.SetItem ( lRowDS, "ALT_LISTE_CODECAR", "N" )
			dw_w_div_sin.SetItem ( lRowDS, "ID_TYP_ZONE", "X" )
			dw_w_div_sin.SetItem ( lRowDS, "ALT_OBLIG", "N" )
			dw_w_div_sin.SetItem ( lRowDS, "ALT_PROT", "O" )
			dw_w_div_sin.SetItem ( lRowDS, "CPT_TRI", 9000 )
			dw_w_div_sin.SetItem ( lRowDS, "VAL_CAR", "O" )
			dw_w_div_sin.SetItem ( lRowDS, "CREE_LE", dtMajLe  )
			dw_w_div_sin.SetItem ( lRowDS, "MAJ_LE", dtMajLe  )
			dw_w_div_sin.SetItem ( lRowDS, "MAJ_PAR", stGlb.sCodOper )
			dw_w_div_sin.SetItem ( lRowDS, "ALT_SUPP", "N" )
		End If
	
		stMessage.sTitre		= "Modification dynamique GC"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sVar[1]    = GCO2M
		stMessage.sVar[2]    = String ( dDteRempl, "dd/mm/yyyy" ) 
		stMessage.sCode		= "WSIN701"
		F_Message ( stMessage )
	End IF
	
Else
	If len ( asFiltre ) > 0 Then 
		asFiltre += " AND "
	Else
		asFiltre = ""
	End IF
	
	asFiltre += "ID_GTI <> 15"
End If 

Return asFiltre
end function

public subroutine wf_afficher_doc (string asnomfichier, string astitreerr);//*-----------------------------------------------------------------
//*
//* Objet			: w_tm_sp_sinistre
//* Evenement 		: wf_afficher_doc
//* Auteur			: F. Pinon
//* Date				: 01/05/2012
//* Libellé			: [PM103]
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

String		sFic,sRun, sFicTmp
Boolean  bOk
String 	sRepWord
n_cst_string	nvString 
Blob blBlob

sFic=ProfileString(stGlb.sFichierIni,"DOCUMENTATION","AIDE","")

sFic=Left(sFic, Len(sFic) - Pos(Reverse(sFic),"\") +1 )  // On supprime le A*.DOC

sFic =sFic + asnomfichier

/*-----------------------------------------------------------------*/
/* L'aide existe-t-elle 												*/
/*-----------------------------------------------------------------*/

bOk = f_FileExists ( sFic )

If Not bOk Then
	stMessage.sTitre  	= asTitreErr
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "AIDE04"
	stMessage.sVar[1]		= sFic
	F_Message ( stMessage )
	Return
End If


sRepWord = f_getwordexe()
/*------------------------------------------------------------------*/
/* Le chemin où trouver word est vide.                              */
/*------------------------------------------------------------------*/
If sRepWord = "" Then 
	stMessage.sTitre  	= asTitreErr
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "AIDE02"
	F_Message ( stMessage )
	Return
End If

sFicTmp = Upper ( stGlb.sreptempo + asnomfichier )

If f_FileExists ( sFicTmp ) Then 
	
	bOk = FileDelete ( sFicTmp )
	If Not bOk Then
		stMessage.sTitre  	= asTitreErr
		stMessage.Icon			= Information!
		stMessage.bErreurG	= TRUE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "AIDE03"
		stMessage.sVar[1]		= "l'aide"
		stMessage.sVar[2]		= sFicTmp
		F_Message ( stMessage )
		Return
	End If
End If

/*------------------------------------------------------------------*/
/* Lecture du fichier source.                                       */
/*------------------------------------------------------------------*/
bOk = F_LireFichierBlob ( blBlob, sFic )
If Not bOk Then
	stMessage.sTitre  	=  asTitreErr
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "AIDE04"
	stMessage.sVar[1]		= sFic
	F_Message ( stMessage )
	Return
End If

/*------------------------------------------------------------------*/
/* Ecriture en local vers fichier destination.							  */
/*------------------------------------------------------------------*/
bOk = F_EcrireFichierBlob ( blBlob, sFicTmp)
If Not bOk Then
	stMessage.sTitre  	= asTitreErr
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "AIDE05"
	stMessage.sVar[1]		= sFicTmp
	F_Message ( stMessage )
	Return
End If

sRun = sRepWord + " " + sFicTmp

RUN ( sRun )
end subroutine

public function boolean wf_blocage_ouv_gti ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_tm_sp_sinistre::wf_blocage_ouv_gti
//* Auteur			: F. Pinon
//* Date				: 22/04/2014
//* Libellé			: 
//* Commentaires	:	[PC13362]
//*
//* Arguments		: 	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF     06/06/2014 [PC786-1_AUCHAN_GEM]  
// 		FPI		21/10/2016	[PI056] dte_ach_port en datetime
//*-----------------------------------------------------------------
Boolean bRet=TRUE
Long lDeb, lFin, lCptDetPro 
String sVal
n_cst_string nvString

f_rechdetpro(lDeb, lFin, dw_det_pro, dw_1.GetItemNumber(1,"ID_PROD"), "-DP", 10)

If lDeb > 0 Then
	sVal=nvString.of_getkeyvalue( dw_det_pro.GetItemString(lDeb, "VAL_CAR"), "BLOCAGE_OUVERTURE_GTI", ";")
	
	If sVal="OUI" and isNull(dw_1.GetItemDateTime ( 1, "DTE_ACH_PORT" )) Then // [PI056]
	
		stMessage.sTitre		= "Contrôle de saisie du sinistre"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= False
		stMessage.sCode = "GENE001"
		stMessage.sVar[1]="la date d'achat de l'appareil~n"
		f_Message ( stMessage )

		Uo_Ong.Uf_ChangerOnglet ( "01" )
		dw_1.setColumn( "DTE_ACH_PORT")
		dw_1.setFocus()
	
		bRet=FALSE
	End if
End if

// [PC786-1_AUCHAN_GEM]  
f_rechdetpro(lDeb, lFin, dw_det_pro, dw_1.GetItemNumber(1,"ID_PROD"), "-DP", 140)
If lDeb > 0 Then
	sVal=nvString.of_getkeyvalue( dw_det_pro.GetItemString(lDeb, "VAL_CAR"), "TYPE", ";")
	If sVal = "GEM" Then
		
	End If
End If



// [PM234-4_V1]
F_RechDetPro ( lDeb, lFin, dw_Det_Pro, dw_1.GetItemNumber ( 1, "ID_PROD" ), "-DP", 94 )

For lCptDetPro = lDeb To lFin
	sVal = nvString.of_getkeyvalue ( dw_Det_Pro.GetItemString ( lCptDetPro, "VAL_CAR" ), "COD_DW", ";")
	
	Choose Case sVal 
		Case "ORANGE_V2BIS"
			If Not iuoGsSpSinistre.Uf_Scripting_V2BIS () Then 
				bRet=FALSE
			End If

	End Choose
Next
// [PM234-4_V1]

Return bRet


end function

public function string wf_gti_denree_alim_auchan (string asfiltre);//*-----------------------------------------------------------------
//*
//* Fonction		: w_tm_sp_sinistre::wf_gti_denree_alim_auchan
//* Auteur			: FABRY JF
//* Date				: 06/06/2014
//* Libellé			: [PC786-1_AUCHAN_GEM] 
//* Commentaires	:	
//*
//* Arguments		: String 	asFiltre			Val
//*
//* Retourne		: String asFiltre	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 
//*-----------------------------------------------------------------

Decimal dcIdSin, dcIdProd, dcIdEts, dcIdGti
String  sIdAdh, GCO2M
Int iPresencePanne, iPresencePGC
Long lDeb, lFin, lRow, lRowDS 
n_cst_string 		lnvPFCString
DateTime dtDteRempl, dtMajLe
Date dDteRempl
Boolean bCHoixAutoGti15_18 
String sVal

// [PC786-1_AUCHAN_GEM]  
f_rechdetpro(lDeb, lFin, dw_det_pro, dw_1.GetItemNumber(1,"ID_PROD"), "-DP", 140)

If lDeb > 0 Then
	sVal=lnvPFCString.of_getkeyvalue( dw_det_pro.GetItemString(lDeb, "VAL_CAR"), "TYPE", ";")
	
	If sVal = "GEM" Then
		Choose Case iuoGsSpSinistre.uf_GestOng_Divers_Trouver ( "TYPE_APP" )
			Case "CNG", "REF", "REG", "RFA", "CAV"
				// OK
			Case Else
					If len ( asFiltre ) > 0 Then 
						asFiltre += " AND "
					Else
						asFiltre = ""
					End IF
					
					asFiltre += "ID_GTI <> 52"
				
		End Choose
		
	End If

End If

Return asFiltre
end function

public function string wf_gti_somme_forfaitaire (string asfiltre);//*-----------------------------------------------------------------
//*
//* Fonction		: w_tm_sp_sinistre::wf_gti_somme_forfaitaire
//* Auteur			: FABRY JF
//* Date				: 07/11/2018
//* Libellé			: [VDOC26935][PC171999] 
//* Commentaires	:	
//*
//* Arguments		: String 	asFiltre			Val
//*
//* Retourne		: String asFiltre	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 
//*-----------------------------------------------------------------

Decimal dcIdSin, dcIdProd, dcIdEts, dcIdGti
String  sIdAdh, GCO2M
Int iPresencePanne, iPresencePGC
Long lDeb, lFin, lRow, lRowDS 
n_cst_string 		lnvPFCString
DateTime dtDteRempl, dtMajLe
Date dDteRempl
Boolean bCHoixAutoGti15_18 
String sVal

// [PC786-1_AUCHAN_GEM]  
f_rechdetpro(lDeb, lFin, dw_det_pro, dw_1.GetItemNumber(1,"ID_PROD"), "-DP", 330)

If lDeb > 0 Then
	If len ( asFiltre ) > 0 Then 
		asFiltre += " AND "
	Else
		asFiltre = ""
	End IF
	
	asFiltre += "ID_GTI <> 37"
				
End If

Return asFiltre
end function

public subroutine wf_sav_bt_test_hub ();/*
Long lIndentityHubPresta, lRowCountHubPresta
Long lErrorHubPresta 
String sSql
Boolean bRet

u_Transaction_Hub_Prestataire itrHubPrestataire  // [HP252_276_HUB_PRESTA]

If Not IsValid ( itrHubPrestataire ) Then
	itrHubPrestataire = Create u_Transaction_Hub_Prestataire
End IF 

bRet = f_ConnectSqlServer_Hub_Prestataire ( stGLB.sFichierIni   , &
									 "HUB PRESTATAIRE BASE" , &
									 itrHubPrestataire    , &
									 stGLB.sMessageErreur, &
									 stGlb.slibcourtappli, &
									 stGlb.sCodOper          ) 

sSql = "Exec edi.PS_HP276_I_HP_VALIDATION_PRESTA_DANS_LE_HUB_PRESTATAIRE 2,7990868,1,'AUYPSQZMJB','ANV','#TD1#TD2#TD3#','ANV0001','Centralisation','4165R','U EXPRESS','7990868 TABOURET VICTOR','Avenue du President Kennedy','Place de L Europe',null,'17000','LA ROCHELLE',3520,'Ass. dépose colis en relais pickup',11,'DOMMAGE ACCIDENTEL',0,87900,'MOBIL ZEN 2 TEL C1',879,1001,'8628214',1,'PRS',1,'M.','Monsieur',null,'TABOURET','VICTOR','TABOURET','VICTOR','52 RUE DU MINAGE',null,null,'17000','LA ROCHELLE','0617239269',null,null,'victor.tabouret@gmail.com','355395071124049',null,'ECRAN TOMBE AU SOL ET CASSE','ECT','06/20/2024 13:13:52','JFF','06/20/2024 13:13:58','A_REPARER','A_REPARER',6,'AIG EUROPE SA','2 500 272','TEL','SMARTPHONE/TELEPHONE MOBILE','APPLE','IPHONE 11 128GO BLANC','IFR','0617239269',599.00,150.00,'12/28/2015 00:00:00','REC',null,null,'NEUF_REC=[#REC#];HP_ID_HUB_PRESTA=AUYPSQZMJB;HP_ID_FOUR=ANV;HP_TYP_DOM=#TD1#TD2#TD3#;HP_ID_POINT_SERV=ANV0001;HP_ID_MODE_PROCESS=Centralisation;CODE_PICK_UP=4165R;NOM_PICK_UP=U EXPRESS;REFASS_PICK_UP=7990868 TABOURET VICTOR;ADR1_PICK_UP=Avenue du President Kennedy;ADR2_PICK_UP=Place de L Europe;ADRCP_PICK_UP=17000;ADRVILLE_PICK_UP=LA ROCHELLE;HP_INFO_SPB_FRN=3520'"
lErrorHubPresta = F_Execute_Hub_Prestataire ( sSql, itrHubPrestataire, lIndentityHubPresta, lRowCountHubPresta )
bRet = lErrorHubPresta = 0 And itrHubPrestataire.SqlCode = 0 And itrHubPrestataire.SqlDBCode = 0

F_Commit_Hub_Prestataire ( itrHubPrestataire, bRet)

/*
sSql = "Exec sysadm.PS_HP276_U_S2_MAJ_GEN_PRESTA 7990868., 1, " + String ( lIndentityHubPresta )
F_Execute ( sSql, SQLCA )
bRet = SQLCA.SqlCode = 0 And SQLCA.SqlDBCode = 0
F_Commit ( SQLCA , bRet )
	*/
	
Disconnect using itrHubPrestataire ;

If IsValid ( itrHubPrestataire ) Then Destroy itrHubPrestataire
*/
end subroutine

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::Ue_Modifier
//* Evenement 		: Ue_Modifier
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 16:37:38
//* Libellé			: 
//* Commentaires	: Ouverture des Fenêtres de détail.
//*				     (On est en modification d'un détail)
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  CAG	12/02/2003  Suite DCMP 030027 : Ajout de la dw DET_PRO
//* #2  JFF  23/03/2004 Blob data pour SVE DCMP 040020
//* #3  JFF  04/10/2004 DCMP 040295
//* #4  JFF  04/06/2007 [DCMP070163-070164-070248-070318] Gestion Prise en charge
//* #5  JFF  18/09/2007 [ALAPAGE]
//* #6  JFF  20/06/2008 [DCMP080479]
//*  	  JFF	13/04/2010  [WEBSIM2].[FRANCE]
//*       FPI	27/07/2010 [PM72]
//* 		FPI	18/10/2010	[PM72.1]
//*     JFF  26/06/2012 [CONFO][NV_PROCESS]
//      JFF  07/05/2013 [RS3552_REVCOUVGTI]
//*-----------------------------------------------------------------

s_Pass stPass_Dga
Date	 dDteCree, dDteJour
Int	 iIdInter
Boolean bRet
Long 	lDeb, lFin, lCptDetPro, lIdProd, lIdRev
String sVal
n_cst_string lnvString

stPass_Dga = istPass
bRet = True

Choose Case isDetailActif
Case "dw_lst_inter"

	isDetailConsult = "dw_lst_inter"
	iIdInter = dw_lst_inter.GetItemNumber ( dw_lst_inter.GetRow (), "ID_I" ) 

	SetPointer ( HourGlass! )
/*------------------------------------------------------------------*/
/* On arme la structure pour expliquer un certain nombre de         */
/* choses. On est en modification, on ne veut pas du bouton CTRL.   */
/* On passe la DW de détail ainsi que la DW Master (Sinistre).      */
/* Cette dernière est trés importante. Elle va éviter d'utiliser    */
/* des instances de fenêtres.                                       */
/*------------------------------------------------------------------*/
	stPass_Dga.bInsert		= False
	stPass_Dga.bSupprime		= True
	stPass_Dga.bControl		= False
	
	stPass_Dga.sTab [ 1 ]	= This.Title
	stPass_Dga.sTab [ 2 ]	= isTypeTrt
	stPass_Dga.sTab [ 3 ]	= Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()

	// stPass_Dga.sTab [ 4 ]	Est déjà utilisé !!!
	// stPass_Dga.sTab [ 5 ]	Est déjà utilisé !!!

	If ibSaisieValidation Then
		stPass_Dga.sTab [ 6 ]	= iuoGsSpSinistre.uf_GetDataInter ( iIdInter ) // #2
	Else
		stPass_Dga.sTab [ 6 ]	= "X"
	End If

	stPass_Dga.bTab [ 1 ]	= ibAltCommune // Gestion des Communes O/N
	stPass_Dga.bTab [ 2 ]	= ibSaisieValidation // Gestion SVE

	stPass_Dga.dwTab [ 1 ]	= Dw_Lst_Inter
	stPass_Dga.dwTab [ 2 ]	= Dw_w_commande // [PM72]
	stPass_Dga.dwMaster		= dw_1

	stPass_Dga.udwTab [ 1 ]	= Dw_w_Div_Sin   // #5

	stPass_Dga.dwNorm [ 1 ]	= dw_Produit			// DataWindow PRODUIT
	stPass_Dga.dwNorm [ 2 ]	= dw_ParaProd			// DataWindow PARA_PROD
	stPass_Dga.dwNorm [ 3 ]	= dw_wParaInfo			// DataWindow W_PARA_INFO
	stPass_Dga.dwNorm [ 4 ]	= dw_wPiece				// DataWindow W_PIECE
	stPass_Dga.dwNorm [ 5 ]	= dw_wRefus				// DataWindow W_REFUS
	stPass_Dga.dwNorm [ 6 ]	= dw_wFrais				// DataWindow W_FRAIS
	stPass_Dga.dwNorm [ 7 ]	= dw_wDetail			// DataWindow W_DETAIL
	stPass_Dga.dwNorm [ 8 ]	= dw_Det_Pro			// DataWindow DET_PRO    // #1
	stPass_Dga.dwNorm [ 9 ]	= dw_Commune			// DataWindow des Communes
	stPass_Dga.dwnorm [ 10 ]	= dw_cmde_typ_frn 		// [PM72.1]
	stPass_Dga.dwnorm [ 11 ]	= dw_w_div_sin		// [VDoc12394]
																		
	If	stPass_Dga.sTab [ 3 ]	<> stGLB.sMonnaieFormatDesire	Then	
		Uo_Consult_Euro.Uf_Changer_Monnaie ( stGLB.sMonnaieFormatDesire )
		wf_Enabled_Fenetre ( stGLB.sMonnaieFormatDesire )
	End If

	F_OuvreTraitement ( iW_Tm_Sp_Interlocuteur, stPass_Dga )

Case "dw_lst_gti"

	isDetailConsult = "dw_lst_gti"
	
	SetPointer ( HourGlass! )	

	stPass_Dga.bInsert		= False
	stPass_Dga.bControl		= True

	stPass_Dga.sTab [ 1 ]	= This.Title
	stPass_Dga.sTab [ 2 ]	= isTypeTrt
	stPass_Dga.sTab [ 3 ]	= Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()
	stPass_Dga.sTab [ 4 ]	= dw_1.GetItemString ( 1, "NUM_IMEI_PORT" ) // n° IMEI provenant de l'adhésion (a pu être modifié depuis l'ouverture du sinistre)
	stPass_Dga.sTab [ 5 ]	= Upper ( trim ( dw_1.GetItemString ( 1, "MARQ_PORT" )))
	stPass_Dga.sTab [ 6 ]	= dw_1.GetItemString ( 1, "MODL_PORT" )
	stPass_Dga.sTab [ 7 ]	= dw_1.GetItemString ( 1, "NUM_IMEI_PORT", Primary!, TRUE ) // DCMP 030407 n° IMEI provenant de l'adhésion (N'A PAS ETE modifié depuis l'ouverture du sinistre)

	stPass_Dga.sTab [ 8 ]	= iuoGsSpSinistre.uf_Determiner_Referentiel ( iuoGsSpSinistre.uf_GestOng_Divers_Trouver ( "TYPE_APP" )) // Référentiel utilisé en fct du type d'appareil (Téléphonie)

	stPass_Dga.bTab [ 1 ]	= ibAltCmdMobile
	stPass_Dga.bTab [ 2 ]	= ibAltCommune // Gestion des Communes O/N

	stPass_Dga.dwTab [ 1 ]	= Dw_Lst_Gti
	stPass_Dga.dwTab [ 2 ]	= Dw_Lst_Inter
	stPass_Dga.dwTab [ 3 ]	= Dw_w_commande

	stPass_Dga.udwTab [ 1 ]	= Dw_w_Div_Sin   // #3
	stPass_Dga.udwTab [ 2 ]	= dw_w_div_Det       // DataWindow Stockage Données onglet divers details

	stPass_Dga.dwMaster		= dw_1

	stPass_Dga.dwNorm [  1 ]	= dw_Produit			// DataWindow PRODUIT
	stPass_Dga.dwNorm [  2 ]	= dw_CodeGarantie		// DataWindow CODE_GARANTIE
	stPass_Dga.dwNorm [  3 ]	= dw_CodeCondition	// DataWindow CODE_CONDITION
	stPass_Dga.dwNorm [  4 ]	= dw_Piece				// DataWindow PIECE
	stPass_Dga.dwNorm [  5 ]	= dw_Motif				// DataWindow MOTIF
	stPass_Dga.dwNorm [  6 ]	= dw_Franchise			// DataWindow FRANCHISE
	stPass_Dga.dwNorm [  7 ]	= dw_Plafond			// DataWindow PLAFOND
	stPass_Dga.dwNorm [  8 ]	= dw_Delai				// DataWindow DELAI
	stPass_Dga.dwNorm [  9 ]	= dw_Garantie			// DataWindow GARANTIE
	stPass_Dga.dwNorm [ 10 ]	= dw_Condition			// DataWindow CONDITION
	stPass_Dga.dwNorm [ 11 ]	= dw_wDetail			// DataWindow W_DETAIL
	stPass_Dga.dwNorm [ 12 ]	= dw_wPiece				// DataWindow W_PIECE
	stPass_Dga.dwNorm [ 13 ]	= dw_wRefus				// DataWindow W_REFUS
	stPass_Dga.dwNorm [ 14 ]	= dw_wParaPlafond		// DataWindow W_PARA_PLAFOND
	stPass_Dga.dwNorm [ 15 ]	= dw_cmde_typ_frn		// DataWindow sur COMMANDE_TYPE, pour le choix des fournisseurs
	stPass_Dga.dwNorm [ 16 ]	= dw_cmde_typ_art		// DataWindow sur COMMANDE_TYPE, pour le choix des articles
/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
	stPass_Dga.dwNorm [ 17 ]	= dw_Horaire_Rdv		// DataWindow pour les horaires de rendez-vous
	stPass_Dga.dwNorm [ 18 ]	= dw_Zone_Fournisseur // DataWindow sur la table ZONE_FOURNISSEUR

/*------------------------------------------------------------------*/
/* Modification SFR # Le 27/09/02                                   */
/*------------------------------------------------------------------*/
	stPass_Dga.dwNorm [ 19 ]	= dw_Lst_Gamme			// DataWindow GAMME
// CAG le 03/10/02
	stPass_Dga.dwNorm [ 20 ]	= dw_Det_Article		// DataWindow DET_ARTICLE
	stPass_Dga.dwNorm [ 21 ]	= dw_Det_Hlr			// DataWindow DET_HLR
	stPass_Dga.dwNorm [ 22 ]	= dw_Det_Pro			// DataWindow DET_PRO #1
	stPass_Dga.dwNorm [ 23 ]	= dw_Commune			// DataWindow des Communes
	stPass_Dga.dwNorm [ 24 ]	= dw_Tac_Imei			// DataWindow des Tac_Imei #3
	stPass_Dga.dwNorm [ 25 ]	= dw_Stk_IFR			// DataWindow Stockage Données IFR #3
	stPass_Dga.dwNorm [ 26 ]	= dw_Code_Equivalence	// DataWindow Stockage Libellés IFR Traduit #3
	stPass_Dga.dwNorm [ 27 ]	= dw_autorisation    // Table autorisation
	stPass_Dga.dwNorm [ 28 ]	= dw_Stk_Codic_Darty	// DataWindow Stockage Données CODIC DARTY #3
	stPass_Dga.dwNorm [ 29 ]	= dw_code_mb         // DataWindow Stockage Données MARQUE diverses (-MB)
	stPass_Dga.dwNorm [ 30 ]	= dw_div_pDet        // DataWindow Stockage Données param onglet divers details
	stPass_Dga.dwNorm [ 31 ]	= dddw_codecar_wdivsin_charg_tempo // Chargement tempo des codes pour W_Div_Det
	stPass_Dga.dwNorm [ 32 ]	= dddw_code_wdivsin_charg_tempo // Chargement tempo des codes pour W_Div_Det
	stPass_Dga.dwNorm [ 33 ]	= dw_wdetail   // [CONFO][NV_PROCESS]

	If	stPass_Dga.sTab [ 3 ]	<> stGLB.sMonnaieFormatDesire	Then	
		Uo_Consult_Euro.Uf_Changer_Monnaie ( stGLB.sMonnaieFormatDesire )
		wf_Enabled_Fenetre ( stGLB.sMonnaieFormatDesire )
	End If

	// [PM234-4_V1]
	F_RechDetPro ( lDeb, lFin, dw_Det_Pro, dw_1.GetItemNumber ( 1, "ID_PROD" ), "-DP", 94 )

	For lCptDetPro = lDeb To lFin
		sVal = lnvString.of_getkeyvalue ( dw_Det_Pro.GetItemString ( lCptDetPro, "VAL_CAR" ), "COD_DW", ";")
		
		Choose Case sVal 
			Case "ORANGE_V2BIS"
				bRet = iuoGsSpSinistre.Uf_Scripting_V2BIS () 

		End Choose
	Next
	// [PM234-4_V1]	
	
	If bRet Then
		
		// [RS3552_REVCOUVGTI]
		lIdProd = dw_1.GetItemNumber ( 1, "ID_PROD" ) 
		lIdRev  = dw_1.GetItemNumber ( 1, "ID_REV" ) 

		If lIdRev < 0 Then
			stMessage.sTitre		= "Dossier non couvert"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= False
			stMessage.bouton     = Ok!
			stMessage.sCode = "WSIN885 "
			f_Message ( stMessage )	
		Else 
			If SQLCA.PS_S_GTI_COUVERTE_SUR_REV ( lIdProd, lIdRev, Dw_Lst_Gti.GetItemNumber ( Dw_Lst_Gti.GetSelectedRow (0), "ID_GTI" ))  <= 0 Then
				stMessage.sTitre		= "Garantie non couverte"
				stMessage.Icon			= Exclamation!
				stMessage.bErreurG	= False
				stMessage.bouton     = Ok!			
				stMessage.sCode = "WSIN886"
				stMessage.sVar[1] = String ( lIdRev ) 
				f_Message ( stMessage )
			End If 
		End IF 
		
		F_OuvreTraitement ( iW_Tm_Sp_W_Gar_Sin, stPass_Dga )
	End If

Case "dw_lst_contact"

	isDetailConsult = "dw_lst_contact"

	SetPointer ( HourGlass! )	

	stPass_Dga.bInsert		= False
	stPass_Dga.bControl		= True

	stPass_Dga.sTab [ 1 ]	= This.Title
	stPass_Dga.sTab [ 2 ]	= isTypeTrt

	stPass_Dga.dwTab [ 1 ]	= Dw_Lst_Contact
	stPass_Dga.dwTab [ 2 ]	= Dw_Lst_Inter

	stPass_Dga.udwTab [ 1 ]	= dw_DosSuiviPar

	stPass_Dga.dwNorm [ 1 ]	= Dw_Corb
	stPass_Dga.dwNorm [ 2 ]	= Dw_Produit

	stPass_Dga.dwMaster		= dw_1


	/*------------------------------------------------------------------*/
	/* Si Message du jour Ok pour Suppression, sinon possible uniquement*/
	/* par responsable                                                  */
	/*------------------------------------------------------------------*/

	dDteCree	=	Date ( String ( Dw_Lst_Contact.GetItemDateTime ( Dw_Lst_Contact.ilLigneClick, "CREE_LE" ), "DD/MM/YYYY" ) )
	dDteJour = 	Today ( )
				
	stPass_Dga.bSupprime   = dDteCree >= dDteJour Or Long ( stGlb.sTypOper) >= 5	
	F_OuvreTraitement ( iW_Tm_Sp_W_Contact, stPass_Dga )

Case "dw_w_commande"

	isDetailConsult = "dw_w_commande"

	SetPointer ( HourGlass! )	

	stPass_Dga.bInsert		= False
	stPass_Dga.bControl		= True

	stPass_Dga.sTab [ 1 ]	= This.Title + "/ Commande n° " + String (dw_w_commande.GetItemNumber ( dw_w_commande.GetRow (), "ID_SEQ" ))
	stPass_Dga.sTab [ 2 ]	= isTypeTrt
	stPass_Dga.sTab [ 3 ]	= Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()
	stPass_Dga.sTab [ 4 ]	= dw_1.GetItemString ( 1, "NUM_IMEI_PORT", Primary!, TRUE ) // DCMP 030407 n° IMEI provenant de l'adhésion (N'A PAS ETE modifié depuis l'ouverture du sinistre)

	stPass_Dga.bTab [ 1 ]	= ibAltCommune // Gestion des Communes O/N

	stPass_Dga.dwTab [ 1 ]	= Dw_w_Commande
	stPass_Dga.dwTab [ 2 ]	= dw_lst_gti
	stPass_Dga.dwTab [ 3 ]	= dw_w_div_det  // #4
/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On ajoute la DW DW_WDETAIL afin de controler que le détail       */
/* n'est pas A REGLER si l'on cherche à supprimer la commande liée  */
/* à ce détail.                                                     */
/*------------------------------------------------------------------*/
	stPass_Dga.dwNorm [ 1 ]	= dw_wDetail
	stPass_Dga.dwNorm [ 2 ]	= dw_Horaire_Rdv
	stPass_Dga.dwNorm [ 3 ]	= dw_Zone_fournisseur
	stPass_Dga.dwNorm [ 4 ]	= dw_Produit
	/*------------------------------------------------------------------*/
	/* #1                                                               */
	/*------------------------------------------------------------------*/
	stPass_Dga.dwNorm [ 5 ]	= dw_Det_Pro			// DataWindow DET_PRO
	stPass_Dga.dwNorm [ 6 ]	= dw_Commune			// DataWindow des Communes
	stPass_Dga.dwNorm [ 7 ]	= dw_w_div_det			// DataWindow des Tac_Imei
	stPass_Dga.dwNorm [ 8 ]	= dw_autorisation		//* #6  [DCMP080479]
	stPass_Dga.dwNorm [ 9 ]	= dw_w_div_sin       // [WEBSIM2].[FRANCE]

	stPass_Dga.dwMaster		= dw_1

	F_OuvreTraitement ( iW_Sp_Gs_W_Commande2, stPass_Dga )



End Choose

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  DBI le 30/08/1999 DCMP 990391 Gestion des motifs de routage			  
//* #3  CAG    05/03/2003 DCMP 030135 : Ajout d'une table des boutiques
//* #4  JFF		20/08/2003 DCMP 030362 : Chargement des communes pour Contrôle(CP/VILLE).
//* #5  JFF    --/--/2003 Gestion des TAC															  
//* #6  JFF    17/11/2003 Gestion du mail pour DARTY
//* #7  JFF    11/03/2004 PROJET_SVE
//* #8  JFF    15/06/2004 Gestion onglet Divers
//* #9  CAG		11/10/2004 DCMP 040366 : Visualisation de la catégorie des courriers en validation uniquement
//* #10 PHG		17/10/2006 [DCMP060445] Controle de cohérence CP-commune unifié entre Sherpa/Simpa
//* #11 JCA		16/05/2007 DCMP 070051 - Fusion des tables [courrier] et composition] en [cour_prod]
//      JFF    12/06/2014 [PI052]
//      JFF    06/04/2020 [PM506-1]
//      JFF    09/09/2022 [PM80_FA12_FRANEX]
//*-----------------------------------------------------------------

s_Pass		stPass_Dga, stPassSVE

//Migration PB8-WYNIWYG-03/2006 CP
//DataWindow	dwNorm[41]
//DataWindow	dwPassageEuro[4]
DataWindow	dwNorm[]
DataWindow	dwPassageEuro[]
//Fin Migration PB8-WYNIWYG-03/2006 CP

String		sRep, sFicRout, sPathCommune
n_cst_string		lnvString // [MIGPB11] [EMD] : ImportFile d'une chaine vide

Wf_PositionnerObjets ()

/*------------------------------------------------------------------*/
/* #7 : Sommes nous en SVE ?                                        */
/*------------------------------------------------------------------*/
ibSaisieValidation = stGLB.bSaiValEdt

// #7
stPassSVE.bTab[1] = ibSaisieValidation
stPassSVE.dwNorm [1] = Dddw_TypeDoc
stPassSVE.dwNorm [2] = Dw_Stk_W_Cour_Blob_Sve
stPassSVE.dwNorm [3] = Dw_Compo

/*------------------------------------------------------------------*/
/* #7																					  */
/* On positionne tous les objets proprement.                        */
/* Gestion Saisie/Validation.                                       */
/*------------------------------------------------------------------*/
If	ibSaisieValidation	Then
	invSaisieValSin = CREATE N_CSt_Saisie_Validation_Sinistre
	// #11 // [PC363][LOGO_AUCHAN]
	
	// [PI052] idw_wPiece => idw_wParaInfo
	invSaisieValSin.Uf_Initialiser ( "SIMPA2", &
												lb_Fichier, &
												dw_GenCourrier, &
												dw_ChoixCourGen, &
												st_Titre, Dddw_TypeDoc, &
												Dw_wCourrier, &
												Dw_Stk_W_Cour_Blob_Sve, &
												dw_Compo, &
												dw_1, &
												dw_det_pro, &
												dw_wPiece, &
												dw_wRefus, &
												dw_wParaPlafond, &
												dw_wParaInfo &
												)
	// #11 - FIN
End If

/*------------------------------------------------------------------*/
/* Nous sommes en saisie (S) ou en Consultation/Validation (C)(V)   */
/*------------------------------------------------------------------*/
isTypeTrt = istPass.sTab[ 2 ]

/*------------------------------------------------------------------*/
/* #4 : Le plus en amont possible, ici donc, je charge une fois     */
/* pour toute le fichier des 39155 communes.                        */
/*------------------------------------------------------------------*/
ibAltCommune = FALSE
If isTypeTrt = "S" Then 
// [DCMP060445]
//	sPathCommune = ProfileString ( stGlb.sFichierIni, "APPLICATION", "CODES_POSTAUX", "" )
//	If sPathCommune <> "" Then	
//		dw_Commune.ImportFile ( sPathCommune )
//		ibAltCommune = dw_Commune.RowCount () > 0
//	Else 
//		ibAltCommune = FALSE
//	End If
// remplacé par
	if isvalid(stglb.uocommune) then
		if stglb.uocommune.rowCount()>0 then
			ibAltCommune = ( stglb.uocommune.ShareData(dw_commune) = 1 )
		End If
	End If
End If
stPass_Dga.bTab[1] = ibAltCommune

/*------------------------------------------------------------------*/
/* On commence à initialiser les NVUO.                              */
/*------------------------------------------------------------------*/
iuoGsSpSinistre = Create U_Gs_Sp_Sinistre
iuoGsSpContTrace = Create U_Gs_Sp_Sinistre_Contact_Trace

/*------------------------------------------------------------------*/
/* #7 initilisation des objets liés à la SVE.                       */
/*------------------------------------------------------------------*/
iuoGsSpSinistre.uf_Initialiser_SVE ( stPassSVE, invSaisieValSin, lb_Fichier )

/*------------------------------------------------------------------*/
/* Ces fonctions sont issues du NVUO ancêtre.                       */
/*------------------------------------------------------------------*/
iuoGsSpSinistre.Uf_Initialisation ( dw_1, itrTrans, Uo_Ong, isTypeTrt )
iuoGsSpSinistre.Uf_Initialiser_Dw ( dw_Produit, dw_Det_Pro, True )
/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002 + CAG 12/09/2002              */
/*------------------------------------------------------------------*/
iuoGsSpSinistre.Uf_Initialiser_Dw_Sfr ( dw_Horaire_Rdv, Dw_Zone_Fournisseur, dw_Det_Article, dw_Det_Hlr, dw_Lst_Gamme, TRUE )
iuoGsSpContTrace.Uf_Initialiser ( dw_1, dw_Lst_Contact, dw_Produit, dw_DosSuiviPar, iTrTrans )

/*------------------------------------------------------------------*/
/* Cette fonction n'appartient qu'au NVUO descendant.               */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On arme les DW dans le bon ordre. (SVP)                          */
/*------------------------------------------------------------------*/
dwNorm[ 1] = dw_CodeGarantie
dwNorm[ 2] = dw_CodeCondition
dwNorm[ 3] = dw_Piece
dwNorm[ 4] = dw_Motif
dwNorm[ 5] = dw_Franchise
dwNorm[ 6] = dw_Plafond
dwNorm[ 7] = dw_Delai
dwNorm[ 8] = dw_Garantie
dwNorm[ 9] = dw_Condition
dwNorm[10] = dw_ParaProd
dwNorm[11] = dw_wParaInfo
dwNorm[12] = dw_wDetail
dwNorm[13] = dw_wPiece
dwNorm[14] = dw_wRefus
dwNorm[15] = dw_wFrais
dwNorm[16] = dw_wCourrier
dwNorm[17] = dw_Police
dwNorm[18] = dw_wParaPlafond
dwNorm[19] = dw_wRegGti
dwNorm[20] = dw_article			// Articles et stocks dispo sur SIMPA
dwNorm[21] = dw_Cmde_Typ_Frn  // DataWindow sur COMMANDE_TYPE, pour le choix des fournisseurs
dwNorm[22] = dw_cmde_typ_art	// DataWindow sur COMMANDE_TYPE, pour le choix des articles
dwNorm[23] = dw_det_pro			// DataWindow sur DET_PRO

/*------------------------------------------------------------------*/
/* #3                                                               */
/*------------------------------------------------------------------*/
dwNorm[24] = dw_boutique		// DataWindow sur BOUTIQUE

/*------------------------------------------------------------------*/
/* #4 : DCMP 030362                                                 */
/*------------------------------------------------------------------*/
dwNorm[25] = dw_Commune 		// DataWindow des communes

/*------------------------------------------------------------------*/
/* #5 : Gestion des TAC															  */
/*------------------------------------------------------------------*/
dwNorm[26] = dw_tac_imei 		// DataWindow des communes

/*------------------------------------------------------------------*/
/* #5 : DCMP 030408                                                 */
/*------------------------------------------------------------------*/
dwNorm[27] = dw_mail			
dwNorm[28] = dw_Autorisation

/*------------------------------------------------------------------*/
/* #8 																				  */
/*------------------------------------------------------------------*/
dwNorm[29] = dw_div_pro
dwNorm[30] = dddw_codecar_wdivsin_charg_tempo
dwNorm[31] = dddw_code_wdivsin_charg_tempo
dwNorm[32] = dw_code_equivalence
dwNorm[33] = dw_stk_ifr
dwNorm[34] = dddw_ifr_marque
dwNorm[35] = dddw_ifr_modele
dwNorm[36] = dw_Code_MB
dwNorm[37] = dddw_dty_marque
dwNorm[38] = dddw_dty_modele
dwNorm[39] = dw_Code_RF
dwNorm[40] = dw_stk_codic_darty
dwNorm[41] = dw_div_pdet
dwNorm[42] = dw_wreg_frais_annexe_frn // [PM80_FA12_FRANEX]

/*------------------------------------------------------------------*/
/* DGA. Le 21/08/2003.                                              */
/* Gestion des boites archives.                                     */
/*------------------------------------------------------------------*/
// [PM506-1]
iuoGsSpSinistre.Uf_Initialiser_Dw_Desc ( &
		dw_Lst_Inter,		&
		dw_Lst_Gti,			&
		dwNorm[],			&
		Uo_Libelle,			&
		dw_Lst_Contact,	&
		dw_Corb,				&
		dw_DosSuiviPar,	&
		dw_w_commande,		&
		dw_BoiteArchive,	&
		dw_w_Div_Sin	,	&
		dw_w_div_Det   ,  &
		pb_controler 	,	&
		st_pause_API_LAB, &
		st_attente_diverse &
		)

//st_pause_API_LAB

dw_Lst_Inter.SetRowFocusIndicator ( p_Focus, 40, 260 )
dw_W_Commande.SetRowFocusIndicator ( p_Focus, 20, 170 )

/*------------------------------------------------------------------*/
/* Initialisation de l'onglet.                                      */
/*------------------------------------------------------------------*/
Uo_Ong.Uf_Initialiser ( 5, 1 )
Uo_Ong.Uf_EnregistrerOnglet ( "01", "Sinistre", 		"", dw_1,			True )
Uo_Ong.Uf_EnregistrerOnglet ( "02", "Garanties", 		"", dw_Lst_Gti,	False )
Uo_Ong.Uf_EnregistrerOnglet ( "03", "Interlocuteurs",	"", dw_Lst_Inter,	False )
Uo_Ong.Uf_EnregistrerOnglet ( "04", "Divers",			"", dw_w_div_sin,	False )
Uo_Ong.Uf_EnregistrerOnglet ( "05", "Commandes",		"", dw_w_commande,	False )
Uo_Ong.Uf_ActiverOnglet ( "05", False )

/*------------------------------------------------------------------*/
/* On réalise un certain nombre de choses en fonction du type de    */
/* traitement. (Initialisation d'une varaible d'instance pour le    */
/* WorkFlow, Gestion des TabOrdrers, Etc..)                         */
/*------------------------------------------------------------------*/
/* #9 CAG : 11/10/2004                                              */
/*------------------------------------------------------------------*/
Cb_Categ.Enabled = False
Cb_Categ.Visible = False

Choose Case isTypeTrt
Case "S"
	isCodEtat = "1"
	
Case "V"
	isCodEtat = "5"
	Wf_Tb_Consultation ()

	Pb_Validation_Dossier.Enabled = True
	Pb_Validation_Dossier.Visible = True

	/*------------------------------------------------------------------*/
	/* #9 CAG : 11/10/2004                                              */
	/*------------------------------------------------------------------*/
	Cb_Categ.Enabled = True
	Cb_Categ.Visible = True

Case "C"
	Wf_Tb_Consultation ()

	Pb_Routage.Enabled = False
	Pb_Routage.Visible = False

End Choose

/*------------------------------------------------------------------*/
/* Le nom du fichier de trace pour l'essai d'écriture.              */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Cette variable sera utilisée pour le routage dans l'événement    */
/* Ue_Routage. Elle sera aussi utilisée dans la fonction de         */
/* validation du UserObjet.                                         */
/*------------------------------------------------------------------*/
sRep = ProfileString ( stGLB.sFichierIni, "TRACE", "REP_TRACE", "Erreur" )
isFicEssaiTrc	= sRep + stGLB.sCodOper + String ( Today (), "ddmm" ) + ".TMP"

iuoGsSpSinistre.Uf_Traitement ( 1, stPass_Dga )

/*------------------------------------------------------------------*/
/* Modification DBI le 30/08/1999                                   */
/* DCMP 990391                                                      */
/* #1                                                               */
/* Chargement des motifs de routage                                 */
/*------------------------------------------------------------------*/

sFicRout = ProfileString ( stGLB.sFichierIni, "APPLICATION", "FICHIER_MOT_ROUT", "Erreur" )

If Not lnvString.of_isEmpty ( sFicRout ) Then // [MIGPB11] [EMD] : ImportFile d'une chaine vide
	Dw_Mot_Rout.ImportFile ( sFicRout )
End If // [MIGPB11] [EMD] : ImportFile d'une chaine vide

sRep = ProfileString ( stGLB.sFichierIni, "TRACE", "REP_TRACE_ROU", "Erreur" )
isFicEssaiTrcRout = sRep + stGLB.sCodOper + String ( Today (), "ddmm" ) + ".TMP"


/*------------------------------------------------------------------*/
/* Gestion du Passage à l'EURO.                                     */
/*------------------------------------------------------------------*/
N_Cst_Passage_Euro	nvPassageEuro

dwPassageEuro [ 1 ] = dw_1
dwPassageEuro [ 2 ] = dw_Lst_Gti
dwPassageEuro [ 3 ] = dw_Lst_Inter
dwPassageEuro [ 4 ] = dw_w_Div_Sin

nvPassageEuro = CREATE N_Cst_Passage_Euro
nvPassageEuro.uf_Initialiser ( dwPassageEuro[] )

//Migration PB8-WYNIWYG-03/2006 OR
//DESTROY nvPassageEuro
If IsValid(nvPassageEuro) Then DESTROY nvPassageEuro
//Fin Migration PB8-WYNIWYG-03/2006 OR

/*------------------------------------------------------------------*/
/* Initialisation de l'objet u_AideContrat                          */
/*------------------------------------------------------------------*/
cb_Aide.uf_Initialiser ( "AIDE", "Aide" )
cb_Notice.uf_Initialiser ( "NOTICE", "Notice" )
cb_Excel.uf_Initialiser ( "EXCEL", "Calculs" )


//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event ue_creer;call super::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::Ue_Creer
//* Evenement 		: Ue_Creer
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 16:37:38
//* Libellé			: 
//* Commentaires	: Ouverture des Fenêtres de détail.
//*				     (On est en création d'un détail)
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF  23/03/2004 Blob data pour SVE DCMP 040020
//* #2  JFF  10/01/2007 La lecture de l'ID_I n'est pas utile en création.
//* #3  JFF  18/09/2007 [ALAPAGE]
//*     FPI	 30/07/2010 [PM72]
//*	  FPI	 18/10/2010	 [PM72.1]
//*     JFF  20/01/2011  [PC363].[PANNE_PGC]
//		FPI	22/04/2014	[PC13362]
//*-----------------------------------------------------------------

s_Pass stPass_Dga
stPass_Dga = istPass
String sFiltre
Int iIdInter
Long lTot, lCpt, lnbContact
Boolean bRet, bOk

/*----------------------------------------------------------------------------*/
/* On peut créer un Contact en Consultation.                                  */
/*----------------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 OR
//If	isTypeTrt <> "S" And isDetailActif <> "dw_lst_contact" Then Return
If	isTypeTrt <> "S" And isDetailActif <> "dw_lst_contact" Then Return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

Choose Case isDetailActif
Case "dw_lst_inter"

	bRet	= True
	SetPointer ( HourGlass! )
//	iIdInter = dw_lst_inter.GetItemNumber ( dw_lst_inter.GetRow (), "ID_I" ) #2

/*------------------------------------------------------------------*/
/* On ne doit pas créer plus de 10 interlocuteurs. On ne gére pas   */
/* les trous, selon St Denis il n'y aura jamais plus de 2 ou 3      */
/* lignes dans la table. Donc on récupére simplement le dernier Id  */
/* de la DW sachant qu'elle est triée sur CODE_ID.                  */
/*------------------------------------------------------------------*/
	lTot = dw_Lst_Inter.RowCount ()
	If	lTot > 0 Then
		If	dw_Lst_Inter.GetItemNumber ( lTot, "ID_I" ) >= 10 Then
			bRet = False

			stMessage.sTitre		= "Création d'un interlocuteur - SIMPA 2"
			stMessage.Icon			= StopSign!
			stMessage.sVar [ 1 ]	= "d'interlocuteur"
			stMessage.sCode		= "WSIN100"
			F_Message ( stMessage )

		End If
	End If

	If	bRet Then
/*------------------------------------------------------------------*/
/* On arme la structure pour expliquer un certain nombre de         */
/* choses. On est en insertion, on veut un bouton CTRL. On passe    */
/* la DW de détail ainsi que la DW Master (Sinistre). Cette         */
/* dernière est trés importante. Elle va éviter d'utiliser des      */
/* instances de fenêtres.                                           */
/*------------------------------------------------------------------*/
		stPass_Dga.bInsert		= True
		stPass_Dga.bControl		= False
	
		stPass_Dga.sTab [ 1 ]	= This.Title
		stPass_Dga.sTab [ 2 ]	= isTypeTrt
 	// stPass_Dga.sTab [ 3 ]   Est réservé pour la modification.
	// stPass_Dga.sTab [ 4 ]	Est déjà utilisé !!!
	// stPass_Dga.sTab [ 5 ]	Est déjà utilisé !!!

		If ibSaisieValidation Then
//			stPass_Dga.sTab [ 6 ]	= iuoGsSpSinistre.uf_GetDataInter ( iIdInter ) // #1  #2
			stPass_Dga.sTab [ 6 ]	= "X"  // #2
		Else
			stPass_Dga.sTab [ 6 ]	= "X"
		End If

		stPass_Dga.bTab [ 1 ]	= ibAltCommune // Gestion des Communes O/N
		stPass_Dga.bTab [ 2 ]	= ibSaisieValidation // Gestion SVE

		stPass_Dga.dwTab [ 1 ]	= Dw_Lst_Inter
		stPass_Dga.dwTab [ 2 ]	= Dw_w_commande // [PM72]
		
		stPass_Dga.dwMaster		= dw_1

		stPass_Dga.udwTab [ 1 ]	= Dw_w_Div_Sin   // #3

		stPass_Dga.dwNorm [ 1 ]	= dw_Produit			// DataWindow PRODUIT
		stPass_Dga.dwNorm [ 2 ]	= dw_ParaProd			// DataWindow PARA_PROD
		stPass_Dga.dwNorm [ 3 ]	= dw_wParaInfo			// DataWindow W_PARA_INFO
		stPass_Dga.dwNorm [ 4 ]	= dw_wPiece				// DataWindow W_PIECE
		stPass_Dga.dwNorm [ 5 ]	= dw_wRefus				// DataWindow W_REFUS
		stPass_Dga.dwNorm [ 6 ]	= dw_wFrais				// DataWindow W_FRAIS
		stPass_Dga.dwNorm [ 7 ]	= dw_wDetail			// DataWindow W_DETAIL
		stPass_Dga.dwNorm [ 8 ]	= dw_Det_Pro			// DataWindow DET_PRO 
		stPass_Dga.dwNorm [ 9 ]	= dw_Commune			// DataWindow des Communes
		stPass_Dga.dwnorm [ 10 ]	= dw_cmde_typ_frn 		// [PM72.1]
		stPass_Dga.dwnorm [ 11 ]	= dw_w_div_sin		// [VDoc12394]

		F_OuvreTraitement ( iW_Tm_Sp_Interlocuteur, stPass_Dga )

	End If

Case "dw_lst_gti"

/*------------------------------------------------------------------*/
/* On va ouvrir une fenêtre pour demander au gestionnaire de        */
/* choisir une garantie.                                            */
/*------------------------------------------------------------------*/

	// [PC13362]
	If not wf_blocage_ouv_gti() Then return 0
	// :[PC13362]
	
/*------------------------------------------------------------------*/
/* On filtre les garanties déjà positionnées.                       */
/*------------------------------------------------------------------*/
	sFiltre = ""

	lTot = dw_Lst_Gti.RowCount ()
	If	lTot > 0 Then
		For	lCpt = 1 To lTot
			sFiltre = sFiltre + "ID_GTI <> " + String ( dw_Lst_Gti.GetItemNumber ( lCpt, "ID_GTI" ) ) + " AND "
		Next
/*------------------------------------------------------------------*/
/* On enléve le dernier AND généré dans la boucle.                  */
/*------------------------------------------------------------------*/
		sFiltre = Left ( sFiltre, Len ( sFiltre ) - 5 )
	End If
	
	// [PC363].[PANNE_PGC]
	// Complèment d'exclusion sur condidion
	
	sFiltre = This.Wf_Gti_Panne_PGC_Auchan ( sFiltre )
	
	// [PC786-1_AUCHAN_GEM]  
	sFiltre = This.Wf_Gti_Denree_Alim_Auchan ( sFiltre )		

	// [VDOC26935][PC171999]  
	sFiltre = This.wf_gti_somme_forfaitaire ( sFiltre )		

	// :[PC363].[PANNE_PGC]
	
	dw_CodeGarantie.SetFilter ( sFiltre )
	dw_CodeGarantie.Filter ()
	dw_CodeGarantie.Sort ()
	
	If	dw_CodeGarantie.RowCount () > 0 Then

		stPass_Dga.trTrans	= itrTrans
		stPass_Dga.wParent	= This
		stPass_Dga.dwNorm[1]	= dw_CodeGarantie

		OpenWithParm ( W_T_Sp_Choix_Garantie, stPass_Dga, stPass_Dga.wParent.ParentWindow () )

/*------------------------------------------------------------------*/
/* On va ouvrir une fenêtre CHILD qui va permettre de choisir la    */
/* garantie que l'on désire ouvrir. La 'suite' de l'ouverture de    */
/* la fenêtre de détail se fera sur l'événement Ue_Choix_Garantie.  */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On va enlever le filtre sur CODE_GARANTIE sur l'événément        */
/* UE_CHOIX_GARANTIE.                                               */
/*------------------------------------------------------------------*/
	Else
/*------------------------------------------------------------------*/
/* On enléve le filtre si il n'y a aucune ligne.                    */
/*------------------------------------------------------------------*/
		sFiltre = ""
		dw_CodeGarantie.SetFilter ( sFiltre )
		dw_CodeGarantie.Filter ()
		dw_CodeGarantie.Sort ()
	End If



Case "dw_lst_contact"

	lNbContact	=	Dw_Lst_Contact.RowCount ()
	bOk			=	True

	For lCpt = 1 To lNbContact 

		If Dw_Lst_Contact.GetItemStatus ( lCpt, 0, PRIMARY! ) = New! 			Or &
			Dw_Lst_Contact.GetItemStatus ( lCpt, 0, PRIMARY! ) = NewModified! Then

			bOk = False
			Exit
		End If 

		If Dw_Lst_Contact.GetItemString ( lCpt, "ALT_VALIDE" ) = "O" Then

			bOk = False
			Exit
		End If 

	Next

	stPass_Dga.bInsert		= True
	stPass_Dga.bControl		= True

	stPass_Dga.sTab [ 1 ]	= This.Title
	stPass_Dga.sTab [ 2 ]	= isTypeTrt
	
	stPass_Dga.dwTab [ 1 ]	= Dw_Lst_Contact
	stPass_Dga.dwTab [ 2 ]	= Dw_Lst_Inter

	stPass_Dga.udwTab [ 1 ]	= dw_DosSuiviPar
	
	stPass_Dga.dwNorm [ 1 ]	= Dw_Corb
	stPass_Dga.dwNorm [ 2 ]	= Dw_Produit

	stPass_Dga.dwMaster		= dw_1

	F_OuvreTraitement ( iW_Tm_Sp_W_Contact, stPass_Dga )



End Choose

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event show;call super::show;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::Show
//* Evenement 		: Show
//* Auteur			: Erick John Stark
//* Date				: 05/12/1997 16:25:00
//* Libellé			: 
//* Commentaires	: Initialisation de la variable ibMajAccueil à Faux
//*				  	  pour que la gestion automatique de la fenêtre d'accueil
//*				     ne soit pas effectuée. La mise à jour de l'accueil est réalisée
//*				     dans W_ACCUEIL_WORKFLOW.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

ibMajAccueil = False

PostEvent ( "ue_TailleFenetre" )


end event

on hide;call w_8_traitement_master::hide;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::Hide
//* Evenement 		: Hide
//* Auteur			: Catherine Abdmeziem
//* Date				: 06/07/2004
//* Libellé			: 
//* Commentaires	: DCMP 030381 : fermeture de la popup sur hide
//*				     
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

If IsValid ( w_T_Sp_Popup_Pol_Ass ) Then Close ( w_T_Sp_Popup_Pol_Ass )

end on

event we_childactivate;call super::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::We_ChildActivate
//* Evenement 		: We_ChildActivate
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:53:35
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.X			=    1
This.Y			=    1


// [PB2022_TAILLE_FEN] + xxx
This.Height		= 1769 + 90


// [PB2022_TAILLE_FEN] + xxx
This.Width		= 3598 + 50

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::Close
//* Evenement 		: Close
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 18:46:48
//* Libellé			: 
//* Commentaires	: Fermeture définitive de la fenêtre.
//*				     On supprime tous les NVUO.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF		16/03/04 DCMP 040020
//* #2  CAG		06/07/04 DCMP 030381 : ajout d'une popup police/assurance
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//Destroy iUoGsSpSinistre
//Destroy iuoGsSpContTrace 
If IsValid(iUoGsSpSinistre) Then Destroy iUoGsSpSinistre
If IsValid(iuoGsSpContTrace) Then Destroy iuoGsSpContTrace
//Fin Migration PB8-WYNIWYG-03/2006 FM

If IsValid ( iW_Tm_Sp_Interlocuteur	) Then Close ( iW_Tm_Sp_Interlocuteur )

If IsValid ( iW_Tm_Sp_W_Gar_Sin 		) Then Close ( iW_Tm_Sp_W_Gar_Sin )

If IsValid ( iW_T_Sp_Message 			) Then Close ( iW_T_Sp_Message )

If IsValid ( iW_T_Sp_Cree_Travail 		) Then Close ( iW_T_Sp_Cree_Travail )

If IsValid ( iW_Tm_Sp_W_Contact ) Then Close ( iW_Tm_Sp_W_Contact )

/*------------------------------------------------------------------*/
/* #2 : CAG 06/07/2004                                              */
/*------------------------------------------------------------------*/
If IsValid ( w_T_Sp_Popup_Pol_Ass ) Then Close ( w_T_Sp_Popup_Pol_Ass )

/*------------------------------------------------------------------*/
/* #1 Gestion Saisie/Validation.                                    */
/*------------------------------------------------------------------*/
If	ibSaisieValidation	Then
	If	IsValid ( invSaisieValSin )	Then DESTROY	invSaisieValSin
End If

end event

event ue_routage;call super::ue_routage;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::Ue_Routage
//* Evenement 		: Ue_Routage
//* Auteur			: Erick John Stark
//* Date				: 05/12/1997 16:36:19
//* Libellé			: 
//* Commentaires	: Ouverture de la fenêtre de routage
//*				  
//*-----------------------------------------------------------------
//* MAJ 	PAR		Date			Modification
//* #1	DBI 	30/08/1999	DCMP 990391 Gestion des motifs de routage			  
//* #2	JCA	05/12/2006	Modification de la corbeille interdite
//* #3	JFF	06/12/2006	On ne regarde le droit de validation que si
//*                        l'on est en validation.
//			FPI	26/12/2013	[PM217-2] Fenêtre de routage IWD
//			JFF   29/11/2023  CCO => Ticket 399863
//			JFF   29/11/2023  [OPTIM_UE_ROUTAGE]
//*-----------------------------------------------------------------

s_Pass stPass
Boolean bRet, bVal
String sVal
//Migration PB8-WYNIWYG-03/2006 OR
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 OR
String sIdIwd, sIdCorb
Long lIdSin
Boolean bOuvrirIwd=FALSE
String sIwdVersion="0"
Long lFamille
String sDosMajPar

/*------------------------------------------------------------------*/
/* Le gestionnaire a-t-il le droit de valider des dossiers pour ce  */
/* produits.                                                        */
/*------------------------------------------------------------------*/
If ibSaisieValidation And isTypeTrt = "V" Then // #3
	iuoGsSpSinistre.uf_GetAutorisation ( "", sVal, bVal, bVal, bRet, -1 )
	If Not bRet Then
		stMessage.sTitre		= "Vous n'êtes pas autorisé."
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= False
		stMessage.sCode		= "SVE0020"
	   stMessage.sVar [1]	= String ( dw_1.GetItemNumber ( 1, "ID_PROD" ) )

		F_Message ( stMessage )
//Migration PB8-WYNIWYG-03/2006 OR
//		Return
		Return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR
	End If
End If

/*------------------------------------------------------------------*/
/* La variable isCodEtat permet de déterminer si on est en saisie   */
/* ou en validation.                                                */
/*------------------------------------------------------------------*/

If	isCodEtat = '1' Then
	stPass.sTab[ 1 ] = '1'		// Saisie
	stPass.sTab[ 2 ] = String ( dw_1.GetItemNumber ( 1, "ID_SIN" ) )
	stPass.sTab[ 3 ] = stNul.str
// #2 -	stPass.sTab[ 4 ] = stNul.str
	stPass.sTab[ 4 ] = String ( dw_Produit.GetItemNumber ( 1, "ID_CORB" ) ) // #2
	stPass.sTab[ 5 ] = isFicEssaiTrc
	stPass.sTab[ 6 ] = isFicEssaiTrcRout	//#1
	stPass.dwNorm[ 1 ] = dw_mot_rout			//#1
Else
	stPass.sTab[ 1 ] = '2'		// Validation
	stPass.sTab[ 2 ] = String ( dw_1.GetItemNumber ( 1, "ID_SIN" ) )
	stPass.sTab[ 3 ] = dw_1.GetItemString ( 1, "MAJ_PAR" )
	stPass.sTab[ 4 ] = String ( dw_Produit.GetItemNumber ( 1, "ID_CORB" ) )
	stPass.sTab[ 5 ] = isFicEssaiTrc
	stPass.sTab[ 6 ] = isFicEssaiTrcRout	//#1
	stPass.dwNorm[ 1 ] = dw_mot_rout			//#1
End If

SetNull(sIdIwd)


// [PM217-2] 
sIwdVersion=ProfileString( stGlb.sFichierini,"APPLICATION","IWD_VERSION","0")
SetNull(lFamille)

lIdSin=dw_1.GetItemNumber ( 1, "ID_SIN" ) 

//	 JFF   29/11/2023  CCO => Ticket 399863, on ajoute 2172 [OPTIM_UE_ROUTAGE]
If F_CLE_A_TRUE ( "OPTIM_UE_ROUTAGE" ) Then
	sIdIwd = Space ( 50 )
	sIdCorb = Space ( 3 ) 
	SQLCA.PS_IWD_CORB_FAM ( lIdSin, sIdIwd, sIdCorb, lFamille )
Else 
	Select id_iwd, id_corb, id_fam
	Into :sIdIwd, :sIdCorb, :lFamille
	From sysadm.w_queue
		LEFT outer join  sysadm.famille on sysadm.w_queue.id_corb=sysadm.famille.id_code and (id_fam=217 or id_fam=2172)
	Where id_sin=:lIdSin
	Using SQLCA;
End If 

If not isnull(sIdIwd) Then bOuvrirIwd=TRUE

//	Mantis 10927
Choose Case sIwdVersion
	Case "0"
		// On ne change rien
	Case "1"
		If Not isnull(lFamille) Then bOuvrirIwd=TRUE
	Case "2"
		bOuvrirIwd=TRUE
End Choose

sDosMajPar=dw_1.GetItemString(1,"MAJ_PAR")
If sDosMajPar="IMGA" or sDosMajPar="EADR"  or sDosMajPar="ML" Then bOuvrirIwd=FALSE
if stglb.scodoper="ML" Then bOuvrirIwd=FALSE

If not bOuvrirIwd Then
	OpenWithParm ( W_Routage, stPass )
else
	stPass.Stab[3]=stGlb.sCodOper
	OpenWithParm ( W_Routage_iwd, stPass )
End if
// :[PM217-2] 

stPass = Message.PowerObjectParm

If	stPass.sTab[ 1 ] = "ROU" Then

/*------------------------------------------------------------------*/
/* Gestion Saisie/Validation.                                       */
/*------------------------------------------------------------------*/
	If	ibSaisieValidation	Then
		If	invSaisieValSin.uf_CourWord_ViderWord ( isCodEtat = '2' ) > 0	Then
//Migration PB8-WYNIWYG-03/2006 OR
//			If	invSaisieValSin.uf_CourWord_PurgerCourriersLocal ( TRUE ) <= 0	Then Return
			If	invSaisieValSin.uf_CourWord_PurgerCourriersLocal ( TRUE ) <= 0	Then Return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR
		Else
//Migration PB8-WYNIWYG-03/2006 OR
//			Return
			Return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR
		End If
	End If
	
	isCodOper	= stPass.sTab[ 2 ]
	isIdCorb		= stPass.sTab[ 3 ]
	isTxtMess	= stPass.sTab[ 4 ]
	isCodAction	= "3"
//Migration PB8-WYNIWYG-03/2006 OR
//	This.TriggerEvent ( "Ue_Retour" )

	// [PM217-2]
	If not isnull(sIdIwd) Then
		//isTxtMess="IWD travail routé à " + isCodOper
		SQLCA.Iwd_Update_Iwd_Router_Dossier( String(lIdSin) , isIdCorb, isCodOper, isTxtMess)
	End if
	// :[PM217-2]
	
	ll_ret = This.TriggerEvent ( "Ue_Retour" )
//Fin Migration PB8-WYNIWYG-03/2006 OR

End If

//Migration PB8-WYNIWYG-03/2006 OR
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::Ue_Retour (OverRide!!)
//* Evenement 		: Ue_Retour
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:29:51
//* Libellé			: 
//* Commentaires	: Opérations  à effectuer avant la fermeture de la fenêtre
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* DCMP990451	JFF		29/09/99 Affichage du message d'ouverture de 
//*										de pochette				  
//* #2		   JFF		05/09/02 Gestion de la gestion de contact uniquement pour Sherpa
//* #3			JFF		16/03/04 DCMP 040020
//* #4			JFF      07/04/2006 Migration PB8-SPB-04/2006 - Appel supplémentaire.
//*-----------------------------------------------------------------

Boolean bOkPourFermer

bOkPourFermer = TRUE

/*------------------------------------------------------------------*/
/* #3 Gestion Saisie/Validation.                                    */
/*------------------------------------------------------------------*/
If	ibSaisieValidation And isTypeTrt <> "C"	Then
	// [PI052]
	/*
	If F_CLE_A_TRUE ( "PI052" ) Then
		If invSaisieValSin.ibPI052_GenEdtKsl Then
			If ibSaisieValidation Then invSaisieValSin.uf_PI052_Verif_Presence_Courrier ()			
		Else
			If	invSaisieValSin.uf_CourWord_ViderWord ( TRUE ) > 0	Then
				If	invSaisieValSin.uf_CourWord_PurgerTouslesCourriers () <= 0	Then Return
			Else
				Return
			End If
		End If
	Else */
		If	invSaisieValSin.uf_CourWord_ViderWord ( TRUE ) > 0	Then
			If	invSaisieValSin.uf_CourWord_PurgerTouslesCourriers () <= 0	Then Return
		Else
			Return
		End If
// 	End If
End If

/*------------------------------------------------------------------*/
/* DCMP990451                                           				  */
/*------------------------------------------------------------------*/
st_Pochette.Hide()

/*------------------------------------------------------------------*/
/* Il faut mettre le script en OVERRIDE.                            */
/* Appel de l'événement UE_MajAccueil avant le retour de la         */
/* fenêtre.                                                         */
/* En effet UE_Retour ne traite pas Ue_MajAccueil si la variable    */
/* ibMajAccueil est à Faux.                                         */
/*------------------------------------------------------------------*/

If IsValid ( W_Consulter_Paragraphe ) Then Close ( W_Consulter_Paragraphe )

/*----------------------------------------------------------------------------*/
/* Gestion des contacts en consultation.                                      */
/*------------------------------------------------------------------*/
/* #2 : JFF le 04/09/2002														  */
/*------------------------------------------------------------------*/
If isTypeTrt = "C" Then
	IF ibAltcontact Then 
		iuoGsSpContTrace.uf_Retour_GestionTrace  ( bOkPourFermer, isATraiterPar )
	ElseIf ibAltcontactSherpa Then 
		iuoGsSpContTrace.uf_Retour_GestionSherpa  ( bOkPourFermer )
	End If
End If

If bOkPourFermer Then 
	This.TriggerEvent ( "UE_MajAccueil" )
	Call Super::Ue_Retour
	
	// #4
	If bFenValAOuvrir Then
		stGlb.sMessageErreur = String ( Dw_1.GetItemNumber ( 1, "ID_SIN" ) )
		Dw_1.PostEvent ( "ue_Ouvrir_FenValidation", 2, 0 )
	End If
	
End If


end event

event ue_majaccueil;call super::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::Ue_MajAccueil
//* Evenement 		: Ue_MajAccueil
//* Auteur			: Erick John Stark
//* Date				: 03/06/1997 11:57:04
//* Libellé			: 
//* Commentaires	: NE JAMAIS ENVOYER DE ' DANS LA CHAINE isMajAccueil
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1 DBI le 30/08/1999 DCMP 990391 Gestion des motifs de routage			 
//* #2 FS  le 16/12/2002 Dcmp 20430 Ajt code état dans trace workflow		 
//*-----------------------------------------------------------------

String 		sTab	= "~t"	// Code tabulation

Long			lCodEtat				// Code Etat du dossier
String		sAltBloc 			// Dossier bloqué ?
String		sMess					// Message saisi
String		sCorbProd			// Corbeille assignée au produit
String		sMajLe, sCreele	// Dates et heures de création et de maj
String		sMajPar				// Responsable de la maj
String		sDtHeure				// Date et heure actuelle
String		sNom					// Nom et prénom
String		sIdSin				// Référence Sinistre
String		sMajParDep
String		sMotifRoutage = "N"// Gestion des motifs de routage  #1
String      sCodEtat           // #2


If dw_1.RowCount () <= 0 Then
	iwParent.TriggerEvent ( "UE_MODIFIER" )	// Réalise les mises à jour liées au WorkFlow
	Return 1
End If 

sDtHeure		= String ( DateTime ( Today(), Now () ), "dd/mm/yyyy hh:mm:ss.ff" )
lCodEtat		= dw_1.GetItemNumber ( 1, "COD_ETAT" )

sMess			= dw_1.GetItemString ( 1, "TXT_MESS" )														
sMajPar		= dw_1.GetItemString ( 1, "MAJ_PAR"  ) 
sAltBloc		= dw_1.GetItemString ( 1, "ALT_BLOC" )
sIdSin		= String ( dw_1.GetItemNumber ( 1, "ID_SIN" ) )

sCreeLe		= String ( dw_1.GetItemDateTime ( 1, "CREE_LE" ), "dd/mm/yyyy hh:mm:ss.ff" )
sMajLe		= String ( dw_1.GetItemDateTime ( 1, "MAJ_LE"  ), "dd/mm/yyyy hh:mm:ss.ff" )

sCorbProd	= String ( dw_Produit.GetItemNumber ( 1, "ID_CORB" ) )
sNom			= dw_1.GetItemString ( 1, "NOM" )	+ " "	+ dw_1.GetItemString( 1, "PRENOM"  )

If IsNull ( sMess ) Then sMess = ""

/*------------------------------------------------------------------*/
/* #2 SIMPA : Le code état du dossier n'est pas renseigné           */
/*            Tj à "0" pour compatibilité fichier avec SINDI        */
/*------------------------------------------------------------------*/

sCodEtat = "0"

/*------------------------------------------------------------------*/
/* S'il n'y a aucun courrier dans DW_COURRIER, que la zone          */
/* lCodEtat ne soit pas égale à 1 (BLOQUEE) et que l'on soit en     */
/* saisie, on passe directement le dossier A EDITER (COD_ETAT=5).   */
/*------------------------------------------------------------------*/
If	lCodEtat <> 1 And isCodEtat = "1" And dw_wCourrier.RowCount () = 0 And isCodAction = "1" Then
	isCodAction = "5"
End If

Choose Case isCodEtat

Case "1" 					// Cas de la saisie
/*------------------------------------------------------------------*/
/* Il est possible que la zone ALT_BLOC ne soit par armée, et       */
/* pourtant la zone COD_ETAT est égale à 1 (BLOQUEE!!).             */
/*------------------------------------------------------------------*/
	If ( lCodEtat = 1 ) And isCodAction = '1' Then	
		sAltBloc			= "O" 
		isCodAction		= "4"
	End If

	/*----------------------------------------------------------------------------*/
	/* La variable isCodAction est armée lors de l'appui sur les boutons de la    */
	/* manière suivante                                                           */
	/*                                                                            */
	/*    1 - Bouton Valider                                                      */
	/*    2 - Bouton Retour                                                       */
	/*    3 - Bouton Routage                                                      */
	/*    4 - Bouton Valider alors que le dossier est bloqué                      */
	/*----------------------------------------------------------------------------*/

	Choose Case isCodAction

	Case '1', '4', '5'	// 1 ....................................... Controle-Valider
								// 4 ....................................... Controle-Valider Bloqué
								// 5 ....................................... Controle-Valider sans courrier ( on passe à la validation )

		isMajAccueil = 	sCreele					+ sTab	+ &
								sCorbProd				+ sTab	+ &
								sIdSin					+ sTab	+ &
								sNom						+ sTab	+ &
								sMajLe					+ sTab	+ &
								sMajPar					+ sTab	+ &
								isCodEtat 				+ sTab	+ &
								"N"						+ sTab	+ &
								sAltBloc					+ sTab	+ &
															+ sTab	+ &
															+ sTab	+ &
								sMess						+ sTab	+ &
								sMajLe					+ sTab	+ &
								sMajPar					+ sTab	+ &
								isCodAction				+ sTab	+ &
															+ sTab	+ &	
															+ sTab	+ &
                        sCodEtat             + sTab

	 Case '2' 				// ....................................... Retour

		sMess	   = dw_1.GetItemString	( 1, "TXT_MESS", Primary!, True )														
		sAltBloc = dw_1.GetItemString ( 1, "ALT_BLOC", Primary!, True )	
		sNom     = dw_1.GetItemString ( 1, "NOM"     , Primary!, True )	+ " "	+&
				     dw_1.GetItemString ( 1, "PRENOM"  , Primary!, True )

		sMajParDep	= dw_1.GetItemString ( 1, "MAJ_PAR", Primary!, True )

		If IsNull ( sMess ) Then sMess = ""

		isMajAccueil 	=	sCreele					+ sTab	+ &
								sCorbProd				+ sTab	+ &
								sIdSin					+ sTab	+ &
								sNom						+ sTab	+ &
								sMajLe					+ sTab	+ &
								sMajPar					+ sTab	+ &
								isCodEtat			 	+ sTab	+ &
								"N" 						+ sTab	+ &
								sAltBloc					+ sTab	+ &
															+ sTab	+ &	
															+ sTab	+ &	
								sMess						+ sTab	+ &
								sDtHeure					+ sTab	+ &
 								stGlb.sCodOper			+ sTab	+ &
								isCodAction				+ sTab	+ &
															+ sTab	+ &	
															+ sTab	+ &
                        sCodEtat             + sTab	

	 Case '3' 				// ....................................... Routage

		sMess  	= isTxtMess
		sMajLe 	= String ( dw_1.GetItemDateTime ( 1, "MAJ_LE" , Primary!, True ), "dd/mm/yyyy hh:mm:ss.ff" )

 		sMajPar	= dw_1.GetItemString ( 1, "MAJ_PAR", Primary!, true ) 
		sAltBloc = dw_1.GetItemString	( 1, "ALT_BLOC", Primary!, True )	

		sNom   	= dw_1.GetItemString ( 1, "NOM"     , Primary!, True )	+ " "	+&
 			        dw_1.GetItemString ( 1, "PRENOM"  , Primary!, True )

		isMajAccueil 	=	sCreeLe					+ sTab	+ &
 								isIdCorb					+ sTab	+ &
 								sIdSin					+ sTab	+ &
 								sNom						+ sTab	+ &
								sMajLe					+ sTab	+ &
								sMajPar					+ sTab	+ &
								isCodEtat 				+ sTab	+ &
								"N" 						+ sTab	+ &
 								sAltBloc			 		+ sTab	+ &
								sdtHeure					+ sTab	+ &
 								isCodOper				+ sTab	+ &
								sMess						+ sTab	+ &
								sdtHeure					+ sTab	+ &
 								stGlb.sCodOper			+ sTab	+ &
								isCodAction				+ sTab	+ &
															+ sTab	+ &	
															+ sTab	+ &
                        sCodEtat             + sTab	

	End Choose

Case "5"		// Validation

	Choose Case isCodAction

	 Case '1' 				// ....................................... Controle-Valider

		sDtHeure		= String ( dw_1.GetItemDateTime ( 1, "MAJ_LE"  ), "dd/mm/yyyy hh:mm:ss.ff" )

		isMajAccueil =		sCreeLe					+ sTab	+ &
								sCorbProd				+ sTab	+ &
								sIdSin					+ sTab	+ &
								sNom						+ sTab	+ &
								sMajLe					+ sTab	+ &
								sMajpar					+ sTab	+ &
								isCodEtat				+ sTab	+ &
								"N" 						+ sTab	+ &
								sAltBloc					+ sTab	+ &
															+ sTab	+ &
															+ sTab	+ &
															+ sTab	+ &
								sDtHeure					+ sTab	+ &
 								stGlb.sCodOper			+ sTab	+ &
								isCodAction				+ sTab	+ &
															+ sTab	+ &	
															+ sTab	+ &
                        sCodEtat             + sTab	

	 Case '2' 				// ....................................... Retour

		sMess	= dw_1.GetItemString	( 1, "TXT_MESS" )														
		If IsNull ( sMess ) Then sMess = ""

		isMajAccueil 	=	sCreeLe					+ sTab	+ &
								sCorbProd				+ sTab	+ &
								sIdSin					+ sTab	+ &
 								sNom						+ sTab	+ &
								sDtHeure					+ sTab	+ &
								sMajPar					+ sTab	+ &
								isCodEtat 				+ sTab	+ &
								"N"						+ sTab	+ &
 								sAltBloc					+ sTab	+ &
															+ sTab	+ &
															+ sTab	+ &
								sMess						+ sTab	+ &
								sDtHeure					+ sTab	+ &
 								stGlb.sCodOper			+ sTab	+ &
								isCodAction				+ sTab	+ &
															+ sTab	+ &	
															+ sTab	+ &
                        sCodEtat             + sTab	

	 Case '3' 				// ....................................... Routage

		sMess  	= isTxtMess
		sMajLe 	= String ( dw_1.GetItemDateTime ( 1, "MAJ_LE" , Primary!, True ), "dd/mm/yyyy hh:mm:ss.ff" )
 		sMajPar	= dw_1.GetItemString ( 1, "MAJ_PAR", Primary!, true ) 
		sAltBloc = dw_1.GetItemString	( 1, "ALT_BLOC", Primary!, True )	
		sMotifRoutage = "ROU"				// #1

		isMajAccueil 	=	sCreeLe					+ sTab	+ &
 								isIdCorb					+ sTab	+ &
								sIdSin					+ sTab	+ &
 								sNom						+ sTab	+ &
								sMajLe					+ sTab	+ &
								sMajPar					+ sTab	+ &
								isCodEtat				+ sTab	+ &
								"N" 						+ sTab	+ &
 								sAltBloc					+ sTab	+ &
								sdtHeure					+ sTab	+ &
 								isCodOper				+ sTab	+ &
								sMess						+ sTab	+ &
								sMajLe					+ sTab	+ &
 								stGlb.sCodOper			+ sTab	+ &
								isCodAction				+ sTab	+ &
															+ sTab	+ &	
															+ sTab	+ &
                        sCodEtat             + sTab	

	End Choose
End Choose

/*----------------------------------------------------------------------------*/
/* Appel de la mise à jour du WorkFlow                                        */
/*----------------------------------------------------------------------------*/

istPass.sTab[1]	=	"AUT"						// Mode automatique pour la mise à jour de la fenêtre WorkFlow
istPass.sTab[2]	=	isMajAccueil
istPass.sTab[3]	=	sMotifRoutage

// #1

If sMotifRoutage = "ROU" Then

	istPass.dwNorm[1] = dw_mot_rout
End If	

Message.PowerObjectParm = istPass

iwParent.TriggerEvent ( "UE_MAJACCUEIL" )	// Réalise les mises à jour liées au WorkFlow

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

on ue_item5;call w_8_traitement_master::ue_item5;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::Item 5
//* Evenement 		: Item5
//* Auteur			: FABRY JF
//* Date				: 01/02/2002
//* Libellé			: 
//* Commentaires	: Evenement déclenché à partir de la fenêtre contacts
//*					  en consultation pour récupérer les init de la personne
//*					  qui va traiter le travail.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

isATraiterPar = iW_Tm_Sp_W_Contact.dw_a_traiter_par.GetItemString ( 1, "DOS_SUIVI_PAR" ) 


end on

event ue_enablefenetre;call super::ue_enablefenetre;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::Ue_EnableFenetre
//* Evenement 		: Ue_EnableFenetre
//* Auteur			: Erick John Stark
//* Date				: 09/06/1998 17:20:28
//* Libellé			: 
//* Commentaires	: On vient de la fenêtre des Garanties
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String sMonnaie

/*------------------------------------------------------------------*/
/* Si on est en saisie, il faut regénérer le TreeView.              */
/*------------------------------------------------------------------*/
Choose Case isTypeTrt
Case "S"
	sMonnaie = stGLB.sMonnaieFormatDesire
	Wf_Enabled_Fenetre ( sMonnaie )

/*------------------------------------------------------------------*/
/* On est en consultation, on détermine d'ou l'on vient (GTI ou     */
/* INTER), on récupére la valeur de la monnaie pour cette fenêtre,  */
/* et on positionne la même valeur pour la fenêtre en cours.        */
/*------------------------------------------------------------------*/
Case "C"
	Choose Case isDetailConsult
	Case "dw_lst_inter"
		sMonnaie = iW_Tm_Sp_Interlocuteur.Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()

	Case "dw_lst_gti"
		sMonnaie = iW_Tm_Sp_W_Gar_Sin.Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()

	End Choose

	If	This.Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante () <> sMonnaie	Then
		Uo_Consult_Euro.Uf_Changer_Monnaie ( sMonnaie )
		Wf_Enabled_Fenetre ( sMonnaie )
	End If

End Choose

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

on w_tm_sp_sinistre.create
int iCurrent
call super::create
this.pb_routage=create pb_routage
this.uo_ong=create uo_ong
this.dw_produit=create dw_produit
this.p_focus=create p_focus
this.dw_codegarantie=create dw_codegarantie
this.dw_paraprod=create dw_paraprod
this.dw_wparainfo=create dw_wparainfo
this.dw_piece=create dw_piece
this.dw_motif=create dw_motif
this.dw_delai=create dw_delai
this.dw_franchise=create dw_franchise
this.dw_plafond=create dw_plafond
this.dw_garantie=create dw_garantie
this.dw_condition=create dw_condition
this.dw_wdetail=create dw_wdetail
this.dw_wpiece=create dw_wpiece
this.dw_wrefus=create dw_wrefus
this.dw_codecondition=create dw_codecondition
this.dw_wfrais=create dw_wfrais
this.dw_wcourrier=create dw_wcourrier
this.uo_libelle=create uo_libelle
this.dw_police=create dw_police
this.uo_3d=create uo_3d
this.dw_lst_inter=create dw_lst_inter
this.dw_lst_gti=create dw_lst_gti
this.dw_wparaplafond=create dw_wparaplafond
this.dw_wreggti=create dw_wreggti
this.dw_mot_rout=create dw_mot_rout
this.st_pochette=create st_pochette
this.dw_lst_contact=create dw_lst_contact
this.dw_corb=create dw_corb
this.dw_article=create dw_article
this.dw_w_commande=create dw_w_commande
this.dw_cmde_typ_frn=create dw_cmde_typ_frn
this.dw_cmde_typ_art=create dw_cmde_typ_art
this.cb_aide=create cb_aide
this.cb_notice=create cb_notice
this.dw_horaire_rdv=create dw_horaire_rdv
this.dw_zone_fournisseur=create dw_zone_fournisseur
this.dw_det_article=create dw_det_article
this.dw_det_hlr=create dw_det_hlr
this.dw_lst_gamme=create dw_lst_gamme
this.dw_det_pro=create dw_det_pro
this.cb_noboite=create cb_noboite
this.dw_boutique=create dw_boutique
this.dw_commune=create dw_commune
this.dw_tac_imei=create dw_tac_imei
this.dw_boitearchive=create dw_boitearchive
this.dw_mail=create dw_mail
this.dw_autorisation=create dw_autorisation
this.dw_gencourrier=create dw_gencourrier
this.dw_stk_w_cour_blob_sve=create dw_stk_w_cour_blob_sve
this.dddw_typedoc=create dddw_typedoc
this.lb_fichier=create lb_fichier
this.dw_choixcourgen=create dw_choixcourgen
this.dw_compo=create dw_compo
this.pb_validation_dossier=create pb_validation_dossier
this.dw_div_pro=create dw_div_pro
this.dw_w_div_sin=create dw_w_div_sin
this.cb_polass=create cb_polass
this.dddw_codecar_wdivsin_charg_tempo=create dddw_codecar_wdivsin_charg_tempo
this.dddw_code_wdivsin_charg_tempo=create dddw_code_wdivsin_charg_tempo
this.dw_code_equivalence=create dw_code_equivalence
this.dw_stk_ifr=create dw_stk_ifr
this.dddw_ifr_marque=create dddw_ifr_marque
this.dw_code_mb=create dw_code_mb
this.dddw_ifr_modele=create dddw_ifr_modele
this.cb_categ=create cb_categ
this.cb_excel=create cb_excel
this.dddw_dty_modele=create dddw_dty_modele
this.dddw_dty_marque=create dddw_dty_marque
this.dw_code_rf=create dw_code_rf
this.dw_stk_codic_darty=create dw_stk_codic_darty
this.dw_div_pdet=create dw_div_pdet
this.dw_w_div_det=create dw_w_div_det
this.cb_valid_factu=create cb_valid_factu
this.dw_dossuivipar=create dw_dossuivipar
this.st_mode_reprise=create st_mode_reprise
this.cb_aide_mode_reprise=create cb_aide_mode_reprise
this.cb_aide_base_manuelle=create cb_aide_base_manuelle
this.cb_journal=create cb_journal
this.uo_consult_euro=create uo_consult_euro
this.st_pause_api_lab=create st_pause_api_lab
this.dw_wreg_frais_annexe_frn=create dw_wreg_frais_annexe_frn
this.st_attente_diverse=create st_attente_diverse
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_routage
this.Control[iCurrent+2]=this.uo_ong
this.Control[iCurrent+3]=this.dw_produit
this.Control[iCurrent+4]=this.p_focus
this.Control[iCurrent+5]=this.dw_codegarantie
this.Control[iCurrent+6]=this.dw_paraprod
this.Control[iCurrent+7]=this.dw_wparainfo
this.Control[iCurrent+8]=this.dw_piece
this.Control[iCurrent+9]=this.dw_motif
this.Control[iCurrent+10]=this.dw_delai
this.Control[iCurrent+11]=this.dw_franchise
this.Control[iCurrent+12]=this.dw_plafond
this.Control[iCurrent+13]=this.dw_garantie
this.Control[iCurrent+14]=this.dw_condition
this.Control[iCurrent+15]=this.dw_wdetail
this.Control[iCurrent+16]=this.dw_wpiece
this.Control[iCurrent+17]=this.dw_wrefus
this.Control[iCurrent+18]=this.dw_codecondition
this.Control[iCurrent+19]=this.dw_wfrais
this.Control[iCurrent+20]=this.dw_wcourrier
this.Control[iCurrent+21]=this.uo_libelle
this.Control[iCurrent+22]=this.dw_police
this.Control[iCurrent+23]=this.uo_3d
this.Control[iCurrent+24]=this.dw_lst_inter
this.Control[iCurrent+25]=this.dw_lst_gti
this.Control[iCurrent+26]=this.dw_wparaplafond
this.Control[iCurrent+27]=this.dw_wreggti
this.Control[iCurrent+28]=this.dw_mot_rout
this.Control[iCurrent+29]=this.st_pochette
this.Control[iCurrent+30]=this.dw_lst_contact
this.Control[iCurrent+31]=this.dw_corb
this.Control[iCurrent+32]=this.dw_article
this.Control[iCurrent+33]=this.dw_w_commande
this.Control[iCurrent+34]=this.dw_cmde_typ_frn
this.Control[iCurrent+35]=this.dw_cmde_typ_art
this.Control[iCurrent+36]=this.cb_aide
this.Control[iCurrent+37]=this.cb_notice
this.Control[iCurrent+38]=this.dw_horaire_rdv
this.Control[iCurrent+39]=this.dw_zone_fournisseur
this.Control[iCurrent+40]=this.dw_det_article
this.Control[iCurrent+41]=this.dw_det_hlr
this.Control[iCurrent+42]=this.dw_lst_gamme
this.Control[iCurrent+43]=this.dw_det_pro
this.Control[iCurrent+44]=this.cb_noboite
this.Control[iCurrent+45]=this.dw_boutique
this.Control[iCurrent+46]=this.dw_commune
this.Control[iCurrent+47]=this.dw_tac_imei
this.Control[iCurrent+48]=this.dw_boitearchive
this.Control[iCurrent+49]=this.dw_mail
this.Control[iCurrent+50]=this.dw_autorisation
this.Control[iCurrent+51]=this.dw_gencourrier
this.Control[iCurrent+52]=this.dw_stk_w_cour_blob_sve
this.Control[iCurrent+53]=this.dddw_typedoc
this.Control[iCurrent+54]=this.lb_fichier
this.Control[iCurrent+55]=this.dw_choixcourgen
this.Control[iCurrent+56]=this.dw_compo
this.Control[iCurrent+57]=this.pb_validation_dossier
this.Control[iCurrent+58]=this.dw_div_pro
this.Control[iCurrent+59]=this.dw_w_div_sin
this.Control[iCurrent+60]=this.cb_polass
this.Control[iCurrent+61]=this.dddw_codecar_wdivsin_charg_tempo
this.Control[iCurrent+62]=this.dddw_code_wdivsin_charg_tempo
this.Control[iCurrent+63]=this.dw_code_equivalence
this.Control[iCurrent+64]=this.dw_stk_ifr
this.Control[iCurrent+65]=this.dddw_ifr_marque
this.Control[iCurrent+66]=this.dw_code_mb
this.Control[iCurrent+67]=this.dddw_ifr_modele
this.Control[iCurrent+68]=this.cb_categ
this.Control[iCurrent+69]=this.cb_excel
this.Control[iCurrent+70]=this.dddw_dty_modele
this.Control[iCurrent+71]=this.dddw_dty_marque
this.Control[iCurrent+72]=this.dw_code_rf
this.Control[iCurrent+73]=this.dw_stk_codic_darty
this.Control[iCurrent+74]=this.dw_div_pdet
this.Control[iCurrent+75]=this.dw_w_div_det
this.Control[iCurrent+76]=this.cb_valid_factu
this.Control[iCurrent+77]=this.dw_dossuivipar
this.Control[iCurrent+78]=this.st_mode_reprise
this.Control[iCurrent+79]=this.cb_aide_mode_reprise
this.Control[iCurrent+80]=this.cb_aide_base_manuelle
this.Control[iCurrent+81]=this.cb_journal
this.Control[iCurrent+82]=this.uo_consult_euro
this.Control[iCurrent+83]=this.st_pause_api_lab
this.Control[iCurrent+84]=this.dw_wreg_frais_annexe_frn
this.Control[iCurrent+85]=this.st_attente_diverse
end on

on w_tm_sp_sinistre.destroy
call super::destroy
destroy(this.pb_routage)
destroy(this.uo_ong)
destroy(this.dw_produit)
destroy(this.p_focus)
destroy(this.dw_codegarantie)
destroy(this.dw_paraprod)
destroy(this.dw_wparainfo)
destroy(this.dw_piece)
destroy(this.dw_motif)
destroy(this.dw_delai)
destroy(this.dw_franchise)
destroy(this.dw_plafond)
destroy(this.dw_garantie)
destroy(this.dw_condition)
destroy(this.dw_wdetail)
destroy(this.dw_wpiece)
destroy(this.dw_wrefus)
destroy(this.dw_codecondition)
destroy(this.dw_wfrais)
destroy(this.dw_wcourrier)
destroy(this.uo_libelle)
destroy(this.dw_police)
destroy(this.uo_3d)
destroy(this.dw_lst_inter)
destroy(this.dw_lst_gti)
destroy(this.dw_wparaplafond)
destroy(this.dw_wreggti)
destroy(this.dw_mot_rout)
destroy(this.st_pochette)
destroy(this.dw_lst_contact)
destroy(this.dw_corb)
destroy(this.dw_article)
destroy(this.dw_w_commande)
destroy(this.dw_cmde_typ_frn)
destroy(this.dw_cmde_typ_art)
destroy(this.cb_aide)
destroy(this.cb_notice)
destroy(this.dw_horaire_rdv)
destroy(this.dw_zone_fournisseur)
destroy(this.dw_det_article)
destroy(this.dw_det_hlr)
destroy(this.dw_lst_gamme)
destroy(this.dw_det_pro)
destroy(this.cb_noboite)
destroy(this.dw_boutique)
destroy(this.dw_commune)
destroy(this.dw_tac_imei)
destroy(this.dw_boitearchive)
destroy(this.dw_mail)
destroy(this.dw_autorisation)
destroy(this.dw_gencourrier)
destroy(this.dw_stk_w_cour_blob_sve)
destroy(this.dddw_typedoc)
destroy(this.lb_fichier)
destroy(this.dw_choixcourgen)
destroy(this.dw_compo)
destroy(this.pb_validation_dossier)
destroy(this.dw_div_pro)
destroy(this.dw_w_div_sin)
destroy(this.cb_polass)
destroy(this.dddw_codecar_wdivsin_charg_tempo)
destroy(this.dddw_code_wdivsin_charg_tempo)
destroy(this.dw_code_equivalence)
destroy(this.dw_stk_ifr)
destroy(this.dddw_ifr_marque)
destroy(this.dw_code_mb)
destroy(this.dddw_ifr_modele)
destroy(this.cb_categ)
destroy(this.cb_excel)
destroy(this.dddw_dty_modele)
destroy(this.dddw_dty_marque)
destroy(this.dw_code_rf)
destroy(this.dw_stk_codic_darty)
destroy(this.dw_div_pdet)
destroy(this.dw_w_div_det)
destroy(this.cb_valid_factu)
destroy(this.dw_dossuivipar)
destroy(this.st_mode_reprise)
destroy(this.cb_aide_mode_reprise)
destroy(this.cb_aide_base_manuelle)
destroy(this.cb_journal)
destroy(this.uo_consult_euro)
destroy(this.st_pause_api_lab)
destroy(this.dw_wreg_frais_annexe_frn)
destroy(this.st_attente_diverse)
end on

event timer;call super::timer;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::Timer
//* Evenement 		: Item5
//* Auteur			: FABRY JF
//* Date				: 25/06/2014
//* Libellé			: [PI052]
//* Commentaires	: Evenement déclenché à partir de la fenêtre contacts
//*					  en consultation pour récupérer les init de la personne
//*					  qui va traiter le travail.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass stPass

// Test d'un boolean de façon à pouvoir déclencher le Timer pour d'autres traitement
// est pas pour le PI052.

// SI timer du PI052 Allumé
If invSaisieValSin.ibTimerPI052 Then
	pb_Controler.Enabled = False

	// Si fin PDF pas encore généré
	If Not invSaisieValSin.ibFinGenerationPDFOk Then

		// Alors on srute toujours le répertoire
		If invSaisieValSin.uf_PI052_GestionTimer ( "SCRUTER", 0 ) <= 0 Then
		
			//... Et si délai dépassé Alors...
			invSaisieValSin.uf_PI052_GestionTimer ( "ARRETER_TIMER", 0 )
			OpenWithParm ( W_Trt_Capture_Click, "" )
			
			stMessage.sTitre		= "Génération des courriers"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "P234021"
			F_Message ( stMessage )  
			
			pb_Controler.Enabled = True			

		End If

	Else // ...Sinon succès, courrier récupérés.
		invSaisieValSin.uf_PI052_GestionTimer ( "ARRETER_TIMER", 0 )
		OpenWithParm ( W_Trt_Capture_Click, "" )
		
		dw_1.TriggerEvent ( "ue_ibScriptClientFocus" )  // Affectation à TRUE
		iuoGsSpSinistre.ib2EmeTourPI052 = True
		pb_Controler.Enabled = True
		pb_Controler.TriggerEvent (Clicked!)
	End If
End If

end event

type cb_debug from w_8_traitement_master`cb_debug within w_tm_sp_sinistre
end type

type dw_1 from w_8_traitement_master`dw_1 within w_tm_sp_sinistre
event ue_ouvrir_fentrv pbm_custom71
event ue_ouvrir_fensaisie pbm_custom70
event ue_ouvrir_fenvalidation pbm_custom69
event ue_ibscriptclientfocus pbm_custom68
event ue_majenabledbouton ( )
event ue_fermerword ( )
event ue_recreer_un_trv ( )
integer x = 59
integer y = 328
integer width = 302
integer height = 288
integer taborder = 360
string dataobject = "d_sp_w_sinistre"
boolean border = false
boolean livescroll = false
end type

event dw_1::ue_ouvrir_fentrv;//*-----------------------------------------------------------------
//*
//* Objet			: Dw_1
//* Evenement 		: ue_Ouvrir_FenTrv
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
//* Libellé			: Overture de la fenêtre des travaux
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: NotFound
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

s_Pass	stPass

/*----------------------------------------------------------------------------*/
/* Ouverture de la fenêtre des travaux en invisible à partir de l'objet       */
/* contact_trace.                                                             */
/*----------------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des paramètres    */
/*------------------------------------------------------------------*/
stPass.trTrans 	= itrTrans
stPass.bControl	= True		// Utilisation du bouton Contôler.
stPass.wParent		= Parent
stPass.sTab [ 1 ] = String ( This.GetItemNumber ( 1, "ID_SIN" ) )
stPass.bInsert		= True
stPass.sTab [2] 	= "WORKFLOW_EN_CONSULT_SAISIE"
stPass.sTab [3] 	= "TOUT"

SetRedraw ( False )
F_OuvreTraitement ( iW_T_Sp_Cree_Travail, stPass )
iW_T_Sp_Cree_Travail.Hide () 

iW_T_Sp_Cree_Travail.Dw_1.SetItem ( 1, "COD_TYP_RECU", "C" )
iW_T_Sp_Cree_Travail.Dw_1.SetItem ( 1, "COD_RECU", "T" )
iW_T_Sp_Cree_Travail.Dw_1.SetItem ( 1, "ID_SIN", Long ( stPass.sTab [ 1 ] ) )
iW_T_Sp_Cree_Travail.Dw_1.SetText ( stPass.sTab [ 1 ] )
iW_T_Sp_Cree_Travail.Dw_1.SetColumn ( "ID_SIN" )
iW_T_Sp_Cree_Travail.Dw_1.TriggerEvent ( "ItemChanged" )

iuoGsSpContTrace.uf_set_DteFinGti ( iW_T_Sp_Cree_Travail.Dw_1.GetItemDateTime ( 1, "DTE_FIN_GTI" ), &
												Not IsNull ( iW_T_Sp_Cree_Travail.Dw_1.GetItemNumber ( 1, "ID_PROD" ) ) )												

iW_T_Sp_Cree_Travail.Dw_1.Reset ()
iW_T_Sp_Cree_Travail.TriggerEvent ( "ue_Retour" )

SetRedraw ( True )
end event

on dw_1::ue_ouvrir_fensaisie;call w_8_traitement_master`dw_1::ue_ouvrir_fensaisie;//*-----------------------------------------------------------------
//*
//* Objet			: Dw_1
//* Evenement 		: ue_Ouvrir_FenSaisie
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
//* Libellé			: Overture de la fenêtre d'accueil dce saisie de sinistre
//* Commentaires	: 
//*				 
//* Arguments		: 
//*
//* Retourne		: NotFound
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

/*----------------------------------------------------------------------------*/
/* Ouverture de la fenêtre d'accueil de saisie de sinistre.                   */
/*----------------------------------------------------------------------------*/
SetPointer ( HourGlass! )


If IsValid ( W_a_Sp_Wkf_Saisie ) Then 
	W_a_Sp_Wkf_Saisie.Show()
Else
	OpenSheetWithParm ( W_a_Sp_Wkf_Saisie, stGLB, W_Mdi_Sp, 0, Layered! )
End If

W_a_Sp_Wkf_Saisie.BringToTop = True
W_a_Sp_Wkf_Saisie.TriggerEvent ("ue_Saisie_Automatique")

end on

event dw_1::ue_ouvrir_fenvalidation;//*-----------------------------------------------------------------
//*
//* Objet			: Dw_1
//* Evenement 		: ue_Ouvrir_FenValidation
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
//* Libellé			: Overture de la fenêtre d'accueil de validation
//* Commentaires	: 
//*				 
//* Arguments		: 
//*
//* Retourne		: NotFound
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	      Modification
//* #1 	 JFF      07/04/2006 Migration PB8-SPB-04/2006 
//* 
//*-----------------------------------------------------------------

/*----------------------------------------------------------------------------*/
/* Ouverture de la fenêtre d'accueil de saisie de sinistre.                   */
/*----------------------------------------------------------------------------*/
SetPointer ( HourGlass! )

//#1
bFenValAOuvrir = wparam = 1 

//#1
If wparam = 2 Then
	bFenValAOuvrir = False // #1
	
	If IsValid ( w_a_sp_wkf_validation ) Then 
		w_a_sp_wkf_validation.Show()
	Else
		OpenSheetWithParm ( w_a_sp_wkf_validation, stGLB, W_Mdi_Sp, 0, Layered! )
	End If
	
	w_a_sp_wkf_validation.BringToTop = True
	w_a_sp_wkf_validation.TriggerEvent ("ue_Saisie_Automatique")
End IF
end event

on dw_1::ue_ibscriptclientfocus;call w_8_traitement_master`dw_1::ue_ibscriptclientfocus;//*-----------------------------------------------------------------
//*
//* Objet         : dw_1
//* Evenement     : ue_ibScriptClientFocus
//* Auteur        : Fabry JF
//* Date          : 15/03/2004 10:58:42
//* Libellé       : Armement du ibScriptClientFocus à partir de u_gs_sp_Sinistre::uf_ControlerGestion
//*					  Utiliser pour la SVE DCMP 040020
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------


ibScriptClientFocus = TRUE


end on

event dw_1::ue_majenabledbouton();//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_1::ue_MajEnabledBouton
//* Evenement 		: Item11
//* Auteur			: FABRY JF
//* Date				: 25/06/2014
//* Libellé			: [PI052]
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

OpenWithParm ( W_Trt_Capture_Click, "" )

Yield ()

pb_controler.Enabled = False
pb_valider.Enabled = True
pb_valider.SetFocus ()

end event

event dw_1::ue_fermerword();//*-----------------------------------------------------------------
//*
//* Objet			: Dw_1
//* Evenement 		: ue_FermerWord
//* Auteur			: FABRY JF
//* Date				: 11/02/2020
//* Libellé			: Ferme Word
//* Commentaires	: 
//*				 
//* Arguments		: 
//*
//* Retourne		: NotFound
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	      Modification
//* 
//*-----------------------------------------------------------------

Long lCpt, lDelai, lDelai2

lDelai = Long ( ProfileString ( stGlb.sFichierIni, "DELAI FERMETURE WORD", "DELAI_FERM_WORD", "5000" ) )

For lCpt = 1 To lDelai
	Yield ()
Next 

RUN ( "taskkill /F  /IM WINWORD.EXE /T", minimized! )

lDelai2 = lDelai / 2

For lCpt = 1 To lDelai2
	Yield ()
Next 

RUN ( "Del " + stGLB.sRepTempo + "*.doc /Q /F", minimized! )	


end event

event dw_1::ue_recreer_un_trv();//*-----------------------------------------------------------------
//*
//* Objet			: Dw_1
//* Evenement 		: ue_ReCreer_un_trv
//* Auteur			: FABRY JF
//* Date				: 11/02/2025
//* Libellé			: [PMO268_MIG48]
//* Commentaires	: Recreer un travail POST Validation, la validation est déjà commitée ici
//*				 
//* Arguments		: 
//*
//* Retourne		: NotFound
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	      Modification
//* 
//*-----------------------------------------------------------------

String sSql, sMessContact 
Boolean bRet 

sMessContact = F_CLE_VAL ( "MESS", gsSeriaTransfert, ";" )
sMessContact = F_Remplace ( sMessContact, "'", "''" )

sSql = "Exec sysadm.PS_I_RECREER_UN_TRAVAIL " + &
			F_CLE_VAL ( "ID_SIN", gsSeriaTransfert, ";" ) + "., " + & 
			F_CLE_VAL ( "ETAT", gsSeriaTransfert, ";" ) + ", " + &
			"'" + F_CLE_VAL ( "OPER", gsSeriaTransfert, ";" ) + "', " + &
			"'" + sMessContact + "'"

gsSeriaTransfert = "" // RAZ

F_Execute ( sSql, SQLCA )
bRet = SQLCA.SqlCode = 0 And SQLCA.SqlDBCode = 0
F_Commit ( SQLCA, bRet )
end event

event dw_1::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::dw_1 (OVERRIDE)
//* Evenement 		: ItemError
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:47:59
//* Libellé			: 
//* Commentaires	: Gestion des messages d'erreur
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 08/11/2002	  La zone id_orian_boutique devient saisissable
//*								  si cod_adh <> 1 et 6 => gestion de la zone
//* #2	 CAG   10/06/2003	  Modification de la marque portable en dddw
//* #3	 CAG	 04/08/2003	  Modif du libellé du msg concernant la modif #2
//* #4	 JFF	 19/02/2006   [SITE_CMDE] Gestion des nouvelles option d'autorisation 79, 80, 81
//* #5	 PHG	 26/04/2007   [DCMP070275] Ajout de nvx motifs sans suite pour la facturation
//* #6    JFF   16/04/2008   [DCMP070914] Numération AIG
//* #7	 PHG   09/08/2008	  |DCMP080625] Désactivation Controle MArque/modèle
//*								  					obligatoire.
//* #8    JFF    15/01/2010  [O2M_DIAG_NOMADE].Lot2.JFF (suppression tag #8)
//*       JFF    08/02/2011  [PC301][VETUSTE]
//*       JFF	  15/05/2012  [ITSM115501]
//*       JFF	  27/03/2014  [DT076]
//*       JFF    07/06/2021  [RS-496] Blocage modif dte_surv, si présence pré-script avec notion de dte_surv exploitée.
//        JFF    05/08/2024  [MCO602_PNEU]
//        JFF    18/11/2024  [KSV649_ORREUCARA]
//*-----------------------------------------------------------------

Long ll_return
String sMarque, sModele
Long lVal

Choose Case Upper ( This.GetColumnName () ) 
	Case "DTE_RESIL"
		// Gestion pour l'override
		If This.GetText () = "" Then 
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetItem ( 1, "DTE_RESIL", stNul.dat )
			This.SetItem ( 1, "DTE_RESIL", stNul.dtm )
//Fin Migration PB8-WYNIWYG-03/2006 FM
			This.TriggerEvent ("ItemChanged" )
//Migration PB8-WYNIWYG-03/2006 CP
//			This.SetActionCode (3)
			ll_return = 3
//Fin Migration PB8-WYNIWYG-03/2006 CP			
			ibErreur = FALSE
		Else
			ibErreur = TRUE
		End If
		isErrCol		= Upper ( This.GetColumnName () )

	Case "MARQ_PORT", "MARQ_PORT2", "MARQ_PORT3", "NUM_IMEI_PORT", "MODL_PORT", "MODL_PORT2", "MODL_PORT3"
		If This.GetText () = "" And This.iiErreur = 0 Then 
			This.TriggerEvent ("ItemChanged" )
			ibErreur = FALSE
		Else
			ibErreur = TRUE
		End If
		isErrCol		= Upper ( This.GetColumnName () )

	Case "ID_ORIAN_BOUTIQUE"
		// [MCO602_PNEU]
		If F_CLE_A_TRUE ( "MCO602_PNEU" ) Then
			Choose Case This.iiErreur
	
				// [MCO602_PNEU]
				Case 3
					If This.GetText () = "" Then 
						lVal = dw_1.GetItemNumber ( 1, "ID_ORIAN_BOUTIQUE" ) 
						If lVal > 0 Then  
							ibErreur = TRUE
							isErrCol	= Upper ( This.GetColumnName () )							
						End If 
					Else
						// Sinon on déclenche l'ancêtre, et la suite ci-dessous
						Call super::itemerror
					End If 
			End Choose	
		End If

	Case Else
		// Sinon on déclenche l'ancêtre, et la suite ci-dessous
		Call super::itemerror
End Choose 

If	ibErreur Then

	stMessage.sTitre		= "Gestion des sinistres - SIMPA2"
	stMessage.Icon			= Information!

	stMessage.bErreurG	= TRUE

	Choose Case isErrCol

	Case "DTE_SURV_DATE"
		Choose Case This.iiErreur
		Case 0
			stMessage.sVar[1] = "date de survenance"				// Erreur de Validation - Date supérieure à date du jour
			stMessage.sCode	= "GENE002"

		Case 1
			stMessage.sVar[1] = "date de survenance"				// Erreur de saisie - Date inférieure au 01/01/1994
			stMessage.sCode	= "GENE002"

		Case 2
			stMessage.sVar[1] = "date de survenance"				// Erreur de saisie - Date de survenance > Date de déclaration
			stMessage.sVar[2] = "inférieure ou égale"
			stMessage.sVar[3] = "date de déclaration"
			stMessage.bErreurG= False
			stMessage.sCode	= "WSIN140"

		Case 3
/*------------------------------------------------------------------*/
/* La commande PS_X_CALC_REVISION vient d'échouer. La structure de  */
/* message est armée sur F_Procedure.                               */
/*------------------------------------------------------------------*/
			stMessage.sTitre		= "Gestion des sinistres - SIMPA2"
			stMessage.Icon			= StopSign!

		Case 4
			stMessage.sVar[1] = "date de survenance"				// Erreur de saisie - Date de survenance < Date d'opposition
			stMessage.sVar[2] = "inférieure"
			stMessage.sVar[3] = "date d'opposition"
			stMessage.bErreurG= False
			stMessage.sCode	= "WSIN140"

		// #6 [DCMP070914] Numération AIG
		Case 5
			stMessage.bErreurG= True
			// sVar[1] est armée sur uf_zn_dtesurv => "StMessage.sVar[1] = sMsg"
			stMessage.sCode	= n_cst_protocole_aig_param_gti.k_msg_prefixenomodif

		// [PC301][VETUSTE]
		Case 6
			stMessage.bErreurG= FALSE
			stMessage.sCode	= "WSIN700"

		//*  JFF    07/06/2021  [RS-496] Blocage modif dte_surv, si présence pré-script avec notion de dte_surv exploitée.
		Case 7
			stMessage.bErreurG= False
			stMessage.sCode	= "WSIN871"
			
		// [KSV649_ORREUCARA]			
		Case 8 
			stMessage.bErreurG= False
			stMessage.sCode	= "WSIN909"
			

		End Choose

	Case "HEU_SURV"
		stMessage.bErreurG	= False
		Choose Case This.iiErreur
		Case 1
			stMessage.sVar[1] = "l'heure de survenance"		// Erreur de saisie - Il faut saisir 4 caractères
			stMessage.sCode	= "WSIN120"

		Case 2
			stMessage.sVar[1] = "L'heure de survenance"		// Erreur de saisie - L'heure est incorrecte
			stMessage.sCode	= "WSIN130"

		Case 3
			stMessage.sVar[1] = "date de survenance"				// Erreur de saisie - Date de survenance < Date d'opposition
			stMessage.sVar[2] = "inférieure"
			stMessage.sVar[3] = "date d'opposition"
			stMessage.sCode	= "WSIN140"

		End Choose

	Case "ADR_1"
		stMessage.sVar[1] 	= "première ligne d'adresse"
		stMessage.sCode		= "GENE002"

	Case "ADR_2"
		stMessage.sVar[1] 	= "seconde ligne d'adresse"
		stMessage.sCode		= "GENE002"

	Case "ADR_CP"
		stMessage.sVar[1] 	= "code postal"
		stMessage.sCode		= "GENE003"

	Case "ADR_VILLE"
		stMessage.sVar[1] 	= "ville"
		stMessage.sCode		= "GENE002"

	Case "NUM_TELD", "NUM_TELB"
		stMessage.sVar[1] 	= "numéro de téléphone"
		stMessage.sCode		= "GENE003"

	Case "NUM_FAX"
		stMessage.sVar[1] 	= "numéro de fax"
		stMessage.sCode		= "GENE003"

	Case "DTE_ACH_PORT"
		Choose Case This.iiErreur
		Case 0
			stMessage.sVar[1] = "date d'achat du portable"		// Erreur de Validation - Date incorrecte
			stMessage.sCode	= "GENE002"
		End Choose

	Case "DTE_OUVLIG_PORT"
		Choose Case This.iiErreur
		Case 0
			stMessage.sVar[1] = "date d'ouverture de ligne"		// Erreur de Validation - Date incorrecte
			stMessage.sCode	= "GENE002"
		End Choose

	/*------------------------------------------------------------------*/
	/* #1                                                               */
	/*------------------------------------------------------------------*/
	Case "ID_ORIAN_BOUTIQUE"
		Choose Case This.iiErreur
		Case 0
			stMessage.bErreurG	= False
			stMessage.sVar[1] 	= "le code orian boutique"
			stMessage.sCode		= "WSIN360"
		Case 1
			stMessage.bErreurG	= False
			stMessage.sCode		= "WSIN400"
			stMessage.Icon			= Information!

		// [DT076]
		Case 2
			stMessage.bErreurG	= False
			stMessage.sCode		= "WSIN769"
			stMessage.Icon			= Information!

		// [MCO602_PNEU]
		Case 3
			stMessage.bErreurG	= False
			stMessage.sCode		= "WSIN902"
			stMessage.Icon			= Information!

		End Choose


	/*------------------------------------------------------------------*/
	/* #2 : CAG 10/06/2003                                              */
	/*------------------------------------------------------------------*/
	/* #3 : CAG 04/08/2003                                              */
	/*------------------------------------------------------------------*/
	Case "MARQ_PORT", "MARQ_PORT2", "MARQ_PORT3"
		Choose Case This.iiErreur
		Case 1
			stMessage.bErreurG	= False
			stMessage.sVar[1] 	= "La marque de l'appareil"
			stMessage.sCode		= "WSIN130"

		Case 2
			stMessage.bErreurG	= False
			stMessage.sCode		= "WSIN450"

		Case 3
			stMessage.bErreurG	= False
			stMessage.sCode		= "WSIN460"

		Case 4 // #7 [DCMP080625] On ne peux plus modifier la marque si Ctrl IMEI en cours, ou fait.
			stMessage.bErreurG	= False
			stMessage.sCode		= "WSIN421"
			
		Case 5 
			// [RS2980_IFR]
			stMessage.bErreurG	= False
			sMarque = Trim ( dw_1.GetItemString ( 1, "MARQ_PORT2" ))
			sModele = Trim ( dw_1.GetItemString ( 1, "MODL_PORT2" ))			
			
			stMessage.sVar[1]    = sMarque
			stMessage.sVar[2]    = sModele		
			
			If Time (Today()) < 14:00:00 Then
				stMessage.sVar[3] = "aujourd'hui"
				stMessage.sVar[4] = "15"									
			Else
				stMessage.sVar[3] = "demain"
				stMessage.sVar[4] = "10"									
			End If
			
			stMessage.sCode		= "WSIN890"			
			

		End Choose

	Case "MODL_PORT", "MODL_PORT2", "MODL_PORT3"
		Choose Case This.iiErreur
		Case 1
			stMessage.bErreurG	= False
			stMessage.sVar[1] 	= "Le modèle de l'appareil"
			stMessage.sCode		= "WSIN131"

		Case 2
			stMessage.bErreurG	= False
			stMessage.sCode		= "WSIN450"

		Case 3
			stMessage.bErreurG	= False
			stMessage.sCode		= "WSIN460"

		Case 4 // #7 [DCMP080625] On ne peux plus modifier le modele si Ctrl IMEI en cours, ou fait.
			stMessage.bErreurG	= False
			stMessage.sCode		= "WSIN421"
			
		Case 5 
			// [RS2980_IFR]
			stMessage.bErreurG	= False			
			sMarque = Trim ( dw_1.GetItemString ( 1, "MARQ_PORT2" ))
			sModele = Trim ( dw_1.GetItemString ( 1, "MODL_PORT2" ))			
			
			stMessage.sVar[1]    = sMarque
			stMessage.sVar[2]    = sModele		
			
			If Time (Today()) < 14:00:00 Then
				stMessage.sVar[3] = "aujourd'hui"
				stMessage.sVar[4] = "15"									
			Else
				stMessage.sVar[3] = "demain"
				stMessage.sVar[4] = "10"									
			End If
			
			stMessage.sCode		= "WSIN890"			

		End Choose

	Case "NUM_IMEI_PORT"
		Choose Case This.iiErreur

		Case 2
			stMessage.bErreurG	= False
			stMessage.sCode		= "WSIN450"

		Case 3
			stMessage.bErreurG	= False
			stMessage.sCode		= "SFRP081"
			
		// [KSV649_ORREUCARA]			
		Case 4 
			stMessage.bErreurG= False
			stMessage.sCode	= "WSIN909"			
		End Choose

	// #4
	Case "NUM_PORT"
		Choose Case This.iiErreur

		Case 1
			stMessage.bErreurG	= False
			stMessage.sVar[1]	   = "numéro de ligne lié au téléphone portable sinitré"
			stMessage.sCode		= "GENE003"

		End Choose
		

	Case "DTE_RESIL"
		Choose Case This.iiErreur

		Case 0
			stMessage.bErreurG	= False
			stMessage.sCode		= "WSIN130"
			stMessage.sVar[1] 	= "La date saisie"

		Case 1
			stMessage.bErreurG	= False
			stMessage.sCode		= "WSIN480"

		Case 2
			stMessage.bErreurG	= False
			stMessage.sCode		= "CTRL001"
			stMessage.sVar[1] 	= "La date d'adhesion"
			stMessage.sVar[2] 	= "La date de résiliation"

		Case 3
			stMessage.bErreurG	= False
			stMessage.sCode		= "CTRL022"
			stMessage.sVar[1] 	= "La date de résiliation"


		End Choose
	// #5 [DCMP070275]Code motif sans suite reservé à al facturation
	Case "COD_MOT_SSUI"
			Choose Case This.iiErreur
				Case 1
				stMessage.bErreurG	= False
				stMessage.sCode		= "WSIN560"
			End Choose

	// [ITSM115501]
	Case "ID_NATSIN"
			Choose Case This.iiErreur
				Case 1
				stMessage.bErreurG	= False
				stMessage.sCode		= "WSIN451"
			End Choose

	Case "ID_TERRIT"
			Choose Case This.iiErreur
				Case 1
				stMessage.bErreurG	= False
				stMessage.sCode		= "WSIN451"
			End Choose
		
	Case "ID_DETSIN"
			Choose Case This.iiErreur
				Case 1
				stMessage.bErreurG	= False
				stMessage.sCode		= "WSIN451"
			End Choose
	// [ITSM115501]

	Case "ALT_EDIT"
			Choose Case This.iiErreur
				Case 1
				stMessage.bErreurG	= False
				stMessage.sCode		= "WSIN724"
			End Choose


	End Choose

	F_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 FM
//	This.Uf_Reinitialiser ()
	ll_return = This.Uf_Reinitialiser ()
	Return ( ll_return )
//Fin Migration PB8-WYNIWYG-03/2006 FM

End If

Return AncestorReturnValue
end event

on dw_1::doubleclicked;call w_8_traitement_master`dw_1::doubleclicked;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_1::DoubleClicked
//* Evenement 		: DoubleClicked
//* Auteur			: Erick John Stark
//* Date				: 02/02/1998 21:46:41
//* Libellé			: 
//* Commentaires	: Modification du Message
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  CAG	 12/02/2003	Suite DCMP 030027 : Ajout de dw sur DET_PRO
//*-----------------------------------------------------------------

s_Pass	stPass_Dga, stFenEquFct
String	sObj, sVal, sMarque, sModele
Long		lRetGamme, lCodTel, lRow
Boolean	bRefIFR, bMarque, bModele
DataWindowChild dwChild

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 27/09/2002                               */
/*------------------------------------------------------------------*/
/* Ajout du bouton pour l'ouverture de la fenêtre des gammes        */
/*------------------------------------------------------------------*/
sObj = GetObjectAtPointer ()
sObj = Upper ( Left ( sObj, pos ( sObj, "~t" ) - 1 ) )

Choose Case sObj
	Case "POST_IT"
		stPass_Dga.sTab[1] = Parent.Title
		stPass_Dga.sTab[2] = isTypeTrt
		stPass_Dga.sTab[3] = dw_1.GetItemString ( 1, "TXT_MESS" )
		stPass_Dga.sTab[4] = "S"

		stPass_Dga.wParent	= Parent

		OpenWithParm ( iW_T_Sp_Message, stPass_Dga, stPass_Dga.wParent.ParentWindow () )

	Case "BM_GAMME", "BM_GAMME_T"
		dw_1.AcceptText ()
		lCodTel = dw_Produit.GetItemNumber ( 1, "COD_TEL" )
		If isTypeTrt = "S" And lCodTel > 0 Then

			/*------------------------------------------------------------------*/
			/* La zone 'Type_app' est-elle renseignée ?                         */
			/*------------------------------------------------------------------*/
			bRefIFR = False
			lRow = dw_w_div_sin.Find ( "NOM_ZONE = 'type_app'", 1, dw_w_div_sin.RowCount () )
			If lRow > 0 Then
				sVal = dw_w_div_sin.GetItemString ( lRow, "VAL_LST_CAR" )
				bRefIFR = iuoGsSpSinistre.uf_Determiner_Referentiel ( sVAL ) = "IFR"
			End If 

			sMarque = Upper (Trim ( dw_1.GetItemString ( 1, "MARQ_PORT" ) ))
			If IsNull ( sMarque ) Then sMarque = ""
			bMarque = sMarque <> ""

			/*------------------------------------------------------------------*/
			/* Sommes-nous en liste IFR ?                                       */
			/*------------------------------------------------------------------*/
			If bMarque Then bMarque = dw_1.Describe ( "marq_port2.visible" ) = "1"
			If bMarque Then
				dw_1.GetChild ( "MARQ_PORT2", dwChild )
				bMarque = dwChild.Find ( "MARQUE = '" + Upper ( sMarque ) + "'", 1, dwChild.RowCount () ) > 0
			End If

			sModele = dw_1.GetItemString ( 1, "MODL_PORT" )
			If IsNull ( sModele ) Then sModele = ""
			bModele = Not IsNull ( sModele ) And sModele <> ""

			If bModele Then bModele = dw_1.Describe ( "modl_port2.visible" ) = "1"
			If bModele Then
				dw_1.GetChild ( "MODL_PORT2", dwChild )
				bModele = dwChild.Find ( "REFERENCE = '" + Upper ( sModele ) + "'", 1, dwChild.RowCount () ) > 0
			End If

			If Not bRefIFR Or Not bMarque Or Not bModele Then
				stMessage.sTitre		= "Contrôle de saisie du sinistre"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= False
				stMessage.sCode 		= "WSIN440"
				f_Message ( stMessage )
			Else

				/*------------------------------------------------------------------*/
				/* Renseignement de la structure pour ouverture Fen de rech Equ     */
				/* Fct.                                                             */
				/*------------------------------------------------------------------*/
				stFenEquFct.sTab   [1] = "CS"
				stFenEquFct.sTab [2] = Upper ( sMarque )   // Marque de référence
				stFenEquFct.sTab [3] = Upper ( sModele )   // Modèle de référence
				stFenEquFct.dwNorm [1] = dw_Stk_IFR			 // Dw des données IFR
				stFenEquFct.dwNorm [2] = dw_Code_Equivalence // Dw des libellés IFR Traduit par D. Buire

				OpenWithParm ( w_Trt_Sp_Ifr_Consultation_Equiv, stFenEquFct )

			End If

		End If

End Choose
end on

event dw_1::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::dw_1
//* Evenement 		: ItemChanged
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:35:04
//* Libellé			: 
//* Commentaires	: Modification des zones
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

s_Pass	stPass_Dga

/*------------------------------------------------------------------*/
/* Si on est en Saisie, on lance le traitement des zones.           */
/*------------------------------------------------------------------*/

If	isTypeTrt = "S" Then
	ll_ret = iuoGsSpSinistre.Uf_Zn_Trt ( stPass_Dga )

	Choose Case This.isNomCol
	Case "DTE_SURV_DATE"
		Parent.Title = stPass_Dga.sTab [ 1 ]
	End Choose
End If

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on dw_1::losefocus;call w_8_traitement_master`dw_1::losefocus;// CAG 05/03/03 : les AcceptText sur le bouton controler plus celui-ci semblent s'annuler ...
//This.AcceptText ()
end on

event dw_1::sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			: Dw_1
//* Evenement 		: SqlPreview
//* Auteur			: FABRY JF
//* Date				: 13/12/2010 
//* Libellé			: Suite bug relevé par Arian Papillon, j'ajoute un "." pour 
//*					  transformer en décimal
//* Commentaires	: [DECIMAL_PAPILLON]
//*				 
//* Arguments		: 
//*
//* Retourne		: NotFound
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Choose Case Left ( sqlsyntax, 4 )

	Case "UPDA"
		sqlsyntax = F_Critere_Decimal ( sqlsyntax )
		This.SetSqlPreview ( sqlsyntax ) 

End Choose

end event

event dw_1::buttonclicked;call super::buttonclicked;//*-----------------------------------------------------------------
//*
//* Fonction		: w_tm_sp_sinistre::dw_1::buttonclicked
//* Auteur			: JFF
//* Date				: 12/05/2016 
//* Libellé			: 
//* Commentaires	:	[MOTEUR_RECH_IFR]
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

s_Pass sPass

If iuoGsSpSinistre.Uf_Zn_MarqPort ( "CONTROLE" ) = -1 Then
	stMessage.sTitre		= "Moteur de recherche IFR"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "WSIN450"
	stMessage.Bouton		= OK!
	F_Message ( stMessage )
	Return
End If

If iuoGsSpSinistre.isReferentielApp <> "IFR" Then
	
	stMessage.sTitre		= "Moteur de recherche IFR"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "GENE176"
	stMessage.Bouton		= OK!
	F_Message ( stMessage )
	
	Return
End If

dw_1.SetColumn ( "MODL_PORT" )
dw_1.SetFocus ()

OpenWithParm ( W_T_Rech_Ifr, sPass ) 

sPass = Message.PowerObjectParm

If sPass.sTab[1] = "RETOUR" Then Return

dw_1.SetItem ( 1, "MARQ_PORT", sPass.sTab[2] )
dw_1.SetText ( sPass.sTab[2] )
iuoGsSpSinistre.Uf_Zn_MarqPort ( "NORMAL" )
dw_1.SetItem ( 1, "MODL_PORT", sPass.sTab[3] )
dw_1.SetText ( sPass.sTab[3] )
iuoGsSpSinistre.Uf_Zn_ModlPort ( )
dw_1.SetColumn ( "ALT_BLOC" )
dw_1.SetFocus ()



end event

type st_titre from w_8_traitement_master`st_titre within w_tm_sp_sinistre
boolean visible = false
integer x = 2958
integer y = 312
integer width = 585
integer height = 80
long textcolor = 0
string text = "                                                                      Génération des courriers en cours, veuillez patienter..."
end type

type pb_retour from w_8_traitement_master`pb_retour within w_tm_sp_sinistre
integer x = 9
integer y = 8
integer width = 242
integer height = 144
integer taborder = 470
end type

event pb_retour::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::Pb_Retour::Clicked (OVERRIDE)
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 05/12/1997 16:45:25
//* Libellé			: 
//* Commentaires	: Positionnement du code action
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean bRet
bRet = True
/*------------------------------------------------------------------*/
/* Le 15/12/1998:                                                   */
/* Le gestionnaire va voir s'afficher un message de confirmation    */
/* pour l'abandon de la saisie.                                     */
/*------------------------------------------------------------------*/
If	isTypeTrt = "S"	Then
	stMessage.sTitre			= "Confirmation de l'abandon de la saisie"
	stMessage.Bouton			= OkCancel!
	stMessage.Icon				= Question!
	stMessage.bErreurG		= FALSE
	stMessage.sVar[1]			= "du dossier " + String ( dw_1.GetItemNumber ( 1, "ID_SIN" ) )
	stMessage.sCode			= "CONF002"
	stMessage.iDefautBouton	= 2

	If	F_Message ( stMessage )	<> 1	Then
		bRet = False
	End If
End If

If	bRet Then
	isCodAction = "2"
	Parent.TriggerEvent ( "Ue_Retour", 1, 1 )
End If

// [PM72]
glIdSinMemPM72 = 0

end event

type pb_valider from w_8_traitement_master`pb_valider within w_tm_sp_sinistre
integer x = 494
integer y = 8
integer width = 242
integer height = 144
integer taborder = 490
end type

on pb_valider::clicked;call w_8_traitement_master`pb_valider::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::pb_valider::Clicked
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 05/12/1997 17:25:29
//* Libellé			: 
//* Commentaires	: Positionnement du code action sur CTRL_VALIDER
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Le positionnement du code action doit être effectué sur le       */
/* contrôle de gestion en fonction du nombre de courrier à envoyer. */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Pour le moment, je positionne isCodAction à 1.                   */
/*------------------------------------------------------------------*/

isCodAction = "1"
end on

type pb_imprimer from w_8_traitement_master`pb_imprimer within w_tm_sp_sinistre
boolean visible = false
integer x = 978
integer y = 8
integer width = 242
integer height = 144
integer taborder = 0
end type

type pb_controler from w_8_traitement_master`pb_controler within w_tm_sp_sinistre
integer x = 251
integer y = 8
integer width = 242
integer height = 144
integer taborder = 480
end type

on pb_controler::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::pb_controler (OVERRIDE)
//* Evenement 		: 
//* Auteur			: Erick John Stark
//* Date				: 05/02/1998 15:50:39
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On déclenche un ItemFocusChanged avant toute chose. Cela         */
/* concerne les zones COD_CIV, ID_ETS.                              */
/*------------------------------------------------------------------*/
dw_1.TriggerEvent ( ItemFocusChanged! )

Call u_pbControler::Clicked

end on

type pb_supprimer from w_8_traitement_master`pb_supprimer within w_tm_sp_sinistre
integer x = 736
integer y = 8
integer width = 242
integer height = 144
integer taborder = 500
end type

type pb_routage from u_8_pbroutage within w_tm_sp_sinistre
integer x = 978
integer y = 8
integer width = 233
integer height = 136
integer taborder = 510
boolean originalsize = false
end type

type uo_ong from u_onglets within w_tm_sp_sinistre
integer x = 9
integer y = 156
integer width = 2432
integer height = 108
integer taborder = 460
boolean border = false
end type

type dw_produit from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 2304
integer y = 1544
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_produit"
end type

type p_focus from picture within w_tm_sp_sinistre
boolean visible = false
integer x = 3168
integer y = 140
integer width = 91
integer height = 76
boolean bringtotop = true
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\focus_1.bmp"
boolean focusrectangle = false
end type

type dw_codegarantie from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 3301
integer y = 196
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_code_garantie"
end type

type dw_paraprod from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 3031
integer y = 404
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_para_prod"
end type

type dw_wparainfo from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 3301
integer y = 400
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_lst_sin_w_inter_para_affecte"
end type

event sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::dw_wParaInfo::SqlPreview
//* Evenement 		: SqlPreview
//* Auteur			: Erick John Stark
//* Date				: 28/11/1997 15:34:57
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ  PAR		Date		Modification
//*       JFF   13/12/2010   [DECIMAL_PAPILLON]
//* 
//*-----------------------------------------------------------------

String	sSqlPreview, sMajPar, sIdPara

Long dcIdSin, dcIdi, dcCptTri, lLig

Long ll_return

DateTime dtCreeLe, dtMajLe

dwBuffer		dwBuf

//Migration PB8-WYNIWYG-03/2006 CP
//sSqlPreview = This.GetSqlPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 CP


/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion ou d'une  */
/* Suppression                                                      */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
// This.GetUpdateStatus ( lLig, dwBuf )
lLig  = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 CP

Choose Case Left ( sSqlPreview, 4 )
Case	"INSE"

	dcIdSin		= This.GetItemNumber ( lLig,	"ID_SIN"					)
	dcIdI			= This.GetItemNumber ( lLig,	"ID_I"					)
	sIdPara		= This.GetItemString ( lLig,	"ID_PARA"				)
	dcCptTri		= This.GetItemNumber	( lLig,	"CPT_TRI"				)

	sMajPar		= stGLB.sCodOper
	dtMajLe		= dw_1.GetItemDateTime ( 1, "MAJ_LE" 					)
	dtCreeLe		= dtMajLe

	itrTrans.DW_I01_W_PARA_INFO (	dcIdSin,				&
											dcIdI,				&
											sIdPara,				&
											dcCptTri,			&
											dtCreeLe,			&
											dtMajLe,				&
											sMajPar		)

										

	If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		

	Else

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 2 )
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		

	End If

Case	"DELE"

	dcIdSin		= This.GetItemNumber ( lLig,	"ID_SIN",	DELETE!, False		)
	dcIdI			= This.GetItemNumber ( lLig,	"ID_I", 		DELETE!, False 	)

	itrTrans.DW_D01_W_PARA_INFO ( dcIdSin, dcIdI )

	If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	Else

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 2 )
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		


	End If

Case "UPDA"

	sqlsyntax = F_Critere_Decimal ( sqlsyntax )

	// Variante pour ce cas, l'id_para est une string donc je retire le point de fin
	sqlsyntax = Left ( Trim ( sqlsyntax), Len ( Trim (sqlsyntax )) - 1 ) + " "
	This.SetSqlPreview ( sqlsyntax ) 

End Choose

//Migration PB8-WYNIWYG-03/2006 CP
//
		Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP		

end event

type dw_piece from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 2002
integer y = 1544
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_piece"
end type

type dw_motif from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 1705
integer y = 1548
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_motif"
end type

type dw_delai from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 1408
integer y = 1544
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_delai"
end type

type dw_franchise from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 1111
integer y = 1544
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_franchise"
end type

type dw_plafond from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 814
integer y = 1544
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_plafond"
end type

type dw_garantie from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 517
integer y = 1544
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_garantie"
end type

type dw_condition from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 219
integer y = 1544
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_condition"
end type

type dw_wdetail from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 3301
integer y = 520
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_w_detail"
end type

event sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::dw_wDetail::SqlPreview
//* Evenement 		: SqlPreview
//* Auteur			: Erick John Stark
//* Date				: 28/11/1997 15:34:57
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1	JFF	12/10/2007	On remplace le DeleteRow par un RowsDiscard, le delete du detail
//*								se chargeant du delete du div_det. Ainsi on évite le plante "No change Made to db"
//*      JFF   13/12/2010  [DECIMAL_PAPILLON]
//*-----------------------------------------------------------------

String	sSqlPreview

Long lLig, LTot, lCpt

//Migration PB8-WYNIWYG-03/2006 CP
Long ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP

Long dcIdSin, dcIdGti, dcIdDetail, dcIdEvt, dcIdiReg, dcCptValide
Long dcCodDecMac, dcCodDecOpe, dcCodEtat, dcCodMotSsui, dcIdCarte

DateTime	dDteDet, dtCreeLe, dtMajLe
DateTime dtDteCmd, dtDteLivr

Decimal {2} dcMtPrej, dcMtFran, dcMtnPlaf, dcMtPlaf, dcMtValAchat, dcMtValPublique

String sHeuDet, sNumCarte, sLibDet, sAltBloc, sAltCour, sAltPlaf, sAltReg, sAltAtt, sAltSsui, sAltValide, sIdTypeCarte, sMajPar
String sNumFacture

dwBuffer		dwBuf

//Migration PB8-WYNIWYG-03/2006 CP
//sSqlPreview = This.GetSqlPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 CP

/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion ou d'une  */
/* Suppression                                                      */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//This.GetUpdateStatus ( lLig, dwBuf )
lLig  = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 CP

Choose Case Left ( sSqlPreview, 4 )
Case	"INSE"

	dcIdSin			= This.GetItemNumber ( lLig,	"ID_SIN"					)
	dcIdGti			= This.GetItemNumber ( lLig,	"ID_GTI"					)
	dcIdDetail		= This.GetItemNumber ( lLig,	"ID_DETAIL"				)
	dcIdEvt			= This.GetItemNumber ( lLig,	"ID_EVT"					)

	sLibDet			= F_GetString ( dw_wDetail, lLig,	"LIB_DET" 		)

	dDteDet			= This.GetItemDateTime	( lLig,	"DTE_DET"	)
	sHeuDet			= F_GetString ( dw_wDetail, lLig, "HEU_DET" )

	sNumCarte		= F_GetString ( dw_wDetail, lLig, "NUM_CARTE" ) 

	dcMtPrej			= This.GetItemNumber ( lLig,	"MT_PREJ"				)
	dcMtFran			= This.GetItemNumber ( lLig,	"MT_FRAN"				)
	dcMtnPlaf		= This.GetItemNumber ( lLig,	"MT_NPLAF"				)
	dcMtPlaf			= This.GetItemNumber ( lLig,	"MT_PLAF"				)

	dcIdiReg			= This.GetItemNumber ( lLig,	"ID_I_REG"				)

	sAltBloc			= This.GetItemString ( lLig,	"ALT_BLOC"				)
	sAltCour			= This.GetItemString ( lLig,	"ALT_COUR"				)
	sAltPlaf			= This.GetItemString ( lLig,	"ALT_PLAF"				)
	sAltReg			= This.GetItemString ( lLig,	"ALT_REG"				)
	sAltAtt			= This.GetItemString ( lLig,	"ALT_ATT"				)
	sAltValide		= This.GetItemString ( lLig,	"ALT_VALIDE"			)
	dcCptValide		= This.GetItemNumber ( lLig,	"CPT_VALIDE"			)

	sAltSsui			= This.GetItemString ( lLig,	"ALT_SSUI"				)
	dcCodMotSsui	= This.GetItemNumber ( lLig,	"COD_MOT_SSUI"			)

	dcCodDecMac		= This.GetItemNumber ( lLig,	"COD_DEC_MAC"			)
	dcCodDecOpe		= This.GetItemNumber ( lLig,	"COD_DEC_OPE"			)
	dcCodEtat		= This.GetItemNumber ( lLig,	"COD_ETAT"				)

	dcIdCarte		= This.GetItemNumber ( lLig,	"ID_CARTE"				)
	sIdTypeCarte	= F_GetString ( dw_wDetail, lLig, "ID_TYPE_CARTE"	)

	sMajPar			= stGLB.sCodOper
	dtMajLe			= dw_1.GetItemDateTime ( 1, "MAJ_LE" 					)
	dtCreeLe			= This.GetItemDateTime ( lLig,	"CREE_LE"			)

	dtDteCmd			= DateTime ( This.GetItemDate ( lLig,	"DTE_CMD"), 00:00:00 )
	//dtDteLivr		= DateTime ( This.GetItemDate ( lLig,	"DTE_LIVR"), 00:00:00 )
	dtDteLivr		= This.GetItemDateTime ( lLig,	"DTE_LIVR") // [PI056]
	
	dcMtValAchat	= This.GetItemDecimal ( lLig,	"MT_VAL_ACHAT"	)
	dcMtValPublique= This.GetItemDecimal ( lLig,	"MT_VAL_PUBLIQUE"	)
	sNumFacture		= This.GetItemString   ( lLig,	"NUM_FACTURE"	)
	
// [MIGPB11] [EMD] : passage des arguments datetime (dont la partie time n'est pas initialisée) en string
/*	
	itrTrans.DW_I01_W_DETAIL (	dcIdSin,				&
										dcIdGti,				&
										dcIdDetail,			&
										dcIdEvt,				&
										sLibDet,				&
										dDteDet,				&
										sHeuDet,				&
										sNumCarte,			&
										dcMtPrej,			&
										dcMtFran,			&
										dcMtnPlaf,			&
										dcMtPlaf,			&
										dcIdiReg,			&
										sAltBloc,			&
										sAltCour,			&
										sAltPlaf,			&
										sAltReg,				&
										sAltAtt,				&
										sAltValide,			&
										dcCptValide,		&
										sAltSsui,			&
										dcCodMotSsui,		&
										dcCodDecMac,		&
										dcCodDecOpe,		&
										dcCodEtat,			&
										dcIdCarte,			&
										sIdTypeCarte,		&
										dtCreeLe,			&		
										dtMajLe,				&
										sMajPar,				&
										dtDteCmd,			&
										dtDteLivr,			&
										dcMtValAchat, 	   &
										dcMtValPublique,  &
										sNumFacture			)										
*/
	itrTrans.DW_I01_W_DETAIL (	dcIdSin,				&
										dcIdGti,					&
										dcIdDetail,				&
										dcIdEvt,					&
										sLibDet,					&
										String( dDteDet ),		&
										sHeuDet,					&
										sNumCarte,				&
										dcMtPrej,				&
										dcMtFran,				&
										dcMtnPlaf,				&
										dcMtPlaf,					&
										dcIdiReg,					&
										sAltBloc,					&
										sAltCour,					&
										sAltPlaf,					&
										sAltReg,					&
										sAltAtt,					&
										sAltValide,				&
										dcCptValide,				&
										sAltSsui,					&
										dcCodMotSsui,			&
										dcCodDecMac,			&
										dcCodDecOpe,			&
										dcCodEtat,				&
										dcIdCarte,				&
										sIdTypeCarte,			&
										dtCreeLe,				&
										dtMajLe,					&
										sMajPar,					&
										String( dtDteCmd ),	&
										String( dtDteLivr ),		&
										dcMtValAchat, 	   		&
										dcMtValPublique,  		&
										sNumFacture			)
// [MIGPB11] [EMD] : Fin

	If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	Else

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 2 )
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	End If

Case	"DELE"

	dcIdSin		= This.GetItemNumber ( lLig,	"ID_SIN",		DELETE!, False		)
	dcIdGti		= This.GetItemNumber ( lLig,	"ID_GTI",		DELETE!, False		)
	dcIdDetail	= This.GetItemNumber ( lLig,	"ID_DETAIL",	DELETE!, False		)

	// #1
	lTot = dw_w_div_det.Deletedcount ()
	For lCpt = lTot To 1 Step -1
		If dw_w_div_det.GetItemNumber ( lCpt,	"ID_GTI", DELETE!, False ) = dcIdGti And &
			dw_w_div_det.GetItemNumber ( lCpt,	"ID_DETAIL", DELETE!, False ) = dcIdDetail then
			dw_w_div_det.RowsDiscard ( lCpt, lCpt, DELETE! ) 
		End If
	Next

	lTot = dw_w_Commande.Deletedcount ()
	For lCpt = lTot To 1 Step -1
		If dw_w_Commande.GetItemNumber ( lCpt,	"ID_GTI", DELETE!, False ) = dcIdGti And &
			dw_w_Commande.GetItemNumber ( lCpt,	"ID_DETAIL", DELETE!, False ) = dcIdDetail then
			dw_w_Commande.RowsDiscard ( lCpt, lCpt, DELETE! ) 
		End If
	Next
	// :#1
	
	itrTrans.DW_D01_W_DETAIL ( dcIdSin, dcIdGti, dcIdDetail )

	If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		

	Else

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 2 )
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		

	End If

Case "UPDA"
	// [DECIMAL_PAPILLON]
	sqlsyntax = F_Critere_Decimal ( sqlsyntax )
	This.SetSqlPreview ( sqlsyntax ) 

End Choose

//Migration PB8-WYNIWYG-03/2006 CP
//
		Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP		

end event

type dw_wpiece from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 3301
integer y = 640
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_w_piece"
end type

event sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::dw_wPiece::SqlPreview
//* Evenement 		: SqlPreview
//* Auteur			: Erick John Stark
//* Date				: 28/11/1997 15:34:57
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*      JFF   13/12/2010  [DECIMAL_PAPILLON]
//*-----------------------------------------------------------------

String	sSqlPreview, sMajPar, sIdPara

Long dcIdSin, dcIdGti, dcIdDetail, dcIdPce, dcIdi, dcCptTri, lLig

//Migration PB8-WYNIWYG-03/2006 CP
Long ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP

DateTime dtCreeLe, dtMajLe

dwBuffer		dwBuf

//Migration PB8-WYNIWYG-03/2006 CP
//sSqlPreview = This.GetSqlPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 CP


/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion ou d'une  */
/* Suppression                                                      */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//This.GetUpdateStatus ( lLig, dwBuf )
lLig  = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 CP

Choose Case Left ( sSqlPreview, 4 )
Case	"INSE"

	dcIdSin		= This.GetItemNumber ( lLig,	"ID_SIN"					)
	dcIdGti		= This.GetItemNumber ( lLig,	"ID_GTI"					)
	dcIdDetail	= This.GetItemNumber ( lLig,	"ID_DETAIL"				)
	dcIdPce		= This.GetItemNumber ( lLig,	"ID_PCE"					)
	dcIdI			= This.GetItemNumber ( lLig,	"ID_I"					)
	sIdPara		= This.GetItemString ( lLig,	"ID_PARA"				)
	dcCptTri		= This.GetItemNumber ( lLig,	"CPT_TRI"				)

	sMajPar		= stGLB.sCodOper
	dtMajLe		= dw_1.GetItemDateTime ( 1, "MAJ_LE" 					)
	dtCreeLe		= dtMajLe

	itrTrans.DW_I01_W_PIECE		 (	dcIdSin,				&
											dcIdGti,				&
											dcIdDetail,			&
											dcIdPce,				&
											dcIdI,				&
											sIdPara,				&
											dcCptTri,			&
											dtCreeLe,			&
											dtMajLe,				&
											sMajPar		)

										

	If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	Else

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 2 )
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	End If

Case	"DELE"

	dcIdSin		= This.GetItemNumber ( lLig,	"ID_SIN",		DELETE!, False		)
	dcIdGti		= This.GetItemNumber ( lLig,	"ID_GTI", 		DELETE!, False		)
	dcIdDetail	= This.GetItemNumber ( lLig,	"ID_DETAIL",	DELETE!, False		)

	itrTrans.DW_D01_W_PIECE ( dcIdSin, dcIdGti, dcIdDetail )

	If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	Else
		
//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 2 )
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	End If

Case "UPDA"
	// [DECIMAL_PAPILLON]
	sqlsyntax = F_Critere_Decimal ( sqlsyntax )
	This.SetSqlPreview ( sqlsyntax ) 

End Choose

//Migration PB8-WYNIWYG-03/2006 CP
//
		Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP		

end event

type dw_wrefus from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 3301
integer y = 760
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_w_refus"
end type

event sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::dw_wRefus::SqlPreview
//* Evenement 		: SqlPreview
//* Auteur			: Erick John Stark
//* Date				: 28/11/1997 15:34:57
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*     JFF   13/12/2010  [DECIMAL_PAPILLON]
//*-----------------------------------------------------------------

String	sSqlPreview, sMajPar, sIdPara, sAltMac, sAltOpe

Long dcIdSin, dcIdGti, dcIdDetail, dcIdMotif, dcIdi, dcCptTri, lLig

//Migration PB8-WYNIWYG-03/2006 CP
Long ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP

DateTime dtCreeLe, dtMajLe

dwBuffer		dwBuf


//Migration PB8-WYNIWYG-03/2006 CP
//sSqlPreview = This.GetSqlPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 CP


/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion ou d'une  */
/* Suppression                                                      */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//This.GetUpdateStatus ( lLig, dwBuf )
lLig  = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 CP


Choose Case Left ( sSqlPreview, 4 )
Case	"INSE"

	dcIdSin		= This.GetItemNumber ( lLig,	"ID_SIN"					)
	dcIdGti		= This.GetItemNumber ( lLig,	"ID_GTI"					)
	dcIdDetail	= This.GetItemNumber ( lLig,	"ID_DETAIL"				)
	dcIdMotif	= This.GetItemNumber ( lLig,	"ID_MOTIF"				)
	sAltMac		= This.GetItemString ( lLig,	"ALT_MAC"				)
	sAltOpe		= This.GetItemString ( lLig,	"ALT_OPE"				)
	dcIdI			= This.GetItemNumber ( lLig,	"ID_I"					)
	sIdPara		= This.GetItemString ( lLig,	"ID_PARA"				)
	dcCptTri		= This.GetItemNumber ( lLig,	"CPT_TRI"				)

	sMajPar		= stGLB.sCodOper
	dtMajLe		= dw_1.GetItemDateTime ( 1, "MAJ_LE" 					)
	dtCreeLe		= dtMajLe

	itrTrans.DW_I01_W_REFUS		 (	dcIdSin,				&
											dcIdGti,				&
											dcIdDetail,			&
											dcIdMotif,			&
											sAltMac,				&
											sAltOpe,				&
											dcIdI,				&
											sIdPara,				&
											dcCptTri,			&
											dtCreeLe,			&
											dtMajLe,				&
											sMajPar		)

										

	If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	Else

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 2 )
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	End If

Case	"DELE"

	dcIdSin		= This.GetItemNumber ( lLig,	"ID_SIN",		DELETE!, False		)
	dcIdGti		= This.GetItemNumber ( lLig,	"ID_GTI", 		DELETE!, False		)
	dcIdDetail	= This.GetItemNumber ( lLig,	"ID_DETAIL",	DELETE!, False		)

	itrTrans.DW_D01_W_REFUS ( dcIdSin, dcIdGti, dcIdDetail )

	If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	Else
//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 2 )
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	End If

Case "UPDA"
	// [DECIMAL_PAPILLON]
	sqlsyntax = F_Critere_Decimal ( sqlsyntax )
	This.SetSqlPreview ( sqlsyntax ) 
	
End Choose

//Migration PB8-WYNIWYG-03/2006 CP
//
		Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP		

end event

type dw_codecondition from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 2597
integer y = 1544
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "dddw_sp_sin_code_condition"
end type

type dw_wfrais from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 3301
integer y = 880
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_w_frais"
end type

event sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::dw_wFrais::SqlPreview
//* Evenement 		: SqlPreview
//* Auteur			: Erick John Stark
//* Date				: 28/11/1997 15:34:57
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*      JFF   13/12/2010  [DECIMAL_PAPILLON]
//*-----------------------------------------------------------------

String	sSqlPreview, sMajPar, sLibFrais, sAltCour

Long dcIdSin, dcIdI, dcIdFrais, dcIdTypFrais, lLig
Long lCodEtat

//Migration PB8-WYNIWYG-03/2006 CP
Long ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP

Decimal {2} dcMtFrais

DateTime dtCreeLe, dtMajLe

dwBuffer		dwBuf

//Migration PB8-WYNIWYG-03/2006 CP
//sSqlPreview = This.GetSqlPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 CP

/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion ou d'une  */
/* Suppression                                                      */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//This.GetUpdateStatus ( lLig, dwBuf )
lLig  = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 CP

Choose Case Left ( sSqlPreview, 4 )
Case	"INSE"

	dcIdSin			= This.GetItemNumber ( lLig,	"ID_SIN"					)
	dcIdI				= This.GetItemNumber ( lLig,	"ID_I"					)
	dcIdFrais		= This.GetItemNumber ( lLig,	"ID_FRAIS"				)
	dcIdTypFrais	= This.GetItemNumber ( lLig,	"ID_TYP_FRAIS"			)
	sLibFrais		= F_GetString ( dw_wFrais, lLig, "LIB_FRAIS" )
	sAltCour			= This.GetItemString ( lLig,	"ALT_COUR"				)
	dcMtFrais		= This.GetItemNumber ( lLig,	"MT_FRAIS"				)
	lCodEtat			= This.GetItemNumber ( lLig,	"COD_ETAT"				)

	sMajPar		= stGLB.sCodOper
	dtMajLe		= dw_1.GetItemDateTime ( 1, "MAJ_LE" 					)
	dtCreeLe		= dtMajLe

	itrTrans.DW_I01_W_FRAIS		 (	dcIdSin,				&
											dcIdI,				&
											dcIdFrais,			&
											dcIdTypFrais,		&
											sLibFrais,			&
											sAltCour,			&
											dcMtFrais,			&
											lCodEtat,			&
											dtCreeLe,			&
											dtMajLe,				&
											sMajPar		)

										

	If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	Else

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 2 )
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	End If

Case	"DELE"

	dcIdSin		= This.GetItemNumber ( lLig,	"ID_SIN",		DELETE!, False		)
	dcIdI			= This.GetItemNumber ( lLig,	"ID_I", 			DELETE!, False		)
	dcIdFrais	= This.GetItemNumber ( lLig,	"ID_FRAIS",		DELETE!, False		)

	itrTrans.DW_D01_W_FRAIS ( dcIdSin, dcIdI, dcIdFrais )

	If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	Else

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 2 )
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	End If

// [DECIMAL_PAPILLON]
Case "UPDA" // Update
	sqlsyntax = F_Critere_Decimal ( sqlsyntax )
	This.SetSqlPreview ( sqlsyntax ) 

End Choose

//Migration PB8-WYNIWYG-03/2006 CP
//
		Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP		

end event

type dw_wcourrier from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 3291
integer y = 1000
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_w_courrier"
end type

event sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::dw_wCourrier::SqlPreview
//* Evenement 		: SqlPreview
//* Auteur			: Erick John Stark
//* Date				: 28/11/1997 15:34:57
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR	Date			Modification
//*
//* #1	PHG	06/11/2006	[DNTMAIL1-2] Ajout de l'id_canal
//*      JFF   13/12/2010  [DECIMAL_PAPILLON]
//       JFF   26/04/2023  [RS5045_REF_MATP]
//*-----------------------------------------------------------------

String	sSqlPreview, sMajPar, sIdCour, sAltPart, sAltPce, sAltPs, sTxtCompo1, sTxtCompo2, sIdCourOrig	
String	sIdCanal, sModeleWord
DateTime dtCreeLe, dtMajLe

Long dcIdSin, dcIdI, dcIdCpt, dcIdIDb, lLig

//Migration PB8-WYNIWYG-03/2006 CP
Long ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP

dwBuffer		dwBuf

//Migration PB8-WYNIWYG-03/2006 CP
//sSqlPreview = This.GetSqlPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 CP

/*------------------------------------------------------------------*/

/* Au niveau du SqlPreview, on ne doit avoir que des insertions.    */
/* Les données insérées proviennent de la foncion                   */
/* Uf_Determiner_Composition de U_Gs_Sp_Sinistre. On envoie le      */
/* DELETE de tous les courriers existant sur Uf_Terminer_Valider de */
/* U_Gs_Sp_Sinistre.                                                */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//This.GetUpdateStatus ( lLig, dwBuf )
lLig  = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 CP

Choose Case Left ( sSqlPreview, 4 )
Case	"INSE"

	dcIdSin			= This.GetItemNumber ( lLig,	"ID_SIN"					)
	dcIdI				= This.GetItemNumber ( lLig,	"ID_I"					)
	dcIdCpt			= This.GetItemNumber ( lLig,	"ID_CPT"					)
	sIdCour			= This.GetItemString ( lLig,	"ID_COUR"				)
	sAltPart			= This.GetItemString ( lLig,	"ALT_PART"				)
	sAltPce			= This.GetItemString ( lLig,	"ALT_PCE"				)
	sAltPs			= This.GetItemString ( lLig,	"ALT_PS"					)
	sTxtCompo1		= F_GetString ( dw_wCourrier, lLig,	"TXT_COMPO1"	)
	sTxtCompo2		= F_GetString ( dw_wCourrier, lLig,	"TXT_COMPO2"	)
	sIdCourOrig		= This.GetItemString ( lLig,	"ID_COUR_ORIG"			)
	sIdCanal			= this.object.id_canal[lLig] // #1 [DNTMAIL1-2]
	dcIdIDb			= This.GetItemNumber ( lLig,	"ID_I_DB"				)
	sModeleWord    = This.GetItemString ( lLig, "MODELE_WORD" ) // [RS5045_REF_MATP]

	sMajPar		= stGLB.sCodOper
	dtMajLe		= dw_1.GetItemDateTime ( 1, "MAJ_LE" 					)
	dtCreeLe		= dtMajLe

	itrTrans.DW_I01_W_COURRIER	 (	dcIdSin,				&
											dcIdI,				&
											dcIdCpt,				&
											sIdCour,				&
											sAltPart,			&
											sAltPce,				&
											sAltPs,				&
											sTxtCompo1,			&
											sTxtCompo2,			&
											dcIdIDb,				&
											dtCreeLe,			&
											dtMajLe,				&
											sMajPar,				&
											sIdCourOrig,		&
											sIdCanal, 			&
											sModeleWord		   &
							)
										

	If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	Else

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 2 )
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	End If

// [DECIMAL_PAPILLON]
Case "UPDA" // Update
	sqlsyntax = F_Critere_Decimal ( sqlsyntax )
	This.SetSqlPreview ( sqlsyntax ) 
	
End Choose

//Migration PB8-WYNIWYG-03/2006 CP
//
Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP		

end event

type uo_libelle from u_libelle_dga within w_tm_sp_sinistre
boolean visible = false
integer x = 3305
integer y = 1368
integer width = 242
integer height = 100
boolean enabled = false
end type

on uo_libelle.destroy
call u_libelle_dga::destroy
end on

type dw_police from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 2889
integer y = 1544
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_police"
end type

type uo_3d from u_bord3d within w_tm_sp_sinistre
integer x = 2624
integer y = 60
integer width = 320
integer height = 120
end type

on constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_3d::Constructor (OVERRIDE)
//* Evenement 		: Constructor
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 14:57:30
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne le Bord en 3D, puis on appelle la construction     */
/* normale.                                                         */
/*------------------------------------------------------------------*/

This.X			=   19
This.Y			=  253
This.Width		= 3520
This.Height		= 1420

Call U_Bord3D::Constructor
end on

on uo_3d.destroy
call u_bord3d::destroy
end on

type dw_lst_inter from u_datawindow_detail within w_tm_sp_sinistre
integer x = 466
integer y = 328
integer width = 302
integer height = 288
integer taborder = 440
string dataobject = "d_sp_sin_lst_inter"
boolean vscrollbar = true
boolean border = false
boolean livescroll = false
end type

event sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::dw_Lst_Inter::SqlPreview
//* Evenement 		: SqlPreview
//* Auteur			: Erick John Stark
//* Date				: 28/11/1997 15:34:57
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  CAG	05/08/2003  Ajout de la zone Ordre_cheque
//* #2  JFF 16/03/2004	DCMP 040020 SVE
//* #3	JCA	23/05/2006	DntMail
//* #4	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
//*      JFF   13/12/2010  [DECIMAL_PAPILLON]
//       JFF   30/05/2023 [PMO89_RS4822]
//*-----------------------------------------------------------------

String	sSqlPreview
String	sSVE

Long lLig

//Migration PB8-WYNIWYG-03/2006 CP
Long ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP

Long dcIdSin, dcIdi, dcCptValide, dcIdIDb
Decimal {2} dcMtReg, dcMtaReg
Integer iCptCour, iCodEtatCtrleInter

String sCodInter, sCodCiv, sNom, sAdr1, sAdr2, sAdrCp, sAdrVille, sAdrAtt, sNumTeld, sNumTelb, sNumFax
String sCodModeReg, sRibBq, sRibGui, sRibCpt, sRibCle, sVref1, sVref2, sCodAg, sCodBq
String sAltPart, sAltPs, sAltPce, sAltQuest, sIdCour, sIdNatCour, sAltCourGest, sIdCourj, sAltValide
String sMajPar, sOrdreCheque, sNumLetCheque, sIdFour, sAltSuiviSms, sNumPortSms
// #3
String sAltSuiviMail, sAdrMail, sVilleNaiss, sPaysNaiss
// #3 FIN

DateTime dtCreeLe, dtMajLe, dtDteNaiss

dwBuffer		dwBuf

//Migration PB8-WYNIWYG-03/2006 CP
//sSqlPreview = This.GetSqlPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 CP

/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion ou d'une  */
/* Suppression                                                      */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//This.GetUpdateStatus ( lLig, dwBuf )
lLig  = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 CP

Choose Case Left ( sSqlPreview, 4 )
Case	"INSE"

	dcIdSin		= This.GetItemNumber ( lLig,	"ID_SIN"					)
	dcIdI			= This.GetItemNumber ( lLig,	"ID_I"					)
	sCodInter	= This.GetItemString ( lLig,	"COD_INTER"				)
	sCodCiv		= This.GetItemString ( lLig,	"COD_CIV"				)
	sNom			= Trim ( This.GetItemString ( lLig,	"NOM"						) )
	sAdr1			= Trim ( This.GetItemString ( lLig,	"ADR_1"					) )
	sAdr2			= F_GetString ( dw_Lst_Inter, lLig,	"ADR_2"			)
	sAdrCp		= This.GetItemString ( lLig,	"ADR_CP"					)
	sAdrVille	= Trim ( This.GetItemString ( lLig,	"ADR_VILLE"				) )
	sAdrAtt		= Trim ( F_GetString ( dw_Lst_Inter, lLig,	"ADR_ATT"		) )
	sNumTeld		= F_GetString ( dw_Lst_Inter, lLig,	"NUM_TELD"		)
	sNumTelb		= F_GetString ( dw_Lst_Inter, lLig,	"NUM_TELB"		)
	sNumFax		= F_GetString ( dw_Lst_Inter, lLig,	"NUM_FAX"		)
	sCodModeReg	= F_GetString ( dw_Lst_Inter, lLig,	"COD_MODE_REG"	)
	sRibBq		= F_GetString ( dw_Lst_Inter, lLig,	"RIB_BQ"			)
	sRibGui		= F_GetString ( dw_Lst_Inter, lLig,	"RIB_GUI"		)
	sRibCpt		= F_GetString ( dw_Lst_Inter, lLig,	"RIB_CPT"		)
	sRibCle		= F_GetString ( dw_Lst_Inter, lLig,	"RIB_CLE"		)
/*------------------------------------------------------------------*/
/* #1 CAG : 05/08/2003                                              */
/*------------------------------------------------------------------*/
	sOrdreCheque  = F_GetString ( dw_Lst_Inter, lLig,	"ORDRE_CHEQUE"	)
	sNumLetCheque = F_GetString ( dw_Lst_Inter, lLig,	"NUM_LET_CHEQUE"	)

	dcMtReg		= This.GetItemNumber ( lLig,	"MT_REG"					)
	dcMtaReg		= This.GetItemNumber ( lLig,	"MT_A_REG"				)

	sVref1		= Trim ( F_GetString ( dw_Lst_Inter, lLig,	"V_REF1"			) )
	sVref2		= Trim ( F_GetString ( dw_Lst_Inter, lLig,	"V_REF2"			) )
	sCodAg		= F_GetString ( dw_Lst_Inter, lLig,	"COD_AG"			)
	sCodBq		= F_GetString ( dw_Lst_Inter, lLig,	"COD_BQ"			)

	iCptCour		= This.GetItemNumber ( lLig,	"CPT_COUR"				)
	sAltValide	= This.GetItemString ( lLig,	"ALT_VALIDE"			)
	dcCptValide	= This.GetItemNumber ( lLig,	"CPT_VALIDE"			)

	sAltPart		= This.GetItemString ( lLig,	"ALT_PART"				)
	sAltPs		= This.GetItemString ( lLig,	"ALT_PS"					)
	sAltPce		= This.GetItemString ( lLig,	"ALT_PCE"				)
/*------------------------------------------------------------------*/
/* Si les zones ALT_XXX sont positionnées à 'E', il faut les        */
/* remettre à 'N'. L'information est nécessaire pour la             */
/* suppression sur W_INTER_BLOB.                                    */
/*------------------------------------------------------------------*/
	If	sAltPart	= "E"	Then sAltPart	= "N"
	If	sAltPs	= "E"	Then sAltPs		= "N"
	If	sAltPce	= "E"	Then sAltPce	= "N"

	sAltQuest	= This.GetItemString ( lLig,	"ALT_QUEST"				)
	sIdCour		= F_GetString ( dw_Lst_Inter, lLig,	"ID_COUR"		)
	sIdNatCour	= F_GetString ( dw_Lst_Inter, lLig,	"ID_NAT_COUR"	)
	sAltCourGest= This.GetItemString ( lLig,	"ALT_COURGEST"			)

	dcIdIDb		= This.GetItemNumber ( lLig,	"ID_I_DB"				)
	sIdCourj		= F_GetString ( dw_Lst_Inter, lLig,	"ID_COURJ"		)

	sMajPar		= stGLB.sCodOper
	dtMajLe		= dw_1.GetItemDateTime ( 1, "MAJ_LE" 					)
	dtCreeLe		= This.GetItemDateTime ( lLig,	"CREE_LE"			)
	sIdFour		= This.GetItemString  ( lLig, "ID_FOUR" )

// #3
	sAltSuiviMail	= This.GetItemString  ( lLig, "ALT_SUIVI_MAIL" )
	sAdrMail			= This.GetItemString  ( lLig, "ADR_MAIL" )

//* #4	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
	sAltSuiviSms	= This.GetItemString  ( lLig, "ALT_SUIVI_SMS" )
	sNumPortSms		= This.GetItemString  ( lLig, "NUM_PORT_SMS" )


// [PMO89_RS4822]
	dtDteNaiss 	=  This.GetItemDateTime ( lLig, "DTE_NAISS" )
	sVilleNaiss	=  This.GetItemString  ( lLig, "VILLE_NAISS" )	
	sPaysNaiss	=  This.GetItemString  ( lLig, "PAYS_NAISS" )		
	iCodEtatCtrleInter = This.GetItemNumber ( lLig, "COD_ETAT_CTRLE_INTER" )			
   

//* #4	JFF	20/10/2008	[FNAC_PROD_ECH_TECH] Ajout des deux zones
	itrTrans.DW_I01_W_INTER (	dcIdSin,				&
										dcIdI,				&
										sCodInter,			&
										sCodCiv,				&
										sNom,					&
										sAdr1,				&
										sAdr2,				&
										sAdrCp,				&
										sAdrVille,			&
										sAdrAtt,				&
										sNumTeld,			&
										sNumTelb,			&
										sNumFax,				&
										sCodModeReg,		&
										sRibBq,				&
										sRibGui,				&
										sRibCpt,				&
										sRibCle,				&
										dcMtaReg,			&
										dcMtReg,				&
										sVref1,				&
										sVref2,				&
										sCodAg,				&
										sCodBq,				&
										iCptCour,			&
										sAltValide,			&
										dcCptValide,		&
										sAltPart,			&
										sAltPs,				&
										sAltPce,				&
										sAltQuest,			&
										sIdCour,				&
										sIdNatCour,			&
										sAltCourGest,		&
										dcIdIDb,				&
										sIdCourj,			&
										dtCreeLe,			&
										dtMajLe,				&
										sMajPar,				&
										sOrdreCheque,		&
										sNumLetCheque,	   &
										sIdFour, 			&
										sAltSuiviMail,		&
 										sAdrMail,			&
										sAltSuiviSms,	   &
										sNumPortSms,		&
										dtDteNaiss,			&
										sVilleNaiss,		&
										sPaysNaiss,			&
										iCodEtatCtrleInter &
										)
// #3 FIN
										

	If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	Else

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 2 )
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	End If

Case	"DELE"

	dcIdSin		= This.GetItemNumber ( lLig,	"ID_SIN",	DELETE!, False		)
	dcIdI			= This.GetItemNumber ( lLig,	"ID_I", 		DELETE!, False 	)

	/*------------------------------------------------------------------*/
	/* #2                                                               */
	/*------------------------------------------------------------------*/
	If ibSaisieValidation Then
		sSVE = "SVE"
	Else
		sSVE = ""
	End If

	itrTrans.DW_D01_W_INTER ( dcIdSin, dcIdI, sSVE )

	If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	Else

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 2 )
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	End If

// [DECIMAL_PAPILLON]
Case "UPDA" // Update
	sqlsyntax = F_Critere_Decimal ( sqlsyntax )
	This.SetSqlPreview ( sqlsyntax ) 
	
End Choose

//Migration PB8-WYNIWYG-03/2006 CP
//
		Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP		

end event

on ue_modifiermenu;call u_datawindow_detail::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_Lst_Inter::Ue_ModifierMenu
//* Evenement 		: Ue_ModifierMenu
//* Auteur			: Erick John Stark
//* Date				: 15/01/1998 14:25:28
//* Libellé			: 
//* Commentaires	: Pas de suppresiion d'un détail à partir du menu contextuel
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.Uf_Mnu_SupprimerItem ( 3 )


/*------------------------------------------------------------------*/
/* En validation ou en consultation, on ne doit pas voir le PopUp   */
/* Menu CREER                                                       */
/*------------------------------------------------------------------*/

If isTypeTrt <> "S" Then 
	This.Uf_Mnu_CacherItem  ( 1 )
	This.Uf_Mnu_ChangerText ( 2, "&Consulter" )
End If


end on

event rbuttondown;//Migration PB8-WYNIWYG-03/2006 OR
//ce code remplace le code de l'ancêtre, 
//il permet la sélection de la ligne sur le click droit

If Row > 0 Then
	This.SetRow(Row)
//	SelectRow(Row, True)
end if

call super::rButtonDown

Return AncestorReturnValue

//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event getfocus;call super::getfocus;//Migration PB8-WYNIWYG-03/2006 FM

SelectRow(0, False)
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type dw_lst_gti from u_datawindow_detail within w_tm_sp_sinistre
integer x = 846
integer y = 320
integer width = 302
integer height = 288
integer taborder = 450
string dataobject = "d_sp_sin_lst_gti"
boolean vscrollbar = true
boolean livescroll = false
end type

on ue_modifiermenu;call u_datawindow_detail::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_Lst_Gti::Ue_ModifierMenu
//* Evenement 		: Ue_ModifierMenu
//* Auteur			: Erick John Stark
//* Date				: 15/01/1998 14:25:28
//* Libellé			: 
//* Commentaires	: Pas de suppresiion d'un détail à partir du menu contextuel
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.Uf_Mnu_SupprimerItem ( 3 )

/*------------------------------------------------------------------*/
/* En validation ou en consultation, on ne doit pas voir le PopUp   */
/* Menu CREER                                                       */
/*------------------------------------------------------------------*/

If isTypeTrt <> "S" Then 
	This.Uf_Mnu_CacherItem  ( 1 )
	This.Uf_Mnu_ChangerText ( 2, "&Consulter" )
End If
end on

event sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::dw_Lst_Gti::SqlPreview
//* Evenement 		: SqlPreview
//* Auteur			: Erick John Stark
//* Date				: 28/11/1997 15:34:57
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1	JFF	12/10/2007	On remplace le DeleteRow par un RowsDiscard, le delete du detail
//*								se chargeant du delete du div_det. Ainsi on évite le plante "No change Made to db"
//*      JFF   13/12/2010  [DECIMAL_PAPILLON]
//*-----------------------------------------------------------------

String	sSqlPreview
Long lCpt, lTot

Long lLig

//Migration PB8-WYNIWYG-03/2006 CP
Long ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP

Long dcIdSin, dcIdGti, dcCodDecMac, dcCodDecOpe, dcCodEtat, dcCodMotSsui, dcCptValide, dcCptiAreg

DateTime	dDteOppo, dDte1ErUf, dtCreeLe, dtMajLe

Decimal {2} dcMtTotPrej, dcMtPrejaReg, dcMtFranaReg, dcMtnPlafaReg, dcMtPlafaReg, dcMtDeduaReg
Decimal {2} dcMtPrejReg, dcMtDeduReg, dcMtFranReg, dcMtnPlafReg, dcMtPlafReg, dcMtProv

String sHeuOppo, sTxtMess, sAltBloc, sAltAtt, sAltPlaf, sAltSsui, sAltValide, sMajPar

dwBuffer		dwBuf
string			sDte1ErUf // [MIGPB11] [EMD] : Report migration Suisse

//Migration PB8-WYNIWYG-03/2006 CP
//sSqlPreview = This.GetSqlPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 CP

/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion ou d'une  */
/* Suppression                                                      */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//This.GetUpdateStatus ( lLig, dwBuf )
lLig  = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 CP


Choose Case Left ( sSqlPreview, 4 )
Case	"INSE"

	dcIdSin			= This.GetItemNumber ( lLig,	"ID_SIN"					)
	dcIdGti			= This.GetItemNumber ( lLig,	"ID_GTI"					)

	dDteOppo			= This.GetItemDateTime ( lLig, "DTE_OPPO"	)
	sHeuOppo			= F_GetString ( dw_Lst_Gti, lLig,	"HEU_OPPO"		)
//Migration PB8-WYNIWYG-03/2006 FM
//	dDte1ErUf		= DateTime ( This.GetItemDate ( lLig,	"DTE_1ER_UF" )	)
	dDte1ErUf		= This.GetItemDateTime ( lLig,	"DTE_1ER_UF" )
//Fin Migration PB8-WYNIWYG-03/2006 FM

	dcMtTotPrej		= This.GetItemNumber ( lLig,	"MT_TOT_PREJ"			)
	dcMtPrejaReg	= This.GetItemNumber ( lLig,	"MT_PREJ_AREG"			)
	dcMtFranaReg	= This.GetItemNumber ( lLig,	"MT_FRAN_AREG"			)
	dcMtnPlafaReg	= This.GetItemNumber ( lLig,	"MT_NPLAF_AREG"		)
	dcMtPlafaReg	= This.GetItemNumber ( lLig,	"MT_PLAF_AREG"			)
	dcMtDeduaReg	= This.GetItemNumber ( lLig,	"MT_DEDU_AREG"			)

	dcMtPrejReg		= This.GetItemNumber ( lLig,	"MT_PREJ_REG"			)
	dcMtDeduReg		= This.GetItemNumber ( lLig,	"MT_DEDU_REG"			)
	dcMtFranReg		= This.GetItemNumber ( lLig,	"MT_FRAN_REG"			)
	dcMtnPlafReg	= This.GetItemNumber ( lLig,	"MT_NPLAF_REG"			)
	dcMtPlafReg		= This.GetItemNumber ( lLig,	"MT_PLAF_REG"			)
	dcMtProv			= This.GetItemNumber ( lLig,	"MT_PROV"				)

	dcCodDecMac		= This.GetItemNumber ( lLig,	"COD_DEC_MAC"			)
	dcCodDecOpe		= This.GetItemNumber ( lLig,	"COD_DEC_OPE"			)
	dcCodEtat		= This.GetItemNumber ( lLig,	"COD_ETAT"				)

	sTxtMess			= Trim ( F_GetString ( dw_Lst_Gti, lLig,	"TXT_MESS"		) )
	sAltBloc			= This.GetItemString ( lLig,	"ALT_BLOC"				)
	sAltAtt			= This.GetItemString ( lLig,	"ALT_ATT"				)
	sAltPlaf			= This.GetItemString ( lLig,	"ALT_PLAF"				)
	sAltSsui			= This.GetItemString ( lLig,	"ALT_SSUI"				)
	dcCodMotSsui	= This.GetItemNumber ( lLig,	"COD_MOT_SSUI"			)
	sAltValide		= This.GetItemString ( lLig,	"ALT_VALIDE"			)
	dcCptValide		= This.GetItemNumber ( lLig,	"CPT_VALIDE"			)
	dcCptiAreg		= This.GetItemNumber ( lLig,	"CPT_I_AREG"			)

	sMajPar			= stGLB.sCodOper
	dtMajLe			= dw_1.GetItemDateTime ( 1, "MAJ_LE" 					)
	dtCreeLe			= This.GetItemDateTime ( lLig,	"CREE_LE"			)

// [MIGPB11] [EMD] : Debut Migration : Report migration Suisse
//	itrTrans.DW_I01_W_GTI	 (	dcIdSin,				&
//										dcIdGti,				&
//										dDteOppo,			&
//										sHeuOppo,			&
//										dDte1ErUf,			&
//										dcMtTotPrej,		&
//										dcMtPrejaReg,		&
//										dcMtFranaReg,		&
//										dcMtnPlafaReg,		&
//										dcMtPlafaReg,		&
//										dcMtDeduaReg,		&
//										dcMtPrejReg,		&
//										dcMtDeduReg,		&
//										dcMtFranReg,		&
//										dcMtnPlafReg,		&
//										dcMtPlafReg,		&
//										dcMtProv,			&
//										dcCodDecMac,		&
//										dcCodDecOpe,		&
//										dcCodEtat,			&
//										sTxtMess,			&
//										sAltBloc,			&
//										sAltAtt,				&
//										sAltPlaf,			&
//										sAltSsui,			&
//										dcCodMotSsui,		&
//										sAltValide,			&
//										dcCptValide,		&
//										dcCptiAreg,			&
//										dtCreeLe,			&		
//										dtMajLe,				&
//										sMajPar				)

	// On passe la date de 1ere UF au format string pour ne pas gener le DBMS (Parfois elle contient une date sans heure)
	sDte1ErUf = string(dDte1ErUf)
										
	itrTrans.DW_I01_W_GTI	 (	dcIdSin,				&
										dcIdGti,				&
										dDteOppo,			&
										sHeuOppo,			&
										sDte1ErUf,			&
										dcMtTotPrej,		&
										dcMtPrejaReg,		&
										dcMtFranaReg,		&
										dcMtnPlafaReg,		&
										dcMtPlafaReg,		&
										dcMtDeduaReg,		&
										dcMtPrejReg,		&
										dcMtDeduReg,		&
										dcMtFranReg,		&
										dcMtnPlafReg,		&
										dcMtPlafReg,		&
										dcMtProv,			&
										dcCodDecMac,		&
										dcCodDecOpe,		&
										dcCodEtat,			&
										sTxtMess,			&
										sAltBloc,				&
										sAltAtt,				&
										sAltPlaf,				&
										sAltSsui,				&
										dcCodMotSsui,		&
										sAltValide,			&
										dcCptValide,			&
										dcCptiAreg,			&
										dtCreeLe,			&		
										dtMajLe,				&
										sMajPar				)
// [MIGPB11] [EMD] : Fin Migration

	If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	Else

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 2 )
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	End If

Case	"DELE"

	dcIdSin		= This.GetItemNumber ( lLig,	"ID_SIN",	DELETE!, False		)
	dcIdGti		= This.GetItemNumber ( lLig,	"ID_GTI",	DELETE!, False		)

	// #1
	lTot = dw_w_div_det.Deletedcount ()
	For lCpt = lTot To 1 Step -1
		If dw_w_div_det.GetItemNumber ( lCpt,	"ID_GTI", DELETE!, False ) = dcIdGti Then
			dw_w_div_det.RowsDiscard ( lCpt, lCpt, DELETE! ) 
		End If
	Next

	lTot = dw_w_Commande.Deletedcount ()
	For lCpt = lTot To 1 Step -1
		If dw_w_Commande.GetItemNumber ( lCpt,	"ID_GTI", DELETE!, False ) = dcIdGti Then
			dw_w_Commande.RowsDiscard ( lCpt, lCpt, DELETE! ) 
		End If
	Next

	lTot = dw_wdetail.Deletedcount ()
	For lCpt = lTot To 1 Step -1
		If dw_wdetail.GetItemNumber ( lCpt,	"ID_GTI", DELETE!, False ) = dcIdGti Then
			dw_wdetail.RowsDiscard ( lCpt, lCpt, DELETE! ) 
		End If
	Next
	
	// :#1

	itrTrans.DW_D01_W_GTI ( dcIdSin, dcIdGti )

	If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	Else

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 2 )
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	End If

Case "UPDA"
	// [DECIMAL_PAPILLON]
	sqlsyntax = F_Critere_Decimal ( sqlsyntax )
	This.SetSqlPreview ( sqlsyntax ) 

End Choose

//Migration PB8-WYNIWYG-03/2006 CP
//
		Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP		

end event

event rbuttondown;//Migration PB8-WYNIWYG-03/2006 OR
//ce code remplace le code de l'ancêtre, 
//il permet la sélection de la ligne sur le click droit

If Row > 0 Then
	This.SetRow(Row)
	SelectRow(Row, True)
end if

call super::rButtonDown

Return AncestorReturnValue

//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

type dw_wparaplafond from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 3301
integer y = 1120
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_w_para_plafond"
end type

event sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::dw_wParaPlafond::SqlPreview
//* Evenement 		: SqlPreview
//* Auteur			: Erick John Stark
//* Date				: 28/11/1997 15:34:57
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String	sSqlPreview, sIdTypPlaf, sIdPara, sMajPar

DateTime dtCreeLe, dtMajLe

Long dcIdSin, dcIdGti, dcIdDetail, dcIdI, lLig

//Migration PB8-WYNIWYG-03/2006 CP
Long ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP

dwBuffer		dwBuf

//Migration PB8-WYNIWYG-03/2006 CP
//sSqlPreview = This.GetSqlPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 CP

/*------------------------------------------------------------------*/
/* Au niveau du SqlPreview, on ne doit avoir que des insertions ou  */
/* des suppressions. Les données insérées proviennent des fonctions */
/* Uf_PreparerValider_Plafond () (Pour les plafonds de la           */
/* garantie) et Uf_PreparerValider_Detail (Pour les plafonds des    */
/* détails).                                                        */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Attention, pour information la zone ID_PARA peut être NULLE.     */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//This.GetUpdateStatus ( lLig, dwBuf )
lLig  = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 CP

Choose Case Left ( sSqlPreview, 4 )
Case	"INSE"

	dcIdSin			= This.GetItemNumber ( lLig,	"ID_SIN"					)
	dcIdGti			= This.GetItemNumber ( lLig,	"ID_GTI"					)
	dcIdDetail		= This.GetItemNumber ( lLig,	"ID_DETAIL"				)
	sIdTypPlaf		= This.GetItemString ( lLig,	"ID_TYP_PLAF"			)
	sIdPara			= F_GetString ( dw_wParaPlafond, lLig,	"ID_PARA"	)
	dcIdI				= This.GetItemNumber ( lLig,	"ID_I"					)
	sMajPar			= stGLB.sCodOper

	dtMajLe			= dw_1.GetItemDateTime ( 1, "MAJ_LE" 					)
	dtCreeLe			= dtMajLe

	itrTrans.DW_I01_W_PARA_PLAFOND	 (	dcIdSin,				&
													dcIdGti,				&
													dcIdDetail,			&
													sIdTypPlaf,			&
													sIdPara,				&
													dcIdI,				&
													dtCreeLe,			&
													dtMajLe,				&
													sMajPar		)

										

	If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	Else

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 2 )
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	End If

Case	"DELE"

	dcIdSin		= This.GetItemNumber ( lLig,	"ID_SIN",		DELETE!, False		)
	dcIdGti		= This.GetItemNumber ( lLig,	"ID_GTI",		DELETE!, False		)
	dcIdDetail	= This.GetItemNumber ( lLig,	"ID_DETAIL",	DELETE!, False		)

	itrTrans.DW_D01_W_PARA_PLAFOND ( dcIdSin, dcIdGti, dcIdDetail )

	If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	Else

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 2 )
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	End If

Case "UPDA"

	sqlsyntax = F_Critere_Decimal ( sqlsyntax )

	// Variante pour ce cas, l'id_typ_plaf est une string donc je retire le point de fin
	sqlsyntax = Left ( Trim ( sqlsyntax), Len ( Trim (sqlsyntax )) - 1 ) + " "


End Choose

//Migration PB8-WYNIWYG-03/2006 CP
//
		Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP		

end event

type dw_wreggti from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 3305
integer y = 1240
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_w_reg_gti"
end type

event sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::dw_wRegGti::SqlPreview
//* Evenement 		: SqlPreview
//* Auteur			: Erick John Stark
//* Date				: 28/11/1997 15:34:57
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date			Modification
//*     JFF   13/12/2010   [DECIMAL_PAPILLON]
//*-----------------------------------------------------------------

String	sSqlPreview, sMajPar

Long dcIdSin, dcIdI, dcIdGti, dcIdRgpt
Long lLig

//Migration PB8-WYNIWYG-03/2006 CP
Long ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP

Decimal {2} dcMtReg, dcMtRgpt

dwBuffer		dwBuf

DateTime dtMajLe, dtCreeLe

//Migration PB8-WYNIWYG-03/2006 CP
//sSqlPreview = This.GetSqlPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 CP

/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion.          */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On insére toujours un ID_REG à 0. Cette valeur sera armée au     */
/* moment de la validation, dans les procédures stockées de         */
/* SqlServer.                                                       */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//This.GetUpdateStatus ( lLig, dwBuf )
lLig  = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 CP

Choose Case Left ( sSqlPreview, 4 )
Case	"INSE"

	dcIdSin			= This.GetItemNumber ( lLig,	"ID_SIN"					)
	dcIdI				= This.GetItemNumber ( lLig,	"ID_I"					)
	dcIdGti			= This.GetItemNumber ( lLig,	"ID_GTI"					)
	dcIdRgpt			= This.GetItemNumber ( lLig,	"ID_RGPT"				)

	dcMtReg			= This.GetItemNumber ( lLig,	"MT_REG"					)
	dcMtRgpt			= This.GetItemNumber ( lLig,	"MT_RGPT"				)

	sMajPar			= stGLB.sCodOper
	dtMajLe			= dw_1.GetItemDateTime ( 1, "MAJ_LE" 					)
	dtCreeLe			= dtMajLe

	
//	sSql = 'sysadm.DW_I01_W_REG_GTI ' 										+	&
//				String ( dcIdSin 							) + ', '				+ 	&
//				String ( dcIdI   							) + ', '				+ 	&
//				String ( dcIdGti 							) + ', '				+ 	&

//				String ( dcIdRgpt 						) + ', '				+ 	&
//				String ( 0 									) + ', '				+ 	&
//				String ( dcMtReg, "#,##0.00" 			) + ', '				+ 	&
//				String ( dcMtRgpt, "#,##0.00"  		) + ', '				+ 	&
//				'"' + String ( dtCreeLe, "dd/mm/yyyy hh:mm:ss.ff" 	)	+ '"' + 	', '				+ 	&
//				'"' + String ( dtMajLe, "dd/mm/yyyy hh:mm:ss.ff"	)	+ '"'	+	', '				+ 	&
//				'"' + sMajPar + '"'
//
//	EXECUTE IMMEDIATE :sSql USING	itrTrans	;

	

	itrTrans.DW_I01_W_REG_GTI (	dcIdSin,				&
											dcIdI,				&
											dcIdGti,				&
											dcIdRgpt,			&
											0,						&
											dcMtReg,				&
											dcMtRgpt,			&
											dtCreeLe,			&		
											dtMajLe,				&
											sMajPar				)										

	If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	Else

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 2 )
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	End If

// [DECIMAL_PAPILLON]
Case "UPDA" // Update
	sqlsyntax = F_Critere_Decimal ( sqlsyntax )
	This.SetSqlPreview ( sqlsyntax ) 

End Choose

//Migration PB8-WYNIWYG-03/2006 CP
//
		Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP		

end event

type dw_mot_rout from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 59
integer y = 1544
integer width = 197
integer height = 96
integer taborder = 380
boolean bringtotop = true
string dataobject = "d_routage_motif"
boolean livescroll = true
end type

type st_pochette from statictext within w_tm_sp_sinistre
boolean visible = false
integer x = 2203
integer y = 8
integer width = 201
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_lst_contact from u_datawindow_detail within w_tm_sp_sinistre
integer x = 1577
integer y = 316
integer width = 302
integer height = 288
integer taborder = 350
string dataobject = "d_sp_sin_lst_contacts"
boolean vscrollbar = true
boolean livescroll = false
end type

event sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_Lst_Contact
//* Evenement 		: SqlPreview
//* Auteur			: JFF
//* Date				: 30/04/2001 15:42:44
//* Libellé			: 
//* Commentaires	: Insertion des Contacts d'un sinistre.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String		sSql, sTxtMess1, sTxtMess2	// commande SQL qui doit être envoyée.
Long			lLig					// N° de la ligne à insèrer ou supprimer.
dwBuffer		dwBuf					// buffer de donnée de la Dw.

//Migration PB8-WYNIWYG-03/2006 CP
//sSql = This.GetSqlPreview ()
sSql = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 CP

Choose Case Left ( sSql, 4 )

	Case "INSE"

		/*------------------------------------------------------------------*/
		// Gestion des quotes dans la saisie des messages
		/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//		This.GetUpdateStatus ( lLig, dwBuf )		
lLig  = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 CP


		sTxtMess1	=	Dw_Lst_Contact.GetItemString ( lLig, "TXT_MESS1" )
		sTxtMess2	=	Dw_Lst_Contact.GetItemString ( lLig, "TXT_MESS2" )

		If IsNull ( sTxtMess1 ) Or sTxtMess1 = "" Then

			sTxtMess1 = "''"
		Else

			sTxtMess1 = f_Remplace ( sTxtMess1, ",", "." )
			sTxtMess1 = "'" + f_Remplace ( sTxtMess1, "'", " " ) + "'"
		End If

		If IsNull ( sTxtMess2 ) Or sTxtMess2 = "" Then

			sTxtMess2 = "''"
		Else

			sTxtMess2 = f_Remplace ( sTxtMess2, ",", "." )
			sTxtMess2 = "'" + f_Remplace ( sTxtMess2, "'", " " ) + "'"
		End If

		sSql	=	"EXECUTE sysadm.DW_I01_CONTACT "        										+ &
					String ( dw_Lst_Contact.GetItemNumber ( lLig, "ID_SIN" ) )				+ "," + &
					String ( dw_Lst_Contact.GetItemNumber ( lLig, "ID_MSG_SEQ" ) )			+ "," + &
					f_GetItem ( Dw_Lst_Contact, lLig, "ID_TYP_MSG"   )		+ "," + &
					String ( dw_Lst_Contact.GetItemNumber ( lLig, "ID_NAT_MSG" ) )			+ "," + &
					f_GetItem ( Dw_Lst_Contact, lLig, "ID_CANAL"     )		+ "," + &
            	f_GetItem ( Dw_Lst_Contact, lLig, "COD_I_PROV"   ) 	+ "," + &
            	sTxtMess1													 	+ "," + &
            	sTxtMess2													 	+ "," + &
            	f_GetItem ( Dw_Lst_Contact, lLig, "ALT_VALIDE"   ) 	+ "," + &
					"'" + String ( dw_Lst_Contact.GetItemDateTime ( lLig, "CREE_LE" ), "dd/mm/yyyy hh:mm:ss" )			+ "'," + &
					"'" + String ( dw_Lst_Contact.GetItemDateTime ( lLig, "MAJ_LE" ), "dd/mm/yyyy hh:mm:ss" )			+ "'," + &
					f_GetItem ( Dw_Lst_Contact, lLig, "MAJ_PAR"      )   

		This.SetSqlPreview ( sSql )

End Choose
end event

type dw_corb from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 3191
integer y = 1544
integer width = 242
integer height = 100
integer taborder = 370
boolean bringtotop = true
boolean enabled = false
string dataobject = "dddw_sp_sin_contact_stkcorb"
end type

type dw_article from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 229
integer y = 1668
integer width = 242
integer height = 100
integer taborder = 390
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_article"
end type

type dw_w_commande from u_datawindow_detail within w_tm_sp_sinistre
integer x = 69
integer y = 656
integer width = 302
integer height = 288
integer taborder = 110
string dataobject = "d_gs_w_commande"
boolean vscrollbar = true
boolean border = false
end type

event sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------*/
//*
//* Objet 			: W_Tm_Sp_Sinistre::dw_w_commande::SqlPreview
//* Evenement 		: SqlPreview
//* Auteur			: Erick John Stark
//* Date				: 28/11/1997 15:34:57
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------*/
//* MAJ PAR		Date		  Modification
//*     JFF   13/12/2010  [DECIMAL_PAPILLON]
//*			FPI		23/12/2010	[23122010.FPI] Code de l'INSERT
//*-----------------------------------------------------------------*/
String	sSqlPreview

Long lLig

//Migration PB8-WYNIWYG-03/2006 CP
Long ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP

Long		 lIdSeq, lCptValide, dcIdSin, dcIdGti, dcIdDetail
DateTime  dtDteRdvCli, dtDteRcpFrn, dtDteEnvCli, dtCreeLe, dtMajLe
String 	 sIdFour, sIdTypArt, sIdMarqArt, sIdModlArt, sAdrNom, sAdrPrenom, sAdrLivr1, sAdrLivr2
String 	 sAdrLivrCpl, sAdrCp, sAdrVille, sAdrTel1, sAdrTel2, sAdrTel3, sAdrMail, sHrdvCliMin
String 	 sHrdvCliMax, sIdSerieAnc, sProbleme, sIdCmdFrn, sIdSerieNouv, sIdBonTransp, sCodEtat
String	 sCommentFrn, sNomGest, sMajPar
decimal dcMtTtcCmde
//
string sIdZone,sAdrCodCiv, sIdRefFour,sAltDevAcp, sIdMarqArtIfr
string sIdModlArtIfr, sInfoSpbFrnCplt, sInfoFrnSpbCplt
string sAdrfcCodCiv,sAdrfcNom, sAdrfcPrenom, sAdrfcLivr1, sAdrfcLivr2, sAdrfcLivrCpl, sAdrfcCp, sAdrfcVille
long iIdBsp, iInfoSpbFrn
long iIdOrianMarque,iIdOrianModele, iStatusGc,iIdAnn
datetime dtElvMobile,dtEmisDevis, dtRetPret,dtDevAcp, dtRetLogis, dtRetPretMin, dtRetPretMax, dtEnvBteFrn
datetime dtRcpBteCli, dtDepBteCli, dtEnvSt, dtRcpMobCli
decimal dcMtDevis 

dwBuffer		dwBuf


//Migration PB8-WYNIWYG-03/2006 CP
//sSqlPreview = This.GetSqlPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 CP

/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion ou d'une  */
/* Suppression                                                      */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//This.GetUpdateStatus ( lLig, dwBuf )
lLig  = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 CP


Choose Case Left ( sSqlPreview, 4 )

Case	"DELE"

	dcIdSin			= This.GetItemNumber ( lLig,	"ID_SIN", DELETE!, False )
	lIdSeq			= This.GetItemNumber ( lLig,	"ID_SEQ", DELETE!, False )

   F_Execute ( "Execute sysadm.DW_D01_W_COMMANDE " + String ( dcIdSin ) + "., " + String ( lIdSeq ) , itrTrans ) 

	If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	Else

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 2 )
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	End If

// [DECIMAL_PAPILLON]
Case	"UPDA"
	sqlsyntax = F_Critere_Decimal ( sqlsyntax )

	// Variante pour ce cas, l'id_seq est un int donc je retire le poit de fin
	sqlsyntax = Left ( Trim ( sqlsyntax), Len ( Trim (sqlsyntax )) - 1 ) + " "
	This.SetSqlPreview ( sqlsyntax ) 

// [23122010.FPI]
Case "INSE"
	
	dcIdSin = This.GetItemNumber ( lLig,	"ID_SIN")
	lIdSeq= This.GetItemNumber ( lLig,	"ID_SEQ")
	dcIdGti = This.GetItemNumber ( lLig,	"ID_GTI")
	dcIdDetail = This.GetItemNumber ( lLig,	"ID_DETAIL")
	sIdFour = This.GetItemString ( lLig,	"ID_FOUR")
	sIdTypArt = This.GetItemString ( lLig,	"ID_TYP_ART")
	sIdMarqArt = This.GetItemString ( lLig,	"ID_MARQ_ART")
	sIdModlArt = This.GetItemString ( lLig,	"ID_MODL_ART")
	dcMtTtcCmde = This.GetItemDecimal ( lLig,	"MT_TTC_CMDE")
	sAdrNom = This.GetItemString ( lLig,	"ADR_NOM")
	sAdrPrenom = This.GetItemString ( lLig,	"ADR_PRENOM")
	sAdrLivr1 = This.GetItemString ( lLig,	"ADR_LIVR1")
	sAdrLivr2 = This.GetItemString ( lLig,	"ADR_LIVR2")
	sAdrLivrCpl = This.GetItemString ( lLig,	"ADR_LIVR_CPL")
	sAdrCp = This.GetItemString ( lLig,	"ADR_CP")
	sAdrVille = This.GetItemString ( lLig,	"ADR_VILLE")
	sAdrTel1 = This.GetItemString ( lLig,	"ADR_TEL1")
	sAdrTel2 = This.GetItemString ( lLig,	"ADR_TEL2")
	sAdrTel3 = This.GetItemString ( lLig,	"ADR_TEL3")
	sAdrMail = This.GetItemString ( lLig,	"ADR_MAIL")
	dtDteRdvCli = This.GetItemDateTime ( lLig,	"DTE_RDV_CLI")
	sHrdvCliMin = This.GetItemString ( lLig,	"HRDV_CLI_MIN")
	sHrdvCliMax = This.GetItemString ( lLig,	"HRDV_CLI_MAX")
	sIdSerieAnc = This.GetItemString ( lLig,	"ID_SERIE_ANC")
	sProbleme = This.GetItemString ( lLig,	"PROBLEME")
	sIdCmdFrn = This.GetItemString ( lLig,	"ID_CMD_FRN")
	sIdSerieNouv = This.GetItemString ( lLig,	"ID_SERIE_NOUV")
	sIdBonTransp = This.GetItemString ( lLig,	"ID_BON_TRANSP")
	dtDteRcpFrn = This.GetItemDateTime ( lLig,	"DTE_RCP_FRN")
	dtDteEnvCli = This.GetItemDateTime ( lLig,	"DTE_ENV_CLI")
	sCodEtat = This.GetItemString ( lLig,	"COD_ETAT")
	sCommentFrn = This.GetItemString ( lLig,	"COMMENT_FRN")
	sNomGest = This.GetItemString ( lLig,	"NOM_GEST")
	dtCreeLe = This.GetItemDateTime ( lLig,	"CREE_LE")
	dtMajLe = This.GetItemDateTime ( lLig,	"MAJ_LE")
	sMajPar = This.GetItemString ( lLig,	"MAJ_PAR")
	sIdZone = This.GetItemString ( lLig,	"ID_ZONE")
	iIdBsp = This.GetItemNumber ( lLig,	"ID_BSP")
	dtRetPret = This.GetItemDateTime ( lLig,	"DTE_RET_PRET")
	sAdrCodCiv = This.GetItemString ( lLig,	"ADR_COD_CIV")
	sIdRefFour = This.GetItemString ( lLig,	"ID_REF_FOUR")
	iIdOrianMarque = This.GetItemNumber ( lLig,	"ID_ORIAN_MARQUE")
	iIdOrianModele = This.GetItemNumber ( lLig,	"ID_ORIAN_MODELE")
	dtElvMobile = This.GetItemDateTime ( lLig,	"DTE_ELV_MOBILE")
	iStatusGc = This.GetItemNumber ( lLig,	"STATUS_GC")
	dtEmisDevis = This.GetItemDateTime ( lLig,	"DTE_EMIS_DEVIS")
	dcMtDevis = This.GetItemDecimal ( lLig,	"MT_DEVIS")
	sAltDevAcp = This.GetItemString ( lLig,	"ALT_DEV_ACP")
	dtDevAcp = This.GetItemDateTime ( lLig,	"DTE_DEV_ACP")
	sAdrfcCodCiv = This.GetItemString ( lLig,	"ADRFC_COD_CIV")
	sAdrfcNom = This.GetItemString ( lLig,	"ADRFC_NOM")
	sAdrfcPrenom = This.GetItemString ( lLig,	"ADRFC_PRENOM")
	sAdrfcLivr1 = This.GetItemString ( lLig,	"ADRFC_LIVR1")
	sAdrfcLivr2 = This.GetItemString ( lLig,	"ADRFC_LIVR2")
	sAdrfcLivrCpl = This.GetItemString ( lLig,	"ADRFC_LIVR_CPL")
	sAdrfcCp = This.GetItemString ( lLig,	"ADRFC_CP")
	sAdrfcVille = This.GetItemString ( lLig,	"ADRFC_VILLE")
	dtRetLogis = This.GetItemDateTime ( lLig,	"DTE_RET_LOGIS")
	dtRetPretMin = This.GetItemDateTime ( lLig,	"DTE_RET_PRET_MIN")
	dtRetPretMax = This.GetItemDateTime ( lLig,	"DTE_RET_PRET_MAX")
	 iIdAnn = This.GetItemNumber ( lLig,	"ID_ANN")
	 dtEnvBteFrn = This.GetItemDateTime ( lLig,	"DTE_ENV_BTE_FRN")
	 dtRcpBteCli = This.GetItemDateTime ( lLig,	"DTE_RCP_BTE_CLI")
	 dtDepBteCli = This.GetItemDateTime ( lLig,	"DTE_DEP_BTE_CLI")
	 dtEnvSt = This.GetItemDateTime ( lLig,	"DTE_ENV_ST")
	 dtRcpMobCli = This.GetItemDateTime ( lLig,	"DTE_RCP_MOB_CLI")
	 iInfoSpbFrn = This.GetItemNumber ( lLig,	"INFO_SPB_FRN")
	 sIdMarqArtIfr = This.GetItemString ( lLig,	"ID_MARQ_ART_IFR")
	 sIdModlArtIfr = This.GetItemString ( lLig,	"ID_MODL_ART_IFR")
	 sInfoSpbFrnCplt = This.GetItemString ( lLig,	"INFO_SPB_FRN_CPLT")
	 sInfoFrnSpbCplt = This.GetItemString ( lLig,	"INFO_FRN_SPB_CPLT")
		 
		 
	itrTrans.DW_I01_W_COMMANDE( dcIdSin,lIdSeq,dcIdGti,dcIdDetail, &
		sIdFour,sIdTypArt,sIdMarqArt,sIdModlArt, dcMtTtcCmde,  &
		sAdrNom, sAdrPrenom, sAdrLivr1, sAdrLivr2, sAdrLivrCpl, sAdrCp, sAdrVille, &
		sAdrTel1, sAdrTel2, sAdrTel3, sAdrMail, dtDteRdvCli, sHrdvCliMin, sHrdvCliMax, &
		sIdSerieAnc, sProbleme, sIdCmdFrn, sIdSerieNouv, sIdBonTransp, dtDteRcpFrn, dtDteEnvCli,  &
		sCodEtat, sCommentFrn, sNomGest, &
		dtCreeLe, dtMajLe, sMajPar,  &
		sIdZone, iIdBsp, &
		dtRetPret, sAdrCodCiv, sIdRefFour, iIdOrianMarque, iIdOrianModele, &
		dtElvMobile, iStatusGc, dtEmisDevis, dcMtDevis, &
		sAltDevAcp, dtDevAcp,  &
		sAdrfcCodCiv, sAdrfcNom, sAdrfcPrenom, sAdrfcLivr1, sAdrfcLivr2, sAdrfcLivrCpl, &
		sAdrfcCp, sAdrfcVille, &
		 dtRetLogis, dtRetPretMin, dtRetPretMax, &
		 iIdAnn, dtEnvBteFrn, dtRcpBteCli, dtDepBteCli, &
		 dtEnvSt, dtRcpMobCli, &
		 iInfoSpbFrn, sIdMarqArtIfr, sIdModlArtIfr, sInfoSpbFrnCplt, sInfoFrnSpbCplt)

	If itrTrans.SqlCode <> 0	Then
		ll_return = 1
	Else
		ll_return = 2
	End If
End Choose

//Migration PB8-WYNIWYG-03/2006 CP
//
Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP		

end event

on ue_modifiermenu;call u_datawindow_detail::ue_modifiermenu;//*****************************************************************************
//
// Objet 		: U_DataWindow_detail
// Evenement 	: ue_ModifierMenu
//	Auteur		: Fabry JF
//	Date			: 04/09/01
// Libellé		: Menu contextuel 
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

This.Uf_Mnu_SupprimerItem ( 1 )
This.Uf_Mnu_SupprimerItem ( 3 )

If This.GetRow () <= 0 Then Return

CHOOSE CASE isTypeTrt
	CASE "S"
	
		If This.GetItemNumber ( This.GetRow (), "CPT_VALIDE" ) > 0 Then
			This.Uf_Mnu_ChangerText ( 2, "&Consulter" )
		Else
			This.Uf_Mnu_ChangerText ( 2, "&Modifier" )
		End If
	

	CASE "C", "V"
		This.Uf_Mnu_ChangerText ( 2, "&Consulter" )

END CHOOSE




end on

event rbuttondown;//Migration PB8-WYNIWYG-03/2006 OR
//ce code remplace le code de l'ancêtre, 
//il permet la sélection de la ligne sur le click droit

If Row > 0 Then
	This.SetRow(Row)
//	SelectRow(Row, True)
end if

call super::rButtonDown

Return AncestorReturnValue

//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

type dw_cmde_typ_frn from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 517
integer y = 1668
integer width = 242
integer height = 100
integer taborder = 400
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_gs_commande_type_frn"
end type

type dw_cmde_typ_art from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 814
integer y = 1668
integer width = 242
integer height = 100
integer taborder = 410
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_gs_commande_type_art"
end type

type cb_aide from u_aidecontrat within w_tm_sp_sinistre
integer x = 1216
integer y = 8
integer width = 192
integer height = 68
integer taborder = 70
end type

type cb_notice from u_aidecontrat within w_tm_sp_sinistre
integer x = 1216
integer y = 76
integer width = 192
integer height = 68
integer taborder = 80
boolean bringtotop = true
end type

type dw_horaire_rdv from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 1111
integer y = 1668
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_gs_horaire_rdv"
end type

type dw_zone_fournisseur from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 1408
integer y = 1668
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_lst_zone_fournisseur"
end type

type dw_det_article from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 1705
integer y = 1672
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_det_article"
boolean livescroll = true
end type

type dw_det_hlr from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 2002
integer y = 1672
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_det_hlr"
boolean livescroll = true
end type

type dw_lst_gamme from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 2304
integer y = 1672
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_liste_gamme"
boolean livescroll = true
end type

type dw_det_pro from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 2597
integer y = 1672
integer width = 242
integer height = 100
integer taborder = 420
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_lst_det_pro"
boolean livescroll = true
end type

type cb_noboite from commandbutton within w_tm_sp_sinistre
boolean visible = false
integer x = 1518
integer y = 668
integer width = 96
integer height = 68
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "..."
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet         : w_tm_sp_Sinistre::cb_noboite
//* Evenement     : clicked
//* Auteur        : PLJ
//* Date          : 05/09/2003 09:46:33
//* Libellé       : 
//* Commentaires  : Ouvre la fenêtre de gestion des numéros de boîte
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------
String	sNoBoite, sNoBoiteOrigine, sText, sMod, sVal
s_Pass	stPass	
Long		lIdTypArch
Boolean	bRet, bVal


/*------------------------------------------------------------------*/
/* Le gestionnaire a-t-il le droit de valider des dossiers pour ce  */
/* produits.                                                        */
/*------------------------------------------------------------------*/
If ibSaisieValidation Then
	iuoGsSpSinistre.uf_GetAutorisation ( "", sVal, bVal, bVal, bRet, -1 )
	If Not bRet Then
		stMessage.sTitre		= "Vous n'êtes pas autorisé."
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= False
		stMessage.sCode		= "SVE0020"
	   stMessage.sVar [1]	= String ( dw_1.GetItemNumber ( 1, "ID_PROD" ) )

		F_Message ( stMessage )
		Return
	End If
End If

stPass.udwTab[1] = dw_BoiteArchive

If isTypeTrt = 'C' Then

	stPass.sTab[1]   = 'CS'
	OpenWithParm  ( w_trt_sp_wkfs_boite, stPass, Parent )

Else

	stPass.sTab[1]   = 'VAL'

	If dw_BoiteArchive.RowCount() = 1 Then

		lIdTypArch = dw_BoiteArchive.GetItemNumber ( 1, "ID_TYP_ARCH" )

		/*----------------------------------------------------------*/
		/* On ouvre la fenêtre que dans la cas d'une méthode privée */
		/*----------------------------------------------------------*/
		If lIdTypArch = 1 Then

			OpenWithParm  ( w_trt_sp_wkfs_boite, stPass, Parent )

			/*------------------------------------------------------------------*/
			/* On récupère le nouveau numéro de boite                           */
			/*------------------------------------------------------------------*/
			sNoBoite = Message.StringParm
			sNoBoiteOrigine = dw_BoiteArchive.GetItemString ( 1, "NO_BOITE" )

			If sNoBoite <> "RETOUR" Then
				If sNoBoite <> sNoBoiteOrigine Or isNull ( sNoBoiteOrigine ) Then
					dw_BoiteArchive.SetItem ( 1, "NO_BOITE", sNoBoite )

					sText = 'A stocker dans boîte ' + sNoBoite
					sMod = "Text_t.Text = '" + sText + "'"
					dw_BoiteArchive.Modify ( sMod )

				End If
			End If
		End If


	End If

End If

end event

type dw_boutique from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 2898
integer y = 1672
integer width = 242
integer height = 100
integer taborder = 430
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_lst_boutique"
end type

type dw_commune from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 3200
integer y = 1672
integer width = 242
integer height = 100
integer taborder = 320
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_commune"
end type

type dw_tac_imei from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 3200
integer y = 1796
integer width = 242
integer height = 100
integer taborder = 120
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_lst_tac_imei"
end type

type dw_boitearchive from u_datawindow within w_tm_sp_sinistre
event ue_recupfocus pbm_custom71
boolean visible = false
integer x = 503
integer y = 664
integer width = 1015
integer height = 96
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_sp_sin_boite_archive"
boolean border = false
end type

type dw_mail from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 2898
integer y = 1796
integer width = 242
integer height = 100
integer taborder = 310
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_trt_mail"
end type

type dw_autorisation from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 2606
integer y = 1796
integer width = 242
integer height = 100
integer taborder = 300
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_lst_autorisation"
end type

type dw_gencourrier from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 2002
integer y = 1804
integer width = 242
integer height = 100
integer taborder = 220
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_stk_generation_courrier"
end type

type dw_stk_w_cour_blob_sve from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 3026
integer y = 532
integer width = 242
integer height = 100
integer taborder = 50
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_stk_w_cour_blob_sve_simpa2"
end type

event sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			: W_Tm_Sa_Sinistre::Dw_Stk_W_Cour_Blob_Sve
//* Evénement		: SqlPreview
//* Auteur			: Fabry JF
//* Date				: 17/03/2004 16:10:01
//* Libellé			: 
//* Commentaires	: On envoie les commandes sur la table W_COUR_BLOB
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*														
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

String		sSqlPreview
Long			lLig
DwBuffer		dwBuf

//Migration PB8-WYNIWYG-03/2006 CP
//sSqlPreview = This.GetSQLPreview ( )
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 CP

/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion ou d'une  */
/* Suppression                                                      */
/*------------------------------------------------------------------*/
Choose Case Left ( sSqlPreview, 4 )
Case	"INSE" 

	//Migration PB8-WYNIWYG-03/2006 CP
	//	This.GetUpdateStatus ( lLig, dwBuf )	
	lLig  = row
	dwBuf = buffer
	//Fin Migration PB8-WYNIWYG-03/2006 CP



	sSQLPreview = 	"EXECUTE sysadm.DW_I01_W_COUR_BLOB "  										+	&
						F_GetItem2 ( Dw_Stk_W_Cour_Blob_Sve, lLig, "ID_SIN" )			+ "," +	&
						F_GetItem2 ( Dw_Stk_W_Cour_Blob_Sve, lLig, "ID_I" )			+ "," +	&
						F_GetItem2 ( Dw_Stk_W_Cour_Blob_Sve, lLig, "ID_CPT" )			+ "," +	&
						F_GetItem2 ( Dw_Stk_W_Cour_Blob_Sve, lLig, "ID_TYP_BLOB" )	+ "," +	&
						F_GetItem2 ( Dw_Stk_W_Cour_Blob_Sve, lLig, "ID_TYP_DOC" )	+ "," +	&
						F_GetItem2 ( Dw_Stk_W_Cour_Blob_Sve, lLig, "CREE_LE" )		+ "," +	&
						F_GetItem2 ( Dw_Stk_W_Cour_Blob_Sve, lLig, "MAJ_LE" )			+ "," +	&
						F_GetItem2 ( Dw_Stk_W_Cour_Blob_Sve, lLig, "MAJ_PAR" )

	Dw_Stk_W_Cour_Blob_Sve.SetSQLPreview ( sSqlPreview )
/*------------------------------------------------------------------*/
/* Logiquement, il ne doit jamais y avoir de DELETE.                */
/*------------------------------------------------------------------*/
End Choose

end event

type dddw_typedoc from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 2304
integer y = 1796
integer width = 242
integer height = 100
integer taborder = 60
boolean bringtotop = true
boolean enabled = false
string dataobject = "dddw_spb_code"
end type

type lb_fichier from listbox within w_tm_sp_sinistre
boolean visible = false
integer x = 530
integer y = 784
integer width = 201
integer height = 144
integer taborder = 150
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type dw_choixcourgen from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 1719
integer y = 1796
integer width = 242
integer height = 100
integer taborder = 200
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_stk_choix_regen_courrier_sim2"
end type

type dw_compo from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 1422
integer y = 1796
integer width = 242
integer height = 100
integer taborder = 210
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sve_lst_paragraphe"
end type

type pb_validation_dossier from u_8_pbvalider within w_tm_sp_sinistre
boolean visible = false
integer x = 251
integer y = 8
integer width = 471
integer height = 136
integer taborder = 340
boolean enabled = false
string text = "&Valider le dossier"
boolean originalsize = false
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::Pb_Validation_Dossier::Clicked! (OVERRIDE)
//* Evenement 		: Clicked! (OVERRIDE)
//* Auteur			: Erick John Stark
//* Date				: 05/11/1998 11:01:22
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR	Date			Modification
//* #1	JCA	08/03/2007	DCMP 070161 - Amelioration process DNT - Autorisation de validation avec réglement
//* #2   JFF   03/04/2007  DCMP 070161 - Modif JF suite erreur d'analyse, il est mieux de tester le "MT_A_REGLER > 0"
//*													 Afind e prendre en compte les frais interlocuteurs
//* #3 	FPI	08/10/2009	[DCMP90595] Ajout du btn valid_factu
//*-----------------------------------------------------------------

Boolean	bRet, bVal
Long		lCodEtat, lIdTypArch
String	sNoBoite, sVal

// #1
string sRech
long lTotDetail, lLigDet
// FIN - #1

// #2
Boolean bMtAReg
// Fin #2
Integer iRet	// #3

bRet = True
This.Enabled = False

/*------------------------------------------------------------------*/
/* Le gestionnaire a-t-il le droit de valider des dossiers pour ce  */
/* produits.                                                        */
/*------------------------------------------------------------------*/
If ibSaisieValidation Then
	iuoGsSpSinistre.uf_GetAutorisation ( "", sVal, bVal, bVal, bRet, -1 )
	If Not bRet Then
		stMessage.sTitre		= "Vous n'êtes pas autorisé."
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= False
		stMessage.sCode		= "SVE0020"
	   stMessage.sVar [1]	= String ( dw_1.GetItemNumber ( 1, "ID_PROD" ) )

		F_Message ( stMessage )
	End If
	
	// #1
	// si au moins 1 detail est dans l'etat "à régler" (CodEtat = 500)
	// si refus de validation avec réglement 
/* #8
	lTotDetail	= dw_wDetail.RowCount ()
	sRech = "COD_ETAT = 500"
	lLigDet = dw_wDetail.Find ( sRech, 1, lTotDetail )
	Fin #8
*/
// #3
bMtAReg = dw_1.GetItemDecimal ( 1, "MT_A_REG" ) > 0 
// Fin #3

/* #3	lLigDet > 0 and &  Remplacé dans le test par bMtAReg */ 
	If	bRet and &
		bMtAReg and &
		Mid (sVal, 17, 1 ) = '0' Then
	
		stMessage.sTitre		= "Gestion des sinistres - SIMPA2"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= false
		stMessage.sCode		= "WSIN520"
	
		F_Message ( stMessage )
	
		bRet = false
	End If
	// FIN - #1

End If

/*------------------------------------------------------------------*/
/* DGA. Le 21/08/2003.                                              */
/* Gestion des boites archives.                                     */
/*------------------------------------------------------------------*/
If	bRet And dw_BoiteArchive.RowCount () > 0	Then
	lIdTypArch	= dw_BoiteArchive.GetItemNumber ( 1, "ID_TYP_ARCH" )
	sNoBoite		= dw_BoiteArchive.GetItemString ( 1, "NO_BOITE" )
	lCodEtat		= dw_1.GetItemNumber ( 1, "COD_ETAT" )

	If	lIdTypArch = 1	And ( lCodEtat = 600 Or lCodEtat = 500 Or lCodEtat = 200 Or lCodEtat = 900 ) And ( IsNull ( sNoBoite ) Or Len ( Trim ( sNoBoite ) ) = 0 )	Then
		stMessage.sTitre		= "Validation Finale d'un dossier"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= False
		stMessage.sCode		= "BARC025"
	   stMessage.bTrace  	= False

		F_Message ( stMessage )
		bRet = False
	End If
End If

If bRet Then
		/*------------------------------------------------------------------*/
		/* Le 15/12/1998:                                                   */
		/* Le gestionnaire va voir s'afficher un message de confirmation    */
		/* de validation.                                                   */
		/*------------------------------------------------------------------*/
	stMessage.sTitre			= "Confirmation de la validation du sinistre"
	stMessage.Bouton			= OkCancel!
	stMessage.Icon				= Question!
	stMessage.bErreurG		= FALSE
	stMessage.sCode			= "CONF007"
	stMessage.iDefautBouton	= 2

	// #3 - [DCMP90595]
	iRet=1
	If Not iuogsspsinistre.uf_getautorisation2( 208) Then
		iRet=F_Message ( stMessage )
	End if
	
//	If	F_Message ( stMessage )	= 1	Then
	If iRet = 1 Then
	// Fin #3 - [DCMP90595]
		SetPointer ( HourGlass! )

		Parent.TriggerEvent ( "Ue_DisableFenetre" )

		Parent.TriggerEvent ( "Ue_Valider_Dossier" )

		Parent.TriggerEvent ( "Ue_EnableFenetre" )
	End If
End If

end event

type dw_div_pro from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 1125
integer y = 1796
integer width = 242
integer height = 100
integer taborder = 190
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_lst_div_pro"
end type

type dw_w_div_sin from u_datawindow within w_tm_sp_sinistre
integer x = 1189
integer y = 320
integer width = 329
integer height = 276
integer taborder = 10
string dataobject = "d_lst_w_div_sin"
boolean vscrollbar = true
boolean border = false
boolean livescroll = false
end type

event itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::dw_w_Diw_Sin
//* Evenement 		: ItemError
//* Auteur			: Fabry JF
//* Date				: 17/06/2004 09:47:59
//* Libellé			: 
//* Commentaires	: Gestion des messages d'erreur
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   20/06/2006   DCMP060480 
//* #2  	 JFF	 29/08/2007	  [DCMP070587] - Charte souplesse SFR
//* #3	 PHG	 09/08/2008	  [DCMP080625] Désactivation Controle 
//*									Marque/modele Obligatoire
//* #4 	 JFF   03/11/2008   [FNAC_PROD_ECH_TECH]
//* #5 	 JFF   12/01/2006   [FNAC_PROD_ECH_TECH].[20090112170517890]
//*  	    JFF	 13/04/2010   [WEBSIM2].[FRANCE]
//* 		 JFF	 03/06/2010   [DCMP100397] Numéro de facture Attitude
//* 		 JFF   04/11/2010   [PC301].[LOT2]
//*       JFF   21/12/2010   [PC301][VESTUSTE]
//        JFF   02/04/2011   [PC694][SFR2012]
//		    FPI	 14/06/2012	  [PC512-2]
//        JFF   06/08/2012   [BLCODE]
//        JFF   14/11/2012   [VDOC9376]
//		FPI	13/08/2013	[DT058]
//       JFF   28/05/2014 [PC786-1_AUCHAN_GEM]
//		FPI	01/07/2014	[DT031-2]
//       JFF   30/07/2014 [PM234-4_V1]
//       JFF   29/09/2014 [DT081-1_AUTORISATION]
//       JFF   31/03/2015 [DT081-4]
//			FPI	19/08/2015	[DT167]
//       JFF   02/11/2016 [DT276]
//       JFF   12/12/2016 [DT269]
//       JFF   15/05/2017 [PC13321-3]
//       JFF   05/03/2018 [VDOC25738]
//       JFF   16/10/2018 [PC171999]
//       JFF   28/02/2019 [VDOC27557]
//       JFF   23/06/2020 [PC202553_SELECTRA]
//       JFF   26/09/2023 [RS5928_FRCH_CHQ]
//       JFF   05/08/2024 [MCO602_PNEU]
//       JFF   18/11/2024 [KSV649_ORREUCARA]
//*-----------------------------------------------------------------

Choose Case isErrCol

	Case "VAL_LST_CAR"
		Choose Case This.iiErreur

			// NOM_ZONE = TYPE_APP
			Case 1
				stMessage.sTitre		= "Modification du type d'appareil"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN450"  // Impossible de modifier le type d'appareil, la marque, le modèle, ...
			Case 2
				stMessage.sTitre		= "Modification du type d'appareil"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN460" // Pour ce produit, le CODIC DARTY permet de déterminer ...

			Case 3  // #1
				stMessage.sTitre		= "Choix de l'opérateur"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN495" // Impossible de modifier l'opérateur dès qu'une commande est présente sur le dossier.@@Si l'état de la commande le permet, supprimez cette dernière et modifier ensuite l'opérateur.

	// [PC301].[LOT2]
			Case 4  // #1
				stMessage.sTitre		= "Choix entrepôt" // Variante
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN699" // Impossible de modifier l'opérateur dès qu'une commande est présente sur le dossier.@@Si l'état de la commande le permet, supprimez cette dernière et modifier ensuite l'opérateur.
	// [PC301].[LOT2]

// [PC694][SFR2012]
			Case 5  // #1
				stMessage.sTitre		= "Modification de la classe" // Variante
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN722" 
// [PC694][SFR2012]

			Case 6  // #1 [VDOC9376]
				stMessage.sTitre		= "Recondionné/Neuf"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN733" // Une commande est présente sur le dossier, il vous est impossible de modifier cette zone.

			Case 7  // [PC801_V10]
				stMessage.sTitre		= "Mode Paiement PayBox"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN739" 

			Case 8 // [DT167]
				stMessage.sTitre		= "Modification du type d'appareil"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN791" // Cet appareil est désormais interdit de déclaration sur ce produit.
				
				If this.GetItemString( row, "VAL_LST_CAR") = data Then this.iireset=1
				

			Case 9 // [DT269]
				stMessage.sTitre		= "Modification du type d'appareil"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN809 " // Modification interdite dès qu'il existe une prestation.
				
				If this.GetItemString( row, "VAL_LST_CAR") = data Then this.iireset=1			


			// [VDOC25738]
			Case 10
				stMessage.sTitre		= "Modification du type d'appareil acheté"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN452"  // Impossible de modifier le type d'appareil, la marque, le modèle, ...

			// [PC171999]
			Case 11
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN831"  // L'état de votre sinistre ne permet plus cette modification.

			// [RS5928_FRCH_CHQ]
			Case 12
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN897"  // L'état de votre sinistre ne permet plus cette modification.

			Case 13  // #1
				stMessage.sTitre		= "Type de prestation "
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN905" // Une prestation de commande ou un règlement est présent sur le dossier, il vous est impossible de modifier le type de prestation.
			
			
			Case Else
				stMessage.sTitre		= "Gestion des sinistres - SIMPA2"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= TRUE
				stMessage.sCode	= "GENE016"  // Saisie Incorrecte
		End Choose

	Case "VAL_CAR"
		Choose Case This.iiErreur

			// NOM_ZONE = TYPE_APP
// [DCMP100397] 
			Case 1	// Veuillez saisir un numéro de facture FNAC/ATTITUDE valide (voyez avec votre RE).
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN694"
// :[DCMP100397] 

			Case Else
				stMessage.sTitre		= "Gestion des sinistres - SIMPA2"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= TRUE
				stMessage.sCode	= "GENE016"  // Saisie Incorrecte
		End Choose

	Case "VAL_LST_NBRE"
		Choose Case This.iiErreur

			// #2
			Case 2   // Pas les droits
				stMessage.sTitre		= "Décision assureur"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sVar[1]		= "211"
				stMessage.sCode		= "WDET500"

			// #2
			Case 3  // Dec déjà prise
				stMessage.sTitre		= "Décision assureur"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN604"

			// #2
			Case 4  // Saisie annulée
				stMessage.sTitre		= "Décision assureur"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN606"
				
			Case 5
				// #4 [FNAC_PROD_ECH_TECH]
				stMessage.sTitre		= "Mode de remplacement"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN630"  // Impossible de modifier le type d'appareil, la marque, le modèle, ...

			Case 6
				// #5 [FNAC_PROD_ECH_TECH].[20090112170517890]
				stMessage.sTitre		= "Mode de remplacement"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN631"  
			
			Case 7 // [DT058]
				stMessage.sTitre		= "Accord Chubb"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN754"  
				
			// [KSV649_ORREUCARA]
			Case 8 // Manque donnée pour ctrle IMEI API
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN908"		
			
			// [KSV649_ORREUCARA]
			Case 9 // Etat actuel ne permet pas de modifier
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN925"		
				
		End Choose

	Case "VAL_ALT"
		Choose Case iiErreur
			Case 1
				stMessage.sTitre		= "Regénération de mot de passe"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "COMD435"
				
			case 2 //#3 [DCMP080625] Demande de controle IMEI Impossible si marque ou modèle non renseigné.
				stMessage.sTitre		= "Demande de Controle IMEI"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN422"

			case 3, 6 //#4 [FNAC_PROD_ECH_TECH][BLCODE]
				stMessage.sTitre		= "Accessoires"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN625"

// [WEBSIM2].[FRANCE]
			Case 4
				stMessage.sTitre		= "Regénération de mot de passe"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "COMD621"				
// :[WEBSIM2].[FRANCE]
				
			//[PC512-2]
			Case 5
				stMessage.sTitre		= "Récupération de données"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN728"				

				
			Case 7
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN762"		
			
			// [PC786-1_AUCHAN_GEM]
			Case 8
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN772"		
			
			// [PM234-4_V1]
			Case 9
				stMessage.sTitre		= "Vous n'avez pas les droits"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "P234018"		

			// [DT081-1_CREDIMM]
			Case 10
				stMessage.sTitre		= "Récrédit impossible"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN776"		
				
			// [DT081-1_CREDIMM]
			Case 11
				stMessage.sTitre		= "Récrédit impossible"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN777"		

			// [DT081-1_AUTORISATION]
			Case 12
				stMessage.sTitre		= "Vous n'avez pas les droits (DT081-1 V2)"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN782"
				
			
			// [DT276]
			Case 13	// Cette donnée ne peut plus être modifiée.
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN807"				
					
			// [PC13321-3]
			Case 14	// Cette donnée ne peut plus être modifiée.
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN814"				
								
			// [PC13321-3]
			Case 15	// Cette donnée ne peut plus être modifiée.
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN815"				

			// [VDOC27557]
			Case 16	// Réserver au DR.
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN838"				

			// [PC202553_SELECTRA]
			Case 17	// Cette donnée ne peut pas être modifiée.
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "GENE185"				

			// [KSV649_ORREUCARA]
			Case 18	// Manque donnée pour ctrle IMEI API
				stMessage.sTitre		= "Données absentes"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN907"	
				
		End Choose		
		
	Case "VAL_DTE"
		Choose Case iiErreur
			Case 1
				stMessage.sTitre		= "Date non valide"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= TRUE
				stMessage.Bouton		= OK!
				stMessage.sVar[1]		= "date du ticket"
				stMessage.sVar[2]		= "antérieure ou égale"
				stMessage.sVar[3]		= "date de survenance"
				stMessage.sCode		= "GENE007"

			Case 2
				stMessage.sTitre		= "Date non valide"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= TRUE
				stMessage.Bouton		= OK!
				stMessage.sVar[1]		= "date du ticket"
				stMessage.sVar[2]		= "antérieure ou égale"
				stMessage.sVar[3]		= "date de déclaration"
				stMessage.sCode		= "GENE007"

			Case 3
				stMessage.sTitre		= "Date non valide"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= TRUE
				stMessage.Bouton		= OK!
				stMessage.sVar[1]		= "date du ticket"
				stMessage.sVar[2]		= "antérieure ou égale"
				stMessage.sVar[3]		= "date du jour"
				stMessage.sCode		= "GENE007"

			Case 4
				stMessage.sTitre		= "Date dernière utilisation"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "GENE013" // [DT031-2] - TODO : revoir le message
				stMessage.sVar[1]		= "Interdit de modifier la date de dernière utilisation si une action est engagée auprès de l'assuré (règlement, refus, commande)." 
				
				
			//	[DT081-4]
			Case 5
				stMessage.sTitre		= "Date manuelle de restitution de prêt"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDSN001" 
		
			
			Case Else
				stMessage.sTitre		= "Date non valide"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sVar[1]		= "date"
				stMessage.sCode		= "GENE002"

			End Choose 

	Case "VAL_NBRE"
		Choose Case iiErreur
			Case 1  // Durée de GC d'origine non saisissable
				stMessage.sTitre		= "Durée garantie constructeur"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WSIN570"
				
			// [PC301][VESTUSTE]
			Case 2  // Durée de GC d'origine non saisissable
				stMessage.sTitre		= "Durée garantie constructeur"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET310"
				
		End Choose


	Case Else

		stMessage.sTitre		= "Gestion des sinistres - SIMPA2"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= TRUE
		stMessage.sCode	= "GENE016"

End Choose	

// [KSV649_ORREUCARA]
If Not This.ibPasDeMessage Then
	F_Message ( stMessage )
End If 

This.ibPasDeMessage = False // [KSV649_ORREUCARA]

//Migration PB8-WYNIWYG-03/2006 FM
//This.Uf_Reinitialiser ()
Return This.Uf_Reinitialiser ()
//Fin Migration PB8-WYNIWYG-03/2006 FM




end event

event rowfocuschanged;call super::rowfocuschanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::dw_w_Div_Sin
//* Evenement 		: RowFocusChanged
//* Auteur			: Fabry JF
//* Date				: 17/06/2004 09:35:04
//* Libellé			: 
//* Commentaires	: Changement de zone 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Si on est en Saisie, on lance le traitement des zones.           */
/*------------------------------------------------------------------*/

If	isTypeTrt = "S" Then
//	[MIGPB8COR] - JCA - 18/04/2006 - Remplace CurrentRow par GetRow() 
//Migration PB8-WYNIWYG-03/2006 FM

	iuoGsSpSinistre.uf_GestOng_Divers_DDDW ( This.GetText (), Upper ( This.GetColumnName () ) , This.GetRow () )
//	iuoGsSpSinistre.uf_GestOng_Divers_DDDW ( This.GetText (), Upper ( This.GetColumnName () ) , CurrentRow )

//Fin Migration PB8-WYNIWYG-03/2006 FM
End If


end event

event itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::dw_w_Div_Sin
//* Evenement 		: ItemChanged
//* Auteur			: Fabry JF
//* Date				: 17/06/2004 09:35:04
//* Libellé			: 
//* Commentaires	: Modification des zones
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Si on est en Saisie, on lance le traitement des zones.           */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

If	isTypeTrt = "S" Then
//Migration PB8-WYNIWYG-03/2006 FM
//	iuoGsSpSinistre.Uf_Zn_Trt_DivSin ( This.GetText (), Upper ( isNomCol) , This.GetRow (), This.GetItemString (This.GetRow (), "NOM_ZONE" ) )
	ll_ret = iuoGsSpSinistre.Uf_Zn_Trt_DivSin ( This.GetText (), Upper ( isNomCol) , This.GetRow (), This.GetItemString (This.GetRow (), "NOM_ZONE" ) )
//Fin Migration PB8-WYNIWYG-03/2006 FM
End If

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret

//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on losefocus;call u_datawindow::losefocus;//*-----------------------------------------------------------------
//*
//* Objet         : dw_w_Div_Sin
//* Evenement     : LoseFocus
//* Auteur        : Fabry JF
//* Date          : 17/06/2004 16:09:21
//* Libellé       : 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------


 dw_w_Div_Sin.AcceptText () 
end on

event itemfocuschanged;call super::itemfocuschanged;//Migration PB8-WYNIWYG-03/2006 FM
//le script du RowFocusChanged est recopié et adapté ici
//(mauvais nom de colonne au 1er passage)
If	isTypeTrt = "S" and row > 0 Then
//	iuoGsSpSinistre.uf_GestOng_Divers_DDDW ( This.GetText (), Upper ( This.GetColumnName () ) , This.GetRow () )
	iuoGsSpSinistre.uf_GestOng_Divers_DDDW ( This.GetText (), Upper ( dwo.name ) , Row )
End If
//Fin Migration PB8-WYNIWYG-03/2006 FM


end event

event sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			: Dw_w_div_sin
//* Evenement 		: SqlPreview
//* Auteur			: FPI
//* Date				: 24/12/2010
//* Libellé			: [23122010.FPI]
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*       JFF   13/12/2010   [DECIMAL_PAPILLON]
//*-----------------------------------------------------------------

String	sSqlPreview

Long lLig, LTot, lCpt
Long ll_return

Long dcIdSin
DateTime	dtCreeLe, dtMajLe,dtvaldte
String sNomZone,  sliblabel, sidtypliste, saltlistecodecar, sidtypzone
String	 saltoblig, saltprot,svalcar,smajpar
Integer icpttri
Long lvalnbre
Decimal dcvalmt
		
dwBuffer		dwBuf

sSqlPreview = SQLSyntax

/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion ou d'une  */
/* Suppression                                                      */
/*------------------------------------------------------------------*/

lLig  = row
dwBuf = buffer

Choose Case Left ( sSqlPreview, 4 )
Case "UPDA"
	
	sqlsyntax = F_Critere_Decimal ( sqlsyntax )

	// Variante pour ce cas, le nom_zone est une string donc je retire le point de fin
	sqlsyntax = Left ( Trim ( sqlsyntax), Len ( Trim (sqlsyntax )) - 1 ) + " "
	This.SetSqlPreview ( sqlsyntax ) 
Case	"INSE"

	dcIdSin			= This.GetItemNumber ( lLig,	"ID_SIN"					)
	sNomZone		= This.GetItemString ( lLig,	"NOM_ZONE"				)

	sliblabel			= This.GetItemString ( lLig,	"LIB_LABEL"					)
	sidtypliste		= This.GetItemString ( lLig,	"ID_TYP_LISTE"			)
	saltlistecodecar	= This.GetItemString ( lLig,	"ALT_LISTE_CODECAR"	)
	sidtypzone		= This.GetItemString ( lLig,	"ID_TYP_ZONE"			)
	saltoblig			= This.GetItemString ( lLig,	"ALT_OBLIG"				)
	saltprot			= This.GetItemString ( lLig,	"ALT_PROT"					)
	icpttri				= This.GetItemNumber ( lLig,	"CPT_TRI"				)
	lvalnbre			= This.GetItemNumber ( lLig,	"VAL_NBRE"				)
	dcvalmt			= This.GetItemDecimal ( lLig,	"VAL_MT"				)
	dtvaldte			= This.GetItemDateTime ( lLig,	"VAL_DTE"		)			// [PI056].20190926
	svalcar			= This.GetItemString ( lLig,	"VAL_CAR"					)
	dtcreele			= This.GetItemDateTime ( lLig,	"CREE_LE"				)
	dtmajle			= This.GetItemDateTime ( lLig,	"MAJ_LE"				)
	smajpar			= This.GetItemString ( lLig,	"MAJ_PAR"				)
	 
	itrTrans.DW_I01_W_DIV_SIN( dcidsin, snomzone, &
		 sliblabel, sidtypliste, saltlistecodecar, sidtypzone,  &
		 saltoblig, saltprot, icpttri,  &
		 lvalnbre, dcvalmt, dtvaldte, svalcar, &
		 dtcreele,  dtmajle, smajpar )

	If itrTrans.SqlCode <> 0	Then

		ll_return = 1
		
	Else

		ll_return = 2
		
	End If

Case	"DELE"

	dcIdSin		= This.GetItemNumber ( lLig,	"ID_SIN",		DELETE!, False		)
	sNomZone =  This.GetItemString ( lLig,	"NOM_ZONE",	DELETE!, False		)
	
	itrTrans.DW_D01_W_DIV_SIN ( dcIdSin,  sNomZone )

	If itrTrans.SqlCode <> 0	Then

		ll_return = 1

	Else

		ll_return = 2

	End If

End Choose

Return ll_return

end event

type cb_polass from commandbutton within w_tm_sp_sinistre
integer x = 1413
integer y = 8
integer width = 274
integer height = 68
integer taborder = 530
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pol. - Ass."
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Fonction      : W_Tm_Sp_Sinistre::Click
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 08/07/2004 17:27:47
//* Libellé       : 
//* Commentaires  : Ajout du bouton pour affichage polices et 
//*						assurances des gti du produit du dr DCMP 030381
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//* #1	 FPI	 26/10/2009	[EXPANSION5.LIB_POLICE] Ajout du param id_boutique_adh
//*-----------------------------------------------------------------

s_Pass	stPass
Long 		lDeb, lFin

stPass.dwNorm [ 1 ] = dw_garantie
stPass.dwNorm [ 2 ] = dw_police
stPass.dwTab [ 1 ] = dw_lst_gti
stPass.lTab [ 1 ] = Parent.X
stPass.lTab [ 2 ] = Parent.Y
stPass.sTab [ 1 ] = "T"

// #1 - [EXPANSION5.LIB_POLICE]
F_Rechdetpro(lDeb, lFin,dw_det_pro, &
	dw_1.getItemNumber( 1, "ID_PROD"),"-DP",124)
	
If lDeb > 0 Then
	// On effectuera la récupération du lib_police dans boutique
	stPass.sTab [ 2 ] = 'O' 
End if
// Fin #1 - [EXPANSION5.LIB_POLICE]

OpenWithParm ( w_t_sp_popup_pol_ass,  stPass)

end event

type dddw_codecar_wdivsin_charg_tempo from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 827
integer y = 1792
integer width = 242
integer height = 100
integer taborder = 170
boolean bringtotop = true
boolean enabled = false
string dataobject = "dddw_sp_code_car"
end type

type dddw_code_wdivsin_charg_tempo from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 521
integer y = 1792
integer width = 242
integer height = 100
integer taborder = 180
boolean bringtotop = true
boolean enabled = false
string dataobject = "dddw_spb_code"
end type

type dw_code_equivalence from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 229
integer y = 1788
integer width = 242
integer height = 100
integer taborder = 140
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_lst_code_equivalence"
end type

type dw_stk_ifr from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 3205
integer y = 1912
integer width = 238
integer height = 92
integer taborder = 230
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_stk_ifr"
end type

type dddw_ifr_marque from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 2903
integer y = 1912
integer width = 238
integer height = 92
integer taborder = 290
boolean bringtotop = true
boolean enabled = false
string dataobject = "dddw_ifr_marque"
end type

type dw_code_mb from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 2304
integer y = 1912
integer width = 247
integer height = 96
integer taborder = 160
boolean bringtotop = true
boolean enabled = false
string dataobject = "dddw_spb_code"
end type

type dddw_ifr_modele from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 2619
integer y = 1912
integer width = 238
integer height = 92
integer taborder = 280
boolean bringtotop = true
boolean enabled = false
string dataobject = "dddw_ifr_modele"
end type

type cb_categ from commandbutton within w_tm_sp_sinistre
integer x = 1893
integer y = 8
integer width = 274
integer height = 68
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Catg Cour."
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Fonction      : W_Tm_Sp_Sinistre::Click
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 11/10/2004
//* Libellé       : 
//* Commentaires  : Ajout du bouton pour affichage catégorie des
//*						courriers : DCMP 040366
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

s_Pass	stPass


stPass.trTrans = itrTrans
stPass.dwNorm [ 1 ] = dddw_TypeDoc
stPass.dwNorm [ 2 ] = dw_WCourrier
stPass.dwTab [ 1 ] = dw_Lst_Inter
stPass.lTab [ 1 ] = dw_1.GetItemNumber ( 1, "ID_SIN" )

OpenWithParm ( w_t_sp_categ_cour,  stPass)
end on

type cb_excel from u_aidecontrat within w_tm_sp_sinistre
integer x = 1413
integer y = 76
integer width = 274
integer height = 68
integer taborder = 90
boolean bringtotop = true
end type

type dddw_dty_modele from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 2002
integer y = 1916
integer width = 238
integer height = 92
integer taborder = 270
boolean bringtotop = true
boolean enabled = false
string dataobject = "dddw_dty_modele"
end type

type dddw_dty_marque from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 1728
integer y = 1916
integer width = 238
integer height = 92
integer taborder = 260
boolean bringtotop = true
boolean enabled = false
string dataobject = "dddw_dty_marque"
end type

type dw_code_rf from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 1426
integer y = 1912
integer width = 247
integer height = 96
integer taborder = 250
boolean bringtotop = true
boolean enabled = false
string dataobject = "dddw_sp_code_car"
end type

type dw_stk_codic_darty from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 1120
integer y = 1912
integer width = 238
integer height = 92
integer taborder = 240
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_stk_codic_darty"
end type

type dw_div_pdet from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 827
integer y = 1916
integer width = 242
integer height = 88
integer taborder = 130
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_lst_div_pdet"
end type

type dw_w_div_det from u_datawindow_detail within w_tm_sp_sinistre
boolean visible = false
integer x = 521
integer y = 1916
integer width = 251
integer height = 88
integer taborder = 20
boolean enabled = false
string dataobject = "d_lst_w_div_det"
boolean livescroll = false
end type

event sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::dw_wdiv_det::SqlPreview
//* Evenement 		: SqlPreview
//* Auteur			: FPI
//* Date				: 24/12/2010
//* Libellé			: [23122010.FPI]
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*       JFF   13/12/2010   [DECIMAL_PAPILLON]
//*-----------------------------------------------------------------

String	sSqlPreview

Long lLig, LTot, lCpt
Long ll_return

Long dcIdSin, dcIdGti, dcIdDetail
DateTime	dtCreeLe, dtMajLe, dtvaldte
String sNomZone,  sliblabel, sidtypliste, saltlistecodecar, sidtypzone
String	 saltoblig, saltprot,svalcar,smajpar
Integer icpttri
Long lvalnbre
Decimal dcvalmt
		
dwBuffer		dwBuf

sSqlPreview = SQLSyntax

/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion ou d'une  */
/* Suppression                                                      */
/*------------------------------------------------------------------*/

lLig  = row
dwBuf = buffer

Choose Case Left ( sSqlPreview, 4 )
Case "UPDA"

	sqlsyntax = F_Critere_Decimal ( sqlsyntax )

	// Variante pour ce cas, le nom_zone est une string donc je retire le point de fin
	sqlsyntax = Left ( Trim ( sqlsyntax), Len ( Trim (sqlsyntax )) - 1 ) + " "
	This.SetSqlPreview ( sqlsyntax ) 
Case	"INSE"

	dcIdSin			= This.GetItemNumber ( lLig,	"ID_SIN"					)
	dcIdGti			= This.GetItemNumber ( lLig,	"ID_GTI"					)
	dcIdDetail		= This.GetItemNumber ( lLig,	"ID_DETAIL"			)
	sNomZone		= This.GetItemString ( lLig,	"NOM_ZONE"				)

	sliblabel			= This.GetItemString ( lLig,	"LIB_LABEL"					)
	sidtypliste		= This.GetItemString ( lLig,	"ID_TYP_LISTE"			)
	saltlistecodecar	= This.GetItemString ( lLig,	"ALT_LISTE_CODECAR"	)
	sidtypzone		= This.GetItemString ( lLig,	"ID_TYP_ZONE"			)
	saltoblig			= This.GetItemString ( lLig,	"ALT_OBLIG"				)
	saltprot			= This.GetItemString ( lLig,	"ALT_PROT"					)
	icpttri				= This.GetItemNumber ( lLig,	"CPT_TRI"				)
	lvalnbre			= This.GetItemNumber ( lLig,	"VAL_NBRE"				)
	dcvalmt			= This.GetItemDecimal ( lLig,	"VAL_MT"				)
	dtvaldte			=  This.GetItemDateTime ( lLig,	"VAL_DTE"		)		// [PI056].20190926
	svalcar			= This.GetItemString ( lLig,	"VAL_CAR"					)
	dtcreele			= This.GetItemDateTime ( lLig,	"CREE_LE"				)
	dtmajle			= This.GetItemDateTime ( lLig,	"MAJ_LE"				)
	smajpar			= This.GetItemString ( lLig,	"MAJ_PAR"				)
	 
	itrTrans.DW_I01_W_DIV_DET( dcidsin, dcidgti, dciddetail, snomzone, &
		 sliblabel, sidtypliste, saltlistecodecar, sidtypzone,  &
		 saltoblig, saltprot, icpttri,  &
		 lvalnbre, dcvalmt, dtvaldte, svalcar, &
		 dtcreele,  dtmajle, smajpar )

	If itrTrans.SqlCode <> 0	Then

		ll_return = 1
		
	Else

		ll_return = 2
		
	End If

Case	"DELE"

	dcIdSin		= This.GetItemNumber ( lLig,	"ID_SIN",		DELETE!, False		)
	dcIdGti		= This.GetItemNumber ( lLig,	"ID_GTI",		DELETE!, False		)
	dcIdDetail	= This.GetItemNumber ( lLig,	"ID_DETAIL",	DELETE!, False		)
	sNomZone =  This.GetItemString ( lLig,	"NOM_ZONE",	DELETE!, False		)
	
	itrTrans.DW_D01_W_DIV_DET ( dcIdSin, dcIdGti, dcIdDetail, sNomZone )

	If itrTrans.SqlCode <> 0	Then

		ll_return = 1

	Else

		ll_return = 2

	End If

End Choose

Return ll_return

end event

type cb_valid_factu from commandbutton within w_tm_sp_sinistre
integer x = 1961
integer y = 480
integer width = 599
integer height = 136
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Validation &Facturation"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_tm_sp_w_gar_sin:cb_valid_factu
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 06/10/2009 11:47:43
//* Libellé			: 
//* Commentaires	: [DCMP090595]
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

cb_valid_factu.Enabled = FALSE

if istypetrt="S" Then 
	pb_controler.TriggerEvent(clicked!)

	if pb_valider.Enabled=TRUE Then
		pb_valider.Enabled=FALSE
		pb_controler.Enabled=FALSE
		pb_valider.TriggerEvent(clicked!)
	End if
Else
	pb_validation_dossier.TriggerEvent(clicked!)
End if
end event

type dw_dossuivipar from u_datawindow within w_tm_sp_sinistre
integer x = 2414
integer width = 1198
integer height = 88
integer taborder = 330
string dataobject = "dddw_sp_wkf_dosuivipar"
boolean border = false
boolean livescroll = false
end type

on losefocus;call u_datawindow::losefocus;This.AcceptText ()
end on

event itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Fonction		: ItemChanged
//* Auteur			: Fabry JF
//* Date				: 05/01/1998 18:25:09
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: Rien
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------

DataWindowChild dwChild
String	sData

//Migration PB8-WYNIWYG-03/2006 CP
Long ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP

sData = Upper ( This.GetText () )
This.GetChild ( "DOS_SUIVI_PAR", dwChild ) 

If dwChild.Find ( "COD_OPER = '" + sData + "'", 1, dwChild.Rowcount () ) <= 0 And Not IsNull ( sData ) Then

//Migration PB8-WYNIWYG-03/2006 CP
//	SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		
	
End If

//Migration PB8-WYNIWYG-03/2006 CP
//
		Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP		



end event

event itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Fonction		: ItemError
//* Auteur			: Fabry JF
//* Date				: 05/01/1998 18:25:09
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: Rien
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------


stMessage.sTitre		= "Dossier à traiter par"
stMessage.Icon			= Information!
stMessage.sCode		= "CONT019"
stMessage.bErreurG	= False

f_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 CP
//SetActionCode ( 1 )
		Return 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		

end event

event constructor;call super::constructor;ilPremCol = 0
ilDernCol = 0
end event

event sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			: Dw_DosSuiviPar
//* Evenement 		: SqlPreview
//* Auteur			: FABRY JF
//* Date				: 13/12/2010 
//* Libellé			: Suite bug relevé par Arian Papillon, j'ajoute un "." pour 
//*					  transformer en décimal
//* Commentaires	: [DECIMAL_PAPILLON]
//*				 
//* Arguments		: 
//*
//* Retourne		: NotFound
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF   13/12/2010   [DECIMAL_PAPILLON]
//* 
//*-----------------------------------------------------------------

Choose Case Left ( sqlsyntax, 4 )

	Case "UPDA"
		sqlsyntax = F_Critere_Decimal ( sqlsyntax )
		This.SetSqlPreview ( sqlsyntax ) 			
		
End Choose

end event

type st_mode_reprise from statictext within w_tm_sp_sinistre
integer x = 2459
integer y = 152
integer width = 800
integer height = 96
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 255
string text = "MODE REPRISE DE BASE MANUELLE"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_aide_mode_reprise from commandbutton within w_tm_sp_sinistre
integer x = 3273
integer y = 152
integer width = 251
integer height = 100
integer taborder = 470
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Aide !!"
end type

event clicked;//*
//* Fonction		: Clicked
//* Auteur			: JFF
//* Date				: 23/05/2012
//* Libellé			: 
//* Commentaires	: [PM103]
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------


stMessage.sTitre		= "Mode reprise de base manuelle"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.bouton		= Ok!
stMessage.sCode		= "WSIN723"
F_Message ( stMessage )

end event

type cb_aide_base_manuelle from commandbutton within w_tm_sp_sinistre
integer x = 1687
integer y = 76
integer width = 480
integer height = 68
integer taborder = 530
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aide Base Manuelle"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Fonction      : W_Tm_Sp_Sinistre::Click
//* Auteur        : FPI
//* Date          : 01/06/2012
//* Libellé       : 
//* Commentaires  : [PM103]
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*-----------------------------------------------------------------

wf_afficher_doc("A_PM103.doc","Aide base manuelle")
end event

type cb_journal from commandbutton within w_tm_sp_sinistre
integer x = 1687
integer y = 8
integer width = 210
integer height = 68
integer taborder = 11
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Journal"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Fonction      : W_Tm_Sp_Sinistre::Click
//* Auteur        : Fabry JF
//* Date          : 07/05/2019
//* Libellé       : 
//* Commentaires  : 
//*						
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

s_Pass	stPass

stPass.lTab [ 1 ] = dw_1.GetItemNumber ( 1, "ID_PROD" )

OpenWithParm ( w_t_sp_journal,  stPass)
end event

type uo_consult_euro from u_consultation_euro within w_tm_sp_sinistre
integer x = 1221
integer y = 8
integer taborder = 520
end type

on ue_changer_monnaie;call u_consultation_euro::ue_changer_monnaie;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::Uo_Consult_Euro::Ue_Changer_Monnaie
//* Evenement 		: Ue_Changer_Monnaie
//* Auteur			: Erick John Stark
//* Date				: 05/12/1997 17:25:29
//* Libellé			: 
//* Commentaires	: On positionne les bonnes valeurs dans le TreeView
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String sMonnaie

sMonnaie = This.uf_Recuperer_Monnaie_Courante ()
Parent.wf_Enabled_Fenetre ( sMonnaie )
end on

on uo_consult_euro.destroy
call u_consultation_euro::destroy
end on

type st_pause_api_lab from statictext within w_tm_sp_sinistre
boolean visible = false
integer x = 2958
integer y = 640
integer width = 338
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 15780518
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_wreg_frais_annexe_frn from datawindow within w_tm_sp_sinistre
boolean visible = false
integer x = 3570
integer y = 1240
integer width = 224
integer height = 104
integer taborder = 160
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_w_reg_frais_annexe_frn"
end type

event sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::dw_wreg_frais_annexe_frn::SqlPreview
//* Evenement 		: SqlPreview
//* Auteur			: FABRY JF
//* Date				: 07/10/2022
//* Libellé			: [PM80_FA12_FRANEX]
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date			Modification
//*-----------------------------------------------------------------

String	sSqlPreview, sMajPar

Long dcIdSin, dcIdI, dcIdGti, dcIdDetail
Decimal {2} dcMtIndemPrinc_1, dcMtFraisAnex_2, dcMtFraisAnex_3, dcMtFraisAnex_4, dcMtFraisAnex_5, dcMtFraisAnex_6, dcMtFraisAnex_7, dcMtFraisAnex_8, dcMtFraisAnex_9, dcMtFraisAnex_10, dcMtFraisAnex_11
Long lLig
Long ll_return
dwBuffer		dwBuf

//Migration PB8-WYNIWYG-03/2006 CP
//sSqlPreview = This.GetSqlPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 CP

/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion.          */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On insére toujours un ID_REG à 0. Cette valeur sera armée au     */
/* moment de la validation, dans les procédures stockées de         */
/* SqlServer.                                                       */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//This.GetUpdateStatus ( lLig, dwBuf )
lLig  = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 CP

Choose Case Left ( sSqlPreview, 4 )
Case	"INSE"

	dcIdSin			= This.GetItemNumber ( lLig,	"ID_SIN"					)
	dcIdI				= This.GetItemNumber ( lLig,	"ID_I"					)
	dcIdGti			= This.GetItemNumber ( lLig,	"ID_GTI"					)
	dcIdDetail		= This.GetItemNumber ( lLig,	"ID_DETAIL"				)

	dcMtIndemPrinc_1 = This.GetItemDecimal ( lLig, "MtIndemPrinc_1")
	dcMtFraisAnex_2 = This.GetItemDecimal ( lLig, "MtFraisAnex_2")
	dcMtFraisAnex_3 = This.GetItemDecimal ( lLig, "MtFraisAnex_3")
	dcMtFraisAnex_4 = This.GetItemDecimal ( lLig, "MtFraisAnex_4")
	dcMtFraisAnex_5 = This.GetItemDecimal ( lLig, "MtFraisAnex_5")
	dcMtFraisAnex_6 = This.GetItemDecimal ( lLig, "MtFraisAnex_6")
	dcMtFraisAnex_7 = This.GetItemDecimal ( lLig, "MtFraisAnex_7")
	dcMtFraisAnex_8 = This.GetItemDecimal ( lLig, "MtFraisAnex_8")
	dcMtFraisAnex_9 = This.GetItemDecimal ( lLig, "MtFraisAnex_9")
	dcMtFraisAnex_10 = This.GetItemDecimal ( lLig, "MtFraisAnex_10")
	dcMtFraisAnex_11 = This.GetItemDecimal ( lLig, "MtFraisAnex_11")

	sMajPar			= stGLB.sCodOper

	itrTrans.PS_DI_W_REG_FRAIS_ANNEXE_FRN_V01 ( &
											dcIdSin, &
											dcIdI, &
											dcIdGti, &
											dcIdDetail, &
											dcMtIndemPrinc_1, &  
											dcMtFraisAnex_2, &
											dcMtFraisAnex_3, &
											dcMtFraisAnex_4, &
											dcMtFraisAnex_5, &
											dcMtFraisAnex_6, &
											dcMtFraisAnex_7, &
											dcMtFraisAnex_8, &
											dcMtFraisAnex_9, &
											dcMtFraisAnex_10, &
											dcMtFraisAnex_11, &
											sMajPar)

	If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	Else

//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 2 )
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
	End If

// [DECIMAL_PAPILLON]
Case "UPDA" // Update
	sqlsyntax = F_Critere_Decimal ( sqlsyntax )
	This.SetSqlPreview ( sqlsyntax ) 

End Choose

//Migration PB8-WYNIWYG-03/2006 CP
//
		Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP		

end event

type st_attente_diverse from statictext within w_tm_sp_sinistre
boolean visible = false
integer x = 2958
integer y = 748
integer width = 338
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 15780518
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

