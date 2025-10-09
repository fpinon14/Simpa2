$PBExportHeader$u_gs_sp_sinistre_garantie.sru
$PBExportComments$---} User Object pour la gestion des garanties. (W_GAR_SIN)
forward
global type u_gs_sp_sinistre_garantie from u_gs_sp_sinistre_anc
end type
end forward

global type u_gs_sp_sinistre_garantie from u_gs_sp_sinistre_anc
end type
global u_gs_sp_sinistre_garantie u_gs_sp_sinistre_garantie

type variables
Private :
	U_DataWindow		idw_wGarSin
	U_Datawindow		idw_wDivSin

	u_DataWindow_Detail	idw_LstInter
	u_DataWindow_Detail	idw_LstGti
	u_DataWindow_Detail	idw_LstDetail
	u_DataWindow_Detail	idw_LstCmdeGti
	u_DataWindow_Detail	idw_LstCmdeSin
	u_DataWindow_Detail	idw_DivDetSin
	u_DataWindow_Detail	idw_DivDetGti

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
	DataWindow		idw_wDetail
	DataWindow		idw_wPiece
	DataWindow		idw_wRefus
	DataWindow		idw_wParaPlafond
	DataWindow		idw_wPPlafond_Gti
	DataWindow		idw_wPPlafond_Detail

	DataWindow		idw_wPiece_Detail
	DataWindow		idw_wRefus_Detail
	DataWindow		idw_wDetailSupp

//Migration PB8-WYNIWYG-03/2006 OR
//variable déclarée dans l'ancêtre
//	DataWindow		idw_DetPro	// DCMP 030027 : CAG 06/02/2003 
//Fin Migration PB8-WYNIWYG-03/2006 OR
	DataWindow		idwAutorisation
	U_Tagger		iuoTagPiece
	U_Tagger		iuoTagRefus

	Date			idDteOppo

	Boolean			ibPlafRef // [PLAF_REF]
	Boolean			ibPlaf748 // [DT215]

	CommandButton		icbTarif

	// 04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
	Long ilEtatForceOpe   // Si >0 alors forcé
	
end variables

forward prototypes
public subroutine uf_traitement (integer aitype, ref s_pass astpass)
private subroutine uf_preparermodifier (ref s_pass astpass)
private subroutine uf_initialiserfenetre ()
private subroutine uf_tb_validation ()
private subroutine uf_tb_oppo ()
private subroutine uf_controlersaisie (ref s_pass astpass)
private subroutine uf_changerproduit ()
private subroutine uf_controlergestion (ref s_pass astpass)
private subroutine uf_gestionutagger_piece (integer aitype)
private subroutine uf_gestionutagger_refus (integer aitype)
private subroutine uf_preparervalider_piece (ref s_pass astpass)
private subroutine uf_preparervalider_refus (ref s_pass astpass)
private subroutine uf_preparervalider (ref s_pass astpass)
private subroutine uf_gestion_piece_detail (integer aitype)
private subroutine uf_preparerinserer (ref s_pass astpass)
private subroutine uf_zn_altbloc ()
private subroutine uf_preparervalider_detail (ref s_pass astpass)
private subroutine uf_cast_dteoppo ()
private function boolean uf_gestionrefus ()
private function boolean uf_rf_ecrirerefus (long alrefus)
private function boolean uf_rf_611 ()
private function boolean uf_rf_612 ()
private function boolean uf_rf_613 ()
private function boolean uf_rf_615 ()
private function boolean uf_rf_621 ()
private function boolean uf_rf_602 ()
private function boolean uf_rf_601 ()
private function string uf_determiner_etat (integer aitype)
private function boolean uf_determiner_etat_detail (integer aitype)
private subroutine uf_calculer_montant_detail (integer aitype)
private function boolean uf_verifier_condition_reg ()
private function string uf_calcul_montantregle ()
private subroutine uf_calculer_dt_1er_uf ()
private subroutine uf_fran_fixe ()
private subroutine uf_preparersupprimer (ref s_pass astpass)
private function string uf_plaf_adherent_renouvellement ()
private function string uf_plaf_adherent_survenance ()
private function string uf_plaf_adhesion_renouvellement ()
private function string uf_plaf_adhesion_survenance ()
private function string uf_gestioncptiareg ()
private function boolean uf_rf_603 ()
private subroutine uf_gestion_str2nul ()
private subroutine uf_gestion_plafond (integer aitype)
private subroutine uf_preparervalider_plafond (ref s_pass astpass)
private subroutine uf_plaf_ecrirepara (string asidtypplaf, string asidpara, string ascptver)
private function integer uf_preparervalider_commande ()
private subroutine uf_gestion_commandes ()
private subroutine uf_preparersupprimer_commande (integer aiidgti)
public subroutine uf_initialiser_objets (ref u_tagger aupiece, ref u_tagger aurefus, ref commandbutton acbtarif)
private function integer uf_controlergestion_sfr ()
private function boolean uf_rf_623 ()
private function boolean uf_rf_624 ()
private function string uf_plaf_nbsin_adhesion_survenance ()
private function string uf_plaf_nbsin_adherent_survenance ()
private function string uf_plaf_nbsin_adhesion_renouvellement ()
private function string uf_plaf_nbsin_adherent_renouvellement ()
private function boolean uf_rf_640 ()
private function boolean uf_rf_641 ()
private function boolean uf_rf_642 ()
private function string uf_plaf_adhesion_annee_civile ()
private function string uf_plaf_adherent_annee_civile ()
private function string uf_plaf_client_physique_annee_civile ()
private function string uf_plaf_produit_annee_civile ()
private function boolean uf_rf_652 ()
private function boolean uf_rf_694 (integer aldeb, integer alfin)
private function boolean uf_rf_695 (integer aldeb, integer alfin)
private function boolean uf_rf_696 (integer aldeb, integer alfin)
public function boolean uf_getautorisation (long aliddroit)
private subroutine uf_set_profilfacturation ()
private function integer uf_copierligne_inf2sup (string asswitch, long alligdwnivinf, string ascle, ref u_datawindow_detail adwsup, ref u_datawindow_detail adwinf)
private function integer uf_copierligne_sup2inf (boolean abdwnivinfreset, ref u_datawindow_detail adwsup, ref u_datawindow_detail adwinf)
private subroutine uf_gestion_detaildivers ()
private function integer uf_preparervalider_ongdivers ()
private subroutine uf_preparersupprimer_ongdivers (integer aiidgti)
private function long uf_zn_dteoppo ()
private function long uf_zn_altssui ()
private function long uf_zn_heuoppo ()
private function long uf_zn_altatt ()
public function long uf_zn_trt (ref s_pass astpass)
public subroutine uf_initialiser_dw_desc (ref u_datawindow_detail adw_lstinter, ref u_datawindow_detail adw_lstgti, ref u_datawindow_detail adw_lstdetail, ref u_datawindow_detail adw_lstcmdegti, ref u_datawindow_detail adw_lstcmdesin, ref u_datawindow_detail adw_divdetgti, ref u_datawindow_detail adw_divdetsin, ref u_datawindow adw_wgarsin, ref datawindow adw_norm[], ref datawindow adw_wdivsin)
private function long uf_zn_codmotssui ()
protected subroutine uf_controlergestion_pec (ref string aspos)
private function string uf_rechecherplafond_pec (string ascas)
private function boolean uf_rf_699 ()
private function boolean uf_rf_628 ()
private function string uf_plaf_nbsin_adherent_annee_civile ()
private function string uf_plaf_nbsin_adhesion_annee_civile ()
private function boolean uf_rf_604 (integer aldeb, integer alfin)
private function boolean uf_rf_643 ()
private function string uf_plaf_nbsin_adhesion ()
private function string uf_plaf_nbsin_adherent ()
private function boolean uf_rf_645 (integer aldeb, integer alfin)
private function string uf_plaf_nbgti_adhesion_par_surv ()
private function string uf_plaf_nbgti_adherent_par_surv ()
private function boolean uf_rf_1419 ()
private function boolean uf_rf_1420 ()
private function string uf_plaf_nbgti_pec_adherent_par_surv ()
private function string uf_plaf_nbgti_pec_adhesion_par_surv ()
private function boolean uf_rf_1450 ()
private function boolean uf_rf_1456 (long aldeb, long alfin)
private function boolean uf_rf_1459 ()
private function boolean uf_rf_1486 ()
private function boolean uf_rf_1493 ()
private function string uf_plaf_sin ()
private function string uf_plaf_nbsin_numport_annee_civile ()
private function string uf_plaf_nbgti_adherent ()
private function string uf_plaf_nbgti_adhesion ()
private function boolean uf_rf_1497 ()
private function string uf_plaf_nbsingti_adhesion_survenance ()
private function string uf_plaf_nbsingti_adhesion_renouvellement ()
private function string uf_plaf_nbsingti_adherent_survenance ()
private function string uf_plaf_nbsingti_adherent_renouvellement ()
public function string uf_plaf_refus (string astypplaf, string ascas)
private function string uf_plaf_adhesion_gti ()
private function string uf_plaf_adherent_gti ()
private function string uf_plaf_adhesion_survenance_ttegti ()
private function string uf_plaf_adherent_survenance_ttegti ()
private function string uf_plaf_adhesion_renouvellement_ttegti ()
private function string uf_plaf_adherent_renouvellement_ttegti ()
private function string uf_plaf_siren_adh_renouv_ttegti ()
private function boolean uf_rf_1676 ()
private function boolean uf_rf_1654 ()
private function string uf_plaf_adhesion_annee_civile_val_achat ()
private function string uf_plaf_adherent_annee_civile_val_achat ()
private function string uf_plaf_evt1397_regle_resil_adh ()
private function string uf_plaf_nbsin_adhesion_renouv_dte_surv ()
private function boolean uf_rf_1720 (integer aldeb, integer alfin)
public function boolean uf_rf_1731 ()
public function boolean uf_rf_650 ()
public function boolean uf_rf_654 ()
private function boolean uf_rf_1740 ()
private function boolean uf_rf_1744 ()
private function boolean uf_rf_1745 ()
private function string uf_plaf_nbsin_adhesion_survenance_resil (string ascas)
private function string uf_plaf_adhesion_renouvellement_proddms ()
private function string uf_plaf_nbsin_adhesion_renou_dte_surv_mp ()
private function string uf_plaf_adhesion_renouvellement_ttgti_mp ()
private function string uf_plaf_nbsin_numport_adhesion ()
private function boolean uf_rf_1810 ()
private function string uf_plaf_adhesion_annee_civile_tt_gti ()
private function string uf_plaf_nbsin_adhesion_surv_gliss_mp ()
private function boolean uf_rf_1335 ()
private function boolean uf_rf_1840 ()
private function boolean uf_rf_1837 ()
private function boolean uf_rf_882 ()
private function boolean uf_rf_223 ()
private function string uf_plaf_adhesion_renouv_typepers ()
private function string uf_plaf_adhesion_renouvellement_prgti_mp ()
private function string uf_plaf_nbgti_adhesion_renou_dte_surv_mp ()
private function boolean uf_rf_1676_2eme_declenchement ()
private function boolean uf_decoder_dp347 (long adcidgti, long adcidnatsin, long adcidmotif, string ascas)
private function boolean uf_rf_1898 ()
private function string uf_plaf_adhesion_survenance_gtidp351 ()
private function string uf_plaf_nbrglt_adhesion_par_surv ()
private function string uf_plaf_nbsinrgl_adhesi_renouv_splref611 ()
private function string uf_plaf_nbsin_adhesion_annee_civile_gti ()
private function string uf_plaf_adhesion_survenance_ttegti_mp ()
private subroutine uf_controlergestion_carrefour_carma ()
private function string uf_controlergestion_des_opticiens ()
private function string uf_plaf_krys_cdl_mt_spec_si_nb_sup_1_sin ()
private function boolean uf_rf_1165 ()
private function boolean uf_rf_1844 ()
end prototypes

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

Case 7					// TERMINER VALIDER	(Wf_TerminerValider)

Case 10					// SUPPRESSION			(Wf_PreparerSupprimer)
	Uf_PreparerSupprimer ( astPass )

End Choose



end subroutine

private subroutine uf_preparermodifier (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerModifier (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Préparation de la modification d'une garantie
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 CAG	 02/09/2004	  DCMP 040355 Bouton tarif papier accessible en validation également
//        JFF   07/05/2013 [PC938_ORANGE_V3]
//       JFF   09/05/2016 [DT215]
//*-----------------------------------------------------------------

Boolean	bSupprime
Long		lTot, lCpt

bSupprime = True
gProcessTempoOrangeV3 = FALSE // [PC938_ORANGE_V3]
ibPlaf748 = False  // [DT215]

String sBitMap

sBitMap = ""

/*------------------------------------------------------------------*/
/* On recopie la ligne du détail de la fenêtre parent dans          */
/* dw_wGarSin de GARANTIE.                                          */
/*------------------------------------------------------------------*/
idw_wGarSin.Uf_CopierLigne ()

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
/* Si la garantie a déjà été validé, on interdit la suppression.    */
/*------------------------------------------------------------------*/
If	idw_wGarSin.GetItemNumber ( 1, "CPT_VALIDE" ) > 0	Then
	bSupprime = False
End If

/*------------------------------------------------------------------*/
/* On gére les pieces et les refus en modification.                 */
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

/*------------------------------------------------------------------*/
/* On s'occupe des plafonds pour la garantie en modification.       */
/*------------------------------------------------------------------*/
Uf_Gestion_Plafond ( 2 )

/*------------------------------------------------------------------*/
/* On s'occupe des pièces et des motifs pour les détails.           */
/*------------------------------------------------------------------*/
Uf_Gestion_Piece_Detail ( 1 )

/*------------------------------------------------------------------*/
/* Gestion des commandes.                                           */
/*------------------------------------------------------------------*/
Uf_Gestion_Commandes ()
Uf_Gestion_DetailDivers ()

/*------------------------------------------------------------------*/
/* On s'occupe de la date d'opposition. Découpage des zones.        */
/*------------------------------------------------------------------*/
Uf_Cast_DteOppo ()

/*------------------------------------------------------------------*/
/* On gére les TabOrder uniquement en saisie.                       */
/*------------------------------------------------------------------*/
If	isTypeTrt = "S"	Then
	Uf_Tb_Oppo ()						// DTE_OPPO, MT_PROV, ALT_SSUI, COD_MOT_SSUI

/*------------------------------------------------------------------*/
/* On gére la dernière colonne.                                     */
/*------------------------------------------------------------------*/
	If	idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG" ) > 0 Then
		idw_wGarSin.ilDernCol = 22					// Zne ALT_BLOC
	Else
		If	idw_wGarSin.GetItemString ( 1, "ALT_SSUI" ) = "O"	Then
			idw_wGarSin.ilDernCol = 26					// Zne COD_MOT_SSUI
		Else
			idw_wGarSin.ilDernCol = 25					// Zne ALT_SSUI
		End If
	End If
End If

/*------------------------------------------------------------------*/
/* La modification de la date ou de l'heure d'opposition est gérée  */
/* en direct sur le ItemChanged des zones. Il est impossible de     */
/* trapper la mise à NULL de la date d'opposition sur ItemChanged.  */
/* Je fais donc ce test sur la Fonction Uf_ControlerSaisie ().      */
/*------------------------------------------------------------------*/
idDteOppo = idw_wGarSin.GetItemDate ( 1, "DTE_OPPO_DATE" )

If	iuoOng.Uf_RecupererOngletCourant () <> "01" Then
	iuoOng.Uf_ChangerOnglet ( "01" ) 
End If

astPass.bSupprime	= bSupprime		
astPass.bRetour	= True

/*------------------------------------------------------------------*/
/* Modification DBI 22/10/1998                                      */
/* On enlève le filtre pour que la Dw_detail puisse afficher le     */
/* libellé                                                          */
/* Le filtre est repositionné dans la fenêtre des détails.          */
/*------------------------------------------------------------------*/
idw_CodeCondition.SetFilter ( "" )
idw_CodeCondition.Filter ()

/*------------------------------------------------------------------*/
/* Le 28/11/2001.                                                   */
/* Modif DGA. DCMP 010375                                           */
/*------------------------------------------------------------------*/
/* #1 CAG : 02/09/2004                                              */
/*------------------------------------------------------------------*/
If	isTypeTrt = "S" Or isTypeTrt = "V"	Then
	If	idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) = 5	Then 
		iCbTarif.Visible = TRUE
	Else
		iCbTarif.Visible = FALSE
	End If
End If

end subroutine

private subroutine uf_initialiserfenetre ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_InitialiserFenetre (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Initialisation de la fenêtre des garanties
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

DataWindowChild							dwChild, dwChild1
u_gs_sp_sinistre_creer_lst_Detail	uoGsDetail

String sCol[ 5 ]

/*------------------------------------------------------------------*/
/* On récupére les DDDW qui ne changent jamais.                     */
/* Colonnes COD_MOT_SSUI, COD_DEC_MAC, COD_DEC_OPE, COD_ETAT.       */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On peut faire un ShareData pour toutes les DDDW avec idw_wSin.   */
/*------------------------------------------------------------------*/
idw_wSin.GetChild ( "COD_MOT_SSUI", dwChild )
idw_wGarSin.GetChild ( "COD_MOT_SSUI", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_wSin.GetChild ( "COD_DEC_MAC", dwChild )
idw_wGarSin.GetChild ( "COD_DEC_MAC", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_wSin.GetChild ( "COD_DEC_OPE", dwChild )
idw_wGarSin.GetChild ( "COD_DEC_OPE", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_wSin.GetChild ( "COD_ETAT", dwChild )
idw_wGarSin.GetChild ( "COD_ETAT", dwChild1 )
dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* On fait un ShareData pour le libellé de la garantie.             */
/*------------------------------------------------------------------*/
idw_wGarSin.iudwDetailSource.GetChild ( "ID_GTI", dwChild )
idw_wGarSin.GetChild ( "ID_GTI", dwChild1 )
dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* On fait un ShareData pour la désignation des interlocuteurs      */
/* pour les pièces et les refus.                                    */
/*------------------------------------------------------------------*/
iuoTagPiece.dw_Trt.GetChild ( "ID_I", dwChild )
idw_LstInter.ShareData ( dwChild )

iuoTagRefus.dw_Trt.GetChild ( "ID_I", dwChild )
idw_LstInter.ShareData ( dwChild )

/*------------------------------------------------------------------*/
/* On s'occupe des colonnes qui peuvent changer de couleur, en      */
/* fonction de la saisie.                                           */
/*------------------------------------------------------------------*/
sCol [ 1 ] = "DTE_OPPO_DATE"
sCol [ 2 ] = "HEU_OPPO"
sCol [ 3 ] = "COD_MOT_SSUI"
sCol [ 4 ] = "MT_PROV"
sCol [ 5 ] = "MT_DEDU_AREG"

idw_wGarSin.Uf_InitialiserCouleur ( sCol )

/*------------------------------------------------------------------*/
/* On va maintenant créer la DW pour les détails.                   */
/* Petite erreur sur les objets ancêtres, un SetTransObject va      */
/* être envoyé or il est inutile car cette DW sera populisée avec   */
/* des RowsCopy.                                                    */
/*------------------------------------------------------------------*/
uoGsDetail = Create u_Gs_Sp_Sinistre_Creer_Lst_Detail
uoGsDetail.Uf_Creer_Detail ( 2, idw_LstDetail, itrTrans )
Destroy uoGsDetail

/*------------------------------------------------------------------*/
/* Modification DBI le 22/10/1998                                   */
/* On fait un ShareData pour la liste des conditions.               */
/*------------------------------------------------------------------*/
idw_LstDetail.GetChild ( "ID_EVT", dwChild )
idw_CodeCondition.ShareData ( dwChild )

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

String sCol[ 9 ]

/*------------------------------------------------------------------*/
/* Cette fonction concerne toutes les zones.                        */
/*------------------------------------------------------------------*/
sCol [ 1 ] = "DTE_OPPO_DATE"
sCol [ 2 ] = "HEU_OPPO"
sCol [ 3 ] = "COD_MOT_SSUI"
sCol [ 4 ] = "ALT_SSUI"
sCol [ 5 ] = "ALT_ATT"
sCol [ 6 ] = "ALT_BLOC"
sCol [ 7 ] = "MT_DEDU_AREG"
sCol [ 8 ] = "MT_PROV"
sCol [ 9 ] = "MT_DEDU_AREG"

idw_wGarSin.Uf_Proteger ( sCol, "1" )

/*------------------------------------------------------------------*/
/* On positionne la gestion des pièces et des refus en mode         */
/* (C)onsultation.                                                  */
/*------------------------------------------------------------------*/
iuoTagPiece.Uf_Consulter ( True ) 
iuoTagRefus.Uf_Consulter ( True ) 

end subroutine

private subroutine uf_tb_oppo ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Tb_Oppo (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 17:35:30
//* Libellé			: 
//* Commentaires	: Gestion des TabOrder pour DTE_OPPO_DATE, HEU_OPPO, MT_PROV, ALT_SSUI, COD_MOT_SSUI, ALT_ATT
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Cette fonction concerne les zones suivantes :                    */
/* DTE_OPPO_DATE, HEU_OPPO, ALT_SSUI, COD_MOT_SSUI, MT_PROV,        */
/* MT_DEDU_AREG.                                                    */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modification DBI le 14/08/1998                                   */
/*                                                                  */
/* La zone alt_att doit également être inaccessible si la garantie  */
/* a été réglée car il s'agit d'un non sens qui en plus pose        */
/* problème lors du calcul du code état.                            */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modification DBI le 17/08/1999                                   */
/* La zone MT_DEDU_AREG est laissée saisissable même si règlement   */
/* effectué.                                                        */
/* Un contrôle Bloquant est toutefois effectué si cette zone est    */
/* saisie et qu'aucun détail n'est à régler.                        */
/*------------------------------------------------------------------*/
/* PHG-21/08/2006-Correction Bug sur Blocage ( alt_bloc )           */
/* saisissable en consultation.                                     */
/* La regle est : Le blocage n'est plus possible quand le code etat */
/* est à 600.                                                       */
/*------------------------------------------------------------------*/

Long lIdGti
Date dDteSurv

String sCol[] //PHG-21/08/2006 - Le tableau n'est plus fixé à 6, il est maintenant dynamique
Long lCodEtatGarantie//PHG-21/08/2006

sCol[ 1 ] = "DTE_OPPO_DATE"
sCol[ 2 ] = "HEU_OPPO"
sCol[ 3 ] = "ALT_SSUI"
sCol[ 4 ] = "COD_MOT_SSUI"
sCol[ 5 ] = "MT_PROV"
sCol[ 6 ] = "ALT_ATT"
/*------------------------------------------------------------------*/
/* Si la garantie posséde un montant de règlement, les zones ne     */
/* sont pas saisissables.                                           */
/*------------------------------------------------------------------*/
If	idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG" ) > 0 Then
	lCodEtatGarantie 	= idw_wGarSin.GetItemNumber ( 1, "COD_ETAT" )//PHG-21/08/2006
	If lCodEtatGarantie = 600 then
		sCol[7] = "ALT_BLOC"
	End If
	idw_wGarSin.Uf_Proteger ( sCol, "1" )
	idw_wGarSin.ilPremCol	= 22						// Zne ALT_BLOC
	idw_wGarSin.isNomCol		= "ALT_BLOC"
Else
/*------------------------------------------------------------------*/
/* Si la date de survenance du sinistre n'est pas renseignée, on    */
/* ne peut pas saisir la date d'opposition.                         */
/*------------------------------------------------------------------*/
	sCol[ 7 ] = "ALT_BLOC" //PHG-21/08/2006
	dDteSurv = idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )
	If	IsNull ( dDteSurv ) Or String ( dDteSurv ) = "01/01/1900" Then
		idw_wGarSin.Uf_Proteger ( { "DTE_OPPO_DATE", "HEU_OPPO" }, "1" )
//PHG-21/08/2006
//		idw_wGarSin.Uf_Proteger ( { "ALT_SSUI", "COD_MOT_SSUI", "MT_PROV", "ALT_ATT" }, "0" )
//		remplacé par : 
		idw_wGarSin.Uf_Proteger ( { "ALT_SSUI", "COD_MOT_SSUI", "MT_PROV", "ALT_ATT","ALT_BLOC" }, "0" )

		idw_wGarSin.ilPremCol	= 17						// Zne MT_PROV
		idw_wGarSin.isNomCol		= "MT_PROV"

	Else
		idw_wGarSin.Uf_Proteger ( sCol, "0" )

/*------------------------------------------------------------------*/
/* Modification DBI le 14/03/1998                                   */
/* La date d'oppo est la première colonne de la datawindow          */
/* uniquement s'il s'agit de la garantie UF ( 7 )                   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Le 27/05/1999.                                                   */
/* Modif DGA. Gestion des UF Téléphone Mobile.                      */
/*------------------------------------------------------------------*/
		lIdGti = idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
		If lIdGti = 7 Or lIdGti = 8 Then

			idw_wGarSin.ilPremCol	= 33						// Zne DTE_OPPO_DATE
			idw_wGarSin.isNomCol		= "DTE_OPPO_DATE"
		Else

			idw_wGarSin.ilPremCol	= 17						// Zne MT_PROV
			idw_wGarSin.isNomCol		= "MT_PROV"
		End If

	End If
End If

end subroutine

private subroutine uf_controlersaisie (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerSaisie (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Contrôle de saisie d'une garantie
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ 			PAR	Date		Modification
//* DCMP990023 JFF	21/05/99 ALT_INFO_PROV : Si cette zone est à OUI 'O' sur la table produit
//*														 et que la provision n'est saisie, une box apparaît afin de
//*														 savoir si oui ou non on continue.
//		FPI	14/12/2015	[CTL_INTER_PC_REFUS]
//*-----------------------------------------------------------------

String	sNouvelleLigne, sText, sPos, sOng, sAltAtt, sRech
String	sAltReclame, sHeure, sAltValide
Long 		lIdI, lCpt, lTotPiece, lIdPce, lChoixDw, lTotDetail, lCodEtat, lTotRefus, lLigPce, lLigRef
Time		tTime
Boolean bModifDteOppo
n_cst_string lnv_string // [SUISSE].LOT3
String sVal

sNouvelleLigne		= "~r~n"
sPos					= ""
sOng					= "01"
sText					= sNouvelleLigne

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

/*------------------------------------------------------------------*/
/* Si ALT_SSUI est positionné à OUI, il faut obligatoirement avoir  */
/* un COD_MOT_SSUI renseigné, mais différent de 0.                  */
/*------------------------------------------------------------------*/
If	idw_wGarSin.GetItemString ( 1, "ALT_SSUI" ) = "O" And  &
	( idw_wGarSin.GetItemNumber ( 1, "COD_MOT_SSUI" ) = 0 Or IsNull ( idw_wGarSin.GetItemNumber ( 1, "COD_MOT_SSUI" ) ) ) Then
	sPos = "COD_MOT_SSUI"
	sText = sText + " - Le motif du sans suite" + sNouvelleLigne
End If

/*------------------------------------------------------------------*/
/* Si l'heure d'opposition est positionnée mais que la date est     */
/* vide, il faut interdire la saisie.                               */
/*------------------------------------------------------------------*/
sHeure = idw_wGarSin.GetItemString ( 1, "HEU_OPPO" )
If	IsNull ( idw_wGarSin.GetItemDate ( 1, "DTE_OPPO_DATE" ) ) And ( sHeure <> "" Or Not IsNull ( sHeure ) ) Then
	sPos = "DTE_OPPO_DATE"
	sText = sText + " - La date d'opposition (Si l'heure est présente)" + sNouvelleLigne
Else
/*------------------------------------------------------------------*/
/* Dans le cas contraire, on positionne la date d'opposition au bon */
/* format.                                                          */
/*------------------------------------------------------------------*/
	If IsNull ( sHeure ) Or sHeure = "" Then
		tTime = 00:00:00
	Else
		tTime = Time ( Left ( sHeure, 2 ) + ":" + Right ( sHeure, 2 ) )
	End If
	idw_wGarSin.SetItem ( 1, "DTE_OPPO", DateTime ( idw_wGarSin.GetItemDate ( 1, "DTE_OPPO_DATE" ), tTime ) )
End If

/*------------------------------------------------------------------*/
/* La modification de la date ou de l'heure d'opposition est gérée  */
/* en direct sur le ItemChanged des zones. Il est impossible de     */
/* trapper la mise à NULL de la date d'opposition sur ItemChanged.  */
/* Je fais donc ce test maintenant. Si la date d'opposition est à   */
/* NULL alors qu'elle n'y était pas en entrant dans la grille,      */ 
/* c'est que le gestionnaire a supprimé le contenu de la zone.      */
/*------------------------------------------------------------------*/
If	IsNull ( idw_wGarSin.GetItemDate ( 1, "DTE_OPPO_DATE" ) ) And Not IsNull ( idDteOppo ) And sPos = "" Then
	idDteOppo = idw_wGarSin.GetItemDate ( 1, "DTE_OPPO_DATE" )
/*------------------------------------------------------------------*/
/* Si la date d'opposition bouge, il faut basculer certains         */
/* détails à NON CONTROLER.                                         */
/*------------------------------------------------------------------*/
	lTotDetail = idw_LstDetail.RowCount ()
	For	lCpt = 1	To lTotDetail
			lCodEtat		= idw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" )
			sAltValide	= idw_LstDetail.GetItemString ( lCpt, "ALT_VALIDE" )
			If	lCodEtat = 100 Or lCodEtat = 500 Or ( lCodEtat = 200 And sAltValide = "O" )	Then
				idw_LstDetail.SetItem ( lCpt, "COD_ETAT", 0 )
				idw_LstDetail.SetItem ( lCpt, "COD_DEC_MAC", 0 )
				idw_LstDetail.SetItem ( lCpt, "COD_DEC_OPE", 0 )
				bModifDteOppo 		= True
			End If
	Next
End If

/*------------------------------------------------------------------*/
/* Si la date vient de changer, on affiche un message               */
/* d'avertissement.                                                 */
/*------------------------------------------------------------------*/
If	bModifDteOppo	Then

	stMessage.sTitre		= "Contrôle de saisie de la garantie"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "WGAR210"

	f_Message ( stMessage )
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
/*------------------------------------------------------------------*/
/* Modification DBI le 14/08/1998                                   */
/*                                                                  */
/* Comme sur le détail, on vérifie que le gestionnaire ne réclame   */
/* pas des pièces et n'indique pas de refus en même temps. On gère  */
/* également la zone ALT_ATT.                                       */
/*------------------------------------------------------------------*/

If	sPos = "" Then
	lTotPiece	= iuoTagPiece.dw_Trt.RowCount ()
	sRech			= "ALT_RECLAME = 'O'"
	lLigPce		= iuoTagPiece.dw_Trt.Find ( sRech, 1, lTotPiece )

	lTotRefus	= iuoTagRefus.dw_Trt.RowCount ()
	sRech			= "ALT_OPE = 'O'"
	lLigRef		= iuoTagRefus.dw_Trt.Find ( sRech, 1, lTotRefus )

	If	lLigPce > 0 And lLigRef > 0 Then
		sPos = "ALT_ATT"

		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "WGAR220"
	End If

	If	sPos = "" Then
		sAltAtt = idw_wGarSin.GetItemString ( 1, "ALT_ATT" )
		If	sAltAtt = "O" And ( lLigPce > 0 Or lLigRef > 0 ) Then
			sPos = "ALT_ATT"

			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "WGAR230"
		End If

	End If
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
				sOng				= "02"
				sPos				= "ID_I"
				lChoixDw			= 1
				astPass.dwNorm[ 1 ] = iuoTagPiece.dw_Trt
				Exit
			End If
			
			// [CTL_INTER_PC_REFUS]
			lIdI = iuoTagPiece.dw_Trt.GetItemNumber(lCpt,"ID_I")
			If iuoTagPiece.dw_Trt.GetItemString(lCpt,"ALT_RECLAME") = "O" Then
				sVal=idw_lstinter.GetItemString( idw_lstinter.Find("ID_I = " + String(lIdI),1,idw_lstinter.RowCount( )), "COD_INTER")
				If sVal="L" or sVal="F" Then
					stMessage.bErreurG	= FALSE
					stMessage.sCode		= "WGAR411"
					
					sOng="02"
					sPos	= "ALT_ATT"
					exit
				End if
			End if
			// :[CTL_INTER_PC_REFUS]
	Next
End If

/*------------------------------------------------------------------*/
/* Affichage de la chaîne correspondant au message d'erreur         */
/*------------------------------------------------------------------*/
If	sPos <> "" Then

	stMessage.sTitre		= "Contrôle de saisie de la garantie"
	stMessage.Icon			= Information!
	
/*------------------------------------------------------------------*/
/* Modification DBI le 14/08/1998                                   */
/* sPos = ALT_ATT uniquement dans le cas                            */
/* ou le gestionnaire demande pièces et refus ou pièces et att ou   */
/* refus et att ( test effectué quelques lignes ci-dessus )         */
/* Dans ce cas, le message d'erreur GENE001 qui indique les         */
/* informations manquantes n'est pas prioritaire.                   */
/* La correction de l'erreur de saisie détectée va peut être        */
/* rendre caduque la zone manquante.                                */
/*------------------------------------------------------------------*/

	If sPos <> "ALT_ATT" Then

		stMessage.sVar[1] 	= sText
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "GENE001"
	End If

	f_Message ( stMessage )

	If	Not IsNull ( sOng ) And iuoOng.Uf_RecupererOngletCourant () <> sOng Then
		iuoOng.Uf_ChangerOnglet ( sOng )
	End If

End If

/*-------------------------------------------------------------------*/
/* DCMP990023, Le 21/05/99, Par JFF : Contrôle de la provision. si   */
/* la zone ALT_INFO_PROV sur la table produit est à 'O' (OUI), et    */
/* que la provision n'est pas renseignée, on demande une confirmation*/
/* pour continuer.																   */
/*-------------------------------------------------------------------*/
If sPos = "" And idw_produit.GetItemString ( 1, "ALT_INFO_PROV" ) = "O" And idw_wGarSin.GetItemDecimal ( 1, "MT_PROV" ) = 0 Then

	stMessage.bErreurG = FALSE
	stMessage.sCode	 = "WGAR280"
	stMessage.sTitre   = "SIMPA2 - Provision"
	stMessage.Icon	    = QUESTION!
	stMessage.Bouton   = YesNo!
	stMessage.svar[1]	 = lnv_string.of_GlobalReplace(stGlb.sMonnaiesymboledesire, "\", "") //[SUISSE].LOT3 : Gestion msg Err avec monnaie

	If F_Message ( stMessage )	= 2 Then
		sPos = "MT_PROV"	
	End If

End If

astPass.sTab [ 1 ] = sPos
astPass.lTab [ 1 ] = lChoixDw

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

private subroutine uf_controlergestion (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerGestion (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Contrôle de gestion d'une garantie
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1 PHG 	19/02/2008 [SUISSE].LOT3 Gestion Dynamique de la monnaie
//* #2 JFF  21/05/2008 [3SUISSE].DEL_RENONC
//* #3 JFF  09/10/2009 [DCMP090572]
//	    JFF  04/10/2012 [ITSM131178][PLAF_REF]
//     JFF  07/05/2013 [PC938_ORANGE_V3]
//     JFF  20/02/2014 [VDOC13754]
// 	 JFF  06/06/2014 [PC786-1_AUCHAN_GEM]  
//     JFF  10/11/2014 [PC801-5]
//		FPI	14/12/2015	[CTL_INTER_PC_REFUS]
//     JFF  15/12/2015 [DT191]
// 	JFF	03/02/2016 [DT191][V3]
// 	JFF	26/05/2016 [BUG_REFUS]
//	FPI	26/07/2016	[CTL_CRA_LAST_DATE] contrôle date de dernière utilisation renseignée si ctl IMEI OK
//    JFF   18/08/2016 [ITSM405947] sur demande de lisette suite bug mettre SOG ald BLC
//       JFF   22/08/2016 [DT244]
//    JFF  25/11/2016  [VDOC22217]
//       JFF   21/02/2107 [DT288]
//       JFF   04/05/2017 [DT288-1_LOT2]
//       JFF   01/08/2017 [DT288-1][MODIF_CHRISTINE]
//       JFF   15/02/2018 [VDOC25687]
//       JFF   19/03/2019 [PC151425-1][V4]
//       JFF   25/03/2019 [DT398]
//       JFF   24/05/2019 [DT391-1]
//       JFF   25/11/2021 [RS1383_FRANCHISE_30E]
//       JFF   22/01/2024 [RS6366_PCEREFUS]
//       JFF   30/01/2025 [MON311_SPL_PACI]
//       JFF   28/03/2025 [MCO1219]
//       JFF   20/06/2025 [MIG147_KRYS]
//       JFF   22/07/2025 [MIG165_BOUYGUES]
// 		JFF   10/09/2025 [20250910084954827][JFF][MIG165_BOUYGUES]
//*-----------------------------------------------------------------
String 		sPos, sVal, sMarque, sVal1, sSql, sFiltreOrig
Decimal {2} dcMtPlafAReg
Boolean		bSup, bAltBloc 
Long lTotwRefus, lCpt, lIdGti, lRow, lRow2, lDeb, lFin, lVal, lVal1, lVal2, lTotLigne, lLigPce, lRow912, lRowDS, lCptDetPro, lVal3
n_cst_string lnvPFCString
Boolean bBitMap, bMsg
int iIdi
DateTime dtDtePivotDT288-1_LOT2, dtCreeLeDos
String sTypApp, sFiltreInitialDwPceDet, sFiltreInitialDwPce
Boolean bBlocageGeoloc, bFin, BDp315
Long lCodePcePB, lCodePceDBL, lCodePce, lLigPcePB, lLigPceDBL, iCodEtat, lTotdwPce, lTotdwPceDet, lCptPce, lTotRefGti 

sPos						= ""
bBitMap					= False
bMsg						= False
bAltBloc = idw_wGarSin.GetItemString ( 1, "ALT_BLOC" ) = "O"


// #3 [DCMP090572]
lIdGti = idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
dtCreeLeDos = idw_WSin.GetItemDateTime ( 1, "CREE_LE")
sMarque = idw_WSin.GetItemString ( 1, "MARQ_PORT" ) 

lRow = idw_wdivSin.find ("UPPER(NOM_ZONE)='TYPE_APP'", 1, idw_wDivSin.rowCount()+1)
If lRow > 0 Then
	sTypApp = idw_wdivSin.GetItemString ( lRow, "VAL_CAR" )		
End If


/*------------------------------------------------------------------*/
/* On positionne la zone ALT_VALIDE de la garantie à OUI.           */
/*------------------------------------------------------------------*/
idw_wGarSin.SetItem ( 1, "ALT_VALIDE", "O" )

/*------------------------------------------------------------------*/
/* Si la garantie n'est pas bloquée, on déclenche la gestion des    */
/* refus.                                                           */
/*------------------------------------------------------------------*/
If	Not bAltBloc Then
	If	Not Uf_GestionRefus ()	Then	sPos = "MT_PROV"
End If

// [MCO1219]
If F_CLE_A_TRUE ( "MCO1219" ) Then
	This.uf_ControlerGestion_Carrefour_Carma ()
End If

// [MIG147_KRYS]
If F_CLE_A_TRUE ( "MIG147_KRYS" ) Then
	If Not bAltBloc and sPos = "" Then 
	 	sPos = This.uf_ControlerGestion_Des_Opticiens ()
	End If 
End If

/*------------------------------------------------------------------*/
/* A l'issue de la gestion des refus, il faut réinitialiser la      */
/* zone ID_I à NULL pour tous les refus non cochés. En effet si la  */
/* personne fait deux fois CTRL+VAL, on ne touche pas à la zone     */
/* ID_I. Cela n'a aucune importance pour la validation, puisqu'on   */
/* utilise les zones ALT_MAC et ALT_OPE, mais on peut éviter un     */
/* DELETE et un INSERT sur les REFUS.                               */
/*------------------------------------------------------------------*/
If	sPos = ""	Then
/*------------------------------------------------------------------*/
/* On détermine le code état de la garantie.                        */
/*------------------------------------------------------------------*/
	Uf_Determiner_Etat ( 1 )					// COD_DEC_MAC
	Uf_Determiner_Etat ( 2 )					// COD_DEC_OPE
	sPos = Uf_Determiner_Etat ( 3 )			// COD_ETAT
End If

/*------------------------------------------------------------------*/
/* On calcule maintenant le montant à régler pour la garantie.      */
/*------------------------------------------------------------------*/
If	sPos = ""	Then
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

// [PLAF_REF]
If sPos = "" Then
	If ibPlafRef Then
		Uf_Determiner_Etat ( 1 )			// COD_DEC_MAC
		Uf_Determiner_Etat ( 2 )			// COD_DEC_OPE
		sPos = Uf_Determiner_Etat ( 3 )	// COD_ETAT
	End If
End If

/*------------------------------------------------------------------*/
/* Modificatin DBI le 18/08/1998                                    */
/*                                                                  */
/* Calcul du nombre d'interlocuteurs à regler et test si <= 1 dans  */
/* le cas                                                           */
/* ou alt_plaf = 'O'                                                */
/*------------------------------------------------------------------*/

If sPos = "" Then
	sPos = Uf_GestionCptiAreg ()
End If

/*------------------------------------------------------------------*/
/* On vérifie que les motifs de refus posséde un interlocuteur      */
/* sinon on affiche un message d'avertissement non bloquant.        */
/* Uniquement dans le cas ou le dossier n'est pas bloqué.           */
/*------------------------------------------------------------------*/
If	idw_wGarSin.GetItemString ( 1, "ALT_BLOC" ) = "N" Then
	lTotwRefus = iuoTagRefus.dw_Trt.RowCount ()
	For	lCpt = 1 To lTotwRefus
			If	( iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_OPE" ) = "O" Or iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_MAC" ) = "O" ) Then
				bBitMap = True
				
				// [RS6366_PCEREFUS]
				If F_CLE_A_TRUE ( "RS6366_PCEREFUS" ) Then
					iCodEtat = idw_wGarSin.GetItemNumber ( 1, "COD_ETAT" )

					If	IsNull ( iuoTagRefus.dw_Trt.GetItemNumber ( lCpt, "ID_I" ) ) And iCodEtat = 200 Then
						// [VDOC13754]
						If Not This.uf_GetAutorisation ( 208 ) Then
							stMessage.sTitre		= "Contrôle de gestion d'une garantie"
							stMessage.Icon			= Information!
							stMessage.bErreurG	= FALSE
							stMessage.sCode		= "WGAR100"
		
							F_Message ( stMessage )
						End If 
						Exit
					End If						
				
				Else				
					If	IsNull ( iuoTagRefus.dw_Trt.GetItemNumber ( lCpt, "ID_I" ) ) Then
						// [VDOC13754]
						If Not This.uf_GetAutorisation ( 208 ) Then
							stMessage.sTitre		= "Contrôle de gestion d'une garantie"
							stMessage.Icon			= Information!
							stMessage.bErreurG	= FALSE
							stMessage.sCode		= "WGAR100"
		
							F_Message ( stMessage )
						End If 
						Exit
					End If
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
					sPos="MT_PROV"
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
/*	DCMP010222 : Message d'alerte pour certains réglements en Euros. */
/* (dans une base en Euros)													  */
/*------------------------------------------------------------------*/
If sPos = "" Then

	If stGlb.sMonnaieFormatDesire = "EURO" Then //#1 [SUISSE].LOT3 "E" est remplacé par "EURO"

		dcMtPlafAReg = idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) 
		bSup = False
		stMessage.sCode = "GENE060"
		stMessage.icon  = Exclamation!
		stMessage.bErreurG = False
		stMessage.bouton = yesno!

		// Pour quel produit ?
		CHOOSE CASE astPass.lTab [ 2 ]

			CASE 15400

				// quel Gti ?				
				CHOOSE CASE idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) 

					// Usage abusif( 5000 Euros )
					CASE 9

						If dcMtPlafAReg >= 5000 Then
							bSup = True
							stMessage.sVar[1] = String ( dcMtPlafAReg, "#,##0.00" )
						End If

				END CHOOSE


			END CHOOSE

			If bSup Then 
				If F_Message ( stMessage ) = 2 Then 		
					 sPos = "MT_PROV" 
				End If
			End If

			stMessage.bouton = Ok!
			stMessage.icon   = Information!

	End If

End If

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
If	sPos = ""	Then
	If	uf_ControlerGestion_Sfr () < 1	Then
		sPos = "MT_PROV"
	End If
End If

If sPos = "" Then This.Uf_ControlerGestion_PEC ( sPos )

// #2 [3SUISSE].DEL_RENONC 
// [PC801-5]  1749
If sPos = "" Then
	// #3 [DCMP090572]
	// [VDOC25687] <> 900
	If idw_wGarSin.GetItemString ( 1, "ALT_ATT" ) = "N" And &
     idw_wGarSin.GetItemNumber ( 1, "COD_ETAT" ) <> 900 And &
	  iuoTagPiece.dw_Trt.Find ( "ID_GTI = " + String ( lIdGti ) + " AND ALT_RECLAME = 'O'", 1, iuoTagPiece.dw_Trt.RowCount () ) <= 0 And &
	  idw_wPiece_Detail.Find ( "ID_GTI = " + String ( lIdGti ) + " AND ALT_RECLAME = 'O'", 1, idw_wPiece_Detail.RowCount () ) <= 0 And &
	  iuoTagRefus.dw_Trt.Find ( "ID_GTI = " + String ( lIdGti ) + " AND ID_MOTIF=1749", 1, iuoTagPiece.dw_Trt.RowCount () ) <= 0 &
	Then
	// #3 :[DCMP090572]	
		If This.Uf_Rf_628 () Then
			sPos = "MT_PROV"
			stMessage.sCode = "WGAR330"
			stMessage.icon  = Exclamation!
			stMessage.bErreurG = False
			stMessage.bouton = Ok!
			F_Message ( stMessage )
		End If			
	End If
End If
// :#2 [3SUISSE].DEL_RENONC 

// [DCMP070510] Message d'alerte si déclenchement de plafond pour le role 208
If sPos = "" Then
 If uf_getautorisation( 208 ) and ( idw_wgarsin.object.alt_plaf[1] = 'O' ) Then
		stMessage.sCode = "GENE157"
		stMessage.icon  = Information!
		stMessage.bErreurG = False
		stMessage.bouton = Ok!
		F_Message ( stMessage )
 End If		
End If

// [PC938_ORANGE_V3]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 239 )
If lDeb > 0 Then
	If gProcessTempoOrangeV3 Then

		// [DT191]
		// [DT191][V3]
		// [DT288]
		
		// [DT398]
		lRow912 = idw_LstCmdeGti.Find ( "ID_TYP_ART = 'PRS' AND COD_ETAT = 'CNV' AND ( INFO_SPB_FRN IN ( 1010, 912, 2116, 2143, 2110 ) OR ( INFO_SPB_FRN IN ( 982, 908 ) AND ID_FOUR = 'COR' ))", 1, idw_LstCmdeGti.Rowcount() ) 			
		
		lRow = idw_LstCmdeGti.Find ( "ID_TYP_ART = 'PST'", 1, idw_LstCmdeGti.Rowcount() ) 			
		
		If lRow912 > 0 And lRow > 0 Then

			idw_LstCmdeGti.DeleteRow ( lRow )
			
			sPos = "MT_PROV"
			stMessage.sCode = "WGAR412" // Interdit d'avoir 912 + PST
			stMessage.icon  = Information!
			stMessage.bErreurG = False
			stMessage.bouton = Ok!
			F_Message ( stMessage )
		Else 
			If lRow912 <= 0 And lRow > 0 Then
				gProcessTempoOrangeV3 = FALSE
				
				lRow2 = idw_LstCmdeGti.Find ( "ID_TYP_ART = 'PRS'", 1, idw_LstCmdeGti.Rowcount() ) 
				If lRow2 > 0 Then
					idw_LstCmdeGti.SetItem ( lRow2, "ADR_COD_CIV"		, idw_LstCmdeGti.GetItemString ( lRow, "ADR_COD_CIV" ) )
					idw_LstCmdeGti.SetItem ( lRow2, "ADR_NOM"			, idw_LstCmdeGti.GetItemString ( lRow, "ADR_NOM" ) )
					idw_LstCmdeGti.SetItem ( lRow2, "ADR_PRENOM"		, idw_LstCmdeGti.GetItemString ( lRow, "ADR_PRENOM" ) )
					idw_LstCmdeGti.SetItem ( lRow2, "ADR_LIVR1"			, idw_LstCmdeGti.GetItemString ( lRow, "ADR_LIVR1" ) )
					idw_LstCmdeGti.SetItem ( lRow2, "ADR_LIVR2"			, idw_LstCmdeGti.GetItemString ( lRow, "ADR_LIVR2" ) )
					idw_LstCmdeGti.SetItem ( lRow2, "ADR_LIVR_CPL"		, idw_LstCmdeGti.GetItemString ( lRow, "ADR_LIVR_CPL" ) )
					idw_LstCmdeGti.SetItem ( lRow2, "ADR_CP"				, idw_LstCmdeGti.GetItemString ( lRow, "ADR_CP" ) )
					idw_LstCmdeGti.SetItem ( lRow2, "ADR_VILLE"			, idw_LstCmdeGti.GetItemString ( lRow, "ADR_VILLE" ) )
				End If
				
			Else
				If lRow912 <= 0 And lRow <= 0 Then
					sPos = "MT_PROV"
					stMessage.sCode = "WGAR399"
					stMessage.icon  = Information!
					stMessage.bErreurG = False
					stMessage.bouton = Ok!
					F_Message ( stMessage )
				End If
			End If
		End If
	End If
	
End If
// [PC938_ORANGE_V3]

// [PC786-1_AUCHAN_GEM]  
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 140 )

If lDeb > 0 Then
	sVal=lnvPFCString.of_getkeyvalue( idw_DetPro.GetItemString(lDeb, "VAL_CAR"), "TYPE", ";")
	
	If sVal = "GEM" Then

		lRow = idw_wdivSin.find ("UPPER(NOM_ZONE)='TYPE_APP'", 1, idw_wDivSin.rowCount()+1)
		If lRow > 0 Then
			sVal = idw_wdivSin.GetItemString ( lRow, "VAL_CAR" )		
		End If

		// [MANTIS12054][PC786]
		lTotLigne = iuoTagPiece.dw_Trt.RowCount ()
		lLigPce = iuoTagPiece.dw_Trt.Find ( "ALT_RECLAME = 'O'", 1, lTotLigne )
		
		If lIdGti = 52 And lLigPce <= 0 Then
			Choose Case sVal 
				Case "CNG", "REF", "REG", "RFA", "CAV"
				
					lVal1 = idw_LstCmdeSin.find ( "ID_GTI = 15 AND ID_FOUR = 'AUC' AND ID_TYP_ART = 'CAF' AND COD_ETAT <> 'ANN'", 1, idw_LstCmdeSin.RowCount ())

					// [ITSM405947] // [DT244]
					// [DT244]
					lVal2 = idw_LstCmdeSin.find ( "ID_GTI = 15 AND ID_FOUR IN ( 'O2M', 'SOG', 'BLC') AND COD_ETAT <> 'ANN'", 1, idw_LstCmdeSin.RowCount ())											

					If lVal1 <= 0 and lVal2 <= 0 Then
						sPos = "MT_PROV"
						stMessage.sCode = "WGAR405"
						stMessage.icon  = Information!
						stMessage.bErreurG = False
						stMessage.bouton = Ok!
						F_Message ( stMessage )
					End If
				
				Case Else
					sPos = "MT_PROV"
					stMessage.sCode = "WGAR404"
					stMessage.icon  = Information!
					stMessage.bErreurG = False
					stMessage.bouton = Ok!
					F_Message ( stMessage )
			End Choose
		End If
		
				
		
	End If
End If

// [PC801-5]
// Volontairement, je n'exploite pas le sPos, on affiche juste un message d'info.
Uf_Plaf_NbSin_Adhesion_Survenance_Resil ( "CONTROLE" )

// [BUG_REFUS]
lRow = iuoTagRefus.dw_trt.Find ( "ID_GTI = " + String ( lIdGti ) + " AND ( ALT_OPE = 'O' OR ALT_MAC = 'O' )", 1, iuoTagRefus.dw_trt.RowCount()) + &
		 idw_wRefus_Detail.Find ( "ID_GTI = " + String ( lIdGti ) + " AND ( ALT_OPE = 'O' OR ALT_MAC = 'O' )", 1, idw_wRefus_Detail.RowCount()) 				
If lRow <= 0 And idw_wGarSin.GetItemNumber ( 1, "COD_ETAT" ) = 200 Then
	sPos = "MT_PROV"
	stMessage.sCode = "WGAR413"
	stMessage.icon  = Information!
	stMessage.bErreurG = False
	stMessage.bouton = Ok!
	F_Message ( stMessage )
End If

// [CTL_CRA_LAST_DATE] - contrôle date saisie si Ctl IMEI OK
if sPos="" Then

	lRow = idw_wdivSin.find ("UPPER(NOM_ZONE)='CRA_LAST_DTE'", 1, idw_wDivSin.rowCount()+1)
	If lRow > 0 Then
		if idw_wdivSin.GetItemString(lRow,"ALT_PROT")="N" and isnull(idw_wdivSin.GetItemDateTime(lRow,"VAL_DTE")) Then	// [PI056].20190926
			lRow = idw_wdivSin.find ("UPPER(NOM_ZONE)='CRA_SUIVI_IMEI'", 1, idw_wDivSin.rowCount()+1)
			if lRow > 0 Then
				if idw_wdivSin.GetItemNumber(lRow,"VAL_NBRE") = 2 Then
					sPos = "MT_PROV"
					stMessage.sCode = "WGAR415"
					stMessage.icon  = Information!
					stMessage.bErreurG = False
					stMessage.bouton = Ok!
					F_Message ( stMessage )
				end if
			End if
		End if
	End if
End if

			
// [DT288-1_LOT2]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 315)
BDp315 = lDeb > 0  // [MIG165_BOUYGUES]

// [MIG165_BOUYGUES]
If F_CLE_A_TRUE ( "MIG165_BOUYGUES" ) Then
	If lDeb <=0 Then
		F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 405 )
	End If 
End If 

If lDeb > 0 Then
	dtDtePivotDT288-1_LOT2 = DateTime ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "DTE_PIVOT_DT288_1_LOT2", ";") )

	// [DT288-1][MODIF_CHRISTINE]
	bBlocageGeoloc = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "BLOCAGE_GEOLOC", ";")  = "OUI"
	sVal = ""
	
	lRow = idw_wdivsin.Find("UPPER(NOM_ZONE)='GEOLOC_SIMPA2'", 1, idw_wdivsin.RowCount())
	If lRow > 0 Then
		sVal1 = idw_wdivsin.GetItemString (lRow, "VAL_CAR") 
		If IsNull ( sVal1 ) or Trim ( sVal1 ) = "" Then sVal1 = "N"
	End If

	lVal = idw_wGarSin.GetItemNumber ( 1, "COD_ETAT" ) 

	// Condition d'appel du WS revu avec Hélène par rapport à la NDC
	// [DT288-1][MODIF_CHRISTINE]
	// [MIG165_BOUYGUES] Or Not BDp315
	If ( ( sVal = "ORANGE_V3BIS" OR sVal = "ORANGE_V3TER" ) &
		  Or &
		  ( bBlocageGeoloc ) &
		) &
		And &
		sMarque = "APPLE" And & 
		sTypApp = "TEL" And &
		( dtCreeLeDos >= dtDtePivotDT288-1_LOT2 Or Not BDp315 ) And & 
		idw_LstCmdeSin.RowCount () <= 0 And &
		( lVal = 100 or lVal = 1 ) And &
		sVal1 = "O" &
		Then
		lRow = iuoTagPiece.dw_trt.Find ( "ID_PCE = 644", 1, iuoTagPiece.dw_trt.RowCount () )
		If lRow > 0 Then 
			iuoTagPiece.dw_trt.SetItem ( lRow, "ALT_RECLAME", "O")
			iuoTagPiece.dw_trt.SetItem ( lRow, "ID_I", 0 )				
			iuoOng.uf_ChangerBitmap ( "02", "K:\PB4OBJ\BMP\8_ALPCE.BMP" )
		End If

	End If
End If

// [PC171999]
lRow = idw_wDivSin.Find ( "Upper (NOM_ZONE) = 'PERSONNE_SIN'", 1, idw_wDivSin.RowCount () ) 
If lRow >0 Then 
	sVal = Upper ( idw_wDivSin.GetItemString ( lRow, "VAL_CAR" ) )
	If IsNull ( sVal ) Or Trim ( sVal ) = "" Then
		sPos = "MT_PROV"
		stMessage.sTitre		= "PC171999"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "WGAR417"
		F_Message ( stMessage )
	End If
End If


// [PC151425-1][V4]
// [PC151425-1]
/*
If F_CLE_A_TRUE ( "PC151425-1" ) Then
	
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 291)
	If lDeb > 0 Then
	
		// [PC151425-1]
		lCodePcePB = Long ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "CODE_PCE_PB", ";") )
		
		// [PC151425-1][V4]
		lCodePceDBL = Long ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "CODE_PCE_DBL", ";") )	
		
		lCodePce = Long ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "CODE_PCE", ";") )	

		lTotLigne = iuoTagPiece.dw_Trt.RowCount ()
	
		lLigPce = iuoTagPiece.dw_Trt.Find ( "ALT_RECLAME = 'O' AND ID_PCE = " + string ( lCodePce ), 1, lTotLigne )			
		lLigPcePB = iuoTagPiece.dw_Trt.Find ( "ALT_RECLAME = 'O' AND ID_PCE = " + string ( lCodePcePB ), 1, lTotLigne )			
		lLigPceDBL = iuoTagPiece.dw_Trt.Find ( "ALT_RECLAME = 'O' AND ID_PCE = " + string ( lCodePceDBL ) , 1, lTotLigne )			
		
		If ( lLigPce > 0 And lLigPcePB > 0 ) Then
			stMessage.sVar[1] = String ( lCodePce )
			stMessage.sVar[2] = String ( lCodePcePB )				
			stMessage.sCode		= "WGAR418"				
			bMsg = True
		End If 

		If ( lLigPce > 0 And lLigPceDBL > 0 ) And Not bMsg Then
			stMessage.sVar[1] = String ( lCodePceDBL )				
			stMessage.sVar[2] = String ( lCodePce )
			stMessage.sVar[3] = String ( lCodePceDBL )
			stMessage.sCode		= "WGAR419"							
			bMsg = True
		End If 

		If ( lLigPcePB > 0 And lLigPceDBL > 0 ) And Not bMsg Then
			stMessage.sVar[1] = String ( lCodePceDBL )				
			stMessage.sVar[2] = String ( lCodePcePB )
			stMessage.sVar[3] = String ( lCodePceDBL )			
			stMessage.sCode		= "WGAR419"										
			bMsg = True
		End If 

		If bMsg Then
			sPos = "MT_PROV"
			stMessage.sTitre		= "PC151425-1"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			F_Message ( stMessage )				
		End If 			
	End If 
End If 
*/

// [BUG_MARC]
If iuoTagRefus.dw_trt.Find ( "ID_GTI = " + String ( lIdGti ) + " AND ( ALT_OPE = 'O' OR ALT_MAC = 'O' )", 1, iuoTagRefus.dw_trt.Rowcount () ) <= 0 And &
	idw_wRefus_Detail.Find ( "ID_GTI = " + String ( lIdGti ) + " AND ( ALT_OPE = 'O' OR ALT_MAC = 'O' )", 1, idw_wRefus_Detail.Rowcount () ) <= 0 And &
	idw_wGarSin.GetItemNumber ( 1, "COD_ETAT" ) = 200 Then

/*	  
  sSql = "Exec sysadm.PS_S01_MAIL 'jff@spb.fr,fpinon@spb.eu', "  +&	  
  "'Etat refusé sans motif de refus sur la garantie " + string ( lIdGti) + ", sinistre " + String ( idw_wsin.GetItemNumber ( 1, "ID_SIN")) + "', " + &
  "'Etat refusé sans motif de refus sur la garantie " + string ( lIdGti) + ", sinistre " + String ( idw_wsin.GetItemNumber ( 1, "ID_SIN")) + ", " + stGlb.sCodOper + "', " + &
  "'Mouchard Refus PB'"		    + ", " + &
  "''"			 		 + ", " + &
  "null"   				 		 + ", " + &
  "null"   				 		 + ", " + &
  "null"   				 		 + ", " + &
  "null"   				 		 + ", " + &
  "null"

	F_execute ( sSql, SQLCA )

*/

	stMessage.sTitre		= "Etat Refusé sans motif"
	stMessage.Icon			= Exclamation!
	stMessage.sCode		= "WGAR432"	
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	F_Message ( stMessage )				


	sPos = "MT_PROV"

End If 	


// [RS1383_FRANCHISE_30E]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 360)
If lDeb > 0 Then
	sVal=lnvPFCString.of_getkeyvalue( idw_DetPro.GetItemString(lDeb, "VAL_CAR"), "ID_CAS", ";")
	If sVal = "RS1383_ALERTE_FRANCHE_30E" and lIdGti = 26 And idw_wGarSin.GetItemNumber ( 1, "COD_ETAT" ) = 500 Then
		bFin = False
		Do While Not bFin
			stMessage.sTitre		= "RS1383 : Alerte franchise"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= YESNO!
			stMessage.sCode		= "WGAR435"
			If F_Message ( stMessage ) = 1 Then bFin = TRUE
		Loop
	End If 
End If 

// [RS6366_PCEREFUS]
If F_CLE_A_TRUE ( "RS6366_PCEREFUS" ) Then
	iCodEtat = idw_wGarSin.GetItemNumber ( 1, "COD_ETAT" )
	
	IF iCodEtat = 200 Then
		
		sFiltreInitialDwPceDet	= 	idw_wPiece_Detail.Describe( "DataWindow.Table.Filter")
	
		If sFiltreInitialDwPceDet = "?" Then sFiltreInitialDwPceDet	= ""
		
		idw_wPiece_Detail.SetFilter ( "ID_GTI = " + String ( lIdGti ) )
		idw_wPiece_Detail.Filter ()
		lTotdwPceDet = idw_wPiece_Detail.RowCount ()

		lTotdwPce = iuoTagPiece.dw_Trt.Find ( "ALT_RECLAME = 'O'", 1, iuoTagPiece.dw_Trt.RowCount () ) 

		If lTotdwPce + lTotdwPceDet > 0 Then

			sPos = "MT_PROV"

			stMessage.sTitre		= "Décochez vos pièces"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "WGAR437"

			F_Message ( stMessage )
		End If 
	
		idw_wPiece_Detail.SetFilter ( sFiltreInitialDwPceDet )
		idw_wPiece_Detail.Filter ()			

	
	End If 
	
	IF iCodEtat = 100 Or iCodEtat = 550 Then
		
		lTotRefGti = iuoTagRefus.dw_Trt.Find ( "( ALT_OPE = 'O' OR ALT_MAC = 'O') AND NOT ISNULL ( ID_I) ", 1, iuoTagRefus.dw_Trt.RowCount () ) 

		If lTotRefGti > 0 Then

			sPos = "MT_PROV"

			stMessage.sTitre		= "Refus affecté aux interlocuteurs"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "WGAR438"

			F_Message ( stMessage )
		End If 
	
		idw_wPiece_Detail.SetFilter ( sFiltreInitialDwPceDet )
		idw_wPiece_Detail.Filter ()			

	
	End If 
	
	
End If

// [MON311_SPL_PACI]
// Plus utile
/*
If F_CLE_A_TRUE ( "MON311_SPL_PACI" ) Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 392 )
	If lDeb > 0 Then
		lVal = Long ( lnvPFCString.of_getkeyvalue( idw_DetPro.GetItemString(lDeb, "VAL_CAR"), "ID_GTI", ";"))
		lVal1 = Long ( lnvPFCString.of_getkeyvalue( idw_DetPro.GetItemString(lDeb, "VAL_CAR"), "MT_PLAF_TEMPO", ";"))
		dcMtPlafAReg = idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) 
		
//		lVal2 = idw_DivDetGti.Find ( "ID_GTI = " + String ( lVal ) + " AND ID_SPL <> 'AAA' AND NOT IS NULL ( ID_SPL )", 1, idw_DivDetGti.RowCount ()) 
		
		lVal2 = idw_DivDetGti.Find ( &
		"ID_GTI = " + String ( lVal ) + " AND " + &
		"UPPER ( NOM_ZONE ) = 'SOUPLESSE_1' " + " AND " + &
		"LEN ( VAL_CAR ) > 0 AND VAL_CAR <> 'AAA'" &
		, 1, idw_DivDetGti.RowCount ())
		
		If lIdGti = lVal And dcMtPlafAReg > lVal1 And lVal2 > 0 Then
			
			sPos = "MT_PROV"

			stMessage.sTitre		= "Souplesse PACIFICA dp/392"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "WGAR442"

			F_Message ( stMessage )			
			
		End IF 		
	End If 	
End If
*/

// [20250910084954827][JFF][MIG165_BOUYGUES]
If F_CLE_A_TRUE ( "MIG165_BOUYGUES" ) Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 405 )		
	If lDeb > 0 Then
		iCodEtat = idw_wGarSin.GetItemNumber ( 1, "COD_ETAT" )

		// La Gti (8) UFs : Régler si présence GTI 10 (Vol) avec AMU un détail PEC ( Rempl 178 RPC, RFO ou réglé evt 940)		
		If lIdGti = 8 Then
			Choose Case iCodEtat 
				Case 500, 550
					
					lVal1 = idw_LstCmdeSin.find ( "ID_GTI = 10 AND STATUS_GC = 178 AND COD_ETAT IN ( 'RFO', 'RPC' ) ", 1, idw_LstCmdeSin.RowCount ())
					lVal2 = idw_wDetail.find ( "ID_GTI = 10 And Id_Evt = 940 And Cod_etat in ( 500, 600 )", 1, idw_wDetail.RowCount ())
					
					If lVal1 <= 0 And lVal2 <= 0 Then
						sPos = "MT_PROV"
		
						stMessage.sTitre		= "Règlement UF conditionné au VOL"
						stMessage.Icon			= Information!
						stMessage.bErreurG	= FALSE
						stMessage.sCode		= "WGAR448"
						stMessage.sVar[1]		= "la garantie UF"
						F_Message ( stMessage )
					End If 
					
			End Choose 
		End IF 				
		
		// Carte SIM (10) : Régler si présence GTI 10 (Vol) avec AMU un détail PEC ( Rempl 178 RPC, RFO ou réglé evt 940)
		lVal1 = idw_LstDetail.find ( "Id_Evt = 924 And Cod_etat in ( 500 )", 1, idw_LstDetail.RowCount ())		
		
		If lVal1 > 0 Then
			lVal1 = idw_LstCmdeSin.find ( "ID_GTI = 10 AND STATUS_GC = 178 AND COD_ETAT IN ( 'RFO', 'RPC' ) ", 1, idw_LstCmdeSin.RowCount ())
			lVal2 = idw_LstDetail.find ( "ID_GTI = 10 And Id_Evt = 940 And Cod_etat in ( 500, 600 )", 1, idw_LstDetail.RowCount ())					

			If lVal1 <= 0 And lVal2 <= 0 Then
				sPos = "MT_PROV"

				stMessage.sTitre		= "Règlement Carte Sim conditionné au VOL"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.sCode		= "WGAR448"
				stMessage.sVar[1]		= "la carte SIM"
				F_Message ( stMessage )
			End If 
		End IF 
 
		// Accessoires : Régler si présence GTI 10, 11, 24 avec AMU (un détail PEC (Rempl (178)) ou Règlement du tel ou réparé)
		lVal1 = idw_LstDetail.find ( "Id_Evt = 971 And Cod_etat in ( 500 )", 1, idw_LstDetail.RowCount ())		
		
		If lVal1 > 0 Then
			lVal1 = idw_LstCmdeSin.find ( "ID_GTI = " + String ( lIdGti ) + " AND STATUS_GC in ( 178, 2 ) And COD_ETAT IN ( 'RFO', 'RPC' ) ", 1, idw_LstCmdeSin.RowCount ())
			lVal2 = idw_LstDetail.find  ( "ID_GTI = " + String ( lIdGti ) + " And Id_Evt = 940 And Cod_etat in ( 500, 600 )", 1, idw_LstDetail.RowCount ())					

			If lVal1 <= 0 And lVal2 <= 0 Then
				sPos = "MT_PROV"

				stMessage.sTitre		= "Règlement Accessoires conditionné"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.sCode		= "WGAR449 "
				stMessage.sVar[1]		= "d'accessoires"
				F_Message ( stMessage )
			End If 
		End IF 
		
	End If 
End IF 
	
astPass.sTab [ 1 ] = sPos

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
/* On est en insertion d'une garantie.                              */
/*------------------------------------------------------------------*/
Case 1
	iuoTagPiece.dw_Trt.Reset ()

/*------------------------------------------------------------------*/
/* On filtre la dw SOURCE (Table PIECE) avec ID_GTI et COD_TYP_PCE. */
/*------------------------------------------------------------------*/
	sFiltre = "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) ) + " AND COD_TYP_PCE = 'G'"

	iuoTagPiece.dw_Source.SetFilter ( sFiltre )
	iuoTagPiece.dw_Source.Filter ()
	iuoTagPiece.dw_Source.Sort ()
	lTotPiece = iuoTagPiece.dw_Source.RowCount ()

/*------------------------------------------------------------------*/
/* Les zones à insérer sont les suivantes :                         */
/* ID_SIN                                                           */
/* ID_GTI                                                           */
/* ID_DETAIL : On positionne -1                                     */
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
					If sIdEvtAuto <> "-1" And Not IsNull ( sIdEvtAuto ) And Trim ( sIdEvtAuto ) <> "" Then Continue

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
					Else
						sAltReclame = "N"
					End If
				Next
			End If
// #1 - FIN

			sLigne = sLigne 																								+ &
						String ( idw_wGarSin.GetItemNumber ( 1, "ID_SIN" ) )						+ sTab	+ &
						String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )						+ sTab	+ &
						"-1"																						+ sTab	+ &
						String ( iuoTagPiece.dw_Source.GetItemNumber ( lCpt, "ID_PCE" ) )		+ sTab	+ &
																													+ sTab	+ &
						iuoTagPiece.dw_Source.GetItemString ( lCpt, "ID_PARA" ) 					+ sTab	+ &
						String ( iuoTagPiece.dw_Source.GetItemNumber ( lCpt, "CPT_TRI" ) )	+ sTab	+ &
																													+ sTab	+ &
																													+ sTab	+ &
						stGLB.sCodOper																			+ sTab	+ &
						iuoTagPiece.dw_Source.GetItemString ( lCpt, "CPT_VER" ) 					+ sTab	+ &
/* #1 */				sAltReclame																				+ sTab	+ &
						iuoTagPiece.dw_Source.GetItemString ( lCpt, "LIB_CODE" ) 				+ sTab	+ &
						"N"																						+ sTab	+ &
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
/* On est en modification d'une garantie.                           */
/*------------------------------------------------------------------*/
Case 2

	iuoTagPiece.dw_Trt.Reset ()

/*------------------------------------------------------------------*/
/* On insére dans DW_TRT les piéces déjà réclamées. Pour cela on    */
/* filtre sur ID_GTI et ID_DETAIL.                                  */
/*------------------------------------------------------------------*/
	sFiltre = "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) ) + " AND ID_DETAIL = -1"

	idw_wPiece.SetFilter ( sFiltre )
	idw_wPiece.Filter ()
	idw_wPiece.Sort ()
	lTotPieceTag = idw_wPiece.RowCount ()

	If	lTotPieceTag > 0 Then
		sBitMap = "K:\PB4OBJ\BMP\8_ALPCE.BMP"
	Else
		sBitMap = ""
	End If
	iuoOng.Uf_ChangerBitmap ( "02", sBitMap )
	
	For	lCpt = 1 To lTotPieceTag
			idw_wPiece.SetItem ( lCpt, "ALT_RECLAME_AVANT", "O" )

/*------------------------------------------------------------------*/
/* Ne jamais faire un SetItem avec un GetItemNumber (Problème de    */
/* précision). Il faut passer dans une variable intermédiaire.      */
/*------------------------------------------------------------------*/
			lIdI = idw_wPiece.GetItemNumber ( lCpt, "ID_I" )
			idw_wPiece.SetItem ( lCpt, "ID_I_AVANT", 			lIdI )
	Next
	idw_wPiece.RowsCopy ( 1, lTotPieceTag, Primary!, iuoTagPiece.dw_Trt, 1, Primary! )

/*------------------------------------------------------------------*/
/* On enleve le filtre sur dw_wPiece.                               */
/*------------------------------------------------------------------*/
	sFiltre = ""
	idw_wPiece.SetFilter ( sFiltre )
	idw_wPiece.Filter ()
	idw_wPiece.Sort ()

/*------------------------------------------------------------------*/
/* On insére maintenant les pièces non réclamées. Pour cela on      */
/* filtre dw_Source sur ID_GTI et COD_TYP_PCE. On n'oublie pas de   */
/* filtrer les pièces déjà présentes dans dw_Trt.                   */
/*------------------------------------------------------------------*/
	For	lCpt = 1 To lTotPieceTag
			sFiltre = sFiltre + "ID_PCE <> " + String ( iuoTagPiece.dw_Trt.GetItemNumber ( lCpt, "ID_PCE" ) ) + " AND "
	Next

	sFiltre = sFiltre + "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) ) + " AND COD_TYP_PCE = 'G'"

	iuoTagPiece.dw_Source.SetFilter ( sFiltre )
	iuoTagPiece.dw_Source.Filter ()
	iuoTagPiece.dw_Source.Sort ()
	lTotPiece = iuoTagPiece.dw_Source.RowCount ()

/*------------------------------------------------------------------*/
/* Les zones à insérer sont les suivantes :                         */
/* ID_SIN                                                           */
/* ID_GTI                                                           */
/* ID_DETAIL : On positionne -1                                     */
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
			sLigne = sLigne 																								+ &
						String ( idw_wGarSin.GetItemNumber ( 1, "ID_SIN" ) )						+ sTab	+ &
						String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )						+ sTab	+ &
						"-1"																						+ sTab	+ &
						String ( iuoTagPiece.dw_Source.GetItemNumber ( lCpt, "ID_PCE" ) )		+ sTab	+ &
																													+ sTab	+ &
						iuoTagPiece.dw_Source.GetItemString ( lCpt, "ID_PARA" ) 					+ sTab	+ &
						String ( iuoTagPiece.dw_Source.GetItemNumber ( lCpt, "CPT_TRI" ) )	+ sTab	+ &
																													+ sTab	+ &
																													+ sTab	+ &
						stGLB.sCodOper																			+ sTab	+ &
						iuoTagPiece.dw_Source.GetItemString ( lCpt, "CPT_VER" ) 					+ sTab	+ &
						"N"																						+ sTab	+ &
						iuoTagPiece.dw_Source.GetItemString ( lCpt, "LIB_CODE" ) 				+ sTab	+ &
						"N"																						+ sTab	+ &
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
/* On est en insertion d'une garantie.                              */
/*------------------------------------------------------------------*/
Case 1
	iuoTagRefus.dw_Trt.Reset ()

/*------------------------------------------------------------------*/
/* On filtre la dw SOURCE (Table MOTIF) avec ID_GTI et COD_TYP_MOTIF*/
/*------------------------------------------------------------------*/
	sFiltre = "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) ) + " AND COD_TYP_MOTIF = 'G'"

	iuoTagRefus.dw_Source.SetFilter ( sFiltre )
	iuoTagRefus.dw_Source.Filter ()
	iuoTagRefus.dw_Source.Sort ()
	lTotMotif = iuoTagRefus.dw_Source.RowCount ()

/*------------------------------------------------------------------*/
/* Les zones à insérer sont les suivantes :                         */
/* ID_SIN                                                           */
/* ID_GTI                                                           */
/* ID_DETAIL : On positionne -1                                     */
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
						String ( idw_wGarSin.GetItemNumber ( 1, "ID_SIN" ) )						+ sTab	+ &
						String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )						+ sTab	+ &
						"-1"																						+ sTab	+ &
						String ( iuoTagRefus.dw_Source.GetItemNumber ( lCpt, "ID_MOTIF" ) )	+ sTab	+ &
						"N"																						+ sTab	+ &
						"N"																						+ sTab	+ &
																													+ sTab	+ &
						iuoTagRefus.dw_Source.GetItemString ( lCpt, "ID_PARA" ) 					+ sTab	+ &
						String ( iuoTagRefus.dw_Source.GetItemNumber ( lCpt, "CPT_TRI" ) )	+ sTab	+ &
																													+ sTab	+ &
																													+ sTab	+ &
						stGLB.sCodOper																			+ sTab	+ &
						iuoTagRefus.dw_Source.GetItemString ( lCpt, "CPT_VER" ) 					+ sTab	+ &
						iuoTagRefus.dw_Source.GetItemString ( lCpt, "LIB_CODE" ) 				+ sTab	+ &
						"N"																						+ sTab	+ &
						"N"																						+ sTab	+ &
																													+ sNew
	Next
	iuoTagRefus.dw_Trt.ImportString ( sLigne )

	sFiltre = ""

	iuoTagRefus.dw_Source.SetFilter ( sFiltre )
	iuoTagRefus.dw_Source.Filter ()
	iuoTagRefus.dw_Source.Sort ()

/*------------------------------------------------------------------*/
/* On est en modification d'une garantie.                           */
/*------------------------------------------------------------------*/
Case 2

	iuoTagRefus.dw_Trt.Reset ()

/*------------------------------------------------------------------*/
/* On insére dans DW_TRT les refus déjà positionnés. Pour cela on   */
/* filtre sur ID_GTI et ID_DETAIL.                                  */
/*------------------------------------------------------------------*/
	sFiltre = "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) ) + " AND ID_DETAIL = -1"

	idw_wRefus.SetFilter ( sFiltre )
	idw_wRefus.Filter ()
	idw_wRefus.Sort ()
	lTotRefusTag = idw_wRefus.RowCount ()

	If	lTotRefusTag > 0 Then
		sBitMap = "K:\PB4OBJ\BMP\8_REF.BMP"
	Else
		sBitMap = ""
	End If
	iuoOng.Uf_ChangerBitmap ( "03", sBitMap )
	
	For	lCpt = 1 To lTotRefusTag
			idw_wRefus.SetItem ( lCpt, "ALT_MAC_AVANT",	idw_wRefus.GetItemString ( lCpt, "ALT_MAC" ) )
			idw_wRefus.SetItem ( lCpt, "ALT_OPE_AVANT",	idw_wRefus.GetItemString ( lCpt, "ALT_OPE" ) )
/*------------------------------------------------------------------*/
/* Ne jamais faire un SetItem avec un GetItemNumber (Problème de    */
/* précision). Il faut passer dans une variable intermédiaire.      */
/*------------------------------------------------------------------*/
			lIdI = idw_wRefus.GetItemNumber ( lCpt, "ID_I" )
			idw_wRefus.SetItem ( lCpt, "ID_I_AVANT", 		lIdI )
	Next
	idw_wRefus.RowsCopy ( 1, lTotRefusTag, Primary!, iuoTagRefus.dw_Trt, 1, Primary! )

/*------------------------------------------------------------------*/
/* On enleve le filtre sur dw_wRefus.                               */
/*------------------------------------------------------------------*/
	sFiltre = ""
	idw_wRefus.SetFilter ( sFiltre )
	idw_wRefus.Filter ()
	idw_wRefus.Sort ()

/*------------------------------------------------------------------*/
/* On insére maintenant les refus non positionnés. Pour cela on     */
/* filtre dw_Source sur ID_GTI et COD_TYP_MOTIF. On n'oublie pas de */
/* filtrer les motifs déjà présents dans dw_Trt.                    */
/*------------------------------------------------------------------*/
	For	lCpt = 1 To lTotRefusTag
			sFiltre = sFiltre + "ID_MOTIF <> " + String ( iuoTagRefus.dw_Trt.GetItemNumber ( lCpt, "ID_MOTIF" ) ) + " AND "
	Next

	sFiltre = sFiltre + "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) ) + " AND COD_TYP_MOTIF = 'G'"

	iuoTagRefus.dw_Source.SetFilter ( sFiltre )
	iuoTagRefus.dw_Source.Filter ()
	iuoTagRefus.dw_Source.Sort ()
	lTotMotif = iuoTagRefus.dw_Source.RowCount ()

/*------------------------------------------------------------------*/
/* Les zones à insérer sont les suivantes :                         */
/* ID_SIN                                                           */
/* ID_GTI                                                           */
/* ID_DETAIL : On positionne -1                                     */
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
						String ( idw_wGarSin.GetItemNumber ( 1, "ID_SIN" ) )						+ sTab	+ &
						String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )						+ sTab	+ &
						"-1"																						+ sTab	+ &
						String ( iuoTagRefus.dw_Source.GetItemNumber ( lCpt, "ID_MOTIF" ) )	+ sTab	+ &
						"N"																						+ sTab	+ &
						"N"																						+ sTab	+ &
																													+ sTab	+ &
						iuoTagRefus.dw_Source.GetItemString ( lCpt, "ID_PARA" ) 					+ sTab	+ &
						String ( iuoTagRefus.dw_Source.GetItemNumber ( lCpt, "CPT_TRI" ) )	+ sTab	+ &
																													+ sTab	+ &
																													+ sTab	+ &
						stGLB.sCodOper																			+ sTab	+ &
						iuoTagRefus.dw_Source.GetItemString ( lCpt, "CPT_VER" ) 					+ sTab	+ &
						iuoTagRefus.dw_Source.GetItemString ( lCpt, "LIB_CODE" ) 				+ sTab	+ &
						"N"																						+ sTab	+ &
						"N"																						+ sTab	+ &
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

private subroutine uf_preparervalider_piece (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerValider_Piece (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Préparation de la validation d'une garantie (Niveau PIECE de la Garantie)
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long 			lTotwPiece, lCpt, lTotTagTrt, lTotSupp, lIdGti, lIdDetail
String 		sFiltre, sAltReclameAvant, sAltReclameApres
Long			lIdIAvant, lIdIApres

Boolean 		bModif, bMove

bModif		= False
bMove			= True

/*------------------------------------------------------------------*/
/* On s'occupe du transfert des pièces de la garantie.              */
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
		sFiltre	= "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) ) + " AND ID_DETAIL = -1"

		idw_wPiece.SetFilter ( sFiltre )
		idw_wPiece.Filter ()
		lTotwPiece = idw_wPiece.RowCount ()
/*------------------------------------------------------------------*/
/* Pour optimiser le DELETE, on va supprimer avec une seule         */
/* commande toutes les pièces de la garantie. (Détail = -1). Il     */
/* faut donc positionner une seule ligne dans le buffer Delete! et  */
/* faire un RowsDiscard sur toutes les autres.                      */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On va d'abord vérifier qu'il n'existe pas une ligne avec le      */
/* même ID_DETAIL dans le buffer Delete!. (Cas possible si la       */
/* personne fait 2 CTL-VAL).                                        */
/*------------------------------------------------------------------*/
		lTotSupp = idw_wPiece.DeletedCount ()

		For	lCpt = 1 To lTotSupp
				lIdGti		= idw_wPiece.GetItemNumber ( lCpt, "ID_GTI", 	Delete!, False )
				lIdDetail	= idw_wPiece.GetItemNumber ( lCpt, "ID_DETAIL", Delete!, False )

				If	lIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) And	&
					lIdDetail	= -1 Then
					bMove = False
					Exit
				End If
		Next
		If	bMove Then
			If	idw_wGarSin.iudwDetailSource.GetItemStatus ( idw_wGarSin.ilLigneDetailSource, 0, Primary! ) = NewModified!	Then
				idw_wPiece.RowsDiscard ( 1, lTotwPiece, Primary! )
			Else
				idw_wPiece.RowsDiscard ( 2, lTotwPiece, Primary! )
				idw_wPiece.RowsMove ( 1, 1, Primary!, idw_wPiece, 1, Delete! )
			End If
		Else
			idw_wPiece.RowsDiscard ( 1, lTotwPiece, Primary! )
		End If

		sFiltre = ""
		idw_wPiece.SetFilter ( sFiltre )
		idw_wPiece.Filter ()
	End If

/*------------------------------------------------------------------*/
/* On insére uniquement les pièces qui sont réclamées.              */
/*------------------------------------------------------------------*/
	sFiltre = "ALT_RECLAME = 'O'"

	iuoTagPiece.dw_Trt.SetFilter ( sFiltre )
	iuoTagPiece.dw_Trt.Filter ()
	lTotTagTrt = iuoTagPiece.dw_Trt.RowCount ()

	If	lTotTagTrt > 0 Then
		iuoTagPiece.dw_Trt.RowsMove ( 1, lTotTagTrt, Primary!, idw_wPiece, 1, Primary! )
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
//* Commentaires	: Préparation de la validation d'une garantie (Niveau REFUS de la Garantie)
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long 			lTotwRefus, lCpt, lTotTagTrt, lTotSupp, lIdGti, lIdDetail
String		sFiltre, sAltMacAvant, sAltOpeAvant, sAltMacApres, sAltOpeApres
Long			lIdIAvant, lIdIApres

Boolean 		bModif, bMove

bModif		= False
bMove			= True

/*------------------------------------------------------------------*/
/* On s'occupe du transfert des refus de la garantie.               */
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
		sFiltre	= "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) ) + " AND ID_DETAIL = -1"

		idw_wRefus.SetFilter ( sFiltre )
		idw_wRefus.Filter ()
		lTotwRefus = idw_wRefus.RowCount ()
/*------------------------------------------------------------------*/
/* Pour optimiser le DELETE, on va supprimer avec une seule         */
/* commande tous les refus de la garantie. (Détail = -1). Il faut   */
/* donc positionne une seule ligne dans le buffer Delete! et faire  */
/* un RowsDiscard sur toutes les autres.                            */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On va d'abord vérifier qu'il n'existe pas une ligne avec le      */
/* même ID_DETAIL dans le buffer Delete!. (Cas possible si la       */
/* personne fait 2 CTL-VAL).                                        */
/*------------------------------------------------------------------*/
		lTotSupp = idw_wRefus.DeletedCount ()

		For	lCpt = 1 To lTotSupp
				lIdGti		= idw_wRefus.GetItemNumber ( lCpt, "ID_GTI", 	Delete!, False )
				lIdDetail	= idw_wRefus.GetItemNumber ( lCpt, "ID_DETAIL", Delete!, False )

				If	lIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) And	&
					lIdDetail	= -1 Then
					bMove = False
					Exit
				End If
		Next
		If	bMove Then
			If	idw_wGarSin.iudwDetailSource.GetItemStatus ( idw_wGarSin.ilLigneDetailSource, 0, Primary! ) = NewModified!	Then
				idw_wRefus.RowsDiscard ( 1, lTotwRefus, Primary! )
			Else
				idw_wRefus.RowsDiscard ( 2, lTotwRefus, Primary! )
				idw_wRefus.RowsMove ( 1, 1, Primary!, idw_wRefus, 1, Delete! )
			End If
		Else
			idw_wRefus.RowsDiscard ( 1, lTotwRefus, Primary! )
		End If

		sFiltre = ""
		idw_wRefus.SetFilter ( sFiltre )
		idw_wRefus.Filter ()
	End If

/*------------------------------------------------------------------*/
/* On insére uniquement les refus qui sont cochés.                  */
/*------------------------------------------------------------------*/
	sFiltre = "ALT_MAC = 'O' Or ALT_OPE = 'O'"

	iuoTagRefus.dw_Trt.SetFilter ( sFiltre )
	iuoTagRefus.dw_Trt.Filter ()
	lTotTagTrt = iuoTagRefus.dw_Trt.RowCount ()

	If	lTotTagTrt > 0 Then
		iuoTagRefus.dw_Trt.RowsMove ( 1, lTotTagTrt, Primary!, idw_wRefus, 1, Primary! )
	End If

	sFiltre = ""
	iuoTagRefus.dw_Trt.SetFilter ( sFiltre )
	iuoTagRefus.dw_Trt.Filter ()
End If

end subroutine

private subroutine uf_preparervalider (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerValider (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Préparation de la validation d'une garantie
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On s'occupe du transfert des pièces de la garantie.              */
/*------------------------------------------------------------------*/
Uf_PreparerValider_Piece ( astPass )

/*------------------------------------------------------------------*/
/* On s'occupe du transfert des refus de la garantie.               */
/*------------------------------------------------------------------*/
Uf_PreparerValider_Refus ( astPass )

/*------------------------------------------------------------------*/
/* On s'occupe du transfert des plafonds de la garantie.            */
/*------------------------------------------------------------------*/
Uf_PreparerValider_Plafond ( astPass )

/*------------------------------------------------------------------*/
/* On s'occupe du transfert des Commandes.					           */
/*------------------------------------------------------------------*/
Uf_PreparerValider_Commande ( )
Uf_PreparerValider_OngDivers ()

/*------------------------------------------------------------------*/
/* On s'occupe du transfert des détails de la garantie.             */
/*------------------------------------------------------------------*/
Uf_PreparerValider_Detail ( astPass )

end subroutine

private subroutine uf_gestion_piece_detail (integer aitype);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Gestion_Piece_Detail (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 22/01/1998 16:31:31
//* Libellé			: 
//* Commentaires	: Gestion des pièces, refus, détails pour la garantie
//*
//* Arguments		: Integer		aiType			(Val)	Type d'action
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sFiltre
Long lCpt, lTotPieceTag, lTotRefusTag, lTotDetail, lIdI, lTotParaPlafond

Choose Case aiType
Case 0						// On est en insertion d'une garantie
	idw_wPiece_Detail.Reset ()
	idw_wRefus_Detail.Reset ()
	idw_wPPlafond_Detail.Reset ()
	idw_LstDetail.Reset ()
	idw_wDetailSupp.Reset ()

/*------------------------------------------------------------------*/
/* Le 16/07/1998. On ne fait pas de Retrieve sur l'objet            */
/* U_DataWindow_Detail qui permet de gérer les détails. Cela pose   */
/* le problème de l'armement de la variable ilLigneClick. Il faut   */
/* donc le faire manuellement.                                      */
/*------------------------------------------------------------------*/
	idw_LstDetail.ilLigneClick = 0

Case 1						// On est en modification d'une garantie
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* GESTION DES PIECES POUR LES DETAILS DE LA GARANTIE               */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On populise dans la DW de stockage (DW_WPIECE_DETAIL) la liste   */
/* des pièces réclamées pour tous les détails.                      */
/*------------------------------------------------------------------*/

	idw_wPiece_Detail.Reset ()
	sFiltre = "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) ) + " AND ID_DETAIL <> -1"

	idw_wPiece.SetFilter ( sFiltre )
	idw_wPiece.Filter ()
	idw_wPiece.Sort ()	
	lTotPieceTag = idw_wPiece.RowCount ()
	
	For	lCpt = 1 To lTotPieceTag
			idw_wPiece.SetItem ( lCpt, "ALT_RECLAME_AVANT",	"O" )
/*------------------------------------------------------------------*/
/* Ne jamais faire un SetItem avec un GetItemNumber (Problème de    */
/* précision). Il faut passer dans une variable intermédiaire.      */
/*------------------------------------------------------------------*/
			lIdI = idw_wPiece.GetItemNumber ( lCpt, "ID_I" )
			idw_wPiece.SetItem ( lCpt, "ID_I_AVANT", 			lIdI )
	Next
	idw_wPiece.RowsCopy ( 1, lTotPieceTag, Primary!, idw_wPiece_Detail, 1, Primary! )

/*------------------------------------------------------------------*/
/* On enleve le filtre sur dw_wPiece.                               */
/*------------------------------------------------------------------*/
	sFiltre = ""
	idw_wPiece.SetFilter ( sFiltre )
	idw_wPiece.Filter ()
	idw_wPiece.Sort ()

/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* GESTION DES REFUS POUR LES DETAILS DE LA GARANTIE                */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On populise dans la DW de stockage (DW_WREFUS_DETAIL) la liste   */
/* des refus réclamés pour tous les détails.                        */
/*------------------------------------------------------------------*/

	idw_wRefus_Detail.Reset ()
	sFiltre = "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) ) + " AND ID_DETAIL <> -1"

	idw_wRefus.SetFilter ( sFiltre )
	idw_wRefus.Filter ()
	idw_wRefus.Sort ()	
	lTotRefusTag = idw_wRefus.RowCount ()
	
	For	lCpt = 1 To lTotRefusTag
			idw_wRefus.SetItem ( lCpt, "ALT_MAC_AVANT",	idw_wRefus.GetItemString ( lCpt, "ALT_MAC" ) )
			idw_wRefus.SetItem ( lCpt, "ALT_OPE_AVANT",	idw_wRefus.GetItemString ( lCpt, "ALT_OPE" ) )
/*------------------------------------------------------------------*/
/* Ne jamais faire un SetItem avec un GetItemNumber (Problème de    */
/* précision). Il faut passer dans une variable intermédiaire.      */
/*------------------------------------------------------------------*/
			lIdI = idw_wRefus.GetItemNumber ( lCpt, "ID_I" )
			idw_wRefus.SetItem ( lCpt, "ID_I_AVANT",		lIdI )
	Next
	idw_wRefus.RowsCopy ( 1, lTotRefusTag, Primary!, idw_wRefus_Detail, 1, Primary! )

/*------------------------------------------------------------------*/
/* On enleve le filtre sur dw_wRefus.                               */
/*------------------------------------------------------------------*/
	sFiltre = ""
	idw_wRefus.SetFilter ( sFiltre )
	idw_wRefus.Filter ()
	idw_wRefus.Sort ()

/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* GESTION DES PLAFONDS POUR LES DETAILS DE LA GARANTIE             */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On populise dans la DW de stockage (DW_WPPLAFOND_DETAIL) la      */
/* liste des plafonds réclamés pour tous les détails.               */
/*------------------------------------------------------------------*/
	idw_wPPlafond_Detail.Reset ()
	sFiltre = "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) ) + " AND ID_DETAIL <> -1"

	idw_wParaPlafond.SetFilter ( sFiltre )
	idw_wParaPlafond.Filter ()
	idw_wParaPlafond.Sort ()	
	lTotParaPlafond = idw_wParaPlafond.RowCount ()
	
	idw_wParaPlafond.RowsCopy ( 1, lTotParaPlafond, Primary!, idw_wPPlafond_Detail, 1, Primary! )

/*------------------------------------------------------------------*/
/* On enleve le filtre sur dw_wParaPlafond.                         */
/*------------------------------------------------------------------*/
	sFiltre = ""
	idw_wParaPlafond.SetFilter ( sFiltre )
	idw_wParaPlafond.Filter ()
	idw_wParaPlafond.Sort ()

/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* GESTION DES DETAILS DE LA GARANTIE                               */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On populise dans la DW de stockage (DW_W_DETAIL) la liste        */
/* des détails.                                                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Important, il ne faut pas oublier de positionner le statut des   */
/* lignes récupérées à NotModified!.                                */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Les lignes sont positionnées à NewModified! et il faut les       */
/* mettre à NotModified! (Obligatoire pour la gestion du détail).   */
/* On passe donc les lignes d'abord en DataModified! puis en        */
/* NotModified!                                                     */
/*------------------------------------------------------------------*/
	idw_wDetailSupp.Reset ()
	idw_LstDetail.Reset ()
	sFiltre = "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) ) + " AND ID_DETAIL <> -1"

	idw_wDetail.SetFilter ( sFiltre )
	idw_wDetail.Filter ()
	idw_wDetail.Sort ()	
	lTotDetail = idw_wDetail.RowCount ()
	
	idw_wDetail.RowsCopy ( 1, lTotDetail, Primary!, idw_LstDetail, 1, Primary! )
	idw_LstDetail.Sort ()

/*------------------------------------------------------------------*/
/* On enleve le filtre sur dw_wDetail.                              */
/*------------------------------------------------------------------*/
	sFiltre = ""
	idw_wDetail.SetFilter ( sFiltre )
	idw_wDetail.Filter ()
	idw_wDetail.Sort ()

/*------------------------------------------------------------------*/
/* On positionne le statut des lignes de détail.                    */
/*------------------------------------------------------------------*/
	For	lCpt = 1 To lTotDetail
			idw_LstDetail.SetItemStatus ( lCpt, 0, Primary!, DataModified! )
			idw_LstDetail.SetItemStatus ( lCpt, 0, Primary!, NotModified! )
	Next

/*------------------------------------------------------------------*/
/* Le 16/07/1998. On ne fait pas de Retrieve sur l'objet            */
/* U_DataWindow_Detail qui permet de gérer les détails. Cela pose   */
/* le problème de l'armement de la variable ilLigneClick. Il faut   */
/* donc le faire manuellement.                                      */
/*------------------------------------------------------------------*/
	If	lTotDetail > 0 Then
		idw_LstDetail.ilLigneClick = 1
		idw_LstDetail.SetRow ( 1 )
		idw_LstDetail.ScrollToRow ( 1 )
	Else
		idw_LstDetail.ilLigneClick = 0
	End If

End Choose
end subroutine

private subroutine uf_preparerinserer (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerInserer (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Préparation de l'insertion d'une garantie
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//*	#1	JCA	12/01/2007		DCMP 050273 - Gestion du bitmap de l'onglet pièce fait dans Uf_GestionuTagger_Piece
//       JFF   07/05/2013 [PC938_ORANGE_V3]
//       JFF   09/05/2016 [DT215]
//*-----------------------------------------------------------------

Long lIdSin
ibPlafRef				= False // [PLAF_REF]

gProcessTempoOrangeV3 = FALSE // [PC938_ORANGE_V3]
ibPlaf748 = False  // [DT215]

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
lIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )

idw_wGarSin.SetItem ( 1, "ID_SIN", lIdSin )
idw_wGarSin.SetItem ( 1, "ID_GTI", astPass.lTab[1] )

/*------------------------------------------------------------------*/
/* On gére les pieces et les refus en insertion.                    */
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

/*------------------------------------------------------------------*/
/* On s'occupe des plafonds pour la garantie en insertion.          */
/*------------------------------------------------------------------*/
Uf_Gestion_Plafond ( 1 )

/*------------------------------------------------------------------*/
/* On s'occupe des pièces et des motifs pour les détails.           */
/*------------------------------------------------------------------*/
Uf_Gestion_Piece_Detail ( 0 )

/*------------------------------------------------------------------*/
/* Gestion des commandes.                                           */
/*------------------------------------------------------------------*/
Uf_Gestion_Commandes ()
Uf_Gestion_DetailDivers ()

/*------------------------------------------------------------------*/
/* On gére les TabOrder.                                            */
/*------------------------------------------------------------------*/
Uf_Tb_Oppo ()						// DTE_OPPO, MT_PROV, ALT_SSUI, COD_MOT_SSUI

/*------------------------------------------------------------------*/
/* On gére la dernière colonne.                                     */
/*------------------------------------------------------------------*/
idw_wGarSin.ilDernCol = 22					// Zne ALT_BLOC

/*------------------------------------------------------------------*/
/* On initialise le montant de MT_PROV avec le MT_CMT de            */
/* CODE_GARANTIE.                                                   */
/*------------------------------------------------------------------*/
idw_wGarSin.SetItem ( 1, "MT_PROV", astPass.lTab[2] )

/*------------------------------------------------------------------*/
/* On positionne la date d'opposition à NULL maintenant.            */
/*------------------------------------------------------------------*/
idDteOppo = stNul.dat

/*------------------------------------------------------------------*/
/* On initialise le Bitmap des onglets Piéces et Refus.             */
/*------------------------------------------------------------------*/
// #1 // iuoOng.Uf_ChangerBitmap ( "02", "" )
iuoOng.Uf_ChangerBitmap ( "03", "" )

If	iuoOng.Uf_RecupererOngletCourant () <> "01" Then
	iuoOng.Uf_ChangerOnglet ( "01" ) 
End If
		
astPass.bRetour = True

/*------------------------------------------------------------------*/
/* Modification DBI 22/10/1998                                      */
/* On enlève le filtre pour que la Dw_detail puisse afficher le     */
/* libellé                                                          */
/* Le filtre est repositionné dans la fenêtre des détails.          */
/*------------------------------------------------------------------*/
idw_CodeCondition.SetFilter ( "" )
idw_CodeCondition.Filter ()

/*------------------------------------------------------------------*/
/* Le 28/11/2001.                                                   */
/* Modif DGA. DCMP 010375                                           */
/*------------------------------------------------------------------*/
If	astPass.lTab[1] = 5	Then 
	iCbTarif.Visible = TRUE
Else
	iCbTarif.Visible = FALSE
End If


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
/* On vient de bloquer la garantie, on passe le COD_ETAT à 1.       */
/*------------------------------------------------------------------*/
If	idw_wGarSin.GetText () = "O" Then
	idw_wGarSin.SetItem ( 1, "COD_ETAT", 1 )
	idw_wGarSin.SetItem ( 1, "COD_DEC_MAC", 1 )
	idw_wGarSin.SetItem ( 1, "COD_DEC_OPE", 1 )
Else
/*------------------------------------------------------------------*/
/* On vient de débloquer le détail, on positionne le COD_ETAT à 0   */
/* (Non controlé). Il sera armé lors du contrôle de                 */
/* gestion.(Normalement!!).                                         */
/*------------------------------------------------------------------*/
	idw_wGarSin.SetItem ( 1, "COD_ETAT", 0 )
	idw_wGarSin.SetItem ( 1, "COD_DEC_MAC", 0 )
	idw_wGarSin.SetItem ( 1, "COD_DEC_OPE", 0 )
End If

///*------------------------------------------------------------------*/
///* On positionne les montants à 0. (MT_PLAF, MT_NPLAF, MT_FRAN).    */
///*------------------------------------------------------------------*/
//	idw_wDetailFF.SetItem ( 1, "MT_PLAF", 	0.00 )	
//	idw_wDetailFF.SetItem ( 1, "MT_NPLAF", 0.00 )	
//	idw_wDetailFF.SetItem ( 1, "MT_FRAN", 	0.00 )
//	idw_wDetailFF.SetItem ( 1, "ALT_PLAF", "N" )
//Else
///*------------------------------------------------------------------*/
///* On vient de débloquer le détail, on positionne le COD_ETAT à 0   */
///* (Non controlé). Il sera armé lors du contrôle de                 */
///* gestion.(Normalement!!).                                         */
///*------------------------------------------------------------------*/
//	idw_wDetailFF.SetItem ( 1, "COD_ETAT", 0 )
//	idw_wDetailFF.SetItem ( 1, "COD_DEC_MAC", 0 )
//	idw_wDetailFF.SetItem ( 1, "COD_DEC_OPE", 0 )
//End If
//
//
end subroutine

private subroutine uf_preparervalider_detail (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerValider_Detail (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Préparation de la validation d'un détail.
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long 				lTotDetail, lCptDetail, lCptSupp, lTotPieceDet, lTotRefusDet, lTotPlafondDet, lTotSupp
Long				lIdGti, lIdDetail, lCptCol, lTotCol

String			sFiltreNull, sFiltreDetail

Boolean			bMove

dwItemStatus	Status, StatuswDet

/*------------------------------------------------------------------*/
/* Si on est en insertion d'une garantie, on peut balancer tous     */
/* les détails danw W_DETAIL.                                       */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On peut aussi insérer toutes les piéces et les motifs des        */
/* détails. Ainsi que les plafonds bien sur.                        */
/*------------------------------------------------------------------*/
lTotDetail 		= idw_LstDetail.RowCount ()
sFiltreNull		= ""

If	idw_wGarSin.iudwDetailSource.GetItemStatus ( idw_wGarSin.ilLigneDetailSource, 0, Primary! ) = NewModified!	Or &
	astPass.bInsert = True Then

	sFiltreDetail = "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) ) + " AND ID_DETAIL <> -1"

	idw_wDetail.SetFilter ( sFiltreDetail )
	idw_wDetail.Filter ()
	lTotSupp = idw_wDetail.RowCount ()
	idw_wDetail.RowsDiscard ( 1, lTotSupp, Primary! )
	idw_wDetail.SetFilter ( sFiltreNull )
	idw_wDetail.Filter ()
	idw_LstDetail.RowsMove ( 1, lTotDetail, Primary!, idw_wDetail, 1, Primary! )

	idw_wPiece.SetFilter ( sFiltreDetail )
	idw_wPiece.Filter ()
	lTotSupp = idw_wPiece.RowCount ()
	idw_wPiece.RowsDiscard ( 1, lTotSupp, Primary! )
	idw_wPiece.SetFilter ( sFiltreNull )
	idw_wPiece.Filter ()
	lTotPieceDet	= idw_wPiece_Detail.RowCount ()
	idw_wPiece_Detail.RowsMove ( 1, lTotPieceDet, Primary!, idw_wPiece, 1, Primary! )	

	idw_wRefus.SetFilter ( sFiltreDetail )
	idw_wRefus.Filter ()
	lTotSupp = idw_wRefus.RowCount ()
	idw_wRefus.RowsDiscard ( 1, lTotSupp, Primary! )
	idw_wRefus.SetFilter ( sFiltreNull )
	idw_wRefus.Filter ()
	lTotRefusDet	= idw_wRefus_Detail.RowCount ()
	idw_wRefus_Detail.RowsMove ( 1, lTotRefusDet, Primary!, idw_wRefus, 1, Primary! )

	idw_wParaPlafond.SetFilter ( sFiltreDetail )
	idw_wParaPlafond.Filter ()
	lTotSupp = idw_wParaPlafond.RowCount ()
	idw_wParaPlafond.RowsDiscard ( 1, lTotSupp, Primary! )
	idw_wParaPlafond.SetFilter ( sFiltreNull )
	idw_wParaPlafond.Filter ()
	lTotPlafondDet	= idw_wPPlafond_Detail.RowCount ()
	idw_wPPlafond_Detail.RowsMove ( 1, lTotPlafondDet, Primary!, idw_wParaPlafond, 1, Primary! )

Else
/*------------------------------------------------------------------*/
/* On s'occupe d'abord des détails qui ont été supprimés. On va     */
/* optimiser les DELETE. La commande supprime automatiquement les   */
/* pièces et les refus. Il faut donc enlever les lignes de W_PIECE  */
/* et W_REFUS.                                                      */
/*------------------------------------------------------------------*/
	lTotSupp = idw_wDetailSupp.RowCount ()

	For	lCptDetail	= lTotSupp	To 1	Step -1
			sFiltreDetail = "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) ) + &
						 		 " AND ID_DETAIL = " + String ( idw_wDetailSupp.GetItemNumber ( lCptDetail, "ID_DETAIL" ) )


			idw_wDetail.SetFilter ( sFiltreDetail )
			idw_wDetail.Filter ()
			lTotDetail = idw_wDetail.RowCount ()

			If	lTotDetail > 0 Then
/*------------------------------------------------------------------*/
/* On casse toutes les pièces existantes de W_PIECE. Buffer         */
/* Primary et Delete                                                */
/*------------------------------------------------------------------*/
				idw_wPiece.SetFilter ( sFiltreDetail )
				idw_wPiece.Filter ()
				lTotPieceDet = idw_wPiece.RowCount ()
				idw_wPiece.RowsDiscard ( 1, lTotPieceDet, Primary! )

				idw_wPiece.SetFilter ( sFiltreNull )
				idw_wPiece.Filter ()

				lTotPieceDet = idw_wPiece.DeletedCount ()
				For	lCptSupp	= lTotPieceDet	To 1 Step -1
						lIdGti		= idw_wPiece.GetItemNumber ( lCptSupp, "ID_GTI", 		Delete!, False )
						lIdDetail	= idw_wPiece.GetItemNumber ( lCptSupp, "ID_DETAIL", 	Delete!, False )

						If	lIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) And &
							lIdDetail	= idw_wDetailSupp.GetItemNumber ( lCptDetail, "ID_DETAIL" )	Then

							idw_wPiece.RowsDiscard ( lCptSupp, lCptSupp, Delete! )
						End If
				Next

/*------------------------------------------------------------------*/
/* On casse tous les refus existants de W_REFUS. Buffer Primary!    */
/* et Delete                                                        */
/*------------------------------------------------------------------*/
				idw_wRefus.SetFilter ( sFiltreDetail )
				idw_wRefus.Filter ()
				lTotRefusDet = idw_wRefus.RowCount ()
				idw_wRefus.RowsDiscard ( 1, lTotRefusDet, Primary! )

				idw_wRefus.SetFilter ( sFiltreNull )
				idw_wRefus.Filter ()

				lTotRefusDet = idw_wRefus.DeletedCount ()
				For	lCptSupp	= lTotRefusDet	To 1 Step -1
						lIdGti		= idw_wRefus.GetItemNumber ( lCptSupp, "ID_GTI", 		Delete!, False )
						lIdDetail	= idw_wRefus.GetItemNumber ( lCptSupp, "ID_DETAIL", 	Delete!, False )

						If	lIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) And &
							lIdDetail	= idw_wDetailSupp.GetItemNumber ( lCptDetail, "ID_DETAIL" )	Then

							idw_wRefus.RowsDiscard ( lCptSupp, lCptSupp, Delete! )
						End If
				Next

/*------------------------------------------------------------------*/
/* On casse tous les plafonds existants de W_PARA_PLAFOND.          */
/* Buffer Primary! et Delete                                        */
/*------------------------------------------------------------------*/
				idw_wParaPlafond.SetFilter ( sFiltreDetail )
				idw_wParaPlafond.Filter ()
				lTotPlafondDet = idw_wParaPlafond.RowCount ()
				idw_wParaPlafond.RowsDiscard ( 1, lTotPlafondDet, Primary! )

				idw_wParaPlafond.SetFilter ( sFiltreNull )
				idw_wParaPlafond.Filter ()

				lTotPlafondDet = idw_wParaPlafond.DeletedCount ()
				For	lCptSupp	= lTotPlafondDet	To 1 Step -1
						lIdGti		= idw_wParaPlafond.GetItemNumber ( lCptSupp, "ID_GTI", 		Delete!, False )
						lIdDetail	= idw_wParaPlafond.GetItemNumber ( lCptSupp, "ID_DETAIL", 	Delete!, False )

						If	lIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) And &
							lIdDetail	= idw_wDetailSupp.GetItemNumber ( lCptDetail, "ID_DETAIL" )	Then

							idw_wParaPlafond.RowsDiscard ( lCptSupp, lCptSupp, Delete! )
						End If
				Next

/*------------------------------------------------------------------*/
/* On supprime maintenant le détail en passant la ligne             */
/* sélectionnée dans la buffer Delete.                              */
/*------------------------------------------------------------------*/
				idw_wDetail.RowsMove ( 1, 1, Primary!, idw_wDetail, 1, Delete! )

				idw_wDetail.SetFilter ( sFiltreNull )
				idw_wDetail.Filter ()
		End If
	Next

/*------------------------------------------------------------------*/
/* On est en modification d'une garantie. On va parcourir la liste  */
/* des détails.                                                     */
/*------------------------------------------------------------------*/
	lTotDetail	= idw_LstDetail.RowCount ()
	For	lCptDetail = lTotDetail To 1 Step -1
			bMove		= True
			Status	= idw_LstDetail.GetItemStatus ( lCptDetail, 0, Primary! )
/*------------------------------------------------------------------*/
/* Si le détail est en insertion, on insére la ligne dans           */
/* W_DETAIL. (Les pièces et les motifs vont suivre le même chemin,  */
/* envoi d'un INSERT).                                              */
/*------------------------------------------------------------------*/
			sFiltreDetail = "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) ) + &
						 		 " AND ID_DETAIL = " + String ( idw_LstDetail.GetItemNumber ( lCptDetail, "ID_DETAIL" ) )

			Choose Case Status
			Case	NewModified!
/*------------------------------------------------------------------*/
/* Les pièces du détail courant.                                    */
/*------------------------------------------------------------------*/
				idw_wPiece_Detail.SetFilter ( sFiltreDetail )
				idw_wPiece_Detail.Filter ()
				lTotPieceDet = idw_wPiece_Detail.RowCount ()

				idw_wPiece_Detail.RowsMove ( 1, lTotPieceDet, Primary!, idw_wPiece, 1, Primary! )

				idw_wPiece_Detail.SetFilter ( sFiltreNull )
				idw_wPiece_Detail.Filter ()

/*------------------------------------------------------------------*/
/* Les refus du détail courant.                                     */
/*------------------------------------------------------------------*/
				idw_wRefus_Detail.SetFilter ( sFiltreDetail )
				idw_wRefus_Detail.Filter ()
				lTotRefusDet = idw_wRefus_Detail.RowCount ()

				idw_wRefus_Detail.RowsMove ( 1, lTotRefusDet, Primary!, idw_wRefus, 1, Primary! )

				idw_wRefus_Detail.SetFilter ( sFiltreNull )
				idw_wRefus_Detail.Filter ()

/*------------------------------------------------------------------*/
/* Les plafonds du détail courant.                                  */
/*------------------------------------------------------------------*/
				idw_wPPlafond_Detail.SetFilter ( sFiltreDetail )
				idw_wPPlafond_Detail.Filter ()
				lTotPlafondDet = idw_wPPlafond_Detail.RowCount ()

				idw_wPPlafond_Detail.RowsMove ( 1, lTotPlafondDet, Primary!, idw_wParaPlafond, 1, Primary! )

				idw_wPPlafond_Detail.SetFilter ( sFiltreNull )
				idw_wPPlafond_Detail.Filter ()


/*------------------------------------------------------------------*/
/* Le Détail courant.                                               */
/*------------------------------------------------------------------*/
				idw_LstDetail.RowsMove ( lCptDetail, lCptDetail, Primary!, idw_wDetail, 1, Primary! )

			Case DataModified!
/*------------------------------------------------------------------*/
/* Le détail est en modification. on va supprimer la ligne de       */
/* W_DETAIL ( faire un RowsDiscard sur cette ligne ). Ensuite,      */
/* on recopie la ligne de W_LSTDETAIL dans W_DETAIL avec un statut  */
/* à Modified! pour envoyer un UPDATE.                              */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Les pièces du détail courant.                                    */
/*------------------------------------------------------------------*/
				If	idw_LstDetail.GetItemString ( lCptDetail, "ALT_MODIF_PIECE" ) = "O"	Then
					lTotSupp = idw_wPiece.DeletedCount ()
					For	lCptSupp = 1 To lTotSupp
							lIdGti		= idw_wPiece.GetItemNumber ( lCptSupp, "ID_GTI",		Delete!, False )
							lIdDetail	= idw_wPiece.GetItemNumber ( lCptSupp, "ID_DETAIL",	Delete!, False )

								If	lIdGti 		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) And	&
								lIdDetail	= idw_LstDetail.GetItemNumber ( lCptDetail, "ID_DETAIL" )	Then
								bMove = False
							End If
					Next

/*------------------------------------------------------------------*/
/* Suppression des pièces existantes pour de détail, avec           */
/* optimisation sur le DELETE.                                      */
/*------------------------------------------------------------------*/
					If	bMove Then
						idw_wPiece.SetFilter ( sFiltreDetail )
						idw_wPiece.Filter ()
						lTotPieceDet = idw_wPiece.RowCount ()
						idw_wPiece.RowsDiscard ( 2, lTotPieceDet, Primary! )
						idw_wPiece.RowsMove ( 1, 1, Primary!, idw_wPiece, 1, Delete! )

						idw_wPiece.SetFilter ( sFiltreNull )
						idw_wPiece.Filter ()
					Else
						idw_wPiece.SetFilter ( sFiltreDetail )
						idw_wPiece.Filter ()
						lTotPieceDet = idw_wPiece.RowCount ()
						idw_wPiece.RowsDiscard ( 1, lTotPieceDet, Primary! )

						idw_wPiece.SetFilter ( sFiltreNull )
						idw_wPiece.Filter ()
						bMove		= True
					End If
/*------------------------------------------------------------------*/
/* Insertion des nouvelles pièces dans W_PIECE.                     */
/*------------------------------------------------------------------*/
					idw_wPiece_Detail.SetFilter ( sFiltreDetail )
					idw_wPiece_Detail.Filter ()
					lTotPieceDet = idw_wPiece_Detail.RowCount ()
					idw_wPiece_Detail.RowsMove ( 1, lTotPieceDet, Primary!, idw_wPiece, 1, Primary! )

					idw_wPiece_Detail.SetFilter ( sFiltreNull )
					idw_wPiece_Detail.Filter ()
				End If

/*------------------------------------------------------------------*/
/* Les refus du détail courant.                                     */
/*------------------------------------------------------------------*/
				If	idw_LstDetail.GetItemString ( lCptDetail, "ALT_MODIF_REFUS" ) = "O"	Then
					lTotSupp = idw_wRefus.DeletedCount ()
					For	lCptSupp = 1 To lTotSupp
							lIdGti		= idw_wRefus.GetItemNumber ( lCptSupp, "ID_GTI",		Delete!, False )
							lIdDetail	= idw_wRefus.GetItemNumber ( lCptSupp, "ID_DETAIL",	Delete!, False )

							If	lIdGti 		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) And	&
								lIdDetail	= idw_LstDetail.GetItemNumber ( lCptDetail, "ID_DETAIL" )	Then
								bMove = False
							End If
					Next

/*------------------------------------------------------------------*/
/* Suppression des refus existants pour de détail, avec             */
/* optimisation sur le DELETE.                                      */
/*------------------------------------------------------------------*/
					If	bMove Then
						idw_wRefus.SetFilter ( sFiltreDetail )
						idw_wRefus.Filter ()
						lTotRefusDet = idw_wRefus.RowCount ()
						idw_wRefus.RowsDiscard ( 2, lTotRefusDet, Primary! )
						idw_wRefus.RowsMove ( 1, 1, Primary!, idw_wRefus, 1, Delete! )

						idw_wRefus.SetFilter ( sFiltreNull )
						idw_wRefus.Filter ()
					Else
						idw_wRefus.SetFilter ( sFiltreDetail )
						idw_wRefus.Filter ()
						lTotRefusDet = idw_wRefus.RowCount ()
						idw_wRefus.RowsDiscard ( 1, lTotRefusDet, Primary! )

						idw_wRefus.SetFilter ( sFiltreNull )
						idw_wRefus.Filter ()
						bMove		= True
					End If
/*------------------------------------------------------------------*/
/* Insertion des nouveaux refus dans W_REFUS.                       */
/*------------------------------------------------------------------*/
					idw_wRefus_Detail.SetFilter ( sFiltreDetail )
					idw_wRefus_Detail.Filter ()
					lTotRefusDet = idw_wRefus_Detail.RowCount ()
					idw_wRefus_Detail.RowsMove ( 1, lTotRefusDet, Primary!, idw_wRefus, 1, Primary! )

					idw_wRefus_Detail.SetFilter ( sFiltreNull )
					idw_wRefus_Detail.Filter ()
				End If

/*------------------------------------------------------------------*/
/* Les plafonds du détail courant.                                  */
/*------------------------------------------------------------------*/
				If	idw_LstDetail.GetItemString ( lCptDetail, "ALT_MODIF_PLAFOND" ) = "O"	Then
					lTotSupp = idw_wParaPlafond.DeletedCount ()
					For	lCptSupp = 1 To lTotSupp
							lIdGti		= idw_wParaPlafond.GetItemNumber ( lCptSupp, "ID_GTI",		Delete!, False )
							lIdDetail	= idw_wParaPlafond.GetItemNumber ( lCptSupp, "ID_DETAIL",	Delete!, False )

								If	lIdGti 		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) And	&
								lIdDetail		= idw_LstDetail.GetItemNumber ( lCptDetail, "ID_DETAIL" )	Then
								bMove = False
							End If
					Next

/*------------------------------------------------------------------*/
/* Suppression des plafonds existants pour ce détail, avec          */
/* optimisation sur le DELETE.                                      */
/*------------------------------------------------------------------*/
					If	bMove Then
						idw_wParaPlafond.SetFilter ( sFiltreDetail )
						idw_wParaPlafond.Filter ()
						lTotPlafondDet = idw_wParaPlafond.RowCount ()
						idw_wParaPlafond.RowsDiscard ( 2, lTotPlafondDet, Primary! )
						idw_wParaPlafond.RowsMove ( 1, 1, Primary!, idw_wParaPlafond, 1, Delete! )

						idw_wParaPlafond.SetFilter ( sFiltreNull )
						idw_wParaPlafond.Filter ()
					Else
						idw_wParaPlafond.SetFilter ( sFiltreDetail )
						idw_wParaPlafond.Filter ()
						lTotPlafondDet = idw_wParaPlafond.RowCount ()
						idw_wParaPlafond.RowsDiscard ( 1, lTotPlafondDet, Primary! )

						idw_wParaPlafond.SetFilter ( sFiltreNull )
						idw_wParaPlafond.Filter ()
						bMove		= True
					End If
/*------------------------------------------------------------------*/
/* Insertion des nouveaux plafonds dans W_PARA_PLAFOND.             */
/*------------------------------------------------------------------*/
					idw_wPPlafond_Detail.SetFilter ( sFiltreDetail )
					idw_wPPlafond_Detail.Filter ()
					lTotPlafondDet = idw_wPPlafond_Detail.RowCount ()
					idw_wPPlafond_Detail.RowsMove ( 1, lTotPlafondDet, Primary!, idw_wParaPlafond, 1, Primary! )

					idw_wPPlafond_Detail.SetFilter ( sFiltreNull )
					idw_wPPlafond_Detail.Filter ()
				End If

/*------------------------------------------------------------------*/
/* Le Détail courant.                                               */
/*------------------------------------------------------------------*/
				idw_wDetail.SetFilter ( sFiltreDetail )
				idw_wDetail.Filter ()

/*------------------------------------------------------------------*/
/* Le 25/08/1998                                                    */
/* Le gestionnaire insére un detail (CTL+VAL), valide la garantie,  */
/* puis revient modifier le détail (CTL+VAL), revalide la garantie  */
/* sans rien toucher d'autre.                                       */
/* Problème sur la validation. Normal car le détail passe en        */
/* DataModified!, or il n'a jamais été enregistré sur le moteur.    */
/*------------------------------------------------------------------*/
				StatuswDet	= idw_wDetail.GetItemStatus ( 1, 0, Primary! )

				If	StatuswDet = NewModified!	Then
					idw_wDetail.RowsDiscard ( 1, 1, Primary! )

					idw_LstDetail.RowsMove ( lCptDetail, lCptDetail, Primary!, idw_wDetail, 1, Primary! )
					idw_wDetail.SetItemStatus ( 1, 0, Primary!, NewModified! )

				Else

					idw_wDetail.RowsDiscard ( 1, 1, Primary! )

					idw_LstDetail.RowsMove ( lCptDetail, lCptDetail, Primary!, idw_wDetail, 1, Primary! )
					idw_wDetail.SetItemStatus ( 1, 0, Primary!, DataModified! )
/*------------------------------------------------------------------*/
/* !! Important, pour que l'update puisse partir, il faut que les   */
/* colonnes possédent le statut DataModified!.                      */
/*------------------------------------------------------------------*/
					lTotCol = Long ( idw_wDetail.Describe ( "DataWindow.Column.Count" ) )
					For	lCptCol = 1 To lTotCol
						idw_wDetail.SetItemStatus ( 1, lCptCol, Primary!, DataModified! )
					Next
				End If

				idw_wDetail.SetFilter ( sFiltreNull )
				idw_wDetail.Filter ()
				
			End Choose
	Next
End If


end subroutine

private subroutine uf_cast_dteoppo ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Cast_DteOppo (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libellé			: 
//* Commentaires	: On va décomposer la zone DTE_OPPO dans DTE_OPPO_DATE et HEU_OPPO
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

DateTime dtDteOppo
Time tHeure
String sHeure, sMinute

dtDteOppo	= idw_wGarSin.GetItemDateTime ( 1, "DTE_OPPO" )
If	IsNull ( dtDteOppo )	Then
	idw_wGarSin.SetItem ( 1, "DTE_OPPO_DATE", stNul.Dat )
	idw_wGarSin.SetItem ( 1, "HEU_OPPO", stNul.str )
Else
	sHeure = idw_wGarSin.GetItemString ( 1, "HEU_OPPO" )

	// JFF le 29/10
	If Len ( sHeure ) = 4 And IsNumber ( sHeure ) And Not IsNull ( sHeure ) And Long ( Left ( sHeure, 2 ) ) <= 23 And Long ( Right ( sHeure, 2 ) ) <= 59 Then
		idw_wGarSin.SetItem ( 1, "DTE_OPPO", DateTime ( Date ( dtDteOppo	), Time ( Left ( sHeure, 2 ) + ":" + Right ( sHeure, 2 ) + ":00" ) ) )
	End If

	// On lit de nouveau
	dtDteOppo	= idw_wGarSin.GetItemDateTime ( 1, "DTE_OPPO" )
	tHeure = Time ( dtDteOppo )

	If	tHeure = 00:00:00	And ( sHeure <> "0000" Or IsNull ( sHeure ) ) Then
		idw_wGarSin.SetItem ( 1, "HEU_OPPO", stNul.str )
	Else
		sHeure	= Left ( String ( tHeure ), 2 )
		sMinute	= Mid ( String ( tHeure ), 4, 2 )
		idw_wGarSin.SetItem ( 1, "HEU_OPPO", sHeure + sMinute )
	End If
	idw_wGarSin.SetItem ( 1, "DTE_OPPO_DATE", Date ( dtDteOppo ) )
End If





end subroutine

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
//* #1    CAG   04/02/2003   DCMP 030027 : Ajout du refus 623
//* #2 	 JFF	 03/03/2004   DCMP 040098 : Modification pour ORANGE Marketing.
//* #3	 JFF	 03/03/2004   DCMP 040098 : Déportation pour toutes les produits de téléphonie
//*								  de l'incohérence entre les dates d'achat/ouvlig/surv/adh, en refus sur la Gti.
//* #4    JFF   23/03/2005   DCMP 050010 : Seuil interv Gti
//* #5    JFF   24/03/2005   DCMP 040530 : Gestion refus 694 (option DP/33)
//* #6    JFF   27/04/2005   DCMP 050200 : Gestion refus 695 (option DP/34)
//* #7    JFF   27/04/2005   DCMP 050200 : Gestion refus 696 (option DP/35)
//* #8	 PHG	 25/01/2007   [CRAO_LOT2] : Désactivation Option 19 : report refus 640 sur Option 75
//* #9	 PHG	 22/01/2008   [DCMP070815]: Gestion Refus 699 (Option DP/63, id_code_num = 699 )
//* #10	 FPI	 30/03/2009	  [GOSPORT] : Ajout du refus 604
//* #11	FPI	09/02/2010		[DCMP100079] Ajout du refus 643
//* 		FPI	15/04/2010		[DCMP100284] Ajout du refus 645
//			FPI	10/08/2010		[DCMP100536] Modification gestion -DP20
//*			FPI	24/08/2010		[DCMP100570] Ajout des refus 1419 et 1420
//*			FPI	17/12/2010		[VDoc1306] Ajout du refus 1450
//*       JFF   27/01/2011    [PC414].[REFUS1456]
//*       JFF    17/05/2011  [VDOC3604]
//*       JFF    17/05/2011  [PC]
//*       JFF    22/06/2011  [PC545].[POINT].[262]
//*			FPI	07/09/2011	[PC387]
//*		 JFF    23/11/2011  [PC581].[POINT155][VDOC5984]
//*       JFF    26/11/2012  [PC877]
//*       JFF    07/05/2013  [PC938_ORANGE_V3]
// 			FPI	14/06/2013	[PC918]
//       JFF   17/06/2013 [PC946_ORANGE_OPPRO]
//        JFF      31/07/2013 [PC845_NOUVPLAF741]
//		FPI	02/10/2013	[PC958]
//    JFF    04/10/2013  [VDOC11880]
//       JFF   12/12/2013 [PC947&977]
//		FPI	31/03/2014	 [PC13362]
//		FPI	06/06/2014	[VDOC13767] Plafonds 746,747
//       JFF   30/07/2014 [PM234-4_V1]
//		FPI	05/08/2014	[DT031-2]
//       JFF   10/11/2014 [PC801-5]
//       JFF   12/12/2014 [PC13321]
//       JFF   09/09/2015 [DT162]
//       JFF   10/02/2015 [VDOC19467]
//       JFF   28/06/2016 [PC151549]
// 		JFF   22/06/2017 [DT288-1][M25522]
// 		JFF   04/10/2017 [VDOC24781]
// 		JFF   17/11/2017 [VDOC25099]
// 		JFF   09/02/2017 [VDOC25662]
//       JFF   06/11/2017 [PC171933-V6]
// 		JFF   22/02/2018 [VDOC25738]
//       JFF   16/10/2018 [PC171999]
//       JFF   24/06/2019 [PC192235]
//       JFF   02/09/2019 [DT424]
//       JFF   23/06/2020 [PC202553_SELECTRA]
//       JFF   08/09/2020 [PC202551_PLAF_759]
//       JFF   07/05/2013 [DT509]
// 		JFF   02/11/2020 [VDOC29786]
// 		JFF   06/10/2020 [PLAFOND762_ISM215077]
//       JFF   20/06/2025 [MIG147_KRYS]
//       JFF   22/07/2025 [MIG165_BOUYGUES]
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* La première chose à faire est de décocher tous les refus         */
/* machines précédents.                                             */
/*------------------------------------------------------------------*/

Long lCpt, lTotRefus, lDeb, lFin
String sValCar	// [DCMP100536] 
String sPos, sVal 
n_cst_string lnvPFCString
Boolean bExcluRefus1676 

lTotRefus = iuoTagRefus.dw_Trt.RowCount ()

For	lCpt = 1 To lTotRefus
		If	iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_MAC" ) = "O"	Then
			iuoTagRefus.dw_Trt.SetItem ( lCpt, "ALT_MAC", "N" )
		End If
Next

If	Not Uf_Rf_601 () Then	Return ( False )
If	Not Uf_Rf_602 () Then	Return ( False )
If	Not Uf_Rf_603 () Then	Return ( False )
If	Not Uf_Rf_611 () Then	Return ( False )
If	Not Uf_Rf_612 () Then	Return ( False )
If	Not Uf_Rf_613 () Then	Return ( False )
If	Not Uf_Rf_615 () Then	Return ( False )
If	Not Uf_Rf_621 () Then	Return ( False )
If	Not Uf_Rf_624 () Then	Return ( False )
If Not uf_rf_1654() Then	Return ( False ) // [PC918]

/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 1 )
If lDeb > 0 Then 
	If Not Uf_Rf_623 () Then	Return ( False )
End If

/*------------------------------------------------------------------*/
/* #8 [CRAO_LOT2] transferer ce refus sur Option 75 et non plus 19  */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 75 )
If lDeb > 0 Then 
	If Not Uf_Rf_640 () Then Return ( False )
End If

/*------------------------------------------------------------------*/
/* #3                                                               */
/* Option 20, déconnexion du déclenchement des trois refus 641,642  */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 20 )
// [DCMP100536]
sValCar=""
If lDeb > 0 Then sValCar=Trim(idw_DetPro.GetItemString(lDeb, "VAL_CAR"))

//If idw_Produit.GetItemNumber ( 1, "COD_TEL" ) > 0 And lDeb <= 0 Then 
If idw_Produit.GetItemNumber ( 1, "COD_TEL" ) > 0  Then 
	
	If sValCar = "642" or lDeb<=0 Then
		If Not Uf_Rf_641 () Then Return ( False )
	End if
	If sValCar = "641" or lDeb<=0 Then
		If Not Uf_Rf_642 () Then Return ( False )
	End if
	
/*	If Not Uf_Rf_641 () Then Return ( False )
	If Not Uf_Rf_642 () Then Return ( False )*/
	
// :// [DCMP100536]
End If

/*------------------------------------------------------------------*/
/* #11 [DCMP100079]                                                       */
/* Option 131,refus 643  */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 131 )
If idw_Produit.GetItemNumber ( 1, "COD_TEL" ) > 0 And lDeb > 0 Then 
	If Not Uf_Rf_643 () Then Return ( False )
End If


// #4
If	Not Uf_Rf_652 () Then  Return ( False )

/*------------------------------------------------------------------*/
/* #5                                                               */
/* Option 33, Gestion refus 694												  */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 33 )
If lDeb > 0 Then 
	If Not Uf_Rf_694 ( lDeb, lFin ) Then Return ( False )
End If

/*------------------------------------------------------------------*/
/* #6                                                               */
/* Option 34, Gestion refus 695												  */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 34 )
If lDeb > 0 Then 
	If Not Uf_Rf_695 ( lDeb, lFin ) Then Return ( False )
End If

/*------------------------------------------------------------------*/
/* #7                                                               */
/* Option 35, Gestion refus 696												  */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 35 )
If lDeb > 0 Then 
	If Not Uf_Rf_696 ( lDeb, lFin ) Then Return ( False )
End If

/*------------------------------------------------------------------*/
/* #10 [GOSPORT]																	  */
/* Option 111, Gestion refus 604												  */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 111 )
If lDeb > 0 Then 
	If Not Uf_Rf_604 ( lDeb, lFin ) Then Return ( False )
End If


// #9	[DCMP070815]
If	Not Uf_Rf_699 () Then Return ( False )

// [DCMP100284]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 135 )
If lDeb > 0 Then 
	If Not Uf_Rf_645 ( lDeb, lFin ) Then Return ( False )
End If

// [VDoc1306]
If	Not uf_rf_1450( )  Then Return (FALSE) 

// [PC414].[REFUS1456]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 160 )
If lDeb > 0 Then 
	If Not This.Uf_Rf_1456 ( lDeb, lFin ) Then Return ( False )
End If

// [VDoc1851]
If	Not uf_rf_1459( )  Then Return (FALSE)

// [VDOC3604]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 171 )
If lDeb > 0 Then 
	If Not This.Uf_Rf_1486 () Then Return ( False )
End If

// [PC545].[POINT].[262]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 174 )
If lDeb > 0 Then 
	If Not This.Uf_Rf_1493 () Then Return ( False )
End If

// [PC387]
If	Not uf_rf_1497( )  Then Return (FALSE)

// [PC938_ORANGE_V3]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 239 )

// [DT288-1][M25522]
If lDeb > 0 Then
	sVal = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "EXCLU_REFUS_1676", ";")
	bExcluRefus1676 = sVal = "OUI" 
End If

// [PC958]
If lDeb <= 0 Then F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 249 )
// :[PC958]

//	[DT031-2]
If lDeb <= 0 Then F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 263 )
// :[DT031-2]

// [KSV649_ORREUCARA]
If lDeb <= 0 Then F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 388 )

// [PMO268_MIG48]
If lDeb <= 0 Then F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 394 )


// [DT288-1][M25522] bExcluRefus1676 
If lDeb > 0 And Not bExcluRefus1676 Then 
	If Not This.Uf_Rf_1676 () Then Return ( False )
End If

// [DT424]
/*
If F_CLE_A_TRUE ( "DT424" ) Then
	If Not This.Uf_Rf_1676_2eme_Declenchement () Then Return ( False )
End If
*/

// [PC947&977]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 254 )
If lDeb > 0 Then 
	If Not This.Uf_Rf_1720 ( lDeb, lFin ) Then Return ( False )
End If
// [PC947&977]

//  [PC13362]
If	Not uf_rf_1731( )  Then Return (FALSE)

// [VDOC13767]
If	Not uf_rf_650( )  Then Return (FALSE)
If	Not uf_rf_654( )  Then Return (FALSE)
//:[VDOC13767]

// [PM234-4_V1]
If Not This.Uf_Rf_1740 () Then Return ( False )
If Not This.Uf_Rf_1744 () Then Return ( False )
If Not This.Uf_Rf_1745 () Then Return ( False )	
// [PM234-4_V1]

// [PC151549]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 302 )
If lDeb > 0 Then 
	If Not This.uf_rf_1810 () Then Return ( False )	
End If

//[PC171933-V6]
/*
If F_CLE_A_TRUE ( "PC171933_V6" ) Then
	If Not This.uf_rf_1840 () Then Return ( False )		
End If
*/

//[VDOC25662]
If Not This.uf_rf_1335 () Then Return ( False )		

//[VDOC25738]
If Not This.uf_rf_1837 () Then Return ( False )		
If Not This.uf_rf_882 () Then Return ( False )		

// [PC171999]
If Not This.uf_rf_223 () Then Return ( False )			


// [PC202553_SELECTRA]
If Not This.uf_rf_1898 () Then Return ( False )				


// [MIG165_BOUYGUES]
If F_CLE_A_TRUE ( "MIG165_BOUYGUES" ) Then
	If Not This.uf_rf_1165 () Then Return ( False )				
	If Not This.uf_rf_1844 () Then Return ( False )					
End If 


// [PLAF_REF]
If sPos = "" Then sPos = Uf_Plaf_Sin ()
If sPos = "" Then sPos = Uf_Plaf_Adhesion_Survenance ()
If sPos = "" Then sPos = Uf_Plaf_Adherent_Survenance ()
If sPos = "" Then sPos = Uf_Plaf_Adhesion_Renouvellement ()

// [PC13321]
If sPos = "" Then sPos = Uf_Plaf_Adhesion_Renouvellement_proddms ()

If sPos = "" Then sPos = Uf_Plaf_Adherent_Renouvellement ()
If sPos = "" Then sPos = Uf_Plaf_NbSin_Adhesion_Survenance ()
If sPos = "" Then sPos = Uf_Plaf_NbSin_Adherent_Survenance ()
If sPos = "" Then sPos = Uf_Plaf_NbSin_Adhesion_Renouvellement ()
If sPos = "" Then sPos = Uf_Plaf_NbSin_Adherent_Renouvellement ()
If sPos = "" Then sPos = Uf_Plaf_Adhesion_Annee_Civile ()
If sPos = "" Then sPos = Uf_Plaf_Adherent_Annee_Civile ()

// [VDOC24781]
If sPos = "" Then sPos = Uf_Plaf_Adhesion_Annee_Civile_tt_gti ()

// [VDOC11880]
If sPos = "" Then sPos = Uf_Plaf_NbSin_Adhesion_Renouv_dte_surv ()

// [PC845_NOUVPLAF]
If sPos = ""	Then sPos = Uf_Plaf_Adhesion_Annee_Civile_val_achat ()
If sPos = ""	Then sPos = Uf_Plaf_Adherent_Annee_Civile_val_achat ()

// [PC845_NOUVPLAF741]
If sPos = ""	Then sPos = This.Uf_Plaf_Evt1397_regle_resil_adh ()

If sPos = "" Then sPos = Uf_Plaf_NbSin_Adhesion_Annee_Civile ()
If sPos = "" Then sPos = Uf_Plaf_NbSin_Adherent_Annee_Civile ()
If sPos = "" Then sPos = uf_Plaf_Client_Physique_Annee_Civile ()
If sPos = "" Then sPos = uf_Plaf_Produit_Annee_Civile ()
If sPos = "" Then sPos = Uf_Plaf_NbSin_Adhesion ()
If sPos = "" Then sPos = Uf_Plaf_NbSin_Adherent ()
If sPos = "" Then sPos = Uf_Plaf_NbGti_adhesion_par_surv( )
If sPos = "" Then sPos = Uf_Plaf_NbGti_adherent_par_surv( )
If sPos = "" Then sPos = Uf_Plaf_NbGti_Pec_adhesion_par_surv( )
If sPos = "" Then sPos = Uf_Plaf_NbGti_Pec_adherent_par_surv( )
If sPos = "" Then sPos = Uf_Plaf_NbSin_numport_annee_civile( )
If sPos = "" Then sPos = Uf_Plaf_NbGti_adhesion ( )
If sPos = "" Then sPos = Uf_Plaf_NbGti_adherent ( )

// [PC581].[POINT155][VDOC5984]
If sPos = "" Then sPos = Uf_Plaf_NbSinGti_Adhesion_Survenance ()
If sPos = "" Then sPos = Uf_Plaf_NbSinGti_Adherent_Survenance ()
If sPos = "" Then sPos = Uf_Plaf_NbSinGti_Adhesion_Renouvellement ()
If sPos = "" Then sPos = Uf_Plaf_NbSinGti_Adherent_Renouvellement ()

// [VDOC7410]
If sPos = "" Then sPos = uf_plaf_adherent_gti ()
If sPos = "" Then sPos = uf_plaf_adhesion_gti ()
// [VDOC7410]	

// [PC877]
If sPos = "" Then sPos = Uf_Plaf_Adhesion_Survenance_TteGti ()
If sPos = "" Then sPos = Uf_Plaf_Adherent_Survenance_TteGti ()
If sPos = "" Then sPos = Uf_Plaf_Adhesion_Renouvellement_TteGti ()
If sPos = "" Then sPos = Uf_Plaf_Adherent_Renouvellement_TteGti ()
If sPos = "" Then sPos = Uf_Plaf_Siren_Adh_Renouv_TteGti	()
// [PC877]

// [PC801-5]
If sPos = "" Then sPos = Uf_Plaf_NbSin_Adhesion_Survenance_Resil ( "REFUS" )

// [DT162]
If sPos = "" Then sPos = Uf_Plaf_Adhesion_Renouvellement_TtGti_mp ()
If sPos = "" Then sPos = Uf_Plaf_NbSin_Adhesion_Renou_dte_surv_mp ()

// [PC192235]
If sPos = "" Then sPos = Uf_Plaf_Adhesion_Renouvellement_PrGti_mp ()
If sPos = "" Then sPos = Uf_Plaf_NbGti_Adhesion_Renou_dte_surv_mp ()

// [VDOC25099]
If sPos = "" Then sPos = Uf_Plaf_NbSin_Adhesion_Surv_gliss_mp () 

// [VDOC19467]
If sPos = "" Then sPos = uf_plaf_nbsin_numport_adhesion ()

// [PC171999]
If sPos = "" Then sPos = Uf_Plaf_Adhesion_Renouv_TypePers ()

// [PC202551_PLAF_759]
If sPos = "" Then sPos = Uf_Plaf_Adhesion_Survenance_GtiDp351 ()	

// [DT509]
If sPos = "" Then sPos = Uf_Plaf_NbSinRgl_Adhesi_Renouv_splref611 ()

// [VDOC29786]
If sPos = "" Then sPos = Uf_Plaf_NbSin_Adhesion_annee_civile_gti ()

// [PLAFOND762_ISM215077]
If sPos = "" Then sPos = uf_plaf_adhesion_survenance_ttegti_mp ()

// [MIG147_KRYS]
If F_CLE_A_TRUE ( "MIG147_KRYS" ) Then
	If sPos = "" Then sPos = Uf_Plaf_KRYS_CDL_MT_SPEC_SI_NB_SUP_1_SIN ()	
End If

If sPos <> "" Then Return False

Return ( True )

end function

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
Else
	bRet = False

	// [LGY19_PARAM_AUTO]
	bFin = False
	Do While Not bFin
		stMessage.sTitre		= "Contrôle de saisie de la garantie"
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

private function boolean uf_rf_611 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_611 (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Nature de sinistre non couverte
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* [20250915131212003][JFF][MIG165_BOUYGUES]
//*-----------------------------------------------------------------

Long lLig, lTotCondition, lIdNatSin, lDeb, lFin

String sRech

Boolean bRet

/*------------------------------------------------------------------*/
/* On déclenche ce motif si la nature du sinistre n'est pas         */
/* couverte. On envoie le test uniquement si la révision est        */
/* connue.                                                          */
/*------------------------------------------------------------------*/
bRet = True

lIdNatSin = idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) // [20250915131212003][JFF][MIG165_BOUYGUES]

If	idw_wSin.GetItemNumber ( 1, "ID_REV" ) <> -1	Then
	sRech = "ID_GTI = " 						+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )	+ &
			  " And ID_TYP_CODE = '+NS'"																				+ &
			  " And ID_CODE = " 				+ String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )

	lTotCondition = idw_Condition.RowCount ()

	lLig = idw_Condition.Find ( sRech, 1, lTotCondition )

/*------------------------------------------------------------------*/
/* La nature de sinistre n'est pas couverte, on déclenche le refus. */
/*------------------------------------------------------------------*/
	If	lLig = 0 Then
		bRet = Uf_RF_EcrireRefus ( 611 )
		
		// [20250915131212003][JFF][MIG165_BOUYGUES]
		// [MIG165_BOUYGUES]
		If F_CLE_A_TRUE ( "MIG165_BOUYGUES" ) Then
			F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 405 )
			If lDeb > 0 Then 
				// Pour Bouygues en du 611 on peut déclencher selon le cas, 2 autres refus.
				If bRet Then
					Choose Case lIdNatSin 
						Case 11 
							bRet = Uf_RF_EcrireRefus ( 1713 )							
							
						Case 28
							bRet = Uf_RF_EcrireRefus ( 1132 )							
					End Choose 
				End If 			
			End If 
		End If 		
	End If
End If

Return ( bRet )
end function

private function boolean uf_rf_612 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_612 (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Détail de sinistre non couvert
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
/* On déclenche ce motif si le détail de sinistre n'est pas         */
/* couvert. On envoie le test uniquement si la révision est connue. */
/*------------------------------------------------------------------*/
bRet = True

If	idw_wSin.GetItemNumber ( 1, "ID_REV" ) <> -1	Then
	sRech = "ID_GTI = " 						+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )	+ &
			  " And ID_TYP_CODE = '+DT'"																				+ &
			  " And ID_CODE = " 				+ String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )


	lTotCondition = idw_Condition.RowCount ()

	lLig = idw_Condition.Find ( sRech, 1, lTotCondition )

/*------------------------------------------------------------------*/
/* Le détail de sinistre n'est pas couvert, on déclenche le refus.  */
/*------------------------------------------------------------------*/
	If	lLig = 0 Then
		bRet = Uf_RF_EcrireRefus ( 612 )
	End If
End If

Return ( bRet )
end function

private function boolean uf_rf_613 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_613 (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Territorialité non couverte
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
/* On déclenche ce motif si la territorialité du sinistre n'est     */
/* pas couverte. On envoie le test uniquement si la révision est    */
/* connue.                                                          */
/*------------------------------------------------------------------*/
bRet = True

If	idw_wSin.GetItemNumber ( 1, "ID_REV" ) <> -1	Then
	sRech = "ID_GTI = " 						+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )	+ &
			  " And ID_TYP_CODE = '+TR'"																				+ &
			  " And ID_CODE = " 				+ String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )


	lTotCondition = idw_Condition.RowCount ()

	lLig = idw_Condition.Find ( sRech, 1, lTotCondition )

/*------------------------------------------------------------------*/
/* La territorialité du sinistre n'est pas couverte, on déclenche   */
/* le refus.                                                        */
/*------------------------------------------------------------------*/
	If	lLig = 0 Then
		bRet = Uf_RF_EcrireRefus ( 613 )
	End If
End If

Return ( bRet )

end function

private function boolean uf_rf_615 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_615 (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Carte non couverte
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------

Long lNbrCarteAffilier, dcIdProd, dcIdRev, dcIdGti, dcIdCarte
String	sIdAdh

Boolean bRet

/*------------------------------------------------------------------*/
/* On déclenche ce refus si l'ID_CARTE n'existe pas dans la table   */
/* AFFILIER. On envoie le test uniquement si PRODUIT.COD_ADH = 3.   */
/* (Méthode NumCarte avec ETS par Carte)                            */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* La zone ID_CARTE est calculée sur la zone ID_ADH de sinistre.    */
/* Elle peut trés bien ne pas avoir été déterminée (ID_CARTE = 0).  */
/* Ce refus ne doit être déclenché que si la révision est connue.   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modification DBI le 05/10/1998                                   */
/* Il ne faut pas déclencher le refus si le numéro de carte n'est   */
/* pas saisi                                                        */
/*------------------------------------------------------------------*/

bRet = True
dcIdRev 	= idw_wSin.GetItemNumber ( 1, "ID_REV" )
sIdAdh	= idw_wSin.GetItemString 	  ( 1, "ID_ADH" )

If	idw_Produit.GetItemString ( 1, "COD_ADH" ) = "3" 	And &
	dcIdRev 		<> -1 											And &
	Not isNull ( sIdAdh )										And &
	sIdAdh		<> ""				 								Then

	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdCarte	= idw_wSin.GetItemNumber ( 1, "ID_CARTE" )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )

	itrTrans.PS_S01_AFFILIER_SINISTRE ( dcIdProd, dcIdRev, dcIdGti, dcIdCarte, lNbrCarteAffilier )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S01_AFFILIER_SINISTRE" )	Then 
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée, on affiche le message.             */
/*------------------------------------------------------------------*/
		bRet = False
		F_Message ( stMessage )
	Else

		If	lNbrCarteAffilier = 0	Then
/*------------------------------------------------------------------*/
/* L'identifiant de la carte n'est pas couvert, on déclenche le     */
/* refus.                                                           */
/*------------------------------------------------------------------*/
			bRet = Uf_RF_EcrireRefus ( 615 )	
		End If
	End If
End If

Return ( bRet )
end function

private function boolean uf_rf_621 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_621 (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Délai de déclaration dépassé
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
//*
//*-----------------------------------------------------------------
Long lTotDelai, lLig, lDuree, lCpt, lLigFinale 
String sIdNivDel, sIdRefDel

Boolean bRet

String sRech, sUnite

Date	dDteSurv, dDteDecl, dDteMax, dDteTemp, dDteSav

bRet				= True
lTotDelai 		= idw_Delai.RowCount ()
lLigFinale		= 0
SetNull ( dDteSav )

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 1 to 4

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
			sIdNivDel = "+DT"  // Détail
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
	End Choose

	If IsNull ( sIdRefDel ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un délai de déclaration pour la garantie. */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_DEL = '"  + sIdNivDel 																+ "' AND " 	+ &
					"ID_REF_DEL = "	+ sIdRefDel 																+ " AND " 	+ &
					"ID_TYP_DEL = '621'"

	lLig = idw_Delai.Find ( sRech, 1, lTotDelai )

	If lLig > 0 Then	

		sUnite	= idw_Delai.GetItemString ( lLig, "UNT_DEL" )
		lDuree	= idw_Delai.GetItemNumber ( lLig, "DUR_MAX" )

		dDteTemp	= F_Plus_Date ( dDteSurv, lDuree, sUnite )

		If Not IsNull ( dDteSav ) Then

			If dDteTemp < dDteSav Then 
				dDteSav = dDteTemp
				lLigFinale = lLig
			End If

		Else
			dDteSav = dDteTemp
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
/* On récupére le délai maximum autorisé entre la survenance du     */
/* sinistre et la date de déclaration. On vérifie si ce délai est   */
/* dépassé.                                                         */
/*------------------------------------------------------------------*/
	dDteSurv = idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )
	dDteDecl = idw_wSin.GetItemDate ( 1, "DTE_DECL" )

	sUnite	= idw_Delai.GetItemString ( lLig, "UNT_DEL" )
	lDuree	= idw_Delai.GetItemNumber ( lLig, "DUR_MAX" )

	dDteMax	= F_Plus_Date ( dDteSurv, lDuree, sUnite )

	If	dDteDecl > dDteMax	Then
/*------------------------------------------------------------------*/
/* La durée maximum de déclaration est dépassée, on déclenche le    */
/* refus 621.                                                       */
/*------------------------------------------------------------------*/
		bRet = Uf_RF_EcrireRefus ( 621 )
	End If
End If

Return ( bRet )
end function

private function boolean uf_rf_602 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_602 (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Adhésion non souscrite au moment des faits
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------

Boolean bRet

String sCodAdh 

Date	dDteAdh, dDteSurv

bRet				= True
sCodAdh			= idw_Produit.GetItemString ( 1, "COD_ADH" )

/*------------------------------------------------------------------*/
/* Dans le cas des produits avec adhésion, on verifie que la date   */
/* d'adhésion est supérieure à la date de survenance, sinon on      */
/* déclenche le refus 602.                                          */
/*------------------------------------------------------------------*/
Choose Case sCodAdh
Case "1", "2", "5", "6"
	dDteAdh 	= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
	dDteSurv	= idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )

/*------------------------------------------------------------------*/
/* Dans le cas des produits avec adhésion, la date d'adhésion doit  */
/* être obligatoirement renseignée. Si elle est vide on arrête le   */
/* contrôle et on informe le gestionnaire.                          */
/*------------------------------------------------------------------*/
	If	IsNull ( dDteAdh )	Then

		stMessage.sTitre		= "Contrôle de saisie de la garantie"
		stMessage.Icon			= StopSign!
		stMessage.bErreurG	= False
		stMessage.sCode		= "WGAR140"

		f_Message ( stMessage )
		bRet = False

	Else
		If	dDteAdh > dDteSurv	Then
			bRet = Uf_RF_EcrireRefus ( 602 )	
		End If
	End If
End Choose

Return ( bRet )
end function

private function boolean uf_rf_601 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_601 (PRIVATE)
//* Auteur			: DBI
//* Date				: 05/10/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Adhésion résiliée
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------

Date dDteResil, dDteSurv, dDteFinGti

Boolean bRet

bRet = True

/*------------------------------------------------------------------*/
/* On déclenche ce motif de refus si la date de fin de garantie     */
/* est connue ( donc adhésion SPB ) et inférieure à la date du      */
/* sinistre.                                                        */
/* Il faut également de la date de résiliation soit renseignée (    */
/* sinon voir refus 603 )                                           */
/*------------------------------------------------------------------*/

dDteFinGti 	= Date(idw_wSin.GetItemDateTime ( 1, "DTE_FIN_GTI" 	)) // [PI056]
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
		bRet = Uf_RF_EcrireRefus ( 601 )
	End If
End If

Return ( bRet )

end function

private function string uf_determiner_etat (integer aitype);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Determiner_Etat (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:27:01
//* Libellé			: 
//* Commentaires	: Détermination du Code Etat de la Garantie
//*
//* Arguments		: Integer		aiType			(Val)
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//* #2    JFF    04/07/2007  [DCMP070163-070164-070248-070318] Gestion Prise en charge
//*								  Mémoire du forçage.
//			 JFF    06/12/2012  [PC476_MANTIS3803]
//        JFF    27/11/2017  [PM426-2]
// 		 JFF   12/01/2021   [FORCAGE_REFUS]
//*-----------------------------------------------------------------

String sRet, sRech, sIdAdh, sAltValide
Long lTotRefus1, lCptRefus, lIdMotif
Boolean bPceGarantie, bForcageRef1676
Long lDeb1, lCptDp, lFin1, lCodeRef, lRow
String sValCar
n_cst_string lnvPFCString
Long lVal, lTotRefus, lTotPce, lCpt, lCptPlaf, lLigFinale
Long lCodDecMac, lCodDecOpe, lCodEtat, lLig
Decimal {2} dcPlafSav, dcPlafTmp
Long lCptDetail, lTotDetail, lCodEtatDetail, lCodMotSsuiGti
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, lNbDetail
Long lTotPlaf
Integer iRep
DateTime dtDteSurv
String	sIdNivPlaf, sIdRefPlaf
Boolean bRefussuiteNonForcage

lVal = 0
sRet = ""
ilEtatForceOpe = 0 
bRefussuiteNonForcage = False

Choose Case aiType
Case 1					//	Détermination du Code Etat Machine (COD_DEC_MAC)

	If			idw_wGarSin.GetItemString ( 1, "ALT_BLOC" ) = "O"	Or Uf_Determiner_Etat_Detail ( 1 ) Then
				lVal = 1
	ElseIf	Uf_Determiner_Etat_Detail ( 0 ) Then				// y a t il des détails "non contrôlé"
/*------------------------------------------------------------------*/
/* Modification DBI le 14/08/1998                                   */
/* Si au moins 1 détail non contrôlé et que la garantie n'est pas   */
/* bloquée, on provoque un message d'erreur                         */
/*------------------------------------------------------------------*/
				lVal = 0
	ElseIf	idw_wGarSin.GetItemString ( 1, "ALT_SSUI" ) = "O"	Then
					lVal = 900
	Else

/*------------------------------------------------------------------*/
/* Modification Dbi le 14/08/1998                                   */
/* je décompose le test pour la gestion du sans suite en deux       */
/* parties.                                                         */
/* Il y avait une erreur dans le document d'analyse car même si     */
/* tous les détails sont sans suite, il faut tenir compte des       */
/* événtuels refus et demandes de pièces de la garantie             */
/*------------------------------------------------------------------*/

	 lTotRefus = iuoTagRefus.dw_Trt.Find ( "ALT_MAC = 'O' OR ALT_OPE = 'O'", 1, iuoTagRefus.dw_Trt.RowCount () )
	 lTotPce   = iuoTagPiece.dw_Trt.Find ( "ALT_RECLAME = 'O'", 1, iuoTagPiece.dw_Trt.RowCount () )

	 If Uf_Determiner_Etat_Detail ( 2 ) 						And &
		 idw_wGarSin.GetItemString ( 1, "ALT_ATT" ) = "N" 	And &
 	    lTotPce   = 0													And &
		 lTotRefus = 0													Then

					lVal = 900
	 Else
/*------------------------------------------------------------------*/
/* Si au moins un refus (Opérateur ou Machine) est coché et que     */
/* aucun détail n'est réglé. (COD_ETAT = 600), on positionne le     */
/* code à 200.                                                      */
/*------------------------------------------------------------------*/
				lTotRefus = iuoTagRefus.dw_Trt.RowCount ()
				For	lCpt = 1 To lTotRefus
						If	iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_MAC" ) = "O" Or &
							iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_OPE" ) = "O"	Then

							If	Uf_Determiner_Etat_Detail ( 3 ) Then
								lVal = 200
							End If
						End If
				Next
/*------------------------------------------------------------------*/
/* Si au moins un des détails est refusé avec ALT_VALIDE = O ET     */
/* qu'il n'y a aucun détail REGLER ou A REGLER 	ET                  */
/* qu'il n'y a aucun détail en demande de piéce	ET                  */
/* qu'il n'y a aucune demande de piéce pour la garantie alors on    */
/* refuse la garantie.                                              */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modification DBI le 14/08/1998                                   */
/* J'ai oublié dans le document fourni à Daniel d'indiquer qu'il    */
/* fallait en plus que la zone ALT_ATT ne soit pas cochée           */
/*------------------------------------------------------------------*/

				If	lVal = 0	Then
					If	Uf_Determiner_Etat_Detail ( 4 ) And Uf_Determiner_Etat_Detail ( 5 ) Then
						lTotPce = iuoTagPiece.dw_Trt.RowCount ()
						bPceGarantie = False

						If idw_wGarSin.GetItemString ( 1, "ALT_ATT" ) = "O" Then 

							bPceGarantie = True
						Else
							
							For	lCpt = 1 To lTotPce
								If	iuoTagPiece.dw_Trt.GetItemString ( lCpt, "ALT_RECLAME" ) = "O"		Then
									bPceGarantie = True
									Exit
								End If
							Next
						End If
						If	Not bPceGarantie	Then	lVal = 200
					End If
				End If
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
/* Si la garantie est en attente, ALT_ATT = 'O', on positionne le   */
/* code à 100.                                                      */
/*------------------------------------------------------------------*/
				If	lVal = 0 And idw_wGarSin.GetItemString ( 1, "ALT_ATT" ) = "O"	Then
					lVal = 100
				End If
/*------------------------------------------------------------------*/
/* S'il y a au moins un détail en demande de pièce ou en attente    */
/* ET                                                               */
/* qu'il n'y a aucun détail REGLER ou A REGLER                      */
/* alors on positionne la garantie en demande de pièce.             */
/*------------------------------------------------------------------*/
				If	lVal = 0	Then
					If	Uf_Determiner_Etat_Detail ( 6 ) And Uf_Determiner_Etat_Detail ( 7 ) Then
						lVal = 100
					End If
				End If
/*------------------------------------------------------------------*/
/* S'il y a au moins un détail en demande de pièce ou en attente    */
/* ET                                                               */
/* qu'il y a au moins un détail REGLER ou A REGLER                  */
/* alors on positionne la garantie en cours de réglement.           */
/*------------------------------------------------------------------*/
				If	lVal = 0	Then
					If	Uf_Determiner_Etat_Detail ( 6 ) And Uf_Determiner_Etat_Detail ( 8 ) Then
						lVal = 550
					End If
				End If
/*------------------------------------------------------------------*/
/* S'il y a au moins un détail A REGLER, on positionne la garantie  */
/* A REGLER.                                                        */
/*------------------------------------------------------------------*/
				If	lVal = 0	Then
					If	Uf_Determiner_Etat_Detail ( 10 ) Then
						lVal = 500
					End If
				End If
/*------------------------------------------------------------------*/
/* S'il existe au moins un détail de REGLER et au moins un détail   */
/* avec ALT_VALIDE = "O", on positionne la garantie à REGLE         */
/* (COD_ETAT = 600).                                                */
/*------------------------------------------------------------------*/
			If	lVal = 0	Then
				If	Uf_Determiner_Etat_Detail ( 12 ) And Uf_Determiner_Etat_Detail ( 13 )	Then
					lVal = 600
				End If
			End If
	 End If
	End If	
	idw_wGarSin.SetItem ( 1, "COD_DEC_MAC", lVal )

Case 2					//	Détermination du Code Etat Opérateur (COD_DEC_OPE)

	If			idw_wGarSin.GetItemString ( 1, "ALT_BLOC" ) = "O"	Or Uf_Determiner_Etat_Detail ( 1 ) Then
				lVal = 1
	ElseIf	idw_wGarSin.GetItemString ( 1, "ALT_SSUI" ) = "O"	Then
					lVal = 900
	Else
	
/*------------------------------------------------------------------*/
/* Modification Dbi le 14/08/1998                                   */
/* je décompose le test pour la gestion du sans suite en deux       */
/* parties.                                                         */
/* Il y avait une erreur dans le document d'analyse car même si     */
/* tous les détails sont sans suite, il faut tenir compte des       */
/* événtuels refus et demandes de pièces de la garantie             */
/*------------------------------------------------------------------*/

	 lTotRefus = iuoTagRefus.dw_Trt.Find ( "ALT_MAC = 'O' OR ALT_OPE = 'O'", 1, iuoTagRefus.dw_Trt.RowCount () )
	 lTotPce   = iuoTagPiece.dw_Trt.Find ( "ALT_RECLAME = 'O'", 1, iuoTagPiece.dw_Trt.RowCount () )

	 If Uf_Determiner_Etat_Detail ( 2 ) 						And &
		 idw_wGarSin.GetItemString ( 1, "ALT_ATT" ) = "N" 	And &
 	    lTotPce   = 0													And &
		 lTotRefus = 0													Then

					lVal = 900
	 Else
/*------------------------------------------------------------------*/
/* Si au moins un refus (Opérateur) est coché et que aucun détail   */
/* n'est A REGLER. (Non forcé pas opérateur) (ALT_REG = "N"), on    */
/* positionne le code à 200.                                        */
/*------------------------------------------------------------------*/
				lTotRefus = iuoTagRefus.dw_Trt.RowCount ()
				For	lCpt = 1 To lTotRefus
						If	iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_OPE" ) = "O"	Then
							If	Uf_Determiner_Etat_Detail ( 9 ) Then
								lVal = 200
								Exit
							End If
						End If
				Next
/*------------------------------------------------------------------*/
/* Si au moins un des détails est refusé avec ALT_VALIDE = O ET     */
/* qu'il n'y a aucun détail REGLER ou A REGLER 	ET                  */
/* qu'il n'y a aucun détail en demande de piéce	ET                  */
/* qu'il n'y a aucune demande de piéce pour la garantie alors on    */
/* refuse la garantie.                                              */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modification DBI le 14/08/1998                                   */
/* J'ai oublié dans le document fourni à Daniel d'indiquer qu'il    */
/* fallait en plus que la zone ALT_ATT ne soit pas cochée           */
/*------------------------------------------------------------------*/
				If	lVal = 0	Then
					If	Uf_Determiner_Etat_Detail ( 4 ) And Uf_Determiner_Etat_Detail ( 5 ) Then
						lTotPce = iuoTagPiece.dw_Trt.RowCount ()
						bPceGarantie = False

						If idw_wGarSin.GetItemString ( 1, "ALT_ATT" ) = "O" Then 

							bPceGarantie = True
						Else
							
							For	lCpt = 1 To lTotPce
								If	iuoTagPiece.dw_Trt.GetItemString ( lCpt, "ALT_RECLAME" ) = "O"		Then
									bPceGarantie = True
									Exit
								End If
							Next
						End If
						If	Not bPceGarantie	Then	lVal = 200
					End If
				End If
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
/* Si la garantie est en attente, ALT_ATT = 'O', on positionne le   */
/* code à 100.                                                      */
/*------------------------------------------------------------------*/
				If	lVal = 0 And idw_wGarSin.GetItemString ( 1, "ALT_ATT" ) = "O"	Then
					lVal = 100
				End If
/*------------------------------------------------------------------*/
/* S'il y a au moins un détail en demande de pièce ou en attente    */
/* ET                                                               */
/* qu'il n'y a aucun détail REGLER ou A REGLER                      */
/* alors on positionne la garantie en demande de pièce.             */
/*------------------------------------------------------------------*/
				If	lVal = 0	Then
					If	Uf_Determiner_Etat_Detail ( 6 ) And Uf_Determiner_Etat_Detail ( 7 ) Then
						lVal = 100
					End If
				End If
/*------------------------------------------------------------------*/
/* S'il y a au moins un détail en demande de pièce ou en attente    */
/* ET                                                               */
/* qu'il y a au moins un détail REGLER ou A REGLER                  */
/* alors on positionne la garantie en cours de réglement.           */
/*------------------------------------------------------------------*/
				If	lVal = 0	Then
					If	Uf_Determiner_Etat_Detail ( 6 ) And Uf_Determiner_Etat_Detail ( 8 ) Then
						lVal = 550
					End If
				End If
/*------------------------------------------------------------------*/
/* S'il y a au moins un détail A REGLER, on positionne la garantie  */
/* A REGLER.                                                        */
/*------------------------------------------------------------------*/
				If	lVal = 0	Then
					If	Uf_Determiner_Etat_Detail ( 10 ) Then
						lVal = 500
					End If
				End If
/*------------------------------------------------------------------*/
/* S'il existe au moins un détail de REGLER et au moins un détail   */
/* avec ALT_VALIDE = "O", on positionne la garantie à REGLE         */
/* (COD_ETAT = 600).                                                */
/*------------------------------------------------------------------*/
			If	lVal = 0	Then
				If	Uf_Determiner_Etat_Detail ( 12 ) And Uf_Determiner_Etat_Detail ( 13 )	Then
					lVal = 600
				End If
			End If
/*------------------------------------------------------------------*/
/* S'il existe au moins un motif de refus machine pour la           */
/* garantie, on positionne le code état à 200 (REFUSE).             */
/*------------------------------------------------------------------*/
			If	lVal = 0	Then
				lTotRefus = iuoTagRefus.dw_Trt.RowCount ()
				For	lCpt = 1 To lTotRefus
						If	iuoTagRefus.dw_Trt.GetItemString ( lCpt, "ALT_MAC" ) = "O"	Then
							lVal = 200
							Exit
						End If
				Next
			End If
	 End If
	End If

	idw_wGarSin.SetItem ( 1, "COD_DEC_OPE", lVal )

Case 3					//	Détermination du Code Etat (COD_ETAT)

	lCodDecOpe	= idw_wGarSin.GetItemNumber ( 1, "COD_DEC_OPE" )
	lCodDecMac	= idw_wGarSin.GetItemNumber ( 1, "COD_DEC_MAC" )
	lCodEtat		= 0

/*------------------------------------------------------------------*/
/* Si l'un des états est à 0, il manque des informations, on        */
/* positionne le COD_ETAT à Non controlé.                           */
/*------------------------------------------------------------------*/
	If	lCodDecOpe = 0 Or lCodDecMac = 0	Then
		stMessage.sTitre		= "Contrôle sur la garantie"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= False
		stMessage.sCode		= "WGAR190"
		
		f_Message ( stMessage )
		sRet = "MT_PROV"
	Else
		If	lCodDecOpe <> lCodDecMac	Then
			// [PM426-2]
			lRow = idw_wdivsin.Find("UPPER(NOM_ZONE)='FORCER_REFUS_1676'", 1, idw_wdivsin.RowCount())
			If lRow> 0 Then
				bForcageRef1676= idw_wdivsin.GetItemString (lRow, "VAL_CAR") = "O"
			End If
			
			If	( Long ( stGLB.sTypOper ) >= idw_Produit.GetItemNumber ( 1, "COD_NIV_OPE" )) &
				Or &
				( iuoTagRefus.dw_Trt.Find ( "ID_MOTIF=1676 AND ALT_MAC='O'", 1, iuoTagRefus.dw_Trt.RowCount ()) > 0 And &
				  iuoTagRefus.dw_Trt.Find ( "ID_MOTIF<>1676 AND ALT_MAC='O'", 1, iuoTagRefus.dw_Trt.RowCount ()) = 0 And &
				  iuoTagRefus.dw_Trt.Find ( "ALT_OPE='O'", 1, iuoTagRefus.dw_Trt.RowCount ()) = 0 And &					  
				  bForcageRef1676 &
				)&
			Then					
				
				// [FORCAGE_REFUS]
				If lCodDecMac = 200 Then
					stMessage.sTitre		= "Dec Mac Dif Dec Ope=> Essai de Forçage autorisé"
					stMessage.Icon			= Exclamation!
					stMessage.Bouton		= YesNo!
					stMessage.bErreurG	= False
					stMessage.sCode		= "WGAR162"
					iRep = f_Message ( stMessage )

					stMessage.Bouton		= Ok!						
					
					If iRep = 1 Then						
						lCodEtat = lCodDecOpe
						ilEtatForceOpe = lCodDecOpe // #2
					Else 
						lCodEtat = lCodDecMac
						bRefussuiteNonForcage = TRUE
					End If 
					
				End If 
				// /[FORCAGE_REFUS]
				
			Else
				lCodEtat = lCodDecMac
			End If
		Else
			lCodEtat = lCodDecOpe
		End If
	End If
/*------------------------------------------------------------------*/
/* Si le COD_ETAT est égal à 200 (REFUSE), on va vérifier s'il      */
/* existe des détails A REGLER ou en EN ATTENTE (COD_ETAT = 500,    */
/* COD_ETAT= 100). Si oui, on demande à l'opérateur s'il est        */
/* d'accord pour basculer ces détails a REFUSE. S'il n'est pas      */
/* d'accord, on bascule le code état de la garantie à NON CONTROLE. */
/*------------------------------------------------------------------*/
	If			lCodEtat = 200	Then
				lTotDetail = idw_LstDetail.RowCount ()

				sRech = "COD_ETAT = 500 Or COD_ETAT = 100"
				lLig = idw_LstDetail.Find ( sRech, 1, lTotDetail )

				If	lLig > 0 Then
					stMessage.sTitre		= "Contrôle sur la garantie"
					stMessage.Icon			= Question!
					stMessage.Bouton		= YesNo!
					stMessage.bErreurG	= False
	
					// [FORCAGE_REFUS]
					stMessage.sCode		= "WGAR161"
					stMessage.sTitre		= "Dec Mac Dif Dec Ope=> Forçage NON autorisé"
					If bRefussuiteNonForcage Then
						iRep = 1 // Décision déjà prise plus haut
					Else 
						iRep = f_Message ( stMessage )							
					End If 
					stMessage.Bouton		= Ok!																		

					
					If	iRep = 1	Then
						For	lCptDetail = 1 To lTotDetail
								lCodEtatDetail = idw_LstDetail.GetItemNumber ( lCptDetail, "COD_ETAT" )
								If	lCodEtatDetail = 500 Or lCodEtatDetail = 100	Then
									idw_LstDetail.SetItem ( lCptDetail, "COD_ETAT", 200 )
								End If
						Next

						// [PC476_MANTIS3803]
						lTotRefus1 = iuoTagRefus.dw_Trt.RowCount ()
						For	lCptRefus = 1 To lTotRefus1
								If	iuoTagRefus.dw_Trt.GetItemString ( lCptRefus , "ALT_MAC" ) = "O"	Then
									lIdMotif = iuoTagRefus.dw_Trt.GetItemNumber ( lCptRefus , "ID_MOTIF" )

									// [PLAF_REF]
									F_RechDetPro ( lDeb1, lFin1, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 183 )
									If lDeb1 > 0 Then
										For lCptDP = lDeb1 To lFin1
											sValCar = idw_DetPro.GetItemString ( lCptDP, "VAL_CAR" )
											lCodeRef = Long ( lnvPFCString.of_getkeyvalue( sValCar, "REF_GTI", ";"))
											If lCodeRef = lIdMotif Then
												iuoTagRefus.dw_Trt.SetItem ( lCptRefus , "ALT_OPE", "O" )
											End If
										Next
									End If 
								End If
						Next
						// :[PC476_MANTIS3803]
						
					Else
						lCodEtat = 0
						sRet = "MT_PROV"
					End If
				End If
/*------------------------------------------------------------------*/
/* Le 08/12/1998:                                                   */
/* Si le COD_ETAT est égal à 900 (SANS SUITE), et que ALT_SSUI est  */
/* égal à OUI (Important, car la garantie peut être SANS SUITE, si  */
/* tous les détails sont SANS SUITE, et ALT_SSUI peut avoir une     */
/* valeur à NON), on va vérifier s'il existe des détails A VALIDER  */
/* et si tous ces détails sont SANS SUITE. Si ce n'est pas le cas,  */
/* on affiche un message d'avertissement pour l'utilisateur. Il     */
/* doit d'abord passer tous les détails SANS SUITE.                 */
/*------------------------------------------------------------------*/
	ElseIf	lCodEtat = 900	And idw_wGarSin.GetItemString ( 1, "ALT_SSUI" ) = "O" Then
				lTotDetail = idw_LstDetail.RowCount ()

				sRech = "COD_ETAT <> 900"
				lLig = idw_LstDetail.Find ( sRech, 1, lTotDetail )

				If	lLig > 0 Then
					stMessage.sTitre		= "Contrôle sur la garantie"
					stMessage.Icon			= Information!
					stMessage.Bouton		= Ok!
					stMessage.bErreurG	= False
					stMessage.sCode		= "WGAR260"

					f_Message ( stMessage )

					lCodEtat = 0
					sRet = "MT_PROV"
				Else
/*------------------------------------------------------------------*/
/* Tous les détails sont sans suite, on arme le motif du SANS       */
/* SUITE de la garantie sur tous les détails A VALIDER. Le          */
/* gestionnaire peut trés bien mettre un motif différent sur un     */
/* détail.                                                          */
/*------------------------------------------------------------------*/
					lCodMotSsuiGti	= idw_wGarSin.GetItemNumber ( 1, "COD_MOT_SSUI" )

					stMessage.sTitre		= "Contrôle sur la garantie"
					stMessage.Icon			= Information!
					stMessage.Bouton		= Ok!
					stMessage.bErreurG	= False
					stMessage.sCode		= "WGAR270"

					f_Message ( stMessage )

					For	lCptDetail = 1 To lTotDetail
							sAltValide = idw_LstDetail.GetItemString ( lCptDetail, "ALT_VALIDE" )
							If	sAltValide = "O"	Then
								idw_LstDetail.SetItem ( lCptDetail, "ALT_SSUI", "O" )
								idw_LstDetail.SetItem ( lCptDetail, "COD_MOT_SSUI", lCodMotSsuiGti )
								idw_LstDetail.SetItem ( lCptDetail, "MT_PREJ", 0.00 )
								idw_LstDetail.SetItem ( lCptDetail, "ID_I_REG", stNul.dcm )
							End If
					Next
				End If
	ElseIf	lCodEtat = 100	Then
/*------------------------------------------------------------------*/
/* Si le COD_ETAT est égal à 100 (EN ATTENTE), on va vérifier s'il  */
/* existe des détails A REGLER (COD_ETAT= 500). Si oui, on demande  */
/* à l'opérateur s'il est d'accord pour basculer ces détails a EN   */
/* ATTENTE. S'il n'est pas d'accord, on bascule le code état de la  */
/* garantie à NON CONTROLE.                                         */
/*------------------------------------------------------------------*/
				lTotDetail = idw_LstDetail.RowCount ()

				sRech = "COD_ETAT = 500"
				lLig = idw_LstDetail.Find ( sRech, 1, lTotDetail )

				If	lLig > 0 Then
					stMessage.sTitre		= "Contrôle sur la garantie"
					stMessage.Icon			= Question!
					stMessage.Bouton		= YesNo!
					stMessage.bErreurG	= False
					stMessage.sCode		= "WGAR170"
		
					iRep = f_Message ( stMessage )
					If	iRep = 1	Then
						For	lCptDetail = 1 To lTotDetail
								lCodEtatDetail = idw_LstDetail.GetItemNumber ( lCptDetail, "COD_ETAT" )
								If	lCodEtatDetail = 500	Then
									idw_LstDetail.SetItem ( lCptDetail, "COD_ETAT", 100 )
								End If
						Next
					Else
						lCodEtat = 0
						sRet = "MT_PROV"
					End If
				End If
	End If

	If	lCodEtat = 550	Then
/*------------------------------------------------------------------*/
/*  On va vérifier s'il existe d'autres détails 'A REGLER' - pour   */
/* une garantie identique - pour des sinistres différents de celui  */
/* en cours de traitement. (Avec adhésion identique). Si c'est le   */
/* cas et qu'il existe au moins un plafond pour cette               */
/* garantie-révision, on doit bloquer le dossier et avertir le      */
/* gestionnaire de valider le sinistre lié avant.                   */
/*------------------------------------------------------------------*/
		lTotPlaf	= idw_Plafond.RowCount ()
		dcPlafSav = 0

		/*------------------------------------------------------------------*/
		/* #1, JFF le 11/04/2003                                            */
		/*------------------------------------------------------------------*/
		For lCptPlaf = 1 to 4

			Choose Case lCptPlaf
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
							"ID_CPT_PLAF = 0"

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
			dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
			dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
			lNbDetail	= 0

			itrTrans.PS_S01_W_GTI_A_REGLER ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, dtDteSurv, lNbDetail )
			If	Not F_Procedure ( stMessage, itrTrans, "PS_S01_W_GTI_A_REGLER" )	Then 
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée, on affiche le message.             */
/*------------------------------------------------------------------*/
				f_Message ( stMessage )
				lCodEtat = 0
				sRet = "MT_PROV"
			Else
				If	lNbDetail > 0 Then
					stMessage.sTitre		= "Contrôle sur la garantie"
					stMessage.Icon			= Information!
					stMessage.bErreurG	= False
					stMessage.sVar[1]		= String ( lNbDetail )
					stMessage.sCode		= "WGAR160"
		
					f_Message ( stMessage )
					lCodEtat = 0
					sRet = "MT_PROV"
				End If
			End If
		End If
	End If

	idw_wGarSin.SetItem ( 1, "COD_ETAT", lCodEtat )

End Choose
			
Return ( sRet )
end function

private function boolean uf_determiner_etat_detail (integer aitype);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Determiner_Etat_Detail (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:27:01
//* Libellé			: 
//* Commentaires	: Détermination du Code Etat en fonction des détails
//*
//* Arguments		: Integer		aiType			(Val) 
//*
//* Retourne		: Boolean
//*
//*-----------------------------------------------------------------
/*------------------------------------------------------------------*/
/* Modification DBI le 14/08/1998                                   */
/* Gestion des détails non controlés ( type 0 )                     */
/* si au moins 1 détail non controlé et que la garantie n'est pas   */
/* bloquée                                                          */
/* on interdit de poursuivre le contrôle                            */
/*------------------------------------------------------------------*/

Boolean bRet

Long lTotDetail, lCpt

lTotDetail	= idw_LstDetail.RowCount ()
bRet			= False

Choose Case aiType

Case 0						// Un des détails est-il non contrôlé ?
	For	lCpt = 1 To lTotDetail
			If	idw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" ) = 0	Then
				bRet = True
				Exit
			End If
	Next

Case 1						// Un des détails est-il bloqué ?
	For	lCpt = 1 To lTotDetail
			If	idw_LstDetail.GetItemString ( lCpt, "ALT_BLOC" ) = "O"	Then
				bRet = True
				Exit
			End If
	Next

Case 2						// Tous les détails sont-ils sans suite ?
	If	lTotDetail > 0	Then bRet = True

	For	lCpt = 1 To lTotDetail
			If	idw_LstDetail.GetItemString ( lCpt, "ALT_SSUI" ) = "N"	Then
				bRet = False
				Exit
			End If
	Next

Case 3						// Aucun détail de réglés ?
	bRet = True

	For	lCpt = 1 To lTotDetail
			If	idw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" ) = 600	Then
				bRet = False
				Exit
			End If
	Next

Case 4						// Un des détails est-il refusé avec ALT_VALIDE = "O" ?
	For	lCpt = 1 To lTotDetail
			If	idw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" ) = 200	And &
				idw_LstDetail.GetItemString ( lCpt, "ALT_VALIDE" ) = "O"	Then
				bRet = True
				Exit
			End If
	Next

Case 5						// Un des détails est-il réglé ou a réglé ou en demande de pièces ?
	If	lTotDetail > 0	Then bRet = True

	For	lCpt = 1 To lTotDetail
			If	idw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" ) = 500 Or &
				idw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" ) = 600 Or &
				idw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" ) = 100 Then
				bRet = False
				Exit
			End If
	Next

Case 6						// Un des détails est-il en demande de pièces ou en attente ?
	For	lCpt = 1 To lTotDetail
			If	idw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" ) = 100 Then
				bRet = True
				Exit
			End If
	Next

Case 7						// Un des détails est-il réglé ou a réglé ?
	If	lTotDetail > 0	Then bRet = True

	For	lCpt = 1 To lTotDetail
			If	idw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" ) = 500 Or &
				idw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" ) = 600 Then
				bRet = False
				Exit
			End If
	Next

Case 8						// Un des détails est-il réglé ou a réglé ?
	For	lCpt = 1 To lTotDetail
			If	idw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" ) = 500 Or &
				idw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" ) = 600 Then
				bRet = True
				Exit
			End If
	Next

Case 9						// Un des détails est-il A REGLER mais non forcé pas l'opérateur ?
	bRet = True

	For	lCpt = 1 To lTotDetail
			If	idw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" ) = 500 And &
				idw_LstDetail.GetItemString ( lCpt, "ALT_REG" ) = "N" Then
				bRet = False
				Exit
			End If
	Next

Case 10						// Un des détails est-il A REGLER ?
	For	lCpt = 1 To lTotDetail
			If	idw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" ) = 500	Then
				bRet = True
				Exit
			End If
	Next

Case 11						// Un des détails est-il A REGLER avec ALT_REG = "O" ?
	For	lCpt = 1 To lTotDetail
			If	idw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" ) = 500	And &
				idw_LstDetail.GetItemString ( lCpt, "ALT_REG" ) = "O"	Then
				bRet = True
				Exit
			End If
	Next

Case 12						// Un des détails est-il REGLER ?
	For	lCpt = 1 To lTotDetail
			If	idw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" ) = 600	Then
				bRet = True
				Exit
			End If
	Next

Case 13						// Un des détails est-il a valider (ALT_VALIDE = "O" ) ?
	For	lCpt = 1 To lTotDetail
			If	idw_LstDetail.GetItemString ( lCpt, "ALT_VALIDE" ) = "O"	Then
				bRet = True
				Exit
			End If
	Next

End Choose

Return ( bRet )


end function

private subroutine uf_calculer_montant_detail (integer aitype);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Calculer_Montant_Detail (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/04/1998 17:58:24
//* Libellé			: 
//* Commentaires	: On va calculer les montants pour la garantie
//*
//* Arguments		: Integer		aiType			(Val)
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lTotDetail, lCpt

Decimal {2} dcMtTotPrej, dcMtPrejaReg, dcMtDeduaReg, dcMtFranaReg, dcMtnPlafaReg, dcMtPlafaReg

lTotDetail = idw_LstDetail.RowCount ()

Choose Case aiType
Case 1					// Cas ou l'on force le réglement d'un détail

	For	lCpt = 1 To lTotDetail
			dcMtTotPrej += idw_LstDetail.GetItemDecimal ( lCpt, "MT_PREJ" )
			If	idw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" ) = 500	Then
				dcMtPrejaReg += idw_LstDetail.GetItemDecimal ( lCpt, "MT_PLAF" )
			End If
	Next
	dcMtDeduaReg 	= 0
	dcMtFranaReg 	= 0

	dcMtnPlafaReg	= dcMtPrejaReg
	dcMtPlafaReg 	= dcMtPrejaReg

Case 2					// Cas ou l'on régle la garantie sans forcer aucun détail

	For	lCpt = 1 To lTotDetail
			dcMtTotPrej += idw_LstDetail.GetItemDecimal ( lCpt, "MT_PREJ" )
			If	idw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" ) = 500	Then
				dcMtPrejaReg += idw_LstDetail.GetItemDecimal ( lCpt, "MT_PLAF" )
			End If
	Next

	dcMtDeduaReg 	= idw_wGarSin.GetItemDecimal ( 1, "MT_DEDU_AREG" )
	If	IsNull ( dcMtDeduaReg ) Then	dcMtDeduaReg = 0
	dcMtFranaReg 	= 0

	dcMtnPlafaReg	= dcMtPrejaReg - dcMtDeduaReg
/*------------------------------------------------------------------*/
/* Modification DBI le 17/08/1999                                   */
/* MT_DEDU_AREG étant toujours accessible, il faut faire            */
/* attention                                                        */
/* de ne pas obtenir de montant négatif.                            */
/* Je remets donc MT_NPLAF_AREG et MT_PLAF_AREG à 0 si < 0.         */
/*------------------------------------------------------------------*/
	If ( dcMtnPlafaReg < 0 ) Then	dcMtnPlafaReg = 0

	dcMtPlafaReg 	= dcMtPrejaReg - dcMtDeduaReg
	If ( dcMtPlafaReg < 0 ) Then	dcMtPlafaReg = 0

End Choose

idw_wGarSin.SetItem ( 1, "MT_TOT_PREJ", 		dcMtTotPrej   )
idw_wGarSin.SetItem ( 1, "MT_PREJ_AREG", 		dcMtPrejaReg  )
idw_wGarSin.SetItem ( 1, "MT_DEDU_AREG",		dcMtDeduaReg  )
idw_wGarSin.SetItem ( 1, "MT_FRAN_AREG",		dcMtFranaReg  )
idw_wGarSin.SetItem ( 1, "MT_NPLAF_AREG",		dcMtnPlafaReg )
idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG",		dcMtPlafaReg  )
end subroutine

private function boolean uf_verifier_condition_reg ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Verifier_Condition_Reg (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 09/04/1998 16:45:16
//* Libellé			: 
//* Commentaires	: On vérifie si le règlement est autorisé
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		True 	= Le règlement est autorisé pour la garantie
//*										False	= Le règlement n'est pas autorisé pour la garantie
//*
//*-----------------------------------------------------------------

Boolean bRet

Long lTotCondition, lLig

String sRech

bRet 				= True
lTotCondition	= idw_Condition.RowCount ()

/*------------------------------------------------------------------*/
/* Important : La révision est forcément connue. En effet, on       */
/* interdit un détail en réglement si la révision est à -1.         */
/* (Uf_ControlerSaisie_Si_Reglement).                               */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On recherche d'abord pour la nature de sinistre.                 */
/*------------------------------------------------------------------*/

sRech = "ID_GTI = " 						+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) ) 	+ &
		  " And ID_TYP_CODE = '+NS'" 																				+ &
		  " And ID_CODE = " 				+ String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )	+ &
		  " And ALT_REG = 'O'"

lLig = idw_Condition.Find ( sRech, 1, lTotCondition )

/*------------------------------------------------------------------*/
/* La nature de sinistre n'autorise pas le règlement de la          */
/* garantie.                                                        */
/*------------------------------------------------------------------*/
If	lLig = 0 Then
	bRet = False
	stMessage.sVar[1] 	= "La nature"
End If

/*------------------------------------------------------------------*/
/* On recherche maintenant pour le détail de sinistre.              */
/*------------------------------------------------------------------*/
If	bRet	Then
	sRech = "ID_GTI = " 						+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )	+ &
			  " And ID_TYP_CODE = '+DT'"																				+ &
			  " And ID_CODE = " 				+ String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )

	lLig = idw_Condition.Find ( sRech, 1, lTotCondition )

/*------------------------------------------------------------------*/
/* Le détail de sinistre n'autorise pas le règlement de la          */
/* garantie.                                                        */
/*------------------------------------------------------------------*/
	If	lLig = 0	Then
		bRet = False
		stMessage.sVar[1] 	= "Le détail"
	End If
End If

/*------------------------------------------------------------------*/
/* On recherche enfin pour la territorialité.                       */
/*------------------------------------------------------------------*/
If	bRet	Then
	sRech = "ID_GTI = " 						+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )	+ &
			  " And ID_TYP_CODE = '+TR'"																				+ &
			  " And ID_CODE = " 				+ String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )

	lLig = idw_Condition.Find ( sRech, 1, lTotCondition )

/*------------------------------------------------------------------*/
/* La territorialité du sinistre n'autorise pas le règlement de la  */
/* garantie.                                                        */
/*------------------------------------------------------------------*/
	If	lLig = 0	Then
		bRet = False
		stMessage.sVar[1] 	= "La territorialité"
	End If
End If

If	Not bRet Then
/*------------------------------------------------------------------*/
/* On affiche un message pour avertir le gestionnaire.              */
/*------------------------------------------------------------------*/

	stMessage.sTitre		= "Contrôle de saisie de la garantie"
	stMessage.Icon			= StopSign!
	stMessage.bErreurG	= False
	stMessage.sCode		= "WGAR180"

	f_Message ( stMessage )
End If

Return ( bRet )


end function

private function string uf_calcul_montantregle ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Calcul_MontantRegle (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Calcul du Montant à régler pour la garantie
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF   22/12/2003   DCMP 030558 Création de 4 nouveaux plafonds 695,696,697,698
//* #2	 CAG	 14/06/2004	  DCMP 040176 Création d'un plafond par année civile (673, 674)
//* #3	 JFF	 06/12/2004	  DCMP 040407 Nouveau Plafond par client physique Sherpa
//* #4    JFF   12/06/2008   [DCMP080377] Plafond Nb Sin par année civile
//* --    JFF   08/04/2010   [DCMP100220]
//*		 FPI	 18/06/2010	  [DCMP100410]
//* 		 JFF   08/12/2010   [PC397][PC441][PC443]
//*       JFF   27/07/2011   [PLAF_REF]
//*		 JFF   23/11/2011   [PC581].[POINT155][VDOC5984]
//*		 JFF   14/06/2012   [VDOC7410]
//*       JFF   26/11/2012   [PC877]
//        JFF   31/07/2013   [PC845_NOUVPLAF]
//        JFF   31/07/2013   [PC845_NOUVPLAF741]
//        JFF   10/11/2014   [PC801-5]
//        JFF   12/12/2014   [PC13321]
//        JFF   07/05/2013   [PC938_ORANGE_V3]
//        JFF   10/02/2015   [VDOC19467]
// 		 JFF   15/09/2017   [VDOC24658]
// 		 JFF   04/10/2017   [VDOC24781]
// 		 JFF   17/11/2017   [VDOC25099]
//        JFF   14/03/2018   [DT352]
// 		 JFF   07/05/2018   [VDOC26121]
//        JFF   16/10/2018   [PC171999]
//        JFF   24/06/2019   [PC192235]
//        JFF   08/09/2020   [PC202551_PLAF_759]
//        JFF   07/05/2013   [DT509]
// 		 JFF   02/11/2020   [VDOC29786]
// 		 JFF   06/10/2020   [PLAFOND762_ISM215077]
// 		 JFF   12/01/2021   [FORCAGE_REFUS]
//        JFF   20/06/2025   [MIG147_KRYS]
//*-----------------------------------------------------------------

String sPos

Long lCodEtatGarantie, lCpt, lTotPlafond, lTotDetail, lIdGti, lDeb, lFin
Decimal {2} dcMtTotPrej

lCodEtatGarantie 	= idw_wGarSin.GetItemNumber ( 1, "COD_ETAT" )
lIdGti				= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
sPos					= ""

/*------------------------------------------------------------------*/
/* Si la garantie est A REGLER ou EN COURS DE REGLEMENT ( COD_ETAT  */
/* = 500, COD_ETAT = 550 ), on va calculer les différents montants  */
/* pour la garantie.                                                */
/*------------------------------------------------------------------*/
If	lCodEtatGarantie = 500 Or lCodEtatGarantie = 550	Then
/*------------------------------------------------------------------*/
/* On arme la zone ALT_PLAF à NON. (Et ce dans tous les cas, cette  */
/* zone peut trés bien être positionnée dans une première           */
/* validation (1 Détail Plafonné) en repositionnée à NON dans une   */
/* seconde validation ( 1 Détail forcé avec ALT_REG).               */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* La zone ALT_PLAF ne sera armée que sur les différents calculs    */
/* des plafonds.                                                    */
/*------------------------------------------------------------------*/
	idw_wGarSin.SetItem ( 1, "ALT_PLAF", "N" )
/*------------------------------------------------------------------*/
/* Si il existe au moins un détail avec un code état A REGLER       */
/* (COD_ETAT = 500) et ALT_REG = "O"                                */
/*------------------------------------------------------------------*/
	If Uf_Determiner_Etat_Detail ( 11 )	Then
/*------------------------------------------------------------------*/
/* On procéde au calcul des différents montants.                    */
/*------------------------------------------------------------------*/
		Uf_Calculer_Montant_Detail ( 1 )
	Else
/*------------------------------------------------------------------*/
/* Il n'existe aucun détail A REGLER avec ALT_REG à OUI.            */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On vérifie si la nature de sinistre, la territorialité et de     */
/* détail de sinistre autorisent d'effectuer un règlement. Si ce    */
/* n'est pas le cas, on affiche un message au gestionnaire et on    */
/* arrete le contrôle.                                              */
/*------------------------------------------------------------------*/
		If	Not Uf_Verifier_Condition_Reg ()	Then
			sPos = "MT_PROV"
		Else
/*------------------------------------------------------------------*/
/* On va calculer la date de 1ère utilisation frauduleuse.          */
/*------------------------------------------------------------------*/
			Uf_Calculer_Dt_1er_Uf ()
/*------------------------------------------------------------------*/
/* On procéde au calcul des différents montants.                    */
/*------------------------------------------------------------------*/
			Uf_Calculer_Montant_Detail ( 2 )

/*------------------------------------------------------------------*/
/* On calcule les plafonds.                                         */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On positionne la zone ALT_BOUGE de DW_PPLAFOND_GTI à             */
/* (S)upprime. Cela va nous permettre de savoir si on vient de      */
/* toucher aux plafonds. On optimise ainsi les commandes SQL.       */
/*------------------------------------------------------------------*/
			lTotPlafond = idw_wPPlafond_Gti.RowCount ()
			For	lCpt = 1 To lTotPlafond
					idw_wPPlafond_Gti.SetItem ( lCpt, "ALT_BOUGE", "S" )
			Next

			// [PLAF_REF]
			If sPos = "" Then sPos = Uf_Plaf_Sin ()
			// [PLAF_REF]


			If sPos = "" Then sPos = Uf_Plaf_Adhesion_Survenance ()
			If sPos = "" Then sPos = Uf_Plaf_Adherent_Survenance ()
			If sPos = "" Then sPos = Uf_Plaf_Adhesion_Renouvellement ()
			
			// [PC13321]
			If sPos = "" Then sPos = Uf_Plaf_Adhesion_Renouvellement_proddms ()
			
			If sPos = "" Then sPos = Uf_Plaf_Adherent_Renouvellement ()
/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
			If sPos = "" Then sPos = Uf_Plaf_NbSin_Adhesion_Survenance ()
			If sPos = "" Then sPos = Uf_Plaf_NbSin_Adherent_Survenance ()
			If sPos = "" Then sPos = Uf_Plaf_NbSin_Adhesion_Renouvellement ()
			If sPos = "" Then sPos = Uf_Plaf_NbSin_Adherent_Renouvellement ()

			// [VDOC11880]
			If sPos = "" Then sPos = Uf_Plaf_NbSin_Adhesion_Renouv_dte_surv ()
			
/*------------------------------------------------------------------*/
/* #2 CAG 14/06/2004                                                */
/*------------------------------------------------------------------*/
			If sPos = "" Then sPos = Uf_Plaf_Adhesion_Annee_Civile ()
			If sPos = "" Then sPos = Uf_Plaf_Adherent_Annee_Civile ()

			// [VDOC24781]
			If sPos = "" Then sPos = Uf_Plaf_Adhesion_Annee_Civile_tt_gti ()
			
// [PC845_NOUVPLAF]
			If sPos = ""	Then sPos = Uf_Plaf_Adhesion_Annee_Civile_val_achat ()
			If sPos = ""	Then sPos = Uf_Plaf_Adherent_Annee_Civile_val_achat ()

// [PC845_NOUVPLAF741]
			If sPos = ""	Then sPos = This.Uf_Plaf_Evt1397_regle_resil_adh ()

//* #4 [DCMP080377]
			If sPos = "" Then sPos = Uf_Plaf_NbSin_Adhesion_Annee_Civile ()
			If sPos = "" Then sPos = Uf_Plaf_NbSin_Adherent_Annee_Civile ()
//* :#4 [DCMP080377]

/*------------------------------------------------------------------*/
/* #3 JFF 06/12/2004                                                */
/*------------------------------------------------------------------*/
			If sPos = "" Then sPos = uf_Plaf_Client_Physique_Annee_Civile ()
			If sPos = "" Then sPos = uf_Plaf_Produit_Annee_Civile ()

// [DCMP100220]
			If sPos = "" Then sPos = Uf_Plaf_NbSin_Adhesion ()
			If sPos = "" Then sPos = Uf_Plaf_NbSin_Adherent ()
// :[DCMP100220]

// [DCMP100410]
		If sPos = "" Then sPos = Uf_Plaf_NbGti_adhesion_par_surv( )
		If sPos = "" Then sPos = Uf_Plaf_NbGti_adherent_par_surv( )
// :[DCMP100410]

// [PC397][PC441][PC443]
		If sPos = "" Then sPos = Uf_Plaf_NbGti_Pec_adhesion_par_surv( )
		If sPos = "" Then sPos = Uf_Plaf_NbGti_Pec_adherent_par_surv( )
// [PC397][PC441][PC443]

		//  [PLAf_REF] plaf 723
		If sPos = "" Then sPos = Uf_Plaf_NbSin_numport_annee_civile( )

		//  [PLAf_REF] 724 et 725
		If sPos = "" Then sPos = Uf_Plaf_NbGti_adhesion ( )
		If sPos = "" Then sPos = Uf_Plaf_NbGti_adherent ( )

// [PC581].[POINT155][VDOC5984]
		If sPos = "" Then sPos = Uf_Plaf_NbSinGti_Adhesion_Survenance ()
		If sPos = "" Then sPos = Uf_Plaf_NbSinGti_Adherent_Survenance ()
		If sPos = "" Then sPos = Uf_Plaf_NbSinGti_Adhesion_Renouvellement ()
		If sPos = "" Then sPos = Uf_Plaf_NbSinGti_Adherent_Renouvellement ()

// [VDOC7410]
		If sPos = "" Then sPos = uf_plaf_adherent_gti ()
		If sPos = "" Then sPos = uf_plaf_adhesion_gti ()
// [VDOC7410]

// [PC877]
If sPos = "" Then sPos = Uf_Plaf_Adhesion_Survenance_TteGti ()
If sPos = "" Then sPos = Uf_Plaf_Adherent_Survenance_TteGti ()
If sPos = "" Then sPos = Uf_Plaf_Adhesion_Renouvellement_TteGti ()
If sPos = "" Then sPos = Uf_Plaf_Adherent_Renouvellement_TteGti ()
If sPos = "" Then sPos = Uf_Plaf_Siren_Adh_Renouv_TteGti	()			
// [PC877]

// [PC801-5]
If sPos = "" Then sPos = Uf_Plaf_NbSin_Adhesion_Survenance_Resil ( "REFUS" )

// [DT162]
If sPos = "" Then sPos = Uf_Plaf_Adhesion_Renouvellement_TtGti_mp ()
If sPos = "" Then sPos = Uf_Plaf_NbSin_Adhesion_Renou_dte_surv_mp ()

// [PC192235]
If sPos = "" Then sPos = Uf_Plaf_Adhesion_Renouvellement_PrGti_mp ()
If sPos = "" Then sPos = Uf_Plaf_NbGti_Adhesion_Renou_dte_surv_mp ()

// [VDOC25099]
If sPos = "" Then sPos = Uf_Plaf_NbSin_Adhesion_Surv_gliss_mp () 

// [VDOC19467]
If sPos = "" Then sPos = uf_plaf_nbsin_numport_adhesion ()

// [PC171999]
If sPos = "" Then sPos = Uf_Plaf_Adhesion_Renouv_TypePers ()

// [PC202551_PLAF_759]
If sPos = "" Then sPos = Uf_Plaf_Adhesion_Survenance_GtiDp351 ()	

// [DT509]
If sPos = "" Then sPos = Uf_Plaf_NbSinRgl_Adhesi_Renouv_splref611 ()

// [VDOC29786]
If sPos = "" Then sPos = Uf_Plaf_NbSin_Adhesion_annee_civile_gti ()

// [PLAFOND762_ISM215077]
If sPos = "" Then sPos = uf_plaf_adhesion_survenance_ttegti_mp ()

// [MIG147_KRYS]
If F_CLE_A_TRUE ( "MIG147_KRYS" ) Then
	If sPos = "" Then sPos = Uf_Plaf_KRYS_CDL_MT_SPEC_SI_NB_SUP_1_SIN ()	
End If

/*------------------------------------------------------------------*/
/* On calcule une franchise éventuelle.                             */
/*------------------------------------------------------------------*/
			Uf_Fran_Fixe ()

		End If
	End If
Else

/*------------------------------------------------------------------*/
/* Modification DBI le 18/08/1998                                   */
/*                                                                  */
/* Reinitialisation des zones de montants à régler si la garantie   */
/* ne fait l'objet d'aucun règlement                                */
/*------------------------------------------------------------------*/

	idw_wGarSin.SetItem ( 1, "MT_PREJ_AREG" , 0 )
	idw_wGarSin.SetItem ( 1, "MT_FRAN_AREG" , 0 )
	idw_wGarSin.SetItem ( 1, "MT_NPLAF_AREG", 0 )
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG" , 0 )

/*------------------------------------------------------------------*/
/* Le 01/06/1999.                                                   */
/* Modif DGA. La zone MT_TOT_PREJ n'est pas recalculée dans le cas  */
/* ou la garantie ne posséde pas un COD_ETAT = 500, 550. C'est une  */
/* erreur. Il faut calculer MT_TOT_PREJ dans tous les cas. (SANS    */
/* SUITE/REFUSE/EN ATTENTE Etc..)                                   */
/*------------------------------------------------------------------*/
	lTotDetail = idw_LstDetail.RowCount ()
	For	lCpt = 1 To lTotDetail
			dcMtTotPrej += idw_LstDetail.GetItemDecimal ( lCpt, "MT_PREJ" )
	Next
	idw_wGarSin.SetItem ( 1, "MT_TOT_PREJ", dcMtTotPrej )

End If

// [VDOC24658]
F_RechDetPro(lDeb, lFin, idw_detpro, idw_produit.getItemNumber(1,"ID_PROD"),"-DP", 320)
If lDeb > 0 And lIdGti = 39 And lCodEtatGarantie = 500 Then
	stMessage.sCode = "WGAR117"
	stMessage.icon  = Information!
	stMessage.bErreurG = False
	stMessage.bouton = Ok!
	F_Message ( stMessage )		
End If

// [DT352]
If idw_Plafond.Find ( "ID_TYP_PLAF = '682' AND ID_GTI = 7", 1, idw_Plafond.RowCount () ) > 0 And &
	lIdGti = 7 Then
	stMessage.sTitre = "DT352"
	stMessage.sCode = "WGAR118"
	stMessage.icon  = Information!
	stMessage.bErreurG = False
	stMessage.bouton = Ok!
	F_Message ( stMessage )		
End If

// [VDOC26121]
F_RechDetPro(lDeb, lFin, idw_detpro, idw_produit.getItemNumber(1,"ID_PROD"),"-DP", 328)
If lDeb > 0 And lIdGti = 1 And lCodEtatGarantie = 500 Then
	stMessage.sTitre = "VDOC26121"
	stMessage.sCode = "WGAR119"
	stMessage.icon  = Information!
	stMessage.bErreurG = False
	stMessage.bouton = Ok!
	F_Message ( stMessage )		
End IF

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

Date dDteDet, dDteMini

dDteMini 	= stNul.Dat
lTotDetail	= idw_LstDetail.RowCount ()

/*------------------------------------------------------------------*/
/* Le 27/05/1999.                                                   */
/* Modif DGA. Gestion des UF Téléphone Mobile.                      */
/*------------------------------------------------------------------*/
lIdGti = idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
If lIdGti = 7 Or lIdGti = 8 Then
	For	lCpt = 1 To lTotDetail
/*------------------------------------------------------------------*/
/* On calcule la plus petite date de tous les détails, qui ne sont  */
/* pas SANS SUITE.                                                  */
/*------------------------------------------------------------------*/
			If	idw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" ) <> 900	Then

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

idw_wGarSin.SetItem ( 1, "DTE_1ER_UF", datetime(dDteMini) ) // [PI056]
end subroutine

private subroutine uf_fran_fixe ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Fran_Fixe (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Application d'une franchise éventuelle pour la garantie
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Franchise paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//* #2	 CAG	  25/06/2004  DCMP 040297
//*-----------------------------------------------------------------

Long lTotFranchise, lLig, lDelai, lCpt, lLigFinale, lCptTypFra
String sRech, sIdPara, sCptVer, sIdNivFra, sIdRefFra, sIdTypFra
Decimal {2} dcMtFran, dcMtFranaReg, dcMtPlafaReg, dcFranSav, dcFranTmp
Date dDte1erUf, dDteOppo

lTotFranchise	= idw_Franchise.RowCount ()
dcMtFran			= 0
dcFranSav = 0
dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 1 to 4

	Choose Case lCpt
		Case 1
			sIdNivFra = "-GA"  // Garantie
			sIdRefFra = "-1"
		Case 2
			sIdNivFra = "+NS"  // Nature de sinistre
			sIdRefFra = String ( idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) )
		Case 3
			sIdNivFra = "+TR"  // Territorialité
			sIdRefFra = String ( idw_wSin.GetItemNumber ( 1, "ID_TERRIT" ) )
		Case 4
			sIdNivFra = "+DT"  // Détail
			sIdRefFra = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )

	End Choose

	If IsNull ( sIdRefFra ) Then Continue

	For lCptTypFra = 1 to 2

		Choose Case lCptTypFra
			Case 1
				sIdTypFra = "1"
			Case 2
				sIdTypFra = "3"
		End Choose

		/*------------------------------------------------------------------*/
		/* On vérifie s'il existe un plafond										  */
		/*------------------------------------------------------------------*/
		sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
						"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
						"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
						"ID_NIV_FRA = '"  + sIdNivFra 																+ "' AND " 	+ &
						"ID_REF_FRA = "	+ sIdRefFra 																+ " AND " 	+ &
						"ID_TYP_FRA = "	+ sIdTypFra

		lLig = idw_Franchise.Find ( sRech, 1, lTotFranchise	)

		If lLig > 0 Then	

			dcFranTmp		= idw_Franchise.GetItemDecimal ( lLig, "MT_FRA" )

			/*------------------------------------------------------------------*/
			/* #2 CAG 25/06/2004 : franchise par pourcentage                    */
			/*------------------------------------------------------------------*/
			If sIdTypFra = "3" Then
				dcFranTmp = dcMtPlafAReg * dcFranTmp
			End If

			If dcFranSav <> 0 Then

				// On garde la plus grande franchise, contrairement au plafond
				If dcFranTmp > dcFranSav Then 
					dcFranSav = dcFranTmp 
					lLigFinale = lLig
				End If

			Else
				dcFranSav = dcFranTmp 
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
/* On vient de trouver la franchise.                                */
/*------------------------------------------------------------------*/
If	lLig > 0 Then
	Choose Case idw_Franchise.GetItemNumber ( lLig, "ID_TYP_FRA" )
	Case 1
/*------------------------------------------------------------------*/
/* Il faut appliquer une franchise fixe, une seule fois.            */
/*------------------------------------------------------------------*/
		dcMtFran = idw_Franchise.GetItemDecimal ( lLig, "MT_FRA" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de franchise dans la DW uniquement si    */
/* le montant est supérieur à zéro.                                 */
/*------------------------------------------------------------------*/
		If	dcMtFran > 0 Then
			sIdPara	= idw_Franchise.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Franchise.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "1", sIdPara, sCptVer )
		End If

	Case 2
/*------------------------------------------------------------------*/
/* Cette franchise ne doit concerner que la garantie Utilisations   */
/* Frauduleuses. On va calculer le délai entre la date de 1er UF    */
/* et la date d'opposition. On récupérera le montant de la          */
/* franchise en fonction de ce délai.                               */
/*------------------------------------------------------------------*/
		dDte1erUf	= Date(idw_wGarSin.GetItemDateTime ( 1, "DTE_1ER_UF" )) // [PI056]
		dDteOppo		= idw_wGarSin.GetItemDate ( 1, "DTE_OPPO_DATE" )

		If	Not IsNull ( dDte1erUf ) And Not IsNull ( dDteOppo )	Then
/*------------------------------------------------------------------*/
/* La date de 1er Uf est forcément plus petite (ou égale) à la      */
/* date d'opposition. (Sinon Refus 633 ou cas d'un détail forcé en  */
/* réglement qui ne passe pas le calcul de la franchise).           */
/*------------------------------------------------------------------*/

			lDelai = DaysAfter ( dDte1erUf, dDteOppo )

			sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
							"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
							"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
							"ID_NIV_FRA = '-GA'" 																			+ " AND " 	+ &
							"ID_REF_FRA = -1"																					+ " AND " 	+ &
							"ID_TYP_FRA = 2"																					+ " AND " 	+ &
							"DUR_MIN <= "		+ String ( lDelai )														+ " AND " 	+ &
							"DUR_MAX >= "		+ String ( lDelai )

/*------------------------------------------------------------------*/
/* On doit forcément trouver une franchise.                         */
/*------------------------------------------------------------------*/
			lLig = idw_Franchise.Find ( sRech, 1, lTotFranchise )

			dcMtFran = idw_Franchise.GetItemDecimal ( lLig, "MT_FRA" )			
/*------------------------------------------------------------------*/
/* On insére le paragraphe de franchise dans la DW uniquement si    */
/* le montant est supérieur à zéro.                                 */
/*------------------------------------------------------------------*/
			If	dcMtFran > 0 Then
				sIdPara	= idw_Franchise.GetItemString ( lLig, "ID_PARA" )
				sCptVer	= idw_Franchise.GetItemString ( lLig, "CPT_VER" )
				Uf_Plaf_EcrirePara ( "2", sIdPara, sCptVer )
			End If
		End If

		Case 3
			dcMtFran = idw_Franchise.GetItemDecimal ( lLig, "MT_FRA" )
			dcMtFran = dcMtPlafAReg * dcMtFran
	End Choose
End If

/*------------------------------------------------------------------*/
/* On recalcule les différents montants pour la garantie.           */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Selon St Denis, si on obtient une valeur de franchise négative,  */
/* on force la franchise à zéro sans rien afficher.                 */
/* NB : Le montant de la franchise peut devenir négatif si on       */
/* change le paramètrage entre deux validations.                    */
/*------------------------------------------------------------------*/
dcMtFranaReg	= dcMtFran - idw_wGarSin.GetItemDecimal ( 1, "MT_FRAN_REG" )
If	dcMtFranaReg < 0	Then	dcMtFranaReg = 0

/*------------------------------------------------------------------*/
/*                                                                  */
/* Modification DBI le 12/08/1998                                   */
/*                                                                  */
/*                                                                  */
/* Suite à un problème sur SIMPA1 et une confirmation de la part    */
/*                                                                  */
/* de C.Villette et de C.Chanal ( les produits concernés étant      */
/*                                                                  */
/* Protécarte, carte affaire BNP, garantie 24 et GA Sérénicarte ),  */
/*                                                                  */
/* la franchise ne doit pas s'appliquer avant les éventuels         */
/*                                                                  */
/* plafonds mais après.                                             */
/*                                                                  */
/*                                                                  */
/*  Ex :                                                            */
/* Mt prej 32000, plafond 30000 et franchise 2400 on règlera        */
/* 27600 et non pas 29600                                           */
/*                                                                  */
/* MT_NPLAF_AREG est donc armé maintenant dans                      */
/* uf_calculer_montant_detail et l'appel de uf_fran_fixe a été      */
/* déplacé après celui des fonctions relatives aux calculs de       */
/* plafond.                                                         */
/*------------------------------------------------------------------*/
dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) - dcMtFranaReg

/*------------------------------------------------------------------*/
/* Le 05/04/1999.                                                   */
/* Le montant du sinistre peut devenir négatif. On rajoute le test  */
/* suivant. Si le montant Plafonné A REGLER est négatif, on arme    */
/* ce montant à zéro. De plus on arme le montant de la Franchise A  */
/* REGLER avec le montant plafonné A REGLER.                        */
/*------------------------------------------------------------------*/
If	dcMtPlafaReg < 0	Then
	dcMtPlafaReg = 0
	dcMtFranaReg = 0
End If

/*------------------------------------------------------------------*/
/* On positionne les valeurs dans la DW et on va commencer le       */
/* calcul des différents plafonds.                                  */
/*------------------------------------------------------------------*/
idw_wGarSin.SetItem ( 1, "MT_FRAN_AREG",		dcMtFranaReg )
idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG",		dcMtPlafaReg )


end subroutine

private subroutine uf_preparersupprimer (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Garantie::Uf_PreparerSupprimer
//* Auteur			: Erick John Stark
//* Date				: 28/01/1998 09:42:07
//* Libellé			: 
//* Commentaires	: On veut supprimer une garantie
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sFiltre
Long lCpt, lTotSupp, lIdGti, lTotwDetail, lTotwPiece, lTotwRefus, lTotwParaPlafond
Integer iRet

/*------------------------------------------------------------------*/
/* On vérifie si on se trouve sur l'onglet N° 01. (Onglet Garantie).*/
/* On affiche un message qui demande si on veut supprimer la        */
/* garantie courante.                                               */
/*------------------------------------------------------------------*/
If	iuoOng.Uf_RecupererOngletCourant () <> "01" Then
	iuoOng.Uf_ChangerOnglet ( "01" )
End If

stMessage.sTitre		= "Suppression d'une garantie"
stMessage.Icon			= Information!
stMessage.sVar[1] 	= "la garantie "
stMessage.bouton	 	= YesNo!
stMessage.bErreurG	= FALSE
stMessage.sCode		= "GENE020"

iRet = F_Message ( stMessage )
/*------------------------------------------------------------------*/
/* Si on ne veut pas supprimer l'enregistrement, on s'arrete.       */
/*------------------------------------------------------------------*/
If	iRet = 2 Then
	astPass.bRetour = False
Else

/*------------------------------------------------------------------*/
/* Il faut maintenant enlever les lignes du buffer DELETE! qui      */
/* peuvent être impactées.                                          */
/* L'utilisateur a changé une première fois les lignes avant de     */
/* vouloir supprimer la garantie.                                   */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On s'occupe des détails.                                         */
/*------------------------------------------------------------------*/
	lTotSupp = idw_wDetail.DeletedCount ()

	For	lCpt = lTotSupp To 1 Step -1
			lIdGtI = idw_wDetail.GetItemNumber ( lCpt, "ID_GTI", Delete!, False )

			If	lIdGti = idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) Then
				idw_wDetail.RowsDiscard ( lCpt, lCpt, Delete! )
			End If
	Next

/*------------------------------------------------------------------*/
/* On veut supprimer une garantie, il faut optimiser les commandes  */
/* DELETE qui partent sur le moteur. La commande DELETE sur la      */
/* garantie supprime aussi les tables dépendantes (W_DETAIL,        */
/* W_PIECE, W_REFUS), donc il ne faut pas envoyer de DELETE par la  */
/* suite sur ces tables.                                            */
/*------------------------------------------------------------------*/

	sFiltre = "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )

	idw_wDetail.SetFilter ( sFiltre )
	idw_wDetail.Filter ()
	lTotwDetail = idw_wDetail.RowCount ()

	idw_wDetail.RowsDiscard ( 1, lTotwDetail, Primary! )

	sFiltre = ""
	idw_wDetail.SetFilter ( sFiltre )
	idw_wDetail.Filter ()


/*------------------------------------------------------------------*/
/* On s'occupe des pièces.                                          */
/*------------------------------------------------------------------*/
	lTotSupp = idw_wPiece.DeletedCount ()

	For	lCpt = lTotSupp To 1 Step -1
			lIdGtI = idw_wPiece.GetItemNumber ( lCpt, "ID_GTI", Delete!, False )

			If	lIdGti = idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) Then
				idw_wPiece.RowsDiscard ( lCpt, lCpt, Delete! )
			End If
	Next

/*------------------------------------------------------------------*/
/* On veut supprimer une garantie, il faut optimiser les commandes  */
/* DELETE qui partent sur le moteur. La commande DELETE sur la      */
/* garantie supprime aussi les tables dépendantes (W_DETAIL,        */
/* W_PIECE, W_REFUS), donc il ne faut pas envoyer de DELETE par la  */
/* suite sur ces tables.                                            */
/*------------------------------------------------------------------*/

	sFiltre = "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )

	idw_wPiece.SetFilter ( sFiltre )
	idw_wPiece.Filter ()
	lTotwPiece = idw_wPiece.RowCount ()

	idw_wPiece.RowsDiscard ( 1, lTotwPiece, Primary! )

	sFiltre = ""
	idw_wPiece.SetFilter ( sFiltre )
	idw_wPiece.Filter ()


/*------------------------------------------------------------------*/
/* On s'occupe des refus.                                           */
/*------------------------------------------------------------------*/
	lTotSupp = idw_wRefus.DeletedCount ()

	For	lCpt = lTotSupp To 1 Step -1
			lIdGtI = idw_wRefus.GetItemNumber ( lCpt, "ID_GTI", Delete!, False )

			If	lIdGti = idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) Then
				idw_wRefus.RowsDiscard ( lCpt, lCpt, Delete! )
			End If
	Next

/*------------------------------------------------------------------*/
/* On veut supprimer une garantie, il faut optimiser les commandes  */
/* DELETE qui partent sur le moteur. La commande DELETE sur la      */
/* garantie supprime aussi les tables dépendantes (W_DETAIL,        */
/* W_PIECE, W_REFUS), donc il ne faut pas envoyer de DELETE par la  */
/* suite sur ces tables.                                            */
/*------------------------------------------------------------------*/

	sFiltre = "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )

	idw_wRefus.SetFilter ( sFiltre )
	idw_wRefus.Filter ()
	lTotwRefus = idw_wRefus.RowCount ()

	idw_wRefus.RowsDiscard ( 1, lTotwRefus, Primary! )

	sFiltre = ""
	idw_wRefus.SetFilter ( sFiltre )
	idw_wRefus.Filter ()

/*------------------------------------------------------------------*/
/* On s'occupe des plafonds.                                        */
/*------------------------------------------------------------------*/
	lTotSupp = idw_wParaPlafond.DeletedCount ()

	For	lCpt = lTotSupp To 1 Step -1
			lIdGtI = idw_wParaPlafond.GetItemNumber ( lCpt, "ID_GTI", Delete!, False )

			If	lIdGti = idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) Then
				idw_wParaPlafond.RowsDiscard ( lCpt, lCpt, Delete! )
			End If
	Next

/*------------------------------------------------------------------*/
/* On veut supprimer une garantie, il faut optimiser les commandes  */
/* DELETE qui partent sur le moteur. La commande DELETE sur la      */
/* garantie supprime aussi les tables dépendantes (W_DETAIL,        */
/* W_PIECE, W_REFUS, W_PARA_PLAFOND), donc il ne faut pas envoyer   */
/* de DELETE par la suite sur ces tables.                           */
/*------------------------------------------------------------------*/
	sFiltre = "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )

	idw_wParaPlafond.SetFilter ( sFiltre )
	idw_wParaPlafond.Filter ()
	lTotwParaPlafond = idw_wParaPlafond.RowCount ()

	idw_wParaPlafond.RowsDiscard ( 1, lTotwParaPlafond, Primary! )

	sFiltre = ""
	idw_wParaPlafond.SetFilter ( sFiltre )
	idw_wParaPlafond.Filter ()

/*------------------------------------------------------------------*/
/* On supprime toutes les commandes non liées à la garantie.        */
/*------------------------------------------------------------------*/
	This.uf_PreparerSupprimer_Commande ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ))
	This.uf_PreparerSupprimer_OngDivers ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ))

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
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//       JFF   16/11/2015 [DT159-1]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale , lCptMax, lDeb, lFin
Decimal {2} dcPlafond, dcMtPlafaReg, dcMtPlafReg, dcPlafSav, dcPlafTmp, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdsDos
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
For lCpt = 1 to 4

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
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdsDos		= idw_wSin.GetItemNumber ( 1, "ID_SDOS" )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
   sUntPerRnv_Adh		   = idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
/*----------------------------------------------------------------------*/
/* On calcule la date du dernier renouvellement.                        */
/* En fonction de l'unité de période de renouvellement (ANNEE,MOIS,JOUR)*/
/*----------------------------------------------------------------------*/
Choose Case sUntPerRnv_Adh
	   Case "A"
	     lCptMax = 30
	   Case "M"
	     lCptMax = 360
	   Case "J"
	    lCptMax = 10950
End Choose  

For lCpt = 1 To lCptMax
	dDteResult = F_Plus_Date ( dDteAdh, dcDurPerRnv_Adh, sUntPerRnv_Adh )
	If	dDteResult <= idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )	Then
		dDteAdh = dDteResult
	Else
		Exit
	End If
Next

	dtDteAdhRenouv = DateTime ( dDteAdh )
	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S04_W_GTI_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, dcIdGti, dtDteSurv, dtDteAdhRenouv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S04_W_GTI_MT_PLAF" )	Then 
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
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG" )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond	Then
			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) )
				
				// [PLAF_REF] // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "694", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "694", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "694", sIdPara, sCptVer )
		End If
	End If

End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )	

end function

private function string uf_plaf_adherent_survenance ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adherent_Survenance (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Application d'un plafond par adhésion/Année survenace glissante
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//       JFF   16/11/2015 [DT159-1]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale, lDeb, lFin
Decimal {2} dcPlafond, dcMtPlafaReg, 	dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdsDos
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
n_cst_string lnvPFCString
// [DCMP050255]
long lLig706, lTotDetail, lLigDet
Decimal{2} dcPlafond706

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 1 to 4

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
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdsDos		= idw_wSin.GetItemNumber ( 1, "ID_SDOS" )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

/*------------------------------------------------------------------*/
/* [DCMP050255] 29/06/2006 PHG : Ajout du plafond par Adherent 706  */
/*------------------------------------------------------------------*/
	
	sRech	=		"ID_PROD = "				+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "					+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "					+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '-GA'" 																					+ " AND " 	+ &
					"ID_REF_PLAF = -1"																						+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																						+ " AND " 	+ &
					"ID_TYP_PLAF = '706'"

	lLig706 = idw_Plafond.Find ( sRech, 1, lTotPlaf )
	dcPlafond706 = 0
	If	lLig706 > 0 Then
		sRech 		= "ID_TYPE_CARTE = 'C5' And ( COD_ETAT = 500 Or COD_ETAT = 600 Or COD_ETAT = 200 Or COD_ETAT = 100 )"
		lTotDetail 	= idw_LstDetail.RowCount ()
		lLigDet		= idw_LstDetail.Find ( sRech, 1, lTotDetail )
		If	lLigDet > 0 Then
			dcPlafond706 = idw_Plafond.GetItemDecimal ( lLig706, "MT_PLAF" )
		End If
	End If
	
//-- fin DCMP050255
		
	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S02_W_GTI_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, dcIdGti, dtDteSurv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S02_W_GTI_MT_PLAF" )	Then 
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
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG"  )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond + dcPlafond706	Then // DCMP 050255 : Prise en compte plafond 706
			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", ( dcPlafond + dcPlafond706 ) - ( dcMtPlafReg + dcMtAutreSinistre ) )
				
				// [PLAF_REF] // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "692", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )

				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "692", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "692", sIdPara, sCptVer )

		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
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
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//       JFF   16/11/2015 [DT159-1]
//*-----------------------------------------------------------------
Long lTotPlaf, lLig, lCpt, lLigFinale, lCptMax, lDeb, lFin
Decimal {2} dcPlafond, dcMtPlafaReg, dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh
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
For lCpt = 1 to 4

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
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
   sUntPerRnv_Adh		   = idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
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

	dtDteAdhRenouv = DateTime ( dDteAdh )
	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S03_W_GTI_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, dtDteSurv, dtDteAdhRenouv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S03_W_GTI_MT_PLAF" )	Then 
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
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG" )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond	Then
			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) )
				
				// [PLAF_REF]  // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "693", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "693", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "693", sIdPara, sCptVer )
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
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
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//* #2	 JFF	  22/03/2005  DCMP 050003.
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF	  29/05/2012  [VDOC6662]
//        JFF   16/11/2015   [DT159-1]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale, lLig701, lDeb, lFin
Decimal {2} dcPlafond, dcMtPlafaReg, 	dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcPlafond701, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, lTotDetail, lLigDet
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
For lCpt = 1 to 4

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
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	
	sRech	=		"ID_PROD = "				+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "					+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "					+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '-GA'" 																					+ " AND " 	+ &
					"ID_REF_PLAF = -1"																						+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																						+ " AND " 	+ &
					"ID_TYP_PLAF = '701'"

	lLig701 = idw_Plafond.Find ( sRech, 1, lTotPlaf )
	dcPlafond701 = 0
	If	lLig701 > 0 Then
		sRech 		= "ID_TYPE_CARTE = 'C5' And ( COD_ETAT = 500 Or COD_ETAT = 600 Or COD_ETAT = 200 Or COD_ETAT = 100 )"
		lTotDetail 	= idw_LstDetail.RowCount ()
		lLigDet		= idw_LstDetail.Find ( sRech, 1, lTotDetail )
		If	lLigDet > 0 Then
			dcPlafond701 = idw_Plafond.GetItemDecimal ( lLig701, "MT_PLAF" )
		End If
	End If
				
	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S01_W_GTI_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, dtDteSurv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S01_W_GTI_MT_PLAF" )	Then 
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
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG"  )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If


		If	dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond + dcPlafond701 Then
			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", ( dcPlafond + dcPlafond701 ) - ( dcMtPlafReg + dcMtAutreSinistre ) )
				
				// [PLAF_REF] // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "691", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "691", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "691", sIdPara, sCptVer )

		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )
	

end function

private function string uf_gestioncptiareg ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GestionCptiAreg (PRIVATE)
//* Auteur			: DBI
//* Date				: 18/08/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Calcul du nombre d'interlocuteurs à régler 
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------


String		sRet = ""

Integer		iIdIReg[], iCptInter

Decimal {0}	dcCptiAReg, dcIdGti

Long			lNbDet, lCpt

Boolean		bTrouve

dcCptiAreg = 0

/*------------------------------------------------------------------*/
/* On n'effectue le calcul que si la garantie fait l'objet d'un     */
/* règlement                                                        */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Je positionne les différents interlocuteurs à régler dans un     */
/* tableau.                                                         */
/* Le Upperbound de ce tableau va me donner le nombre d'inter à     */
/* régler.                                                          */
/*------------------------------------------------------------------*/

If ( idw_wGarSin.GetItemNumber ( 1, "COD_ETAT" ) = 500 ) Or &
   ( idw_wGarSin.GetItemNumber ( 1, "COD_ETAT" ) = 550 ) Then

	dcIdGti	= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	lNbDet	= idw_LstDetail.RowCount ( )

	For lCpt = 1 To lNbDet

		If ( iDw_LstDetail.GetItemNumber ( lCpt, "ID_GTI"   ) = dcIdGti ) And &
			( iDw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" ) = 500   ) Then

			bTrouve = False

			For iCptInter = 1 To UpperBound ( iIdIReg )

/*------------------------------------------------------------------*/
/* Si l'interlocuteur existe déjà dans le tableau on arrête  la     */
/* recherche                                                        */
/*------------------------------------------------------------------*/

				If ( iIdIReg [ iCptInter ] = iDw_LstDetail.GetItemNumber ( lCpt, "ID_I_REG" ) ) Then

					bTrouve = True
					Exit
				End If
			Next		

/*------------------------------------------------------------------*/
/* Si on n'a pas trouvé l'interlocuteur dans le tableau on          */
/* l'ajoute à la fin                                                */
/*------------------------------------------------------------------*/

			If Not bTrouve Then

				iIdIReg [ UpperBound ( iIdIReg ) + 1 ] = iDw_LstDetail.GetItemNumber ( lCpt, "ID_I_REG" )
			End If
		End If
	Next
End If

dcCptiAReg	= UpperBound ( iIdIReg )

idw_wGarSin.SetItem ( 1, "CPT_I_AREG", dcCptiAReg )

/*------------------------------------------------------------------*/
/* Si le nombre d'interlocuteurs à régler est > 1 et que le         */
/* montant à régler sur la garantie est plafonné, il nous est       */
/* impossible de faire la répartirion des montants par              */
/* interlocuteur.                                                   */
/*                                                                  */
/* La gestion doit donc forcer les détails ou corriger sa saisie.   */
/*------------------------------------------------------------------*/

If ( dcCptiAReg > 1 ) And ( idw_wGarSin.GetItemString ( 1, "ALT_PLAF" ) = "O" ) Then

	stMessage.sTitre		= "Contrôle de gestion d'une garantie"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "WGAR250"

	F_Message ( stMessage )
	
	sRet	=	"ALT_BLOC"
End If

Return ( sRet )
end function

private function boolean uf_rf_603 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_603 (PRIVATE)
//* Auteur			: DBI
//* Date				: 05/10/1998 15:07:49
//* Libellé			: 
//* Commentaires	: pas de primes perçues
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//	FPI	09/11/2011	[Vdoc5870] Déclenchement autre refus sur clé dans DP29
// JFF   13/06/2023  [EVOL_REFUS_603_PNP] 
//*-----------------------------------------------------------------

Date dDteResil, dDteSurv, dDteFinGti
Long lDeb, lFin
n_cst_string nvString
String sRefus, sCodAdh 

Boolean bRet
Boolean bRefusDeclenche
DateTime dtDt1, dtDt2, dtDt3, dtCreeLe

bRet = True
bRefusDeclenche = False

sRefus = "603"
/*------------------------------------------------------------------*/
/* On déclenche ce motif de refus si la date de fin de garantie     */
/* est connue ( donc adhésion SPB ) et inférieure à la date du      */
/* sinistre.                                                        */
/*------------------------------------------------------------------*/
/* Il ne doit pas y avoir de date de résiliation sans quoi          */
/* s'est le motif 601 qui sera déclenché                            */
/*------------------------------------------------------------------*/

sCodAdh = idw_Produit.GetItemString ( 1, "COD_ADH" ) // [EVOL_REFUS_603_PNP] 
dtCreeLe = idw_Wsin.GetItemDateTime ( 1, "CREE_LE" ) // [EVOL_REFUS_603_PNP] 

dDteFinGti 	= Date(idw_wSin.GetItemDateTime ( 1, "DTE_FIN_GTI" 	)) // [PI056]
dDteResil 	= idw_wSin.GetItemDate ( 1, "DTE_RESIL"   	)
dDteSurv 	= idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE"  )

If	Not isNull ( dDteFinGti )		And	&
	Not isNull ( dDteSurv   )		And	&
	IsNull     ( dDteResil  ) 		Then

	If dDteFinGti < dDteSurv Then

		bRefusDeclenche = True // [EVOL_REFUS_603_PNP] 

/*------------------------------------------------------------------*/
/* L'adhésion est résiliée et la fin de garantie a été atteinte     */
/* avant le sinistre                                                */
/*------------------------------------------------------------------*/
		// 	[Vdoc5870]
		F_RechDetPro(lDeb, lFin, idw_detpro, idw_wSin.GetItemNumber( 1,"ID_PROD"), "-DP", 29)
		If lDeb > 0 Then
			sRefus=nvString.of_getkeyvalue( idw_detpro.GetItemString(lDeb ,"VAL_CAR") , "REFUS", ";")
			If sRefus="" Then sRefus="603"
		End if
		
		bRet = Uf_RF_EcrireRefus ( Long(sRefus) )
		
		//bRet = Uf_RF_EcrireRefus ( 603 )
		// Fin VDoc5870
	End If
End If

// [EVOL_REFUS_603_PNP] 
SQLCA.PS_S_DATE_PIVOT ( "EVOL_REFUS_603_PNP", dtDt1, dtDt2, dtDt3 ) 

If Not bRefusDeclenche 	 And &
	isNull ( dDteFinGti ) And &
	sCodAdh = "1"  		 And &
	dtCreeLe >= dtDt1		 Then
	
	bRefusDeclenche = True // [EVOL_REFUS_603_PNP] 

	// [Vdoc5870]
	F_RechDetPro(lDeb, lFin, idw_detpro, idw_wSin.GetItemNumber( 1,"ID_PROD"), "-DP", 29)
	If lDeb > 0 Then
		sRefus=nvString.of_getkeyvalue( idw_detpro.GetItemString(lDeb ,"VAL_CAR") , "REFUS", ";")
		If sRefus="" Then sRefus="603"
	End if
		
	bRet = Uf_RF_EcrireRefus ( Long(sRefus) )
	
End If 

Return ( bRet )

end function

private subroutine uf_gestion_str2nul ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Sinistre_Garantie::Uf_Gestion_Str2Nul (PRIVATE)
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

String sCol[ 1 ]
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

sCol[  1 ] = "TXT_MESS"

For	lCpt = 1 To lNbrCol
		sVal = Trim ( idw_wGarSin.GetItemString ( 1, sCol[ lCpt ] ) )
		If Len ( sVal ) = 0 Then
			idw_wGarSin.SetItem ( 1, sCol[ lCpt ], stNul.str )
		Else
			idw_wGarSin.SetItem ( 1, sCol[ lCpt ], sVal )
		End If
Next

/*------------------------------------------------------------------*/
/* Si la zone MT_PROV est à NULL, on met la valeur 0. (En effet la  */
/* zone est obligatoire dans la table)                              */
/*------------------------------------------------------------------*/
If	IsNull ( idw_wGarSin.GetItemDecimal ( 1, "MT_PROV" ) ) Then
	idw_wGarSin.SetItem ( 1, "MT_PROV", 0.00 )
End If

/*------------------------------------------------------------------*/
/* Si la zone MT_DEDU_AREG est à NULL, on met la valeur 0. (En      */
/* effet la zone est obligatoire dans la table)                     */
/*------------------------------------------------------------------*/
If	IsNull ( idw_wGarSin.GetItemDecimal ( 1, "MT_DEDU_AREG" ) ) Then
	idw_wGarSin.SetItem ( 1, "MT_DEDU_AREG", 0.00 )
End If

end subroutine

private subroutine uf_gestion_plafond (integer aitype);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Gestion_Plafond (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 22/01/1998 16:31:31
//* Libellé			: 
//* Commentaires	: Gestion des plafonds pour la garantie
//*
//* Arguments		: Integer		aiType			(Val)	Type d'action
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sFiltre
Long lTotPlafond

Choose Case aiType
/*------------------------------------------------------------------*/
/* On est en insertion d'une garantie.                              */
/*------------------------------------------------------------------*/
Case 1
	idw_wPPlafond_Gti.Reset ()

/*------------------------------------------------------------------*/
/* On est en modification d'une garantie.                           */
/*------------------------------------------------------------------*/
Case 2

	idw_wPPlafond_Gti.Reset ()

/*------------------------------------------------------------------*/
/* On insére dans idw_wPPlafond_Gti les plafonds déjà positionnés.  */
/* Pour cela on filtre sur ID_GTI et ID_DETAIL.                     */
/*------------------------------------------------------------------*/
	sFiltre = "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) ) + " AND ID_DETAIL = -1"	

	idw_wParaPlafond.SetFilter ( sFiltre )
	idw_wParaPlafond.Filter ()
	idw_wParaPlafond.Sort ()
	lTotPlafond = idw_wParaPlafond.RowCount ()

	idw_wParaPlafond.RowsCopy ( 1, lTotPlafond, Primary!, idw_wPPlafond_Gti, 1, Primary! )

/*------------------------------------------------------------------*/
/* On enleve le filtre sur idw_wPlafond.                            */
/*------------------------------------------------------------------*/
	sFiltre = ""
	idw_wParaPlafond.SetFilter ( sFiltre )
	idw_wParaPlafond.Filter ()
	idw_wParaPlafond.Sort ()

	idw_wPPlafond_Gti.Sort ()

End Choose
end subroutine

private subroutine uf_preparervalider_plafond (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerValider_Plafond (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Préparation de la validation d'une garantie (Niveau PLAFOND de la Garantie)
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long 			lTotwParaPlafond, lCpt, lTotSupp, lIdGti, lIdDetail, lTotPlafondGti
String		sFiltre

Boolean 		bModif, bMove

bModif		= False
bMove			= True

/*------------------------------------------------------------------*/
/* On s'occupe du transfert des plafonds de la garantie.            */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On va vérifier si on vient de toucher aux plafonds. La DW        */
/* idw_WPPlafond_Gti contient les anciens plafonds (ALT_BOUGE = S)  */
/* (Armement dans Uf_Calcul_MontantRegle () ) et les nouveaux       */
/* plafonds (ALT_BOUGE = O) (Armement dans Uf_Plaf_EcrirePara () ). */
/*------------------------------------------------------------------*/
lTotPlafondGti = idw_wPPlafond_Gti.RowCount ()
For	lCpt = 1 To lTotPlafondGti
		If	idw_wPPlafond_Gti.GetItemString ( lCpt, "ALT_BOUGE" ) = "S"	Then	
			bModif = True
			Exit
		End If
Next

If	bModif	Then
	If	Not astPass.bInsert Then
/*------------------------------------------------------------------*/
/* On a touché aux plafonds. On supprime, en modification tous les  */
/* plafonds.                                                        */
/*------------------------------------------------------------------*/
		sFiltre	= "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) ) + " AND ID_DETAIL = -1"

		idw_wParaPlafond.SetFilter ( sFiltre )
		idw_wParaPlafond.Filter ()
		lTotwParaPlafond = idw_wParaPlafond.RowCount ()
/*------------------------------------------------------------------*/
/* Pour optimiser le DELETE, on va supprimer avec une seule         */
/* commande tous les plafonds de la garantie. (Détail = -1). Il faut*/
/* donc positionne une seule ligne dans le buffer Delete! et faire  */
/* un RowsDiscard sur toutes les autres.                            */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On va d'abord vérifier qu'il n'existe pas une ligne avec le      */
/* même ID_DETAIL dans le buffer Delete!. (Cas possible si la       */
/* personne fait 2 CTL-VAL).                                        */
/*------------------------------------------------------------------*/
		lTotSupp = idw_wParaPlafond.DeletedCount ()

		For	lCpt = 1 To lTotSupp
				lIdGti		= idw_wParaPlafond.GetItemNumber ( lCpt, "ID_GTI", 	Delete!, False )
				lIdDetail	= idw_wParaPlafond.GetItemNumber ( lCpt, "ID_DETAIL", Delete!, False )

				If	lIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) And	&
					lIdDetail	= -1 Then
					bMove = False
					Exit
				End If
		Next
		If	bMove Then
			If	idw_wGarSin.iudwDetailSource.GetItemStatus ( idw_wGarSin.ilLigneDetailSource, 0, Primary! ) = NewModified!	Then
				idw_wParaPlafond.RowsDiscard ( 1, lTotwParaPlafond, Primary! )
			Else
				idw_wParaPlafond.RowsDiscard ( 2, lTotwParaPlafond, Primary! )
				idw_wParaPlafond.RowsMove ( 1, 1, Primary!, idw_wParaPlafond, 1, Delete! )
			End If
		Else
			idw_wParaPlafond.RowsDiscard ( 1, lTotwParaPlafond, Primary! )
		End If

		sFiltre = ""
		idw_wParaPlafond.SetFilter ( sFiltre )
		idw_wParaPlafond.Filter ()
	End If
End If

/*------------------------------------------------------------------*/
/* On insére maintenant tous les nouveaux plafonds.                 */
/*------------------------------------------------------------------*/
sFiltre = "ALT_BOUGE = 'O'"
idw_wPPlafond_Gti.SetFilter ( sFiltre )
idw_wPPlafond_Gti.Filter ()
lTotPlafondGti	= idw_wPPlafond_Gti.RowCount ()
	
If	lTotPlafondGti > 0 Then
	idw_wPPlafond_Gti.RowsMove ( 1, lTotPlafondGti, Primary!, idw_wParaPlafond, 1, Primary! )
End If

sFiltre = ""
idw_wPPlafond_Gti.SetFilter ( sFiltre )
idw_wPPlafond_Gti.Filter ()


end subroutine

private subroutine uf_plaf_ecrirepara (string asidtypplaf, string asidpara, string ascptver);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_EcrirePara (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 23/01/1998 17:40:41
//* Libellé			: 
//* Commentaires	: Insertion du paragraphe de plafond
//*
//* Arguments		: String			asIdTypPlaf		(Val) Identifiant du Type de plafond
//* 					: String			asIdPara			(Val) Identifiant du paragraphe
//* 					: String			asCptVer			(Val) Compteur de révision
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1 DBI le 24/09/1999 : si cod_etat detail 600 + 100 -> cod_etat gti = 500
//*			  	Or dans ce cas aucun détail etat 500 donc Find lstdetail
//*				ramème 0.
//*-----------------------------------------------------------------

Long lLig, lIdSin, lIdGti, lIdDetail, lIdI, lLigDet, lTotDetail
String sRech

// #1 J'ai déplacé la recherche sur idwLstDEtail car si lLigDet = 0
//    on n'insère pas la ligne 
/*------------------------------------------------------------------*/
/* Attention, pour information la zone ID_PARA peut être NULLE.     */
/*------------------------------------------------------------------*/
lTotDetail	= idw_LstDetail.RowCount ()
sRech 		= "( COD_ETAT = 500 Or COD_ETAT = 550 Or COD_ETAT = 600 ) And ALT_VALIDE = 'O'"

lLigDet		= idw_LstDetail.Find  ( sRech, 1, lTotDetail )

lIdSin		= idw_wGarSin.GetItemNumber ( 1, "ID_SIN" )
lIdGti 		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
lIdDetail	= -1

If lLigDet > 0 Then
/*------------------------------------------------------------------*/
/* On insére une ligne dans la DW idw_wPPlafond_Gti.                */
/*------------------------------------------------------------------*/
	lLig = idw_wPPlafond_Gti.InsertRow ( 0 )

/*------------------------------------------------------------------*/
/* Pour la zone ID_I, on prend la valeur de la première ligne de    */
/* détail avec un code ETAT à 500, 550 , 600. Il doit forcément     */
/* exister une ligne de détail sinon la garantie ne peut être A     */
/* REGLER. S'il existe plusieurs ID_I pour les détails, il sera     */
/* impossible de valider la garantie. (Fonction Uf_GestionCptiAreg  */
/* ().                                                              */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Il doit forcément exister une ligne de détail sinon il est       */
/* impossible que la garantie soit A REGLER.                        */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Les zones CREE_LE, MAJ_LE, MAJ_PAR seront renseignées sur        */
/* l'événement SqlPreview () de la DW idw_wParaPlafond.             */
/*------------------------------------------------------------------*/
	lIdI			= idw_LstDetail.GetItemNumber ( lLigDet, "ID_I_REG" )

	idw_wPPlafond_Gti.SetItem ( lLig, "ID_SIN", lIdSin )
	idw_wPPlafond_Gti.SetItem ( lLig, "ID_GTI", lIdGti )
	idw_wPPlafond_Gti.SetItem ( lLig, "ID_DETAIL", lIdDetail )
	idw_wPPlafond_Gti.SetItem ( lLig, "ID_TYP_PLAF", asIdTypPlaf )
	idw_wPPlafond_Gti.SetItem ( lLig, "ID_PARA", asIdPara )
	idw_wPPlafond_Gti.SetItem ( lLig, "CPT_VER", asCptVer )
	idw_wPPlafond_Gti.SetItem ( lLig, "ID_I", lIdI )
	idw_wPPlafond_Gti.SetItem ( lLig, "ALT_BOUGE", "O" )

End If	// #1





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
lNbrTotLig = idw_LstCmdeGti.DeletedCount () 

For lCptLig = lNbrTotLig To 1 Step -1

/*------------------------------------------------------------------*/
/* ...on construit la clé de chaque enregistrement contenus dans    */
/* le buffer Delete! de DwNivInf.                                   */
/*------------------------------------------------------------------*/
	sCle = "ID_SEQ = " + String ( idw_LstCmdeGti.GetItemNumber ( lCptLig, "ID_SEQ", DELETE!, TRUE ) ) 

/*------------------------------------------------------------------*/
/* Avec cette ligne identifiée, on effectue le traitement           */
/* nécéssaire sur la DataWindow de niveau supérieur. Voir fonction  */
/* Uf_CopierLigne.                                                  */
/*------------------------------------------------------------------*/
	If This.Uf_CopierLigne_Inf2Sup ( "BD", lCptLig, sCle, iDw_LstCmdeSin, iDw_LstCmdeGti )	< 0  Then Return -1

Next

/*------------------------------------------------------------------*/
/* Pour toutes les lignes contenues dans le buffer Primary!         */
/* DwNivInf... (Le client a pu filtrer le buffer Primaire)          */
/*------------------------------------------------------------------*/
lNbrTotLig = idw_LstCmdeGti.RowCount () 
For lCptLig = 1 To lNbrTotLig


	/*------------------------------------------------------------------*/
	/* ...on construit la clé de chaque enregistrement contenus dans    */
	/* le buffer Primaire de DwNivInf.                                  */
	/*------------------------------------------------------------------*/
	sCle = "ID_SEQ = " + String ( idw_LstCmdeGti.GetItemNumber ( lCptLig, "ID_SEQ", PRIMARY!, TRUE ) ) 


	/*------------------------------------------------------------------*/
	/* Avec cette ligne identifiée, on effectue le traitement           */
	/* nécéssaire sur la DataWindow de niveau supérieur. Voir fonction  */
	/* Uf_CopierLigne.                                                  */
	/*------------------------------------------------------------------*/
	If This.Uf_CopierLigne_Inf2Sup ( "BP", lCptLig, sCle, iDw_LstCmdeSin, iDw_LstCmdeGti )	< 0   Then Return -1
		
Next

iDw_LstCmdeSin.SetSort ( "ID_SEQ D" )
iDw_LstCmdeSin.Sort ()
If iDw_LstCmdeSin.RowCount () > 0 Then 
	iDw_LstCmdeSin.ScrollToRow ( 1 )
	iDw_LstCmdeSin.SetRow ( 1 )
End If

Return 1




end function

private subroutine uf_gestion_commandes ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Gestion_Commandes (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 11/09/2001 16:31:31
//* Libellé			: 
//* Commentaires	: Gestion des Commandes
//*
//* Arguments		: 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

DwItemStatus lStatusDw
String sFiltre
Long		lNbrCol, lNbrLig, lCptLig, lCptCol
Int		iRet

idw_LstCmdeGti.Reset ()

sFiltre = "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) ) + " AND ID_DETAIL <> -1"
idw_LstCmdeSin.SetFilter ( sFiltre )
idw_LstCmdeSin.Filter ()
lNbrLig = idw_LstCmdeSin.RowCount()

/*------------------------------------------------------------------*/
/* Copie des lignes niveau supérieur vers niveau inférieur.         */
/* (Attention, on recopie le buffer primare, le client est donc     */
/* libre de le filtrer.)                                            */
/*------------------------------------------------------------------*/
iRet = idw_LstCmdeSin.RowsCopy ( 1, lNbrLig, PRIMARY!, idw_LstCmdeGti, 1, PRIMARY! )

/*------------------------------------------------------------------*/
/* Recopie des Status de lignes et colonnes.                        */
/*------------------------------------------------------------------*/
lNbrCol = Long ( idw_LstCmdeSin.Describe ("DataWindow.Column.Count" ) )

For lCptLig = 1 to lNbrLig

   /*------------------------------------------------------------------*/
	/* De façons à être sûr de pouvoir modifier les status de           */
	/* colonnes, on force le status de la ligne à DATAMODIFIED!         */
	/*------------------------------------------------------------------*/
	idw_LstCmdeGti.SetItemStatus ( lCptLig, 0, Primary!, DataModified! )

	/*------------------------------------------------------------------*/
	/* Recopie des status de colonnes.                                  */
	/*------------------------------------------------------------------*/
	For lCptCol = 1 To lNbrCol
		lStatusDw = idw_LstCmdeSin.GetItemStatus ( lCptLig, lCptCol, Primary! )
		idw_LstCmdeGti.SetItemStatus ( lCptLig, lCptCol, Primary!, lStatusDw )
	Next

	/*------------------------------------------------------------------*/
	/* Les status de colonne étant recopiés, on recopie à ce moment le  */
	/* status de la ligne.                                              */
	/*------------------------------------------------------------------*/
	lStatusDw = idw_LstCmdeSin.GetItemStatus ( lCptLig, 0, Primary! )
	idw_LstCmdeGti.SetItemStatus ( lCptLig, 0, Primary!, lStatusDw  )

Next

/*------------------------------------------------------------------*/
/* On enleve le filtre sur dw_wDetail.                              */
/*------------------------------------------------------------------*/
sFiltre = ""
idw_LstCmdeSin.SetFilter ( sFiltre )
idw_LstCmdeSin.Filter ()
idw_LstCmdeSin.Sort ()	

end subroutine

private subroutine uf_preparersupprimer_commande (integer aiidgti);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_garantie::uf_PreparerSupprimer_Commande (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 05/11/1999 15:51:33
//* Libellé			: 
//* Commentaires	: Suppression au niveau sinistre des commandes liées à la garantie
//*					  
//*					
//*
//* Arguments		:  aiIdGti		Integer		(Val)
//*						
//*					  
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Long	ltotCmdeSin, lCpt


idw_LstCmdeSin.SetFilter ( "ID_GTI    = " + String ( aiIdGti ) + " AND CPT_VALIDE = 0 " )
idw_LstCmdeSin.Filter ( )
lTotCmdeSin = idw_LstCmdeSin.RowCount ()
For lCpt = lTotCmdeSin To 1 Step -1
	idw_LstCmdeSin.DeleteRow ( lCpt )
Next
idw_LstCmdeSin.SetFilter ( "" )
idw_LstCmdeSin.Filter ( )




end subroutine

public subroutine uf_initialiser_objets (ref u_tagger aupiece, ref u_tagger aurefus, ref commandbutton acbtarif);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialiser_Objets (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 22/01/1998 15:23:57
//* Libellé			: 
//* Commentaires	: Initialisation des objets de la fenêtre W_Tm_Sp_W_Gar_Sin
//*
//* Arguments		: U_Tagger				auoPiece		(Réf)	User Objet pour les pieces
//*					  U_Tagger				auoRefus		(Réf)	User Objet pour les refus
//*					  CommandButton		acbTarif		(Réf)	Bouton sur l'aide du TARIF PAPIER
//*
//* Retourne		: Rien
//*
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
end subroutine

private function integer uf_controlergestion_sfr ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Sinistre_wDetail::uf_ControlerGestion_SFR (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 21/07/2002 09:31:39
//* Libellé			: 
//* Commentaires	: Controle de gestion spécifique à SFR
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//* #1	 CAG	 06/02/2003	  DCMP 30065 : On doit pouvoir clôturer une
//*													gti panne sans dte_ret_pret
//* #2	 JFF	 07/05/2004   DCMP 040111 : Interdire tout réglement >0 Euros sur produit 5712, GTI 18
//*-----------------------------------------------------------------
/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/

Long lCodEtat, lTotCmd, lCpt, lIdGti, lIdSeq, lCodTel, lTotGti, lLig, lIdBsp
DateTime dtDteRetPret
String sRech, sCodEtatCmd
Integer iRet
Boolean bCmdGtiBris 

iRet = 1
lCodTel	= idw_Produit.GetItemNumber ( 1, "COD_TEL" )
/*------------------------------------------------------------------*/
/* Si on est en train de traiter une garantie PANNE (18) et que le  */
/* contrôle de gestion de la garantie positionne un COD_ETAT à      */
/* 200/500/600/900, on va vérifier que les commandes -si elles      */
/* existent - pour cette garantie PANNE, possédent toutes la zone   */
/* DTE_RET_PRET correctement renseignée.                            */
/*------------------------------------------------------------------*/
If	lCodTel = 21	Then
/*------------------------------------------------------------------*/
/* #1 : CAG 06/02/2003                                              */
/*------------------------------------------------------------------*/
//	If	idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) = 18	Then
//		lCodEtat = idw_wGarSin.GetItemNumber  ( 1, "COD_ETAT" )
//		If	lCodEtat = 200 Or lCodEtat = 500 Or lCodEtat = 600 Or lCodEtat = 900	Then 
///*------------------------------------------------------------------*/
///* La DW D_GS_W_COMMANDE posséde un ordre de tri sur ID_SEQ. On     */
///* est donc obligé de parcourir toutes les lignes pour trouver les  */
///* commandes en correspondance avec la garantie PANNE.              */
///*------------------------------------------------------------------*/
///*------------------------------------------------------------------*/
///* On prend la DW idw_LstCmdeGti en compte. La DW idw_LstCmdeSin    */
///* peut ne pas être mise à jour.                                    */
///*------------------------------------------------------------------*/
//			lTotCmd = idw_LstCmdeGti.RowCount ()
//			For	lCpt = 1 To lTotCmd
//					lIdGti			= idw_LstCmdeGti.GetItemNumber ( lCpt, "ID_GTI" )
//					dtDteRetPret	= idw_LstCmdeGti.GetItemDateTime ( lCpt, "DTE_RET_PRET" )
//					lIdSeq			= idw_LstCmdeGti.GetItemNumber ( lCpt, "ID_SEQ" )
//					sCodEtatCmd		= idw_LstCmdeGti.GetItemString ( lCpt, "COD_ETAT" )
//
//					If	lIdGti = 18 And sCodEtatCmd <> "ANN" And ( IsNull ( dtDteRetPret ) ) Then
//						stMessage.sTitre		= "Gestion SFR"
//						stMessage.Icon			= Exclamation!
//						stMessage.sVar[1] 	= String ( lIdSeq )
//						stMessage.bErreurG	= FALSE
//						stMessage.Bouton		= OK!
//						stMessage.sCode		= "SFRP005"
//
//						iRet = -1
//						Exit
//					End If
//			Next
//
//		End If
//	End If

/*------------------------------------------------------------------*/
/* Contrôle équivalent à celui positionné sur le bouton COMMANDER   */
/* de la gestion des détails. (Fonction uf_Bt_Commander).           */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On vérifie s'il existe une commande pour la garantie BRIS.       */
/*------------------------------------------------------------------*/
lTotCmd	= idw_LstCmdeSin.RowCount ()
sRech		= "ID_GTI = 11 And COD_ETAT <> 'ANN'"
If	idw_LstCmdeSin.Find ( sRech, 1, lTotCmd ) > 0	Then bCmdGtiBris = TRUE
/*------------------------------------------------------------------*/
/* Pour une garantie BRIS (11)                                      */
/*------------------------------------------------------------------*/
/* On vérifie que la garantie PANNE est close s'il existe au moins  */
/* une commande active pour cette garantie.                         */
/*------------------------------------------------------------------*/
	If	iRet = 1 And bCmdGtiBris Then
		lTotGti	= idw_wGarSin.iudwDetailSource.RowCount ()
		sRech		= "ID_GTI = 18"

		If	idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) = 11	Then
			lLig = idw_wGarSin.iudwDetailSource.Find ( sRech, 1, lTotGti )

			If	lLig > 0	Then
				lCodEtat = idw_wGarSin.iudwDetailSource.GetItemNumber ( lLig, "COD_ETAT" )
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
	If	iRet = 1 And bCmdGtiBris Then
		If	idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) = 11	Then		

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
						End If
					End If
			Next
		End If
	End If

	// #2
	If	idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) = 18	Then
		If idw_wGarSin.GetItemNumber ( 1, "COD_ETAT" ) = 500 And &
			idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) <> 0 Then
				iRet = -1
				stMessage.sTitre		= "Gestion SFR"
				stMessage.Icon			= Exclamation!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "SFRP190"

		End If
	End If

End If

If	iRet <> 1	Then
	F_Message ( stMessage )
End If

Return ( iRet )
end function

private function boolean uf_rf_623 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_623 (PRIVATE)
//* Auteur			: Catherine Abdmeziem	
//* Date				: 04/02/2003
//* Libellé			: DCMP 030027 : refus de garantie si dte d'adh hors bornes 
//*										 01/06/2001 et 01/06/2002 (incluses)
//* Commentaires	: UNIQUEMENT POUR SFR PGC 17800 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    01/07/2003  DMDI 9326&9347 pour modifier date de fin 01/06/2002 en 31/12/2002
//*
//*-----------------------------------------------------------------


Date dDteAdh, dDteInf, dDteSup

Boolean bRet

bRet = True

dDteAdh 		= idw_wSin.GetItemDate ( 1, "DTE_ADH" 	)
dDteInf		= Date("01/06/2001")
dDteSup		= Date("31/12/2002")

If dDteAdh < dDteInf Or dDteAdh > dDteSup Then
/*------------------------------------------------------------------*/
/* L'adhésion est résiliée et la fin de garantie a été atteinte     */
/* avant le sinistre                                                */
/*------------------------------------------------------------------*/
		bRet = Uf_RF_EcrireRefus ( 623 )
End If

Return ( bRet )

end function

private function boolean uf_rf_624 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_624 (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 14/04/2003 
//* Libellé			: 
//* Commentaires	: Délai 1er Uf/Dte Oppo
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------

Long lTotDelai, lLig, lDuree, lCpt
String	sIdNivDel, sIdRefDel

Boolean bRet

String sRech, sUnite

Date	dDte1erUf, dDteOppo, dDteMax

bRet				= True
lTotDelai 		= idw_Delai.RowCount ()

For lCpt = 1 to 4

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


	End Choose

	If IsNull ( sIdRefDel ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un délai 624 pour la garantie.            */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_DEL = '"  + sIdNivDel 																+ "' AND " 	+ &
					"ID_REF_DEL = "	+ sIdRefDel 																+ " AND " 	+ &
					"ID_TYP_DEL = '624'"

	lLig = idw_Delai.Find ( sRech, 1, lTotDelai )


	If	lLig > 0 Then
	/*------------------------------------------------------------------*/
	/* On récupére le délai maximum autorisé entre la survenance du     */
	/* sinistre et la date de déclaration. On vérifie si ce délai est   */
	/* dépassé.                                                         */
	/*------------------------------------------------------------------*/

		dDte1erUF= Date( idw_wGarSin.GetItemDateTime ( 1, "DTE_1ER_UF" ) ) // [PI056]
		dDteOppo = Date ( idw_wGarSin.GetItemDateTime ( 1, "DTE_OPPO" ) )

		sUnite	= idw_Delai.GetItemString ( lLig, "UNT_DEL" )
		lDuree	= idw_Delai.GetItemNumber ( lLig, "DUR_MAX" )

		dDteMax	= F_Plus_Date ( dDte1erUf, lDuree, sUnite )

		If	dDteOppo > dDteMax	Then
		/*------------------------------------------------------------------*/
		/* La durée maximum est dépassée, on déclenche le refus 624.        */
		/*------------------------------------------------------------------*/
			bRet = Uf_RF_EcrireRefus ( 624 )
		End If

	End If
Next

Return ( bRet )
end function

private function string uf_plaf_nbsin_adhesion_survenance ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbSin_Adhesion_Survenance (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 22/12/2003
//* Libellé			: DCMP 030558 Création de 4 nouveaux plafonds 695,696,697,698
//* Commentaires	: Plafond NB SIN/ANNEE SURV. GLISS&ADHESION  
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Integer iNbAutreSin, iSinEnCours
Long dcIdSin, dcIdProd, dcIdEts
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '695'"

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

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	iNbAutreSin = 0

	itrTrans.PS_S01_W_GTI_NBSIN ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dtDteSurv, iNbAutreSin )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S01_W_GTI_NBSIN" )	Then 
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

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		iSinEnCours		= 1

		If	iSinEnCours + iNbAutreSin > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "695", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "695", "NORMAL" )			
			
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If


Return ( sPos )
	

end function

private function string uf_plaf_nbsin_adherent_survenance ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbSin_Adherent_Survenance (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 22/12/2003
//* Libellé			: DCMP 030558 Création de 4 nouveaux plafonds 695,696,697,698
//* Commentaires	: NB SIN/ANNEE SURV. GLISS&ADHERENT 
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Long dcIdSin, dcIdProd, dcIdEts, dcIdsDos
Integer iSinEnCours, iNbAutreSin
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '696'"

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
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	iNbAutreSin = 0
	itrTrans.PS_S02_W_GTI_NBSIN ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, dtDteSurv, iNbAutreSin )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S02_W_GTI_NBSIN" )	Then 
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

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		iSinEnCours		= 1

		If	iSinEnCours + iNbAutreSin > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "696", sIdPara, sCptVer )

			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "696", "NORMAL" )

		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )
end function

private function string uf_plaf_nbsin_adhesion_renouvellement ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbSin_Adhesion_Renouvellement (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 22/12/2003
//* Libellé			: DCMP 030558 Création de 4 nouveaux plafonds 695,696,697,698
//* Commentaires	: NB SIN/ANNEE RENOUV&ADHESION 
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF	  29/05/2012  [VDOC6662]
//        JFF    07/05/2013  [DT509]
//*-----------------------------------------------------------------
Long lTotPlaf, lLig, lCpt, lLigFinale, lCptMax
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Integer iNbAutreSin, iSinEnCours
Long dcIdSin, dcIdProd, dcIdEts 
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '697'"

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

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
   sUntPerRnv_Adh		   = idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
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

	dtDteAdhRenouv = DateTime ( dDteAdh )
	iNbAutreSin = 0

	itrTrans.PS_S03_W_GTI_NBSIN ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dtDteSurv, dtDteAdhRenouv, iNbAutreSin )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S03_W_GTI_NBSIN" )	Then 
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
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
		iSinEnCours		= 1

		If	iSinEnCours + iNbAutreSin > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "697", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "697", "NORMAL" )			
			
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If


Return ( sPos )
	


end function

private function string uf_plaf_nbsin_adherent_renouvellement ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbSin_Adherent_Renouvellement (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 22/12/2003
//* Libellé			: DCMP 030558 Création de 4 nouveaux plafonds 695,696,697,698
//* Commentaires	: NB SIN/ANNEE RENOUV&ADHERENT
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale, lCptMax
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Long dcIdSin, dcIdProd, dcIdEts, dcIdsDos
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Integer iNbAutreSin, iSinEnCours
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh


sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()

dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '698'"

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
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
   sUntPerRnv_Adh		   = idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
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

	dtDteAdhRenouv = DateTime ( dDteAdh )
	iNbAutreSin = 0

	itrTrans.PS_S04_W_GTI_NBSIN ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, dtDteSurv, dtDteAdhRenouv, iNbAutreSin )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S04_W_GTI_NBSIN" )	Then 
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

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
		iSinEnCours		= 1

		If	iSinEnCours + iNbAutreSin > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "698", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "698", "NORMAL" )			
			
		End If
	End If

End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )	

end function

private function boolean uf_rf_640 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_640 (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 03/03/2004 
//* Libellé			: DCMP 040098 Refus pour ORANGE
//* Commentaires	: Controle IMEI non Ok
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//[CRAO_LOT2] : Modifier ce refus pour declenchement si #cra_suivi_imei# in ( 3,4,5 ou 100)
//sCrasuiviIMei = 100 : Dossier refusé avec Controle IMEI Non Ok avant projet CRAO
Long 	  lCraSuiviIMEI
Long    lRow
Boolean bRet

bRet = True

if isvalid(idw_wdivSin) then
	lRow = idw_wdivSin.find("UPPER(NOM_ZONE)='CRA_SUIVI_IMEI'", 1, idw_wDivSin.rowCount()+1)
	if lRow > 0 then
		lCraSuiviIMEI = idw_wDivSin.object.val_nbre[lRow]
	End If
	if lCraSuiviIMEI = 3 or lCraSuiviIMEI = 4 or lCraSuiviIMEI = 5 or lCraSuiviIMEI = 100 then
		/*------------------------------------------------------------------*/
		/* Un controle IMEI non Ok a été détecté => refus 640               */
		/*------------------------------------------------------------------*/
		bRet = Uf_RF_EcrireRefus ( 640 )
	End If
End If

Return ( bRet )

//*******************************
// Ancien SCript, pour Option 19
//
//Date dDteAdh, dDteInf, dDteSup
//String sIMEIClient, sIMEICtrl
//
//Boolean bRet
//
//bRet = True
//
//sIMEIClient = Trim ( idw_Wsin.GetItemString ( 1, "NUM_IMEI_PORT" ) )
//sIMEICtrl   = Trim ( idw_Wsin.GetItemString ( 1, "REF_CIE" ) )
//
//If IsNull ( sIMEIClient ) Then sIMEIClient = ""
//If IsNull ( sIMEICtrl   ) Then sIMEICtrl   = ""
//
//If sIMEIClient <> sIMEICtrl And sIMEICtrl <> "" And sIMEIClient <> "" And sIMEIClient <> Fill ( "0", 15) Then
//	/*------------------------------------------------------------------*/
//	/* L'IMEI de contrôle est différennt de l'IMEI Client, on           */
//	/* délcenche le refus.                                              */
//	/*------------------------------------------------------------------*/
//	bRet = Uf_RF_EcrireRefus ( 640 )
//End If
//
//Return ( bRet )
//
end function

private function boolean uf_rf_641 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_641 (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 03/03/2004 
//* Libellé			: DCMP 040098 
//* Commentaires	: DTE ACHAT/OUVLIG > DTE SURVENANCE
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
// 		FPI	21/10/2016	[PI056] dte_ach_port en datetime
//*-----------------------------------------------------------------

Date dDteSurv, dDteAchPort, dDteOuvLigPort  
String sIMEIClient, sIMEICtrl

Boolean bRet

bRet = True

dDtesurv = idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) 
dDteAchPort  = Date(idw_wSin.GetItemDateTime ( 1, "DTE_ACH_PORT" ) ) // [PI056]
dDteOuvLigPort  =Date( idw_wSin.GetItemDateTime ( 1, "DTE_OUVLIG_PORT" ))  // [PI056]

If	Not IsNull ( dDteSurv ) and Not IsNull ( dDteAchPort  ) And Not IsNull ( dDteOuvLigPort ) Then
	If ( dDteSurv < dDteAchPort ) Or ( dDteSurv < dDteOuvLigPort ) Then
		bRet = Uf_RF_EcrireRefus ( 641 )
	End If
End If

Return ( bRet )

end function

private function boolean uf_rf_642 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_642 (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 03/03/2004 
//* Libellé			: DCMP 040098 
//* Commentaires	: DTE ACHAT/OUVLIG > DTE ADHESION
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------

Date dDteAdh, dDteAchPort, dDteOuvLigPort  
String sIMEIClient, sIMEICtrl

Boolean bRet

bRet = True

dDteAdh= idw_wSin.GetItemDate ( 1, "DTE_ADH" ) 
dDteAchPort  = Date(idw_wSin.GetItemDateTime ( 1, "DTE_ACH_PORT" ) ) // [PI056]
dDteOuvLigPort  =Date( idw_wSin.GetItemDateTime ( 1, "DTE_OUVLIG_PORT" ))  // [PI056]

If	Not IsNull ( dDteAdh ) and Not IsNull ( dDteAchPort  ) And Not IsNull ( dDteOuvLigPort ) Then
	If ( dDteAdh < dDteAchPort ) Or ( dDteAdh < dDteOuvLigPort ) Then
		bRet = Uf_RF_EcrireRefus ( 642 )
	End If
End If

Return ( bRet )

end function

private function string uf_plaf_adhesion_annee_civile ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adhesion_Annee_Civile (PRIVATE)
//* Auteur			: Catherine Abdmeziem
//* Date				: 14/06/2004
//* Libellé			: 
//* Commentaires	: Application d'un plafond par adhésion/Année civile
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//* #2	FPI	 18/01/2010	[DCMP090687] Ajout du plafond 713
//* #3	FPI	 27/01/2010	[DCMP100063] Ajout du plafond 714
//* #4	FPI	09/02/2010	[DCMP100063.Correctif] Correction du SetItem
//*       JFF   27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//       JFF   16/11/2015 [DT159-1]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale, lDeb, lFin
Decimal {2} dcPlafond, dcMtPlafaReg, 	dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Long lLig713, lligdet, ltotdetail	// #2
Decimal {2} dcPlafond713, dcPlafond714	// #2 - #3 
Long lLig714		// #3
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
For lCpt = 1 to 4

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
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	// #2
	sRech	=		"ID_PROD = "				+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "					+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "					+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '-GA'" 																					+ " AND " 	+ &
					"ID_REF_PLAF = -1"																						+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																						+ " AND " 	+ &
					"ID_TYP_PLAF = '713'"

	lLig713 = idw_Plafond.Find ( sRech, 1, lTotPlaf )
	dcPlafond713 = 0
	If	lLig713 > 0 Then
		sRech 		= "ID_TYPE_CARTE = 'C5' And ( COD_ETAT = 500 Or COD_ETAT = 600 Or COD_ETAT = 200 Or COD_ETAT = 100 )"
		lTotDetail 	= idw_LstDetail.RowCount ()
		lLigDet		= idw_LstDetail.Find ( sRech, 1, lTotDetail )
		If	lLigDet > 0 Then
			dcPlafond713 = idw_Plafond.GetItemDecimal ( lLig713, "MT_PLAF" )
		End If
	End If
	// Fin #2

	// #3 - [DCMP100063]
	sRech	=		"ID_PROD = "				+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "					+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "					+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '-GA'" 																					+ " AND " 	+ &
					"ID_REF_PLAF = -1"																						+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																						+ " AND " 	+ &
					"ID_TYP_PLAF = '714'"

	lLig714 = idw_Plafond.Find ( sRech, 1, lTotPlaf )
	dcPlafond714 = 0
	If	lLig714 > 0 Then
		Choose Case idw_wGarSin.GetItemNumber ( 1, "COD_ETAT" )
			Case 500, 550, 600, 200, 100
				If idw_wsin.getItemstring ( 1, "ID_TYPE_CARTE" ) = "C5" Then				
					dcPlafond714 = idw_Plafond.GetItemDecimal ( lLig714, "MT_PLAF" )
				End If
		End Choose 
	End If
	// Fin #3 - [DCMP100063]

	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S05_W_GTI_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, dtDteSurv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S05_W_GTI_MT_PLAF" )	Then 
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
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG"  )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond + dcPlafond713 + dcPlafond714 Then // #2 ajout de +dcPlafond713 // #3 - [DCMP100063] ajout de +dcPlafond714

			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", (dcPlafond + dcPlafond713 + dcPlafond714) - ( dcMtPlafReg + dcMtAutreSinistre ) )
				
				// [PLAF_REF] // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "673", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "673", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "673", sIdPara, sCptVer )			
			
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
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
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//        JFF   16/11/2015 [DT159-1]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale, lDeb, lFin
Decimal {2} dcPlafond, dcMtPlafaReg, 	dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdsDos
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
For lCpt = 1 to 4

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
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdsDos		= idw_wSin.GetItemNumber ( 1, "ID_SDOS" )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S06_W_GTI_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, dcIdGti, dtDteSurv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S06_W_GTI_MT_PLAF" )	Then 
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
		
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG"  )

		If	dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond	Then
			
			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) )

				// [PLAF_REF] // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "674", "REF_PLAF_NUM_>0" )

				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "674", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "674", sIdPara, sCptVer )

		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If
	
Return ( sPos )
end function

private function string uf_plaf_client_physique_annee_civile ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Plaf_Client_Physique_Annee_Civile (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 03/12/2004 15:07:49
//* Libellé			: DCMP 040407
//* Commentaires	: Application d'un plafond par client physique (Sherpa) par année civile
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//        JFF   16/11/2015 [DT159-1]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale, lDeb, lFin
Decimal {2} dcPlafond, dcMtPlafaReg, 	dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcMtPlafaRegAutGti, 	dcMtPlafRegAutGti , dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, lTotGti, lCptGti
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
n_cst_string lnvPFCString

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '699'"

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
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S01_W_GTI_CLIENT ( dcIdSin, dcIdProd, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S01_W_GTI_CLIENT" )	Then 
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
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG"  )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		lTotGti = idw_LstGti.RowCount ()
		dcMtPlafaRegAutGti = 0
		dcMtPlafRegAutGti  = 0			

/*------------------------------------------------------------------*/
/* Recherche des sommes réglées et A régler sur toutes les autres   */
/* GTI sur sin en cours.                                            */
/*------------------------------------------------------------------*/
		For lCptGti = 1 To lTotGti
			If idw_LstGti.GetItemNumber ( lCptGti, "ID_GTI" ) = idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) Then Continue
			dcMtPlafaRegAutGti += idw_LstGti.GetItemDecimal ( lCptGti, "MT_PLAF_AREG" )
			dcMtPlafRegAutGti  += idw_LstGti.GetItemDecimal ( lCptGti, "MT_PLAF_REG" )
		Next

		If dcMtPlafaRegAutGti + dcMtPlafRegAutGti + dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond	Then

			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", dcPlafond - ( dcMtPlafRegAutGti + dcMtPlafReg + dcMtAutreSinistre ) )
				
				// [PLAF_REF] // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "699", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "699", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "699", sIdPara, sCptVer )			
			
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )
	

end function

private function string uf_plaf_produit_annee_civile ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Plaf_Produit_Annee_Civile (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 03/12/2004 15:07:49
//* Libellé			: DCMP 040407
//* Commentaires	: Application d'un plafond par code produit sinistre et par année civile
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//        JFF    16/11/2015  [DT159-1]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale, lDeb, lFin
Decimal {2} dcPlafond, dcMtPlafaReg, 	dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcMtPlafaRegAutGti, 	dcMtPlafRegAutGti , dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, lTotGti, lCptGti
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
n_cst_string lnvPFCString

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '700'"

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
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S01_W_GTI_PRODUIT ( dcIdSin, dcIdProd, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S01_W_GTI_PRODUIT" )	Then 
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
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG"  )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		lTotGti = idw_LstGti.RowCount ()
		dcMtPlafaRegAutGti = 0
		dcMtPlafRegAutGti  = 0			

/*------------------------------------------------------------------*/
/* Recherche des sommes réglées et A régler sur toutes les autres   */
/* GTI sur sin en cours.                                            */
/*------------------------------------------------------------------*/
		For lCptGti = 1 To lTotGti
			If idw_LstGti.GetItemNumber ( lCptGti, "ID_GTI" ) = idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) Then Continue
			dcMtPlafaRegAutGti += idw_LstGti.GetItemDecimal ( lCptGti, "MT_PLAF_AREG" )
			dcMtPlafRegAutGti  += idw_LstGti.GetItemDecimal ( lCptGti, "MT_PLAF_REG" )
		Next

		If dcMtPlafaRegAutGti + dcMtPlafRegAutGti + dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond	Then

			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", dcPlafond - ( dcMtPlafRegAutGti + dcMtPlafReg + dcMtAutreSinistre ) )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 			"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "700", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "700", "NORMAL" )			
			
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If


Return ( sPos )
	

end function

private function boolean uf_rf_652 ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_Sinistre_Garantie::uf_Rf_652 (PRIVATE)
//* Date				: 23/03/2005
//* Libellé			: Sueil intervention sur Garantie
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
Long lTotPlaf, lLig, lCpt, lTotDetail
String sIdNivPlaf, sIdRefPlaf
Boolean bRet

Decimal {2} dcMtTotPrej 

String sRech

bRet				= True
lTotPlaf 		= idw_Plafond.RowCount ()

lTotDetail = idw_LstDetail.RowCount ()
For	lCpt = 1 To lTotDetail
	dcMtTotPrej += idw_LstDetail.GetItemDecimal ( lCpt, "MT_PREJ" )
Next

/*------------------------------------------------------------------*/
/* Si le montant du préjudice est NULL ou égal à zéro, on ne gére   */
/* pas de refus.                                                    */
/*------------------------------------------------------------------*/
If	IsNull ( dcMtTotPrej ) Or dcMtTotPrej = 0 Then Return ( bRet )

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond 										  */
/*------------------------------------------------------------------*/
sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
				"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
				"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
				"ID_NIV_PLAF = '-GA' AND " 	+ &
				"ID_REF_PLAF = -1    AND " 	+ &
				"ID_CPT_PLAF = 0"																					+ " AND " 	+ &
				"ID_TYP_PLAF = '652'"

lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* Si le montant du préjudice est strictement inférieur au montant  */
/* du plafond, on déclenche le refus 652.                           */
/*------------------------------------------------------------------*/
	If	dcMtTotPrej < idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )	Then
		bRet = Uf_RF_EcrireRefus ( 652 )
	End If
End If


Return ( bRet )




end function

private function boolean uf_rf_694 (integer aldeb, integer alfin);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_Sinistre_Garantie::uf_Rf_694 (PRIVATE)
//* Date				: 23/03/2005
//* Libellé			: Refus Gti (voir param det_pro opt33) si Aucune GTI UF ouverte.
//* Commentaires	: DCMP 040530
//*
//* Arguments		: Int		alDeb			Val		Point d'entrée dans DET_PRO
//*					  Int		alFin			Val		Point de fin dans DET_PRO
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
Long lLig, lIdGti, lCpt 
Boolean bRet

bRet = True

For lCpt = alDeb To alFin
	lIdGti = idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" )

	If idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) = lIdGti And idw_LstGti.Find ( "ID_GTI = 7", 1, idw_LstGti.RowCount () ) <= 0 Then
		bRet = Uf_RF_EcrireRefus ( 694 )
		exit
	End If
next

Return ( bRet )




end function

private function boolean uf_rf_695 (integer aldeb, integer alfin);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_Sinistre_Garantie::uf_Rf_695 (PRIVATE)
//* Date				: 23/03/2005
//* Libellé			: Refus Gti CLE (voir param det_pro opt34) si Aucune GTI UF ouverte.
//* Commentaires	: DCMP 050200
//*
//* Arguments		: Int		alDeb			Val		Point d'entrée dans DET_PRO
//*					  Int		alFin			Val		Point de fin dans DET_PRO
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
Long lLig, lIdGti, lCpt 
Boolean bRet

bRet = True

For lCpt = alDeb To alFin
	lIdGti = idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" )

	If idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) = lIdGti And & 
			( idw_LstGti.Find ( "ID_GTI = 7", 1, idw_LstGti.RowCount () ) <= 0  And & 
			  idw_LstGti.Find ( "ID_GTI = 6", 1, idw_LstGti.RowCount () ) <= 0 ) & 
	Then

		bRet = Uf_RF_EcrireRefus ( 695 )
		exit
	End If
next

Return ( bRet )




end function

private function boolean uf_rf_696 (integer aldeb, integer alfin);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_Sinistre_Garantie::uf_Rf_696 (PRIVATE)
//* Date				: 23/03/2005
//* Libellé			: Refus Gti (vir param det_pro opt/35) si Aucune GTI UF/TdF/Espèces ouverte.
//* Commentaires	: DCMP 050200
//*
//* Arguments		: Int		alDeb			Val		Point d'entrée dans DET_PRO
//*					  Int		alFin			Val		Point de fin dans DET_PRO
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
Long lLig, lIdGti, lCpt 
Boolean bRet

bRet = True

For lCpt = alDeb To alFin
	lIdGti = idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" )

	If idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) = lIdGti And & 
			( idw_LstGti.Find ( "ID_GTI = 7", 1, idw_LstGti.RowCount () ) <= 0  And & 
			  idw_LstGti.Find ( "ID_GTI = 6", 1, idw_LstGti.RowCount () ) <= 0  And &
			  idw_LstGti.Find ( "ID_GTI = 2", 1, idw_LstGti.RowCount () ) <= 0 ) & 
	Then

		bRet = Uf_RF_EcrireRefus ( 696 )
		exit
	End If
next

Return ( bRet )




end function

public function boolean uf_getautorisation (long aliddroit);//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_sinistre_garantie::uf_GetAutorisation (PUBLIC)
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
//* Fonction      : u_gs_sp_sinistre_garantie::uf_Set_ProfilFacturation (PRIVATE)
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
If Not This.uf_GetAutorisation ( 208 ) Then Return

idw_wGarSin.SetItem ( 1, "ALT_BLOC", "N" )
idw_wGarSin.SetItem ( 1, "ALT_ATT", "N" )
idw_wGarSin.SetItem ( 1, "ALT_SSUI", "N" )
idw_wGarSin.SetItem ( 1, "COD_MOT_SSUI", 0 )

lTot = idw_wPiece.RowCount ()
For lCpt = lTot To 1 Step -1
	idw_wPiece.DeleteRow ( lCpt )
Next


end subroutine

private function integer uf_copierligne_inf2sup (string asswitch, long alligdwnivinf, string ascle, ref u_datawindow_detail adwsup, ref u_datawindow_detail adwinf);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_garantie::uf_CopierLigne_Inf2Sup
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

				If adwSup.GetItemStatus	( lLigDwNivSup, 0, Primary! ) = NewModified! Then			
	
					// Aucune commande SQL ne partira sur le moteur dans ce cas
					iRet = adwSup.RowsDiscard ( lLigDwNivSup, lLigDwNivSup, PRIMARY! )
					If IsNull ( iRet ) or iRet <= 0 Then Return -1
	
					// ..et on remet à jour le Buffer DELETE de DwInf afin qu'il corresponde
					// à la réalité des données supprimées en base, après la validation.
					iRet = adwInf.RowsDiscard ( alLigDwNivInf, alLigDwNivInf, DELETE! )
					If IsNull ( iRet ) or iRet <= 0 Then Return -1
	
				Else				
	
					// Une commande Delete partira sur le moteur.
					iRet = adwSup.DeleteRow ( lLigDwNivSup )
					If IsNull ( iRet ) or iRet <= 0 Then Return -1
	
				End If
		
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
//* Fonction		: u_gs_sp_sinistre_Garantie::uf_CopierLigne_Sup2Inf (PRIVATE)
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

String 	sFiltre

idw_DivDetSin.SetFilter  ( "ID_GTI    = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) ) )
idw_DivDetSin.Filter ( )

This.uf_CopierLigne_Sup2Inf ( TRUE, idw_DivDetSin, idw_DivDetGti )

sFiltre = ""
idw_DivDetSin.SetFilter ( sFiltre )
idw_DivDetSin.Filter ()
idw_DivDetSin.Sort ()	

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

/*------------------------------------------------------------------*/
/* Pour toutes les lignes contenues dans le buffer Deleted! de      */
/* DwNivInf...                                                      */
/* Le compteur est à l'envers, car on Détruit des rows sur IdwRe-   */
/* questor dans Uf_CopierLigne												  */
/*------------------------------------------------------------------*/
lNbrTotLig = idw_DivDetGti.DeletedCount () 

For lCptLig = lNbrTotLig To 1 Step -1

/*------------------------------------------------------------------*/
/* ...on construit la clé de chaque enregistrement contenus dans    */
/* le buffer Delete! de DwNivInf.                                   */
/*------------------------------------------------------------------*/
	sCle = "ID_GTI = " + String ( idw_DivDetGti.GetItemNumber ( lCptLig, "ID_GTI", DELETE!, TRUE ) ) + " AND " + &
			 "ID_DETAIL = " + String ( idw_DivDetGti.GetItemNumber ( lCptLig, "ID_DETAIL", DELETE!, TRUE ) ) + " AND " + &
			 "UPPER ( NOM_ZONE ) = '" + Upper ( idw_DivDetGti.GetItemString ( lCptLig, "NOM_ZONE", DELETE!, TRUE ) ) + "'"

/*------------------------------------------------------------------*/
/* Avec cette ligne identifiée, on effectue le traitement           */
/* nécéssaire sur la DataWindow de niveau supérieur. Voir fonction  */
/* Uf_CopierLigne.                                                  */
/*------------------------------------------------------------------*/
	If This.Uf_CopierLigne_Inf2Sup ( "BD", lCptLig, sCle, idw_DivDetSin, idw_DivDetGti )	< 0  Then Return -1

Next

/*------------------------------------------------------------------*/
/* Pour toutes les lignes contenues dans le buffer Primary!         */
/* DwNivInf... (Le client a pu filtrer le buffer Primaire)          */
/*------------------------------------------------------------------*/
lNbrTotLig = idw_DivDetGti.RowCount () 
For lCptLig = 1 To lNbrTotLig


/*------------------------------------------------------------------*/
/* ...on construit la clé de chaque enregistrement contenus dans    */
/* le buffer Primaire de DwNivInf.                                  */
/*------------------------------------------------------------------*/
	sCle = "ID_GTI = " + String ( idw_DivDetGti.GetItemNumber ( lCptLig, "ID_GTI", PRIMARY!, TRUE ) ) + " AND " + &
			 "ID_DETAIL = " + String ( idw_DivDetGti.GetItemNumber ( lCptLig, "ID_DETAIL", PRIMARY!, TRUE ) ) + " AND " + &
			 "UPPER ( NOM_ZONE ) = '" + Upper ( idw_DivDetGti.GetItemString ( lCptLig, "NOM_ZONE", PRIMARY!, TRUE ) ) + "'"



	/*------------------------------------------------------------------*/
	/* Avec cette ligne identifiée, on effectue le traitement           */
	/* nécéssaire sur la DataWindow de niveau supérieur. Voir fonction  */
	/* Uf_CopierLigne.                                                  */
	/*------------------------------------------------------------------*/
	If This.Uf_CopierLigne_Inf2Sup ( "BP", lCptLig, sCle, idw_DivDetSin, idw_DivDetGti )	< 0   Then Return -1
		
Next

Return 1




end function

private subroutine uf_preparersupprimer_ongdivers (integer aiidgti);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_garantie::uf_PreparerSupprimer_OngDivers (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 05/10/2005
//* Libellé			: 
//* Commentaires	: Suppression au niveau sinistre des detail/divers liées à la garantie
//*					  
//*					
//*
//* Arguments		:  aiIdGti		Integer		(Val)
//*						
//*					  
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Long	lTotDivDetSin, lCpt


idw_DivDetSin.SetFilter ( "ID_GTI    = " + String ( aiIdGti ) + " AND CPT_VALIDE = 0 " )
idw_DivDetSin.Filter ( )
lTotDivDetSin = idw_DivDetSin.RowCount ()
For lCpt = lTotDivDetSin To 1 Step -1
	idw_DivDetSin.DeleteRow ( lCpt )
Next
idw_DivDetSin.SetFilter ( "" )
idw_DivDetSin.Filter ( )




end subroutine

private function long uf_zn_dteoppo ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_DteOppo (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libellé			: 
//* Commentaires	: Contrôle de DTE_OPPO_DATE
//*
//* Arguments		: Aucun
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------

Date dDteSurv, dDteOppo
Integer iAction
Long lTotDetail, lCodEtat, lCpt
String sAltValide, sHeuSurv, sHeuOppo
Boolean bModifDteOppo, bTimeSurv
Time tTime

DateTime dtDteSurv, dtDteOppo

iAction = 0

/*------------------------------------------------------------------*/
/* On compare la date de survenance du sinistre et la date          */
/* d'opposition.                                                    */
/*------------------------------------------------------------------*/
dDteSurv = idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )


If	Not IsNull ( dDteSurv ) Then
/*------------------------------------------------------------------*/
/* On s'occupe de récupérer un DateTime pour la Date de SURVENANCE. */
/*------------------------------------------------------------------*/
	sHeuSurv	= idw_wSin.GetItemString ( 1, "HEU_SURV" )

	If IsNull ( sHeuSurv ) Or sHeuSurv = "" Then
		tTime = 00:00:00
	Else
		tTime = Time ( Left ( sHeuSurv, 2 ) + ":" + Right ( sHeuSurv, 2 ) )
		bTimeSurv = True
	End If

	dtDteSurv = DateTime ( dDteSurv, tTime )

/*------------------------------------------------------------------*/
/* On s'occupe de récupérer un DateTime pour la Date D'OPPOSITION.  */
/*------------------------------------------------------------------*/
	dDteOppo	= Date ( idw_wGarSin.GetText () )
	sHeuOppo	= idw_wGarSin.GetItemString ( 1, "HEU_OPPO" )

	If IsNull ( sHeuOppo ) Or sHeuOppo = "" Then
		If	bTimeSurv Then
			tTime = 23:59:59
		Else
			tTime = 00:00:00
		End If
	Else
		tTime = Time ( Left ( sHeuOppo, 2 ) + ":" + Right ( sHeuOppo, 2 ) )
	End If

	dtDteOppo = DateTime ( dDteOppo, tTime )

/*------------------------------------------------------------------*/
/* On compare maintenant les deux DateTime.                         */
/*------------------------------------------------------------------*/
	If	dtDteOppo < dtDteSurv	Then
		idw_wGarSin.iiErreur = 1
		iAction = 1
	End If
End If

/*------------------------------------------------------------------*/
/* Si la date d'opposition bouge, il faut basculer certains         */
/* détails à NON CONTROLER.                                         */
/*------------------------------------------------------------------*/
If	iAction = 0	Then
/*------------------------------------------------------------------*/
/* Il ne faut pas oublier de réarmer idDteOppo afin de gérer le     */
/* cas de la remise à NULL de la zone sur la fonction               */
/* Uf_ControlerSaisie ().                                           */
/*------------------------------------------------------------------*/
	idDteOppo = dDteOppo
	lTotDetail = idw_LstDetail.RowCount ()
	For	lCpt = 1	To lTotDetail
			lCodEtat		= idw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" )
			sAltValide	= idw_LstDetail.GetItemString ( lCpt, "ALT_VALIDE" )
			If	lCodEtat = 100 Or lCodEtat = 500 Or ( lCodEtat = 200 And sAltValide = "O" )	Then
				idw_LstDetail.SetItem ( lCpt, "COD_ETAT", 0 )
				idw_LstDetail.SetItem ( lCpt, "COD_DEC_MAC", 0 )
				idw_LstDetail.SetItem ( lCpt, "COD_DEC_OPE", 0 )
				bModifDteOppo 		= True
			End If
	Next
End If

/*------------------------------------------------------------------*/
/* Si la date vient de changer, on affiche un message               */
/* d'avertissement.                                                 */
/*------------------------------------------------------------------*/
If	bModifDteOppo	Then

	stMessage.sTitre		= "Contrôle de saisie de la garantie"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "WGAR210"

	f_Message ( stMessage )

End If

//Migration PB8-WYNIWYG-03/2006 OR
//idw_wGarSin.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 OR

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

stMessage.sTitre		= "Contrôle sur la garantie"
stMessage.Icon			= Information!
stMessage.bErreurG	= False

/*------------------------------------------------------------------*/
/* On veut mettre la zone ALT_SSUI à OUI, on vérifie qu'il          */
/* n'existe pas de pièces ou de motifs cochés.                      */
/*------------------------------------------------------------------*/
If	idw_wGarSin.GetText () = "O" Then

	lTotLigne = iuoTagPiece.dw_Trt.RowCount ()
	lLigPce = iuoTagPiece.dw_Trt.Find ( "ALT_RECLAME = 'O'", 1, lTotLigne )

	If	lLigPce = 0	Then
		lTotLigne = iuoTagRefus.dw_Trt.RowCount ()
		lLigRef = iuoTagRefus.dw_Trt.Find ( "ALT_OPE = 'O' Or ALT_MAC = 'O'", 1, lTotLigne )
		If	lLigRef = 0	Then

/*------------------------------------------------------------------*/
/* Modification DBI le 14/08/1998                                   */
/* Positionnement du même test sur alt_att que sur les détails      */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Il est impossible de mettre le dossier SANS SUITE si ALT_ATT     */
/* est positionné.                                                  */
/*------------------------------------------------------------------*/

			If	idw_wGarSin.GetItemString ( 1, "ALT_ATT" ) = "O" Then

				stMessage.sVar[1]		= "La garantie est en attente"
				stMessage.sCode		= "WGAR120"
				f_Message ( stMessage )
			Else

				idw_wGarSin.SetItem ( 1, "ALT_SSUI", "O" )

				idw_wGarSin.SetItem ( 1, "COD_ETAT",		900 )
				idw_wGarSin.SetItem ( 1, "COD_DEC_MAC",	900 )
				idw_wGarSin.SetItem ( 1, "COD_DEC_OPE",	900 )
			End If
		End If
	End If

	If	lLigPce > 0 Then
		stMessage.sVar[1]		= "La pièce N° " + String ( iuoTagPiece.dw_Trt.GetItemNumber ( lLigPce, "ID_PCE" ) ) + " est réclamée."
		stMessage.sCode		= "WGAR120"
		
		f_Message ( stMessage )
	End If

	If	lLigRef > 0 Then
		stMessage.sVar[1]		= "Le refus N° " + String ( iuoTagRefus.dw_Trt.GetItemNumber ( lLigRef, "ID_MOTIF" ) ) + " est coché."
		stMessage.sCode		= "WGAR120"

		f_Message ( stMessage )
	End If

/*------------------------------------------------------------------*/
/* On vient de mettre la zone Sans Suite à NON.                     */
/*------------------------------------------------------------------*/
Else
	idw_wGarSin.SetItem ( 1, "ALT_SSUI", "N" )
	idw_wGarSin.SetItem ( 1, "COD_MOT_SSUI", 0 )

	idw_wGarSin.SetItem ( 1, "COD_ETAT",		0 )
	idw_wGarSin.SetItem ( 1, "COD_DEC_MAC",	0 )
	idw_wGarSin.SetItem ( 1, "COD_DEC_OPE",	0 )
End If

//Migration PB8-WYNIWYG-03/2006 OR
//idw_wGarSin.SetActionCode ( 2 )
Return 2
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

private function long uf_zn_heuoppo ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_HeuOppo (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/01/1998 17:14:39
//* Libellé			: 
//* Commentaires	: Controle de HEU_OPPO
//*
//* Arguments		: Aucun
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------

String sVal, sAltValide, sHeuSurv
Integer iAction
Long lCpt, lTotDetail, lCodEtat
Boolean bModifDteOppo

Date dDteSurv, dDteOppo

DateTime dtDteSurv, dtDteOppo

Time tTime

sVal		= Trim ( idw_wGarSin.GetText () )
iAction	= 2

If	sVal = "" Then
	sVal = stNul.str
Else
	If	Len ( sVal ) <> 4 Then
		idw_wGarSin.iiErreur		= 1
		idw_wGarSin.iiReset		= 0
		iAction						= 1
	Else
		If	Not IsTime ( Left ( sVal, 2 ) + ":" + Right ( sVal, 2 ) )	Then
			idw_wGarSin.iiErreur = 2
			idw_wGarSin.iiReset	= 0
			iAction					= 1
		End If
	End If
End If

/*------------------------------------------------------------------*/
/* On va comparer le DateTime de SURVENANCE et le DateTime          */
/* d'OPPOSITION.                                                    */
/*------------------------------------------------------------------*/
If	iAction <> 1 Then
	dDteSurv = idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )
	dDteOppo	= idw_wGarSin.GetItemDate ( 1, "DTE_OPPO_DATE" )
/*------------------------------------------------------------------*/
/* Les deux dates ne sont pas NULLES, on peut les transformer en    */
/* DateTime.                                                        */
/*------------------------------------------------------------------*/
	If	Not IsNull ( dDteSurv ) And Not IsNull ( dDteOppo )	Then
/*------------------------------------------------------------------*/
/* On s'occupe de la Date de SURVENANCE.                            */
/*------------------------------------------------------------------*/
		sHeuSurv = idw_wSin.GetItemString ( 1, "HEU_SURV" )
		
		If	IsNull ( sHeuSurv ) Or sHeuSurv = "" Then
			tTime = 00:00:00
		Else
			tTime = Time ( Left ( sHeuSurv, 2 ) + ":" + Right ( sHeuSurv, 2 ) )		
		End If
		
		dtDteSurv = DateTime ( dDteSurv, tTime )

/*------------------------------------------------------------------*/
/* On s'occupe de la Date D'OPPOSITION.                             */
/*------------------------------------------------------------------*/
		If	IsNull ( sVal ) Or sVal = "" Then
			tTime = 00:00:00
		Else
			tTime = Time ( Left ( sVal, 2 ) + ":" + Right ( sVal, 2 ) )		
		End If
		
		dtDteOppo = DateTime ( dDteOppo, tTime )

/*------------------------------------------------------------------*/
/* On compare maintenant les deux DateTime.                         */
/*------------------------------------------------------------------*/
		If	dtDteOppo < dtDteSurv	Then
			idw_wGarSin.iiErreur		= 3
			idw_wGarSin.iiReset		= 0
			iAction						= 1
		End If

	End IF
End If

If	iAction <> 1 Then
	idw_wGarSin.SetItem ( 1, "HEU_OPPO", sVal )

/*------------------------------------------------------------------*/
/* Si l'heure d'opposition bouge, il faut basculer certains         */
/* détails à NON CONTROLER.                                         */
/*------------------------------------------------------------------*/
	lTotDetail = idw_LstDetail.RowCount ()
	For	lCpt = 1	To lTotDetail
			lCodEtat		= idw_LstDetail.GetItemNumber ( lCpt, "COD_ETAT" )
			sAltValide	= idw_LstDetail.GetItemString ( lCpt, "ALT_VALIDE" )
			If	lCodEtat = 100 Or lCodEtat = 500 Or ( lCodEtat = 200 And sAltValide = "O" )	Then
				idw_LstDetail.SetItem ( lCpt, "COD_ETAT", 0 )
				idw_LstDetail.SetItem ( lCpt, "COD_DEC_MAC", 0 )
				idw_LstDetail.SetItem ( lCpt, "COD_DEC_OPE", 0 )
				bModifDteOppo 		= True
			End If
	Next
End If

/*------------------------------------------------------------------*/
/* Si l'heure vient de changer, on affiche un message               */
/* d'avertissement.                                                 */
/*------------------------------------------------------------------*/
	If	bModifDteOppo	Then

		stMessage.sTitre		= "Contrôle de saisie de la garantie"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "WGAR210"

		f_Message ( stMessage )

End If

//Migration PB8-WYNIWYG-03/2006 OR
//idw_wGarSin.SetActionCode ( iAction )
Return iAction
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

/*------------------------------------------------------------------*/
/* On veut mettre ALT_ATT à OUI, il faut vérifier si ALT_SSUI est   */
/* à NON.                                                           */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 OR
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

If	idw_wGarSin.GetText () = "O" Then
	If	idw_wGarSin.GetItemString ( 1, "ALT_SSUI" ) = "O"	Then
		stMessage.sTitre		= "Contrôle sur la garantie"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= False
		stMessage.sCode		= "WGAR130"
		
		f_Message ( stMessage )
//Migration PB8-WYNIWYG-03/2006 OR
//		idw_wGarSin.SetActionCode ( 2 )
		ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 OR
	End If
End If
//Migration PB8-WYNIWYG-03/2006 OR
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

public function long uf_zn_trt (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_Trt (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:27:01
//* Libellé			: 
//* Commentaires	: Traitement sur les zones de dw_wGarSin
//*
//* Arguments		: s_Pass			astPass			(Réf) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1 PHG	26/04/2007 [DCMP070275] Ajout nvx Motif Sans suite pour facturation
Long lRet
lRet = 0

Choose Case idw_wGarSin.isNomCol
Case "DTE_OPPO_DATE"
	lRet = Uf_Zn_DteOppo ()

Case "HEU_OPPO"
	lRet = Uf_Zn_HeuOppo ()

Case "ALT_SSUI"
	lRet = Uf_Zn_AltSSui ()
// #1 PHG	26/04/2007 [DCMP070275] 
Case "COD_MOT_SSUI"
	lRet = Uf_Zn_CodMotSsui()

Case "ALT_ATT"
	lRet = Uf_Zn_AltAtt () 

Case "ALT_BLOC"
	Uf_Zn_AltBloc ()

End Choose

Return ( lRet )


end function

public subroutine uf_initialiser_dw_desc (ref u_datawindow_detail adw_lstinter, ref u_datawindow_detail adw_lstgti, ref u_datawindow_detail adw_lstdetail, ref u_datawindow_detail adw_lstcmdegti, ref u_datawindow_detail adw_lstcmdesin, ref u_datawindow_detail adw_divdetgti, ref u_datawindow_detail adw_divdetsin, ref u_datawindow adw_wgarsin, ref datawindow adw_norm[], ref datawindow adw_wdivsin);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialiser_Dw_Desc (Public)
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:47:02
//* Libellé			: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*
//* Arguments		: U_DataWindow_Detail	adw_LstInter		(Réf)	DataWindow sur les interlocuteurs (Liste)
//*					  U_DataWindow_Detail	adw_LstGti  		(Réf)	DataWindow sur les Gti (Liste)
//*					  U_DataWindow_Detail	adw_LstDetail		(Réf)	DataWindow sur les Détails (Liste)
//*					  U_DataWindow_Detail	adw_LstCmdeGti		(Réf)	DataWindow sur les commandes niveau Gti (Liste)
//*					  U_DataWindow_Detail	adw_LstCmdeSin		(Réf)	DataWindow sur les commandes niveau Sin (Liste)
//*					  U_DataWindow_Detail	adw_DivDetGti		(Réf)	DataWindow sur les commandes niveau Gti (Liste)
//*					  U_DataWindow_Detail	adw_DivDetSin		(Réf)	DataWindow sur les commandes niveau Sin (Liste)
//*					  U_DataWindow				adw_wGarSin			(Réf)	DataWindow sur la garantie (FreeForm) 
//*					  DataWindow				adw_Norm[19]		(Réf)	Tableau de DataWindow 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date			Modification
//* #1  PHG		26/01/2007	[CRAO_LOT2] 
//*	                     Ajout de dw_divsin de w_tm_sp_sinistre
//*								Comme varaible d'instance pour test dans uf_rf_640
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* DataWindow sur les INTERLOCUTEURS. Liste => U_DataWindow_Detail. */
/*------------------------------------------------------------------*/
idw_LstInter	= adw_LstInter

/*------------------------------------------------------------------*/
/* DataWindow sur les INTERLOCUTEURS. Liste => U_DataWindow_Detail. */
/*------------------------------------------------------------------*/
idw_LstGti	   = adw_LstGti

/*------------------------------------------------------------------*/
/* DataWindow sur les DETAILS.        Liste => U_DataWindow_Detail. */
/*------------------------------------------------------------------*/
idw_LstDetail	= adw_LstDetail

/*------------------------------------------------------------------*/
/* DataWindow sur la GARANTIE.       Saisie => U_DataWindow.        */
/*------------------------------------------------------------------*/
idw_wGarSin		= adw_wGarSin

/*------------------------------------------------------------------*/
/* DataWindow sur les COMMANDES.     Saisie => U_DataWindow.        */
/*------------------------------------------------------------------*/
idw_LstCmdeGti		= adw_LstCmdeGti
idw_LstCmdeSin		= adw_LstCmdeSin

idw_DivDetSin = adw_DivDetSin 
idw_DivDetGti = adw_DivDetGti 

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
/* DataWindow sur la table W_DETAIL                                 */
/*------------------------------------------------------------------*/
idw_wDetail	= adw_Norm[10]

/*------------------------------------------------------------------*/
/* DataWindow sur la table W_PIECE                                  */
/*------------------------------------------------------------------*/
idw_wPiece	= adw_Norm[11]

/*------------------------------------------------------------------*/
/* DataWindow sur la table W_REFUS                                  */
/*------------------------------------------------------------------*/
idw_wRefus	= adw_Norm[12]

/*------------------------------------------------------------------*/
/* DataWindow sur la table W_PARA_PLAFOND                           */
/*------------------------------------------------------------------*/
idw_wParaPlafond	= adw_Norm[13]

/*------------------------------------------------------------------*/
/* DataWindow sur la table W_PIECE                                  */
/*------------------------------------------------------------------*/
idw_wPiece_Detail	= adw_Norm[14]

/*------------------------------------------------------------------*/
/* DataWindow sur la table W_REFUS                                  */
/*------------------------------------------------------------------*/
idw_wRefus_Detail	= adw_Norm[15]

/*------------------------------------------------------------------*/
/* DataWindow External pour les plafonds de la garantie.            */
/*------------------------------------------------------------------*/
idw_wPPlafond_Gti	= adw_Norm[16]

/*------------------------------------------------------------------*/
/* DataWindow External pour les plafonds des détails de la garantie.*/
/*------------------------------------------------------------------*/
idw_wPPlafond_Detail	= adw_Norm[17]

/*------------------------------------------------------------------*/
/* DataWindow external permettant de garder les détails supprimés   */
/*------------------------------------------------------------------*/
idw_wDetailSupp	= adw_Norm[18]

/*------------------------------------------------------------------*/
/* DataWindow Autorisation.													  */
/*------------------------------------------------------------------*/
idwAutorisation   = adw_Norm[19]

/*------------------------------------------------------------------*/
/* u_DataWindow Onglet divers de Sinistre                           */
/*------------------------------------------------------------------*/
idw_wDivSin = adw_wDivSin
end subroutine

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

sData = idw_wGarSin.GetText()

if len(sData) > 0 then
	if Not this.uf_GetAutorisation(208) and 	&
			( 												&
				long(sData) = 3 or 					&
				long(sData) = 4 						&
			) 	then
			
		lACtion = 1
		idw_wGarSin.iiErreur = 1
		
	End If
End If


// [PC509-2]
if lACtion = 0 And len(sData) > 0 then	
	If long(sData) = 11 Then
		lAction = 1
		idw_wGarSin.iiErreur = 1
	End If
End If


// [MOTIF_SSUITE_90]
if lACtion = 0 And len(sData) > 0 then	
	If long(sData) = 90 Then
		lAction = 1
		idw_wGarSin.iiErreur = 1
	End If
End If

return lAction



end function

protected subroutine uf_controlergestion_pec (ref string aspos);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerGestion_PEC (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 13/10/2005
//* Libellé			: 
//* Commentaires	: Contrôle de gestion particulier pour les prises en charges.
//*
//* Arguments		: String		asPos		Réf.
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF 04/06/2007  [DCMP070163-070164-070248-070318] Gestion Prise en charge
//* #2  JFF 04/07/2007  [DCMP070163-070164-070248-070318] Gestion Prise en charge : Modif sur cod_etat
//* #3  JFF 12/07/2007  Idem au détail, on peut prendre en charge
//* #4  JFF 01/07/2008  [DCMP080370]
//*-----------------------------------------------------------------

Long lDeb, lFin, lRow, lCodEtat, lTot, lCpt, lIdGti, lIdDet, lRowPRS
Boolean bCasto, bAuMoinsUnPlafond, bAuMoinsUnRefus, bAuMoinUnePriseEnChargeCoche, bAMUnForcagePriseEnChargeCoche 
Boolean bGestPec // #1
Boolean bRf661

bRf661 = False // #2

If asPos <> "" Then Return
lCodEtat = idw_wGarSin.GetItemNumber ( 1, "COD_ETAT" )
lIdGti = idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )

If idw_wGarSin.GetItemNumber ( 1, "COD_ETAT" ) = 1 Then Return

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
End IF

If Not bGestPec And Not bCasto Then Return

idw_DivDetGti.SetFilter ( "ID_GTI = " + String ( lIdGti ) + " AND UPPER ( NOM_ZONE ) = 'PEC'" )
idw_DivDetGti.Filter ( )
lTot = idw_DivDetGti.RowCount ()

bAuMoinUnePriseEnChargeCoche = FALSE
For lCpt = 1 To lTot
	If idw_DivDetGti.GetItemString ( lCpt, "VAL_ALT" ) = "O" Then
		// #2
		lIdDet = idw_DivDetGti.GetItemNumber ( lCpt, "ID_DETAIL" )

		// #2		
		lRow = idw_LstDetail.Find ( "ID_GTI = " + String ( lIdGti ) + " AND ID_DETAIL = " + String ( lIdDet ), 1, idw_LstDetail.RowCount () )

		Choose Case idw_LstDetail.GetItemNumber ( lRow, "COD_ETAT" )
			Case 200, 900, 1 
				// ON ne compte pas la PEC

			Case Else
		
				bAuMoinUnePriseEnChargeCoche = TRUE
				Exit
		
		End Choose 
		
		
	End If
Next

idw_DivDetGti.SetFilter ( "ID_GTI = " + String ( lIdGti ) + " AND UPPER ( NOM_ZONE ) = 'ALT_PEC'" )
idw_DivDetGti.Filter ( )
lTot = idw_DivDetGti.RowCount ()

bAMUnForcagePriseEnChargeCoche = FALSE
For lCpt = 1 To lTot
	If idw_DivDetGti.GetItemString ( lCpt, "VAL_ALT" ) = "O" Then
		// #2
		lIdDet = idw_DivDetGti.GetItemNumber ( lCpt, "ID_DETAIL" )

		// #2		
		lRow = idw_LstDetail.Find ( "ID_GTI = " + String ( lIdGti ) + " AND ID_DETAIL = " + String ( lIdDet ), 1, idw_LstDetail.RowCount () )

		Choose Case idw_LstDetail.GetItemNumber ( lRow, "COD_ETAT" )
			Case 200, 900, 1 
				// ON ne compte pas le forçage

			Case Else

				bAMUnForcagePriseEnChargeCoche = TRUE
				Exit
				
		End Choose 				
		
	End If
Next

idw_DivDetGti.SetFilter ( "" )
idw_DivDetGti.Filter ( )

Choose Case lCodEtat
	Case 100, 200
		// On ne traite le cas de la pec que pour ces code état.
	Case Else
		Return
End Choose

If bAuMoinUnePriseEnChargeCoche  And &
	( iuoTagRefus.dw_Trt.Find ( "ALT_OPE = 'O'", 1, iuoTagRefus.dw_Trt.RowCount () ) > 0  ) Then
//* #4  [DCMP080370] On permet la PEC même s'il y a des pièce demandées.
/*
	( iuoTagPiece.dw_Trt.Find ( "ALT_RECLAME = 'O'", 1, iuoTagPiece.dw_Trt.RowCount () ) > 0 Or &
	iuoTagRefus.dw_Trt.Find ( "ALT_OPE = 'O'", 1, iuoTagRefus.dw_Trt.RowCount () ) > 0  ) Then
*/
//* :#4  [DCMP080370]
	// #3

	LRowPrs = idw_LstCmdeGti.Find ( "ID_GTI = " + String ( lIdGti ) + &
											  " AND ID_TYP_ART = 'PRS' AND COD_ETAT <> 'ANN'", 1, idw_LstCmdeGti.RowCount () )

	// #3 Si présence d'une réparation et dem de piècen, on ne déclenche pas le blocage.
	If Not ( lRowPrs > 0 And iuoTagPiece.dw_Trt.Find ( "ALT_RECLAME = 'O'", 1, iuoTagPiece.dw_Trt.RowCount () ) > 0 ) Then

		stMessage.sCode = "WDET450"
		asPos = "MT_PROV"
		F_Message ( stMessage )

		// #1
		Return
	End If
	
End If

// #1
If bGestPEC Then
	bAuMoinsUnPlafond = This.Uf_RechecherPlafond_Pec ( "-DP/86" ) = "O"
ElseIf bCasto Then
	bAuMoinsUnPlafond = This.Uf_RechecherPlafond_Pec ( "CASTO" ) = "O"
End If


// #1 filtre modifié.
bAuMoinsUnRefus   = iuoTagRefus.dw_Trt.Find ( "ID_GTI = " + String ( lIdGti ) + " AND ID_DETAIL = -1 AND ( ALT_OPE = 'O' OR ALT_MAC = 'O') ", 1, iuoTagRefus.dw_Trt.RowCount () ) > 0 Or &
							idw_wGarSin.GetItemNumber ( 1, "COD_ETAT" )  = 200

If bAuMoinsUnPlafond Then
	idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
Else 
	idw_wGarSin.SetItem ( 1, "ALT_PLAF", "N" )
End IF

If asPos = "" And bAuMoinUnePriseEnChargeCoche And bAuMoinsUnPlafond Then
	If Not Uf_RF_EcrireRefus ( 661 ) Then
		asPos = "MT_PROV"
	Else 
		idw_wGarSin.SetItem ( 1, "COD_DEC_MAC", 200 ) // #2
		bRf661 = TRUE
		iuoOng.Uf_ChangerBitmap ( "03", "K:\PB4OBJ\BMP\8_REF.BMP" )
	End If
	bAuMoinsUnRefus = TRUE
End If

If asPos = "" And bAuMoinUnePriseEnChargeCoche And bAuMoinsUnRefus And Not bAMUnForcagePriseEnChargeCoche Then
	idw_wGarSin.SetItem ( 1, "COD_DEC_MAC", 200 )
	idw_wGarSin.SetItem ( 1, "COD_DEC_OPE", 100 )
	idw_wGarSin.SetItem ( 1, "COD_ETAT", 200 )
End If

// #2 ilEtatForceOpe pour  éviter systèmatiquement forcer la PEC excepté pour le refus 661
If asPos = "" And ilEtatForceOpe > 0 And Not bRf661 And bAuMoinUnePriseEnChargeCoche And bAuMoinsUnRefus And Not bAMUnForcagePriseEnChargeCoche Then
	idw_wGarSin.SetItem ( 1, "COD_DEC_MAC", 200 )
	idw_wGarSin.SetItem ( 1, "COD_DEC_OPE", ilEtatForceOpe )
	idw_wGarSin.SetItem ( 1, "COD_ETAT", ilEtatForceOpe )
End If

If asPos = "" And bAuMoinUnePriseEnChargeCoche And bAMUnForcagePriseEnChargeCoche Then
	idw_wGarSin.SetItem ( 1, "COD_DEC_OPE", 100 )
	idw_wGarSin.SetItem ( 1, "COD_ETAT", 100 )
	stMessage.sCode = "WDET460"	
	F_Message ( stMessage )
End If

// #1
If bCasto Then
	If asPos = "" Then
		If bAuMoinUnePriseEnChargeCoche And idw_wGarSin.GetItemNumber ( 1, "COD_ETAT" ) = 100 Then
			stMessage.sCode = "WDET470"
		Else
			stMessage.sCode = "WDET480"
		End If
		F_Message ( stMessage )
	End If
End IF

end subroutine

private function string uf_rechecherplafond_pec (string ascas);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre_detail::Uf_RechecherPlafond_Pec (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 11/10/2005
//* Libellé			: Recherche des plafonds en amont pour les gestions de prise en charge
//* Commentaires	: 
//*
//* Arguments		: String			asCas				Val  "CASTO", "-DP/86"
//*
//* Retourne		: O/N : O=Au moins plaf s'est déclenche
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
//*       JFF    17/06/2011  [PC545].[BUG_BGE_721]
//*       JFF    27/07/2011  [PLAF_REF]
//*----------------------------------------------------------------

Long lTot, lCpt, lTotDet, lCptDet, lTotDivDet, lRow, lIdGti, lTotDetail
String	sIdGti, sIdEvt, sNull, sFiltre, sFiltreOrig, sPlafAutre, sVal, sRech
Decimal {2} dcPlafGti, dcPlafValAch, dcPlafDef, dcPlafSav, dcMtLu, dcMtMaxLu
s_Plafond_Pec stPlafPec
u_Datawindow udwNull
n_cst_string lnvPFCString		

SetNull ( sNull ) 
SetNull ( udwNull )
sVal = ""

sIdGti = String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )
lIdGti = idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )

// [PC545].[BUG_BGE_721]
//	[PC363].[10%]
lRow = idw_LstCmdeSin.Find ( "COD_ETAT <> 'ANN' AND POS ( INFO_FRN_SPB_CPLT, 'APP_INCOMPLET=OUI', 1) >0", 1, idw_LstCmdeSin.RowCount () )
sVal = "[###]"

If lRow > 0 Then
	lnvPFCString.of_Setkeyvalue ( sVal, "APP_INCOMPLET", "OUI", ";")
End If

// [PC301].[V15_EVOL_VETUSTE]
lTotDetail = idw_wDetail.RowCount ()
dcMtLu = 0
dcMtMaxLu = 0
For lCptDet = 1 To lTotDetail	
	
	sRech	=		"ID_GTI = "	+ String ( idw_wDetail.GetItemNumber ( lCptDet, "ID_GTI" ) )	+ " AND " 	+ &
					"ID_DETAIL = "	+ String ( idw_wDetail.GetItemNumber ( lCptDet, "ID_DETAIL" ) )	+ " AND " 	+ &
					"UPPER ( NOM_ZONE ) = 'MT_MAX_PROPO_PLF722'"
		
	lRow = idw_DivDetGti.Find ( sRech, 1, idw_DivDetGti.RowCount () ) 
	If lRow > 0 Then
		dcMtLu = idw_DivDetGti.GetItemDecimal ( lRow, "VAL_MT" )
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

//* F_Plafond_Pec 
//* Retourne		: Structure s_plafond_pec (0 indique qu'il n'y a pas de plafond)
//*					  Pour le type Autre, le retour est sous cette forme
//*					  O[704][3]    => OUI, plaf 704, x3 (en cours + autre)
//*					  N[704][1]		=> NON, plaf 704, x1 ( juste l'en cours)

// [PLAF_REF]
Choose Case asCas
	Case "CASTO"
		stPlafPec = F_Plafond_Pec ( "2" + sVal, idw_wSin, idw_wDivSin, idw_wGarSin, idw_LstDetail, udwNull, idw_Plafond, idw_DetPro, idw_produit, idw_DivDetGti, lIdGti, -1 )

		// [PLAF_REF]
		If ( stPlafPec.dcPlafValAch > stPlafPec.dcPlafGti And stPlafPec.dcPlafGti > 0 ) Or &
			( stPlafPec.dcPlafValAch = 0.01 ) Or &
			( stPlafPec.dcPlafGti = 0.01 ) Or &
			Left ( stPlafPec.sPlafAutre, 1 ) = "O" Then
			Return "O"
		Else 
			Return "N"
		End If

	Case "-DP/86" // #1
		stPlafPec = F_Plafond_Pec ( "5" + sVal, idw_wSin, idw_wDivSin, idw_wGarSin, idw_LstDetail, udwNull, idw_Plafond, idw_DetPro, idw_produit, idw_DivDetGti, lIdGti, -1 )

		// [PLAF_REF]
		If ( stPlafPec.dcPlafMtPec > stPlafPec.dcPlafGti And stPlafPec.dcPlafGti > 0 ) Or &
			( stPlafPec.dcPlafGti = 0.01 ) Or &
			( stPlafPec.dcPlafMtPec = 0.01 ) Or &
			Left ( stPlafPec.sPlafAutre, 1 ) = "O" Then 
			Return "O"
		Else 
			Return "N"
		End If
		
End Choose


Return "N"


end function

private function boolean uf_rf_699 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_699 (PRIVATE)
//* Auteur			: PHG
//* Date				: 22/01/2008
//* Libellé			: [DCMP070815] : Refus Garantie Liée à une Nature de sinistre,
//*										  le tout lié à une Heure de Survenance Non Courverte
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 PHG		28/02/2008 [DCMP080144] On lie aussi le refus à un detail de sinistre parametré
//*								  dans l'option -DP/63, parametre ID_DETSIN dans val_car
//* #2    JFF     12/01/2009 [20090112160907947]
//* #3	FPI	13/01/2010 [DCMP100006]
//* #4	FPI	18/01/2010 [DCMP100006] Correction
//			FPI	02/11/2010	 [ITSM49360] Affichage du msg si dte_surv vide
//*-----------------------------------------------------------------

Long  lDeb, lIdGti, lIdNatSin ,lIdDetSin, lRech, lFin, lCpt  // #1 [DCMP080114] ajout de lIdDetSin
Date dDteSurv						// Date de Surv, Type Date
Time tHrSurv						// Hr de surv, type Time
String	sHrSurv					// Hr de surv en texte
DateTime dtDteSurv				// Date/heure de surv 
DateTime dtDteDeb, dtDteFin 	// Date/heure de debut et Fin de sinistre autorisé.
Time		tDeb, tFin				// Heure de début et de fin paramétrée dans det_pro
String	sDpParam 				// Paramétrage enregistré dans detpro.val_car
n_cst_string lnv_string 		// Utilisation de fct de découpage de chaine.
Boolean bRet,bRefus

bRet = True

// Si pas d'option 63 : Pas de Refus
// #2 [20090112160907947]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 63 )

If lDeb <= 0 Then Return TRUE

// #2 [20090112160907947]
For lCpt = lDeb TO lFin

		// #2 [20090112160907947]
		lRech= idw_DetPro.Find(	"ID_TYP_CODE_DP = '-DP' AND ID_CODE_DP = 63 AND ID_CODE_NUM = 699", lCpt, lCpt )

		// #2 [20090112160907947]
		If lRech <= 0 Then continue

		// Lecture date et heure de survenance du sinistre
		dDteSurv 	= idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )
		sHrSurv		= idw_wSin.GetItemString(1, "HEU_SURV" )
		tHrSurv		= time(left(sHrSurv,2)+":"+Right(sHrSurv,2))
		dtDteSurv	= DateTime(dDteSurv, tHrSurv)
		
		// #3 [DCMP100006] - #4 Mise en commentaire
/*		If IsNull ( sHrSurv ) Then
				stMessage.berreurg=TRUE
				stMessage.scode="EWK0012"
				stMessage.sVar[1] = "l'heure de survenance"				
				stMessage.stitre = "Contrôle de saisie"
				
				bRet = Uf_RF_EcrireRefus ( 699 )
				Return ( bRet )			
		End if
		// Fin #3
	*/
		// Controle Date/Heure de surv : Si erroné, Refus
		bRefus =  	( isnull(dDteSurv) or dDteSurv=1900-01-01) or &
						( isnull(tHrSurv) or ( sHrSurv<>"0000" and tHrSurv = 00:00:00.000000 ) )
		
		// Lecture Garantie en Cours
		lIdGti    = idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
		lIdNatSin = idw_wSin.GetItemNumber ( 1, "ID_NATSIN" )
		lIdDetSin = idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) // #1 [DCMP080114] Lecture du Detail de sinistre
		
		// Lecture Paramétrage DetPro
		// #2 [20090112160907947]
		sDpParam = idw_DetPro.GetItemString ( lRech, "VAL_CAR" )
		
		// Calcul des Dates et Heures de Sinistre autorisée
		tDeb = Time(lnv_string.of_getkeyvalue( sDpParam, "HEU_SURV_DEB", ";"))
		tFin = Time(lnv_string.of_getkeyvalue( sDpParam, "HEU_SURV_FIN", ";"))
		
		If tHrSurv >= tDeb And tHrSurv <= 23:59:00 Then
			dtDteDeb = DateTime(dDteSurv, tDeb)
			dtDteFin = DateTime(RelativeDate(dDteSurv,1), tFin)
		Else
			dtDteDeb = DateTime(RelativeDate(dDteSurv,-1), tDeb)	
			dtDteFin = DateTime(dDteSurv, tFin)
		End If
		
		// Si Pour la Garantie et la Nature de sinistre actuelle, on a un refus 699 paramétré
		//	 et 
		//		si la date et heure de survenance est dans la plage horaire paramétré ,
		//		ou si la date/heure de survenance est invalide
		//  On déclenche le refus.
	
		//  #4
/*		If	( long(lnv_string.of_getkeyvalue( sDpParam, "ID_GTI", ";")) = lIdGti ) and 		&
			( long(lnv_string.of_getkeyvalue( sDpParam, "ID_NATSIN", ";")) = lIdNatSin ) and &
			( long(lnv_string.of_getkeyvalue( sDpParam, "ID_DETSIN", ";")) = lIdDetSin ) and *//*#1 [DCMP080144 */&  			
/*			( ( dtDteDeb <= dtDteSurv and dtDteSurv <= dtDteFin ) or bRefus ) Then
				bRet = Uf_RF_EcrireRefus ( 699 )
	
	*/
	If	( long(lnv_string.of_getkeyvalue( sDpParam, "ID_GTI", ";")) = lIdGti ) and 		&
			( long(lnv_string.of_getkeyvalue( sDpParam, "ID_NATSIN", ";")) = lIdNatSin ) and &
			( long(lnv_string.of_getkeyvalue( sDpParam, "ID_DETSIN", ";")) = lIdDetSin ) Then

				
				If IsNull ( sHrSurv ) Then
					stMessage.berreurg=TRUE
					stMessage.scode="EWK0012"
					stMessage.sVar[1] = "l'heure de survenance"				
					stMessage.stitre = "Contrôle de saisie"
					
					f_message(stmessage ) // [ITSM49360]
					
					bRet = Uf_RF_EcrireRefus ( 699 )
					Return ( bRet )			
				End if
	
				// Controle Date/Heure de surv : Si erroné, Refus
				bRefus =  	( isnull(dDteSurv) or dDteSurv=1900-01-01) or &
								( isnull(tHrSurv) or ( sHrSurv<>"0000" and tHrSurv = 00:00:00.000000 ) )
			
				If ( ( dtDteDeb <= dtDteSurv and dtDteSurv <= dtDteFin ) or bRefus ) Then
					bRet = Uf_RF_EcrireRefus ( 699 )
					Return ( bRet )			
				End If
				// Fin #4
			
				// #2 [20090112160907947]
				If bRet Then Exit
		End If
		
Next
	
Return ( bRet )
end function

private function boolean uf_rf_628 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_628 (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 03/06/2008
//* Libellé			: Ce "Refus" n'en est en fait pas un !
//*                 En effet, le délai de renonciation -DL/628 n'est pas (Uf_Rf_628) appelé sur Uf_GestionRefus,
//*                 mais sur uf_controlerGestion afin de générer un blocage et non un refus.
//*                 Il faudra mettre la garantie "En attente pour s'en sortir ou refusé".
//* Commentaires	: [3SUISSE].DEL_RENONC
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 			FPI	15/09/2014	[OPTIM_SQL]
//*-----------------------------------------------------------------
Long lTotDelai, lLig, lDuree, lCpt, lLigFinale 
String sIdNivDel, sIdRefDel

Boolean bRet

String sRech, sUnite, sIdGti
Date	dDteDecl, dDteMax, dDteTemp, dDteSav, dDteAdh, dDateDuJour
DateTime  dtDateDuJour
dtDateDuJour = stNul.dtm

sIdGti = String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )

// Si AMU réglement a été forcé, on ne regarde pas ce délai.
If idw_LstDetail.Find ( "ALT_REG = 'O' AND COD_ETAT IN ( 500, 600 )", 1, idw_LstDetail.rowcount()) > 0 Then Return False

// Si AMU un refus cocher sur les refus de GTI OU si AMU un refus de détail avec pour les deux cas, un inter destinataire, alors on ne regarde pas ce délai.
If iuoTagRefus.dw_Trt.Find ( "( ALT_OPE = 'O' OR ALT_MAC = 'O') AND NOT ISNULL ( ID_I) ", 1, iuoTagRefus.dw_Trt.RowCount () ) > 0  Or &
   idw_wRefus_Detail.Find ( "( ALT_OPE = 'O' OR ALT_MAC = 'O') AND NOT ISNULL ( ID_I) AND ID_GTI = " + sIdGti + " AND ID_DETAIL > -1 ", 1, idw_wRefus.Rowcount()) > 0 Then Return False

bRet				= False
lTotDelai 		= idw_Delai.RowCount ()
lLigFinale		= 0
SetNull ( dDteSav )

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 1 to 4

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
			sIdNivDel = "+DT"  // Détail
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
	End Choose

	If IsNull ( sIdRefDel ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un délai de déclaration pour la garantie. */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_DEL = '"  + sIdNivDel 																+ "' AND " 	+ &
					"ID_REF_DEL = "	+ sIdRefDel 																+ " AND " 	+ &
					"ID_TYP_DEL = '628'"

	lLig = idw_Delai.Find ( sRech, 1, lTotDelai )

	If lLig > 0 Then	

		sUnite	= idw_Delai.GetItemString ( lLig, "UNT_DEL" )
		lDuree	= idw_Delai.GetItemNumber ( lLig, "DUR_MAX" )

		dDteTemp	= F_Plus_Date ( dDteDecl, lDuree, sUnite )

		If Not IsNull ( dDteSav ) Then

			If dDteTemp > dDteSav Then 
				dDteSav = dDteTemp
				lLigFinale = lLig
			End If

		Else
			dDteSav = dDteTemp
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/


If	lLig > 0 Then
	dDteDecl = idw_wSin.GetItemDate ( 1, "DTE_DECL" )
	dDteAdh = idw_wSin.GetItemDate ( 1, "DTE_ADH" )

	// [OPTIM_SQL]
	dtDateDuJour=Datetime( Today(), Now() )
	// :[OPTIM_SQL]
	dDateDuJour = Date ( dtDateDuJour )

	sUnite	= idw_Delai.GetItemString ( lLig, "UNT_DEL" )
	lDuree	= idw_Delai.GetItemNumber ( lLig, "DUR_MAX" )

	dDteMax	= F_Plus_Date ( dDteAdh, lDuree, sUnite )

	If	dDteDecl < dDteMax And dDateDuJour < dDteMax Then
		bRet = True
	End If
End If

Return ( bRet )

end function

private function string uf_plaf_nbsin_adherent_annee_civile ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbSin_Adherent_Annee_Civile (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 12/06/2008
//* Libellé			: Plafond Nbre Sinistre par adherent et année civile.
//* Commentaires	: [DCMP080377]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Long dcIdSin, dcIdProd, dcIdEts, dcIdsDos
Integer iSinEnCours, iNbAutreSin
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '712'"

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
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	iNbAutreSin = 0

	SQLCA.PS_S05_W_GTI_NBSIN ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, dtDteSurv, iNbAutreSin )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S05_W_GTI_NBSIN" )	Then 
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

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		iSinEnCours		= 1

		If	iSinEnCours + iNbAutreSin > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "712", sIdPara, sCptVer )

			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "712", "NORMAL" )

		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )

end function

private function string uf_plaf_nbsin_adhesion_annee_civile ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbSin_Adhesion_Annee_Civile (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 12/06/2008
//* Libellé			: Plafond Nbre Sinistre par adhesion et année civile.
//* Commentaires	: [DCMP080377]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Integer iNbAutreSin, iSinEnCours
Long dcIdSin, dcIdProd, dcIdEts
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '711'"

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

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	iNbAutreSin = 0

	SQLCA.PS_S06_W_GTI_NBSIN ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dtDteSurv, iNbAutreSin )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S01_W_GTI_NBSIN" )	Then 
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

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		iSinEnCours		= 1

		If	iSinEnCours + iNbAutreSin > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "711", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "711", "NORMAL" )			
			
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If


Return ( sPos )
	

end function

private function boolean uf_rf_604 (integer aldeb, integer alfin);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_Sinistre_Garantie::uf_Rf_604 (PRIVATE)
//* Date				: 30/03/2009
//* Libellé			: Refus Gti CLE (voir param det_pro opt 111) .
//* Commentaires	: [GOSPORT]
//*
//* Arguments		: Int		alDeb			Val		Point d'entrée dans DET_PRO
//*					  Int		alFin			Val		Point de fin dans DET_PRO
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
Long lLig, lIdGti, lCpt 
Boolean bRet

bRet = True

For lCpt = alDeb To alFin
	lIdGti = idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" )

	If idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) = lIdGti And & 
			( idw_LstGti.Find ( "ID_GTI = 10", 1, idw_LstGti.RowCount () ) <= 0  And & 
			  idw_LstGti.Find ( "ID_GTI = 11", 1, idw_LstGti.RowCount () ) <= 0 ) & 
	Then

		bRet = Uf_RF_EcrireRefus ( 604 )
		exit
	End If
next

Return ( bRet )




end function

private function boolean uf_rf_643 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_643 (PRIVATE)
//* Auteur			: FPI
//* Date				: 09/02/2010
//* Libellé			: [DCMP100079]
//* Commentaires	: DTE ACHAT/OUVLIG < DTE ADHESION
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------

Date dDteAdh, dDteAchPort, dDteOuvLigPort  
String sIMEIClient, sIMEICtrl

Boolean bRet

bRet = True

dDteAdh= idw_wSin.GetItemDate ( 1, "DTE_ADH" ) 
dDteAchPort  = Date(idw_wSin.GetItemDateTime ( 1, "DTE_ACH_PORT" ) ) // [PI056]
dDteOuvLigPort  = Date( idw_wSin.GetItemDateTime ( 1, "DTE_OUVLIG_PORT" ))  // [PI056]

If	Not IsNull ( dDteAdh ) and Not IsNull ( dDteAchPort  ) And Not IsNull ( dDteOuvLigPort ) Then
	If ( dDteAdh > dDteAchPort ) Or ( dDteAdh >dDteOuvLigPort ) Then
		bRet = Uf_RF_EcrireRefus ( 643 )
	End If
End If

Return ( bRet )

end function

private function string uf_plaf_nbsin_adhesion ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbSin_Adhesion (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 07/04/2010
//* Libellé			: Plafond Nbre Sinistre par adhesion.
//* Commentaires	: [DCMP100220]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale, lDeb, lFin, lRow 
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Integer iNbAutreSin, iSinEnCours
Long dcIdSin, dcIdProd, dcIdEts
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf, sVal
DateTime dtMajLe

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '715'"

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

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
				
	iNbAutreSin = 0

	SQLCA.PS_S07_W_GTI_NBSIN ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, iNbAutreSin )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S07_W_GTI_NBSIN" )	Then 
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

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		iSinEnCours		= 1

		If	iSinEnCours + iNbAutreSin > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "715", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "715", "NORMAL" )
			
			// [MIG19_PSPLAF_SAGA2]
			If F_CLE_A_TRUE ( "MIG19_PSPLAF_SAGA2" ) Then
				F_RechDetPro(lDeb, lFin, idw_detpro, idw_produit.getItemNumber(1,"ID_PROD"),"-DP", 395)
				If lDeb > 0 Then	
			
					lRow = idw_wdivsin.Find("UPPER(NOM_ZONE)='ADH_DEJA_INDEM'", 1, idw_wdivsin.RowCount())
					If lRow> 0 Then
						sVal = idw_wdivsin.GetItemString (lRow, "VAL_CAR") 
					
						If sVal <> "O" Then
							idw_wdivSin.SetItem ( lRow, "VAL_CAR", "O" )
							dtMajLe = DateTime ( Today (), Now () )
							idw_wDivSin.SetItem ( lRow, "MAJ_LE", dtMajLe  )
							idw_wDivSin.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )
							idw_wDivSin.SetItem ( lRow, "ALT_SUPP", "N" )
						End If
					End If
				End If 			
			End If			
			
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If


Return ( sPos )
	

end function

private function string uf_plaf_nbsin_adherent ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbSin_Adherent (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 12/06/2008
//* Libellé			: Plafond Nbre Sinistre par adherent et année civile.
//* Commentaires	: [DCMP080377]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Long dcIdSin, dcIdProd, dcIdEts, dcIdsDos
Integer iSinEnCours, iNbAutreSin
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '716'"

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
				
	iNbAutreSin = 0

	SQLCA.PS_S08_W_GTI_NBSIN ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, iNbAutreSin )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S08_W_GTI_NBSIN" )	Then 
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

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		iSinEnCours		= 1

		If	iSinEnCours + iNbAutreSin > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "716", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "716", "NORMAL" )

		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )

end function

private function boolean uf_rf_645 (integer aldeb, integer alfin);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_Sinistre_Garantie::uf_Rf_645 (PRIVATE)
//* Date				: 15/04/2010
//* Libellé			: Refus Gti CLE (voir param det_pro opt 135) .
//* Commentaires	: [DCMP100284]
//*
//* Arguments		: Int		alDeb			Val		Point d'entrée dans DET_PRO
//*					  Int		alFin			Val		Point de fin dans DET_PRO
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
Long lLig, lIdGti, lCpt 
Boolean bRet
String sVal
n_cst_string lnv_string 		// Utilisation de fct de découpage de chaine.
Date 	  dDteSurv, dDteDebCouv, dDteMaxCouv, dDteAchat

bRet = True

dDteSurv = idw_wsin.getitemdate( 1, "DTE_SURV_DATE")
dDteAchat  = Date(idw_wSin.GetItemDateTime ( 1, "DTE_ACH_PORT" ) ) // [PI056]


For lCpt = alDeb To alFin
	lIdGti = idw_DetPro.GetItemNumber ( lCpt, "ID_CODE_NUM" )

	If idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) = lIdGti 	Then

		sVal = lnv_string.of_getkeyvalue( idw_DetPro.GetItemString ( lCpt, "VAL_CAR" ), "DEB_COUV_RAPPORT_DTE_ACH", ";")
		dDteDebCouv = f_plus_date( dDteAchat, Long(Left(sVal, Len(sVal) -1)) , Right(sVal,1) )

		sVal = lnv_string.of_getkeyvalue( idw_DetPro.GetItemString ( lCpt, "VAL_CAR" ), "DUR_MAX_COUV_RAPPORT_DTE_ACH", ";")
		dDteMaxCouv = f_plus_date( dDteAchat, Long(Left(sVal, Len(sVal) -1)) , Right(sVal,1) )	
		
		if dDteSurv < dDteDebCouv or dDteSurv >= ddteMaxCouv Then
			bRet = Uf_RF_EcrireRefus ( 645 )
		End if
		
		exit
	End If
next

Return ( bRet )




end function

private function string uf_plaf_nbgti_adhesion_par_surv ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_plaf_nbgti_adhesion_par_surv (PRIVATE)
//* Auteur			: F. Pinon
//* Date				: 18/06/2010
//* Libellé			: [DCMP100410]
//* Commentaires	: Application d'un plafond par adhésion/Année survenace glissante/gti
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//			FPI	08/12/2010	[DCMP100410.Correction]
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp, dcIdsDos
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, lTotDetail, lLigDet
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Integer ilNbAutreSinistre, iSinEnCours

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '717'"

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
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	
	sRech	=		"ID_PROD = "				+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "					+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "					+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '-GA'" 																					+ " AND " 	+ &
					"ID_REF_PLAF = -1"																						+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																						+ " AND " 	+ &
					"ID_TYP_PLAF = '717'"

	ilNbAutreSinistre = 0

	//itrTrans.PS_S10_W_GTI_NBGTI_ADHESION( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, dtDteSurv, dcIdGti,  ilNbAutreSinistre )
	itrTrans.PS_S10_W_GTI_NBGTI_ADHESION_V01( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dtDteSurv, dcIdGti,  ilNbAutreSinistre ) //	[DCMP100410.Correction]	
	
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S10_W_GTI_NBGTI_ADHESION" )	Then 
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

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		iSinEnCours		= 1

		If	iSinEnCours + ilNbAutreSinistre > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "717", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "717", "NORMAL" )

		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )

end function

private function string uf_plaf_nbgti_adherent_par_surv ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_plaf_nbgti_adherent_par_surv (PRIVATE)
//* Auteur			: F. Pinon
//* Date				: 18/06/2010
//* Libellé			: [DCMP100410]
//* Commentaires	: Application d'un plafond par adhérent/Année survenace glissante/gti
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//			 FPI	  08/12/2010  [DCMP100410.Correction]
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp, dcIdsDos
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, lTotDetail, lLigDet
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Integer ilNbAutreSinistre, iSinEnCours

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '718'"

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
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	
	sRech	=		"ID_PROD = "				+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "					+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "					+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '-GA'" 																					+ " AND " 	+ &
					"ID_REF_PLAF = -1"																						+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																						+ " AND " 	+ &
					"ID_TYP_PLAF = '718'"

	ilNbAutreSinistre = 0

	//itrTrans.PS_S09_W_GTI_NBGTI_ADHERENT( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dtDteSurv, dcIdGti,  ilNbAutreSinistre )
	itrTrans.PS_S09_W_GTI_NBGTI_ADHERENT_V01( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsdos, dtDteSurv, dcIdGti,  ilNbAutreSinistre ) //	[DCMP100410.Correction]
		
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S09_W_GTI_NBGTI_ADHERENT" )	Then 
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

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		iSinEnCours		= 1

		If	iSinEnCours + ilNbAutreSinistre > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "718", sIdPara, sCptVer )

			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "718", "NORMAL" )

		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )

end function

private function boolean uf_rf_1419 ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_Sinistre_Garantie::uf_Rf_1419 (PRIVATE)
//* Date				: 
//* Libellé			: NB SINISTRE DEPASSE PAR ADHESION
//* Commentaires	: [DCMP100570]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//       JFF   07/05/2013 [MIG19_PSPLAF_SAGA2]
//*-----------------------------------------------------------------
Long lTotPlaf, lLig, lCpt, lDeb, lFin, lRow
Boolean bRet
Decimal dcIdSin, dcIdProd, dcIdEts, dcPlafond
String sIdAdh, sVal
Integer iNbAutreSin 
String sRech
DateTime dtMajLe 

bRet				= True
lTotPlaf 		= idw_Plafond.RowCount ()

dcIdSin= idw_wSin.GetItemDecimal ( 1, "ID_SIN" )
dcIdProd= idw_wSin.GetItemDecimal ( 1, "ID_PROD" )
dcIdEts= idw_wSin.GetItemDecimal ( 1, "ID_ETS" )
sIdAdh =idw_wSin.GetItemString( 1, "ID_ADH" )

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond 										  */
/*------------------------------------------------------------------*/
sRech	=		"ID_PROD = "		+ String ( dcIdProd ) 			+ " AND " 	+ &
				"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
				"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
				"ID_NIV_PLAF = '-GA' AND " 	+ &
				"ID_REF_PLAF = -1    AND " 	+ &
				"ID_CPT_PLAF = 0"																					+ " AND " 	+ &
				"ID_TYP_PLAF = '715'"

lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

If	lLig > 0 Then
	
	SQLCA.PS_S07_W_GTI_NBSIN ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, iNbAutreSin )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S07_W_GTI_NBSIN" )	Then 
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée, on affiche le message.             */
/*------------------------------------------------------------------*/
		f_Message ( stMessage )
		bRet=FALSE
	Else

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		
		If	1 + iNbAutreSin > dcPlafond	Then
			bRet = Uf_RF_EcrireRefus ( 1419 )

			// [MIG19_PSPLAF_SAGA2]
			If F_CLE_A_TRUE ( "MIG19_PSPLAF_SAGA2" ) Then
				F_RechDetPro(lDeb, lFin, idw_detpro, idw_produit.getItemNumber(1,"ID_PROD"),"-DP", 395)
				If lDeb > 0 Then	
			
					lRow = idw_wdivsin.Find("UPPER(NOM_ZONE)='ADH_DEJA_INDEM'", 1, idw_wdivsin.RowCount())
					If lRow> 0 Then
						sVal = idw_wdivsin.GetItemString (lRow, "VAL_CAR") 
					
						If sVal <> "O" Then
							idw_wdivSin.SetItem ( lRow, "VAL_CAR", "O" )
							dtMajLe = DateTime ( Today (), Now () )
							idw_wDivSin.SetItem ( lRow, "MAJ_LE", dtMajLe  )
							idw_wDivSin.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )
							idw_wDivSin.SetItem ( lRow, "ALT_SUPP", "N" )
						End If
					End If
				End If 			
			End If
		End If
	End if
End If

Return ( bRet )
end function

private function boolean uf_rf_1420 ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_Sinistre_Garantie::uf_Rf_1420 (PRIVATE)
//* Date				: 
//* Libellé			: NB SINISTRE DEPASSE PAR ADHERENT
//* Commentaires	: [DCMP100570]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
Long lTotPlaf, lLig, lCpt
Boolean bRet
Decimal dcIdSin, dcIdProd, dcIdEts, dcPlafond, dcIdsDos
String sIdAdh 
Integer iNbAutreSin 
String sRech

bRet				= True
lTotPlaf 		= idw_Plafond.RowCount ()

dcIdSin= idw_wSin.GetItemDecimal ( 1, "ID_SIN" )
dcIdProd= idw_wSin.GetItemDecimal ( 1, "ID_PROD" )
dcIdEts= idw_wSin.GetItemDecimal ( 1, "ID_ETS" )
sIdAdh =idw_wSin.GetItemString( 1, "ID_ADH" )
dcIdsDos		= idw_wSin.GetItemNumber ( 1, "ID_SDOS" )
	
/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond 										  */
/*------------------------------------------------------------------*/
sRech	=		"ID_PROD = "		+ String ( dcIdProd ) 			+ " AND " 	+ &
				"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
				"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
				"ID_NIV_PLAF = '-GA' AND " 	+ &
				"ID_REF_PLAF = -1    AND " 	+ &
				"ID_CPT_PLAF = 0"																					+ " AND " 	+ &
				"ID_TYP_PLAF = '716'"

lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

If	lLig > 0 Then
	
	SQLCA.PS_S08_W_GTI_NBSIN ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, iNbAutreSin )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S08_W_GTI_NBSIN" )	Then 
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée, on affiche le message.             */
/*------------------------------------------------------------------*/
		f_Message ( stMessage )
		bRet=FALSE
	Else

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		
		If	1 + iNbAutreSin > dcPlafond	Then
			bRet = Uf_RF_EcrireRefus ( 1420 )
		End If
	End if
End If

Return ( bRet )
end function

private function string uf_plaf_nbgti_pec_adherent_par_surv ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_plaf_nbgti_pec_adherent_par_surv (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 08/12/2010
//* Libellé			: [PC397][PC441][PC443]
//* Commentaires	: Application d'un plafond par adhérent/Année survenace glissante/gti
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp, dcIdsDos
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, lTotDetail, lLigDet
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Integer ilNbAutreSinistre, iSinEnCours

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '720'"

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
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )

	ilNbAutreSinistre = 0

	SQLCA.PS_S12_W_GTI_NBGTI_PEC_ADHERENT( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, dtDteSurv, dcIdGti,  ilNbAutreSinistre )
		
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S12_W_GTI_NBGTI_PEC_ADHERENT" )	Then 
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

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		iSinEnCours		= 1

		If	iSinEnCours + ilNbAutreSinistre > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "720", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "720", "NORMAL" )

		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )

end function

private function string uf_plaf_nbgti_pec_adhesion_par_surv ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_plaf_nbgti_adhesion_par_surv (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 08/12/2010
//* Libellé			: [PC397][PC441][PC443]
//* Commentaires	: Application d'un plafond par adhésion/Année survenace glissante/gti
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, lTotDetail, lLigDet
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Integer ilNbAutreSinistre, iSinEnCours

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '719'"

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

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )

	ilNbAutreSinistre = 0

	itrTrans.PS_S11_W_GTI_NBGTI_PEC_ADHESION( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dtDteSurv, dcIdGti,  ilNbAutreSinistre )
		
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S11_W_GTI_NBGTI_PEC_ADHESION" )	Then 
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

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		iSinEnCours		= 1

		If	iSinEnCours + ilNbAutreSinistre > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "719", sIdPara, sCptVer )

			// [PLAF_REF] 
			sPos = Uf_Plaf_Refus ( "719", "NORMAL" )

		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )

end function

private function boolean uf_rf_1450 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_1450
//* Auteur			: FPI
//* Date				: 17/12/2010
//* Libellé			: 
//* Commentaires	: dte_surv < dte_affil
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------

Long lNbrCarteAffilier, dcIdProd, dcIdRev, dcIdGti, dcIdCarte
String	sIdAdh
Datetime dtDteSurv, dteAffil

Boolean bRet

bRet = True
dcIdRev 	= idw_wSin.GetItemNumber ( 1, "ID_REV" )
sIdAdh	= idw_wSin.GetItemString 	  ( 1, "ID_ADH" )

If	idw_Produit.GetItemString ( 1, "COD_ADH" ) = "3" 	And &
	dcIdRev 		<> -1 											And &
	Not isNull ( sIdAdh )										And &
	sIdAdh		<> ""				 								Then

	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdCarte	= idw_wSin.GetItemNumber ( 1, "ID_CARTE" )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	
	dtDteSurv= idw_wSin.GetItemDatetime ( 1, "DTE_SURV" )
	
	itrTrans.PS_S02_AFFILIER_SINISTRE ( dcIdProd, dcIdRev, dcIdGti, dcIdCarte, dteAffil )
	
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S01_AFFILIER_SINISTRE" )	Then 
/*------------------------------------------------------------------*/
/* Il y a une erreur dans l'appel de la procédure, la structure     */
/* stMessage vient d'être armée, on affiche le message.             */
/*------------------------------------------------------------------*/
		bRet = False
		F_Message ( stMessage )
	Else

		If	dteAffil > dtDteSurv	Then

			bRet = Uf_RF_EcrireRefus ( 1450 )	
		End If
	End If
End If

Return ( bRet )
end function

private function boolean uf_rf_1456 (long aldeb, long alfin);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_Sinistre_Garantie::uf_rf_1456 (PRIVATE)
//* Auteur			: JFF
//* Date				: 27/01/2011
//* Libellé			: [PC414].[REFUS1456]
//* Commentaires	: Refus si panne au déballage
//*
//* Arguments		: alDeb		Integer 		Val
//*					  alFin		Integer 		Val
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//		FPI	07/03/2011	 [DCMP090652]
//		FPI	28/11/2012	[VDoc8949]
//		FPI	24/04/2013	[PC929_CDISCOUNT]
//*-----------------------------------------------------------------

Date dDteSurv, dDteAchat, dDtePivot
Long lDuree 
n_cst_string lnvPFCString
String sUnite, sTypAppLu, sTypAppSin
Long lRow
Date dDteAdh, dDteAdhMaxLu, dDteAdhLu
String sDteAdhLu, sDtePivot
Long lRowDefaut[4] = {-1,-1,-1,-1}
Long lIdGti, lIdGtiDetPro
n_cst_string nvString
Boolean bRet

bRet = True

dDteAchat 	= Date(idw_wSin.GetItemDateTime ( 1, "DTE_ACH_PORT" )) // [PI056]

dDteSurv 	= idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE"  )
	
lIdGti= idw_wgarsin.GetItemNumber(1,"ID_GTI") // [VDoc8949]

If IsNull ( dDteAchat ) Or IsNull ( dDteSurv ) Then
	bRet = Uf_RF_EcrireRefus ( 1456 )
	Return bRet
End IF

// [DCMP090652]
sTypAppSin=""
lRow=idw_wdivsin.find("nom_zone='type_app'",1,idw_wdivsin.RowCount())
if lRow > 0 Then sTypAppSin = idw_wdivsin.GetItemString(lRow,"VAL_CAR")

dDteAdh = idw_wsin.GetItemDate(1,"DTE_ADH")
SetNull(dDteAdhMaxLu)

// Détermination des lignes pertinentes
/*
lRowDefaut est rempli selon l'importance du paramétrage :
1 : la date d'adhésion pivot et le type d'appareil sont renseignés
2 : seul le type d'appareil est renseigné
3 : seule la date d'adhésion est renseignée
4 : aucune des 2 valeurs n'est renseignée
*/
for lRow=alDeb to alFin
	
	SetNull(dDteAdhLu)
	
	sTypAppLu = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lRow, "VAL_CAR" ), "TYPE_APP", ";")
	sDteAdhLu= lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lRow, "VAL_CAR" ), "DTE_ADH", ";")
	
	If sDteAdhLu <> "" Then dDteAdhLu = Date(sDteAdhLu)
	
	// [VDoc8949]
	lIdGtiDetPro=idw_DetPro.GetItemNumber( lRow, "ID_CODE_NUM" )
	If lIdGtiDetPro <> -1 and lIdGtiDetPro <> lIdGti Then Continue			
	If sTypAppLu="" Then
		if sDteAdhLu="" Then
			If lRowDefaut[4] =-1 Then lRowDefaut[4] = lRow
		Else
			If (isnull(dDteAdhMaxLu) or dDteAdhLu > dDteAdhMaxLu) and dDteAdh >= dDteAdhLu Then
				dDteAdhMaxLu	= Date(sDteAdhLu)
				If lRowDefaut[3] =-1 Then lRowDefaut[3]=lRow
			End If
		End If
	Else
		If Pos(sTypAppLu,"#" + sTypAppSin + "#") > 0 Then
			if sDteAdhLu="" Then
				If lRowDefaut[2] =-1 Then lRowDefaut[2] = lRow
			Else
				If (isnull(dDteAdhMaxLu) or dDteAdhLu > dDteAdhMaxLu) and dDteAdh >= dDteAdhLu Then
					dDteAdhMaxLu	= Date(sDteAdhLu)
					If lRowDefaut[1] =-1 Then lRowDefaut[1]=lRow
				End If
			End If
		End if
	End if

Next

alDeb=-1 // [VDoc8949]
	
For lRow = 1 To 4
	If lRowDefaut[lRow] <> -1 Then 
		alDeb= lRowDefaut[lRow] 
		Exit
	End if
Next
// :[DCMP090652]

if alDeb=-1 Then Return true// [VDoc8949]

lDuree = Long ( lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( alDeb, "VAL_CAR" ), "DUREE_GTI_PANNE_DEBALLAGE", ";"))
sUnite = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( alDeb, "VAL_CAR" ), "UNITE_DUREE", ";")

dDtePivot = F_Plus_Date ( dDteAchat, lDuree, sUnite )

// [PC929_CDISCOUNT]
lRow=idw_wdivsin.Find("Upper(nom_zone)='DTE_DEB_GTI'",1,idw_wdivsin.RowCount())
If lRow > 0 Then
	dDtePivot 	= Date(idw_wdivsin.GetItemDateTime ( lRow, "VAL_DTE" )) 	// [PI056].20190926
	dDtePivot = RelativeDate(dDtePivot,-1)
End if
// :[PC929_CDISCOUNT]

If dDteSurv <= dDtePivot Then
	bRet = Uf_RF_EcrireRefus ( 1456 )
End IF

Return ( bRet )

end function

private function boolean uf_rf_1459 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_1459 (PRIVATE)
//* Auteur			: FPI
//* Date				: 23/02/2011 07:28
//* Libellé			: [VDoc1851]
//* Commentaires	: Délai de carence (dte surv > dte_adh+dl)
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*			FPI	07/09/2011	[PC387] si présence délai 631 , on regarde la date d'achat
//*			FPI	07/11/2011	[PC581-1] délai 630 activé uniqt si "Eco-avantage" cochée avec DP 201
//          JFF   23/06/2020  [PC202553_SELECTRA]
//*-----------------------------------------------------------------
Long lTotDelai, lLig, lDuree, lCpt, lLigFinale , lLig2, lDeb, lFin
String sIdNivDel, sIdRefDel, sIMEI_Saisi, sIMEI_Ctrle1, sIMEI_Ctrle2
Date dDateImeiCtrl1, dDateImeiCtrl2


Boolean bRet

String sRech, sUnite

Date	dDteSurv, dDteAdh, dDteMin, dDteTemp, dDteSav,dDteAchPort
n_cst_string nvstring

bRet				= True
lTotDelai 		= idw_Delai.RowCount ()
lLigFinale		= 0
SetNull ( dDteSav )

dDteAdh = idw_wSin.GetItemDate ( 1, "DTE_ADH" )

// [PC202553_SELECTRA]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 348 )
If lDeb > 0 Then
	lCpt=idw_wdivsin.Find("UPPER(NOM_ZONE)='TYPE_APP'", 1, idw_wdivsin.RowCount())
	If lCpt > 0 Then
		If idw_wdivsin.GetItemString(lCpt, "VAL_CAR") = "TEL" Then 
			sIMEI_Saisi = idw_wSin.GetItemString ( 1, "NUM_IMEI_PORT" )

			lCpt = idw_wdivsin.Find("UPPER(NOM_ZONE)='IMEI_CTRL_1'", 1, idw_wdivsin.RowCount())
			If lCpt> 0 Then
				sIMEI_Ctrle1 = idw_wdivsin.GetItemString (lCpt, "VAL_CAR") 
				If IsNull ( sIMEI_Ctrle1 ) Then sIMEI_Ctrle1 = ""
			End If
			
			lCpt = idw_wdivsin.Find("UPPER(NOM_ZONE)='IMEI_CTRL_2'", 1, idw_wdivsin.RowCount())
			If lCpt> 0 Then
				sIMEI_Ctrle2 = idw_wdivsin.GetItemString (lCpt, "VAL_CAR") 
				If IsNull ( sIMEI_Ctrle2 ) Then sIMEI_Ctrle2 = ""
			End If

			If sIMEI_Saisi = sIMEI_Ctrle1 Then
				lCpt = idw_wdivsin.Find("UPPER(NOM_ZONE)='DTE_IMEI_CTRL_1'", 1, idw_wdivsin.RowCount())
				If lCpt> 0 Then
					dDateImeiCtrl1 = Date ( idw_wdivsin.GetItemDateTime (lCpt, "VAL_DTE") )
					If IsNull ( dDateImeiCtrl1 ) Or dDateImeiCtrl1 = 1900-01-01 Then
						bRet = Uf_RF_EcrireRefus ( 1459 )
						Return bRet 
					End If 
					dDteAdh = dDateImeiCtrl1 
				End If 						
			End If 
			
			If sIMEI_Saisi = sIMEI_Ctrle2 And sIMEI_Saisi <> sIMEI_Ctrle1 Then
				lCpt = idw_wdivsin.Find("UPPER(NOM_ZONE)='DTE_IMEI_CTRL_2'", 1, idw_wdivsin.RowCount())
				If lCpt> 0 Then
					dDateImeiCtrl2 = Date ( idw_wdivsin.GetItemDateTime (lCpt, "VAL_DTE") )
					If IsNull ( dDateImeiCtrl2 ) Or dDateImeiCtrl2 = 1900-01-01 Then
						bRet = Uf_RF_EcrireRefus ( 1459 )
						Return bRet 
					End If 
					dDteAdh = dDateImeiCtrl2
				End If 
			End If 
			
		End If 
	End if
End If


dDteAchPort 	= Date(idw_wSin.GetItemDateTime ( 1, "DTE_ACH_PORT" )) // [PI056] // [PC387]

// [PC581-1] 
F_rechdetPro(lLig, lLig2, idw_detpro,idw_wSin.GetItemNumber( 1, "ID_PROD" ), '-DP', 201)
If lLig > 0 Then
	lCpt=idw_wdivsin.Find("UPPER(NOM_ZONE)='ECO_AVANTAGE'", 1, idw_wdivsin.RowCount())
	If lCpt > 0 Then
		If idw_wdivsin.GetItemString(lCpt, "VAL_CAR") = "N" Then Return TRUE
	End if
End if
// :[PC581-1] 

For lCpt = 1 to 4

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
			sIdNivDel = "+DT"  // Détail
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
	End Choose

	If IsNull ( sIdRefDel ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un délai de déclaration pour la garantie. */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_DEL = '"  + sIdNivDel 																+ "' AND " 	+ &
					"ID_REF_DEL = "	+ sIdRefDel 																+ " AND " 	+ &
					"ID_TYP_DEL = '630'"

	lLig = idw_Delai.Find ( sRech, 1, lTotDelai )

	// [PC387] - Si le délai 631 est paramétré dans les mêmes conditions, on compare la date d'adhésion à la date d'achat
	If not isNull(dDteAchPort) Then
		sRech=nvstring.of_globalreplace( sRech,"ID_TYP_DEL = '630'","ID_TYP_DEL = '631'")
		lLig2 = idw_Delai.Find ( sRech, 1, lTotDelai )

		If lLig> 0 And lLig2 > 0 and dDteAdh<> dDteAchPort Then Continue
	End if
	// :[PC387]
	
	If lLig > 0 Then	

		sUnite	= idw_Delai.GetItemString ( lLig, "UNT_DEL" )
		lDuree	= idw_Delai.GetItemNumber ( lLig, "DUR_MAX" )

		dDteTemp	= F_Plus_Date ( dDteAdh, lDuree, sUnite )

		// On prend la date la plus loin paramétrée
		If Not IsNull ( dDteSav ) Then

			If dDteTemp > dDteSav Then 
				dDteSav = dDteTemp
				lLigFinale = lLig
			End If

		Else
			dDteSav = dDteTemp
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On récupére le délai minimum autorisé entre la survenance du     */
/* sinistre et la date d'adhésion. On vérifie si ce délai est   */
/* dépassé.                                                         */
/*------------------------------------------------------------------*/
	dDteSurv = idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )
	
	sUnite	= idw_Delai.GetItemString ( lLig, "UNT_DEL" )
	lDuree	= idw_Delai.GetItemNumber ( lLig, "DUR_MAX" )

	dDteMin	= F_Plus_Date ( dDteAdh, lDuree, sUnite ) // Normalement égal à dteSav

	If	dDteSurv < dDteMin	Then
		bRet = Uf_RF_EcrireRefus ( 1459 )
	End If
End If

Return ( bRet )
end function

private function boolean uf_rf_1486 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_1486 (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 17/05/2011
//* Libellé			: 
//* Commentaires	: [VDOC3604]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		
//*
//*-----------------------------------------------------------------

Date dDteSurv, dDtePivot

Boolean bRet

bRet = True

/*------------------------------------------------------------------*/
/* On déclenche ce motif de refus si la date de fin de garantie     */
/* est connue ( donc adhésion SPB ) et inférieure à la date du      */
/* sinistre.                                                        */
/* Il faut également de la date de résiliation soit renseignée (    */
/* sinon voir refus 603 )                                           */
/*------------------------------------------------------------------*/

dDteSurv 	= idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE"  )
dDtePivot   = F_Plus_Date ( dDteSurv, 2, "A" )

If	isNull ( dDteSurv ) Or ( dDtePivot < Today () ) Then
	bRet = Uf_RF_EcrireRefus ( 1486 )
End If

Return ( bRet )

end function

private function boolean uf_rf_1493 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_1493 (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 22/06/2011
//* Libellé			: 
//* Commentaires	: [PC545].[POINT].[262]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		
//*
//*-----------------------------------------------------------------

Date dDteAdh, dDtePivot, dDteAchat
Long lDeb, lFin
n_cst_string lnvPFCString
Boolean bRet
String sDuree, sUnite

bRet = True

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 174 )

sDuree = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "DUREE", ";")
sUnite = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "UNITE", ";")

dDteAdh = idw_wSin.GetItemDate ( 1, "DTE_ADH"  )
dDteAchat = Date(idw_wSin.GetItemDateTime ( 1, "DTE_ACH_PORT"  ) ) // [PI056]

dDtePivot = F_Plus_Date ( dDteAchat, Long ( sDuree ), sUnite )

If	isNull ( dDteAdh ) Or isNull ( dDteAchat ) Or ( dDteAdh > dDtePivot ) Then
	bRet = Uf_RF_EcrireRefus ( 1493 )
End If

Return ( bRet )

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
//        JFF    16/11/2015 [DT159-1]
//*-----------------------------------------------------------------
Long lTotPlaf, lLig, lLig681, lTotDetail, lLigDet, lCpt, lLigFinale, lFin

Decimal {2} dcPlafond, dcMtPlafaReg, dcMtPlafReg, dcPlafond681, dcPlafTmp, dcPlafSav, dcEcoTaxe

String sRech, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
String sPos
Long lDeb
String sVal
String sIdEvt[]
n_cst_string lnvpfcstring

sPos = ""

dcPlafond681 = 0
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 1 to 4

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
/*------------------------------------------------------------------*/
/* Le 30/10/1998.                                                   */
/* Pour le produit SECURILION, on vérifie s'il existe un plafond    */
/* complémentaire 681. Ce plafond sert à augmenter le plafond de    */
/* remboursement pour les cartes Premier. S'il existe une carte de  */
/* type C5, pour en détail avec COD_ETAT = 100,200,500, 600 le      */
/* montant du plafond 680 est additionné au montant du plafond 681. */
/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "				+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "					+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "					+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '-GA'" 																					+ " AND " 	+ &
					"ID_REF_PLAF = -1"																						+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																						+ " AND " 	+ &
					"ID_TYP_PLAF = '681'"

	lLig681 = idw_Plafond.Find ( sRech, 1, lTotPlaf )
	If	lLig681 > 0 Then
		sRech 		= "ID_TYPE_CARTE = 'C5' And ( COD_ETAT = 500 Or COD_ETAT = 600 Or COD_ETAT = 200 Or COD_ETAT = 100 )"
		lTotDetail 	= idw_LstDetail.RowCount ()
		lLigDet		= idw_LstDetail.Find ( sRech, 1, lTotDetail )
		If	lLigDet > 0 Then
			dcPlafond681 = idw_Plafond.GetItemDecimal ( lLig681, "MT_PLAF" )
		End If
	End If

/*------------------------------------------------------------------*/
/* Modification DBI le 12/08/1998                                   */
/*                                                                  */
/* La zone à prendre en compte pour le calcul du montant plafonné   */
/* n'est pas MT_NPLAF_AREG mais MT_PLAF_AREG sinon on ne            */
/* tient pas compte des plafonds appliqués successivement           */
/*------------------------------------------------------------------*/

	dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG" )
	dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )

	dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" ) + dcPlafond681

	// [DT159-1]
	F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
	If lDeb > 0 Then 	
		dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
		If dcEcoTaxe > 0 Then 
			dcPlafond += dcEcoTaxe 
		End If
	End If

	// [PC925].Mantis10568
	sRech="ID_PROD = " + String ( idw_wsin.GetItemNumber(1,"ID_PROD" ))
	sRech+=" And ID_TYP_CODE_DP = '-DP' AND ID_CODE_DP = 257"
	sRech+=" And ID_CODE_NUM=680"
	lDeb=idw_detpro.find(sRech, 1, idw_detpro.RowCount())
		
	If lDeb > 0 Then
		sVal=idw_detpro.GetItemString(lDeb, "VAL_CAR")
		sVal=lnvPFCString.of_getkeyvalue( sVal, "ID_EVT", ";")
		lnvPFCString.of_parsetoarray( sVal,"#", sIdEvt )

		For lCpt=1 to UpperBound(sIdEvt)
			If sIdEvt[lCpt] ="" Then Continue
			lDeb=idw_lstdetail.Find("ID_EVT=" + 	sIdEvt[lCpt] + " And COD_ETAT in (500,600) And MT_PLAF > 0", 1, idw_lstdetail.RowCount() )
			If lDeb > 0 Then
				dcPlafond+=idw_lstdetail.GetItemDecimal(lDeb, "MT_PLAF")
			End if
		Next
	End if
	// :[PC925].Mantis10568
	
	If	dcMtPlafReg + dcMtPlafaReg  > dcPlafond	Then
		
		If dcPlafond - dcMtPlafReg > 0 Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", dcPlafond - dcMtPlafReg )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "680", "REF_PLAF_NUM_>0" )
			
		Else
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			// [PLAF_REF]
			sPos = Uf_Plaf_Refus ( "680", "NORMAL" )
		End If	

		idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
		/*------------------------------------------------------------------*/
		/* On insére le paragraphe de plafond dans la DW.                   */
		/*------------------------------------------------------------------*/
		sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
		sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
		Uf_Plaf_EcrirePara ( "680", sIdPara, sCptVer )
		
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return sPos
end function

private function string uf_plaf_nbsin_numport_annee_civile ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbSin_NumPort_Annee_Civile (PRIVATE)
//* Auteur			: FPI
//* Date				: 05/05/2011
//* Libellé			: Plafond Nbre Sinistres par numéro de portable sinistré et année civile.
//* Commentaires	: [PC345][PLAF_REF]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Integer iNbAutreSin, iSinEnCours
Long dcIdSin, dcIdProd
DateTime dtDteSurv
String sRech, sPos, sNumPort, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '723'"

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

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	sNumPort	= idw_wSin.GetItemString 	 ( 1, "NUM_PORT" )
	
	sNumPort	= F_REMPLACE ( sNumPort	, " ", "" )
	
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	iNbAutreSin = 0

	SQLCA.PS_S13_W_GTI_NBSIN_NUM_PORT ( dcIdSin, dcIdProd, sNumPort , dtDteSurv, iNbAutreSin )

	If	Not F_Procedure ( stMessage, itrTrans, "PS_S13_W_GTI_NBSIN_NUM_PORT" )	Then 
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

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		iSinEnCours		= 1

		If	iSinEnCours + iNbAutreSin > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "723", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "723", "NORMAL")	
			
		End If
	End If
End If

Return sPos
	

end function

private function string uf_plaf_nbgti_adherent ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_plaf_nbgti_adherent (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 23/08/2011
//* Libellé			: [PLAF_REF]
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp, dcIdsDos
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, lTotDetail, lLigDet
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Integer ilNbAutreSinistre, iSinEnCours

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '725'"

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
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )

	ilNbAutreSinistre = 0

	itrTrans.PS_S15_W_GTI_NBGTI_ADHERENT ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsdos, dcIdGti,  ilNbAutreSinistre ) 
		
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S15_W_GTI_NBGTI_ADHERENT" )	Then 
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

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		iSinEnCours		= 1

		If	iSinEnCours + ilNbAutreSinistre > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "725", sIdPara, sCptVer )

			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "725", "NORMAL" )

		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )

end function

private function string uf_plaf_nbgti_adhesion ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_plaf_nbgti_adhesion (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 23/08/2011
//* Libellé			: [PLAF_REF]
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, lTotDetail, lLigDet
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Integer ilNbAutreSinistre, iSinEnCours

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '724'"

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

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	
	ilNbAutreSinistre = 0

	itrTrans.PS_S14_W_GTI_NBGTI_ADHESION ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti,  ilNbAutreSinistre ) 
		
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S14_W_GTI_NBGTI_ADHESION" )	Then 
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

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		iSinEnCours		= 1

		If	iSinEnCours + ilNbAutreSinistre > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "724", sIdPara, sCptVer )

			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "724", "NORMAL" )

		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )

end function

private function boolean uf_rf_1497 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_1497 (PRIVATE)
//* Auteur			: FPI
//* Date				: 07/09/2011
//* Libellé			: [PC387]
//* Commentaires	: Délai de carence (dte surv > dte_adh+dl) si dte_adh<>dte_ach
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------
Long lTotDelai, lLig, lDuree, lCpt, lLigFinale 
String sIdNivDel, sIdRefDel
Boolean bRet
String sRech, sUnite
Date	dDteSurv, dDteAdh, dDteMin, dDteTemp, dDteSav,dDteAchPort

bRet				= True
lTotDelai 		= idw_Delai.RowCount ()
lLigFinale		= 0
SetNull ( dDteSav )

dDteAdh = idw_wSin.GetItemDate ( 1, "DTE_ADH" )
dDteAchPort = Date(idw_wSin.GetItemDateTime ( 1, "DTE_ACH_PORT"  ) ) // [PI056]

If IsNull(dDteAchPort) Then return TRUE // si la date d'achat n'est pas renseigné, pas de delai 631

if dDteAdh= dDteAchPort Then Return TRUE // On déclenche le refus uniqt si dte_adh<>dte_ach

For lCpt = 1 to 4

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
			sIdNivDel = "+DT"  // Détail
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
	End Choose

	If IsNull ( sIdRefDel ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un délai de déclaration pour la garantie. */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_DEL = '"  + sIdNivDel 																+ "' AND " 	+ &
					"ID_REF_DEL = "	+ sIdRefDel 																+ " AND " 	+ &
					"ID_TYP_DEL = '631'"

	lLig = idw_Delai.Find ( sRech, 1, lTotDelai )

	If lLig > 0 Then	

		sUnite	= idw_Delai.GetItemString ( lLig, "UNT_DEL" )
		lDuree	= idw_Delai.GetItemNumber ( lLig, "DUR_MAX" )

		dDteTemp	= F_Plus_Date ( dDteAdh, lDuree, sUnite )

		// On prend la date la plus loin paramétrée
		If Not IsNull ( dDteSav ) Then

			If dDteTemp > dDteSav Then 
				dDteSav = dDteTemp
				lLigFinale = lLig
			End If

		Else
			dDteSav = dDteTemp
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On récupére le délai minimum autorisé entre la survenance du     */
/* sinistre et la date d'adhésion. On vérifie si ce délai est   */
/* dépassé.                                                         */
/*------------------------------------------------------------------*/
	dDteSurv = idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )
	
	sUnite	= idw_Delai.GetItemString ( lLig, "UNT_DEL" )
	lDuree	= idw_Delai.GetItemNumber ( lLig, "DUR_MAX" )

	dDteMin	= F_Plus_Date ( dDteAdh, lDuree, sUnite ) // Normalement égal à dteSav

	If	dDteSurv < dDteMin	Then
		bRet = Uf_RF_EcrireRefus ( 1497 )
	End If
End If

Return ( bRet )
end function

private function string uf_plaf_nbsingti_adhesion_survenance ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbSinGti_Adhesion_Survenance (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 22/11/2011
//* Libellé			: [PC581].[POINT155][VDOC5984]
//* Commentaires	: Plafond NB SIN/GTI/ANNEE SURV. GLISS&ADHESION  
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Integer iNbAutreSin, iSinEnCours
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '726'"

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

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	
	iNbAutreSin = 0

	itrTrans.PS_S09_W_GTI_NBSIN ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, dtDteSurv, iNbAutreSin )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S09_W_GTI_NBSIN" )	Then 
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

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		iSinEnCours		= 1

		If	iSinEnCours + iNbAutreSin > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "726", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "726", "NORMAL" )			
			
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If


Return ( sPos )
	

end function

private function string uf_plaf_nbsingti_adhesion_renouvellement ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbSinGti_Adhesion_Renouvellement (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 22/11/2011
//* Libellé			: [PC581].[POINT155][VDOC5984]
//* Commentaires	: NB SIN/GTI/ANNEE RENOUV&ADHESION 
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------
Long lTotPlaf, lLig, lCpt, lLigFinale, lCptMax
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Integer iNbAutreSin, iSinEnCours
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '728'"

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

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
   sUntPerRnv_Adh		   = idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
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

	dtDteAdhRenouv = DateTime ( dDteAdh )
	iNbAutreSin = 0

	itrTrans.PS_S11_W_GTI_NBSIN ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, dtDteSurv, dtDteAdhRenouv, iNbAutreSin )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S11_W_GTI_NBSIN" )	Then 
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
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
		iSinEnCours		= 1

		If	iSinEnCours + iNbAutreSin > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "728", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "728", "NORMAL" )			
			
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If


Return ( sPos )
	


end function

private function string uf_plaf_nbsingti_adherent_survenance ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbSinGti_Adherent_Survenance (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 22/11/2011
//* Libellé			: [PC581].[POINT155][VDOC5984]
//* Commentaires	: NB SIN/GTI/ANNEE SURV. GLISS&ADHERENT 
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Long dcIdSin, dcIdProd, dcIdEts, dcIdsDos, dcIdGti
Integer iSinEnCours, iNbAutreSin
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '727'"

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
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
				
	iNbAutreSin = 0
	itrTrans.PS_S10_W_GTI_NBSIN ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, dcIdsDos, dtDteSurv, iNbAutreSin )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S10_W_GTI_NBSIN" )	Then 
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

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		iSinEnCours		= 1

		If	iSinEnCours + iNbAutreSin > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "727", sIdPara, sCptVer )

			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "727", "NORMAL" )

		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )
end function

private function string uf_plaf_nbsingti_adherent_renouvellement ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbSinGti_Adherent_Renouvellement (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 22/11/2011
//* Libellé			: [PC581].[POINT155][VDOC5984]
//* Commentaires	: NB SIN/GTI/ANNEE RENOUV&ADHERENT
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF	  29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale, lCptMax
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Long dcIdSin, dcIdProd, dcIdEts, dcIdsDos, dcIdGti
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Integer iNbAutreSin, iSinEnCours
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh


sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()

dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '729'"

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
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
   sUntPerRnv_Adh		   = idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
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

	dtDteAdhRenouv = DateTime ( dDteAdh )
	iNbAutreSin = 0

	itrTrans.PS_S12_W_GTI_NBSIN ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, dcIdsDos, dtDteSurv, dtDteAdhRenouv, iNbAutreSin )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S12_W_GTI_NBSIN" )	Then 
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

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
		iSinEnCours		= 1

		If	iSinEnCours + iNbAutreSin > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "729", sIdPara, sCptVer )
			
			// [PLAF_REF]  // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "729", "NORMAL" )			
			
		End If
	End If

End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )	

end function

public function string uf_plaf_refus (string astypplaf, string ascas);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Refus (PRIVATE)
//* Auteur			: Fabry JFF
//* Date				: 29/07/2011 
//* Libellé			: 
//* Commentaires	: [PLAF_REF]
//*
//* Arguments		: String  asTypPlaf   Val
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

// Return ""

// [PLAF_REF]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 183 )
If lDeb > 0 Then
	For lCpt = lDeb To lFin
		If Long ( idw_DetPro.GetItemString ( lCpt, "ID_CODE_CAR" ) ) = Long ( asTypPlaf ) Then
			sValCar = idw_DetPro.GetItemString ( lCpt, "VAL_CAR" )
			lCodeRef = Long ( lnvPFCString.of_getkeyvalue( sValCar, "REF_GTI", ";"))

			// [VDOC6662]	
			If asCas = "NORMAL" &
					OR ( lnvPFCString.of_getkeyvalue( sValCar, "REF_PLAF_NUM_>0", ";") = "OUI" And &
						  asCas = "REF_PLAF_NUM_>0" ) Then

						// Evol
						If Long ( lnvPFCString.of_getkeyvalue( sValCar, "REF_EVT", ";")) > 0 And lCodeRef = 0 Then
							Continue
						End if
			
						ibPlafRef = lCodeRef > 0 
					
						If Not Uf_RF_EcrireRefus ( lCodeRef ) Then
							sPos = "MT_PROV"
						End If
						
						// [VDOC6662]	
						If asCas = "REF_PLAF_NUM_>0" Then 
							idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
							idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
						End IF
						
			End If
		End If 
	Next
End If
// [PLAF_REF]

Return sPos 
end function

private function string uf_plaf_adhesion_gti ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_plaf_adhesion_gti (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 26/02/1998 15:07:49
//* Libellé			: 
//* Commentaires	: Application d'un plafond numéraire par adhésion et gti
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
//        JFF   16/11/2015 [DT159-1]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale, lLig701, lDeb, lFin
Decimal {2} dcPlafond, dcMtPlafaReg, 	dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcPlafond701, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, lTotDetail, lLigDet
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
For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '732'"

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
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

		
	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S_W_GTI_PLAF_ADHESION ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S_W_GTI_PLAF_ADHESION" )	Then 
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
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG"  )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond Then
			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", ( dcPlafond ) - ( dcMtPlafReg + dcMtAutreSinistre ) )
				
				// [PLAF_REF] // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "732", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "732", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "732", sIdPara, sCptVer )

		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )
	

end function

private function string uf_plaf_adherent_gti ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_plaf_adherent_gti (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 14/06/2012
//* Libellé			: 
//* Commentaires	: Application d'un plafond numéraire par adhérent et gti
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
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale, lLig701, lDeb, lFin
Decimal {2} dcPlafond, dcMtPlafaReg, 	dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcPlafond701, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, lTotDetail, lLigDet, dcIdsDos
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
For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '733'"

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
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

		
	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S_W_GTI_PLAF_ADHERENT ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, dcIdGti, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S_W_GTI_PLAF_ADHERENT" )	Then 
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
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG"  )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If


		If	dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond Then
			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", ( dcPlafond ) - ( dcMtPlafReg + dcMtAutreSinistre ) )
				
				// [PLAF_REF] // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "733", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "733", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "733", sIdPara, sCptVer )

		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )
	

end function

private function string uf_plaf_adhesion_survenance_ttegti ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adhesion_Survenance_TteGti (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 26/11/2012
//* Libellé			: [PC877]
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
Decimal {2} dcPlafond, dcMtPlafaReg, 	dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, lTotDetail, lLigDet
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
For lCpt = 1 to 4

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
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S734_W_GTI_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dtDteSurv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S734_W_GTI_MT_PLAF" )	Then 
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
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG"  )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond Then
			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", ( dcPlafond ) - ( dcMtPlafReg + dcMtAutreSinistre ) )
				
				// [PLAF_REF] // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "734", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "734", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
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

private function string uf_plaf_adherent_survenance_ttegti ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adherent_Survenance_TteGti (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 26/11/2012
//* Libellé			: [PC877]
//* Commentaires	: Application d'un plafond par adhésion/Année survenace glissante
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//       JFF   16/11/2015 [DT159-1]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale, lDeb, lFin
Decimal {2} dcPlafond, dcMtPlafaReg, 	dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdsDos
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
n_cst_string lnvPFCString
// [DCMP050255]
long lTotDetail, lLigDet


sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '735'"

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
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

		
	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S735_W_GTI_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, dtDteSurv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S735_W_GTI_MT_PLAF" )	Then 
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
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG"  )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond Then // DCMP 050255 : Prise en compte plafond 706
			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", ( dcPlafond ) - ( dcMtPlafReg + dcMtAutreSinistre ) )
				
				// [PLAF_REF] // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "735", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )

				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "735", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "735", sIdPara, sCptVer )

		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If	

Return ( sPos )
end function

private function string uf_plaf_adhesion_renouvellement_ttegti ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adhesion_Renouvellement_TteGti (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 26/11/2012 
//* Libellé			: [PC877]
//* Commentaires	: Application d'un plafond par adhésion/Année renouvellement
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//			FPI	26/03/2014	[PC925].Mantis10568
//       JFF   16/11/2015 [DT159-1]
//			FPI	19/10/2017	[VDOC24781]
//*-----------------------------------------------------------------
Long lTotPlaf, lLig, lCpt, lLigFinale, lCptMax
Decimal {2} dcPlafond, dcMtPlafaReg, dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh
Long lDeb, lFin
String sVal
n_cst_string lnvPFCString
String sIdEvt[]

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '736'"

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
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
   sUntPerRnv_Adh		   = idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
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

	dtDteAdhRenouv = DateTime ( dDteAdh )
	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S736_W_GTI_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dtDteSurv, dtDteAdhRenouv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S736_W_GTI_MT_PLAF" )	Then 
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
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If
		
		// [PC925].Mantis10568
		sRech="ID_PROD = " + String ( idw_wsin.GetItemNumber(1,"ID_PROD" ))
		sRech+=" And ID_TYP_CODE_DP = '-DP' AND ID_CODE_DP = 257"
		sRech+=" And ID_CODE_NUM=736"
		lDeb=idw_detpro.find(sRech, 1, idw_detpro.RowCount())
			
		If lDeb > 0 Then
			sVal=idw_detpro.GetItemString(lDeb, "VAL_CAR")
			sVal=lnvPFCString.of_getkeyvalue( sVal, "ID_EVT", ";")
			lnvPFCString.of_parsetoarray( sVal,"#", sIdEvt )

			For lCpt=1 to UpperBound(sIdEvt)
				If sIdEvt[lCpt] ="" Then Continue
				lDeb=idw_lstdetail.Find("ID_EVT=" + 	sIdEvt[lCpt] + " And COD_ETAT in (500,600) And MT_PLAF > 0", 1, idw_lstdetail.RowCount() )
				If lDeb > 0 Then
					dcPlafond+=idw_lstdetail.GetItemDecimal(lDeb, "MT_PLAF")
				End if
			Next
		End if
		//:[PC925].Mantis10568
		
		// [VDOC24781]
		dcMtPlafaReg= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg=idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG" )
		For lDeb=1 To idw_lstgti.RowCount()

			if idw_lstGti.GetItemNumber( lDeb, "ID_GTI") =  idw_wGarSin.GetItemNumber( 1, "ID_GTI") Then Continue
			
			dcMtAutreSinistre	+= idw_lstGti.GetItemDecimal ( lDeb, "MT_PLAF_AREG" )
			dcMtAutreSinistre		+= idw_lstGti.GetItemDecimal ( lDeb, "MT_PLAF_REG" )
		Next
		// :[VDOC24781]

		If	dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond	Then
			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) )
				
				// [PLAF_REF]  // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "736", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "736", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "736", sIdPara, sCptVer )
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )
	


end function

private function string uf_plaf_adherent_renouvellement_ttegti ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adherent_Renouvellement_TteGti (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 26/11/2012
//* Libellé			: [PC877]
//* Commentaires	: Application d'un plafond par adhérent/Année renouvellement
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//       JFF   16/11/2015 [DT159-1]
//		FPI	19/10/2017	 [VDOC24781]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale , lCptMax, lDeb, lFin
Decimal {2} dcPlafond, dcMtPlafaReg, dcMtPlafReg, dcPlafSav, dcPlafTmp, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdsDos
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
For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '737'"

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
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
   sUntPerRnv_Adh		   = idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
/*----------------------------------------------------------------------*/
/* On calcule la date du dernier renouvellement.                        */
/* En fonction de l'unité de période de renouvellement (ANNEE,MOIS,JOUR)*/
/*----------------------------------------------------------------------*/
Choose Case sUntPerRnv_Adh
	   Case "A"
	     lCptMax = 30
	   Case "M"
	     lCptMax = 360
	   Case "J"
	    lCptMax = 10950
End Choose  

For lCpt = 1 To lCptMax
	dDteResult = F_Plus_Date ( dDteAdh, dcDurPerRnv_Adh, sUntPerRnv_Adh )
	If	dDteResult <= idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )	Then
		dDteAdh = dDteResult
	Else
		Exit
	End If
Next

	dtDteAdhRenouv = DateTime ( dDteAdh )
	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S737_W_GTI_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, dtDteSurv, dtDteAdhRenouv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S737_W_GTI_MT_PLAF" )	Then 
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
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
		
		// [VDOC24781]
		dcMtPlafaReg= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg=idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG" )
		For lDeb=1 To idw_lstgti.RowCount()

			if idw_lstGti.GetItemNumber( lDeb, "ID_GTI") =  idw_wGarSin.GetItemNumber( 1, "ID_GTI") Then Continue
			
			dcMtAutreSinistre	+= idw_lstGti.GetItemDecimal ( lDeb, "MT_PLAF_AREG" )
			dcMtAutreSinistre	+= idw_lstGti.GetItemDecimal ( lDeb, "MT_PLAF_REG" )
		Next
		// :[VDOC24781]

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond	Then
			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) )
				
				// [PLAF_REF] // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "737", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "737", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "737", sIdPara, sCptVer )
		End If
	End If

End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )	

end function

private function string uf_plaf_siren_adh_renouv_ttegti ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Siren_Adh_Renouv_TteGti (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 26/11/2012 
//* Libellé			: [PC877]
//* Commentaires	: Application d'un plafond par adhésion/Année renouvellement
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//       JFF   16/11/2015 [DT159-1]
//*-----------------------------------------------------------------
Long lTotPlaf, lLig, lCpt, lLigFinale, lCptMax, dcIdProdAdh, lDeb, lFin
Decimal {2} dcPlafond, dcMtPlafaReg, dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcEcoTaxe
Long dcIdSin, dcIdProd, dcIdEts
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh, sIdSiren		
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
For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '738'"

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
	dcIdProdAdh	= idw_produit.GetItemNumber ( 1, "COD_PROD_DMS" )
	sIdSiren		= idw_wSin.GetItemString ( 1, "ID_CONTRAT_ABONNE" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
   sUntPerRnv_Adh		   = idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
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

	dtDteAdhRenouv = DateTime ( dDteAdh )
	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S738_W_GTI_MT_PLAF ( dcIdSin, dcIdProdAdh, sIdSiren, dtDteSurv, dtDteAdhRenouv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S738_W_GTI_MT_PLAF" )	Then 
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
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG" )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond	Then
			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) )
				
				// [PLAF_REF]  // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "738", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "738", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "738", sIdPara, sCptVer )
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )
	


end function

private function boolean uf_rf_1676 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_1676 (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 17/05/2011
//* Libellé			: 
//* Commentaires	: [PC938_ORANGE_V3]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		
//*
//*-----------------------------------------------------------------
//		FPI	13/06/2013 [PC938_CTL_IMEI]
//    JFF   17/06/2013 [PC946_ORANGE_OPPRO]
//    JFF   18/08/2013 [VDOC12141]
//		FPI	02/10/2013 [PC958] Orange Caraibe
//		FPI	05/08/2014 [DT031-2]
//		FPI	27/11/2015 [VDOC19078]
//		FPI	24/05/2016 [ITSM384602] - correction effacement de la DDU
//    JFF   28/09/2016 [DT262]
//    JFF   03/03/2025 [PMO268_MIG48]
//*-----------------------------------------------------------------

String sNumPort, sIMEI, sVal
Long lRet, lDeb, lFin, lIdProd, lRow, lVal, lCpt
DateTime dteSurv, dtMajLe, dtDerTrans
Boolean bRet, bOrangeCaraibe, bRenseignerDDU
n_cst_string lnvPFCString
Integer iVal

bRet = True
bRenseignerDDU=FALSE

sIMEI		= Trim ( idw_wSin.GetItemString ( 1, "NUM_IMEI_PORT"  ))

// [DT262]
F_RechDetPro(lDeb, lFin, idw_detpro, idw_produit.getItemNumber(1,"ID_PROD"),"-DP", 308)
If lDeb > 0 And ( sIMEI = "" Or IsNUll ( sIMEI )) Then
	Return True
End If

/*------------------------------------------------------------------*/
/* On déclenche ce motif de refus si la date de fin de garantie     */
/* est connue ( donc adhésion SPB ) et inférieure à la date du      */
/* sinistre.                                                        */
/* Il faut également de la date de résiliation soit renseignée (    */
/* sinon voir refus 603 )                                           */
/*------------------------------------------------------------------*/
// [VDOC12141]
lRow = idw_wdivSin.find("UPPER(NOM_ZONE)='TYPE_APP'", 1, idw_wDivSin.rowCount()+1)
If lRow > 0 Then
	sVal = idw_wdivSin.GetItemString ( lRow, "VAL_CAR" )		
	
	// [DT031-2]
	f_rechdetpro(lDeb, lFin, idw_detpro, idw_produit.getItemNumber(1,"ID_PROD"),"-DP", 263)
	Choose Case sVal
		Case "TEL"
			// On fait le contrôle
		Case "PC2"
			// Contrôle uniqt si DP 263
			if lDeb <=0 Then Return TRUE
		Case Else
			// Autres types d'appareil, pas de ctl
			Return TRUE
	End choose
	// :[DT031-2]
End If

lRow = idw_wdivSin.find("UPPER(NOM_ZONE)='CTRL_IMEI_SUCCES'", 1, idw_wDivSin.rowCount()+1)
If lRow > 0 Then
	sVal = idw_wdivSin.GetItemString ( lRow, "VAL_CAR" )
	If IsNull ( sVal ) Then sVal = "N"
	If sVal = "O" Then Return TRUE
End if 

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 239 )

// [DT031-2]
If lDeb <= 0 Then F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 263 )
// :[DT031-2]

// [PC958] 
bOrangeCaraibe=FALSE
if lDeb <= 0 Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 249 )
	If lDeb > 0 Then bOrangeCaraibe=TRUE
End if
// :[PC958] 

sVal = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")			

// Orange V3
If lDeb > 0 And sVal = "" Then

	sNumPort = Trim ( idw_wSin.GetItemString ( 1, "NUM_PORT"  ))

	sNumPort	= F_REMPLACE ( sNumPort	, " ", "" )
	
	dteSurv = idw_wSin.GetItemDateTime( 1, "DTE_SURV")
	
	If IsNull ( sNumPort ) Then sNumPort = ""
	If IsNull ( sIMEI		) Then sIMEI	 = ""
	sNumPort = F_REMPLACE ( sNumPort, " ", "" )
	
	If sNumPort = "" Or sIMEI = "" Then
		Return Uf_RF_EcrireRefus ( 1676 )
	End If
	
	lRow=idw_wdivSin.find("UPPER(NOM_ZONE)='CRA_SUIVI_IMEI'", 1, idw_wDivSin.rowCount()+1)
	if lRow > 0 Then
		iVal=idw_wdivSin.GetItemNumber ( lRow, "VAL_NBRE" )
		If isNull(iVal) Then iVal=0
	End if
	
	// [BUG_IMEIOK]
	If iVal=2 Then // IMEI OK pas de vérif
		lRet=1
	Else
		// [PC958] 
		If bOrangeCaraibe Then
			lRet = SQLCA.PS_S01_CTL_IMEI_ORANGECARAIBE (  sNumPort, sIMEI, dteSurv ) 
		Else		
			// [DT031-2]
			lRet = SQLCA.PS_S01_CTL_IMEI_ORANGEV3_V02 (  sNumPort, sIMEI, dteSurv, dtDerTrans ) 
			// [DT031-2]
						
			// [VDOC19078]
			// [ITSM384602] - correction effacement de la DDU
			bRenseignerDDU=(isNull(dtDerTrans)=FALSE)
			
			If lRet > 0 Then
				If Date(dtDerTrans) < idw_wSin.getItemDate(1, "DTE_ADH") Then
					lRet=0
				End if
			End if
			// :[VDOC19078]
		End if
		// :[PC958] 
	End if
	
	// [VDOC12141]
	If lRet > 0 Then
		lRow = idw_wdivSin.find("UPPER(NOM_ZONE)='CTRL_IMEI_SUCCES'", 1, idw_wDivSin.rowCount()+1)
		If lRow > 0 Then
			idw_wdivSin.SetItem ( lRow, "VAL_CAR", "O" )
			dtMajLe = DateTime ( Today (), Now () )
			idw_wDivSin.SetItem ( lRow, "MAJ_LE", dtMajLe  )
			idw_wDivSin.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )
			idw_wDivSin.SetItem ( lRow, "ALT_SUPP", "N" )
		End if 
	End If

	// [DT031-2]
	If lRet > 0  or bRenseignerDDU Then // [VDOC19078]
		lRow = idw_wdivSin.find("UPPER(NOM_ZONE)='CRA_LAST_DTE'", 1, idw_wDivSin.rowCount()+1)
		If lRow > 0 Then
			idw_wdivSin.SetItem ( lRow, "VAL_DTE", dtDerTrans )
			dtMajLe = DateTime ( Today (), Now () )
			idw_wDivSin.SetItem ( lRow, "MAJ_LE", dtMajLe  )
			idw_wDivSin.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )
			idw_wDivSin.SetItem ( lRow, "ALT_SUPP", "N" )
		End if 
	End If
	// :[DT031-2]
	
	If	lRet = 0 Then
		bRet = Uf_RF_EcrireRefus ( 1676 )
	End If

End If

// [PC946_ORANGE_OPPRO]
If lDeb > 0 And sVal = "ORANGE_OPEN_PRO" Then
	lRow = idw_wdivsin.Find("UPPER(NOM_ZONE)='CRA_SUIVI_IMEI'", 1, idw_wdivsin.RowCount())
	If lRow> 0 Then
		lVal = idw_wdivsin.GetItemNumber (lRow, "VAL_NBRE") 
		If IsNull ( lVal ) Then lVal = 0
		Choose Case lVal
			Case 0, 1, 2
				// Ok
			Case Else
				bRet = Uf_RF_EcrireRefus ( 1676 )
		End CHoose
	End if
End If

// [KSV649_ORREUCARA]
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 387)
If lDeb <= 0 Then 
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 388)
End If 

// [PMO268_MIG48]
If lDeb <= 0 Then 
	F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 394 )
End If 

If lDeb > 0 Then
	lRow = idw_wdivsin.Find("UPPER(NOM_ZONE)='CRA_SUIVI_IMEI'", 1, idw_wdivsin.RowCount())
	If lRow> 0 Then
		lVal = idw_wdivsin.GetItemNumber (lRow, "VAL_NBRE") 
		If IsNull ( lVal ) Then lVal = 0
		Choose Case lVal
			Case 100
				bRet = Uf_RF_EcrireRefus ( 1676 )
		End CHoose
	End if	
End IF 



Return ( bRet )


end function

private function boolean uf_rf_1654 ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_rf_1654 (PRIVATE)
//* Auteur			: FPI
//* Date				: 14/06/2013
//* Libellé			: [PC918]
//* Commentaires	: Délai de carence dépassé
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------
Long lTotDelai, lLig, lDuree, lCpt, lLigFinale 
String sIdNivDel, sIdRefDel

Boolean bRet

String sRech, sUnite

Date	dDteSurv,  dDteMax, dDteTemp, dDteSav, dDteAchCoque, dDteAchMobile

bRet				= True
lTotDelai 		= idw_Delai.RowCount ()
lLigFinale		= 0
SetNull ( dDteSav )

dDteSurv = idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )
dDteAchMobile = Date(idw_wSin.GetItemDateTime ( 1, "DTE_ACH_PORT" ) ) // [PI056]

lLig=idw_wdivsin.Find("UPPER(NOM_ZONE) = 'DTE_ACH_COQUE'",1,idw_wdivsin.RowCount())
if lLig > 0 Then
	dDteAchCoque = Date(idw_wdivsin.GetItemDateTime ( lLig, "VAL_DTE" )) 	// [PI056].20190926
Else 
	// La zone "achat de coque" n'existe pas : le produit n'est pas concerné par ce refus
	Return TRUE 
End if

For lCpt = 1 to 4

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
			sIdNivDel = "+DT"  // Détail
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
	End Choose

	If IsNull ( sIdRefDel ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un délai de déclaration pour la garantie. */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_DEL = '"  + sIdNivDel 																+ "' AND " 	+ &
					"ID_REF_DEL = "	+ sIdRefDel 																+ " AND " 	+ &
					"ID_TYP_DEL = '633'"

	lLig = idw_Delai.Find ( sRech, 1, lTotDelai )

	If lLig > 0 Then	

		sUnite	= idw_Delai.GetItemString ( lLig, "UNT_DEL" )
		lDuree	= idw_Delai.GetItemNumber ( lLig, "DUR_MAX" )

		dDteTemp	= F_Plus_Date ( dDteSurv, lDuree, sUnite )

		If Not IsNull ( dDteSav ) Then

			If dDteTemp < dDteSav Then 
				dDteSav = dDteTemp
				lLigFinale = lLig
			End If

		Else
			dDteSav = dDteTemp
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale
/*------------------------------------------------------------------*/
/* FIN #1																			  */
/*------------------------------------------------------------------*/


If	lLig > 0 Then

	If isNull(dDteAchMobile) Then 
		bRet=Uf_RF_EcrireRefus ( 1654 )
		Return bRet
	End if
	
	// Le refus ne s'applique que si l'achat de la coque est postérieure à la date d'achat du mobile
	If dDteAchCoque <= dDteAchMobile Then Return TRUE 
	
	sUnite	= idw_Delai.GetItemString ( lLig, "UNT_DEL" )
	lDuree	= idw_Delai.GetItemNumber ( lLig, "DUR_MAX" )

	dDteMax	= F_Plus_Date ( dDteAchCoque, lDuree, sUnite )

	If	dDteSurv < dDteMax	Then
/*------------------------------------------------------------------*/
/* La durée maximum de déclaration est dépassée, on déclenche le    */
/* refus 1654.                                                       */
/*------------------------------------------------------------------*/
		bRet = Uf_RF_EcrireRefus ( 1654 )
	End If
End If

Return ( bRet )
end function

private function string uf_plaf_adhesion_annee_civile_val_achat ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adhesion_Annee_Civile_val_achat (PRIVATE)
//* Auteur			: Catherine Abdmeziem/ JFF
//* Date				: 31/07/2004
//* Libellé			: PC845_NOUVPLAF
//* Commentaires	: Application d'un plafond par adhésion/Année civile
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//* #2	FPI	 18/01/2010	[DCMP090687] Ajout du plafond 713
//* #3	FPI	 27/01/2010	[DCMP100063] Ajout du plafond 714
//* #4	FPI	09/02/2010	[DCMP100063.Correctif] Correction du SetItem
//*       JFF   27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//       JFF   16/11/2015 [DT159-1]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale, lRow, lDeb, lFin
Decimal {2} dcPlafond, dcMtPlafaReg, 	dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Long lLig713, lligdet, ltotdetail	// #2
Decimal {2} dcPlafond713, dcPlafond714	// #2 - #3 
Long lLig714		// #3
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
For lCpt = 1 to 4

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
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				

	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S05_W_GTI_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, dtDteSurv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S05_W_GTI_MT_PLAF" )	Then 
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
		
//		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
// [PC845] C'est la variante de ce plafond, on garde les requête existante du 673 et 674, mais on ne compare
// pas à une valeur fixe paramètrée sur le plafond, mais à la valeur d'achat du détail
//		dcMtPlaf		= idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT"   )
		lRow = idw_LstDetail.Find ( "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) ) + " AND MT_VAL_ACHAT > 0 ", 1, idw_LstDetail.Rowcount() )
		If lRow > 0 Then
			dcPlafond = idw_LstDetail.GetItemDecimal ( lRow, "MT_VAL_ACHAT" )
			
			// [DT159-1]
			F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
			If lDeb > 0 Then 	
				dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
				If dcEcoTaxe > 0 Then 
					dcPlafond += dcEcoTaxe 
				End If
			End If
			
		Else
			dcPlafond = 0
		End If
		
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG"  )

		If	dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond  Then // #2 ajout de +dcPlafond713 // #3 - [DCMP100063] ajout de +dcPlafond714

			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", (dcPlafond ) - ( dcMtPlafReg + dcMtAutreSinistre ) )
				
				// [PLAF_REF] // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "739", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "739", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "739", sIdPara, sCptVer )			
			
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )
	

end function

private function string uf_plaf_adherent_annee_civile_val_achat ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adherent_Annee_Civile_val_achat (PRIVATE)
//* Auteur			: Catherine Abdmeziem / JFF
//* Date				: 31/07/2013
//* Libellé			: PC845_NOUVPLAF
//* Commentaires	: Application d'un plafond par adhérent/Année civile
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale, lRow, lDeb, lFin
Decimal {2} dcPlafond, dcMtPlafaReg, 	dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdsDos
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
For lCpt = 1 to 4

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
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdsDos		= idw_wSin.GetItemNumber ( 1, "ID_SDOS" )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S06_W_GTI_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, dcIdGti, dtDteSurv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S06_W_GTI_MT_PLAF" )	Then 
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

//		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
// [PC845] C'est la variante de ce plafond, on garde les requête existante du 673 et 674, mais on ne compare
// pas à une valeur fixe paramètrée sur le plafond, mais à la valeur d'achat du détail
//		dcMtPlaf		= idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT"   )
		lRow = idw_LstDetail.Find ( "ID_GTI = " + String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) ) + " AND MT_VAL_ACHAT > 0 ", 1, idw_LstDetail.Rowcount() )
		If lRow > 0 Then
			dcPlafond = idw_LstDetail.GetItemDecimal ( lRow, "MT_VAL_ACHAT" )

			// [DT159-1]
			F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
			If lDeb > 0 Then 	
				dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
				If dcEcoTaxe > 0 Then 
					dcPlafond += dcEcoTaxe 
				End If
			End If
			
		Else
			dcPlafond = 0
		End If		
	
		
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG"  )

		If	dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond	Then
			
			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) )

				// [PLAF_REF] // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "740", "REF_PLAF_NUM_>0" )

				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "740", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "740", sIdPara, sCptVer )

		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If
	
Return ( sPos )
end function

private function string uf_plaf_evt1397_regle_resil_adh ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Evt1397_regle_resil_adh (PRIVATE)
//* Auteur			: JFF
//* Date				: 25/09/2013
//* Libellé			: PC845_NOUVPLAF741 
//* Commentaires	: Application d'un plafond par adhésion/Année civile
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//* #2	FPI	 18/01/2010	[DCMP090687] Ajout du plafond 713
//* #3	FPI	 27/01/2010	[DCMP100063] Ajout du plafond 714
//* #4	FPI	09/02/2010	[DCMP100063.Correctif] Correction du SetItem
//*       JFF   27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale, lRow 
Decimal {2} dcPlafond, dcMtPlafaReg, 	dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcMtPlaf
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, dcIdEvt
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Long lLig713, lligdet, ltotdetail	// #2
Decimal {2} dcPlafond713, dcPlafond714	// #2 - #3 
Long lLig714		// #3

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 1 to 4

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
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dcPlafond	= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
	dcIdEvt		= dcPlafond

	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S_W_DETAIL_MT_PLAF_EVT_REGLE ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdEvt , sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S_W_DETAIL_MT_PLAF_EVT_REGLE" )	Then 
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
		
//	dcMtPlaf		= idw_wDetailFF.GetItemDecimal ( 1, "MT_PLAF"   )
// [PC845] C'est la variante de ce plafond, on garde les requête existante du 673 et 674
// On recherche juste un evt 1397 réglé.
		if idw_LstDetail.Find ( "ID_EVT = " + String ( dcPlafond) + " AND COD_ETAT = 600", 1, idw_LstDetail.RowCount ()) > 0 Then
			dcMtPlaf		= 1 // On veut juste que ce soit positif.
		End if
		
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG"  )

		If	dcMtAutreSinistre + dcMtPlaf > 0 Then // #2 ajout de +dcPlafond713 // #3 - [DCMP100063] ajout de +dcPlafond714

			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			// [PLAF_REF]
			sPos = Uf_Plaf_Refus ( "741", "NORMAL" )

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "741", sIdPara, sCptVer )			
			
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )
	

end function

private function string uf_plaf_nbsin_adhesion_renouv_dte_surv ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbSin_Adhesion_Renouv_dte_surv (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 04/10/2013
//* Libellé			: [VDOC11880]
//* Commentaires	: NB SIN/ANNEE RENOUV&ADHESION 
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------
Long lTotPlaf, lLig, lCpt, lLigFinale, lCptMax
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Integer iNbAutreSin, iSinEnCours
Long dcIdSin, dcIdProd, dcIdEts 
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '742'"

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

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
   sUntPerRnv_Adh		   = idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
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

	dtDteAdhRenouv = DateTime ( dDteAdh )
	iNbAutreSin = 0

	itrTrans.PS_S03_W_GTI_NBSIN_DTE_SURV ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dtDteSurv, dtDteAdhRenouv, iNbAutreSin )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S03_W_GTI_NBSIN_DTE_SURV" )	Then 
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
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
		iSinEnCours		= 1

		If	iSinEnCours + iNbAutreSin > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "742", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "742", "NORMAL" )			
			
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If


Return ( sPos )
	


end function

private function boolean uf_rf_1720 (integer aldeb, integer alfin);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_Sinistre_Garantie::uf_Rf_1720 (PRIVATE)
//* Date				: 17/12/2013
//* Libellé			: Refus GTI NON COUVERTE SANS OUV AUTRE GTI
//* Commentaires	: [PC947&977]
//*
//* Arguments		: Int		alDeb			Val		Point d'entrée dans DET_PRO
//*					  Int		alFin			Val		Point de fin dans DET_PRO
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
// 17/09/2018	FPI	[VDOC26776]
//*-----------------------------------------------------------------

Long lLig, lIdGti, lCpt 
Boolean bRet
n_cst_string lnvPFCString
String sValCar 
Long lIdGtiACtrl, lIdGtiEnCours, lTotRow, lRowDp

bRet = True

// [VDOC26776]
lIdGtiEnCours = idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )

For lRowDp=alDeb to alFin
	lIdGtiACtrl = idw_DetPro.GetItemNumber ( lRowDp, "ID_CODE_NUM" )
	
	If lIdGtiEnCours <> lIdGtiACtrl Then Continue

	// On est sur la ligne de det_pro lié à la garantie à contrôler
	sValCar = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lRowDp, "VAL_CAR" ), "GTI_OBLIG", ";")
	
	For lCpt = 1 To  idw_LstGti.RowCount () 

		lIdGti = idw_LstGti.GetItemNumber ( lCpt, "ID_GTI" ) 
		If lIdGti = lIdGtiEnCours Then Continue
	
		If Pos ( sValCar, "#" + String ( lIdGti ) + "#" ) > 0 Then
			Return TRUE
		End If
	next
	
	bRet = Uf_RF_EcrireRefus ( 1720 )
Next
// :[VDOC26776]

Return ( bRet )




end function

public function boolean uf_rf_1731 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_1731
//* Auteur			: FPI
//* Date				: 31/03/2014
//* Libellé			: [PC13362]
//* Commentaires	: Délai date adhésion postérieure date achat dépassé
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//			FPI	15/05/2014	[VDOC14423]
//*-----------------------------------------------------------------
Long lTotDelai, lLig, lDuree, lCpt, lLigFinale 
String sIdNivDel, sIdRefDel

Boolean bRet

String sRech, sUnite

Date	dDteAch, dDteAdh, dDteMax, dDteTemp, dDteSav

bRet				= True
lTotDelai 		= idw_Delai.RowCount ()
lLigFinale		= 0
SetNull ( dDteSav )

dDteAch=Date(idw_wSin.GetItemDateTime ( 1, "DTE_ACH_PORT" ) ) // [PI056]
dDteAdh=idw_wSin.GetItemDate ( 1, "DTE_ADH" ) 

For lCpt = 1 to 4

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
			sIdNivDel = "+DT"  // Détail
			sIdRefDel = String ( idw_wSin.GetItemNumber ( 1, "ID_DETSIN" ) )
	End Choose

	If IsNull ( sIdRefDel ) Then Continue

	/*------------------------------------------------------------------*/
	/* On vérifie s'il existe un délai de déclaration pour la garantie. */
	/*------------------------------------------------------------------*/
	sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "			+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_DEL = '"  + sIdNivDel 																+ "' AND " 	+ &
					"ID_REF_DEL = "	+ sIdRefDel 																+ " AND " 	+ &
					"ID_TYP_DEL = '635'"

	lLig = idw_Delai.Find ( sRech, 1, lTotDelai )

	If lLig > 0 Then	

		sUnite	= idw_Delai.GetItemString ( lLig, "UNT_DEL" )
		lDuree	= idw_Delai.GetItemNumber ( lLig, "DUR_MAX" )

		dDteTemp	= F_Plus_Date ( dDteAch, lDuree, sUnite )

		If Not IsNull ( dDteSav ) Then

			If dDteTemp < dDteSav Then 
				dDteSav = dDteTemp
				lLigFinale = lLig
			End If

		Else
			dDteSav = dDteTemp
			lLigFinale = lLig
		End If
	End If

Next

lLig = lLigFinale

// [VDOC14423]
If lLig > 0 And isNull(dDteAch) Then // Si la date d'achat n'est pas renseigné, on coche le refus.
	bRet = Uf_RF_EcrireRefus ( 1731 )
	lLig=0
End if
// :[VDOC14423]

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On récupére le délai maximum autorisé entre la survenance du     */
/* sinistre et la date de déclaration. On vérifie si ce délai est   */
/* dépassé.                                                         */
/*------------------------------------------------------------------*/
	sUnite	= idw_Delai.GetItemString ( lLig, "UNT_DEL" )
	lDuree	= idw_Delai.GetItemNumber ( lLig, "DUR_MAX" )

	dDteMax	= F_Plus_Date ( dDteAch, lDuree, sUnite )

	If	dDteMax	 < dDteAdh Then
/*------------------------------------------------------------------*/
/* La durée maximum d'adhésion est dépassée, on déclenche le    */
/* refus 1731.                                                       */
/*------------------------------------------------------------------*/
		bRet = Uf_RF_EcrireRefus ( 1731 )
	End If
End If

Return ( bRet )
end function

public function boolean uf_rf_650 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_650 (PRIVATE)
//* Auteur			: FPI
//* Date				: 06/06/2014
//* Libellé			: [VDOC13767]
//* Commentaires	: Seuil d'intervention non atteint
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt
String sIdNivPlaf, sIdRefPlaf
Boolean bRet
Long lTotDetail
Decimal {2} dcMtPrej

String sRech

bRet				= True
lTotPlaf 		= idw_Plafond.RowCount ()

lTotDetail = idw_LstDetail.RowCount ()
For	lCpt = 1 To lTotDetail
	dcMtPrej += idw_LstDetail.GetItemDecimal ( lCpt, "MT_PREJ" )
Next

/*------------------------------------------------------------------*/
/* Si le montant du préjudice est NULL ou égal à zéro, on ne gére   */
/* pas de refus.                                                    */
/*------------------------------------------------------------------*/
If	IsNull ( dcMtPrej ) Or dcMtPrej = 0 Then Return ( bRet )

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond 										  */
/*------------------------------------------------------------------*/
// #3 [DCMP071000] Lecture ID_GTI dans idw_wDetailFF ald de idw_wGarSin
sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
				"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
				"ID_CPT_PLAF = 0"																					+ " AND " 	+ &
				"ID_TYP_PLAF = '746'"

lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* Si le montant du préjudice est strictement inférieur au montant  */
/* du plafond, on déclenche le refus 650.                           */
/*------------------------------------------------------------------*/
	If	dcMtPrej < idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )	Then
		bRet = Uf_RF_EcrireRefus (   1764 )
	End If
End If

Return ( bRet )
end function

public function boolean uf_rf_654 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_654 (PRIVATE)
//* Auteur			: FPI
//* Date				: 06/06/2014
//* Libellé			: [VDOC13767]
//* Commentaires	: Seuil d'intervention non atteint
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lTotDetail
String sIdNivPlaf, sIdRefPlaf
Boolean bRet

Decimal {2} dcValAchat

String sRech

bRet				= True
lTotPlaf 		= idw_Plafond.RowCount ()

dcValAchat=0
lTotDetail = idw_LstDetail.RowCount ()
For	lCpt = 1 To lTotDetail
	dcValAchat=Max(dcValAchat,idw_LstDetail.GetItemDecimal ( lCpt, "MT_VAL_ACHAT" ))
Next

/*------------------------------------------------------------------*/
/* Si le montant d'achat est NULL ou égal à zéro, on ne gére   */
/* pas de refus.                                                    */
/*------------------------------------------------------------------*/
If	IsNull ( dcValAchat ) Or dcValAchat = 0 Then Return ( bRet )

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond 										  */
/*------------------------------------------------------------------*/
// #2 [DCMP071000] Lecture ID_GTI dans idw_wDetailFF ald de idw_wGarSin
sRech	=		"ID_PROD = "		+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
				"ID_REV = "			+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
				"ID_CPT_PLAF = 0"																					+ " AND " 	+ &
				"ID_TYP_PLAF = '747'"

lLig = idw_Plafond.Find ( sRech, 1, lTotPlaf )

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* Si le montant du préjudice est strictement inférieur au montant  */
/* du plafond, on déclenche le refus 654.                           */
/*------------------------------------------------------------------*/
	If	dcValAchat < idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )	Then
		bRet = Uf_RF_EcrireRefus (   1765 )
	End If
End If

Return ( bRet )
end function

private function boolean uf_rf_1740 ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_rf_1740 (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 31/07/2014
//* Libellé			: 
//* Commentaires	: [PM234-4_V1]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		
//*
//*-----------------------------------------------------------------

Boolean bRet
Long lRow

bRet = True

lRow = idw_wDivSin.Find ( "NOM_ZONE = 'refus_script' AND VAL_NBRE = 1740", 1,  idw_wDivSin.RowCount () )

If	lRow > 0  Then
	bRet = Uf_RF_EcrireRefus ( 1740 )
End If

Return ( bRet )

end function

private function boolean uf_rf_1744 ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_rf_1744 (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 31/07/2014
//* Libellé			: 
//* Commentaires	: [PM234-4_V1]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		
//*
//*-----------------------------------------------------------------

Boolean bRet
Long lRow

bRet = True

lRow = idw_wDivSin.Find ( "NOM_ZONE = 'refus_script' AND VAL_NBRE = 1744", 1,  idw_wDivSin.RowCount () )

If	lRow > 0  Then
	bRet = Uf_RF_EcrireRefus ( 1744 )
End If

Return ( bRet )

end function

private function boolean uf_rf_1745 ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_rf_1745 (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 31/07/2014
//* Libellé			: 
//* Commentaires	: [PM234-4_V1]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		
//*
//*-----------------------------------------------------------------

Boolean bRet
Long lRow

bRet = True

lRow = idw_wDivSin.Find ( "NOM_ZONE = 'refus_script' AND VAL_NBRE = 1745", 1,  idw_wDivSin.RowCount () )

If	lRow > 0  Then
	bRet = Uf_RF_EcrireRefus ( 1745 )
End If

Return ( bRet )

end function

private function string uf_plaf_nbsin_adhesion_survenance_resil (string ascas);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_plaf_nbsin_adhesion_survenance_resil (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 10/11/2014
//* Libellé			: 
//* Commentaires	: Plafond G-(n-1)pec+1décl survglis=>RésilAdh
//*
//* Arguments		: asCas : "CONTROLE" / "REFUS"
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//        JFF   22/04/2020   [DT472]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Integer iNbAutreSin, iSinEnCours
Long dcIdSin, dcIdProd, dcIdEts, lRow, lIdNatSin, lIdGti
DateTime dtDteSurv, dtMajLe
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf, sVal
Boolean bResil

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '748'"

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

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	// [DT472]
	lIdNatSin = idw_wSin.GetItemNumber ( 1, "ID_NATSIN" )
	lIdGti    = idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
				
	iNbAutreSin = 0

	itrTrans.PS_S_W_GTI_NBSIN_RESIL_ADH ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dtDteSurv, iNbAutreSin )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S_W_GTI_NBSIN_RESIL_ADH" )	Then 
		
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

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		iSinEnCours		= 1

		Choose Case asCas
			Case "REFUS"

				If	iSinEnCours + iNbAutreSin > dcPlafond	Then

					// [DT215]
					ibPlaf748 = TRUE 
					
					idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
					idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
		/*------------------------------------------------------------------*/
		/* On insére le paragraphe de plafond dans la DW.                   */
		/*------------------------------------------------------------------*/
					sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
					sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
					Uf_Plaf_EcrirePara ( "1749", sIdPara, sCptVer )
					
					// [PLAF_REF] // [VDOC6662]
					sPos = Uf_Plaf_Refus ( "748", "NORMAL" )			
					
					// [DT472]
					bResil = This.uf_decoder_dp347 ( lIdGti, lIdNatSin, 1749, asCas)
					
					If sPos = "" And bResil Then
				
						stMessage.sTitre		= "Contrôle de gestion d'une garantie"
						stMessage.Icon			= Exclamation!
						stMessage.bErreurG	= FALSE
						stMessage.sVar [1]   = String ( iNbAutreSin ) 
						stMessage.sCode		= "WGAR408"
						F_Message ( stMessage )				
						
					End If

					
				End If
				
			Case "CONTROLE"
				
				// Pour le le cas "Contrôle" je réduis d'une unité le paramètrage
				// Compliqué à expliquer, se référer à la NDC
				
				dcPlafond --
				If dcPlafond < 0 Then 
					dcPlafond = 0
				End If

				// [DT215]
				If	( iSinEnCours + iNbAutreSin > dcPlafond ) And Not ibPlaf748 Then
				
					bResil = This.uf_decoder_dp347 ( lIdGti, lIdNatSin, 1749, asCas)
					
					If sPos = "" And bResil Then
				
						stMessage.sTitre		= "Contrôle de gestion d'une garantie"
						stMessage.Icon			= Exclamation!
						stMessage.bErreurG	= FALSE
						stMessage.sVar [1]   = String ( iNbAutreSin ) 
						stMessage.sCode		= "WGAR409"
						F_Message ( stMessage )				
						
					End If
				End If

				ibPlaf748 = False

		End Choose 
	End If
End If

If asCas = "REFUS" And idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If


Return ( sPos )
	

end function

private function string uf_plaf_adhesion_renouvellement_proddms ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adhesion_Renouvellement_proddms (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 12/12/2014
//* Libellé			: [PC13321]
//* Commentaires	: Application d'un plafond par adhésion/Année renouvellement
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF	  29/05/2012  [VDOC6662]
//        JFF    16/11/2015 [DT159-1]
//*-----------------------------------------------------------------
Long lTotPlaf, lLig, lCpt, lLigFinale, lCptMax, lDeb, lFin
Decimal {2} dcPlafond, dcMtPlafaReg, dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcEcoTaxe
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh
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
For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '749'"

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
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
   sUntPerRnv_Adh		   = idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
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

	dtDteAdhRenouv = DateTime ( dDteAdh )
	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S031_W_GTI_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, dtDteSurv, dtDteAdhRenouv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S031_W_GTI_MT_PLAF" )	Then 
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
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG" )


		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond	Then
			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) )
				
				// [PLAF_REF]  // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "749", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "749", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "749", sIdPara, sCptVer )
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )
	


end function

private function string uf_plaf_nbsin_adhesion_renou_dte_surv_mp ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbSin_Adhesion_Renou_dte_surv_mp (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 04/10/2013
//* Libellé			: [VDOC11880]
//* Commentaires	: NB SIN/ANNEE RENOUV&ADHESION 
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------
Long lTotPlaf, lLig, lCpt, lLigFinale, lCptMax
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Integer iNbAutreSin, iSinEnCours
Long dcIdSin, dcIdProd, dcIdEts 
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '751'"

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

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
   sUntPerRnv_Adh		   = idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
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

	dtDteAdhRenouv = DateTime ( dDteAdh )
	iNbAutreSin = 0

	itrTrans.PS_S751_W_GTI_NBSIN_DTE_SURV ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dtDteSurv, dtDteAdhRenouv, iNbAutreSin )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S751_W_GTI_NBSIN_DTE_SURV" )	Then 
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
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
		iSinEnCours		= 1

		If	iSinEnCours + iNbAutreSin > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "751", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "751", "NORMAL" )			
			
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If


Return ( sPos )
	


end function

private function string uf_plaf_adhesion_renouvellement_ttgti_mp ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adhesion_Renouvellement_TtGti_mp (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 09/09/2015
//* Libellé			: [DT162]
//* Commentaires	: Application d'un plafond par adhésion/Année renouvellement
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//			FPI	26/03/2014	[PC925].Mantis10568
//       JFF   16/11/2015 [DT159-1]
//*-----------------------------------------------------------------
Long lTotPlaf, lLig, lCpt, lLigFinale, lCptMax
Decimal {2} dcPlafond, dcMtPlafaReg, dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh
Long lDeb, lFin
String sVal
n_cst_string lnvPFCString
String sIdEvt[]

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '750'"

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
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
   sUntPerRnv_Adh		   = idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
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

	dtDteAdhRenouv = DateTime ( dDteAdh )
	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S750_W_GTI_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dtDteSurv, dtDteAdhRenouv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S750_W_GTI_MT_PLAF" )	Then 
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
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If
		
		// [PC925].Mantis10568
		sRech="ID_PROD = " + String ( idw_wsin.GetItemNumber(1,"ID_PROD" ))
		sRech+=" And ID_TYP_CODE_DP = '-DP' AND ID_CODE_DP = 257"
		sRech+=" And ID_CODE_NUM=750"
		lDeb=idw_detpro.find(sRech, 1, idw_detpro.RowCount())
			
		If lDeb > 0 Then
			sVal=idw_detpro.GetItemString(lDeb, "VAL_CAR")
			sVal=lnvPFCString.of_getkeyvalue( sVal, "ID_EVT", ";")
			lnvPFCString.of_parsetoarray( sVal,"#", sIdEvt )

			For lCpt=1 to UpperBound(sIdEvt)
				If sIdEvt[lCpt] ="" Then Continue
				lDeb=idw_lstdetail.Find("ID_EVT=" + 	sIdEvt[lCpt] + " And COD_ETAT in (500,600) And MT_PLAF > 0", 1, idw_lstdetail.RowCount() )
				If lDeb > 0 Then
					dcPlafond+=idw_lstdetail.GetItemDecimal(lDeb, "MT_PLAF")
				End if
			Next
		End if
		//:[PC925].Mantis10568
		
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG" )

		If	dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond	Then
			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) )
				
				// [PLAF_REF]  // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "750", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "750", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "750", sIdPara, sCptVer )
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )
	


end function

private function string uf_plaf_nbsin_numport_adhesion ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbSin_NumPort_Adhesion (PRIVATE)
//* Auteur			: JFF
//* Date				: 10/02/2016
//* Libellé			: Plafond Nbre Sinistres par numéro de portable sinistré et année d'adhésion.
//* Commentaires	: [VDOC19396]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//  		 JFF		29/05/2012  [VDOC6662]
//			FPI		30/03/2017	[PLAF_752]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale, dcIdEts, lCptMax
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Integer iNbAutreSin, iSinEnCours
Long dcIdSin, dcIdProd
DateTime dtDteSurv, dtDteAdhRenouv
String sRech, sPos, sNumPort, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf, sIdAdh
Date dDteAdh, dDteResult
Decimal{5} dcDurPerRnv_Adh
String     sUntPerRnv_Adh

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '752'"

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

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	sNumPort	= idw_wSin.GetItemString 	 ( 1, "NUM_PORT" )

	sNumPort	= F_REMPLACE ( sNumPort	, " ", "" )
	
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
   sUntPerRnv_Adh		   = idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
			
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

	dtDteAdhRenouv = DateTime ( dDteAdh )
				
	iNbAutreSin = 0

	SQLCA.PS_S_W_GTI_NBSIN_NUM_PORT_ANN_ADH (dcIdSin,dcIdProd,dcIdEts,sIdAdh,sNumPort,dtDteSurv, dtDteAdhRenouv, iNbAutreSin ) 

	If	Not F_Procedure ( stMessage, itrTrans, "PS_S_W_GTI_NBSIN_NUM_PORT_ANN_ADH" )	Then 
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

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		iSinEnCours		= 1

		If	iSinEnCours + iNbAutreSin > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "752", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			// [PLAF_752]
			sPos = Uf_Plaf_Refus ( "752", "NORMAL")						
			// :[PLAF_752]
			
		End If
	End If
End If

Return sPos
	

end function

private function boolean uf_rf_1810 ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_rf_1745 (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 30/06/2016
//* Libellé			: 
//* Commentaires	: [PC151549]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		
//*
//*-----------------------------------------------------------------

Boolean bRet
Long lRow, lIdGti

bRet = True

lIdGti = idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )

lRow = idw_wDivSin.Find ( "NOM_ZONE = 'opt_accessoire' AND VAL_CAR = 'O'", 1,  idw_wDivSin.RowCount () )

If	lRow <= 0 And lIdGti = 53 Then
	bRet = Uf_RF_EcrireRefus ( 1810 )
End If

Return ( bRet )

end function

private function string uf_plaf_adhesion_annee_civile_tt_gti ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adhesion_Annee_Civile_tt_gti (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 04/10/2017
//* Libellé			: [VDOC24781]
//* Commentaires	: Application d'un plafond par adhésion/Année civile
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//* #2	FPI	 18/01/2010	[DCMP090687] Ajout du plafond 713
//* #3	FPI	 27/01/2010	[DCMP100063] Ajout du plafond 714
//* #4	FPI	09/02/2010	[DCMP100063.Correctif] Correction du SetItem
//*       JFF   27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//       JFF   16/11/2015 [DT159-1]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale, lDeb, lFin
Decimal {2} dcPlafond, dcMtPlafaReg, 	dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Long lLig713, lligdet, ltotdetail	// #2
Decimal {2} dcPlafond713, dcPlafond714	// #2 - #3 
Long lLig714		// #3
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
For lCpt = 1 to 4

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
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	// #2
	sRech	=		"ID_PROD = "				+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "					+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "					+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '-GA'" 																					+ " AND " 	+ &
					"ID_REF_PLAF = -1"																						+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																						+ " AND " 	+ &
					"ID_TYP_PLAF = '713'"

	lLig713 = idw_Plafond.Find ( sRech, 1, lTotPlaf )
	dcPlafond713 = 0
	If	lLig713 > 0 Then
		sRech 		= "ID_TYPE_CARTE = 'C5' And ( COD_ETAT = 500 Or COD_ETAT = 600 Or COD_ETAT = 200 Or COD_ETAT = 100 )"
		lTotDetail 	= idw_LstDetail.RowCount ()
		lLigDet		= idw_LstDetail.Find ( sRech, 1, lTotDetail )
		If	lLigDet > 0 Then
			dcPlafond713 = idw_Plafond.GetItemDecimal ( lLig713, "MT_PLAF" )
		End If
	End If
	// Fin #2

	// #3 - [DCMP100063]
	sRech	=		"ID_PROD = "				+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "					+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "					+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '-GA'" 																					+ " AND " 	+ &
					"ID_REF_PLAF = -1"																						+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																						+ " AND " 	+ &
					"ID_TYP_PLAF = '714'"

	lLig714 = idw_Plafond.Find ( sRech, 1, lTotPlaf )
	dcPlafond714 = 0
	If	lLig714 > 0 Then
		Choose Case idw_wGarSin.GetItemNumber ( 1, "COD_ETAT" )
			Case 500, 550, 600, 200, 100
				If idw_wsin.getItemstring ( 1, "ID_TYPE_CARTE" ) = "C5" Then				
					dcPlafond714 = idw_Plafond.GetItemDecimal ( lLig714, "MT_PLAF" )
				End If
		End Choose 
	End If
	// Fin #3 - [DCMP100063]

	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S05_W_GTI_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, dtDteSurv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S05_W_GTI_MT_PLAF" )	Then 
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
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG"  )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond + dcPlafond713 + dcPlafond714 Then // #2 ajout de +dcPlafond713 // #3 - [DCMP100063] ajout de +dcPlafond714

			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", (dcPlafond + dcPlafond713 + dcPlafond714) - ( dcMtPlafReg + dcMtAutreSinistre ) )
				
				// [PLAF_REF] // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "753", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "753", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "753", sIdPara, sCptVer )			
			
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )
	

end function

private function string uf_plaf_nbsin_adhesion_surv_gliss_mp ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbSin_Adhesion_Surv_gliss_mp (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 17/11/2017
//* Libellé			: [VDOC2599]
//* Commentaires	: G-NB SIN/AN MP SURV. GLISS&ADHESION
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------
Long lTotPlaf, lLig, lCpt, lLigFinale, lCptMax
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Integer iNbAutreSin, iSinEnCours
Long dcIdSin, dcIdProd, dcIdEts 
DateTime dtDteSurv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '755'"

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

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	iNbAutreSin = 0

	itrTrans.PS_S755_W_GTI_NBSIN_DTE_SURV ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dtDteSurv, iNbAutreSin )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S755_W_GTI_NBSIN_DTE_SURV" )	Then 
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
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
		iSinEnCours		= 1

		If	iSinEnCours + iNbAutreSin > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "755", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "755", "NORMAL" )			
			
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If


Return ( sPos )
	


end function

private function boolean uf_rf_1335 ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_rf_1335 (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 08/02/2017
//* Libellé			: 
//* Commentaires	: [DT75][VDOC25662]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		
//*
//*-----------------------------------------------------------------

Boolean bRet
Long lDeb, lFin, lRow, lCpt
n_cst_string lnvPFCString
String sValCar, sMarqPort, sTypArt, sMarqAuto, sTypArtAuto 

bRet = True

F_RechDetPro(lDeb, lFin, idw_detpro, idw_produit.getItemNumber(1,"ID_PROD"),"-DP", 325)
If lDeb <= 0 Then	Return True

sMarqPort = idw_Wsin.GetItemString ( 1, "MARQ_PORT" )

lRow = idw_wdivsin.Find("UPPER(NOM_ZONE)='TYPE_APP'", 1, idw_wdivsin.RowCount())
If lRow> 0 Then
	sTypArt = idw_wdivsin.GetItemString (lRow, "VAL_CAR") 
End If

For lCpt = lDeb to lFin 
	sValCar = idw_DetPro.GetItemString ( lCpt, "VAL_CAR" )
	sMarqAuto = lnvPFCString.of_getkeyvalue( sValCar, "MARQUE", ";")
	sTypArtAuto = lnvPFCString.of_getkeyvalue( sValCar, "TYP_ART", ";")	

	If Pos ( sMarqAuto, "#" + sMarqPort + "#" ) <= 0 And Pos ( sTypArtAuto, "#" + sTypArt + "#" ) > 0 Then
		bRet = Uf_RF_EcrireRefus ( 1335)
		Exit
	End If
Next


Return ( bRet )

end function

private function boolean uf_rf_1840 ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_rf_1840 (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 20/02/2018
//* Libellé			: [PC171933_V6]
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------
Long  lLig
Date	dDteSurv, dDteFinArticle
Boolean bRet

lLig=idw_wdivsin.Find("UPPER(NOM_ZONE) = 'DTE_EFF_ARTICLE'",1,idw_wdivsin.RowCount())

If lLig <= 0 Then Return True

dDteSurv = idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" )
dDteFinArticle = Date(idw_wdivsin.GetItemDateTime ( lLig, "VAL_DTE" )) // [PI056].20190926

If IsNull ( dDteSurv ) Or IsNull ( dDteFinArticle ) Then Return True

If	dDteSurv < dDteFinArticle	Then
	bRet = Uf_RF_EcrireRefus ( 1840 )
End If

Return ( bRet )
end function

private function boolean uf_rf_1837 ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_rf_1837 (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 22/02/2018
//* Libellé			: 
//* Commentaires	: [VDOC25738]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		
//*
//*-----------------------------------------------------------------

Boolean bRet
Long lDeb, lFin, lRow, lCpt
n_cst_string lnvPFCString
String sValCar, sMarqPort, sTypArt, sMarqAuto, sTypArtAuto 

bRet = True

F_RechDetPro(lDeb, lFin, idw_detpro, idw_produit.getItemNumber(1,"ID_PROD"),"-DP", 326)
If lDeb <= 0 Then	Return True

sValCar = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "TYP_APP_REFUS", ";")

lRow = idw_wdivsin.Find("UPPER(NOM_ZONE)='TYPAPP_AREC_ANEU'", 1, idw_wdivsin.RowCount())
If lRow <= 0 Then Return TRUE
sTypArt = idw_wdivsin.GetItemString (lRow, "VAL_CAR") 


If Pos ( sValCar, "#" + sTypArt + "#" ) > 0  Then
	bRet = Uf_RF_EcrireRefus ( 1837)
End If



Return ( bRet )

end function

private function boolean uf_rf_882 ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_rf_882 (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 22/02/2018
//* Libellé			: 
//* Commentaires	: [VDOC25738]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		
//*
//*-----------------------------------------------------------------

Boolean bRet
Long lDeb, lFin, lRow, lCpt
n_cst_string lnvPFCString
String sValCar, sMarqPort, sTypArt, sMarqAuto, sTypArtAuto 

bRet = True

F_RechDetPro(lDeb, lFin, idw_detpro, idw_produit.getItemNumber(1,"ID_PROD"),"-DP", 327)
If lDeb <= 0 Then	Return True

sValCar = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "TYP_APP_REFUS", ";")

lRow = idw_wdivsin.Find("UPPER(NOM_ZONE)='TYPAPP_AREC_ANEU'", 1, idw_wdivsin.RowCount())
If lRow <= 0 Then Return TRUE
sTypArt = idw_wdivsin.GetItemString (lRow, "VAL_CAR") 


If Pos ( sValCar, "#" + sTypArt + "#" ) > 0  Then
	bRet = Uf_RF_EcrireRefus ( 882 )
End If



Return ( bRet )

end function

private function boolean uf_rf_223 ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_rf_223 (PRIVATE)
//* Auteur			: JFF
//* Date				: 16/10/2018 
//* Libellé			: [PC171999]
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Boolean bRet
Long lDeb, lFin, lRow 
String sVariante, sPersonne
n_cst_string lnvPFCString

F_RechDetPro ( lDeb, lFin, idw_detpro,idw_wSin.GetItemNumber( 1, "ID_PROD" ), "-DP", 330 )

If lDeb <= 0 Then Return TRUE

sVariante = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")

lRow = idw_wdivsin.Find ( "UPPER ( NOM_ZONE ) = 'PERSONNE_SIN'", 1, idw_wdivsin.RowCount())
If lRow <= 0 Then Return TRUE

sPersonne = idw_wdivsin.GetItemString (lRow, "VAL_CAR") 

//If sVariante <> "SOLO" Then Return TRUE

Choose Case sVariante 
	Case "SOLO"
		If sPersonne = "ASS" Then Return TRUE		

	Case "FAMILLE"
		Choose Case sPersonne 
			Case "ASS", "AUP" 
				Return TRUE		
		End Choose 
End Choose 

bRet = Uf_RF_EcrireRefus ( 223 )




Return ( bRet )
end function

private function string uf_plaf_adhesion_renouv_typepers ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_plaf_adhesion_renouv_typepers (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 17/10/2018
//* Libellé			: 
//* Commentaires	: Application d'un plafond par adhésion/Année renouvellement et par type de personne
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//       JFF   16/11/2015 [DT159-1]
//*-----------------------------------------------------------------
Long lTotPlaf, lLig, lCpt, lLigFinale, lCptMax, lDeb, lFin
Decimal {2} dcPlafond, dcMtPlafaReg, dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, lRow 
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh, sTypePersonne
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
For lCpt = 1 to 4

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
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
	sTypePersonne = ""

	lRow = idw_wDivSin.Find ( "Upper (NOM_ZONE) = 'PERSONNE_SIN'", 1, idw_wDivSin.RowCount () ) 
	If lRow >0 Then 
		sTypePersonne = Upper ( idw_wDivSin.GetItemString ( lRow, "VAL_CAR" ) )
		If IsNull ( sTypePersonne ) Then sTypePersonne = ""
	End If
			
	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
   sUntPerRnv_Adh		   = idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
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

	dtDteAdhRenouv = DateTime ( dDteAdh )
	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S_W_GTI_MT_PLAF_756 ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, sTypePersonne, dcIdGti, dtDteSurv, dtDteAdhRenouv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S03_W_GTI_MT_PLAF" )	Then 
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
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG" )

		If	dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond	Then
			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) )
				
				// [PLAF_REF]  // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "756", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "756", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "756", sIdPara, sCptVer )
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )
	


end function

private function string uf_plaf_adhesion_renouvellement_prgti_mp ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adhesion_Renouvellement_PrGti_mp (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 04/07/2019
//* Libellé			: [PC192235]
//* Commentaires	: Application d'un plafond par adhésion/Année renouvellement
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JFF    11/04/2003  Traitement des Plafonds paramatrés sur les +NS, +DT, +TR
//*								  déclenché sur le contrôler
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//			FPI	26/03/2014	[PC925].Mantis10568
//       JFF   16/11/2015 [DT159-1]
//*-----------------------------------------------------------------
Long lTotPlaf, lLig, lCpt, lLigFinale, lCptMax
Decimal {2} dcPlafond, dcMtPlafaReg, dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh
Long lDeb, lFin, dcIdGti
String sVal
n_cst_string lnvPFCString
String sIdEvt[]

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

/*------------------------------------------------------------------*/
/* #1, JFF le 11/04/2003                                            */
/*------------------------------------------------------------------*/
For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '757'"

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
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
   sUntPerRnv_Adh		   = idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
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

	dtDteAdhRenouv = DateTime ( dDteAdh )
	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S757_W_GTI_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dtDteSurv, dtDteAdhRenouv, dcIdGti, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S757_W_GTI_MT_PLAF" )	Then 
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
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If
		
		// [PC925].Mantis10568
		sRech="ID_PROD = " + String ( idw_wsin.GetItemNumber(1,"ID_PROD" ))
		sRech+=" And ID_TYP_CODE_DP = '-DP' AND ID_CODE_DP = 257"
		sRech+=" And ID_CODE_NUM=757"
		lDeb=idw_detpro.find(sRech, 1, idw_detpro.RowCount())
			
		If lDeb > 0 Then
			sVal=idw_detpro.GetItemString(lDeb, "VAL_CAR")
			sVal=lnvPFCString.of_getkeyvalue( sVal, "ID_EVT", ";")
			lnvPFCString.of_parsetoarray( sVal,"#", sIdEvt )

			For lCpt=1 to UpperBound(sIdEvt)
				If sIdEvt[lCpt] ="" Then Continue
				lDeb=idw_lstdetail.Find("ID_EVT=" + 	sIdEvt[lCpt] + " And COD_ETAT in (500,600) And MT_PLAF > 0", 1, idw_lstdetail.RowCount() )
				If lDeb > 0 Then
					dcPlafond+=idw_lstdetail.GetItemDecimal(lDeb, "MT_PLAF")
				End if
			Next
		End if
		//:[PC925].Mantis10568
		
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG" )

		If	dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond	Then
			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) )
				
				// [PLAF_REF]  // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "757", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "757", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "757", sIdPara, sCptVer )
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )
	


end function

private function string uf_plaf_nbgti_adhesion_renou_dte_surv_mp ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbSin_Adhesion_Renou_dte_surv_mp (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 04/07/2019
//* Libellé			: [PC192235]
//* Commentaires	: NB GTI/ANNEE RENOUV&ADHESION 
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------
Long lTotPlaf, lLig, lCpt, lLigFinale, lCptMax
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Integer iNbAutreSin, iSinEnCours
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '758'"

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

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
   sUntPerRnv_Adh		   = idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
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

	dtDteAdhRenouv = DateTime ( dDteAdh )
	iNbAutreSin = 0

	itrTrans.PS_S758_W_GTI_NBGTI_DTE_SURV ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dtDteSurv, dtDteAdhRenouv, dcIdGti, iNbAutreSin )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S758_W_GTI_NBGTI_DTE_SURV" )	Then 
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
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
		iSinEnCours		= 1

		If	iSinEnCours + iNbAutreSin > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "758", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "758", "NORMAL" )			
			
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If


Return ( sPos )
	


end function

private function boolean uf_rf_1676_2eme_declenchement ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_1676_2eme_Declenchement (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 11/09/2019
//* Libellé			: 
//* Commentaires	: [DT424]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		
//*
//*-----------------------------------------------------------------
//		FPI	13/06/2013 [PC938_CTL_IMEI]
//    JFF   17/06/2013 [PC946_ORANGE_OPPRO]
//    JFF   18/08/2013 [VDOC12141]
//		FPI	02/10/2013 [PC958] Orange Caraibe
//		FPI	05/08/2014 [DT031-2]
//		FPI	27/11/2015 [VDOC19078]
//		FPI	24/05/2016 [ITSM384602] - correction effacement de la DDU
//    JFF   28/09/2016 [DT262]
//*-----------------------------------------------------------------
String sNumPort, sIMEI, sVal
Long lRet, lDeb, lFin, lIdProd, lRow, lVal, lCpt
DateTime dteSurv, dtMajLe, dtDerTrans
Boolean bRet, bOrangeCaraibe, bRenseignerDDU
n_cst_string lnvPFCString
Integer iVal

bRet = True
bRenseignerDDU=FALSE

// [DT424]
// S'il n'y a pas 
lVal = idw_LstCmdeSin.Find ( "ID_TYP_ART = 'EDI' AND ID_REF_FOUR = 'CONTEST_IMEI' AND COD_ETAT <> 'ANN' AND STATUS_GC NOT IN ( 740 )", 1, idw_LstCmdeSin.RowCount() )

If lVal > 0 Then 
	dtDerTrans = DateTime ( lnvPFCString.of_getkeyvalue (idw_LstCmdeSin.GetItemString ( lVal, "INFO_FRN_SPB_CPLT" ), "DTE_DDU_1", ";"))
	
	lRow = idw_wdivSin.find("UPPER(NOM_ZONE)='CRA_LAST_DTE'", 1, idw_wDivSin.rowCount()+1)
	If lRow > 0 Then
		idw_wdivSin.SetItem ( lRow, "VAL_DTE", dtDerTrans )
		dtMajLe = DateTime ( Today (), Now () )
		idw_wDivSin.SetItem ( lRow, "MAJ_LE", dtMajLe  )
		idw_wDivSin.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )
		idw_wDivSin.SetItem ( lRow, "ALT_SUPP", "N" )
	End if 
End If 

lVal = idw_LstCmdeSin.Find ( "ID_TYP_ART = 'EDI' AND ID_REF_FOUR = 'CONTEST_IMEI' AND COD_ETAT <> 'ANN' AND STATUS_GC IN ( 715, 725, 740 ) ", 1, idw_LstCmdeSin.RowCount() )
If lVal <= 0 Then Return True

bRet = Uf_RF_EcrireRefus ( 1676 )

Return ( bRet )


end function

private function boolean uf_decoder_dp347 (long adcidgti, long adcidnatsin, long adcidmotif, string ascas);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Decoder_DP347 (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 22/04/2020
//* Libellé			: 
//* Commentaires	: [DT472]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lDeb, lFin, lRow
n_cst_string lnvPFCString
Int iPos, iPos2
String sVal, sVal2
DateTime dtMajLe 

// FALSE = Param Non trouvé ou ne matche pas => Aucune résil
// TRUE  = Param trouvé ou matche => résil

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 347 )
If lDeb <= 0 Then Return FALSE


// Trouve-t-on le refus dans le refus_seul 
lRow = idw_DetPro.Find ( "ID_CODE_NUM = " + String ( adcidgti ), lDeb, lFin )

If lRow <= 0 Then Return FALSE

sVal = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lRow, "VAL_CAR" ), "REFUS_SEUL", ";")
iPos = Pos ( sVal, "#" + String ( adcIdMotif ) + "#" )

// Sinon est-il trouvé dans la recherche couplé à l'IdNatSin
If iPos <=0 Then
	sVal  = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lRow, "VAL_CAR" ), "REFUS_COUPLE", ";")
	sVal2 = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lRow, "VAL_CAR" ), "NATSIN", ";")
	iPos = Pos ( sVal, "#" + String ( adcIdMotif ) + "#" )
	iPos2 = Pos ( sVal2, "#" + String ( adcidnatsin ) + "#" )
	
	If iPos <= 0 Or iPos2 <= 0 then iPos = 0
	
End If 


If iPos > 0 And asCas = "CONTROLE" Then
	lRow = idw_wdivsin.Find("UPPER(NOM_ZONE)='RESIL_AUTO_ADH'", 1, idw_wdivsin.RowCount())
	If lRow> 0 Then
		sVal = idw_wdivsin.GetItemString (lRow, "VAL_CAR") 
	
		If sVal <> "O" Then
			idw_wdivSin.SetItem ( lRow, "VAL_CAR", "O" )
			dtMajLe = DateTime ( Today (), Now () )
			idw_wDivSin.SetItem ( lRow, "MAJ_LE", dtMajLe  )
			idw_wDivSin.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )
			idw_wDivSin.SetItem ( lRow, "ALT_SUPP", "N" )
		End If
	End If

	Return TRUE
	
End If 


Return iPos > 0

end function

private function boolean uf_rf_1898 ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_rf_1898 (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 23/06/2020
//* Libellé			: Contrôle IMEI saisie avec le l'IMEI de contrôle des adhésions.
//* Commentaires	: [PC202553_SELECTRA]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		
//*
//*-----------------------------------------------------------------
//       JFF   06/09/2024 [KSV516]
//*-----------------------------------------------------------------

Boolean bRet, bVarianteSelectra2024 
Long lDeb, lFin, lRow
String sTypArt, sIMEI_Saisi, sIMEI_Ctrle1, sIMEI_Ctrle2 

bRet = True

F_RechDetPro(lDeb, lFin, idw_detpro, idw_produit.getItemNumber(1,"ID_PROD"),"-DP", 348)
If lDeb <= 0 Then	Return True

// [KSV516]
bVarianteSelectra2024 = F_CLE_VAL ( "VARIANTE", idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), ";" ) = "SELECTRA_OFFRE_2024"
If bVarianteSelectra2024 Then Return TRUE

lRow = idw_wdivsin.Find("UPPER(NOM_ZONE)='TYPE_APP'", 1, idw_wdivsin.RowCount())
If lRow> 0 Then
	sTypArt = idw_wdivsin.GetItemString (lRow, "VAL_CAR") 
End If

If sTypArt <> "TEL" Then Return TRUE

sIMEI_Saisi = idw_Wsin.GetItemString ( 1, "NUM_IMEI_PORT" )
If IsNull ( sIMEI_Saisi ) Then sIMEI_Saisi = ""

lRow = idw_wdivsin.Find("UPPER(NOM_ZONE)='IMEI_CTRL_1'", 1, idw_wdivsin.RowCount())
If lRow> 0 Then
	sIMEI_Ctrle1 = idw_wdivsin.GetItemString (lRow, "VAL_CAR") 
	If IsNull ( sIMEI_Ctrle1 ) Then sIMEI_Ctrle1 = ""
End If

lRow = idw_wdivsin.Find("UPPER(NOM_ZONE)='IMEI_CTRL_2'", 1, idw_wdivsin.RowCount())
If lRow> 0 Then
	sIMEI_Ctrle2 = idw_wdivsin.GetItemString (lRow, "VAL_CAR") 
	If IsNull ( sIMEI_Ctrle2 ) Then sIMEI_Ctrle2 = ""
End If

If sIMEI_Saisi = "" OR ( sIMEI_Saisi <> sIMEI_Ctrle1 And  sIMEI_Saisi <> sIMEI_Ctrle2 ) Then  
	bRet = Uf_RF_EcrireRefus ( 1898)
End If 


Return ( bRet )

end function

private function string uf_plaf_adhesion_survenance_gtidp351 ();//*-----------------------------------------------------------------
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
Decimal {2} dcPlafond, dcMtPlafaReg, 	dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, lTotDetail, lLigDet
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
For lCpt = 1 to 4

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
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S759_W_GTI_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dtDteSurv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S759_W_GTI_MT_PLAF" )	Then 
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
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG"  )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond Then
			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", ( dcPlafond ) - ( dcMtPlafReg + dcMtAutreSinistre ) )
				
				// [PLAF_REF] // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "759", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "759", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
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

private function string uf_plaf_nbrglt_adhesion_par_surv ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_plaf_nbgti_adhesion_par_surv (PRIVATE)
//* Auteur			: F. Pinon
//* Date				: 18/06/2010
//* Libellé			: [DCMP100410]
//* Commentaires	: Application d'un plafond par adhésion/Année survenace glissante/gti
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//			FPI	08/12/2010	[DCMP100410.Correction]
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp, dcIdsDos
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti, lTotDetail, lLigDet
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Integer ilNbAutreSinistre, iSinEnCours

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '717'"

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
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )
	
	sRech	=		"ID_PROD = "				+ String ( idw_wSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
					"ID_REV = "					+ String ( idw_wSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
					"ID_GTI = "					+ String ( idw_wGarSin.GetItemNumber ( 1, "ID_GTI" ) )		+ " AND " 	+ &
					"ID_NIV_PLAF = '-GA'" 																					+ " AND " 	+ &
					"ID_REF_PLAF = -1"																						+ " AND " 	+ &
					"ID_CPT_PLAF = 0"	 																						+ " AND " 	+ &
					"ID_TYP_PLAF = '717'"

	ilNbAutreSinistre = 0

	//itrTrans.PS_S10_W_GTI_NBGTI_ADHESION( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdsDos, dtDteSurv, dcIdGti,  ilNbAutreSinistre )
	itrTrans.PS_S10_W_GTI_NBGTI_ADHESION_V01( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dtDteSurv, dcIdGti,  ilNbAutreSinistre ) //	[DCMP100410.Correction]	
	
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S10_W_GTI_NBGTI_ADHESION" )	Then 
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

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		iSinEnCours		= 1

		If	iSinEnCours + ilNbAutreSinistre > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "717", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "717", "NORMAL" )

		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )

end function

private function string uf_plaf_nbsinrgl_adhesi_renouv_splref611 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbSinRgl_Adhesi_Renouv_splref611 (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 29/09/2020
//* Libellé			: [DT509]
//* Commentaires	: NbSinRgl_Adhesi_Renouv_splref611
//*
//* Arguments		: Aucun
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    27/07/2011  [PLAF_REF]
//  		 JFF		29/05/2012  [VDOC6662]
//*-----------------------------------------------------------------
Long lTotPlaf, lLig, lCpt, lLigFinale, lCptMax, dcIdNatSin
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp, dcMtPlafaReg
Integer iNbAutreSin, iSinEnCours
Long dcIdSin, dcIdProd, dcIdEts, dcIdGti
DateTime dtDteSurv, dtDteAdhRenouv
Date dDteAdh, dDteResult
String sRech, sPos, sIdAdh, sMtAutreSinistre, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf
Decimal{5}   dcDurPerRnv_Adh
String       sUntPerRnv_Adh
Boolean bFin

sPos = ""
dcMtPlafaReg = idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '760'"

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

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdNatSin  = idw_wSin.GetItemNumber ( 1, "ID_NATSIN" ) 
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )

	dDteAdh		= idw_wSin.GetItemDate ( 1, "DTE_ADH" )
   dcDurPerRnv_Adh		= idw_produit.GetItemNumber ( 1, "DUR_PERRNV_ADH" )
   sUntPerRnv_Adh		   = idw_produit.GetItemString ( 1, "UNT_PERRNV_ADH" )
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

	dtDteAdhRenouv = DateTime ( dDteAdh )
	iNbAutreSin = 0

	itrTrans.PS_S11_W_GTI_NBSINRGL_ADHESION_RNV_SPLREF611 ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, dtDteSurv, dtDteAdhRenouv, dcIdNatSin, iNbAutreSin )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S11_W_GTI_NBSINRGL_ADHESION_RNV_SPLREF611" )	Then 
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
		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF" )
		iSinEnCours		= 1

		If	iSinEnCours + iNbAutreSin > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "760", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "760", "NORMAL" )			
		
		Else
			// Souplesse
			If dcMtPlafaReg > 0 Then 
				Do While Not bFin
					stMessage.sTitre		= "Souplesse sur nature de sinistre"
					stMessage.Icon			= Question!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= YESNO!
					stMessage.sCode		= "WGAR434"
					If F_Message ( stMessage ) = 1 Then bFin = TRUE
				Loop				
			End IF 
			
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If


Return ( sPos )
	


end function

private function string uf_plaf_nbsin_adhesion_annee_civile_gti ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_NbSin_Adhesion_annee_civile_gti (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 02/11/2020
//* Libellé			: [VDOC29286]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//*-----------------------------------------------------------------

Long lTotPlaf, lLig, lCpt, lLigFinale, dcIdGti
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Integer iNbAutreSin, iSinEnCours
Long dcIdSin, dcIdProd, dcIdEts
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '761'"

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

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
	dcIdGti		= idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )	
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )
				
	iNbAutreSin = 0

	itrTrans.PS_S_W_GTI_NBIN_GTI_ANCIVILE_ADHESION ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dcIdGti, dtDteSurv, iNbAutreSin )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S_W_GTI_NBIN_GTI_ANCIVILE_ADHESION" )	Then 
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

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		iSinEnCours		= 1

		If	iSinEnCours + iNbAutreSin > dcPlafond	Then
			idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )
/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "761", sIdPara, sCptVer )
			
			// [PLAF_REF] // [VDOC6662]
			sPos = Uf_Plaf_Refus ( "761", "NORMAL" )			
			
		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If


Return ( sPos )
	

end function

private function string uf_plaf_adhesion_survenance_ttegti_mp ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_Adhesion_Survenance_TteGti_MP (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 06/10/2021
//* Libellé			: [PLAFOND762_ISM215077]
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
Decimal {2} dcPlafond, dcMtPlafaReg, 	dcMtPlafReg, dcMtAutreSinistre, dcPlafSav, dcPlafTmp, dcEcoTaxe 
Long dcIdSin, dcIdProd, dcIdEts, lTotDetail, lLigDet
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
For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '762'"

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
	dtDteSurv	= DateTime ( idw_wSin.GetItemDate ( 1, "DTE_SURV_DATE" ) )

	dcMtAutreSinistre = 0
	sMtAutreSinistre 	= "             "

	itrTrans.PS_S762_W_GTI_MT_PLAF ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, dtDteSurv, sMtAutreSinistre )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S762_W_GTI_MT_PLAF" )	Then 
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
		dcMtPlafaReg	= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" )
		dcMtPlafReg		= idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_REG"  )

		// [DT159-1]
		F_RechDetPro ( lDeb, lFin, iDw_DetPro, iDw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 293)
		If lDeb > 0 Then 	
			dcEcoTaxe = Dec ( lnvPFCString.of_getkeyvalue (iDw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "MT_ECOTAXE", ";") )
			If dcEcoTaxe > 0 Then 
				dcPlafond += dcEcoTaxe 
			End If
		End If

		If	dcMtPlafaReg + dcMtPlafReg + dcMtAutreSinistre > dcPlafond Then
			If dcPlafond - ( dcMtPlafReg + dcMtAutreSinistre ) > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", ( dcPlafond ) - ( dcMtPlafReg + dcMtAutreSinistre ) )
				
				// [PLAF_REF] // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "762", "REF_PLAF_NUM_>0" )
				
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "762", "NORMAL" )
			End If	

			idw_wGarSin.SetItem ( 1, "ALT_PLAF", "O" )
			/*------------------------------------------------------------------*/
			/* On insére le paragraphe de plafond dans la DW.                   */
			/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "762", sIdPara, sCptVer )

		End If
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If

Return ( sPos )
	

end function

private subroutine uf_controlergestion_carrefour_carma ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Sinistre_wDetail::uf_ControlerGestion_Carrefour_Carma (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 28/03/2025 09:31:39
//* Libellé			: [MCO1219]
//* Commentaires	: Controle de gestion spécifique à Carrefour_Carma
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer
//*
//*-----------------------------------------------------------------

Long lRowCmde, lRowDet, lIdGti, lIdDetail, lEtatDet, lTotPiece, lCpt

lRowCmde = idw_LstCmdeGti.find ( "ID_FOUR IN ( 'CAR', 'CMA' ) AND COD_ETAT IN ( 'CNV', 'RPC' )", 1, idw_LstCmdeGti.RowCount ())
If lRowCmde <= 0 Then Return

lIdGti = idw_LstCmdeGti.GetItemNumber ( lRowCmde, "ID_GTI" )
lIdDetail = idw_LstCmdeGti.GetItemNumber ( lRowCmde, "ID_DETAIL" )

lRowDet = idw_LstDetail.Find ( &
				"ID_GTI = " + String ( lIdGti ) + " AND " + &
				"ID_DETAIL = " + String ( lIdDetail ), &
				1, idw_LstDetail.RowCount ())

If lRowDet <= 0 Then Return

lEtatDet = idw_LstDetail.GetItemNumber ( lRowDet, "COD_ETAT" ) 

If lEtatDet <> 500 Then Return

idw_wGarSin.SetItem ( 1, "ALT_BLOC", "N" )
idw_wGarSin.SetItem ( 1, "ALT_ATT", "N" )
idw_wGarSin.SetItem ( 1, "ALT_SSUI", "N" )
idw_wGarSin.SetItem ( 1, "COD_MOT_SSUI", 0 )

lTotPiece = iuoTagPiece.dw_Trt.RowCount ()
For	lCpt = 1 To lTotPiece
		iuoTagPiece.dw_Trt.SetItem ( lCpt, "ALT_RECLAME", "N" )
		iuoTagPiece.dw_Trt.SetItem ( lCpt, "ID_I", stNul.iNum )
Next 

iuoOng.Uf_ChangerBitmap ( "02", "" )

lTotPiece = idw_wPiece.RowCount ()
For lCpt = lTotPiece To 1 Step -1
	idw_wPiece.DeleteRow ( lCpt )
Next




end subroutine

private function string uf_controlergestion_des_opticiens ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Sinistre_wDetail::uf_ControlerGestion_Des_Opticiens (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 20/06/2025
//* Libellé			: [MIG147_KRYS]
//* Commentaires	: Controle de gestion spécifique aux opticiens
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer
//*
//*-----------------------------------------------------------------

String sPos, sVariante
Long lDeb, lFin, lCount, lCount2 


sPos = ""

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_Produit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 403 )
If lDeb <= 0 Then Return sPos

sVariante = F_CLE_VAL ( "VARIANTE", idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), ";" )

Choose Case sVariante 
	Case "KRYS", "COLLECTIF_DES_LUNETIERS"
		
		idw_LstDetail.SetFilter ( "COD_ETAT = 500 AND ALT_REG = 'N'" )
		idw_LstDetail.Filter ()
		lCount = idw_LstDetail.RowCount() 
		
		// Si 2 evt avec un A_REGLER (500)alors « vous ne pouvez pas régler 2 evt, dans ce cas, régler sur « Tout l’équipement » 
		If lCount > 1 Then
				stMessage.sTitre		= "Contrôle de gestion d'une garantie"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.sCode		= "WGAR446"

				F_Message ( stMessage )
				
				sPos = "MT_PROV"
		End IF 

		idw_LstDetail.SetFilter ( "COD_ETAT = 600 AND ALT_REG = 'N'" )
		idw_LstDetail.Filter ()
		lCount = idw_LstDetail.RowCount() 

		idw_LstDetail.SetFilter ( "ALT_REG = 'O'" )
		idw_LstDetail.Filter ()
		lCount2 = idw_LstDetail.RowCount() 		
		
		// Si un evt déjà REGLE (600) alors « vous ne pouvez effectuer qu’un seul règlement (pour une question de calcul de plafond ) »
		If lCount > 0 And lCount2 <=0 Then
				stMessage.sTitre		= "Contrôle de gestion d'une garantie"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.sCode		= "WGAR447"

				F_Message ( stMessage )
				
				sPos = "MT_PROV"
		End IF 
		
		
End Choose 


idw_LstDetail.SetFilter ( "" )
idw_LstDetail.Filter ()
idw_LstDetail.Sort ()

Return sPos

end function

private function string uf_plaf_krys_cdl_mt_spec_si_nb_sup_1_sin ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Plaf_KRYS_CDL_MT_SPEC_SI_NB_SUP_1_SIN (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 04/07/2025
//* Libellé			: [MIG147_KRYS]
//* Commentaires	: Plafond spécial Opticiens KRYS et CDL, Si plus d'un 1 sin indem, alors les suivants sont sur un plafond fixe
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------
Long lTotPlaf, lLig, lCpt, lLigFinale
Decimal {2} dcPlafond, dcPlafSav, dcPlafTmp
Integer iNbAutreSin, iSinEnCours
Long dcIdSin, dcIdProd, dcIdEts
DateTime dtDteSurv
String sRech, sPos, sIdAdh, sIdPara, sCptVer, sIdNivPlaf, sIdRefPlaf

sPos = ""

/*------------------------------------------------------------------*/
/* On vérifie s'il existe un plafond par sinistre.                  */
/*------------------------------------------------------------------*/
lTotPlaf = idw_Plafond.RowCount ()
dcPlafSav = 0

For lCpt = 1 to 4

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
					"ID_TYP_PLAF = '764'"

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

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On recupére les autres sinistres si besoin, on fait appel à la   */
/* procédure stockée.                                               */
/*------------------------------------------------------------------*/
	dcIdSin		= idw_wSin.GetItemNumber ( 1, "ID_SIN" )
	dcIdProd		= idw_wSin.GetItemNumber ( 1, "ID_PROD" )
	dcIdEts		= idw_wSin.GetItemNumber ( 1, "ID_ETS" )
	sIdAdh		= idw_wSin.GetItemString ( 1, "ID_ADH" )
				
	iNbAutreSin = 0

	itrTrans.PS_S764_W_GTI_KRYS_CDL_NBSIN ( dcIdSin, dcIdProd, dcIdEts, sIdAdh, iNbAutreSin )
	If	Not F_Procedure ( stMessage, itrTrans, "PS_S764_W_GTI_KRYS_CDL_NBSIN" )	Then 
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

		dcPlafond		= idw_Plafond.GetItemDecimal ( lLig, "MT_PLAF"   )
		iSinEnCours		= 1

		If	iSinEnCours + iNbAutreSin > 1	Then
			IF dcPlafond > 0 Then
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", dcPlafond )
	
				// [PLAF_REF]  // [VDOC6662]
				sPos = Uf_Plaf_Refus ( "764", "REF_PLAF_NUM_>0" )
			Else
				idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )
				// [PLAF_REF]
				sPos = Uf_Plaf_Refus ( "764", "NORMAL" )
			End If					
	
			idw_wGarSin.SetItem ( 1, "ALT_PLAF", 	"O" )

/*------------------------------------------------------------------*/
/* On insére le paragraphe de plafond dans la DW.                   */
/*------------------------------------------------------------------*/
			sIdPara	= idw_Plafond.GetItemString ( lLig, "ID_PARA" )
			sCptVer	= idw_Plafond.GetItemString ( lLig, "CPT_VER" )
			Uf_Plaf_EcrirePara ( "764", sIdPara, sCptVer )
			
		End If
	
	End If
End If

If idw_wGarSin.GetItemDecimal ( 1, "MT_PLAF_AREG" ) < 0 Then
	idw_wGarSin.SetItem ( 1, "MT_PLAF_AREG", 0 )	
End If


Return ( sPos )
	

end function

private function boolean uf_rf_1165 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_1165 (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 03/10/2025
//* Libellé			: [MIG165_BOUYGUES]
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* [20250915131212003][JFF][MIG165_BOUYGUES]
//*-----------------------------------------------------------------

Long lLig, lTotCondition, lIdNatSin, lDeb, lFin, lIdGti, lRow
String sVal, sVal1, sVal2
Boolean bRet

/*------------------------------------------------------------------*/
/* On déclenche ce motif si la nature du sinistre n'est pas         */
/* couverte. On envoie le test uniquement si la révision est        */
/* connue.                                                          */
/*------------------------------------------------------------------*/
bRet = True

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 405 )
If lDeb <= 0 Then Return bRet

lRow = idw_wdivsin.Find("UPPER(NOM_ZONE)='QUE_S_EST_T_IL_PASSE_CODE'", 1, idw_wdivsin.RowCount())
If lRow > 0 Then 
	sVal = idw_wdivsin.GetItemString (lRow, "VAL_CAR") 
End If 

lRow = idw_wdivsin.Find("UPPER(NOM_ZONE)='DYSFONCTIONNEMENT_APPAREIL'", 1, idw_wdivsin.RowCount())
If lRow > 0 Then 
	sVal1 = idw_wdivsin.GetItemString (lRow, "VAL_CAR") 
End If 

lRow = idw_wdivsin.Find("UPPER(NOM_ZONE)='APP_INUTILISABLE_SUITE_DYSFONCT'", 1, idw_wdivsin.RowCount())
If lRow > 0 Then 
	sVal2 = idw_wdivsin.GetItemString (lRow, "VAL_CAR") 
End If 

lIdGti = idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )

Choose Case lIdGti 
	Case 24
		If sVal1 = "NON" and sVal2 = "NON" Then
			bRet = Uf_RF_EcrireRefus ( 1165 )
		End If 

	Case 11, 24
		If ( Pos ( sVal, "REE" ) > 0 Or ( sVal1 = "NON" and sVal2 = "NON" ) ) Then
			bRet = Uf_RF_EcrireRefus ( 1165 )
		End If 
End Choose 

Return ( bRet )
end function

private function boolean uf_rf_1844 ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Rf_1165 (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 03/10/2025
//* Libellé			: [MIG165_BOUYGUES]
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		Vrai = Le refus existe, on vient de le cocher.
//*										Faux = Le refus n'existe pas.
//*
//*-----------------------------------------------------------------
//* [20250915131212003][JFF][MIG165_BOUYGUES]
//*-----------------------------------------------------------------

Long lLig, lTotCondition, lIdNatSin, lDeb, lFin, lIdGti, lRow
String sVal, sVal1, sVal2
Boolean bRet


/*------------------------------------------------------------------*/
/* On déclenche ce motif si la nature du sinistre n'est pas         */
/* couverte. On envoie le test uniquement si la révision est        */
/* connue.                                                          */
/*------------------------------------------------------------------*/
bRet = True

F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 405 )
If lDeb <= 0 Then Return bRet

lRow = idw_wdivsin.Find("UPPER(NOM_ZONE)='DOMMAGES_EXTERIEURS_VISIBLES'", 1, idw_wdivsin.RowCount())
If lRow > 0 Then 
	sVal = idw_wdivsin.GetItemString (lRow, "VAL_CAR") 
End If 

lIdGti = idw_wGarSin.GetItemNumber ( 1, "ID_GTI" )

If lIdGti = 11 And sVal = "NON" Then
	bRet = Uf_RF_EcrireRefus ( 1844 )
End If 

Return ( bRet )

end function

on u_gs_sp_sinistre_garantie.create
call super::create
end on

on u_gs_sp_sinistre_garantie.destroy
call super::destroy
end on

