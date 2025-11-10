$PBExportHeader$w_t_resume_action_gestion.srw
forward
global type w_t_resume_action_gestion from window
end type
type cb_stop from commandbutton within w_t_resume_action_gestion
end type
type cb_ok from commandbutton within w_t_resume_action_gestion
end type
type st_info from statictext within w_t_resume_action_gestion
end type
type st_existant from statictext within w_t_resume_action_gestion
end type
type st_action from statictext within w_t_resume_action_gestion
end type
type dw_existant from datawindow within w_t_resume_action_gestion
end type
type dw_action from datawindow within w_t_resume_action_gestion
end type
end forward

global type w_t_resume_action_gestion from window
integer width = 3337
integer height = 1904
boolean titlebar = true
string title = "Résumé des actions sensibles / Alertes (vDoc12845 Claudie Souchard/Hélène Liegeard)"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_stop cb_stop
cb_ok cb_ok
st_info st_info
st_existant st_existant
st_action st_action
dw_existant dw_existant
dw_action dw_action
end type
global w_t_resume_action_gestion w_t_resume_action_gestion

type variables
Private :

u_DataWindow_Detail	idw_LstInter
u_DataWindow_Detail	idw_LstwCommande

DataWindow		idw_wDetail

// Actions en cours de saisie sur le dossier.
Boolean ibRegNumInterAssSurGti  // Règlement num inter A sur une Gti.
Boolean ibRegFournPRS2  		  // Règlement d’un fournisseur pour un réparation réparé
Boolean ibRegFournPRS21  		  // Règlement d’un fournisseur pour un réparation irréparable
Boolean ibRegFournPRSSav  		  // Règlement d’un fournisseur pour un réparation SAV
Boolean ibRegFournRempl  		  // Règlement d’un fournisseur pour un remplacement
Boolean ibRegFournDiagConf  	  // Règlement d’un fournisseur pour d’un diagnostic conforme
Boolean ibRegFournDiagNConf  	  // Règlement d’un fournisseur pour d’un diagnostic non conforme
Boolean ibPrestaRemplCNV  		  // Passage d’un remplacement
Boolean ibPrestaRepaCNV  		  // Passage d’une réparation
Boolean ibPrestaDiagCNV  		  // Passage d’un diagnostic
Boolean ibPrestaRepaSavCNV  	  // Passage d’une réparation SAV

// Actions validées en base.
Boolean ibBSRegNumInterAssSurGtiSansRM	// Bin 1  // Règlement num inter A sur une Gti sans Somme de RM Total
Boolean ibBSRegFourRepaRepaSansRM 		// Bin 2  // Règlement d’un fournisseur pour une réparation réparée Somme de RM Total
Boolean ibBSRegFourRepaIRRepaSansRM 	// Bin 3  // Règlement d’un fournisseur pour un réparation irréparable sans Somme de RM Total
Boolean ibBSRegFourRepaSAVSansRM 		// Bin 4  // Règlement d’un fournisseur pour un réparation SAV sans Somme de RM Total
Boolean ibBSRegFourRemplSansRM 			// Bin 5  // Règlement d’un fournisseur pour un remplacement sans Somme de RM Total
Boolean ibBSRegFourDiagConfSansRM 		// Bin 6  // Règlement d’un fournisseur pour un diagnostic conforme sans Somme de RM
Boolean ibBSRegFourDiagNConfSansRM 		// Bin 7  // Règlement d’un fournisseur pour un diagnostic non conforme sans Somme de RM
Boolean ibBSRemplacementNonAnn 			// Bin 8  // Remplacement (Non annulé)
Boolean ibBSRepaRepaNonAnn 				// Bin 9  // Réparation (réparé) (Non annulé)
Boolean ibBSRepaIRRepaNonAnn 				// Bin 10 // Réparation (irréparable) (Non annulé)
Boolean ibBSRepaSAVNonAnn 					// Bin 11 // Réparation SAV (Non annulé)
Boolean ibBSDiagConfNonAnn 				// Bin 12 // Diag (conforme) (Non annulé)
Boolean ibBSDiagNConfNonAnn 				// Bin 13 // Diag (non conforme) (Non annulé)
Boolean ibBSSwapCTRNonAnn 					// Bin 14 // Swap par CTR (Non annulé)


Boolean ibAMU_Incoherence					// Au Moins Une Incohérence
Boolean ibPasseParClose

Long 	  iCptCompteur					// Compteur de lien
Long 	  ilIdSin

String isTbLibActionCourante [11,2]
String isTbLibActionExistante [14,2]
String isSortie

DateTime	iDtCleInsert










end variables

forward prototypes
public function boolean wf_amu_incoherence ()
public subroutine wf_detectiondescas ()
public subroutine wf_definitiondesactions ()
public subroutine wf_declencherincoherence (string asactioncourante, string asactionexistante)
end prototypes

public function boolean wf_amu_incoherence ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_resume_action_gestion::wf_amu_incoherence
//* Auteur			: JFF
//* Date				: 05/02/2014
//* Libellé			: [VDOC12845]
//* Commentaires	:
//*
//* Arguments		: 
//*
//* Retourne		: 
//*-----------------------------------------------------------------
//* JFF	14/08/2014		[VDOC15083]
//* JFF  18/08/2014 		[PM254_V1]
//*-----------------------------------------------------------------

/* 
idw_LstInter
idw_LstwCommande
idw_wDetail
*/

iCptCompteur	 = 0

/*
// Actions en cours de saisie sur le dossier.
1_Boolean ibRegNumInterAssSurGti  // Règlement num inter A sur une Gti.
2_Boolean ibRegFournPRS2  		  // Règlement d’un fournisseur pour un réparation réparé
3_Boolean ibRegFournPRS21  		  // Règlement d’un fournisseur pour un réparation irréparable
4_Boolean ibRegFournPRSSav  		  // Règlement d’un fournisseur pour un réparation SAV
5_Boolean ibRegFournRempl  		  // Règlement d’un fournisseur pour un remplacement
6_Boolean ibRegFournDiagConf  	  // Règlement d’un fournisseur pour d’un diagnostic conforme
7_Boolean ibRegFournDiagNConf  	  // Règlement d’un fournisseur pour d’un diagnostic non conforme
8_Boolean ibPrestaRemplCNV  		  // Passage d’un remplacement
9_Boolean ibPrestaRepaCNV  		  // Passage d’une réparation
10_Boolean ibPrestaDiagCNV  		  // Passage d’un diagnostic
11_Boolean ibPrestaRepaSavCNV  	  // Passage d’une réparation SAV

// Actions validées en base.
Boolean ibBSRegNumInterAssSurGtiSansRM	// Bin 1  // Règlement num inter A sur une Gti sans Somme de RM Total
Boolean ibBSRegFourRepaRepaSansRM 		// Bin 2  // Règlement d’un fournisseur pour une réparation réparée Somme de RM Total
Boolean ibBSRegFourRepaIRRepaSansRM 	// Bin 3  // Règlement d’un fournisseur pour un réparation irréparable sans Somme de RM Total
Boolean ibBSRegFourRepaSAVSansRM 		// Bin 4  // Règlement d’un fournisseur pour un réparation SAV sans Somme de RM Total
Boolean ibBSRegFourRemplSansRM 			// Bin 5  // Règlement d’un fournisseur pour un remplacement sans Somme de RM Total
Boolean ibBSRegFourDiagConfSansRM 		// Bin 6  // Règlement d’un fournisseur pour un diagnostic conforme sans Somme de RM
Boolean ibBSRegFourDiagNConfSansRM 		// Bin 7  // Règlement d’un fournisseur pour un diagnostic non conforme sans Somme de RM
Boolean ibBSRemplacementNonAnn 			// Bin 8  // Remplacement (Non annulé)
Boolean ibBSRepaRepaNonAnn 				// Bin 9  // Réparation (réparé) (Non annulé)
Boolean ibBSRepaIRRepaNonAnn 				// Bin 10 // Réparation (irréparable) (Non annulé)
Boolean ibBSRepaSAVNonAnn 					// Bin 11 // Réparation SAV (Non annulé)
Boolean ibBSDiagConfNonAnn 				// Bin 12 // Diag (conforme) (Non annulé)
Boolean ibBSDiagNConfNonAnn 				// Bin 13 // Diag (non conforme) (Non annulé)
Boolean ibBSSwapCTRNonAnn 					// Bin 14 // Swap par CTR (Non annulé) [PM254_V1]
*/

ibAMU_Incoherence	= False
iDtCleInsert = DateTime ( Today (), Now() )

// Cas 1 : // Règlement num inter A sur une Gti.
If ibRegNumInterAssSurGti Then
	
	// Bin 1  // Règlement num inter A sur une Gti sans Somme de RM Total
	If ibBSRegNumInterAssSurGtiSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegNumInterAssSurGti", "ibBSRegNumInterAssSurGtiSansRM" )
	End If

	// Bin 2  // Règlement d’un fournisseur pour une réparation réparée Somme de RM Total
	If ibBSRegFourRepaRepaSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegNumInterAssSurGti", "ibBSRegFourRepaRepaSansRM" )
	End If

	// Bin 4  // Règlement d’un fournisseur pour un réparation SAV sans Somme de RM Total
	If ibBSRegFourRepaSAVSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegNumInterAssSurGti", "ibBSRegFourRepaSAVSansRM" )
	End If

	// Bin 5  // Règlement d’un fournisseur pour un remplacement sans Somme de RM Total
	If ibBSRegFourRemplSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegNumInterAssSurGti", "ibBSRegFourRemplSansRM" )
	End If

	// Bin 8  // Remplacement (Non annulé)
	If ibBSRemplacementNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegNumInterAssSurGti", "ibBSRemplacementNonAnn" )
	End If

	// BBin 9  // Réparation (réparé) (Non annulé)
	If ibBSRepaRepaNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegNumInterAssSurGti", "ibBSRepaRepaNonAnn" )
	End If

	// Bin 10 // Réparation (irréparable) (Non annulé)
	If ibBSRepaIRRepaNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegNumInterAssSurGti", "ibBSRepaIRRepaNonAnn" )
	End If

	// Bin 11 // Réparation SAV (Non annulé)
	If ibBSRepaSAVNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegNumInterAssSurGti", "ibBSRepaSAVNonAnn" )
	End If

	// Bin 13 // Diag (non conforme) (Non annulé)
	If ibBSDiagNConfNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegNumInterAssSurGti", "ibBSDiagNConfNonAnn" )
	End If
	
	// Bin 14 // Swap par CTR (Non annulé)
	If ibBSSwapCTRNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegNumInterAssSurGti", "ibBSSwapCTRNonAnn" )
	End If
End If	


// Cas 2 : // Règlement d’un fournisseur pour une réparation réparée
If ibRegFournPRS2 Then

	// Bin 1  // Règlement num inter A sur une Gti sans Somme de RM Total
	If ibBSRegNumInterAssSurGtiSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRS2", "ibBSRegNumInterAssSurGtiSansRM" )
	End If
	
	// Bin 2  // Règlement d’un fournisseur pour une réparation réparée Somme de RM Total
	If ibBSRegFourRepaRepaSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRS2", "ibBSRegFourRepaRepaSansRM" )
	End If

	// Bin 3  // Règlement d’un fournisseur pour une réparation irréparable sans Somme de RM Total
	If ibBSRegFourRepaIRRepaSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRS2", "ibBSRegFourRepaIRRepaSansRM" )
	End If
	
	// Bin 4  // Règlement d’un fournisseur pour une réparation irréparable sans Somme de RM Total
	If ibBSRegFourRepaSAVSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRS2", "ibBSRegFourRepaSAVSansRM" )
	End If

	// Bin 5  // Règlement d’un fournisseur pour un remplacement sans Somme de RM Total
	If ibBSRegFourRemplSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRS2", "ibBSRegFourRemplSansRM" )
	End If

	// Bin 6  // Règlement d’un fournisseur pour un diagnostic conforme sans Somme de RM
	If ibBSRegFourDiagConfSansRM  Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRS2", "ibBSRegFourDiagConfSansRM" )
	End If

	// Bin 7  // Règlement d’un fournisseur pour un diagnostic non conforme sans Somme de RM
	If ibBSRegFourDiagNConfSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRS2", "ibBSRegFourDiagNConfSansRM" )
	End If
	
	// Bin 8  // Remplacement (Non annulé)
	If ibBSRemplacementNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRS2", "ibBSRemplacementNonAnn" )
	End If
	
	// Bin 10 // Réparation (irréparable) (Non annulé)
	If ibBSRepaIRRepaNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRS2", "ibBSRepaIRRepaNonAnn" )
	End If

	// Bin 12 // Diag (conforme) (Non annulé)
	If ibBSDiagConfNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRS2", "ibBSDiagConfNonAnn" )
	End If

	// Bin 13 // Diag (non conforme) (Non annulé)
	If ibBSDiagNConfNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRS2", "ibBSDiagNConfNonAnn" )
	End If
	
End If

// Cas 3 : // Règlement d’un fournisseur pour un réparation irréparable
If ibRegFournPRS21 Then
	
	// Bin 2 // Règlement d’un fournisseur pour une réparation réparée Somme de RM Total
	If ibBSRegFourRepaRepaSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRS21", "ibBSRegFourRepaRepaSansRM" )
	End If

	// Bin 3  // Règlement d’un fournisseur pour un réparation irréparable sans Somme de RM Total
	If ibBSRegFourRepaIRRepaSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRS21", "ibBSRegFourRepaIRRepaSansRM" )
	End If

	// Bin 4  // Règlement d’un fournisseur pour une réparation irréparable sans Somme de RM Total
	If ibBSRegFourRepaSAVSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRS21", "ibBSRegFourRepaSAVSansRM" )
	End If

	// Bin 6  // Règlement d’un fournisseur pour un diagnostic conforme sans Somme de RM
	If ibBSRegFourDiagConfSansRM  Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRS21", "ibBSRegFourDiagConfSansRM" )
	End If

	// Bin 7  // Règlement d’un fournisseur pour un diagnostic non conforme sans Somme de RM
	If ibBSRegFourDiagNConfSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRS21", "ibBSRegFourDiagNConfSansRM" )
	End If

	// Bin 9  // Réparation (réparé) (Non annulé)
	If ibBSRepaRepaNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRS21", "ibBSRepaRepaNonAnn" )
	End If

	// Bin 12 // Diag (conforme) (Non annulé)
	If ibBSDiagConfNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRS21", "ibBSDiagConfNonAnn" )
	End If

	// Bin 13 // Diag (non conforme) (Non annulé)
	If ibBSDiagNConfNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRS21", "ibBSDiagNConfNonAnn" )
	End If


End If

// Cas 4 : // Règlement d’un fournisseur pour un réparation SAV
If ibRegFournPRSSav Then
	// Bin 2 // Règlement d’un fournisseur pour une réparation réparée Somme de RM Total
	If ibBSRegFourRepaRepaSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRSSav", "ibBSRegFourRepaRepaSansRM" )
	End If

	// Bin 3  // Règlement d’un fournisseur pour un réparation irréparable sans Somme de RM Total
	If ibBSRegFourRepaIRRepaSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRSSav", "ibBSRegFourRepaIRRepaSansRM" )
	End If

	// Bin 4  // Règlement d’un fournisseur pour une réparation irréparable sans Somme de RM Total
	If ibBSRegFourRepaSAVSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRSSav", "ibBSRegFourRepaSAVSansRM" )
	End If

	// Bin 6  // Règlement d’un fournisseur pour un diagnostic conforme sans Somme de RM
	If ibBSRegFourDiagConfSansRM  Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRSSav", "ibBSRegFourDiagConfSansRM" )
	End If

	// Bin 7  // Règlement d’un fournisseur pour un diagnostic non conforme sans Somme de RM
	If ibBSRegFourDiagNConfSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRSSav", "ibBSRegFourDiagNConfSansRM" )
	End If

	// Bin 10  // Réparation (irréparable) (Non annulé)
	If ibBSRepaIRRepaNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRSSav", "ibBSRepaIRRepaNonAnn" )
	End If

	// Bin 11  // Réparation SAV (Non annulé)
	If ibBSRepaSAVNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRSSav", "ibBSRepaSAVNonAnn" )
	End If

	// Bin 12 // Diag (conforme) (Non annulé)
	If ibBSDiagConfNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRSSav", "ibBSDiagConfNonAnn" )
	End If

	// Bin 13 // Diag (non conforme) (Non annulé)
	If ibBSDiagNConfNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournPRSSav", "ibBSDiagNConfNonAnn" )
	End If

End If


// Cas 5 : // Règlement d’un fournisseur pour un remplacement
If ibRegFournRempl Then

	// Bin 1 // Règlement num inter A sur une Gti sans Somme de RM Total
	If ibBSRegNumInterAssSurGtiSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournRempl", "ibBSRegNumInterAssSurGtiSansRM" )
	End If

	// Bin 2 // Règlement d’un fournisseur pour une réparation réparée Somme de RM Total
	If ibBSRegFourRepaRepaSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournRempl", "ibBSRegFourRepaRepaSansRM" )
	End If
	
	// Bin 4 // Règlement d’un fournisseur pour un réparation SAV sans Somme de RM Total
	If ibBSRegFourRepaSAVSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournRempl", "ibBSRegFourRepaSAVSansRM" )
	End If

	// Bin 5 // Règlement d’un fournisseur pour un remplacement sans Somme de RM Total
	If ibBSRegFourRemplSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournRempl", "ibBSRegFourRemplSansRM" )
	End If

	// Bin 7 // Règlement d’un fournisseur pour un diagnostic non conforme sans Somme de RM
	If ibBSRegFourDiagNConfSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournRempl", "ibBSRegFourDiagNConfSansRM" )
	End If

	// Bin 8 // Remplacement (Non annulé)
	/*  [Vdoc15083], gêne Maryse.
	If ibBSRemplacementNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournRempl", "ibBSRemplacementNonAnn" )
	End If
	*/
	
	// Bin 9  // Réparation (réparé) (Non annulé)
	If ibBSRepaRepaNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournRempl", "ibBSRepaRepaNonAnn" )
	End If

	// Bin 13 // Diag (non conforme) (Non annulé)
	If ibBSDiagNConfNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournRempl", "ibBSDiagNConfNonAnn" )
	End If
	
End If

// Cas 6 : // Règlement d’un fournisseur pour un diagnostic conforme
If ibRegFournDiagConf Then

	// Bin 1  // Règlement num inter A sur une Gti sans Somme de RM Total
	If ibBSRegNumInterAssSurGtiSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagConf", "ibBSRegNumInterAssSurGtiSansRM" )
	End If

	// Bin 2  // Règlement d’un fournisseur pour une réparation réparée Somme de RM Total
	If ibBSRegFourRepaRepaSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagConf", "ibBSRegFourRepaRepaSansRM" )
	End If

	// Bin 3  // Règlement d’un fournisseur pour un réparation irréparable sans Somme de RM Total
	If ibBSRegFourRepaIRRepaSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagConf", "ibBSRegFourRepaIRRepaSansRM" )
	End If

	// Bin 4  // Règlement d’un fournisseur pour un réparation SAV sans Somme de RM Total
	If ibBSRegFourRepaSAVSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagConf", "ibBSRegFourRepaSAVSansRM" )
	End If

	// Bin 6  // Règlement d’un fournisseur pour un diagnostic conforme sans Somme de RM
	If ibBSRegFourDiagConfSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagConf", "ibBSRegFourDiagConfSansRM" )
	End If

	// Bin 7  // Règlement d’un fournisseur pour un diagnostic non conforme sans Somme de RM
	If ibBSRegFourDiagNConfSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagConf", "ibBSRegFourDiagNConfSansRM" )
	End If

	// Bin 9  // Réparation (réparé) (Non annulé)
	If ibBSRepaRepaNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagConf", "ibBSRepaRepaNonAnn" )
	End If

	// Bin 10 // Réparation (irréparable) (Non annulé)
	If ibBSRepaIRRepaNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagConf", "ibBSRepaIRRepaNonAnn" )
	End If

	// Bin 11 // Réparation SAV (Non annulé)
	If ibBSRepaSAVNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagConf", "ibBSRepaSAVNonAnn" )
	End If

	// Bin 12 // Diag (conforme) (Non annulé)
	If ibBSDiagConfNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagConf", "ibBSDiagConfNonAnn" )
	End If

	// Bin 13 // Diag (non conforme) (Non annulé)
	If ibBSDiagNConfNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagConf", "ibBSDiagNConfNonAnn" )
	End If


End If

// Cas 7 : // Règlement d’un fournisseur pour d’un diagnostic non conforme
If ibRegFournDiagNConf Then

	// Bin 1  // Règlement num inter A sur une Gti sans Somme de RM Total
	If ibBSRegNumInterAssSurGtiSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagNConf", "ibBSRegNumInterAssSurGtiSansRM" )
	End If

	// Bin 2 // Règlement d’un fournisseur pour une réparation réparée Somme de RM Total
	If ibBSRegFourRepaRepaSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagNConf", "ibBSRegFourRepaRepaSansRM" )
	End If

	// Bin 3 // Règlement d’un fournisseur pour un réparation irréparable sans Somme de RM Total
	If ibBSRegFourRepaIRRepaSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagNConf", "ibBSRegFourRepaIRRepaSansRM" )
	End If

	// Bin 4  // Règlement d’un fournisseur pour un réparation SAV sans Somme de RM Total
	If ibBSRegFourRepaSAVSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagNConf", "ibBSRegFourRepaSAVSansRM" )
	End If

	// Bin 5  // Règlement d’un fournisseur pour un remplacement sans Somme de RM Total
	If ibBSRegFourRemplSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagNConf", "ibBSRegFourRemplSansRM" )
	End If

	// Bin 6  // Règlement d’un fournisseur pour un diagnostic conforme sans Somme de RM
	If ibBSRegFourDiagConfSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagNConf", "ibBSRegFourDiagConfSansRM" )
	End If
	
	// Bin 7  // Règlement d’un fournisseur pour un diagnostic non conforme sans Somme de RM
	If ibBSRegFourDiagNConfSansRM Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagNConf", "ibBSRegFourDiagNConfSansRM" )
	End If

	// Bin 9  // Réparation (réparé) (Non annulé)
	If ibBSRepaRepaNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagNConf", "ibBSRepaRepaNonAnn" )
	End If

	// Bin 10 // Réparation (irréparable) (Non annulé)
	If ibBSRepaIRRepaNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagNConf", "ibBSRepaIRRepaNonAnn" )
	End If

	// Bin 11 // Réparation SAV (Non annulé)
	If ibBSRepaSAVNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagNConf", "ibBSRepaSAVNonAnn" )
	End If

	// Bin 12 // Diag (conforme) (Non annulé)
	If ibBSDiagConfNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagNConf", "ibBSDiagConfNonAnn" )
	End If
	
	// Bin 13 // Diag (non conforme) (Non annulé)
	If ibBSDiagNConfNonAnn Then
		This.wf_DeclencherIncoherence ( "ibRegFournDiagNConf", "ibBSDiagNConfNonAnn" )
	End If

	
End If


// Cas 8 : // Passage d’un remplacement
If ibPrestaRemplCNV Then

	// Bin 1 // Règlement num inter A sur une Gti sans Somme de RM Total
	If ibBSRegNumInterAssSurGtiSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaRemplCNV", "ibBSRegNumInterAssSurGtiSansRM" )
	End If

	// Bin 2  // Règlement d’un fournisseur pour une réparation réparée Somme de RM Total
	If ibBSRegFourRepaRepaSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaRemplCNV", "ibBSRegFourRepaRepaSansRM" )
	End If

	// Bin 4  // Règlement d’un fournisseur pour un réparation SAV sans Somme de RM Total
	If ibBSRegFourRepaSAVSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaRemplCNV", "ibBSRegFourRepaSAVSansRM" )
	End If

	// Bin 5  // Règlement d’un fournisseur pour un remplacement sans Somme de RM Total
	If ibBSRegFourRemplSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaRemplCNV", "ibBSRegFourRemplSansRM" )
	End If

	// Bin 7  // Règlement d’un fournisseur pour un diagnostic non conforme sans Somme de RM
	If ibBSRegFourDiagNConfSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaRemplCNV", "ibBSRegFourDiagNConfSansRM" )
	End If

	// Bin 8  // Remplacement (Non annulé)
	If ibBSRemplacementNonAnn Then
		This.wf_DeclencherIncoherence ( "ibPrestaRemplCNV", "ibBSRemplacementNonAnn" )
	End If

	// Bin 9  // Réparation (réparé) (Non annulé)
	If ibBSRepaRepaNonAnn Then
		This.wf_DeclencherIncoherence ( "ibPrestaRemplCNV", "ibBSRepaRepaNonAnn" )
	End If

	// Bin 11 // Réparation SAV (Non annulé)
	If ibBSRepaSAVNonAnn Then
		This.wf_DeclencherIncoherence ( "ibPrestaRemplCNV", "ibBSRepaSAVNonAnn" )
	End If

	// Bin 13 // Diag (non conforme) (Non annulé)
	If ibBSDiagNConfNonAnn Then
		This.wf_DeclencherIncoherence ( "ibPrestaRemplCNV", "ibBSDiagNConfNonAnn" )
	End If

	// Bin 14 // Swap par CTR (Non annulé)
	If ibBSSwapCTRNonAnn Then
		This.wf_DeclencherIncoherence ( "ibPrestaRemplCNV", "ibBSSwapCTRNonAnn" )
	End If
End If


// Cas 9 : // Passage d’une réparation
If ibPrestaRepaCNV Then

	// Bin 1  // Règlement num inter A sur une Gti sans Somme de RM Total
	If ibBSRegNumInterAssSurGtiSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaCNV", "ibBSRegNumInterAssSurGtiSansRM" )
	End If

	// Bin 2  // Règlement d’un fournisseur pour une réparation réparée Somme de RM Total
	If ibBSRegFourRepaRepaSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaCNV", "ibBSRegFourRepaRepaSansRM" )
	End If
	
	// Bin 3  // Règlement d’un fournisseur pour un réparation irréparable sans Somme de RM Total
	If ibBSRegFourRepaIRRepaSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaCNV", "ibBSRegFourRepaIRRepaSansRM" )
	End If

	// Bin 4  // Règlement d’un fournisseur pour un réparation SAV sans Somme de RM Total
	If ibBSRegFourRepaSAVSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaCNV", "ibBSRegFourRepaSAVSansRM" )
	End If

	// Bin 5  // Règlement d’un fournisseur pour un remplacement sans Somme de RM Total
	If ibBSRegFourRemplSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaCNV", "ibBSRegFourRemplSansRM" )
	End If

	// Bin 6  // Règlement d’un fournisseur pour un diagnostic conforme sans Somme de RM
	If ibBSRegFourDiagConfSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaCNV", "ibBSRegFourDiagConfSansRM" )
	End If

	// Bin 7  // Règlement d’un fournisseur pour un diagnostic non conforme sans Somme de RM
	If ibBSRegFourDiagNConfSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaCNV", "ibBSRegFourDiagNConfSansRM" )
	End If

	// Bin 8  // Remplacement (Non annulé)
	If ibBSRemplacementNonAnn Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaCNV", "ibBSRemplacementNonAnn" )
	End If

	// Bin 9  // Réparation (réparé) (Non annulé)
	If ibBSRepaRepaNonAnn Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaCNV", "ibBSRepaRepaNonAnn" )
	End If

	// Bin 10 // Réparation (irréparable) (Non annulé)
	If ibBSRepaIRRepaNonAnn Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaCNV", "ibBSRepaIRRepaNonAnn" )
	End If

	// Bin 11 // Réparation SAV (Non annulé)
	If ibBSRepaSAVNonAnn Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaCNV", "ibBSRepaSAVNonAnn" )
	End If

	// Bin 12 // Diag (conforme) (Non annulé)
	If ibBSDiagConfNonAnn Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaCNV", "ibBSDiagConfNonAnn" )
	End If

	// Bin 13 // Diag (non conforme) (Non annulé)
	If ibBSDiagNConfNonAnn Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaCNV", "ibBSDiagNConfNonAnn" )
	End If
	
End If


// Cas 10 : // Passage d’un diagnostic
If ibPrestaDiagCNV Then

	// Bin 1  // Règlement num inter A sur une Gti sans Somme de RM Total
	If ibBSRegNumInterAssSurGtiSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaDiagCNV", "ibBSRegNumInterAssSurGtiSansRM" )
	End If

	// Bin 2  // Règlement d’un fournisseur pour une réparation réparée Somme de RM Total
	If ibBSRegFourRepaRepaSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaDiagCNV", "ibBSRegFourRepaRepaSansRM" )
	End If

	// Bin 3  // Règlement d’un fournisseur pour un réparation irréparable sans Somme de RM Total
	If ibBSRegFourRepaIRRepaSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaDiagCNV", "ibBSRegFourRepaIRRepaSansRM" )
	End If

	// Bin 4  // Règlement d’un fournisseur pour un réparation SAV sans Somme de RM Total
	If ibBSRegFourRepaSAVSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaDiagCNV", "ibBSRegFourRepaSAVSansRM" )
	End If

	// Bin 5  // Règlement d’un fournisseur pour un remplacement sans Somme de RM Total
	If ibBSRegFourRemplSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaDiagCNV", "ibBSRegFourRemplSansRM" )
	End If

	// Bin 6  // Règlement d’un fournisseur pour un diagnostic conforme sans Somme de RM
	If ibBSRegFourDiagConfSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaDiagCNV", "ibBSRegFourDiagConfSansRM" )
	End If

	// Bin 7  // Règlement d’un fournisseur pour un diagnostic non conforme sans Somme de RM
	If ibBSRegFourDiagNConfSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaDiagCNV", "ibBSRegFourDiagNConfSansRM" )
	End If

	// Bin 8  // Remplacement (Non annulé)
	If ibBSRemplacementNonAnn Then
		This.wf_DeclencherIncoherence ( "ibPrestaDiagCNV", "ibBSRemplacementNonAnn" )
	End If

	// Bin 9  // Réparation (réparé) (Non annulé)
	If ibBSRepaRepaNonAnn Then
		This.wf_DeclencherIncoherence ( "ibPrestaDiagCNV", "ibBSRepaRepaNonAnn" )
	End If

	// Bin 10 // Réparation (irréparable) (Non annulé)
	If ibBSRepaIRRepaNonAnn Then
		This.wf_DeclencherIncoherence ( "ibPrestaDiagCNV", "ibBSRepaIRRepaNonAnn" )
	End If

	// Bin 11 // Réparation SAV (Non annulé)
	If ibBSRepaSAVNonAnn Then
		This.wf_DeclencherIncoherence ( "ibPrestaDiagCNV", "ibBSRepaSAVNonAnn" )
	End If

	// Bin 12 // Diag (conforme) (Non annulé)
	If ibBSDiagConfNonAnn Then
		This.wf_DeclencherIncoherence ( "ibPrestaDiagCNV", "ibBSDiagConfNonAnn" )
	End If

	// Bin 13 // Diag (non conforme) (Non annulé)
	If ibBSDiagNConfNonAnn Then
		This.wf_DeclencherIncoherence ( "ibPrestaDiagCNV", "ibBSDiagNConfNonAnn" )
	End If

End If

// Cas 11 : // Passage d’une réparation SAV
If ibPrestaRepaSavCNV Then

	// Bin 1  // Règlement num inter A sur une Gti sans Somme de RM Total
	If ibBSRegNumInterAssSurGtiSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaSavCNV", "ibBSRegNumInterAssSurGtiSansRM" )
	End If

	// Bin 3  // Règlement d’un fournisseur pour un réparation irréparable sans Somme de RM Total
	If ibBSRegFourRepaIRRepaSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaSavCNV", "ibBSRegFourRepaIRRepaSansRM" )
	End If

	// Bin 4  // Règlement d’un fournisseur pour un réparation SAV sans Somme de RM Total
	If ibBSRegFourRepaSAVSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaSavCNV", "ibBSRegFourRepaSAVSansRM" )
	End If

	// Bin 5  // Règlement d’un fournisseur pour un remplacement sans Somme de RM Total
	If ibBSRegFourRemplSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaSavCNV", "ibBSRegFourRemplSansRM" )
	End If

	// Bin 6  // Règlement d’un fournisseur pour un diagnostic conforme sans Somme de RM
	If ibBSRegFourDiagConfSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaSavCNV", "ibBSRegFourDiagConfSansRM" )
	End If

	// Bin 7  // Règlement d’un fournisseur pour un diagnostic non conforme sans Somme de RM
	If ibBSRegFourDiagNConfSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaSavCNV", "ibBSRegFourDiagNConfSansRM" )
	End If

	// Bin 7  // Règlement d’un fournisseur pour un diagnostic non conforme sans Somme de RM
	If ibBSRegFourDiagNConfSansRM Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaSavCNV", "ibBSRegFourDiagNConfSansRM" )
	End If

	// Bin 8  // Remplacement (Non annulé)
	If ibBSRemplacementNonAnn Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaSavCNV", "ibBSRemplacementNonAnn" )
	End If

	// Bin 10 // Réparation (irréparable) (Non annulé)
	If ibBSRepaIRRepaNonAnn Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaSavCNV", "ibBSRepaIRRepaNonAnn" )
	End If

	// Bin 11 // Réparation SAV (Non annulé)
	If ibBSRepaSAVNonAnn Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaSavCNV", "ibBSRepaSAVNonAnn" )
	End If

	// Bin 12 // Diag (conforme) (Non annulé)
	If ibBSDiagConfNonAnn Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaSavCNV", "ibBSDiagConfNonAnn" )
	End If

	// Bin 12 // Bin 13 // Diag (non conforme) (Non annulé)
	If ibBSDiagNConfNonAnn Then
		This.wf_DeclencherIncoherence ( "ibPrestaRepaSavCNV", "ibBSDiagNConfNonAnn" )
	End If


End If

Return ibAMU_Incoherence

end function

public subroutine wf_detectiondescas ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_resume_action_gestion::Wf_DetectionDesCas 
//* Auteur			: JFF
//* Date				: 05/02/2014
//* Libellé			: [VDOC12845]
//* Commentaires	:
//*
//* Arguments		: 
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------
//       JFF   18/08/2014 [PM254_V1]
//*-----------------------------------------------------------------

Long lTotInter, lCptInter, lIdI, lRow, lIdSin, lRowDet
String sResult

// Règlement num inter A sur une Gti hors UF (8).
ibRegNumInterAssSurGti = idw_LstInter.Find ( "MT_A_REG > 0", 1, idw_LstInter.RowCount ()) > 0 And &
								 idw_wDetail.Find ( "COD_ETAT = 500 AND ID_I_REG = 0 AND ID_GTI NOT IN (8)", 1, idw_wDetail.RowCount ()) > 0 

// Règlement lié à un fournisseur
ibRegFournPRS2 = FALSE // Règlement d’un fournisseur pour un réparation réparé
ibRegFournPRS21 = FALSE // Règlement d’un fournisseur pour un réparation irréparable
ibRegFournPRSSav = FALSE // Règlement d’un fournisseur pour un réparation SAV
ibRegFournRempl = False  // Règlement d’un fournisseur pour un remplacement
ibRegFournDiagConf = False  // Règlement d’un fournisseur pour d’un diagnostic conforme
ibRegFournDiagNConf = False // Règlement d’un fournisseur pour d’un diagnostic non conforme

lTotInter = idw_LstInter.RowCount ()

For lCptInter = 1 To lTotInter 
	
	If lCptInter = 1 Then
		lIdSin = idw_LstInter.GetItemNumber ( lCptInter, "ID_SIN" )
		ilIdSin = lIdSin
	End If
	
	If idw_LstInter.GetItemString ( lCptInter, "COD_INTER" ) <> "F" Then Continue
	If idw_LstInter.GetItemDecimal ( lCptInter, "MT_A_REG" ) <= 0 Then Continue
	
	lIdI = idw_LstInter.GetItemNumber ( lCptInter, "ID_I" )
	
	lRowDet= idw_wDetail.Find ( "COD_ETAT = 500 AND ID_I_REG = " + String ( lIdI ), 1, idw_wDetail.RowCount () ) 
	If lRowDet <=0 Then Continue
	
	lRow = idw_LstwCommande.Find &
			 ( "ID_GTI     = " + String ( idw_wDetail.GetItemNumber ( lRowDet, "ID_GTI" ) )    + " AND " + &
				"ID_DETAIL  = " + String ( idw_wDetail.GetItemNumber ( lRowDet, "ID_DETAIL" ) ) + " AND " + &
				"ID_TYP_ART = 'PRS'"																			  + " AND " + &
				"STATUS_GC  = 2"																			 	  				  &
				,1, idw_LstwCommande.RowCount () )
	If lRow > 0 Then 
		ibRegFournPRS2 = TRUE
		Exit
	End If
	
	lRow = idw_LstwCommande.Find &
			 ( "ID_GTI     = " + String ( idw_wDetail.GetItemNumber ( lRowDet, "ID_GTI" ) )    + " AND " + &
				"ID_DETAIL  = " + String ( idw_wDetail.GetItemNumber ( lRowDet, "ID_DETAIL" ) ) + " AND " + &
				"ID_TYP_ART = 'PRS'"																			  + " AND " + &
				"STATUS_GC  = 21"																			 	  				  &
				,1, idw_LstwCommande.RowCount () )
	If lRow > 0 Then 
		ibRegFournPRS21 = TRUE
		Exit
	End If

	lRow = idw_LstwCommande.Find &
			 ( "ID_GTI     = " + String ( idw_wDetail.GetItemNumber ( lRowDet, "ID_GTI" ) )    + " AND " + &
				"ID_DETAIL  = " + String ( idw_wDetail.GetItemNumber ( lRowDet, "ID_DETAIL" ) ) + " AND " + &
				"POS ( INFO_SPB_FRN_CPLT, '_SAV=OUI' ) > 0 " &
				,1, idw_LstwCommande.RowCount () )
				
	If lRow > 0 Then 
		ibRegFournPRSSav = TRUE
		Exit
	End If

	lRow = idw_LstwCommande.Find &
			 ( "ID_GTI     = " + String ( idw_wDetail.GetItemNumber ( lRowDet, "ID_GTI" ) )    + " AND " + &
				"ID_DETAIL  = " + String ( idw_wDetail.GetItemNumber ( lRowDet, "ID_DETAIL" ) ) + " AND " + &
				"ID_TYP_ART NOT IN ( 'EDI', 'PRS', 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', " + & 
				" 'PCM', 'MAI', 'REL', 'RST', 'PST', 'RES', 'REA' )"								  &
				,1, idw_LstwCommande.RowCount () )
	If lRow > 0 Then 
		ibRegFournRempl = TRUE
		Exit
	End If

	lRow = idw_LstwCommande.Find &
			 ( "ID_GTI     = " + String ( idw_wDetail.GetItemNumber ( lRowDet, "ID_GTI" ) )    + " AND " + &
				"ID_DETAIL  = " + String ( idw_wDetail.GetItemNumber ( lRowDet, "ID_DETAIL" ) ) + " AND " + &
				"ID_REF_FOUR = 'A_DIAGNOSTIQUER'"														  + " AND " + &
				"STATUS_GC  = 151"																			 	  				  &
				,1, idw_LstwCommande.RowCount () )
	If lRow > 0 Then 
		ibRegFournDiagConf = TRUE
		Exit
	End If

	lRow = idw_LstwCommande.Find &
			 ( "ID_GTI     = " + String ( idw_wDetail.GetItemNumber ( lRowDet, "ID_GTI" ) )    + " AND " + &
				"ID_DETAIL  = " + String ( idw_wDetail.GetItemNumber ( lRowDet, "ID_DETAIL" ) ) + " AND " + &
				"ID_REF_FOUR = 'A_DIAGNOSTIQUER'"														  + " AND " + &
				"STATUS_GC  = 152"																			 	  				  &
				,1, idw_LstwCommande.RowCount () )
	If lRow > 0 Then 
		ibRegFournDiagNConf = TRUE
		Exit
	End If

Next


// Passage d'un flux 
ibPrestaRemplCNV = False // Passage d’un remplacement
ibPrestaRepaCNV = False // Passage d’une réparation
ibPrestaDiagCNV = False // Passage d’un diagnostic	  
ibPrestaRepaSavCNV = False // Passage d’une réparation SAV

// Passage d’un remplacement
lRow = idw_LstwCommande.Find &
		 ( "COD_ETAT = 'CNV' AND " + &
			"ID_TYP_ART NOT IN ( 'EDI', 'PRS', 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', " + & 
			" 'PCM', 'MAI', 'REL', 'RST', 'PST', 'RES', 'REA' )"								  &
			,1, idw_LstwCommande.RowCount () )
If lRow > 0 Then 
	ibPrestaRemplCNV = TRUE
End If

// Passage d’une réparation
lRow = idw_LstwCommande.Find &
		 ( "ID_TYP_ART = 'PRS' AND COD_ETAT = 'CNV'" &
		   ,1, idw_LstwCommande.RowCount () )
If lRow > 0 Then 
	ibPrestaRepaCNV = TRUE
End If


// Passage d’un diagnostic
lRow = idw_LstwCommande.Find &
		 ( "ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT = 'CNV'" &
		   ,1, idw_LstwCommande.RowCount () )
If lRow > 0 Then 
	ibPrestaDiagCNV = TRUE
End If

// Passage d’une réparation SAV
lRow = idw_LstwCommande.Find &
		 ( "ID_TYP_ART = 'PRS' AND COD_ETAT = 'CNV' AND POS ( INFO_SPB_FRN_CPLT, '_SAV=OUI' ) > 0" &
		   ,1, idw_LstwCommande.RowCount () )
If lRow > 0 Then 
	ibPrestaRepaCNV = TRUE
End If

// PS pour les actions déjà passées
sResult = Fill ( "", 255 )
SQLCA.PS_S_REGL_PRESTA_VDOC12845  ( lIdSin , sResult )

ibBSRegNumInterAssSurGtiSansRM = Mid ( sResult, 1, 1 ) = "1"
ibBSRegFourRepaRepaSansRM 		 = Mid ( sResult, 2, 1 ) = "1"
ibBSRegFourRepaIRRepaSansRM 	 = Mid ( sResult, 3, 1 ) = "1"
ibBSRegFourRepaSAVSansRM 		 = Mid ( sResult, 4, 1 ) = "1"
ibBSRegFourRemplSansRM 		    = Mid ( sResult, 5, 1 ) = "1"
ibBSRegFourDiagConfSansRM 		 = Mid ( sResult, 6, 1 ) = "1"
ibBSRegFourDiagNConfSansRM 	 = Mid ( sResult, 7, 1 ) = "1"
ibBSRemplacementNonAnn 			 = Mid ( sResult, 8, 1 ) = "1"
ibBSRepaRepaNonAnn 				 = Mid ( sResult, 9, 1 ) = "1"
ibBSRepaIRRepaNonAnn 		    = Mid ( sResult, 10, 1 ) = "1"
ibBSRepaSAVNonAnn 				 = Mid ( sResult, 11, 1 ) = "1"
ibBSDiagConfNonAnn 				 = Mid ( sResult, 12, 1 ) = "1"
ibBSDiagNConfNonAnn 				 = Mid ( sResult, 13, 1 ) = "1"
ibBSSwapCTRNonAnn 				 = Mid ( sResult, 14, 1 ) = "1" // [PM254_V1]

end subroutine

public subroutine wf_definitiondesactions ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_resume_action_gestion::wf_definitiondesactions
//* Auteur			: JFF
//* Date				: 05/02/2014
//* Libellé			: [VDOC12845]
//* Commentaires	:
//*
//* Arguments		: 
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------
//       JFF   18/08/2014 [PM254_V1]
//*-----------------------------------------------------------------



// Action Courante

// Règlement num inter A sur une Gti Hors GTi UF (8).
isTbLibActionCourante [1,1] = "ibRegNumInterAssSurGti"
isTbLibActionCourante [1,2] = "Vous réglez l'assuré sur une garantie (hors UF)"

// Règlement d’un fournisseur pour un réparation réparé
isTbLibActionCourante [2,1] = "ibRegFournPRS2"  
isTbLibActionCourante [2,2] = "Vous réglez un fournisseur pour une réparation (réparée)"

// Règlement d’un fournisseur pour un réparation irréparable
isTbLibActionCourante [3,1] = "ibRegFournPRS21"  
isTbLibActionCourante [3,2] = "Vous réglez un fournisseur pour une réparation (irréparable)"

// Règlement d’un fournisseur pour un réparation SAV
isTbLibActionCourante [4,1] = "ibRegFournPRSSav"  
isTbLibActionCourante [4,2] = "Vous réglez un fournisseur pour une réparation en mode SAV"

// Règlement d’un fournisseur pour un remplacement
isTbLibActionCourante [5,1] = "ibRegFournRempl"
isTbLibActionCourante [5,2] = "Vous réglez un fournisseur pour un remplacement"

// Règlement d’un fournisseur pour d’un diagnostic conforme
isTbLibActionCourante [6,1] = "ibRegFournDiagConf"  
isTbLibActionCourante [6,2] = "Vous réglez un fournisseur pour un diagnostic (conforme)"

// Règlement d’un fournisseur pour d’un diagnostic non conforme
isTbLibActionCourante [7,1] = "ibRegFournDiagNConf"
isTbLibActionCourante [7,2] = "Vous réglez un fournisseur pour d'un diagnostic (non conforme)"

// Passage d’un remplacement
isTbLibActionCourante [8,1] = "ibPrestaRemplCNV"  
isTbLibActionCourante [8,2] = "Vous passez une prestation de remplacement, Bon d'achat, etc"

// Passage d’une réparation
isTbLibActionCourante [9,1] = "ibPrestaRepaCNV"  
isTbLibActionCourante [9,2] = "Vous passez une prestation de réparation, désoxydation"

// Passage d’un diagnostic
isTbLibActionCourante [10,1] = "ibPrestaDiagCNV"  
isTbLibActionCourante [10,2] = "Vous passez une prestation de diagnostic"

// Passage d’une réparation en mode SAV
isTbLibActionCourante [11,1] = "ibPrestaRepaSavCNV"  
isTbLibActionCourante [11,2] = "Vous passez une réparation en mode SAV"




// Action Existante

// Bin 1  // Règlement num inter A sur une Gti sans Somme de RM Total Hors UF
isTbLibActionExistante [1,1] = "ibBSRegNumInterAssSurGtiSansRM"
isTbLibActionExistante [1,2] = "Règlement assuré sur une garantie (hors UF) sans Somme Totale RM"

// Bin 2  // Règlement d’un fournisseur pour une réparation réparée Somme de RM Total
isTbLibActionExistante [2,1] = "ibBSRegFourRepaRepaSansRM" 
isTbLibActionExistante [2,2] = "Règlement fournisseur pour une réparation (réparée) sans Somme Totale RM"

// Bin 3  // Règlement d’un fournisseur pour un réparation irréparable sans Somme de RM Total
isTbLibActionExistante [3,1] = "ibBSRegFourRepaIRRepaSansRM"
isTbLibActionExistante [3,2] = "Règlement fournisseur pour une réparation (irréparable) sans Somme Totale RM"

// Bin 4  // Règlement d’un fournisseur pour un réparation SAV sans Somme de RM Total
isTbLibActionExistante [4,1] = "ibBSRegFourRepaSAVSansRM" 
isTbLibActionExistante [4,2] = "Règlement fournisseur pour une réparation mode SAV sans Somme Totale RM"

// Bin 5  // Règlement d’un fournisseur pour un remplacement sans Somme de RM Total
isTbLibActionExistante [5,1] = "ibBSRegFourRemplSansRM"
isTbLibActionExistante [5,2] = "Règlement fournisseur pour un remplacement sans Somme Totale RM"

// Bin 6  // Règlement d’un fournisseur pour un diagnostic conforme sans Somme de RM
isTbLibActionExistante [6,1] = "ibBSRegFourDiagConfSansRM" 
isTbLibActionExistante [6,2] = "Règlement fournisseur pour un diagnostic (conforme) sans Somme Totale RM"

// Bin 7  // Règlement d’un fournisseur pour un diagnostic non conforme sans Somme de RM
isTbLibActionExistante [7,1] = "ibBSRegFourDiagNConfSansRM" 
isTbLibActionExistante [7,2] = "Règlement fournisseur pour un diagnostic (non conforme) sans Somme Totale RM"

// Bin 8  // Remplacement (Non annulé)
isTbLibActionExistante [8,1] = "ibBSRemplacementNonAnn" 
isTbLibActionExistante [8,2] = "Remplacement (non annulé)"

// Bin 9  // Réparation (réparé) (Non annulé)
isTbLibActionExistante [9,1] = "ibBSRepaRepaNonAnn" 
isTbLibActionExistante [9,2] = "Réparation (réparée) (non annulée)"

// Bin 10 // Réparation (irréparable) (Non annulé)
isTbLibActionExistante [10,1] = "ibBSRepaIRRepaNonAnn" 
isTbLibActionExistante [10,2] = "Réparation (irréparable) (non annulée)"

// Bin 11 // Réparation SAV (Non annulé)
isTbLibActionExistante [11,1] = "ibBSRepaSAVNonAnn"
isTbLibActionExistante [11,2] = "Réparation en mode SAV (non annulée)"

// Bin 12 // Diag (conforme) (Non annulé)
isTbLibActionExistante [12,1] = "ibBSDiagConfNonAnn" 
isTbLibActionExistante [12,2] = "Diagnostic (conforme) (non annulé)"

// Bin 13 // Diag (non conforme) (Non annulé)
isTbLibActionExistante [13,1] = "ibBSDiagNConfNonAnn"
isTbLibActionExistante [13,2] = "Diagnostic (non conforme) (non annulé)"

// [PM254_V1]
// Bin 14 // Swap par CTR (Non annulé)
isTbLibActionExistante [14,1] = "ibBSSwapCTRNonAnn"
isTbLibActionExistante [14,2] = "Swap effectué par le CTR (Non annulé)"

end subroutine

public subroutine wf_declencherincoherence (string asactioncourante, string asactionexistante);//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_resume_action_gestion::wf_declencherincoherence
//* Auteur			: JFF
//* Date				: 05/02/2014
//* Libellé			: [VDOC12845]
//* Commentaires	:
//*
//* Arguments		: 
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------

Long lCptCompteur, lRow, lCptRow, lTotRow 
String sLibActionCourante, sLibActionExistante, sSql


ibAMU_Incoherence = TRUE

lTotRow = UpperBound ( isTbLibActionCourante, 1 )
For lCptRow = 1 To lTotRow 
	If isTbLibActionCourante [ lCptRow, 1 ] = asActionCourante Then
		sLibActionCourante = isTbLibActionCourante [ lCptRow, 2 ]
	End If
Next

lTotRow = UpperBound ( isTbLibActionExistante, 1 )
For lCptRow = 1 To lTotRow 
	If isTbLibActionExistante [ lCptRow, 1 ] = asActionExistante Then
		sLibActionExistante = isTbLibActionExistante [ lCptRow, 2 ]
	End If
Next


lRow = dw_action.Find ( "CLE = '" + asActionCourante + "'", 1, dw_action.RowCount () )

If lRow <= 0 Then
	iCptCompteur ++
	lCptCompteur = iCptCompteur
	lRow = dw_action.InsertRow (0)
	dw_action.SetItem ( lRow, "CLE", asActionCourante )
	dw_action.SetItem ( lRow, "CPT_LIEN", lCptCompteur )
	dw_action.SetItem ( lRow, "ACTION", sLibActionCourante )
Else
	lCptCompteur = dw_action.GetItemNumber ( lRow, "CPT_LIEN" )
End IF 


lRow = dw_existant.Find ( "CLE = '" + asActionExistante + "'", 1, dw_existant.RowCount () )

If lRow <= 0 Then
	lRow = dw_existant.InsertRow (0)
	dw_existant.SetItem ( lRow, "CLE", asActionExistante )
	dw_existant.SetItem ( lRow, "CPT_LIEN", lCptCompteur )
	dw_existant.SetItem ( lRow, "ACTION", sLibActionExistante )
Else
	dw_existant.SetItem ( lRow, "CPT_LIEN", lCptCompteur )
End IF 


sSql = "Exec sysadm.PS_I_TRACE_ALERTE " + &
			String ( ilIdSin ) + "., " + &
			"'" + asActionCourante + "', " + &
			"'" + asActionExistante + "', " + &
			"null, " + &
			"'" + stGlb.sCodOper + "', " + &
			"'" + String ( iDtCleInsert ) + "'" 

F_Execute ( sSql, SQLCA )

F_COMMIT ( SQLCA, SQLCA.SqlCode = 0 And SQLCA.SqlDBCode = 0 )


end subroutine

on w_t_resume_action_gestion.create
this.cb_stop=create cb_stop
this.cb_ok=create cb_ok
this.st_info=create st_info
this.st_existant=create st_existant
this.st_action=create st_action
this.dw_existant=create dw_existant
this.dw_action=create dw_action
this.Control[]={this.cb_stop,&
this.cb_ok,&
this.st_info,&
this.st_existant,&
this.st_action,&
this.dw_existant,&
this.dw_action}
end on

on w_t_resume_action_gestion.destroy
destroy(this.cb_stop)
destroy(this.cb_ok)
destroy(this.st_info)
destroy(this.st_existant)
destroy(this.st_action)
destroy(this.dw_existant)
destroy(this.dw_action)
end on

event open;//*-----------------------------------------------------------------
//*
//* Fonction		: w_t_resume_action_gestion::open
//* Auteur			: JFF
//* Date				: 05/02/2014
//* Libellé			: [VDOC12845]
//* Commentaires	:
//*
//* Arguments		: 
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------

s_pass stPass
s_pass stNull

ibPasseParClose = FALSE

This.Hide ()

dw_action.Modify ( "cle.protect=1 cpt_lien.protect=1 action.protect=1 " )
dw_existant.Modify ( "cle.protect=1 cpt_lien.protect=1 action.protect=1 " )

stPass=Message.Powerobjectparm

idw_LstInter = stPass.dwtab[1]
idw_LstwCommande = stPass.dwtab[2]
idw_wDetail = stPass.dwnorm[1]

ilIdSin = -1

This.Wf_DefinitionDesActions ()
This.Wf_DetectionDesCas ()

If This.Wf_AMU_Incoherence () Then
	This.Show ()
Else 
	stPass = stNull
	stPass.sTab [1] = "OK"
	isSortie = "OK"
	Message.Powerobjectparm = stPass
	CloseWithReturn(This, Message.Powerobjectparm )
End If

end event

event close;
If Not ibPasseParClose And isSortie <> "OK" Then 
	cb_stop.Event Clicked ()
End If

ibPasseParClose = TRUE
end event

type cb_stop from commandbutton within w_t_resume_action_gestion
integer x = 1650
integer y = 1592
integer width = 1083
integer height = 148
integer taborder = 30
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Je revoie mon acte de gestion"
end type

event clicked;
s_Pass stPass

String sSql 


sSql = "Exec sysadm.PS_U_TRACE_ALERTE " + &
			String ( ilIdSin ) + "., " + &
			"'STOP', " + &
			"'" + stGlb.sCodOper + "', " + &
			"'" + String ( iDtCleInsert ) + "'" 

F_Execute ( sSql, SQLCA )
F_COMMIT ( SQLCA, SQLCA.SqlCode = 0 And SQLCA.SqlDBCode = 0 )


stPass.sTab [1] = "STOP"

Message.Powerobjectparm = stPass

CloseWithReturn(Parent, Message.Powerobjectparm )

end event

type cb_ok from commandbutton within w_t_resume_action_gestion
integer x = 466
integer y = 1592
integer width = 1097
integer height = 148
integer taborder = 30
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Situation normale, je continue"
end type

event clicked;
s_Pass stPass
String sSql 


sSql = "Exec sysadm.PS_U_TRACE_ALERTE " + &
			String ( ilIdSin ) + "., " + &
			"'OK', " + &
			"'" + stGlb.sCodOper + "', " + &
			"'" + String ( iDtCleInsert ) + "'" 

F_Execute ( sSql, SQLCA )
F_COMMIT ( SQLCA, SQLCA.SqlCode = 0 And SQLCA.SqlDBCode = 0 )


stPass.sTab [1] = "OK"
isSortie = "OK"

Message.Powerobjectparm = stPass

CloseWithReturn(Parent, Message.Powerobjectparm )

end event

type st_info from statictext within w_t_resume_action_gestion
integer x = 41
integer y = 1412
integer width = 3177
integer height = 160
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cette fenêtre n~'est pas bloquante, elle a simplement pour but de vous alerter sur d~'éventuelles incohérences de gestion."
boolean focusrectangle = false
end type

type st_existant from statictext within w_t_resume_action_gestion
integer x = 41
integer y = 736
integer width = 3218
integer height = 88
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "...semblent incohérentes avec des actions de gestion déjà validées sur ce dossier (ci-dessous)"
boolean focusrectangle = false
end type

type st_action from statictext within w_t_resume_action_gestion
integer x = 425
integer y = 36
integer width = 2450
integer height = 92
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "les actions de gestion que vous êtes en train de passer (ci-dessous)..."
boolean focusrectangle = false
end type

type dw_existant from datawindow within w_t_resume_action_gestion
integer x = 41
integer y = 816
integer width = 3186
integer height = 580
integer taborder = 20
string title = "none"
string dataobject = "d_resume_action_2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_action from datawindow within w_t_resume_action_gestion
integer x = 41
integer y = 144
integer width = 3186
integer height = 568
integer taborder = 10
string title = "none"
string dataobject = "d_resume_action_1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

