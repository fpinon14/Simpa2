$PBExportHeader$n_cst_w_commande3.sru
$PBExportComments$Objet liés à la fenêtre Commande3
forward
global type n_cst_w_commande3 from u_gs_sp_sinistre_anc
end type
end forward

global type n_cst_w_commande3 from u_gs_sp_sinistre_anc
end type
global n_cst_w_commande3 n_cst_w_commande3

type variables
Public :
u_sp_ifr_pilote		iuoEqvFct
Boolean			ibModifAdrInterdite // [HP252_276_HUB_PRESTA]

Private :

u_DataWindow		idwDetail
u_DataWindow		idwWsin
u_DataWindow		idwWDivsin
u_DataWindow      idwLstDetail // [BLCODE]

u_DataWindow_Detail	idwCmde
u_DataWindow_Detail	idwCmdeSin
u_DataWindow_Detail	idwCmdeGti
u_DataWindow_Detail	idwCmdeDet
u_DataWindow_Detail	idwLstInter
u_DataWindow_Detail	idwwDivDet			
u_DataWindow_Detail	idwDivDetGti  // [BLCODE]


DataWindow		idwFourn
DataWindow		idwTypArt
DataWindow		idwArticle
DataWindow		idwArticlePrs
DataWindow		idwBandeau
DataWindow		idwPlafond
DataWindow		idwProduit
DataWindow		idwInfoCmde
DataWindow		idwCmdTypFrn
DataWindow		idwCmdTypArt
DataWindow		idwCommune   // DCMP030362
DataWindow		idwTacImei
DataWindow		idwStkIfr, idwCodeEquiv
DataWindow		idwAutorisation 
DataWindow		idwWpieceGti // [FNAC_PROD_ECH_TECH].[20090224144248310]

// JFF   04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
StaticText		istAltPec

Boolean			ibPlusInfo
Boolean			ibInsCmdeCEG	// DCMP 030161
Boolean			ibControlerSaisie    // à True : On est dans le controlerSaisie.
Boolean			ibAuMoins1_Cetelec // Boolean pour gestion particulère CETELEC/ARVATO
Boolean			ibAuMoins1_Arvato // Boolean pour gestion particulère ARVATO
Boolean			ibAltCommune   // DCMP 030362 Gestion des commune O/N
Boolean			ibMesInfoAff   // Message info affiché
Boolean                               ibToutMob     //Boolean pour gestion du bouton Tout Mobile
Boolean                               ibPbleParamFrn     //Boolean probleme param fournisseur
Boolean			ibAMUTrace1     // AMU fois le déclenchement de la trace_1 sur cette grille de cmde.
Boolean			ibDecocherPresta, ibReouvPresta // [MSS_LOT2]
Boolean			ibAMUTrace1Btq  // [WEBSIM2].[FRANCE] AMU fois le déclenchement de la trace_1 sur cette grille de cmde.
Boolean			ibPasDeSaisieProbleme // [PC321]
Boolean			ibIPHONE_absent // [ITSM107966]
Boolean			ibDecocherPrestaO2M, ibReouvPrestaO2M // [VDOC8041]
Boolean			ibChoixCIS_ASS	// [PC869]
Boolean			ibAltPec // [VDOC12142]
Boolean			ibAMU_MajContr // [PC13442_MOBZEN2]
Boolean			ibvDoc18588_KoProxiPSM_GoToO2M // [VDOC18588]
Boolean			ibBrisEcran // [DT447]

Long			ilNbCmde
Long			ilCptOrdre
Long			ilMarquaGeBLCODE // [BLCODE]
Long 			ilProcessTempo // [PC938_ORANGE_V3]
Long 			ilNbreTourExistantMobile // [DT145_V4]

String			isDept // [DCMP090327].[SBETV]
String			isNumIMEIAdh
String			isNumIMEIAdhOrigine   // DCMP 030407
String			isMarqPortAdh
String			isModlPortAdh
String			isFiltreArtDetPro	// DCMP 030129 (liste des mobiles orange)
String			isChoixAction  // C ou S our R
String			isMobileUnique
String			isTypApp    // Type App sinistré
String			isCasGestionDartyNomade
String			isFourRepartPC // [DCMP080500]
String			isInfoSpbFrnCplt // [FNAC_PROD_ECH_TECH]
String			isInfoSpbFrnCpltTempo // [PC938_ORANGE_V3]
String			isFournParDefaut // [DCMP090327].[SBETV]
String 			isCas2FluxMS1 // [MSS_LOT2]
String			isCodeBoutiqueCentralPSM // [PM200][PSM]
String			isCodeBoutiqueProximitePSM // [PM200][PSM]
String			isCodeBoutiqueRelaiPSM // [PC938_ORANGE_V3]
String			isPrcBLCODE // [BLCODE]
String 			isTabAdrPSMTempo [] // [PC938_ORANGE_V3]
String 			isAdrCivPickUp, isAdrNomPickUp, isAdrPreNomPickUp, isAdr1PickUp, isAdr2PickUp, isAdrCpltPickUp, isAdrVillePickUp, isAdrCpPickUp, isCodePickUp
String			isBtqPsmProxiSav // [ITSM282197]

// idcMtPlafcmdeWeb = Plafond maxi pour la commande sur extrant
// 3 valeurs possibles : 
//		1 : -1 = Aucun plafond
//		2 : -2 = Interdiction de commander
//    3 : >0 = Plafond max
Decimal {2} 	idcMtPlafcmdeWeb 
Decimal {2} 	idcMtPec, idcMtForfait

// soapconnection isoapcnx // FPI	25/07/2024 [MIG_PB2022] - SoapConnection Obsolète
end variables

forward prototypes
public subroutine uf_preparerinserer (ref s_pass astpass)
public subroutine uf_infoarticle (string asdw, string ascas)
private subroutine uf_initcmdeclient ()
public function string uf_controlersaisie ()
private function string uf_formatage_cp (string astext)
private function string uf_formatage_heure (string astext)
private function string uf_formatage_email (string astext)
public function string uf_controlergestion ()
public function boolean uf_preparervalider ()
private function integer uf_copierligne (string asswitch, long alligdwnivinf, string ascle, u_datawindow_detail adwsup, u_datawindow_detail adwinf)
private function integer uf_preparervalider_commande ()
public subroutine uf_rowfocuschanged (string asdw)
private subroutine uf_initcasparticulier ()
private function integer uf_zn_probleme (ref datawindow adw, string asdata, long alrow)
private subroutine uf_modifier_icone_sfr ()
private subroutine uf_zn_adrcp (string asval)
private subroutine uf_tb_sfr ()
private subroutine uf_caspartcegetel (string asidfour)
private subroutine uf_armementgmecat (long alrow)
private subroutine uf_initcasparticuliertel ()
public subroutine uf_switch_ctrlsaisie (boolean abSwitch)
private subroutine uf_caspart_prestation ()
private function integer uf_zn_marque (ref datawindow adw, string asdata, long alrow)
private subroutine uf_controlersaisie_commune (ref string aspos)
private subroutine uf_controlersaisie_tacimei (ref string aspos)
private function integer uf_zn_idserieanc (ref datawindow adw, string asdata, long alrow)
private subroutine uf_epuration_zonecommune (ref string asville, ref integer aicode)
private subroutine uf_selectionautomatique ()
private function string uf_type_evenement ()
private function string uf_controlergestion_prs_fournmarqmob (string asidfour, string asidtypart, string asidmarqart)
public function string uf_controlersaisieselection ()
public function string uf_controlergestionselection ()
private subroutine uf_gestionzone_infospbfrn (long alrowchoix, ref datawindow adw)
private subroutine uf_controlersaisie_zn_infospbfrn (long alcpt, ref string asmesserr)
private function integer uf_zn_rib (ref datawindow adw, string asdata, long alrow)
private function string uf_controlergestion_sbe (long alcpt)
private subroutine uf_preparervalider_inter ()
private function integer uf_nouveau_num_sequence ()
private function string uf_controlergestion_mss (long alcpt)
public subroutine uf_initialiser (ref s_pass astpass, ref u_sp_ifr_pilote auoequivfct)
public subroutine uf_zn_cocher_equiv_fct ()
private subroutine uf_correspondance_ifr_frn ()
private function string uf_controlergestion_darty_tel (long alcpt)
private function string uf_controlergestion_darty_nomade (long alcpt)
public function string uf_controlergestionedi ()
private function string uf_controlergestionedi_cdiscount (long alcpt)
public function string uf_controlersaisieedi ()
private subroutine uf_preparer_articletype_edi ()
private subroutine uf_preparervalider_cdiscount ()
public function boolean uf_tracetoutmobile ()
private function integer uf_zn_codmodereg (ref datawindow adw, string asdata, long alrow)
public function long uf_controlerzone (string asdw, string asnomcol, string asdata, long alrow)
public function long uf_gerermessage (string asdw)
private function string uf_controlergestion_cordon (long alcpt)
private function string uf_controlergestion_wbx (long alcpt)
private subroutine uf_armementplafond (string ascas)
private subroutine uf_controlersaisie_cp (ref string aspos)
private subroutine uf_preparervalider_dern_maj_plaf ()
private subroutine uf_initialiser2 ()
private function string uf_controlergestionedi_o2m (long alcpt)
private subroutine uf_preparervalider_o2m ()
private subroutine uf_selectionautomatique_dtynom_sanspropo ()
private function string uf_controlergestion_scf (long alcpt)
private function string uf_selectionautomatique_dtynom_avecpropo ()
private subroutine uf_epurationautretypeart ()
private function string uf_controlergestion_fnac (long alcpt)
private function string uf_controlergestion_o2m (long alcpt)
public subroutine uf_initpardefaut (integer aicas)
private function string uf_controlergestionedi_sbetv (long alcpt)
public subroutine uf_message_process_sbetv (long alrow, long alinfospbfrn)
private subroutine uf_gestionzone_infospbfrn_sbetv_1100 (ref n_cst_attrib_key alnv_key[], ref long aldefaut, ref boolean abrdvaprendre)
private subroutine uf_gestionzone_infospbfrn_mssdiag_1200 (ref n_cst_attrib_key alnv_key[], ref long aldefaut, ref boolean abrdvaprendre)
public subroutine uf_message_process_mssdiag (long alrow, long alinfospbfrn)
private function string uf_controlergestionedi_mssdiag (long alcpt)
private subroutine uf_selectionautomatique_standard_sansppo (string asidfour, string asfiltre)
private function string uf_selectionautomatique_standard_avecppo (string asidfour, string asfiltre)
private function string uf_controlergestion_ms1 (long alcpt)
private function string uf_gestionzone_infospbfrn_mssdiag_1200_2 (ref long alstatusgcactuel, ref long alinfospbfrnorig)
private subroutine uf_gestionzone_infospbfrn_mssdiag_1200_3 (string ascas2flux, ref long aldefaut, ref boolean abrdvaprendre, long alstatusgcactuel, long alinfospbfrnorig)
private subroutine uf_protegerzone (string ascas, integer aiprotection)
private function boolean uf_preparervalider_majpresta ()
public function boolean uf_getautorisation (long aliddroit)
public subroutine uf_epuration_probleme ()
private function string uf_controlergestion_auchan (long alcpt)
private subroutine uf_chgt_fourn_fct_dp148 (long alidprod, ref string asfourmodif)
private function string uf_controlergestion_carrefourlad (long alcpt)
private subroutine uf_preparervalider_selectioncourrier ()
private function string uf_controlergestion_axa (long alcpt)
private function string uf_controlergestion_mobistore (long alcpt)
protected subroutine uf_gestionzone_infospbfrn_caspart (long alrowchoix, ref datawindow adw, ref string asfiltre, ref long aldefaut, ref long alidliste)
private subroutine uf_gestionzone_infospbfrn_o2m_900 (ref n_cst_attrib_key alnv_key[], ref long aldefaut, ref boolean abrdvaprendre)
private function string uf_controlergestion_psm (long alcpt)
private function boolean uf_preparervalider_game ()
private subroutine uf_gestionzone_infospbfrn_blc_900 (ref n_cst_attrib_key alnv_key[], ref long aldefaut, ref boolean abrdvaprendre)
public subroutine uf_message_process_blc (long alrow, long alinfospbfrn)
private subroutine uf_chgt_fourn_fct_mobile (integer aicas)
private function boolean uf_preparervalider_majprestao2m ()
private function string uf_controlergestion_coriolis (long alcpt)
private subroutine uf_gestionzone_infospbfrn_psm_2100 (ref n_cst_attrib_key alnv_key[], ref long aldefaut, ref boolean abrdvaprendre)
private function string uf_zn_choix_regle_psm (string ascas)
private subroutine uf_selectionautomatique_pret_standard ()
private subroutine uf_gestionzone_infospbfrn_o2m_prs (ref long aldefaut)
private subroutine uf_preparervalider_presta_suppl (string ascasprestasuppl, long alrow)
private subroutine uf_selectionautomatique_restit_pret_ant ()
private subroutine uf_selectionautomatique_recup_app_sin ()
private function string uf_controlergestionedi_psm (long alcpt)
public subroutine uf_message_process_psm (long alrow, long alinfospbfrn)
private function string uf_controlergestion_sbetv (long alcpt)
public subroutine uf_message_process_o2m (long alrow, long alinfospbfrn)
public function string uf_epure_zone (ref string asvaleur)
public subroutine uf_q_ios7 ()
protected function integer uf_zn_choix (ref datawindow adw, string asdata, long alrow)
private function integer uf_zn_infospbfrn (ref datawindow adw, string asdata, long alrow)
private function string uf_controlergestion_cegetel (long alcpt)
private function string uf_controlergestion_tamet (long alcpt)
private subroutine uf_gestionzone_infospbfrn_tamet_2500 (ref n_cst_attrib_key alnv_key[], ref long aldefaut, ref boolean abrdvaprendre)
public subroutine uf_deconnecter_equiv_fct (string ascas)
private subroutine uf_existance_mobile ()
private function string uf_controlergestion_rueducommerce (long alcpt)
private function string uf_controlergestion_cdiscountpro (long alcpt)
public function integer uf_get_btqpsm_centralisation (long alidprod, long alidsin, long alidevt, string asaction, ref string ascodebtqcentral)
public function string uf_gestion_relaipickup ()
private function string uf_controlergestion_cma (long alcpt)
private subroutine uf_selectionautomatique_id_ref_four (string asidreffour)
private function string uf_controlergestion_centreautoleclerc (long alcpt)
private function string uf_controlergestion_eko_net_dgc (long alcpt)
private function string uf_zn_choix_process_cmde_orangev3 (datawindow adw, long alrow, string astypart, string asaction)
public subroutine uf_check_boutique_psm (psm_psmdataresponse ureponse)
private function string uf_controlergestion_aas (long alcpt)
private function string uf_controlergestion_bak2 (long alcpt)
private function string uf_controlergestion_ceat (long alcpt)
private function integer uf_zn_adrcodciv (ref datawindow adw, string asdata, long alrow)
private function string uf_controlergestion_hub (long alcpt)
private function integer uf_zn_choix_regle_hub (string ascas, long alidprod, long alidsin, long alidgti, long aliddetail, integer airet, datawindow adw, ref long alrow)
end prototypes

public subroutine uf_preparerinserer (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_PreparerInserer (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 19/09/2001
//* Libellé			: Prepare l'insertion
//* Commentaires	: 
//*
//* Arguments		: astPass			s_Pass		Ref
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 CAG	 25/11/2002	  Modification SFR Preference : suite aux tests avant
//*								  mise en prod, rapatriement du n° imei du sinistre
//*								  pour tous les mobiles dispo à la commande
//* #2	 CAG   25/02/2003	  DCMP 030129 : Liste des mobiles Orange : Ajout de la zone
//*									id_ref_four dans le fichier envoyé par Cetelec pour
//*									identifier les mobiles spécifiques d'Orange (même ref
//*									marque et modèle que les autres avec des prix différents) +
//*									#ORANGE# dans la zone comment_frn
//* #3	 CAG	 10/09/2003	  Ajout du frn DDF pr Orange => filtre décrit ds #2 DCMP 030129
//*								  seulement si le fournisseur est CETELEC
//* #4	 JFF	 23/01/2003   DCMP 040026 : On Shunte la Sélection Auto
//* #5    JFF   21/06/2006   DCMP 060480 : Filtre des articles chargé sur -DP/56
//* #6    JFF	 06/02/2006  [SITE_CMDE] Gestion des nouvelles option d'autorisation 79, 80, 81
//* #7    JFF   04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
//* #8	 JFF   18/09/2007  [ALAPAGE]
//* #9    JFF   28/11/2007  [DCMP070701]
//* #10	 JFF	 09/06/2008  [DCMP070798]
//* #11   JFF   02/09/2009  [DCMP090327].[SBETV]
//* #12   JFF   09/12/2009  [20091209134657110] LEs 20 premiers car seulement
//* #13   JFF   09/12/2009  [20091209155130520] Erreur de copier/coller
//* #14   JFF   02/03/2010  [MSS_LOT2]
//*  	    JFF	 13/04/2010  [WEBSIM2].[FRANCE]
//*		 PHG	 02/07/2010	 [DCMP100420] On enlève la limitation à 20 de NUmIMEIAdh
//*       JFF   27/07/2010  [PC321]
//		FPI	30/09/2011	[VDoc5406] Message d'info GRTV
// 		 JFF   13/02/2012   [PM200][PSM]
//        JFF   14/11/2012   [VDOC9376]
//        JFF   04/02/2012   [PC662_VDOC9376_M6646]
//       JFF   07/05/2013 [PC938_ORANGE_V3]
//       JFF   26/08/2013 [DT57_CMDE_IPHONE_SFR]
// 		JFF   19/09/2013 [VDOC12142] 
// 		FPI	27/09/2013	[VDoc12269]
//			FPI	16/05/2014  [VDOC14351]
//       JFF   06/01/2015 [DT124]
//       JFF   19/02/2015 [ITSM274801]
//       JFF   09/04/2015 [DT141]
//       JFF   03/06/2015 [DT145_V4]
//       JFF   16/07/2015 [VDOC18218]
//		FPI	19/08/2015	[REPAR_GTI] - pour une réparation on n'active pas la page d'équiv fonct
//       JFF   03/09/2015 [VDOC18588]
//       JFF   19/01/2015 [VDOC19697]
//        JFF  17/05/2016 	  [PM280-2]
//       JFF   23/05/2017 [DT145-2]
//       JFF   12/09/2017 [PC151259-3]
//       JFF   20/11/2017 [PC171933][V4]
//       JFF   08/11/2018 [BUG_PRS] obligé de rejour le This.Uf_RowfocusChanged ( "DWFOURN" ) sinon la preste de réparation n'apparait pas.
//       JFF   18/12/2018 [PM471-1]
//       JFF   17/09/2019 [DT447]
//*-----------------------------------------------------------------
Long		lDeb, lFin, lRow, lTot, lCpt, lVal, lIdGti, lRowMtPec, lRow2, lIdProd, lQteDisp, lIdEVt, lCpt2, lTot2, lIdCie
String	sFiltre, sDteProdEqvFc, sFiltreFrn, sSortOrig, sSav, sFiltreTempo // #5
String   sChaine, sVal, sVal2, sLibCie
Integer	iPos, iPos1, iPos2
Boolean	bTrouve, bEQFDecx, bDT57, bCasAppleSfrSbe, bCasAppleCmdeChezSfrSuite176Sbe
Boolean  bCasAppleChoixDmeAvantO2m, bCasAppleChoixO2mSuiteDME176
n_cst_string	lnv_string
Long lIdSin, lIdRev


isCodeBoutiqueCentralPSM = "" // [PM200][PSM]
isCodeBoutiqueProximitePSM = "" // [PM200][PSM]
isCodeBoutiqueRelaiPSM = "" // [PC938_ORANGE_V3]
ibIPHONE_absent = FALSE // [ITSM107966]
ibToutMob = False
ibPlusInfo = False
ibPbleParamFrn = False
ibAMUTrace1 = False
ibAMUTrace1Btq = False // [WEBSIM2].[FRANCE] 
isInfoSpbFrncplt = ""
ilNbCmde 	  = 0
// [MSS_LOT2]
ibDecocherPresta = FALSE 
ibReouvPresta = False
ibDecocherPrestaO2M = FALSE
ibReouvPrestaO2M = FALSE
ibChoixCIS_ASS = False // [PC869]
gProcessTempoOrangeV3Action = False  //  [PC938_ORANGE_V3]
bDT57 = False
idcMtPec = 0 // [ITSM274801]
isBtqPsmProxiSav = "" // [ITSM282197]
ilNbreTourExistantMobile = 0 // [DT145_V4]
ibvDoc18588_KoProxiPSM_GoToO2M = False  // [VDOC18588]
ibModifAdrInterdite = False // [HP252_276_HUB_PRESTA]

lIdSin = idwWsin.GetItemNumber ( 1, "ID_SIN" )
lIdRev = idwWsin.GetItemNumber ( 1, "ID_REV" )
lIdGti = idwDetail.GetItemNumber ( 1, "ID_GTI" ) // [DT57_CMDE_IPHONE_SFR]
lIdProd = idwProduit.GetItemNumber ( 1, "ID_PROD" ) 

ibBrisEcran = astPass.bTab [3] // [DT447]

This.Uf_ProtegerZone ( "MAJ_DIAG_2FLUX", 0 )
isCas2FluxMS1 = ""
// [MSS_LOT2]
ibPasDeSaisieProbleme = FALSE // [PC321]

// #12 [20091209134657110]
// [DCMP100420] Annulation de #12 [20091209134657110]
isNumIMEIAdh  = astPass.sTab [1]
isNumIMEIAdh=uf_epure_zone( isNumIMEIAdh) // [VDoc12269]
// :#12 [20091209134657110]

lIdEvt = idwDetail.GetItemNumber ( 1, "ID_EVT" ) // [PM200][LOT2][DESOX]

isMarqPortAdh = astPass.sTab [2]
isModlPortAdh = astPass.sTab [3]

// #12 [20091209134657110]
// [DCMP100420] Annulation du left à 20 de ( #12 [20091209134657110] )
isNumIMEIAdhOrigine = astPass.sTab [4]

isNumIMEIAdhOrigine=uf_epure_zone( isNumIMEIAdhOrigine) // [VDoc12269]

// #13 [20091209155130520]
// isNumIMEIAdhOrigine = Left ( astPass.sTab [1], 20 )
// isNumIMEIAdhOrigine = Left ( astPass.sTab [4], 20 )
// :#12 [20091209134657110]

isChoixAction = astPass.sTab [5]
isCasGestionDartyNomade = astPass.sTab [6]
idcMtPlafcmdeWeb = -1  // #6 voir les cas de valeurs possibles sur la déclaration de l'instance
isDept="" // #11 [DCMP090327].[SBETV]


ilCptOrdre = 0
isMobileUnique = ""
isFournParDefaut = "" // #11 [DCMP090327].[SBETV]

// #7
istAltPec.Visible = idwwDivDet.Find ( "ID_GTI = " + String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) ) + &
												  " AND ID_DETAIL = " +  String ( idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
												  " AND UPPER ( NOM_ZONE ) = 'ALT_PEC' " + &
												  " AND UPPER ( VAL_LST_CAR ) = 'O'" &
											  , 1, idwwDivDet.RowCount () ) > 0

// [VDOC12142]
ibAltPec = istAltPec.Visible 

// [VDOC18218]
// [ITSM274801]
lRowMtPec = idwwDivDet.Find ( "ID_GTI = " + String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) ) + &
						  " AND ID_DETAIL = " +  String ( idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
						  " AND UPPER ( NOM_ZONE ) = 'MT_PEC' " &
					  , 1, idwwDivDet.RowCount () ) 

// Lecture du montant						  
If lRowMtPec > 0 Then
	idcMtPec = idwwDivDet.GetItemDecimal ( lRowMtPec, "VAL_MT" )
End if 	
// [ITSM274801]

// [DT141] 
lRow =  idwCmdeSin.Find ( "ID_FOUR = 'SBE' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT IN ( 'RPC', 'RFO' ) AND STATUS_GC > 0", 1, idwCmdeSin.RowCount() )
lRow2 = idwCmdeSin.Find ( "ID_FOUR = 'SBE' AND ID_REF_FOUR = 'CMDE_A_CPLTER' AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount() )	
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 275 )
bCasAppleSfrSbe = ( lRow > 0 OR lIdGti = 10 ) And lRow2 <= 0 And lDeb > 0 And isMarqPortAdh = "APPLE"

lRow2 = idwCmdeSin.Find ( "ID_FOUR = 'SBE' AND ID_REF_FOUR = 'CMDE_A_CPLTER' AND COD_ETAT IN ( 'RPC', 'RFO') AND STATUS_GC = 176", 1, idwCmdeSin.RowCount() )	
bCasAppleCmdeChezSfrSuite176Sbe = ( lRow > 0 OR lIdGti = 10 ) And lRow2 > 0 And lDeb > 0 And isMarqPortAdh = "APPLE"

// [DT145_V4]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 279 )
lRow =  idwCmdeSin.Find ( "ID_FOUR = 'DME' AND POS ( 'ID_MARQ_ART_IFR', 'IPHONE' ) > 0" , 1, idwCmdeSin.RowCount() )

// [DT145-2]
bCasAppleChoixDmeAvantO2m = lRow <= 0 And lDeb > 0 

//[DT145_V4][MANTIS17246][ITSM45260]
If Not bCasAppleChoixDmeAvantO2m Then
	// [DT145-2]
	bCasAppleChoixDmeAvantO2m = lDeb > 0 
End If

// [DT145-2]
If Not bCasAppleChoixDmeAvantO2m Then
	bCasAppleChoixDmeAvantO2m = lDeb > 0 
End If

If Not bCasAppleChoixDmeAvantO2m Then
	// [DT145-2]
	lRow =  idwCmdeSin.Find ( "ID_FOUR = 'DME' AND COD_ETAT IN ( 'ANN' ) " , 1, idwCmdeSin.RowCount() )
	bCasAppleChoixO2mSuiteDME176 = lRow > 0 And lDeb > 0 
End If

/*------------------------------------------------------------------*/
/* Recherche du type d'appareil sinistré.                           */
/*------------------------------------------------------------------*/
lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, idwWDivSin.RowCount () ) 
If lRow > 0 Then 
	isTypApp = Upper ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) )
	If IsNull ( isTypApp ) Then
		isTypApp = "AUT" 
	End If
End If

// [BUG_FORFAIT2]
// [DT141] 
idcMtForfait = 0
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 110)

If lDeb > 0 Then
	lDeb = idw_DetPro.Find ( "ID_CODE_CAR = '" + isTypApp + "'", lDeb, lFin ) 
End If

If lDeb > 0 Then
	idcMtForfait = Dec ( lnv_string.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "FORFAIT", ";") )
End If
// :[BUG_FORFAIT2]

/*------------------------------------------------------------------*/
/* Objet équivalence visible uniquement dans certains cas.          */
/*------------------------------------------------------------------*/
//* #10	[DCMP070798] Ajout PC2
Choose Case isTypApp 
	Case "TEL", "PC2"
		iuoEqvFct.Show ()
	Case Else
		iuoEqvFct.Hide ()
End Choose 

// [REPAR_GTI]
if isChoixaction="R" Then iuoEqvFct.Hide ()
// :[REPAR_GTI]

// #5
// DP/56 : Utilisation du filtre fournisseur
sFiltreFrn = stNul.str

// [PM471-1]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 56 )
If lDeb > 0 Then
	lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'CHOIX_PACK'", 1, idwWDivSin.RowCount () ) 
	If lRow > 0 Then
		sFiltreFrn = idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" )
		sFiltreFrn = "[#" + sFiltreFrn + "#]"
		lnv_string.of_setkeyvalue( sChaine, "CHOIX_PACK", sFiltreFrn, ";")			
	End If
End If
// Fin #5

// [VDOC9376]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 226 )
If lDeb > 0 Then
	lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'TYPAPP_REC_NEU'", 1, idwWDivSin.RowCount () ) 
	If lRow > 0 Then
		sFiltreTempo = idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" )
		sFiltreTempo = "[#" + sFiltreTempo + "#]"
		
		lnv_string.of_setkeyvalue( sChaine, "NEUF_REC", sFiltreTempo, ";")						
		
		// [PC662_VDOC9376_M6646]
		lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "NEUF_REC", sFiltreTempo , ";")
	
	End If
End If
// [VDOC9376]	

F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 331 )
If lDeb > 0 Then
	lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'CHOIX_GRADE'", 1, idwWDivSin.RowCount () ) 
	If lRow > 0 Then
		sVal = idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" )
		sVal = F_Remplace ( sVal, "GR", "GR#" ) 
		sVal = "[#" + sVal + "#]"
		lnv_string.of_setkeyvalue( sChaine, "CHOIX_GRADE", sVal, ";")			
	End If
End If
	

// [DT124]
lnv_string.of_setkeyvalue( sChaine, "MARQUE", isMarqPortAdh, ";")
lnv_string.of_setkeyvalue( sChaine, "MODELE", isModlPortAdh, ";")
// [DT124]

/*------------------------------------------------------------------*/
/* Retrieve des articles à chaque ouverture de la fenêtre, afin de  */
/* bénéfichier                                                      */
/* des infos les récentes possibles au niveau des stocks et des     */
/* articles.                                                        */
/*------------------------------------------------------------------*/
sFiltre = idwArticle.Describe ( "DataWindow.Table.Filter" )
//Migration PB8-WYNIWYG-03/2006 FM
If sFiltre = '?' then sFiltre = ''
//Fin Migration PB8-WYNIWYG-03/2006 FM
idwArticle.SetFilter ( "" )
idwArticle.Filter ()

// gestion standard
// [PM471-1]
// Pour la désact, renommer et supprimer l'ancien DO.
idwArticle.DataObject = "d_article1_v02"

This. Uf_Initialiser2 ()

// [DT141] 
If bCasAppleSfrSbe Then sChaine = stNul.str
	
// [DT124] sChaine
// [PM471-1]
idwArticle.Retrieve ( idwWSin.GetItemNumber ( 1, "ID_PROD" ), sChaine )
// :#8

// [DT386_EXTR_AXA]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 337 ) 
If lDeb > 0 Then 
	lRow = idw_DetPro.Find ( "ID_CODE_NUM = " + String ( lIdGti ), lDeb, lFin ) 
	If lRow > 0 Then
		sVal = idw_DetPro.GetItemString ( lRow, "VAL_CAR" )
		sVal = lnv_String.of_getkeyvalue ( sVal, "EDI_CONSERVER", ";")
	
		idwArticle.SetFilter ( "ID_TYP_ART = 'EDI' AND POS ( '" + sVal + "', '#' + ID_REF_FOUR + '#' ) <= 0" ) 
		idwArticle.Filter ( ) 
		idwArticle.RowsDiscard ( 1, idwArticle.RowCount (), Primary!)
		idwArticle.SetFilter ( "" ) 
		idwArticle.Filter ( ) 
		idwArticle.Sort ( ) 
	End If 
End If 

// [PC151259-3] [PC171933][V4]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 252 )

If lDeb > 0 Then
// [PC151259-2] // [PC171918] // [PC171933]
	sVal = lnv_String.of_getkeyvalue ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")
	sVal2 = lnv_String.of_getkeyvalue ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "FAMILLE", ";")
	
	If sVal = "ADVISE_6" And sVal2 = "HTE" Then sVal = "FULL_SERENITY_ADV_5"
	
	Choose Case sVal 
		Case "FULL_SERENITY_ADV_5", "ADVISE_7"
			// Ok on laisse
		Case Else
			lDeb = 0
	End Choose 

End If 


If lDeb <= 0 Then
	// Si l'on n'est pas dans ADVISE on supprime le stock O2M dédié à ADVISE
	idwArticle.SetFilter ( "ID_FOUR = 'O2M' AND POS ( OBSERV_FRN, '[#1F5#]' ) > 0" )
	idwArticle.Filter ()
	idwArticle.RowsDiscard ( 1, idwArticle.RowCount (), Primary!)
	idwArticle.SetFilter ( "" )
	idwArticle.Filter ()
End If

// [PM471-1]
// La restriction assureur, supprime tous les appareils tague [#RSASS#...#] si l'assureur ne correspond pas
sLibCie = Fill ( " ", 35 ) 
SQLCA.PS_S_LIB_CIE_V01 ( lIdSin, lIdRev, lIdGti, lIdCie, sLibCie )

If sLibCie <> "" Then
	lTot = idwArticle.RowCount ()
	For lCpt2 = lTot To 1 Step -1
		sVal2 = idwArticle.GetItemString ( lCpt2, "OBSERV_FRN" )
		If Pos ( sVal2, "[#RSASS#" ) <= 0 Then Continue
		
		iPos1 = Pos ( sVal2, "[#RSASS#" )
		iPos2 = Pos ( sVal2, "#]", iPos1 )
		sVal2 = Mid ( sVal2, iPos1 + 8, iPos2 - ( iPos1 + 8 ) ) 
		
		If Pos ( sLibCie, sVal2 ) <= 0 Then
			idwArticle.RowsDisCard ( lCpt2, lCpt2, primary!  )
		End IF 
		
	Next 
End If

// #9 Epuration des doublons (sur même frn ou frn différent)
sSortOrig = idwArticle.Describe ( "DataWindow.Table.Sort" )
If sSortOrig = "?" then sSortOrig = ""
idwArticle.SetSort ( "ID_MARQ_IFR A, ID_MODL_IFR A, MT_PRIX_HT D" )
idwArticle.Sort ()


lTot = idwArticle.RowCount ()
sSav = ""
For lCpt = lTot To 1 Step -1
		If Trim ( Upper ( idwArticle.Object.id_typ_art [ lCpt ] )) <> "TEL" Then Continue

		// [DT141] 
		If bCasAppleCmdeChezSfrSuite176Sbe And &
			idwArticle.GetItemString ( lCpt, "ID_FOUR" ) = "CEG" Then 
			Continue
		End If

		// [DT145_V4]
		Choose Case True
			Case bCasAppleChoixDmeAvantO2m, bCasAppleChoixO2mSuiteDME176 			
				Choose Case idwArticle.GetItemString ( lCpt, "ID_FOUR" )
					Case "DME", "O2M"
						continue
				End Choose 
		End CHoose 
		
		If Trim ( Upper ( idwArticle.Object.id_marq_ifr [ lCpt ] )) + &
 		   Trim ( Upper ( idwArticle.Object.id_modl_ifr [ lCpt ] )) = sSav Then
			idwArticle.RowsDiscard ( lCpt, lCpt, Primary!)
		Else 
			
			// [VDOC19697]
			lQteDisp = idwArticle.GetItemNumber ( lCpt, "QT_DISP" )
			If lQteDisp > 0 Then
				sSav = Trim ( Upper ( idwArticle.Object.id_marq_ifr [ lCpt ] )) + &
						 Trim ( Upper ( idwArticle.Object.id_modl_ifr [ lCpt ] )) 
			End If
		End If
Next

idwArticle.SetSort ( sSortOrig )
idwArticle.Sort () // #9
// :#9

	
This.uf_Preparer_ArticleType_EDI ()

idwArticle.SetFilter ( sFiltre )
idwArticle.Filter ()
idwArticle.Sort () // #9

/*------------------------------------------------------------------*/
/* Initialisation de l'objet Pilote Equiv. Fct.                     */
/*------------------------------------------------------------------*/
//* #10	[DCMP070798] Ajout PC2
Choose Case isTypApp 
	Case "TEL", "PC2"
		// [REPAR_GTI]
		// [PM280-2]
		If lIdEvt <> 1426 And isChoixAction <> "R" Then
			iuoEqvFct.uf_preparer( isChoixAction, isMarqPortAdh, isModlPortAdh, idwDetail.GetItemDecimal ( 1, "MT_VAL_ACHAT" ) )
		End if
		// :[REPAR_GTI]

End Choose

/*------------------------------------------------------------------*/
/* On traite le cas particulier de la prestation sur téléphone.     */
/*------------------------------------------------------------------*/
This.uf_InitCasParticulier ()


/*------------------------------------------------------------------*/
/* Armement des plafonds.                                           */
/*------------------------------------------------------------------*/
This.uf_ArmementPlafond ( "APPLICATION_TOTALE" )


/*------------------------------------------------------------------*/
/* L'on peut par défaut pour certains produit positionner           */
/* automatiquement le fournisseur et le typ d'article.              */
/*------------------------------------------------------------------*/
// #30 [DCMP090327].[SBETV]
This.uf_InitParDefaut (1)

/*------------------------------------------------------------------*/
/* Selection automatique de certains mobiles sur Option.            */
/*------------------------------------------------------------------*/
/* #4																					  */
/*------------------------------------------------------------------*/
This.uf_SelectionAutomatique ()


/*------------------------------------------------------------------*/
/* Insertion d'un Premier Row dans la Dw des commandes.             */
/*------------------------------------------------------------------*/
This.uf_InitCmdeClient ()


/*------------------------------------------------------------------*/
/* #2																				     */
/*------------------------------------------------------------------*/
sFiltre = idwArticle.Describe ( "DataWindow.Table.Filter" )
//Migration PB8-WYNIWYG-03/2006 FM
If sFiltre = '?' then sFiltre = ''
//Fin Migration PB8-WYNIWYG-03/2006 FM

F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 3 )
isFiltreArtDetPro = "Pos ( OBSERV_FRN, '#ORANGE#', 1 ) > 0"
/*------------------------------------------------------------------*/
/* #3 : CAG 10/09/2003 : filtre sur #ORANGE# uniquement pr frn = CET*/
/*------------------------------------------------------------------*/
If lDeb <= 0 Then
	isFiltreArtDetPro = "Not " + isFiltreArtDetPro
End If

// On ne modifie le filtre que pour les articles de type "TEL"
If Pos ( sFiltre, "ID_TYP_ART = 'TEL'", 1) > 0 Then
	bTrouve = False
	iPos = 0
	Do
		iPos = Pos ( sFiltre , "AND", iPos + 1 )
		If iPos > 0 And ( Mid ( sFiltre, iPos + 4, 3 ) = "Pos" Or Mid ( sFiltre, iPos + 8, 3 ) = "Pos" )  Then
			bTrouve = True
		End If
	Loop Until bTrouve Or iPos = 0
	If bTrouve Then
		sFiltre = Left ( sFiltre, iPos - 2 )
	End If
	sFiltre = sFiltre + " AND " + isFiltreArtDetPro
	idwArticle.SetFilter ( sFiltre )
	idwArticle.Filter ()
	idwArticle.Sort ()
End If


/*------------------------------------------------------------------*/
/* Doit-on déconnecter la recherche par équivalence fonctionnelle   */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 24 )
bEQFDecx = lDeb > 0 

// [PC505].[POINT35]
If Not bEQFDecx Then
	Choose Case isTypApp
		Case "TEL"  // Ajoute TPC lors de la livraison du système TPCIFR !!
			// Ok on laisse
		Case Else 
			// On force la déconnexion
			bEQFDecx = TRUE
	End Choose
End If

If bEQFDecx Or idwBandeau.GetItemString ( 1, "ALT_AUTRE_PLAFOND") = "O" Then This.Uf_Deconnecter_Equiv_Fct ("FONCTION")

/*------------------------------------------------------------------*/
/* contrôle : On n'applique l'éuiv fct que si le dossier a été      */
/* créé postérieurement à la mep du projet Equiv. Fct. Vu avec C.   */
/* Chauvin le 28/10/2004                                            */
/*------------------------------------------------------------------*/
/* Date de mise en production de l'Equiv Fct.                       */
/*------------------------------------------------------------------*/
sDteProdEqvFc = ProfileString ( stGlb.sFichierIni, "DIVERS", "DATE_PRODUCTION_EQV_FCT", "01/01/2000" )
sDteProdEqvFc = Right (sDteProdEqvFc, 4) + "-" + Mid (sDteProdEqvFc, 4, 2 ) + "-" + Left (sDteProdEqvFc, 2) 

If Date ( idwWSin.GetItemDateTime ( 1, "CREE_LE" ) ) < Date ( sDteProdEqvFc ) Then
	bEQFDecx = TRUE // #6
	This.Uf_Deconnecter_Equiv_Fct ("FONCTION")
End If

/*----------------------------------------------------------------------------*/
/* #6 Y a-t-il au mois une option 79, 80, 81 ? Auquel cas on déconnecte l'EQF */ 
/*----------------------------------------------------------------------------*/
// Autor Cmde Gestionnaire
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 79 )

// Si cette option n'est trouvé, c'est que le gestionnaire ne peut pas commander
// en direct chez un FRN, l'EQF en ligne avec l'assuré n'a donc plus de raison d'être
If lDeb <= 0 Then 
	bEQFDecx = TRUE 
	This.Uf_Deconnecter_Equiv_Fct ("FONCTION")
End If
// /#6


/*------------------------------------------------------------------*/
/* Modification demandé par Denis Bizien le 13/12/04.               */
/*------------------------------------------------------------------*/

If Not bEQFDecx Then
	Choose Case isChoixAction
		Case "C", "S"
			This.uf_Correspondance_IFR_FRN ()
	End Choose
End If

Choose Case isChoixAction
	Case "C", "S"
		This.uf_EpurationAutreTypeArt () //* #10 [DCMP070798]
End Choose

// [VDoc5406] 
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 152 )
If lDeb > 0 And idwDetail.GetItemNumber ( 1, "ID_GTI" ) = 15 Then
	If isChoixAction="C" Then // [VDOC14351] - msg uniquement si commande
		stMessage.berreurg=FALSE
		stMessage.bouton=Ok!
		stMessage.icon=Information!
		stMessage.scode="COMD672"
		stMessage.sTitre="Commandes"
		
		f_Message(stMessage)
	End if
End if
// :[VDoc5406] 

//[BUG_PRS] 
This.Uf_RowfocusChanged ( "DWFOURN" )


// Important !, problème de perte de partage, ce jour le 18/10, je m'en sors par ce biais !!
idwFourn.PostEvent ( "ue_Share" )





end subroutine

public subroutine uf_infoarticle (string asdw, string ascas);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_InfoArticle (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 19/09/2001
//* Libellé			: Plus d'information sur l'article
//* Commentaires	: 
//*
//* Arguments		:  String		asDw		Val
//*						String		asCas		Val
//*					  
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
//* 
//*---------------------------------------------------------------

String	sObject
Long		lRow, lHautMax, lHautMin, ltot, lCpt
Int		iPos
DataWindow Dw

/*------------------------------------------------------------------*/
/* Sur quelle Dw a-t-on clické ?                                    */
/*------------------------------------------------------------------*/

CHOOSE CASE Upper ( asDw ) 
	CASE "DW_ARTICLE"
		dw = idwArticle
		lHautMax = 981

	CASE "DW_ARTICLE_PRS"
		dw = idwArticlePrs
		lHautMax = 901
END CHOOSE

/*------------------------------------------------------------------*/
/* Hauteur mini et maxi du détail.                                  */
/*------------------------------------------------------------------*/
lHautMin = 85

CHOOSE CASE Upper( asCas )

	// Va et Vient sur le click
	CASE "CLICK" 

		sObject = dw.GetObjectAtPointer () 
		iPos 	  = Pos ( sObject, "~t", 1 ) 
		lRow	  = Long ( Right ( sObject, Len ( sObject ) - iPos  ) )
		sObject = Left ( sObject, iPos - 1 )

		If sObject = "b_info" Then

			dw.AcceptText ()

			// On agrandit
			If Not ibPlusInfo Then

				/*------------------------------------------------------------------*/
				/* Juste avant d'agrandir, on prépare le label et le filtre pour    */
				/* liste INFO_SPB_FRN				                                   */
				/*------------------------------------------------------------------*/
//* #1 [FNAC_PROD_ECH_TECH] Devient gênant pour FNAC, et n'est pas utile de toute façon à cet endroit
// c'était juste une question d'esthétique à l'époque. ce sera appelé sur le clique de la cac.
//				This.uf_GestionZone_infoSpbFrn ( lRow, dw )

				dw.SetItem ( lRow, "HAUT_DET_MAX", "O" )
				dw.SetdetailHeight ( lRow, lRow, lHautMax )
				dw.SetRow ( lRow )
				dw.ScrollToRow ( lRow )
				ibPlusInfo = True
				dw.SetColumn ( "ID_SERIE_ANC" )
				dw.SetFocus ()

				/*------------------------------------------------------------------*/
				/* Modification SFR # le 03/10/02 : Maj de l'affichage des          */
				/* libellés gammes et appartenance au catalogue                     */
				/*------------------------------------------------------------------*/
				This.uf_ArmementGmeCat ( lRow )

			// On Rétrécit
			Else
				dw.SetItem ( lRow, "HAUT_DET_MAX", "N" )
				dw.SetdetailHeight ( lRow, lRow, lHautMin )
				dw.ScrollToRow ( lRow )
				dw.SetRow ( lRow )
				ibPlusInfo = False
				dw.SetColumn ( "CHOIX" )
				dw.SetFocus ()
			End If
		End If



	// On force à hauteur Mini
	CASE "MINI"

		dw.SetFilter ( "" ) 
		dw.Filter ( ) 
		ibPlusInfo = False
		lTot = dw.RowCount ()
		For lCpt = 1 To lTot
			dw.SetItem ( lCpt, "HAUT_DET_MAX", "N" )
		Next
		idwArticle.SetdetailHeight ( 1, lTot, lHautMin )		
		idwArticlePrs.SetdetailHeight ( 1, lTot, lHautMin )		
		dw.SetColumn ( "CHOIX" )

END CHOOSE


end subroutine

private subroutine uf_initcmdeclient ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_InitCmdeClient (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 19/09/2001
//* Libellé			: Initialisation de la dw de commande avec les 
//*					  coordonnées du client
//* Commentaires	: 
//*
//* Arguments		: astPass			s_Pass		Ref
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    13/06/2003  Modif ARVATO Adr de Fact.
//* #2    JFF    06/07/2003  DCMP 040206
//        JFF    07/05/2013  [PC938_ORANGE_V3]
//        JFF    08/04/2014  [PM255]
//        JFF    08/04/2014  [VDOC15185]
//        JFF    15/12/2015  [DT191]
//        JFF    06/01/2016  [PC13313]
//        JFF    23/01/2017  [DT290]
//        JFF    17/04/2018  [DT288-4]
//        JFF    03/09/2018  [DT361]
//*---------------------------------------------------------------
DateTime	dtToday
Long lRow, lDeb, lFin, lIdSin
String sNom
String sNumTel1, sNumTel2, sNumTelSvg

dtToday = DateTime ( Today (), Now () )
idwCmde.Reset ()
idwCmde.InsertRow ( 0 )

lIdSin = idwDetail.GetItemNumber  ( 1, "ID_SIN" ) 
sNom    = idwWsin.GetItemString  ( 1, "NOM" ) + " " + idwWsin.GetItemString  ( 1, "PRENOM" ) 

idwCmde.SetItem ( 1, "ID_SIN"				, idwDetail.GetItemNumber  ( 1, "ID_SIN" ) )
idwCmde.SetItem ( 1, "ID_GTI"				, idwDetail.GetItemNumber  ( 1, "ID_GTI" ) )
idwCmde.SetItem ( 1, "ID_DETAIL"			, idwDetail.GetItemNumber  ( 1, "ID_DETAIL" ) )

idwCmde.SetItem ( 1, "ADR_COD_CIV"		, idwWsin.GetItemString  ( 1, "COD_CIV" ) )
idwCmde.SetItem ( 1, "ADR_NOM"			, idwWsin.GetItemString  ( 1, "NOM" ) )
idwCmde.SetItem ( 1, "ADR_PRENOM"		, idwWsin.GetItemString  ( 1, "PRENOM" ) )
idwCmde.SetItem ( 1, "ADR_LIVR1"			, idwWsin.GetItemString  ( 1, "ADR_1" ) )
idwCmde.SetItem ( 1, "ADR_LIVR2"			, idwWsin.GetItemString  ( 1, "ADR_2" ) )
idwCmde.SetItem ( 1, "ADR_CP"				, idwWsin.GetItemString  ( 1, "ADR_CP" ) )
idwCmde.SetItem ( 1, "ADR_VILLE"			, idwWsin.GetItemString  ( 1, "ADR_VILLE" ) )

// [DT288-4]
sNumTel1 = F_Format_Num_Tel ( idwWsin.GetItemString  ( 1, "NUM_TELD" ), TRUE )
sNumTel2 = F_Format_Num_Tel ( idwWsin.GetItemString  ( 1, "NUM_TELB" ), TRUE )

If ( Left ( sNumTel2, 2 ) = "06" Or Left ( sNumTel2, 2 ) = "07" ) And ( Left ( sNumTel1, 2 ) <> "06" and Left ( sNumTel2, 2 ) <> "07" ) Then
	sNumTelSvg = sNumTel1
	sNumTel1 = sNumTel2
	sNumTel2 = sNumTelSvg 
End If
	
idwCmde.SetItem ( 1, "ADR_TEL1"			, sNumTel1 )
idwCmde.SetItem ( 1, "ADR_TEL2"			, sNumTel2 )
idwCmde.SetItem ( 1, "CREE_LE"			, dtToday )
idwCmde.SetItem ( 1, "MAJ_LE"				, dtToday )
idwCmde.SetItem ( 1, "MAJ_PAR"			, stGlb.sCodOper )
idwCmde.SetItem ( 1, "NOM_GEST"			, Upper ( stGlb.sNomOper ) + " " + Upper ( stGlb.sPrenomOper )  )
idwCmde.SetItem ( 1, "COD_ETAT"			, "CNV"  )
idwCmde.SetItem ( 1, "CPT_VALIDE"		, 0  )
// #1
/* DESACTIVATION DE L'ADRESSE DE FACTURATION
idwCmde.SetItem ( 1, "ADRFC_COD_CIV"	, idwWsin.GetItemString  ( 1, "COD_CIV" ) )
idwCmde.SetItem ( 1, "ADRFC_NOM"			, idwWsin.GetItemString  ( 1, "NOM" ) )
idwCmde.SetItem ( 1, "ADRFC_PRENOM"		, idwWsin.GetItemString  ( 1, "PRENOM" ) )
idwCmde.SetItem ( 1, "ADRFC_LIVR1"		, idwWsin.GetItemString  ( 1, "ADR_1" ) )
idwCmde.SetItem ( 1, "ADRFC_LIVR2"		, idwWsin.GetItemString  ( 1, "ADR_2" ) )
idwCmde.SetItem ( 1, "ADRFC_CP"			, idwWsin.GetItemString  ( 1, "ADR_CP" ) )
idwCmde.SetItem ( 1, "ADRFC_VILLE"		, idwWsin.GetItemString  ( 1, "ADR_VILLE" ) )
*/
idwCmde.SetItem ( 1, "ADRFC_COD_CIV"	, "1" )
idwCmde.SetItem ( 1, "ADRFC_NOM"			, "X" )
idwCmde.SetItem ( 1, "ADRFC_PRENOM"		, "X" )
idwCmde.SetItem ( 1, "ADRFC_LIVR1"		, "X" )
idwCmde.SetItem ( 1, "ADRFC_LIVR2"		, "X" )
idwCmde.SetItem ( 1, "ADRFC_CP"			, "00000" )
idwCmde.SetItem ( 1, "ADRFC_VILLE"		, "X" )

// #2

lRow = idwLstInter.Find ( "COD_INTER = 'A'", 1, idwLstInter.RowCount () )
If lRow > 0 Then

	If IsNull ( idwLstInter.GetItemString  ( lRow, "COD_MODE_REG" ) ) Then
		idwCmde.SetItem ( 1, "COD_MODE_REG"	, "VA" )
	Else
		idwCmde.SetItem ( 1, "COD_MODE_REG"	, idwLstInter.GetItemString  ( lRow, "COD_MODE_REG" ) )
	End If

	idwCmde.SetItem ( 1, "RIB_BQ"			, idwLstInter.GetItemString  ( lRow, "RIB_BQ" ) )
	idwCmde.SetItem ( 1, "RIB_GUI"		, idwLstInter.GetItemString  ( lRow, "RIB_GUI" ) )
	idwCmde.SetItem ( 1, "RIB_CPT"		, idwLstInter.GetItemString  ( lRow, "RIB_CPT" ) )
	idwCmde.SetItem ( 1, "RIB_CLE"		, idwLstInter.GetItemString  ( lRow, "RIB_CLE" ) )
End If


/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/* Changement de l'icone pour ADR_TEL3 et armement de la valeur     */
/* pour certains produits (SFR).                                    */
/*------------------------------------------------------------------*/
uf_Tb_Sfr ()
uf_Modifier_Icone_Sfr ()

/*------------------------------------------------------------------*/
/* Protection des zones de RIB, elle seront déprotégé dans          */
/* certains cas sur le Bouton Ctrl                                  */
/*------------------------------------------------------------------*/
idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "1" )

// [PC938_ORANGE_V3]
// [PC938_ORANGE_V3][MANTIS7684]
// [PM255]
If isChoixAction <> "R" And gProcessTempoOrangeV3 Then
	Choose Case ilProcessTempo 
		Case 976, 978

			// [VDOC15185]
			lRow = idwCmdeGti.Find("ID_TYP_ART = 'PRS' AND COD_ETAT NOT IN ( 'ANN', 'RFO', 'RPC')", 1, idwCmdeGti.RowCount())
			
			If lRow > 0 Then
				idwCmde.SetItem ( 1, "ADR_COD_CIV"		, idwCmdeGti.GetItemString ( lRow , "ADR_COD_CIV" ))
				idwCmde.SetItem ( 1, "ADR_NOM"			, idwCmdeGti.GetItemString ( lRow , "ADR_NOM" ))
				idwCmde.SetItem ( 1, "ADR_PRENOM"		, idwCmdeGti.GetItemString ( lRow , "ADR_PRENOM" ))
				idwCmde.SetItem ( 1, "ADR_LIVR1"			, idwCmdeGti.GetItemString ( lRow , "ADR_LIVR1" ))
				idwCmde.SetItem ( 1, "ADR_LIVR2"			, idwCmdeGti.GetItemString ( lRow , "ADR_LIVR2" ))
				idwCmde.SetItem ( 1, "ADR_LIVR_CPL"		, idwCmdeGti.GetItemString ( lRow , "ADR_LIVR_CPL" ))
				idwCmde.SetItem ( 1, "ADR_CP"				, idwCmdeGti.GetItemString ( lRow , "ADR_CP" ))
				idwCmde.SetItem ( 1, "ADR_VILLE"			, idwCmdeGti.GetItemString ( lRow , "ADR_VILLE" ))					
			End If

		// [PM255] [DT191] // [DT290]
		Case 981, 982, 2143, 984
			idwCmde.SetItem ( 1, "ADR_COD_CIV"		, isAdrCivPickUp )
			idwCmde.SetItem ( 1, "ADR_NOM"			, isAdrNomPickUp )
			idwCmde.SetItem ( 1, "ADR_PRENOM"		, isAdrPreNomPickUp )
			idwCmde.SetItem ( 1, "ADR_LIVR1"			, isAdr1PickUp ) 
			idwCmde.SetItem ( 1, "ADR_LIVR2"			, isAdr2PickUp ) 
			idwCmde.SetItem ( 1, "ADR_LIVR_CPL"		, isAdrCpltPickUp )
			idwCmde.SetItem ( 1, "ADR_CP"				, isAdrCpPickUp)
			idwCmde.SetItem ( 1, "ADR_VILLE"			, isAdrVillePickUp )				
			
	End Choose
End If



end subroutine

public function string uf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerSaisie (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 06/10/2001
//* Libellé			: 
//* Commentaires	: Controle de saisie
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 10/09/2002   Modification SFR # Ajout de la colonne ADR_COD_CIV
//* #2	 CAG	 07/11/2002	  						   Récup du code SRP + ajout des
//*															modifs : zone pb obligatoire pr PRS
//*															zone IMEI
//* #3	 CAG	 18/11/2002	  						   Ctrl de la zone IMEI :
//*														   document du cmpte-rendu de mission chez CETELEC (2.3)
//*															Le Imei doit être un nombre de 15 chiffres ou "0"
//* #3.1	 JFF	 01/09/2003	  						   Pour CEGETEL (MUST), on ne prend pas que les IMEI Valide ou à 15x0.
//*															en revanche le pout #3.1 est développé avec DET_PRO et peut s'adapter à tout produit
//* #4	 CAG	 18/11/2002	  						   Ctrl des zones de téléphone
//*														   document du cmpte-rendu de mission chez CETELEC (2.2)
//*															10 chiffres commençant par 0 et ne finissant pas par 0000
//* #5	 CAG	 06/12/2002								Suite visite Caen du 05/12/2002 : les zones marques et modèles
//*															pour lesquelles on demandait confirmation si non saisies 
//*															deviennent obligatoires.
//* #6	 CAG	 24/02/2003	  Le bris est maintenant géré par Cetelec
//* #7	 CAG	 20/03/2003	  DCMP 030161 : 1) si pls frn => msg + 2) si l'une des cmds/prs du sinistre a déjà
//*												    été envoyée chez Cetelec, modification de l'adresse par celle de Cetelec
//* #8	 JFF	 10/06/2003	  On adapte le #7 à ARVATO/ASF
//* #9	 JFF   26/08/2003	  DCMP 030362 : contrôle des communes par rapport au fichier INSEE
//* #10	 JFF   02/09/2003	  Contrôles des TAC_IMEI
//* #11	 JFF	 01/10/2003	  Suite arrêt de contrat avec CETELEC, toutes commandes chez CEGETEL doit avoir l'adresse d'ARVATO
//*								  s'il y a déjà eu une PRS, que ce soit chez CETELEC ou ARVATO.
//* #12	 JFF	 09/10/2003	  Acception sur option des CP à 00000
//* #13   JFF   23/01/2003	  DCMP 040006 : Si une PRS CET puis une CMD CEG alors adresse du client.
//* #14   JFF   30/06/2004	  DCMP 040206 Zone Info_spb_frn
//* #15   JFF   23/06/2008   [DCMP080287].FAX_MAIL
//* #16   JFF   03/08/2008   [CAMARA].[PRESTA_WEB_BOUTIQUE]
//*       JFF   27/07/2010   [PC321]
//* 		 JFF   04/11/2010   [PC301].[LOT2]
//		FPI	15/06/2012	[SFRP085.FPI] Désactivation du contrôle du n° de tel
//*   JFF   25/10/2012  ITSM133780
//*   JFF   21/03/2016  [370853_ITSM]
//*   JFF   01/10/2024  [MCO602_PNEU]
//*-----------------------------------------------------------------
String sCol [ ], sErr [ ], sTabNull [], sIdFourAdr, sTabAdrFour[], s15Zero, sIdFour1, sIdTypArt1, sIdFour2, sIdTypArt2
String 		sNouvelleLigne, sPos, sText, sVal, sDw, sAdrTel1, sAdrTel, sFind, sTriActuel, sIMEICorr, sMessErr
Long 			lCpt, lNbrCol, lTot, lCptCol, lRow, lCptFourDif, lDeb, lFin

Integer		iDeptInterdit[26] = { 4, 5, 6, 9, 11, 12, 13, 15, 30, 31, 32, 34, 40, 43, 46, 47, 48, 64, 65, 66, 73, 74, 81, 82, 83, 84 }
String		sIdFour, sIdTypArt, sFiltreOrig
Long			lAdrCp
Boolean		bDeptTrouve, bAuMoinsUnePRS, bDp382
Date			dDteRdvCli
n_cst_string lnvPFCString

sNouvelleLigne		= "~r~n"
sPos					= ""
sText					= sNouvelleLigne
sFind					= ""
s15Zero				= Fill ( "0", 15)

// [MCO602_PNEU]
bDp382 = False
If F_CLE_A_TRUE ( "MCO602_PNEU" ) Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 382 )
	bDp382 = lDeb > 0 
End If 


sFiltreOrig = iDwArticle.Describe ( "datawindow.table.filter" ) 
If sFiltreOrig = "?" Then sFiltreOrig = ""

/*------------------------------------------------------------------*/
/* Le 14/08/2003 JFF																  */
/* On interdira la saisie de la commande dans ce cas car pas "-2"   */
/* chez ARVATO, uniquement du 1, donc cloture de ce sin en          */
/* Ssuite, et ouverture d'un autre sinistre pour ce cas précis      */
/*------------------------------------------------------------------*/
idwArticle.SetFilter ( "CHOIX = 'O'" )
idwArticle.Filter ( )

/*------------------------------------------------------------------*/
/* Au moins une commande doit être saisie.								  */
/*------------------------------------------------------------------*/
stMessage.sTitre  	= "Controle de saisie"
stMessage.Icon			= Information!
stMessage.bErreurG	= TRUE
stMessage.Bouton		= Ok!
stMessage.sCode		= "GENE001"

If idwArticle.RowCount () <= 0 Then
	sDw = "G"
	stMessage.sVar [1] = sNouvelleLigne + " - Au moins une commande" + sNouvelleLigne
	F_Message ( stMessage )
	Return sDw + sPos
End If 


/*------------------------------------------------------------------*/
/* #7	1er contrôle																  */
/*------------------------------------------------------------------*/
lTot = idwArticle.RowCount ()
If lTot > 1 Then
	// #16 [CAMARA].[PRESTA_WEB_BOUTIQUE] 
	sIdFour1 = idwArticle.GetItemString ( 1, "ID_FOUR" )
	sIdTypArt1 = idwArticle.GetItemString ( 1, "ID_TYP_ART" )
	
	sTriActuel	= idwArticle.Describe ( "DataWindow.Table.Sort" )
	idwArticle.SetSort ( "ID_FOUR" )
	idwArticle.Sort ()

	sFind = "ID_FOUR <> '" + sIdFour1 + "'"
	lRow = idwArticle.Find ( sFind, 2, lTot )

	// #16 [CAMARA].[PRESTA_WEB_BOUTIQUE] Traitement de cas spéciaux autorisant ce cas
	If lRow > 0 Then
		sIdFour2 = idwArticle.GetItemString ( lRow, "ID_FOUR" )
		sIdTypArt2 = idwArticle.GetItemString ( lRow, "ID_TYP_ART" )

		If ( sIdFour1 = "WBB" And sIdTypArt2 = "SMS" ) Or ( sIdFour2 = "WBB" And sIdTypArt1 = "SMS") Then
			lRow = 0 // Cas autorisé
		End IF
	End If
	
	
	If lRow > 0 Then
		stMessage.sCode	=	"COMD045"
		stMessage.bErreurG	= FALSE
		F_Message ( stMessage )

		idwArticle.SetSort ( sTriActuel )
		idwArticle.Sort ()

		Return sDw + sPos
	End If
	
	idwArticle.SetSort ( sTriActuel )
	idwArticle.Sort ()
End If

/*------------------------------------------------------------------*/
/* #7, #8 2ème contrôle															  */
/*------------------------------------------------------------------*/
ibInsCmdeCEG = False


/*------------------------------------------------------------------*/
/* Controle de saisie de la partie Client.                          */
/* (Sans la date de RDV)														  */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* #1																					  */
/*------------------------------------------------------------------*/
sCol[ 1 ] = "ADR_NOM"
sCol[ 2 ] = "ADR_PRENOM"
sCol[ 3 ] = "ADR_LIVR1"
sCol[ 4 ] = "ADR_CP"
sCol[ 5 ] = "ADR_VILLE"
sCol[ 6 ] = "ADR_TEL1"
sCol[ 7 ] = "ADR_COD_CIV"
// #8
sCol[ 8 ] = "ADRFC_NOM"
sCol[ 9 ] = "ADRFC_PRENOM"
sCol[ 10] = "ADRFC_LIVR1"
sCol[ 11] = "ADRFC_CP"
sCol[ 12] = "ADRFC_VILLE"
sCol[ 13] = "ADRFC_COD_CIV"

sErr[ 1 ] = " - Le nom du client (Récup/Livr.)"
sErr[ 2 ] = " - Le prenom du client (Récup/Livr.)"
sErr[ 3 ] = " - L'adresse (Récup/Livr.)"
sErr[ 4 ] = " - Le code postal (Récup/Livr.)"
sErr[ 5 ] = " - La ville (Récup/Livr.)"
sErr[ 6 ] = " - Le n° de téléphone"
// #8
sErr[ 7 ] = " - La civilité (Récup/Livr.)"
sErr[ 8 ] = " - Le nom du client (Fact.)"
sErr[ 9 ] = " - Le prenom du client (Fact.)"
sErr[ 10] = " - L'adresse (Fact.)"
sErr[ 11] = " - Le code postal (Fact.)"
sErr[ 12] = " - La ville (Fact.)"
sErr[ 13] = " - La civilité (Fact.)"

lNbrCol	 = UpperBound ( sCol )

stMessage.sTitre  	= "Controle de saisie"
stMessage.Icon			= Information!
stMessage.bErreurG	= TRUE
stMessage.Bouton		= Ok!
stMessage.sCode		= "GENE001"

For lCptCol = 1 To lNbrCol

	// [PC301].[LOT2]
	// [VDOC16803] ajout AXA
	If lCptCol = 6 Then 
		If idwArticle.Find ( "ID_FOUR IN ( 'CAR', 'AXA') AND CHOIX = 'O'", 1, idwArticle.Rowcount() ) > 0  Then
			// ITSM133780
			If IsNull ( Trim ( idwCmde.GetItemString ( 1, sCol [ lCptCol ] )) ) Then
				idwCmde.SetItem ( 1, sCol [ lCptCol ], "" ) 
			End If
			Continue
		End If
	End If
	// :[PC301].[LOT2]

	CHOOSE CASE lCptCol
		CASE 1 To 13
			sVal =  Trim ( idwCmde.GetItemString ( 1, sCol [ lCptCol ] ))
	END CHOOSE

	If IsNull ( sVal ) or sVal = ""	Then

		If sPos = "" Then sPos = sCol[ lCptCol ]
		sText = sText + sErr[ lCptCol ] + sNouvelleLigne

	End If

Next

If sPos <> "" Then 
	sDw = "D"
	stMessage.sVar [1] = sText
	F_Message ( stMessage )
	Return sDw + sPos
End If



If sPos <> "" Then 
	sDw = "D"
	stMessage.sVar [1] = sText
	F_Message ( stMessage )
	Return sDw + sPos
End If
	
/*------------------------------------------------------------------*/
/* Controle de saisie de la partie Commande.                        */
/*------------------------------------------------------------------*/
sCol = sTabNull
sErr = sTabNull

sCol[ 1 ] = "PROBLEME"
sCol[ 2 ] = "ID_SERIE_ANC"
sCol[ 3 ] = "ID_MARQ_ART"
sCol[ 4 ] = "ID_MODL_ART"
sCol[ 5 ] = "INFO_SPB_FRN"

sErr[ 1 ] = " - La description du problème"
sErr[ 2 ] = " - Le n° de série de l'ancien appareil"
sErr[ 3 ] = " - La marque de l'ancien appareil"
sErr[ 4 ] = " - Le modèle de l'ancien appareil"
sErr[ 5 ] = " - "

lNbrCol	 = UpperBound ( sCol )

stMessage.sTitre		= "Controle de saisie - Prestation(s)"
stMessage.Icon			= Information!
stMessage.bErreurG	= TRUE
stMessage.Bouton		= Ok!
stMessage.sCode		= "GENE001"


/*------------------------------------------------------------------*/
/* Le numéro IMEI est obligatoire pour tous les articles, s'il y a  */
/* au moins une prestation ou commande										  */
/*------------------------------------------------------------------*/
lTot = idwArticle.RowCount ()

For	lCpt = 1 To lTot

	// [PC321]
	If lCpt = 1 And ibPasDeSaisieProbleme Then
		Continue
	End If
	// :[PC321]
	
	// [MCO602_PNEU]
	If F_CLE_A_TRUE ( "MCO602_PNEU" ) Then
		If Not bDp382 Then
			sVal =  Trim ( idwArticle.GetItemString ( lCpt, sCol [ 2 ] ))
		
			If IsNull ( sVal ) or sVal = ""	Then
				If sPos = "" Then sPos = sCol [ 2 ]
				sText = sText + sErr[ 2 ] + sNouvelleLigne
			End If
		End If 
	Else
		sVal =  Trim ( idwArticle.GetItemString ( lCpt, sCol [ 2 ] ))
	
		If IsNull ( sVal ) or sVal = ""	Then
			If sPos = "" Then sPos = sCol [ 2 ]
			sText = sText + sErr[ 2 ] + sNouvelleLigne
		End If
	End IF 	

	If sPos <> "" Then 
		sDw = "G"

		stMessage.sVar [1] = sText
		F_Message ( stMessage )
		Return sDw + sPos
	End If	

	If sPos = "" Then
/*------------------------------------------------------------------*/
/* #3                                                               */
/*------------------------------------------------------------------*/
		// Interdit-on l'IMEI à 0 pour ce produit ? OUI si lDeb > 0
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 6 )

		If isTypApp <> "TEL" And lDeb > 0 And sVal = "" Then

			sPos = sCol [ 2 ]
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!

			stMessage.sCode		= "SFRP083" 
			sDw = "G"

			F_Message ( stMessage )
			Return sDw + sPos

		End If

		If isTypApp = "TEL" And ( ( sVal <> s15Zero ) And ( Len ( sVal ) <> 15 or Not IsNumber ( sVal ) ) ) &
			Or ( sVal = s15Zero And lDeb > 0 )  Then

			sPos = sCol [ 2 ]
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!

			If lDeb > 0 Then
				stMessage.sCode		= "SFRP082"  // On interdit la saisie de 15x0
			Else
				stMessage.sCode		= "SFRP080"  // On Autorise la saisie de 15x0
			End If
			sDw = "G"

			F_Message ( stMessage )
			Return sDw + sPos
		End If

	End If

/*------------------------------------------------------------------*/
/* #3.1                                                             */
/*------------------------------------------------------------------*/
	If sPos = "" Then

		// Interdit-on l'IMEI à 0 pour ce produit ? OUI si lDeb > 0
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 6 )

		If sVal <> s15Zero Or lDeb > 0 Then

			F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 5 )

			If lDeb > 0 Then

				//Si l'IMEI n'est pas valide alors
				If Not F_IMEI ( sVal, sIMEICorr ) Then
					sPos = sCol [ 2 ]
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= Ok!
					stMessage.sCode		= "SFRP081"

					sDw = "G"

					F_Message ( stMessage )
					Return sDw + sPos
				End If 

			End If
		End If

	End If

	// #14
	sVal = String ( idwArticle.GetItemNumber ( lCpt, sCol [ 5 ] ) )

	If IsNull ( sVal ) or sVal = "" Then
		/*------------------------------------------------------------------*/
		/* #14 : Cas particulier pour la zone info_spb_frn                  */
		/*------------------------------------------------------------------*/
		This.uf_ControlerSaisie_Zn_InfoSpbFrn ( lCpt, sMessErr )

		If sMessErr <> "" Then
			If sPos = "" Then sPos = sCol [ 5 ]
			sText = sText + sErr[ 5 ] + sMessErr + sNouvelleLigne
		End If 
	End If

	// [370853_ITSM]
	sVal = String ( idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) )
	sIdfour = String ( idwArticle.GetItemString ( lCpt, "ID_FOUR" ) )
	Choose Case sVal
		Case "A_REPARER", "A_DESOXYDER"
			if sText = "" or sText = sNouvelleLigne  Then
				Choose case sIdFour 
					Case "O2M", "SB1", "MS1", "BLC", "PSM", "COR"
						sVal = string(idwArticle.GetItemNumber ( lCpt, 'INFO_SPB_FRN'))
	
						if lnvPFCString.of_IsEmpty(sVal) or sVal = "0" And Not ibReouvPresta Then
							sPos = 'INFO_SPB_FRN'
							sText = sText + "- Le Process" + sNouvelleLigne
						End If
				End Choose
			End If
	End Choose 


	If sPos <> "" Then 
		sDw = "G"

		stMessage.sVar [1] = sText
		F_Message ( stMessage )
		Return sDw + sPos
	End If	

Next

/*------------------------------------------------------------------*/
/* Filtre sur toutes les prestations choisies                       */
/*------------------------------------------------------------------*/
//* #15 [DCMP080287].FAX_MAIL
// idwArticle.SetFilter ( "CHOIX = 'O' AND ID_TYP_ART = 'PRS'" )
idwArticle.SetFilter ( "CHOIX = 'O' AND ID_TYP_ART IN ( 'PRS', 'AEF', 'DEV' )" )

//* :#15 [DCMP080287].FAX_MAIL

idwArticle.Filter ( )
lTot = idwArticle.RowCount ()
lNbrCol	 = UpperBound ( sCol )

/*------------------------------------------------------------------*/
/* La description du problème est obligatoire pour tous les         */
/* articles s'il y a au moins une prestation                        */
/*------------------------------------------------------------------*/
/* # 5 CAG : 06/12/2002						                             */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lTot

	For lCptCol = 1 To lNbrCol

		Choose Case lCptCol
//* #15 [DCMP080287].FAX_MAIL 3 et 4 ne sont plus nécéssaire
//			Case 1, 3, 4
			Case 1
//* :#15 [DCMP080287].FAX_MAIL 

				// [PC321]
				If lCpt = 1 And ibPasDeSaisieProbleme Then
					Continue
				End If
				// :[PC321]

				sVal = Trim ( idwArticle.GetItemString ( lCpt, sCol [ lCptCol ] ) )
			Case Else
				sVal = "BIDON"
		End Choose

		If IsNull ( sVal ) or sVal = ""	Then
			sPos = sCol [ lCptCol ]
			sText = sText + sErr[ lCptCol ] + sNouvelleLigne
		End If




	Next
	If sPos <> "" Then 
		sDw = "G"

		stMessage.sVar [1] = sText
		F_Message ( stMessage )
		Return sDw + sPos

	End If

Next

/*------------------------------------------------------------------*/
/* On affiche un message pour signaler que certaines zones          */
/* (ID_MARQ_ART, ID_MODL_ART, zones rdv sauf pour					     */
/*  CEGETEL) ne sont pas saisies. 										     */
/* On demande au gestionnaire de confirmer si cette situation est   */
/* normale.                                                         */
/*------------------------------------------------------------------*/
/* # 5 CAG : 06/12/2002						                             */
/*------------------------------------------------------------------*/
sCol = sTabNull
sErr = sTabNull

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 04/10/2002.                              */
/*------------------------------------------------------------------*/
/* Dans le cas de CEGETEL, la date de rdv n'est pas obligatoire     */
/*------------------------------------------------------------------*/
lRow = idwFourn.GetRow ()
idwArticle.SetFilter ( "CHOIX = 'O'" )
idwArticle.Filter ( )
lTot = idwArticle.RowCount ()

bAuMoinsUnePRS		 = idwArticle.Find ( "ID_TYP_ART = 'PRS' AND CHOIX = 'O'", 1, lTot ) > 0 


/*------------------------------------------------------------------*/
/* #9 : DCMP 030362                                                 */
/*------------------------------------------------------------------*/
If sPos = "" Then
	This.uf_ControlerSaisie_Commune ( sPos )
	IF sPos <> "" Then sDw = "D"
End If

/*------------------------------------------------------------------*/
/* #12 : 																			  */
/*------------------------------------------------------------------*/
If sPos = "" Then
	This.uf_ControlerSaisie_CP ( sPos )
	IF sPos <> "" Then sDw = "D"
End If

Return sDw + sPos

end function

private function string uf_formatage_cp (string astext);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::Uf_Formatage_CP (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/09/2001
//* Libellé			: Formatage CP
//* Commentaires	: 
//*
//* Arguments		: asText		String		Val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

String	sVal, sCar
Int		iLen, iPoint, iAt
Long		lVal, lCpt, lPos

sVal = asText
iLen = Len ( Trim ( sVal ) )

/*------------------------------------------------------------------*/
/* Au moins 5 Caractères.                                           */
/*------------------------------------------------------------------*/
If iLen < 5 then 	sVal = "-1"


/*------------------------------------------------------------------*/
/* Enfin il ne peut y avoir que certains caractères.                */
/*------------------------------------------------------------------*/
If sVal <>  "-1" Then
	For lCpt = 1 To iLen
		sCar = Mid ( sVal, lCpt, 1 )

		If Not ( ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) ) Then
			sVal = "-1"
			Exit
		End If
	Next
End If

Return sVal
end function

private function string uf_formatage_heure (string astext);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::Uf_Formatage_Heure (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/10/2001
//* Libellé			: Formatage des Heures
//* Commentaires	: 
//*
//* Arguments		: asText		String		Val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

String	sVal
Int		iLen
Long		lVal

sVal = Trim ( asText )
iLen = Len ( Trim ( sVal ) )
lVal = Long ( sVal )

CHOOSE CASE iLen
	CASE 0
		SetNull ( sVal ) 		

	// 8 = 0800
	CASE 1
		sVal = "0" + sVal + "00"		

	// 15 = 1500
	CASE 2
		If lVal > 23 Then 
			sVal = "-1"
		Else
			sVal = + sVal + "00"		
		End If

	// 156 = 1506
	// 246 = 0246
	CASE 3
		lVal = Long ( Left ( sVal, 2 ) )
		If lVal > 23 Then
			lVal = Long ( Right ( sVal, 2 ) )
			If lVal > 59 Then
				sVal = "-1"
			Else
				sVal = "0" + Left ( sVal, 1 ) + Right ( sVal, 2 )
			End If
		Else		

			sVal = Left ( sVal, 2 ) + "0" + Right ( sVal, 1 )
		End If

	//1530 = 1530
	CASE 4

		lVal = Long ( Left ( sVal, 2 ) )
		If lVal > 23 Then
			sVal = "-1"
		Else
			lVal = Long ( Right ( sVal, 2 ) )
			If lVal > 59 Then	sVal = "-1"
		End If

END CHOOSE

Return sVal
end function

private function string uf_formatage_email (string astext);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::Uf_Formatage_eMail (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/10/2001
//* Libellé			: Formatage de l'mail
//* Commentaires	: 
//*
//* Arguments		: asText		String		Val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    24/08/2004  On ne tient plus compte des points, il 
//* 								  peut en effet y en avoir plusieurs dans l'email
//* 
//*-----------------------------------------------------------------

String	sVal, sCar
Int		iLen, iPoint, iAt
Long		lVal, lCpt, lPos


sVal = Trim ( asText )
iLen = Len ( Trim ( sVal ) )

If iLen <= 0 Then Return sVal

/*------------------------------------------------------------------*/
/* Recherche d'un double espace à remplacer par @                   */
/*------------------------------------------------------------------*/
DO WHILE Pos ( sVal, "  ", 1 ) > 1 
	sVal = Replace ( sVal, Pos ( sVal, "  ", 1 ), 2, "@" )	
LOOP

/*------------------------------------------------------------------*/
/* Recherche d'un espace à remplacer par .                          */
/*------------------------------------------------------------------*/
DO WHILE Pos ( sVal, " ", 1 ) > 1 
	sVal = Replace ( sVal, Pos ( sVal, " ", 1 ), 1, "." )	
LOOP

/*------------------------------------------------------------------*/
/* Vérification de la validité de l'email.                          */
/*------------------------------------------------------------------*/
iPoint = 0
iAt = 0
For lCpt = 1 To iLen 
	sCar = Mid ( sVal, lCpt, 1 )

	// @ et . impossible en premier et dernier
	If ( lCpt = 1 Or lCpt = iLen ) And ( sCar = "@" Or sCar ="." ) Then 
		sVal = "-1"
		Exit
	End If

	If sCar = "." Then 
		iPoint++
	End If

	If sCar = "@" Then 
		iAt++
		iPoint = 0

		// xxx@xx@xxx.xx Impossible
		If iAt >1 Then
			sVal = "-1"
			Exit
		End If

	End If

Next

// Pas plus d'un @ et au moins un .
If iAt <> 1 Or iPoint < 1 Then sVal = "-1"

/*------------------------------------------------------------------*/
/* Enfin il ne peut y avoir que certain caractères.                 */
/*------------------------------------------------------------------*/
If sVal <>  "-1" Then
	iLen = Len ( Trim ( sVal ) )
	For lCpt = 1 To iLen
		sCar = Mid ( sVal, lCpt, 1 )

		If Not ( ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) Or &
					( Asc ( sCar ) >= 65 And Asc ( sCar ) <= 90 ) Or &
					( Asc ( sCar ) >= 97 And Asc ( sCar ) <= 122 ) Or &
					sCar = "." Or & 
					sCar = "@" Or &
					sCar = "_" Or &
					sCar = "-") Then

			sVal = "-1"
			Exit
		End If
	Next
End If

Return sVal
end function

public function string uf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 06/09/2001
//* Libellé			: 
//* Commentaires	: Controle de Gestion
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 CAG	 16/06/2003	  Modification de la marque portable en dddw
//* #2	 CAG	 04/08/2003	  Modif du libellé du msg concernant la modif #1
//* #3	 JFF	 12/11/2003   Gestion particuliere pour DARTY
//* #4	 CAG	 21/09/2004	  DCMP 040381 : Ajout du frn MSS
//* #5    JFF	 07/02/2006   [DCMP060119] modif suite ajout frn AEVUM
//* #6    MADM	 09/05/2006   [DCMP060356] modif suite Rempl frn AEVUM par CORDON
//* #7    JFF	 06/02/2006   [SITE_CMDE] Gestion des nouvelles option d'autorisation 79, 80, 81
//* #8	 JCA	 03/12/2007	  DCMP 70906 Afficher un message à un endroit précis pour une condition particulière.
//* #9	 PHG	 04/12/2007	  [O2M] Suppression du controle Cdiscount => Code Mort
//* #10   JFF   26/03/2008   [SURCOUF_ECH_EXPRESS]
//* #11   JFF   01/04/2008   [DCMP080256][EEE_PC_ASUS] 
//* #12   JFF	 20/10/2008	  [FNAC_PROD_ECH_TECH].[SMS]
//* #13   JFF	 20/10/2008	  [FNAC_PROD_ECH_TECH].[20090127140540720]
//* #14   JFF   03/08/2008   [CAMARA].[PRESTA_WEB_BOUTIQUE]
//* #15   JFF   02/03/2010   [MSS_LOT2]
//*  	    JFF	 13/04/2010   [WEBSIM2].[FRANCE]
//*       JFF   30/06/2010   [PC363_AUCHAN]
//* 		 JFF   04/11/2010   [PC301].[LOT2]
//*		 JFF   01/02/2011   [GROSBILL].[PC398-403-479]
//		FPI	05/04/2011	[PC434]
//*       JFF   26/08/2011   [VDOC4288]
//*       JFF   01/09/2011   [PC10][DIAG_NOMADE]
//*		 JFF   14/09/2011   [VDOC5026]
//*       JFF   19/09/2011   [PM82][LOT2]
//*       FPI   09/11/2011   [VDoc5944]
// 		 JFF   13/02/2012   [PM200][PSM]
//        JFF   17/04/2012   [PM200][LOT2][DESOX]
//        JFF   23/05/2012   [PM103][1]
//        JFF   01/10/2012   [MANTIS4831]
//        JFF   10/10/2012   [PC869]
// 		 FPI	 20/11/2012	  [PC10-2]  - Mantis 5801 - ajout de Converlance
//        JFF   07/05/2013   [PC938_ORANGE_V3]
//        JFF   07/05/2013   [PC929-1]
//        JFF   26/08/2013 [DT57_CMDE_IPHONE_SFR]
//        JFF   09/09/2013 [PM222-1]
//		FPI	26/03/2014	[PC925]
//		FPI	16/05/2014  [VDOC14351]
//        JFF   02/09/2014 [PC13442_MOBZEN2]
//		FPI	05/09/2014	[DT076]
//       JFF   04/11/2014 [PM280-1]
//       JFF   02/01/2015 [PC801_6_TAMET]
//        JFF   09/09/2013 [PM222-1] V4
//       JFF   04/11/2014 [PM280-1][MANTIS15171]
// 		FPI	05/06/2015	[VDOC17593]
//       JFF   05/06/2015 [VDOC17789]
//       JFF    02/07/2015 [UNE_PRESTA_PAR_DETAI]
//       JFF   22/07/2015 [DT168][MANTIS16681]
//		FPI	08/09/2015 [PC13442-2] Ajout ATECH
//       JFF   04/12/2015 [VDOC19345]
//       JFF   08/01/2015 [VDOC19600]
//       JFF   13/01/2016 [PM222-2]
//       JFF   26/01/2016 [PC13313][MANTIS19360]
//		FPI	02/02/2016 [VDOC19809]
//       JFF   29/02/2016 [DT191-1]
//		FPI	08/04/2016	[DT176]
//       JFF   07/06/2016 [DT227]
//       JFF   17/05/2016 [PM280-2]
//       JFF   07/11/2016 [PC151259]
//       JFF   23/01/2017 [DT290]
//       JFF   27/03/2017 [ITSM453020]
//       JFF   29/05/2017 [PC151259-2]
//       JFF   23/08/2017 [DT288-3_LOT1][PM280]
//       JFF   05/10/2017 [PC171918]
//       JFF   05/12/2017 [PM426-1]
//       JFF   07/02/2017 [VDOC25657]
//       JFF   22/02/2017 [VDOC25770]
//       JFF   31/07/2018 [DT363]
//       JFF   03/09/2018 [DT361]
//			JFF   23/11/2018 [ITSM574876]
//       JFF   19/12/2022 [RS4093_EVOL_ELD]
//       JFF   07/03/2024 [HP252_276_HUB_PRESTA]
//*---------------------------------------------------------------

Int					iRet
String				sIdFour, sVal, sVal1, sPos, sDw, sNouvCmde, sMarq, sModl, sFind, sNull, sMess, sIdRefFour, sDonneurOrdre
String				sIdMarqArt, sIdTypArt, sFiltreOrigArticle, sSortOrig, sIdTypArtSav, sAdrMail
Date					dDate1, dDate2
Long					lTot, lCpt, lRow, lDeb, lFin, lQte, lTotDoub, lCptDbl, lIdEvt, lCount, lIdGti, lRow1, lRow2, lRow3, lIdDetail, lPosSlash 
Long 					lVal, lVal1, lInfoSpbfrn
DataWindowChild	dwChild
Boolean				bCasBatAmovAlimExt  //* #13 [FNAC_PROD_ECH_TECH].[20090127140540720]
Boolean				bCasWBBetSMS //  #14 [CAMARA].[PRESTA_WEB_BOUTIQUE]
Boolean				bCasWBBetCAF // [WEBSIM2].[FRANCE]
Boolean				bQteNegInterdite, bIdGti, bConsAppPretVol
Boolean  			bDeclaWebAtlas, bDcnxWebAtlas
Boolean				bARepGti
Decimal {2}			dcMtTTCCmde 
n_cst_string 		lnv_string

// #8
string sTypApp
integer iFind, iRow
// FIN #8

String sCodeBtqCentral
Long lIdProd, lIdSin

iRet = 1
sPos = ""
sDw  = ""

lIdEvt = idwDetail.GetItemNumber ( 1, "ID_EVT" ) // [PM200][LOT2][DESOX]
lIdGti = idwDetail.GetItemNumber ( 1, "ID_GTI" ) 
lIdDetail = idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) 

// [PM222-2]
lIdProd = idwwsin.GetItemNumber(1,"ID_PROD")
lIdSin = idwwsin.GetItemNumber(1,"ID_SIN")

stMessage.sTitre  	= "Controle de gestion"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= Ok!

// [PM234-4_V1]
bDeclaWebAtlas = FALSE
bDeclaWebAtlas = idwWDivsin.Find ( "NOM_ZONE = 'decla_atlas' AND VAL_CAR = 'O'", 1, idwWDivSin.RowCount () ) > 0
bDcnxWebAtlas = idwWDivsin.Find ( "NOM_ZONE = 'dcnx_decla_atlas' AND VAL_CAR = 'O'", 1, idwWDivSin.RowCount () ) > 0

If bDcnxWebAtlas Then
	bDeclaWebAtlas = False
End If

//* #13 [FNAC_PROD_ECH_TECH].[20090127140540720]
sFiltreOrigArticle = idwArticle.Describe ("DataWindow.Table.filter") 
If sFiltreOrigArticle = "?" Then sFiltreOrigArticle = ""

sSortOrig = idwArticle.Describe ("DataWindow.Table.Sort") 
If sSortOrig = "?" Then sSortOrig = ""


idwArticle.SetRedraw ( False )
idwArticle.SetFilter ( "" )
idwArticle.filter ()


//* #15 [MSS_LOT2] ajout ACC (autre accessoire)
bCasBatAmovAlimExt = idwArticle.Find ( "CHOIX = 'O' AND ID_TYP_ART IN ( 'BAM', 'ALE', 'ACC', 'PCM') ", 1, idwArticle.RowCount () ) > 0 

// #14 [CAMARA].[PRESTA_WEB_BOUTIQUE]
// [WEBSIM2].[FRANCE]
bCasWBBetSMS = FALSE
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 118 ) 
If lDeb > 0 Then
	bCasWBBetSMS = idwArticle.Find ( "CHOIX = 'O' AND ID_TYP_ART = 'SMS'", 1, idwArticle.RowCount () ) > 0 And &
						idwArticle.Find ( "CHOIX = 'O' AND ID_FOUR = 'WBB'", 1, idwArticle.RowCount () ) > 0 
End If

bCasWBBetCAF = FALSE
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 130 ) 
If lDeb > 0 Then
	bCasWBBetCAF = idwArticle.Find ( "CHOIX = 'O' AND ID_FOUR <> 'WBB' AND ID_TYP_ART = 'CAF'", 1, idwArticle.RowCount () ) > 0 And &
						idwArticle.Find ( "CHOIX = 'O' AND ID_FOUR = 'WBB'", 1, idwArticle.RowCount () ) > 0 
End If

// [VDOC4288]
idwArticle.SetFilter ( "CHOIX = 'O'" )
idwArticle.filter ()
lTot = idwArticle.RowCount ()
For lCpt = 1 To lTot
	sIdFour = idwArticle.GetItemString ( lCpt, "ID_FOUR" ) 
	bQteNegInterdite = FALSE
	
	Choose Case sIdFour
		Case "CIS", "PAP", "O2M"
			bQteNegInterdite = TRUE			
	End Choose
	
	If Not bQteNegInterdite Then
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 184) 
		bQteNegInterdite = idw_DetPro.Find ( "ID_CODE_CAR = '" + sIdFour + "'", lDeb, lFin ) > 0
	End If 
		
	// [VDOC5026] ajout de fournisseur en dur
	If bQteNegInterdite Then
		
		lQte = idwArticle.GetItemNumber ( lCpt, "QT_DISP" ) 
		If lQte <=0 Then
			stMessage.sTitre		= "Commandes"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!
			stMessage.sCode		= "COMD662"
		
			F_Message ( stMessage )
			sPos = "PROBLEME"
			Return "G" + sPos
		End If
	End If
	
	// [DT57_CMDE_IPHONE_SFR]
	sVal = idwArticle.GetItemString ( lCpt, "OBSERV_FRN" ) 
	If Pos ( sVal, "[#REC#]" ) > 0 Then
		lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "NEUF_REC", "REC" , ";")				
		
		// VDOC25657
		If Pos ( sVal, "[#GR#" ) > 0 Then
			sVal = Mid ( sVal, Pos ( sVal, "[#GR#" ) + 5, 1 ) 
			lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "GRADE_REC", sVal , ";")								
		End If 
		
		// VDOC25770
		If Pos ( sVal, "[#PR#" ) > 0 Then
			sVal = Mid ( sVal, Pos ( sVal, "[#PR#" ) + 5, 3 ) 
			lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "PROV_REC", sVal , ";")								
		End If 
		
	End If	

	// [PM426-1]
	If Pos ( sVal, "[#NEU#]" ) > 0 Then
		lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "NEUF_REC", "NEU" , ";")				
	End If	
Next

// :[VDOC4288]

idwArticle.SetFilter ( sFiltreOrigArticle )
idwArticle.filter ()
idwArticle.Sort ()
idwArticle.SetRedraw ( True)
//* :#13 [FNAC_PROD_ECH_TECH].[20090127140540720]

/*------------------------------------------------------------------*/
/* Contrôle Général.                                                */
/*------------------------------------------------------------------*/
/* Heure mini avant Heure Maxi.												  */
/*------------------------------------------------------------------*/
sVal 	= idwCmde.GetItemString ( 1, "HRDV_CLI_MIN" )
sVal1 = idwCmde.GetItemString ( 1, "HRDV_CLI_MAX" )
If Not IsNull ( sVal ) And Not IsNull ( sVal1 ) Then
	If Time ( Left ( sVal, 2 ) + ":" + Right ( sVal, 2 ) ) > &
		Time ( Left ( sVal1, 2 ) + ":" + Right ( sVal1, 2 ) ) Then
		sDw = "D"
		stMessage.sCode = "COMD011"		
		F_Message ( stMessage )
		Return sDw + "HRDV_CLI_MIN" 
	End If
ElseIf IsNull ( sVal ) And Not IsNull ( sVal1 ) Then 
		sDw = "D"
		stMessage.sCode = "COMD011"		
		F_Message ( stMessage )
		Return sDw + "HRDV_CLI_MIN" 
End If	

/*------------------------------------------------------------------*/
/* Si Au moins une Heure alors une date doit être saisi.				  */
/*------------------------------------------------------------------*/
If ( Not IsNull ( sVal ) Or Not IsNull ( sVal1 ) ) And &
	( IsNull ( idwCmde.GetItemDate ( 1, "DTE_RDV_CLI" ) ) ) Then
	sDw = "D"
	stMessage.sCode = "COMD012"		
	F_Message ( stMessage )
	Return sDw + "DTE_RDV_CLI"

End If

/*------------------------------------------------------------------*/
/* DCMP20103 : une seule commande par gestionnaire						  */
/*------------------------------------------------------------------*/
/* #3 : Gestion particulire DARTY -DP 11                            */
/*------------------------------------------------------------------*/
sNouvCmde = Left ( idwBandeau.GetItemString ( 1, "NOUV_CMDE" ), 2 ) 
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 45 ) // 3 Mob max autorisé
If lDeb > 0 Then
		sDw = "G"
		If IsNumber ( sNouvCmde ) Then
			If Integer ( sNouvCmde ) > 3 Then
				stMessage.sTitre		= "Commandes"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= Ok!
				stMessage.sCode		= "COMD063"

				F_Message ( stMessage )
				Return sDw + "DTE_RDV_CLI"
			End If
		End If
End IF

If idwBandeau.Rowcount ( ) > 0 Then

		sDw = "G"

		If IsNumber ( sNouvCmde ) Then

			// #11 [DCMP080256][EEE_PC_ASUS] 
			// Si le type d'appareil sinistré est PC3, càd PC ASUS+CLE, alors on autorise la sélection de deux
			// Appareils de remplacement, à savoir, le PC et la CLE.

			Choose Case TRUE
					// #13 [FNAC_PROD_ECH_TECH].[20090127140540720]						
					// #14 [CAMARA].[PRESTA_WEB_BOUTIQUE]

					// [WEBSIM2].[FRANCE]
					// [PC10][DIAG_NOMADE]
					Case isTypApp = "PC3" Or bCasBatAmovAlimExt Or bCasWBBetSMS Or bCasWBBetCAF Or isTypApp = "OU1" Or isTypApp =  "OU2" 
						If Integer ( sNouvCmde ) > 2 then
							stMessage.sTitre		= "Commandes"
							stMessage.Icon			= Information!
							stMessage.bErreurG	= FALSE
							stMessage.Bouton		= Ok!
							stMessage.sCode		= "COMD471" // #11
							stMessage.sVAR[1]		= "2" // #11									
							F_Message ( stMessage )
							Return sDw + "DTE_RDV_CLI"
							
						End If
	
				Case Else
					If Integer ( sNouvCmde ) > 1 Then
						stMessage.sTitre		= "Commandes"
						stMessage.Icon			= Information!
						stMessage.bErreurG	= FALSE
						stMessage.Bouton		= Ok!
		//				stMessage.sCode		= "COMD035"
						stMessage.sCode		= "COMD471" // #11
						stMessage.sVAR[1]		= "1" // #11						
		
						F_Message ( stMessage )
						Return sDw + "DTE_RDV_CLI"
					End If
					
			End Choose
		
			// :#11 [DCMP080256][EEE_PC_ASUS] 

		End If
End If

// [PC10][DIAG_NOMADE]
idwArticle.SetRedraw ( False ) // #7
idwArticle.SetFilter ( "CHOIX = 'O'" )
idwArticle.Filter ( )
idwArticle.SetSort ( "ID_TYP_ART" )
idwArticle.Sort ( )

F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 45 ) 
If lDeb <= 0 Then
	lTotDoub = idwArticle.RowCount ()
	sIdTypArtSav = ""
	For lCptDbl = 1 To lTotDoub 
		sIdTypArt = idwArticle.GetItemString ( lCptDbl, "ID_TYP_ART" ) 
		If sIdTypArt = sIdTypArtSav Then
			idwArticle.SetFilter ( sFiltreOrigArticle  )
			idwArticle.filter ()
			idwArticle.SetSort ( sSortOrig )
			idwArticle.Sort ( )
			idwArticle.SetRedraw ( True ) // #7
		
			stMessage.sTitre		= "Commandes"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!
			stMessage.sCode		= "COMD666" // #11
			F_Message ( stMessage )
			Return sDw + "DTE_RDV_CLI"
		End If 
	
		sIdTypArtSav = sIdTypArt 
			
	Next
End If

dcMtTTCCmde = 0 
For lCptDbl = 1 To lTotDoub 
	dcMtTTCCmde += idwArticle.GetItemDecimal ( lCptDbl, "MT_PRIX_TTC" ) 
Next

If dcMtTTCCmde > idcMtPlafcmdeWeb And &
	idcMtPlafcmdeWeb > 0  And &
	( idwwDivDet.Find ( "ID_GTI = " + String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) ) + &
	" AND ID_DETAIL = " +  String ( idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
	" AND UPPER ( NOM_ZONE ) = 'ALT_PEC' " + &
	" AND UPPER ( VAL_LST_CAR ) <> 'O'" &
	, 1, idwwDivDet.RowCount () ) > 0 ) Then 
	
		idwArticle.SetFilter ( sFiltreOrigArticle  )
		idwArticle.filter ()
		idwArticle.SetSort ( sSortOrig )
		idwArticle.Sort ( )
		idwArticle.SetRedraw ( True ) // #7
	
		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "COMD667" // #11
		stMessage.sVar [1]   = String ( dcMtTTCCmde ) + "€"
		stMessage.sVar [2]   = String ( idcMtPlafcmdeWeb ) + "€"
		F_Message ( stMessage )
		Return sDw + "DTE_RDV_CLI"
End If

idwArticle.SetSort ( sSortOrig )
idwArticle.Sort ( )
idwArticle.SetRedraw ( True ) // #7

// :[ITSM79671] 
// [PC10][DIAG_NOMADE]

// [MANTIS4734]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 222 ) 
If lDeb > 0 Then

	lCount = idwCmdeSin.Find ( "ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount () ) + &
				idwCmdeGti.Find ( "ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT <> 'ANN'", 1, idwCmdeGti.RowCount () ) + &
				idwCmdeDet.Find ( "ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT <> 'ANN'", 1, idwCmdeDet.RowCount () ) 
				
	sVal = lnv_String.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "ID_GTI_CONCERNE", ";")					
	bIdGti = False
	If IsNull ( sVal ) Or Trim ( sVal ) = "" Then
		bIdGti = TRUE
	ElseIf Pos ( sVal, "#" + String ( lIdGti ) + "#" ) > 0 Then
		bIdGti = TRUE
	End If

	If idwArticle.Find ( "CHOIX = 'O' AND ID_TYP_ART = 'CAF'", 1, idwArticle.RowCount () ) > 0 And lCount <= 0 And bIdGti Then

		stMessage.sTitre		= "Commandes : Option -DP/222"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "COMD747" // #11
		F_Message ( stMessage )
		Return sDw + "DTE_RDV_CLI"
	End If
End If
// :[MANTIS4734]

/*------------------------------------------------------------------*/
/* Filtre sur toutes les prestations choisies                       */
/*------------------------------------------------------------------*/

idwArticle.SetRedraw ( False ) // #7
idwArticlePrs.SetRedraw ( False ) // #7
idwfourn.SetRedraw ( False ) // #7
idwTypArt.SetRedraw ( False ) // #7

idwArticle.SetFilter ( "CHOIX = 'O'" )
idwArticle.Filter ( )

lTot = idwArticle.RowCount ()

ibMesInfoAff = FALSE
ibAMU_MajContr = False // [PC13442_MOBZEN2]

For lCpt = 1 To lTot

	sIdFour = idwArticle.GetItemString ( lCpt, "ID_FOUR" )
	sIdMarqArt = idwArticle.GetItemString ( lCpt, "ID_MARQ_ART" )
	sIdTypArt = idwArticle.GetItemString ( lCpt, "ID_TYP_ART" )
	sIdRefFour = idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" )
	lInfoSpbfrn = idwArticle.GetItemNumber ( lCpt, "INFO_SPB_FRN" )
	

	// Le produit autorise-t-il la commande WEB pour les assurés
	If sIdFour = "WBA" Then  // #7
		// Autor Cmde Assuré
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 80 )
		If lDeb <= 0 Then 
			sPos = "PROBLEME"
			
			stMessage.sTitre		= "Paramètrage"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sVar[1]		= "un assuré"
			stMessage.sCode		= "COMD432"

			F_Message ( stMessage )			
			
		End If 
	// Le produit autorise-t-il la commande WEB pour les assurés
	ElseIf sIdFour = "WBB" Then  // #7	
		// Autor Cmde Boutique
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 81 )
		IF lDeb <= 0 Then
			sPos = "PROBLEME"
			stMessage.sTitre		= "Paramètrage"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sVar[1]		= "une boutique"
			stMessage.sCode		= "COMD432"

			F_Message ( stMessage )			
			
		End If
	// Le produit autorise-t-il la commande WEB 
	ElseIf Left ( Upper ( sIdFour ), 2 ) = "WB" Then  // #7	
		sPos = "PROBLEME"
		stMessage.sTitre		= "Paramètrage"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sVar[1]		= "un tiers"
		stMessage.sCode		= "COMD432"

		F_Message ( stMessage )			

	// Le produit autorise-t-il la commande de remplacement pour un gestionnaire
	ElseIf Left ( Upper ( sIdFour ), 2 ) <> "WB" Then  // #7	
		// Autor Cmde Gestionnaire
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 79 )
		IF lDeb <= 0 Then
			sPos = "PROBLEME"
			stMessage.sTitre		= "Paramètrage"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "COMD433"

			F_Message ( stMessage )			
			
		End If
	End If

	// [VDOC19600]
	// [PC13313][MANTIS19360]
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 295 ) 
	If lDeb <= 0 Then
		// [DT290]
		Choose Case lInfoSpbFrn
			Case 981, 982, 983, 973, 2141, 2142, 2143, 984
				// Pas de message pour ces process
				
			Case Else
				
				sVal = idwCmde.GetItemString ( 1, "ADR_COD_CIV" )	

				// [DT191-1]
				If lnv_string.of_getkeyvalue (isInfoSpbFrnCplt, "RET_REL_PICK_UP", ";") = "OUI" Then
					sVal = ""							
				End If
				
				If sVal = "5" Then
					stMessage.sTitre		= "vDoc19600 / C. Quertier"
					stMessage.Icon			= Information!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= Ok!
					stMessage.sCode		= "COMD935"
				
					F_Message ( stMessage )
				End If
		End Choose 
	End If 

	If sPos <> "" Then Exit
	
	/*------------------------------------------------------------------*/
	/* Vérification du fournisseur en fonction de la marque, pour les   */
	/* réparations	                                                    */
	/*------------------------------------------------------------------*/
	If sPos = "" Then
		Choose Case sIdTypArt 
		
			Case "PRS" 
				sPos = This.uf_ControlerGestion_prs_FournMarqMob ( sIdFour, sIdTypArt, sIdMarqArt )

				// #8
				if sPos <> "" then exit
				
				sFind  = "ID_TYP_ART = 'PRS' AND COD_ETAT = 'RPC' AND ID_SEQ > 0"
				iFind = idwCmdeSin.find ( sFind, 1, idwCmdeSin.rowcount() ) 
				
				iRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, idwWDivSin.RowCount () )
				if iRow > 0 then sTypApp = Upper ( Trim ( idwWDivSin.GetItemString ( iRow, "VAL_LST_CAR" ) ) )
				
				// [PM280-1]
				bARepGti = lnv_string.of_Getkeyvalue( isInfoSpbFrnCplt, "A_REP_GARANTIE", ";" ) = "OUI"
				
				if iFind > 0 and sTypApp <> "" And Not bARepGti then
					stMessage.sTitre		= "Information"
					stMessage.Icon			= Information!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= OK!
					stMessage.sCode		= "COMD455"

					F_Message ( stMessage )			
				End If
				// FIN - #8


				// [PM200][LOT2][DESOX]
				If lIdEvt = 1377 And idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) = "A_REPARER" Then
					idwArticle.SetItem ( lCpt, "ID_REF_FOUR", "A_DESOXYDER" )
				End If
				// [PM200][LOT2][DESOX]


				// [PM82][LOT2]
				// Si l'on arrive jusque'ici, c'est que le le ueItem5 de la fen de détail a laissé passé 
				// au niveau de la gti 3 mois ou 12 mois, donc pas la peine de refaire ce contrôle.

				// [VDOC19345]
				If Not bARepGti Then
					
					sMess = ""	
					
					// [ITSM453020]
					// [PM222-1]
					sFind  = "POS ( INFO_SPB_FRN_CPLT, 'A_DESOXYDER_SAV=OUI') > 0 AND COD_ETAT IN ( 'RPC', 'RFO') AND STATUS_GC IN ( 22, 23, 2, 21)"
					
					iFind = idwCmdeSin.find ( sFind, 1, idwCmdeSin.rowcount() ) 
					If iFind > 0 Then
						lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "A_CONTROLER_SAV", "OUI", ";")
						If sIdFour = "PSM" Then
							// [PM222-2]
							iRet=uf_get_btqpsm_centralisation(lIdProd, lIdSin, lIdEvt, "A_CONTROLER_SAV", sCodeBtqCentral) 
							If iRet <> 1 Then 
								sCodeBtqCentral = "33"
							End If
							
							lnv_String.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_BTQ_PSM_CENTRALE", sCodeBtqCentral , ";")
						End IF 
						sMess = "COMD828"
					Else
						sFind  = "ID_TYP_ART = 'PRS' AND COD_ETAT IN ( 'RPC', 'RFO') AND ID_SEQ > 0 AND STATUS_GC IN ( 22 )"
						// [PM280-1][MANTIS15171]
						iFind = idwCmdeSin.find ( sFind, 1, idwCmdeSin.rowcount() ) 
						If iFind > 0 Then
							lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "A_DESOXYDER_SAV", "OUI", ";")
							sMess = "COMD712"
						End If
					End If
					// [PM222-1]					
					
					// [MANTIS4831]
					
					// [DT168][MANTIS16681]
					If iFind > 0 Then
						Choose Case sIdFour
							Case "SBE"
								// On change pas l'action
							Case Else 
								idwArticle.SetItem ( lCpt, "ID_REF_FOUR", "A_DESOXYDER" )														
						End Choose
					End If
							
					If sMess <> "" Then
						stMessage.sTitre		= "Information"
						stMessage.Icon			= Information!
						stMessage.bErreurG	= FALSE
						stMessage.Bouton		= OK!
						stMessage.sCode		= sMess
	
						F_Message ( stMessage )			
					End If
				End If 
				// [PM200][LOT2][DESOX]					
				
				
				// [PM280-1][MANTIS15171]
				// [VDOC19345]
				If iFind <=0 And Not bARepGti Then 

					sMess = ""	

					// [ITSM453020]
					sFind  = "POS ( INFO_SPB_FRN_CPLT, 'A_REPARER_SAV=OUI') > 0 AND COD_ETAT IN ( 'RPC', 'RFO') AND STATUS_GC IN ( 2, 21, 22, 23 )"						
					
					iFind = idwCmdeSin.find ( sFind, 1, idwCmdeSin.rowcount() ) 
					If iFind > 0 Then
						lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "A_CONTROLER_SAV", "OUI", ";")
						If sIdFour = "PSM" Then
							// [PM222-2]
							iRet=uf_get_btqpsm_centralisation(lIdProd, lIdSin, lIdEvt, "A_CONTROLER_SAV", sCodeBtqCentral) 
							If iRet <> 1 Then 
								sCodeBtqCentral = "33"
							End If
							
							lnv_String.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_BTQ_PSM_CENTRALE", sCodeBtqCentral , ";")
						End IF 
						sMess = "COMD828"						
					Else
						sFind  = "ID_TYP_ART = 'PRS' AND COD_ETAT IN ( 'RPC', 'RFO') AND ID_SEQ > 0 AND STATUS_GC IN ( 2 )"
						
						iFind = idwCmdeSin.find ( sFind, 1, idwCmdeSin.rowcount() ) 
						
						If iFind > 0 Then
							lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "A_REPARER_SAV", "OUI", ";")
							sMess = "COMD671"								
						End If
					End If

					// [MANTIS4831]
					If iFind > 0 Then
						idwArticle.SetItem ( lCpt, "ID_REF_FOUR", "A_REPARER" )
					End If
					
					If sMess <> "" Then
						stMessage.sTitre		= "Information"
						stMessage.Icon			= Information!
						stMessage.bErreurG	= FALSE
						stMessage.Bouton		= OK!
						stMessage.sCode		= sMess
	
						F_Message ( stMessage )			
					End If
				End If
				// [PM82][LOT2]
				
			// [PC434]
			Case "MAI"
			lRow = idwLstInter.Find ( "COD_INTER = 'A'", 1, idwLstInter.RowCount () )
				If lRow > 0 Then
					sAdrMail= idwLstInter.GetItemString ( lRow, "ADR_MAIL" )
		
					If IsNull ( sAdrMail ) OR Trim ( sAdrMail ) = "" Then
						stMessage.sCode = "COMD658"
						F_Message ( stMessage )
						Return "D" + "RIB_BQ"
					End If
				End if
			// :[PC434]	
				
		End Choose
	End If

	If sPos <> "" Then Exit

	// [VDOC19809]
	if Pos(isInfospbfrncplt,"A_REPARER_SAV=OUI") > 0 Or Pos(isInfospbfrncplt,"A_DESOXYDER_SAV=OUI") > 0 Then
		
		if Pos(isInfospbfrncplt,"A_REPARER_SAV=OUI") > 0 Then 
			sVal="A_REPARER_SAV"
		Else
			sVal="A_DESOXYDER_SAV"
		End if

		If sIdFour = "PSM" Then
			iRet=uf_get_btqpsm_centralisation(lIdProd, lIdSin, lIdEvt, sVal, sCodeBtqCentral) 
			if iRet = 1 Then
				lnv_String.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_BTQ_PSM_CENTRALE", sCodeBtqCentral , ";")
			End if
		End If
	End if
	// :[VDOC19809]
	
	/*------------------------------------------------------------------*/
	/* Contrôle Particulier pour certains fournisseurs.                 */
	/*------------------------------------------------------------------*/
	CHOOSE CASE Upper ( sIdFour )

		/*------------------------------------------------------------------*/
		/* Fournisseur CEGETEL 	 														  */
		/*------------------------------------------------------------------*/
		CASE "CEG"
			sPos = This.uf_ControlerGestion_CEGETEL ( lCpt )

		/*------------------------------------------------------------------*/
		/* Fournisseur DARTY MONTREUIL												  */
		/*------------------------------------------------------------------*/
		CASE "DTY"

			sPos = This.uf_ControlerGestion_DARTY_Tel ( lCpt )
			sPos = This.uf_ControlerGestion_DARTY_Nomade ( lCpt )

		/*------------------------------------------------------------------*/
		/* Fournisseur DARTY SAV TREMBLAY											  */
		/*------------------------------------------------------------------*/
		CASE "DST"
			sPos = This.uf_ControlerGestion_DARTY_Nomade ( lCpt )

		/*------------------------------------------------------------------*/
		/* Fournisseur SBE    	 														  */
		/*------------------------------------------------------------------*/
		CASE "SBE"
			sPos = This.uf_ControlerGestion_SBE ( lCpt ) 

		/*------------------------------------------------------------------*/
		/* #4 Fournisseur MSS    	 													  */
		/*------------------------------------------------------------------*/
		CASE "MSS"
			sPos = This.uf_ControlerGestion_MSS ( lCpt ) 

//		#9 [O2M] Suppression de Ce Controle, qui est en fait dans uf_ControlerGestionEDI_CDiscount()
//		/*------------------------------------------------------------------*/
//		/* Fournisseur CDS      	 													  */
//		/*------------------------------------------------------------------*/
//		CASE "CDS"
//			sPos = This.uf_ControlerGestion_CDiscount ( lCpt ) 
//
		/*------------------------------------------------------------------*/
		/* #6 Fournisseur CORDON  	 													  */
		/*------------------------------------------------------------------*/
		CASE "COR"
			sPos = This.uf_ControlerGestion_CORDON ( lCpt ) 	

		// #10 [SURCOUF_ECH_EXPRESS]
		CASE "SCF"
			sPos = This.Uf_ControlerGestion_SCF ( lCpt ) 	

		//* #12 [FNAC_PROD_ECH_TECH].[SMS]
		CASE "FNC"
			sPos = This.Uf_ControlerGestion_FNAC ( lCpt ) 	

//* #13 [FNAC_PROD_ECH_TECH].[20090127140540720]
		CASE "O2M"
			sPos = This.Uf_ControlerGestion_O2M ( lCpt ) 	

//* #15 [MSS_LOT2]
		CASE "MS1"
			sPos = This.Uf_ControlerGestion_MS1 ( lCpt ) 	

// [PC363_AUCHAN]
		CASE "AUC"
			sPos = This.Uf_ControlerGestion_AUCHAN ( lCpt ) 	

// [PC301].[LOT2]
		CASE "CAR"
			sPos = This.Uf_ControlerGestion_CarrefourLad ( lCpt )

// [GROSBILL].[PC398-403-479]
		CASE "AXA"
			sPos = This.Uf_ControlerGestion_AXA ( lCpt )
	
		CASE "MBS","CVC", "ATC" // [PC10-2] ajout de Converlance
			// [PC13442-2] Ajout ATECH
			// [PC10][DIAG_NOMADE]
			sPos = This.Uf_ControlerGestion_Mobistore	( lCpt )
		/*------------------------------------------------------------------*/
		/* #7 Fournisseur Virtuel Web 												  */
		/*------------------------------------------------------------------*/

		// [PM200][PSM]
		CASE "PSM"
			sPos = This.uf_ControlerGestion_PSM ( lCpt ) 	

		// [PC869]
		CASE "CIS"
			sPos = This.uf_ControlerGestion_CORIOLIS ( lCpt ) 	

		// [PC929-1]
		CASE "SB1"
			sPos = This.Uf_ControlerGestion_SBETV ( lCpt ) 	
		
		// [PC925]
		Case "SRR"
			If sIdTypArt = "PRS" Then
				stmessage.scode="COMD850"
				stmessage.sVar[1]=String(idwwsin.getItemNumber( 1, "ID_SIN")) + "-" + String(this.uf_nouveau_num_sequence( ))
				stmessage.bouton=Ok!
				stMessage.icon=Information!
				f_message(stMessage)
			End if

		// [PC801_6_TAMET]
		CASE "TMT"
			sPos = This.uf_ControlerGestion_TAMET ( lCpt ) 	


		CASE "RDC" 
			// [VDOC18125]
			sPos = This.Uf_ControlerGestion_RueDuCommerce (lCpt)

		// [DT185]
		CASE "CDP" 
			// [DT185]
			sPos = This.Uf_ControlerGestion_CDiscountPRO ( lCpt ) 
		
		// [DT176]
		Case "CMA"
			sPos = This.Uf_ControlerGestion_CMA ( lCpt ) 
			
		// [DT227]
		Case "CAL", "AUT"
			sPos = This.Uf_ControlerGestion_CentreAutoLeclerc ( lCpt ) 

		// [PC151259] // [PC151259-2] // [PC171918]
		Case "EKO", "DGC", "NET", "SMT", "RAV", "RTP", "SFG"
			sPos = This.Uf_ControlerGestion_EKO_NET_DGC ( lCpt ) 

		// [DT363]
		Case "AAS"
			sPos = This.Uf_ControlerGestion_AAS ( lCpt ) 			

		// [DT363]
		Case "BK2"
			sPos = This.Uf_ControlerGestion_BAK2 ( lCpt ) 			

		// [DT361]
		Case "CEA"
			sPos = This.Uf_ControlerGestion_CEAT ( lCpt )
		
		// [RS4093_EVOL_ELD]
		Case "ELD"

			// [RS4093_EVOL_ELD]
			If F_CLE_A_TRUE ( "RS4093_CUT_PRS_ELD" ) Then
				stMessage.sTitre		= "Commandes ELectropdépôt"
				stMessage.Icon			= Exclamation!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= Ok!
				stMessage.sCode		= "GENE013"
				stMessage.sVar[1]		= "Les commandes ElectroDépôt sont suspendues pour l'instant, cette contrainte est liée à une évolution en cours de mise en production. Réglez en numéraire ou bien attendez quelques jours pour créer la prestation, vous serez averti lorsque ce sera de nouveau possible."
				F_Message ( stMessage )
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"
			End If

		// [HP252_276_HUB_PRESTA]
		Case "HUB"
			sPos = This.Uf_ControlerGestion_HUB ( lCpt )

			
		CASE ELSE
			If Left ( Upper ( sIdFour ), 2 ) = "WB" Then  // #7
				sPos = This.uf_ControlerGestion_WBX ( lCpt ) 	// #7

				If sPos = "" Then
					If idwFourn.Find ( "ID_CODE_FRN='CEG'", 1, idwFourn.RowCount () ) > 0 Then
						sPos = This.uf_ControlerGestion_CEGETEL ( lCpt )
					End If 
				End If 
				
			End If


	END CHOOSE

	If sPos <> "" Then Exit

Next

/*------------------------------------------------------------------*/
/* #1 CAG 16/06/2003                                                */
/*------------------------------------------------------------------*/
/* #2 CAG 04/08/2003                                                */
/*------------------------------------------------------------------*/
/* JFF le 04/11//2004 : Ce contrôle n'est plus nécéssaire avec le   */
/* projet Equiv. Fct, il est fait en amont.								  */
/*------------------------------------------------------------------*/
/*
If sPos = "" Then
	idwArticle.SetFilter ( "CHOIX = 'O' AND ID_TYP_ART = 'PRS'" )
	idwArticle.Filter ( )
	lTot = idwArticle.RowCount ()

	idwArticlePrs.GetChild ( "ID_MARQ_ART", dwChild )
	For lCpt = 1 To lTot
		sMarq = idwArticlePrs.GetItemString ( lCpt, "ID_MARQ_ART" )
		// ctrl de la validité du champ si le gestionnaire n'y a pas touché (=> ctrl de marque provenant des adh)
		If Not IsNull ( sMarq ) And Trim ( sMarq ) <> "" Then
			sFind = "LIB_CODE = '" + sMarq + "'"
			lRow = dwChild.Find ( sFind, 1, dwChild.RowCount () )
			If lRow <= 0 Then
				stMessage.sCode = "WSIN410"
				stMessage.sVar [ 1 ] = "La marque de l'appareil"
				F_Message ( stMessage )
				sDw = "G"
				Return sDw + "ID_MARQ_ART"
			End If

		End If

		// ctrl de saisie de marque si saisie modèle
		sModl = idwArticlePrs.GetItemString ( lCpt, "ID_MODL_ART" )
		If Not IsNull ( sModl ) And Trim ( sModl ) <> "" Then
			If IsNull ( sMarq ) Or Trim ( sMarq ) = "" Then
				stMessage.sCode = "WSIN420"
				F_Message ( stMessage )
				sDw = "G"
				Return sDw + "ID_MARQ_ART"
			End If
		End If

		// mise à null de la marque si elle est effacée
		If Trim ( sMarq ) = "" Then
			SetNull ( sNull )
			idwArticle.SetItem ( 1, "MARQ_PORT", sNull )
		End If

	Next
End If
*/

// [VDoc5944]
If sPos=""  Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 152 )
	If lDeb > 0 And idwDetail.GetItemNumber ( 1, "ID_GTI" ) = 15 Then
		// [VDOC14351] msg uniquement si cmd de remplacement
		If idwArticle.Find ( "CHOIX = 'O' AND ID_TYP_ART in ('CAF','EDI') ", 1, idwArticle.RowCount () ) <= 0 Then
			stMessage.berreurg=FALSE
			stMessage.bouton=YesNo!
			stMessage.icon=Question!
			stMessage.scode="COMD677"
			stMessage.sTitre="Commandes"
			
			if f_Message(stMessage) = 2 Then
				sPos="DADR_LIVR1"
			End if
		End if
	End if
End if
// :[VDoc5944]

// [VDOC17593]
If sPos=""  Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 280 )
	If lDeb > 0 Then
		If idwArticle.Find ( "CHOIX = 'O' AND ID_TYP_ART='CAF'", 1, idwArticle.RowCount () ) > 0 Then
			stMessage.berreurg=FALSE
			stMessage.bouton=YesNo!
			stMessage.icon=Question!
			stMessage.scode="COMD677"
			stMessage.sTitre="Commandes"
			
			if f_Message(stMessage) = 2 Then
				sPos="DADR_LIVR1"
			End if
		End if
	End if
End if
// :[VDOC17593]

If ibPbleParamFrn Then
	stMessage.sTitre		= "Commandes"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "COMD427"

	F_Message ( stMessage )
	Return sDw + "DTE_RDV_CLI"
End If

// [PM103][1]
If gbModeReprise_223 Then
	lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "PRESTA_REPRISE_BASE_MANUELLE", "OUI", ";")
End If

// [PC938_ORANGE_V3]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 239 ) 
If lDeb > 0 Then
	If Not gProcessTempoOrangeV3 And idwArticle.Find ( "CHOIX = 'O' AND ID_TYP_ART = 'PST'", 1, idwArticle.Rowcount() ) > 0 Then
		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "COMD792"
	
		F_Message ( stMessage )
		Return sDw + "DTE_RDV_CLI"
		
	End If

	If gProcessTempoOrangeV3 And idwArticle.Find ( "CHOIX = 'O' AND ID_TYP_ART = 'PST'", 1, idwArticle.Rowcount() ) > 0 Then
		If lIdEvt <> 1396 Then
			stMessage.sTitre		= "Commandes"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!
			stMessage.sCode		= "COMD794"
		
			F_Message ( stMessage )
			Return sDw + "DTE_RDV_CLI"			
		End If
	End If
	
	If idwArticle.Find ( "CHOIX = 'O' AND ID_TYP_ART = 'RES'", 1, idwArticle.Rowcount() ) > 0 Then

		// PC938_ORV3_M8086
		lRow1 = idwCmdeSin.Find("ID_FOUR IN ('O2M') AND ID_GTI IN ( 10, 11, 24 ) AND POS ( INFO_SPB_FRN_CPLT, 'TYP_RELAI=PRET') > 0 AND STATUS_GC IN ( 262, 233 ) AND COD_ETAT NOT IN ( 'ANN' )",1,idwCmdeSin.RowCount()) 
		lRow2 = idwCmdeSin.Find("ID_FOUR IN ('PSM') AND ID_GTI IN ( 10, 11, 24 ) AND ID_TYP_ART = 'REL' AND COD_ETAT NOT IN ( 'ANN') ",1,idwCmdeSin.RowCount()) 
		lRow3 = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'CONS_APPPRETVOL'", 1, idwWDivSin.RowCount () )

		If lRow3> 0 Then 
			bConsAppPretVol = Upper ( Trim ( idwWDivSin.GetItemString ( lRow3, "VAL_LST_CAR" ) ) ) = "O"
		End If	

		If Not ( lRow1 > 0 And lRow2 <= 0 And Not bConsAppPretVol And lIdEvt = 1398 ) Then
			stMessage.sTitre		= "Commandes"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!
			stMessage.sCode		= "COMD809"
		
			F_Message ( stMessage )
			Return sDw + "DTE_RDV_CLI"			
		End If
		
		If idwArticle.Find ( "CHOIX = 'O' AND ID_TYP_ART = 'REA'", 1, idwArticle.Rowcount() ) > 0 Then

			lRow1 = idwCmdeSin.Find("ID_FOUR IN ('O2M') AND ID_GTI IN ( 11, 24 ) AND POS ( INFO_SPB_FRN_CPLT, 'TYP_RELAI=PRET') > 0 ",1,idwCmdeSin.RowCount()) 
			lRow2 = idwCmdeSin.Find("ID_FOUR IN ('O2M') AND ID_GTI IN ( 11, 24 ) AND ID_TYP_ART = 'PRS'",1,idwCmdeSin.RowCount()) 

			If Not ( lRow1 <= 0 And lRow2 <= 0 And lIdEvt = 1410 ) Then
				stMessage.sTitre		= "Commandes"
				stMessage.Icon			= Exclamation!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= Ok!
				stMessage.sCode		= "COMD813"
			
				F_Message ( stMessage )
				Return sDw + "DTE_RDV_CLI"			
			End If
		End If			
	End If
End If

// [PM234-4_V1]
// [PM280-2]
If bDeclaWebAtlas Then

	// [PM280-2]
	Choose Case lIdEvt
		Case 1422, 1429
			// Ok, pas de blocage
		Case Else
			If idwArticle.Find ( "CHOIX = 'O' AND ID_TYP_ART = 'PRS'", 1, idwArticle.RowCount () ) > 0 Then
				stMessage.sTitre		= "Commandes"
				stMessage.Icon			= Exclamation!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= Ok!
				stMessage.sCode		= "P234016"
			
				F_Message ( stMessage )
			End If
	End Choose 
		
End If
// /[PM234-4_V1]

// [VDOC17789]
Choose Case sIdRefFour
	Case "A_REPARER", "A_DIAGNOSTIQUER"
		If isMarqPortAdh = "APPLE" And sPos = "" Then
			stMessage.sTitre		= "Commandes"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!
			stMessage.sCode		= "V017789"
		
			F_Message ( stMessage )
		End If
End Choose
// [VDOC17789]


lRow = idwCmdeSin.Find ( "ID_GTI = " + String ( lIdGti ) + " AND ID_DETAIL = " + String ( lIdDetail ) + " AND ID_REF_FOUR IN ( 'A_REPARER', 'A_DIAGNOSTIQUER', 'A_DESOXYDER' )", 1, idwCmdeSin.RowCount ())
lRow1 = idwArticle.Find ( "CHOIX = 'O' AND ID_REF_FOUR IN ( 'A_REPARER', 'A_DIAGNOSTIQUER', 'A_DESOXYDER' )", 1, idwArticle.RowCount () ) 
If lRow > 0 And lRow1 > 0 Then
		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "COMD915"
	
		F_Message ( stMessage )
		Return sDw + "DTE_RDV_CLI"		
End If

// [DT288]
If isChoixAction = "C" And sIdFour <> "COR" Then 
	lRow = idwCmdeSin.Find ( "ID_FOUR = 'COR' AND COD_ETAT <> 'ANN' AND POS ( INFO_FRN_SPB_CPLT, 'SWAP_AUTO_CTR=OUI' ) > 0", 1, idwCmdeSin.RowCount ())
	If lRow > 0 Then
		stMessage.sTitre		= "DT288 : Condition commande CORDON"
		stMessage.Icon			= information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode = "COMD962"
		F_Message ( stMessage )
		Return "G" + "RIB_BQ"		
	End If
End If

// [ITSM574876]
If sIdRefFour = "REFUSE_A_REEXP" Then
	lRow = idwCmdeSin.Find ( "ID_REF_FOUR = 'CONTEST_SUR_REMPL' AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount ())
	If lRow > 0 Then
		sVal = idwCmdeSin.GetItemString ( lRow, "ID_SERIE_ANC" ) 
	End IF 		
End If 

Return sPos

end function

public function boolean uf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_PreparerValider (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 06/09/2001
//* Libellé			: 
//* Commentaires	: Validation de la commande en saisie
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: Boolean
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG 	 28/02/2003	  Cas de pls prestations : ajout d'un tri
//*										sort de l'objet ne marche pas, il
//*										faut le faire en dyn.
//* #2	 CAG	 20/03/2003	  DCMP 030161 : 1) si pls frn => msg + 2) si l'une des cmds/prs du sinistre a déjà
//*												    été envoyée chez Cetelec, modification de l'adresse par celle de Cetelec
//* #3	 JFF	 02/01/2004	  DCMP 030483 : Pour une sélection de mobile à placer sur le courrier il simplement mémoriser
//*													 les mobiles choisis sans créer de commandes.
//* #4    MADM  16/02/2006   DCMP 050532 : Ajout de 2 colonnes à la Table Commande (id_marq_art_ifr,id_modl_art_ifr) 
//* #5	 JCA	 12/06/2006   Mail Push : Suppression appel uf_preparervalider_mail()
//* #6    JFF	 06/02/2006   [SITE_CMDE] Gestion des nouvelles option d'autorisation 79, 80, 81
//* #7    JFF   04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
//* #8    PHG   10/12/2007	  [O2M]	Gestion O2M : Inscription des Frais d'envoi, via uf_PréparerValider_O2M
//* #9 	 JFF	 20/10/2008	  [FNAC_PROD_ECH_TECH]
//* #10	 JFF	 28/10/2008	  [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767]
//* #11   JFF   02/03/2010   [MSS_LOT2]
//*       JFF   30/06/2010   [PC363_AUCHAN]
//*       JFF   05/07/2011   [PC292][AUCHAN]
//*       JFF   27/10/2011   [ITSM85986]
//*       FPI   28/11/2011   [PR09] Ajout du fournisseur GAME
//*       JFF   05/01/2012   [RECUP_DONNEE_O2M]
//* 		FPI	06/02/2012	[PR09.2] Renforcement de contrôles pour le WS Game
//        JFF   01/03/2012  [CONFO][MEUBLE][PC542]
//        JFF   01/03/2012  [CONFO][LITERIE][PC543]
//       JFF     17/04/2012   [PM200][LOT2][DESOX]
//        JFF   23/05/2012   [PM103][1]
//        JFF   31/07/2012   [MANTIS3929]
//        JFF   30/08/2012   [VDOC8041]
//        JFF   07/05/2013   [PC938_ORANGE_V3]
//        JFF   18/04/2013   [VDOC14131]
//        JFF   07/04/2015   [PC13442-1]
//        JFF   02/06/2015   [PC13442-1][MANTIS15246]
//        JFF   10/12/2015   [PC13442-1MT17865]
//        JFF   28/06/2016   [PC151549]
//        JFF   25/04/2018   [VDOC26046]
// 		 JFF   23/11/2018   [ITSM574876]
//        JFF   07/03/2024   [HP252_276_HUB_PRESTA]
//*---------------------------------------------------------------

Boolean bRet
Long	lTot, lCpt, lSeqMax, lSeqMax1, lSeqMax2, lSeq, lInfoSpbFrn , lRow, lDeb, lFin, lIdEvt, lVal1, lIdGti, lDeb1, lFin1
String	sNull, sAdrCpl, sVal, sVal1, sInfoSpbFrnCpltAutrePresta, sCasPrestaSuppl
Date		dNull
Integer iMethode205 
n_cst_string lnvPFCString

lIdEvt = idwDetail.GetItemNumber ( 1, "ID_EVT" ) // [PM200][LOT2][DESOX]
lIdGti = idwDetail.GetItemNumber ( 1, "ID_GTI" )
sCasPrestaSuppl = ""

// #11 [MSS_LOT2]
If ibReouvPresta Then
	bRet = This.Uf_PreparerValider_MajPresta ( )
	Return bRet
End If
// :#11 [MSS_LOT2]

// [VDOC8041]
If ibReouvPrestaO2M Then
	bRet = This.Uf_PreparerValider_MajPrestaO2M ( ) // [VDOC8041] à implémenter
	Return bRet
End If
// [VDOC8041]

// [PC292][AUCHAN]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 179 )
If lDeb > 0 Then
	idwArticle.SetFilter ( "ID_FOUR = 'SB1' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND CHOIX = 'O'" )
	idwArticle.Filter ()
	
	If idwArticle.Rowcount () > 0 Then
		idwArticle.SetFilter ( "ID_FOUR = 'O2M' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER'" )
		idwArticle.Filter ()

		If idwArticle.Rowcount () > 0 Then
			idwArticle.SetItem ( 1, "CHOIX", "O" )
			idwArticle.SetItem ( 1, "PROBLEME", "POUR O2M => NE RIEN DIAGNOSTIQUER, Prestation passée uniquement pour le retour de proposition en zone sérialisée." )
			idwArticle.SetItem ( 1, "INFO_SPB_FRN", 964 )			
		End If
	End If
End If
// :[PC292][AUCHAN]

// [RECUP_DONNEE_O2M]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 205 )
If lDeb > 0 Then
	iMethode205 = Integer ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "METHODE", ";")) 
	lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'RECUP_DONNEES'", 1, idwWDivSin.RowCount () ) 
	If lRow > 0 Then
		sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
	End If

	idwArticle.SetFilter ( "ID_FOUR <> 'O2M' AND ID_TYP_ART = 'TEL' AND POS ( ID_MODL_ART, 'IPHONE') > 0 AND CHOIX = 'O'" )
	idwArticle.Filter ()
	
	// [MANTIS3929]
	lVal1 = idwCmdeSin.Find ( "ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount () )
	If lVal1 > 0 Then
		sVal1 = lnvPFCString.of_getkeyvalue (idwCmdeSin.GetItemString ( lVal1, "INFO_FRN_SPB_CPLT" ), "CGU_PRESENT", ";")
	End If			
	// [MANTIS3929]
	
	If idwArticle.Rowcount () > 0 And iMethode205 = 2 And sVal = "O" And sVal1 = "OUI" Then
		idwArticle.SetFilter ( "ID_FOUR = 'O2M' AND ID_TYP_ART = 'PCM'" )
		idwArticle.Filter ()			
		If idwArticle.Rowcount () > 0 Then
			idwArticle.SetItem ( 1, "CHOIX", "O" )
		End If
	End IF
End If
// [RECUP_DONNEE_O2M]

// [CONFO][MEUBLE][PC542]
// [CONFO][LITERIE][PC543]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 207 )
If lDeb > 0 Then
	idwArticle.SetFilter ( "ID_FOUR = 'BLC' AND ID_TYP_ART = 'EDI' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND CHOIX = 'O'" )
	idwArticle.Filter ()

	If idwArticle.Rowcount () > 0 Then
		idwArticle.SetFilter ( "ID_FOUR = 'O2M' AND ID_REF_FOUR = 'A_RECUP_A_RECYCLER'" )
		idwArticle.Filter ()
	
		If idwArticle.Rowcount () > 0 Then
			idwArticle.SetItem ( 1, "CHOIX", "O" )
			
			// [VDOC26046]
			idwArticle.SetItem ( 1, "PROBLEME", "POUR O2M => O2M doit aller chercher le matériel chez l'assuré pour un Diag de principe." )
			idwArticle.SetItem ( 1, "INFO_SPB_FRN", 1506 )			
		End If
	End If
End If

// [PC938_ORANGE_V3]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 239	)
If lDeb > 0 Then
	idwArticle.SetFilter ( "ID_FOUR = 'O2M' AND ID_TYP_ART NOT IN ('PRS', 'EDI') AND CHOIX = 'O'")
	idwArticle.Filter ()

	If idwArticle.Rowcount () > 0 And Pos ( isInfoSpbFrnCplt, "RELAI_BTQ_PSM=OUI") > 0 And Pos ( isInfoSpbFrnCplt, "TYP_RELAI=PRET" ) > 0 Then
		idwArticle.SetFilter ( "ID_FOUR = 'PSM' AND ID_TYP_ART = 'REL' AND ID_REF_FOUR = 'RELAI_BTQ'" )
		idwArticle.Filter ()
	
		If idwArticle.Rowcount () > 0 Then
			idwArticle.SetItem ( 1, "CHOIX", "O" )

			sInfoSpbFrnCpltAutrePresta = "CODE_BTQ_RELAI_PSM=" + isCodeBoutiqueRelaiPSM + ";TYP_RELAI=PRET;CODE_BTQ_PSM_PROXIMITE=" + isCodeBoutiqueRelaiPSM 
			idwArticle.SetItem ( 1, "PROBLEME", "O2M vous envoie un appareil de prêt pour l'assuré qui passera le chercher en boutique une fois que vous aurez répondu à cette prestation comme quoi vous avez reçu l'appareil" )
			idwArticle.SetItem ( 1, "INFO_SPB_FRN", 2135 )			
		End If
	End If
	
	idwArticle.SetFilter ( "ID_FOUR = 'O2M' AND ID_TYP_ART NOT IN ('PRS', 'EDI') AND CHOIX = 'O'")
	idwArticle.Filter ()

	If idwArticle.Rowcount () > 0 And Pos ( isInfoSpbFrnCplt, "RELAI_BTQ_PSM=OUI") > 0 And Pos ( isInfoSpbFrnCplt, "TYP_RELAI=REMPL" ) > 0 Then
		idwArticle.SetFilter ( "ID_FOUR = 'PSM' AND ID_TYP_ART = 'REL' AND ID_REF_FOUR = 'RELAI_BTQ'" )
		idwArticle.Filter ()
	
		If idwArticle.Rowcount () > 0 Then
			idwArticle.SetItem ( 1, "CHOIX", "O" )

			sInfoSpbFrnCpltAutrePresta = "CODE_BTQ_RELAI_PSM=" + isCodeBoutiqueRelaiPSM + ";TYP_RELAI=REMPL;CODE_BTQ_PSM_PROXIMITE=" + isCodeBoutiqueRelaiPSM 
			idwArticle.SetItem ( 1, "PROBLEME", "O2M vous envoie un appareil de remplacement définitif pour l'assuré qui passera le chercher en boutique une fois que vous aurez répondu à cette prestation comme quoi vous avez reçu l'appareil" )
			idwArticle.SetItem ( 1, "INFO_SPB_FRN", 2136 )			
			
			If ( lIdGti = 11 Or lIdGti = 24) And idwCmdeSin.Find ( "ID_TYP_ART = 'PRS' AND COD_ETAT <> 'ANN' ", 1, idwCmdeSin.RowCount ()) <= 0 Then
				lnvPFCString.of_setkeyvalue( sInfoSpbFrnCpltAutrePresta, "APP_SIN_A_RECUPERER", "OUI", ";")
				sCasPrestaSuppl = "DIAG/980"
			End IF
			
		End If
	End If

	idwArticle.SetFilter ( "ID_FOUR = 'O2M' AND ID_TYP_ART NOT IN ('PRS', 'EDI', 'PST', 'RES' ) AND CHOIX = 'O'")
	idwArticle.Filter ()

	If idwArticle.Rowcount () > 0 And idwCmdeSin.Find ( "ID_TYP_ART = 'PRS' AND COD_ETAT <> 'ANN' ", 1, idwCmdeSin.RowCount ()) <= 0 Then
		If ( lIdGti = 11 Or lIdGti = 24) And idwCmdeSin.Find ( "ID_TYP_ART = 'PRS' AND COD_ETAT <> 'ANN' ", 1, idwCmdeSin.RowCount ()) <= 0 Then
			lnvPFCString.of_setkeyvalue( sInfoSpbFrnCpltAutrePresta, "APP_SIN_A_RECUPERER", "OUI", ";")
		
			// [PC938_ORV3_M8086]
			lRow = idwCmdeSin.Find ( "ID_FOUR = 'O2M' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT <> 'ANN'", 1 , idwCmdeSin.RowCount () )
			If lRow <= 0 Then
				sCasPrestaSuppl = "DIAG/980"
			End IF
		End IF
	End If		
End If
// :[PC938_ORANGE_V3]


// [PC13442-1]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 274	)
// [PC13442-1][MANTIS15246]
lRow = idwWDivSin.Find ( "NOM_ZONE = 'ech_express_48h' AND VAL_CAR = 'O'", 1, idwWDivSin.RowCount () ) 

If lDeb > 0 And lRow > 0 Then
	// [PC13442-1MT17865]
	If lIdGti = 11 Then
		
		// [PC151549]
		idwArticle.SetFilter ( "ID_FOUR IN ( 'MBS', 'BST') AND ID_TYP_ART NOT IN ('PRS', 'EDI', 'AEF' ) AND CHOIX = 'O'")		
		
		idwArticle.Filter ()
		
		If idwArticle.Rowcount () > 0 Then
			lRow = idwCmdeSin.Find ( "ID_FOUR = 'O2M' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT <> 'ANN'", 1 , idwCmdeSin.RowCount () )
			If lRow <= 0 Then
				sCasPrestaSuppl = "DIAG/980_MBZ2"
			End IF
		End If			
	End If			
End If
// [PC13442-1]


SetNull ( sNull )
SetNull ( dNull )

idwArticle.SetRedraw ( FALSE )
idwArticlePrs.SetRedraw ( FALSE )
lSeqMax = Long ( idwCmdeSin.Describe ( "Evaluate ( 'max (id_seq)', 0 )") )
lSeqMax1 = Long ( idwCmdeDet.Describe ( "Evaluate ( 'max (id_seq)', 0 )") )
lSeqMax2 = Long ( idwCmdeGti.Describe ( "Evaluate ( 'max (id_seq)', 0 )") )

/*------------------------------------------------------------------*/
/* Il peut déjà y avoir des commandes au niveau détail              */
/*------------------------------------------------------------------*/
If lSeqMax1 > lSeqMax Then lSeqMax = lSeqMax1
If lSeqMax2 > lSeqMax Then lSeqMax = lSeqMax2

/*------------------------------------------------------------------*/
/* On insert le nombre de lignes nécessaire dans la DW des           */
/* commandes, sachant qu'il y en a déjà une.                        */
/*------------------------------------------------------------------*/
idwArticle.SetFilter ( "CHOIX = 'O'" )
idwArticle.Filter ( )

/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
If idwArticle.Visible Then
	idwArticle.SetSort ( 'MT_PRIX_TTC A, ID_MARQ_ART A, ID_MODL_ART A')
Else
	idwArticle.SetSort ( 'MT_PRIX_TTC A, ID_MARQ_ART A, ID_MODL_ART A')
End If
idwArticle.Sort ( )

lTot = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* On supprime les espaces des n° de Tel seulement pour les n°      */
/* Français à 10 Chiffres.                                          */
/*------------------------------------------------------------------*/
idwCmde.SetItem ( 1, "ADR_TEL1", F_Format_Num_Tel ( idwCmde.GetItemString ( 1, "ADR_TEL1" ), FALSE ) )
idwCmde.SetItem ( 1, "ADR_TEL2", F_Format_Num_Tel ( idwCmde.GetItemString ( 1, "ADR_TEL2" ), FALSE ) )
idwCmde.SetItem ( 1, "ADR_TEL3", F_Format_Num_Tel ( idwCmde.GetItemString ( 1, "ADR_TEL3" ), FALSE ) )

For lCpt = 1 To lTot - 1
	idwCmde.RowsCopy ( 1, 1, Primary!, idwCmde, idwCmde.RowCount (), Primary! )
Next

Choose Case sCasPrestaSuppl 
	// [PC13442-1]
	Case "DIAG/980", "DIAG/980_MBZ2"
		idwCmde.RowsCopy ( 1, 1, Primary!, idwCmde, idwCmde.RowCount (), Primary! )			
End Choose

/*------------------------------------------------------------------*/
/* On populise maintenant la Dw des commandes.                      */
/*------------------------------------------------------------------*/
For lCpt = 1 To lTot


	// [HP252_276_HUB_PRESTA]
	If F_CLE_A_TRUE ( "HP252_276_HUB_PRESTA" ) Then

		sVal = F_CLE_VAL ( "HP_ID_HUB_PRESTA", isInfoSpbFrnCplt, ";" ) 
		If Trim ( sVal ) <> "" Then 
			sVal = lnvPFCString.of_Getkeyvalue( isInfoSpbFrnCplt, "HP_ID_FOUR", ";" )
			If sVal <> "" Then
				idwCmde.SetItem ( lCpt, "ID_FOUR", sVal )
			End If 
		Else 
			idwCmde.SetItem ( lCpt, "ID_FOUR", idwArticle.GetItemString ( lCpt, "ID_FOUR" ) )			
		End If 
		
	Else
		idwCmde.SetItem ( lCpt, "ID_FOUR", idwArticle.GetItemString ( lCpt, "ID_FOUR" ) )
	End If	
	
	
	idwCmde.SetItem ( lCpt, "ID_TYP_ART"	, idwArticle.GetItemString ( lCpt, "ID_TYP_ART" ) )
	idwCmde.SetItem ( lCpt, "ID_MARQ_ART"	, idwArticle.GetItemString ( lCpt, "ID_MARQ_ART" ) )
	idwCmde.SetItem ( lCpt, "ID_MODL_ART"	, idwArticle.GetItemString ( lCpt, "ID_MODL_ART" ) )
	idwCmde.SetItem ( lCpt, "ID_SERIE_ANC"	, idwArticle.GetItemString ( lCpt, "ID_SERIE_ANC" ) )
	idwCmde.SetItem ( lCpt, "PROBLEME"	   , idwArticle.GetItemString ( lCpt, "PROBLEME" ) )
	
	// [ITSM574876]
	IF idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) = "REFUSE_A_REEXP" Then
		lRow = idwCmdeSin.Find ( "ID_REF_FOUR = 'CONTEST_SUR_REMPL' AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount () )
		If lRow > 0 Then
			sVal = idwCmdeSin.GetItemString ( lRow, "ID_SERIE_ANC" )
			idwCmde.SetItem ( lCpt, "ID_SERIE_ANC", sVal )
		End IF 
	End If

	// #6 Pour les commandes Web, on place la valeur du plafond dans 
	If Left ( idwArticle.GetItemString ( lCpt, "ID_FOUR" ), 2 ) = "WB" Then
		idwCmde.SetItem ( lCpt, "MT_TTC_CMDE", idcMtPlafcmdeWeb )
	// #10 [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767] // [PC363_AUCHAN]
	ElseIf idwArticle.GetItemString ( lCpt, "ID_TYP_ART" ) = "CAF" Then
		// Pas de cmde Web, mais idcMtPlafcmdeWeb contient tout simplement le mt_pec.
		idwCmde.SetItem ( lCpt, "MT_TTC_CMDE", idcMtPlafcmdeWeb )		
	Else
		idwCmde.SetItem ( lCpt, "MT_TTC_CMDE", idwArticle.GetItemDecimal ( lCpt, "MT_PRIX_TTC" ) )
	End If
	
	/*------------------------------------------------------------------*/
	/* Modification SFR # le 04/10/02 : Ajout des colonnes              */
	/* supplémentaires (dte_ret_pret reste à null)				           */
	/*------------------------------------------------------------------*/
	idwCmde.SetItem ( lCpt, "ID_BSP"				, 0 )
	idwCmde.SetItem ( lCpt, "ID_REF_FOUR"		, idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) )

   // #6 Pour les commandes Web, on place la valeur du plafond dans 
	If Left ( idwArticle.GetItemString ( lCpt, "ID_FOUR" ), 2 ) = "WB" Then
		idwCmde.SetItem ( lCpt, "ID_ORIAN_MARQUE"	, 1 )
	Else
		idwCmde.SetItem ( lCpt, "ID_ORIAN_MARQUE"	, 0 )
	End If 

	idwCmde.SetItem ( lCpt, "ID_ORIAN_MODELE"	, 0 )
   /*----------------------------------------------------------------------*/
   /* #4    MADM  16/02/2006   DCMP 050532 : Ajout de 2 colonnes à la Table*/
   /*          Commande (id_marq_art_ifr,id_modl_art_ifr)                  */
   /*----------------------------------------------------------------------*/
   idwCmde.SetItem ( lCpt, "ID_MARQ_ART_IFR"	, idwArticle.GetItemString ( lCpt, "ID_MARQ_IFR" ) )
   idwCmde.SetItem ( lCpt, "ID_MODL_ART_IFR"	, idwArticle.GetItemString ( lCpt, "ID_MODL_IFR" ) )

	lInfoSpbFrn = idwArticle.GetItemNumber ( lCpt, "INFO_SPB_FRN" ) 
	If lInfoSpbFrn < 0 Then	SetNull ( lInfoSpbFrn ) 

	idwCmde.SetItem ( lCpt, "INFO_SPB_FRN"	, lInfoSpbFrn )
	
	//* #1 [FNAC_PROD_ECH_TECH]
	idwCmde.SetItem ( lCpt, "INFO_SPB_FRN_CPLT", isInfoSpbFrnCplt )

	// [PC938_ORANGE_V3]
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 239 )
	If lDeb > 0 Then
		If idwArticle.GetItemString ( lCpt, "ID_FOUR" ) = "PSM" And idwArticle.GetItemString ( lCpt, "ID_TYP_ART" ) = "REL" Then
			idwCmde.SetItem ( lCpt, "INFO_SPB_FRN_CPLT", sInfoSpbFrnCpltAutrePresta )				
		End If		
	End IF
	// [PC938_ORANGE_V3]

Next

// [PC938_ORANGE_V3]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 239 )
// [PC13442-1]
F_RechDetPro ( lDeb1, lFin1, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 274 )
If lDeb > 0 Or lDeb1 > 0 Then
	If sCasPrestaSuppl <> "" Then
		This.uf_PreparerValider_Presta_Suppl (sCasPrestaSuppl, lTot + 1 )
	End If
End If

/*------------------------------------------------------------------*/
/* On complémente et on vérifier les commandes pour c-Discount      */
/*------------------------------------------------------------------*/
This.uf_PreparerValider_CDiscount ()

//* #8  [O2M] Inscription des Frais d'envoi
This.uf_PreparerValider_O2M()


// [PR09.2]// [PM103][1]
If Not gbModeReprise_223 Then
	bRet=This.uf_preparerValider_GAME() //  [PR09] 
	If Not bRet Then Return FALSE // 	[PR09.2]
End If 
// :[PR09.2]

/*------------------------------------------------------------------*/
/* Numérotation des commandes, en fonction de celle déjà existant   */
/* sur le sinistre.                                                 */
/*------------------------------------------------------------------*/
lTot = idwCmde.RowCount ()
For lCpt = 1 To lTot
	idwCmde.SetItem ( lCpt, "ID_SEQ", lSeqMax + lCpt )

	/*------------------------------------------------------------------*/
	/* #2                                                               */
	/*------------------------------------------------------------------*/
	If ibInsCmdeCEG Then
		lSeq = lSeqMax + lCpt
		sAdrCpl = idwCmde.GetItemString ( lCpt, "ADR_LIVR_CPL")
		sAdrCpl += " " + String ( idwWSin.GetItemNumber ( 1, "ID_SIN" ) ) + "-" + String ( lSeq ) + " " + &
					  idwCmde.GetItemString ( lCpt, "ADR_TEL1")
		idwCmde.SetItem ( lCpt, "ADR_LIVR_CPL", sAdrCpl )
 
	End If

	// Pour les commandes différentes des prestations
	If idwCmde.GetItemString ( lCpt, "ID_TYP_ART" ) <> "PRS" Then
		idwCmde.SetItem ( lCpt, "DTE_RDV_CLI", dNull )
		idwCmde.SetItem ( lCpt, "HRDV_CLI_MIN", sNull )
		idwCmde.SetItem ( lCpt, "HRDV_CLI_MAX", sNull )
	End If

	// [VDOC14131]
	Choose Case sCasPrestaSuppl 
		// [PC13442-1]
		Case "DIAG/980", "DIAG/980_MBZ2"
			If idwCmde.GetItemString ( lCpt, "ID_REF_FOUR" )  = "A_DIAGNOSTIQUER" Then
				idwCmde.SetItem ( lCpt, "ID_SERIE_ANC", idwWsin.GetItemString ( 1, "NUM_IMEI_PORT" ) )
			End If
	End Choose

Next

/*------------------------------------------------------------------*/
/* On met à jour la petite Dw des compteurs.                        */
/*------------------------------------------------------------------*/
Choose Case isChoixAction 
	Case "C", "R", "I"
		/*------------------------------------------------------------------*/
		/* On remonte les lignes dans la Dw supérieure.                     */
		/*------------------------------------------------------------------*/
		This.Uf_PreparerValider_Commande ()

		/*------------------------------------------------------------------*/
		/* On met à jour le RIB sur la dw Inter                             */
		/*------------------------------------------------------------------*/
		Uf_PreparerValider_Inter ()
	
		iDwInfoCmde.SetItem ( 1, "NBRE_NOUV", iDwInfoCmde.GetItemNumber ( 1, "NBRE_NOUV" ) + lTot ) 
		iDwInfoCmde.SetItem ( 1, "NBRE_DET", iDwInfoCmde.GetItemNumber ( 1, "NBRE_DET" ) + lTot ) 

/*------------------------------------------------------------------*/
/* #3 : mémorisation des mobiles choisis                            */
/*------------------------------------------------------------------*/
	Case "S" 
		This.Uf_PreparerValider_SelectionCourrier ()	
End Choose

This.uf_RowFocusChanged ( "DWFOURN" )
This.uf_RowFocusChanged ( "DWTYPART" )

idwArticle.SetRedraw ( TRUE )
idwArticlePrs.SetRedraw ( TRUE )

/*------------------------------------------------------------------*/
/* #3 : recherche sur dw_article le 1er article coché trouvé        */
/*------------------------------------------------------------------*/
// Appel de la fonction uf_TraceToutMobile ()
This.uf_TraceToutMobile ()

// #7 Retouche du MT_PEC le cas échéant.
This.Uf_PreparerValider_Dern_Maj_Plaf ()

gProcessTempoOrangeV3Action = False

// [PM246][MANTIS10235]
gAutoriseDiag = FALSE
gAutoriseRempl = FALSE

Return bRet

end function

private function integer uf_copierligne (string asswitch, long alligdwnivinf, string ascle, u_datawindow_detail adwsup, u_datawindow_detail adwinf);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::uf_CopierLigne
//* Auteur			: Fabry JF
//* Date				: 05/11/1999 15:51:33
//* Libellé			: Recopie LA LIGNE SPECIFIEE d'une DW d'un niveau inférieur (2,3,..)
//*					  vers un niveau supérieur (0,1...) en replacant les ItemStatus.
//* Commentaires	: Les results set des deux Dw doivent être identiques.
//*					  Points à respecter : 
//*						 - La DataWindow de niveau inférieur doit avoir la capacité d'updater
//*							afin de pouvoir gérer le buffer DELETE!.
//*					
//*
//* Arguments		: String			asSwitch				(Val)				Valeur : "BP" (Traitement du Buffer Primaire de DW INF)
//*																					Valeur : "BD" (Traitement du Buffer Deleted de DW INF)
//*					  Long			alLigDwNivInf		(Val)				Ligne en cours sur la Dw Niv Inf
//*					  String			asCle					(Val)				Clé permettant d'identifier une ligne sur DW SUP
//*																					EX: "ID_SIN = 5 AND ID_GTI = 2"
//*					  u_DataWindow_Detail	adwSup						Datawindows Supérieur
//*					  u_DataWindow_Detail	adwInf						Datawindows Inférieur
//*
//* Retourne		: Integer  0  NO ACTION
//*								  1  SUCCESS
//*								 -1  FAILURE
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

DwItemStatus lStatusDwNivInf			// Status de la ligne sur DW INF
DwItemStatus lStatusDwNivSup			// Status de la ligne sur DW SUP
DwItemStatus lStatusDwTemp				// Status Tempon
Long			 lLigDwNivSup				// Ligne sur DW SUP
Long			 lNbrColDwNivSup			// Nbre de colonne sur DW SUP
Long			 lCptColDwNivSup			// Compteur de colonne sur DW SUP
Int			 iRet							// Valeur de retour


CHOOSE CASE Upper ( asSwitch )

	/*------------------------------------------------------------------*/
	/* Traitement du buffer PRIMAIRE (recopie)                          */
	/*------------------------------------------------------------------*/
	CASE "BP"
		CHOOSE CASE adwInf.GetItemStatus ( alLigDwNivInf, 0, PRIMARY! )
		
			CASE DataModified!, NewModified!			
				
				lStatusDwNivSup = NotModified!
				lStatusDwNivInf = adwInf.GetItemStatus ( alLigDwNivInf, 0, PRIMARY! )

				lLigDwNivSup = adwSup.Find ( asCle, 1 , adwSup.RowCount () )
				
				If lLigDwNivSup > 0  Then 
					lStatusDwNivSup = adwSup.GetItemStatus ( lLigDwNivSup, 0, PRIMARY! )
					adwSup.RowsDiscard ( lLigDwNivSup, lLigDwNivSup, PRIMARY! )
				End If
				
				iRet = adwInf.RowsCopy ( alLigDwNivInf, alLigDwNivInf, PRIMARY!, adwSup, adwSup.RowCount () + 1, PRIMARY! )
				If IsNull ( iRet ) or iRet < 0 or ( iRet = 0 and lLigDwNivSup > 0 ) Then Return -1

				If iRet = 0 And lLigDwNivSup <= 0 Then Return 0
		
				adwSup.SetItemStatus ( adwSup.RowCount (), 0, Primary!, DataModified! )
				lNbrColDwNivSup = Long ( adwSup.Describe ("DataWindow.Column.Count") )
		
				For lCptColDwNivSup = 1 To lNbrColDwNivSup
					lStatusDwTemp = adwInf.GetItemStatus ( alLigDwNivInf, lCptColDwNivSup, Primary! )
					adwSup.SetItemStatus ( adwSup.RowCount (), lCptColDwNivSup, Primary!, lStatusDwTemp )
				Next
		
				/*------------------------------------------------------------------*/
				/* "Moulinette" permettant de replacer proprement les ItemStatus de */
				/* chaque ligne sur la DW SUP.   											  */
				/*------------------------------------------------------------------*/
				If lLigDwNivSup > 0 Then
					If lStatusDwNivInf = DataModified! Then
						If lStatusDwNivSup = NewModified! or lStatusDwNivSup = DataModified! Then
							adwSup.SetItemStatus ( adwSup.RowCount (), 0, Primary!, lStatusDwNivSup )
						End If
					ElseIf lStatusDwNivInf = NewModified! Then
						adwSup.SetItemStatus ( adwSup.RowCount (), 0, Primary!, lStatusDwNivInf )
					End If
				Else
					adwSup.SetItemStatus ( adwSup.RowCount (), 0, Primary!, NewModified! )			
				End If
		
		END CHOOSE


END CHOOSE



Return 1

end function

private function integer uf_preparervalider_commande ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerValider_Commande (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 12/09/2001 10:49:34
//* Libellé			: 
//* Commentaires	: Préparation de la validation d'une Commande.
//*
//* Arguments		:
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long			 lNbrTotLig, lCptLig
String		 sCle


/*------------------------------------------------------------------*/
/* Pour toutes les lignes contenues dans le buffer Primary!         */
/* DwNivInf... (Le client a pu filtrer le buffer Primaire)          */
/*------------------------------------------------------------------*/
lNbrTotLig = idwCmde.RowCount () 
For lCptLig = 1 To lNbrTotLig


/*------------------------------------------------------------------*/
/* ...on construit la clé de chaque enregistrement contenus dans    */
/* le buffer Primaire de DwNivInf.                                  */
/*------------------------------------------------------------------*/
	sCle = "ID_SEQ = " + String ( idwCmde.GetItemNumber ( lCptLig, "ID_SEQ", PRIMARY!, TRUE ) )  


	/*------------------------------------------------------------------*/
	/* Avec cette ligne identifiée, on effectue le traitement           */
	/* nécéssaire sur la DataWindow de niveau supérieur. Voir fonction  */
	/* Uf_CopierLigne.                                                  */
	/*------------------------------------------------------------------*/
	If This.Uf_CopierLigne ( "BP", lCptLig, sCle, idwCmdeDet, idwCmde ) < 0 Then Return -1
		
Next

Return 1




end function

public subroutine uf_rowfocuschanged (string asdw);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_RowfocusChanged (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 19/09/2001
//* Libellé			: Changement de row sur Dw
//* Commentaires	: 
//*
//* Arguments		: asDw		String		Value
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 CAG   25/02/2003	  DCMP 030129 : Liste des mobiles Orange : Ajout de la zone
//*									id_ref_four dans le fichier envoyé par Cetelec pour
//*									identifier les mobiles spécifiques d'Orange (même ref
//*									marque et modèle que les autres avec des prix différents) +
//*									#ORANGE# dans la zone comment_frn
//* #2	 CAG 	 28/02/2003	  Cas de pls prestations : ajout d'un tri
//*										sort de l'objet ne marche pas, il
//*										faut le faire en dyn.
//* #3	 JFF   04/06/2003   Modif pour gestion ARVATO avec plusieurs fournisseurs pour MUST
//* #4	 CAG	 10/09/2003	  Ajout du frn DDF pr Orange => filtre décrit ds #1 seulement si
//*								  le fournisseur est CETELEC
//* #5	 JFF   06/02/2006   [SITE_CMDE] Gestion des nouvelles option d'autorisation 79, 80, 81
//* #6    JFF   28/01/2008   [DCMP080028]
//* #7    JFF   09/06/2008   [DCMP070798]
//			JFF/FPI 16/08/2012	[PC801] Mantis 4492
//        JFF   11/03/2013   [ITSM149183]
//*---------------------------------------------------------------

Long  lTot, lCpt, lRow, lDeb, lFin, lRowFrn
String	sIdFour, sIdTypArt, sIdGti, sModif, sFiltreArt, sFiltreFrn, sAltVisible, sTypApp
DataWindow	Dw
Boolean		bPageFrn

sFiltreArt = ""

If IsNull ( isMobileUnique ) Then isMobileUnique = ""

// Sommes-nous sur la page des fournisseurs.
bPageFrn = idwFourn.Visible

// #6
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, idwWDivSin.RowCount () )
If lRow <= 0 Then Return

// [PM220_MANTIS6992]
sTypApp = isTypApp

If IsNull ( sTypApp ) Or Trim ( sTypApp ) = "" Then sTypApp = "XXX"
// :#6

idwArticle.SetRedraw ( FALSE )
idwArticlePrs.SetRedraw ( FALSE )
idwFourn.SetRedraw ( FALSE )
idwTypArt.SetRedraw ( FALSE )

/*------------------------------------------------------------------*/
/* On rétréci tous les détails.                                     */
/*------------------------------------------------------------------*/
This.uf_InfoArticle ( "DW_ARTICLE", "MINI" )
This.uf_InfoArticle ( "DW_ARTICLE_PRS", "MINI" )

sIdGti = String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) )
lRow = idwFourn.GetRow ()
If lRow <= 0 Then Return
sIdFour 	= Upper ( idwFourn.GetItemString ( lRow, "ID_CODE_FRN" ) )
//Migration PB8-WYNIWYG-03/2006 FM
//erreur au 1er passage sIdFour = Null, et après lors de la constitution du filtre
//le filtre devient null => demande le filtre
//si IdFourn est null on simule Tous les fournisseurs
If IsNull(sIdFour) Then sIdFour = "TOUS FOURNISSEURS"
//Fin Migration PB8-WYNIWYG-03/2006 FM

Choose Case isChoixAction
	Case "S", "C"
		sAltVisible += " AND ALT_VISIBLE = 'O' " + isMobileUnique
	Case "R", "I"
		sAltVisible += ""
End Choose

CHOOSE CASE Upper ( asDw )

	/*------------------------------------------------------------------*/
	/* Changement de fournisseur.                                       */
	/*------------------------------------------------------------------*/
	CASE "DWFOURN"
		dw = idwFourn

		lTot = idwFourn.RowCount ()
		For lCpt = 1 To lTot
			idwFourn.SetItem ( lCpt, "ROWSELECT", "N" )
		Next
		lTot = idwTypArt.RowCount ()
		For lCpt = 1 To lTot
			idwTypArt.SetItem ( lCpt, "ROWSELECT", "N" )
		Next

		/*------------------------------------------------------------------*/
		/* Article par defaut                                               */
		/*------------------------------------------------------------------*/
		If Pos ( sIdFour, Upper ("TOUS"), 1 ) > 0 Then
			// Tous fournisseurs
			sFiltreArt = "ID_GTI = " + sIdGti + " AND ID_CODE_ART <> '-1' AND ID_TYP_CODE = '-XX'"	
		Else
			sFiltreArt = "ID_GTI = " + sIdGti + " AND ID_CODE_FRN = '" + sIdFour + "' AND ID_CODE_ART <> '-1' AND ID_TYP_CODE = '-XX'"
		End If

		/*------------------------------------------------------------------*/
		/* Si nous sommes en sélection pour le courrier, il faut filtrer    */
		/* (exclure) les fournisseur de prestation.                         */
		/*------------------------------------------------------------------*/
		Choose Case isChoixAction
			Case "S", "C"
				sFiltreArt += " AND ID_CODE_ART NOT IN ( 'PRS', 'EDI' )"
			Case "R"
				sFiltreArt += " AND ID_CODE_ART = 'PRS'"
			Case "I"
				sFiltreArt += " AND ID_CODE_ART = 'EDI'"
		End Choose

		idwTypArt.SetFilter ( sFiltreArt  )
		idwTypArt.Filter    ( )
		idwTypArt.Sort ()
		
		// #6
		lRow = idwTypArt.Find ( "NBRE > 0", 1, idwTypArt.RowCount ())
		If lRow <= 0 Then
			lRow = idwTypArt.Find ( "ID_CODE_ART = '" + sTypApp + "'", 1, idwTypArt.RowCount ())
			If lRow <= 0 Then			
				lRow = idwTypArt.Find ( "ALT_CODE_DEF = 'O'", 1, idwTypArt.RowCount ())
			End If 
		End If
		// :#6

		sFiltreArt = ""

		If lRow <= 0 Then 
			If idwFourn.RowCount () > 0 And idwTypArt.RowCount ( ) > 0 Then lRow = 1
		End If

		If lRow > 0 Then
			idwTypArt.ScrollToRow ( lRow )
			idwTypArt.SetRow      ( lRow )
			idwTypArt.SetItem     ( lRow, "ROWSELECT", "O" )
		End If

		/*------------------------------------------------------------------*/
		/* Modification SFR # le 03/10/02 : Gestion de l'affichage de la    */
		/* dw article en fonction du fournisseur sélectionné                */
		/*------------------------------------------------------------------*/
//		This.uf_CasPartCEGETEL ( sIdFour )

		If idwCmde.RowCount () > 0 And Not ibControlerSaisie Then
			This.uf_zn_AdrCp ( idwCmde.GetItemString ( 1, "ADR_CP" ) ) 
		End If

	/*------------------------------------------------------------------*/
	/* Changement de type d'article.                                    */
	/*------------------------------------------------------------------*/
	CASE "DWTYPART"
		dw = idwTypArt

		lTot = idwTypArt.RowCount ()
		For lCpt = 1 To lTot
			idwTypArt.SetItem ( lCpt, "ROWSELECT", "N" )
		Next

END CHOOSE


/*------------------------------------------------------------------*/
/* On marque le row par une couleur différente et on filtre les     */
/* articles.                                                        */
/*------------------------------------------------------------------*/
lRow = Dw.GetRow ()
If lRow > 0 Then 
	Dw.SetItem ( lRow, "ROWSELECT", "O" )
End If

lRow = idwTypArt.GetRow ()
sIdTypArt = ""

If lRow > 0 Then 
	sIdTypArt = Upper ( idwTypArt.GetItemString ( lRow, "ID_CODE_ART" ) )
End If

sFiltreArt = ""

If Pos ( sIdFour, Upper ("TOUS"), 1 ) > 0 Then
	// Tous fournisseurs
	sFiltreArt = "ID_TYP_ART = '" + sIdTypArt + "'" 
Else
	sFiltreArt = "ID_FOUR = '" + sIdFour + "' AND ID_TYP_ART = '" + sIdTypArt + "'" 
End If

// [ITSM149183]
If sIdTypArt = "TEL" Then
	sFiltreArt += sAltVisible 
Else
	sFiltreArt = F_Remplace ( sFiltreArt, isMobileUnique, "" )
End If
// [ITSM149183]

idwArticle.SetFilter ( sFiltreArt )
idwArticle.Filter ( )

/*------------------------------------------------------------------*/
/* Pour les prestations, le DataObject est différents.              */
/*------------------------------------------------------------------*/
/* #2                                                               */
/*------------------------------------------------------------------*/
CHOOSE CASE Upper ( sIdTypArt )

	CASE "PRS"
		If bPageFrn Then 
			idwArticle.Hide ()
			idwArticlePrs.Show ()
		End If 
		idwArticle.SetSort ( 'MT_PRIX_TTC A, ID_MARQ_ART A, ID_MODL_ART A')
		idwArticle.SetRedraw ( TRUE )

	CASE ELSE
		If bPageFrn Then 
			idwArticle.Show ()
			idwArticlePrs.Hide ()
		End If
		idwArticle.SetRedraw ( FALSE ) // #5
		idwArticle.SetSort ( 'MT_PRIX_TTC A, ID_MARQ_ART A, ID_MODL_ART A')

		// #5
		idwArticle.SetFilter ( "" )
		idwArticle.Filter ( )
		
		lRowFrn = idwFourn.Find ( "ID_GTI = " + sIdGti + " AND LEFT ( ID_CODE_FRN, 2 ) = 'WB'", 1, idwFourn.RowCount ()) // #1
		If lRowFrn > 0 Then

// #7 [DCMP070798] lRowFrn = idwArticle.Find ( "ID_REF_FOUR = 'TEL_VIRTUEL_SPB_WEB'", 1, idwArticle.Rowcount ())
			lRowFrn = idwArticle.Find ( "ID_REF_FOUR = '" + sTypApp + "_VIRTUEL_SPB_WEB' AND ID_TYP_ART = '" + sTypApp  + "'", 1, idwArticle.Rowcount ())			
// :#7 [DCMP070798]
			If lRowFrn > 0 Then 
				idwArticle.SetItem ( lRowFrn, "ALT_VISIBLE", "O" )
			End If
		End If
		
		
		// [PC801]
		lRowFrn = idwFourn.Find ( "ID_GTI = " + sIdGti + " AND LEFT ( ID_CODE_ART, 3 ) = 'CAF'", 1, idwFourn.RowCount ()) // #1
		If lRowFrn > 0 Then
			lRowFrn = idwArticle.Find ( "ID_TYP_ART = 'CAF'", 1, idwArticle.Rowcount ())			
			If lRowFrn > 0 Then 
				idwArticle.SetItem ( lRowFrn, "ALT_VISIBLE", "O" )
			End If
		End If
		// :[PC801]
		
		idwArticle.SetFilter ( sFiltreArt )
		idwArticle.Filter ( )
		// /#5


		// Gestion Darty
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 11 )
		If lDeb <=0 Then
			F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 31 )
			If lDeb <=0 Then
				F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 45 )
			End If 
		End If

		If lDeb > 0 Then idwArticle.SetSort ( 'MT_PRIX_TTC D, ID_MARQ_ART A, ID_MODL_ART A')

		idwArticle.SetRedraw ( TRUE ) // #5
		idwArticlePrs.SetRedraw ( TRUE )

END CHOOSE

idwArticle.Sort ( )

idwFourn.SetRedraw ( TRUE )
idwTypArt.SetRedraw ( TRUE )

end subroutine

private subroutine uf_initcasparticulier ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_int_fin_Article::Uf_InitCasParticulier (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 02/11/2001
//* Libellé			: 
//* Commentaires	: Initialisation particulière en fonction de certain fournisseurs.
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

This.uf_InitCasParticulierTel ()

/*------------------------------------------------------------------*/
/* Cas particulier pour les prestations                             */
/*------------------------------------------------------------------*/
This.Uf_CasPart_Prestation ()

end subroutine

private function integer uf_zn_probleme (ref datawindow adw, string asdata, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_Zn_Probleme
//* Date				: 19/09/2001
//* Libellé			: Zone Choix
//* Commentaires	: 
//*
//* Arguments		: aDw				DataWindow	Val
//*					  asData			String		Val
//*					  alRow			String		Val
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   02/03/2010   [MSS_LOT2]
//* 		 FPI	 25/06/2010   [20100625.FPI] Epuration de message
//*       JFF   27/07/2010   [PC321]
//        JFF   30/08/2012   [VDOC8041]
//*---------------------------------------------------------------

Int iRet
Long	lLen, lCpt

iRet = 0
lLen = Len ( asData )

//* #6 [MSS_LOT2]
// [PC321] Ajout ibPasDeSaisieProbleme
If iRet = 0 And ( ibReouvPresta OR ibReouvPrestaO2M ) Then
	iRet = 1
End IF

// [PC321]
If iRet = 0 And ibPasDeSaisieProbleme Then
	iRet = 1	
End If

/*------------------------------------------------------------------*/
/* Il ne doit pas y avoir de retour chariot.                        */
/*------------------------------------------------------------------*/
If iRet = 0 And Pos ( asData, Char ( 13 ), 1 ) > 0 Then 
	iRet = 1
End IF

// 	[20100625.FPI] 
If iRet = 0 And (Pos ( asData, Char ( 11 ), 1 ) > 0 or  Pos ( asData, Char ( 10 ), 1 ) > 0) Then 
	iRet = 1
End IF

Return iRet
end function

private subroutine uf_modifier_icone_sfr ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_W_Commande3::uf_Modifier_Icone_Sfr (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 21/07/2002 09:31:39
//* Libellé			: 
//* Commentaires	: On positionne un BITMAP différent sur la zone ADR_TEL3
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 12/11/2002	  Annexe 20 : [MOBILE PROTECT] est géré

//*												  comme les autres produits SIMPA
//* #2	 CAG	 24/02/2003	  Le bris est maintenant géré par Cetelec
//*-----------------------------------------------------------------

String sMod, sAdrCp

sMod = "P_ADR_TEL3.FileName = 'K:\PB4OBJ\BMP\TEL.BMP'"

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/* #1																					  */
/*------------------------------------------------------------------*/
If	idwProduit.GetItemNumber ( 1, "COD_TEL" ) = 21 And &
	idwProduit.GetItemNumber ( 1, "ID_PROD" ) <> 5707 Then
/*------------------------------------------------------------------*/
/* On positionne la zone ADR_TEL3 avec la zone NUM_PORT de W_SIN.   */
/* Dans le cas d'une PRESTATION uniquement.                         */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Pour SFR, (Garantie PANNE) il existe un seul article de type     */
/* PRESTATION.                                                      */
/*------------------------------------------------------------------*/
/* #2                                                               */
/*------------------------------------------------------------------*/
	If	idwTypArt.RowCount () = 1 Then
		If idwTypArt.GetItemString ( 1, "ID_CODE_ART" ) = "PRS" Then
			sMod = "P_ADR_TEL3.FileName = 'K:\PB4OBJ\BMP\TEL_PORT.BMP'"
			If	IsNull ( idwCmde.GetItemString ( 1, "ADR_TEL3" ) )	Then
				idwCmde.SetItem ( 1, "ADR_TEL3", F_Format_Num_Tel ( idwWsin.GetItemString  ( 1, "NUM_PORT" ), TRUE ) )
			End If
		End If
	End If
/*------------------------------------------------------------------*/
/* On effectue le traitement pour la première fois sur la zone      */
/* ADR_CP.                                                          */
/*------------------------------------------------------------------*/
	sAdrCp = idwCmde.GetItemString ( 1, "ADR_CP" )
	uf_Zn_AdrCp ( sAdrCp )
End If
/*------------------------------------------------------------------*/
/* On execute le modify sur la DW.                                  */
/*------------------------------------------------------------------*/
idwCmde.Modify ( sMod )

end subroutine

private subroutine uf_zn_adrcp (string asval);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_W_Commande3::uf_Zn_AdrCp (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 21/07/2002 09:31:39
//* Libellé			: 
//* Commentaires	: On s'occupe de la zone ADR_CP
//*
//* Arguments		: (Val)		asVal		String
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 12/11/2002	  Annexe 20 : [MOBILE PROTECT] est géré
//*												  comme les autres produits SIMPA
//* #2    JFF   04/06/2003	  Modification de la structure de la table ZONE_COGEPAR (nouvellement
//*								  nommée ZONE_FOURNISSEUR), donc modification du sRech
//* #3	 JFF	 06/06/2003   Pour ARVATO, on ne gère que le département
//*-----------------------------------------------------------------

Long lTotZoneFournisseur, lLig, lIdProd, lRowFourn, lNull
String sIdZone, sRech, sFiltreFin, sIdFour, sNull, sValDefaut
DataWindowChild		dwChild

/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
SetNull ( sNull )
SetNull ( lNull )
idwCmde.SetItem ( 1, "ID_ZONE", sNull )
idwCmde.SetItem ( 1, "ID_CHOIX_HORAIRE", sNull )

/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
lIdProd =  idwProduit.GetItemNumber ( 1, "ID_PROD" )
lRowFourn = idwFourn.GetRow ()
If lRowfourn > 0 Then 
	sIdFour =  idwFourn.GetItemString ( lRowFourn, "ID_CODE_FRN" )
End If

/*------------------------------------------------------------------*/
/* #3                                                               */
/*------------------------------------------------------------------*/
sValDefaut = "B"  // B pour CETELEC

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On vient de passer la fonction pour le formatage de la zone      */
/* ADR_CP.                                                          */
/*------------------------------------------------------------------*/
/* #1																					  */
/*------------------------------------------------------------------*/
If	idwProduit.GetItemNumber ( 1, "COD_TEL" ) = 21 And lIdProd  <> 5707	Then
/*------------------------------------------------------------------*/
/* On vérifie si le CODE POSTAL que l'on vient de saisir existe     */
/* dans la table ZONE_FOURNISSEUR.                                  */
/*------------------------------------------------------------------*/
	If	Not IsNull ( asVal )	Then
		lTotZoneFournisseur = idw_ZoneFournisseur.RowCount ()

		// #1
		sRech = "ID_PROD = " + String ( lIdProd ) + "  AND " + &
				  "ID_FOUR = '" + sIdFour 				+ "' AND " + &
				  "CODE_POSTAL = '" + asVal + "'"
		lLig = idw_ZoneFournisseur.Find ( sRech, 1, lTotZoneFournisseur )

		If	lLig > 0	Then
			// #1
			sIdZone = idw_ZoneFournisseur.GetItemString ( lLig, "CODE_ACTION" )

		Else
			sIdZone = sValDefaut 
		End If
	Else
		sIdZone = stNul.str
	End If
	idwCmde.SetItem ( 1, "ID_ZONE", sIdZone )
/*------------------------------------------------------------------*/
/* On positionne les zones qui dépendent de ID_ZONE à NULL.         */
/*------------------------------------------------------------------*/
	idwCmde.SetItem ( 1, "ID_CHOIX_HORAIRE", stNul.lng )
	idwCmde.SetItem ( 1, "DTE_RDV_CLI", stNul.dat )
	idwCmde.SetItem ( 1, "HRDV_CLI_MIN", stNul.str )
	idwCmde.SetItem ( 1, "HRDV_CLI_MAX", stNul.str )

	sFiltreFin = This.uf_Filtrer_HoraireRdv ( sIdZone )

	idwCmde.GetChild ( "ID_CHOIX_HORAIRE", dwChild )

	dwChild.SetFilter ( sFiltreFin )
	dwChild.Filter ()
	dwChild.Sort ()
End If

end subroutine

private subroutine uf_tb_sfr ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_W_Commande3::uf_Tb_Sfr (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 21/07/2002 09:31:39
//* Libellé			: 
//* Commentaires	: Gestion des TabOrder pour le produit SFR
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 07/11/2002	  Annexe 20 : [MOBILE PROTECT] : même gestion des rdv
//*									           que les autres produits téléphonie SP
//* #2	 CAG	 15/11/2002	  Vu avec JFF, correction : dans le cas de SFR (5712)
//*										les zones de rdv doivent être dispo (soit combo, soit zn saisissables)
//*-----------------------------------------------------------------

Long lRow

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
If	idwProduit.GetItemNumber ( 1, "COD_TEL" ) = 21 And &
	idwProduit.GetItemNumber ( 1, "ID_PROD" ) <> 5707	Then

	lRow = idwFourn.GetRow ()
	/*------------------------------------------------------------------*/
	/* #2                                                               */
	/*------------------------------------------------------------------*/
	If Upper ( idwFourn.GetItemString ( lRow, "ID_CODE_FRN" ) ) = "CEG" Then
		idwCmde.Uf_Proteger ( { "DTE_RDV_CLI", "HRDV_CLI_MIN", "HRDV_CLI_MAX" }, "0" )
		idwCmde.Uf_Proteger ( { "ID_CHOIX_HORAIRE" }, "1" )
	Else
		idwCmde.Uf_Proteger ( { "DTE_RDV_CLI", "HRDV_CLI_MIN", "HRDV_CLI_MAX" }, "1" )
		idwCmde.Uf_Proteger ( { "ID_CHOIX_HORAIRE" }, "0" )
	End If
Else
	idwCmde.Uf_Proteger ( { "DTE_RDV_CLI", "HRDV_CLI_MIN", "HRDV_CLI_MAX" }, "0" )
	idwCmde.Uf_Proteger ( { "ID_CHOIX_HORAIRE" }, "1" )
End If


end subroutine

private subroutine uf_caspartcegetel (string asidfour);//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_W_Commande3::uf_CasPartCEGETEL ( PRIVATE )
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 03/10/2002 16:49:46
//* Libellé       : Gestion de l'affichage des champs de la dw article
//* Commentaires  : 
//*
//* Arguments     : ( Val )	String	asIdFour	:	Fournisseur sélectionné ou défini par défaut
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

String sModif

If asIdFour = "CEG" Then
		sModif = " APP_CATALOGUE_T.Visible = 1"
		sModif = sModif + " LIB_CATALOGUE_T.Visible = 1"
		sModif = sModif + " QT_DISP.Visible = 0 QT_DISP_T.Visible = 0"
		idwArticle.Modify ( sModif )
Else
		sModif = " APP_CATALOGUE_T.Visible = 0"
		sModif = sModif + " LIB_CATALOGUE_T.Visible = 0"
		sModif = sModif + " QT_DISP.Visible = 1 QT_DISP_T.Visible = 1"
End If
idwArticle.Modify ( sModif )

end subroutine

private subroutine uf_armementgmecat (long alrow);//*-----------------------------------------------------------------
//*
//* Fonction      : N_Cst_W_Commande3::uf_ArmementGmeCat ( PRIVATE )
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 03/10/2002 17:46:39
//* Libellé       : 
//* Commentaires  : 
//*
//* Arguments     : ( Val )	Long	alRow	:	Ligne cliquée 
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

String sText, sModif

If idwArticle.GetItemString ( alRow, "APP_CATALOGUE" ) = "CAT" Then
	sText = "Inclu dans le catalogue"
Else
	sText = "N~~'est pas inclu dans le catalogue"
End If

sModif = "LIB_CATALOGUE_T.Text = '" + sText + "'"
idwArticle.Modify ( sModif )


end subroutine

private subroutine uf_initcasparticuliertel ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_InitCasParticulierTel (PRIVATE)
//* Auteur			: Abdmeziem	Catherine
//* Date				: 25/11/2002
//* Libellé			: 
//* Commentaires	: Modification SFR : Initialisation des mobiles dispos à la commande
//*
//* Arguments		: Aucun
//*					  
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 CAG 	 28/02/2003	  Cas de pls prestations : ajout d'un tri
//*										sort de l'objet ne marche pas, il
//*										faut le faire en dyn.
//*---------------------------------------------------------------

Long	lTotRow, lCpt

/*------------------------------------------------------------------*/
/* Initialisation de l'IMEI du téléphone avec les données de        */
/*	l'adhésion					 													  */
/*------------------------------------------------------------------*/
idwArticle.SetFilter ( "ID_TYP_ART <> 'PRS'" )
idwArticle.Filter ()

lTotRow = idwArticle.RowCount ()

If Not IsNull ( isNumIMEIAdh ) Then
	For lCpt = 1 to lTotRow
		idwArticle.SetItem ( lCpt, "ID_SERIE_ANC", isNumIMEIAdh )
	Next
End If

idwArticle.SetFilter ( "" )
idwArticle.Filter ()

/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
If idwArticle.Visible Then
	idwArticle.SetSort ( 'MT_PRIX_TTC A, ID_MARQ_ART A, ID_MODL_ART A')
Else
	idwArticle.SetSort ( 'MT_PRIX_TTC A, ID_MARQ_ART A, ID_MODL_ART A')
End If
idwArticle.Sort ( )

end subroutine

public subroutine uf_switch_ctrlsaisie (boolean abSwitch);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande3::uf_Switch_CtrlSaisie (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 06/06/2003 16:16:48
//* Libellé       : Utilisé sur la fenêtre w_commande3 sur ueControler
//* Commentaires  : Permet de bloquer l'initialisation de la zone de RDV lors
//*					  du clique sur le bouton "Controler"
//*
//* Arguments     : Boolean	abSwitch		Val
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

// à True, On est dans le Contrôler Saisie.

ibControlerSaisie = abSwitch
end subroutine

private subroutine uf_caspart_prestation ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_CasPart_Prestation (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 02/11/2001
//* Libellé			: 
//* Commentaires	: Gestion des cas particuliers pour les Prestations
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*
//* #1	 CAG 	 27/02/2003	  Cas de pls prestations : ajout d'une boucle
//*-----------------------------------------------------------------

Long	lRow, lTotRow, lCpt


/*------------------------------------------------------------------*/
/* Initialisation de la marque, modèle, et IMEI du téléphone avec   */
/* les données de l'adhésion pour la prestations						  */
/*------------------------------------------------------------------*/
idwArticle.SetFilter ( "ID_TYP_ART = 'PRS'" ) 
idwArticle.Filter ( ) 

lTotRow = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/

For lCpt = 1 To lTotRow
	If Not IsNull ( isNumIMEIAdh ) Then idwArticle.SetItem ( lCpt, "ID_SERIE_ANC", isNumIMEIAdh )
	If Not IsNull ( isMarqPortAdh ) Then idwArticle.SetItem ( lCpt, "ID_MARQ_ART", isMarqPortAdh )
	If Not IsNull ( isModlPortAdh ) Then idwArticle.SetItem ( lCpt, "ID_MODL_ART", isModlPortAdh )
Next 

idwArticle.SetFilter ( "" ) 
idwArticle.Filter ( ) 


end subroutine

private function integer uf_zn_marque (ref datawindow adw, string asdata, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_Zn_Marque (PRIVATE)
//* Auteur			: Abdmeziem Catherine
//* Date				: 16/06/2003
//* Libellé			: Zone Marque
//* Commentaires	: 
//*
//* Arguments		: aDw				DataWindow	Val
//*					  asData			String		Val
//*					  alRow			String		Val
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*---------------------------------------------------------------

Int					iRet
String				sFind
Long					lRow
DataWindowChild	dwChild

iRet = 0
sFind = ""
lRow = 0

aDw.GetChild ( "ID_MARQ_ART", dwChild )
sFind = "LIB_CODE = '" + asData + "'"
lRow = dwChild.Find ( sFind, 1, dwChild.RowCount () )
If lRow <= 0 Then
	iRet = 1
End If

Return iRet
end function

private subroutine uf_controlersaisie_commune (ref string aspos);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande3::uf_ControlerSaisie_Commune (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 25/08/2003 16:34:05
//* Libellé       : DCMP 030362 Contrôle des communes.
//* Commentaires  : 
//*
//* Arguments     : String		réf		asPos
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF	  08/10/2003  Le fichier INSEE.TXT ne contien que les 25 premiers 
//*								  caractères de la ville.
//* #2	 JFF	  27/01/2004  DCMP 030581 : On prévoit un shunt pour le contrôle des communes.
//* #3	 PHG	  17/06/2006  [DCMP060445] : Unification Sherpa/simpa Controle des communes
//*								  Réécriture de la fonction.
//* #4    JFF    25/04/2007  [SITE_CMDE]
//*-----------------------------------------------------------------

Long 			lCptAdr, lDeb, lFin
String 		sVille, sCP, sMes, sPosCP, sPosVille

If asPos <> "" Or Not ibAltCommune Then Return

/*------------------------------------------------------------------*/
/* #2 : OPTION 16 : Si Option, on déconnecte tout le contrôle des   */
/* communes                                                         */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 16 )
If lDeb > 0 Then Return


For lCptAdr = 1 To 1  // ald 1 TO 2
	
	/*------------------------------------------------------------------*/
	/* Cas de l'adresse de Livraison et de facturation	                 */
	/*------------------------------------------------------------------*/
	Choose Case lCptAdr
		Case 1 // Livraison
			sCP	  	 = Upper ( Trim ( idwCmde.GetItemString ( 1, "ADR_CP" )	) ) 
			sVille  	 = Upper ( Trim ( idwCmde.GetItemString ( 1, "ADR_VILLE" )	 ) )
			sMes		 ="livraison"
			sPosCP	 = "ADR_CP"
			sPosVille = "ADR_VILLE"

		Case 2 // Facturation
			sCP	  	 = Upper ( Trim ( idwCmde.GetItemString ( 1, "ADRFC_CP" )	) ) 
			sVille    = Upper ( Trim ( idwCmde.GetItemString ( 1, "ADRFC_VILLE" ) ) )	
			sMes		 ="facturation"
			sPosCP	 = "ADRFC_CP"
			sPosVille = "ADRFC_VILLE"

	End Choose 
	
	if Not stglb.uocommune.uf_verif_cp_ville( sCP, sVille) then
		if Not stglb.uocommune.uf_checkcp( sCP) then
			/*------------------------------------------------------------------*/
			/* Le CP n'existe pas					                                */
			/*------------------------------------------------------------------*/
			stMessage.sTitre		= "Contrôle de saisie d'un interlocuteur (Communes)"
			stMessage.Bouton		= Ok!
			stMessage.Icon			= Information!
			stMessage.sVar[1]		= sMes
			stMessage.bErreurG	= TRUE
			stMessage.sCode		= "COMM06"
			f_Message ( stMessage )
			asPos = sPosCP
		else
			/*------------------------------------------------------------------*/
			/* La commune n'existe pas                                          */
			/*------------------------------------------------------------------*/
			stMessage.sTitre		= "Contrôle de saisie d'un interlocuteur (Communes)"
			stMessage.Bouton		= Ok!
			stMessage.Icon			= Information!
			stMessage.sVar[1]		= sMes
			stMessage.bErreurG	= TRUE
			stMessage.sCode		= "COMM07"
			f_Message ( stMessage )
			asPos = sPosVille
		End If
	End If
	
	// #4
	If lCptAdr = 1 And ( &
		Not F_Libelle ( idwCmde.GetItemString ( 1, "ADR_NOM"), 7 )  Or &
		Not F_Libelle ( idwCmde.GetItemString ( 1, "ADR_PRENOM"), 7 )  Or &		
		Not F_Libelle ( idwCmde.GetItemString ( 1, "ADR_LIVR1"), 7 )  Or &
		Not F_Libelle ( idwCmde.GetItemString ( 1, "ADR_LIVR2"), 7 )  Or &
		Not F_Libelle ( idwCmde.GetItemString ( 1, "ADR_LIVR_CPL"), 7 )   &		
		) Then
	
		stMessage.sTitre		= "Contrôle de saisie d'un interlocuteur (Nom, prénom, adresse)"
		stMessage.Bouton		= Ok!
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD446"
		f_Message ( stMessage )
		asPos = "ADR_LIVR1"
	
	End If
	//   /#4	

	If asPos <> "" Then Exit
Next

end subroutine

private subroutine uf_controlersaisie_tacimei (ref string aspos);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande3::uf_ControlerSaisie_TacImei (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 02/09/2003 15:04:10
//* Libellé       : Contrôle des TAC_IMEI
//* Commentaires  : 
//*
//* Arguments     : String		réf		asPos
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

String	sTacImei
String	sMarqPort, sMarqTAC, sFiltreOrig
Long 		lTotTAC, lRow, lTotArt, lCptArt

If asPos <> "" Then Return

sFiltreOrig = idwArticle.Describe ("DataWindow.Table.filter") 
If sFiltreOrig = "?" Then sFiltreOrig = ""

idwArticle.SetFilter ( "CHOIX = 'O' AND ID_TYP_ART = 'PRS'" )
idwArticle.Filter ( )

lTotTAC = idwTacImei.RowCount ()
lTotArt = idwArticle.RowCount ()

For lCptArt = 1 To lTotArt 
	sTacImei = Left ( idwArticle.GetItemString ( lCptArt, "ID_SERIE_ANC" )  , 6 )
	sMarqPort = Upper ( idwArticle.GetItemString ( lCptArt, "ID_MARQ_ART" ) )

	/*------------------------------------------------------------------*/
	/* On ne fait le contrôle de cohérence que si les deux zones sont   */
	/* renseignées.                                                     */
	/*------------------------------------------------------------------*/
	If IsNull ( sMarqPort ) Or sMarqPort = "" Or IsNull ( sTacImei ) Or sTacImei = "" Or sTacImei = "000000" Then Continue

	lRow = idwTacImei.Find ( "ID_TAC = " + sTacImei, 1, lTotTAC )

	/*------------------------------------------------------------------*/
	/* TAC Trouvé dans la base.                                         */
	/*------------------------------------------------------------------*/
	If lRow > 0 Then
		sMarqTAC = Upper ( idwTacImei.GetItemString ( lRow, "MARQUE" ) )

		/*------------------------------------------------------------------*/
		/* Mais le TAC ne correspond pas à la Marque.                       */
		/*------------------------------------------------------------------*/
		If sMarqPort <> sMarqTac Then

			stMessage.sTitre		= "Contrôle de validité du TAC IMEI"
			stMessage.Bouton		= Ok!
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.sVar[1]		= sTacImei
			stMessage.sVar[2]		= sMarqTac
			stMessage.sCode		= "GENE130"
			f_Message ( stMessage )
			asPos = "MARQ_PORT"

		End If

	End If

	/*------------------------------------------------------------------*/
	/* Non Trouvé dans la base.                                         */
	/* Alerte non bloquante.														  */
	/*------------------------------------------------------------------*/
	If lRow <= 0 Then

		stMessage.sTitre		= "Contrôle de validité du TAC IMEI"
		stMessage.Bouton		= Ok!
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.sVar[1]		= sTacImei
		stMessage.sVar[2]		= sMarqTac
		stMessage.sCode		= "GENE131"
		f_Message ( stMessage )

	End If

	If asPos <> "" Then Exit

Next

idwArticle.SetFilter ( sFiltreOrig )
idwArticle.Filter ( )

end subroutine

private function integer uf_zn_idserieanc (ref datawindow adw, string asdata, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_Zn_IdSerieAnc (PRIVATE)
//* Date				: 02/09/2003
//* Libellé			: Zone Id_Serie_Anc
//* Commentaires	: 
//*
//* Arguments		: aDw				DataWindow	Ref
//*					  asData			String		Val
//*					  alRow			String		Val
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF	   09/09/2003 Denis souhaite que les gestionnaire saississent
//*								  eux-même les quinze '0', et non pas que la saisie
//*								  soit assistée.
//* 
//*---------------------------------------------------------------

Int iRet
Long	lLen, lCpt
Boolean bQueDesZeros

iRet 		= 0

/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
Return iRet


asData 	= Trim ( asData )
lLen 		= Len ( asData )
bQueDesZeros = True

For lCpt = 1 To lLen
	If Mid ( asData, lCpt, 1 ) <> "0" Then 
		bQueDesZeros = False
		Exit
	End If
Next

If bQueDesZeros Then 
	asData = Fill ( "0", 15 )
	aDw.SetItem ( alRow, "ID_SERIE_ANC", asData )
	iRet = 2
End If

Return iRet
end function

private subroutine uf_epuration_zonecommune (ref string asville, ref integer aicode);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande3::uf_Epuration_ZoneCommune ( PRIVATE )
//* Auteur        : Fabry JF
//* Date          : 12/09/2003 10:48:04
//* Libellé       : Supprime tout ce qui est gênant dans la chaine de 
//*					  la ville afin de ne garder que la ville.
//* Commentaires  : 
//*
//* Arguments     : String 	asVille 		aRef
//*					  Integer	aiCode		aRef	 1 : Présence d'un CEDEX, BP, etc 
//*															 0 : Aucune présence de mot clé.		
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------
String sVille, sCar, sMot, sMotSubst
String sTbMotCle []   // Mots Clé à ne pas tenir Compte
Integer iTotMotCle, iCpt, iPos
Boolean bCarTrouve

sTbMotCle = { " BP", "CEDEX", "CÉDEX", "CEDÉX", "CÉDÉX" }
sVille = Upper ( asVille )
aiCode = 0

/*------------------------------------------------------------------*/
/* 1 : Suppression des mots clés                                    */
/*------------------------------------------------------------------*/
iTotMotCle = UpperBound ( sTbMotCle )
For iCpt = 1 To iTotMotCle
	iPos = 1
	Do While iPos > 0 
		iPos = Pos ( sVille, sTbMotCle [iCpt], 1 )
		If iPos > 0 Then
			sVille = Replace ( sVille , iPos, Len ( sTbMotCle [iCpt]), "" ) 
			aiCode = 1
		End If
	Loop
Next

/*------------------------------------------------------------------*/
/* 2 : Par la gauche, suppression de tout caractère non compris     */
/* entre 65 et 90 (ASCII).                                          */
/*------------------------------------------------------------------*/
bCarTrouve = TRUE
Do While bCarTrouve 
	sCar = Left ( sVille, 1 )

	Choose Case asc ( sCar ) 
		Case 65 To 90
			bCarTrouve = False

		Case Else
			bCarTrouve = TRUE
				sVille = Right ( sVille, Len ( sVille ) - 1 )
	End Choose 
Loop

/*------------------------------------------------------------------*/
/* 3 : Par la Droite, suppression de tout caractère non compris     */
/* entre 65 et 90 (ASCII).                                          */
/*------------------------------------------------------------------*/
bCarTrouve = TRUE
Do While bCarTrouve 
	sCar = Right ( sVille, 1 )
	Choose Case asc ( sCar ) 
		Case 65 To 90
			bCarTrouve = False

		Case Else
			bCarTrouve = TRUE
				sVille = Left ( sVille, Len ( sVille ) - 1 )

	End Choose 
Loop


/*------------------------------------------------------------------*/
/* 4 : Si _SAINT_ Ou _SAINTE_ trouvé en début de chaine remplacer   */
/* par ST ou STE                                                    */
/*------------------------------------------------------------------*/
For iCpt = 1 To 4
	Choose Case iCpt
		Case 1
			sMot = " SAINT "
			sMotSubst = " ST "
		Case 2
			sMot = " SAINTE "
			sMotSubst = " STE "
		Case 3
			sMot = "SAINT "
			sMotSubst = "ST "
		Case 4
			sMot = "SAINTE "
			sMotSubst = "STE "
			
	End Choose

	iPos = Pos ( sVille, sMot, 1 )

	Choose Case iCpt
		Case 1, 2
			If iPos > 0 Then
				sVille = Replace ( sVille, iPos, Len ( sMot ), sMotSubst ) 
			End If

		Case 3, 4
			If iPos = 1 Then
				sVille = Replace ( sVille, iPos, Len ( sMot ), sMotSubst ) 
			End If
	End Choose 
Next

/*------------------------------------------------------------------*/
/* 5 : Si la ville est composée, il ne doit y avoir qu'un espace 	  */
/* entre les mots.																  */
/*------------------------------------------------------------------*/
iPos = 1 
Do While iPos > 0 
	iPos = Pos ( sVille, "  ", 1 )
	If iPos > 0 Then
		sVille = Replace ( sVille , iPos, 2, " " ) 
	End If
Loop


asVille = sVille


end subroutine

private subroutine uf_selectionautomatique ();//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande3::uf_SelectionAutomatique (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 20/11/2003 14:04:43
//* Libellé       : Sélection automatique de mobiles sur Option.
//* Commentaires  : Créé à l'origine pour DARTY
//*
//* Arguments     : Aucun
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1   JFF    01/10/2007   [DCMP070689] complèment Darty Swap&DartyMP
//* #2   JFF    09/10/2007   [ALAPAGE]
//* #3   JFF    28/01/2008   [DCMP080028] Ajout "11/NPCP/>300/PRS_DST_ANN/CMD_DTY"
//* #4   JFF    24/04/2008   [DCMP080329] Rechercher existance appareil pour DARTY TEL
//* #5   JFF    14/05/2008   [DCMP080324]
//* #6   JFF    10/06/2009   [MOBISQUARE]
//* #7   JFF    27/01/2010   [DCMP090283]
//* #8   JFF    27/01/2010   [DCMP090283].[20100203161827340]
//       JFF    07/05/2013   [PC938_ORANGE_V3]
//       JFF    19/04/2016   [DT209]
//       JFF    17/05/2016   [PM280-2]
//       JFF    28/06/2016   [PC151549]
//       JFF    29/08/2017   [DT288-3_LOT1_2EME_VS]
//       JFF    01/10/2018   [PM445-1]
//       JFF    05/12/2018   [ITSM576752]
// 		JFF    23/09/2019   [PC192298-PC192300-PC192900]
//*-----------------------------------------------------------------

Long lDeb, lFin, lDeb2, lFin2, lPos, lTotArt, lcptArt, lVal
boolean bAmuTrouve
String sFiltre, sRet, sCasGestionStandard, sVal, sFiltreOrig, sFiltreOrig2, sVariante 
n_cst_string lnvPFCString

bAmuTrouve = False


sFiltreOrig2 = idwArticle.Describe ("DataWindow.Table.filter") 
If sFiltreOrig2 = "?" Then sFiltreOrig = ""

// [DT209]
Choose Case idwDetail.GetItemNumber ( 1, "ID_EVT" ) 
	Case 1424 
		This.uf_selectionautomatique_id_ref_four ( "BON_EMARGE" )

	// [PM280-2]
	Case 1426 
		This.uf_selectionautomatique_id_ref_four ( "CONTEST_SUR_REMPL" )
		
	Case 1451 
		This.uf_selectionautomatique_id_ref_four ( "A_CONTROLER_IMEI" )
		
End Choose 

// [PC192298-PC192300-PC192900]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 114 )
If lDeb > 0 And isChoixAction = "I" Then
	sVariante = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")		
	Choose Case sVariante 
		Case "ERR_TACH_FIT"
			This.uf_selectionautomatique_id_ref_four ( "A_RECUP_A_RECYCLER" )				
	End Choose 
End If 


If F_CLE_A_TRUE ( "DT361_M29347" ) Then
	Choose Case idwDetail.GetItemNumber ( 1, "ID_GTI" ) 
		Case 24
				sFiltreOrig = idwArticle.Describe ("DataWindow.Table.filter") 
				If sFiltreOrig = "?" Then sFiltreOrig = ""
				
				idwArticle.SetFilter ( "ID_REF_FOUR IN ( 'A_REPARER_FORCE' ) AND ID_FOUR IN ( 'CEA', 'PSM', 'SBE', 'TMT')" )
				idwArticle.Filter ( )
				idwArticle.RowsDisCard ( 1, idwArticle.RowCount(), Primary! )				
				
				idwArticle.SetFilter ( sFiltreOrig )
				idwArticle.Filter ( )
				idwArticle.Sort ()
				
		Case Else
				sFiltreOrig = idwArticle.Describe ("DataWindow.Table.filter") 
				If sFiltreOrig = "?" Then sFiltreOrig = ""
				
				idwArticle.SetFilter ( "ID_REF_FOUR IN ( 'A_DESOXYDER_FORCE' )" )
				idwArticle.Filter ( )
				idwArticle.RowsDisCard ( 1, idwArticle.RowCount(), Primary! )				
				
				idwArticle.SetFilter ( sFiltreOrig )
				idwArticle.Filter ( )
				idwArticle.Sort ()				
				
		End Choose 
End If 


// [PM445-1] à supprimer 
// [DT288-3_LOT1_2EME_VS]
Choose Case idwDetail.GetItemNumber ( 1, "ID_EVT" ) 
	Case 1439 
		
		lVal = idwCmdeSin.Find ( "ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount ())
		
		If lVal > 0 Then
			idwArticle.SetFilter ( "ID_REF_FOUR IN ( 'NE_PAS_REMPLACER' )" ) 
		Else 
			idwArticle.SetFilter ( "ID_REF_FOUR IN ( 'A_REMPLACER', 'NE_PAS_REMPLACER' )" )
		End IF 
		
		idwArticle.Filter ( )
		idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount(), Filter! )
	
End Choose	

// [ITSM576752]
idwArticle.SetFilter ( sFiltreOrig2  )
idwArticle.Filter ()
idwArticle.Sort ()

//* #8 [DCMP090283].[20100203161827340]
If isChoixAction <> "C" Then Return

F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 45 )
If lDeb <= 0 Then Return
//* #8 [DCMP090283].[20100203161827340]

// [PC938_ORANGE_V3]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 239 )
If lDeb > 0 Then
	This.uf_selectionautomatique_pret_standard ()
	This.uf_selectionautomatique_restit_pret_ant ()
	
	// PC938_ORV3_M8086
	This.uf_selectionautomatique_recup_app_sin ()
	
	Return
End If

// [PC13442]
lDeb=idwwdivsin.Find("NOM_ZONE='ech_express_48h' AND VAL_CAR='O'", 1, idwwdivsin.RowCount())
If lDeb > 0 Then

	// [PC151549]
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 302 ) // MBZ3
	If lDeb > 0 Then
		uf_selectionautomatique_standard_sansppo("BST","ID_TYP_ART='CAF'")		
	Else	
		uf_selectionautomatique_standard_sansppo("MBS","ID_TYP_ART='CAF'") // MBZ2
	End If

	return
End if
// :[PC13442]

// #5 [DCMP080324]
sRet = ""
sCasGestionStandard = ""

// #4 [DCMP080329]
//If isMobileUnique <> "" Then return

// #7 [DCMP090283]
// Sinon, il est hors plafond "choix.visible" <> "1" donc on continue et on réinitialise

sFiltreOrig = idwArticle.Describe ("DataWindow.Table.filter") 
If sFiltreOrig = "?" Then sFiltreOrig = ""
sFiltreOrig = F_Remplace ( sFiltreOrig, isMobileUnique, "" )

idwArticle.SetFilter ( sFiltreOrig  )
idwArticle.Filter ()
idwArticle.Sort ()

lTotArt = idwArticle.RowCount ()
For lCptArt = 1 To lTotArt
	idwArticle.SetItem ( lCptArt, "ALT_VISIBLE", "O" )
Next

isMobileUnique = ""
This.uf_ArmementPlafond ( "APPLICATION_TOTALE" )
// :#7 [DCMP090283]

/*------------------------------------------------------------------*/
/* Sélection automatique pour Darty Nomade, Type d'article CAF      */
/*------------------------------------------------------------------*/
// #8 [DCMP090283].[20100203161827340] 
If isCasGestionDartyNomade <> "" Then
	If Not bAmuTrouve Then
		Choose Case isCasGestionDartyNomade
			Case "10/PCP/CMD_DTY", "11/PCP/CMD_DTY", "10/NPCP/PROPO/CMD_DTY" ,&
				  "11/NPCP/PROPO/<=300/CMD_DTY", "11/NPCP/PROPO/>300/DST_ANN/CMD_DTY" // #1 #3
				bAmuTrouve = True
				sRet = This.uf_SelectionAutomatique_DtyNom_AvecPropo ()
		
			Case "10/NPCP/CMD_DTY", "11/NPCP/<=300/CMD_DTY", "11/NPCP/>300/PRS_DST_ANN/CMD_DTY", "11/NPCP/REPAR/IPAD/O2M" // #3
				bAmuTrouve = True	
				This.uf_SelectionAutomatique_DtyNom_SansPropo ()
		End Choose 
	End If
	
	// #5 [DCMP080324]
	If sRet = "BASCULE_AVEC_PROPO_VERS_SANS_PROPO" Then
	
		// On bascule alors le "CAS" avec propo vers le cas similaire sans propo
		
		Choose Case isCasGestionDartyNomade
				
			Case "10/PCP/CMD_DTY", "10/NPCP/PROPO/CMD_DTY"
				isCasGestionDartyNomade = "10/NPCP/CMD_DTY"
				// #8 [DCMP090283].[20100203161827340] 
				bAmuTrouve = True				
				
			Case "11/PCP/CMD_DTY", "11/NPCP/PROPO/<=300/CMD_DTY"
				isCasGestionDartyNomade = "11/NPCP/<=300/CMD_DTY"
				// #8 [DCMP090283].[20100203161827340] 
				bAmuTrouve = True				
				
			Case "11/NPCP/PROPO/>300/DST_ANN/CMD_DTY"
				isCasGestionDartyNomade = "11/NPCP/>300/PRS_DST_ANN/CMD_DTY"
				// #8 [DCMP090283].[20100203161827340] 
				bAmuTrouve = True				
				
		End Choose 
	
		// On réaffecte l'instance à la variable globale.
		gsCasGestion = isCasGestionDartyNomade 
	
	End If
	// :#5
End If
// :#8 [DCMP090283].[20100203161827340]

/*------------------------------------------------------------------*/
/* La gestion de sélection auto des 3 mob doit être paramétré       */
/* (-DP/45 )                                                        */
/*------------------------------------------------------------------*/
// #8 [DCMP090283].[20100203161827340]
If isCasGestionDartyNomade = "" And Not bAmuTrouve Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 45 )
	If lDeb > 0 Then 

		//* #6 [MOBISQUARE] isTypApp ald TEL
		sFiltre = "ID_FOUR = '" + Upper ( idw_DetPro.GetItemString ( lDeb, "ID_CODE_CAR" ) ) + "' AND ID_TYP_ART = '" + isTypApp + "' AND MT_PRIX_TTC <= MT_PLAF"

		// ALAPAGE #2
		F_RechDetPro ( lDeb2, lFin2, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 89 )
		If lDeb2 > 0 And isChoixAction = "S" then
			sFiltre = "ID_FOUR = '" + Upper ( idw_DetPro.GetItemString ( lDeb, "ID_CODE_CAR" ) ) + "' AND MT_PRIX_TTC <= MT_PLAF" 
		End If

		//* #7 [DCMP090283]
//		This.uf_SelectionAutomatique_Standard (Upper ( idw_DetPro.GetItemString ( lDeb, "ID_CODE_CAR" ) ), sFiltre )
		sRet = This.uf_selectionautomatique_standard_avecppo (Upper ( idw_DetPro.GetItemString ( lDeb, "ID_CODE_CAR" ) ), sFiltre )

		If sRet = "BASCULE_AVEC_PROPO_VERS_SANS_PROPO" Then
			sCasGestionStandard = "MAIL_SANS_PROPO"
		Else
			sCasGestionStandard = "MAIL_AVEC_PROPO"
		End If
		
		// Affectation à la variable globale.
		gsCasGestion = sCasGestionStandard 
		//* :#7 [DCMP090283]
		
	End If
End If





end subroutine

private function string uf_type_evenement ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::uf_Type_Evenement (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/11/2003 
//* Libellé			: Quel est le type de l'événement choisi Rempl, Remb, Répar ?
//* Commentaires	: 
//*
//* Arguments		: String		asPos		Réf.
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*
//*-----------------------------------------------------------------

Long			lDeb, lFin, lTotTb, lCpt, lPos
String 		sLibEvt, sTbLibEvt [], sVal
Int			iRet

sTbLibEvt [1] = "REMPL"
sTbLibEvt [2] = "REMBO"
sTbLibEvt [3] = "REPAR"
sTbLibEvt [4] = "RÉPAR"


sLibEvt  = Upper ( idwDetail.Describe ( "Evaluate ('LookUpDisplay ( ID_EVT )', 1)" ) )

lTotTb = UpperBound ( sTbLibEvt )

/*------------------------------------------------------------------*/
/* On recherche par le libellé de l'Evt s'il s'agit d'un            */
/* Remplacement, Remboursement ou réparation. Je fais cette         */
/* recherche par libellé et non par ID afin que ce code prenne en   */
/* compte tous les nouveaux Evt de ce type qui pourraient être      */
/* créés par la suite.                                              */
/*------------------------------------------------------------------*/
sVal = ""
For lCpt = 1 to lTotTb 
	lPos = Pos ( sLibEvt, sTbLibEvt [lCpt], 1 )
	If lPos > 0 Then
		sVal = sTbLibEvt [lCpt]
		Exit
	End If
Next

Return sVal


end function

private function string uf_controlergestion_prs_fournmarqmob (string asidfour, string asidtypart, string asidmarqart);//*-----------------------------------------------------------------
//*
//* Fonction      : n_Cst_W_Commande3::uf_ControlerGestion_Prs_FournMarqMob (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 28/06/2004 14:30:06
//* Libellé       : Vérification Marques/fournisseurs pour les REPARATIONS.
//* Commentaires  : 
//*
//* Arguments     : String		sIdFour		Val
//* 					  String		sIdTypArt	Val
//* 					  String		sIdMarqArt	Val
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    23/11/2004  DCMP 040493 aiguillage par prod/marq.
//*      MADM    09/01/2006  DCMP 060008 Fournisseur SBE pour la marque BENQ
//*      MADM    26/01/2006  DCMP 060092 Fournisseur SBE pour la marque PANTECH
//* #2    JFF	  07/02/2006  [DCMP060119] modif suite ajout frn AEVUM
//* #3   MADM	  09/03/2006  [DCMP060356] modif suite ajout frn CORDON
//* #4   MADM	  22/05/2006  [DCMP060423] Fournisseur A-NOVO pour la marque SONY ERICSSON du code produit 10902
//* #5    MADM   18/08/2006  [DCMP060572] Fournisseur SBE pour la marque SAMSUNG
//* #6   MADM	  22/08/2006  [DCMP060577] Fournisseur A-NOVO pour la marque SONY ERICSSON du code produit 10909
//* #7   JFF	  12/12/2006  [DCMP060915] Les HTC vont chez Cordon
//* #8    JFF    10/04/2006  [DCMP070250] pour 9110 et 10908, les S.ERICSSON vont chez ANV
//* #9	 JFF    29/05/2007  [DCMP070344] Envoi des SHARP cheaz cordon
//* #10	 JFF    31/10/2007  [DCMP070819] Envoi des ETEN chez cordon
//* #11   JFF    16/11/2007  [DCMP070881] Nouvelle technique pour gérer aiguiller sur Marque/Modèle
//* #12   JFF    11/12/2007  [DCMP070880] LG vers COdron pour prod part.
//* #13	 JFF	  10/01/200	  [DCMP080034] SONY ERIC  W910I vers ANOVO
//* #14	 JFF	  16/01/2007  [DCMP080057] SONY ERIC  W890I et 380I vers ANOVO
//* #15	 PHG	  21/01/2008  [DCMP080073] Retrait RIM BLACKBERRY en Interdiction Totale
//*										    & Routage RIM BLACKBERRY vers SBE.
//* #16   JFF    29/01/2008  [DCMP080098] HUAWEI vers CORDON
//* #17   JFF    15/04/2008  [DMDI22614] TWINSIM Vers Acean
//* #18   JFF    02/06/2008  [DMDI22949] MODELABS MTV3.3 vers Cordon
//* #29   JFF    19/06/2008  [DCMP080500] Aiguillage par pourcentage d'envoi
//* #30	 JFF	  06/01/2009  [DMDI24606]
//* #31	 JFF	  05/03/2009  [DMDI25066]
//* #32	 FPI		20/03/2009	[DCMP090109] O2M Réparateur d'IPhone
//* #33   JFF	  20/04/2009  [DMDI25515][DMDI25516] 
//* #34   JFF    24/06/2009  [DMDI25985]
//* #35   JFF    24/06/2009  [DCMP090355]
//* #36   JFF    02/09/2009  [DCMP090327].[SBETV]
//*-----------------------------------------------------------------

String sIdGti, sRech, sIdFourModif
Long	 lTotRow, lRow, lIdProd, lDeb, lFin
Boolean bErr
n_cst_attrib_key	lnv_Key[] 			

sIdGti  = String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) )
lIdProd = idwWsin.GetItemNumber ( 1, "ID_PROD" )
lTotRow = idwFourn.RowCount ()
bErr	  = False

//* #36 [DCMP090327].[SBETV]
// stMessage.sCode = "COMD069"
stMessage.sCode = "COMD552"
stMessage.sVar [1] = isFournParDefaut 
stMessage.sVar [2] = asidfour

bErr = Upper ( asidfour ) <> Upper ( isFournParDefaut ) 

If bErr Then
	F_Message ( stMessage )
	Return "G" + "PROBLEME"
End If

Return ""
//* :#36 [DCMP090327].[SBETV]


end function

public function string uf_controlersaisieselection ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerSaisieSelection (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 29/06/2004
//* Libellé			: Contrôle de saisie pour une sélection de mobile à placer sur un courrier
//* Commentaires	: 
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    21/01/2011  [PC301].[V15_EVOL_VETUSTE]
//*-----------------------------------------------------------------
String 	sNouvelleLigne, sPos, sText, sDw, sFiltreOrig 
String	sIdGti, sIdEvt, sFind, sIdRev 
Long 		lRow

sNouvelleLigne		= "~r~n"
sPos					= ""
sText					= sNouvelleLigne
sDw					= ""

/*------------------------------------------------------------------*/
/* Nous sommes en sélection de mobiles à placer sur courriers. Si   */
/* le mobile sinistré du client est dispo chez un fournisseur,      */
/* impossible de sélectionner un mobile, il faut directement le     */
/* commander (par la fenêtre des commandes)                         */
/*------------------------------------------------------------------*/
If isMobileUnique <> "" Then
	sDw = "G"
	stMessage.sTitre  	= "Controle de saisie"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "COMD080"
	F_Message ( stMessage )
	Return sDw + sPos
End If 


sFiltreOrig = iDwArticle.Describe ( "datawindow.table.filter" ) 
If sFiltreOrig = "?" Then sFiltreOrig = ""

idwArticle.SetFilter ( "CHOIX = 'O'" )
idwArticle.Filter ( )

/*------------------------------------------------------------------*/
/* Au moins une commande doit être saisie.								  */
/*------------------------------------------------------------------*/
If idwArticle.RowCount () <= 0 Then
	sDw = "G"
	
	stMessage.sTitre  	= "Controle de saisie"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "GENE001"
	stMessage.sVar [1] 	= sNouvelleLigne + " - Au moins une sélection" + sNouvelleLigne
	F_Message ( stMessage )
	Return sDw + sPos
End If 

idwArticle.SetFilter ( sFiltreOrig )
idwArticle.Filter ( )

// [PC301].[V15_EVOL_VETUSTE]
sIdGti = String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) )
sIdEvt = String ( idwDetail.GetItemNumber ( 1, "ID_EVT" ) )
sIdRev = String ( idwWsin.GetItemNumber ( 1, "ID_REV" ) )	

sFind = 	" ID_GTI = " + sIdGti + &
			" AND ID_REV = " + sIdRev + &	
			" AND ID_NIV_PLAF = '+EV' " + &
			" AND ID_REF_PLAF = " + sIdEvt + &							
			" AND ID_TYP_PLAF = '722' " + &
			" AND ID_CPT_PLAF = 0"	

If idwPlafond.Find ( sFind, 1, idwPlafond.RowCount () ) > 0 Then

	lRow = idwwDivDet.Find ( "Upper (NOM_ZONE) = 'MT_MAX_PROPO_PLF722'", 1, idwwDivDet.RowCount () ) 
	If lRow <= 0 Then 
		sDw = "G"
		
		stMessage.sTitre  	= "Controle de saisie"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "COMD653"
		F_Message ( stMessage )
		Return sDw + sPos
	End If
End If
// :[PC301].[V15_EVOL_VETUSTE]


Return sDw + sPos


end function

public function string uf_controlergestionselection ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestionSelection (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 06/09/2001
//* Libellé			: controle de gestion pour une sélection de mobiles à placer sur courrier
//* Commentaires	: Controle de Gestion
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    29/06/2004  DCMP 030304 S. Lecroq
//*-----------------------------------------------------------------

Int					iRet
String				sPos, sDw, sNouvSel
Long					lTot, lCpt, lRow, lDeb, lFin, lNbreSel 

iRet = 1
sPos = ""
sDw  = ""

stMessage.sTitre  	= "Controle de gestion"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= Ok!


/*------------------------------------------------------------------*/
/* #1 : Gestion sélection courrier -DP,15									  */
/*------------------------------------------------------------------*/
sNouvSel = Left ( idwBandeau.GetItemString ( 1, "NOUV_CMDE" ), 2 ) 
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 15 )

If lDeb > 0 Then

		lNbreSel = idw_DetPro.GetItemNumber ( lDeb, "VAL_NUM" ) 
		If IsNull ( lNbreSel ) Then lNbreSel = 100
		sDw = "G"

		If IsNumber ( sNouvSel ) Then
			If Integer ( sNouvSel ) > lNbreSel Then
				stMessage.sTitre		= "Commandes"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= Ok!
				stMessage.sCode		= "COMD070"
				stMessage.sVar [1]   = String( lNbreSel )
				F_Message ( stMessage )
				Return sDw 
			End If
		End If

End If

Return sPos
end function

private subroutine uf_gestionzone_infospbfrn (long alrowchoix, ref datawindow adw);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_Commande3::uf_GestionZone_InfoSpbFrn (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 30/06/2004 14:58:44
//* Libellé       : Gestion de la zone Info_Spb_Frn
//* Commentaires  : DCMP 040206
//*
//* Arguments     : Long			alRowChoix		Val		// Row du mobile cliqué
//*					  DataWindow	aDw				Réf	   // Dw commande ou prestation ?
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   26/03/2008   [SURCOUF_ECH_EXPRESS]
//        JFF   29/02/2016   [DT191-1]
//*-----------------------------------------------------------------

Long	lRow, lIdListe, lDefaut
DataWindowChild dwChild
String sFiltreOrig, sIdGti, sIdTypArt, sIdFour, sLabel, sFiltreFrn, sFiltreArt, sFiltreDef

sFiltreArt = ""

idwTypArt.SetRedraw ( False )
idwTypArt.TriggerEvent ( "ue_RFC_False" )

sIdGti = String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) )

sIdFour = adw.GetItemString ( alRowChoix, "ID_FOUR" )
sIdTypArt = adw.GetItemString ( alRowChoix, "ID_TYP_ART" )

lRow = idwFourn.Find ( "ROWSELECT = 'O'", 1, idwFourn.RowCount () )

sFiltreFrn = ""
If lRow > 0 Then
	If Pos ( idwFourn.GetItemString ( lRow, "ID_CODE_FRN"), "TOUS" ) <= 0 Then
		sFiltreFrn = " AND ID_CODE_FRN = '" + sIdFour + "' "
	End If 
End If

/*------------------------------------------------------------------*/
/* Si nous sommes en sélection pour le courrier, il faut filtrer    */
/* (exclure) les fournisseur de prestation.                         */
/*------------------------------------------------------------------*/
Choose Case isChoixAction
	Case "S", "C"
		sFiltreArt += " AND ID_CODE_ART <> 'PRS'"
	Case "R"
		sFiltreArt += " AND ID_CODE_ART = 'PRS'"
	Case "I"
		sFiltreArt += " AND ID_CODE_ART = 'EDI'"
End Choose

sFiltreOrig = "ID_GTI = " + sIdGti + " AND ID_CODE_ART <> '-1' AND ID_TYP_CODE = '-XX'" + sFiltreFrn + sFiltreArt 


idwTypArt.SetFilter ("")
idwTypArt.Filter ()

lRow = idwTypArt.Find ( "ID_GTI = " + sIdGti + " AND ID_CODE_FRN = '" + sIdFour + "' AND ID_CODE_ART = '" + sIdTypArt + &
								"' AND ID_TYP_CODE = '-IF'", 1, idwTypArt.RowCount () )

/*------------------------------------------------------------------*/
/* Aucune liste d'information n'est gérée pour le quarté, on rend   */
/* donc invisible le label et la zone (-100)                        */
/*------------------------------------------------------------------*/
If lRow <= 0 Then 
	adw.SetITem ( alRowChoix, "INFO_SPB_FRN", -100 )
	idwTypArt.SetFilter( sFiltreOrig ) 
	idwTypArt.Filter() 
	lRow = idwTypArt.Find ( "ID_GTI = " + sIdGti + " AND ID_CODE_FRN = '" + sIdFour + "' AND ID_CODE_ART = '" + sIdTypArt + "' AND ROWSELECT = 'O'", 1, idwTypArt.RowCount () )
	idwTypArt.ScrollToRow ( lRow )
	idwTypArt.SetRow ( lRow )
	idwTypArt.SetRedraw ( TRUE )
	idwTypArt.TriggerEvent ( "ue_RFC_True" )
	Return
End If

/*------------------------------------------------------------------*/
/* Récupération du code de la liste qui est forcément une centaine. */
/*------------------------------------------------------------------*/
lIdListe = idwTypArt.GetItemNumber ( lRow, "ID_CODE" )

adw.GetChild ( "INFO_SPB_FRN", dwChild )

dwChild.SetFilter ( "ID_CODE = " + String ( lIdListe + 1 ) )
dwChild.Filter ()

If dwChild.RowCount () <> 1 Then 
	adw.SetITem ( alRowChoix, "INFO_SPB_FRN", -100 )
	idwTypArt.SetFilter( sFiltreOrig ) 
	idwTypArt.Filter() 
	lRow = idwTypArt.Find ( "ID_GTI = " + sIdGti + " AND ID_CODE_FRN = '" + sIdFour + "' AND ID_CODE_ART = '" + sIdTypArt + "' AND ROWSELECT = 'O'", 1, idwTypArt.RowCount () )
	idwTypArt.ScrollToRow ( lRow )
	idwTypArt.SetRow ( lRow )
	idwTypArt.SetRedraw ( TRUE )
	idwTypArt.TriggerEvent ( "ue_RFC_True" )
	Return
End If

/*------------------------------------------------------------------*/
/* Mise à jour de label.                                            */
/*------------------------------------------------------------------*/
sLabel = dwChild.GetItemString ( 1, "LIB_CODE" )
sLabel = F_Remplace ( sLabel , "'", "~~'" )

adw.Modify ( "info_spb_frn_t.text = '" + sLabel  + "'" )

/*------------------------------------------------------------------*/
/* Gestion des cas particuliers                                     */
/*------------------------------------------------------------------*/
SetNull ( lDefaut )
sFiltreDef = ""
This.uf_GestionZone_InfoSpbFrn_CasPart ( alRowChoix, aDw, sFiltreDef, lDefaut, lIdListe )  // #1 ajout lIdListe

/*------------------------------------------------------------------*/
/* Valeur par défaut à placer si présence élément x99 dans la liste */
/*------------------------------------------------------------------*/
If Not IsNull ( lDefaut ) Then
	adw.SetITem ( alRowChoix, "INFO_SPB_FRN", lDefaut )
Else 
	lDefaut = adw.GetItemNumber ( alRowChoix, "INFO_SPB_FRN" )
	If IsNull ( lDefaut ) Then 
		dwChild.SetFilter ( "ID_CODE = " + String ( lIdListe + 99 ) )
		dwChild.Filter ()

		If dwChild.RowCount () > 0 Then 
			adw.SetITem ( alRowChoix, "INFO_SPB_FRN", Long ( dwChild.GetItemString ( 1, "LIB_CODE" ) ) )
		End If
	End If
End If

/*------------------------------------------------------------------*/
/* On filtre définitivement la liste pour l'affichage.              */
/*------------------------------------------------------------------*/
sFiltreDef = "ID_CODE > " + String ( lIdListe + 1 ) + " AND ID_CODE < " + String ( lIdListe + 99 ) + sFiltreDef 
dwChild.SetFilter ( sFiltreDef )
dwChild.Filter ()

idwTypArt.SetFilter( sFiltreOrig ) 
idwTypArt.Filter() 
idwTypArt.Sort ()
lRow = idwTypArt.Find ( "ID_GTI = " + sIdGti + sFiltreFrn + " AND ID_CODE_ART = '" + sIdTypArt + "' AND ROWSELECT = 'O'", 1, idwTypArt.RowCount () )
idwTypArt.ScrollToRow ( lRow )
idwTypArt.SetRow ( lRow )
idwTypArt.SetRedraw ( TRUE )
idwTypArt.TriggerEvent ( "ue_RFC_True" )



end subroutine

private subroutine uf_controlersaisie_zn_infospbfrn (long alcpt, ref string asmesserr);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_W_Commande3::uf_ControlerSaisie_Zn_InfoSpbFrn (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 30/06/2004 17:36:26
//* Libellé       : Gestion particulière pour le contrôle de la zone InfoSpbFrn
//* Commentaires  : DCMP 040206
//*
//* Arguments     : Long 		alCpt				Val
//*					  String		asMessErr		Réf
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

Long	lRow, lIdListe
DataWindowChild dwChild
String sFiltreOrig, sIdGti, sIdTypArt, sIdFour, sLabel, sFiltreFrn, sFiltreOrigChild, sFiltreDef

idwTypArt.SetRedraw ( False )
asMessErr = ""

sIdGti = String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) )

sIdFour = idwArticle.GetItemString ( alCpt, "ID_FOUR" )
sIdTypArt = idwArticle.GetItemString ( alCpt, "ID_TYP_ART" )

lRow = idwFourn.Find ( "ROWSELECT = 'O'", 1, idwFourn.RowCount () )

sFiltreFrn = ""
If lRow > 0 Then
	If Pos ( idwFourn.GetItemString ( lRow, "ID_CODE_FRN"), "TOUS" ) <= 0 Then
		sFiltreFrn = " AND ID_CODE_FRN = '" + sIdFour + "' "
	End If 
End If

sFiltreOrig = "ID_GTI = " + sIdGti + sFiltreFrn + " AND ID_CODE_ART <> '-1' AND ID_TYP_CODE = '-XX'"

idwTypArt.SetFilter ("")
idwTypArt.Filter ()

lRow = idwTypArt.Find ( "ID_GTI = " + sIdGti + " AND ID_CODE_FRN = '" + sIdFour + "' AND ID_CODE_ART = '" + sIdTypArt + &
								"' AND ID_TYP_CODE = '-IF'", 1, idwTypArt.RowCount () )

/*------------------------------------------------------------------*/
/* Aucune liste d'information n'est gérée pour le quarté, on rend   */
/* donc invisible le label et la zone (-100)                        */
/*------------------------------------------------------------------*/
If lRow <= 0 Then 
	asMessErr = ""
	idwTypArt.SetFilter( sFiltreOrig ) 
	idwTypArt.Filter() 
	lRow = idwTypArt.Find ( "ID_GTI = " + sIdGti + " AND ID_CODE_FRN = '" + sIdFour + "' AND ID_CODE_ART = '" + sIdTypArt + "' AND ROWSELECT = 'O'", 1, idwTypArt.RowCount () )
	idwTypArt.ScrollToRow ( lRow )
	idwTypArt.SetRow ( lRow )
	idwTypArt.SetRedraw ( TRUE )
	Return
End If

/*------------------------------------------------------------------*/
/* Récupération du code de la liste qui est forcément une centaine. */
/*------------------------------------------------------------------*/
lIdListe = idwTypArt.GetItemNumber ( lRow, "ID_CODE" )

idwArticle.GetChild ( "INFO_SPB_FRN", dwChild )

/*------------------------------------------------------------------*/
/* Filtre recherche valeur par défaut (présence elt x99)				  */
/*------------------------------------------------------------------*/
dwChild.SetFilter ( "ID_CODE = " + String ( lIdListe + 99 ) )
dwChild.Filter ()

/*------------------------------------------------------------------*/
/* Il y a une valeur par défaut, on la renseigne dans la zone et    */
/* l'on sort.                                                       */
/*------------------------------------------------------------------*/
If dwChild.RowCount () > 0 Then
	idwArticle.SetItem ( alCpt, "INFO_SPB_FRN", Long ( dwChild.GetItemString ( 1, "LIB_CODE") ) )
	asMessErr = ""
	
	sFiltreDef = "ID_CODE > " + String ( lIdListe + 1 ) + " AND ID_CODE < " + String ( lIdListe + 99 ) + sFiltreDef 
	dwChild.SetFilter ( sFiltreDef )
	dwChild.Filter ()
	
	Return	
End If

/*------------------------------------------------------------------*/
/* Filtre pour récupératino du libellé de la liste.                 */
/*------------------------------------------------------------------*/
dwChild.SetFilter ( "ID_CODE = " + String ( lIdListe + 1 ) )
dwChild.Filter ()

If dwChild.RowCount () <> 1 Then 
	asMessErr = "l'information à transmettre au fournisseur"

	sFiltreDef = "ID_CODE > " + String ( lIdListe + 1 ) + " AND ID_CODE < " + String ( lIdListe + 99 ) + sFiltreDef 
	dwChild.SetFilter ( sFiltreDef )
	dwChild.Filter ()
	
	idwTypArt.SetFilter( sFiltreOrig ) 
	idwTypArt.Filter() 
	lRow = idwTypArt.Find ( "ID_GTI = " + sIdGti + " AND ID_CODE_FRN = '" + sIdFour + "' AND ID_CODE_ART = '" + sIdTypArt + "' AND ROWSELECT = 'O'", 1, idwTypArt.RowCount () )
	idwTypArt.ScrollToRow ( lRow )
	idwTypArt.SetRow ( lRow )
	idwTypArt.SetRedraw ( TRUE )
	Return
End If

/*------------------------------------------------------------------*/
/* Armement du message d'erreur à retourner (libellé)					  */
/*------------------------------------------------------------------*/
asMessErr = dwChild.GetItemString ( 1, "LIB_CODE" )

sFiltreDef = "ID_CODE > " + String ( lIdListe + 1 ) + " AND ID_CODE < " + String ( lIdListe + 99 ) + sFiltreDef 
dwChild.SetFilter ( sFiltreDef )
dwChild.Filter ()

idwTypArt.SetFilter( sFiltreOrig ) 
idwTypArt.Filter() 
lRow = idwTypArt.Find ( "ID_GTI = " + sIdGti + sFiltreFrn + " AND ID_CODE_ART = '" + sIdTypArt + "' AND ROWSELECT = 'O'", 1, idwTypArt.RowCount () )
idwTypArt.ScrollToRow ( lRow )
idwTypArt.SetRow ( lRow )
idwTypArt.SetRedraw ( TRUE )


end subroutine

private function integer uf_zn_rib (ref datawindow adw, string asdata, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_Zn_Rib (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/07/2001
//* Libellé			: 4 Zones du RIB
//* Commentaires	: 
//*
//* Arguments		: aDw				DataWindow	Val
//*					  asData			String		Val
//*					  alRow			String		Val
//*
//* Retourne		: Int
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*---------------------------------------------------------------

Integer iRet
String sRibBq, sRibGui, sRibCpt, sRibCle

iRet	= 2


Choose Case idwCmde.isNomCol
Case "RIB_BQ"
	If Not IsNull ( asData ) And asData <> "" Then 
		sRibBq = String (  Dec ( asData ), "00000" )
	End If
	idwCmde.SetItem ( alRow,  "RIB_BQ", sRibBq )
	idwCmde.SetItem ( alRow,  "RIB_CLE", stNul.str )

Case "RIB_GUI"
	If Not IsNull ( asData ) And asData <> "" Then 
		sRibGui	= String ( Dec ( asData ), "00000" )
	End IF
	idwCmde.SetItem ( alRow,  "RIB_GUI", sRibGui )
	idwCmde.SetItem ( alRow,  "RIB_CLE", stNul.str )

Case "RIB_CPT"

	If Not IsNull ( asData ) And asData <> "" Then 
		sRibCpt = Fill ( "0", 11 - Len ( asData ) ) + asData
	End If
	idwCmde.SetItem ( alRow,  "RIB_CPT", sRibCpt )
	idwCmde.SetItem ( alRow,  "RIB_CLE", stNul.str )

Case "RIB_CLE"
	sRibBq	= idwCmde.GetItemString ( alRow, "RIB_BQ" )
	sRibGui	= idwCmde.GetItemString ( alRow, "RIB_GUI" )
	sRibCpt	= idwCmde.GetItemString ( alRow, "RIB_CPT" )

	sRibCle	= asData
	
	If	Not IsNull ( sRibBq + sRibGui + sRibCpt + sRibCle ) Then
		If	Not F_Rib ( sRibBq, sRibGui, sRibCpt, sRibCle ) Then
			iRet			= 1
			idwCmde.iiErreur = 1
		End If
	End If

	If iRet <> 1 Then
		idwCmde.SetItem ( alRow,  "RIB_CLE", sRibCle )
	End If

End Choose

Return iRet
end function

private function string uf_controlergestion_sbe (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_SBE (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/07/2004
//* Libellé			: Controle Spécifique pour SBE
//* Commentaires	: DCMP 040206/040291 : Controle spéciale pour SBE en fonction de la 
//*					  liste -IF
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	JCA	26/12/2006	DCMP 060907 - Changement de l'appel à F_Determiner_Montant_Frais_Envoi
//*									ajout des arguments alidprod (Val), adwdetpro (Ref), adcFrais (Ref)
//		 	FPI	24/06/2010 [DCMP100551] Modification de l'option 76
//       JFF   22/07/2015 [DT168]
//       JFF   23/06/2020 [PC202553_SELECTRA]
//*-----------------------------------------------------------------

String sPos, sProbleme, sCodModeReg, sTypPresta 
Long lInfoSpbFrn, lIdEvt, lIdGti, lDEb, lFin 
Dec {2} dcFrais //#1
Boolean bRibVide
Boolean bPc441 // Pièce facture d'achat&Reglt cotisation.
Boolean bPc74  // Copie bulletion adhésion
Boolean bAutoriseCmde 

sPos = ""
bAutoriseCmde = FALSE

lIdEvt = idwDetail.GetItemNumber ( 1, "ID_EVT" ) // [PM200][LOT2][DESOX]
lIdGti = idwDetail.GetItemNumber ( 1, "ID_GTI" ) 

/*------------------------------------------------------------------*/
/* Si au moins une prestation vers SBE est détectée                 */
/* ET sur laquelle la zone info_spb_frn est égale à 210  (client    */
/* envoi son mobile)                                                */
/* ET que la méthode de règlement et " VA "                         */
/* ET que le RIB est vide                                           */
/* ALORS afficher un message :                                      */
/*------------------------------------------------------------------*/
lInfoSpbFrn = idwArticle.GetItemNumber ( alCpt, "INFO_SPB_FRN" ) 

// [PC202553_SELECTRA]
sTypPresta = idwArticle.GetItemString  ( alCpt, "ID_TYP_ART" )  

sCodModeReg = idwCmde.GetItemString ( 1, "COD_MODE_REG" ) 
bRibVide    = 	IsNull ( idwCmde.GetItemString ( 1, "RIB_BQ" ) ) Or idwCmde.GetItemString ( 1, "RIB_BQ" ) = Fill ( "0", 5 ) Or &
					IsNull ( idwCmde.GetItemString ( 1, "RIB_GUI" ) ) Or idwCmde.GetItemString ( 1, "RIB_GUI" ) = Fill ( "0", 5 ) Or &
					IsNull ( idwCmde.GetItemString ( 1, "RIB_CPT" ) ) Or idwCmde.GetItemString ( 1, "RIB_CPT" ) = Fill ( "0", 11 ) Or&
					IsNull ( idwCmde.GetItemString ( 1, "RIB_CLE" ) ) 

If  lInfoSpbFrn = 210 Then
		/*------------------------------------------------------------------*/
		/* On déprotège les zones                                           */
		/*------------------------------------------------------------------*/
		idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "0" )
Else 
		/*------------------------------------------------------------------*/
		/* Sinon on laisse protègé.													  */
		/*------------------------------------------------------------------*/
		idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "1" )
End If 

If  lInfoSpbFrn = 210 And Upper ( sCodModeReg ) = "VA" And bRibVide Then
		stMessage.sCode = "COMD071"
		F_Message ( stMessage )
		Return "D" + "RIB_BQ"
End If

/*------------------------------------------------------------------*/
/* Message d'information pour le gestionnaire                       */
/*------------------------------------------------------------------*/
If  lInfoSpbFrn = 210 Then
	stMessage.sCode = "COMD079"
	//stMessage.sVar [1] = F_Determiner_Montant_Frais_Envoi ( String ( lInfoSpbFrn ), idwWsin.object.id_prod[1], idw_DetPro, dcFrais ) // #1
	stMessage.sVar [1] = F_Determiner_Montant_Frais_Envoi ( String ( lInfoSpbFrn ), idwWsin.object.id_prod[1],isTypApp, idw_DetPro, dcFrais ) // [DCMP100551]
	stMessage.sVar [2] = String ( idwCmde.GetItemNumber ( 1, "ID_SIN" ) ) + "-" + String (  This.uf_Nouveau_Num_Sequence () ) 
	F_Message ( stMessage )
End If 

// [DT168]
If lIdGti = 24 and lIdEvt = 1377 Then
	stMessage.sCode = "COMD921"
	stMessage.Icon	 = Exclamation!
	F_Message ( stMessage )
	Return "D" + "RIB_BQ"
End If

Choose Case lInfoSpbFrn
	Case 	905, 910, 961, 962
		This.uf_message_process_o2m( alCpt, lInfoSpbFrn )		
End Choose


// [PC202553_SELECTRA]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 348)
If lDeb > 0 and sTypPresta = "CAF" Then
	Choose Case isTypApp
		Case "CQA"
			Choose Case isMarqPortAdh
				Case "BEATS"
					bAutoriseCmde = True
							
			End Choose 
			
		Case "MCS"
			Choose Case isMarqPortAdh
				Case "APPLE"
					bAutoriseCmde = Pos ( isModlPortAdh, "WATCH" ) > 0 
			End CHoose 							
			
	End Choose
	
	If Not bAutoriseCmde Then 
		stMessage.sCode = "COMD994"
		stMessage.sVar[1] = "SBE"
		F_Message ( stMessage )
		Return "G" + "ALT_CHOIX"
	End If 
End If 

Return sPos

end function

private subroutine uf_preparervalider_inter ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerValider_Inter (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 08/07/2004 10:49:34
//* Libellé			: Mise à jour de la table Inter
//* Commentaires	: 
//*
//* Arguments		:
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lRow
String sVal, sVal1
Boolean bMaj

bMaj = False

lRow = idwLstInter.Find ( "COD_INTER = 'A'", 1, idwLstInter.RowCount () )

If lRow <= 0 Then Return 

sVal  = idwCmde.GetItemString ( 1, "COD_MODE_REG" )
sVal1 = idwLstInter.GetItemString  ( lRow, "COD_MODE_REG" )
If IsNull ( sVal ) Then sVal = ""
If IsNull ( sVal1 ) Then sVal1 = ""

If Upper ( sVal ) <> Upper ( sVal1 ) Then
	bMaj = True
	idwLstInter.SetItem ( lRow, "COD_MODE_REG", sVal )
End If 

sVal = idwCmde.GetItemString ( 1, "RIB_BQ" ) 
sVal1 = idwLstInter.GetItemString  ( lRow, "RIB_BQ" )
If IsNull ( sVal ) Then sVal = ""
If IsNull ( sVal1 ) Then sVal1 = ""

If Upper ( sVal ) <> Upper ( sVal1 ) Then
	bMaj = True
	idwLstInter.SetItem ( lRow, "RIB_BQ", sVal )
End If

sVal = idwCmde.GetItemString ( 1, "RIB_GUI" ) 
sVal1 = idwLstInter.GetItemString  ( lRow, "RIB_GUI" )
If IsNull ( sVal ) Then sVal = ""
If IsNull ( sVal1 ) Then sVal1 = ""

If Upper ( sVal ) <> Upper ( sVal1 ) Then
	bMaj = True
	idwLstInter.SetItem ( lRow, "RIB_GUI", sVal )
End If

sVal = idwCmde.GetItemString ( 1, "RIB_CPT" ) 
sVal1 = idwLstInter.GetItemString  ( lRow, "RIB_CPT" )
If IsNull ( sVal ) Then sVal = ""
If IsNull ( sVal1 ) Then sVal1 = ""

If Upper ( sVal ) <> Upper ( sVal1 ) Then

	bMaj = True
	idwLstInter.SetItem ( lRow, "RIB_CPT", sVal )
End If

sVal = idwCmde.GetItemString ( 1, "RIB_CLE" ) 
sVal1 = idwLstInter.GetItemString  ( lRow, "RIB_CLE" )
If IsNull ( sVal ) Then sVal = ""
If IsNull ( sVal1 ) Then sVal1 = ""

If Upper ( sVal ) <> Upper ( sVal1 ) Then

	bMaj = True
	idwLstInter.SetItem ( lRow, "RIB_CLE", sVal )
End If

/*------------------------------------------------------------------*/
/* Si au moins une maj, on averti le gestionnaire                   */
/*------------------------------------------------------------------*/
If bMaj Then
	stMessage.sTitre  	= "Controle de gestion"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode = "COMD074"		
	F_Message ( stMessage )
End If
end subroutine

private function integer uf_nouveau_num_sequence ();//*-----------------------------------------------------------------
//*
//* Fonction      : dw_regle_coherence::uf_Nouveau_Num_Sequence (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 09/07/2004 15:29:56
//* Libellé       : Renvoi le numéro de séquence pour la commande en cours
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

Long lSeqMax, lSeqMax1, lSeqMax2  

lSeqMax = Long ( idwCmdeSin.Describe ( "Evaluate ( 'max (id_seq)', 0 )") )
lSeqMax1 = Long ( idwCmdeDet.Describe ( "Evaluate ( 'max (id_seq)', 0 )") )
lSeqMax2 = Long ( idwCmdeGti.Describe ( "Evaluate ( 'max (id_seq)', 0 )") )

/*------------------------------------------------------------------*/
/* Il peut déjà y avoir des commandes au niveau détail              */
/*------------------------------------------------------------------*/
If lSeqMax1 > lSeqMax Then lSeqMax = lSeqMax1
If lSeqMax2 > lSeqMax Then lSeqMax = lSeqMax2

If lSeqMax <= 0 Or IsNull ( lSeqMax ) Then lSeqMax = 0

lSeqMax ++

Return lSeqMax 

end function

private function string uf_controlergestion_mss (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_MSS (PRIVATE)
//* Auteur			: Catherine Abdmeziem
//* Date				: 21/09/2004
//* Libellé			: Controle Spécifique pour MSS
//* Commentaires	: DCMP 040381 : Affichage d'un msg à la validation
//*												  de prs pour MSS
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    30/11/2004  DCMP 040415
//* 
//*-----------------------------------------------------------------

String sPos

sPos = ""

/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
stMessage.sTitre		= "Alerte MSS"
stMessage.Bouton		= YESNO!
stMessage.Icon			= Exclamation!
stMessage.bErreurG	= FALSE
stMessage.sCode		= "COMD090"
If f_Message ( stMessage ) = 2 Then
	Return "PROBLEME"
End If

/*------------------------------------------------------------------*/
/* Message d'information pour le gestionnaire                       */
/*------------------------------------------------------------------*/
stMessage.sCode = "COMD077"
stMessage.sVar [1] = String ( idwCmde.GetItemNumber ( 1, "ID_SIN" ) ) + "-" + String (  This.uf_Nouveau_Num_Sequence () ) 
F_Message ( stMessage )
Return sPos

end function

public subroutine uf_initialiser (ref s_pass astpass, ref u_sp_ifr_pilote auoequivfct);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_Initialiser (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 19/09/2001
//* Libellé			: Initialisation
//* Commentaires	: 
//*
//* Arguments		: astPass			s_Pass					Ref
//*					  auoEquivFct		u_sp_ifr_pilote		Ref   // Object visuel de recherche d'Equiv. Fct.
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 CAG   16/06/2003	  Modification de la marque portable en dddw
//* #2    JFF	 30/06/2004	  DCMP 040206
//* #3    JFF   22/03/2006   supprimer insertion tous fournisseurs déporté dans la requête.
//* #4    JFF   04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
//* #5    JFF   13/02/2008   [FNAC_PROD_ECH_TECH].[20090224144248310]
//        JFF   06/08/2012   [BLCODE]
//        JFF   07/03/2024   [HP252_276_HUB_PRESTA]
//*----------------------------------------------------------------

Long lRow, ll_ret
DataWindowChild	dwChild, dwChild1

idwCmde 		= astPass.dwTab  [1] 
idwLstInter = astPass.dwTab  [2] 
idwCmdeSin 	= astPass.dwTab  [3] 
idwCmdeDet 	= astPass.dwTab  [4] 
idwCmdeGti	= astPass.dwTab  [5] 
idwwDivDet  = astPass.dwTab  [6] // #4 
idwLstDetail= astPass.dwTab  [7] // [BLCODE]	
		
istAltPec	= astPass.stTab  [1] // #4
ilMarquaGeBLCODE = astPass.lTab  [1] // [BLCODE]

idwFourn 	= astPass.dwNorm [1]
idwTypArt 	= astPass.dwNorm [2]
idwArticle 	= astPass.dwNorm [3]
idwBandeau 	= astPass.dwNorm [4]
idwPlafond 	= astPass.dwNorm [5]
idwArticlePrs = astPass.dwNorm [6]
idwProduit	  = astPass.dwNorm [7]
idwInfoCmde	  = astPass.dwNorm [8]
idwCmdTypFrn  = astPass.dwNorm [9]
idwCmdTypArt  = astPass.dwNorm [10]
idwCommune    = astPass.dwNorm [11]
idwTacImei    = astPass.dwNorm [12]
idwStkIFR     = astPass.dwNorm [13]
idwcodeEquiv  = astPass.dwNorm [14]
idwAutorisation = astPass.dwNorm [15]
//* #5 [FNAC_PROD_ECH_TECH].[20090224144248310]
idwWpieceGti = astPass.dwNorm [16] // Pièce cochée sur la garantie

ibAltCommune  = astPass.bTab [1]

idwWSin		= astPass.dwMaster
idwDetail	= astPass.dwMaster1
idwWdivSin  = astPass.udwTab [1]
idwDivDetGti = astPass.udwTab [2] // [BLCODE]
		
iuoEqvFct 	= auoEquivFct

/*------------------------------------------------------------------*/
/* Initialisation des transaction.                                  */
/*------------------------------------------------------------------*/
ll_ret = idwArticle.SetTransObject ( SQLCA )

/*------------------------------------------------------------------*/
/* Partage des données.                                             */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//le partage des données est dépacé après le partage des données des child
//ll_ret = idwArticle.ShareData ( idwArticlePrs )
//ll_ret = idwCmdTypFrn.ShareData ( idwFourn  )
//ll_ret = idwCmdTypArt.ShareData ( idwTypArt )
//Fin Migration PB8-WYNIWYG-03/2006 FM

This. Uf_Initialiser2 ()

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/* Initialisation des colonnes dont la couleur va changer en        */
/* fonction du type de produit.                                     */
/*------------------------------------------------------------------*/
// [HP252_276_HUB_PRESTA]
If F_CLE_A_TRUE ( "HP252_276_HUB_PRESTA" ) Then
	idwCmde.uf_InitialiserCouleur		 	&
		( {	"DTE_RDV_CLI"				,	&
				"HRDV_CLI_MIN"				,	&
				"HRDV_CLI_MAX"				,	&
				"ID_CHOIX_HORAIRE"		,	&
				"COD_MODE_REG"				,  &
				"RIB_BQ"						,  &
				"RIB_GUI"					,  &
				"RIB_CPT"					,  &
				"RIB_CLE" 					,	&
				"ADR_COD_CIV" 				, 	&
				"ADR_NOM"					,  &
				"ADR_PRENOM"				,	&
				"ADR_LIVR1"					,  &
				"ADR_LIVR2"					,  &
				"ADR_LIVR_CPL"				,  &
				"ADR_CP"						,  &
				"ADR_VILLE"						&
			} )
Else 
	idwCmde.uf_InitialiserCouleur		 	&
		( {	"DTE_RDV_CLI"				,	&
				"HRDV_CLI_MIN"				,	&
				"HRDV_CLI_MAX"				,	&
				"ID_CHOIX_HORAIRE"		,	&
				"COD_MODE_REG"				,  &
				"RIB_BQ"						,  &
				"RIB_GUI"					,  &
				"RIB_CPT"					,  &
				"RIB_CLE" 						&
			} )
End If 
		
/*------------------------------------------------------------------*/
/* Positionnement de la DDDW sur ID_CHOIX_HORAIRE.                  */
/*------------------------------------------------------------------*/
ll_ret = idwCmde.GetChild ( "ID_CHOIX_HORAIRE", dwChild1 )
ll_ret = idw_HoraireRdv.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* CAG # Modification SFR # Le 09/09/2002.                          */
/*------------------------------------------------------------------*/
ll_ret = idwWSin.GetChild ( "COD_CIV", dwChild )
ll_ret = idwCmde.GetChild ( "ADR_COD_CIV", dwChild1)
ll_ret = dwChild.ShareData ( dwChild1 )
ll_ret = idwCmde.GetChild ( "ADRFC_COD_CIV", dwChild1 )
ll_ret = dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* #1 CAG 16/06/2003                                                */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//Une child n'existe plus, inutile!!
//ll_ret = idwWSin.GetChild ( "MARQ_PORT", dwChild )
//ll_ret = idwArticlePrs.GetChild ( "ID_MARQ_ART", dwChild1 )
//ll_ret = dwChild.ShareData ( dwChild1 )
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Insertion d'une nouvelle dans dw des fourn.                      */
/*------------------------------------------------------------------*/

/* #3 Mise en commentaire

lRow = idwFourn.InsertRow (1)
idwFourn.SetItem ( lRow, "ID_PROD", idwWsin.GetItemNumber ( 1, "ID_PROD" ) )
idwFourn.SetItem ( lRow, "ID_GTI", 0 )
idwFourn.SetItem ( lRow, "ID_CODE_FRN", "TOUS FOURNISSEURS" )
idwFourn.SetItem ( lRow, "ID_CODE_ART", "-1" )
idwFourn.SetItem ( lRow, "ALT_CODE_DEF", "O" )
idwFourn.SetItem ( lRow, "NBRE", 0 )
idwFourn.SetItem ( lRow, "ROWSELECT", "N" )
idwFourn.SetItem ( lRow, "ID_TYP_CODE", "-XX" )
idwFourn.SetItem ( lRow, "ID_CODE", -1 )

*/

/*------------------------------------------------------------------*/
/* Initialisation de l'objet Pilote Equiv. Fct.                     */
/*------------------------------------------------------------------*/
iuoEqvFct.uf_initialiser( idwStkIFR, idwcodeEquiv )

end subroutine

public subroutine uf_zn_cocher_equiv_fct ();//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande3::uf_Zn_Cocher_Equiv_Fc (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 25/10/2004 10:51:52
//* Libellé       : Une équivalence vient d'être coché, on déclenche donc le trt associé.
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF	  06/02/2006  [SITE_CMDE] Gestion des nouvelles option d'autorisation 79, 80, 81
//* #2    JFF    24/06/2008  [20060824].[DMDI23202].BUG
//*       JFF    18/10/2011  [PC505].[POINT37]
//			JFF/FPI 16/08/2012	[PC801] Mantis 4492
//*-----------------------------------------------------------------

Long 	lRow, lTotIfr, lTotFrn, lCptIfr, lRowFrn, lCptFrn, lTotFour, lCptfour, lTotTypArt, lCptTypArt, lRowCtrl
String	sMarqIfr, sModlIfr, sFiltreOrig, sFiltre, sIdFour, sIdTypArt
String   sIdGti // #1

/*------------------------------------------------------------------*/
/* On place le curseur sur "TOUS FOURNISSEUR" qui doit se trouver   */
/* sur la 1ère. Dans tous les cas, si l'on est entré dans cette     */
/* fenêtre, c'est qu'il y a au moins une ligne.                     */
/*------------------------------------------------------------------*/
idwFourn.SetRow (1)
idwFourn.ScrollToRow (1)

sIdGti = String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) ) // #1

lTotFour = idwFourn.RowCount ()
For lCptFour = 1 To lTotFour
	idwFourn.SetItem ( lCptFour, "NBRE", 0 )
Next

This.uf_RowFocusChanged ( "DWFOURN" )

/*------------------------------------------------------------------*/
/* Et sur au moins un type d'article 'TEL'...                       */
/*------------------------------------------------------------------*/

// #1
// lRow = idwTypArt.Find ( "ID_CODE_ART = 'TEL'", 1, idwTypArt.RowCount ())
lRow = idwTypArt.Find ( "ID_GTI = " + sIdGti + " AND ID_CODE_ART = 'TEL'", 1, idwTypArt.RowCount ()) // #1

If lRow > 0 Then
	idwTypArt.SetRow ( lRow )
	This.uf_RowFocusChanged ( "DWTYPART" )
End If

lTotTypArt = idwTypArt.RowCount ()
For lCptTypArt = 1 To lTotTypArt 
	idwTypArt.SetItem ( lCptTypArt, "NBRE", 0 )
Next

/*------------------------------------------------------------------*/
/* Modification temporaire du filtre des articles.                  */
/*------------------------------------------------------------------*/
idwArticle.SetRedraw ( FALSE )
sFiltreOrig = idwArticle.Describe ("DataWindow.Table.filter") 
If sFiltreOrig = "?" Then sFiltreOrig = ""

sFiltre = sFiltreOrig 
sFiltre = Left ( sFiltre, Pos ( sFiltre, "AND ALT_VISIBLE = 'O'", 1 ) - 1 )

idwArticle.SetFilter ( sFiltre )
idwArticle.Filter ( )

/*------------------------------------------------------------------*/
/* Nbre d'équivalence.                                              */
/*------------------------------------------------------------------*/
lTotIfr = iuoEqvFct.dw_Trt_Consult.RowCount ()
lTotFrn = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Pour Chaque équivalence, remise à ALT_VISIBLE à N					  */
/*------------------------------------------------------------------*/
iuoEqvFct.Uf_Set_AltVisible ( -1, "N", 0 )

/*------------------------------------------------------------------*/
/* Pour Chaque Fournisseur, remise à ALT_VISIBLE à N					  */
/*------------------------------------------------------------------*/
For lCptFrn = 1 To lTotFrn
	idwArticle.SetItem ( lCptFrn, "ALT_VISIBLE", "N" )
	idwArticle.SetItem ( lCptFrn, "CHOIX", "N" )
Next

/*------------------------------------------------------------------*/
/* Pour Chaque équivalence...                                       */
/*------------------------------------------------------------------*/
For lCptIfr = 1 To lTotIfr

	sMarqIfr = Trim ( Upper ( iuoEqvFct.dw_Trt_Consult.GetItemString ( lCptIfr, "MARQUE" ) ) )
	sModlIfr = Trim ( Upper ( iuoEqvFct.dw_Trt_Consult.GetItemString ( lCptIfr, "REFERENCE" ) ) )

/*------------------------------------------------------------------*/
/* Recherche et croisement avec la table article.	                  */
/*------------------------------------------------------------------*/
	lRowFrn = idwArticle.Find ( "ID_MARQ_IFR = '" + sMarqIfr + "' AND ID_MODL_IFR = '" + sModlIfr + "'", 1, lTotFrn )

	If lRowFrn > 0 Then
		sIdFour= idwArticle.GetItemString ( lRowFrn, "ID_FOUR" ) // #1
		sIdTypArt= idwArticle.GetItemString ( lRowFrn, "ID_TYP_ART" ) // #1

		//* #2 [20060824].[DMDI23202].BUG
//		lRowCtrl = idwFourn.Find ( "ID_GTI = " + sIdGti + " AND ID_CODE_FRN = '" + sIdFour + "' AND ID_CODE_ART = '" + sIdTypArt + "'", 1, idwFourn.RowCount ()) // #1
		lRowCtrl = idwTypArt.Find ( "ID_GTI = " + sIdGti + " AND ID_CODE_FRN = '" + sIdFour + "' AND ID_CODE_ART = '" + sIdTypArt + "'", 1, idwTypArt.RowCount ()) // #1
		//* :#2 [20060824].[DMDI23202].BUG
		
		If lRowCtrl > 0  Then // #1
			idwArticle.SetItem ( lRowFrn, "ALT_VISIBLE", "O" )
			iuoEqvFct.Uf_Set_AltVisible ( lCptIfr, "O", lrowFrn )
		End If
	End If		

Next

/*-------------------------------------------------------------------------*/
/* #1..Dans tous les cas, on affiche s'il est paramètré, l'article WBA/TEL */
/*-------------------------------------------------------------------------*/
lRowFrn = idwFourn.Find ( "ID_GTI = " + sIdGti + " AND LEFT ( ID_CODE_FRN, 2 ) = 'WB'", 1, idwFourn.RowCount ()) // #1
If lRowFrn > 0 Then
	lRowFrn = idwArticle.Find ( "ID_REF_FOUR = 'TEL_VIRTUEL_SPB_WEB'", 1, lTotFrn )
	If lRowFrn > 0 Then 
		idwArticle.SetItem ( lRowFrn, "ALT_VISIBLE", "O" )
	End If
End If		


// [PC801]
lRowFrn = idwFourn.Find ( "ID_GTI = " + sIdGti + " AND LEFT ( ID_CODE_ART, 3 ) = 'CAF'", 1, idwFourn.RowCount ()) // #1
If lRowFrn > 0 Then
	lRowFrn = idwArticle.Find ( "ID_TYP_ART = 'CAF'", 1, idwArticle.Rowcount ())			
	If lRowFrn > 0 Then 
		idwArticle.SetItem ( lRowFrn, "ALT_VISIBLE", "O" )
	End If
End If
// :[PC801]


/*------------------------------------------------------------------*/
/* Filtre dw_Article.                                               */
/*------------------------------------------------------------------*/
idwArticle.SetFilter ( sFiltreOrig )
idwArticle.Filter ( )
idwArticle.Sort ()
idwArticle.SetRedraw ( TRUE )

iuoEqvFct.BringtoTop = TRUE

iuoEqvFct.uf_filtrerDwRech ()
iuoEqvFct.uf_Activer_AffREch ( TRUE )


end subroutine

private subroutine uf_correspondance_ifr_frn ();//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commade3::uf_Correspondance_Ifr_Frn (Private)
//* Auteur        : Fabry JF
//* Date          : 27/12/2004 14:53:49
//* Libellé       : Gestion de l'existance d'au un moins mobile équivalent chez nos Frn.
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF	09/06/2008    [DCMP070798]
//        JFF  17/05/2016 	  [PM280-2]
//*-----------------------------------------------------------------
/*------------------------------------------------------------------*/
/* Nouvelle règle de gestion pour l'équivalence :         			  */
/*        Si, parmi les mobiles disponibles chez nos fournisseurs,  */
/* aucun de ces mobiles n'a un prix public IFR inférieur ou égal    */
/* au prix public IFR du                                            */
/*        mobile sinistré, alors :                                  */
/* 	Selon un nouveau paramètre par code produit sinistre :        */
/* 	a/ On déconnecte le système d'équivalence, et l'on propose    */
/* systématiquement les 3 mobiles les moins chers en fonction du    */
/* prix TTC fournisseurs.                                           */
/* 	b/ Sinon on averti simplement le gestionnaire que le système  */
/* d'équivalence est déconnectée et qu'il doit prendre contact      */
/* avec un RU.                                                      */
/*                                                                  */
/*------------------------------------------------------------------*/

Decimal {2} dcMtPrixIfrMobSin 
String sFiltreOrig, sTriOrig, sFiltre, sMarq, sModl
Long ltot, lCpt, lDeb, lFin, lIdEvt
Boolean bChoixMob

lIdEvt = idwDetail.GetItemNumber ( 1, "ID_EVT" ) // [PM200][LOT2][DESOX]


//* #1 [DCMP070798] Ajout PC2
Choose Case isTypApp 
	Case "TEL", "PC2"
		// Ok pour Traitement
	Case  Else
		Return
End Choose


/*------------------------------------------------------------------*/
/* Doit-on déconnecter la recherche par équivalence fonctionnelle   */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 24 )
If lDeb > 0 Then Return

/*------------------------------------------------------------------*/
/* Le mobile exise peut-être chez le fournisseur.                   */
/*------------------------------------------------------------------*/
If isMobileUnique <> "" Then Return

dcMtPrixIfrMobSin = iuoEqvFct.uf_Get_Frequence_Sinistre ()

If dcMtPrixIfrMobSin = -1 Then Return

/*------------------------------------------------------------------*/
/* Recherche si au moins 1 mobile présent chez nos fournisseurs a   */
/* un prix IFR inférieur ou égal au prix IFR du mobile sinistré.    */
/*------------------------------------------------------------------*/
idwArticle.SetRedraw ( FALSE )

/*------------------------------------------------------------------*/
/* On sauve le filtre original.                                     */
/*------------------------------------------------------------------*/
sFiltreOrig = idwArticle.Describe ("DataWindow.Table.filter") 
If sFiltreOrig = "?" Then sFiltreOrig = ""

sTriOrig = idwArticle.Describe ("DataWindow.Table.sort") 
If sTriOrig = "?" Then sTriOrig = ""

sFiltre = "MT_PRIX_IFR <= " + String ( dcMtPrixIfrMobSin )

idwArticle.SetFilter ( sFiltre )
idwArticle.Filter ( )
lTot = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Si lTot = 0, c'est qu'aucun mobile ne pourra être proposé        */
/* quelque soit la rech par EQF que l'on pourra faire.              */
/* Si lTot > 0 On sort alors , puisque l'EQF peut au moins ramener 1*/
/* mobile																			  */
/*------------------------------------------------------------------*/
If lTot > 0 Then 
	idwArticle.SetFilter ( sFiltreOrig )
	idwArticle.Filter ( )
	idwArticle.SetSort ( sTriOrig )
	idwArticle.Sort ( )

	idwArticle.SetRedraw ( TRUE )

	Return
End If

/*------------------------------------------------------------------*/
/* Option 27 : Si Aucun mob correspond ET Opt 27 trouvé alors alors */
/* Proposition de 3 mobiles les moins cher chez nos Frn				  */
/* si Opt 27 non trouvé, alors message information gestion.			  */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 27 )
bChoixMob = lDeb > 0 

If Not bChoixMob Then
	isMobileUnique += " AND ( UPPER ( ID_MARQ_IFR ) = 'XXX' AND UPPER ( ID_MODL_IFR ) = 'XXX' ) " 

	stMessage.sTitre		= "Aucune équivalence"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "COMD100"
	F_Message ( stMessage )
End If

/*------------------------------------------------------------------*/
/* Sinon Propo de 3 mobiles de trois mobiles.                       */
/*------------------------------------------------------------------*/
If bChoixMob Then

	sFiltre = sFiltreOrig 
	sFiltre = Replace ( sFiltre, Pos ( sFiltre, "AND ALT_VISIBLE = 'O'", 1 ), 21, "" )

	idwArticle.SetFilter ( sFiltre )
	idwArticle.Filter ( )
	idwArticle.SetSort ( "MT_PRIX_TTC A" )
	idwArticle.Sort ( )

	lTot = 3  // Traitement de Trois mobile maxi
	If idwArticle.Rowcount ( ) < lTot Then lTot = idwArticle.Rowcount ( ) 
	isMobileUnique = "" 

	For lCpt = 1 To lTot
		sMarq = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MARQ_IFR" ) ) )
		sModl = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MODL_IFR" ) ) )

		idwArticle.SetItem ( lCpt, "ALT_VISIBLE", "O" )
		isMobileUnique += " ( UPPER ( ID_MARQ_IFR ) = '" + Upper ( sMarq ) + "' AND UPPER ( ID_MODL_IFR ) = '" + Upper ( sModl ) + "' ) " 
		If lCpt < lTot Then isMobileUnique +=" OR "
		If lCpt = lTot Then isMobileUnique = " AND ( " + isMobileUnique + " ) "
	Next	
End If

/*------------------------------------------------------------------*/
/* Initialisation de l'objet Pilote Equiv. Fct.                     */
/* On initialise au format R pour déactiver la recherche d'eq. Fct  */
/*------------------------------------------------------------------*/
iuoEqvFct.uf_Filtrer_Init ()

// [PM280-2]
If lIdEvt <> 1426 Then
	iuoEqvFct.uf_preparer( "R", isMarqPortAdh, isModlPortAdh, idwDetail.GetItemDecimal ( 1, "MT_VAL_ACHAT" ) )				
End If 

idwArticle.SetFilter ( sFiltreOrig )
idwArticle.Filter ( )
idwArticle.SetSort ( sTriOrig )
idwArticle.Sort ( )

idwArticle.SetRedraw ( TRUE )


end subroutine

private function string uf_controlergestion_darty_tel (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_Darty_Tel (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 17/11/2003
//* Libellé			: Controler Spécifique pour DARTY
//* Commentaires	: La zone problème pour DARTY doit au moins contenir un chiffre.
//*					  Ce chiffre est fixé par la machine pour l'ordre du choix.
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

String sPos, sProbleme
Long lDeb, lFin

sPos = ""

/*------------------------------------------------------------------*/
/* Si nous ne sommes pas en gestion DARTY TEL , on ressort.         */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 11 )
If lDeb <= 0 Then Return sPos

If Upper ( idwArticle.GetItemString ( alCpt, "ID_TYP_ART" ) ) <> "TEL" Then
	Return sPos
End If 

sProbleme = idwArticle.GetItemString ( alCpt, "PROBLEME" )

If Not IsNumber ( sProbleme ) Or sProbleme = "" Or IsNull ( sProbleme ) Then
		stMessage.sCode = "COMD065"
		F_Message ( stMessage )
		Return "G" + "PROBLEME"
End If

Return sPos

end function

private function string uf_controlergestion_darty_nomade (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_Darty_Nomade (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 17/11/2003
//* Libellé			: Controler Spécifique pour DARTY NOMADE
//* Commentaires	: 
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1   JFF    01/10/2007   [DCMP070689] complèment Darty Swap&DartyMP
//* #2   JFF    28/01/2008  [DCMP080028]
//       JFF   08/02/2016 [PC151522]
//*-----------------------------------------------------------------

String sPos, sProbleme, sIdFour, sIdTypArt, sIdMarqArt, sRech, sIdGti
Long lDeb, lFin, lRow, lTotRow
Boolean bErr, bDartySwap, bDartyMP
n_cst_string lnvPFCString

sPos = ""
bErr = False

lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, idwWDivSin.RowCount () )

If lRow <= 0 Then Return "G" + "PROBLEME"

sIdFour = idwArticle.GetItemString ( alCpt, "ID_FOUR" )
sIdTypArt = idwArticle.GetItemString ( alCpt, "ID_TYP_ART" )
sIdMarqArt = idwArticle.GetItemString ( alCpt, "ID_MARQ_ART" )
sIdGti  = String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) )
lTotRow = idwFourn.RowCount ()

stMessage.sTitre		= "DARTY Nomade"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= Ok!


/*------------------------------------------------------------------*/
/* Si nous ne sommes pas en gestion DARTY NOMADE , on ressort.      */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 31 )
If lDeb <= 0 Then Return sPos

// [PC151522]
If lDeb > 0 Then
	If lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR"), "OPT_31_ASSOUPLIE", ";") = "OUI" Then
		Return sPos
	End If
End If



F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 90 )
bDartySwap = lDeb > 0 

// #2
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 91 )
bDartyMP = lDeb > 0 

Choose Case isCasGestionDartyNomade 

	Case "11/NPCP/>300/PRS_DST_ANN/CMD_DTY"

		Choose Case sIdFour
			Case "DTY"
				// Ok c'est le bon fournisseur
				bErr = False

			Case Else
				// Ce n'est pas le bon fournisseur, mais si le bon fournisseur
				// n'est pas paramètré alors, on n'affiche pas de message d'erreur

				// Ajouter des 'OR' dans les parenthèses si besoin d'autres Frns
				sRech =  "ID_GTI = " + sIdGti + " AND " + &
							" ( ID_CODE_FRN = 'DTY' )" + &           
							" AND ID_CODE_ART <> 'PRS'"
				lRow = idwFourn.Find ( sRech, 1, lTotRow )

				// Le bon fournisseur est paramètré, on affiche donc le message d'erreur
				If lRow > 0 Then
					bErr = True
					stMessage.sCode = "COMD131"
				End IF
		End Choose	

// #2
	Case "11/NPCP/PROPO/>300/DST_ANN/CMD_DTY"

		Choose Case sIdFour
			Case "DTY"
				// Ok c'est le bon fournisseur
				bErr = False

			Case Else
				// Ce n'est pas le bon fournisseur, mais si le bon fournisseur
				// n'est pas paramètré alors, on n'affiche pas de message d'erreur

				// Ajouter des 'OR' dans les parenthèses si besoin d'autres Frns
				sRech =  "ID_GTI = " + sIdGti + " AND " + &
							" ( ID_CODE_FRN = 'DTY' )" + &           
							" AND ID_CODE_ART <> 'PRS'"
				lRow = idwFourn.Find ( sRech, 1, lTotRow )

				// Le bon fournisseur est paramètré, on affiche donc le message d'erreur
				If lRow > 0 Then
					bErr = True
					stMessage.sCode = "COMD133"
				End IF
		End Choose	
// :#2


	Case "11/PCP/PRS_DTY"

		Choose Case sIdFour
			Case "DTY"
				// Ok c'est le bon fournisseur
				bErr = False
				If Not ibMesInfoAff Then
					stMessage.sCode		= "COMD260"
					F_Message ( stMessage )
					ibMesInfoAff = TRUE
				End If

			Case Else
				// Ce n'est pas le bon fournisseur, mais si le bon fournisseur
				// n'est pas paramètré alors, on n'affiche pas de message d'erreur

				// Ajouter des 'OR' dans les parenthèses si besoin d'autres Frns
				sRech =  "ID_GTI = " + sIdGti + " AND " + &
							" ( ID_CODE_FRN = 'DTY' )" + &           
							" AND ID_CODE_ART = 'PRS'"
				lRow = idwFourn.Find ( sRech, 1, lTotRow )

				// Le bon fournisseur est paramètré, on affiche donc le message d'erreur
				If lRow > 0 Then
					bErr = True
					stMessage.sCode = "COMD140"
				End IF
		End Choose	

	Case "11/NPCP/>300/PRS_DST"

		Choose Case sIdFour

			Case "DST"
				// Ok c'est le bon fournisseur
				bErr = False
				If Not ibMesInfoAff Then
					stMessage.sCode		= "COMD250"
					F_Message ( stMessage )
					ibMesInfoAff = TRUE
				End If

			Case Else
				// Ce n'est pas le bon fournisseur, mais si le bon fournisseur
				// n'est pas paramètré alors, on n'affiche pas de message d'erreur

				// Ajouter des 'OR' dans les parenthèses si besoin d'autres Frns
				sRech =  "ID_GTI = " + sIdGti + " AND " + &
							" ( ID_CODE_FRN = 'DST' )" + &           
							" AND ID_CODE_ART = 'PRS'"
				lRow = idwFourn.Find ( sRech, 1, lTotRow )

				// Le bon fournisseur est paramètré, on affiche donc le message d'erreur
				If lRow > 0 Then
					bErr = True
					stMessage.sCode = "COMD130"
				End IF
		End Choose

	Case "11/NPCP/<=300/CMD_DTY"

		Choose Case sIdFour
			Case "DTY"
				// Ok c'est le bon fournisseur
				bErr = False

			Case Else
				// Ce n'est pas le bon fournisseur, mais si le bon fournisseur
				// n'est pas paramètré alors, on n'affiche pas de message d'erreur

				// Ajouter des 'OR' dans les parenthèses si besoin d'autres Frns
				sRech =  "ID_GTI = " + sIdGti + " AND " + &
							" ( ID_CODE_FRN = 'DTY' )" + &           
							" AND ID_CODE_ART <> 'PRS'"
				lRow = idwFourn.Find ( sRech, 1, lTotRow )

				// Le bon fournisseur est paramètré, on affiche donc le message d'erreur
				If lRow > 0 Then
					bErr = True

					// #2
					If bDartySwap Then 
						stMessage.sCode = "COMD142"
					ElseIf isMarqPortAdh = "CREATIVE" Then
						stMessage.sCode = "COMD121"
					Else	
						stMessage.sCode = "COMD120"
					End If
					// :#2
					
				End IF
		End Choose	

// #2
	Case "11/NPCP/PROPO/<=300/CMD_DTY"

		Choose Case sIdFour
			Case "DTY"
				// Ok c'est le bon fournisseur
				bErr = False

			Case Else
				// Ce n'est pas le bon fournisseur, mais si le bon fournisseur
				// n'est pas paramètré alors, on n'affiche pas de message d'erreur

				// Ajouter des 'OR' dans les parenthèses si besoin d'autres Frns
				sRech =  "ID_GTI = " + sIdGti + " AND " + &
							" ( ID_CODE_FRN = 'DTY' )" + &           
							" AND ID_CODE_ART <> 'PRS'"
				lRow = idwFourn.Find ( sRech, 1, lTotRow )

				// Le bon fournisseur est paramètré, on affiche donc le message d'erreur
				If lRow > 0 Then
					bErr = True

					// #2
					If bDartySwap Then 
						stMessage.sCode = "COMD143"
					ElseIf isMarqPortAdh = "CREATIVE" Then
						stMessage.sCode = "COMD122"
					Else	
						stMessage.sCode = "COMD124"
					End If
					// #2
					
				End IF
		End Choose	



// #1
	Case "10/PCP/CMD_DTY", "11/PCP/CMD_DTY"

		Choose Case sIdFour
			Case "DTY"
				// Ok c'est le bon fournisseur
				bErr = False
			
				If sIdTypArt <> "PCP" Then 
					bErr = True
					
					// #1
					If isCasGestionDartyNomade = "10/PCP/CMD_DTY" Then
						stMessage.sCode = "COMD150"
					ElseIf isCasGestionDartyNomade = "11/PCP/CMD_DTY" Then
						stMessage.sCode = "COMD151"
					End IF
				End If

				If Not bErr Then
					sProbleme = idwArticle.GetItemString ( alCpt, "PROBLEME" )

					If Not IsNumber ( sProbleme ) Or sProbleme = "" Or IsNull ( sProbleme ) Then
						bErr = True
						stMessage.sCode = "COMD240"
					End If

				End If

			Case Else
				// Ce n'est pas le bon fournisseur, mais si le bon fournisseur
				// n'est pas paramètré alors, on n'affiche pas de message d'erreur

				// Ajouter des 'OR' dans les parenthèses si besoin d'autres Frns
				sRech =  "ID_GTI = " + sIdGti + " AND " + &
							" ( ID_CODE_FRN = 'DTY' )" + &           
							" AND ID_CODE_ART <> 'PRS'"
				lRow = idwFourn.Find ( sRech, 1, lTotRow )

				// Le bon fournisseur est paramètré, on affiche donc le message d'erreur
				If lRow > 0 Then
					bErr = True
					stMessage.sCode = "COMD150"
				End IF
		End Choose	


	Case "10/NPCP/CMD_DTY"

		Choose Case sIdFour
			Case "DTY"
				// Ok c'est le bon fournisseur
				bErr = False
			
				If sIdTypArt <> "CAF" Then 
					bErr = True
					stMessage.sCode = "COMD160"
				End If

			Case Else
				// Ce n'est pas le bon fournisseur, mais si le bon fournisseur
				// n'est pas paramètré alors, on n'affiche pas de message d'erreur

				// Ajouter des 'OR' dans les parenthèses si besoin d'autres Frns
				sRech =  "ID_GTI = " + sIdGti + " AND " + &
							" ( ID_CODE_FRN = 'DTY' )" + &           
							" AND ID_CODE_ART <> 'PRS'"
				lRow = idwFourn.Find ( sRech, 1, lTotRow )

				// Le bon fournisseur est paramètré, on affiche donc le message d'erreur
				If lRow > 0 Then
					bErr = True
					stMessage.sCode = "COMD160"
				End IF
		End Choose	

// #2
	Case "10/NPCP/PROPO/CMD_DTY"

		Choose Case sIdFour
			Case "DTY"
				// Ok c'est le bon fournisseur
				bErr = False
			
				If sIdTypArt = "CAF" Then 
					bErr = True
					stMessage.sCode = "COMD161"
				End If

			Case Else
				// Ce n'est pas le bon fournisseur, mais si le bon fournisseur
				// n'est pas paramètré alors, on n'affiche pas de message d'erreur

				// Ajouter des 'OR' dans les parenthèses si besoin d'autres Frns
				sRech =  "ID_GTI = " + sIdGti + " AND " + &
							" ( ID_CODE_FRN = 'DTY' )" + &           
							" AND ID_CODE_ART <> 'PRS'"
				lRow = idwFourn.Find ( sRech, 1, lTotRow )

				// Le bon fournisseur est paramètré, on affiche donc le message d'erreur
				If lRow > 0 Then
					bErr = True
					stMessage.sCode = "COMD161"
				End IF
		End Choose	
// :#2

End Choose

If bErr Then
	F_Message ( stMessage )
	Return "G" + "PROBLEME"
End If

Return sPos

end function

public function string uf_controlergestionedi ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestionEDI (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 19/07/2005
//* Libellé			: 
//* Commentaires	: Controle de Gestion pour les EDI
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 PHG	 10/12/2007	  [O2M] Controle de Gestion EDI pour O2M
//* #2 	 JFF	 20/10/2008	  [FNAC_PROD_ECH_TECH]
//* #3    JFF   06/08/2009   [O2M_DIAG_NOMADE].[JFF].[20090806170657743]
//* #4    JFF   02/09/2009   [DCMP090327].[SBETV]
//* #5    JFF   09/09/2009   [O2M_DIAG_NOMADE].[JFF].[20090909105840793]
//* #6    JFF   25/11/2009   [MSS_DIAG]
//*       JFF   30/06/2010   [PC363_AUCHAN]
//*       JFF   05/07/2011   [PC292][AUCHAN]
//*       JFF   12/09/2011   [PC292][AUCHAN]
//*       FPI   09/11/2011   [VDoc5944]
//        JFF   01/03/2012   [CONFO][MEUBLE][PC542]
//        JFF   17/04/2012   [PM200][LOT2][DESOX]
//        JFF   23/05/2012   [PM103][1]
//        JFF   06/08/2012   [BLCODE]
//		    FPI	 12/10/2012	  [PC846/864]
//        JFF   19/02/2013	  [VDOC9304_PM82_LOT1]
//        JFF   09/09/2013   [PM222-1]
//       JFF   30/12/2013 [PC13348&13408]
//		FPI	16/05/2014  [VDOC14351]
//       JFF   02/10/2014 [VDOC15485]
//    JFF   21/11/2014 [VDOC16011]
//       JFF   09/04/2015 [DT141]
//       JFF    02/07/2015 [UNE_PRESTA_PAR_DETAI]
//       JFF    29/10/2015 [VDOC18993]
//       JFF   29/02/2016 [DT191-1]
//       JFF   26/04/2016 [DT207][DT208]
//       JFF   03/05/2016 [DT209][MANTIS20581]
//       JFF   19/05/2016 [DT209][MANTIS20750][MANTIS20756]
//       JFF   17/05/2016 [PM280-2]
//			JFF	25/08/2017 [REF_A_REEXP_PICK_UP]
//       JFF   17/04/2018 [DT288-4]
//       JFF   21/11/2018 [VDOC27123]
//       JFF   26/11/2018 [PC874_2_V1]
//       JFF   20/06/2022 [RS3220_MODDEGR_TELST]
//       JFF   07/03/2024 [HP252_276_HUB_PRESTA]
//*-----------------------------------------------------------------

Int					iRet
String				sIdFour, sVal, sVal1, sPos, sDw, sNouvCmde, sMarq, sModl, sFind, sNull, sIdRefFour
String				sIdMarqArt, sIdTypArt, sIdFourModif, sRech, sIdGti, sPasseDroit, sFiltreOrig , sSortOrig
Date					dDate1, dDate2
Long					lTot, lCpt, lRow, lDeb, lFin, lTotRow, lRow1, lCpt2, lRow2, lRow3, lRow4
Long lIdEvt, lIdGti, lIdDetail
Decimal {2} dcMtValAchat 
DataWindowChild	dwChild
n_cst_attrib_key	lnv_Key[] 			
n_cst_string lnv_String
DateTime dtMajLe, dtCreeLeDos, dtVal 

idwArticle.SetRedraw(FALSE)

iRet = 1
sPos = ""
sDw  = ""
sPasseDroit = ""

stMessage.sTitre  	= "Controle de gestion"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= Ok!

//* #2 [FNAC_PROD_ECH_TECH]
sIdGti  = String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) )
lTotRow = idwFourn.RowCount ()
//* /#2 [FNAC_PROD_ECH_TECH]

lIdEvt = idwDetail.GetItemNumber ( 1, "ID_EVT" ) // [PM200][LOT2][DESOX]
lIdGti = idwDetail.GetItemNumber ( 1, "ID_GTI" ) 
lIdDetail = idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) 
dcMtValAchat = idwDetail.GetItemDecimal ( 1, "MT_VAL_ACHAT" ) 

/*------------------------------------------------------------------*/
/* Contrôle Général.                                                */
/*------------------------------------------------------------------*/
If idwBandeau.Rowcount ( ) > 0 Then

	sNouvCmde = Left ( idwBandeau.GetItemString ( 1, "NOUV_CMDE" ), 2 ) 

	sDw = "G"

	If IsNumber ( sNouvCmde ) Then
		If Integer ( sNouvCmde ) > 1 Then
			
			// [PC292][AUCHAN]
			idwArticle.SetRedraw (False)
			sFiltreOrig = idwArticle.Describe ("DataWindow.Table.filter") 
			If sFiltreOrig = "?" Then sFiltreOrig = ""
			sSortOrig = idwArticle.Describe ("DataWindow.Table.Sort") 
			If sSortOrig = "?" Then sSortOrig = ""

			idwArticle.SetFilter ( "" )
			idwArticle.Filter ()
			idwArticle.SetSort ( sSortOrig )
			idwArticle.Sort ()
			// :[PC292][AUCHAN]

			// [PC363_AUCHAN]
			If Integer ( sNouvCmde ) = 2 And ( &
					( idwArticle.Find("CHOIX='O' AND ID_REF_FOUR = 'DECISION_SPB' AND INFO_SPB_FRN IN ( 970, 971)", 1, idwArticle.RowCount()+1 ) > 0 And &
					idwArticle.Find("CHOIX='O' AND ID_REF_FOUR = 'PEC_A_RECYCLER'", 1, idwArticle.RowCount()+1 ) > 0 ) Or &
					( idwArticle.Find("CHOIX='O' AND ID_REF_FOUR = 'DECISION_SPB' AND INFO_SPB_FRN = 971", 1, idwArticle.RowCount()+1 ) > 0 And &
					idwArticle.Find("CHOIX='O' AND ID_REF_FOUR = 'REFUSE_A_REEXP'", 1, idwArticle.RowCount()+1 ) > 0 ) &
					) Then
				
				// On laisse passer ce cas sinon, redirection sur le ELSE
				sPasseDroit = "#SB1#O2M#"
				
			Else
				
				// [O2M] : Détermination du message a afficher au cas ou plusieurs commandes sont cochées.
				lCpt = idwArticle.Find("CHOIX='O'", 1, idwArticle.RowCount()+1 )
				if lCpt > 0 then sIdFour = upper(string(idwArticle.object.id_four[lCpt]))
							
				// #1 JFF [FNAC_PROD_ECH_TECH]	
				Choose Case sIdFour
					Case "CDS"
						stMessage.sCode		= "COMD423"
					Case Else
						stMessage.sCode		= "COMD462" 
				End choose
				// :#1 JFF [FNAC_PROD_ECH_TECH]	
	
				stMessage.sTitre		= "Commandes"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= Ok!
	
				idwArticle.SetRedraw(TRUE)
				F_Message ( stMessage )
				Return sDw + "DTE_RDV_CLI"
			End If
			
			// [PC292][AUCHAN]
			idwArticle.SetFilter ( sFiltreOrig  )
			idwArticle.Filter ()
			idwArticle.SetSort ( sSortOrig  )
			idwArticle.Sort ()
			idwArticle.SetRedraw (True)
			// :[PC292][AUCHAN]
			
		End If			
	End If
End If

// [PC846/864]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 224 )
If lDeb > 0 Then sPasseDroit="#BLC#SCR#"
// :[PC846/864]

/*------------------------------------------------------------------*/
/* Filtre sur toutes les prestations choisies                       */
/*------------------------------------------------------------------*/
idwArticle.SetFilter ( "CHOIX = 'O'" )
idwArticle.Filter ( )

lTot = idwArticle.RowCount ()

ibMesInfoAff = FALSE



// #4 [DCMP090327].[SBETV] Code de remplacement
If lTot > 0 Then
	lCpt = 1
	sIdFour = idwArticle.GetItemString ( lCpt, "ID_FOUR" )

	// [PM82][LOT1]
	sIdRefFour = idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" )


	//[VDOC18993]
	// [DT207][DT208]
	// [PM280-2] lIdEvt <> 1426 &
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 180 )
	If lDeb > 0 Then
		For lCpt2 = lDeb To lFin
			If idw_DetPro.GetItemNumber ( lCpt2, "VAL_NUM" ) = lIdGti Then
				sVal = lnv_String.of_getkeyvalue (idw_DetPro.GetItemString ( lCpt2, "VAL_CAR" ), "ID_REF_FOUR", ";")

				If Pos ( sVal, "#" + Upper ( sIdRefFour ) + "#") > 0 And &
				lIdEvt <> 1426 And &
				( lnv_String.of_getkeyvalue (idw_DetPro.GetItemString ( lCpt2, "VAL_CAR" ), "OK_SI_INF_FORFAIT", ";") <> "OUI" &
				  Or &
				  ( lnv_String.of_getkeyvalue (idw_DetPro.GetItemString ( lCpt2, "VAL_CAR" ), "OK_SI_INF_FORFAIT", ";") = "OUI" And & 
					 idcMtPec > idcMtForfait &
				  ) &
				) &
				Then
					stMessage.sCode = "COMD927"
					idwArticle.SetRedraw(TRUE)
					F_Message ( stMessage )
					Return sDw + "DTE_RDV_CLI"					
				End If
				Exit
			End If 
		Next
	End If
	
	// [PM200][LOT2][DESOX]
	Choose Case sIdRefFour 
		Case "A_REPARER_FORCE"
			
			// [PM222-1]
			lRow = idwCmdeSin.Find ( "( ID_REF_FOUR IN ( 'A_REPARER' ) OR POS ( INFO_SPB_FRN_CPLT, 'A_REPARER_SAV=OUI') > 0 OR POS ( INFO_SPB_FRN_CPLT, 'A_CONTROLER_SAV=OUI') > 0) AND COD_ETAT NOT IN ( 'RFO', 'RPC', 'ANN') AND STATUS_GC IN ( 153, 154 )", 1, idwCmdeSin.Rowcount() ) 
			
			If lRow > 0 Then
				idwArticle.SetItem ( lCpt, "ID_MARQ_ART", isMarqPortAdh ) 
				idwArticle.SetItem ( lCpt, "ID_MODL_ART", isModlPortAdh )
			Else
				stMessage.sCode = "COMD713"
				idwArticle.SetRedraw(TRUE)
				F_Message ( stMessage )
				Return sDw + "DTE_RDV_CLI"
			End If

		// [HP252_276_HUB_PRESTA]
		Case "A_DIAG_FORCE"

			// [PM222-1] // [HP252_276_HUB_PRESTA]
			lRow = idwCmdeSin.Find ( "( ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND POS ( INFO_SPB_FRN_CPLT, 'HP_ID_HUB_PRESTA') > 0) AND COD_ETAT NOT IN ( 'RFO', 'RPC', 'ANN') AND STATUS_GC IN ( 153, 154 )", 1, idwCmdeSin.Rowcount() ) 
				
			If lRow > 0 Then
				idwArticle.SetItem ( lCpt, "ID_MARQ_ART", isMarqPortAdh ) 
				idwArticle.SetItem ( lCpt, "ID_MODL_ART", isModlPortAdh )
			Else
				stMessage.sCode = "COMT004"
				idwArticle.SetRedraw(TRUE)
				F_Message ( stMessage )
				Return sDw + "DTE_RDV_CLI"
			End If



	// [PM200][LOT2][DESOX]
		Case "A_DESOXYDER_FORCE"

			// [PM222-1]
			lRow = idwCmdeSin.Find ( "( ID_REF_FOUR IN ( 'A_DESOXYDER' ) OR POS ( INFO_SPB_FRN_CPLT, 'A_REPARER_SAV=OUI') > 0 OR POS ( INFO_SPB_FRN_CPLT, 'A_DESOXYDER_SAV=OUI') > 0  OR POS ( INFO_SPB_FRN_CPLT, 'A_CONTROLER_SAV=OUI') > 0) AND COD_ETAT NOT IN ( 'RFO', 'RPC', 'ANN') AND STATUS_GC IN ( 153, 154 )", 1, idwCmdeSin.Rowcount() ) 								
			
			If lRow > 0 Then
				idwArticle.SetItem ( lCpt, "ID_MARQ_ART", isMarqPortAdh ) 
				idwArticle.SetItem ( lCpt, "ID_MODL_ART", isModlPortAdh )
			Else
				stMessage.sCode = "COMD714"
				idwArticle.SetRedraw(TRUE)
				F_Message ( stMessage )
				Return sDw + "DTE_RDV_CLI"
			End If

		// [DT209][MANTIS20581]			
		Case "BON_EMARGE"			
				lRow  = idwCmdeSin.Find ( "ID_FOUR = 'SBE' AND COD_ETAT IN ( 'RPC', 'RFO' ) AND STATUS_GC IN ( 2, 178)", 1, idwCmdeSin.RowCount() )									
				
				//	[DT209][MANTIS20750][MANTIS20756]	
				// [VDOC27123]BVID/BVIP/BVIT
				lRow1 = idwCmdeSin.Find ( "ID_FOUR = 'SBE' AND COD_ETAT IN ( 'RPC', 'RFO' ) AND STATUS_GC IN ( 21 )", 1, idwCmdeSin.RowCount() )				
				lRow2 = idwCmdeSin.Find ( "ID_FOUR = 'SBE' AND COD_ETAT IN ( 'RPC', 'RFO' ) AND STATUS_GC IN ( 21 ) AND ( POS ( COMMENT_FRN, '[BVIE]' ) > 0 OR POS ( COMMENT_FRN, '[BVID]' ) > 0 OR POS ( COMMENT_FRN, '[BVIP]' ) > 0 OR POS ( COMMENT_FRN, '[BVIT]' ) > 0 )", 1, idwCmdeSin.RowCount() )
				lRow3 = idwCmdeSin.Find ( "ID_FOUR = 'SBE' AND COD_ETAT IN ( 'RPC', 'RFO' ) AND STATUS_GC IN ( 152 )", 1, idwCmdeSin.RowCount() )
				lRow4 = idwCmdeSin.Find ( "ID_FOUR = 'SBE' AND COD_ETAT IN ( 'RPC', 'RFO' ) AND ID_REF_FOUR = 'REFUSE_A_REEXP'", 1, idwCmdeSin.RowCount() )
				
				If Not ( lRow > 0 Or ( lRow1 > 0 And lRow2 <= 0 And lRow <=0 ) Or ( lRow3 > 0 And lRow4 > 0 ) ) Then
					stMessage.sCode = "COMD942"
					idwArticle.SetRedraw(TRUE)
					F_Message ( stMessage )
					Return sDw + "DTE_RDV_CLI"
				End If

		// [PM280-2]			
		Case "CONTEST_SUR_REMPL"			
				lRow = idwCmdeSin.Find ( &
				"ID_FOUR = 'O2M' AND " + &
				"COD_ETAT <> 'ANN' AND " + &
				"( ID_TYP_ART NOT IN ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' ) " + &
				"  OR " + &
				"  ( ID_TYP_ART = 'RST' AND POS ( INFO_SPB_FRN_CPLT, 'RST_CMDE+SUIVI=OUI' ) > 0 ) " + &
				") " + &
				" AND STATUS_GC NOT IN ( 176, 239, 203 )" &
				, 1, idwCmdeSin.RowCount () ) 
				
				If lRow <= 0 Then
					stMessage.sCode = "COMD944"
					idwArticle.SetRedraw(TRUE)
					F_Message ( stMessage )
					Return sDw + "DTE_RDV_CLI"
				End If


		// [PM445]
		Case "A_REMPLACER", "NE_PAS_REMPLACER"
			
			lRow1 = idwCmdeSin.Find ( "ID_FOUR = 'O2M' AND COD_ETAT NOT IN ( 'RPC', 'RFO', 'ANN' ) AND POS ( INFO_FRN_SPB_CPLT, 'PERTE_ALLER=OUI') > 0", 1, idwCmdeSin.RowCount() )
			
			If lRow1 <= 0 Then
				stMessage.sCode = "COMD996"
				idwArticle.SetRedraw(TRUE)
				F_Message ( stMessage )
				Return sDw + "DTE_RDV_CLI"
			Else 
				sPasseDroit = "#O2M#"
			End If 
	End Choose


	Choose Case sIdFour
		 //#3 [O2M_DIAG_NOMADE].[JFF].[20090806170657743]               

		// #5 [O2M_DIAG_NOMADE].[JFF].[20090909105840793]
		// Case "CDS"   
			// Pas de contrôle
		// #5 :[O2M_DIAG_NOMADE].[JFF].[20090909105840793]
		//:#3 [O2M_DIAG_NOMADE].[JFF].[20090806170657743]
	  
		Case isFournParDefaut
			// Ok c'est le bon fournisseur
		
		Case Else

			// [PC292][AUCHAN]
			If Pos ( sPasseDroit, "#" + sIdFour + "#", 1) > 0 Or &
				( sIdFour = "O2M" And idwCmdeSin.Find ( "ID_FOUR='O2M' AND ID_REF_FOUR='A_DIAGNOSTIQUER' AND STATUS_GC=179", 1, idwCmdeSin.RowCount() ) > 0 )&
				Then
				// On laisse passer
			Else
			
				stMessage.sCode = "COMD552"
				stMessage.sVar [1] = isFournParDefaut 
				stMessage.sVar [2] = sidfour
				idwArticle.SetRedraw(TRUE)
				F_Message ( stMessage )
				Return sDw + "DTE_RDV_CLI"
			End If
			
	End Choose	
End If
// :#4 [DCMP090327].[SBETV]


/*------------------------------------------------------------------*/
/* Contrôle Particulier pour certains fournisseurs.                 */
/*------------------------------------------------------------------*/
CHOOSE CASE Upper ( sIdFour )


	/*------------------------------------------------------------------*/
	/* Fournisseur CDS      	 													  */
	/*------------------------------------------------------------------*/
	CASE "CDS"
		sPos = This.uf_ControlerGestionEDI_CDiscount ( lCpt ) 

	/*------------------------------------------------------------------*/
	/* Fournisseur [O2M] : Controle de Gestion O2M							  */
	/*------------------------------------------------------------------*/
	// BLCODE
	// [PC13348&13408]
	// [DT141] Ajout SBE
	// [DT288-4]
	CASE "O2M", "BLC", "MTT", "SBE", "COR"
		sPos = This.uf_ControlerGestionEDI_O2M ( lCpt ) 

	// #4 [DCMP090327].[SBETV]
	CASE "SB1"
		sPos = This.Uf_ControlerGestionEdi_SBETV ( lCpt )

	// #6 [MSS_DIAG]
	CASE "MS1"
		sPos = This.Uf_ControlerGestionEdi_MSSDIAG ( lCpt )

	// #6 [MSS_DIAG]
	CASE "PSM"
		sPos = This.Uf_ControlerGestionEdi_PSM ( lCpt )

	

END CHOOSE

// [VDoc5944]
If sPos=""  Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 152 )
	If lDeb > 0 And idwDetail.GetItemNumber ( 1, "ID_GTI" ) = 15 Then
		If sIdFour ="CAR" Then // [VDOC14351] Uniquement si remplacement
			stMessage.berreurg=FALSE
			stMessage.bouton=YesNo!
			stMessage.icon=Question!
			stMessage.scode="COMD677"
			stMessage.sTitre="Commandes"
			
			if f_Message(stMessage) = 2 Then
				sPos="DADR_LIVR1"
			End if
		End if
	End if
End if
// :[VDoc5944]

// #4 [DCMP090327].[SBETV]
/*
	If sPos <> "" Then Exit

Next
*/
// :#4 [DCMP090327].[SBETV]

// [PM103][1]
If gbModeReprise_223 Then
	lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "PRESTA_REPRISE_BASE_MANUELLE", "OUI", ";")
End If

// [VDOC16011]
// [VDOC16011]
lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "MT_PEC", String ( idcMtPec, "##0.00" ), ";")		

lRow = idwCmdeSin.Find ( "ID_GTI = " + String ( lIdGti ) + " AND ID_DETAIL = " + String ( lIdDetail ) + " AND ID_REF_FOUR IN ( 'A_REPARER', 'A_DIAGNOSTIQUER', 'A_DESOXYDER' )", 1, idwCmdeSin.RowCount ())
lRow1 = idwArticle.Find ( "CHOIX = 'O' AND ID_REF_FOUR IN ( 'A_REPARER', 'A_DIAGNOSTIQUER', 'A_DESOXYDER' )", 1, idwArticle.RowCount () ) 
If lRow > 0 And lRow1 > 0 Then
		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "COMD915"
	
		F_Message ( stMessage )
		Return sDw + "DTE_RDV_CLI"		
End If

// [DT191-1]
// [PM280-2]
// [VDOC17789]
Choose Case sIdRefFour
	Case "A_REPARER", "A_DIAGNOSTIQUER", "CONTEST_SUR_REMPL"
		If isMarqPortAdh = "APPLE" And sPos = "" Then
			stMessage.sTitre		= "Commandes"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!
			stMessage.sCode		= "V017789"
		
			F_Message ( stMessage )
		End If
	

	Case "INFORMATION"
		// [DT288-3_LOT1_2EME_VS]
		lRow = idwCmdeSin.Find ( "ID_FOUR = 'COR' AND COD_ETAT <> 'ANN' AND ( POS ( INFO_FRN_SPB_CPLT, 'SWAP_AUTO_CTR=OUI' ) > 0 OR ( ID_REF_FOUR = 'A_REPARER' AND STATUS_GC = 2) )", 1, idwCmdeSin.RowCount ())

		If lRow <= 0 Then
			stMessage.sTitre		= "Commandes"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!
			stMessage.sCode		= "COMD968"
		
			F_Message ( stMessage )
			Return sDw + "DTE_RDV_CLI"		
		End IF 
	
		lRow = idwCmdeSin.Find ( "ID_FOUR = 'COR' AND COD_ETAT <> 'ANN' AND POS ( INFO_FRN_SPB_CPLT, 'SWAP_AUTO_CTR=OUI' ) > 0", 1, idwCmdeSin.RowCount ())
		
		If lRow > 0 Then
			lnv_String.of_setkeyvalue( isInfoSpbFrnCplt, "TYPE_INFO", "SAV_SUR_SWAP", ";")
		End If
		
		If lRow <= 0 Then
			lRow = idwCmdeSin.Find ( "ID_FOUR = 'COR' AND COD_ETAT <> 'ANN' AND ID_REF_FOUR = 'A_REPARER' AND STATUS_GC = 2", 1, idwCmdeSin.RowCount ())			
			If lRow > 0 Then
				lnv_String.of_setkeyvalue( isInfoSpbFrnCplt, "TYPE_INFO", "SAV_SUR_REPARATION", ";")
			End If
		End If 

	Case "A_CONTROLER_IMEI"
		// [PC874_2_V1]
		lRow = idwCmdeSin.Find ( "ID_REF_FOUR = 'A_CONTROLER_IMEI' AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount ())
		If lRow > 0 Then
			stMessage.sTitre		= "PC874-2 / Contrôle IMEI"
			stMessage.Icon			= information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!
			stMessage.sCode = "COMD980"
			F_Message ( stMessage )
			Return "G" + "RIB_BQ"
		End IF 
		
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 218)
		If lDeb > 0 Then
			dtVal = DateTime ( lnv_String.of_getkeyvalue(idw_DetPro.GetItemString(lDeb,"VAL_CAR" ), "DTE_PIVOT_PC874_2", ";") )
			dtCreeLeDos = idwWsin.GetItemDateTime ( 1, "CREE_LE")
			
			If dtCreeLeDos < dtVal Then
				// Protection contre saisie par défaut
				stMessage.sTitre		= "PC874-2 / Contrôle IMEI"
				stMessage.Icon			= information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= Ok!
				stMessage.sCode = "COMD981"
				F_Message ( stMessage )
				Return "G" + "RIB_BQ"

			End If 
		End If 

		lRow = idwWDivsin.Find ( "NOM_ZONE = 'cra_ctrl_imei'", 1, idwWDivSin.RowCount () )
		If lRow > 0 Then 
			idwWDivSin.SetItem ( lRow, "VAL_CAR", "O" ) 
			dtMajLe = DateTime ( Today (), Now () )
			idwWDivSin.SetItem ( lRow, "MAJ_LE", dtMajLe  )
			idwWDivSin.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )
			idwWDivSin.SetItem ( lRow, "ALT_SUPP", "N" )
		End If

		lRow = idwWDivsin.Find ( "NOM_ZONE = 'cra_suivi_imei'", 1, idwWDivSin.RowCount () )
		If lRow > 0 Then 
			idwWDivSin.SetItem ( lRow, "VAL_NBRE", 1 ) 
			dtMajLe = DateTime ( Today (), Now () )
			idwWDivSin.SetItem ( lRow, "MAJ_LE", dtMajLe  )
			idwWDivSin.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )
			idwWDivSin.SetItem ( lRow, "ALT_SUPP", "N" )
		End If			
		
End Choose
// [VDOC17789]



idwArticle.SetRedraw(TRUE)
Return sPos
end function

private function string uf_controlergestionedi_cdiscount (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestionEDI_CDiscount (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 19/07/2005
//* Libellé			: Controler Spécifique pour CDiscount
//* Commentaires	: 
//*
//* Arguments		: Long		aalCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   15/01/2010   [O2M_DIAG_NOMADE].Lot2.JFF.[20100303150646373]
//* --    JFF   07/04/2010   [PC384].[CDISCOUNT]
//* --    JFF   30/09/2010   [PC474]
//*-----------------------------------------------------------------

String sPos, sFiltreOrig, sIdTypArt, sIdRefFour
Long lTot, lRow, lIdEvt
Decimal{2} dcMtFrais, dcMtValAchat 
Boolean bPresence_ARecupARecycler, bMep_O2M_DIAG_NOMADE, bForcagePec 

stMessage.sCode = ""
stMessage.sVar[1] = "C-Discount"
sPos = ""

sIdTypArt = idwArticle.GetItemString ( alCpt, "ID_TYP_ART" ) 	

// #1  [O2M_DIAG_NOMADE].Lot2.JFF.[20100303150646373]
dcMtValAchat = idwDetail.GetitemDecimal( 1, "MT_VAL_ACHAT")
lIdEvt = idwDetail.GetitemNumber ( 1, "ID_EVT")

/* [PC474]
bPresence_ARecupARecycler = idwCmdeSin.Find ( "ID_FOUR = 'O2M' AND ID_REF_FOUR = 'A_RECUP_A_RECYCLER' AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.Rowcount () ) + &
								    idwCmdeGti.Find ( "ID_FOUR = 'O2M' AND ID_REF_FOUR = 'A_RECUP_A_RECYCLER' AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.Rowcount () ) > 0 
*/ 

/* [PC474]
bMep_O2M_DIAG_NOMADE = TRUE
*/
bForcagePec = idwwDivDet.Find ( "ID_GTI = " + String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) ) + &
							 			 " AND ID_DETAIL = " +  String ( idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
										 " AND UPPER ( NOM_ZONE ) = 'ALT_PEC' " + &
										 " AND UPPER ( VAL_LST_CAR ) = 'O'" &
									  , 1, idwwDivDet.RowCount () ) > 0 
// :#1  [O2M_DIAG_NOMADE].Lot2.JFF.[20100303150646373]

If sIdTypArt <> "EDI" Then Return ""

sIdRefFour = Upper ( idwArticle.GetItemString ( alCpt, "ID_REF_FOUR" ) )

Choose Case sIdRefFour 
	Case "MONTANT_FRAIS"
		lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'PROVISION_FRAIS'", 1, idwWDivSin.RowCount () ) 

		If lRow <= 0 Then 
			stMessage.sCode = "COMD410"
		Else
			dcMtFrais = idwWDivSin.GetItemDecimal ( lRow, "VAL_MT" ) 			

			If dcMtFrais <= 0 Or IsNull ( dcMtFrais ) Then
				stMessage.sCode = "COMD410"
			End If
		End If

	Case "MONTANT_VAL_ACHAT", "MONTANT_PEC" // [Vdoc10441]

		// Elle est obligatoire pour arriver jusque ici.

End Choose

// #1  [O2M_DIAG_NOMADE].Lot2.JFF.[20100303150646373]
/* [PC474]
If bMep_O2M_DIAG_NOMADE Then
	Choose Case lIdEvt 
		Case 973, 940
// [PC384].[CDISCOUNT]
//			If dcMtValAchat >= 200 And Not bPresence_ARecupARecycler And Not bForcagePec Then
			If dcMtValAchat >= 600 And Not bPresence_ARecupARecycler And Not bForcagePec Then
// :[PC384].[CDISCOUNT]
				stMessage.sCode = "COMD590"
			End If
	End Choose
End If
*/ // : [PC474]
// :#1 [O2M_DIAG_NOMADE].Lot2.JFF.[20100303150646373]

If stMessage.sCode <> "" Then
		F_Message ( stMessage )
		Return "G" + "PROBLEME"
End If

Return sPos

end function

public function string uf_controlersaisieedi ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerSaisieEdi (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 29/06/2004
//* Libellé			: Contrôle de saisie pour un EDI
//* Commentaires	: 
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 PHG	 19/12/2007	  [O2M] Refonte de la fonction pour integrer des controle edi Multifournisseur.
//* #2    JFF   02/09/2009   [DCMP090327].[SBETV]
//* #3    JFF   25/11/2009   [MSS_DIAG]
//* #4    JFF   02/03/2010   [MSS_LOT2]
//*       JFF   05/01/2012   [RECUP_DONNEE_O2M]
//        JFF   30/12/2013   [PC13348&13408]
//        JFF   30/12/2013 [PC13348&13408]
//        JFF   13/05/2015 [DT141][MANTIS15472]
//        JFF   29/02/2016 [DT191-1]
//        JFF   17/05/2016 [PM280-2]
//        JFF   29/08/2017 [DT288-3_LOT1_2EME_VS]
//*-----------------------------------------------------------------
String 		sNouvelleLigne, sPos, sText, sDw, sFiltreOrig, sIdFour,sIdRefFour 
long			lRow, lCol, lFour, lnbCol, lNbFour
String 		sTabNull[]
String		sCol[], sErr[], sIdFourArray[], sIdRefFourArray[]
n_cst_string	lnv_string
String 		sRet, sVal
String 		sVar[]

sNouvelleLigne		= "~r~n"
sPos					= ""
sText					= sNouvelleLigne
sDw					= ""

sFiltreOrig = iDwArticle.Describe ( "datawindow.table.filter" ) 
If sFiltreOrig = "?" Then sFiltreOrig = ""

idwArticle.SetFilter ( "CHOIX = 'O'" )
idwArticle.Filter ( )

/*------------------------------------------------------------------*/
/* Au moins une commande doit être saisie.								  */
/*------------------------------------------------------------------*/
If idwArticle.RowCount () <= 0 Then
	sDw = "G"
	sVar [1] = sNouvelleLigne + " - Au moins une sélection" + sNouvelleLigne
	sRet = sDw + sPos
End If 


/*------------------------------------------------------------------*/
/* Controle de Champs Obligatoire pour EDI                          */
/*------------------------------------------------------------------*/

/* [O2M].387 Controle de Champs sur la Dw des commandes */
// [MSS_LOT2] Ajout And Not ibReouvPresta 
// [VDOC8041]
if sRet = "" And Not ibReouvPresta Then
	sCol = sTabNull
	sErr = sTabNull
	sIdFourArray =sTabNull
	
	// Définition des colonne à tester, et du fournisseur auxquel ca s'applique.
	// Si '*' comme fournisseur défini pour une colonne, le controle est alors TOUT fournisseur
	// On s'arrete sur la 1ere ligne pour lequel un champ obligatoire n'a pas été saisi.

//	sCol[1] = "ADR_LIVR1" // JFF 31/12
	sCol[1] = "ADR_TEL1"  // JFF JFF 31/12

// sErr[1] = " - l'adresse." JFF 31/12
	sErr[1] = " - le numéro de téléphone en première ligne"  // JFF 31/12
	
	// [DCMP090327].[SBETV]
	// [MSS_DIAG]
	// [CONFO][MEUBLE][PC542]
	// [PC13348&13408]
	// [DT141][MANTIS15472]
	// [DT288-3_LOT1_2EME_VS]	
	sIdFourArray [1] = "O2M;SB1;MS1;BLC;MTT;SBE;COR"

	lNbCol	 = UpperBound ( sCol )
	
	// A ce moment la, tel qu'est concu la fenetre, on a n'a pas forcement connaissance, au niveau de la commande en cours,
	// du fournisseur auxquel on passe commande d'un flux EDI.
	// On assume donc que le fournisseur à prendre en compte est le fournisseur de la première ligne cochée.
	// Ce qui est cohérent, car on ne peux avoir de regle de saisie sur la dw au sein d'une meme commande pour
	// plusieurs fournisseurs.

// 	lRow = idwArticle.Find("CHOIX = 'O'", 1, idwArticle.rowcount()) //  JFF 31/12
// 	sIdFour	= upper(idwArticle.GetItemString ( lRow, "ID_FOUR" ))  // JFF 31/12
		
	For lCol = 1 TO lNbCol

// 		sVal 		= idwCmde.GetItemString ( lRow, sCol [ lCol ] ) // JFF 31/12
	 		sVal 		= idwCmde.GetItemString ( 1, sCol [ lCol ] ) // JFF 31/12	je mets 1 !, il n'y a toujours qu'une seule commande.	
		
//		If lnv_string.of_IsEmpty(sVal)	&
//			and ( Pos(sIdFourArray[lCol],"*" )>0 or Pos(sIdFourArray[lCol], sIdFour )>0 )  Then  // JFF 31/12
			
		If lnv_string.of_IsEmpty(sVal) Then  // JFF 31/12
		
			If sPos = "" Then sPos = sCol [ lCol ]
			sText = sText + sErr[ lCol ] + sNouvelleLigne
		End If
	Next
	If sText <> "" and sText <> sNouvelleLigne Then 
		sDw = "D"
		sVar [1] = sText
		sRet = sDw+sPos
	End If
End If

/* Controle de Champs sur la Dw ARticle */

if sRet = "" Then
	sCol = sTabNull
	sErr = sTabNull
	sIdFourArray =sTabNull
	sIdRefFourArray = stabNull
	
	// Définition des colonne à tester, et par colonne, les fournisseur et les reférence fournisseurs 
	// auxquels ca s'applique
	// Si '*' comme fournisseur défini pour une colonne, le controle est alors TOUT fournisseur
	// Si '*' comme Reférence Fournisseur définie pour une colonne, le controle est alors TOUTE Reference fournisseur
	// On s'arrete sur la 1ere ligne pour lequel un champ obligatoire n'a pas été saisi.

	// #4 [MSS_LOT2]
	If Not ibReouvPresta Then
		sCol[1] = "PROBLEME"
		sErr[1] = " - La description du problème"
	End If
	// :#4 [MSS_LOT2]
	
	// [DCMP090327].[SBETV]
	// #3 [MSS_DIAG]
	// [CONFO][MEUBLE][PC542]
	// [PC13348&13408]
	// [DT288-3_LOT1_2EME_VS]
	sIdFourArray [1] = "O2M;SB1;MS1;BLC;PSM;MTT;SBE;COR"
	sIdRefFourArray[1] = "A_DIAGNOSTIQUER;DONNEES_A_RECUPERER;CONTEST_SUR_REMPL;INFORMATION" // [RECUP_DONNEE_O2M] // [PM280-2]


	lNbCol	 = UpperBound ( sCol )
	
	For lRow = 1 to idwArticle.RowCount()
		
		sIdFour	= upper(idwArticle.GetItemString ( lRow, "ID_FOUR" ))
		sIdRefFour = upper(idwArticle.GetItemString ( lRow, "ID_REF_FOUR" ))
		
		For lCol = 1 TO lNbCol

			sVal 		= idwArticle.GetItemString ( lRow, sCol [ lCol ] )  
			
			If lnv_string.of_IsEmpty(sVal)	&
				and ( Pos(sIdFourArray[lCol],"*" )>0 or Pos(sIdFourArray[lCol], sIdFour )>0 ) &
				and ( Pos(sIdRefFourArray[lCol], "*" )>0 or Pos(sIdRefFourArray[lCol], sIdRefFour )>0 ) Then
				If sPos = "" Then sPos = sCol [ lCol ]
				sText = sText + sErr[ lCol ] + sNouvelleLigne
			End If
		Next
		
		/* Controle exceptionnel sur la dw article, ne rentrant pas dans la boucle */
		if sText = "" or sText = sNouvelleLigne  Then
			// [O2M].372, Note 265, Point 2 : L'info_spb_frn doit être saisi et supérieur à 0.
			// [DCMP090327].[SBETV]
			// #3 [MSS_DIAG]			
			// [CONFO][MEUBLE][PC542]
			Choose case sIdFour 
				Case "O2M", "SB1", "MS1", "BLC", "PSM", "COR"
					sVal = string(idwArticle.GetItemNumber ( lRow, 'INFO_SPB_FRN'))

					// #4 [MSS_LOT2] ajout And Not ibReouvPresta 
					if lnv_string.of_IsEmpty(sVal) or sVal = "0" And Not ibReouvPresta Then
						sPos = 'INFO_SPB_FRN'
						sText = sText + "- Le Process" + sNouvelleLigne
					End If
			End Choose
		End If
		
		If sText <> "" and sText <> sNouvelleLigne Then 
			sDw = "G"
			sVar [1] = sText
			sRet = sDw+sPos
			Exit
		End If
	Next
End If

// [DT191-1]
If sPos = "" Then
	This.uf_ControlerSaisie_Commune ( sPos )
	IF sPos <> "" Then 
		sDw = "D"
		Return sDw		
	End If
End If

If sPos = "" Then
	This.uf_ControlerSaisie_CP ( sPos )
	IF sPos <> "" Then 
		sDw = "D"
		Return sDw		
	End If
		
	Return sDw
End If

if sRet <> "" Then
	stMessage.sTitre		= "Controle de saisie - Information(s)"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "GENE001"
	stMessage.sVar 		= sVar
	F_Message (stMessage)
End If

idwArticle.SetFilter ( sFiltreOrig )
idwArticle.Filter ( )

Return sRet

end function

private subroutine uf_preparer_articletype_edi ();//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_Commande3::Uf_Preparer_ArticleType_EDI (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 20/07/2005 17:10:53
//* Libellé       : Juste après le retrieve, place les valeurs nécéssaire.
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//* 		FPI	11/03/2013	[VDoc10441] Montant valeur d'achat devien montant de pec
//*-----------------------------------------------------------------

Long lTot, lCpt, lRow
String	sIdTypArt, sIdRefFour, sIdMarqIfr

lTot = idwArticle.RowCount ()

For lCpt = 1 To lTot
		
	sIdTypArt = idwArticle.GetItemString ( lCpt, "ID_TYP_ART" ) 	
	If sIdTypArt <> "EDI" Then Continue

	sIdRefFour = Upper ( idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) )
	sIdMarqIfr = Upper ( idwArticle.GetItemString ( lCpt, "ID_MARQ_IFR" ) ) + " : "

	Choose Case sIdRefFour 
		Case "MONTANT_FRAIS"
			lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'PROVISION_FRAIS'", 1, idwWDivSin.RowCount () ) 

			If lRow <= 0 Then 
				idwArticle.SetItem ( lCpt, "ID_MARQ_IFR", sIdMarqIfr )							
				Continue
			End If

			idwArticle.SetItem ( lCpt, "ID_MARQ_IFR", sIdMarqIfr + String ( idwWDivSin.GetItemDecimal ( lRow, "VAL_MT" ), "#,##0.00 \"+stGlb.smonnaiesymboledesire ) ) //[SUISSE].LOT3

		Case "MONTANT_VAL_ACHAT"

			idwArticle.SetItem ( lCpt, "ID_MARQ_IFR", sIdMarqIfr + String ( idwDetail.GetItemDecimal ( 1, "MT_VAL_ACHAT" ), "#,##0.00 \"+stGlb.smonnaiesymboledesire ) ) //[SUISSE].LOT3
		
		Case "MONTANT_PEC" // [VDoc10441]
			lRow = idwwDivDet.Find ( "ID_GTI = " + String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) ) + &
								  " AND ID_DETAIL = " +  String ( idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
								  " AND UPPER ( NOM_ZONE ) = 'MT_PEC' " &
							  , 1, idwwDivDet.RowCount () ) 
	
			// Lecture du montant						  
			If lRow > 0 Then
				idwArticle.SetItem ( lCpt, "ID_MARQ_IFR", sIdMarqIfr + String (idwwDivDet.GetItemDecimal ( lRow, "VAL_MT" ), "#,##0.00 \"+stGlb.smonnaiesymboledesire ) ) 
			End if
			
	End Choose
		

Next
end subroutine

private subroutine uf_preparervalider_cdiscount ();//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_sinistre_wdetail::uf_PreparerValider_CDiscount (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 21/07/2005 14:28:47
//* Libellé       : On complémente les enregistrement pour C-Discount.
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
// 			FPI	25/02/2013 	[VDOC10441] On prend le montant de PEC et non la valeur d'achat
//*-----------------------------------------------------------------

Long lDeb, lFin, lTot, lCpt, lRow
String sVal, sIdRefFour
Decimal dcMtPec


// Traitement C-Discount
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 37 )

If lDeb <= 0 Then return

lTot = idwCmde.RowCount ()

For lCpt = 1 To lTot
	sVal = idwCmde.GetItemString ( lCpt, "ADR_NOM" )
	If IsNull ( sVal ) Or Trim ( sVal ) = "" Then idwCmde.SetItem ( lCpt, "ADR_NOM", "X" )

	sVal = idwCmde.GetItemString ( lCpt, "ADR_PRENOM" )
	If IsNull ( sVal ) Or Trim ( sVal ) = "" Then idwCmde.SetItem ( lCpt, "ADR_PRENOM", "X" )

	sVal = idwCmde.GetItemString ( lCpt, "ADR_LIVR1" )
	If IsNull ( sVal ) Or Trim ( sVal ) = "" Then idwCmde.SetItem ( lCpt, "ADR_LIVR1", "X" )

	sVal = idwCmde.GetItemString ( lCpt, "ADR_CP" )
	If IsNull ( sVal ) Or Trim ( sVal ) = "" Then idwCmde.SetItem ( lCpt, "ADR_CP", "X" )

	sVal = idwCmde.GetItemString ( lCpt, "ADR_VILLE" )
	If IsNull ( sVal ) Or Trim ( sVal ) = "" Then idwCmde.SetItem ( lCpt, "ADR_VILLE", "X" )

	sVal = idwCmde.GetItemString ( lCpt, "ADR_TEL1" )
	If IsNull ( sVal ) Or Trim ( sVal ) = "" Then idwCmde.SetItem ( lCpt, "ADR_TEL1", "X" )

	sVal = String ( idwCmde.GetItemDecimal ( lCpt, "MT_TTC_CMDE" ) )
	If IsNull ( sVal ) Or Trim ( sVal ) = "" Then idwCmde.SetItem ( lCpt, "MT_TTC_CMDE", 0 )


	idwCmde.SetItem ( lCpt, "DTE_ENV_BTE_FRN", idwWsin.GetItemDateTime ( 1, "DTE_SURV" ) )
	idwCmde.SetItem ( lCpt, "ID_SERIE_NOUV", idwWsin.GetItemString ( 1, "ID_CONTRAT_ABONNE" ) )


	sIdRefFour = Upper ( idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) )

	Choose Case sIdRefFour 
		Case "MONTANT_FRAIS"
			lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'PROVISION_FRAIS'", 1, idwWDivSin.RowCount () ) 
			idwCmde.SetItem ( lCpt, "MT_TTC_CMDE", idwWDivSin.GetItemDecimal ( lRow, "VAL_MT" ) )

		Case "MONTANT_VAL_ACHAT"

			// [VDOC10441] On prend le montant de PEC et non la valeur d'achat
			lRow = idwwDivDet.Find ( "ID_GTI = " + String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) ) + &
								  " AND ID_DETAIL = " +  String ( idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
								  " AND UPPER ( NOM_ZONE ) = 'MT_PEC' " &
							  , 1, idwwDivDet.RowCount () ) 
	
			// Lecture du montant						  
			If lRow > 0 Then
				dcMtPec = idwwDivDet.GetItemDecimal ( lRow, "VAL_MT" )
			End if 
		
			idwCmde.SetItem ( lCpt, "MT_TTC_CMDE", 	dcMtPec)
		
		Case "MONTANT_PEC" // [VDOC10441]
			lRow = idwwDivDet.Find ( "ID_GTI = " + String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) ) + &
								  " AND ID_DETAIL = " +  String ( idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
								  " AND UPPER ( NOM_ZONE ) = 'MT_PEC' " &
							  , 1, idwwDivDet.RowCount () ) 
	
			// Lecture du montant						  
			If lRow > 0 Then
				dcMtPec = idwwDivDet.GetItemDecimal ( lRow, "VAL_MT" )
			End if 
		
			idwCmde.SetItem ( lCpt, "MT_TTC_CMDE", 	dcMtPec)
	End Choose


Next


end subroutine

public function boolean uf_tracetoutmobile ();//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_Commande3::uf_TraceToutMobile (PUBLIC)
//* Auteur        : Madani M
//* Date          : 12/12/2005 14:25:50
//* Libellé       : Trace du bouton "Tout mobile":
//*						   
//* Commentaires  : DCMP 050641
//*
//* Arguments     : 
//*
//* Retourne      : Boolean  bRet
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

Long dcIdSin, dcIdProd, dcIdGti , lRow 
Decimal {2} dcMtValPbcSin 
Decimal {2} dcMtValPbc 
Decimal {2} dcMtPrixHT
Decimal {2} dcTVA
Decimal {2} dcMtValFrnttc 
String sNomGest, sPrenomGest, sMajPar, sSql , sMarqPortCmd , sModlPortCmd , sidTypArt 
Boolean  bRet

If Not ibToutMob Then Return False

dcIdSin				= idwwSin.GetItemNumber ( 1, "ID_SIN" )
dcIdProd    		= idwWsin.GetItemNumber ( 1, "ID_PROD" )
dcIdGti				= idwDetail.GetItemNumber ( 1, "ID_GTI" )
dcMtValPbcSin   	= idwDetail.GetItemDecimal ( 1, "MT_VAL_PUBLIQUE" )				//valeur IFR
sNomGest     		= Stglb.sNomOPer
sPrenomGest  		= Stglb.sPrenomOPer
smajPar      		= Stglb.sCodOper

If dcMtValPbcSin <= 0 Or IsNull ( dcMtValPbcSin ) Then 
	dcMtValPbcSin = 0
End If 

lRow  = idwarticle.Find ("CHOIX = 'O' " , 1 , idwarticle.RowCount () )

IF lRow > 0 THEN

 	dcMtPrixHT			= idwarticle.GetItemNumber (lRow , "MT_PRIX_HT" )
	dcTVA					= idwarticle.GetItemNumber (lRow , "TVA" )
	dcMtValFrnttc 		= dcMtPrixHT * ((dcTVA/100)+1)
	sidTypArt 			= idwarticle.GetItemString (lRow , "ID_TYP_ART" )
	sMarqPortCmd 		= idwarticle.GetItemString (lRow , "ID_MARQ_ART" )
	sModlPortCmd 		= idwarticle.GetItemString (lRow , "ID_MODL_ART" )
	dcMtValPbc 			= idwarticle.GetItemNumber (lRow , "MT_PRIX_IFR" )

// Tester si les valeurs ramenées sont nulles

	If dcMtValPbc <= 0 Or IsNull ( dcMtValPbc ) Then 
		dcMtValPbc = 0
	End If 

	If dcMtValFrnttc <= 0 Or IsNull ( dcMtValFrnttc ) Then 
		dcMtValFrnttc = 0
	End If 

	If IsNull ( sMarqPortCmd ) Then sMarqPortCmd = ""
	If IsNull ( sModlPortCmd ) Then sModlPortCmd = ""
	If IsNull ( sidTypArt ) Then sidTypArt = ""

ELSE
	sMarqPortCmd 		= "null"
	sModlPortCmd 		= "null"
	dcMtValPbc 			= 0
	dcMtValFrnttc 		= 0
	sidTypArt 			= "null"

END IF

sSql				= "Exec sysadm.PS_I01_TRACE_TOUT_MOBILE " + &
						String(dcIdSin)  + ", " + &
						String(dcIdProd) + ", " + &
						String(dcIdGti)  + ", " + &
						"'" + isMarqPortAdh + "', " + &
						"'" + isModlPortAdh + "', " + &
					   String(dcMtValPbcSin)  +", "  
						


If sMarqPortCmd = "null" Then
	ssql+= sMarqPortCmd+ ","
Else
	sSql+= "'" + sMarqPortCmd + "', "
End If


If sModlPortCmd = "null" Then
	ssql+= sMarqPortCmd+ ","
Else
	sSql+= "'" + sModlPortCmd + "', "
End If

if IsNull ( dcMtValPbc ) Or dcMtValPbc  <= 0 Then dcMtValPbc = 0
sSql+= String(dcMtValPbc) +","			

if IsNull ( dcMtValFrnttc ) Or dcMtValPbc  <= 0 Then dcMtValFrnttc = 0
sSql+= String(dcMtValFrnttc) +","		

If sidTypArt = "null" Then
	ssql+= sidTypArt+ ","
Else
	sSql+= "'" + sidTypArt + "', "
End If

If sNomGest = "null" Then
	ssql+= sNomGest + ","
Else
	sSql+= "'" + sNomGest + "', "
End If

If sPrenomGest = "null" Then
	ssql+= sPrenomGest+ ","
Else
	sSql+= "'" + sPrenomGest + "', "
End If

If smajPar = "null" Then
	ssql+= smajPar 
Else
	sSql+= smajPar 
End If


F_EXECUTE ( sSql, SQLCA)


bRet = SQLCA.SqlCode = 0 And SQLCA.SqlDbCode = 0
F_Commit (SQLCA , bRet )

Return bRet


end function

private function integer uf_zn_codmodereg (ref datawindow adw, string asdata, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_Zn_CodModeReg (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/03/2006
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: aDw				DataWindow	Val
//*					  asData			String		Val
//*					  alRow			String		Val
//*
//* Retourne		: Int
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*---------------------------------------------------------------

Integer iRet
String sRibBq, sRibGui, sRibCpt, sRibCle

iRet	= 0

// #1 [3SUISSE].COD_MODE_REG 
Long lDeb, lFin, lCpt
n_cst_string lnvPFCString
String sCodInterAutorise, sCodInter, sCodModReg 
Boolean bAutorise

sCodModReg = Upper ( asData )

Choose Case sCodModReg 
	Case "VA", "C"
		// Ok On passe au Ctrle de param
	Case Else 
	iRet			= 1
	idwCmde.iiErreur = 0
	Return iRet
End Choose

bAutorise = FALSE
sCodInter = "A" // Je force à A, on commande tjs poru un ASSURE
// :#1 [3SUISSE].COD_MODE_REG 

// #1 [3SUISSE].COD_MODE_REG 
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 100 )
For lCpt = lDeb To lFin
	If Trim ( Upper ( idw_DetPro.GetItemString ( lCpt, "ID_CODE_CAR" ) ) ) = Trim ( Upper ( sCodModReg ) ) Then
		sCodInterAutorise = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lCpt, "VAL_CAR" ), "COD_INTER", ";")
		bAutorise = sCodInter = sCodInterAutorise 
		If bAutorise Then Exit
	End If
Next

If Not bAutorise Then
	iRet			= 1
	idwCmde.iiErreur = 1
End If
// :#1 [3SUISSE].COD_MODE_REG 

// Interdiction de saisiR FM
/* Ancien code
If Upper ( asData ) = "FM" Then
	iRet			= 1
	idwCmde.iiErreur = 1
End If
*/

Return iRet



end function

public function long uf_controlerzone (string asdw, string asnomcol, string asdata, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerZone (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 19/09/2001
//* Libellé			: Controle de zones
//* Commentaires	: 
//*
//* Arguments		: asDw			String		Val
//*					  asNomcol		String		Val
//*					  asData			String		Val
//*					  alRow			Long			Val
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 CAG	 12/11/2002	  Annexe 20 : [MOBILE PROTECT] est géré
//*												  comme les autres produits SIMPA
//* #2	 CAG   16/06/2003	  Modification de la marque portable en dddw
//        JFF   12/11/2018   [PM452-1]
//*----------------------------------------------------------------

Int	iRet
String sVal, sHoraire, sHoraireDeb, sHoraireFin
Date dJourRdv
Long lLigHoraire
DataWindow dw
DataWindowChild	dwChild

iRet = 0

/*------------------------------------------------------------------*/
/* Sur quelle Dw a-t-on clické ?                                    */
/*------------------------------------------------------------------*/
CHOOSE CASE Upper ( asDw ) 
	CASE "DW_ARTICLE"
		dw = idwArticle

	CASE "DW_ARTICLE_PRS"
		dw = idwArticlePrs

	CASE "DW_COMMANDE"
		dw = idwCmde

END CHOOSE

CHOOSE CASE Upper ( asNomCol )

	CASE "PROBLEME"
		iRet = This.uf_Zn_Probleme ( dw, asData, alRow )

	CASE "CHOIX"
		
		iRet = This.uf_Zn_choix ( dw, asData, alRow )

	CASE "HRDV_CLI_MIN", "HRDV_CLI_MAX"

		sVal = This.uf_Formatage_Heure ( asData )
		If sVal = "-1" Then 
			iRet = 1
		Else
			iRet = 2
			dw.SetItem ( 1, asNomCol, sVal )
		End If

	CASE "ADR_CP"
		sVal = This.uf_Formatage_CP ( asData )

		/*------------------------------------------------------------------*/
		/* # Modification SFR # Le 17/07/2002.                              */
		/*------------------------------------------------------------------*/
		If	sVal <> "-1" And idwProduit.GetItemNumber ( 1, "COD_TEL" ) = 21 And &
			idwProduit.GetItemNumber ( 1, "ID_PROD" ) <> 5707	Then
		/*------------------------------------------------------------------*/
		/* On procéde à l'armement des valeurs pour les zones A ou B.       */
		/*------------------------------------------------------------------*/
			uf_Zn_AdrCp ( sVal )
		End If

		If sVal = "-1" Then 	iRet = 1

	CASE "ADRFC_CP"
		sVal = This.uf_Formatage_CP ( asData )

		If sVal = "-1" Then 	iRet = 1


	CASE "ADR_TEL1", "ADR_TEL2", "ADR_TEL3"

		sVal = F_Format_Num_Tel ( asData, TRUE )
		If sVal = "-1" Then 
			iRet = 1
		Else
			iRet = 2
			dw.SetItem ( 1, asNomCol, sVal )
		End If

	CASE "ADR_MAIL"

		sVal = This.uf_Formatage_eMail ( asData )


		If sVal = "-1" Then 
			iRet = 1
		Else
			iRet = 2
			dw.SetItem ( 1, asNomCol, sVal )
		End If

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
	Case"ID_CHOIX_HORAIRE"
		dw.GetChild ( "ID_CHOIX_HORAIRE", dwChild )
		lLigHoraire = dwChild.GetRow ()
		sHoraire		= dwChild.GetItemString ( lLigHoraire, "HORAIRE" )
		sHoraireDeb	= Left ( sHoraire, 2 ) + Mid ( sHoraire, 4, 2 )
		sHoraireFin	= Mid ( sHoraire, 7, 2 ) + Right ( sHoraire, 2 )
		
		dw.SetItem ( 1, "HRDV_CLI_MIN", sHoraireDeb )
		dw.SetItem ( 1, "HRDV_CLI_MAX", sHoraireFin )

		dJourRdv		= dwChild.GetItemDate ( lLigHoraire, "JOUR" )
		dw.SetItem ( 1, "DTE_RDV_CLI", dJourRdv )

	/*------------------------------------------------------------------*/
	/* #3 CAG 16/06/2003                                                */
	/*------------------------------------------------------------------*/
	Case "ID_MARQ_ART"
		If Trim ( asData ) <> "" Then	iRet = This.uf_Zn_Marque ( dw, asData, alRow )

	Case "ID_SERIE_ANC"
		If Trim ( asData ) <> "" Then	iRet = This.Uf_Zn_IdSerieAnc ( dw, asData, alRow )

	Case "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE"
		iRet = This.Uf_Zn_Rib ( dw, asData, alRow )

	Case "COD_MODE_REG"
		iRet = This.Uf_Zn_CodModeReg ( dw, asData, alRow )

	Case "INFO_SPB_FRN"
		iRet = This.Uf_Zn_InfoSpbFrn ( dw, asData, alRow )

	Case "ADR_COD_CIV"
		
		// [PM452-1]
		iRet = This.Uf_Zn_AdrCodCiv ( dw, asData, alRow )	

END CHOOSE
//Migration PB8-WYNIWYG-03/2006 FM
//dw.SetActionCode ( iRet )
Return iRet
//Fin Migration PB8-WYNIWYG-03/2006 FM
end function

public function long uf_gerermessage (string asdw);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_GererMessage (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 06/09/2001
//* Libellé			: Gestion Msg d'erreurs
//* Commentaires	: 
//*
//* Arguments		: asDw		String		Val
//*					  
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 CAG   16/06/2003	  Modification de la marque portable en dddw
//* #2	 CAG	 04/08/2003	  Modif du libellé du msg concernant la modif #1
//* #3	 PHG	 14/12/2007	  [O2M] Gestion : "Probleme" et "info_spb_frn" obligatoire pour O2M
//* #4    JFF   21/05/2008   [3SUISSE].COD_MODE_REG 
//* #5    JFF   02/09/2009   [DCMP090327].[SBETV]
//* #6    JFF   30/11/2009   [MSS_DIAG]
//* #7    JFF   02/03/2010   [MSS_LOT2]
//*		 FPI	 13/07/2010	  [PC321]
//        JFF   06/08/2012   [BLCODE]
//        JFF   30/08/2012   [VDOC8041]
//       JFF   30/12/2013 [PC13348&13408]
//       JFF   02/01/2015 [PC801_6_TAMET]
//       JFF   09/04/2015 [DT141]
//       JFF   12/11/2018 [PM452-1]
//       JFF   07/03/2024   [HP252_276_HUB_PRESTA]
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

u_DataWindow_Detail Dwdt
DataWindow	Dw

stMessage.sTitre  	= "Controle de zone"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.bouton 		= Ok!

CHOOSE CASE Upper ( asDw )

	CASE "DW_COMMANDE"
		dwdt = idwCmde

		CHOOSE CASE Upper ( dwdt.isErrCol )

			CASE "ADR_MAIL"
				stMessage.sCode = "COMD015"
				F_Message ( stMessage )

			CASE "ADR_CP", "ADRFC_CP"
				stMessage.sCode = "COMD016"
				F_Message ( stMessage )

			CASE "ADR_TEL1", "ADR_TEL2", "ADR_TEL3"
				stMessage.sCode = "COMD033"
				F_Message ( stMessage )

			Case "RIB_BQ"
				stMessage.sVar[1] = "code de la banque"
				stMessage.sCode	= "GENE003"
				F_Message ( stMessage )

			Case "RIB_GUI"
				stMessage.sVar[1] = "code du guichet"
				stMessage.sCode	= "GENE003"
				F_Message ( stMessage )

			Case "RIB_CPT"
				stMessage.sVar[1] = "numéro du compte"
				stMessage.sCode	= "GENE003"
				F_Message ( stMessage )

			Case "RIB_CLE"
				Choose Case dwdt.iiErreur
				Case 0
					stMessage.sVar[1] = "clé RIB"
					stMessage.sCode	= "GENE002"
					F_Message ( stMessage )

				Case 1
					stMessage.bErreurG	= False
					stMessage.sCode  		= "REFU005"
					F_Message ( stMessage )

				End Choose

			Case "COD_MODE_REG"
				Choose Case dwdt.iiErreur

					//* #1 [3SUISSE].COD_MODE_REG 
					Case 0
						stMessage.sCode	= "GENE163"
						stMessage.Icon			= Exclamation!
						F_Message ( stMessage )

					Case 1
						stMessage.sCode	= "GENE134"
						stMessage.Icon			= Exclamation!
						F_Message ( stMessage )

				End Choose
				
			Case "ADR_COD_CIV"

				Choose Case dwdt.iiErreur

					// [PM452-1]
					Case 0
						stMessage.sCode	= "WINT306"
						F_Message ( stMessage )
				End Choose 				

		END CHOOSE

	CASE "DW_ARTICLE"
		dw = idwArticle

		CHOOSE CASE Upper ( dw.GetColumnName () )

			CASE "PROBLEME"
				// #7 [MSS_LOT2]
				// [VDOC8041]
				If ibReouvPresta Or ibReouvPrestaO2M Then
					stMessage.sCode = "COMD613"
				Else 
					stMessage.sCode = "COMD034"
				End If
				F_Message ( stMessage )

			CASE "INFO_SPB_FRN" //#3 [O2M] Le Champs INFO_SPB n'est pas modifiabla par le gestionnaire par O2M
				//* #5 [DCMP090327].[SBETV]
				//* #6 [MSS_DIAG]
				// [PC13348&13408]
				// [DT141] Ajout SBE
				// [HP252_276_HUB_PRESTA] "HUB"
				Choose Case dw.object.id_four[dw.GetRow()] 
					Case "O2M", "SB1", "MS1", "BLC", "PSM", "MTT", "SBE", "COR", "HUB" // [BLCODE]
						// #7 [MSS_LOT2]		
						// [VDOC8041]
						If ibReouvPresta Or ibReouvPrestaO2M Then
							stMessage.sCode = "COMD613"
						// [HP252_276_HUB_PRESTA]
						ElseIf dw.object.id_four[dw.GetRow()] = "HUB" Then 
							stMessage.sCode = "COMT001"
						Else
							stMessage.sCode = "COMD461" // #3 [O2M] : Message "Cette information est fonction du paramètrage, vous ne pouvez pas la modifier."
						End If
						F_Message ( stMessage )
						
						// On remet l'ancienne valeur ( Simulation de uf_reinitialiser avec iiError a 2... )
						dw.SetItem (dw.GetRow(), 'INFO_SPB_FRN', dw.object.info_spb_frn[dw.GetRow()] ) 
				End Choose

		END CHOOSE

	CASE "DW_ARTICLE_PRS"
		dw = idwArticlePrs

		CHOOSE CASE Upper ( dw.GetColumnName ( ) )

			CASE "PROBLEME"
				// #7 [MSS_LOT2]
				// [VDOC8041]				
				If ibReouvPresta Or ibReouvPrestaO2M Then
					stMessage.sCode = "COMD613"
				// [PC321]
				ElseIf ibPasDeSaisieProbleme Then
					stMessage.sCode = "COMD642"
				// [PC321]
				Else
					stMessage.sCode = "COMD034"
				End If
				F_Message ( stMessage )

			/*------------------------------------------------------------------*/
			/* #1 CAG 16/06/2003                                                */
			/*------------------------------------------------------------------*/
			/* #2 CAG 04/08/2003                                                */
			/*------------------------------------------------------------------*/
			CASE "ID_MARQ_ART"
				stMessage.sCode = "WSIN130"
				stMessage.sVar [ 1 ] = "La marque de l'appareil"
				F_Message ( stMessage )

			// #7 [MSS_LOT2]		
			CASE "INFO_SPB_FRN" //#3 [O2M] Le Champs INFO_SPB n'est pas modifiabla par le gestionnaire par O2M
				//* #5 [DCMP090327].[SBETV]
				//* #6 [MSS_DIAG]
				// [PC13348&13408]
				// [PC801_6_TAMET]
				// [HP252_276_HUB_PRESTA] "HUB"
				Choose Case dw.object.id_four[dw.GetRow()] 
					Case "O2M", "SB1", "MS1", "SCR", "BLC", "PSM", "MTT", "TMT", "SBE", "COR", "HUB" // [PC321] - Ajout de SCR // [BLCODE]
						// [VDOC8041]										
						If ibReouvPresta Or ibReouvPrestaO2M Then
							stMessage.sCode = "COMD613"
						// [HP252_276_HUB_PRESTA]
						ElseIf dw.object.id_four[dw.GetRow()] = "HUB" Then 
							stMessage.sCode = "COMT001"
						Else
							stMessage.sCode = "COMD461" // #3 [O2M] : Message "Cette information est fonction du paramètrage, vous ne pouvez pas la modifier."
						End If
						F_Message ( stMessage )
						
						// On remet l'ancienne valeur ( Simulation de uf_reinitialiser avec iiError a 2... )
						dw.SetItem (dw.GetRow(), 'INFO_SPB_FRN', dw.object.info_spb_frn[dw.GetRow()] ) 
				End Choose
			// :#7 [MSS_LOT2]		

			
		END CHOOSE

END CHOOSE

If asDw = "DW_COMMANDE" Then 
//	dwdt.iiReset = 2
	dwdt.uf_Reinitialiser ( )
	ll_ret = 1  // Ajout JFF le 05/10/2008, bug datant de la migration, oubli WYNWYG.
Else
//Migration PB8-WYNIWYG-03/2006 FM
//	dw.SetActionCode ( 1 )
	ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
End If

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end function

private function string uf_controlergestion_cordon (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_CORDON (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 09/05/2006
//* Libellé			: Controle Spécifique pour CORDON
//* Commentaires	: DCMP 060356 : Controle spécial 
//*					  liste -IF
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	JCA	26/12/2006	DCMP 060907 - Changement de l'appel à F_Determiner_Montant_Frais_Envoi
//*									ajout des arguments alidprod (Val), adwdetpro (Ref), adcFrais (Ref)
//		 	FPI	24/06/2010 [DCMP100551] Modification de l'option 76
//*-----------------------------------------------------------------

String sPos, sProbleme, sCodModeReg, sIdRefFour
Long lInfoSpbFrn 
Dec {2} dcFrais //#1
Boolean bRibVide
String sTypArt, sNumCmde	
Long lRow, lIdGti
String sVal, sAdresseCordon
n_cst_string lnvPFCString
Date dDtePivot  

sPos = ""

lIdGti = idwDetail.GetItemNumber ( 1, "ID_GTI" ) 

sAdresseCordon = "Assurance C/O Cordon Electronics" + Char ( 13 )
sAdresseCordon += "ZI de la Lande" + Char ( 13 )
sAdresseCordon += "10 à 14 Chemin de Barateau" + Char ( 13 )
sAdresseCordon += "33999 Saint-Loubès"

/*------------------------------------------------------------------*/
/* Si au moins une prestation vers AV est détectée                 */
/* ET sur laquelle la zone info_spb_frn est égale à 310  (client    */
/* envoi son mobile)                                                */
/* ET que la méthode de règlement et " VA "                         */
/* ET que le RIB est vide                                           */
/* ALORS afficher un message :                                      */
/*------------------------------------------------------------------*/

sTypArt = idwArticle.object.id_typ_art [alCpt] 
sIdRefFour = idwArticle.object.id_ref_four [alCpt]  // [DT288-3_LOT1_2EME_VS]
sNumCmde	= string(idwWsin.object.id_sin[1])+"-"+string(uf_nouveau_num_sequence( ))
lInfoSpbFrn = idwArticle.GetItemNumber ( alCpt, "INFO_SPB_FRN" ) 
sCodModeReg = idwCmde.GetItemString ( 1, "COD_MODE_REG" ) 
bRibVide    = 	IsNull ( idwCmde.GetItemString ( 1, "RIB_BQ" ) ) Or idwCmde.GetItemString ( 1, "RIB_BQ" ) = Fill ( "0", 5 ) Or &
					IsNull ( idwCmde.GetItemString ( 1, "RIB_GUI" ) ) Or idwCmde.GetItemString ( 1, "RIB_GUI" ) = Fill ( "0", 5 ) Or &
					IsNull ( idwCmde.GetItemString ( 1, "RIB_CPT" ) ) Or idwCmde.GetItemString ( 1, "RIB_CPT" ) = Fill ( "0", 11 ) Or&
					IsNull ( idwCmde.GetItemString ( 1, "RIB_CLE" ) ) 

If  lInfoSpbFrn = 310 Then
		/*------------------------------------------------------------------*/
		/* On déprotège les zones                                           */
		/*------------------------------------------------------------------*/
		idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "0" )
Else 
		/*------------------------------------------------------------------*/
		/* Sinon on laisse protègé.													  */
		/*------------------------------------------------------------------*/
		idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "1" )
End If 

If  lInfoSpbFrn = 310 And Upper ( sCodModeReg ) = "VA" And bRibVide Then
		stMessage.sCode = "COMD071"
		F_Message ( stMessage )
		Return "D" + "RIB_BQ"
End If

/*------------------------------------------------------------------*/
/* Message d'information pour le gestionnaire                       */
/*------------------------------------------------------------------*/
If  lInfoSpbFrn = 310 Then
	stMessage.sCode = "COMD081"
	//stMessage.sVar [1] = F_Determiner_Montant_Frais_Envoi ( String ( lInfoSpbFrn ), idwWsin.object.id_prod[1], idw_DetPro, dcFrais ) // #1
	stMessage.sVar [1] = F_Determiner_Montant_Frais_Envoi ( String ( lInfoSpbFrn ), idwWsin.object.id_prod[1], isTypApp, idw_DetPro, dcFrais ) // [DCMP100551]
	stMessage.sVar [2] = String ( idwCmde.GetItemNumber ( 1, "ID_SIN" ) ) + "-" + String (  This.uf_Nouveau_Num_Sequence () ) 
	F_Message ( stMessage )
End If 

/*------------------------------------------------------------------*/
/* Message d'information pour le gestionnaire                       */
/*------------------------------------------------------------------*/
Choose Case lInfoSpbFrn 
	Case 912
		If sTypArt = "PRS" Then
			stMessage.sCode = "COMD955" 					
			stMessage.sVar[1] = sNumCmde
			stMessage.sVar[2] = sAdresseCordon
			F_Message ( stMessage )
		End If

	Case 908			
		If sTypArt = "PRS" Then
			stMessage.sCode = "COMD956" 					
			stMessage.sVar[1] = sNumCmde
			stMessage.sVar[2] = sAdresseCordon			
			F_Message ( stMessage )
		End If

	Case 982		

		If sTypArt = "PRS" Then
			stMessage.sCode = "COMD957" 					
			F_Message ( stMessage )
		End If


End Choose 

lRow = idwWDivsin.Find ( "NOM_ZONE = 'code_verrou_sherpa_script'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	 sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
	 If IsNull ( sVal ) Then sVal = ""
	 If Len ( sVal ) > 0 Then
		 lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_VERROU_ORIG", sVal, ";")
	 End If
End If


If sTypArt = "CAF" Then 
	
	// [DT288-4]
	lRow = idwCmdeSin.Find ( "ID_FOUR = 'COR' AND COD_ETAT <> 'ANN' AND POS ( INFO_FRN_SPB_CPLT, 'SWAP_AUTO_CTR=OUI' ) > 0 AND POS ( INFO_FRN_SPB_CPLT, 'PRBLE_LIVRAISON=COLIS_PERDU' ) > 0", 1, idwCmdeSin.RowCount ()) + &
			 idwCmdeSin.Find ( "ID_FOUR = 'COR' AND COD_ETAT <> 'ANN' AND STATUS_GC = 2 AND POS ( INFO_FRN_SPB_CPLT, 'PRBLE_LIVRAISON=COLIS_PERDU' ) > 0", 1, idwCmdeSin.RowCount ()) 		
	If lRow <= 0 Then
		stMessage.sTitre		= "DT288 : Condition commande CORDON"
		stMessage.Icon			= information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode = "COMD970"
		F_Message ( stMessage )
		Return "G" + "RIB_BQ"
	End If
	
	If lRow > 0 Then
		idwArticle.SetItem ( alCpt, "ID_MARQ_ART", isMarqPortAdh ) 
		idwArticle.SetItem ( alCpt, "ID_MODL_ART", isModlPortAdh ) 		
		idwArticle.SetItem ( alCpt, "ID_MARQ_IFR", isMarqPortAdh ) 
		idwArticle.SetItem ( alCpt, "ID_MODL_IFR", isModlPortAdh ) 		
		idwArticle.SetItem ( alCpt, "ID_REF_FOUR", "A_COMMANDER" ) 		
		idwArticle.SetItem ( alCpt, "ID_TYP_ART", isTypApp )
		idwArticle.SetItem ( alCpt, "ID_TYP_ART", isTypApp )
		idwArticle.SetItem ( alCpt, "INFO_SPB_FRN", 975 )
		
		stMessage.sCode = "COMD789"
		F_Message ( stMessage )		
		
	End If
End If


Return sPos

end function

private function string uf_controlergestion_wbx (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_WBX (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 07/02/2007
//* Libellé			: Controle Spécifique pour fournisseur(s) virtuel WEB
//* Commentaires	: [SITE_CMDE] Gestion des nouvelles option d'autorisation 79, 80, 81
//*												  
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF	09/06/2008    [DCMP070798]
//*  	    JFF	13/04/2010    [WEBSIM2].[FRANCE]
//*-----------------------------------------------------------------

String sPos, sIdGti, sIdTypArt, sIdFourEnCours, sIdFourAut, sFiltreOrigArticle, sFiltre
String sDescribe, sFiltreFrn, sIdSin, sSql
Long lTot, lCpt, lRowFrn, lRow, lNbreMiniMob, lDeb, lFin, lNbreMob
n_cst_string lnvPFCString
Boolean bNbreMiniMobOk

sPos = ""

// Donnée utile pour les filtres
sIdGti = String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) )
sIdTypArt = Upper ( idwArticle.GetItemString ( alCpt, "ID_TYP_ART" ) )
sIdFourEnCours = Upper ( idwArticle.GetItemString ( alCpt, "ID_FOUR" ) )
sIdSin = String ( idwDetail.GetItemNumber ( 1, "ID_SIN" ) )

// Sav du filtre original
sFiltreOrigArticle = idwArticle.Describe ("DataWindow.Table.filter") 
If sFiltreOrigArticle = "?" Then sFiltreOrigArticle = ""

lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "NEUF_REC", "", ";")

Choose Case Upper ( sIdFourEnCours )

	// Controle propre à la WBA
	Case "WBA"
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 80 )

		lNbreMiniMob = Long ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "NBRE_MINI_MOB", ";"))
		
		// Nouveau filtre avec gel de l'écran
		// Ce filtre fait appraître les potentiellement commandable et ceux bloquant par un plafond.
		// Malheureusement, aucun critère ne peut faire apparaître ceux uniquement commandable.
		sFiltre = "ID_TYP_ART = '" + sIdTypArt + "' AND ID_FOUR <> '" + sIdFourEnCours + "'"
		idwArticle.SetRedraw ( FALSE )
		idwArticle.SetFilter ( sFiltre )
		idwArticle.Filter ( )
		
		lTot = idwArticle.RowCount ( )
		
		bNbreMiniMobOk = False
		lNbreMob = 0
		
		
		For lCpt = 1 To lTot
		
			// On vérifie que mobile appartienne bien à un fournisseur lié à la Gti
			sIdFourAut = Upper ( idwArticle.GetItemString ( lCpt, "ID_FOUR" ) )
		// #1	[DCMP070798] lRowFrn = idwFourn.Find ( "ID_GTI = " + sIdGti + " AND ID_CODE_FRN = '" + sIdFourAut + "' AND ID_CODE_ART = '" + sIdTypArt + "'", 1, idwFourn.RowCount ()) // #1	

			lRowFrn = idwArticle.Find ( "ID_FOUR = '" + sIdFourAut + "' AND ID_TYP_ART = '" + sIdTypArt + "'", 1, idwArticle.RowCount ()) // #1				
		// :#1 [DCMP070798]
		
			// Si OUI...
			If lRowFrn > 0 Then
				
				// ON récupère la propirété visible de la case à cocher donnant ordre de commande
				sDescribe = Trim ( idwArticle.describe ( "choix.visible" ) )
		
				// On en épure les " en début de chaîne, les TAB, et on remplace les ' par ~~'
				sDescribe = F_Remplace ( sDescribe, '"', "" )
				sDescribe = Mid ( sDescribe, Pos ( Upper ( sDescribe ), "IF", 1 ), Len ( sDescribe ) )
				sDescribe = F_Remplace ( sDescribe, "'", "~~'" )
		
				If idwArticle.describe ( "Evaluate ( '" + sDescribe + "', " + String ( lCpt ) + ")" ) = "1" Then
					lNbreMob ++
					bNbreMiniMobOk = lNbreMob >= lNbreMiniMob
				End If 
		
				// Au moins lNbreMiniMob mobile(s) est dispo à la commande alors vu avec BH le 31/01/07, 
				// ON autroise la commande WEB
				If bNbreMiniMobOk Then Exit
		
			End If
		Next
		
		idwArticle.SetFilter ( sFiltreOrigArticle )
		idwArticle.Filter ( )
		idwArticle.Sort ()
		
		/*------------------------------------------------------------------*/
		/* #1                                                               */
		/*------------------------------------------------------------------*/
		
		If Not bNbreMiniMobOk Then
			
			If Not ibAMUTrace1 Then
				// TRACE_1
				sSql  =	" EXEC sysadm.PS_I01_TRACE_CMDE_V01 "
				sSql +=	"null, "
				sSql +=	"'GTI=" + sIdGti + ";MT_PLAF=" + String ( idcMtPlafcmdeWeb ) + "', "
				sSql +=	sIdSin + ", "
				sSql +=	"null, "
				sSql +=	"null, "
				sSql +=	"1, "
				sSql +=	"'TRACE', "
				sSql +=	"'SIM8', "
				sSql +=	"'SAISIE', "
				sSql +=	"null, "
				sSql +=	"'" + stGlb.sCodOper + "'"
			
				F_EXECUTE ( sSql, SQLCA)	
				F_Commit  (SQLCA , SQLCA.SqlCode = 0 And SQLCA.SqlDbCode = 0 )
				ibAMUTrace1 = TRUE
			End If
			
			stMessage.sTitre		= "Commande WEB refusée"
			stMessage.Bouton		= Ok!
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "COMD431"
			f_Message ( stMessage ) 
			sPos = "PROBLEME"
		End If


	// Controle propre à la WBA	
	Case "WBB"
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 81 )

	// [WEBSIM2].[FRANCE]
	   If sPos = "" Then
			If Not ibAMUTrace1Btq Then
				// TRACE_1
				sSql  =	" EXEC sysadm.PS_I01_TRACE_CMDE_BTQ_V01 "
				sSql +=	"null, "
				sSql +=	"'GTI=" + sIdGti + ";MT_PLAF=" + String ( idcMtPlafcmdeWeb ) + "', "
				sSql +=	"null, "
				sSql +=	sIdSin + ", "
				sSql +=	"null, "
				sSql +=	"null, "
				sSql +=	"null, "
				sSql +=	"null, "
				sSql +=	"27, "
				sSql +=	"'TRACE', "
				sSql +=	"'SIHP', "
				sSql +=	"'SAISIE', "
				sSql +=	"null, "
				sSql +=	"null, "
				sSql +=	"'" + stGlb.sCodOper + "'"
			
				F_EXECUTE ( sSql, SQLCA)	
				F_Commit  (SQLCA , SQLCA.SqlCode = 0 And SQLCA.SqlDbCode = 0 )
				ibAMUTrace1Btq = TRUE
			End If
		End If		
		
End Choose


Return sPos



end function

private subroutine uf_armementplafond (string ascas);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ArmementPlafond (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 19/09/2001
//* Libellé			: Armement des plafonds
//* Commentaires	: 
//*
//* Arguments		: String		asCas		val   // [DCMP070059] APPLICATION_TOTALE/APPLICATION_PARTIELLE
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    06/11/2003  Gestion du nouveau plafond VALEUR D'ACHAT pour DARTY
//* #2    JFF	  06/02/2006  [SITE_CMDE] Gestion des nouvelles option d'autorisation 79, 80, 81
//* #3    JFF    23/02/2006  [DCMP070059]
//*       JFF    17/06/2011  [PC545].[BUG_BGE_721]
//*       JFF    27/07/2011  [PLAF_REF]
//*       JFF    03/08/2015  [BUG_IDCMTPLAFCMDEWEB]
//*----------------------------------------------------------------

Long lTot, lCpt, lDeb1, lDeb2, lFin, lIdGti, lIdDetail, lRow, lTotDetail, lCptDet, lIdEvt 
String	sIdGti, sIdEvt, sNull, sFiltre, sFiltreOrig, sPlafAutre , sIdNivPlaf, sVal, sRech
Decimal {2} dcPlafGti, dcPlafEvt, dcPlafValAch, dcPlafDef, dcPlafSav, dcPlafValIfr, dcMtLu, dcMtMaxLu
u_DataWindow udwNull
s_Plafond_Pec stPlafPec
n_cst_string lnvPFCString

SetNull ( sNull ) 
SetNull ( udwNull )

// ITSM134028
// Clé permanente à ne pas supprimer
// On shunt les contrôles bloquant, on autorise le forçage.
If F_CLE_A_TRUE ( "SHUNT_CTRLE_FORC_PEC" ) Then
	Choose Case stGlb.sCodOper
		Case "JFF", "FPI"
			Return 
	End Choose
End If

/*------------------------------------------------------------------*/
/* On sauve le filtre original.                                     */
/*------------------------------------------------------------------*/
sFiltreOrig = idwArticle.Describe ("DataWindow.Table.filter") 
If sFiltreOrig = "?" Then sFiltreOrig = ""

sVal = ""

/*------------------------------------------------------------------*/
/* Armement des plafonds.                                           */
/*------------------------------------------------------------------*/
idwBandeau.InsertRow ( 0 )
idwBandeau.SetItem ( 1, "NOUV_CMDE", sNull )

lIdGti = idwDetail.GetItemNumber ( 1, "ID_GTI" )
lIdDetail = idwDetail.GetItemNumber ( 1, "ID_DETAIL" )
lIdEvt = idwDetail.GetItemNumber ( 1, "ID_EVT" )

//* F_Plafond_Pec 
//* Retourne		: Structure s_plafond_pec (0 indique qu'il n'y a pas de plafond)
//*					  Pour le type Autre, le retour est sous cette forme
//*					  O[704][3]    => OUI, plaf 704, x3 (en cours + autre)
//*					  N[704][1]		=> NON, plaf 704, x1 ( juste l'en cours)

// [PC545].[BUG_BGE_721]
//	[PC363].[10%]
lRow = idwCmdeSin.Find ( "COD_ETAT <> 'ANN' AND POS ( INFO_FRN_SPB_CPLT, 'APP_INCOMPLET=OUI', 1) >0", 1, idwCmdeSin.RowCount () )
sVal = "[###]"

If lRow > 0 Then
	lnvPFCString.of_Setkeyvalue ( sVal, "APP_INCOMPLET", "OUI", ";")
End If

// [PC301].[V15_EVOL_VETUSTE]
lTotDetail = idwDetail.iudwDetailSource.RowCount ()
dcMtLu = 0
dcMtMaxLu = 0
For lCptDet = 1 To lTotDetail	
	
	sRech	=		"ID_GTI = "	+ String ( idwDetail.iudwDetailSource.GetItemNumber ( lCptDet, "ID_GTI" ) )	+ " AND " 	+ &
					"ID_DETAIL = "	+ String ( idwDetail.iudwDetailSource.GetItemNumber ( lCptDet, "ID_DETAIL" ) )	+ " AND " 	+ &
					"UPPER ( NOM_ZONE ) = 'MT_MAX_PROPO_PLF722'"
		
	lRow = idwwDivDet.Find ( sRech, 1, idwwDivDet.RowCount () ) 
	If lRow > 0 Then
		dcMtLu = idwwDivDet.GetItemDecimal ( lRow, "VAL_MT" )
		If dcMtLu > dcMtMaxLu Then
			dcMtMaxLu = dcMtLu 
		End If
	End If					
	
Next

If dcMtMaxLu > 0 Then
	lnvPFCString.of_Setkeyvalue ( sVal, "MT_MAX_PLAF_722", String ( dcMtMaxLu ), ";")
End If
// [PC301].[V15_EVOL_VETUSTE]
// :[PC545].[BUG_BGE_721]
// :[PC545].[BUG_BGE_721].[DEBUG][MER][MEP]

stPlafPec = F_Plafond_Pec ( "3" + sVal, idwwSin, idwWDivsin, udwNull, idwDetail, udwNull, idwPlafond, idw_DetPro, idw_produit, idwwDivDet, lIdGti, lIdDetail )

// Affichage palfond sur Bandeau
idwBandeau.SetItem ( 1, "MT_PLAF_GTI", stPlafPec.dcPlafGti )
idwBandeau.SetItem ( 1, "MT_PLAF_EVT", stPlafPec.dcPlafEvt )

// #3
If Upper ( asCas ) = "APPLICATION_PARTIELLE" Then 
	idwBandeau.SetItem ( 1, "MT_PLAF_VALACHAT", 0  )
	idwBandeau.SetItem ( 1, "MT_PLAF_IFR", 0 )
Else
	idwBandeau.SetItem ( 1, "MT_PLAF_VALACHAT", stPlafPec.dcPlafValAch  )
	idwBandeau.SetItem ( 1, "MT_PLAF_IFR", stPlafPec.dcPlafValPublique )
End If

Choose Case Left ( stPlafPec.sPlafAutre, 1 )
	Case "O"
		idwBandeau.SetItem ( 1, "ALT_AUTRE_PLAFOND", Right ( stPlafPec.sPlafAutre, Len ( stPlafPec.sPlafAutre ) - 1 ) )		
	Case Else 		
		idwBandeau.SetItem ( 1, "ALT_AUTRE_PLAFOND", "(Aucun)" )		
End Choose 

/*------------------------------------------------------------------*/
/* On prend le plus petit des plafond positif.                      */
/*------------------------------------------------------------------*/
If Left ( stPlafPec.sPlafAutre, 1 ) = "O" Then 
	dcPlafDef = -100
	idcMtPlafcmdeWeb  = -2  // #2 Commande interdite sur le WEB
Else
	dcPlafDef = 100000
	idcMtPlafcmdeWeb = -1 // #2 Aucun plafond sur le WEB
	
	// #3
	If Upper ( asCas ) <> "APPLICATION_PARTIELLE" Then 
		If dcPlafDef > stPlafPec.dcPlafValPublique And stPlafPec.dcPlafValPublique > 0 Then dcPlafDef = stPlafPec.dcPlafValPublique 
		If dcPlafDef > stPlafPec.dcPlafValAch And stPlafPec.dcPlafValAch > 0 Then dcPlafDef = stPlafPec.dcPlafValAch
	End If
	
	If dcPlafDef > stPlafPec.dcPlafGti  And stPlafPec.dcPlafGti  > 0 Then dcPlafDef = stPlafPec.dcPlafGti  
	If dcPlafDef > stPlafPec.dcPlafEvt And stPlafPec.dcPlafEvt > 0 Then dcPlafDef = stPlafPec.dcPlafEvt 
	
	If dcPlafDef <= 0 Then dcPlafDef = 100000

	// #2 plafond détecté pour le Web		
	If dcPlafDef > 0 And dcPlafDef < 100000 Then idcMtPlafcmdeWeb = dcPlafDef

	// [PLAF_REF]
	// à laisser pour la MEP
	If dcPlafDef = 0.01 Then 
	
		// Si lRow <= 0 alors PEC suite placement projet, sinon, PEC réél
		lRow = idwwDivDet.Find ( "ID_GTI = " + String ( lIdGti ) + " AND " + &
										 "ID_DETAIL = " + String ( lIdDetail ) + " AND " + &
										 "UPPER ( NOM_ZONE ) = 'ALT_PLAF_PEC' " + " AND " + &
										 "VAL_CAR = 'O'", 1, idwwDivDet.RowCount() )
		
		If lIdEvt = 1083 And lRow <= 0 Then
			dcPlafDef = 10000
		Else 
			dcPlafDef = -100
			idcMtPlafcmdeWeb = dcPlafDef 
		End If
		
	End If
	// [PLAF_REF]	

End If

// [PM103] On laisse passé pour ne pas géner la reprise.
If gbModeReprise_223 Then
	If idwDetail.GetItemNumber ( 1, "ID_EVT" ) = 1083 Then
		dcPlafDef = 10000
	End IF
End If
// :[PM103]

// [PLAF_PEC_AR] On ne tient pas compte du plafond si un diag non ann est déjà présent
lRow = idwCmdeSin.Find ( "( ID_REF_FOUR IN ( 'A_DIAGNOSTIQUER', 'A_REPARER') OR ID_TYP_ART = 'PRS' ) AND COD_ETAT NOT IN ( 'ANN', 'CNV' )", idwCmdeSin.Rowcount(), 1 ) 
If lRow > 0 And isChoixAction = "I" Then
	dcPlafDef = 10000
End If
// [:PLAF_PEC_AR]

// [BUG_IDCMTPLAFCMDEWEB]
If idcMtPlafcmdeWeb > 0 And idcMtPlafcmdeWeb > idcMtPec Then
	idcMtPlafcmdeWeb = idcMtPec
End If

If dcPlafDef > 0 And dcPlafDef > idcMtPec Then
	dcPlafDef = idcMtPec
End If

/*------------------------------------------------------------------*/
/* Armement sur Dw Article.                                         */
/*------------------------------------------------------------------*/
idwArticle.SetFilter ( "" )
idwArticle.Filter ()
lTot = idwArticle.RowCount ()
For lCpt = 1 To lTot
	idwArticle.SetItem ( lCpt, "MT_PLAF", dcPlafDef  )
Next

// #3
idwArticle.SetFilter ( sFiltreOrig )
idwArticle.Filter ( )
idwArticle.Sort ( )

end subroutine

private subroutine uf_controlersaisie_cp (ref string aspos);
//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande3::uf_ControlerSaisie_CP (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 09/10/2003 16:34:05
//* Libellé       : 
//* Commentaires  : 
//*
//* Arguments     : String		réf		asPos
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ	PAR      Date	     Modification
//* #1	JCA	27/02/2007	Réécriture de la fonction - DCMP 070019 - Envoi commande fournisseur pour assuré habitant DOM-TOM et à l'étranger
//* #2   JFF   17/04/2007  [SITE_CMDE]
//			FPI	25/07/2014	[PC925] - ITSM 227299 PEC Web si produit SRR
//			FPI	12/01/2014	[ITSM255402] - ITSM 255402 PEC Web si produit Orange Caraibe
//*-----------------------------------------------------------------

n_cst_string	lnvPFCString
Long 				lDeb, lFin
string			sIdTypArt, sAdrCp, sAdrVille, sIdCodeCar, sValCar
integer 			i
boolean			bAutoriseCommande
String 			sFiltreOrigArticle, sFiltre, sIdFour


// sIdTypArt = idwArticle.object.id_typ_art[1]   Bug JCA => modif JFF
// Deb Modif JF

// Sav du filtre original
sFiltreOrigArticle = idwArticle.Describe ("DataWindow.Table.filter") 
If sFiltreOrigArticle = "?" Then sFiltreOrigArticle = ""

sFiltre = "CHOIX = 'O'"
idwArticle.SetRedraw ( FALSE )
idwArticle.SetFilter ( sFiltre )
idwArticle.Filter ( )

If idwArticle.RowCount ( ) > 0 Then
	sIdTypArt = idwArticle.object.id_typ_art[1]
	sIdFour = idwArticle.object.id_Four[1] // #2
End If	

idwArticle.SetFilter ( sFiltreOrigArticle )
idwArticle.Filter ( )
idwArticle.Sort ()

// Fin modif JF

sAdrCp = idwCmde.object.adr_cp[1]
sAdrVille = idwCmde.object.adr_ville[1]

bAutoriseCommande = true

// [PC925] - ITSM 227299 PEC Web si produit SRR
f_rechdetpro(ldeb, lFin, idw_Detpro, idwWsin.GetItemNumber(1,"ID_PROD"), "-DP", 256)

// [ITSM255402] -PEC Web si produit Orange Caraibe
If lDeb<=0 Then f_rechdetpro (ldeb, lFin, idw_Detpro, idwWsin.GetItemNumber(1,"ID_PROD"), "-DP", 249)

If lDeb<=0 And &
	Left ( sIdFour, 2 ) = "WB" And &
	sAdrVille <> "MONACO" And &
	( sAdrCp = "00000" Or &
	  Left ( sAdrCp, 2 ) = "97" Or &
	  Left ( sAdrCp, 2 ) = "98" ) &
	Then
	stMessage.sTitre		= "Contrôle d'autorisation"
	stMessage.Bouton		= Ok!
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "GENE156"
	f_Message ( stMessage )
	asPos = "ADR_CP"
	bAutoriseCommande = False
End if
// :[PC925]

if asPos = "" then
	// on recherche si l'option 8 est paramétrée pour le produit
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.object.id_prod[1], '-DP', 8 )

	if lDeb > 0 then
		
		For i = lDeb To lFin
			// type d'artivle paramétré
			sIdCodeCar = idw_DetPro.object.id_code_car[i]
			// mot clé autorisant les DOM-TOM et l'ETRANGER
			sValCar	=	lnvPFCString.of_getkeyvalue ( idw_DetPro.object.val_car[i], 'TERR', ';' )
			
			// si le type d'article paramétré est le même que celui pour la commande en cours
			if sIdCodeCar = sIdTypArt then
			
				if sAdrCp = '00000' then
	
					// si la chaine contient la sous chaine '[ETRANGER]'
					if Pos ( sValCar, '[ETRANGER]' ) = 0  then
						bAutoriseCommande = false // on REFUSE la prestation
						stMessage.sVar[1] = "étrangers"
						exit
					end if
					
				elseif left ( sAdrCp, 2 ) = '98' or left ( sAdrCp, 2 ) = '97' then
					
					// si la chaine contient la sous chaine '[DOM-TOM]' ou  si la ville est MONACO
					if Pos ( sValCar, '[DOM-TOM]' ) = 0 and upper(sAdrVille) <> 'MONACO' then
						bAutoriseCommande = false // on REFUSE la prestation
						stMessage.sVar[1] = "des DOM-TOM"
						exit
					end if
	
				end if
				
			end if
			
		next
		
	else
		// si l'option n'est pas paramétrée et que l'on a un CP ETRANGER OU DOM-TOM
		if sAdrCp = '00000' then
			bAutoriseCommande = false // on REFUSE la prestation
			stMessage.sVar[1] = "étrangers"
		end if
			
		if ( left ( sAdrCp, 2 ) = '98' or left ( sAdrCp, 2 ) = '97' ) and & 
					upper(sAdrVille) <> 'MONACO' then
			bAutoriseCommande = false // on REFUSE la prestation
			stMessage.sVar[1] = "des DOM-TOM"			
		end if
	end if
	
end if

if bAutoriseCommande = false And asPos = "" then
	stMessage.sTitre		= "Contrôle d'autorisation"
	stMessage.Bouton		= Ok!
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "GENE155"
	f_Message ( stMessage )
	asPos = 'ADR_CP'
end if
end subroutine

private subroutine uf_preparervalider_dern_maj_plaf ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerValider_Dern_Maj_Plaf (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 08/07/2004 10:49:34
//* Libellé			: Dernière mises à jour des plafond pour le cas du  672 avant de sortir
//*					  Le cas échéant, le MT_PEC sera retouché si la PEC n'est pas forcée.
//* Commentaires	: JFF   04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
//*
//* Arguments		:
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//*       JFF   17/06/2011   [PC545].[BUG_BGE_721]
//*-----------------------------------------------------------------

u_DataWindow udwNull 
s_Plafond_Pec stPlafPec 
Long lIdGti, lIdDetail, lRowMtPec, lRow, lTotDetail, lCptDet
Decimal {2} dcMtPecReCalculee, dcMtPecActuelle, dcMtLu, dcMtLuMax, dcMtMaxLu
n_cst_string lnv_string // [SUISSE].LOT3 : Gestion msg Err avec monnaie
SetNull ( udwNull )
String sVal, sRech

// Pour le traitement très particulier du 672
lIdGti = -1
lIdDetail = -1
sVal = ""

// [PC545].[BUG_BGE_721]
//	[PC363].[10%]
lRow = idwCmdeSin.Find ( "COD_ETAT <> 'ANN' AND POS ( INFO_FRN_SPB_CPLT, 'APP_INCOMPLET=OUI', 1) >0", 1, idwCmdeSin.RowCount () )
sVal = "[###]"

If lRow > 0 Then
	lnv_string.of_Setkeyvalue ( sVal, "APP_INCOMPLET", "OUI", ";")
End If

// [PC301].[V15_EVOL_VETUSTE]
lTotDetail = idwDetail.iudwDetailSource.RowCount ()
dcMtLu = 0
dcMtMaxLu = 0
For lCptDet = 1 To lTotDetail	
	
	sRech	=		"ID_GTI = "	+ String ( idwDetail.iudwDetailSource.GetItemNumber ( lCptDet, "ID_GTI" ) )	+ " AND " 	+ &
					"ID_DETAIL = "	+ String ( idwDetail.iudwDetailSource.GetItemNumber ( lCptDet, "ID_DETAIL" ) )	+ " AND " 	+ &
					"UPPER ( NOM_ZONE ) = 'MT_MAX_PROPO_PLF722'"
		
	lRow = idwwDivDet.Find ( sRech, 1, idwwDivDet.RowCount () ) 
	If lRow > 0 Then
		dcMtLu = idwwDivDet.GetItemDecimal ( lRow, "VAL_MT" )
		If dcMtLu > dcMtMaxLu Then
			dcMtMaxLu = dcMtLu 
		End If
	End If					
	
Next

If dcMtMaxLu > 0 Then
	lnv_string.of_Setkeyvalue ( sVal, "MT_MAX_PLAF_722", String ( dcMtMaxLu ), ";")
End If
// [PC301].[V15_EVOL_VETUSTE]
// :[PC545].[BUG_BGE_721]

// On relance le calcul des plafond, lequel cette fois prendra en compte le 672
stPlafPec = F_Plafond_Pec ( "3" + sVal, idwwSin, idwWDivsin, udwNull, idwDetail, idwCmde, idwPlafond, idw_DetPro, idw_produit, idwwDivDet, lIdGti, lIdDetail )

// On initialise le montant recalculé
dcMtPecReCalculee = idwDetail.GetItemDecimal ( 1, "MT_VAL_ACHAT" )

If ( dcMtPecReCalculee > stPlafPec.dcPlafEvt And stPlafPec.dcPlafEvt > 0 ) Or dcMtPecReCalculee <= 0 Then dcMtPecReCalculee = stPlafPec.dcPlafEvt
If ( dcMtPecReCalculee > stPlafPec.dcPlafValAch And stPlafPec.dcPlafValAch > 0 ) Or dcMtPecReCalculee <= 0 Then dcMtPecReCalculee = stPlafPec.dcPlafValAch
If ( dcMtPecReCalculee > stPlafPec.dcPlafGti  And stPlafPec.dcPlafGti  > 0 ) Or dcMtPecReCalculee <= 0 Then dcMtPecReCalculee = stPlafPec.dcPlafGti  
If ( dcMtPecReCalculee > stPlafPec.dcPlafValPublique And stPlafPec.dcPlafValPublique > 0 ) Or dcMtPecReCalculee <= 0 Then dcMtPecReCalculee = stPlafPec.dcPlafValPublique
If Left ( stPlafPec.sPlafAutre, 1 ) = "O" Then dcMtPecReCalculee = 0 
If dcMtPecReCalculee <= 0 Then dcMtPecReCalculee = 0

// Un nouveau mt de PEc a été recalculé

// Recherche la PEC non forcée (alt_pec<>'O') car sinon on ne la retouche pas
If ( idwwDivDet.Find ( "ID_GTI = " + String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) ) + &
							  " AND ID_DETAIL = " +  String ( idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
							  " AND UPPER ( NOM_ZONE ) = 'PEC' " + &
							  " AND UPPER ( VAL_LST_CAR ) = 'O'" &
						  , 1, idwwDivDet.RowCount () ) > 0 ) AND &
						  														&
	  ( idwwDivDet.Find ( "ID_GTI = " + String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) ) + &
		  " AND ID_DETAIL = " +  String ( idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
		  " AND UPPER ( NOM_ZONE ) = 'ALT_PEC' " + &
		  " AND UPPER ( VAL_LST_CAR ) <> 'O'" &
	  , 1, idwwDivDet.RowCount () ) > 0 ) Then &

	// une Pec non forcée est trouvée, recherche du montant de Pec (Du row)
	lRowMtPec = idwwDivDet.Find ( "ID_GTI = " + String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) ) + &
							  " AND ID_DETAIL = " +  String ( idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
							  " AND UPPER ( NOM_ZONE ) = 'MT_PEC' " &
						  , 1, idwwDivDet.RowCount () ) 

	// Lecture du montant						  
	If lRowMtPec > 0 Then
		dcMtPecActuelle = idwwDivDet.GetItemDecimal ( lRowMtPec, "VAL_MT" )
	End if 

	// Si le montant recalculé est >=0 et est strictement inférieur au montant actuel 
	// Alors on mets à jour sur le détail et on averti.
	If dcMtPecReCalculee < dcMtPecActuelle And dcMtPecReCalculee >= 0 Then
		idwwDivDet.SetItem ( lRowMtPec, "VAL_MT", dcMtPecReCalculee )		

		/*------------------------------------------------------------------*/
		/* Si au moins une maj, on averti le gestionnaire                   */
		/*------------------------------------------------------------------*/
		stMessage.sTitre  	= "Montant PEC retouché"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode = "COMD447"		
		stMessage.sVar[1] = String (dcMtPecActuelle)
		stMessage.sVar[2] = lnv_string.of_GlobalReplace( stGlb.smonnaiesymboledesire, "\", "" ) // [SUISSE].LOT3 : Gestion msg Err avec monnaie
		stMessage.sVar[3] = String (dcMtPecReCalculee)
		stMessage.sVar[4] = lnv_string.of_GlobalReplace( stGlb.smonnaiesymboledesire, "\", "" ) // [SUISSE].LOT3 : Gestion msg Err avec monnaie
		F_Message ( stMessage )
		
	End If

End IF



end subroutine

private subroutine uf_initialiser2 ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_Initialiser2 (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 03/10/2007
//* Libellé			: Initialisation pouvant être appelé plusieurs fois (sur chgt DataObject)
//* Commentaires	: [ALAPAGE]
//*
//* Arguments		: 
//*					  
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*----------------------------------------------------------------

Long lRow, ll_ret
DataWindowChild	dwChild, dwChild1


/*------------------------------------------------------------------*/
/* Initialisation des transaction.                                  */
/*------------------------------------------------------------------*/
ll_ret = idwArticle.SetTransObject ( SQLCA )

ll_ret = idwCmdeSin.GetChild ( "ID_FOUR", dwChild )
ll_ret = idwArticle.GetChild ( "ID_FOUR", dwChild1)
ll_ret = dwChild.ShareData ( dwChild1 )

ll_ret = idwCmdeSin.GetChild ( "ID_FOUR", dwChild )
ll_ret = idwArticlePrs.GetChild ( "ID_FOUR", dwChild1)
ll_ret = dwChild.ShareData ( dwChild1 )
ll_ret = idwFourn.GetChild ( "ID_CODE_FRN", dwChild1)

ll_ret = dwChild.ShareData ( dwChild1 )

ll_ret = idwCmdeSin.GetChild ( "ID_TYP_ART", dwChild )
ll_ret = idwArticle.GetChild ( "ID_TYP_ART", dwChild1)
ll_ret = dwChild.ShareData ( dwChild1 )

//Migration PB8-WYNIWYG-03/2006 FM
//Une child n'existe plus, inutile!!
//ll_ret = idwCmdeSin.GetChild ( "ID_TYP_ART", dwChild )
//ll_ret = idwArticlePrs.GetChild ( "ID_TYP_ART", dwChild1)
//ll_ret = dwChild.ShareData ( dwChild1 )
//Fin Migration PB8-WYNIWYG-03/2006 FM

ll_ret = idwTypArt.GetChild ( "ID_CODE_ART", dwChild1)
ll_ret = dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* #2                                                               */
/*------------------------------------------------------------------*/
ll_ret = idwLstInter.GetChild ( "COD_MODE_REG", dwChild )
ll_ret = idwCmde.GetChild ( "COD_MODE_REG", dwChild1 )
ll_ret = dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* #2: Chargement des listes info SPB vers Frn                      */
/*------------------------------------------------------------------*/
ll_ret = idwArticlePrs.GetChild ( "INFO_SPB_FRN", dwChild)
ll_ret = dwChild.SetTransObject ( SQLCA )
ll_ret = dwChild.Retrieve ( "-IF" )
ll_ret = idwArticle.GetChild ( "INFO_SPB_FRN", dwChild1 )
ll_ret = dwChild.ShareData ( dwChild1 )

//Migration PB8-WYNIWYG-03/2006 FM
//le partage des données est dépacé ici après le partage des données des child
ll_ret = idwArticle.ShareData ( idwArticlePrs )
ll_ret = idwCmdTypFrn.ShareData ( idwFourn  )
ll_ret = idwCmdTypArt.ShareData ( idwTypArt )
//Fin Migration PB8-WYNIWYG-03/2006 FM


end subroutine

private function string uf_controlergestionedi_o2m (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestionEdi_O2M (PRIVATE)
//* Auteur			: PHG
//* Date				: 10/12/2007
//* Libellé			: Controler Spécifique pour O2M
//* Commentaires	: [O2M]Controle de Gestion pour le fournisseur O2M
//*
//* Arguments		: Long		aalCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//* #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
//* #2	PHG	23/06/2009	[O2M_DIAG_NOMADE]
//* #3	JFF	07/08/2009	[O2M_DIAG_NOMADE].[JFF].[20090807133737597]
//* #4	JFF	07/08/2009	[O2M_DIAG_NOMADE].[JFF].[20090901100945950]
//* #5	PHG	04/01/2010	[02M_DIAG_NOMADE].Lot2  : Point 4, paragraphe 2 et 3.
//* #6	PHG	14/01/2009  [O2M_DIAG_NOMADE].lot2 : Point 6, paragraphe 1.
//* #7   JFF   15/01/2010  [O2M_DIAG_NOMADE].Lot2.JFF
//* #8	PHG	20/10/2010  [O2M_DIAG_NOMADE].lot2 : On prends que la première adr mail de la boutique.
//* #9   JFF   02/03/2010  [MSS_LOT2]
//* --   JFF   07/04/2010  [PC384].[CDISCOUNT]
//*      JFF   21/03/2010  [VDOC3433]
//*      JFF   19/04/2010  [PM72] Modif demandée par Nathalie le 21 Mars 2011
//*      JFF   01/09/2011  [PC10][DIAG_NOMADE]
//		FPI	15/09/2011	[PC413-1] Evolution DP 37
//*      JFF   19/09/2011  [PM82][LOT1]
//*      JFF   12/12/2011  [VDOC4970]
//*      JFF   05/01/2012  [RECUP_DONNEE_O2M]
//       JFF   06/08/2012  [BLCODE]
//       JFF   11/02/2013  [PC896_CDISCOUNT]	
//       JFF   11/02/2013  [PC913_CDISCOUNT][MANTIS6654]
//       JFF   19/02/2013	[VDOC9304_PM82_LOT1]
//       JFF   02/04/2013  [PC929_CDISCOUNT]
//       JFF   26/11/2013  [ITSM18686]
//       JFF   18/02/2014  [PM246][MANTIS10235]
//			FPI	14/04/2014	[PC13448]
// 		JFF	02/05/2014	[VDOC14293]
//       JFF   02/06/2014 [PC929_CDISCOUNT][PC929-2-V3]
//       JFF   17/06/2014 [PM259-1]
//       JFF   02/10/2014 [VDOC15485]
//	      JFF   19/02/2015 [VDOC15533]
//       JFF   09/04/2015 [DT141]
//       JFF   13/07/2015 [PC151270_ORANGE_V3]
//       JFF   23/02/2016 [PM330-1]
//       JFF   19/04/2016 [DT209]
//       JFF   17/05/2016 [PM280-2]
//       JFF   08/07/2016 [VDOC21215]
//       JFF   12/12/2016 [DT269]
//       JFF   17/04/2018 [DT288-4]
// 		JFF	06/08/2018 [MANTIS28873] ajout BVIE
//       JFF   01/10/2018 [PM445-1]
//       JFF   15/05/2019 [DT386_EXTR_AXA]
//       JFF   25/09/2019 [DT386_EXTR_AXA_V8]
//*-----------------------------------------------------------------
String sPos, sFiltreOrig1, sFiltreOrig2, sIdTypArt, sIdRefFour, sCodModeReg, sValCar, sDiagO2M, sDiagMBS, sIdFour, sLibEvt  
String sLibArt, sCodeArt, sRefMat, sVal1 
Long lTot, lRow, lInfoSpbFrn,lIdProd, lTot1, lCpt, lIddetail, lIdEvt
Long lDeb, lFin, lCptDetPro 
Decimal{2}   dcMtValAchat 
Boolean bRibVide, bModeForcagePRS, bModeForcageDiag, bModDegTLS
n_cst_string lnv_string
datawindowchild dwchild // #5	PHG [02M_DIAG_NOMADE].Lot2
long lVal, lVal1 // #5	PHG [02M_DIAG_NOMADE].Lot2
long lPos // #8 PHG [02M_DIAG_NOMADE].Lot2
string sAdrMailBoutique, sVal, sTypApp
Long lIdGti, lGtDuDR
String sSkuIfr
Date dDtePivot 

// [BLCODE]
sIdFour = upper(string(idwArticle.object.id_four[alCpt]))


stMessage.sCode = ""
sPos = ""

lIdGti = idwDetail.GetItemNumber ( 1, "ID_GTI" )
lIdEvt = idwDetail.GetItemNumber ( 1, "ID_EVT" ) // [PM280-2]
sIdRefFour 	= Upper ( idwArticle.GetItemString ( alCpt, "ID_REF_FOUR" ) )
lIdProd 		= idwWsin.GetItemNumber ( 1, "ID_PROD" )
lInfoSpbFrn = idwArticle.object.info_spb_frn[alCpt]

// [RS3220_MODDEGR_TELST]
bModDegTLS = &
idwCmdeSin.Find ( &
		"ID_FOUR = 'O2M' AND " + &
		"COD_ETAT <> 'ANN' AND " + &
		"( ID_TYP_ART NOT IN ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' ) " + &
		"  OR " + &
		"  ( ID_TYP_ART = 'RST' AND POS ( INFO_SPB_FRN_CPLT, 'RST_CMDE+SUIVI=OUI' ) > 0 ) " + &
		") " + &
		" AND STATUS_GC NOT IN ( 176, 239, 203 )" + &
		" AND POS ( INFO_SPB_FRN_CPLT, 'RS3220=TLS' ) > 0" &		
		, 1, idwCmdeSin.RowCount () ) > 0 

sIdTypArt = idwArticle.GetItemString ( alCpt, "ID_TYP_ART" ) 	
If sIdTypArt <> "EDI" Then Return ""

// [RECUP_DONNEE_O2M]		
If lIdGti = 44 Then
	Choose Case sIdRefFour 		
		Case "DONNEES_A_RECUPERER"		
			// Ok
		Case Else
			stMessage.sCode = "COMD696"
			stMessage.bouton = Ok!
			F_Message ( stMessage )
			sPos = "ALT_CHOIX"
			Return "G" + "ALT_CHOIX"
		
	End Choose
End If		

// [PM246][MANTIS10235]
// [PC151270_ORANGE_V3]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 94 )
For lCptDetPro = lDeb To lFin
	sVal = lnv_string.of_getkeyvalue ( idw_DetPro.GetItemString ( lCptDetPro, "VAL_CAR" ), "COD_DW", ";")
	
	// [PM280-2] lIdEvt <> 1426
	Choose Case sVal 
		Case "ORANGE_V3", "ORANGE_V2BIS", "ORANGE_V3BIS", "ORANGE_V3TER"
			If ( sIdReffour = "A_DIAGNOSTIQUER" Or sIdReffour = "PEC_A_RECYCLER" ) And Not gAutoriseDiag And lIdEvt <> 1426 Then
				// On coupe, vu avec Lisette et ML Gasnier suite mantis 10235 le 17/12/2014

				If Not ( sIdReffour = "PEC_A_RECYCLER" And &
					idwCmdeSin.Find("ID_REF_FOUR = 'A_DIAGNOSTIQUER'", 1, idwCmdeSin.RowCount ()) >0 ) Then
					stMessage.sCode = "COMD846"
					stMessage.bouton = Ok!
					F_Message ( stMessage )
					sPos = "ALT_CHOIX"
					Return "G" + "ALT_CHOIX"
				End If
		
			End If
	End Choose 
Next
// [PM246][MANTIS10235]	


// #5 [MSS_LOT2]
If idwCmdeSin.Find("ID_FOUR = 'MS1' AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount() ) > 0 Then
	stMessage.sCode = "COMD615" 
	stMessage.bouton = Ok!
	stMessage.sVar[1] = "O2M"	
	stMessage.sVar[2] = "MSS"	
	F_Message ( stMessage )
	sPos = "ALT_CHOIX"
	Return "G" + "ALT_CHOIX"
End If
// #5 [MSS_LOT2]

// [PM82][LOT1]
bModeForcagePRS = idwCmdeSin.Find ( "ID_TYP_ART = 'PRS' AND STATUS_GC IN ( 153, 154 ) AND COD_ETAT NOT IN ( 'RFO', 'RPC', 'ANN')", 1, idwCmdeSin.RowCount() )  > 0
// [PM82][LOT1]

// [PC929_CDISCOUNT][PC929-2-V3]
If Not bModeForcagePRS Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 235 )
	If lDeb > 0 Then
		If lnv_string.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "TVSUP32P", ";") = "OUI" Then
			Choose Case isTypApp
				Case "TL7", "TLO", "TPS"
					bModeForcagePRS = True
			End Choose
		End If
	End If
End If 
// [PC929_CDISCOUNT][PC929-2-V3]

// [PM330-1]
If Not bModeForcagePRS Then	
	bModeForcagePRS = idwCmdeSin.Find ( "ID_TYP_ART = 'PRS' AND STATUS_GC IN ( 21, 23 ) AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount() )  > 0		
End If

// [PM280-2]
If Not bModeForcagePRS Then	
	bModeForcagePRS = idwDetail.GetItemNumber ( 1, "ID_EVT" ) = 1426
End IF	

// [DT209]
If F_CLE_A_TRUE ( "DT209" ) Then
	If Not bModeForcagePRS Then		
		bModeForcagePRS = idwDetail.GetItemNumber ( 1, "ID_EVT" ) = 1424
	End If
End If

// [PM445-1]
If Not bModeForcagePRS Then		
	bModeForcagePRS = idwDetail.GetItemNumber ( 1, "ID_EVT" ) = 1439
End If


// [VDOC9304_PM82_LOT1]
// [VDOC15485]
bModeForcageDiag = False


// #4 [O2M_DIAG_NOMADE].[JFF].[20090901100945950]
If idwDetail.GetItemNumber ( 1, "ID_EVT" ) <> 1083 And Not bModeForcagePRS Then
	stMessage.sCode = "COMD550" 
	stMessage.bouton = Ok!
	F_Message ( stMessage )
	sPos = "ALT_CHOIX"
	Return "G" + "ALT_CHOIX"
End If
// :#4 [O2M_DIAG_NOMADE].[JFF].[20090901100945950]			


// #2 [O2M_DIAG_NOMADE] 1/
// Si le Appareil Non paramétré sur Option DP/95 => Message Bloquant : "Pour ce produit, ce type d'appareil ne rentre pas dans ce process"
// [PM82][LOT1]
// [VDOC9304_PM82_LOT1]
If Not bModeForcagePRS And Not bModeForcageDiag Then
	if idw_DetPro.Find(   "ID_PROD="+ string(lIdProd) +                         &
								" AND ID_CODE_DP=95" +                                 &
								" AND POS(VAL_CAR, 'ACTION="+sIdRefFour+";', 1)>0" +   &
								" AND POS(VAL_CAR, 'TYP_APP="+isTypApp+";', 1)>0"       &
								, 1, idw_DetPro.rowCount()+1) = 0 Then
		stMessage.sCode = "COMD531" // [O2M_DIAG_NOMADE] Message : "Ce type d'appareil ne rentre pas dans ce process"
		stMessage.bouton = Ok!
		F_Message ( stMessage )
		sPos = "ALT_CHOIX"
		Return "G" + "ALT_CHOIX"
	End If
	
	// [O2M].372, Note 265, Point 1 : On vérifie que l'action choisie est cohérente avec le paramétrage du produit
	if idw_DetPro.Find(	"ID_PROD="+ string(lIdProd) + 								&
								" AND POS(VAL_CAR, 'ACTION="+sIdRefFour+";', 1)>0" + 	&
								" AND POS(VAL_CAR, 'TYP_APP="+isTypApp+";', 1)>0"		&
								, 1, idw_DetPro.rowCount()+1) = 0 Then
		stMessage.sCode = "COMD463" // Msg : "Information Cochée non autorisée pour ce produit.@Veuillez sélectionner une autre information."
		stMessage.bouton = Ok!
		F_Message ( stMessage )
		sPos = "ALT_CHOIX"
		Return "G" + "ALT_CHOIX"
	End If
End If

// [PC10][DIAG_NOMADE]
f_rechdetpro(lDeb, lFin, idw_DetPro, lIdProd, "-DP", 46 )
If lDeb > 0 Then
	sValCar = idw_DetPro.GetItemString ( lDeb, "VAL_CAR" )
	sDiagO2M = lnv_string.of_Getkeyvalue( sValCar, "DIAG_O2M", ";" )
	If Trim ( sDiagO2M ) <> "" Then
		If Not Pos ( sDiagO2M, "#" + isTypApp + "#", 1 ) > 0 Then
			sDiagMBS = lnv_string.of_Getkeyvalue( sValCar, "DIAG_MBS", ";" )
			If Not Pos ( sDiagMBS, "#" + isTypApp + "#", 1 ) > 0 Then
				stMessage.sCode = "COMD664" // 
				stMessage.bouton = Ok!
				F_Message ( stMessage )
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"
			Else
				stMessage.sCode = "COMD663" // 
				stMessage.bouton = Ok!
				F_Message ( stMessage )
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"
				
			End If
		End if 
	End If
End If
// [PC10][DIAG_NOMADE]	

// [O2M].378 : Controle du RIB SI Mode de Reglement = "Virement Auto", Info Spb Frn 415, et RibVide
sCodModeReg =  idwCmde.GetItemString ( 1, "COD_MODE_REG" ) 
bRibVide    = 	lnv_string.of_isempty ( idwCmde.GetItemString ( 1, "RIB_BQ" ) ) Or idwCmde.GetItemString ( 1, "RIB_BQ" ) = Fill ( "0", 5 ) Or &
					lnv_string.of_isempty ( idwCmde.GetItemString ( 1, "RIB_GUI" ) ) Or idwCmde.GetItemString ( 1, "RIB_GUI" ) = Fill ( "0", 5 ) Or &
					lnv_string.of_isempty ( idwCmde.GetItemString ( 1, "RIB_CPT" ) ) Or idwCmde.GetItemString ( 1, "RIB_CPT" ) = Fill ( "0", 11 ) Or&
					lnv_string.of_isempty ( idwCmde.GetItemString ( 1, "RIB_CLE" ) ) 

// JFF   19/04/2010  [PM72] Modif demandée par Nathalie le 21 Mars 2011
//If sIdRefFour = "A_DIAGNOSTIQUER" And Upper ( sCodModeReg ) = "VA" And bRibVide Then
//		Choose Case lInfoSpbFrn 
//			Case 415, 905, 910, 915, 920, 936, 941 //* #1 [FNAC_PROD_ECH_TECH]
//				stMessage.sCode = "COMD466"
//				F_Message ( stMessage )
//				Return "D" + "RIB_BQ"
//		End Choose
//End If
//

// #2 [O2M_DIAG_NOMADE] 2/
// -Si Produit CD-discount + Fourn O2M + Action A diagnostiquer + Val Achat < 200 Euro
//  Interdiction de process => Process interdit pour les valeurs d'achat strictement inférieures  200 Euro
f_rechdetpro(lDeb, lFin, idw_DetPro, lIdProd, "-DP", 37 )
dcMtValAchat = idwDetail.GetitemDecimal( 1, "MT_VAL_ACHAT")
if lDeb > 0 Then

	// [PC896_CDISCOUNT]
	sVal = lnv_string.of_getkeyvalue ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")
	If sVal = "TACHE_DECH" Then
		if sIdRefFour = "A_DIAGNOSTIQUER" and dcMtValAchat < 300 Then
	
			stMessage.sCode = "COMD771"
			stMessage.sVar[1] = "300"
			stMessage.bouton = Ok!
	
			F_Message ( stMessage )
			sPos = "ALT_CHOIX"
			Return "G" + "ALT_CHOIX"
			
		End If		
	End If
	// [PC896_CDISCOUNT]

	// [PC13448]
	if sVal="PRO" Then
			if sIdRefFour = "A_DIAGNOSTIQUER" and dcMtValAchat > 500 Then
				stMessage.sCode = "COMD861"
				stMessage.sVar[1] = "500"
				stMessage.bouton = Ok!
		
				F_Message ( stMessage )
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"
				
			End if
	End if
	// :[PC13448]
	
	// [PC413-1] - Exclusion de l'IPad à cette règle
	sVal =lnv_string.of_getkeyvalue( idw_DetPro.GetItemString(lDeb,"VAL_CAR"), "EXCLURE_IPAD", ";")
	sTypApp=""

	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then 
		sTypApp=	idwWDivsin.GetItemString(lRow,"VAL_CAR")
	End if

	// [PC913_CDISCOUNT][MANTIS6654]
	sVal1 = ""
	sVal1 = lnv_string.of_getkeyvalue ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")
	// :[PC913_CDISCOUNT][MANTIS6654]

	// [PC913_CDISCOUNT][MANTIS6654]
	// [VDOC21215]
	Choose Case sVal1
		Case "BRICO_JARDI", "GTI_SERENITE", "TACHE_DECH"
			// Rien
		Case Else
			If sVal <> "OUI" Or Not (sTypApp="TPC" and isMarqPortAdh="APPLE" and Left(ismodlportadh ,4) = "IPAD") Then
			// :[PC413-1]
			
				if sIdRefFour = "A_DIAGNOSTIQUER" and dcMtValAchat >= 600 Then
			
					stMessage.sCode = "COMD617"
					stMessage.sVar[1] = "600"
					stMessage.bouton = Ok!
			
					F_Message ( stMessage )
					sPos = "ALT_CHOIX"
					Return "G" + "ALT_CHOIX"
					
				End If
				// [PC384].[CDISCOUNT]	
			End If
	End choose// [PC413-1]
End if
// :#2 [O2M_DIAG_NOMADE]

// [PC13321-3]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 266 )	
If lDeb > 0 And sIdRefFour = "A_DIAGNOSTIQUER"  Then
	If lnv_string.of_getkeyvalue( idw_DetPro.GetItemString(lDeb,"VAL_CAR") , "VARIANTE", ";") = "BRUN" Then
		lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'TELEDIAG_OK'", 1, idwWDivSin.RowCount () ) 
		If lRow > 0 Then 
			If Upper ( idwWDivSin.GetItemString ( lRow, "VAL_ALT" ) ) = "O" Then
				stMessage.sCode = "COMD965"
				stMessage.bouton = OK!
				F_Message ( stMessage )	
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"					
			End If
		End If
	End If
End If
// [PC13321-3]

// [PC13321][MANTIS14551]
dcMtValAchat = idwDetail.GetitemDecimal( 1, "MT_VAL_ACHAT")
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 266 )	
If lDeb > 0 And sIdRefFour = "A_DIAGNOSTIQUER" And dcMtValAchat >= 200 &
	And lnv_string.of_getkeyvalue( idw_DetPro.GetItemString(lDeb,"VAL_CAR") , "VARIANTE", ";") <> "BRUN" Then
	stMessage.sCode = "COMD904"
	stMessage.sVar[1] = "200"
	stMessage.bouton = OK!
	F_Message ( stMessage )	
	sPos = "ALT_CHOIX"
	Return "G" + "ALT_CHOIX"
End If
	

// [PM82][LOT1]
// [DT209]
If bModeForcagePRS Then
	// [PM280-2]
	Choose Case sIdRefFour
		Case "REFUSE_A_REEXP", "A_REPARER_FORCE", "A_DESOXYDER_FORCE", "BON_EMARGE", "CONTEST_SUR_REMPL", "PEC_A_RECYCLER", "NE_PAS_REMPLACER", "A_REMPLACER"
			// Ok on a le droit
		Case Else
			stMessage.sCode = "COMD669" 
			stMessage.bouton = Ok!
			sPos = "ALT_CHOIX"
			F_Message ( stMessage )
			Return "G" + "ALT_CHOIX"

	End Choose	
Else 
	Choose Case sIdRefFour
		Case "A_REPARER_FORCE", "A_DESOXYDER_FORCE"
			stMessage.sCode = "COMD670" 
			stMessage.bouton = Ok!
			F_Message ( stMessage )
			sPos = "ALT_CHOIX"
			Return "G" + "ALT_CHOIX"

	End Choose
End If
// [PM82][LOT1]


Choose Case sIdRefFour 
	Case "A_DIAGNOSTIQUER"
//		if idwCmdeSin.RowCount() > 0 then //[O2M].391 : On ignore toute prestation annulée
		if idwCmdeSin.Find( "COD_ETAT <>'ANN'", 1, idwCmdeSin.RowCount() + 1 ) > 0 then
			stMessage.sCode = "COMD456" // [O2M] : Message : Vous choisissez un flux de DIAGNOSTIQUE alors que d'autres prestations existent déjà sur le dossier, êtes vous sûr de votre choix ?
			stMessage.bouton = YesNo!
			if F_Message ( stMessage ) <> 1 Then
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"
			End If
		// [O2M].381 : Vérification qu'il n'y a pas de diagnostic déja émis et clos.
		ElseIf idwCmdeSin.Find("ID_FOUR IN ('O2M', 'BLC') AND ID_REF_FOUR<>'A_DIAGNOSTIQUER'", 1, idwCmdeSin.RowCount()+1 ) > 0 Then
			stMessage.sCode = "COMD464" // [O2M] : Message : Vous avez déjà émis un ou plusieurs flux de clôture avec O2M sur ce dossier.@Souhaitez-vous vraiment émettre un flux demandant un diagnostique ?"
			stMessage.bouton = YesNo!
			if F_Message ( stMessage ) <> 1 Then
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"

			End If
// [FNAC_PROD_ECH_TECH].[20090330152547023]			
		End If

		lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'RECUP_DONNEES'", 1, idwWDivSin.RowCount () ) 
		If lRow > 0 Then
			sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
			If sVal = "O" Then 
				sVal = "OUI"
			Else
				sVal = "NON"
			End If
			
			lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "RECUP_DONNEES", sVal, ";")		
			
		End If

		//[DOC14293]
		lRow = idwWDivsin.Find ( "NOM_ZONE = 'code_verrou_sherpa_script'", 1, idwWDivSin.RowCount () )
		If lRow > 0 Then 
			 sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
			 If IsNull ( sVal ) Then sVal = ""
			 If Len ( sVal ) > 0 Then
				 lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_VERROU_ORIG", sVal, ";")
			 End If
		End If	
		//[VDOC14293]

		// [PM259-1]
		lRow = idwWDivsin.Find ( "NOM_ZONE = 'code_parental'", 1, idwWDivSin.RowCount () )
		If lRow > 0 Then 
			 sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
			 If IsNull ( sVal ) Then sVal = ""
			 If Len ( sVal ) > 0 Then
				 lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_PARENTAL", sVal, ";")
			 End If
		End If	
		// [PM259-1]	

		//	[VDOC15533]
		sSkuIfr = Space ( 35 )
		SQLCA.PS_S_SKU_IFR ( isMarqPortAdh, isModlPortAdh, sSkuIfr )
		If IsNull ( sSkuIfr ) Then sSkuIfr = ""
		
		lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "SKU_IFR", sSkuIfr, ";")
	
			// [DT269]
/*			
		If F_CLE_A_TRUE ( "DT269" ) Then
			lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'TAILLE_ECRAN'", 1, idwWDivSin.RowCount () )
			If lRow > 0 Then 
				sVal = idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" )
				If Len ( sVal ) = 3 And sVal <> "AC0" Then
					lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "TAILLE_TV", sVal, ";")			
				End If 
			End If
		End If
*/

		// [DT386_EXTR_AXA]
		If lIdGti = 54 Then
				lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "BUYBACK", "OUI", ";")						
		End If

		// [DT386_EXTR_AXA_V8]
		/*
		If F_CLE_NUMERIQUE ( "DT386_EXTR_AXA" ) >= 2 Then

			lRow = idwWDivsin.Find ( "NOM_ZONE = 'type_pce_identite'", 1, idwWDivSin.RowCount () )
			If lRow > 0 Then 
				sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
				If IsNull ( sVal ) Then sVal = ""
				If Len ( sVal ) > 0 Then
				 lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "TYP_PCE_IDENT", sVal, ";")
				End If				
			End If

			lRow = idwWDivsin.Find ( "NOM_ZONE = 'autorite_pce_identite'", 1, idwWDivSin.RowCount () )
			If lRow > 0 Then 
				sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
				If IsNull ( sVal ) Then sVal = ""
				If Len ( sVal ) > 0 Then
				 lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "AUTOR_PCE_IDENT", sVal, ";")
				End If				
			End If

			lRow = idwWDivsin.Find ( "NOM_ZONE = 'num_pce_identite'", 1, idwWDivSin.RowCount () )
			If lRow > 0 Then 
				sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
				If IsNull ( sVal ) Then sVal = ""
				If Len ( sVal ) > 0 Then
				 lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "NUM_PCE_IDENT", sVal, ";")
				End If				
			End If

			lRow = idwWDivsin.Find ( "NOM_ZONE = 'dte_delivrance_pi'", 1, idwWDivSin.RowCount () )
			If lRow > 0 Then 
				sVal = String ( idwWDivSin.GetItemDateTime ( lRow, "VAL_DTE" ), "dd/mm/yyyy" ) // [PI056].20190926
				If IsNull ( sVal ) Then sVal = ""
				If Len ( sVal ) > 0 Then
				 lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "DTE_DELIVR_PI", sVal, ";")
				End If				
			End If
			
			lRow = idwWDivsin.Find ( "NOM_ZONE = 'dte_fin_val_pi'", 1, idwWDivSin.RowCount () )
			If lRow > 0 Then 
				sVal = String ( idwWDivSin.GetItemDateTime ( lRow, "VAL_DTE" ), "dd/mm/yyyy" ) // [PI056].20190926
				If IsNull ( sVal ) Then sVal = ""
				If Len ( sVal ) > 0 Then
				 lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "DTE_FIN_VAL_PI", sVal, ";")
				End If				
			End If				

		End IF 
		*/

		// [BLCODE]
		Choose Case sIdFour
			Case "BLC"
				This.uf_message_process_blc ( alCpt, lInfoSpbFrn )
			

				sFiltreOrig1 = idwLstDetail.Describe ("DataWindow.Table.filter") 
				If sFiltreOrig1 = "?" Then sFiltreOrig1 = ""
	
				idwDivDetGti.SetFilter ( "UPPER ( NOM_ZONE ) = 'PRIS_PRESTA_BLCODE' AND VAL_NBRE = " + String ( ilMarquaGeBLCODE ) )
				idwDivDetGti.Filter ( )
				idwDivDetGti.Sort()
				
		
				lTot1 = idwDivDetGti.RowCount()
				sRefMat = ""
				For lCpt = 1 To lTot1 
					
					lIdGti = idwDivDetGti.GetItemNumber ( lCpt, "ID_GTI" ) 
					lIddetail = idwDivDetGti.GetItemNumber ( lCpt, "ID_DETAIL" ) 
					
					lRow = idwLstDetail.Find ( "ID_GTI = " + String ( lIdGti ) + " AND ID_DETAIL = " + String ( lIddetail ), 1, idwLstDetail.RowCount() ) 
					
					If lRow > 0 Then
						sLibEvt  = Upper ( idwLstDetail.Describe ( "Evaluate ('LookUpDisplay ( ID_EVT )', " + String ( lRow ) + ")" ) )
						If IsNull ( sLibEvt ) Then sLibEvt = ""
						sLibEvt = Trim ( sLibEvt )

						idwDivDetGti.SetFilter ( "ID_GTI = " + String ( lIdGti ) + " AND " + &
													  "ID_DETAIL = " + String ( lIddetail ) + " AND " + & 
													  "UPPER ( NOM_ZONE ) = 'LIB_ARTICLE'" )
						idwDivDetGti.Filter ( )
						
						If idwDivDetGti.RowCount () > 0 Then
							sLibArt = idwDivDetGti.GetItemString ( 1, "VAL_CAR" )
						End If
						If IsNull ( sLibArt ) Then sLibArt = ""
						sLibArt = Trim ( sLibArt )


						idwDivDetGti.SetFilter ( "ID_GTI = " + String ( lIdGti ) + " AND " + &
													  "ID_DETAIL = " + String ( lIddetail ) + " AND " + & 
													  "UPPER ( NOM_ZONE ) = 'CODE_ARTICLE'" )
						idwDivDetGti.Filter ( )
						
						If idwDivDetGti.RowCount () > 0 Then
							sCodeArt = idwDivDetGti.GetItemString ( 1, "VAL_CAR" )
						End If
						If IsNull ( sCodeArt ) Then sCodeArt = ""
						sCodeArt = Trim ( sCodeArt )

						idwDivDetGti.SetFilter ( "UPPER ( NOM_ZONE ) = 'PRIS_PRESTA_BLCODE' AND VAL_NBRE = " + String ( ilMarquaGeBLCODE ) )
						idwDivDetGti.Filter ( )
						idwDivDetGti.Sort()
						
						sRefMat += "[" + sLibEvt + "/" + sCodeArt + "/" + sLibArt + "]"
						
					End If

				Next 

				idwDivDetGti.SetFilter ( sFiltreOrig1 )
				idwDivDetGti.Filter ( )
				idwDivDetGti.Sort()

				
				lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "MARQUAGE", String ( ilMarquaGeBLCODE ), ";")
				lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "REF_MAT", sRefMat, ";")

			// [DT141] Ajout SBE
			Case "O2M", "MTT", "SBE"
				uf_message_process_o2m( alCpt, lInfoSpbFrn )
				
		End Choose
		
// :[FNAC_PROD_ECH_TECH].[20090330152547023]			

		//
	case "PEC_A_RECYCLER", "REFUSE_A_REEXP"
		// [O2M].382 : Vérification qu'il y a bien un diagnostic déja émis et clos avant de recycler ou refuser.
		
		// [ITSM18686]
		// [PC13348&13408]
		// [VDOC15485]
		// [DT141] ajout SBE
		If idwCmdeSin.Find("ID_FOUR IN ('O2M', 'BLC', 'MTT', 'SBE' ) AND ID_REF_FOUR='A_DIAGNOSTIQUER' AND STATUS_GC > 0 AND COD_ETAT = 'RFO'", 1, idwCmdeSin.RowCount()+1 ) = 0 Then
			// [PM82][LOT1]
			If Not bModeForcagePRS Then
				stMEssage.sVar[1] = sIdRefFour
				stMessage.sCode = "COMD465" // [O2M] : Message : "Vous ne pouvez émettre cette action (#) vers O2M sans avoir précédemment émis une demande de diagonostique."
				stMessage.bouton = Ok!
				F_Message ( stMessage )
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"
			End If
		End If
		
		// [VDOC6381]
		If idwCmdeSin.Find("ID_FOUR IN ('O2M', 'BLC') AND ID_REF_FOUR='A_DIAGNOSTIQUER' AND INFO_SPB_FRN = 964", 1, idwCmdeSin.RowCount()+1 ) > 0 Then
			stMEssage.sVar[1] = sIdRefFour
			stMessage.sCode = "COMD700" // [O2M] : Message : "Vous ne pouvez émettre cette action (#) vers O2M sans avoir précédemment émis une demande de diagonostique."
			stMessage.bouton = Ok!
			F_Message ( stMessage )
			sPos = "ALT_CHOIX"
			Return "G" + "ALT_CHOIX"
		End If
		// [VDOC6381]		
	
	// [PC929_CDISCOUNT][PC929-2-V3]	
		If sIdRefFour = "REFUSE_A_REEXP" Then
			If idwCmdeSin.Find ( "ID_FOUR IN ('O2M', 'BLC') AND STATUS_GC = 170 AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount()+1 ) > 0 Then
				stMessage.sCode = "COMD872" 
				stMessage.bouton = Ok!
				F_Message ( stMessage )
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"
				
			End If
		End If


		// [DT288-4]
		// [MANTIS28873] ajout BVIE
		If sIdRefFour = "REFUSE_A_REEXP" And idwCmdeSin.Find ( "ID_FOUR = 'COR' AND COD_ETAT <> 'ANN' AND STATUS_GC = 21 AND ( POS ( COMMENT_FRN, '[BVIE]' ) > 0 OR POS ( COMMENT_FRN, '[BVID]' ) > 0 OR POS ( COMMENT_FRN, '[BVIP]' ) > 0 OR POS ( COMMENT_FRN, '[BVIT]' ) > 0 )", 1, idwCmdeSin.RowCount ()) > 0 Then

			dDtePivot = Today ()
			dDtePivot = F_PLUS_DATE ( dDtePivot, -30, "J" )

			// [MANTIS28873] ajout BVIE
			lRow = idwCmdeSin.Find ( "ID_FOUR = 'COR' AND COD_ETAT <> 'ANN' AND STATUS_GC = 21 AND ( POS ( COMMENT_FRN, '[BVIE]' ) > 0 OR POS ( COMMENT_FRN, '[BVID]' ) > 0 OR POS ( COMMENT_FRN, '[BVIP]' ) > 0 OR POS ( COMMENT_FRN, '[BVIT]' ) > 0 )  AND DTE_ENV_CLI >= DATETIME ( '" + String ( dDtePivot, "yyyy-mm-dd hh:mm:ss" ) + "')", 1, idwCmdeSin.RowCount ())

			SQLCA.PS_S01_AUTORISATION ( 9, stGlb.sCodOper, lIdprod, lGtDuDR )

			If lRow <= 0 And lGtDuDR > 0 Then
				stMessage.sTitre		= "DT288 : Condition commande CORDON"
				stMessage.Icon			= information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= YesNo!
				stMessage.sCode = "COMD993"
				If F_Message ( stMessage ) = 2 Then 
					Return "G" + "RIB_BQ"		
				End If 
			End IF 
		
			If lRow <= 0 And lGtDuDR = 0 Then
				stMessage.sTitre		= "DT288 : Condition commande CORDON"
				stMessage.Icon			= information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= Ok!
				stMessage.sCode = "COMD971"
				F_Message ( stMessage )
				Return "G" + "RIB_BQ"		
			End IF 
		End If
		
	case "A_RECUP_A_RECYCLER" //#5 [02M_DIAG_NOMADE].Lot2  : Point 4, paragraphe 2 et 3
		// #5 [O2M_DIAG_NOMADE].Lot2 : Paragraphe 2 : Sur une presta "A_RECUP_A_RECYCLER" ayant le process 435, Vérification que le code boutique est saisi.
		If lInfoSpbFrn=435 Or lInfoSpbFrn=1502 Then
// #7 [O2M_DIAG_NOMADE].Lot2.JFF
//			If lnv_string.of_isempty( string(idw_Wsin.object.id_orian_boutique[1]) ) Then // [O2M_DIAG_NOMADE].Lot 2 Point 4, Paragraphe 2
			If lnv_string.of_isempty( string(idwWsin.object.id_orian_boutique[1]) ) Then // [O2M_DIAG_NOMADE].Lot 2 Point 4, Paragraphe 2
				stMessage.sCode = "COMD584" // [O2M] : Message : "Vous devez saisir une boutique sur la grille des sinistres."
				stMessage.bouton = Ok!
				F_Message ( stMessage )
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"
			Else
				// #5 [O2M_DIAG_NOMADE].Lot2 Paragraphe 3 :
				// Lecture de l'adresse mail de la boutique et placement de celle-ci dans la variable d'instance.
				// Si l'adresse mail n'existe pas, message et blocage.
				
				// Lecture adresse mail de la boutique.
				idwWsin.GetChild ( "ID_ORIAN_BOUTIQUE", dwChild )
				lVal = idwWsin.GetItemNumber ( 1, "ID_ORIAN_BOUTIQUE" )
				If IsNull ( lVal ) Then 
					sAdrMailBoutique = ""
				Else
					lRow = dwChild.Find ( "ID_BOUTIQUE = " + String ( lVal ), 1, dwChild.Rowcount () )
					If lRow > 0 Then
						sAdrMailBoutique = dwChild.GetItemString ( lRow, "ADR_MAIL" )
						// #8 [O2M_DIAG_NOMADE].lot2 On ne prends que la première adresse mail.
						lPos = Pos(sAdrMailBoutique, ",")
						if lPos > 0 Then
							sAdrMailBoutique = Left ( sAdrMAilBoutique, lPos - 1 )
						End If
					Else
						sAdrMailBoutique = ""
					End If
				End If
				
				// Verif si adresse mail Ok
				if lnv_string.of_isempty( sAdrMailBoutique) Then
					stMessage.sCode = "COMD585"
					stMessage.bouton = Ok!
					F_Message ( stMessage )
					sPos = "ALT_CHOIX"
					Return "G" + "ALT_CHOIX"
				Else // adr mail ok, on la mémorise avec le code boutique associé. #5 [O2M_DIAG_NOMADE].Lot2 Paragraphe 4
					lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_BTQ_REL", string(lVal), ";")
					lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "MAIL_BTQ_REL", trim(sAdrMailBoutique), ";")
				End If
			End If
		End If

// [RECUP_DONNEE_O2M]		
	Case "DONNEES_A_RECUPERER"		
		
		If lIdGti <> 44 Then
			stMessage.sCode = "COMD695"
			stMessage.bouton = Ok!
			F_Message ( stMessage )
			sPos = "ALT_CHOIX"
			Return "G" + "ALT_CHOIX"
		End If
		
		lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'RECUP_DONNEES'", 1, idwWDivSin.RowCount () ) 
		If lRow > 0 Then
			sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
			If sVal = "O" Then 
				sVal = "OUI"
			Else
				sVal = "NON"
			End If

			lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "RECUP_DONNEES", sVal, ";")					
			
		End If

		If lIdGti = 44 Then
			lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'RECUP_MATERIEL'", 1, idwWDivSin.RowCount () ) 
			If lRow > 0 Then
				sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
				If sVal = "O" Then 
					sVal = "OUI"
				Else
					sVal = "NON"
				End If
		
				lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "RECUP_APP_PAR_ASSURE", sVal, ";")						
			End If
		End If
		
		uf_message_process_o2m( alCpt, lInfoSpbFrn )

	// [PM280-2]
	Case "CONTEST_SUR_REMPL"				

				// [RS3220_MODDEGR_TELST]
		If bModDegTLS Then
			stMessage.sCode = "COMD998"
			stMessage.icon  = Exclamation!
			stMessage.sTitre = "RS3220 : O2M=>TLS Mode dégradé"
			stMessage.bouton = OK!
			F_Message ( stMessage )	
			sPos = "ALT_CHOIX"
			Return "G" + "ALT_CHOIX"		
		Else 
			uf_message_process_o2m( alCpt, lInfoSpbFrn )				
		End If  


	// [PM445-1]
	Case "NE_PAS_REMPLACER"
		lVal = idwCmdeSin.Find ( &
				"ID_REF_FOUR IN ( 'A_REPARER', 'A_DESOXYDER', 'A_DIAGNOSTIQUER' ) AND " + &
				"ISNULL ( DTE_RCP_FRN ) AND LEN ( ID_BON_TRANSP ) > 0 AND " + &
				"POS ( INFO_FRN_SPB_CPLT, 'PRBLE_LIVRAISON' ) > 0 AND " + &
				"POS ( INFO_FRN_SPB_CPLT, 'PERTE_ALLER' ) > 0 AND " + &
				"COD_ETAT IN ( 'ECT', 'ECL' )", &
				1, idwCmdeSin.RoWCount () )
	
		If lVal > 0 Then 
	
			lVal = idwCmdeSin.GetItemNumber ( lVal, "ID_SEQ" )
			
			lVal = idwCmdeSin.Find ( &
					"( ID_TYP_ART NOT IN ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' ) " + &
					"  OR " + &
					"  ( ID_TYP_ART = 'RST' AND POS ( INFO_SPB_FRN_CPLT, 'RST_CMDE+SUIVI=OUI' ) > 0 ) " + &
					") " + &
					" AND ( STATUS_GC NOT IN ( 176 ) AND COD_ETAT <> 'ANN' ) " + &
					" AND ID_SEQ > " + String ( lVal ) &					
					, 1, idwCmdeSin.RowCount ()) 			
					
			lVal1 = idwLstDetail.Find ( "ID_I_REG = 0 AND COD_ETAT IN ( 500, 600 )", 1, idwLstDetail.RowCount() )

			If lVal <= 0 And lVal1 <= 0 Then
				stMessage.sCode = "COMD976"
				stMessage.bouton = YESNO!
				stMessage.icon  = Exclamation!
				If F_Message ( stMessage ) = 2 Then
					sPos = "ALT_CHOIX"
					Return "G" + "ALT_CHOIX"		
				End If 
		   End IF
		End If			

			
			
	// [PM445-1]
	Case "A_REMPLACER"
		
		lVal = idwCmdeSin.Find ( &
				"ID_REF_FOUR IN ( 'A_REPARER', 'A_DESOXYDER', 'A_DIAGNOSTIQUER' ) AND " + &
				"ISNULL ( DTE_RCP_FRN ) AND LEN ( ID_BON_TRANSP ) > 0 AND " + &
				"POS ( INFO_FRN_SPB_CPLT, 'PRBLE_LIVRAISON' ) > 0 AND " + &
				"POS ( INFO_FRN_SPB_CPLT, 'PERTE_ALLER' ) > 0 AND " + &
				"COD_ETAT IN ( 'ECT', 'ECL' )", &
				1, idwCmdeSin.RoWCount () )
	
		If lVal > 0 Then 
	
			lVal = idwCmdeSin.GetItemNumber ( lVal, "ID_SEQ" )
			
			lVal = idwCmdeSin.Find ( &
					"( ID_TYP_ART NOT IN ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' ) " + &
					"  OR " + &
					"  ( ID_TYP_ART = 'RST' AND POS ( INFO_SPB_FRN_CPLT, 'RST_CMDE+SUIVI=OUI' ) > 0 ) " + &
					") " + &
					" AND ( STATUS_GC NOT IN ( 176 ) AND COD_ETAT <> 'ANN' ) " + &
					" AND ID_SEQ > " + String ( lVal ) &					
					, 1, idwCmdeSin.RowCount ()) 			
					
			lVal1 = idwLstDetail.Find ( "ID_I_REG = 0 AND COD_ETAT IN ( 500, 600 )", 1, idwLstDetail.RowCount() )

			If lVal > 0 Or lVal1 > 0 Then
				stMessage.sCode = "COMD977"
				stMessage.bouton = OK!
				stMessage.icon  = Exclamation!
				F_Message ( stMessage )

				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"		

		   End IF
		End If			
		
End Choose

Return sPos

end function

private subroutine uf_preparervalider_o2m ();//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_sinistre_wdetail::uf_PreparerValider_O2M (PRIVATE)
//* Auteur        : PHG
//* Date          : 10/12/2005
//* Libellé       : [O2M] On complémente les enregistrement pour O2M
//* Commentaires  : C'est a dire le MT_FRAIS dans MT_DEVIS
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #11   JFF   01/04/2008   [DCMP080256][EEE_PC_ASUS] 
//* #12	 JFF	 20/10/2008	  [FNAC_PROD_ECH_TECH]
//* #13	 JFF	 24/03/2009	  [DCMP090109] O2M répare les IPhones
//		 	FPI	24/06/2010 [DCMP100551] Modification de l'option 76
//*-----------------------------------------------------------------

Boolean bBattSin, bAlimSin 	//* #12 [FNAC_PROD_ECH_TECH]
Long lTot, lRow, lIdProd, lInfoSpbFrn 
String sVal, sFind, sAction, StypApp
decimal {2} dcFrais 
n_cst_string lnv_string
n_cst_attrib_key	lKey[]


// Lecture du Produit
lIdProd  = idwWSin.GetItemNumber ( 1, "ID_PROD" )

// Lecture du Code Action
sFind = "ID_FOUR = 'O2M' AND CHOIX = 'O'"
lTot = idwArticle.RowCount ()
lRow = idwArticle.Find ( sFind, 1, lTot )

if lRow > 0 then 
	sAction  = idwArticle.object.id_ref_four[lRow]
	lInfoSpbFrn = idwArticle.object.info_spb_frn [lRow] 	//* #12 [FNAC_PROD_ECH_TECH]
Else // [DCMP080256][EEE_PC_ASUS] 
	Return // [DCMP080256][EEE_PC_ASUS] 
End If

// Lecture du Type D'appareil
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, idwWDivSin.RowCount () )
If lRow <= 0 Then Return

sTypApp = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) )
If lnv_String.Of_IsEmpty(sTypApp) Then Return

//* #12 [FNAC_PROD_ECH_TECH]
// La batterie est-elle sinistrée ?
bBattSin = False
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'BATT_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bBattSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" 
End If

// L'alim est-elle sinistrée ?
bAlimSin = False
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'ALIM_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bAlimSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" 
End If

If ( bAlimSin Or bBattSin) And lInfoSpbFrn = 910 Then
		lKey[1].iskeyname  = "CTG"
		lKey[1].iakeyvalue = "B"
		lKey[2].iskeyname	 ="ACTION"
		lKey[2].iakeyvalue = sAction
		lKey[3].iskeyname  ="MT_FRAIS"		
		F_RechDetPro_withKey ( lRow, idw_DetPro, lIdProd , "-DP", 95, lKey )
		If lRow > 0 Then
			if not isnull(lKey[3].iakeyvalue) And Trim ( lKey[3].iakeyvalue ) <> "" Then sVal = lKey[3].iakeyvalue
		End IF	
Else 
	Choose Case lInfoSpbFrn 
		Case 400 To 499, 905, 910, 915, 920, 936, 941 				
			// Recherche des Clés :
			lKey[1].iskeyname = "TYP_APP"
			lKey[1].iakeyvalue = sTypApp
			lKey[3].iskeyname = "ACTION"
			lKey[3].iakeyvalue = sAction
			lKey[5].iskeyname = "MT_FRAIS" // On definit la clé MT_FRAIS afin qu'elle puisse etre mise à jour.
			F_RechDetPro_withKey ( lRow, idw_DetPro, lIdProd , "-DP", 95, lKey )
			If lRow > 0 Then
				if not isnull(lKey[5].iakeyvalue) And Trim ( lKey[3].iakeyvalue ) <> "" Then sVal = lKey[5].iakeyvalue
			End IF	
			
		// #13 [DCMP090109]
		Case 1010

			//F_Determiner_Montant_Frais_Envoi ( String ( lInfoSpbFrn ), idwWsin.object.id_prod[1], idw_DetPro, dcFrais ) // #1 
			F_Determiner_Montant_Frais_Envoi ( String ( lInfoSpbFrn ), idwWsin.object.id_prod[1], isTypApp, idw_DetPro, dcFrais ) // [DCMP100551]
			sVal = String ( dcFrais )
			If dcFrais > 0 Then lRow = 1
		// #13 [DCMP090109] - Fin
			
	End Choose		
End IF

//* :#12 [FNAC_PROD_ECH_TECH]

If lRow <= 0 Then return

// [O2M] Mise à jour de MT_DEVIS
lTot = idwCmde.RowCount()
For lRow = 1 To lTot
	idwCmde.SetItem ( lRow, "MT_DEVIS", dec(sVal) )
Next

return
end subroutine

private subroutine uf_selectionautomatique_dtynom_sanspropo ();//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande3::uf_selectionautomatique_dtynom_SansPropo (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 20/11/2003 14:04:43
//* Libellé       : Sélection automatique 
//* Commentaires  : Créé à l'origine pour DARTY
//*
//* Arguments     : Aucun
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    14/03/2013  [PM220]
//*-----------------------------------------------------------------

Long	lDeb, lFin, lCpt, lTotRow, lRowFournOrig, lRowFournRech, lCoche, lIdGti, lRow
String	sFiltreOrig, sSortOrig

lIdGti = idwDetail.GetItemNumber ( 1, "ID_GTI" )

/*------------------------------------------------------------------*/
/* Si nous ne sommes pas en gestion DARTY, on ressort.              */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 31 )
If lDeb <= 0 Then Return

/*------------------------------------------------------------------*/
/* La gestion de sélection auot des 3 mob doit être paramétré       */
/* (-DP/45 )                                                        */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 45 )
If lDeb <= 0 Then Return


/*------------------------------------------------------------------*/
/* On sauve le filtre original.                                     */
/*------------------------------------------------------------------*/
sFiltreOrig = idwArticle.Describe ("DataWindow.Table.filter") 
If sFiltreOrig = "?" Then sFiltreOrig = ""

sSortOrig = idwArticle.Describe ("DataWindow.Table.Sort") 
If sSortOrig = "?" Then sSortOrig = ""

lRowFournOrig = idwFourn.GetRow ()
lRowFournRech = idwFourn.Find ( "ID_CODE_FRN = 'DTY'", 1, idwFourn.RowCount () )

/*------------------------------------------------------------------*/
/* DARTY n'est pas paramétré comme fournisseur sur le produit       */
/* On ressort																		  */
/*------------------------------------------------------------------*/
If lRowFournRech <= 0 Then Return

/*------------------------------------------------------------------*/
/* On ne sélectionne les mobiles que si l'événement choisi est un   */
/* événement de remplacement. pour tout autre type d'evt, on        */
/* ressort.                                                         */
/*------------------------------------------------------------------*/
Choose Case This.uf_Type_Evenement ()
	Case  "REMPL"
		// Pour le remplacement on continu

	Case  Else
		// Pour tout autre cas, on sort.
		Return
End Choose

idwFourn.SetRow ( lRowFournRech )
This.uf_RowFocusChanged ( "DWFOURN" ) 

/*------------------------------------------------------------------*/
/* On n'applique cette sélection que pour les mobiles que propose   */
/* DARTY.                                                           */
/*------------------------------------------------------------------*/

// [PM220]
iF isTypApp = "TPC" Then
	idwCmdTypArt.SetFilter ( "( ID_CODE_FRN = 'DTY' AND ID_CODE_ART = 'CAF' ) OR ( ID_CODE_FRN = 'O2M' AND ID_CODE_ART = 'TPC' ) " )
	idwCmdTypArt.Filter ()
	idwArticle.SetFilter ( "( ID_FOUR = 'DTY' AND ID_TYP_ART = 'CAF' ) OR ( ID_FOUR = 'O2M' AND ID_TYP_ART = 'TPC' AND MT_PRIX_TTC <= MT_PLAF )" )
Else
	idwArticle.SetFilter ( "ID_FOUR = 'DTY' AND ID_TYP_ART = 'CAF'" )
End If

idwArticle.Filter ( )

/*------------------------------------------------------------------*/
/* On Coche les trois premiers mobiles (au plus)                    */
/*------------------------------------------------------------------*/
// [PM220]
Choose Case isTypApp 
	Case "TPC" 
		lRow = idwCmdTypArt.find ( "ID_GTI = " + String ( lIdGti ) + " AND ID_CODE_FRN = 'O2M' AND ID_CODE_ART IN ( 'TPC' )", 1, idwCmdTypArt.RowCount ()) 
		If lRow <=0 And idwArticle.RowCount () > 0 Then
			isTypApp = "CAF"
			idwArticle.SetItem ( 1, "CHOIX", "O" )
			This.uf_Zn_Choix ( iDwArticle, "O", 1 )
		End If
		
	Case Else
		If idwArticle.RowCount () > 0 Then
			idwArticle.SetItem ( 1, "CHOIX", "O" )
			This.uf_Zn_Choix ( iDwArticle, "O", 1 )
		End If
End Choose			

// #1 Suppression des autres articles pour éviter les erreus
idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount(), Filter! )


/*------------------------------------------------------------------*/
/* On replace le filtre d'origine.                                  */
/*------------------------------------------------------------------*/
idwFourn.SetRow ( lRowFournOrig )
This.uf_RowFocusChanged ( "DWFOURN" ) 

idwArticle.SetFilter ( sFiltreOrig  )
idwArticle.Filter ()
idwArticle.SetSort ( sSortOrig  )
idwArticle.Sort ()



end subroutine

private function string uf_controlergestion_scf (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_SCF (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 31/03/2008
//* Libellé			: 
//* Commentaires	: [SURCOUF_ECH_EXPRESS]
//*					  
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//		 	FPI	24/06/2010 [DCMP100551] Modification de l'option 76
//*-----------------------------------------------------------------

String sPos, sProbleme, sCodModeReg 
Long lInfoSpbFrn 
Dec {2} dcFrais //#1
Boolean bRibVide

// #5 [SURCOUF_ECH_EXPRESS]
DataWindowChild dwChild 
Long lVal, lRow
String sVal 
// :#5

sPos = ""
lInfoSpbFrn = idwArticle.GetItemNumber ( alCpt, "INFO_SPB_FRN" ) 

/*------------------------------------------------------------------*/
/* Sinon on laisse protègé.													  */
/*------------------------------------------------------------------*/
idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "1" )

/*------------------------------------------------------------------*/
/* Message d'information pour le gestionnaire                       */
/*------------------------------------------------------------------*/
If  lInfoSpbFrn = 510 Then

		// #5
	idwWsin.GetChild ( "ID_ORIAN_BOUTIQUE", dwChild )
	lVal = idwWsin.GetItemNumber ( 1, "ID_ORIAN_BOUTIQUE" )
	If IsNull ( lVal ) Then 
		sVal = ""
	Else
		lRow = dwChild.Find ( "ID_BOUTIQUE = " + String ( lVal ), 1, dwChild.Rowcount () )
		If lRow > 0 Then
			sVal = "Numéro " + String (lVal) + " " + dwChild.GetItemString ( lRow, "ADR_VILLE" )
		Else 
			sVal = ""
		End If
	End If

	stMessage.sCode = "COMD082"
	//stMessage.sVar [1] = F_Determiner_Montant_Frais_Envoi ( String ( lInfoSpbFrn ), idwWsin.object.id_prod[1], idw_DetPro, dcFrais ) // #1
	stMessage.sVar [1] = F_Determiner_Montant_Frais_Envoi ( String ( lInfoSpbFrn ), idwWsin.object.id_prod[1], istypapp, idw_DetPro, dcFrais ) // [DCMP100551]
	stMessage.sVar [2] = sVal
	stMessage.sVar [3] = String ( idwCmde.GetItemNumber ( 1, "ID_SIN" ) ) + "-" + String (  This.uf_Nouveau_Num_Sequence () ) 
	F_Message ( stMessage )
End If

Return sPos

end function

private function string uf_selectionautomatique_dtynom_avecpropo ();//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande3::uf_selectionautomatique_dtynom_AvecPropo (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 20/11/2003 14:04:43
//* Libellé       : Sélection automatique de 3 Appareils
//* Commentaires  : Créé à l'origine pour DARTY
//*
//* Arguments     : Aucun
//*
//* Retourne      : String  sRetCas   Val  #2 [DCMP080324]
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF     28/01/2008  [DCMP080028]
//* #2    JFF     14/05/2008  [DCMP080324]
//*       JFF     27/02/2012  [ITSM107966]
//*-----------------------------------------------------------------

Long	lDeb, lFin, lCpt, lTotRow, lRowFournOrig, lRowFournRech, lCoche, lRow
String	sFiltreOrig, sSortOrig, sTypApp, sRetCas

// #2 [DCMP080324]
sRetCas = ""

/*------------------------------------------------------------------*/
/* Si nous ne sommes pas en gestion DARTY, on ressort.              */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 31 )
If lDeb <= 0 Then Return sRetCas

/*------------------------------------------------------------------*/
/* La gestion de sélection auot des 3 mob doit être paramétré       */
/* (-DP/45 )                                                        */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 45 )
If lDeb <= 0 Then Return sRetCas


lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, idwWDivSin.RowCount () )
If lRow <= 0 Then Return sRetCas

// #1
sTypApp = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) )
If IsNull ( sTypApp ) Or Trim ( sTypApp ) = "" Then Return sRetCas
// :#1

/*------------------------------------------------------------------*/
/* On sauve le filtre original.                                     */
/*------------------------------------------------------------------*/
sFiltreOrig = idwArticle.Describe ("DataWindow.Table.filter") 
If sFiltreOrig = "?" Then sFiltreOrig = ""

sSortOrig = idwArticle.Describe ("DataWindow.Table.Sort") 
If sSortOrig = "?" Then sSortOrig = ""

lRowFournOrig = idwFourn.GetRow ()
lRowFournRech = idwFourn.Find ( "ID_CODE_FRN = 'DTY'", 1, idwFourn.RowCount () )

/*------------------------------------------------------------------*/
/* DARTY n'est pas paramétré comme fournisseur sur le produit       */
/* On ressort																		  */
/*------------------------------------------------------------------*/
If lRowFournRech <= 0 Then Return sRetCas

/*------------------------------------------------------------------*/
/* On ne sélectionne les mobiles que si l'événement choisi est un   */
/* événement de remplacement. pour tout autre type d'evt, on        */
/* ressort.                                                         */
/*------------------------------------------------------------------*/
Choose Case This.uf_Type_Evenement ()
	Case  "REMPL"
		// Pour le remplacement on continu

	Case  Else
		// Pour tout autre cas, on sort.
		Return sRetCas
End Choose

idwFourn.SetRow ( lRowFournRech )
This.uf_RowFocusChanged ( "DWFOURN" ) 

/*------------------------------------------------------------------*/
/* On n'applique cette sélection que pour les mobiles que propose   */
/* DARTY.                                                           */
/*------------------------------------------------------------------*/
idwArticle.SetFilter ( "ID_FOUR = 'DTY' AND ID_TYP_ART = '" + sTypApp + "' AND MT_PRIX_TTC <= MT_PLAF" ) // #1
idwArticle.Filter ( )

/*------------------------------------------------------------------*/
/* On les tris par odre de prix TTC Décroissants.                   */
/*------------------------------------------------------------------*/
idwArticle.SetSort ( "MT_PRIX_TTC D, ID_MARQ_ART A, ID_MODL_ART A")
idwArticle.Sort ()

/*------------------------------------------------------------------*/
/* On ne sélectionnera au maximum que trois dossiers.               */
/*------------------------------------------------------------------*/
lTotRow = idwArticle.RowCount ()
If lTotRow >= 3 Then lTotRow = 3

// #2 [DCMP080324] à ce moment précis, s'il n'est pas possible de sélection au moins un article, on se rabat 
// automatiquement sur le mail sans propo.
If lTotRow <= 0 Then
	sRetCas = "BASCULE_AVEC_PROPO_VERS_SANS_PROPO"
	uf_selectionautomatique_dtynom_SansPropo ()

	// ITSM107966
	If Not ibIPHONE_absent Then

		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "COMD472"
	
		F_Message ( stMessage )
	End If 
	// ITSM107966

Else

	/*------------------------------------------------------------------*/
	/* On Coche les trois premiers mobiles (au plus)                    */
	/*------------------------------------------------------------------*/
	
	For lCpt = 1 To lTotRow 
		idwArticle.SetItem ( lCpt, "CHOIX", "O" )
		This.uf_Zn_Choix ( iDwArticle, "O", lCpt )
	Next
	
	// #2 [DCMP080324] Je déplace ce code ici qui se trouvait plus haut auparavant.
	idwArticle.SetFilter ( "ID_FOUR = 'DTY' AND ID_TYP_ART = '" + sTypApp + "'" ) // #1
	idwArticle.Filter ( )
	// #1 Suppression des autres articles pour éviter les erreurs
	idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount(), Filter! )
	// :#2

End If // :#2

/*------------------------------------------------------------------*/
/* On replace le filtre d'origine.                                  */
/*------------------------------------------------------------------*/
idwFourn.SetRow ( lRowFournOrig )
This.uf_RowFocusChanged ( "DWFOURN" ) 
idwArticle.SetFilter ( sFiltreOrig  )
idwArticle.Filter ()
idwArticle.SetSort ( sSortOrig  )
idwArticle.Sort ()

// #2 [DCMP080324] 
Return sRetCas
end function

private subroutine uf_epurationautretypeart ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::uf_EpurationAutreTypeArt (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 10/06/2008
//* Libellé			: Pour Les Commandes, on épure les types proposés différents du type sinistrés
//* Commentaires	: [DCMP070798]
//*												  
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   02/03/2010   [MSS_LOT2]
//        JFF   22/04/2011   [20110422142842650] sur demande de Pascal
//			 FPI	 05/07/2011	  [PC434] Retour recette : ajout du filtre "MAI"
//*       JFF   01/09/2011   [PC10][DIAG_NOMADE]
//       JFF   07/05/2013 [PC938_ORANGE_V3]
//*-----------------------------------------------------------------

String sFiltreOrig 
String sTypAppEpur


sFiltreOrig = idwArticle.Describe ("DataWindow.Table.filter") 
If sFiltreOrig = "?" Then sFiltreOrig = ""


Choose Case isTypApp
	Case "PC3"
		sTypAppEpur = "PC2','PC1"

	// [PC10][DIAG_NOMADE]
	Case "OU1", "OU2"
		sTypAppEpur = "PCP','CUB','PCC"
		
	Case Else
		sTypAppEpur = isTypApp		
End Choose

//* #1 [MSS_LOT2] ajout ACC

Choose Case isChoixAction 
	Case "C"
		//	[PC434] - Ajout MAI // [PC938_ORANGE_V3] REL
		idwArticle.SetFilter ( "ID_TYP_ART in ( 'DEV', 'CAF', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'RST', 'PST', 'RES', 'REA', '" + sTypAppEpur + "')" )

	//  [20110422142842650]
	Case "S"
		idwArticle.SetFilter ( "ID_TYP_ART in ( 'BAM', 'ALE', 'ACC', '" + sTypAppEpur + "')" )
End Choose

idwArticle.Filter ( )
idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount(), Filter! )

idwArticle.SetFilter ( sFiltreOrig  )
idwArticle.Filter ()

idwArticle.Sort ()


end subroutine

private function string uf_controlergestion_fnac (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_FNAC (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/07/2004
//* Libellé			: Controle Spécifique pour FNAC
//* Commentaires	: [FNAC_PROD_ECH_TECH].[SMS]
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ	PAR	Date			Modification
//       JFF   03/06/2010  [PC397/443_IPAD]
//*-----------------------------------------------------------------
String sPos, sFiltreOrig, sSortOrig, sTypAction, sNumGsm
Long   lRow, lModeRempl
Boolean bAltSuiviSms

sPos = ""

lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'MODE_REMPL'", 1, idwWDivSin.RowCount () ) 
If lRow > 0 Then 
	lModeRempl = idwWDivSin.GetItemNumber ( lRow, "VAL_LST_NBRE" ) 

	// [PC397/443_IPAD]
	If IsNull ( lModeRempl ) Then lModeRempl = 0 
	
	If lModeRempl <= 0 Then
		stMessage.sCode = "COMD509"
		F_Message ( stMessage )
		Return "D" + "RIB_BQ"
	End If	
Else	
	// zone absente, problème de param, on bloque
	stMessage.sCode = "COMD510"
	F_Message ( stMessage )

	Return "D" + "RIB_BQ"
	
End If

sTypAction = idwArticle.GetItemString ( alCpt, "ID_TYP_ART" )

Choose Case sTypAction

	Case "CAF"
		If lModeRempl <> 1 Then
			stMessage.sCode = "COMD508"
			F_Message ( stMessage )
			Return "D" + "RIB_BQ"
		End If
		
	Case "SMS"
		If lModeRempl <> 2 Then
			stMessage.sCode = "COMD508"
			F_Message ( stMessage )
			Return "D" + "RIB_BQ"
		End If

		lRow = idwLstInter.Find ( "COD_INTER = 'A'", 1, idwLstInter.RowCount () )
		If lRow > 0 Then
			bAltSuiviSms = idwLstInter.GetItemString ( lRow, "ALT_SUIVI_SMS" ) = "O"
			sNumGsm = idwLstInter.GetItemString ( lRow, "NUM_PORT_SMS" )
		
			If Not bAltSuiviSms Or IsNull ( sNumGsm ) OR Trim ( sNumGsm ) = "" Then
				stMessage.sCode = "COMD511"
				F_Message ( stMessage )
				Return "D" + "RIB_BQ"
			End If
		End IF
		
End CHoose


Return sPos

end function

private function string uf_controlergestion_o2m (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_O2M (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 03/02/2009
//* Libellé			: Controle Spécifique pour O2M (hors EDI)
//* Commentaires	: [FNAC_PROD_ECH_TECH].[20090127140540720]
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ	PAR	Date			Modification
//* #3 	FPI	20/03/2009	[DCMP090109] O2M devient réparateur d'IPhone
//* #4   JFF   02/03/2010  [MSS_LOT2]
//*  	   JFF	13/04/2010  [ADRESSE_O2M]
//*      JFF   17/05/2010  [DCMP100302].[20100517204909090]
//*      JFF   10/06/2010  [PC419/440/418/439_MICROMANIA]
//		 	FPI	24/06/2010  [DCMP100551] Modification de l'option 76
//       JFF   30/09/2010  [PC474]
//		 	FPI	24/06/2010  [DCMP100551] Modification de l'option 76
//*		JFF   05/01/2011  [PC202].[DOM_COM]
//*		FPI	05/09/2011	[PC413-1] - Exclusion de l'IPad à la règle des 600€
//*      JFF   12/12/2011  [VDOC4970]
//*      JFF   21/12/2011  [VDOC4970][MANTIS2042]
//*      JFF   05/01/2012  [RECUP_DONNEE_O2M]
//       JFF   30/08/2012  [VDOC8041]
//       JFF   11/09/2012  [PC662][POINT7]
//       JFF   13/11/2012  [VDOC9057]
//       JFF   04/02/2012  [PC662_VDOC9376_M6646]
//       JFF   07/05/2013  [PC938_ORANGE_V3]
//       JFF   07/05/2013  [PC938_ORV3_M8247]
//       JFF   09/09/2013  [PM222-1]
//       JFF   11/02/2014  [DT57_CMDE_IPHONE_SFR]
//       JFF   08/04/2014 [PM255]
// 		FPI	09/04/2014 [PC13448]
// 		JFF	02/05/2014 [VDOC14293]
//       JFF   22/05/2014 [PC14495]
//       JFF   02/06/2014 [PC929_CDISCOUNT][PC929-2-V3]
//       JFF   17/06/2014 [PM259-1]
//		FPI	11/07/2014 [VDOC14882]
//    JFF   21/11/2014 [VDOC16011]
//    JFF   12/12/2014 [PC13321]
//    JFF   04/02/2015 [PC13321][MANTIS14046]
//	   JFF   19/02/2015 [VDOC15533]
// 		FPI	27/02/2015	[VDOC16821] On se base sur le cp de l'assuré ald la caisse
//		JFF	03/07/2015 [PM280-1][MANTIS15456]
//       JFF   15/12/2015 [DT191]
//       JFF   29/03/2016 [DT200]
// 		FPI	21/10/2016	[PI056] dte_ach_port en datetime
//       JFF   12/12/2016 [DT269]
//       JFF   23/01/2017 [DT290]
//       JFF   31/07/2018 [DT363]
//       JFF   20/06/2022 [RS3220_MODDEGR_TELST]
//*-----------------------------------------------------------------

String sPos, sProbleme, sCodModeReg, sIdRefFour, sVal, sIdTypArtCmd, sNumCmde, sTypArtForce 
String sNomLigne1, sNomLigne2, sAdrLigne1, sAdrLigne2, sCP, sVille, sAdresseO2m	
Long lInfoSpbFrn, lRow, lCaisse, lModule, lCodeMag, lIdProd
Long lIdGti, lDeb, lFin, lRowOrig, lCpt, lIdEvt 
Dec {2} dcFrais //#1
Boolean bRibVide, bErrBAMALE
n_cst_cmd_commun	lnvCmdCommun
Decimal{2}   dcMtValAchat // [PC474]
Decimal{2}   dcMtPivotCds // [PC13448]
String sMarqPort, sModelePort, sTypApp // [PC413-1]
Boolean bA_DIAG_O2M_175, bA_DIAG_O2M_151234, bPEC_A_RECYCLER, bAUT_ACC_SIN
Boolean bOrangeV3, bExclu, bARepGti, bModDegTLS
n_cst_string lnv_string
String sAdrNom, sAdr1, sAdr2, sAdrVille, sAdrCP, sAdressePSM, sTypArt
Date dtDteAchat, dtDteSurv 
String sSkuIfr 

// [ADRESSE_O2M]
lIdEvt = idwDetail.GetItemNumber ( 1, "ID_EVT" ) 
lIdGti = idwDetail.GetItemNumber ( 1, "ID_GTI" )
dcMtValAchat = idwDetail.GetitemDecimal( 1, "MT_VAL_ACHAT") // [PC474]
lInfoSpbFrn = idwArticle.object.info_spb_frn[alCpt] // [PC474]
sTypArt = idwArticle.object.id_typ_art [alCpt] 
dtDteSurv = Date ( idwWsin.GetItemDateTime ( 1, "DTE_SURV" ) ) // [PC929_CDISCOUNT][PC929-2-V3]
dtDteAchat = Date (idwWsin.GetItemDateTime ( 1, "DTE_ACH_PORT" ) ) // [PI056]
bExclu = False

bErrBamAle = FALSE

sPos = ""

// [PM280-1][MANTIS15456]
bARepGti = lnv_string.of_Getkeyvalue( isInfoSpbFrnCplt, "A_REP_GARANTIE", ";" ) = "OUI"

// [RS3220_MODDEGR_TELST]
bModDegTLS = &
idwCmdeSin.Find ( &
		"ID_FOUR = 'O2M' AND " + &
		"COD_ETAT <> 'ANN' AND " + &
		"( ID_TYP_ART NOT IN ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' ) " + &
		"  OR " + &
		"  ( ID_TYP_ART = 'RST' AND POS ( INFO_SPB_FRN_CPLT, 'RST_CMDE+SUIVI=OUI' ) > 0 ) " + &
		") " + &
		" AND STATUS_GC NOT IN ( 176, 239, 203 )" + &
		" AND POS ( INFO_SPB_FRN_CPLT, 'RS3220=TLS' ) > 0" &		
		, 1, idwCmdeSin.RowCount () ) > 0 
		
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 239 )
bOrangeV3 = lDeb > 0

// #4 [MSS_LOT2]
If idwCmdeSin.Find("ID_FOUR = 'MS1' AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount() ) > 0 Then
	stMessage.sCode = "COMD615" 
	stMessage.bouton = Ok!
	stMessage.sVar[1] = "O2M"	
	stMessage.sVar[2] = "MSS"	
	F_Message ( stMessage )
	sPos = "ALT_CHOIX"
	Return "G" + "ALT_CHOIX"
End If
// #4 [MSS_LOT2]

// [PC929_CDISCOUNT][PC929-2-V3]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 235 )
If lDeb > 0 Then
	Choose Case isTypApp
		Case "TL7", "TLO", "TPS"
			If lnv_string.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "TVSUP32P", ";") = "OUI" Then
				// [PC13419-1]
				If lnv_string.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MSG_GC_TVSUP32P", ";") = "OUI" Then
					If sTypArt = "PRS" And dtDteSurv < F_PLUS_DATE ( dtDteAchat , 1, "A"  ) And &
						idwwDivDet.Find ( "ID_GTI = " + String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) ) + &
						" AND ID_DETAIL = " +  String ( idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
						" AND UPPER ( NOM_ZONE ) = 'ALT_PEC' " + &
						" AND UPPER ( VAL_LST_CAR ) = 'O'", 1, idwwDivDet.Rowcount()  ) <= 0 Then
						
						stMessage.sCode = "COMD880"
						
						stMessage.bouton = OK!
						F_Message ( stMessage )	
					END IF	
				Else
					If sTypArt = "PRS" And dtDteSurv < F_PLUS_DATE ( dtDteAchat , 1, "A"  ) And &
					idwwDivDet.Find ( "ID_GTI = " + String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) ) + &
					" AND ID_DETAIL = " +  String ( idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
					" AND UPPER ( NOM_ZONE ) = 'ALT_PEC' " + &
					" AND UPPER ( VAL_LST_CAR ) = 'O'", 1, idwwDivDet.Rowcount()  ) <= 0 Then
					
						stMessage.sCode = "COMD870"
						
						stMessage.bouton = OK!
						F_Message ( stMessage )	
						sPos = "ALT_CHOIX"
						Return "G" + "ALT_CHOIX"
					End If
				End if
			// :[PC13419-1]
			End if
	End Choose
End If

sIdRefFour = Upper ( idwArticle.GetItemString ( alCpt, "ID_REF_FOUR" ) )
sIdTypArtCmd  = Upper ( idwArticle.GetItemString ( alCpt, "ID_TYP_ART" ) )

// [VDOC4970]
bA_DIAG_O2M_175 = idwCmdeSin.Find("ID_FOUR = 'O2M' AND ID_REF_FOUR='A_DIAGNOSTIQUER' AND STATUS_GC = 175 AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount() ) > 0
bA_DIAG_O2M_151234 = idwCmdeSin.Find("ID_FOUR = 'O2M' AND ID_REF_FOUR='A_DIAGNOSTIQUER' AND STATUS_GC IN ( 151, 152, 153, 154 ) AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount() ) > 0
bPEC_A_RECYCLER = idwCmdeSin.Find("ID_FOUR = 'O2M' AND ID_REF_FOUR='PEC_A_RECYCLER' AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount() ) > 0

lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'AUT_ACC_SIN'", 1, idwWDivSin.RowCount () ) 
If lRow > 0 Then 
	bAUT_ACC_SIN = Upper ( idwWDivSin.GetItemString ( lRow, "VAL_ALT" ) ) = "O"
End If

// [PC938_ORV3_M8247]
If sIdTypArtCmd = "RST" And &
	( idwwDivDet.Find ( "ID_GTI = " + String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) ) + &
	" AND ID_DETAIL = " +  String ( idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
	" AND UPPER ( NOM_ZONE ) = 'ALT_PEC' " + &
	" AND UPPER ( VAL_LST_CAR ) <> 'O'" &
	, 1, idwwDivDet.RowCount () ) > 0 ) And &
	( idwwDivDet.Find ( "ID_GTI = " + String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) ) + &
	" AND ID_DETAIL = " +  String ( idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
	" AND UPPER ( NOM_ZONE ) = 'MT_PEC' " + &
	" AND VAL_MT <= 0" &
	, 1, idwwDivDet.RowCount () ) > 0 )	&
	Then 

	stMessage.sCode = "COMD823 "

	stMessage.bouton = OK!
	F_Message ( stMessage )	
	sPos = "ALT_CHOIX"
	Return "G" + "ALT_CHOIX"
	
End If

If bAUT_ACC_SIN And Not bA_DIAG_O2M_175 and Not bA_DIAG_O2M_151234 Then

	If sIdRefFour <> "PAS_DE_COMMANDE" Then
		stMessage.sCode = "COMD595"
	Else
		stMessage.sCode = "COMD693"
	End If
	
	stMessage.bouton = OK!
	F_Message ( stMessage )
	sPos = "ALT_CHOIX"
	Return "G" + "ALT_CHOIX"


ElseIf Not bAUT_ACC_SIN And Not bA_DIAG_O2M_175 Then

// [VDOC4970][MANTIS2042]
	If sIdRefFour = "CMDE_AUT_ACC" Then
		stMessage.sCode = "COMD593"

		stMessage.bouton = OK!
		F_Message ( stMessage )	
		sPos = "ALT_CHOIX"
		Return "G" + "ALT_CHOIX"
		
	End If
	
	If sIdRefFour = "PAS_DE_COMMANDE" Then
		stMessage.sCode = "COMD693"
		
		stMessage.bouton = OK!
		F_Message ( stMessage )	
		sPos = "ALT_CHOIX"
		Return "G" + "ALT_CHOIX"
		
	End If
// :[VDOC4970][MANTIS2042]		

End If 

// [DCMP100507/100508/100444]
Choose Case sIdRefFour

	Case "PAS_DE_COMMANDE", "CMDE_AUT_ACC"
		If Not bPEC_A_RECYCLER Then
			stMessage.sTitre = "DCMP100507"
			stMessage.sCode = "COMD643"
			stMessage.bouton = OK!
			F_Message ( stMessage )
			sPos = "ALT_CHOIX"
			Return "G" + "ALT_CHOIX"
		End If

End Choose
// :[VDOC4970]


//* #6 [FNAC_PROD_ECH_TECH].[20090127140540720]
Choose Case sIdRefFour
	Case "CMDE_ALIM_EXT", "CMDE_BATT_AMOV"
		 
		If sIdRefFour = "CMDE_ALIM_EXT" Then
			lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'ALIM_SIN'", 1, idwWDivSin.RowCount () ) 
			If lRow > 0 Then 
				If Upper ( idwWDivSin.GetItemString ( lRow, "VAL_ALT" ) ) <> "O" Then
					bErrBamAle = TRUE
				End If
			Else
// [PC419/440/418/439_MICROMANIA]
//				bErrBamAle = TRUE				
				bErrBamAle = FALSE
			End If
		End If 
		
		If Not bErrBamAle And sIdRefFour = "CMDE_BATT_AMOV" Then
			lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'BATT_SIN'", 1, idwWDivSin.RowCount () ) 
			If lRow > 0 Then 

				If Upper ( idwWDivSin.GetItemString ( lRow, "VAL_ALT" ) ) <> "O" Then
					bErrBamAle = TRUE
				End If
			Else
// [PC419/440/418/439_MICROMANIA]
//				bErrBamAle = TRUE				
				bErrBamAle = FALSE
			End If
		End If 

		If bErrBamAle Then
			stMessage.sCode = "COMD512"
			stMessage.bouton = YESNO!
			If F_Message ( stMessage ) = 2 Then
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"
			End If
		End If
End Choose

// [PC474]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 37 )
If lDeb > 0 Then
	// [PC13448]
	dcMtPivotCds=600 
	sVal=lnv_String.of_getkeyvalue( idw_DetPro.GetItemString(lDeb,"VAL_CAR"), "VARIANTE", ";")
	If sVal="PRO" Then dcMtPivotCds=500
	// :[PC13448]
	
	if lInfoSpbFrn = 1010 And sIdRefFour = "A_REPARER" and dcMtValAchat < dcMtPivotCds Then	

		// [PC413-1] - Exclusion de l'IPad à cette règle
		sTypApp=""

		lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, idwWDivSin.RowCount () )
		If lRow > 0 Then 
			sTypApp=	idwWDivsin.GetItemString(lRow,"VAL_CAR")
		End if
	
		If Not (sTypApp="TPC" and isMarqPortAdh="APPLE" and Left(ismodlportadh ,4) = "IPAD") Then
		// :[PC413-1]
			stMessage.sCode = "COMD618"
			stMessage.sVar[1] = "600"
			If sVal="PRO" Then stMessage.sVar[1] = "500" // [PC13448]
			stMessage.bouton = Ok!
		
			F_Message ( stMessage )
			sPos = "ALT_CHOIX"
			Return "G" + "ALT_CHOIX"
		End if // [PC413-1]
	End If
End If
// [PC474]

F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 266 )	

If lDeb > 0 And sTypArt = "PRS" And dcMtValAchat < 200 Then
	// [MANTIS14045]	
	If lnv_string.of_getkeyvalue( idw_DetPro.GetItemString(lDeb,"VAL_CAR") , "VARIANTE", ";") = "BRUN" Then
		Choose Case isTypApp
			Case "TLC", "TLO", "TPS", "TTC"
				bExclu = True
		End Choose
	End if

	If Not bExclu Then
		stMessage.sCode = "COMD895"
		stMessage.sVar[1] = "200"
		stMessage.bouton = OK!
		F_Message ( stMessage )	
		sPos = "ALT_CHOIX"
		Return "G" + "ALT_CHOIX"
	End If
End If

// #3 [DCMP090109] 
IF sPos = "" Then

/*------------------------------------------------------------------*/
/* Si au moins une prestation vers O2M est détectée              */
/* ET sur laquelle la zone info_spb_frn est égale à 1010  (client    */
/* envoi son mobile)                                                */
/* ET que la méthode de règlement et " VA "                         */
/* ET que le RIB est vide                                           */
/* ALORS afficher un message :                                      */
/*------------------------------------------------------------------*/

	lInfoSpbFrn = idwArticle.GetItemNumber ( alCpt, "INFO_SPB_FRN" ) 
	sCodModeReg = idwCmde.GetItemString ( 1, "COD_MODE_REG" ) 
	bRibVide    = 	IsNull ( idwCmde.GetItemString ( 1, "RIB_BQ" ) ) Or idwCmde.GetItemString ( 1, "RIB_BQ" ) = Fill ( "0", 5 ) Or &
					IsNull ( idwCmde.GetItemString ( 1, "RIB_GUI" ) ) Or idwCmde.GetItemString ( 1, "RIB_GUI" ) = Fill ( "0", 5 ) Or &
					IsNull ( idwCmde.GetItemString ( 1, "RIB_CPT" ) ) Or idwCmde.GetItemString ( 1, "RIB_CPT" ) = Fill ( "0", 11 ) Or&
					IsNull ( idwCmde.GetItemString ( 1, "RIB_CLE" ) ) 

	sNumCmde	= string(idwWsin.object.id_sin[1])+"-"+string(uf_nouveau_num_sequence( ))

	// [201307
	sTypArtForce = sTypArt

// [ADRESSE_O2M]
// [VDOC9057] "A_DIAGNOSTIQUER",&
// [VDOC14882]
lnvCmdCommun.uf_GetAdresseO2M_2 ( &
"", &
"",&
lInfoSpbFrn, &
isTypApp,&
sTypArtForce,&
"CNV",&
lIdGti,&
ismodlportadh, &
isInfoSpbFrnCplt,&
idwCmdeSin,&
idwWDivSin,&
idw_DetPro,& 
idwWsin.GetItemNumber ( 1, "ID_PROD" ),&
sNomLigne1,&
sNomLigne2,& 
sAdrLigne1,& 
sAdrLigne2,&
sCP,&
sVille )

//: [VDOC14882]
	sAdresseO2m	= ""
	If Not IsNull ( sNomLigne1 ) And Len ( sNomLigne1 ) > 0 Then sAdresseO2m += sNomLigne1 

	// [MANTIS9243]
	If Not IsNull ( sAdresseO2m  ) And Len ( sAdresseO2m  ) > 0 Then sAdresseO2m += "" + Char ( 13 ) 	
	
	If Not IsNull ( sNomLigne2 ) And Len ( sNomLigne2 ) > 0 Then sAdresseO2m += sNomLigne2 + Char ( 13 ) 
	If Not IsNull ( sAdrLigne1 ) And Len ( sAdrLigne1 ) > 0 Then sAdresseO2m += sAdrLigne1 + Char ( 13 ) 
	If Not IsNull ( sAdrLigne2 ) And Len ( sAdrLigne2 ) > 0 Then sAdresseO2m += sAdrLigne2 + Char ( 13 ) 
	If Not IsNull ( sCP ) And Len ( sCP ) > 0 Then sAdresseO2m	+=	sCP
	If Not IsNull ( sVille ) And Len ( sVille ) > 0 Then sAdresseO2m	+=	" " + sVille 

	
// [ADRESSE_O2M]

	Choose Case lInfoSpbFrn 
		Case 1010
			/*------------------------------------------------------------------*/
			/* On déprotège les zones                                           */
			/*------------------------------------------------------------------*/
			idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "0" )
		Case Else 
			/*------------------------------------------------------------------*/
			/* Sinon on laisse protégé.													  */
			/*------------------------------------------------------------------*/
			idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "1" )
	End Choose


	If  Upper ( sCodModeReg ) = "VA" And bRibVide Then
			Choose Case lInfoSpbFrn
				Case 1010
					stMessage.sCode = "COMD071"
					F_Message ( stMessage )
					Return "D" + "RIB_BQ"
			End Choose	
	End If

	// [VDOC8041]
	sVal = lnv_string.of_Getkeyvalue( isInfoSpbFrnCplt, "CODE_VERROU", ";" )
	If Not IsNull ( sVal ) And Trim ( sVal ) <> "" Then
			stMessage.sCode = "COMD745"
			F_Message ( stMessage )
			Return sPos
		
	End IF

	/*------------------------------------------------------------------*/
	/* Message d'information pour le gestionnaire                       */
	/*------------------------------------------------------------------*/
	Choose Case lInfoSpbFrn 

		// [PC13321]
		Case 910, 961, 962, 937, 942
		
			This.uf_message_process_o2m ( alCpt, lInfoSpbFrn )
		
		
		Case 912

			// [DT191]
			If bOrangeV3 Then
				// PC938_ORV3_M8086
				If sTypArt = "RES" Then
					
					// [PM255] [MANTIS11374]
					lRowOrig = idwCmdeSin.Find ( "POS ( INFO_SPB_FRN_CPLT, 'CODE_PICK_UP' ) > 0 AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount () )
					If lRowOrig > 0 Then						
						stMessage.sCode = " COMD874"
					Else 
						stMessage.sCode = " COMD811"
					End If
					
					stMessage.sVar[1] = sNumCmde
					stMessage.sVar[2] = sAdresseO2M
					F_Message ( stMessage )

				End If
				
				If sTypArt = "REA" Then
					stMessage.sCode = " COMD815"

					stMessage.sVar[1] = sNumCmde
					stMessage.sVar[2] = sAdresseO2M
					F_Message ( stMessage )
				
				End If
				
				// [DT191]
				If sTypArt = "PRS" Then
					stMessage.sCode = "COMD933" 					
					stMessage.sVar[1] = sNumCmde
					stMessage.sVar[2] = sAdresseO2M
					F_Message ( stMessage )
				End If

			Else
				// [PC13321]
				This.uf_message_process_o2m ( alCpt, lInfoSpbFrn )
			End If
		
		Case 973  // [PC938_ORANGE_V3]
			
			lCodeMag = Long ( F_REMPLACE ( isCodeBoutiqueRelaiPSM, "#", "" ) )
			lIdProd = idwProduit.GetItemNumber ( 1, "ID_PROD" ) 
			sAdrNom = Space ( 35 ) 
			sAdr1   = Space ( 35 ) 
			sAdr2   = Space ( 35 ) 
			sAdrVille = Space ( 35 ) 
			sAdrCp = Space ( 5 ) 
			SQLCA.PS_S_BOUTIQUE_ADRESSE (lIdProd, lCodeMag, sAdrNom, sAdr1, sAdr2, sAdrVille, sAdrCP )
			
			sAdressePSM = ""
			If Not IsNull ( sAdrNom ) And Len ( sAdrNom ) > 0 Then sAdressePSM += sAdrNom + Char ( 13 ) 
			If Not IsNull ( sAdr1 ) And Len ( sAdr1 ) > 0 Then sAdressePSM += sAdr1 + Char ( 13 ) 
			If Not IsNull ( sAdr2 ) And Len ( sAdr2 ) > 0 Then sAdressePSM += sAdr2 + Char ( 13 ) 
			If Not IsNull ( sAdrCp ) And Len ( sAdrCp ) > 0 Then sAdressePSM +=	sAdrCP 
			If Not IsNull ( sAdrVille ) And Len ( sAdrVille ) > 0 Then sAdressePSM += " " + sAdrVille 
		
			stMessage.sCode = "COMD786"
			stMessage.sVar [1] = sAdressePSM
			
			F_Message ( stMessage )
			
		Case 974  // [PC938_ORANGE_V3]
			
			stMessage.sCode = "COMD788"
			F_Message ( stMessage )

		Case 975  // [PC938_ORANGE_V3]


			stMessage.sCode = "COMD789"
			F_Message ( stMessage )
			
		Case 976  

			If sTypArt = "PRS" Then
				stMessage.sCode = "COMD800"
				F_Message ( stMessage )
			End If
			
		Case 977  			

			If sTypArt = "PRS" Then
				stMessage.sCode = "COMD801"
				F_Message ( stMessage )
			End If
			
		Case 978  			

			If sTypArt = "PRS" Then
				stMessage.sCode = "COMD802" 					
				F_Message ( stMessage )
			End If
			
		Case 979  			

			If sTypArt = "PRS" Then
				stMessage.sCode = "COMD803" 					
				F_Message ( stMessage )
			End If

		// [PM255]
		Case 981  			

			If sTypArt = "PRS" Then
				stMessage.sCode = "COMD858" 					
				F_Message ( stMessage )
			End If		

		// [PM255]
		Case 982

			If sTypArt = "PRS" Then
				stMessage.sCode = "COMD859" 					
				F_Message ( stMessage )
			End If		

		// [PM255]
		Case 983

			stMessage.sCode = "COMD862" 					
			F_Message ( stMessage )

		// [DT290]
		Case 984

			stMessage.sCode = "COMD953" 					
			F_Message ( stMessage )
			
		// [PC929_CDISCOUNT][PC929-2-V3]			
		Case 	955
			stMessage.sCode = "COMD871"					

			// [PC13321][MANTIS14046]
			F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 266 )
			If ldeb > 0 Then
				If lnv_string.of_getkeyvalue( idw_DetPro.GetItemString(lDeb,"VAL_CAR") , "VARIANTE", ";") = "BRUN" Then
					stMessage.sCode = "COMD902"					
				End if
			End if			
			
			stMessage.sVar[1] = sNumCmde
			
			F_Message ( stMessage )		

		// [PC13321]
		Case 	957
			stMessage.sCode = "COMD893"					
			
			stMessage.sVar[1] = sNumCmde
			
			F_Message ( stMessage )		
			
	
		Case 1010
	// [WEBSIM2].[FRANCE]
	//		stMessage.sCode		= "COMD515" 
			stMessage.sCode		= "COMD627" 		
	// :[WEBSIM2].[FRANCE]				
			
//			stMessage.sVar [1] = F_Determiner_Montant_Frais_Envoi ( String ( lInfoSpbFrn ), idwWsin.object.id_prod[1], idw_DetPro, dcFrais ) // #1 
			stMessage.sVar [1] = F_Determiner_Montant_Frais_Envoi ( String ( lInfoSpbFrn ), idwWsin.object.id_prod[1], istypapp, idw_DetPro, dcFrais ) // [DCMP100551]

			// [DCMP100302].[20100517204909090]
			If Trim ( stMessage.sVar [1] ) <> "" And Not IsNull ( stMessage.sVar [1]) Then
				// Ajout de "par SPB"
				stMessage.sVar [1] = F_REMPLACE ( stMessage.sVar [1], "L'assuré sera remboursé", "L'assuré sera remboursé par SPB")
				// Suppression du "." de fin"
				stMessage.sVar [1] = Left ( stMessage.sVar [1], Len ( stMessage.sVar [1] ) - 1 )
				// ajout du complèment de phrase.
				stMessage.sVar [1] += " sur présentation de la facture d'achat de la poste."
				
				//  [PC202].[DOM_COM]
				// [VDOC16821]
				f_rechdetpro(lDeb, lFin, idw_detpro, idwProduit.GetItemNumber(1, "ID_PROD"),"-DP",138)
				If lDeb > 0 Then
					sVal=idwCmde.GetItemString(1,"ADR_CP")
					if Len(trim(sVal)) = 5 Then 
						sVal=Left(sVal,3)
					Else 
						sVal=""
					End if
		
					Choose case sVal
						Case "971","972","973","974","975","976","984","986","987","988"
						//(971) Guadeloupe 
						// (972) Martinique 
						// (973) Guyane 
						// (974) La Réunion 
						// (975) Saint-Pierre-et-Miquelon 
						// (976) Mayotte 
						// (984) Terres Australes et Antarctiques 
						// (986) Wallis et Futuna 
						// (987) Polynésie Française 
						// (988) Nouvelle-Calédonie 
							stMessage.sVar [1] = F_REMPLACE ( stMessage.sVar [1], String ( dcFrais ) + "€", "27€ maximum")	
					End choose
						
				End if
				// [VDOC16821]
				//  :[PC202].[DOM_COM]
				
			End IF
			// :[DCMP100302].[20100517204909090]		
// [ADRESSE_O2M]			

			// [RECUP_DONNEE_O2M]		
			lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'RECUP_DONNEES'", 1, idwWDivSin.RowCount () ) 
			If lRow > 0 Then
				sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
				If sVal = "O" Then 
					sVal = "OUI"
				Else
					sVal = "NON"
				End If
				
				lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "RECUP_DONNEES", sVal, ";")		
			End If

			If lIdGti = 44 Then
				lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'RECUP_MATERIEL'", 1, idwWDivSin.RowCount () ) 
				If lRow > 0 Then
					sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
					If sVal = "O" Then 
						sVal = "OUI"
					Else
						sVal = "NON"
					End If
			
					lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "RECUP_APP_PAR_ASSURE", sVal, ";")	
				End If
			End If

			stMessage.sVar [2] = sAdresseO2M
			stMessage.sVar [3] = String ( idwCmde.GetItemNumber ( 1, "ID_SIN" ) ) + "-" + String (  This.uf_Nouveau_Num_Sequence () ) 


			// [PM280-1][MANTIS15456]
			If bARepGti Then
				stMessage.sVar [1] = ""
			End If

// [ADRESSE_O2M]			
			F_Message ( stMessage )
		
	End Choose 
	
End if
// :#3 [DCMP090109] 


// [PC662][POINT7]
If sPos = "" Then
	
	// Si DP 220 présente
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 220 )
	If lDeb > 0 Then

		sVal = "DARTY_ABONNEMENT" // A supp par la suite.

		Choose Case sVal
			Case "DARTY_ABONNEMENT"
		
				// Recherche module adhésion
				lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'TRANCHE_TARIF'", 1, idwWDivSin.RowCount () )
			
				If lRow > 0 Then 
					// Lecture module adhésion
					lModule = idwWDivSin.GetItemNumber ( lRow, "VAL_NBRE" )
					
					// If stGlb.sCodOper = "JFF" Then lModule = 2
		
					// [PC662_VDOC9376_M6646]				
					// Surfacturation hors IPHONE !!
					If Pos ( isModlPortAdh, "IPHONE" ) <= 0 And ( lnv_string.of_Getkeyvalue( isInfoSpbFrnCplt, "NEUF_REC", ";") = "REC" ) Then
					
						Choose Case sIdTypArtCmd
							Case "TEL"
		
								Choose Case lModule 
									Case 1
										lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "MAJOR_CONTRACTUELLE_EUROS", "10", ";")
									Case 2
										lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "MAJOR_CONTRACTUELLE_EUROS", "23", ";")
									Case 3						
										lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "MAJOR_CONTRACTUELLE_EUROS", "35", ";")
										
								End Choose
								
						End Choose
					End IF
		
				End If
				
		End Choose
	End If			
End If
// [PC662][POINT7]

//[DOC14293]
lRow = idwWDivsin.Find ( "NOM_ZONE = 'code_verrou_sherpa_script'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	 sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
	 If IsNull ( sVal ) Then sVal = ""
	 If Len ( sVal ) > 0 Then
		 lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_VERROU_ORIG", sVal, ";")
	 End If
End If	
//[VDOC14293]

// [PM259-1]
lRow = idwWDivsin.Find ( "NOM_ZONE = 'code_parental'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	 sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
	 If IsNull ( sVal ) Then sVal = ""
	 If Len ( sVal ) > 0 Then
		 lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_PARENTAL", sVal, ";")
	 End If
End If	
// [PM259-1]

// [PC14495]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 261 )	
If lDeb > 0 Then
	If dcMtValAchat < 100 Then
		stMessage.sCode = "COMD866"
		
		stMessage.bouton = OK!
		F_Message ( stMessage )	
		sPos = "ALT_CHOIX"
		Return "G" + "ALT_CHOIX"
	End If			
End If
// [PC14495]

// [PC13321]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 266 )	
If lDeb > 0 And sTypArt = "PRS" And lInfoSpbFrn = 0 Then
	stMessage.sCode = "COMD894"
	
	stMessage.bouton = OK!
	F_Message ( stMessage )	
	sPos = "ALT_CHOIX"
	Return "G" + "ALT_CHOIX"
End If


// [VDOC16011]
lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "MT_PEC", String ( idcMtPec, "##0.00" ), ";")		

//	[VDOC15533]
Choose Case sIdRefFour 
	Case "A_REPARER"
		sSkuIfr = Space ( 35 )
		SQLCA.PS_S_SKU_IFR ( isMarqPortAdh, isModlPortAdh, sSkuIfr )
		If IsNull ( sSkuIfr ) Then sSkuIfr = ""
		
		lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "SKU_IFR", sSkuIfr, ";")
End Choose 	

// [DT200]
Choose Case sIdRefFour 
	Case "A_REPARER"
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 290 )	
		For lCpt = lDeb To lFin
	
			sVal = idw_DetPro.GetItemString ( lCpt, "VAL_CAR" ) 
			sVal = lnv_string.of_getkeyvalue (sVal, "MODL", ";")		
			If Pos ( isModlPortAdh, sVal ) > 0 Then
				lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "NE_PAS_REPARER", "OUI", ";")
				idwArticle.SetItem ( alCpt, "PROBLEME", "SUITE IRREPARABILITE CONSTATEE EN BOUTIQUE AGREEE  NE PAS CHERCHER À REPARER CET APPAREIL  RETOURNER DANS TOUS LES CAS 21 IRREPARABLE  MAIS QUALIFIER L IRREPARABILITE PAR UN MOT CLE DANS LE COMMENTAIRE." )
				stMessage.sCode = "COMD940" 					
				F_Message ( stMessage )
				Exit
			End If
		Next 
End Choose 	
//	[DT200]

// [DT269]
/*
If F_CLE_A_TRUE ( "DT269" ) Then
	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'TAILLE_ECRAN'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then 
		sVal = idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" )
		If Len ( sVal ) = 3 And sVal <> "AC0" Then
			lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "TAILLE_TV", sVal, ";")			
		End If 
	End If
End If
*/

// [DT363]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 252 )		
If lDeb > 0 And isChoixAction = "C" And isTypApp = "TEL" Then
	sVal = idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ) 
	sVal = Trim ( lnv_string.of_getkeyvalue ( sVal, "ADR_MAIL_AAS", ";" ))
	If Len ( sVal ) > 0 Then 
		stMessage.sCode = "COMD974"
		stMessage.bouton = OK!
		F_Message ( stMessage )	
		sPos = "ALT_CHOIX"
		Return "G" + "ALT_CHOIX"
	End If
End If 

// [RS3220_MODDEGR_TELST]
If bModDegTLS And bARepGti Then
	stMessage.sCode = "COMD997"
	stMessage.icon  = Exclamation!
	stMessage.sTitre = "RS3220 : O2M=>TLS Mode dégradé"
	stMessage.bouton = OK!
	F_Message ( stMessage )	
	sPos = "ALT_CHOIX"
	Return "G" + "ALT_CHOIX"		
End If 
	

Return sPos

end function

public subroutine uf_initpardefaut (integer aicas);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_InitParDefaut (PUBLIC) [DCMP090327].[SBETV] modif en Public !!
//* Auteur			: Fabry JF
//* Date				: 19/09/2001
//* Libellé			: Initialisation par Défaut du Fournisseur et du Type D'article
//* Commentaires	: 
//*
//* Arguments     : Integer	aicas	val  // 1er ou 2ème tour   [DCMP090327].[SBETV] Ajout !!
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 09/12/2002	  Bug de l'affichage du compteur des types articles :
//*								  l'init. n'était faite qu'après filtre et donc sur
//*								  un seul type d'article => on positionne le filtre
//*								  à vide, on initialise et on laisse repositionner
//*								  le filtre tel qu'il était.
//* #2	 JFF	 25/06/2004   DCMP 40206 : Choix du fournisseur en fonction du Mobile
//* #3	 JFF   07/10/2004	  DCMP 40295 : Choix du/des fournisseurs en fonction de l'action C,S,R
//* #4	 JFF   17/10/2007   DCMP 070698 : Appliquer le MT_PEC sur le TTC_FOURN ou TTC_IFR du mob de rempl
//* #5    JFF   04/09/2009   [DCMP090327].[SBETV]
//* #6    JFF   27/01/2010   [DCMP090283]
//* #6    JFF   23/03/2012   [VDOC7271] Refonte substitution
//*       JFF   27/04/2012   [VDOC7726] Transfert Cordon vers PSM
//*       JFF   29/11/2016   [PC151259][M0022804]
//*---------------------------------------------------------------

Long lIdProd, lRowFourn, lRowTypArt, lTot, lcpt, lRow, lDeb, lFin
String sCodeFour, sTypArt, sIdFournDef, sIdGti, sFiltreArt, sVar, sFiltreFrn, sExclusion, sIdFour, sIdFourSav
n_cst_string lnvPFCString // #4
String sPorteeApplicationMTPEC // #4

sIdGti = String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) )


// #4 
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 92 )
If lDeb > 0 Then
	sPorteeApplicationMTPEC = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "SIMPA2", ";")

	Choose Case sPorteeApplicationMTPEC 
		Case "TTC_FOURN"
			idwArticle.Modify ( "mt_prix_ttc.expression='~Round ( (mt_prix_ht + (  mt_prix_ht *  tva / 100 ) ) , 2 )'" )

		Case "TTC_IFR"
			idwArticle.Modify ( "mt_prix_ttc.expression='~IF ( mt_prix_ifr = 0 or IsNull ( mt_prix_ifr ) , Round ( (mt_prix_ht + (  mt_prix_ht *  tva / 100 ) ) , 2 ), mt_prix_ifr )'" ) 

		Case Else
			idwArticle.Modify ( "mt_prix_ttc.expression='~Round ( (mt_prix_ht + (  mt_prix_ht *  tva / 100 ) ) , 2 )'" ) 
			
	End Choose
	
End If
// :#4

/*------------------------------------------------------------------*/
/* Modification dynamique des attibuts par défaut						  */
/*------------------------------------------------------------------*/
// #6   [DCMP090283]
/*
idwArticle.Modify ( "choix.visible='1~tIF ((mt_prix_ttc > mt_plaf ) Or (mt_prix_ttc > mt_prix_ifr ) or (qt_disp <= 2 And id_four = ~~'ANV~~'),0,1 )'" ) 
idwArticle.Modify ( "marq_modl.color='16711680~tIF ( mt_prix_ttc > mt_plaf Or mt_prix_ttc > mt_prix_ifr or (qt_disp <= 2 And id_four = ~~'ANV~~'), 255, If ( choix = ~~'O~~', 32768, 16711680 ))'" )
idwArticle.Modify ( "marq_modl.font.weight='700~tIF ( qt_disp <= 0 or (qt_disp <= 2 And id_four = ~~'ANV~~' ), 400, 700)'" )
idwArticle.Modify ( "ordre.color='16711680~tIF ( mt_prix_ttc > mt_plaf Or mt_prix_ttc > mt_prix_ifr or (qt_disp <= 2 And id_four = ~~'ANV~~'), 255, If ( choix = ~~'O~~', 32768, 16711680 ))'" )
idwArticle.Modify ( "ordre.font.weight='700~tIF ( qt_disp <= 0 or (qt_disp <= 2 And id_four = ~~'ANV~~' ), 400, 700)'" )
idwArticle.Modify ( "qt_disp.color='16711680~tIF ( mt_prix_ttc > mt_plaf Or mt_prix_ttc > mt_prix_ifr or (qt_disp <= 2 And id_four = ~~'ANV~~'), 255, If ( choix = ~~'O~~', 32768, 16711680 ))'" )
idwArticle.Modify ( "qt_disp.font.weight='700~tIF ( qt_disp <= 0 or (qt_disp <= 2 And id_four = ~~'ANV~~' ), 400, 700)'" )
*/

idwArticle.Modify ( "choix.visible='1~tIF (mt_prix_ttc > mt_plaf),0,1 )'" ) 
idwArticle.Modify ( "marq_modl.color='16711680~tIF ( mt_prix_ttc > mt_plaf), 255, If ( choix = ~~'O~~', 32768, 16711680 ))'" )
idwArticle.Modify ( "marq_modl.font.weight='700~tIF ( qt_disp <= 0, 400, 700)'" )
idwArticle.Modify ( "ordre.color='16711680~tIF ( mt_prix_ttc > mt_plaf, 255, If ( choix = ~~'O~~', 32768, 16711680 ))'" )
idwArticle.Modify ( "ordre.font.weight='700~tIF ( qt_disp <= 0, 400, 700)'" )
idwArticle.Modify ( "qt_disp.color='16711680~tIF ( mt_prix_ttc > mt_plaf, 255, If ( choix = ~~'O~~', 32768, 16711680 ))'" )
idwArticle.Modify ( "qt_disp.font.weight='700~tIF ( qt_disp <= 0, 400, 700)'" )

// :#6 [DCMP090283]


idwArticlePrs.Modify ( "choix.visible='1~tIF ( mt_plaf = -100,0,1 )'" ) 
idwArticlePrs.Modify ( "marq_modl.color='16711680~tIF ( mt_plaf = -100, 255, If ( choix = ~~'O~~', 32768, 16711680 ))'" )


Choose Case isChoixAction
	Case "I"
		idwArticle.Modify ( "mt_prix_ttc_t.visible = 0 qt_disp_t.visible = 0 ordre.visible = 0 qt_disp.visible = 0" )
		idwArticle.Modify ( "observ_frn_t.text = 'Description zone' anc_app_t.visible = 0 descp_probl_t.visible = 0 probleme.visible = 0" )
		idwArticle.Modify ( "id_marq_art_t.Text = 'Information'" )
		idwTypArt.Modify  ( "titre_t.Text = 'Types d~~'informations'" )
	Case Else
		idwArticle.Modify ( "mt_prix_ttc_t.visible = 1 qt_disp_t.visible = 1 ordre.visible = 1 qt_disp.visible = 1" )
		idwArticle.Modify ( "observ_frn_t.text = 'Obs. Fourn' anc_app_t.visible = 1 descp_probl_t.visible = 1 probleme.visible = 1" )
		idwArticle.Modify ( "id_marq_art_t.Text = 'Article'" )
		idwTypArt.Modify  ( "titre_t.Text = 'Types d~~'articles'" )
End Choose

/*------------------------------------------------------------------*/
/* #2 : Choix du fournisseur par Défaut en fonction du mobile.      */
/*------------------------------------------------------------------*/
// [20090325093446770]
// This.uf_Chgt_Fourn_Fct_Mobile ()
// Déplacer dans le Choose Case 

/*------------------------------------------------------------------*/
/* #3 : Choix du/des fournisseurs en fonction de l'action C,S,R     */
/*------------------------------------------------------------------*/
Choose Case isChoixAction
	Case "C", "S"
		sTypArt = " AND ID_CODE_ART NOT IN ( 'PRS', 'EDI' ) ) OR ( ID_GTI = 0 AND ID_CODE_ART = '-1' ) "

	Case "R"
		// [20090325093446770]
		// #5 [DCMP090327].[SBETV]
		
		// [VDOC7726]
		This.uf_Chgt_Fourn_Fct_Mobile (aiCas)			
		
		sTypArt = " AND ID_CODE_ART = 'PRS' ) "

	Case "I"
		// [FNAC_PROD_ECH_TECH].[20090330152547023]
		// #5 [DCMP090327].[SBETV]		

		// [VDOC7726]
		This.uf_Chgt_Fourn_Fct_Mobile (aiCas)			

		sTypArt = " AND ID_CODE_ART = 'EDI' ) "

End Choose

sFiltreFrn = "( ID_GTI = " + sIdGti + " AND ID_CODE_ART <> '-1' AND ID_TYP_CODE = '-XX' " + sTypArt 

/*------------------------------------------------------------------*/
/* Fournisseur par défaut.                                          */
/*------------------------------------------------------------------*/
idwFourn.SetFilter ( sFiltreFrn )
idwFourn.Filter ( )
idwFourn.Sort ( )

/*------------------------------------------------------------------*/
/* Deuxième épuration de idwFourn                                   */
/*------------------------------------------------------------------*/
sExclusion = ""
sIdFour    = ""
sIdFourSav = ""
sTypArt    = ""
lTot = idwFourn.RowCount ()

For lCpt = 1 to lTot
	If idwFourn.GetItemNumber ( lCpt, "ID_GTI" ) = 0 Then Continue

	sIdFour = idwFourn.GetItemString ( lCpt, "ID_CODE_FRN" )
	sTypArt = idwFourn.GetItemString ( lCpt, "ID_CODE_ART" )

	// Si Egalité alors Exclusion
	If sIdFour = sIdFourSav Then
		sExclusion += " AND ( ID_CODE_FRN <> '" + sIdFour + "' OR ID_CODE_ART <> '" + sTypArt + "' ) "
	End If

	sIdFourSav = sIdFour 

Next

idwFourn.SetFilter ( sFiltreFrn + sExclusion )
idwFourn.Filter ( )
idwFourn.Sort ( )

/*------------------------------------------------------------------*/
/* L'on peut par défaut pour certains produit positionner           */
/* automatiquement le fournisseur et le typ d'article.              */
/*------------------------------------------------------------------*/
lRow = idwFourn.Find ( "ALT_CODE_DEF = 'O'", 1, idwFourn.RowCount ()) 
If lRow <= 0 Then 
	If idwFourn.RowCount () > 0 Then	lRow = 1
End If

If lRow > 0 Then 
	idwFourn.ScrollToRow ( lRow )
	idwFourn.SetRow      ( lRow )
	idwFourn.SetItem     ( lRow, "ROWSELECT", "O" )
	sIdFournDef = Upper  ( idwFourn.GetItemString ( lRow, "ID_CODE_FRN" ) )

	// CAG le 03/10/02
//	This.uf_CasPartCEGETEL ( sIdFournDef )
End If

/*------------------------------------------------------------------*/
/* #1 CAG : 09/12/02                                                */
/*------------------------------------------------------------------*/
/* On en profite pour remettre à 0 les compteurs.                   */
/*------------------------------------------------------------------*/
lTot = idwFourn.RowCount ()
For lCpt = 1 To lTot
	idwFourn.SetItem ( lCpt, "NBRE", 0 )
Next

idwTypArt.SetFilter ( "" )
idwTypArt.Filter ()
idwTypArt.Sort ()

lTot = idwTypArt.RowCount ()
For lCpt = 1 To lTot
	idwTypArt.SetItem ( lCpt, "NBRE", 0 )
Next

/*------------------------------------------------------------------*/
/* Article par defaut                                               */
/*------------------------------------------------------------------*/
/* Si nous sommes en sélection pour le courrier, il faut filtrer    */
/* (exclure) les fournisseur de prestation.                         */
/*------------------------------------------------------------------*/
Choose Case isChoixAction
	Case "S", "C"
		sFiltreArt = "ID_GTI = " + sIdGti + " AND ID_CODE_ART <> '-1' AND ID_TYP_CODE = '-XX'"
		sFiltreArt += " AND ID_CODE_ART NOT IN ( 'PRS', 'EDI' ) "
	Case "R"
		sFiltreArt = "ID_GTI = " + sIdGti + " AND ID_CODE_FRN = '" + sIdFournDef + "' AND ID_CODE_ART <> '-1' AND ID_TYP_CODE = '-XX'"
		sFiltreArt += " AND ID_CODE_ART = 'PRS'"
	Case "I"
		sFiltreArt = "ID_GTI = " + sIdGti + " AND ID_CODE_FRN = '" + sIdFournDef + "' AND ID_CODE_ART <> '-1' AND ID_TYP_CODE = '-XX'"
		sFiltreArt += " AND ID_CODE_ART = 'EDI'"
End Choose

idwTypArt.SetFilter ( sFiltreArt )
idwTypArt.Filter    ( )
idwTypArt.Sort ( )
lRow = idwTypArt.Find ( "ALT_CODE_DEF = 'O'", 1, idwTypArt.RowCount ())

If lRow <= 0 Then 
	If idwFourn.RowCount () > 0 And idwTypArt.RowCount () > 0 Then lRow = 1
End If

If lRow > 0 Then
	idwTypArt.ScrollToRow ( lRow )
	idwTypArt.SetRow    ( lRow )
	idwTypArt.SetItem     ( lRow, "ROWSELECT", "O" )
End If

Choose Case isChoixAction
	Case "S"
		sVar  = "sélection sur courrier"
	Case "C"
		sVar  = "commande"
	Case "R"
		sVar  = "réparation"
	Case "I"
		sVar  = "information"
End Choose

idwBandeau.SetItem ( 1, "NOUV_CMDE", "Aucune nouvelle " + sVar )

// 1er Tour
This.uf_RowFocusChanged ( "DWFOURN" )
This.uf_RowFocusChanged ( "DWTYPART" )

/*------------------------------------------------------------------*/
/* Le mobile de l'assuré est-il dispo chez l'un des fournisseur,    */
/* si oui, armement de : isMobileUnique                             */
/*------------------------------------------------------------------*/

// [PC151259][M0022804]
If isChoixAction <> "R" And isChoixAction <> "I" Then
	// [VDOC7271] Refonte substitution
	// [VDOC16304]
	This.uf_Existance_Mobile ()		

	
	// 2ème Tour
	This.uf_RowFocusChanged ( "DWTYPART" )
End If

end subroutine

private function string uf_controlergestionedi_sbetv (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestionEdi_SBETV (PRIVATE)
//* Auteur			: PHG (dupplique JFF)
//* Date				: 04/09/2009
//* Libellé			: Controler Spécifique pour SBETV
//* Commentaires	: [DCMP090327].[SBETV] Controle de Gestion pour le fournisseur SBE TV
//*
//* Arguments		: Long		aalCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ  PAR      Date	   Modification
//* #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
//* #2   PHG   23/06/2009  [O2M_DIAG_NOMADE]
//* #3   JFF   07/08/2009  [O2M_DIAG_NOMADE].[JFF].[20090807133737597]
//* #4   JFF   07/08/2009  [O2M_DIAG_NOMADE].[JFF].[20090901100945950]
//*      JFF   07/04/2010  [DCMP100181]
//* 		JFF   04/11/2010  [PC301].[LOT2]
//*      JFF   19/04/2010  [PM72] Modif demandée par Nathalie le 21 Mars 2011
//		   FPI	24/06/2013	[VDoc11007]
//* 		JFF   23/06/2015  [ITSM301852]
//*-----------------------------------------------------------------

String sPos, sFiltreOrig, sIdTypArt, sIdRefFour, sCodModeReg
Long lTot, lRow, lInfoSpbFrn,lIdProd, lRow1
Long lDeb, lFin //#2 
Decimal{2}   dcMtValAchat 
Boolean bRibVide
n_cst_string lnv_string

stMessage.sCode = ""
sPos = ""

sIdTypArt = idwArticle.GetItemString ( alCpt, "ID_TYP_ART" ) 	
If sIdTypArt <> "EDI" Then Return ""

// #4 [O2M_DIAG_NOMADE].[JFF].[20090901100945950]
If idwDetail.GetItemNumber ( 1, "ID_EVT" ) <> 1083 Then
	stMessage.sCode = "COMD553" // [DCMP090327].[SBETV]
	stMessage.bouton = Ok!
	F_Message ( stMessage )
	sPos = "ALT_CHOIX"
	Return "G" + "ALT_CHOIX"
End If
// :#4 [O2M_DIAG_NOMADE].[JFF].[20090901100945950]			


sIdRefFour 	= Upper ( idwArticle.GetItemString ( alCpt, "ID_REF_FOUR" ) )
lIdProd 		= idwWsin.GetItemNumber ( 1, "ID_PROD" ) 
lInfoSpbFrn = idwArticle.object.info_spb_frn[alCpt]

// #2 [O2M_DIAG_NOMADE] 1/
// Si le Appareil Non paramétré sur Option DP/95 => Message Bloquant : "Pour ce produit, ce type d'appareil ne rentre pas dans ce process"
if idw_DetPro.Find(   "ID_PROD="+ string(lIdProd) +                         &
                     " AND ID_CODE_DP=95" +                                 &
                     " AND POS(VAL_CAR, 'ACTION="+sIdRefFour+";', 1)>0" +   &
                     " AND POS(VAL_CAR, 'TYP_APP="+isTypApp+";', 1)>0"       &
                     , 1, idw_DetPro.rowCount()+1) = 0 Then
   stMessage.sCode = "COMD531" // [O2M_DIAG_NOMADE] Message : "Ce type d'appareil ne rentre pas dans ce process"
   stMessage.bouton = Ok!
   F_Message ( stMessage )
   sPos = "ALT_CHOIX"
   Return "G" + "ALT_CHOIX"
End If

// [O2M].372, Note 265, Point 1 : On vérifie que l'action choisie est cohérente avec le paramétrage du produit
if idw_DetPro.Find(	"ID_PROD="+ string(lIdProd) + 								&
							" AND POS(VAL_CAR, 'ACTION="+sIdRefFour+";', 1)>0" + 	&
							" AND POS(VAL_CAR, 'TYP_APP="+isTypApp+";', 1)>0"		&
							, 1, idw_DetPro.rowCount()+1) = 0 Then
	stMessage.sCode = "COMD463" // Msg : "Information Cochée non autorisée pour ce produit.@Veuillez sélectionner une autre information."
	stMessage.bouton = Ok!
	F_Message ( stMessage )
	sPos = "ALT_CHOIX"
	Return "G" + "ALT_CHOIX"
End If
//

// [O2M].378 : Controle du RIB SI Mode de Reglement = "Virement Auto", Info Spb Frn 415, et RibVide
sCodModeReg =  idwCmde.GetItemString ( 1, "COD_MODE_REG" ) 
bRibVide    = 	lnv_string.of_isempty ( idwCmde.GetItemString ( 1, "RIB_BQ" ) ) Or idwCmde.GetItemString ( 1, "RIB_BQ" ) = Fill ( "0", 5 ) Or &
					lnv_string.of_isempty ( idwCmde.GetItemString ( 1, "RIB_GUI" ) ) Or idwCmde.GetItemString ( 1, "RIB_GUI" ) = Fill ( "0", 5 ) Or &
					lnv_string.of_isempty ( idwCmde.GetItemString ( 1, "RIB_CPT" ) ) Or idwCmde.GetItemString ( 1, "RIB_CPT" ) = Fill ( "0", 11 ) Or&
					lnv_string.of_isempty ( idwCmde.GetItemString ( 1, "RIB_CLE" ) ) 

//*      JFF   19/04/2010  [PM72] Modif demandée par Nathalie le 21 Mars 2011
//If sIdRefFour = "A_DIAGNOSTIQUER" And Upper ( sCodModeReg ) = "VA" And bRibVide Then
//		Choose Case lInfoSpbFrn 
//			Case -1 //* #1 [FNAC_PROD_ECH_TECH]
//				stMessage.sCode = "COMD466"
//				F_Message ( stMessage )
//				Return "D" + "RIB_BQ"
//		End Choose
//End If
//

Choose Case sIdRefFour 
	Case "A_DIAGNOSTIQUER"
//		if idwCmdeSin.RowCount() > 0 then //[O2M].391 : On ignore toute prestation annulée
		if idwCmdeSin.Find( "COD_ETAT <>'ANN'", 1, idwCmdeSin.RowCount() + 1 ) > 0 then
			stMessage.sCode = "COMD456" // [O2M] : Message : Vous choisissez un flux de DIAGNOSTIQUE alors que d'autres prestations existent déjà sur le dossier, êtes vous sûr de votre choix ?
			stMessage.bouton = YesNo!
			if F_Message ( stMessage ) <> 1 Then
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"
			End If
		// [O2M].381 : Vérification qu'il n'y a pas de diagnostic déja émis et clos.
		// [DCMP090327].[SBETV]
		ElseIf idwCmdeSin.Find("ID_FOUR = 'SB1' AND ID_REF_FOUR<>'A_DIAGNOSTIQUER'", 1, idwCmdeSin.RowCount()+1 ) > 0 Then
			stMessage.sCode = "COMD554" // [O2M] : Message : Vous avez déjà émis un ou plusieurs flux de clôture avec O2M sur ce dossier.@Souhaitez-vous vraiment émettre un flux demandant un diagnostique ?"
			stMessage.bouton = YesNo!
			if F_Message ( stMessage ) <> 1 Then
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"

			End If
// [FNAC_PROD_ECH_TECH].[20090330152547023]			
/*	
		Else
			uf_message_process_o2m( alCpt, lInfoSpbFrn )
*/
		End If
		
		// [VDoc11007]
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 152)
		If lDeb > 0 Then
			dcMtValAchat=idwDetail.GetItemDecimal(1,"MT_VAL_ACHAT")
			If idwArticle.GetItemString ( alCpt, "ID_FOUR" ) ="SB1" and dcMtValAchat > 0 and dcMtValAchat < 500 Then
				
			 lRow=idwwDivDet.Find ( "ID_GTI = " + String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) ) + &
						" AND ID_DETAIL = " +  String ( idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
						" AND UPPER ( NOM_ZONE ) = 'ALT_PEC' " + &
						" AND UPPER ( VAL_LST_CAR ) <> 'O'" &
						, 1, idwwDivDet.RowCount () ) 

				If lRow > 0 Then
					stMessage.sCode = "COMD812" // Niveau insuffisant - blocage
					stMessage.bouton = OK!
					f_message(stMessage)
					sPos = "ALT_CHOIX"
					Return "G" + "ALT_CHOIX"
				End if
			End if
		End if
		// :[VDoc11007]
		
		// message du Else Je sors le 
		uf_message_process_SBETV( alCpt, lInfoSpbFrn )
// :[FNAC_PROD_ECH_TECH].[20090330152547023]			

	case "PEC_A_RECYCLER", "REFUSE_A_REEXP"
		// [O2M].382 : Vérification qu'il y a bien un diagnostic déja émis et clos avant de recycler ou refuser.
		// [DCMP090327].[SBETV]
		If idwCmdeSin.Find("ID_FOUR = 'SB1' AND ID_REF_FOUR='A_DIAGNOSTIQUER' AND STATUS_GC > 0", 1, idwCmdeSin.RowCount()+1 ) = 0 Then
			stMEssage.sVar[1] = sIdRefFour
			stMessage.sCode = "COMD555" // [O2M] : Message : "Vous ne pouvez émettre cette action (#) vers O2M sans avoir précédemment émis une demande de diagonostique."
			stMessage.bouton = Ok!
			F_Message ( stMessage )
			sPos = "ALT_CHOIX"
			Return "G" + "ALT_CHOIX"
		End If

	// [PC301].[LOT2]
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 152 )
		If lDeb > 0 Then
			If idwCmdeSin.Find("ID_FOUR = 'SB1' AND ID_REF_FOUR='A_DIAGNOSTIQUER' AND STATUS_GC = 171 AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount()+1 ) > 0 Then
				stMessage.sCode = "COMD619" // [O2M] : Message : "Vous ne pouvez émettre cette action (#) vers O2M sans avoir précédemment émis une demande de diagonostique."
				stMessage.bouton = Ok!
				F_Message ( stMessage )
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"
			End If		
		End If
	// [PC301].[LOT2]
	
// [DCMP100181]
		// [ITSM301852]
		lRow = idwCmdeSin.Find("ID_FOUR = 'SB1' AND ID_REF_FOUR='A_DIAGNOSTIQUER' AND STATUS_GC = 170 AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount()+1 )
		lRow1 = idwCmdeSin.Find("ID_FOUR = 'SB1' AND ID_REF_FOUR='A_DIAGNOSTIQUER' AND STATUS_GC in ( 151, 152, 171 ) AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount()+1 )
		If lRow > 0 And ( lRow1 <= 0 Or ( lRow1 > 0 And lRow < lRow1 ) ) Then
			stMessage.sCode = "COMD619" // [O2M] : Message : "Vous ne pouvez émettre cette action (#) vers O2M sans avoir précédemment émis une demande de diagonostique."
			stMessage.bouton = Ok!
			F_Message ( stMessage )
			sPos = "ALT_CHOIX"
			Return "G" + "ALT_CHOIX"
		End If
// :[DCMP100181]

End Choose

Return sPos

end function

public subroutine uf_message_process_sbetv (long alrow, long alinfospbfrn);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::uf_message_process_sbetv
//* Auteur			: Pierre-Henri Gillot (JFF)
//* Date				: 04/09/2009 
//* Libellé			: 
//* Commentaires	: Affiche les message de PRocess SBETV au gestionnaire
//*					  en fonction de l'info_spb_frn selectionnée
//*					  [DCMP090327].[SBETV]
//*
//* Arguments		: 
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF	20/10/2008	  [FNAC_PROD_ECH_TECH]
//* #2    JFF  13/02/2008    [FNAC_PROD_ECH_TECH].[20090223142259343]
//* #3    JFF  13/02/2008    [FNAC_PROD_ECH_TECH].[20090224144248310]
//* #4    JFF  30/03/2009    [FNAC_PROD_ECH_TECH].[20090330152547023]
//* #5    JFF  23/04/2009    [LCL_NOMADE]
//* #6    JFF  19/05/2009    [DCMP090172]
//* #7    JFF  05/05/2009    [RUEDUCOMMERCE]
//* #8    JFF  05/05/2009    [DCMP090298]
//* #9    JFF   25/11/2009   [MSS_DIAG]
//*-----------------------------------------------------------------

string sCodMSg, sMtFrais, sCommentaireFrais
String sVar[]
String sNumCmde, sAction, sTypApp, sTaillecoli, sNomContractant, sPc74
String sAppSin, sAlimSin, sBattSin //  [FNAC_PROD_ECH_TECH]
decimal{2} dcMtFrais
Boolean bPc441 // Pièce facture d'achat&Reglt cotisation.
Boolean bPc74  // Copie bulletion adhésion
Boolean bRDCommerce // #7 [RUEDUCOMMERCE]
Boolean bFNACEpt  //* #8 [DCMP090298]
long	lRow, lDeb, lFin
n_cst_attrib_key	lnv_key[], lnv2_key[]
n_cst_string	lnv_string
n_cst_string   lnvPFCString

dcMtFrais = -1
sMtFrais = ""
sTaillecoli = ""
sCommentaireFrais = ""

// #6 [DCMP090172]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 59 )
If lDeb > 0 Then
	sNomContractant = Trim ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ) )
Else 
	sNomContractant = ""
End If
If IsNull ( sNomContractant ) Then sNomContractant = ""
// :#6 [DCMP090172]

//* #7 [RUEDUCOMMERCE]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 114 )
bRDCommerce = lDeb > 0
//* :#7 [RUEDUCOMMERCE]

//* #8 [DCMP090298]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 105 )
bFNACEpt = lDeb > 0
//* :#8 [DCMP090298]

//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
// Facture d'achat de l'appareil garantie
bPc441 = idwWpieceGti.Find ( "ALT_RECLAME = 'O' AND ID_PCE = 441", 1, idwWpieceGti.RowCount () ) > 0

//* #4    JFF  30/03/2009    [FNAC_PROD_ECH_TECH].[20090330152547023]
bPc74 = idwWpieceGti.Find ( "ALT_RECLAME = 'O' AND ID_PCE = 74", 1, idwWpieceGti.RowCount () ) > 0
If bPc74 Then
	sPc74 = "- Le bulletin d'adhésion"
	//* #7 [RUEDUCOMMERCE].[CRTEST1]
	If bRDCommerce Then
		sPc74 = "- La copie du certificat d'adhésion"					
	End If
	//* #7 [RUEDUCOMMERCE].[CRTEST1]				
Else
	sPc74 = ""
End If


if idwWsin.rowCount() > 0 Then
	sNumCmde	= string(idwWsin.object.id_sin[1])+"-"+string(uf_nouveau_num_sequence( ))

	// L'appareil est-il sinistré ?
	sAppSin = "NON"
	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'APP_SIN'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then 
		If Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" Then
			sAppSin = "OUI"
		End If
	End If
	
	// La batterie est-elle sinistrée ?
	sBattSin = "NON"
	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'BATT_SIN'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then 
		If Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" Then
			sBattSin = "OUI"
		End IF
	End If
	
	// L'alim est-elle sinistrée ?
	sAlimSin = "NON"
	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'ALIM_SIN'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then 
		If Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" Then
			sAlimSin = "OUI"
		End If
	End If
	
	sAction	= 'A_DIAGNOSTIQUER'
	sTypApp	= isTypApp


	// #1 JFF [FNAC_PROD_ECH_TECH]				
	// Cas particulier : si batt ext ou alim ext, on passe en process identique à B donc mt_frais d'une catégorie B
/* Non géré sur SBETV
	If sBattSin = "OUI" Or sAlimSin = "OUI" Then
		lnv2_Key[1].iskeyname  = "CTG"
		lnv2_Key[1].iakeyvalue = "B"
		lnv2_Key[2].iskeyname	 ="ACTION"
		lnv2_Key[2].iakeyvalue = sAction
		lnv2_Key[3].iskeyname  ="MT_FRAIS"		
		F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv2_Key )
	End If
	// :#1 JFF [FNAC_PROD_ECH_TECH]				
*/	
	lnv_Key[1].iskeyname	 ="TYP_APP"
	lnv_Key[1].iakeyvalue =sTypApp
	lnv_Key[2].iskeyname	 ="ID_COUR"
	lnv_Key[3].iskeyname	 ="ACTION"
	lnv_Key[3].iakeyvalue = sAction
	lnv_Key[4].iskeyname	 ="PROCESS_ALT"

	// #1 JFF [FNAC_PROD_ECH_TECH]				
	lnv_Key[5].iskeyname	 ="CTG"
	lnv_Key[6].iskeyname	 ="EMBORG"
	lnv_Key[7].iskeyname	 ="PROCESS_EMBORG"
	lnv_Key[8].iskeyname	 ="DEPOT_FNAC_ALT"
	lnv_Key[9].iskeyname	 ="PROCESS_FNAC_ALT"
	lnv_Key[10].iskeyname ="FRN_ALT"
	lnv_Key[11].iskeyname ="MT_FRAIS"
	lnv_Key[12].iskeyname ="CPLT_ADR_FRN_PROD"	
	//* #5 [LCL_NOMADE]
	lnv_Key[13].iskeyname ="TAILLE_COLI"	
	
	// :#1 JFF [FNAC_PROD_ECH_TECH]				

	F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv_Key )


	if lRow > 0 Then

		If sBattSin = "OUI" Or sAlimSin = "OUI" Then		
			If IsNumber ( lnv2_Key[3].iakeyvalue ) Then // #1 JFF [FNAC_PROD_ECH_TECH]	
				dcMtFrais = dec (lnv2_Key[3].iakeyvalue)
			// #1 JFF [FNAC_PROD_ECH_TECH]	
			Else 
				sMtFrais = lnv2_Key[3].iakeyvalue
			End If
	
		Else
		
			If IsNumber ( lnv_Key[11].iakeyvalue ) Then // #1 JFF [FNAC_PROD_ECH_TECH]	
				dcMtFrais = dec (lnv_Key[11].iakeyvalue)
			// #1 JFF [FNAC_PROD_ECH_TECH]	
			Else 
				sMtFrais = lnv_Key[11].iakeyvalue
			End If
			// :#1 JFF [FNAC_PROD_ECH_TECH]				
		End If

		//* #7 [RUEDUCOMMERCE].[CRTEST1]
		If bRDCommerce Then
			sCommentaireFrais += " (Si envoi depuis la France)"
		End If
		//* #7 [RUEDUCOMMERCE].[CRTEST1]				

		//* #5 [LCL_NOMADE]
		If lnv_Key[13].iakeyvalue <> "" And Not IsNull ( lnv_Key[13].iakeyvalue ) Then
			sTaillecoli = lnv_Key[13].iakeyvalue
		End If
		
	End If

	choose Case alInfoSpbFrn
			

		Case 	1110
			sCodMsg = "COMD558"		

			sVar[1] = "Appareil sinistré/batterie interne : " + sAppSin
			sVar[2] = "Batterie amovible sinistrée : " + sBattSin
			sVar[3] = "Câble d'alimentation sinistrée : " + sAlimSin

			// Pour SBETV, pas d'affichage concernant la batterie ni l'alim			
			sVar[2] = ""
			sVar[3] = ""

			//* :#7 [RUEDUCOMMERCE].[CRTEST1]			
			
			sVar[4] = lnv_Key[5].iakeyvalue // "Appareil de catégorie : "

			// Sur 935,940 c'est forcément l'appareil qui est sinitré.
			sVar[5] = "son appareil et tous les accessoires d'origine (manuel, etc)"

			//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
			If bPc441 Then
				sVar[7] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
			Else
				sVar[7] = ""
			End If

			//* #4 [FNAC_PROD_ECH_TECH].[20090330152547023]
			sVar[8] = sPc74
			
			sVar[9] = sNumCmde
			
		Case 	1115

			sCodMsg = "COMD559" // #6 [DCMP090172]

			sVar[1] = "Appareil sinistré/batterie interne : " + sAppSin
			sVar[2] = "Batterie amovible sinistrée : " + sBattSin
			sVar[3] = "Câble d'alimentation sinistrée : " + sAlimSin

			// Pour SBETV, pas d'affichage concernant la batterie ni l'alim			
			sVar[2] = ""
			sVar[3] = ""
			
			sVar[4] = lnv_Key[5].iakeyvalue // "Appareil de catégorie : "

			//* #2 [FNAC_PROD_ECH_TECH].[20090223142259343]
			If sAppSin = "OUI" Then 
				sVar[5] = "son appareil et tous les accessoires d'origine (manuel, etc)"
			ElseIf sBattSin = "OUI" And sAlimSin = "OUI" Then 
				sVar[5] = "sa batterie amovible, son alimentation externe et tous les accessoires d'origine (manuel, etc)"				
			ElseIF sBattSin = "OUI" Then
				sVar[5] = "sa batterie amovible et tous les accessoires d'origine (manuel, etc)"
			ElseIF sAlimSin = "OUI" Then
				sVar[5] = "son alimentation externe et tous les accessoires d'origine (manuel, etc)"
			End If

			// #6 [DCMP090172]
			If sNomContractant = "" Then 
				sVar[6] = "en magasin"
			Else
				sVar[6] = "chez " + sNomContractant
			End If
			// :#6 [DCMP090172]

			If alInfoSpbFrn = -1 Then
				sVar[7] = "pour dépôt du conditionnement chez FNAC puis enlèvement pour expédition vers SBE TV "
				sVar[8] = "20x20x20 cm"
			ElseIf alInfoSpbFrn = -2 Then
				sVar[7] = "pour dépôt du conditionnement chez FNAC puis enlèvement pour expédition vers SBE TV "
				sVar[8] = "30x30x30 cm"
			ElseIf alInfoSpbFrn = -3 Then
				sVar[7] = "pour dépôt du conditionnement chez FNAC puis enlèvement pour expédition vers SBE TV "
				sVar[8] = "50x50x25 cm"
			ElseIf alInfoSpbFrn = -4 Then
				sVar[7] = "pour dépôt du conditionnement chez FNAC puis enlèvement pour expédition vers SBE TV "
				sVar[8] = "50x50x50 cm"
			ElseIf alInfoSpbFrn = 1115 Then
				sVar[7] = "pour enlèvement et expédition vers SBE TV "
				sVar[8] = "spécial"
			Else 
				sVar[7] = "pour dépôt du conditionnement chez FNAC puis enlèvement pour expédition vers SBE TV "
				sVar[8] = "(inconnu)"
			End If
			//* :#2 [FNAC_PROD_ECH_TECH].[20090223142259343]

			// #6 [DCMP090172]
			If sNomContractant = "" Then 
				sVar[9] = "en magasin"
			Else
				sVar[9] = "chez " + sNomContractant
			End If
			// :#6 [DCMP090172]

			//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
			If bPc441 Then
				sVar[10] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
			Else
				sVar[10] = ""
			End If

			//* #4 [FNAC_PROD_ECH_TECH].[20090330152547023]
			sVar[11] = sPc74

			sVar[12] = sNumCmde
			
			
// :#1 JFF [FNAC_PROD_ECH_TECH]							
	End Choose

	//* #9  [MSS_DIAG]
	If sCodMsg <> "" Then
		stMessage.scode = sCodMsg
		stMessage.sVar = sVar
	
		F_Message(stMessage)
	End If
	//* :#9  [MSS_DIAG]
	
End If




end subroutine

private subroutine uf_gestionzone_infospbfrn_sbetv_1100 (ref n_cst_attrib_key alnv_key[], ref long aldefaut, ref boolean abrdvaprendre);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_Commande3::uf_GestionZone_InfoSpbFrn_SBETV_1100 (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 04/10/2008 17h12
//* Libellé       : Process particuliers pour FNAC EPT sur liste 1100
//* Commentaires  : [DCMP090327].[SBETV]
//*
//* Arguments     : n_cst_attrib_key  alnv_key[]		Réf		// Valeur par défaut dans la zone
//*		    		  Long				  alDefaut        Réf	   // Process retenu
//*					  Boolean			  abRdvAPrendre   Réf      // TRUE : Un Rdv est à prendre.
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    13/02/2008  [FNAC_PROD_ECH_TECH].[20090213145759303]
//* #2    JFF    13/02/2008  [FNAC_PROD_ECH_TECH].[20090223142259343]
//* #3    JFF    19/05/2009  [DCMP090172]
//* #4    JFF    05/05/2009  [RUEDUCOMMERCE]
//* #5    JFF    28/07/2009  [DCMP090378]
//*       JFF    26/07/2010  [ITSM_40837] Bug incomprehensible (perte de code suite fusion à mon avis)
//*       JFF    05/07/2011  [PC292][AUCHAN]
//*       JFF    04/01/2011  [VDOC9839]
//*-----------------------------------------------------------------

stMessage.sTitre		= "Process"
Boolean bDepotFNAC, bEmbOrig, bAppSin, bAlimSin, bBattSin, bRtrParTrp, bPrestaExistante, bMaterielChezSBETV, bFNACEpt
String  sCTG, sNomContractant, sResidant
Long 	  lRow, lDeb, lFin
n_cst_string	lnv_string
Boolean bRDCommerce // #4 [RUEDUCOMMERCE]
Boolean bCltFrontalier, bCarrefour 

alDefaut = 0

If isInfoSpbFrncplt <> "" Then
		isInfoSpbFrncplt += ";"
End If
isInfoSpbFrncplt += "MAT_SIN="	

abRdvAPrendre = FALSE

bDepotFNAC = FALSE
bEmbOrig= FALSE
bRtrParTrp = False
bAppSin = FALSE
bAlimSin = FALSE
bBattSin = FALSE
sResidant=""

// [PC292][AUCHAN]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 140 )
If lDeb > 0 Then
	sResidant = Trim ( lnv_string.of_Getkeyvalue( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "RESIDANT", ";") )
End If
// [PC292][AUCHAN]

// #3 [DCMP090172]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 59 )
If lDeb > 0 Then
	sNomContractant = Trim ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ) )
Else 
	sNomContractant = ""
End If
If IsNull ( sNomContractant ) Then sNomContractant = ""
// :#3 [DCMP090172]


//* #4 [RUEDUCOMMERCE]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 114 )
bRDCommerce = lDeb > 0
//* :#4 [RUEDUCOMMERCE]

//* #5 [DCMP090378]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 105 )
bFNACEpt = lDeb > 0
//* :#5 [DCMP090378]

// [VDOC9839]
bCarrefour=FALSE
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 152 )
bCarrefour = lDeb > 0
// [VDOC9839]

// L'appareil est-il sinistré ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'APP_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bAppSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

// La batterie est-elle sinistrée ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'BATT_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bBattSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

// L'alim est-elle sinistrée ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'ALIM_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bAlimSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

// La catégorie de l'appareil
sCTG = alnv_key [5].iaKeyValue

//* #1 [FNAC_PROD_ECH_TECH].[20090213145759303]
bPrestaExistante = idwCmdeSin.Find ( "ID_FOUR = 'SB1' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER'", 1, idwCmdeSin.RowCount ()) > 0 

// [VDOC9839] And Not bCarrefour
If bPrestaExistante And Not bCarrefour Then
	stMessage.Bouton		= YESNO!
	stMessage.Icon			= Question!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "COMD556"
	bMaterielChezSBETV = f_Message ( stMessage ) = 1
End If

// Si l'appareil est sinistrée, les deux question qui suivent ont un sens.
If bAppSin Then  
	isInfoSpbFrncplt += "[SIN_APP]"

	// [PC292][AUCHAN] Assuré Frontalier
	If alDefaut = 0 And Not bMaterielChezSBETV And Not bDepotFNAC And alnv_key [22].iaKeyValue = "OUI" Then
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD659"
		stMessage.sVar [1]   = 	sResidant
		bCltFrontalier = f_Message ( stMessage ) = 1

		If bCltFrontalier Then
			bDepotFNAC = TRUE
			stMessage.Bouton		= OK!
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "COMD660" 
			stMessage.sVar [1]   = sNomContractant
			f_Message ( stMessage )
			alDefaut = Long ( alnv_Key[23].iaKeyValue ) 
		End If
	End If
	// [PC292][AUCHAN] 


	//* #2 [FNAC_PROD_ECH_TECH].[20090223142259343] inversion des deux questions

	// La catégorie autorise-t-elle un dépôt chez FNAC, si oui, on pose la question uniquement pour CTG A et B
// [ITSM_40837] 
//	If Not bMaterielChezSBETV And alnv_key [6].iaKeyValue = "OUI" Then
	If alDefaut = 0 And Not bMaterielChezSBETV And alnv_key [24].iaKeyValue = "OUI" Then
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD541" // #3 [DCMP090172] #5 [DCMP090378]
		stMessage.sVar[1]		= "son appareil"		
		stMessage.sVar[2] 	= sNomContractant // #3 [DCMP090172]
		stMessage.sVar[3]    = ""

// [20091007140933640]
		// #5 [DCMP090378] Armement contextuel de la troisième variable en fonction du contractant
		If bFNACEpt Then
			stMessage.sVar[3] = "(question à poser aux clients One uniquement, si pas client One : réponse = non)"
		End If
		// :#5 [DCMP090378]
// [20091007140933640]				

		bDepotFNAC = f_Message ( stMessage ) = 1
// [ITSM_40837] 
//		If bDepotFNAC Then alDefaut = Long ( alnv_Key[7].iaKeyValue ) // Process Fnac
		If bDepotFNAC Then alDefaut = Long ( alnv_Key[25].iaKeyValue ) // Process Fnac
	End If

	// Si pas de dépôt FNAC ni EMBallage d'ORIGine alors process par défaut pour la catégorie paramètré

	If alDefaut = 0 Then
// [ITSM_40837] 
//		alDefaut = Long ( alnv_Key[4].iaKeyValue ) // Process 
		alDefaut = Long ( alnv_Key[26].iaKeyValue ) // Process 
	End If

End If

// Si l'appareil n'est pas sinistrée
If Not bAppSin Then  
	// On ne traite que le de AppSin seul
	
End If


// En fonction du process, y a-t-il un RDV à prendre ?
// Pas de RDV pour SBETV (vu avec Aurélien) SBETV se charge du RDV.
Choose Case alDefaut
	Case -1

		If Not bMaterielChezSBETV Then 
			abRdvAPrendre = TRUE
		End If
		
	Case Else
		// Pour les autres cas, il s'agit d'envoi pas l'assuré ou passage O2M/TRP chez FNAC
End Choose

//* #1 [FNAC_PROD_ECH_TECH].[20090213145759303]
If bMaterielChezSBETV Then 
	alDefaut = 1102
End If

If isDept <> "" Then
	If isInfoSpbFrncplt <> "" Then
		isInfoSpbFrncplt += ";"
	End If
	isInfoSpbFrncplt += "DEPT_ENLEV=" + isDept
End If

end subroutine

private subroutine uf_gestionzone_infospbfrn_mssdiag_1200 (ref n_cst_attrib_key alnv_key[], ref long aldefaut, ref boolean abrdvaprendre);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_Commande3::uf_GestionZone_InfoSpbFrn_MSSDIAG_1200 (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 30/10/2009 17h12
//* Libellé       : 
//* Commentaires  : [MSS_DIAG]
//*
//* Arguments     : n_cst_attrib_key  alnv_key[]		Réf		// Valeur par défaut dans la zone
//*		    		  Long				  alDefaut        Réf	   // Process retenu
//*					  Boolean			  abRdvAPrendre   Réf      // TRUE : Un Rdv est à prendre.
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    13/02/2008  [FNAC_PROD_ECH_TECH].[20090213145759303]
//* #2    JFF    13/02/2008  [FNAC_PROD_ECH_TECH].[20090223142259343]
//* #3    JFF    19/05/2009  [DCMP090172]
//* #4    JFF    05/05/2009  [RUEDUCOMMERCE]
//* #5    JFF    28/07/2009  [DCMP090378]
//* #6    JFF    02/09/2009  [DCMP090327].[SBETV]
//* #7    JFF    07/10/2009  [DCMP090421]
//* #8    JFF    16/11/2009  [DCMP090421].[20091116110244950]
//* #9    JFF    18/11/2009  [DCMP090421].[20091118105631390]
//* #10   JFF    02/03/2010  [MSS_LOT2]
//*-----------------------------------------------------------------

stMessage.sTitre		= "Process"
Boolean bDepotFNAC, bEmbOrig, bAppSin, bAlimSin, bBattSin, bRtrParTrp, bPrestaExistante, bAccSin
Boolean bMaterielChezMSS, bFNACEpt, bCltVIP, bEnvoiOuTeleChg, bEmbOrigOk, bAssEnvColissimo, bEnvCartonPrepaye
String  sCTG, sNomContractant, sVal, sCas2flux 
Long 	  lRow, lDeb, lFin, lPos
Long    lStatusGCActuel, lInfoSpbFrnOrig
n_cst_string	lnv_string
Boolean bRDCommerce // #4 [RUEDUCOMMERCE]

alDefaut = 0

// #6 [DCMP090327].[SBETV]
If isInfoSpbFrncplt <> "" Then
		isInfoSpbFrncplt += ";"
End If
isInfoSpbFrncplt += "MAT_SIN="	

abRdvAPrendre = FALSE

bDepotFNAC = FALSE
bEmbOrig= FALSE
bRtrParTrp = False
bAppSin = FALSE
bAlimSin = FALSE
bBattSin = FALSE
bAccSin = FALSE //* #10 [MSS_LOT2].[P3]
bCltVIP = FALSE // #7 [DCMP090421]
bEnvoiOuTeleChg = FALSE // #7 [DCMP090421]
bAssEnvColissimo = False //* #10 [MSS_LOT2].[P_JFF_2]
sCas2flux = ""
bMaterielChezMSS = False // [MSS_LOT2].[P_JFF_2]

// #3 [DCMP090172]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 59 )
If lDeb > 0 Then
	sNomContractant = Trim ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ) )
Else 
	sNomContractant = ""
End If
If IsNull ( sNomContractant ) Then sNomContractant = ""
// :#3 [DCMP090172]


//* #4 [RUEDUCOMMERCE]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 114 )
bRDCommerce = lDeb > 0
//* :#4 [RUEDUCOMMERCE]

//* #5 [DCMP090378]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 105 )
bFNACEpt = lDeb > 0
//* :#5 [DCMP090378]

// L'appareil est-il sinistré ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'APP_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bAppSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

// La batterie est-elle sinistrée ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'BATT_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bBattSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

// L'alim est-elle sinistrée ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'ALIM_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bAlimSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

//* #10 [MSS_LOT2].[P_JFF_2]
// Un autre acc est-il sinitré ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'AUT_ACC_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bAccSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

// La catégorie de l'appareil
sCTG = alnv_key [5].iaKeyValue

//* #1 [FNAC_PROD_ECH_TECH].[20090213145759303]
bPrestaExistante = idwCmdeSin.Find ( "ID_FOUR = 'MS1' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount ()) > 0 

//* #1 [MSS_LOT2]
If bPrestaExistante Then
	// Cas d'un nouveau clic sur A_DIAG alors qu'une presta de diag non annulée existe déjà.
 	sCas2flux = This.uf_GestionZone_InfoSpbFrn_MSSDIAG_1200_2 ( lStatusGCActuel, lInfoSpbFrnOrig ) 
	
	isCas2FluxMS1 = sCas2flux  // Pour trt message résumé
	
	If sCas2flux = "AUCUN_CHOIX" Then
		ibDecocherPresta = TRUE
		Return
	End If
	
	If sCas2flux = "ERREUR_INCOHERENCE_ETAT_PRESTA" Then
		stMessage.Bouton		= OK!
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD605"
		F_Message ( stMessage )

		ibDecocherPresta = TRUE
		Return
	End If

	// Traitement du cas 
 	This.uf_GestionZone_InfoSpbFrn_MSSDIAG_1200_3 ( sCas2flux, alDefaut, abRdvAPrendre, lStatusGCActuel, lInfoSpbFrnOrig )
	 
	Choose Case alDefaut
		Case -1000 // Cas d'un nouveau process entier. 
			// On contiue
			alDefaut = 0

		Case 1262, 1202
			If bAppSin Then  
				lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "MAT_SIN", "[SIN_APP]", ";")
			End If
			
			If bBattSin Then 
				lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "MAT_SIN", "[SIN_BATT]", ";")
			End If

			If bAlimSin Then 
				lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "MAT_SIN", "[SIN_ALIM]", ";")
			End If

			If bAccSin Then 
				lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "MAT_SIN", "[SIN_AUT_ACC]", ";")
			End If
			Return
			
		Case Else 
			Return
	End Choose 
End If

/*
If bPrestaExistante Then
	stMessage.Bouton		= YESNO!
	stMessage.Icon			= Question!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "COMD571"
	bMaterielChezMSS = f_Message ( stMessage ) = 1
End If
*/

// Si l'appareil est sinistrée, les deux question qui suivent ont un sens.
If bAppSin Then  
	isInfoSpbFrncplt += "[SIN_APP]"

	// #7 [DCMP090421]
	If Not bMaterielChezMSS And alnv_key [14].iaKeyValue = "OUI" Then
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD560" 

		stMessage.sVar[1]		= "VIP"
		If bFNACEpt Then
			stMessage.sVar[1]		= "ONE"
		End If

		stMessage.sVar[2]	= sNomContractant // #3 [DCMP090172]			
			
		bCltVIP = f_Message ( stMessage ) = 1
	End If
	// #7 [DCMP090421]
	//* #2 [FNAC_PROD_ECH_TECH].[20090223142259343] inversion des deux questions

	// La catégorie autorise-t-elle un dépôt chez FNAC, si oui, on pose la question uniquement pour CTG A et B
	// [DCMP090421] ajout bCltVIP
	If Not bMaterielChezMSS And bCltVIP And alnv_key [8].iaKeyValue = "OUI" Then
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD541" // #3 [DCMP090172] #5 [DCMP090378]
		stMessage.sVar[1]		= "son appareil"		
		stMessage.sVar[2] 	= sNomContractant // #3 [DCMP090172]
		stMessage.sVar[3]    = ""

	// #7 [DCMP090421]
   /*
		// #5 [DCMP090378] Armement contextuel de la troisième variable en fonction du contractant
		If bFNACEpt Then
			stMessage.sVar[3] = "(question à poser aux clients One uniquement, si pas client One : réponse = non)"
		End If
		// :#5 [DCMP090378]
   */
	// :#7 [DCMP090421]

		bDepotFNAC = f_Message ( stMessage ) = 1
		If sCTG = "C" And bDepotFNAC Then
			alDefaut = Long ( alnv_Key[9].iaKeyValue ) // Process Fnac			
		End If
		
	End If

	// Colissimo
//* #10 [MSS_LOT2].[P_JFF_2]
/*
	If Not bMaterielChezMSS And sCTG = "C" And ( Not bCltVip Or ( bCltVip And Not bDepotFNAC ) ) And alDefaut = 0 Then
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD572" 
	
		bAssEnvColissimo = f_Message ( stMessage ) = 1
		If bAssEnvColissimo Then
			alDefaut = Long ( alnv_Key[4].iaKeyValue ) 
		End If
	End If 
*/
	// Carton PréPayé
	If Not bMaterielChezMSS And sCTG = "C" And ( Not bCltVip Or ( bCltVip And Not bDepotFNAC ) ) And &
		Not bAssEnvColissimo And alDefaut = 0 And alnv_Key[20].iaKeyValue = "OUI" Then

		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD573" 
		
		bEnvCartonPrepaye = f_Message ( stMessage ) = 1
		If bEnvCartonPrepaye Then
			alDefaut = Long ( alnv_Key[21].iaKeyValue ) 
		End If
	End If 

	If Not bMaterielChezMSS And sCTG = "C" And ( Not bCltVip Or ( bCltVip And Not bDepotFNAC ) ) And &
		Not bAssEnvColissimo And Not bEnvCartonPrepaye And alDefaut = 0 Then
// #10 [MSS_LOT2].[P_JFF_1]		
/*
		And alnv_Key[6].iaKeyValue = "OUI" Then
	
			stMessage.Bouton		= YESNO!
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "COMD565" // #7 [DCMP090421]
			bEmbOrig = f_Message ( stMessage ) = 1
*/		

// #10 [MSS_LOT2].[P_JFF_1]
			alDefaut = Long ( alnv_Key[13].iaKeyValue )

// #10 [MSS_LOT2].[P_JFF_1]
/*
		If bEmbOrig Then
			sVal = String ( alnv_Key[13].iaKeyValue )
			lPos = Pos ( sVal, "/", 1)
			If lPos <= 0 Then
				alDefaut = Long ( sVal )
			Else
				alDefaut = Long ( Mid ( sVal, 1, lPos - 1 ) )
			End If
		Else
			sVal = String ( alnv_Key[13].iaKeyValue )
			lPos = Pos ( sVal, "/", 1)
			If lPos <= 0 Then
				alDefaut = Long ( sVal )
			Else
				alDefaut = Long ( Mid ( sVal, lPos + 1, Len ( sVal) ) )
			End If					
		End If
*/		
			
	End If

	// S'il ne l'a pas déposé en boutique FNAC, on lui demande s'il a l'emballage 
	// d'origine en fonction de la Catégorie de son appareil	
	// #7 [DCMP090421]	ajout gestion bEnvoiOuTeleChg

	// Traitement catégorie E
	If sCTG = "E" And Not bMaterielChezMSS And alDefaut = 0 Then

// #10 [MSS_LOT2].[P_JFF_1]
/*
		If alnv_Key[6].iaKeyValue = "OUI" Then
			stMessage.Bouton		= YESNO!
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "COMD565" // #7 [DCMP090421]
			bEmbOrig = f_Message ( stMessage ) = 1
		End If
*/

		If bCltVIP Then
			IF bDepotFNAC Then
// #10 [MSS_LOT2].[P_JFF_1]
/*
				If bEmbOrig Then
					sVal = String ( alnv_Key[7].iaKeyValue )
					lPos = Pos ( sVal, "/", 1)
					If lPos <= 0 Then
						alDefaut = Long ( sVal )
					Else
						alDefaut = Long ( Mid ( sVal, lPos + 1, Len ( sVal) ) )
					End If
				Else
*/
					
					sVal = String ( alnv_Key[4].iaKeyValue )
					lPos = Pos ( sVal, "/", 1)
					If lPos <= 0 Then
						alDefaut = Long ( sVal )
					Else
						alDefaut = Long ( Mid ( sVal, lPos + 1, Len ( sVal ) ) )
					End If					
// #10 [MSS_LOT2].[P_JFF_1]
/*
				End If
*/

			Else
// #10 [MSS_LOT2].[P_JFF_1]
/*
				If bEmbOrig Then
					sVal = String ( alnv_Key[7].iaKeyValue )
					lPos = Pos ( sVal, "/", 1)
					If lPos <= 0 Then
						alDefaut = Long ( sVal )
					Else
						alDefaut = Long ( Mid ( sVal, 1, lPos - 1 ) )
					End If
				Else
*/					
					sVal = String ( alnv_Key[4].iaKeyValue )
					lPos = Pos ( sVal, "/", 1)
					If lPos <= 0 Then
						alDefaut = Long ( sVal )
					Else
						alDefaut = Long ( Mid ( sVal, 1, lPos - 1 ) )
					End If					
// #10 [MSS_LOT2].[P_JFF_1]
/*
				End If
*/				
			End If
			
		Else
// #10 [MSS_LOT2].[P_JFF_1]
/*
			If bEmbOrig Then
				sVal = String ( alnv_Key[7].iaKeyValue )
				lPos = Pos ( sVal, "/", 1)
				If lPos <= 0 Then
					alDefaut = Long ( sVal )
				Else
					alDefaut = Long ( Mid ( sVal, 1, lPos - 1 ) )
				End If
			Else
*/
				
				sVal = String ( alnv_Key[4].iaKeyValue )
				lPos = Pos ( sVal, "/", 1)
				If lPos <= 0 Then
					alDefaut = Long ( sVal )
				Else
					alDefaut = Long ( Mid ( sVal, 1, lPos - 1 ) )
				End If					
// #10 [MSS_LOT2].[P_JFF_1]
/*
			End If
*/				

		End If

	
	End If
	// Fin Traitement catégorie E
	
End If

// Si l'appareil n'est pas sinistrée
If Not bAppSin Then  

	//* #2 [FNAC_PROD_ECH_TECH].[20090223142259343] 
	// dépôt chez FNAC ? 
	If Not bMaterielChezMSS Then 
	
		If bBattSin Then 
			isInfoSpbFrncplt += "[SIN_BATT]"
			alDefaut = 1234 
		End If

		If bAlimSin Then 
			isInfoSpbFrncplt += "[SIN_ALIM]"
			alDefaut = 1234
		End If

		//* #10 [MSS_LOT2].[P_JFF_2]
		If bAccSin Then 
			isInfoSpbFrncplt += "[SIN_AUT_ACC]"
			alDefaut = 1234
		End If
		
	End If
	//* :#2 [FNAC_PROD_ECH_TECH].[20090223142259343] 

End If


// En fonction du process, y a-t-il un RDV à prendre ?
//* #6 [MSS_LOT2].[P_JFF_1] supp 1238, 1256
Choose Case alDefaut
	Case 1237, 1255

		If Not bMaterielChezMSS Then 
			abRdvAPrendre = TRUE
		End If
		
	Case Else
		// Pour les autres cas, il s'agit d'envoi pas l'assuré ou passage O2M/TRP chez FNAC
End Choose

lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "ENV_VERS", "ATT", ";")
end subroutine

public subroutine uf_message_process_mssdiag (long alrow, long alinfospbfrn);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::uf_message_process_mssdiag
//* Auteur			: Pierre-Henri Gillot (JFF)
//* Date				: 04/09/2009 
//* Libellé			: 
//* Commentaires	: Affiche les message de PRocess MSS au gestionnaire
//*					  en fonction de l'info_spb_frn selectionnée
//*					   [MSS_DIAG]
//*
//* Arguments		: 
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF	20/10/2008	  [FNAC_PROD_ECH_TECH]
//* #2    JFF  13/02/2008    [FNAC_PROD_ECH_TECH].[20090223142259343]
//* #3    JFF  13/02/2008    [FNAC_PROD_ECH_TECH].[20090224144248310]
//* #4    JFF  30/03/2009    [FNAC_PROD_ECH_TECH].[20090330152547023]
//* #5    JFF  23/04/2009    [LCL_NOMADE]
//* #6    JFF  19/05/2009    [DCMP090172]
//* #7    JFF  05/05/2009    [RUEDUCOMMERCE]
//* #8    JFF  05/05/2009    [DCMP090298]
//* #9    JFF  02/03/2010    [MSS_LOT2]
//* --    JFF  06/04/2010    [MSS_LOT2].[20100406155536700]
//*-----------------------------------------------------------------

string sCodMSg, sMtFrais, sCommentaireFrais
String sVar[]
String sNumCmde, sAction, sTypApp, sTaillecoli, sNomContractant, sPc74
String sAppSin, sAlimSin, sBattSin, sAccSin //  [FNAC_PROD_ECH_TECH]
decimal{2} dcMtFrais
Boolean bPc441 // Pièce facture d'achat&Reglt cotisation.
Boolean bPc74  // Copie bulletion adhésion
Boolean bRDCommerce // #7 [RUEDUCOMMERCE]
Boolean bFNACEpt  //* #8 [DCMP090298]
long	lRow, lDeb, lFin
n_cst_attrib_key	lnv_key[], lnv2_key[]
n_cst_string	lnv_string
n_cst_string   lnvPFCString

dcMtFrais = -1
sMtFrais = ""
sTaillecoli = ""
sCommentaireFrais = ""

// #6 [DCMP090172]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 59 )
If lDeb > 0 Then
	sNomContractant = Trim ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ) )
Else 
	sNomContractant = ""
End If
If IsNull ( sNomContractant ) Then sNomContractant = ""
// :#6 [DCMP090172]

//* #7 [RUEDUCOMMERCE]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 114 )
bRDCommerce = lDeb > 0
//* :#7 [RUEDUCOMMERCE]

//* #8 [DCMP090298]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 105 )
bFNACEpt = lDeb > 0
//* :#8 [DCMP090298]

//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
// Facture d'achat de l'appareil garantie
bPc441 = idwWpieceGti.Find ( "ALT_RECLAME = 'O' AND ID_PCE = 441", 1, idwWpieceGti.RowCount () ) > 0

//* #4    JFF  30/03/2009    [FNAC_PROD_ECH_TECH].[20090330152547023]
bPc74 = idwWpieceGti.Find ( "ALT_RECLAME = 'O' AND ID_PCE = 74", 1, idwWpieceGti.RowCount () ) > 0
If bPc74 Then
	sPc74 = "- Le bulletin d'adhésion"
	//* #7 [RUEDUCOMMERCE].[CRTEST1]
	If bRDCommerce Then
		sPc74 = "- La copie du certificat d'adhésion"					
	End If
	//* #7 [RUEDUCOMMERCE].[CRTEST1]				
Else
	sPc74 = ""
End If


if idwWsin.rowCount() > 0 Then
	sNumCmde	= string(idwWsin.object.id_sin[1])+"-"+string(uf_nouveau_num_sequence( ))

	// L'appareil est-il sinistré ?
	sAppSin = "NON"
	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'APP_SIN'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then 
		If Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" Then
			sAppSin = "OUI"
		End If
	End If
	
	// La batterie est-elle sinistrée ?
	sBattSin = "NON"
	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'BATT_SIN'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then 
		If Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" Then
			sBattSin = "OUI"
		End IF
	End If
	
	// L'alim est-elle sinistrée ?
	sAlimSin = "NON"
	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'ALIM_SIN'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then 
		If Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" Then
			sAlimSin = "OUI"
		End If
	End If

	// #9 [MSS_LOT2].[P3]
	// Un autre accessoire est-il sinistré ?
	sAccSin = "NON"
	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'AUT_ACC_SIN'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then 
		If Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" Then
			sAccSin = "OUI"
		End If
	End If	
	
	sAction	= 'A_DIAGNOSTIQUER'
	sTypApp	= isTypApp


	// #1 JFF [FNAC_PROD_ECH_TECH]
	// #9 [MSS_LOT2].[P3]	
	// Cas particulier : si batt ext ou alim ext, on passe en process identique à B donc mt_frais d'une catégorie B
	If sBattSin = "OUI" Or sAlimSin = "OUI" Or sAccSin = "OUI" Then
		lnv2_Key[1].iskeyname  = "CTG"
		lnv2_Key[1].iakeyvalue = "B"
		lnv2_Key[2].iskeyname	 ="ACTION"
		lnv2_Key[2].iakeyvalue = sAction
		lnv2_Key[3].iskeyname  ="MT_FRAIS"		
		F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv2_Key )
	End If
	// :#1 JFF [FNAC_PROD_ECH_TECH]				

	lnv_Key[1].iskeyname	 ="TYP_APP"
	lnv_Key[1].iakeyvalue =sTypApp
	lnv_Key[2].iskeyname	 ="ID_COUR"
	lnv_Key[3].iskeyname	 ="ACTION"
	lnv_Key[3].iakeyvalue = sAction
	lnv_Key[4].iskeyname	 ="PROCESS_ALT"

	// #1 JFF [FNAC_PROD_ECH_TECH]				
	lnv_Key[5].iskeyname	 ="CTG"
	lnv_Key[6].iskeyname	 ="EMBORG"
	lnv_Key[7].iskeyname	 ="PROCESS_EMBORG"
	lnv_Key[8].iskeyname	 ="DEPOT_FNAC_ALT"
	lnv_Key[9].iskeyname	 ="PROCESS_FNAC_ALT"
	lnv_Key[10].iskeyname ="FRN_ALT"
	lnv_Key[11].iskeyname ="MT_FRAIS"
	lnv_Key[12].iskeyname ="CPLT_ADR_FRN_PROD"	
	
	//* #5 [LCL_NOMADE]
	lnv_Key[13].iskeyname ="TAILLE_COLI"	
	
	// [MSS_DIAG]
	lnv_Key[14].iskeyname ="FRN_DPT_IDF_MAT" 
	lnv_Key[15].iskeyname ="FRN_DPT_IDF_APM"
	// [MSS_DIAG]	
	
	// :#1 JFF [FNAC_PROD_ECH_TECH]				

	F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv_Key )


	if lRow > 0 Then
		
		// #9 [MSS_LOT2].[P3]	
		If sBattSin = "OUI" Or sAlimSin = "OUI" Or sAccSin = "OUI" Then		
			If IsNumber ( lnv2_Key[3].iakeyvalue ) Then // #1 JFF [FNAC_PROD_ECH_TECH]	
				dcMtFrais = dec (lnv2_Key[3].iakeyvalue)
			// #1 JFF [FNAC_PROD_ECH_TECH]	
			Else 
				sMtFrais = lnv2_Key[3].iakeyvalue
			End If
	
		Else
		
			If IsNumber ( lnv_Key[11].iakeyvalue ) Then // #1 JFF [FNAC_PROD_ECH_TECH]	
				dcMtFrais = dec (lnv_Key[11].iakeyvalue)
			// #1 JFF [FNAC_PROD_ECH_TECH]	
			Else 
				sMtFrais = lnv_Key[11].iakeyvalue
			End If
			// :#1 JFF [FNAC_PROD_ECH_TECH]				
		End If

		//* #5 [LCL_NOMADE]
		If lnv_Key[13].iakeyvalue <> "" And Not IsNull ( lnv_Key[13].iakeyvalue ) Then
			sTaillecoli = lnv_Key[13].iakeyvalue
		End If
		
	End If

//* #9 [MSS_LOT2] Cas pertinent de 2nd flux necessitant un msg de résumé.
	If isCas2FluxMS1 <> "" Then
		
		Choose Case isCas2FluxMS1 
				
			Case "[P8][MAJ_DIAG>1]"

				sCodMsg = "COMD607"		 
				Choose Case alInfoSpbFrn
					Case 1263
						sVar[1] = "l'assuré"
					Case 1264						
						sVar[1] = "Le SAV" + sNomContractant
						
				End Choose
				
			Case "[P10][CAS_2][MAJ_DIAG>1]"

				sCodMsg = "COMD608"		 

				sVar[1] = F_Remplace ( lnvPFCString.of_getkeyvalue (isInfoSpbFrnCplt, "DTE_HEU_RDV", ";"), "[", "" )		
				sVar[1] = F_Remplace ( sVar[1], "]", "" )		

			Case "[P_JFF_4][NOUV_SEQ_DIAG>1]"
				sCodMsg = "COMD609"		
				
			Case "[P7][MAJ_DIAG>1][ASS_ENVOIE_ACC]"				
				sCodMsg = "COMD610"
				
			Case "[P7][MAJ_DIAG>1][DIAG_EN_L_ETAT_ASS_N_ENVOIE_PAS_ACC]"				
				sCodMsg = "COMD611"				
				
			Case "[P_DCDC_3][NOUV_SEQ_DIAG>1][1202]"				
				sCodMsg = "COMD612"								

		End Choose 
		
		alInfoSpbFrn = -1 // On shunt par ce biais le second Choose Case
		
	End If

	choose Case alInfoSpbFrn

//* #9 [MSS_LOT2].[P_JFF_2] supp 1235
//		Case 	1234, 1235
		Case 	1234

			sCodMsg = "COMD574"		

			sVar[1] = "Appareil sinistré/batterie interne : " + sAppSin
			// #9 [MSS_LOT2].[P3]	
			sVar[2] = "Accessoire annexe sinistré : " + sAccSin
			sVar[3] = ""

			sVar[4] = lnv_Key[5].iakeyvalue // "Appareil de catégorie : "
			If sAppSin = "OUI" Then 
				sVar[5] = "son appareil et tous les accessoires d'origine (manuel, batterie amovible, câble d'alimentation, etc)"
			ElseIf sBattSin = "OUI" And sAlimSin = "OUI" Then 
				sVar[5] = "sa batterie amovible, son câble d'alimentation et tous les accessoires d'origine (manuel, etc)"				
			ElseIF sBattSin = "OUI" Then
				sVar[5] = "sa batterie amovible et tous les accessoires d'origine (manuel, etc)"
			ElseIF sAlimSin = "OUI" Then
				sVar[5] = "son câble d'alimentation et tous les accessoires d'origine (manuel, etc)"
			// #9 [MSS_LOT2].[P3]	
			ElseIf sAccSin = "OUI" Then
// [MSS_LOT2].[20100406155536700]
//				sVar[5] = "son accessoire sinistré et tous les accessoires d'origine (manuel, etc)"
				sVar[5] = "son accessoire sinistré"
// :[MSS_LOT2].[20100406155536700]
			End If

			If alInfoSpbFrn = 1234 Then
				sVar[6] = "M"
			ElseIf alInfoSpbFrn = 1235 Then
				sVar[6] = "XL"
			End If

			//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
			If bPc441 Then
				sVar[7] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
			Else
				sVar[7] = ""
			End If

			//* #4 [FNAC_PROD_ECH_TECH].[20090330152547023]
			sVar[8] = sPc74

			sVar[9] = sNumCmde

			If dcMtFrais > 0 Then
				sVar[10] = "L'assuré sera remboursé d'un montant de : " + string( dcMtFrais ) + lnv_string.of_GlobalReplace( stGlb.smonnaiesymboledesire, "\", "" ) + sCommentaireFrais // [SUISSE].LOT3 : Gestion msg Err avec monnaie
			Else
				sVar[10] = "L'assuré sera remboursé d'un montant de : " + sMtFrais + sCommentaireFrais 
			End If
			
			sVar[11] = lnv_Key[12].iakeyvalue
			


		Case 1236
//		936, 941
 			sCodMsg = "COMD575"		

			sVar[1] = "Appareil sinistré/batterie interne : " + sAppSin
			// #9 [MSS_LOT2].[P3]	
			sVar[2] = "Accessoire annexe sinistré : " + sAccSin
			sVar[3] = ""
			
			sVar[4] = lnv_Key[5].iakeyvalue // "Appareil de catégorie : "

			sVar[5] = lnv_Key[12].iakeyvalue

			sVar[6] = "Son appareil et tous les accessoires d'origine (manuel, batterie amovible, câble d'alimentation, etc)"

			//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
			If bPc441 Then
				sVar[7] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
			Else
				sVar[7] = ""
			End If
			
			//* #4 [FNAC_PROD_ECH_TECH].[20090330152547023]
			sVar[8] = sPc74
			
			sVar[9] = sNumCmde
			

		Case 1237, 1255 
		// 935, 940
 			sCodMsg = "COMD576"		

			sVar[1] = "Appareil sinistré/batterie interne : " + sAppSin
			// #9 [MSS_LOT2].[P3]	
			sVar[2] = "Accessoire annexe sinistré : " + sAccSin
			sVar[3] = ""
			
			sVar[4] = lnv_Key[5].iakeyvalue // "Appareil de catégorie : "

			sVar[5] = F_Remplace ( lnvPFCString.of_getkeyvalue (isInfoSpbFrnCplt, "DTE_HEU_RDV", ";"), "[", "" )		
			sVar[5] = F_Remplace ( sVar[5], "]", "" )		

			sVar[6] = lnvPFCString.of_getkeyvalue (isInfoSpbFrnCplt, "DEPT_ENLEV", ";")

			sVar[7] = "Son appareil et tous les accessoires d'origine (manuel, batterie amovible, câble d'alimentation, etc)"

			//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
			If bPc441 Then
				sVar[8] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
			Else
				sVar[8] = ""
			End If

			//* #4 [FNAC_PROD_ECH_TECH].[20090330152547023]
			sVar[9] = sPc74

			sVar[10] = sNumCmde

// #6 [MSS_LOT2].[P_JFF_1] Supp 1238, 1256
/*
		Case 1256
 			sCodMsg = "COMD577"		
			
			sVar[1] = "Appareil sinistré/batterie interne : " + sAppSin
			sVar[2] = "Batterie amovible sinistrée : " + sBattSin
			sVar[3] = "Câble d'alimentation sinistrée : " + sAlimSin
			
			sVar[4] = lnv_Key[5].iakeyvalue // "Appareil de catégorie : "

			sVar[5] = F_Remplace ( lnvPFCString.of_getkeyvalue (isInfoSpbFrnCplt, "DTE_HEU_RDV", ";"), "[", "" )		
			sVar[5] = F_Remplace ( sVar[5], "]", "" )		

			sVar[6] = lnvPFCString.of_getkeyvalue (isInfoSpbFrnCplt, "DEPT_ENLEV", ";")

			sVar[7] = "Son appareil et tous les accessoires d'origine (manuel, batterie amovible, câble d'alimentation, etc)"

			// #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
			If bPc441 Then
				sVar[8] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
			Else
				sVar[8] = ""
			End If

			// #4 [FNAC_PROD_ECH_TECH].[20090330152547023]
			sVar[9] = sPc74

			sVar[10] = sNumCmde
*/
		
		Case  1240

			sCodMsg = "COMD579" 

			sVar[1] = "Appareil sinistré/batterie interne : " + sAppSin
			// #9 [MSS_LOT2].[P3]	
			sVar[2] = "Accessoire annexe sinistré : " + sAccSin
			sVar[3] = ""
			
			sVar[4] = lnv_Key[5].iakeyvalue // "Appareil de catégorie : "

			//* #2 [FNAC_PROD_ECH_TECH].[20090223142259343]
			sVar[5] = "son appareil et tous les accessoires d'origine (manuel, batterie amovible, câble d'alimentation, etc)"

			// #6 [DCMP090172]
			If sNomContractant = "" Then 
				sVar[6] = "en magasin"
			Else
				sVar[6] = "chez " + sNomContractant
			End If
			// :#6 [DCMP090172]

			sVar[7] = sVar[6]

			//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
			If bPc441 Then
				sVar[8] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
			Else
				sVar[8] = ""
			End If

			//* #4 [FNAC_PROD_ECH_TECH].[20090330152547023]
			sVar[9] = sPc74

			sVar[10] = sNumCmde

// #6 [MSS_LOT2].[P_JFF_1] Supp 1261
//		Case 	1260, 1261 
		Case 	1260


			sCodMsg = "COMD578" // #6 [DCMP090172]

			sVar[1] = "Appareil sinistré/batterie interne : " + sAppSin
			// #9 [MSS_LOT2].[P3]	
			sVar[2] = "Accessoire annexe sinistré : " + sAccSin
			sVar[3] = ""

			//* #7 [RUEDUCOMMERCE].[CRTEST1]
			If bRDCommerce Then
				sVar[2] = ""
				sVar[3] = ""
			End If
			//* :#7 [RUEDUCOMMERCE].[CRTEST1]			
			
			sVar[4] = lnv_Key[5].iakeyvalue // "Appareil de catégorie : "

			//* #2 [FNAC_PROD_ECH_TECH].[20090223142259343]
			sVar[5] = "son appareil et tous les accessoires d'origine (manuel, batterie amovible, câble d'alimentation, etc)"

			// #6 [DCMP090172]
			If sNomContractant = "" Then 
				sVar[6] = "en magasin"
			Else
				sVar[6] = "chez " + sNomContractant
			End If
			// :#6 [DCMP090172]

			If alInfoSpbFrn = 1260 Then
				sVar[7] = "pour dépôt du conditionnement chez FNAC puis enlèvement pour expédition vers MSS "
				sVar[8] = "un emballage spécial"
			ElseIf alInfoSpbFrn = 1261 Then
				sVar[7] = "pour enlèvement et expédition vers MSS "
				sVar[8] = "l'emballage d'origine laissé par l'assuré (ou emballage équivalent fourni par l'assuré)"
			End If
			//* :#2 [FNAC_PROD_ECH_TECH].[20090223142259343]

			// #6 [DCMP090172]
			If sNomContractant = "" Then 
				sVar[9] = "en magasin"
			Else
				sVar[9] = "chez " + sNomContractant
			End If
			// :#6 [DCMP090172]

			//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
			If bPc441 Then
				sVar[10] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
			Else
				sVar[10] = ""
			End If

			//* #4 [FNAC_PROD_ECH_TECH].[20090330152547023]
			sVar[11] = sPc74

			sVar[12] = sNumCmde

			If sNomContractant = "" Then 
				sVar[13] = "le magasin"
			Else
				sVar[13] = sNomContractant
			End If


			
			
// :#1 JFF [FNAC_PROD_ECH_TECH]							
	End Choose

	If sCodMsg <> "" Then
		stMessage.scode = sCodMsg
		stMessage.sVar = sVar
	
		F_Message(stMessage)
	End If

		
End If




end subroutine

private function string uf_controlergestionedi_mssdiag (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestionEdi_MSSDIAG (PRIVATE)
//* Auteur			: PHG (dupplique JFF)
//* Date				: 04/09/2009
//* Libellé			: Controler Spécifique pour MSS
//* Commentaires	: [MSS_DIAG] Controle de Gestion pour le fournisseur MSS
//*
//* Arguments		: Long		aalCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ  PAR      Date	   Modification
//* #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
//* #2   PHG   23/06/2009  [O2M_DIAG_NOMADE]
//* #3   JFF   07/08/2009  [O2M_DIAG_NOMADE].[JFF].[20090807133737597]
//* #4   JFF   07/08/2009  [O2M_DIAG_NOMADE].[JFF].[20090901100945950]
//* #5   JFF   02/03/2010  [MSS_LOT2]
//*      JFF   14/06/2010  [DCMP100422]
//*		JFF	21/03/2011	[VDOC3538]
//*      JFF   19/04/2010  [PM72] Modif demandée par Nathalie le 21 Mars 2011
//		FPI	06/07/2011	[VDoc4662] Report de contrôle sur les retours de commandes MSS
//*-----------------------------------------------------------------

String sPos, sFiltreOrig, sIdTypArt, sIdRefFour, sCodModeReg, sVal
Long lTot, lRow, lInfoSpbFrn,lIdProd
Long lDeb, lFin //#2 
Decimal{2}   dcMtValAchat 
Boolean bRibVide
Boolean bA_DIAG_MS1_156
n_cst_string lnv_string
Boolean bA_DIAG_MS1_169, bPrestaInterdite // [VDoc4662] 

stMessage.sCode = ""
sPos = ""

sIdTypArt = idwArticle.GetItemString ( alCpt, "ID_TYP_ART" ) 	
If sIdTypArt <> "EDI" Then Return ""

// [VDOC3538]
bA_DIAG_MS1_156 = idwCmdeSin.Find("ID_FOUR = 'MS1' AND ID_REF_FOUR='A_DIAGNOSTIQUER' AND STATUS_GC IN ( 156 ) AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount() ) > 0

// #5 [MSS_LOT2]
If idwCmdeSin.Find("ID_FOUR = 'O2M' AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount() ) > 0 Then
	stMessage.sCode = "COMD615" 
	stMessage.bouton = Ok!
	stMessage.sVar[1] = "MSS"
	stMessage.sVar[2] = "O2M"	
	F_Message ( stMessage )
	sPos = "ALT_CHOIX"
	Return "G" + "ALT_CHOIX"
End If
// #5 [MSS_LOT2]

// #4 [O2M_DIAG_NOMADE].[JFF].[20090901100945950]
If idwDetail.GetItemNumber ( 1, "ID_EVT" ) <> 1083 Then
	stMessage.sCode = "COMD553" // [DCMP090327].[SBETV]
	stMessage.bouton = Ok!
	F_Message ( stMessage )
	sPos = "ALT_CHOIX"
	Return "G" + "ALT_CHOIX"
End If
// :#4 [O2M_DIAG_NOMADE].[JFF].[20090901100945950]			

// #5 [MSS_LOT2].[P3]
// Accsin interdit pour O2M
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'BATT_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	If Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" Then
		stMessage.sCode = "COMD592" 
		stMessage.bouton = Ok!
		F_Message ( stMessage )
		sPos = "ALT_CHOIX"
		Return "G" + "ALT_CHOIX"
	End If
End If

lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'ALIM_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	If Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" Then
		stMessage.sCode = "COMD592" 
		stMessage.bouton = Ok!
		F_Message ( stMessage )
		sPos = "ALT_CHOIX"
		Return "G" + "ALT_CHOIX"
	End If
End If
// :#9 [MSS_LOT2].[P3]


lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'NUM_FACT'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	sVal = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) 
	If IsNull ( sVal ) Or Len ( sVal ) = 0 Then
		stMessage.sCode = "COMD580" 
		stMessage.bouton = Ok!
		F_Message ( stMessage )
		sPos = "ALT_CHOIX"
		Return "G" + "ALT_CHOIX"
	End IF
End If

sIdRefFour 	= Upper ( idwArticle.GetItemString ( alCpt, "ID_REF_FOUR" ) )
lIdProd 		= idwWsin.GetItemNumber ( 1, "ID_PROD" ) 
lInfoSpbFrn = idwArticle.object.info_spb_frn[alCpt]

// #2 [O2M_DIAG_NOMADE] 1/
// Si le Appareil Non paramétré sur Option DP/95 => Message Bloquant : "Pour ce produit, ce type d'appareil ne rentre pas dans ce process"
if idw_DetPro.Find(   "ID_PROD="+ string(lIdProd) +                         &
                     " AND ID_CODE_DP=95" +                                 &
                     " AND POS(VAL_CAR, 'ACTION="+sIdRefFour+";', 1)>0" +   &
                     " AND POS(VAL_CAR, 'TYP_APP="+isTypApp+";', 1)>0"       &
                     , 1, idw_DetPro.rowCount()+1) = 0 Then
   stMessage.sCode = "COMD531" // [O2M_DIAG_NOMADE] Message : "Ce type d'appareil ne rentre pas dans ce process"
   stMessage.bouton = Ok!
   F_Message ( stMessage )
   sPos = "ALT_CHOIX"
   Return "G" + "ALT_CHOIX"
End If

// [O2M].372, Note 265, Point 1 : On vérifie que l'action choisie est cohérente avec le paramétrage du produit
if idw_DetPro.Find(	"ID_PROD="+ string(lIdProd) + 								&
							" AND POS(VAL_CAR, 'ACTION="+sIdRefFour+";', 1)>0" + 	&
							" AND POS(VAL_CAR, 'TYP_APP="+isTypApp+";', 1)>0"		&
							, 1, idw_DetPro.rowCount()+1) = 0 Then
	stMessage.sCode = "COMD463" // Msg : "Information Cochée non autorisée pour ce produit.@Veuillez sélectionner une autre information."
	stMessage.bouton = Ok!
	F_Message ( stMessage )
	sPos = "ALT_CHOIX"
	Return "G" + "ALT_CHOIX"
End If
//

// [O2M].378 : Controle du RIB SI Mode de Reglement = "Virement Auto", Info Spb Frn 415, et RibVide
sCodModeReg =  idwCmde.GetItemString ( 1, "COD_MODE_REG" ) 
bRibVide    = 	lnv_string.of_isempty ( idwCmde.GetItemString ( 1, "RIB_BQ" ) ) Or idwCmde.GetItemString ( 1, "RIB_BQ" ) = Fill ( "0", 5 ) Or &
					lnv_string.of_isempty ( idwCmde.GetItemString ( 1, "RIB_GUI" ) ) Or idwCmde.GetItemString ( 1, "RIB_GUI" ) = Fill ( "0", 5 ) Or &
					lnv_string.of_isempty ( idwCmde.GetItemString ( 1, "RIB_CPT" ) ) Or idwCmde.GetItemString ( 1, "RIB_CPT" ) = Fill ( "0", 11 ) Or&
					lnv_string.of_isempty ( idwCmde.GetItemString ( 1, "RIB_CLE" ) ) 

//*      JFF   19/04/2010  [PM72] Modif demandée par Nathalie le 21 Mars 2011
//If sIdRefFour = "A_DIAGNOSTIQUER" And Upper ( sCodModeReg ) = "VA" And bRibVide Then
//		Choose Case lInfoSpbFrn 
//
//// #5 [MSS_LOT2].[P_JFF_2] supp 1235
////			Case 1234, 1235 //* #1 [FNAC_PROD_ECH_TECH]
//
//			Case 1234 //* #1 [FNAC_PROD_ECH_TECH]				
//				stMessage.sCode = "COMD466"
//				F_Message ( stMessage )
//				Return "D" + "RIB_BQ"
//		End Choose
//End If
//
//

// [VDoc4662]
bA_DIAG_MS1_169 = idwCmdeSin.Find("ID_FOUR = 'MS1' AND ID_REF_FOUR='A_DIAGNOSTIQUER' AND STATUS_GC IN ( 169 ) AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount() ) > 0
bPrestaInterdite = idwCmdeSin.Find("ID_FOUR = 'MS1' AND STATUS_GC IN ( 155, 159, 160, 162, 164, 165, 172, 173, 176 ) AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount() ) > 0

If bPrestaInterdite Then
	stMessage.sTitre = "DCMP100444"
	stMessage.sCode = "COMD645"
	stMessage.bouton = OK!
	F_Message ( stMessage )
	sPos = "ALT_CHOIX"
	Return "G" + "ALT_CHOIX"
End If
// :[VDoc4662]

Choose Case sIdRefFour 
	Case "A_DIAGNOSTIQUER"
//		if idwCmdeSin.RowCount() > 0 then //[O2M].391 : On ignore toute prestation annulée

// #5 [MSS_LOT2] Pour MSS, ces contrôle n'ont plus d'utilité.
//		if idwCmdeSin.Find( "COD_ETAT <>'ANN'", 1, idwCmdeSin.RowCount() + 1 ) > 0 then
/* 
		if idwCmdeSin.Find( "COD_ETAT <>'ANN'", 1, idwCmdeSin.RowCount() + 1 ) > 0 And Not ibReouvPresta then
			stMessage.sCode = "COMD456"  // [O2M] : Message : Vous choisissez un flux de DIAGNOSTIQUE alors que d'autres prestations existent déjà sur le dossier, êtes vous sûr de votre choix ?
			stMessage.bouton = YesNo!
			if F_Message ( stMessage ) <> 1 Then
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"
			End If

//		 [O2M].381 : Vérification qu'il n'y a pas de diagnostic déja émis et clos.
//		 [DCMP090327].[SBETV]
		ElseIf idwCmdeSin.Find("ID_FOUR = 'MS1' AND ID_REF_FOUR<>'A_DIAGNOSTIQUER'", 1, idwCmdeSin.RowCount()+1 ) > 0 Then
			stMessage.sCode = "COMD581" // [O2M] : Message : Vous avez déjà émis un ou plusieurs flux de clôture avec O2M sur ce dossier.@Souhaitez-vous vraiment émettre un flux demandant un diagnostique ?"
			stMessage.bouton = YesNo!
			if F_Message ( stMessage ) <> 1 Then
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"

			End If
			
// [FNAC_PROD_ECH_TECH].[20090330152547023]			
	
		Else
			uf_message_process_o2m( alCpt, lInfoSpbFrn )

		End If
*/
		// message du Else Je sors le 
		uf_message_process_MSSDIAG( alCpt, lInfoSpbFrn )
// :[FNAC_PROD_ECH_TECH].[20090330152547023]			

	case "PEC_A_RECYCLER", "REFUSE_A_REEXP"
		// [O2M].382 : Vérification qu'il y a bien un diagnostic déja émis et clos avant de recycler ou refuser.
		// [DCMP090327].[SBETV]
		If idwCmdeSin.Find("ID_FOUR = 'MS1' AND ID_REF_FOUR='A_DIAGNOSTIQUER' AND STATUS_GC > 0 AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount()+1 ) = 0 Then
			stMEssage.sVar[1] = sIdRefFour
			stMessage.sCode = "COMD582" // [O2M] : Message : "Vous ne pouvez émettre cette action (#) vers O2M sans avoir précédemment émis une demande de diagonostique."
			stMessage.bouton = Ok!
			F_Message ( stMessage )
			sPos = "ALT_CHOIX"
			Return "G" + "ALT_CHOIX"
		End If
		
		// [DCMP100422]
		If sIdRefFour = "REFUSE_A_REEXP" Then
			If idwCmdeSin.Find("ID_FOUR = 'MS1' AND ID_REF_FOUR='A_DIAGNOSTIQUER' AND STATUS_GC in ( 155, 160, 165, 172, 173) AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount()+1 ) > 0 Then
				stMEssage.sVar[1] = sIdRefFour
				stMessage.sCode = "COMD636" // [O2M] : Message : "Le statut de retour d'MSS sur la prestation de diagnostic ne permet pas d'émettre cette action (#)."
				stMessage.bouton = Ok!
				F_Message ( stMessage )

				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"
			End If
		End IF
		// :[DCMP100422]		
		
		// [VDoc4662]
		If sIdRefFour = "PEC_A_RECYCLER" Then
			
			If bA_DIAG_MS1_169 Then
				stMessage.sTitre = "DCMP100508"
				stMessage.sCode = "COMD644"
				stMessage.bouton = OK!
				F_Message ( stMessage )
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"
			End If
			
		End if
		// :[VDoc4662]
		
	case "ENVOI_DEVIS_ASSURE"
		// [O2M].382 : Vérification qu'il y a bien un diagnostic déja émis et clos avant de recycler ou refuser.
		// [DCMP090327].[SBETV]
		// #5 [MSS_LOT2].[P_JFF_4]		
		If idwCmdeSin.Find("ID_FOUR = 'MS1' AND ID_REF_FOUR='A_DIAGNOSTIQUER' AND STATUS_GC >0 AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount()+1 ) > 0 Then

//			If idwCmdeSin.Find("ID_FOUR = 'MS1' AND ID_REF_FOUR='A_DIAGNOSTIQUER' AND STATUS_GC in ( 152, 153, 154) AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount()+1 ) = 0 Then
			If idwCmdeSin.Find("ID_FOUR = 'MS1' AND ID_REF_FOUR='A_DIAGNOSTIQUER' AND STATUS_GC in ( 152 ) AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount()+1 ) = 0 Then
				stMEssage.sVar[1] = sIdRefFour
				stMessage.sCode = "COMD583" // [O2M] : Message : "Vous ne pouvez émettre cette action (#) vers O2M sans avoir précédemment émis une demande de diagonostique."
				stMessage.bouton = Ok!
				F_Message ( stMessage )
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"
			End If
		Else
			
			stMEssage.sVar[1] = sIdRefFour
			stMessage.sCode = "COMD586" // [O2M] : Message : "Vous ne pouvez émettre cette action (#) vers O2M sans avoir précédemment émis une demande de diagonostique."
			stMessage.bouton = Ok!
			F_Message ( stMessage )
			sPos = "ALT_CHOIX"
			Return "G" + "ALT_CHOIX"
		End If

	// [VDOC3538]
	Case "DOSSIER_A_CLORE"
		If Not bA_DIAG_MS1_156 Then
			stMessage.sTitre = "VDOC3538"
			stMessage.sCode = "COMD657"
			stMessage.bouton = OK!
			stMEssage.sVar[1] = sIdRefFour			
			F_Message ( stMessage )
			sPos = "ALT_CHOIX"
			Return "G" + "ALT_CHOIX"
		End If	

End Choose

Return sPos

end function

private subroutine uf_selectionautomatique_standard_sansppo (string asidfour, string asfiltre);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande3::uf_selectionautomatique_standard_sansppo (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 20/11/2003 14:04:43
//* Libellé       : Sélection automatique 
//* Commentaires  : [DCMP090283]
//*
//* Arguments     : 	String		asIdFour		Val
//*					  	String		asFiltre		Val
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

Long	lDeb, lFin, lCpt, lTotRow, lRowFournOrig, lRowFournRech, lCoche
String	sFiltreOrig, sSortOrig

/*------------------------------------------------------------------*/
/* La gestion de sélection auot des 3 mob doit être paramétré       */
/* (-DP/45 )                                                        */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 45 )
If lDeb <= 0 Then Return


/*------------------------------------------------------------------*/
/* On sauve le filtre original.                                     */
/*------------------------------------------------------------------*/
sFiltreOrig = idwArticle.Describe ("DataWindow.Table.filter") 
If sFiltreOrig = "?" Then sFiltreOrig = ""

sSortOrig = idwArticle.Describe ("DataWindow.Table.Sort") 
If sSortOrig = "?" Then sSortOrig = ""

lRowFournOrig = idwFourn.GetRow ()
lRowFournRech = idwFourn.Find ( "ID_CODE_FRN = '" + Upper ( asIdFour ) + "'", 1, idwFourn.RowCount () )

/*------------------------------------------------------------------*/
/* DARTY n'est pas paramétré comme fournisseur sur le produit       */
/* On ressort																		  */
/*------------------------------------------------------------------*/
If lRowFournRech <= 0 Then Return

/*------------------------------------------------------------------*/
/* On ne sélectionne les mobiles que si l'événement choisi est un   */
/* événement de remplacement. pour tout autre type d'evt, on        */
/* ressort.                                                         */
/*------------------------------------------------------------------*/
Choose Case This.uf_Type_Evenement ()
	Case  "REMPL"
		// Pour le remplacement on continu

	Case  Else
		// Pour tout autre cas, on sort.
		Return
End Choose

idwFourn.SetRow ( lRowFournRech )
This.uf_RowFocusChanged ( "DWFOURN" ) 

/*------------------------------------------------------------------*/
/* On n'applique cette sélection que pour les mobiles que propose   */
/* DARTY.                                                           */
/*------------------------------------------------------------------*/
idwArticle.SetFilter ( Upper ( asFiltre ) )
idwArticle.Filter ( )

/*------------------------------------------------------------------*/
/* On Coche les trois premiers mobiles (au plus)                    */
/*------------------------------------------------------------------*/
If idwArticle.RowCount () > 0 Then
	idwArticle.SetItem ( 1, "CHOIX", "O" )
	This.uf_Zn_Choix ( iDwArticle, "O", 1 )
End If

// #1 Suppression des autres articles pour éviter les erreus
idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount(), Filter! )


/*------------------------------------------------------------------*/
/* On replace le filtre d'origine.                                  */
/*------------------------------------------------------------------*/
idwFourn.SetRow ( lRowFournOrig )
This.uf_RowFocusChanged ( "DWFOURN" ) 

idwArticle.SetFilter ( sFiltreOrig  )
idwArticle.Filter ()
idwArticle.SetSort ( sSortOrig  )
idwArticle.Sort ()



end subroutine

private function string uf_selectionautomatique_standard_avecppo (string asidfour, string asfiltre);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande3::uf_selectionautomatique_standard_avecppo (PRIVATE)
//* 					  
//* Auteur        : Fabry JF
//* Date          : 10/11/2005
//* Libellé       : Sélection automatique de mobiles sur Option 45.
//* Commentaires  : [DCMP090283] Ex fonction n_cst_w_commande3::uf_selectionautomatique_standard
//*
//* Arguments     : 	String		asIdFour		Val
//*					  	String		asFiltre		Val
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    27/01/2010  [DCMP090283]
//*       JFF     27/02/2012  [ITSM107966]
//*-----------------------------------------------------------------

Long	lDeb, lFin, lCpt, lTotRow, lRowFournOrig, lRowFournRech, lCoche
String	sFiltreOrig, sSortOrig, sRetCas

sRetCas = ""

/*------------------------------------------------------------------*/
/* La gestion de sélection auot des 3 mob doit être paramétré       */
/* (-DP/45 )                                                        */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 45 )
If lDeb <= 0 Then Return sRetCas

/*------------------------------------------------------------------*/
/* On sauve le filtre original.                                     */
/*------------------------------------------------------------------*/
sFiltreOrig = idwArticle.Describe ("DataWindow.Table.filter") 
If sFiltreOrig = "?" Then sFiltreOrig = ""

sSortOrig = idwArticle.Describe ("DataWindow.Table.Sort") 
If sSortOrig = "?" Then sSortOrig = ""

lRowFournOrig = idwFourn.GetRow ()
lRowFournRech = idwFourn.Find ( "ID_CODE_FRN = '" + Upper ( asIdFour ) + "'", 1, idwFourn.RowCount () )

/*------------------------------------------------------------------*/
/* DARTY n'est pas paramétré comme fournisseur sur le produit       */
/* On ressort																		  */
/*------------------------------------------------------------------*/
If lRowFournRech <= 0 Then Return sRetCas

/*------------------------------------------------------------------*/
/* On ne sélectionne les mobiles que si l'événement choisi est un   */
/* événement de remplacement. pour tout autre type d'evt, on        */
/* ressort.                                                         */
/*------------------------------------------------------------------*/
Choose Case This.uf_Type_Evenement ()
	Case  "REMPL"
		// Pour le remplacement on continu

	Case  Else
		// Pour tout autre cas, on sort.
		Return sRetCas
End Choose

idwFourn.SetRow ( lRowFournRech )
This.uf_RowFocusChanged ( "DWFOURN" ) 

/*------------------------------------------------------------------*/
/* On n'applique cette sélection que pour les mobiles que propose   */
/* DARTY.                                                           */
/*------------------------------------------------------------------*/
idwArticle.SetFilter ( Upper ( asFiltre ) )
idwArticle.Filter ( )

/*------------------------------------------------------------------*/
/* On les tris par odre de prix TTC Décroissants.                   */
/*------------------------------------------------------------------*/
idwArticle.SetSort ( "MT_PRIX_TTC D, ID_MARQ_ART A, ID_MODL_ART A")
idwArticle.Sort ()

/*------------------------------------------------------------------*/
/* On ne sélectionnera au maximum que trois dossiers.               */
/*------------------------------------------------------------------*/
lTotRow = idwArticle.RowCount ()
If lTotRow >= 3 Then lTotRow = 3

/*------------------------------------------------------------------*/
/* On Coche les trois premiers mobiles (au plus)                    */
/*------------------------------------------------------------------*/
// #1 [DCMP090283]
If lTotRow <= 0 Then
	sRetCas = "BASCULE_AVEC_PROPO_VERS_SANS_PROPO"
	This.uf_selectionautomatique_standard_sansppo ( asIdFour, "ID_FOUR = '" + asIdFour + "' AND ID_TYP_ART = 'CAF'")
	
	// ITSM107966
	If Not ibIPHONE_absent Then

		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "COMD472"
	
		F_Message ( stMessage )
	End If 
	// ITSM107966


Else
// :#1 [DCMP090283]

	For lCpt = 1 To lTotRow 
		idwArticle.SetItem ( lCpt, "CHOIX", "O" )
		This.uf_Zn_Choix ( iDwArticle, "O", lCpt )
	Next
End If

/*------------------------------------------------------------------*/
/* On replace le filtre d'origine.                                  */
/*------------------------------------------------------------------*/
idwFourn.SetRow ( lRowFournOrig )
This.uf_RowFocusChanged ( "DWFOURN" ) 
idwArticle.SetFilter ( sFiltreOrig  )
idwArticle.Filter ()
idwArticle.SetSort ( sSortOrig  )
idwArticle.Sort ()

Return sRetCas

end function

private function string uf_controlergestion_ms1 (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_MS1 (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 04/03/2010
//* Libellé			: Controle Spécifique pour MS1/MSS (hors EDI)
//* Commentaires	: [MSS_LOT2] Création de la fonction
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ	PAR	Date			Modification
//* #3 	FPI	20/03/2009	[DCMP090109] O2M devient réparateur d'IPhone
//*      JFF   03/11/2010  [DCMP100507/100508/100444]
//		FPI	06/07/2011	[VDoc4662] Déport de contrôle sur les retours de commandes MSS
//*-----------------------------------------------------------------

String sPos, sProbleme, sCodModeReg, sIdRefFour 
Long lInfoSpbFrn, lRow
Dec {2} dcFrais //#1
Boolean bRibVide, bErrBAMALE, bA_DIAG_MS1_175, bAUT_ACC_SIN, bA_DIAG_MS1_151234
Boolean bPEC_A_RECYCLER, bA_DIAG_MS1_169, bPrestaInterdite // [DCMP100507/100508/100444]
n_cst_string lnv_string

bErrBamAle = FALSE
bAUT_ACC_SIN = False
bA_DIAG_MS1_175 = False

sPos = ""

// #5 [MSS_LOT2]
If idwCmdeSin.Find("ID_FOUR = 'O2M' AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount() ) > 0 Then
	stMessage.sCode = "COMD615" 
	stMessage.bouton = Ok!
	stMessage.sVar[1] = "MSS"
	stMessage.sVar[2] = "O2M"	
	F_Message ( stMessage )
	sPos = "ALT_CHOIX"
	Return "G" + "ALT_CHOIX"
End If
// #5 [MSS_LOT2]

sIdRefFour = Upper ( idwArticle.GetItemString ( alCpt, "ID_REF_FOUR" ) )

bA_DIAG_MS1_175 = idwCmdeSin.Find("ID_FOUR = 'MS1' AND ID_REF_FOUR='A_DIAGNOSTIQUER' AND STATUS_GC = 175 AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount() ) > 0
bA_DIAG_MS1_151234 = idwCmdeSin.Find("ID_FOUR = 'MS1' AND ID_REF_FOUR='A_DIAGNOSTIQUER' AND STATUS_GC IN ( 151, 152, 153, 154 ) AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount() ) > 0

// [DCMP100507/100508/100444]
bPEC_A_RECYCLER = idwCmdeSin.Find("ID_FOUR = 'MS1' AND ID_REF_FOUR='PEC_A_RECYCLER' AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount() ) > 0

//	[VDoc4662]  Mise en commentaire
/*bA_DIAG_MS1_169 = idwCmdeSin.Find("ID_FOUR = 'MS1' AND ID_REF_FOUR='A_DIAGNOSTIQUER' AND STATUS_GC IN ( 169 ) AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount() ) > 0
bPrestaInterdite = idwCmdeSin.Find("ID_FOUR = 'MS1' AND STATUS_GC IN ( 155, 159, 160, 162, 164, 165, 172, 173, 176 ) AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount() ) > 0
*/

// :[DCMP100507/100508/100444]

lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'AUT_ACC_SIN'", 1, idwWDivSin.RowCount () ) 
If lRow > 0 Then 
	bAUT_ACC_SIN = Upper ( idwWDivSin.GetItemString ( lRow, "VAL_ALT" ) ) = "O"
End If

//	[VDoc4662]  Mise en commentaire
// [DCMP100507/100508/100444]
/*If bPrestaInterdite Then
	stMessage.sTitre = "DCMP100444"
	stMessage.sCode = "COMD645"
	stMessage.bouton = OK!
	F_Message ( stMessage )
	sPos = "ALT_CHOIX"
	Return "G" + "ALT_CHOIX"
End If*/
// :[DCMP100507/100508/100444]

If bAUT_ACC_SIN And Not bA_DIAG_MS1_175 and Not bA_DIAG_MS1_151234 Then

	If sIdRefFour <> "PAS_DE_COMMANDE" Then
		stMessage.sCode = "COMD595"
	Else
		stMessage.sCode = "COMD594"
	End If
	
	stMessage.bouton = OK!
	F_Message ( stMessage )
	sPos = "ALT_CHOIX"
	Return "G" + "ALT_CHOIX"


ElseIf Not bAUT_ACC_SIN And Not bA_DIAG_MS1_175 Then
	If sIdRefFour <> "PAS_DE_COMMANDE" Then
		stMessage.sCode = "COMD593"
	Else
		stMessage.sCode = "COMD594"
	End If
	
	stMessage.bouton = OK!
	F_Message ( stMessage )	
	sPos = "ALT_CHOIX"
	Return "G" + "ALT_CHOIX"
End If 

// [DCMP100507/100508/100444]
Choose Case sIdRefFour

	Case "PAS_DE_COMMANDE", "CMDE_AUT_ACC"
		If Not bPEC_A_RECYCLER Then
			stMessage.sTitre = "DCMP100507"
			stMessage.sCode = "COMD643"
			stMessage.bouton = OK!
			F_Message ( stMessage )
			sPos = "ALT_CHOIX"
			Return "G" + "ALT_CHOIX"
		End If

	//	[VDoc4662]  Mise en commentaire
	/*Case "PEC_A_RECYCLER"
		If bA_DIAG_MS1_169 Then
			stMessage.sTitre = "DCMP100508"
			stMessage.sCode = "COMD644"
			stMessage.bouton = OK!
			F_Message ( stMessage )
			sPos = "ALT_CHOIX"
			Return "G" + "ALT_CHOIX"
		End If
		*/
End Choose



// [DCMP100507/100508/100444]

//CMDE_AUT_ACC

//* #6 [FNAC_PROD_ECH_TECH].[20090127140540720]
Choose Case sIdRefFour
	Case "CMDE_ALIM_EXT", "CMDE_BATT_AMOV", "CMDE_AUT_ACC", "PAS_DE_COMMANDE"
		 
		If sIdRefFour = "CMDE_ALIM_EXT" Then
			lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'ALIM_SIN'", 1, idwWDivSin.RowCount () ) 
			If lRow > 0 Then 
				If Upper ( idwWDivSin.GetItemString ( lRow, "VAL_ALT" ) ) <> "O" Then
					bErrBamAle = TRUE
				End If
			Else
				bErrBamAle = TRUE				
			End If
		End If 
		
		If Not bErrBamAle And sIdRefFour = "CMDE_BATT_AMOV" Then
			lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'BATT_SIN'", 1, idwWDivSin.RowCount () ) 
			If lRow > 0 Then 

				If Upper ( idwWDivSin.GetItemString ( lRow, "VAL_ALT" ) ) <> "O" Then
					bErrBamAle = TRUE
				End If
			Else
				bErrBamAle = TRUE				
			End If
		End If 

		If Not bErrBamAle And ( sIdRefFour = "CMDE_AUT_ACC" Or sIdRefFour = "PAS_DE_COMMANDE" ) Then
			lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'AUT_ACC_SIN'", 1, idwWDivSin.RowCount () ) 
			If lRow > 0 Then 

				If Upper ( idwWDivSin.GetItemString ( lRow, "VAL_ALT" ) ) <> "O" Then
					bErrBamAle = TRUE
				End If
			Else
				bErrBamAle = TRUE				
			End If
		End If 

		If bErrBamAle Then
			stMessage.sCode = "COMD512"
			stMessage.bouton = YESNO!
			If F_Message ( stMessage ) = 2 Then
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"
			End If
		End If
End Choose

lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "ENV_VERS", "MS1", ";")

Return sPos

end function

private function string uf_gestionzone_infospbfrn_mssdiag_1200_2 (ref long alstatusgcactuel, ref long alinfospbfrnorig);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_Commande3::uf_GestionZone_InfoSpbFrn_MSSDIAG_1200_2 (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 04/03/2010
//* Libellé       : Détermination du cas de gestion precis pour le 2ème acte MSS 
//* Commentaires  : [MSS_DIAG][MSS_LOT2]
//* 						Se réfèrer aux fichiers du PCC
//* 						\\spb.lan\DSI\Produits\Clients-Distributeurs\FNAC\Fnac - Échanges Produits Techniques\Offre\MSS\Analyse\Analyse - Lot 2
//* 						"analyse résumé maj presta diag mss.txt"
//*						"Analyse MSS LOT2.txt"
//*						"Analyse technique lot 2 pour réalisation.txt"
//*
//* Arguments     : Long		alStatusGCActuel		Ref
//*					  long		alInfoSpbFrnOrig     Ref
//*
//* Retourne      : String		: La cas de gestion
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    23/07/10    [DCMP100523] 
//			FPI	30/09/2011	[VDoc3857]
//*-----------------------------------------------------------------

String sCasGestion, sEtatDernierePrestaADiag
Boolean	bCasTrouve, bMaterielChezMSS, bPrestaExistanteClose, bPrestaExistanteEnCours, bCmdeAccHonoree
Boolean  bDernPrestaClose, bDernPrestaEncours
Long lRow, lStatusGc, lInfoSpbFrn

bCasTrouve = False
sCasGestion = "AUCUN_CHOIX"

// Initialisation variables d'informations
bPrestaExistanteClose = idwCmdeSin.Find ( "ID_FOUR = 'MS1' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT = 'RFO'", 1, idwCmdeSin.Rowcount() ) > 0
bPrestaExistanteEnCours = idwCmdeSin.Find ( "ID_FOUR = 'MS1' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT = 'ECT'",	1, idwCmdeSin.Rowcount() ) > 0 
bCmdeAccHonoree = idwCmdeSin.Find ( "ID_FOUR = 'MS1' AND ID_TYP_ART = 'ACC' AND STATUS_GC = 165 AND COD_ETAT <> 'ANN'",	1, idwCmdeSin.Rowcount() ) > 0 

// Recherche descendante
idwCmdeSin.Sort ()
lRow = idwCmdeSin.Find ( "ID_FOUR = 'MS1' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER'",  1,idwCmdeSin.Rowcount() ) 
sEtatDernierePrestaADiag = idwCmdeSin.GetItemString ( lRow, "COD_ETAT" )

bDernPrestaClose = sEtatDernierePrestaADiag = "RFO"
bDernPrestaEncours = sEtatDernierePrestaADiag = "ECT"

lStatusGc  = idwCmdeSin.GetItemNumber ( lRow, "STATUS_GC" )
lInfoSpbFrn = idwCmdeSin.GetItemNumber ( lRow, "INFO_SPB_FRN" )

alStatusGCActuel = lStatusGc  
alInfospbfrnorig = lInfoSpbFrn 


// [Gérer par blocage les cas d'incohérence]
If bPrestaExistanteClose And bPrestaExistanteEnCours And sEtatDernierePrestaADiag <> "ECT" Then
	// Message expliquant le cas au GT
	sCasGestion = "ERREUR_INCOHERENCE_ETAT_PRESTA"
	Return sCasGestion 
End If

// "Le matériel est-il chez MSS ?"
stMessage.Bouton		= YESNO!
stMessage.Icon			= Question!
stMessage.bErreurG	= FALSE
stMessage.sCode		= "COMD571"
bMaterielChezMSS 		= f_Message ( stMessage ) = 1

// [P_DCDC_1] pour le cas Not bMaterielChezMSS
If bDernPrestaClose And Not bMaterielChezMSS And Not bCmdeAccHonoree Then
	// Message expliquant le cas au GT
	stMessage.Bouton		= OK!
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "COMD596"
	F_Message ( stMessage )
	
	sCasGestion = "[P_DCDC_1][NOUV_SEQ_DIAG>1][1]"
	Return sCasGestion 
End If

// [P4]
If bDernPrestaClose And Not bMaterielChezMSS And bCmdeAccHonoree Then
	// Message expliquant le cas au GT
	stMessage.Bouton		= OK!
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "COMD597"
	F_Message ( stMessage )
	
	sCasGestion = "[P4][NOUV_SEQ_DIAG>1]"
	Return sCasGestion 
End If

// [P8]
Choose Case lInfoSpbFrn 
	Case 1236, 1240, 1263, 1264
/* [DCMP100523] 
		Choose Case lStatusGc  
 			Case 0, 158
*/				
				If bDernPrestaEncours And Not bMaterielChezMSS Then

					// [VDoc3857]
					If lStatusGC=163 Then
						stMessage.Bouton		= YesNo!
						stMessage.Icon			= Question!
						stMessage.bErreurG	= FALSE
						stMessage.sCode		= "COMD698"
						If F_Message ( stMessage ) = 1 Then
							stMessage.sCode		= "COMD598"
							sCasGestion = "[P8][MAJ_DIAG>1]"
						Else
							sCasGestion = "[P8][MAJ_DIAG>2]"
							stMessage.sCode		= "COMD699"
						End if
						
						stMessage.Bouton		= OK!
						stMessage.Icon			= Information!
						stMessage.bErreurG	= FALSE
						F_Message ( stMessage )
					Else
						sCasGestion = "ERREUR_INCOHERENCE_ETAT_PRESTA"
					End if
					Return sCasGestion 
				// :[VDoc3857]
			End If
/*	[DCMP100523] 			
		End Choose
*/		
End Choose

// [P10] Page 48 du CDC
Choose Case lInfoSpbFrn 
	Case 1237, 1238, 1255, 1256
		If bDernPrestaEncours And Not bMaterielChezMSS Then
			// Message expliquant le cas au GT, notammement que le cas nécessite une question
			stMessage.Bouton		= YESNO!
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "COMD599"

			If f_Message ( stMessage ) = 1 Then
				sCasGestion = "[P10][CAS_2][MAJ_DIAG>1]"
				Return sCasGestion 				
			Else
				sCasGestion = "[P10][CAS_3][NOUV_DOS>1]"
				stMessage.Bouton		= OK!
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.sCode		= "COMD606"
				F_Message ( stMessage )

				Return sCasGestion 				
			End IF				
		End If				
End Choose			

// Mat chez MSS pour la suite
// [P_JFF_4] 
Choose Case lStatusGc
	Case 153, 154
		If bMaterielChezMSS And bDernPrestaClose And Not bCmdeAccHonoree Then
			// Message expliquant le cas au GT
			stMessage.Bouton		= OK!
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "COMD600"
			F_Message ( stMessage )
			
			sCasGestion = "[P_JFF_4][NOUV_SEQ_DIAG>1]"
			Return sCasGestion 				
		End If
End Choose

// [P7]
If bMaterielChezMSS And bDernPrestaEncours And lStatusGc = 169 Then
	// Message expliquant le cas au GT
	stMessage.Bouton		= YESNO!
	stMessage.Icon			= question!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "COMD601"

	// Ass envoie ou pas ?
	If f_Message ( stMessage ) = 1 Then
		sCasGestion = "[P7][MAJ_DIAG>1][ASS_ENVOIE_ACC]"
		Return sCasGestion 				
	Else
		// diag tout même ou pas ?
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD602"
		
		If f_Message ( stMessage ) = 1 Then
			sCasGestion = "[P7][MAJ_DIAG>1][DIAG_EN_L_ETAT_ASS_N_ENVOIE_PAS_ACC]"
			Return sCasGestion 				
		Else
			stMessage.Bouton		= OK!
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "COMD603"
			F_Message ( stMessage )

			sCasGestion = "[P7][MAJ_DIAG>1][REF_A_REXP_DECOCHER_DIAG]"		
			Return sCasGestion 							
		End If
		Return sCasGestion 				
	End IF				
End If

//	[P_DCDC_3]
If bMaterielChezMSS And bDernPrestaClose Then
	// Message expliquant le cas au GT
	stMessage.Bouton		= OK!
	stMessage.Icon			= Question!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "COMD604"
		
	f_Message ( stMessage ) 
	sCasGestion = "[P_DCDC_3][NOUV_SEQ_DIAG>1][1202]"
	Return sCasGestion 				
End If

Return sCasGestion

end function

private subroutine uf_gestionzone_infospbfrn_mssdiag_1200_3 (string ascas2flux, ref long aldefaut, ref boolean abrdvaprendre, long alstatusgcactuel, long alinfospbfrnorig);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_Commande3::uf_GestionZone_InfoSpbFrn_MSSDIAG_1200_3 (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 04/03/2010
//* Libellé       : Traitement du cas de gestion precis pour le 2ème acte MSS 
//* Commentaires  : [MSS_DIAG][MSS_LOT2]
//* 						Se réfèrer aux fichiers du PCC
//* 						\\spb.lan\DSI\Produits\Clients-Distributeurs\FNAC\Fnac - Échanges Produits Techniques\Offre\MSS\Analyse\Analyse - Lot 2
//* 						"analyse résumé maj presta diag mss.txt"
//*						"Analyse MSS LOT2.txt"
//*						"Analyse technique lot 2 pour réalisation.txt"
//*
//* Arguments     : String			asCas2Flux 		 val
//*		    		  Long			alDefaut        Réf	   // Process retenu
//*					  Boolean		abRdvAPrendre   Réf      // TRUE : Un Rdv est à prendre.
//*					  Long			alStatusGCActuel		val
//*					  long			alInfoSpbFrnOrig     val
//*
//* Retourne      : String		: La cas de gestion
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//			FPI	27/01/2012	[VDoc3857]
//*-----------------------------------------------------------------

n_cst_string lnv_string
String	sDetPresta
Long     lRelC13, lRelRdv

sDetPresta = ""

Choose Case asCas2Flux
	Case "[P_DCDC_1][NOUV_SEQ_DIAG>1][1]"
		sDetPresta = "ATT"
		alDefaut   = -1000  // Cas d'un nouveau process entier. 
		isCas2FluxMS1 = ""

	Case "[P4][NOUV_SEQ_DIAG>1]"
		ibDecocherPresta = TRUE
		isCas2FluxMS1 = ""
		
	Case "[P8][MAJ_DIAG>1]", "[P8][MAJ_DIAG>2]" // [VDoc3857] ajout du [P8][MAJ_DIAG>2]
		ibReouvPresta = TRUE
		sDetPresta = "ATT"
		
		
		Choose Case alInfoSpbFrnOrig
			Case 1236, 1263
				alDefaut = 1263

			Case 1240, 1264
				alDefaut = 1264				
				
		End Choose

		If asCas2Flux =  "[P8][MAJ_DIAG>2]" Then alDefaut=alInfoSpbFrnOrig // [VDoc3857] 
		
		lRelC13 = Long ( lnv_string.of_Getkeyvalue( isInfoSpbFrnCplt, "REL_C13", ";") )
		If IsNull ( lRelC13 ) Or lRelC13 <= 0 Then lRelC13 = 0

		lRelC13 += 1 
		
		lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "REL_C13", String ( lRelC13 ), ";")


	Case "[P10][CAS_2][MAJ_DIAG>1]"
		ibReouvPresta = TRUE
		sDetPresta = "ATT"
		abRdvAPrendre = TRUE

		lRelRdv = Long ( lnv_string.of_Getkeyvalue( isInfoSpbFrnCplt, "REL_RDV", ";") )
		If IsNull ( lRelRdv ) Or lRelRdv <= 0 Then lRelRdv = 0
		
		lRelRdv += 1 		
		lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "REL_RDV", String ( lRelRdv ), ";")

	Case "[P10][CAS_3][NOUV_DOS>1]"
		sDetPresta = "MS1"
		ibDecocherPresta = TRUE
		isCas2FluxMS1 = ""

	Case "[P_JFF_4][NOUV_SEQ_DIAG>1]"
		sDetPresta = "MS1"
		alDefaut   = 1262  // Cas d'un nouveau process entier. 

	Case "[P7][MAJ_DIAG>1][ASS_ENVOIE_ACC]"
		ibReouvPresta = TRUE
		sDetPresta = "MS1"
		
		lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "RETOUR_169", "ASS_ENVOIE_ACC", ";")
		

	Case "[P7][MAJ_DIAG>1][DIAG_EN_L_ETAT_ASS_N_ENVOIE_PAS_ACC]"
		ibReouvPresta = TRUE
		sDetPresta = "MS1"
		
		lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "RETOUR_169", "DIAG_EN_L_ETAT_ASS_N_ENVOIE_PAS_ACC", ";")


	Case "[P7][MAJ_DIAG>1][REF_A_REXP_DECOCHER_DIAG]"		
		ibDecocherPresta = TRUE
		isCas2FluxMS1 = ""

	Case "[P_DCDC_3][NOUV_SEQ_DIAG>1][1202]"
		sDetPresta = "MS1"
		alDefaut   = 1202  // Cas d'un nouveau process entier. 


End Choose 

If ibReouvPresta Then
	This.Uf_ProtegerZone ( "MAJ_DIAG_2FLUX", 1 )
End If

lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "ENV_VERS", sDetPresta, ";")
lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "NO_MAIL", "OUI", ";")


end subroutine

private subroutine uf_protegerzone (string ascas, integer aiprotection);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::Uf_ProtegerZone (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/09/2001
//* Libellé			: Gestion Msg d'erreurs
//* Commentaires	: [MSS_LOT2]
//*
//* Arguments		: String		asCas		Val
//*					  String    aiProtection Integer  
//*					  
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

asCas = Upper ( asCas )

Choose Case asCas
	Case "MAJ_DIAG_2FLUX"
		idwCmde.uf_Proteger &
				( {	"ADR_COD_CIV"		,&
						"ADR_NOM"			,& 
						"ADR_PRENOM"		,& 
						"ADR_LIVR1" 		,&
						"ADR_LIVR2"			,&
						"ADR_LIVR_CPL"		,&
						"ADR_CP"				,&
						"ADR_VILLE"			,&
						"ADR_TEL1"			,&
						"ADR_TEL2"			,&
						"ADR_TEL3"			&
				}, String ( aiProtection ) )

		
End Choose
end subroutine

private function boolean uf_preparervalider_majpresta ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_PreparerValider_MajPresta (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 09/03/2010
//* Libellé			: 
//* Commentaires	: Validation de la commande en saisie
//* 					  [MSS_LOT2]
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: Boolean
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*---------------------------------------------------------------

Boolean bRet
Long    lRow, lRelC13, lRelRdv, lStatusGc
String  sVal, sInfoSpbFrnCpltActuel
n_cst_string lnv_string

bRet = TRUE

// Recherche descendante
idwCmdeSin.Sort ()
lRow = idwCmdeSin.Find ( "ID_FOUR = 'MS1' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER'", idwCmdeSin.Rowcount(), 1 ) 

// Lecture de INFO_SPB_FRN_CPLT de la presta existante.
sInfoSpbFrnCpltActuel = Trim ( idwCmdeSin.GetItemString ( lRow, "INFO_SPB_FRN_CPLT" ))
If IsNull ( sInfoSpbFrnCpltActuel  ) Then sInfoSpbFrnCpltActuel  = ""

// REL_C13
sVal = Trim ( lnv_string.of_Getkeyvalue( isInfoSpbFrnCplt, "REL_C13", ";") )
If IsNull ( sVal ) Then sVal = ""
If sVal <> "" Then
	lRelC13 = Long ( lnv_string.of_Getkeyvalue( sInfoSpbFrnCpltActuel, "REL_C13", ";") )
	If IsNull ( lRelC13  ) Or lRelC13 <= 0 Then lRelC13  = 0
		
	lRelC13 += Long ( sVal )
	lnv_string.of_setkeyvalue( sInfoSpbFrnCpltActuel, "REL_C13", String ( lRelC13 ), ";")
End If


// DTE_HEU_RDV
sVal = Trim ( lnv_string.of_Getkeyvalue( isInfoSpbFrnCplt, "DTE_HEU_RDV", ";") )
If IsNull ( sVal ) Then sVal = ""
If sVal <> "" Then
	lnv_string.of_setkeyvalue( sInfoSpbFrnCpltActuel, "DTE_HEU_RDV", String ( sVal ), ";")
End If

// REL_RDV
sVal = Trim ( lnv_string.of_Getkeyvalue( isInfoSpbFrnCplt, "REL_RDV", ";") )
If IsNull ( sVal ) Then sVal = ""
If sVal <> "" Then
	lRelRdv = Long ( lnv_string.of_Getkeyvalue( sInfoSpbFrnCpltActuel, "REL_RDV", ";") )
	If IsNull ( lRelRdv  ) Or lRelRdv <= 0 Then lRelRdv  = 0
		
	lRelRdv += Long ( sVal )
	lnv_string.of_setkeyvalue( sInfoSpbFrnCpltActuel, "REL_RDV", String ( lRelRdv ), ";")
End If

// RETOUR_169
sVal = Trim ( lnv_string.of_Getkeyvalue( isInfoSpbFrnCplt, "RETOUR_169", ";") )
If IsNull ( sVal ) Then sVal = ""
If sVal <> "" Then
		lnv_string.of_setkeyvalue( sInfoSpbFrnCpltActuel, "RETOUR_169", String ( sVal ), ";")
End If

// ENV_VERS
sVal = Trim ( lnv_string.of_Getkeyvalue( isInfoSpbFrnCplt, "ENV_VERS", ";") )
If IsNull ( sVal ) Then sVal = ""
If sVal <> "" Then
		lnv_string.of_setkeyvalue( sInfoSpbFrnCpltActuel, "ENV_VERS", String ( sVal ), ";")
End If

// NO_MAIL
sVal = Trim ( lnv_string.of_Getkeyvalue( isInfoSpbFrnCplt, "NO_MAIL", ";") )
If IsNull ( sVal ) Then sVal = ""
If sVal <> "" Then
		lnv_string.of_setkeyvalue( sInfoSpbFrnCpltActuel, "NO_MAIL", String ( sVal ), ";")
End If

// Repère de maj pour la validation
lnv_string.of_setkeyvalue( sInfoSpbFrnCpltActuel, "MAJ_PRS", "OUI", ";")

// Ecriture
// On réouvre la prestation
idwCmdeSin.SetItem ( lRow, "COD_ETAT", "CNV" )

// L'INFO_SPB_FRN est réécrit.
idwArticle.SetFilter ( "CHOIX = 'O'" )
idwArticle.Filter ( )
lStatusGc = idwArticle.GetItemNumber ( 1, "INFO_SPB_FRN" ) 
If lStatusGC > 0 Then 
	idwCmdeSin.SetItem ( lRow, "INFO_SPB_FRN", lStatusGc ) 
End If

// L'INFO_SPB_FRN_CPLT est réécrit.
idwCmdeSin.SetItem ( lRow, "INFO_SPB_FRN_CPLT", sInfoSpbFrnCpltActuel ) 

idwCmde.RowsDiscard ( 1, idwCmde.RowCount (), PRIMARY! )

This.uf_RowFocusChanged ( "DWFOURN" )
This.uf_RowFocusChanged ( "DWTYPART" )

Return bRet

end function

public function boolean uf_getautorisation (long aliddroit);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande3::uf_GetAutorisation (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 09/03/2010
//* Libellé       : Lecture simple d'une autorisation
//* Commentaires  : [MSS_LOT2]
//*
//* Arguments     : Long	alIdDroit		Val
//*
//* Retourne      : Boolean  TRUE, on a le droit
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

String sIdProd, sFindOrig, sFindOrig1

sIdProd = String ( idwWsin.GetItemNumber ( 1, "ID_PROD" ) )

sFindOrig   = "ID_OPER = '" + Upper ( stGlb.sCodOper ) + "' AND " + &
				  "ID_NAT_OPER = " + String ( alIdDroit ) + " AND ID_PROD = " + sIdProd

sFindOrig1   = "ID_OPER = '" + Upper ( stGlb.sCodOper ) + "' AND " + &
				  "ID_NAT_OPER = " + String ( alIdDroit ) + " AND ID_PROD = -1"

Return idwAutorisation.Find ( sFindOrig   , 1, idwAutorisation.RowCount() )  > 0 Or &
	    idwAutorisation.Find ( sFindOrig1  , 1, idwAutorisation.RowCount() )  > 0




end function

public subroutine uf_epuration_probleme ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::uf_epuration_probleme
//* Auteur			: F. Pinon
//* Date				: 16/06/2010 15:02:37
//* Libellé			: Epure la zone "probleme"
//* Commentaires	: [Bug.Char13_Probleme]
//*
//* Arguments		: 
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	25/06/2010 	[20100625.FPI] Epuration de message
//			FPI	30/05/2012	[20120530.FPI] Suppression des " dans le probleme
//*-----------------------------------------------------------------
String sProbleme
Long lCpt

For lCpt=1 to idwArticle.Rowcount( )
	sProbleme = idwArticle.getitemString(lCpt,"PROBLEME")

	if isnull(sProbleme) Then continue
	
	sProbleme = f_remplace(sProbleme,Char(13)," ")
	sProbleme = f_remplace(sProbleme,Char(10)," ")
	sProbleme = f_remplace(sProbleme,Char(9)," ")
	sProbleme = f_remplace(sProbleme,Char(11)," ")	// [20100625.FPI] 
	sProbleme = f_remplace(sProbleme,"~""," ")// [20120530.FPI]
	
	idwArticle.setitem( lCpt, "PROBLEME",sProbleme)
Next

For lCpt=1 to idwArticlePrs.Rowcount( )
	sProbleme = idwArticlePrs.getitemString(lCpt,"PROBLEME")

	if isnull(sProbleme) Then continue
	
	sProbleme = f_remplace(sProbleme,Char(13)," ")
	sProbleme = f_remplace(sProbleme,Char(10)," ")
	sProbleme = f_remplace(sProbleme,Char(9)," ")
	sProbleme = f_remplace(sProbleme,Char(11)," ")	// [20100625.FPI] 
	sProbleme = f_remplace(sProbleme,"~""," ")// [20120530.FPI]
	
	idwArticlePrs.setitem( lCpt, "PROBLEME",sProbleme)
Next


end subroutine

private function string uf_controlergestion_auchan (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_AUCHAN (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/07/2004
//* Libellé			: Controle Spécifique pour Auchan
//* Commentaires	: [PC363_AUCHAN]
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ	PAR	Date			Modification
//       JFF   03/06/2010  [PC397/443_IPAD]
//       JFF   23/11/2015 [DT185]
//*-----------------------------------------------------------------
String sPos, sFiltreOrig, sSortOrig, sTypAction, sNumGsm, sVal
Long   lRow, lModeRempl, lDeb, lFin
Boolean bAltSuiviSms
n_cst_string lnv_string
DataWindowChild dwChild
Long lIdEvt 

sPos = ""

/*
			stMessage.sCode = "COMD508"
			F_Message ( stMessage )
			Return "D" + "RIB_BQ"
*/

sTypAction = idwArticle.GetItemString ( alCpt, "ID_TYP_ART" )
lIdEvt = idwDetail.GetItemNumber  ( 1, "ID_EVT" )

Choose Case sTypAction

	Case "CAF"

		// [DT185]
		If lIdEvt <> 1317 Then
			idwDetail.GetChild ( "ID_EVT", dwChild )
			lRow = dwChild.Find ( "ID_CODE = 1317", 1, dwChild.RowCount()) 
			If lRow > 0 Then
				stMessage.sCode = "COMD928"
				stMessage.berreurg=FALSE
				F_Message ( stMessage )
				Return "CHOIX"				
			End If
		End If

		F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 140 )
		If lDeb <= 0 Then Return sPos
		
		sVal = idw_DetPro.GetItemString ( lDeb, "VAL_CAR" )
		sVal = Trim ( lnv_string.of_Getkeyvalue( sVal, "DUREE_VALIDITE_CARTE_CADEAU", ";") )
		lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "DUR_VAL_CC", sVal, ";")
	

End CHoose


Return sPos

end function

private subroutine uf_chgt_fourn_fct_dp148 (long alidprod, ref string asfourmodif);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::uf_chgt_fourn_fct_dp148
//* Auteur			: F. Pinon
//* Date				: 13/10/2010 11:13:41
//* Libellé			: [DCMP100452] - PC 171
//* Commentaires	: 
//*
//* Arguments		: value long alidprod	 */
/* 	value string asmarque	 */
/* 	ref string asfourmodif	 */
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

/*
L'option 148 définit le fournisseur par type d'appareil.
Il est important que la colonne "tri" soit rempli avec les spécificités par marque en premier.
Ex : 
Id_code_car	Val_car															Tri
--------			---------															----
SBE				TYPE_APP=#TVS#TLC#;MARQUE=#SAMSUNG#		1
O2M				TYPE_APP=#TVS#TLC#										2

--> Les télés de marques SAMSUNG chez SBE, les autres télés chez O2M
*/

Long lDeb, lFin
n_cst_string nvstring
string sValCar, sListeMarques, sListeTypApp

F_RechDetPro(ldeb, lfin, idw_DetPro, alIdProd,"-DP",148)

if lDeb <=0 Then return

Do While lDeb <= lFin
	sValCar=idw_DetPro.GetItemString(lDeb,"VAL_CAR")
	
	sListeTypApp=nvstring.of_getkeyvalue( sValCar, "TYPE_APP", ";")
	sListeMarques=nvstring.of_getkeyvalue( sValCar, "MARQUE", ";")
	
	If Pos(sListeTypApp,"#" + isTypapp + "#") > 0 Then
		if sListeMarques = "" Then
			asFourModif = idw_DetPro.GetItemString(lDeb,"ID_CODE_CAR")
			exit
		End if
	
		If Pos(sListeMarques ,"#" + ismarqportadh + "#") > 0 Then
			asFourModif = idw_DetPro.GetItemString(lDeb,"ID_CODE_CAR")
			exit
		End if

	End if
	
	lDeb++
Loop




end subroutine

private function string uf_controlergestion_carrefourlad (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_CarrefourLad (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 17/11/2010
//* Libellé			: Controle Spécifique pour Auchan
//* Commentaires	: [PC301].[LOT2]
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ	PAR	Date			Modification
//       JFF   03/06/2010  [PC397/443_IPAD]
//*-----------------------------------------------------------------
String sPos, sTel1Port, sTel2Dom
Long   lRow, lModeRempl, lDeb, lFin
Boolean bAltSuiviSms, bOk
n_cst_string lnv_string

sPos = ""

sTel1Port = idwCmde.GetItemString ( 1, "ADR_TEL1" ) 
If IsNull ( sTel1Port ) Then sTel1Port = ""
sTel2Dom  = idwCmde.GetItemString ( 1, "ADR_TEL2" )
If IsNull ( sTel2Dom ) Then sTel2Dom = ""

stMessage.sCode = ""
bOk = False

Choose Case Left ( sTel1Port, 2 ) 
	Case "06", "07"
		// Ok
		bOk = True
		
	Case Else
		If sTel1Port <> "" Then
			stMessage.sCode = "COMD646"
			F_Message ( stMessage )
			Return "D" + "RIB_BQ"
		End If
		
End Choose 

Choose Case Left ( sTel2Dom, 2 ) 
	Case "06", "07"
		stMessage.sCode = "COMD647"
		F_Message ( stMessage )
		Return "D" + "RIB_BQ"	
		
	Case Else
		If Not bOk Then
			If sTel2Dom = "" Then
				stMessage.sCode = "COMD647"
				F_Message ( stMessage )
				Return "D" + "RIB_BQ"	
			ELse
				bOk = True
			End If
		End If
		// Ok
		
End Choose 

Return sPos

end function

private subroutine uf_preparervalider_selectioncourrier ();//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande3::uf_PreparerValider_SelectionCourrier (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 02/01/2004 16:14:32
//* Libellé       : Validation s'il sagit d'une sélection à placer sur le courrier
//* Commentaires  : On mémorise l'information provisoirement sur le disque local
//*					  DCMP 030483
//*
//* Arguments     : Rien
//*
//* Retourne      : Boolean
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     	Modification
//* #1 	 DGA      19/09/2006 Gestion d'un répertoire temporaire DCMP-060643
//*       JFF      21/01/2011 [PC301].[V15_EVOL_VETUSTE]
//*
//*
//*-----------------------------------------------------------------

Int		iTot, iCpt, iFic
String	sVal, sRepWin, sFic, sIdGti, sIdEvt
String   sFind, sIdRev 
Long lRow
Boolean  bRet
u_DataWindow udwNull 
s_Plafond_Pec stPlafPec 
Long lIdGti, lIdDetail, lRowMtPec
Decimal {2} dcMtPrec, dcMtLu, dcMtPecActuelle, dcTxMinMajPlafond 
n_cst_string lnv_string // [SUISSE].LOT3 : Gestion msg Err avec monnaie
SetNull ( udwNull )
DateTime dtMajLe 


sVal = ""
iTot = idwCmde.RowCount ()

// Pour le traitement très particulier du 722
// [PC301].[V15_EVOL_VETUSTE]
sIdGti = String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) )
sIdEvt = String ( idwDetail.GetItemNumber ( 1, "ID_EVT" ) )
sIdRev = String ( idwWsin.GetItemNumber ( 1, "ID_REV" ) )

lRow = idwPlafond.Find ( " ID_GTI = " + sIdGti + &
							" AND ID_REV = " + sIdRev + &
							" AND ID_NIV_PLAF = '+EV' " + &
							" AND ID_REF_PLAF = " + sIdEvt + &							
							" AND Id_TYP_PLAF = '722'" + &
							" AND ID_CPT_PLAF = 0", 1, idwPlafond.RowCount () ) 

If lRow > 0 Then

	dcTxMinMajPlafond = idwPlafond.GetItemDecimal ( lRow, "MT_PLAF" )
	
	dcMtPrec = 0	
	For iCpt = 1 To iTot
		dcMtLu = idwCmde.GetItemDecimal ( iCpt, "MT_TTC_CMDE"	) 
		If dcMtLu > dcMtPrec Then 
			dcMtPrec = dcMtLu 
		End If
	Next
	
	If dcMtPrec > 0 Then
		dcMtPrec += dcMtPrec * dcTxMinMajPlafond 
	End If

	If dcMtPrec <= 0 Then
		dcMtPrec = 0
	End If
	
	lRow = idwwDivDet.Find ( "Upper (NOM_ZONE) = 'MT_MAX_PROPO_PLF722'", 1, idwwDivDet.RowCount () ) 
	// Présence tester sur ControlerSelection Avant.
	idwwDivDet.SetItem ( lRow, "VAL_MT", dcMtPrec )	
	dtMajLe = DateTime ( Today (), Now () )
	idwwDivDet.SetItem ( lRow, "MAJ_LE", dtMajLe  )
	idwwDivDet.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )
	idwwDivDet.SetItem ( lRow, "ALT_SUPP", "N" )
	// #1 Plus logique de mettre aussi à jour w_sin
	idwDetail.SetItem ( 1, "MAJ_LE", dtMajLe  )
	idwDetail.SetItem ( 1, "MAJ_PAR", stGlb.sCodOper )

	
	
	// Recherche la PEC non forcée (alt_pec<>'O') car sinon on ne la retouche pas
	If ( idwwDivDet.Find ( "ID_GTI = " + String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) ) + &
								  " AND ID_DETAIL = " +  String ( idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
								  " AND UPPER ( NOM_ZONE ) = 'PEC' " + &
								  " AND UPPER ( VAL_LST_CAR ) = 'O'" &
							  , 1, idwwDivDet.RowCount () ) > 0 ) AND &
																					&
		  ( idwwDivDet.Find ( "ID_GTI = " + String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) ) + &
			  " AND ID_DETAIL = " +  String ( idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
			  " AND UPPER ( NOM_ZONE ) = 'ALT_PEC' " + &
			  " AND UPPER ( VAL_LST_CAR ) <> 'O'" &
		  , 1, idwwDivDet.RowCount () ) > 0 ) Then &
	
		// une Pec non forcée est trouvée, recherche du montant de Pec (Du row)
		lRowMtPec = idwwDivDet.Find ( "ID_GTI = " + String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) ) + &
								  " AND ID_DETAIL = " +  String ( idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
								  " AND UPPER ( NOM_ZONE ) = 'MT_PEC' " &
							  , 1, idwwDivDet.RowCount () ) 
	
		// Lecture du montant						  
		If lRowMtPec > 0 Then
			dcMtPecActuelle = idwwDivDet.GetItemDecimal ( lRowMtPec, "VAL_MT" )
		End if 
		
		// Si le montant recalculé est >=0 et est strictement inférieur au montant actuel 
		// Alors on mets à jour sur le détail et on averti.
		If dcMtPrec < dcMtPecActuelle And dcMtPrec >= 0 Then
			idwwDivDet.SetItem ( lRowMtPec, "VAL_MT", dcMtPrec )		
	
			/*------------------------------------------------------------------*/
			/* Si au moins une maj, on averti le gestionnaire                   */
			/*------------------------------------------------------------------*/
			stMessage.sTitre  	= "Montant PEC retouché (Plafond 722)"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!
			stMessage.sCode = "COMD447"		
			stMessage.sVar[1] = String (idcMtPlafcmdeWeb)
			stMessage.sVar[2] = lnv_string.of_GlobalReplace( stGlb.smonnaiesymboledesire, "\", "" ) // [SUISSE].LOT3 : Gestion msg Err avec monnaie
			stMessage.sVar[3] = String (dcMtPrec)
			stMessage.sVar[4] = lnv_string.of_GlobalReplace( stGlb.smonnaiesymboledesire, "\", "" ) // [SUISSE].LOT3 : Gestion msg Err avec monnaie
			F_Message ( stMessage )
			
		End If
	
	End IF

End If
// :[PC301].[V15_EVOL_VETUSTE]

/*------------------------------------------------------------------*/
/* Stockage de ZVAR14/15 sur disque                                 */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sRepWin = stGlb.sWinDir + "\TEMP\"

sRepWin = stGLB.sRepTempo

sFic	  = sRepWin + "ZV1415.TXT"
FileDelete ( sFic )
iFic = FileOpen ( sFic, LineMode!, Write!, LockWrite!, Replace! )

If iFic > 0 Then
	/*------------------------------------------------------------------*/
	/* Mémorisation pour construction ultérieur de ZVAR14 et ZVAR15     */
	/*------------------------------------------------------------------*/
	For iCpt = 1 To iTot
		sVal = Upper ( idwCmde.GetItemString ( iCpt, "ID_MARQ_ART"	) ) + " " + &
				 Upper ( idwCmde.GetItemString ( iCpt, "ID_MODL_ART"	) ) 
	
		FileWrite ( iFic, sVal )	
	Next

	FileClose ( iFic )
End If


end subroutine

private function string uf_controlergestion_axa (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_AXA (PRIVATE)
//* Auteur			: Fabry JF 
//* Date				: 01/02/2011
//* Libellé			: Controle Spécifique pour AXA
//* Commentaires	: [GROSBILL].[PC398-403-479]
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//		FPI	08/12/2014		[PC13174]
//    JFF   09/04/2018 [DT353]
//*-----------------------------------------------------------------

String sPos, sProbleme, sCodModeReg 
Long lInfoSpbFrn 
Dec {2} dcFrais //#1
Boolean bRibVide
Long lDeb, lFin, lRow

sPos = ""

/*------------------------------------------------------------------*/
/* Si au moins une prestation vers AV est détectée                 */
/* ET sur laquelle la zone info_spb_frn est égale à 310  (client    */
/* envoi son mobile)                                                */
/* ET que la méthode de règlement et " VA "                         */
/* ET que le RIB est vide                                           */
/* ALORS afficher un message :                                      */
/*------------------------------------------------------------------*/

lInfoSpbFrn = idwArticle.GetItemNumber ( alCpt, "INFO_SPB_FRN" ) 
sCodModeReg = idwCmde.GetItemString ( 1, "COD_MODE_REG" ) 
bRibVide    = 	IsNull ( idwCmde.GetItemString ( 1, "RIB_BQ" ) ) Or idwCmde.GetItemString ( 1, "RIB_BQ" ) = Fill ( "0", 5 ) Or &
					IsNull ( idwCmde.GetItemString ( 1, "RIB_GUI" ) ) Or idwCmde.GetItemString ( 1, "RIB_GUI" ) = Fill ( "0", 5 ) Or &
					IsNull ( idwCmde.GetItemString ( 1, "RIB_CPT" ) ) Or idwCmde.GetItemString ( 1, "RIB_CPT" ) = Fill ( "0", 11 ) Or&
					IsNull ( idwCmde.GetItemString ( 1, "RIB_CLE" ) ) 

idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "1" )

// [PC13174]
f_rechdetpro( lDeb, lFin, idw_detpro, idwwSin.GetItemNumber(1,"ID_PROD"), "-DP", 	264)
if lDeb > 0 Then
	if lInfoSpbFrn <> 1790 Then
		stMessage.sCode = "GENE013"
		stMessage.berreurg=FALSE
		stMessage.sVar[1] = "Process interdit"
		F_Message ( stMessage )
		Return "CHOIX"
	End if
	idwwsin.SetItem(1,"MARQ_PORT","PAS_DE_MARQUE")
	idwwsin.SetItem(1,"MODL_PORT","PAS_DE_MODELE")
	lRow=idwwdivsin.Find("NOM_ZONE='type_app'",1,idwwdivsin.RowCount())
	if lRow > 0 Then
		idwwdivsin.SetItem(lRow,"VAL_CAR","SER")
	End if
End if
// :[PC13174]

/*------------------------------------------------------------------*/
/* Message d'information pour le gestionnaire                       */
/*------------------------------------------------------------------*/
If  lInfoSpbFrn = 1710 Then
	stMessage.sCode = "COMD654"
// stMessage.sVar [1] = F_Determiner_Montant_Frais_Envoi ( String ( lInfoSpbFrn ), idwWsin.object.id_prod[1], idw_DetPro, dcFrais ) // #1
//	stMessage.sVar [1] = F_Determiner_Montant_Frais_Envoi ( String ( lInfoSpbFrn ), idwWsin.object.id_prod[1], isTypApp, idw_DetPro, dcFrais ) // [DCMP100551]
//	stMessage.sVar [2] = String ( idwCmde.GetItemNumber ( 1, "ID_SIN" ) ) + "-" + String (  This.uf_Nouveau_Num_Sequence () ) 
	F_Message ( stMessage )
End If 

// [DT353]
idwCmde.SetItem (1, "STATUS_GC", 2 )
idwCmde.SetItem (1, "COMMENT_FRN", String ( Today (), "dd/mm/yyyy" ) + "=>Changement de serrure effectuée")
idwCmde.SetItem (1, "DTE_ENV_CLI", Datetime ( Today (), Now() ) )

Return sPos

end function

private function string uf_controlergestion_mobistore (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_Mobistore (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 01/03/2011
//* Libellé			: Controler Spécifique pour MOBISTORE
//* Commentaires	: [PC10][DIAG_NOMADE]
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//        JFF   29/04/2014   [DT070]
//        JFF   02/09/2014   [PC13442_MOBZEN2]
//        JFF   07/04/2015   [PC13442-1]
//*-----------------------------------------------------------------

String sPos, sValCar, sDiagMbs, sDiagO2M, sIdTypArt, sVal, sIdGti, sIdRev
Long lDeb, lFin, lRow, lVal
n_cst_string lnv_string
Decimal {2} dcMtPrixTTCarticle, dcMajContract, dcMtPlaf680, dcMajContractLu, dcMajContract1
sPos = ""

/*------------------------------------------------------------------*/
/* Si nous ne sommes pas en gestion MOBISTORE, on ressort.          */
/*------------------------------------------------------------------*/

sIdTypArt = idwArticle.GetItemString ( alCpt, "ID_TYP_ART" )

If sIdTypArt = "AEF" Then
	
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 46 )
	If lDeb <= 0 Then Return sPos
	
	sValCar = idw_DetPro.GetItemString ( lDeb, "VAL_CAR" )
	sDiagMBS = lnv_string.of_Getkeyvalue( sValCar, "DIAG_MBS", ";" )
	If Trim ( sDiagMBS ) <> "" Then
		If Not Pos ( sDiagMBS, "#" + isTypApp + "#", 1 ) > 0 Then
			sDiagO2M = lnv_string.of_Getkeyvalue( sValCar, "DIAG_O2M", ";" )
			If Not Pos ( sDiagO2M, "#" + isTypApp + "#", 1 ) > 0 Then
				stMessage.sCode = "COMD664" // 
				stMessage.bouton = Ok!
				F_Message ( stMessage )
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"
			Else
				stMessage.sCode = "COMD665" // 
				stMessage.bouton = Ok!
				F_Message ( stMessage )
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"
				
			End If
		End if 
	End If
End If


If sIdTypArt = "DEV" Then
	If isTypApp = "TPC" and Pos ( isModlPortAdh, "IPAD", 1 ) > 0 Then
		stMessage.sCode = "COMD668" // 
		stMessage.bouton = Ok!
		F_Message ( stMessage )
		sPos = "ALT_CHOIX"
		Return "G" + "ALT_CHOIX"		
	End If	
End If
// [PC10][DIAG_NOMADE]	

// [PC13442-1]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 274	)
If lDeb > 0 Then
	lVal = idwWsin.GetItemNumber ( 1, "ID_ORIAN_BOUTIQUE" )
	If IsNull ( lVal ) Or lVal <= 0 Then
		stMessage.sCode = "COMD909" // 
		stMessage.bouton = Ok!
		F_Message ( stMessage )
		sPos = "ALT_CHOIX"
		Return "G" + "ALT_CHOIX"		
	End IF 
End If 

// Si DP 220 présente
// [DT070]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 220 )
If lDeb > 0 Then

	sVal = lnv_string.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "CAS", ";")

	Choose Case sVal
		Case "MOBISTORE_ET_PRODUIT_DERIVES"
	
			dcMtPrixTTCarticle = idwArticle.GetItemDecimal ( alCpt, "MT_PRIX_TTC" )
			If dcMtPrixTTCarticle <=0 Then dcMtPrixTTCarticle = idcMtPlafcmdeWeb
			dcMajContract1 = dcMtPrixTTCarticle * 0.20
			dcMajContract = dcMajContract1 
			
			sIdGti = String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) )
			sIdRev = String ( idwWsin.GetItemNumber ( 1, "ID_REV" ) )
			
			lRow = idwPlafond.Find ( " ID_GTI = " + sIdGti + &
											 " AND ID_REV = " + sIdRev + &
											 " AND ID_NIV_PLAF = '-GA' " + &
											 " AND Id_TYP_PLAF = '680'" + &
											 " AND ID_CPT_PLAF = 0", 1, idwPlafond.RowCount () ) 
			
			If lRow > 0 Then
				dcMtPlaf680 = idwPlafond.GetItemDecimal ( lRow, "MT_PLAF" )
				
				If dcMtPrixTTCarticle + dcMajContract1 > dcMtPlaf680 Then
					dcMajContract = dcMtPlaf680 - dcMtPrixTTCarticle
				End If
				
			End If

			dcMajContractLu = Dec ( lnv_string.of_Getkeyvalue( isInfoSpbFrnCplt, "MAJOR_CONTRACTUELLE_EUROS", ";"))

			If ( dcMajContract < dcMajContractLu Or ibAMU_MajContr = False ) And dcMtPlaf680 > 0 And dcMtPrixTTCarticle + dcMajContract1 > dcMtPlaf680 Then
				lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "MAJOR_CONTRACTUELLE_EUROS", String ( dcMajContract ), ";")
			End If

			// [MANTIS11213] 16/05/2014 JFF
			If ( dcMajContract > dcMajContractLu Or ibAMU_MajContr = False ) And ( dcMtPlaf680 <= 0 Or ( dcMtPlaf680 > 0 And dcMtPrixTTCarticle + dcMajContract1 <= dcMtPlaf680 )) Then
				lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "MAJOR_CONTRACTUELLE_EUROS", String ( dcMajContract ), ";")
			End If

	
		// [PC13442_MOBZEN2]
		Case "MOBISTORE_MOBILZEN2"
			
			dcMtPrixTTCarticle = idwArticle.GetItemDecimal ( alCpt, "MT_PRIX_TTC" )
			If dcMtPrixTTCarticle <=0 Then dcMtPrixTTCarticle = idcMtPlafcmdeWeb
			dcMajContract1 = 20

			lRow = idwWDivsin.Find ( "NOM_ZONE = 'ech_express_48h' AND VAL_CAR = 'O'", 1, idwWDivSin.RowCount () )
			If lRow > 0 Then 
				dcMajContract1 += 10
			End If
	
			dcMajContract = dcMajContract1 
			
			sIdGti = String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) )
			sIdRev = String ( idwWsin.GetItemNumber ( 1, "ID_REV" ) )
			
			lRow = idwPlafond.Find ( " ID_GTI = " + sIdGti + &
											 " AND ID_REV = " + sIdRev + &
											 " AND ID_NIV_PLAF = '-GA' " + &
											 " AND Id_TYP_PLAF = '680'" + &
											 " AND ID_CPT_PLAF = 0", 1, idwPlafond.RowCount () ) 
			
			If lRow > 0 Then
				dcMtPlaf680 = idwPlafond.GetItemDecimal ( lRow, "MT_PLAF" )
				
				If dcMtPrixTTCarticle + dcMajContract1 > dcMtPlaf680 Then
					dcMajContract = dcMtPlaf680 - dcMtPrixTTCarticle
				End If
				
			End If

			dcMajContractLu = Dec ( lnv_string.of_Getkeyvalue( isInfoSpbFrnCplt, "MAJOR_CONTRACTUELLE_EUROS", ";"))

			If ( dcMajContract < dcMajContractLu Or ibAMU_MajContr = False ) Then // And dcMtPlaf680 > 0 Then // And dcMtPrixTTCarticle + dcMajContract1 > dcMtPlaf680 Then
				lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "MAJOR_CONTRACTUELLE_EUROS", String ( dcMajContract ), ";")
				ibAMU_MajContr = True
			End If

			// [MANTIS11213] 16/05/2014 JFF ajout
			// [MANTIS12430] 30/09/2014 JFF retrait
/*
			If ( dcMajContract > dcMajContractLu Or ibAMU_MajContr = False ) And ( dcMtPlaf680 <= 0 Or ( dcMtPlaf680 > 0 And dcMtPrixTTCarticle + dcMajContract1 <= dcMtPlaf680 )) Then
				lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "MAJOR_CONTRACTUELLE_EUROS", String ( dcMajContract ), ";")
				ibAMU_MajContr = True					
			End If
*/

	
	End Choose
End If			
// [DT070]

Return sPos

end function

protected subroutine uf_gestionzone_infospbfrn_caspart (long alrowchoix, ref datawindow adw, ref string asfiltre, ref long aldefaut, ref long alidliste);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_Commande3::uf_GestionZone_InfoSpbFrn_CasPart (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 22/11/2004 14:58:44
//* Libellé       : Remaniement du filtre définitif pour gèrer des cas très particuliers
//* Commentaires  : DCMP XXXXXX
//*
//* Arguments     : Long			alRowChoix		Val		// Row du mobile cliqué
//*					  DataWindow	aDw				Réf	   // Dw commande ou prestation ?
//*					  String			asFiltre		   Réf 		// filtre à modifier
//*					  Long			alDefaut			Réf		// Valeur par défaut dans la zone
//*                 Long			alIdListe      Val      // code de la liste  #3
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    01/03/2005  DCMP 050095 : Uniquement 110 qqs la marque pour ANV uniquement.
//* #2	 PHG	  13/12/2007  [O2M] : GEstion O2M : Determination du cas par defaut
//*											 En fonction du param PRocess du parametrage -DP/95
//*											 Et gestion de la protectino de la saisie du RIB
//* #3    JFF    26/03/2008  [SURCOUF_ECH_EXPRESS]
//* #4 	 JFF	  20/10/2008  [FNAC_PROD_ECH_TECH]
//* #5    JFF    02/09/2009  [DCMP090327].[SBETV]
//* #6    JFF    07/10/2009  [DCMP090421]
//* #7    JFF    30/11/2009  [MSS_DIAG]
//* #8    JFF    02/03/2010  [MSS_LOT2]
//*       JFF    30/06/2010  [PC363_AUCHAN]
//*       JFF    26/07/2010  [ITSM_40837] Bug.
//*		 JFF    05/01/2011  [PC202].[DOM_COM]
//*       JFF    19/09/2011  [PM82][LOT1]
//*       JFF    12/12/2011  [VDOC4970]
//        JFF    17/04/2012  [PM200][LOT2][DESOX]
//        JFF    06/08/2012  [BLCODE]
//        JFF    26/11/2012  [PC877]
//        JFF    25/03/2013  [PC801_LOT1_V2]
//        JFF    02/04/2013  [PC929_CDISCOUNT]
//        JFF    07/05/2013  [PC938_ORANGE_V3]
//        JFF    15/07/2013  [PC929-1]
//        JFF    04/09/2013  [PC929_CDISCOUN_M8601]
//        JFF    12/12/2013  [PC947&977]
//        JFF    26/05/2013  [DT87]
//        JFF    12/12/2014  [PC13321]
//        JFF    02/01/2015  [PC801_6_TAMET]
//        JFF    09/04/2015  [DT141]
//        JFF    18/06/2015  [VDOC17951]
//        JFF    30/06/2015  [DT156]
//        JFF    26/10/2015  [PC786-2_V3]
//        JFF    29/02/2016  [DT191-1]
//        JFF    07/11/2016  [PC151259]
//        JFF    02/01/2017  [DT253]
//        JFF    13/03/2017  [MODIF_RECH_DP_95]
//        JFF    21/02/2107  [DT288]
//        JFF    29/05/2017  [PC151259-2]
//        JFF    05/10/2017  [PC171918]
//        JFF    05/12/2017  [PM426-1]
//        JFF    03/09/2018  [DT361]
//        JFF    17/09/2018  [PM444-1]
//        JFF    26/11/2018  [PC874_2_V1]
//*-----------------------------------------------------------------
String	sIdFour
n_cst_attrib_key	lnv_Key[] 			// #2 [O2M]
n_cst_attrib_key	TbNull[] 			// #2 [O2M]
string				sTypApp, sAction 	// #2 [O2M]
long					lRow, lProcess		// #2 [O2M]
Long					lPos // [MSS_DIAG]
Long					lRow175
Long 					lDeb, lFin, lDeb1, lFin1, lDeb2, lFin2
Boolean	abRdvAPrendre
n_cst_attrib_rdv lnvRDV
String sFrnDptIdfApm, sFrnDptIdfMat, sDept, sVal // [MSS_DIAG]
n_cst_string	lnv_string
String sVarianteAuchan
Boolean bTempoCle, bProcessForce 
Long lVal

abRdvAPrendre = FALSE
sIdFour = Trim ( Upper ( aDw.GetItemString ( alRowChoix, "ID_FOUR" ) ) )

// #7 [MSS_DIAG] Code déplacé, remonté ici pour factorisation sur les 3 fournisseurs
sAction  = adw.object.id_ref_four[alrowchoix]
sTypApp = isTypApp

// [DT191-1]
If isChoixAction = "C" Then
	sAction = "A_COMMANDER"
End If

lnv_Key[1].iskeyname	 ="TYP_APP"
lnv_Key[1].iakeyvalue =sTypApp
lnv_Key[2].iskeyname	 ="ID_COUR"
lnv_Key[3].iskeyname	 ="ACTION"
lnv_Key[3].iakeyvalue = sAction
lnv_Key[4].iskeyname	 ="PROCESS"

// #4 JFF [FNAC_PROD_ECH_TECH]				
lnv_Key[5].iskeyname	 ="CTG"
lnv_Key[6].iskeyname	 ="EMBORG"
lnv_Key[7].iskeyname	 ="PROCESS_EMBORG"
lnv_Key[8].iskeyname	 ="DEPOT_FNAC"
lnv_Key[9].iskeyname	 ="PROCESS_FNAC"
lnv_Key[10].iskeyname ="FRN"
lnv_Key[11].iskeyname ="MT_FRAIS"
lnv_Key[12].iskeyname ="RTR_PAR_TRP"
lnv_Key[13].iskeyname ="PROCESS_TRP"
// :#4 JFF [FNAC_PROD_ECH_TECH]				

// [DCMP090421]
lnv_Key[14].iskeyname ="CLT_VIP"     // client TONE/VIP ?
lnv_Key[15].iskeyname ="ENV_TLCHG"   // Env par assuré par coliss. ou télécharg bon prépayé?
lnv_Key[16].iskeyname ="PROCESS_ENV_TLCHG" // Process lié à ENV_TLCHG
lnv_Key[17].iskeyname ="EMBORGOK" // Ok donc pour Emb Orig ?
// :#7 [MSS_DIAG]

// #7 [MSS_DIAG]
lnv_Key[18].iskeyname ="FRN_DPT_IDF_MAT" 
lnv_Key[19].iskeyname ="FRN_DPT_IDF_APM"
lnv_Key[20].iskeyname ="ENV_CRT_PREPY"
lnv_Key[21].iskeyname ="PROCESS_CRT_PREPY"

// [PC363_AUCHAN]
lnv_Key[22].iskeyname ="CLT_FRT"
lnv_Key[23].iskeyname ="PRC_FRT"

// [ITSM_40837] Bug
lnv_Key[24].iskeyname ="DEPOT_FNAC_ALT"
lnv_Key[25].iskeyname ="PROCESS_FNAC_ALT"
lnv_Key[26].iskeyname ="PROCESS_ALT"

// [PC202].[DOM_COM]
lnv_Key[27].iskeyname ="DOM_COM"

// BLCODE
lnv_Key[28].iskeyname = "P_DEPOT_PAR_ASS"
lnv_Key[29].iskeyname = "P_ENVOI_PAR_ASS"
lnv_Key[30].iskeyname = "P_BLCODE_ENV_BONPPAYE_COURR_OU_MAIL"
lnv_Key[31].iskeyname = "P_BLCODE_ENV_CARTONVD_AVEC_BONPPAYE";
lnv_Key[32].iskeyname = "P_BONPPAYE_DISPO_SITE"
lnv_Key[33].iskeyname = "P_ENLEV_CHEZ_ASSURE"
lnv_Key[34].iskeyname = "MODE_BLC"

// [PC877]
lnv_Key[35].iskeyname = "ENVASS"
lnv_Key[36].iskeyname = "AVANCE_FRAIS"
lnv_Key[37].iskeyname = "PROCESS_AVANCE_FRAIS"
lnv_Key[38].iskeyname = "ENV_TLCHG2"
lnv_Key[39].iskeyname = "PROCESS_ENV_TLCHG2"	

// [PC929_CDISCOUNT]
lnv_Key[40].iskeyname = "EMBORG2"	

// [DT87]
lnv_Key[41].iskeyname = "PROCESS_HM"	

// [DT156]
lnv_Key[42].iskeyname = "SCAPSAV"	
lnv_Key[43].iskeyname = "PROCESS_SCAPSAV"		

// [PC786-2_V3]
lnv_Key[44].iskeyname = "CARTON_ADAPTE"	
lnv_Key[45].iskeyname = "PROCESS_CARTON_ADAPTE"		

// [DT191-1] // [DT288]
lnv_Key[46].iskeyname = "QREL_PICKUP_RET"	
lnv_Key[47].iskeyname = "PROCESS_PICKUP"	
lnv_Key[48].iskeyname = "Q_PICKUP"	


// [ICI_20180905] !! placement du process_prs !!


// :#7 [MSS_DIAG]

Choose Case sIdFour 
	
	Case "PSM"

		// [PC929_CDISCOUN_M8601]
		bProcessForce = False
		Choose Case sAction 
			Case "REFUSE_A_REEXP", "A_REPARER_FORCE", "A_DESOXYDER_FORCE", "PEC_A_RECYCLER", "A_DIAG_FORCE"
			alDefaut = 430
			bProcessForce = True
		End Choose

		If Not bProcessForce Then
			// [PC877] // [PC929-1] // [PC947&977]
			F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 209 )			
			If lDeb > 0 Then
				sVal = Trim ( lnv_string.of_Getkeyvalue( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "PROCESS", ";") )
				bTempoCle = sVal <> "" 
			End If
			
			If bTempoCle  Then 
				
				lnv_Key = TbNull
				lnv_Key[1].iskeyname	 = "TYP_APP"
				lnv_Key[1].iakeyvalue = sTypApp
				lnv_Key[2].iskeyname	 = "ID_COUR"
				lnv_Key[3].iskeyname	 = "ACTION"
				lnv_Key[4].iskeyname	 = "PROCESS"
				lnv_Key[5].iskeyname	 = "PROXI_EMBORIG"								
				lnv_Key[6].iskeyname	 = "PROCESS_PROXI_EMBORG"								
				lnv_Key[7].iskeyname	 = "COLI_PREPAYE"
				lnv_Key[8].iskeyname	 = "PROCESS_COLI_PREPAYE"
				lnv_Key[9].iskeyname	 = "MT_FRAIS"
				lnv_Key[10].iskeyname = "INTER_DOM"
				lnv_Key[11].iskeyname = "PROCESS_INTER_DOM"				
				lnv_Key[12].iskeyname = "EMBORIG"	
				lnv_Key[13].iskeyname = "PROCESS_EMBORG_BONPREPAYE"
				lnv_Key[14].iskeyname = "PROCESS_PROXI_UNIQ"					
				
				// [PC938_ORANGE_V3]
				lnv_Key[15].iskeyname = "PRET_STD"					
				lnv_Key[16].iskeyname = "ADR_MAIL" // [VDOC17951]
				lnv_Key[17].iskeyname = "PROCESS_MAIL_BONPREPAYE" // [VDOC17951]
	
				// [DT191-1]
				lnv_Key[18].iskeyname = "QREL_PICKUP_RET"	
	
				F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 209, lnv_Key )
				
				if lRow > 0 Then
					alDefaut = long (lnv_Key[4].iakeyvalue)
					Choose Case TRUE
	
						Case ( ( alDefaut >= 2100 and alDefaut <= 2199 ) Or alDefaut = 0 ) 
							This.uf_GestionZone_InfoSpbFrn_PSM_2100 ( lnv_Key, alDefaut, abRdvAPrendre )						
							
					End Choose
	
					Choose Case alDefaut				
			
						Case -1
							idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "0" )
						Case Else  
							idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "1" )
					End Choose				
				End If 
			End If 							
		End If

	// [PC801_6_TAMET]	
	Case "TMT"

		// [PC929_CDISCOUN_M8601]
		bProcessForce = False
		Choose Case sAction 
			Case "REFUSE_A_REEXP", "A_REPARER_FORCE", "A_DESOXYDER_FORCE", "PEC_A_RECYCLER", "A_DIAG_FORCE"
			alDefaut = 430
			bProcessForce = True
		End Choose

		If Not bProcessForce Then
			// [PC877] // [PC929-1] // [PC947&977]
			F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 267 )			
			If lDeb > 0 Then
				sVal = Trim ( lnv_string.of_Getkeyvalue( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "PROCESS", ";") )
				bTempoCle = sVal <> "" 
			End If
			
			If bTempoCle  Then 
				
				lnv_Key = TbNull
				lnv_Key[1].iskeyname	 = "TYP_APP"
				lnv_Key[1].iakeyvalue = sTypApp
				lnv_Key[2].iskeyname	 = "ID_COUR"
				lnv_Key[3].iskeyname	 = "ACTION"
				lnv_Key[4].iskeyname	 = "PROCESS"
				lnv_Key[5].iskeyname	 = "PROXI_EMBORIG"								
				lnv_Key[6].iskeyname	 = "PROCESS_PROXI_EMBORG"								
				lnv_Key[7].iskeyname	 = "COLI_PREPAYE"
				lnv_Key[8].iskeyname	 = "PROCESS_COLI_PREPAYE"
				lnv_Key[9].iskeyname	 = "MT_FRAIS"
				lnv_Key[10].iskeyname = "INTER_DOM"
				lnv_Key[11].iskeyname = "PROCESS_INTER_DOM"				
	
				// [PC801_LOT1_V2]
				lnv_Key[12].iskeyname = "EMBORIG"
				lnv_Key[13].iskeyname = "PROCESS_EMBORG_BONPREPAYE"
				lnv_Key[14].iskeyname = "PROCESS_PROXI_UNIQ"					
				
				// [PC938_ORANGE_V3]
				lnv_Key[15].iskeyname = "PRET_STD"					
				
	
				F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 267, lnv_Key )
				
				if lRow > 0 Then
					alDefaut = long (lnv_Key[4].iakeyvalue)
					Choose Case TRUE
	
						Case ( ( alDefaut >= 2500 and alDefaut <= 2599 ) Or alDefaut = 0 ) 
							This.uf_GestionZone_InfoSpbFrn_TAMET_2500 ( lnv_Key, alDefaut, abRdvAPrendre )						
							
					End Choose
	
					Choose Case alDefaut				
			
						Case -1
							idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "0" )
						Case Else  
							idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "1" )
					End Choose				
				End If 
			End If 							
		End If

	Case "BLC" // #2 

		if lower(adw.ClassName() ) = "dw_article" then // On blinde pour etre sur de tapper la bonne dw
			
			F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv_Key )
			
			// #4 JFF [FNAC_PROD_ECH_TECH]				
			if lRow > 0 Then
				alDefaut = long (lnv_Key[4].iakeyvalue)
				Choose Case TRUE

					Case ( ( alDefaut >= 900 and alDefaut <= 999 ) Or alDefaut = 0 ) And sAction = "A_DIAGNOSTIQUER" 
						This.uf_GestionZone_InfoSpbFrn_BLC_900 ( lnv_Key, alDefaut, abRdvAPrendre )						
						
				End Choose

				Choose Case alDefaut				
		
					Case -1
						idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "0" )
					Case Else  
						idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "1" )
				End Choose				
			End If 
		End If 			
		
	// [DT141] Ajout SBE
	// [DT253]
	Case "O2M", "MTT", "SBE", "COR" // #2 [O2M]Calcul de la valeur par defaut de la liste à attribuer

		// [PC13321]
		if ( lower(adw.ClassName() ) = "dw_article" ) Or ( lower(adw.ClassName() ) = "dw_article_prs" ) then // On blinde pour etre sur de tapper la bonne dw

			lnv_Key[10].iakeyvalue = sIdFour
			F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv_Key )
			If lRow <= 0 Then 
				lnv_Key[10].iakeyvalue = ""
			End If
							
			F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv_Key )
			
			// #4 JFF [FNAC_PROD_ECH_TECH]				
			if lRow > 0 Then
				alDefaut = long (lnv_Key[4].iakeyvalue)
				Choose Case TRUE
					Case alDefaut < 900
						// [O2M] Gestion de la protection du rib
						Choose CAse alDefaut
							Case 415, 420
								idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "0" )
		//					Case 410  // #4 JFF [FNAC_PROD_ECH_TECH]
							Case Else  // #4 JFF [FNAC_PROD_ECH_TECH]
								idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "1" )
						End Choose

					// [VDOC4970]
					Case alDefaut >= 900 and alDefaut <= 999 And sAction = "PEC_A_RECYCLER" 
						
						lRow175 = idwCmdeSin.find ( "ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT <> 'ANN' AND STATUS_GC = 175 AND ID_FOUR = 'O2M'", 1, idwCmdeSin.RowCount () )
						If lRow175 > 0 Then
							alDefaut = 0
						End If

					// [PC13321]
					// [DT191-1]
					Case alDefaut >= 900 and alDefaut <= 999 And ( sAction = "A_DIAGNOSTIQUER" OR sAction = "A_REPARER" OR sAction = "A_COMMANDER" ) 

							This.uf_GestionZone_InfoSpbFrn_O2M_900 ( lnv_Key, alDefaut, abRdvAPrendre )

							If abRdvAPrendre Then 			
								lnvRDV = create n_cst_attrib_rdv
								
								lnvRDV.dtDteHeuRef 					= datetime(Today (), Now ())																
								lnvRDV.iNbreRdvADemander			= 2
								lnvRDV.iAjoutNbHeuPremierRDV		= 24
								lnvRDV.tHeuMiniRdv					= 08:00:00
								lnvRDV.tHeuMaxiRdv					= 18:00:00
								lnvRDV.iIncrRdvMinute				= 60
								lnvRDV.iIncrRdvDate					= 1
								lnvRDV.iNbMinuteParPlageHoraire	= 240
								lnvRDV.iNbreJourCalendaireMax		= 60
								lnvRDV.iRdvAutoriseMemeJournee	= 1
								lnvRDV.bJourOuvrable					= FALSE
								lnvRDV.bJFerie							= FALSE
								lnvRDV.bDimanche						= FALSE
								lnvRDV.bAnnulerautorise				= FALSE
								lnvRDV.sMsg								= "Veuillez prendre " + String ( lnvRDV.iNbreRdvADemander ) + " rendez-vous avec l'assuré. Attention ! Un rendez-vous par journée."
						
								Do While lnvRDV.uf_getrdv( ) = "" Or lnvRDV.uf_getrdv( ) = "[ANNULER]"
									OpenWithParm(w_trt_choix_rdv, lnvRDV )
									lnvRDV = message.PowerObjectParm
						
									If lnvRDV.uf_getrdv( ) = "" Or lnvRDV.uf_getrdv( ) = "[ANNULER]" Then 
										stMessage.Bouton		= Ok!
										stMessage.Icon			= Information!
										stMessage.bErreurG	= FALSE
										stMessage.sCode		= "COMD488"
										stMessage.sVar [1]   = String ( lnvRDV.iNbreRdvADemander )
										f_Message ( stMessage ) 
									End If
								Loop
						
								If isInfoSpbFrncplt <> "" Then
										isInfoSpbFrncplt += ";"
								End If
							   isInfoSpbFrncplt += "DTE_HEU_RDV="+ lnvRDV.uf_getrdv( )
						
								Destroy lnvRDV
							End IF

					
						Choose Case alDefaut				
				
							Case 905, 910, 915, 920, 936, 941
								idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "0" )
							Case Else  
								idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "1" )
						End Choose				
					End Choose
			// :#4 JFF [FNAC_PROD_ECH_TECH]								

			ElseIf lRow = 0 Then

				// [PC13321]
				If lower ( adw.ClassName() ) <> "dw_article_prs" Then
					alDefaut = 990 // Aucune Action Particulière si non trouvée.
					idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "1" )
				End If 
			End If
		End If

		// [PC938_ORANGE_V3]
		F_RechDetPro ( lDeb2, lFin2, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 239 )
		If lDeb2 > 0 Then
			If lower(adw.ClassName() ) = "dw_article_prs" Then // On blinde pour etre sur de tapper la bonne dw
				This.uf_GestionZone_InfoSpbFrn_O2M_PRS ( alDefaut )
			End If
		End If
		
		// [PC929_CDISCOUNT][PC929-2-V3]
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 235 )
		If lDeb > 0 Then
			If lnv_string.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "TVSUP32P", ";") = "OUI" Then
				Choose Case isTypApp
					Case "TL7", "TLO", "TPS"  // Les TV >= 32 pouces
						If lower(adw.ClassName() ) = "dw_article_prs" Then // On blinde pour etre sur de tapper la bonne dw
							This.uf_GestionZone_InfoSpbFrn_O2M_PRS ( alDefaut )
						End If
						
						If lower(adw.ClassName() ) = "dw_article" And sAction = "A_DIAGNOSTIQUER" Then // On blinde pour etre sur de tapper la bonne dw
									alDefaut = 0
									ibDecocherPresta = True
									stMessage.Bouton		= Ok!
									stMessage.Icon			= Information!
									stMessage.bErreurG	= FALSE
									stMessage.sCode		= "COMD873"
									f_Message ( stMessage ) 
						End If
						
						
				End Choose
			End If
		End If
		// [PC929_CDISCOUNT][PC929-2-V3]		
		

	// #5 [DCMP090327].[SBETV]
	Case "SB1" // #2 [O2M]Calcul de la valeur par defaut de la liste à attribuer

			// :#4 JFF [FNAC_PROD_ECH_TECH]				

			F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv_Key )
			
			// #4 JFF [FNAC_PROD_ECH_TECH]				
			if lRow > 0 Then
// [ITSM_40837] Bug.
//				alDefaut = long (lnv_Key[4].iakeyvalue)
				alDefaut = long (lnv_Key[26].iakeyvalue)				

				Choose Case TRUE

					Case alDefaut >= 1100 and alDefaut <= 1199 And ( sAction = "A_DIAGNOSTIQUER" Or sAction = "A_REPARER" )
							This.uf_GestionZone_InfoSpbFrn_SBETV_1100 ( lnv_Key, alDefaut, abRdvAPrendre )

							If abRdvAPrendre Then 			
								// Pas de Rdv pour SBETV, 
							End IF
							
						Choose Case alDefaut				
				
							Case -1
								idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "0" )
							Case Else  
								idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "1" )
						End Choose				
					End Choose
			// :#4 JFF [FNAC_PROD_ECH_TECH]								
				
			ElseIf lRow = 0 Then
				alDefaut = 1190 // Aucune Action Particulière si non trouvée.
				idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "1" )
			End If
	// #5 [DCMP090327].[SBETV]


	// #7 [MSS_DIAG]
	Case "MS1" // #2 [O2M]Calcul de la valeur par defaut de la liste à attribuer
		if lower(adw.ClassName() ) = "dw_article" then // On blinde pour etre sur de tapper la bonne dw

			F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv_Key )
			
			// #4 JFF [FNAC_PROD_ECH_TECH]				
			if lRow > 0 Then
//				alDefaut = long (lnv_Key[4].iakeyvalue)

				sVal = String ( lnv_Key[4].iaKeyValue )
				lPos = Pos ( sVal, "/", 1)
				If lPos <= 0 Then
					alDefaut = Long ( sVal )
				Else
					alDefaut = Long ( Left ( sVal, lPos - 1  ) )
				End If					
				Choose Case TRUE

					Case alDefaut >= 1200 and alDefaut <= 1299 And sAction = "A_DIAGNOSTIQUER" 
							This.uf_GestionZone_InfoSpbFrn_MSSDIAG_1200 ( lnv_Key, alDefaut, abRdvAPrendre )

							If abRdvAPrendre Then 			

								// Saisie Dépt Enlèv.
								sDept = ""
								Do While sDept = "" Or sDept = "[RETOUR]"

									Open( w_sp_trt_saisie_dept )
									sDept = Message.StringParm
				
									If sDept = "" Or sDept = "[RETOUR]" Then 
										stMessage.Bouton		= Ok!
										stMessage.Icon			= Information!
										stMessage.bErreurG	= FALSE
										stMessage.sCode		= "COMD551"
										f_Message ( stMessage ) 
									End If
								Loop
				
								sDept = lnv_string.of_getkeyvalue (sDept, "DEPT", ";")
								If IsNull ( sDept ) Then sDept = ""
								isDept=sDept

								If isDept <> "" Then
									If isInfoSpbFrncplt <> "" Then
										isInfoSpbFrncplt += ";"
									End If
									isInfoSpbFrncplt += "DEPT_ENLEV=" + isDept
								End If
								
								// Lecture param
								sFrnDptIdfMat = lnv_Key[18].iakeyvalue
								sFrnDptIdfApm = lnv_Key[19].iakeyvalue

								lnvRDV = create n_cst_attrib_rdv
								
								lnvRDV.dtDteHeuRef 					= datetime(Today (), Now ())																
								lnvRDV.iNbreRdvADemander			= 1
								lnvRDV.iAjoutNbHeuPremierRDV		= 48
								lnvRDV.iIncrRdvDate					= 1
								lnvRDV.iNbreJourCalendaireMax		= 60
								lnvRDV.iRdvAutoriseMemeJournee	= 1
								lnvRDV.bJFerie							= FALSE
								lnvRDV.bDimanche						= FALSE
								lnvRDV.bAnnulerautorise				= FALSE
								lnvRDV.sMsg								= "Veuillez prendre " + String ( lnvRDV.iNbreRdvADemander ) + " rendez-vous avec l'assuré sur les plages horaires suivantes "

								lnvRDV.tHeuMiniRdv			= 14:00:00
								lnvRDV.tHeuMaxiRdv			= 18:00:00
								lnvRDV.iIncrRdvMinute		= 10000
								
								lnvRDV.iNbMinuteParPlageHoraire	= 240
								lnvRDV.bJourOuvrable			= TRUE
								lnvRDV.tJourOuvrableMaxRdvSamedi	= 13:00:00

								
								// Préparation Rdv en fontion des cas.
								If Pos ( sFrnDptIdfMat, "#" + sDept + "#", 1 ) <= 0 And Pos ( sFrnDptIdfApm, "#" + sDept + "#", 1 ) <= 0  Then
									// Province
									lnvRDV.sMsg = "Le département est en province." + lnvRDV.sMsg + " (jours ouvrables, matin ou après-midi)."
									lnvRDV.bGenerationForcee		= TRUE
									lnvRDV.sTbDefinitionGenForcee [1]       = "08:00-13:00;14:00-18:00" // Lundi
									lnvRDV.sTbDefinitionGenForcee [2]       = "08:00-13:00;14:00-18:00" // Mardi
									lnvRDV.sTbDefinitionGenForcee [3]       = "08:00-13:00;14:00-18:00" // Mercredi
									lnvRDV.sTbDefinitionGenForcee [4]       = "08:00-13:00;14:00-18:00" // Jeudi
									lnvRDV.sTbDefinitionGenForcee [5]       = "08:00-13:00;14:00-18:00" // Vendredi
									lnvRDV.sTbDefinitionGenForcee [6]       = "08:00-13:00" // Samedi
									lnvRDV.sTbDefinitionGenForcee [7]       = "" //Dimanche
									
								ElseIf Pos ( sFrnDptIdfMat, "#" + sDept + "#", 1 ) > 0 Then
									// Mat IDF
									lnvRDV.sMsg = "Le département est en île de france." + lnvRDV.sMsg + " (jours ouvrables, matin uniquement)."
									lnvRDV.bGenerationForcee		= TRUE
									lnvRDV.sTbDefinitionGenForcee [1]       = "08:00-13:00" // Lundi
									lnvRDV.sTbDefinitionGenForcee [2]       = "08:00-13:00" // Mardi
									lnvRDV.sTbDefinitionGenForcee [3]       = "08:00-13:00" // Mercredi
									lnvRDV.sTbDefinitionGenForcee [4]       = "08:00-13:00" // Jeudi
									lnvRDV.sTbDefinitionGenForcee [5]       = "08:00-13:00" // Vendredi
									lnvRDV.sTbDefinitionGenForcee [6]       = "08:00-13:00" // Samedi
									lnvRDV.sTbDefinitionGenForcee [7]       = "" //Dimanche
							
								ElseIf Pos ( sFrnDptIdfApm, "#" + sDept + "#", 1 ) > 0 Then
									// Apm Idf
									lnvRDV.bGenerationForcee		= TRUE
									lnvRDV.sMsg = "Le département est en île de france." + lnvRDV.sMsg + " (jours ouvrés, après-midi uniquement)."
									lnvRDV.sTbDefinitionGenForcee [1]       = "14:00-18:00" // Lundi
									lnvRDV.sTbDefinitionGenForcee [2]       = "14:00-18:00" // Mardi
									lnvRDV.sTbDefinitionGenForcee [3]       = "14:00-18:00" // Mercredi
									lnvRDV.sTbDefinitionGenForcee [4]       = "14:00-18:00" // Jeudi
									lnvRDV.sTbDefinitionGenForcee [5]       = "14:00-18:00" // Vendredi
									lnvRDV.sTbDefinitionGenForcee [6]       = "" // Samedi
									lnvRDV.sTbDefinitionGenForcee [7]       = "" //Dimanche
									
								End If
								
								Do While lnvRDV.uf_getrdv( ) = "" Or lnvRDV.uf_getrdv( ) = "[ANNULER]"
									OpenWithParm(w_trt_choix_rdv, lnvRDV )
									lnvRDV = message.PowerObjectParm
						
									If lnvRDV.uf_getrdv( ) = "" Or lnvRDV.uf_getrdv( ) = "[ANNULER]" Then 
										stMessage.Bouton		= Ok!
										stMessage.Icon			= Information!
										stMessage.bErreurG	= FALSE
										stMessage.sCode		= "COMD488"
										stMessage.sVar [1]   = String ( lnvRDV.iNbreRdvADemander )
										f_Message ( stMessage ) 
									End If
								Loop 
						
								If isInfoSpbFrncplt <> "" Then
										isInfoSpbFrncplt += ";"
								End If
							   isInfoSpbFrncplt += "DTE_HEU_RDV="+ lnvRDV.uf_getrdv( )

								Destroy lnvRDV	
							
							End IF
							
						Choose Case alDefaut				

// #8 [MSS_LOT2].[P_JFF_2]
//							Case 1234, 1235
							Case 1234
								idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "0" )
							Case Else  
								idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "1" )
						End Choose				
					End Choose
			// :#4 JFF [FNAC_PROD_ECH_TECH]								
				
			ElseIf lRow = 0 Then
				alDefaut = 1290 // Aucune Action Particulière si non trouvée.
				idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "1" )
			End If
		End If	
	// :#7 [MSS_DIAG]	
	
	// [PC151259-2] // [PC171918] // [PM444-1]
	Case "EKO", "DGC", "NET", "SMT", "RAV", "RTP", "SFG", "AGP"

		lnv_Key[10].iakeyvalue = isFournParDefaut

		F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv_Key )
		
		// [PC151259]
		if lRow > 0 Then
			alDefaut = long (lnv_Key[4].iakeyvalue)
		End If
		
End Choose

// [PM426-1]  pour la désact, mettre "CIS" dans le case au dessus et supprimer cette partie
If F_CLE_A_TRUE ( "PM426-1" ) Then
	Choose Case sIdFour 
		Case "CIS"
			lnv_Key[10].iakeyvalue = isFournParDefaut
	
			F_RechDetPro_withkey ( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv_Key )
			
			// [PC151259]
			if lRow > 0 Then
				alDefaut = long (lnv_Key[4].iakeyvalue)
			End If			
	End Choose 
End If

// [DT361]
Choose Case sIdFour 
	Case "CEA"
	if ( lower(adw.ClassName() ) = "dw_article_prs" ) then // On blinde pour etre sur de tapper la bonne dw

		lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'PROCESS_PRS'", 1, idwWDivSin.RowCount () ) 
		If lRow >0 Then 
			lVal = idwWDivSin.GetItemNumber ( lRow, "VAL_NBRE" ) 
			If IsNull ( lVal ) Then lVal = 0
			IF lVal = 0 Then lVal = 3110
			alDefaut = lVal 
		End If
	Else
		alDefaut = 990
	End if
End Choose 

// [PC874_2_V1]
Choose Case sIdFour 
	Case "OMT"
	if ( lower(adw.ClassName() ) = "dw_article_prs" ) then // On blinde pour etre sur de tapper la bonne dw

		lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'PROCESS'", 1, idwWDivSin.RowCount () ) 
		If lRow >0 Then 
			lVal = idwWDivSin.GetItemNumber ( lRow, "VAL_NBRE" ) 
			If IsNull ( lVal ) Then lVal = 0
			alDefaut = lVal 
		End If
	Else
		alDefaut = 990
	End if
End Choose 

end subroutine

private subroutine uf_gestionzone_infospbfrn_o2m_900 (ref n_cst_attrib_key alnv_key[], ref long aldefaut, ref boolean abrdvaprendre);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_Commande3::uf_GestionZone_InfoSpbFrn_O2M_900 (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 24/10/2008 17h12
//* Libellé       : Process particuliers pour FNAC EPT sur liste 900
//* Commentaires  : [FNAC_PROD_ECH_TECH] [AUCH_SITCOL_NVFRONT]
//*
//* Arguments     : n_cst_attrib_key  alnv_key[]		Réf		// Valeur par défaut dans la zone
//*		    		  Long				  alDefaut        Réf	   // Process retenu
//*					  Boolean			  abRdvAPrendre   Réf      // TRUE : Un Rdv est à prendre.
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    13/02/2008  [FNAC_PROD_ECH_TECH].[20090213145759303]
//* #2    JFF    13/02/2008  [FNAC_PROD_ECH_TECH].[20090223142259343]
//* #3    JFF    19/05/2009  [DCMP090172]
//* #4    JFF    05/05/2009  [RUEDUCOMMERCE]
//* #5    JFF    28/07/2009  [DCMP090378]
//* #6    JFF    02/09/2009  [DCMP090327].[SBETV]
//* #7    JFF    07/10/2009  [DCMP090421]
//* #8    JFF    16/11/2009  [DCMP090421].[20091116110244950]
//* #9    JFF    18/11/2009  [DCMP090421].[20091118105631390]
//*       JFF    10/06/2010  [PC419/440/418/439_MICROMANIA]
//*       JFF    30/06/2010  [PC363_AUCHAN]
//*		 JFF    05/01/2011  [PC202].[DOM_COM]
//* 	    JFF    05/01/2011  [PC545].[POINT].[229]
//*       JFF    05/07/2011  [PC292][AUCHAN]
//*       JFF    05/07/2011  [AUCHAN].[AUCH_SITCOL_NVFRONT]
//*       JFF    12/12/2011  [VDOC4970]
//        JFF    06/08/2012  [BLCODE]
//        JFF    26/11/2012  [PC877]
//        JFF    17/01/2013  [PC913]
//        JFF    25/03/2013  [PC801_LOT1_V2]
//        JFF    26/05/2013  [DT87]
// 		 FPI	  27/02/2015  [VDOC16821] On se base sur le cp de l'assuré ald la caisse
//        JFF    10/06/2015  [PM280-1][MANTIS15456]
//        JFF    30/06/2015  [DT156]
//		    FPI	  07/10/2015  [VDOC18660]
//        JFF    26/10/2015  [PC786-2_V3]
//        JFF    29/02/2016  [DT191-1]
//        JFF    23/03/2016  [DT191-1][MANTIS20039]
//			 FPI	  07/07/2016 [VDoc21247]
//        JFF    02/03/2107 [MODIF_SCAPSAV]
//        JFF    21/02/2107 [DT288]
//*-----------------------------------------------------------------
stMessage.sTitre		= "Process"
Boolean bDepotFNAC, bEmbOrig, bAppSin, bAlimSin, bBattSin, bAccSin, bElectroDepot
Boolean bRtrParTrp, bPrestaExistante, bMaterielChezO2M, bFNACEpt, bCltVIP, bEnvoiOuTeleChg, bEmbOrigOk, bAuchan
Boolean bPrestaScapSavExistanteRefusee 
String  sCTG, sNomContractant, sVal, sResidant, sResidant2, sVarianteAuchan, sAdrMail
Long 	  lRow, lDeb, lFin, lCaisse, lRow4
n_cst_string	lnv_string
Boolean bRDCommerce // #4 [RUEDUCOMMERCE]
Boolean bMicromania // [PC419/440/418/439_MICROMANIA]
Boolean bCltFrontalier // [PC363_AUCHAN]
Boolean bCltFrontResidant1 
Boolean bEnvAss, bAvanceFrais, bEnvTlchg2, bARepGti 
Boolean bRetRelPickUp  // [DT191-1]
Boolean bRelaiPickUp // [DT288]
String  sRet 

alDefaut = 0
sResidant=""
sRet = ""

// #6 [DCMP090327].[SBETV]
If isInfoSpbFrncplt <> "" Then
	isInfoSpbFrncplt += ";"
End If
isInfoSpbFrncplt += "MAT_SIN="	

abRdvAPrendre = FALSE

bDepotFNAC = FALSE
bEmbOrig= FALSE
bRtrParTrp = False
bAppSin = FALSE
bAlimSin = FALSE
bAccSin = FALSE
bBattSin = FALSE
bCltVIP = FALSE // #7 [DCMP090421]
bEnvoiOuTeleChg = FALSE // #7 [DCMP090421]
bCltFrontResidant1 = FALSE

// [PC292][AUCHAN]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 140 )
If lDeb > 0 Then
	bAuchan = TRUE
	sResidant = Trim ( lnv_string.of_Getkeyvalue( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "RESIDANT", ";") )
	sResidant2 = Trim ( lnv_string.of_Getkeyvalue( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "RESIDANT2", ";") )
	sVarianteAuchan = Trim ( lnv_string.of_Getkeyvalue( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";") )
End If		
// [PC292][AUCHAN]			

// #3 [DCMP090172]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 59 )
If lDeb > 0 Then
	sNomContractant = Trim ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ) )
Else 
	sNomContractant = ""
End If
If IsNull ( sNomContractant ) Then sNomContractant = ""
// :#3 [DCMP090172]


//* #4 [RUEDUCOMMERCE]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 114 )
bRDCommerce = lDeb > 0
//* :#4 [RUEDUCOMMERCE]

// [PC419/440/418/439_MICROMANIA]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 137 )
bMicromania = lDeb > 0
// [PC419/440/418/439_MICROMANIA]

//* #5 [DCMP090378]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 105 )
bFNACEpt = lDeb > 0
//* :#5 [DCMP090378]

// [PC13321]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 266 )
bElectroDepot = lDeb > 0

// L'appareil est-il sinistré ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'APP_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bAppSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

// La batterie est-elle sinistrée ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'BATT_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bBattSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

// L'alim est-elle sinistrée ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'ALIM_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bAlimSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

// [VDOC4970]
// L'Autre Accessoire est-elle sinistrée ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'AUT_ACC_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bAccSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

// La catégorie de l'appareil
sCTG = alnv_key [5].iaKeyValue

//* #1 [FNAC_PROD_ECH_TECH].[20090213145759303]
bPrestaExistante = idwCmdeSin.Find ( "ID_FOUR = 'O2M' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT = 'RFO'", 1, idwCmdeSin.RowCount ()) > 0 

// [DT156]
// lnv_Key[42].iskeyname = "SCAPSAV"
If alnv_key [42].iaKeyValue = "OUI" Then
	bPrestaExistante = False
End If

// [MODIF_SCAPSAV]
bPrestaScapSavExistanteRefusee = idwCmdeSin.Find ( "ID_FOUR = 'O2M' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT = 'RFO' AND INFO_SPB_FRN = 985 AND STATUS_GC IN ( 304, 156, 157, 158, 160, 174)", 1, idwCmdeSin.RowCount ()) > 0	

// [PM280-1][MANTIS15456]
bARepGti = lnv_string.of_Getkeyvalue( isInfoSpbFrnCplt, "A_REP_GARANTIE", ";" ) = "OUI"


If bPrestaExistante Then
	stMessage.Bouton		= YESNO!
	stMessage.Icon			= Question!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "COMD513"
	bMaterielChezO2M = f_Message ( stMessage ) = 1
End If

// Si l'appareil est sinistrée, les deux question qui suivent ont un sens.
If bAppSin Then  
	isInfoSpbFrncplt += "[SIN_APP]"

	// #7 [DCMP090421]
	If alDefaut = 0 And Not bMaterielChezO2M And alnv_key [14].iaKeyValue = "OUI" Then
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD560" 

		stMessage.sVar[1]		= "VIP"
		If bFNACEpt Then
			stMessage.sVar[1]		= "ONE"
		End If

		stMessage.sVar[2]	= sNomContractant // #3 [DCMP090172]			
			
		bCltVIP = f_Message ( stMessage ) = 1
	End If
	// #7 [DCMP090421]
	//* #2 [FNAC_PROD_ECH_TECH].[20090223142259343] inversion des deux questions

	// La catégorie autorise-t-elle un dépôt chez FNAC, si oui, on pose la question uniquement pour CTG A et B
	// [DCMP090421] ajout bCltVIP
	If alDefaut = 0 And Not bMaterielChezO2M And bCltVIP And alnv_key [8].iaKeyValue = "OUI" Then
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD541" // #3 [DCMP090172] #5 [DCMP090378]
		stMessage.sVar[1]		= "son appareil"		
		stMessage.sVar[2] 	= sNomContractant // #3 [DCMP090172]
		stMessage.sVar[3]    = ""

	// #7 [DCMP090421]
   /*
		// #5 [DCMP090378] Armement contextuel de la troisième variable en fonction du contractant
		If bFNACEpt Then
			stMessage.sVar[3] = "(question à poser aux clients One uniquement, si pas client One : réponse = non)"
		End If
		// :#5 [DCMP090378]
   */
	// :#7 [DCMP090421]

		bDepotFNAC = f_Message ( stMessage ) = 1
		If bDepotFNAC Then alDefaut = Long ( alnv_Key[9].iaKeyValue ) // Process Fnac
	End If

	// [DT156]
	// lnv_Key[42].iskeyname = "SCAPSAV"
	If alDefaut = 0 And Not bMaterielChezO2M And Not bDepotFNAC And alnv_key [42].iaKeyValue = "OUI" And Not bPrestaScapSavExistanteRefusee Then
		alDefaut = Long ( alnv_Key[43].iaKeyValue ) // lnv_Key[43].iskeyname = "PROCESS_SCAPSAV"	
	End If

	// [PC363_AUCHAN] Assuré Frontalier
	// [PC292][AUCHAN] And alnv_key [5].iaKeyValue <> "E"
	If alDefaut = 0 And Not bMaterielChezO2M And Not bDepotFNAC And alnv_key [22].iaKeyValue = "OUI" And alnv_key [5].iaKeyValue <> "E" Then
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD638" 
		
		If sResidant <> "" Then
			stMessage.sCode		= "COMD659" 
			stMessage.sVar [1]   = 	sResidant
		End if
		
		bCltFrontalier = f_Message ( stMessage ) = 1

		// Oui frontalier Suisse, (Italien, Espagnol)
		If bCltFrontalier Then
			bCltFrontResidant1 = TRUE
			stMessage.Bouton		= YESNO!
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			
			stMessage.sCode		= "COMD661" 
			stMessage.sVar[1] 	= sNomContractant
			stMessage.sVar[2] 	= sNomContractant

			If f_Message ( stMessage ) = 1 Then
				alDefaut = Long ( alnv_Key[23].iaKeyValue ) // Process frontalier
			End If
		End If
		
		// Si pas de process, alors résidant2 ?
		// [AUCH_SITCOL_NVFRONT]
		If Not bCltFrontResidant1 And sResidant2 <> "" Then
			stMessage.Bouton		= YESNO!
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "COMD659" 
			stMessage.sVar [1]   = 	sResidant2
			
			bCltFrontalier = f_Message ( stMessage ) = 1
		End If			
		// [AUCH_SITCOL_NVFRONT]	
	
	End If
	// [PC363_AUCHAN]

	// S'il ne l'a pas déposé en boutique FNAC, on lui demande s'il a l'emballage 
	// d'origine en fonction de la Catégorie de son appareil	
	// #7 [DCMP090421]	ajout gestion bEnvoiOuTeleChg
	// [PC929_CDISCOUNT]
	If alDefaut = 0 And Not bMaterielChezO2M And Not bDepotFNAC And ( alnv_key [6].iaKeyValue = "OUI" Or alnv_key [40].iaKeyValue = "OUI" ) Then

		// [AUCH_SITCOL_NVFRONT]
		// Modif Auchan
		// Si non frontalier et process tjrs à 0 et pour Auchan alors on ne fait rien, on passe cette question.
		If Not ( Not bCltFrontalier And alDefaut = 0 And bAuchan ) Then
			stMessage.Bouton		= YESNO!
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "COMD565" // #7 [DCMP090421]
			
			// [PC929_CDISCOUNT]
			If alnv_key [40].iaKeyValue = "OUI" Then
				stMessage.sCode		= "COMD778"
			End If
			
			bEmbOrig = f_Message ( stMessage ) = 1
			If bEmbOrig And alnv_key [17].iaKeyValue <> "OUI" Then alDefaut = Long ( alnv_Key[7].iaKeyValue ) // Process Emb Orig
		End If
		// [AUCH_SITCOL_NVFRONT]				
	End If
	
	// #7 [DCMP090421]
	If alDefaut = 0 And Not bMaterielChezO2M And Not bDepotFNAC And bEmbOrig and alnv_key [17].iaKeyValue = "OUI" Then

		// [AUCH_SITCOL_NVFRONT]
		// Modif Auchan
		// Si non frontalier et process tjrs à 0 et pour Auchan alors on ne fait rien, on passe cette question.
		If Not ( Not bCltFrontalier And alDefaut = 0 And bAuchan ) Then
			stMessage.Bouton		= YESNO!
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "COMD566" // Ass ok pour utiliser cet emballage (orig ou autre)?
			bEmbOrigOk = f_Message ( stMessage ) = 1
			If bEmbOrigOk And alnv_key [15].iaKeyValue  <> "OUI" Then alDefaut = Long ( alnv_Key[7].iaKeyValue ) // Process Emb Orig		
		End If
		// [AUCH_SITCOL_NVFRONT]
	End If
	// :#7 [DCMP090421]

	// #7 [DCMP090421]
	// Si ....
	// (Les questions concernant l'emb ne sont pas posées )
	// Ou 
	// (Les questions concernant l'emb sont pas posée et répondu à OUI)

	// #8 [DCMP090421].[20091116110244950]
//	If Not bMaterielChezO2M And Not bDepotFNAC And Not bCltVIP And alnv_key [15].iaKeyValue = "OUI" And &
	If alDefaut = 0 And Not bMaterielChezO2M And Not bDepotFNAC And alnv_key [15].iaKeyValue = "OUI" And &
		( &
		  ( alnv_key [6].iaKeyValue <> "OUI" And alnv_key [17].iaKeyValue <> "OUI") &
		  Or &
		  ( bEmbOrig And bEmbOrigOk ) &
		  Or &
		  bAuchan &
		) &
	Then
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		
		// Test sur la CTG
		Choose Case alnv_key [5].iaKeyValue
			Case "A", "B"
				stMessage.sVar [1] = "(qu'il devra trouver le cas échéant)"
			Case Else
				stMessage.sVar [1] = ""
		End Choose				

		stMessage.sCode		= "COMD561"

		//* #4 [RUEDUCOMMERCE]
		If bRDCommerce Then
			stMessage.sCode = "COMD562"
		End If
		//* :#4 [RUEDUCOMMERCE]

		// [AUCH_SITCOL_NVFRONT]
		// Modif Auchan
		// [PC801_LOT1_V2]
		If Not bCltFrontalier And bAuchan And sVarianteAuchan <> "PC801" Then
			stMessage.sCode = "COMD674"
		End If
		// [AUCH_SITCOL_NVFRONT]		

		bEnvoiOuTeleChg = f_Message ( stMessage ) = 2			

		If bEnvoiOuTeleChg Then 
			alDefaut = Long ( alnv_Key[16].iaKeyValue ) 
		ElseIf alnv_key [6].iaKeyValue = "OUI" And alnv_key [17].iaKeyValue <> "OUI" And bEmbOrig Then 
			alDefaut = Long ( alnv_Key[7].iaKeyValue )
		ElseIf bEmbOrigOk Then 
			alDefaut = Long ( alnv_Key[7].iaKeyValue )
		End If
		
	End If	
	// :#7 [DCMP090421]

	// [VDOC18660]
	If alnv_key [15].iaKeyValue = "AUTO" Then
		
		lRow4=idwLstInter.Find("COD_INTER='A'",1,idwLstInter.RowCount( ))
		
		if lRow4 > 0 Then
			sAdrMail=idwLstInter.GetItemString(lRow4, "ADR_MAIL")
			if isNull(sAdrMail) Then sAdrMail=""
			if trim(sAdrMail) <> "" Then bEnvoiOuTeleChg=TRUE
		End if
		
		If bEnvoiOuTeleChg Then 
			alDefaut = Long ( alnv_Key[16].iaKeyValue ) 
		ElseIf alnv_key [6].iaKeyValue = "OUI" And alnv_key [17].iaKeyValue <> "OUI" And bEmbOrig Then 
			alDefaut = Long ( alnv_Key[7].iaKeyValue )
		ElseIf bEmbOrigOk Then 
			alDefaut = Long ( alnv_Key[7].iaKeyValue )
		End If
	End If
	// :[VDOC18660]
	

	//* :#2 [FNAC_PROD_ECH_TECH].[20090223142259343] inversion des deux questions

	// Si pas de dépot FNAC ni d'emballge, on lui propose le dernier process.
	// O2M envoi un carton vide, l'assuré choisit entre deux cas pour le retour : soit pas ses soins, soit par transporteur
	// #7 [DCMP090421]	ajout gestion bEnvoiOuTeleChg
	If alDefaut = 0 And Not bMaterielChezO2M And Not bDepotFNAC And Not bEnvoiOuTeleChg And &
		( Not bEmbOrig Or ( bEmbOrig And Not bEmbOrigOk ) ) And alnv_key [12].iaKeyValue = "OUI" Then
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sVar[1] = ""

		If alnv_key [11].iaKeyValue <> "" Then
			stMessage.sVar[1] = "L'assuré sera remboursé d'un montant de : " + alnv_key [11].iaKeyValue + lnv_string.of_GlobalReplace( stGlb.smonnaiesymboledesire, "\", "" ) // [SUISSE].LOT3 : Gestion msg Err avec monnaie
		End If		

		// [PM280-1][MANTIS15456]		
		If bARepGti Then
			stMessage.sVar[1] = ""
		End If
		
		
		stMessage.sCode		= "COMD506"

		//* #4 [RUEDUCOMMERCE]
		If bRDCommerce Then
			stMessage.sCode = "COMD525"
		End If
		//* :#4 [RUEDUCOMMERCE]

		// [PC419/440/418/439_MICROMANIA]
		If bMicromania Then
			stMessage.sCode = "COMD637"		
			bRtrParTrp = f_Message ( stMessage ) = 2

		// [AUCH_SITCOL_NVFRONT]
		// Modif Auchan
		ElseIf Not bCltFrontalier And bAuchan Then
			stMessage.Bouton		= Ok!
			stMessage.Icon			= Information!
			stMessage.sCode = "COMD675"		
			f_Message ( stMessage ) 
			bRtrParTrp = TRUE
		Else			
			bRtrParTrp = f_Message ( stMessage ) = 1
		End IF
		// [PC419/440/418/439_MICROMANIA]		
		
		If bRtrParTrp Then alDefaut = Long ( alnv_Key[13].iaKeyValue ) // Process Retour par Transporteur
	End If

//  [PC202].[DOM_COM] Process DOM
	If alDefaut = 0 And alnv_key [27].iaKeyValue = "OUI" Then
		// [VDOC16821]
		
		sVal=idwCmde.GetItemString(1,"ADR_CP")
		if Len(trim(sVal)) = 5 Then 
			sVal=Left(sVal,3)
		Else 
			sVal=""
		End if
		
		Choose Case sVal 
			Case "971","972","973","974","975","976","984","986","987","988"
			//(971) Guadeloupe 
			// (972) Martinique 
			// (973) Guyane 
			// (974) La Réunion 
			// (975) Saint-Pierre-et-Miquelon 
			// (976) Mayotte 
			// (984) Terres Australes et Antarctiques 
			// (986) Wallis et Futuna 
			// (987) Polynésie Française 
			// (988) Nouvelle-Calédonie 
				// ON contredit le process alors 
				Choose Case sCTG
					Case "A", "B" // dit "léger et non encombrant"
							// ON laisse le process défini par défaut.			
							
					Case "C", "D", "E" // dit "lourd et encombrant"
						stMessage.sCode		= "COMD650"
						stMessage.Bouton		= OK!
						stMessage.Icon			= Information!
						stMessage.bErreurG	= FALSE
					
						stMessage.sVar[1] = sCTG // "Appareil de catégorie : "

						F_Message ( stMessage )
						ibDecocherPresta = TRUE		
						alDefaut = 998 // Process bidont qui n'ira même pas en base, juste pour le traiter du uf_messageO2M 
				End Choose
			
			Case Else 
				// ON laisse le process défini par défaut.			
			
			End Choose
		// :[VDoc16821]
	End If
//  :[PC202].[DOM_COM]
	// Si pas de dépôt FNAC ni EMBallage d'ORIGine alors process par défaut pour la catégorie paramètré

	// [PC786-2_V3]
	If alDefaut = 0 And alnv_key [44].iaKeyValue = "OUI" Then
		lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'CARTON_ADAPT_APP'", 1, idwWDivSin.RowCount () )
		If lRow > 0 Then 
			If Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" Then
				alDefaut = Long ( alnv_Key[45].iaKeyValue )
			End If
		End If
	End If

	// [DT191-1]
	// Je ne regarde pas le process exprès, car cette question ne joue pas sur le process.
	If alnv_Key[46].iaKeyValue = "OUI" Then
		
		lRow = 0
		If isChoixAction = "C" Then
			lRow = idwCmdeSin.Find ( "ID_REF_FOUR IN ( 'A_DIAGNOSTIQUER', 'A_REPARER' ) AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount () )
			If lRow > 0 Then
				lRow4 = idwCmdeSin.Find ( "ID_REF_FOUR IN ( 'A_DIAGNOSTIQUER', 'A_REPARER' ) AND COD_ETAT <> 'ANN' AND POS ( INFO_SPB_FRN_CPLT, 'RET_REL_PICK_UP=OUI' ) > 0", 1, idwCmdeSin.RowCount () )					

				If lRow4 > 0 Then
			
					sVal = lnv_String.of_getkeyvalue (idwCmdeSin.GetItemString ( lRow, "INFO_SPB_FRN_CPLT" ), "RET_REL_PICK_UP", ";")
					lnv_String.of_Setkeyvalue ( isInfoSpbFrnCplt, "RET_REL_PICK_UP", sVal, ";")
		
					sVal = lnv_String.of_getkeyvalue (idwCmdeSin.GetItemString ( lRow, "INFO_SPB_FRN_CPLT" ), "CODE_PICK_UP", ";")
					lnv_String.of_Setkeyvalue ( isInfoSpbFrnCplt, "CODE_PICK_UP", sVal, ";")
					
					sVal = lnv_String.of_getkeyvalue (idwCmdeSin.GetItemString ( lRow, "INFO_SPB_FRN_CPLT" ), "MAIL_ASSURE", ";")
					lnv_String.of_Setkeyvalue ( isInfoSpbFrnCplt, "MAIL_ASSURE", sVal, ";")
			
					If alnv_Key[47].iaKeyValue <> "" Then
						alDefaut = Long ( alnv_Key[47].iaKeyValue )
					End If
	
					// [DT191-1][MANTIS20039]
					isAdrCivPickUp	  = idwCmdeSin.GetItemString ( lRow4, "ADR_COD_CIV" )
					isAdrNomPickUp   = idwCmdeSin.GetItemString ( lRow4, "ADR_NOM" )
					isAdrPreNomPickUp = idwCmdeSin.GetItemString ( lRow4, "ADR_PRENOM" )
					isAdr1PickUp     = idwCmdeSin.GetItemString ( lRow4, "ADR_LIVR1" )
					isAdr2PickUp     = idwCmdeSin.GetItemString ( lRow4, "ADR_LIVR2" )
					isAdrCpltPickUp  = idwCmdeSin.GetItemString ( lRow4, "ADR_LIVR_CPL" )
					isAdrCpPickUp    = idwCmdeSin.GetItemString ( lRow4, "ADR_CP" )
					isAdrVillePickUp = idwCmdeSin.GetItemString ( lRow4, "ADR_VILLE" )
	
					idwCmde.SetItem ( 1, "ADR_COD_CIV"		, isAdrCivPickUp)
					idwCmde.SetItem ( 1, "ADR_NOM"			, isAdrNomPickUp)
					idwCmde.SetItem ( 1, "ADR_PRENOM"		, isAdrPreNomPickUp)
					idwCmde.SetItem ( 1, "ADR_LIVR1"			, isAdr1PickUp)
					idwCmde.SetItem ( 1, "ADR_LIVR2"			, isAdr2PickUp)
					idwCmde.SetItem ( 1, "ADR_LIVR_CPL"		, isAdrCpltPickUp)
					idwCmde.SetItem ( 1, "ADR_CP"				, isAdrCpPickUp)
					idwCmde.SetItem ( 1, "ADR_VILLE"			, isAdrVillePickUp)
					
					gsAdrCivPickUp = isAdrCivPickUp
					gsAdrNomPickUp = isAdrNomPickUp
					gsAdrPreNomPickUp = isAdrPreNomPickUp 
					gsAdr1PickUp = isAdr1PickUp 
					gsAdr2PickUp = isAdr2PickUp  
					gsAdrCpltPickUp = isAdrCpltPickUp 
					gsAdrVillePickUp = isAdrVillePickUp 
					gsAdrCpPickUp = isAdrCpPickUp 
					gsCodePickUp = isCodePickUp 
				End If					
				
			End If 					
		End If
		
		If lRow = 0 Then 
			stMessage.Bouton		= YESNO!
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "COMD936" 
			bRetRelPickUp = f_Message ( stMessage ) = 1
			
			If bRetRelPickUp  Then
				sRet = This.uf_Gestion_RelaiPickUp ()
				If sRet = "[RETOUR]" Then
					bRetRelPickUp  = False
				Else 
					lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "RET_REL_PICK_UP", "OUI", ";")
					
					// Cas pour le Vol, action A_COMMANDER
					If isChoixAction = "C" And alnv_Key[47].iaKeyValue <> "" Then
						alDefaut = Long ( alnv_Key[47].iaKeyValue )
					End If
				End If 
			End If
		End If
	End If

// [DT288]
	If alDefaut = 0 And alnv_key [48].iaKeyValue = "OUI" Then
		stMessage.sTitre		= "Relais Pick Up ?"
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= YESNO!
		stMessage.sCode		= "COMD854"

		bRelaiPickUp = f_Message ( stMessage ) = 1 

		If bRelaiPickUp  Then
			sRet = This.uf_Gestion_RelaiPickUp ()
			If sRet = "[RETOUR]" Then
				bRelaiPickUp  = False
			Else 
				alDefaut = Long ( alnv_Key[47].iaKeyValue )
			End If 
		End If
	End If

// [PC545].[POINT].[229]
// [DT288]
	If alDefaut = 0 And Not ibDecocherPresta Then
		alDefaut = Long ( alnv_Key[4].iaKeyValue ) // Process 
		
		// [DT87]
		If len ( String ( alnv_Key[41].iaKeyValue ) ) > 0 Then
			lRow4= idwLstInter.Find ( "COD_INTER = 'A'", 1, idwLstInter.RowCount () )
			If lRow4> 0 Then
				sAdrMail= idwLstInter.GetItemString ( lRow4, "ADR_MAIL" )
				If IsNull ( sAdrMail ) Or Trim ( sAdrMail ) = "" Then
					alDefaut = Long ( alnv_Key[41].iaKeyValue )
				End If
			End If			
		End If
	End If
// :[PC545].[POINT].[229]
	
End If

// Si l'appareil n'est pas sinistrée
If Not bAppSin Then  

	//* #2 [FNAC_PROD_ECH_TECH].[20090223142259343] 
	// dépôt chez FNAC ? 
	If alDefaut = 0 And Not bMaterielChezO2M Then 

		// #7 [DCMP090421]
		If alnv_key [14].iaKeyValue = "OUI" Then
			stMessage.Bouton		= YESNO!
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "COMD560" 
	
			stMessage.sVar[1]		= "VIP"
			If bFNACEpt Then
				stMessage.sVar[1]		= "ONE"
			End If
	
			stMessage.sVar[2]	= sNomContractant // #3 [DCMP090172]			
				
			bCltVIP = f_Message ( stMessage ) = 1
		End If
		// #7 [DCMP090421]
		
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD541" // #3 [DCMP090172] #5 [DCMP090378]

		// [VDOC4970]
		stMessage.sVar[1] = ""
		
		If bBattSin Then 
			stMessage.sVar[1] += "sa batterie amovible"			
		End If

		If bAlimSin Then 
			If stMessage.sVar[1] <> "" Then stMessage.sVar[1] += ", "
			stMessage.sVar[1] = "son câble d'alimentation"			
		End If

		If bAccSin Then 
			If stMessage.sVar[1] <> "" Then stMessage.sVar[1] += ", "
			stMessage.sVar[1] = "son accessoire"			
		End If
		// [VDOC4970]
		
		stMessage.sVar[2] 	= sNomContractant // #3 [DCMP090172]

		stMessage.sVar[3]    = ""

		// #7 [DCMP090421]
		// #5 [DCMP090378] Armement contextuel de la troisième variable en fonction du contractant
		/*
		If bFNACEpt Then
			stMessage.sVar[3] = "(question à poser aux clients One uniquement, si pas client One : réponse = non)"
		End If
		*/
		// :#5 [DCMP090378]
		// :#7 [DCMP090421]

		// #7 [DCMP090421]
		If bCltVIP Then
			bDepotFNAC = f_Message ( stMessage ) = 1
		End If
		// :#7 [DCMP090421]
		
		If bDepotFNAC Then 

			If bBattSin Then 
				isInfoSpbFrncplt += "[SIN_BATT]"
				alDefaut = 906 // Process Fnac				
			End If
			If bAlimSin Then 
				isInfoSpbFrncplt += "[SIN_ALIM]"
				alDefaut = 906 // Process Fnac				
			End If
			
			// [VDOC4970]
			If bAccSin Then 
				isInfoSpbFrncplt += "[SIN_AUT_ACC]"
				alDefaut = 906 // Process Fnac				
			End If
			
		End If
	End If
	//* :#2 [FNAC_PROD_ECH_TECH].[20090223142259343] 

	// #7 [DCMP090421]
	If alDefaut = 0 And Not bMaterielChezO2M And Not bDepotFNAC And alnv_key [15].iaKeyValue = "OUI" Then
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE

		// Test sur la CTG
		Choose Case alnv_key [5].iaKeyValue
			Case "A", "B"
				stMessage.sVar [1] = "(qu'il devra trouver le cas échéant)"
			Case Else
				stMessage.sVar [1] = ""
		End Choose	
		
		stMessage.sCode		= "COMD561"

		//* #4 [RUEDUCOMMERCE]
		If bRDCommerce Then
			stMessage.sCode = "COMD562"
		End If
		//* :#4 [RUEDUCOMMERCE]
		
		bEnvoiOuTeleChg = f_Message ( stMessage ) = 2
		If bEnvoiOuTeleChg Then 
			If bBattSin Then 
				isInfoSpbFrncplt += "[SIN_BATT]"
				alDefaut = 912 // Process Fnac				
			End If
			If bAlimSin Then 
				isInfoSpbFrncplt += "[SIN_ALIM]"
				alDefaut = 912 // Process Fnac				
			End If

			// [VDOC4970]
			If bAccSin Then 
				isInfoSpbFrncplt += "[SIN_AUT_ACC]"
				alDefaut = 912 // Process Fnac				
			End If

		End If
	End If	
	// :#7 [DCMP090421]

	// [PC363_AUCHAN] Assuré Frontalier
	If alDefaut = 0 And alnv_key [22].iaKeyValue = "OUI" Then
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD638" 
		bCltFrontalier = f_Message ( stMessage ) = 1
		If bCltFrontalier Then
			alDefaut = Long ( alnv_Key[23].iaKeyValue ) // Process frontalie
		End If
	End If
	// [PC363_AUCHAN]
	
	// Si Batterie sinistrée on bascule sur 910, idem à une CTG B
	// #7 [DCMP090421]
	If alDefaut = 0 And Not bCltFrontalier And Not bDepotFNAC And Not bEnvoiOuTeleChg And bBattSin Then
		If Not bMaterielChezO2M Then 
			alDefaut = 910
		End IF
		isInfoSpbFrncplt += "[SIN_BATT]"
	End If

	// Si alim sinistrée on bascule sur 910, idem à une CTG B
	// IL est possible que les deux soient sinistrée, on reste tout même sur du B soit 910 colissimo M
	// #7 [DCMP090421]
	If alDefaut = 0 And Not bCltFrontalier And Not bDepotFNAC And Not bEnvoiOuTeleChg And bAlimSin Then
		If Not bMaterielChezO2M Then 
			alDefaut = 910
		End If
		isInfoSpbFrncplt += "[SIN_ALIM]"
	End If

	// [VDOC4970]
	If alDefaut = 0 And Not bCltFrontalier And Not bDepotFNAC And Not bEnvoiOuTeleChg And bAccSin Then
		If Not bMaterielChezO2M Then 
			alDefaut = 910
		End If
		isInfoSpbFrncplt += "[SIN_AUT_ACC]"
	End If	
	
End If


// En fonction du process, y a-t-il un RDV à prendre ?
// [PC13321]
Choose Case alDefaut
	Case 925, 930, 955, 957

		If Not bMaterielChezO2M Then 
			abRdvAPrendre = TRUE
		End If

		// [PC13321]
		If bElectroDepot Then
			abRdvAPrendre = False
		End If
		
	Case Else
		// Pour les autres cas, il s'agit d'envoi pas l'assuré ou passage O2M/TRP chez FNAC
End Choose

// [VDoc21247]
If String(alnv_key[10].iaKeyValue) ="O2M" Then abRdvAPrendre = FALSE

//* #1 [FNAC_PROD_ECH_TECH].[20090213145759303]
If bMaterielChezO2M Then 
	alDefaut = 902
End If

//* #6 [DCMP090327].[SBETV]
If isDept <> "" Then
	If isInfoSpbFrncplt <> "" Then
		isInfoSpbFrncplt += ";"
	End If
	isInfoSpbFrncplt += "DEPT_ENLEV=" + isDept
End If

//* #9 [DCMP090421].[20091118105631390]
// [DT87] ajout 967
Choose Case alDefaut
	Case 907, 912, 937, 942, 967
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 106 )

		If lDeb > 0 Then

			lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, idwWDivsin.RowCount () ) 
			If lRow >0 Then 
				sVal = Upper ( idwWDivsin.GetItemString ( lRow, "VAL_LST_CAR" ) )
			
				lRow = idw_DetPro.Find ( "ID_TYP_CALC = '-AR' AND ID_CODE_CAR = '" + sVal + "'", lDeb, lFin )
				If lRow > 0 Then
					sVal = Trim ( idw_DetPro.GetItemString ( lRow, "VAL_CAR"))
					If IsNull ( sVal ) Then sVal = ""

					If isInfoSpbFrncplt <> "" Then
						isInfoSpbFrncplt += ";"
					End If
					isInfoSpbFrncplt += "LIB_ART_CLT=" + sVal
					
				End If
				
			End If
		End If		
		
End Choose
//* :#9 [DCMP090421].[20091118105631390]

end subroutine

private function string uf_controlergestion_psm (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_PSM 	(PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 15/02/2012
//* Libellé			: Controle Spécifique pour PSM
//* Commentaires	: // [PM200][PSM]
//*					  liste -IF
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	JCA	26/12/2006	DCMP 060907 - Changement de l'appel à F_Determiner_Montant_Frais_Envoi
//*									ajout des arguments alidprod (Val), adwdetpro (Ref), adcFrais (Ref)
//		 	FPI	24/06/2010 [DCMP100551] Modification de l'option 76
//       JFF   17/04/2012  [PM200][LOT2][DESOX]
//       JFF   26/11/2012  [PC877]
//       JFF   17/12/2012  [PM200_LOT3_V3]
//       JFF   25/03/2013  [PC801_LOT1_V2]
//       JFF   07/05/2013 [PC938_ORANGE_V3]
//       JFF   20/06/2013 [PC801_LOT1_V2]
//       JFF   09/09/2013 [PM222-1]
//       JFF   08/04/2014 [PM255]
//       JFF   14/05/2014 [PC13274-2]
//       JFF   02/02/2015 [DT122]
//	      JFF   19/02/2015 [VDOC15533]
//		   FPI	24/02/2015 [CORR_PROC_SANS_PSM]
// 		JFF	03/04/2015 [DT122][MANTIS15016]
//       JFF   15/12/2015 [DT191]
//       JFF   29/08/2016 [DT200-1]
//       JFF   05/10/2017 [PC171918]
//       JFF   25/03/2019 [DT398]
//*-----------------------------------------------------------------

String sPos, sProbleme, sCodModeRegn, sVar1, sVar2, sVar3, sFiltreOrigArticle, sSortOrig, sVal
Long lInfoSpbFrn, lIdSin, lCpt
Dec {2} dcFrais //#1
Boolean bRibVide
Long lIdBoutique, lNull, lRow, lFind
String sLibBoutique=""
string  snomligne1, snomligne2, sadrligne1, sadrligne2, scp, sville
n_cst_string lnvPFCString
String sVar[]
String sCodMsg, sAction 
long	lDeb, lFin, lCaisse
Long lIdGti, lIdEvt
n_cst_attrib_key	lnv_key[], lnv2_key[]
n_cst_cmd_commun	lnvCmdCommun
String sMtFrais 
String sNouvelleLigne, sText
Boolean bSouplessePacifica // [DT122]
String sSkuIfr, sIdRefFour 
Int iPos

sPos = ""

lIdEvt = idwDetail.GetItemNumber ( 1, "ID_EVT" ) // [PM200][LOT2][DESOX]
lIdGti = idwDetail.GetItemNumber ( 1, "ID_GTI" ) 

// [DT122]
bSouplessePacifica = FALSE
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 269 )
bSouplessePacifica = lDeb > 0 

lInfoSpbFrn = idwArticle.GetItemNumber ( alCpt, "INFO_SPB_FRN" ) 
sIdRefFour = idwArticle.GetItemString ( alCpt, "ID_REF_FOUR" )  // [VDOC15533]

idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "1" )

/*------------------------------------------------------------------*/
/* Message d'information pour le gestionnaire                       */
/*------------------------------------------------------------------*/
sFiltreOrigArticle = idwArticle.Describe ("DataWindow.Table.filter") 
If sFiltreOrigArticle = "?" Then sFiltreOrigArticle = ""

sSortOrig = idwArticle.Describe ("DataWindow.Table.Sort") 
If sSortOrig = "?" Then sSortOrig = ""

idwArticle.SetFilter ( "CHOIX = 'O' AND ID_FOUR = 'PSM' AND ID_TYP_ART = 'REL'" )
idwArticle.filter ()

If idwArticle.RowCount () > 0 Then
	stMessage.sTitre		= "Presta Relai"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "COMD784"
	F_Message ( stMessage )

	Return "G" + sPos
End If

// [DT168] 
If lIdGti = 24 and lIdEvt <> 1377 Then
	stMessage.sCode = "COMD922"
	stMessage.Icon	 = Exclamation!
	F_Message ( stMessage )
	Return "G" + sPos
End If

idwArticle.SetFilter ( sFiltreOrigArticle )
idwArticle.filter ()
idwArticle.SetSort ( sSortOrig )
idwArticle.Sort ()
idwArticle.SetRedraw ( True)


snomligne1=Space(35)
snomligne2=Space(35)
sadrligne1=Space(35)
sadrligne2=Space(35)
scp=Space(35)
sville=Space(35)
lIdSin  = idwDetail.GetItemNumber ( 1, "ID_SIN" )

lIdBoutique= Long ( lnvPFCString.of_getkeyvalue (isInfoSpbFrnCplt, "CODE_BTQ_PSM_CENTRALE", ";") )
SQLCA.PS_S_adresse_centrale_psm( lIdSin, String(lIdBoutique), 'SEL_BOUTIQUE', snomligne1, snomligne2, sadrligne1, sadrligne2, scp, sville)

If (not isnull(sNomLigne1)) and  len(trim(sNomLigne1)) > 0 Then sVar1 = sNomLigne1 
If (not isnull(sNomLigne2)) and  len(trim(sNomLigne2)) > 0 Then sVar1+= " " + sNomLigne2 

If idwCmdeSin.find ( "( POS ( INFO_SPB_FRN_CPLT, 'A_REPARER_SAV=OUI') > 0 OR POS ( INFO_SPB_FRN_CPLT, 'A_DESOXYDER_SAV=OUI') > 0 ) AND COD_ETAT IN ( 'RPC', 'RFO') AND STATUS_GC IN ( 2,21,22,23 )", 1, idwCmdeSin.rowcount() ) > 0 Then
	sVar1 += " - Contrôle SAV"
End If

If (not isnull(sAdrLigne1)) and  len(trim(sAdrLigne1)) > 0 Then sVar2 =sAdrLigne1
If (not isnull(sAdrLigne2)) and  len(trim(sAdrLigne2)) > 0 Then sVar2+= " " + sAdrLigne2

If (not isnull(sCp)) and  len(trim(sCp)) > 0 Then sVar3 =sCp 
If (not isnull(sVille)) and  len(trim(sVille)) > 0 Then sVar3 += " " + sVille

sVar [1] = F_Determiner_Montant_Frais_Envoi ( String ( lInfoSpbFrn ), idwWsin.object.id_prod[1], isTypApp, idw_DetPro, dcFrais ) // [DCMP100551]
sVar [2] = sVar1
sVar [3] =	sVar2
sVar [4] =	sVar3
sVar [5] = String ( idwCmde.GetItemNumber ( 1, "ID_SIN" ) ) + "-" + String (  This.uf_Nouveau_Num_Sequence () ) 


Choose Case lInfoSpbFrn 

	Case 2110 
		
		IF isCodeBoutiqueProximitePSM = "" Then	

			// [DT398]
			sCodMsg = "COMD988"
			
			// [DT122]
			If bSouplessePacifica Then
				sCodMsg = "COMD989"
			End If
		
		Else
			// [PM200_LOT3_V3]
			sVar [1] = sMtFrais
			sVar [2] = String ( idwCmde.GetItemNumber ( 1, "ID_SIN" ) ) + "-" + String (  This.uf_Nouveau_Num_Sequence () ) 

			// [DT398]
			sCodMsg = "COMD986"				
	
			// [DT122][MANTIS15016]
			If bSouplessePacifica Then
				sCodMsg = "COMD987"
			End If
			
		End If	


	// [PC801_LOT1_V2]
	Case 	2116
	

		// PC801_LOT1_V5, Vu avec S. Vabre le 17/10, pas de boutique de centralisation pour le 2116.
		sCodMsg = "COMD834"		
		sVar [1] = String ( idwCmde.GetItemNumber ( 1, "ID_SIN" ) ) + "-" + String (  This.uf_Nouveau_Num_Sequence () ) 			

		// [PC947&977] Vu avec s.vabre le 16/12, on réactive la variable pour le process 2116
		// lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_BTQ_PSM_CENTRALE", "", ";")

	Case 2130 // [MANTIS7596]
		
		sCodMsg = "COMD760"					
		sVar [1] = String ( idwCmde.GetItemNumber ( 1, "ID_SIN" ) ) + "-" + String (  This.uf_Nouveau_Num_Sequence () ) 							

		// [PC938_ORANGE_V3]
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 239 ) 
		If lDeb > 0 Then
			sCodMsg = "COMD806"
		End If


	Case 2137
		
		sCodMsg = "COMD796"

	Case 2138
		
		sCodMsg = "COMD797"
		
	Case 2139

		sCodMsg = "COMD798"

	Case 2140				
		
		sCodMsg = "COMD799"	

	// [PM255]				
	Case 2141

		sCodMsg = "COMD856"

	// [PM255]				
	Case 2142
		
		sCodMsg = "COMD857"				
		
	// [DT191]				
	Case 2143
		
		sCodMsg = "COMD934"			

// [PC801_LOT1_V2]
	Case 0 
		sPos = "INFO_SPB_FRN"
		sText += "~n~r"
		sText = sText + "- Le Process" + sNouvelleLigne
		sText += "~n~r"
		stMessage.sTitre		= "Controle de saisie - Information(s)"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= TRUE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "GENE001"
		stMessage.sVar[1]		= sText
		F_Message (stMessage)

		Return sPos
	
		
End Choose	

// [PM200][LOT2][DESOX]
// [ITSM274801]
lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "MT_PEC", String ( idcMtPec, "##0.00" ), ";")		


If sCodMsg <> "" Then
	stMessage.scode = sCodMsg
	stMessage.sVar = sVar

	F_Message(stMessage)
End If
	

// [PC13274-2]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 260 ) 
If lDeb > 0 Then	
	sVal = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "CAS", ";")
	
	Choose Case sVal 
		Case "RECUP_DONNEES"
			lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "RECUP_DONNEES", "SUR_DEM_ASS", ";")
	End Choose
	
End If

//[DOC14293]
lRow = idwWDivsin.Find ( "NOM_ZONE = 'code_verrou_sherpa_script'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	 sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
	 If IsNull ( sVal ) Then sVal = ""
	 If Len ( sVal ) > 0 Then
		 lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_VERROU_ORIG", sVal, ";")
	 End If
End If	
//[VDOC14293]

// [PM259-1]
lRow = idwWDivsin.Find ( "NOM_ZONE = 'code_parental'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	 sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
	 If IsNull ( sVal ) Then sVal = ""
	 If Len ( sVal ) > 0 Then
		 lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_PARENTAL", sVal, ";")
	 End If
End If	
// [PM259-1]

//	[VDOC15533]
Choose Case sIdRefFour 
	Case "A_REPARER", "A_DESOXYDER"
		sSkuIfr = Space ( 35 )
		SQLCA.PS_S_SKU_IFR ( isMarqPortAdh, isModlPortAdh, sSkuIfr )
		If IsNull ( sSkuIfr ) Then sSkuIfr = ""
		
		lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "SKU_IFR", sSkuIfr, ";")
End Choose

// [DT200-1]
Choose Case sIdRefFour 
	Case "A_REPARER", "A_DESOXYDER"
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 290 )	
		For lCpt = lDeb To lFin
			sVal = idw_DetPro.GetItemString ( lCpt, "VAL_CAR" ) 
			sVal = lnvPFCString.of_getkeyvalue (sVal, "MODL", ";")		
			If Pos ( isModlPortAdh, sVal ) > 0 Then
				lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "NE_PAS_REPARER", "OUI", ";")
				idwArticle.SetItem ( alCpt, "PROBLEME", "SUITE IRREPARABILITE CONSTATEE EN BOUTIQUE AGREEE  NE PAS CHERCHER À REPARER CET APPAREIL  RETOURNER DANS TOUS LES CAS 21 IRREPARABLE  MAIS QUALIFIER L IRREPARABILITE PAR UN MOT CLE DANS LE COMMENTAIRE." )
				stMessage.sCode = "COMD949" 					
				F_Message ( stMessage )
				Exit
			End If
		Next 
End Choose 	
//	[DT200-1]

// [PC151259-1]
// [PC171918]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 252 )
If lDeb > 0 Then
	sVal = lnvPFCString.of_getkeyvalue ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")
	Choose Case sVal
		Case "FULL_SERENITY_ADV_5", "ADVISE_6"
			lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'FRN_REPA_ADH'", 1, idwWDivSin.RowCount () ) 
			If lRow >0 Then 
				sVal = Trim ( Upper ( idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) ))
				If IsNull ( sVal ) Then sVal = ""
				
				iPos = Pos ( sVal, "_" ) 
				
				If iPos > 0 Then
					sVal = Mid ( sVal, iPos + 1, Len ( sVal ) )
				Else 
					sVal = ""
				End If
				
				If IsNull ( sVal ) Then sVal = ""
				
				If Len ( sVal ) > 0 Then
					lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "BTQ_PSM_ADV", sVal, ";")
				End If
				
			End IF
	End Choose 
End If

Return sPos

end function

private function boolean uf_preparervalider_game ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::uf_preparervalider_game
//* Auteur			: F. Pinon
//* Date				: 28/10/2011 09:36:23
//* Libellé			: 
//* Commentaires	: [PR09]
//*
//* Arguments		: 
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	06/02/2012	[PR09.2] Ajout de messages d'erreur
//			FPI	30/05/2012	[PR09.2].Secure Sécurisation des bons GAME en simulation
//			FPI	10/07/2012	[PR09.3] format du n° de police modifié
//			FPI	17/12/2012	[VDOC9835]
//			FPI	25/07/2024 [MIG_PB2022] - SoapConnection Obsolète
//*-----------------------------------------------------------------
String sFind, sPrefixeBon
Long lTot, lRow, lIdGti
n_cst_sp_ws_game_caller uWsCaller
Decimal dcIdSin, dcIdAdh, dcIdEts,dcMtCmde, dcIdSDos, dcIdProd
Date dteAdh
String sNoBon, sIdAdh
Long lRet
Boolean bRet, bConcatNoBon

bRet=TRUE

// Lecture du Code Action
sFind = "ID_FOUR = 'GAM' AND CHOIX = 'O'"
lTot = idwArticle.RowCount ()
lRow = idwArticle.Find ( sFind, 1, lTot )

If lRow <=0 Then Return TRUE

// [PR09.2].Secure

dcIdProd = idwWSin.GetItemDecimal( 1, "ID_PROD")
dcIdSin = idwCmde.GetItemDecimal( 1, "ID_SIN")
sIdAdh = idwWSin.GetItemString( 1, "ID_ADH")
dcIdEts = idwWSin.GetItemDecimal( 1, "ID_ETS")
dcIdSDos = idwWSin.GetItemDecimal( 1, "ID_SDOS")
dcMtCmde = idwCmde.GetItemDecimal ( 1, "MT_TTC_CMDE")
dteAdh = idwWSin.GetItemDate( 1, "DTE_ADH")


// [PR09.3]
/*
-	Si sinistre sur dossier des ETS 01001, 01002 et 02001 tu laisses comme maintenant
-	Si sinistre sur dossier de l’ETS 03001 tu formates le n° police ainsi : 8580860/GDV/n° de dossier
-	Si sinistre sur dossier de l’ETS 04001 tu formates le n° de police ainsi : 8580859/ECN/n° de dossier
*/
// [PR09.3]
// [VDOC9835]
bConcatNoBon=FALSE
Choose Case dcIdEts
	Case 1001
		if dteAdh >= Date("2011-06-01") Then 
			bConcatNoBon=TRUE
			sPrefixeBon="70701053602/ECN/"
		End if
	Case 1002
		if dteAdh >= Date("2011-06-01") Then 
			bConcatNoBon=TRUE
			sPrefixeBon="70701056002/ECN/"
		End if
	Case 1003
		if dteAdh >= Date("2011-06-01") Then 
			bConcatNoBon=TRUE
			sPrefixeBon="70701053302/ECN/"
		End if
	Case 3001
		sPrefixeBon="8580860/GDV/"
	Case 4001
		sPrefixeBon="8580859/ECN/"
	Case Else
		// On laisse
End Choose

if bConcatNoBon Then 
	sidadh= sPrefixeBon + Trim(sIdAdh) 
Else
	sIdAdh = String(dcIdProd) + "-" + String(dcIdEts) + "-" + Trim(sIdAdh) + "-" + String(dcIdSDos)
End if
// :[VDOC9835]
//:[PR09.3]
uWsCaller = Create n_cst_sp_ws_game_caller

// [MIG_PB2022] - SoapConnection Obsolète
/*If not isValid (isoapcnx) Then isoapcnx = CREATE soapconnection

lRet=uWsCaller.createproxy(isoapcnx )*/
lRet=1
// :[MIG_PB2022] 

if lRet=-1 Then	stMessage.sCode="COMD705" // 	[PR09.2]

If lRet > 0 Then lRet= uWsCaller.uf_get_no_bon_game( dcidsin, dcMtCmde, Datetime(dteAdh,Time("00:00:00")), sidadh, snobon)

 // 	[PR09.2]
Choose Case lRet
	Case 1 // OK
		 idwCmde.SetItem(1,"INFO_FRN_SPB_CPLT","NO_BON=" + sNoBon )
	Case -1 // Erreur de comm
		stMessage.sCode="COMD706"
	Case -2 // Erreur format
		stMessage.sCode="COMD707"
	Case -3 // Commande déjà effectuée
		stMessage.sCode="COMD708"
	Case -4 // N° adh inconnu
		stMessage.sCode="COMD709"
	Case Else // Exception Soap
		stMessage.sCode="COMD706"
End Choose
// :[PR09.2]

Destroy uWsCaller

if lRet <> 1 Then
	stMessage.bErreurG=FALSE
	stMessage.Icon=Information!
	stMessage.Bouton=OK!
	stMessage.sTitre="Commande GAME"
	
	f_message(stMessage)
	
	bRet=FALSE
End if

Return bRet
end function

private subroutine uf_gestionzone_infospbfrn_blc_900 (ref n_cst_attrib_key alnv_key[], ref long aldefaut, ref boolean abrdvaprendre);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_Commande3::uf_GestionZone_InfoSpbFrn_BLC_900 (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 24/10/2008 17h12
//* Libellé       : Process particuliers pour FNAC EPT sur liste 900
//* Commentaires  : [FNAC_PROD_ECH_TECH] [AUCH_SITCOL_NVFRONT]
//*
//* Arguments     : n_cst_attrib_key  alnv_key[]		Réf		// Valeur par défaut dans la zone
//*		    		  Long				  alDefaut        Réf	   // Process retenu
//*					  Boolean			  abRdvAPrendre   Réf      // TRUE : Un Rdv est à prendre.
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    13/02/2008  [FNAC_PROD_ECH_TECH].[20090213145759303]
//* #2    JFF    13/02/2008  [FNAC_PROD_ECH_TECH].[20090223142259343]
//* #3    JFF    19/05/2009  [DCMP090172]
//* #4    JFF    05/05/2009  [RUEDUCOMMERCE]
//* #5    JFF    28/07/2009  [DCMP090378]
//* #6    JFF    02/09/2009  [DCMP090327].[SBETV]
//* #7    JFF    07/10/2009  [DCMP090421]
//* #8    JFF    16/11/2009  [DCMP090421].[20091116110244950]
//* #9    JFF    18/11/2009  [DCMP090421].[20091118105631390]
//*       JFF    10/06/2010  [PC419/440/418/439_MICROMANIA]
//*       JFF    30/06/2010  [PC363_AUCHAN]
//*		 JFF    05/01/2011  [PC202].[DOM_COM]
//* 	    JFF    05/01/2011  [PC545].[POINT].[229]
//*       JFF    05/07/2011  [PC292][AUCHAN]
//*       JFF    05/07/2011  [AUCHAN].[AUCH_SITCOL_NVFRONT]
//*       JFF    12/12/2011  [VDOC4970]
//        JFF    06/08/2012  [BLCODE]
//        JFF    30/06/2015  [DT156]
//        JFF    02/03/2107  [MODIF_SCAPSAV]
//*-----------------------------------------------------------------
stMessage.sTitre		= "Process"
Boolean bDepotFNAC, bEmbOrig, bAppSin, bAlimSin, bBattSin, bAccSin, bDepotEnvoiParAss
Boolean bRtrParTrp, bPrestaExistante, bMaterielChezBLCODE, bFNACEpt, bCltVIP, bEnvoiOuTeleChg, bEmbOrigOk, bAuchan
Boolean bDimSup150cm, bPoidsSup30kg, bPrestaScapSavExistanteRefusee 
String  sCTG, sNomContractant, sVal, sResidant, sResidant2
String  sModeBlc
Long 	  lRow, lDeb, lFin, lCaisse
n_cst_string	lnv_string
Boolean bRDCommerce // #4 [RUEDUCOMMERCE]
Boolean bMicromania // [PC419/440/418/439_MICROMANIA]
Boolean bCltFrontalier // [PC363_AUCHAN]
Boolean bCltFrontResidant1 
Boolean bDepotParAssure 
Boolean bBlCodeEnvBBPMailcour, bBlCodeEnvCartonBBP, bAssTlchrgBBPsite, bBLCODEEnvTP 


alDefaut = 0
sResidant=""

// #6 [DCMP090327].[SBETV]
If isInfoSpbFrncplt <> "" Then
		isInfoSpbFrncplt += ";"
End If
isInfoSpbFrncplt += "MAT_SIN="	

abRdvAPrendre = FALSE

bDepotFNAC = FALSE
bEmbOrig= FALSE
bRtrParTrp = False
bAppSin = FALSE
bAlimSin = FALSE
bAccSin = FALSE
bBattSin = FALSE
bCltVIP = FALSE // #7 [DCMP090421]
bEnvoiOuTeleChg = FALSE // #7 [DCMP090421]
bCltFrontResidant1 = FALSE

isPrcBLCODE = ""

// #3 [DCMP090172]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 59 )
If lDeb > 0 Then
	sNomContractant = Trim ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ) )
Else 
	sNomContractant = ""
End If
If IsNull ( sNomContractant ) Then sNomContractant = ""
// :#3 [DCMP090172]

// L'appareil est-il sinistré ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'APP_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bAppSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

// La batterie est-elle sinistrée ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'BATT_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bBattSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

// L'alim est-elle sinistrée ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'ALIM_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bAlimSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

// [VDOC4970]
// L'Autre Accessoire est-elle sinistrée ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'AUT_ACC_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bAccSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'DIMENSION_SUP_150CM'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bDimSup150cm = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'POIDS_SUP_30KG'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bPoidsSup30kg = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

// La catégorie de l'appareil
sCTG = alnv_key [5].iaKeyValue

If IsNull ( sCTG ) Then sCTG = ""
sCTG = Trim ( sCTG ) 

//* #1 [FNAC_PROD_ECH_TECH].[20090213145759303]
bPrestaExistante = idwCmdeSin.Find ( "ID_FOUR = 'BLC' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT = 'RFO'", 1, idwCmdeSin.RowCount ()) > 0 

// [DT156]
// lnv_Key[42].iskeyname = "SCAPSAV"
If alnv_key [42].iaKeyValue = "OUI" Then
	bPrestaExistante = False
End If

// [MODIF_SCAPSAV]
bPrestaScapSavExistanteRefusee = idwCmdeSin.Find ( "ID_FOUR = 'BLC' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT = 'RFO' AND INFO_SPB_FRN = 985 AND STATUS_GC IN ( 304, 156, 157, 158, 160, 174)", 1, idwCmdeSin.RowCount ()) > 0	

If bPrestaExistante Then
	stMessage.Bouton		= YESNO!
	stMessage.Icon			= Question!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "COMD513"
	bMaterielChezBLCODE = f_Message ( stMessage ) = 1
End If

// Si l'appareil est sinistrée, les deux question qui suivent ont un sens.
If bAppSin Then  
	isInfoSpbFrncplt += "[SIN_APP]"

	// La catégorie autorise-t-elle un dépôt chez FNAC, si oui, on pose la question uniquement pour CTG A et B
	// [DCMP090421] ajout bCltVIP

	// Déjà chez 
	If alDefaut = 0 And bMaterielChezBLCODE Then
		alDefaut = 902
	End If 

	// Dépot par Assuré "P_DEPOT_PAR_ASS"
	If alDefaut = 0 And Long ( alnv_Key[28].iaKeyValue ) > 0 Then
		
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD719" // #3 [DCMP090172] #5 [DCMP090378]
		stMessage.sVar[1]		= "BLCODE"		
	
		bDepotParAssure = f_Message ( stMessage ) = 1
		If bDepotParAssure Then alDefaut = Long ( alnv_Key[28].iaKeyValue ) 
			
	End If

	// Si bDimSup150cm Ou bPoidsSup30kg Alors forçage en 955
	If bDimSup150cm Or bPoidsSup30kg  Then
		Choose Case alnv_key [34].iaKeyValue 
			Case "CONFORAMA" 
				alDefaut = 956
			Case Else
				alDefaut = 955
		End Choose
		
		stMessage.Bouton		= Ok!
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD746" 

		f_Message ( stMessage )
	End If

	// Envoi par Assuré colissimo "P_ENVOI_PAR_ASS"
	If alDefaut = 0 And &
		alnv_key [34].iaKeyValue <> "AUCHAN_PEM" And &
		alnv_key [34].iaKeyValue <> "CARREFOUR_GRBB_GEM" And &
		Long ( alnv_Key[29].iaKeyValue ) > 0 Then
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD720" 

		bDepotEnvoiParAss = f_Message ( stMessage ) = 1
		If bDepotEnvoiParAss Then 
			
			If sCTG = "" Then
				isPrcBLCODE="#903#905#910#915#920#"
				alDefaut = -100 // Process d'attente
			Else
				alDefaut = Long ( alnv_Key[29].iaKeyValue ) 
			End IF
			
		End If 			

		
	End If

	// "P_BLCODE_ENV_BONPPAYE_COURR_OU_MAIL"
	If alDefaut = 0 And Long ( alnv_Key[30].iaKeyValue ) > 0 And &
		alnv_key [34].iaKeyValue <> "CARREFOUR_GRBB_GEM" Then
		
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD721" 
		stMessage.sVar[1]		= "BLCODE"		

		bBlCodeEnvBBPMailcour = f_Message ( stMessage ) = 1
		If bBlCodeEnvBBPMailcour Then 
			
			If sCTG = "" Then
				isPrcBLCODE="#903#908#913#938#943#"
				alDefaut = -100 // Process d'attente
			Else
				alDefaut = Long ( alnv_Key[30].iaKeyValue ) 
			End IF
			
		End If 			
		
		
	End If

	// "P_BLCODE_ENV_CARTONVD_AVEC_BONPPAYE"
	If alDefaut = 0 And Long ( alnv_Key[31].iaKeyValue ) > 0 And &
		alnv_key [34].iaKeyValue <> "CARREFOUR_GRBB_GEM" Then
		
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD722" 
		stMessage.sVar[1]		= "BLCODE"		

		bBlCodeEnvCartonBBP = f_Message ( stMessage ) = 1
		If bBlCodeEnvCartonBBP Then 
			
			If sCTG = "" Then
				isPrcBLCODE="#903#909#914#939#944#"
				alDefaut = -100 // Process d'attente
			Else
				alDefaut = Long ( alnv_Key[31].iaKeyValue ) 
			End IF
			
		End If 			
		
	End If

	// "P_BONPPAYE_DISPO_SITE"
	If alDefaut = 0 And Long ( alnv_Key[32].iaKeyValue ) > 0 And &
		alnv_key [34].iaKeyValue <> "CARREFOUR_GRBB_GEM" Then

		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD723" 

		bAssTlchrgBBPsite = f_Message ( stMessage ) = 1
		If bAssTlchrgBBPsite Then 
			
			If sCTG = "" Then
				isPrcBLCODE="#903#907#912#937#942#"
				alDefaut = -100 // Process d'attente
			Else
				alDefaut = Long ( alnv_Key[32].iaKeyValue ) 
			End IF
			
		End If 			
	End If

	// "P_ENLEV_CHEZ_ASSURE"
	If alDefaut = 0 And Long ( alnv_Key[33].iaKeyValue ) > 0 Then
		
		If sCTG = "" And alnv_key [34].iaKeyValue <> "CONFORAMA" Then
			stMessage.Bouton		= YESNO!
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "COMD730" 
	
			bBLCODEEnvTP = f_Message ( stMessage ) = 1
			If bBLCODEEnvTP Then alDefaut = 955
			
		Else
			bBLCODEEnvTP = True
			If bBLCODEEnvTP Then alDefaut = Long ( alnv_Key[33].iaKeyValue ) 			
		End If

	End If

	// [DT156]
	// lnv_Key[42].iskeyname = "SCAPSAV"
	If alDefaut = 0 And alnv_key [42].iaKeyValue = "OUI" And Not bPrestaScapSavExistanteRefusee Then
		alDefaut = Long ( alnv_Key[43].iaKeyValue ) // lnv_Key[43].iskeyname = "PROCESS_SCAPSAV"	
	End If

// [PC545].[POINT].[229]
	If alDefaut = 0 And isPrcBLCODE = "" Then
		alDefaut = Long ( alnv_Key[4].iaKeyValue ) // Process 
	End If
// :[PC545].[POINT].[229]
	
End If

If isPrcBLCODE <> "" Then
	sVal = F_REMPLACE ( isPrcBLCODE, "#", "," )
	sVal = Right ( sVal, Len ( sVal ) - 1 ) 
	sVal = Left  ( sVal, Len ( sVal ) - 1 ) 
	stMessage.Bouton		= Ok!
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "COMD731" 
	stMessage.sVar[1]		= sVal 
	alDefaut = 0
	
	f_Message ( stMessage )
End If


If alDefaut = 0 And isPrcBLCODE = "" Then
	stMessage.Bouton		= OK!
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "COMD736" 
	f_Message ( stMessage )

End If


//* #1 [FNAC_PROD_ECH_TECH].[20090213145759303]
If bMaterielChezBLCODE Then 
	alDefaut = 902
End If


//* #9 [DCMP090421].[20091118105631390]
Choose Case alDefaut
	Case 907, 912, 937, 942
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 106 )

		If lDeb > 0 Then

			lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, idwWDivsin.RowCount () ) 
			If lRow >0 Then 
				sVal = Upper ( idwWDivsin.GetItemString ( lRow, "VAL_LST_CAR" ) )
			
				lRow = idw_DetPro.Find ( "ID_TYP_CALC = '-AR' AND ID_CODE_CAR = '" + sVal + "'", lDeb, lFin )
				If lRow > 0 Then
					sVal = Trim ( idw_DetPro.GetItemString ( lRow, "VAL_CAR"))
					If IsNull ( sVal ) Then sVal = ""

					If isInfoSpbFrncplt <> "" Then
						isInfoSpbFrncplt += ";"
					End If
					isInfoSpbFrncplt += "LIB_ART_CLT=" + sVal
					
				End If
				
			End If
		End If		
		
End Choose
//* :#9 [DCMP090421].[20091118105631390]
end subroutine

public subroutine uf_message_process_blc (long alrow, long alinfospbfrn);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::uf_message_process_blc
//* Auteur			: Pierre-Henri Gillot
//* Date				: 18/12/2007 17:34:39
//* Libellé			: 
//* Commentaires	: [O2M] Affiche les message de PRocess O2M au gestionnaire
//*					  en fonction de l'info_spb_frn selectionnée
//*
//* Arguments		: 
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF	20/10/2008	  [FNAC_PROD_ECH_TECH]
//* #2    JFF  13/02/2008    [FNAC_PROD_ECH_TECH].[20090223142259343]
//* #3    JFF  13/02/2008    [FNAC_PROD_ECH_TECH].[20090224144248310]
//* #4    JFF  30/03/2009    [FNAC_PROD_ECH_TECH].[20090330152547023]
//* #5    JFF  23/04/2009    [LCL_NOMADE]
//* #6    JFF  19/05/2009    [DCMP090172]
//* #7    JFF  05/05/2009    [RUEDUCOMMERCE]
//* #8    JFF  05/05/2009    [DCMP090298]
//* #9    JFF  07/10/2009    [DCMP090421]
//* #10   JFF  25/11/2009    [MSS_DIAG]
//* 		 FPI	08/04/2010	  [DMDI28280] Taille S->M
//*  	    JFF	13/04/2010    [ADRESSE_O2M]
//*       JFF  10/06/2010    [PC419/440/418/439_MICROMANIA]
//*		 JFF  05/01/2011    [PC202].[DOM_COM]
//*       JFF  22/06/2011    [PC545].[POINT].[255]
//*       JFF  05/07/2011    [AUCHAN].[AUCH_SITCOL_NVFRONT]
//*       JFF  05/01/2012    [RECUP_DONNEE_O2M]
//*       JFF  08/01/2014    [VDOC13009]
//			FPI 01/06/2015 	[VDOC17736] Correction adresse BLC
//       JFF   30/06/2015 [DT156]
//       JFF   27/10/2021 [RS1218-RS1259-ADRO2M]
//       JFF   05/07/2022 [RS3337]
//*-----------------------------------------------------------------

string sCodMSg, sMtFrais, sCommentaireFrais, sIdRefFour 
String sVar[]
String sNumCmde, sAction, sTypApp, sTaillecoli, sNomContractant, sPc74
String sAppSin, sAlimSin, sBattSin //  [FNAC_PROD_ECH_TECH]
String sNomLigne1, sNomLigne2, sAdrLigne1, sAdrLigne2, sCP, sVille, sAdresseBlc	
decimal{2} dcMtFrais
Boolean bPc441 // Pièce facture d'achat&Reglt cotisation.
Boolean bPc74  // Copie bulletion adhésion
Boolean bRDCommerce // #7 [RUEDUCOMMERCE]
Boolean bFNACEpt  //* #8 [DCMP090298]
Boolean bMicromania // [PC419/440/418/439_MICROMANIA]
Boolean bCRCA_Pacifica, bDomCom // [PC202].[DOM_COM]
Boolean bAuchan

long	lRow, lDeb, lFin, lCaisse
Long lIdGti 
n_cst_attrib_key	lnv_key[], lnv2_key[]
n_cst_string	lnv_string
n_cst_string   lnvPFCString
n_cst_cmd_commun	lnvCmdCommun

dcMtFrais = -1
sMtFrais = ""
sTaillecoli = ""
sCommentaireFrais = ""

// [RECUP_DONNEE_O2M]
sIdRefFour 	= Upper ( idwArticle.GetItemString ( alRow, "ID_REF_FOUR" ) )

// [AUCH_SITCOL_NVFRONT]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 140 )
bAuchan = lDeb > 0 

// [ADRESSE_O2M]
lIdGti = idwDetail.GetItemNumber ( 1, "ID_GTI" )

// #6 [DCMP090172]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 59 )
If lDeb > 0 Then
	sNomContractant = Trim ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ) )
Else 
	sNomContractant = ""
End If
If IsNull ( sNomContractant ) Then sNomContractant = ""
// :#6 [DCMP090172]

//* #7 [RUEDUCOMMERCE]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 114 )
bRDCommerce = lDeb > 0
//* :#7 [RUEDUCOMMERCE]

// [PC419/440/418/439_MICROMANIA]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 137 )
bMicromania = lDeb > 0
// [PC419/440/418/439_MICROMANIA]

//* #8 [DCMP090298]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 105 )
bFNACEpt = lDeb > 0
//* :#8 [DCMP090298]

//  [PC202].[DOM_COM]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 138 )
bCRCA_Pacifica = lDeb > 0


if idwWsin.rowCount() > 0 Then
	sNumCmde	= string(idwWsin.object.id_sin[1])+"-"+string(uf_nouveau_num_sequence( ))

	// L'appareil est-il sinistré ?
	sAppSin = "NON"
	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'APP_SIN'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then 
		If Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" Then
			sAppSin = "OUI"
		End If
	End If
	
	// La batterie est-elle sinistrée ?
	sBattSin = "NON"
	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'BATT_SIN'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then 
		If Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" Then
			sBattSin = "OUI"
		End IF
	End If
	
	// L'alim est-elle sinistrée ?
	sAlimSin = "NON"
	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'ALIM_SIN'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then 
		If Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" Then
			sAlimSin = "OUI"
		End If
	End If

	// [RECUP_DONNEE_O2M]
	Choose Case sIdRefFour 
		Case "A_DIAGNOSTIQUER", "DONNER_A_RECUPERER"
			sAction = sIdRefFour 
		Case Else
			sAction = ""
	End Choose
	sTypApp	= isTypApp

	// #1 JFF [FNAC_PROD_ECH_TECH]				
	// Cas particulier : si batt ext ou alim ext, on passe en process identique à B donc mt_frais d'une catégorie B
	If sBattSin = "OUI" Or sAlimSin = "OUI" Then
		lnv2_Key[1].iskeyname  = "CTG"
		lnv2_Key[1].iakeyvalue = "B"
		lnv2_Key[2].iskeyname	 ="ACTION"
		lnv2_Key[2].iakeyvalue = sAction
		lnv2_Key[3].iskeyname  ="MT_FRAIS"		
		F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv2_Key )
	End If
	// :#1 JFF [FNAC_PROD_ECH_TECH]				
	
	lnv_Key[1].iskeyname	 ="TYP_APP"
	lnv_Key[1].iakeyvalue =sTypApp
	lnv_Key[2].iskeyname	 ="ID_COUR"
	lnv_Key[3].iskeyname	 ="ACTION"
	lnv_Key[3].iakeyvalue = sAction
	lnv_Key[4].iskeyname	 ="PROCESS"

	// #1 JFF [FNAC_PROD_ECH_TECH]				
	lnv_Key[5].iskeyname	 ="CTG"
	lnv_Key[6].iskeyname	 ="EMBORG"
	lnv_Key[7].iskeyname	 ="PROCESS_EMBORG"
	lnv_Key[8].iskeyname	 ="DEPOT_FNAC"
	lnv_Key[9].iskeyname	 ="PROCESS_FNAC"
	lnv_Key[10].iskeyname ="FRN"
	lnv_Key[11].iskeyname ="MT_FRAIS"
	lnv_Key[12].iskeyname ="CPLT_ADR_FRN_PROD"	
	//* #5 [LCL_NOMADE]
	lnv_Key[13].iskeyname ="TAILLE_COLI"	
	
	// :#1 JFF [FNAC_PROD_ECH_TECH]				

	F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv_Key )


	if lRow > 0 Then
		If sBattSin = "OUI" Or sAlimSin = "OUI" Then		
			If IsNumber ( lnv2_Key[3].iakeyvalue ) Then // #1 JFF [FNAC_PROD_ECH_TECH]	
				dcMtFrais = dec (lnv2_Key[3].iakeyvalue)
			// #1 JFF [FNAC_PROD_ECH_TECH]	
			Else 
				sMtFrais = lnv2_Key[3].iakeyvalue
			End If
	
		Else
		
			If IsNumber ( lnv_Key[11].iakeyvalue ) Then // #1 JFF [FNAC_PROD_ECH_TECH]	
				dcMtFrais = dec (lnv_Key[11].iakeyvalue)
			// #1 JFF [FNAC_PROD_ECH_TECH]	
			Else 
				sMtFrais = lnv_Key[11].iakeyvalue
			End If
			// :#1 JFF [FNAC_PROD_ECH_TECH]				
		End If

		//* #7 [RUEDUCOMMERCE].[CRTEST1]
		If bRDCommerce Then
			sCommentaireFrais += " (Si envoi depuis la France)"
		End If
		//* #7 [RUEDUCOMMERCE].[CRTEST1]				

		//  [PC202].[DOM_COM]
		If bCRCA_Pacifica and bDomcom Then
			sCommentaireFrais += " Maximum"
		End If
		//  [PC202].[DOM_COM]

		//* #5 [LCL_NOMADE]
		If lnv_Key[13].iakeyvalue <> "" And Not IsNull ( lnv_Key[13].iakeyvalue ) Then
			sTaillecoli = lnv_Key[13].iakeyvalue
		End If
		
	End If

// [ADRESSE_O2M]
// [VDOC13009]
// [VDOC17736] Correction adresse
	/*sAdresseBlc	=  "STE IDEM" + Char ( 13 ) 
	sAdresseBlc	+= "3 ALLEES DES GARAYS" + Char ( 13 ) 
	sAdresseBlc	+= "91120 PALAISEAU"*/

	// [RS3337]
	sAdresseBlc	= "LOXY" + Char ( 13 ) 
	sAdresseBlc	+= "21-23 Rue Saint-Hilaire" + Char ( 13 ) 
	sAdresseBlc	+= "Saint-Ouen l'Aumône" + Char ( 13 ) 
	sAdresseBlc	+= "95041 CERGY-PONTOISE CEDEX 1"		
	
// [ADRESSE_O2M]

	choose Case alInfoSpbFrn

			
// #1 JFF [FNAC_PROD_ECH_TECH]	905 à 999			
		Case 	903 // [FNAC_PROD_ECH_TECH].[20090330152547023]

			sCodMsg = "COMD724"		
			sVar[1] = sNumCmde
			sVar[2] = sAdresseBlc	

		Case 	905, 910, 915, 920

			sCodMsg = "COMD725"

			sVar[1] = ""
			sVar[2] = ""

			If dcMtFrais > 0 Then
				sVar[1] = "L'assuré pourra se faire rembourser ces frais d'envoi sur justificatif, montant " + string(dcMtFrais)
				sVar[2] = lnv_string.of_GlobalReplace( stGlb.smonnaiesymboledesire, "\", "" ) 
			End If			

			sVar[3] = sNumCmde
			sVar[4] = sAdresseBlc	


			
		Case 	908, 913, 938,943

			sCodMsg = "COMD726"

			sVar[1] = sNumCmde
			sVar[2] = sAdresseBlc	


		Case 	909,914,939,944
			sCodMsg = "COMD727"

			sVar[1] = sNumCmde
			sVar[2] = sAdresseBlc	

		Case  907, 912, 937, 942, 967
			
			sCodMsg = "COMD728"

			sVar[1] = sNumCmde
			sVar[2] = sAdresseBlc	

		Case 	968
			sCodMsg = "COMD761"

			sVar[1] = sNumCmde
			sVar[2] = sAdresseBlc

		Case 	955, 956

			sCodMsg = "COMD729"
			sVar[1] = sNumCmde

		// [DT156]
		Case 	957
			stMessage.sCode = "COMD893"					
			
			stMessage.sVar[1] = sNumCmde
			
			F_Message ( stMessage )		
			

		// [DT156]
		Case 985

			sCodMsg = "COMD914"
			
			If bPc441 Then
				sVar[1] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
			Else
				sVar[1] = ""
			End If

			sVar[2] = sPc74

			sVar[3] = sNumCmde


			
// :#1 JFF [FNAC_PROD_ECH_TECH]							
	End Choose

	//* #10  [MSS_DIAG]
	If sCodMsg <> "" Then
		stMessage.scode = sCodMsg
		stMessage.sVar = sVar
	
		F_Message(stMessage)
	End If
	//* :#10  [MSS_DIAG]
	
End If


end subroutine

private subroutine uf_chgt_fourn_fct_mobile (integer aicas);//*-----------------------------------------------------------------
//*
//* Fonction      : dw_regle_coherence::uf_Chgt_Fourn_Fct_Mobile (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 28/06/2004 13:33:22
//* Libellé       : Changement de fournisseur en fonction du mobile sinistré
//* Commentaires  : DCMP 040206
//*
//* Arguments     : Integer	aicas	val  // 1er ou 2ème tour   [DCMP090327].[SBETV] Ajout !!
//*
//* Retourne      : 	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    23/11/2004  DCMP 040493 aiguillage par prod/marq.
//*		 MADM   09/01/2006  DCMP 060008 Fournisseur SBE pour la marque BENQ
//*       MADM   26/01/2006  DCMP 060092 Fournisseur SBE pour la marque PANTECH
//* #2    JFF	  07/02/2006  [DCMP060119] modif suite ajout frn AEVUM
//* #3    MADM	  09/05/2006  [DCMP060356] modif suite ajout frn CORDON
//* #4    MADM	  22/05/2006  [DCMP060423] Fournisseur A-NOVO pour la marque SONY ERICSSON du code produit 10902
//* #5    MADM   18/08/2006  [DCMP060572] Fournisseur SBE pour la marque SAMSUNG
//* #6    MADM	  22/08/2006  [DCMP060577] Fournisseur A-NOVO pour la marque SONY ERICSSON du code produit 10909
//* #7    JFF	  12/12/2006  [DCMP060915] Les HTC vont chez Cordon
//* #8    JFF    10/04/2006  [DCMP070250] pour 9110 et 10908, les S.ERICSSON vont chez ANV
//* #9	 JFF    29/05/2007  [DCMP070344] Envoi des SHARP chez cordon
//* #10	 JFF    31/10/2007  [DCMP070819] Envoi des ETEN chez cordon
//* #11   JFF    16/11/2007  [DCMP070881] Nouvelle technique pour gérer aiguiller sur Marque/Modèle
//*													prioritaire sur Marque/Produit, vu avec A. Rault le 16/11/2007
//* #12   JFF    11/12/2007  [DCMP070880] LG vers COdron pour prod part.
//* #13	 JFF	  10/01/2007  [DCMP080034] SONY ERIC  W910I vers ANOVO
//* #14	 JFF	  16/01/2007  [DCMP080057] SONY ERIC  W890I et 380I vers ANOVO
//* #15	 PHG	  21/01/2008  [DCMP080073] Retrait RIM BLACKBERRY en Interdiction Totale
//*										    & Routage RIM BLACKBERRY vers SBE.
//* #16   JFF    29/01/2008  [DCMP080098] HUAWEI vers CORDON
//* #17   JFF    28/01/2008  [DCMP080028]
//* #18   JFF    15/04/2008  [DMDI22614] TWINSIM Vers Acean
//* #19   JFF    02/06/2008  [DMDI22949] MODELABS MTV3.3 vers Cordon
//* #20   JFF    19/06/2008  [DCMP080500] Aiguillage par pourcentage d'envoi
//* #21	 JFF	  20/10/2008  [FNAC_PROD_ECH_TECH]
//* #22	 JFF	  06/01/2009  [DMDI24606]
//* #23	 JFF	  05/03/2009  [DMDI25066]
//* #24   FPI    20/03/2009  [DCMP090109] O2M Réparateur IPhone
//* #25   JFF    01/04/2009  [20090401221022360] cas C-discount
//* #26   JFF    09/04/2009  [20090325175626940] cas Go-Micro
//* #27   JFF	  20/04/2009  [DMDI25515][DMDI25516] 
//* #28   JFF    24/06/2009  [DMDI25985]
//* #29   JFF    24/06/2009  [DCMP090355]
//* #30   JFF    02/09/2009  [DCMP090327].[SBETV]
//* #31   JFF    09/09/2009  [O2M_DIAG_NOMADE].[JFF].[20090909105840793]
//* #32   JFF    03/08/2009  [SCCCG13]
//* #33	 FPI	  12/11/2009  [200911121436].FPI Correction dev [SBETV] suite inter 59724 : iakeyvalue à caster en string
//* #34   JFF    17/12/2009  [20091217174145860].DMDI27438
//* #35   JFF    30/12/2009  [DCMP090751]
//* #36   JFF    15/01/2010  [O2M_DIAG_NOMADE].Lot2.JFF
//* #37   JFF    19/01/2009  [DCMP100026]
//* #38   JFF    24/02/2010  [DCMP100104] Tous les LG vont chez CORdon
//*     JFF     02/03/2010  [MSS_LOT2]
//* 	FPI	29/03/2010	[DCMP100233] Complement DCMP 090355
//* 	FPI	30/03/2010	[DCMP100183]
//* 	FPI	02/04/2010	[PC106] Evolution de l'option 121
//*			FPI	20/04/2010 [DCMP100306]
//*			FPI	22/04/2010 [DCMP100285]
//          JFF   03/06/2010 [PC397/443_IPAD]
//          JFF   29/06/2010 [PC41]
//*		FPI	12/07/2010	[PC321]
//          JFF   22/07/2010 [PM140]
//			   JFF   30/09/2010 [PC474]
//			FPI	03/11/2010	 [PC171] - DCMP100452
//          JFF   13/12/2010 [PC551] 41100, 41101
// 		   JFF	20/01/2011 [GROSBILL].[PC398-403-479]
//      FPI	11/04/2011	 [PC434]
//				JFF   15/04/2011 [PC323]
//		FPI	18/04/2011	[PC581]
//		FPI	02/05/2011	[PC595] 
//		FPI	10/05/2011	[PC514] 
//		FPI	31/05/2011	 [PC581] [PC514] [PC512-1] Ajout d'IPhone en réparation
//		FPI	04/07/2011	[PC514-1] 
//    JFF   12/07/2011   [PC547] Ajout produit 30800 à 30803
//	FPI	01/08/2011	 [PC413-1_Lot1] Ajout 22511 to 22514
//	FPI	16/08/2011	 [PC521] Ajout de 44500 pour l'IPhone
//	FPI	25/08/2011	[PC469] Modification comportement option 121
//       JFF   19/09/2011   [PM82][LOT1]
// 		FPI	27/09/2011	[PC514-1] Ajout 36812,36813 pour l'IPad
//		FPI	05/10/2011	[VDoc4564]
//    JFF	07/10/2011  [PC581] Samsung Galaxy
// 		FPI	30/11/2011	[VDoc6143] Ajout modèles d'Iphone 4S
// 		 JFF   13/02/2012   [PM200][PSM]
//*      JFF    23/02/2012   [VDOC7066]
//        JFF   01/03/2012  [CONFO][MEUBLE][PC542] -> FPI - 07/06/2012 - suppr car utilisation DP 95
//*      JFF    22/03/2012   [VDOC7214]
//*      JFF    29/03/2012   [MANTIS3076][PM200]
// 		FPI	30/03/2012	[VDoc7440] Ajout des IPad2
//       JFF   12/04/2012  [VDOC7532] 
//       JFF   12/04/2012  [VDOC7507][VDOC7577]
//       JFF     17/04/2012   [PM200][LOT2][DESOX]
//*       JFF   27/04/2012   [VDOC7726] Transfert Cordon vers PSM
//        JFF    06/08/2012  [BLCODE]
//        JFF    22/08/2012  [ITSM127498]
//        JFF    31/08/2012  [VDOC8722]
//		FPI	20/09/2012	[VDoc8903] Iphone 5
//      JFF  10/10/2012  [PC869]
//		FPI  12/10/2012 [PC846/864]
//      JFF  15/10/2012  [PC869]
//		FPI	06/11/2012	[ITSM134800]
// 		FPI	23/11/2012 [PC874]
// 		JFF	28/11/2012 [PM200_LOT3]
//       JFF    26/11/2012  [PC877]
// 		JFF	05/12/2012 [PM200_LOT4]
// 		JFF	29/01/2013 [PC801_MANTIS6481]
//       JFF   14/02/2013 [VDOC10362]
//       JFF   19/02/2013 [VDOC9304_PM82_LOT1]
//		FPI	04/03/2013	[PC467-2] 
//       JFF   07/05/2013 [PC938_ORANGE_V3]
//       JFF   07/05/2013 [PC929-1]
//		FPI	18/07/2013	[2EME_PRESTA_SAV][ITSM166882]
//       JFF   25/07/2013 [VDOC11739]
//		FPI	25/07/2013	[PC954]
//		FPI 	29/07/2013 [PC918]
//		JFF 	03/09/2013 [PC929_CDISCOUN_M8602]
//		JFF 	21/06/2013 [VDOC11649]
//		JFF 	27/09/2013 [VDOC12097]
//    JFF   04/10/2013 [PC980_MANTIS8945]
//    JFF	10/10/2013 [VDOC12436]
//    JFF	28/10/2013 [VDOC12480]
//    JFF   12/12/2013 [PC947&977]
//	 FPI	10/02/2014	[PC925]
//		FPI	01/04/2014	[PM257-1] Ws PSM
// 		JFF 	05/05/2014 [VDOC14301]
//       JFF   28/05/2014 [PC786-1_AUCHAN_GEM]
//       JFF   07/05/2013 [PC929_CDISCOUNT][PC929-2-V3]
//    JFF   23/09/2014 		[VDOC15439]
//       JFF   02/10/2014 [VDOC15485]
//       JFF   14/10/2014 [OPTIM_IPHONE]
//       JFF   04/11/2014 [PM280-1]
//		FPI	08/12/2014	[PC13174]
//       JFF   12/12/2014 [PC13321]
//       JFF   20/03/2015 [PC13321][MANTIS14803]
//		FPI	25/03/2015	[PC14613]
//		JFF	21/04/2015	[VDOC17311]
//		FPI	26/05/2015	[PC786-2]
//       JFF   13/07/2015 [PC151270_ORANGE_V3]
//       JFF   15/07/2015 [VDOC18196]
//       JFF   22/07/2015 [DT168]
// 		JFF   31/07/2015 [DT156][MANTIS16649]
//       JFF   03/09/2015 [VDOC18588]
//		FPI	14/09/2015 [DT173].Mt17057
//       JFF   08/02/2016 [PC151522]
//       JFF   23/02/2016 [PM330-1][MANTIS19998]
//       JFF   18/04/2016 [PM330-1][ITSM376181]
//       JFF   26/04/2016 [DT207][DT208]
//       JFF   02/06/2016 [BUG_IPHONE_DESOX]
//       JFF   28/06/2016 [PC151549]
//       JFF   06/07/2016 [ITSM396197]
//       JFF   07/11/2016 [PC151259]
//       JFF   02/01/2017 [DT253]
//       JFF   21/02/2107 [DT288]
//       JFF   02/03/2107 [MODIF_SCAPSAV]
// 		JFF   12/04/2107 [DT288][M24507]
// 		JFF	15/05/2017 [ITSM466332] Bug
//       JFF   29/05/2017 [PC151259-2]
//       JFF   23/08/2017 [DT288-3_LOT1][PM280]
//       JFF   12/09/2017 [PC151259-3]
// 		JFF	03/10/2017 [WS_PSM]
//       JFF   05/10/2017 [PC171918]
//       JFF   01/06/2018 [PC151425-1]
//       JFF   26/11/2018 [PC874_2_V1]
//       JFF   04/03/2019 [DT401]
//       JFF   30/09/2019 [DT447-1]
//       JFF   23/06/2020 [PC202553_SELECTRA]
//       JFF   07/03/2024 [HP252_276_HUB_PRESTA]
//       JFF   18/10/2024 [HP252_276_HUB_PRESTA][HUB577]
//*-----------------------------------------------------------------

String sIdGti, sRech, sIdFourModif, sModlRepart, sTypPresta, sDept, sVal, sDimSup150cm, sPoidsSup30cm, sIdFourPM82LOT1, sVal1, sVal2
Long lTotRow, lRow, lCpt, lIdProd, lDeb, lFin, lIdSin, lRowBatAlim, lIdEvt, lRow2, lRow3, lRowSBE, lRowPSM, lVal1, lRow4
n_cst_attrib_key	lnv_Key[], lnv_KeyVide[], lnv_Key2[], lnv_KeyNull[]
Boolean	bParticulier, bBattSin, bAlimSin, bDartyIpad, bShunt, bPrestaExisteHub 
Boolean  bTablettePC, bPC869, bTeleDiagOk 
Long lDeb2, lFin2, lRowScapSav, lVal
String sValCar, sListeTypApp, sListeMarques, sCodeBtqCentral
Decimal {2} dcMtValAchat 
Decimal dcIdEts
n_cst_string lnvPFCString // #30 [DCMP090327].[SBETV]
Boolean bAutoriserSavSiFournAbsentParam, bFournAbsent, bPSM, bChoixHubFait
Long lCptDwPrs, lTotRowDwPrs, lDeb1, lFin1, lCpt1, lIdGti, lCptDetPro 
Long lIdProcessPremierePrestaPRS // [2EME_PRESTA_SAV][ITSM166882]
Integer iRet, iCptIphonePSM, iTotIphonePSM
Boolean bAfficheMsgErreurFinal=TRUE // [PC786-2]
String sTabIphonePSM []
DateTime dtDt1, dtDt2, dtDt3, dtCreeLe 
Boolean bOkPassCtrleDP315, bSAVInterdit, bTestSavInterdit, bPsmRepa, bHubPossible, bPrestaExisteNonHub, bCutOffO2M
DateTime dtDtePivotDT1288, dtCreeLeDos, dtDtePivotDT401, dtDtePivotDT447 
String sFind, sLibFour, sSysExploit, sIdFourO2mOuHubPresta, sLstAppHub 
Int iFind

lIdSin  = idwDetail.GetItemNumber ( 1, "ID_SIN" )
lIdEvt  = idwDetail.GetItemNumber ( 1, "ID_EVT" ) // [PM200][LOT2][DESOX]
lIdGti  = idwDetail.GetItemNumber ( 1, "ID_GTI" )
sIdGti  = String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) )
lTotRow = idwFourn.RowCount ()
lIdProd = idwWsin.GetItemNumber ( 1, "ID_PROD" )
dtCreeLe = idwWsin.GetItemDateTime ( 1, "CREE_LE" ) // [DT253]
sIdFourModif = ""
isFourRepartPC = Space ( 3 )
bParticulier = False
bShunt = FALSE
bTablettePC = False
bPC869 = False
bAutoriserSavSiFournAbsentParam = False
bFournAbsent = False
bOkPassCtrleDP315 = False
bSAVInterdit = False
dtCreeLeDos = idwWSin.GetItemDateTime ( 1, "CREE_LE") // [DT401]
bPsmRepa = False ;  bHubPossible = False // [HP252_276_HUB_PRESTA]
bPrestaExisteNonHub = False // [HP252_276_HUB_PRESTA]
bCutOffO2M = False 
bChoixHubFait = False

isFournParDefaut = "" // #30 [DCMP090327].[SBETV]

//* #31 [O2M_DIAG_NOMADE].[JFF].[20090909105840793]
lIdEvt = idwDetail.GetItemNumber ( 1, "ID_EVT" )

// Clé permanente à ne pas supprimer
If F_CLE_A_TRUE ( "SHUNT_CTRLE_PRESTA" ) Then
	Choose Case stGlb.sCodOper
		Case "JFF", "FPI"
			bShunt = True
	End Choose
End If

F_RechDetPro ( lDeb2, lFin2, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 167 )
bDartyIpad = lDeb2 > 0 

sVal  = ""
Choose case isChoixAction
	Case "R"
		sVal += " = 'PRS'"
		sTypPresta = "PRS"
	Case "I"
		sVal += " = 'EDI'"
		sTypPresta = "EDI"
End Choose

sRech = "ID_GTI = " + sIdGti + " AND ID_CODE_ART = '" + sTypPresta + "' AND ID_TYP_CODE = '-XX' AND ID_CODE = -1"

If F_CLE_A_TRUE ( "HP252_276_HUB_PRESTA" ) Then
	sRech += " AND ID_CODE_FRN <> 'HUB'"
End IF 

lRow = idwFourn.Find ( sRech, 1, lTotRow )
If lRow > 0 Then
	sIdFourModif = idwFourn.GetItemString ( lRow, "ID_CODE_FRN" ) 
End If

sRech = "ID_GTI = " + sIdGti + " AND ID_CODE_FRN = 'PSM' AND ID_CODE_ART = 'PRS' AND ID_TYP_CODE = '-XX' AND ID_CODE = -1"
lRowPSM = idwFourn.Find ( sRech, 1, lTotRow )

If lRowPSM > 0 Then
	bPsmRepa = True
	sIdFourModif="PSM"			
			
	// [PM257-1]
End IF
// [PM200][PSM]

// [HP252_276_HUB_PRESTA]
If F_CLE_A_TRUE ( "HP252_276_HUB_PRESTA" ) Then
	// Y a-t-il du Hub possible pour l'action demandée ?
	sRech = "ID_GTI = " + sIdGti + " AND ID_CODE_FRN = 'HUB' AND ID_CODE_ART = '" + sTypPresta + "' AND ID_TYP_CODE = '-XX' AND ID_CODE = -1"
	bHubPossible = idwFourn.Find ( sRech, 1, lTotRow ) > 0 
	
	// Y a-t-il une presta de réparation ou de diag déjà existante NON HUB
	lRow = idwCmdeSin.Find( "( ID_TYP_ART = 'PRS' OR ID_REF_FOUR = 'A_DIAGNOSTIQUER' ) AND POS ( info_spb_frn_cplt, 'HP_ID_HUB_PRESTA' ) <=0" ,1,idwCmdeSin.RowCount()) 
	bPrestaExisteNonHub = lRow > 0 

	// Y a-t-il une presta de réparation ou de diag déjà existante HUB
	lRow = idwCmdeSin.Find( "( ID_TYP_ART = 'PRS' OR ID_REF_FOUR = 'A_DIAGNOSTIQUER' ) AND POS ( info_spb_frn_cplt, 'HP_ID_HUB_PRESTA' ) > 0" ,1,idwCmdeSin.RowCount()) 
	bPrestaExisteHub = lRow > 0 

/*
	lRow = idwCmdeSin.Find( "ID_TYP_ART = 'PRS' OR ID_REF_FOUR = 'A_DIAGNOSTIQUER'" ,1,idwCmdeSin.RowCount()) 
	If lRow > 0 Then
		sVal2	= idwCmdeSin.GetItemString ( lRow, "info_spb_frn_cplt" ) 
		sVal2	= F_CLE_VAL ( "HP_ID_HUB_PRESTA", sVal2, ";" ) 
		bPrestaExisteNonHub = Len ( Trim ( sVal2 ) ) <= 0
	End IF 
*/

	// Décision 
	/*
	If Not bPrestaExisteNonHub And bHubPossible And Not bPsmRepa Then 
		sIdFourModif = "HUB"	
	End If 
	*/
	
End IF 


// [HP252_276_HUB_PRESTA]
sIdFourO2mOuHubPresta = "O2M"

If F_CLE_A_TRUE ( "HP252_276_HUB_PRESTA" ) Then
	If F_CLE_A_TRUE ( "HP252_276_CUTOFF_O2M" ) Then

		// Détermination HUB ou O2M => O2M si déjà présence d'une presta O2M
		If idwCmdeSin.Find( "ID_FOUR IN ( 'O2M', 'BLC')" ,1,idwCmdeSin.RowCount()) > 0 Then
			sIdFourO2mOuHubPresta = "O2M"
		Else 
			F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 379 )
			If lDeb > 0 Then
				bCutOffO2M = True
			
				//[HP252_276_HUB_PRESTA][HUB577]
				sVal = idw_DetPro.GetItemString ( lDeb, "VAL_CAR" )
				sLstAppHub = F_CLE_VAL ( "TYP_APP_HUB", sVal, ";" )
				If IsNull ( sLstAppHub ) Then sLstAppHub = ""
				
				// Si Pas de liste Hub spécifie, tous les appareils vont vers le HUB
				If sLstAppHub = "" Then
					sIdFourO2mOuHubPresta = "HUB"		

				// Sinon si AMU app Hub Spécifié, alors ce sont uniquement les app de la liste qui vont vers le HUB
				Else
					If Pos ( sLstAppHub, "#" + isTypApp + "#" ) > 0 Then					
						sIdFourO2mOuHubPresta = "HUB"
					End If 
				End IF 
			End If 
		End If

	End IF 
	
End IF 

/*------------------------------------------------------------------*/
/* #1 second aiguillage par fourn/produit/marque.                   */
/*------------------------------------------------------------------*/
Choose Case Upper ( isMarqPortAdh ) 

	// ParMarque
	Case 	"APPLE" 

		// Par modèle
		Choose Case True 
				/* isModlPortAdh [OPTIM_IPHONE] */
			// #28 [DMDI25985] => Ajout des 4x3GS
			// [PM140]
			// 	[VDoc6143] Ajout modèles d'Iphone 4S
			// [VDOC7214]
			//[VDoc8903]
			// [VDOC12436]
			// [VDOC15439]
			// [OPTIM_IPHONE]
			
			Case Pos ( isModlPortAdh, "IPHONE" ) > 0

				// [VDoc4564]
				
				IF lIdEvt <> 1377 Then
				
					lnv_key = lnv_KeyNull
			
					lnv_key[1].iskeyname = "MODELE"
					lnv_key[1].iakeyValue = "IPHONE"
					lnv_key[2].iskeyname = "ID_FOUR"
					lnv_key[3].iskeyname = "METHODE"
					
					f_rechdetpro_withkey(lRow, idw_DetPro, lIdProd,"-DP", 200, lnv_key)
				
					If lRow > 0 Then
						sIdFourModif = "O2M"
					End If
	
					// [VDOC18196]
					If Not ibvDoc18588_KoProxiPSM_GoToO2M Then
						F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 283 )
						For lCptDetPro = lDeb To lFin
						
							sVal = idw_DetPro.GetItemString ( lCptDetPro, "VAL_CAR" ) 
							
							// [VDOC18588]
							/* annulé par DPG
							If F_CLE_SHUNT_A_TRUE ( "VDOC18588" ) Then
								sVal = lnvPFCString.of_getkeyvalue (sVal, "MODL", ";")								
							End If
							*/
							
							If Pos ( isModlPortAdh, sVal ) > 0 Then
								sIdFourModif = "PSM"
								Exit
							End If
						Next
					End If							

					If lRow > 0 Then // [ITSM134800]
						IF lnv_key[2].iakeyValue <> "" Then 
							sIdFourModif = Trim ( Upper ( lnv_key[2].iakeyValue ) )
						End if
					End if
	
					// [DT173].Mt17057
					// [DT207][DT208] sIdFourModif <> "PSM" 
					IF lRow > 0 Then
						If lnv_key[3].iakeyValue <> "" Then 
							If lnv_key[3].iakeyValue="REPA_PSM" And sIdFourModif <> "PSM" Then
									stMessage.sTitre		= "Commandes"
									stMessage.Icon			= Question!
									stMessage.bErreurG	= FALSE
									stMessage.Bouton		= YesNo!
											
									stMessage.sCode = "WDET566"
									if F_Message ( stMessage ) = 2 Then sIdFourModif = "PSM"
							End if
						End if
					End if
					// :[DT173].Mt17057
					
					// [DT288]
					// Vu que COR devient le défaut pour OV2 -dp/239, 
					// il faut maintenir via cette règle O2M pour le DT290
					
					F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 315 )
					If lDeb > 0 And lIdGti <> 24 Then
						F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 314 )
						For lCptDetPro = lDeb To lFin
							sVal = idw_DetPro.GetItemString ( lCptDetPro, "VAL_CAR" ) 
							
							If Pos ( isModlPortAdh, sVal ) > 0 Then
								sIdFourModif = "O2M"
								Exit
							End If
						Next
					End If								
				End If			

		End Choose	
// #24 [DCMP090109]

		// toujours le modèle mais de façons différente 'demande d'Aurélien)
		// [VDOC7507][VDOC7577]
		Choose Case True
			Case Pos ( isModlPortAdh, "IPAD" ) > 0
				// [VDoc4564]
				lnv_key = lnv_KeyNull
				
				lnv_key[1].iskeyname = "MODELE"
				lnv_key[1].iakeyValue = "IPAD"
				lnv_key[2].iskeyname = "ID_FOUR"
			
				// [PC980_MANTIS8945]
				If lIdEVt <> 1377 Then
					f_rechdetpro_withkey(lRow, idw_DetPro, lIdProd,"-DP", 200, lnv_key)
				
					If lRow > 0 Then
						sIdFourModif = "O2M"
						bDartyIpad = TRUE
					End if
					
					IF lRow > 0 Then // [ITSM134800]
						IF lnv_key[2].iakeyValue <> "" Then
							sIdFourModif = Trim ( Upper ( lnv_key[2].iakeyValue ) )
							bDartyIpad = TRUE
						End If
					End if
				End If
				
		End Choose

End Choose

// #20 [DCMP080500] 
If isFourRepartPC <> sIdFourModif Then isFourRepartPC = ""

/*------------------------------------------------------------------*/
/* Cas particulier de la gestion DARTY NOMADE.                      */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 31 )

// [PC151522]
If lDeb > 0 Then
	If lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR"), "OPT_31_ASSOUPLIE", ";") = "OUI" Then
		lDeb = 0
	End If
End If

If lDeb > 0 And Not bDartyIPAD Then 
	Choose Case True

		Case isCasGestionDartyNomade = "11/PCP/PRS_DTY" Or Pos ( isCasGestionDartyNomade, "CMD_DTY", 1 ) > 0  // #17
			sIdFourModif = "DTY"			

		Case isCasGestionDartyNomade = "11/NPCP/>300/PRS_DST"
			sIdFourModif = "DST"			

	End Choose
End If


// [PC202553_SELECTRA]
lDeb = 0
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 349)

// [ITSM460673]
If lIdGti <> 24 Or lDeb > 0  Then
	uf_chgt_fourn_fct_dp148( idwWSin.GetItemNumber ( 1, "ID_PROD" ) , sIdFourModif) // [PC171] - DCMP100452
End if
// :[ITSM460673]

// [PC929-1]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 37 )

// [PC474]
If lDeb > 0 Then
	If lIdEvt = 937 Then
		sIdFourModif = "O2M"
	End If
End If
// :[PC474]

 // [PC874]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 218 )
If lDeb > 0 and sTypPresta = "PRS" Then
	dcIdEts= idwwsin.GetItemDecimal (1,"ID_ETS") 
	if dcIdEts = 1004 or dcIdEts=1005 Then sIdFourModif = "OMT"
End If
// :[PC874]	

// [DT168] 
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 275 )
If lDeb > 0 and sTypPresta = "PRS" Then
	sIdFourModif = "SBE"
End If
// [DT168]		

// [DT227]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 299 )
If lDeb > 0 and sTypPresta = "PRS" Then
	lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'LIEU_REPAR'", 1, idwWDivSin.RowCount () ) 
	If lRow >0 Then 
		sVal = Upper ( idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) )
		sIdFourModif = sVal
	End If 
End If

// [PC151259] // FULL_SERENITY_ADV_5
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 252 )
If lDeb > 0 and sTypPresta = "PRS" Then

	// Si on est sur ADVISE (dp252) on réinitialise sIdFourModif armé par défaut plus 
	// Car c'est cet algo ci-dessous qui détermine le fournisseur.
	sVal1 = lnvPFCString.of_getkeyvalue ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")
	sVal = lnvPFCString.of_getkeyvalue ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "DTE_PIVOT_DT401", ";")
	If IsNull ( sVal ) Then sVal = ""
	If IsNull ( sVal1 ) Then sVal1 = ""		
	sVal = Trim ( sVal ) 
	sVal1 = Trim ( sVal1 ) 		
	If sVal <> "" And sVal1 <> "" Then
		sIdFourModif = ""
	End If 

	// [DT401]
	sVal = lnvPFCString.of_getkeyvalue ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "DTE_PIVOT_DT401", ";")
	If IsNull ( sVal ) Then sVal = ""
	
	If sVal <> "" Then
		dtDtePivotDT401 = DateTime ( sVal )
		If dtCreeLeDos >= dtDtePivotDT401 Then 
			sIdFourModif = "AAS"
		End If 
	End IF 
	
	sVal = lnvPFCString.of_getkeyvalue ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")
	
	// [DT401]
	IF sIdFourModif = "AAS" Then sVal = ""
	
	// [PC171918]
	Choose Case sVal
		Case "FULL_SERENITY_ADV_5", "ADVISE_6"
			sIdFourModif = "" 
			lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'FRN_REPA_ADH'", 1, idwWDivSin.RowCount () ) 
			If lRow >0 Then 
				sVal = Trim ( Upper ( idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) ))
				If IsNull ( sVal ) Then sVal = ""
				
				Choose Case Left ( sVal, 3 ) 
					Case "PSM"
						sIdFourModif = Left ( sVal, 3 ) 
						
						Choose Case isTypApp
							Case "TEL", "TPC"
								// OK
							Case Else
								sIdFourModif = "" // Problème, pas le bon fourn pour le bon mat
						End Choose 
						
				End Choose 
				
				Choose Case Left ( sVal, 3 ) 
			
					// [PC151259-2] [PC171918]
					Case "EKO", "DGC", "NET", "SMT", "RAV", "RTP", "SFG", "O2M"
						sIdFourModif = Left ( sVal, 3 ) 
		
				End Choose 
	
			End If
	End Choose
End If	

// [DT253]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 312 )	
If lDeb > 0 and sTypPresta = "PRS" Then
	sIdFourModif = "COR"
End If

// [PC151425-1]
/*
If F_CLE_A_TRUE ( "PC151425-1" ) Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 298 )	
	If lDeb > 0 and sTypPresta = "PRS" Then

		sIdFourModif = "O2M" // O2M dans tous les cas
	
		// Sauf pour la désox
		IF lIdEvt = 1377 Then
			sIdFourModif = "PSM"
		End If 
		
	End IF
End If
*/

// [DT447] 
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 342)
If lDeb > 0 and sTypPresta = "PRS" Then
	sVal = lnvPFCString.of_getkeyvalue ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "DTE_PIVOT_DT447", ";")
	sVal1 = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "CAS", ";")			
		
	If sVal <> "" And IsDate ( sVal ) Then
		dtDtePivotDT447 = DateTime ( sVal )

		// Traitement après MEP DT447
		If dtCreeLeDos >= dtDtePivotDT447 Then
		
			Choose Case sVal1
				Case "80500", "35800"
	
					If ibBrisEcran Then			
						sIdFourModif = "PSM"
					Else 
						sIdFourModif = "O2M"
					End If
						
				
				// [DT447-1]
				Case "44502"
					
					Choose Case isTypApp
						Case "CJP", "PCP"
							sIdFourModif = "O2M"

					End Choose 
	
			End Choose
		End IF 
	End IF 
End If
// [DT447]		

// [PC202553_SELECTRA]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 348)
If lDeb > 0 and sTypPresta = "PRS" Then
	Choose Case isTypApp
		Case "TPC"
			sSysExploit = Space ( 35 )
			SQLCA.PS_S_SYS_EXPLOIT_APP_IFR ( isMarqPortAdh, isModlPortAdh, sSysExploit ) 
			If Upper ( sSysExploit ) = "ANDROID" Then
				sIdFourModif = "SBE"
			End If 

		Case "MCS"				
			sSysExploit = Space ( 35 )
			SQLCA.PS_S_SYS_EXPLOIT_APP_IFR ( isMarqPortAdh, isModlPortAdh, sSysExploit ) 
			sIdFourModif = "" // C'est SBE si ANDORID sinon rien pas d'envoi.
			If Upper ( sSysExploit ) = "ANDROID" Then
				sIdFourModif = "SBE"
			End If 

		Case "CRV"								
			If isMarqPortAdh <> "SAMSUNG" Then 
				sIdFourModif = ""
			End If 
			
	End Choose 
End If 

// ------ Fin du traitement des action PRS ------ //

// ------ Début du traitement des action EDI ------ //

// Début du traitement I
If isChoixAction = "I" Then 

	lnv_key = lnv_KeyNull

	lnv_Key[1].iskeyname	 ="TYP_APP"
	lnv_Key[1].iakeyvalue = isTypApp
	lnv_Key[2].iskeyname	 ="ACTION"
	lnv_Key[2].iakeyvalue ="A_DIAGNOSTIQUER"
	lnv_Key[3].iskeyname	 ="FRN"
	lnv_Key[4].iskeyname	 ="FRN_DPT"
	lnv_Key[5].iskeyname	 ="FRN_ALT"
	lnv_Key[6].iskeyname	 ="FRN_DPT_ALT"
	lnv_Key[7].iskeyname	 ="SCAPSAV" // [DT156]
	lnv_Key[8].iskeyname	 ="FRN_SCAPSAV" // [DT156]	
	

	// [DT141] 
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 275 )
	If lDeb > 0 Then
		If isMarqPortAdh <> "APPLE" Then
			// [DT168]
			lnv_Key[3].iakeyvalue =""
		Else 
			lnv_Key[3].iakeyvalue ="SBE"
		End If
	End If
	// [DT141] 	
	
	lnv_Key2 = lnv_Key
	
	// [PC929-1] 
	bPSM = False
	
	
	If bPSM Then
		F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 209, lnv_Key )		
	Else
		F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv_Key )			
		
		// [HP252_276_HUB_PRESTA] // Permet de ne plus maintenir le param 95 A_DIAG pour le futur
		If lRow <=0 Then
			If F_CLE_A_TRUE ( "HP252_276_HUB_PRESTA" ) Then
				If F_CLE_A_TRUE ( "HP252_276_CUTOFF_O2M" ) Then
					If bHubPossible And Not bPrestaExisteNonHub And bCutOffO2m And sIdFourO2mOuHubPresta = "HUB" Then
						lnv_Key[3].iakeyvalue = sIdFourO2mOuHubPresta 
						sTypPresta = "EDI"
						bParticulier = True
					End If 
				End IF 
			End If		
		End If 		
	End If


	If lRow > 0 Then
		

		// #30 [DCMP090327].[SBETV] 
		lRow2 = idwCmdeSin.Find ( "ID_REF_FOUR='A_DIAGNOSTIQUER' AND COD_ETAT <> 'ANN'", 1 , idwCmdeSin.RowCount () ) 
		
		// [DT156]
		// ScapSav
		If lnv_Key[7].iakeyvalue = "OUI" Then
			// [MODIF_SCAPSAV]
			lRowScapSav = idwCmdeSin.Find ( "ID_FOUR IN ('O2M', 'BLC') AND ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT = 'RFO' AND INFO_SPB_FRN = 985 AND STATUS_GC IN ( 304, 156, 157, 158, 160, 174)", 1, idwCmdeSin.RowCount ()) 
			
			If lRowScapSav <= 0 Then
				lnv_Key[3].iakeyvalue =lnv_Key[8].iakeyvalue // Le frn lié au scapsav
				lnv_Key[4].iakeyvalue =""
			Else
				// [DT156][MANTIS16649]
				lRow2 = idwCmdeSin.Find ( "ID_REF_FOUR='A_DIAGNOSTIQUER' AND COD_ETAT <> 'ANN' AND INFO_SPB_FRN <> 985", 1 , idwCmdeSin.RowCount () ) 
			End If
		End If 
		
		
		If lRow2 > 0 Then
			
			sIdFourModif = idwCmdeSin.GetItemString ( lRow2, "ID_FOUR" )
			sTypPresta = "EDI"
			bParticulier = True
		
		ElseIf IsNull ( lnv_Key[4].iakeyvalue ) Or Trim ( string(lnv_Key[4].iakeyvalue) ) = "" Then // #33
				sIdFourModif = string(lnv_Key[3].iakeyvalue) // #33
				sTypPresta = "EDI"
				bParticulier = True

		ElseIf String(lnv_Key[4].iakeyvalue) = "TOUS" Then // #33
			// Si un frn est paramétré sur l'option 95 pour ce type d'appareil, il a priorité sur tout le reste.
			If String(lnv_Key[3].iakeyvalue) <> "" Then 
				sIdFourModif = string(lnv_Key[3].iakeyvalue) // #33
				sTypPresta = "EDI"
				bParticulier = True
			End If
			
   	ElseIF string(lnv_Key[4].iakeyvalue) = "AUCUN" Then
			If string(lnv_Key[5].iakeyvalue) <> "" Then 
				sIdFourModif = string(lnv_Key[5].iakeyvalue) // #33
				sTypPresta = "EDI"
				bParticulier = True
			End If
			
		Else
			If aicas = 1 Then
				//sIdFourModif = lnv_Key[3].iakeyvalue
				sIdFourModif = string(lnv_Key[3].iakeyvalue) // #33
				sTypPresta = "EDI"
				bParticulier = True
				idwCmde.PostEvent ( "ue_Init_Par_Defaut" )
			End If
		
			// Deuxième tour (cas spécial)
			If aicas = 2 Then			
				sDept = ""
				Do While sDept = "" Or sDept = "[RETOUR]"
					// 1 arg supp sur cette fonction
					// passage en public
					// Ue à créer sur dw_commande sur fen
					// Tagger tout
					
					Open( w_sp_trt_saisie_dept )
					sDept = Message.StringParm

					If sDept = "" Or sDept = "[RETOUR]" Then 
						stMessage.Bouton		= Ok!
						stMessage.Icon			= Information!
						stMessage.bErreurG	= FALSE
						stMessage.sCode		= "COMD551"
						f_Message ( stMessage ) 
					End If
				Loop

				sDept = lnvPFCString.of_getkeyvalue (sDept, "DEPT", ";")
				If IsNull ( sDept ) Then sDept = ""
				isDept=sDept
				
				/*IF lnv_Key[4].iakeyvalue = "RESTE" Then 
					If Pos ( lnv_Key[6].iakeyvalue, "#" + sDept + "#", 1 ) > 0 Then
						sIdFourModif = lnv_Key[5].iakeyvalue*/ // #33
  				  IF String(lnv_Key[4].iakeyvalue) = "RESTE" Then 
					If Pos ( string(lnv_Key[6].iakeyvalue), "#" + sDept + "#", 1 ) > 0 Then
						sIdFourModif = string(lnv_Key[5].iakeyvalue)
						sTypPresta = "EDI"
						bParticulier = True
					Else
//						sIdFourModif = lnv_Key[3].iakeyvalue
						sIdFourModif = string(lnv_Key[3].iakeyvalue) // #33
						sTypPresta = "EDI"
						bParticulier = True
					End If
				Else
					/*If Pos ( lnv_Key[4].iakeyvalue, "#" + sDept + "#", 1 ) > 0 Then
						sIdFourModif = lnv_Key[3].iakeyvalue*/
					If Pos ( String(lnv_Key[4].iakeyvalue), "#" + sDept + "#", 1 ) > 0 Then
						sIdFourModif = string(lnv_Key[3].iakeyvalue)		// #33
						sTypPresta = "EDI"
						bParticulier = True
					Else
						//sIdFourModif = lnv_Key[5].iakeyvalue
						sIdFourModif = string(lnv_Key[5].iakeyvalue)		// #33
						sTypPresta = "EDI"
						bParticulier = True
					End If
				End If
			End If			
		End If
		// :#30 [DCMP090327].[SBETV]
		
	End If 

	// #36 [O2M_DIAG_NOMADE].Lot2.JFF
	If lRow <= 0 Then
		lnv_Key[2].iakeyvalue = "A_RECUP_A_RECYCLER"
		F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv_Key )

		If lRow > 0 Then
			//sIdFourModif = lnv_Key[3].iakeyvalue
			sIdFourModif = string(lnv_Key[3].iakeyvalue) // #33
			sTypPresta = "EDI"
			bParticulier = True
		End If	
	End If
	// #36 [O2M_DIAG_NOMADE].Lot2.JFF	

	// [VDOC17311]
	If lRow <= 0 Then
		lnv_Key[2].iakeyvalue = "PEC_A_RECYCLER"
		F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv_Key )

		If lRow > 0 Then
			//sIdFourModif = lnv_Key[3].iakeyvalue
			sIdFourModif = string(lnv_Key[3].iakeyvalue) // #33
			sTypPresta = "EDI"
			bParticulier = True
		End If	
	End If

	If lRow <= 0 Then
		lnv_Key[2].iakeyvalue = "REFUSE_A_REEXP"
		F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv_Key )

		If lRow > 0 Then
			//sIdFourModif = lnv_Key[3].iakeyvalue
			sIdFourModif = string(lnv_Key[3].iakeyvalue) // #33
			sTypPresta = "EDI"
			bParticulier = True
		End If	
	End If
	
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 37 )
	If lDeb > 0 Then
		sTypPresta = "EDI"
		If lIdEvt <> 1083 Then
			sIdFourModif = "CDS"
		End If
	End If

	// [PM82][LOT1]
	//[ITSM127498]
	lRow3 = idwCmdeSin.Find ( "ID_TYP_ART = 'PRS' AND STATUS_GC IN ( 153, 154 ) AND COD_ETAT NOT IN ( 'RFO', 'RPC', 'ANN')", 1, idwCmdeSin.RowCount() ) 
	
	// [PM330-1][MANTIS19998] 
	If lRow3 <= 0 Then
		
		// [PM330-1][ITSM376181]
		Choose Case lIdEvt
			Case 973, 974 
				// Rien, cas CDS
			Case Else
				lRow3 = idwCmdeSin.Find ( "ID_TYP_ART = 'PRS' AND STATUS_GC IN ( 21, 23 ) AND COD_ETAT IN ( 'RFO', 'RPC', 'RSP' )", 1, idwCmdeSin.RowCount() ) 
		End Choose
	End If
	
	If lRow3 > 0 Then
		sIdFourPM82LOT1 = idwCmdeSin.GetItemString ( lRow3, "ID_FOUR" ) 
		sIdFourModif = idwCmdeSin.GetItemString ( lRow3, "ID_FOUR" ) 
	End If
	// [PM82][LOT1]
	
	// [DT288-3_LOT1_2EME_VS]
	Choose Case lIdEvt
		Case 1439 
			lRow3 = idwCmdeSin.RowCount() 	
			If lRow3 > 0 Then
				sIdFourModif = idwCmdeSin.GetItemString ( lRow3, "ID_FOUR" ) 
			End IF
	End choose 
	
	Choose Case lIdEvt
		Case 1426
			sIdFourModif = "O2M"
	End choose 
	
	// [PC874_2_V1]
	Choose Case lIdEvt
		Case 1451
			lnv_key = lnv_KeyNull
		
			lnv_Key[1].iskeyname	 ="TYP_APP"
			lnv_Key[1].iakeyvalue = isTypApp
			lnv_Key[2].iskeyname	 ="ACTION"
			lnv_Key[2].iakeyvalue = "A_CONTROLER_IMEI"
			lnv_Key[3].iskeyname	 ="FRN"				
			
			F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv_Key )
		
			If lRow > 0 Then
				sIdFourModif = string(lnv_Key[3].iakeyvalue) // #33
				sTypPresta = "EDI"
				bParticulier = True
			End If	
	End choose 

	// [HP252_276_HUB_PRESTA] [ICI]
/*
	If F_CLE_A_TRUE ( "HP252_276_HUB_PRESTA" ) Then
		If Not bPrestaExisteNonHub And ( bPrestaExisteHub Or bHubPossible ) Then
			sIdFourModif = "HUB"
		End If 
	End If 	
*/	


End If
// :#21 JFF [FNAC_PROD_ECH_TECH]				

// [PC786-2]
If sIdFourModif="SOG" Then
	
	lnv_key = lnv_KeyNull
	
	lnv_Key[1].iskeyname	 ="TYPE"
	F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP",  140, lnv_Key )
	
	if lRow > 0 Then
		If String( lnv_Key[1].iakeyvalue) = "GEM" Then
			dcMtValAchat = idwDetail.GetItemDecimal ( 1, "MT_VAL_ACHAT" )
				
			bTeleDiagOk = FALSE
			lRow2 = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'TELEDIAG_OK'", 1, idwWDivSin.RowCount () )
			If lRow2 > 0 Then 
				bTeleDiagOk = Upper ( Trim ( idwWDivSin.GetItemString ( lRow2 , "VAL_CAR" ) ) ) = "O"
			End If					
			
			If dcMtValAchat < 150 And Not bTeleDiagOk Then
			
				stMessage.sTitre		= "Commandes"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= Ok!
				stMessage.sCode		= "COMD913"
				stMessage.sVar[1]	   = "150"
			
				F_Message ( stMessage )
				
				 bAfficheMsgErreurFinal=FALSE // [PC786-2]
				 
				sIdFourModif = ""
				
			End If
		End if
	End if
End if
// [:PC786-2]

// [BLCODE]
If sIdFourModif = "BLC" Then
	
	If sIdFourModif <> "" Then

		lnv_key = lnv_KeyNull

		lnv_Key[1].iskeyname	 ="TYP_APP"
		lnv_Key[1].iakeyvalue = isTypApp
		lnv_Key[2].iskeyname	 ="ACTION"
		lnv_Key[2].iakeyvalue = "A_DIAGNOSTIQUER"
		lnv_Key[3].iskeyname	 = "FRN"
		lnv_Key[4].iskeyname	 = "MODE_BLC"
			
		// :#30 [DCMP090327].[SBETV]
		
		F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv_Key )
		If lRow > 0 Then

			Choose Case lnv_Key[4].iakeyvalue
				Case "AUCHAN_GEM"
					
					dcMtValAchat = idwDetail.GetItemDecimal ( 1, "MT_VAL_ACHAT" )
					
					bTeleDiagOk = FALSE
					lRow2 = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'TELEDIAG_OK'", 1, idwWDivSin.RowCount () )
					If lRow2 > 0 Then 
						bTeleDiagOk = Upper ( Trim ( idwWDivSin.GetItemString ( lRow2 , "VAL_CAR" ) ) ) = "O"
					End If					
					
					If dcMtValAchat < 150 And Not bTeleDiagOk Then
					
						stMessage.sTitre		= "Commandes"
						stMessage.Icon			= Information!
						stMessage.bErreurG	= FALSE
						stMessage.Bouton		= Ok!
						stMessage.sCode		= "COMD869"
						stMessage.sVar[1]	   = "150"
					
						F_Message ( stMessage )
						
						sIdFourModif = ""
						
					End If
					
			End Choose
			
		
			Choose Case lnv_Key[4].iakeyvalue
				Case "CARREFOUR_GRBB_PEM", "CARREFOUR_GRBB_GEM"
					
					dcMtValAchat = idwDetail.GetItemDecimal ( 1, "MT_VAL_ACHAT" )
					If dcMtValAchat < 150 Then
					
						stMessage.sTitre		= "Commandes"
						stMessage.Icon			= Information!
						stMessage.bErreurG	= FALSE
						stMessage.Bouton		= Ok!
						stMessage.sCode		= "COMD732"
						stMessage.sVar[1]	   = "150"
					
						F_Message ( stMessage )
						
						sIdFourModif = ""
						
					End If
					
			End Choose
		End If		
	End If
End If
// [BLCODE]


// ------ Fin du traitement des action EDI ------ //


// #38 [DCMP100104] Je recode la [DCMP080578] qui semble avoir disparue (?)
If isChoixAction = "R" And Not bShunt Then
	lRow2 = idwCmdeSin.Find ( "ID_TYP_ART='PRS'", 1 , idwCmdeSin.RowCount () ) 
	If lRow2 > 0 Then
		sIdFourModif = idwCmdeSin.GetItemString ( lRow2, "ID_FOUR" )
		lIdProcessPremierePrestaPRS= idwCmdeSin.GetItemNumber ( lRow2, "INFO_SPB_FRN" ) // [2EME_PRESTA_SAV][ITSM166882]
		// [2EME_PRESTA_SAV]
		bAutoriserSavSiFournAbsentParam = True
	End If 
End If
// #38 [DCMP100104] 

// [PM280-1]
If isChoixAction = "R" Then
	lVal1 = idwCmdeSin.Find ( &
		"ID_FOUR = 'O2M' AND " + &
		"COD_ETAT <> 'ANN' AND " + &
		"( ID_TYP_ART NOT IN ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' ) " + &
		"  OR " + &
		"  ( ID_TYP_ART = 'RST' AND POS ( INFO_SPB_FRN_CPLT, 'RST_CMDE+SUIVI=OUI' ) > 0 ) " + &
		") AND " + &
		" COD_ETAT = 'RPC' AND STATUS_GC = 178" &
		, 1, idwCmdeSin.RowCount () ) 

	If lVal1 > 0 Then
		sIdFourModif = "O2M"
	End If

End If
// [PM280-1]

// [DT288]
// [ITSM466332] Bug
If isChoixAction = "R" Then
	// SAV Cordon interdit
	// [DT401]
	If bAutoriserSavSiFournAbsentParam Then
		
		Choose Case sIdFourModif 
			Case "COR", "AAS"
				
				If sIdFourModif = "COR" Then sLibFour = "CORDON"
				If sIdFourModif = "AAS" Then sLibFour = "ADIVSE AFFINITY SERVICE"					
				
				bTestSavInterdit = True

				F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 252 )
				If lDeb > 0 Then
				
					sVal = lnvPFCString.of_getkeyvalue ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "DTE_PIVOT_DT401", ";")
					If IsNull ( sVal ) Then sVal = ""
					
					If sVal <> "" Then
						dtDtePivotDT401 = DateTime ( sVal )
						If dtCreeLeDos < dtDtePivotDT401 Then 
							bTestSavInterdit = False 
						End If 
					End IF 
				End If 
				
				IF bTestSavInterdit Then
					// [DT288][M24507]
					sFind  = "ID_FOUR = '" + sIdFourModif + "' AND ID_REF_FOUR = 'A_REPARER' AND COD_ETAT IN ( 'RPC', 'RFO') AND STATUS_GC = 2"						
			
					iFind = idwCmdeSin.find ( sFind, 1, idwCmdeSin.rowcount() ) 
					
					If iFind > 0 Then
						sIdFourModif = ""
						bSAVInterdit = TRUE
						
						stMessage.sTitre		= "DT288 : Sav interdit"
						stMessage.Icon			= information!
						stMessage.bErreurG	= FALSE
						stMessage.Bouton		= Ok!
						stMessage.sVar[1]    = sLibFour
						stMessage.sCode		= "COMD984"
						F_Message ( stMessage )
					End If
				End IF 
		End Choose
		
	Else
		If bAutoriserSavSiFournAbsentParam And sIdFourModif = "COR" Then
			// [DT288][M24507]
			sFind  = "ID_FOUR = 'COR' AND ID_REF_FOUR = 'A_REPARER' AND COD_ETAT IN ( 'RPC', 'RFO') AND STATUS_GC = 2"						
	
			iFind = idwCmdeSin.find ( sFind, 1, idwCmdeSin.rowcount() ) 
			
			If iFind > 0 Then
				sIdFourModif = ""
				bSAVInterdit = TRUE
				
				stMessage.sTitre		= "DT288 : Sav interdit avec CORDON"
				stMessage.Icon			= information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= Ok!
				stMessage.sCode		= "COMD960"
				F_Message ( stMessage )
			End If
				
		End If 	
	End If 
End If 			
	
If isChoixAction = "R" And ( Not bAutoriserSavSiFournAbsentParam OR ( sIdFourModif = "COR" )) Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 315 )
	If lDeb > 0 And lIdGti = 24 Then
		bOkPassCtrleDP315 = TRUE
		
		If lIdEvt = 1377 And isMarqPortAdh = "APPLE" Then
			sIdFourModif = ""
			bOkPassCtrleDP315 = FALSE
			stMessage.sTitre		= "DT288 : Changement de process"
			stMessage.Icon			= information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!
			stMessage.sCode		= "COMD958"
		
			F_Message ( stMessage )
		End If
		
		If lIdEvt <> 1377 And isMarqPortAdh <> "APPLE" Then
			sIdFourModif = ""
			bOkPassCtrleDP315 = FALSE
			
			/*
			stMessage.sTitre		= "DT288 : Changement de process"
			stMessage.Icon			= information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!
			stMessage.sCode		= "COMD959"
		
			F_Message ( stMessage )
			*/
		End If
	End If
End If

/*------------------------------------------------------------------*/
/* Sinon on modif le fourn par défaut.                              */
/*------------------------------------------------------------------*/

// [HP252_276_HUB_PRESTA]
If F_CLE_A_TRUE ( "HP252_276_HUB_PRESTA" ) Then
/*
	If sIdFourModif = "O2M" Then
		sIdFourModif = sIdFourO2mOuHubPresta	
	End If 
*/
	IF bPrestaExisteNonHub And Not bChoixHubFait  Then
		bChoixHubFait = True 
		// On laisse sIdFourModif tel qu'il a été initialisé
	End IF 
	
	If bPrestaExisteHub And Not bChoixHubFait Then
		bChoixHubFait = True 
		sIdFourModif = "HUB"
	End If 

	If bHubPossible And sIdFourModif = "" And Not bChoixHubFait Then
		bChoixHubFait = True 
		sIdFourModif = "HUB"
	End If 
	
	Choose Case sIdFourModif 
		Case "O2M", "BLC"
			IF bHubPossible And Not bChoixHubFait Then
			
				IF bCutOffO2M Then
					If sIdFourModif = "BLC" And sIdFourO2mOuHubPresta = "O2M" Then sIdFourO2mOuHubPresta = sIdFourModif
					sIdFourModif = sIdFourO2mOuHubPresta				
				Else 
					sIdFourModif = "HUB"				
				End IF 
				
			End If 
	End Choose 	
End If

sRech = "ID_GTI = " + sIdGti + " AND ID_CODE_FRN = '" + sIdFourModif + "' AND ID_CODE_ART = '" + sTypPresta + "' AND ID_TYP_CODE = '-XX' AND ID_CODE = -1"
lRow = idwFourn.Find ( sRech, 1, lTotRow )

// [2EME_PRESTA_SAV]
// [DT288]
If lRow <=0 And bAutoriserSavSiFournAbsentParam And Not bSAVInterdit Then
	lRow = 1
	bFournAbsent = True
End If

// La batterie est-elle sinistrée ?
// #30 [DCMP090327].[SBETV] 
// Si Pour SBETV Battsin ou Alim est cochée, alors on stoppe tout, en forçant vers le "Else".

// La batterie est-elle sinistrée ?
If sIdFourModif = "SB1" Then
	lRowBatAlim = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'BATT_SIN'", 1, idwWDivSin.RowCount () )
	If lRowBatAlim > 0 Then 
		bBattSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRowBatAlim , "VAL_LST_CAR" ) ) ) = "O"
	End If
	
	// L'alim est-elle sinistrée ?
	lRowBatAlim = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'ALIM_SIN'", 1, idwWDivSin.RowCount () )
	If lRowBatAlim > 0 Then 
		bAlimSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRowBatAlim , "VAL_LST_CAR" ) ) ) = "O"
	End If
	
	If bBattSin Or bAlimSin Then 
		lRow = 0
		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "COMD557"
	
		F_Message ( stMessage )
	End If
	
End If
// :#30 [DCMP090327].[SBETV] 

//	[MANTIS4026]
sVal = "NON"

// [PC801_MANTIS6481]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 209 )
If lDeb > 0 Then
	sVal = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "DESOX_IPHONE", ";")
	If IsNull ( sVal ) Or Trim ( sVal ) = "" Then sVal = "NON"
End If
// [PC801_MANTIS6481]	

If sVal = "NON" And lIdEvt = 1377 And Pos ( Upper ( isModlPortAdh) , "IPHONE" ) > 0 Then	
	stMessage.sCode = "WDET620"
	stMessage.icon  = Information!
	stMessage.bErreurG = False
	stMessage.bouton = Ok!
	F_Message ( stMessage )
	lRow = 0
End If
//	:[MANTIS4026]

// [BUG_IPHONE_DESOX]
// [ITSM396197] Not bAutoriserSavSiFournAbsentParam 
// [DT288]
F_RechDetPro ( lDeb2, lFin2, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 275 ) // On exclue les SFR du contrôle
If lDeb2 <=0 And &
	lIdEvt <> 1422 And &
	Not bAutoriserSavSiFournAbsentParam And &
	( &
		( isChoixAction = "R" And lIdGti = 24 And lIdEvt <> 1377 And Pos ( Upper ( isModlPortAdh) , "IPHONE" ) > 0 And sVal = "OUI" And lRowPSM > 0 ) & 
		Or &
		( isChoixAction = "R" And lIdGti = 24 And lIdEvt <> 1377 And Pos ( Upper ( isModlPortAdh) , "IPHONE" ) <= 0 And lRowPSM > 0 ) & 		
	) And &		
	Not bOkPassCtrleDP315 &
Then
	stMessage.sCode = "WDET651"
	stMessage.icon  = Information!
	stMessage.bErreurG = False
	stMessage.bouton = Ok!
	F_Message ( stMessage )
	lRow = 0
End If 
// :[BUG_IPHONE_DESOX]

// [PC151549]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 302 )
If lDeb > 0 Then
	Choose Case idwWSin.GetItemNumber ( 1, "ID_NATSIN" ) 
		Case 92, 105
			IF isTypApp <> "TEL" and isChoixAction = "R" Then
				lRow = 0 
			End If
	End Choose
	
	IF isTypApp = "MCS" and isChoixAction = "R" Then
		lRow = 0 
	End If
End If

If lRow > 0 Then

	For lCpt = 1 To lTotRow
		If idwFourn.GetItemString ( lCpt, "ID_CODE_ART" ) = sTypPresta And &
			idwFourn.GetItemString ( lCpt, "ID_TYP_CODE" ) = "-XX" And &
			idwFourn.GetItemNumber ( lCpt, "ID_CODE" ) = -1 And &
			idwFourn.GetItemNumber ( lCpt, "ID_GTI" ) = Long ( sIdGti ) Then 
	
			idwFourn.SetItem ( lCpt, "ALT_CODE_DEF", "N" )
		End If
	Next

	idwFourn.SetItem ( lRow, "ALT_CODE_DEF", "O" )			

	// [MANTIS3076][PM200]
	If sIdFourModif <> "PSM" Then
		isCodeBoutiqueCentralPSM  = ""
	Else
	
		
		// [WS_PSM]
		iRet=uf_get_btqpsm_centralisation(lIdProd, lIdSin, lIdEvt, "", sCodeBtqCentral) 
	
		If iRet=1 Then 
			isCodeBoutiqueCentralPSM = sCodeBtqCentral
		Else 
			isCodeBoutiqueCentralPSM = "33"
		End If
		
		lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_BTQ_PSM_CENTRALE", isCodeBoutiqueCentralPSM, ";")					
	End If
	// :[MANTIS3076][PM200]

	isFournParDefaut = sIdFourModif // #30 [DCMP090327].[SBETV]


// [DCMP090109]
Else
	// #2
	idwArticlePrs.Setfilter ("") 
	idwArticlePrs.filter () 
	idwArticlePrs.Rowsdiscard ( 1, idwArticlePrs.Rowcount (), Primary! )

	idwArticle.Setfilter ("") 
	idwArticle.filter () 
	idwArticle.Rowsdiscard ( 1, idwArticle.Rowcount (), Primary! )
	
	ibPbleParamFrn = True
	stMessage.sTitre		= "Commandes"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "COMD427"

	If bAfficheMsgErreurFinal Then F_Message ( stMessage ) // [PC786-2]

End If
// :[DCMP090109]


end subroutine

private function boolean uf_preparervalider_majprestao2m ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_PreparerValider_MajPrestaO2M (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 30/08/2012
//* Libellé			: 
//* Commentaires	: Validation de la commande en saisie
//* 					  [VDOC8041]
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: Boolean
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF   07/05/2013   [PC938_ORANGE_V3]
//*---------------------------------------------------------------

Boolean bRet
Long    lRow, lRelC13, lRelRdv, lStatusGc
String  sVal, sInfoSpbFrnCpltActuel
n_cst_string lnv_string

bRet = TRUE

// Recherche descendante
idwCmdeSin.Sort ()
lRow = idwCmdeSin.Find ( "ID_FOUR = 'O2M' AND ID_TYP_ART = 'PRS' AND COD_ETAT NOT IN ( 'ANN', 'RFO', 'RPC') AND STATUS_GC = 232", idwCmdeSin.Rowcount(), 1 ) 

// [PC938_ORANGE_V3]
If lRow <= 0 Then
	lRow = idwCmdeSin.Find ( "ID_FOUR IN ('O2M') AND ID_TYP_ART = 'PST' AND COD_ETAT NOT IN ( 'ANN', 'RFO', 'RPC') AND STATUS_GC IN ( 235, 236)",1,idwCmdeSin.RowCount()) 
End If

If lRow <= 0 Then
	lRow = idwCmdeSin.Find ( "ID_FOUR IN ('PSM') AND ID_TYP_ART = 'PRS' AND COD_ETAT NOT IN ( 'ANN', 'RFO', 'RPC') AND STATUS_GC IN ( 235, 236)",1,idwCmdeSin.RowCount()) 
End If

// Lecture de INFO_SPB_FRN_CPLT de la presta existante.
sInfoSpbFrnCpltActuel = Trim ( idwCmdeSin.GetItemString ( lRow, "INFO_SPB_FRN_CPLT" ))
If IsNull ( sInfoSpbFrnCpltActuel  ) Then sInfoSpbFrnCpltActuel  = ""


// DTE_HEU_RDV
sVal = Trim ( lnv_string.of_Getkeyvalue( isInfoSpbFrnCplt, "CODE_VERROU", ";") )
If IsNull ( sVal ) Then sVal = ""
If sVal <> "" Then
	lnv_string.of_setkeyvalue( sInfoSpbFrnCpltActuel, "CODE_VERROU", String ( sVal ), ";")
End If

sVal = Trim ( lnv_string.of_Getkeyvalue( isInfoSpbFrnCplt, "SECONDE_VISITE", ";") )
If IsNull ( sVal ) Then sVal = ""
If sVal <> "" Then
	lnv_string.of_setkeyvalue( sInfoSpbFrnCpltActuel, "SECONDE_VISITE", String ( sVal ), ";")
End If


// Repère de maj pour la validation
lnv_string.of_setkeyvalue( sInfoSpbFrnCpltActuel, "MAJ_PRS", "OUI", ";")

// Ecriture
// On réouvre la prestation
idwCmdeSin.SetItem ( lRow, "COD_ETAT", "CNV" )

// L'INFO_SPB_FRN est réécrit.
idwArticle.SetFilter ( "CHOIX = 'O'" )
idwArticle.Filter ( )
lStatusGc = idwArticle.GetItemNumber ( 1, "INFO_SPB_FRN" ) 
If lStatusGC > 0 Then 
	idwCmdeSin.SetItem ( lRow, "INFO_SPB_FRN", lStatusGc ) 
End If

// L'INFO_SPB_FRN_CPLT est réécrit.
idwCmdeSin.SetItem ( lRow, "INFO_SPB_FRN_CPLT", sInfoSpbFrnCpltActuel ) 

idwCmde.RowsDiscard ( 1, idwCmde.RowCount (), PRIMARY! )

This.uf_RowFocusChanged ( "DWFOURN" )
This.uf_RowFocusChanged ( "DWTYPART" )

Return bRet

end function

private function string uf_controlergestion_coriolis (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_CORIOLIS (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/07/2004
//* Libellé			: Controle Spécifique pour Coriolis
//* Commentaires	: [PC869]
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ	PAR	Date			Modification
//       JFF   03/06/2010  [PC397/443_IPAD]
//       JFF   06/01/2016  [PC13313]
//       JFF   03/09/2018  [DT361]
//*-----------------------------------------------------------------
String sPos, sNumPdv, sNom
String sAdrNom, sAdr1, sAdr2, sAdrVille, sAdrCp
Long   lRow, lDeb, lFin, lIdProd, lCodeMag, lIdSin
n_cst_string lnv_string

sPos = ""
sNumPdv = ""

lIdSin  = idwDetail.GetItemNumber ( 1, "ID_SIN" )
sNom    = idwWsin.GetItemString  ( 1, "NOM" ) + " " + idwWsin.GetItemString  ( 1, "PRENOM" ) 

// On ne fait le choix qu'une seule fois.
If ibChoixCIS_ASS Then return ""

// Pour Mobileo Pro
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 223 )
If lDeb > 0 Then 
	
	lRow = idwCmdeSin.Find ( "ID_FOUR = 'PSM' AND " + &
									 "STATUS_GC = 21 AND " + &
									 "POS ( INFO_FRN_SPB_CPLT, 'DONNEES_RECUPEREES=OUI' ) > 0 AND " + &
									 "POS ( INFO_FRN_SPB_CPLT, 'ASSURE_EN_PDV=OUI' ) > 0", 1, idwCmdeSin.RowCount() ) 
	If lRow > 0 Then
		sNumPdv = Trim ( lnv_string.of_Getkeyvalue( idwCmdeSin.GetItemString ( lRow, "INFO_FRN_SPB_CPLT" ), "NUM_PDV", ";") )
	End if
	
	If lRow <= 0 Then
		lRow = idwCmdeSin.Find ( "ID_FOUR = 'PSM' AND " + &
										 "STATUS_GC = 21 AND " + &
										 "POS ( INFO_FRN_SPB_CPLT, 'DONNEES_RECUPEREES=OUI' ) > 0 AND " + &
										 "POS ( INFO_FRN_SPB_CPLT, 'ASSURE_ENVOIE_COLIS=OUI' ) > 0", 1, idwCmdeSin.RowCount() ) 
		If lRow > 0 Then
			sNumPdv = Trim ( lnv_string.of_Getkeyvalue( idwCmdeSin.GetItemString ( lRow, "INFO_SPB_FRN_CPLT" ), "CODE_BTQ_PSM_CENTRALE", ";") )			
		End If
	End IF
	
	If sNumPDV <> "" Then
		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= YesNo!
		stMessage.sCode		= "COMD748"
	
		// 1=PSM
		If F_Message ( stMessage ) = 1 Then
			lCodeMag = Long ( sNumPDV )
			lIdProd = idwProduit.GetItemNumber ( 1, "ID_PROD" ) 
			sAdrNom = Space ( 35 ) 
			sAdr1   = Space ( 35 ) 
			sAdr2   = Space ( 35 ) 
			sAdrVille = Space ( 35 ) 
			sAdrCp = Space ( 5 ) 
			SQLCA.PS_S_BOUTIQUE_ADRESSE (lIdProd, lCodeMag, sAdrNom, sAdr1, sAdr2, sAdrVille, sAdrCP )
			
			idwCmde.SetItem ( 1, "ADR_COD_CIV"		, "5" )
			idwCmde.SetItem ( 1, "ADR_NOM"			, sAdrNom )
			idwCmde.SetItem ( 1, "ADR_PRENOM"		, String ( lIdSin ) + " " + sNom )
			idwCmde.SetItem ( 1, "ADR_LIVR1"			, sAdr1 ) 
			idwCmde.SetItem ( 1, "ADR_LIVR2"			, sAdr2 ) 
			idwCmde.SetItem ( 1, "ADR_LIVR_CPL"		, "" )
			idwCmde.SetItem ( 1, "ADR_CP"				, sAdrCP)
			idwCmde.SetItem ( 1, "ADR_VILLE"			, sAdrVille )

		End If
		
		ibChoixCIS_ASS = TRUE
		
	End If
	
End If

Return sPos

end function

private subroutine uf_gestionzone_infospbfrn_psm_2100 (ref n_cst_attrib_key alnv_key[], ref long aldefaut, ref boolean abrdvaprendre);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_Commande3::uf_GestionZone_InfoSpbFrn_PSM_2100 (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 28/11/2012
//* Libellé       : [PC877]
//* Commentaires  : 
//*
//* Arguments     : n_cst_attrib_key  alnv_key[]		Réf		// Valeur par défaut dans la zone
//*		    		  Long				  alDefaut        Réf	   // Process retenu
//*					  Boolean			  abRdvAPrendre   Réf      // TRUE : Un Rdv est à prendre.
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    13/02/2008  [FNAC_PROD_ECH_TECH].[20090213145759303]
//* #2    JFF    13/02/2008  [FNAC_PROD_ECH_TECH].[20090223142259343]
//* #3    JFF    19/05/2009  [DCMP090172]
//* #4    JFF    05/05/2009  [RUEDUCOMMERCE]
//* #5    JFF    28/07/2009  [DCMP090378]
//* #6    JFF    02/09/2009  [DCMP090327].[SBETV]
//* #7    JFF    07/10/2009  [DCMP090421]
//* #8    JFF    16/11/2009  [DCMP090421].[20091116110244950]
//* #9    JFF    18/11/2009  [DCMP090421].[20091118105631390]
//*       JFF    10/06/2010  [PC419/440/418/439_MICROMANIA]
//*       JFF    30/06/2010  [PC363_AUCHAN]
//*		 JFF    05/01/2011  [PC202].[DOM_COM]
//* 	    JFF    05/01/2011  [PC545].[POINT].[229]
//*       JFF    05/07/2011  [PC292][AUCHAN]
//*       JFF    05/07/2011  [AUCHAN].[AUCH_SITCOL_NVFRONT]
//*       JFF    12/12/2011  [VDOC4970]
//        JFF    06/08/2012  [BLCODE]
//        JFF    25/03/2013  [PC801_LOT1_V2]
//        JFF    07/05/2013  [PC938_ORANGE_V3]
//        JFF    23/01/2014  [VDOC13473]
//        JFF    08/04/2014  [PM255]
//        JFF    11/08/2014  [DT94]
//        JFF    18/06/2015  [VDOC17951]
//        JFF    15/12/2015  [DT191]
//        JFF    29/02/2016  [DT191-1]
//        JFF    25/03/2019  [DT398]
//*-----------------------------------------------------------------
stMessage.sTitre		= "Process"
Boolean bDepotFNAC, bEmbOrig, bAppSin, bAlimSin, bBattSin, bAccSin, bDepotEnvoiParAss
Boolean bRtrParTrp, bPrestaExistante, bMaterielChezPSM, bFNACEpt, bCltVIP, bEnvoiOuTeleChg, bEmbOrigOk, bAuchan
Boolean bDimSup150cm, bPoidsSup30kg, bProxiEmbOrig , bColiPrePaye, bInterDom 
String  sCTG, sNomContractant, sVal, sResidant, sResidant2
String  sModeBlc, sAdrMail
Long 	  lRow, lDeb, lFin, lCaisse, lVal, lIdEvt
n_cst_string	lnv_string
Boolean bRDCommerce // #4 [RUEDUCOMMERCE]
Boolean bMicromania // [PC419/440/418/439_MICROMANIA]
Boolean bCltFrontalier // [PC363_AUCHAN]
Boolean bCltFrontResidant1 
Boolean bDepotParAssure, bProcessScripting 
Boolean bBlCodeEnvBBPMailcour, bBlCodeEnvCartonBBP, bAssTlchrgBBPsite, bBLCODEEnvTP 
Boolean bRetRelPickUp
n_cst_string lnvPFCString
Long lCodeMag, lIdProd, lIdSin
String sAdrNom, sAdr1, sAdr2, sAdrVille, sAdrCP, sNom
String sRet 

// [PC801_LOT1_V2]
bProcessScripting = alDefaut = 2198 

lIdEvt = idwDetail.GetItemNumber ( 1, "ID_EVT" ) //  [VDOC13473]

alDefaut = 0
sResidant=""
sRet = "" 

// #6 [DCMP090327].[SBETV]
If isInfoSpbFrncplt <> "" Then
		isInfoSpbFrncplt += ";"
End If
isInfoSpbFrncplt += "MAT_SIN="	

abRdvAPrendre = FALSE

bDepotFNAC = FALSE
bEmbOrig= FALSE
bRtrParTrp = False
bAppSin = FALSE
bAlimSin = FALSE
bAccSin = FALSE
bBattSin = FALSE
bCltVIP = FALSE // #7 [DCMP090421]
bEnvoiOuTeleChg = FALSE // #7 [DCMP090421]
bCltFrontResidant1 = FALSE

isPrcBLCODE = ""

// #3 [DCMP090172]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 59 )
If lDeb > 0 Then
	sNomContractant = Trim ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ) )
Else 
	sNomContractant = ""
End If
If IsNull ( sNomContractant ) Then sNomContractant = ""
// :#3 [DCMP090172]

// L'appareil est-il sinistré ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'APP_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bAppSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

// La batterie est-elle sinistrée ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'BATT_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bBattSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

// L'alim est-elle sinistrée ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'ALIM_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bAlimSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

// [VDOC4970]
// L'Autre Accessoire est-elle sinistrée ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'AUT_ACC_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bAccSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

// La catégorie de l'appareil
sCTG = alnv_key [5].iaKeyValue

If IsNull ( sCTG ) Then sCTG = ""
sCTG = Trim ( sCTG ) 

//* #1 [FNAC_PROD_ECH_TECH].[20090213145759303]
bPrestaExistante = idwCmdeSin.Find ( "ID_FOUR = 'PSM' AND ID_TYP_ART = 'PRS' AND COD_ETAT = 'RPC'", 1, idwCmdeSin.RowCount ()) > 0 

// Bug ramené par raphelle adam et qui pertube le SAVx2 Orange V3
// Je shunte définitivement cette question
// [BUG_RAPHAELLE]
bPrestaExistante =False


If bPrestaExistante Then
	stMessage.Bouton		= YESNO!
	stMessage.Icon			= Question!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "COMD513"
	bMaterielChezPSM = f_Message ( stMessage ) = 1
End If

// Si l'appareil est sinistrée, les deux question qui suivent ont un sens.
// ITSM273445
If bAppSin Or bAccSin Then  
	isInfoSpbFrncplt += "[SIN_APP]"

	// La catégorie autorise-t-elle un dépôt chez FNAC, si oui, on pose la question uniquement pour CTG A et B
	// [DCMP090421] ajout bCltVIP

	// Déjà chez PSM
	If alDefaut = 0 And bMaterielChezPSM Then
		alDefaut = 2102
		isCodeBoutiqueProximitePSM = ""
	End If 

	// [PC801_LOT1_V2]
	If bProcessScripting Then
		lRow = idwWDivsin.Find ( "NOM_ZONE = 'process_prs'", 1, idwWDivSin.RowCount () )
		If lRow > 0 Then 
			lVal = idwWDivsin.GetItemNumber ( lRow, "VAL_NBRE" )
			
			// PC801_LOT1 NDC V5
			If Not IsNull ( lVal ) And lVal > 0 Then
				alDefaut = lVal
			Else
				alDefaut = 2110
			End IF
		End If						
			
		If lVal = 2130 Then
			lRow = idwWDivsin.Find ( "NOM_ZONE = 'btq_psm'", 1, idwWDivSin.RowCount () )
			If lRow > 0 Then 
				lVal = idwWDivsin.GetItemNumber ( lRow, "VAL_NBRE" )
				If lVal > 0 Then
					isCodeBoutiqueProximitePSM = "#" + String ( lVal ) + "#"
					lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_BTQ_PSM_PROXIMITE", isCodeBoutiqueProximitePSM , ";")
				Else
					alDefaut = 0
				End If
			End If					
		End If

		// [VDOC13473]	Oxydation		
		If lIdEvt = 1377 Then
			isCodeBoutiqueProximitePSM = ""
			lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_BTQ_PSM_PROXIMITE", isCodeBoutiqueProximitePSM , ";")
			alDefaut = 2116
		End If	
		
	End If
	
	// [PC801_LOT1_V2]
	// "EMBORIG"
	If alDefaut = 0 And alnv_Key[14].iaKeyValue <> "" Then
		If isCodeBoutiqueProximitePSM <> "" Then alDefaut = Long ( alnv_Key[14].iaKeyValue ) 
	End If
						
	// "PROXI_EMBORIG"
	If alDefaut = 0 And alnv_Key[5].iaKeyValue = "OUI" Then
		
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD755" 
	
		bProxiEmbOrig = f_Message ( stMessage ) = 1
		If bProxiEmbOrig Then alDefaut = Long ( alnv_Key[6].iaKeyValue ) 
			
	End If

	// "COLI_PREPAYE"
	If alDefaut = 0 And alnv_Key[7].iaKeyValue = "OUI" Then
		
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD756" 
	
		bColiPrePaye = f_Message ( stMessage ) = 1
		If bColiPrePaye Then alDefaut = Long ( alnv_Key[8].iaKeyValue ) 
			
	End If

	// "INTER_DOM"
	If alDefaut = 0 And alnv_Key[10].iaKeyValue = "OUI" Then

		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD763" 
	
		bInterDom = f_Message ( stMessage ) = 1
		If bInterDom Then alDefaut = Long ( alnv_Key[11].iaKeyValue ) 

	End if

	// [PC801_LOT1_V2]
	// "EMBORIG"
	If alDefaut = 0 And alnv_Key[12].iaKeyValue = "OUI" Then
		
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD774" 
	
		bEmbOrig = f_Message ( stMessage ) = 1
		If bEmbOrig Then alDefaut = Long ( alnv_Key[13].iaKeyValue ) 
			
	End If

	// [PC801_LOT1_V2]
	// "ADR_MAIL"
	If alDefaut = 0 And alnv_Key[16].iaKeyValue = "OUI" Then
		lRow = idwLstInter.Find ( "COD_INTER = 'A'", 1, idwLstInter.RowCount () )
		If lRow> 0 Then
			sAdrMail= idwLstInter.GetItemString ( lRow, "ADR_MAIL" )
			If Not IsNull ( sAdrMail ) And Trim ( sAdrMail ) <> "" Then
				alDefaut = Long ( alnv_Key[17].iaKeyValue ) 
			End If
		End If				
	End If

	// [PC938_ORANGE_V3]
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 239 ) 

	// [PC946_ORANGE_OPPRO]
	sVal = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")			

	// [DT191-1]
	// Hors ORV3 et si pas de proxi
	If lDeb <= 0 And isCodeBoutiqueProximitePSM = "" Then
		// Je ne regarde pas le process exprès, car cette question ne joue pas sur le process.
		If alnv_Key[18].iaKeyValue = "OUI" Then 
			stMessage.Bouton		= YESNO!
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "COMD936" 
			bRetRelPickUp = f_Message ( stMessage ) = 1
			
			If bRetRelPickUp  Then
				sRet = This.uf_Gestion_RelaiPickUp ()
				If sRet = "[RETOUR]" Then
					bRetRelPickUp  = False
				Else 
					lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "RET_REL_PICK_UP", "OUI", ";")
				End If
			End If
		End If			
	End If


	If lDeb > 0 And sVal = "" Then
		If alDefaut = 0 And alnv_Key[15].iaKeyValue = "OUI" And isCodeBoutiqueProximitePSM <> "" Then
			// [DT398]
			alDefaut = long (alnv_Key[4].iakeyvalue) 		
		End If

		If alDefaut = 0 And alnv_Key[15].iaKeyValue = "OUI" And isCodeBoutiqueProximitePSM = "" Then
			This.uf_zn_choix_process_Cmde_OrangeV3 ( idwArticlePrs, idwArticlePrs.GetRow (), idwArticlePrs.GetItemString ( idwArticlePrs.GetRow (), "ID_TYP_ART") , isChoixAction )
			
			Choose Case ilProcessTempo
				Case 976
					alDefaut = 2137

				Case 977
					alDefaut = 2138

				Case 978
					alDefaut = 2139
					
				Case 979
					alDefaut = 2140
					
				// [PM255]
				Case 981
					alDefaut = 2141

				// [PM255]
				Case 982
					alDefaut = 2142
				
				// [DT94]
				Case 1010
					alDefaut = 2110
				
				// [DT94] Cas du sav
				Case Else
					alDefaut = ilProcessTempo

					// [ITSM282197]
					If isBtqPsmProxiSav <> "" Then
						lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_BTQ_PSM_PROXIMITE", isBtqPsmProxiSav, ";")
					End If
					
			End Choose

			// [PM255] // [DT191] 2143
			Choose Case alDefaut 
				Case 2137 TO 2143
			
					lnvPFCString.of_setkeyvalue( isInfoSpbFrnCpltTempo, "NOM_ASS", idwWsin.GetItemString  ( 1, "NOM" ), ";")		
					lnvPFCString.of_setkeyvalue( isInfoSpbFrnCpltTempo, "PRENOM_ASS", idwWsin.GetItemString  ( 1, "PRENOM" ) , ";")
					
					lCodeMag = Long ( F_REMPLACE ( isCodeBoutiqueCentralPSM, "#", "" ) )
					lIdProd = idwProduit.GetItemNumber ( 1, "ID_PROD" ) 
					sAdrNom = Space ( 35 ) 
					sAdr1   = Space ( 35 ) 
					sAdr2   = Space ( 35 ) 
					sAdrVille = Space ( 35 ) 
					sAdrCp = Space ( 5 ) 
					SQLCA.PS_S_BOUTIQUE_ADRESSE (lIdProd, lCodeMag, sAdrNom, sAdr1, sAdr2, sAdrVille, sAdrCP )
					
					lIdSin  = idwDetail.GetItemNumber ( 1, "ID_SIN" )
					sNom    = idwWsin.GetItemString  ( 1, "NOM" ) + " " + idwWsin.GetItemString  ( 1, "PRENOM" ) 
					
					lnvPFCString.of_setkeyvalue( isInfoSpbFrnCpltTempo, "PSM_NOM1", sAdrNom, ";")		
					lnvPFCString.of_setkeyvalue( isInfoSpbFrnCpltTempo, "PSM_NOM2", String ( lIdSin ) + " " + sNom, ";")							
					lnvPFCString.of_setkeyvalue( isInfoSpbFrnCpltTempo, "PSM_ADR1", sAdr1, ";")							
					lnvPFCString.of_setkeyvalue( isInfoSpbFrnCpltTempo, "PSM_ADR2", sAdr2, ";")							
					lnvPFCString.of_setkeyvalue( isInfoSpbFrnCpltTempo, "PSM_CP", sAdrCP, ";")												
					lnvPFCString.of_setkeyvalue( isInfoSpbFrnCpltTempo, "PSM_VILLE", sAdrVille, ";")												

					lnvPFCString.of_setkeyvalue( isInfoSpbFrnCpltTempo, "PSM_IMEI_SIN", idwWsin.GetItemString  ( 1, "NUM_IMEI_PORT" ), ";")
					lnvPFCString.of_setkeyvalue( isInfoSpbFrnCpltTempo, "PSM_MARQ_SIN", idwWsin.GetItemString  ( 1, "MARQ_PORT" ), ";")
					lnvPFCString.of_setkeyvalue( isInfoSpbFrnCpltTempo, "PSM_MARQ_SIN", idwWsin.GetItemString  ( 1, "MODL_PORT" ), ";")					

			End Choose
	
		End if
	End if		

	If alDefaut = 0 Then
		alDefaut = Long ( alnv_Key[4].iaKeyValue ) // Process 
		
		Choose Case alDefaut 
			Case 2130
				If IsNull ( isCodeBoutiqueProximitePSM ) Or Len ( Trim ( isCodeBoutiqueProximitePSM )) <= 0 Then
					alDefaut = 0
				End If
				
				isCodeBoutiqueCentralPSM = ""
				lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_BTQ_PSM_CENTRALE", isCodeBoutiqueCentralPSM, ";")		
			
			Case 2120 
				
				If IsNull ( isCodeBoutiqueCentralPSM ) Or Len ( Trim ( isCodeBoutiqueCentralPSM )) <= 0 Then
					alDefaut = 0
				End If
				
				isCodeBoutiqueProximitePSM = ""
				lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_BTQ_PSM_PROXIMITE", isCodeBoutiqueProximitePSM , ";")				

			Case 2125 

				isCodeBoutiqueProximitePSM = ""
				lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_BTQ_PSM_PROXIMITE", isCodeBoutiqueProximitePSM , ";")
				
		End Choose
	
	End If
// :[PC545].[POINT].[229]
	
End If

//* #1 [FNAC_PROD_ECH_TECH].[20090213145759303]
If bMaterielChezPSM Then 
	alDefaut = 2102
End If


end subroutine

private function string uf_zn_choix_regle_psm (string ascas);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::uf_zn_choix_regle_PSM (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 29/03/2013
//* Libellé			: Regle_PSM
//* Commentaires	: [Vdoc10556]   !!!!  Prévenir ATLAS !!!! Quand cette fonction est modifié pour les Décla Orange V3.
//*
//* Arguments		: String asCas
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 		 JFF     28/05/2013 [VDOC11189]
//* 		 JFF     17/09/2013 [VDOC12178]
//*		FPI		17/06/2014	 [VDOC14687] 
//*      JFF		17/03/2015 [ITSM280888]
//*      JFF		27/07/2015 [VDOC18263][VDOC18196]
//       JFF   	03/09/2015 [VDOC18588]
//       JFF   	26/02/2016 [VDOC20021]
//*---------------------------------------------------------------

String sRet, sVal, sVal2, sValSav
Long lDeb, lFin, lCptDetPro 
n_cst_string lnvPFCString

sRet = "NON"

// [VDOC20021] Shunt définitif.
Return sRet


// Cas de règle
Choose Case asCas
	Case "MARQ/MODL"
		
		// Cas de marque
		Choose Case isMarqPortAdh
			
			Case "HTC"

				// Cas de marque
				Choose Case isModlPortAdh
				
					Case  "SENSATION", &
							"SENSATION XL", &
							"ONE X 16GO",  &
							"ONE X 32GO",  &
							"ONE X+ 64GB",  &
							"DESIRE HD",  &
							"TOUCHHD2",  &
							"WILDFIRE",  &
							"WILDFIRE S"

						sRet = "OUI"

				End Choose
/*	[VDOC12178]
			Case "LG"

				Choose Case isModlPortAdh
					
					Case 	"NEXUS 4 16GO", &
							"NEXUS 4 8GO" 

						sRet = "OUI"

				End Choose
*/

			Case "SONY"

				// Cas de marque
				Choose Case isModlPortAdh
					
					Case 	"XPERIA Z"

						sRet = "OUI"
						
					Case "XPERIA Z ULTRA", "XPERIA Z1", "XPERIA Z1 COMPACT", "XPERIA Z2"// [VDOC14687] 
							sRet = "OUI"
							
					Case "XPERIA S", "XPERIA ION" // Dem Seb
						
				End Choose

			Case "SONY ERICSSON"

				// Cas de marque
				Choose Case isModlPortAdh
					
					Case 	"XPERIA S", &
							"XPERIA ION", &
							"XPERIA PLAY"

						sRet = "OUI"

				End Choose

			Case "MOTOROLA"
				// Cas de marque
				Choose Case isModlPortAdh
					
					Case 	"RAZR", &
							"LUMIA 900", &
							"RAZR I"

						sRet = "OUI"

				End Choose

				
			Case "NOKIA"				

					// [VDOC14687] - en commentaire
					// Cas de marque
/*					Choose Case isModlPortAdh
						
						Case 	"LUMIA 820", &
								"LUMIA 900", &
								"LUMIA 920"
	
							sRet = "OUI"
	
					End Choose
*/
			
/* [VDOC11189]
			Case "SAMSUNG"
				// Cas de marque
				Choose Case isModlPortAdh
					
					Case 	"I9300 GALAXY S3 16GO", &
							"I9300 GALAXY S3 32GO"

						sRet = "OUI"

				End Choose
*/

			Case "SAMSUNG"
				Choose Case isModlPortAdh
					
					// [ITSM280888]	
					Case 	"I9600GAL-S5 16GO BLANC", "SAMSUNG GALAXY S5 G900F BLANC" ,&
							"I9600GAL-S5 16GO BLEU", "SAMSUNG GALAXY S5 G900F BLEU" ,&
							"I9600GAL-S5 16GO NOIR", "SAMSUNG GALAXY S5 G900F NOIR" ,&
							"I9600GAL-S5 16GO OR", "SAMSUNG GALAXY S5 G900F OR"

							sRet = "OUI"

				End Choose

			Case "APPLE"

					// [VDOC18263][VDOC18196]
					F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 283 )
					For lCptDetPro = lDeb To lFin
					
						sVal = idw_DetPro.GetItemString ( lCptDetPro, "VAL_CAR" ) 

						// [VDOC18588]
						/* annulé par DPG
						If F_CLE_SHUNT_A_TRUE ( "VDOC18588" ) Then
							sValSav = sVal 
							sVal = lnvPFCString.of_getkeyvalue (sValSav, "MODL", ";")
							sVal2 = lnvPFCString.of_getkeyvalue (sValSav, "QUEST_PROXI_PSM", ";")
							If sVal2 = "OUI" Then sVal = "" // Donc Pas exclu de la proxi (donc autorisé à la proxi)
						End If							
						*/
						
						If Pos ( isModlPortAdh, sVal ) > 0 Then
							sRet = "OUI"
							Exit
						End If
					Next

		End Choose
		
		
End choose

Return sRet
end function

private subroutine uf_selectionautomatique_pret_standard ();//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande3::uf_selectionautomatique_pret_standard (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 16/05/2010 14:04:43
//* Libellé       : Sélection automatique 
//* Commentaires  : [PC938_ORANGE_V3]
//*
//* Arguments     : 	String		asIdFour		Val
//*					  	String		asFiltre		Val
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//        JFF    08/04/2014   [PM255]
//        JFF    08/04/2014   [VDOC15185]
//        JFF    15/12/2015   [DT191]
//        JFF    23/01/2017   [DT290]
//*-----------------------------------------------------------------

Long	lDeb, lFin, lCpt, lTotRow, lRowFournOrig, lRowFournRech, lCoche, lIdEvt, lRow1, lRow2, lRow3
String	sFiltreOrig, sSortOrig, sIdFour

lRow1 =  idwCmdeSin.Find("ID_FOUR IN ('O2M') AND ID_TYP_ART = 'PST' AND COD_ETAT NOT IN ( 'ANN', 'RFO', 'RPC') AND STATUS_GC IN ( 235, 236)",1,idwCmdeSin.RowCount()) 
lRow2 =	idwCmdeSin.Find("ID_FOUR IN ('PSM') AND ID_TYP_ART = 'PRS' AND COD_ETAT NOT IN ( 'ANN', 'RFO', 'RPC') AND STATUS_GC IN ( 235, 236)",1,idwCmdeSin.RowCount()) 
lRow3 =  idwCmdeSin.Find("POS ( INFO_SPB_FRN_CPLT, 'SECONDE_VISITE=') >0",1,idwCmdeSin.RowCount()) 

If Not gProcessTempoOrangeV3 And ( ( lRow1 > 0 Or lRow2 > 0 ) And lRow3 <= 0 ) Then
	gProcessTempoOrangeV3 = TRUE
	gProcessTempoOrangeV3Action = TRUE
End If
	
If Not gProcessTempoOrangeV3 Then Return

/*------------------------------------------------------------------*/
/* On sauve le filtre original.                                     */
/*------------------------------------------------------------------*/
sFiltreOrig = idwArticle.Describe ("DataWindow.Table.filter") 
If sFiltreOrig = "?" Then sFiltreOrig = ""

sSortOrig = idwArticle.Describe ("DataWindow.Table.Sort") 
If sSortOrig = "?" Then sSortOrig = ""

/*------------------------------------------------------------------*/
/* On ne sélectionne les mobiles que si l'événement choisi est un   */
/* événement de remplacement. pour tout autre type d'evt, on        */
/* ressort.                                                         */
/*------------------------------------------------------------------*/
lIdEvt = idwDetail.GetItemNumber ( 1, "ID_EVT" )
Choose Case lIdEvt 
	Case 1396
		// Ok
	Case Else
		Return
End choose

/*------------------------------------------------------------------*/
/* On n'applique cette sélection que pour les mobiles que propose   */
/* DARTY.                                                           */
/*------------------------------------------------------------------*/
// [DT191]
idwArticle.SetFilter ( "ID_TYP_ART = 'PST'" )
idwArticle.Filter ( )

/*------------------------------------------------------------------*/
/* On Coche les trois premiers mobiles (au plus)                    */
/*------------------------------------------------------------------*/
If idwArticle.RowCount () > 0 Then
	idwArticle.SetItem ( 1, "CHOIX", "O" )
	This.uf_Zn_Choix ( iDwArticle, "O", 1 )	

	idwArticle.SetItem ( 1, "INFO_SPB_FRN", ilProcessTempo )
	isInfoSpbFrnCplt = isInfoSpbFrnCpltTempo

	Choose Case ilProcessTempo 
		Case 976, 978 
			
		// [PM255] // [DT191] // [DT290]
		Case 981, 982, 2143, 984
		
			stMessage.sTitre		= "Commandes"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!
			stMessage.sCode		= "COMD860"
	
			F_Message ( stMessage )
			
		
	End Choose


End If

// #1 Suppression des autres articles pour éviter les erreus
idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount(), Filter! )


/*------------------------------------------------------------------*/
/* On replace le filtre d'origine.                                  */
/*------------------------------------------------------------------*/
This.uf_RowFocusChanged ( "DWFOURN" ) 

idwArticle.SetFilter ( sFiltreOrig  )
idwArticle.Filter ()
idwArticle.SetSort ( sSortOrig  )
idwArticle.Sort ()



end subroutine

private subroutine uf_gestionzone_infospbfrn_o2m_prs (ref long aldefaut);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_Commande3::uf_GestionZone_InfoSpbFrn_O2M_PRS (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 21/05/2013	
//* Libellé       : 
//* Commentaires  : [PC938_ORANGE_V3]
//*
//* Arguments     : 
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//       JFF   02/06/2014 [PC929_CDISCOUNT][PC929-2-V3]
//*-----------------------------------------------------------------

Long lDeb, lFin
String sVal
n_cst_string lnvPFCString

// [PC946][MANTIS8006]

F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 239 ) 

// [PC946_ORANGE_OPPRO]
If lDeb > 0 Then
	sVal = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")			

	If lDeb > 0 And sVal = "" Then
	
		This.uf_zn_choix_process_Cmde_OrangeV3 ( idwArticlePrs, idwArticlePrs.GetRow (), idwArticlePrs.GetItemString ( idwArticlePrs.GetRow (), "ID_TYP_ART") , isChoixAction )
		alDefaut = ilProcessTempo
	
	End If 
End If

// [PC929_CDISCOUNT][PC929-2-V3]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 235 )
If lDeb > 0 Then
	If lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "TVSUP32P", ";") = "OUI" Then
		Choose Case isTypApp
			Case "TL7", "TLO", "TPS"  // Les TV >= 32 pouces
				alDefaut = 955
		End Choose
	End If
End If

end subroutine

private subroutine uf_preparervalider_presta_suppl (string ascasprestasuppl, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_sinistre_wdetail::uf_PreparerValider_Presta_Suppl (PRIVATE)
//* Auteur        : JFF
//* Date          : 22/05/2013	
//* Libellé       : 
//* Commentaires  : [PC938_ORANGE_V3]
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//       JFF   07/04/2015 [PC13442-1]
//       JFF   18/12/2018 [PM471-1]
//*-----------------------------------------------------------------

Long lTot, lCpt, lRow, lDeb, LFin
Long lCodeMag, lIdProd, lIdSin, lVal1
String sAdrMail, sAdrNom, sAdr1, sAdr2, sAdrVille, sAdrCP, sNom, sVar2
n_cst_string	lnv_string
String sChaine

Choose Case asCasPrestaSuppl
	Case "DIAG/980", "DIAG/980_MBZ2"

		// [DT124]
		lnv_string.of_setkeyvalue( sChaine, "MARQUE", isMarqPortAdh, ";")
		lnv_string.of_setkeyvalue( sChaine, "MODELE", isModlPortAdh, ";")
		// [DT124]

		// [PM471-1]
		idwArticle.Retrieve ( idwWSin.GetItemNumber ( 1, "ID_PROD" ), sChaine ) //#5
		idwArticle.SetFilter ( "ID_FOUR = 'O2M' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER'" )
		idwArticle.Filter ()
		
		If idwArticle.Rowcount () > 0 Then
			idwArticle.SetItem ( 1, "CHOIX", "O" )
			idwArticle.SetItem ( 1, "INFO_SPB_FRN", 980 )									
		End If

		lCpt = alRow

		idwCmde.SetItem ( lCpt, "ID_FOUR"		, idwArticle.GetItemString ( 1, "ID_FOUR" ) )
		idwCmde.SetItem ( lCpt, "ID_TYP_ART"	, idwArticle.GetItemString ( 1, "ID_TYP_ART" ) )
		idwCmde.SetItem ( lCpt, "ID_MARQ_ART"	, idwArticle.GetItemString ( 1, "ID_MARQ_ART" ) )
		idwCmde.SetItem ( lCpt, "ID_MODL_ART"	, idwArticle.GetItemString ( 1, "ID_MODL_ART" ) )
		idwCmde.SetItem ( lCpt, "ID_SERIE_ANC"	, idwArticle.GetItemString ( 1, "ID_SERIE_ANC" ) )
		idwCmde.SetItem ( lCpt, "PROBLEME"		, idwArticle.GetItemString ( 1, "PROBLEME" ) )

		// #6 Pour les commandes Web, on place la valeur du plafond dans 
		If Left ( idwArticle.GetItemString ( lCpt, "ID_FOUR" ), 2 ) = "WB" Then
			idwCmde.SetItem ( lCpt, "MT_TTC_CMDE", idcMtPlafcmdeWeb )
		// #10 [FNAC_PROD_ECH_TECH].[BGE].[20091027112156767] // [PC363_AUCHAN]
		ElseIf idwArticle.GetItemString ( lCpt, "ID_TYP_ART" ) = "CAF" Then
			// Pas de cmde Web, mais idcMtPlafcmdeWeb contient tout simplement le mt_pec.
			idwCmde.SetItem ( lCpt, "MT_TTC_CMDE", idcMtPlafcmdeWeb )		
		Else
			idwCmde.SetItem ( lCpt, "MT_TTC_CMDE", idwArticle.GetItemDecimal ( 1, "MT_PRIX_TTC" ) )
		End If
	
		/*------------------------------------------------------------------*/
		/* Modification SFR # le 04/10/02 : Ajout des colonnes              */
		/* supplémentaires (dte_ret_pret reste à null)				           */
		/*------------------------------------------------------------------*/
		idwCmde.SetItem ( lCpt, "ID_BSP"				, 0 )
		idwCmde.SetItem ( lCpt, "ID_REF_FOUR"		, idwArticle.GetItemString ( 1, "ID_REF_FOUR" ) )

		// #6 Pour les commandes Web, on place la valeur du plafond dans 
		If Left ( idwArticle.GetItemString ( lCpt, "ID_FOUR" ), 2 ) = "WB" Then
			idwCmde.SetItem ( lCpt, "ID_ORIAN_MARQUE"	, 1 )
		Else
			idwCmde.SetItem ( lCpt, "ID_ORIAN_MARQUE"	, 0 )
		End If 

		idwCmde.SetItem ( lCpt, "ID_ORIAN_MODELE"	, 0 )
   /*----------------------------------------------------------------------*/
   /* #4    MADM  16/02/2006   DCMP 050532 : Ajout de 2 colonnes à la Table*/
   /*          Commande (id_marq_art_ifr,id_modl_art_ifr)                  */
   /*----------------------------------------------------------------------*/
   idwCmde.SetItem ( lCpt, "ID_MARQ_ART_IFR"	, idwArticle.GetItemString ( 1, "ID_MARQ_IFR" ) )
   idwCmde.SetItem ( lCpt, "ID_MODL_ART_IFR"	, idwArticle.GetItemString ( 1, "ID_MODL_IFR" ) )

	idwCmde.SetItem ( lCpt, "INFO_SPB_FRN"	, 980)
	
	//* #1 [FNAC_PROD_ECH_TECH]
	idwCmde.SetItem ( lCpt, "INFO_SPB_FRN_CPLT", "MAT_SIN=[SIN_APP]"  )
	
	// [PC13442-1]
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 274	)
	If lDeb > 0 Then
		
		// [VDOC20810]
		idwCmde.SetItem ( lCpt, "INFO_SPB_FRN"	, 912)
		
		idwCmde.SetItem ( lCpt, "PROBLEME", "En attente d'envoi éventuel d'une boutique MOBISTORE si le dossier est accepté. S'il est accepté, la boutique enverra l'appareil à SPBS pour un Diag de principe uniquement, le matériel aura déjà été remplacé en boutique." )

		lCodeMag = idwWsin.GetItemNumber ( 1, "ID_ORIAN_BOUTIQUE" )
		lIdProd = idwProduit.GetItemNumber ( 1, "ID_PROD" ) 
		sAdrMail = Space ( 35 ) 
		sAdrNom = Space ( 35 ) 
		sAdr1   = Space ( 35 ) 
		sAdr2   = Space ( 35 ) 
		sAdrVille = Space ( 35 ) 
		sAdrCp = Space ( 5 ) 

		SQLCA.PS_S_BOUTIQUE_ADRESSE_2 (lIdProd, lCodeMag, sAdrMail, sAdrNom, sAdr1, sAdr2, sAdrVille, sAdrCP )
		
		lIdSin  = idwDetail.GetItemNumber ( 1, "ID_SIN" )
		sNom    = idwWsin.GetItemString  ( 1, "NOM" ) + " " + idwWsin.GetItemString  ( 1, "PRENOM" ) 
		
		idwCmde.SetItem ( lCpt, "ADR_COD_CIV"		, "5" )
		idwCmde.SetItem ( lCpt, "ADR_NOM"			, sAdrNom )
		idwCmde.SetItem ( lCpt, "ADR_PRENOM"		, String ( lIdSin ) + " " + sNom )
		idwCmde.SetItem ( lCpt, "ADR_LIVR1"			, sAdr1 ) 
		idwCmde.SetItem ( lCpt, "ADR_LIVR2"			, sAdr2 ) 
		idwCmde.SetItem ( lCpt, "ADR_LIVR_CPL"		, "" )
		idwCmde.SetItem ( lCpt, "ADR_CP"				, sAdrCP)
		idwCmde.SetItem ( lCpt, "ADR_VILLE"			, sAdrVille )

		sVar2 = Trim ( idwCmde.GetItemString ( lCpt, "INFO_SPB_FRN_CPLT" ) )
		
		lnv_string.of_Setkeyvalue ( sVar2, "ADR_MAIL_MAG", sAdrMail, ";")
		idwCmde.SetItem ( lCpt, "INFO_SPB_FRN_CPLT", sVar2 )


	End If

End Choose 

return
end subroutine

private subroutine uf_selectionautomatique_restit_pret_ant ();//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande3::uf_selectionautomatique_restit_pret_ant (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 16/05/2010 14:04:43
//* Libellé       : Sélection automatique 
//* Commentaires  : [PC938_ORANGE_V3]
//*
//* Arguments     : 	String		asIdFour		Val
//*					  	String		asFiltre		Val
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//        JFF   02/12/2013   [PC938-1_V1]
//*-----------------------------------------------------------------

Long	lDeb, lFin, lCpt, lTotRow, lRowFournOrig, lRowFournRech, lCoche, lIdEvt, lRow1, lRow2, lRow3, lRow4
String	sFiltreOrig, sSortOrig, sAdrMail
Boolean bConsAppPretVol

lIdEvt = idwDetail.GetItemNumber ( 1, "ID_EVT" )

If lIdEvt <> 1398 Then
	Return
End If

// PC938_ORV3_M8086
lRow1 = idwCmdeSin.Find("ID_FOUR IN ('O2M') AND ID_GTI IN ( 10, 24, 11 ) AND POS ( INFO_SPB_FRN_CPLT, 'TYP_RELAI=PRET') > 0 AND STATUS_GC IN ( 262, 233 ) AND COD_ETAT NOT IN ( 'ANN' )",1,idwCmdeSin.RowCount()) 
lRow2 = idwCmdeSin.Find("ID_FOUR IN ('PSM') AND ID_GTI IN ( 10, 24, 11 ) AND ID_TYP_ART = 'REL' AND COD_ETAT NOT IN ( 'ANN') ",1,idwCmdeSin.RowCount()) 
lRow3 = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'CONS_APPPRETVOL'", 1, idwWDivSin.RowCount () )


If lRow3> 0 Then 
	bConsAppPretVol = Upper ( Trim ( idwWDivSin.GetItemString ( lRow3, "VAL_LST_CAR" ) ) ) = "O"
End If	

If Not ( lRow1 > 0 And lRow2 <= 0 And Not bConsAppPretVol ) Then

	idwArticle.RowsDisCard ( 1, idwArticle.RowCount(), Primary! )

	stMessage.sTitre		= "Commandes"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "COMD810"

	F_Message ( stMessage )

	Return
End If
	
/*------------------------------------------------------------------*/
/* On sauve le filtre original.                                     */
/*------------------------------------------------------------------*/
sFiltreOrig = idwArticle.Describe ("DataWindow.Table.filter") 
If sFiltreOrig = "?" Then sFiltreOrig = ""

sSortOrig = idwArticle.Describe ("DataWindow.Table.Sort") 
If sSortOrig = "?" Then sSortOrig = ""

/*------------------------------------------------------------------*/
/* On n'applique cette sélection que pour les mobiles que propose   */
/* DARTY.                                                           */
/*------------------------------------------------------------------*/
idwArticle.SetFilter ( "ID_TYP_ART = 'RES'" )
idwArticle.Filter ( )

/*------------------------------------------------------------------*/
/* On Coche les trois premiers mobiles (au plus)                    */
/*------------------------------------------------------------------*/
If idwArticle.RowCount () > 0 Then
	idwArticle.SetItem ( 1, "CHOIX", "O" )
	This.uf_Zn_Choix ( iDwArticle, "O", 1 )	

	// [PC938-1_V1]
	lRow4= idwLstInter.Find ( "COD_INTER = 'A'", 1, idwLstInter.RowCount () )
	If lRow4> 0 Then
		sAdrMail= idwLstInter.GetItemString ( lRow4, "ADR_MAIL" )
		If IsNull ( sAdrMail ) OR Trim ( sAdrMail ) = "" Then
			idwArticle.SetItem ( 1, "INFO_SPB_FRN", 910 )		
		Else
			idwArticle.SetItem ( 1, "INFO_SPB_FRN", 912 )		
		End If
	End If		

End If

// #1 Suppression des autres articles pour éviter les erreus
idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount(), Filter! )


/*------------------------------------------------------------------*/
/* On replace le filtre d'origine.                                  */
/*------------------------------------------------------------------*/
This.uf_RowFocusChanged ( "DWFOURN" ) 

idwArticle.SetFilter ( sFiltreOrig  )
idwArticle.Filter ()
idwArticle.SetSort ( sSortOrig  )
idwArticle.Sort ()



end subroutine

private subroutine uf_selectionautomatique_recup_app_sin ();//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande3::uf_selectionautomatique_recup_app_sin (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 16/05/2010 14:04:43
//* Libellé       : Sélection automatique 
//* Commentaires  : [PC938_ORANGE_V3]
//*
//* Arguments     : 	String		asIdFour		Val
//*					  	String		asFiltre		Val
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//       JFF   02/12/2013 [PC938-1_V1]
//*-----------------------------------------------------------------

Long	lDeb, lFin, lCpt, lTotRow, lRowFournOrig, lRowFournRech, lCoche, lIdEvt, lRow1, lRow2, lRow3, lRow4
String	sFiltreOrig, sSortOrig, sAdrMail
Boolean bConsAppPretVol

lIdEvt = idwDetail.GetItemNumber ( 1, "ID_EVT" )

If lIdEvt <> 1410 Then
	Return
End If

lRow1 = idwCmdeSin.Find("ID_FOUR IN ('O2M') AND ID_GTI IN ( 11, 24 ) AND POS ( INFO_SPB_FRN_CPLT, 'TYP_RELAI=PRET') > 0 ",1,idwCmdeSin.RowCount()) 
lRow2 = idwCmdeSin.Find("ID_FOUR IN ('O2M') AND ID_GTI IN ( 11, 24 ) AND ID_TYP_ART = 'PRS'",1,idwCmdeSin.RowCount()) 


If Not ( lRow1 <= 0 And lRow2 <= 0 ) Then
	idwArticle.RowsDisCard ( 1, idwArticle.RowCount(), Primary! )

	stMessage.sTitre		= "Commandes"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "COMD814"

	F_Message ( stMessage )

	Return
End If
	
/*------------------------------------------------------------------*/
/* On sauve le filtre original.                                     */
/*------------------------------------------------------------------*/
sFiltreOrig = idwArticle.Describe ("DataWindow.Table.filter") 
If sFiltreOrig = "?" Then sFiltreOrig = ""

sSortOrig = idwArticle.Describe ("DataWindow.Table.Sort") 
If sSortOrig = "?" Then sSortOrig = ""

/*------------------------------------------------------------------*/
/* On n'applique cette sélection que pour les mobiles que propose   */
/* DARTY.                                                           */
/*------------------------------------------------------------------*/
idwArticle.SetFilter ( "ID_TYP_ART = 'REA'" )
idwArticle.Filter ( )

/*------------------------------------------------------------------*/
/* On Coche les trois premiers mobiles (au plus)                    */
/*------------------------------------------------------------------*/
If idwArticle.RowCount () > 0 Then
	idwArticle.SetItem ( 1, "CHOIX", "O" )
	This.uf_Zn_Choix ( iDwArticle, "O", 1 )	
	
	// [PC938-1_V1]
	lRow4= idwLstInter.Find ( "COD_INTER = 'A'", 1, idwLstInter.RowCount () )
	If lRow4> 0 Then
		sAdrMail= idwLstInter.GetItemString ( lRow4, "ADR_MAIL" )
		If IsNull ( sAdrMail ) OR Trim ( sAdrMail ) = "" Then
			idwArticle.SetItem ( 1, "INFO_SPB_FRN", 910 )		
		Else
			idwArticle.SetItem ( 1, "INFO_SPB_FRN", 912 )		
		End If
	End If		
	
End If

// #1 Suppression des autres articles pour éviter les erreus
idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount(), Filter! )


/*------------------------------------------------------------------*/
/* On replace le filtre d'origine.                                  */
/*------------------------------------------------------------------*/
This.uf_RowFocusChanged ( "DWFOURN" ) 

idwArticle.SetFilter ( sFiltreOrig  )
idwArticle.Filter ()
idwArticle.SetSort ( sSortOrig  )
idwArticle.Sort ()



end subroutine

private function string uf_controlergestionedi_psm (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestionEdi_PSM (PRIVATE)
//* Auteur			: PHG
//* Date				: 10/12/2007
//* Libellé			: Controler Spécifique pour O2M
//* Commentaires	: [O2M]Controle de Gestion pour le fournisseur O2M
//*
//* Arguments		: Long		aalCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//* #1	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
//* #2	PHG	23/06/2009	[O2M_DIAG_NOMADE]
//* #3	JFF	07/08/2009	[O2M_DIAG_NOMADE].[JFF].[20090807133737597]
//* #4	JFF	07/08/2009	[O2M_DIAG_NOMADE].[JFF].[20090901100945950]
//* #5	PHG	04/01/2010	[02M_DIAG_NOMADE].Lot2  : Point 4, paragraphe 2 et 3.
//* #6	PHG	14/01/2009  [O2M_DIAG_NOMADE].lot2 : Point 6, paragraphe 1.
//* #7   JFF   15/01/2010  [O2M_DIAG_NOMADE].Lot2.JFF
//* #8	PHG	20/10/2010  [O2M_DIAG_NOMADE].lot2 : On prends que la première adr mail de la boutique.
//* #9   JFF   02/03/2010  [MSS_LOT2]
//* --   JFF   07/04/2010  [PC384].[CDISCOUNT]
//*      JFF   21/03/2010  [VDOC3433]
//*      JFF   19/04/2010  [PM72] Modif demandée par Nathalie le 21 Mars 2011
//*      JFF   01/09/2011  [PC10][DIAG_NOMADE]
//		FPI	15/09/2011	[PC413-1] Evolution DP 37
//*      JFF   19/09/2011  [PM82][LOT1]
//*      JFF   12/12/2011  [VDOC4970]
//*      JFF   05/01/2012  [RECUP_DONNEE_O2M]
//       JFF   06/08/2012  [BLCODE]
//       JFF   11/02/2013  [PC896_CDISCOUNT]	
//       JFF   11/02/2013  [PC913_CDISCOUNT][MANTIS6654]
//       JFF   19/02/2013	[VDOC9304_PM82_LOT1]
//       JFF   02/04/2013  [PC929_CDISCOUNT]
//       JFF   11/09/2013  [PC929_CDISCOUNT][MANTIS8652]
//       JFF   02/10/2014 [VDOC15485]
//       JFF   23/02/2016 [PM330-1][MANTIS19998]
//       JFF   01/10/2018 [PM445-1]
//       JFF   05/12/2019 [VDOC28734]
//*-----------------------------------------------------------------

String sPos, sFiltreOrig1, sFiltreOrig2, sIdTypArt, sIdRefFour, sCodModeReg, sValCar, sDiagO2M, sDiagMBS, sIdFour, sLibEvt  
String sLibArt, sCodeArt, sRefMat, sVal1 
Long lTot, lRow, lInfoSpbFrn,lIdProd, lTot1, lCpt, lIddetail, lVal1
Long lDeb, lFin //#2 
Decimal{2}   dcMtValAchat 
Boolean bRibVide, bModeForcagePRS, bModeForcageDiag
n_cst_string lnv_string
datawindowchild dwchild // #5	PHG [02M_DIAG_NOMADE].Lot2
long lVal // #5	PHG [02M_DIAG_NOMADE].Lot2
long lPos // #8 PHG [02M_DIAG_NOMADE].Lot2
string sAdrMailBoutique, sVal, sTypApp
Long lIdGti
String sSkuIfr
String sCodeBoutiqueCentralPSM_PrestaPrec 
String sCodeBoutiqueProximitePSM_PrestaPrec 

// [BLCODE]
sIdFour = upper(string(idwArticle.object.id_four[alCpt]))


stMessage.sCode = ""
sPos = ""

lIdGti = idwDetail.GetItemNumber ( 1, "ID_GTI" )
sIdRefFour 	= Upper ( idwArticle.GetItemString ( alCpt, "ID_REF_FOUR" ) )
lIdProd 		= idwWsin.GetItemNumber ( 1, "ID_PROD" )
lInfoSpbFrn = idwArticle.object.info_spb_frn[alCpt]

sIdTypArt = idwArticle.GetItemString ( alCpt, "ID_TYP_ART" ) 	
If sIdTypArt <> "EDI" Then Return ""


// [PM82][LOT1]
bModeForcagePRS = idwCmdeSin.Find ( "ID_TYP_ART = 'PRS' AND STATUS_GC IN ( 153, 154 ) AND COD_ETAT NOT IN ( 'RFO', 'RPC', 'ANN')", 1, idwCmdeSin.RowCount() )  > 0
// [PM82][LOT1]

// [PM330-1][MANTIS19998] 
If Not bModeForcagePRS Then
	bModeForcagePRS = idwCmdeSin.Find ( "ID_TYP_ART = 'PRS' AND STATUS_GC IN ( 21, 23 ) AND COD_ETAT IN ( 'RFO', 'RPC', 'RSP' )", 1, idwCmdeSin.RowCount() ) > 0 
End If

// [PM445-1]
If Not bModeForcagePRS Then		
	bModeForcagePRS = idwDetail.GetItemNumber ( 1, "ID_EVT" ) = 1439
End If

// [VDOC9304_PM82_LOT1]
// [VDOC15485]
bModeForcageDiag = False


// #4 [O2M_DIAG_NOMADE].[JFF].[20090901100945950]
If idwDetail.GetItemNumber ( 1, "ID_EVT" ) <> 1083 And Not bModeForcagePRS Then
	stMessage.sCode = "COMD817" 
	stMessage.bouton = Ok!
	F_Message ( stMessage )
	sPos = "ALT_CHOIX"
	Return "G" + "ALT_CHOIX"
End If
// :#4 [O2M_DIAG_NOMADE].[JFF].[20090901100945950]			


// #2 [O2M_DIAG_NOMADE] 1/
// Si le Appareil Non paramétré sur Option DP/95 => Message Bloquant : "Pour ce produit, ce type d'appareil ne rentre pas dans ce process"
// [PM82][LOT1]
// [VDOC9304_PM82_LOT1]
If Not bModeForcagePRS And Not bModeForcageDiag Then
	// [MANTIS8652]
	Choose Case sIdRefFour
		Case "A_DIAGNOSTIQUER"
	
			if idw_DetPro.Find(   "ID_PROD="+ string(lIdProd) +                         &
										" AND ID_CODE_DP=209" +                                 &
										" AND POS(VAL_CAR, 'ACTION="+sIdRefFour+";', 1)>0" +   &
										" AND POS(VAL_CAR, 'TYP_APP="+isTypApp+";', 1)>0"       &
										, 1, idw_DetPro.rowCount()+1) = 0 Then
				stMessage.sCode = "COMD531" // [O2M_DIAG_NOMADE] Message : "Ce type d'appareil ne rentre pas dans ce process"
				stMessage.bouton = Ok!
				F_Message ( stMessage )
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"
			End If 
		Case Else
				// ON laisse passer, pas de param, sinon pose problème avec la 209 qui ne fonctionne pas comme la 95
	End Choose
	
	// [O2M].372, Note 265, Point 1 : On vérifie que l'action choisie est cohérente avec le paramétrage du produit
	if idw_DetPro.Find(	"ID_PROD="+ string(lIdProd) + 								&
								" AND POS(VAL_CAR, 'ACTION="+sIdRefFour+";', 1)>0" + 	&
								" AND POS(VAL_CAR, 'TYP_APP="+isTypApp+";', 1)>0"		&
								, 1, idw_DetPro.rowCount()+1) = 0 Then
		stMessage.sCode = "COMD463" // Msg : "Information Cochée non autorisée pour ce produit.@Veuillez sélectionner une autre information."
		stMessage.bouton = Ok!
		F_Message ( stMessage )
		sPos = "ALT_CHOIX"
		Return "G" + "ALT_CHOIX"
	End If
End If

// [PC10][DIAG_NOMADE]	


// #2 [O2M_DIAG_NOMADE] 2/
// -Si Produit CD-discount + Fourn O2M + Action A diagnostiquer + Val Achat < 200 Euro
//  Interdiction de process => Process interdit pour les valeurs d'achat strictement inférieures  200 Euro


// [PM82][LOT1]
If bModeForcagePRS Then
	Choose Case sIdRefFour
		// [PM445-1]
		Case "REFUSE_A_REEXP", "A_REPARER_FORCE", "A_DESOXYDER_FORCE", "NE_PAS_REMPLACER", "A_REMPLACER"
			
			// Ok on a le droit
		Case Else
			stMessage.sCode = "COMD669" 
			stMessage.bouton = Ok!
			sPos = "ALT_CHOIX"
			F_Message ( stMessage )
			Return "G" + "ALT_CHOIX"

	End Choose
Else 
	Choose Case sIdRefFour
		Case "A_REPARER_FORCE", "A_DESOXYDER_FORCE"
			stMessage.sCode = "COMD670" 
			stMessage.bouton = Ok!
			F_Message ( stMessage )
			sPos = "ALT_CHOIX"
			Return "G" + "ALT_CHOIX"

	End Choose
End If
// [PM82][LOT1]

// [VDOC9304_PM82_LOT1]
If bModeForcageDiag Then
	Choose Case sIdRefFour
		Case "REFUSE_A_REEXP", "A_DIAG_FORCE"
			// Ok on a le droit
		Case Else
			stMessage.sCode = "COMD773" 
			stMessage.bouton = Ok!
			sPos = "ALT_CHOIX"
			F_Message ( stMessage )
			Return "G" + "ALT_CHOIX"

	End Choose
Else 
	Choose Case sIdRefFour
		Case "A_DIAG_FORCE"
			stMessage.sCode = "COMD670" 
			stMessage.bouton = Ok!
			F_Message ( stMessage )
			sPos = "ALT_CHOIX"
			Return "G" + "ALT_CHOIX"

	End Choose
End If		
// [VDOC9304_PM82_LOT1]


Choose Case sIdRefFour 
	Case "A_DIAGNOSTIQUER"
//		if idwCmdeSin.RowCount() > 0 then //[O2M].391 : On ignore toute prestation annulée
		if idwCmdeSin.Find( "COD_ETAT <>'ANN'", 1, idwCmdeSin.RowCount() + 1 ) > 0 then
			stMessage.sCode = "COMD456" // [O2M] : Message : Vous choisissez un flux de DIAGNOSTIQUE alors que d'autres prestations existent déjà sur le dossier, êtes vous sûr de votre choix ?
			stMessage.bouton = YesNo!
			if F_Message ( stMessage ) <> 1 Then
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"
			End If
		// [O2M].381 : Vérification qu'il n'y a pas de diagnostic déja émis et clos.
		ElseIf idwCmdeSin.Find("ID_FOUR IN ('O2M', 'BLC') AND ID_REF_FOUR<>'A_DIAGNOSTIQUER'", 1, idwCmdeSin.RowCount()+1 ) > 0 Then
			stMessage.sCode = "COMD464" // [O2M] : Message : Vous avez déjà émis un ou plusieurs flux de clôture avec O2M sur ce dossier.@Souhaitez-vous vraiment émettre un flux demandant un diagnostique ?"
			stMessage.bouton = YesNo!
			if F_Message ( stMessage ) <> 1 Then
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"

			End If
// [FNAC_PROD_ECH_TECH].[20090330152547023]			
		End If

		//	[VDOC15533]
		sSkuIfr = Space ( 35 )
		SQLCA.PS_S_SKU_IFR ( isMarqPortAdh, isModlPortAdh, sSkuIfr )
		If IsNull ( sSkuIfr ) Then sSkuIfr = ""
		
		lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "SKU_IFR", sSkuIfr, ";")

		// [BLCODE]
		Choose Case sIdFour

			Case "PSM"	
				This.uf_message_process_PSM( alCpt, lInfoSpbFrn )
		End Choose
		
// :[FNAC_PROD_ECH_TECH].[20090330152547023]			

	case "PEC_A_RECYCLER", "REFUSE_A_REEXP"

		// [VDOC28734]
		lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_BTQ_PSM_CENTRALE", "", ";")
		lnv_string.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_BTQ_PSM_PROXIMITE", "", ";")
		
		isInfoSpbFrnCplt = F_REMPLACE ( isInfoSpbFrnCplt, "CODE_BTQ_PSM_CENTRALE=", "" )
		isInfoSpbFrnCplt = F_REMPLACE ( isInfoSpbFrnCplt, "CODE_BTQ_PSM_PROXIMITE=", "" )	
		isInfoSpbFrnCplt = F_REMPLACE ( isInfoSpbFrnCplt, ";;", ";" )
		If Trim ( isInfoSpbFrnCplt ) = ";" Then isInfoSpbFrnCplt = ""

	// [PM445-1]
	Case "NE_PAS_REMPLACER"
		lVal = idwCmdeSin.Find ( &
				"ID_REF_FOUR IN ( 'A_REPARER', 'A_DESOXYDER', 'A_DIAGNOSTIQUER' ) AND " + &
				"ISNULL ( DTE_RCP_FRN ) AND LEN ( ID_BON_TRANSP ) > 0 AND " + &
				"POS ( INFO_FRN_SPB_CPLT, 'PRBLE_LIVRAISON' ) > 0 AND " + &
				"POS ( INFO_FRN_SPB_CPLT, 'PERTE_ALLER' ) > 0 AND " + &
				"COD_ETAT IN ( 'ECT', 'ECL' )", &
				1, idwCmdeSin.RoWCount () )
	
		If lVal > 0 Then 
	
			lVal = idwCmdeSin.GetItemNumber ( lVal, "ID_SEQ" )
			
			lVal = idwCmdeSin.Find ( &
					"( ID_TYP_ART NOT IN ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' ) " + &
					"  OR " + &
					"  ( ID_TYP_ART = 'RST' AND POS ( INFO_SPB_FRN_CPLT, 'RST_CMDE+SUIVI=OUI' ) > 0 ) " + &
					") " + &
					" AND ( STATUS_GC NOT IN ( 176 ) AND COD_ETAT <> 'ANN' ) " + &
					" AND ID_SEQ > " + String ( lVal ) &					
					, 1, idwCmdeSin.RowCount ()) 			
					
			lVal1 = idwLstDetail.Find ( "ID_I_REG = 0 AND COD_ETAT IN ( 500, 600 )", 1, idwLstDetail.RowCount() )

			If lVal <= 0 And lVal1 <= 0 Then
				stMessage.sCode = "COMD976"
				stMessage.bouton = YESNO!
				stMessage.icon  = Exclamation!
				If F_Message ( stMessage ) = 2 Then
					sPos = "ALT_CHOIX"
					Return "G" + "ALT_CHOIX"		
				End If 
		   End IF
		End If			

			
			
	// [PM445-1]
	Case "A_REMPLACER"
		
		lVal = idwCmdeSin.Find ( &
				"ID_REF_FOUR IN ( 'A_REPARER', 'A_DESOXYDER', 'A_DIAGNOSTIQUER' ) AND " + &
				"ISNULL ( DTE_RCP_FRN ) AND LEN ( ID_BON_TRANSP ) > 0 AND " + &
				"POS ( INFO_FRN_SPB_CPLT, 'PRBLE_LIVRAISON' ) > 0 AND " + &
				"POS ( INFO_FRN_SPB_CPLT, 'PERTE_ALLER' ) > 0 AND " + &
				"COD_ETAT IN ( 'ECT', 'ECL' )", &
				1, idwCmdeSin.RoWCount () )
	
		If lVal > 0 Then 
	
			lVal = idwCmdeSin.GetItemNumber ( lVal, "ID_SEQ" )

			//					" AND CPT_VALIDE > 0" +  &
			lVal = idwCmdeSin.Find ( &
					"( ID_TYP_ART NOT IN ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' ) " + &
					"  OR " + &
					"  ( ID_TYP_ART = 'RST' AND POS ( INFO_SPB_FRN_CPLT, 'RST_CMDE+SUIVI=OUI' ) > 0 ) " + &
					") " + &
					" AND ( STATUS_GC NOT IN ( 176 ) AND COD_ETAT <> 'ANN' ) " + &
					" AND ID_SEQ > " + String ( lVal ) &					
					, 1, idwCmdeSin.RowCount ()) 			
					
			lVal1 = idwLstDetail.Find ( "ID_I_REG = 0 AND COD_ETAT IN ( 500, 600 )", 1, idwLstDetail.RowCount() )

			If lVal > 0 Or lVal1 > 0 Then
				stMessage.sCode = "COMD977"
				stMessage.bouton = OK!
				stMessage.icon  = Exclamation!
				F_Message ( stMessage )

				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"		

		   End IF
		End If			
		
		
End Choose

Return sPos

end function

public subroutine uf_message_process_psm (long alrow, long alinfospbfrn);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::uf_message_process_PSM
//* Auteur			: Pierre-Henri Gillot
//* Date				: 18/12/2007 17:34:39
//* Libellé			: 
//* Commentaires	: [O2M] Affiche les message de PRocess O2M au gestionnaire
//*					  en fonction de l'info_spb_frn selectionnée
//*
//* Arguments		: 
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF	20/10/2008	  [FNAC_PROD_ECH_TECH]
//* #2    JFF  13/02/2008    [FNAC_PROD_ECH_TECH].[20090223142259343]
//* #3    JFF  13/02/2008    [FNAC_PROD_ECH_TECH].[20090224144248310]
//* #4    JFF  30/03/2009    [FNAC_PROD_ECH_TECH].[20090330152547023]
//* #5    JFF  23/04/2009    [LCL_NOMADE]
//* #6    JFF  19/05/2009    [DCMP090172]
//* #7    JFF  05/05/2009    [RUEDUCOMMERCE]
//* #8    JFF  05/05/2009    [DCMP090298]
//* #9    JFF  07/10/2009    [DCMP090421]
//* #10   JFF  25/11/2009    [MSS_DIAG]
//* 		 FPI	08/04/2010	  [DMDI28280] Taille S->M
//*  	    JFF	13/04/2010    [ADRESSE_O2M]
//*       JFF  10/06/2010    [PC419/440/418/439_MICROMANIA]
//*		 JFF  05/01/2011    [PC202].[DOM_COM]
//*       JFF  22/06/2011    [PC545].[POINT].[255]
//*       JFF  05/07/2011    [AUCHAN].[AUCH_SITCOL_NVFRONT]
//*       JFF  12/12/2011    [VDOC4970]
//*       JFF  05/01/2012    [RECUP_DONNEE_O2M]
//*       JFF  29/08/2012    [VDOC7524]
//*       JFF  13/11/2012    [VDOC9057]
//        JFF  26/11/2012    [PC877]
//*       JFF  17/01/2013    [PC913]
//*       JFF  02/04/2013    [PC929_CDISCOUNT]
// 		FPI	27/02/2015		[VDOC16821] On se base sur le cp de l'assuré ald la caisse
//*-----------------------------------------------------------------

string sCodMSg, sMtFrais, sCommentaireFrais, sIdRefFour
String sVar[], sVal
String sNumCmde, sAction, sTypApp, sTaillecoli, sNomContractant, sPc74
String sAppSin, sAlimSin, sBattSin, sAccSin //  [FNAC_PROD_ECH_TECH]
String sNomLigne1, sNomLigne2, sAdrLigne1, sAdrLigne2, sCP, sVille, sAdresseO2m	
decimal{2} dcMtFrais
Boolean bPc441 // Pièce facture d'achat&Reglt cotisation.
Boolean bPc74  // Copie bulletion adhésion
Boolean bRDCommerce // #7 [RUEDUCOMMERCE]
Boolean bFNACEpt  //* #8 [DCMP090298]
Boolean bMicromania // [PC419/440/418/439_MICROMANIA]
Boolean bCRCA_Pacifica, bDomCom // [PC202].[DOM_COM]
Boolean bAuchan
Boolean bOrangeV3

long	lRow, lDeb, lFin, lCaisse
Long lIdGti 
n_cst_attrib_key	lnv_key[], lnv2_key[]
n_cst_string	lnv_string
n_cst_string   lnvPFCString
n_cst_cmd_commun	lnvCmdCommun

dcMtFrais = -1
sMtFrais = ""
sTaillecoli = ""
sCommentaireFrais = ""

// [RECUP_DONNEE_O2M]
sIdRefFour 	= Upper ( idwArticle.GetItemString ( alRow, "ID_REF_FOUR" ) )

// [AUCH_SITCOL_NVFRONT]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 140 )
bAuchan = lDeb > 0 

// [ADRESSE_O2M]
lIdGti = idwDetail.GetItemNumber ( 1, "ID_GTI" )

// #6 [DCMP090172]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 59 )
If lDeb > 0 Then
	sNomContractant = Trim ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ) )
Else 
	sNomContractant = ""
End If
If IsNull ( sNomContractant ) Then sNomContractant = ""
// :#6 [DCMP090172]

//* #7 [RUEDUCOMMERCE]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 114 )
bRDCommerce = lDeb > 0
//* :#7 [RUEDUCOMMERCE]

// [PC419/440/418/439_MICROMANIA]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 137 )
bMicromania = lDeb > 0
// [PC419/440/418/439_MICROMANIA]

//* #8 [DCMP090298]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 105 )
bFNACEpt = lDeb > 0
//* :#8 [DCMP090298]

//  [PC202].[DOM_COM]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 138 )
bCRCA_Pacifica = lDeb > 0

bDomCom = False
If bCRCA_Pacifica Then
	// [VDOC16821] On se base sur le cp de l'assuré ald la caisse
		
	sVal=idwCmde.GetItemString(1,"ADR_CP")
	if Len(trim(sVal)) = 5 Then 
		sVal=Left(sVal,3)
	Else 
		sVal=""
	End if
	
	Choose case sVal
		Case "971","972","973","974","975","976","984","986","987","988"
		//(971) Guadeloupe 
		// (972) Martinique 
		// (973) Guyane 
		// (974) La Réunion 
		// (975) Saint-Pierre-et-Miquelon 
		// (976) Mayotte 
		// (984) Terres Australes et Antarctiques 
		// (986) Wallis et Futuna 
		// (987) Polynésie Française 
		// (988) Nouvelle-Calédonie 
			bDomCom = True
	End choose
End If
//  [PC202].[DOM_COM]

//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
// Facture d'achat de l'appareil garantie
bPc441 = idwWpieceGti.Find ( "ALT_RECLAME = 'O' AND ID_PCE = 441", 1, idwWpieceGti.RowCount () ) > 0

//* #4    JFF  30/03/2009    [FNAC_PROD_ECH_TECH].[20090330152547023]
bPc74 = idwWpieceGti.Find ( "ALT_RECLAME = 'O' AND ID_PCE = 74", 1, idwWpieceGti.RowCount () ) > 0
If bPc74 Then
	sPc74 = "- Le bulletin d'adhésion"
	//* #7 [RUEDUCOMMERCE].[CRTEST1]
	If bRDCommerce Then
		sPc74 = "- La copie du certificat d'adhésion"					
	End If
	//* #7 [RUEDUCOMMERCE].[CRTEST1]				
Else
	sPc74 = ""
End If

sCodMsg = ""

if idwWsin.rowCount() > 0 Then
	sNumCmde	= string(idwWsin.object.id_sin[1])+"-"+string(uf_nouveau_num_sequence( ))

	// L'appareil est-il sinistré ?
	sAppSin = "NON"
	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'APP_SIN'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then 
		If Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" Then
			sAppSin = "OUI"
		End If
	End If
	
	// La batterie est-elle sinistrée ?
	sBattSin = "NON"
	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'BATT_SIN'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then 
		If Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" Then
			sBattSin = "OUI"
		End IF
	End If
	
	// L'alim est-elle sinistrée ?
	sAlimSin = "NON"
	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'ALIM_SIN'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then 
		If Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" Then
			sAlimSin = "OUI"
		End If
	End If

	// Un autre accessoire est-il sinistré ?
	// [VDOC4970]	
	sAccSin = "NON"
	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'AUT_ACC_SIN'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then 
		If Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" Then
			sAccSin = "OUI"
		End If
	End If	
	
	// [RECUP_DONNEE_O2M]
	Choose Case sIdRefFour 
		Case "A_DIAGNOSTIQUER", "DONNER_A_RECUPERER"
			sAction = sIdRefFour 
		Case Else
			sAction = ""
	End Choose
	sTypApp	= isTypApp

	// #1 JFF [FNAC_PROD_ECH_TECH]				
	// Cas particulier : si batt ext ou alim ext, on passe en process identique à B donc mt_frais d'une catégorie B
	// [VDOC4970]
	If sBattSin = "OUI" Or sAlimSin = "OUI" Or sAccSin = "OUI" Then
		lnv2_Key[1].iskeyname  = "CTG"
		lnv2_Key[1].iakeyvalue = "B"
		lnv2_Key[2].iskeyname	 ="ACTION"
		lnv2_Key[2].iakeyvalue = sAction
		lnv2_Key[3].iskeyname  ="MT_FRAIS"		
		F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv2_Key )
	End If
	// :#1 JFF [FNAC_PROD_ECH_TECH]				
	
	lnv_Key[1].iskeyname	 ="TYP_APP"
	lnv_Key[1].iakeyvalue =sTypApp
	lnv_Key[2].iskeyname	 ="ID_COUR"
	lnv_Key[3].iskeyname	 ="ACTION"
	lnv_Key[3].iakeyvalue = sAction
	lnv_Key[4].iskeyname	 ="PROCESS"

	// #1 JFF [FNAC_PROD_ECH_TECH]				
	lnv_Key[5].iskeyname	 ="CTG"
	lnv_Key[6].iskeyname	 ="EMBORG"
	lnv_Key[7].iskeyname	 ="PROCESS_EMBORG"
	lnv_Key[8].iskeyname	 ="DEPOT_FNAC"
	lnv_Key[9].iskeyname	 ="PROCESS_FNAC"
	lnv_Key[10].iskeyname ="FRN"
	lnv_Key[11].iskeyname ="MT_FRAIS"
	lnv_Key[12].iskeyname ="CPLT_ADR_FRN_PROD"	
	//* #5 [LCL_NOMADE]
	lnv_Key[13].iskeyname ="TAILLE_COLI"	
	
	// :#1 JFF [FNAC_PROD_ECH_TECH]				

	F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv_Key )


	if lRow > 0 Then
		// [VDOC4970]
		If sBattSin = "OUI" Or sAlimSin = "OUI" Or sAccSin = "OUI" Then		
			If IsNumber ( lnv2_Key[3].iakeyvalue ) Then // #1 JFF [FNAC_PROD_ECH_TECH]	
				dcMtFrais = dec (lnv2_Key[3].iakeyvalue)
			// #1 JFF [FNAC_PROD_ECH_TECH]	
			Else 
				sMtFrais = lnv2_Key[3].iakeyvalue
			End If
	
		Else
		
			If IsNumber ( lnv_Key[11].iakeyvalue ) Then // #1 JFF [FNAC_PROD_ECH_TECH]	
				dcMtFrais = dec (lnv_Key[11].iakeyvalue)
			// #1 JFF [FNAC_PROD_ECH_TECH]	
			Else 
				sMtFrais = lnv_Key[11].iakeyvalue
			End If
			// :#1 JFF [FNAC_PROD_ECH_TECH]				
		End If

		//* #7 [RUEDUCOMMERCE].[CRTEST1]
		If bRDCommerce Then
			sCommentaireFrais += " (Si envoi depuis la France)"
		End If
		//* #7 [RUEDUCOMMERCE].[CRTEST1]				

		//  [PC202].[DOM_COM]
		If bCRCA_Pacifica and bDomcom Then
			sCommentaireFrais += " Maximum"
		End If
		//  [PC202].[DOM_COM]

		//* #5 [LCL_NOMADE]
		If lnv_Key[13].iakeyvalue <> "" And Not IsNull ( lnv_Key[13].iakeyvalue ) Then
			sTaillecoli = lnv_Key[13].iakeyvalue
		End If
		
	End If

	choose Case alInfoSpbFrn

		case 2130
			// [PC929_CDISCOUNT]
			sCodMsg = "COMD806"		
			sVar[1] = sNumCmde							
				
	End choose

End If

stMessage.scode = sCodMsg
stMessage.sVar = sVar

If stMessage.scode <> "" Then
	F_Message(stMessage)
End If
//* :#8 [DCMP090298]



end subroutine

private function string uf_controlergestion_sbetv (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_SBETV (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/07/2004
//* Libellé			: Controle Spécifique pour SBE
//* Commentaires	: DCMP 040206/040291 : Controle spéciale pour SBE en fonction de la 
//*					  liste -IF
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	JCA	26/12/2006	DCMP 060907 - Changement de l'appel à F_Determiner_Montant_Frais_Envoi
//*									ajout des arguments alidprod (Val), adwdetpro (Ref), adcFrais (Ref)
//		 	FPI	24/06/2010 [DCMP100551] Modification de l'option 76
//*-----------------------------------------------------------------

String sPos, sProbleme, sCodModeReg, sCodMsg, sVar [], sPc74, sNumCmde, sNomContractant 
Long lInfoSpbFrn, lDeb, lFin
Dec {2} dcFrais //#1
Boolean bRibVide, bPc441, bPc74

sPos = ""

/*------------------------------------------------------------------*/
/* Si au moins une prestation vers SBE est détectée                 */
/* ET sur laquelle la zone info_spb_frn est égale à 210  (client    */
/* envoi son mobile)                                                */
/* ET que la méthode de règlement et " VA "                         */
/* ET que le RIB est vide                                           */
/* ALORS afficher un message :                                      */
/*------------------------------------------------------------------*/

lInfoSpbFrn = idwArticle.GetItemNumber ( alCpt, "INFO_SPB_FRN" ) 
idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "1" )

bPc441 = idwWpieceGti.Find ( "ALT_RECLAME = 'O' AND ID_PCE = 441", 1, idwWpieceGti.RowCount () ) > 0

//* #4    JFF  30/03/2009    [FNAC_PROD_ECH_TECH].[20090330152547023]
bPc74 = idwWpieceGti.Find ( "ALT_RECLAME = 'O' AND ID_PCE = 74", 1, idwWpieceGti.RowCount () ) > 0
If bPc74 Then
	sPc74 = "- Le bulletin d'adhésion"
Else
	sPc74 = ""
End If

sNumCmde	= string(idwWsin.object.id_sin[1])+"-"+string(uf_nouveau_num_sequence( ))

F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 59 )
If lDeb > 0 Then
	sNomContractant = Trim ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ) )
Else 
	sNomContractant = ""
End If
If IsNull ( sNomContractant ) Then sNomContractant = ""



Choose Case lInfoSpbFrn

	Case 	1112
		sCodMsg = "COMD819"		

		If bPc441 Then
			sVar[1] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
		Else
			sVar[1] = ""
		End If

		sVar[2] = sPc74
		
		sVar[3] = sNumCmde
			
End Choose

If sCodMsg <> "" Then
	stMessage.scode = sCodMsg
	stMessage.sVar = sVar

	F_Message(stMessage)
End If


Return sPos

end function

public subroutine uf_message_process_o2m (long alrow, long alinfospbfrn);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::uf_message_process_o2m
//* Auteur			: Pierre-Henri Gillot
//* Date				: 18/12/2007 17:34:39
//* Libellé			: 
//* Commentaires	: [O2M] Affiche les message de PRocess O2M au gestionnaire
//*					  en fonction de l'info_spb_frn selectionnée
//*
//* Arguments		: 
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF	20/10/2008	  [FNAC_PROD_ECH_TECH]
//* #2    JFF  13/02/2008    [FNAC_PROD_ECH_TECH].[20090223142259343]
//* #3    JFF  13/02/2008    [FNAC_PROD_ECH_TECH].[20090224144248310]
//* #4    JFF  30/03/2009    [FNAC_PROD_ECH_TECH].[20090330152547023]
//* #5    JFF  23/04/2009    [LCL_NOMADE]
//* #6    JFF  19/05/2009    [DCMP090172]
//* #7    JFF  05/05/2009    [RUEDUCOMMERCE]
//* #8    JFF  05/05/2009    [DCMP090298]
//* #9    JFF  07/10/2009    [DCMP090421]
//* #10   JFF  25/11/2009    [MSS_DIAG]
//* 		 FPI	08/04/2010	  [DMDI28280] Taille S->M
//*  	    JFF	13/04/2010    [ADRESSE_O2M]
//*       JFF  10/06/2010    [PC419/440/418/439_MICROMANIA]
//*		 JFF  05/01/2011    [PC202].[DOM_COM]
//*       JFF  22/06/2011    [PC545].[POINT].[255]
//*       JFF  05/07/2011    [AUCHAN].[AUCH_SITCOL_NVFRONT]
//*       JFF  12/12/2011    [VDOC4970]
//*       JFF  05/01/2012    [RECUP_DONNEE_O2M]
//*       JFF  29/08/2012    [VDOC7524]
//*       JFF  13/11/2012    [VDOC9057]
//        JFF  26/11/2012    [PC877]
//*       JFF  17/01/2013    [PC913]
//*       JFF  02/04/2013    [PC929_CDISCOUNT]
//        JFF  30/12/2013    [PC13348&13408]
//			FPI 02/07/2014		[PC14503].Mantis11633
//		FPI	11/07/2014 [VDOC14882]
//       JFF   02/02/2015 [DT122]
//		FPI	27/02/2015 [VDOC16821] On se base sur le cp de l'assuré ald la caisse
//       JFF   09/04/2015 [DT141]
//       JFF   10/06/2015 [PM280-1][MANTIS15456]
//       JFF   30/06/2015 [DT156]
// 		JFF 	31/07/2015 [DT168][MANTIS16641]
// 		JFF 	01/10/2015 [VDOC15705]
//       JFF   29/02/2016 [DT191-1]
//       JFF   17/05/2016 [PM280-2]
// 		FPI	15/07/2016 [VDOC21247]
//       JFF   02/01/2019 [MANTIS29738][PM453-1]
//       JFF   15/05/2019 [DT386_EXTR_AXA]
//*-----------------------------------------------------------------
string sCodMSg, sMtFrais, sCommentaireFrais, sIdRefFour, sIdFour
String sVar[]
String sNumCmde, sAction, sTypApp, sTaillecoli, sNomContractant, sPc74
String sAppSin, sAlimSin, sBattSin, sAccSin //  [FNAC_PROD_ECH_TECH]
String sNomLigne1, sNomLigne2, sAdrLigne1, sAdrLigne2, sCP, sVille, sAdresseO2m
String sIdTypArt, sVal
decimal{2} dcMtFrais
Boolean bPc441 // Pièce facture d'achat&Reglt cotisation.
Boolean bPc74  // Copie bulletion adhésion
Boolean bRDCommerce // #7 [RUEDUCOMMERCE]
Boolean bFNACEpt  //* #8 [DCMP090298]
Boolean bMicromania // [PC419/440/418/439_MICROMANIA]
Boolean bCRCA_Pacifica, bDomCom // [PC202].[DOM_COM]
Boolean bAuchan
Boolean bOrangeV3
Boolean bCdsBricoPro // [PC14503].Mantis11633
Boolean bSouplessePacifica // [DT122]
Boolean bARepGti // [PM280-1][MANTIS15456]
Boolean bBuyBackAXA // [DT386_EXTR_AXA]

long	lRow, lDeb, lFin, lCaisse
Long lIdGti 
n_cst_attrib_key	lnv_key[], lnv2_key[]
n_cst_string	lnv_string
n_cst_string   lnvPFCString
n_cst_cmd_commun	lnvCmdCommun

dcMtFrais = -1
sMtFrais = ""
sTaillecoli = ""
sCommentaireFrais = ""

// [RECUP_DONNEE_O2M]
sIdRefFour 	= Upper ( idwArticle.GetItemString ( alRow, "ID_REF_FOUR" ) )

// [PC13321]
sIdTypArt   = Upper ( idwArticle.GetItemString ( alRow, "ID_TYP_ART" ) )

// [PC13348&13408]
sIdFour     = Upper ( idwArticle.GetItemString ( alRow, "ID_FOUR" ) )

// [AUCH_SITCOL_NVFRONT]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 140 )
bAuchan = lDeb > 0 

// [ADRESSE_O2M]
lIdGti = idwDetail.GetItemNumber ( 1, "ID_GTI" )

// [PM280-1][MANTIS15456]
bARepGti = lnvPFCString.of_Getkeyvalue( isInfoSpbFrnCplt, "A_REP_GARANTIE", ";" ) = "OUI"

// #6 [DCMP090172]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 59 )
If lDeb > 0 Then
	sNomContractant = Trim ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ) )
Else 
	sNomContractant = ""
End If
If IsNull ( sNomContractant ) Then sNomContractant = ""
// :#6 [DCMP090172]

//* #7 [RUEDUCOMMERCE]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 114 )
bRDCommerce = lDeb > 0
//* :#7 [RUEDUCOMMERCE]

// [PC419/440/418/439_MICROMANIA]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 137 )
bMicromania = lDeb > 0
// [PC419/440/418/439_MICROMANIA]

//* #8 [DCMP090298]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 105 )
bFNACEpt = lDeb > 0
//* :#8 [DCMP090298]

// [PC14503]
bCdsBricoPro =FALSE
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 37 )
If ldeb > 0 Then
	If lnv_string.of_getkeyvalue( idw_DetPro.GetItemString(lDeb,"VAL_CAR") , "VARIANTE", ";") = "BRICO_JARDI" Then
		bCdsBricoPro =TRUE
	End if
End if
// :[PC14503]

//  [PC202].[DOM_COM]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 138 )
bCRCA_Pacifica = lDeb > 0

// [DT122]
bSouplessePacifica = FALSE
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 269 )
bSouplessePacifica = lDeb > 0 

// [DT386_EXTR_AXA]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 335 )
bBuyBackAXA = lDeb > 0 


bDomCom = False
If bCRCA_Pacifica Then
	// [VDOC16821] On se base sur le cp de l'assuré ald la caisse
	sVal=idwCmde.GetItemString(1,"ADR_CP")
	if Len(trim(sVal)) = 5 Then 
		sVal=Left(sVal,3)
	Else 
		sVal=""
	End if
	
	Choose case sVal
		Case "971","972","973","974","975","976","984","986","987","988"
			//(971) Guadeloupe 
			// (972) Martinique 
			// (973) Guyane 
			// (974) La Réunion 
			// (975) Saint-Pierre-et-Miquelon 
			// (976) Mayotte 
			// (984) Terres Australes et Antarctiques 
			// (986) Wallis et Futuna 
			// (987) Polynésie Française 
			// (988) Nouvelle-Calédonie 
			bDomCom = True
	End choose
End If

//  [PC202].[DOM_COM]

//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
// Facture d'achat de l'appareil garantie
bPc441 = idwWpieceGti.Find ( "ALT_RECLAME = 'O' AND ID_PCE = 441", 1, idwWpieceGti.RowCount () ) > 0

//* #4    JFF  30/03/2009    [FNAC_PROD_ECH_TECH].[20090330152547023]
bPc74 = idwWpieceGti.Find ( "ALT_RECLAME = 'O' AND ID_PCE = 74", 1, idwWpieceGti.RowCount () ) > 0
If bPc74 Then
	sPc74 = "- Le bulletin d'adhésion"
	//* #7 [RUEDUCOMMERCE].[CRTEST1]
	If bRDCommerce Then
		sPc74 = "- La copie du certificat d'adhésion"					
	End If
	//* #7 [RUEDUCOMMERCE].[CRTEST1]				
Else
	sPc74 = ""
End If


if idwWsin.rowCount() > 0 Then
	sNumCmde	= string(idwWsin.object.id_sin[1])+"-"+string(uf_nouveau_num_sequence( ))

	// L'appareil est-il sinistré ?
	sAppSin = "NON"
	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'APP_SIN'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then 
		If Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" Then
			sAppSin = "OUI"
		End If
	End If
	
	// La batterie est-elle sinistrée ?
	sBattSin = "NON"
	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'BATT_SIN'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then 
		If Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" Then
			sBattSin = "OUI"
		End IF
	End If
	
	// L'alim est-elle sinistrée ?
	sAlimSin = "NON"
	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'ALIM_SIN'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then 
		If Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" Then
			sAlimSin = "OUI"
		End If
	End If

	// Un autre accessoire est-il sinistré ?
	// [VDOC4970]	
	sAccSin = "NON"
	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'AUT_ACC_SIN'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then 
		If Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O" Then
			sAccSin = "OUI"
		End If
	End If	
	
	// [RECUP_DONNEE_O2M]
	// [DT168][MANTIS16641]
	// [PM280-2]
	Choose Case sIdRefFour 
		Case "A_DIAGNOSTIQUER", "DONNER_A_RECUPERER", "A_REPARER", "A_DESOXYDER", "CONTEST_SUR_REMPL"
			sAction = sIdRefFour 
		Case Else
			sAction = ""
	End Choose
	sTypApp	= isTypApp

	// #1 JFF [FNAC_PROD_ECH_TECH]				
	// Cas particulier : si batt ext ou alim ext, on passe en process identique à B donc mt_frais d'une catégorie B
	// [VDOC4970]
	If sBattSin = "OUI" Or sAlimSin = "OUI" Or sAccSin = "OUI" Then
		lnv2_Key[1].iskeyname  = "CTG"
		lnv2_Key[1].iakeyvalue = "B"
		lnv2_Key[2].iskeyname	 ="ACTION"
		lnv2_Key[2].iakeyvalue = sAction
		lnv2_Key[3].iskeyname  ="MT_FRAIS"		
		F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv2_Key )
	End If
	// :#1 JFF [FNAC_PROD_ECH_TECH]				
	
	lnv_Key[1].iskeyname	 ="TYP_APP"
	lnv_Key[1].iakeyvalue =sTypApp
	lnv_Key[2].iskeyname	 ="ID_COUR"
	lnv_Key[3].iskeyname	 ="ACTION"
	lnv_Key[3].iakeyvalue = sAction
	lnv_Key[4].iskeyname	 ="PROCESS"

	// #1 JFF [FNAC_PROD_ECH_TECH]				
	lnv_Key[5].iskeyname	 ="CTG"
	lnv_Key[6].iskeyname	 ="EMBORG"
	lnv_Key[7].iskeyname	 ="PROCESS_EMBORG"
	lnv_Key[8].iskeyname	 ="DEPOT_FNAC"
	lnv_Key[9].iskeyname	 ="PROCESS_FNAC"
	lnv_Key[10].iskeyname ="FRN"
	lnv_Key[11].iskeyname ="MT_FRAIS"
	lnv_Key[12].iskeyname ="CPLT_ADR_FRN_PROD"	
	//* #5 [LCL_NOMADE]
	lnv_Key[13].iskeyname ="TAILLE_COLI"	
	
	// :#1 JFF [FNAC_PROD_ECH_TECH]				

	F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 95, lnv_Key )

	// [MANTIS29738][PM453-1]
	If Not IsValid ( lnv_Key[5].iakeyvalue ) Then lnv_Key[5].iakeyvalue = "Non paramétré" 

	if lRow > 0 Then
		// [VDOC4970]
		If sBattSin = "OUI" Or sAlimSin = "OUI" Or sAccSin = "OUI" Then		
			If IsNumber ( lnv2_Key[3].iakeyvalue ) Then // #1 JFF [FNAC_PROD_ECH_TECH]	
				dcMtFrais = dec (lnv2_Key[3].iakeyvalue)
			// #1 JFF [FNAC_PROD_ECH_TECH]	
			Else 
				sMtFrais = lnv2_Key[3].iakeyvalue
			End If
	
		Else
		
			If IsNumber ( lnv_Key[11].iakeyvalue ) Then // #1 JFF [FNAC_PROD_ECH_TECH]	
				dcMtFrais = dec (lnv_Key[11].iakeyvalue)
			// #1 JFF [FNAC_PROD_ECH_TECH]	
			Else 
				sMtFrais = lnv_Key[11].iakeyvalue
			End If
			// :#1 JFF [FNAC_PROD_ECH_TECH]				
		End If

		//* #7 [RUEDUCOMMERCE].[CRTEST1]
		If bRDCommerce Then
			sCommentaireFrais += " (Si envoi depuis la France)"
		End If
		//* #7 [RUEDUCOMMERCE].[CRTEST1]				

		//  [PC202].[DOM_COM]
		If bCRCA_Pacifica and bDomcom Then
			sCommentaireFrais += " Maximum"
		End If
		//  [PC202].[DOM_COM]

		//* #5 [LCL_NOMADE]
		If lnv_Key[13].iakeyvalue <> "" And Not IsNull ( lnv_Key[13].iakeyvalue ) Then
			sTaillecoli = lnv_Key[13].iakeyvalue
		End If
		
	End If

// [ADRESSE_O2M]
// [VDOC9057] "A_DIAGNOSTIQUER",&
// [VDOC14882]
lnvCmdCommun.uf_GetAdresseO2M_2 ( &
	"", &
	sIdRefFour,&
	alInfoSpbFrn, &
	sTypApp,&
	sIdTypArt,&
	"CNV",&
	lIdGti,&
	ismodlportadh , &
	isInfoSpbFrnCplt,&
	idwCmdeSin,&
	idwWDivSin,&
	idw_DetPro,& 
	idwWsin.GetItemNumber ( 1, "ID_PROD" ),&
	sNomLigne1,&
	sNomLigne2,& 
	sAdrLigne1,& 
	sAdrLigne2,&
	sCP,&
	sVille )
// :[VDOC14882]

	sAdresseO2m	= ""
	If Not IsNull ( sNomLigne1 ) And Len ( sNomLigne1 ) > 0 Then sAdresseO2m += sNomLigne1 + Char ( 13 ) 
	If Not IsNull ( sNomLigne2 ) And Len ( sNomLigne2 ) > 0 Then sAdresseO2m += sNomLigne2 + Char ( 13 ) 
	If Not IsNull ( sAdrLigne1 ) And Len ( sAdrLigne1 ) > 0 Then sAdresseO2m += sAdrLigne1 + Char ( 13 ) 
	If Not IsNull ( sAdrLigne2 ) And Len ( sAdrLigne2 ) > 0 Then sAdresseO2m += sAdrLigne2 + Char ( 13 ) 
	If Not IsNull ( sCP ) And Len ( sCP ) > 0 Then sAdresseO2m	+=	sCP
	If Not IsNull ( sVille ) And Len ( sVille ) > 0 Then sAdresseO2m	+=	" " + sVille 
	
// [ADRESSE_O2M]

// [PC13348&13408]
IF sIdFour = "MTT" Then
	sAdresseO2m =  "ADAR" + Char ( 13 ) 
	sAdresseO2m += "Générale Télécom Services" + Char ( 13 ) 
	sAdresseO2m += "SAV" + Char ( 13 ) 
	sAdresseO2m += "15, Allée Jean Jaurès" + Char ( 13 ) 
	sAdresseO2m += "31000 TOULOUSE - France"
End If 

// [DT141] 
IF sIdFour = "SBE" Then
	sAdresseO2m =  "SBE France" + Char ( 13 ) 
	sAdresseO2m += "Assurance SPB-AIG" + Char ( 13 ) 
	sAdresseO2m += "1 bd de la Liane" + Char ( 13 ) 
	sAdresseO2m += "62360 SAINT LEONARD"
End If 	

	choose Case alInfoSpbFrn

		case 410

// [ADRESSE_O2M]
//			sCodMsg = "COMD519" //* #5 [LCL_NOMADE]
			sCodMsg = "COMD629"		
// :[ADRESSE_O2M]
			
			If sTaillecoli <> "" Then
				sVar[1] = "Si l'envoi se fait par Colissimo, la taille doit être " + sTaillecoli 
			Else
				sVar[1] = ""
			End If

// [ADRESSE_O2M]
			sVar[2] = sAdresseO2m			

//			sVar[2] = sNumCmde
			sVar[3] = sNumCmde
// :[ADRESSE_O2M]
			
		case 415

// [ADRESSE_O2M]
//			sCodMsg = "COMD520" //* #5 [LCL_NOMADE] 	
			sCodMsg = "COMD630"		
// :[ADRESSE_O2M]

			If sTaillecoli <> "" Then
				sVar[1] = "Si l'envoi se fait par Colissimo, la taille doit être " + sTaillecoli 
			Else
				sVar[1] = ""
			End If

			sVar[2] = string(dcMtFrais)
			sVar[3] = lnv_string.of_GlobalReplace( stGlb.smonnaiesymboledesire, "\", "" ) // [SUISSE].LOT3 : Gestion msg Err avec monnaie

// [ADRESSE_O2M]		
			sVar[4] = sAdresseO2m			

//			sVar[4] = sNumCmde
			sVar[5] = sNumCmde
// :[ADRESSE_O2M]			
			
		case 420
			sCodMsg = "COMD459"	
			sVar[1] = sNumCmde
			
// #1 JFF [FNAC_PROD_ECH_TECH]	905 à 999			
		Case 	903 // [FNAC_PROD_ECH_TECH].[20090330152547023]
// [ADRESSE_O2M]
//			sCodMsg = "COMD518"		
// :[ADRESSE_O2M]
// [VDOC4970]
//			sCodMsg = "COMD628"		
//			sCodMsg = "COMD679"
			sCodMsg = "COMD738"	// [VDOC7524]
// [VDOC4970]			
			
			sVar[1] = "Appareil sinistré/batterie interne : " + sAppSin
			sVar[2] = "Batterie amovible sinistrée : " + sBattSin
			sVar[3] = "Câble d'alimentation sinistré : " + sAlimSin
			sVar[4] = "Accessoire annexe sinistré : " + sAccSin

			//* #7 [RUEDUCOMMERCE].[CRTEST1]
			If bRDCommerce Then
				sVar[2] = ""
				sVar[3] = ""
				sVar[4] = ""				
			End If
			//* :#7 [RUEDUCOMMERCE].[CRTEST1]			
			
			sVar[5] = lnv_Key[5].iakeyvalue // "Appareil de catégorie : "

			If sAppSin = "OUI" Then 
				sVar[6] = "son appareil et tous les accessoires d'origine (manuel, batterie amovible, câble d'alimentation, etc)"
				// [PC545].[POINT].[255]
				// [PC545].[POINT].[255][DEBUG][MER][MEP]
				sVar[7] = "dans l'emballage d'origine ou autre emballage" // [VDOC7524]				
			ElseIf sBattSin = "OUI" and sAlimSin = "OUI" Then 
				sVar[6] = "sa batterie amovible et son câble d'alimentation"
				sVar[7] = "dans un emballage"	// [VDOC7524]
			ElseIF sBattSin = "OUI" Then
				sVar[6] = "sa batterie amovible"
				sVar[7] = "dans un emballage"	// [VDOC7524]				
			ElseIF sAlimSin = "OUI" Then
				sVar[6] = "son câble d'alimentation"
				sVar[7] = "dans un emballage" // [VDOC7524]				
			ElseIF sAccSin = "OUI" Then
				sVar[6] = "son accessoire"
				sVar[7] = "dans un emballage" // [VDOC7524]				
			End If			

			//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
			If bPc441 Then
				sVar[8] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
			Else
				sVar[8] = ""
			End If

			//* #4 [FNAC_PROD_ECH_TECH].[20090330152547023]
			sVar[9] = sPc74
			
			sVar[10] = sNumCmde
			
// [ADRESSE_O2M]
//			sVar[9] = lnv_Key[12].iakeyvalue
			sVar[11] = sAdresseO2m	
// :[ADRESSE_O2M]		

// [PC419/440/418/439_MICROMANIA] Ajout 961, 962
		Case 	905, 910, 961, 962

// [ADRESSE_O2M]
//			sCodMsg = "COMD503"		
// :[ADRESSE_O2M]

// [VDOC4970]
//			sCodMsg = "COMD624"
//			sCodMsg = "COMD680"
			sCodMsg = "COMD741"			// [VDOC7524]						
// [VDOC4970]			


			//* #7 [RUEDUCOMMERCE]
			If bRDCommerce Then
	// [ADRESSE_O2M]
	//			sCodMsg = "COMD523"		
	// :[ADRESSE_O2M]

// [VDOC4970]				
				// sCodMsg = "COMD631"		
				sCodMsg = "COMD681"		
				sCodMsg = "COMD742"			// [VDOC7524]										
// [VDOC4970]				

				
			End If
			//* :#7 [RUEDUCOMMERCE]			

			sVar[1] = "Appareil sinistré/batterie interne : " + sAppSin
			sVar[2] = "Batterie amovible sinistrée : " + sBattSin
			sVar[3] = "Câble d'alimentation sinistré : " + sAlimSin
			sVar[4] = "Accessoire annexe sinistré : " + sAccSin

			//* #7 [RUEDUCOMMERCE].[CRTEST1]
			Choose Case True
				Case bRDCommerce, bCRCA_Pacifica
					sVar[2] = ""
					sVar[3] = ""
					sVar[4] = ""					
			End Choose 
			//* :#7 [RUEDUCOMMERCE].[CRTEST1]
			
			sVar[5] = lnv_Key[5].iakeyvalue // "Appareil de catégorie : "
			If sAppSin = "OUI" Then 
				sVar[6] = "son appareil et tous les accessoires d'origine (manuel, batterie amovible, câble d'alimentation, etc)"
				// [PC545].[POINT].[255]
				// [PC545].[POINT].[255][DEBUG][MER][MEP]

				// [DT122][MANTIS14871]
				If bSouplessePacifica And isTypApp = "TEL" Then
					sVar[6] = "son appareil"
				End If 
				
				sVar[7] = "dans l'emballage d'origine ou dans" // [VDOC7524] 	
				
				// [DT122][MANTIS14871]
				If bSouplessePacifica Then
					sVar[7] = "dans" // [VDOC7524] 	
				End If
				
			ElseIf sBattSin = "OUI" And sAlimSin = "OUI" Then 
				sVar[6] = "sa batterie amovible et son câble d'alimentation"								
				sVar[7] = "dans" // [VDOC7524]				
			ElseIF sBattSin = "OUI" Then
				sVar[6] = "sa batterie amovible"				
				sVar[7] = "dans" // [VDOC7524]								
			ElseIF sAlimSin = "OUI" Then
				sVar[6] = "son câble d'alimentation"
				sVar[7] = "dans" // [VDOC7524]								
			ElseIF sAccSin = "OUI" Then
				sVar[6] = "son accessoire"
				sVar[7] = "dans" // [VDOC7524]								
			End If			

			If alInfoSpbFrn = 905 Then
				//sVar[6] = "S"
				sVar[8] = "M" 				// [DMDI28280] 
			ElseIf alInfoSpbFrn = 910 Then
				//  [PC202].[DOM_COM]
				If bDomCom Then
					sVar[8] = "L"
				Else
					sVar[8] = "M"
				End If
				
			// [PC419/440/418/439_MICROMANIA] Ajout 961, 962
			ElseIf alInfoSpbFrn = 961 Then
				sVar[8] = "L"
			ElseIf alInfoSpbFrn = 962 Then
				sVar[8] = "XL"
			// :[PC419/440/418/439_MICROMANIA] Ajout 961, 962				
			Else
				sVar[8] = "?"
			End If

			//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
			If bPc441 Then
				sVar[9] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
			Else
				sVar[9] = ""
			End If

			//* #4 [FNAC_PROD_ECH_TECH].[20090330152547023]
			sVar[10] = sPc74

			sVar[11] = sNumCmde

			If bDomCom Then
				dcMtFrais = 27
				sMtFrais = "27€"
			End If

			// [PM280-1][MANTIS15456]
			If dcMtFrais > 0 Then
				sVar[12] = "L'assuré sera remboursé d'un montant de : " + string( dcMtFrais ) + lnv_string.of_GlobalReplace( stGlb.smonnaiesymboledesire, "\", "" ) + sCommentaireFrais // [SUISSE].LOT3 : Gestion msg Err avec monnaie
			Else
				sVar[12] = "L'assuré sera remboursé d'un montant de : " + sMtFrais + sCommentaireFrais 
			End If
			
			// [PM280-1][MANTIS15456]
			If bARepGti Then
				sVar[12] = ""
			End If
			
// [ADRESSE_O2M]
//			sVar[11] = lnv_Key[12].iakeyvalue
			sVar[13] = sAdresseO2m	
// :[ADRESSE_O2M]
			
		Case 	915, 920

			sCodMsg = "COMD682"

			If bRDCommerce Then
				sCodMsg = "COMD683"
			End If

			// [DT122]
			If bSouplessePacifica Then
				sCodMsg = "COMD900"
			End If

			sVar[1] = "Appareil sinistré/batterie interne : " + sAppSin
			sVar[2] = "Batterie amovible sinistrée : " + sBattSin
			sVar[3] = "Câble d'alimentation sinistré : " + sAlimSin
			sVar[4] = "Accessoire annexe sinistré : " + sAccSin

			//* #7 [RUEDUCOMMERCE].[CRTEST1]
			If bRDCommerce Then
				sVar[2] = ""
				sVar[3] = ""
				sVar[4] = ""				
			End If
			//* :#7 [RUEDUCOMMERCE].[CRTEST1]			
						
			sVar[5] = lnv_Key[5].iakeyvalue // "Appareil de catégorie : "

			// Sur 915,920 c'est forcément l'appareil qui est sinitré.
			sVar[6] = "son appareil et tous les accessoires d'origine (manuel, batterie amovible, câble d'alimentation, etc)"

			// [DT122]
			If bSouplessePacifica And isTypApp = "TEL" Then
				sVar[6] = "son appareil"
			End If 

			//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
			If bPc441 Then
				sVar[7] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
			Else
				sVar[7] = ""
			End If

			//* #4 [FNAC_PROD_ECH_TECH].[20090330152547023]
			sVar[8] = sPc74

			sVar[9] = sNumCmde

			If dcMtFrais > 0 Then
				sVar[10] = "L'assuré sera remboursé d'un montant de : " + string( dcMtFrais ) + lnv_string.of_GlobalReplace( stGlb.smonnaiesymboledesire, "\", "" ) + sCommentaireFrais // [SUISSE].LOT3 : Gestion msg Err avec monnaie
			ElseIf sMtFrais <> "" Then
				sVar[10] = "L'assuré sera remboursé d'un montant de : " + sMtFrais + sCommentaireFrais 
			Else 
				sVar[10] = ""
			End If

			// [PM280-1][MANTIS15456]
			If bARepGti Then
				sVar[10] = ""
			End If 

// [ADRESSE_O2M]
//			sVar[10] = lnv_Key[12].iakeyvalue
			sVar[11] = sAdresseO2m	
// :[ADRESSE_O2M]

		Case 	925, 930
				//* #1 [FNAC_PROD_ECH_TECH] En attente process O2M/MSS éventuel

		Case 935, 940
// [VDOC4970]	
			// sCodMsg = "COMD505"		
			sCodMsg = "COMD684"					
// [VDOC4970]	

			sVar[1] = "Appareil sinistré/batterie interne : " + sAppSin
			sVar[2] = "Batterie amovible sinistrée : " + sBattSin
			sVar[3] = "Câble d'alimentation sinistré : " + sAlimSin
			sVar[4] = "Accessoire annexe sinistré : " + sAccSin
			
			//* #7 [RUEDUCOMMERCE].[CRTEST1]
			If bRDCommerce Then
				sVar[2] = ""
				sVar[3] = ""
				sVar[4] = ""				
			End If
			//* :#7 [RUEDUCOMMERCE].[CRTEST1]
			
			sVar[5] = lnv_Key[5].iakeyvalue // "Appareil de catégorie : "

			sVar[6] = "Son appareil et tous les accessoires d'origine (manuel, batterie amovible, câble d'alimentation, etc)"

			//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
			If bPc441 Then
				sVar[7] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
			Else
				sVar[7] = ""
			End If

			//* #4 [FNAC_PROD_ECH_TECH].[20090330152547023]
			sVar[8] = sPc74

			sVar[9] = sNumCmde


		Case 936, 941
	// [ADRESSE_O2M]
//			sCodMsg = "COMD507"		
	// :[ADRESSE_O2M]
	
// [VDOC4970]		
			//sCodMsg = "COMD626"
			sCodMsg = "COMD685"
// [VDOC4970]		
	
			//* #7 [RUEDUCOMMERCE]
			If bRDCommerce Then
	// [ADRESSE_O2M]
	//			sCodMsg = "COMD526"		
				sCodMsg = "COMD686"		
	// :[ADRESSE_O2M]
			End If
			//* :#7 [RUEDUCOMMERCE]		

			sVar[1] = "Appareil sinistré/batterie interne : " + sAppSin
			sVar[2] = "Batterie amovible sinistrée : " + sBattSin
			sVar[3] = "Câble d'alimentation sinistré : " + sAlimSin
			sVar[4] = "Accessoire annexe sinistré : " + sAccSin

			//* #7 [RUEDUCOMMERCE].[CRTEST1]
			If bRDCommerce Then
				sVar[2] = ""
				sVar[3] = ""
				sVar[4] = ""				
			End If
			//* :#7 [RUEDUCOMMERCE].[CRTEST1]			
			
			sVar[5] = lnv_Key[5].iakeyvalue // "Appareil de catégorie : "

// [ADRESSE_O2M]
//			sVar[5] = lnv_Key[12].iakeyvalue
			sVar[6] = sAdresseO2m	
// :[ADRESSE_O2M]

			If dcMtFrais > 0 Then
				sVar[7] = "L'assuré sera remboursé d'un montant de : " + string( dcMtFrais ) + lnv_string.of_GlobalReplace( stGlb.smonnaiesymboledesire, "\", "" ) + sCommentaireFrais // [SUISSE].LOT3 : Gestion msg Err avec monnaie
			ElseIf sMtFrais <> "" Then
				sVar[7] = "L'assuré sera remboursé d'un montant de : " + sMtFrais + sCommentaireFrais 
			Else 
				sVar[7] = ""
			End If

			// [PM280-1][MANTIS15456]
			If bARepGti Then
				sVar[7] = ""
			End If
			
			sVar[8] = "Son appareil et tous les accessoires d'origine (manuel, batterie amovible, câble d'alimentation, etc)"

			//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
			If bPc441 Then
				sVar[9] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
			Else
				sVar[9] = ""
			End If
			
			//* #4 [FNAC_PROD_ECH_TECH].[20090330152547023]
			sVar[10] = sPc74
			
			sVar[11] = sNumCmde


		Case 	955
// [VDOC4970]		
			// sCodMsg = "COMD486"		
			// [VDOC21247]
			sCodMsg = "COMD947"
// [VDOC4970]		

			sVar[1] = "Appareil sinistré/batterie interne : " + sAppSin
			sVar[2] = "Batterie amovible sinistrée : " + sBattSin
			sVar[3] = "Câble d'alimentation sinistré : " + sAlimSin
			sVar[4] = "Accessoire annexe sinistré : " + sAccSin

			//* #7 [RUEDUCOMMERCE].[CRTEST1]
			If bRDCommerce Then
				sVar[2] = ""
				sVar[3] = ""
				sVar[4] = ""				
			End If
			//* :#7 [RUEDUCOMMERCE].[CRTEST1]			
			
			sVar[5] = lnv_Key[5].iakeyvalue // "Appareil de catégorie : "

			// [VDOC21247]
			sVar[6]=""
			
			// Sur 935,940 c'est forcément l'appareil qui est sinitré.
			sVar[7] = "son appareil et tous les accessoires d'origine (manuel, batterie amovible, câble d'alimentation, etc)"

			//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
			If bPc441 Then
				sVar[8] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
			Else
				sVar[8] = ""
			End If

			//* #4 [FNAC_PROD_ECH_TECH].[20090330152547023]
			sVar[9] = sPc74
			
			sVar[10] = sNumCmde
			
		Case 	945, 950, 960, 906, 911

// [VDOC4970]		
			// sCodMsg = "COMD522" // #6 [DCMP090172]
			sCodMsg = "COMD688"
// [VDOC4970]		
			sVar[1] = "Appareil sinistré/batterie interne : " + sAppSin
			sVar[2] = "Batterie amovible sinistrée : " + sBattSin
			sVar[3] = "Câble d'alimentation sinistré : " + sAlimSin
			sVar[4] = "Accessoire annexe sinistré : " + sAccSin

			//* #7 [RUEDUCOMMERCE].[CRTEST1]
			If bRDCommerce Then
				sVar[2] = ""
				sVar[3] = ""
				sVar[4] = ""				
			End If
			//* :#7 [RUEDUCOMMERCE].[CRTEST1]			
			
			sVar[5] = lnv_Key[5].iakeyvalue // "Appareil de catégorie : "

			//* #2 [FNAC_PROD_ECH_TECH].[20090223142259343]
			If sAppSin = "OUI" Then 
				sVar[6] = "son appareil et tous les accessoires d'origine (manuel, batterie amovible, câble d'alimentation, etc)"
				// [PC545].[POINT].[255]
				// [PC545].[POINT].[255][DEBUG][MER][MEP]
			ElseIf sBattSin = "OUI" And sAlimSin = "OUI" Then 
				sVar[6] = "sa batterie amovible et son câble d'alimentation"								
			ElseIF sBattSin = "OUI" Then
				sVar[6] = "sa batterie amovible"				
			ElseIF sAlimSin = "OUI" Then
				sVar[6] = "son câble d'alimentation"
			ElseIF sAccSin = "OUI" Then
				sVar[6] = "son accessoire"
			End If			

			// #6 [DCMP090172]
			If sNomContractant = "" Then 
				sVar[7] = "en magasin"
			Else
				sVar[7] = "chez " + sNomContractant
			End If
			// :#6 [DCMP090172]

			If alInfoSpbFrn = 906 Then
				sVar[8] = "pour dépôt du conditionnement chez FNAC puis enlèvement pour expédition vers O2M "
				sVar[9] = "20x20x20 cm"
			ElseIf alInfoSpbFrn = 911 Then
				sVar[8] = "pour dépôt du conditionnement chez FNAC puis enlèvement pour expédition vers O2M "
				sVar[9] = "30x30x30 cm"
			ElseIf alInfoSpbFrn = 945 Then
				sVar[8] = "pour dépôt du conditionnement chez FNAC puis enlèvement pour expédition vers O2M "
				sVar[9] = "50x50x25 cm"
			ElseIf alInfoSpbFrn = 950 Then
				sVar[8] = "pour dépôt du conditionnement chez FNAC puis enlèvement pour expédition vers O2M "
				sVar[9] = "50x50x50 cm"
			ElseIf alInfoSpbFrn = 960 Then
				sVar[8] = "pour enlèvement et expédition vers O2M "
				sVar[9] = "spécial"
			Else 
				sVar[8] = "pour dépôt du conditionnement chez FNAC puis enlèvement pour expédition vers O2M "
				sVar[9] = "(inconnu)"
			End If
			//* :#2 [FNAC_PROD_ECH_TECH].[20090223142259343]

			// #6 [DCMP090172]
			If sNomContractant = "" Then 
				sVar[10] = "en magasin"
			Else
				sVar[10] = "chez " + sNomContractant
			End If
			// :#6 [DCMP090172]

			//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
			If bPc441 Then
				sVar[11] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
			Else
				sVar[11] = ""
			End If

			//* #4 [FNAC_PROD_ECH_TECH].[20090330152547023]
			sVar[12] = sPc74

			sVar[13] = sNumCmde

		Case 963

// [VDOC4970]		
			// sCodMsg = "COMD639" // #6 [DCMP090172]
			sCodMsg = "COMD689"
// [VDOC4970]		

			sVar[1] = "Appareil sinistré/batterie interne : " + sAppSin
			sVar[2] = "Batterie amovible sinistrée : " + sBattSin
			sVar[3] = "Câble d'alimentation sinistré : " + sAlimSin
			sVar[4] = "Accessoire annexe sinistré : " + sAccSin

			//* #7 [RUEDUCOMMERCE].[CRTEST1]
			If bRDCommerce Then
				sVar[2] = ""
				sVar[3] = ""
				sVar[4] = ""
			End If
			//* :#7 [RUEDUCOMMERCE].[CRTEST1]			
			
			sVar[5] = lnv_Key[5].iakeyvalue // "Appareil de catégorie : "

			//* #2 [FNAC_PROD_ECH_TECH].[20090223142259343]
			If sAppSin = "OUI" Then 
				sVar[6] = "son appareil et tous les accessoires d'origine (manuel, batterie amovible, câble d'alimentation, etc)"
				// [PC545].[POINT].[255]
				// [PC545].[POINT].[255][DEBUG][MER][MEP]
			ElseIf sBattSin = "OUI" And sAlimSin = "OUI" Then 
				sVar[6] = "sa batterie amovible et son câble d'alimentation"								
			ElseIF sBattSin = "OUI" Then
				sVar[6] = "sa batterie amovible"				
			ElseIF sAlimSin = "OUI" Then
				sVar[6] = "son câble d'alimentation"
			End If			


			If sNomContractant = "" Then 
				sVar[7] = "en magasin"
			Else
				sVar[7] = "chez " + sNomContractant
			End If

			//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
			If bPc441 Then
				sVar[8] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
			Else
				sVar[8] = ""
			End If

			//* #4 [FNAC_PROD_ECH_TECH].[20090330152547023]
			sVar[9] = sPc74

			sVar[10] = sNumCmde


		// #9 07/10/2009 [DCMP090421]
		// [PC877] 967
		Case 907, 912, 937, 942, 967, 972
			sCodMsg = "COMD690"					

			If bRDCommerce Then
				sCodMsg = "COMD691"		
			End If

			If bAuchan Then
				sCodMsg = "COMD692"						
			End If

			// [DT386_EXTR_AXA]
			If bBuyBackAXA	Then
				sCodMsg = "COMD991"				
			End If 
			
			// [PC929_CDISCOUNT]
			If alInfoSpbFrn = 972 Then
				sCodMsg = "COMD777"										
			End If

			sVar[1] = "Appareil sinistré/batterie interne : " + sAppSin
			sVar[2] = "Batterie amovible sinistrée : " + sBattSin
			sVar[3] = "Câble d'alimentation sinistré : " + sAlimSin
			sVar[4] = "Accessoire annexe sinistré : " + sAccSin

			//* #7 [RUEDUCOMMERCE].[CRTEST1]
			If bRDCommerce Then
				sVar[2] = ""
				sVar[3] = ""
				sVar[4] = ""
			End If
			//* :#7 [RUEDUCOMMERCE].[CRTEST1]
			
			sVar[5] = lnv_Key[5].iakeyvalue // "Appareil de catégorie : "
			If sAppSin = "OUI" Then

				// [VDOC15705]
				If isTypApp = "TEL" then
					sVar[6] = "son appareil sans les accessoires d'origine"
				Else 
					sVar[6] = "son appareil et tous les accessoires d'origine (manuel, batterie amovible, câble d'alimentation, etc)"											
				End If
				
				// [PC545].[POINT].[255]
				// [PC545].[POINT].[255][DEBUG][MER][MEP]
			ElseIf sBattSin = "OUI" And sAlimSin = "OUI" Then 
				sVar[6] = "sa batterie amovible et son câble d'alimentation"								
			ElseIF sBattSin = "OUI" Then
				sVar[6] = "sa batterie amovible"				
			ElseIF sAlimSin = "OUI" Then
				sVar[6] = "son câble d'alimentation"
			ElseIF sAccSin = "OUI" Then
				sVar[6] = "son accessoire"
			End If			

			//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
			If bPc441 Then
				sVar[7] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
			Else
				sVar[7] = ""
			End If

			//* #4 [FNAC_PROD_ECH_TECH].[20090330152547023]
			sVar[8] = sPc74

			sVar[9] = sNumCmde
		
// [ADRESSE_O2M]
//			sVar[9] = lnv_Key[12].iakeyvalue

			// [DT386_EXTR_AXA]
			If bBuyBackAXA	Then
				sVar[10] = ""
			Else 
				sVar[10] = sAdresseO2m					
			End If 
			
// :[ADRESSE_O2M]

		// [PC877]
		Case 	968
			sCodMsg = "COMD761"

			sVar[1] = sNumCmde
			sVar[2] = sAdresseO2m
			
		// [PC913]
		Case 951

			sCodMsg = "COMD767"
			
			//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
			If bPc441 Then
				sVar[1] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
			Else
				sVar[1] = ""
			End If

			sVar[2] = sPc74

			sVar[3] = sNumCmde

			If bDomCom Then
				dcMtFrais = 27
				sMtFrais = "27€"
			End If
			
			If dcMtFrais > 0 Then
				sVar[4] = "L'assuré sera remboursé d'un montant de : " + string( dcMtFrais ) + lnv_string.of_GlobalReplace( stGlb.smonnaiesymboledesire, "\", "" ) + sCommentaireFrais // [SUISSE].LOT3 : Gestion msg Err avec monnaie
			Else
				sVar[4] = "L'assuré sera remboursé d'un montant de : " + sMtFrais + sCommentaireFrais 
			End If

			// [PM280-1][MANTIS15456]
			If bARepGti Then
				sVar[4] = ""
			End If
			
			sVar[5] = sAdresseO2m	

		// [PC913]
		Case 952

			sCodMsg = "COMD768"
			
			//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
			If bPc441 Then
				sVar[1] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
			Else
				sVar[1] = ""
			End If

			sVar[2] = sPc74

			sVar[3] = sNumCmde

			sVar[4] = sAdresseO2m	

		// [PC913]
		Case 953

			sCodMsg = "COMD779"
			
			If sAppSin = "OUI" Then 
			sVar[1] = "son appareil et tous les accessoires d'origine (manuel, batterie amovible, câble d'alimentation, etc)"
			ElseIf sBattSin = "OUI" And sAlimSin = "OUI" Then 
				sVar[1] = "sa batterie amovible et son câble d'alimentation"								
			ElseIF sBattSin = "OUI" Then
				sVar[1] = "sa batterie amovible"				
			ElseIF sAlimSin = "OUI" Then
				sVar[1] = "son câble d'alimentation"
			End If	
			
			
			//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
			If bPc441 Then
				sVar[2] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
			Else
				sVar[2] = ""
			End If

			sVar[3] = sPc74

			sVar[4] = sNumCmde			

		// [DT191-1]
		Case 983

			stMessage.sCode = "COMD862" 					
			F_Message ( stMessage )

		// [DT156]
		Case 985

			sCodMsg = "COMD914"
			
			If bPc441 Then
				sVar[1] = "- La facture " + sNomContractant + " où figure le montant d'achat de l'appareil et du règlement de la cotisation"
			Else
				sVar[1] = ""
			End If

			sVar[2] = sPc74

			sVar[3] = sNumCmde

			
			
		Case 990 //[PC14503].Mantis11633
			If bCdsBricoPro Then
				sCodMsg="COMD875"
			End if
			
// :#1 JFF [FNAC_PROD_ECH_TECH]							
	End Choose

	//* #10  [MSS_DIAG]
	If sCodMsg <> "" Then
		stMessage.scode = sCodMsg
		stMessage.sVar = sVar
	
		F_Message(stMessage)
	End If
	//* :#10  [MSS_DIAG]
	
End If

//* #8 [DCMP090298]
// Traitement de cas particulier
stMessage.scode = ""

Choose Case sTypApp

	Case "APN"
		
		Choose Case Upper ( isMarqPortAdh ) 
		
			Case 	"NIKON"		

				stMessage.scode = "COMD528"
		
		End Choose
		
End Choose 

If stMessage.scode <> "" Then
	F_Message(stMessage)
End If
//* :#8 [DCMP090298]

// [DT191-1]
If lnvPFCString.of_getkeyvalue (isInfoSpbFrnCplt, "RET_REL_PICK_UP", ";") = "OUI" Then
	stMessage.scode = "COMD938"
	F_Message(stMessage)
End If

end subroutine

public function string uf_epure_zone (ref string asvaleur);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::uf_epurezone
//* Auteur			: F. Pinon
//* Date				: 27/09/2013
//* Libellé			: Fonciton d'épuration du contenu de zone (tab + retours chariots)
//* Commentaires	: [VDoc12269] 
//*
//* Arguments		: value string asvaleur	 */
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

String sRet
Long lPos, lPos2

if isnull(asvaleur) then return asvaleur

sRet=asvaleur

// [VDoc9391] On supprime tout ce qu'il y a à droite du retour chariot
lPos =Pos(sRet,Char(13))
If lPos <=0 Then 
	lPos =Pos(sRet,Char(10))
else 
	lPos2=Pos(sRet,Char(10))
	If lPos2>0 Then lPos=Min(lPos,  lPos2)
End if

If lPos > 0 Then sRet=Left(sRet, lPos - 1)

sRet = f_remplace(sRet,Char(13)," ")
sRet = f_remplace(sRet,Char(10)," ")
sRet = f_remplace(sRet,Char(9)," ")
sRet = f_remplace(sRet,Char(11)," ")
sRet = f_remplace(sRet,";"," ")	
sRet = f_remplace(sRet,"~"","")

Return sRet
end function

public subroutine uf_q_ios7 ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_Q_IOS7 (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 06/09/2013
//* Libellé			: [VDOC12443]
//* Commentaires	: Controle de Gestion
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*---------------------------------------------------------------
// 		JFF 	05/05/2014 [VDOC14301]
//       JFF   30/07/2014 [PM234-4_V1]
//       JFF   29/01/2016 [PM280-1]
//       JFF   18/02/2015 [VDOC16907]
//       JFF   20/03/2015 [VDOC17171]
//       JFF   08/03/2015 [VDOC20198]
//       JFF   17/05/2016 [PM280-2]
//       JFF   21/09/2016 [VDOC21880]
//*---------------------------------------------------------------
n_cst_string lnvPFCString

Boolean bAutorise, bDeclaWebAtlas, bDcnxWebAtlas
String  sInfoIphoneAtlas

Long LRow, lIdEvt

bAutorise = FALSE

lIdEvt = idwDetail.GetItemNumber ( 1, "ID_EVT" ) // [PM280-1]

// [PM234-4_V1]
bDeclaWebAtlas = FALSE
bDeclaWebAtlas = idwWDivsin.Find ( "NOM_ZONE = 'decla_atlas' AND VAL_CAR = 'O'", 1, idwWDivSin.RowCount () ) > 0
bDcnxWebAtlas = idwWDivsin.Find ( "NOM_ZONE = 'dcnx_decla_atlas' AND VAL_CAR = 'O'", 1, idwWDivSin.RowCount () ) > 0

If bDcnxWebAtlas Then
	bDeclaWebAtlas = False
End If

lRow = idwWDivsin.Find ( "NOM_ZONE = 'info_iphone_atlas'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	sInfoIphoneAtlas = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
End If
// [PM234-4_V1]

// [VDOC16907]
// [VDOC21880] IPAD
Choose Case Upper ( isMarqPortAdh ) 
	Case "APPLE"
		Choose Case True
			Case Pos ( isModlPortAdh, "IPHONE" ) > 0 Or ( Pos ( isModlPortAdh, "IPAD" ) > 0 )
				bAutorise = True
			
		End Choose
End Choose
	
If Not bAutorise Then Return  

// [PM234-4_V1]

lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "MAIL_IOS7", "OUI", ";")



end subroutine

protected function integer uf_zn_choix (ref datawindow adw, string asdata, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_Zn_Choix (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 19/09/2001
//* Libellé			: Zone Choix
//* Commentaires	: 
//*
//* Arguments		: aDw				DataWindow	Val
//*					  asData			String		Val
//*					  alRow			String		Val
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #2   JFF    01/10/2007   [DCMP070689] complèment Darty Swap&DartyMP
//* #3	JFF    18/09/2007   [ALAPAGE]
//* #3   JFF    28/01/2008   [DCMP080028]
//* #4   JFF    05/03/2008   Bug sur le champs calculé
//* #5   JFF   01/04/2008    [DCMP080256][EEE_PC_ASUS] 
//* #6	JFF	20/10/2008	  [FNAC_PROD_ECH_TECH]
//* #7   JFF   10/06/2009    [RUEDUCOMMERCE]
//* #8   JFF    10/06/2009   [MOBISQUARE]
//* #9   JFF    10/08/2009   [O2M_DIAG_NOMADE].[JFF].[20090810170829127]
//* #10  JFF    02/09/2009   [DCMP090327].[SBETV]
//* #11  JFF    02/09/2009   [20091019114301233]
//* #12  JFF    02/03/2010   [MSS_LOT2]
//*      JFF    27/07/2010   [PC321]
// 			FPI	18/05/2011	[PC512]
//			FPI	25/01/2012	 [CONFO][CUISINE] Carte cadeau Confo
//			FPI	14/02/2012	 [PM200][PSM]
//       JFF   02/04/2011   [PC694][SFR2012]
//       JFF   17/04/2012   [PM200][LOT2][DESOX]
//		FPI	24/04/2012	[VDoc7285] Interdire diag si réparation non-annulée et inversement
//      JFF   23/05/2012 [PM103][1]
//      JFF   30/08/2012 [VDOC8041]
//        JFF    24/09/2012  [PC869]
//		FPI 	12/10/2012	[PC846/864]
// 	  JFF	  28/11/2012 [PM200_LOT3]
//    JFF     14/02/2013 [VDOC10362]
//    JFF     21/03/2013 [ITSM150589]
//    JFF     29/03/2013 [VDOC10556]
//     JFF   07/05/2013 [PC938_ORANGE_V3]
//     JFF  15/05/2013 [PC938_ORANGE_V3]
//      JFF   17/06/2013 [PC946_ORANGE_OPPRO]
//       JFF   07/05/2013 [PC929-1]
//		FPI	18/07/2013	[PM200_5]
//		FPI 	10/09/201	 [PM200_5].2 inversion de la détermination de la méthode WS PSM
//       JFF   09/09/2013 [PM222-1]
//       JFF   11/10/2013 [VDOC12443]
//			JFF   31/10/2013 [ITSM181736]
// 		JFF   18/02/2014 [PM246][MANTIS10235]
// 		JFF   18/02/2014 [PM246][MANTIS10193]
//		FPI	01/04/2014	[PM257-1] Suppression du forçage de btq de centralisation
//    JFF    12/06/2014 [MANTIS11433]
//       JFF   30/07/2014 [PM234-4_V1]
//       JFF   11/08/2014 [DT94]
//       JFF   18/02/2014 [PM280][MANTIS13512]
//       JFF   18/02/2014 [PM280][MANTIS14672]
//       JFF   31/03/2014 [PM280-1][MANTIS14825]
//       JFF   13/07/2015 [PC151270_ORANGE_V3]
//       JFF   03/09/2015 [VDOC18588]
//       JFF   29/10/2015 [VDOC18993]
//       JFF   08/03/2015 [VDOC20198]
//       JFF   17/05/2016 [PM280-2]
//       JFF   21/02/2107 [DT288]
//       JFF   23/08/2017 [DT288-3_LOT1][PM280]
//       JFF   09/04/2018 [DT353]
//       JFF   31/08/2018 [PM441-1]
//       JFF   12/09/2018 [PC874_2_V1]
// 		JFF	30/11/2018 [ITSM576546]
//       JFF   20/06/2022 [RS3220_MODDEGR_TELST]
//       JFF   16/08/2022 [RS3200]
//       JFF   07/03/2024 [HP252_276_HUB_PRESTA]
//*---------------------------------------------------------------

Int iRet, iPos 
String	sTypArt, sIdfour, sIdTypArt, sNull, sVar, sVar1, sTypApp, sVal, sCodeVerrou, sVal2, sIdRefFour, sPos
Long		lRow, lDeb, lFin, lNull, lTotTypArt, lCpt, lIdEvt, lCptDetPro, lVal1, lIdGti, lIdDetail, lIdSin 
Boolean  bGestionDartyTel, bGestionDartyNomade, bSel3MobAuto, bRueDucommerce, bORANGE_V3_CMDE, bCasReouv235_236, bPecForce
s_Pass	stPassALP
Decimal {2} dcMtPrixTTC // #4
n_cst_string lnvPFCString 
n_cst_attrib_rdc	nvrdc
datawindowchild dwChildMarqPort
String sDteCreationCarte, sNumCarte //[CONFO][CUISINE]
Long lIdProd, lVal 
n_cst_attrib_key	lnv_Key[]
String sValInclu, sValExclu
s_pass stPass, stPassNull
Boolean bMethode_BoutiquePSM_WS=TRUE // [PM200_5]
String sCpAssure // [PM200_5]
Decimal {2} dcMtValAchat
Boolean bDeclaWebAtlas, bDcnxWebAtlas
String sTypLivrAtlas, sCodLivrAtlas, sTypAppPretAtlas, sCasHub
Boolean bGestionAxaVirtuelle
Date dDteEnvCli, dJour

iRet = 0
lIdEvt = idwDetail.GetItemNumber ( 1, "ID_EVT" )
lIdProd = idwWsin.GetItemNumber ( 1, "ID_PROD" )
lIdSin = idwWSin.GetItemNumber ( 1, "ID_SIN" )
lIdGti = idwDetail.GetItemNumber ( 1, "ID_GTI" )
lIdDetail = idwDetail.GetItemNumber ( 1, "ID_DETAIL" )
bCasReouv235_236 = False
sIdFour=Upper ( adw.GetItemString ( alRow, "ID_FOUR" ) )
sIdTypArt = Upper ( adw.GetItemString ( alRow, "ID_TYP_ART" )	)
sIdReffour = Upper ( adw.GetItemString ( alRow, "ID_REF_FOUR" )	)
dcMtValAchat = idwDetail.GetitemDecimal( 1, "MT_VAL_ACHAT") 
bPecForce = False

// [PM234-4_V1]
bDeclaWebAtlas = FALSE
bDeclaWebAtlas = idwWDivsin.Find ( "NOM_ZONE = 'decla_atlas' AND VAL_CAR = 'O'", 1, idwWDivSin.RowCount () ) > 0
bDcnxWebAtlas = idwWDivsin.Find ( "NOM_ZONE = 'dcnx_decla_atlas' AND VAL_CAR = 'O'", 1, idwWDivSin.RowCount () ) > 0

// [ITSM331639]
bPecForce =idwwDivDet.Find ( "ID_GTI = " + String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) ) + &
			" AND ID_DETAIL = " +  String ( idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
			" AND UPPER ( NOM_ZONE ) = 'ALT_PEC' " + &
			" AND UPPER ( VAL_LST_CAR ) = 'O'" &
			, 1, idwwDivDet.RowCount () ) > 0

If bDcnxWebAtlas Then
	bDeclaWebAtlas = False
End If

lRow = idwWDivsin.Find ( "NOM_ZONE = 'type_livraison_atlas'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	sTypLivrAtlas = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
End If

lRow = idwWDivsin.Find ( "NOM_ZONE = 'code_livraison_atlas'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	sCodLivrAtlas = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
End If

lRow = idwWDivsin.Find ( "NOM_ZONE = 'typ_app_pret_atlas'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	sTypAppPretAtlas = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
End If

// [PM234-4_V1]

/*------------------------------------------------------------------*/
/* #1 : Gestion particuliere DARTY -DP 11                           */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 11 )
bGestionDartyTel = lDeb > 0

F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 31 )
bGestionDartyNomade = lDeb > 0

F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 45 )
bSel3MobAuto = lDeb > 0

// [PC13174]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 264 )
bGestionAxaVirtuelle= lDeb > 0

// #7 [RUEDUCOMMERCE]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 114 )
// bRueDucommerce = lDeb > 0 And ( isChoixAction = "C" Or isChoixAction = "S" ) [ITSM181736]
bRueDucommerce = lDeb > 0 And ( isChoixAction = "C" Or isChoixAction = "S" ) And sIdFour = "RDC" // [ITSM181736]

// [PC938_ORANGE_V3]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 239 )
bORANGE_V3_CMDE = lDeb > 0 And isChoixAction = "C" 


// [PM246][MANTIS10235]
// [PC151270_ORANGE_V3]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 94 )
For lCptDetPro = lDeb To lFin
	sVal = lnvPFCString.of_getkeyvalue ( idw_DetPro.GetItemString ( lCptDetPro, "VAL_CAR" ), "COD_DW", ";")

	//[VDOC18993]
	// [PM280-2] lIdEvt <> 1426
	Choose Case sVal 
		Case "ORANGE_V3", "ORANGE_V2BIS", "ORANGE_V3BIS", "ORANGE_V3TER"
			If ( sIdReffour = "A_DIAGNOSTIQUER" Or sIdReffour = "PEC_A_RECYCLER" ) And Not gAutoriseDiag And lIdEvt <> 1426 Then
				// On coupe, vu avec Lisette et ML Gasnier suite mantis 10235 le 17/12/2014
				
				If Not ( sIdReffour = "PEC_A_RECYCLER" And &
							idwCmdeSin.Find("ID_REF_FOUR = 'A_DIAGNOSTIQUER'", 1, idwCmdeSin.RowCount ()) >0 ) Then
					stMessage.sCode = "COMD846"
					stMessage.bouton = Ok!
					F_Message ( stMessage )
					idwArticle.SetItem ( alRow, "CHOIX", "N" )
					Return 2
				End If
				
			End If
	End Choose 
Next
// [PM246][MANTIS10235]	

// [PC938_ORANGE_V3]
If ( ( adw.GetItemString ( alRow, "ID_TYP_ART" ) = "PST" And adw.GetItemString ( alRow, "ID_FOUR" ) = "O2M" ) Or &
	  ( adw.GetItemString ( alRow, "ID_TYP_ART" ) = "PRS" And adw.GetItemString ( alRow, "ID_FOUR" ) = "PSM" ) &
	) And &
	asData="O" Then
	
	If idwCmdeSin.Find("ID_FOUR IN ('O2M') AND ID_TYP_ART = 'PST' AND COD_ETAT NOT IN ( 'ANN', 'RFO', 'RPC') AND STATUS_GC IN ( 235, 236)",1,idwCmdeSin.RowCount()) > 0 Or &
		idwCmdeSin.Find("ID_FOUR IN ('PSM') AND ID_TYP_ART = 'PRS' AND COD_ETAT NOT IN ( 'ANN', 'RFO', 'RPC') AND STATUS_GC IN ( 235, 236)",1,idwCmdeSin.RowCount()) > 0 Then
			
			bCasReouv235_236 = True
			bORANGE_V3_CMDE = FALSE
			
	End If 
End If


If idwTypArt.RowCount () <= 0 Then 	Return 2

sTypArt = Upper ( adw.GetITemString ( alRow, "ID_TYP_ART" ) )
sIdRefFour = Upper ( adw.GetITemString ( alRow, "ID_REF_FOUR" ) )

SetNull ( sNull )
adw.SetItem ( alRow, "PROBLEME", sNull )

// [PC938_ORANGE_V3]
If bORANGE_V3_CMDE Then
	IF sTypArt = "REL" Then
		stMessage.sTitre  	= "Controle de zone"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD785"
		stMessage.bouton 		= Ok!
		f_message(stMessage)
		idwArticle.SetItem ( alRow, "CHOIX", "N" )
		Return 2
	End If
End If		
// [PC938_ORANGE_V3]

// #7 [RUEDUCOMMERCE]
If bRueDuCommerce And isChoixAction = "C" And asData = "O" And sTypArt <> 'CAF'  Then // [PC473] ajout de sTypArt <> 'CAF'


	idwWsin.Getchild ( "MARQ_PORT", dwChildMarqPort )
	nvrdc = CREATE n_cst_attrib_rdc

	nvrdc.idcmtpec = adw.GetItemDecimal ( alRow, "MT_PLAF" )
	nvrdc.idwmarques = dwChildMarqPort
	nvrdc.idwdetpro = idw_detpro
	nvrdc.iiIdProd = idwWSin.GetItemNumber ( 1, "ID_PROD" )
	
	OpenWithParm ( w_sp_trt_saisie_rdc, nvrdc ) 
	nvrdc = Message.PowerObjectParm

//	String sChaineRetour
//	sChaineRetour = "ID_REF_FOUR=EDU.0045496365332;ID_MARQ_ART=NOKIA;ID_MODL_ART=3510;MT_TTC_CMDE=152.00;REF_FDP=RDC-001;CODE_PAYS=FR"

	If nvrdc.uf_getsaisie( ) = "[ANNULER]" Then
		If asData = "O" Then
			asData = "N"
		Else 
			asData = "O"
		End If
		idwArticle.SetItem ( alRow, "CHOIX", asData )
		Return 2
	End If

	idwArticle.SetItem ( alRow, "MT_PRIX_HT", Dec ( lnvPFCString.of_getkeyvalue (nvrdc.uf_getsaisie( ), "MT_TTC_CMDE", ";" ) ) )
	idwArticle.SetItem ( alRow, "TVA", 0  ) // à 0 impérativement !! vu que le prix HT  le prix TTC
	idwArticle.SetItem ( alRow, "ID_REF_FOUR", lnvPFCString.of_getkeyvalue (nvrdc.uf_getsaisie( ), "ID_REF_FOUR", ";" ) )
	idwArticle.SetItem ( alRow, "ID_MARQ_ART", lnvPFCString.of_getkeyvalue (nvrdc.uf_getsaisie( ), "ID_MARQ_ART", ";" ) )
	idwArticle.SetItem ( alRow, "ID_MODL_ART", lnvPFCString.of_getkeyvalue (nvrdc.uf_getsaisie( ), "ID_MODL_ART", ";" ) )

	// #10 [DCMP090327].[SBETV]
	If isInfoSpbFrncplt <> "" Then
		isInfoSpbFrncplt += ";"
	End If
	// :#10 [DCMP090327].[SBETV]	
	isInfoSpbFrnCplt  += "REF_FDP=" + lnvPFCString.of_getkeyvalue (nvrdc.uf_getsaisie( ), "REF_FDP", ";" ) + ";"
	isInfoSpbFrnCplt  += "CODE_PAYS=" + lnvPFCString.of_getkeyvalue (nvrdc.uf_getsaisie( ), "CODE_PAYS", ";" ) + ";" 


	Destroy nvrdc 
	
End If
// :#7

// [HP252_276_HUB_PRESTA]
If sIdfour="HUB" And &
   ( isChoixAction = "C" Or isChoixAction = "R" Or isChoixAction = "I" ) And &
	asData="O" &
	Then
	
		sCasHub = ""
	
		Choose Case isChoixAction 
			Case "C"
				sCasHub = "A_COMMANDER"
			Case "R"
				sCasHub = "A_REPARER"
			Case "I"
				Choose Case sIdRefFour
					Case "A_DIAGNOSTIQUER", &
						  "REFUSE_A_REEXP", &
						  "PEC_A_RECYCLER", &
						  "CODE_VERROU", &
						  "A_REPARER_FORCE", &
						  "A_DIAG_FORCE"
						  
						sCasHub = sIdRefFour
				End Choose
		End Choose
	
		If sCasHub <> "" Then
			iRet = This.uf_zn_choix_regle_hub ( sCasHub, lIdProd, lIdSin, lIdGti, lIdDetail, iRet, adw, alRow )
		End If 

End If 


// [CONFO][CUISINE]
If asData="O" Then
	If sIdfour="CFM" and sTypArt="CAF" Then
		sVar = ""

		// [PC14495]
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 261 )	
		If lDeb > 0 Then
			If dcMtValAchat >= 100 Then
				stMessage.sCode = "COMD868"
				stMessage.bouton = YESNO!
				
				If F_Message ( stMessage )	= 2 Then
					ibDecocherPresta = True
				End IF
			End If			
		End If
		// [PC14495]		
		
		// [PC14495]
		If Not ibDecocherPresta Then
			Do While sVar = "" Or sVar = "[RETOUR]"
		
				Open( w_sp_trt_saisie_carte_conforama )
				sVar = Message.StringParm
		
				If sVar = "" Or sVar = "[RETOUR]" Then 
					stMessage.Bouton		= Ok!
					stMessage.Icon			= Information!
					stMessage.bErreurG	= FALSE
					stMessage.sCode		= "COMD697"
					f_Message ( stMessage ) 
				End If
			Loop
		
			sDteCreationCarte = lnvPFCString.of_getkeyvalue (sVar, "DATE_CREATION", ";")
			If IsNull ( sDteCreationCarte ) Then sDteCreationCarte = ""
		
			sNumCarte = lnvPFCString.of_getkeyvalue (sVar, "NUM_CARTE", ";")
			If IsNull ( sNumCarte ) Then sNumCarte = ""
		
			idwCmde.SetItem ( 1, "ID_CMD_FRN", sNumCarte )
			lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "DTE_CREATION_CARTE_CADEAU", sDteCreationCarte, ";")

			// [PC14495]
			F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 207 )	
			If lDeb > 0 Then
				idwArticle.SetItem ( alRow, "ID_SERIE_ANC", "X" )
			End If 
		End If
	End If		
End if
// :[CONFO][CUISINE]


// [PM280-1]
// [PM280][MANTIS13512] AND STATUS_GC NOT IN ( 176 )
// [PM280][MANTIS14672] ajout 239, 203

// [RS3220_MODDEGR_TELST]
/*If mode_dégradé Then
	lVal1 = idwCmdeSin.Find ( &
		"ID_FOUR = 'O2M' AND " + &
		"COD_ETAT <> 'ANN' AND " + &
		"( ID_TYP_ART NOT IN ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' ) " + &
		"  OR " + &
		"  ( ID_TYP_ART = 'RST' AND POS ( INFO_SPB_FRN_CPLT, 'RST_CMDE+SUIVI=OUI' ) > 0 ) " + &
		") " + &
		" AND STATUS_GC NOT IN ( 176, 239, 203 )" + &
		" AND POS ( INFO_SPB_FRN_CPLT, 'RS3220=TLS' ) <= 0" &		
		, 1, idwCmdeSin.RowCount () ) 
Else */
	lVal1 = idwCmdeSin.Find ( &
		"ID_FOUR = 'O2M' AND " + &
		"COD_ETAT <> 'ANN' AND " + &
		"( ID_TYP_ART NOT IN ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' ) " + &
		"  OR " + &
		"  ( ID_TYP_ART = 'RST' AND POS ( INFO_SPB_FRN_CPLT, 'RST_CMDE+SUIVI=OUI' ) > 0 ) " + &
		") " + &
		" AND STATUS_GC NOT IN ( 176, 239, 203 )" &
		, 1, idwCmdeSin.RowCount () ) 
// End If 

// [ITSM331639]
If isChoixAction = "R" And lVal1 > 0 Then
	stMessage.sTitre		= "Commandes"
	stMessage.Icon			= Question!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= YESNO!
	stMessage.sCode		= "COMD885"

	If F_Message ( stMessage ) = 1 Then
		dDteEnvCli = Date ( idwCmdeSin.GetItemDateTime ( lVal1, "DTE_ENV_CLI" ) )
		dJour = Today ()
	
		If dDteEnvCli < F_PLUS_DATE ( dJour, -12, "M" ) And Not bPecForce Then
			stMessage.sTitre		= "Commandes"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!
			stMessage.sCode		= "COMD899"

			ibDecocherPresta = True
			
			F_Message ( stMessage )
		
		Else	
			lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "A_REP_GARANTIE", "OUI", ";")
			
			// [PM280-1][MANTIS14825]
			idwArticle.SetItem(1,"ID_SERIE_ANC", idwCmdeSin.GetItemString ( lVal1, "ID_SERIE_NOUV") ) 
			idwArticle.SetItem ( 1, "ID_MARQ_ART",  idwCmdeSin.GetItemString ( lVal1, "ID_MARQ_ART") ) 
			idwArticle.SetItem ( 1, "ID_MODL_ART",  idwCmdeSin.GetItemString ( lVal1, "ID_MODL_ART") ) 
		End If

	Else
		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "COMD886"			

		ibDecocherPresta = True
		
		F_Message ( stMessage )

	End If
End If
// [PM280-1]

// [PM280-2]
If isChoixAction = "I" And lVal1 > 0 And lIdEvt = 1426 Then
	
	// [ITSM576546]
	Choose Case idwArticle.GetItemString ( alRow, "ID_REF_FOUR") 
		Case "PEC_A_RECYCLER", "REFUSE_A_REEXP"
			// Pas de contrôle
		Case Else
					
			dDteEnvCli = Date ( idwCmdeSin.GetItemDateTime ( lVal1, "DTE_ENV_CLI" ) )
			dJour = Today ()
	
			If dDteEnvCli < F_PLUS_DATE ( dJour, -12, "M" ) And Not bPecForce Then
				stMessage.sTitre		= "Commandes"
				stMessage.Icon			= Exclamation!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= Ok!
				stMessage.sCode		= "COMD899"
	
				ibDecocherPresta = True
				
				F_Message ( stMessage )
			
			Else	
				
				// [PM280-1][MANTIS14825]
				idwArticle.SetItem (1,"ID_SERIE_ANC", idwCmdeSin.GetItemString ( lVal1, "ID_SERIE_NOUV") ) 
				idwArticle.SetItem ( 1, "ID_MARQ_ART",  idwCmdeSin.GetItemString ( lVal1, "ID_MARQ_ART") ) 
				idwArticle.SetItem ( 1, "ID_MODL_ART",  idwCmdeSin.GetItemString ( lVal1, "ID_MODL_ART") ) 
			End If
	End Choose 
End If
	
// [PM295-1]
/*
If F_C_L_E_A_TRUE ( "PM295-1" ) Then
	lVal1 = idwCmdeSin.Find ( &
	   "ID_FOUR = 'PSM' AND " + &
		"COD_ETAT <> 'ANN' AND " + &
		"( ID_TYP_ART = 'PRS' AND " + &
		"POS ( INFO_FRN_SPB_CPLT, 'CHGT_CM=OUI' ) > 0 ) " &
		, 1, idwCmdeSin.RowCount () ) 

	If isChoixAction = "R" And lVal1 > 0 Then
		idwArticle.SetItem(1,"ID_SERIE_ANC", idwCmdeSin.GetItemString ( lVal1, "ID_SERIE_NOUV") ) 
	End If
End If
*/
// [PM295-1]


// [PM200][PSM] Gestion Proximité PSM
// [PC929-1] [PM234-4_V1]
// [PM234-4_V1]
If sIdfour="PSM" And &
   ( isChoixAction = "R" Or ( isChoixAction = "I" AND sIdRefFour = "A_DIAGNOSTIQUER" ) ) And &
	asData="O" And &
	( Not bDeclaWebAtlas Or ( bDeclaWebAtlas And sTypLivrAtlas = "PXM" ) ) &
	Then

	sVar = ""

	// [PM200_5]
	sCpAssure=""
	lRow=idwlstinter.Find("COD_INTER='A'",1,idwlstinter.RowCount())
	If lRow > 0 Then
		sCpAssure=idwlstinter.GetItemString(lRow,"ADR_CP")
	End if
	
	// [PC694][SFR2012]
	sVal = "NON"

	lnv_Key[1].iskeyname	 ="TYP_APP"
	lnv_Key[1].iakeyvalue =isTypApp
	F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 209, lnv_Key )
	
	If lRow > 0 Then
		sVal = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lRow, "VAL_CAR" ), "DNCX_BTQ_PROXMITE", ";")			

		// [PM200_5]
		sVal2= lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lRow, "VAL_CAR" ), "METHODE_WS", ";")
		
		if sVal2="NON" Then bMethode_BoutiquePSM_WS=FALSE
	Else
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 209 )			
		If lDeb > 0 Then
			sVal = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "DNCX_BTQ_PROXMITE", ";")
			sValInclu = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "DNCX_BTQ_TYP_APP_INCLU", ";")
			sValExclu = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "DNCX_BTQ_TYP_APP_EXCLU", ";")
			
			// [PM200_5]
			sVal2= lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "METHODE_WS", ";")
			// [PM200_5].2
			if sVal2="NON" Then bMethode_BoutiquePSM_WS=FALSE
			
		End If
	End If
		
	// [PC869]
	If sVal = "OUI" Then // Deconnexion sous condition

		// Inclusion d'appareil pour les deconnexion
		If Len ( Trim ( sValInclu ) ) > 0 Then
			If Pos ( sValInclu, "#" + isTypApp + "#" ) <= 0 Then
				sVal = "NON"
			End If
		End If

		// Exclusion d'appareil pour les deconnexion			
		If Len ( Trim ( sValExclu ) ) > 0 Then
			If Pos ( sValExclu, "#" + isTypApp + "#" ) > 0 Then
				sVal = "NON"
			End If
		End If
		
	End If
	// :[PC869]	

	// [PM200][LOT2][DESOX]
	// [PM200_LOT3]
	// [VDOC10362]
	If lIdEvt = 1377 And isFournParDefaut = "PSM" Then
		sVal = "OUI" // Pas de btq de prox
	End IF
	// [PM200][LOT2][DESOX]

	// [PM103][1]
	If gbModeReprise_223 Then
		sVal = "OUI" // Pas de btq de prox				
	End If
	// :[PM103][1]

	// [PC801_LOT1_V2]
	lRow = idwWDivsin.Find ( "NOM_ZONE = 'process_prs'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then 
		lVal = idwWDivsin.GetItemNumber ( lRow, "VAL_NBRE" )
		If lVal = 2116 Then
			sVal = "OUI"
		End If
	End If
	// [PC801_LOT1_V2]	

	// [VDOC10556]
	// [MANTIS11433]
	If This.uf_zn_choix_regle_PSM ( "MARQ/MODL" ) = "OUI" And lVal <> 2130 Then
		sVal = "OUI"
	End if
	// [VDOC10556]	
	
	
	// [PM222-1]
	If idwCmdeSin.find ( "( POS ( INFO_SPB_FRN_CPLT, 'A_REPARER_SAV=OUI') > 0 OR POS ( INFO_SPB_FRN_CPLT, 'A_DESOXYDER_SAV=OUI') > 0 ) AND COD_ETAT IN ( 'RPC', 'RFO') AND STATUS_GC IN ( 2, 21, 22, 23 )", 1, idwCmdeSin.rowcount() ) > 0 Then		
		sVal = "OUI"
	End If 
	

	// OUI=Deconnexion, càd pas d'ouverture de fen proxi
	If Trim ( sVal ) <> "OUI" And Not bCasReouv235_236 Then
		
		// [PC938_ORANGE_V3]
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 239 )
		
		// [PC946_ORANGE_OPPRO]
		sVal2 = ""
		If lDeb > 0 Then
			sVal2 = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")			
		End IF

		If lDeb > 0 And sVal2 = "" Then
			stPass.dctab[1]=idwWSin.GetItemNumber ( 1, "ID_SIN" )
			stPass.ltab[1]=1 // Nb max de boutiques sélectionnables
			stPass.sTab[1]="Saisie code(s) boutique(s) pour DEPLACEMENT de l'assuré en proximité"

			// [PM200_5]
			stPass.btab[1]=bMethode_BoutiquePSM_WS	
			stPass.sTab[2]=sCpAssure

			// [VDoc18634]
			stPass.lTab[2]=lIdEvt
			stPass.lTab[3]=lIdProd
			stPass.sTab[3]=isMarqPortAdh
			stPass.sTab[4]=isModlPortAdh
			stPass.sTab[5]=isTypapp

			// [PM234-4_V1]
			If bDeclaWebAtlas Then
				If sTypLivrAtlas <> "PXM" Then 
					bDeclaWebAtlas = False
				Else
					lnvPFCString.of_setkeyvalue( Message.StringParm, "BOUTIQUES", sCodLivrAtlas  , ";")
				End If
			End If
			// /[PM234-4_V1]
	
			If Not bDeclaWebAtlas Then
				OpenWithParm( w_sp_trt_saisie_boutiques,  stPass ) 	
			End If 
		Else
			// [PM200_5]
			stPass.btab[1]=bMethode_BoutiquePSM_WS	
			stPass.sTab[1]=""
			stPass.sTab[2]=sCpAssure
			stPass.dctab[1]=idwWSin.GetItemNumber ( 1, "ID_SIN" )
			
				// [VDoc18634]
			stPass.lTab[2]=lIdEvt
			stPass.lTab[3]=lIdProd
			stPass.sTab[3]=isMarqPortAdh
			stPass.sTab[4]=isModlPortAdh
			stPass.sTab[5]=isTypapp

			// [PM234-4_V1]
			If bDeclaWebAtlas Then
				If sTypLivrAtlas <> "PXM" Then 
					bDeclaWebAtlas = False
				Else
					lnvPFCString.of_setkeyvalue( Message.StringParm, "BOUTIQUES", sCodLivrAtlas  , ";")
				End If
			End If
			// /[PM234-4_V1]
	
			If Not bDeclaWebAtlas Then			
				OpenWithParm( w_sp_trt_saisie_boutiques,  stPass ) 	
			End If
		End if
			
		// :[PC938_ORANGE_V3]
		
		sVar = Message.StringParm
	
		If sVar = "" or sVar = "[RETOUR]" Then 
			// Pas de boutique sélectionné

			// [VDOC18588]
			/*
			If F_CLE_SHUNT_A_TRUE ( "VDOC18588" ) Then					
				F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 283 )
				For lCptDetPro = lDeb To lFin
			
					sVal = idw_DetPro.GetItemString ( lCptDetPro, "VAL_CAR" ) 
					sVal = lnvPFCString.of_getkeyvalue (sVal, "MODL", ";")								
			
					If Pos ( isModlPortAdh, sVal ) > 0 Then
						isInfoSpbFrnCplt = ""
						ibvDoc18588_KoProxiPSM_GoToO2M = TRUE
						This.uf_InitParDefaut (1)
						ibvDoc18588_KoProxiPSM_GoToO2M = False
						
						// Relecture obligatoire !
						sIdFour=Upper ( adw.GetItemString ( alRow, "ID_FOUR" ) )
						sIdTypArt = Upper ( adw.GetItemString ( alRow, "ID_TYP_ART" )	)
						sIdReffour = Upper ( adw.GetItemString ( alRow, "ID_REF_FOUR" )	)
						Exit
					End If
				Next
			End If
			*/
			
			// PC929_CDISCOUN_M8540
			stMessage.sTitre  	= "Controle de zone"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.bouton 		= Ok!
			stMessage.sCode="COMD825"
			f_message(stMessage)				
			
		Else	
			// parser BOUTIQUES=#...#...#
			isCodeBoutiqueProximitePSM = lnvPFCString.of_Getkeyvalue( sVar, "BOUTIQUES", ";") 
			lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_BTQ_PSM_PROXIMITE", isCodeBoutiqueProximitePSM , ";")

			// Info FPI - La boutique de centralisation devient la première boutique de proxi
			// [PM257-1] Suppression du forçage de btq de centralisation
			/*
				sVal = lnvPFCString.of_Getkeyvalue( sVar, "BOUTIQUES", ";")
				iPos = Pos ( sVal, "#")
				If iPos > 0 Then
					iPos = Pos ( sVal, "#", iPos + 1)
					If iPos > 0 Then					
						sVal = Left ( sVal, iPos )
					End If
				End If
				
				isCodeBoutiqueCentralPSM = F_REMPLACE ( sVal , "#", "" )
				lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_BTQ_PSM_CENTRALE", isCodeBoutiqueCentralPSM, ";")
			*/
			// [PM257-1]
			
		End if

		// [PM257-1] Suppression du forçage de btq de centralisation
		/*	
			// [PC938_ORANGE_V3] nouveau process
			F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 239 )
			
			// [PC946_ORANGE_OPPRO]
			sVal2 = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")	
			
			// [PM234-4_V1] And Not bDeclaWebAtlas
			If lDeb > 0 And isCodeBoutiqueProximitePSM = "" And sVal2 = "" And Not bDeclaWebAtlas Then
	
				stMessage.sTitre  	= "Controle de zone"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.bouton 		= Ok!
				stMessage.sCode="COMD807"
				f_message(stMessage)
	
				
				stPass.dctab[1]=idwWSin.GetItemNumber ( 1, "ID_SIN" )
				stPass.ltab[1]=1 // Nb max de boutiques sélectionnables
				stPass.sTab[1]="Saisie code(s) boutique(s) pour TRANSFORMATION en code de centralisation"
		
				// [PM200_5]
				stPass.btab[1]=bMethode_BoutiquePSM_WS	
				stPass.sTab[2]=sCpAssure
					
				OpenWithParm( w_sp_trt_saisie_boutiques,  stPass ) 	
				
				sVar = Message.StringParm
			
				If sVar = "" or sVar = "[RETOUR]" Then 
					// Pas de boutique sélectionné
				Else	
					// parser BOUTIQUES=#...#...#
					isCodeBoutiqueCentralPSM = F_REMPLACE ( lnvPFCString.of_Getkeyvalue( sVar, "BOUTIQUES", ";"), "#", "" )
					lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_BTQ_PSM_CENTRALE", isCodeBoutiqueCentralPSM, ";")
				End if				
			*/
			// [PC938_ORANGE_V3]
		   // :[PM257-1]		
			
		
	End If
	// [PC694][SFR2012]

	// [PC874]
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 218 )
	If lDeb > 0 Then
		Choose Case  idwWSin.GetItemNumber ( 1, "ID_ETS" )
			Case 1001 // Martinique

				//isCodeBoutiqueProximitePSM = "#59#"
				
				
			Case 1002 // Guadeloupe
				isCodeBoutiqueProximitePSM = "#60#"
				lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_BTQ_PSM_PROXIMITE", isCodeBoutiqueProximitePSM , ";")
		End Choose
	End if
	// :[PC874]	

	
	
End if
// :[PM200][PSM]


// [VDoc7285]
If asData="O" Then
	If adw.GetItemString(alRow,"ID_REF_FOUR") = "A_DIAGNOSTIQUER" Then
		If idwCmdeSin.Find("ID_TYP_ART='PRS' and COD_ETAT <> 'ANN'",1,idwCmdeSin.RowCount()) > 0 Then
			// Erreur
			iRet=2
			stMessage.sCode="COMD716"
		End if
	End if
	
	If sTypArt="PRS" Then
		If idwCmdeSin.Find("ID_REF_FOUR='A_DIAGNOSTIQUER' and COD_ETAT <> 'ANN'",1,idwCmdeSin.RowCount()) > 0 And &
			( lnvPFCString.of_Getkeyvalue( isInfoSpbFrnCplt, "A_REP_GARANTIE", ";" ) <> "OUI" ) &
		Then
			// Erreur
			iret=2
			stMessage.sCode="COMD715"
		End if
	End if
	
	If iRet=2 Then
		stMessage.sTitre  	= "Controle de zone"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.bouton 		= Ok!
		f_message(stMessage)
		
		Return 2
	End if
End If
// :[VDoc7285]

// [VDOC8041]
If adw.GetItemString ( alRow, "ID_TYP_ART" ) = "PRS" And &
	adw.GetItemString ( alRow, "ID_FOUR" ) = "O2M" And &
	asData="O" Then
	
	If idwCmdeSin.Find("ID_FOUR = 'O2M' AND ID_TYP_ART = 'PRS' AND COD_ETAT NOT IN ( 'ANN', 'RFO', 'RPC') AND STATUS_GC = 232",1,idwCmdeSin.RowCount()) > 0 Then

		sVar = "[RETOUR]"

		Do While sVar = "[RETOUR]"
			OpenWithParm( w_sp_trt_saisie_codeverrou,  idwWSin.GetItemNumber ( 1, "ID_SIN" ) ) 
			sVar = Message.StringParm
			
			If sVar = "[RETOUR]" Then
				stMessage.sTitre  	= "Controle de zone"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.bouton 		= Ok!
				stMessage.sCode 		= "COMD744"
				f_message(stMessage)					
			End If
			
		Loop 

		// parser CODE_VERROU=
		sCodeVerrou = lnvPFCString.of_Getkeyvalue( sVar, "CODE_VERROU", ";") 
		lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_VERROU", sCodeVerrou, ";")
		ibReouvPrestaO2M = TRUE
		ibPasDeSaisieProbleme = TRUE
		ibDecocherPrestaO2M = TRUE
	End IF
End If
// [VDOC8041]


// [VDOC8041]
If bCasReouv235_236 Then
	stMessage.sTitre  	= "Controle de zone"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.bouton 		= YesNo!
	stMessage.sCode 		= "COMD808"
	If f_message(stMessage) = 1 Then
		lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "SECONDE_VISITE", "OUI", ";")
		lnvPFCString.of_setkeyvalue( isInfoSpbFrnCpltTempo, "SECONDE_VISITE", "OUI", ";")
	Else 
		lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "SECONDE_VISITE", "NON", ";")
		lnvPFCString.of_setkeyvalue( isInfoSpbFrnCpltTempo, "SECONDE_VISITE", "NON", ";")				
	End If

	ibReouvPrestaO2M = TRUE
	ibPasDeSaisieProbleme = TRUE
	ibDecocherPrestaO2M = TRUE
End If
// [VDOC8041]


/*------------------------------------------------------------------*/
/* Si l'article dépasse le Plafond, on ne peut pas le cocher.       */
/* De toute façon le coche dans ce cas est hors de l'écran avec un  */
/* X=4000 mais il le code ci-dessous de gérer une éventuelle        */
/* pression sur la barre qui cocherait alors l'article.             */
/*------------------------------------------------------------------*/
// [HP252_276_HUB_PRESTA]
If F_CLE_A_TRUE ( "HP252_276_HUB_PRESTA" ) Then
	If ( sTypArt <> "PRS" Or sTypArt <> "EDI" ) And asData = "O" And alrow > 0 Then
		dcMtPrixTTC = adw.GetItemDecimal ( alRow, "MT_PRIX_TTC" ) // #4
		If dcMtPrixTTC > adw.GetItemDecimal ( alRow, "MT_PLAF" )  Then
			iRet = 2
		End If 
	End If
Else 
	If sTypArt <> "PRS" And asData = "O" Then
		dcMtPrixTTC = adw.GetItemDecimal ( alRow, "MT_PRIX_TTC" ) // #4
		If dcMtPrixTTC > adw.GetItemDecimal ( alRow, "MT_PLAF" )  Then
			iRet = 2
		End If 
	End If
End If

/*------------------------------------------------------------------*/
/* On incrémente/Décrémente les compteur de fournisseurs et de      */
/* type d'article.                                                  */
/*------------------------------------------------------------------*/

If iRet = 0 Then 
	If asData = "O" Then
		// On Coche
		// [ITSM150589] ajout des 3 If lRow > 0 Then 
		lRow = idwFourn.Find ( "ID_CODE_FRN = '" + sIdFour + "'", 1, idwFourn.RowCount () )
		If lRow > 0 Then idwFourn.SetItem ( lRow, "NBRE", idwFourn.GetItemNumber ( lRow, "NBRE" ) + 1 )

		lRow = idwFourn.Find ( "Left (ID_CODE_FRN, 4) = 'TOUS'", 1, idwFourn.RowCount () ) 
		If lRow > 0 Then idwFourn.SetItem ( lRow, "NBRE", idwFourn.GetItemNumber ( lRow, "NBRE" ) + 1 )

		lRow = idwTypArt.Find ( "ID_CODE_FRN = '" + sIdFour + "' AND ID_CODE_ART = '" + sIdTypArt + "'", 1, idwTypArt.RowCount () ) 
		If lRow > 0 Then idwTypArt.SetItem ( lRow, "NBRE", idwTypArt.GetItemNumber ( lRow, "NBRE" ) + 1 )

		ilNbCmde ++

		/*------------------------------------------------------------------*/
		/* #1 : Gestion particuliere DARTY -DP 11                           */
		/*------------------------------------------------------------------*/
		// #8 [MOBISQUARE]
/*
		If sTypArt = "TEL" And bSel3MobAuto Then 
			ilCptOrdre ++
			adw.SetItem ( alRow, "PROBLEME", String ( ilCptOrdre ) ) 
		End If

// #1, #3
		If bSel3MobAuto and bGestionDartyNomade And Pos ( isCasGestionDartyNomade, "CMD_DTY", 1 ) > 0 Then 
			ilCptOrdre ++
			adw.SetItem ( alRow, "PROBLEME", String ( ilCptOrdre ) ) 
		End If
*/

		// [PC13174]
		If bGestionAxaVirtuelle Then

			idwCmde.SetItem(1,"ID_SERIE_ANC","X")
			idwArticle.SetItem(1,"ID_SERIE_ANC","X")
			idwArticle.SetItem(1,"INFO_SPB_FRN",1790)			

			// [DT353]
			idwArticle.SetItem (1, "PROBLEME", "Changement de serrure à effectuer")				
			
		End if
		// :[PC13174]
		
// #1, #3
		If bSel3MobAuto Then
			If bGestionDartyNomade And Pos ( isCasGestionDartyNomade, "CMD_DTY", 1 ) > 0 Then 
				ilCptOrdre ++
				adw.SetItem ( alRow, "PROBLEME", String ( ilCptOrdre ) ) 
			Else
				Choose Case sTypArt
               //* #9 [O2M_DIAG_NOMADE].[JFF].[20090810170829127] Ajout EDI
					// [PC10][DIAG_NOMADE]
               Case "CAF", "AEF", "CAS", "SMS", "PRS", "EDI", "DEV"
						// Exclusion						
					Case Else
						ilCptOrdre ++
						adw.SetItem ( alRow, "PROBLEME", String ( ilCptOrdre ) ) 
				End Choose
			End If
		End IF
		// :#8 [MOBISQUARE]	
		
		/*------------------------------------------------------------------*/
		/* On déprotège les zones  (-IF)                                    */
		/* saisie du RIB pour les frais												  */
		/*------------------------------------------------------------------*/
		/* Juste avant d'agrandir, on prépare le label et le filtre pour    */
		/* liste INFO_SPB_FRN				                                   */
		/* # Ajout du code 310 pour cordon											  */		
		/*------------------------------------------------------------------*/
		If not ibDecocherPresta Then
			This.uf_GestionZone_infospbfrn ( alRow, adw )
		End If
		// [PC938_ORANGE_V3]
		// [PM280-1]
		If bORANGE_V3_CMDE And ( not ibDecocherPresta ) Then
			This.uf_zn_choix_process_Cmde_OrangeV3 ( adw, alrow, sTypArt, isChoixAction )
		End If
		// /[PC938_ORANGE_V3]

		// [RS3200]
		If Not bORANGE_V3_CMDE Then
			If sIdFour = "TLS" Then
				idwArticle.SetItem(1,"INFO_SPB_FRN", 975)			
			End If 
		End If 

		// [PC321]
		If sIdFour = "SCR" And sTypArt="PRS" Then // [PC846/864] Ajout du ctrl sur PRS
			ibPasDeSaisieProbleme = TRUE
			// Pas de saisie dans zone probleme pour SCR.
		End If

		// #12 [MSS_LOT2]
		// Forçage décochage immédiat
		If ibDecocherPresta Then
			idwArticle.SetItem ( alRow, "CHOIX", "N" )
			ibDecocherPresta = FALSE

			// [PC321]
			ibPasDeSaisieProbleme = FALSE
			
			lRow = idwFourn.Find ( "ID_CODE_FRN = '" + sIdFour + "'", 1, idwFourn.RowCount () )
			idwFourn.SetItem ( lRow, "NBRE", idwFourn.GetItemNumber ( lRow, "NBRE" ) - 1 )
	
			lRow = idwFourn.Find ( "Left (ID_CODE_FRN, 4) = 'TOUS'", 1, idwFourn.RowCount () ) 
			If lRow > 0 Then idwFourn.SetItem ( lRow, "NBRE", idwFourn.GetItemNumber ( lRow, "NBRE" ) - 1 )
	
			lRow = idwTypArt.Find ( "ID_CODE_FRN = '" + sIdFour + "' AND ID_CODE_ART = '" + sIdTypArt + "'", 1, idwTypArt.RowCount () ) 
			idwTypArt.SetItem ( lRow, "NBRE", idwTypArt.GetItemNumber ( lRow, "NBRE" ) - 1 )
	
			ilNbCmde --			
			
			Return 2
		End If
		// #12 [MSS_LOT2]		
		
		// [VDOC12443]
		// [PM246][MANTIS10193]			
		// [VDOC20198]
		// [PM280-2]
		// [DT288]
		If idwCmdeSin.Find("ID_FOUR IN ('O2M', 'PSM', 'COR' ) AND ID_TYP_ART = 'PRS' AND COD_ETAT NOT IN ( 'ANN', 'RFO', 'RPC') AND STATUS_GC = 232",1,idwCmdeSin.RowCount()) <= 0 Then
			Choose Case sIdFour  
				Case "O2M", "PSM", "COR"
					Choose Case sIdRefFour
						Case "A_REPARER", "A_DIAGNOSTIQUER", "A_DESOXYDER", "CONTEST_SUR_REMPL"
							This.Uf_Q_IOS7 () 
					End Choose
			End Choose
		End If

//* #5 [DCMP080256][EEE_PC_ASUS]  Ajout 610
		Choose Case adw.GetItemNumber ( alRow, "INFO_SPB_FRN" ) 
			Case 110, 210, 310, 610 
				idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "0" )
		End Choose 

		adw.Setcolumn ( "ID_SERIE_ANC" )
		adw.SetFocus ()

	Else
		// On DéCoche
		lRow = idwFourn.Find ( "ID_CODE_FRN = '" + sIdFour + "'", 1, idwFourn.RowCount () )
		idwFourn.SetItem ( lRow, "NBRE", idwFourn.GetItemNumber ( lRow, "NBRE" ) - 1 )

		lRow = idwFourn.Find ( "Left (ID_CODE_FRN, 4) = 'TOUS'", 1, idwFourn.RowCount () ) 
		If lRow > 0 Then idwFourn.SetItem ( lRow, "NBRE", idwFourn.GetItemNumber ( lRow, "NBRE" ) - 1 )

		lRow = idwTypArt.Find ( "ID_CODE_FRN = '" + sIdFour + "' AND ID_CODE_ART = '" + sIdTypArt + "'", 1, idwTypArt.RowCount () ) 
		idwTypArt.SetItem ( lRow, "NBRE", idwTypArt.GetItemNumber ( lRow, "NBRE" ) - 1 )

		// [PC321]
		ibPasDeSaisieProbleme = FALSE

		ilNbCmde --

		//* #6 [FNAC_PROD_ECH_TECH]
		// isInfoSpbFrncplt = ""
		//* #11 [20091019114301233]
		//* #12 [MSS_LOT2]
//		If isInfoSpbFrncplt <> "" Then
		If isInfoSpbFrncplt <> "" Or ibDecocherPresta Or ibReouvPresta Or isCas2FluxMS1 <> "" Then			
			stMessage.sTitre		= "Commandes"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!
			stMessage.sCode		= "COMD568"			
			
			F_Message ( stMessage )
			
			idwArticlePrs.Setfilter ("") 
			idwArticlePrs.filter () 
			idwArticlePrs.Rowsdiscard ( 1, idwArticlePrs.Rowcount (), Primary! )
			
			idwArticle.Setfilter ("") 
			idwArticle.filter () 
			idwArticle.Rowsdiscard ( 1, idwArticle.Rowcount (), Primary! )

			isInfoSpbFrncplt = ""
		End If
		//* #11 [20091019114301233]

	End If

	Choose Case isChoixAction
		Case "S"
			sVar  = "sélection sur courrier"
			sVar1 = "sélections sur courrier"
		Case "C"
			sVar  = "commande"
			sVar1 = "commandes"
		Case "R"
			sVar  = "réparation"
			sVar1 = "réparations"
		Case "I"
			sVar  = "information"
			sVar1 = "informations"
	End Choose

	If ilNbCmde <= 0 Then 
		idwBandeau.SetItem ( 1, "NOUV_CMDE", "Aucune nouvelle " + sVar )
	ElseIf ilNbCmde = 1 Then 
		idwBandeau.SetItem ( 1, "NOUV_CMDE", String ( ilNbCmde ) + " nouvelle " + sVar )
	ElseIf ilNbCmde > 0 Then 
		idwBandeau.SetItem ( 1, "NOUV_CMDE", String ( ilNbCmde ) + " nouvelles " + sVar1 )
	End If

End If

// [PM234-4_V1]
If bDeclaWebAtlas Then
	If asData = "O" And isChoixAction = "R" Then
		idwArticlePrs.SetItem  ( alRow, "PROBLEME", Upper ( Left ( idwWsin.GetItemString ( 1, "TXT_MESS" ), 254) ) )
	End If 
End If
// /[PM234-4_V1]

Return iRet
end function

private function integer uf_zn_infospbfrn (ref datawindow adw, string asdata, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_Zn_InfoSpbFrn (PRIVATE)
//* Date				: 19/09/2001
//* Libellé			: Zone Info_Spb_Frn
//* Commentaires	: 
//*
//* Arguments		: aDw				DataWindow	Val
//*					  asData			String		Val
//*					  alRow			String		Val
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF	  07/02/2006  [DCMP060119] modif suite ajout frn AEVUM
//* #2    MADM	  10/05/2006  [DCMP060356] modif suite Rempl frn AEVUM par CORDON
//* #3	 JCA	  26/12/2006	DCMP 060907 - Changement de l'appel à F_Determiner_Montant_Frais_Envoi
//*										ajout des arguments alidprod (Val), adwdetpro (Ref), adcFrais (Ref)
//* #4	 PHG	  12/12/2007  [O2M]: Gestion de l'interdication de modification.
//* #5    JFF    31/03/2008  [SURCOUF_ECH_EXPRESS]
//* #6    JFF    01/04/2008  [DCMP080256][EEE_PC_ASUS] 
//* #7	 JFF	  20/10/2008  [FNAC_PROD_ECH_TECH]
//* #8    JFF    30/03/2008  [FNAC_PROD_ECH_TECH].[20090330152547023] Exclusion 903 de l'interdiction
//* #9    JFF    02/09/2009  [DCMP090327].[SBETV]
//* #10   JFF    25/11/2009  [MSS_DIAG]
//* #11   JFF    02/03/2010  [MSS_LOT2]
//*  	    JFF	  13/04/2010  [WEBSIM2].[FRANCE]
//*  	    JFF	  13/04/2010  [ADRESSE_O2M]
//*       JFF    17/05/2010  [DCMP100302].[20100517204909090]
//*		 FPI	 02/07/2010		[PC321]
//* 	  FPI	24/06/2010 [DCMP100551] Modification de l'option 76
//*       JFF    22/09/2010  [PM01].[LOT3&4]
//*       JFF    30/06/2010  [PC363_AUCHAN]
//*       JFF   09/09/2011   [PC499][PC501][PC545][-1x3][V5]
//        JFF   30/08/2012   [VDOC8041]
//*       JFF  13/11/2012    [VDOC9057]
//*       JFF  02/04/2013    [PC929_CDISCOUNT]
//		FPI	11/07/2014 [VDOC14882]
//       JFF   02/01/2015 [PC801_6_TAMET]
//		JFF	03/07/2015 [PM280-1][MANTIS15456]
//        JFF   07/03/2024   [HP252_276_HUB_PRESTA]
//*---------------------------------------------------------------

Int iRet
Long	lLen, lCpt
Dec {2} dcFrais
String sNomLigne1, sNomLigne2, sAdrLigne1, sAdrLigne2, sCP, sVille, sAdresseO2m, sIdRefFour, sIdFour
n_cst_cmd_commun	lnvCmdCommun
Long lDeb, lFin
Boolean bARepGti 
n_cst_string lnv_string


// #5 [SURCOUF_ECH_EXPRESS]
DataWindowChild dwChild 
Long lVal, lRow
Long lIdGti 
String sVal 
// :#5

// [PM280-1][MANTIS15456]
bARepGti = lnv_string.of_Getkeyvalue( isInfoSpbFrnCplt, "A_REP_GARANTIE", ";" ) = "OUI"

// [PC363_AUCHAN]
sIdRefFour 	= Upper ( aDw.GetItemString ( alRow, "ID_REF_FOUR" ) )

// [BLCODE]
sIdFour 	= Upper ( aDw.GetItemString ( alRow, "ID_FOUR" ) )

// [ADRESSE_O2M]
lIdGti = idwDetail.GetItemNumber ( 1, "ID_GTI" )
// [ADRESSE_O2M]
// [VDOC9057] "A_DIAGNOSTIQUER",&
// [VDOC14882]
lnvCmdCommun.uf_GetAdresseO2M_2 ( &
"A_DIAGNOSTIQUER",&
"", &
Long ( asData ) , &
isTypApp,&
"EDI",&
"CNV",&
lIdGti,&
ismodlportadh , &
isInfoSpbFrnCplt,&
idwCmdeSin,&
idwWDivSin,&
idw_DetPro,& 
idwWsin.GetItemNumber ( 1, "ID_PROD" ),&
sNomLigne1,&
sNomLigne2,& 
sAdrLigne1,& 
sAdrLigne2,&
sCP,&
sVille )
// :[VDoc14882]

	sAdresseO2m	= ""
	If Not IsNull ( sNomLigne1 ) And Len ( sNomLigne1 ) > 0 Then sAdresseO2m += sNomLigne1 + Char ( 13 ) 
	If Not IsNull ( sNomLigne2 ) And Len ( sNomLigne2 ) > 0 Then sAdresseO2m += sNomLigne2 + Char ( 13 ) 
	If Not IsNull ( sAdrLigne1 ) And Len ( sAdrLigne1 ) > 0 Then sAdresseO2m += sAdrLigne1 + Char ( 13 ) 
	If Not IsNull ( sAdrLigne2 ) And Len ( sAdrLigne2 ) > 0 Then sAdresseO2m += sAdrLigne2 + Char ( 13 ) 
	If Not IsNull ( sCP ) And Len ( sCP ) > 0 Then sAdresseO2m	+=	sCP
	If Not IsNull ( sVille ) And Len ( sVille ) > 0 Then sAdresseO2m	+=	" " + sVille 
// [ADRESSE_O2M]
iRet = 0

//* #6 [MSS_LOT2]
If iRet = 0 And ( ibReouvPresta Or ibReouvPrestaO2M ) Then
	iRet = 1
	Return iRet
End IF

/*------------------------------------------------------------------*/
/* On ne déprotège que si le client envoi lui-même son mobile code  */
/* 110,210,310 (-IF)                                                */
/*------------------------------------------------------------------*/
Choose Case Long ( asData ) 
	// A-NOVO
	//* #6 [DCMP080256][EEE_PC_ASUS] 	
	Case 110, 610
		idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "0" )

		// Message d'information
		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
//		stMessage.sVar [1]   = F_Determiner_Montant_Frais_Envoi ( asData, idwWsin.object.id_prod[1], idw_DetPro, dcFrais ) // #3
		stMessage.sVar [1]   = F_Determiner_Montant_Frais_Envoi ( asData, idwWsin.object.id_prod[1], istypapp, idw_DetPro, dcFrais )  // [DCMP100551]
		stMessage.sVar [2]   = String ( idwCmde.GetItemNumber ( 1, "ID_SIN" ) ) + "-" + String (  This.uf_Nouveau_Num_Sequence () ) 
		If Long ( asData ) = 110 then stMessage.sCode = "COMD078" // Brive
		If Long ( asData ) = 610 then stMessage.sCode = "COMD083" // Angers
		F_Message ( stMessage )

	// SBE
	Case 210
		idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "0" )

		// Message d'information
		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		//stMessage.sVar [1]   = F_Determiner_Montant_Frais_Envoi ( asData, idwWsin.object.id_prod[1], idw_DetPro, dcFrais ) // #3
		stMessage.sVar [1]   = F_Determiner_Montant_Frais_Envoi ( asData, idwWsin.object.id_prod[1], istypapp, idw_DetPro, dcFrais )  // [DCMP100551]
		stMessage.sVar [2]   = String ( idwCmde.GetItemNumber ( 1, "ID_SIN" ) ) + "-" + String (  This.uf_Nouveau_Num_Sequence () ) 
		stMessage.sCode		= "COMD079"
		F_Message ( stMessage )

	// AEVUM #1  Rempl de AEVUM par CORDON #2
	Case 310
		idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "0" )

		// Message d'information
		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		//stMessage.sVar [1]   = F_Determiner_Montant_Frais_Envoi ( asData, idwWsin.object.id_prod[1], idw_DetPro, dcFrais ) // #3
		stMessage.sVar [1]   = F_Determiner_Montant_Frais_Envoi ( asData, idwWsin.object.id_prod[1], istypapp, idw_DetPro, dcFrais ) // [DCMP100551]
		stMessage.sVar [2]   = String ( idwCmde.GetItemNumber ( 1, "ID_SIN" ) ) + "-" + String (  This.uf_Nouveau_Num_Sequence () ) 
		stMessage.sCode		= "COMD081"
		F_Message ( stMessage )

	//* #7 [FNAC_PROD_ECH_TECH]
	//* #8 [FNAC_PROD_ECH_TECH].[20090330152547023] Exclusion 903 de l'interdiction
	// [PC363_AUCHAN]
	Case 410 TO 499, 900 TO 902, 904 TO 964, 967 TO 969, 972 TO 999 // [O2M] Gestion de l'interdication de changment de info_spb_frn pour o2M
			
			// On gère l'interdiction de modification de info_spb_frn
			iRet = 1 // Declenchement de l'item error et gestion du message par uf_gerermessage
						// pas de gestion possible de iiError, et d'utilisation invTrt.uf_SetReset car la dw_article
						// n'herite pas de u_datawindows.
						
			// [BLCODE]
			If isPrcBLCODE <> "" And sIdfour = "BLC" Then
				If Pos ( isPrcBLCODE, "#" + asData + "#" ) > 0 Then
					iRet = 0
				End If 
			End If
			
			// [PC929_CDISCOUNT]
			F_RechDetPro ( lDeb, lFin, idw_DetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 235 )						
			If lDeb > 0 Then
				If Long ( asData ) = 968 And idwArticle.GetItemNumber ( alrow, "INFO_SPB_FRN" ) = 967 Then
					iRet = 0
				End If
				
				If Long ( asData ) = 935 And idwArticle.GetItemNumber ( alrow, "INFO_SPB_FRN" ) = 937 Then
					iRet = 0
				End If

				If Long ( asData ) = 940 And idwArticle.GetItemNumber ( alrow, "INFO_SPB_FRN" ) = 942 Then
					iRet = 0
				End If
				
			End If

	// [PC363_AUCHAN]
	Case 970, 971 // [O2M] Gestion de l'interdication de changment de info_spb_frn pour o2M

			If sIdRefFour <> "DECISION_SPB" Then
				// On gère l'interdiction de modification de info_spb_frn
				iRet = 1 // Declenchement de l'item error et gestion du message par uf_gerermessage
							// pas de gestion possible de iiError, et d'utilisation invTrt.uf_SetReset car la dw_article
							// n'herite pas de u_datawindows.
			End If
	// :[PC363_AUCHAN]

	//* #9 [DCMP090327].[SBETV]
	Case 1100 TO 1102, 1104 TO 1199 // Gestion de l'interdication de changment de info_spb_frn pour SBETV
			
			// On gère l'interdiction de modification de info_spb_frn
			iRet = 1 // Declenchement de l'item error et gestion du message par uf_gerermessage
						// pas de gestion possible de iiError, et d'utilisation invTrt.uf_SetReset car la dw_article
						// n'herite pas de u_datawindows.

	//* #10  [MSS_DIAG]
	Case 1200 TO 1202, 1204 TO 1299 // Gestion de l'interdication de changment de info_spb_frn pour SBETV
			
			// On gère l'interdiction de modification de info_spb_frn
			iRet = 1 // Declenchement de l'item error et gestion du message par uf_gerermessage
						// pas de gestion possible de iiError, et d'utilisation invTrt.uf_SetReset car la dw_article
						// n'herite pas de u_datawindows.


	// [SURCOUF_ECH_EXPRESS]
	Case 510 
		idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "0" )

		// #5
		idwWsin.GetChild ( "ID_ORIAN_BOUTIQUE", dwChild )
		lVal = idwWsin.GetItemNumber ( 1, "ID_ORIAN_BOUTIQUE" )
		If IsNull ( lVal ) Then 
			sVal = ""
		Else
			lRow = dwChild.Find ( "ID_BOUTIQUE = " + String ( lVal ), 1, dwChild.Rowcount () )
			If lRow > 0 Then
				sVal = "Numéro " + String (lVal) + " " + dwChild.GetItemString ( lRow, "ADR_VILLE" )
			Else 
				sVal = ""
			End If
		End If


		// Message d'information
		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		//stMessage.sVar [1]   = F_Determiner_Montant_Frais_Envoi ( asData, idwWsin.object.id_prod[1], idw_DetPro, dcFrais ) // #3
		stMessage.sVar [1]   = F_Determiner_Montant_Frais_Envoi ( asData, idwWsin.object.id_prod[1], istypapp, idw_DetPro, dcFrais ) // [DCMP100551]
		stMessage.sVar [2]   = sVal
		stMessage.sVar [3]   = String ( idwCmde.GetItemNumber ( 1, "ID_SIN" ) ) + "-" + String (  This.uf_Nouveau_Num_Sequence () ) 
		stMessage.sCode		= "COMD082"
		F_Message ( stMessage )
		
		// :#5 [SURCOUF_ECH_EXPRESS]

// #8 [DCMP090109] 
	Case 1010
		
		// On gère l'interdiction de modification de info_spb_frn
		iRet = 1 // Declenchement de l'item error et gestion du message par uf_gerermessage
					// pas de gestion possible de iiError, et d'utilisation invTrt.uf_SetReset car la dw_article
					// n'herite pas de u_datawindows.
			
	// [PC321] - CARREFOUR FRANCE CASSE VOL - 1410 automatique et non modifiable
	Case 1415 to 1455

			iRet=1

// [PM01].[LOT3&4]
	Case 1502 TO 1503, 1505

			
			// On gère l'interdiction de modification de info_spb_frn
			iRet = 1 // Declenchement de l'item error et gestion du message par uf_gerermessage
						// pas de gestion possible de iiError, et d'utilisation invTrt.uf_SetReset car la dw_article
						// n'herite pas de u_datawindows.


	Case 1504


			If adw.GetItemNumber ( alRow, "INFO_SPB_FRN" ) <> 1503 Then
				iRet = 1
			End If

		
// :[PM01].[LOT3&4]		

//  [PC499][PC501][PC545][-1x3][V5]
	Case 965, 966

			If Not ( sIdRefFour = "PEC_A_RECYCLER" And adw.GetItemNumber ( alRow, "INFO_SPB_FRN" ) = 0 ) Then
				iRet = 1
			End If

		
	// [PM200] // [PC877]
	Case  2103 TO 2199 // [O2M] Gestion de l'interdication de changment de info_spb_frn pour o2M
			
			// On gère l'interdiction de modification de info_spb_frn
			iRet = 1 // Declenchement de l'item error et gestion du message par uf_gerermessage
						// pas de gestion possible de iiError, et d'utilisation invTrt.uf_SetReset car la dw_article
						// n'herite pas de u_datawindows.

	// [PC801_6_TAMET]
	Case 2503 To 2599
		
		iRet = 1

	// [HP252_276_HUB_PRESTA]
	Case 3510 To 3599
		
		iRet = 1

						
						
	Case Else
		idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "1" )

End Choose 

Return iRet

end function

private function string uf_controlergestion_cegetel (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction      : W_Sp_Gamme::uf_ControlerGestion_CEGETEL ( PRIVATE )
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 04/10/2002 16:19:15
//* Libellé       : 
//* Commentaires  : 
//*
//* Arguments     : Aucun
//*
//* Retourne      : String	:	1 lettre + nom zone erreur ( lettre = dw sur laquelle se situe l'erreur )
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   	11/03/2003 Ajout de contrôles sur adresses et ville
//        JFF     11/02/2014 [DT57_CMDE_IPHONE_SFR]
//*-----------------------------------------------------------------

DataWindowChild	dwChild
String				sPos, sDw, sVal, sIdTypArtcmd, sIdFour, sIdModl
Long					lRow, lLen, lLen1, lDeb, lFin, lModule
n_cst_string lnvPFCString

sPos = ""

lRow = idwFourn.GetRow ()

sIdTypArtCmd  = Upper ( idwArticle.GetItemString ( alCpt, "ID_TYP_ART" ) )
sIdFour = Upper ( idwArticle.GetItemString ( alCpt, "ID_FOUR" ) )
sIdModl = Upper ( idwArticle.GetItemString ( alCpt, "ID_MODL_ART" ) )

idwCmde.GetChild ( "ADR_COD_CIV", dwChild )
lRow = dwChild.GetRow ()
lLen = 0
lLen1 = Len ( Trim ( dwChild.GetItemString ( lRow, "LIB_CODE" ) ) ) 
If Not IsNull ( lLen1 ) Then lLen += lLen1

lLen1	= Len ( Trim ( idwCmde.GetItemString ( 1, "ADR_NOM" ) ) )
If Not IsNull ( lLen1 ) Then lLen += lLen1

lLen1	= Len ( Trim ( idwCmde.GetItemString ( 1, "ADR_PRENOM" ) ) )
If Not IsNull ( lLen1 ) Then lLen += lLen1

// -2 pour les 2 espaces entre la civilité et le nom, et le nom et le prénom
If lLen >= 30 - 2 Then
	sDw = "D"
	stMessage.sCode = "COMD038"
	F_Message ( stMessage )
	Return sDw + "ADR_NOM"
End If

/*------------------------------------------------------------------*/
/*	#1 ADR_CPL <= 30                                                 */
/*------------------------------------------------------------------*/
lLen = Len ( Trim ( idwCmde.GetItemString ( 1, "ADR_LIVR_CPL" ) ) )
If lLen > 30 Then
	sDw = "D"
	stMessage.sCode = "COMD041"
	F_Message ( stMessage )
	Return sDw + "ADR_LIVR_CPL" 
End If

/*------------------------------------------------------------------*/
/* #1 ADR_1 + ADR_2 <= 30                                           */
/*------------------------------------------------------------------*/
lLen = 0
lLen1 = Len ( Trim ( idwCmde.GetItemString ( 1, "ADR_LIVR1" ) ) )
If Not IsNull ( lLen1 ) Then lLen += lLen1

lLen1 = Len ( Trim ( idwCmde.GetItemString ( 1, "ADR_LIVR2" ) ) )
If Not IsNull ( lLen1 ) Then lLen += lLen1

// -1 pour le séparateur
If lLen > 30 - 1 Then
	sDw = "D"
	stMessage.sCode = "COMD042"
	F_Message ( stMessage )
	Return sDw + "ADR_LIVR1" 
End If

/*------------------------------------------------------------------*/
/* #1 ADR_VILLE <= 25                                               */
/*------------------------------------------------------------------*/
/*
lLen = Len ( Trim ( idwCmde.GetItemString ( 1, "ADR_VILLE" ) ) )
If lLen > 25 Then
	sDw = "D"
	stMessage.sCode = "COMD043"
	F_Message ( stMessage )
	Return sDw + "ADR_VILLE" 
End If
*/

// [DT57_CMDE_IPHONE_SFR]
If sPos = "" Then
	
	// Si DP 220 présente
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 220 )
	If lDeb > 0 Then

		sVal = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "CAS", ";")
		
		Choose Case sVal
			Case "IPHONE_O2M_SFR"
		
				If Pos ( sIdModl, "IPHONE" ) > 0 And sIdFour = "CEG" And ( lnvPFCString.of_Getkeyvalue( isInfoSpbFrnCplt, "NEUF_REC", ";") = "REC" ) Then
				
					Choose Case sIdTypArtCmd
						Case "TEL"
							lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "MAJOR_CONTRACTUELLE_EUROS", "20", ";")

					End Choose
				End IF
			
		End Choose
	End If			
End If
// [DT57_CMDE_IPHONE_SFR]

Return sPos
end function

private function string uf_controlergestion_tamet (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_TAMET 	(PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 15/02/2012
//* Libellé			: Controle Spécifique pour PSM
//* Commentaires	: // [PM200][PSM]
//*					  liste -IF
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	JCA	26/12/2006	DCMP 060907 - Changement de l'appel à F_Determiner_Montant_Frais_Envoi
//*									ajout des arguments alidprod (Val), adwdetpro (Ref), adcFrais (Ref)
//		 	FPI	24/06/2010 [DCMP100551] Modification de l'option 76
//       JFF   17/04/2012  [PM200][LOT2][DESOX]
//       JFF   26/11/2012  [PC877]
//       JFF   17/12/2012  [PM200_LOT3_V3]
//       JFF   25/03/2013  [PC801_LOT1_V2]
//       JFF   07/05/2013 [PC938_ORANGE_V3]
//       JFF   20/06/2013 [PC801_LOT1_V2]
//       JFF   09/09/2013 [PM222-1]
//       JFF   08/04/2014 [PM255]
//       JFF   14/05/2014 [PC13274-2]
//       JFF   02/01/2015 [PC801_6_TAMET]
//       JFF   21/05/2015 [VDOC17717]
//*-----------------------------------------------------------------

String sPos, sProbleme, sCodModeRegn, sVar1, sVar2, sVar3, sFiltreOrigArticle, sSortOrig, sVal
Long lInfoSpbFrn, lIdSin
Dec {2} dcFrais //#1
Boolean bRibVide
Long lIdBoutique, lNull, lRow, lFind
String sLibBoutique=""
string  snomligne1, snomligne2, sadrligne1, sadrligne2, scp, sville
n_cst_string lnvPFCString
String sVar[]
String sCodMsg, sAction 
long	lDeb, lFin, lCaisse
Long lIdGti 
n_cst_attrib_key	lnv_key[], lnv2_key[]
n_cst_cmd_commun	lnvCmdCommun
String sMtFrais 
String sNouvelleLigne, sText

sPos = ""

lInfoSpbFrn = idwArticle.GetItemNumber ( alCpt, "INFO_SPB_FRN" ) 
idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "1" )

/*------------------------------------------------------------------*/
/* Message d'information pour le gestionnaire                       */
/*------------------------------------------------------------------*/
sFiltreOrigArticle = idwArticle.Describe ("DataWindow.Table.filter") 
If sFiltreOrigArticle = "?" Then sFiltreOrigArticle = ""



snomligne1=Space(35)
snomligne2=Space(35)
sadrligne1=Space(35)
sadrligne2=Space(35)
scp=Space(35)
sville=Space(35)
lIdSin  = idwDetail.GetItemNumber ( 1, "ID_SIN" )

If idwCmdeSin.find ( "( POS ( INFO_SPB_FRN_CPLT, 'A_REPARER_SAV=OUI') > 0 OR POS ( INFO_SPB_FRN_CPLT, 'A_DESOXYDER_SAV=OUI') > 0 ) AND COD_ETAT IN ( 'RPC', 'RFO') AND STATUS_GC IN ( 2,21,22,23 )", 1, idwCmdeSin.rowcount() ) > 0 Then
	sVar1 += " - Contrôle SAV"
End If

Choose Case lInfoSpbFrn 

	// [PC801_6_TAMET]
	Case 	2510

		// [VDOC17717]
		sVar [1] = F_Determiner_Montant_Frais_Envoi ( String ( lInfoSpbFrn ), idwWsin.object.id_prod[1], isTypApp, idw_DetPro, dcFrais ) // [DCMP100551]
		sVar [2] = "JUCLAN - SPB AUCHAN"
		sVar [3] = "Immeuble SOPRANO, 5 rue de Maidstone"
		sVar [4] = "60000 Beauvais"
		sVar [5] = String ( idwCmde.GetItemNumber ( 1, "ID_SIN" ) ) + "-" + String (  This.uf_Nouveau_Num_Sequence () ) 

		sCodMsg = "COMD897"		

	Case 	2516

		// PC801_LOT1_V5, Vu avec S. Vabre le 17/10, pas de boutique de centralisation pour le 2116.
		sCodMsg = "COMD896"		
		sVar [1] = String ( idwCmde.GetItemNumber ( 1, "ID_SIN" ) ) + "-" + String (  This.uf_Nouveau_Num_Sequence () ) 			

		// [PC947&977] Vu avec s.vabre le 16/12, on réactive la variable pour le process 2116
		// lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_BTQ_PSM_CENTRALE", "", ";")

	

// [PC801_LOT1_V2]
	Case 0 
		sPos = "INFO_SPB_FRN"
		sText += "~n~r"
		sText = sText + "- Le Process" + sNouvelleLigne
		sText += "~n~r"
		stMessage.sTitre		= "Controle de saisie - Information(s)"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= TRUE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "GENE001"
		stMessage.sVar[1]		= sText
		F_Message (stMessage)

		Return sPos
	
		
End Choose	

// [PM200][LOT2][DESOX]
// [ITSM274801]
lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "MT_PEC", String ( idcMtPec, "##0.00" ), ";")		


If sCodMsg <> "" Then
	stMessage.scode = sCodMsg
	stMessage.sVar = sVar

	F_Message(stMessage)
End If
	
		


// [PC13274-2]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 260 ) 
If lDeb > 0 Then	
	sVal = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "CAS", ";")
	
	Choose Case sVal 
		Case "RECUP_DONNEES"
			lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "RECUP_DONNEES", "SUR_DEM_ASS", ";")
	End Choose
	
End If

//[DOC14293]
lRow = idwWDivsin.Find ( "NOM_ZONE = 'code_verrou_sherpa_script'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	 sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
	 If IsNull ( sVal ) Then sVal = ""
	 If Len ( sVal ) > 0 Then
		 lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_VERROU_ORIG", sVal, ";")
	 End If
End If	
//[VDOC14293]

// [PM259-1]
lRow = idwWDivsin.Find ( "NOM_ZONE = 'code_parental'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	 sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
	 If IsNull ( sVal ) Then sVal = ""
	 If Len ( sVal ) > 0 Then
		 lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_PARENTAL", sVal, ";")
	 End If
End If	
// [PM259-1]

Return sPos

end function

private subroutine uf_gestionzone_infospbfrn_tamet_2500 (ref n_cst_attrib_key alnv_key[], ref long aldefaut, ref boolean abrdvaprendre);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_Commande3::uf_GestionZone_InfoSpbFrn_TAMET_2500 (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 28/11/2012
//* Libellé       : [PC877]
//* Commentaires  : 
//*
//* Arguments     : n_cst_attrib_key  alnv_key[]		Réf		// Valeur par défaut dans la zone
//*		    		  Long				  alDefaut        Réf	   // Process retenu
//*					  Boolean			  abRdvAPrendre   Réf      // TRUE : Un Rdv est à prendre.
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    13/02/2008  [FNAC_PROD_ECH_TECH].[20090213145759303]
//* #2    JFF    13/02/2008  [FNAC_PROD_ECH_TECH].[20090223142259343]
//* #3    JFF    19/05/2009  [DCMP090172]
//* #4    JFF    05/05/2009  [RUEDUCOMMERCE]
//* #5    JFF    28/07/2009  [DCMP090378]
//* #6    JFF    02/09/2009  [DCMP090327].[SBETV]
//* #7    JFF    07/10/2009  [DCMP090421]
//* #8    JFF    16/11/2009  [DCMP090421].[20091116110244950]
//* #9    JFF    18/11/2009  [DCMP090421].[20091118105631390]
//*       JFF    10/06/2010  [PC419/440/418/439_MICROMANIA]
//*       JFF    30/06/2010  [PC363_AUCHAN]
//*		 JFF    05/01/2011  [PC202].[DOM_COM]
//* 	    JFF    05/01/2011  [PC545].[POINT].[229]
//*       JFF    05/07/2011  [PC292][AUCHAN]
//*       JFF    05/07/2011  [AUCHAN].[AUCH_SITCOL_NVFRONT]
//*       JFF    12/12/2011  [VDOC4970]
//        JFF    06/08/2012  [BLCODE]
//        JFF    25/03/2013  [PC801_LOT1_V2]
//        JFF    07/05/2013  [PC938_ORANGE_V3]
//        JFF    23/01/2014  [VDOC13473]
//        JFF    08/04/2014  [PM255]
//        JFF    11/08/2014  [DT94]
//*-----------------------------------------------------------------
stMessage.sTitre		= "Process"
Boolean bDepotFNAC, bEmbOrig, bAppSin, bAlimSin, bBattSin, bAccSin, bDepotEnvoiParAss
Boolean bRtrParTrp, bPrestaExistante, bMaterielChezTAMET, bFNACEpt, bCltVIP, bEnvoiOuTeleChg, bEmbOrigOk, bAuchan
Boolean bDimSup150cm, bPoidsSup30kg, bProxiEmbOrig , bColiPrePaye, bInterDom 
String  sCTG, sNomContractant, sVal, sResidant, sResidant2
String  sModeBlc
Long 	  lRow, lDeb, lFin, lCaisse, lVal, lIdEvt
n_cst_string	lnv_string
Boolean bRDCommerce // #4 [RUEDUCOMMERCE]
Boolean bMicromania // [PC419/440/418/439_MICROMANIA]
Boolean bCltFrontalier // [PC363_AUCHAN]
Boolean bCltFrontResidant1 
Boolean bDepotParAssure, bProcessScripting 
Boolean bBlCodeEnvBBPMailcour, bBlCodeEnvCartonBBP, bAssTlchrgBBPsite, bBLCODEEnvTP 
n_cst_string lnvPFCString
Long lCodeMag, lIdProd, lIdSin
String sAdrNom, sAdr1, sAdr2, sAdrVille, sAdrCP, sNom

// [PC801_LOT1_V2]
bProcessScripting = alDefaut = 2198 

lIdEvt = idwDetail.GetItemNumber ( 1, "ID_EVT" ) //  [VDOC13473]

alDefaut = 0
sResidant=""

// #6 [DCMP090327].[SBETV]
If isInfoSpbFrncplt <> "" Then
		isInfoSpbFrncplt += ";"
End If
isInfoSpbFrncplt += "MAT_SIN="	

abRdvAPrendre = FALSE

bDepotFNAC = FALSE
bEmbOrig= FALSE
bRtrParTrp = False
bAppSin = FALSE
bAlimSin = FALSE
bAccSin = FALSE
bBattSin = FALSE
bCltVIP = FALSE // #7 [DCMP090421]
bEnvoiOuTeleChg = FALSE // #7 [DCMP090421]
bCltFrontResidant1 = FALSE

isPrcBLCODE = ""

// #3 [DCMP090172]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 59 )
If lDeb > 0 Then
	sNomContractant = Trim ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ) )
Else 
	sNomContractant = ""
End If
If IsNull ( sNomContractant ) Then sNomContractant = ""
// :#3 [DCMP090172]

// L'appareil est-il sinistré ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'APP_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bAppSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

// La batterie est-elle sinistrée ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'BATT_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bBattSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

// L'alim est-elle sinistrée ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'ALIM_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bAlimSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

// [VDOC4970]
// L'Autre Accessoire est-elle sinistrée ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'AUT_ACC_SIN'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bAccSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If

// La catégorie de l'appareil
sCTG = alnv_key [5].iaKeyValue

If IsNull ( sCTG ) Then sCTG = ""
sCTG = Trim ( sCTG ) 

//* #1 [FNAC_PROD_ECH_TECH].[20090213145759303]
bPrestaExistante = idwCmdeSin.Find ( "ID_FOUR = 'TMT' AND ID_TYP_ART = 'PRS' AND COD_ETAT = 'RPC'", 1, idwCmdeSin.RowCount ()) > 0 

If bPrestaExistante Then
	stMessage.Bouton		= YESNO!
	stMessage.Icon			= Question!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "COMD513"
	bMaterielChezTAMET = f_Message ( stMessage ) = 1
End If

// Si l'appareil est sinistrée, les deux question qui suivent ont un sens.
If bAppSin Then  
	isInfoSpbFrncplt += "[SIN_APP]"

	// La catégorie autorise-t-elle un dépôt chez FNAC, si oui, on pose la question uniquement pour CTG A et B
	// [DCMP090421] ajout bCltVIP

	// Déjà chez PSM
	If alDefaut = 0 And bMaterielChezTAMET Then
		alDefaut = 2502
		isCodeBoutiqueProximitePSM = ""
	End If 


	// [PC801_LOT1_V2]
	// "EMBORIG"
	If alDefaut = 0 And alnv_Key[14].iaKeyValue <> "" Then
		If isCodeBoutiqueProximitePSM <> "" Then alDefaut = Long ( alnv_Key[14].iaKeyValue ) 
	End If
						
	// "PROXI_EMBORIG"
	If alDefaut = 0 And alnv_Key[5].iaKeyValue = "OUI" Then
		
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD755" 
	
		bProxiEmbOrig = f_Message ( stMessage ) = 1
		If bProxiEmbOrig Then alDefaut = Long ( alnv_Key[6].iaKeyValue ) 
			
	End If

	// "COLI_PREPAYE"
	If alDefaut = 0 And alnv_Key[7].iaKeyValue = "OUI" Then
		
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD756" 
	
		bColiPrePaye = f_Message ( stMessage ) = 1
		If bColiPrePaye Then alDefaut = Long ( alnv_Key[8].iaKeyValue ) 
			
	End If

	// "INTER_DOM"
	If alDefaut = 0 And alnv_Key[10].iaKeyValue = "OUI" Then

		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD763" 
	
		bInterDom = f_Message ( stMessage ) = 1
		If bInterDom Then alDefaut = Long ( alnv_Key[11].iaKeyValue ) 

	End if

	// [PC801_LOT1_V2]
	// "EMBORIG"
	If alDefaut = 0 And alnv_Key[12].iaKeyValue = "OUI" Then
		
		stMessage.Bouton		= YESNO!
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "COMD774" 
	
		bEmbOrig = f_Message ( stMessage ) = 1
		If bEmbOrig Then alDefaut = Long ( alnv_Key[13].iaKeyValue ) 
			
	End If



	If alDefaut = 0 Then
		alDefaut = Long ( alnv_Key[4].iaKeyValue ) // Process 
	End If
// :[PC545].[POINT].[229]
	
End If

//* #1 [FNAC_PROD_ECH_TECH].[20090213145759303]
If bMaterielChezTAMET Then 
	alDefaut = 2502
End If


end subroutine

public subroutine uf_deconnecter_equiv_fct (string ascas);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_Commande3::uf_Deconnecter_Equiv_Fct (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 15/10/2004 11:41:50
//* Libellé       : Deconnexion de l'équivalence fonctionnelle :
//*							- Soit par clique sur le bouton superuser
//*						   - Soit par Option Det_pro en fonction du produit.
//* Commentaires  : 
//*
//* Arguments     : asCas
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    16/10/2006  [DCMP060693] Shunt obligatoire pour gèrer les 
//*								  nouveaux produits MEDIA SATURN, MONDOVELLO, MUSIQUE_GUARD
//* #2    JFF	  06/02/2006  [SITE_CMDE] Gestion des nouvelles option d'autorisation 79, 80, 81
//* #3    JFF    23/02/2007  [DCMP070059]
//* #4    JFF    04/06/2007  [DCMP070163-070164-070248-070318] Gestion Prise en charge
//* #5    JFF    21/01/2008  [DCMP070988] Trt particulier sur l'IPHONE
//* #6    JFF    22/04/2008  [DCMP080288] Trt particulier sur l'IPHONE16GO
//* #7    JFF    24/04/2008  [DCMP080329] Rechercher existance appareil pour DARTY TEL
//* #8	 JFF	  09/06/2008  [DCMP070798] 
//* #9	 JFF	  18/07/2008  [DCMP080570] Gedtion IPHONE 3G 16GO et IPHONE 3G 8GO
//* #10   JFF	  07/10/2008  [DCMP080734] Gestion IPHONE libellé par SFR
//* #11   JFF    03/12/2008  [DCMP080737] Asus EEEPC Linux/Windows
//* #12	 FPI	  06/03/2009  [DMDI25082]  Gestion IPhone 3G 16GO GB BLANC
//* #13   JFF    24/03/2009  [DMDI25968] suppression certains IPHONE et ajout nvx IPHONE
//* #14   JFF    02/03/2010  [MSS_LOT2]
//*       JFF    02/03/2010  [PM140]
//*       JFF    01/09/2011  [PC10][DIAG_NOMADE]
//*      JFF    22/03/2012   [VDOC7214]
//		FPI	20/09/2012	[VDoc8903] Iphone 5
//        JFF   14/01/2015 [VDOC16304]
//        JFF  17/05/2016 	  [PM280-2]
//        JFF   28/10/2020 [VDOC29759] On libère la marque APPLE
//*-----------------------------------------------------------------

String sFind, sVal, sMarq, sModl, sFiltreOrig, sFiltre, sIdGti, sIdFour, sTypAppEpur
String sAltVisible // #2
String sIdTypArt // #8
Long lRow, lTot, lCpt, lRowCtrl, lDeb, lFin, lIdEvt

lIdEvt = idwDetail.GetItemNumber ( 1, "ID_EVT" ) // [PM200][LOT2][DESOX]

ibToutMob = UPPER ( asCas ) = "BOUTON"  

// #5#6 Si le tel sinistré est un .... (en orthographe IFR) On interdit la touche TOUT MOBILE
stMessage.sCode = ""

// On interdit certaines marques/modl seulement si l'on presse TOUT MOBILE
If ibToutMob Then
	Choose Case isMarqPortAdh
			
		Case "APPLE"	
			
			Choose Case TRUE
				// [VDOC16304]
				Case 	Pos ( isModlPortAdh, "IPHONE" ) > 0

					// [VDOC29759] A supprimer à la MEP (commenter mais garder le code).
					/*	
						idwArticle.SetFilter ( "" )
						idwArticle.Filter ( )
					
						lRow = idwArticle.Find ( "ID_TYP_ART = 'CAF'", 1, idwArticle.RowCount () )
						If lRow > 0 Then
							idwArticle.SetFilter ( "ID_TYP_ART = 'CAF'" )
							idwArticle.Filter ()
							idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount (), Primary! )
							idwArticle.SetFilter ( "" )
							idwArticle.Filter ()
							
							// Autoriser clique sur Tout mobile
							
						Else
							stMessage.sCode		= "COMD468"
							idwArticle.RowsDisCard ( 1, idwArticle.Rowcount (), Primary! )
							idwArticle.SetFilter ( "" )
							idwArticle.Filter ()
							
						End If				
					*/
			End Choose 			

		Case "ASUS"	
			
			Choose Case isModlPortAdh // #11 [DCMP080737] 
				Case "EEEPC LINUX", "EEEPC WINDOWS"
					stMessage.sCode		= "COMD468"
					
			End Choose 			
			
	End Choose 
			
	If stMessage.sCode <> "" Then		
		stMessage.sTitre		= "Touche TOUT MOBILE"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sVar[1]    = isMarqPortAdh
		stMessage.sVar[2]    = isModlPortAdh
		F_Message ( stMessage )
		Return
	End If 
End If
// :#5:#6

/*------------------------------------------------------------------*/
/* Initialisation de l'objet Pilote Equiv. Fct.                     */
/*------------------------------------------------------------------*/
iuoEqvFct.uf_Filtrer_Init ()

sAltVisible = "O" // #2
sIdGti = String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) ) // #2

//#1
//If isTypApp = "AUT" Then Return

//* #8 [DCMP070798] Ajout PC2
Choose Case isTypApp 
	Case "TEL", "PC2"
		// [PM280-2]
		If lIdEvt <> 1426 Then
			iuoEqvFct.uf_preparer( "R", isMarqPortAdh, isModlPortAdh, idwDetail.GetItemDecimal ( 1, "MT_VAL_ACHAT" ) )				
		End If 

	Case  Else
		
End Choose

//* #7 [DCMP080329] 
If ibToutMob Then 
	isMobileUnique = ""
End If
//* :#7 

idwArticle.SetRedraw ( FALSE )

/*------------------------------------------------------------------*/
/* Modification dynamique des attibuts 									  */
/*------------------------------------------------------------------*/
idwArticle.Modify ( "choix.visible='1~tIF ( ( mt_prix_ttc > mt_plaf ) or (qt_disp <= 2 And id_four = ~~'ANV~~'),0,1 )'" ) 
idwArticle.Modify ( "marq_modl.color='16711680~tIF ( ( mt_prix_ttc > mt_plaf ) or (qt_disp <= 2 And id_four = ~~'ANV~~'), 255, If ( choix = ~~'O~~', 32768, 16711680 ))'" )
idwArticle.Modify ( "ordre.color='16711680~tIF ( ( mt_prix_ttc > mt_plaf ) or (qt_disp <= 2 And id_four = ~~'ANV~~'), 255, If ( choix = ~~'O~~', 32768, 16711680 ))'" )
idwArticle.Modify ( "qt_disp.color='16711680~tIF ( ( mt_prix_ttc > mt_plaf ) or (qt_disp <= 2 And id_four = ~~'ANV~~'), 255, If ( choix = ~~'O~~', 32768, 16711680 ))'" )

// [PC505].[POINT35]
idwTypArt.SetRedraw ( FALSE )
sFiltre = "ID_GTI = " + sIdGti + " AND ID_CODE_ART <> '-1' AND ID_TYP_CODE = '-XX' AND ID_CODE_ART NOT IN ( 'PRS', 'EDI' )"
idwTypArt.SetFilter ( sFiltre )
idwTypArt.Filter ()

/*------------------------------------------------------------------*/
/* On sauve le filtre original.                                     */
/*------------------------------------------------------------------*/
sFiltreOrig = idwArticle.Describe ("DataWindow.Table.filter") 
If sFiltreOrig = "?" Then sFiltreOrig = ""

sFiltre = "" 

idwArticle.SetFilter ( sFiltre )
idwArticle.Filter ( )
idwArticle.Sort ()

// Autor Cmde Gestionnaire ? // #2
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 79 )
If lDeb > 0 Then
	sAltVisible = "O" // #2
Else
	sAltVisible = "N" // #2	
End If

lTot = idwArticle.RowCount ()
For lCpt = 1 To lTot
	sIdFour= idwArticle.GetItemString ( lCpt, "ID_FOUR" ) // #2

	Choose Case isTypApp
		Case "PC3"
			sTypAppEpur = "PC2','PC1"

		// [PC10][DIAG_NOMADE]
		Case "OU1", "OU2"
			sTypAppEpur = "PCP','CUB','PCC"
			
		Case Else
			sTypAppEpur = isTypApp		
	End Choose

	//* #8 [DCMP070798]
	// #8 lRowCtrl = idwFourn.Find ( "ID_GTI = " + sIdGti + " AND ID_CODE_FRN = '" + sIdFour + "'", 1, idwFourn.RowCount ()) // #2
	// #14 [MSS_LOT2] ajout ACC
	// [PC434] Ajout MAI
	lRowCtrl = idwTypArt.Find ( "ID_GTI = " + sIdGti + " AND ID_CODE_FRN = '" + sIdFour + "' AND ( ID_CODE_ART IN ('" + sTypAppEpur + "') Or ID_CODE_ART IN ( 'CAF', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM','MAI' ) ) ", 1, idwTypArt.RowCount ()) // #8
	//* :#8 [DCMP070798]
	
	If lRowCtrl > 0  Then // #2
		idwArticle.SetItem ( lCpt, "ALT_VISIBLE", sAltVisible ) // #2
	End If

	// #4 Correction de Bug, rien à voir avec le projet.
	If ibToutMob And idwArticle.GetItemString ( lCpt, "CHOIX" ) = "O" Then
		This.Uf_Zn_Choix ( idwArticle, "N", lCpt ) // #4
		idwArticle.SetItem ( lCpt, "CHOIX", "N" )
	End If
	
Next

// #3
This.uf_ArmementPlafond ( "APPLICATION_TOTALE" )

// [PC505].[POINT35]
// [ITSM83055]
Choose Case isChoixAction
	Case "S", "C"
		iDwFourn.SetRow ( 1 )
End Choose

This.uf_RowFocusChanged ( "DWFOURN" )
This.uf_RowFocusChanged ( "DWTYPART" )

idwArticle.Sort ()

idwArticle.SetRedraw ( TRUE )
idwTypArt.SetRedraw ( TRUE )

end subroutine

private subroutine uf_existance_mobile ();//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande3::uf_Existance_Mobile (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 14/10/2004 14:51:30
//* Libellé       : Gère l'existance du mobile sinistré dans le stock 
//*					  fournisseur. S'il est dispo, seul ce mobile peut être commandé.
//* Commentaires  : Armement d'une variable isMobileUnique si le mobile est dispo.
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	JCA		22/03/2006	DCMP 060263 -
//* #2   JFF      23/02/2007  [DCMP070059]
//* #3   JFF      21/01/2008  [DCMP070988] Trt particulier sur l'IPHONE
//* #4   JFF      22/04/2008  [DCMP080288] Trt particulier sur l'IPHONE16GO
//* #5   JFF      24/04/2008  [DCMP080329] Rechercher existance appareil pour DARTY TEL
//* #6   JFF	   18/07/2008  [DCMP080570] Gestion IPHONE 3G 16GO et IPHONE 3G 8GO
//* #7   JFF	   07/10/2008  [DCMP080734] Gestion IPHONE libellé par SFR
//* #8   JFF      03/12/2008  [DCMP080737] Asus EEEPC Linux/Windows
//* #9 	FPI		06/03/2009	[DMDI25082]  Gestion IPhone 3G 16GO GB BLANC
//* #10  JFF      27/03/2009  [DCMP090130] Mobistore
//* #11  JFF      24/03/2009  [DMDI25968] suppression certains IPHONE et ajout nvx IPHONE
//* #12  JFF		29/07/2009  [DCMP090362] Ajout Gestion IPHONE Orange Fnac
//* #13  JFF		29/07/2009  [DCMP090396] Ajout Gestion IPHONE Sfr
//* #14  JFF      30/11/2009  [20091130092752093] mise en production
//* #15	FPI	   18/03/2010	[DCMP100200] Annulation d'une partie de DCMP 090396
//*		FPI	   20/04/2010	[DCMP100289]
//*      JFF      22/07/2010  [PM140]
//*      JFF      16/09/2010  [DCMP100602]
//*      JFF      16/09/2010  [DCMP100595]
//*    	FPI		26/10/2010	[VDoc1611]
//*    	JFF		28/10/2011	[VDoc5774]
//		FPI		05/01/2011	[VDoc6433] Substitution d'IPhone 4G uniquement pour CEG & produit SFR
//		FPI		01/03/2012	[VDoc7107] Blocage IPHONE 4G/8GB BLANC
//*      JFF    22/03/2012   [VDOC7214]
//       JFF   23/03/2012   [VDOC7271] Refonte substitution
//       JFF   23/03/2012   [VDOC7098] Shunt de la DCMP070059
//       JFF   02/08/2012   [ITSM125902] Shunt suite problème.
//		FPI	20/09/2012	[VDoc8903] Iphone 5
// 		FPI	03/12/2012	[PC801].Mantis6062
//		FPI	26/06/2013	[VDOC11483] Déconnexion substitution
//       JFF   26/08/2013 [DT57_CMDE_IPHONE_SFR]
//       JFF   06/11/2013 [ITSM182707]
//        JFF   19/11/2013 [DT_60_AUGM_TVA]
//        JFF   14/01/2015 [VDOC16304]
//       JFF   09/04/2015 [DT141]
//       JFF   09/04/2015 [DT141][MANTIS15514]
//       JFF   03/06/2015 [DT145_V4]
//       JFF   17/06/2015 [DT145_V4][MANTIS15842]
//			JFF   07/07/2015 [DT153]
//       JFF   16/07/2015 [VDOC18218]
//       JFF   15/09/2015 [DT145-1] Evol DT145_V4
//       JFF   23/09/2015 [DT145_V4][MANTIS17246]
//       JFF   28/10/2015 [ITSM336306]
//       JFF   17/05/2016 [PM280-2]
//       JFF   25/08/2016 [PC151549][MANTIS21559]
//       JFF   07/11/2016 [PC151259]
// 		JFF	21/03/2017 [DT288][M24382]
//       JFF   13/04/2017 [DT288-1]
//       JFF   23/05/2017 [DT145-2]
//       JFF   01/08/2017 [DT288-1][MODIF_CHRISTINE]
//       JFF   04/08/2017 [DT288-1][MODIF_CHRISTINE][VDOC24372]
//       JFF   12/09/2017 [PC151259-3]
//       JFF   05/10/2017 [PC171918]
//       JFF   28/10/2020 [VDOC29759] On libère la marque APPLE
// 		JFF   08/04/2021 [VDOC30259] [VDOC29759] version 2
//       JFF   30/08/2021 [RS972][OPTIM_MB3&4]
//       JFF   16/08/2022 [RS3200]
//			JF 	17/01/2022 [20230117163534170]
//*-----------------------------------------------------------------

String sFind, sVal, sMarq, sModl, sFiltreOrig, sFiltre 
String sMarqAdhSav, sModlAdhSav // #12  [DCMP090362] 
Long lRow, lTot, lCpt, lDeb, lFin, lIdProd, lIdEvt, lRow2, lIdGti, lRow1
Boolean bTelParticulier, bSubstitution // #3
Boolean bCasIPhoneCEG, bSubstChoisi, bIdEvtParticulier, bAMUsubstProposee
Int iCptSubst 
Int iNbreSubst
String sMarqAppSubs, sModlAppSubs
Decimal {2} dcMtValPublique, dcMtPrixTTCifr 
Boolean	bCasAppleCmdeChezSbe, bCasAppleCmdeChezSfrSuite176Sbe  // [DT141]
Boolean	bCasAppleChoixDmeAvantO2m, bCasAppleChoixO2mSuiteDME176 // [DT145_V4]
Boolean bCasAppleCmdeChezCordon 
String sFiltreCasAppleChoixDmeAvantO2m
String sFiltreOrig1 
n_cst_string lnvPFCString

// #1	JCA	22/03/2006	DCMP 060263
String sSortOrig, sSort, sFourOne, sSortFour, sFilterFour
Long lCountFourn
// FIN #1


bCasIPhoneCEG=FALSE // 	[VDoc6433] 
lIdEvt = idwDetail.GetItemNumber ( 1, "ID_EVT" ) // [PM200][LOT2][DESOX]
lIdGti = idwDetail.GetItemNumber ( 1, "ID_GTI" ) // [DT141]
bIdEvtParticulier = False
sFiltreCasAppleChoixDmeAvantO2m = "" // [DT145_V4]
bAMUsubstProposee = False

// #12  [DCMP090362] 
lIdProd = idwWSin.GetItemNumber ( 1, "ID_PROD" )
sMarqAdhSav = isMarqPortAdh 
sModlAdhSav = isModlPortAdh

isMobileUnique = ""
bSubstitution = False

bCasAppleCmdeChezSbe = FALSE
bCasAppleCmdeChezSfrSuite176Sbe= FALSE
bCasAppleCmdeChezCordon = False

// [20230117163534170]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 239 )
If lDeb > 0 And lIdGti = 10 Then
	idwArticle.SetFilter ( "ID_FOUR = 'COR'" )
	idwArticle.Filter ()
	idwArticle.RowsDisCard ( 1, idwArticle.RowCount (), Primary! )
	idwArticle.SetFilter ( "" )
	idwArticle.Filter ()			
End If 


// [RS972][OPTIM_MB3&4]
F_RechDetPro ( lDeb, lFin, idw_DetPro, lIdProd, "-DP", 302 )
If lDeb > 0 Then
	idwArticle.SetFilter ( "ID_FOUR = 'BST' AND ID_TYP_ART NOT IN ( 'CAF')" )
	idwArticle.Filter ()
	idwArticle.RowsDisCard ( 1, idwArticle.RowCount (), Primary! )
	idwArticle.SetFilter ( "" )
	idwArticle.Filter ()		
	
	idwTypArt.SetFilter ( "ID_CODE_FRN = 'BST' AND ID_CODE_ART NOT IN ( 'CAF')" )
	idwTypArt.Filter ()
	idwTypArt.RowsDisCard ( 1, idwTypArt.RowCount (), Primary! )
	idwTypArt.SetFilter ( "" )
	idwTypArt.Filter ()		
	
End if 

// [DT288][M24382]
If isChoixAction = "C" Then 
	lRow = idwCmdeSin.Find ( "ID_FOUR = 'COR' AND COD_ETAT <> 'ANN'  AND ( POS ( INFO_FRN_SPB_CPLT, 'SWAP_AUTO_CTR=OUI' ) > 0 OR STATUS_GC = 2)", 1, idwCmdeSin.RowCount ())
	
	If lRow > 0 Then
		bCasAppleCmdeChezCordon = True
		idwArticle.SetFilter ( "ID_FOUR = 'COR'" )
		idwArticle.Filter ()
		idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount (), Filter! )
		idwArticle.SetFilter ( "" )
		idwArticle.Filter ()					
	End If
End If

// [DT288-1][MODIF_CHRISTINE]
F_RechDetPro ( lDeb, lFin, idw_DetPro, lIdProd, "-DP", 319 )
If isMarqPortAdh = "APPLE" And lIdGti <> 10 And lDeb > 0 Then

	// [RS3200]
	// On priviligie TELSTORE si TLS présent, sinon O2M commande avant
	idwArticle.SetFilter ( "ID_FOUR = 'TLS'" )
	idwArticle.Filter ()
	
	If idwArticle.RowCount () <= 0 Then 
		// [DT288-1][MODIF_CHRISTINE][VDOC24372]								
		idwArticle.SetFilter ( "ID_FOUR IN ( 'O2M' ) AND ID_TYP_ART NOT IN ( 'PRS', 'EDI', 'REA' )" )										
		idwArticle.Filter ()
		idwArticle.RowsDisCard ( 1, idwArticle.RowCount (), Primary! )
	End If 

	idwArticle.SetFilter ( "" )
	idwArticle.Filter ()
	
End If

// [PC151259]
// [PC151259-3]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 252 )
If lDeb > 0 Then
	sVal = lnvPFCString.of_getkeyvalue ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")
	// [PC171918]
	Choose Case sVal 
		Case "FULL_SERENITY_ADV_5", "ADVISE_6"
			lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'FRN_REMPL_ADH'", 1, idwWDivSin.RowCount () ) 
			If lRow >0 Then 
				sVal = Trim ( Upper ( idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) ))
				If IsNull ( sVal ) Then sVal = ""
				
				// [PC151259-3]
				idwArticle.SetFilter ( "ID_FOUR IN ( '" + sVal + "', 'O2M', 'AAS' )" )
	
				idwArticle.Filter ()
				idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount (), Filter! )
				idwArticle.SetFilter ( "" )
				idwArticle.Filter ()					
			Else 
				idwArticle.SetFilter ( "" )
				idwArticle.Filter ()
				idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount (), Filter! )
				idwArticle.SetFilter ( "" )
				idwArticle.Filter ()					
			End If
	End Choose 
End If


// [DT141] 
F_RechDetPro ( lDeb, lFin, idw_DetPro, lIdProd, "-DP", 275 )
If lDeb > 0 Then
	lRow =  idwCmdeSin.Find ( "ID_FOUR = 'SBE' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT IN ( 'RPC', 'RFO' ) AND STATUS_GC > 0", 1, idwCmdeSin.RowCount() )
	lRow2 = idwCmdeSin.Find ( "ID_FOUR = 'SBE' AND ID_REF_FOUR = 'CMDE_A_CPLTER' AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount() )	
	
	bCasAppleCmdeChezSbe = ( lRow > 0 OR lIdGti = 10 ) And lRow2 <= 0 And lDeb > 0 And isMarqPortAdh = "APPLE"
	
	lRow2 = idwCmdeSin.Find ( "ID_FOUR = 'SBE' AND ID_REF_FOUR = 'CMDE_A_CPLTER' AND COD_ETAT IN ( 'RPC', 'RFO') AND STATUS_GC = 176", 1, idwCmdeSin.RowCount() )	
	bCasAppleCmdeChezSfrSuite176Sbe = ( lRow > 0 OR lIdGti = 10 ) And lRow2 > 0 And lDeb > 0 And isMarqPortAdh = "APPLE"
	
	IF bCasAppleCmdeChezSfrSuite176Sbe Then
// [ITSM336306]
		idwArticle.SetFilter ( "ID_FOUR IN ( 'CEG' ) OR ID_REF_FOUR IN ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP') " )
			
		idwArticle.Filter ()
		idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount (), Filter! )
		idwArticle.SetFilter ( "" )
		idwArticle.Filter ()			
	End If

	If Not bCasAppleCmdeChezSbe Then
		idwArticle.SetFilter ( "ID_TYP_ART IN ( 'CAF' ) AND ID_FOUR = 'SBE'" )
		idwArticle.Filter ()
		idwArticle.RowsDisCard ( 1, idwArticle.RowCount (), Primary! )
		idwArticle.SetFilter ( "" )
		idwArticle.Filter ()
	End If	
End If	



// [DT145_V4]
// [DT288-1] And Not bCasAppleCmdeChezCordon
F_RechDetPro ( lDeb, lFin, idw_DetPro, lIdProd, "-DP", 279 )
If lDeb > 0 And Not bCasAppleCmdeChezCordon Then
	
	If ilNbreTourExistantMobile = 0 Then 
		// 1er Tourtour 0=1er, 1=2ème
		// [DT145-2]
		lRow =  idwCmdeSin.Find ( "ID_FOUR = 'DME'" , 1, idwCmdeSin.RowCount() )
		bCasAppleChoixDmeAvantO2m = lRow <= 0 And lDeb > 0 
	
		If Not bCasAppleChoixDmeAvantO2m Then
			// [DT145-2]
			lRow =  idwCmdeSin.Find ( "ID_FOUR = 'DME' AND COD_ETAT IN ( 'ANN' )" , 1, idwCmdeSin.RowCount() )
			bCasAppleChoixO2mSuiteDME176 = lRow > 0 And lDeb > 0 
		End If
		
		If bCasAppleChoixDmeAvantO2m Then
			sFiltreCasAppleChoixDmeAvantO2m = "ID_FOUR IN ( 'DME' )"
		End If
		
		// [MANTIS15842]
		If bCasAppleChoixO2mSuiteDME176 Then
			
			// [RS3200]
			// On priviligie TELSTORE si TLS présent, sinon O2M commande avant
			idwArticle.SetFilter ( "ID_FOUR = 'TLS'" )
			idwArticle.Filter ()
			If idwArticle.RowCount () <= 0 Then 
				
				// [DT145-2]
				// [DT145-1] Evol DT145_V4
				IF isMarqPortAdh = "APPLE" Then
					idwArticle.SetFilter ( "ID_FOUR IN ( 'O2M' ) AND ID_TYP_ART NOT IN ( 'PRS', 'EDI', 'REA' )" )
				Else
					// [DT288-1][MODIF_CHRISTINE][VDOC24372]
					idwArticle.SetFilter ( "ID_FOUR IN ( 'O2M' ) AND ( ( ID_TYP_ART NOT IN ( 'PRS', 'EDI' ) AND POS ( OBSERV_FRN, '[#NEU#]' ) > 0) OR ID_TYP_ART IN ( 'REA', 'RST') )" )
				End If
			End If 	
	
			idwArticle.Filter ()
			idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount (), Filter! )
			idwArticle.SetFilter ( "" )
			idwArticle.Filter ()

		End If
		
		
	End If

	// [MANTIS15842]
	If ilNbreTourExistantMobile = 1 Then 
		
		// [RS3200]
		// On priviligie TELSTORE si TLS présent, sinon O2M commande avant
		idwArticle.SetFilter ( "ID_FOUR = 'TLS'" )
		idwArticle.Filter ()
		If idwArticle.RowCount () <= 0 Then 
			
			// 1er Tourtour 0=1er, 1=2ème
			// [DT145-2]
			// [DT145-1] Evol DT145_V4
			IF isMarqPortAdh = "APPLE" Then
				idwArticle.SetFilter ( "ID_FOUR IN ( 'O2M' ) AND ID_TYP_ART NOT IN ( 'PRS', 'EDI', 'REA' )" )
			Else
				// [DT288-1][MODIF_CHRISTINE][VDOC24372]
				idwArticle.SetFilter ( "ID_FOUR IN ( 'O2M' ) AND ( ( ID_TYP_ART NOT IN ( 'PRS', 'EDI' ) AND POS ( OBSERV_FRN, '[#NEU#]' ) > 0) OR ID_TYP_ART IN ( 'REA', 'RST' ) )" )
			End If
		End If 	

		idwArticle.Filter ()
		idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount (), Filter! )
		idwArticle.SetFilter ( "" )
		idwArticle.Filter ()

	End If
End If 


// [ITSM125902]
// #5 [DCMP080329] DTY TEL
F_RechDetPro ( lDeb, lFin, idw_DetPro, lIdProd, "-DP", 11 )

// #10 [DCMP090130]
If lDeb <= 0 Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, lIdProd, "-DP", 46 )
End IF

If lDeb <= 0 Then
	/*------------------------------------------------------------------*/
	/* Doit-on déconnecter la recherche par équivalence fonctionnelle   */
	/*------------------------------------------------------------------*/
	F_RechDetPro ( lDeb, lFin, idw_DetPro, lIdProd, "-DP", 24 )
	
	// [DT141] On coupe la subst.
	// [DT141][MANTIS15514]		
	Choose Case True
		Case bCasAppleCmdeChezSbe 			
			lDeb = 0
	End Choose 			
	// [DT141]	
	
	If lDeb > 0 Then Return
End If

Choose case isChoixAction 
	Case "R", "I"
		Return
End Choose

idwArticle.SetRedraw ( FALSE )
idwArticle.Modify ( "choix.visible='1~tIF ( mt_prix_ttc > mt_plaf or (qt_disp <= 2 And id_four = ~~'ANV~~'),0,1 )'" ) 
idwArticle.Modify ( "marq_modl.color='16711680~tIF ( mt_prix_ttc > mt_plaf or (qt_disp <= 2 And id_four = ~~'ANV~~'), 255, If ( choix = ~~'O~~', 32768, 16711680 ))'" )
idwArticle.Modify ( "ordre.color='16711680~tIF ( mt_prix_ttc > mt_plaf or (qt_disp <= 2 And id_four = ~~'ANV~~'), 255, If ( choix = ~~'O~~', 32768, 16711680 ))'" )
idwArticle.Modify ( "qt_disp.color='16711680~tIF ( mt_prix_ttc > mt_plaf or (qt_disp <= 2 And id_four = ~~'ANV~~'), 255, If ( choix = ~~'O~~', 32768, 16711680 ))'" )


/*------------------------------------------------------------------*/
/* On sauve le filtre original.                                     */
/*------------------------------------------------------------------*/
sFiltreOrig = idwArticle.Describe ("DataWindow.Table.filter") 
If sFiltreOrig = "?" Then sFiltreOrig = ""

// #1	JCA	22/03/2006	DCMP 060263
sSortOrig = idwArticle.Describe ("DataWindow.Table.sort") 
If sSortOrig = "?" Then sSortOrig = ""


// Recherche du fournisseur dont la quantite est positive, trie par montant HT croissant
sFilterFour = "ID_MARQ_IFR = '" + isMarqPortAdh + "' AND ID_MODL_IFR = '" + isModlPortAdh + "' AND QT_DISP > 0 "
sSortFour = "MT_PRIX_TTC A"

// [DT145_V4]
If bCasAppleChoixDmeAvantO2m Then
	sFilterFour = sFiltreCasAppleChoixDmeAvantO2m + " AND " + sFilterFour
End IF

idwArticle.SetFilter (sFilterFour)
idwArticle.SetSort (sSortFour)
idwArticle.Filter ()
idwArticle.Sort ()


lCountFourn = idwArticle.RowCount()

// #12  [DCMP090362] GESTION DE LA SUBSTITUTION
// Si Modèle absent, on fait un second tour pour la substitution

// [VDOC11483] Déconnexion substitution
F_RechDetPro ( lDeb, lFin, idw_DetPro, lIdProd, "-DP", 243 )

// [DT141] On coupe la subst.
Choose Case True
	Case bCasAppleCmdeChezSbe 			
		lDeb = 1
End Choose 			
// [DT141]

// [VDOC29759] ICI mettre lDeb = 1 pour couper la substitution définitivement
lDeb = 1 

// [DT57_CMDE_IPHONE_SFR] And Not IphoneVirtuel
If lCountFourn <= 0 and lDeb <=0 Then // si dp 243 pas de substitution
//If lCountFourn <= 0 Then
// :[VDOC11483] Déconnexion substitution

	// [VDOC7271] Refonte substitution
	iCptSubst = 1
	iNbreSubst = 1 // Pour premier tour
	stMessage.sCode = ""
	bSubstChoisi = False
	
	// [PC938_ORANGE_V3][MANTIS7683]
	Choose Case lIdEvt 
		Case 1396, 1398, 1410
			iNbreSubst = 0 
	End Choose
	// [PC938_ORANGE_V3]
	

	Do While iNbreSubst > 0 

		sMarqAppSubs = Space ( 35 )
		sModlAppSubs = Space ( 35 )
		iNbreSubst = 0

		SQLCA.PS_S_SUBSTITUTION ( lIdProd, isMarqPortAdh, isModlPortAdh, iCptSubst, sMarqAppSubs, sModlAppSubs, iNbreSubst ) 

		// [VDOC18218]
		sFilterFour = "ID_MARQ_IFR = '" + sMarqAppSubs + "' AND ID_MODL_IFR = '" + sModlAppSubs + "' AND QT_DISP > 0 " + " AND MT_PRIX_TTC <= " + String ( idcMtPec, "##0.00" )
		sSortFour = "MT_PRIX_TTC A"		
		
		// [DT145_V4]
		If bCasAppleChoixDmeAvantO2m Then
			sFilterFour = sFiltreCasAppleChoixDmeAvantO2m + " AND " + sFilterFour
		End IF
		
		idwArticle.SetFilter (sFilterFour)
		idwArticle.SetSort (sSortFour)
		idwArticle.Filter ()
		idwArticle.Sort ()
		
		lCountFourn = idwArticle.RowCount()
		
		If iNbreSubst > 0 And lCountFourn > 0 Then
			stMessage.sTitre  	= "Choix substitution"
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= YESNO!
			stMessage.sVar[1] = sMarqAppSubs
			stMessage.sVar[2] = sModlAppSubs

			If stMessage.sCode = "" Then
				stMessage.sCode = "COMD710"
			Else
				stMessage.sCode = "COMD711"
			End IF

			// [DT153]
			bAMUsubstProposee = TRUE
			
			If F_Message ( stMessage ) = 1 Then
				isMarqPortAdh = sMarqAppSubs
				isModlPortAdh = sModlAppSubs
				bSubstChoisi = TRUE
				Exit
			End If 
		End IF

		iCptSubst++
	
	Loop

	If Not bSubstChoisi Then lCountFourn = 0
	// [VDOC7271] Refonte substitution
	
End If
// :#12  [DCMP090362] 

// [DT141] On coupe lCountFourn (=0) même si l'appareil est, ce n'est plus le process
Choose Case True
	Case bCasAppleCmdeChezSbe 			
		lCountFourn = 0
End Choose 

If lCountFourn > 0 Then
	idwArticle.SetItem (1, "ALT_VISIBLE", "O")
	sFourOne = idwArticle.GetItemString (1, "ID_FOUR")
	
	// [DT153]
	dcMtPrixTTCifr = idwArticle.GetItemDecimal (1, "MT_PRIX_TTC")

	If isMobileUnique = "" Then 
		isMobileUnique = " AND UPPER (ID_FOUR) = '" + Upper (sFourOne) + "' AND UPPER ( ID_MARQ_IFR ) = '" + Upper ( isMarqPortAdh ) + "' AND UPPER ( ID_MODL_IFR ) = '" + Upper ( isModlPortAdh ) + "' " 

		// [DT145_V4]
		If bCasAppleChoixDmeAvantO2m Then
			isMobileUnique += " AND " + sFiltreCasAppleChoixDmeAvantO2m
		End IF
		
		// [DT153]
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 239 )
		If lDeb > 0 And isMobileUnique <> "" And ( dcMtPrixTTCifr <= idcMtPec Or bAMUsubstProposee ) Then
			sFiltreOrig1 = idwArticle.Describe ("DataWindow.Table.filter") 
			If sFiltreOrig1 = "?" Then sFiltreOrig = ""
			idwArticle.SetFilter ( "ID_FOUR = 'O2M' and ID_TYP_ART = 'RST'" )
			idwArticle.Filter ()
			idwArticle.RowsDisCard ( 1, idwArticle.Rowcount(), Primary! )
			idwArticle.SetFilter ( sFiltreOrig1 )
			idwArticle.Filter ()			
		End If
		
		/*------------------------------------------------------------------*/
		/* Initialisation de l'objet Pilote Equiv. Fct.                     */
	   /* On initialise au format R pour déactiver la recherche d'eq. Fct  */
		/*------------------------------------------------------------------*/
		iuoEqvFct.uf_Filtrer_Init ()
		
		// [PM280-2]
		If lIdEvt <> 1426 Then
			iuoEqvFct.uf_preparer( "R", isMarqPortAdh, isModlPortAdh, idwDetail.GetItemDecimal ( 1, "MT_VAL_ACHAT" ) )				
		End If 
	End If
	// #2
	
	// [VDOC7098]
	If bSubstChoisi Then
		This.uf_ArmementPlafond ( "APPLICATION_TOTALE" )			
	Else
		This.uf_ArmementPlafond ( "APPLICATION_PARTIELLE" )
	End IF
	// [VDOC7098]		

End If
// FIN #1

// [DT145_V4]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 279 )
If lDeb > 0 And lCountFourn <= 0 And bCasAppleChoixDmeAvantO2m And ilNbreTourExistantMobile = 0 Then
	ilNbreTourExistantMobile = 1
	This.Uf_Existance_Mobile () // Appel récursif contrôler ilNbreTourExistantMobile 
	Return
End If

// #3 Si le tel sinistré est un .... (en orthographe IFR) Et que ce tél n'esty pas en Stokc, On interdit la commande d'un autre appareil.
stMessage.sCode = ""
bTelParticulier = FALSE
Choose Case isMarqPortAdh
		
	Case "APPLE"	

		Choose Case TRUE 

			// [DT141][MANTIS15514]						
			Case Pos ( isModlPortAdh, "IPAD" ) > 0 And &
				  ( bCasAppleCmdeChezSbe Or bCasAppleCmdeChezSfrSuite176Sbe ) 
				  
					Choose Case True
						Case bCasAppleCmdeChezSbe 
							stMessage.sCode = ""
							idwArticle.SetFilter ( "ID_TYP_ART IN ( 'CAF' ) AND ID_FOUR = 'SBE'" )
							idwArticle.Filter ()
							idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount (), Filter! )
							idwArticle.SetFilter ( "" )
							idwArticle.Filter ()
							This.Uf_Deconnecter_Equiv_Fct ("FONCTION")
							isTypApp = "CAF"
							
						Case bCasAppleCmdeChezSfrSuite176Sbe 
							stMessage.sCode = ""

							// [ITSM336306]
							idwArticle.SetFilter ( "ID_FOUR IN ( 'CEG' ) OR ID_REF_FOUR IN ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP') " )
							
							idwArticle.Filter ()
							idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount (), Filter! )
							idwArticle.SetFilter ( "" )
							idwArticle.Filter ()
							This.Uf_Deconnecter_Equiv_Fct ("FONCTION")
							bTelParticulier = TRUE
					End Choose 				
						
			Case Pos ( isModlPortAdh, "IPHONE" ) > 0
					

// :#11 [DMDI25968] 
				// [PC938_ORANGE_V3][MANTIS7683]
				Choose Case lIdEvt 
					Case 1396, 1398, 1410
						bIdEvtParticulier = True
				End Choose
				// [PC938_ORANGE_V3]

				bTelParticulier = TRUE
				
				If bIdEvtParticulier Then
					bTelParticulier = FALSE
				End If
					
					
				// [DT141] On enlève l'armement du message ci-dessus + on coupe l'EQF.
				Choose Case True
					Case bCasAppleCmdeChezSbe 
						stMessage.sCode = ""
						idwArticle.SetFilter ( "ID_TYP_ART IN ( 'CAF' ) AND ID_FOUR = 'SBE'" )
						idwArticle.Filter ()
						idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount (), Filter! )
						idwArticle.SetFilter ( "" )
						idwArticle.Filter ()
						This.Uf_Deconnecter_Equiv_Fct ("FONCTION")
						isTypApp = "CAF"
						
					Case bCasAppleCmdeChezSfrSuite176Sbe 
						stMessage.sCode = ""
						idwArticle.SetFilter ( "ID_FOUR IN ( 'CEG' )" )
						idwArticle.Filter ()
						idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount (), Filter! )
						idwArticle.SetFilter ( "" )
						idwArticle.Filter ()
						This.Uf_Deconnecter_Equiv_Fct ("FONCTION")
						bTelParticulier = TRUE
				End Choose 
				
				// [DT145_V4]
				Choose Case True
					Case bCasAppleChoixDmeAvantO2m 
						stMessage.sCode = ""
						If ilNbreTourExistantMobile = 0 Then
							// [DT288-1][MODIF_CHRISTINE][VDOC24372]							
							idwArticle.SetFilter ( "ID_FOUR IN ( 'DME' ) OR ID_TYP_ART IN ( 'REA', 'RST' )" )
						End If 

						// [MANTIS15842]
						If ilNbreTourExistantMobile = 1 Then
							// [DT145-1] Evol DT145_V4
							// [RS3200]
							// On priviligie TELSTORE si TLS présent, sinon O2M commande avant
							idwArticle.SetFilter ( "ID_FOUR = 'TLS'" )
							idwArticle.Filter ()
							If idwArticle.RowCount () <= 0 Then 
								idwArticle.SetFilter ( "ID_FOUR IN ( 'O2M' )" )									
							End If 
						End If 
						
						idwArticle.Filter ()
						idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount (), Filter! )
						idwArticle.SetFilter ( "" )
						idwArticle.Filter ()
						
						This.Uf_Deconnecter_Equiv_Fct ("FONCTION")
						bTelParticulier = TRUE		
				End Choose 
				
				// [DT141]
				If isMobileUnique = "" And Not bIdEvtParticulier And &
					Not bCasAppleCmdeChezSbe And  &
					Not bCasAppleCmdeChezCordon &
					Then

					idwArticle.SetFilter ( "" )
					idwArticle.Filter ( )

					lRow = idwArticle.Find ( "ID_TYP_ART IN ('CAF', 'RST') AND ID_FOUR NOT IN ( 'COR' )", 1, idwArticle.RowCount () )

					// [VDOC29759] version 2 [VDOC30259]
					lRow1 = idwArticle.Find ( "ID_TYP_ART NOT IN ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' )", 1, idwArticle.RowCount () )
					If lRow1 > 0 Then lRow = 0
					
					If lRow > 0 Then
						idwArticle.SetFilter ( "ID_TYP_ART IN ( 'CAF', 'RST')" )
						idwArticle.Filter ()
						idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount (), Filter! )
						idwArticle.SetFilter ( "" )
						idwArticle.Filter ()
						
						stMessage.sTitre		= "Commande"
						stMessage.Icon			= Information!
						stMessage.bErreurG	= FALSE
						stMessage.Bouton		= Ok!
						stMessage.sCode = "COMD734"
						
						// [PC801].Mantis6062
						lRow = idwArticle.Find ( "ID_TYP_ART = 'CAF' AND ID_FOUR='AUC'", 1, idwArticle.RowCount () )
						If lRow > 0 Then stMessage.sCode = "COMD762"

						lRow = idwArticle.Find ( "ID_TYP_ART = 'RST'", 1, idwArticle.RowCount () )
						If lRow > 0 Then stMessage.sCode = "COMD822"
						
						
						// [PC151549][MANTIS21559]
						lRow = idwArticle.Find ( "ID_TYP_ART = 'CAF' AND ID_FOUR='BST'", 1, idwArticle.RowCount () )
						If lRow > 0 Then stMessage.sCode = "COMD948"
						
						
						F_Message ( stMessage )
						stMessage.sCode = ""
						
						This.Uf_Deconnecter_Equiv_Fct ("FONCTION")					
						
					Else
						// [VDOC29759] ICI supprimer le message et remettre bTelParticulier = TRUE, on ne supprime pas les Iphone
						//	stMessage.sCode = "COMD542"
					End If
					
				End If
	
		End Choose 	
		
	Case "ASUS"	

		/// #11 [DCMP080737] 
		Choose Case isModlPortAdh
			Case "EEEPC LINUX", "EEEPC WINDOWS"
				bTelParticulier = TRUE
				If isMobileUnique = "" Then
					stMessage.sCode = "COMD542"
				End If
	
		End Choose 	
	

	Case Else
		// [DT145-2]
		// [DT145_V4]
		Choose Case True
			Case bCasAppleChoixDmeAvantO2m 
				stMessage.sCode = ""
				If ilNbreTourExistantMobile = 0 Then
					idwArticle.SetFilter ( "ID_FOUR IN ( 'DME' )" )
				End If 

				// [MANTIS15842]
				If ilNbreTourExistantMobile = 1 Then
					// [DT145-1] Evol DT145_V4
					// On priviligie TELSTORE si TLS présent, sinon O2M commande avant
					idwArticle.SetFilter ( "ID_FOUR = 'TLS'" )
					idwArticle.Filter ()
					If idwArticle.RowCount () <= 0 Then 
						idwArticle.SetFilter ( "ID_FOUR IN ( 'O2M' )" )
					End If 
				End If 
				
				idwArticle.Filter ()
				idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount (), Filter! )
				idwArticle.SetFilter ( "" )
				idwArticle.Filter ()
				This.Uf_Deconnecter_Equiv_Fct ("FONCTION")
				// bTelParticulier = TRUE		
		End Choose 		
		
End Choose 
// :3

// [VDOC29759] toujours à True pour de plus supprimer les Iphone
bTelParticulier = TRUE


// #3 #7
If Not bTelParticulier Then
	// ON supprime l'APPLE IPHONE (l'Iphone n'est dispo que si le tél sin est un IPHONE)
	// Recherche du fournisseur dont la quantite est positive, trie par montant HT croissant

	sFilterFour = ""

	sFilterFour += "( ID_MARQ_IFR = 'APPLE' AND POS ( ID_MODL_IFR, 'IPHONE' ) > 0) "
	sFilterFour += " OR " 
	sFilterFour += "( ID_MARQ_IFR = 'ASUS' AND ID_MODL_IFR = 'EEEPC LINUX' ) " 		// #8 [DCMP080737] 
	sFilterFour += " OR " 
	sFilterFour += "( ID_MARQ_IFR = 'ASUS' AND ID_MODL_IFR = 'EEEPC WINDOWS' ) " 		// #8 [DCMP080737] 

	idwArticle.SetFilter (sFilterFour)
	idwArticle.Filter ()
	idwArticle.RowsDisCard ( 1, idwArticle.RowCount (), Primary! )
End IF 
// :#3

idwArticle.SetFilter ( sFiltreOrig )
idwArticle.SetSort ( sSortOrig )
idwArticle.Filter ( )
idwArticle.Sort ( )

idwArticle.SetRedraw ( TRUE )

// #12  [DCMP090362] Restauration d'origne suite à l'éventuellement subtitution faite en amont
isMarqPortAdh = sMarqAdhSav
isModlPortAdh = sModlAdhSav  
// :#12  [DCMP090362] 

// #3		
If stMessage.sCode <> "" Then		
	ibIPHONE_absent = TRUE // [ITSM107966]
	
	stMessage.sTitre		= "Commande"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sVar[1]    = isMarqPortAdh
	stMessage.sVar[2]    = isModlPortAdh
	F_Message ( stMessage )

	idwArticle.SetFilter ( "" )
	idwArticle.Filter ()
	idwArticle.Reset ( )

	idwCmde.PostEvent ( "ue_Retour" )
	Return
End If 
// :#3

// :#2



/*------------------------------------------------------------------*/
/* Nous sommes en sélection de mobiles à placer sur courriers. Si   */
/* le mobile sinistré du client est dispo chez un fournisseur,      */
/* impossible de sélectionner un mobile, il faut directement le     */
/* commander (par la fenêtre des commandes)                         */
/*------------------------------------------------------------------*/
If isMobileUnique <> "" And isChoixAction = "S" Then
	stMessage.sTitre  	= "Controle de saisie"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "COMD080"
	F_Message ( stMessage )
End If

end subroutine

private function string uf_controlergestion_rueducommerce (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_RueDuCommerce (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 11/09/2015
//* Libellé			: Controle Spécifique pour Coriolis
//* Commentaires	: [VDOC18125]
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ	PAR	Date			Modification
//       JFF   03/06/2010  [PC397/443_IPAD]
//		FPI	22/09/2015	[DT172]
//*-----------------------------------------------------------------
String sPos, sIdTypArtCmd  , sVal
Long lRow

sPos = ""

sIdTypArtCmd  = Upper ( idwArticle.GetItemString ( alCpt, "ID_TYP_ART" ) )

If sIdTypArtCmd = "CAS" Then

	stMessage.sTitre		= "Commandes"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= YesNo!
	stMessage.sCode		= "COMD925"

	If F_Message ( stMessage ) = 2 Then
		sPos = "ALT_CHOIX"
	End If
	
End If

// [DT172]
If sIdTypArtCmd = "CAF" Then
	lRow=idwwdivsin.Find("Upper(NOM_ZONE)='NUM_COMMANDE'",1,	idwwdivsin.RowCount())
	If lRow > 0 Then
		sVal=idwwdivsin.GetItemString(lRow, "VAL_CAR")
		If isNull(sVal) or Trim(sVal)="" Then
			stMessage.sTitre		= "Commandes"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "COMD926"
			sPos = "ALT_CHOIX"
			
			f_message(stMessage)
			
		End if
	End if
End if
// :[DT172]

Return sPos

end function

private function string uf_controlergestion_cdiscountpro (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_CDiscountPRO (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 23/11/2015
//* Libellé			: Controle Spécifique pour CDP
//* Commentaires	: [DT185]
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ	PAR	Date			Modification
//       JFF   23/11/2015 [DT185]
//       JFF   03/09/2018 [DT361]
//*-----------------------------------------------------------------
String sPos, sFiltreOrig, sSortOrig, sTypAction, sNumGsm, sVal, sNom
Long   lRow, lModeRempl, lDeb, lFin, lIdSin  
Boolean bAltSuiviSms
n_cst_string lnv_string
DataWindowChild dwChild
Long lIdEvt 

sPos = ""

sTypAction = idwArticle.GetItemString ( alCpt, "ID_TYP_ART" )
lIdEvt = idwDetail.GetItemNumber  ( 1, "ID_EVT" )

lIdSin  = idwDetail.GetItemNumber ( 1, "ID_SIN" )
sNom    = idwWsin.GetItemString  ( 1, "NOM" ) + " " + idwWsin.GetItemString  ( 1, "PRENOM" ) 

Choose Case sTypAction

	Case "CAF"

		// Ok
		
	Case Else 
		
		If lIdEvt = 1317 Then
			idwDetail.GetChild ( "ID_EVT", dwChild )
			lRow = dwChild.Find ( "ID_CODE = 936", 1, dwChild.RowCount()) 
			If lRow > 0 Then
				stMessage.sCode = "COMD929"
				stMessage.berreurg=FALSE
				F_Message ( stMessage )
				Return "CHOIX"				
			End If
		End If

End CHoose


Return sPos

end function

public function integer uf_get_btqpsm_centralisation (long alidprod, long alidsin, long alidevt, string asaction, ref string ascodebtqcentral);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::uf_get_btqpsm_centralisation
//* Auteur			: F. Pinon
//* Date				: 01/04/2014
//* Libellé			: 
//* Commentaires	: [PM257-1]
//*
//* Arguments		: alIdProd	Long
//*					  alIdSin	long
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//			FPI		13/01/2015	[PM222-2]
//			FPI		06/07/2015	[2EME_APPEL_WS_PSM]
// 			FPI		15/07/2016	[VDOC21323]
//			FPI		08/12/2017	[VDoc25239]
//*-----------------------------------------------------------------
Long lRet, lRowDD
n_cst_sp_ws_btqpsm_caller uWsCaller
psm_psmdataresponse uoReponse
String adrCp, sAction, sVal

adrCp=idwWSin.GetItemString(1,"ADR_CP")

sAction="A_REPARER"

if asAction<> "" Then sAction=asAction //[PM222-2]

If alIdEvt=1377 Then sAction="A_DESOXYDER"

uWsCaller = Create n_cst_sp_ws_btqpsm_caller

lRet= uWsCaller.uf_get_boutiques_centralisation(sAction, alIdProd, adrCp, ismarqportadh , ismodlportadh, string(alIdSin), istypapp, uoReponse )

// [2EME_APPEL_WS_PSM]
if lRet < 0 Then 
	lRet= uWsCaller.uf_get_boutiques_centralisation(sAction, alIdProd, adrCp, ismarqportadh , ismodlportadh, string(alIdSin), istypapp, uoReponse )
End if

asCodeBtqCentral = "-1"
If lRet = 1 Then 
	asCodeBtqCentral = uoReponse.centralisation
	
	// [CORR_PROC_SANS_PSM]
	If isNull(asCodeBtqCentral) Then asCodeBtqCentral=""
	
	// [VDOC21323]
	Do While Len(asCodeBtqCentral) > 0 and not isNumber(asCodeBtqCentral)
		asCodeBtqCentral=Mid(asCodeBtqCentral,2)
	Loop
	// :[VDOC21323]

	If not isNumber(asCodeBtqCentral) Then 	asCodeBtqCentral=""
	
	If Trim ( asCodeBtqCentral ) = "" Then
		asCodeBtqCentral = "-1"
		lRet = -1
	End if
	// :[CORR_PROC_SANS_PSM]
	
	
End If

lRowDD  = idwwdivdet.Find ( "NOM_ZONE = 'pb_webservice_PSM'", 1, idwwDivDet.RowCount () )				

if lRet < 1 Then
	// marquage de l'erreur
	
	If lRowDD  <= 0 Then
		lRowDD  = idwwdivdet.InsertRow (0)
			
		idwwdivdet.SetItem ( lRowDD , "ID_SIN", alIdSin )
		idwwdivdet.SetItem ( lRowDD , "ID_GTI", idwDetail.GetItemNumber ( 1, "ID_GTI" ) )	
		idwwdivdet.SetItem ( lRowDD , "ID_DETAIL", idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) )		 
		idwwdivdet.SetItem ( lRowDD , "NOM_ZONE", "pb_webservice_PSM" )
		idwwdivdet.SetItem ( lRowDD , "LIB_LABEL", "WebService Btq PSM indisponible" )
		idwwdivdet.SetItem ( lRowDD , "ID_TYP_LISTE", "-XX" )
		idwwdivdet.SetItem ( lRowDD , "ALT_LISTE_CODECAR", "N")
		idwwdivdet.SetItem ( lRowDD , "ID_TYP_ZONE", "X" )
		idwwdivdet.SetItem ( lRowDD , "ALT_OBLIG", "N" )
		idwwdivdet.SetItem ( lRowDD , "ALT_PROT", "O" )
		idwwdivdet.SetItem ( lRowDD , "CPT_TRI", 500 )
		idwwdivdet.SetItem ( lRowDD , "VAL_DTE", stNul.dtm )	// [PI056].20190926
		idwwdivdet.SetItem ( lRowDD , "VAL_CAR", "O" )
		idwwdivdet.SetItem ( lRowDD , "VAL_NBRE", stNul.lng )
		idwwdivdet.SetItem ( lRowDD , "VAL_MT", stnul.dcm )
		idwwdivdet.SetItem ( lRowDD , "ALT_SUPP", "N" )
		idwwdivdet.SetItem ( lRowDD , "CREE_LE", DateTime ( Today (), Now () ) )
		idwwdivdet.SetItem ( lRowDD , "MAJ_LE", DateTime ( Today (), Now () ) )
		idwwdivdet.SetItem ( lRowDD , "MAJ_PAR", stGlb.sCodOper )
	End If
Else
	If lRowDD > 0 Then idwwdivdet.deleterow( lRowDD )	
	
	uf_check_boutique_psm( uoReponse ) // [VDoc25239]

End if

Destroy uWsCaller

Return lRet
end function

public function string uf_gestion_relaipickup ();//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_Commande3::uf_Gestion_RelaiPickUp (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 01/03/2016
//* Libellé       : Gestion des relai PickUp
//* Commentaires  : [DT191-1] Fonction Relai PickUp
//*
//* Arguments     :		Réf	   // Dw commande ou prestation ?
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*
//*-----------------------------------------------------------------

String sRet
st_point_relai_chronopost relai_chrono
Long lIdSin  
String sNom, sAdrMail 
n_cst_string lnvPFCString
Long lRow 

lIdSin  = idwDetail.GetItemNumber ( 1, "ID_SIN" )
sNom    = idwWsin.GetItemString  ( 1, "NOM" ) + " " + idwWsin.GetItemString  ( 1, "PRENOM" ) 


lRow = idwlstinter.Find ( "COD_INTER='A'", 1, idwlstinter.RowCount() )
If lRow > 0 Then
	sAdrMail = idwlstinter.GetItemString (lRow, "ADR_MAIL" )
End if
		
If IsNull ( sAdrMail ) Or Len ( Trim ( sAdrMail )) = 0 Then
	// Mail null
	stMessage.sTitre		= "Relais Pick Up !! => Absence de mail"
	stMessage.Icon			= Question!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= YESNO!
	stMessage.sCode		= "COMD852"
	
	sRet = "[RETOUR]"
	
	If f_Message ( stMessage ) = 1 Then
		ibDecocherPresta = True
	End If
	
	Return sRet
Else
	// Mail présent, cas eligible au process Relai PickUp
	stMessage.sTitre		= "Relais Pick Up !! => Adresse mail valide ?"
	stMessage.Icon			= Question!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= YESNO!
	stMessage.sCode		= "COMD853"
	stMessage.sVar[1]		= sAdrMail
	
	If f_Message ( stMessage ) = 2 Then
		ibDecocherPresta = True
		sRet = "[RETOUR]"			
		Return sRet
	End If


End If

// Init à laisser.
isAdrCivPickUp	  = "" 
isAdrNomPickUp   = ""
isAdrPreNomPickUp = ""
isAdr1PickUp     = ""
isAdr2PickUp     = ""
isAdrCpltPickUp  = ""
isAdrCpPickUp    = ""
isAdrVillePickUp = ""
isCodePickUp 	  = ""

relai_chrono.nomassure=idwcmde.GetItemString(1,"ADR_NOM")
relai_chrono.prenomassure=idwcmde.GetItemString(1,"ADR_PRENOM")
relai_chrono.adresse1=idwcmde.GetItemString(1,"ADR_LIVR1")
relai_chrono.adresse2=idwcmde.GetItemString(1,"ADR_LIVR2")
relai_chrono.adresse3=idwcmde.GetItemString(1,"ADR_LIVR_CPL")
relai_chrono.codepostal =idwcmde.GetItemString(1,"ADR_CP")
relai_chrono.ville =idwcmde.GetItemString(1,"ADR_VILLE")
	
OpenWithParm(w_sp_trt_saisie_relai_pickup, relai_chrono)
	
relai_chrono=Message.Powerobjectparm


If relai_chrono.returncode="[RETOUR]" Then
	sRet = relai_chrono.returncode
	stMessage.sTitre		= "Commandes"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sCode		= "COMD937"	
	
	f_Message ( stMessage ) 

	Return sRet
End If

// Hors Atlas (normal)
// Valeur test qu'il faudra ensuite renseigner avec les retours 
// Armement pour les ZVAR du courrier
isAdrCivPickUp	 = "5" // Toujours en dur
isAdrNomPickUp   = relai_chrono.pointrelais.nom
isAdrPreNomPickUp = String ( lIdSin ) + " " + sNom // A laisser
isAdr1PickUp     = relai_chrono.pointrelais.adresse1
isAdr2PickUp     = relai_chrono.pointrelais.adresse2
isAdrCpltPickUp  = relai_chrono.pointrelais.adresse3
isAdrCpPickUp    = relai_chrono.pointrelais.codepostal
isAdrVillePickUp = relai_chrono.pointrelais.localite

// Le code 
isCodePickUp     = relai_chrono.pointrelais.identifiant

gsAdrCivPickUp = isAdrCivPickUp
gsAdrNomPickUp = isAdrNomPickUp
gsAdrPreNomPickUp = isAdrPreNomPickUp 
gsAdr1PickUp = isAdr1PickUp 
gsAdr2PickUp = isAdr2PickUp  
gsAdrCpltPickUp = isAdrCpltPickUp 
gsAdrVillePickUp = isAdrVillePickUp 
gsAdrCpPickUp = isAdrCpPickUp 
gsCodePickUp = isCodePickUp 

If Not IsNull ( isCodePickUp ) And Len ( Trim ( isCodePickUp ) ) > 0  Then
	If not isnull(relai_chrono.pointrelais) Then
		gsHorairePickUp = relai_chrono.pointrelais.uf_get_horaires_semaine ()
	End if
End If

If IsNull ( gsHorairePickUp ) or Trim(gsHorairePickUp) = "" Then gsHorairePickUp = "(Horaires non précisés)"

idwCmde.SetItem ( 1, "ADR_COD_CIV"		, isAdrCivPickUp )
idwCmde.SetItem ( 1, "ADR_NOM"			, isAdrNomPickUp )
idwCmde.SetItem ( 1, "ADR_PRENOM"		, isAdrPreNomPickUp )
idwCmde.SetItem ( 1, "ADR_LIVR1"			, isAdr1PickUp ) 
idwCmde.SetItem ( 1, "ADR_LIVR2"			, isAdr2PickUp ) 
idwCmde.SetItem ( 1, "ADR_LIVR_CPL"		, isAdrCpltPickUp )
idwCmde.SetItem ( 1, "ADR_CP"				, isAdrCpPickUp)
idwCmde.SetItem ( 1, "ADR_VILLE"			, isAdrVillePickUp )	

lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_PICK_UP", isCodePickUp, ";")					

stMessage.sTitre		= "Commandes"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= OK!
stMessage.sCode		= "COMD855"	

f_Message ( stMessage ) 


Return sRet



end function

private function string uf_controlergestion_cma (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_CMA 	(PRIVATE)
//* Auteur			: FPI
//* Date				: 08/04/2016
//* Libellé			: Controle Spécifique pour Carma
//* Commentaires	: [DT176]
//*					  
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//			FPI		22/03/2018	[DT339]
//*-----------------------------------------------------------------

String sPos
n_cst_string lnvPFCString
Long lDeb, lFin

sPos = ""

F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 297 ) 
If lDeb > 0 Then	
	lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "GESTION_ENVOI_BA", "SPB", ";")
	
	// [DT339]
	if idwcmde.GetItemDecimal( alCpt, "MT_TTC_CMDE")  > 1000 Then
			lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "TYPE_ENVOI", "PHYSIQUE", ";")
	End if
	
	if lnvPFCString.of_getkeyvalue(idw_DetPro.GetItemString(lDeb, "VAL_CAR"), "ENVOI_DIFFERE", ";") = "OUI" Then
		lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "ENVOI_DIFFERE", "OUI", ";")
	End if
		
Else
	lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "GESTION_ENVOI_BA", "CARMA", ";")
End If


Return sPos

end function

private subroutine uf_selectionautomatique_id_ref_four (string asidreffour);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_w_commande3::uf_selectionautomatique_id_ref_four (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 19/04/2016 
//* Libellé       : Sélection automatique sur id_ref_four
//* Commentaires  : [DT209]
//*
//* Arguments     : 	String		asIdFour		Val
//*					  	String		asFiltre		Val
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*-----------------------------------------------------------------

Long	lDeb, lFin, lCpt, lTotRow, lRowFournOrig, lRowFournRech, lCoche, lIdEvt, lRow1, lRow2, lRow3, lRow4
String	sFiltreOrig, sSortOrig, sAdrMail
Boolean bConsAppPretVol, bOkFiltre

bOkFiltre = True

/*------------------------------------------------------------------*/
/* On sauve le filtre original.                                     */
/*------------------------------------------------------------------*/
sFiltreOrig = idwArticle.Describe ("DataWindow.Table.filter") 
If sFiltreOrig = "?" Then sFiltreOrig = ""

sSortOrig = idwArticle.Describe ("DataWindow.Table.Sort") 
If sSortOrig = "?" Then sSortOrig = ""

// [PM280-2]
If asIdRefFour = "CONTEST_SUR_REMPL" Then
	lRow1 = idwCmdeSin.Find ( "ID_REF_FOUR = 'CONTEST_SUR_REMPL'", 1, idwCmdeSin.RowCount ())
	bOkFiltre = lRow1 <= 0 
End If


If bOkFiltre Then
	idwArticle.SetFilter ( "ID_REF_FOUR = '" + asIdRefFour + "'" )
	idwArticle.Filter ( )
	
	/*------------------------------------------------------------------*/
	/* On Coche les trois premiers mobiles (au plus)                    */
	/*------------------------------------------------------------------*/
	If idwArticle.RowCount () > 0 Then
		idwArticle.SetItem ( 1, "CHOIX", "O" )
		This.uf_Zn_Choix ( iDwArticle, "O", 1 )	
	End If
End If	
	

// [PM280-2]
Choose Case asIdRefFour
	Case "CONTEST_SUR_REMPL"
		idwArticle.SetFilter ( "ID_REF_FOUR = '" + asIdRefFour + "' OR ID_REF_FOUR IN ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP' )" )
		idwArticle.Filter ( )

End Choose 

// #1 Suppression des autres articles pour éviter les erreus
idwArticle.RowsDisCard ( 1, idwArticle.FilteredCount(), Filter! )


/*------------------------------------------------------------------*/
/* On replace le filtre d'origine.                                  */
/*------------------------------------------------------------------*/
This.uf_RowFocusChanged ( "DWFOURN" ) 

idwArticle.SetFilter ( sFiltreOrig  )
idwArticle.Filter ()
idwArticle.SetSort ( sSortOrig  )
idwArticle.Sort ()



end subroutine

private function string uf_controlergestion_centreautoleclerc (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_CentreAutoLeclerc (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 08/06/2016
//* Libellé			: Controle Spécifique pour CALet AUT
//* Commentaires	: [DT227]
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ	PAR	Date			Modification
//       JFF   05/08/2024  [MCO602_PNEU]
//*-----------------------------------------------------------------

Long lDeb, lFin, lRow
String sVal, sPos, sIdFour

sIdFour = idwArticle.GetItemString ( alCpt, "ID_FOUR" )


// [MCO602_PNEU]
If F_CLE_A_TRUE ( "MCO602_PNEU" ) Then
	stMessage.sCode = "COMT005" // 
	stMessage.bouton = Ok!
	F_Message ( stMessage )
	sPos = "ALT_CHOIX"
	Return "G" + "ALT_CHOIX"			

Else 
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 299 )
	If lDeb > 0 Then
		lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'LIEU_REPAR'", 1, idwWDivSin.RowCount () ) 
		If lRow >0 Then 
			sVal = Upper ( idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) )
			
			If sVal <> sIdFour Then
				stMessage.sCode = "COMD946" // 
				stMessage.bouton = Ok!
				F_Message ( stMessage )
				sPos = "ALT_CHOIX"
				Return "G" + "ALT_CHOIX"			
			End If
			
		End If 
	End If
	
End If



Return sPos

end function

private function string uf_controlergestion_eko_net_dgc (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_EKO_NET_DGC 	(PRIVATE)
//* Auteur			: JFF
//* Date				: 08/11/2016
//* Libellé			: Controle Spécifique pour EKOTEK, NETPHONE GROUP, DGC MULTIMEDIA
//* Commentaires	: [PC151259]
//*					  
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

String sPos, sVal 
n_cst_string lnvPFCString
Long lDeb, lFin, lRow

sPos = ""

lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'FRN_REPA_ADH'", 1, idwWDivSin.RowCount () ) 

If lRow <= 0 Then Return sPos

sVal = Trim ( Upper ( idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) ))
If IsNull ( sVal ) Then sVal = ""

// [PC151259-2]
Choose Case Left ( sVal, 3 )
	Case "NET", "RAV"
		lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "SOUS_FRN", sVal, ";")	
End Choose 

Return sPos

end function

private function string uf_zn_choix_process_cmde_orangev3 (datawindow adw, long alrow, string astypart, string asaction);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::uf_zn_choix_process_Cmde_OrangeV3 (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 07/05/2013
//* Libellé			: Regle_PSM
//* Commentaires	: [PC938_ORANGE_V3]
//*
//* Arguments		: String asCas
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//       JFF   17/06/2013 [PC946_ORANGE_OPPRO]
// 		JFF   19/09/2013 [VDOC12142] 
// 		JFF   02/12/2013 [ITSM186841]
// 		JFF   24/03/2014 [VDOC8041]
//       JFF   07/05/2013 [DT081_EVOL_PRET_BRIS]
//       JFF   08/04/2014 [PM255]
//       JFF   30/07/2014 [PM234-4_V1]
//       JFF   11/08/2014 [DT94]
//       JFF   04/11/2014 [PM280-1]
//       JFF   05/01/2015 [DT94_V3]
//       JFF   09/02/2015 [ITSM271446]
//       JFF   25/03/2015 [VDOC17204]
//       JFF   13/07/2015 [PC151270_ORANGE_V3]
//       JFF   06/08/2015 [ITSM312914]
//       JFF   15/12/2015 [DT191]
//       JFF   19/01/2015 [DT191][MANTIS19258]
// 		JFF	03/02/2016 [DT191][V3]
// 		JFF	12/02/2016 [ITSM362519]
// 		JFF	22/02/2016 [ITSM363955]
// 		JFF	03/03/2016 [ITSM365999]
// 		JFF	10/02/2016 [DT191][#]
// 		JFF	18/03/2016 [BUG_PICK_UP]
//       JFF   21/03/2016 [370853_ITSM]
//       JFF   23/03/2016 [DT191-1][MANTIS20039]
//			JFF   30/03/2016 [VDOC20392]
//       JFF   23/01/2017 [DT290]
//       JFF   21/02/2107 [DT288]
//       JFF   12/05/2107 [BUG_CORDON]
//       JFF   01/08/2017 [DT288-1][MODIF_CHRISTINE]
//       JFF   16/08/2017 [ITSM482467]
//       JFF   31/08/2017 [ITSM485071]
//       JFF   06/09/2017 [ITSM485869]
// 		JFF   20/09/2017 [BUG_PRET_REMPL]
//       JFF   10/12/2018 [PM453-1]
//       JFF   25/03/2019 [DT398]
//       JFF   16/08/2022 [RS3200]
//       JFF   10/10/2019 [DT398] Version clé 2
//*---------------------------------------------------------------

String sRet, sVar, sNom, sChoixOOP, sVal, sSql 
String sVal1, sNumPdvReel
Int iPos 
boolean bFin, bBtqPSM, bLieuProf, bDomicile, bPcePVRecu, bPretStandard, bCasBrisHorsPrs, bRempl, bCasReouv235_236, bCasBrisIrreparable 
Boolean bEntreDeGamme, bSmartPhone, bIphone, bRelaiPickUp, bMethode_BoutiquePSM_WS, bIphone5, bTrouveTypPret
n_cst_string lnvPFCString
Long lCodeMag, lIdProd, lIdSin, lRow, lIdGti, lProcessOrig, lRowOrig, lVal, lIdEvt, lRow4, iLen 
String sAdrNom, sAdr1, sAdr2, sAdrVille, sAdrCp, sAdrMail, sCodePickUpOrig, sCpAssure, sVal2, sIdFour
Decimal {2} dcMtPec, dcTva
s_pass stPass
st_point_relai_chronopost relai_chrono
n_cst_attrib_key	lnv_Key[]
Boolean bDeclaWebAtlas, bEnvoiParAssure, bDcnxWebAtlas, bBonPrePaye
String sTypLivrAtlas, sCodLivrAtlas, sTypAppPretAtlas
n_cst_sp_ws_chronopost_caller uoWsCaller
Boolean bCasHorsVol // [ITSM271446]
String sPrcOrig, sInfoSpbFrnCpltSav
Boolean bARepGti // [PM280-1]
Boolean bPC151270 // [PC151270_ORANGE_V3]
Boolean bDT290 // [DT290]
Long lDeb, lFin, lCptDetPro 
DateTime dtDtePivotDT1288, dtCreeLeDos
Boolean bCmdeDme 

lIdProd=idwWSin.GetItemNumber( 1, "ID_PROD")
sIdFour=Upper ( adw.GetItemString ( alRow, "ID_FOUR" ) )
bDT290 = FALSE
bCmdeDme = FALSE

// [PM280-1]
bARepGti = lnvPFCString.of_Getkeyvalue( isInfoSpbFrnCplt, "A_REP_GARANTIE", ";" ) = "OUI"

// [PM234-4_V1]
bDeclaWebAtlas = FALSE
bDeclaWebAtlas = idwWDivsin.Find ( "NOM_ZONE = 'decla_atlas' AND VAL_CAR = 'O'", 1, idwWDivSin.RowCount () ) > 0
bDcnxWebAtlas = idwWDivsin.Find ( "NOM_ZONE = 'dcnx_decla_atlas' AND VAL_CAR = 'O'", 1, idwWDivSin.RowCount () ) > 0

// [PC151270_ORANGE_V3]
lnv_Key[1].iskeyname	 ="PC151270"
lnv_Key[1].iakeyvalue ="OUI"

// [DT288]
dtCreeLeDos = idwWSin.GetItemDateTime ( 1, "CREE_LE")

F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 239, lnv_Key )
If lRow > 0 Then
	bPC151270 = TRUE
End If
// :[PC151270_ORANGE_V3]

// [DT288]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 315 )
If lDeb > 0 Then
	dtDtePivotDT1288 = DateTime ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "DTE_PIVOT_DT288", ";") )
End If

If bDcnxWebAtlas Then
	bDeclaWebAtlas = False
End If

lRow = idwWDivsin.Find ( "NOM_ZONE = 'type_livraison_atlas'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	sTypLivrAtlas = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
	If IsNull ( sTypLivrAtlas ) Then sTypLivrAtlas = ""		
	
	Choose Case sTypLivrAtlas
		Case "DMC", "LIP"
			sTypLivrAtlas = "BPP"
	End Choose 
	
End If

lRow = idwWDivsin.Find ( "NOM_ZONE = 'code_livraison_atlas'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	sCodLivrAtlas = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
	If IsNull ( sCodLivrAtlas ) Then sCodLivrAtlas = ""		
End If

lRow = idwWDivsin.Find ( "NOM_ZONE = 'typ_app_pret_atlas'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	sTypAppPretAtlas = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
	If IsNull ( sTypAppPretAtlas ) Then sTypAppPretAtlas = ""				
End If
// [PM234-4_V1]

lIdSin  = idwDetail.GetItemNumber ( 1, "ID_SIN" )
sNom    = idwWsin.GetItemString  ( 1, "NOM" ) + " " + idwWsin.GetItemString  ( 1, "PRENOM" ) 

// [DT288]
If bDeclaWebAtlas Then
	If sTypLivrAtlas = "PXM" And isMarqPortAdh = "APPLE" And dtCreeLeDos >= dtDtePivotDT1288 Then
		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!

		//	[VDOC20392]			
		stMessage.sCode		= "COMD954"

/*		 
		 sSql = "Exec sysadm.PS_S01_MAIL 'mpotrel@spb.fr,jff@spb.fr,hforjonel@spb.fr', "  +&
				  "'Bug ATLAS à l''instant DT288 PXM sur APPLE, sur dossier :  " + String ( lIdSin ) + ", GT : " + stGlb.sCodOper + ", Base " + SQLCA.Database + "', " + &
				  "'Bug ATLAS : Dossier " + String ( lIdSin ) + "'" + ", " + &
				  "'Bug ATLAS !'"		    + ", " + &
				  "''"			 		 	+ ", " + &
				  "null"   				 		 + ", " + &
				  "null"   				 		 + ", " + &
				  "null"   				 		 + ", " + &
				  "null"   				 		 + ", " + &
				  "null"
		
			F_execute ( sSql, SQLCA )
			F_Commit ( SQLCA, true )
*/

		f_Message ( stMessage ) 

		ibDecocherPresta = TRUE			
		Return sRet
		
	End If
End If


// [370853_ITSM]
If bDeclaWebAtlas Then
	lRow = idwLstInter.Find ( "COD_INTER = 'L'", 1, idwLstInter.RowCount ())
	If ( lRow <= 0 And ( sTypLivrAtlas = "RPU" Or sTypLivrAtlas = "BPP" ) ) Or &
		sTypLivrAtlas = "" Or &
		( ( sTypLivrAtlas = "RPU" Or sTypLivrAtlas = "PXM" ) And sCodLivrAtlas = "" ) &
		Then
		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!

		//	[VDOC20392]			
		stMessage.sCode		= "COMD941"

/*
		 sSql = "Exec sysadm.PS_S01_MAIL 'mpotrel@spb.fr,jff@spb.fr,hforjonel@spb.fr', "  +&
				  "'Bug ATLAS à l''instant sur dossier :  " + String ( lIdSin ) + ", GT : " + stGlb.sCodOper + ", Base " + SQLCA.Database + "', " + &
				  "'Bug ATLAS : Dossier " + String ( lIdSin ) + "'" + ", " + &
				  "'Bug ATLAS !'"		    + ", " + &
				  "''"			 		 	+ ", " + &
				  "null"   				 		 + ", " + &
				  "null"   				 		 + ", " + &
				  "null"   				 		 + ", " + &
				  "null"   				 		 + ", " + &
				  "null"
		
			F_execute ( sSql, SQLCA )
			F_Commit ( SQLCA, true )
*/

		f_Message ( stMessage ) 

		ibDecocherPresta = TRUE			
		Return sRet
	End If
End If


bPcePVRecu = FALSE
lProcessOrig = -1
bCasReouv235_236 = False

sCpAssure = ""
lRow = idwlstinter.Find ( "COD_INTER='A'", 1, idwlstinter.RowCount() )
If lRow > 0 Then
	sCpAssure = idwlstinter.GetItemString ( lRow, "ADR_CP" )
End if

bMethode_BoutiquePSM_WS = TRUE
lnv_Key[1].iskeyname	 ="TYP_APP"
lnv_Key[1].iakeyvalue =isTypApp
F_RechDetPro_withkey( lRow, idw_DetPro, idwWsin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 209, lnv_Key )

sVal2= lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lRow, "VAL_CAR" ), "METHODE_WS", ";")
if sVal2="NON" Then bMethode_BoutiquePSM_WS=FALSE

/*
Msg :  3 choix possibles  livraison : domicile, bureau, dans un PSM 
	 L’assuré souhaite-t-il être livré dans un PSM ?  O/N
*/

// PCE_PV_RECU ?
lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'PCE_PV_RECU'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bPcePVRecu = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
End If	

lIdGti = idwDetail.GetItemNumber ( 1, "ID_GTI" )
lIdEvt = idwDetail.GetItemNumber ( 1, "ID_EVT" ) // [PM280-1]

// Cas du diag
bCasHorsVol = lIdGti <> 10  // [ITSM271446]
bCasBrisHorsPrs = ( lIdGti = 11 Or lIdGti = 24 ) And idwCmdeSin.Find ( "ID_TYP_ART = 'PRS' AND COD_ETAT <> 'ANN' ", 1, idwCmdeSin.RowCount ()) <= 0 
bCasBrisIrreparable = ( lIdGti = 11 Or lIdGti = 24 ) And idwCmdeSin.Find ( "ID_TYP_ART = 'PRS' AND COD_ETAT <> 'ANN' AND STATUS_GC IN ( 21, 23 )", 1, idwCmdeSin.RowCount ()) > 0 

If ( ( adw.GetItemString ( alRow, "ID_TYP_ART" ) = "PST" And adw.GetItemString ( alRow, "ID_FOUR" ) = "O2M" ) Or &
	  ( adw.GetItemString ( alRow, "ID_TYP_ART" ) = "PRS" And adw.GetItemString ( alRow, "ID_FOUR" ) = "PSM" ) &
	)  Then
	
	If idwCmdeSin.Find("ID_FOUR IN ('O2M') AND ID_TYP_ART = 'PST' AND COD_ETAT NOT IN ( 'ANN', 'RFO', 'RPC') AND STATUS_GC IN ( 235, 236)",1,idwCmdeSin.RowCount()) > 0 Or &
		idwCmdeSin.Find("ID_FOUR IN ('PSM') AND ID_TYP_ART = 'PRS' AND COD_ETAT NOT IN ( 'ANN', 'RFO', 'RPC') AND STATUS_GC IN ( 235, 236)",1,idwCmdeSin.RowCount()) > 0 Then

		bCasReouv235_236 = True
		Return sRet

	End IF
End If

// [VDOC8041]
If ( adw.GetItemString ( alRow, "ID_TYP_ART" ) = "PRS" And adw.GetItemString ( alRow, "ID_FOUR" ) = "O2M" ) Then
	
	If idwCmdeSin.Find("ID_FOUR IN ('O2M') AND ID_TYP_ART = 'PRS' AND COD_ETAT NOT IN ( 'ANN', 'RFO', 'RPC') AND STATUS_GC IN ( 232 )",1,idwCmdeSin.RowCount()) > 0 Then

		Return sRet

	End IF
End If
// [VDOC8041]


If asAction = "C" Then
	lRowOrig = idwCmdeSin.Find ( "ID_TYP_ART = 'PST' AND COD_ETAT <> 'ANN' AND POS ( INFO_SPB_FRN_CPLT, 'PRC_ORIG=') > 0", 1, idwCmdeSin.RowCount () )
	If lRowOrig > 0 Then
		sPrcOrig = lnvPFCString.of_getkeyvalue (idwCmdeSin.GetItemString ( lRowOrig, "INFO_SPB_FRN_CPLT" ), "PRC_ORIG", ";")
		lProcessOrig = Long ( sPrcOrig )
	End If
	
	If lRowOrig <= 0 Then
		lRowOrig = idwCmdeSin.Find ( "ID_TYP_ART = 'PST' AND COD_ETAT <> 'ANN'", 1, idwCmdeSin.RowCount () )
		If lRowOrig > 0 Then
			lProcessOrig = idwCmdeSin.GetItemNumber ( lRowOrig, "INFO_SPB_FRN" )
			
			// [PM255]
			sCodePickUpOrig = lnvPFCString.of_getkeyvalue (idwCmdeSin.GetItemString ( lRowOrig, "INFO_SPB_FRN_CPLT" ), "CODE_PICK_UP", ";")
		End If
	End If

	If lRowOrig <= 0 Then

		lRowOrig = idwCmdeSin.Find ( "ID_TYP_ART = 'PRS' AND ID_FOUR = 'PSM' AND POS ( INFO_SPB_FRN_CPLT, 'CODE_BTQ_PSM_PROXIMITE=') > 0", 1, idwCmdeSin.RowCount () )
		
		If lRowOrig > 0 Then
			
			// [ITSM482467]
			If idwArticle.GetItemString ( alRow, "ID_FOUR" ) = "DME" Then
				lProcessOrig = 910
			Else
				lProcessOrig = 973
				isCodeBoutiqueRelaiPSM = lnvPFCString.of_getkeyvalue (idwCmdeSin.GetItemString ( lRowOrig, "INFO_SPB_FRN_CPLT" ), "CODE_BTQ_PSM_PROXIMITE", ";")
	
				// [ITSM312914]
				if lnvPFCString.of_getkeyvalue (idwCmdeSin.GetItemString ( lRowOrig, "INFO_FRN_SPB_CPLT" ), "ASSURE_EN_PDV", ";")	= "OUI" Then			
					sNumPdvReel = lnvPFCString.of_getkeyvalue (idwCmdeSin.GetItemString ( lRowOrig, "INFO_FRN_SPB_CPLT" ), "NUM_PDV", ";")
				End if
				
				bBtqPSM = TRUE
			End If
		End If

		// [DT191]
		If lRowOrig <= 0 Then
			
			// [ITSM485071]
			lRowOrig = idwCmdeSin.Find ( "ID_TYP_ART = 'PRS' AND COD_ETAT <> 'ANN' AND INFO_SPB_FRN NOT IN ( 2102, 902 )", 1, idwCmdeSin.RowCount () )			
			
			If lRowOrig > 0 Then
				lProcessOrig = idwCmdeSin.GetItemNumber ( lRowOrig, "INFO_SPB_FRN" )
				
				// [PM255]
				sCodePickUpOrig = lnvPFCString.of_getkeyvalue (idwCmdeSin.GetItemString ( lRowOrig, "INFO_SPB_FRN_CPLT" ), "CODE_PICK_UP", ";")
			End If
		End If

		
	End If 
	
	If lProcessOrig > 0 Then
		
		Choose Case lProcessOrig 
			
			// Lieu Prof
			Case 2137, 2139, 976, 978
				
				bLieuProf = True // 974
	
			// Dom 	
			Case 2138, 2140, 977, 979			
				
				bDomicile = True // 975

			// Rel Pick Up
			// [PM255] // [DT191] // [DT290]
			Case 2141, 2142, 981, 982, 2143, 984
				
				bRelaiPickUp = True

			// [DT191]
			// [ITSM363955] ajout 2110
			// [ITSM365999] ajout 1010
			// [DT290] je passe 1010 en  910
			// [DT288] 908
			Case 2116, 912, 2110, 1010, 910, 908
					
				bBonPrePaye = True
				
		End Choose
			
	End IF	
	
End If

// [PM280-1]
If asAction = "R" And bARepGti Then

	// [PM453-1]
	lRow4= idwLstInter.Find ( "COD_INTER = 'A'", 1, idwLstInter.RowCount () )
	If lRow4> 0 Then
		sAdrMail= idwLstInter.GetItemString ( lRow4, "ADR_MAIL" )
		If IsNull ( sAdrMail ) OR Trim ( sAdrMail ) = "" Then
			ilProcessTempo = 910
		Else
			ilProcessTempo = 912
		End If
	End If		
	
	Return sRet	
End If

// [DT94] Cas du SAV sur presta réparé (2) A_REPARER_SAV
If asAction = "R" Then		
	lRowOrig = idwCmdeSin.Find ( "ID_TYP_ART = 'PRS' AND COD_ETAT IN ( 'RPC', 'RFO') AND ID_SEQ > 0 AND STATUS_GC IN ( 2, 21, 22, 23 )", 1, idwCmdeSin.RowCount () )
	
	If lRowOrig > 0 Then
		lProcessOrig = idwCmdeSin.GetItemNumber ( lRowOrig, "INFO_SPB_FRN" )

		// [PM255]
		sCodePickUpOrig = lnvPFCString.of_getkeyvalue (idwCmdeSin.GetItemString ( lRowOrig, "INFO_SPB_FRN_CPLT" ), "CODE_PICK_UP", ";")
		
		Choose Case lProcessOrig	
			Case 976
				lProcessOrig	= 978
			Case 977
				lProcessOrig	= 979
				
			// [DT290]				
			Case 981, 984
				lProcessOrig	= 982
		End CHoose 

	
		Choose Case lProcessOrig	
			Case 2137
				lProcessOrig	= 2139
			Case 2138
				lProcessOrig	= 2140
			Case 2141
				lProcessOrig	= 2142
		End CHoose 
		
		// [DT191-1][MANTIS20039]
		// [DT290]
		Choose Case lProcessOrig
			Case 2143, 2142, 2141, 983, 982, 981, 984

				isAdrCivPickUp	  = idwCmdeSin.GetItemString ( lRowOrig, "ADR_COD_CIV" )
				isAdrNomPickUp   = idwCmdeSin.GetItemString ( lRowOrig, "ADR_NOM" )
				isAdrPreNomPickUp = idwCmdeSin.GetItemString ( lRowOrig, "ADR_PRENOM" )
				isAdr1PickUp     = idwCmdeSin.GetItemString ( lRowOrig, "ADR_LIVR1" )
				isAdr2PickUp     = idwCmdeSin.GetItemString ( lRowOrig, "ADR_LIVR2" )
				isAdrCpltPickUp  = idwCmdeSin.GetItemString ( lRowOrig, "ADR_LIVR_CPL" )
				isAdrCpPickUp    = idwCmdeSin.GetItemString ( lRowOrig, "ADR_CP" )
				isAdrVillePickUp = idwCmdeSin.GetItemString ( lRowOrig, "ADR_VILLE" )
				
				idwCmde.SetItem ( 1, "ADR_COD_CIV"		, isAdrCivPickUp)
				idwCmde.SetItem ( 1, "ADR_NOM"			, isAdrNomPickUp)
				idwCmde.SetItem ( 1, "ADR_PRENOM"		, isAdrPreNomPickUp)
				idwCmde.SetItem ( 1, "ADR_LIVR1"			, isAdr1PickUp)
				idwCmde.SetItem ( 1, "ADR_LIVR2"			, isAdr2PickUp)
				idwCmde.SetItem ( 1, "ADR_LIVR_CPL"		, isAdrCpltPickUp)
				idwCmde.SetItem ( 1, "ADR_CP"				, isAdrCpPickUp)
				idwCmde.SetItem ( 1, "ADR_VILLE"			, isAdrVillePickUp)
				
				// [BUG_CORDON]
				If lProcessOrig > 0 And Not IsNull ( sCodePickUpOrig ) and Trim ( sCodePickUpOrig ) <> "" Then
					lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_PICK_UP", sCodePickUpOrig, ";")																
				End If
				
				gsAdrCivPickUp = isAdrCivPickUp
				gsAdrNomPickUp = isAdrNomPickUp
				gsAdrPreNomPickUp = isAdrPreNomPickUp 
				gsAdr1PickUp = isAdr1PickUp 
				gsAdr2PickUp = isAdr2PickUp  
				gsAdrCpltPickUp = isAdrCpltPickUp 
				gsAdrVillePickUp = isAdrVillePickUp 
				gsAdrCpPickUp = isAdrCpPickUp 
				gsCodePickUp = isCodePickUp
				
		End Choose 
		
		ilProcessTempo = lProcessOrig
		
		// [ITSM282197]
		sInfoSpbFrnCpltSav = idwCmdeSin.GetItemString ( lRowOrig, "INFO_SPB_FRN_CPLT" ) 
		isBtqPsmProxiSav = lnvPFCString.of_Getkeyvalue( sInfoSpbFrnCpltSav, "CODE_BTQ_PSM_PROXIMITE", ";" )

		Return sRet
	End If
End If
// [DT94]


// [PC946_ORANGE_OPPRO]
sChoixOOP = ""

Choose Case asTypArt
	Case "PST", "RES", "REA"
		
		Return sRet
	
	Case "RST"

		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "COMD804"  // COMD790   [DT191]

			stMessage.sVar[1]		= "est cochée"
			lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "RST_CMDE+SUIVI", "OUI", ";")			
	
			
			lRow = idwwDivDet.Find ( "ID_GTI = " + String ( idwDetail.GetItemNumber ( 1, "ID_GTI" ) ) + &
								  " AND ID_DETAIL = " +  String ( idwDetail.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
								  " AND UPPER ( NOM_ZONE ) = 'MT_PEC' " &
							  , 1, idwwDivDet.RowCount () ) 
	
			// Lecture du montant						  
			If lRow > 0 Then
				dcMtPec = idwwDivDet.GetItemDecimal ( lRow, "VAL_MT" )
				dcTva   = adw.GetItemDecimal ( alRow, "TVA" )
				dcMtPec = dcMtPec / (1 + ( dcTva / 100))
				
				adw.SetItem ( alRow, "MT_PRIX_HT", dcMtPec )
			End if 			


			F_Message ( stMessage ) 			
		
End Choose

// [PM280-1]
If asAction = "R" And isCodeBoutiqueProximitePSM = "" And lIdEvt <> 1422 Then

	isInfoSpbFrnCpltTempo = ""
	ilProcessTempo = 0

	// [DT94]
	If bDeclaWebAtlas Then
		// [PC151270_ORANGE_V3]
		bPretStandard = Not IsNUll ( sTypAppPretAtlas ) And Len ( sTypAppPretAtlas ) > 0 
		If bPC151270 Then
			If bPretStandard  Then
				stMessage.sTitre		= "Commandes"
				stMessage.Icon			= Exclamation!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= Ok!
				stMessage.sCode		= "COMD918"
				
				f_Message ( stMessage ) 
			End If
			bPretStandard = False
		End If
	Else	
		// [PC151270_ORANGE_V3]
		bPretStandard = False
		If Not bPC151270 Then
			
			// [VDOC18500]
			// Plus d'un prêt => passer par le protugal prêt hors SIMPA2
			stMessage.sTitre		= "vDoc18500/DPG/Christine Quertier"
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!
			stMessage.sCode		= "COMD924"
			
			f_Message ( stMessage )
			
			bPretStandard = FALSE
		End If 
	End If 	

	// [PM255]
	// [DT94_V3] Shunt DT94
	// [PM234-4_V1]
	If bDeclaWebAtlas Then
		bRelaiPickUp = sTypLivrAtlas = "RPU"
	Else 
	
		lRow = idwlstinter.Find ( "COD_INTER='A'", 1, idwlstinter.RowCount() )
		If lRow > 0 Then
			sAdrMail = idwlstinter.GetItemString (lRow, "ADR_MAIL" )
		End if
		
		If IsNull ( sAdrMail ) Or Len ( Trim ( sAdrMail )) = 0 Then
			// Mail null
			stMessage.sTitre		= "Relais Pick Up !! => Absence de mail"
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= YESNO!
			stMessage.sCode		= "COMD852"
			
			If f_Message ( stMessage ) = 1 Then
				ibDecocherPresta = True
				Return sRet
			End If
			
		Else
			// Mail présent, cas eligible au process Relai PickUp
			stMessage.sTitre		= "Relais Pick Up !! => Adresse mail valide ?"
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= YESNO!
			stMessage.sCode		= "COMD853"
			stMessage.sVar[1]		= sAdrMail
			
			If f_Message ( stMessage ) = 2 Then
				ibDecocherPresta = True
				Return sRet
			End If

		End If
		
		// Relai Pick up ?
		If Len ( Trim ( sAdrMail )) > 0 Then
			stMessage.sTitre		= "Relais Pick Up ?"
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= YESNO!
			stMessage.sCode		= "COMD854"

			bRelaiPickUp = f_Message ( stMessage ) = 1 
			
		End If
	End IF
	// /[PM234-4_V1]



	// [ICI_APPEL_WS_BTQ_REL_PICK_UP]
	If bRelaiPickUp Then

		// [DT290]
		If sIdFour = "O2M" Then
			F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 314 )
			For lCptDetPro = lDeb To lFin
			
				sVal = idw_DetPro.GetItemString ( lCptDetPro, "VAL_CAR" ) 
				
				If Pos ( isModlPortAdh, sVal ) > 0 Then
					stMessage.sTitre		= "projet DT290 => Swap Direct !"
					stMessage.Icon			= Exclamation!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= Ok!
					stMessage.sCode		= "COMD952 "	
					f_Message ( stMessage ) 
					
					bDT290 = TRUE
				End If
			Next
		End If 

		// Init à laisser.
		isAdrCivPickUp	  = "" 
		isAdrNomPickUp   = ""
		isAdrPreNomPickUp = ""
		isAdr1PickUp     = ""
		isAdr2PickUp     = ""
		isAdrCpltPickUp  = ""
		isAdrCpPickUp    = ""
		isAdrVillePickUp = ""
		isCodePickUp 	  = ""

		// [PM234-4_V1]
		If Not bDeclaWebAtlas Then
			relai_chrono.nomassure=idwcmde.GetItemString(1,"ADR_NOM")
			relai_chrono.prenomassure=idwcmde.GetItemString(1,"ADR_PRENOM")
			relai_chrono.adresse1=idwcmde.GetItemString(1,"ADR_LIVR1")
			relai_chrono.adresse2=idwcmde.GetItemString(1,"ADR_LIVR2")
			relai_chrono.adresse3=idwcmde.GetItemString(1,"ADR_LIVR_CPL")
			relai_chrono.codepostal =idwcmde.GetItemString(1,"ADR_CP")
			relai_chrono.ville =idwcmde.GetItemString(1,"ADR_VILLE")
			
			OpenWithParm(w_sp_trt_saisie_relai_pickup, relai_chrono)
			
			relai_chrono=Message.Powerobjectparm
		End If 

		// [PM234-4_V1]
		If relai_chrono.returncode="[RETOUR]" And Not bDeclaWebAtlas Then
			ibDecocherPresta = True
			Return sRet
		Else
			// [PM234-4_V1]
			If bDeclaWebAtlas Then
				// Inter L
				lRow = idwLstInter.Find ( "COD_INTER = 'L'", 1, idwLstInter.RowCount ())
				If lRow > 0 Then

					isAdrCivPickUp	 = "5" // Toujours en dur
					isAdrNomPickUp   = idwLstInter.GetItemString ( lRow, "NOM" )
					isAdrPreNomPickUp = String ( lIdSin ) + " " + sNom // A laisser
					isAdr1PickUp     = idwLstInter.GetItemString ( lRow, "ADR_1" )
					isAdr2PickUp     = idwLstInter.GetItemString ( lRow, "ADR_2" )
					isAdrCpltPickUp  = idwLstInter.GetItemString ( lRow, "ADR_ATT" )
					isAdrCpPickUp    = idwLstInter.GetItemString ( lRow, "ADR_CP" )
					isAdrVillePickUp = idwLstInter.GetItemString ( lRow, "ADR_VILLE" )					
				
					// Le code 
					lRow = idwWDivsin.Find ( "NOM_ZONE = 'code_livraison_atlas'", 1, idwWDivSin.RowCount () )
					If lRow > 0 Then 
						isCodePickUp = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
						// WS PickUp (isHorairePickUp)
						uoWsCaller=CREATE n_cst_sp_ws_chronopost_caller
						relai_chrono.pointrelais=CREATE chrono_pointchr
						uoWsCaller.uf_get_pointrelai ( isCodePickUp, relai_chrono.pointrelais )
						destroy uoWsCaller
					End IF

				End If
			Else
			
				// Hors Atlas (normal)
				// Valeur test qu'il faudra ensuite renseigner avec les retours 
				// Armement pour les ZVAR du courrier
				isAdrCivPickUp	 = "5" // Toujours en dur
				isAdrNomPickUp   = relai_chrono.pointrelais.nom
				isAdrPreNomPickUp = String ( lIdSin ) + " " + sNom // A laisser
				isAdr1PickUp     = relai_chrono.pointrelais.adresse1
				isAdr2PickUp     = relai_chrono.pointrelais.adresse2
				isAdrCpltPickUp  = relai_chrono.pointrelais.adresse3
				isAdrCpPickUp    = relai_chrono.pointrelais.codepostal
				isAdrVillePickUp = relai_chrono.pointrelais.localite
		
				// Le code 
				isCodePickUp     = relai_chrono.pointrelais.identifiant
			End If			
			
			gsAdrCivPickUp = isAdrCivPickUp
			gsAdrNomPickUp = isAdrNomPickUp
			gsAdrPreNomPickUp = isAdrPreNomPickUp 
			gsAdr1PickUp = isAdr1PickUp 
			gsAdr2PickUp = isAdr2PickUp  
			gsAdrCpltPickUp = isAdrCpltPickUp 
			gsAdrVillePickUp = isAdrVillePickUp 
			gsAdrCpPickUp = isAdrCpPickUp 
			gsCodePickUp = isCodePickUp 
			
			If Not bDeclaWebAtlas Or ( Not IsNull ( isCodePickUp ) And Len ( Trim ( isCodePickUp ) ) > 0 ) Then
				If not isnull(relai_chrono.pointrelais) Then
					gsHorairePickUp = relai_chrono.pointrelais.uf_get_horaires_semaine ()
				End if
			End If
			
			If IsNull ( gsHorairePickUp ) or Trim(gsHorairePickUp) = "" Then gsHorairePickUp = "(Horaires non précisés)"
			
			
		End if		 // Fin retour		
	
		idwCmde.SetItem ( 1, "ADR_COD_CIV"		, isAdrCivPickUp )
		idwCmde.SetItem ( 1, "ADR_NOM"			, isAdrNomPickUp )
		idwCmde.SetItem ( 1, "ADR_PRENOM"		, isAdrPreNomPickUp )
		idwCmde.SetItem ( 1, "ADR_LIVR1"			, isAdr1PickUp ) 
		idwCmde.SetItem ( 1, "ADR_LIVR2"			, isAdr2PickUp ) 
		idwCmde.SetItem ( 1, "ADR_LIVR_CPL"		, isAdrCpltPickUp )
		idwCmde.SetItem ( 1, "ADR_CP"				, isAdrCpPickUp)
		idwCmde.SetItem ( 1, "ADR_VILLE"			, isAdrVillePickUp )	
		
		lnvPFCString.of_setkeyvalue( isInfoSpbFrnCpltTempo, "CODE_PICK_UP", isCodePickUp, ";")			
		lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_PICK_UP", isCodePickUp, ";")					
		
		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "COMD855"	
		
		f_Message ( stMessage ) 
	End If
	// :[ICI_APPEL_WS_BTQ_REL_PICK_UP]
	// :[PM255]
	
	// [DT081_EVOL_PRET_BRIS]
	If bPretStandard And isTypApp = "TEL" Then

		// [PM234-4_V1]
		If bDeclaWebAtlas Then
			bEntreDeGamme = sTypAppPretAtlas = "ENG"
			bSmartPhone = sTypAppPretAtlas = "SPH"
			bIphone = sTypAppPretAtlas = "IPH"
			
			// [VDOC17204]
			bIphone5 = sTypAppPretAtlas = "IP5" // [VDOC17204]
		Else
		
			// [VDOC17204]
			bTrouveTypPret = False
			stMessage.sTitre		= "Commandes"
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= YESNO!
			stMessage.sCode		= "COMD905"
			
			bEntreDeGamme = f_Message ( stMessage ) = 1
			bTrouveTypPret = bEntreDeGamme
			
			If Not bTrouveTypPret Then

				stMessage.sTitre		= "Commandes"
				stMessage.Icon			= Question!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= YESNO!
				stMessage.sCode		= "COMD906"
				
				bSmartPhone = f_Message ( stMessage ) = 1
				bTrouveTypPret = bSmartPhone 
			End If

			If Not bTrouveTypPret Then

				stMessage.sTitre		= "Commandes"
				stMessage.Icon			= Question!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= YESNO!
				stMessage.sCode		= "COMD907"
				
				bIphone = f_Message ( stMessage ) = 1
				bTrouveTypPret = bIphone 
			
			End If
	
			If Not bTrouveTypPret Then
				bIphone5 = True
			End If			
			// /[VDOC17204]
			
		
		End If
		
		If bEntreDeGamme Then sVal = "ENTREE_GAM"
		If bSmartPhone Then sVal = "SMARTPHONE"
		If bIphone Then sVal = "IPHONE"
		If bIphone5 Then sVal = "IPHONE5" // [VDOC17204]

		lnvPFCString.of_setkeyvalue( isInfoSpbFrnCpltTempo, "TYP_APP_PRET", sVal, ";")			
		
	End If	
	
End If

If asAction = "C" And lProcessOrig <= 0 And sChoixOOP = "" Then
	stMessage.sTitre		= "Commandes"
	stMessage.Icon			= Question!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= YESNO!
	stMessage.sCode		= "COMD999"  // DT398


	// [PM234-4_V1]
	If bDeclaWebAtlas Then
		bRelaiPickUp = sTypLivrAtlas = "RPU"
	Else 
		
		// [ITSM485869]
		If idwArticle.GetItemString ( alRow, "ID_FOUR" ) = "DME" Then
			bRelaiPickUp = False
		Else
			bRelaiPickUp = f_Message ( stMessage ) = 1 
		End If
	End If
	// [PM234-4_V1]		

	// [PM234-4_V1]		
	If bRelaiPickUp And Not bDeclaWebAtlas Then
		lRow = idwlstinter.Find ( "COD_INTER='A'", 1, idwlstinter.RowCount() )
		If lRow > 0 Then
			sAdrMail = idwlstinter.GetItemString (lRow, "ADR_MAIL" )
		End if
		
		If IsNull ( sAdrMail ) Or Len ( Trim ( sAdrMail )) = 0 Then
			// Mail null
			stMessage.sTitre		= "Relais Pick Up !! => Absence de mail"
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= YESNO!
			stMessage.sCode		= "COMD852"
			
			If f_Message ( stMessage ) = 1 Then
				ibDecocherPresta = True
				Return sRet
			Else 
				bRelaiPickUp = False
			End If
			
		Else
			// Mail présent, cas eligible au process Relai PickUp
			stMessage.sTitre		= "Relais Pick Up !! => Adresse mail valide ?"
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= YESNO!
			stMessage.sCode		= "COMD853"
			stMessage.sVar[1]		= sAdrMail
			
			If f_Message ( stMessage ) = 2 Then
				ibDecocherPresta = True
				Return sRet
			End If					

		End If
		
	End If			

	// [ICI_APPEL_WS_BTQ_REL_PICK_UP]
	If bRelaiPickUp Then

		// Init à laisser.
		isAdrCivPickUp	  = "" 
		isAdrNomPickUp   = ""
		isAdrPreNomPickUp = ""
		isAdr1PickUp     = ""
		isAdr2PickUp     = ""
		isAdrCpltPickUp  = ""
		isAdrCpPickUp    = ""
		isAdrVillePickUp = ""
		isCodePickUp 	  = ""


		// [PM234-4_V1]
		If Not bDeclaWebAtlas Then			
			relai_chrono.nomassure=idwcmde.GetItemString(1,"ADR_NOM")
			relai_chrono.prenomassure=idwcmde.GetItemString(1,"ADR_PRENOM")
			relai_chrono.adresse1=idwcmde.GetItemString(1,"ADR_LIVR1")
			relai_chrono.adresse2=idwcmde.GetItemString(1,"ADR_LIVR2")
			relai_chrono.adresse3=idwcmde.GetItemString(1,"ADR_LIVR_CPL")
			relai_chrono.codepostal =idwcmde.GetItemString(1,"ADR_CP")
			relai_chrono.ville =idwcmde.GetItemString(1,"ADR_VILLE")
			
			OpenWithParm(w_sp_trt_saisie_relai_pickup, relai_chrono)
			
			relai_chrono=Message.Powerobjectparm
		End If

		// [PM234-4_V1]			
		If relai_chrono.returncode="[RETOUR]" And Not bDeclaWebAtlas Then
			ibDecocherPresta = True
			Return sRet
		Else

			// [PM234-4_V1]
			If bDeclaWebAtlas Then
				// Inter L
				lRow = idwLstInter.Find ( "COD_INTER = 'L'", 1, idwLstInter.RowCount ())
				If lRow > 0 Then

					isAdrCivPickUp	 = "5" // Toujours en dur
					isAdrNomPickUp   = idwLstInter.GetItemString ( lRow, "NOM" )
					isAdrPreNomPickUp = String ( lIdSin ) + " " + sNom // A laisser
					isAdr1PickUp     = idwLstInter.GetItemString ( lRow, "ADR_1" )
					isAdr2PickUp     = idwLstInter.GetItemString ( lRow, "ADR_2" )
					isAdrCpltPickUp  = idwLstInter.GetItemString ( lRow, "ADR_ATT" )
					isAdrCpPickUp    = idwLstInter.GetItemString ( lRow, "ADR_CP" )
					isAdrVillePickUp = idwLstInter.GetItemString ( lRow, "ADR_VILLE" )					
				
					// Le code 
					lRow = idwWDivsin.Find ( "NOM_ZONE = 'code_livraison_atlas'", 1, idwWDivSin.RowCount () )
					If lRow > 0 Then 
						isCodePickUp = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) 
						// WS PickUp (isHorairePickUp)
						uoWsCaller=CREATE n_cst_sp_ws_chronopost_caller
						relai_chrono.pointrelais=CREATE chrono_pointchr
						uoWsCaller.uf_get_pointrelai ( isCodePickUp, relai_chrono.pointrelais )
						destroy uoWsCaller
					End IF

				End If
			Else
			
				// Hors Atlas (normal)				
				// Valeur test qu'il faudra ensuite renseigner avec les retours 
				isAdrCivPickUp	 = "5" // Toujours en dur
				isAdrNomPickUp   = relai_chrono.pointrelais.nom
				isAdrPreNomPickUp = String ( lIdSin ) + " " + sNom // A laisser
				isAdr1PickUp     = relai_chrono.pointrelais.adresse1
				isAdr2PickUp     = relai_chrono.pointrelais.adresse2
				isAdrCpltPickUp  = relai_chrono.pointrelais.adresse3
				isAdrCpPickUp    = relai_chrono.pointrelais.codepostal
				isAdrVillePickUp = relai_chrono.pointrelais.localite
		
				// Le code 
				isCodePickUp     = relai_chrono.pointrelais.identifiant
			End If
			
			// Armement pour les ZVAR du courrier
			gsAdrCivPickUp = isAdrCivPickUp
			gsAdrNomPickUp = isAdrNomPickUp
			gsAdrPreNomPickUp = isAdrPreNomPickUp 
			gsAdr1PickUp = isAdr1PickUp 
			gsAdr2PickUp = isAdr2PickUp  
			gsAdrCpltPickUp = isAdrCpltPickUp 
			gsAdrVillePickUp = isAdrVillePickUp 
			gsAdrCpPickUp = isAdrCpPickUp 
			gsCodePickUp = isCodePickUp 

			If Not bDeclaWebAtlas Or ( Not IsNull ( isCodePickUp ) And Len ( Trim ( isCodePickUp ) ) > 0 ) Then
				If not isnull(relai_chrono.pointrelais) Then
					gsHorairePickUp = relai_chrono.pointrelais.uf_get_horaires_semaine ()
				End if
			End If
			
			If IsNull ( gsHorairePickUp )  or Trim(gsHorairePickup)="" Then gsHorairePickUp = "(Horaires non précisés)"
			
		End if		 // Fin retour		
	
		idwCmde.SetItem ( 1, "ADR_COD_CIV"		, isAdrCivPickUp )
		idwCmde.SetItem ( 1, "ADR_NOM"			, isAdrNomPickUp )
		idwCmde.SetItem ( 1, "ADR_PRENOM"		, isAdrPreNomPickUp )
		idwCmde.SetItem ( 1, "ADR_LIVR1"			, isAdr1PickUp ) 
		idwCmde.SetItem ( 1, "ADR_LIVR2"			, isAdr2PickUp ) 
		idwCmde.SetItem ( 1, "ADR_LIVR_CPL"		, isAdrCpltPickUp )
		idwCmde.SetItem ( 1, "ADR_CP"				, isAdrCpPickUp)
		idwCmde.SetItem ( 1, "ADR_VILLE"			, isAdrVillePickUp )	

		lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_PICK_UP", isCodePickUp, ";")					
		
		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "COMD855"	
		
		f_Message ( stMessage ) 
	End If
	// :[ICI_APPEL_WS_BTQ_REL_PICK_UP]		

	
End If


// [PM255]
// Process relai Pick Up
If bRelaiPickUp Then
	bFin = TRUE

	If asAction = "R" Then

		If Not bPretStandard  Then
		
			// [DT191]
			Choose Case sIdFour
				Case "O2M"
					ilProcessTempo = 982
					
					// [DT290]
					If bDT290 Then
						ilProcessTempo = 984
					End If 
					
				Case "PSM"
					ilProcessTempo = 2143
			
				// [DT288]
				Case "COR"
					ilProcessTempo = 982
		
					
			End Choose
			
		Else
			ilProcessTempo = 981					
			lnvPFCString.of_setkeyvalue( isInfoSpbFrnCpltTempo, "TYP_RELAI", "PRET", ";")					
		End If		

		gProcessTempoOrangeV3 = TRUE
		gProcessTempoOrangeV3Action = TRUE

	End If
	
	If asAction = "C" Then

		// [DT288-1][MODIF_CHRISTINE]
		If idwArticle.GetItemString ( alRow, "ID_FOUR" ) = "DME" Then
			lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "TYP_RELAI", "REMPL", ";")									
			bCmdeDme = True
		End If

		If Not bCmdeDme Then
			If lProcessOrig > 0 Then
	
				idwCmde.SetItem ( 1, "ADR_COD_CIV"		, stNul.str )
				idwCmde.SetItem ( 1, "ADR_NOM"			, stNul.str )
				idwCmde.SetItem ( 1, "ADR_PRENOM"		, stNul.str )
				idwCmde.SetItem ( 1, "ADR_LIVR1"			, stNul.str )
				idwCmde.SetItem ( 1, "ADR_LIVR2"			, stNul.str )
				idwCmde.SetItem ( 1, "ADR_LIVR_CPL"		, stNul.str )	
				idwCmde.SetItem ( 1, "ADR_CP"				, stNul.str )
				idwCmde.SetItem ( 1, "ADR_VILLE"			, stNul.str )				
				
				idwCmde.SetItem ( 1, "ADR_COD_CIV"		, idwCmdeSin.GetItemString ( lRowOrig, "ADR_COD_CIV" ))
				idwCmde.SetItem ( 1, "ADR_NOM"			, idwCmdeSin.GetItemString ( lRowOrig, "ADR_NOM" ))
				idwCmde.SetItem ( 1, "ADR_PRENOM"		, idwCmdeSin.GetItemString ( lRowOrig, "ADR_PRENOM" ))
				idwCmde.SetItem ( 1, "ADR_LIVR1"			, idwCmdeSin.GetItemString ( lRowOrig, "ADR_LIVR1" ))
				idwCmde.SetItem ( 1, "ADR_LIVR2"			, idwCmdeSin.GetItemString ( lRowOrig, "ADR_LIVR2" ))
				idwCmde.SetItem ( 1, "ADR_LIVR_CPL"		, idwCmdeSin.GetItemString ( lRowOrig, "ADR_LIVR_CPL" ))
				idwCmde.SetItem ( 1, "ADR_CP"				, idwCmdeSin.GetItemString ( lRowOrig, "ADR_CP" ))
				idwCmde.SetItem ( 1, "ADR_VILLE"			, idwCmdeSin.GetItemString ( lRowOrig, "ADR_VILLE" ))
	
				lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_PICK_UP", sCodePickUpOrig, ";")																
			
			End If
	
		
			// [ITSM192069]
			// [ITSM271446] 
			// [ITSM362519] plus de pret par anticipiation
			lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "TYP_RELAI", "REMPL", ";")					
	
			adw.SetITem ( alRow, "INFO_SPB_FRN", 983 )			
	
			If lProcessOrig > 0 And sChoixOOP = "" Then
				stMessage.sTitre		= "Commandes"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "COMD860"
			
				f_Message ( stMessage ) 
			End If 			
			
			// [ITSM284233]
			gsAdrCivPickUp = idwCmde.GetItemString ( 1, "ADR_COD_CIV")
			gsAdrNomPickUp =  idwCmde.GetItemString ( 1, "ADR_NOM")
			gsAdrPreNomPickUp = idwCmde.GetItemString ( 1, "ADR_PRENOM") 
			gsAdr1PickUp = idwCmde.GetItemString ( 1, "ADR_LIVR1") 
			gsAdr2PickUp = idwCmde.GetItemString ( 1, "ADR_LIVR2")   
			gsAdrCpltPickUp = idwCmde.GetItemString ( 1, "ADR_LIVR_CPL")  
			gsAdrVillePickUp = idwCmde.GetItemString ( 1, "ADR_VILLE")  
			gsAdrCpPickUp =  idwCmde.GetItemString ( 1, "ADR_CP")   
			gsCodePickUp = sCodePickUpOrig 
			// :[ITSM284233]
		End If		
	End If			
End If
// :[PM255]

// « L’assuré souhaite-t-il être livré à domicile ? » O/N 
// [DT94]
// [DT94_V3] Shunt DT94

// [DT191] 
If Not bFin And lProcessOrig <= 0 Then 

	// [PM234-4_V1]
	If bDeclaWebAtlas Then
		bBonPrePaye = sTypLivrAtlas = "BPP"
	Else
		// [DT191][MANTIS19258]
		If asAction = "C" Then
			
			// [ITSM485869]
			// Je laisse ce code qui a l'air débil mais c'est pour bien voir d'où ça vient
			If idwArticle.GetItemString ( alRow, "ID_FOUR" ) = "DME" Then
				bBonPrePaye = True   // Le cas de DME obligatoire qui existait déjà
			Else
				bBonPrePaye = True   // Plus de btq PSM depuis le DT398, donc plus de question et alternative obligatoire à true
			End If
		End If
		
		If asAction = "R" Then		
			bBonPrePaye =TRUE
		End If
	End If
	// [PM234-4_V1]
	
End If 

// Trt Bon prépayé
If bBonPrePaye Then
	bFin = TRUE
	
	// [PM234-4_V1]
	If bDeclaWebAtlas Then
		// Inter L
		lRow = idwLstInter.Find ( "COD_INTER = 'L'", 1, idwLstInter.RowCount ())
		If lRow > 0 Then
			
			// [DT191][#]
			idwCmde.SetItem ( 1, "ADR_COD_CIV"		, idwLstInter.GetItemString ( lRow, "COD_CIV" ))
			
			sVal = Trim ( idwLstInter.GetItemString ( lRow, "NOM" ))
			iLen = Len ( sVal )
			iPos = Pos ( sVal, "[#]" ) 
			If iPos > 0 Then
				idwCmde.SetItem ( 1, "ADR_NOM"			, Right ( sVal, iLen - iPos - 2 ))
				idwCmde.SetItem ( 1, "ADR_PRENOM"		, Left  ( sVal, iPos - 1))
			Else
				idwCmde.SetItem ( 1, "ADR_NOM"			, idwLstInter.GetItemString ( lRow, "NOM" ))
				idwCmde.SetItem ( 1, "ADR_PRENOM"		, idwLstInter.GetItemString ( lRow, "NOM" ))
			End If 
			
			idwCmde.SetItem ( 1, "ADR_LIVR1"			, idwLstInter.GetItemString ( lRow, "ADR_1" ))
			idwCmde.SetItem ( 1, "ADR_LIVR2"			, idwLstInter.GetItemString ( lRow, "ADR_2" ))
			idwCmde.SetItem ( 1, "ADR_LIVR_CPL"		, idwLstInter.GetItemString ( lRow, "ADR_ATT" ))
			idwCmde.SetItem ( 1, "ADR_CP"				, idwLstInter.GetItemString ( lRow, "ADR_CP" ))
			idwCmde.SetItem ( 1, "ADR_VILLE"			, idwLstInter.GetItemString ( lRow, "ADR_VILLE" ))
		End IF 
	End If 
	// /[PM234-4_V1]
	
	If asAction = "R" Then
		gProcessTempoOrangeV3 = TRUE
		gProcessTempoOrangeV3Action = TRUE

		// [DT191]
		Choose Case sIdFour
			Case "O2M"
				// [DT191][V3]
				lRow4= idwLstInter.Find ( "COD_INTER = 'A'", 1, idwLstInter.RowCount () )
				If lRow4> 0 Then
					sAdrMail= idwLstInter.GetItemString ( lRow4, "ADR_MAIL" )
					If IsNull ( sAdrMail ) OR Trim ( sAdrMail ) = "" Then
						ilProcessTempo = 1010
					Else
						ilProcessTempo = 912
					End If
				End If		
				
			Case "PSM"
				// [DT398]
				ilProcessTempo = 2110
				
				
			// [DT288]
			Case "COR"
				lRow4= idwLstInter.Find ( "COD_INTER = 'A'", 1, idwLstInter.RowCount () )
				If lRow4> 0 Then
					sAdrMail= idwLstInter.GetItemString ( lRow4, "ADR_MAIL" )
					If IsNull ( sAdrMail ) OR Trim ( sAdrMail ) = "" Then
						ilProcessTempo = 908
					Else
						ilProcessTempo = 912
					End If
				End If		
				
			End Choose
	End If
	
	// [ITSM271446]
	If asAction = "C"Then 
	
		lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "TYP_RELAI", "REMPL", ";")				

		// [RS3200]
		Choose Case sIdFour
			Case "TLS"
				adw.SetITem ( alRow, "INFO_SPB_FRN", 975 )
		End Choose 
		
		// [ITSM478042]
		if adw.GetItemNumber(alRow,"INFO_SPB_FRN") <> 975 Then 
			adw.SetITem ( alRow, "INFO_SPB_FRN", stNul.lng) // Pas de process = envoi à domicile
		End if
		// :[ITSM478042]
		
	End if
	
End If


/* domicile par défaut */
// [DT191] Ici, blinder sur "C" pour ne pas être gêné sur la répa.

If Not bFin And asAction = "C" Then 

	// [DT398] Si presta PRoxi alors à présent la commande est envoyé à Domicile (CQ)
	adw.SetITem ( alRow, "INFO_SPB_FRN", 975 )
	bBtqPSM = False

End If 


// trt Boutique
If bBtqPSM And asAction <> "R" Then
	
	bFin = TRUE

	If lProcessOrig <= 0 And sChoixOOP = "" Then
		sVar = ""
		
		// [PM234-4_V1]
		If bDeclaWebAtlas Then
			If sTypLivrAtlas <> "PXM" Then 
				bDeclaWebAtlas = False
			Else
				sVar = sCodLivrAtlas 
			End If
		End If
		// /[PM234-4_V1]		
		
		Do While ( sVar = "" or sVar = "[RETOUR]" ) And Not bDeclaWebAtlas
			
			// FPI - on passe le nb max de boutiques à sélectionner
			stPass.dctab[1]=idwWSin.GetItemNumber ( 1, "ID_SIN" )
			stPass.ltab[1]=1 														// Nb max de boutiques sélectionnables

			// [PM200_5]
			stPass.btab[1]=bMethode_BoutiquePSM_WS	
			stPass.sTab[2]=sCpAssure
			
				// [VDoc18634]
			stPass.lTab[2]=lIdEvt
			stPass.lTab[3]=lIdProd
			stPass.sTab[3]=isMarqPortAdh
			stPass.sTab[4]=isModlPortAdh
			stPass.sTab[5]=isTypapp

			OpenWithParm ( w_sp_trt_saisie_boutiques,  stPass ) 
	
			sVar = Message.StringParm
			
			If sVar = "" or sVar = "[RETOUR]" Then 
				stMessage.sTitre		= "Commandes"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "COMD787"
				F_Message ( stMessage )
			End If
		Loop 

		// parser BOUTIQUES=#...#...#
		isCodeBoutiqueRelaiPSM = lnvPFCString.of_Getkeyvalue( sVar, "BOUTIQUES", ";") 

	End If
	
	// [PC946_ORANGE_OPPRO]
	If sChoixOOP = "PSM" Then
		lRow = idwWDivsin.Find ( "NOM_ZONE = 'btq_psm'", 1, idwWDivSin.RowCount () )
		If lRow > 0 Then 
			lVal = idwWDivSin.GetItemNumber ( lRow, "VAL_NBRE" ) 
			If IsNull ( lVal ) Then lVal = 0
			isCodeBoutiqueRelaiPSM = "#"+ String ( lVal ) + "#"
		End If
	End If


	If asAction = "C" Then

		lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_BTQ_RELAI_PSM", isCodeBoutiqueRelaiPSM, ";")
		lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "RELAI_BTQ_PSM", "OUI", ";")

		// [ITSM192069]
		// [ITSM271446]
		If bPcePVRecu Or bCasBrisHorsPrs Or lProcessOrig = 973 Or bCasBrisIrreparable Or bCasHorsVol Then
			lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "TYP_RELAI", "REMPL", ";")					
		Else
			// [BUG_PRET_REMPL]
			lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "TYP_RELAI", "REMPL", ";")		
			
			// [VDOC12142] 
			If ibAltPec Then
				lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "TYP_RELAI", "REMPL", ";")										

				stMessage.sTitre		= "Commandes"
				stMessage.Icon			= Question!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "COMD829"
				F_Message ( stMessage )

			End If
		End If
		
		lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "NOM_ASS", idwWsin.GetItemString  ( 1, "NOM" ), ";")		
		lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "PRENOM_ASS", idwWsin.GetItemString  ( 1, "PRENOM" ) , ";")		
		
		adw.SetITem ( alRow, "INFO_SPB_FRN", 973 )
		
		// [ITSM312914]
		If IsNumber ( sNumPdvReel ) And Long ( sNumPdvReel ) > 0 Then 
			sVal1 = sNumPdvReel 
		Else 
			sVal1 = isCodeBoutiqueRelaiPSM
			iPos = pos ( sVal1, "#", 2 ) 
			sVal1 = Left ( sVal1, iPos )
		End If
		lCodeMag = Long ( F_REMPLACE ( sVal1, "#", "" ) )
		
		lIdProd = idwProduit.GetItemNumber ( 1, "ID_PROD" ) 
		sAdrNom = Space ( 35 ) 
		sAdr1   = Space ( 35 ) 
		sAdr2   = Space ( 35 ) 
		sAdrVille = Space ( 35 ) 
		sAdrCp = Space ( 5 ) 
		SQLCA.PS_S_BOUTIQUE_ADRESSE (lIdProd, lCodeMag, sAdrNom, sAdr1, sAdr2, sAdrVille, sAdrCP )
		
		idwCmde.SetItem ( 1, "ADR_COD_CIV"		, "5" )
		idwCmde.SetItem ( 1, "ADR_NOM"			, sAdrNom )
		idwCmde.SetItem ( 1, "ADR_PRENOM"		, String ( lIdSin ) + " " + sNom )
		idwCmde.SetItem ( 1, "ADR_LIVR1"			, sAdr1 ) 
		idwCmde.SetItem ( 1, "ADR_LIVR2"			, sAdr2 ) 
		idwCmde.SetItem ( 1, "ADR_LIVR_CPL"		, "" )
		idwCmde.SetItem ( 1, "ADR_CP"				, sAdrCP)
		idwCmde.SetItem ( 1, "ADR_VILLE"			, sAdrVille )	
		
		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "COMD783"	
		
		f_Message ( stMessage ) 
		
	End If
	
End If 


Return sRet
end function

public subroutine uf_check_boutique_psm (psm_psmdataresponse ureponse);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::uf_check_boutique_psm
//* Auteur			: F. Pinon
//* Date				: 01/12/2017
//* Libellé			: [VDoc25239]
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

int i
long dcidprod
string  sadrmail, sadrnom, sadr1, sadr2, sadrville, sadrcp, sAdrTel, sCodMag
n_cst_string nvstring

// Pas d'infos, on sort
if UpperBound(uReponse.shopInfos) = 0 Then return

For i=1 To UpperBound(uReponse.shopInfos) 
	
	sadrmail = Space (128) 
	sadrnom= Space (35)
	sadr1= Space (40)
	sadr2= Space (40)
	sadrville= Space (35)
	sadrcp= Space (5)
	sAdrTel=Space(20)
	
	uReponse.shopInfos[i].uf_transforme_en_boutique_simpa2()
	
	sCodMag=uReponse.shopInfos[i].shopid
	
	sCodMag=string(long(sCodMag))
	
	SQLCA.PS_S_BOUTIQUE_ADRESSE_4(idwWsin.GetItemNumber(1,"ID_PROD"), "PSM", sCodMag, sadrmail, sadrnom, sadr1, sadr2, sadrville, sadrcp, sAdrTel) 
	
	if Trim(sAdrCp) ="" Then
		
		string sVal
		
		sVal="exec sysadm.PS_I03_BOUTIQUE '" + sCodMag + "','" + uReponse.shopInfos[i].shopName + "','" +  uReponse.shopInfos[i].address1 + "','" +  uReponse.shopInfos[i].address2 + "','" +  	&	
			uReponse.shopInfos[i].zipCode + "','" +  uReponse.shopInfos[i].city + "','" + "" + "','" + uReponse.shopInfos[i].email + "','" +  stGlb.sCodOper
		// Création
		SQLCA.PS_I03_BOUTIQUE(sCodMag, uReponse.shopInfos[i].shopName, uReponse.shopInfos[i].address1, uReponse.shopInfos[i].address2, 	&	
			uReponse.shopInfos[i].zipCode, uReponse.shopInfos[i].city,"",uReponse.shopInfos[i].email, stGlb.sCodOper)
			
		f_commit(SQLCA,true)
	 Else
		if sadr1 <> uReponse.shopInfos[i].address1 or &
			sadr2 <> uReponse.shopInfos[i].address2 or &
			sadrville <> uReponse.shopInfos[i].city or &
			sadrcp <> uReponse.shopInfos[i].zipCode or &
			sadrmail <> uReponse.shopInfos[i].email or &
			sadrnom <> uReponse.shopInfos[i].shopName Then
			// Mise à jour
			SQLCA.PS_I03_BOUTIQUE(sCodMag, uReponse.shopInfos[i].shopName, uReponse.shopInfos[i].address1, uReponse.shopInfos[i].address2, 	&	
			uReponse.shopInfos[i].zipCode, uReponse.shopInfos[i].city,"",uReponse.shopInfos[i].email, stGlb.sCodOper)
			
			f_commit(SQLCA,true)
		End if
		
		
	End if
			
Next
end subroutine

private function string uf_controlergestion_aas (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_AAS (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 02/08/2018
//* Libellé			: [DT363]
//* Commentaires	: 
//*					  
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//		 	FPI	24/06/2010 [DCMP100551] Modification de l'option 76
//*-----------------------------------------------------------------

String sPos, sProbleme, sCodModeReg 
Long lInfoSpbFrn, lIdGti 
Dec {2} dcFrais //#1
Boolean bRibVide
DateTime dtCreeLe, dtDtePivotDT401
String sTypePresta
DataWindowChild dwChild 
Long lVal, lRow, lDeb, lFin
String sVal 
n_cst_string lnvPFCString



sPos = ""
lInfoSpbFrn = idwArticle.GetItemNumber ( alCpt, "INFO_SPB_FRN" ) 
sTypePresta = idwArticle.GetItemString  ( alCpt, "ID_TYP_ART" ) 
dtCreeLe = idwWsin.GetItemDateTime ( 1, "CREE_LE" ) 


/*------------------------------------------------------------------*/
/* Sinon on laisse protègé.													  */
/*------------------------------------------------------------------*/
idwCmde.Uf_Proteger ( { "COD_MODE_REG", "RIB_BQ", "RIB_GUI", "RIB_CPT", "RIB_CLE" }, "1" )

/*------------------------------------------------------------------*/
/* Message d'information pour le gestionnaire                       */
/*------------------------------------------------------------------*/
lIdGti = idwDetail.GetItemNumber ( 1, "ID_GTI" )

// [DT401]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 252 )
If lDeb > 0 Then
	sVal = lnvPFCString.of_getkeyvalue ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "DTE_PIVOT_DT401", ";")
	If IsNull ( sVal ) Then sVal = ""
End If 

If sVal <> "" Then
	dtDtePivotDT401 = DateTime ( sVal )
	If dtCreeLe >= dtDtePivotDT401 Then 
		Choose Case sTypePresta
			Case "PRS"
				sPos = "" // Ok
			Case Else 
				Choose Case lIdGti 
					Case 10, 12
						sPos = ""
						
					Case Else 		
						sPos = "D" + "RIB_BQ"		
						stMessage.sCode = "COMD983"
						F_Message ( stMessage )
						
				End Choose 
		End CHoose 
		
	Else 
		Choose Case lIdGti 
			Case 10, 12
				If isTypApp = "TEL" Then
					sPos = ""
				Else 
					sPos = "D" + "RIB_BQ"		
					stMessage.sCode = "COMD973"
					F_Message ( stMessage )
				End If
				
			Case Else 		
				// Date de MEP, gestion de l'existant.
				If Date ( dtCreeLe ) >= 2018-08-21 Then
					sPos = "D" + "RIB_BQ"		
					stMessage.sCode = "COMD973"
					F_Message ( stMessage )
				Else 
					sPos = ""
				End If
				
		End Choose 
					
	End If 
Else 
	// Ancien code que je conserve pour les tous cas Hors DT401
	Choose Case lIdGti 
		Case 10, 12
			If isTypApp = "TEL" Then
				sPos = ""
			Else 
				sPos = "D" + "RIB_BQ"		
				stMessage.sCode = "COMD973"
				F_Message ( stMessage )
			End If
			
		Case Else 		
			// Date de MEP, gestion de l'existant.
			If Date ( dtCreeLe ) >= 2018-08-21 Then
				sPos = "D" + "RIB_BQ"		
				stMessage.sCode = "COMD973"
				F_Message ( stMessage )
			Else 
				sPos = ""
			End If
			
	End Choose 
	
End IF 

Return sPos

end function

private function string uf_controlergestion_bak2 (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_BAK2 (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 02/08/2018
//* Libellé			: Controle Spécifique pour BAK2
//* Commentaires	: [DT363]
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ	PAR	Date			Modification
//       JFF   03/06/2010  [PC397/443_IPAD]
//       JFF   06/01/2016  [PC13313]
//*-----------------------------------------------------------------
String sPos, sNumPdv, sNom
String sAdrNom, sAdr1, sAdr2, sAdrVille, sAdrCp, sVal
Long   lRow, lDeb, lFin, lIdProd, lCodeMag, lIdSin, lCpt
n_cst_string lnv_string

sPos = ""

// [DT363]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 252 )		
If lDeb > 0 And isChoixAction = "C" And isTypApp = "TEL" Then
	sVal = idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ) 
	sVal = Trim ( lnv_string.of_getkeyvalue ( sVal, "ADR_MAIL_AAS", ";" ))
	If Len ( sVal ) > 0 Then 
		stMessage.sCode = "COMD975"
		stMessage.bouton = OK!
		F_Message ( stMessage )	
		sPos = "ALT_CHOIX"
		Return "G" + "ALT_CHOIX"
	End If
End If 

Return sPos

end function

private function string uf_controlergestion_ceat (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_CEAT (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 21/09/2018
//* Libellé			: Controle Spécifique pour CEAT
//* Commentaires	: 
//*					  liste -IF
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	JCA	26/12/2006	DCMP 060907 - Changement de l'appel à F_Determiner_Montant_Frais_Envoi
//*									ajout des arguments alidprod (Val), adwdetpro (Ref), adcFrais (Ref)
//		 	FPI	24/06/2010 [DCMP100551] Modification de l'option 76
//*-----------------------------------------------------------------

String sPos, sProbleme, sCodModeReg, sIdRefFour
Long lInfoSpbFrn 
Dec {2} dcFrais //#1
Boolean bRibVide
String sTypArt, sNumCmde	
Long lRow, lIdGti
String sVal, sAdresseCordon
n_cst_string lnvPFCString
Date dDtePivot  

sPos = ""

lIdGti = idwDetail.GetItemNumber ( 1, "ID_GTI" ) 

If lIdGti = 24 Then
	idwArticle.SetItem ( alCpt, "ID_REF_FOUR", "A_DESOXYDER" ) 		
End IF

Return sPos

end function

private function integer uf_zn_adrcodciv (ref datawindow adw, string asdata, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_Zn_AdrCodCiv (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 12/11/2018
//* Libellé			: Zone Cod_civ
//* Commentaires	: [PM452-1]
//*
//* Arguments		: aDw				DataWindow	Val
//*					  asData			String		Val
//*					  alRow			String		Val
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*---------------------------------------------------------------

Int					iRet

iRet = 0

If asData = "3" Then
	iRet = 1
End If

Return iRet
end function

private function string uf_controlergestion_hub (long alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::Uf_ControlerGestion_HUB (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 11/03/2024
//* Libellé			: Controle Spécifique pour HUB 
//* Commentaires	: [HP252_276_HUB_PRESTA]
//*
//* Arguments		: Long		alCpt			val
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ	PAR	Date			Modification
//*-----------------------------------------------------------------

String sPos
sPos = ""



Return sPos





end function

private function integer uf_zn_choix_regle_hub (string ascas, long alidprod, long alidsin, long alidgti, long aliddetail, integer airet, datawindow adw, ref long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::uf_zn_choix_regle_HUB (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 11/03/2024
//* Libellé			: Regle du HUB
//* Commentaires	: [HP252_276_HUB_PRESTA]
//*
//* Arguments		: String asCas
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 		 JFF  27/11/2024  [20241127082353640]
//* 		 JFF  17/01/2025  [HUB_TYP_APP_REMPL] (V01)
//*---------------------------------------------------------------

s_Pass	stPass
String   sRetHubPrestataire, sAdrMail, sVal, sVal1, sVar, sCodeVerrou, sRetHubPrestaOrig, sIdFourOrig, sLibCie
String   sTabValRet []
Integer  iRet, iRow, iTotTabValRet, iCpt, iIdSeqPrestaHubOrig
n_cst_string lnvPFCString 
Long lRow, lIdRev, lIdCie

lIdRev = idwWsin.GetItemNumber ( 1, "ID_REV" )

stPass.ltab[1] = alIdProd
stPass.ltab[2] = alIdGti
stPass.lTab[3]	= alidsin
stPass.lTab[4]	= Long ( idwCmde.GetItemString ( 1, "ADR_COD_CIV" ))

stPass.sTab[1]	= isMarqPortAdh
stPass.sTab[2]	= isModlPortAdh
stPass.sTab[3]	= isTypapp
stPass.sTab[4]	= ascas

stPass.sTab[5]	= idwCmde.GetItemString ( 1, "ADR_NOM" )
stPass.sTab[6]	= idwCmde.GetItemString ( 1, "ADR_PRENOM" )
stPass.sTab[7]	= idwCmde.GetItemString ( 1, "ADR_LIVR1" )
stPass.sTab[8] = idwCmde.GetItemString ( 1, "ADR_LIVR2" )
stPass.sTab[9] = idwCmde.GetItemString ( 1, "ADR_LIVR_CPL" )
stPass.sTab[10]= idwCmde.GetItemString ( 1, "ADR_CP" )
stPass.sTab[11]= idwCmde.GetItemString ( 1, "ADR_VILLE" )
stPass.sTab[12]= idwWsin.GetItemString  ( 1, "NOM" ) 
stPass.sTab[13]= idwWsin.GetItemString  ( 1, "PRENOM" ) 

iRow = idwLstInter.Find ( "COD_INTER = 'A'", 1, idwLstInter.RowCount () )
stPass.sTab[14] = ""
If iRow > 0 Then
	sAdrMail= idwLstInter.GetItemString ( iRow, "ADR_MAIL" )
	If Not IsNull ( sAdrMail ) And Trim ( sAdrMail ) <> "" Then
		stPass.sTab[14] = sAdrMail 
	End If
End If	

stPass.sTab[15]= "FR"  // Pays [20241127082353640]

// Pays [20241127082353640]
// [HUB_TYP_APP_REMPL]
If F_CLE_A_TRUE ( "HUB_TYP_APP_REMPL" ) Then
	lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'TYPAPP_AREC_ANEU'", 1, idwWDivSin.RowCount () ) 
	
	If lRow > 0 Then
		sVal = idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" )
		stPass.sTab[16] = sVal
	End If
Else	
	lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'TYPAPP_REC_NEU'", 1, idwWDivSin.RowCount () ) 
	
	If lRow <= 0 Then
		lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'TYPAPP_AREC_ANEU'", 1, idwWDivSin.RowCount () ) 
	End iF 
	
	If lRow > 0 Then
		sVal = idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" )
		If sVal = "AREC" Then sVal = "REC"
		If sVal = "ANEU" Then sVal = "NEU"	
		stPass.sTab[16] = sVal
	End If
End If 

// [HUB_TYP_APP_REMPL]
lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'TYPAPP_REC_NEU'", 1, idwWDivSin.RowCount () ) 
If lRow > 0 Then
	sVal = idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" )
	stPass.sTab[17] = sVal
End If	
	
stPass.sTab[18] = "" // [HUB_TYP_APP_REMPL] Chaine séria vide pour l'instant, à remplir au besoin

sLibCie = Fill ( " ", 35 ) 
SQLCA.PS_S_LIB_CIE_V01 ( alidsin, lIdRev, alIdGti, lIdCie, sLibCie )
stPass.sTab[19] = sLibCie
stPass.lTab[5 ] = lIdCie

stPass.sTab[50] = "CREATION_PRESTATION"


stPass.dcTab[1]= idwDetail.GetItemDecimal ( 1, "MT_VAL_ACHAT" ) // [20241127082353640]
stPass.dcTab[2]= idcMtPec // [20241127082353640]

stPass.dtTab[1]= idwWsin.GetItemDateTime ( 1, "DTE_ACH_PORT" ) // [20241127082353640]




Choose Case ascas
	
	Case "A_REPARER", "A_DIAGNOSTIQUER", "A_COMMANDER"
		
		stMessage.sTitre		= "Contrôle Hub Prestataire"
		stMessage.Icon			= Question!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= YESNO!
		stMessage.sCode		= "HUBP002"
		
		If F_Message ( stMessage ) = 2 Then Return 1
		
		
		OpenWithParm( w_sp_trt_saisie_hub_prestataire,  stPass ) 
		
		sRetHubPrestataire = Message.StringParm
		
		If sRetHubPrestataire = "" or sRetHubPrestataire = "[RETOUR]" Then 
			idwArticle.SetFilter ( "" ) 
			idwArticle.Filter ()
			If idwArticle.RowCount() > 0 Then idwArticle.RowsDiscard ( 1, idwArticle.RowCount(), primary! )
			alrow = -1
			Return 1
		End IF 

		sTabValRet [1] ="HP_ID_HUB_PRESTA"
		sTabValRet [2] ="HP_ID_FOUR"
		sTabValRet [3] ="HP_TYP_DOM"
		sTabValRet [4] ="HP_ID_POINT_SERV"
		sTabValRet [5] ="HP_ID_MODE_LOGIS"
		sTabValRet [6] ="CODE_PICK_UP"
		sTabValRet [7] ="NOM_PICK_UP"
		sTabValRet [8] ="REFASS_PICK_UP"
		sTabValRet [9] ="ADR1_PICK_UP"
		sTabValRet [10] ="ADR2_PICK_UP"
		sTabValRet [11] ="ADR3_PICK_UP"
		sTabValRet [12] ="ADRCP_PICK_UP"
		sTabValRet [13] ="ADRVILLE_PICK_UP"
		sTabValRet [14] ="HP_INFO_SPB_FRN"
		sTabValRet [15] ="HP_ID_PROCESS_ACHEM" 

		iTotTabValRet = UpperBound ( sTabValRet  )
		For iCpt = 1 To iTotTabValRet 
			sVal = lnvPFCString.of_Getkeyvalue( sRetHubPrestataire, sTabValRet [iCpt], ";" ) 
			If Trim ( sVal ) <> "" And Not IsNull ( sVal ) Then
				lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, sTabValRet [iCpt], sVal, ";")
			End IF 
		Next 		

		sVal = lnvPFCString.of_Getkeyvalue( sRetHubPrestataire, "CODE_PICK_UP", ";" )
		If Trim ( sVal ) <> "" Then
			idwCmde.Uf_Proteger ( { "ADR_COD_CIV", "ADR_NOM", "ADR_PRENOM", "ADR_LIVR1", "ADR_LIVR2", "ADR_LIVR_CPL", "ADR_CP", "ADR_VILLE" }, "1" )	
			ibModifAdrInterdite = True
		End If 
		
		sVal = lnvPFCString.of_Getkeyvalue( sRetHubPrestataire, "HP_INFO_SPB_FRN", ";" )
		adw.SetItem ( alRow, "INFO_SPB_FRN", Long ( sVal ))


	Case "CODE_VERROU"

		iRow = idwCmdeSin.Find( "POS ( INFO_SPB_FRN_CPLT, 'HP_ID_HUB_PRESTA') > 0 AND COD_ETAT NOT IN ( 'ANN', 'RFO', 'RPC') AND STATUS_GC = 232",1,idwCmdeSin.RowCount())

		If iRow  > 0 Then
	
			sVal = idwCmdeSin.GetItemString ( iRow, "INFO_SPB_FRN_CPLT" )
	
			sVal1 = lnvPFCString.of_Getkeyvalue( sVal, "HP_ID_HUB_PRESTA", ";") // ID_HUB_PRESTA de la presta d'origine
			lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "HP_ID_HUB_PRESTA", sVal1, ";")
	
			sVal1 = lnvPFCString.of_Getkeyvalue( sVal, "HP_ID_FOUR", ";") // ID_FOUR de la presta d'origine
			lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "HP_ID_FOUR", sVal1, ";")
	
			lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "HP_INFO_SPB_FRN", "990", ";")		
			adw.SetItem ( alRow, "INFO_SPB_FRN", 990 )
	
			sVar = "[RETOUR]"
	
			Do While sVar = "[RETOUR]"
				OpenWithParm( w_sp_trt_saisie_codeverrou,  "HUB" ) 
				sVar = Message.StringParm
				
				If sVar = "[RETOUR]" Then
					stMessage.sTitre  	= "Controle de zone"
					stMessage.Icon			= Information!
					stMessage.bErreurG	= FALSE
					stMessage.bouton 		= Ok!
					stMessage.sCode 		= "COMD744"
					f_message(stMessage)					
				End If
				
			Loop 
		
			// parser CODE_VERROU=
			sCodeVerrou = lnvPFCString.of_Getkeyvalue( sVar, "CODE_VERROU", ";") 
			lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "CODE_VERROU", sCodeVerrou, ";")
		Else
			stMessage.sTitre  	= "Absence de cas"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.bouton 		= Ok!
			stMessage.sCode 		= "COMT002"
			f_message(stMessage)					
		End If 

		
	Case "PEC_A_RECYCLER", "REFUSE_A_REEXP", "A_REPARER_FORCE", "A_DIAG_FORCE"
		
		sRetHubPrestaOrig = Space ( 20 ) 
		sIdFourOrig = Space ( 3 ) 
		SQLCA.PS_HP276_S_S2_RECUPERER_ID_SEQ_ORIG ( alIdsin, iIdSeqPrestaHubOrig, sRetHubPrestaOrig, sIdFourOrig )

		
		If sRetHubPrestaOrig = "" Or sIdFourOrig = "" Then

			stMessage.sTitre  	= "Récup. Données Presta. Orig"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.bouton 		= Ok!
			stMessage.sCode 		= "COMT003"
			f_message(stMessage)					
			
			idwArticle.SetFilter ( "" ) 
			idwArticle.Filter ()
			If idwArticle.RowCount() > 0 Then idwArticle.RowsDiscard ( 1, idwArticle.RowCount(), primary! )
			alrow = -1
			Return 1
			
		Else 		

			lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "HP_ID_HUB_PRESTA", sRetHubPrestaOrig, ";")
			lnvPFCString.of_setkeyvalue( isInfoSpbFrnCplt, "HP_ID_FOUR", sIdFourOrig, ";")			
		
		End If 
		
	Case ELSE


End Choose 

Return aiRet
end function

on n_cst_w_commande3.create
call super::create
end on

on n_cst_w_commande3.destroy
call super::destroy
end on

event destructor;call super::destructor;// FPI	25/07/2024 [MIG_PB2022] - SoapConnection Obsolète
// If  isValid (isoapcnx) Then DESTROY isoapcnx
end event

