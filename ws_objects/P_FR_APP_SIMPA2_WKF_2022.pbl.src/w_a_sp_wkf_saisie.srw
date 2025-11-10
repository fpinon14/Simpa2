$PBExportHeader$w_a_sp_wkf_saisie.srw
$PBExportComments$-} Fenêtre d'accueil pour la saisie des dossiers
forward
global type w_a_sp_wkf_saisie from w_a_spb_workflow
end type
type pb_tel from picturebutton within w_a_sp_wkf_saisie
end type
type pb_consult from picturebutton within w_a_sp_wkf_saisie
end type
type pb_workflow from picturebutton within w_a_sp_wkf_saisie
end type
type pb_edition from picturebutton within w_a_sp_wkf_saisie
end type
type pb_validation from picturebutton within w_a_sp_wkf_saisie
end type
end forward

global type w_a_sp_wkf_saisie from w_a_spb_workflow
integer x = 1
integer y = 1
string title = "Saisie de sinistres"
event ue_saisie_automatique pbm_custom39
event ue_message_sherpa pbm_custom38
pb_tel pb_tel
pb_consult pb_consult
pb_workflow pb_workflow
pb_edition pb_edition
pb_validation pb_validation
end type
global w_a_sp_wkf_saisie w_a_sp_wkf_saisie

type variables
Private :

String	isBoutonRac
String      isAction
String      isParam

// True : On cherche a ouvrir le dossier à partir de Sherpa 
// False : On cherche a ouvrir le dossier en double cliquant
// dessus, donc impossible.
Boolean	ibVenuParSherpa

// Gestion raccourcis Workflow
//CP Boolean	ibRaccActif 
end variables

forward prototypes
public subroutine wf_anonymationensim (long adcidsin)
end prototypes

event ue_saisie_automatique;//*-----------------------------------------------------------------
//*
//* Objet			: Dw_1
//* Evenement 		: ue_SaisieAutomatique
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
//* #1    FS     15/03/2002  Interprétation des ordres de sherpa
//* #2    FS    25/09/2002   Mémorisation de gsParam et gsAction en instance
//*                          pour utilisation ultérieure sur ue_message_sherpa
//*-----------------------------------------------------------------

String sIdsin
s_Pass stPass


isAction = gsAction 
isParam  = gsParam

// ... #1 Début de modification

CHOOSE CASE gsaction

   CASE "TEST_GERER"

		/*----------------------------------------------------------------------------*/
		/* La fenêtre de gestion est-elle ouverte ?                                   */
		/*----------------------------------------------------------------------------*/

      gsParam = "FERME"

		If IsValid ( W_Tm_Sp_Sinistre ) Then // ... La fenêtre de traitement est ouverte

			IF W_Tm_Sp_Sinistre.visible then gsParam = "OUVERT"

     	End If

      Return

	CASE "GERER"

		/*----------------------------------------------------------------------------*/
		/* Simulation automatique de consultation.                                    */
		/*----------------------------------------------------------------------------*/

		// ... Si la fenêtre est encore ouverte : on n'ouvre pas le dossier

		If IsValid ( W_Tm_Sp_Sinistre ) Then
			IF W_Tm_Sp_Sinistre.visible then

				stMessage.sTitre  	= "Ouverture dossier " + gsParam
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= Ok!
				stMessage.sCode		= "GENE070"
				stMessage.sVar[1]		= gsParam
				F_Message ( stMessage )
				Return
			End If
		End If


		// ... On provoque le chargement du travail dans dw_1

		SetPointer ( HourGlass! )

		stPass.sTab[2] = "sysadm.w_queue.id_sin = '" + gsParam + "'"
		stPass.sTab[1] = " WHERE " + stPass.sTab[2] 

		Message.PowerObjectParm = stPass
		This.TriggerEvent ( "ue_Fin_Interro" )

		// ... On provoque l'ouverture du dossier à partir du travail de dw_1

		If dw_1.RowCount () > 0 Then
			dw_1.ilLigneClick = 1
			dw_1.SelectRow (1, TRUE )
			dw_1.ScrollToRow ( 1 )
			dw_1.SetRow ( 1 )
			ibVenuParSherpa = True
			This.TriggerEvent ( "ue_Modifier" )
			ibVenuParSherpa = False
		End If

		gsAction = ""
		gsParam  = ""

		SetPointer ( Arrow! )
      Return

END CHOOSE


// ... #1 Fin de modification

/*------------------------------------------------------------------*/
/* Code d'origine SIMPA :                                           */
/*------------------------------------------------------------------*/


CHOOSE CASE stGlb.sMessageErreur

/*----------------------------------------------------------------------------*/
/* Raccourci vers accueil sinistre.                                           */
/*----------------------------------------------------------------------------*/
	CASE "SAISIESIN"

		If IsValid ( W_Tm_Sp_Sinistre ) Then
			IF Not W_Tm_Sp_Sinistre.visible then
				pb_Interro.TriggerEvent ("clicked")
			ENd If 
		Else
			pb_Interro.TriggerEvent ("clicked")
		End If

/*----------------------------------------------------------------------------*/
/*	Ouverture fen sinistre suite trv en consult.                               */
/*----------------------------------------------------------------------------*/
	CASE ELSE

		/*----------------------------------------------------------------------------*/
		/* Simulation automatique de saisie.                                          */
		/*----------------------------------------------------------------------------*/
		sIdSin =	stGlb.sMessageErreur 

		If IsValid ( W_Tm_Sp_Sinistre ) Then
			IF W_Tm_Sp_Sinistre.visible then
				stMessage.sTitre  	= "Ouverture automatique"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= Ok!
				stMessage.sCode		= "GENE070"
				stMessage.sVar[1]		= sIdSin
				F_Message ( stMessage )
				Return
			End If
		End If

		stPass.sTab[2] = "sysadm.w_queue.id_sin = '" + sIdsin + "'"
		stPass.sTab[1] = " WHERE " + stPass.sTab[2] 

		Message.PowerObjectParm = stPass

		This.TriggerEvent ( "ue_Fin_Interro" )

		If dw_1.RowCount () > 0 Then
			dw_1.ilLigneClick = 1
			dw_1.SelectRow (1, TRUE )
			dw_1.ScrollToRow ( 1 )
			dw_1.SetRow ( 1 )
			This.TriggerEvent ( "ue_Modifier" )
		End If


END CHOOSE

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_message_sherpa;

Long lHandle, lRet
String sCmd

// DCMP 70647
long lHandleSherpa, lMessageIdSherpa, lLongParm, lWordParam
// FIN - DCMP 70647

/*------------------------------------------------------------------*/
/* Gestion de la valeur de retour pour SHERPA                       */
/*------------------------------------------------------------------*/

Yield()

If isParam <> "" Then

   // La ligne est-elle toujours dans la dw_1

   lRet = dw_1.Find ( "id_sin='"+ isParam + "'", 1, 99999 )

   If lRet > 0 Then 

      sCmd = "RET_MAJACCUEIL" + " " + isParam  // ... Le dossier figure toujours dans la liste

		// DCMP 70647
		lWordParam = 700000
		lLongParm = long(isParam)
		// FIN - DCMP 70647
		
   Else

      sCmd = "RET_DELACCUEIL" + " " + isParam  // ... Le dossier n'est plus dans la liste

		// DCMP 70647
		lWordParam = 700100
		lLongParm = long(isParam)
		// FIN - DCMP 70647
		
   End If

   // Envoi du message à sherpa

// DCMP 70647
		lHandleSherpa = w_mdi_sp.Wf_Browse_Fenetre ( "SHERPA" )
		if	lHandleSherpa > 0	then
				lMessageIdSherpa = 1023 + 1
					
				lRet = Send ( lHandleSherpa, lMessageIdSherpa, lWordParam, lLongParm )
		end if

//	lhandle = OpenChannel( "SHERPA", "AUTO")
//
//	If lHandle > 0 Then
//
//		lRet = ExecRemote( sCmd , lhandle)
//
//		CloseChannel ( lhandle )
//
//	End If
// FIN - DCMP 70647

End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

public subroutine wf_anonymationensim (long adcidsin);//*-----------------------------------------------------------------
//*
//* Fonction		: W_T_Sp_Cree_Wkf::wf_AnonymationEnSim (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 13/02/2019
//* Libellé			: 
//* Commentaires	: [PM473-1]
//*
//* Arguments		: adcidsin
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ 			PAR		Date		Modification
//*-----------------------------------------------------------------

String sSql
Boolean bRet 
Long lRet

lRet = SQLCA.PS_U_TRT_PM260 ( adcIdSin, "SIM" )

If lRet > 0 Then
	F_Execute ( sSql, SQLCA )
	
	bRet = SQLCA.SqlCode = 0 And SQLCA.SqlDBCode = 0
	
	F_Commit ( SQLCA, bRet )  // Commit/Rollback
End If 


end subroutine

event ue_item6;call super::ue_item6;//*-----------------------------------------------------------------
//*
//* Objet			: Fenêtre
//* Evenement 		: ue_item6
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
//* Libellé			: Ouverture fenêtre en raccourci.
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

Choose Case isBoutonRac

	Case "TEL","COURRIER"

		stGlb.sMessageErreur = isBoutonRac

		If IsValid ( W_a_Sp_Cree_Travail ) Then 
			W_a_Sp_Cree_Travail.Show()
		Else
			OpenSheetWithParm ( W_a_Sp_Cree_Travail, stGLB, W_Mdi_Sp, 0, Layered! )
		End If

		W_a_Sp_Cree_Travail.BringToTop = True
		W_a_Sp_Cree_Travail.TriggerEvent ("ue_Saisie_Automatique")

	Case "CONS"

		If IsValid ( w_ac_sp_dossier_2000 ) Then 
			w_ac_sp_dossier_2000.Show()
		Else
			OpenSheetWithParm ( w_ac_sp_dossier_2000 , stGLB, W_Mdi_Sp, 0, Layered! )
		End If

		w_ac_sp_dossier_2000.BringToTop = True
		w_ac_sp_dossier_2000.TriggerEvent ("ue_Saisie_Automatique")

	Case "EDTSIN"

		/*------------------------------------------------------------------*/
		/* Si on est en SVE                                                 */
		/*------------------------------------------------------------------*/
		If stGLB.bSaiValEdt Then
			If IsValid ( W_Ae_Sp_Edition_Dcmp060589 ) Then 
				W_Ae_Sp_Edition_Dcmp060589.Show()
			Else
				OpenSheetWithParm ( W_Ae_Sp_Edition_Dcmp060589, stGLB, W_Mdi_Sp, 0, Layered! )
			End If

			W_Ae_Sp_Edition_Dcmp060589.BringToTop = True
			W_Ae_Sp_Edition_Dcmp060589.TriggerEvent ("ue_Saisie_Automatique")

		Else 
			If IsValid ( w_ae_sp_edit_sinistre_wkf_2000 ) Then 
				w_ae_sp_edit_sinistre_wkf_2000.Show()
			Else
				OpenSheetWithParm ( w_ae_sp_edit_sinistre_wkf_2000 , stGLB, W_Mdi_Sp, 0, Layered! )
			End If

			w_ae_sp_edit_sinistre_wkf_2000.BringToTop = True
			w_ae_sp_edit_sinistre_wkf_2000.TriggerEvent ("ue_Saisie_Automatique")

		End If


	Case "VALSIN"

		stGlb.sMessageErreur = isBoutonRac

		If IsValid ( w_a_sp_wkf_validation ) Then 
			w_a_sp_wkf_validation.Show()
		Else
			OpenSheetWithParm ( w_a_sp_wkf_validation , stGLB, W_Mdi_Sp, 0, Layered! )
		End If

		w_a_sp_wkf_validation.BringToTop = True
		w_a_sp_wkf_validation.TriggerEvent ("ue_Saisie_Automatique")


End Choose

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_wkf_saisie
//* Evenement 		: ue_initialiser
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
//* Libellé			: 
//* Commentaires	: 
//*				 
//* Arguments		: 
//*
//* Retourne		: NotFound
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #2	 JFF		05/09/2002 Gestion de l'accès au workflow (Sherpa)
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Initialisation des boutons de téléphonie.                        */
/*------------------------------------------------------------------*/
/* #2 : JFF le 04/09/2002														  */
/*------------------------------------------------------------------*/
ibRaccActif = ProfileString ( stGlb.sFichierIni, "BOUTONS RACCOURCIS", "BoutonRac", "" ) = "O"
ibVenuParSherpa = False

pb_Consult.Visible 	 = stGlb.bConsult
pb_edition.Visible 	 = stGlb.bEdtSin

pb_Workflow.Visible = ibRaccActif And stGlb.bCreationTrv
pb_Tel.Visible = ibRaccActif And stGlb.bCreationTrv
pb_validation.Visible = ibRaccActif And stGlb.bValSin
pb_interro.Visible = ibRaccActif
pb_tri.Visible = ibRaccActif
pb_imprimer.Visible = ibRaccActif

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Wkf_Saisie::Ue_Modifier (!!! OVERRIDE !!!)
//* Evenement 		: Ue_Modifier
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 11:03:18
//* Libellé			: 
//* Commentaires	: Ouverture de la fenêtre de gestion des sinistres
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1	 JFF		05/09/2002 Acitvation/Désactivation de la Dw d'accueil
//* #2	FPI	 12/10/2009	[DCMP090616] Dossier suivi par oblig
//*     JFF    29/10/2018  [CONS_REST_CARDIF]
//*       JFF   11/02/2019 [PM473-1]
//*-----------------------------------------------------------------

Boolean bRet

/*------------------------------------------------------------------*/
/* #1 : JFF le 04/09/2002														  */
/*------------------------------------------------------------------*/
If Not ibRaccActif And Not ibVenuParSherpa Then Return 

/*------------------------------------------------------------------*/
/* #1 : JFF le 04/09/2002, on réappelle le script ancêtre sinon.	  */
/*------------------------------------------------------------------*/
Call Super::ue_Modifier

SetPointer ( HourGlass! )

If ibContinuerModifier Then

	istPass.bSupprime = False
	istPass.bControl  = True
	istPass.bInsert   = False
	istPass.sTab[1] 	= dw_1.GetItemString ( dw_1.ilLigneClick, "ID_SIN" )
	istPass.sTab[2] 	= "S"				// Nous sommes en saisie
/*------------------------------------------------------------------*/
/* Le 16/06/1998 : Pour la détermination du Code courrier à         */
/* envoyer à chacun des interlocuteurs, on a besoin de connaître    */
/* dans la fonction Uf_Determiner_Courrier de U_Gs_Sinistre la      */
/* provenance du courrier.                                          */
/*------------------------------------------------------------------*/
	istPass.sTab[3] 	= dw_1.GetItemString ( dw_1.ilLigneClick, "COD_I_PROV" )					// Provenance du courrier recu
/*------------------------------------------------------------------*/
/* Le 08/07/1998 : Pour la composition des variables, on a besoin   */
/* de connaitre le type de courrier recu, ainsi que la date du      */ 
/* dernier courrier client.                                         */
/*------------------------------------------------------------------*/
	istPass.sTab[4] 	= dw_1.GetItemString ( dw_1.ilLigneClick, "COD_RECU" )					// Type de courrier recu
	istPass.sTab[5] 	= String ( dw_1.GetItemDateTime ( dw_1.ilLigneClick, "DTE_COUR_CLI" ), "dd/mm/yyyy"	)	// Date du dernier courrier client

	// #6
	istPass.sTab[6] 	= dw_1.GetItemString ( dw_1.ilLigneClick, "COD_TYP_RECU" )

	If SQLCA.PS_S_CONS_RESTR_EXCL( Long ( istPass.sTab[1]), stGlb.sCodOper, "W" ) < 0 Then
		stMessage.sTitre		= "Accès interdit"
		stMessage.Icon		   = Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "GENE180"
		F_Message ( stMessage )
		F_Execute ( "Exec sysadm.PS_U_CONS_RESTR_EXCL " + istPass.sTab[1] + ".", SQLCA )
		bRet = SQLCA.SqlCode = 0 And SQLCA.SqlDbCode = 0
		If bRet Then
			F_COMMIT ( SQLCA, True )
			dw_1.SetItem ( dw_1.ilLigneClick, "ALT_OCCUPE", "N" )
		Else 
			F_COMMIT ( SQLCA, False )				
		End If 

	Else 
		// [PM473-1]
		If Upper(SQLCA.Database) <> "SIMPA2_PRO" &
		And Not F_CLE_A_TRUE ( "PM473-1_SPECIAL_TEST" ) Then
		
			Choose Case stGlb.sCodOper 
				Case "JFF", "FPI"
					If F_CLE_A_TRUE ( "BASE_SIM_ANONYME" ) Then
						This.wf_AnonymationEnSim ( Long ( istPass.sTab[1]))
					End If
				Case Else
					This.wf_AnonymationEnSim ( Long ( istPass.sTab[1]))
			End Choose 
		End If 
	
		F_OuvreTraitement ( W_Tm_Sp_Sinistre, istpass )
	End If

End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_workflow;call super::ue_workflow;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Wkf_Saisie::Ue_WorkFlow
//* Evenement 		: Ue_WorkFlow
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 11:04:37
//* Libellé			: 
//* Commentaires	: Gestion d'une fenêtre de workflow
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On est en saisie de sinistre, on arme la variable pour le        */
/* SELECT sur COD_ETAT.                                             */
/*------------------------------------------------------------------*/

isCodEtat = '1'

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_fermer_interro;call super::ue_fermer_interro;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Wkf_Saisie::Ue_Fermer_Interro
//* Evenement 		: Ue_Fermer_Interro (EXTEND)
//* Auteur			: Erick John Stark
//* Date				: 24/10/1997 15:30:45
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild		dwChild

W_Interro.dw_1.GetChild ( "ID_CORB", dwChild )
dwChild.ShareDataOff ()

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_preparer_interro;call super::ue_preparer_interro;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Wkf_Saisie::Ue_Preparer_Interro
//* Evenement 		: Ue_Preparer_Interro (EXTEND)
//* Auteur			: Erick John Stark
//* Date				: 24/10/1997 15:30:45
//* Libellé			: 
//* Commentaires	: Populise la liste des corbeilles dans la dw d'interro
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild		dwChild, dwChild1

W_Interro.dw_1.GetChild ( "ID_CORB", dwChild )
dw_Corbeille.GetChild ( "ID_CORB", dwChild1 )
dwChild1.ShareData ( dwChild )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on w_a_sp_wkf_saisie.create
int iCurrent
call super::create
this.pb_tel=create pb_tel
this.pb_consult=create pb_consult
this.pb_workflow=create pb_workflow
this.pb_edition=create pb_edition
this.pb_validation=create pb_validation
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_tel
this.Control[iCurrent+2]=this.pb_consult
this.Control[iCurrent+3]=this.pb_workflow
this.Control[iCurrent+4]=this.pb_edition
this.Control[iCurrent+5]=this.pb_validation
end on

on w_a_sp_wkf_saisie.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_tel)
destroy(this.pb_consult)
destroy(this.pb_workflow)
destroy(this.pb_edition)
destroy(this.pb_validation)
end on

event ue_fin_interro;call super::ue_fin_interro;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Wkf_Saisie::Ue_Fin_Interro
//* Evenement 		: Ue_Fin_Interro
//* Auteur			: FABRY JF
//* Date				: 13/02/2019
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//      JFF  11/02/2019 [PM473-1]
//*-----------------------------------------------------------------

Long lTot, lCpt, lIdSin

If Upper(SQLCA.Database) <> "SIMPA2_PRO" &
	And Not F_CLE_A_TRUE ( "PM473-1_SPECIAL_TEST" ) &
	Then

	lTot = Dw_1.RowCount ()

	Choose Case stGlb.sCodOper 
		Case "JFF", "FPI"
			If Not F_CLE_A_TRUE ( "BASE_SIM_ANONYME" ) Then
				lTot = 0 
			End If
	End Choose 	
	
	
	For lCpt = 1 To lTot
	
		lIdSin = Long ( dw_1.GetItemString ( lCpt, "ID_SIN" ))

		If SQLCA.PS_CTLE_DOS_CREE_EN_SIM ( lIdSin ) < 0 Then
			dw_1.SetItem ( lCpt, "NOM", "XXANONYMEXX XXANONYM" )		
		End If 
		
		
	Next

Else 
	
	lTot = Dw_1.RowCount ()
	
	For lCpt = 1 To lTot
	
		lIdSin = Long ( dw_1.GetItemString ( lCpt, "ID_SIN" ))
	
		If SQLCA.PS_S_CONS_RESTR_EXCL ( lIdSin, stGlb.sCodOper, "W" ) < 0 Then
			dw_1.SetItem ( lCpt, "NOM", "!! INT. PAR ASS. !!" )
		End If 
	
	Next

End If 


	

	






end event

event ue_taillerhauteur;//*****************************************************************************
//
// Objet 		: w_Accueil
// Evenement 	: UE_TAILLERHAUTEUR
//	Auteur		: Erick John Stark
//	Date			: 20/02/1996
// Libellé		: 
// Commentaires: Centrage de la DW d'accueil dans la hauteur de la Fenêtre
//						  /!\ OVERRIDE /!\
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

// [PB2022_TAILLE_FEN] (- 50)
dw_1.Uf_Hauteur ( This.Height - 70 , 0 )

// [PB2022_TAILLE_FEN] 
dw_1.X = 280

If	dw_1.Visible = False Then
	dw_1.Visible = True
End If

end event

type cb_debug from w_a_spb_workflow`cb_debug within w_a_sp_wkf_saisie
end type

type pb_retour from w_a_spb_workflow`pb_retour within w_a_sp_wkf_saisie
integer taborder = 90
end type

type pb_interro from w_a_spb_workflow`pb_interro within w_a_sp_wkf_saisie
integer taborder = 110
end type

type pb_creer from w_a_spb_workflow`pb_creer within w_a_sp_wkf_saisie
boolean visible = false
integer x = 745
integer y = 164
boolean enabled = false
end type

type dw_1 from w_a_spb_workflow`dw_1 within w_a_sp_wkf_saisie
integer x = 219
integer taborder = 80
string ispointer = ""
end type

on dw_1::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet         : dw_1
//* Evenement     : ue_modifiermenu  (!! OVERRIDE !! )
//* Auteur        : Fabry JF
//* Date          : 02/10/2002 12:34:39
//* Libellé       : Shunt Pour Mise en place Sherpa
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

If ibRaccActif Then 
	Call Super::ue_ModifierMenu
Else
	This.uf_Mnu_SupprimerItem ( 1 )
	This.uf_Mnu_SupprimerItem ( 2 )
	This.uf_Mnu_SupprimerItem ( 3 )
End If
end on

event dw_1::ue_majaccueil;call super::ue_majaccueil;If IsValid ( Parent ) Then Parent.postEvent ( "ue_message_sherpa" )

end event

on dw_1::constructor;call w_a_spb_workflow`dw_1::constructor;//*-----------------------------------------------------------------
//*
//* Fonction		: w_a_spb_workflow::dw_1
//* Evenement 		: ::Constructor
//* Auteur			: DBI
//* Date				: 22/09/1999 16:47:40
//* Libellé			: Suppression de la limitation à 150 lignes 
//* Commentaires	: la limite pose des problèmes lors de la vérification des
//*				     anciens travaux non traités
//*				  
//*-----------------------------------------------------------------

ilMaxLig = 0
end on

event dw_1::rbuttondown;//Migration PB8-WYNIWYG-03/2006 FM
//ce code remplace le code de l'ancêtre, 
//il permet la sélection de la ligne sur le click droit

If Row > 0 Then
	This.SetRow(Row)
	SelectRow(Row, True)
end if

call super::rButtonDown

Return AncestorReturnValue

//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type pb_tri from w_a_spb_workflow`pb_tri within w_a_sp_wkf_saisie
integer taborder = 130
end type

type pb_imprimer from w_a_spb_workflow`pb_imprimer within w_a_sp_wkf_saisie
end type

type dw_libre from w_a_spb_workflow`dw_libre within w_a_sp_wkf_saisie
integer x = 50
integer y = 212
end type

type mle_msg1 from w_a_spb_workflow`mle_msg1 within w_a_sp_wkf_saisie
end type

type pb_debloc from w_a_spb_workflow`pb_debloc within w_a_sp_wkf_saisie
end type

type dw_corbeille from w_a_spb_workflow`dw_corbeille within w_a_sp_wkf_saisie
integer x = 247
integer y = 212
integer taborder = 100
boolean livescroll = false
end type

type dw_workflow from w_a_spb_workflow`dw_workflow within w_a_sp_wkf_saisie
integer x = 443
integer y = 212
integer taborder = 120
boolean livescroll = false
end type

type pb_tel from picturebutton within w_a_sp_wkf_saisie
integer x = 18
integer y = 568
integer width = 242
integer height = 144
integer taborder = 30
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Décl.Tél."
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_tel.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: pb_Tel
//* Evenement 		: Clicked
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
//* Libellé			: 
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

isBoutonRac = "TEL"
Parent.TriggerEvent ( "ue_Item6" )
end on

type pb_consult from picturebutton within w_a_sp_wkf_saisie
integer x = 18
integer y = 856
integer width = 242
integer height = 144
integer taborder = 40
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consult."
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_cons.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: pb_Tel
//* Evenement 		: Clicked
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
//* Libellé			: 
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

isBoutonRac = "CONS"
Parent.TriggerEvent ( "ue_Item6" )

end on

type pb_workflow from picturebutton within w_a_sp_wkf_saisie
integer x = 18
integer y = 712
integer width = 242
integer height = 144
integer taborder = 70
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Courrier"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_trv.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: pb_Tel
//* Evenement 		: Clicked
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
//* Libellé			: 
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

isBoutonRac = "COURRIER"
Parent.TriggerEvent ( "ue_Item6" )

end on

type pb_edition from picturebutton within w_a_sp_wkf_saisie
integer x = 18
integer y = 1000
integer width = 242
integer height = 144
integer taborder = 50
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Edt. Sin."
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_edtsin.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: pb_edition
//* Evenement 		: Clicked
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
//* Libellé			: 
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

isBoutonRac = "EDTSIN"
Parent.TriggerEvent ( "ue_Item6" )

end on

type pb_validation from picturebutton within w_a_sp_wkf_saisie
integer x = 18
integer y = 1144
integer width = 242
integer height = 144
integer taborder = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Val. Sin"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_valsin.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: pb_Tel
//* Evenement 		: Clicked
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
//* Libellé			: 
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

isBoutonRac = "VALSIN"
Parent.TriggerEvent ( "ue_Item6" )

end on

