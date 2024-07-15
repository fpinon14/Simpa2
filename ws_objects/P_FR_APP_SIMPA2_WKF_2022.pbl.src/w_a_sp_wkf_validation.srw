HA$PBExportHeader$w_a_sp_wkf_validation.srw
forward
global type w_a_sp_wkf_validation from w_a_spb_workflow
end type
type pb_saisie from picturebutton within w_a_sp_wkf_validation
end type
type pb_consult from picturebutton within w_a_sp_wkf_validation
end type
type pb_tel from picturebutton within w_a_sp_wkf_validation
end type
type pb_workflow from picturebutton within w_a_sp_wkf_validation
end type
type pb_edition from picturebutton within w_a_sp_wkf_validation
end type
end forward

global type w_a_sp_wkf_validation from w_a_spb_workflow
integer height = 1888
string title = "Validation de sinistres"
event ue_saisie_automatique pbm_custom39
event ue_message_sherpa pbm_custom38
pb_saisie pb_saisie
pb_consult pb_consult
pb_tel pb_tel
pb_workflow pb_workflow
pb_edition pb_edition
end type
global w_a_sp_wkf_validation w_a_sp_wkf_validation

type variables
Private :
	W_Tm_Sp_Sinistre		iw_Tm_Sp_Sinistre_Validation
	String			isBoutonRac
	String			isAction
	String			isParam

// True : On cherche a ouvrir le dossier $$HEX2$$e0002000$$ENDHEX$$partir de Sherpa 
// False : On cherche a ouvrir le dossier en double cliquant
// dessus, donc impossible.
Boolean	ibVenuParSherpa

// Gestion raccourcis Workflow

//Migration PB8-WYNIWYG-03/2006 CP Ici pour eviter un conflit avec une var. globale de meme nom
//Boolean	ibRaccActif 	
Boolean	New_ibRaccActif
//Fin Migration PB8-WYNIWYG-03/2006 CP




end variables

event ue_saisie_automatique;//*-----------------------------------------------------------------
//*
//* Objet			: Dw_1
//* Evenement 		: ue_SaisieAutomatique
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Overture de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement de validation
//* Commentaires	: 
//*				 
//* Arguments		: 
//*
//* Retourne		: NotFound
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    PLJ   25/07/2002   Ouverture automatique pour les dossier venant de Sherpa 
//* #2    FS    25/09/2002   M$$HEX1$$e900$$ENDHEX$$morisation de gsParam et gsAction en instance
//*                          pour utilisation ult$$HEX1$$e900$$ENDHEX$$rieure sur ue_message_sherpa
//* #3 	 JFF	 02/10/2002	  Utilisation d'un code indiquant d'ou l'on vient : ibVenuParSherpa
//*-----------------------------------------------------------------

String sIdsin
s_Pass stPass

isAction = gsAction // ... #2
isParam  = gsParam  // ... #2

// ... #1 D$$HEX1$$e900$$ENDHEX$$but de modification
CHOOSE CASE gsaction

   CASE "TEST_VALIDER"

		/*----------------------------------------------------------------------------*/
		/* La fen$$HEX1$$ea00$$ENDHEX$$tre de validation est-elle ouverte ?                                */
		/*----------------------------------------------------------------------------*/

      gsParam = "FERME"
   

		If IsValid ( iw_Tm_Sp_Sinistre_Validation ) Then	// ... La fen$$HEX1$$ea00$$ENDHEX$$tre de traitement est ouverte

				IF iw_Tm_Sp_Sinistre_Validation.visible then gsParam = "OUVERT"

     	End If

//Migration PB8-WYNIWYG-03/2006 FM
//      Return
      Return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM


	CASE "VALIDER"

		/*----------------------------------------------------------------------------*/
		/* Simulation automatique de l'ouverture de la validation                     */
		/*----------------------------------------------------------------------------*/

		// ... Si la fen$$HEX1$$ea00$$ENDHEX$$tre est encore ouverte : on n'ouvre pas le dossier

		If IsValid ( iw_Tm_Sp_Sinistre_Validation ) Then
			IF iw_Tm_Sp_Sinistre_Validation.visible then
				stMessage.sTitre  	= "Ouverture dossier " + gsParam
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= Ok!
				stMessage.sCode		= "GENE071"
				stMessage.sVar[1]		= gsParam
				F_Message ( stMessage )
//Migration PB8-WYNIWYG-03/2006 FM
//				Return
				Return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If
		End If


		// ... On provoque le chargement du travail dans dw_1

		SetPointer ( HourGlass! )

		stPass.sTab[2] = "sysadm.w_queue.id_sin = '" + gsParam + "'"
		stPass.sTab[1] = " WHERE " + stPass.sTab[2] 

		Message.PowerObjectParm = stPass
		This.TriggerEvent ( "ue_Fin_Interro" )

		// ... On provoque l'ouverture du dossier $$HEX2$$e0002000$$ENDHEX$$partir du travail de dw_1

		If dw_1.RowCount () > 0 Then
			dw_1.ilLigneClick = 1
			dw_1.SelectRow (1, TRUE )
			dw_1.ScrollToRow ( 1 )
			dw_1.SetRow ( 1 )

			//#3
			ibVenuParSherpa = True
			This.Event Ue_Modifier(0,0)
/*------------------------------------------------------------------*/
/* [MIGPB8COR]                                                      */
/* DGA. Probl$$HEX1$$e800$$ENDHEX$$me affichage Word. On essaye avec un PostEvent.       */
/*------------------------------------------------------------------*/
//			This.TriggerEvent ( "ue_Modifier" )
			ibVenuParSherpa = False
		End If

		gsAction = ""
		gsParam  = ""

		SetPointer ( Arrow! )
//Migration PB8-WYNIWYG-03/2006 FM
//		Return
		Return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM
     
END CHOOSE
// ... #1 Fin de modification


CHOOSE CASE stGlb.sMessageErreur

/*----------------------------------------------------------------------------*/
/* Raccourci vers accueil sinistre.                                           */
/*----------------------------------------------------------------------------*/
	CASE "VALSIN"

//Migration PB8-WYNIWYG-03/2006 CP Ici pour eviter un conflit avec une var. globale de meme nom
//		If ibRaccActif Then 
		If New_ibRaccActif Then 
//Fin Migration PB8-WYNIWYG-03/2006 CP
			If IsValid ( iw_Tm_Sp_Sinistre_Validation ) Then
				IF Not iw_Tm_Sp_Sinistre_Validation.visible then
					pb_Interro.TriggerEvent ("clicked")
				ENd If 
			Else
				pb_Interro.TriggerEvent ("clicked")
			End If
		End If


/*----------------------------------------------------------------------------*/
/*	Ouverture fen sinistre suite trv en consult.                               */
/*----------------------------------------------------------------------------*/
	CASE ELSE

		/*----------------------------------------------------------------------------*/
		/* Simulation automatique de saisie.                                          */
		/*----------------------------------------------------------------------------*/
		sIdSin =	stGlb.sMessageErreur 

		If IsValid ( iw_Tm_Sp_Sinistre_Validation) Then
			IF iw_Tm_Sp_Sinistre_Validation.visible then
				stMessage.sTitre  	= "Ouverture automatique"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= Ok!
				stMessage.sCode		= "GENE071"
				stMessage.sVar[1]		= sIdSin
				F_Message ( stMessage )
//Migration PB8-WYNIWYG-03/2006 FM
//				Return
				Return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM
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

			//#3
			ibVenuParSherpa = True
			This.TriggerEvent ( "ue_Modifier" )
			ibVenuParSherpa = False

		End If

END CHOOSE

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM


end event

event ue_message_sherpa;Long lHandle, lRet
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

   // Envoi du message $$HEX2$$e0002000$$ENDHEX$$sherpa

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

event ue_item6;call super::ue_item6;//*-----------------------------------------------------------------
//*
//* Objet			: Fen$$HEX1$$ea00$$ENDHEX$$tre
//* Evenement 		: ue_item6
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ouverture fen$$HEX1$$ea00$$ENDHEX$$tre en raccourci.
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
/* Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil de saisie de sinistre.                   */
/*----------------------------------------------------------------------------*/
SetPointer ( HourGlass! )

Choose Case isBoutonRac

	Case "SAISIESIN"

		stGlb.sMessageErreur = isBoutonRac

		If IsValid ( W_a_Sp_Wkf_Saisie ) Then 
			W_a_Sp_Wkf_Saisie.Show()
		Else
			OpenSheetWithParm ( W_a_Sp_Wkf_Saisie, stGLB, W_Mdi_Sp, 0, Layered! )
		End If

		W_a_Sp_Wkf_Saisie.BringToTop = True
		W_a_Sp_Wkf_Saisie.TriggerEvent ("ue_Saisie_Automatique")


	Case "CONS"

		If IsValid ( w_ac_sp_dossier_2000 ) Then 
			w_ac_sp_dossier_2000.Show()
		Else
			OpenSheetWithParm ( w_ac_sp_dossier_2000 , stGLB, W_Mdi_Sp, 0, Layered! )
		End If

		w_ac_sp_dossier_2000.BringToTop = True
		w_ac_sp_dossier_2000.TriggerEvent ("ue_Saisie_Automatique")

	Case "TEL", "COURRIER"

		stGlb.sMessageErreur = isBoutonRac

		If IsValid ( W_a_Sp_Cree_Travail ) Then 
			W_a_Sp_Cree_Travail.Show()
		Else
			OpenSheetWithParm ( W_a_Sp_Cree_Travail, stGLB, W_Mdi_Sp, 0, Layered! )
		End If

		W_a_Sp_Cree_Travail.BringToTop = True
		W_a_Sp_Cree_Travail.TriggerEvent ("ue_Saisie_Automatique")


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
End Choose

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: Fen d'acc de Valid.
//* Evenement 		: ue_initialiser (EXTEND)
//* Auteur			: JFF
//* Date				: 09/07/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #2		   JFF		05/09/2002 Gestion de la gestion de contact uniquement pour Sherpa
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Initialisation des boutons de raccourcis.                        */
/*------------------------------------------------------------------*/
/* #2 : JFF le 04/09/2002														  */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP Ici pour eviter un conflit avec une var. globale de meme nom
//ibRaccActif = ProfileString ( stGlb.sFichierIni, "BOUTONS RACCOURCIS", "BoutonRac", "" ) = "O"
New_ibRaccActif = ProfileString ( stGlb.sFichierIni, "BOUTONS RACCOURCIS", "BoutonRac", "" ) = "O"
//Fin Migration PB8-WYNIWYG-03/2006 CP

ibVenuParSherpa = False

pb_Consult.Visible 	= stGlb.bConsult
pb_Edition.Visible 	= stGlb.bEdtSin

//Migration PB8-WYNIWYG-03/2006 CP Ici pour eviter un conflit avec une var. globale de meme nom
//pb_Tel.Visible 		= ibRaccActif And stGlb.bCreationTrv
//pb_WorkFlow.Visible 	= ibRaccActif And stGlb.bCreationTrv
//pb_Saisie.Visible 	= ibRaccActif And stGlb.bSaisieSin
//pb_interro.Visible = ibRaccActif
//pb_tri.Visible = ibRaccActif
//pb_imprimer.Visible = ibRaccActif
pb_Tel.Visible 		= New_ibRaccActif And stGlb.bCreationTrv
pb_WorkFlow.Visible 	= New_ibRaccActif And stGlb.bCreationTrv
pb_Saisie.Visible 	= New_ibRaccActif And stGlb.bSaisieSin
pb_interro.Visible = New_ibRaccActif
pb_tri.Visible = New_ibRaccActif
pb_imprimer.Visible = New_ibRaccActif
//Fin Migration PB8-WYNIWYG-03/2006 CP

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Wkf_Valid::Ue_Modifier (!! OverRide !! )
//* Evenement 		: Ue_Modifier
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 11:03:18
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de validation des sinistres
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1	 JFF		05/09/2002 Acitvation/D$$HEX1$$e900$$ENDHEX$$sactivation de la Dw d'accueil
//*-----------------------------------------------------------------

Boolean	bActif

/*------------------------------------------------------------------*/
/* #1 : JFF le 04/09/2002														  */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP Ici pour eviter un conflit avec une var. globale de meme nom
//If Not ibRaccActif And Not ibVenuParSherpa Then Return 
If Not New_ibRaccActif And Not ibVenuParSherpa Then Return 
//Fin Migration PB8-WYNIWYG-03/2006 CP



/*------------------------------------------------------------------*/
/* #1 : JFF le 04/09/2002, on r$$HEX1$$e900$$ENDHEX$$appelle le script anc$$HEX1$$ea00$$ENDHEX$$tre sinon.	  */
/*------------------------------------------------------------------*/
Call Super::ue_Modifier
SetPointer ( HourGlass! )

If ibContinuerModifier Then

	istPass.bSupprime = False
	istPass.bControl  = True
	istPass.bInsert   = False
	istPass.sTab[1] 	= dw_1.GetItemString ( dw_1.ilLigneClick, "ID_SIN" )
	istPass.sTab[2] 	= "V"				// Nous sommes en validation
/*------------------------------------------------------------------*/
/* Le 16/06/1998 : Pour la d$$HEX1$$e900$$ENDHEX$$termination du Code courrier $$HEX10$$e000200020002000200020002000200020002000$$ENDHEX$$*/
/* envoyer $$HEX2$$e0002000$$ENDHEX$$chacun des interlocuteurs, on a besoin de conna$$HEX1$$ee00$$ENDHEX$$tre    */
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

	F_OuvreTraitement ( iW_Tm_Sp_Sinistre_Validation, istpass )

End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_workflow;call super::ue_workflow;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Wkf_Valid::Ue_WorkFlow
//* Evenement 		: Ue_WorkFlow
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 11:04:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion d'une fen$$HEX1$$ea00$$ENDHEX$$tre de workflow
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On est en validation de sinistre, on arme la variable pour le    */
/* SELECT sur COD_ETAT.                                             */
/*------------------------------------------------------------------*/

isCodEtat = '5'

///*------------------------------------------------------------------*/
///* On initialise le DataObject pour l'interrogation des travaux,    */
///* sinon par d$$HEX1$$e900$$ENDHEX$$faut on utilise celui des anc$$HEX1$$ea00$$ENDHEX$$tres.                  */
///*------------------------------------------------------------------*/
//
//pb_Interro.istInterro.wAncetre				= This
//pb_Interro.istInterro.sTitre 					= "Recherche des Travaux"
//pb_Interro.istInterro.sDataObject			= "d_sp_int_w_queue"
//pb_Interro.istInterro.sCodeDw					= "TRAVAUX - Simpa2"
//
//pb_Interro.istInterro.sData[1].sNom			= "id_sin"
//pb_Interro.istInterro.sData[1].sDbName		= "sysadm.w_queue.id_sin"
//pb_Interro.istInterro.sData[1].sType		= "STRING"
//pb_Interro.istInterro.sData[1].sOperande	= "="
//
//pb_Interro.istInterro.sData[2].sNom			= "id_corb"
//pb_Interro.istInterro.sData[2].sDbName		= "sysadm.w_queue.id_corb"
//pb_Interro.istInterro.sData[2].sType		= "STRING"
//pb_Interro.istInterro.sData[2].sOperande	= "="
//
//pb_Interro.istInterro.sData[3].sNom			= "trv_maj_par"
//pb_Interro.istInterro.sData[3].sDbName		= "sysadm.w_queue.dos_maj_par"
//pb_Interro.istInterro.sData[3].sType		= "STRING"
//pb_Interro.istInterro.sData[3].sOperande	= "="
//
//pb_Interro.istInterro.sData[4].sNom			= "nom"
//pb_Interro.istInterro.sData[4].sDbName		= "sysadm.w_queue.nom"
//pb_Interro.istInterro.sData[4].sType		= "STRING"
//pb_Interro.istInterro.sData[4].sOperande	= "="
//

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_preparer_interro;call super::ue_preparer_interro;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Wkf_Valid::Ue_Preparer_Interro
//* Evenement 		: Ue_Preparer_Interro (EXTEND)
//* Auteur			: Erick John Stark
//* Date				: 24/10/1997 15:30:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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

on w_a_sp_wkf_validation.create
int iCurrent
call super::create
this.pb_saisie=create pb_saisie
this.pb_consult=create pb_consult
this.pb_tel=create pb_tel
this.pb_workflow=create pb_workflow
this.pb_edition=create pb_edition
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_saisie
this.Control[iCurrent+2]=this.pb_consult
this.Control[iCurrent+3]=this.pb_tel
this.Control[iCurrent+4]=this.pb_workflow
this.Control[iCurrent+5]=this.pb_edition
end on

on w_a_sp_wkf_validation.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_saisie)
destroy(this.pb_consult)
destroy(this.pb_tel)
destroy(this.pb_workflow)
destroy(this.pb_edition)
end on

event ue_fermer_interro;call super::ue_fermer_interro;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Wkf_Valid::Ue_Fermer_Interro
//* Evenement 		: Ue_Fermer_Interro (EXTEND)
//* Auteur			: Erick John Stark
//* Date				: 24/10/1997 15:30:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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

type cb_debug from w_a_spb_workflow`cb_debug within w_a_sp_wkf_validation
end type

type pb_retour from w_a_spb_workflow`pb_retour within w_a_sp_wkf_validation
integer taborder = 90
end type

type pb_interro from w_a_spb_workflow`pb_interro within w_a_sp_wkf_validation
integer taborder = 110
end type

type pb_creer from w_a_spb_workflow`pb_creer within w_a_sp_wkf_validation
boolean visible = false
integer x = 741
integer y = 168
boolean enabled = false
end type

type dw_1 from w_a_spb_workflow`dw_1 within w_a_sp_wkf_validation
integer taborder = 80
end type

on dw_1::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet         : dw_1
//* Evenement     : ue_modifiermenu  (!! OVERRIDE !! )
//* Auteur        : Fabry JF
//* Date          : 02/10/2002 12:34:39
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Shunt Pour Mise en place Sherpa
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

//Migration PB8-WYNIWYG-03/2006 CP Ici pour eviter un conflit avec une var. globale de meme nom
//If ibRaccActif Then 
If New_ibRaccActif Then 
//Fin Migration PB8-WYNIWYG-03/2006 CP
	Call Super::ue_ModifierMenu
Else
	This.uf_Mnu_SupprimerItem ( 1 )
	This.uf_Mnu_SupprimerItem ( 2 )
	This.uf_Mnu_SupprimerItem ( 3 )
End If
end on

event dw_1::ue_majaccueil;call super::ue_majaccueil;If IsValid ( Parent ) Then Parent.postevent ( "ue_message_sherpa" )
end event

on dw_1::constructor;call w_a_spb_workflow`dw_1::constructor;//*-----------------------------------------------------------------
//*
//* Fonction		: w_a_spb_workflow::dw_1
//* Evenement 		: ::Constructor
//* Auteur			: DBI
//* Date				: 22/09/1999 16:47:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Suppression de la limitation $$HEX2$$e0002000$$ENDHEX$$150 lignes 
//* Commentaires	: la limite pose des probl$$HEX1$$e800$$ENDHEX$$mes lors de la v$$HEX1$$e900$$ENDHEX$$rification des
//*				     anciens travaux non trait$$HEX1$$e900$$ENDHEX$$s
//*				  
//*-----------------------------------------------------------------

ilMaxLig = 0
end on

event dw_1::rbuttondown;//Migration PB8-WYNIWYG-03/2006 FM
//ce code remplace le code de l'anc$$HEX1$$ea00$$ENDHEX$$tre, 
//il permet la s$$HEX1$$e900$$ENDHEX$$lection de la ligne sur le click droit

If Row > 0 Then
	This.SetRow(Row)
	SelectRow(Row, True)
end if

call super::rButtonDown

Return AncestorReturnValue

//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type pb_tri from w_a_spb_workflow`pb_tri within w_a_sp_wkf_validation
integer taborder = 130
end type

type pb_imprimer from w_a_spb_workflow`pb_imprimer within w_a_sp_wkf_validation
end type

type dw_libre from w_a_spb_workflow`dw_libre within w_a_sp_wkf_validation
end type

type mle_msg1 from w_a_spb_workflow`mle_msg1 within w_a_sp_wkf_validation
end type

type pb_debloc from w_a_spb_workflow`pb_debloc within w_a_sp_wkf_validation
end type

type dw_corbeille from w_a_spb_workflow`dw_corbeille within w_a_sp_wkf_validation
integer taborder = 100
end type

type dw_workflow from w_a_spb_workflow`dw_workflow within w_a_sp_wkf_validation
integer taborder = 120
end type

type pb_saisie from picturebutton within w_a_sp_wkf_validation
integer x = 18
integer y = 856
integer width = 242
integer height = 144
integer taborder = 50
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Saisie Sin"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_saisie.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: pb_Saisie
//* Evenement 		: Clicked
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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

isBoutonRac = "SAISIESIN"
Parent.TriggerEvent ( "ue_Item6" )
end on

type pb_consult from picturebutton within w_a_sp_wkf_validation
integer x = 18
integer y = 1000
integer width = 242
integer height = 144
integer taborder = 60
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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

type pb_tel from picturebutton within w_a_sp_wkf_validation
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
string text = "D$$HEX1$$e900$$ENDHEX$$cl.T$$HEX1$$e900$$ENDHEX$$l."
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_tel.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: pb_Tel
//* Evenement 		: Clicked
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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

type pb_workflow from picturebutton within w_a_sp_wkf_validation
integer x = 18
integer y = 712
integer width = 242
integer height = 144
integer taborder = 40
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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

type pb_edition from picturebutton within w_a_sp_wkf_validation
integer x = 18
integer y = 1144
integer width = 242
integer height = 144
integer taborder = 70
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
//* Objet			: pb_Tel
//* Evenement 		: Clicked
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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

