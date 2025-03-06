$PBExportHeader$u_gs_sp_sinistre_wdetail.sru
$PBExportComments$---} User Object pour la gestion des détails. (W_DETAIL)
forward
global type u_gs_sp_sinistre_wdetail from u_gs_sp_sinistre_anc
end type
end forward

global type u_gs_sp_sinistre_wdetail from u_gs_sp_sinistre_anc
event ue_mt_prej ( )
end type
global u_gs_sp_sinistre_wdetail u_gs_sp_sinistre_wdetail

type variables
Private :
	u_DataWindow		idw_wDetailFF
	u_DataWindow		idw_wGarSin
	u_DataWindow		idw_wDivSin

	u_DataWindow_Detail	idw_LstInter
	u_DataWindow_Detail	idw_LstGarSin
	u_DataWindow_Detail	idw_LstDetail
	u_DataWindow_Detail	idw_LstCmdeSin
	u_DataWindow_Detail	idw_LstCmdeGti
	u_DataWindow_Detail	idw_LstCmdeDet
	u_DataWindow_Detail	idw_wDivDetGti			
	u_DataWindow_Detail	idw_wDivDet			

	DataWindow		idw_CodeGarantie
	DataWindow		idw_CodeCondition
	DataWindow		idw_Piece
	DataWindow		idw_Motif
	DataWindow		idw_Franchise
	DataWindow		idw_Plafond
	DataWindow		idw_Delai
	DataWindow		idw_Garantie
	DataWindow		idw_Condition
	DataWindow		idw_ParaProd
	DataWindow		idw_wParaInfo
	DataWindow		idw_wPPlafond_Detail

	DataWindow		idw_wPiece_Detail
	DataWindow		idw_wRefus_Detail
	DataWindow		idw_wPlaf_Detail
	DataWindow		idw_wDetailSupp
	DataWindow		idw_InfoCmde
	DataWindow		idw_ChoixAction
	DataWindow		idwStkIfr, idwCodEquiv 
	DataWindow		idwStkCodicDarty
	DataWindow		idwAutorisation
	DataWindow		idwDivPDet
	DataWindow		idddw_CodeCar_wDivDet_Charg_Tempo, idddw_Code_wDivDet_Charg_Tempo
	DataWindow		idwDetailSin // [CONFO][NV_PROCESS]


	U_Tagger		iuoTagPiece
	U_Tagger		iuoTagRefus

	Decimal {2}		idcMtPlafInitial
	
	String			isAltBlocInitial
	String			isReferentiel
	String 			islCodeRefPlafNum // [BLCODE]
    	
	Long			ilCodTel
	Long			ilRetGamme
	
	Boolean			ibAltCmde
	Boolean			ibMtValAchatSaisie
	Boolean			ibInsert // [DCMP070056]
	Boolean			ibPlafRef // [PLAF_REF]
	Boolean			ibPlafNumeraire // [PLAF_REF]
	Boolean 			ibCtlValAchat
	Boolean			ibIdEvtInterditCreation // [DT424]
	
	CommandButton		icbTarif
	CommandButton		icbCommander
	CommandButton		icbValAchDef

	// JFF   04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
	StaticText			istPec, istLabPec
	
	//	Constantes pour définir les options
	constant integer K_DP85_GESTIONPGC = 85 // [DCMP070284] : Option 85 : Gestion Prise en charge garantie constructeur

Public :
	Boolean			ibCochageCCConfoEncours // [CONFO][CUISINE][PC680]
	Boolean			ibDeCochageCCConfoEncours // [CONFO][CUISINE][PC680]	
	Boolean			ibCocheALentreeCCConfo // [CONFO][CUISINE][PC680]		
end variables

forward prototypes
public subroutine uf_traitement (integer aitype, ref s_pass astpass)
private subroutine uf_initialiserfenetre ()
private subroutine uf_tb_validation ()
private subroutine uf_preparerinserer (ref s_pass astpass)
private subroutine uf_zn_altbloc ()
private subroutine uf_preparermodifier (ref s_pass astpass)
private subroutine uf_gestionutagger_piece (integer aitype)
private subroutine uf_gestionutagger_refus (integer aitype)
private subroutine uf_changerproduit ()
private subroutine uf_preparervalider (ref s_pass astpass)
private subroutine uf_preparervalider_piece (ref s_pass astpass)
private subroutine uf_preparervalider_refus (ref s_pass astpass)
private subroutine uf_gestiongarantie ()
private subroutine uf_tb_detail ()
private subroutine uf_tb_AltReg ()
private subroutine uf_zn_libdet ()
private subroutine uf_controlersaisie (ref s_pass astpass)
private subroutine uf_controlergestion (ref s_pass astpass)
private function boolean uf_rf_ecrirerefus (long alrefus)
private function boolean uf_rf_614 ()
private function boolean uf_gestionrefus ()
private function boolean uf_rf_632 ()
private subroutine uf_cast_dtedet ()
private subroutine uf_zn_idevt ()
public subroutine uf_zn_trt_focus (ref s_pass astpass)
private function boolean uf_rf_633 ()
private function boolean uf_rf_634 ()
private function boolean uf_rf_631 ()
private function boolean uf_rf_680 ()
private function boolean uf_rf_650 ()
private function boolean uf_rf_660 ()
private function string uf_determiner_etat (integer aitype)
private subroutine uf_fran_fixe ()
private function string uf_controlersaisie_si_reglement ()
private subroutine uf_recalcul_autre_detail ()
private subroutine uf_preparersupprimer (ref s_pass astpass)
private function string uf_plaf_adherent_renouvellement ()
private function string uf_plaf_adherent_survenance ()
private function string uf_plaf_adhesion_renouvellement ()
private function string uf_plaf_adhesion_survenance ()
private function string uf_calcul_montantregle ()
private subroutine uf_calculer_dt_1er_uf ()
private function boolean uf_rf_625 ()
private function boolean uf_rf_622 ()
private subroutine uf_gestion_str2nul ()
private subroutine uf_gestion_plafond (integer aitype)
private subroutine uf_preparervalider_plafond (ref s_pass astpass)
private function boolean uf_rf_635 ()
private subroutine uf_plaf_ecrirepara (string asidtypplaf, string asidpara, string ascptver)
private function boolean uf_rf_626 ()
private subroutine uf_gestion_commandes ()
private function integer uf_preparervalider_commande ()
public subroutine uf_bt_annuler_commande ()
public function integer uf_bt_commander ()
private subroutine uf_rendre_visible_idireg (integer aichoix)
public subroutine uf_majvargamme (long alRetGamme)
private subroutine uf_controlergestion_si_val_achat (ref string aspos)
public function decimal uf_maxttc_mobilechoisi ()
private subroutine uf_calcul_montantregle_gti_gmp (decimal adcmtprej)
private function string uf_plaf_adhesion_annee_civile ()
private function string uf_plaf_adherent_annee_civile ()
public function integer uf_bt_valachatdefaut ()
public function boolean uf_getautorisation (long alidDroit)
private subroutine uf_set_profilfacturation ()
private function integer uf_get_fournisseur_aregler ()
private function integer uf_copierligne_inf2sup (string asswitch, long alligdwnivinf, string ascle, ref u_datawindow_detail adwsup, ref u_datawindow_detail adwinf)
private function integer uf_copierligne_sup2inf (boolean abdwnivinfreset, ref u_datawindow_detail adwsup, ref u_datawindow_detail adwinf)
private subroutine uf_gestion_detaildivers ()
public subroutine uf_initialiser_dw_desc (ref u_datawindow_detail adw_lstgarsin, ref u_datawindow_detail adw_lstinter, ref u_datawindow_detail adw_lstdetail, ref u_datawindow_detail adw_lstcmdegti, ref u_datawindow_detail adw_lstcmdesin, ref u_datawindow adw_wdivsin, ref u_datawindow_detail adw_wdivdetsin, ref u_datawindow_detail adw_wdivdet, ref u_datawindow adw_wdetailff, ref u_datawindow adw_wgarsin, ref datawindow adw_norm[], ref u_datawindow_detail adw_udwdet[])
private subroutine uf_gestong_divers_caspart_finaux ()
public subroutine uf_gestong_divers_dddw (string asData, string asNomCol, long alRow)
private function string uf_controlergestion_ongletdivers (ref string asong)
public function string uf_gestong_divers_trouver (string asnomzone)
private function boolean uf_rf_653 ()
private function string uf_rechecherplafond_pec ()
private subroutine uf_controlergestion_pec (ref string aspos)
private function integer uf_preparervalider_ongdivers ()
private function boolean uf_rf_697 ()
private function long uf_zn_altssui ()
private function long uf_zn_altreg ()
private function long uf_zn_altatt ()
private function long uf_zn_heudet ()
private function long uf_zn_numcarte ()
private function long uf_zn_idevt_telephonie ()
private function long uf_zn_dtefacture ()
private function long uf_zn_idireg ()
private function long uf_zn_numfacture ()
private function long uf_zn_trt_divdet_vallst (string asdata, string asnomcol, long alrow)
private function long uf_zn_trt_divdet_marqapp (string asdata, string asnomcol, long alrow)
private function long uf_zn_trt_divdet_aucunemarq (string asdata, string asnomcol, long alrow)
private function long uf_zn_trt_divdet_pec (string asdata, string asnomcol, long alrow)
private function long uf_zn_trt_divdet_modlapp (string asdata, string asnomcol, long alrow)
private function long uf_zn_trt_divdet_qte (string asdata, string asnomcol, long alrow)
private function long uf_zn_dte_det_date ()
private function long uf_zn_trt_divdet_alt_pec (string asdata, string asnomcol, long alrow)
public function long uf_zn_trt (ref s_pass astpass)
public function long uf_zn_trt_divdet (string asdata, string asnomcol, long alrow, string asnomzone)
private function boolean uf_rf_654 ()
private function long uf_zn_trt_divdet_doschargespb (string asdata, string asnomcol, long alrow)
public function string uf_gestion_mediasaturn ()
private subroutine uf_controlergestion_208 (ref string aspos)
private function boolean uf_deja_une_commande ()
private function boolean uf_rf_627 ()
private subroutine uf_controlergestion_cle (ref string aspos)
private subroutine uf_gestong_divers ()
private function string uf_gestion_cond_plaf_671_675 ()
private function string uf_plaf_nbev_gti_adherent_renouvellement ()
private function string uf_plaf_nbev_gti_adherent_survenance ()
private function string uf_plaf_nbev_gti_adhesion_renouvellement ()
private function string uf_plaf_nbev_gti_adhesion_survenance ()
private function string uf_plaf_nbev_sin_adherent_renouvellement ()
private function string uf_plaf_nbev_sin_adherent_survenance ()
private function string uf_plaf_nbev_sin_adhesion_renouvellement ()
private function string uf_plaf_nbev_sin_adhesion_survenance ()
private function long uf_zn_codmotssui ()
public function boolean uf_controlergestion_donnee_pgc (long alidgti, long alidevt, ref string aspos, ref string astext)
private function boolean uf_rf_636 ()
private function boolean uf_rf_637 ()
public subroutine uf_gestong_divers_majzone (string asnomzone, long alrow, any aavalue)
public subroutine uf_initialiser_objets (ref u_tagger aupiece, ref u_tagger aurefus, ref commandbutton acbtarif, ref commandbutton acbcommander, ref commandbutton acbvalachdef, ref statictext astpec, ref statictext astlabpec)
private function long uf_zn_trt_divdet_mtpec (string asdata, string asnomcol, long alrow)
private function long uf_zn_trt_divdet_accordrempl (string asdata, string asnomcol, long alrow)
private subroutine uf_controlergestion_factuetaccordrempl (ref string aspos)
private subroutine uf_controlergestion_o2m (ref string aspos)
private function boolean uf_rf_698 ()
private function long uf_zn_mtvalpublique ()
private function long uf_zn_trt_divdet_accordrempl2 (string asdata, string asnomcol, long alrow)
private function long uf_zn_trt_divdet_rejetzone_droit (string asdata, string asnomcol, long alrow, long aldroit)
private function long uf_zn_trt_divdet_fncnumfact (string asdata, string asnomcol, long alrow)
private function long uf_zn_trt_divdet_fncdteticket (string asdata, string asnomcol, long alrow)
private function long uf_zn_mtvalachat (string asval)
private subroutine uf_gestion_mtvalachat ()
private function boolean uf_rf_629 ()
private function boolean uf_rf_655 ()
private function boolean uf_rf_651 ()
public function boolean uf_controlergestion_o2m_apprecuprecycl ()
private function boolean uf_rf_644 ()
public function boolean uf_garantierevision ()
private function long uf_zn_trt_divdet_numprs (string asdata, string asnomcol, long alrow)
private function boolean uf_rf_1438 ()
private function long uf_zn_trt_divdet_adr_imm_etg (string asdata, string asnomcol, long alrow)
private function long uf_zn_trt_divdet_vetuste (string asdata, string asnomcol, long alrow)
private function integer uf_zn_mtprej ()
private function decimal uf_calcul_montantvetuste (string ascas, decimal adcmtvalpivot, integer aidurgtigc, date addteachat, date addtesurv)
private function long uf_zn_trt_divdet_calculvetuste (string asdata, string asnomcol, long alrow)
private function string uf_plaf_evt ()
private function string uf_plaf_sin ()
private function string uf_plaf_sin_carte ()
private subroutine uf_controlergestion_altregparam (ref string aspos)
private function long uf_zn_trt_divdet_collerinfo (string asdata, string asnomcol, long alrow)
public function boolean uf_rf_601 ()
public function boolean uf_rf_603 ()
private function string uf_plaf_nbev_gti_adhesion ()
private function long uf_zn_trt_divdet_code_article (string asdata, string asnomcol, long alrow)
private function long uf_zn_trt_divdet_lib_article (string asdata, string asnomcol, long alrow)
private function long uf_zn_trt_divdet_dte_fin_gti_article (string asdata, string asnomcol, long alrow)
private function long uf_zn_trt_divdet_code_rgpr_element (string asdata, string asnomcol, long alrow)
private function string uf_plaf_nbcodergpt_distinct_gti_adhesion ()
private function long uf_zn_trt_divdet_taillearticle (string asdata, string asnomcol, long alrow)
public function string uf_gestion_dartynomade (decimal adcmtvalachat, string aschoixaction)
private function string uf_plaf_refus (string astypplaf, string ascas)
private function long uf_zn_trt_divdet_enlvbien (string asdata, string asnomcol, long alrow)
private function boolean uf_rf_1590 ()
private function boolean uf_rf_1599 ()
private function boolean uf_rf_1604 ()
private function boolean uf_rf_1605 ()
private function boolean uf_rf_1678 ()
public function boolean uf_rf_1694 ()
protected function string uf_plaf_adhesion_annee_civile_val_achat ()
private function string uf_plaf_adherent_annee_civile_val_achat ()
public function boolean uf_controler_sanction_eco ()
protected function string uf_plaf_evt1397_regle_resil_adh ()
private function string uf_plaf_nbev_gti_adhesion_renou_dte_surv ()
private function boolean uf_rf_1802 ()
private subroutine uf_gestion_mtvalpublique ()
private function string uf_plaf_adhesion_annee_civile_tt_gti ()
private function boolean uf_rf_97 ()
private function boolean uf_rf_dp307 ()
private function long uf_zn_trt_divdet_souplesse (string asdata, string asnomcol, long alrow)
private function string uf_plaf_adhesion_renouv_typepers ()
private function long uf_zn_trt_divdet_refusscb (string asdata, string asnomcol, long alrow)
private subroutine uf_controlergestion_franchise_cb_extr (ref string aspos)
public function string uf_plaf_adhesion_survenance_ttegti ()
public function string uf_plaf_adhesion_survenance_gtidp351 ()
private subroutine uf_gestion_dtedet ()
public function boolean uf_rf_dp370_val_div_det ()
public function string uf_epurezone (string asvaleur)
public subroutine uf_gestong_divers_caspart_liste (string asnomzone, long alidprod, long alidrev, long alidgti)
public subroutine uf_affichage_dw_choix_action (integer alidevt)
private function decimal uf_calcul_montantvetuste_2 (string ascas, decimal adcmtvalpivot, integer aidurgtigc, date addteachat, date addtesurv)
end prototypes

event ue_mt_prej();//*-----------------------------------------------------------------
//*
//* Evt           : ue_mt_prej
//* Auteur			: Fabry JF
//* Date				: 15/12/2011
//* Libellé			: [VDOC6122]
//* Commentaires	: Contrôle de gestion d'un détail
//*
//* Arguments		: 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------


Long lDeb, lFin
Decimal {2} dcMtValAchat, dcMtValPublique, dcMtPrej

// [PC301][VESTUSTE][VDOC6122]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 152)
dcMtValAchat = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" ) 
dcMtValPublique = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_PUBLIQUE" ) 
dcMtPrej = idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" ) 
If This.uf_GetAutorisation ( 208 ) And lDeb > 0 And dcMtValPublique <= 0 And dcMtValAchat> 0 And dcMtPrej > 0 Then
	This.Uf_Zn_MtPrej ()
	This.uf_Rendre_Visible_IdiReg ( 0 )
End If 


end event

public subroutine uf_traitement (integer aitype, ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Traitement (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:29:33
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: Integer		aiType			(Val)	Type de traitement
//*					  s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Choose Case aiType
Case 1					// INITIALISATION		(Ue_Initialiser de la fenêtre)
	Uf_InitialiserFenetre ()

Case 2					// MODIFICATION		(Wf_PreparerModifier)
	Uf_PreparerModifier ( astPass )

Case 3					// INSERTION			(Wf_PreparerInserer)
	Uf_PreparerInserer ( astPass )

Case 4					// CONTROLE SAISIE	(Wf_ControlerSaisie) + (Wf_ControlerGestion)
	Uf_ControlerSaisie 	( astPass )
	If	astPass.sTab [ 1 ] = "" Then
		astPass.lTab [ 1 ] = 0
		Uf_ControlerGestion ( astPass )
	End If

Case 6					// PREPARER VALIDER	(Wf_PreparerValider)
	Uf_PreparerValider ( astPass )

Case 9					// CAS PARTICULIER	(Appel sur l'événement Ue_Banque)

Case 10					// SUPPRESSION			(Wf_PreparerSupprimer)
	Uf_PreparerSupprimer ( astPass )

End Choose



end subroutine

private subroutine uf_initialiserfenetre ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_InitialiserFenetre (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Initialisation de la fenêtre (FREEFORM) d'un détail
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1    JFF    28/01/2008  [DCMP080028]
//*-----------------------------------------------------------------

DataWindowChild		dwChild, dwChild1
String sTri

String sCol[] 

/*------------------------------------------------------------------*/
/* On récupére les DDDW qui ne changent jamais.                     */
/* Colonnes COD_MOT_SSUI, COD_DEC_MAC, COD_DEC_OPE, COD_ETAT,       */
/* ID_TYP_CARTE.                                                    */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On peut faire un ShareData pour toutes les DDDW avec idw_wSin.   */
/*------------------------------------------------------------------*/
idw_wSin.GetChild ( "COD_MOT_SSUI", dwChild )
idw_wDetailFF.GetChild ( "COD_MOT_SSUI", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_wSin.GetChild ( "COD_DEC_MAC", dwChild )
idw_wDetailFF.GetChild ( "COD_DEC_MAC", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_wSin.GetChild ( "COD_DEC_OPE", dwChild )
idw_wDetailFF.GetChild ( "COD_DEC_OPE", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_wSin.GetChild ( "COD_ETAT", dwChild )
idw_wDetailFF.GetChild ( "COD_ETAT", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_wSin.GetChild ( "ID_TYPE_CARTE", dwChild )
idw_wDetailFF.GetChild ( "ID_TYPE_CARTE", dwChild1 )
dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* Le 21/04/1999. Modif. pour la couverture UF des autres cartes.   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On veut trier la zone ID_TYPE_CARTE en fonction du libellé.      */
/*------------------------------------------------------------------*/
sTri = "LIB_CODE A"
dwChild1.SetSort ( sTri )
dwChild1.Sort ()

/*------------------------------------------------------------------*/
/* On fait un ShareData pour le libellé de la garantie.             */
/*------------------------------------------------------------------*/
idw_LstGarSin.GetChild ( "ID_GTI", dwChild )
idw_wDetailFF.GetChild ( "ID_GTI", dwChild1 )
dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* On fait un ShareData pour la désignation des interlocuteurs      */
/* pour les pièces, les refus et le destinataire du réglement.      */
/*------------------------------------------------------------------*/
iuoTagPiece.dw_Trt.GetChild ( "ID_I", dwChild )
idw_LstInter.ShareData ( dwChild )

iuoTagRefus.dw_Trt.GetChild ( "ID_I", dwChild )
idw_LstInter.ShareData ( dwChild )

idw_wDetailFF.GetChild ( "ID_I_REG", dwChild )
idw_LstInter.ShareData ( dwChild )

/*------------------------------------------------------------------*/
/* On fait un ShareData pour la liste des conditions.               */
/*------------------------------------------------------------------*/
idw_wDetailFF.GetChild ( "ID_EVT", dwChild )
idw_CodeCondition.ShareData ( dwChild )

/*------------------------------------------------------------------*/
/* On s'occupe des colonnes qui peuvent changer de couleur, en      */
/* fonction de la saisie.                                           */
/*------------------------------------------------------------------*/
sCol [  1 ] = "ID_EVT"
sCol [  2 ] = "DTE_DET_DATE"
sCol [  3 ] = "HEU_DET"
sCol [  4 ] = "NUM_CARTE"
sCol [  5 ] = "LIB_DET"
sCol [  6 ] = "MT_PREJ"
sCol [  7 ] = "ID_I_REG"
sCol [  8 ] = "MT_PLAF"
sCol [  9 ] = "COD_MOT_SSUI"
sCol [ 10 ] = "ID_TYPE_CARTE"
sCol [ 11 ] = "MT_VAL_ACHAT"
sCol [ 12 ] = "DTE_FACTURE"
sCol [ 13 ] = "NUM_FACTURE"
sCol [ 14 ] = "MT_VAL_PUBLIQUE" // #1

idw_wDetailFF.Uf_InitialiserCouleur ( sCol )

/*------------------------------------------------------------------*/
/* Si on est en Consultation/Validation, on va initialiser les      */
/* zones en protect une seule fois.                                 */
/*------------------------------------------------------------------*/
If	isTypeTrt = "C" Or isTypeTrt = "V" Then
	Uf_Tb_Validation ()
End If

end subroutine

private subroutine uf_tb_validation ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Tb_Adhesion (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 17:35:30
//* Libellé			: 
//* Commentaires	: Gestion des TabOrder en consultaion/Validation.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1    JFF    28/01/2008  [DCMP080028]
//			FPI	24/08/2011	[VDoc5059]
//*-----------------------------------------------------------------

String sCol[]
Long lDeb, lFin

/*------------------------------------------------------------------*/
/* Cette fonction concerne toutes les zones.                        */
/*------------------------------------------------------------------*/
sCol [  1 ] = "ID_EVT"
sCol [  2 ] = "DTE_DET_DATE"
sCol [  3 ] = "HEU_DET"
sCol [  4 ] = "NUM_CARTE"
sCol [  5 ] = "LIB_DET"
sCol [  6 ] = "ALT_COUR"
sCol [  7 ] = "MT_PREJ"
sCol [  8 ] = "ID_I_REG"
sCol [  9 ] = "MT_PLAF"
sCol [ 10 ] = "ALT_SSUI"
sCol [ 11 ] = "COD_MOT_SSUI"
sCol [ 12 ] = "ALT_ATT"
sCol [ 13 ] = "ALT_BLOC"
sCol [ 14 ] = "ALT_REG"
sCol [ 15 ] = "ID_TYPE_CARTE"
sCol [ 16 ] = "MT_VAL_ACHAT"
sCol [ 17 ] = "DTE_FACTURE"
sCol [ 18 ] = "NUM_FACTURE"
sCol [ 19 ] = "MT_VAL_ACHAT"

idw_wDetailFF.Uf_Proteger ( sCol, "1" )
iCbValAchDef.Enabled = False

/*------------------------------------------------------------------*/
/* On positionne la gestion des pièces et des refus en mode         */
/* (C)onsultation.                                                  */
/*------------------------------------------------------------------*/
iuoTagPiece.Uf_Consulter ( True ) 
iuoTagRefus.Uf_Consulter ( True ) 

// [VDoc5059]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 178 )
If lDeb > 0 Then
	idw_wDetailFF.Modify("mt_prej_t.Text='Surconsommation'")
End if
end subroutine

private subroutine uf_preparerinserer (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerInserer (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Préparation de l'insertion d'un détail
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1 JCA	12/01/2007	DCMP 050273 - Gestion du bitmap de l'onglet pièce fait dans Uf_GestionuTagger_Piece
//* #2 JCA	04/06/2007	DCMP 070304 - Mise sans suite d'un détail de garantie sur l'option 75
//* #3 JFF  04/06/2007  [DCMP070163-070164-070248-070318] Gestion Prise en charge
//* #4 JFF  04/09/2007  [DCMP070431]
//* #5 JFF  28/01/2008  [DCMP080028]
//* #6 JFF  28/01/2008  [DCMP070921]
//* #7 JFF  26/08/2009  [GEST_VAL_ACH_ADH]
//     JFF  02/09/2019  [DT424]
//     JFF  11/09/2020  [VDOC29630]
//*-----------------------------------------------------------------

Long lIdSin, lIdGti, lTotDetail, lIdDetail, lTot, lCpt, lDeb, lFin, lCodTel, lRow, lVal
Date dDteTicket
String sIMEI
lTotDetail = 0
idw_LstCmdeDet.Reset ()

/*------------------------------------------------------------------*/
/* Modification SFR # Le 27/09/02 : initialisation de la gamme. La  */
/* valeur -1 signifie que la fenêtre des gammes n'a pas été         */
/* ouverte.                                                         */
/*------------------------------------------------------------------*/
ilRetGamme = -1
isReferentiel = astPass.sTab [1]
ibMtValAchatSaisie = FALSE
ibInsert = TRUE // [DCMP070056]
idw_wDetailFF.Uf_Proteger ( { "MT_VAL_PUBLIQUE" } , "1" ) // #5
ibPlafRef				= False // [PLAF_REF]
islCodeRefPlafNum		= "" // [PLAF_REF]
ibPlafNumeraire 		= False // [PLAF_REF]
ibCochageCCConfoEncours = False // [CONFO][CUISINE][PC680]
ibDeCochageCCConfoEncours = False // [CONFO][CUISINE][PC680]
ibIdEvtInterditCreation = False // [DT424]

// #2
stMessage.sTitre		= "Contrôle de gestion d'un détail"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE

sImei = idw_wSin.GetItemString ( 1, "NUM_IMEI_PORT" ) // #2
lCodTel = idw_Produit.GetItemNumber ( 1, "COD_TEL" ) // JFF

if IsNull ( sImei ) And isReferentiel = "IFR" And lCodTel > 0 then
	stMessage.sCode = "WDET521"
	F_Message ( stMessage )
end if
//: #2 - FIN

/*------------------------------------------------------------------*/
/* Rôle de facturation, droit -NA/208										  */
/*------------------------------------------------------------------*/
This.uf_Set_ProfilFacturation ()

/*------------------------------------------------------------------*/
/* Le produit a t-il changé ?                                       */
/*------------------------------------------------------------------*/
Uf_ChangerProduit ()

/*------------------------------------------------------------------*/
/* On récupére l'ID_SIN et l'ID_GTI.                                */
/*------------------------------------------------------------------*/
lIdSin		= idw_wGarSin.GetItemNumber ( 1, "ID_SIN" )
lIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
ilCodTel		= idw_Produit.GetItemNumber ( 1, "COD_TEL" )
ibAltCmde 	= idw_Produit.GetItemString ( 1, "ALT_CMD_MOBILE" ) = "O"

idw_wDetailFF.SetItem ( 1, "ID_SIN", lIdSin )
idw_wDetailFF.SetItem ( 1, "ID_GTI", lIdGti )

/*------------------------------------------------------------------*/
/* On incrémente le N° du détail.                                   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Le N° de détail commence à zéro.                                 */
/*------------------------------------------------------------------*/

lTotDetail = idw_wDetailFF.iudwDetailSource.RowCount ()
If	lTotDetail = 0 Then
	lIdDetail = 0
Else
	lIdDetail = idw_wDetailFF.iudwDetailSource.GetItemNumber ( lTotDetail, "ID_DETAIL" )
	lIdDetail ++
End If
idw_wDetailFF.SetItem ( 1, "ID_DETAIL", lIdDetail )

/*------------------------------------------------------------------*/
/* On gére les pieces, les refus et les plafonds en insertion.      */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* S'il n'y a pas d'interlocuteurs, on rend l'onglet inaccessible.  */
/*------------------------------------------------------------------*/
If	idw_LstInter.RowCount () = 0 Then
	iuoOng.Uf_ActiverOnglet ( "02", False )
Else
	iuoOng.Uf_ActiverOnglet ( "02", True )
	Uf_GestionuTagger_Piece ( 1 )
End If

Uf_GestionuTagger_Refus ( 1 )

Uf_Gestion_Plafond ( 1 )

Uf_GestionGarantie ()

/*------------------------------------------------------------------*/
/* Gestion des commandes.                                           */
/*------------------------------------------------------------------*/
Uf_Gestion_Commandes ()
Uf_Gestion_DetailDivers ()
Uf_GestOng_Divers ()

/*------------------------------------------------------------------*/
/* On gére les TabOrder.                                            */
/*------------------------------------------------------------------*/

idw_wDetailFF.Modify ( "mt_prej_t.Text= 'Mt Préjudice'" )	

Uf_Tb_Detail ()
/*------------------------------------------------------------------*/
/* On gére la dernière colonne.                                     */
/*------------------------------------------------------------------*/
idw_wDetailFF.ilDernCol = 14					// Zne ALT_BLOC

/*------------------------------------------------------------------*/
/* On s'occupe des variables d'instance nécessaires à la gestion    */
/* du dossier.                                                      */
/*------------------------------------------------------------------*/
idcMtPlafInitial = 0.00
isAltBlocInitial = "N"

/*------------------------------------------------------------------*/
/* On initialise le Bitmap des onglets Piéces et Refus.             */
/*------------------------------------------------------------------*/
// #1 // #iuoOng.Uf_ChangerBitmap ( "02", "" ) 
iuoOng.Uf_ChangerBitmap ( "03", "" )

If	iuoOng.Uf_RecupererOngletCourant () <> "01" Then
	iuoOng.Uf_ChangerOnglet ( "01" ) 
End If

astPass.bRetour = True

/*------------------------------------------------------------------*/
/* Le 28/11/2001.                                                   */
/* Modif DGA. DCMP 010375                                           */
/*------------------------------------------------------------------*/
If	lIdGti = 5	Then 
	iCbTarif.Visible = TRUE
Else
	iCbTarif.Visible = FALSE
End If

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/* La zone ID_I_REG est rendue Visible/Invisible en fonction de     */
/* certains critères.                                               */
/*------------------------------------------------------------------*/
This.uf_Rendre_Visible_Idireg ( 0 )

This.uf_Gestion_MtValPublique ( )

//* #7 [GEST_VAL_ACH_ADH]
This.uf_Gestion_MtValAchat ()

// [VDOC29630]
This.uf_Gestion_DteDet ()	

If Not This.uf_GetAutorisation ( 208 ) Then 
	idw_wDetailFF.SetColumn ( "MT_PREJ" )
Else 
	idw_wDetailFF.SetColumn ( "DTE_FACTURE" )
End IF

// Casto
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 43 )
If lDeb > 0 Then
	dDteTicket = Date(idw_wDivSin.GetItemDateTime ( idw_wDivSin.Find ( "NOM_ZONE = 'dte_ticket'", 1, idw_wDivSin.RowCount () ), "VAL_DTE" )	)	// [PI056].20190926
	idw_wDetailFF.SetItem ( 1, "DTE_DET_DATE", dDteTicket )
End If

// #3
istPec.Text = ""

lIdGti = idw_WdetailFF.GetItemNumber ( 1, "ID_GTI" )
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 86 )

istPec.Hide () ; istLabPec.Hide ()

If lDeb > 0 Then
	For lCpt = lDeb To lFin
		If idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) = lIdGti Then
				istPec.Visible = lDeb > 0 
				istLabPec.Visible = lDeb > 0 
			Exit
		End If 
	Next
	
End If
// :#3

// #4 Valeur par défaut
lRow = idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'ACCORD_REMPL'", 1, idw_wDivDet.RowCount () )
If lRow > 0 Then

	lVal = idw_wDivDet.GetItemNumber ( lRow, "VAL_NBRE" ) 
	If IsNull ( lVal ) Or lVal = 0 Then 
		This.uf_GestOng_Divers_MajZone ( "ACCORD_REMPL", lRow, 1 )
	End If
End If

// #5 Valeur par défaut
lRow = idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'ACCORD_REMPL2'", 1, idw_wDivDet.RowCount () )
If lRow > 0 Then

	lVal = idw_wDivDet.GetItemNumber ( lRow, "VAL_NBRE" ) 
	If IsNull ( lVal ) Or lVal = 0 Then 
		This.uf_GestOng_Divers_MajZone ( "ACCORD_REMPL2", lRow, 1 )
	End If
End If

ibCtlValAchat=FALSE // [VDOC10924]

idw_wDetailFF.SetFocus ()

end subroutine

private subroutine uf_zn_altbloc ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_AltBloc (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libellé			: 
//* Commentaires	: Controle de ALT_BLOC
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On vient de bloquer le détail, on passe le COD_ETAT à 1.         */
/*------------------------------------------------------------------*/
If	idw_wDetailFF.GetText () = "O" Then
	idw_wDetailFF.SetItem ( 1, "COD_ETAT", 1 )
	idw_wDetailFF.SetItem ( 1, "COD_DEC_MAC", 1 )
	idw_wDetailFF.SetItem ( 1, "COD_DEC_OPE", 1 )

/*------------------------------------------------------------------*/
/* On positionne les montants à 0. (MT_PLAF, MT_NPLAF, MT_FRAN).    */
/*------------------------------------------------------------------*/
	idw_wDetailFF.SetItem ( 1, "MT_PLAF", 	0.00 )	
	idw_wDetailFF.SetItem ( 1, "MT_NPLAF", 0.00 )	
	idw_wDetailFF.SetItem ( 1, "MT_FRAN", 	0.00 )
	idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "N" )
Else
/*------------------------------------------------------------------*/
/* On vient de débloquer le détail, on positionne le COD_ETAT à 0   */
/* (Non controlé). Il sera armé lors du contrôle de                 */
/* gestion.(Normalement!!).                                         */
/*------------------------------------------------------------------*/
	idw_wDetailFF.SetItem ( 1, "COD_ETAT", 0 )
	idw_wDetailFF.SetItem ( 1, "COD_DEC_MAC", 0 )
	idw_wDetailFF.SetItem ( 1, "COD_DEC_OPE", 0 )
End If


end subroutine

private subroutine uf_preparermodifier (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerModifier (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Préparation de la modification d'un détail
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1 JCA	04/06/2007	DCMP 070304 - Mise sans suite d'un détail de garantie sur l'option 75
//* #2 JFF  04/06/2007  [DCMP070163-070164-070248-070318] Gestion Prise en charge
//* #3 JFF  04/09/2007  [DCMP070431]
//* #4 JFF  28/01/2008  [DCMP080028]
//* #5 JFF  05/02/2008  [DCMP070921]
//* #6 PHG	03/03/2008  [SUISSE].LOT3 Correction Afficahge PEC
//* #7 JFF  26/08/2009  [GEST_VAL_ACH_ADH]
//*    JFF  27/07/2011  [PLAF_REF]
//*    JFF  12/12/2011  [VDOC6122]
//       JFF   24/01/2012  [CONFO][CUISINE][PC680]
//       JFF   11/09/2012  [PC662][POINT7]
//       JFF   26/08/2013 [DT57_CMDE_IPHONE_SFR]
//       JFF   03/12/2013 [ITSM186204]
//       JFF   29/04/2014 [DT070]
//       JFF   02/09/2019 [DT424]
//       JFF   11/09/2020 [VDOC29630]
//*-----------------------------------------------------------------

Boolean	bSupprime, bPresenceCmdeCeg 
Long lTot, lCpt, lDeb, lFin, lCodTel, lIdGti, lIdEvt, lRow, lVal, lIdDetail 
Date dDteTicket
string sImei // #1
String sBitMap, sCas
String sMtPec // #2
Boolean bPec, bAltPec // #2
Boolean bConfo
Decimal dcMtValPublique, dcMtPrej, dcMtValAchat 
Boolean bRole208
String  sNumFact, sVal
Date dDteFact 
Integer iCodeEtat 
n_cst_string lnvPFCString
Decimal {2} dcMtMajor, dcMtCmde

bSupprime = True
ibPlafRef				= False // [PLAF_REF]
idw_LstCmdeDet.Reset ()

sBitMap = ""
ilCodTel = idw_Produit.GetItemNumber ( 1, "COD_TEL" )
ibAltCmde = idw_Produit.GetItemString ( 1, "ALT_CMD_MOBILE" ) = "O"
isReferentiel = astPass.sTab [1]
ibMtValAchatSaisie = FALSE
ibInsert = FALSE // [DCMP070056]
idw_wDetailFF.Uf_Proteger ( { "MT_VAL_PUBLIQUE" } , "1" ) // #4
ibPlafRef				= False // [PLAF_REF]
islCodeRefPlafNum		= "" // [PLAF_REF]
ibPlafNumeraire 		= False // [PLAF_REF]
ibCochageCCConfoEncours = False // [CONFO][CUISINE][PC680]
ibDeCochageCCConfoEncours = False // [CONFO][CUISINE][PC680]
ibIdEvtInterditCreation = False // [DT424]

// [CONFO][CUISINE][PC680]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 207 )
bConfo = lDeb > 0

// #1
stMessage.sTitre		= "Contrôle de gestion d'un détail"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE

sImei = idw_wSin.GetItemString ( 1, "NUM_IMEI_PORT" ) // #1
lCodTel = idw_Produit.GetItemNumber ( 1, "COD_TEL" ) // JFF

if IsNull ( sImei ) And isReferentiel = "IFR" And lCodTel > 0 then
	stMessage.sCode = "WDET521"
	F_Message ( stMessage )
end if
//: #1 - FIN

/*------------------------------------------------------------------*/
/* Modification SFR # Le 27/09/02 : initialisation de la gamme. La  */
/* valeur -1 signifie que la fenêtre des gammes n'a pas été         */
/* ouverte.                                                         */
/*------------------------------------------------------------------*/
ilRetGamme = -1

/*------------------------------------------------------------------*/
/* On recopie la ligne du détail de la fenêtre parent dans          */
/* dw_wDetailFF de W_DETAIL.                                        */
/*------------------------------------------------------------------*/
idw_wDetailFF.Uf_CopierLigne ()


/*------------------------------------------------------------------*/
/* Rôle de facturation, droit -NA/208										  */
/*------------------------------------------------------------------*/
This.uf_Set_ProfilFacturation ()


/*------------------------------------------------------------------*/
/* Le produit a t-il changé ?                                       */
/*------------------------------------------------------------------*/
Uf_ChangerProduit ()

/*------------------------------------------------------------------*/
/* On autorise ou non l'utilisation du bouton SUPPRIMER de la       */
/* fenêtre.                                                         */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Si le détail a déjà été validé, on interdit la suppression.      */
/*------------------------------------------------------------------*/
If	idw_wDetailFF.GetItemNumber ( 1, "CPT_VALIDE" ) > 0	Then
	bSupprime = False
End If

/*------------------------------------------------------------------*/
/* On gére les pieces, les refus et les plafonds en modification.   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* S'il n'y a pas d'interlocuteurs, on rend l'onglet inaccessible.  */
/*------------------------------------------------------------------*/
If	idw_LstInter.RowCount () = 0 Then
	iuoOng.Uf_ActiverOnglet ( "02", False )
Else
	iuoOng.Uf_ActiverOnglet ( "02", True )
End If

Uf_GestionuTagger_Piece ( 2 )
Uf_GestionuTagger_Refus ( 2 )
Uf_Gestion_Plafond ( 2 )

Uf_GestionGarantie ()
/*------------------------------------------------------------------*/
/* Gestion des commandes.                                           */
/*------------------------------------------------------------------*/
Uf_Gestion_Commandes ()
Uf_Gestion_DetailDivers ()
Uf_GestOng_Divers ()

/*------------------------------------------------------------------*/
/* On s'occupe de la date du détail. Découpage des zones.           */
/*------------------------------------------------------------------*/
Uf_Cast_DteDet ()

idw_wDetailFF.Modify ( "mt_prej_t.Text= 'Mt Préjudice'" )	

/*------------------------------------------------------------------*/
/* On gére les TabOrder uniquement en saisie.                       */
/*------------------------------------------------------------------*/
If	isTypeTrt = "S"	Then
	Uf_Tb_Detail ()

/*------------------------------------------------------------------*/
/* On gére la dernière colonne.                                     */
/*------------------------------------------------------------------*/
	If	idw_wDetailFF.GetItemString ( 1, "ALT_SSUI" ) = "O"	Then
		idw_wDetailFF.ilDernCol = 22					// Zne COD_MOT_SSUI
	Else
		idw_wDetailFF.ilDernCol = 21					// Zne ALT_SSUI
	End If
End If

/*------------------------------------------------------------------*/
/* On s'occupe des variables d'instance nécessaires à la gestion    */
/* du dossier.                                                      */
/*------------------------------------------------------------------*/
idcMtPlafInitial = idw_wDetailFF.GetItemNumber ( 1, "MT_PLAF" )
isAltBlocInitial = idw_wDetailFF.GetItemString ( 1, "ALT_BLOC" )
lIdGti = idw_WdetailFF.GetItemNumber ( 1, "ID_GTI" )
lIdDetail = idw_WdetailFF.GetItemNumber ( 1, "ID_DETAIL" )


If	iuoOng.Uf_RecupererOngletCourant () <> "01" Then
	iuoOng.Uf_ChangerOnglet ( "01" ) 
End If

/*------------------------------------------------------------------*/
/* On vérifie si on donne accés au bonton CONTROLE de la fenêtre.   */
/* En effet si le détail est déjà réglé (COD_ETAT = 600),           */
/* l'utilisateur ne doit rien toucher.                              */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Le bouton sera rendu actif/inactif dans la fonction              */
/* Wf_PreparerModifier de la fenêtre.                               */
/*------------------------------------------------------------------*/
If	idw_wDetailFF.GetItemNumber ( 1, "COD_ETAT" ) = 600	Then
	astPass.lTab[1] = 0			// Il faut désactiver le bouton
Else
	astPass.lTab[1] = 1			// Il faut activer le bouton
End If

astPass.bSupprime	= bSupprime		
astPass.bRetour	= True

/*------------------------------------------------------------------*/
/* Le 28/11/2001.                                                   */
/* Modif DGA. DCMP 010375                                           */
/*------------------------------------------------------------------*/
If	isTypeTrt = "S"	Then
	If	idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) = 5	Then 
		iCbTarif.Visible = TRUE
	Else
		iCbTarif.Visible = FALSE
	End If
End If

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/* La zone ID_I_REG est rendue Visible/Invisible en fonction de     */
/* certains critères.                                               */
/*------------------------------------------------------------------*/
This.uf_Rendre_Visible_Idireg ( 0 )

This.uf_Gestion_MtValPublique ( )

//* #7 [GEST_VAL_ACH_ADH]
This.uf_Gestion_MtValAchat ()

// [VDOC29630]
This.uf_Gestion_DteDet ()	

If Not This.uf_GetAutorisation ( 208 ) Then 
	idw_wDetailFF.SetColumn ( "MT_PREJ" )
Else 
	idw_wDetailFF.SetColumn ( "DTE_FACTURE" )
End IF

// #2
lIdGti = idw_WdetailFF.GetItemNumber ( 1, "ID_GTI" )
lIdEvt = idw_WdetailFF.GetItemNumber ( 1, "ID_EVT" )
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 86 )

istPec.Text = ""
istPec.Hide () ; istLabPec.Hide ()

If lDeb > 0 Then
	For lCpt = lDeb To lFin
		If idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) = lIdGti Then
	
				istPec.Visible = lDeb > 0 
				istLabPec.Visible = lDeb > 0 
	
				sMtPec = This.uf_GestOng_Divers_Trouver ("MT_PEC" ) 
				bPec = This.uf_GestOng_Divers_Trouver ("PEC" ) = "O"
				bAltPec = This.uf_GestOng_Divers_Trouver ("ALT_PEC" ) = "O"
				
				If Dec ( sMtPec ) > 0 And bPec Then
					//#6 [SUISSE].LOT3 
					istPec.Text = String ( dec ( sMtPec ), "#,##0.00 \"+stGlb.smonnaiesymboledesire ) 
				
					If bAltPec and bPec Then
						istPec.TextColor = 255 // rouge
					Else
						istPec.TextColor = 32768 // Vert foncé
					End IF
				End If
			Exit
		End If 
	Next
	
End If
// :#2

// #3 Valeur par défaut
lRow = idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'ACCORD_REMPL'", 1, idw_wDivDet.RowCount () )
If lRow > 0 Then

	lVal = idw_wDivDet.GetItemNumber ( lRow, "VAL_NBRE" ) 
	If IsNull ( lVal ) Or lVal = 0 Then 
		This.uf_GestOng_Divers_MajZone ( "ACCORD_REMPL", lRow, 1 )
	End If
End If

// #5 Valeur par défaut
lRow = idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'ACCORD_REMPL2'", 1, idw_wDivDet.RowCount () )
If lRow > 0 Then

	lVal = idw_wDivDet.GetItemNumber ( lRow, "VAL_NBRE" ) 
	If IsNull ( lVal ) Or lVal = 0 Then 
		This.uf_GestOng_Divers_MajZone ( "ACCORD_REMPL2", lRow, 1 )
	End If
End If

// [PLAF_REF]

// [CONFO][CUISINE][PC680]
If bConfo Then 
	Choose Case lIdEvt
		Case 1317
			ibCocheALentreeCCConfo = This.uf_GestOng_Divers_Trouver ("PEC" ) = "O" 
	End Choose
End If 
// :[CONFO][CUISINE][PC680]

// [PC662][POINT7]
bRole208 = This.uf_GetAutorisation ( 208 )
sNumFact = idw_wDetailFF.GetItemString ( 1, "NUM_FACTURE" )
dDteFact = Date (idw_wDetailFF.GetItemDateTime ( 1, "DTE_FACTURE" )) // [PI056]
dcMtPrej = idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" )
iCodeEtat = idw_wDetailFF.GetItemNumber ( 1, "COD_ETAT" )

// [DT57_CMDE_IPHONE_SFR]
// [DT070]
lRow = 0

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 248 )
If lDeb > 0 Then
	sCas = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "CAS", ";")

	lRow = idw_LstCmdeSin.Find ( "ID_GTI = " + String ( lIdGti ) + " AND " + &
										  "ID_DETAIL = " + String ( lIdDetail ) + " AND " + &
										  "POS ( INFO_SPB_FRN_CPLT, 'MAJOR_CONTRACTUELLE_EUROS' ) > 0" &
										  , 1, idw_LstCmdeSin.RowCount () )
	
	Choose Case sCas 

		Case "DARTY_ABONNEMENT", "IPHONE_O2M_SFR", "MOBISTORE_ET_PRODUIT_DERIVES", "MOBISTORE_MOBILZEN2"
			If lRow > 0 Then
				sVal = idw_LstCmdeSin.GetItemString ( lRow, "INFO_SPB_FRN_CPLT" )
				sVal = lnvPFCString.of_getkeyvalue (sVal, "MAJOR_CONTRACTUELLE_EUROS", ";")
				If IsNull ( sVal ) Or Len ( sVal ) <= 0 Then
					sVal = "0"
				End If
				
				dcMtMajor = Dec ( sVal )
				dcMtCmde  = idw_LstCmdeSin.GetItemDecimal ( lRow, "MT_TTC_CMDE" )
				
				If dcMtPrej > dcMtCmde + dcMtMajor Then
					lRow = 0
					stMessage.sTitre		= "Réglement facture"
					stMessage.Icon			= Exclamation!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= Ok!
					stMessage.sCode		= "WDET637"
					stMessage.sVar[1] = String ( dcMtPrej ) + "€"
					stMessage.sVar[2] = String ( dcMtCmde ) + "€"
					stMessage.sVar[3] = String ( dcMtMajor ) + "€"

				
					F_Message ( stMessage )
					
				End If
				
			End If

	End Choose
	
End If

If bRole208 and lRow > 0 And &
	Not IsNull ( sNumFact ) And &
	sNumFact <> "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" And &
	Not IsNull ( dDteFact ) And &
	dcMtPrej > 0 and &
	iCodeEtat = 100 &
	Then 
		idw_WdetailFF.SetItem ( 1, "ALT_REG", "O" )
		idw_WdetailFF.SetItem ( 1, "ALT_SSUI", "N" )			
		This.Uf_Tb_AltReg ()
		idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcMtPrej )
End If
// [PC662][POINT7]

// [PC301][VESTUSTE][VDOC6122]
PostEvent ( This, "ue_mt_prej" )

ibCtlValAchat=FALSE // [VDOC10924]

idw_wDetailFF.SetFocus ()

// [VDOC28827] et [VDOC28866]
idw_wDivDet.setRow (1)

// [HUB875]
If F_CLE_A_TRUE ( "HUB875" ) Then
	This.uf_affichage_dw_choix_action ( lIdEvt )
End If

end subroutine

private subroutine uf_gestionutagger_piece (integer aitype);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GestionuTagger_Piece (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 22/01/1998 16:31:31
//* Libellé			: 
//* Commentaires	: Gestion des pièces à réclamer
//*
//* Arguments		: Integer		aiType			(Val)	Type d'action
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//*	#1	JCA	12/01/2007		DCMP 050273 - Cochage automatique des pièces à la création d'un détail en fonction de l'option 77
//		FPI		29/03/2012		[PM194] Evolution de la DP 77
//    JFF   04/09/2023  [RS5656_MOD_PCE_DIF]
//*-----------------------------------------------------------------

String sTab, sNew, sLigne, sFiltre, sBitMap, sIdEvtAuto
Long lCpt, lTotPiece, lTotPieceTag, lIdI

Long		lBoucle, lBitmap, lDeb, lFin, lPieceAuto, lPiece, lGtiAuto, lGti, lProd // #1
String	sAltReclame // #1
n_cst_string 	lnvString // [PM194]
String		sListeNatSin, sFlagAutoSimpa2, sVal // [PM194]

sAltReclame = "N" // #1

sTab		= "~t"
sNew		= "~r~n"
sLigne	= ""

Choose Case aiType
/*------------------------------------------------------------------*/
/* On a changé de produit, on repopulise les pièces dans dw_Source. */
/*------------------------------------------------------------------*/
Case 0					
	iuoTagPiece.dw_Source.Reset ()
	idw_Piece.RowsCopy ( 1, 999, Primary!, iuoTagPiece.dw_Source, 1, Primary! )

/*------------------------------------------------------------------*/
/* On est en insertion d'un détail.                                 */
/*------------------------------------------------------------------*/
Case 1
	iuoTagPiece.dw_Trt.Reset ()

/*------------------------------------------------------------------*/
/* On filtre la dw SOURCE (Table PIECE) avec ID_GTI et COD_TYP_PCE. */
/*------------------------------------------------------------------*/
	sFiltre = "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + " AND COD_TYP_PCE = 'E'"

	iuoTagPiece.dw_Source.SetFilter ( sFiltre )
	iuoTagPiece.dw_Source.Filter ()
	iuoTagPiece.dw_Source.Sort ()
	lTotPiece = iuoTagPiece.dw_Source.RowCount ()

/*------------------------------------------------------------------*/
/* Les zones à insérer sont les suivantes :                         */
/* ID_SIN                                                           */
/* ID_GTI                                                           */
/* ID_DETAIL : On positionne avec la valeur du détail en cours      */
/* ID_PCE                                                           */
/* ID_I      : Positionné à ""                                      */
/* ID_PARA                                                          */
/* CPT_TRI                                                          */
/* CREE_LE	: Cette valeur sera positionnée sur l'update de la DW   */
/* MAJ_LE	: Cette valeur sera positionnée sur l'update de la DW   */
/* MAJ_PAR                                                          */
/* CPT_VER                                                          */
/* ALT_RECLAME                                                      */
/* LIB_PCE                                                          */
/* ALT_RECLAME_AVANT                                                */
/* ID_I_AVANT : Positionné à ""                                     */
/*------------------------------------------------------------------*/

	For	lCpt = 1 To lTotPiece
// #1
			lProd		=	idw_Produit.object.id_prod[1]
			
			F_RechDetPro ( lDeb, lFin, idw_DetPro, lProd, '-DP', 77 )
			If lDeb > 0 Then
				For lBoucle = lDeb To lFin
					lPiece		=	iuoTagPiece.dw_Source.object.id_pce[lCpt]
					lPieceAuto	=	idw_DetPro.object.val_num[lBoucle]
					lGti			=	idw_wGarSin.object.id_gti[1]
					lGtiAuto		=	idw_DetPro.object.id_code_num[lBoucle]
	
					// [RS5656_MOD_PCE_DIF]
					sIdEvtAuto = idw_DetPro.object.id_code_car[lBoucle]
					If sIdEvtAuto = "-1" Then Continue
	
					If lPieceAuto = lPiece And lGtiAuto = lGti Then
						// [PM194] Evolution de la DP 77
						sAltReclame = "N"
						
						sVal= idw_DetPro.object.val_car[lBoucle]
						if isnull(sVal) Then sVal=""
						
						sListeNatSin=lnvString.of_getkeyvalue(sVal, "ID_NATSIN", ";")
						
						sFlagAutoSimpa2=lnvString.of_getkeyvalue(sVal, "AUTO_SIMPA2", ";")
						if sFlagAutoSimpa2 ="" Then sFlagAutoSimpa2="OUI"
						
						If sFlagAutoSimpa2="OUI" Then
							If sListeNatSin="" or &
								Pos(sListeNatSin,"#" + String(idw_wSin.GetItemNumber(1,"ID_NATSIN")) + "#") > 0 Then
								sAltReclame = "O"
								lBitmap = 1
							End if
						End if
						
						exit
						// :[PM194]
						// Fin [PM194]
					Else
						sAltReclame = "N"
					End If
				Next
			End If
// #1 - FIN

			sLigne = sLigne 																										+ &
						String ( idw_wDetailFF.GetItemNumber ( 1, "ID_SIN" ) )							+ sTab	+ &
						String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )							+ sTab	+ &
						String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )						+ sTab	+ &
						String ( iuoTagPiece.dw_Source.GetItemNumber ( lCpt, "ID_PCE" ) )				+ sTab	+ &
																															+ sTab	+ &
						iuoTagPiece.dw_Source.GetItemString ( lCpt, "ID_PARA" ) 							+ sTab	+ &
						String ( iuoTagPiece.dw_Source.GetItemNumber ( lCpt, "CPT_TRI" ) )			+ sTab	+ &
																															+ sTab	+ &
																															+ sTab	+ &
						stGLB.sCodOper																					+ sTab	+ &
						iuoTagPiece.dw_Source.GetItemString ( lCpt, "CPT_VER" ) 							+ sTab	+ &
/* #1 */				sAltReclame																						+ sTab	+ &
						iuoTagPiece.dw_Source.GetItemString ( lCpt, "LIB_CODE" ) 						+ sTab	+ &
						"N"																								+ sTab	+ &
																															+ sNew
	Next
	
	iuoTagPiece.dw_Trt.ImportString ( sLigne )
	
	// #1
	If	lBitmap = 1 Then
		sBitMap = "K:\PB4OBJ\BMP\8_ALPCE.BMP"
	Else
		sBitMap = ""
	End If
	iuoOng.Uf_ChangerBitmap ( "02", sBitMap )
	// #1 - FIN

	sFiltre = ""

	iuoTagPiece.dw_Source.SetFilter ( sFiltre )
	iuoTagPiece.dw_Source.Filter ()
	iuoTagPiece.dw_Source.Sort ()

/*------------------------------------------------------------------*/
/* On est en modification d'un détail.                              */
/*------------------------------------------------------------------*/
Case 2

	iuoTagPiece.dw_Trt.Reset ()

/*------------------------------------------------------------------*/
/* On insére dans DW_TRT les piéces déjà réclamées. Pour cela on    */
/* filtre sur ID_GTI et ID_DETAIL.                                  */
/*------------------------------------------------------------------*/
	sFiltre = "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + &
				 " AND ID_DETAIL = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )

	idw_wPiece_Detail.SetFilter ( sFiltre )
	idw_wPiece_Detail.Filter ()
	idw_wPiece_Detail.Sort ()
	lTotPieceTag = idw_wPiece_Detail.RowCount ()

	If	lTotPieceTag > 0 Then
		sBitMap = "K:\PB4OBJ\BMP\8_ALPCE.BMP"
	Else
		sBitMap = ""
	End If
	iuoOng.Uf_ChangerBitmap ( "02", sBitMap )
	
	For	lCpt = 1 To lTotPieceTag
			idw_wPiece_Detail.SetItem ( lCpt, "ALT_RECLAME_AVANT",	"O" )
/*------------------------------------------------------------------*/
/* Ne jamais faire un SetItem avec un GetItemNumber (Problème de    */
/* précision). Il faut passer dans une variable intermédiaire.      */
/*------------------------------------------------------------------*/
			lIdI = idw_wPiece_Detail.GetItemNumber ( lCpt, "ID_I" )
			idw_wPiece_Detail.SetItem ( lCpt, "ID_I_AVANT", 			lIdI )
	Next
	idw_wPiece_Detail.RowsCopy ( 1, lTotPieceTag, Primary!, iuoTagPiece.dw_Trt, 1, Primary! )

/*------------------------------------------------------------------*/
/* On enleve le filtre sur dw_wPiece.                               */
/*------------------------------------------------------------------*/

	sFiltre = ""
	idw_wPiece_Detail.SetFilter ( sFiltre )
	idw_wPiece_Detail.Filter ()
	idw_wPiece_Detail.Sort ()

/*------------------------------------------------------------------*/
/* On insére maintenant les pièces non réclamées. Pour cela on      */
/* filtre dw_Source sur ID_GTI et COD_TYP_PCE. On n'oublie pas de   */
/* filtrer les pièces déjà présentes dans dw_Trt.                   */
/*------------------------------------------------------------------*/
	For	lCpt = 1 To lTotPieceTag
			sFiltre = sFiltre + "ID_PCE <> " + String ( iuoTagPiece.dw_Trt.GetItemNumber ( lCpt, "ID_PCE" ) ) + " AND "
	Next

	sFiltre = sFiltre + "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + " AND COD_TYP_PCE = 'E'"

	iuoTagPiece.dw_Source.SetFilter ( sFiltre )
	iuoTagPiece.dw_Source.Filter ()
	iuoTagPiece.dw_Source.Sort ()
	lTotPiece = iuoTagPiece.dw_Source.RowCount ()

/*------------------------------------------------------------------*/
/* Les zones à insérer sont les suivantes :                         */
/* ID_SIN                                                           */
/* ID_GTI                                                           */
/* ID_DETAIL : On positionne avec la valeur du détail en cours      */
/* ID_PCE                                                           */
/* ID_I      : Positionné à ""                                      */
/* ID_PARA                                                          */
/* CPT_TRI                                                          */
/* CREE_LE	: Cette valeur sera positionnée sur l'update de la DW   */
/* MAJ_LE	: Cette valeur sera positionnée sur l'update de la DW   */
/* MAJ_PAR                                                          */
/* CPT_VER                                                          */
/* ALT_RECLAME                                                      */
/* LIB_PCE                                                          */
/* ALT_RECLAME_AVANT                                                */
/* ID_I_AVANT : Positionné à ""                                     */
/*------------------------------------------------------------------*/
	For	lCpt = 1 To lTotPiece
			sLigne = sLigne 																										+ &
						String ( idw_wDetailFF.GetItemNumber ( 1, "ID_SIN" ) )							+ sTab	+ &
						String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )							+ sTab	+ &
						String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )						+ sTab	+ &
						String ( iuoTagPiece.dw_Source.GetItemNumber ( lCpt, "ID_PCE" ) )				+ sTab	+ &
																															+ sTab	+ &
						iuoTagPiece.dw_Source.GetItemString ( lCpt, "ID_PARA" ) 							+ sTab	+ &
						String ( iuoTagPiece.dw_Source.GetItemNumber ( lCpt, "CPT_TRI" ) )			+ sTab	+ &
																															+ sTab	+ &
																															+ sTab	+ &
						stGLB.sCodOper																					+ sTab	+ &
						iuoTagPiece.dw_Source.GetItemString ( lCpt, "CPT_VER" ) 							+ sTab	+ &
						"N"																								+ sTab	+ &
						iuoTagPiece.dw_Source.GetItemString ( lCpt, "LIB_CODE" ) 						+ sTab	+ &
						"N"																								+ sTab	+ &
																															+ sNew
	Next
	iuoTagPiece.dw_Trt.ImportString ( sLigne )

	sFiltre = ""

	iuoTagPiece.dw_Source.SetFilter ( sFiltre )
	iuoTagPiece.dw_Source.Filter ()
	iuoTagPiece.dw_Source.Sort ()

	iuoTagPiece.dw_Trt.Sort ()

End Choose
end subroutine

private subroutine uf_gestionutagger_refus (integer aitype);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GestionuTagger_Refus (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 22/01/1998 16:31:31
//* Libellé			: 
//* Commentaires	: Gestion des motifs de refus
//*
//* Arguments		: Integer		aiType			(Val)	Type d'action
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sTab, sNew, sLigne, sFiltre, sBitMap
Long lCpt, lTotMotif, lTotRefusTag, lIdI

sTab		= "~t"
sNew		= "~r~n"
sLigne	= ""

Choose Case aiType
/*------------------------------------------------------------------*/
/* On a changé de produit, on repopulise les motifs dans dw_Source. */
/*------------------------------------------------------------------*/
Case 0					
	iuoTagRefus.dw_Source.Reset ()
	idw_Motif.RowsCopy ( 1, 999, Primary!, iuoTagRefus.dw_Source, 1, Primary! )

/*------------------------------------------------------------------*/
/* On est en insertion d'un détail.                                 */
/*------------------------------------------------------------------*/
Case 1
	iuoTagRefus.dw_Trt.Reset ()

/*------------------------------------------------------------------*/
/* On filtre la dw SOURCE (Table MOTIF) avec ID_GTI et COD_TYP_MOTIF*/
/*------------------------------------------------------------------*/
	sFiltre = "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + " AND COD_TYP_MOTIF = 'E'"

	iuoTagRefus.dw_Source.SetFilter ( sFiltre )
	iuoTagRefus.dw_Source.Filter ()
	iuoTagRefus.dw_Source.Sort ()
	lTotMotif = iuoTagRefus.dw_Source.RowCount ()

/*------------------------------------------------------------------*/
/* Les zones à insérer sont les suivantes :                         */
/* ID_SIN                                                           */
/* ID_GTI                                                           */
/* ID_DETAIL : On positionne avec la valeur du détail en cours      */
/* ID_MOTIF                                                         */
/* ALT_MAC                                                          */
/* ALT_OPE                                                          */
/* ID_I      : Positionné à ""                                      */
/* ID_PARA                                                          */
/* CPT_TRI                                                          */
/* CREE_LE	: Cette valeur sera positionnée sur l'update de la DW   */
/* MAJ_LE	: Cette valeur sera positionnée sur l'update de la DW   */
/* MAJ_PAR                                                          */
/* CPT_VER                                                          */
/* LIB_MOTIF                                                        */
/* ALT_MAC_AVANT                                                    */
/* ALT_OPE_AVANT                                                    */
/* ID_I_AVANT : Positionné à ""                                     */
/*------------------------------------------------------------------*/
	For	lCpt = 1 To lTotMotif
			sLigne = sLigne 																										+ &
						String ( idw_wDetailFF.GetItemNumber ( 1, "ID_SIN" ) )							+ sTab	+ &
						String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )							+ sTab	+ &
						String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )						+ sTab	+ &
						String ( iuoTagRefus.dw_Source.GetItemNumber ( lCpt, "ID_MOTIF" ) )			+ sTab	+ &
						"N"																								+ sTab	+ &
						"N"																								+ sTab	+ &
																															+ sTab	+ &
						iuoTagRefus.dw_Source.GetItemString ( lCpt, "ID_PARA" ) 							+ sTab	+ &
						String ( iuoTagRefus.dw_Source.GetItemNumber ( lCpt, "CPT_TRI" ) )			+ sTab	+ &
																															+ sTab	+ &
																															+ sTab	+ &
						stGLB.sCodOper																					+ sTab	+ &
						iuoTagRefus.dw_Source.GetItemString ( lCpt, "CPT_VER" ) 							+ sTab	+ &
						iuoTagRefus.dw_Source.GetItemString ( lCpt, "LIB_CODE" ) 						+ sTab	+ &
						"N"																								+ sTab	+ &
						"N"																								+ sTab	+ &
																															+ sNew
	Next
	iuoTagRefus.dw_Trt.ImportString ( sLigne )

	sFiltre = ""

	iuoTagRefus.dw_Source.SetFilter ( sFiltre )
	iuoTagRefus.dw_Source.Filter ()
	iuoTagRefus.dw_Source.Sort ()



/*------------------------------------------------------------------*/
/* On est en modification d'un détail.                              */
/*------------------------------------------------------------------*/
Case 2

	iuoTagRefus.dw_Trt.Reset ()

/*------------------------------------------------------------------*/
/* On insére dans DW_TRT les refus déjà positionnés. Pour cela on   */
/* filtre sur ID_GTI et ID_DETAIL.                                  */
/*------------------------------------------------------------------*/
	sFiltre = "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + &
				 " AND ID_DETAIL = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )

	idw_wRefus_Detail.SetFilter ( sFiltre )
	idw_wRefus_Detail.Filter ()
	idw_wRefus_Detail.Sort ()
	lTotRefusTag = idw_wRefus_Detail.RowCount ()

	If	lTotRefusTag > 0 Then
		sBitMap = "K:\PB4OBJ\BMP\8_REF.BMP"
	Else
		sBitMap = ""
	End If
	iuoOng.Uf_ChangerBitmap ( "03", sBitMap )
	
	For	lCpt = 1 To lTotRefusTag
			idw_wRefus_Detail.SetItem ( lCpt, "ALT_MAC_AVANT", idw_wRefus_Detail.GetItemString ( lCpt, "ALT_MAC" ) )
			idw_wRefus_Detail.SetItem ( lCpt, "ALT_OPE_AVANT", idw_wRefus_Detail.GetItemString ( lCpt, "ALT_OPE" ) )
/*------------------------------------------------------------------*/
/* Ne jamais faire un SetItem avec un GetItemNumber (Problème de    */
/* précision). Il faut passer dans une variable intermédiaire.      */
/*------------------------------------------------------------------*/
			lIdI = idw_wRefus_Detail.GetItemNumber ( lCpt, "ID_I" )
			idw_wRefus_Detail.SetItem ( lCpt, "ID_I_AVANT", 	lIdI )
	Next
	idw_wRefus_Detail.RowsCopy ( 1, lTotRefusTag, Primary!, iuoTagRefus.dw_Trt, 1, Primary! )

/*------------------------------------------------------------------*/
/* On enleve le filtre sur dw_wRefus.                               */
/*------------------------------------------------------------------*/
	sFiltre = ""
	idw_wRefus_Detail.SetFilter ( sFiltre )
	idw_wRefus_Detail.Filter ()
	idw_wRefus_Detail.Sort ()

/*------------------------------------------------------------------*/
/* On insére maintenant les refus non positionnés. Pour cela on     */
/* filtre dw_Source sur ID_GTI et COD_TYP_MOTIF. On n'oublie pas de */
/* filtrer les motifs déjà présents dans dw_Trt.                    */
/*------------------------------------------------------------------*/
	For	lCpt = 1 To lTotRefusTag
			sFiltre = sFiltre + "ID_MOTIF <> " + String ( iuoTagRefus.dw_Trt.GetItemNumber ( lCpt, "ID_MOTIF" ) ) + " AND "
	Next

	sFiltre = sFiltre + "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + " AND COD_TYP_MOTIF = 'E'"

	iuoTagRefus.dw_Source.SetFilter ( sFiltre )
	iuoTagRefus.dw_Source.Filter ()
	iuoTagRefus.dw_Source.Sort ()
	lTotMotif = iuoTagRefus.dw_Source.RowCount ()

/*------------------------------------------------------------------*/
/* Les zones à insérer sont les suivantes :                         */
/* ID_SIN                                                           */
/* ID_GTI                                                           */
/* ID_DETAIL : On positionne avec la valeur du détail en cours      */
/* ID_MOTIF                                                         */
/* ALT_MAC                                                          */
/* ALT_OPE                                                          */
/* ID_I      : Positionné à ""                                      */
/* ID_PARA                                                          */
/* CPT_TRI                                                          */
/* CREE_LE	: Cette valeur sera positionnée sur l'update de la DW   */
/* MAJ_LE	: Cette valeur sera positionnée sur l'update de la DW   */
/* MAJ_PAR                                                          */
/* CPT_VER                                                          */
/* LIB_MOTIF                                                        */
/* ALT_MAC_AVANT                                                    */
/* ALT_OPE_AVANT                                                    */
/* ID_I_AVANT : Positionné à ""                                     */
/*------------------------------------------------------------------*/
	For	lCpt = 1 To lTotMotif
			sLigne = sLigne 																								+ &
						String ( idw_wDetailFF.GetItemNumber ( 1, "ID_SIN" ) )							+ sTab	+ &
						String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )							+ sTab	+ &
						String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )						+ sTab	+ &
						String ( iuoTagRefus.dw_Source.GetItemNumber ( lCpt, "ID_MOTIF" ) )			+ sTab	+ &
						"N"																								+ sTab	+ &
						"N"																								+ sTab	+ &
																															+ sTab	+ &
						iuoTagRefus.dw_Source.GetItemString ( lCpt, "ID_PARA" ) 							+ sTab	+ &
						String ( iuoTagRefus.dw_Source.GetItemNumber ( lCpt, "CPT_TRI" ) )			+ sTab	+ &
																															+ sTab	+ &
																															+ sTab	+ &
						stGLB.sCodOper																					+ sTab	+ &
						iuoTagRefus.dw_Source.GetItemString ( lCpt, "CPT_VER" ) 							+ sTab	+ &
						iuoTagRefus.dw_Source.GetItemString ( lCpt, "LIB_CODE" ) 						+ sTab	+ &
						"N"																								+ sTab	+ &
						"N"																								+ sTab	+ &
																															+ sNew
	Next
	iuoTagRefus.dw_Trt.ImportString ( sLigne )

	sFiltre = ""

	iuoTagRefus.dw_Source.SetFilter ( sFiltre )
	iuoTagRefus.dw_Source.Filter ()
	iuoTagRefus.dw_Source.Sort ()

	iuoTagRefus.dw_Trt.Sort ()

End Choose

end subroutine

private subroutine uf_changerproduit ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ChangerProduit (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 23/01/1998 17:40:41
//* Libellé			: 
//* Commentaires	: A t-on changé de produit ou de révision ?
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* L'événement Ue_Initialisation n'est déclenchée qu'une seule      */
/* fois. Or la fenêtre de traitement détail a besoin de savoir si   */
/* le produit a changé. Il faut donc faire le test sur              */
/* Uf_PreparerModifier et Uf_PreparerInserer.                       */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Les initialisations relatives au Produit/Révision auront lieu    */
/* ici.                                                             */
/*------------------------------------------------------------------*/
Long lIdProd, lIdRev

lIdProd		= idw_Produit.GetItemNumber ( 1, "ID_PROD" )
lIdRev		= idw_wSin.GetItemNumber ( 1, "ID_REV" )

If	lIdProd <> ilDernierIdProd Or lIdRev <> ilDernierIdRev	Then
/*------------------------------------------------------------------*/
/* On réinitialise la liste des pièces et des motifs (DW_SOURCE).   */
/*------------------------------------------------------------------*/
	Uf_GestionuTagger_Piece ( 0 )
	Uf_GestionuTagger_Refus ( 0 )
		
	ilDernierIdProd	= lIdProd
	ilDernierIdRev		= lIdRev
End If



end subroutine

private subroutine uf_preparervalider (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerValider (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Préparation de la validation d'un détail
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//       JFF   24/01/2012  [CONFO][CUISINE][PC680]
//*-----------------------------------------------------------------

DataWindowChild	dwChild
String	sFiltre

/*------------------------------------------------------------------*/
/* On s'occupe du transfert des pièces du détail.                   */
/*------------------------------------------------------------------*/
Uf_PreparerValider_Piece ( astPass )

/*------------------------------------------------------------------*/
/* On s'occupe du transfert des refus du détail.                    */
/*------------------------------------------------------------------*/
Uf_PreparerValider_Refus ( astPass )

/*------------------------------------------------------------------*/
/* On s'occupe du transfert des plafonds du détail.                 */
/*------------------------------------------------------------------*/
Uf_PreparerValider_Plafond ( astPass )

/*------------------------------------------------------------------*/
/* On s'occupe du transfert des Commandes.					           */
/*------------------------------------------------------------------*/
Uf_PreparerValider_Commande ( )

Uf_PreparerValider_OngDivers ( )

/*------------------------------------------------------------------*/
/* Le 21/04/1999. Modif. pour la couverture UF des autres cartes.   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On désactive le filtre sur ID_TYPE_CARTE. Ce filtre peut être    */
/* positionné dans la fonction Uf_Zn_IdEvt ()                       */
/*------------------------------------------------------------------*/
sFiltre = ""

idw_wDetailFF.GetChild ( "ID_TYPE_CARTE", dwChild )
dwChild.SetFilter  ( sFiltre )
dwChild.Filter ()

// [CONFO][CUISINE][PC680]
ibCochageCCConfoEncours = FALSE


end subroutine

private subroutine uf_preparervalider_piece (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerValider_Piece (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Préparation de la validation d'un détail (Niveau PIECE)
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long 			lTotwPiece, lCpt, lTotTagTrt
String 		sFiltre, sAltReclameAvant, sAltReclameApres
Long			lIdIAvant, lIdIApres

Boolean 		bModif

bModif		= False

/*------------------------------------------------------------------*/
/* On s'occupe du transfert des pièces du détail.                  */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On va vérifier si l'une pièce a été touché. (Modification        */
/* possible sur ALT_RECLAME ou ID_I). Si c'est le cas, on supprime  */
/* toutes les pièces (en modification) et on insére les autres.     */
/*------------------------------------------------------------------*/
lTotTagTrt = iuoTagPiece.dw_Trt.RowCount ()

For	lCpt = 1	To	lTotTagTrt
		sAltReclameAvant	= iuoTagPiece.dw_Trt.GetItemString ( lCpt, "ALT_RECLAME_AVANT"  )
		sAltReclameApres	= iuoTagPiece.dw_Trt.GetItemString ( lCpt, "ALT_RECLAME" )

		lIdIAvant			= iuoTagPiece.dw_Trt.GetItemNumber ( lCpt, "ID_I_AVANT" )
		lIdIApres			= iuoTagPiece.dw_Trt.GetItemNumber ( lCpt, "ID_I" )

		If	IsNull ( lIdIAvant ) Then lIdIAvant = -1
		If	IsNull ( lIdIApres ) Then lIdIApres = -1

		If	sAltReclameAvant <> sAltReclameApres Or lIdIAvant <> lIdIApres	Then
			bModif = True
			Exit
		End If
Next

If	bModif	Then
	If	Not astPass.bInsert Then
/*------------------------------------------------------------------*/
/* On a touché à l'une des pièces. On supprime, en modification,    */
/* les pièces préalablement cochés.                                 */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On positionne le flag pour l'optimisation des commandes sur      */
/* W_GAR_SIN.                                                       */
/*------------------------------------------------------------------*/
		idw_wDetailFF.SetItem ( 1, "ALT_MODIF_PIECE", "O" )

		sFiltre = "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + &
					 " AND ID_DETAIL = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )

		idw_wPiece_Detail.SetFilter ( sFiltre )
		idw_wPiece_Detail.Filter ()
		lTotwPiece = idw_wPiece_Detail.RowCount ()

		idw_wPiece_Detail.RowsDiscard ( 1, lTotwPiece, Primary! )

		sFiltre = ""
		idw_wPiece_Detail.SetFilter ( sFiltre )
		idw_wPiece_Detail.Filter ()
	End If

/*------------------------------------------------------------------*/
/* On insére uniquement les pièces qui sont réclamées.              */
/*------------------------------------------------------------------*/
	sFiltre = "ALT_RECLAME = 'O'"

	iuoTagPiece.dw_Trt.SetFilter ( sFiltre )
	iuoTagPiece.dw_Trt.Filter ()
	lTotTagTrt = iuoTagPiece.dw_Trt.RowCount ()

	If	lTotTagTrt > 0 Then
		iuoTagPiece.dw_Trt.RowsMove ( 1, lTotTagTrt, Primary!, idw_wPiece_Detail, 1, Primary! )
	End If

	sFiltre = ""
	iuoTagPiece.dw_Trt.SetFilter ( sFiltre )
	iuoTagPiece.dw_Trt.Filter ()
End If

end subroutine

private subroutine uf_preparervalider_refus (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerValider_Refus (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Préparation de la validation d'un détail (Niveau REFUS)
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long 			lTotwRefus, lCpt, lTotTagTrt
String		sFiltre, sAltMacAvant, sAltOpeAvant, sAltMacApres, sAltOpeApres
Long			lIdIAvant, lIdIApres

Boolean 		bModif

bModif		= False

/*------------------------------------------------------------------*/
/* On s'occupe du transfert des refus du détail.                    */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On va vérifier si l'un des refus a bougé. (Modification possible */
/* sur ALT_MAC, ALT_OPE ou ID_I). Si c'est le cas, on supprime      */
/* tous les refus (en modification) et on insére les autres.        */
/*------------------------------------------------------------------*/
lTotTagTrt = iuoTagRefus.dw_Trt.RowCount ()

For	lCpt = 1	To	lTotTagTrt
		sAltMacAvant		= iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_MAC_AVANT"  )
		sAltMacApres		= iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_MAC"  )

		sAltOpeAvant		= iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_OPE_AVANT"  )
		sAltOpeApres		= iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_OPE"  )

		lIdIAvant			= iuoTagRefus.dw_Trt.GetItemNumber ( lCpt, "ID_I_AVANT" )
		lIdIApres			= iuoTagRefus.dw_Trt.GetItemNumber ( lCpt, "ID_I" )

		If	IsNull ( lIdIAvant ) Then lIdIAvant = -1
		If	IsNull ( lIdIApres ) Then lIdIApres = -1

		If	sAltMacAvant <> sAltMacApres Or sAltOpeAvant <> sAltOpeApres  Or lIdIAvant <> lIdIApres	Then
			bModif = True
			Exit
		End If
Next

If	bModif	Then
	If	Not astPass.bInsert Then
/*------------------------------------------------------------------*/
/* On a touché à l'un des refus. On supprime, en modification,      */
/* les refus préalablement cochés.                                  */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On positionne le flag pour l'optimisation des commandes sur      */
/* W_GAR_SIN.                                                       */
/*------------------------------------------------------------------*/
		idw_wDetailFF.SetItem ( 1, "ALT_MODIF_REFUS", "O" )

		sFiltre = "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + &
					 " AND ID_DETAIL = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )

		idw_wRefus_Detail.SetFilter ( sFiltre )
		idw_wRefus_Detail.Filter ()
		lTotwRefus = idw_wRefus_Detail.RowCount ()

		idw_wRefus_Detail.RowsDiscard ( 1, lTotwRefus, Primary! )

		sFiltre = ""
		idw_wRefus_Detail.SetFilter ( sFiltre )
		idw_wRefus_Detail.Filter ()
	End If

/*------------------------------------------------------------------*/
/* On insére uniquement les refus qui sont cochés.                  */
/*------------------------------------------------------------------*/
	sFiltre = "ALT_MAC = 'O' Or ALT_OPE = 'O'"

	iuoTagRefus.dw_Trt.SetFilter ( sFiltre )
	iuoTagRefus.dw_Trt.Filter ()
	lTotTagTrt = iuoTagRefus.dw_Trt.RowCount ()

	If	lTotTagTrt > 0 Then
		iuoTagRefus.dw_Trt.RowsMove ( 1, lTotTagTrt, Primary!, idw_wRefus_Detail, 1, Primary! )
	End If

	sFiltre = ""
	iuoTagRefus.dw_Trt.SetFilter ( sFiltre )
	iuoTagRefus.dw_Trt.Filter ()
End If

end subroutine

private subroutine uf_gestiongarantie ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GestionGarantie (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 23/01/1998 17:40:41
//* Libellé			: 
//* Commentaires	: Modification cosmétique d'un détail en fonction d'une garantie
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    11/05/2004  DCMP 040149 GMP (gti 23)
//* #2    JFF	  05/11/2004  Gestion particulière pour le DNT/DM
//* #3    JFF    02/11/2009  [DCMP071000].[JFF]
//        JFF    24/01/2012  [CONFO][CUISINE][PC680]
//*-----------------------------------------------------------------

Long lIdGti, lIdGtiDP, lCpt, lDeb, lFin
Date dDteAchatSin, dDteAchatDet 
String sMod, sLib

lIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
sMod			= ""

// #3  [DCMP071000].[JFF]
If lIdGti = 23 Then
	sMod += "mt_val_achat_t.Text = 'Nouveau prix constaté' "
	idw_wDetailFF.Modify ( sMod )
	sMod = ""
End If
// :#3  [DCMP071000].[JFF]

// [CONFO][CUISINE][PC680]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 207 )
If lDeb > 0 Then
	If lIdGti = 51 Then
		sMod += "mt_val_achat_t.Text = 'Mt des frais si rlgt par CC'"
		idw_wDetailFF.Modify ( sMod )
		sMod = ""
	Else
		sMod += "mt_val_achat_t.Text = 'Montant en " + stGlb.smonnaiesymboledesire + " de la Qté'"
		idw_wDetailFF.Modify ( sMod )
		sMod = ""
	End IF
End IF
// [CONFO][CUISINE][PC680]

/*------------------------------------------------------------------*/
/* La première chose est de filtrer les événements. La zone ID_EVT  */
/* est une DDDW. Elle correspond au SELECT sur la table             */
/* CODE_CONDITION (+EV) toutes garanties confondues. Il faut donc   */
/* filtrer les événements en fonction de ID_GTI.                    */
/*------------------------------------------------------------------*/
idw_CodeCondition.SetFilter ( "ID_GTI = " + String ( lIdGti ) )
idw_CodeCondition.Filter ()

/*------------------------------------------------------------------*/
/* Affichage sur Option DET_PRO le 30/09/05 JFF                     */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 42 )
If lDeb <= 0 Then 
	sMod+= " dte_det_t.visible = 0 dte_det_date.visible = 0"
	idw_wDetailFF.Modify ( sMod )	
	Return
End If

For lCpt = lDeb To lFin 

	lIdGtiDP = idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" )

	If lIdGtiDP <> lIdGti Then Continue

	sLib     = idw_DetPro.GetItemString ( lCpt, "val_car" )
	sLib     = F_Remplace ( sLib, "'", "~~'" )

	If lIdGti > 0 And sLib <> "-1" Then
		sMod = "dte_det_t.Text = '" + sLib +"' "		
	End If

	/*------------------------------------------------------------------*/
	/* On s'occupe du libellé sur DTE_DET.                              */
	/*------------------------------------------------------------------*/
	Choose Case lIdGti
/* #3  [DCMP071000].[JFF]
	// #1
	Case	23
		sMod += "mt_val_achat_t.Text = 'Nouveau prix constaté' "
*/
	// #2
	Case	15
	   dDteAchatSin = Date(idw_wSin.GetItemDateTime ( 1, "DTE_ACH_PORT" ) ) // [PI056]
		dDteAchatDet = idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" )

		If IsNull ( dDteAchatDet ) And Not IsNull ( dDteAchatSin ) Then
			idw_wDetailFF.SetItem ( 1, "DTE_DET_DATE", dDteAchatSin  )	
		End If

	End Choose

	sMod+= " dte_det_t.visible = 1 dte_det_date.visible = 1"

	If	sMod <> "" Then
		idw_wDetailFF.Modify ( sMod )
	End If

	Exit
Next

If sMod = "" Then 
	sMod+= " dte_det_t.visible = 0 dte_det_date.visible = 0"
	idw_wDetailFF.Modify ( sMod )	
End If 
end subroutine

private subroutine uf_tb_detail ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Tb_Detail (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 17:35:30
//* Libellé			: 
//* Commentaires	: Gestion des TabOrder en saisie
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF   30/10/2003	  MtValAchat Visible uniquement si DET_PRO=9
//* #2    JFF   31/01/2008   [DCMP080028]
//			FPI	24/08/2011	[VDoc5059]
//			FPI	24/08/2015	[DT158] protection zone val_achat
//			FPI	22/10/2015	[VDoc18971] protection zone val_achat sauf factu
//*-----------------------------------------------------------------

Boolean	bCasto
String sCol[]
Long lIdEvt, lDeb, lFin

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 43 ) // Gestion Castorama
bCasto = lDeb > 0

/*------------------------------------------------------------------*/
/* Cette fonction concerne toutes les zones.                        */
/*------------------------------------------------------------------*/
sCol [  1 ] = "ID_EVT"
sCol [  2 ] = "DTE_DET_DATE"
sCol [  3 ] = "HEU_DET"
sCol [  4 ] = "NUM_CARTE"
sCol [  5 ] = "LIB_DET"
sCol [  6 ] = "ALT_COUR"
sCol [  7 ] = "MT_PREJ"
sCol [  8 ] = "ID_I_REG"
sCol [  9 ] = "MT_PLAF"
sCol [ 10 ] = "ALT_SSUI"
sCol [ 11 ] = "COD_MOT_SSUI"
sCol [ 12 ] = "ALT_ATT"
sCol [ 13 ] = "ALT_BLOC"
sCol [ 14 ] = "ALT_REG"
sCol [ 15 ] = "ID_TYPE_CARTE"
sCol [ 16 ] = "MT_VAL_ACHAT"
sCol [ 17 ] = "DTE_FACTURE"
sCol [ 18 ] = "NUM_FACTURE"
sCol [ 19 ] = "MT_VAL_PUBLIQUE"

/*------------------------------------------------------------------*/
/* Si le détail est déjà réglé, aucune zone n'est accessible.       */
/*------------------------------------------------------------------*/
If	idw_wDetailFF.GetItemNumber ( 1, "COD_ETAT" ) = 600	Then
	idw_wDetailFF.Uf_Proteger ( sCol, "1" )
Else
/*------------------------------------------------------------------*/
/* Si le niveau de l'opérateur le permet, on rend la zone ALT_REG   */
/* accessible.                                                      */
/*------------------------------------------------------------------*/
	If	Long ( stGLB.sTypOper ) >= idw_Produit.GetItemNumber ( 1, "COD_NIV_OPE" )	Then
		idw_wDetailFF.Uf_Proteger ( { "ALT_REG" }, "0" )
/*------------------------------------------------------------------*/
/* Le montant plafonné est accessible si ALT_REG est à OUI.         */
/*------------------------------------------------------------------*/
		Uf_Tb_AltReg ()
	Else
		idw_wDetailFF.Uf_Proteger ( { "ALT_REG", "MT_PLAF" }, "1" )
	End If

/*------------------------------------------------------------------*/
/* Si le dossier a été validé au moins 1 fois, ID_EVT est non       */
/* accessible.                                                      */
/*------------------------------------------------------------------*/
	If	idw_wDetailFF.GetItemNumber ( 1, "CPT_VALIDE" ) > 0 Then
		idw_wDetailFF.Uf_Proteger ( { "ID_EVT" }, "1" )
		
		idw_wDetailFF.ilPremCol = 5		// Zne LIB_DET
	Else
		idw_wDetailFF.Uf_Proteger ( { "ID_EVT" }, "0" )	

		idw_wDetailFF.ilPremCol = 4		// Zne ID_EVT
	End If

/*------------------------------------------------------------------*/
/* Modification DBI le 18/08/1998                                   */
/*                                                                  */
/* isNomCol était armé avec ID_EVT or le tri sur preparerInserer    */
/* ou preparermodifier déclenche un itemfocuschanged                */
/*------------------------------------------------------------------*/
	idw_wDetailFF.isNomCol = ""

/*------------------------------------------------------------------*/
/* Toutes les autres zones sont accessibles.                        */
/*------------------------------------------------------------------*/
	idw_wDetailFF.Uf_Proteger ( { "DTE_DET_DATE", "HEU_DET", "NUM_CARTE", "LIB_DET", "ALT_COUR", "MT_PREJ", "ID_I_REG", &
											"ALT_SSUI", "COD_MOT_SSUI", "ALT_ATT", "ALT_BLOC", "MT_VAL_ACHAT", "DTE_FACTURE", "NUM_FACTURE" }, "0" )

/*------------------------------------------------------------------*/
/* Le 21/04/1999. Modif. pour la couverture UF des autres cartes.   */
/*------------------------------------------------------------------*/
	lIdEvt = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	If	( lIdEvt >= 706 And lIdEvt <= 709 ) Or ( lIdEvt >= 716 And lIdEvt <= 719 )	Then
		idw_wDetailFF.Uf_Proteger ( { "ID_TYPE_CARTE" }, "0" )
	Else
		idw_wDetailFF.Uf_Proteger ( { "ID_TYPE_CARTE" }, "1" )
	End If

End If

/*------------------------------------------------------------------*/
/* #1 JFF 30/10/2003                                                */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 9 )

If lDeb > 0 Then
	idw_wDetailFF.Modify ( "mt_val_achat.visible=1 mt_val_achat_t.visible=1 " )
Else 
	idw_wDetailFF.Modify ( "mt_val_achat.visible=0 mt_val_achat_t.visible=0 " )
End If

// #2
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 41 )
If lDeb > 0 Then
	idw_wDetailFF.Modify ( "mt_val_publique.visible=1 mt_val_publique_t.visible=1 " )
Else 
	idw_wDetailFF.Modify ( "mt_val_publique.visible=0 mt_val_publique_t.visible=0 " )
End If


If bCasto Then
	idw_wDetailFF.Modify ( "mt_val_achat_t.Text= 'Montant en " + stGlb.smonnaiesymboledesire + " de la Qté'" ) //[SUISSE].LOT3

	Choose Case idw_wDetailFF.GetItemNumber ( 1, "ID_GTI")
		Case 11, 27
			idw_wDetailFF.Modify ( "mt_prej_t.Text= 'Mt Fact. Mensuelle~n~rCastorama'" )
		Case Else
			idw_wDetailFF.Modify ( "mt_prej_t.Text= 'Mt Préjudice'" )
	End CHoose 

End If

// [VDoc5059]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 178 )
If lDeb > 0 Then
	idw_wDetailFF.Modify("mt_prej_t.Text='Surconsommation'")
End if

// [DT158]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 287 )
If lDeb > 0 and (not uf_getautorisation( 208 )) Then // [VDoc18971]
	if idw_wdivsin.Find("UPPER(nom_zone)='MT_VAL_ACHAT_ADH'",1, idw_wdivsin.RowCount( ) ) > 0 Then
		idw_wDetailFF.uf_proteger( {"MT_VAL_ACHAT"}, "1")
		icbValAchDef.enabled=false
	End if
End if

end subroutine

private subroutine uf_tb_AltReg ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Tb_AltReg (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 17:35:30
//* Libellé			: 
//* Commentaires	: Gestion des TabOrder pour les zones ALT_REG, MT_PLAF
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

If	idw_wDetailFF.GetItemString ( 1, "ALT_REG" ) = "O"	Then
	idw_wDetailFF.Uf_Proteger ( { "MT_PLAF" }, "0" )
Else
	idw_wDetailFF.Uf_Proteger ( { "MT_PLAF" } , "1" )
End If


end subroutine

private subroutine uf_zn_libdet ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_LibDet (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libellé			: 
//* Commentaires	: Controle de LIB_DET
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sVal, sLibDet

sVal = idw_wDetailFF.GetText ()

/*------------------------------------------------------------------*/
/* Il faut remettre le libellé à NUL car on n'utilise pas le        */
/* principe de l'ancêtre U_DataWindow avec iiCarNul. (Impossible à  */
/* faire puisqu'il faut s'occuper de la zone ALT_COUR)              */
/*------------------------------------------------------------------*/
If	IsNull ( sVal ) Or sVal = ""	Then
	idw_wDetailFF.SetItem ( 1, "LIB_DET", stNul.str )
	idw_wDetailFF.SetItem ( 1, "ALT_COUR", "N" )
Else
/*------------------------------------------------------------------*/
/* Si on vient 'ajouter' des caractères au libellé, on vérifie si   */
/* la personne voulait déjà faire apparaître ce libellé sur le      */
/* courrier.                                                        */
/*------------------------------------------------------------------*/
	sLibDet = idw_wDetailFF.GetItemString ( 1, "LIB_DET" )
	If	IsNull ( sLibDet ) Or sLibDet = ""	Then
		idw_wDetailFF.SetItem ( 1, "ALT_COUR", "O" )
	End If
End If

end subroutine

private subroutine uf_controlersaisie (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerSaisie (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Contrôle de saisie du détail
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF		09/05/2006 DCMP060324
//* #2    MADM    06/07/2006 DCMP 060472 FNAC Suissse-Belgique permettre le règlement à 0 euros sur option 57   
//* #3 	 PHG		30/05/07 [DCMP070284] Gestion des Refus automatique pour la PGC
//* #4    JFF     04/06/2007  [DCMP070163-070164-070248-070318] Gestion Prise en charge
//* #5    JFF     28/01/2008  [DCMP080028]
//* #6	 JFF	   20/10/2008	[FNAC_PROD_ECH_TECH]
//* #7	FPI	10/02/2010	[CASTO_SWAP] Contrôle de la zone "ref_article_casto" propre à Casto
//* #8	FPI	26/02/2010	[20100226.FPI] Correction colonne en erreur
//			FPI	18/02/2011	[VDoc3233] Modif du message pour date du détail
//			FPI	07/09/2011	[VDoc5257]
//       JFF   24/01/2012  [CONFO][CUISINE][PC680]
//		FPI	14/12/2015	[CTL_INTER_PC_REFUS]
//*-----------------------------------------------------------------

String sCol [ 1 ], sErr [ 1 ], sVal [ 1 ]
String 		sNouvelleLigne, sText, sPos, sOng, sAltReclame, sHeure, sRech, sAltAtt, sIdTypeCarte
Long 			lCpt, lNbrCol, lChoixDw, lTotPiece, lIdI, lIdPce, lTotRefus 
Long  		lLigPce, lLigRef, lDeb, lFin, lIdGti, lIdEvt, lRow
Time			tTime
Boolean		bRazIdIReg, bValPubliqueOblig, bConfo, bVal
Boolean 		bCtlCasto	// #7
Decimal{2}	dcMtVal // #1



sNouvelleLigne		= "~r~n"
lNbrCol				= UpperBound ( sCol )
sPos					= ""
sOng					= "01"
sText					= sNouvelleLigne

lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
lIdEvt = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
stMessage.sVar[1] = ""

//* #6 [FNAC_PROD_ECH_TECH]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 107 )
bValPubliqueOblig = lDeb > 0

// [CONFO][CUISINE][PC680]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 207 )
bConfo = lDeb > 0

/*------------------------------------------------------------------*/
/* Cette variable permet de déterminer au retour de la fonction     */
/* (Wf_ControlerSaisie) on se positionne sur Dw_1 ou si arme        */
/* idwControle.                                                     */
/* Si lChoixDw = 0 -> dw_1                                          */
/* Si lChoixDw = 1 -> On utilisera idwControle, il faudra armer     */
/* stPass_dwNorm[1].                                                */
/*------------------------------------------------------------------*/
lChoixDw				= 0

/*------------------------------------------------------------------*/
/* On transforme toutes les chaines vides en NULL avant de          */
/* commencer.                                                       */
/*------------------------------------------------------------------*/
Uf_Gestion_Str2Nul ()

sCol[ 1 ] = "ID_EVT"

sErr[ 1 ] = " - Le code événement"

/*------------------------------------------------------------------*/
/* Si ALT_SSUI est positionné à OUI, il faut oblogatoirement avoir  */
/* un COD_MOT_SSUI renseigné, mais différent de 0.                  */
/*------------------------------------------------------------------*/
If	idw_wDetailFF.GetItemString ( 1, "ALT_SSUI" ) = "O" And  &
	( idw_wDetailFF.GetItemNumber ( 1, "COD_MOT_SSUI" ) = 0 Or IsNull ( idw_wDetailFF.GetItemNumber ( 1, "COD_MOT_SSUI" ) ) ) Then
	sPos = "COD_MOT_SSUI"
	sText = sText + " - Le motif du sans suite" + sNouvelleLigne

	stMessage.sVar[1] 	= sText
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "GENE001"
End If

/*------------------------------------------------------------------*/
/* Si l'heure du détail est positionnée mais que la date est        */
/* vide, il faut interdire la saisie.                               */
/*------------------------------------------------------------------*/
sHeure = idw_wDetailFF.GetItemString ( 1, "HEU_DET" )
If	IsNull ( idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" ) ) And ( sHeure <> "" Or Not IsNull ( sHeure ) ) Then
	sPos = "DTE_DET_DATE"
	sText = sText + " - La date du détail (Si l'heure est présente)" + sNouvelleLigne

	stMessage.sVar[1] 	= sText
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "GENE001"

Else
/*------------------------------------------------------------------*/
/* Dans le cas contraire, on positionne la date du détail au bon    */
/* format.                                                          */
/*------------------------------------------------------------------*/
	If IsNull ( sHeure ) Or sHeure = "" Then
		tTime = 00:00:00
	Else
		tTime = Time ( Left ( sHeure, 2 ) + ":" + Right ( sHeure, 2 ) )
	End If
	idw_wDetailFF.SetItem ( 1, "DTE_DET", DateTime ( idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" ), tTime ) )
End If

/*------------------------------------------------------------------*/
/* Toutes les pièces réclamées doivent avoir un interlocuteur.      */
/*------------------------------------------------------------------*/
If	sPos = "" Then
	lTotPiece = iuoTagPiece.dw_Trt.RowCount ()
	For	lCpt = 1 To lTotPiece
			sAltReclame = iuoTagPiece.dw_Trt.GetItemString ( lCpt, "ALT_RECLAME" )
			lIdI			= iuoTagPiece.dw_Trt.GetItemNumber ( lCpt, "ID_I" )
			If	sAltReclame = "O" And IsNull ( lIdI ) Then
				lIdPce = iuoTagPiece.dw_Trt.GetItemNumber ( lCpt, "ID_PCE" ) 

				iuoTagPiece.dw_Trt.SetRow ( lCpt )
				sText				= sText + " - L'interlocuteur pour la pièce " + String ( lIdPce ) + sNouvelleLigne

				stMessage.sVar[1] 	= sText
				stMessage.bErreurG	= TRUE
				stMessage.sCode		= "GENE001"

				sOng				= "02"
				sPos				= "ID_I"
				lChoixDw			= 1
				astPass.dwNorm[ 1 ] = iuoTagPiece.dw_Trt
				Exit
			End If
			
			// [CTL_INTER_PC_REFUS]
			lIdI = iuoTagPiece.dw_Trt.GetItemNumber(lCpt,"ID_I")
			If iuoTagPiece.dw_Trt.GetItemString(lCpt,"ALT_RECLAME") = "O" Then
				sVal[1]=idw_lstinter.GetItemString( idw_lstinter.Find("ID_I = " + String(lIdI),1,idw_lstinter.RowCount( )), "COD_INTER")
				If sVal[1]="L" or sVal[1]="F" Then
					stMessage.bErreurG	= FALSE
					stMessage.sCode		= "WGAR411"
					sOng				= "02"
					sPos	= "ID_I"
					lChoixDw			= 1
					astPass.dwNorm[ 1 ] = iuoTagPiece.dw_Trt
					exit
				End if
			End if
			// :[CTL_INTER_PC_REFUS]
	Next
End If

/*------------------------------------------------------------------*/
/* S'il existe des PIECES et des REFUS OPERATEURS de cochés, en     */
/* même temps, on demande au gestionnaire de faire quelque chose.   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* S'il existe des PIECES ou des REFUS OPERATEURS de cochés, et     */
/* que l'opérateur positionne le dossier en ATTENTE, on lui         */
/* demande de faire quelque chose.                                  */
/*------------------------------------------------------------------*/
If	sPos = "" Then
	lTotPiece	= iuoTagPiece.dw_Trt.RowCount ()
	sRech			= "ALT_RECLAME = 'O'"
	lLigPce		= iuoTagPiece.dw_Trt.Find ( sRech, 1, lTotPiece )

	lTotRefus	= iuoTagRefus.dw_Trt.RowCount ()
	sRech			= "ALT_OPE = 'O'"
	lLigRef		= iuoTagRefus.dw_Trt.Find ( sRech, 1, lTotRefus )

	If	lLigPce > 0 And lLigRef > 0 Then
		sPos = "LIB_DET"

		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "WDET170"
	End If

	If	sPos = "" Then
		sAltAtt = idw_wDetailFF.GetItemString ( 1, "ALT_ATT" )
		If	sAltAtt = "O" And ( lLigPce > 0 Or lLigRef > 0 ) Then
			sPos = "LIB_DET"

			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "WDET180"
		End If

	End If
End If

If	sPos = "" Then
/*------------------------------------------------------------------*/
/* on vérifie simplement les colonnes obligatoires.                 */
/* ID_EVT                                                           */
/*------------------------------------------------------------------*/
	For	lCpt = 1 To lNbrCol
			sVal[ lCpt ] = String ( idw_wDetailFF.GetItemNumber ( 1, sCol[ lCpt ] ) )
	Next


	For	lCpt = 1 To lNbrCol
			If IsNull ( sVal[ lCpt ] ) or sVal[ lCpt ] = ""	Then

				If sPos = "" Then sPos = sCol[ lCpt ]
				sText = sText + sErr[ lCpt ] + sNouvelleLigne

			End If
	Next
	If	sPos <> "" Then
			stMessage.sVar[1] 	= sText
			stMessage.bErreurG	= TRUE
			stMessage.sCode		= "GENE001"
	Else
/*------------------------------------------------------------------*/
/* Le 10/12/1998                                                    */
/* Si le détail est SANS SUITE, on force la zone MT_PREJ à zéro.    */
/* Sinon, le calcul sur MT_TOT_PREJ de la garantie sera faux.       */
/*------------------------------------------------------------------*/
		If	idw_wDetailFF.GetItemString ( 1, "ALT_SSUI" ) = "O"	Then
			idw_wDetailFF.SetItem ( 1, "MT_PREJ", 0.00 )
		End If
/*------------------------------------------------------------------*/
/* Le 10/12/1998                                                    */
/* Si la zone MT_PREJ est à 0.00, on positionne la zone ID_I_REG à  */
/* NULL.                                                            */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* La zone ID_I_REG doit être mise à NULL si MT_PREJ est à zéro,    */
/* sauf dans le cas des produits SFR et uniquement dans le cas      */
/* d'une garantie PANNE (18).                                       */
/*------------------------------------------------------------------*/
		bRazIdIReg = ( idw_wDetailFF.GetItemNumber ( 1, "MT_PREJ" ) = 0 )
		If ( ilCodTel = 21 And idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) = 18	) And bRazIdIReg Then bRazIdIReg = FALSE
		
		/*------------------------------------------------------------------*/
	   /* #2 MADM 06/07/2006 DCMP 060472		                             */
	   /*------------------------------------------------------------------*/
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 57 )
		If lDeb > 0 Then 
			
		  For lCpt = lDeb To lFin	
			If idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) = lIdGti And idw_DetPro.GetItemNumber ( lCpt, "VAL_NUM" ) = lIdEvt Then 
			   bRazIdIReg = FALSE
				Exit
			End If
		  Next	
		End If
		/*------------------------------------------------------------------*/
		/* Fin MADM																			  */
		/*------------------------------------------------------------------*/

		If	bRazIdIReg	Then
			idw_wDetailFF.SetItem ( 1, "ID_I_REG", stNul.dcm )
		End If
	End If
End If

If	sPos = ""	Then
	sIdTypeCarte = idw_wDetailFF.GetItemString ( 1, "ID_TYPE_CARTE" )
	If	IsNull ( sIdTypeCarte )	Then

		sPos						= "ID_TYPE_CARTE"
		sText 					= sText + " - Le type de la carte" + sNouvelleLigne

		stMessage.sCode		= "GENE001"
		stMessage.bErreurG	= TRUE
		stMessage.sVar[1] 	= sText

	End If
End If

/*------------------------------------------------------------------*/
/* DCMP 050355/ JFF le 12/09/2005 : si Opt -DP/38, on DTE_DET       */
/* Obligatoire.												                 */
/*------------------------------------------------------------------*/
If	sPos = "" And idw_wDetailFF.GetItemString ( 1, "ALT_BLOC" ) <> "O" Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 38 )
	If lDeb > 0 Then 
		If	IsNull ( idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" )	) Then

			bVal = False
			If bConfo Then 
				Choose Case lIdEvt
					Case 1317, 1083, 934
						// On ne controle pas
						bVal = True
				End Choose
			End If 
			
			If Not bVal Then
				If sPos = "" Then sPos = "DTE_DET_DATE"
				// sText = sText + " - La date de d'achat" + sNouvelleLigne
				sText = sText + " - La date du détail" + sNouvelleLigne// 	[VDoc3233] 
				
				stMessage.sCode		= "GENE001"
				stMessage.bErreurG	= TRUE
				stMessage.sVar[1] 	= sText
			End If
		End If
	End IF
	
	// #1
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 47 )
	If lDeb > 0 Then 
		dcMtVal = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" )
		If	IsNull ( dcMtVal ) Then dcMtVal = 0
		If dcMtVal = 0 Then
			If sPos = "" Then sPos = "MT_VAL_ACHAT"
			sText = sText + " - La valeur d'achat d'origine" + sNouvelleLigne
	
			stMessage.sCode		= "GENE001"
			stMessage.bErreurG	= TRUE
			stMessage.sVar[1] 	= sText
		End If
	End If
	// Fin #1


	// #5 	
	// #6 [FNAC_PROD_ECH_TECH] (test sur bValPubliqueOblig )
	If bValPubliqueOblig And isTypeTrt = "S" And This.uf_GestOng_Divers_Trouver ("PEC" ) <> "O" Then
		dcMtVal = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_PUBLIQUE" )
		If	IsNull ( dcMtVal ) Then dcMtVal = 0
		
		If Not ( lIdEvt = 1083 And idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" ) <= 0 ) And dcMtVal = 0 Then
			If sPos = "" Then sPos = "MT_VAL_PUBLIQUE"
			sText = sText + " - La valeur publique" + sNouvelleLigne
	
			stMessage.sCode		= "GENE001"
			stMessage.bErreurG	= TRUE
			stMessage.sVar[1] 	= sText
		End If
	End If	
	// :#5	
	
End If

/*------------------------------------------------------------------*/
/* #3 [DCMP070284] On controle les données pour la Prologantion     */
/* Garantie Constructeur                                            */
/*------------------------------------------------------------------*/
If	sPos = "" And idw_wDetailFF.GetItemString ( 1, "ALT_BLOC" ) <> "O" Then
	If idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" ) > 0 OR This.uf_GestOng_Divers_Trouver ("PEC" ) = "O" Then
		This.uf_controlergestion_donnee_pgc( lIdGti, lIdEvt, sPos, sText)
			If sPos <> "" Then 
				stMessage.sCode		= "GENE001"
				stMessage.bErreurG	= TRUE
				stMessage.sVar[1] 	= sText
			End If
	End IF
End If

// #7 - 	[CASTO_SWAP] 
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 43 ) // Casto
If lDeb > 0 and lIdGti = 18 Then
	sVal[1]= This.uf_GestOng_Divers_Trouver ("ref_article_casto" )

	If isnull(sVal[1]) Then sVal[1]=""
	sVal[1]=Trim(sVal[1])
	
	if sPos = "" Then stMessage.sVar[1] =""
	
	if sVal[1]="" Then
		stMessage.sCode		= "GENE001"
		stMessage.bErreurG	= TRUE
		stMessage.sVar[1] 	+="- la référence de l'article Castorama" + sNouvelleLigne
		// #8 - [20100226.FPI]
		If sPos = "" Then
			sOng="04"
			sPos = "VAL_CAR"		
			lChoixDw=1
			astPass.dwNorm[ 1 ] =idw_wdivdet
		End if
		//		sPos = "ALT_BLOC"
		// Fin #8
	End if
	
	If sPos = "" and Len(sVal[1]) > 13 Then
		stMessage.sCode		= "WDET572"
		stMessage.bErreurG	= FALSE
		sOng="04"
		// #8 - [20100226.FPI]
//		sPos = "ALT_BLOC"
		sPos = "VAL_CAR"		
		lChoixDw=1
		astPass.dwNorm[ 1 ] =idw_wdivdet
		// Fin #8
	End if
	
	If sPos = "" and not isNumber(sVal[1]) Then
		stMessage.sCode		= "GENE002"
		stMessage.bErreurG	= TRUE
		stMessage.sVar[1]  ="référence de l'article Castorama"
		// #8 - [20100226.FPI]
//		sPos = "ALT_BLOC"
		sPos = "VAL_CAR"		
		sOng="04"
		lChoixDw=1
		astPass.dwNorm[ 1 ] =idw_wdivdet
		// Fin #8
	End if
End if
// Fin #7

// [VDoc5059]
// [VDoc5257] - mise en commentaire
/*
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 178 )
If lDeb > 0  Then
	dcMtVal = idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" ) 
	
	If isnull(dcMtVal) or dcMtVal=0 Then 
		stMessage.sCode		= "GENE001"
		stMessage.bErreurG	= TRUE
		stMessage.sVar[1] 	+="- la surconsommation" + sNouvelleLigne
		If sPos = "" Then
			sOng="04"
			sPos = "VAL_MT"		
			lChoixDw=1
			astPass.dwNorm[ 1 ] =idw_wdivdet
		End if
	End if
End if*/
// :[VDoc5059]

/*------------------------------------------------------------------*/
/* Affichage de la chaîne correspondant au message d'erreur         */
/*------------------------------------------------------------------*/
If	sPos <> "" Then

	stMessage.sTitre		= "Contrôle de saisie du détail"
	stMessage.Icon			= Information!

	f_Message ( stMessage )

	If	Not IsNull ( sOng ) And iuoOng.Uf_RecupererOngletCourant () <> sOng Then
		iuoOng.Uf_ChangerOnglet ( sOng )
	End If

End If

// #4
If	sPos = "" And idw_wDetailFF.GetItemString ( 1, "ALT_BLOC" ) <> "O" Then
	lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'PEC'", 1, idw_wDivDet.RowCount () )
	If lRow > 0 Then
		If idw_wDivDet.GetItemString ( lRow, "VAL_LST_CAR" ) <> "O" And &
			idw_wDetailFF.GetItemString ( 1, "ALT_ATT" ) = "O" Then

			stMessage.sCode		= "WDET531"
			stMessage.bErreurG	= FALSE
			stMessage.bouton     = YesNo!
			
			If F_Message ( stMessage ) = 2 Then
				sPos = "LIB_DET"
			End If

			stMessage.sCode		= "GENE001"
			stMessage.bErreurG	= TRUE
			stMessage.bouton     = Ok!
	
		End If
	End If 
End If
// :#4
	
		
astPass.sTab [ 1 ] = sPos
astPass.lTab [ 1 ] = lChoixDw

end subroutine

private subroutine uf_controlergestion (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerGestion (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Contrôle de gestion d'un détail
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    06/11/2003  Ajout d'un contrôle sur la zone MT_VAL_ACHAT
//* #2	 JFF	  16/07/2004  Gestion onglet divers.
//* #3	 JCA		13/11/2006	DCMP 060826	- controle réglement fournisseur
//* #4	 JCA		13/02/2007	DCMP 060928	- controle pour la garantie clef (id_gti = 1) tout produit
//* #5	 JCA		01/06/2007	DCMP 070304	- possibilité de mettre sans suite les details de garantie pour les produits avec l'option 75
//* #6    JFF     04/06/2007  [DCMP070163-070164-070248-070318] Gestion Prise en charge
//* #7    JFF     04/09/2007  [DCMP070431]
//* #8	 PHG		05/09/2007	[DCMP070510] MEssage d'alerte pour Role 508 Si plafonds
//* #9	 PHG		12/12/2007	[O2M]	: Controle de Gestion pour Flux O2M sur le detail correspondant
//* #10	 FPI		05/03/2009	Contrôle date de facturation <= date du jour
//*       JFF     12/04/2010  [O2M_DIAG_NOMADE].Lot2.JFF.[20100412131826877]
//*       JFF     27/04/2010  [O2M_DIAG_NOMADE].Lot2.JFF.[20100427143447010]
//*		 JFF		06/05/2010  [20100506164646807]
//*		 JFF		07/05/2010  [DCMP100331]
//*		 FPI		16/06/2010  [DCMP100403] 
//* 		 JFF     04/11/2010  [PC301].[LOT2]
//*       JFF     29/11/2010  [PC474]
//*       JFF     27/07/2011  [PLAF_REF]
//*		 JFF     27/10/2011  [VDOC5453]
//        JFF     24/01/2012  [CONFO][CUISINE][PC680]
// 		 JFF     19/06/2012  [CONFO][NV_PROCESS]
//        JFF     27/08/2012  [MANTIS4237]
//			 JFF     19/09/2012  [MANTIS4026]
//	       JFF     04/10/2012  [ITSM131178][PLAF_REF]
// 		 JFF	   29/01/2013  [PC801_MANTIS6481]
//		FPI	27/02/2013	 [ITSM147960] Epuration de zones de l'onglet Divers
//		FPI	03/04/2013	[REG_FACTU_DIAG] Contrôle sur le règlement de diagnostic BLC
//		FPI	18/04/2013	[VDoc10924] Ajout ctrl valeur d'achat différent
//		FPI 	15/05/2013	[PC926]
//    JFF   06/06/2013  [VDOC11003] ajout AND STATUS_GC NOT IN ( 2, 21 )
//		FPI	11/06/2013	[PC845]
//	   FPI	14/08/2013	[DT058]
//    JFF   27/11/2013  [ITSM18204]
//		FPI	26/12/2013	[PC864_1] Mantis 8099 - règlement du détail à 0
//    JFF   13/01/2014  [PM246]
//    JFF   20/02/2014  [VDOC13754]
//    JFF   01/07/2014  [PM246-2_GPS_OV3]
//    JFF   11/08/2014  [DT94]
//    JFF   03/09/2014  [DT92_FACTU_CASTO]
//    JFF   03/10/2014  [VDOC15472]
//		FPI	04/03/2015	[VDoc16817]
//    JFF   21/05/2015  [VDOC17414]
//		FPI	09/06/2015	[REGL_LBE]
//    JFF   15/06/2015  [DT154]
//    JFF   23/06/2015  [ITSM301945]
//    JFF  	24/09/2015 	[PC13442][ITSM326391]
//    JFF   28/09/2015  [PM319-1]
//		FPI	14/12/2015	[CTL_INTER_PC_REFUS]
//    JFF   19/04/2016  [DT209]
//    JFF   07/06/2016  [DT227]
//    JFF   17/05/2016  [PM280-2][MANTIS21220]
//    JFF   17/08/2016  [VDOC21471]
//    JFF   17/08/2016  [VDOC21595]
//    JFF   22/09/2016  [VDOC21796]
//    JFF   01/08/2017  [DT288-1][MODIF_CHRISTINE]
//    JFF   04/08/2017  [DT288-1][MODIF_CHRISTINE][VDOC24372]
// 	JFF   29/08/2017  [DT288-3_LOT1_2EME_VS]
// 	JFF   16/04/2018  [ITSM529150]
//    JFF   25/04/2018  [VDOC26046]
//    JFF   22/08/2018  [DT344]
//    JFF   01/10/2018  [PM445-1]
//    JFF   15/10/2018 	[DT391]
// 	JFF	06/11/2018  [DT391][MANTIS29427]
//    JFF   26/11/2018  [PC874_2_V1]
//    JFF   03/12/2018  [VDOC27314]
//    JFF   24/06/2019  [PC192235]
//    JFF   02/09/2019  [DT424]
//    JFF   07/08/2019  [PM462-1][V3]
//    JFF   15/01/2020  [VDOC28827]/[VDOC28866]
//    JFF   22/12/2021  [RS1472_DT432_BRED]
//    JFF   05/08/2024  [MCO602_PNEU]
//    JFF   29/08/2024  [CAR_SPEC_LCL]
//    JFF   06/09/2024  [KSV516]
//*-----------------------------------------------------------------
String sPos, sOng, sPosPec, sFiltreOrig, sVal1, sVal 
Long lTotwRefus, lCpt, lDeb, lFin, lCptDetPro, lVal, lIdProd, lTrouve, lVal1, lValOrig
n_cst_string lnvPFCString
DateTime dtDt1, dtDt2, dtDt3, dtCreeLe
string sImei // #5
integer iEtat, iRowcount, iIdi // #5
Long lCodTel // #5
Date dDteFact // #10
Boolean bBitMap, bDetailBloque, bPresence_ARecupARecycler, bMep_O2M_DIAG_NOMADE, bForcagePec, bShunt, bAltReg
Long lIdEvt // [O2M_DIAG_NOMADE].Lot2.JFF.[20100412131826877]
Decimal {7} dcMtValAchat // [O2M_DIAG_NOMADE].Lot2.JFF.[20100412131826877]
Decimal {2} dcMtValPublique, dcMtFran
Decimal {2} dcMtPec // [VDOC26046]
Boolean bPresencePRS_FrnECO // [DCMP100331]
Boolean bDetailEnAttente // [MANTIS4237]
Long lRow // [DCMP100331]
Long lIdGti // [DCMP100403] 
Decimal dcMtPrej 
String sFiltre, sLibEvt, sMarqPortSin
Long lRow1, lRowDD
Int iIdIReg  
DataWindowChild dwChild // [VDOC16817]
Long lIdDetail, lTot 
String sTabSpl [] // [DT344]
Boolean bSC2FoyerNomade // [PC192235]
Boolean bFranchiseSelectra, bVarianteSelectra2024  // [PC202553]  [KSV516]
String sRech
Long lLig
Decimal {2} dcMtPlafAReg 

stMessage.sTitre		= "Contrôle de gestion d'un détail"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.sCode		= "" // #6

sPos						= ""
bBitMap					= False
ibPlafRef				= False // [PLAF_REF]
islCodeRefPlafNum		= "" // [PLAF_REF]
ibPlafNumeraire 		= False // [PLAF_REF]

lIdProd = idw_wSin.GetItemNumber ( 1, "ID_PROD" )
lIdEvt = idw_wDetailFF.getitemnumber(1,"ID_EVT") 	 // [VDOC26046]
lIdDetail = idw_wDetailFF.getitemnumber(1,"ID_DETAIL") 	 // [VDOC26046]
lIdGti = idw_wDetailFF.getitemnumber(1,"ID_GTI") 	 // [CONFO][NV_PROCESS]

dtCreeLe = idw_Wsin.GetItemDateTime ( 1, "CREE_LE" ) // [DT227]
sMarqPortSin = Upper( idw_Wsin.GetItemString ( 1, "MARQ_PORT" ) )

// [PM246-2_GPS_OV3]
bAltReg = idw_wDetailFF.GetItemString ( 1, "ALT_REG" ) = "O"

/*------------------------------------------------------------------*/
/* On positionne la zone ALT_VALIDE du détail à OUI.                */
/*------------------------------------------------------------------*/
idw_wDetailFF.SetItem ( 1, "ALT_VALIDE", "O" )
bDetailBloque = idw_wDetailFF.GetItemString ( 1, "ALT_BLOC" ) = "O"

// [MANTIS4237]
bDetailEnAttente = idw_wDetailFF.GetItemString ( 1, "ALT_ATT" ) = "O"

// [O2M_DIAG_NOMADE].Lot2.JFF.[20100412131826877]
lIdEvt = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
sLibEvt  = Upper ( idw_wDetailFF.Describe ( "Evaluate ('LookUpDisplay ( ID_EVT )', 1)" ) )
iIdIReg  = idw_wDetailFF.GetItemNumber ( 1, "ID_I_REG" )

dcMtPrej = idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" ) // [PLAF_REF]

dcMtValAchat = idw_wDetailFF.GetitemDecimal( 1, "MT_VAL_ACHAT")
dcMtValPublique = idw_wDetailFF.GetitemDecimal( 1, "MT_VAL_PUBLIQUE")
bPresence_ARecupARecycler = idw_LstCmdeSin.Find ( "ID_FOUR = 'O2M' AND ID_REF_FOUR = 'A_RECUP_A_RECYCLER' AND COD_ETAT <> 'ANN'", 1, idw_LstCmdeSin.Rowcount () ) + &
								    idw_LstCmdeSin.Find ( "ID_FOUR = 'O2M' AND ID_REF_FOUR = 'A_RECUP_A_RECYCLER' AND COD_ETAT <> 'ANN'", 1, idw_LstCmdeSin.Rowcount () ) > 0 
bMep_O2M_DIAG_NOMADE = TRUE
bForcagePec = idw_wDivDet.Find ( "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + &
							 			 " AND ID_DETAIL = " +  String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
										 " AND UPPER ( NOM_ZONE ) = 'ALT_PEC' " + &
										 " AND UPPER ( VAL_LST_CAR ) = 'O'" &
									  , 1, idw_wDivDet.RowCount () ) > 0 
// :[O2M_DIAG_NOMADE].Lot2.JFF.[20100412131826877]

bPresencePRS_FrnECO = idw_LstCmdeSin.Find ( &
"ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + &
" AND ID_DETAIL = " +  String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
" AND ID_FOUR = 'ECO' AND ID_TYP_ART = 'PRS' AND COD_ETAT <> 'ANN'", 1, idw_LstCmdeSin.Rowcount () ) > 0

// [CAR_SPEC_LCL]
If F_CLE_A_TRUE ( "CAR_SPEC_LCL" ) Then
	sVal = idw_wDetailFF.GetItemString ( 1, "LIB_DET" ) 
	sVal = This.uf_EpureZone ( sVal )
	idw_wDetailFF.SetItem ( 1, "LIB_DET", sVal ) 
End If 

// [DT209]
If F_CLE_A_TRUE ( "DT209" ) Then
	If lIdEvt = 1424 Then
		idw_wDetailFF.SetItem ( 1, "MT_PREJ", 0 )
		idw_wDetailFF.SetItem ( 1, "ID_I_REG", stNul.lng )
		idw_wDetailFF.SetItem ( 1, "ALT_SSUI", "O" )
		idw_wDetailFF.SetItem ( 1, "ALT_ATT", "N" )		
		idw_wDetailFF.SetItem ( 1, "COD_MOT_SSUI", 12 )
	End If 
End If

// [DT288-3_LOT1_2EME_VS]
If lIdEvt = 1439 Then	
	idw_wDetailFF.SetItem ( 1, "MT_PREJ", 0 )
	idw_wDetailFF.SetItem ( 1, "ID_I_REG", stNul.lng )
	idw_wDetailFF.SetItem ( 1, "ALT_SSUI", "O" )
	idw_wDetailFF.SetItem ( 1, "ALT_ATT", "N" )		
	idw_wDetailFF.SetItem ( 1, "COD_MOT_SSUI", 2 )
End If	

/*------------------------------------------------------------------*/
/* Si le dossier n'est pas bloqué, on déclenche la gestion des      */
/* Refus.                                                           */
/*------------------------------------------------------------------*/
If	Not bDetailBloque Then

	// [PM319-1]
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 150 )
	If lDeb > 0 Then
		// [PM319-1]				
		sVal = lnvPFCString.of_getkeyvalue ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")

		If sVal = "PRIX_ORANGE" And Left ( Upper( sLibEvt ) , 4 )  = "REMB" and iIdIReg = 0 Then
			sVal = This.uf_GestOng_Divers_Trouver ("VAL_PUB_ORANGE" )
			If dec ( sVal ) > 0 And dec ( sVal ) < dcMtValPublique Then
				idw_wDetailFF.SetItem ( 1, "MT_VAL_PUBLIQUE", Dec ( sVal ) )
				
				lRowDD  = idw_wDivDet.Find ( "NOM_ZONE = 'val_pub_orange_utilisee'" , 1, idw_wDivDet.RowCount () )				
				If lRowDD  <= 0 Then
					lRowDD  = idw_wDivDet.InsertRow (0)
				
					idw_wDivDet.SetItem ( lRowDD , "ID_SIN", idw_wDetailFF.GetItemNumber ( 1, "ID_SIN" ) )
					idw_wDivDet.SetItem ( lRowDD , "ID_GTI", idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )	
					idw_wDivDet.SetItem ( lRowDD , "ID_DETAIL", idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )		 
					idw_wDivDet.SetItem ( lRowDD , "NOM_ZONE", "val_pub_orange_utilisee" )
					idw_wDivDet.SetItem ( lRowDD , "LIB_LABEL", "Valeur publique Orange Utilisée" )
					idw_wDivDet.SetItem ( lRowDD , "ID_TYP_LISTE", "-XX" )
					idw_wDivDet.SetItem ( lRowDD , "ALT_LISTE_CODECAR", "N")
					idw_wDivDet.SetItem ( lRowDD , "ID_TYP_ZONE", "X" )
					idw_wDivDet.SetItem ( lRowDD , "ALT_OBLIG", "N" )
					idw_wDivDet.SetItem ( lRowDD , "ALT_PROT", "O" )
					idw_wDivDet.SetItem ( lRowDD , "CPT_TRI", 520 )
					idw_wDivDet.SetItem ( lRowDD , "VAL_DTE", stNul.dtm )	// [PI056].20190926
					idw_wDivDet.SetItem ( lRowDD , "VAL_CAR", stNul.str)
					idw_wDivDet.SetItem ( lRowDD , "VAL_NBRE", stNul.lng )
					idw_wDivDet.SetItem ( lRowDD , "VAL_MT", stNul.dcm)
					idw_wDivDet.SetItem ( lRowDD , "ALT_SUPP", "N" )
					idw_wDivDet.SetItem ( lRowDD , "CREE_LE", DateTime ( Today (), Now () ) )
					idw_wDivDet.SetItem ( lRowDD , "MAJ_LE", DateTime ( Today (), Now () ) )
					idw_wDivDet.SetItem ( lRowDD , "MAJ_PAR", stGlb.sCodOper )
	
					lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'VAL_PUB_ORANGE_UTILISEE'", 1, idw_wDivDet.RowCount () )
					If lRow > 0 Then
						This.uf_GestOng_Divers_MajZone ( "VAL_PUB_ORANGE_UTILISEE", lRow, "O" )
					End If 			
				End If				
			End If				
		End IF	
	End If

/*------------------------------------------------------------------*/
/* Modification DBI le 23/09/1998                                   */
/* On calcule la date de 1er uf non plus sur la garantie mais sur   */
/* les détails                                                      */
/* on en a besoin pour calculer le délai 625                        */
/*------------------------------------------------------------------*/

	uf_Calculer_dt_1er_Uf ( )

	If	Not Uf_GestionRefus ()	Then	sPos = "LIB_DET"
End If

/*------------------------------------------------------------------*/
/* A l'issue de la gestion des refus, il faut réinitialiser la      */
/* zone ID_I à NULL pour tous les refus non cochés. En effet si la  */
/* personne fait deux fois CTRL+VAL, on ne touche pas à la zone     */
/* ID_I. Cela n'a aucune importance pour la validation, puisqu'on   */
/* utilise les zones ALT_MAC et ALT_OPE, mais on peut éviter un     */
/* DELETE et un INSERT sur les REFUS.                               */
/*------------------------------------------------------------------*/
If	sPos = "" Then
/*------------------------------------------------------------------*/
/* On détermine le code état du dossier.                            */
/*------------------------------------------------------------------*/
	Uf_Determiner_Etat ( 1 )			// COD_DEC_MAC
	Uf_Determiner_Etat ( 2 )			// COD_DEC_OPE
	sPos = Uf_Determiner_Etat ( 3 )	// COD_ETAT
End If

// #5
sImei = idw_wSin.GetItemString ( 1, "NUM_IMEI_PORT" )
iEtat = idw_wDetailFF.GetItemNumber ( 1, "COD_ETAT" )
iRowcount = idw_LstCmdeDet.RowCount ( )
lCodTel = idw_Produit.GetItemNumber ( 1, "COD_TEL" ) // JFF

// [PM462-1][V3]
/*
If F_CLE_A_TRUE ( "PM462-1" ) Then
	If iEtat = 500 And sPos = "" Then
		This.Uf_ControlerGestion_Franchise_CB_EXTR ( sPos )
	End IF 
End If
*/

if	sPos = "" And isReferentiel = "IFR" And lCodTel > 0 then
	if IsNull( sImei ) and ( iRowcount > 0 or iEtat = 500 ) then
		stMessage.sCode = "WDET520"
		F_Message ( stMessage )
		sPos = "LIB_DET"
	end if	
end if
// #5 - FIN

/*------------------------------------------------------------------*/
/* #2 :                                                             */
/*------------------------------------------------------------------*/
If Not bDetailBloque And sPos = "" Then
	sPos = This.uf_ControlerGestion_OngletDivers ( sOng )
	If sPos <> "" Then
		iUoOng.Uf_ChangerOnglet ( SOng )	
		F_Message ( stMessage )
		If idw_wDivDet.RowCount () > 0 Then idw_wDivDet.SetRow ( 1 )
		idw_wDivDet.SetFocus ()
	End If
	
End If

/*------------------------------------------------------------------*/
/* On calcule maintenant le montant à régler.                       */
/*------------------------------------------------------------------*/
If	sPos = "" Then
	sPos = Uf_Calcul_MontantRegle ()

End If

// [ITSM131178][PLAF_REF]
If	sPos = "" Then
	lTotwRefus = iuoTagRefus.dw_Trt.RowCount ()
	For	lCpt = 1 To lTotwRefus
			If	( iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_OPE" ) = "N" And iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_MAC" ) = "N" ) Then
				iuoTagRefus.dw_Trt.SetItem ( lCpt, "ID_I", stNul.dcm )
			End If
	Next
End If	

If sPos = "" Then
	// [PLAF_REF]
	If ibPlafRef Then
		Uf_Determiner_Etat ( 1 )			// COD_DEC_MAC
		Uf_Determiner_Etat ( 2 )			// COD_DEC_OPE
		sPos = Uf_Determiner_Etat ( 3 )	// COD_ETAT
	End If
End If

/*------------------------------------------------------------------*/
/* On vérifie que les motifs de refus posséde un interlocuteur      */
/* sinon on affiche un message d'avertissement non bloquant.        */
/* Uniquement dans les cas ou le dossier n'est pas bloqué.          */
/*------------------------------------------------------------------*/
If	idw_wDetailFF.GetItemString ( 1, "ALT_BLOC" ) = "N" Then
	lTotwRefus = iuoTagRefus.dw_Trt.RowCount ()
	For	lCpt = 1 To lTotwRefus
			If	( iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_OPE" ) = "O" Or iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_MAC" ) = "O" ) Then
				bBitMap = True
				If	IsNull ( iuoTagRefus.dw_Trt.GetItemNumber ( lCpt, "ID_I" ) ) Then
					// [VDOC13754]
					If Not This.uf_GetAutorisation ( 208 ) Then
						stMessage.sCode		= "WGAR100"
						F_Message ( stMessage )
					End If
					
					Exit
				End If
				
				// [CTL_INTER_PC_REFUS]
				iIdi = iuoTagRefus.dw_Trt.GetItemNumber(lCpt,"ID_I")
				sVal=idw_lstinter.GetItemString( idw_lstinter.Find("ID_I = " + String(iIdi),1,idw_lstinter.RowCount( )), "COD_INTER")
				If sVal="L" or sVal="F" Then
					stMessage.sTitre		= "Contrôle de gestion d'une garantie"
					stMessage.Icon			= Information!
					stMessage.bErreurG	= FALSE
					stMessage.sCode		= "WGAR410"

					F_Message ( stMessage )
					
					iuoOng.Uf_ChangerOnglet ( "03" )
					sPos = "LIB_DET"
					exit
				End if
				// :[CTL_INTER_PC_REFUS]
			End If
	Next

/*------------------------------------------------------------------*/
/* On détermine au passage s'il faut afficher un bitmap dans        */
/* l'onglet des refus.                                              */
/*------------------------------------------------------------------*/
	If	bBitMap	Then
		iuoOng.Uf_ChangerBitmap ( "03", "K:\PB4OBJ\BMP\8_REF.BMP" )
	Else
		iuoOng.Uf_ChangerBitmap ( "03", "" )
	End If
End If

/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
If sPos = "" Then This.Uf_ControlerGestion_Si_Val_Achat ( sPos )
// #6

// [CONFO][CUISINE][PC680]
sPosPec = ""
This.Uf_ControlerGestion_Pec ( sPosPec )

If sPosPec <> "" And sPos = "" Then
	sPos = sPosPec
End If

If Not bDetailBloque And &
	idw_wDetailFF.GetItemNumber ( 1, "COD_ETAT" ) = 100 And &
	idw_wDetailFF.GetItemString ( 1, "ALT_ATT" ) = "O" And &
	sPos = "MT_PREJ" Then

		sPos = This.uf_ControlerGestion_OngletDivers ( sOng )
		If sPos <> "" Then
			iUoOng.Uf_ChangerOnglet ( SOng )	
			F_Message ( stMessage )
			If idw_wDivDet.RowCount () > 0 Then idw_wDivDet.SetRow ( 1 )
			idw_wDivDet.SetFocus ()
		End If		
End If
// :[CONFO][CUISINE][PC680]

// #6
If sPos = "MT_PREJ" And stMessage.sCode = "WDET150" Then
		f_Message ( stMessage )
End If

//* #3
If sPos = "" Then This.Uf_ControlerGestion_208 ( sPos )

//* #4
If sPos = "" Then This.Uf_ControlerGestion_Cle ( sPos )

//* #7
//* #9 [O2M] Controle de Gestion sur Detail concernant flux O2M
If sPos = "" Then Uf_ControlerGestion_O2M  ( sPos )

// [VDOC5453]
If iEtat = 500 Then
	If sPos = "" Then Uf_ControlerGestion_AltRegParam ( sPos )
End If

// #8 [DCMP070510] Message d'alerte si déclenchement de plafond pour le role 208
if uf_getautorisation( 208 ) and idw_wdetailFF.object.alt_plaf[1]="O" Then
		stMessage.sCode = "GENE157"
		stMessage.icon  = Information!
		stMessage.bErreurG = False
		stMessage.bouton = Ok!
		F_Message ( stMessage )
End If

// #10 - Contrôle date de facturation <= date du jour
if uf_getautorisation( 208 ) Then
	dDteFact = Date( idw_wDetailFF.GetItemDateTime ( 1, "DTE_FACTURE" ) ) // [PI056]
	if dDteFact > Today() Then
		stMessage.sCode = "CTRL022"
		stMessage.svar[1]="de facturation"
		stMessage.icon  = StopSign!
		stMessage.bErreurG = False
		stMessage.bouton = Ok!
		F_Message ( stMessage )
		sPos = "DTE_FACTURE"
	end if
End if


// [PC474]
// [O2M_DIAG_NOMADE].Lot2.JFF.[20100427143447010]
//F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 37 )
//
////[O2M_DIAG_NOMADE].Lot2.JFF.[20100412131826877]
//bMep_O2M_DIAG_NOMADE = TRUE
//
//lIdGti = idw_wDetailFF.getitemnumber(1,"ID_GTI") 	 // [DCMP100403] 
//
//If sPos = "" And bMep_O2M_DIAG_NOMADE And lDeb > 0 and lIdGti <> 10 Then  // [DCMP100403] - ajout de lIdGti <>10
//	Choose Case lIdEvt 
//		Case 973, 940
//			If dcMtValAchat >= 600 And Not bPresence_ARecupARecycler And Not bForcagePec Then
//				stMessage.sCode = "COMD620"
//				stMessage.icon  = Information!
//				stMessage.bErreurG = False
//				stMessage.bouton = Ok!
//				F_Message ( stMessage )
//				sPos = "LIB_DET"
//		End If
//	End Choose	
//End IF 
// :[O2M_DIAG_NOMADE].Lot2.JFF.[20100412131826877]
// [PC474]

// [20100506164646807]
If Not uf_GarantieRevision () And iEtat = 500 Then
	stMessage.sCode = "WDET574"
	stMessage.icon  = Information!
	stMessage.bErreurG = False
	stMessage.bouton = Ok!
	F_Message ( stMessage )
	sPos = "LIB_DET"
End If
// [20100506164646807]

// [DCMP100331]
If iEtat = 500 And bPresencePRS_FrnECO Then
	lRow = idw_wDivDet.Find ( "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + &
							 		" AND ID_DETAIL = " +  String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
									" AND UPPER ( NOM_ZONE ) = 'NUM_PRS' ", 1, idw_wDivDet.RowCount () ) 
	
	If lRow > 0 Then
		sVal = This.uf_GestOng_Divers_Trouver ( "NUM_PRS" ) 
		If Trim ( sVal ) = "" Or IsNull ( sVal ) Then
			stMessage.sCode = "WDET576"
			stMessage.icon  = Information!
			stMessage.bErreurG = False
			stMessage.bouton = Ok!
			F_Message ( stMessage )
			sPos = "LIB_DET"
		End If
	End If
	
End If
// :[DCMP100331] 

// [PC301].[LOT2]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 152 )

// [PC864_1]
If lDeb <=0 Then 
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 224 )
End if

If lDeb > 0 Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 57 )
	If lDeb > 0 Then
		For lCpt = lDeb To lFin
			If iEtat <> 500 And idw_DetPro.GetItemNumber ( lCpt, "VAL_NUM" ) = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) Then
				lRow = idw_LstCmdeDet.Find ( "ID_FOUR IN ('CAR', 'CMA') AND ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + &
													  " AND ID_DETAIL = " +  String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
													  " AND COD_ETAT = 'CNV'"  , 1 , idw_LstCmdeDet.RowCount () )					
				If lRow > 0 Then
					stMessage.sCode = "WDET579"
					stMessage.icon  = Information!
					stMessage.bErreurG = False
					stMessage.bouton = Ok!
					F_Message ( stMessage )
					sPos = "LIB_DET"
				End If
			End If
		Next
	End If
End If
// :[PC301].[LOT2]

// [PC845]
if sPos="" And iEtat = 500 And lIdEvt = 1389 Then

	lDeb=idw_wdivsin.Find("NOM_ZONE='lieu_repar'",1,idw_wdivsin.Rowcount( ))
	if lDeb > 0 Then
		sVal=idw_wdivsin.GetItemString(lDeb, "VAL_CAR")
		if isNull(sVal) Then sVal=""
		
		Choose Case sVal
			Case ""
				// Zone "Centre de réparation" non renseignée
				stMessage.sCode = "WDET628"
				stMessage.icon  = Information!
				stMessage.bErreurG = False
				stMessage.bouton = Ok!
				F_Message ( stMessage )
				sPos = "LIB_DET"
			Case "CAL" 
				// Réparation Centre L’auto Leclerc => pas de règlement des frais de dépose
				stMessage.sCode = "WDET627"
				stMessage.icon  = Information!
				stMessage.bErreurG = False
				stMessage.bouton = Ok!
				F_Message ( stMessage )
				sPos = "LIB_DET"
		End Choose
	End if
End if
//:[PC845]

// [PC926]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 240 )
If lDeb > 0 Then
	If (iEtat <> 500 or idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" ) <> 0  )And idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) = 1388 Then
		stMessage.sCode = "WDET625"
		stMessage.icon  = Information!
		stMessage.bErreurG = False
		stMessage.bouton = Ok!
		F_Message ( stMessage )
		sPos = "LIB_DET"
	End If
End If
// :[PC926]

// [PLAF_REF]
If lIdEvt = 1083 And Not This.uf_GetAutorisation ( 208 ) Then
		
	If dcMtPrej > 0 Then
		stMessage.sCode = "WDET593"
		stMessage.icon  = Information!
		stMessage.bErreurG = False
		stMessage.bouton = Ok!
		F_Message ( stMessage )
		sPos = "LIB_DET"
	End If

End If
// [PLAF_REF]


// [CONFO][MEUBLE][PC542]
// [CONFO][NV_PROCESS]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 207 )
If lDeb > 0 And Not bDetailBloque And Not bDetailEnAttente Then	
	If lIdGti = 51 And lIdEvt = 934 Then

		sFiltreOrig = idwDetailSin.Describe ( "datawindow.table.filter" )
		If sFiltreOrig = "?" Then sFiltreOrig = ""

		idwDetailSin.SetFilter ( "" )
		idwDetailSin.Filter ()
		
		lRow = idwDetailSin.Find ( "ID_GTI <> 51 AND COD_ETAT IN ( 600, 500 )", 1, idwDetailSin.RowCount ()) 
		If lRow <= 0 Then
			stMessage.sCode = "WDET618"
			stMessage.icon  = Information!
			stMessage.bErreurG = False
			stMessage.bouton = Ok!
			F_Message ( stMessage )
			sPos = "LIB_DET"
		End If 
		
		idwDetailSin.SetFilter ( sFiltreOrig )
		idwDetailSin.Filter ()
		idwDetailSin.Sort ()

	End If
End If

// [VDOC26046]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 207 )
If lDeb > 0  Then	
	If lIdGti = 27 And &
		lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";") = "SIEGE" And &
		lIdEvt = 1317 And &
		idw_LstDetail.Find ( "ID_EVT = 1361", 1, idw_LstDetail.Rowcount () ) > 0 &
		Then
			lRow = idw_wDivDet.Find ( "ID_GTI = " + String ( lIdGti ) + " AND " + &
												"ID_DETAIL = " + String ( lIdDetail ) + " AND " + &
												"UPPER ( NOM_ZONE ) = 'MT_PEC' " + " AND " + &
												"VAL_MT > 0", 1, idw_wDivDet.RowCount() )		
			If lRow > 0 Then
				dcMtPec = idw_wDivDet.GetItemDecimal ( lRow, "VAL_MT" )
				
				If dcMtPec >=600 Then
					lRow = idw_LstCmdeSin.Find ( "ID_REF_FOUR = 'A_RECUP_A_RECYCLER' AND COD_ETAT <> 'ANN'", 1, idw_LstCmdeSin.RowCount ())
					If lRow <= 0 Then
						stMessage.sCode = "WDET664"
						stMessage.icon  = Information!
						stMessage.bErreurG = False
						stMessage.bouton = Ok!
						F_Message ( stMessage )
						sPos = "LIB_DET"							
					End IF 
				End If 
			End If 
												
	End If 
End IF 
//	[MANTIS4026]


sVal = "NON"

// [PC801_MANTIS6481]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 209 )
If lDeb > 0 Then
	sVal = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "DESOX_IPHONE", ";")
	If IsNull ( sVal ) Or Trim ( sVal ) = "" Then sVal = "NON"
End If
// [PC801_MANTIS6481]	

If sVal = "NON" And lIdEvt = 1377 And Pos ( Upper ( idw_Wsin.GetItemString ( 1, "MODL_PORT" ) ), "IPHONE" ) > 0 Then	
	stMessage.sCode = "WDET620"
	stMessage.icon  = Information!
	stMessage.bErreurG = False
	stMessage.bouton = Ok!
	F_Message ( stMessage )
	sPos = "LIB_DET"
End If
//	:[MANTIS4026]

// [REG_FACTU_DIAG]
// [VDOC11003] ajout AND STATUS_GC NOT IN ( 2, 21 )
If iEtat=500 Then

	bShunt = False

	// PC938_ORV3_FACTU
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 239 )
	If lDeb > 0 Then
		bShunt = True
	End If
	

	// [PC13442][ITSM326391]
	If lDeb <=0 Then
		lRow=idw_wdivsin.Find("NOM_ZONE='ech_express_48h'", 1, idw_wdivsin.RowCount())
		If lRow > 0 Then
			If idw_wdivsin.GetItemString(lRow, "VAL_CAR") = "O" Then
				bShunt = True
			End If 
		End if
	End If 
	// :[PC13442][ITSM326391]	
	
	// [ITSM301945] je supprime 171
	// le 07/07/2015, je rajoute le 171 (JF)
	// Le 03/01/2017, je retire le 171 (JF), ITSM 436699
	If Not bShunt Then
		sFiltre=" And COD_ETAT <> 'ANN' And ID_GTI=" + String(lIdGti) + " And ID_DETAIL=" + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )
		If idw_LstCmdeSin.Find("ID_REF_FOUR='A_DIAGNOSTIQUER' AND ID_FOUR IN ('SB1', 'BLC', 'MS1', 'O2M', 'SBE') AND STATUS_GC NOT IN ( 2, 21, 170, 171 ) AND INFO_SPB_FRN NOT IN ( 964 )" + sFiltre,1,idw_LstCmdeSin.RowCount()) > 0 And &
			idw_LstCmdeSin.Find("ID_REF_FOUR IN ('REFUSE_A_REEXP','PEC_A_RECYCLER')" + sFiltre,1,idw_LstCmdeSin.RowCount()) <= 0 Then
			
			stMessage.sCode = "WDET623"
			stMessage.icon  = Information!
			stMessage.bErreurG = False
			stMessage.bouton = Ok!
			F_Message ( stMessage )
			sPos = "LIB_DET"
			
		End if
	End IF
End if
// :[REG_FACTU_DIAG]

// [VDOC10924]
If sPos=""  and (not uf_getautorisation( 208)) And (not ibctlvalachat) Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 237 )
	If lDeb <= 0 Then
		lRow=idw_lstdetail.Find("MT_VAL_ACHAT<>" + String(dcMtValAchat) + " AND ID_DETAIL<>" + String(idw_wDetailFF.GetItemnumber( 1, "ID_DETAIL")) ,1,idw_lstdetail.RowCount())
		If lRow > 0 Then
			stMessage.sVar[1]=String(idw_lstdetail.GetItemnumber( lRow, "ID_DETAIL"))
			stMessage.sVar[2]=String(idw_lstdetail.GetItemDecimal( lRow, "MT_VAL_ACHAT"))
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= YesNo!
			stMessage.sCode		= "WDET624"	
			
			if f_message(stMessage)=2 Then
				sPos = "LIB_DET"
			End if
		End if
	End if
End if
// :[VDOC10924]

// 	[DT058]
If sPos="" Then
	If not uf_controler_sanction_eco( ) Then sPos="LIB_DET"
End if
// 	:[DT058]

// [ITSM147960]

If sPos = "" Then
	For lRow=1 to idw_wdivdet.RowCount()
		sVal=idw_wdivdet.GetItemString(lRow, "VAL_CAR")
		If not isNull(sVal) Then
			sVal=f_remplace(sVal,"~"","p")
			sVal=f_remplace(sVal,Char(13)," ")
			sVal=f_remplace(sVal,Char(10)," ")
			sVal=f_remplace(sVal,Char(9)," ")
			sVal=f_remplace(sVal,Char(11)," ")
			idw_wdivdet.SetItem(lRow,"VAL_CAR",sVal)
		End if
	Next
End if
// :[ITSM147960]

// [PM246][MANTIS10235] 
// [PM246-2_GPS_OV3] And Not bAltReg 
// [VDOC21471]
If uf_GestOng_Divers_Trouver ("ALT_PEC" ) <> "O" AND &
	iEtat = 500 And &
	Not gAutoriseDiag And &
	Not gAutoriseRempl And &
	Not bAltReg And &
   lIdEvt <> 1423 &
	Then
	
	// [ITSM529150]
	Choose Case lIdGti
		Case 10, 8, 12
			// Pas de réparation, c'est normal
		Case Else
			F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 94 )
			For lCptDetPro = lDeb To lFin
				sVal = lnvPFCString.of_getkeyvalue ( idw_DetPro.GetItemString ( lCptDetPro, "VAL_CAR" ), "COD_DW", ";")
				
				// [VDOC21471]				
				Choose Case sVal 
					Case "ORANGE_V3", "ORANGE_V2BIS", "ORANGE_V3BIS", "ORANGE_V3TER"
						lRow = idw_LstCmdeSin.Find ( "ID_TYP_ART = 'PRS' AND COD_ETAT <> 'ANN' AND CPT_VALIDE > 0", 1, idw_LstCmdeSin.RowCount ()) 
						
						// ITSM214537
						lRow1 = idw_LstCmdeSin.Find ( "ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT <> 'ANN' AND CPT_VALIDE > 0", 1, idw_LstCmdeSin.RowCount ()) 
												
						If lRow <= 0 And lRow1 <= 0 And Not This.uf_GetAutorisation ( 208 ) Then
							stMessage.sCode = "COMD841"
							stMessage.sVar [1] = "un règlement"
							stMessage.icon  = Information!
							stMessage.bErreurG = False
							stMessage.bouton = Ok!
							F_Message ( stMessage )
							sPos = "LIB_DET"
						End If
				End Choose 
			
			Next
	End Choose
End If
// :[PM246]
			
// [DT94]
If uf_GestOng_Divers_Trouver ("ALT_PEC" ) <> "O" AND iEtat = 500 And Not bAltReg And Not This.uf_GetAutorisation ( 208 ) Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 239 )		

	If lDeb > 0 Then

		// [DT288-1][MODIF_CHRISTINE]
		lRow = idw_LstCmdeSin.Find ( &
		"( ( ID_TYP_ART NOT IN ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' ) " + &
		"    OR " + &
		"    ( ID_TYP_ART = 'RST' AND POS ( INFO_SPB_FRN_CPLT, 'RST_CMDE+SUIVI=OUI' ) > 0 ) " + &
		"  ) " + &
		"   AND POS ( INFO_SPB_FRN_CPLT, 'TYP_RELAI=REMPL' ) > 0 " + &
		"   AND ( ( STATUS_GC IN ( 176 ) AND COD_ETAT <> 'ANN' ) " + &
		"         OR " + &
		"         ( ID_FOUR = 'DME' AND COD_ETAT = 'ANN')" + &
		"       ) " + & 
		"   AND CPT_VALIDE > 0" + &
		") " + &
		"OR " + &
		"( ID_REF_FOUR = 'CONTEST_SUR_REMPL' AND COD_ETAT = 'RFO' AND STATUS_GC = 151 )" &
		, 1, idw_LstCmdeSin.RowCount ()) 			
		
		// [DT154]
		Choose Case lIdEvt
			Case 924, 925, 1071, 1200
				lRow = 1 // On passe.

			// [VDOC21471]					
			Case 1423
				lRow = 1 // On passe.					
				
		End Choose
		
		// [DT288-1][MODIF_CHRISTINE][VDOC24372]
		If sMarqPortSin = "APPLE" Then
			lRow = 1 // On passe.									
		End IF

		// [PM445-1]
		lVal = idw_LstCmdeSin.Find ( &
				"ID_REF_FOUR IN ( 'A_REPARER', 'A_DESOXYDER', 'A_DIAGNOSTIQUER' ) AND " + &
				"ISNULL ( DTE_RCP_FRN ) AND LEN ( ID_BON_TRANSP ) > 0 AND " + &
				"POS ( INFO_FRN_SPB_CPLT, 'PRBLE_LIVRAISON' ) > 0 AND " + &
				"POS ( INFO_FRN_SPB_CPLT, 'PERTE_ALLER' ) > 0 AND " + &
				"COD_ETAT IN ( 'ECT', 'ECL' )", &
				1, idw_LstCmdeSin.RoWCount () )
		
		If lVal > 0 Then 
			lVal = idw_LstCmdeSin.GetItemNumber ( lVal, "ID_SEQ" )
			
			lVal = idw_LstCmdeSin.Find ( &
					"( ( ID_TYP_ART NOT IN ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' ) " + &
					"    OR " + &
					"    ( ID_TYP_ART = 'RST' AND POS ( INFO_SPB_FRN_CPLT, 'RST_CMDE+SUIVI=OUI' ) > 0 ) " + &
					"  ) " + &
					"  AND ( STATUS_GC NOT IN ( 176 ) AND COD_ETAT <> 'ANN' ) " + &
					"  AND CPT_VALIDE > 0" +  &
					"  AND ID_SEQ > " + String ( lVal ) + &
					") " + & 
					"OR " + &
					"( ID_REF_FOUR = 'CONTEST_SUR_REMPL' AND COD_ETAT = 'RFO' AND STATUS_GC = 151 )" &
					, 1, idw_LstCmdeSin.RowCount ()) 			
					
			lVal1 = idw_LstDetail.Find ( "ID_I_REG = 0 AND COD_ETAT = 600", 1, idw_LstDetail.RowCount() )

			If lVal <= 0 And lVal1 <= 0 And This.uf_getautorisation ( 9 ) Then
				lRow = 1
			End If
		End If	
		
		
		If lRow <= 0 Then
			stMessage.sCode = "COMD877"
			stMessage.icon  = Information!
			stMessage.bErreurG = False
			stMessage.bouton = Ok!
			F_Message ( stMessage )
			sPos = "LIB_DET"				
		End If
		
	End If
End If
// [DT94]

// [DT92_FACTU_CASTO]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 43 )		
If lDeb > 0 Then
	sVal  = This.uf_GestOng_Divers_Trouver ( "BON_A_REGLER" ) 		
	sVal1 = This.uf_GestOng_Divers_Trouver ( "CAUSE_ATTENTE" ) 
	
	If sVal = "O" And sVal1 <> "AUC" Then
		stMessage.sCode = "COMD878"
		stMessage.icon  = Information!
		stMessage.bErreurG = False
		stMessage.bouton = Ok!
		F_Message ( stMessage )
		sPos = "LIB_DET"				
	End If
End If 
// [DT92_FACTU_CASTO]

// [VDOC15472]
If lIdEvt = 1396 Then
	lVal = idw_wDetailFF.GetItemNumber ( 1, "ID_I_REG" )
	lRow = idw_LstInter.Find ( "ID_I = " + String ( lVal ), 1, idw_LstInter.RowCount ())
	
	If lRow > 0 Then
		If idw_LstInter.GetItemString ( lRow, "COD_INTER" ) <> "F" Then
			stMessage.sCode = "WDET639"
			stMessage.icon  = Information!
			stMessage.bErreurG = False
			stMessage.bouton = Ok!
			F_Message ( stMessage )
			sPos = "LIB_DET"				
		End If
	End If 
	
End IF 

// [PC13174]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 264 )
If lIdEvt = 1419 and lDeb > 0 Then
	lVal = idw_wDetailFF.GetItemNumber ( 1, "ID_I_REG" )
	lRow = idw_LstInter.Find ( "ID_I = " + String ( lVal ), 1, idw_LstInter.RowCount ())
	
	If lRow > 0 Then
		If idw_lstcmdegti.Find("ID_FOUR='AXA'" ,1, idw_lstcmdegti.RowCount()) <= 0 Then
			stMessage.sCode = "WDET642"
			stMessage.icon  = Information!
			stMessage.bErreurG = False
			stMessage.bouton = Ok!
			F_Message ( stMessage )
			sPos = "LIB_DET"				
		End if
		
		If sPos="" and idw_LstInter.GetItemString ( lRow, "COD_INTER" ) <> "F" Then
			stMessage.sCode = "WDET641"
			stMessage.icon  = Information!
			stMessage.bErreurG = False
			stMessage.bouton = Ok!
			F_Message ( stMessage )
			sPos = "LIB_DET"				
		End If
	End If 
End If 

// [EVT_CAUTION_DR]
If lIdEvt = 1425 Then
	SQLCA.PS_S01_AUTORISATION (9, stGlb.sCodOper, lIdprod, lTrouve)
	If lTrouve <= 0 Then
		stMessage.sTitre       = "Réglement caution exceptionnel"
		stMessage.bErreurG	= FALSE
		stMessage.icon  = Exclamation!
		stMessage.sCode		= "WDET650"
		stMessage.bouton = Ok!
		F_Message ( stMessage )
		sPos = "LIB_DET"		
	End If
End If

// [MCO602_PNEU] à Commenter (pas supprimer) définitivement
If NOT F_CLE_A_TRUE ( "MCO602_PNEU" ) Then
	// [DT227]
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 299 )	
	If lDeb > 0 Then
		// JFF 07/06/2016 [DT227]
		SQLCA.PS_S_DATE_PIVOT ( "DT227", dtDt1, dtDt2, dtDt3 ) 
		
		If dtCreeLe >= dtDt1 Then
			
			Choose Case lIdEvt
				Case 1391
					lVal1 = idw_LstCmdeDet.Find ( "COD_ETAT <> 'ANN' AND ID_TYP_ART = 'PRS'", 1, idw_LstCmdeDet.rowCount()+1 )						
					If lVal1 <= 0 Then
						stMessage.sTitre  	= "Leclerc Pneu"
						stMessage.Icon			= Information!
						stMessage.bErreurG	= FALSE
						stMessage.Bouton		= Ok!
						stMessage.sCode = "WDET652"
						F_Message ( stMessage )
						sPos = "ID_I_REG"
					End If	
					
				Case 1397
					lVal1 = idw_LstCmdeDet.Find ( "COD_ETAT <> 'ANN' AND ID_TYP_ART = 'PNE'", 1, idw_LstCmdeDet.rowCount()+1 )						
					If lVal1 <= 0 Then
						stMessage.sTitre  	= "Leclerc Pneu"
						stMessage.Icon			= Information!
						stMessage.bErreurG	= FALSE
						stMessage.Bouton		= Ok!
						stMessage.sCode = "WDET653"
						F_Message ( stMessage )
						sPos = "ID_I_REG"
					End If
					
			End Choose 
		End If
	End If 
End If 
 

// [VDoc16817]
If sPos="" and idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF" ) > 0 Then
	// Règlement > 0
	lVal = idw_wDetailFF.GetItemNumber ( 1, "ID_I_REG" )
	lRow = idw_LstInter.Find ( "ID_I = " + String ( lVal ), 1, idw_LstInter.RowCount ())

	If lRow > 0 Then
		
		If idw_LstInter.GetItemString ( lRow, "COD_INTER" ) <> "F" Then
			// Destinataire Assuré ou Autre
			idw_wdetailff.GetChild( "ID_EVT", dwChild)
			lRow=dwChild.Find("ID_CODE=" + String(idw_wdetailff.GetItemNumber(1,"ID_EVT")), 1, dwChild.Rowcount( ))
			
			If Left(Upper(dwChild.GetItemString(lRow, "LIB_CODE")),5) = "REMPL" Then
				// Evènement de remplacement
				stMessage.sTitre       = "(VDoc16817) Règlement assuré interdit"
				stMessage.bErreurG	= FALSE
				stMessage.sCode		= "WDET643"
				stMessage.bouton = Ok!
				F_Message ( stMessage )
				
				sPos = "ID_I_REG"	
			End if
		End if
		
		// [REGL_LBE] - Si règlement LBE et pas de case "pas_de_rglt_fourn", on l'ajoute
		If sPos="" And idw_LstInter.GetItemString ( lRow, "ID_FOUR") = "LBE" Then
			lRowDD  = idw_wDivDet.Find ( "NOM_ZONE = 'pas_de_rglt_fourn'", 1, idw_wDivDet.RowCount () )				
			If lRowDD  <= 0 Then
				lRowDD  = idw_wDivDet.InsertRow (0)
			
				idw_wDivDet.SetItem ( lRowDD , "ID_SIN", idw_wDetailFF.GetItemNumber ( 1, "ID_SIN" ) )
				idw_wDivDet.SetItem ( lRowDD , "ID_GTI", idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )	
				idw_wDivDet.SetItem ( lRowDD , "ID_DETAIL", idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )		 
				idw_wDivDet.SetItem ( lRowDD , "NOM_ZONE", "pas_de_rglt_fourn" )
				idw_wDivDet.SetItem ( lRowDD , "LIB_LABEL", "Pas de rglt fournisseur" )
				idw_wDivDet.SetItem ( lRowDD , "ID_TYP_LISTE", "-XX" )
				idw_wDivDet.SetItem ( lRowDD , "ALT_LISTE_CODECAR", "N")
				idw_wDivDet.SetItem ( lRowDD , "ID_TYP_ZONE", "X" )
				idw_wDivDet.SetItem ( lRowDD , "ALT_OBLIG", "N" )
				idw_wDivDet.SetItem ( lRowDD , "ALT_PROT", "O" )
				idw_wDivDet.SetItem ( lRowDD , "CPT_TRI", 500 )
				idw_wDivDet.SetItem ( lRowDD , "VAL_DTE", stNul.dtm )	// [PI056].20190926
				idw_wDivDet.SetItem ( lRowDD , "VAL_CAR", "O" )
				idw_wDivDet.SetItem ( lRowDD , "VAL_NBRE", stNul.lng )
				idw_wDivDet.SetItem ( lRowDD , "VAL_MT", stNul.dcm )
				idw_wDivDet.SetItem ( lRowDD , "ALT_SUPP", "N" )
				idw_wDivDet.SetItem ( lRowDD , "CREE_LE", DateTime ( Today (), Now () ) )
				idw_wDivDet.SetItem ( lRowDD , "MAJ_LE", DateTime ( Today (), Now () ) )
				idw_wDivDet.SetItem ( lRowDD , "MAJ_PAR", stGlb.sCodOper )
			End if
		End if
		// :[REGL_LBE]
	End if
End if
// :[VDoc16817]

// [PM280-2][MANTIS21220]
lRow = idw_LstCmdeDet.Find ( "ID_REF_FOUR IN ( 'PEC_A_RECYCLER', 'REFUSE_A_REEXP') AND COD_ETAT = 'CNV'", 1, idw_LstCmdeDet.RowCount () )
lVal = idw_wdetailff.GetItemNumber ( 1, "COD_ETAT" )
If lIdEvt = 1426 And lRow > 0 Then
	Choose Case lVal
		Case 1, 100	
			stMessage.sTitre       = "PM280-2"
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "WDET654"
			stMessage.bouton = Ok!
			F_Message ( stMessage )
			
			sPos = "ID_I_REG"	
	End Choose 
End If
// :[PM280-2][MANTIS21220]

// [VDOC21595]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 304 )	
If lDeb > 0 Then
	For lCpt = lDeb To lFin 
		If dtCreeLe >= DateTime ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lCpt, "VAL_CAR" ), "DTE_PIVOT", ";") ) Then
			If lIdGti = idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) And &
				lIdEVt = idw_DetPro.GetItemNumber ( lCpt, "VAL_NUM" ) Then 				
				
				stMessage.sTitre       = "DT226/VDOC21595/DPG/J.MOULIN"
				stMessage.bErreurG	= FALSE
				stMessage.sCode		= "WDET655"
				stMessage.sVar[1]		= lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lCpt, "VAL_CAR" ), "DTE_PIVOT", ";") 
				stMessage.bouton = Ok!
				F_Message ( stMessage )
				
				sPos = "ID_I_REG"						
				
			End If
			
		End If
	Next
End If	

// [DT344]
If Not bDetailBloque Then
	
	// [MON311_SPL_PACI]
	If F_CLE_A_TRUE ( "MON311_SPL_PACI" ) Then
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 392 )
		If lDeb > 0 Then
			
			sVal = lnvPFCString.of_getkeyvalue( idw_DetPro.GetItemString(lDeb, "VAL_CAR"), "EVTS_GTI_7_SPL_FORCEE", ";")
		
			If iEtat = 500 And lIdGti = 7 And Pos ( sVal, "#" + String ( lIdEvt ) + "#" ) > 0 Then
				lRow = idw_wDivDet.Find ( &
				"ID_GTI = " + String ( lVal ) + " AND " + &
				"UPPER ( NOM_ZONE ) = 'SOUPLESSE_1' " &
				, 1, idw_wDivDet.RowCount ())
	
				lRow = idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'SOUPLESSE_1'", 1, idw_wDivDet.Rowcount () ) 
				If lRow > 0 Then
					This.uf_GestOng_Divers_MajZone ( "SOUPLESSE_1", lRow, "SIC" )
				End If
	
			End IF 
		End If 	
	End If

	If idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'SOUPLESSE_1'", 1, idw_wDivDet.RowCount() ) > 0 Then
	
		sTabSpl [1] = Trim (This.uf_GestOng_Divers_Trouver ( "SOUPLESSE_1" ))
		sTabSpl [2] = Trim (This.uf_GestOng_Divers_Trouver ( "SOUPLESSE_2" ))
		sTabSpl [3] = Trim (This.uf_GestOng_Divers_Trouver ( "SOUPLESSE_3" ))
	
		If IsNull ( sTabSpl [1] ) Then sTabSpl [1] = ""
		If IsNull ( sTabSpl [2] ) Then sTabSpl [2] = ""
		If IsNull ( sTabSpl [3] ) Then sTabSpl [3] = ""
	
		// [VDOC28827] et [VDOC28866]
		If iEtat = 500 And sTabSpl [1] = "" Then
			stMessage.sTitre       = "VDOC28827/28866"
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "WDET677"
			stMessage.Icon			= Information!
			stMessage.bouton = Ok!
			F_Message ( stMessage )				
			sPos = "ID_I_REG"	
			idw_wDivDet.setRow (1)
		End If 
		
		lTot = UpperBound ( sTabSpl )
		
		sVal = ""
		For lCpt = 1 To lTot 
			If Pos ( sVal, "#" + sTabSpl [lCpt] + "#" ) > 0 And sTabSpl [lCpt] <> "AAA" And sTabSpl [lCpt] <> "" Then
				stMessage.sTitre       = "DT344/DPG/J.MOULIN"
				stMessage.bErreurG	= FALSE
				stMessage.sCode		= "WDET667"
				stMessage.Icon			= Information!
				stMessage.bouton = Ok!
				F_Message ( stMessage )				
				sPos = "ID_I_REG"	
				idw_wDivDet.setRow (1)
				Exit
			Else 
				sVal +=  "#" + sTabSpl [lCpt] + "#"
			End If 
		Next 
	End If 
End If

// [DT391]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 65 )	
If lDeb > 0 And lIdGti = 7 Then
	sVal = idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ) 
	// [DT391][MANTIS29427]
	lRowDD = idw_wDivDet.Find ( "NOM_ZONE = 'alt_fraude'" , 1, idw_wDivDet.RowCount () )		
	If lRowDD > 0 Then 
		If Pos ( sVal, "#" + String ( lIdEvt ) + "#" ) > 0 Then
			This.uf_GestOng_Divers_MajZone ( "ALT_FRAUDE", lRowDD, "O" )						
		Else 
			This.uf_GestOng_Divers_MajZone ( "ALT_FRAUDE", lRowDD, "N" )						
		End If
	End If 
End If 

// [PC874_2_V1]
If lIdEvt = 1451 And iuoTagPiece.dw_Trt.Find ( "ALT_RECLAME = 'O'", 1, iuoTagPiece.dw_Trt.RowCount () ) > 0   Then
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "WDET668"
	stMessage.Icon			= Information!
	stMessage.bouton = Ok!
	F_Message ( stMessage )				
	sPos = "ID_I_REG"			
End If 

// [VDOC27314]
// [PC301].[LOT2]			
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 152 )
// [PC321]
if lDeb <=0 Then 			
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 141 )
End if

// [PC302]			
if lDeb <=0 Then 			
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 212 )
End if

// [PC864_1]			
if lDeb <=0 Then 			
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 224 )
End if

If lDeb > 0 Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 57 )		
	If lDeb > 0 Then		
		For lCpt = lDeb To lFin
			If idw_DetPro.GetItemNumber ( lCpt, "VAL_NUM" ) = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) And &
				idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) Then

								  
				lRow = idw_LstCmdeDet.Find ( "ID_FOUR IN ('CAR', 'CMA') AND ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + &
										  " AND ID_DETAIL = " +  String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
										  " AND COD_ETAT = 'CNV'"  , 1 , idw_LstCmdeDet.RowCount () )

				If lRow > 0 And idw_wDetailFF.GetItemString ( 1, "ALT_ATT" ) = "O" Then
					stMessage.bErreurG	= FALSE
					stMessage.sCode		= "WDET669"
					stMessage.Icon			= Information!
					stMessage.bouton = Ok!
					F_Message ( stMessage )				
					sPos = "ID_I_REG"							
				End If 											  
		
			End If 
		Next
	End If 
End If 

// [PC192235]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 341 )
sVal = Upper ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";"))
bSC2FoyerNomade = sVal = "FOYER_NOMADE"

sVal = This.uf_GestOng_Divers_Trouver ("PEC" )	

If bSC2FoyerNomade And Not IsNull ( iIdIReg ) And sVal <> "O" Then
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "WDET671"
	stMessage.Icon			= Information!
	stMessage.bouton = Ok!
	F_Message ( stMessage )				
	sPos = "ID_I_REG"			
End If 

// [DT424]
/*
If F_CLE_A_TRUE ( "DT424" ) Then
	If lIdEvt = 1457 And ibIdEvtInterditCreation	Then
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "WDET672"
		stMessage.Icon			= Exclamation!
		stMessage.bouton = Ok!
		F_Message ( stMessage )				
		sPos = "ID_I_REG"
	End If 
End If
*/

// [PC202553_SELECTRA]
If Not bDetailBloque And Not bAltReg And iEtat = 500 Then

	lRow = idw_wdivsin.Find ( "Upper (NOM_ZONE) = 'FRANCHISE_PAYBOX'", 1, idw_wdivsin.RowCount () ) 
	If lRow <=0 Then sVal = "N"
	If lRow > 0 Then sVal=idw_wdivsin.GetItemString(lRow,"VAL_CAR")
	If IsNull ( sVal ) Then sVal = "N"
	
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 348 )
	bFranchiseSelectra = lDeb > 0 

	// [KSV516]
	bVarianteSelectra2024 = FALSE
	If bFranchiseSelectra Then 
		bVarianteSelectra2024 = F_CLE_VAL ( "VARIANTE", idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), ";" ) = "SELECTRA_OFFRE_2024"
	End If 	
	
	sRech	=		"ID_PROD = "		+ String ( lIdProd ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( lIdGti )		+ " AND " 	+ &
					"ID_CPT_FRA = 1"																					+ " AND " 	+ &
					"ID_TYP_FRA = "   + "5"

	lLig = idw_Franchise.Find ( sRech, 1, idw_Franchise.RowCount ()	)

	If lLig > 0 Then	
		dcMtFran = idw_Franchise.GetItemDecimal ( lLig, "MT_FRA" )
	End If 
	
	
	Choose Case True 
		// [KSV516]
		Case bFranchiseSelectra And Not bVarianteSelectra2024 
			if sVal="N" Then 
				stMessage.sTitre		= "Franchise Paybox"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET678"
				stMessage.sVar[1]		= String ( dcMtFran )
		
				F_Message ( stMessage )
				
				sPos = "ID_I_REG"	
			End if				
	End Choose
End If 

// [RS1472_DT432_BRED]
If Not bDetailBloque Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 354 )
	If lDeb > 0 And iuoTagPiece.dw_Trt.Find ( "ALT_RECLAME = 'O'", 1, iuoTagPiece.dw_Trt.RowCount () ) > 0 Then		
		Choose Case lIdEvt
			Case 702, 711
				/* Le contrôle ne concerne pas que les dossiers du DT432, mais tous les dossiers
				lRow = idw_wDivSin.Find ( "Upper (NOM_ZONE) = 'DT432_ID_SIN_EMETTEUR'", 1, idw_wDivSin.RowCount () ) 
				If lRow >0 Then 
					sVal = Trim ( Upper ( idw_wDivSin.GetItemString ( lRow, "VAL_CAR" ) ))
					If IsNull ( sVal) Then sVal = ""
					
					If sVal <> "" Then*/
						stMessage.sTitre		= "DT432/RS1472 : Demande de pièces interdite"
						stMessage.bErreurG	= FALSE
						stMessage.sCode		= "WDET679 "
						stMessage.Icon			= information!
						stMessage.bouton = Ok!
						F_Message ( stMessage )				
						sPos = "ID_I_REG"
				/*End If 
				 End If */
		End Choose 				
	End IF 
End IF 


astPass.sTab [ 1 ] = sPos

end subroutine

private function boolean uf_rf_ecrirerefus (long alrefus);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_EcrireRefus (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:21:26
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: Long		alRefus			(Val)	N° du Refus
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* JFF  24/12/2024  [LGY19_PARAM_AUTO]
//*-----------------------------------------------------------------
Boolean bRet, bFin

Long lLig, lTotRefus

String sRech

/*------------------------------------------------------------------*/
/* On va cocher le refus (MACHINE) dans la liste des refus. Si on   */
/* ne trouve pas le refus, on s'arrete.                             */
/*------------------------------------------------------------------*/
bRet			= True
lTotRefus	= iuoTagRefus.dw_Trt.RowCount ()

sRech 		= "ID_MOTIF = " + String ( alRefus )

lLig 			= iuoTagRefus.dw_Trt.Find ( sRech, 1, lTotRefus )

If	lLig > 0 Then
	iuoTagRefus.dw_Trt.SetItem ( lLig, "ALT_MAC", "O" )
	
	If Pos ( islCodeRefPlafNum, "#" + String ( alRefus ) + "#" ) > 0 Then
		iuoTagRefus.dw_Trt.SetItem ( lLig, "ALT_OPE", "O" )
	End IF
	
Else
	bRet = False

	// [LGY19_PARAM_AUTO]
	bFin = False
	Do While Not bFin
		stMessage.sTitre		= "Contrôle de saisie du détail"
		stMessage.Icon			= Information!
		stMessage.sVar[1] 	= String ( alRefus )			
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= YESNO!
		stMessage.sCode		= "WDET140"
		If F_Message ( stMessage ) = 1 Then bFin = TRUE
	Loop


End If

Return ( bRet )
end function

private function boolean uf_rf_614 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_614 (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Evénement non couvert
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------

Long lLig, lTotCondition

String sRech

Boolean bRet

/*------------------------------------------------------------------*/
/* On déclenche ce motif si l'événement saisi n'est pas couvert.    */
/* On envoie le test uniquement si la révision est connue.          */
/*------------------------------------------------------------------*/
bRet = True

If	idw_wSin.GetItemNumber ( 1, "ID_REV" ) <> -1	Then

	sRech = "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + &
			  " And ID_TYP_CODE = '+EV' And ID_CODE = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	lTotCondition = idw_Condition.RowCount ()

	lLig = idw_Condition.Find ( sRech, 1, lTotCondition )

/*------------------------------------------------------------------*/
/* L'événement n'est pas couvert, on déclenche le refus.            */
/*------------------------------------------------------------------*/
	If	lLig = 0 Then
		bRet = Uf_RF_EcrireRefus ( 614 )
	End If
End If

Return ( bRet )


	


end function

private function boolean uf_gestionrefus ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GestionRefus (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 23/01/1998 17:40:41
//* Libellé			: 
//* Commentaires	: On démarre la gestion des refus
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #2	 JFF	  26/10/2004  DCMP 040406 Si Option 26, on ne déclenche pas le refus 633
//* [DCMP060272]	PHG	31/05/2006 Ajout Seuil Inter sur val achat ( casto ) 
//* #3  MADM 11/07/2006 DCMP 050393 Gestion de refus automatique entre évènements et nature de sinistre
//* #4	PHG	30/05/2007	[DCMP070284] Gestion des refus automatique pour la PGC
//* #5	FPI	17/03/2009	[DCMP090107] Refus 650 et 654 désactivé pour l'autorisation 208
//* #6	FPI	29/09/2009	[DCMP090573] Refus 629
//* #7	PHG	26/10/2009  [DCMP071000] REfus 655 ( Seuil d'intervention GMP ) + correction rf 651
//* #8	FPI	10/02/2010	[CASTO_SWAP] Refus 644
//*			FPI	22/10/2010	 [PC516] Refus 1438
//*       JFF    27/07/2011  [PLAF_REF]
//       JFF   24/01/2012  [CONFO][CUISINE]
//        JFF    24/09/2012  [PC869]
//*      JFF   12/10/2012  [ITSM131064][PLAF_REF]
// 		JFF   31/10/2012  [MANTIS4919_PC680]
// 		JFF   28/11/2012  [PC543_MANTIS5297]
//		FPI	17/06/2013	[VDOC10633]
//		FPI	23/07/2013	[PC940]
//        JFF      31/07/2013 [PC845_NOUVPLAF]
//        JFF      31/07/2013 [PC845_NOUVPLAF741]
//    JFF    04/10/2013  [VDOC11880]
// 		JFF   04/10/2017 [VDOC24781]
// 		JFF   19/01/2018 [VDOC25532]
//		FPI	18/07/2018	 [VDOC26406] Evolution DP 307
//        JFF   16/10/2018   [PC171999]
//       JFF   26/11/2019 [PC192290]
//       JFF   08/09/2020 [PC202551_PLAF_759]
//       JFF   18/09/2023 [RS5875_DIF_DIV_DET]
//*-----------------------------------------------------------------
Long lDeb, lFin, lRow, lTotDetail, lCptDet, lIdGti, lIdDetail, lTotwRefus, lCodeRef, lRow1
Long lCpt, lTotRefus, lIdEvt 
String sVal, sRech, sValCar, sPos
Decimal {2} dcMtLu, dcMtMaxLu, dcMtPec
Boolean bBitMap
string sTypParaVer[], sTempTypPlaf, sTempIdPara, sTempCptVer, sAltReg 
integer i
u_DataWindow udwNull // #1
s_Plafond_Pec stPlafPec // #1
n_cst_string lnvPFCString

/*------------------------------------------------------------------*/
/* La première chose à faire est de décocher tous les refus         */
/* machines précédents.                                             */
/*------------------------------------------------------------------*/
sPos = "" 

lIdEvt = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
lIdDetail = idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" )


lTotRefus = iuoTagRefus.dw_Trt.RowCount ()

For	lCpt = 1 To lTotRefus
		If	iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_MAC" ) = "O"	Then
			iuoTagRefus.dw_Trt.SetItem ( lCpt, "ALT_MAC", "N" )
		End If
Next

//  [ITSM131064][PLAF_REF]
// Si lRow <= 0 alors PEC suite placement projet, sinon, PEC réél
lRow = idw_wDivDet.Find ( "ID_GTI = " + String ( lIdGti ) + " AND " + &
								 "ID_DETAIL = " + String ( lIdDetail ) + " AND " + &
								 "UPPER ( NOM_ZONE ) = 'ALT_PLAF_PEC' " + " AND " + &
								 "VAL_CAR = 'O'", 1, idw_wDivDet.RowCount() )
								 
lRow1 = idw_wDivDet.Find ( "ID_GTI = " + String ( lIdGti ) + " AND " + &
								 "ID_DETAIL = " + String ( lIdDetail ) + " AND " + &
								 "UPPER ( NOM_ZONE ) = 'PEC' " + " AND " + &
								 "VAL_CAR = 'O'", 1, idw_wDivDet.RowCount() )							

If lIdEvt = 1083 And lRow <= 0 And lRow1 > 0 Then
	// On shunte le contrôle des refus.
	Return TRUE
End IF

If	Not Uf_Rf_614 () Then	Return ( False )
If	Not Uf_Rf_622 () Then	Return ( False )
If	Not Uf_Rf_625 () Then	Return ( False )
If	Not Uf_Rf_626 () Then	Return ( False )
If	Not Uf_Rf_627 () Then	Return ( False ) // [DCMP060794]
If	Not Uf_Rf_632 () Then	Return ( False )
If	Not Uf_Rf_633 () Then	Return ( False )
If	Not Uf_Rf_634 () Then	Return ( False )
If	Not Uf_Rf_635 () Then	Return ( False )
If	Not Uf_Rf_636 () Then	Return ( False ) // [DCMP070284]
// If	Not Uf_Rf_637 () Then	Return ( False ) // [DCMP070284] Appelé sur condition dans le refus 636
If	Not Uf_Rf_631 () Then	Return ( False )
If	Not Uf_Rf_680 () Then	Return ( False )
if Not This.uf_GetAutorisation(208)  Then// #5 [DCMP090107] 
	If	Not Uf_Rf_650 () Then	Return ( False )
End if
If	Not Uf_Rf_660 () Then	Return ( False )
If Not Uf_Rf_651 () Then 	Return ( False )
If Not Uf_Rf_697 () Then   Return ( False ) 
If Not Uf_Rf_653 () Then   Return ( False )
if Not this.uf_GetAutorisation(208) Then // #5 [DCMP090107] 
	If Not Uf_Rf_654 () Then   Return ( False ) // [DCMP060272]
End if

If Not Uf_Rf_629 () Then   Return ( False ) // #6 [DCMP090573]

/*------------------------------------------------------------------*/
/* #3 MADM 11/07/2006 DCMP050393 		                             */
/*------------------------------------------------------------------*/
// [DCMP070815]
If Not Uf_Rf_698 () Then   Return ( False ) 

// #7 [DCMP071000]
If Not Uf_Rf_655 () Then   Return ( False ) 

// # 8 - [CASTO_SWAP] Refus 644
If Not Uf_Rf_644 () Then   Return ( False ) 

// [PC516] Refus 1438
If Not uf_rf_1438( ) Then   Return ( False ) 

// [PC869]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 221 )
If lDeb > 0 Then
	If	Not Uf_Rf_1590 () Then	Return ( False )
End If
// :[PC869]

If not uf_rf_1678() Then Return FALSE // [VDOC10633]

// [CONFO][CUISINE]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 207 )
If lDeb > 0 Then
	If	Not Uf_Rf_601 () Then	Return ( False )
	If	Not Uf_Rf_603 () Then	Return ( False )
	
	// MANTIS4919_PC680
	If	Not Uf_Rf_1599 () Then	Return ( False )
	
	// [PC543_MANTIS5297]
	If	Not Uf_Rf_1604 () Then	Return ( False )
	If	Not Uf_Rf_1605 () Then	Return ( False )	
End If
// :[CONFO][CUISINE]

If not uf_rf_1694() then Return False // [PC940]

// [VDOC21796]
// [VDOC26406]
If not uf_rf_dp307() then Return False 

// [VDOC25532]
If not This.Uf_Rf_97 () Then Return False 

// [RS5875_DIF_DIV_DET]
If not This.Uf_Rf_dp370_val_div_det () Then Return False 

//////////////////////////////////// Coder les refus au dessus //////////////////////////////////////////

// [PLAF_REF] Code à laisser à la fin

// A garder en pour le MEP

//* F_Plafond_Pec 
//* Retourne		: Structure s_plafond_pec (0 indique qu'il n'y a pas de plafond)
//*					  Pour le type Autre, le retour est sous cette forme
//*					  O[704][3]    => OUI, plaf 704, x3 (en cours + autre)
//*					  N[704][1]		=> NON, plaf 704, x1 ( juste l'en cours)

//	 [PC363].[10%]
lRow = idw_LstCmdeSin.Find ( "COD_ETAT <> 'ANN' AND POS ( INFO_FRN_SPB_CPLT, 'APP_INCOMPLET=OUI', 1) >0", 1, idw_LstCmdeSin.RowCount () )
sVal = "[###]"

If lRow > 0 Then
	lnvPFCString.of_Setkeyvalue ( sVal, "APP_INCOMPLET", "OUI", ";")
End If

// [PC301].[V15_EVOL_VETUSTE]
lTotDetail = idw_wDetailFF.iudwDetailSource.RowCount ()
dcMtLu = 0
dcMtMaxLu = 0
For lCptDet = 1 To lTotDetail	
	
	sRech	=		"ID_GTI = "	+ String ( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCptDet, "ID_GTI" ) )	+ " AND " 	+ &
					"ID_DETAIL = "	+ String ( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCptDet, "ID_DETAIL" ) )	+ " AND " 	+ &
					"UPPER ( NOM_ZONE ) = 'MT_MAX_PROPO_PLF722'"
		
	lRow = idw_wDivDetGti.Find ( sRech, 1, idw_wDivDetGti.RowCount () ) 
	If lRow > 0 Then
		dcMtLu = idw_wDivDetGti.GetItemDecimal ( lRow, "VAL_MT" )
		If dcMtLu > dcMtMaxLu Then
			dcMtMaxLu = dcMtLu 
		End If
	End If					
	
Next

If dcMtMaxLu > 0 Then
	lnvPFCString.of_Setkeyvalue ( sVal, "MT_MAX_PLAF_722", String ( dcMtMaxLu ), ";")
End If
// [PC301].[V15_EVOL_VETUSTE]

stPlafPec = F_Plafond_Pec ( "3" + sVal , idw_wSin, idw_wDivSin, udwNull, idw_wDetailFF, udwNull, idw_Plafond, idw_DetPro, idw_produit, idw_wDivDet, lIdGti, lIdDetail )
//	 [PC363].[10%]

dcMtPec = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" )

If ( dcMtPec > stPlafPec.dcPlafEvt And stPlafPec.dcPlafEvt > 0 ) Or dcMtPec <= 0 Then dcMtPec = stPlafPec.dcPlafEvt
If ( dcMtPec > stPlafPec.dcPlafValAch And stPlafPec.dcPlafValAch > 0 ) Or dcMtPec <= 0 Then dcMtPec = stPlafPec.dcPlafValAch
If ( dcMtPec > stPlafPec.dcPlafGti  And stPlafPec.dcPlafGti  > 0 ) Or dcMtPec <= 0 Then dcMtPec = stPlafPec.dcPlafGti  
If ( dcMtPec > stPlafPec.dcPlafValPublique And stPlafPec.dcPlafValPublique > 0 ) Or dcMtPec <= 0 Then dcMtPec = stPlafPec.dcPlafValPublique
If Left ( stPlafPec.sPlafAutre, 1 ) = "O" Then dcMtPec = 0 

If IsNull ( dcMtPec ) Then dcMtPec = 0

If ( dcMtPec <= 0 Or dcMtPec = 0.01 ) Then 
	dcMtPec = 0 

	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 183 )
	If lDeb > 0 And dcMtPec = 0  Then
		f_decomposerchaine (stPlafPec.stypparaver, ";", sTypParaVer[])
		for i = 1 to UpperBound(sTypParaVer)
			if sTypParaVer[i] <> "" then
				sTempTypPlaf = left (left (sTypParaVer[i], 8), 4)
				sTempIdPara  = right (left (sTypParaVer[i], 8), 4)
				sTempCptVer  = right (sTypParaVer[i], 3)
				
				For lCpt = lDeb To lFin
					If Long ( idw_DetPro.GetItemString ( lCpt, "ID_CODE_CAR" ) ) = Long ( sTempTypPlaf ) Then
						sValCar = idw_DetPro.GetItemString ( lCpt, "VAL_CAR" )
						lCodeRef = Long ( lnvPFCString.of_getkeyvalue( sValCar, "REF_EVT", ";"))

						// Evol
						If Long ( lnvPFCString.of_getkeyvalue( sValCar, "REF_GTI", ";")) > 0 And lCodeRef = 0 Then
							Continue
						End if

						If Not Uf_RF_EcrireRefus ( lCodeRef ) Then
							Return False
						End If
					End If 
				Next
			end if
		next
		
	End If
	// [PLAF_REF]
	
End IF
// [DEBUG][MER][MEP][PLAF_REF][SIMPA_PRO]

// [PLAF_REF]
sAltReg = idw_wDetailFF.GetItemString ( 1, "ALT_REG" )

If sAltReg <> "O" Then
	If sPos = ""	Then sPos = Uf_Plaf_Adhesion_Survenance ()
	If sPos = ""	Then sPos = Uf_Plaf_Adherent_Survenance ()
	If sPos = ""	Then sPos = Uf_Plaf_Adhesion_Renouvellement ()
	If sPos = ""	Then sPos = Uf_Plaf_Adherent_Renouvellement ()

	If sPos = ""	Then sPos = Uf_Plaf_Adhesion_Annee_Civile ()
	If sPos = ""	Then sPos = Uf_Plaf_Adherent_Annee_Civile ()

	// [VDOC24781]
	If sPos = "" Then sPos = Uf_Plaf_Adhesion_Annee_Civile_tt_gti ()
	
// [PC845_NOUVPLAF]
	If sPos = ""	Then sPos = Uf_Plaf_Adhesion_Annee_Civile_val_achat ()
	If sPos = ""	Then sPos = Uf_Plaf_Adherent_Annee_Civile_val_achat ()

// [PC845_NOUVPLAF741]
	If sPos = ""	Then sPos = This.Uf_Plaf_Evt1397_regle_resil_adh ()
	
	If sPos = ""	Then sPos = Uf_Plaf_NbEv_Gti_Adhesion_Survenance ()
	If sPos = ""	Then sPos = Uf_Plaf_NbEv_Gti_Adherent_Survenance ()
	If sPos = ""	Then sPos = Uf_Plaf_NbEv_Gti_Adhesion_Renouvellement ()
	If sPos = ""	Then sPos = Uf_Plaf_NbEv_Gti_Adherent_Renouvellement ()

	// [VDOC11880]
	If sPos = ""  Then sPos = Uf_plaf_NbEv_Gti_Adhesion_Renou_Dte_Surv ()
	
	If sPos = ""	Then sPos = Uf_Plaf_NbEv_Sin_Adhesion_Survenance ()
	If sPos = ""	Then sPos = Uf_Plaf_NbEv_Sin_Adherent_Survenance ()
	If sPos = ""	Then sPos = Uf_Plaf_NbEv_Sin_Adhesion_Renouvellement ()
	If sPos = ""	Then sPos = Uf_Plaf_NbEv_Sin_Adherent_Renouvellement ()
	If sPos = ""	Then sPos = uf_plaf_evt ()
	If sPos = ""	Then sPos = Uf_Plaf_Sin ()
	If sPos = ""	Then sPos = Uf_Plaf_Sin_Carte ()

	// [CONFO][CUISINE][PC680]	
	If sPos = ""	Then sPos = Uf_Plaf_NbEv_Gti_Adhesion()
	If sPos = ""	Then sPos = uf_plaf_nbcodergpt_distinct_gti_adhesion ()

	// [PC171999]
	If sPos = "" Then sPos = Uf_Plaf_Adhesion_Renouv_TypePers ()
	
	// [PC192290]
	If sPos = "" Then sPos = 	Uf_Plaf_Adhesion_Survenance_TteGti ()

	// [PC202551_PLAF_759]
	If sPos = "" Then sPos = Uf_Plaf_Adhesion_Survenance_GtiDp351 ()	
	
	If sPos <> "" Then Return False
End If


Return ( True )


end function

private function boolean uf_rf_632 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_632 (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Débit avant le sinistre
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//* [DCMP060533] PHG	06/09/2006 Deconnexion refus 632 par option -DP 68
//*-----------------------------------------------------------------

Date dDteSurv, dDteDet
String sHeureDet, sHeureSurv
Boolean bRet, bOk
Long lIdGti, lDeb, lCpt, lFin

/*------------------------------------------------------------------*/
/* On déclenche ce motif dans le cas de la garantie Utilisations    */
/* Frauduleuses. Si la date de détail est inférieure à la date de   */
/* survenance, on arme le motif 632.                                */
/*------------------------------------------------------------------*/

bRet = True
/*------------------------------------------------------------------*/
/* Le 27/05/1999.                                                   */
/* Modif DGA. Gestion des UF Téléphone Mobile.                      */
/*------------------------------------------------------------------*/
lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )

bOk    = False

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 42 )
If lDeb <= 0 Then Return True
For lCpt = lDeb to lFin 
	If idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) = lIdGti And idw_DetPro.GetItemString ( lCpt, "ID_CODE_CAR" ) = 'U' Then 
		bOk = True
		Exit
	End If
Next
If Not bOk Then Return TRUE

/*------------------------------------------------------------------*/
/* [DCMP060533] Deconnexion du refus 632 par l'option 68 pour la    */
/* garantie paramétrée dans l'option 68 du produit                  */
/*------------------------------------------------------------------*/

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 68 )

If lDeb > 0 Then
	bOk = idw_DetPro.Find ("ID_CODE_NUM = "+string(lIdGti), lDeb, lFin ) > 0
	If bOk Then Return TRUE
End If
// Fin [DCMP060533]

dDteSurv = idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )
//Migration PB8-WYNIWYG-03/2006 CP
//dDteDet	= idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" )
dDteDet	= Date(idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" ))
//Fin Migration PB8-WYNIWYG-03/2006 CP
/*------------------------------------------------------------------*/
/* On teste d'abord la date.                                        */
/*------------------------------------------------------------------*/
If	Not IsNull ( dDteSurv ) And Not IsNull ( dDteDet )	Then
	If	dDteDet < dDteSurv	Then
		bRet = Uf_RF_EcrireRefus ( 632 )
	Else
		sHeureDet		= idw_wDetailFF.GetItemString ( 1, "HEU_DET" )
		sHeureSurv		= idw_wSin.GetItemString ( 1, "HEU_SURV" )

		If Not IsNull ( sHeureDet ) And Not IsNull  ( sHeureSurv )	Then
/*------------------------------------------------------------------*/
/* On teste l'heure si besoin. On n'a pas besoin de convertir la    */
/* String en Time.                                                  */
/*------------------------------------------------------------------*/
			If	( dDteDet <= dDteSurv ) And ( sHeureDet < sHeureSurv ) Then
				bRet = Uf_RF_EcrireRefus ( 632 )
			End If			
		End If
	End If
End If

Return ( bRet )
end function

private subroutine uf_cast_dtedet ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Cast_DteDet (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libellé			: 
//* Commentaires	: On va décomposer la zone DTE_DET dans DTE_DET_DATE et HEU_DET
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

DateTime dtDteDet
Time tHeure
String sHeure, sMinute

dtDteDet	= idw_wDetailFF.GetItemDateTime ( 1, "DTE_DET" )
If	IsNull ( dtDteDet )	Then
	idw_wDetailFF.SetItem ( 1, "DTE_DET_DATE", stNul.Dat )
	idw_wDetailFF.SetItem ( 1, "HEU_DET", stNul.str )
Else
	sHeure = idw_wDetailFF.GetItemString ( 1, "HEU_DET" )

	// JFF le 29/10
	If Len ( sHeure ) = 4 And IsNumber ( sHeure ) And Not IsNull ( sHeure ) And Long ( Left ( sHeure, 2 ) ) <= 23 And Long ( Right ( sHeure, 2 ) ) <= 59 Then
		idw_wDetailFF.SetItem ( 1, "DTE_DET", DateTime ( Date ( dtDteDet	), Time ( Left ( sHeure, 2 ) + ":" + Right ( sHeure, 2 ) + ":00" ) ) )
	End If

	// On lit de nouveau
	dtDteDet	= idw_wDetailFF.GetItemDateTime ( 1, "DTE_DET" )
	tHeure = Time ( dtDteDet )

	If	tHeure = 00:00:00	And ( sHeure <> "0000" Or IsNull ( sHeure ) ) Then
		idw_wDetailFF.SetItem ( 1, "HEU_DET", stNul.str )
	Else
		sHeure	= Left ( String ( tHeure ), 2 )
		sMinute	= Mid ( String ( tHeure ), 4, 2 )
		idw_wDetailFF.SetItem ( 1, "HEU_DET", sHeure + sMinute )
	End If
	idw_wDetailFF.SetItem ( 1, "DTE_DET_DATE", Date ( dtDteDet ) )
End If





end subroutine

private subroutine uf_zn_idevt ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_IdEvt (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libellé			: 
//* Commentaires	: Controle de ID_EVT
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------

DataWindowChild dwChild
String sLibDet, sCodAdh, sIdTypeCarte, sRech, sRet
String sNumCarte, sFiltre
String sTab[]
Long lDeb, lFin

Decimal {0} dcIdCarte

Long lLig, lTotDetail, lIdEvt

sLibDet = idw_wDetailFF.GetItemString ( 1, "LIB_DET" )

If	sLibDet = "" Or IsNull ( sLibDet ) Then
	idw_wDetailFF.GetChild ( "ID_EVT", dwChild )
	lLig = dwChild.GetRow ()

	sLibDet = dwChild.GetItemString ( lLig, "LIB_EVT" )
	If	Not IsNull ( sLibDet ) Then 
		idw_wDetailFF.SetItem ( 1, "LIB_DET", sLibDet )
		idw_wDetailFF.SetItem ( 1, "ALT_COUR", "O" )
	Else
		idw_wDetailFF.SetItem ( 1, "ALT_COUR", "N" )
	End If

End If

/*------------------------------------------------------------------*/
/* Pour les produits avec COD_ADH = 3 ou 4, on arme par défaut la   */
/* zone NUM_CARTE avec la valeur de ID_ADH. On en profite aussi     */
/* pour armer ID_CARTE et ID_TYPE_CARTE.                            */
/*------------------------------------------------------------------*/
sCodAdh			= idw_Produit.GetItemString ( 1, "COD_ADH" )

/*------------------------------------------------------------------*/
/* Le 21/04/1999. Modif. pour la couverture UF des autres cartes.   */
/*------------------------------------------------------------------*/
lIdEvt			= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )

Choose Case lIdEvt
Case 706, 716
	sFiltre			= "Left ( ID_CODE, 1 ) = 'D'"
	dcIdCarte		= -1
	sIdTypeCarte	= stNul.str
	sNumCarte		= stNul.str

	idw_wDetailFF.Uf_Proteger ( { "ID_TYPE_CARTE" }, "0" )
Case Else
	sFiltre			= ""
	dcIdCarte 		= 0
	sIdTypeCarte	= "00"
	sNumCarte		= stNul.str

	idw_wDetailFF.Uf_Proteger ( { "ID_TYPE_CARTE" }, "1" )
End Choose

/*------------------------------------------------------------------*/
/* On récupére l'attribut du champ NUM_CARTE.                       */
/*------------------------------------------------------------------*/
sRet = idw_wDetailFF.Describe ( "NUM_CARTE.Visible" )
F_DecomposerChaine ( sRet, "~t", sTab )
/*------------------------------------------------------------------*/
/* On enleve la dernière double quote.                              */
/*------------------------------------------------------------------*/
sTab[2] = Left ( sTab[2], Len ( sTab[2] ) -1 )
sRet = "Evaluate ( '" + sTab[2] + "', 1 ) "

/*------------------------------------------------------------------*/
/* On peut maintenant évaluer l'attribut de la colonne.             */
/* 1-> Visible.                                                     */
/* 0-> Invisible.                                                   */
/*------------------------------------------------------------------*/
sRet = idw_wDetailFF.Describe ( sRet )

/*------------------------------------------------------------------*/
/* La zone NUM_CARTE est visible, on vérifie si on peut l'armer     */
/* avec une valeur précédente.                                      */
/*------------------------------------------------------------------*/
If	sRet = "1" Then
	Choose Case sCodAdh 
	Case "3", "4"
		sNumCarte 		= idw_wSin.GetItemString ( 1, "ID_ADH" )
		dcIdCarte		= idw_wSin.GetItemNumber ( 1, "ID_CARTE" )
		sIdTypeCarte	= idw_wSin.GetItemString ( 1, "ID_TYPE_CARTE" )

	Case "1", "2", "5", "6"
/*------------------------------------------------------------------*/
/* Pour les produits avec COD_ADH = 1,2,5,6, on arme par défaut la  */
/* zone NUM_CARTE avec le dernier N° saisi (s'il existe). On en     */
/* profite pour armer les zones ID_CARTE et ID_TYPE_CARTE.          */
/*------------------------------------------------------------------*/
		lTotDetail	= idw_wDetailFF.iudwDetailSource.RowCount ()
/*------------------------------------------------------------------*/
/* Le 21/04/1999. Modif. pour la couverture UF des autres cartes.   */
/*------------------------------------------------------------------*/


		If			( lIdEvt >= 701 And lIdEvt <= 705 )	Then
					sRech 		= "NUM_CARTE <> '' And ( ID_EVT >= 701 And ID_EVT <= 705 )"
		ElseIf	( lIdEvt >= 710 And lIdEvt <= 715 )		Then
					sRech 		= "NUM_CARTE <> '' And ( ID_EVT >= 710 And ID_EVT <= 715 )"
		ElseIf	( lIdEvt >= 706 And lIdEvt <= 709 ) Or ( lIdEvt >= 716 And lIdEvt <= 719 )		Then
					sRech 		= "NUM_CARTE <> '' And ( ( ID_EVT >= 706 And ID_EVT <= 709 ) Or ( ID_EVT >= 716 And ID_EVT <= 719 ) )"
		Else
					sRech 		= "NUM_CARTE <> '' And ID_EVT = " + String ( lIdEvt )
		End If

		lLig 			= idw_wDetailFF.iudwDetailSource.Find ( sRech, lTotDetail, 1 )

		If	lLig > 0 Then
			sNumCarte		= idw_wDetailFF.iudwDetailSource.GetItemString ( lLig, "NUM_CARTE" )
			dcIdCarte		= idw_wDetailFF.iudwDetailSource.GetItemNumber ( lLig, "ID_CARTE" )
			sIdTypeCarte	= idw_wDetailFF.iudwDetailSource.GetItemString ( lLig, "ID_TYPE_CARTE" )
		End If

	End Choose
End If

/*------------------------------------------------------------------*/
/* Le 21/04/1999. Modif. pour la couverture UF des autres cartes.   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On arme le filtre sur la saisie du type de carte. Ce filtre      */
/* sera dans tous les cas repositionné à "" sur le CTRL+VAL de la   */
/* fenêtre ou sur RETOUR.                                           */
/*------------------------------------------------------------------*/

idw_wDetailFF.GetChild ( "ID_TYPE_CARTE", dwChild )
dwChild.SetFilter  ( sFiltre )
dwChild.Filter ()

idw_wDetailFF.SetItem ( 1, "NUM_CARTE", sNumCarte )
idw_wDetailFF.SetItem ( 1, "ID_CARTE", dcIdCarte )
idw_wDetailFF.SetItem ( 1, "ID_TYPE_CARTE", sIdTypeCarte )




end subroutine

public subroutine uf_zn_trt_focus (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_Trt (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:27:01
//* Libellé			: 
//* Commentaires	: Traitement sur les zones de dw_wDetailFF (On vient de ItemFocusChanged)
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Choose Case idw_wDetailFF.isNomCol
Case "ID_EVT"
	Uf_Zn_IdEvt ()

End Choose


end subroutine

private function boolean uf_rf_633 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_633 (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Débit aprés opposition
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------

Date dDteOppo, dDteDet
String sHeureDet, sHeureOppo
Boolean bRet, bOk
Long lIdGti, lDeb, lFin, lCpt

/*------------------------------------------------------------------*/
/* On déclenche ce motif dans le cas de la garantie Utilisations    */
/* Frauduleuses. Si la date de détail est supérieure à la date      */
/* d'opposition, on arme le motif 633.                              */
/*------------------------------------------------------------------*/
bRet = True

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 26 )
If lDeb > 0 Then Return True

/*------------------------------------------------------------------*/
/* Le 27/05/1999.                                                   */
/* Modif DGA. Gestion des UF Téléphone Mobile.                      */
/*------------------------------------------------------------------*/
lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )

bOk    = False


F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 42 )
If lDeb <= 0 Then Return True
For lCpt = lDeb to lFin 
	If idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) = lIdGti And idw_DetPro.GetItemString ( lCpt, "ID_CODE_CAR" ) = 'U' Then 
		bOk = True
		Exit
	End If
Next
If Not bOk Then Return TRUE

dDteOppo	= idw_wGarSin.GetItemDate ( 1, "DTE_OPPO_DATE" )
dDteDet	= idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" )

/*------------------------------------------------------------------*/
/* On teste d'abord la date.                                        */
/*------------------------------------------------------------------*/
If	Not IsNull ( dDteOppo ) And Not IsNull ( dDteDet )	Then
	If	dDteDet > dDteOppo	Then
		bRet = Uf_RF_EcrireRefus ( 633 )
	Else
		sHeureDet		= idw_wDetailFF.GetItemString ( 1, "HEU_DET" )
		sHeureOppo		= idw_wGarSin.GetItemString ( 1, "HEU_OPPO" )

		If Not IsNull ( sHeureDet ) And Not IsNull  ( sHeureOppo )	Then
/*------------------------------------------------------------------*/
/* On teste l'heure si besoin. On n'a pas besoin de convertir la    */
/* String en Time.                                                  */
/*------------------------------------------------------------------*/
			If	( dDteDet >= dDteOppo ) And ( sHeureDet > sHeureOppo ) Then
				bRet = Uf_RF_EcrireRefus ( 633 )
			End If			
		End If
	End If
End If


Return ( bRet )
end function

private function boolean uf_rf_634 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_634 (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Espéces retirées après le sinistre
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------

Date dDteSurv, dDteDet

String sHeureDet, sHeureSurv
Boolean bRet, bOk
Long lDeb, lFin, lCpt, lIdGti

/*------------------------------------------------------------------*/
/* On déclenche ce motif dans le cas de la garantie Espéces. Si la  */
/* date de détail est supérieure à la date de survenance, on arme   */
/* le motif 634.                                                    */
/*------------------------------------------------------------------*/

bRet = True
bOk    = False

lIdGti = idw_wDetailFF.GetItemnumber ( 1, "ID_GTI" )

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 42 )
If lDeb <= 0 Then Return True
For lCpt = lDeb to lFin 
	If idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) = lIdGti And idw_DetPro.GetItemString ( lCpt, "ID_CODE_CAR" ) = 'R' Then 
		bOk = True
		Exit
	End If
Next
If Not bOk Then Return TRUE

dDteSurv = idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )
dDteDet	= idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" )

/*------------------------------------------------------------------*/
/* On teste d'abord la date.                                        */
/*------------------------------------------------------------------*/
If	Not IsNull ( dDteSurv ) And Not IsNull ( dDteDet )	Then
	If	dDteDet > dDteSurv	Then
		bRet = Uf_RF_EcrireRefus ( 634 )
	Else
		sHeureDet		= idw_wDetailFF.GetItemString ( 1, "HEU_DET" )
		sHeureSurv		= idw_wSin.GetItemString ( 1, "HEU_SURV" )

		If Not IsNull ( sHeureDet ) And Not IsNull  ( sHeureSurv )	Then
/*------------------------------------------------------------------*/
/* On teste l'heure si besoin. On n'a pas besoin de convertir la    */
/* String en Time.                                                  */
/*------------------------------------------------------------------*/
			If	( dDteDet >= dDteSurv ) And ( sHeureDet > sHeureSurv ) Then
				bRet = Uf_RF_EcrireRefus ( 634 )
			End If			
		End If
	End If
End If

Return ( bRet )
end function

private function boolean uf_rf_631 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_631 (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Achats après le sinistre
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 	  JFF    22/09/99 On déclenche maintenant ce refus pour la garantie 9
//*							si les dates et heures d'oppo n'ont pas été saisie et 
//*						   que la date du détail soit postérieure à la date du sinistre.		
//* #1  JFF    18/04/06 [BUG_180406] Modification lGti en lIdGti
//*-----------------------------------------------------------------
Date 	  dDteSurv, dDteDet, dDetOppo
String  sHeuOppo
Boolean bRet, bGestionDateAchat, bGestionSpecialeGti9, bOk
long	  lDeb, lFin, lCpt, lIdGti

/*------------------------------------------------------------------*/
/* On déclenche ce motif dans le cas de la garantie Achats. Si la   */
/* date de détail est supérieuere à la date de survenance, on arme  */
/* le motif 631.                                                    */
/*------------------------------------------------------------------*/

bRet = True

lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) //#1
dDetOppo = idw_wGarSin.GetItemDate  ( 1, "DTE_OPPO_DATE" )
sHeuOppo = idw_wGarSin.GetItemString  ( 1, "HEU_OPPO" )
bOk      = False

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 42 )
If lDeb <= 0 Then Return True
For lCpt = lDeb to lFin 
	If lIdGti = 9 Or ( idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) = lIdGti And idw_DetPro.GetItemString ( lCpt, "ID_CODE_CAR" ) = "A" ) Then 
		bOk = True
		bGestionDateAchat = True
		Exit
	End If
Next
If Not bOk Then Return TRUE

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 42 )

bGestionSpecialeGti9 = ( lIdGti = 9 and ( IsNull (dDetOppo ) Or String ( dDetOppo ) = "" or IsNull (sHeuOppo ) Or sHeuOppo = "" ) )

If	 bGestionDateAchat And ( lIdGti <> 9 Or bGestionSpecialeGti9 ) Then

	dDteSurv = idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )
	dDteDet	= idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" )

	If	Not IsNull ( dDteSurv ) And Not IsNull ( dDteDet )	Then
		If	dDteDet > dDteSurv	Then
			bRet = Uf_RF_EcrireRefus ( 631 )
		End If
	End If
End If

Return ( bRet )
end function

private function boolean uf_rf_680 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_680 (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Plafond par sinistre déjà réglé
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    	11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//* #2	 PHG		26/10/2009 [DCMP071000] rf 655+651: Annexe : Correction Bug
//*								  présent sur toute les fonctions de refus.
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCptDetail, lNbrDetail, lIdEvt, lCpt
String sIdNivPlaf, sIdRefPlaf

Boolean bRet

Decimal {2} dcTotDejaRegle, dcMtPlaf

String sRech

bRet				= True
dcTotDejaRegle = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt

		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond 										  */
	/*------------------------------------------------------------------*/
	// #2 [DCMP071000] Lecture ID_GTI dans idw_wDetailFF ald de idw_wGarSin
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '" + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"																					+ " AND " 	+ &
					"ID_TYP_PLAF = '680'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If	lLig > 0 Then

	/*------------------------------------------------------------------*/
	/* On vient de trouver le plafond, on va calculer la somme des      */
	/* montants déjà réglés. (Pour le même événement, la même           */
	/* garantie).                                                       */
	/*------------------------------------------------------------------*/
		lIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
		lNbrDetail	= idw_wDetailFF.iudwDetailSource.RowCount ()
		For	lCptDetail = 1 To lNbrDetail

				If	idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCptDetail, "COD_ETAT" ) = 600	And &
					idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCptDetail, "ID_EVT" ) = lIdEvt Then
					dcTotDejaRegle = dcTotDejaRegle + idw_wDetailFF.iudwDetailSource.GetItemDecimal ( lCptDetail, "MT_PLAF" )
				End If
		Next

	/*------------------------------------------------------------------*/
	/* Si le montant déjà réglé est supérieur ou égal au montant du     */
	/* plafond, on déclenche le refus 680.                              */
	/*------------------------------------------------------------------*/
		dcMtPlaf = idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
		If	dcTotDejaRegle >= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" ) Then
			bRet = Uf_RF_EcrireRefus ( 680 )
		End If
	End If
Next

Return ( bRet )
end function

private function boolean uf_rf_650 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_650 (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Seuil d'intervention non atteint
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//* #2		PHG	26/10/2009 [DCMP071000] rf 655+651: Annexe : Correction Bug
//*								  présent sur toute les fonctions de refus.
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt
String sIdNivPlaf, sIdRefPlaf
Boolean bRet

Decimal {2} dcMtPrej

String sRech

bRet				= True
lTotPlaf 		= idw_Plafond.RowCount ()
dcMtPrej			= idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" )

/*------------------------------------------------------------------*/
/* Si le montant du préjudice est NULL ou égal à zéro, on ne gére   */
/* pas de refus.                                                    */
/*------------------------------------------------------------------*/
If	IsNull ( dcMtPrej ) Or dcMtPrej = 0 Then Return ( bRet )

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 1 to 5

	Choose Case lCpt
		Case 1
			sIdNivPlaf = "-GA"  // Garantie
			sIdRefPlaf = "-1"
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond 										  */
	/*------------------------------------------------------------------*/
	// #3 [DCMP071000] Lecture ID_GTI dans idw_wDetailFF ald de idw_wGarSin
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '" + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"																					+ " AND " 	+ &
					"ID_TYP_PLAF = '650'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* Si le montant du préjudice est strictement inférieur au montant  */
/* du plafond, on déclenche le refus 650.                           */
/*------------------------------------------------------------------*/
		If	dcMtPrej < idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )	Then
			bRet = Uf_RF_EcrireRefus ( 650 )
		End If
	End If
Next

Return ( bRet )
end function

private function boolean uf_rf_660 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_650 (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Plafond d'intervention dépassé
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//* #2		PHG	26/10/2009 [DCMP071000] rf 655+651: Annexe : Correction Bug
//*								  présent sur toute les fonctions de refus.
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt
String sIdNivPlaf, sIdRefPlaf
Boolean bRet

Decimal {2} dcMtPrej

String sRech

bRet				= True
lTotPlaf 		= idw_Plafond.RowCount ()
dcMtPrej			= idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" )
If	IsNull ( dcMtPrej ) Then	dcMtPrej = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 1 to 5

	Choose Case lCpt
		Case 1
			sIdNivPlaf = "-GA"  // Garantie
			sIdRefPlaf = "-1"
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond 										  */
	/*------------------------------------------------------------------*/
	// #1 [DCMP071000] Lecture ID_GTI dans idw_wDetailFF ald de idw_wGarSin
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '" + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"																					+ " AND " 	+ &
					"ID_TYP_PLAF = '660'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If	lLig > 0 Then

		/*------------------------------------------------------------------*/
		/* Si le montant du préjudice est strictement supérieur au montant  */
		/* du plafond, on déclenche le refus 660.                           */
		/*------------------------------------------------------------------*/
		If	dcMtPrej > idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )	Then
			bRet = Uf_RF_EcrireRefus ( 660 )
		End If
	End If
Next

Return ( bRet )

end function

private function string uf_determiner_etat (integer aitype);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Determiner_Etat (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:27:01
//* Libellé			: 
//* Commentaires	: Détermination du Code Etat du détail
//*
//* Arguments		: Integer		aiType			(Val) 
//*
//* Retourne		: String			
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//* #2    MADM    06/07/2006 DCMP 060472 FNAC Suissse-Belgique permettre le règlement à 0 euros sur option 57   
//* #3    JFF   04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
//*-----------------------------------------------------------------

String sRet, sRech, sIdAdh, sIdNivPlaf, sIdRefPlaf
Long lVal, lTotRefus, lTotPce, lCpt, lTotCmdDet, lCptPlaf, lLigFinale
Long lCodDecMac, lCodDecOpe, lCodEtat, lLig, lTotPlaf, lIdGti
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdEvt, lNbDetail,lIdEvt, lDeb, lFin 
DateTime	dtDteSurv
Decimal {2}  dcPlafSav, dcPlafTmp

lVal		= 0
lIdGti	= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
lIdEvt   = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
sRet		= ""

Choose Case aiType
Case 1					//	Détermination du Code Etat Machine (COD_DEC_MAC)

	If			idw_wDetailFF.GetItemString ( 1, "ALT_BLOC" ) = "O"	Then
				lVal = 1
	ElseIf	idw_wDetailFF.GetItemString ( 1, "ALT_SSUI" ) = "O"	Then
				lVal = 900
	Else
/*------------------------------------------------------------------*/
/* Si au moins un refus (Opérateur ou Machine) est coché, on        */
/* positionne le code à 200.                                        */
/*------------------------------------------------------------------*/
				lTotRefus = iuoTagRefus.dw_Trt.RowCount ()
				For	lCpt = 1 To lTotRefus
						If	iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_MAC" ) = "O" Or &
							iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_OPE" ) = "O"	Then

							lVal = 200
							Exit
						End If
				Next
/*------------------------------------------------------------------*/
/* Si on réclame au moins une pièce on positionne le code à 100.    */
/*------------------------------------------------------------------*/
				If	lVal = 0	Then
					lTotPce = iuoTagPiece.dw_Trt.RowCount ()
					For	lCpt = 1 To lTotPce
							If	iuoTagPiece.dw_Trt.GetItemString ( lCpt, "ALT_RECLAME" ) = "O"		Then
								lVal = 100
								Exit
							End If
					Next
				End If
/*------------------------------------------------------------------*/
/* Si le dossier est en attente, ALT_ATT = 'O', on positionne le    */
/* code à 100.                                                      */
/*------------------------------------------------------------------*/
				If	lVal = 0 And idw_wDetailFF.GetItemString ( 1, "ALT_ATT" ) = "O"	Then
					lVal = 100
				End If
/*------------------------------------------------------------------*/
/* Si le montant de préjudice n'est pas renseigné, on positionne    */
/* le code à 0. (Non controlé).                                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/* Pour les produits SFR, le montant du préjudice peut être égal à  */
/* 0 pour la garantie PANNE uniquement.                             */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Il faut au moins une commande active pour la garantie.           */
/*------------------------------------------------------------------*/
				sRech			= "ID_GTI = 18 And COD_ETAT <> 'ANN'"
				lTotCmdDet	= idw_LstCmdeDet.RowCount ()

				If			( ilCodTel = 21 And lIdGti = 18 ) And lVal = 0 And idw_LstCmdeDet.Find ( sRech, 1, lTotCmdDet ) > 0 &
							And idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" ) >= 0 Then
							lVal = 500
				ElseIf	lVal	= 0 And idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" ) > 0 Then
							lVal = 500
				End IF
			   /*------------------------------------------------------------------*/
	   	   /* #2 MADM 06/07/2006 DCMP 060472		                             */
	         /*------------------------------------------------------------------*/
				F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 57 )

				If lDeb > 0 Then 
				 For lCpt = lDeb To lFin	
					If idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) = lIdGti And idw_DetPro.GetItemNumber ( lCpt, "VAL_NUM" ) = lIdEvt & 
					   And lVal	= 0 And idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" ) >= 0 Then
					   lVal = 500
						Exit
				 	End IF
				 Next	 
				End IF
				/*------------------------------------------------------------------*/
		      /* Fin MADM								                     				  */
		      /*------------------------------------------------------------------*/
					
	End If
	idw_wDetailFF.SetItem ( 1, "COD_DEC_MAC", lVal )

Case 2					//	Détermination du Code Etat Opérateur (COD_DEC_OPE)

	If			idw_wDetailFF.GetItemString ( 1, "ALT_BLOC" ) = "O"	Then
				lVal = 1
	ElseIf	idw_wDetailFF.GetItemString ( 1, "ALT_REG" ) = "O"	Then
				lVal = 500
	ElseIf	idw_wDetailFF.GetItemString ( 1, "ALT_SSUI" ) = "O"	Then
				lVal = 900
	Else
/*------------------------------------------------------------------*/
/* Si au moins un refus (Opérateur) est coché, on positionne le     */
/* code à 200.                                                      */
/*------------------------------------------------------------------*/
				lTotRefus = iuoTagRefus.dw_Trt.RowCount ()
				For	lCpt = 1 To lTotRefus
						If	iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_OPE" ) = "O"	Then
							lVal = 200
							Exit
						End If
				Next
/*------------------------------------------------------------------*/
/* Si on réclame au moins une pièce on positionne le code à 100.    */
/*------------------------------------------------------------------*/
				If	lVal = 0	Then
					lTotPce = iuoTagPiece.dw_Trt.RowCount ()
					For	lCpt = 1 To lTotPce
							If	iuoTagPiece.dw_Trt.GetItemString ( lCpt, "ALT_RECLAME" ) = "O"		Then
								lVal = 100
								Exit
							End If
					Next
				End If
/*------------------------------------------------------------------*/
/* Si le dossier est en attente, ALT_ATT = 'O', on positionne le    */
/* code à 100.                                                      */
/*------------------------------------------------------------------*/
				If	lVal = 0 And idw_wDetailFF.GetItemString ( 1, "ALT_ATT" ) = "O"	Then
					lVal = 100
				End If
/*------------------------------------------------------------------*/
/* Si au moins un des refus (Machine) est coché, on positionne le   */
/* code à 200.                                                      */
/*------------------------------------------------------------------*/
				If	lVal = 0 Then
					For	lCpt = 1 To lTotRefus
							If	iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_MAC" ) = "O"	Then
								lVal = 200
								Exit
							End If
					Next
				End If
/*------------------------------------------------------------------*/
/* Si le montant de préjudice n'est pas renseigné, on positionne    */
/* le code à 0. (Non controlé).                                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/* Pour les produits SFR, le montant du préjudice peut être égal à  */
/* 0 pour la garantie PANNE uniquement.                             */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Il faut au moins une commande active pour la garantie.           */
/*------------------------------------------------------------------*/
				sRech			= "ID_GTI = 18 And COD_ETAT <> 'ANN'"
				lTotCmdDet	= idw_LstCmdeDet.RowCount ()

				If			( ilCodTel = 21 And lIdGti = 18 ) And lVal = 0 And idw_LstCmdeDet.Find ( sRech, 1, lTotCmdDet ) > 0 &
							And idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" ) >= 0 Then
							lVal = 500
				ElseIf	lVal	= 0 And idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" ) > 0 Then
							lVal = 500
				End IF
				
				/*------------------------------------------------------------------*/
	   	   /* #2 MADM 06/07/2006 DCMP 060472		                             */
	         /*------------------------------------------------------------------*/
				F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 57 )
				If lDeb > 0 Then 
				 For lCpt = lDeb To lFin	
					If idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) = lIdGti And idw_DetPro.GetItemNumber ( lCpt, "VAL_NUM" ) = lIdEvt & 
					   And lVal	= 0 And idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" ) >= 0 Then
					   lVal = 500
						Exit
					End IF
				 Next	
				End IF
				/*------------------------------------------------------------------*/
		      /* Fin MADM								                     				  */
		      /*------------------------------------------------------------------*/
	End If
	idw_wDetailFF.SetItem ( 1, "COD_DEC_OPE", lVal )

Case 3					//	Détermination du Code Etat (COD_ETAT)

	lCodDecOpe	= idw_wDetailFF.GetItemNumber ( 1, "COD_DEC_OPE" )
	lCodDecMac	= idw_wDetailFF.GetItemNumber ( 1, "COD_DEC_MAC" )
	lCodEtat		= 0

/*------------------------------------------------------------------*/
/* Si l'un des états est à 0, il manque des informations, on        */
/* positionne le COD_ETAT à Non controlé.                           */
/*------------------------------------------------------------------*/
	If	lCodDecOpe = 0 Or lCodDecMac = 0	Then
/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/* Affichage d'un message d'erreur spécifique pour le cas ou le     */
/* gestionnaire veuille régler à 0 Euros, sans saisir de commande.  */
/*------------------------------------------------------------------*/
		sRech			= "ID_GTI = 18 And COD_ETAT <> 'ANN'"
		lTotCmdDet	= idw_LstCmdeDet.RowCount ()

		If			( ilCodTel = 21 And lIdGti = 18 ) And lVal = 0 And idw_LstCmdeDet.Find ( sRech, 1, lTotCmdDet ) = 0 &
					And idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" ) = 0 Then
					stMessage.sCode		= "SFRP010"
		Else
					stMessage.sCode		= "WDET150"
		End If

		stMessage.sTitre		= "Contrôle sur le détail"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= False

// #3	On le traitera plus tard.
//		f_Message ( stMessage )

		sRet = "MT_PREJ"
	Else
		If	lCodDecOpe <> lCodDecMac	Then
			If	Long ( stGLB.sTypOper ) >= idw_Produit.GetItemNumber ( 1, "COD_NIV_OPE" )	Then
				lCodEtat = lCodDecOpe
			Else
				lCodEtat = lCodDecMac
			End If
		Else
			lCodEtat = lCodDecOpe
		End If
	End If
/*------------------------------------------------------------------*/
/* Si le COD_ETAT est égal à 500 (A REGLER), on va vérifier que     */
/* toutes les zones nécessaires (Sinistre, Détail) sont bien        */
/* renseignées.                                                     */
/*------------------------------------------------------------------*/
	If	lCodEtat = 500	Then
		/*------------------------------------------------------------------*/
	   /* #2 MADM 06/07/2006 DCMP 060472		                             */
	   /*------------------------------------------------------------------*/
		If idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" ) = 0 Then
		   stMessage.sTitre		= "Information gestionnaire"
		   stMessage.Icon			= Information!
		   stMessage.bErreurG	= False
		   stMessage.sCode		= "WDET490"
		   F_message ( stMessage )
		END IF	
		/*------------------------------------------------------------------*/
		/* Fin MADM			                  										  */
		/*------------------------------------------------------------------*/
		
		sRet = Uf_ControlerSaisie_Si_Reglement ()
		If	sRet <> "" Then
			lCodEtat = 0
		Else
/*------------------------------------------------------------------*/
/* On va vérifier s'il existe d'autres détails 'A REGLER' pour des  */
/* sinistres différents de celui en cours de traitement. (Avec      */
/* adhésion identique).                                             */
/* Si c'est le cas et qu'il existe au moins un plafond pour cette   */
/* garantie-révision, on doit bloquer le dossier et avertir le      */
/* gestionnaire de valider le sinistre lié avant.                   */
/*------------------------------------------------------------------*/
			lTotPlaf	= idw_Plafond.RowCount ()
			dcPlafSav = 0

			/*------------------------------------------------------------------*/
			/* #1, JFF le 11/04/2003                                            */
			/*------------------------------------------------------------------*/
			For lCptPlaf = 2 to 5

				Choose Case lCptPlaf
					Case 2
						sIdNivPlaf = "+NS"  // Nature de sinistre
						sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
					Case 3
						sIdNivPlaf = "+TR"  // Territorialité
						sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
					Case 4
						sIdNivPlaf = "+DT"  // Détail
						sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
					Case 5
						sIdNivPlaf = "+EV"  // Evénement de garantie
						sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

				End Choose

				If IsNull ( sIdRefPlaf ) Then Continue

				/*------------------------------------------------------------------*/
				/* On vérifie s'il existe un plafond										  */
				/*------------------------------------------------------------------*/
				sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
								"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
								"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
								"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
								"ID_REF_PLAF = "	+ sIdRefPlaf 								


				lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

				If lLig > 0 Then	

					dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

					If dcPlafSav <> 0 Then

						If dcPlafTmp < dcPlafSav Then 
							dcPlafSav = dcPlafTmp 
							lLigFinale = lLig
						End If

					Else
						dcPlafSav = dcPlafTmp 
						lLigFinale = lLig
					End If
				End If

			Next

			lLig = lLigFinale
			/*------------------------------------------------------------------*/
			/* FIN #1																			  */
			/*------------------------------------------------------------------*/

			If	lLig > 0 Then
				dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
				dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
				dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
				sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
				dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
				dcIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
				dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
				lNbDetail	= 0

				itrTrans.PS_S01_W_DETAIL_A_REGLER ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, dcIdEvt, dtDteSurv, lNbDetail )
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée.                                    */
/*------------------------------------------------------------------*/
				If	Not F_Procedure ( stMessage, itrTrans, "PS_S01_W_DETAIL_A_REGLER" )	Then
					f_Message ( stMessage )
					sRet		= "ID_EVT"
					lCodEtat = 0
				Else
					If	lNbDetail > 0 Then
						stMessage.sTitre		= "Contrôle sur le détail"
						stMessage.Icon			= Information!
						stMessage.sVar[1]		= String ( lNbDetail )
						stMessage.bErreurG	= False
						stMessage.sCode		= "WDET160"
	
						f_Message ( stMessage )
						sRet		= "ID_EVT"
						lCodEtat = 0
					End If
				End If
			End If
		End If
	End If

	idw_wDetailFF.SetItem ( 1, "COD_ETAT", lCodEtat )

/*------------------------------------------------------------------*/
/* Le 10/12/1998                                                    */
/* Si le détail n'est pas A REGLER (COD_ETAT=500), on positionne    */
/* la zone ID_I_REG à NULL.                                         */
/*------------------------------------------------------------------*/
	If	idw_wDetailFF.GetItemNumber ( 1, "COD_ETAT" ) <> 500	Then
		idw_wDetailFF.SetItem ( 1, "ID_I_REG", stNul.dcm )
	End If
	
End Choose
			
Return ( sRet )



end function

private subroutine uf_fran_fixe ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Fran_Fixe (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Application d'une franchise fixe éventuelle
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//* #2	 JFF	  04/06/2004  DCMP 040235
//* #3	 CAG	  25/06/2004  Les franchises de type NS, DT et TR n'ont pas de sens 
//*								  sur le détail puisqu'on les applique déjà sur la gti.
//*								  ( Sinon appliquées 2 fois, même si dans param on ne
//*									 peut mettre une franchise que sur une gti XOR des détails )
//* #4	 CAG	  25/06/2004  Calcul de la franchise après application des plafonds => mt_plaf
//			 JFF    13/01/2010  [PC363].[10%]
//			 JFF    11/01/2010  [MANTIS3458][PC724]
// 		 JFF	  01/06/2016  [VDOC20980]
//        JFF    06/11/2017  [PC171933]
//*-----------------------------------------------------------------

n_cst_string lnvPFCString
Long lTotFranchise, lLig, lCpt, lLigFinale, lCptTypFra, lIdGti, lIdEvt, lDeb, lFin, lBorneMin, lBorneMax
String sRech, sIdPara, sCptVer, sIdNivFra, sIdRefFra, sIdTypFra, sIdTypFraSav
Decimal {2} dcMtPlaf, dcMtFra, dcFranSav, dcFranTmp, dcMtPrejDet, dcMtPlafOrig, dcMtFranchise, dcMtPlafOrig2, dcMtValAchat 
Long lTotPlaf, lRow
Boolean bAppIncomplet, bPriseEnCharge, bCoqueNonAdapte, bCoqueNeProtegePas

lTotFranchise = idw_Franchise.RowCount ()
dcFranSav = 0
dcMtPrejDet = idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" ) 

// [PC363].[10%]
dcMtPlafOrig = idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF" )
dcMtFranchise = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
/* #3, CAG le 25/06/2004                                            */
/*------------------------------------------------------------------*/
For lCpt = 5 to 5

	Choose Case lCpt
		Case 5
			sIdNivFra = "+EV"  // Evénement de garantie
			sIdRefFra = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )
	End Choose

	If IsNull ( sIdRefFra ) Then Continue

	// #2
	For lCptTypFra = 1 To 3

		/*------------------------------------------------------------------*/
		/* Le cas 2 est traité par l'objet des garantie.	                 */
		/*------------------------------------------------------------------*/
		Choose Case lCptTypFra
			Case 1
				sIdTypFra = "1"

			Case 2
				sIdTypFra = "3"

			// [MANTIS3458][PC724]
			Case 3
				sIdTypFra = "4"
			
		End Choose 

		/*------------------------------------------------------------------*/
		/* On vérifie s'il existe un plafond										  */
		/*------------------------------------------------------------------*/
		sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
						"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
						"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
						"ID_NIV_FRA = '"  + sIdNivFra 																+ "' AND " 	+ &
						"ID_REF_FRA = "	+ sIdRefFra 																+ " AND " 	+ &
						"ID_CPT_FRA = 1"																					+ " AND " 	+ &
						"ID_TYP_FRA = "   + sIdTypFra

		lLig = idw_Franchise.Find ( sRech, 1, lTotFranchise	)

		If lLig > 0 Then	

			dcFranTmp		= idw_Franchise.GetItemDecimal ( lLig, "MT_FRA" )

			/*------------------------------------------------------------------*/
			/* #2 : Cas particulier pour le tytpe de franchise '3', c'est un %  */
			/* du MT_PREJ                                                       */
			/*------------------------------------------------------------------*/
			If sIdTypFra = "3" Then 
				dcFranTmp = dcMtPrejDet * dcFranTmp
			End If 

			// [MANTIS3458][PC724]
			If sIdTypFra = "4" Then 
				dcFranTmp = dcMtPlafOrig * dcFranTmp
			End If 


			If dcFranSav <> 0 Then

				// On garde la plus grande franchise, contrairement au plafond
				If dcFranTmp > dcFranSav Then 
					dcFranSav = dcFranTmp 
					sIdTypFraSav = sIdTypFra
					lLigFinale = lLig
				End If

			Else
				dcFranSav = dcFranTmp 
				sIdTypFraSav = sIdTypFra
				lLigFinale = lLig
			End If
		End If
	Next
Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On vient de trouver la franchise, Il ne reste plus qu'à          */
/* l'appliquer.                                                     */
/*------------------------------------------------------------------*/
If	lLig > 0 Then
	//	 [PC363].[10%]
//	dcMtPlaf  = idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF" )
	dcMtPlaf   = dcMtPlafOrig
	//	 [PC363].[10%]
	
	dcMtFra    = idw_Franchise.GetItemDecimal ( lLig, "MT_FRA" )

	/*------------------------------------------------------------------*/
	/* #2 : Cas particulier pour le tytpe de franchise '3', c'est un %  */
	/* du MT_PREJ                                                       */
	/*------------------------------------------------------------------*/
	If sIdTypFraSav = "3" Then 
		dcMtFra = dcMtPrejDet * dcMtFra
	End If 

	// [MANTIS3458][PC724]
	If sIdTypFraSav = "4" Then 
		dcMtFra = dcMtPlaf * dcMtFra
	End If 


	If dcMtPlaf > dcMtFra Then
		dcMtPlaf = dcMtPlaf - dcMtFra
	Else
		dcMtPlaf = 0
	End If

//	idw_wDetailFF.SetItem ( 1, "MT_NPLAF", dcMtPlaf )
	idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcMtPlaf )
/*------------------------------------------------------------------*/
/* Ne jamais faire un SetItem avec un GetItemNumber (Problème de    */
/* précision). Il faut passer dans une variable intermédiaire.      */
/*------------------------------------------------------------------*/
	idw_wDetailFF.SetItem ( 1, "MT_FRAN", dcMtFra )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de franchise dans la DW uniquement si    */
/* le montant est supérieur à zéro.                                 */
/*------------------------------------------------------------------*/
	If	dcMtFra > 0 Then
		sIdPara	= idw_Franchise.GetItemString ( lLig, "ID_PARA" )
		sCptVer	= idw_Franchise.GetItemString ( lLig, "CPT_VER" )
		Uf_Plaf_EcrirePara ( "1", sIdPara, sCptVer )
	End If
End If

//	 [PC363].[10%]
//  Cette franchise est particulière, paramètrée dans les
//  plafonds car utilisé aussi dans les PEC.
lTotPlaf = idw_Plafond.RowCount ()
sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
				"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
				"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
				"ID_NIV_PLAF = '+EV'" 																			+ " AND " 	+ &
				"ID_REF_PLAF = "	+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) ) 	+ " AND " 	+ &
				"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
				"ID_TYP_PLAF = '721'"
lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )
If	lLig > 0 Then  // #2

	dcMtPlaf = dcMtPlafOrig 

	If dcMtPlaf > 0 Then

		// Condition : appareil incomplet chez O2M ?
		bAppIncomplet = idw_LstCmdeSin.Find ( "COD_ETAT <> 'ANN' AND POS ( INFO_FRN_SPB_CPLT, 'APP_INCOMPLET=OUI', 1) >0", 1, idw_LstCmdeSin.RowCount () ) > 0

		// Y a-t-il eu déjà une pec, si oui, on n'applique la franchise sur le réglt
		// Car déjà appliqué sur la pec.
		bPriseEnCharge = idw_wDivDet.Find ( &
			 "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + " AND " + &
			 "ID_DETAIL = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) ) + " AND " + &
			 "UPPER ( NOM_ZONE ) = 'PEC' AND VAL_LST_CAR = 'O'", 1, idw_wDivDet.Rowcount () ) > 0 

		If bAppIncomplet And Not bPriseEnCharge Then
			dcMtPlaf += dcMtPlaf * ABS ( idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )) * -1
			If dcMtPlaf <= 0 Then dcMtPlaf = 0		
			
			If	 ( dcMtPlaf < dcMtPlafOrig ) And bAppIncomplet And Not bPriseEnCharge Then
	
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcMtPlaf )
				/*------------------------------------------------------------------*/
				/* On insére le paragraphe de plafond dans la DW.                   */
				/*------------------------------------------------------------------*/
				sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
				sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
				Uf_Plaf_EcrirePara ( "721", sIdPara, sCptVer )
			End IF
		End If
	End If
End If
//	 [PC363].[10%]

// [PC947&977]
dcMtPlafOrig2 = idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF" )
lTotPlaf = idw_Plafond.RowCount ()
sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
				"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
				"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
				"ID_NIV_PLAF = '+EV'" 																			+ " AND " 	+ &
				"ID_REF_PLAF = "	+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) ) 	+ " AND " 	+ &
				"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
				"ID_TYP_PLAF = '744'"
lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )
If	lLig > 0 Then  // #2
	
	dcMtPlaf = dcMtPlafOrig2
	dcMtFranchise = idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

	If dcMtPlaf > 0 Then

		// Condition : 
		lRow = idw_wDivSin.Find ( "NOM_ZONE = 'coque_non_adapte'", 1,  idw_wDivSin.RowCount () )
		If lRow > 0 Then
			bCoqueNonAdapte = idw_wDivSin.GetItemString ( lRow, "VAL_CAR" ) = "O"
		End If			

		// Y a-t-il eu déjà une pec, si oui, on n'applique la franchise sur le réglt
		// Car déjà appliqué sur la pec.
		bPriseEnCharge = idw_wDivDet.Find ( &
			 "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + " AND " + &
			 "ID_DETAIL = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) ) + " AND " + &
			 "UPPER ( NOM_ZONE ) = 'PEC' AND VAL_LST_CAR = 'O'", 1, idw_wDivDet.Rowcount () ) > 0 

		If bCoqueNonAdapte And Not bPriseEnCharge Then
			dcMtPlaf -= dcMtFranchise 
			If dcMtPlaf <= 0 Then dcMtPlaf = 0
		
			If	 ( dcMtPlaf < dcMtPlafOrig ) And bCoqueNonAdapte And Not bPriseEnCharge Then
	
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcMtPlaf )
				idw_wDetailFF.SetItem ( 1, "MT_FRAN", dcMtFranchise )
				/*------------------------------------------------------------------*/
				/* On insére le paragraphe de plafond dans la DW.                   */
				/*------------------------------------------------------------------*/
				sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
				sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
				Uf_Plaf_EcrirePara ( "744", sIdPara, sCptVer )
			End IF
		End If
	End If
End If


lTotPlaf = idw_Plafond.RowCount ()
sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
				"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
				"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
				"ID_NIV_PLAF = '+EV'" 																			+ " AND " 	+ &
				"ID_REF_PLAF = "	+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) ) 	+ " AND " 	+ &
				"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
				"ID_TYP_PLAF = '745'"
lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )
If	lLig > 0 Then  // #2

	dcMtFranchise = idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
	dcMtPlaf = dcMtPlafOrig2

	If dcMtPlaf > 0 Then

		// Condition : 
		// [VDOC20980]
		lRow = idw_wDivSin.Find ( "NOM_ZONE = 'coque_ne_protege'", 1,  idw_wDivSin.RowCount () )	
		
		If lRow > 0 Then
			bCoqueNeProtegePas = idw_wDivSin.GetItemString ( lRow, "VAL_CAR" ) = "O"
		End If			

		// Y a-t-il eu déjà une pec, si oui, on n'applique la franchise sur le réglt
		// Car déjà appliqué sur la pec.
		bPriseEnCharge = idw_wDivDet.Find ( &
			 "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + " AND " + &
			 "ID_DETAIL = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) ) + " AND " + &
			 "UPPER ( NOM_ZONE ) = 'PEC' AND VAL_LST_CAR = 'O'", 1, idw_wDivDet.Rowcount () ) > 0 

		If bCoqueNeProtegePas  And Not bPriseEnCharge Then
			dcMtPlaf -= dcMtFranchise 
			If dcMtPlaf <= 0 Then dcMtPlaf = 0
		
			If	 ( dcMtPlaf < dcMtPlafOrig ) And bCoqueNeProtegePas  And Not bPriseEnCharge Then
	
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcMtPlaf )
				idw_wDetailFF.SetItem ( 1, "MT_FRAN", dcMtFranchise )					
				/*------------------------------------------------------------------*/
				/* On insére le paragraphe de plafond dans la DW.                   */
				/*------------------------------------------------------------------*/
				sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
				sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
				Uf_Plaf_EcrirePara ( "745", sIdPara, sCptVer )
			End IF
		End If
	End If
End If	
// [PC947&977]

// [PC171933]
dcMtPlafOrig2 = idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF" )
lTotPlaf = idw_Plafond.RowCount ()
sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
				"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
				"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
				"ID_NIV_PLAF = '+EV'" 																			+ " AND " 	+ &
				"ID_REF_PLAF = "	+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) ) 	+ " AND " 	+ &
				"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
				"ID_TYP_PLAF = '754'"
lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )
If	lLig > 0 Then  // #2
	
	dcMtPlaf = dcMtPlafOrig2
	dcMtFranchise = idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

	If dcMtPlaf > 0 Then

		// Condition : 
		dcMtValAchat = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" )
		dcMtFranchise = 0
					
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 321 )
		If lDeb > 0 Then
			For lCpt = lDeb to lFin 
				lBorneMin = Long ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lCpt, "VAL_CAR" ), "BORNE_MIN", ";") )
				lBorneMax = Long ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lCpt, "VAL_CAR" ), "BORNE_MAX", ";") )
	
				If dcMtValAchat >= lBorneMin And dcMtValAchat < lBorneMax Then 
					dcMtFranchise = dec ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lCpt, "VAL_CAR" ), "MT_FRANCHISE", ";") )											
					Exit
				End If
			Next
		End if
					
		// Y a-t-il eu déjà une pec, si oui, on n'applique la franchise sur le réglt
		// Car déjà appliqué sur la pec.
		bPriseEnCharge = idw_wDivDet.Find ( &
			 "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + " AND " + &
			 "ID_DETAIL = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) ) + " AND " + &
			 "UPPER ( NOM_ZONE ) = 'PEC' AND VAL_LST_CAR = 'O'", 1, idw_wDivDet.Rowcount () ) > 0 

		If dcMtFranchise > 0 And Not bPriseEnCharge Then
			dcMtPlaf -= dcMtFranchise 
			If dcMtPlaf <= 0 Then dcMtPlaf = 0
		
			If	 ( dcMtPlaf < dcMtPlafOrig ) And Not bPriseEnCharge Then
	
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcMtPlaf )
				idw_wDetailFF.SetItem ( 1, "MT_FRAN", dcMtFranchise )
				/*------------------------------------------------------------------*/
				/* On insére le paragraphe de plafond dans la DW.                   */
				/*------------------------------------------------------------------*/
				sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
				sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
				Uf_Plaf_EcrirePara ( "754", sIdPara, sCptVer )
			End IF
		End If
	End If
End If

end subroutine

private function string uf_controlersaisie_si_reglement ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerSaisie_Si_Reglement (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Contrôle de saisie du détail s'il est à régler
//*
//* Arguments		: Aucun
//*
//* Retourne		: String		"" = Toutes les zones sont saisies
//*									?	= Zone non saisie
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*  #1 JFF		23/11/99 Ajout de contrôles pour régler Gti 9
//*  #2 JFF		12/05/04 DCMP 040149 GMP (gti 23 )
//*  #3 JCA	   11/12/2007	DCMP 70920 / 70943 - 
//*  #4 JFF    05/02/2008   [DCMP070921]
//*  #4 JFF    16/11/2012   [VDOC9485]
//*  #4 JFF    06/02/2013   [VDOC9485] Retour arrière
//*     JFF    03/09/2014   [DT92_FACTU_CASTO]
//      JFF    21/05/2015   [VDOC17414]
//      JFF    24/05/2019   [DT391-1]
//		  JFF    12/12/2019   [VDOC28814]
//*-----------------------------------------------------------------

String 		sNouvelleLigne, sText, sPos, sOng, sHeureDet, sHeureSurv, sHeureOppo, sNumCarte, sRech, sLib, sCodAction, sIdFour
String  		sFiltreOri, sFiltrePrs, sVal 
Long 			lIdGti, lIdEvt, lRet, lTotCmdDet, lDeb, lFin, lCpt, lAccordRepml2, lIdIAReg
Date			dDteOppo
Decimal {2}	dcMtPlaf, dcMtVal
Boolean		bOk, bReglFourn

Long lRow, lVal, lRow1	// #3
Datetime dtCreeLe // #3

sNouvelleLigne		= "~r~n"
sPos					= ""
sOng					= "01"
sText					= sNouvelleLigne

lIdGti	= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
lIdEvt	= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
lIdIAReg	= idw_wDetailFF.GetItemNumber ( 1, "ID_I_REG" )

// #4
bReglFourn = idw_LstInter.Find ( "ID_I = " + String ( lIdIAReg	) + " AND COD_INTER = 'F'", 1, idw_LstInter.Rowcount () ) > 0


/*------------------------------------------------------------------*/
/* Le montant MT_PLAF doit être renseigné si ALT_REG est égal à     */
/* OUI.                                                             */
/*------------------------------------------------------------------*/
dcMtPlaf = idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF" )
If	IsNull ( dcMtPlaf ) Then dcMtPlaf = 0

If	idw_wDetailFF.GetItemString ( 1, "ALT_REG" ) = "O" And dcMtPlaf <= 0	Then
	If sPos = "" Then sPos = "MT_PLAF"
	sText = sText + " - Le montant plafonné" + sNouvelleLigne
End If

// #3
// Si oui, recherche d'un irreparable....
// [VDOC9485] ajout This.uf_GetAutorisation ( 208 )
// [VDOC9485] retrait This.uf_GetAutorisation ( 208 )

/*------------------------------------------------------------------*/
/* Le 27/05/1999.                                                   */
/* Modif DGA. Gestion des UF Téléphone Mobile.                      */
/*------------------------------------------------------------------*/
/* #1 Le 23/11/1999	JFF														  */
/* Date Utilisation obligatoire pour régler Gti 9.						  */	
/*------------------------------------------------------------------*/
/* La date de l'événement est obligatoire.                          */
/*------------------------------------------------------------------*/
// #2
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 42 ) // Gestion Date Achat
If lDeb > 0 And Not This.uf_GetAutorisation ( 208 ) Then
	For lCpt = lDeb To lFin 
		If	lIdGti = idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) Then
			If	IsNull ( idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" )	) Then
				If sPos = "" Then sPos = "DTE_DET_DATE"
				sText = sText + " - La date de l'événement" + sNouvelleLigne
			End If
			Exit
		End If
	Next
End If

/*------------------------------------------------------------------*/
/* Le 27/05/1999.                                                   */
/* Modif DGA. Gestion des UF Téléphone Mobile.                      */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* L'heure de l'événement est obligatoire dans certains cas.        */
/*------------------------------------------------------------------*/
If	lIdGti = 2 Or ( lIdGti = 7 And ( lIdEvt >= 710 And lIdEvt <= 719 ) )	Or ( lIdGti = 8 And ( lIdEvt >= 801 And lIdEvt <= 819 ) ) Then
	If	IsNull ( idw_wDetailFF.GetItemString ( 1, "HEU_DET" ) ) Or idw_wDetailFF.GetItemString ( 1, "HEU_DET" ) = "" Then
		If	sPos = "" Then sPos = "HEU_DET"
		sText = sText + " - L'heure de l'événement" + sNouvelleLigne
	End If
End If

/*------------------------------------------------------------------*/
/* Le 21/04/1999. Modif. pour la couverture UF des autres cartes.   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Le N° de carte est obligatoire dans certains cas.                */
/*------------------------------------------------------------------*/
/* #1 Le 23/11/1999	JFF														  */
/* N° Carte obligatoire pour régler Gti 9.								  */	
/*------------------------------------------------------------------*/

// [VDOC28814]
/*
	sNumCarte = idw_wDetailFF.GetItemString ( 1, "NUM_CARTE" )
	If	IsNull ( sNumCarte ) And ( ( lIdGti = 7 And  lIdEvt >=710 And lIdEvt <= 719 ) Or lIdGti = 9 ) Then
		If sPos = "" Then sPos = "NUM_CARTE"
		sText = sText + " - Le numéro de la carte" + sNouvelleLigne
	End If
	
	/*------------------------------------------------------------------*/
	/* Au moins 4 chiffres pour le NUM_CARTE si ID_EVT >= 716 et        */
	/* ID_EVT <= 719.                                                   */
	/*------------------------------------------------------------------*/
	If	Len ( sNumCarte ) < 4 And ( lIdGti = 7 )  And ( lIdEvt >=716 And lIdEvt <= 719 )	Then
		If sPos = "" Then sPos = "NUM_CARTE"
		sText = sText + " - Le numéro de la carte (au moins 4 Chiffres)" + sNouvelleLigne
	End If
*/

/*------------------------------------------------------------------*/
/* Le destinataire du règlement est obligatoire.                    */
/*------------------------------------------------------------------*/
If	IsNull ( idw_wDetailFF.GetItemNumber ( 1, "ID_I_REG" ) ) Then
	If sPos = "" Then sPos = "ID_I_REG"
	sText = sText + " - Le destinataire du règlement" + sNouvelleLigne
End If

/*------------------------------------------------------------------*/
/* #2 Option Det_Pro 21 : Gestion GTI GMP                           */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 21 )
If lDeb > 0 Then 
	bOk = False
	For lCpt = lDeb To lFin
		If lIdGti = idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) Then
			bOk = True
			Exit
		End If
	Next

	If bOk Then
		sLib = " - Le nouveau prix constaté"
	Else
		lDeb = 0
	End If
End If

IF lDeb <= 0 Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 36 )
	If lDeb > 0 Then sLib = " - La valeur d'achat d'origine"
End If

If lDeb > 0 Then 
	dcMtVal = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" )
	If	IsNull ( dcMtVal ) Then dcMtVal = 0

	If dcMtVal = 0 Then
		If sPos = "" Then sPos = "MT_VAL_ACHAT"
		sText = sText + sLib  + sNouvelleLigne
	End If
End If

/*------------------------------------------------------------------*/
/* La date de survenance du sinistre est obligatoire. On se         */
/* positionne par défaut sur la zone ID_EVT du détail.              */
/*------------------------------------------------------------------*/
If	IsNull ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) ) Then
	If sPos = "" Then sPos = "ID_EVT"
	sText = sText + " - La date de survenance du sinistre" + sNouvelleLigne
End If

/*------------------------------------------------------------------*/
/* Le N° adhésion est obligatoire. On se positionne par défaut sur  */
/* la zone ID_EVT du détail.                                        */
/*------------------------------------------------------------------*/
If	IsNull ( idw_wSin.GetItemString ( 1, "ID_ADH" ) ) Then
	If sPos = "" Then sPos = "ID_EVT"
	sText = sText + " - La référence de l'adhésion" + sNouvelleLigne
End If

/*------------------------------------------------------------------*/
/* Le N° ETS est obligatoire. On se positionne par défaut sur la    */
/* zone ID_EVT du détail.                                           */
/*------------------------------------------------------------------*/
If	IsNull ( idw_wSin.GetItemNumber ( 1, "ID_ETS" ) ) Then
	If sPos = "" Then sPos = "ID_EVT"
	sText = sText + " - La référence ETS" + sNouvelleLigne
End If

/*------------------------------------------------------------------*/
/* On récupére certaines zones pour faciliter les tests suivants.   */
/*------------------------------------------------------------------*/
sHeureDet	= idw_wDetailFF.GetItemString ( 1, "HEU_DET" )
If	sHeureDet = "" Then sHeureDet = stNul.str

sHeureSurv	= idw_wSin.GetItemString ( 1, "HEU_SURV" )
If	sHeureSurv = "" Then sHeureSurv = stNul.str

sHeureOppo	= idw_wGarSin.GetItemString ( 1, "HEU_OPPO" )
If sHeureOppo = "" Then sHeureOppo = stNul.str

dDteOppo		= idw_wGarSin.GetItemDate ( 1, "DTE_OPPO_DATE" )

/*------------------------------------------------------------------*/
/* L'heure de survenance est obligatoire dans certains cas. On se   */
/* positionne par défaut sur la zone ID_EVT du détail.              */
/*------------------------------------------------------------------*/
If	lIdGti = 7 And ( ( lIdEvt >= 710 And lIdEvt <= 719 ) Or ( lIdEvt >= 700 And lIdEvt <= 709 ) ) And Not IsNull ( sHeureDet ) And &
	IsNull ( sHeureSurv ) Then
	If sPos = "" Then sPos = "ID_EVT"
	sText = sText + " - L'heure de survenance du sinistre" + sNouvelleLigne
End If

If	lIdGti = 2 And IsNull ( sHeureSurv ) Then
	If sPos = "" Then sPos = "ID_EVT"
	sText = sText + " - L'heure de survenance du sinistre" + sNouvelleLigne

End If

/*------------------------------------------------------------------*/
/* Le 27/05/1999.                                                   */
/* Modif DGA. Gestion des UF Téléphone Mobile.                      */
/*------------------------------------------------------------------*/
If	lIdGti = 8 And ( lIdEvt >= 801 And lIdEvt <= 819 ) And IsNull ( sHeureSurv ) Then
	If sPos = "" Then sPos = "ID_EVT"
	sText = sText + " - L'heure de survenance du sinistre" + sNouvelleLigne
End If

/*------------------------------------------------------------------*/
/* L'heure d'opposition est obligatoire dans certains cas. On se    */
/* positionne par défaut sur la zone ID_EVT du détail.              */
/*------------------------------------------------------------------*/
If	lIdGti = 7 And ( ( lIdEvt >= 710 And lIdEvt <= 719 ) Or ( lIdEvt >= 700 And lIdEvt <= 709 ) ) And Not IsNull ( sHeureDet ) And &
	IsNull ( sHeureOppo ) Then
	If sPos = "" Then sPos = "ID_EVT"
	sText = sText + " - L'heure d'opposition" + sNouvelleLigne
End If

/*------------------------------------------------------------------*/
/* Le 27/05/1999.                                                   */
/* Modif DGA. Gestion des UF Téléphone Mobile.                      */
/*------------------------------------------------------------------*/
If	lIdGti = 8 And ( lIdEvt >= 801 And lIdEvt <= 819 ) And Not IsNull ( sHeureDet ) And IsNull ( sHeureOppo ) Then
	If sPos = "" Then sPos = "ID_EVT"
	sText = sText + " - L'heure d'opposition" + sNouvelleLigne
End If

/*------------------------------------------------------------------*/
/* La date d'opposition est obligatoire dans certains cas. On se    */
/* positionne par défaut sur la zone ID_EVT du détail.              */
/*------------------------------------------------------------------*/
/* Modif DBI le 15/04/1999                                          */
/* Modif du contrôle                                                */
/*      lIdEvt >= 700 And lIdEvt <= 709 And Not IsNull ( sHeureDet )*/
/* remplacé par                                                     */
/*      lIdEvt >= 700 And lIdEvt <= 709                             */
/* Si la date de l'evt est saisi, il faut systématiquement vérifier */
/* que la date d'opposition est renseignée pour règler              */
/*------------------------------------------------------------------*/
If	lIdGti = 7 And ( ( lIdEvt >= 710 And lIdEvt <= 719 ) Or ( lIdEvt >= 700 And lIdEvt <= 709 ) ) And &
	IsNull ( dDteOppo ) Then
	If sPos = "" Then sPos = "ID_EVT"
	sText = sText + " - la date d'opposition" + sNouvelleLigne
End If

/*------------------------------------------------------------------*/
/* Le 27/05/1999.                                                   */
/* Modif DGA. Gestion des UF Téléphone Mobile.                      */
/*------------------------------------------------------------------*/
If	lIdGti = 8 And ( lIdEvt >= 801 And lIdEvt <= 819 ) And IsNull ( dDteOppo ) Then
	If sPos = "" Then sPos = "ID_EVT"
	sText = sText + " - la date d'opposition" + sNouvelleLigne
End If

/*------------------------------------------------------------------*/
/* Si la valeur de la révison est à -1, il faut arreter le          */
/* contrôle. Le gestionnaire devra bloquer le détail pour           */
/* l'enregistrer.                                                   */
/*------------------------------------------------------------------*/
If	idw_wSin.GetItemNumber ( 1, "ID_REV" ) = -1	Then
	If sPos = "" Then sPos = "ID_EVT"
	sText = sText + " - la révision du produit" + sNouvelleLigne
End If

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/* Il faut au moins une commande active pour la garantie.           */
/*------------------------------------------------------------------*/
If	ilCodTel = 21 And lIdGti = 18	Then
	sRech			= "ID_GTI = 18 And COD_ETAT <> 'ANN'"
	lTotCmdDet	= idw_LstCmdeDet.RowCount ()

	If	idw_LstCmdeDet.Find ( sRech, 1, lTotCmdDet ) = 0	Then
		If sPos = "" Then sPos = "ID_EVT"
		sText = sText + " - Une commande (PRESTATION) pour la garantie PANNE" + sNouvelleLigne
	End If
End If

/*------------------------------------------------------------------*/
/* Pour Régler CASTO, au une décision CASTO doit être présente.     */
/*------------------------------------------------------------------*/
// [DT92_FACTU_CASTO] à Supprimer à la désact.
/* [DT92_FACTU_CASTO_2]
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 43 ) // CASTO
	If lDeb > 0 And sPos = "" Then 
		sCodAction = This.uf_GestOng_Divers_Trouver ("COD_ACTION" )
		sIdFour = idw_LstInter.GetItemString ( idw_LstInter.Find ( "ID_I = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_I_REG" ) ) , 1, idw_LstInter.RowCount () ), &
															"ID_FOUR" ) 
	
		If IsNull ( sCodAction ) Then sCodAction = "" 
		If Trim ( sCodAction ) = "" And sIdFour = "CAS" Then
			If sPos = "" Then sPos = "LIB_DET"
			sText = sText + " - Au moins une décision provenant de CASTORAMA est nécessaire pour régler l'interlocuteur CASTORAMA" + sNouvelleLigne
		End If
	End If
End If
*/

// [DT391-1]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 310)		
If lDeb > 0 And lIdGti = 7 Then
	sVal = Trim ( This.uf_GestOng_Divers_Trouver ("REFUS_SCB" ))
	If IsNull ( sVal ) Then sVal = ""
	
	If sVal = "" Then 
		If sPos = "" Then sPos = "ID_EVT"
		sText = sText + " - Le refus SCB" + sNouvelleLigne
	End If 
	
End If 

/*------------------------------------------------------------------*/
/* Affichage de la chaîne correspondant au message d'erreur         */
/*------------------------------------------------------------------*/
If	sPos <> "" Then

	stMessage.sTitre		= "Contrôle de saisie du détail"
	stMessage.Icon			= Information!
	stMessage.Bouton		= OK!
	stMessage.sVar[1] 	= sText
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "GENE001"

	f_Message ( stMessage )

	If	Not IsNull ( sOng ) And iuoOng.Uf_RecupererOngletCourant () <> sOng Then
		iuoOng.Uf_ChangerOnglet ( sOng )
	End If

Else
/*------------------------------------------------------------------*/
/* Le 21/04/1999. Modif. pour la couverture UF des autres cartes.   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Affichage d'un message non bloquant dans certains cas si la      */
/* zone NUM_CARTE est vide.                                         */
/*------------------------------------------------------------------*/
	// [VDOC28814]
/*
		If	IsNull ( sNumCarte ) And ( lIdGti = 7 )  And ( lIdEvt >=701 And lIdEvt <= 709 )	Then
	
			stMessage.sTitre		= "Contrôle de saisie du détail"
			stMessage.Icon			= Question!
			stMessage.Bouton		= YesNo!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "WDET230"
	
			lRet = F_Message ( stMessage )
	
			If	lRet = 2	Then
				sPos = "NUM_CARTE"
			End If
	
		End If
*/
End If

Return ( sPos )
end function

private subroutine uf_recalcul_autre_detail ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Recalcul_Autre_Detail (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Faut-il recalculer les autres détails ?
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail

Decimal {2} dcMtPlafCourant

String sRech

/*------------------------------------------------------------------*/
/* On va vérifier s'il existe au moins un plafond (680, 691, 692,   */
/* 693, 694).                                                       */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()

sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
				"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
				"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
				"ID_NIV_PLAF = '+EV'" 																			+ " AND " 	+ &
				"ID_REF_PLAF = "	+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) ) 	+ " AND " 	+ &
				"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
				" ( ID_TYP_PLAF = '680' OR ID_TYP_PLAF = '691' OR ID_TYP_PLAF = '692' OR ID_TYP_PLAF = '693' OR ID_TYP_PLAF = '694' )"

lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

If	lLig > 0 Then
	lTotDetail = idw_wDetailFF.iudwDetailSource.RowCount ()
/*------------------------------------------------------------------*/
/* On va vérifier les autres détails si le montant MT_PLAF diminue  */
/* par rapport à la valeur initiale, ou si le détail était bloqué.  */
/*------------------------------------------------------------------*/

	dcMtPlafCourant = idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF" )

	If	( dcMtPlafCourant < idcMtPlafInitial ) Or ( isAltBlocInitial = "O" ) Then
		For	lCpt = 1 To lTotDetail
/*------------------------------------------------------------------*/
/* On ne traite pas le détail courant.                              */
/*------------------------------------------------------------------*/
				If		idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_DETAIL" ) = lIdDetail	Then
						Continue
				Else
/*------------------------------------------------------------------*/
/* Si le détail est 'A REGLE' et qu'il est plafonné (ALT_PLAF =     */
/* OUI), on repositionne COD_ETAT à 'NON CONTROLE'.                 */
/*------------------------------------------------------------------*/
						If	idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 500 And &
							idw_wDetailFF.iudwDetailSource.GetItemString ( lCpt, "ALT_PLAF" ) = "O"	Then

							idw_wDetailFF.iudwDetailSource.SetItem ( lCpt, "COD_ETAT", 0 )

						End If
				End If
		Next
	End If
End If
	

end subroutine

private subroutine uf_preparersupprimer (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_wDetail::Uf_PreparerSupprimer
//* Auteur			: Erick John Stark
//* Date				: 28/01/1998 09:42:07
//* Libellé			: 
//* Commentaires	: On veut supprimer un détail
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sFiltre, sCle
Long lTotwPieceDetail, lTotwRefusDetail, lTotwPlafDetail, lLig, lIdDetail
Long	lTotCmdeDet, lTotDivDet, lCpt
Integer iRet
Boolean	bEffCmde

bEffCmde = False
iRet = 1
ibInsert = FALSE // [DCMP070056]

/*------------------------------------------------------------------*/
/* On vérifie si on se trouve sur l'onglet N° 01. (Onglet Detail).  */
/* On affiche un message qui demande si on veut supprimer le frais  */
/* courant                                                          */
/*------------------------------------------------------------------*/
If	iuoOng.Uf_RecupererOngletCourant () <> "01" Then
	iuoOng.Uf_ChangerOnglet ( "01" )
End If

/*------------------------------------------------------------------*/
/* y a-t-il des commandes pour ce détail ?                          */
/*------------------------------------------------------------------*/
If idw_LstCmdeDet.Rowcount () > 0 Then

	stMessage.sTitre		= "Suppression d'un détail"
	stMessage.Icon			= Question!
	stMessage.bouton	 	= YesNo!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "COMD022"

	If F_Message ( stMessage ) = 2 Then 
		astPass.bRetour = False
		Return
	Else
		bEffCmde = True
	End If
End If

/*------------------------------------------------------------------*/
/* Si on ne veut pas supprimer l'enregistrement, on s'arrete.       */
/* On ne propose se message que s'il n'y a pas de commande pour ne  */
/* pas surcharger.																  */
/*------------------------------------------------------------------*/
If Not bEffCmde Then
	stMessage.sTitre		= "Suppression d'un détail"
	stMessage.Icon			= Question!
	stMessage.sVar[1] 	= "ce détail "
	stMessage.bouton	 	= YesNo!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "GENE020"

	iRet = F_Message ( stMessage )
	If	iRet = 2 Then
		astPass.bRetour = False
		Return
	End If
End If

If iRet = 1 Then
/*------------------------------------------------------------------*/
/* On supprime un détail, il faut supprimer toutes les pièces et    */
/* les refus. L'optimisation - pour les commandes DELETE - sera     */
/* faîte sur la garantie.                                           */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* PIECE                                                            */
/*------------------------------------------------------------------*/

	sFiltre = "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + &
				 " AND ID_DETAIL = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )

	idw_wPiece_Detail.SetFilter ( sFiltre )
	idw_wPiece_Detail.Filter ()
	lTotwPieceDetail = idw_wPiece_Detail.RowCount ()

	idw_wPiece_Detail.RowsDiscard ( 1, lTotwPieceDetail, Primary! )

	sFiltre = ""
	idw_wPiece_Detail.SetFilter ( sFiltre )
	idw_wPiece_Detail.Filter ()

/*------------------------------------------------------------------*/
/* REFUS                                                            */
/*------------------------------------------------------------------*/

	sFiltre = "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + &
				 " AND ID_DETAIL = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )

	idw_wRefus_Detail.SetFilter ( sFiltre )
	idw_wRefus_Detail.Filter ()
	lTotwRefusDetail = idw_wRefus_Detail.RowCount ()

	idw_wRefus_Detail.RowsDiscard ( 1, lTotwRefusDetail, Primary! )

	sFiltre = ""
	idw_wRefus_Detail.SetFilter ( sFiltre )
	idw_wRefus_Detail.Filter ()

/*------------------------------------------------------------------*/
/* PLAFOND                                                          */
/*------------------------------------------------------------------*/

	sFiltre = "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + &
				 " AND ID_DETAIL = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )

	idw_wPPlafond_Detail.SetFilter ( sFiltre )
	idw_wPPlafond_Detail.Filter ()
	lTotwPlafDetail = idw_wPPlafond_Detail.RowCount ()

	idw_wPPlafond_Detail.RowsDiscard ( 1, lTotwPlafDetail, Primary! )

	sFiltre = ""
	idw_wPPlafond_Detail.SetFilter ( sFiltre )
	idw_wPPlafond_Detail.Filter ()

/*------------------------------------------------------------------*/
/* DETAIL_SUPP                                                      */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On insére une ligne pour le détail dans une DataWindow           */
/* external. En effet la liste des détails ne posséde pas d'objet   */
/* de transaction, donc il n'y a pas de buffer de suppression.      */
/*------------------------------------------------------------------*/
	lLig = idw_wDetailSupp.InsertRow ( 0 )
/*------------------------------------------------------------------*/
/* Ne jamais faire un SetItem avec un GetItemNumber (Problème de    */
/* précision). Il faut passer dans une variable intermédiaire.      */
/*------------------------------------------------------------------*/
	lIdDetail = idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" )
	idw_wDetailSupp.SetItem ( lLig, "ID_DETAIL", lIdDetail )

/*------------------------------------------------------------------*/
/* On supprime un détail, on va vérifier s'il faut repositionner    */
/* les autres détails.                                              */
/*------------------------------------------------------------------*/
	Uf_Recalcul_Autre_Detail ()

	lTotDivDet = idw_wDivDet.RowCount ()	
	For lCpt = lTotDivDet To 1 Step -1
		/*------------------------------------------------------------------*/
		/* La Dw doit avoir la capacité d'updater, afin que le buffer       */
		/* DELETE! soit pris en compte, ainsi la ligne sera placé dans le   */
		/* le buffer DELETE!																  */
		/*------------------------------------------------------------------*/
		idw_wDivDet.SetItemStatus ( lCpt, 0, PRIMARY!, DATAMODIFIED! )
		iRet = idw_wDivDet.DeleteRow ( lCpt )

	Next

	Uf_PreparerValider_OngDivers ()

/*------------------------------------------------------------------*/
/* Suppression des commandes liés au  détail.                       */
/* Seulement au niveau garantie, pas au niveau sinistre, car on peut*/
/* encore faire retour au niveau garantie.								  */
/*------------------------------------------------------------------*/
	If bEffCmde Then

		lTotCmdeDet = idw_LstCmdeDet.RowCount ()	
		For lCpt = lTotCmdeDet To 1 Step -1
			/*------------------------------------------------------------------*/
			/* La Dw doit avoir la capacité d'updater, afin que le buffer       */
			/* DELETE! soit pris en compte, ainsi la ligne sera placé dans le   */
			/* le buffer DELETE!																  */
			/*------------------------------------------------------------------*/
			idw_LstCmdeDet.SetItemStatus ( lCpt, 0, PRIMARY!, DATAMODIFIED! )
			iRet = idw_LstCmdeDet.DeleteRow ( lCpt )
		Next

		/*------------------------------------------------------------------*/
		/* Pour toutes les lignes contenues dans le buffer Deleted! de      */
		/* DwNivInf...                                                      */
		/* Le compteur est à l'envers, car on Détruit des rows sur IdwRe-   */
		/* questor dans Uf_CopierLigne												  */
		/*------------------------------------------------------------------*/
		lTotCmdeDet = idw_LstCmdeDet.DeletedCount () 

		For lCpt = lTotCmdeDet To 1 Step -1

		/*------------------------------------------------------------------*/
		/* ...on construit la clé de chaque enregistrement contenus dans    */
		/* le buffer Delete! de DwNivInf.                                   */
		/*------------------------------------------------------------------*/
			sCle = "ID_SEQ = " + String ( idw_LstCmdeDet.GetItemNumber ( lCpt, "ID_SEQ", DELETE!, TRUE ) ) 

		/*------------------------------------------------------------------*/
		/* Avec cette ligne identifiée, on effectue le traitement           */
		/* nécéssaire sur la DataWindow de niveau supérieur. Voir fonction  */
		/* Uf_CopierLigne.                                                  */
		/*------------------------------------------------------------------*/
			This.Uf_CopierLigne_Inf2Sup ( "BD", lCpt, sCle, iDw_LstCmdeGti, iDw_LstCmdeDet )

		Next

			
	End If

	astPass.bRetour = True
End If



	



end subroutine

private function string uf_plaf_adherent_renouvellement ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adherent_Renouvellement (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Application d'un plafond par adhérent/Année renouvellement
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012 [VDOC6662]
//       JFF   16/11/2015 [DT159-1]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale, lCptMax, lDeb, lFin
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafSav, dcPlafTmp, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdsDos, dcIdGti, dcIdEvt
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
n_cst_string lnvPFCString
Decimal{2} 	dcMtAutreSinistre
String		sMtAutreSinistre
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh

sPos = ""
/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '694'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
	lTotDetail = idw_wDetailFF.iudwDetailSource.RowCount ()
/*------------------------------------------------------------------*/
/* On s'occupe du détail courant, en insertion ou en modification.  */
/* Ce détail ne sera pas traité dans la boucle.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modification DBI le 12/08/1998                                   */
/*                                                                  */
/* La zone à prendre en compte pour le calcul du montant plafonné   */
/* n'est pas MT_NPLAF      mais MT_PLAF      sinon on ne            */
/* tient pas compte des plafonds appliqués successivement           */
/*------------------------------------------------------------------*/

	dcMtPlaf		= idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF"   )
	lIdDetail	= idw_wDetailFF.GetItemDecimal ( 1, "ID_DETAIL" )

	For	lCpt = 1 To lTotDetail
/*------------------------------------------------------------------*/
/* On ne traite pas le détail courant.                              */
/*------------------------------------------------------------------*/
			If		idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_DETAIL" ) = lIdDetail	Then
					Continue
			Else
/*------------------------------------------------------------------*/
/* Le détail est 'REGLE' ou 'A REGLE', on récupére le montant       */
/* MT_PLAF.                                                         */
/*------------------------------------------------------------------*/
					If	( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 500 Or &
						  idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 600	) And &
						( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) = idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_EVT" ) ) Then

						dcSommeDetail += idw_wDetailFF.iudwDetailSource.GetItemDecimal ( lCpt, "MT_PLAF" )
					End If
			End If
	Next

/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdsDos		= idw_wSin.GetItemNumber ( 1, "ID_SDOS" )
	dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
	dcIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
   sUntPerRnv_Adh		= idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
/*----------------------------------------------------------------------*/
/* On calcule la date du dernier renouvellement.                        */
/* En fonction de l'unité de periode de renouvellement (ANNEE,MOIS,JOUR)*/
/*----------------------------------------------------------------------*/
   Choose Case sUntPerRnv_Adh
	   Case "A"
	     lCptMax = 30
	   Case "M"
	     lCptMax = 360
	   Case "J"
	    lCptMax = 10950
	End Choose

	For	lCpt = 1 To lCptMax
			dDteResult = F_Plus_Date ( dDteAdh, dcDurPerRnv_Adh, sUntPerRnv_Adh )
			If	dDteResult <= idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )	Then
				dDteAdh = dDteResult
			Else
				Exit
			End If
	Next

	dtDteAdhRenouv 	= DateTime ( dDteAdh )
	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S04_W_DETAIL_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, dcIdGti, dcIdEvt, dtDteSurv, dtDteAdhRenouv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S04_W_DETAIL_MT_PLAF" )	Then
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée.                                    */
/*------------------------------------------------------------------*/
		sPos		= "ALT_BLOC"
		F_Message ( stMessage )
	Else
/*------------------------------------------------------------------*/
/* On détermine si on dépasse le plafond.                           */
/*------------------------------------------------------------------*/

		dcMtAutreSinistre = Dec ( sMtAutreSinistre )
		dcPlafond			= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcSommeDetail + dcMtAutreSinistre + dcMtPlaf > dcPlafond	Then

			If dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) > 0 Then
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) )

				// [PLAF_REF] // [VDOC6662]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "694", "REF_PLAF_NUM_>0" )
				
			ELse
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
				// [PLAF_REF]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "694", "NORMAL" )
			End If

			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )

/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "694", sIdPara, sCptVer )

			
		End If
	End If
End If
	
Return ( sPos )
end function

private function string uf_plaf_adherent_survenance ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adherent_Survenance (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Application d'un plafond par adhérent/Année survenace glissante
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF	  29/05/2012  [VDOC6662]
//        JFF    16/11/2015  [DT159-1]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale, lDeb, lFin
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafSav, dcPlafTmp, dcEcoTaxe
Long dcIdSin, dcIdProd, dcIdEts, dcIdsDos, dcIdGti, dcIdEvt
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
n_cst_string lnvPFCString
Decimal{2} 	dcMtAutreSinistre
String		sMtAutreSinistre

sPos = ""
/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par adhérent.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '692'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next
lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
	lTotDetail = idw_wDetailFF.iudwDetailSource.RowCount ()
/*------------------------------------------------------------------*/
/* On s'occupe du détail courant, en insertion ou en modification.  */
/* Ce détail ne sera pas traité dans la boucle.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modification DBI le 12/08/1998                                   */
/*                                                                  */
/* La zone à prendre en compte pour le calcul du montant plafonné   */
/* n'est pas MT_NPLAF      mais MT_PLAF      sinon on ne            */
/* tient pas compte des plafonds appliqués successivement           */
/*------------------------------------------------------------------*/

	dcMtPlaf		= idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF"   )
	lIdDetail	= idw_wDetailFF.GetItemDecimal ( 1, "ID_DETAIL" )

	For	lCpt = 1 To lTotDetail
/*------------------------------------------------------------------*/
/* On ne traite pas le détail courant.                              */
/*------------------------------------------------------------------*/
			If		idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_DETAIL" ) = lIdDetail	Then
					Continue
			Else
/*------------------------------------------------------------------*/
/* Le détail est 'REGLE' ou 'A REGLE', on récupére le montant       */
/* MT_PLAF.                                                         */
/*------------------------------------------------------------------*/
					If	( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 500 Or &
						  idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 600	) And &
						( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) = idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_EVT" ) ) Then

						dcSommeDetail += idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "MT_PLAF" )
					End If
			End If
	Next

/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdsDos		= idw_wSin.GetItemNumber ( 1, "ID_SDOS" )
	dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
	dcIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	dcMtAutreSinistre = 0
	sMtAutreSinistre = "             "

	itrTrans.PS_S02_W_DETAIL_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, dcIdGti, dcIdEvt, dtDteSurv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S02_W_DETAIL_MT_PLAF" )	Then
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée.                                    */
/*------------------------------------------------------------------*/
		sPos		= "ALT_BLOC"
		F_Message ( stMessage )
	Else
/*------------------------------------------------------------------*/
/* On détermine si on dépasse le plafond.                           */
/*------------------------------------------------------------------*/

		dcMtAutreSinistre = Dec ( sMtAutreSinistre )
		dcPlafond			= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )


		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcSommeDetail + dcMtAutreSinistre + dcMtPlaf > dcPlafond	Then
			
			If dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) > 0 Then
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) )

				// [PLAF_REF] // [VDOC6662]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "692", "REF_PLAF_NUM_>0" )

			Else 
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 ) 
				// [PLAF_REF]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "692", "NORMAL" )
			End If

			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "692", sIdPara, sCptVer )
			
			
		End If
	End If

End If
	
Return ( sPos )
end function

private function string uf_plaf_adhesion_renouvellement ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adhesion_Renouvellement (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Application d'un plafond par adhésion/Année renouvellement
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF	  29/05/2012 [VDOC6662]
//        JFF    16/11/2015 [DT159-1]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale, lCptMax, lDeb, lFin
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafSav, dcPlafTmp, dcEcoTaxe
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdEvt
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
n_cst_string lnvPFCString
Decimal{2} 	dcMtAutreSinistre
String		sMtAutreSinistre
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh

sPos = ""
/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '693'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
	lTotDetail = idw_wDetailFF.iudwDetailSource.RowCount ()
/*------------------------------------------------------------------*/
/* On s'occupe du détail courant, en insertion ou en modification.  */
/* Ce détail ne sera pas traité dans la boucle.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modification DBI le 12/08/1998                                   */
/*                                                                  */
/* La zone à prendre en compte pour le calcul du montant plafonné   */
/* n'est pas MT_NPLAF      mais MT_PLAF      sinon on ne            */
/* tient pas compte des plafonds appliqués successivement           */
/*------------------------------------------------------------------*/

	dcMtPlaf		= idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF"   )
	lIdDetail	= idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" )

	For	lCpt = 1 To lTotDetail
/*------------------------------------------------------------------*/
/* On ne traite pas le détail courant.                              */
/*------------------------------------------------------------------*/
			If		idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_DETAIL" ) = lIdDetail	Then
					Continue
			Else
/*------------------------------------------------------------------*/
/* Le détail est 'REGLE' ou 'A REGLE', on récupére le montant       */
/* MT_PLAF.                                                         */
/*------------------------------------------------------------------*/
					If	( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 500 Or &
						  idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 600	) And &
						( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) = idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_EVT" ) ) Then

						dcSommeDetail += idw_wDetailFF.iudwDetailSource.GetItemDecimal ( lCpt, "MT_PLAF" )
					End If
			End If
	Next

/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
	dcIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
   sUntPerRnv_Adh		= idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
/*----------------------------------------------------------------------*/
/* On calcule la date du dernier renouvellement.                        */
/* En fonction de l'unité de periode de renouvellement (ANNEE,MOIS,JOUR)*/
/*----------------------------------------------------------------------*/
   Choose Case sUntPerRnv_Adh
	   Case "A"
	     lCptMax = 30
	   Case "M"
	     lCptMax = 360
	   Case "J"
	    lCptMax = 10950
	End Choose

	For	lCpt = 1 To lCptMax
			dDteResult = F_Plus_Date ( dDteAdh, dcDurPerRnv_Adh, sUntPerRnv_Adh )
			If	dDteResult <= idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )	Then
				dDteAdh = dDteResult
			Else
				Exit
			End If
	Next

	dtDteAdhRenouv 	= DateTime ( dDteAdh )
	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S03_W_DETAIL_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, dcIdEvt, dtDteSurv, dtDteAdhRenouv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S03_W_DETAIL_MT_PLAF" )	Then
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée.                                    */
/*------------------------------------------------------------------*/
		sPos		= "ALT_BLOC"
		F_Message ( stMessage )
	Else
/*------------------------------------------------------------------*/
/* On détermine si on dépasse le plafond.                           */
/*------------------------------------------------------------------*/

		dcMtAutreSinistre = Dec ( sMtAutreSinistre )
		dcPlafond			= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If


		If	dcSommeDetail + dcMtAutreSinistre + dcMtPlaf > dcPlafond	Then
				
			If dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) > 0 Then
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) )
				
				// [PLAF_REF]// [VDOC6662] 
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "693", "REF_PLAF_NUM_>0" )

				
			Else
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
				
				// [PLAF_REF]
				ibPlafNumeraire = TRUE // [PLAF_REF]				
				sPos = Uf_Plaf_Refus ( "693", "NORMAL" )
			End If
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )

/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "693", sIdPara, sCptVer )
			
			
		End If
	End If
End If
	
Return ( sPos )
end function

private function string uf_plaf_adhesion_survenance ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adhesion_Survenance (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Application d'un plafond par adhésion/Année survenace glissante
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012 [VDOC6662]
//       JFF   16/11/2015 [DT159-1]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale, lDeb, lFin
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafSav, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdEvt
Decimal{2} 	dcMtAutreSinistre, dcPlafTmp
String		sMtAutreSinistre, sIdNivPlaf, sIdRefPlaf
n_cst_string lnvPFCString
DateTime dtDteSurv

String sRech, sPos, sIdAdh, sIdPara, sCptVer

sPos = ""
/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '691'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
	lTotDetail = idw_wDetailFF.iudwDetailSource.RowCount ()
/*------------------------------------------------------------------*/
/* On s'occupe du détail courant, en insertion ou en modification.  */
/* Ce détail ne sera pas traité dans la boucle.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modification DBI le 12/08/1998                                   */
/*                                                                  */
/* La zone à prendre en compte pour le calcul du montant plafonné   */
/* n'est pas MT_NPLAF      mais MT_PLAF      sinon on ne            */
/* tient pas compte des plafonds appliqués successivement           */
/*------------------------------------------------------------------*/

	dcMtPlaf		= idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF"   )
	lIdDetail	= idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" )

	For	lCpt = 1 To lTotDetail
/*------------------------------------------------------------------*/
/* On ne traite pas le détail courant.                              */
/*------------------------------------------------------------------*/
			If		idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_DETAIL" ) = lIdDetail	Then
					Continue
			Else
/*------------------------------------------------------------------*/
/* Le détail est 'REGLE' ou 'A REGLE', on récupére le montant       */
/* MT_PLAF.                                                         */
/*------------------------------------------------------------------*/
					If	( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 500 Or &
						  idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 600	) And &
						( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) = idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_EVT" ) ) Then

						dcSommeDetail += idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "MT_PLAF" )
					End If
			End If
	Next
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )

	dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
	dcIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	dcMtAutreSinistre = 0
	sMtAutreSinistre = "             "

	itrTrans.PS_S01_W_DETAIL_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, dcIdEvt, dtDteSurv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S01_W_DETAIL_MT_PLAF" )	Then
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée.                                    */
/*------------------------------------------------------------------*/
		sPos		= "ALT_BLOC"
		F_Message ( stMessage )
	Else
/*------------------------------------------------------------------*/
/* On détermine si on dépasse le plafond.                           */
/*------------------------------------------------------------------*/

		dcMtAutreSinistre = Dec ( sMtAutreSinistre )
		dcPlafond			= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcSommeDetail + dcMtAutreSinistre + dcMtPlaf > dcPlafond	Then

			If dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) > 0 Then
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) )

				// [PLAF_REF] // [VDOC6662]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "691", "REF_PLAF_NUM_>0" )				
				
			Else 
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
				// [PLAF_REF]
				ibPlafNumeraire = TRUE // [PLAF_REF]				
				sPos = Uf_Plaf_Refus ( "691", "NORMAL" )
			End If
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )

/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "691", sIdPara, sCptVer )
			
		End If
	End If
End If
	
Return ( sPos )
end function

private function string uf_calcul_montantregle ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Calcul_MontantRegle (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Calcul du Montant à régler
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 CAG		 14/06/04	DCMP 040176 : création d'un plafond par année civile
//* #2	 CAG		 25/06/04	Calcul de la franchise après les plafonds
//* #3	 PHG		 16/04/07	[DCMP060777] : Ajout des plafonds 707 a 710
//*									( Nb Ev adherent|adhesion/renouvellement|survenance )	
//*	 #4 PHG		 24/12/2009  [O2M_DIAG_NOMADE].Lot2 Point 3.1
//*       JFF      27/07/11   [PLAF_REF]
//        JFF      24/01/2012 [CONFO][CUISINE]
//        JFF      21/12/2012 [VDOC9650]
//        JFF      31/07/2013 [PC845_NOUVPLAF]
//        JFF      31/07/2013 [PC845_NOUVPLAF741]
//        JFF      04/10/2013 [VDOC11880]
//        JFF   	 24/09/2015 [PC13442][ITSM326391]
// 		 JFF      04/10/2017 [VDOC24781]
//        JFF      16/10/2018 [PC171999]
//        JFF      26/11/2019 [PC192290]
//        JFF      08/09/2020 [PC202551_PLAF_759]
//*-----------------------------------------------------------------

String sPos, sFind
Boolean bCasto, bBloque 
Long lCpt, lTotPlafond, lRow, lDeb, lFin
Date dDteFact
String sNumFacture, sIdGti, sIdDetail

Decimal {2} dcMtPrej, dcMtPlaf

sPos = ""

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 43 )
bCasto = lDeb > 0

bBloque = idw_wDetailFF.GetItemString ( 1, "ALT_BLOC" ) = "O"

/*------------------------------------------------------------------*/
/* On positionne les toutes les valeurs à zéro. Ensuite si le       */
/* détail est 'A REGLE', on démarre le calcul (Franchise, Plafond). */
/*------------------------------------------------------------------*/
idw_wDetailFF.SetItem ( 1, "MT_NPLAF", 0.00 )
idw_wDetailFF.SetItem ( 1, "MT_FRAN", 	0.00 )
idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "N" )


If sPos <> "" Then Return sPos

If	idw_wDetailFF.GetItemString ( 1, "ALT_REG" ) = "N"	Then
	idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0.00 )
End If

If	idw_wDetailFF.GetItemNumber ( 1, "COD_ETAT" ) = 500	Then
	// #4 [O2M_DIAG_NOMADE].Lot2 Point 3.1
	if	uf_controlergestion_o2m_apprecuprecycl() and & 
		idw_wDetailFF.GetItemString ( 1, "ALT_REG" ) = "N" Then
		
		stMessage.sTitre		= "Process"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "WDET571"
		F_Message ( stMessage )
		sPos = "ALT_BLOC"
		return sPos 	

	End If // :[O2M_DIAG_NOMADE].Lot2 Point 3.1
	
	/*------------------------------------------------------------------*/
	/* Si la date de facture est visible, alors elle doit être          */
	/* renseignée pour régler.                                          */
	/*------------------------------------------------------------------*/
	If sPos = "" And idw_wDetailFF.Describe ( "dte_facture.visible" ) = "1" Then

		sIdGti = String (idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ))
		sIdDetail = String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ))

		sFind = "ID_GTI = " + sIdGti + " AND ID_DETAIL = " + sIdDetail

		// PC938_ORV3_FACTU
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 239 )
		If lDeb > 0 Then
			sFind += " AND ID_REF_FOUR NOT IN ( 'A_DIAGNOSTIQUER' ) AND ID_TYP_ART NOT IN ( 'RES', 'REA', 'REL' )"
		End If

		// [PC13442][ITSM326391]
		If lDeb <=0 Then
			lRow=idw_wdivsin.Find("NOM_ZONE='ech_express_48h'", 1, idw_wdivsin.RowCount())
			If lRow > 0 Then
				If idw_wdivsin.GetItemString(lRow, "VAL_CAR") = "O" Then
					sFind += " AND ID_REF_FOUR NOT IN ( 'A_DIAGNOSTIQUER' )"						
				End If 
			End if
		End If 
		// :[PC13442][ITSM326391]


		lRow = idw_LstCmdeDet.Find ( sFind , 1, idw_LstCmdeDet.RowCount () )

		If lRow > 0 Then
			Choose Case idw_LstCmdeDet.GetItemString ( lRow, "COD_ETAT" )

				// [VDOC9650] supp de "ECL"
				// ITSM205361 ajout DEF
				Case "RPC", "ANN", "RFO", "RSP", "DEF"
					// On peut régler
				Case Else
					stMessage.sTitre		= "Date de facture"
					stMessage.Icon			= Information!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= OK!
					stMessage.sCode		= "COMD424"
					F_Message ( stMessage )
					sPos = "DTE_FACTURE"

			End Choose 
		End If


		dDteFact = Date( idw_wDetailFF.GetItemDateTime ( 1, "DTE_FACTURE" ) ) // [PI056]
		If sPos = "" and IsNull ( dDteFact ) Or dDteFact = 1900-01-01 Then
			stMessage.sTitre		= "Date de facture"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WDET240"
			F_Message ( stMessage )
			sPos = "DTE_FACTURE"
		End If


		sNumFacture = idw_wDetailFF.GetItemString ( 1, "NUM_FACTURE" )
		If sPos = "" and ( IsNull ( sNumFacture ) Or sNumFacture = "" ) Then
			stMessage.sTitre		= "Numéro de facture"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WDET241"
			F_Message ( stMessage )
			sPos = "NUM_FACTURE"
		End If
		If sPos <> "" Then Return sPos
	
	End If 

	dcMtPrej = idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" )
/*------------------------------------------------------------------*/
/* Si le réglement est forcé, on positionne le montant MT_PLAF      */
/* dans MT_NPLAF.                                                   */
/*------------------------------------------------------------------*/
	If	idw_wDetailFF.GetItemString ( 1, "ALT_REG" ) = "O"	Then
/*------------------------------------------------------------------*/
/* Ne jamais faire un SetItem avec un GetItemNumber (Problème de    */
/* précision). Il faut passer dans une variable intermédiaire.      */
/*------------------------------------------------------------------*/
		dcMtPlaf = idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF" )
		idw_wDetailFF.SetItem ( 1, "MT_NPLAF", dcMtPlaf )
	Else
		idw_wDetailFF.SetItem ( 1, "MT_NPLAF", dcMtPrej )
		idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcMtPrej )

/*------------------------------------------------------------------*/
/* Si nous sommes en gestion GMP (Gti Meill. Prix), on corrige      */
/* MT_NPLAF et MT_PLAF )                                            */
/*------------------------------------------------------------------*/
		This.uf_Calcul_MontantRegle_Gti_GMP ( dcMtPrej )

/*------------------------------------------------------------------*/
/* On positionne la zone ALT_BOUGE de DW_PLAF_DETAIL à              */
/* (S)upprime. Cela va nous permettre de savoir si on vient de      */
/* toucher aux plafonds. On optimise ainsi les commandes SQL.       */
/*------------------------------------------------------------------*/
		lTotPlafond = idw_wPlaf_Detail.RowCount ()
		For	lCpt = 1 To lTotPlafond
			idw_wPlaf_Detail.SetItem ( lCpt, "ALT_BOUGE", "S" )
		Next

		// [PLAF_REF]
		If sPos = "" Then sPos = Uf_Plaf_Evt ()
		If sPos = "" Then sPos = Uf_Plaf_Sin ()
		If sPos = "" Then sPos = Uf_Plaf_Sin_Carte ()
		// [PLAF_REF]


		If sPos = ""	Then sPos = Uf_Plaf_Adhesion_Survenance ()
		If sPos = ""	Then sPos = Uf_Plaf_Adherent_Survenance ()

		If sPos = ""	Then sPos = Uf_Plaf_Adhesion_Renouvellement ()
		If sPos = ""	Then sPos = Uf_Plaf_Adherent_Renouvellement ()

	/*------------------------------------------------------------------*/
	/* #1                                                               */
	/*------------------------------------------------------------------*/
		If sPos = ""	Then sPos = Uf_Plaf_Adhesion_Annee_Civile ()
		If sPos = ""	Then sPos = Uf_Plaf_Adherent_Annee_Civile ()

		// [VDOC24781]
		If sPos = "" Then sPos = Uf_Plaf_Adhesion_Annee_Civile_tt_gti ()

// [PC845_NOUVPLAF]
		If sPos = ""	Then sPos = Uf_Plaf_Adhesion_Annee_Civile_val_achat ()
		If sPos = ""	Then sPos = Uf_Plaf_Adherent_Annee_Civile_val_achat ()

// [PC845_NOUVPLAF741]
		If sPos = ""	Then sPos = This.Uf_Plaf_Evt1397_regle_resil_adh ()

		If sPos = ""	Then sPos = Uf_Plaf_NbEv_Gti_Adhesion_Survenance ()
		If sPos = ""	Then sPos = Uf_Plaf_NbEv_Gti_Adherent_Survenance ()
		If sPos = ""	Then sPos = Uf_Plaf_NbEv_Gti_Adhesion_Renouvellement ()
		If sPos = ""	Then sPos = Uf_Plaf_NbEv_Gti_Adherent_Renouvellement ()

		// [VDOC11880]
		If sPos = ""  Then sPos = Uf_plaf_NbEv_Gti_Adhesion_Renou_Dte_Surv ()
		
		// [DCMP060777] PHG 16/04/2007 : Nouveau plafonds 707 a 710
		If sPos = ""	Then sPos = Uf_Plaf_NbEv_Sin_Adhesion_Survenance ()
		If sPos = ""	Then sPos = Uf_Plaf_NbEv_Sin_Adherent_Survenance ()
		If sPos = ""	Then sPos = Uf_Plaf_NbEv_Sin_Adhesion_Renouvellement ()
		If sPos = ""	Then sPos = Uf_Plaf_NbEv_Sin_Adherent_Renouvellement ()
		
		// [CONFO][CUISINE][PC680]	
		If sPos = ""	Then sPos = Uf_Plaf_NbEv_Gti_Adhesion()
		If sPos = ""	Then sPos = uf_plaf_nbcodergpt_distinct_gti_adhesion ()

		// [PC171999]
		If sPos = "" Then sPos = Uf_Plaf_Adhesion_Renouv_TypePers ()

		// [PC192290]
		If sPos = "" Then sPos = Uf_Plaf_Adhesion_Survenance_TteGti ()
	
		// [PC202551_PLAF_759]
		If sPos = "" Then sPos = Uf_Plaf_Adhesion_Survenance_GtiDp351 ()	
	
/*------------------------------------------------------------------*/
/* #2 CAG 25/06/2004 : cet appel était avant le calcul des plafonds */
/*------------------------------------------------------------------*/
/* On va maintenant appliquer une franchise éventuelle, puis les    */
/* plafonds successifs dans le cas ou on ne force pas le règlement. */
/*------------------------------------------------------------------*/
		Uf_Fran_Fixe ()

		// Ctrl Castorama
		If bCasto And Not bBloque  Then
			If This.uf_GestOng_Divers_Trouver ("PEC" ) = "N" Then
			stMessage.sTitre		= "Prise en charge"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WDET340"
			F_Message ( stMessage )
			sPos = "LIB_DET"
		End If
	 End If


	End If
End If	

/*------------------------------------------------------------------*/
/* Si le détail n'est pas bloqué, on va vérifier s'il faut          */
/* repositionner les autres détails.                                */
/*------------------------------------------------------------------*/
If	Not bBloque And sPos = "" Then
	Uf_Recalcul_Autre_Detail ()
End If

Return ( sPos )
end function

private subroutine uf_calculer_dt_1er_uf ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Calculer_Dt_1er_Uf (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 09/04/1998 17:30:47
//* Libellé			: 
//* Commentaires	: On calcule la date de 1ère utilisation frauduleuse
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lTotDetail, lCpt, lIdGti

Date dDteDet, dDteMini, dDteDetCour

Decimal {0} dcIdDetail

dDteMini 	= stNul.Dat
lTotDetail	= idw_LstDetail.RowCount ()
dcIdDetail  = idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) 

/*------------------------------------------------------------------*/
/* On gère la date du détail actuel                                 */
/* si elle n'est pas null on initialise date mini avec              */
/*------------------------------------------------------------------*/

dDteDetCour = Date ( idw_wDetailFF.GetItemDateTime ( 1, "DTE_DET" ) )
If	Not IsNull ( dDteDetCour )	Then

		dDteMini = dDteDetCour
End If


/*------------------------------------------------------------------*/
/* Le 27/05/1999.                                                   */
/* Modif DGA. Gestion des UF Téléphone Mobile.                      */
/*------------------------------------------------------------------*/
lIdGti = idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
If	lIdGti = 7 Or lIdGti = 8	Then

	For	lCpt = 1 To lTotDetail
/*------------------------------------------------------------------*/
/* On calcule la plus petite date de tous les détails, qui ne sont  */
/* pas SANS SUITE.                                                  */
/*------------------------------------------------------------------*/

			If	idw_LstDetail.GetItemNumber ( lCpt, "ID_DETAIL" ) <> dcIdDetail	And &
			   idw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" )  <> 900				Then

/*----------------------------------------------------------------------------*/
/* Modification DBI : le 12/08/1998                                           */
/* La zone DTE_DET_DATE n'est renseignée que lors de la saisie d'un détail    */
/* et n'est utile qu'à ce moment                                              */
/*                                                                            */
/* si on vient uniquement sur la garantie sans contrôler et valider le        */
/* détail                                                                     */
/* elle n'est pas renseignée                                                  */
/*                                                                            */
/* Seule la zone DTE_DET ( format datetime ) est toujours valide.             */
/*                                                                            */
/* Je remplace donc                                                           */
/* 	dDteDet = idw_LstDetail.GetItemDate ( lCpt, "DTE_DET_DATE" )              */
/*----------------------------------------------------------------------------*/

				dDteDet = Date ( idw_LstDetail.GetItemDateTime ( lCpt, "DTE_DET" ) )
				If	Not IsNull ( dDteDet )	Then
/*------------------------------------------------------------------*/
/* Si tous les détails sont SANS SUITE, il faut mettre la zone      */
/* DTE_1ER_UF à NULL.                                               */
/*------------------------------------------------------------------*/
					If	IsNull ( dDteMini )	Then
						dDteMini = dDteDet
					Else
						If	dDteDet < dDteMini	Then
							dDteMini = dDteDet
						End If
					End If
				End If
			End If
	Next
End If

idw_wGarSin.SetItem ( 1, "DTE_1ER_UF", Datetime(dDteMini) ) // [PI056]
end subroutine

private function boolean uf_rf_625 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_625 (PRIVATE)
//* Auteur			: DBI
//* Date				: 23/09/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Délai 1er Uf/Dte Det
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Délai paramatrés sur les +NS, +DT, +TR
//*								  déclenché surle contrôle de garantie.
//* #2		PHG	26/10/2009 [DCMP071000] rf 655+651: Annexe : Correction Bug
//*								  présent sur toute les fonctions de refus.
//*-----------------------------------------------------------------

Long lTotDelai, lLig, lDuree, lCpt 
String sIdNivDel, sIdRefDel
Boolean bRet

String sRech, sUnite

Date	dDte1erUf, dDteDet, dDteMax

bRet				= True
lTotDelai 		= idw_Delai.RowCount ()

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 1 to 5

	Choose Case lCpt
		Case 1
			sIdNivDel = "-GA"  // Garantie
			sIdRefDel = "-1"
		Case 2
			sIdNivDel = "+NS"  // Nature de sinistre
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivDel = "+TR"  // Territorialité
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivDel = "+DT"  // Détail de sinistre
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivDel = "+EV"  // Evénement de garantie
			sIdRefDel = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )


	End Choose

	If IsNull ( sIdRefDel ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un délai 625 pour la garantie.            */
	/*------------------------------------------------------------------*/
	// #2 [DCMP071000] Lecture ID_GTI dans idw_wDetailFF ald de idw_wGarSin
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_DEL = '"  + sIdNivDel 																+ "' AND " 	+ &
					"ID_REF_DEL = "	+ sIdRefDel 																+ " AND " 	+ &
					"ID_TYP_DEL = '625'"

	lLig = idw_Delai.Find ( sRech, 1, lTotDelai )


	If	lLig > 0 Then
	/*------------------------------------------------------------------*/
	/* On récupére le délai maximum autorisé entre la survenance du     */
	/* sinistre et la date de déclaration. On vérifie si ce délai est   */
	/* dépassé.                                                         */
	/*------------------------------------------------------------------*/

		dDte1erUF= Date (idw_wGarSin.GetItemDateTime ( 1, "DTE_1ER_UF" ) ) // [PI056]
		dDteDet 	= Date ( idw_wDetailFF.GetItemDateTime ( 1, "DTE_DET" ) )

		sUnite	= idw_Delai.GetItemString ( lLig, "UNT_DEL" )
		lDuree	= idw_Delai.GetItemNumber ( lLig, "DUR_MAX" )

		dDteMax	= F_Plus_Date ( dDte1erUf, lDuree, sUnite )

		If	dDteDet > dDteMax	Then
		/*------------------------------------------------------------------*/
		/* La durée maximum est dépassée, on déclenche le refus 625.        */
		/*------------------------------------------------------------------*/
			bRet = Uf_RF_EcrireRefus ( 625 )
		End If

	End If
Next

Return ( bRet )
end function

private function boolean uf_rf_622 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_622 (PRIVATE)
//* Auteur			: DBI
//* Date				: 23/09/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Délai date det/Dte survenance
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Délai paramatrés sur les +NS, +DT, +TR
//*								  déclenché surle contrôle de garantie.
//* #2	 PHG	  04/04/2007  [DCMP070234] Prise en compte du delai *Min* du délais 622
//*								  Cas de déclechement du refus :
//*								  			DMax         Dmin        Dsurv
//*								  1 : Dt---[------------]--------------|---- => Refus
//*								  2 :   ---[----Dt------]--------------|---- => Ok
//*								  3 :   ---[------------]----Dt--------|---- => Refus
//*								  4 :   ---[------------]--------------|--Dt => Refus
//* #3		PHG	26/10/2009 [DCMP071000] rf 655+651: Annexe : Correction Bug
//*								  présent sur toute les fonctions de refus.
//*        JFf    23/12/2010 [VDOC6416][PC494]
//*-----------------------------------------------------------------
Long 		lTotDelai, lLig, lDuree, lNbJour, lNbHeu, lHeuDet, lHeuMax, lCpt, lDeb, lFin, lCpt2, lRow
Boolean 	bRet
String 	sRech, sUnite, sHeuDet, sHeuSurv, sIdNivDel, sIdRefDel, sTypDatePivot, sIdGti
Date		dDteSurv, dDteDet, dDteMax, dtDteRelassComm 
Time		hHeuMax
DateTime dtDteMax, dtSurv
long 		lDelaiMin // [DCMP070234]Délai pour calculer la Dmin à partir de Dsurv
DateTime	dtDteMin  // DateTime Min pour lequel le dt doit etre *INFERIEUR OU EGAL* 
long 		lNbJrMin, lNbHMin, lHeuMin // Variables de calcul de dtDteMin
time		hHeuMin							// Variables de calcul de dtDteMin, suite
date		dDteMin							// Date Min pour lequel le dt doit etre *INFERIEUR OU EGAL* 
												// si le calcul est en jours
DateTime	dtDteDet							// DateTime du Detail, pendant de dDteDet
n_cst_string lnvPFCString

bRet				= True
lTotDelai 		= idw_Delai.RowCount ()


/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 1 to 5

	Choose Case lCpt
		Case 1
			sIdNivDel = "-GA"  // Garantie
			sIdRefDel = "-1"
		Case 2
			sIdNivDel = "+NS"  // Nature de sinistre
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivDel = "+TR"  // Territorialité
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivDel = "+DT"  // Détail de sinistre
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivDel = "+EV"  // Evénement de garantie
			sIdRefDel = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )


	End Choose

	If IsNull ( sIdRefDel ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un délai de déclaration pour la garantie. */
	/*------------------------------------------------------------------*/
	// #3 [DCMP071000] Lecture ID_GTI dans idw_wDetailFF ald de idw_wGarSin
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_DEL = '"  + sIdNivDel 																+ "' AND " 	+ &
					"ID_REF_DEL = "	+ sIdRefDel 																+ " AND " 	+ &
					"ID_TYP_DEL = '622'"

	lLig = idw_Delai.Find ( sRech, 1, lTotDelai )


	If	lLig > 0 Then

	/*------------------------------------------------------------------*/
	/* Le cas du délai en heure est géré à part car on doit travailler  */
	/* sur des datetime et non sur des dates.                           */
	/* De plus, on ne peut pas utiliser uniquement f_plus_date pour le  */
	/* calcul de la date de référence                                   */
	/*------------------------------------------------------------------*/

		sUnite	= idw_Delai.GetItemString ( lLig, "UNT_DEL" )
		lDuree	= idw_Delai.GetItemNumber ( lLig, "DUR_MAX" )
		// [DCMP070234]On lit le délai minimum
		lDelaiMin = idw_Delai.GetItemNumber ( lLig, "DUR_MIN" )
		//
		dDteDet 	= Date ( idw_wDetailFF.GetItemDateTime ( 1, "DTE_DET" ) )

		dDteSurv	= idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) 

		// [VDOC6416][PC494]
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 204 )
		For lCpt2 = lDeb To lFin
			sIdGti = Trim ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lCpt2, "VAL_CAR" ), "ID_GTI", ";"))
			
			If sIdGti = String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) Then
				sTypDatePivot = Trim ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lCpt2, "VAL_CAR" ), "TYPE_DTE_PIVOT", ";"))
				
				Choose Case sTypDatePivot
					Case "DTE_RELANCE_ASS_COMM"
						lRow = idw_WDivSin.Find ( "Upper (NOM_ZONE) = 'DTE_RELANCE_ASS_COMM'", 1, idw_WDivSin.RowCount () ) 

						If lRow <= 0 Then 
							bRet = Uf_RF_EcrireRefus ( 622 )
							Return bRet
						Else
							dtDteRelassComm = Date(idw_WDivSin.GetItemDateTime ( lRow, "VAL_DTE" ))	// [PI056].20190926
							If IsNull ( dtDteRelassComm ) Then 
								bRet = Uf_RF_EcrireRefus ( 622 )
								Return bRet
							End If
							
							// On affecte dtDteRelassComm à dDteSurv et on laisse se poursuivre le reste de la fonction
							dDteSurv = dtDteRelassComm 
						
						End If

					Case "DTE_SURV"							
						// On ne fait rien, c'est le défaut.
				End CHoose
				
			End If
		Next
		// :[VDOC6416][PC494]

		If sUnite = 'H' Then

	/*------------------------------------------------------------------*/
	/* on additionne les heures à la date du détail.                    */
	/* On commence par déterminer à combien de jours et d'heures        */
	/* correspond lDuree                                                */
	/*------------------------------------------------------------------*/

			lNbJour	=	Truncate ( ( lDuree / 24 ), 0 )		// Partie entière du nombre d'heures / 24
			lNbHeu	=	Mod ( lDuree, 24 )						// Reste de la division du nb heures / 24
			
			sHeuDet	=	idw_wDetailFF.GetItemString 	( 1, "HEU_DET" )		
			sHeuSurv	=	idw_wSin.GetItemString 			( 1, "HEU_SURV" )		

			// [DCMP070234] On calcule le nombre de jour + heure que représente le délai min
			lNbJrMin	=	Truncate ( ( lDelaiMin / 24 ), 0 )
			lNbHMin  =	Mod ( lDelaiMin, 24 )
			//
			
			// Si la comparaison peut se faire en heure ( Heure de sruvenance & heure de detail OK )
			If ( Not isNull ( sHeuDet  ) )					And	&
				( Not isNull ( sHeuSurv ) )					Then

				lHeuDet	=  Long ( Left ( sHeuDet, 2 ) )
				lHeuMax  =  lHeuDet + lNbHeu

	/*------------------------------------------------------------------*/
	/* Si le nombre d'heures obtenu dépasse une journée, on ajoute un   */
	/* jour et on enlève 24 heures à heuMax                             */
	/*------------------------------------------------------------------*/

				If lHeuMax > 23 Then

					lHeuMax 	= lHeuMax - 24
					lNbJour	++
				End If

				hHeuMax	= Time ( String ( lHeuMax ) + ':' + Right ( sHeuDet, 2 ) )
				dDteMax	= F_Plus_Date ( dDteDet, lNbJour, 'J' )

	/*------------------------------------------------------------------*/
	/* Conversion de dDteMax et hHeuMax en datetime pour comparaison    */
	/* avec dtSurv                                                      */
	/*------------------------------------------------------------------*/

				dtDteMax = DateTime ( dDteMax, hHeuMax )
				dtSurv	= DateTime ( dDteSurv, Time ( Left ( sHeuSurv, 2 ) + ':' + Right ( sHeuSurv, 2 ) ) )

	// [DCMP070234] On calcule sur le meme principe la dateMin mais en partant de DteSurv,
	// et avec un calcul a reours ( soustraction de date et heure et non plus addition )
				lHeuMin  = Long ( Left ( sHeuSurv, 2 ) ) - lNbHMin
				If lHeuMin <0 Then // Si le nombre d'heure resultant est négatif
					lHeuMin 	= 24 - abs(lHeuMin) // On détermine l'heure correcte en prenant 
														  // le complement à 24
					lNbJrMin	--						  // On enlève un jour
				End If
				hHeuMin	= Time ( String ( lHeuMin ) + ':' + Right ( sHeuSurv, 2 ) )
				dDteMin  = F_Plus_Date ( dDteSurv, lNbJrMin * -1, 'J' ) // On calcule a rebours
				dtDteMin = DateTime (dDteMin, hHeuMin)
				// on calcule aussi le datetime du detail
				dtDteDet = DAteTime (dDteDet, Time ( Left ( sHeuDet, 2 ) + ':' + Right ( sHeuDet, 2 ) ) )
	//
				
				If	dtSurv > dtDteMax	or dtDteDet > dtDteMin Then // [DCMP070234] on teste aussi la borne Min
	/*------------------------------------------------------------------*/
	/* La durée maximum est dépassée, on déclenche le refus 622.        */
	/*------------------------------------------------------------------*/
					bRet = Uf_RF_EcrireRefus ( 622 )
				End If

			Else

				dDteMax	= F_Plus_Date ( dDteDet, lNbJour, 'J' )
				dDteMin  = F_Plus_Date ( dDteSurv, lNbJrMin * -1, 'J' ) // [DCMP070234] On calcule a rebours

				If	dDteSurv > dDteMax or dDteDet > dDteMin	Then // [DCMP070234] On teste en plus le délais min
		/*------------------------------------------------------------------*/
		/* La durée maximum est dépassée, on déclenche le refus 622.        */
		/*------------------------------------------------------------------*/
					bRet = Uf_RF_EcrireRefus ( 622 )
				End If
			End If

		Else

			dDteMax	= F_Plus_Date ( dDteDet, lDuree, sUnite )
			dDteMin  = F_Plus_Date ( dDteSurv, lDelaiMin * -1, 'J' ) // [DCMP070234] On calcule a rebours

			If	dDteSurv > dDteMax or dDteDet > dDteMin   Then // [DCMP070234] On teste en plus le délais min
		/*------------------------------------------------------------------*/
		/* La durée maximum est dépassée, on déclenche le refus 622.        */
		/*------------------------------------------------------------------*/
				bRet = Uf_RF_EcrireRefus ( 622 )
			End If
		End If

	End If
Next
Return ( bRet )
end function

private subroutine uf_gestion_str2nul ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Sinistre_wDetail::Uf_Gestion_Str2Nul (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 17/10/1998 18:05:58
//* Libellé			: 
//* Commentaires	: Cette fonction transforme les chaines vides en NULL
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sCol[ 2 ]
String sVal
Long lCpt, lNbrCol

/*------------------------------------------------------------------*/
/* Le but de cette fonction est de transformer toutes les zones au  */
/* format STRING dans la DW courante en NULL. Cela évitera d'avoir  */
/* sur le moteurs des zones avec des blancs. Cette fonction doit    */
/* être appelée avant la fonction Uf_ControlerSaisie ().            */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* De plus si le gestionnaire saisi des blancs DEVANT la zone,      */
/* ces caractères sont automatiquement enlevés.                     */
/*------------------------------------------------------------------*/

lNbrCol				= UpperBound ( sCol )

sCol[  1 ] = "LIB_DET"
sCol[  2 ] = "NUM_CARTE"

For	lCpt = 1 To lNbrCol
		sVal = Trim ( idw_wDetailFF.GetItemString ( 1, sCol[ lCpt ] ) )
		If Len ( sVal ) = 0 Then
			idw_wDetailFF.SetItem ( 1, sCol[ lCpt ], stNul.str )
			If	lCpt = 1 Then
				idw_wDetailFF.SetItem ( 1, "ALT_COUR", "N" )
			End If
		Else
			idw_wDetailFF.SetItem ( 1, sCol[ lCpt ], sVal )
		End If
Next

/*------------------------------------------------------------------*/
/* Le 10/12/1998                                                    */
/* Si le dossier est SANS SUITE, il n'y a pas de test sur la        */
/* valeur MT_PREJ. Donc si cette valeur est à NULL, cela pose un    */

/* problème.                                                        */
/*------------------------------------------------------------------*/
If	IsNull ( idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" ) )	Then
	idw_wDetailFF.SetItem ( 1, "MT_PREJ", 0.00 )
End If


end subroutine

private subroutine uf_gestion_plafond (integer aitype);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Gestion_Plafond_Piece (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 22/01/1998 16:31:31
//* Libellé			: 
//* Commentaires	: Gestion des plafonds pour le détail
//*
//* Arguments		: Integer		aiType			(Val)	Type d'action
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sFiltre
Long lTotPlafondTag


Choose Case aiType
/*------------------------------------------------------------------*/
/* On est en insertion d'un détail.                                 */
/*------------------------------------------------------------------*/
Case 1
	idw_wPlaf_Detail.Reset ()

/*------------------------------------------------------------------*/
/* On est en modification d'un détail.                              */
/*------------------------------------------------------------------*/
Case 2
	idw_wPlaf_Detail.Reset ()

/*------------------------------------------------------------------*/
/* On insére dans DW_WPLAF_DETAIL les plafonds déjà positionnés.    */
/* Pour cela on filtre sur ID_GTI et ID_DETAIL.                     */
/*------------------------------------------------------------------*/
	sFiltre = "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + &
				 " AND ID_DETAIL = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )

	idw_wPPlafond_Detail.SetFilter ( sFiltre )
	idw_wPPlafond_Detail.Filter ()
	idw_wPPlafond_Detail.Sort ()
	lTotPlafondTag = idw_wPPlafond_Detail.RowCount ()
	
	idw_wPPlafond_Detail.RowsCopy ( 1, lTotPlafondTag, Primary!, idw_wPlaf_Detail, 1, Primary! )

/*------------------------------------------------------------------*/
/* On enleve le filtre sur dw_wPPlafond_Detail.                     */
/*------------------------------------------------------------------*/
	sFiltre = ""
	idw_wPPlafond_Detail.SetFilter ( sFiltre )
	idw_wPPlafond_Detail.Filter ()
	idw_wPPlafond_Detail.Sort ()

End Choose
end subroutine

private subroutine uf_preparervalider_plafond (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerValider_Plafond (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Préparation de la validation d'un détail (Niveau PLAFOND)
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long 			lTotwPlaf, lCpt, lTotPlafTag
String		sFiltre

Boolean 		bModif

bModif		= False

/*------------------------------------------------------------------*/
/* On s'occupe du transfert des plafonds du détail.                 */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On va vérifier si l'un des plafonds a bougé. Il suffit de        */
/* tester s'il existe une ligne avec ALT_BOUGE à (S)upprime.        */
/* Fonction Uf_Calcul_MontantRegle (). Si c'est le cas on supprime  */
/* tous les plafonds et on insére les autres s'ils existent.        */
/* (ALT_BOUGE = OUI).                                               */
/*------------------------------------------------------------------*/
lTotPlafTag = idw_wPlaf_Detail.RowCount ()

For	lCpt = 1	To	lTotPlafTag
		If	idw_wPlaf_Detail.GetItemString ( lCpt, "ALT_BOUGE" ) = "S"	Then
			bModif = True
			Exit
		End If
Next

If	bModif	Then
	If	Not astPass.bInsert Then
/*------------------------------------------------------------------*/
/* On a touché à l'un des plafonds. On supprime, en modification,   */
/* tous les plafonds.                                               */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On positionne le flag pour l'optimisation des commandes sur      */
/* W_GAR_SIN.                                                       */
/*------------------------------------------------------------------*/
		idw_wDetailFF.SetItem ( 1, "ALT_MODIF_PLAFOND", "O" )

		sFiltre = "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + &
					 " AND ID_DETAIL = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )

		idw_wPPLafond_Detail.SetFilter ( sFiltre )
		idw_wPPlafond_Detail.Filter ()
		lTotwPlaf = idw_wPPlafond_Detail.RowCount ()

		idw_wPPlafond_Detail.RowsDiscard ( 1, lTotwPlaf, Primary! )

		sFiltre = ""
		idw_wPPlafond_Detail.SetFilter ( sFiltre )
		idw_wPPlafond_Detail.Filter ()
	End If
End If

/*------------------------------------------------------------------*/
/* On insére les nouveaux plafonds.                                 */
/*------------------------------------------------------------------*/
sFiltre = "ALT_BOUGE = 'O'"

idw_wPlaf_Detail.SetFilter ( sFiltre )
idw_wPlaf_Detail.Filter ()
lTotPlafTag = 	idw_wPlaf_Detail.RowCount ()

If	lTotPlafTag > 0 Then
/*------------------------------------------------------------------*/
/* On positionne le flag pour l'optimisation des commandes sur      */
/* W_GAR_SIN.                                                       */
/*------------------------------------------------------------------*/
	idw_wDetailFF.SetItem ( 1, "ALT_MODIF_PLAFOND", "O" )

	idw_wPlaf_Detail.RowsMove ( 1, lTotPlafTag, Primary!, idw_wPPlafond_Detail, 1, Primary! )
End If

sFiltre = ""
idw_wPlaf_Detail.SetFilter ( sFiltre )
idw_wPlaf_Detail.Filter ()

end subroutine

private function boolean uf_rf_635 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_635 (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Carte différente de la carte couverte
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------

String sIdAdh, sNumCarte, sCodAdh
Boolean bRet


/*------------------------------------------------------------------*/
/* On déclenche ce refus pour les produits avec COD_ADH = 3 ou 4    */
/* (Adhésion par Carte). Si la zone ID_ADH (correspondant au N° de  */
/* la carte couverte) est saisie, on verifie si ce N° est           */
/* identique au N° de carte du détail que l'on vient de saisir.(Si  */
/* ce N° de carte n'est pas NULL, bien sur). Dans le cas ou les     */
/* deux N° sont différents, on arme le motif 635.                   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* La zone COD_ADH est armée sur la DW de Sinistre par Denis. On    */
/* peut donc la récupérer directement.                              */
/*------------------------------------------------------------------*/
bRet		= True
sCodAdh 	= idw_wSin.GetItemString ( 1, "COD_ADH" )

If	sCodAdh = '3' Or sCodAdh = '4'	Then
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	sNumCarte	= idw_wDetailFF.getItemString ( 1, "NUM_CARTE" )

	If	Not IsNull ( sIdADh ) And Not IsNull ( sNumCarte )	Then
		If	sIdAdh <> sNumCarte	Then
			bRet = Uf_RF_EcrireRefus ( 635 )
		End If
	End If

End If

Return ( bRet )

end function

private subroutine uf_plaf_ecrirepara (string asidtypplaf, string asidpara, string ascptver);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_EcrirePara (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 23/01/1998 17:40:41
//* Libellé			: 
//* Commentaires	: Insertion du paragraphe de plafond ou de franchise
//*
//* Arguments		: String			asIdTypPlaf		(Val) Identifiant du Type de plafond/franchise
//* 					: String			asIdPara			(Val) Identifiant du paragraphe
//* 					: String			asCptVer			(Val) Révision du paragraphe
//*
//* Retourne		: Rien
//*
//* #2	 JFF  	07/11/2007	DCMP 70428 Memoriser les paragraphes de plafonds pour les utiliser dans l'appelant
//*-----------------------------------------------------------------

Long lLig, lIdSin, lIdGti, lIdDetail, lIdI

/*------------------------------------------------------------------*/
/* On insére une ligne dans la DW idw_wPlaf_Detail.                 */
/*------------------------------------------------------------------*/
lLig = idw_wPlaf_Detail.InsertRow ( 0 )

lIdSin		= idw_wDetailFF.GetItemNumber ( 1, "ID_SIN" )
lIdGti 		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
lIdDetail	= idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" )

/*------------------------------------------------------------------*/
/* Pour la zone ID_I, on prend la valeur actuelle du détail. S'il   */
/* existe plusieurs ID_I pour les détails, il sera impossible de    */
/* valider la garantie.                                             */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Les zones CREE_LE, MAJ_LE, MAJ_PAR seront renseignées sur        */
/* l'événement SqlPreview () de la DW idw_wParaPlafond.             */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Attention, pour information la zone ID_PARA peut être NULLE.     */
/*------------------------------------------------------------------*/
lIdI			= idw_wDetailFF.GetItemNumber ( 1, "ID_I_REG" )

// #2
If IsNull ( lIdI ) Then lIdI = 0
// :#2

idw_wPlaf_Detail.SetItem ( lLig, "ID_SIN", lIdSin )
idw_wPlaf_Detail.SetItem ( lLig, "ID_GTI", lIdGti )
idw_wPlaf_Detail.SetItem ( lLig, "ID_DETAIL", lIdDetail )
idw_wPlaf_Detail.SetItem ( lLig, "ID_TYP_PLAF", asIdTypPlaf )
idw_wPlaf_Detail.SetItem ( lLig, "ID_PARA", asIdPara )
idw_wPlaf_Detail.SetItem ( lLig, "CPT_VER", asCptVer )
idw_wPlaf_Detail.SetItem ( lLig, "ID_I", lIdI )
idw_wPlaf_Detail.SetItem ( lLig, "ALT_BOUGE", "O" )

end subroutine

private function boolean uf_rf_626 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_626 (PRIVATE)
//* Auteur			: FABRY F
//* Date				: 19/11/1999 15:07:49
//* Libellé			: 
//* Commentaires	: DELAI DTE OPPO./DATE DETAIL DEPASSE  REFUS 626
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Délai paramatrés sur les +NS, +DT, +TR
//*								  déclenché surle contrôle de garantie.
//* #2		PHG	26/10/2009 [DCMP071000] rf 655+651: Annexe : Correction Bug
//*								  présent sur toute les fonctions de refus.
//*-----------------------------------------------------------------

Boolean  bRet, bGestionDateUF, bOk
Date	   dDteOppo, dDteDet, dDteMax
Time		tDteOppo
String 	sUnite, sVal, sRech, sIdNivDel, sIdRefDel
Long 		lDuree, lTotDelai, lLig, lIdGti, lEcartOppoDet, lEcartOppoDelMax, lIdEvt, lCpt, lDeb, lFin

lTotDelai = idw_Delai.RowCount ()
bRet   = True

/*------------------------------------------------------------------*/
/* On déclenche le motif 626 dans le cas de la garantie Usage abusif*/
/* et dans certaines conditions.												  */ 
/*------------------------------------------------------------------*/
lIdGti = idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
lIdEvt = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
bOk    = False

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 42 )
If lDeb <= 0 Then Return True
For lCpt = lDeb to lFin 
	If idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) = lIdGti And idw_DetPro.GetItemString ( lCpt, "ID_CODE_CAR" ) = 'U' Then 
		bOk = True
		Exit
	End If
Next
If Not bOk Then Return TRUE


/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 1 to 5

	Choose Case lCpt
		Case 1
			sIdNivDel = "-GA"  // Garantie
			sIdRefDel = "-1"
		Case 2
			sIdNivDel = "+NS"  // Nature de sinistre
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivDel = "+TR"  // Territorialité
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivDel = "+DT"  // Détail de sinistre
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivDel = "+EV"  // Evénement de garantie
			sIdRefDel = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )


	End Choose

	If IsNull ( sIdRefDel ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un délai 626 pour la garantie. 			  */
	/*------------------------------------------------------------------*/
	// #2 [DCMP071000] Lecture ID_GTI dans idw_wDetailFF ald de idw_wGarSin
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_DEL = '"  + sIdNivDel 																+ "' AND " 	+ &
					"ID_REF_DEL = "	+ sIdRefDel 																+ " AND " 	+ &
					"ID_TYP_DEL = '626'"

	lLig = idw_Delai.Find ( sRech, 1, lTotDelai )

	/*------------------------------------------------------------------*/
	/* On vérifie qu'il y ait une date d'opposition de saisie, une      */
	/* heure d'oppo, une date d'utilisation sur le détail ainsi qu'une  */
	/* heure d'utilisation, sans quoi ce refus ne peut être déclenché.  */
	/*------------------------------------------------------------------*/
	If lLig > 0 Then

		sVal = String ( idw_wGarSin.GetItemDate ( 1, "DTE_OPPO_DATE" ) )
		If IsNull ( sVal ) or sVal = "" Then Return ( bRet )

		If bRet Then
			sVal =  idw_wGarSin.GetItemString ( 1, "HEU_OPPO" )
			If IsNull ( sVal ) or sVal = "" Then Return ( bRet )
		End If

		If bRet Then
			sVal = String ( idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" ) )
			If IsNull ( sVal ) or sVal = "" Then Return ( bRet )
		End If


		/*------------------------------------------------------------------*/
		/* Récupération du DatteTime d'opposition et du DateTime            */
		/* d'utilisation du détail.                                         */
		/*------------------------------------------------------------------*/

		dDteOppo		= idw_wGarSin.GetItemDate ( 1, "DTE_OPPO_DATE" )
		dDteDet		= idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" )

		sVal 			= idw_wGarSin.GetItemString ( 1, "HEU_OPPO" )
		tDteOppo		= Time ( Integer ( Left ( sVal, 2) ), Integer ( Right ( sVal, 2 ) ), 0 )


		/*------------------------------------------------------------------*/
		/* Ecart en minutes et à la minute près, entre Date oppo et Date    */
		/* du détail.                                                       */
		/* La date du détail n'est pas obligatoire, on la fixe par défaut à */
	   /* 23H59																				  */		
		/*------------------------------------------------------------------*/
		lEcartOppoDet = F_DateDiff ( "n", "dt", dDteOppo, tDteOppo, dDteDet, 23:59:00 )

		/*------------------------------------------------------------------*/
		/* On s'arrête si la date d'utilisation est antérieure (à la        */
		/* minute près à la date d'oppo ).                                  */
		/* Il n'y à pas de refus dans ce cas.										  */
		/*------------------------------------------------------------------*/
		If lEcartOppoDet >= 0 Then

			/*------------------------------------------------------------------*/
			/* On récupére le délai maximum autorisé entre la date              */
			/* d'opposition et la date d'utilisation du détail. On vérifie si   */
			/* ce délai est dépassé.                                            */
			/*------------------------------------------------------------------*/
			sUnite	= idw_Delai.GetItemString ( lLig, "UNT_DEL" )
			lDuree	= idw_Delai.GetItemNumber ( lLig, "DUR_MAX" )

			dDteMax	= F_Plus_Date ( dDteOppo, lDuree, sUnite )

			/*------------------------------------------------------------------*/
			/* Ecart en minutes et à la minute près, entre la Date oppo et la   */
			/* Date maximum couvrant le détail construite à partir du délai     */
			/* maximum.                                                         */
			/* VU AVEC DENIS, LE DERNIER JOUR IL EST COUVERT JUSQU'A 23H59		  */
			/*------------------------------------------------------------------*/
			lEcartOppoDelMax = F_DateDiff ( "n", "dt", dDteOppo, tDteOppo, dDteMax, 23:59:00 )		


			/*------------------------------------------------------------------*/
			/* Si le nombre de minutes entre la Date d'oppo et le détail et     */
			/* plus grande que le nombre de minutes entre la Date Oppo et la    */
			/* date maximum couvrant le détail, alors on déclenche le refus.    */
			/*------------------------------------------------------------------*/
			If lEcartOppoDet > lEcartOppoDelMax Then
					bRet = Uf_RF_EcrireRefus ( 626 )
			End If

		End If
	End If
Next

Return ( bRet )
end function

private subroutine uf_gestion_commandes ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Gestion_Commandes (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 11/09/2001 16:31:31
//* Libellé			: Gestion des Commandes
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

DwItemStatus lStatusDw
String sFiltre
Long		lNbrCol, lNbrLig, lCptLig, lCptCol, lTotCmdeGti, lDeb, lFin
Int		iRet

idw_LstCmdeDet.Reset ()
idw_InfoCmde.Reset ()

If Not ibAltCmde Then Return 

idw_InfoCmde.InsertRow ( 0 )
idw_InfoCmde.SetItem ( 1, "ID_DETAIL", idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )

idw_LstCmdeGti.SetFilter ( "ID_GTI    = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + " AND " + &
									"ID_DETAIL = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) ) )
idw_LstCmdeGti.Filter ( )
lTotCmdeGti = idw_LstCmdeGti.RowCount ()
idw_LstCmdeGti.SetFilter ( "" )
idw_LstCmdeGti.Filter ( )

idw_InfoCmde.SetItem ( 1, "NBRE_DET", lTotCmdeGti )	
idw_InfoCmde.SetItem ( 1, "NBRE_NOUV", 0 )	

/*------------------------------------------------------------------*/
/* Choix Action Commander ou sélectionner pour courrier visible ou  */
/* pas ?                                                            */
/*------------------------------------------------------------------*/
idw_ChoixAction.InsertRow ( 0 )
idw_ChoixAction.SetItem ( 1, "CHOIX_ACTION", "C" )
icbCommander.Text = "Commander >>"

/*------------------------------------------------------------------*/
/* Descentes des lignes du niveau Garanties vers Détails.           */
/*------------------------------------------------------------------*/
sFiltre = "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + &
			 " AND ID_DETAIL = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )

idw_LstCmdeGti.SetFilter ( sFiltre )
idw_LstCmdeGti.Filter ()
idw_LstCmdeGti.Sort ()	
lNbrLig = idw_LstCmdeGti.RowCount()

/*------------------------------------------------------------------*/
/* Copie des lignes niveau supérieur vers niveau inférieur.         */
/* (Attention, on recopie le buffer primare, le client est donc     */
/* libre de le filtrer.)                                            */
/*------------------------------------------------------------------*/
iRet = idw_LstCmdeGti.RowsCopy ( 1, lNbrLig, PRIMARY!, idw_LstCmdeDet, 1, PRIMARY! )

/*------------------------------------------------------------------*/
/* Recopie des Status de lignes et colonnes.                        */
/*------------------------------------------------------------------*/
lNbrCol = Long ( idw_LstCmdeGti.Describe ("DataWindow.Column.Count" ) )


For lCptLig = 1 to lNbrLig

   /*------------------------------------------------------------------*/
	/* De façons à être sûr de pouvoir modifier les status de           */
	/* colonnes, on force le status de la ligne à DATAMODIFIED!         */
	/*------------------------------------------------------------------*/
	idw_LstCmdeDet.SetItemStatus ( lCptLig, 0, Primary!, DataModified! )


	/*------------------------------------------------------------------*/
	/* Recopie des status de colonnes.                                  */
	/*------------------------------------------------------------------*/
	For lCptCol = 1 To lNbrCol
		lStatusDw = idw_LstCmdeGti.GetItemStatus ( lCptLig, lCptCol, Primary! )
		idw_LstCmdeDet.SetItemStatus ( lCptLig, lCptCol, Primary!, lStatusDw )
	Next

	/*------------------------------------------------------------------*/
	/* Les status de colonne étant recopiés, on recopie à ce moment le  */
	/* status de la ligne.                                              */
	/*------------------------------------------------------------------*/
	lStatusDw = idw_LstCmdeGti.GetItemStatus ( lCptLig, 0, Primary! )
	idw_LstCmdeDet.SetItemStatus ( lCptLig, 0, Primary!, lStatusDw )

Next

/*------------------------------------------------------------------*/
/* On enleve le filtre sur dw_wDetail.                              */
/*------------------------------------------------------------------*/
sFiltre = ""
idw_LstCmdeGti.SetFilter ( sFiltre )
idw_LstCmdeGti.Filter ()
idw_LstCmdeGti.Sort ()	

end subroutine

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
/* Pour toutes les lignes contenues dans le buffer Deleted! de      */
/* DwNivInf...                                                      */
/* Le compteur est à l'envers, car on Détruit des rows sur IdwRe-   */
/* questor dans Uf_CopierLigne												  */
/*------------------------------------------------------------------*/
lNbrTotLig = idw_LstCmdeDet.DeletedCount () 

For lCptLig = lNbrTotLig To 1 Step -1

/*------------------------------------------------------------------*/
/* ...on construit la clé de chaque enregistrement contenus dans    */
/* le buffer Delete! de DwNivInf.                                   */
/*------------------------------------------------------------------*/
	sCle = "ID_SEQ = " + String ( idw_LstCmdeDet.GetItemNumber ( lCptLig, "ID_SEQ", DELETE!, TRUE ) ) 

/*------------------------------------------------------------------*/
/* Avec cette ligne identifiée, on effectue le traitement           */
/* nécéssaire sur la DataWindow de niveau supérieur. Voir fonction  */
/* Uf_CopierLigne.                                                  */
/*------------------------------------------------------------------*/
	If This.Uf_CopierLigne_Inf2Sup ( "BD", lCptLig, sCle, iDw_LstCmdeGti, iDw_LstCmdeDet )	< 0  Then Return -1

Next


/*------------------------------------------------------------------*/
/* Pour toutes les lignes contenues dans le buffer Primary!         */
/* DwNivInf... (Le client a pu filtrer le buffer Primaire)          */
/*------------------------------------------------------------------*/
lNbrTotLig = idw_LstCmdeDet.RowCount () 
For lCptLig = 1 To lNbrTotLig


/*------------------------------------------------------------------*/
/* ...on construit la clé de chaque enregistrement contenus dans    */
/* le buffer Primaire de DwNivInf.                                  */
/*------------------------------------------------------------------*/
	sCle = "ID_SEQ = " + String ( idw_LstCmdeDet.GetItemNumber ( lCptLig, "ID_SEQ", PRIMARY!, TRUE ) ) 


	/*------------------------------------------------------------------*/
	/* Avec cette ligne identifiée, on effectue le traitement           */
	/* nécéssaire sur la DataWindow de niveau supérieur. Voir fonction  */
	/* Uf_CopierLigne.                                                  */
	/*------------------------------------------------------------------*/
	If This.Uf_CopierLigne_Inf2Sup ( "BP", lCptLig, sCle, idw_LstCmdeGti, idw_LstCmdeDet )	< 0   Then Return -1
		
Next

Return 1




end function

public subroutine uf_bt_annuler_commande ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Bt_Annuler_Commande (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 12/09/2001 10:49:34
//* Libellé			: 
//* Commentaires	: Préparation de la validation d'une Commande.
//*
//* Arguments		:
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------

Long	lNbreNouv, lTotCmdeDet, lSeqMax, lSeqMax1, lRow 

lNbreNouv = idw_InfoCmde.GetItemNumber ( 1, "NBRE_NOUV" )

If  lNbreNouv > 0 Then

	stMessage.sTitre		= "Commandes"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= YESNO!
	stMessage.sCode		= "COMD021"

	If F_Message ( stMessage ) = 2 Then Return
	
	idw_InfoCmde.SetItem ( 1, "NBRE_DET", idw_InfoCmde.GetItemNumber ( 1, "NBRE_DET" ) - lNbreNouv )
	idw_InfoCmde.SetItem ( 1, "NBRE_NOUV", 0 )

	lSeqMax  = Long ( idw_LstCmdeSin.Describe ( "Evaluate ( 'max (id_seq)', 0 )") )
	lSeqMax1 = Long ( idw_LstCmdeGti.Describe ( "Evaluate ( 'max (id_seq)', 0 )") )

	If lSeqMax1 > lSeqMax Then lSeqMax = lSeqMax1

	idw_LstCmdeDet.SetFilter ( "ID_SEQ > " + String ( lSeqMax ) )
	idw_LstCmdeDet.Filter ( )
	idw_LstCmdeDet.RowsDiscard ( 1, 	idw_LstCmdeDet.RowCount ( ), PRIMARY! )
	idw_LstCmdeDet.SetFilter ( "" )
	idw_LstCmdeDet.Filter ( )
	
End If


end subroutine

public function integer uf_bt_commander ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Sinistre_wDetail::uf_bt_Commander (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 21/07/2002 09:31:39
//* Libellé			: 
//* Commentaires	: Traitement du CLICK sur le bouton COMMANDER de la fenêtre de DETAIL
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 CAG	 02/10/2002	  Si on est dans le cas d'une gti BRIS (11)
//*								  Question : Mobile endommagé réceptionné ?
//*								  si oui ouvrir sinon retour
//*								  Vu avec B. Hanin, on ne gère pas de date de réception
//*								  du mobile, une simple box de confirmation suffit. (p38)
//* #2	 CAG	 29/01/20023  Annexe 22 : on ne pose la question ci-dessus
//*												  que si evt <> 845, et non compris entre 850 et 853 (inclus)
//*-----------------------------------------------------------------
/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/

Long lTotGti, lCodEtat, lLig, lTotCmd, lCpt, lIdGti, lIdSeq, lIdBsp, lIdEvt
DateTime dtDteRetPret
String sRech, sCodEtatCmd
Integer iRet

iRet = 1

/*------------------------------------------------------------------*/
/* Pour la garantie PANNE (18)                                      */
/*------------------------------------------------------------------*/
/* Il est impossible de passer une PReStation auprés de CETELEC si  */
/* une garantie BRIS existe.                                        */
/*------------------------------------------------------------------*/
If	ilCodTel = 21	Then
	lTotGti	= idw_LstGarSin.RowCount ()
	If	idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) = 18	Then
		sRech = "ID_GTI = 11"
		lLig	= idw_LstGarSin.Find ( sRech, 1, lTotGti )

		If	lLig > 0	Then
			stMessage.sTitre		= "Gestion SFR"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "SFRP003"
			
			iRet = -1
		End If
	End If
/*------------------------------------------------------------------*/
/* Pour une garantie BRIS (11)                                      */
/*------------------------------------------------------------------*/
/* On vérifie que la garantie PANNE est close s'il existe au moins  */
/* une commande active pour cette garantie.                         */
/*------------------------------------------------------------------*/
	If	iRet = 1		Then
		sRech		= "ID_GTI = 18"

		If	idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) = 11	Then
			lLig = idw_LstGarSin.Find ( sRech, 1, lTotGti )

			If	lLig > 0	Then
				lCodEtat = idw_LstGarSin.GetItemNumber ( lLig, "COD_ETAT" )
				If	lCodEtat <> 200 And lCodEtat <> 500 And lCodEtat <> 600 And lCodEtat <> 900	Then

					lTotCmd	= idw_LstCmdeSin.RowCount ()
					sRech		= "ID_GTI = 18 And COD_ETAT <> 'ANN'"
					If	idw_LstCmdeSin.Find ( sRech, 1, lTotCmd ) > 0	Then

						stMessage.sTitre		= "Gestion SFR"
						stMessage.Icon			= Exclamation!
						stMessage.bErreurG	= FALSE
						stMessage.Bouton		= OK!
						stMessage.sCode		= "SFRP045"
						iRet = -1
					End If
				End If
			End If
		End If
	End If
/*------------------------------------------------------------------*/
/* Pour une garantie BRIS (11)                                      */
/*------------------------------------------------------------------*/
/* On vérifie que toutes les commandes en cours pour la garantie    */
/* PANNE possédent une valeur renseignée pour la zone DTE_RET_PRET. */
/*------------------------------------------------------------------*/
	If	iRet = 1	Then
		If	idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) = 11	Then		
			lTotCmd = idw_LstCmdeSin.RowCount ()

			For	lCpt = 1 To lTotCmd
					lIdGti			= idw_LstCmdeSin.GetItemNumber ( lCpt, "ID_GTI" )
					dtDteRetPret	= idw_LstCmdeSin.GetItemDateTime ( lCpt, "DTE_RET_PRET" )
					lIdSeq			= idw_LstCmdeSin.GetItemNumber ( lCpt, "ID_SEQ" )
					sCodEtatCmd		= idw_LstCmdeSin.GetItemString ( lCpt, "COD_ETAT" )
					lIdBsp			= idw_LstCmdeSin.GetItemNumber ( lCpt, "ID_BSP" )

					If	lIdGti = 18 And sCodEtatCmd <> "ANN" Then
/*------------------------------------------------------------------*/
/* Pour une garantie BRIS (11)                                      */
/*------------------------------------------------------------------*/
/* On verifie si l'une des commandes en cours pour la garantie      */
/* PANNE n'autorise pas la création d'une commande pour CEGETEL     */
/* (ID_BSP=0).                                                      */
/*------------------------------------------------------------------*/
						If		lIdBsp = 0	Then

										stMessage.sTitre		= "Gestion SFR"
										stMessage.Icon			= Exclamation!
										stMessage.bErreurG	= FALSE
										stMessage.sVar[1]		= String ( lIdSeq )
										stMessage.Bouton		= OK!
										stMessage.sCode		= "SFRP055"

										iRet = -1
										Exit
/*------------------------------------------------------------------*/
/* Pour une garantie BRIS (11)                                      */
/*------------------------------------------------------------------*/
/* S'il s'agit d'un BRIS sur PANNE, (Réparable) la saisie d'une     */
/* commande chez CEGETEL est interdite.                             */
/*------------------------------------------------------------------*/
						ElseIf		Not IsNull ( dtDteRetPret ) And lIdBsp = 1	Then

										stMessage.sTitre		= "Gestion SFR"
										stMessage.Icon			= Exclamation!
										stMessage.bErreurG	= FALSE
										stMessage.sVar[1]		= String ( lIdSeq )
										stMessage.Bouton		= OK!
										stMessage.sCode		= "SFRP065"

										iRet = -1
										Exit
						ElseIf		Not IsNull ( dtDteRetPret ) And IsNull ( lIdBsp ) Then

										stMessage.sTitre		= "Gestion SFR"
										stMessage.Icon			= Exclamation!
										stMessage.bErreurG	= FALSE
										stMessage.sVar[1]		= String ( lIdSeq )
										stMessage.Bouton		= OK!
										stMessage.sCode		= "SFRP060"

										iRet = -1
										Exit
						End If
					End If
			Next
		End If
	End If
End If

If	iRet <> 1	Then
	F_Message ( stMessage )
End If

If iRet = 1 And ilCodTel = 21	Then
/*------------------------------------------------------------------*/
/* #1 CAG 02/10/02                                                  */
/*------------------------------------------------------------------*/
/* #2 CAG 29/01/03                                                  */
/*------------------------------------------------------------------*/
	lIdEvt = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	If idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) = 11 Then
		Choose Case lIdEvt 
			Case 	845, 850, 851, 852, 853, 856, 857, 858, 859

				stMessage.sTitre		= "Gestion SFR"
				stMessage.Icon			= Question!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= YESNO!
				stMessage.sCode		= "SFRP075"
				If F_Message ( stMessage ) = 2 Then	iRet = -1
		End Choose
	End If
End If


Return ( iRet )
end function

private subroutine uf_rendre_visible_idireg (integer aichoix);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Sinistre_wDetail::uf_Rendre_Visible_IdiReg (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 21/07/2002 09:31:39
//* Libellé			: 
//* Commentaires	: On va rendre visible ou invisible les zones ID_I_REG et ID_I_REG_T
//*
//* Arguments		: (Val)		Integer		aiChoix
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1    CAG   03/02/2003   Annexe 22 : si l'une des prestations liées
//*									à ce détail possède un id_bsp > 0 la zone
//*									destinataire règlement doit être invisible
//* #2    MADM    06/07/2006 DCMP 060472 FNAC Suissse-Belgique permettre le règlement à 0 euros sur option 57   
//*-----------------------------------------------------------------
/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/

Long lIdGti, lIdEvt, lDeb, lFin, lCpt
Boolean bVisible
Decimal {2} dcMtPrej
String sMod, sFiltre

bVisible = False

lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
lIdEvt = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )

Choose Case aiChoix
Case 0
	dcMtPrej = idw_wDetailFF.GetItemNumber ( 1, "MT_PREJ" )
Case 1
	dcMtPrej = Dec ( idw_wDetailFF.GetText () )
Case 2
	lIdEvt = Long ( idw_wDetailFF.GetText () )
	//*------------------------------------------------------*/
	//*#2 on lit le montant du préjudice : si dcMtPrej > o   */
	//* le champ zone à régler est visible                   */
	//*------------------------------------------------------*/
	dcMtPrej = idw_wDetailFF.GetItemNumber ( 1, "MT_PREJ" )
End Choose

/*------------------------------------------------------------------*/
/* Dans le cas des produits SFR, on peut 'régler' le dossier avec   */
/* un montant MT_PREJ à zéro. Il faut donc rendre les zones         */
/* ID_I_REG et ID_I_REG_T visibles.                                 */
/*------------------------------------------------------------------*/
sFiltre = "ID_GTI = " + String ( lIdGti ) + &
          " AND ID_DETAIL = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
			 " AND ID_BSP > 0 "
idw_LstCmdeSin.SetFilter ( sFiltre )
idw_LstCmdeSin.Filter ()

If	ilCodTel = 21 And lIdGti = 18 Then
	If idw_LstCmdeSin.Rowcount () = 0 Then
		bVisible = TRUE
	Else
		If	dcMtPrej > 0	Then
			bVisible = TRUE
		End If
	End If
Else
	If	dcMtPrej > 0	Then
		bVisible = TRUE
	End If
End If

/*------------------------------------------------------------------*/
/* #2 MADM 06/07/2006 DCMP 060472		                             */
/* On cherche l'option 57 si trouvé et les conditions ci-dessous    */
/* reunies alors on rend visible le champ zone à régler             */
/*------------------------------------------------------------------*/
If Not bVisible And dcMtPrej <= 0 Then
       F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 57 )
		 If lDeb > 0 Then
			For lCpt = lDeb To lFin 
			 If idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) = lIdGti And idw_DetPro.GetItemNumber ( lCpt, "VAL_NUM" ) = lIdEvt Then
				 bVisible = TRUE
				 Exit
			 End If
		   Next 
		 End If	
End If		 
/*------------------------------------------------------------------*/
/* Fin MADM															              */
/*------------------------------------------------------------------*/

If	bVisible Then
	sMod = "ID_I_REG.Visible = '1' ID_I_REG_T.Visible = '1'"
Else
	sMod = "ID_I_REG.Visible = '0' ID_I_REG_T.Visible = '0'"
End If

idw_wDetailFF.Modify ( sMod )

sFiltre = ""
idw_LstCmdeSin.SetFilter ( sFiltre )
idw_LstCmdeSin.Filter ()

end subroutine

public subroutine uf_majvargamme (long alRetGamme);//*-----------------------------------------------------------------
//*
//* Fonction      : U_Gs_Sp_Sinistre_WDetail::uf_MajVarGamme ( PUBLIC )
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 27/09/2002 15:39:58
//* Libellé       : Maj de la variable d'instance gamme
//* Commentaires  : 
//*
//* Arguments     : ( Val )	Long	alRetGamme	:	la gamme retournée par la fenêtre des gammes
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

ilRetGamme = alRetGamme

end subroutine

private subroutine uf_controlergestion_si_val_achat (ref string aspos);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerGestion_Si_Val_Achat (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/11/2003 
//* Libellé			: 
//* Commentaires	: Contrôle de saisie liés à l'utilisation de la zone MT_VAL_ACHAT
//*					  (initialement pour DARTY)
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
String 		sNouvelleLigne, sLibEvt, sTbLibEvt [], sVal
Decimal {2}	dcMtValAchat
Boolean		bValAchRens, bCasto, bDetAREG 
Int			iRet

If idw_wDetailFF.GetItemString ( 1, "ALT_BLOC" ) = "O" Then
	Return
End If

sNouvelleLigne		= "~r~n"
sTbLibEvt [1] = "REMPL"
sTbLibEvt [2] = "REMBO"
sTbLibEvt [3] = "REPAR"
sTbLibEvt [4] = "RÉPAR"

bValAchRens = FALSE
iRet = 1

/*------------------------------------------------------------------*/
/* Si l'utilisation de la valeur d'achat n'est pas paramètré, on    */
/* ressort.                                                         */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 9 )
If lDeb <= 0 Or asPos <> "" Then Return 

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 43 )
bCasto = lDeb > 0

bDetAREG = idw_wDetailFF.GetItemNumber ( 1, "COD_ETAT" ) = 500 

dcMtValAchat = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" )  
If IsNull ( dcMtValAchat ) Then
	dcMtValAchat = 0
	idw_wDetailFF.SetItem ( 1, "MT_VAL_ACHAT", 0 )  
End If

bValAchRens  = dcMtValAchat > 0 
sLibEvt  = Upper ( idw_wDetailFF.Describe ( "Evaluate ('LookUpDisplay ( ID_EVT )', 1)" ) )

lTotTb = UpperBound ( sTbLibEvt )

/*------------------------------------------------------------------*/
/* On recherche par le libellé de l'Evt s'il s'agit d'un            */
/* Remplacement, Remboursement ou réparation. Je fais cette         */
/* recherche par libellé et non par ID afin que ce code prenne en   */
/* compte tous les nouveaux Evt de ce type qui pourraient être      */
/* créés par la suite.                                              */
/*------------------------------------------------------------------*/
For lCpt = 1 to lTotTb 
	lPos = Pos ( sLibEvt, sTbLibEvt [lCpt], 1 )
	If lPos > 0 Then
		sVal = sTbLibEvt [lCpt]
		Exit
	End If
Next

/*------------------------------------------------------------------*/
/* Pour Chaque Type d'Evt, le cas peut être différent.              */
/*------------------------------------------------------------------*/
Choose Case sVal
	Case  "REMPL", "REMBO"
		/*------------------------------------------------------------------*/
		/* Vu avec BH le 06/11/03, pour le Rempl et Rembo, la valeur        */
		/* d'achat est obligatoire.                                         */
		/*------------------------------------------------------------------*/
		If bDetAREG And Not bValAchRens Then 
			iRet = -1
			stMessage.sCode = "TLPH007"
		Else
			iRet = 1
		End If

	Case  "REPAR", "RÉPAR"
		/*------------------------------------------------------------------*/
		/* Vu avec BH le 06/11/03, pour la Répar. la valeur d'achat n'est   */
		/* pas obligatoire en effet le paiement auprès d'ANOVO est un       */
		/* forfait.																			  */
		/*------------------------------------------------------------------*/
		iRet = 1

	Case  Else
		If bCasto And Not bValAchRens Then
			iRet = -1
			stMessage.sCode = "WDET270"
		End If

End Choose

If iRet = -1 Then

	asPos = "MT_VAL_ACHAT"	
	stMessage.bErreurG	= FALSE
	stMessage.sTitre		= "Contrôle de saisie du détail"
	stMessage.Icon			= Information!

	f_Message ( stMessage )
End If


end subroutine

public function decimal uf_maxttc_mobilechoisi ();//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_sinistre_wdetail::uf_MaxTTC_MobileChoisi (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 14/11/2003 15:46:26
//* Libellé       : Retourne le Max TTC des mobile (TYP_ART = TEL) commandé/choisi
//*					  su le sinistre.
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : Decimal	Max TTC
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    14/12/2006  Si diff de PRS
//*
//*-----------------------------------------------------------------

Decimal {2}	dcPlafond, dcPlafondSav
String  sFiltreOrig, sFiltre

// sFiltre = "ID_TYP_ART = 'TEL' AND COD_ETAT <> 'ANN'"
// #1
sFiltre = "ID_TYP_ART <> 'PRS' AND COD_ETAT <> 'ANN'"

/*------------------------------------------------------------------*/
/* Recherche sur liste des commandes se trouvant au niveau du       */
/* sinistre.                                                        */
/*------------------------------------------------------------------*/
sFiltreOrig = idw_LstCmdeSin.Describe ( "datawindow.table.filter" )
If sFiltreOrig = "?" Then sFiltreOrig = ""

idw_LstCmdeSin.SetFilter ( sFiltre )
idw_LstCmdeSin.Filter ()

dcPlafond = Dec ( idw_LstCmdeSin.Describe( "Evaluate('Max ( mt_ttc_cmde )', 0)" ) )
dcPlafondSAV = dcPlafond

idw_LstCmdeSin.SetFilter ( sFiltreOrig )
idw_LstCmdeSin.Filter ()

/*------------------------------------------------------------------*/
/* Recherche sur liste des commandes se trouvant au niveau de       */
/* la Gti.                                                          */
/*------------------------------------------------------------------*/
sFiltreOrig = idw_LstCmdeGti.Describe ( "datawindow.table.filter" )
If sFiltreOrig = "?" Then sFiltreOrig = ""

idw_LstCmdeGti.SetFilter ( sFiltre )
idw_LstCmdeGti.Filter ()

dcPlafond = Dec ( idw_LstCmdeGti.Describe( "Evaluate('Max ( mt_ttc_cmde )', 0)" ) )
If dcPlafond > dcPlafondSAV Then dcPlafondSAV = dcPlafond

idw_LstCmdeGti.SetFilter ( sFiltreOrig )
idw_LstCmdeGti.Filter ()

/*------------------------------------------------------------------*/
/* Recherche sur liste des commandes se trouvant au niveau du       */
/* Detail.                                                          */
/*------------------------------------------------------------------*/
sFiltreOrig = idw_LstCmdeDet.Describe ( "datawindow.table.filter" )
If sFiltreOrig = "?" Then sFiltreOrig = ""

idw_LstCmdeDet.SetFilter ( sFiltre )
idw_LstCmdeDet.Filter ()

dcPlafond = Dec ( idw_LstCmdeDet.Describe( "Evaluate('Max ( mt_ttc_cmde )', 0)" ) )
If dcPlafond > dcPlafondSAV Then dcPlafondSAV = dcPlafond

idw_LstCmdeDet.SetFilter ( sFiltreOrig )
idw_LstCmdeDet.Filter ()

If IsNull ( dcPlafondSAV ) Then dcPlafondSAV = 0


Return dcPlafondSAV
end function

private subroutine uf_calcul_montantregle_gti_gmp (decimal adcmtprej);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Calcul_MontantRegle_Gti_GMP (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Calcul du Montant à régler
//*
//* Arguments		: Decimal		adcMtPrej				Val
//*
//* Retourne		: (none)
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*
//*-----------------------------------------------------------------


Long lDeb, lFin, lIdGti, lCpt
Decimal {2} dcMtNouvPrixConstate 
Boolean bOk

lIdGti			= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )

/*------------------------------------------------------------------*/
/* Option Det_Pro 21 : Gestion GTI GMP                              */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 21 )
If lDeb <= 0 Then Return

For lCpt = lDeb To lFin
	If lIdGti = idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) Then
		bOk = True
		Exit
	End If
Next

If Not bOk Then Return 
dcMtNouvPrixConstate = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" )

If IsNull ( dcMtNouvPrixConstate ) Then dcMtNouvPrixConstate = 0

If dcMtNouvPrixConstate < adcMtPrej Then
	idw_wDetailFF.SetItem ( 1, "MT_NPLAF", adcMtPrej - dcMtNouvPrixConstate )
	idw_wDetailFF.SetItem ( 1, "MT_PLAF", adcMtPrej - dcMtNouvPrixConstate )
Else
	idw_wDetailFF.SetItem ( 1, "MT_NPLAF", 0 )
	idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
End If



end subroutine

private function string uf_plaf_adhesion_annee_civile ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adhesion_Annee_Civile (PRIVATE)
//* Auteur			: Catherine Abdmeziem
//* Date				: 14/06/2004
//* Libellé			: 
//* Commentaires	: Application d'un plafond par Année civile
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012 [VDOC6662]
//        JFF    16/11/2015  [DT159-1]
//*-----------------------------------------------------------------


Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale, lDeb, lFin
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafSav, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdEvt
Decimal{2} 	dcMtAutreSinistre, dcPlafTmp
String		sMtAutreSinistre, sIdNivPlaf, sIdRefPlaf
n_cst_string lnvPFCString

DateTime dtDteSurv

String sRech, sPos, sIdAdh, sIdPara, sCptVer

sPos = ""
/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '673'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
	lTotDetail = idw_wDetailFF.iudwDetailSource.RowCount ()
/*------------------------------------------------------------------*/
/* On s'occupe du détail courant, en insertion ou en modification.  */
/* Ce détail ne sera pas traité dans la boucle.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modification DBI le 12/08/1998                                   */
/*                                                                  */
/* La zone à prendre en compte pour le calcul du montant plafonné   */
/* n'est pas MT_NPLAF      mais MT_PLAF      sinon on ne            */
/* tient pas compte des plafonds appliqués successivement           */
/*------------------------------------------------------------------*/

	dcMtPlaf		= idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF"   )
	lIdDetail	= idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" )

	For	lCpt = 1 To lTotDetail
/*------------------------------------------------------------------*/
/* On ne traite pas le détail courant.                              */
/*------------------------------------------------------------------*/
			If		idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_DETAIL" ) = lIdDetail	Then
					Continue
			Else
/*------------------------------------------------------------------*/
/* Le détail est 'REGLE' ou 'A REGLE', on récupére le montant       */
/* MT_PLAF.                                                         */
/*------------------------------------------------------------------*/
					If	( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 500 Or &
						  idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 600	) And &
						( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) = idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_EVT" ) ) Then

						dcSommeDetail += idw_wDetailFF.iudwDetailSource.GetItemDecimal ( lCpt, "MT_PLAF" )
					End If
			End If
	Next
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
	dcIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	dcMtAutreSinistre = 0
	sMtAutreSinistre = "             "

	itrTrans.PS_S05_W_DETAIL_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, dcIdEvt, dtDteSurv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S05_W_DETAIL_MT_PLAF" )	Then
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée.                                    */
/*------------------------------------------------------------------*/
		sPos		= "ALT_BLOC"
		F_Message ( stMessage )
	Else
/*------------------------------------------------------------------*/
/* On détermine si on dépasse le plafond.                           */
/*------------------------------------------------------------------*/

		dcMtAutreSinistre = Dec ( sMtAutreSinistre )
		dcPlafond			= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcSommeDetail + dcMtAutreSinistre + dcMtPlaf > dcPlafond	Then

			If dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) > 0 Then
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) )
				
				// [PLAF_REF] // [VDOC6662]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "673", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
				// [PLAF_REF]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "673", "NORMAL" )
			End If
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )

/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "673", sIdPara, sCptVer )

			
		End If
	End If
End If
	
Return ( sPos )
end function

private function string uf_plaf_adherent_annee_civile ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adherent_Annee_Civile (PRIVATE)
//* Auteur			: Catherine Abdmeziem
//* Date				: 14/06/2004
//* Libellé			: 
//* Commentaires	: Application d'un plafond par adhérent/Année civile
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012 [VDOC6662]
//        JFF    16/11/2015 [DT159-1]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale, lDeb, lFin
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafSav, dcPlafTmp, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdsDos, dcIdGti, dcIdEvt
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
n_cst_string lnvPFCString

Decimal{2} 	dcMtAutreSinistre
String		sMtAutreSinistre

sPos = ""
/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par adhérent.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '674'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next
lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
	lTotDetail = idw_wDetailFF.iudwDetailSource.RowCount ()
/*------------------------------------------------------------------*/
/* On s'occupe du détail courant, en insertion ou en modification.  */
/* Ce détail ne sera pas traité dans la boucle.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modification DBI le 12/08/1998                                   */
/*                                                                  */
/* La zone à prendre en compte pour le calcul du montant plafonné   */
/* n'est pas MT_NPLAF      mais MT_PLAF      sinon on ne            */
/* tient pas compte des plafonds appliqués successivement           */
/*------------------------------------------------------------------*/

	dcMtPlaf		= idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF"   )
	lIdDetail	= idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" )

	For	lCpt = 1 To lTotDetail
/*------------------------------------------------------------------*/
/* On ne traite pas le détail courant.                              */
/*------------------------------------------------------------------*/
			If		idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_DETAIL" ) = lIdDetail	Then
					Continue
			Else
/*------------------------------------------------------------------*/
/* Le détail est 'REGLE' ou 'A REGLE', on récupére le montant       */
/* MT_PLAF.                                                         */
/*------------------------------------------------------------------*/
					If	( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 500 Or &
						  idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 600	) And &
						( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) = idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_EVT" ) ) Then

						dcSommeDetail += idw_wDetailFF.iudwDetailSource.GetItemDecimal ( lCpt, "MT_PLAF" )
					End If
			End If
	Next

/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdsDos		= idw_wSin.GetItemNumber ( 1, "ID_SDOS" )
	dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
	dcIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	dcMtAutreSinistre = 0
	sMtAutreSinistre = "             "

	itrTrans.PS_S06_W_DETAIL_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, dcIdGti, dcIdEvt, dtDteSurv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S02_W_DETAIL_MT_PLAF" )	Then
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée.                                    */
/*------------------------------------------------------------------*/
		sPos		= "ALT_BLOC"
		F_Message ( stMessage )
	Else
/*------------------------------------------------------------------*/
/* On détermine si on dépasse le plafond.                           */
/*------------------------------------------------------------------*/

		dcMtAutreSinistre = Dec ( sMtAutreSinistre )
		dcPlafond			= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcSommeDetail + dcMtAutreSinistre + dcMtPlaf > dcPlafond	Then
			If dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) > 0 Then
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) )

				// [PLAF_REF] // [VDOC6662]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "674", "REF_PLAF_NUM_>0" )
				
			Else 
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
				// [PLAF_REF]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "674", "NORMAL" )
			End If
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )

/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "674", sIdPara, sCptVer )

		End If
	End If

End If
	
Return ( sPos )
end function

public function integer uf_bt_valachatdefaut ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Sinistre_wDetail::uf_bt_ValAchatDefaut (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 12/05/2005
//* Libellé			: 
//* Commentaires	: Traitement du CLICK sur le bouton VALEUR ACHAT PAR DEFAUT.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF	 01/04/2009   [20090401102753490]
//*-----------------------------------------------------------------
/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/

Decimal {2} dcMtValAchatDef
Long ll_ret, lDeb, lFin, lRow, lIdGti
n_cst_string lnv_String 
Boolean bCestOk
String sVal
n_cst_string lnvPFCString

//* #1 [20090401102753490]
dcMtValAchatDef = 9999
bCestOk = False

ll_ret = Uf_Zn_MtValAchat ( String ( dcMtValAchatDef ) )

If ll_Ret = 0 Then
	idw_wDetailFF.SetItem ( 1, "MT_VAL_ACHAT", dcMtValAchatDef )
End If

If ll_Ret = 1 Then
	Choose Case idw_wDetailFF.iiErreur
		Case 1
				stMessage.bErreurG	= FALSE
				stMessage.sVar[1]	= String ( This.uf_MaxTTC_MobileChoisi () )
				stMessage.sVar[2]	= lnv_string.of_GlobalReplace( stGlb.smonnaiesymboledesire, "\", "" ) // [SUISSE].LOT3 : Gestion msg Err avec monnaie
				stMessage.sVar[3] = "le montant de la valeur d'achat"		// Erreur de Validation - 
				stMessage.sCode	= "COMD062"			
				
		Case 2
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET310"			
	End CHoose
	
	F_Message ( stMessage )
End If

//* :#1 [20090401102753490]

Return ( 1 )

end function

public function boolean uf_getautorisation (long alidDroit);//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_sinistre_wdetail::uf_GetAutorisation (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 18/05/2005 12:59:19
//* Libellé       : Lecture simple d'une autorisation
//* Commentaires  : 
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

sIdProd = String ( idw_wsin.GetItemNumber ( 1, "ID_PROD" ) )

sFindOrig   = "ID_OPER = '" + Upper ( stGlb.sCodOper ) + "' AND " + &
				  "ID_NAT_OPER = " + String ( alIdDroit ) + " AND ID_PROD = " + sIdProd

sFindOrig1   = "ID_OPER = '" + Upper ( stGlb.sCodOper ) + "' AND " + &
				  "ID_NAT_OPER = " + String ( alIdDroit ) + " AND ID_PROD = -1"


Return idwAutorisation.Find ( sFindOrig   , 1, idwAutorisation.RowCount() )  > 0 Or &
	    idwAutorisation.Find ( sFindOrig1  , 1, idwAutorisation.RowCount() )  > 0




end function

private subroutine uf_set_profilfacturation ();//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_sinistre_wdetail::uf_Set_ProfilFacturation (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 18/05/2005 17:15:35
//* Libellé       : Profil de facturation si -NA/208
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

Long lTot, lCpt

/*------------------------------------------------------------------*/
/* Rôle de facturation, droit -NA/208										  */
/*------------------------------------------------------------------*/
If Not This.uf_GetAutorisation ( 208 ) Then 
	idw_wDetailFF.Modify ( "dte_facture_t.visible = 0 dte_facture.visible = 0 num_facture_t.visible = 0 num_facture.visible = 0" )
	Return
End If

idw_wDetailFF.Modify ( "dte_facture_t.visible = 1 dte_facture.visible = 1 num_facture_t.visible = 1 num_facture.visible = 1" )

idw_wDetailFF.SetItem ( 1, "ALT_BLOC", "N" )
idw_wDetailFF.SetItem ( 1, "ALT_ATT", "N" )
idw_wDetailFF.SetItem ( 1, "ALT_SSUI", "N" )
idw_wDetailFF.SetItem ( 1, "COD_MOT_SSUI", 0 )

lTot = idw_wPiece_Detail.RowCount ()
For lCpt = lTot To 1 Step -1
	idw_wPiece_Detail.DeleteRow ( lCpt )
Next


end subroutine

private function integer uf_get_fournisseur_aregler ();//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_sinistre_wdetail::uf_Get_Fournisseur_ARegler (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 18/05/2005 17:26:30
//* Libellé       : Détermination du fournisseur à régler
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


Long lRow
String sIdGti, sIdDetail, sIdFour
Int  iIdI

/*------------------------------------------------------------------*/
/* Rôle de facturation, droit -NA/208										  */
/*------------------------------------------------------------------*/
If Not This.uf_GetAutorisation ( 208 ) Then Return -1

sIdGti = String (idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ))
sIdDetail = String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ))

lRow = idw_LstCmdeDet.Find ( "ID_GTI = " + sIdGti + " AND ID_DETAIL = " + sIdDetail, 1, idw_LstCmdeDet.RowCount () )

/*------------------------------------------------------------------*/
/* Aucune commande ne correspond OU plus d'une commande EST lié à   */
/* ce détail, donc on sort (-1) car impossible de trouver le FRN    */
/*------------------------------------------------------------------*/
If lRow <> 1 Then Return -1

sIdFour = idw_LstCmdeDet.GetItemString ( lRow, "ID_FOUR" )

lRow = idw_LstInter.Find ( "ID_FOUR = '" + Upper ( sIdFour ) + "'", 1, idw_LstInter.RowCount ())

/*------------------------------------------------------------------*/
/* Aucun Interlocuteur Fournisseur trouvé.								  */
/*------------------------------------------------------------------*/
If lRow <=0  Then Return -1

iIdI = idw_LstInter.GetItemNumber ( lRow, "ID_I" )

Return iIdI
end function

private function integer uf_copierligne_inf2sup (string asswitch, long alligdwnivinf, string ascle, ref u_datawindow_detail adwsup, ref u_datawindow_detail adwinf);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_wdetail::uf_CopierLigne_Inf2Sup (PRIVATE)
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
	/* Traitement du buffer DELETED (effacement)                        */
	/*------------------------------------------------------------------*/
	CASE "BD"

		lLigDwNivSup = adwSup.Find ( asCle, 1 , adwSup.RowCount () )
		
		If lLigDwNivSup > 0  Then 

				/*------------------------------------------------------------------*/
				/* Si on est en MultiNiveaux, on force le status de la ligne à 	  */
				/* effacer à DATAMODIFIED! afin que la suppression place cette 	  */
				/* ligne dans le buffer DELETE!,	quelque soit son status.			  */
				/*------------------------------------------------------------------*/
				adwSup.SetItemStatus ( lLigDwNivSup, 0, PRIMARY!, DATAMODIFIED! )
					
				iRet = adwSup.DeleteRow ( lLigDwNivSup )
		
		End If


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

private function integer uf_copierligne_sup2inf (boolean abdwnivinfreset, ref u_datawindow_detail adwsup, ref u_datawindow_detail adwinf);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_wdetail::uf_CopierLigne_Sup2Inf (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 05/11/1999 14:44:32
//* Libellé			: Copie TOUTES LES LIGNES du buffer PRIMAIRE d'une DW d'un niveau supérieur (0,1,..)
//*					  vers un niveau inférieur (2,3...) en replacant les ItemStatus.
//* Commentaires	: Les result set des deux Dw doivent être identiques.
//*					  uf_CopierLigneInf2Sup
//*
//* Arguments		: Boolean 					abDwNivInfReset			val  // Reset la dw niv inf.
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

Long		lNbrCol, lNbrLig, lCptLig, lCptCol
Int		iRet
DwItemStatus disStatus

If abDwNivInfReset Then adwInf.Reset ()

/*------------------------------------------------------------------*/
/* Copie des lignes niveau supérieur vers niveau inférieur.         */
/* (Attention, on recopie le buffer primare, le client est donc     */
/* libre de le filtrer.)                                            */
/*------------------------------------------------------------------*/
iRet = adwSup.RowsCopy ( 1, adwSup.RowCount(), PRIMARY!, adwInf, 1, PRIMARY! )
If IsNull ( iRet ) or iRet < 0 Then Return -1
If iRet = 0 Then Return 0

/*------------------------------------------------------------------*/
/* Recopie des Status de lignes et colonnes.                        */
/*------------------------------------------------------------------*/
lNbrCol = Long ( adwSup.Describe ( "DataWindow.Column.Count" ) )
lNbrLig = adwSup.RowCount()

If lNbrCol = 0 Or lNbrLig = 0 Then Return 0
If lNbrCol < 0 Or lNbrLig < 0 Then Return -1

For lCptLig = 1 to lNbrLig

   /*------------------------------------------------------------------*/
	/* De façons à être sûr de pouvoir modifier les status de           */
	/* colonnes, on force le status de la ligne à DATAMODIFIED!         */
	/*------------------------------------------------------------------*/
	adwInf.SetItemStatus ( lCptLig, 0, Primary!, DataModified! )


	/*------------------------------------------------------------------*/
	/* Recopie des status de colonnes.                                  */
	/*------------------------------------------------------------------*/
	For lCptCol = 1 To lNbrCol
		disStatus = adwSup.GetItemStatus ( lCptLig, lCptCol, Primary! )
		adwInf.SetItemStatus ( lCptLig, lCptCol, Primary!, disStatus )
	Next

	/*------------------------------------------------------------------*/
	/* Les status de colonne étant recopiés, on recopie à ce moment le  */
	/* status de la ligne.                                              */
	/*------------------------------------------------------------------*/
	disStatus = adwSup.GetItemStatus ( lCptLig, 0, Primary! ) 
	adwInf.SetItemStatus ( lCptLig, 0, Primary!, disStatus )

Next

Return 1
end function

private subroutine uf_gestion_detaildivers ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Gestion_DetailDivers (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 04/10/2005
//* Libellé			: Gestion des DetailDivers
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------


String 	sFiltre, sRech

sRech = "ID_GTI    = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + " AND " + &
  		  "ID_DETAIL = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )
idw_wDivDetGti.SetFilter  ( sRech )
idw_wDivDetGti.Filter ( )

This.uf_CopierLigne_Sup2Inf ( TRUE, idw_wDivDetGti, idw_wDivDet )

sFiltre = ""
idw_wDivDetGti.SetFilter ( sFiltre )
idw_wDivDetGti.Filter ()
idw_wDivDetGti.Sort ()	


end subroutine

public subroutine uf_initialiser_dw_desc (ref u_datawindow_detail adw_lstgarsin, ref u_datawindow_detail adw_lstinter, ref u_datawindow_detail adw_lstdetail, ref u_datawindow_detail adw_lstcmdegti, ref u_datawindow_detail adw_lstcmdesin, ref u_datawindow adw_wdivsin, ref u_datawindow_detail adw_wdivdetsin, ref u_datawindow_detail adw_wdivdet, ref u_datawindow adw_wdetailff, ref u_datawindow adw_wgarsin, ref datawindow adw_norm[], ref u_datawindow_detail adw_udwdet[]);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialiser_Dw_Desc (Public)
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:47:02
//* Libellé			: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*
//* Arguments		: U_DataWindow_Detail	adw_LstGarSin		(Réf)	DataWindow sur la liste des garanties
//*					  U_DataWindow_Detail	adw_LstInter		(Réf)	DataWindow sur la liste des interlocuteurs
//*					  U_DataWindow_Detail	adw_LstDetail		(Réf)	DataWindow sur la liste des détails de la garantie
//*					  U_DataWindow_Detail	adw_LstCmdeGti		(Réf)	DataWindow sur la liste des commandes de la garantie
//*					  U_DataWindow_Detail	adw_LstCmdeSin		(Réf)	DataWindow sur la liste des commandes du sinistre
//*					  U_DataWindow				adw_wDivSin			(Réf)	DataWindow sur w_Div_Sin
//*					  U_DataWindow_Detail	adw_wDivDetsin		(Réf)	Dw divers detail sur fen sinistre
//*					  U_DataWindow_Detail	adw_wDivDet			(Réf)	Dw divers detail sur fen detail
//*					  U_DataWindow				adw_wDetailFF		(Réf)	DataWindow sur le détail en cours de saisie
//*					  U_DataWindow				adw_wGarSin			(Réf)	DataWindow sur la garantie en cours de saisie
//*					  DataWindow				adw_Norm[]			(Réf)	Tableau de DataWindow 
//*					  U_DataWindow_Detail	adw_UdwDet []		(Réf)	Tableau de u_Dw_Detail local à la fenêtre détail
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* DataWindow sur les GARANTIES.      Liste => U_DataWindow_Detail. */
/*------------------------------------------------------------------*/
idw_LstGarSin	= adw_LstGarSin

/*------------------------------------------------------------------*/
/* DataWindow sur les INTERLOCUTEURS. Liste => U_DataWindow_Detail. */
/*------------------------------------------------------------------*/
idw_LstInter	= adw_LstInter

/*------------------------------------------------------------------*/
/* DataWindow sur les DETAILS      Liste => U_DataWindow_Detail.    */
/*------------------------------------------------------------------*/
idw_LstDetail	= adw_LstDetail

/*------------------------------------------------------------------*/
/* DataWindow sur les COMMANDES    Liste => U_DataWindow_Detail.    */
/*------------------------------------------------------------------*/
idw_LstCmdeGti	= adw_LstCmdeGti

/*------------------------------------------------------------------*/
/* DataWindow sur les COMMANDES    Liste => U_DataWindow_Detail.    */
/*------------------------------------------------------------------*/
idw_LstCmdeSin	= adw_LstCmdeSin

/*------------------------------------------------------------------*/
/* w_Div_Sin, Onglet Divers sur grille sinistre                     */
/*------------------------------------------------------------------*/
idw_wDivSin	= adw_wDivSin			

idw_wDivDetGti = adw_wDivDetSin
idw_wDivDet = adw_wDivDet

/*------------------------------------------------------------------*/
/* DataWindow sur le DETAIL.          Saisie => U_DataWindow.       */
/*------------------------------------------------------------------*/
idw_wDetailFF	= adw_wDetailFF

/*------------------------------------------------------------------*/
/* DataWindow sur la GARANTIE.        Saisie => U_DataWindow.       */
/*------------------------------------------------------------------*/
idw_wGarSin	= adw_wGarSin

/*------------------------------------------------------------------*/
/* On va utiliser un tableau de DW pour armer les instances du      */
/* NVUO, il faut les charger dans le bon ordre.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* DataWindow sur la table CODE GARANTIE                            */
/*------------------------------------------------------------------*/
idw_CodeGarantie	= adw_Norm[1]

/*------------------------------------------------------------------*/
/* DataWindow sur la table CODE CONDITION                           */
/*------------------------------------------------------------------*/
idw_CodeCondition	= adw_Norm[2]

/*------------------------------------------------------------------*/
/* DataWindow sur la table PIECE                                    */
/*------------------------------------------------------------------*/
idw_Piece	= adw_Norm[3]

/*------------------------------------------------------------------*/
/* DataWindow sur la table MOTIF                                    */
/*------------------------------------------------------------------*/
idw_Motif	= adw_Norm[4]

/*------------------------------------------------------------------*/
/* DataWindow sur la table FRANCHISE                                */
/*------------------------------------------------------------------*/
idw_Franchise	= adw_Norm[5]

/*------------------------------------------------------------------*/
/* DataWindow sur la table PLAFOND                                  */
/*------------------------------------------------------------------*/
idw_Plafond	= adw_Norm[6]

/*------------------------------------------------------------------*/
/* DataWindow sur la table DELAI                                    */
/*------------------------------------------------------------------*/
idw_Delai	= adw_Norm[7]

/*------------------------------------------------------------------*/
/* DataWindow sur la table GARANTIE                                 */
/*------------------------------------------------------------------*/
idw_Garantie	= adw_Norm[8]

/*------------------------------------------------------------------*/
/* DataWindow sur la table CONDITION                                */
/*------------------------------------------------------------------*/
idw_Condition	= adw_Norm[9]

/*------------------------------------------------------------------*/
/* DataWindow sur la table W_PIECE_DETAIL                           */
/*------------------------------------------------------------------*/
idw_wPiece_Detail	= adw_Norm[10]

/*------------------------------------------------------------------*/
/* DataWindow sur la table W_REFUS_DETAIL                           */
/*------------------------------------------------------------------*/
idw_wRefus_Detail	= adw_Norm[11]

/*------------------------------------------------------------------*/
/* DataWindow sur W_PPLAFOND_DETAIL (Tous les plafonds en cours)    */
/*------------------------------------------------------------------*/
idw_wPPlafond_Detail	= adw_Norm[12]

/*------------------------------------------------------------------*/
/* DataWindow sur W_PLAF_DETAIL (Nouveaux plafonds)                 */
/*------------------------------------------------------------------*/
idw_wPlaf_Detail	= adw_Norm[13]

/*------------------------------------------------------------------*/
/* DataWindow external permettant de garder les détails supprimés   */
/*------------------------------------------------------------------*/
idw_wDetailSupp	= adw_Norm[14]

/*------------------------------------------------------------------*/
/* Petites DataWindow affichant les infos concernant les commandes. */
/*------------------------------------------------------------------*/
idw_InfoCmde		= adw_Norm[15]

/*------------------------------------------------------------------*/
/* DataWindow permettant de choisir entre commander et sélectionner */
/* les mobiles pour apparation sur courrier.								  */
/*------------------------------------------------------------------*/
idw_ChoixAction	= adw_Norm[16]

/*------------------------------------------------------------------*/
/* Stockage IFR                                                     */
/*------------------------------------------------------------------*/
idwStkIfr 			= adw_Norm[17]
idwCodEquiv 		= adw_Norm[18]

/*------------------------------------------------------------------*/
/* DataWindow sur les commandes local à la fenêtre détail.			  */
/*------------------------------------------------------------------*/
idw_LstCmdeDet		= adw_UdwDet [1]

/*------------------------------------------------------------------*/
/* Stockage CODIC DARTY                                             */
/*------------------------------------------------------------------*/
idwStkCodicDarty  = adw_Norm[19]

/*------------------------------------------------------------------*/
/* Autorisation																	  */
/*------------------------------------------------------------------*/
idwautorisation  = adw_Norm[20]

idwDivPDet  	  = adw_Norm[21]

idddw_CodeCar_wDivDet_Charg_Tempo = adw_Norm[22]
idddw_Code_wDivDet_Charg_Tempo = adw_Norm[23]

idwDetailSin = adw_Norm[24] // [CONFO][NV_PROCESS]

end subroutine

private subroutine uf_gestong_divers_caspart_finaux ();//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_sinistre_detail::uf_GestOng_Divers_CasPart_Finaux (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 04/10/2005
//* Libellé       : Gestion des cas particulier à la fin du traitement de l'onglet Divers.
//* Commentaires  : 
//*
//* Arguments		: 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
//*       JFF   21/12/2010   [PC301][VESTUSTE]
//*       JFF    21/01/2011  [PC301].[V15_EVOL_VETUSTE]
//*       JFF    27/05/2011  [PC10].[DP150]
//*       JFF    24/01/2012  [CONFO][CUISINE][PC680]
//        JFF   01/03/2012   [CONFO][MEUBLE][PC542]
//        JFF   25/11/2014   [PM251-2]
//        JFF   07/11/2016   [PC151259]
//*-----------------------------------------------------------------

Long lTot, lCpt, lNbre
String sNomZone, sData, sVal
long lIdPRod, lDeb, lFin, lIdGti 
n_cst_string lnvPFCString

// #1
Boolean bGestPEC, bCasto
Boolean bConfoMeuble, bConfoLiterie, bConfoSiege

lIdProd = idw_Wsin.GetITemNumber ( 1, "ID_PROD" )
lIdGti  = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )

// #1
bGestPEC = False
F_RechDetPro ( lDeb, lFin, idw_DetPro, lIdProd, '-DP', 86 )
If lDeb > 0 Then 
	For lCpt = lDeb To lFin
		If idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) = lIdGti Then
			bGestPEC = True
			Exit
		End If 
	Next
End If

// #1
F_RechDetPro ( lDeb, lFin, idw_DetPro, lIdProd, '-DP', 43 )
bCasto = lDeb > 0

// #1
If Not bCasto And Not bGestPEC Then
	lTot = idw_WdivDet.RowCount ()

	For lCpt = lTot To 1 Step -1
		sNomZone = Upper ( idw_WdivDet.GetItemString ( lCpt, "NOM_ZONE" ) )
		Choose Case sNomZone 

			Case	"ALT_PEC", "ALT_PLAF_PEC", "DTE_PEC", "MT_PEC", "PEC"

				If Upper ( idw_WdivDet.GetItemString ( lCpt, "ALT_SUPP" )) = "O" Then
					idw_WdivDet.rowsdiscard( lCpt, lCpt, Primary! )
				End If
			
		End Choose
	Next
End If

lTot = idw_WdivDet.RowCount ()
For lCpt = 1 To lTot 

	sNomZone = Upper ( idw_WdivDet.GetItemString ( lCpt, "NOM_ZONE" ) )

	Choose Case sNomZone	

		// [PC301][VESTUSTE]
		// [PC301].[V15_EVOL_VETUSTE] // [PC10].[DP150]
		// [CONFO][CUISINE][PC680]
		// [CONFO][MEUBLE][PC542]
		// [PM251-2]
		// [PM319-1]
		// [PC151259]
		// [RS972][OPTIM_MB3&4]
		Case "ALT_PLAF_PEC", &
			  "DTE_PEC", "MT_PEC",&
			  "VETUSTE",&
			  "MT_MAX_PROPO_PLF722", &
			  "SAISIE_VAL_PUBLIQUE_MANUELLE", &
			  "REMPL_CARTE_CADEAU", &
			  "PRIS_PRESTA_BLCODE", &
			  "VALIDATION_AUTO", &
			  "VAL_PUB_ORANGE", &
			  "MT_VAL_PUBLIQUE_FORMULE",&
  			  "VAL_PUB_BOOST"

			// #1
			idw_wDivDet.SetItem ( lCpt, "ALT_PROT", "O" )		

			// #1
			If sNomZone = "MT_PEC" And This.uf_GestOng_Divers_Trouver ( "ALT_PEC" ) = "O" Then
					idw_wDivDet.SetItem ( lCpt, "ALT_PROT", "N" )		
			End If
	
			// [CONFO][CUISINE][PC680]
			If sNomZone = "REMPL_CARTE_CADEAU" Then
				lNbre = idw_wDivDet.GetItemNumber ( lCpt, "VAL_NBRE" )
				If IsNull ( lNbre ) OR lNbre = 0 Then 
					This.uf_GestOng_Divers_MajZone ( "REMPL_CARTE_CADEAU", lCpt, 1 )
				End If
			End IF
	
			// [CONFO][MEUBLE][PC542]
			If sNomZone = "PRIS_PRESTA_BLCODE" Then
				lNbre = idw_wDivDet.GetItemNumber  ( lCpt, "VAL_NBRE" )
				If IsNull ( lNbre ) OR lNbre = 0 Then 
					This.uf_GestOng_Divers_MajZone ( "PRIS_PRESTA_BLCODE", lCpt, 1 )
				End If
			End IF


		Case "TAILLE_ARTICLE"
			// [CONFO][MEUBLE][PC542]
//			This.uf_GestOng_Divers_MajZone ( "TAILLE_ARTICLE", lCpt, 1 )

		Case "ENLV_BIEN"
			// [CONFO][MEUBLE][PC542]

			// [CONFO][CUISINE][PC680]
			F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 207 )
			If lDeb > 0 Then 

				// [CONFO][NV_PROCESS]				
				// [CONFO][MEUBLE][PC542]
				// [CONFO][LITERIE][PC543]
				// [CONFO][SIEGE][PC716]
				Choose Case lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")  
					Case "MEUBLE"
						bConfoMeuble = TRUE
					Case "LITERIE"	
						bConfoLiterie = TRUE
					Case "SIEGE"	
						bConfoSiege = TRUE
						
				End Choose
			End If
			
			sVal = idw_wDivDet.GetItemString  ( lCpt, "VAL_CAR" )
			If IsNull ( sVal) OR Trim ( sVal ) = "" Then 
				This.uf_GestOng_Divers_MajZone ( "ENLV_BIEN", lCpt, "1" )
			End If
			
			// [CONFO][NV_PROCESS]				
			If bConfoLiterie Then
				This.uf_GestOng_Divers_MajZone ( "ENLV_BIEN", lCpt, "2" )
			End If

			// [CONFO][NV_PROCESS]				
			If bConfoSiege And lIdGti = 27 Then
				This.uf_GestOng_Divers_MajZone ( "ENLV_BIEN", lCpt, "2" )
			End If

		Case "SOUPLESSE_1", "SOUPLESSE_2", "SOUPLESSE_3"
			
			


/*------------------------------------------------------------------*/
/* Type de l'appareil                                               */
/*------------------------------------------------------------------*/
		Case "TYPE_APP"
//
//			Choose Case lIdProd
//
//				// Traitement particulier pour un ou plusieur produit, coder ici
//				Case 0
//
//				Case Else
//
//					sData = Upper ( This.uf_GestOng_Divers_Trouver ( "TYPE_APP" ) )
//			
//					This.Uf_Zn_Trt_DivSin_TypeApp ( sData, "VAL_LST_CAR", lCpt, TRUE )
//
//			End Choose 

/*------------------------------------------------------------------*/
/* CODIC DARTY, toujours protéger, jamais saisissable (vu avec DGA) */
/*------------------------------------------------------------------*/
		Case "CODIC"

//			// Protection contre saisie
//			idw_WdivDet.SetItem ( lCpt,"ALT_PROT", "O" )	
//
//			sData = Trim ( This.uf_GestOng_Divers_Trouver ( "CODIC" ) )
//			If IsNull ( sData ) Then sData = "" 
//			If Long ( sData ) = 0 Then sData = ""
//
///*------------------------------------------------------------------*/
///* Si Pas de CODIC, on ne gère pas le dossier, Problème.			     */
///*------------------------------------------------------------------*/
//			If sData = "" And isTypeTrt = "S" Then
//				stMessage.sTitre		= "CODIC Absent !"
//				stMessage.Icon			= Exclamation!
//				stMessage.bErreurG	= FALSE
//				stMessage.Bouton		= OK!
//				stMessage.sCode		= "WDSI001"
//				//iPbControler.Enabled = FALSE
//				F_Message ( stMessage )
//	
//			Else
//				This.Uf_Zn_Trt_DivSin_Codic ( sData, "VAL_NBRE", lCpt, TRUE )
//			End If


	End Choose

Next


end subroutine

public subroutine uf_gestong_divers_dddw (string asData, string asNomCol, long alRow);//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_sinistre_detail::uf_GestOng_Divers_DDDW (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 04/10/2005
//* Libellé       : Gestion des listes DDDW de l'onglet Divers
//* Commentaires  : Traitement particuliers afin de pouvoir gèrer plusieurs
//*					  liste "code_car" et plusieurs list "code"
//*
//* Arguments		: String		asData		Val
//*					  String		asNomCol		Val
//*					  Long		alRow			Val
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

String sNomZone
DataWindowChild dwChild
Long  lTotVal, lCptVal

If alRow <= 0 Then Return

sNomZone = Upper ( idw_wDivDet.GetItemString ( alRow, "NOM_ZONE" ) )

Choose Case asNomCol

	Case "VAL_LST_CAR", "VAL_LST_NBRE"

		If asNomCol = "VAL_LST_CAR" Then
			idw_wDivDet.GetChild ( "VAL_LST_CAR", dwChild )
		Else
			idw_wDivDet.GetChild ( "VAL_LST_NBRE", dwChild )
		End if 

		lTotVal = dwChild.RowCount ()

		For lCptVal = 1 To lTotVal
			If Upper ( dwChild.GetItemString ( lCptVal, "NOM_ZONE" )) = sNomZone Then
				dwChild.SetItem ( lCptVal, "ALT_VISIBLE", 1 )
			Else
				dwChild.SetItem ( lCptVal, "ALT_VISIBLE", 2 )
			End IF 
		Next		

		dwChild.Sort ()

End Choose



end subroutine

private function string uf_controlergestion_ongletdivers (ref string asong);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerGestion_OngletDivers (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 16/07/2004
//* Libellé			: Gestion du contrôle de saisie/gestion lié à l'onglet DIVERS
//* Commentaires	: 
//*
//* Arguments		: String			asOng					Réf
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   10/01/2007   DCMP060798/060799
//* #2	 JFF	 30/05/2007	  [DCMP070355] Adaption du code pour Casto et hors casto
//			FPI	24/08/2011		[VDoc5059]
//       JFF   24/01/2012  [CONFO][CUISINE][PC680]
//        JFF   01/03/2012  [CONFO][MEUBLE][PC542]
//*-----------------------------------------------------------------

String	sPos, sNouvelleLigne, sText, sCodeZone, sAide, sVal
Boolean	bTjsOblig, bDetAREG, bAltProt  
Long		lCodEtatSin, lIdProd, lCpt, lTotZoneDet, lTotZoneParam, lRow, lIdGti, lDeb, lFin
Boolean bCasto, bConfo, bExcepConfo
Decimal {2} dcMtValAChat
Long lIdEvt 

sPos = ""
sAide = " (Onglet 'divers')"
lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
lIdEvt = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
dcMtValAChat = idw_wDetailFF.GetItemNumber ( 1, "MT_VAL_ACHAT" )

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 43 )
bCasto = lDeb > 0

// [CONFO][CUISINE][PC680]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 207 )
bConfo = lDeb > 0

bExcepConfo=False
If bConfo Then 
	Choose Case lIdEvt
		Case 1317, 1083
			// On ne controle pas
			bExcepConfo=True
	End Choose
End If 
// :[CONFO][CUISINE][PC680]

/*------------------------------------------------------------------*/
/* Si la dw des gestion renseignée, ne comporte aucune zone, on     */
/* ressort.                                                         */
/*------------------------------------------------------------------*/
If idw_wDivDet.RowCount () <= 0 Then Return ""

sNouvelleLigne		= "~r~n"
sText					= sNouvelleLigne
lIdProd 				= idw_Wsin.GetItemNumber ( 1, "ID_PROD" )

lTotZoneDet = idw_wDivDet.RowCount ()
lTotZoneParam = idwDivPDet.RowCount ()

/*------------------------------------------------------------------*/
/* Le détail est-il à régler ?                                      */
/*------------------------------------------------------------------*/
bDetAREG = idw_wDetailFF.GetItemNumber ( 1, "COD_ETAT" ) = 500

/*------------------------------------------------------------------*/
/* Pour chaque zone de l'onglet Divers affichée sur le dossier.     */
/*------------------------------------------------------------------*/
For lCpt = 1 To lTotZoneDet

/*------------------------------------------------------------------*/
/* id_code lib_code                                                 */
/* ------- -----------------------------------                      */
/* -1      Unité div_pro div_sin                                    */
/* C       Chaine                                                   */
/* D       Date                                                     */
/* LC      Liste de valeur CAR                                      */
/* LN      Liste de valeur NUM                                      */
/* N       Nombre                                                   */
/* P       Taux                                                     */
/* S       Montant                                                  */
/* X       Alt                                                      */
/*------------------------------------------------------------------*/
/* La donnée est-elle renseignée												  */
/*------------------------------------------------------------------*/
	Choose Case Upper ( idw_wDivDet.GetItemString ( lCpt, "ID_TYP_ZONE" ) )
		Case "C", "LC", "X"
			sVal = Trim ( idw_wDivDet.GetItemString ( lCpt, "VAL_CAR" ) )
		Case "D"
			sVal = Trim ( String ( idw_wDivDet.GetItemDateTime ( lCpt, "VAL_DTE" )))	// [PI056].20190926
		Case "N", "LN"
			sVal = Trim ( String ( idw_wDivDet.GetItemNumber ( lCpt, "VAL_NBRE" )))
			If Long ( sVal ) = 0 Then sVal = ""
		Case "P", "S"
			sVal = Trim ( String ( idw_wDivDet.GetItemDecimal ( lCpt, "VAL_MT" )))
			If Dec ( sVal ) = 0 Then sVal = ""
	End Choose

/*------------------------------------------------------------------*/
/* Si la donnée est renseignée, on passe au suivant.	              */
/*------------------------------------------------------------------*/
	If IsNull ( sVal ) Then sVal = ""

	sCodeZone = Lower ( idw_wDivDet.GetItemString ( lCpt, "NOM_ZONE" ) )
	
	// [CONFO][MEUBLE][PC542]
	Choose Case sCodeZone 
		Case "enlv_bien"
			If Long ( sVal ) = 1 Then
				sVal = ""
			End If
	End CHoose 
	
	If sVal <> "" Then Continue

	bAltProt  = idw_wDivDet.GetItemString ( lCpt, "ALT_PROT" ) = "O"

/*------------------------------------------------------------------*/
/* La zone trouvée sur le dossier a-t-elle (encore) un paramètrage  */
/* actif ?                                                          */
/*------------------------------------------------------------------*/
	lRow = idwDivPDet.Find ( "ID_PROD = " + String ( lIdProd ) + " AND NOM_ZONE = '" + sCodeZone + "'", 1, lTotZoneParam )

/*------------------------------------------------------------------*/
/* Si Oui, on récupére le param.                                    */
/*------------------------------------------------------------------*/
	If lRow > 0 Then
		bTjsOblig = idwDivPDet.GetItemString ( lRow, "ALT_OBLIG" ) = "O"
/*------------------------------------------------------------------*/
/* Sinon on le fixe par défaut.                                     */
/*------------------------------------------------------------------*/
	ELse
		bTjsOblig = FALSE
	End If 


/*------------------------------------------------------------------*/
/* !! AJOUTER les nlles zn à contrôler, ICI !!							  */
/*------------------------------------------------------------------*/
/* En fonction de la zone trouvée sur l'onglet Divers, on           */
/* déclenche un action.                                             */
/*------------------------------------------------------------------*/
	Choose Case sCodeZone 

		/*------------------------------------------------------------------*/
		/* Zone : Marque de l'appareil (casto)										  */
		/*------------------------------------------------------------------*/
		Case "marq_app"

			If bTjsOblig And Not bAltProt Then
				If sPos = "" Then sPos = "ALT_BLOC"
				sText += "- La marque de l'appareil" + sAide + sNouvelleLigne
			End If 

		/*------------------------------------------------------------------*/
		/* Zone : Marque de l'appareil (casto)										  */
		/*------------------------------------------------------------------*/
		Case "modl_app"

			If bTjsOblig And Not bAltProt Then
				If sPos = "" Then sPos = "ALT_BLOC"
				sText += "- La modèle de l'appareil (ou description si aucune marque)" + sAide + sNouvelleLigne
			End If 

		/*------------------------------------------------------------------*/
		/* Zone : Quantité (casto)														  */
		// :[CONFO][CUISINE][PC680]
		/*------------------------------------------------------------------*/
		Case "qte"

			If bTjsOblig And Not bAltProt And Not bExcepConfo Then
				If sPos = "" Then sPos = "ALT_BLOC"
				sText += "- La quantité" + sAide + sNouvelleLigne
			End If 

		/*------------------------------------------------------------------*/
		/* Zone : Type prestation (casto)  										     */
		/*------------------------------------------------------------------*/
		// #1 // #2 [DCMP070355] Adaption du code pour Casto et hors casto
		Case "typ_presta"
			lRow = idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'PEC' AND VAL_LST_CAR = 'O'" , 1, idw_wDivDet.RowCount ())
			If ( ( lRow > 0 and bCasto ) Or Not bCasto ) And bTjsOblig And Not bAltProt And lIdGti = 15 Then
				If sPos = "" Then sPos = "ALT_BLOC"
				sText += "- Le type de prestation" + sAide + sNouvelleLigne
			End If 

		// [VDoc5059]
		Case "mt_tot_conso"
			If bTjsOblig And Not bAltProt Then
				If sPos = "" Then sPos = "ALT_BLOC"
				sText += "- La consommation totale" + sAide + sNouvelleLigne
			End If 

		Case "mt_conso_moyenne"
			If bTjsOblig And Not bAltProt Then
				If sPos = "" Then sPos = "ALT_BLOC"
				sText += "- La consommation moyenne" + sAide + sNouvelleLigne
			End If 

		// [CONFO][CUISINE]			
		Case "code_article"
			If bTjsOblig And Not bAltProt And Not bExcepConfo Then
				If sPos = "" Then sPos = "ALT_BLOC"
				sText += "- Le code de l'article" + sAide + sNouvelleLigne
			End If 

		// [CONFO][CUISINE]			
		Case "lib_article"
			If bTjsOblig And Not bAltProt And Not bExcepConfo Then
				If sPos = "" Then sPos = "ALT_BLOC"
				sText += "- Le libellé de article" + sAide + sNouvelleLigne
			End If 
			
		// [CONFO][CUISINE]			
		Case "dte_fin_gti_article"
			If bTjsOblig And Not bAltProt And Not bExcepConfo Then
				If sPos = "" Then sPos = "ALT_BLOC"
				sText += "- La date de fin de garantie de l'article" + sAide + sNouvelleLigne
			End If 
			
			If Not IsDate ( sVal ) And Not bExcepConfo Then
				If sPos = "" Then sPos = "ALT_BLOC"
				sText += "- Une date de fin de garantie valide" + sAide + sNouvelleLigne
			End IF
				
		// [CONFO][MEUBLE][PC542]		
		Case "taille_article"
			If bTjsOblig And Not bAltProt And Not bExcepConfo Then
				If IsNull ( sVal ) Or Trim ( sVal ) = "" Then
					If sPos = "" Then sPos = "ALT_BLOC"
					sText += "- La taille de l'article" + sAide + sNouvelleLigne
				End If
			End If 

		// [CONFO][NV_PROCESS]
/*
		Case "enlv_bien"
			If bTjsOblig And Not bAltProt And Not bExcepConfo Then
				If ( IsNull ( sVal ) Or Trim ( sVal ) = "" ) And dcMtValAChat <= 200 Then
					If sPos = "" Then sPos = "ALT_BLOC"
					sText += "- l'avis du client sur la récupération du bien est obligatoire pour les valeurs d'achat inférieures ou égale à 200€" + sAide + sNouvelleLigne
				End If
			End If 
*/
			
	End Choose

Next

If sPos <> "" Then 
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "GENE001"
	stMessage.sTitre		= "Contrôle de gestion"
	stMessage.Icon			= Information!
	stMessage.Bouton		= Ok!
	stMessage.sVar [1]   = sText
	
	asOng = "04"
End If

Return sPos

end function

public function string uf_gestong_divers_trouver (string asnomzone);//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_sinistre_detail::uf_GestOng_Divers_Trouver (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 07/10/2005
//* Libellé       : Trouver une valeur sur une zone de l'oglet divers
//* Commentaires  : 
//*
//* Arguments		: String			asNomZone		Val
//*
//* Retour			: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//* #1	 PHG	 29/02/2008	  [DCMP080111] Création des Variables ZVAR35 à 39
//* 								  Refonte Fonction => Forme Générique
//*-----------------------------------------------------------------

Long lTot, lFound
String sNomZone, sData, sIdTypZone

sData = ""

lTot = idw_WDivDet.RowCount ()

lFound = idw_WDivDet.Find("UPPER(NOM_ZONE) = '" + upper(asNomZone) + "'", 1, lTot )

if lfound > 0 Then
	sIdTypZone = idw_WDivDet.object.id_typ_zone[lFound]
	Choose Case sIdTypZone
		Case 'C', 'X', 'LC'
			sData = Upper ( idw_WDivDet.GetItemString ( lFound, "VAL_CAR" ) )
		Case 'D'
			sData = String ( idw_WDivDet.GetItemDateTime ( lFound, "VAL_DTE" ), "dd/mm/yyyy"  )	// [PI056].20190926
		Case 'N', 'LN'
			sData = String ( idw_WDivDet.GetItemNumber ( lFound, "VAL_NBRE" ) ) 
		Case 'S'
			sData = String ( idw_WDivDet.GetItemdecimal ( lFound, "VAL_MT" ), "#,##0.00" ) 
		Case 'P'
			sData = String ( idw_WDivDet.GetItemdecimal ( lFound, "VAL_MT" ), "##0.00" ) 			
	End Choose

End If

Return Trim (sData)

// Ancien Code
//
//Long lTot, lCpt, lDeb, lFin
//String sNomZone, sData
//
//sData = ""
//
//asNomZone = Upper ( asNomZone )
//
//lTot = idw_wDivDet.RowCount ()
//
//For lCpt = 1 To lTot
//
//	sNomZone = Upper ( idw_wDivDet.GetItemString ( lCpt, "NOM_ZONE" ) )
//
//	Choose Case sNomZone	
//
//		Case "MARQ_APP", "MODL_APP"
//
//			If sNomZone = asNomZone Then
//				sData = idw_wDivDet.GetItemString ( lCpt, "VAL_CAR" )
//			End If			
//
//		Case "AUCUNE_MARQ", "PEC", "ALT_PEC"
//
//			If sNomZone = asNomZone Then
//				sData = idw_wDivDet.GetItemString ( lCpt, "VAL_ALT" ) 
//			End If			
//
//		Case "QTE", "COD_ACTION"
//
//			If sNomZone = asNomZone Then
//				sData = String ( idw_wDivDet.GetItemNumber ( lCpt, "VAL_NBRE" ) )
//			End If			
//
//		Case "MT_PEC"
//
//			If sNomZone = asNomZone Then
//				sData = String ( idw_wDivDet.GetItemDecimal ( lCpt, "VAL_MT" ) )
//			End If			
//
//
//
//	End Choose
//
//Next
//
//Return sData
end function

private function boolean uf_rf_653 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_653 (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 11/10/2005
//* Libellé			: Seuil d'intervention non atteint
//* Commentaires	: Seuil spécial : ( La QTE (ong divers) / Val Achat ) > au seuil pour passé
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1		PHG	26/10/2009 [DCMP071000] rf 655+651: Annexe : Correction Bug
//*								  présent sur toute les fonctions de refus.
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lQte, lDeb, lFin
String sIdNivPlaf, sIdRefPlaf
Boolean bRet

Decimal {2} dcMtValAchat

/* Créer à l'origine pour Castoram -DP/43 */

String sRech
bRet				= True
lTotPlaf 		= idw_Plafond.RowCount ()
dcMtValAchat	= idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" )
lQte 				= Long ( This.uf_GestOng_Divers_Trouver ("QTE" ) )

/*------------------------------------------------------------------*/
/* Si le montant du préjudice est NULL ou égal à zéro, on ne gére   */
/* pas de refus.                                                    */
/*------------------------------------------------------------------*/
If	IsNull ( dcMtValAchat ) Or dcMtValAchat = 0 Then Return ( bRet )
IF IsNull ( lQte ) Or lQte = 0 Then Return ( bRet )

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 1 to 5

	Choose Case lCpt
		Case 1
			sIdNivPlaf = "-GA"  // Garantie
			sIdRefPlaf = "-1"
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond 										  */
	/*------------------------------------------------------------------*/
	// #1 [DCMP071000] Lecture ID_GTI dans idw_wDetailFF ald de idw_wGarSin
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '" + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"																					+ " AND " 	+ &
					"ID_TYP_PLAF = '653'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* Si le montant du préjudice est strictement inférieur au montant  */
/* du plafond, on déclenche le refus 653.                           */
/*------------------------------------------------------------------*/
		If	( dcMtValAchat / lQte ) < idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )	Then
			bRet = Uf_RF_EcrireRefus ( 653 )
			Exit
		End If
	End If
Next

Return ( bRet )
end function

private function string uf_rechecherplafond_pec ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_wdetail::Uf_RechecherPlafond_Pec (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 11/10/2005
//* Libellé			: Recherche des plafonds en amont pour les gestions de prise en charge
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: O/N : O=Au moins plaf s'est déclenche
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
//* #2	 JCA		25/10/2007	DCMP 70428 Memoriser les paragraphes de plafonds pour les utiliser dans l'appelant
//*       JFF    17/06/2011  [PC545].[BUG_BGE_721]
//*       JFF    27/07/2011  [PLAF_REF]	
//*----------------------------------------------------------------

// #1 fonction revu intégralement.

Long lIdGti, lIdDetail, lRow, lTotDetail, lCptDet, lDeb, lFin, lCpt
s_Plafond_Pec stPlafPec
u_DataWindow udwNull 
Decimal {2} dcMtPec, dcMtLu, dcMtMaxLu
Decimal {2} dcPlafGti, dcPlafEvt, dcPlafValAch, dcPlafDef, dcPlafSav

// #2
String asTypParaVer[], sTempTypPlaf, sTempIdPara, sTempCptVer, sValCar
integer i
Long lTotPlafond, lCptPlaf, lCodeRef
String sVal, sRech	
n_cst_string lnvPFCString

SetNull ( udwNull )

lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) 
lIdDetail = idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" )
sVal = ""

// [PC545].[BUG_BGE_721]
//* F_Plafond_Pec 
//* Retourne		: Structure s_plafond_pec (0 indique qu'il n'y a pas de plafond)
//*					  Pour le type Autre, le retour est sous cette forme
//*					  O[704][3]    => OUI, plaf 704, x3 (en cours + autre)
//*					  N[704][1]		=> NON, plaf 704, x1 ( juste l'en cours)

//	 [PC363].[10%]
lRow = idw_LstCmdeSin.Find ( "COD_ETAT <> 'ANN' AND POS ( INFO_FRN_SPB_CPLT, 'APP_INCOMPLET=OUI', 1) >0", 1, idw_LstCmdeSin.RowCount () )
sVal = "[###]"

If lRow > 0 Then
	lnvPFCString.of_Setkeyvalue ( sVal, "APP_INCOMPLET", "OUI", ";")
End If

// [PC301].[V15_EVOL_VETUSTE]
lTotDetail = idw_wDetailFF.iudwDetailSource.RowCount ()
dcMtLu = 0
dcMtMaxLu = 0
For lCptDet = 1 To lTotDetail	
	
	sRech	=		"ID_GTI = "	+ String ( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCptDet, "ID_GTI" ) )	+ " AND " 	+ &
					"ID_DETAIL = "	+ String ( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCptDet, "ID_DETAIL" ) )	+ " AND " 	+ &
					"UPPER ( NOM_ZONE ) = 'MT_MAX_PROPO_PLF722'"
		
	lRow = idw_wDivDetGti.Find ( sRech, 1, idw_wDivDetGti.RowCount () ) 
	If lRow > 0 Then
		dcMtLu = idw_wDivDetGti.GetItemDecimal ( lRow, "VAL_MT" )
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

stPlafPec = F_Plafond_Pec ( "3" + sVal, idw_wSin, idw_wDivSin, udwNull, idw_wDetailFF, udwNull, idw_Plafond, idw_DetPro, idw_produit, idw_wDivDet, lIdGti, lIdDetail )

dcPlafValAch = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" )
dcMtPec = dcPlafValAch 

If ( dcMtPec > stPlafPec.dcPlafEvt And stPlafPec.dcPlafEvt > 0 ) Or dcMtPec <= 0 Then dcMtPec = stPlafPec.dcPlafEvt
If ( dcMtPec > stPlafPec.dcPlafValAch And stPlafPec.dcPlafValAch > 0 ) Or dcMtPec <= 0 Then dcMtPec = stPlafPec.dcPlafValAch
If ( dcMtPec > stPlafPec.dcPlafGti  And stPlafPec.dcPlafGti  > 0 ) Or dcMtPec <= 0 Then dcMtPec = stPlafPec.dcPlafGti  
If ( dcMtPec > stPlafPec.dcPlafValPublique And stPlafPec.dcPlafValPublique > 0 ) Or dcMtPec <= 0 Then dcMtPec = stPlafPec.dcPlafValPublique
If Left ( stPlafPec.sPlafAutre, 1 ) = "O" Then dcMtPec = 0 
If dcMtPec <= 0 Then dcMtPec = 0

If IsNull ( dcMtPec ) Then dcMtPec = 0

// #2

// JFF (#2)
lTotPlafond = idw_wPlaf_Detail.RowCount ()
For	lCptPlaf = 1 To lTotPlafond
	idw_wPlaf_Detail.SetItem ( lCptPlaf, "ALT_BOUGE", "S" )
Next		
// JFF (:#2)


if stPlafPec.stypparaver <> "" then
	f_decomposerchaine (stPlafPec.stypparaver, ";", asTypParaVer[])
	for i = 1 to UpperBound(asTypParaVer)
		if asTypParaVer[i] <> "" then
			sTempTypPlaf = left (left (asTypParaVer[i], 8), 4)
			sTempIdPara  = right (left (asTypParaVer[i], 8), 4)
			sTempCptVer  = right (asTypParaVer[i], 3)
			
			Uf_Plaf_EcrirePara ( sTempTypPlaf, sTempIdPara, sTempCptVer )
		end if
	next
end if
// FIN - #2

// [PLAF_REF]
If ( dcMtPec <= 0 Or dcMtPec = 0.01 ) Then 
	dcMtPec = 0 

	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 183 )
	If lDeb > 0 And dcMtPec = 0  Then
		f_decomposerchaine (stPlafPec.stypparaver, ";", asTypParaVer[])
		for i = 1 to UpperBound(asTypParaVer)
			if asTypParaVer[i] <> "" then
				sTempTypPlaf = left (left (asTypParaVer[i], 8), 4)
				sTempIdPara  = right (left (asTypParaVer[i], 8), 4)
				sTempCptVer  = right (asTypParaVer[i], 3)
				
				For lCpt = lDeb To lFin
					If Long ( idw_DetPro.GetItemString ( lCpt, "ID_CODE_CAR" ) ) = Long ( sTempTypPlaf ) Then
						sValCar = idw_DetPro.GetItemString ( lCpt, "VAL_CAR" )
						lCodeRef = Long ( lnvPFCString.of_getkeyvalue( sValCar, "REF_EVT", ";"))

						// Evol
						If Long ( lnvPFCString.of_getkeyvalue( sValCar, "REF_GTI", ";")) > 0 And lCodeRef = 0 Then
							Continue
						End if
					
						If Not Uf_RF_EcrireRefus ( lCodeRef ) Then
							Return "LIB_DET" // [PLAF_REF]
						End If
					End If 
				Next
			end if
		next
		
	End If
End IF
// [PLAF_REF]


If ( dcPlafValAch > dcMtPec And dcMtPec > 0 ) Then
	Return "O"
Else 
	Return "N"
End If

end function

private subroutine uf_controlergestion_pec (ref string aspos);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerGestion_PEC (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/11/2003 
//* Libellé			: 
//* Commentaires	: Contrôle de gestion particulier pour les prises en charges.
//*
//* Arguments		: String		asPos		Réf.
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF  13/10/2006 DCMP 060755 Forcçage dossier Casto
//* #2  JFF  04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
//* #3  JFF  04/07/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge : Modif
//*								  on autorise la PEc même avec dem de pièce
//* #4  JFF  03/06/2008   [DCMP080077].BUG1 On Autorise une refus opérateur si presta liée ne irrép. 21
//* #5  JFF  01/07/2008   [DCMP080370]
//* #6  PHG  24/12/2009   [O2M_DIAG_NOMADE].Lot2 Point 3.2
//* #7  JFF  15/01/2010   [O2M_DIAG_NOMADE].Lot2.JFF
//*     JFF  27/07/2011   [PLAF_REF]
//*     JFF  10/09/2012   [ITSM129341]
//*     JFF  14/12/2012   [ITSM138882]
//*     JFF  21/06/2012   [VDOC10608]
//      JFF  17/05/2016   [PM280-2]
//*-----------------------------------------------------------------

Long lDeb, lFin, lRow, lIdGti, lCpt, lIdDetail, lRowPrs, LRowPrs21, lIdEvt
Boolean bCasto, bAuMoinsUnPlafond, bAuMoinsUnRefus, bGestPec, bDemSansSuite 
Boolean bPriseEnChargeCoche, bForcagePriseEnChargeCoche, bForcageReglement, bChercheARegler
Boolean bAumoinsUnRefusOpe // #4 [DCMP080077].BUG1
Boolean bAumoinsUnePiece // #5 [DCMP080370]
Boolean bShunt1

String sVal, sPos

If idw_wDetailFF.GetItemString ( 1, "ALT_BLOC" ) = "O" Then Return
lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) 

//#3
lIdDetail  = idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) 
// [ITSM129341]
lIdEvt     = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) 

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 43 )
bCasto = lDeb > 0

// #2
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 86 )
bGestPEC = False
If lDeb > 0 Then
	For lCpt = lDeb To lFin
		If idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) = lIdGti Then
			bGestPEC = True
			Exit
		End If 
	Next
End If

// #2
If Not bCasto And Not bGestPec Then Return

// #2
If bCasto And asPos <> "" Then Return

// #4 [DCMP080077].BUG1
bAumoinsUnRefusOpe = iuoTagRefus.dw_Trt.Find ( "ALT_OPE = 'O'", 1, iuoTagRefus.dw_Trt.RowCount () ) > 0
bAumoinsUnePiece = iuoTagPiece.dw_Trt.Find ( "ALT_RECLAME = 'O'", 1, iuoTagPiece.dw_Trt.RowCount () ) > 0 // #5 [DCMP080370]

// #2
If bAumoinsUnePiece Or bAumoinsUnRefusOpe Then

	lRow = idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'PEC'" , 1, idw_wDivDet.RowCount ())		

	// #2 //#5  [DCMP080370]
	If bCasto And bAumoinsUnRefusOpe Then 

		If lRow > 0 Then
			idw_wDivDet.SetItem ( lRow, "VAL_ALT", "N" )
			idw_wDivDet.SetItem ( lRow, "MAJ_LE", DateTime ( Today (), Now () ) )
			idw_wDivDet.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )
			idw_wDivDet.SetItem ( lRow, "ALT_SUPP", "N" )	
		End If
	
		lRow = idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'ALT_PEC'" , 1, idw_wDivDet.RowCount ())
		If lRow > 0 Then
			idw_wDivDet.SetItem ( lRow, "VAL_ALT", "N" )
			idw_wDivDet.SetItem ( lRow, "MAJ_LE", DateTime ( Today (), Now () ) )
			idw_wDivDet.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )
			idw_wDivDet.SetItem ( lRow, "ALT_SUPP", "N" )	
		End If
	End If

	// #2
	If bGestPec Then

		If lRow > 0 Then
			If idw_wDivDet.GetItemString ( lRow, "VAL_CAR" ) = "O" Then

				LRowPrs = idw_LstCmdeDet.Find ( "ID_GTI = " + String ( lIdGti ) + &
														  " AND ID_DETAIL = " + String ( lIdDetail ) + &
														  " AND ID_TYP_ART = 'PRS'", 1, idw_LstCmdeDet.RowCount () )
														  
			   // #4 [DCMP080077].BUG1
				LRowPrs21 = idw_LstCmdeDet.Find ( "ID_GTI = " + String ( lIdGti ) + &
														  " AND ID_DETAIL = " + String ( lIdDetail ) + &
														  " AND ID_TYP_ART = 'PRS' AND STATUS_GC = 21", 1, idw_LstCmdeDet.RowCount () )
			   // :#4 [DCMP080077].BUG1
														  

				// #3 Si présence d'une réparation et dem de piècen, on ne déclenche pas le blocage.
			   // #4 [DCMP080077].BUG1 Si présence d'une réparation irrép ET AMU un refus Opé, on ne déclenche pas le blocage.
				// [ITSM129341]
				// [PM280-2] 1426
				If Not ( &
						( lRowPrs > 0 And iuoTagPiece.dw_Trt.Find ( "ALT_RECLAME = 'O'", 1, iuoTagPiece.dw_Trt.RowCount () ) > 0 ) &
						OR &
						( LRowPrs21 > 0 And bAumoinsUnRefusOpe ) &
						 ) &
					And lIdEvt <> 1083 &
					And lIdEvt <> 1426 &
					Then
				
					stMessage.bErreurG	= FALSE
					stMessage.sTitre		= "Action incohérente"
					stMessage.Icon			= Information!
					stMessage.sCode = "WDET528"
					asPos = "LIB_DET"
					f_Message ( stMessage )
					Return
					
				End If
			End If 
		End If
	End If
End If

// #2
bAuMoinsUnPlafond = FALSE
If bCasto Then 

	// [PLAF_REF]
	sVal = This.Uf_RechecherPlafond_Pec ()
	
	Choose Case sVal
		Case "LIB_DET" 
			sPos = sVal
		Case Else
			bAuMoinsUnPlafond = sVal = "O"
	End Choose
	// [PLAF_REF]
End If

bAuMoinsUnRefus   = iuoTagRefus.dw_Trt.Find ( "ALT_OPE = 'O' OR ALT_MAC = 'O'", 1, iuoTagRefus.dw_Trt.RowCount () ) > 0
bPriseEnChargeCoche = This.uf_GestOng_Divers_Trouver ("PEC" ) = "O"
bForcagePriseEnChargeCoche = This.uf_GestOng_Divers_Trouver ("ALT_PEC" ) = "O"

// #2
bChercheARegler = idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" ) > 0 
bDemSansSuite = idw_wDetailFF.GetItemString ( 1, "ALT_SSUI" ) ="O"
// #1
bForcageReglement = idw_wDetailFF.GetItemString ( 1, "ALT_REG" ) = "O" And idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" ) > 0 

// #6 [O2M_DIAG_NOMADE].Lot2 Point 3.2
// #7 [O2M_DIAG_NOMADE].Lot2.JFF
// if uf_controlergestion_o2m_AppRecupRecycl() and Not bForcagePriseEnChargeCoche Then
 if bPriseEnChargeCoche And uf_controlergestion_o2m_AppRecupRecycl() and Not bForcagePriseEnChargeCoche Then
		stMessage.bErreurG	= FALSE
		stMessage.sTitre		= "Interdiction de prendre en charge"
		stMessage.Icon		= Information!
		stMessage.sCode		= "WDET571"
		asPos 					= "LIB_DET"
		f_Message ( stMessage )

		// #7 [O2M_DIAG_NOMADE].Lot2.JFF
		Return
End If
// :[O2M_DIAG_NOMADE].Lot2 Point 3.2


/*------------------------------------------------------------------*/
/* Si au moins un plafond a été déclenché, sans qu'il y ait de      */
/* refus alors je force moi-même un refus/plafond (660) même s'il   */
/* n'est pas paramètré.															  */
/*------------------------------------------------------------------*/
// #2
If asPos = "" And bCasto And bAuMoinsUnPlafond And Not bAuMoinsUnRefus Then
	If Not Uf_RF_EcrireRefus ( 660 ) Then
		asPos = "LIB_DET"
	Else 
		iuoOng.Uf_ChangerBitmap ( "03", "K:\PB4OBJ\BMP\8_REF.BMP" )
	End If
	bAuMoinsUnRefus = TRUE
End If

/*------------------------------------------------------------------*/
/* S'il y a refus ET que la PEC est coché SANS être forcée, ALORS   */
/* REFUS+MESS.                                                      */
/*------------------------------------------------------------------*/
// #4 [DCMP080077].BUG1 ajout du cas LRowPrs21 > 0 And bAumoinsUnRefusOpe
// [PM280-2] lIdEvt <> 1426 
If asPos = "" And bAuMoinsUnRefus And bPriseEnChargeCoche And Not bForcagePriseEnChargeCoche And &
   Not ( LRowPrs21 > 0 And bAumoinsUnRefusOpe ) And & 
	lIdEvt <> 1426 &
	Then

	lRow = idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'PEC'" , 1, idw_wDivDet.RowCount ())

	If bCasto and lRow > 0 Then
		idw_wDivDet.SetItem ( lRow, "VAL_ALT", "N" )
		idw_wDivDet.SetItem ( lRow, "MAJ_LE", DateTime ( Today (), Now () ) )
		idw_wDivDet.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )
		idw_wDivDet.SetItem ( lRow, "ALT_SUPP", "N" )	
	End If
	
	// #2
	If bGestPec Then
		idw_wDetailFF.SetItem ( 1, "ALT_ATT", "N" )			
		idw_wDetailFF.SetItem ( 1, "COD_ETAT", 0 )						
		
		stMessage.bErreurG	= FALSE
		stMessage.sTitre		= "Action incohérente"
		stMessage.Icon			= Information!
		stMessage.sCode = "WDET529"

		// [ITSM138882]
		If This.uf_GetAutorisation ( 208 ) Then 
			lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'ALT_PEC'", 1, idw_wDivDet.RowCount () )
			If lRow > 0 Then
				This.uf_GestOng_Divers_MajZone ( "ALT_PEC", lRow, "O" )
				
				stMessage.bErreurG	= FALSE
				stMessage.sTitre		= "Information pour Cellule Presta"
				stMessage.Icon			= Information!
				stMessage.sCode = "WDET621"
			End If 
		End If
		// :[ITSM138882]
		
		asPos = "LIB_DET"
		f_Message ( stMessage )
		Return
	End If
/*		
	idw_wDetailFF.SetItem ( 1, "COD_DEC_MAC", 200 )
// #1
	If bForcageReglement Then
		idw_wDetailFF.SetItem ( 1, "COD_DEC_OPE", 500 )
	Else	
		idw_wDetailFF.SetItem ( 1, "COD_DEC_OPE", 200 )
	End If 

	If bForcageReglement Then
		idw_wDetailFF.SetItem ( 1, "COD_ETAT", 500 )
	Else	
		idw_wDetailFF.SetItem ( 1, "COD_ETAT", 200 )
	End If 
// Fin #1	
*/
// #2
	If bCasto Then
		stMessage.sCode = "WDET390"
		F_Message ( stMessage )
	End If
End If

/*------------------------------------------------------------------*/
/* S'il y a refus ET que la PEC est cochée ETANT forcée, ALORS      */
/* MESS sans REFUS.                                                 */
/*------------------------------------------------------------------*/
If asPos = "" And bPriseEnChargeCoche And bForcagePriseEnChargeCoche Then

	If bAuMoinsUnRefus Then
		idw_wDetailFF.SetItem ( 1, "COD_DEC_MAC", 200 )
	End If		

	If bAuMoinsUnRefus And Not bChercheARegler Then
		idw_wDetailFF.SetItem ( 1, "COD_DEC_OPE", 100 )
		idw_wDetailFF.SetItem ( 1, "COD_ETAT", 100 )		
		idw_wDetailFF.SetItem ( 1, "ALT_ATT", "O" )		
	End If

// #2	
	If bChercheARegler then
		idw_wDetailFF.SetItem ( 1, "ALT_ATT", "N" )			
	End If

// #2 Information
	If bChercheARegler And Not bForcageReglement Then

		bShunt1 = False

		// [VDOC10608]
		If This.uf_GetAutorisation ( 208 ) Then
			idw_wDetailFF.SetItem ( 1, "ALT_REG", "O" )
			idw_wDetailFF.SetItem ( 1, "MT_PLAF", idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" ) )
			bShunt1 = True
		End If

		// [VDOC10608]
		If Not bShunt1 Then
			stMessage.sTitre		= "Contrôle de saisie du détail"
			stMessage.Icon			= Information!
			stMessage.Bouton		= OK!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "WDET530"
		
			f_Message ( stMessage )
		End If
	End If 


// #2
	If bCasto Then
		stMessage.sCode = "WDET400"
		F_Message ( stMessage )
	End IF
End If


If Not bAuMoinsUnRefus And bPriseEnChargeCoche And Not bChercheARegler And Not bDemSansSuite Then

	// #2
	If bGestPec Then

		If idw_wDetailFF.GetItemNumber ( 1, "COD_DEC_MAC" ) = 0 And &
			idw_wDetailFF.GetItemNumber ( 1, "COD_DEC_OPE" ) = 0 And &
			idw_wDetailFF.GetItemNumber ( 1, "COD_ETAT" ) = 0 Then

			idw_wDetailFF.SetItem ( 1, "COD_DEC_MAC", 100 )
			idw_wDetailFF.SetItem ( 1, "COD_DEC_OPE", 100 )
			idw_wDetailFF.SetItem ( 1, "COD_ETAT", 100 )		
		
			idw_wDetailFF.SetItem ( 1, "ALT_ATT", "O" )	
			asPos = ""
		End IF

	End If
End If


// #2 if bCasto
lRow = idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'ALT_PLAF_PEC'" , 1, idw_wDivDet.RowCount ())
If bCasto And lRow > 0 Then
	IF bAuMoinsUnPlafond Then
		sVal = "O"
	Else 		
		sVal = "N"
	End If
// #2
	This.uf_GestOng_Divers_MajZone ( "ALT_PLAF_PEC", lRow, sVal )

End If

// Uniquement si CASTO !
If bCasto Then
	If This.uf_GestOng_Divers_Trouver ("PEC" ) = "O" Then
		stMessage.sCode = "WDET420"
	Else
		stMessage.sCode = "WDET430"
	End If
	F_Message ( stMessage )	
End IF



end subroutine

private function integer uf_preparervalider_ongdivers ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerValider_OngDivers (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 04/10/2005
//* Libellé			: 
//* Commentaires	: Préparation de la validation de l'onglet Divers.
//*
//* Arguments		: 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long			 lNbrTotLig, lCptLig
String		 sCle
Long 			 lRow, lCpt, lTotRow


lTotRow = idw_wDivDet.RowCount ()

/*------------------------------------------------------------------*/
/* On supprime la zone 'X_TEMPO_X' ne servant à rien.               */
/*------------------------------------------------------------------*/
lRow = idw_wDivDet.Find ( "NOM_ZONE = 'X_TEMPO_X'", 1, lTotRow  )
If lRow > 0 Then idw_wDivDet.RowsDiscard ( lRow, lRow, Primary! )

lTotRow = idw_wDivDet.RowCount ()

/*------------------------------------------------------------------*/
/* On supprime toutes les zones créées qui n'ont pas été modifiée,  */
/* cela ne sert à rien de les intégrer en base.                     */
/*------------------------------------------------------------------*/
For lCpt = lTotRow To 1 Step -1
	Choose case idw_wDivDet.GetItemString ( lCpt, "ALT_SUPP" )
		Case "O"
			idw_wDivDet.RowsDiscard ( lCpt, lCpt, Primary! )
	End Choose 
Next

/*------------------------------------------------------------------*/
/* Pour toutes les lignes contenues dans le buffer Deleted! de      */
/* DwNivInf...                                                      */
/* Le compteur est à l'envers, car on Détruit des rows sur IdwRe-   */
/* questor dans Uf_CopierLigne												  */
/*------------------------------------------------------------------*/
lNbrTotLig = idw_wDivDet.DeletedCount () 

For lCptLig = lNbrTotLig To 1 Step -1

/*------------------------------------------------------------------*/
/* ...on construit la clé de chaque enregistrement contenus dans    */
/* le buffer Delete! de DwNivInf.                                   */
/*------------------------------------------------------------------*/
	sCle = "ID_GTI = " + String ( idw_wDivDet.GetItemNumber ( lCptLig, "ID_GTI", DELETE!, TRUE ) ) + " AND " + &
			 "ID_DETAIL = " + String ( idw_wDivDet.GetItemNumber ( lCptLig, "ID_DETAIL", DELETE!, TRUE ) ) + " AND " + &
			 "UPPER ( NOM_ZONE ) = '" + Upper ( idw_wDivDet.GetItemString ( lCptLig, "NOM_ZONE", DELETE!, TRUE ) ) + "'"

/*------------------------------------------------------------------*/
/* Avec cette ligne identifiée, on effectue le traitement           */
/* nécéssaire sur la DataWindow de niveau supérieur. Voir fonction  */
/* Uf_CopierLigne.                                                  */
/*------------------------------------------------------------------*/
	If This.Uf_CopierLigne_Inf2Sup ( "BD", lCptLig, sCle, idw_wDivDetGti, idw_wDivDet )	< 0  Then Return -1

Next

/*------------------------------------------------------------------*/
/* Pour toutes les lignes contenues dans le buffer Primary!         */
/* DwNivInf... (Le client a pu filtrer le buffer Primaire)          */
/*------------------------------------------------------------------*/
lNbrTotLig = idw_wDivDet.RowCount () 
For lCptLig = 1 To lNbrTotLig


/*------------------------------------------------------------------*/
/* ...on construit la clé de chaque enregistrement contenus dans    */
/* le buffer Primaire de DwNivInf.                                  */
/*------------------------------------------------------------------*/
	sCle = "ID_GTI = " + String ( idw_wDivDet.GetItemNumber ( lCptLig, "ID_GTI", PRIMARY!, TRUE ) ) + " AND " + &
			 "ID_DETAIL = " + String ( idw_wDivDet.GetItemNumber ( lCptLig, "ID_DETAIL", PRIMARY!, TRUE ) ) + " AND " + &
			 "UPPER ( NOM_ZONE ) = '" + Upper ( idw_wDivDet.GetItemString ( lCptLig, "NOM_ZONE", PRIMARY!, TRUE ) ) + "'"



	/*------------------------------------------------------------------*/
	/* Avec cette ligne identifiée, on effectue le traitement           */
	/* nécéssaire sur la DataWindow de niveau supérieur. Voir fonction  */
	/* Uf_CopierLigne.                                                  */
	/*------------------------------------------------------------------*/
	If This.Uf_CopierLigne_Inf2Sup ( "BP", lCptLig, sCle, idw_wDivDetGti, idw_wDivDet )	< 0   Then Return -1

Next


Return 1


end function

private function boolean uf_rf_697 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_697 (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 04/11/2005
//* Libellé			: 
//* Commentaires	: Refus CASTORAMA suite expertise
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF     19/10/2006 DCMP060693
//*       JFF     01/09/2011 [PC10][DIAG_NOMADE]
//*-----------------------------------------------------------------

Long lCodAction, lDeb, lFin, lRow, lIdGti, lIdDetail, lStatus
Boolean bRet
String sCas 

bRet	= True
sCas  = ""

lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
lIdDetail = idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" )

If sCas = "" Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 43 ) // CASTO
	If lDeb > 0 Then sCas = "CASTO"
End If

If sCas = "" Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 71 ) // MEDIA SATURN
	If lDeb > 0 Then sCas = "MEDIA_SATURN"
End If

// [PC10][DIAG_NOMADE]
If sCas = "" Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 46 ) // MOBISTORE
	If lDeb > 0 Then sCas = "MOBISTORE"
End If


If lDeb <= 0 and sCas = "" Then Return TRUE

Choose Case sCas
	Case "CASTO"
		lCodAction = Long ( This.uf_GestOng_Divers_Trouver ("COD_ACTION" ) )
		
		/*------------------------------------------------------------------*/
		/* Si un "refus suite expertise" est trouvé alors on coche.         */
		/*------------------------------------------------------------------*/
		If lCodAction = 55 Then
			bRet = Uf_RF_EcrireRefus ( 697 )
		End If 

	Case "MEDIA_SATURN", "MOBISTORE" // #1
	
		lRow = idw_LstCmdeSin.Find ( "ID_GTI = " + String ( lIdGti ) + " AND ID_DETAIL = " + String ( lIdDetail ), 1, idw_LstCmdeSin.Rowcount () )
		If lRow > 0 Then
			lStatus = idw_LstCmdeSin.GetItemNumber ( lRow, "STATUS_GC" )
			
			If lStatus = 72 Then
				// [PC10][DIAG_NOMADE]
				lRow = idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'PEC'" , 1, idw_wDivDet.RowCount ())
				If lRow > 0 Then
					This.uf_GestOng_Divers_MajZone ( "PEC", lRow, "N" )
				End If				
				// [PC10][DIAG_NOMADE]				
				
				bRet = Uf_RF_EcrireRefus ( 697 )
			End If
			
		End If
	
End Choose	
	
Return ( bRet )

end function

private function long uf_zn_altssui ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_AltSsui (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libellé			: 
//* Commentaires	: Controle de ALT_SSUI
//*
//* Arguments		: Aucun
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------

Long lTotLigne, lLigPce, lLigRef

stMessage.sTitre		= "Contrôle sur le détail"
stMessage.Icon			= Information!
stMessage.bErreurG	= False

/*------------------------------------------------------------------*/
/* On veut mettre la zone ALT_SSUI à OUI, on vérifie qu'il          */
/* n'existe pas de pièces ou de motifs cochés.                      */
/*------------------------------------------------------------------*/
If	idw_wDetailFF.GetText () = "O" Then

	lTotLigne = iuoTagPiece.dw_Trt.RowCount ()
	lLigPce = iuoTagPiece.dw_Trt.Find ( "ALT_RECLAME = 'O'", 1, lTotLigne )

	If	lLigPce = 0	Then
		lTotLigne = iuoTagRefus.dw_Trt.RowCount ()
		lLigRef = iuoTagRefus.dw_Trt.Find ( "ALT_OPE = 'O' Or ALT_MAC = 'O'", 1, lTotLigne )
		
		If	lLigRef = 0	Then
/*------------------------------------------------------------------*/
/* Il est impossible de mettre le dossier SANS SUITE si ALT_ATT     */
/* est positionné.                                                  */
/*------------------------------------------------------------------*/
			If			idw_wDetailFF.GetItemString ( 1, "ALT_ATT" ) = "O" Then
						stMessage.sCode = "WDET190"
						f_Message ( stMessage )

/*------------------------------------------------------------------*/
/* Il est impossible de mettre le dossier SANS SUITE si on force    */
/* le règlement. (ALT_REG = O).                                     */
/*------------------------------------------------------------------*/
			ElseIf	idw_wDetailFF.GetItemString ( 1, "ALT_REG" ) = "O" Then
						stMessage.sCode = "WDET200"
						f_Message ( stMessage )

			Else
				idw_wDetailFF.SetItem ( 1, "ALT_SSUI", "O" )

				idw_wDetailFF.SetItem ( 1, "COD_ETAT", 	900 )
				idw_wDetailFF.SetItem ( 1, "COD_DEC_MAC", 900 )
				idw_wDetailFF.SetItem ( 1, "COD_DEC_OPE", 900 )
			End If
		End If
	End If

	If	lLigPce > 0 Then
		stMessage.sVar[1]		= "La pièce N° " + String ( iuoTagPiece.dw_Trt.GetItemNumber ( lLigPce, "ID_PCE" ) ) + " est réclamée."
		stMessage.sCode		= "WDET120"
		
		f_Message ( stMessage )
	End If

	If	lLigRef > 0 Then
		stMessage.sVar[1]		= "Le refus N° " + String ( iuoTagRefus.dw_Trt.GetItemNumber ( lLigRef, "ID_MOTIF" ) ) + " est coché."
		stMessage.sCode		= "WDET120"

		f_Message ( stMessage )
	End If

/*------------------------------------------------------------------*/
/* On vient de mettre la zone Sans Suite à NON.                     */
/*------------------------------------------------------------------*/
Else
	idw_wDetailFF.SetItem ( 1, "ALT_SSUI", "N" )
	idw_wDetailFF.SetItem ( 1, "COD_MOT_SSUI", 0 )

	idw_wDetailFF.SetItem ( 1, "COD_ETAT", 	0 )
	idw_wDetailFF.SetItem ( 1, "COD_DEC_MAC", 0 )
	idw_wDetailFF.SetItem ( 1, "COD_DEC_OPE", 0 )
End If

//Migration PB8-WYNIWYG-03/2006 OR
//idw_wDetailFF.SetActionCode ( 2 )
Return 2
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_altreg ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_AltReg (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libellé			: 
//* Commentaires	: Controle de ALT_REG
//*
//* Arguments		: Aucun
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//* JFF	04/08/2015	[VDOC18256]
//*-----------------------------------------------------------------

Long lIdGti , lDeb, lFin
Date dDteAdh

/*------------------------------------------------------------------*/
/* On teste la valeur de ALT_REG. Si NON, on repositionne le        */
/* montant MT_PLAF à 0. Ensuite, on positionne les TabOrder.        */
/*------------------------------------------------------------------*/
If	idw_wDetailFF.GetText () = "O" Then
	If idw_wDetailFF.GetItemString ( 1, "ALT_SSUI" ) = "O" Then

		stMessage.sTitre		= "Contrôle sur le détail"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= False
		stMessage.sCode		= "WDET210"

		f_Message ( stMessage )		
	Else
		idw_wDetailFF.SetItem ( 1, "ALT_REG", "O" )
		
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 286 )
		lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
		dDteAdh = idw_wSin.GetItemDate ( 1, "DTE_ADH" )							
		
		If lDeb > 0 And lIdGti = 7 And dDteAdh >= 2014-10-20 Then 
			stMessage.sTitre		= "VDOC18256/C.Bellet"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= False
			stMessage.bouton		= YesNo!
			stMessage.sCode		= "V018256"
	
			If f_Message ( stMessage )	= 2 Then
				idw_wDetailFF.SetItem ( 1, "ALT_REG", "N" )
			End If

		End If
		
	End If
Else
	idw_wDetailFF.SetItem ( 1, "ALT_REG", "N" )
	idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0.00 )
End If

//Migration PB8-WYNIWYG-03/2006 OR
//idw_wDetailFF.SetActionCode ( 2 )
Uf_Tb_AltReg ()
Return 2
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_altatt ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_AltAtt (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libellé			: 
//* Commentaires	: Controle de ALT_ATT
//*
//* Arguments		: Aucun
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//Migration PB8-WYNIWYG-03/2006 OR
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

/*------------------------------------------------------------------*/
/* On veut mettre ALT_ATT à OUI, il faut vérifier si ALT_SSUI est   */
/* à NON.                                                           */
/*------------------------------------------------------------------*/

If	idw_wDetailFF.GetText () = "O" Then
	If	idw_wDetailFF.GetItemString ( 1, "ALT_SSUI" ) = "O"	Then
		stMessage.sTitre		= "Contrôle sur le détail"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= False
		stMessage.sCode		= "WDET130"
		
		f_Message ( stMessage )
//Migration PB8-WYNIWYG-03/2006 OR
//		idw_wDetailFF.SetActionCode ( 2 )
		ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 OR
	End If
End If

//Migration PB8-WYNIWYG-03/2006 OR
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_heudet ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_HeuDet (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libellé			: 
//* Commentaires	: Controle de HEU_DET
//*
//* Arguments		: Aucun
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------

String sVal
Integer iAction

sVal		= Trim ( idw_wDetailFF.GetText () )
iAction	= 2

If	sVal = "" Then
	sVal = stNul.str
Else
	If	Len ( sVal ) <> 4 Then
		idw_wDetailFF.iiErreur		= 1
		idw_wDetailFF.iiReset		= 0
		iAction						= 1
	Else
		If	Not IsTime ( Left ( sVal, 2 ) + ":" + Right ( sVal, 2 ) )	Then
			idw_wDetailFF.iiErreur = 2
			idw_wDetailFF.iiReset	= 0
			iAction				= 1
		End If
	End If
End If

If	iAction <> 1 Then
	idw_wDetailFF.SetItem ( 1, "HEU_DET", sVal )
End If

//Migration PB8-WYNIWYG-03/2006 OR
//idw_wDetailFF.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_numcarte ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_NumCarte (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libellé			: 
//* Commentaires	: Controle de NUM_CARTE
//*
//* Arguments		: Aucun
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//	FPI	14/02/2011	[VDoc3118] Ajout DP 163
//       JFF   20/01/2014 [PM208]
//*-----------------------------------------------------------------

Integer iAction

Long dcIdCarte, dcIdGrp, lIdProd, lNbAffilier, lIdEvt, lRet

String sNumCarte, sIdTypeCarte

Boolean bVerifCarte, bProc
//Migration PB8-WYNIWYG-03/2006 OR
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 OR
n_cst_string nvstring
String sValCar
Long lDeb, lFin

sIdTypeCarte	= Space ( 3 )
sNumCarte		= Trim ( idw_wDetailFF.GetText () )
iAction			= 2
bProc				= True

lIdProd			= idw_wSin.GetItemNumber ( 1, "ID_PROD" )

/*------------------------------------------------------------------*/
/* Le gestionnaire vient d'effacer le contenu de la zone. Gestion   */
/* du iiCarNul standard avec réinitialisation d'un certain nombre   */
/* de zones à la fin du script.                                     */
/*------------------------------------------------------------------*/
If	sNumCarte = ""	Then
	iAction = 1
Else
/*------------------------------------------------------------------*/
/* On vérifie le N° de carte.                                       */
/*------------------------------------------------------------------*/
	bVerifCarte = F_Carte ( sNumCarte, "111" )
/*------------------------------------------------------------------*/
/* On recherche le type de la carte ainsi que son l'identifiant.    */
/* Cette recherche va s'effectuer dans la table CARTE.              */
/*------------------------------------------------------------------*/
	itrTrans.PS_S01_CARTE_SINISTRE ( sNumCarte, lIdProd, dcIdCarte, sIdTypeCarte, dcIdGrp, lNbAffilier )

	If	Not F_Procedure ( stMessage, itrTrans, "PS_S01_CARTE_SINISTRE" )	Then
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée, on déclenche un ItemError.         */
/*------------------------------------------------------------------*/
		iAction 						= 1
		idw_wDetailFF.iiErreur	= 2
		bProc							= False
	End If

	lIdEvt = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )

	Choose Case lIdEvt
	Case 701, 702, 703, 704, 705, 712, 713, 714, 715
		If	bVerifCarte	= False Then
/*------------------------------------------------------------------*/
/* Il y a une erreur de saisie sur le N° de carte.                  */
/*------------------------------------------------------------------*/
			iAction 						= 1
			idw_wDetailFF.iiErreur	= 1
		Else
/*------------------------------------------------------------------*/
/* On vérifie si la carte est connue, si elle ne l'est pas, on      */
/* affiche non bloquant d'avertissement.                            */
/*------------------------------------------------------------------*/
			If	sIdTypeCarte = "   "	And bProc = True Then

				stMessage.sTitre		= "Contrôle sur le détail"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= False
				stMessage.bTrace		= False
				stMessage.sCode		= "WDET220"

				F_Message ( stMessage )		

				sIdTypeCarte 	= "00"
				dcIdCarte		= 0
			End If

			idw_wDetailFF.SetItem ( 1, "ID_CARTE", dcIdCarte )
			idw_wDetailFF.SetItem ( 1, "ID_TYPE_CARTE", sIdTypeCarte )
			
		End If

	Case 706, 707, 708, 709, 716, 717, 718, 719

	Case 701, 710, 711
		If	bVerifCarte	= False Then
/*------------------------------------------------------------------*/
/* Il y a une erreur de saisie sur le N° de carte.                  */
/*------------------------------------------------------------------*/
			iAction 						= 1
			idw_wDetailFF.iiErreur	= 1
		Else
/*------------------------------------------------------------------*/
/* On vérifie si la carte est connue, et que la valeur de ID_GRP    */
/* est bonne.                                                       */
/*------------------------------------------------------------------*/
			// [VDoc3118]
			lRet=0
			
			F_Rechdetpro(lDeb, lFin, idw_detpro, idw_wsin.GetItemNumber(1,"ID_PROD"),"-DP",163)
			If lDeb > 0 Then
				sValCar=idw_detpro.GetItemString( lDeb, "VAL_CAR")
				sValCar=nvstring.of_getkeyvalue( sValCar, "ID_CARTE", ";")
				sValCar="/" + sValCar + "/"
				lRet=Pos(sValCar,"/" + string(dcIdCarte) + "/")
			End if
			if lRet <=0 Then
			// :[VDoc3118]
				lRet = itrTrans.PS_S01_CARTE_UF ( lIdProd, dcIdGrp )
	
				If	Not F_Procedure ( stMessage, itrTrans, "PS_S01_CARTE_UF" )	Then
	/*------------------------------------------------------------------*/
	/* Il y a une erreur dans l'appel de la procédure, la structure     */
	/* stMessage vient d'être armée, on déclenche un ItemError.         */
	/*------------------------------------------------------------------*/
					iAction 						= 1
					idw_wDetailFF.iiErreur	= 2
				Else
					If	lRet = 0	Then
						iAction 						= 1
						idw_wDetailFF.iiErreur	= 4
					Else
						idw_wDetailFF.SetItem ( 1, "ID_CARTE", dcIdCarte )
						idw_wDetailFF.SetItem ( 1, "ID_TYPE_CARTE", sIdTypeCarte )
					End If
				End If
			// [VDoc3118]
			Else
				idw_wDetailFF.SetItem ( 1, "ID_CARTE", dcIdCarte )
				idw_wDetailFF.SetItem ( 1, "ID_TYPE_CARTE", sIdTypeCarte )
			End if
			// :[VDoc3118]
		End If
	End Choose
End If

//Migration PB8-WYNIWYG-03/2006 OR
//idw_wDetailFF.SetActionCode ( iAction )
ll_ret = iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR
/*------------------------------------------------------------------*/
/* Il est important de faire un ActionCode à 2. En effet la         */
/* fonction SetActionCode n'est pas immédiate. Il faut attendre la  */
/* fin de la fonction appelante.                                    */
/*------------------------------------------------------------------*/
If	iAction = 2 Then
	If	sNumCarte = "" Then SetNull ( sNumCarte )
	
 	// [PM208]
	sNumCarte = Left ( sNumCarte,6 ) + Fill ("X", Len ( sNumCarte ) - 10) + Right (sNumCarte, 4)
	
	idw_wDetailFF.SetItem ( 1, "NUM_CARTE", sNumCarte )
Else

/*------------------------------------------------------------------*/
/* Il vient d'y avoir une erreur. (N° de carte incorrecte, Erreur   */
/* de saisie, Erreur de procédure, Carte non couverte). On ne va    */
/* pas réinitialiser la valeur de ID_ADH avec la valeur précédente  */
/* selon le souhait de Denis. Il faut donc annuler les valeurs      */
/* précédentes pour ID_CARTE et ID_TYPE_CARTE.                      */
/*------------------------------------------------------------------*/

	idw_wDetailFF.SetItem ( 1, "ID_CARTE", 0 )
	lIdEvt = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )

	If	sNumCarte = ""	And ( ( lIdEvt >= 701 And lIdEvt <= 706 ) Or ( lIdEvt >= 710 And lIdEvt <= 715 ) ) Then
		idw_wDetailFF.SetItem ( 1, "ID_TYPE_CARTE", "00" )
	Else
		idw_wDetailFF.SetItem ( 1, "ID_TYPE_CARTE", stNul.str )
	End If

//Suite à la détection d'un problème. Je positionne ID_TYPE_CARTE à NULL.
End If
//Migration PB8-WYNIWYG-03/2006 OR
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR


end function

private function long uf_zn_idevt_telephonie ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_IdEvt_Telephonie (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 06/01/1998 09:27:01
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//* #2	 CAG	 29/01/2002  Annexe 22 : on ne pose la question ci-dessus
//*												  que si evt <> 845, et non compris entre 850 et 853 (inclus)
//* #3	 JFF   15/10/2003	 Les anciens EVT de replacement MUST ne doivent plus être choisis.
//* #4    MADM  17/07/2006  DCMP 060472 FNAC Suissse-Belgique permettre le règlement à 0 euros sur option 57
//* #5    JFF   04/06/2007  [DCMP070163-070164-070248-070318] Gestion Prise en charge
//* #6    JFF   25/03/2008  [DCMP080200]
//* #7    JFF   02/03/2010  [MSS_LOT2]
//			 FPI	 25/07/2011	 [VDoc4788] Evènement indit pour autre que facturation
//			 JFF   19/09/2012  [MANTIS4026]
// 		 JFF	 29/01/2013  [PC801_MANTIS6481]
// 		 FPI	 27/12/2013  [PC845][ITSM192266] Ajout de l'evt 1415
//			 FPI	 06/10/2014	 [PC13174]
//        JFF   28/09/2015  [PM319-1]
//        JFF   02/09/2019  [DT424]
//        JFF   23/03/2022  [RS1507_CONS_MAN]
//        JFF   20/12/2023  [RS6269_EVOL_CONFO]
//        JFF   05/08/2024  [MCO602_PNEU]
//        JFF   12/02/2025   [HUB875]
//*-----------------------------------------------------------------

Long	lNbreNouv, lTotCmdeDet, lSeqMax, lSeqMax1, lCpt, lIdEvt, lDeb, lFin, lRow, lIdEvtGetText, lIdEvtITem, lIdDetail 
Boolean	bContinuer, bCasto
Integer iAction
String sVal, sLibEvt
n_cst_string lnvPFCString

bContinuer = TRUE
iAction = 0
lIdEvtGetText = Long ( idw_wDetailFF.GetText () ) // [DT424]
lIdEvtITem = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) // [DT424]

/*---------------------------------------------------------------------------------------*/
/* #4 on lit le montant du préjudice : si dcMtPrej > o le champ zone à régler est visible*/
/*---------------------------------------------------------------------------------------*/
This.uf_Rendre_Visible_IdiReg (2)

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 43 )
bCasto = lDeb > 0

// #5
//If bCasto And iAction = 0 Then
If iAction = 0 Then	
	// ON ne touche à rien une fois la prise en charge cochée.
	If This.uf_GestOng_Divers_Trouver ("PEC" ) = "O" Then
		idw_wDetailFF.iiErreur = 3
		iAction = 1
		bContinuer = FALSE
	End If
End If

/*------------------------------------------------------------------*/
/* #3                                                               */
/*------------------------------------------------------------------*/
lIdEvt = Long ( idw_wDetailFF.GetText () )
If iAction = 0 Then
	Choose Case lIdEvt
		Case 	846, 847, 848, 849, 860
				idw_wDetailFF.iiErreur = 1
				iAction = 1
				bContinuer = FALSE

		//* #6  JFF    25/03/2008 [DCMP080200]
		Case 	1089, 1090, 1091, 1415, 1489 // [PC845][ITSM192266] Ajout de l'evt 1415 [MCO602_PNEU]
				If Not this.uf_GetAutorisation(208) Then
					idw_wDetailFF.iiErreur = 4
					iAction = 1
					bContinuer = FALSE
				End If
			
	End Choose
End If

// 	[VDoc4788]
If iAction=0 and (Not this.uf_GetAutorisation(208)) Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 181 )

	If lDeb > 0 Then
		For lCpt=lDeb to lFin
			if lIdEvt = idw_DetPro.GetItemNumber(lCpt,"ID_CODE_NUM") Then
				idw_wDetailFF.iiErreur = 4
				iAction = 1
				bContinuer = FALSE
			End if
		Next
	End if
		
End if
// :[VDoc4788]

/*------------------------------------------------------------------*/
/* Pour la gestion des commandes.                                   */
/*------------------------------------------------------------------*/
If ibAltCmde And iAction = 0 Then

	lNbreNouv = idw_InfoCmde.GetItemNumber ( 1, "NBRE_NOUV" )
	lNbreNouv += idw_InfoCmde.GetItemNumber ( 1, "NBRE_DET" )

	If lNbreNouv > 0 Then

/*------------------------------------------------------------------*/
/* JFF Le 06/11/2003 : Je n'utilise plus ce code, mais je le garde  */
/* pour le cas il je devrais                                        */
/* faire marche arrière si cela ne convient pas à la gestion.       */
/* ( COMD018 ancien message )													  */
/* DEBUT :                                                          */
/*------------------------------------------------------------------*/
/*
		stMessage.sTitre		= "Attention aux commandes !!"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "COMD062"

		If F_Message ( stMessage ) = 2 Then
				idw_wDetailFF.iiErreur = 0
				iAction = 1
				bContinuer = FALSE
		Else

			idw_InfoCmde.SetItem ( 1, "NBRE_DET", idw_InfoCmde.GetItemNumber ( 1, "NBRE_DET" ) - lNbreNouv )
			idw_InfoCmde.SetItem ( 1, "NBRE_NOUV", 0 )

			lSeqMax = Long ( idw_LstCmdeSin.Describe ( "Evaluate ( 'max (id_seq)', 0 )") )
			lSeqMax1 = Long ( idw_LstCmdeGti.Describe ( "Evaluate ( 'max (id_seq)', 0 )") )

			If lSeqMax1 > lSeqMax Then lSeqMax = lSeqMax1

			idw_LstCmdeDet.SetFilter ( "ID_SEQ > " + String ( lSeqMax ) )
			idw_LstCmdeDet.Filter ( )
			idw_LstCmdeDet.RowsDiscard ( 1, 	idw_LstCmdeDet.RowCount ( ), PRIMARY! )
			idw_LstCmdeDet.SetFilter ( "" )
			idw_LstCmdeDet.Filter ( )

			iAction = 2
		End If
*/
/*------------------------------------------------------------------*/
/* FIN                                                              */
/*------------------------------------------------------------------*/

	End If

/*------------------------------------------------------------------*/
/* Si l'utilisateur a répondu oui à la question "voulez-vous    	  */
/* continuer ?"																     */
/*------------------------------------------------------------------*/
/* #2 CAG 29/01/03																  */
/*------------------------------------------------------------------*/

	If iAction <> 1 And ilCodTel = 21 And idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) = 11 And bContinuer Then

		Choose Case lIdEvt
			Case 	845, 850, 851, 852, 853, 856, 857, 858, 859
	
				stMessage.sTitre		= "Gestion SFR"
				stMessage.Icon			= Question!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= YESNO!
				stMessage.sCode		= "SFRP075"

				If F_Message ( stMessage ) = 2 Then
					idw_wDetailFF.iiErreur = 0
					iAction = 1
					bContinuer = FALSE
				End If
		End Choose 

	End If
	
	// Afin de ne pas déclencher de message sur l'itemError
	stMessage.sCode		= ""
End If

// #7 [MSS_LOT2]
If iAction = 0 And lIdEvt = 1136 Then	
/*
	if ProfileString ( stGlb.sFichierIni, "DATE_MEP", "MSS_LOT2_NA219", "FALSE" ) <> "TRUE" Or &
		This.uf_GetAutorisation ( 219 ) Then
*/
		idw_wDetailFF.iiErreur = 5
		iAction = 1
		bContinuer = FALSE

End If
// #7 [MSS_LOT2]

//	[MANTIS4026]
sVal = "NON"

// [PC801_MANTIS6481]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 209 )
If lDeb > 0 Then
	sVal = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "DESOX_IPHONE", ";")
	If IsNull ( sVal ) Or Trim ( sVal ) = "" Then sVal = "NON"
End If
// [PC801_MANTIS6481]	

If sVal = "NON" And iAction = 0 And lIdEvt = 1377 And Pos ( Upper ( idw_Wsin.GetItemString ( 1, "MODL_PORT" ) ), "IPHONE" ) > 0 Then	
	idw_wDetailFF.iiErreur = 6
	iAction = 1
	bContinuer = FALSE
End If
//	:[MANTIS4026]

//	[PC13174]
If iAction=0 and lIdEvt=1419 Then
	lDeb=idw_wdivsin.Find("NOM_ZONE in ('int_ser_sup_150','interv_serrurier') and VAL_CAR='O'",1, idw_wdivsin.RowCount())
	If lDeb <=0 Then
		idw_wDetailFF.iiErreur = 7
		iAction = 1
	End if
End if

If iAction=0 and lIdEvt=1419 Then
	lDeb=idw_wdivsin.Find("NOM_ZONE='int_ser_sup_150' and VAL_CAR='O'",1, idw_wdivsin.RowCount())
	If lDeb > 0 Then
		idw_wdetailff.SetItem( 1, "MT_PREJ", 150.00 )
		This.uf_Rendre_Visible_Idireg ( 0 )
	End if
End if
//	:[PC13174]

// [PM319-1]
lRow = idw_wDivDet.Find ( "NOM_ZONE = 'val_pub_orange_utilisee' AND VAL_CAR = 'O'" , 1, idw_wDivDet.RowCount () )					
If lRow > 0 Then
	idw_wDetailFF.iiErreur = 8
	iAction = 1
End IF

// [DT424]
/*
If F_CLE_A_TRUE ( "DT424" ) Then
	If lIdEvtGetText = 1457 And ( lIdEvtITem <> lIdEvtGetText Or IsNUll ( lIdEvtITem  ) ) Then
		ibIdEvtInterditCreation	 = TRUE
	End If 	
End If
*/

// [RS1507]

// [RS1507_CONS_MAN]
Choose Case lIdEvt
	Case 1083, 1479, 1481
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 224 )
		If lDeb > 0 Then
			lRow=idw_wdivsin.Find("UPPER(NOM_ZONE)='TYPE_APP'",1, idw_wdivsin.RowCount())
			If lRow > 0 Then
				Choose Case idw_wdivsin.GetItemString(lRow,"VAL_CAR") 
					Case "MSF", "MAF"
						sVal = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_PEC_ACC", ";")
						If IsNumber ( sVal ) Then 
							If Dec ( sVal ) > 0 Then
								idw_wdetailff.SetItem( 1, "MT_VAL_ACHAT", dec ( sVal ) )
							End If 
						End If 
				End Choose 
			End If 
		End IF 
End Choose 


// [RS6269_EVOL_CONFO]
If F_CLE_A_TRUE ( "RS6269_EVOL_CONFO" ) Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 207 )
	If iAction = 0 And lDeb > 0 Then
		lIdDetail = idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) 
		
		// Si premier détail
		If lIdDetail = 0 Then 
			Choose Case lIdEvtGetText
				Case 1083, 1317
					idw_wDetailFF.iiErreur = 9
					iAction = 1
					
			End Choose
		End If 
	End If 
End If

// [HUB875]
If F_CLE_A_TRUE ( "HUB875" ) Then
	If iAction = 0 Then This.uf_affichage_dw_choix_action ( lIdEvtGetText )
End If


//Migration PB8-WYNIWYG-03/2006 OR
//idw_wDetailFF.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_dtefacture ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_zn_DteFacture (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 18/05/2005 17:14:39
//* Libellé			: 
//* Commentaires	: Controle de la date de facture fournisseur
//*
//* Arguments		: Aucun
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------

String sDte
//Migration PB8-WYNIWYG-03/2006 OR
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

sDte = Trim ( idw_wDetailFF.GetText () )

//If Not IsDate ( sDte ) Or Date ( sDte ) > Today () Then
If isnull(Datetime ( sDte )) Or Date ( sDte ) > Today () Then // [PI056]

	idw_wDetailFF.iiErreur = 1
//Migration PB8-WYNIWYG-03/2006 OR
//	idw_wDetailFF.SetActionCode ( 1 )
	ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 OR
End If 
//Migration PB8-WYNIWYG-03/2006 OR
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_idireg ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_IdIReg (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 18/05/2005 17:14:39
//* Libellé			: 
//* Commentaires	: Controle de ID_I_REG
//*
//* Arguments		: Aucun
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//* #1	JCA	25/09/2006	DCMP06652
//* #2	JFF	20/10/2008	[FNAC_PROD_ECH_TECH]
//* 		JFF   04/11/2010 [PC301].[LOT2]
//*			FPI	08/03/2011 [PC321] - Règlement à 0
//* 		JFF   09/05/2012 [PC302]
//*      JFF   02/07/2012 [PM103]
//		FPI	26/12/2013	[PC864_1] Mantis 8099 - règlement du détail à 0
//*-----------------------------------------------------------------

Int iAction
Long  lRow, lDeb, lFin, lTot, lCpt, lIdEvt
String sVal, sIdFour, sIdGti, sIdDetail, SNom, sTab []
Boolean bCasto
DataWindowChild dwChild

iAction = 0

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 43 )
bCasto = lDeb > 0

sVal = idw_wDetailFF.GetText () 

lRow = idw_LstInter.Find ( "ID_I = " + sVal, 1, idw_LstInter.RowCount () )

//Migration PB8-WYNIWYG-03/2006 OR
//If lRow <= 0 Then Return
//If idw_LstInter.GetItemString ( lRow, "COD_INTER" ) <> "F" Then Return
//If lRow <= 0 Then Return lRow
If lRow <= 0 Then Return 1
//Fin Migration PB8-WYNIWYG-03/2006 OR

// #1
choose case idw_LstInter.GetItemString ( lRow, "COD_INTER" )
	case "A"
		lRow = idw_LstCmdeDet.RowCount ()
		if lRow > 0 then
			iAction = 1
			idw_wDetailFF.iiErreur = 2

			// [PC301].[LOT2]			
			F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 152 )
			// [PC321]
			if lDeb <=0 Then 			
				F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 141 )
			End if

			// [PC302]			
			if lDeb <=0 Then 			
				F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 212 )
			End if
			
			// [PC864_1]			
			if lDeb <=0 Then 			
				F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 224 )
			End if
			
			If lDeb > 0 Then
				F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 57 )
				If lDeb > 0 Then
					For lCpt = lDeb To lFin
						If idw_DetPro.GetItemNumber ( lCpt, "VAL_NUM" ) = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) And &
						   idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) Then
							lRow = idw_LstCmdeDet.Find ( "ID_FOUR IN ('CAR', 'CMA') AND ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + &
													  " AND ID_DETAIL = " +  String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
													  " AND COD_ETAT = 'CNV'"  , 1 , idw_LstCmdeDet.RowCount () )
							If lRow > 0 then
								iAction = 0
								idw_wDetailFF.iiErreur = 0
							Else
								lRow = idw_LstCmdeSin.Find ( "ID_FOUR IN ('CAR', 'CMA') AND ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + &
													  " AND ID_DETAIL = " +  String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) ) + &
													  " AND COD_ETAT <> 'ANN'", 1 , idw_LstCmdeSin.RowCount () )
								If lRow > 0 then
									iAction = 0
									idw_wDetailFF.iiErreur = 0
								End If
													  
							End If
						End If
					Next
				End If
			End If
			// [PC301].[LOT2]			
			End if

		
	case "F"
		/*------------------------------------------------------------------*/
		/* Il faut avoir un rôle de facturation pour régler un fournisseur. */
		/*------------------------------------------------------------------*/
		If Not This.uf_GetAutorisation ( 208 ) And &
			Not gbModeReprise_223 &
		Then
			iAction = 1
			idw_wDetailFF.iiErreur = 1 
		End If

		If iAction = 0 And Not bCasto Then
			sIdFour = idw_LstInter.GetItemString ( lRow, "ID_FOUR" )
			sNom = idw_LstInter.GetItemString ( lRow, "NOM" ) //* #2 [FNAC_PROD_ECH_TECH]					
			sIdGti  = String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )
			sIdDetail = String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )

			//* #2 [FNAC_PROD_ECH_TECH]					
			sTab = {"FNC", "MDS", "DTY", "MVL"}
			lTot = UpperBound ( sTab )
			
			For lCpt = 1 To lTot
				If Pos ( sNom, "/" + sTab [lCpt] + "/" , 1 ) > 0 Then
					lRow = 1
					Exit
				End If
			Next
			//* :#2 [FNAC_PROD_ECH_TECH]
			
			//* #2 [FNAC_PROD_ECH_TECH]					
			If lRow <= 0 Then
			//* :#2 [FNAC_PROD_ECH_TECH]										
					lRow = idw_LstCmdeDet.Find ( "ID_FOUR = '" + sIdFour + "' AND ID_GTI = " + sIdGti + " AND ID_DETAIL = " + sIdDetail, 1 , idw_LstCmdeDet.RowCount () )					
			End If
		
			If lRow <= 0 Then
				stMessage.sTitre		= "Contrôle interlocuteur réglement"
				stMessage.Icon			= Exclamation!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= YesNo!
				stMessage.sCode		= "WDET250"
		
				If F_Message ( stMessage ) = 2 Then
					iAction = 1
				End If 
		
				stMessage.sCode		= ""
		
			End If 
		End If

	case else
		return 0
end choose		
// #1 - FIN

//idw_wDetailFF.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_numfacture ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_NumFacture  (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 25/05/2005
//* Libellé			: 
//* Commentaires	: Controle du NumFacture
//*
//* Arguments		: Aucun
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------

String sVal
//Migration PB8-WYNIWYG-03/2006 OR
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

sVal = idw_wDetailFF.GetText ()

If IsNull ( sVal ) Or sVal = "" Then
	idw_wDetailFF.iiErreur = 1
//Migration PB8-WYNIWYG-03/2006 OR
//	idw_wDetailFF.SetActionCode ( 1 )
	ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 OR
End If

//Migration PB8-WYNIWYG-03/2006 OR
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_trt_divdet_vallst (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_wdetail::Uf_Zn_Trt_DivDet_ValLst (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 04/10/2005
//* Libellé			: Contrôle de cohérence sur les valeurs de liste choisies et 
//*					  le nom de la zone d'affectation (uniquement dans l'onglet divers)
//* Commentaires	: 	
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

String				sFind, sNomZone
Long					lRow
DataWindowChild	dwChild
Integer				iAction

sFind = ""
iAction = 0

sNomZone = Upper ( idw_wDivDet.GetItemString ( alRow, "NOM_ZONE" ) )

If asNomCol = "VAL_LST_CAR" Then
	idw_wDivDet.GetChild ( "VAL_LST_CAR", dwChild )
Else
	idw_wDivDet.GetChild ( "VAL_LST_NBRE", dwChild )
End If 

If Not IsNull ( asData ) and asData <> "" Then

	If asNomCol = "VAL_LST_CAR" Then
		sFind = "ID_CODE = '" + asData + "' AND ALT_VISIBLE = 1 AND UPPER ( NOM_ZONE ) = '" + sNomZone + "'"
	Else
		sFind = "ID_CODE = " + asData + " AND ALT_VISIBLE = 1 AND UPPER ( NOM_ZONE ) = '" + sNomZone + "'"
	End If 

	lRow = dwChild.Find ( sFind, 1, dwChild.RowCount () )

	If lRow <= 0 Then
		idw_wDivDet.iiErreur = 1
		iAction = 1
	End If
End If

//Migration PB8-WYNIWYG-03/2006 OR
//idw_wDivDet.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_trt_divdet_marqapp (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_MarqApp (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 07/10/2005
//* Libellé			: Contrôle de la zone MarqApp
//* Commentaires	: 
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

Long lDeb, lFin
Integer iAction
String sAltAucun
iAction = 0
Boolean bCasto  // cas Castorama

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 43 )
bCasto = lDeb > 0

Choose Case TRUE
	Case bCasto

		// ON ne touche à rien une fois la prise en charge cochée.
		If This.uf_GestOng_Divers_Trouver ("PEC" ) = "O" Then
			idw_wDivDet.iiErreur = 2
			iAction = 1
		End If

		If iAction = 0 Then
			sAltAucun = This.uf_GestOng_Divers_Trouver ("AUCUNE_MARQ" )
			If sAltAucun = "O" Then
				idw_wDivDet.iiErreur = 1
				iAction = 1
			End If
		End If
	
	Case Else 

End Choose


//Migration PB8-WYNIWYG-03/2006 OR
//idw_wDivDet.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_trt_divdet_aucunemarq (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_AucuneMarq (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 07/10/2005
//* Libellé			: Contrôle de la zone AucuneMarq
//* Commentaires	: 
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

Long lDeb, lFin, lRow
Integer iAction
String sAltAucun
iAction = 0
Boolean bCasto  // cas Castorama

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 43 )
bCasto = lDeb > 0

Choose Case TRUE
	Case bCasto

		// ON ne touche à rien une fois la prise en charge cochée.
		If This.uf_GestOng_Divers_Trouver ("PEC" ) = "O" Then
			idw_wDivDet.iiErreur = 3
			iAction = 1
		End If

		If iAction = 0 Then
			lRow = idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'MARQ_APP'" , 1, idw_wDivDet.RowCount ())
			If lRow > 0 Then
				If asData = "O" Then 
					idw_wDivDet.SetItem ( lRow, "VAL_CAR", "<AUCUNE>" )
				Else 
					idw_wDivDet.SetItem ( lRow, "VAL_CAR", stNul.str )
				End If

				idw_wDivDet.SetItem ( lRow, "MAJ_LE", DateTime ( Today (), Now () ) )
				idw_wDivDet.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )
				idw_wDivDet.SetItem ( lRow, "ALT_SUPP", "N" )
			End If
		End If
	Case Else 

End Choose


//Migration PB8-WYNIWYG-03/2006 OR
//idw_wDivDet.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_trt_divdet_pec (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_Pec (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 07/10/2005
//* Libellé			: Contrôle de la zone Pec (Prise En Charge)
//* Commentaires	: 
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
//* #2	 JCA		26/10/2007	DCMP 70428 Memoriser les paragraphes de plafonds pour les utiliser dans l'appelant
//* #3    JFF    28/01/2008  [DCMP080028]
//* #4	 PHG	  03/03/2008  [SUISSE].LOT3 : Correction Affichage PEC
//* #5 	 JFF	  20/10/2008  [FNAC_PROD_ECH_TECH]
//* #6    JFF	  28/07/2009  [DCMP090427]
//*       JFF	  06/05/2010  [20100506164646807]
//*       JFF    21/12/2010  [PC301][VESTUSTE]
//*		 JFF    13/01/2010  [PC363].[10%]
//*       JFF    21/01/2011  [PC301].[V15_EVOL_VETUSTE]
//*       JFF    27/07/2011  [PLAF_REF]
//*       JFF    24/01/2012  [CONFO][CUISINE][PC680]
//*       JFF    07/05/2013  [PC938_ORANGE_V3]
//        JFF    13/11/2013  [PC13371_72]
//        JFF    20/02/2014  [VDOC13754]
//			 FPI	  18/06/2014  [VDoc145555]
//        JFF    29/01/2015  [PM280][MANTIS13511]
// 		 JFF    24/03/2016  [VDOC20382]
//        JFF    01/10/2018  [PM445-1]
//        JFF    24/06/2019  [PC192235]
//*-----------------------------------------------------------------

Long lDeb, lFin, lRow, lQte, lCodEtat, lIdGti, lCpt, lIdEvt, lIdRev, lLig, lIdDetail, lRow2
Long lIdProd, lFound, lTotWRefus, lCountDiv1, lCptDiv1, lIdDetailDiv1, lRowDiv1, LRowInsert, lIdGtiDiv1
Date dDteAchat, dDteSurv 
Integer iAction
String sAltAucun, sMarq, sModl, sIdTypCode, sIdCode, sMess, sMess2
String sFindString, sFiltreOrig
iAction = 0
Decimal {2} dcMtValAchat, dcMtPec, dcMtValPublique, dcMtVal, dcMtLu, dcMtMaxLu, dcMtPec1, dcMtPlaf, dcPctMtPecPrs
Boolean bCasto  // cas Castorama
Boolean bGestPec // #1
Boolean bValPubliqueOblig, bBitMap 
String  sRech // #1
u_DataWindow udwNull // #1
s_Plafond_Pec stPlafPec // #1
Integer 	iDurGtiGc, iVetuste
Long 		lRowDS
String 	sVal, sValCar
n_cst_string lnvPFCString
Long lTotDetail, lCptDet, lCodeRef, lIdEvt1 
Boolean bConfo, bValAchat, bDteAchat
String sCodeArticle, sLibArticle
Date dDteFinGtiArticle
Long lIdGrpt, lRowDet1, lCodeEtatDet, lMarquageCC
Boolean bSC2FoyerNomade // [PC192235]

// #2
string sTypParaVer[], sTempTypPlaf, sTempIdPara, sTempCptVer
integer i
Long lCptPlaf, lTotPlafond

SetNull ( udwNull )

// #1 
lIdProd = idw_wSin.GetItemNumber ( 1, "ID_PROD" )
lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
lIdEvt = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
lIdRev = idw_wSin.GetItemNumber ( 1, "ID_REV" )
lIdDetail = idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" )
bValAchat = TRUE
bDteAchat = TRUE

// #1
If IsNull ( lIdEvt ) Then
	idw_wDivDet.iiErreur = 13
	iAction = 1	
	Return iAction
End If

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 43 )
bCasto = lDeb > 0

// [CONFO][CUISINE][PC680]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 207 )
bConfo = lDeb > 0

// [PC301][VESTUSTE]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 152)

// [PC192235]
If lDeb <=0 Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 341)
	sVal= Upper ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";"))
	bSC2FoyerNomade = sVal = "FOYER_NOMADE"
	If Not bSC2FoyerNomade Then lDeb = 0
End IF

// [PC301][VESTUSTE] 
If lDeb > 0 And asData = "O" Then

	lRow2 = idw_wDivDet.Find ( "NOM_ZONE = 'calcul_vetuste'", 1, idw_wDivDet.Rowcount () ) 

	If lRow2 > 0 Then
		iAction = This.Uf_Zn_Trt_DivDet_CalculVetuste ( "O", asNomCol, lRow2)
		If iAction = 0 Then
			This.uf_GestOng_Divers_MajZone ( "CALCUL_VETUSTE", lRow2, "O" )
		End If
	End If
End If
// :[PC301][VESTUSTE]


//* #5 [FNAC_PROD_ECH_TECH]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 107 )
bValPubliqueOblig = lDeb > 0


// #1
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 86 )
bGestPEC = False
If lDeb > 0 Then
	For lCpt = lDeb To lFin
		If idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) = lIdGti Then
			bGestPEC = True
			Exit
		End If 
	Next
End IF

// #1 On gère Casto à l'ancienne méthode.
If Not bCasto And Not bGestPec Then
	idw_wDivDet.iiErreur = 12
	iAction = 1	
	Return iAction
End If

lCodEtat = idw_wDetailFF.GetItemNumber ( 1, "COD_ETAT" )

// #1
Choose Case lCodEtat
	Case 100, 0, 1, 200
		// Ok on peut cocher/décocher
	Case Else 
		idw_wDivDet.iiErreur = 10
		iAction = 1
		Return iAction		
end Choose 


// Partie commune 
// #1 (DCMP 070318 ) 
Choose Case asData 
	Case "O"
		For lCpt = 2 to 5
		
			Choose Case lCpt

				Case 2
					sIdTypCode = "+NS"  // Nature de sinistre
					sIdCode = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
					sMess = "La nature du sinistre"
					sMess2 = "couverte"
				Case 3
					sIdTypCode = "+TR"  // Territorialité
					sIdCode = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
					sMess = "La territorialité"
					sMess2 = "couverte"
				Case 4
					sIdTypCode = "+DT"  // Détail de sinistre
					sIdCode = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
					sMess = "Le détail de sinistre "					
					sMess2 = "couvert"
				Case 5
					sIdTypCode = "+EV"  // Evénement de garantie
					sIdCode = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )
					sMess = "L'événement du détail de garantie"
					sMess2 = "couvert"
	
			End Choose
		
			If IsNull ( sIdCode ) Then Continue
		
			sRech	=		"ID_REV = "			+ String ( lIdRev ) 		+ " AND " 	+ &
							"ID_GTI = "			+ String ( lIdGti )		+ " AND " 	+ &
							"ID_TYP_CODE = '"  + sIdTypCode 	+ "' AND " 	+ &
							"ID_CODE = "  + sIdCode + " AND " 	+ &
							"ALT_REG = 'N'"

			lLig = idw_Condition.Find ( sRech, 1, idw_Condition.RowCount () )
		
			If	lLig > 0 Then
			
				idw_wDivDet.iiErreur = 14
				stMessage.sVar [1] = sMess
				stMessage.sVar [2] = sMess2				
				iAction = 1	
				Return iAction
			Else

				sRech	=		"ID_REV = "			+ String ( lIdRev ) 		+ " AND " 	+ &
								"ID_GTI = "			+ String ( lIdGti )		+ " AND " 	+ &
								"ID_TYP_CODE = '"  + sIdTypCode 	+ "' AND " 	+ &
								"ID_CODE = "  + sIdCode 
	
				lLig = idw_Condition.Find ( sRech, 1, idw_Condition.RowCount () )
			
				If	lLig <= 0 Then
				
					idw_wDivDet.iiErreur = 20
					stMessage.sVar [1] = sMess
					stMessage.sVar [2] = sMess2				
					iAction = 1	
					Return iAction
				End If				
			End If
		Next

		dcMtValAchat = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" )
		If IsNull ( dcMtValAchat ) Then dcMtValAchat = 0		

	  // [CONFO][CUISINE][PC680]
	  Choose Case True
			Case bConfo And asData = "O"
				Choose Case lIdEvt
					Case 1317, 1083, 934
						bValAchat = FALSE
						bDteAchat = FALSE
				End CHoose
		End CHoose

		// [PC13174]
		if lIdEvt=1421  Then 
			bDteAchat=FALSE
			bValAchat=FALSE
		End if
		// :[PC13174]
		
		If dcMtValAchat = 0 And iAction = 0 And bValAchat Then
			idw_wDivDet.iiErreur = 18
			iAction = 1
		End If


// #3
//* #5 [FNAC_PROD_ECH_TECH] (test sur bValPubliqueOblig )
		If bValPubliqueOblig  Then
			dcMtValPublique = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_PUBLIQUE" )
			If IsNull ( dcMtValPublique ) Then dcMtValPublique = 0		
	
			If dcMtValPublique = 0 And iAction = 0 Then
				idw_wDivDet.iiErreur = 21
				iAction = 1
			End If
		End If
// :#3

		sFindString = 	" ID_PROD = " + string(lIdProd) + &
							" AND ID_TYP_CODE_DP = '-DP' AND ID_CODE_DP = 42 " + &
							" AND ID_CODE_NUM = " + string (lIdGti) + &
							" AND ID_CODE_CAR = 'A'"

		lFound = idw_DetPro.Find(sFindString, 1, idw_DetPro.rowCount() )

		If lfound > 0 then
			dDteAchat = idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" )
		Else
			dDteAchat = Date(idw_wSin.GetItemDateTime ( 1, "DTE_ACH_PORT" ) ) // [PI056]
		End If

		If dDteAchat = 1900-01-01 Then SetNull ( dDteAchat )

		If iAction = 0 And IsNull ( dDteAchat ) And bDteAchat Then
			If lFound > 0 Then 
				idw_wDivDet.iiErreur = 5
			Else
				idw_wDivDet.iiErreur = 19
			End If 
			iAction = 1
		End If

		// [20100506164646807]
		If Not uf_GarantieRevision () Then
			idw_wDivDet.iiErreur = 23
			iAction = 1
		End If
		// [20100506164646807]



	Case "N"

		lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'PEC'", 1, idw_wDivDet.RowCount () )
		If lRow > 0 Then
			If idw_wDivDet.GetItemString ( lRow, "VAL_CAR", Primary!, TRUE ) = "O" And &
			   idw_wDivDet.GetItemNumber ( lRow, "CPT_VALIDE" ) > 0 Then
				idw_wDivDet.iiErreur = 16
				iAction = 1
				Return iAction
			End If
		End If

		If This.uf_GestOng_Divers_Trouver ("ALT_PEC" ) = "O" Then
			idw_wDivDet.iiErreur = 9
			iAction = 1
			Return iAction			
		End If
		
		If This.uf_Deja_Une_Commande () Then
			idw_wDivDet.iiErreur = 17
			iAction = 1
			Return iAction			
		End If			

		// [CONFO][MEUBLE][PC542]
		If Long ( This.uf_GestOng_Divers_Trouver ("PRIS_PRESTA_BLCODE" ) ) > 1 Then
			idw_wDivDet.iiErreur = 38
			iAction = 1
			Return iAction			
		End If

End Choose


// Casto
Choose Case TRUE
	Case bCasto And asData = "O"

		dcMtValAchat = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" )
		If IsNull ( dcMtValAchat ) Then dcMtValAchat = 0
		lQte = Long ( This.uf_GestOng_Divers_Trouver ("QTE" ) )
		dDteAchat = idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" )
		If dDteAchat = 1900-01-01 Then SetNull ( dDteAchat )
		sMarq = This.uf_GestOng_Divers_Trouver ("MARQ_APP" )
		sModl = This.uf_GestOng_Divers_Trouver ("MODL_APP" )

		If dcMtValAchat = 0 And iAction = 0 Then
			idw_wDivDet.iiErreur = 1
			iAction = 1
		End If

		If lQte <= 0 And iAction = 0 Then
			idw_wDivDet.iiErreur = 2
			iAction = 1
		End If

		If iAction = 0 And IsNull ( sMarq ) Or Trim ( sMarq ) = "" Or IsNull ( sModl ) Or Trim ( sModl ) = "" Then
			idw_wDivDet.iiErreur = 4
			iAction = 1
		End If

		If iAction = 0 And IsNull ( dDteAchat ) Then
			idw_wDivDet.iiErreur = 5
			iAction = 1
		End If


	Case bCasto And asData = "N"

		lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'PEC'", 1, idw_wDivDet.RowCount () )
		If idw_wDivDet.GetItemString ( lRow, "VAL_CAR", Primary!, TRUE ) = "O" And &
			idw_wDivDet.GetItemNumber ( lRow, "CPT_VALIDE" ) > 0 Then
			idw_wDivDet.iiErreur = 6
			iAction = 1
			Return iAction
		End If

		If This.uf_GestOng_Divers_Trouver ("ALT_PEC" ) = "O" Then
			idw_wDivDet.iiErreur = 9
			iAction = 1
			Return iAction			
		End If

   // [CONFO][CUISINE][PC680]
	Case bConfo And asData = "O"
		
		lQte = Long ( This.uf_GestOng_Divers_Trouver ("QTE" ) )
		sCodeArticle = This.uf_GestOng_Divers_Trouver ("CODE_ARTICLE" )
		sLibArticle = This.uf_GestOng_Divers_Trouver ("LIB_ARTICLE" )
		dDteFinGtiArticle = Date ( This.uf_GestOng_Divers_Trouver ("DTE_FIN_GTI_ARTICLE" ))
		lIdGrpt = Long ( This.uf_GestOng_Divers_Trouver ("CODE_RGPR_ELEMENT" ) )

		Choose Case lIdEvt
			Case 1317, 1083
				idw_wDetailFF.SetItem ( 1, "MT_VAL_ACHAT", 0 )						
				idw_wDetailFF.SetItem ( 1, "DTE_DET_DATE", stNul.dat )
				
				If iAction = 0 And Not IsNull ( lQte ) And lQte <> 0 Then
					idw_wDivDet.iiErreur = 32
					iAction = 1
				End If
				
				If iAction = 0 And ( Len ( sCodeArticle ) > 0 And Not IsNull ( sCodeArticle ))  Then
					idw_wDivDet.iiErreur = 33
					iAction = 1		
				End If
		
				If iAction = 0 And ( Len ( sLibArticle ) > 0 And Not IsNull ( sLibArticle )) Then
					idw_wDivDet.iiErreur = 34
					iAction = 1		
				End IF
		
				If iAction = 0 And ( Not IsNull ( dDteFinGtiArticle ) And dDteFinGtiArticle <> 1900-01-01 ) Then
					idw_wDivDet.iiErreur = 35
					iAction = 1		
				End IF
		
				If iAction = 0 And ( Not IsNull ( lIdGrpt ) And lIdGrpt > 0 ) Then
					idw_wDivDet.iiErreur = 36
					iAction = 1		
				End IF

				If iAction = 0 Then
					// On ne lit pas la valeur d'achat, mais on fait la somme des MT_PEC des autres détail.
					// dcMtPec = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" )
					dcMtPec = 0

					// [CONFO][NV_PROCESS]
					idw_wDivDetGti.SetFilter ( &
					"ID_GTI = " + String ( lIdGti ) + " AND " + &
					"UPPER ( NOM_ZONE ) IN ( 'MT_PEC', 'ALT_PEC', 'REMPL_CARTE_CADEAU')" )

					idw_wDivDetGti.Filter ()

					lCountDiv1 = idw_wDivDetGti.RowCount()
					lMarquageCC = Long ( String ( Day ( Today () ) ) + String ( Hour ( Now () ) ) + String ( Minute ( Now () ) ) + String ( Second ( Now () ) ) )
					
					For lCptDiv1 = 1 To lCountDiv1 
						If Upper ( idw_wDivDetGti.GetItemString ( lCptDiv1, "NOM_ZONE" ) ) <> "MT_PEC" Then Continue
						
						dcMtPec1 = idw_wDivDetGti.GetItemDecimal ( lCptDiv1, "VAL_MT" )  // En prévision...
						If IsNull ( dcMtPec1 ) Then dcMtPec1 = 0
						If dcMtPec1 <= 0 Then continue
						
						lIdDetailDiv1 = idw_wDivDetGti.GetItemNumber ( lCptDiv1, "ID_DETAIL" )
						lIdGtiDiv1 = idw_wDivDetGti.GetItemNumber ( lCptDiv1, "ID_GTI" )
						
						lRowDiv1 = idw_wDivDetGti.Find ( &
							"ID_GTI = " + String ( lIdGti ) + " AND " + &
							"ID_DETAIL = " + String ( lIdDetailDiv1 ) + " AND " + &
							"UPPER ( NOM_ZONE ) = 'REMPL_CARTE_CADEAU' " + " AND " + &
							"VAL_NBRE > 1" &
							, 1, lCountDiv1 )
													
						If lRowDiv1 > 0 Then
							Continue // Déjà pris sur une carte Cadeau
						End If
						
						lRowDet1 = idw_LstDetail.Find ( &
							"ID_GTI = " + String ( lIdGti ) + " AND " + &
							"ID_DETAIL = " + String ( lIdDetailDiv1 ) &
							, 1, idw_LstDetail.Rowcount () )
						
						lIdEvt1 = idw_LstDetail.GetItemNumber ( lRowDet1, "ID_EVT" )
						Choose Case lIdEvt1 
							Case 1317, 1083
								continue
						End Choose
						
						lCodeEtatDet = idw_LstDetail.GetItemNumber ( lRowDet1, "COD_ETAT" )
						Choose Case lCodeEtatDet 
							Case 100
								// Ok on prend
							Case 200
								lRowDiv1 = idw_wDivDetGti.Find ( &
								"ID_GTI = " + String ( lIdGti ) + " AND " + &
								"ID_DETAIL = " + String ( lIdDetailDiv1 ) + " AND " + &
								"UPPER ( NOM_ZONE ) = 'ALT_PEC' " + " AND " + &
								"VAL_CAR = 'O'" &
								, 1, lCountDiv1 )
								
								If lRowDiv1 <=0 Then
									Continue // Refusé sans force, on passe.
								End If
							Case 500, 600, 900, 0
								Continue // On passe
								
						End Choose
							
						lRowDiv1 = idw_wDivDetGti.Find ( &
							"ID_GTI = " + String ( lIdGti ) + " AND " + &
							"ID_DETAIL = " + String ( lIdDetailDiv1 ) + " AND " + &
							"UPPER ( NOM_ZONE ) = 'MT_PEC'"&
							, 1, lCountDiv1 )	
						
						dcMtPec1 = idw_wDivDetGti.GetItemDecimal ( lRowDiv1, "VAL_MT" )
						
						If dcMtPec1 <= 0 Then Continue
						
						
						// ON prend le mt_Pec 
						dcMtPec += dcMtPec1

						// Marquage
						lRowDiv1 = idw_wDivDetGti.Find ( &
							"ID_GTI = " + String ( lIdGti ) + " AND " + &
							"ID_DETAIL = " + String ( lIdDetailDiv1 ) + " AND " + &
							"UPPER ( NOM_ZONE ) = 'REMPL_CARTE_CADEAU' " &
							, 1, lCountDiv1 )
						
						If lIdEvt = 1317 Then
							idw_wDivDetGti.SetItem ( lRowDiv1, "VAL_NBRE", lMarquageCC ) // Marqué
							idw_LstDetail.SetItem ( lRowDet1, "COD_ETAT", 600 ) // mis comme réglé
							idw_LstDetail.SetItem ( lRowDet1, "ALT_ATT", "N" ) // mis comme réglé
						End If
					Next

					If dcMtPec <= 0 Then
						idw_wDivDet.iiErreur = 37
						iAction = 1		
					Else
						idw_wDetailFF.SetItem ( 1, "MT_VAL_ACHAT", dcMtPec )
						
						If lIdEvt = 1317 Then
							lRow2 = idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'REMPL_CARTE_CADEAU'", 1, idw_wDivDet.Rowcount () ) 
							If lRow2 > 0 Then
								This.uf_GestOng_Divers_MajZone ( "REMPL_CARTE_CADEAU", lRow2, lMarquageCC )
							End If
						End If
						
						ibCochageCCConfoEncours = TRUE // [CONFO][CUISINE][PC680]
						ibDeCochageCCConfoEncours = False
					End IF
					
					idw_wDivDetGti.SetFilter ( "" )
					idw_wDivDetGti.Filter ( )			

					
				End If				
				
				
			Case Else
				
				Choose Case lIdEvt
					Case 934

						sFiltreOrig = idwDetailSin.Describe ( "datawindow.table.filter" )
						If sFiltreOrig = "?" Then sFiltreOrig = ""

						idwDetailSin.SetFilter ( "" )
						idwDetailSin.Filter ()
						
						lRow = idwDetailSin.Find ( "ID_GTI <> 51 AND COD_ETAT = 600", 1, idwDetailSin.RowCount ()) 
						If lRow <= 0 Then
							idw_wDivDet.iiErreur = 39
							iAction = 1
						End If 

						idwDetailSin.SetFilter ( sFiltreOrig )
						idwDetailSin.Filter ()
						idwDetailSin.Sort ()

				
					Case Else
						// Zones obligatoires
						If iAction = 0 And lQte <= 0 Then
							idw_wDivDet.iiErreur = 2
							iAction = 1
						End If
						
						If iAction = 0 And ( Len ( sCodeArticle ) = 0 Or IsNull ( sCodeArticle ))  Then
							idw_wDivDet.iiErreur = 28
							iAction = 1		
						End If
				
						If iAction = 0 And ( Len ( sLibArticle ) = 0 Or IsNull ( sLibArticle )) Then
							idw_wDivDet.iiErreur = 29
							iAction = 1		
						End IF
				
						If iAction = 0 And ( IsNull ( dDteFinGtiArticle ) Or dDteFinGtiArticle = 1900-01-01 ) Then
							idw_wDivDet.iiErreur = 30
							iAction = 1		
						End IF
				
						If iAction = 0 And ( IsNull ( lIdGrpt ) Or lIdGrpt <= 0 ) Then
							idw_wDivDet.iiErreur = 31
							iAction = 1		
						End IF

				End Choose
					
		End Choose
		

	Case bConfo And asData = "N"

		Choose Case lIdEvt
			Case 1317, 1083

				Choose Case lIdEvt 
					Case 1317 
						sVal = This.uf_GestOng_Divers_Trouver ("REMPL_CARTE_CADEAU" )
					Case 1083 
						sVal = This.uf_GestOng_Divers_Trouver ("PRIS_PRESTA_BLCODE" )
				End Choose

				idw_wDivDetGti.SetFilter ( &
					"ID_GTI = " + String ( lIdGti ) + " AND " + &
					"UPPER ( NOM_ZONE ) = 'REMPL_CARTE_CADEAU' " + " AND " + &
					"VAL_NBRE = " + sVal )
				idw_wDivDetGti.Filter ()

				lCountDiv1 = idw_wDivDetGti.RowCount()
				For lCptDiv1 = 1 To lCountDiv1 
					
					idw_wDivDetGti.SetItem ( lCptDiv1, "VAL_NBRE", 0 ) // Marqué
					lIdDetailDiv1 = idw_wDivDetGti.GetItemNumber ( lCptDiv1, "ID_DETAIL" )
					
					lRowDet1 = idw_LstDetail.Find ( &
						"ID_GTI = " + String ( lIdGti ) + " AND " + &
						"ID_DETAIL = " + String ( lIdDetailDiv1 ) &
						, 1, idw_LstDetail.Rowcount () )
					
					If lIdEvt = 1317 Then
						idw_LstDetail.SetItem ( lRowDet1, "COD_ETAT", 0 ) // mis comme réglé
					End If
				Next

				idw_wDivDetGti.SetFilter ( "" )
				idw_wDivDetGti.Filter ()
				
				ibCochageCCConfoEncours = FALSE // [CONFO][CUISINE][PC680]
				If ibCocheALentreeCCConfo Then ibDeCochageCCConfoEncours = True


		End CHoose

	Case Else 

End Choose

// #1 Calcul et détermination des zones liés à la PEC
// Option 86 uniquement
If Not bCasto And bGestPEC And iAction = 0 Then
	If asData = "O" Then
	
		//* F_Plafond_Pec 
		//* Retourne		: Structure s_plafond_pec (0 indique qu'il n'y a pas de plafond)
		//*					  Pour le type Autre, le retour est sous cette forme
		//*					  O[704][3]    => OUI, plaf 704, x3 (en cours + autre)
		//*					  N[704][1]		=> NON, plaf 704, x1 ( juste l'en cours)

		//	 [PC363].[10%]
		lRow = idw_LstCmdeSin.Find ( "COD_ETAT <> 'ANN' AND POS ( INFO_FRN_SPB_CPLT, 'APP_INCOMPLET=OUI', 1) >0", 1, idw_LstCmdeSin.RowCount () )
		sVal = "[###]"

		If lRow > 0 Then
			lnvPFCString.of_Setkeyvalue ( sVal, "APP_INCOMPLET", "OUI", ";")
		End If

		// [PC301].[V15_EVOL_VETUSTE]
		lTotDetail = idw_wDetailFF.iudwDetailSource.RowCount ()
		dcMtLu = 0
		dcMtMaxLu = 0
		For lCptDet = 1 To lTotDetail	
			
			sRech	=		"ID_GTI = "	+ String ( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCptDet, "ID_GTI" ) )	+ " AND " 	+ &
							"ID_DETAIL = "	+ String ( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCptDet, "ID_DETAIL" ) )	+ " AND " 	+ &
							"UPPER ( NOM_ZONE ) = 'MT_MAX_PROPO_PLF722'"
				
			lRow = idw_wDivDetGti.Find ( sRech, 1, idw_wDivDetGti.RowCount () ) 
			If lRow > 0 Then
				dcMtLu = idw_wDivDetGti.GetItemDecimal ( lRow, "VAL_MT" )
				If dcMtLu > dcMtMaxLu Then
					dcMtMaxLu = dcMtLu 
				End If
			End If					
			
		Next

		If dcMtMaxLu > 0 Then
			lnvPFCString.of_Setkeyvalue ( sVal, "MT_MAX_PLAF_722", String ( dcMtMaxLu ), ";")
		End If
		// [PC301].[V15_EVOL_VETUSTE]

		stPlafPec = F_Plafond_Pec ( "3" + sVal , idw_wSin, idw_wDivSin, udwNull, idw_wDetailFF, udwNull, idw_Plafond, idw_DetPro, idw_produit, idw_wDivDet, lIdGti, lIdDetail )
		//	 [PC363].[10%]

		dcMtPec = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" )		
		
		If ( dcMtPec > stPlafPec.dcPlafEvt And stPlafPec.dcPlafEvt > 0 ) Or dcMtPec <= 0 Then dcMtPec = stPlafPec.dcPlafEvt
		If ( dcMtPec > stPlafPec.dcPlafValAch And stPlafPec.dcPlafValAch > 0 ) Or dcMtPec <= 0 Then dcMtPec = stPlafPec.dcPlafValAch
		If ( dcMtPec > stPlafPec.dcPlafGti  And stPlafPec.dcPlafGti  > 0 ) Or dcMtPec <= 0 Then dcMtPec = stPlafPec.dcPlafGti  
		If ( dcMtPec > stPlafPec.dcPlafValPublique And stPlafPec.dcPlafValPublique > 0 ) Or dcMtPec <= 0 Then dcMtPec = stPlafPec.dcPlafValPublique
		If Left ( stPlafPec.sPlafAutre, 1 ) = "O" Then dcMtPec = 0 

		If IsNull ( dcMtPec ) Then dcMtPec = 0
		
		// [VDOC20382]
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 266 )
		If lDeb > 0 And lIdEvt = 937 Then
			sVal = lnvPFCString.of_Getkeyvalue( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "PCT_MT_PEC_PRS", ";" ) 
			If Not IsNumber ( sVal ) Then 
				dcPctMtPecPrs = 0
			Else
				dcPctMtPecPrs = Dec ( sVal )
			End If
			
			If dcPctMtPecPrs > 0 Then
				dcMtPec *= dcPctMtPecPrs 
			End If
		End If
		
		// [PLAF_REF]
		If ( dcMtPec <= 0 Or dcMtPec = 0.01 ) Then 
			dcMtPec = 0 

			F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 183 )
			If lDeb > 0 And dcMtPec = 0 Then
				f_decomposerchaine (stPlafPec.stypparaver, ";", sTypParaVer[])
				for i = 1 to UpperBound(sTypParaVer)
					if sTypParaVer[i] <> "" then
						sTempTypPlaf = left (left (sTypParaVer[i], 8), 4)
						sTempIdPara  = right (left (sTypParaVer[i], 8), 4)
						sTempCptVer  = right (sTypParaVer[i], 3)
						
						For lCpt = lDeb To lFin
							If Long ( idw_DetPro.GetItemString ( lCpt, "ID_CODE_CAR" ) ) = Long ( sTempTypPlaf ) Then
								sValCar = idw_DetPro.GetItemString ( lCpt, "VAL_CAR" )
								lCodeRef = Long ( lnvPFCString.of_getkeyvalue( sValCar, "REF_EVT", ";"))

								// Evol
								If Long ( lnvPFCString.of_getkeyvalue( sValCar, "REF_GTI", ";")) > 0 And lCodeRef = 0 Then
									Continue
								End if
							
								If Not Uf_RF_EcrireRefus ( lCodeRef ) Then
									iAction = 1
									Return iAction		
								End If
								
							End If 
						Next
					end if
				next
				
				lTotwRefus = iuoTagRefus.dw_Trt.RowCount ()
				For	lCpt = 1 To lTotwRefus
						If	( iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_OPE" ) = "O" Or iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_MAC" ) = "O" ) Then
							bBitMap = True
							If	IsNull ( iuoTagRefus.dw_Trt.GetItemNumber ( lCpt, "ID_I" ) ) Then
								// [VDOC13754]
								If Not This.uf_GetAutorisation ( 208 ) Then
									stMessage.sCode		= "WGAR100"
									F_Message ( stMessage )
								End If
								
								Exit
							End If
						End If
				Next

				If	bBitMap	Then
					iuoOng.Uf_ChangerBitmap ( "03", "K:\PB4OBJ\BMP\8_REF.BMP" )
				Else
					iuoOng.Uf_ChangerBitmap ( "03", "" )
				End If
				
			End If
		End IF
		// [PLAF_REF]

		// #2

		// JFF (#2)
		lTotPlafond = idw_wPlaf_Detail.RowCount ()
		For lCptPlaf = 1 To lTotPlafond
			idw_wPlaf_Detail.SetItem ( lCptPlaf, "ALT_BOUGE", "S" )
		Next		
		// JFF (:#2)
		
		if stPlafPec.stypparaver <> "" then
			f_decomposerchaine (stPlafPec.stypparaver, ";", sTypParaVer[])
			for i = 1 to UpperBound(sTypParaVer)
				if sTypParaVer[i] <> "" then
					sTempTypPlaf = left (left (sTypParaVer[i], 8), 4)
					sTempIdPara  = right (left (sTypParaVer[i], 8), 4)
					sTempCptVer  = right (sTypParaVer[i], 3)
					
					Uf_Plaf_EcrirePara ( sTempTypPlaf, sTempIdPara, sTempCptVer )
				end if
			next
		end if
		// FIN - #2

		lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'MT_PEC'", 1, idw_wDivDet.RowCount () )
		If lRow > 0 Then
			
			// [PC938_ORANGE_V3][MANTIS7583]
			// [PM280][MANTIS13511] 1422
			// [PM445-1]
			// [PC874_2_V1]
			Choose Case lIdEvt
				Case 1396, 1398, 1422, 1439, 1451
					This.uf_GestOng_Divers_MajZone ( "MT_PEC", lRow, 0 )
				Case Else

					This.uf_GestOng_Divers_MajZone ( "MT_PEC", lRow, dcMtPec )
					// [PC13371_71]
					F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 226 )
					If lDeb > 0 Then
						sValCar = lnvPFCString.of_getkeyvalue( Upper ( Trim ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ) ) ), "MT_PLAF", ";")
						If len ( Trim ( sValCar ) ) > 0 And IsNumber ( sValCar ) Then
							dcMtPlaf = Dec ( sValCar )
							If dcMtPec = dcMtPlaf Then
								sValCar = lnvPFCString.of_getkeyvalue( Upper ( Trim ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ) ) ), "SI_MT_PLAF", ";")
								
								lRow = idw_wdivsin.Find ("UPPER(NOM_ZONE)='TYPAPP_REC_NEU'",1, idw_wdivsin.RowCount())
								If lRow > 0 And Len ( Trim ( sValCar )) > 0 Then
									idw_wdivsin.SetItem ( lRow, "VAL_LST_CAR", sValCar )
								End If
							End If
						End If
					End IF
			End Choose
		Else
			idw_wDivDet.iiErreur = 15
			stMessage.sVar [1] = "MT_PEC"
			iAction = 1
			Return iAction
		End If
	
		lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'DTE_PEC'", 1, idw_wDivDet.RowCount () )
		If lRow > 0 Then
			This.uf_GestOng_Divers_MajZone ( "DTE_PEC", lRow, Today() )
		Else
			idw_wDivDet.iiErreur = 15
			stMessage.sVar [1] = "DTE_PEC"
			iAction = 1
			Return iAction
		End If
		// #4 [SUISSE].LOT3 
		istPec.Text = String ( dcMtPec, "#,##0.00 \"+stGlb.smonnaiesymboledesire )

		If This.uf_GestOng_Divers_Trouver ("ALT_PEC" ) = "O" Then
			istPec.TextColor = 255 // rouge
		Else
			istPec.TextColor = 32768 // Vert foncé
		End IF

		lRow = idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'ALT_PLAF_PEC'" , 1, idw_wDivDet.RowCount ())
		If lRow > 0 Then
			This.uf_GestOng_Divers_MajZone ( "ALT_PLAF_PEC", lRow, "O" )
		End If

	End If
	
	If asData = "N" Then
		lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'MT_PEC'", 1, idw_wDivDet.RowCount () )
		If lRow > 0 Then
			This.uf_GestOng_Divers_MajZone ( "MT_PEC", lRow, 0 )
		Else
			idw_wDivDet.iiErreur = 15
			stMessage.sVar [1] = "MT_PEC"
			iAction = 1
			Return iAction
		End If
		
		lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'DTE_PEC'", 1, idw_wDivDet.RowCount () )
		If lRow > 0 Then
			This.uf_GestOng_Divers_MajZone ( "DTE_PEC", lRow, stNul.dat )
		Else
			idw_wDivDet.iiErreur = 15
			stMessage.sVar [1] = "DTE_PEC"
			iAction = 1
			Return iAction
		End If		

		istPec.Text = ""

		lRow = idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'ALT_PLAF_PEC'" , 1, idw_wDivDet.RowCount ())
		If lRow > 0 Then
			This.uf_GestOng_Divers_MajZone ( "ALT_PLAF_PEC", lRow, "N" )
		End If

		lRow2 = idw_wDivDet.Find ( "NOM_ZONE = 'calcul_vetuste'", 1, idw_wDivDet.Rowcount () ) 
	
		If lRow2 > 0 Then
			iAction = This.Uf_Zn_Trt_DivDet_CalculVetuste ( "N", asNomCol, lRow2)
			If iAction = 0 Then
				This.uf_GestOng_Divers_MajZone ( "CALCUL_VETUSTE", lRow2, "N" )
			End If
		End If
	
		lRow = idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'MT_MAX_PROPO_PLF722'" , 1, idw_wDivDet.RowCount ())
		If lRow > 0 Then
			This.uf_GestOng_Divers_MajZone ( "MT_MAX_PROPO_PLF722", lRow, 0 )
		End If	
	End If	
End If 
// :#1

// [VDoc145555]
If iAction=0 And asData="O" Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 9 )
	If lDeb > 0 Then
		sVal=lnvPFCString.of_getkeyvalue( idw_DetPro.GetItemString(lDeb,"VAL_CAR"), "MSG_INFO_PEC", ";") 
		If sVal="OUI" Then
			stMessage.bErreurG	= FALSE
			stMessage.sTitre		= "Information"
			stMessage.Icon			= Information!
			stMessage.bouton		= Ok!
			stMessage.sCode = "WDET638" 
			f_Message ( stMessage )
		End if
	End if
End if
// :[VDoc145555]

//Migration PB8-WYNIWYG-03/2006 OR
//idw_wDivDet.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_trt_divdet_modlapp (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_ModlApp (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 07/10/2005
//* Libellé			: Contrôle de la zone ModlApp
//* Commentaires	: 
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

Long lDeb, lFin
Integer iAction
String sAltAucun
iAction = 0
Boolean bCasto  // cas Castorama

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 43 )
bCasto = lDeb > 0

Choose Case TRUE
	Case bCasto

		// ON ne touche à rien une fois la prise en charge cochée.
		If This.uf_GestOng_Divers_Trouver ("PEC" ) = "O" Then
			idw_wDivDet.iiErreur = 2
			iAction = 1
		End If
	
	Case Else 

End Choose


//Migration PB8-WYNIWYG-03/2006 OR
//idw_wDivDet.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_trt_divdet_qte (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_qte (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 07/10/2005
//* Libellé			: Contrôle de la zone MarqApp
//* Commentaires	: 
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//        JFF   24/01/2012   [CONFO][CUISINE]
//        JFF   24/01/2012   [CONFO][CUISINE][PC680]
//*-----------------------------------------------------------------

Long lDeb, lFin, lIdEvt
Integer iAction
String sAltAucun
iAction = 0
Boolean bCasto, bConfo, bQteZeroAutorise

bQteZeroAutorise = FALSE

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 43 )
bCasto = lDeb > 0

// [CONFO][CUISINE][PC680]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 207 )
bConfo = lDeb > 0

lIdEvt = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )

//  [CONFO][CUISINE] Suppression de la contrainte Casto, ce contrôle est valable tout le temps.

// ON ne touche à rien une fois la prise en charge cochée.
If This.uf_GestOng_Divers_Trouver ("PEC" ) = "O" Then
	idw_wDivDet.iiErreur = 1
	iAction = 1
End If

Choose Case lIdEvt
	Case 1317, 1083
		If bConfo Then
			bQteZeroAutorise = TRUE
		End If	

End Choose 

If Long ( asData ) <= 0 And Not bQteZeroAutorise Then
	idw_wDivDet.iiErreur = 2
	iAction = 1
End If

//Migration PB8-WYNIWYG-03/2006 OR
//idw_wDivDet.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_dte_det_date ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_zn_Dte_Det_Date (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 18/05/2005 17:14:39
//* Libellé			: 
//* Commentaires	: Controle de la date d'achat
//*
//* Arguments		: Aucun
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//* JFF  07/04/2010	[DCMP100188]
//* JFF  10/09/2012  [PLAF_REF]
//* JFF  15/04/2019  [PC182145]
//*-----------------------------------------------------------------

String sDte
Boolean bCasto, bOk
Long lDeb, lFin, lIdEvt, lIdGti, lCpt, lVal
Integer iAction
Date dtDteDet 

dtDteDet = idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" )
lIdEvt = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
sDte = Trim ( idw_wDetailFF.GetText () )
iAction = 0
bOk = FALSE

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 43 )
bCasto = lDeb > 0

//If iAction = 0 And bCasto Then #1
If iAction = 0 Then  // #1
	// ON ne touche à rien une fois la prise en charge cochée.
	If This.uf_GestOng_Divers_Trouver ("PEC" ) = "O" Then

		// [PLAF_REF] autorisation de la modification de la dte_det dans un cas très précis.
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 42 )
		If lDeb > 0 Then
			For lCpt = lDeb to lFin 
				If  idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM")  = lIdGti And idw_DetPro.GetItemString ( lCpt, "ID_CODE_CAR" ) = "A"  Then 
					If lIdEvt = 1083 Then
						iAction = 0			
						bOk = True
					End IF
				End If
			Next
			
			If Not bOk Then
				idw_wDetailFF.iiErreur = 1
				iAction = 1
			End If
			
		Else
			idw_wDetailFF.iiErreur = 1
			iAction = 1
		End If
	End If

End If

// [DCMP100188]
If iAction = 0 And Not IsDate ( sDte ) Then

	idw_wDetailFF.iiErreur = 0
	iAction = 1

End If 

// [PC182145]
If iAction = 0 Then
	If Date ( sDte ) > Today () Then 
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 134 )
		lVal = idw_DetPro.Find ( "ID_CODE_NUM = " + String ( lIdGti ) + " OR ID_CODE_NUM = -1", lDeb , lFin )
		If lVal <=0 Then 
			idw_wDetailFF.iiErreur = 0
			iAction = 1
		End If 
	End If 		
End If
// :[DCMP100188]


//Migration PB8-WYNIWYG-03/2006 OR
//idw_wDetailFF.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_trt_divdet_alt_pec (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_Alt_Pec (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 07/10/2005
//* Libellé			: Contrôle de la zone AltPec (Forcer la Prise En Charge)
//* Commentaires	: 
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
//*       JFF   17/06/2011   [PC545].[BUG_BGE_721]
//*		 JFF   12/07/2011   [DOC4684]
//*       JFF   27/07/2011   [PLAF_REF]
//        JFF   20/02/2014   [VDOC13754]
//*-----------------------------------------------------------------

Long lDeb, lFin, lRow, lQte, lCodETat, lTotDetail, lCptDet, lTotwRefus, lCodeRef
Long lCpt, lIdGti, lIdDetail // #1
Date dDteAchat
Integer iAction
String sAltAucun, sMarq, sModl
iAction = 0
Decimal {2} dcMtValAchat
Boolean bCasto, bForcerOK  // cas Castorama
Boolean bGestPEC // bGestPec
u_DataWindow udwNull // #1
s_Plafond_Pec stPlafPec // #1
Decimal {2} dcMtPec, dcMtLu, dcMtMaxLu 
n_cst_string lnvPFCString		
String sVal, sRech
string sTypParaVer[], sTempTypPlaf, sTempIdPara, sTempCptVer, sValCar
Integer i
Boolean bBitMap

// ITSM134028
// Clé permanente à ne pas supprimer
// On shunt les contrôles bloquant, on autorise le forçage.
If F_CLE_A_TRUE ( "SHUNT_CTRLE_FORC_PEC" ) Then
	Choose Case stGlb.sCodOper
		Case "JFF", "FPI"
			Return 0
	End Choose
End If

If This.uf_GetAutorisation ( 208 ) Then
	Return 0
End If

SetNull ( udwNull )
sVal = ""

lCodEtat = idw_wDetailFF.GetItemNumber ( 1, "COD_ETAT" )
// #1 
lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
lIdDetail = idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" )

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 43 )
bCasto = lDeb > 0

// #1
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 86 )
bGestPEC = False
If lDeb > 0 Then
	For lCpt = lDeb To lFin
		If idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) = lIdGti Then
			bGestPEC = True
			Exit
		End If 
	Next
End If

// #1 On gère Casto à l'ancienne méthode.
If Not bCasto And Not bGestPec Then
	idw_wDivDet.iiErreur = 12
	iAction = 1	
	Return iAction
End If

// #1
Choose Case lCodEtat
	Case 100, 0, 1, 200
		// Ok on peut décoché
	Case Else 
		idw_wDivDet.iiErreur = 10
		iAction = 1
		Return iAction		
end Choose 

If This.uf_Deja_Une_Commande () Then
	idw_wDivDet.iiErreur = 17
	iAction = 1
	Return iAction			
End If


// #1 Le gt peut-il forcer ? (cocher/décocher)
// [DOC4684]
bForcerOK = ( Long ( stGlb.sTypOper ) >= idw_Produit.GetItemNumber ( 1, "COD_NIV_OPE" ) ) OR &
				Mid ( gsBINDroit, 18, 1 ) = "1"

If Not bForcerOK And iAction = 0 Then
	idw_wDivDet.iiErreur = 7
	iAction = 1
	Return iAction
End If


// Partie commune 
// #1 
Choose Case asData 
	Case "O"

		lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'PEC'", 1, idw_wDivDet.RowCount () )
		If lRow > 0 Then
			If idw_wDivDet.GetItemString ( lRow, "VAL_CAR", Primary!, TRUE ) = "O" And &
			   idw_wDivDet.GetItemNumber ( lRow, "CPT_VALIDE" ) > 0 Then
				idw_wDivDet.iiErreur = 16
				iAction = 1
				Return iAction
			End If
		End If
		
		If iAction = 0 And This.uf_GestOng_Divers_Trouver ("PEC" ) = "N" Then
			idw_wDivDet.iiErreur = 8
			iAction = 1
			Return iAction
		End If 
		
	Case "N"
		
		lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'ALT_PEC'", 1, idw_wDivDet.RowCount () )
		If lRow > 0 Then
			If idw_wDivDet.GetItemString ( lRow, "VAL_CAR", Primary!, TRUE ) = "O" And &
			   idw_wDivDet.GetItemNumber ( lRow, "CPT_VALIDE" ) > 0 Then
				idw_wDivDet.iiErreur = 16
				iAction = 1
				Return iAction
			End If
		End If

End Choose

// Casto
Choose Case TRUE
	Case bCasto And asData = "O"


	Case bCasto And asData = "N"
		If iAction = 0 And idw_wDetailFF.GetItemNumber ( 1, "CPT_VALIDE" ) > 0 Then
			idw_wDivDet.iiErreur = 6
			iAction = 1
			Return iAction			
		End If

		If iAction = 0 Then
			Choose Case lCodEtat
				Case 100, 0, 1
					// Ok on peut décoché
				Case Else 
					idw_wDivDet.iiErreur = 10
					iAction = 1
					Return iAction					
			end Choose 
		End If

	Case Else 

End Choose


// #1
// Option 86 uniquement
If Not bCasto And bGestPEC And iAction = 0 Then

	If asData = "O" Then
		lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'MT_PEC'", 1, idw_wDivDet.RowCount () )
		If lRow > 0 Then
			idw_wDivDet.SetItem ( lRow, "ALT_PROT", "N" )
		End If 

		istPec.TextColor = 255 // rouge

		lRow = idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'ALT_PLAF_PEC'" , 1, idw_wDivDet.RowCount ())
		If lRow > 0 Then
			This.uf_GestOng_Divers_MajZone ( "ALT_PLAF_PEC", lRow, "N" )
		End If
	
	End If 	


	If asData = "N" Then
		lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'MT_PEC'", 1, idw_wDivDet.RowCount () )
		If lRow > 0 Then
			idw_wDivDet.SetItem ( lRow, "ALT_PROT", "O" )
		End If 
		
		istPec.TextColor = 32768 // Vert foncé		

		// [PC545].[BUG_BGE_721]
		//	 [PC363].[10%]
		lRow = idw_LstCmdeSin.Find ( "COD_ETAT <> 'ANN' AND POS ( INFO_FRN_SPB_CPLT, 'APP_INCOMPLET=OUI', 1) >0", 1, idw_LstCmdeSin.RowCount () )
		sVal = "[###]"

		If lRow > 0 Then
			lnvPFCString.of_Setkeyvalue ( sVal, "APP_INCOMPLET", "OUI", ";")
		End If

		// [PC301].[V15_EVOL_VETUSTE]
		lTotDetail = idw_wDetailFF.iudwDetailSource.RowCount ()
		dcMtLu = 0
		dcMtMaxLu = 0
		For lCptDet = 1 To lTotDetail	
			
			sRech	=		"ID_GTI = "	+ String ( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCptDet, "ID_GTI" ) )	+ " AND " 	+ &
							"ID_DETAIL = "	+ String ( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCptDet, "ID_DETAIL" ) )	+ " AND " 	+ &
							"UPPER ( NOM_ZONE ) = 'MT_MAX_PROPO_PLF722'"
				
			lRow = idw_wDivDetGti.Find ( sRech, 1, idw_wDivDetGti.RowCount () ) 
			If lRow > 0 Then
				dcMtLu = idw_wDivDetGti.GetItemDecimal ( lRow, "VAL_MT" )
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

		stPlafPec = F_Plafond_Pec ( "4" + sVal, idw_wSin, idw_wDivSin, udwNull, idw_wDetailFF, udwNull, idw_Plafond, idw_DetPro, idw_produit, idw_wDivDet, lIdGti, lIdDetail )
		
		dcMtPec = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" )
		
		If ( dcMtPec > stPlafPec.dcPlafEvt And stPlafPec.dcPlafEvt > 0 ) Or dcMtPec <= 0 Then dcMtPec = stPlafPec.dcPlafEvt
		If ( dcMtPec > stPlafPec.dcPlafValAch And stPlafPec.dcPlafValAch > 0 ) Or dcMtPec <= 0 Then dcMtPec = stPlafPec.dcPlafValAch
		If ( dcMtPec > stPlafPec.dcPlafGti  And stPlafPec.dcPlafGti  > 0 ) Or dcMtPec <= 0 Then dcMtPec = stPlafPec.dcPlafGti  
		If ( dcMtPec > stPlafPec.dcPlafValPublique And stPlafPec.dcPlafValPublique > 0 ) Or dcMtPec <= 0 Then dcMtPec = stPlafPec.dcPlafValPublique
		If Left ( stPlafPec.sPlafAutre, 1 ) = "O" Then dcMtPec = 0 

		If IsNull ( dcMtPec ) Then dcMtPec = 0

		// [PLAF_REF]
		If ( dcMtPec <= 0 Or dcMtPec = 0.01 ) Then 
			dcMtPec = 0 

			F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 183 )
			If lDeb > 0 And dcMtPec = 0 Then

				f_decomposerchaine (stPlafPec.stypparaver, ";", sTypParaVer[])
				for i = 1 to UpperBound(sTypParaVer)
					if sTypParaVer[i] <> "" then
						sTempTypPlaf = left (left (sTypParaVer[i], 8), 4)
						sTempIdPara  = right (left (sTypParaVer[i], 8), 4)
						sTempCptVer  = right (sTypParaVer[i], 3)
						
						For lCpt = lDeb To lFin
							If Long ( idw_DetPro.GetItemString ( lCpt, "ID_CODE_CAR" ) ) = Long ( sTempTypPlaf ) Then
								sValCar = idw_DetPro.GetItemString ( lCpt, "VAL_CAR" )
								lCodeRef = Long ( lnvPFCString.of_getkeyvalue( sValCar, "REF_EVT", ";"))

								// Evol
								If Long ( lnvPFCString.of_getkeyvalue( sValCar, "REF_GTI", ";")) > 0 And lCodeRef = 0 Then
									Continue
								End if
							
								If Not Uf_RF_EcrireRefus ( lCodeRef ) Then
									iAction = 1
									Return iAction		
								End If
							End If 
						Next
					end if
				next

				lTotwRefus = iuoTagRefus.dw_Trt.RowCount ()
				For	lCpt = 1 To lTotwRefus
						If	( iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_OPE" ) = "O" Or iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_MAC" ) = "O" ) Then
							bBitMap = True
							If	IsNull ( iuoTagRefus.dw_Trt.GetItemNumber ( lCpt, "ID_I" ) ) Then
								// [VDOC13754]
								If Not This.uf_GetAutorisation ( 208 ) Then
									stMessage.sCode		= "WGAR100"
									F_Message ( stMessage )
								End If
								Exit
							End If
						End If
				Next

				If	bBitMap	Then
					iuoOng.Uf_ChangerBitmap ( "03", "K:\PB4OBJ\BMP\8_REF.BMP" )
				Else
					iuoOng.Uf_ChangerBitmap ( "03", "" )
				End If
			End If
		End If
		// [PLAF_REF]


		lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'MT_PEC'", 1, idw_wDivDet.RowCount () )
		If lRow > 0 Then
			This.uf_GestOng_Divers_MajZone ( "MT_PEC", lRow, dcMtPec )
		Else
			idw_wDivDet.iiErreur = 15
			stMessage.sVar [1] = "MT_PEC"
			iAction = 1
			Return iAction
		End If
		// [SUISSE].LOT3
		istPec.Text = String ( dcMtPec, "#,##0.00 \"+stGlb.smonnaiesymboledesire )

		lRow = idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'ALT_PLAF_PEC'" , 1, idw_wDivDet.RowCount ())
		If lRow > 0 Then
			This.uf_GestOng_Divers_MajZone ( "ALT_PLAF_PEC", lRow, "O" )
		End If
		
		
	End If 

End If 

//Migration PB8-WYNIWYG-03/2006 OR
//idw_wDivDet.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

public function long uf_zn_trt (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_Trt (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:27:01
//* Libellé			: 
//* Commentaires	: Traitement sur les zones de dw_wDetailFF (On vient de ItemChanged)
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1 PHG 26/07/2007	[DCMP070275] Ajout nvx motifs sans suite pour la facturation
//* #2 JFF 28/01/2008   [DCMP080028]
//* #3 JFF 01/04/2009   [20090401102753490]
//*    JFF 21/12/2010   [PC301][VESTUSTE]
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//variable permettant la récupération et le retour de la fonction appelée
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

Choose Case idw_wDetailFF.isNomCol
Case "HEU_DET"
	ll_ret = Uf_Zn_HeuDet ()

Case "LIB_DET"
	Uf_Zn_LibDet ()

Case "ALT_REG"
	ll_ret = Uf_Zn_AltReg ()

Case "ALT_SSUI"
	ll_ret = Uf_Zn_AltSSui ()

// #1 [DCMP070275] On teste la valeur saisie de Motif Sans Suite
Case "COD_MOT_SSUI"
	ll_ret = Uf_Zn_CodMotSsui ()

Case "ALT_ATT"
	ll_ret = Uf_Zn_AltAtt ()

Case "ALT_BLOC"
	Uf_Zn_AltBloc ()

Case "NUM_CARTE"
	ll_ret = Uf_Zn_NumCarte ()

Case "ID_EVT"
	ll_ret = Uf_Zn_IdEvt_Telephonie ()

Case "MT_PREJ"
	// [PC301][VESTUSTE]
	ll_ret = Uf_Zn_MtPrej ()

Case "DTE_FACTURE"
	ll_ret = Uf_Zn_DteFacture ()

Case "NUM_FACTURE"
	ll_ret = Uf_Zn_NumFacture ()

Case "MT_VAL_ACHAT"
	//* #3 [20090401102753490]
	ll_ret = Uf_Zn_MtValAchat (idw_wDetailFF.GetText ())

// #2
Case "MT_VAL_PUBLIQUE"
	ll_ret = Uf_Zn_MtValPublique ()
// :#2

Case "ID_I_REG"
	ll_ret = Uf_Zn_IdIReg ()

Case "DTE_DET_DATE"
	ll_ret = Uf_Zn_Dte_Det_Date ()


End Choose

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end function

public function long uf_zn_trt_divdet (string asdata, string asnomcol, long alrow, string asnomzone);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_Trt_DivDet (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 17/06/2004 
//* Libellé			: 
//* Commentaires	: Traitement sur les zones de dw_w_div_det. (On vient de ItemChanged)
//*
//* Arguments		: String		asData		Val
//*					  String		asNomCol		Val
//*					  Long		alRow			Val
//*					  String		asNomZone	Val
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
//* #2	 JFF	 27/08/2007   [DCMP070431]
//* #3    JFF   05/02/2008   [DCMP070921]
//* #4	 JFF	 20/10/2008	  [FNAC_PROD_ECH_TECH]
//* #5	 JFF	 20/10/2008	  [FNAC_PROD_ECH_TECH].[20090127140540720]
//* 		 JFF   07/05/2010   [DCMP100331]
//* 		 JFF   04/11/2010   [PC301].[LOT2]
//        JFF   16/12/2010   [PC301][VESTUSTE]
//        JFF   24/01/2012   [CONFO][CUISINE][PC680]
//        JFF   01/03/2012   [CONFO][MEUBLE][PC542]
//        JFF   24/09/2018   [DT344]
//        JFF   24/05/2019   [DT391-1]
//*-----------------------------------------------------------------
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

DateTime dtMajLe // #1


Choose Case asNomCol

	/*------------------------------------------------------------------*/
	/* Traitement de colonne	                                         */
	/*------------------------------------------------------------------*/
	Case	"VAL_LST_NBRE", "VAL_LST_CAR"
		ll_ret = This.Uf_Zn_Trt_DivDet_Vallst ( Upper ( asData ), Upper( asNomCol ), alRow )

		/*------------------------------------------------------------------*/
		/* Traitement de zone  		                                         */
		/*------------------------------------------------------------------*/
		Choose Case Upper ( asNomZone ) 

			Case "TYPE_APP"
//				This.Uf_Zn_Trt_DivDet_TypeApp ( Upper ( asData ), Upper( asNomCol ), alRow, FALSE )

			Case "ACCORD_REMPL"
				ll_ret = This.Uf_Zn_Trt_DivDet_AccordRempl ( Upper ( asData ), Upper( asNomCol ), alRow )

			Case "ACCORD_REMPL2" // #3
				ll_ret = This.Uf_Zn_Trt_DivDet_AccordRempl2 ( Upper ( asData ), Upper( asNomCol ), alRow )

			// [CONFO][MEUBLE][PC542]
			Case "TAILLE_ARTICLE"
				ll_ret = This.Uf_Zn_Trt_DivDet_TailleArticle ( Upper ( asData ), Upper( asNomCol ), alRow )	

			// [CONFO][MEUBLE][PC542]
			Case "ENLV_BIEN"
				ll_ret = This.Uf_Zn_Trt_DivDet_EnlvBien ( Upper ( asData ), Upper( asNomCol ), alRow )	

			// [DT344]
			Case "SOUPLESSE_1", "SOUPLESSE_2", "SOUPLESSE_3"
				ll_ret = This.Uf_Zn_Trt_DivDet_Souplesse ( Upper ( asData ), Upper( asNomCol ), alRow )	

			// [DT391-1]
			Case "REFUS_SCB"
				ll_ret = This.Uf_Zn_Trt_DivDet_RefusSCB ( Upper ( asData ), Upper( asNomCol ), alRow )	


		End Choose 

	Case	"VAL_NBRE"
		Choose Case Upper ( asNomZone ) 
			Case "QTE"
				ll_ret = This.Uf_Zn_Trt_DivDet_Qte ( Upper ( asData ), Upper( asNomCol ), alRow )

			// [PC301][VESTUSTE]			
			Case "VETUSTE"
				ll_ret = This.Uf_Zn_Trt_DivDet_Vetuste ( Upper ( asData ), Upper( asNomCol ), alRow )				

			// [CONFO][CUISINE][PC680]
			Case "CODE_RGPR_ELEMENT"
				ll_ret = This.Uf_Zn_Trt_DivDet_code_rgpr_element ( Upper ( asData ), Upper( asNomCol ), alRow )	

				
		End Choose

	Case	"VAL_CAR"
		Choose Case Upper ( asNomZone ) 

			Case "MARQ_APP"
				ll_ret = This.Uf_Zn_Trt_DivDet_MarqApp ( Upper ( asData ), Upper( asNomCol ), alRow )
			Case "MODL_APP"
				ll_ret = This.Uf_Zn_Trt_DivDet_ModlApp ( Upper ( asData ), Upper( asNomCol ), alRow )

			//* #4 [FNAC_PROD_ECH_TECH]
			//* #5 [FNAC_PROD_ECH_TECH].[20090127140540720]
			Case "FNC_MAG", "FNC_HEU_TICKET", "FNC_CAISSE", "FNC_HOTE", "FNC_TICKET", "FNC_MARQ_MODL"
				ll_ret = This.Uf_Zn_Trt_DivDet_RejetZone_Droit ( Upper ( asData ), Upper( asNomCol ), alRow, 208 )

			//* #5 [FNAC_PROD_ECH_TECH].[20090127140540720]
			Case "FNC_NUM_FACT"
				ll_ret = This.Uf_Zn_Trt_DivDet_RejetZone_Droit ( Upper ( asData ), Upper( asNomCol ), alRow, 208 )
				If ll_ret = 0 Then Uf_Zn_Trt_DivDet_FncNumFact ( Upper ( asData ), Upper( asNomCol ), alRow )

			// [DCMP100331]
			Case "NUM_PRS"
				ll_ret = This.Uf_Zn_Trt_DivDet_NumPrs ( Upper ( asData ), Upper( asNomCol ), alRow )

			// [PC301].[LOT2]
			Case "ADR_IMM_ETG"
				ll_ret = This.Uf_Zn_Trt_DivDet_Adr_Imm_Etg ( Upper ( asData ), Upper( asNomCol ), alRow )				
				
			Case "CODE_ARTICLE"
				ll_ret = This.Uf_Zn_Trt_DivDet_Code_Article ( Upper ( asData ), Upper( asNomCol ), alRow )				
				
			Case "LIB_ARTICLE"
				ll_ret = This.Uf_Zn_Trt_DivDet_Lib_Article ( Upper ( asData ), Upper( asNomCol ), alRow )				
				

		End Choose 

	Case	"VAL_ALT"
		Choose Case Upper ( asNomZone ) 

			Case "AUCUNE_MARQ"
				ll_ret = This.Uf_Zn_Trt_DivDet_AucuneMarq ( Upper ( asData ), Upper( asNomCol ), alRow )

			Case "PEC"
				ll_ret = This.Uf_Zn_Trt_DivDet_Pec ( Upper ( asData ), Upper( asNomCol ), alRow )

			Case "ALT_PEC"
				ll_ret = This.Uf_Zn_Trt_DivDet_Alt_Pec ( Upper ( asData ), Upper( asNomCol ), alRow )

			Case "DOS_CHARGE_SPB"
				ll_ret = This.Uf_Zn_Trt_DivDet_DosChargeSPB ( Upper ( asData ), Upper( asNomCol ), alRow )

			Case "CALCUL_VETUSTE"
				ll_ret = This.Uf_Zn_Trt_DivDet_CalculVetuste ( Upper ( asData ), Upper( asNomCol ), alRow )

			// [CONFO][CUISINE]
			Case "COLLER_INFO"
				ll_ret = This.Uf_Zn_Trt_DivDet_CollerInfo ( Upper ( asData ), Upper( asNomCol ), alRow )

	End Choose 

	Case	"VAL_DTE"
		Choose Case Upper ( asNomZone ) 
			//* #4 [FNAC_PROD_ECH_TECH]
			Case "FNC_DTE_TICKET" 
				ll_ret = This.Uf_Zn_Trt_DivDet_RejetZone_Droit ( Upper ( asData ), Upper( asNomCol ), alRow, 208 )

				//* #5 [FNAC_PROD_ECH_TECH].[20090127140540720]
				If ll_ret = 0 Then This.Uf_Zn_Trt_DivDet_FncDteTicket ( Upper ( asData ), Upper( asNomCol ), alRow )

			Case "DTE_FIN_GTI_ARTICLE" 
				ll_ret = This.Uf_Zn_Trt_DivDet_Dte_Fin_Gti_Article ( Upper ( asData ), Upper( asNomCol ), alRow )


		End Choose 
	Case	"VAL_MT"

		/*------------------------------------------------------------------*/
		/* Traitement de zone  		                                         */
		/*------------------------------------------------------------------*/
		Choose Case Upper ( asNomZone ) 

			Case "MT_PEC" // #1
				ll_ret = This.Uf_Zn_Trt_DivDet_MtPec ( Upper ( asData ), Upper( asNomCol ), alRow )

			//* #4 [FNAC_PROD_ECH_TECH]
			Case "FNC_MT_TICKET" 
				ll_ret = This.Uf_Zn_Trt_DivDet_RejetZone_Droit ( Upper ( asData ), Upper( asNomCol ), alRow, 208 )
		End Choose 



End Choose


If ll_Ret = 0 Then

	// #1
	dtMajLe = DateTime ( Today (), Now () )
	
	idw_wDivDet.SetItem ( alRow, "MAJ_LE", dtMajLe )
	idw_wDivDet.SetItem ( alRow, "MAJ_PAR", stGlb.sCodOper )
	idw_wDivDet.SetItem ( alRow, "ALT_SUPP", "N" )
	
	// #1 Plus logique de mettre aussi à jour w_sin
	idw_wDetailFF.SetItem ( 1, "MAJ_LE", dtMajLe  )
	idw_wDetailFF.SetItem ( 1, "MAJ_PAR", stGlb.sCodOper )		

End If

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end function

private function boolean uf_rf_654 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_654 (PRIVATE)
//* Auteur			: PHG, d'apres Uf_rf_654
//* Date				: 31/06/2006
//* Libellé			: 
//* Commentaires	: Seuil d'intervention non atteint
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* Modif déja réalisé dans la uf_rf_650
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//* Modif specifique uf_rf_654
//* [DCMP060272]	PHG	31/05/2006 : Ajout refus 654
//* #2		PHG	26/10/2009 [DCMP071000] rf 655+651: Annexe : Correction Bug
//*								  présent sur toute les fonctions de refus.

//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt
String sIdNivPlaf, sIdRefPlaf
Boolean bRet

Decimal {2} dcValAchat

String sRech

bRet				= True
lTotPlaf 		= idw_Plafond.RowCount ()
dcValAchat		= idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" )

/*------------------------------------------------------------------*/
/* Si le montant d'achat est NULL ou égal à zéro, on ne gére   */
/* pas de refus.                                                    */
/*------------------------------------------------------------------*/
If	IsNull ( dcValAchat ) Or dcValAchat = 0 Then Return ( bRet )

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 1 to 5

	Choose Case lCpt
		Case 1
			sIdNivPlaf = "-GA"  // Garantie
			sIdRefPlaf = "-1"
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond 										  */
	/*------------------------------------------------------------------*/
	// #2 [DCMP071000] Lecture ID_GTI dans idw_wDetailFF ald de idw_wGarSin
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '" + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"																					+ " AND " 	+ &
					"ID_TYP_PLAF = '654'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* Si le montant du préjudice est strictement inférieur au montant  */
/* du plafond, on déclenche le refus 654.                           */
/*------------------------------------------------------------------*/
		If	dcValAchat < idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )	Then
			bRet = Uf_RF_EcrireRefus ( 654 )
		End If
	End If
Next

Return ( bRet )
end function

private function long uf_zn_trt_divdet_doschargespb (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_DosChargeSPB (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 19/07/2006
//* Libellé			: Contrôle de la zone Dos_Charge_SPB (Forcer la Prise En Charge)
//* Commentaires	: 
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//* Retourne		: long
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------
Int iAction

iAction = 0

// Droit 209/-NA pour pouvoir Cocher.
If Not This.uf_GetAutorisation ( 209 ) Then 
	idw_wDivDet.iiErreur = 11
	iAction = 1
End If

Return iAction
end function

public function string uf_gestion_mediasaturn ();//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_sinistre_wdetail::uf_Gestion_MediaSaturn (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 09/10/2006 15:05:09
//* Libellé       : Gestion du produit MEDIA SATURN
//* Commentaires  : Option -DP,71
//*
//* Arguments     : 
//*
//* Retourne      : String			// Code d'aiguillage
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1   MADM   20/07/2006   DCMP 060528 Gestion particuliére sur la marque CREATIVE 
//*
//*-----------------------------------------------------------------

Long	  lIdGti, lDeb, lFin
String  asRet

/*------------------------------------------------------------------*/
/* Sommes-nous en Gestion MEDIA SATURN                              */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 71 )
If lDeb <= 0 Then Return ""

lIdGti  = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
stMessage.sCode = "" 
asRet = ""

/*------------------------------------------------------------------*/
/* En fonction de Garantie (BRIS/VOL) 										  */
/* on définit un aiguillage.                                        */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* #1 Récupération de la marque via la grille de sinistre           */
/*------------------------------------------------------------------*/
Choose Case lIdGti
	
	Case 11  // BRIS
			asRet = "11/EXPERT_MDS"
	Case 10  // Vol
			asRet = "10/CMDE_MDS"
			
	Case Else 
			asRet = ""
			
End Choose

Return asRet
end function

private subroutine uf_controlergestion_208 (ref string aspos);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerGestion_208 (PRIVATE)
//* Auteur			: JCA
//* Date				: 13/11/2006
//* Libellé			: 
//* Commentaires	: DCMP 060826	- Contrôle de saisie liés au réglement des fournisseurs par les personnes ayant le droit 208
//*
//* Arguments		: String		asPos		Réf.
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF	 20/10/2008	[FNAC_PROD_ECH_TECH]
//*     JFF  02/07/2012 [PM103]
//		FPI	06/08/2012	[VDoc7858]
//    JFF   14/02/2012  [VDOC10265]
//*-----------------------------------------------------------------

Long  lRow, lTot, lCpt
String sVal
String sTab []
String sRech 
String sIdFour

sVal = string ( idw_wDetailFF.GetItemNumber ( 1, "ID_I_REG"  ) )
lRow = idw_LstInter.Find ( "ID_I = " + sVal, 1, idw_LstInter.RowCount () )

If lRow <= 0 Then asPos = ""

If idw_LstInter.GetItemString ( lRow, "COD_INTER" ) = "F" and &
	not This.uf_GetAutorisation ( 208 ) And &
	Not gbModeReprise_223 &
	Then 		asPos = "ID_I_REG"

If asPos <> "" Then
	stMessage.sTitre		= "Contrôle interlocuteur réglement"
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "WDET260"

	f_Message ( stMessage )
End If


//* #1 [FNAC_PROD_ECH_TECH]
If idw_LstInter.GetItemString ( lRow, "COD_INTER" ) = "F" and &
   Pos ( idw_LstInter.GetItemString ( lRow, "NOM" ), "/FNC/", 1 ) > 0 Then
	
	sTab [1]	= "fnc_mag"
	sTab [2]	= "fnc_heu_ticket"
	sTab [3]	= "fnc_caisse"
	sTab [4]	= "fnc_hote"
	sTab [5]	= "fnc_ticket"	

	lTot = UpperBound ( sTab )
	For lCpt = 1 To lTot 
		sVal = This.uf_GestOng_Divers_Trouver ( sTab [lCpt] )
		If IsNull ( sVal ) Or Trim ( sVal ) = "" Then
			asPos = "ID_I_REG"
			Exit
		End If
	Next

	If asPos = "" Then
		sVal = This.uf_GestOng_Divers_Trouver ( "fnc_dte_ticket" )	
		If IsNull ( sVal ) Or Trim ( sVal ) = "01/01/1900" Or Trim ( sVal ) = "" Then asPos = "ID_I_REG"
	End If 

	If asPos = "" Then
		sVal = This.uf_GestOng_Divers_Trouver ( "fnc_mt_ticket" )	
		If IsNull ( sVal ) Or Not IsNumber ( sVal ) Then
			asPos = "ID_I_REG"
		End If
		
		If asPos = "" Then
			If Long ( sVal ) = 0 Then asPos = "ID_I_REG"
		End IF
	End If 
	
	If asPos <> ""THen
		stMessage.sTitre		= "Contrôle lié à la facturation"
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "WDET261"
		
		f_Message ( stMessage )
	End If
End If
//* :#1 [FNAC_PROD_ECH_TECH]

// [VDOC7858]
If asPos="" Then
	If idw_LstInter.GetItemString ( lRow, "COD_INTER" ) = "F" and &
		This.uf_GetAutorisation ( 208 ) And &
		idw_wDetailFF.GetItemDecimal( 1, "MT_PREJ") > 0 Then

		 sVal=idw_lstcmdedet.Describe("Evaluate('Sum(mt_ttc_cmde)', 0)")
		
		If Dec(sVal) > 0 Then
			If idw_wDetailFF.GetItemDecimal( 1, "MT_PREJ")  > Dec(sVal) Then
				stMessage.sTitre		= "Contrôle lié à la facturation"
				stMessage.bErreurG	= FALSE
				stMessage.sCode		= "WDET619"
				stMessage.bouton=YesNo!
				
				if f_Message ( stMessage ) = 2 Then asPos = "ID_I_REG"
			End if
		End if
		
	End if
End if

// [VDOC10265]
sIdFour = idw_LstInter.GetItemString ( idw_LstInter.Find ( "ID_I = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_I_REG" ) ) , 1, idw_LstInter.RowCount () ), &
													"ID_FOUR" ) 

sRech = "ID_GTI = " + String ( idw_wDetailFF.GetItemDecimal( 1, "ID_GTI") ) + " AND " + &
		  "ID_DETAIL = "+ String ( idw_wDetailFF.GetItemDecimal( 1, "ID_DETAIL") ) + " AND " + &
		  "COD_ETAT = 'ANN' And ID_FOUR='" + sIdFour + "'"
		  
If idw_LstCmdeSin.Find ( sRech, 1, idw_LstCmdeSin.RowCount () ) > 0 Then
	stMessage.sTitre		= "Contrôle lié à la facturation"
	stMessage.bErreurG	= FALSE
	stMessage.Icon			= Exclamation!
	stMessage.sCode		= "WDET622"
	stMessage.bouton		= Ok!
	
	// Info simplement
	F_Message ( stMessage ) 
End If
// [VDOC10265]


end subroutine

private function boolean uf_deja_une_commande ();//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_sinistre_wdetail::uf_Deja_Une_Commande (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 14/12/2006 15:46:26
//* Libellé       : Retourne TRUE si présence d'une commande pour ce détail
//*					  su le sinistre.
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : Decimal	Max TTC
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

Decimal {2}	dcPlafond, dcPlafondSav
String  sFiltreOrig, sFiltre, sIdGti, sIdDetail
Int     iNbCmde

sIdGti = String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )
sIdDetail = string ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )
iNbCmde = 0


sFiltre = "ID_GTI = " + sIdGti + " AND ID_DETAIL = " + sIdDetail

/*------------------------------------------------------------------*/
/* Recherche sur liste des commandes se trouvant au niveau du       */
/* sinistre.                                                        */
/*------------------------------------------------------------------*/
sFiltreOrig = idw_LstCmdeSin.Describe ( "datawindow.table.filter" )
If sFiltreOrig = "?" Then sFiltreOrig = ""

idw_LstCmdeSin.SetFilter ( sFiltre )
idw_LstCmdeSin.Filter ()

iNbCmde += idw_LstCmdeSin.Rowcount ()

idw_LstCmdeSin.SetFilter ( sFiltreOrig )
idw_LstCmdeSin.Filter ()

/*------------------------------------------------------------------*/
/* Recherche sur liste des commandes se trouvant au niveau de       */
/* la Gti.                                                          */
/*------------------------------------------------------------------*/
sFiltreOrig = idw_LstCmdeGti.Describe ( "datawindow.table.filter" )
If sFiltreOrig = "?" Then sFiltreOrig = ""

idw_LstCmdeGti.SetFilter ( sFiltre )
idw_LstCmdeGti.Filter ()

iNbCmde += idw_LstCmdeGti.Rowcount ()

idw_LstCmdeGti.SetFilter ( sFiltreOrig )
idw_LstCmdeGti.Filter ()

/*------------------------------------------------------------------*/
/* Recherche sur liste des commandes se trouvant au niveau du       */
/* Detail.                                                          */
/*------------------------------------------------------------------*/
sFiltreOrig = idw_LstCmdeDet.Describe ( "datawindow.table.filter" )
If sFiltreOrig = "?" Then sFiltreOrig = ""

idw_LstCmdeDet.SetFilter ( sFiltre )
idw_LstCmdeDet.Filter ()

iNbCmde += idw_LstCmdeDet.Rowcount ()

idw_LstCmdeDet.SetFilter ( sFiltreOrig )
idw_LstCmdeDet.Filter ()


Return iNbCmde > 0 

end function

private function boolean uf_rf_627 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_627 (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 30/01/2007 
//* Libellé			: [DCMP060794]
//* Commentaires	: Date Surv/Date Détail (Det>Surv+Dl)
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1		PHG	26/10/2009 [DCMP071000] rf 655+651: Annexe : Correction Bug
//*								  présent sur toute les fonctions de refus.
//*-----------------------------------------------------------------
Long 		lTotDelai, lLig, lDuree, lNbJour, lNbHeu, lHeuSurv, lHeuMax, lCpt
Boolean 	bRet
String 	sRech, sUnite, sHeuDet, sHeuSurv, sIdNivDel, sIdRefDel
Date		dDteSurv, dDteDet, dDteMax
Time		hHeuMax
DateTime dtDteMax, dtDet

bRet				= True
lTotDelai 		= idw_Delai.RowCount ()


/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 1 to 5

	Choose Case lCpt
		Case 1
			sIdNivDel = "-GA"  // Garantie
			sIdRefDel = "-1"
		Case 2
			sIdNivDel = "+NS"  // Nature de sinistre
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivDel = "+TR"  // Territorialité
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivDel = "+DT"  // Détail de sinistre
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivDel = "+EV"  // Evénement de garantie
			sIdRefDel = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )


	End Choose

	If IsNull ( sIdRefDel ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un délai de déclaration pour la garantie. */
	/*------------------------------------------------------------------*/
	// #1 [DCMP071000] Lecture ID_GTI dans idw_wDetailFF ald de idw_wGarSin
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_DEL = '"  + sIdNivDel 																+ "' AND " 	+ &
					"ID_REF_DEL = "	+ sIdRefDel 																+ " AND " 	+ &
					"ID_TYP_DEL = '627'"

	lLig = idw_Delai.Find ( sRech, 1, lTotDelai )


	If	lLig > 0 Then

	/*------------------------------------------------------------------*/
	/* Le cas du délai en heure est géré à part car on doit travailler  */
	/* sur des datetime et non sur des dates.                           */
	/* De plus, on ne peut pas utiliser uniquement f_plus_date pour le  */
	/* calcul de la date de référence                                   */
	/*------------------------------------------------------------------*/

		sUnite	= idw_Delai.GetItemString ( lLig, "UNT_DEL" )
		lDuree	= idw_Delai.GetItemNumber ( lLig, "DUR_MAX" )
		dDteDet 	= Date ( idw_wDetailFF.GetItemDateTime ( 1, "DTE_DET" ) )

		dDteSurv	= idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) 

		If sUnite = 'H' Then

	/*------------------------------------------------------------------*/
	/* on additionne les heures à la date du détail.                    */
	/* On commence par déterminer à combien de jours et d'heures        */
	/* correspond lDuree                                                */
	/*------------------------------------------------------------------*/

			lNbJour	=	Truncate ( ( lDuree / 24 ), 0 )		// Partie entière du nombre d'heures / 24
			lNbHeu	=	Mod ( lDuree, 24 )						// Reste de la division du nb heures / 24

			sHeuDet	=	idw_wDetailFF.GetItemString 	( 1, "HEU_DET" )		
			sHeuSurv	=	idw_wSin.GetItemString 			( 1, "HEU_SURV" )		

			If ( Not isNull ( sHeuDet  ) )					And	&
				( Not isNull ( sHeuSurv ) )					Then

				//lHeuDet	=  Long ( Left ( sHeuDet, 2 ) )
				lHeuSurv	=  Long ( Left ( sHeuSurv, 2 ) )
				lHeuMax  =  lHeuSurv + lNbHeu

	/*------------------------------------------------------------------*/
	/* Si le nombre d'heures obtenu dépasse une journée, on ajoute un   */
	/* jour et on enlève 24 heures à heuMax                             */
	/*------------------------------------------------------------------*/

				If lHeuMax > 23 Then

					lHeuMax 	= lHeuMax - 24
					lNbJour	++
				End If

				hHeuMax	= Time ( String ( lHeuMax ) + ':' + Right ( sHeuSurv, 2 ) )
				dDteMax	= F_Plus_Date ( dDteSurv, lNbJour, 'J' )

	/*------------------------------------------------------------------*/
	/* Conversion de dDteMax et hHeuMax en datetime pour comparaison    */
	/* avec dtSurv                                                      */
	/*------------------------------------------------------------------*/

				dtDteMax = DateTime ( dDteMax, hHeuMax )
				dtDet 	= DateTime ( dDteDet, Time ( Left ( sHeuDet, 2 ) + ':' + Right ( sHeuDet, 2 ) ) )

				If	dtDet > dtDteMax Then
	/*------------------------------------------------------------------*/
	/* La durée maximum est dépassée, on déclenche le refus 627.        */
	/*------------------------------------------------------------------*/
					bRet = Uf_RF_EcrireRefus ( 627 )
				End If

			Else

				dDteMax	= F_Plus_Date ( dDteSurv, lNbJour, 'J' )

				If	dDteDet > dDteMax	Then
		/*------------------------------------------------------------------*/
		/* La durée maximum est dépassée, on déclenche le refus 627.        */
		/*------------------------------------------------------------------*/
					bRet = Uf_RF_EcrireRefus ( 627 )
				End If
			End If

		Else

			dDteMax	= F_Plus_Date ( dDteSurv, lDuree, sUnite )

			If	dDteDet > dDteMax	Then
		/*------------------------------------------------------------------*/
		/* La durée maximum est dépassée, on déclenche le refus 627.        */
		/*------------------------------------------------------------------*/
				bRet = Uf_RF_EcrireRefus ( 627 )
			End If
		End If

	End If
Next
Return ( bRet )

end function

private subroutine uf_controlergestion_cle (ref string aspos);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerGestion_cle (PRIVATE)
//* Auteur			: JCA
//* Date				: 13/02/2007
//* Libellé			: 
//* Commentaires	: DCMP 060928	- Contrôle de complémentaire sur la garantie cle (id_gti = 1)
//*
//* Arguments		: String		asPos		Réf.
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*
//*-----------------------------------------------------------------

integer iIdDetail, iIdGti, iCodEtat, iRet

iIdGti = idw_wDetailFF.object.id_gti[1]
iCodEtat = idw_wDetailFF.object.cod_etat[1]

If iIdGti = 1 And ( iCodEtat = 100 Or iCodEtat = 500 ) Then
	stMessage.sTitre		= "Contrôle détail garantie"
	stMessage.Bouton		= YesNo!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "WDET510"

	iRet = f_Message ( stMessage )

	If iRet = 2 Then
		asPos = "LIB_DET"
	End If
End If

end subroutine

private subroutine uf_gestong_divers ();//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_sinistre_wdetail::uf_GestOng_Divers (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 16/06/2004 11:13:57
//* Libellé       : Gestion de l'onglet DIVERS
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    19/03/2008  Bug remonté par N. Béchéri
//*       JFF    15/01/2020  [VDOC28827]/[VDOC28866]
//        JFF    08/10/2024  [MCO194]
//*-----------------------------------------------------------------

Long lTotParam, lCptParam, lCptDivD, lRowDS, lRowDP, lTotDivD, lNull, lCptVal, lTotVal, lRowChild, lCodEtat, lIdGti
String	sNomZoneP, sNomZoneS, sIdTypListe, sNull, sAltLstCodeCar 
Decimal  dcNull
Date		dNull
Datetime dtNull	// [PI056].20190926
DataWindowChild	dwChildCodeCar, dwChildCode

SetNull ( dNull )
SetNull ( lNull )
SetNull ( sNull )
SetNull ( dcNull )
SetNull (dtNull)	// [PI056].20190926

lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )

idwDivPDet.SetFilter ( "ID_GTI = " + String ( lIdGti ) )
idwDivPDet.Filter ()

lCodEtat = idw_wDetailFF.GetItemNumber ( 1, "COD_ETAT" ) 

/*------------------------------------------------------------------*/
/* Affichage des lignes se trouvant dans la dw de param dw_div_pro. */
/*------------------------------------------------------------------*/
lTotParam = idwDivPDet.RowCount ()
lTotDivD  = idw_wDivDet.RowCount ()

If isTypeTrt = "S" Then
	For lCptParam = 1 To lTotParam

		sNomZoneP = Lower ( idwDivPDet.GetItemString ( lCptParam, "NOM_ZONE" ) )

		lRowDS	 = idw_wDivDet.Find ( "Lower ( NOM_ZONE ) = '" + sNomZoneP + "'", 1, lTotDivD ) 

	/*------------------------------------------------------------------*/
	/* Le row n'est pas trouvé, donc on l'insère                        */
	/*------------------------------------------------------------------*/
		If lRowDS <= 0 Then
			lRowDS = idw_wDivDet.InsertRow (0)

			idw_wDivDet.SetItem ( lRowDS, "ID_SIN", idw_wSin.GetItemNumber ( 1, "ID_SIN" ) )
			idw_wDivDet.SetItem ( lRowDS, "ID_GTI", idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )
			idw_wDivDet.SetItem ( lRowDS, "ID_DETAIL", idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )
			idw_wDivDet.SetItem ( lRowDS, "NOM_ZONE", sNomZoneP )
			idw_wDivDet.SetItem ( lRowDS, "LIB_LABEL", idwDivPDet.GetItemString ( lCptParam, "LIB_LABEL" ) )
			idw_wDivDet.SetItem ( lRowDS, "ID_TYP_LISTE", idwDivPDet.GetItemString ( lCptParam, "ID_TYP_LISTE" ) )
			idw_wDivDet.SetItem ( lRowDS, "ALT_LISTE_CODECAR", idwDivPDet.GetItemString ( lCptParam, "ALT_LISTE_CODECAR" ) )
			idw_wDivDet.SetItem ( lRowDS, "ID_TYP_ZONE", idwDivPDet.GetItemString ( lCptParam, "ID_TYP_ZONE" ) )
			idw_wDivDet.SetItem ( lRowDS, "ALT_OBLIG", idwDivPDet.GetItemString ( lCptParam, "ALT_OBLIG" ) )
			idw_wDivDet.SetItem ( lRowDS, "ALT_PROT", "N" )
			idw_wDivDet.SetItem ( lRowDS, "CPT_TRI", idwDivPDet.GetItemNumber ( lCptParam, "CPT_TRI" ) )
			idw_wDivDet.SetItem ( lRowDS, "VAL_DTE", dtNull )	// [PI056].20190926
			idw_wDivDet.SetItem ( lRowDS, "VAL_CAR", sNull )
			idw_wDivDet.SetItem ( lRowDS, "VAL_NBRE", lNull )
			idw_wDivDet.SetItem ( lRowDS, "VAL_MT", dcNull )
			idw_wDivDet.SetItem ( lRowDS, "ALT_SUPP", "O" )
			idw_wDivDet.SetItem ( lRowDS, "CREE_LE", DateTime ( Today (), Now () ) )
			idw_wDivDet.SetItem ( lRowDS, "MAJ_LE", DateTime ( Today (), Now () ) )
			idw_wDivDet.SetItem ( lRowDS, "MAJ_PAR", stGlb.sCodOper )

			Choose Case idwDivPDet.GetItemString ( lCptParam, "ID_TYP_ZONE" )
				Case "P", "S"
					idw_wDivDet.SetItem ( lRowDS, "VAL_MT", 0 )
				Case "N"
					idw_wDivDet.SetItem ( lRowDS, "VAL_NBRE", 0 )
				Case "X"
					idw_wDivDet.SetItem ( lRowDS, "VAL_CAR", "N" )
			End Choose 

//			A voir plus tard si nécessaire.
//			This.uf_GestOng_Divers_DefautZone ( sNomZoneP , idw_wSin.GetItemNumber ( 1, "ID_PROD" ), lRowDS )

		End If
	Next
End If
/*------------------------------------------------------------------*/
/* Suite à l'insertion dans idw_wDivDet des lignes manquantes, on   */
/* les mets maintenant à jour si besoin.                            */
/*------------------------------------------------------------------*/
lTotDivD  = idw_wDivDet.RowCount ()

idw_wDivDet.GetChild ( "VAL_LST_CAR", dwChildCodeCar )
dwChildCodeCar.Reset ()

idw_wDivDet.GetChild ( "VAL_LST_NBRE", dwChildCode )
dwChildCode.Reset ()


For lCptDivD = 1 To lTotDivD
	sIdTypListe = idw_wDivDet.GetItemString ( lCptDivD, "ID_TYP_LISTE" ) 

/*---------------------------------------------------------------------*/
/* Liste à charger : Cette Technique de chargement permet d'utiliser   */
/* plusieurs liste du même type (liste de code_car par exemple)		  */
/*---------------------------------------------------------------------*/
	If sIdTypListe <> "-1" Then
		sAltLstCodeCar = idw_wDivDet.GetItemString ( lCptDivD, "ALT_LISTE_CODECAR" ) 
		Choose Case sAltLstCodeCar 

			// Retrieve sur Code_Car
			Case "O"

				idddw_CodeCar_wDivDet_Charg_Tempo.Retrieve ( sIdTypListe )

				// [VDOC28827] et [VDOC28866]
//				Permet d'exclure des valeur la liste charger, en fct param sur DetPro
//				[MCO194] id_rev
				This.uf_GestOng_Divers_CasPart_Liste ( idw_wDivDet.GetItemString ( lCptDivD, "NOM_ZONE" ), &
																	idw_wSin.GetItemNumber ( 1, "ID_PROD" ), &
																	idw_wSin.GetItemNumber ( 1, "ID_REV" ), &
																	lIdGti  )
				
				lTotVal = idddw_CodeCar_wDivDet_Charg_Tempo.RowCount ()
							
				For lCptVal = 1 To lTotVal
					lRowChild = dwChildCodeCar.InsertRow ( 0 )
					dwChildCodeCar.SetItem ( lRowChild, "ID_CODE", idddw_CodeCar_wDivDet_Charg_Tempo.GetItemString ( lCptVal, "ID_CODE" ) )
					dwChildCodeCar.SetItem ( lRowChild, "LIB_CODE", idddw_CodeCar_wDivDet_Charg_Tempo.GetItemString ( lCptVal, "LIB_CODE" ) )
					dwChildCodeCar.SetItem ( lRowChild, "NOM_ZONE", idw_wDivDet.GetItemString ( lCptDivD, "NOM_ZONE" ) )
					dwChildCodeCar.SetItem ( lRowChild, "ALT_VISIBLE", 2 ) 
				Next

			// Retrieve sur Code
			Case "N"			

				idddw_Code_wDivDet_Charg_Tempo.Retrieve ( sIdTypListe )

				// [VDOC28827] et [VDOC28866]
//				Permet d'exclure des valeur la liste charger, en fct param sur DetPro
//				[MCO194] id_rev
				This.uf_GestOng_Divers_CasPart_Liste ( idw_wDivDet.GetItemString ( lCptDivD, "NOM_ZONE" ), &
																	idw_wSin.GetItemNumber ( 1, "ID_PROD" ), &
																	idw_wSin.GetItemNumber ( 1, "ID_REV" ), &
																	lIdGti )


				lTotVal = idddw_Code_wDivDet_Charg_Tempo.RowCount ()

				For lCptVal = 1 To lTotVal
					lRowChild = dwChildCode.InsertRow ( 0 )
					dwChildCode.SetItem ( lRowChild, "ID_CODE", idddw_Code_wDivDet_Charg_Tempo.GetItemNumber ( lCptVal, "ID_CODE" ) )
					dwChildCode.SetItem ( lRowChild, "LIB_CODE", idddw_Code_wDivDet_Charg_Tempo.GetItemString ( lCptVal, "LIB_CODE" ) )
					dwChildCode.SetItem ( lRowChild, "NOM_ZONE", idw_wDivDet.GetItemString ( lCptDivD, "NOM_ZONE" ) )
					dwChildCode.SetItem ( lRowChild, "ALT_VISIBLE", 2 ) 
				Next

		End Choose
	End If
Next

/*------------------------------------------------------------------*/
/* Il est impossible de protéger par 'protect=1' toutes lignes et   */
/* col d'une dw, au moins une zone doit avoir le focus.             */
/*------------------------------------------------------------------*/
If lTotDivD > 0 Then
	lRowDS = idw_wDivDet.InsertRow (0)
	idw_wDivDet.SetItem ( lRowDS, "ID_SIN", idw_wSin.GetItemNumber ( 1, "ID_SIN" ) )
	idw_wDivDet.SetItem ( lRowDS, "NOM_ZONE", "X_TEMPO_X" )
	idw_wDivDet.SetItem ( lRowDS, "LIB_LABEL", "" )
	idw_wDivDet.SetItem ( lRowDS, "ID_TYP_ZONE", "X" )
	idw_wDivDet.SetItem ( lRowDS, "ALT_OBLIG", "N" )
	idw_wDivDet.SetItem ( lRowDS, "ALT_PROT", "N" )
	idw_wDivDet.SetItem ( lRowDS, "CPT_TRI", 10000 )
	idw_wDivDet.SetItem ( lRowDS, "VAL_CAR", "O" )

	idw_wDivDet.SetRow ( lRowDs )
End If

idw_wDivDet.Sort ()

/*------------------------------------------------------------------*/
/* Protection des zones dynamique de dw_w_Div_Sin en Validation.    */
/* Attention, on ne protége par le dernier élément déplacé à X=10000*/
/*------------------------------------------------------------------*/
If isTypeTrt <> "S" Or lCodEtat = 600 OR lCodEtat = 900 Or lCodEtat = 200 Then
	lTotDivD = idw_wDivDet.rowcount() 
	For lCptDivD = 1 to lTotDivD 
		idw_wDivDet.SetItem ( lCptDivD ,"ALT_PROT", "O" )
		
	Next
End If

If isTypeTrt = "S" And lCodEtat = 100 Then
	lTotDivD = idw_wDivDet.rowcount() 
	For lCptDivD = 1 to lTotDivD 

		// #1 Attention, uniquement les zones pouvant être déprotégées.
		Choose Case lower ( idw_wDivDet.GetItemString ( lCptDivD, "NOM_ZONE" ) )
			Case "pec_redresse", "alt_plaf_pec", "cod_action", "alt_modif"
				// Elles devraient normalement être déjà protégé, mais on les reprotège pour en être certain
				idw_wDivDet.SetItem ( lCptDivD ,"ALT_PROT", "O" )				
			Case Else 
				// pour toutes les autres, on déprotège.
				idw_wDivDet.SetItem ( lCptDivD ,"ALT_PROT", "N" )				
		End Choose
	Next
End If

If isTypeTrt = "S" Then This.uf_GestOng_Divers_CasPart_Finaux ()

idw_wDivDet.SetRow ( idw_wDivDet.rowcount())

idwDivPDet.SetFilter ( "" )
idwDivPDet.Filter ()

end subroutine

private function string uf_gestion_cond_plaf_671_675 ();//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_sinistre_wdetail::uf_Gestion_cond_plaf_671_675 (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 16/06/2004 11:13:57
//* Libellé       : Vérifie si le Tel commandé est le même que celui sinistré.
//* Commentaires  : [DCMP070059]
//*
//* Arguments     : 
//*
//* Retourne      : String		asCas		Val   "MOB_SINISTRE_=_MOB_COMMANDE"/"AUTRE_CAS"
//*						
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

String sRech, sIdGti, sIdDetail, sMarqPortSin, sModlPortSin, sRetour 

sRetour = "AUTRE_CAS"

sMarqPortSin = Upper( idw_Wsin.GetItemString ( 1, "MARQ_PORT" ) )
sModlPortSin = Upper ( idw_Wsin.GetItemString ( 1, "MODL_PORT" ) )

If IsNull ( sMarqPortSin ) Then sMarqPortSin = ""
If IsNull ( sModlPortSin ) Then sModlPortSin = ""

sIdGti = String ( idw_WDetailFF.GetItemNumber ( 1, "ID_GTI" ) )
sIdDetail = String ( idw_WDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )

sRech = "ID_GTI = " + sIdGti + " AND " + &
		  "ID_DETAIL = "+ sIdDetail + " AND " + &
		  "ID_TYP_ART = 'TEL' AND " + &
		  "UPPER ( ID_MARQ_ART_IFR ) = '" + sMarqPortSin + "' AND " + &
		  "UPPER ( ID_MODL_ART_IFR ) = '" + sModlPortSin + "' AND " + &
		  "COD_ETAT = 'RPC'"
	

If idw_LstCmdeSin.Find ( sRech, 1, idw_LstCmdeSin.RowCount () ) > 0 Then
	sRetour = "MOB_SINISTRE_=_MOB_COMMANDE"
End If

Return sRetour

end function

private function string uf_plaf_nbev_gti_adherent_renouvellement ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbEvt_Gti_Adherent_Renouvellement (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 28/09/2005 
//* Libellé			: 
//* Commentaires	: Application d'un plafond par adhérent/Renouvellement (Nbre evt par année)
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	FPI		01/10/2009	[DCMP090539] Correction calcul nb evt
//* #2   FPI      05/03/2010  [20100305140001227] Correctif calcul de plafond (nb de détails)
//*      JFF      27/07/2011  [PLAF_REF]			
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------


Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale, lCptMax
Int iNbAutSin, iSinEnCours
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafSav
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdEvt, dcIdsDos
Decimal{2} 	dcPlafTmp
String		sIdNivPlaf, sIdRefPlaf
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sIdPara, sCptVer
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh

sPos = ""
/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '705'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdsDos		= idw_wSin.GetItemNumber ( 1, "ID_SDOS" )
	dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
	dcIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
	sUntPerRnv_Adh		= idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
/*---------------------------------------------------------------------*/
/* On calcule la date du dernier renouvellement.                       */
/*En fonction de l'unité de periode de renouvellement (ANNEE,MOIS,JOUR)*/
/*---------------------------------------------------------------------*/
   Choose Case sUntPerRnv_Adh
	   Case "A"
	     lCptMax = 30
	   Case "M"
	     lCptMax = 360
	   Case "J"
	    lCptMax = 10950
	End Choose
	
	For	lCpt = 1 To lCptMax
			dDteResult = F_Plus_Date ( dDteAdh, dcDurPerRnv_Adh, sUntPerRnv_Adh )
			If	dDteResult <= idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )	Then
				dDteAdh = dDteResult
			Else
				Exit
			End If
	Next

	dtDteAdhRenouv 	= DateTime ( dDteAdh )
				
	iNbAutSin= 0

	itrTrans.PS_S10_W_DETAIL_NBEVT ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, dcIdGti, dcIdEvt, dtDteSurv, dtDteAdhRenouv, iNbAutSin)

	If	Not F_Procedure ( stMessage, itrTrans, "PS_S10_W_DETAIL_NBEVT" )	Then 
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée, on affiche le message.             */
/*------------------------------------------------------------------*/
		f_Message ( stMessage )
		sPos = "MT_PREJ"
	Else
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		// #1 - [DCMP090539]
		//iSinEnCours		= 1
		lIdDetail = idw_wdetailff.GetItemNumber(1,"ID_DETAIL")
		
		// #2 [20100305140001227] 
/*
		iSinEnCours		= Integer(idw_lstdetail.describe( &
			"Evaluate('sum(if(id_detail <>" +	string(lIdDetail) + ",1,0) for all)',0)")) 	
*/			
		iSinEnCours		= Integer(idw_lstdetail.describe( &
			"Evaluate('sum(if(id_evt = " + String ( dcIdEvt ) + " and  id_detail <>" +	string(lIdDetail) + ",1,0) for all)',0)")) 	
		// :#2 [20100305140001227] 		
		
		iSinEnCours++ 											
		// Fin #1 - [DCMP090539]
		
		If	iSinEnCours + iNbAutSin > dcPlafond	Then
			idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "705", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "705", "NORMAL" )
		
		End If
	End If
End If

	
Return ( sPos )

end function

private function string uf_plaf_nbev_gti_adherent_survenance ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbEv_Gti_Adherent_Survenance (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 28/09/2005 
//* Libellé			: 
//* Commentaires	: Application d'un plafond par adhérent/Année survenance glissante (Nbre evt par année)
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	FPI		01/10/2009	[DCMP090539] Correction calcul nb evt
//* #2   FPI      05/03/2010  [20100305140001227] Correctif calcul de plafond (nb de détails)
//*      JFF      27/07/2011  [PLAF_REF]			
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------


Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale
Int iNbAutSin, iSinEnCours
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafSav
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdEvt, dcIdsDos
Decimal{2} 	dcPlafTmp
String		sIdNivPlaf, sIdRefPlaf

DateTime dtDteSurv

String sRech, sPos, sIdAdh, sIdPara, sCptVer

sPos = ""
/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '703'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdsDos		= idw_wSin.GetItemNumber ( 1, "ID_SDOS" )
	dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
	dcIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	iNbAutSin= 0

	itrTrans.PS_S08_W_DETAIL_NBEVT ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, dcIdGti, dcIdEvt, dtDteSurv, iNbAutSin)

	If	Not F_Procedure ( stMessage, itrTrans, "PS_S08_W_DETAIL_NBSIN" )	Then 
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée, on affiche le message.             */
/*------------------------------------------------------------------*/
		f_Message ( stMessage )
		sPos = "MT_PREJ"
	Else
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		
		// #1 - [DCMP090539]
		//iSinEnCours		= 1
		lIdDetail = idw_wdetailff.GetItemNumber(1,"ID_DETAIL")
		
		// #2 [20100305140001227] 
/*
		iSinEnCours		= Integer(idw_lstdetail.describe( &
			"Evaluate('sum(if(id_detail <>" +	string(lIdDetail) + ",1,0) for all)',0)")) 	
*/			
		iSinEnCours		= Integer(idw_lstdetail.describe( &
			"Evaluate('sum(if(id_evt = " + String ( dcIdEvt ) + " and  id_detail <>" +	string(lIdDetail) + ",1,0) for all)',0)")) 	
		// :#2 [20100305140001227] 
		
		iSinEnCours++ 											
		// Fin #1 - [DCMP090539]
		
		If	iSinEnCours + iNbAutSin > dcPlafond	Then
			idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "703", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "703", "NORMAL" )
			
		End If
	End If
End If
	
Return ( sPos )

end function

private function string uf_plaf_nbev_gti_adhesion_renouvellement ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbEvUf_Plaf_NbEv_Gti_Adhesion_Renouvellement_Adhesion_Renouvellement (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 28/09/2005 
//* Libellé			: 
//* Commentaires	: Application d'un plafond par adhésion/Renouvellement (Nbre evt par année)
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	FPI		01/10/2009	[DCMP090539] Correction calcul nb evt
//* #2   JFF      05/03/2010  [20100305140001227] Correctif important
//*      JFF      27/07/2011  [PLAF_REF]			
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale, lCptMax
Int iNbAutSin, iSinEnCours
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafSav
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdEvt
Decimal{2} 	dcPlafTmp
String		sIdNivPlaf, sIdRefPlaf
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sIdPara, sCptVer
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh

sPos = ""
/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '704'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
	dcIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
	sUntPerRnv_Adh		= idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
/*---------------------------------------------------------------------*/
/* On calcule la date du dernier renouvellement.                       */
/*En fonction de l'unité de periode de renouvellement (ANNEE,MOIS,JOUR)*/
/*---------------------------------------------------------------------*/
   Choose Case sUntPerRnv_Adh
	   Case "A"
	     lCptMax = 30
	   Case "M"
	     lCptMax = 360
	   Case "J"
	    lCptMax = 10950
	End Choose

	For	lCpt = 1 To lCptMax
			dDteResult = F_Plus_Date ( dDteAdh, dcDurPerRnv_Adh, sUntPerRnv_Adh )
			If	dDteResult <= idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )	Then
				dDteAdh = dDteResult
			Else
				Exit
			End If
	Next
	dtDteAdhRenouv 	= DateTime ( dDteAdh )
				
	iNbAutSin= 0

	itrTrans.PS_S09_W_DETAIL_NBEVT ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, dcIdEvt, dtDteSurv, dtDteAdhRenouv, iNbAutSin)


	If	Not F_Procedure ( stMessage, itrTrans, "PS_S09_W_DETAIL_NBSIN" )	Then 
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée, on affiche le message.             */
/*------------------------------------------------------------------*/
		f_Message ( stMessage )
		sPos = "MT_PREJ"
	Else
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		
		// #1 - [DCMP090539]
		//iSinEnCours		= 1
		lIdDetail = idw_wdetailff.GetItemNumber(1,"ID_DETAIL")

		// #2 [20100305140001227] Correctif important
/*
		iSinEnCours		= Integer(idw_lstdetail.describe( &
			"Evaluate('sum(if(id_detail <>" +	string(lIdDetail) + ",1,0) for all)',0)")) 	
*/			
		iSinEnCours		= Integer(idw_lstdetail.describe( &
			"Evaluate('sum(if(id_evt = " + String ( dcIdEvt ) + " and  id_detail <>" +	string(lIdDetail) + ",1,0) for all)',0)")) 	
		// :#2 [20100305140001227] Correctif important			
		
		iSinEnCours++ 											
		// Fin #1 - [DCMP090539]
		
		If	iSinEnCours + iNbAutSin > dcPlafond	Then
			idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "704", sIdPara, sCptVer )
			
			// [PLAF_REF]// [VDOC6662]
			sPos = Uf_Plaf_Refus ( "704", "NORMAL" )
			
		End If

	End If
End If

	
Return ( sPos )

end function

private function string uf_plaf_nbev_gti_adhesion_survenance ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbEv_Gti_Adhesion_Survenance (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 28/09/2005 
//* Libellé			: 
//* Commentaires	: Application d'un plafond par adhésion/Année survenace glissante (Nbre evt par année)
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	FPI		01/10/2009	[DCMP090539] Correction calcul nb evt
//* #2   FPI      05/03/2010  [20100305140001227] Correctif calcul de plafond (nb de détails)
//*      JFF      27/07/2011  [PLAF_REF]			
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------


Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale
Int iNbAutSin, iSinEnCours
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafSav
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdEvt
Decimal{2} 	dcPlafTmp
String		sIdNivPlaf, sIdRefPlaf

DateTime dtDteSurv

String sRech, sPos, sIdAdh, sIdPara, sCptVer

sPos = ""
/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '702'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
	dcIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	iNbAutSin= 0

	itrTrans.PS_S07_W_DETAIL_NBEVT ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, dcIdEvt, dtDteSurv, iNbAutSin)

	If	Not F_Procedure ( stMessage, itrTrans, "PS_S07_W_DETAIL_NBSIN" )	Then 
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée, on affiche le message.             */
/*------------------------------------------------------------------*/
		f_Message ( stMessage )
		sPos = "MT_PREJ"
	Else
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		// #1 - [DCMP090539]
		//iSinEnCours		= 1
		lIdDetail = idw_wdetailff.GetItemNumber(1,"ID_DETAIL")
		
		// #2 [20100305140001227] 
/*
		iSinEnCours		= Integer(idw_lstdetail.describe( &
			"Evaluate('sum(if(id_detail <>" +	string(lIdDetail) + ",1,0) for all)',0)")) 	
*/			
		iSinEnCours		= Integer(idw_lstdetail.describe( &
			"Evaluate('sum(if(id_evt = " + String ( dcIdEvt ) + " and  id_detail <>" +	string(lIdDetail) + ",1,0) for all)',0)")) 	
		// :#2 [20100305140001227]
		
		iSinEnCours++ 											
		// Fin #1 - [DCMP090539]
		
		If	iSinEnCours + iNbAutSin > dcPlafond	Then
			idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "702", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "702", "NORMAL" )
			
		End If
	End If
End If

	
Return ( sPos )

end function

private function string uf_plaf_nbev_sin_adherent_renouvellement ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbEv_Sin_Adherent_Renouvellement (PRIVATE)
//* Auteur			: PHG, d'après Fabry JF
//* Date				: 13/04/2007
//* Libellé			: 
//* Commentaires	: Application d'un plafond par adhérent/Renouvellement (Nbre evt par année)
//*					  Recherche des evenement au niveau Sinistre et non pas Gti
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	FPI		01/10/2009	[DCMP090539] Correction calcul nb evt
//* #2   FPI      05/03/2010  [20100305140001227] Correctif calcul de plafond (nb de détails)
//*      JFF      27/07/2011  [PLAF_REF]			
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------
//* [DCMP060777] PHG 13/04/2007 
//*		Recopie de le fonction
//* 		Uf_Plaf_NbEvt_Gti_Adherent_Renouvellement en
//* 		Uf_Plaf_NbEvt_Sin_Adherent_Renouvellement
//*

Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale, lCptMax
Int iNbAutSin, iSinEnCours
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafSav
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdEvt, dcIdsDos
Decimal{2} 	dcPlafTmp
String		sIdNivPlaf, sIdRefPlaf
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sIdPara, sCptVer
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh

sPos = ""
/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '" + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '710'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdsDos		= idw_wSin.GetItemNumber ( 1, "ID_SDOS" )
	dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
	dcIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
	sUntPerRnv_Adh		= idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
/*---------------------------------------------------------------------*/
/* On calcule la date du dernier renouvellement.                       */
/*En fonction de l'unité de periode de renouvellement (ANNEE,MOIS,JOUR)*/
/*---------------------------------------------------------------------*/
   Choose Case sUntPerRnv_Adh
	   Case "A"
	     lCptMax = 30
	   Case "M"
	     lCptMax = 360
	   Case "J"
	    lCptMax = 10950
	End Choose
	For	lCpt = 1 To lCptMax
			dDteResult = F_Plus_Date ( dDteAdh, dcDurPerRnv_Adh, sUntPerRnv_Adh )
			If	dDteResult <= idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )	Then
				dDteAdh = dDteResult
			Else
				Exit
			End If
	Next

	dtDteAdhRenouv 	= DateTime ( dDteAdh )
				
	iNbAutSin= 0
	
// [DCMP060777] TODO : Tester la procstock
	itrTrans.PS_S14_W_DETAIL_NBEVT ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, /*dcIdGti,*/ dcIdEvt, dtDteSurv, dtDteAdhRenouv, iNbAutSin)

	If	Not F_Procedure ( stMessage, itrTrans, "PS_S14_W_DETAIL_NBEVT" )	Then 
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée, on affiche le message.             */
/*------------------------------------------------------------------*/
		f_Message ( stMessage )
		sPos = "MT_PREJ"
	Else
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		
		// #1 - [DCMP090539]
		//iSinEnCours		= 1
		lIdDetail = idw_wdetailff.GetItemNumber(1,"ID_DETAIL")
		
		// #2 [20100305140001227] 
/*
		iSinEnCours		= Integer(idw_lstdetail.describe( &
			"Evaluate('sum(if(id_detail <>" +	string(lIdDetail) + ",1,0) for all)',0)")) 	
*/			
		iSinEnCours		= Integer(idw_lstdetail.describe( &
			"Evaluate('sum(if(id_evt = " + String ( dcIdEvt ) + " and  id_detail <>" +	string(lIdDetail) + ",1,0) for all)',0)")) 	
		// :#2 [20100305140001227]
		
		iSinEnCours++ 											
		// Fin #1 - [DCMP090539]
		
		If	iSinEnCours + iNbAutSin > dcPlafond	Then
			idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "710", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "710", "NORMAL" )
			
			
		End If
	End If
End If

	
Return ( sPos )

end function

private function string uf_plaf_nbev_sin_adherent_survenance ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbEv_Sin_Adherent_Survenance (PRIVATE)
//* Auteur			: PHG, d'après Fabry JF
//* Date				: 13/04/2007 
//* Libellé			: 
//* Commentaires	: Application d'un plafond par adhérent/Année survenance glissante (Nbre evt par année)
//*					  Toute garantie confondue
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	FPI		01/10/2009	[DCMP090539] Correction calcul nb evt
//* #2   FPI      05/03/2010  [20100305140001227] Correctif calcul de plafond (nb de détails)
//*      JFF      27/07/2011  [PLAF_REF]			
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------
//* [DCMP060777] PHG 13/04/2007 

Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale
Int iNbAutSin, iSinEnCours
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafSav
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdEvt, dcIdsDos
Decimal{2} 	dcPlafTmp
String		sIdNivPlaf, sIdRefPlaf

DateTime dtDteSurv

String sRech, sPos, sIdAdh, sIdPara, sCptVer

sPos = ""
/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '708'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdsDos		= idw_wSin.GetItemNumber ( 1, "ID_SDOS" )
	dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
	dcIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	iNbAutSin= 0

// [DCMP060777]TODO : Tester procstock
	itrTrans.PS_S12_W_DETAIL_NBEVT ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, /*dcIdGti,*/ dcIdEvt, dtDteSurv, iNbAutSin)

	If	Not F_Procedure ( stMessage, itrTrans, "PS_S12_W_DETAIL_NBSIN" )	Then 
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée, on affiche le message.             */
/*------------------------------------------------------------------*/
		f_Message ( stMessage )
		sPos = "MT_PREJ"
	Else
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		
		// #1 - [DCMP090539]
		//iSinEnCours		= 1
		lIdDetail = idw_wdetailff.GetItemNumber(1,"ID_DETAIL")
		
		// #2 [20100305140001227] 
/*
		iSinEnCours		= Integer(idw_lstdetail.describe( &
			"Evaluate('sum(if(id_detail <>" +	string(lIdDetail) + ",1,0) for all)',0)")) 	
*/			
		iSinEnCours		= Integer(idw_lstdetail.describe( &
			"Evaluate('sum(if(id_evt = " + String ( dcIdEvt ) + " and  id_detail <>" +	string(lIdDetail) + ",1,0) for all)',0)")) 	
		// :#2 [20100305140001227] 
		
		iSinEnCours++ 											
		// Fin #1 - [DCMP090539]
		
		If	iSinEnCours + iNbAutSin > dcPlafond	Then
			idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "708", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "708", "NORMAL" )
			
		End If
	End If
End If

	
Return ( sPos )

end function

private function string uf_plaf_nbev_sin_adhesion_renouvellement ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbEv_Sin_Adhesion_Renouvellement (PRIVATE)
//* Auteur			: PHG, d'après Fabry JF
//* Date				: 13/04/2007
//* Libellé			: 
//* Commentaires	: Application d'un plafond par adhésion/Renouvellement (Nbre evt par année)
//*					  toute garantie confondue
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	FPI		01/10/2009	[DCMP090539] Correction calcul nb evt
//* #2   FPI      05/03/2010  [20100305140001227] Correctif calcul de plafond (nb de détails)
//*      JFF      27/07/2011  [PLAF_REF]			
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------
//* [DCMP060777] PHG 13/04/2007 

Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale, lCptMax
Int iNbAutSin, iSinEnCours
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafSav
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdEvt
Decimal{2} 	dcPlafTmp
String		sIdNivPlaf, sIdRefPlaf
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sIdPara, sCptVer
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh

sPos = ""
/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '709'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
	dcIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
	sUntPerRnv_Adh		= idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
/*---------------------------------------------------------------------*/
/* On calcule la date du dernier renouvellement.                       */
/*En fonction de l'unité de periode de renouvellement (ANNEE,MOIS,JOUR)*/
/*---------------------------------------------------------------------*/
   Choose Case sUntPerRnv_Adh
	   Case "A"
	     lCptMax = 30
	   Case "M"
	     lCptMax = 360
	   Case "J"
	    lCptMax = 10950
	End Choose

	For	lCpt = 1 To lCptMax
			dDteResult = F_Plus_Date ( dDteAdh, dcDurPerRnv_Adh, sUntPerRnv_Adh )
			If	dDteResult <= idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )	Then
				dDteAdh = dDteResult
			Else
				Exit
			End If
	Next
	dtDteAdhRenouv 	= DateTime ( dDteAdh )
				
	iNbAutSin= 0

// [DCMP060777] TODO : Procstock a Tester
	itrTrans.PS_S13_W_DETAIL_NBEVT ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, /*dcIdGti,*/ dcIdEvt, dtDteSurv, dtDteAdhRenouv, iNbAutSin)

	If	Not F_Procedure ( stMessage, itrTrans, "PS_S13_W_DETAIL_NBSIN" )	Then 
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée, on affiche le message.             */
/*------------------------------------------------------------------*/
		f_Message ( stMessage )
		sPos = "MT_PREJ"
	Else
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		
		// #1 - [DCMP090539]
		//iSinEnCours		= 1
		lIdDetail = idw_wdetailff.GetItemNumber(1,"ID_DETAIL")
		
	// #2 [20100305140001227] 
/*
		iSinEnCours		= Integer(idw_lstdetail.describe( &
			"Evaluate('sum(if(id_detail <>" +	string(lIdDetail) + ",1,0) for all)',0)")) 	
*/			
		iSinEnCours		= Integer(idw_lstdetail.describe( &
			"Evaluate('sum(if(id_evt = " + String ( dcIdEvt ) + " and  id_detail <>" +	string(lIdDetail) + ",1,0) for all)',0)")) 	
		// :#2 [20100305140001227] 
		
		iSinEnCours++ 											
		// Fin #1 - [DCMP090539]
		
		If	iSinEnCours + iNbAutSin > dcPlafond	Then
			idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "709", sIdPara, sCptVer )

			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "709", "NORMAL" )
			
		End If

	End If
End If

	
Return ( sPos )

end function

private function string uf_plaf_nbev_sin_adhesion_survenance ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbEv_Gti_Adhesion_Survenance (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 28/09/2005 
//* Libellé			: 
//* Commentaires	: Application d'un plafond par adhésion/Année survenace glissante (Nbre evt par année)
//* 					  Toute Garantie Confondue
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	FPI		01/10/2009	[DCMP090539] Correction calcul nb evt
//* #2   FPI      05/03/2010  [20100305140001227] Correctif calcul de plafond (nb de détails)
//*      JFF      27/07/2011  [PLAF_REF]			
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------
//* [DCMP060777] PHG 13/04/2007 

Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale
Int iNbAutSin, iSinEnCours
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafSav
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdEvt
Decimal{2} 	dcPlafTmp
String		sIdNivPlaf, sIdRefPlaf

DateTime dtDteSurv

String sRech, sPos, sIdAdh, sIdPara, sCptVer

sPos = ""
/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '707'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
	dcIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	iNbAutSin= 0

	// [DCMP060777] TODO : Proc Stock a tester
	itrTrans.PS_S11_W_DETAIL_NBEVT ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, /*dcIdGti,*/ dcIdEvt, dtDteSurv, iNbAutSin)

	If	Not F_Procedure ( stMessage, itrTrans, "PS_S11_W_DETAIL_NBSIN" )	Then 
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée, on affiche le message.             */
/*------------------------------------------------------------------*/
		f_Message ( stMessage )
		sPos = "MT_PREJ"
	Else
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )

		// #1 - [DCMP090539]
		//iSinEnCours		= 1
		lIdDetail = idw_wdetailff.GetItemNumber(1,"ID_DETAIL")
		
	// #2 [20100305140001227] 
/*
		iSinEnCours		= Integer(idw_lstdetail.describe( &
			"Evaluate('sum(if(id_detail <>" +	string(lIdDetail) + ",1,0) for all)',0)")) 	
*/			
		iSinEnCours		= Integer(idw_lstdetail.describe( &
			"Evaluate('sum(if(id_evt = " + String ( dcIdEvt ) + " and  id_detail <>" +	string(lIdDetail) + ",1,0) for all)',0)")) 	
		// :#2 [20100305140001227] 	
		
		iSinEnCours++ 											
		// Fin #1 - [DCMP090539]

		If	iSinEnCours + iNbAutSin > dcPlafond	Then
			idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "707", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "707", "NORMAL" )
			
		End If
	End If
End If
	
Return ( sPos )

end function

private function long uf_zn_codmotssui ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_CodMotSsui (PRIVATE)
//* Auteur			: PHG
//* Date				: 26/04/2007
//* Libellé			: Controle de COD_MOT_SSUI ( Motif de classement sans suite )
//* Commentaires	: [DCMP070275] Creation uf_zn_codmotssui
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//       JFF   08/07/2013 [PC509-2]
//       JFF   10/08/2017 [MOTIF_SSUITE_90]
//*-----------------------------------------------------------------

long lAction = 0
string sData
sData = idw_wDetailFF.GetText()
if len(sData) > 0 then
	if Not this.uf_GetAutorisation(208) and 	&
			( 												&
				long(sData) = 3 or 					&
				long(sData) = 4 						&
			) 	then
			
		lACtion = 1
		idw_wDetailFF.iiErreur = 1
		
	End If
End If

// [PC509-2]
if lACtion = 0 And len(sData) > 0 then	
	If long(sData) = 11 Then
		lAction = 1
		idw_wDetailFF.iiErreur = 1
	End If
End If

// [MOTIF_SSUITE_90]
if lACtion = 0 And len(sData) > 0 then	
	If long(sData) = 90 Then
		lAction = 1
		idw_wDetailFF.iiErreur = 1
	End If
End If

return lAction



end function

public function boolean uf_controlergestion_donnee_pgc (long alidgti, long alidevt, ref string aspos, ref string astext);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_wdetail::uf_controlergestion_donnee_pgc
//* Auteur			: Pierre-Henri Gillot
//* Date				: 24/05/2007 17:16:35
//* Libellé			: [DCMP070284] Gestion PGC
//* Commentaires	: Controle la bonne saisie des données
//*					  indispensable au calcul de la PGC
//*					  ( Option 85, Prolongation Garantie Constructeur. )
//*
//* Arguments		: 	ref string aspos	
//* 						ref string astext	
//*
//* Retourne		: integer	: -1 Erreur, 1 Ok
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	JCA	23/10/2007	DCMP 70755 - Annulation du contrôle si detail existant pour garantie 15
//       JFF   22/11/2023 [RS6175_GC_SCRP_SIM2]
//*-----------------------------------------------------------------

boolean 	bRet = TRUE
boolean 	bPGCActif
long		lDeb, lFin, lCpt, lIdGti, lIdEvt, lIdProd, lFound, lDurGtiOrg
date 		dDteAchat
string 	sFindString

// pour décoincer les cas de problème en factu en attendant que je fasse la modif adéquat (JFF)
// Return True

// Si la personne a le rôle de facturation, on ressort.
If This.uf_GetAutorisation ( 208 ) Then Return True

// #1
string sFindGti
// on ne fait pas le controle si le detail est 200 : refusé, 600 : réglé, 900 : sans suite (hors detail en cours) 
sFindGti = "ID_GTI = " + string(idw_wDetailFF.object.id_gti[1]) + " AND ID_DETAIL <> " + string(idw_wDetailFF.object.id_detail[1]) + " AND COD_ETAT IN ( 200, 600, 900 )"
lFound = idw_LstDetail.Find( sFindGti, 1, idw_LstDetail.rowcount()) 

if lFound > 0 then return true
// FIN - #1

lIdProd = idw_wSin.GetItemNumber ( 1, "ID_PROD" )

F_RechDetPro ( lDeb, lFin, idw_DetPro, lIdProd, "-DP", K_DP85_GESTIONPGC )
bPGCActif = lDeb > 0
If bPGCActif Then
	For lCpt = lDeb To lFin 
		If	alIdGti = idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) &
			and alIdEvt = idw_DetPro.GetItemNumber ( lCpt, "VAL_NUM" ) Then
			// Controle Date d'achat
			// Selon l'option 42, on choisi d'aller lire dans la la fenetre des sinistre
			// ou dans la fenetre du detail.
			sFindString = 	" ID_PROD = " + string(lIdProd) + &
								" AND ID_TYP_CODE_DP = '-DP' AND ID_CODE_DP = 42 " + &
								" AND ID_CODE_NUM = " + string (alIdGti) + &
								" AND ID_CODE_CAR = 'A'"

			lFound = idw_DetPro.Find(sFindString, 1, idw_DetPro.rowCount()+1 )

			If lfound > 0 then
				dDteAchat = idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" )
			Else
				dDteAchat = Date(idw_wSin.GetItemDateTime ( 1, "DTE_ACH_PORT" ) ) // [PI056]
			End If

			If	IsNull ( dDteAchat ) Then
				asText = asText + " - La date d'achat" + "~n~r"
				If asPos = "" Then asPos = "DTE_DET_DATE"
				bret = FALSE
			End If

			// Controle Durée d'Origine
			// [RS6175_GC_SCRP_SIM2]
			sFindString = "UPPER(NOM_ZONE) = 'DUREE_GTI_ORIG'"
			
			lFound = idw_wDivSin.Find(sFindString, 1 , idw_wDivSin.RowCount())
			if lFound > 0 Then
				lDurGtiOrg = idw_wDivSin.object.val_nbre[lFound]
			End If  
			If lFound = 0 or lDurGtiOrg = 0 or IsNull(lDurGtiOrg) then
				asText = asText + " - La durée de garantie constructeur" + "~n~r"
				If asPos = "" Then asPos = "DTE_DET_DATE"
				bret = FALSE
			End If
		End If
		
		If Not bRet Then Exit
	Next
End If

return bRet



end function

private function boolean uf_rf_636 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_636 (PRIVATE)
//* Auteur			: PHG
//* Date				: 25/05/2007 15:07:49
//* Libellé			: [DCMP070284]
//* Commentaires	: REfus : Date de survenance couverte par la garantie Contructeur.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*     JFF  20/01/2011  [PC363].[PANNE_PGC]
// 		FPI	31/07/2013	[PC936] PGC exprimée en jours
//       JFF   22/11/2023 [RS6175_GC_SCRP_SIM2]
//*-----------------------------------------------------------------
Date 	  dDteSurv, dDteFinGC, dDteAchat
Boolean bRet, bGestionDateAchat, bOk
long	  lDeb, lFin, lCpt, lIdProd, lIdGti, lIdEvt, lDuGC, lRet, lRowDS
Int 	  iRefus
string  sRechDetPro[4] = &
	{	" ID_PROD = ", &
		" AND ID_TYP_CODE_DP = '-DP' AND ID_CODE_DP = ", &
		" AND ID_CODE_NUM = ", &
		" AND VAL_NUM = "}
string  sFindString
String sUnite, sValCar // [PC936]
n_cst_string lnvPFCString

//*------------------------------------------------------------------*/
//* On déclenche ce motif dans le cas de la garantie Prolongation    */
//* Garantie Constructeur. Si la date de Survenance est  Inférieure  */
//* à la Date D'achat + la durée de la GC => REfus 636		         */
//* Ex :																				   */
//* Pas de Refus 636
//* ---+=======---|------>
//*   Da DuGC		DSurv
//*
//* Refus 636
//*			 DSurv
//* ---+======|=--------->
//*   Da DuGC		
//*------------------------------------------------------------------*/

bRet = True

// [PC363].[PANNE_PGC]
lRowDS = idw_wDivSin.Find ( "UPPER ( NOM_ZONE ) = 'PGC_O2M' AND VAL_LST_CAR = 'O'", 1, idw_wDivSin.RowCount () )				
If lRowDS <= 0 Then 
	iRefus = 636 // Garantie Constructeur
Else 
	iRefus = 638 // Garantie O2M
End If
// [PC363].[PANNE_PGC]

lIdProd	= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
lIdGti	= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
lIdEvt	= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
dDteSurv = idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )

// L'Option K_DP85_GESTIONPGC est-elle présente pour le produit/gti/evt ?
sFindString =	sRechDetPro[1] + string (lIdProd) + sRechDetPro[2] + string(K_DP85_GESTIONPGC) &
					+ sRechDetPro[3] + string (lIdGti) + sRechDetPro[4] + string(lIdEvt)
lRet = idw_detpro.Find( sFindString, 1, idw_detpro.RowCount() )

if lRet > 0 then // Oui, on effectue le calcul du refus

	// [PC936]
	sValCar = idw_detpro.GetItemString( lRet, "VAL_CAR")
	sUnite=lnvPFCString.of_getkeyvalue( sValCar, "UNITE", ";")
	If sUnite="" Then sUnite="M" //en mois par défaut
	// :[PC936]

	// recherche de l'option 42 pour déterminer la lecture de la date d'achat.
	sFindString =	sRechDetPro[1] + string (lIdProd) + sRechDetPro[2] + "42" + &
						sRechDetPro[3] + string (lIdGti)
	lRet = idw_detpro.Find( sFindString, 1, idw_detpro.RowCount() )

	If lRet > 0 then
		dDteAchat = idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" )
	Else
		dDteAchat = Date(idw_wSin.GetItemDateTime ( 1, "DTE_ACH_PORT" ) ) // [PI056]
	End If
	// Lecture de la valeur de la durée de garantie d'origine (lDuGC)

	// [RS6175_GC_SCRP_SIM2]
	sFindString = "UPPER(NOM_ZONE) = 'DUREE_GTI_ORIG'"
	
	lRet = idw_wDivSin.Find(sFindString, 1 , idw_wDivSin.RowCount())
	if lRet > 0 And &
		( Not IsNull ( dDteSurv ) And Not IsNull ( lDuGC ) And Not Isnull(dDteAchat) ) Then
		
		lDuGC = idw_wDivSin.object.val_nbre[lRet]
		
		// [PC936]
		dDteFinGC = F_PLUS_DATE ( dDteAchat, lDuGC, sUnite )
		// :[PC936]
		
		If	dDteSurv < dDteFinGC	Then // Si date de surv < à la date de fin de GC, refus 636

			// [PC363].[PANNE_PGC]
			If iRefus = 638 Then

				stMessage.bErreurG	= FALSE
				stMessage.sTitre		= "Information"
				stMessage.Icon			= Information!
				stMessage.bouton		= Ok!
				stMessage.sCode 		= "WDET591" 
				f_Message ( stMessage )
				
			End If 
			// [PC363].[PANNE_PGC]
			
			bRet = Uf_RF_EcrireRefus ( iRefus )
		Else
			If	Not Uf_Rf_637 () Then	Return ( False )			
		End If
	End If
End If

Return ( bRet )

end function

private function boolean uf_rf_637 ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Rf_637 (PRIVATE)
//* Auteur			: PHG
//* Date				: 25/05/2007 15:07:49
//* Libellé			: [DCMP070284]
//* Commentaires	: REfus : Date de survenance au dela 
//*					  de la date de fin de la Garantie Constructeur prolongée.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF  09/07/07   Si GC non saisie, alors on ne déclenche pas le refus 637, vu avec Maryline le 09/07
// 		FPI	31/07/2013	[PC936] PGC exprimée en jours
//*-----------------------------------------------------------------
Date 	  dDteSurv, dDteFinGC, dDteAchat
Boolean bRet, bGestionDateAchat, bOk
long	  lDeb, lFin, lCpt, lIdProd, lIdGti, lIdEvt, lDuGC,lRet
long	  lGCMMin, lGCMMax, lDuPGC
string  sRechDetPro[4] = &
	{	" ID_PROD = ", &
		" AND ID_TYP_CODE_DP = '-DP' AND ID_CODE_DP = ", &
		" AND ID_CODE_NUM = ", &
		" AND VAL_NUM = "	}
string  sFindString, sValCar
n_cst_string lnvPFCString
String sUnite // [PC936]

//*------------------------------------------------------------------*/
//* On déclenche ce motif dans le cas de la garantie Prolongation    */
//* Garantie Constructeur. 
//* Si la date de Survenance est postérieur à la fin de la garantie
//* contrusteur Prolongée, Refus 637
//* Ex :																				   */
//* x => Durée de la prolongation de GC lue dans le paramétrage
//*		qui est fonction de la DuGC.
//* = => Durée de la Garantie Constructeur 
//* Pas de Refus 637
//* ---+=======xxxxx|x--------->
//*   Da 		     DSurv
//*
//* Refus 637
//* ---+=======xxxxxxx--|------>
//*   Da 		         DSurv
//*------------------------------------------------------------------*/
//       JFF   22/11/2023 [RS6175_GC_SCRP_SIM2]
//*------------------------------------------------------------------*/

bRet = True
lRet = 0

lIdProd	= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
lIdGti	= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
lIdEvt	= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
dDteSurv = idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )

// Lecture de la valeur de la durée de garantie d'origine (lDuGC)
if isvalid(idw_wDivSin) then
	
	// [RS6175_GC_SCRP_SIM2]
	sFindString = "UPPER(NOM_ZONE) = 'DUREE_GTI_ORIG'"
	
	lRet = idw_wDivSin.Find(sFindString, 1 , idw_wDivSin.RowCount())
End If

if lRet > 0 then // Si trouvée, on continue le calcul du refus
	lDuGC = idw_wDivSin.object.val_nbre[lRet] // d'abord Memorisation de la DuGC

	// #1
	If IsNull ( lDuGC ) Or lDuGC = 0 Then
		Return True
	End If

	// Lecture de la Prolongation de Garantie Constructeur
	// On cherche quelle est la Durée de PGC a appliquer
	// en fonction de la DuGC et du paramétrage :
	// DuPGC trouvée quand :
	// DuGC >= à la durée  minimale de DuGc pour application prolongation (lGCMMin)
	// DuGC <= à la durée  maximale de DuGc pour application prolongation (lGCMMax)
	
	// ... Lecture de l'option K_DP85_GESTIONPGC
	sFindString =	sRechDetPro[1] + string (lIdProd) + sRechDetPro[2] + string(K_DP85_GESTIONPGC) &
						+ sRechDetPro[3] + string (lIdGti) + sRechDetPro[4] + string(lIdEvt)
	lRet = idw_detpro.Find( sFindString, 1, idw_detpro.RowCount()+1 )
	
	If lRet > 0 Then
		do
			lGCMMin = 0; lGCMMax = 0; lDuPGC = 0 // Réinit
			sValCar = idw_detpro.GetItemString( lRet, "VAL_CAR")
		
			// [PC936]
			sUnite=lnvPFCString.of_getkeyvalue( sValCar, "UNITE", ";")
			Choose Case sUnite
				Case "J"
					lGCMMin = long ( lnvPFCString.of_getkeyvalue( sValCar, "GC_JOUR_MIN", ";"))
					lGCMMax = long ( lnvPFCString.of_getkeyvalue( sValCar, "GC_JOUR_MAX", ";"))
					lDuPGC  = long ( lnvPFCString.of_getkeyvalue( sValCar, "PGC_JOUR", ";"))
				Case Else // en mois par défaut
					lGCMMin = long ( lnvPFCString.of_getkeyvalue( sValCar, "GC_MOIS_MIN", ";"))
					lGCMMax = long ( lnvPFCString.of_getkeyvalue( sValCar, "GC_MOIS_MAX", ";"))
					lDuPGC  = long ( lnvPFCString.of_getkeyvalue( sValCar, "PGC_MOIS", ";"))
					sUnite="M"
			End choose
			// :[PC936]
	
			if lDuGC >= lGCMMin and lDuGC <= lGCMMax then
				lRet = -10 // -10 : Indiqe que c'est trouvé
			else
				lRet = idw_detpro.Find( sFindString, lRet+1, idw_detpro.RowCount()+1 )
			End IF
		loop until lRet <= 0 
		
		if lRet = -10 then
			// recherche de l'option 42 pour déterminer la lecture de la date d'achat.
			sFindString =	sRechDetPro[1] + string (lIdProd) + sRechDetPro[2] + "42" + &
								sRechDetPro[3] + string (lIdGti)
			lRet = idw_detpro.Find( sFindString, 1, idw_detpro.RowCount() )
		
			If lRet > 0 then
				dDteAchat = idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" )
			Else
				dDteAchat = Date(idw_wSin.GetItemDateTime ( 1, "DTE_ACH_PORT" ) ) // [PI056]
			End If
			
			if ( Not IsNull ( dDteSurv ) ) 	And &
				( Not IsNull ( lDuGC 	) ) 	And &
				( Not IsNull ( dDteAchat) ) 	And &
				( Not IsNull ( lGCMMin	) )	And &
				( Not IsNull ( lGCMMax  ) )	And &
				( Not IsNull ( lDuGC		) )	Then
	
				// [PC936]
				dDteFinGC = F_PLUS_DATE ( dDteAchat, lDuGC + lDuPGC, sUnite )
				// :[PC936]
				
				If	dDteSurv > dDteFinGC	Then // Si date de surv > à la nouvelle date de fin de GC,
													  // refus 637
					bRet = Uf_RF_EcrireRefus ( 637 )
				End If
			End If
		Else
			bRet = Uf_RF_EcrireRefus ( 637 ) // Aucune PGC trouvé 
		End If
	End If
End If

Return ( bRet )

end function

public subroutine uf_gestong_divers_majzone (string asnomzone, long alrow, any aavalue);//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_sinistre::uf_GestOng_Divers_MajZone (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 05/06/2007
//* Libellé       : Mise à Jour par script d'une zone de l'onglet Divers
//*					  + gestion des valeurs par défaut si Initialisation
//* Commentaires  : Créé pour [DCMP070163-070164-070248-070318] Gestion Prise en charge
//*
//* Arguments		: String			asNomZone		Val
//*					  Long			alRow				Val
//*					  any				aaValue			Val : valeur à positionner dans le champs
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    04/06/2007  [DCMP070163-070164-070248-070318] Gestion Prise en charge
//*       JFF    21/12/2010  [PC301][VESTUSTE]
//*       JFF    21/01/2011  [PC301].[V15_EVOL_VETUSTE]
//*       JFF    27/05/2011  [PC10].[DP150]
//*       JFF    24/01/2012  [CONFO][CUISINE][PC680]
//*       JFF    14/12/2012  [ITSM138882]
//*       JFF    15/10/2018  [DT391]
//*-----------------------------------------------------------------

Boolean	bMajZone
Long		lDeb, lFin, lCpt
String	sIdCode
DateTime dtMajLe // #1

asNomZone = Upper ( asNomZone )
bMajZone = False

Choose Case asNomZone	

	// [PC301].[V15_EVOL_VETUSTE]
	Case 	"MT_PEC", &
			"MT_MAX_PROPO_PLF722", &
			"VAL_PUB_ORANGE"

		bMajZone = True
		idw_wDivDet.SetItem ( alRow, "VAL_MT", aaValue )

	// [CONFO][CUISINE]
	Case "DTE_PEC", "DTE_FIN_GTI_ARTICLE"

		bMajZone = True
		idw_wDivDet.SetItem ( alRow, "VAL_DTE", aaValue )

	// [PC301].[V15_EVOL_VETUSTE] [PLAF_REF] [PC10].[DP150]
	// [CONFO][CUISINE]
	// [CONFO][MEUBLE][PC542]
	// [ITSM138882] "ALT_PEC"
	Case 	"ALT_PLAF_PEC", &
			"VETUSTE", &
			"CALCUL_VETUSTE", &
			"PEC", &
			"SAISIE_VAL_PUBLIQUE_MANUELLE", &
			"CODE_ARTICLE", &
			"LIB_ARTICLE", &
			"ENLV_BIEN", &
			"ALT_PEC",&
			"VAL_PUB_ORANGE_UTILISEE", &
			"ALT_FRAUDE", &
			"SOUPLESSE_1"
			

		bMajZone = True
		idw_wDivDet.SetItem ( alRow, "VAL_CAR", aaValue )


	// [CONFO][CUISINE][PC680]
	// [CONFO][MEUBLE][PC542]
	Case "ACCORD_REMPL", "ACCORD_REMPL2", "REMPL_CARTE_CADEAU", "TAILLE_ARTICLE", "PRIS_PRESTA_BLCODE"

		bMajZone = True
		idw_wDivDet.SetItem ( alRow, "VAL_NBRE", aaValue )


End Choose

If	bMajZone Then

	// #1
	dtMajLe = DateTime ( Today (), Now () )
	
	idw_wDivDet.SetItem ( alRow, "MAJ_LE", dtMajLe  )
	idw_wDivDet.SetItem ( alRow, "MAJ_PAR", stGlb.sCodOper )
	idw_wDivDet.SetItem ( alRow, "ALT_SUPP", "N" )
	
	// #1 Plus logique de mettre aussi à jour w_sin
	idw_wDetailFF.SetItem ( 1, "MAJ_LE", dtMajLe  )
	idw_wDetailFF.SetItem ( 1, "MAJ_PAR", stGlb.sCodOper )	
	
End If

end subroutine

public subroutine uf_initialiser_objets (ref u_tagger aupiece, ref u_tagger aurefus, ref commandbutton acbtarif, ref commandbutton acbcommander, ref commandbutton acbvalachdef, ref statictext astpec, ref statictext astlabpec);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialiser_Objets (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 22/01/1998 15:23:57
//* Libellé			: 
//* Commentaires	: Initialisation des objets de la fenêtre W_Td_Sp_W_Detail
//*
//* Arguments		: U_Tagger				auoPiece		(Réf)	User Objet pour les pieces
//*					  U_Tagger				auoRefus		(Réf)	User Objet pour les refus
//*					  CommandButton		acbTarif		(Réf)	Bouton sur l'aide du TARIF PAPIER
//*					  CommandButton		acbCommander(Réf)	Bouton Commander
//*					  CommandButton		acbValAchDef(Réf)	Bouton Valeur Achat par défaut
//*					  StaticText			astPec		(Réf) Static text informatif sur la PEC // #1
//*					  StaticText			astLabPec	(Réf) Statix text informatif sur la PEC // #1
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1    JFF   04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
//*-----------------------------------------------------------------

iUoTagPiece	= auPiece
iUoTagRefus	= auRefus

/*------------------------------------------------------------------*/
/* On initialise la DW de traitement maintenant. On n'utilise pas   */
/* la fonction Uf_Initialiser () car elle affecte à nouveau le      */
/* itrTrans. Ce qui est inutile.                                    */
/*------------------------------------------------------------------*/
iuoTagPiece.dw_Trt.DataObject		= "d_Lst_Sin_W_Piece_Affecte"
iuoTagPiece.dw_Source.DataObject = idw_Piece.DataObject

iuoTagRefus.dw_Trt.DataObject		= "d_Lst_Sin_W_Refus_Affecte"
iuoTagRefus.dw_Source.DataObject = idw_Motif.DataObject

/*------------------------------------------------------------------*/
/* Le 28/11/2001.                                                   */
/* Modif DGA. DCMP 010375                                           */
/*------------------------------------------------------------------*/
iCbTarif = aCbTarif
iCbCommander = aCbCommander
iCbValAchDef = aCbValAchDef

// #1
istPec = astPec
istLabPec = astLabPec

end subroutine

private function long uf_zn_trt_divdet_mtpec (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_MtPec (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 12/06/2007
//* Libellé			: Contrôle de la zone MtPec (Prise En Charge)
//* Commentaires	: [DCMP070163-070164-070248-070318] Gestion Prise en charge
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    13/07/2011  [VDOC4684]
//*-----------------------------------------------------------------

Long lDeb, lFin, lCpt, lIdGti, lRow
Integer iAction
Boolean bGestPec
Decimal {2} dcMtPec, dcMtPecOriginal

iAction = 0
lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 86 )
bGestPEC = False
If lDeb > 0 Then
	For lCpt = lDeb To lFin
		If idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) = lIdGti Then
			bGestPEC = True
			Exit
		End If 
	Next
End If

If Not bGestPEC Then 
	idw_wDivDet.iiErreur = 4
	iAction = 1	
	Return iAction
End If

// Pec et forçage de pec sont obligatoire
If Not ( This.uf_GestOng_Divers_Trouver ("ALT_PEC" ) = "O" And &
	  	 This.uf_GestOng_Divers_Trouver ("PEC" ) = "O" ) Then
	idw_wDivDet.iiErreur = 1
	iAction = 1
	Return iAction
End If

// Il ne doit pas y avoir de commande sur le détail.
If This.uf_Deja_Une_Commande () Then
	idw_wDivDet.iiErreur = 2
	iAction = 1
	Return iAction			
End If			

// Si le mt de pec à déjà été validée, interdiction de le modifier.
lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'MT_PEC'", 1, idw_wDivDet.RowCount () )
If lRow > 0 Then
	If idw_wDivDet.GetItemNumber ( lRow, "CPT_VALIDE" ) > 0 Then
		idw_wDivDet.iiErreur = 6  // [ITSM137898]
		iAction = 1
		Return iAction
	End If
End If

dcMtPec = Dec ( asData )
If IsNull ( dcMtPec ) Then dcMtPec = 0

// [VDoc4684]
If Mid ( gsBINDroit, 18, 1 ) = "1" Then
	dcMtPecOriginal = idw_wDivDet.GetItemDecimal ( lRow, "VAL_MT" ) 
	If dcMtPecOriginal < dcMtPec Then
		idw_wDivDet.iiErreur = 5
		iAction = 1
		Return iAction
	End If
End If

// [SUISSE].LOT3
istPec.Text = String ( dcMtPec, "#,##0.00 \"+stGlb.smonnaiesymboledesire )

Return iAction



end function

private function long uf_zn_trt_divdet_accordrempl (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_AccordRempl (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 19/07/2006
//* Libellé			: Contrôle de la zone Accord Remplacement pour les irréparable [DCMP070431]
//* Commentaires	: 
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//* Retourne		: long
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//      JFF   23/05/2012 [PM103][1]
//*-----------------------------------------------------------------
Int iAction

iAction = 0

// Droit 210/-NA Autoriser cmde de rempl suit irréparable.
// [PM103][1]
If Not This.uf_GetAutorisation ( 210 ) And Not gbModeReprise_223 Then 
	idw_wDivDet.iiErreur = 1
	iAction = 1
End If

If iAction = 0 And ( idw_LstCmdeSin.Find ( "ID_TYP_ART = 'TEL' AND COD_ETAT <> 'ANN'", 1, idw_LstCmdeSin.RowCount () ) > 0 Or &
							 idw_LstCmdeGti.Find ( "ID_TYP_ART = 'TEL' AND COD_ETAT <> 'ANN'", 1, idw_LstCmdeSin.RowCount () ) > 0 ) Then
	iAction = 1
	idw_wDivDet.iiErreur = 2
End If

Return iAction

end function

private subroutine uf_controlergestion_factuetaccordrempl (ref string aspos);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerGestion_FactuEtAccordRempl (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 13/11/2006
//* Libellé			: 
//* Commentaires	: [DCMP070431] 
//*
//* Arguments		: String		asPos		Réf.
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF  17/09/2007 Gestion de l'existant
//* #4  JFF  16/11/2012 [VDOC9485]
//* #4  JFF  06/02/2013 [VDOC9485] Retour arrière
//*     JFF  28/08/2014 [BUG_WDET534]
//*-----------------------------------------------------------------

Long lCodEtat, lRow, lDeb, lFin, lIdDetail, lIdGti, lRow2, lRow3
DateTime dtCreeLe 
String sTypApp

// [VDOC9485] ajout This.uf_GetAutorisation ( 208 )
// [VDOC9485] Retour arrière
// If This.uf_GetAutorisation ( 208 ) Then Return

lCodEtat = idw_wDetailFF.GetItemNumber ( 1, "COD_ETAT"  )
dtCreeLe = idw_wDetailFF.GetItemDatetime ( 1, "CREE_LE"  )
lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI"  )
lIdDetail= idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL"  )

If lCodEtat <> 500 Then Return

// #1 Date du placement du contrôle
If dtCreeLe < DateTime ( 2007-09-05 ) Then Return

// nouveau Contrôle
lRow = idw_LstCmdeDet.Find ( "ID_GTI=" + String (lIdGti) + " AND ID_DETAIL=" + String (lIdDetail) + "AND ID_TYP_ART = 'PRS' AND STATUS_GC = 21", 1, idw_LstCmdeDet.RowCount () )
lRow2 = idw_wDivSin.Find ( "NOM_ZONE = 'type_app'", 1,  idw_wDivSin.RowCount () )

If lRow2 > 0 Then
	sTypApp = idw_wDivSin.GetItemString ( lRow2, "VAL_LST_CAR" )
End If

If lRow > 0 Then

	// Si présent, l'accord pour le rempl est-il présent ?
	lRow = idw_wDivDet.Find ( "ID_GTI = " + String ( lIdGti ) + " AND " + &
								  "ID_DETAIL = " + String ( lIdDetail ) + " AND " + &
								  "UPPER ( NOM_ZONE ) = 'ACCORD_REMPL' AND VAL_LST_NBRE = 1", 1, idw_wDivDet.RowCount ( ) ) 

	lRow3 = idw_wDivDetGti.Find ( "UPPER ( NOM_ZONE ) = 'ACCORD_REMPL' AND VAL_LST_NBRE = 2", 1, idw_wDivDetGti.RowCount ( ) ) 


	// Si absent, Message bloquant.
	If lRow > 0 And lRow3 <=0 Then
		stMessage.sTitre		= "Cmde rempl sur irréparable"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "WDET534"
	
		f_Message ( stMessage )
		asPos = "ALT_BLOC"
	End If
End If
	

end subroutine

private subroutine uf_controlergestion_o2m (ref string aspos);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerGestion_O2M (PRIVATE)
//* Auteur			: PHG
//* Date				: 12/12/2007
//* Libellé			: 
//* Commentaires	: Contrôle de gestion pour Flux O2M sur Detail contenant des Flux O2M.
//*
//* Arguments		: String		asPos		Réf.
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date			Modification
//*-----------------------------------------------------------------

Long lCodeEtatDetail, lIdGti, lIdDetail
Boolean bPresenseDiagRFO, bPresenceRefuserAReexp
Decimal {2} dcMtPrej

// LE 24/12/2007, code volontairement shunter par JF, sur demande d'Audrey et MCB
// En effet, dans tous les cas, le détail se terminera par SANS SUITE.
Return

If idw_wDetailFF.GetItemString ( 1, "ALT_BLOC" ) = "O" Then Return

lCodeEtatDetail = idw_wDetailFF.GetItemNumber ( 1, "COD_ETAT" )
lIdDetail  = idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) 
lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) 


bPresenseDiagRFO = idw_LstCmdeDet.Find (	"ID_GTI = " + String ( lIdGti ) + 									&
														" AND ID_DETAIL = " + String ( lIdDetail ) + 					&
														" AND ID_FOUR = 'O2M'" + &
														" AND ID_TYP_ART = 'EDI'" + 											&
														" AND ID_REF_FOUR = 'A_DIAGNOSTIQUER'" + 							&
														" AND COD_ETAT = 'RFO'", 1, idw_LstCmdeDet.RowCount () )> 0 

bPresenceRefuserAReexp = idw_LstCmdeDet.Find (	"ID_GTI = " + String ( lIdGti ) + 									&
																	" AND ID_DETAIL = " + String ( lIdDetail ) + 					&
																	" AND ID_FOUR = 'O2M'"  +	&
																	" AND ID_TYP_ART = 'EDI'" + 											&
																	" AND ID_REF_FOUR = 'REFUSE_A_REEXP'" +  							&
																	" AND COD_ETAT <> 'ANN'" &
																	, 1, idw_LstCmdeDet.RowCount () )>0

if lCodeEtatDetail = 200 and ( bPresenseDiagRFO and Not bPresenceRefuserAReexp ) Then
		stMessage.bErreurG	= FALSE
		stMessage.sTitre		= "Action incohérente"
		stMessage.Icon			= Information!
		stMessage.bouton		= YesNo!
		stMessage.sCode = "WDET540" 
		asPos = "LIB_DET"
		if f_Message ( stMessage ) <> 1 then
			asPos = "" // Réponse NON : On Continue
		End If
		Return
End If

if lCodeEtatDetail <> 200 and ( bPresenseDiagRFO and bPresenceRefuserAReexp ) Then
		stMessage.bErreurG	= FALSE
		stMessage.sTitre		= "Action incohérente"
		stMessage.Icon			= Information!
		stMessage.bouton		= Ok!
		stMessage.sCode = "WDET550" 
		asPos = "LIB_DET"
		f_Message ( stMessage )
		Return
End If


end subroutine

private function boolean uf_rf_698 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_698 (PRIVATE)
//* Auteur			: MADM
//* Date				: 11/07/2006
//* Libellé			: 
//* Commentaires	: Refus automatique entre évènements et nature de sinistre [DCMP 050393]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 PHG		22/01/2008 [DCMP070815] Changement du paramétrage Det_pro ( utilisation n_cst_string... )
//* #2    JFF     12/01/2009 [20090112160907947]
//*-----------------------------------------------------------------

Long  lDeb, lFin, lIdGti, lIdEvt, lIdNatSin, lCpt, lRech
String	sDpParam 		// #1 [DCMP070815] Paramétrage enregistré dans detpro.val_car
n_cst_string lnv_string // #1 [DCMP070815] utilisation de fct de découpage de chaine.
Boolean bRet

bRet				= True
lIdGti    = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
lIdEvt    = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
lIdNatSin = idw_wSin.GetItemNumber ( 1, "ID_NATSIN" )

// Si pas d'option 63 : Pas de Refus
// #2 [20090112160907947]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 63 )
							
If lDeb <= 0 Then Return TRUE

// #2 [20090112160907947]
For lCpt = lDeb TO lFin

	// #2 [20090112160907947]
	lRech = idw_DetPro.Find(	"ID_TYP_CODE_DP = '-DP' AND ID_CODE_DP = 63 AND ID_CODE_NUM = 698", lCpt, lCpt )

	// #2 [20090112160907947]
	If lRech <= 0 Then continue

	// #1 [DCMP070815] Lecture du paramétrage
	// #2 [20090112160907947]	
	sDpParam = idw_DetPro.GetItemString ( lCpt, "VAL_CAR" )
	
	/*------------------------------------------------------------------------------------*/
	/* Si lors de la boucle les 3 égalités sont vérifiéés alors on déclenche le refus 698.*/
	/*------------------------------------------------------------------------------------*/
	If	( long(lnv_string.of_getkeyvalue( sDpParam, "ID_GTI", ";")) = lIdGti ) and 		&
		( long(lnv_string.of_getkeyvalue( sDpParam, "ID_EVT", ";")) = lIdEvt ) and 		&
		( long(lnv_string.of_getkeyvalue( sDpParam, "ID_NATSIN", ";")) = lIdNatSin ) Then 
			bRet = Uf_RF_EcrireRefus ( 698 )

			// #2 [20090112160907947]
			If bRet Then Exit
		
	End If 
Next

Return ( bRet )

end function

private function long uf_zn_mtvalpublique ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_MtValPublique (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 31/01/2008 17:14:39
//* Libellé			: [DCMP080028]
//* Commentaires	: Controle de MT_VAL_ACHAT
//*
//* Arguments		: Aucun
//*
//* Retourne		: long
//*-----------------------------------------------------------------
//* #1   JFF    28/01/2008  [DCMP080028]
//* #2   JFF    10/07/2008  [DCMP080401].SAISIE_VAL_PUBLIQUE
//       JFF    01/07/2014  [PC786-1_AUCHAN_GEM][MANTIS11397] 
//*-----------------------------------------------------------------

String sValSaisie
Decimal {2} dcMaxTTCMob, dcMtValAchat
Integer iAction
Boolean bMtValPublSaisie  // #5 [DCMP080401].SAISIE_VAL_PUBLIQUE
Long lDeb, lFin // #5 [DCMP080401].SAISIE_VAL_PUBLIQUE
Long lIdGti

lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )

sValSaisie = idw_wDetailFF.GetText ()

dcMtValAchat = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" )
If IsNull ( dcMtValAchat ) Then dcMtValAchat = 0		

iAction = 0

If iAction = 0 Then  // #1
	If This.uf_GestOng_Divers_Trouver ("PEC" ) = "O" Then
		idw_wDetailFF.iiErreur = 2
		iAction = 1
	End If
End If 

/*------------------------------------------------------------------*/
/* Pour la gestion des commandes.                                   */
/*------------------------------------------------------------------*/
// [PC786-1_AUCHAN_GEM][MANTIS11397] 
If ibAltCmde And iAction = 0 And lIdGti <> 52 Then

	dcMaxTTCMob = uf_MaxTTC_MobileChoisi ()

   If dcMaxTTCMob > 0 Then
		If Dec ( sValSaisie ) < dcMaxTTCMob Then
			idw_wDetailFF.iiErreur = 1
			iAction = 1
		End If
	End If

End If

//* #2 [DCMP080401].SAISIE_VAL_PUBLIQUE
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 102 )
bMtValPublSaisie = lDeb > 0
//* :#2 [DCMP080401].SAISIE_VAL_PUBLIQUE

// #1
If bMtValPublSaisie And iAction = 0 Then
	If Dec ( sValSaisie ) > dcMtValAchat Then
			idw_wDetailFF.iiErreur = 3
			iAction = 1
	End If 
End If
// :#1


//Migration PB8-WYNIWYG-03/2006 OR
//idw_wDetailFF.SetActionCode (iAction)
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_trt_divdet_accordrempl2 (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_AccordRempl2 (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 19/07/2006
//* Libellé			: Contrôle de la zone Accord Remplacement2 pour les Accord suite à 2 réparation [DCMP070921]
//* Commentaires	: 
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//* Retourne		: long
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    13/06/2008  [20080613] vu avec Aurélien, on supprime ce contrôle gênant.
//        JFF    23/05/2012  [PM103][1]
//*-----------------------------------------------------------------
Int iAction

iAction = 0

// Droit 212/-NA Autoriser cmde de rempl suit irréparable.
// [PM103][1]
If Not This.uf_GetAutorisation ( 212 ) And Not gbModeReprise_223 Then 
	idw_wDivDet.iiErreur = 3
	iAction = 1
End If

/* #1 [20080613]
If iAction = 0 And ( idw_LstCmdeSin.Find ( "ID_TYP_ART = 'TEL' AND COD_ETAT <> 'ANN'", 1, idw_LstCmdeSin.RowCount () ) > 0 Or &
							 idw_LstCmdeGti.Find ( "ID_TYP_ART = 'TEL' AND COD_ETAT <> 'ANN'", 1, idw_LstCmdeSin.RowCount () ) > 0 ) Then
	iAction = 1
	idw_wDivDet.iiErreur = 2
End If
*/

// Il ne doit pas y avoir de commande sur le détail.
If iAction = 0  And This.uf_Deja_Une_Commande () Then
	idw_wDivDet.iiErreur = 4
	iAction = 1
End If	


Return iAction

end function

private function long uf_zn_trt_divdet_rejetzone_droit (string asdata, string asnomcol, long alrow, long aldroit);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_RejetZone_Droit (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 25/11/2008
//* Libellé			: Zone spécial pour traiter les rejets.
//* Commentaires	: 
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*					  Long			alDroit			Val
//*
//* Retourne		: long
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF	   20/10/2008 [FNAC_PROD_ECH_TECH].[20090127140540720]
//*-----------------------------------------------------------------
Int iAction
Boolean bPresenceFNAC_CAF, bPresenceFNAC_SMS, bFnacEPT, bForcage
Long lDeb, lFin, lIdGti, lIdDetail

iAction = 0
bForcage = False

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 105 )
bFnacEPT = lDeb > 0

lIdGti = idw_wDivDet.GetItemNumber ( alRow, "ID_GTI" )
lIdDetail = idw_wDivDet.GetItemNumber ( alRow, "ID_DETAIL" )


bPresenceFNAC_CAF = idw_LstCmdeSin.Find (	" ID_GTI = " + String ( lIdGti ) + 									&
														" AND ID_DETAIL = " + String ( lIdDetail ) + 					&
														" AND ID_FOUR = 'FNC'" + &
														" AND ID_TYP_ART = 'CAF'" + 											&
														" AND COD_ETAT = 'RPC'", 1, idw_LstCmdeSin.RowCount () )> 0 

bPresenceFNAC_SMS = idw_LstCmdeSin.Find (	" ID_GTI = " + String ( lIdGti ) + 									&
														" AND ID_DETAIL = " + String ( lIdDetail ) + 					&
														" AND ID_FOUR = 'FNC'" + &
														" AND ID_TYP_ART = 'SMS'" + 											&
														" AND COD_ETAT = 'RPC'", 1, idw_LstCmdeSin.RowCount () )> 0 



If Not This.uf_GetAutorisation ( alDroit ) Then 

	//* #1 [FNAC_PROD_ECH_TECH].[20090127140540720]
	If alDroit = 208 And bPresenceFNAC_SMS Then
		bForcage = True // On autorise dans ce cas.	
	End If

	If Not bForcage Then
		idw_wDivDet.iiErreur = 1000
		iAction = 1
	End If
	
End If

Return iAction

end function

private function long uf_zn_trt_divdet_fncnumfact (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_FncNumFact (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 28/01/2009
//* Libellé			: Contrôle de la zone FncNumFact
//* Commentaires	: [FNAC_PROD_ECH_TECH].[20090127140540720]
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//* Retourne		: long
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------
Int iAction
Long lIdGti, lIdDetail, lRow


iAction = 0

lIdGti = idw_wDivDet.GetItemNumber ( alRow, "ID_GTI" )
lIdDetail = idw_wDivDet.GetItemNumber ( alRow, "ID_DETAIL" )

lRow = idw_wDetailFF.Find ( "ID_GTI = " + String ( lIdGti ) + " AND ID_DETAIL = " + String ( lIdDetail ), 1, idw_wDetailFF.Rowcount () )

If lRow <= 0 Then Return iAction 

idw_wDetailFF.SetItem ( lRow, "NUM_FACTURE", asData )

Return iAction

end function

private function long uf_zn_trt_divdet_fncdteticket (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_FncDteTicket (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 28/01/2009
//* Libellé			: Contrôle de la zone FncNumFact
//* Commentaires	: [FNAC_PROD_ECH_TECH].[20090127140540720]
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//* Retourne		: long
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------
Int iAction
Long lIdGti, lIdDetail, lRow


iAction = 0

lIdGti = idw_wDivDet.GetItemNumber ( alRow, "ID_GTI" )
lIdDetail = idw_wDivDet.GetItemNumber ( alRow, "ID_DETAIL" )

lRow = idw_wDetailFF.Find ( "ID_GTI = " + String ( lIdGti ) + " AND ID_DETAIL = " + String ( lIdDetail ), 1, idw_wDetailFF.Rowcount () )

If lRow <= 0 Then Return iAction 

idw_wDetailFF.SetItem ( lRow, "DTE_FACTURE", Datetime ( asData ) ) // [PI056] -> passage en datetime

Return iAction

end function

private function long uf_zn_mtvalachat (string asval);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_MtValAchat (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/11/2003 17:14:39
//* Libellé			: 
//* Commentaires	: Controle de MT_VAL_ACHAT
//*
//* Arguments		: Aucun
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*-----------------------------------------------------------------
//* #1    JFF   04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
//* #2	 JFF	 01/04/2009   [20090401102753490]
//* #3    JFF   26/08/2009   [GEST_VAL_ACH_ADH]
//* #4    JFF 	 22/10/2009   [O2M_DIAG_NOMADE].[JFF].[20091022224855853]
//* #5	FPI	04/03/2010	[DCMP100114] - autoriser une première saisie du montant de valeur d'achat
//*       JFF   29/11/2010   [PC474]
//		FPI	08/03/2011	[PC321]
//        JFF   01/03/2012  [CONFO][MEUBLE][PC542]
//* JFF  10/09/2012  [PLAF_REF]
//		FPI	18/04/2013	[VDoc10924] Ajout ctrl valeur d'achat différent
//        JFF   01/07/2014   [PC786-1_AUCHAN_GEM][MANTIS11397] 
//        JFF   13/05/2016   [BUG_MANTIS_20726]
//       JFF   07/11/2016 [PC151259]
//       JFF   05/10/2017 [PC171918]
//       JFF   06/11/2017 [PC171933]
//    	JFF   06/11/2017 [PC171933][V4]
//       JFF   24/06/2019 [PC192235]
//*-----------------------------------------------------------------

String sVal, sRech, sVal1, sTypApp, sVal2
Long lNbreNouv, lDeb, lFin, lRowDS, lRow, lIdEvt, lIdGti
Decimal {2} dcMaxTTCMob, dcMtValAchat, dcTauxVetuste
Boolean bCasto, bPlaf675 
Integer iAction
Decimal {2} dcMtValPublique, dcAnciennete
n_cst_string lnvPFCString
Date dDteDet, dDteSurv  
Long lCptDteDet, lRowDD

//* #2	 JFF	 01/04/2009   [20090401102753490]
// sVal = idw_wDetailFF.GetText ()
sVal = asVal

iAction = 0
lIdEvt = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
ibMtValAchatSaisie = FALSE
bPlaf675 = TRUE // [BUG_MANTIS_20726]

lRow = idw_WDivSin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, idw_WDivSin.RowCount () ) 
If lRow <= 0 Then 
	sTypApp = "XXX"
Else
	sTypApp = Upper ( idw_WDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) )
End If			

// #4 [O2M_DIAG_NOMADE].[JFF].[20091022224855853]
This.uf_Gestion_DartyNomade ( Dec ( sVal ), "" )

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 43 )
bCasto = lDeb > 0
// If bCasto And iAction = 0 Then // #1
If iAction = 0 Then  // #1
	If This.uf_GestOng_Divers_Trouver ("PEC" ) = "O" Then

		// [BUG_MANTIS_20726]
		sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
						"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
						"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
						"ID_NIV_PLAF = '+EV' AND " 	+ &
						"ID_REF_PLAF = 1083 AND " 	+ &
						"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
						"ID_TYP_PLAF = '675'"

		If idw_Plafond.Find ( sRech, 1, idw_Plafond.RowCount ()) <= 0 Then
			bPlaf675 = FALSE
		End If 
		
		// [PLAF_REF] autorisation de la modification de la dte_det dans un cas très précis.
		If lIdEvt = 1083 And bPlaf675 Then
			iAction = 0			
		Else
			idw_wDetailFF.iiErreur = 2
			iAction = 1
		End If
	End If
End If 

If iAction = 0 Then ibMtValAchatSaisie = TRUE

/*------------------------------------------------------------------*/
/* Pour la gestion des commandes.                                   */
/*------------------------------------------------------------------*/
// [PC786-1_AUCHAN_GEM][MANTIS11397] 
If ibAltCmde And iAction = 0 and lIdGti <> 51 and lIdGti <> 52 Then

	dcMaxTTCMob = uf_MaxTTC_MobileChoisi ()

	If dcMaxTTCMob > 0 Then
		If Dec ( sVal ) < dcMaxTTCMob Then
			idw_wDetailFF.iiErreur = 1
			iAction = 1
		End If
	End If

End If

// #3 [GEST_VAL_ACH_ADH]
lRowDS = idw_wDivSin.Find ( "NOM_ZONE = 'mt_val_achat_adh'", 1, idw_wDivSin.RowCount () )				
If lRowDS > 0 Then
	// #5 - [DCMP100114]
	dcMtValAchat = idw_wDivSin.GetItemDecimal(lRowDS,"VAL_MT")
	
	If isnull(dcMtValAchat) or dcMtValAchat = 0 Then
		iAction=0
	ElseIf Long ( stGlb.sTypOper ) < 3 Then  // Fin #5 - le if devient elseif
			idw_wDetailFF.iiErreur = 3
			iAction = 1
	End If
End If
// :#3 [GEST_VAL_ACH_ADH]

// [PC321]
dcMtValPublique= idw_wdetailff.GetItemDecimal(1,"MT_VAL_PUBLIQUE")

If iAction=0  Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 141 )
	If lDeb > 0 Then idw_wdetailff.SetItem(1,"MT_VAL_PUBLIQUE",Dec(sVal) )
End if
// :[PC321]

// [VDoc10924] 
If iAction=0  and (not uf_getautorisation( 208)) Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 237 )
	If lDeb <= 0 Then
		lRow=idw_lstdetail.Find("MT_VAL_ACHAT<>" + sVal + " AND ID_DETAIL<>" + String(idw_wDetailFF.GetItemnumber( 1, "ID_DETAIL")),1,idw_lstdetail.RowCount())
		If lRow > 0 Then
			stMessage.sVar[1]=String(idw_lstdetail.GetItemnumber( lRow, "ID_DETAIL"))
			stMessage.sVar[2]=String(idw_lstdetail.GetItemDecimal( lRow, "MT_VAL_ACHAT"))
			stMessage.sTitre		= "Valeur achat différente"
			stMessage.Icon			= Question!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= YesNo!
			stMessage.sCode		= "WDET624"	
			
			if f_message(stMessage)=2 Then
				idw_wDetailFF.iiErreur = 4
				iAction = 1		
				stMessage.sCode="" // Pour ne pas afficher d'autre message d'erreur
				ibCtlValAchat=FALSE
			Else
				ibCtlValAchat=TRUE
			End if
		End if
	End if
End if
// :[VDoc10924] 

// [PC151259] // [PC171918] // [PC171933]
If isReferentiel <> "IFR" Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 252 )
	If lDeb > 0 Then
		sVal1 = lnvPFCString.of_getkeyvalue ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")
		Choose Case sVal1 
			Case "FULL_SERENITY_ADV_5", "ADVISE_6", "ADVISE_7"

				dDteSurv = Date ( idw_wSin.GetItemDatetime (1, "DTE_SURV" ))
				
				F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 42 )
				If lDeb > 0 Then
					For lCptDteDet = lDeb to lFin 
						If  idw_DetPro.GetItemNumber ( lCptDteDet, "ID_CODE_NUM")  = lIdGti And idw_DetPro.GetItemString ( lCptDteDet, "ID_CODE_CAR" ) = "A"  Then 
							dDteDet = idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" )
							Exit
						End If
					Next
				Else
					dDteDet	=Date(idw_wSin.GetItemDateTime ( 1, "DTE_ACH_PORT" ) ) // [PI056]
				End if

				// [PC171933][V4]
				dcTauxVetuste = 1   // 1%
				If sVal1 = "ADVISE_7" Then 
					dcTauxVetuste = 3    // 3%
				End If
	
				dcAnciennete = Abs ( DaysAfter ( dDteSurv, dDteDet ) )
				dcAnciennete = dcAnciennete / 30
				dcMtValPublique = Dec ( sVal ) * ( 1 - ( ( dcTauxVetuste/100 ) * dcAnciennete ))
				If dcMtValPublique < 0 Then dcMtValPublique = 0
				idw_wDetailFF.SetItem ( 1, "MT_VAL_PUBLIQUE", dcMtValPublique  )
	
				lRowDD  = idw_wDivDet.Find ( "Upper (nom_zone) = 'MT_VAL_PUBLIQUE_FORMULE'", 1, idw_wDivDet.RowCount () )				
				If lRowDD  <= 0 Then
					lRowDD  = idw_wDivDet.InsertRow (0)
					idw_wDivDet.SetItem ( lRowDD , "ID_SIN", idw_wDetailFF.GetItemNumber ( 1, "ID_SIN" ) )
					idw_wDivDet.SetItem ( lRowDD , "ID_GTI", idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )	
					idw_wDivDet.SetItem ( lRowDD , "ID_DETAIL", idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )		 
					idw_wDivDet.SetItem ( lRowDD , "NOM_ZONE", "mt_val_publique_formule" )
					idw_wDivDet.SetItem ( lRowDD , "LIB_LABEL", "Formule montant valeur publique" )
					idw_wDivDet.SetItem ( lRowDD , "ID_TYP_LISTE", "-XX" )
					idw_wDivDet.SetItem ( lRowDD , "ALT_LISTE_CODECAR", "N")
					idw_wDivDet.SetItem ( lRowDD , "ID_TYP_ZONE", "C" )
					idw_wDivDet.SetItem ( lRowDD , "ALT_OBLIG", "N" )
					idw_wDivDet.SetItem ( lRowDD , "ALT_PROT", "O" )
					idw_wDivDet.SetItem ( lRowDD , "CPT_TRI", 500 )
					idw_wDivDet.SetItem ( lRowDD , "VAL_DTE", stNul.dtm )	// [PI056].20190926
					idw_wDivDet.SetItem ( lRowDD , "VAL_CAR", "ValAchat x (1- (" + String (dcTauxVetuste) +"/100)xAncté_Mois)" )
					idw_wDivDet.SetItem ( lRowDD , "VAL_NBRE", stNul.lng )
					idw_wDivDet.SetItem ( lRowDD , "VAL_MT", stNul.dcm )
					idw_wDivDet.SetItem ( lRowDD , "ALT_SUPP", "N" )
					idw_wDivDet.SetItem ( lRowDD , "CREE_LE", DateTime ( Today (), Now () ) )
					idw_wDivDet.SetItem ( lRowDD , "MAJ_LE", DateTime ( Today (), Now () ) )
					idw_wDivDet.SetItem ( lRowDD , "MAJ_PAR", stGlb.sCodOper )				
	
					lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'MT_VAL_PUBLIQUE_FORMULE'", 1, idw_wDivDet.RowCount () )
					If lRow > 0 Then
						// [PC171933][V4]
						This.uf_GestOng_Divers_MajZone ( "MT_VAL_PUBLIQUE_FORMULE", lRow, "ValAchat x (1- (" + String (dcTauxVetuste) +"/100)xAncté_Mois)" )
					End If 			
				End If				
		End CHoose
	End If 
End If

// [PC192235]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 340 )
If lDeb > 0 Then
	// [VDOC29630]
	If isReferentiel = "IFR" Then
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 352)				
		If lDeb > 0 Then
			sVal2 = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "TYP_APP", ";")
			If Pos ( sVal2, "#" + sTypApp + "#" ) > 0 Then
				dcMtValAchat = Dec ( sVal ) 
				idw_wdetailff.SetItem ( 1,"MT_VAL_PUBLIQUE", dcMtValAchat )
			End If 
		End If 
	Else 
		dcMtValAchat = Dec ( sVal ) 
		idw_wdetailff.SetItem ( 1,"MT_VAL_PUBLIQUE", dcMtValAchat )
	ENd If 
End IF 


//Migration PB8-WYNIWYG-03/2006 OR
//idw_wDetailFF.SetActionCode (iAction)
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private subroutine uf_gestion_mtvalachat ();//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_Sinistre_Wdetail::uf_Gestion_MtValAchat (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 26/08/2009 14:10:05
//* Libellé       : [GEST_VAL_ACH_ADH]
//* Commentaires  : A la création du détail uniquement, on insert la valeur d'achat 
//*                 provenant des adhésions si elle elle présente du w_div_sin 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//       JFF   07/11/2016 [PC151259]
//*-----------------------------------------------------------------

Long   lDeb, lFin, lRowDS
Decimal {2} dcMtValAchatAdh, dcMtValAchatActuelle


dcMtValAchatActuelle = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" )
If IsNull ( dcMtValAchatActuelle ) Then dcMtValAchatActuelle = 0

If dcMtValAchatActuelle > 0 Then Return

// Gère-t-on la valeur d'achat
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 9 )
If lDeb <= 0 Then Return

// #3 On cherche d'abord sur Div_sin si un Val achat a été mémorisée
lRowDS = idw_wDivSin.Find ( "NOM_ZONE = 'mt_val_achat_adh'", 1, idw_wDivSin.RowCount () )				
If lRowDS <= 0 Then Return
// #3 On la lis le cas échéant
dcMtValAchatAdh = idw_wDivSin.GetItemDecimal ( lRowDS, "VAL_MT" )

If IsNull ( dcMtValAchatAdh ) Then dcMtValAchatAdh = 0
If dcMtValAchatAdh < 0 Then dcMtValAchatAdh = 0

idw_wDetailFF.SetItem ( 1, "MT_VAL_ACHAT", dcMtValAchatAdh )



end subroutine

private function boolean uf_rf_629 ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_wdetail::uf_rf_629
//* Auteur			: F. Pinon
//* Date				: 29/09/2009 15:34:24
//* Libellé			: 
//* Commentaires	: [DCMP090573]
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	PHG	26/10/2009 [DCMP071000] rf 655+651: Annexe : Correction Bug
//*								  présent sur toute les fonctions de refus.
//*-----------------------------------------------------------------

Long 		lTotDelai, lLig, lDuree, lNbJour, lNbHeu, lHeuDet, lHeuMax, lCpt
Boolean 	bRet
String 	sRech, sUnite, sHeuDet, sHeuSurv, sIdNivDel, sIdRefDel
Date		dDteDecl, dDteDet, dDteMax
Time		hHeuMax
DateTime dtDteMax, dtDecl

bRet				= True
lTotDelai 		= idw_Delai.RowCount ()


For lCpt = 1 to 5

	Choose Case lCpt
		Case 1
			sIdNivDel = "-GA"  // Garantie
			sIdRefDel = "-1"
		Case 2
			sIdNivDel = "+NS"  // Nature de sinistre
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivDel = "+TR"  // Territorialité
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivDel = "+DT"  // Détail de sinistre
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivDel = "+EV"  // Evénement de garantie
			sIdRefDel = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )


	End Choose

	If IsNull ( sIdRefDel ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un délai de déclaration pour la garantie. */
	/*------------------------------------------------------------------*/
	// #1 [DCMP071000] Lecture ID_GTI dans idw_wDetailFF ald de idw_wGarSin
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_DEL = '"  + sIdNivDel 																+ "' AND " 	+ &
					"ID_REF_DEL = "	+ sIdRefDel 																+ " AND " 	+ &
					"ID_TYP_DEL = '629'"

	lLig = idw_Delai.Find ( sRech, 1, lTotDelai )


	If	lLig > 0 Then

	/*------------------------------------------------------------------*/
	/* Le cas du délai en heure est géré à part car on doit travailler  */
	/* sur des datetime et non sur des dates.                           */
	/* De plus, on ne peut pas utiliser uniquement f_plus_date pour le  */
	/* calcul de la date de référence                                   */
	/*------------------------------------------------------------------*/

		sUnite	= idw_Delai.GetItemString ( lLig, "UNT_DEL" )
		lDuree	= idw_Delai.GetItemNumber ( lLig, "DUR_MAX" )
		dDteDet 	= Date ( idw_wDetailFF.GetItemDateTime ( 1, "DTE_DET" ) )

		dDteDecl	= idw_wSin.GetItemDate ( 1, "DTE_DECL" ) 

		If sUnite = 'H' Then

	/*------------------------------------------------------------------*/
	/* on additionne les heures à la date du détail.                    */
	/* On commence par déterminer à combien de jours et d'heures        */
	/* correspond lDuree                                                */
	/*------------------------------------------------------------------*/

			lNbJour	=	Truncate ( ( lDuree / 24 ), 0 )		// Partie entière du nombre d'heures / 24
			lNbHeu	=	Mod ( lDuree, 24 )						// Reste de la division du nb heures / 24

			sHeuDet	=	idw_wDetailFF.GetItemString 	( 1, "HEU_DET" )		
			
			if isNull(sHeuDet) Then sHeuDet="0000" // On force l'heure à 00:00 
			
			If ( Not isNull ( sHeuDet  ) ) Then

				lHeuDet	=  Long ( Left ( sHeuDet, 2 ) )
				lHeuMax  =  lHeuDet + lNbHeu

	/*------------------------------------------------------------------*/
	/* Si le nombre d'heures obtenu dépasse une journée, on ajoute un   */
	/* jour et on enlève 24 heures à heuMax                             */
	/*------------------------------------------------------------------*/

				If lHeuMax > 23 Then

					lHeuMax 	= lHeuMax - 24
					lNbJour	++
				End If

				hHeuMax	= Time ( String ( lHeuMax ) + ':' + Right ( sHeuDet, 2 ) )
				dDteMax	= F_Plus_Date ( dDteDet, lNbJour, 'J' )

	/*------------------------------------------------------------------*/
	/* Conversion de dDteMax et hHeuMax en datetime pour comparaison    */
	/* avec dtSurv                                                      */
	/*------------------------------------------------------------------*/

				dtDteMax = DateTime ( dDteMax, hHeuMax )
				dtDecl 	= DateTime ( dDteDecl )

				If	dtDecl > dtDteMax Then
	/*------------------------------------------------------------------*/
	/* La durée maximum est dépassée, on déclenche le refus 629.        */
	/*------------------------------------------------------------------*/
					bRet = Uf_RF_EcrireRefus ( 629 )
				End If

			Else

				dDteMax	= F_Plus_Date ( dDteDecl, lNbJour, 'J' )

				If	dDteDet > dDteMax	Then
		/*------------------------------------------------------------------*/
		/* La durée maximum est dépassée, on déclenche le refus 629.        */
		/*------------------------------------------------------------------*/
					bRet = Uf_RF_EcrireRefus ( 629 )
				End If
			End If

		Else

			dDteMax	= F_Plus_Date ( dDteDet, lDuree, sUnite )

			If	dDteDecl > dDteMax	Then
		/*------------------------------------------------------------------*/
		/* La durée maximum est dépassée, on déclenche le refus 629.        */
		/*------------------------------------------------------------------*/
				bRet = Uf_RF_EcrireRefus ( 629 )
			End If
		End If

	End If
Next

Return ( bRet )

end function

private function boolean uf_rf_655 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_655 (PRIVATE)
//* Auteur			: PHG
//* Date				: 26/10/2009
//* Libellé			: 
//* Commentaires	: [DCMP071000] Seuil d'intervention Pour la garantie Meilleur Prix
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt
String sIdNivPlaf, sIdRefPlaf
Boolean bRet

Decimal {2} dcMtPrej,dcMtValAchat

String sRech

bRet				= True
lTotPlaf 		= idw_Plafond.RowCount ()
dcMtPrej			= idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" )
dcMtValAchat	= idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" )

/*------------------------------------------------------------------*/
/* Si le montant du préjudice est NULL ou égal à zéro, on ne gére   */
/* pas de refus.                                                    */
/*------------------------------------------------------------------*/
If	IsNull ( dcMtPrej ) Or dcMtPrej = 0 Then Return ( bRet )

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 1 to 5

	Choose Case lCpt
		Case 1
			sIdNivPlaf = "-GA"  // Garantie
			sIdRefPlaf = "-1"
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond 										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '" + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"																					+ " AND " 	+ &
					"ID_TYP_PLAF = '655'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If	lLig > 0 Then
		/*----------------------------------------------------------------------*/
		/* Si Valeur d'achat d'origine - Prix Constaté <= Seuil d'intervention  */
		/*    Alors Refus,                                                      */
		/* dénomination :                                                       */
		/* Mt_Prej = Valeur Achat origine                                       */
		/* Mt_Val_Achat = Prix constaté                                         */
		/* Mt_plaf = Seuil d'intervention                                       */
		/*----------------------------------------------------------------------*/

		If	( dcMtPrej - dcMtValAchat ) <= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )	Then
			bRet = Uf_RF_EcrireRefus ( 655 )
		End If
	End If
Next

Return ( bRet )
end function

private function boolean uf_rf_651 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_651 (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 11/05/2004 15:07:49
//* Libellé			: 
//* Commentaires	: Si Prix constaté > Valeur Achat origine (MT_PREJ) Alors Refus
//*					  dénomination : Mt_Prej = Valeur Achat origine 
//*										  Mt_Val_Achat = Prix constaté
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	PHG		21/10/2009	[DCMP071000] Seuil D'intervention Minimum
//										pour Gti Meilleur Prix
//										Chantier Annexe : normalisation uf_rf_651
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt
String sIdNivPlaf, sIdRefPlaf
Boolean bRet
Decimal {2} dcMtPrej, dcPxConst
String sRech

bRet				= True
lTotPlaf 		= idw_Plafond.RowCount ()
dcMtPrej			= idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" )
dcPxConst		= idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" )


/*------------------------------------------------------------------*/
/* Si le montant du préjudice est NULL ou égal à zéro, on ne gére   */
/* pas de refus.                                                    */
/*------------------------------------------------------------------*/
If	IsNull ( dcMtPrej ) Or dcMtPrej = 0 Then Return ( bRet )

For lCpt = 1 to 5

	Choose Case lCpt
		Case 1
			sIdNivPlaf = "-GA"  // Garantie
			sIdRefPlaf = "-1"
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond 										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '" + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"																					+ " AND " 	+ &
					"ID_TYP_PLAF = '651'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If	lLig > 0 Then
		/*------------------------------------------------------------------*/
		/* Si Prix constaté >= Valeur Achat origine Alors Refus ,           */
		/* dénomination : Mt_Prej = Valeur Achat origine Mt_Val_Achat =     */
		/* Prix constaté                                                    */
		/*------------------------------------------------------------------*/
		If	dcPxConst >= dcMtPrej Then
			bRet = Uf_RF_EcrireRefus ( 651 )
		End If
	End If
Next

Return ( bRet )


////*-----------------------------------------------------------------
////*
////* Fonction		: Uf_Rf_651 (PRIVATE)
////* Auteur			: Fabry JF
////* Date				: 11/05/2004 15:07:49
////* Libellé			: 
////* Commentaires	: Si Prix constaté > Valeur Achat origine Alors Refus
////*					  dénomination : Mt_Prej = Valeur Achat origine 
////*										  Mt_Val_Achat = Prix constaté
////*
////* Arguments		: Aucun
////*
////* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
////*										Faux = Le refus n'existe pas.
////*
////*-----------------------------------------------------------------
////* MAJ   PAR      Date	     Modification
////* #1	PHG		21/10/2009	[DCMP07100] Seuil D'intervention Minimum
////										pour Gti Meilleur Prix
////										Chantier Annexe : normalisation uf_rf_651
////*-----------------------------------------------------------------
//
//
//Boolean bRet, bOk
//Long 	  lDeb, lFin, lIdGti, lCpt
//
//Decimal {2} dcMtPrej, dcPxConst
//
///*------------------------------------------------------------------*/
///* #1                                                               */
///*------------------------------------------------------------------*/
//F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 21 )
//If lDeb <= 0 Then Return TRUE
//
//bRet				= True
//dcMtPrej			= idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" )
//dcPxConst		= idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" )
//lIdGti			= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
//bOk				= False
//
//For lCpt = lDeb To lFin
//	If lIdGti = idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" ) Then
//		bOk = True
//		Exit
//	End If
//Next
//
//If Not bOk Then Return TRUE
//
///*------------------------------------------------------------------*/
///* Si le montant du préjudice est NULL ou égal à zéro, on ne gére   */
///* pas de refus.                                                    */
///*------------------------------------------------------------------*/
//If	IsNull ( dcMtPrej ) Or dcMtPrej = 0 Then Return ( bRet )
//
///*------------------------------------------------------------------*/
///* Si Prix constaté > Valeur Achat origine Alors Refus ,            */
///* dénomination : Mt_Prej = Valeur Achat origine Mt_Val_Achat =     */
///* Prix constaté                                                    */
///*------------------------------------------------------------------*/
//If	dcPxConst > dcMtPrej Then
//	bRet = Uf_RF_EcrireRefus ( 651 )
//End If
//
//Return ( bRet )
//
end function

public function boolean uf_controlergestion_o2m_apprecuprecycl ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_wdetail::uf_controlergestion_o2m_apprecuprecycl
//* Auteur			: Pierre-Henri Gillot
//* Date				: 24/12/2009 14:08:29
//* Libellé			: [O2M_DIAG_NOMADE].Lot2
//* Commentaires	: 
//*
//* Arguments		: (None)
//*
//* Retourne		: TRUE :	Présence d'une préstation APP_RECUP_RECYCL
//*									en process 435 et Status Gc <> 166
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   15/01/2010   [O2M_DIAG_NOMADE].Lot2.JFF
//* #2    JFF   15/01/2010   [O2M_DIAG_NOMADE].Lot2.JFF
//*       JFF    22/09/2010  [PM01].[LOT3&4]
//*       JFF    18/12/2012  [PC543_MANTIS6008]
//*-----------------------------------------------------------------

Long lCodeEtatDetail, lIdGti, lIdDetail, lDeb, lFin
Boolean bAppRecupRecyclage

if not isvalid(idw_wDetailFF) Then return false

If idw_wDetailFF.GetItemString ( 1, "ALT_BLOC" ) = "O" Then Return false

// [PC543_MANTIS6008]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 230 )
If lDeb > 0 Then Return False
// [PC543_MANTIS6008]

bAppRecupRecyclage = idw_LstCmdeSin.Find ("ID_TYP_ART = 'EDI'" + 					&
														" AND ID_FOUR = 'O2M'" + 							&
														" AND INFO_SPB_FRN in ( 435, 1502, 1503, 1504, 1505)" + 					&
														" AND STATUS_GC NOT IN (166,167,168)" + 						& 
														" AND COD_ETAT NOT IN ( 'ANN', 'CNV' )", 1, idw_LstCmdeDet.RowCount () )> 0 
// [PM01].[LOT3&4]

// #1 [O2M_DIAG_NOMADE].Lot2.JFF
//														" AND COD_ETAT <> 'ANN'", 1, idw_LstCmdeDet.RowCount () )> 0 

// [PM01].[LOT3&4]

return bAppRecupRecyclage
end function

private function boolean uf_rf_644 ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_wdetail::uf_rf_644
//* Auteur			: F. Pinon
//* Date				: 10/02/2010 11:09:14
//* Libellé			: 
//* Commentaires	: [CASTO_SWAP]
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

Date 	  dDteDp, dDteDet
Boolean bRet, bOk
long	  lDeb, lFin, lCpt, lIdGti
String sValCar
n_cst_string lnv_String
/*------------------------------------------------------------------*/
/* On déclenche ce motif dans le cas de la garantie Achats. Si la   */
/* date de détail est supérieuere à la date de survenance, on arme  */
/* le motif 631.                                                    */
/*------------------------------------------------------------------*/

lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )

bRet = True
bOk      = False

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 42 )
If lDeb > 0 Then
	For lCpt = lDeb to lFin 
		If  idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM")  = lIdGti And idw_DetPro.GetItemString ( lCpt, "ID_CODE_CAR" ) = "A"  Then 
			bOk = True
			Exit
		End If
	Next
	
	If Not bOk Then Return TRUE
	dDteDet	= idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" )
Else
	dDteDet	=Date(idw_wSin.GetItemDateTime ( 1, "DTE_ACH_PORT" ) ) // [PI056]
End if

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 132 )
if lDeb >  0 Then
	For lCpt = lDeb to lFin 
		If  idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM")  = lIdGti Then 
			bOk = True
			Exit
		End If
	Next
	
	If Not bOk Then Return TRUE

	sValCar=idw_DetPro.GetItemString ( lCpt, "VAL_CAR") 
	sValCar=lnv_String.of_getkeyvalue( sValCar, "DTE_PIVOT", ";")
	
	dDteDp=Date(sValCar)
	
	if dDteDet < dDteDp Then
		bRet = Uf_RF_EcrireRefus ( 644 )
	End if
	
End if

Return bRet
end function

public function boolean uf_garantierevision ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::uf_GarantieRevision (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/05/2010 
//* Libellé			: TRUE si c'est garantie est couverte par un assureur, même s'il y a forçage
//* Commentaires	: [20100506164646807]
//*
//* Arguments		: 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lIdProd, lIdRev, lIdGti
Boolean bRet

lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
lIdProd = idw_wSin.GetItemNumber ( 1, "ID_PROD" )
lIdRev = idw_wSin.GetItemNumber ( 1, "ID_REV" )

bRet = idw_Garantie.Find ( "ID_PROD = " + String ( lIdprod ) + " AND " + &
									"ID_REV = " + String ( lIdRev ) + " AND " + &
									"ID_GTI = " + String ( lIdGti ), 1, idw_Garantie.RowCount () ) > 0 
									
Return bRet



end function

private function long uf_zn_trt_divdet_numprs (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_NumPrs (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 07/05/2010
//* Libellé			: Contrôle de la zone Num_Prs
//* Commentaires	: [DCMP100331]
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//* Retourne		: long
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------
Int iAction
Long lIdGti, lIdDetail
String sValAvant 

iAction = 0
sValAvant = Trim ( idw_wDivDet.GetItemString ( alRow, "VAL_CAR" ))

If iAction = 0 And Len ( sValAvant ) > 0 And stGlb.sTypOper < "3" Then
	iAction = 1
	idw_wDivDet.iiErreur = 4
End If

If iAction = 0 And Len ( Trim ( asData ) ) <> 10 Then
	iAction = 1
	idw_wDivDet.iiErreur = 3
End If 	

Return iAction

end function

private function boolean uf_rf_1438 ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_wdetail::uf_rf_1438
//* Auteur			: F. Pinon
//* Date				: 22/10/2010 11:09:14
//* Libellé			: 
//* Commentaires	: [PC516]
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
// 			FPI	30/12/2010	[ITSM55084] Correction
//*-----------------------------------------------------------------

Date 	  dDteDp, dDteDet
Boolean bRet, bOk
long	  lDeb, lFin, lCpt, lIdGti
String sValCar
n_cst_string lnv_String

lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )

bRet = True
bOk      = False

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 42 )
If lDeb > 0 Then
	For lCpt = lDeb to lFin 
		If  idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM")  = lIdGti And idw_DetPro.GetItemString ( lCpt, "ID_CODE_CAR" ) = "A"  Then 
			bOk = True
			Exit
		End If
	Next
	
	If Not bOk Then Return TRUE
	dDteDet	= idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" )
Else
	dDteDet	=Date(idw_wSin.GetItemDateTime ( 1, "DTE_ACH_PORT" ) ) // [PI056]
End if

lDeb=0
lFin=0

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 149 )
if lDeb >  0 Then
	
	bOk=FALSE // [ITSM55084] - Remplacement de bRet par bOk
	For lCpt = lDeb to lFin 
		If  idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM")  = lIdGti Then 
			bOk = True
			Exit
		End If
	Next
	
	If Not bOk Then Return TRUE

	sValCar=idw_DetPro.GetItemString ( lCpt, "VAL_CAR") 
	sValCar=lnv_String.of_getkeyvalue( sValCar, "DTE_PIVOT", ";")
	
	dDteDp=Date(sValCar)
	
	if dDteDet > dDteDp Then
		bRet = Uf_RF_EcrireRefus ( 1438 )
	End if
	
End if

Return bRet
end function

private function long uf_zn_trt_divdet_adr_imm_etg (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_adr_imm_etg (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 07/05/2010
//* Libellé			: Contrôle de la zone Num_Prs
//* Commentaires	: [PC301].[LOT2]
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//* Retourne		: long
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------
Int iAction
Long lIdGti, lIdDetail
String sValAvant 

iAction = 0

If Not IsNumber ( asData ) Or Long ( asData ) < 0 Or Long ( asData ) > 100 Then
	iAction = 1
	idw_wDivDet.iiErreur = 5	
End If

Return iAction

end function

private function long uf_zn_trt_divdet_vetuste (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_Vetuste (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 07/10/2005
//* Libellé			: Contrôle de la zone MarqApp
//* Commentaires	: [PC301][VESTUSTE]
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

Integer iAction
iAction = 0



// ON ne touche à rien une fois la prise en charge cochée.
If This.uf_GestOng_Divers_Trouver ("PEC" ) = "O" Then
	idw_wDivDet.iiErreur = 3
	iAction = 1
End If

Return iAction


end function

private function integer uf_zn_mtprej ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_MtPrej (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 18/05/2005 17:14:39
//* Libellé			: 
//* Commentaires	: Controle de MT_PREJ
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer
//*
//*       JFF   21/12/2010   [PC301][VESTUSTE]
//*       JFF   22/11/2023 [RS6175_GC_SCRP_SIM2]
//*-----------------------------------------------------------------

Int iIdi
Long lRow, lDeb, lFin, lRowDS, lIdPRod, lIdGti, lFound
Decimal{2} dcMtValAchat, dcMtVal, dcMtValPublique
String sIdGti, sIdDetail, sFindString
Integer iAction, iDurGtiGc, iVetuste // [PC301][VESTUSTE]
date dDteAchat, dDteSurv

iAction = 0

lIdProd = idw_Produit.GetItemNumber ( 1, "ID_PROD" )
lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )

This.uf_Rendre_Visible_Idireg ( 1 )

dcMtValAchat = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" )
If IsNull ( dcMtValAchat ) Then dcMtValAchat = 0		

dcMtValPublique = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_PUBLIQUE" )
If IsNull ( dcMtValPublique ) Then dcMtValPublique = 0		

// [PC301][VESTUSTE]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 152)
If lDeb > 0 And dcMtValPublique <= 0 Then

	If dcMtValAchat = 0 Then
		idw_wDetailFF.iiErreur = 1
		iAction = 1	
		Return iAction
	End If

	// [RS6175_GC_SCRP_SIM2]
	lRowDS = idw_wDivSin.Find ( "NOM_ZONE = 'duree_gti_orig'", 1, idw_wDivSin.RowCount () )				
	
	If lRowDS <= 0 Then 
		idw_wDetailFF.iiErreur = 24
		iAction = 1	
		Return iAction
	End If

	iDurGtiGc = idw_wDivSin.GetItemDecimal ( lRowDS, "VAL_NBRE" )
	
	If IsNull ( iDurGtiGc ) Then iDurGtiGc = 0
	If iDurGtiGc <= 0 Then
		idw_wDetailFF.iiErreur = 25
		iAction = 1	
		Return iAction
	End If

	sFindString = 	" ID_PROD = " + string(lIdProd) + " AND ID_TYP_CODE_DP = '-DP' AND ID_CODE_DP = 42 AND ID_CODE_NUM = " + string (lIdGti) + " AND ID_CODE_CAR = 'A'"
	lFound = idw_DetPro.Find(sFindString, 1, idw_DetPro.rowCount() )
	If lfound > 0 then
		dDteAchat = idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" )
	Else
		dDteAchat = Date(idw_wSin.GetItemDateTime ( 1, "DTE_ACH_PORT" ) ) // [PI056]
	End If
	
	If dDteAchat = 1900-01-01 Then SetNull ( dDteAchat )
	
	If iAction = 0 And IsNull ( dDteAchat ) Then
		If lFound > 0 Then 
			idw_wDivDet.iiErreur = 5
		Else
			idw_wDivDet.iiErreur = 19
		End If 
		iAction = 1
		Return iAction
	End If

	dDteSurv = Date ( idw_wSin.GetItemDatetime (1, "DTE_SURV" ))
	If IsNull ( dDteSurv ) Then
		idw_wDivDet.iiErreur = 27
		iAction = 1
		Return iAction
	End If

/*
	iVetuste = Long (This.uf_GestOng_Divers_Trouver ("VETUSTE" ) )
	If IsNull ( iVetuste ) Then iVetuste = 0
	If iVetuste <= 0 Then
		idw_wDetailFF.iiErreur = 26
		iAction = 1
		Return iAction		
	End If
*/

	dcMtVal = This.uf_Calcul_MontantVetuste ( "CARREFOUR_GRTV", dcMtValAchat, iDurGtiGc, dDteAchat, dDteSurv )
	idw_wDetailFF.SetItem ( 1, "MT_VAL_PUBLIQUE", dcMtVal )

End If
// :[PC301][VESTUSTE]


/*------------------------------------------------------------------*/
/* Rôle de facturation, droit -NA/208										  */
/*------------------------------------------------------------------*/
If This.uf_GetAutorisation ( 208 ) Then 

	/*------------------------------------------------------------------*/
	/* On force l'inter à régler.                                       */
	/*------------------------------------------------------------------*/
	iIdi = This.uf_Get_Fournisseur_ARegler ()
	If iIdi > 0 Then
		idw_wDetailFF.SetItem ( 1, "ID_I_REG", iIdi )
	End If

	/*------------------------------------------------------------------*/
	/* si ValAchat entre 1 et 10 alors on force à 9999                  */
	/*------------------------------------------------------------------*/
	If IsNull ( dcMtValAchat ) Then dcMtValAchat = 0
	If dcMtValAchat >=1 And dcMtValAchat <=10 Then idw_wDetailFF.SetItem ( 1, "MT_VAL_ACHAT", 9999 )

	idw_wDetailFF.TriggerEvent ( "ue_Btcontroler" )
End If

// [DT058]
If iAction=0 Then
	If not uf_controler_sanction_eco( ) Then
		This.uf_Rendre_Visible_Idireg ( 0 )
		iAction= 2
	End if
End if

// [PC301][VESTUSTE]
Return iAction

	


end function

private function decimal uf_calcul_montantvetuste (string ascas, decimal adcmtvalpivot, integer aidurgtigc, date addteachat, date addtesurv);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Calcul_MontantVetuste (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 21/12/2010
//* Libellé			: [PC301][VESTUSTE]
//* Commentaires	: Calcul du Montant en fonction de la vestuste
//*
//* Arguments		: String		asCas					Val
//*					  Decimal   adcMtValPivot		Val
//*					  Integer   aiDurGtiGc			Val
//*					  Date		adDteAchat			Val
//*					  Date		adDteSurv			Val
//*
//* Retourne		: decimal dcValRetour
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    21/01/2011  [PC301].[V15_EVOL_VETUSTE]
//			 JFF 	  17/09/2015  [VDOC18560]
//        JFF    24/06/2019  [PC192235]
//        JFF    21/10/2020  [VDOC29747]
//        JFF    18/02/2025  [PMO268_MIG25]
//        JFF    18/02/2025  [PMO268_MIG20]
//*-----------------------------------------------------------------
Decimal {2} dcValRetour, dcMtValPublique
Int iVetuste, iJour, iJour2
String sVetuste, sValDte, sVetusteModifie, sVal
Date dVal, dtVal
Long lRow, lDeb, lFin
n_cst_string lnvPFCString
Boolean 	bExclureCalcVetuste //	[VDOC18560]
Boolean 	bSC2FoyerNomade // [PC192235]
Boolean  bProtectEffPers, bEvollis, bOuiBike // [VDOC29747]


If F_CLE_A_TRUE ( "MODIF_CALC_VETUSTE" ) Then
	dcValRetour	= this.uf_Calcul_MontantVetuste_2 ( ascas, adcmtvalpivot, aidurgtigc, addteachat, addtesurv )
	Return dcValRetour	
End IF 
	
dcValRetour	= 0
bExclureCalcVetuste = FALSE

//	[VDOC18560]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 152 )
sVal= Upper ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "EXCL_CALC_VETUSTE", ";"))
bExclureCalcVetuste = sVal = "OUI"

// [PC192235]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 341 )
sVal= Upper ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";"))
bSC2FoyerNomade = sVal = "FOYER_NOMADE"

// [VDOC29747]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 355 )
If lDeb > 0 Then 
	sVal= Upper ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";"))
	bProtectEffPers = sVal = "PROTECT_EFF_PERS"
	bEvollis = sVal = "EVOLLIS" // [PMO268_MIG25]
	bOuiBike = sVal = "OUIBIKE" // [PMO268_MIG20]
	If sVal <> "" And asCas = "" Then
		asCas = sVal
	End If 
End IF 

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 102 )
If lDeb > 0 Then
	idw_wDetailFF.Uf_Proteger ( { "MT_VAL_PUBLIQUE" } , "0" )
Else
	idw_wDetailFF.Uf_Proteger ( { "MT_VAL_PUBLIQUE" } , "1" )	
End If

dcMtValPublique = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_PUBLIQUE" )
If IsNull ( dcMtValPublique ) Then dcMtValPublique = 0	

// [PC192235] // [VDOC29747]
Choose Case True
	Case bSC2FoyerNomade, bProtectEffPers
		// Pas de contrôle
	Case Else 
		If dcMtValPublique > 0 Then
			stMessage.sTitre		= "Prise en charge"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WDET590"
			
			//	[VDOC18560]
			If Not bExclureCalcVetuste Then
				F_Message (stMessage)
			End If 
		End If 			
End Choose 

Choose Case Upper ( asCas )
		

	Case "CARREFOUR_GRTV",  "S2C_FOYER_NOMADE", "PROTECT_EFF_PERS"

		iVetuste = 0

		dtVal = adDteAchat
		iJour = Day ( dtVal )
		Do While dtVal <= adDteSurv
			dtVal = F_Plus_Date ( dtVal, 1, "M" )

			If Day ( dtVal ) <> iJour Then
				iJour2 = iJour
				sValDte = ""

				Do While Not IsDate ( sValDte )
					sValDte = String ( iJour2 ) + "/" + String ( Month ( dtVal )) + "/" + String ( Year ( dtVal ))
					If Not IsDate ( sValDte ) Then
						iJour2 --	
					End If						
				Loop
				
				dtVal = Date ( sValDte )
				
			End If						
				
			If dtVal <= adDteSurv Then
				iVetuste ++
			End If
		Loop

		If dtVal > adDteSurv Then
			dtVal = F_Plus_Date ( dtVal, -1, "M" )				
		End If
		// [PC301].[V15_EVOL_VETUSTE]
		
		sVetuste = String ( iVetuste )
		If adDteSurv > dtVal Then
			
			Choose Case True 
				Case bSC2FoyerNomade, bProtectEffPers
					// Aucun ajout
				Case Else 
					iVetuste += 1
			End CHoose 

			sVetuste = "+" + String ( iVetuste )
			
		End If
		// [PC301].[V15_EVOL_VETUSTE]
		
		lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'VETUSTE'", 1, idw_wDivDet.RowCount () )
		If lRow > 0 Then
			This.uf_GestOng_Divers_MajZone ( "VETUSTE", lRow, sVetuste )
		End If 
		
		If Upper ( asCas ) = "CARREFOUR_GRTV" Then
		
			Choose Case aiDurGtiGc
				
				Case 12
			
					// non géré par SPB, géré par carrefour à 0.9%
					If iVetuste > 12 and iVetuste <= 24 Then
						dcValRetour = 0
					End If
					
					If iVetuste > 24 and iVetuste <= 36 Then
						dcValRetour = adcMtValPivot * 0.8
					End If
	
				Case 24
	
					If iVetuste > 24 and iVetuste <= 36 Then
						dcValRetour = adcMtValPivot * 0.8
					End If
	
					If iVetuste > 36 and iVetuste <= 48 Then
						dcValRetour = adcMtValPivot * 0.7
					End If
	
					If iVetuste > 48 and iVetuste <= 60 Then
						dcValRetour = adcMtValPivot * 0.6
					End If
					
			End Choose
	
		End IF 

		// [VDOC29747]			
		If bProtectEffPers Then
			// 2% de vétusté par mois sur iVetuste mois : soir 
			dcValRetour = adcMtValPivot * 0.98^iVetuste
		End IF 
		
		
		// [PC192235]
		If bSC2FoyerNomade Then
			// 1% par mois d'ancienneté
			dcValRetour = adcMtValPivot * ( 1 - ( 0.01 * iVetuste ))
		End IF 
		
		
		//	[VDOC18560]
		If bExclureCalcVetuste Then
			dcValRetour = adcMtValPivot
			sVetusteModifie = "+0"
			
			lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'VETUSTE'", 1, idw_wDivDet.RowCount () )
			If lRow > 0 Then
				This.uf_GestOng_Divers_MajZone ( "VETUSTE", lRow, sVetusteModifie )
			End If
		End If
		
End Choose

If dcValRetour <= 0 Then
	
	sVetusteModifie = sVetuste + " /calc.imposs.vPublique manuelle"
	
	lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'VETUSTE'", 1, idw_wDivDet.RowCount () )
	If lRow > 0 Then
		This.uf_GestOng_Divers_MajZone ( "VETUSTE", lRow, sVetusteModifie )
	End If
	idw_wDetailFF.Uf_Proteger ( { "MT_VAL_PUBLIQUE" } , "0" ) // #4
	
End If

// [PC192235]
Choose Case True
	Case bSC2FoyerNomade, bProtectEffPers
		// Pas de contrôle
	Case Else 
		If dcMtValPublique > 0 Then
			sVetusteModifie = sVetuste + " /vPubliq.existante non calculée"
		
			lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'VETUSTE'", 1, idw_wDivDet.RowCount () )
			If lRow > 0 Then
				This.uf_GestOng_Divers_MajZone ( "VETUSTE", lRow, sVetusteModifie )
			End If
			
			dcValRetour = dcMtValPublique 
		End If
		
End Choose 

Return dcValRetour

end function

private function long uf_zn_trt_divdet_calculvetuste (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_CalculVetuste (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 07/10/2011
//* Libellé			: Calcul de la vetuste
//* Commentaires	: 
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//* Retourne		: long
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//			 JFF 	  17/09/2015  [VDOC18560]
//        JFF    24/06/2019  [PC192235]
//        JFF    22/11/2023  [RS6175_GC_SCRP_SIM2]
//*-----------------------------------------------------------------

Decimal {2} dcMtValAchat, dcMtVal, dcMtValPublique
Int iAction, iDurGtiGc 
Long lRowDs, lIdProd, lIdGti, lFound, lRow, lVal
String sFindString, sVal
Date dDteAchat, dDteSurv 
Boolean 	bExclureCalcVetuste //	[VDOC18560]
Boolean 	bSC2FoyerNomade // [PC192235]
Long 		lDeb, lFin
n_cst_string lnvPFCString

iAction = 0

asData = Upper ( asData ) 
bExclureCalcVetuste = FALSE

dcMtValAchat = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" )
If IsNull ( dcMtValAchat ) Then dcMtValAchat = 0		

// [PC192235]
dcMtValPublique = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_PUBLIQUE" )
If IsNull ( dcMtValPublique ) Then dcMtValPublique = 0		

//	[VDOC18560]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 152 )
sVal= Upper ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "EXCL_CALC_VETUSTE", ";"))
bExclureCalcVetuste = sVal = "OUI"

// [PC192235]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 341 )
sVal= Upper ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";"))
bSC2FoyerNomade = sVal = "FOYER_NOMADE"

Choose Case asData
	
	Case "O"
		stMessage.bErreurG	= FALSE
		stMessage.sTitre		= "Information"
		stMessage.Icon			= Exclamation!
		stMessage.bouton		= YesNo!
		stMessage.sCode 		= "WDET588" 

		//	[VDOC18560]
		If bExclureCalcVetuste Then
			stMessage.sCode = "WDET645"
		End If

		If f_Message ( stMessage ) = 2 Then
			iAction = 1
			stMessage.bErreurG	= FALSE
			stMessage.sTitre		= "Information"
			stMessage.Icon			= Information!
			stMessage.bouton		= Ok!
			stMessage.sCode 		= "WDET589" 
			Return iAction
		End If

		If dcMtValAchat = 0 Then
			idw_wDivDet.iiErreur = 18
			iAction = 1
			Return iAction
		End If

		// [PC192235]
		If Not bSC2FoyerNomade Then
			
			// [RS6175_GC_SCRP_SIM2]
			lRowDS = idw_wDivSin.Find ( "NOM_ZONE = 'duree_gti_orig'", 1, idw_wDivSin.RowCount () )				
		
			If lRowDS <= 0 Then 
				idw_wDivDet.iiErreur = 24
				iAction = 1	
				Return iAction
			End If
			
			iDurGtiGc = idw_wDivSin.GetItemDecimal ( lRowDS, "VAL_NBRE" )
			
			If IsNull ( iDurGtiGc ) Then iDurGtiGc = 0
			If iDurGtiGc <= 0 Then
				idw_wDivDet.iiErreur = 25
				iAction = 1	
				Return iAction
			End If				
		End IF 

		sFindString = 	" ID_PROD = " + string(lIdProd) + " AND ID_TYP_CODE_DP = '-DP' AND ID_CODE_DP = 42 AND ID_CODE_NUM = " + string (lIdGti) + " AND ID_CODE_CAR = 'A'"
		lFound = idw_DetPro.Find(sFindString, 1, idw_DetPro.rowCount() )
		If lfound > 0 then
			dDteAchat = idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" )
		Else
			dDteAchat = Date(idw_wSin.GetItemDateTime ( 1, "DTE_ACH_PORT" ) ) // [PI056]
		End If
		
		If dDteAchat = 1900-01-01 Then SetNull ( dDteAchat )
		
		If iAction = 0 And IsNull ( dDteAchat ) Then
			If lFound > 0 Then 
				idw_wDivDet.iiErreur = 5
			Else
				idw_wDivDet.iiErreur = 19
			End If 
			iAction = 1
			Return iAction
		End If
		
		dDteSurv = Date ( idw_wSin.GetItemDatetime (1, "DTE_SURV" ))
		If IsNull ( dDteSurv ) Then
			idw_wDivDet.iiErreur = 27
			iAction = 1
			Return iAction
		End If
		
		/*
		iVetuste = Long (This.uf_GestOng_Divers_Trouver ("VETUSTE" ) )
		If IsNull ( iVetuste ) Then iVetuste = 0
		If iVetuste <= 0 Then
			idw_wDivDet.iiErreur = 26
			iAction = 1
			Return iAction		
		End If
		*/
		
		// [PC192235]
		Choose Case True
			Case bSC2FoyerNomade
				dcMtVal = This.uf_Calcul_MontantVetuste ( "S2C_FOYER_NOMADE", dcMtValPublique, iDurGtiGc, dDteAchat, dDteSurv )					
			Case Else 
				dcMtVal = This.uf_Calcul_MontantVetuste ( "CARREFOUR_GRTV", dcMtValAchat, iDurGtiGc, dDteAchat, dDteSurv )
				
		End Choose 
		
		idw_wDetailFF.SetItem ( 1, "MT_VAL_PUBLIQUE", dcMtVal )
			
	Case "N"

		lVal = idw_wDetailFF.GetItemNumber ( 1, "COD_ETAT" ) 
		
		Choose Case lVal
			Case 500, 600
				idw_wDivDet.iiErreur = 16
				iAction = 1
				Return iAction
				
		End Choose

		If alRow > 0 Then
			If idw_wDivDet.GetItemString ( alRow, "VAL_CAR", Primary!, TRUE ) = "O" And &
			   idw_wDivDet.GetItemNumber ( alRow, "CPT_VALIDE" ) > 0 Then
				idw_wDivDet.iiErreur = 16
				iAction = 1
				Return iAction
			End If
		End If

		lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'PEC'", 1, idw_wDivDet.RowCount () )
		If lRow > 0 Then
			If idw_wDivDet.GetItemString ( lRow, "VAL_CAR" ) = "O" Then
				idw_wDivDet.iiErreur = 16
				iAction = 1
				Return iAction
			End If
		End If
		
		If This.uf_Deja_Une_Commande () Then
			idw_wDivDet.iiErreur = 17
			iAction = 1
			Return iAction			
		End If			

		lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'VETUSTE'", 1, idw_wDivDet.RowCount () )
		If lRow > 0 Then
			This.uf_GestOng_Divers_MajZone ( "VETUSTE", lRow, "" )
			idw_wDetailFF.SetItem ( 1, "MT_VAL_PUBLIQUE", 0 )
		End If 

End Choose

//Migration PB8-WYNIWYG-03/2006 OR
//idw_wDivDet.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function string uf_plaf_evt ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Evt (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Application d'un plafond par événement
//*
//* Arguments		: Aucun
//*
//* Retourne		: sPos
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   14/11/2003	  Ajouts de deux gestion particulères de plafonds :
//*								  .1 : Plaf type 671 paramétré sur EVT alors --> Plaf sur Mt_prej avec ValAchat saisi, 
//*										 puis sur Evt ensuite
//*								  .2 : Plaf type 672 parmétré sur EVT --> Plaf sur Max (TTC) Des TEL choisi, puis Evt
//* #2    JFF   23/02/2007   [DCMP070059]
//*       JFF   21/01/2011  [PC301].[V15_EVOL_VETUSTE]
//*       JFF   27/07/2011  [PLAF_REF]
//  		 JFF	 29/05/2012  [VDOC6662]
//        JFF   02/04/2013  [PC929_CDISCOUNT]
//		FPI	26/07/2013	[PC952]
//       JFF   16/11/2015 [DT159-1]
//       JFF   07/08/2019 [PM462-1]
// 		JFF	22/10/2020 [VDOC29747]
//       JFF   05/08/2024 [MCO602_PNEU]
//*-----------------------------------------------------------------
Long lTotPlaf, lLig, lTotDetail, lCptDet, lRow, lDeb, lFin, lCpt
Decimal {2} dcPlafond, dcMtnPlaf, dcMtPlaf, dcTxMinMajPlafond, dcMtLu, dcMtMaxLu, dcEcoTaxe, dcMtCpltPayBoxSCM, dcMtVal, dcMtPrej 
Boolean bMobSinEgMobCmde // #2
String sRech, sIdPara, sCptVer, sDteProdEqvFc, sPos, sVal, sPlafond
Decimal {5} dcTxVetustePC
DateTime dtDteSurv, dtDteAchat, dtDteAchatDet 
boolean bAutoriserTRT 
Long lIdProd , lIdGti, lIdDetail
String sIdTypArt, sTypePrestaDp384, sTypePrestaDs
n_cst_string lnvPFCString

dcMtCpltPayBoxSCM = 0

lTotPlaf = idw_Plafond.RowCount ()
sPos = ""

lIdGti=idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
lIdDetail=idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" )

// [PC929_CDISCOUNT]
dcTxVetustePC = 1
bAutoriserTRT = TRUE

lIdProd = idw_wSin.GetItemNumber ( 1, "ID_PROD" ) 
lRow = idw_wDivSin.Find ( "NOM_ZONE = 'type_app'", 1,  idw_wDivSin.RowCount () )
If lRow >=0 Then
	sIdTypArt = Upper ( idw_wDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) )
Else 
	bAutoriserTRT = False
End If
	
If IsNull ( sIdTypArt ) Or Len ( Trim ( sIdTypArt )) = 0 Then bAutoriserTRT = False


dtDteSurv = idw_wSin.GetItemDateTime ( 1, "DTE_SURV" )
If IsNull ( dtDteSurv ) Then bAutoriserTRT = False

dtDteAchat = idw_wSin.GetItemDateTime ( 1, "DTE_ACH_PORT" )  // [PI056]
If IsNull ( dtDteAchat ) Then bAutoriserTRT = False


If bAutoriserTRT Then
	// [PC952]
	sVal = Space ( 20 )
	SQLCA.PS_GET_VTS_PEC_V01 ( lIdProd, sIdTypArt, lIdGti, dtDteSurv, dtDteAchat, sVal )
	// :[PC952]			
	
	If Trim ( sVal ) = "" Then
		dcTxVetustePC = 1 
	Else
		dcTxVetustePC = Dec ( sVal ) 					
	End If 
	
End If 

// [VDOC29747] Gestion d'une vétusté pour produit monétique (juste mt_prej)
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 355 )
If lDeb > 0 Then
	dtDteAchatDet = idw_wDetailFF.GetItemDateTime ( 1, "DTE_DET" )
	dcMtPrej = idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" )
	sVal= Upper ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "ID_GTI", ";"))
	If IsNull ( sVal ) Then sVal = ""
	If Pos ( sVal, "#" + String ( lIdGti ) + "#" ) > 0 And not isnull (dtDteAchatDet) And not isnull (dtDteSurv) Then
		dcMtVal = This.uf_Calcul_MontantVetuste ( "", dcMtPrej, 0, Date (dtDteAchatDet), Date(dtDteSurv ))
		If dcMtVal > 0 Then
			idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcMtVal )
		End IF 
	End If 
End If 

// #2
bMobSinEgMobCmde = This.uf_Gestion_cond_plaf_671_675 () = "MOB_SINISTRE_=_MOB_COMMANDE"

/*------------------------------------------------------------------*/
/* #1.1 : JFF le 14/11/2003                                         */
/* 671 :  PLAF. RBT. EVT. DYN FCT(VAL.ACHAT)								  */
/*------------------------------------------------------------------*/
sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
				"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
				"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
				"ID_NIV_PLAF = '+EV'" 																			+ " AND " 	+ &
				"ID_REF_PLAF = "	+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) ) 	+ " AND " 	+ &
				"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
				"ID_TYP_PLAF = '671'"

lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )
If	lLig > 0 And Not bMobSinEgMobCmde Then  // #2

	/*------------------------------------------------------------------*/
	/* Lecture de la valeur d'achat.                                    */
	/*------------------------------------------------------------------*/
	// [PC929_CDISCOUNT]
	dcPlafond  = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" ) * dcTxVetustePC

	/*------------------------------------------------------------------*/
	/* Minoration ou Majoration du plafond avec un pourcentage saisi    */
	/* sur le paramètrage du produit.                                   */
	/*------------------------------------------------------------------*/
	dcPlafond += dcPlafond * idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

	// [DT159-1]
	F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
	If lDeb > 0 Then 	
		dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
		If dcEcoTaxe > 0 Then 
			dcPlafond += dcEcoTaxe 
		End If
	End If

	// [PM462-1] Cplt de paiement PayBox par CB sru le SCM ?
	// SI oui, on le prend en compte pour éviter de forcer le dossier.
	// [PM462-1]
	/*
	If F_CLE_A_TRUE ( "PM462-1" ) Then
		lRow = idw_LstCmdeSin.Find ( & 
		" ID_GTI = " + string ( lIdGti ) + & 
		" AND ID_DETAIL = " + string ( lIdDetail ) + & 
		" AND POS ( INFO_SPB_FRN_CPLT, 'MT_CPLT_PAYBOX_SCM' ) > 0 " & 
		,1, idw_LstCmdeSin.RowCount () )
		
		If lRow > 0 Then
			sVal = lnvPFCString.of_getkeyvalue (idw_LstCmdeSin.GetItemString ( lRow, "INFO_SPB_FRN_CPLT" ), "MT_CPLT_PAYBOX_SCM", ";")
			If IsNumber ( sVal ) Then 
				dcMtCpltPayBoxSCM = Dec ( sVal )
				
				If dcMtCpltPayBoxSCM > 0 Then
					dcPlafond += dcMtCpltPayBoxSCM 
				End IF 
			End If 
		End IF 
	End If
	*/

	If dcPlafond > 0 Then
			dcMtnPlaf = idw_wDetailFF.GetItemDecimal ( 1, "MT_NPLAF" )
			dcMtPlaf  = idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF" )

		If	 ( dcMtPlaf > dcPlafond ) Or ( dcMtnPlaf > dcPlafond And dcMtPlaf = 0 ) Then

			If dcPlafond > 0 Then
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcPlafond )
				
				// [PLAF_REF] // [VDOC6662]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "671", "REF_PLAF_NUM_>0" )
				
			Else			
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
				// [PLAF_REF]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "671", "NORMAL" )
			End If			

			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "671", sIdPara, sCptVer )
			
			
		End IF
	End If
End If

/*------------------------------------------------------------------*/
/* #1.2 : JFF le 14/11/2003                                         */
/* 672 :  PLAF. EVT. FCT(MAX.TTC MOB CHOISI)								  */
/*------------------------------------------------------------------*/
sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
				"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
				"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
				"ID_NIV_PLAF = '+EV'" 																			+ " AND " 	+ &
				"ID_REF_PLAF = "	+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) ) 	+ " AND " 	+ &
				"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
				"ID_TYP_PLAF = '672'"

lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )
If	lLig > 0 Then

	/*------------------------------------------------------------------*/
	/* Armement par le Max TTC des mobile choisi.							  */
	/*------------------------------------------------------------------*/
	dcPlafond = This.uf_MaxTTC_MobileChoisi ()

	/*------------------------------------------------------------------*/
	/* Minoration ou Majoration du plafond avec un pourcentage saisi    */
	/* sur le paramètrage du produit.                                   */
	/*------------------------------------------------------------------*/
	dcPlafond += dcPlafond * idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

	// [DT159-1]
	F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
	If lDeb > 0 Then 	
		dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
		If dcEcoTaxe > 0 Then 
			dcPlafond += dcEcoTaxe 
		End If
	End If

	If dcPlafond > 0 Then
		dcMtnPlaf = idw_wDetailFF.GetItemDecimal ( 1, "MT_NPLAF" )
		dcMtPlaf  = idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF" )

		If	 ( dcMtPlaf > dcPlafond ) Or ( dcMtnPlaf > dcPlafond And dcMtPlaf = 0 ) Then

			If dcPlafond > 0 Then
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcPlafond )
				
				// [PLAF_REF] // [VDOC6662]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "672", "REF_PLAF_NUM_>0" )
				
			Else			
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
				// [PLAF_REF]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "672", "NORMAL" )
			End If			

			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "672", sIdPara, sCptVer )
	
		End IF
	End If
End If

/*------------------------------------------------------------------*/
/* 675 :  PLAF EVT DYN FCT(VAL.PUBLIQU)+/-Tx%    						  */
/*------------------------------------------------------------------*/
sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
				"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
				"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
				"ID_NIV_PLAF = '+EV'" 																			+ " AND " 	+ &
				"ID_REF_PLAF = "	+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) ) 	+ " AND " 	+ &
				"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
				"ID_TYP_PLAF = '675'"

lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

/*------------------------------------------------------------------*/
/* contrôle : On n'applique ce plafond que si le dossier a          */
/* été créé postérieurement à la mep du projet Equiv. Fct. Vu avec  */
/* C. Chauvin le 28/10/2004                                         */
/*------------------------------------------------------------------*/
/* Date de mise en production de l'Equiv Fct.                       */
/*------------------------------------------------------------------*/
sDteProdEqvFc = ProfileString ( stGlb.sFichierIni, "DIVERS", "DATE_PRODUCTION_EQV_FCT", "01/01/2000" )
sDteProdEqvFc = Right (sDteProdEqvFc, 4) + "-" + Mid (sDteProdEqvFc, 4, 2 ) + "-" + Left (sDteProdEqvFc, 2) 

If	lLig > 0 And Date ( idw_wSin.GetItemDateTime ( 1, "CREE_LE" ) ) >= Date ( sDteProdEqvFc ) And Not bMobSinEgMobCmde Then  // #2 

	/*------------------------------------------------------------------*/
	/* Lecture de la valeur d'achat.                                    */
	/*------------------------------------------------------------------*/
	dcPlafond  = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_PUBLIQUE" )

	/*------------------------------------------------------------------*/
	/* Minoration ou Majoration du plafond avec un pourcentage saisi    */
	/* sur le paramètrage du produit.                                   */
	/*------------------------------------------------------------------*/
	dcPlafond += dcPlafond * idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

	// [DT159-1]
	F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
	If lDeb > 0 Then 	
		dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
		If dcEcoTaxe > 0 Then 
			dcPlafond += dcEcoTaxe 
		End If
	End If

	// [PM462-1] Cplt de paiement PayBox par CB sru le SCM ?
	// SI oui, on le prend en compte pour éviter de forcer le dossier.
	// [PM462-1]
/*	
	If F_CLE_A_TRUE ( "PM462-1" ) Then
		lRow = idw_LstCmdeSin.Find ( & 
		" ID_GTI = " + string ( lIdGti ) + & 
		" AND ID_DETAIL = " + string ( lIdDetail ) + & 
		" AND POS ( INFO_SPB_FRN_CPLT, 'MT_CPLT_PAYBOX_SCM' ) > 0 " & 
		,1, idw_LstCmdeSin.RowCount () )
		
		If lRow > 0 Then
			sVal = lnvPFCString.of_getkeyvalue (idw_LstCmdeSin.GetItemString ( lRow, "INFO_SPB_FRN_CPLT" ), "MT_CPLT_PAYBOX_SCM", ";")
			If IsNumber ( sVal ) Then 
				dcMtCpltPayBoxSCM = Dec ( sVal )
				
				If dcMtCpltPayBoxSCM > 0 Then
					dcPlafond += dcMtCpltPayBoxSCM 
				End IF 
			End If 
		End IF 
	End If
*/

	If dcPlafond > 0 Then
			dcMtnPlaf = idw_wDetailFF.GetItemDecimal ( 1, "MT_NPLAF" )
			dcMtPlaf  = idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF" )

		If	 ( dcMtPlaf > dcPlafond ) Or ( dcMtnPlaf > dcPlafond And dcMtPlaf = 0 ) Then

			If dcPlafond > 0 Then
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcPlafond )

				// [PLAF_REF] // [VDOC6662]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "675", "REF_PLAF_NUM_>0" )

				
			Else
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
				// [PLAF_REF]
				ibPlafNumeraire = TRUE // [PLAF_REF]				
				sPos = Uf_Plaf_Refus ( "675", "NORMAL" )
			End If 

			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "675", sIdPara, sCptVer )
			
		End IF
	End If
End If

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par événement.                 */
/*------------------------------------------------------------------*/
sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
				"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
				"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
				"ID_NIV_PLAF = '+EV'" 																			+ " AND " 	+ &
				"ID_REF_PLAF = "	+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) ) 	+ " AND " 	+ &
				"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
				"ID_TYP_PLAF = '670'"


lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )
If	lLig > 0 Then
	dcPlafond = idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
	
	// [DT159-1]
	F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
	If lDeb > 0 Then 	
		dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
		If dcEcoTaxe > 0 Then 
			dcPlafond += dcEcoTaxe 
		End If
	End If
	
	If dcPlafond > 0 Then
		dcMtnPlaf = idw_wDetailFF.GetItemDecimal ( 1, "MT_NPLAF" )
		dcMtPlaf  = idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF" )

		If	 ( dcMtPlaf > dcPlafond ) Or ( dcMtnPlaf > dcPlafond And dcMtPlaf = 0 ) Then

			If dcPlafond > 0 Then
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcPlafond )
				
				// [PLAF_REF] // [VDOC6662]
				ibPlafNumeraire = TRUE // [PLAF_REF]				
				sPos = Uf_Plaf_Refus ( "670", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
				// [PLAF_REF]
				ibPlafNumeraire = TRUE // [PLAF_REF]				
				sPos = Uf_Plaf_Refus ( "670", "NORMAL" )
			End If

		/*------------------------------------------------------------------*/
		/* On insére le paragraphe de plafond dans la DW.                   */
		/*------------------------------------------------------------------*/
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "670", sIdPara, sCptVer )
			
			
		End If
	End If
End If

// [MCO602_PNEU]
If Not F_CLE_A_TRUE ( "MCO602_PNEU" ) Then
	If idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF" ) < 0 Then
		idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
	End If
End If

// [PC301].[V15_EVOL_VETUSTE]
// Plafonf 722
sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
				"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
				"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
				"ID_NIV_PLAF = '+EV'" 																			+ " AND " 	+ &
				"ID_REF_PLAF = "	+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) ) 	+ " AND " 	+ &
				"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
				"ID_TYP_PLAF = '722'"

lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )
If	lLig > 0 Then  // #2

	dcTxMinMajPlafond = idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
	
	lTotDetail = idw_wDetailFF.iudwDetailSource.RowCount ()
	dcMtLu = 0
	dcMtMaxLu = 0
	For lCptDet = 1 To lTotDetail	
		
		Choose Case idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCptDet, "COD_ETAT" ) 
			Case 900
				// Je ne compte pas ce plafond sur les Sans suite
				
			Case Else
				sRech	=		"ID_GTI = "	+ String ( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCptDet, "ID_GTI" ) )	+ " AND " 	+ &
								"ID_DETAIL = "	+ String ( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCptDet, "ID_DETAIL" ) )	+ " AND " 	+ &
								"UPPER ( NOM_ZONE ) = 'MT_MAX_PROPO_PLF722'"

				
				lRow = idw_wDivDetGti.Find ( sRech, 1, idw_wDivDetGti.RowCount () ) 
				If lRow > 0 Then
					dcMtLu = idw_wDivDetGti.GetItemDecimal ( lRow, "VAL_MT" )
					If dcMtLu > dcMtMaxLu Then
						dcMtMaxLu = dcMtLu 
					End If
				End If					
				
		End Choose
		
	Next
	
	If dcMtMaxLu > 0 Then
		dcMtMaxLu += dcMtMaxLu * dcTxMinMajPlafond 
	End If	

	// [DT159-1]
	F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
	If lDeb > 0 Then 	
		dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
		If dcEcoTaxe > 0 Then 
			dcPlafond += dcEcoTaxe 
		End If
	End If


	// [DT159-1]
	If dcPlafond > 0 OR ( dcMtMaxLu > 0 ) Then
		dcMtnPlaf = idw_wDetailFF.GetItemDecimal ( 1, "MT_NPLAF" )
		dcMtPlaf  = idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF" )

		If	 ( dcMtPlaf > dcMtMaxLu ) Or ( dcMtnPlaf > dcMtMaxLu And dcMtPlaf = 0 ) Then

			If dcMtMaxLu > 0 Then
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcMtMaxLu )
				
				// [PLAF_REF] // [VDOC6662]
				ibPlafNumeraire = TRUE // [PLAF_REF]				
				sPos = Uf_Plaf_Refus ( "722", "REF_PLAF_NUM_>0" )
				
			Else 
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
				// [PLAF_REF]
				ibPlafNumeraire = TRUE // [PLAF_REF]				
				sPos = Uf_Plaf_Refus ( "722", "NORMAL" )
			End If

			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "722", sIdPara, sCptVer )
			
			
		End IF
	End If
End If
// :[PC301].[V15_EVOL_VETUSTE]

// [MCO602_PNEU]
If F_CLE_A_TRUE ( "MCO602_PNEU" ) Then
	
	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond par événement.                 */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '+EV'" 																			+ " AND " 	+ &
					"ID_REF_PLAF = "	+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) ) 	+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '763'"
	
	
	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )
	If	lLig > 0 Then

		lRow = idw_wDivSin.Find ( "NOM_ZONE = 'typ_presta'", 1,  idw_wDivSin.RowCount () )
		sTypePrestaDs = ""
		If lRow > 0 Then
			sTypePrestaDs = idw_wDivSin.GetItemString ( lRow, "VAL_CAR" ) 
		End If	

		sTypePrestaDp384 = ""
		dcPlafond = 0
		If sTypePrestaDs <> "" Then
			F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 384)

			If lDeb > 0 Then 
				For lCpt = lDeb To lFin 
					sVal = iDw_DetPro.GetItemString ( lCpt, "VAL_CAR" ) 
					sTypePrestaDp384 = F_CLE_VAL ( "TYP_PRESTA", sVal, ";" )
					If sTypePrestaDp384 = sTypePrestaDs Then
						sPlafond = F_CLE_VAL ( "MT_PLAF", sVal, ";" )						
						dcPlafond = 0
						If IsNumber ( sPlafond ) Then
							dcPlafond = Dec ( sPlafond ) 
							Exit
						End If 
					End If 
				Next 
			End IF 
		End If 		
		
		If dcPlafond > 0 Then
			
			dcMtnPlaf = idw_wDetailFF.GetItemDecimal ( 1, "MT_NPLAF" )
			dcMtPlaf  = idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF" )
	
			If	 ( dcMtPlaf > dcPlafond ) Or ( dcMtnPlaf > dcPlafond And dcMtPlaf = 0 ) Then
	
				If dcPlafond > 0 Then
					idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcPlafond )
					
					// [PLAF_REF] // [VDOC6662]
					ibPlafNumeraire = TRUE // [PLAF_REF]				
					sPos = Uf_Plaf_Refus ( "763", "REF_PLAF_NUM_>0" )
					
				Else
					idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
					// [PLAF_REF]
					ibPlafNumeraire = TRUE // [PLAF_REF]				
					sPos = Uf_Plaf_Refus ( "763", "NORMAL" )
				End If
	
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
				idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )
				sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
				sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
				Uf_Plaf_EcrirePara ( "763", sIdPara, sCptVer )
				
				
			End If
		End If
	End If
End IF 

// [MCO602_PNEU]
// A laisser à la fin
If F_CLE_A_TRUE ( "MCO602_PNEU" ) Then
	If idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF" ) < 0 Then
		idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
	End If
End If


Return sPos // [PLAF_REF]
end function

private function string uf_plaf_sin ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Sin (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Application d'un plafond par sinistre
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]			
//  		 JFF		29/05/2012  [VDOC6662]
//        JFF    11/10/2013  [VDOC12475]
//       JFF   16/11/2015 [DT159-1]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale, lDeb, lFin

Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafTmp, dcPlafSav, dcEcoTaxe 
String sRech, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf, sPos
n_cst_string lnvPFCString

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0
sPos = ""

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt

		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement
			sIdRefPlaf = String ( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '680'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
	lTotDetail = idw_wDetailFF.iudwDetailSource.RowCount ()
/*------------------------------------------------------------------*/
/* On s'occupe du détail courant, en insertion ou en modification.  */
/* Ce détail ne sera pas traité dans la boucle.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modification DBI le 12/08/1998                                   */
/*                                                                  */
/* La zone à prendre en compte pour le calcul du montant plafonné   */
/* n'est pas MT_NPLAF      mais MT_PLAF      sinon on ne            */
/* tient pas compte des plafonds appliqués successivement           */
/*------------------------------------------------------------------*/

	dcMtPlaf		= idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF" )
	lIdDetail	= idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" )

	For	lCpt = 1 To lTotDetail
/*------------------------------------------------------------------*/
/* On ne traite pas le détail courant.                              */
/*------------------------------------------------------------------*/
			If		idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_DETAIL" ) = lIdDetail	Then
					Continue
			Else
/*------------------------------------------------------------------*/
/* Le détail est 'REGLE' ou 'A REGLE', on récupére le montant       */
/* MT_PLAF.                                                         */
/*------------------------------------------------------------------*/
				// [VDOC12475]
				If	( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 500   Or  &
					  idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 600 ) And &
					( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) = idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_EVT" ) ) Then

						dcSommeDetail += idw_wDetailFF.iudwDetailSource.GetItemDecimal ( lCpt, "MT_PLAF" )
					End If
			End If
	Next
/*------------------------------------------------------------------*/
/* On additionne la somme des détails avec le montant du détail     */
/* courant.                                                         */
/*------------------------------------------------------------------*/

	dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

	// [DT159-1]
	F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
	If lDeb > 0 Then 	
		dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
		If dcEcoTaxe > 0 Then 
			dcPlafond += dcEcoTaxe 
		End If
	End If

	If	dcSommeDetail + dcMtPlaf > dcPlafond	Then

		If dcPlafond - dcSommeDetail  > 0 Then
			idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcPlafond - dcSommeDetail  )
			
			// [PLAF_REF] // [VDOC6662]
			ibPlafNumeraire = TRUE // [PLAF_REF]
			sPos = Uf_Plaf_Refus ( "680", "REF_PLAF_NUM_>0" )
			
		Else
			
			idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
			// [PLAF_REF]
			ibPlafNumeraire = TRUE // [PLAF_REF]			
			sPos = Uf_Plaf_Refus ( "680", "NORMAL" )
		End If

		idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )
		/*------------------------------------------------------------------*/
		/* On insére le paragraphe de plafond dans la DW.                   */
		/*------------------------------------------------------------------*/
		sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
		sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
		Uf_Plaf_EcrirePara ( "680", sIdPara, sCptVer )


	End If
End If
	
If idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF" ) < 0 Then
	idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
End If

Return ( sPos ) // [PLAF_REF]


end function

private function string uf_plaf_sin_carte ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Sin_Carte (PRIVATE)
//* Auteur			: Fabyr JF
//* Date				: 12/03/2002
//* Libellé			: 
//* Commentaires	: Application d'un plafond par sinistre pour les opérations
//*					  par Cartes (682) DCMP20115
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]			
//  		 JFF		29/05/2012  [VDOC6662]
//       JFF     16/11/2015 [DT159-1]
//  		 JFF		13/02/2018  [VDOC25656] 1442
//  		 JFF		06/03/2018  [VDOC25800] 745
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lIdEvt, lLigFinale, lDeb, lFin
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcAregFinal, dcPlafTmp, dcPlafSav, dcEcoTaxe 
String sRech, sIdPara, sCptVer,sIdNivPlaf, sIdRefPlaf, sPos
n_cst_string lnvPFCString

lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0
sPos = ""

/*------------------------------------------------------------------*/
/* On applique ce plafond que pour un événement par carte.          */
/*------------------------------------------------------------------*/
lIdEvt = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )

// [VDOC25656]
// [VDOC25800]
Choose case lIdEvt 
	Case 700 TO 719, 1442, 745
		// Ok
	Case Else 
		Return sPos
End Choose 


/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 1 to 5

	Choose Case lCpt
		Case 1
			sIdNivPlaf = "-GA"  // Garantie
			sIdRefPlaf = "-1"
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement
			sIdRefPlaf = String ( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '682'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
	lTotDetail = idw_wDetailFF.iudwDetailSource.RowCount ()
/*------------------------------------------------------------------*/
/* On s'occupe du détail courant, en insertion ou en modification.  */
/* Ce détail ne sera pas traité dans la boucle.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modification DBI le 12/08/1998                                   */
/*                                                                  */
/* La zone à prendre en compte pour le calcul du montant plafonné   */
/* n'est pas MT_NPLAF      mais MT_PLAF      sinon on ne            */
/* tient pas compte des plafonds appliqués successivement           */
/*------------------------------------------------------------------*/

	dcMtPlaf		= idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF" )

	lIdDetail	= idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" )

	For	lCpt = 1 To lTotDetail

/*------------------------------------------------------------------*/
/* On ne cumule que les opérations par Cartes.                      */
/*------------------------------------------------------------------*/
			lIdEvt = idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_EVT" )

			// [VDOC25656]
			// [VDOC25800]			
			Choose case lIdEvt 
				Case 700 TO 719, 1442, 745
					// Ok
				Case Else 
					Continue
			End Choose 
				
/*------------------------------------------------------------------*/
/* On ne traite pas le détail courant.                              */
/*------------------------------------------------------------------*/
			If		idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_DETAIL" ) = lIdDetail	Then
					Continue
			Else
/*------------------------------------------------------------------*/
/* Le détail est 'REGLE' ou 'A REGLE', on récupére le montant       */
/* MT_PLAF.                                                         */
/*------------------------------------------------------------------*/
				If	( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 500   Or  &
					  idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 600 ) Then

						dcSommeDetail += idw_wDetailFF.iudwDetailSource.GetItemDecimal ( lCpt, "MT_PLAF" )
					End If
			End If
	Next
/*------------------------------------------------------------------*/
/* On additionne la somme des détails avec le montant du détail     */
/* courant.                                                         */
/*------------------------------------------------------------------*/

	dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

	// [DT159-1]
	F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
	If lDeb > 0 Then 	
		dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
		If dcEcoTaxe > 0 Then 
			dcPlafond += dcEcoTaxe 
		End If
	End If

	If	dcSommeDetail + dcMtPlaf > dcPlafond	Then

		dcAregFinal = dcPlafond - dcSommeDetail
		If dcAregFinal < 0 Then dcAregFinal = 0

		If dcAregFinal > 0 Then
			idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcAregFinal )
			
			// [PLAF_REF] // [VDOC6662]
			ibPlafNumeraire = TRUE // [PLAF_REF]			
			sPos = Uf_Plaf_Refus ( "682", "REF_PLAF_NUM_>0" )
			
		Else
			idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
			// [PLAF_REF]
			ibPlafNumeraire = TRUE // [PLAF_REF]			
			sPos = Uf_Plaf_Refus ( "682", "NORMAL" )
		End If

		idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )

		/*------------------------------------------------------------------*/
		/* On insére le paragraphe de plafond dans la DW.                   */
		/*------------------------------------------------------------------*/
		sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
		sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
		Uf_Plaf_EcrirePara ( "682", sIdPara, sCptVer )

	End If
End If
	
If idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF" ) < 0 Then
	idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
End If

Return sPos // [PLAF_REF]

end function

private subroutine uf_controlergestion_altregparam (ref string aspos);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerGestion_AltRegParam (PRIVATE)
//* Auteur			: JFF
//* Date				: 27/10/2011
//* Libellé			: [VDOC5453]
//* Commentaires	: 
//*
//* Arguments		: String		asPos		Réf.
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 	  JFF	05/11/2015	[ITSM338938]
//*-----------------------------------------------------------------


Long lCpt, lLig, lIdRev, lIdGTi
String sIdTypCode, sMess, sMess2, sIdCode, sRech, sAltReg

lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
lIdRev = idw_wSin.GetItemNumber ( 1, "ID_REV" )

// [ITSM338938]
sAltReg = idw_wDetailFF.GetItemString ( 1, "ALT_REG" )
If sAltReg = "O" Then Return

For lCpt = 2 to 5

	Choose Case lCpt

		Case 2
			sIdTypCode = "+NS"  // Nature de sinistre
			sIdCode = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
			sMess = "La nature du sinistre"
			sMess2 = "couverte"
		Case 3
			sIdTypCode = "+TR"  // Territorialité
			sIdCode = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
			sMess = "La territorialité"
			sMess2 = "couverte"
		Case 4
			sIdTypCode = "+DT"  // Détail de sinistre
			sIdCode = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
			sMess = "Le détail de sinistre "					
			sMess2 = "couvert"
		Case 5
			sIdTypCode = "+EV"  // Evénement de garantie
			sIdCode = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )
			sMess = "L'événement du détail de garantie"
			sMess2 = "couvert"

	End Choose

	If IsNull ( sIdCode ) Then Continue

	sRech	=		"ID_REV = "			+ String ( lIdRev ) 		+ " AND " 	+ &
					"ID_GTI = "			+ String ( lIdGti )		+ " AND " 	+ &
					"ID_TYP_CODE = '"  + sIdTypCode 	+ "' AND " 	+ &
					"ID_CODE = "  + sIdCode + " AND " 	+ &
					"ALT_REG = 'N'"

	lLig = idw_Condition.Find ( sRech, 1, idw_Condition.RowCount () )

	If	lLig > 0 Then
		// param présent mais n'autorisant pas.
		stMessage.sTitre		= "Contrôle détail garantie"
		stMessage.Bouton		= ok!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "WDET595"
		stMessage.sVar [1] = sMess
		stMessage.sVar [2] = sMess2				
		f_Message ( stMessage )
	
		asPos = "LIB_DET"
		Exit

	Else

		sRech	=		"ID_REV = "			+ String ( lIdRev ) 		+ " AND " 	+ &
						"ID_GTI = "			+ String ( lIdGti )		+ " AND " 	+ &
						"ID_TYP_CODE = '"  + sIdTypCode 	+ "' AND " 	+ &
						"ID_CODE = "  + sIdCode 

		lLig = idw_Condition.Find ( sRech, 1, idw_Condition.RowCount () )
	
		If	lLig <= 0 Then
			//absence de param
			stMessage.sTitre		= "Contrôle détail garantie"
			stMessage.Bouton		= Ok!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "WDET596"
			stMessage.sVar [1] = sMess
			stMessage.sVar [2] = sMess2				
			f_Message ( stMessage )
		
			asPos = "LIB_DET"
			Exit
			
		End If				
	End If
Next

end subroutine

private function long uf_zn_trt_divdet_collerinfo (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_CollerInfo (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 25/01/2012
//* Libellé			: Coller le presse papier dans certaines zones
//* Commentaires	: 
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Integer iAction
Long    lDeb, lFin, lRow
String  sMess, sCodeArticle, sLibArticle, sDteFinGti   
n_cst_string lnvPFCString

iAction = 0 

// ON ne touche à rien une fois la prise en charge cochée.
If This.uf_GestOng_Divers_Trouver ("PEC" ) = "O" Then
	idw_wDivDet.iiErreur = 3
	iAction = 1
End If

// #1 On gère Casto à l'ancienne méthode.
If asData = "O" and iAction = 0 Then
	// Confo
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 207 )
	If lDeb > 0 Then
		
		sCodeArticle = lnvPFCString.of_getkeyvalue (ClipBoard (), "CODE_ARTICLE", ";")
		sLibArticle  = lnvPFCString.of_getkeyvalue (ClipBoard (), "LIB_ARTICLE", ";")
		sDteFinGti   = lnvPFCString.of_getkeyvalue (ClipBoard (), "DTE_FIN_GTI_ARTICLE", ";")		
		
		lRow = idw_wDivDet.Find ( "NOM_ZONE = 'code_article'", 1, idw_wDivDet.Rowcount () ) 
		If lRow > 0 Then
			This.uf_GestOng_Divers_MajZone ( "CODE_ARTICLE", lRow, sCodeArticle )
		End If

		lRow = idw_wDivDet.Find ( "NOM_ZONE = 'lib_article'", 1, idw_wDivDet.Rowcount () ) 
		If lRow > 0 Then
			This.uf_GestOng_Divers_MajZone ( "LIB_ARTICLE", lRow, sLibArticle )
		End If

		If IsDate ( sDteFinGti ) Then
			lRow = idw_wDivDet.Find ( "NOM_ZONE = 'dte_fin_gti_article'", 1, idw_wDivDet.Rowcount () ) 
			If lRow > 0 Then
				This.uf_GestOng_Divers_MajZone ( "DTE_FIN_GTI_ARTICLE", lRow, Date ( sDteFinGti ) )
			End If
		End If

		If Len ( scodeArticle ) + Len ( sLibArticle ) + Len ( sDteFinGti ) > 0 Then
			idw_wDivDet.SetItem ( alRow ,"ALT_PROT", "O" )
			idw_wDivDet.AcceptText ()
		End If

		ClipBoard ( "" )
		
	End If
	Return iAction
	
End If

Return iAction


end function

public function boolean uf_rf_601 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_601 (PRIVATE)
//* Auteur			: JFF
//* Date				: 25/01/2012
//* Libellé			: [CONFO][CUISINE]
//* Commentaires	: Adhésion résiliée
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//       JFF   24/01/2012  [CONFO][CUISINE]
//       JFF   28/11/2012  [PC543_MANTIS5894]
//*-----------------------------------------------------------------

Date dDteResil, dDteSurv, dDteFinGti
Long lIdEvt, lDeb, lFin
Boolean bRet, bVal, bConfo

bRet = True

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 207 )
bConfo = lDeb > 0

lIdEvt = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )

/*------------------------------------------------------------------*/
/* On déclenche ce motif de refus si la date de fin de garantie     */
/* est connue ( donc adhésion SPB ) et inférieure à la date du      */
/* sinistre.                                                        */
/* Il faut également de la date de résiliation soit renseignée (    */
/* sinon voir refus 603 )                                           */
/*------------------------------------------------------------------*/

dDteFinGti 	= Date ( This.uf_GestOng_Divers_Trouver ( "DTE_FIN_GTI_ARTICLE" ) )
dDteResil 	= idw_wSin.GetItemDate ( 1, "DTE_RESIL"   	)
dDteSurv 	= idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE"  )

If	Not isNull ( dDteFinGti )		And	&
	Not isNull ( dDteSurv   )		And	&
	Not IsNull ( dDteResil  ) 		Then

	If dDteFinGti < dDteSurv Then

/*------------------------------------------------------------------*/
/* L'adhésion est résiliée et la fin de garantie a été atteinte     */
/* avant le sinistre                                                */
/*------------------------------------------------------------------*/
		// PC543_MANTIS5894
		bVal = False
		iF bConfo Then
			Choose Case lIdEvt
				Case 1317, 1083, 934
					// On ne controle pas
					bVal = True
			End Choose
		End If		
		// :PC543_MANTIS5894

		If Not bVal Then
			bRet = Uf_RF_EcrireRefus ( 601 )
		End If
	End If
End If

Return ( bRet )

end function

public function boolean uf_rf_603 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_603 (PRIVATE)
//* Auteur			: JFF
//* Date				: 25/01/2012 
//* Libellé			: [CONFO][CUISINE]
//* Commentaires	: pas de primes perçues
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//	FPI	09/11/2011	[Vdoc5870] Déclenchement autre refus sur clé dans DP29
//*-----------------------------------------------------------------

Date dDteResil, dDteSurv, dDteFinGti
Long lDeb, lFin, lIdEvt
n_cst_string nvString
String sRefus
Boolean bRet, bConfo, bVal

bRet = True

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 207 )
bConfo = lDeb > 0

lIdEvt = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )

sRefus = "603"
/*------------------------------------------------------------------*/
/* On déclenche ce motif de refus si la date de fin de garantie     */
/* est connue ( donc adhésion SPB ) et inférieure à la date du      */
/* sinistre.                                                        */
/*------------------------------------------------------------------*/
/* Il ne doit pas y avoir de date de résiliation sans quoi          */
/* s'est le motif 601 qui sera déclenché                            */
/*------------------------------------------------------------------*/

dDteFinGti 	= Date ( This.uf_GestOng_Divers_Trouver ( "DTE_FIN_GTI_ARTICLE" ) )
dDteResil 	= idw_wSin.GetItemDate ( 1, "DTE_RESIL"   	)
dDteSurv 	= idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE"  )

If	Not isNull ( dDteFinGti )		And	&
	Not isNull ( dDteSurv   )		And	&
	IsNull     ( dDteResil  ) 		Then

	If dDteFinGti < dDteSurv Then

/*------------------------------------------------------------------*/
/* L'adhésion est résiliée et la fin de garantie a été atteinte     */
/* avant le sinistre                                                */
/*------------------------------------------------------------------*/
		// 	[Vdoc5870]
//		F_RechDetPro(lDeb, lFin, idw_detpro, idw_wSin.GetItemNumber( 1,"ID_PROD"), "-DP", 29)
//		If lDeb > 0 Then
//			sRefus=nvString.of_getkeyvalue( idw_detpro.GetItemString(lDeb ,"VAL_CAR") , "REFUS", ";")
//			If sRefus="" Then sRefus="603"
//		End if
		
//		bRet = Uf_RF_EcrireRefus ( Long(sRefus) )

		bVal = False
		If bConfo Then 
			Choose Case lIdEvt
				Case 1317, 1083, 934
					// On ne controle pas
					bVal = True
			End Choose
		End If 
		
		If Not bVal Then
			bRet = Uf_RF_EcrireRefus ( 603 )
		End If
		// Fin VDoc5870
	End If
End If

Return ( bRet )
end function

private function string uf_plaf_nbev_gti_adhesion ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbEv_Gti_Adhesion (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 25/01/2012 
//* Libellé			: [CONFO][CUISINE][PC680]
//* Commentaires	: Application d'un plafond par adhésion
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	FPI		01/10/2009	[DCMP090539] Correction calcul nb evt
//* #2   JFF      05/03/2010  [20100305140001227] Correctif important
//*      JFF      27/07/2011  [PLAF_REF]			
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale, lCptMax
Int iNbAutSin, iSinEnCours
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafSav
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdEvt
Decimal{2} 	dcPlafTmp
String		sIdNivPlaf, sIdRefPlaf
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sIdPara, sCptVer
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh

sPos = ""
/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '730'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
	iNbAutSin= 0

	itrTrans.PS_S_W_DETAIL_NBEVT_GTI_ADHESION ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, iNbAutSin)

	If	Not F_Procedure ( stMessage, itrTrans, "PS_S_W_DETAIL_NBEVT_GTI_ADHESION" )	Then 
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée, on affiche le message.             */
/*------------------------------------------------------------------*/
		f_Message ( stMessage )
		sPos = "MT_PREJ"
	Else
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		
		// #1 - [DCMP090539]
		//iSinEnCours		= 1
		lIdDetail = idw_wdetailff.GetItemNumber(1,"ID_DETAIL")

		// #2 [20100305140001227] Correctif important
/*
		iSinEnCours		= Integer(idw_lstdetail.describe( &
			"Evaluate('sum(if(id_detail <>" +	string(lIdDetail) + ",1,0) for all)',0)")) 	
*/			
		iSinEnCours		= Integer(idw_lstdetail.describe( &
			"Evaluate('sum(if(id_detail <>" +	string(lIdDetail) + ",1,0) for all)',0)")) 	
		// :#2 [20100305140001227] Correctif important			
		
		iSinEnCours++ 											
		// Fin #1 - [DCMP090539]
		
		If	iSinEnCours + iNbAutSin > dcPlafond	Then
			idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "730", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "730", "NORMAL" )
			
		End If

	End If
End If

	
Return ( sPos )

end function

private function long uf_zn_trt_divdet_code_article (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_code_article (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 07/10/2005
//* Libellé			: Contrôle de la zone MarqApp
//* Commentaires	: 
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//        JFF   24/01/2012   [CONFO][CUISINE]
//*-----------------------------------------------------------------

Long lDeb, lFin
Integer iAction
String sAltAucun
iAction = 0
Boolean bCasto  // cas Castorama

//  [CONFO][CUISINE] 

// ON ne touche à rien une fois la prise en charge cochée.
If This.uf_GestOng_Divers_Trouver ("PEC" ) = "O" Then
	idw_wDivDet.iiErreur = 2
	iAction = 1
End If

//Migration PB8-WYNIWYG-03/2006 OR
//idw_wDivDet.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_trt_divdet_lib_article (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_lib_article (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 07/10/2005
//* Libellé			: Contrôle de la zone MarqApp
//* Commentaires	: 
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//        JFF   24/01/2012   [CONFO][CUISINE]
//*-----------------------------------------------------------------

Long lDeb, lFin
Integer iAction
String sAltAucun
iAction = 0
Boolean bCasto  // cas Castorama

//  [CONFO][CUISINE] 

// ON ne touche à rien une fois la prise en charge cochée.
If This.uf_GestOng_Divers_Trouver ("PEC" ) = "O" Then
	idw_wDivDet.iiErreur = 2
	iAction = 1
End If

//Migration PB8-WYNIWYG-03/2006 OR
//idw_wDivDet.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_trt_divdet_dte_fin_gti_article (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_dte_fin_gti_article (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 07/10/2005
//* Libellé			: Contrôle de la zone MarqApp
//* Commentaires	: 
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//        JFF   24/01/2012   [CONFO][CUISINE]
//*-----------------------------------------------------------------

Long lDeb, lFin
Integer iAction
String sAltAucun
iAction = 0
Boolean bCasto  // cas Castorama

//  [CONFO][CUISINE] 

// ON ne touche à rien une fois la prise en charge cochée.
If This.uf_GestOng_Divers_Trouver ("PEC" ) = "O" Then
	idw_wDivDet.iiErreur = 1
	iAction = 1
End If

//Migration PB8-WYNIWYG-03/2006 OR
//idw_wDivDet.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_trt_divdet_code_rgpr_element (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_code_rgpr_element (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 07/10/2005
//* Libellé			: Contrôle de la zone MarqApp
//* Commentaires	: 
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//        JFF   24/01/2012   [CONFO][CUISINE][PC680]
//*-----------------------------------------------------------------

Long lDeb, lFin, dcIdSin, dcIdProd, dcIdEts, lIdRgpt
Integer iAction
String sAltAucun, sChaine, sIdAdh, sChaine1
iAction = 0
Boolean bCasto  // cas Castorama

//  [CONFO][CUISINE] 

// ON ne touche à rien une fois la prise en charge cochée.
If This.uf_GestOng_Divers_Trouver ("PEC" ) = "O" Then
	idw_wDivDet.iiErreur = 1
	iAction = 1
End If

If iAction = 0 And Long ( asData ) <= 0  Then
	idw_wDivDet.iiErreur = -1
	iAction = 1
End If

If iAction = 0 And Len ( Trim ( asData )) > 0 And Not IsNull ( asData ) Then
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	lIdRgpt     = Long ( asData )
	
	sChaine = Space ( 255 )
	sChaine1 = Space ( 255 )
	
	SQLCA.PS_VERIF_CODE_RGPT_V01 ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, lIdRgpt, sChaine, sChaine1 )
	
	sChaine = Trim ( sChaine )
	sChaine1 = Trim ( sChaine1 )
	
	If IsNull (sChaine) then sChaine = ""
	If IsNull (sChaine1) then sChaine1 = ""
	
	sChaine += sChaine1
	
   If sChaine <> "" And Not IsNull ( sChaine ) Then
		stMessage.bErreurG	= FALSE
		stMessage.sTitre		= "Dossier ayant déjà ce code de regroupement"
		stMessage.Icon			= Information!
		stMessage.bouton		= Ok!
		stMessage.sVar[1]    = sChaine
		stMessage.sCode = "WDET597" 
		f_Message ( stMessage )
	End If
	
End If

//Migration PB8-WYNIWYG-03/2006 OR
//idw_wDivDet.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function string uf_plaf_nbcodergpt_distinct_gti_adhesion ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_plaf_nbcodergpt_distinct_gti_adhesion (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 25/01/2012 
//* Libellé			: [CONFO][CUISINE][PC680]
//* Commentaires	: Application d'un plafond par adhésion
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	FPI		01/10/2009	[DCMP090539] Correction calcul nb evt
//* #2   JFF      05/03/2010  [20100305140001227] Correctif important
//*      JFF      27/07/2011  [PLAF_REF]			
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale, lCptMax, lIdRpgt 
Int iNbAutSin, iSinEnCours
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafSav
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdEvt, lRowDivDet 
Long lIdDetailEnCours, lIdGtiEnCours, lCount, lCptDet
Decimal{2} 	dcPlafTmp
String		sIdNivPlaf, sIdRefPlaf, sChaine
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sIdPara, sCptVer
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh
Boolean	bDeclenchementPlafond

sPos = ""
bDeclenchementPlafond = FALSE

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '731'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
	iNbAutSin= 0

	itrTrans.PS_S_W_DETAIL_CODERGPT_DISTINCT_GTI_ADHESION ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, iNbAutSin, sChaine )

	If	Not F_Procedure ( stMessage, itrTrans, "PS_S_W_DETAIL_NBEVT_GTI_ADHESION" )	Then 
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée, on affiche le message.             */
/*------------------------------------------------------------------*/
		f_Message ( stMessage )
		sPos = "MT_PREJ"
	Else

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		bDeclenchementPlafond = iNbAutSin > dcPlafond 

		If Not bDeclenchementPlafond Then
			bDeclenchementPlafond = TRUE
			
			// LEs détails du sinistre en cours pour la même gti
			lIdDetailEnCours = idw_wdetailff.GetItemNumber (1,"ID_DETAIL")
			lIdGtiEnCours    = idw_wdetailff.GetItemNumber ( 1, "ID_GTI" )

			idw_LstDetail.SetFilter ( "ID_GTI = " + String ( lIdGtiEnCours ) + " AND " + &
											  "ID_DETAIL <> " + String ( lIdDetailEnCours ) + " AND " + &
											  "COD_ETAT NOT IN ( 1, 900, 200)" &
											  )
			idw_LstDetail.Filter ()											  
			lCount = idw_LstDetail.Rowcount ()

			For lCptDet = 1 To lCount 
				lIdDetail = idw_LstDetail.GetItemNumber ( lCptDet, "ID_DETAIL" )
				
				lRowDivDet = idw_wDivDetGti.Find ( &
				"ID_GTI = " + String ( lIdGtiEnCours ) + " AND " + &
				"ID_DETAIL = " + String ( lIdDetail ) + " AND " + &
				"UPPER ( NOM_ZONE ) = 'CODE_RGPR_ELEMENT'" &
				, 1, idw_wDivDetGti.RowCount () )
				
				If lRowDivDet > 0 Then
					lIdRpgt = idw_wDivDetGti.GetItemNumber ( lRowDivDet, "VAL_NBRE" )
					
					If Pos ( SChaine, "#" + String ( lIdRpgt ) + "#", 1 ) <= 0 Then
						sChaine = sChaine + "#" + String ( lIdRpgt ) + "#"
						iNbAutSin++
					End If
				End If
			Next

			idw_LstDetail.SetFilter ( "" )
			idw_LstDetail.Filter ()											  

		 // le détail en cours
			lRowDivDet = idw_wDivDet.Find ( &
			"ID_GTI = " + String ( lIdGtiEnCours ) + " AND " + &
			"ID_DETAIL = " + String ( lIdDetailEnCours )	+ " AND " + &
			"UPPER ( NOM_ZONE ) = 'CODE_RGPR_ELEMENT'" &
			, 1, idw_wDivDet.RowCount () )

			If lRowDivDet > 0 Then
				lIdRpgt = idw_wDivDet.GetItemNumber ( lRowDivDet, "VAL_NBRE" )
				
				If Pos ( SChaine, "#" + String ( lIdRpgt ) + "#", 1 ) <= 0 Then
					sChaine = sChaine + "#" + String ( lIdRpgt ) + "#"
					iNbAutSin++
				End If
			End If
	
		End If

		If iNbAutSin > dcPlafond Then
			idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", 	"O" )

			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "731", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "731", "NORMAL" )
		End IF
	
	End If
End If

	
Return ( sPos )

end function

private function long uf_zn_trt_divdet_taillearticle (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_TailleArticle (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 25/01/2012
//* Libellé			: [CONFO][MEUBLE][PC542]
//* Commentaires	: 
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Integer iAction
Long    lDeb, lFin, lRow
String  sMess, sCodeArticle, sLibArticle, sDteFinGti   
n_cst_string lnvPFCString

iAction = 0 

// ON ne touche à rien une fois la prise en charge cochée.
If This.uf_GestOng_Divers_Trouver ("PEC" ) = "O" Then
	idw_wDivDet.iiErreur = 5
	iAction = 1
End If

Return iAction


end function

public function string uf_gestion_dartynomade (decimal adcmtvalachat, string aschoixaction);//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_sinistre_wdetail::uf_Gestion_DartyNomade (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 18/01/2005 15:05:09
//* Libellé       : Gestion du produit DARTY NOMADE (8691, 8692)
//* Commentaires  : Projet NM-2004-04-121V1, option -DP,31
//*
//* Arguments     : Decimal      adcMtValAchat            Val   // 
//*					  String		   asChoixAction				 Val   // #11 [O2M_DIAG_NOMADE].[JFF].[20091022224855853]
//* Retourne      : String         // Code d'aiguillage
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date        Modification
//* #1   MADM   20/07/2006   DCMP 060528 Gestion particuliére sur la marque CREATIVE 
//* #2   JFF    01/10/2007   [DCMP070689] complèment Darty Swap&DartyMP
//* #3   JFF    14/12/2007   [DCMP070968] complèment Darty Swap&DartyMP
//* #4   JFF    28/01/2008   [DCMP080028] 
//* #5   JFF    23/04/2008   [DCMP080283]
//* #6   PHG    30/06/2009     [O2M_DIAG_NOMADE] Gestion des message de process.
//* #7   JFF    10/08/2009     [O2M_DIAG_NOMADE].[JFF].[20090810163647500]
//* #8   JFF    11/08/2009   [O2M_DIAG_NOMADE].[JFF].[20090810171940623]
//* #9   JFF    11/08/2009   [O2M_DIAG_NOMADE].[JFF].[20090811160805277]
//* #10  JFF    11/08/2009   [O2M_DIAG_NOMADE].[JFF].[20090811170635107]
//* #11  JFF 	 22/10/2009   [O2M_DIAG_NOMADE].[JFF].[20091022224855853]
//*      JFF    08/04/2011   [PC430][V10]
//*      JFF    16/02/2012   [ITSM105388]
//*      JFF    27/02/2012   [ITSM108109]
//*      JFF    21/11/2012   [VDOC8832]
//*      JFF    21/11/2012   [VDOC8806] ajout 'CJP', 'PCJ', 'GCJ'
//       JFF    08/02/2016   [PC151522]
//*-----------------------------------------------------------------

Long     lIdGti, lRow, lDeb, lFin, lStatutGc
Long    lIdEvt, lCptValide // #9 [O2M_DIAG_NOMADE].[JFF].[20090811160805277]
String  sTypApp, asRet, sCodEtat, sMarque, sModlPortSin 
Boolean bDartySwap, bDartyMP, bDartyIpad
n_cst_string lnvPFCString
Boolean bTrouveO2MDiagNAnn, bTrouveO2MPRSNAnnRepare

// [PM103]
If gbModeReprise_223 Then Return ""
sModlPortSin = Upper ( idw_Wsin.GetItemString ( 1, "MODL_PORT" ) )

/*------------------------------------------------------------------*/
/* Sommes-nous en Gestion DARTY NOMADE                              */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 31 )
If lDeb <= 0 Then Return ""

// [PC151522]
If lDeb > 0 Then
	If lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR"), "OPT_31_ASSOUPLIE", ";") = "OUI" Then
		 Return ""
	End If
End If


// #2
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 90 )
bDartySwap = lDeb > 0 

// #2
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 91 )
bDartyMP = lDeb > 0 

// [ITSM105388]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 167 )
bDartyIpad = lDeb > 0 

// [VDOC8832]
bDartyIpad = bDartyIpad Or Pos ( sModlPortSin, "IPAD" ) > 0
// :[VDOC8832]

// #9 [O2M_DIAG_NOMADE].[JFF].[20090811160805277]
lIdEvt = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
lCptValide = idw_wDetailFF.GetItemNumber ( 1, "CPT_VALIDE" )

/*------------------------------------------------------------------*/
/* Si l'evt de Remboursement 965 est placé avant la saisie de la    */
/* valeur d'achat alors, on ne gère aucun cas.                      */
/*------------------------------------------------------------------*/
// #9 [O2M_DIAG_NOMADE].[JFF].[20090811160805277]

If lIdEvt = 965 Then Return ""

// #9 [O2M_DIAG_NOMADE].[JFF].[20090811160805277]
If lIdEvt = 1083 And lCptValide > 0 Then Return ""


lIdGti  = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
stMessage.sCode = "" 
asRet = ""

/*------------------------------------------------------------------*/
/* En fonction de Garantie (BRIS/VOL) et type de matériel sinistré  */
/* on définit un aiguillage.                                        */
/*------------------------------------------------------------------*/
stMessage.sTitre      = "Commandes"
stMessage.Icon         = Information!
stMessage.bErreurG   = FALSE
stMessage.Bouton      = Ok!

lRow = idw_WDivSin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, idw_WDivSin.RowCount () ) 
If lRow <= 0 Then 
   sTypApp = "XXX"
Else
   sTypApp = Upper ( idw_WDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) )
End If

/*------------------------------------------------------------------*/
/* En fonction de Garantie (BRIS/VOL) et type de matériel sinistré  */
/* on définit un aiguillage.                                        */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* #1 Récupération de la marque via la grille de sinistre           */
/*------------------------------------------------------------------*/
sMarque = Upper ( idW_wSin.GetItemString ( 1, "MARQ_PORT3" ) )

// [O2M_DPN_JFF]
// Armement ici d'un boolean répondant à la phrase de l'analyse 
// bTrouveO2MDiagNAnn="Rechercher si une prestation de diagnostic O2M non annulée existe"
// #6 [O2M_DIAG_NOMADE] Rechercher si une prestation de diagnostic O2M non annulée existe"

/* #7   [O2M_DIAG_NOMADE].[JFF].[20090810163647500]
bTrouveO2MDiagNAnn = &
   ( idw_LstCmdeSin.Find ( "CODE_ETAT <> 'ANN'AND ID_REF_FOUR = 'A_DIAGNOSTIQUER' ", &
                           1,&
                           idw_LstCmdeSin.rowCount()+1 ) > 0 )
*/
bTrouveO2MDiagNAnn = &
   ( idw_LstCmdeSin.Find ( "ID_FOUR = 'O2M' AND COD_ETAT <> 'ANN' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER'", &
                           1,&
                           idw_LstCmdeSin.rowCount()+1 ) > 0 )
bTrouveO2MPRSNAnnRepare = &
   ( idw_LstCmdeSin.Find ( "ID_FOUR = 'O2M' AND COD_ETAT <> 'ANN' AND ID_TYP_ART = 'PRS' AND STATUS_GC = 2", &
                           1,&
                           idw_LstCmdeSin.rowCount()+1 ) > 0 )
									
// :#7   [O2M_DIAG_NOMADE].[JFF].[20090810163647500]


Choose Case lIdGti
   
   Case 11  // BRIS

      Choose Case sTypApp 

         Case "PCP"  // PC Portable

               stMessage.sCode      = "COMD140"
               asRet = "11/PCP/PRS_DTY"

               // #2
               Choose Case True
                  Case bDartySwap, bDartyMP
                     //[O2M_DPN_JFF]
                     // Si Not bTrouveO2MDiagNAnn Alors vers Diag O2M
                        // Nouveau message identique au 141 mais modifié
                        /*
                           - Le sinistre est un bris
                           - La valeur d'achat est inférieure ou égale à 300€
   
                           =>Choisissez l'évènement Action O2M
                           =>Passer une demande de diagnostic
                        */
                     // Sinon 141 existant mais modifié avec - Suite au retour de diagnostic d'O2M, alors :

                     // #6 [O2M_DIAG_NOMADE] 
							// #11 [O2M_DIAG_NOMADE].[JFF].[20091022224855853]
                     if Not bTrouveO2MDiagNAnn And asChoixAction <> "C" Then

                        //* #10  [O2M_DIAG_NOMADE].[JFF].[20090811170635107]
                        // stMessage.sCode      = "COMD533"
                        stMessage.sCode      = "COMD544"
                        //* :#10  [O2M_DIAG_NOMADE].[JFF].[20090811170635107]
                        
                        // #8   [O2M_DIAG_NOMADE].[JFF].[20090810171940623]
                        // asRet = ""
                        asRet = "11/PCP/DIAG_O2M"
                        // :#8   [O2M_DIAG_NOMADE].[JFF].[20090810171940623]
                     Else
                        stMessage.sCode      = "COMD534"   // #6 [O2M_DIAG_NOMADE] "COMD141" => "COMD534"
                        asRet = "11/PCP/CMD_DTY"
                     End If
               End Choose

			// [PC430][V10]
/*
			Case 	"TPC" 
				asRet = "11/NPCP/PROPO/<=300/CMD_DTY"
*/
         Case Else   // Autre Qu'un PC
            
            Choose Case TRUE

					Case bDartySwap   // #3 Ce cas doit être au 1er Rang, extr. important !!

                  // #4#5
                  Choose Case sTypApp
                     Case "BCD", "BHD", "BNU", "APC", "APN", "APR", "CAM", "CSJ", "DVP", "GPS", "PDA", "TPC", "CJP", "PCJ", "GCJ" 
                        // [O2M_DPN_JFF]
//                        stMessage.sCode = "COMD143"
//                        asRet = "11/NPCP/PROPO/<=300/CMD_DTY"   
                        // #6 [O2M_DIAG_NOMADE] 
								// #11 [O2M_DIAG_NOMADE].[JFF].[20091022224855853]
								If Not bTrouveO2MDiagNAnn And asChoixAction <> "C" Then

                           //* #10  [O2M_DIAG_NOMADE].[JFF].[20090811170635107]
                           // stMessage.sCode      = "COMD533"
                           stMessage.sCode      = "COMD545"
                           //* :#10  [O2M_DIAG_NOMADE].[JFF].[20090811170635107]

                           // #8   [O2M_DIAG_NOMADE].[JFF].[20090810171940623]
                           // asRet = ""
                           asRet = "11/NPCP/DIAG_O2M"
                           // :#8   [O2M_DIAG_NOMADE].[JFF].[20090810171940623]
                           
                        Else
                           stMessage.sCode      = "COMD535"   // #6 [O2M_DIAG_NOMADE] "COMD143" => "COMD535"
                           asRet = "11/NPCP/PROPO/<=300/CMD_DTY"
                        End If
								
								// [VDOC8832]
								If bDartyIpad Then
									stMessage.sCode   = ""
									asRet = "11/NPCP/REPAR/IPAD/O2M"
								End If
								// :[VDOC8832]
                  
                  // :4                  
                     Case Else
//                        // [O2M_DPN_JFF]
//                        stMessage.sCode = "COMD142"
//                        asRet = "11/NPCP/<=300/CMD_DTY"
                        // #6 [O2M_DIAG_NOMADE] 
								// #11 [O2M_DIAG_NOMADE].[JFF].[20091022224855853]
								if Not bTrouveO2MDiagNAnn And asChoixAction <> "C" Then

                           //* #10  [O2M_DIAG_NOMADE].[JFF].[20090811170635107]
                           // stMessage.sCode      = "COMD533"
                           stMessage.sCode      = "COMD545"
                           //* :#10  [O2M_DIAG_NOMADE].[JFF].[20090811170635107]

                           // #8   [O2M_DIAG_NOMADE].[JFF].[20090810171940623]
                           // asRet = ""
                           asRet = "11/NPCP/DIAG_O2M"
                           // :#8   [O2M_DIAG_NOMADE].[JFF].[20090810171940623]

                        Else
                           stMessage.sCode      = "COMD536"   // #6 [O2M_DIAG_NOMADE] "COMD142" => "COMD536"
                           asRet = "11/NPCP/<=300/CMD_DTY"
                        End If
                        
                  End Choose
               
               /*---------------------------------------------------------------------------*/
               /* #1 Si la marque est CREATIVE, on traite à l'identique du cas < à 300 euros*/
               /*---------------------------------------------------------------------------*/
               Case    sMarque = "CREATIVE"
                  stMessage.sVar[1]    = sMarque

                  // #4
                  Choose Case sTypApp
                     Case "BCD", "BHD", "BNU", "APC", "APN", "APR", "CAM", "CSJ", "DVP", "GPS", "PDA", "TPC", "CJP", "PCJ", "GCJ" 
//                        // [O2M_DPN_JFF]
//                        stMessage.sCode   = "COMD122"
//                        asRet = "11/NPCP/PROPO/<=300/CMD_DTY"                        
                        // #6 [O2M_DIAG_NOMADE] 
								// #11 [O2M_DIAG_NOMADE].[JFF].[20091022224855853]
								if Not bTrouveO2MDiagNAnn And asChoixAction <> "C" Then

                           //* #10  [O2M_DIAG_NOMADE].[JFF].[20090811170635107]
                           // stMessage.sCode      = "COMD533"
                           stMessage.sCode      = "COMD545"
                           //* :#10  [O2M_DIAG_NOMADE].[JFF].[20090811170635107]

                           
                           // #8   [O2M_DIAG_NOMADE].[JFF].[20090810171940623]
                           // asRet = ""
                           asRet = "11/NPCP/DIAG_O2M"
                           // :#8   [O2M_DIAG_NOMADE].[JFF].[20090810171940623]

                        Else
                           stMessage.sCode      = "COMD537"   // #6 [O2M_DIAG_NOMADE] "COMD122" => "COMD537"
                           asRet = "11/NPCP/PROPO/<=300/CMD_DTY"
                        End If

								// [VDOC8832]
								If bDartyIpad Then
									stMessage.sCode   = ""
									asRet = "11/NPCP/REPAR/IPAD/O2M"
								End If
								// :[VDOC8832]
                  
                  // :4                  
                     Case Else
//                        // [O2M_DPN_JFF]
//                        stMessage.sCode   = "COMD121"
//                        asRet = "11/NPCP/<=300/CMD_DTY"
                        // #6 [O2M_DIAG_NOMADE] 
								// #11 [O2M_DIAG_NOMADE].[JFF].[20091022224855853]
								if Not bTrouveO2MDiagNAnn And asChoixAction <> "C" Then

                           //* #10  [O2M_DIAG_NOMADE].[JFF].[20090811170635107]
                           // stMessage.sCode      = "COMD533"
                           stMessage.sCode      = "COMD545"
                           //* :#10  [O2M_DIAG_NOMADE].[JFF].[20090811170635107]
                           
                           // #8   [O2M_DIAG_NOMADE].[JFF].[20090810171940623]
                           // asRet = ""
                           asRet = "11/NPCP/DIAG_O2M"
                           // :#8   [O2M_DIAG_NOMADE].[JFF].[20090810171940623]

                        Else
                           stMessage.sCode      = "COMD538"   // #6 [O2M_DIAG_NOMADE] "COMD121" => "COMD538"
                           asRet = "11/NPCP/<=300/CMD_DTY"
                        End If
                  End CHoose


               // Inférieur à 300 E
               Case adcMtValAchat <= 300

                  // #4
                  Choose Case sTypApp
                     Case "BCD", "BHD", "BNU", "APC", "APN", "APR", "CAM", "CSJ", "DVP", "GPS", "PDA", "TPC", "CJP", "PCJ", "GCJ" 
//                        // [O2M_DPN_JFF]
//                        stMessage.sCode   = "COMD124"
//                        asRet = "11/NPCP/PROPO/<=300/CMD_DTY"                        
                        // #6 [O2M_DIAG_NOMADE] 
								// #11 [O2M_DIAG_NOMADE].[JFF].[20091022224855853]
								if Not bTrouveO2MDiagNAnn And asChoixAction <> "C" Then

                           stMessage.sCode      = "COMD533"
                           // #8   [O2M_DIAG_NOMADE].[JFF].[20090810171940623]
                           // asRet = ""
                           asRet = "11/NPCP/DIAG_O2M"
                           // :#8   [O2M_DIAG_NOMADE].[JFF].[20090810171940623]

                        Else
                           stMessage.sCode      = "COMD539"   // #6 [O2M_DIAG_NOMADE] "COMD124" => "COMD539"
                           asRet = "11/NPCP/PROPO/<=300/CMD_DTY"
                        End If
								
								// [VDOC8832]
								If bDartyIpad Then
									stMessage.sCode   = ""
									asRet = "11/NPCP/REPAR/IPAD/O2M"
								End If
								// :[VDOC8832]
								
								
								
                  // :4                  
                     Case Else
//                        // [O2M_DPN_JFF]
//                        stMessage.sCode   = "COMD120"
//                        asRet = "11/NPCP/<=300/CMD_DTY"
                        // #6 [O2M_DIAG_NOMADE] 
								// #11 [O2M_DIAG_NOMADE].[JFF].[20091022224855853]
								if Not bTrouveO2MDiagNAnn And asChoixAction <> "C" Then

                           stMessage.sCode      = "COMD533"
                           // #8   [O2M_DIAG_NOMADE].[JFF].[20090810171940623]
                           // asRet = ""
                           asRet = "11/NPCP/DIAG_O2M"
                           // :#8   [O2M_DIAG_NOMADE].[JFF].[20090810171940623]

                        Else
                           stMessage.sCode      = "COMD540"   // #6 [O2M_DIAG_NOMADE] "COMD120" => "COMD540"
                           asRet = "11/NPCP/<=300/CMD_DTY"
                        End If
                  End CHoose


               // Supérieur à 300 E
               Case adcMtValAchat > 300

                  /*------------------------------------------------------------------*/
                  /* Deux Cas : Si aucune PRS à DST alors => DST sinon CMD DTY si     */
                  /* DST possède un code -GC à 30                                     */
                  /*------------------------------------------------------------------*/
                  lRow = idw_LstCmdeSin.Find ( "ID_FOUR = 'DST'", 1, idw_LstCmdeSin.RowCount () )
                  If lRow > 0 Then
                     // Process 2ème Tour      
                     stMessage.sCode   = "COMD132"
                     asRet = "11/NPCP/>300/PRS_DST_EC"
                     sCodEtat = idw_LstCmdeSin.GetItemString ( lRow, "COD_ETAT" )
                     lStatutGc= idw_LstCmdeSin.GetItemNumber ( lRow, "STATUS_GC" )

                  /*------------------------------------------------------------------*/
                  /* PRS annuler et statut = "Non réparable par tremblay"              */
                  /*------------------------------------------------------------------*/
							// ITSM108109
                     If lStatutGc = 30 OR sCodEtat = "ANN" Then

                        // #4
                        Choose Case sTypApp
                           Case "BCD", "BHD", "BNU", "APC", "APN", "APR", "CAM", "CSJ", "DVP", "GPS", "PDA", "TPC", "CJP", "PCJ", "GCJ" 
                              stMessage.sCode   = "COMD133"
                              asRet = "11/NPCP/PROPO/>300/DST_ANN/CMD_DTY"
                        // :4                  
                           Case Else
                              stMessage.sCode   = "COMD131"
                              asRet = "11/NPCP/>300/PRS_DST_ANN/CMD_DTY"
                        End choose
                     End If
						End If

						If bTrouveO2MPRSNAnnRepare Or bTrouveO2MDiagNAnn Then
							// Process 2ème Tour      
							stMessage.sCode   = "COMD134"
							asRet = "11/NPCP/>300/PRS_O2M_EC"

							// #4
							Choose Case sTypApp
								Case "BCD", "BHD", "BNU", "APC", "APN", "APR", "CAM", "CSJ", "DVP", "GPS", "PDA", "TPC", "CJP", "PCJ", "GCJ" 
									stMessage.sCode   = "COMD135"
									asRet = "11/NPCP/PROPO/>300/DST_ANN/CMD_DTY"
							// :4                  
								Case Else
									stMessage.sCode   = "COMD136"
									asRet = "11/NPCP/>300/PRS_DST_ANN/CMD_DTY"
							End choose
					
						End If
						
                  If asRet = "" Then
                     // Process normal 1er Tour
                     stMessage.sCode   = "COMD130"
                     asRet = "11/NPCP/>300/PRS_DST"
							
							// [ITSM105388]
							If bDartyIpad Then
								stMessage.sCode   = ""
								asRet = "11/NPCP/REPAR/IPAD/O2M"
							End If
							
                  End If

            End Choose 

      End Choose

   Case 10  // VOL

      Choose Case sTypApp 

         Case "PCP"  // PC Portable
               stMessage.sCode      = "COMD150"
               asRet = "10/PCP/CMD_DTY"

			// [PC430][V10]
			Case 	"TPC" 
					asRet = "10/NPCP/CMD_DTY"

         Case Else   // Autre Qu'un PC

               // #4
               Choose Case sTypApp
                  Case "BCD", "BHD", "BNU", "APC", "APN", "APR", "CAM", "CSJ", "DVP", "GPS", "PDA", "TPC", "CJP", "PCJ", "GCJ" 
                     stMessage.sCode      = "COMD161"
                     asRet = "10/NPCP/PROPO/CMD_DTY"
               // :4                  
                  Case Else
							stMessage.sCode      = "COMD160"            
                     asRet = "10/NPCP/CMD_DTY"
               End choose



      End Choose

   Case Else

End Choose

If stMessage.sCode <> "" And Not ibMtValAchatSaisie Then F_Message ( stMessage )

Return asRet

end function

private function string uf_plaf_refus (string astypplaf, string ascas);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Refus (PRIVATE)
//* Auteur			: Fabry JFF
//* Date				: 29/07/2011 
//* Libellé			: 
//* Commentaires	: [PLAF_REF]
//*
//* Arguments		: String  asTypPlaf   Val
//* Arguments		: String  asCas		 Val
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//  		 JFF		29/05/2012 [VDOC6662]
//*-----------------------------------------------------------------

String sPos, sValCar
Long lDeb, lFin, lCpt, lCodeRef
n_cst_String lnvPFCString
sPos = ""


// [PLAF_REF]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 183 )
If lDeb > 0 Then
	For lCpt = lDeb To lFin
		If Long ( idw_DetPro.GetItemString ( lCpt, "ID_CODE_CAR" ) ) = Long ( asTypPlaf ) Then
			sValCar = idw_DetPro.GetItemString ( lCpt, "VAL_CAR" )
			lCodeRef = Long ( lnvPFCString.of_getkeyvalue( sValCar, "REF_EVT", ";"))

			// [VDOC6662]	
			If asCas = "NORMAL" &
					OR ( lnvPFCString.of_getkeyvalue( sValCar, "REF_PLAF_NUM_>0", ";") = "OUI" And &
						  asCas = "REF_PLAF_NUM_>0" ) Then

				// Evol
				If Long ( lnvPFCString.of_getkeyvalue( sValCar, "REF_GTI", ";")) > 0 And lCodeRef = 0 Then
					Continue
				End if
	
				ibPlafRef = lCodeRef > 0 
			
				If ibPlafNumeraire Then
					islCodeRefPlafNum += "#" + String (lCodeRef) + "#" // [BLCODE]
					ibPlafNumeraire = FALSE
				End If
			
				If Not Uf_RF_EcrireRefus ( lCodeRef ) Then
					sPos = "LIB_DET"
				End If

				// [VDOC6662]	
				If asCas = "REF_PLAF_NUM_>0" Then
					idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
					idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )
				End If
				
			End If 
		End If 
	Next
End If
// [PLAF_REF]


Return sPos 
end function

private function long uf_zn_trt_divdet_enlvbien (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_EnlvBien (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 25/01/2012
//* Libellé			: [CONFO][MEUBLE][PC542]
//* Commentaires	: 
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Integer iAction
Long    lDeb, lFin, lRow, lIdGti
String  sMess, sCodeArticle, sLibArticle, sDteFinGti   
n_cst_string lnvPFCString
Boolean bConfoMeuble, bConfoLiterie, bConfoSiege

iAction = 0 

// ON ne touche à rien une fois la prise en charge cochée.
If This.uf_GestOng_Divers_Trouver ("PEC" ) = "O" Then
	idw_wDivDet.iiErreur = 1
	iAction = 1
End If

If iAction = 0 Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 207 )
	If lDeb > 0 Then 

		lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )		

		// [CONFO][NV_PROCESS]				
		// [CONFO][MEUBLE][PC542]
		// [CONFO][LITERIE][PC543]
		// [CONFO][SIEGE][PC716]
		Choose Case lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")  
			Case "MEUBLE"
				bConfoMeuble = TRUE
			Case "LITERIE"	
				bConfoLiterie = TRUE
			Case "SIEGE"	
				bConfoSiege = TRUE
		End Choose
		
		// [CONFO][NV_PROCESS]	
		If bConfoLiterie Then
			idw_wDivDet.iiErreur = 2
			iAction = 1
		End If
		
		// [CONFO][NV_PROCESS]				
		If bConfoSiege And lIdGti = 27 Then
			idw_wDivDet.iiErreur = 3
			iAction = 1
		End If
		
		
	End If
End If			


Return iAction


end function

private function boolean uf_rf_1590 ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_wdetail::uf_rf_1590
//* Auteur			: F. Pinon
//* Date				: 22/10/2010 11:09:14
//* Libellé			: 
//* Commentaires	: [PC869]
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
// 			FPI	30/12/2010	[ITSM55084] Correction
//			FPI	10/12/2012	[VDoc9173] Spécification par garantie
//*-----------------------------------------------------------------

Date 	  dDteDp, dDteDet
Boolean bRet, bOk
long	  lDeb, lFin, lCpt, lIdGti, lRow, lRow1
String sValCar, sFiltre
n_cst_string lnv_String
Decimal {2} dcMtPrej
String sIdGti[]

lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )

bRet = True
bOk  = False

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 221 )
if lDeb <= 0 Then return bRet
	
// dcMtPrej = idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" )
//[VDoc9173]
sFiltre="ID_GTI = 10 AND ( MT_PLAF_AREG > 0 OR MT_PLAF_REG > 0 )"


sValCar=idw_DetPro.GetItemString(lDeb,"VAL_CAR")
If isnull(sValCar) Then sValCar=""
If sValCar="-1" Then sValCar=""

Choose Case lnv_String.of_getkeyvalue( sValCar, "ID_GTI", ";")
	Case ""
		// On garde le filtre sur la garantie 10
	Case "TOUS"
		// Toutes garanties
		sFiltre="( MT_PLAF_AREG > 0 OR MT_PLAF_REG > 0 )"
	Case Else
		// On décortique
		lnv_string.of_parsetoarray(  lnv_String.of_getkeyvalue( sValCar, "ID_GTI", ";"),  "#",  sIdGti )
		sFiltre="( MT_PLAF_AREG > 0 OR MT_PLAF_REG > 0 ) And ID_GTI IN ("
		For lCpt=1 To UpperBound(sIdGti)
			if sIdGti[lCpt] <> "" Then sFiltre+=sIdGti[lCpt] + ","
		Next
		
		sFiltre=Left(sFiltre,Len(sFiltre) -1) + ")"
End Choose

// :[VDoc9173]

lRow = idw_LstGarSin.Find ( sFiltre, 1, idw_LstGarSin.RowCount() )

//lRow = idw_LstGarSin.Find ( "ID_GTI = 10 AND ( MT_PLAF_AREG > 0 OR MT_PLAF_REG > 0 )", 1, idw_LstGarSin.RowCount() )
// :[Vdoc9173]

lRow1 = idw_LstCmdeSin.Find ( "ID_GTI = 10 AND ID_TYP_ART NOT IN ( 'EDI', 'PRS', 'DEV', 'AEF', 'CAS', 'SMS', 'PCM', 'MAI')", 1, idw_LstCmdeSin.Rowcount() )

// And dcMtPrej > 0
if lIdGti = 53 And ( lRow <= 0 And lRow1 <= 0 ) Then  
	bRet = Uf_RF_EcrireRefus ( 1590 )
End if
	
Return bRet

end function

private function boolean uf_rf_1599 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_1599 (PRIVATE)
//* Auteur			: JFF
//* Date				: 31/10/2012
//* Libellé			: [PC680][MANTIS4919]
//* Commentaires	: Délai entre 1er élément et Dernier élément (pour les produits CONFO)
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Long lTotDelai, lLig, lDuree, lCpt, lCount, lCptDet
String sIdNivDel, sIdRefDel, sFiltreOri
Boolean bRet

String sRech, sUnite

Date	dDte1erElt, dDteEltEnCours, dDteTemp, dDteMax

bRet				= True
lTotDelai 		= idw_Delai.RowCount ()

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 1 to 5

	Choose Case lCpt
		Case 1
			sIdNivDel = "-GA"  // Garantie
			sIdRefDel = "-1"
		Case 2
			sIdNivDel = "+NS"  // Nature de sinistre
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivDel = "+TR"  // Territorialité
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivDel = "+DT"  // Détail de sinistre
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivDel = "+EV"  // Evénement de garantie
			sIdRefDel = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )


	End Choose

	If IsNull ( sIdRefDel ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un délai 625 pour la garantie.            */
	/*------------------------------------------------------------------*/
	// #2 [DCMP071000] Lecture ID_GTI dans idw_wDetailFF ald de idw_wGarSin
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_DEL = '"  + sIdNivDel 																+ "' AND " 	+ &
					"ID_REF_DEL = "	+ sIdRefDel 																+ " AND " 	+ &
					"ID_TYP_DEL = '632'"

	lLig = idw_Delai.Find ( sRech, 1, lTotDelai )


	If	lLig > 0 Then
	/*------------------------------------------------------------------*/
	/* On récupére le délai maximum autorisé entre la survenance du     */
	/* sinistre et la date de déclaration. On vérifie si ce délai est   */
	/* dépassé.                                                         */
	/*------------------------------------------------------------------*/

		sFiltreOri = idw_LstDetail.Describe ( "datawindow.table.filter" )
		if sFiltreOri = "?" then sFiltreOri = ""
		
		idw_LstDetail.SetFilter ( "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + " AND " + &
										  "ID_DETAIL <> " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) ) )
		idw_LstDetail.Filter ()											  
		lCount = idw_LstDetail.Rowcount ()

		SetNull ( dDte1erElt ) 
		For lCptDet = 1 To lCount 
			dDteTemp = Date ( idw_LstDetail.GetItemDateTime ( lCptDet, "DTE_DET" ) )
			If IsNull ( dDte1erElt ) And Not IsNull ( dDteTemp ) Then 
				dDte1erElt = dDteTemp
			End If
			
			If Not IsNull ( dDteTemp ) And Not IsNull ( dDte1erElt ) And dDteTemp < dDte1erElt Then
				dDte1erElt = dDteTemp
			End If
			
		Next
		
		dDteEltEnCours	= Date ( idw_wDetailFF.GetItemDateTime ( 1, "DTE_DET" ) )
		
		sUnite	= idw_Delai.GetItemString ( lLig, "UNT_DEL" )
		lDuree	= idw_Delai.GetItemNumber ( lLig, "DUR_MAX" )

		dDteMax	= F_Plus_Date ( dDte1erElt, lDuree, sUnite )


		If	dDteEltEnCours > dDteMax	Then
			bRet = Uf_RF_EcrireRefus ( 1599 )
		End If

	End If
Next

idw_LstDetail.SetFilter ( sFiltreOri )
idw_LstDetail.Filter ()											  
idw_LstDetail.Sort ()											  

Return ( bRet )
end function

private function boolean uf_rf_1604 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_1604 (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 28/11/2012
//* Libellé			: PC543_MANTIS5297
//* Commentaires	: DATE PRISE POSS ANTERIEURE DTE ADH
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//* [DCMP060533] PHG	06/09/2006 Deconnexion refus 632 par option -DP 68
//*-----------------------------------------------------------------

Date dDteAdh, dDteDet
Boolean bRet 

/*------------------------------------------------------------------*/
/* On déclenche ce motif dans le cas de la garantie Utilisations    */
/* Frauduleuses. Si la date de détail est inférieure à la date de   */
/* survenance, on arme le motif 632.                                */
/*------------------------------------------------------------------*/

bRet = True

dDteAdh = idw_wSin.GetItemDate ( 1, "DTE_ADH" )
dDteDet	= Date(idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" ))

If IsNull ( dDteAdh ) Then Return bRet
If IsNull ( dDteDet) Then Return bRet

If	dDteDet < dDteAdh Then
	bRet = Uf_RF_EcrireRefus ( 1604 )
End If

Return ( bRet )
end function

private function boolean uf_rf_1605 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_1605 (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 28/11/2012
//* Libellé			: PC543_MANTIS5297
//* Commentaires	: DATE PRISE POSS ANTERIEURE DTE ADH
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//* [DCMP060533] PHG	06/09/2006 Deconnexion refus 632 par option -DP 68
//*-----------------------------------------------------------------

Date dDteSurv, dDteDet
Boolean bRet 

/*------------------------------------------------------------------*/
/* On déclenche ce motif dans le cas de la garantie Utilisations    */
/* Frauduleuses. Si la date de détail est inférieure à la date de   */
/* survenance, on arme le motif 632.                                */
/*------------------------------------------------------------------*/

bRet = True

dDteSurv = idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )
dDteDet	= Date(idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" ))

If IsNull ( dDteSurv ) Then Return bRet
If IsNull ( dDteDet) Then Return bRet

If	dDteDet > dDteSurv Then
	bRet = Uf_RF_EcrireRefus ( 1605 )
End If

Return ( bRet )
end function

private function boolean uf_rf_1678 ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_wdetail::uf_rf_1678
//* Auteur			: F. Pinon
//* Date				: 17/06/2013
//* Libellé			: 
//* Commentaires	: [VDOC10633]
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

Decimal dcMtPivot, dcValAchat
Boolean bRet, bOk
long	  lDeb, lFin
String sValCar
n_cst_string lnv_String


bRet = True
bOk      = False

lDeb= iuotagrefus.dw_trt.Find("ID_MOTIF=1678",1, iuotagrefus.dw_trt.RowCount())
If lDeb <=0 Then return TRUE

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 242 )
If lDeb <= 0 Then
	stmessage.stitre="Contrôle sur le détail"
	stmessage.berreurg=FALSE
	stMessage.svar[1]="1678"
	stMessage.svar[2]="242"
	stmessage.sCode="WDET629"
	f_message(stmessage)
	Return FALSE
End if


sValCar=idw_DetPro.GetItemString ( lDeb, "VAL_CAR") 
sValCar=lnv_String.of_getkeyvalue( sValCar, "MT_MAX_VAL_ACHAT", ";")

dcMtPivot=Dec(sValCar)
dcValAchat=idw_wdetailff.GetItemDecimal(1,"MT_VAL_ACHAT")

if dcValAchat > dcMtPivot Then
	bRet = Uf_RF_EcrireRefus ( 1678 )
End if
	

Return bRet
end function

public function boolean uf_rf_1694 ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_wdetail::uf_rf_1694
//* Auteur			: F. Pinon
//* Date				: 23/07/2013
//* Libellé			: 
//* Commentaires	: [PC940]
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

Long 		lTotDelai, lLig, lDuree, lNbJour, lNbHeu, lHeuDet, lHeuMax, lCpt
Boolean 	bRet
String 	sRech, sUnite, sHeuDet, sHeuSurv, sIdNivDel, sIdRefDel
Date		dDteDecl, dDteDet, dDteMax
Time		hHeuMax
DateTime dtDteMax, dtDecl

bRet				= True
lTotDelai 		= idw_Delai.RowCount ()


For lCpt = 1 to 5

	Choose Case lCpt
		Case 1
			sIdNivDel = "-GA"  // Garantie
			sIdRefDel = "-1"
		Case 2
			sIdNivDel = "+NS"  // Nature de sinistre
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivDel = "+TR"  // Territorialité
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivDel = "+DT"  // Détail de sinistre
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivDel = "+EV"  // Evénement de garantie
			sIdRefDel = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )


	End Choose

	If IsNull ( sIdRefDel ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un délai de déclaration pour la garantie. */
	/*------------------------------------------------------------------*/
	// #1 [DCMP071000] Lecture ID_GTI dans idw_wDetailFF ald de idw_wGarSin
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_DEL = '"  + sIdNivDel 																+ "' AND " 	+ &
					"ID_REF_DEL = "	+ sIdRefDel 																+ " AND " 	+ &
					"ID_TYP_DEL = '634'"

	lLig = idw_Delai.Find ( sRech, 1, lTotDelai )


	If	lLig > 0 Then

	/*------------------------------------------------------------------*/
	/* Le cas du délai en heure est géré à part car on doit travailler  */
	/* sur des datetime et non sur des dates.                           */
	/* De plus, on ne peut pas utiliser uniquement f_plus_date pour le  */
	/* calcul de la date de référence                                   */
	/*------------------------------------------------------------------*/

		sUnite	= idw_Delai.GetItemString ( lLig, "UNT_DEL" )
		lDuree	= idw_Delai.GetItemNumber ( lLig, "DUR_MAX" )
		dDteDet 	= Date ( idw_wDetailFF.GetItemDateTime ( 1, "DTE_DET" ) )

		dDteDecl	= idw_wSin.GetItemDate ( 1, "DTE_DECL" ) 

		dDteMax	= F_Plus_Date ( dDteDet, lDuree, sUnite )

		If	dDteDecl < dDteMax	Then
		/*------------------------------------------------------------------*/
		/* La durée maximum est dépassée, on déclenche le refus 1694.        */
		/*------------------------------------------------------------------*/
			bRet = Uf_RF_EcrireRefus ( 1694 )
		End If
		
	End If
Next

Return ( bRet )

end function

protected function string uf_plaf_adhesion_annee_civile_val_achat ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adhesion_Annee_Civile_val_achat (PRIVATE)
//* Auteur			: Catherine Abdmeziem / JFF
//* Date				: 31/07/2013
//* Libellé			: [PC845]PC845_NOUVPLAF
//* Commentaires	: Application d'un plafond par Année civile
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012 [VDOC6662]
//       JFF   16/11/2015 [DT159-1]
//*-----------------------------------------------------------------


Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale, lDeb, lFin
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafSav, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdEvt
Decimal{2} 	dcMtAutreSinistre, dcPlafTmp
String		sMtAutreSinistre, sIdNivPlaf, sIdRefPlaf
n_cst_string lnvPFCString

DateTime dtDteSurv

String sRech, sPos, sIdAdh, sIdPara, sCptVer

sPos = ""
/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '739'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
	lTotDetail = idw_wDetailFF.iudwDetailSource.RowCount ()
/*------------------------------------------------------------------*/
/* On s'occupe du détail courant, en insertion ou en modification.  */
/* Ce détail ne sera pas traité dans la boucle.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modification DBI le 12/08/1998                                   */
/*                                                                  */
/* La zone à prendre en compte pour le calcul du montant plafonné   */
/* n'est pas MT_NPLAF      mais MT_PLAF      sinon on ne            */
/* tient pas compte des plafonds appliqués successivement           */
/*------------------------------------------------------------------*/

//	dcMtPlaf		= idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF"   )
// [PC845] C'est la variante de ce plafond, on garde les requête existante du 673 et 674, mais on ne compare
// pas à une valeur fixe paramètrée sur le plafond, mais à la valeur d'achat du détail
	dcMtPlaf		= idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT"   )

	lIdDetail	= idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" )

	For	lCpt = 1 To lTotDetail
/*------------------------------------------------------------------*/
/* On ne traite pas le détail courant.                              */
/*------------------------------------------------------------------*/
			If		idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_DETAIL" ) = lIdDetail	Then
					Continue
			Else
/*------------------------------------------------------------------*/
/* Le détail est 'REGLE' ou 'A REGLE', on récupére le montant       */
/* MT_PLAF.                                                         */
/*------------------------------------------------------------------*/
					If	( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 500 Or &
						  idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 600	) And &
						( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) = idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_EVT" ) ) Then

						dcSommeDetail += idw_wDetailFF.iudwDetailSource.GetItemDecimal ( lCpt, "MT_PLAF" )
					End If
			End If
	Next
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
	dcIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	dcMtAutreSinistre = 0
	sMtAutreSinistre = "             "

	itrTrans.PS_S05_W_DETAIL_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, dcIdEvt, dtDteSurv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S05_W_DETAIL_MT_PLAF" )	Then
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée.                                    */
/*------------------------------------------------------------------*/
		sPos		= "ALT_BLOC"
		F_Message ( stMessage )
	Else
/*------------------------------------------------------------------*/
/* On détermine si on dépasse le plafond.                           */
/*------------------------------------------------------------------*/

		dcMtAutreSinistre = Dec ( sMtAutreSinistre )
//		dcPlafond			= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
// [PC845] C'est la variante de ce plafond, on garde les requête existante du 673 et 674, mais on ne compare
// pas à une valeur fixe paramètrée sur le plafond, mais à la valeur d'achat du détail
		dcPlafond			= idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT"   )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcSommeDetail + dcMtAutreSinistre + dcMtPlaf > dcPlafond	Then

			If dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) > 0 Then
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) )
				
				// [PLAF_REF] // [VDOC6662]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "739", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
				// [PLAF_REF]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "739", "NORMAL" )
			End If
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )

/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "739", sIdPara, sCptVer )

			
		End If
	End If
End If
	
Return ( sPos )
end function

private function string uf_plaf_adherent_annee_civile_val_achat ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adherent_Annee_Civile_val_achat (PRIVATE)
//* Auteur			: Catherine Abdmeziem / JFF
//* Date				: 31/07/2013
//* Libellé			: [PC845]PC845_NOUVPLAF
//* Commentaires	: Application d'un plafond par adhérent/Année civile
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012 [VDOC6662]
//        JFF    16/11/2015 [DT159-1]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale, lDeb, lFin
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafSav, dcPlafTmp, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdsDos, dcIdGti, dcIdEvt
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
n_cst_string lnvPFCString
Decimal{2} 	dcMtAutreSinistre
String		sMtAutreSinistre

sPos = ""
/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par adhérent.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '740'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next
lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
	lTotDetail = idw_wDetailFF.iudwDetailSource.RowCount ()
/*------------------------------------------------------------------*/
/* On s'occupe du détail courant, en insertion ou en modification.  */
/* Ce détail ne sera pas traité dans la boucle.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modification DBI le 12/08/1998                                   */
/*                                                                  */
/* La zone à prendre en compte pour le calcul du montant plafonné   */
/* n'est pas MT_NPLAF      mais MT_PLAF      sinon on ne            */
/* tient pas compte des plafonds appliqués successivement           */
/*------------------------------------------------------------------*/

//	dcMtPlaf		= idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF"   )
// [PC845] C'est la variante de ce plafond, on garde les requête existante du 673 et 674, mais on ne compare
// pas à une valeur fixe paramètrée sur le plafond, mais à la valeur d'achat du détail
	dcMtPlaf		= idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT"   )
	
	lIdDetail	= idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" )

	For	lCpt = 1 To lTotDetail
/*------------------------------------------------------------------*/
/* On ne traite pas le détail courant.                              */
/*------------------------------------------------------------------*/
			If		idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_DETAIL" ) = lIdDetail	Then
					Continue
			Else
/*------------------------------------------------------------------*/
/* Le détail est 'REGLE' ou 'A REGLE', on récupére le montant       */
/* MT_PLAF.                                                         */
/*------------------------------------------------------------------*/
					If	( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 500 Or &
						  idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 600	) And &
						( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) = idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_EVT" ) ) Then

						dcSommeDetail += idw_wDetailFF.iudwDetailSource.GetItemDecimal ( lCpt, "MT_PLAF" )
					End If
			End If
	Next

/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdsDos		= idw_wSin.GetItemNumber ( 1, "ID_SDOS" )
	dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
	dcIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	dcMtAutreSinistre = 0
	sMtAutreSinistre = "             "

	itrTrans.PS_S06_W_DETAIL_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, dcIdGti, dcIdEvt, dtDteSurv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S02_W_DETAIL_MT_PLAF" )	Then
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée.                                    */
/*------------------------------------------------------------------*/
		sPos		= "ALT_BLOC"
		F_Message ( stMessage )
	Else
/*------------------------------------------------------------------*/
/* On détermine si on dépasse le plafond.                           */
/*------------------------------------------------------------------*/

		dcMtAutreSinistre = Dec ( sMtAutreSinistre )
//		dcPlafond			= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
// [PC845] C'est la variante de ce plafond, on garde les requête existante du 673 et 674, mais on ne compare
// pas à une valeur fixe paramètrée sur le plafond, mais à la valeur d'achat du détail
		dcPlafond			= idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT"   )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcSommeDetail + dcMtAutreSinistre + dcMtPlaf > dcPlafond	Then
			If dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) > 0 Then
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) )

				// [PLAF_REF] // [VDOC6662]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "740", "REF_PLAF_NUM_>0" )
				
			Else 
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
				// [PLAF_REF]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "740", "NORMAL" )
			End If
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )

/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "740", sIdPara, sCptVer )

		End If
	End If

End If
	
Return ( sPos )
end function

public function boolean uf_controler_sanction_eco ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_controler_sanction_eco (PUBLIC)
//* Auteur			: FPI
//* Date				: 14/08/2013
//* Libellé			: [DT58]
//* Commentaires	: Contrôle territoire sous sanction économique USA
//*
//* Arguments		: 
//*
//* Retourne		: TRUE si on peut commander/régler sur le dossier ; FALSE sinon
//*
//*-----------------------------------------------------------------
Boolean bRet=TRUE
Long lDeb, lFin, lRow
String sVal

F_rechdetpro(lDeb, lFin, idw_detpro, idw_wsin.GetItemNumber(1,"ID_PROD"), "-DP", 246)
If ldeb <= 0 Then return TRUE

// Récupération de la ligne indiquant que le pays de survenance est sous sanction économique USA
lRow=idw_wdivsin.Find("UPPER(NOM_ZONE)='SANCTION_ECO'",1, idw_wdivsin.RowCount())
If lRow <=0 Then 
		bRet=FALSE
		stMessage.scode="WDET631"
		stMessage.sVar[1]="sanction_eco"
End if

If bRet Then
	If idw_wdivsin.GetItemString(lRow,"VAL_CAR") = "N" Then return TRUE // Pays non concerné
	
	// Récupération du résultat de la demande d'accord Chubb
	lRow=idw_wdivsin.Find("UPPER(NOM_ZONE)='ACCORD_CHUBB'",1, idw_wdivsin.RowCount())
	If lRow <=0 Then 
		bRet=FALSE
		stMessage.scode="WDET631"
		stMessage.sVar[1]="accord_chubb"
	Else
		sVal=String(idw_wdivsin.GetItemNumber(lRow,"VAL_NBRE"))
	End if
End if

If bRet Then 
	// Contrôle du résultat de la demande d'accord Chubb
	bRet=(sVal="2")
	If not bRet Then
		// Resultat <> "Accord"
		Choose Case sVal
			Case "0"
				// Non renseigné
				stMessage.scode="WDET632"
			Case "1"
				// Demande en cours
				stMessage.scode="WDET633"
			Case "3"
				// Refus
				stMessage.scode="WDET634"
		End Choose
	End if
End if

If not bRet Then
	// Affichage du message d'erreur
	stmessage.stitre="Pays sous sanction économique USA"
	stmessage.berreurg=FALSE
	
	f_message(stMessage)
End if

Return bRet
end function

protected function string uf_plaf_evt1397_regle_resil_adh ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Evt1397_regle_resil_adh (PRIVATE)
//* Auteur			: JFF
//* Date				: 31/07/2013
//* Libellé			: [PC845]
//* Commentaires	: Application d'un plafond si evt 1397 réglé.
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012 [VDOC6662]
//       JFF   16/11/2015 [DT159-1]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale, lDeb, lFin
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafSav, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdEvt
Decimal{2} 	dcMtAutreSinistre, dcPlafTmp
String		sMtAutreSinistre, sIdNivPlaf, sIdRefPlaf
n_cst_string lnvPFCString
DateTime dtDteSurv

String sRech, sPos, sIdAdh, sIdPara, sCptVer

sPos = ""
/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '741'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
	lTotDetail = idw_wDetailFF.iudwDetailSource.RowCount ()
/*------------------------------------------------------------------*/
/* On s'occupe du détail courant, en insertion ou en modification.  */
/* Ce détail ne sera pas traité dans la boucle.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modification DBI le 12/08/1998                                   */
/*                                                                  */
/* La zone à prendre en compte pour le calcul du montant plafonné   */
/* n'est pas MT_NPLAF      mais MT_PLAF      sinon on ne            */
/* tient pas compte des plafonds appliqués successivement           */
/*------------------------------------------------------------------*/

//	dcMtPlaf		= idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF"   )
// [PC845] C'est la variante de ce plafond, on garde les requête existante du 673 et 674
// On recherche juste un evt 1397 réglé.
	dcPlafond			= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

	// [DT159-1]
	F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
	If lDeb > 0 Then 	
		dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
		If dcEcoTaxe > 0 Then 
			dcPlafond += dcEcoTaxe 
		End If
	End If
	
	
	if idw_wDetailFF.GetItemNumber ( 1, "MT_PLAF" ) > 0 Then
		dcMtPlaf		= 1 // On veut juste que ce soit positif.
	End if


	lIdDetail	= idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" )

/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
	dcIdEvt		= dcPlafond
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	dcMtAutreSinistre = 0
	sMtAutreSinistre = "             "

	itrTrans.PS_S_W_DETAIL_MT_PLAF_EVT_REGLE ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdEvt, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S_W_DETAIL_MT_PLAF_EVT_REGLE" )	Then
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée.                                    */
/*------------------------------------------------------------------*/
		sPos		= "ALT_BLOC"
		F_Message ( stMessage )
	Else
/*------------------------------------------------------------------*/
/* On détermine si on dépasse le plafond.                           */
/*------------------------------------------------------------------*/

		dcMtAutreSinistre = Dec ( sMtAutreSinistre )
//		dcPlafond			= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
// [PC845] C'est la variante de ce plafond, on garde les requête existante du 673 et 674, mais on ne compare
// pas à une valeur fixe paramètrée sur le plafond, mais à la valeur d'achat du détail

		If	dcSommeDetail + dcMtAutreSinistre > 0 Then

			idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
			// [PLAF_REF]
			ibPlafNumeraire = TRUE // [PLAF_REF]
			sPos = Uf_Plaf_Refus ( "741", "NORMAL" )

			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )

/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "741", sIdPara, sCptVer )
			
		End If
	End If
End If
	
Return ( sPos )
end function

private function string uf_plaf_nbev_gti_adhesion_renou_dte_surv ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_plaf_nbev_gti_adhesion_renou_dte_surv (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 04/10/2013
//* Libellé			: [VDOC11880]
//* Commentaires	: Application d'un plafond par adhésion/Renouvellement (Nbre evt par année)
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	FPI		01/10/2009	[DCMP090539] Correction calcul nb evt
//* #2   JFF      05/03/2010  [20100305140001227] Correctif important
//*      JFF      27/07/2011  [PLAF_REF]			
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale, lCptMax
Int iNbAutSin, iSinEnCours
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafSav
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdEvt
Decimal{2} 	dcPlafTmp
String		sIdNivPlaf, sIdRefPlaf
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sIdPara, sCptVer
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh

sPos = ""
/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '743'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
	dcIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
	sUntPerRnv_Adh		= idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
/*---------------------------------------------------------------------*/
/* On calcule la date du dernier renouvellement.                       */
/*En fonction de l'unité de periode de renouvellement (ANNEE,MOIS,JOUR)*/
/*---------------------------------------------------------------------*/
   Choose Case sUntPerRnv_Adh
	   Case "A"
	     lCptMax = 30
	   Case "M"
	     lCptMax = 360
	   Case "J"
	    lCptMax = 10950
	End Choose

	For	lCpt = 1 To lCptMax
			dDteResult = F_Plus_Date ( dDteAdh, dcDurPerRnv_Adh, sUntPerRnv_Adh )
			If	dDteResult <= idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )	Then
				dDteAdh = dDteResult
			Else
				Exit
			End If
	Next
	dtDteAdhRenouv 	= DateTime ( dDteAdh )
				
	iNbAutSin= 0

	itrTrans.PS_S09_W_DETAIL_NBEVT_DTE_SURV ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, dcIdEvt, dtDteSurv, dtDteAdhRenouv, iNbAutSin)


	If	Not F_Procedure ( stMessage, itrTrans, "PS_S09_W_DETAIL_NBSIN" )	Then 
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée, on affiche le message.             */
/*------------------------------------------------------------------*/
		f_Message ( stMessage )
		sPos = "MT_PREJ"
	Else
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		
		// #1 - [DCMP090539]
		//iSinEnCours		= 1
		lIdDetail = idw_wdetailff.GetItemNumber(1,"ID_DETAIL")

		// #2 [20100305140001227] Correctif important
/*
		iSinEnCours		= Integer(idw_lstdetail.describe( &
			"Evaluate('sum(if(id_detail <>" +	string(lIdDetail) + ",1,0) for all)',0)")) 	
*/			
		iSinEnCours		= Integer(idw_lstdetail.describe( &
			"Evaluate('sum(if(id_evt = " + String ( dcIdEvt ) + " and  id_detail <>" +	string(lIdDetail) + ",1,0) for all)',0)")) 	
		// :#2 [20100305140001227] Correctif important			
		
		iSinEnCours++ 											
		// Fin #1 - [DCMP090539]
		
		If	iSinEnCours + iNbAutSin > dcPlafond	Then
			idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "743", sIdPara, sCptVer )
			
			// [PLAF_REF]// [VDOC6662]
			sPos = Uf_Plaf_Refus ( "743", "NORMAL" )
			
		End If

	End If
End If

	
Return ( sPos )

end function

private function boolean uf_rf_1802 ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_wdetail::uf_rf_1802
//* Auteur			: Fabry JF
//* Date				: 22/09/2016
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

Boolean bRet
Long lRow, lIdEvt, lDeb, lFin, lCpt
n_cst_string lnvPFCString

bRet = True
lIdEvt = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 307 )	
If lDeb > 0 And lIdEvt = 1029 Then
	For lCpt = lDeb To lFin 
		If lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lCpt, "VAL_CAR" ), "ID_EVT", ";") = "1029" Then
			bRet = Uf_RF_EcrireRefus ( 1802 )
		End If 
	Next
End If
	
Return ( bRet )
end function

private subroutine uf_gestion_mtvalpublique ();//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_Sinistre_Wdetail::uf_Gestion_MtValPublique (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 05/10/2004 14:10:05
//* Libellé       : Gestion de la valeur à placer dans la zone Mt_Val_Publique
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    11/12/2006  [DCMP060908]
//* #2    JFF    14/02/2007  [DCMP070056]
//* #3    JFF    10/04/2007  [DCMP070256]
//* #4    JFF    28/01/2008  [DCMP080028]
//* #5    JFF    10/07/2008  [DCMP080401].SAISIE_VAL_PUBLIQUE
//*       JFF    10/02/2011  [PC301].[V15_EVOL_VETUSTE]
//*       JFF    27/05/2011  [PC10].[DP150]
//*       JFF    21/10/2011  [VDOC5459]
//        JFF    28/09/2015  [PM319-1]
//			 JFF    20/04/2018  [VDOC26051]
//			 JFF    31/05/2018  [VDOC26241]
//			 JFF    31/05/2018  [VDOC29630]
//        JFF    30/08/2021  [RS972][OPTIM_MB3&4]
//        JFF    11/05/2022  [RS2980_IFR]
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Regle :                                                          */
/* 																					  */
/* - On place le prix TTC fréquent du mobile renseigné sur la gri   */
/* e de sinistre                                                    */
/* s'il est issu du fichier IFR, et que le type d'appareil est      */
/* TEL.                                                             */
/* 																					  */
/* - On place 0.00 s'il n'est pas issu du fichier IFR, et que le    */
/* pe d'appareil n'est pas TEL.                                     */
/*------------------------------------------------------------------*/

String sTypApp, sVal, sMarque, sModele, sDteProdEqvFc, sChaineBcv, sCodeRet, sCodeRetPrixIfrSav 
Long   lRow, lDeb, lFin, lRowDS, lRowDD, lIdGti, lIdDetail, lIdEvt, lRow1 
Decimal {2} dcMtPrixFrequent, dcMtValPub, dcMtValAchat, dcAnciennete, dcMtPrixFrequentActuel
Int 	iCodEtatDet 
Boolean bAutoriserMajValPub, bVarOrange, bVarBoost, bFin
Boolean bAutoriserSaisie // #5 [DCMP080401].SAISIE_VAL_PUBLIQUE
Boolean bDP150, bVarAdvise5 
n_cst_string lnvPFCString

bAutoriserMajValPub = FALSE
bDP150 = False
bVarOrange = False

lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
lIdDetail = idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" )
lIdEvt = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )

iCodEtatDet = idw_wDetailFF.GetItemNumber ( 1, "COD_ETAT" )
dcMtPrixFrequent = idw_wDetailFF.GetItemNumber ( 1, "MT_VAL_PUBLIQUE" )  // #3
dcMtPrixFrequentActuel = dcMtPrixFrequent // [VDOC26051]
dcMtValAchat = idw_wDetailFF.GetItemNumber ( 1, "MT_VAL_ACHAT" )  

lRow = idw_WDivSin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, idw_WDivSin.RowCount () ) 
If lRow <= 0 Then 
	sTypApp = "XXX"
Else
	sTypApp = Upper ( idw_WDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) )
End If			


Choose Case iCodEtatDet 
	Case 0, 100, 1 // #2
	
		// Si lRow <= 0 alors PEC suite placement projet, sinon, PEC réél
		lRow = idw_wDivDet.Find ( "ID_GTI = " + String ( lIdGti ) + " AND " + &
										 "ID_DETAIL = " + String ( lIdDetail ) + " AND " + &
										 "UPPER ( NOM_ZONE ) = 'ALT_PLAF_PEC' " + " AND " + &
										 "VAL_CAR = 'O'", 1, idw_wDivDet.RowCount() )
										 
		lRow1 = idw_wDivDet.Find ( "ID_GTI = " + String ( lIdGti ) + " AND " + &
										 "ID_DETAIL = " + String ( lIdDetail ) + " AND " + &
										 "UPPER ( NOM_ZONE ) = 'PEC' " + " AND " + &
										 "VAL_CAR = 'O'", 1, idw_wDivDet.RowCount() )							
		
		If lIdEvt = 1083 And lRow <= 0 And lRow1 > 0 And dcMtPrixFrequent = 0 Then
			idw_wDetailFF.SetItem ( 1, "MT_VAL_PUBLIQUE", dcMtValAchat ) 
			Return
		End IF
				
/*------------------------------------------------------------------*/
/* Suite entretien JFF/MGA le 15/02 ci-dessous la règle de maj      */
/* définit pour le montant de la valeur publique de chaque détail.  */
/* Le montant IFR se met à jour si ( Aucune commande/Réparation     */
/* n'a été créé ET qu'aucun réglement n'a été effectué sur le       */
/* dossier ) OU si le détail et en création.                        */
/*------------------------------------------------------------------*/
/*
		bAutoriserMajValPub = 	 	( idw_LstCmdeSin.RowCount () <= 0 And &
											  idw_LstCmdeGti.RowCount () <= 0 And &
											  idw_LstCmdeDet.RowCount () <= 0 And &
											  idw_wSin.GetItemDecimal ( 1, "MT_REG" ) <= 0 )  &
											  Or ibInsert
*/

		// #3 dcMtPrixFrequent <=0 gère les cas du scripting.
		bAutoriserMajValPub = ibInsert Or dcMtPrixFrequent <=0 Or IsNull ( dcMtPrixFrequent  )
									 
		If Not bAutoriserMajValPub Then Return
		// /#2

	Case Else

		Return
		
End Choose 

//* #5 [DCMP080401].SAISIE_VAL_PUBLIQUE
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 102 )
bAutoriserSaisie = lDeb > 0

// [VDOC5459]
If bAutoriserSaisie Then

	Choose Case isReferentiel
		Case "IFR"
		
			// [VDOC29630]
			F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 352)				
			If lDeb > 0 Then
				sVal = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "TYP_APP", ";")
				If Pos ( sVal, "#" + sTypApp + "#" ) <= 0 Then
					bAutoriserSaisie = FALSE						
				End If 
			Else
				bAutoriserSaisie = FALSE
			End If 
			
		Case Else
			// rien à faire.			
	End Choose
	
End If


// [PC10].[DP150]
If Not bAutoriserSaisie And dcMtPrixFrequent = 0 Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 150 )
	If lDeb > 0 Then
		// Armement dcMtValPub 
		sMarque = idw_wSin.GetItemString ( 1, "MARQ_PORT2" )
		sModele = idw_wSin.GetItemString ( 1, "MODL_PORT2" )
		
		// [PM319-1]				
		sChaineBcv =idw_DetPro.GetItemString ( lDeb, "VAL_CAR" )
		sVal = lnvPFCString.of_getkeyvalue ( sChaineBcv, "VARIANTE", ";")
		bVarOrange = sVal = "PRIX_ORANGE"
		bVarBoost  = sVal = "PRIX_BOOST" // [RS972][OPTIM_MB3&4]
		lnvPFCString.of_Setkeyvalue ( sChaineBcv, "TYP_APP", sTypApp, ";")
		
		SQLCA.PS_S01_ARTICLE_DP150_V02 (idw_WSin.GetItemNumber ( 1, "ID_PROD" ), sMarque, sModele, dcMtValPub, sChaineBcv  )

		If dcMtValPub = 0 And Not bVarOrange And Not bVarBoost Then
			bAutoriserSaisie = True
			bDP150 = True
						
			lRowDD  = idw_wDivDet.Find ( "NOM_ZONE = 'saisie_val_publique_manuelle'", 1, idw_wDivDet.RowCount () )				
			If lRowDD  <= 0 Then
				lRowDD  = idw_wDivDet.InsertRow (0)
			
				idw_wDivDet.SetItem ( lRowDD , "ID_SIN", idw_wDetailFF.GetItemNumber ( 1, "ID_SIN" ) )
				idw_wDivDet.SetItem ( lRowDD , "ID_GTI", idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )	
				idw_wDivDet.SetItem ( lRowDD , "ID_DETAIL", idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )		 
				idw_wDivDet.SetItem ( lRowDD , "NOM_ZONE", "saisie_val_publique_manuelle" )
				idw_wDivDet.SetItem ( lRowDD , "LIB_LABEL", "Valeur publique saisie manuellement" )
				idw_wDivDet.SetItem ( lRowDD , "ID_TYP_LISTE", "-XX" )
				idw_wDivDet.SetItem ( lRowDD , "ALT_LISTE_CODECAR", "N")
				idw_wDivDet.SetItem ( lRowDD , "ID_TYP_ZONE", "X" )
				idw_wDivDet.SetItem ( lRowDD , "ALT_OBLIG", "N" )
				idw_wDivDet.SetItem ( lRowDD , "ALT_PROT", "O" )
				idw_wDivDet.SetItem ( lRowDD , "CPT_TRI", 500 )
				idw_wDivDet.SetItem ( lRowDD , "VAL_DTE", stNul.dtm )	// [PI056].20190926
				idw_wDivDet.SetItem ( lRowDD , "VAL_CAR", "O" )
				idw_wDivDet.SetItem ( lRowDD , "VAL_NBRE", stNul.lng )
				idw_wDivDet.SetItem ( lRowDD , "VAL_MT", dcMtValPub )
				idw_wDivDet.SetItem ( lRowDD , "ALT_SUPP", "N" )
				idw_wDivDet.SetItem ( lRowDD , "CREE_LE", DateTime ( Today (), Now () ) )
				idw_wDivDet.SetItem ( lRowDD , "MAJ_LE", DateTime ( Today (), Now () ) )
				idw_wDivDet.SetItem ( lRowDD , "MAJ_PAR", stGlb.sCodOper )

				lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'SAISIE_VAL_PUBLIQUE_MANUELLE'", 1, idw_wDivDet.RowCount () )
				If lRow > 0 Then
					This.uf_GestOng_Divers_MajZone ( "SAISIE_VAL_PUBLIQUE_MANUELLE", lRow, "O" )
				End If 			
			End If
		End If
	End If
End If
// :[PC10].[DP150]

If	isTypeTrt = "S" And bAutoriserSaisie Then
	idw_wDetailFF.Uf_Proteger ( { "MT_VAL_PUBLIQUE" } , "0" ) // #4
End If 
//* :#5 [DCMP080401].SAISIE_VAL_PUBLIQUE

/*------------------------------------------------------------------*/
/* Si la ligne n'est pas trouvé -> 0 Euro									  */
/*------------------------------------------------------------------*/
If isReferentiel = "" Then 
	idw_wDetailFF.SetItem ( 1, "MT_VAL_PUBLIQUE", 0 )
	Return
End If

// [VDOC29630]
If isReferentiel = "IFR" And bAutoriserSaisie Then 
	idw_wDetailFF.SetItem ( 1, "MT_VAL_PUBLIQUE", 0 )
	Return
End If 

/*------------------------------------------------------------------*/
/* L'appareil n'est pas un téléphone, donc on permet l'ouverture.   */
/*------------------------------------------------------------------*/
Choose Case isReferentiel
	Case "IFR"
		
		dcMtPrixFrequent = 0 
		
		// #3 On cherche d'abord sur Div_sin si un VP a été mémorisée
		lRowDS = idw_wDivSin.Find ( "NOM_ZONE = 'mt_val_publique'", 1, idw_wDivSin.RowCount () )				

		// #3 On la lis le cas échéant
		If lRowDS > 0 Then
			dcMtPrixFrequent = idw_wDivSin.GetItemDecimal ( lRowDS, "VAL_MT" )
		End If
		
		// #3	en l'absence, on cherche si amu detail existe avec une VP > 0	
		If dcMtPrixFrequent = 0 Or IsNull ( dcMtPrixFrequent ) Then
			lRowDS = idw_LstDetail.Find ( "MT_VAL_PUBLIQUE > 0", 1, idw_LstDetail.RowCount () )

			// #3 On la lis le cas échéant
			If lRowDS > 0 Then
				dcMtPrixFrequent = idw_LstDetail.GetItemDecimal ( lRowDS, "MT_VAL_PUBLIQUE" )
			End IF
		End If

		// #3	en l'absence, on se rabat sur le prix IFR
		// [PC10].[DP150]
		If ( dcMtPrixFrequent = 0 Or IsNull ( dcMtPrixFrequent ) ) And not bDP150 Then
				
			sMarque = idw_wSin.GetItemString ( 1, "MARQ_PORT2" )
			sModele = idw_wSin.GetItemString ( 1, "MODL_PORT2" )
	
			lRow = idwStkIfr.Find ( "MARQUE = Upper ('" + sMarque + "') AND REFERENCE = Upper ('" + sModele + "')", 1, idwStkIfr.RowCount() )
	
			If lRow <= 0 Then
				idw_wDetailFF.SetItem ( 1, "MT_VAL_PUBLIQUE", 0 )
				Return
			End If
	
			dcMtPrixFrequent = idwStkIfr.GetItemDecimal ( lRow, "FREQUENCE" )
			
		// [RS2980_IFR]
			sCodeRetPrixIfrSav = gsCodeRetPrixIfr 
			
			gsCodeRetPrixIfr = "" // On réinitialise puisqu'on rappelle
				
			sCodeRet = Space ( 20 )
			
			SQLCA.PS_U_MARQUAGE_PRIX_IFR_A_REVOIR ( sMarque, sModele, sCodeRet ) 
			F_Commit ( SQLCA, SQLCA.SqlCode = 0 And SQLCA.SqlDBCode = 0)
			
			If sCodeRet = "URGE" Then
				dcMtPrixFrequent = 0

				gsCodeRetPrixIfr = sCodeRet
				
				If sCodeRetPrixIfrSav = "" Then 
					bFin = False
					Do While Not bFin
						stMessage.sTitre		= "RS2980 : Prix IFR à revoir"
						stMessage.Icon			= Exclamation!
						stMessage.bErreurG	= FALSE
						stMessage.Bouton		= YESNO!
						stMessage.sCode		= "WSIN882"
						stMessage.sVar[1]    = sMarque
						stMessage.sVar[2]    = sModele
						
						If Time (Today()) < 14:00:00 Then
							stMessage.sVar[3] = "aujourd'hui"
							stMessage.sVar[4] = "15"									
						Else
							stMessage.sVar[3] = "demain"
							stMessage.sVar[4] = "10"									
						End If							
						
						If F_Message ( stMessage ) = 1 Then bFin = TRUE
					Loop
				End If 					
			End if 
			// /[RS2980_IFR]			
			

		End If 
		/*------------------------------------------------------------------*/
		/* Dernier contrôle : On n'applique la date que si le dossier a     */
		/* été créé postérieurement à la mep du projet Equiv. Fct. Vu avec  */
		/* C. Chauvin le 28/10/2004                                         */
		/*------------------------------------------------------------------*/
		/* Date de mise en production de l'Equiv Fct.                       */
		/*------------------------------------------------------------------*/
			/* Début nouveau code #1
				Dans tous les cas à présent, si le référentiel est IFR (et mobile existe)
				on place le montant prix public.
				En aval, lors de la commande puis du réglement, on utilisera cette valeur 
				si présence plafond 675.
				Si EQF déconnectée, on peut tout même utiliser le prix IFR pour plafonner sur plafond ASSURER.
				A l'inverse, on pourra avoir l'EQF et le plafond 675 absent.	
			*/
			
		// [PM319-1]				
		// [RS972][OPTIM_MB3&4]		
		If bVarOrange Or bVarBoost Then

			lRowDD  = idw_wDivDet.Find ( "NOM_ZONE = 'val_pub_orange'" , 1, idw_wDivDet.RowCount () )				
			If lRowDD  <= 0 Then
				lRowDD  = idw_wDivDet.InsertRow (0)
			
				idw_wDivDet.SetItem ( lRowDD , "ID_SIN", idw_wDetailFF.GetItemNumber ( 1, "ID_SIN" ) )
				idw_wDivDet.SetItem ( lRowDD , "ID_GTI", idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) )	
				idw_wDivDet.SetItem ( lRowDD , "ID_DETAIL", idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" ) )		 
				
				If bVarOrange Then 
					idw_wDivDet.SetItem ( lRowDD , "NOM_ZONE", "val_pub_orange" )
					idw_wDivDet.SetItem ( lRowDD , "LIB_LABEL", "Valeur publique Orange" )
				End If 

				If bVarBoost Then 
					idw_wDivDet.SetItem ( lRowDD , "NOM_ZONE", "val_pub_boost" )
					idw_wDivDet.SetItem ( lRowDD , "LIB_LABEL", "Valeur publique Boost" )
				End If 
				
				idw_wDivDet.SetItem ( lRowDD , "ID_TYP_LISTE", "-XX" )
				idw_wDivDet.SetItem ( lRowDD , "ALT_LISTE_CODECAR", "N")
				idw_wDivDet.SetItem ( lRowDD , "ID_TYP_ZONE", "S" )
				idw_wDivDet.SetItem ( lRowDD , "ALT_OBLIG", "N" )
				idw_wDivDet.SetItem ( lRowDD , "ALT_PROT", "O" )
				idw_wDivDet.SetItem ( lRowDD , "CPT_TRI", 510 )
				idw_wDivDet.SetItem ( lRowDD , "VAL_DTE", stNul.dtm )	// [PI056].20190926
				idw_wDivDet.SetItem ( lRowDD , "VAL_CAR", stNul.str)
				idw_wDivDet.SetItem ( lRowDD , "VAL_NBRE", stNul.lng )
				idw_wDivDet.SetItem ( lRowDD , "VAL_MT", dcMtValPub )
				idw_wDivDet.SetItem ( lRowDD , "ALT_SUPP", "N" )
				idw_wDivDet.SetItem ( lRowDD , "CREE_LE", DateTime ( Today (), Now () ) )
				idw_wDivDet.SetItem ( lRowDD , "MAJ_LE", DateTime ( Today (), Now () ) )
				idw_wDivDet.SetItem ( lRowDD , "MAJ_PAR", stGlb.sCodOper )

				If bVarOrange Then 
					lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'VAL_PUB_ORANGE'", 1, idw_wDivDet.RowCount () )
					If lRow > 0 Then
						This.uf_GestOng_Divers_MajZone ( "VAL_PUB_ORANGE", lRow, dcMtValPub )
					End If 			
				End If 

				If bVarBoost Then 
					lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'VAL_PUB_BOOST'", 1, idw_wDivDet.RowCount () )
					If lRow > 0 Then
						This.uf_GestOng_Divers_MajZone ( "VAL_PUB_BOOST", lRow, dcMtValPub )
					End If 			
				End If 
			End IF 
		End If
	
		idw_wDetailFF.SetItem ( 1, "MT_VAL_PUBLIQUE", dcMtPrixFrequent  )
			// Fin #1
			
		// [VDOC26051]
		// On recalcule le MT_PEC
		If This.uf_GestOng_Divers_Trouver ("PEC" ) = "O" And dcMtPrixFrequentActuel <> dcMtPrixFrequent Then
			lRow = idw_wDivDet.Find ( "UPPER ( NOM_ZONE ) = 'PEC'" , 1, idw_wDivDet.RowCount ())
			If lRow > 0 Then
				
				// [VDOC26241]
				If dcMtPrixFrequentActuel = dcMtValAchat And dcMtPrixFrequent > dcMtValAchat Then
					idw_wDetailFF.SetItem ( 1, "MT_VAL_ACHAT", dcMtPrixFrequent  )
				End If 
				
				This.Uf_Zn_Trt_DivDet_Pec ( "O", "VAL_CAR", lRow )
				
			End If 
		End If 

	Case "REF_CODIC_DARTY"
		idw_wDetailFF.SetItem ( 1, "MT_VAL_PUBLIQUE", 0 )
		/* #5 [DCMP080401].SAISIE_VAL_PUBLIQUE (code remonté en haut)
		If	isTypeTrt = "S" And bAutoriserSaisie Then
			idw_wDetailFF.Uf_Proteger ( { "MT_VAL_PUBLIQUE" } , "0" ) // #4
		End If 
		*/

	Case Else
		idw_wDetailFF.SetItem ( 1, "MT_VAL_PUBLIQUE", 0 )

		

End Choose





end subroutine

private function string uf_plaf_adhesion_annee_civile_tt_gti ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adhesion_Annee_Civile_tt_gti (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 04/10/2017
//* Libellé			: [VDOC24781]
//* Commentaires	: Application d'un plafond par Année civile
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012 [VDOC6662]
//        JFF    16/11/2015  [DT159-1]
//*-----------------------------------------------------------------


Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale, lDeb, lFin
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafSav, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdEvt
Decimal{2} 	dcMtAutreSinistre, dcPlafTmp
String		sMtAutreSinistre, sIdNivPlaf, sIdRefPlaf
n_cst_string lnvPFCString

DateTime dtDteSurv

String sRech, sPos, sIdAdh, sIdPara, sCptVer

sPos = ""
/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '753'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
	lTotDetail = idw_wDetailFF.iudwDetailSource.RowCount ()
/*------------------------------------------------------------------*/
/* On s'occupe du détail courant, en insertion ou en modification.  */
/* Ce détail ne sera pas traité dans la boucle.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modification DBI le 12/08/1998                                   */
/*                                                                  */
/* La zone à prendre en compte pour le calcul du montant plafonné   */
/* n'est pas MT_NPLAF      mais MT_PLAF      sinon on ne            */
/* tient pas compte des plafonds appliqués successivement           */
/*------------------------------------------------------------------*/

	dcMtPlaf		= idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF"   )
	lIdDetail	= idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" )

	For	lCpt = 1 To lTotDetail
/*------------------------------------------------------------------*/
/* On ne traite pas le détail courant.                              */
/*------------------------------------------------------------------*/
			If		idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_DETAIL" ) = lIdDetail	Then
					Continue
			Else
/*------------------------------------------------------------------*/
/* Le détail est 'REGLE' ou 'A REGLE', on récupére le montant       */
/* MT_PLAF.                                                         */
/*------------------------------------------------------------------*/
					If	( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 500 Or &
						  idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 600	) And &
						( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) = idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_EVT" ) ) Then

						dcSommeDetail += idw_wDetailFF.iudwDetailSource.GetItemDecimal ( lCpt, "MT_PLAF" )
					End If
			End If
	Next
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
	dcIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	dcMtAutreSinistre = 0
	sMtAutreSinistre = "             "

	itrTrans.PS_S05_W_DETAIL_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, dcIdEvt, dtDteSurv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S05_W_DETAIL_MT_PLAF" )	Then
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée.                                    */
/*------------------------------------------------------------------*/
		sPos		= "ALT_BLOC"
		F_Message ( stMessage )
	Else
/*------------------------------------------------------------------*/
/* On détermine si on dépasse le plafond.                           */
/*------------------------------------------------------------------*/

		dcMtAutreSinistre = Dec ( sMtAutreSinistre )
		dcPlafond			= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcSommeDetail + dcMtAutreSinistre + dcMtPlaf > dcPlafond	Then

			If dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) > 0 Then
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) )
				
				// [PLAF_REF] // [VDOC6662]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "753", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
				// [PLAF_REF]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "753", "NORMAL" )
			End If
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )

/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "753", sIdPara, sCptVer )

			
		End If
	End If
End If
	
Return ( sPos )
end function

private function boolean uf_rf_97 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_97 (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 19/01/2018
//* Libellé			: 
//* Commentaires	: Evénement non couvert
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------

Long lLig, lTotCondition, lDeb, lFin, lIdGti, lIdEvt

n_cst_string lnvPFCString
String sRech, sChaineBcv, sVal

Boolean bRet

/*------------------------------------------------------------------*/
/* On déclenche ce motif si l'événement saisi n'est pas couvert.    */
/* On envoie le test uniquement si la révision est connue.          */
/*------------------------------------------------------------------*/
bRet = True
lIdGti  = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
lIdEvt  = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )


F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 322 )
If lDeb <= 0 Then Return True

sChaineBcv =idw_DetPro.GetItemString ( lDeb, "VAL_CAR" )

sVal = lnvPFCString.of_getkeyvalue ( sChaineBcv, "ID_GTI", ";")
IF Pos ( sVal, "#" + String ( lIdGti ) + "#" ) <= 0 Then Return True

sVal = lnvPFCString.of_getkeyvalue ( sChaineBcv, "ID_EVT", ";")
IF Pos ( sVal, "#" + String ( lIdEvt ) + "#" ) <= 0 Then Return True


If	idw_wSin.GetItemNumber ( 1, "ID_REV" ) <> -1	Then

	sRech = "ID_GTI = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" ) ) + &
			  " And ID_TYP_CODE = '+EV' And ID_CODE = " + String ( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	lTotCondition = idw_Condition.RowCount ()

	lLig = idw_Condition.Find ( sRech, 1, lTotCondition )

/*------------------------------------------------------------------*/
/* L'événement n'est pas couvert, on déclenche le refus.            */
/*------------------------------------------------------------------*/
	If	lLig = 0 Then
		bRet = Uf_RF_EcrireRefus ( 97 )
	End If
End If

Return ( bRet )


	


end function

private function boolean uf_rf_dp307 ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_wdetail::uf_rf_dp307
//* Auteur			: FPI
//* Date				: 18/07/2018
//* Libellé			: 
//* Commentaires	: [VDOC26406]
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

Boolean bRet
Long lRow, lIdEvt, lDeb, lFin, lCpt
n_cst_string lnvPFCString
string sval

bRet = True
lIdEvt = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 307 )	
If lDeb > 0 Then
	For lCpt = lDeb To lFin 
		sVal=lnvPFCString.of_getkeyvalue( idw_DetPro.GetItemString ( lCpt, "VAL_CAR" ), "ID_EVT", ";")

		if sVal=String(lIdEvt) Then
			sVal=lnvPFCString.of_getkeyvalue( idw_DetPro.GetItemString ( lCpt, "VAL_CAR" ), "ID_REFUS", ";")
			bRet = Uf_RF_EcrireRefus ( Long(sVal) )
		End If 
		
	Next
End If
	
Return ( bRet )
end function

private function long uf_zn_trt_divdet_souplesse (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_Souplesse (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 25/09/2018
//* Libellé			: [DT344]
//* Commentaires	: 
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//  JFF   08/10/2024  [MCO194]
//*-----------------------------------------------------------------

Long    dcIdProd, dcIdGti, lRet, dcIdRev
Int	  iAction

iAction = 0 

dcIdProd = idw_wSin.GetItemNumber ( 1, "ID_PROD" )
dcIdRev  = idw_wSin.GetItemNumber ( 1, "ID_REV" )
dcIdGti  = idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )

asData 	= Trim ( asData )
If IsNull ( asData ) Then asData = ""

// [VDOC28827] et [VDOC28866]
If asData = "AAA" Then Return iAction

lRet = SQLCA.PS_S_SOUPLESSE_V01 ( dcIdProd, dcIdRev, dcIdGti, asData )

If lRet < 0 Then
	idw_wDivDet.iiErreur = 4
	iAction = 1
End If 

Return iAction


end function

private function string uf_plaf_adhesion_renouv_typepers ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_plaf_adhesion_renouv_typepers (PRIVATE)
//* Auteur			: FABRYJF
//* Date				: 17/10/2018 15:07:49
//* Libellé			: 
//* Commentaires	: Application d'un plafond par adhésion/Année renouvellement et par type de personne
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF	  29/05/2012 [VDOC6662]
//        JFF    16/11/2015 [DT159-1]
//*-----------------------------------------------------------------
Long lTotPlaf, lLig, lTotDetail, lCpt, lIdDetail, lLigFinale, lCptMax, lDeb, lFin
Decimal {2} dcPlafond, dcSommeDetail, dcMtPlaf, dcPlafSav, dcPlafTmp, dcEcoTaxe
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdEvt, lRow
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
n_cst_string lnvPFCString
Decimal{2} 	dcMtAutreSinistre
String		sMtAutreSinistre
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh, sTypePersonne

sPos = ""
/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '756'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
	lTotDetail = idw_wDetailFF.iudwDetailSource.RowCount ()
/*------------------------------------------------------------------*/
/* On s'occupe du détail courant, en insertion ou en modification.  */
/* Ce détail ne sera pas traité dans la boucle.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modification DBI le 12/08/1998                                   */
/*                                                                  */
/* La zone à prendre en compte pour le calcul du montant plafonné   */
/* n'est pas MT_NPLAF      mais MT_PLAF      sinon on ne            */
/* tient pas compte des plafonds appliqués successivement           */
/*------------------------------------------------------------------*/

	dcMtPlaf		= idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF"   )
	lIdDetail	= idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" )

	For	lCpt = 1 To lTotDetail
/*------------------------------------------------------------------*/
/* On ne traite pas le détail courant.                              */
/*------------------------------------------------------------------*/
			If		idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_DETAIL" ) = lIdDetail	Then
					Continue
			Else
/*------------------------------------------------------------------*/
/* Le détail est 'REGLE' ou 'A REGLE', on récupére le montant       */
/* MT_PLAF.                                                         */
/*------------------------------------------------------------------*/
					If	( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 500 Or &
						  idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 600	) And &
						( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) = idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_EVT" ) ) Then

						dcSommeDetail += idw_wDetailFF.iudwDetailSource.GetItemDecimal ( lCpt, "MT_PLAF" )
					End If
			End If
	Next

/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdGti		= idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )
	dcIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	sTypePersonne = ""

	lRow = idw_wDivSin.Find ( "Upper (NOM_ZONE) = 'PERSONNE_SIN'", 1, idw_wDivSin.RowCount () ) 
	If lRow >0 Then 
		sTypePersonne = Upper ( idw_wDivSin.GetItemString ( lRow, "VAL_CAR" ) )
		If IsNull ( sTypePersonne ) Then sTypePersonne = ""
	End If

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
   sUntPerRnv_Adh		= idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
/*----------------------------------------------------------------------*/
/* On calcule la date du dernier renouvellement.                        */
/* En fonction de l'unité de periode de renouvellement (ANNEE,MOIS,JOUR)*/
/*----------------------------------------------------------------------*/
   Choose Case sUntPerRnv_Adh
	   Case "A"
	     lCptMax = 30
	   Case "M"
	     lCptMax = 360
	   Case "J"
	    lCptMax = 10950
	End Choose

	For	lCpt = 1 To lCptMax
			dDteResult = F_Plus_Date ( dDteAdh, dcDurPerRnv_Adh, sUntPerRnv_Adh )
			If	dDteResult <= idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )	Then
				dDteAdh = dDteResult
			Else
				Exit
			End If
	Next

	dtDteAdhRenouv 	= DateTime ( dDteAdh )
	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S_W_DETAIL_MT_PLAF_756 ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, sTypePersonne, dcIdGti, dcIdEvt, dtDteSurv, dtDteAdhRenouv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S03_W_DETAIL_MT_PLAF" )	Then
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée.                                    */
/*------------------------------------------------------------------*/
		sPos		= "ALT_BLOC"
		F_Message ( stMessage )
	Else
/*------------------------------------------------------------------*/
/* On détermine si on dépasse le plafond.                           */
/*------------------------------------------------------------------*/

		dcMtAutreSinistre = Dec ( sMtAutreSinistre )
		dcPlafond			= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If	dcSommeDetail + dcMtAutreSinistre + dcMtPlaf > dcPlafond	Then
				
			If dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) > 0 Then
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) )
				
				// [PLAF_REF]// [VDOC6662] 
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "756", "REF_PLAF_NUM_>0" )

				
			Else
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
				
				// [PLAF_REF]
				ibPlafNumeraire = TRUE // [PLAF_REF]				
				sPos = Uf_Plaf_Refus ( "756", "NORMAL" )
			End If
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )

/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "756", sIdPara, sCptVer )
			
			
		End If
	End If
End If
	
Return ( sPos )
end function

private function long uf_zn_trt_divdet_refusscb (string asdata, string asnomcol, long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Zn_Trt_DivDet_RefusSCB (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 24/05/2019
//* Libellé			: [DT391-1]
//* Commentaires	: 
//*
//* Arguments		: String 		asData			Val
//*					  String 		asNomCol			Val
//*					  Long			alRow				Val
//*
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Int	  iAction, iEtat 

iAction = 0 

iEtat = idw_wDetailFF.GetItemNumber ( 1, "COD_ETAT" )

Choose Case iEtat 
	Case 0 , 100
		// OK
	Case Else
		idw_wDivDet.iiErreur = 5
		iAction = 1
End Choose 

Return iAction


end function

private subroutine uf_controlergestion_franchise_cb_extr (ref string aspos);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerGestion_Franchise_CB_EXTR (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 03/10/2019 
//* Libellé			: [PM462-1][V3]
//* Commentaires	: Contrôles liés au remboursement de Franchise CB Extranet
//*
//* Arguments		: String		asPos		Réf.
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*
//*-----------------------------------------------------------------

Long dcIdSin, lRet, lIdEvt
Decimal {2} dcMtFranCBprej

dcIdSin = idw_wDetailFF.GetItemNumber ( 1, "ID_SIN" )
dcMtFranCBprej = idw_wDetailFF.GetItemDecimal ( 1, "MT_PREJ" )
lIdEvt = idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )

Choose Case lIdEvt 
	Case 1461 	
	
		// 1/ Contrôle sur l’evt : On autorise si la SUM des reglements CB (+/-) > 0 car si =0, plus rien n’est à rembourser.
		lRet = SQLCA.PS_I_PM462_1_CTRLE_REMB_FRANCHISE ( dcIdSin, "SUM_FRANCHISE_CB_REG_POSITIF", dcMtFranCBprej )
		
		If lRet < 0 Then
			asPos = "ID_I_REG"
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "WDET673"
			stMessage.Icon			= Exclamation!
			stMessage.bouton = Ok!
			F_Message ( stMessage )
			Return
		End If 
		
		
		// 2/ Le remboursement d’une franchise sur l’evt (le montant) doit correspondre à un des montants de franche CB/EXTR existant dans reglement.
		lRet = SQLCA.PS_I_PM462_1_CTRLE_REMB_FRANCHISE ( dcIdSin, "FRANCHISE_EGALE_AMU_MT_CB_DS_REGL", dcMtFranCBprej )
		
		If lRet < 0 Then
			asPos = "ID_I_REG"
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "WDET674"
			stMessage.sVar[1]    = String ( dcMtFranCBprej ) + "€"
			stMessage.Icon			= Exclamation!
			stMessage.bouton = Ok!
			F_Message ( stMessage )
			Return
		End If 
		
		
		// 3/ La SUM des reglements CB (+/-) > 0 + le présent remboursement (négatif) ne doit as donner un nombre négatif, sinon, interdire (problème cas anormal). Cela doit rester positif ou nulle (0)
		lRet = SQLCA.PS_I_PM462_1_CTRLE_REMB_FRANCHISE ( dcIdSin, "SUM_FRANCHISE_CB_PLUS_MT_PREJ_POSITIF_OU_ZERO", dcMtFranCBprej )
		
		If lRet < 0 Then
			asPos = "ID_I_REG"
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "WDET675"
			stMessage.sVar[1]    = String ( dcMtFranCBprej ) + "€"
			stMessage.Icon			= Exclamation!
			stMessage.bouton = Ok!
			F_Message ( stMessage )
			Return
		End If 
		
		// 5/ Forcer le règlement sur l’evt 1461 pour régler la franchise et supprimer ce forçage par la suite.
		idw_wDetailFF.SetItem ( 1, "ALT_REG", "O" )

	Case Else
		// 4/ A contrôler sur un RN : si le montant de l’evt (quel qu’il soit) soit égale à un des montants de Franchise payé, alors avertir le GT par un message « Erreur ou Ok ? »		
		lRet = SQLCA.PS_I_PM462_1_CTRLE_REMB_FRANCHISE ( dcIdSin, "RN_REEL_OU_REMB_FRANCHISE", dcMtFranCBprej )
		
		If lRet < 0 Then
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "WDET676"
			stMessage.sVar[1]    = String ( dcMtFranCBprej ) + "€"
			stMessage.Icon			= Exclamation!
			stMessage.bouton = YESNO!
			If F_Message ( stMessage ) = 2 Then	asPos = "ID_I_REG"
			
			Return
		End If 
		
		
End Choose 		





end subroutine

public function string uf_plaf_adhesion_survenance_ttegti ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adhesion_Survenance_TteGti (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 26/11/2012
//* Libellé			: [PC192290]
//* Commentaires	: Application d'un plafond par adhésion/Année survenace glissante
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//* #2	 JFF	  22/03/2005  DCMP 050003.
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF	  29/05/2012  [VDOC6662]
//        JFF    16/11/2015  [DT159-1]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale, lDeb, lFin
Decimal {2} dcPlafond, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcEcoTaxe, dcMtPlaf, dcSommeDetail		
Long dcIdSin, dcIdProd, dcIdEts, lTotDetail, lLigDet, iIdDetail, dcIdEvt, lIdDetail
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
n_cst_string lnvPFCString
sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '734'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
	
	lTotDetail = idw_wDetailFF.iudwDetailSource.RowCount ()
/*------------------------------------------------------------------*/
/* On s'occupe du détail courant, en insertion ou en modification.  */
/* Ce détail ne sera pas traité dans la boucle.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modification DBI le 12/08/1998                                   */
/*                                                                  */
/* La zone à prendre en compte pour le calcul du montant plafonné   */
/* n'est pas MT_NPLAF      mais MT_PLAF      sinon on ne            */
/* tient pas compte des plafonds appliqués successivement           */
/*------------------------------------------------------------------*/

	dcMtPlaf		= idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF"   )
	lIdDetail	= idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" )

	For	lCpt = 1 To lTotDetail
/*------------------------------------------------------------------*/
/* On ne traite pas le détail courant.                              */
/*------------------------------------------------------------------*/
			If		idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_DETAIL" ) = lIdDetail	Then
					Continue
			Else
/*------------------------------------------------------------------*/
/* Le détail est 'REGLE' ou 'A REGLE', on récupére le montant       */
/* MT_PLAF.                                                         */
/*------------------------------------------------------------------*/
					If	( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 500 Or &
						  idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 600	) And &
						( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) = idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_EVT" ) ) Then

						dcSommeDetail += idw_wDetailFF.iudwDetailSource.GetItemDecimal ( lCpt, "MT_PLAF" )
					End If
			End If
	Next	
	
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S734_W_DETAIL_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdEvt, dtDteSurv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S734_W_DETAIL_MT_PLAF" )	Then 
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée, on affiche le message.             */
/*------------------------------------------------------------------*/
		f_Message ( stMessage )
		sPos = "MT_PROV"
	Else
/*------------------------------------------------------------------*/
/* On détermine si on dépasse le plafond.                           */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Modification DBI le 12/08/1998                                   */
/*                                                                  */
/* La zone à prendre en compte pour le calcul du montant plafonné   */
/* n'est pas MT_NPLAF_AREG mais MT_PLAF_AREG sinon on ne            */
/* tient pas compte des plafonds appliqués successivement           */
/*------------------------------------------------------------------*/

		dcMtAutreSinistre = Dec ( sMtAutreSinistre )
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcSommeDetail + dcMtAutreSinistre + dcMtPlaf > dcPlafond	Then

			If dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) > 0 Then
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) )
				
				// [PLAF_REF] // [VDOC6662]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "734", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
				// [PLAF_REF]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "734", "NORMAL" )
			End If
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )

/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "734", sIdPara, sCptVer )

			
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )
	

end function

public function string uf_plaf_adhesion_survenance_gtidp351 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adhesion_Survenance_GtiDp351 (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 08/09/2020
//* Libellé			: [PC202551]
//* Commentaires	: Application d'un plafond par adhésion/Année survenace glissante
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//* #2	 JFF	  22/03/2005  DCMP 050003.
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF	  29/05/2012  [VDOC6662]
//        JFF    16/11/2015  [DT159-1]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale, lDeb, lFin
Decimal {2} dcPlafond, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcEcoTaxe, dcMtPlaf, dcSommeDetail		
Long dcIdSin, dcIdProd, dcIdEts, lTotDetail, lLigDet, iIdDetail, dcIdEvt, lIdDetail
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
n_cst_string lnvPFCString
sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 2 to 5

	Choose Case lCpt
		Case 2
			sIdNivPlaf = "+NS"  // Nature de sinistre
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivPlaf = "+TR"  // Territorialité
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivPlaf = "+DT"  // Détail
			sIdRefPlaf = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
		Case 5
			sIdNivPlaf = "+EV"  // Evénement de garantie
			sIdRefPlaf = String (idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) )

	End Choose

	If IsNull ( sIdRefPlaf ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un plafond										  */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '"  + sIdNivPlaf 																+ "' AND " 	+ &
					"ID_REF_PLAF = "	+ sIdRefPlaf 																+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																				+ " AND " 	+ &
					"ID_TYP_PLAF = '759'"

	lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

	If lLig > 0 Then	

		dcPlafTmp		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		If dcPlafSav <> 0 Then

			If dcPlafTmp < dcPlafSav Then 
				dcPlafSav = dcPlafTmp 
				lLigFinale = lLig
			End If

		Else
			dcPlafSav = dcPlafTmp 
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/

If	lLig > 0 Then
	
	lTotDetail = idw_wDetailFF.iudwDetailSource.RowCount ()
/*------------------------------------------------------------------*/
/* On s'occupe du détail courant, en insertion ou en modification.  */
/* Ce détail ne sera pas traité dans la boucle.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modification DBI le 12/08/1998                                   */
/*                                                                  */
/* La zone à prendre en compte pour le calcul du montant plafonné   */
/* n'est pas MT_NPLAF      mais MT_PLAF      sinon on ne            */
/* tient pas compte des plafonds appliqués successivement           */
/*------------------------------------------------------------------*/

	dcMtPlaf		= idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF"   )
	lIdDetail	= idw_wDetailFF.GetItemNumber ( 1, "ID_DETAIL" )

	For	lCpt = 1 To lTotDetail
/*------------------------------------------------------------------*/
/* On ne traite pas le détail courant.                              */
/*------------------------------------------------------------------*/
			If		idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_DETAIL" ) = lIdDetail	Then
					Continue
			Else
/*------------------------------------------------------------------*/
/* Le détail est 'REGLE' ou 'A REGLE', on récupére le montant       */
/* MT_PLAF.                                                         */
/*------------------------------------------------------------------*/
					If	( idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 500 Or &
						  idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "COD_ETAT" ) = 600	) And &
						( idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" ) = idw_wDetailFF.iudwDetailSource.GetItemNumber ( lCpt, "ID_EVT" ) ) Then

						dcSommeDetail += idw_wDetailFF.iudwDetailSource.GetItemDecimal ( lCpt, "MT_PLAF" )
					End If
			End If
	Next	
	
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdEvt		= idw_wDetailFF.GetItemNumber ( 1, "ID_EVT" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S759_W_DETAIL_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdEvt, dtDteSurv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S759_W_DETAIL_MT_PLAF" )	Then 
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée, on affiche le message.             */
/*------------------------------------------------------------------*/
		f_Message ( stMessage )
		sPos = "MT_PROV"
	Else
/*------------------------------------------------------------------*/
/* On détermine si on dépasse le plafond.                           */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Modification DBI le 12/08/1998                                   */
/*                                                                  */
/* La zone à prendre en compte pour le calcul du montant plafonné   */
/* n'est pas MT_NPLAF_AREG mais MT_PLAF_AREG sinon on ne            */
/* tient pas compte des plafonds appliqués successivement           */
/*------------------------------------------------------------------*/

		dcMtAutreSinistre = Dec ( sMtAutreSinistre )
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcSommeDetail + dcMtAutreSinistre + dcMtPlaf > dcPlafond	Then

			If dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) > 0 Then
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", dcPlafond - ( dcSommeDetail + dcMtAutreSinistre ) )
				
				// [PLAF_REF] // [VDOC6662]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "759", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wDetailFF.SetItem ( 1, "MT_PLAF", 0 )
				// [PLAF_REF]
				ibPlafNumeraire = TRUE // [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "759", "NORMAL" )
			End If
			idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "O" )

/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "759", sIdPara, sCptVer )

			
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )
	

end function

private subroutine uf_gestion_dtedet ();//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_Sinistre_Wdetail::uf_Gestion_DteDet (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 11/09/2020 14:10:05
//* Libellé       : [VDOC29630]
//* Commentaires  : A la création du détail uniquement, on insert la valeur d'achat 
//*                 provenant des adhésions si elle elle présente du w_div_sin 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//       JFF   07/11/2016 [PC151259]
//*-----------------------------------------------------------------

DateTime dtDteAchSin, dtDteDet
Date     dDteDetDate
Long lIdGti, lDeb, lFin, lCptDteDet

lIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )


F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 353 )
If lDeb <= 0 Then Return

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 42 )
If lDeb > 0 Then
	For lCptDteDet = lDeb to lFin 
		If idw_DetPro.GetItemNumber ( lCptDteDet, "ID_CODE_NUM") = lIdGti And idw_DetPro.GetItemString ( lCptDteDet, "ID_CODE_CAR" ) = "A"  Then 
			dtDteAchSin = idw_Wsin.GetItemDateTime ( 1, "DTE_ACH_PORT" )
			dDteDetDate = idw_wDetailFF.GetItemDate ( 1, "DTE_DET_DATE" )		
			If Not IsNull ( dtDteAchSin ) And IsNull ( dDteDetDate ) Then
				idw_wDetailFF.SetItem ( 1, "DTE_DET_DATE", dtDteAchSin )
			End If 
		End If
	Next
End If 


end subroutine

public function boolean uf_rf_dp370_val_div_det ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_dp370_val_div_det (PRIVATE)
//* Auteur			: JFF
//* Date				: 18/09/2023
//* Libellé			: [RS5875_DIF_DIV_DET]
//* Commentaires	: Adhésion résiliée
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
Boolean bRet 
n_cst_string lnvPFCString
Int iIdGti, iIdMotif
Long lDeb, lFin, lCptDp 
String sValCar, sLstGti, sNomZone, sValRefus, sVal

bRet = True

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 370 )
If lDeb <=0 Then Return True

// Initialisation des données du détail de garantie
iIdGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )

For lCptDp = lDeb To lFin
	
	// Initialisation des données de param
	sValCar = idw_DetPro.GetItemString ( lCptDp, "VAL_CAR" ) 
	sLstGti = lnvPFCString.of_getkeyvalue (sValCar, "ID_GTI", ";")
	sNomZone = Upper ( lnvPFCString.of_getkeyvalue (sValCar, "NOM_ZONE", ";"))
	sValRefus = lnvPFCString.of_getkeyvalue (sValCar, "VAL_REF", ";")
	iIdMotif = Integer ( lnvPFCString.of_getkeyvalue (sValCar, "ID_MOTIF", ";"))
	
	If Pos ( "#" + String ( iIdGti ) + "#", sLstGti ) <= 0 Then Continue
	
	sVal   = This.uf_GestOng_Divers_Trouver ( sNomZone )
	If IsNull ( sVal ) Then sVal = ""
	
	Choose Case sVal 
		Case "NRS", ""
			Continue
	End Choose 
	
	If Pos ( "#" + String ( sVal ) + "#", sValRefus ) <= 0 Then Continue
	
	bRet = Uf_RF_EcrireRefus ( iIdMotif )
	
	If Not bRet Then Exit

Next 

Return ( bRet )

end function

public function string uf_epurezone (string asvaleur);//*-----------------------------------------------------------------
//* 
//* Fonction		: u_gs_sp_sinistre_detail::uf_epurezone
//* Auteur			: F. Pinon
//* Date				: 11/10/2010 15:34:44
//* Libellé			: Foncion d'épuration du contenu de zone (tab + retours chariots)
//* Commentaires	: [FPI.11102010] 
//*
//* Arguments		: value string asvaleur	 */
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	30/05/2012	[EpureModele]	Suppr des ; dans marque/modèle
//			FPI	27/11/2012	[VDoc9391]
//			FPI	27/09/2013	[VDoc12269]
//       JFF   31/05/2021  ajout ”  (c'est un double quote spécial) [EPUR_MODL]
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
// :[VDoc9391]

sRet = f_remplace(sRet,Char(13)," ")
sRet = f_remplace(sRet,Char(10)," ")
sRet = f_remplace(sRet,Char(9)," ")
sRet = f_remplace(sRet,Char(11)," ")
sRet = f_remplace(sRet,";"," ")	// [EpureModele]	
sRet = f_remplace(sRet,"~"","p")// [VDoc12269]

// [EPUR_MODL]
sRet = f_remplace(sRet,"”","p")


Return sRet
end function

public subroutine uf_gestong_divers_caspart_liste (string asnomzone, long alidprod, long alidrev, long alidgti);//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_sinistre_wdetail::uf_GestOng_Divers_CasPart_Liste (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 29/09/2004 11:13:57
//* Libellé       : Gestion des cas particuliers lors du chargement des listes l'onglet divers
//* Commentaires  : 
//*
//* Arguments		: String			asNomZone		Val
//*					  String			alIdProd			Val
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//        JFF   08/10/2024   [MCO194]
//*
//*-----------------------------------------------------------------
Long lDeb, lFin, lTot1, lTot2, lCpt1, lCpt2, lRet
Boolean bTrouve
String	sIdCode

asNomZone = Upper ( asNomZone )


Choose Case asNomZone	

	Case "SOUPLESSE_1", "SOUPLESSE_2", "SOUPLESSE_3"

		lTot1 = idddw_CodeCar_wDivDet_Charg_Tempo.RowCount ()
		
		For lCpt1 = lTot1 To 1 Step -1
			sIdCode = idddw_CodeCar_wDivDet_Charg_Tempo.GetItemString ( lCpt1, "ID_CODE" )
			
			If sIdCode = "AAA" Then Continue
			
			lRet = SQLCA.PS_S_SOUPLESSE_V01 ( alIdProd, alIdRev, alIdGti, sIdCode ) // [MCO194]
			
			If lRet < 0 Then
				idddw_CodeCar_wDivDet_Charg_Tempo.RowsDiscard ( lCpt1, lCpt1, Primary! )				
			End If 
			
		Next

End Choose



end subroutine

public subroutine uf_affichage_dw_choix_action (integer alidevt);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_affichage_dw_choix_action (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 14/02/2025
//* Libellé			: 
//* Commentaires	: Calcul du Montant à régler
//*
//* Arguments		: Aucun
//*
//* Retourne		: String					Nom de la zone sur laquelle on se positionne si Erreur
//*
//*-----------------d------------------------------------------------
Long lDeb, lFin, lIGti
String sLibEvt
	
If Not idw_ChoixAction.Visible Then Return

lIGti = idw_wDetailFF.GetItemNumber ( 1, "ID_GTI" )

idw_ChoixAction.dataobject = "d_choix_action"
idw_ChoixAction.InsertRow ( 0 )
idw_ChoixAction.SetItem ( 1, "CHOIX_ACTION", "R" )	
icbCommander.Text = "Réparer >>"	


F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 393 )

If lDeb > 0 Then
	
	Choose Case alIdEvt
		Case 1491
			idw_ChoixAction.dataobject = "d_choix_action_service_hub"
			idw_ChoixAction.InsertRow ( 0 )				

			idw_ChoixAction.SetItem ( 1, "CHOIX_ACTION", "R" )
			icbCommander.Text = "Serv. HUB >>"					
			
	End Choose
	
End If 	

sLibEvt  = Upper ( SQLCA.FN_CODE_NUM ( alIdEvt, "+EV" ) )
If Left ( sLibEvt, 5 ) = "REMPL" Or lIGti = 10 Then

	idw_ChoixAction.dataobject = "d_choix_action_cmde_seule"
	idw_ChoixAction.InsertRow ( 0 )

	idw_ChoixAction.SetItem ( 1, "CHOIX_ACTION", "C" )
	icbCommander.Text = "Commander >>"
End If 
idw_ChoixAction.Show() 
idw_ChoixAction.BringToTop = True


end subroutine

private function decimal uf_calcul_montantvetuste_2 (string ascas, decimal adcmtvalpivot, integer aidurgtigc, date addteachat, date addtesurv);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Calcul_MontantVetuste (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 21/12/2010
//* Libellé			: [PC301][VESTUSTE]
//* Commentaires	: Calcul du Montant en fonction de la vestuste
//*
//* Arguments		: String		asCas					Val
//*					  Decimal   adcMtValPivot		Val
//*					  Integer   aiDurGtiGc			Val
//*					  Date		adDteAchat			Val
//*					  Date		adDteSurv			Val
//*
//* Retourne		: decimal dcValRetour
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    21/01/2011  [PC301].[V15_EVOL_VETUSTE]
//			 JFF 	  17/09/2015  [VDOC18560]
//        JFF    24/06/2019  [PC192235]
//        JFF    21/10/2020  [VDOC29747]
//        JFF    18/02/2025  [PMO268_MIG25]
//        JFF    18/02/2025  [PMO268_MIG20]
//			 JFF    20/02/2025  [MODIF_CALC_VETUSTE]
//*-----------------------------------------------------------------
Decimal {2} dcValRetour, dcMtValPublique
Int iVetuste, iJour, iJour2
String sVetuste, sValDte, sVetusteModifie, sVal
Date dVal, dtVal
Long lRow, lDeb, lFin
n_cst_string lnvPFCString
Boolean 	bExclureCalcVetuste //	[VDOC18560]
Boolean 	bSC2FoyerNomade // [PC192235]
Boolean  bProtectEffPers, bCarrefourGRTV, bEvollis, bOuiBike // [VDOC29747]

dcValRetour	= 0
bExclureCalcVetuste = FALSE

bCarrefourGRTV = asCas = "CARREFOUR_GRTV"
bSC2FoyerNomade = asCas = "S2C_FOYER_NOMADE"

//	[VDOC18560]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 152 )
sVal= Upper ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "EXCL_CALC_VETUSTE", ";"))
bExclureCalcVetuste = sVal = "OUI"

// [PC192235]
// /!\ DEFINITION DES CAS ICI si cas non passés en argument /!\
If asCas = "" Then 
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 341 )
	sVal= Upper ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";"))
	bSC2FoyerNomade = sVal = "FOYER_NOMADE"

	// [VDOC29747]
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 355 )
	If lDeb > 0 Then 
		sVal= Upper ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";"))
		bProtectEffPers = sVal = "PROTECT_EFF_PERS"
		bEvollis = sVal = "EVOLLIS" // [PMO268_MIG25]
		bOuiBike = sVal = "OUIBIKE" // [PMO268_MIG20]
	End IF 
End IF 

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 102 )
If lDeb > 0 Then
	idw_wDetailFF.Uf_Proteger ( { "MT_VAL_PUBLIQUE" } , "0" )
Else
	idw_wDetailFF.Uf_Proteger ( { "MT_VAL_PUBLIQUE" } , "1" )	
End If

dcMtValPublique = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_PUBLIQUE" )
If IsNull ( dcMtValPublique ) Then dcMtValPublique = 0	

// [PC192235] // [VDOC29747]
Choose Case True
	Case bCarrefourGRTV 
		If dcMtValPublique > 0 Then
			stMessage.sTitre		= "Prise en charge"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WDET590"
			
			//	[VDOC18560]
			If Not bExclureCalcVetuste Then
				F_Message (stMessage)
			End If 
		End If 			
End Choose 


iVetuste = 0
dtVal = adDteAchat

Choose Case True
		
	// [PMO268_MIG25] [PMO268_MIG20]		
	Case bEvollis, bOuiBike
		// 1% de vétusté par mois d’ancienneté à compter du 13ème mois après l’achat, 
		// limité à 40 mois (on commence à Date d’achat + 12 mois).
		dtVal = F_Plus_Date ( dtVal, 12, "M" )
		
End Choose 


iJour = Day ( dtVal )
Do While dtVal <= adDteSurv
	dtVal = F_Plus_Date ( dtVal, 1, "M" )

	If Day ( dtVal ) <> iJour Then
		iJour2 = iJour
		sValDte = ""

		Do While Not IsDate ( sValDte )
			sValDte = String ( iJour2 ) + "/" + String ( Month ( dtVal )) + "/" + String ( Year ( dtVal ))
			If Not IsDate ( sValDte ) Then
				iJour2 --	
			End If						
		Loop
		
		dtVal = Date ( sValDte )
		
	End If						
		
	If dtVal <= adDteSurv Then
		iVetuste ++
	End If
Loop

If dtVal > adDteSurv Then
	dtVal = F_Plus_Date ( dtVal, -1, "M" )				
End If


sVetuste = String ( iVetuste )
If adDteSurv > dtVal Then

	Choose Case True 
		Case bCarrefourGRTV 
			iVetuste += 1
	End CHoose 

	sVetuste = "+" + String ( iVetuste )
			
End If		
		
lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'VETUSTE'", 1, idw_wDivDet.RowCount () )
If lRow > 0 Then
	This.uf_GestOng_Divers_MajZone ( "VETUSTE", lRow, sVetuste )
End If 


Choose Case True 
		
	Case bCarrefourGRTV 

		Choose Case aiDurGtiGc
			
			Case 12
		
				// non géré par SPB, géré par carrefour à 0.9%
				If iVetuste > 12 and iVetuste <= 24 Then
					dcValRetour = 0
				End If
				
				If iVetuste > 24 and iVetuste <= 36 Then
					dcValRetour = adcMtValPivot * 0.8
				End If

			Case 24

				If iVetuste > 24 and iVetuste <= 36 Then
					dcValRetour = adcMtValPivot * 0.8
				End If

				If iVetuste > 36 and iVetuste <= 48 Then
					dcValRetour = adcMtValPivot * 0.7
				End If

				If iVetuste > 48 and iVetuste <= 60 Then
					dcValRetour = adcMtValPivot * 0.6
				End If
				
		End Choose

		//	[VDOC18560]
		If bExclureCalcVetuste Then
			dcValRetour = adcMtValPivot
			sVetusteModifie = "+0"
			
			lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'VETUSTE'", 1, idw_wDivDet.RowCount () )
			If lRow > 0 Then
				This.uf_GestOng_Divers_MajZone ( "VETUSTE", lRow, sVetusteModifie )
			End If
		End If

		If dcMtValPublique > 0 Then
			sVetusteModifie = sVetuste + " /vPubliq.existante non calculée"
		
			lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'VETUSTE'", 1, idw_wDivDet.RowCount () )
			If lRow > 0 Then
				This.uf_GestOng_Divers_MajZone ( "VETUSTE", lRow, sVetusteModifie )
			End If
			
			dcValRetour = dcMtValPublique 
		End If		
		

	// [PC192235]
	Case bSC2FoyerNomade
		// 1% par mois d'ancienneté (vétusté Linéaire)
		dcValRetour = adcMtValPivot * ( 1 - ( 0.01 * iVetuste ))


	// [VDOC29747]			
	Case bProtectEffPers
		// 2% de vétusté par mois (vétusté composée)
		dcValRetour = adcMtValPivot * 0.98^iVetuste
		
	// [PMO268_MIG25] [PMO268_MIG20]		
	Case bEvollis, bOuiBike
		If iVetuste > 40 Then iVetuste = 40 // Limité à 40 mois Max.

		// 1% de vétusté par mois (vétusté composée)
		dcValRetour = adcMtValPivot * 0.99^iVetuste
		

End Choose 


// [PC192235]
Choose Case True
	Case bCarrefourGRTV 
		If dcMtValPublique > 0 Then
			sVetusteModifie = sVetuste + " /vPubliq.existante non calculée"
		
			lRow = idw_wDivDet.Find ( "Upper (nom_zone) = 'VETUSTE'", 1, idw_wDivDet.RowCount () )
			If lRow > 0 Then
				This.uf_GestOng_Divers_MajZone ( "VETUSTE", lRow, sVetusteModifie )
			End If
			
			dcValRetour = dcMtValPublique 
		End If
		
End Choose 

Return dcValRetour

end function

on u_gs_sp_sinistre_wdetail.create
call super::create
end on

on u_gs_sp_sinistre_wdetail.destroy
call super::destroy
end on

