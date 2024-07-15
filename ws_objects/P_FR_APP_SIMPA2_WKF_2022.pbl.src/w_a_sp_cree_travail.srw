HA$PBExportHeader$w_a_sp_cree_travail.srw
$PBExportComments$-} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour la cr$$HEX1$$e900$$ENDHEX$$ation des travaux
forward
global type w_a_sp_cree_travail from w_8_accueil
end type
type dw_2 from datawindow within w_a_sp_cree_travail
end type
type pb_saisie from picturebutton within w_a_sp_cree_travail
end type
type pb_consult from picturebutton within w_a_sp_cree_travail
end type
type pb_tel from picturebutton within w_a_sp_cree_travail
end type
type pb_workflow from picturebutton within w_a_sp_cree_travail
end type
type pb_edition from picturebutton within w_a_sp_cree_travail
end type
type pb_validation from picturebutton within w_a_sp_cree_travail
end type
type sle_1 from singlelineedit within w_a_sp_cree_travail
end type
type cb_1 from commandbutton within w_a_sp_cree_travail
end type
type cb_2 from commandbutton within w_a_sp_cree_travail
end type
end forward

global type w_a_sp_cree_travail from w_8_accueil
integer x = 0
integer y = 0
integer width = 3598
integer height = 1768
string title = "Accueil - Gestion des Travaux"
event ue_saisie_automatique pbm_custom39
dw_2 dw_2
pb_saisie pb_saisie
pb_consult pb_consult
pb_tel pb_tel
pb_workflow pb_workflow
pb_edition pb_edition
pb_validation pb_validation
sle_1 sle_1
cb_1 cb_1
cb_2 cb_2
end type
global w_a_sp_cree_travail w_a_sp_cree_travail

type variables
Private :

String isBoutonRac
end variables

event ue_saisie_automatique;//*-----------------------------------------------------------------
//*
//* Objet			: Fen$$HEX1$$ea00$$ENDHEX$$tre
//* Evenement 		: ue_SaisieAutomatique
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Overture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil dce saisie de sinistre
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
/* Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre sur le Timer, car Probl$$HEX1$$e800$$ENDHEX$$me d'affichage.            */
/* On attend 0.1 secodne avant d'afficher                                     */
/*----------------------------------------------------------------------------*/
istPass.sTab [3] = stGlb.sMessageErreur
Timer (0.1)

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Cree_Travail
//* Evenement 		: Open (EXTEND)
//* Auteur			: Erick John Stark
//* Date				: 06/07/1998 10:28:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #2		   JFF		05/09/2002 Gestion de l'acc$$HEX1$$e800$$ENDHEX$$s au workflow (Sherpa)
//*-----------------------------------------------------------------
Boolean	bAff

//Migration PB8-WYNIWYG-03/2006 CP
//String sTables [ 2 ]			// Table du SELECT
String sTables []			// Table du SELECT
//Fin Migration PB8-WYNIWYG-03/2006 CP

/*------------------------------------------------------------------*/
/* Affecte l'object de transaction $$HEX2$$e0002000$$ENDHEX$$la variable d'instance.        */
/*------------------------------------------------------------------*/
itrTrans = SQLCA

/*------------------------------------------------------------------*/
/*   Description de la DW d'accueil                                 */
/*------------------------------------------------------------------*/
dw_1.istCol [ 1 ].sDbName		=	"sysadm.w_queue.trv_cree_le"
dw_1.istCol [ 1 ].sType			=	"Datetime"
dw_1.istCol [ 1 ].sHeaderName	=	"Cr$$HEX1$$e900$$ENDHEX$$ation"
dw_1.istCol [ 1 ].sFormat		=	"dd/mm/yy hh:mm"
dw_1.istCol [ 1 ].ilargeur		=	17
dw_1.istCol [ 1 ].sAlignement	=	"2"
dw_1.istCol [ 1 ].sInvisible	= 	"N"

dw_1.istCol [ 2 ].sDbName		=	"sysadm.produit.lib_court"
dw_1.istCol [ 2 ].sType			=	"char(20)"
dw_1.istCol [ 2 ].sHeaderName	=	"Produit"
dw_1.istCol [ 2 ].ilargeur		=	20
dw_1.istCol [ 2 ].sAlignement	=	"0"
dw_1.istCol [ 2 ].sInvisible	= 	"N"

dw_1.istCol [ 3 ].sDbName		=	"sysadm.w_queue.id_sin"
//Migration PB8-WYNIWYG-03/2006 FM
//dw_1.istCol [ 3 ].sType			=	"char(6)"
dw_1.istCol [ 3 ].sType			=	"char(10)"  // [PI062]
//Fin Migration PB8-WYNIWYG-03/2006 FM
dw_1.istCol [ 3 ].sHeaderName	=	"Sinistre"
dw_1.istCol [ 3 ].ilargeur		=	10  // [PI062]
dw_1.istCol [ 3 ].sAlignement	=	"0"
dw_1.istCol [ 3 ].sInvisible	= 	"N"

dw_1.istCol [ 4 ].sDbName		=	"sysadm.w_queue.nom"
dw_1.istCol [ 4 ].sType			=	"char(71)"
dw_1.istCol [ 4 ].sHeaderName	=	"Nom"
dw_1.istCol [ 4 ].ilargeur		=	40
dw_1.istCol [ 4 ].sAlignement	=	"0"
dw_1.istCol [ 4 ].sInvisible	= 	"N"

sTables [ 1 ] = "w_queue"
sTables [ 2 ] = "produit"

/*------------------------------------------------------------------*/
/* Jointure entre les tables.                                       */
/*------------------------------------------------------------------*/
dw_1.isJointure = " AND sysadm.w_queue.id_prod = sysadm.produit.id_prod"

/*------------------------------------------------------------------*/
/* Tri par d$$HEX1$$e900$$ENDHEX$$faut de la Data Window d'accueil.                      */
/*------------------------------------------------------------------*/
Dw_1.isTri = "#2 A, #1 A"

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/
dw_1.Uf_Creer_Tout( dw_1.istCol, sTables, itrTrans )

wf_Construire_Chaine_Tri()

/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche                                             */
/*------------------------------------------------------------------*/
pb_Interro.istInterro.wAncetre					= This
pb_Interro.istInterro.sTitre 						= "Recherche des travaux"
pb_Interro.istInterro.sDataObject				= "d_sp_int_w_queue"
pb_Interro.istInterro.sCodeDw						= "W_QUEUE"

pb_Interro.istInterro.sData [ 1 ].sNom			= "id_sin"
pb_Interro.istInterro.sData [ 1 ].sDbName		= "sysadm.w_queue.id_sin"
pb_Interro.istInterro.sData [ 1 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 1 ].sOperande	= "="

pb_Interro.istInterro.sData [ 2 ].sNom			= "id_corb"
pb_Interro.istInterro.sData [ 2 ].sDbName		= "sysadm.w_queue.id_corb"
pb_Interro.istInterro.sData [ 2 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 2 ].sOperande	= "="

pb_Interro.istInterro.sData [ 3 ].sNom			= "maj_par"
pb_Interro.istInterro.sData [ 3 ].sDbName		= "sysadm.w_queue.trv_maj_par"
pb_Interro.istInterro.sData [ 3 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 3 ].sOperande	= "="

pb_Interro.istInterro.sData [ 4 ].sNom			= "nom"
pb_Interro.istInterro.sData [ 4 ].sDbName		= "sysadm.w_queue.nom"
pb_Interro.istInterro.sData [ 4 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 4 ].sOperande	= "="

/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= itrTrans
istPass.bControl	= True		// Utilisation du bouton Cont$$HEX1$$f400$$ENDHEX$$ler.

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la liste des corbeilles maintenant. Sur l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement  */
/* Ue_Preparer_Interro, on fera un ShareData pour afficher le nom   */
/* des corbeilles.                                                  */
/*------------------------------------------------------------------*/
dw_2.SetTransObject ( itrTrans )
dw_2.Retrieve       ( "-CO"    )

/*------------------------------------------------------------------*/
/* Initialisation des boutons de raccourcis.                        */
/*------------------------------------------------------------------*/
/* #2 : JFF le 04/09/2002														  */
/*------------------------------------------------------------------*/
bAff = ProfileString ( stGlb.sFichierIni, "BOUTONS RACCOURCIS", "BoutonRac", "" ) = "O"
pb_Consult.Visible 	= stGlb.bConsult
pb_Edition.Visible 	= stGlb.bEdtSin

pb_Tel.Visible 	= bAff And stGlb.bCreationTrv
pb_WorkFlow.Visible 	= bAff And stGlb.bCreationTrv
pb_Saisie.Visible 	= bAff And stGlb.bSaisieSin
pb_Validation.Visible= bAff And stGlb.bValSin

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

		If IsValid ( w_ae_sp_edit_sinistre_wkf_2000 ) Then 
			w_ae_sp_edit_sinistre_wkf_2000.Show()
		Else
			OpenSheetWithParm ( w_ae_sp_edit_sinistre_wkf_2000 , stGLB, W_Mdi_Sp, 0, Layered! )
		End If

		w_ae_sp_edit_sinistre_wkf_2000.BringToTop = True
		w_ae_sp_edit_sinistre_wkf_2000.TriggerEvent ("ue_Saisie_Automatique")

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

event ue_creer;call super::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Cree_Travail
//* Evenement 		: Ue_Creer (EXTEND)
//* Auteur			: Erick John Stark
//* Date				: 06/07/1998 10:27:57
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cr$$HEX1$$e900$$ENDHEX$$ation d'un enregistrement
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

istPass.sTab [2] = "WORKFLOW_EN_SAISIE"

F_OuvreTraitement ( W_T_Sp_Cree_Travail, istPass )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on timer;call w_8_accueil::timer;//*-----------------------------------------------------------------
//*
//* Objet			: Fen$$HEX1$$ea00$$ENDHEX$$tre
//* Evenement 		: Timer
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Overture de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement de sinistre
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

Timer (0)
This.TriggerEvent ( "ue_creer" )

end on

event ue_preparer_interro;call super::ue_preparer_interro;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Cree_Travail
//* Evenement 		: Ue_Preparer_Interro (EXTEND)
//* Auteur			: Erick John Stark
//* Date				: 06/07/1998 10:35:41
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialise la DDDW des corbeilles.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild 	dwIdCorb		// DDDW des corbeilles

W_Interro.dw_1.GetChild ( "ID_CORB", dwIdCorb )
dw_2.Sharedata          ( dwIdCorb )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on w_a_sp_cree_travail.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.pb_saisie=create pb_saisie
this.pb_consult=create pb_consult
this.pb_tel=create pb_tel
this.pb_workflow=create pb_workflow
this.pb_edition=create pb_edition
this.pb_validation=create pb_validation
this.sle_1=create sle_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.pb_saisie
this.Control[iCurrent+3]=this.pb_consult
this.Control[iCurrent+4]=this.pb_tel
this.Control[iCurrent+5]=this.pb_workflow
this.Control[iCurrent+6]=this.pb_edition
this.Control[iCurrent+7]=this.pb_validation
this.Control[iCurrent+8]=this.sle_1
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.cb_2
end on

on w_a_sp_cree_travail.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.pb_saisie)
destroy(this.pb_consult)
destroy(this.pb_tel)
destroy(this.pb_workflow)
destroy(this.pb_edition)
destroy(this.pb_validation)
destroy(this.sle_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

type cb_debug from w_8_accueil`cb_debug within w_a_sp_cree_travail
end type

type pb_retour from w_8_accueil`pb_retour within w_a_sp_cree_travail
integer width = 242
integer height = 144
integer taborder = 100
end type

type pb_interro from w_8_accueil`pb_interro within w_a_sp_cree_travail
integer width = 242
integer height = 144
integer taborder = 120
end type

type pb_creer from w_8_accueil`pb_creer within w_a_sp_cree_travail
integer width = 242
integer height = 144
integer taborder = 110
end type

on pb_creer::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: pb_Creer (OverRide !!)
//* Evenement 		: Ue_Creer (EXTEND)
//* Auteur			: Fabry JF
//* Date				: 15/05/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cr$$HEX1$$e900$$ENDHEX$$ation d'un enregistrement
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

istPass.sTab [3] = "TOUT"

Call Super::Clicked 
end on

type dw_1 from w_8_accueil`dw_1 within w_a_sp_cree_travail
integer taborder = 40
end type

event dw_1::ue_modifiermenu;call super::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet			:	w_8_accueil::dw_1
//* Evenement 		:	Ue_ModifierMenu
//* Auteur			:	YP
//* Date				:	01/10/1997 11:25:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Le choix 'Modifier' est inactif puisqu'on ne peut que cr$$HEX1$$e900$$ENDHEX$$er des travaux.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

uf_Mnu_InterdirItem ( 2 )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event dw_1::rbuttondown;//Migration PB8-WYNIWYG-03/2006 OR
//ce code remplace le code de l'anc$$HEX1$$ea00$$ENDHEX$$tre, 
//il permet la s$$HEX1$$e900$$ENDHEX$$lection de la ligne sur le click droit

If Row > 0 Then
	This.SetRow(Row)
	SelectRow(Row, True)
end if

call super::rButtonDown

Return AncestorReturnValue

//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

type pb_tri from w_8_accueil`pb_tri within w_a_sp_cree_travail
integer width = 242
integer height = 144
integer taborder = 130
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_sp_cree_travail
end type

type dw_2 from datawindow within w_a_sp_cree_travail
boolean visible = false
integer x = 3200
integer y = 40
integer width = 261
integer height = 108
integer taborder = 30
boolean bringtotop = true
string dataobject = "dddw_spb_code"
boolean livescroll = true
end type

type pb_saisie from picturebutton within w_a_sp_cree_travail
integer x = 1614
integer y = 16
integer width = 242
integer height = 144
integer taborder = 90
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

type pb_consult from picturebutton within w_a_sp_cree_travail
integer x = 1856
integer y = 16
integer width = 242
integer height = 144
integer taborder = 80
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

type pb_tel from picturebutton within w_a_sp_cree_travail
integer x = 1129
integer y = 16
integer width = 242
integer height = 144
integer taborder = 70
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

type pb_workflow from picturebutton within w_a_sp_cree_travail
integer x = 1371
integer y = 16
integer width = 242
integer height = 144
integer taborder = 20
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

type pb_edition from picturebutton within w_a_sp_cree_travail
integer x = 2098
integer y = 16
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

type pb_validation from picturebutton within w_a_sp_cree_travail
integer x = 2341
integer y = 16
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

isBoutonRac = "VALSIN"
Parent.TriggerEvent ( "ue_Item6" )

end on

type sle_1 from singlelineedit within w_a_sp_cree_travail
integer x = 672
integer y = 164
integer width = 1312
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;long lCle
boolean bEval
if len(this.text)>0 Then
	bEval = F_cle_Iban (this.text, lCle)
	lCle = 0 
	bEval = False
	bEval = F_Iban (this.text, lCle)
End If
end event

type cb_1 from commandbutton within w_a_sp_cree_travail
integer x = 2039
integer y = 164
integer width = 402
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;n_cst_attrib_rdv lnvRDv

lnvRDV = create n_cst_attrib_rdv

//lnvRDV.dtDteHeuRef 					= datetime(2008-10-14, 17:20:00)
//lnvRDV.iNbreRdvADemander			= 2
//lnvRDV.iAjoutNbHeuPremierRDV		= 24
//lnvRDV.tHeuMiniRdv					= 08:00:00
//lnvRDV.tHeuMaxiRdv					= 18:00:00
//lnvRDV.iIncrRdvMinute				= 60
//lnvRDV.iIncrRdvDate					= 1
//lnvRDV.iNbMinuteParPlageHoraire	= 120
//lnvRDV.iNbreJourCalendaireMax		= 7
//lnvRDV.iRdvAutoriseMemeJournee	= 2
//lnvRDV.bJourOuvrable					= FALSE
//lnvRDV.bJFerie							= FALSE
//lnvRDV.bDimanche						= TRUE
//lnvRDV.bAnnulerautorise				= TRUE
//lnvRDV.sMsg				= "Ceci est une information."

//lnvRDV.dtDteHeuRef 					= datetime(Today (), 09:12:12)
//lnvRDV.iNbreRdvADemander			= 1
//lnvRDV.iAjoutNbHeuPremierRDV		= 48
//lnvRDV.tHeuMiniRdv					= 08:00:00
//lnvRDV.tHeuMaxiRdv					= 18:00:00
//lnvRDV.iIncrRdvMinute				= 360
//lnvRDV.iIncrRdvDate					= 1
//lnvRDV.iNbMinuteParPlageHoraire	= 240
//lnvRDV.iNbreJourCalendaireMax		= 30
//lnvRDV.iRdvAutoriseMemeJournee	= 1
//lnvRDV.bJourOuvrable					= TRUE
//lnvRDV.tJourOuvrableMaxRdvSamedi	= 13:00:00
//lnvRDV.bJFerie							= FALSE
//lnvRDV.bDimanche						= FALSE
//lnvRDV.bAnnulerautorise				= FALSE
//lnvRDV.sMsg								= "Veuillez prendre " + String ( lnvRDV.iNbreRdvADemander ) + " rendez-vous avec l'assur$$HEX1$$e900$$ENDHEX$$. Attention ! Un rendez-vous par journ$$HEX1$$e900$$ENDHEX$$e."
//
/*
lnvRDV.dtDteHeuRef 			= datetime(2009-11-25, 09:12:12)
lnvRDV.iNbreRdvADemander		= 1
lnvRDV.iAjoutNbHeuPremierRDV	= 48
lnvRDV.sMsg				= "Veuillez prendre " + String ( lnvRDV.iNbreRdvADemander ) + " rendez-vous avec l'assur$$HEX1$$e900$$ENDHEX$$. Attention ! Un rendez-vous par journ$$HEX1$$e900$$ENDHEX$$e."
lnvRDV.bAnnulerautorise		= FALSE
lnvRDV.bJFerie				= FALSE
lnvRDV.iRdvAutoriseMemeJournee	= 1
lnvRDV.iNbreJourCalendaireMax	= 60
lnvRDV.bGenerationForcee		= TRUE
lnvRDV.sTbDefinitionGenForcee [1]       = "08:00-13:00;14:00-18:00" // Lundi
lnvRDV.sTbDefinitionGenForcee [2]       = "08:00-13:00;14:00-18:00" // Mardi
lnvRDV.sTbDefinitionGenForcee [3]       = "08:00-13:00;14:00-18:00" // Mercredi
lnvRDV.sTbDefinitionGenForcee [4]       = "08:00-13:00;14:00-18:00" // Jeudi
lnvRDV.sTbDefinitionGenForcee [5]       = "08:00-13:00;14:00-18:00" // Vendredi
lnvRDV.sTbDefinitionGenForcee [6]       = "08:00-13:00" // Samedi
lnvRDV.sTbDefinitionGenForcee [7]       = "" //Dimanche

lnvRDV.tHeuMiniRdv			= 14:00:00
lnvRDV.tHeuMaxiRdv			= 18:00:00
lnvRDV.iIncrRdvMinute		= 10000
lnvRDV.iIncrRdvDate			= 1
lnvRDV.iNbMinuteParPlageHoraire	= 240
lnvRDV.bJourOuvrable			= TRUE
lnvRDV.tJourOuvrableMaxRdvSamedi	= 13:00:00
lnvRDV.bDimanche			= FALSE
*/

lnvRDV.dtDteHeuRef 					= datetime(Today (), Now ())																
lnvRDV.iNbreRdvADemander			= 1
lnvRDV.iAjoutNbHeuPremierRDV		= 48
lnvRDV.iIncrRdvDate					= 1
lnvRDV.iNbreJourCalendaireMax		= 60
lnvRDV.iRdvAutoriseMemeJournee	= 1
lnvRDV.bJFerie							= FALSE
lnvRDV.bDimanche						= FALSE
lnvRDV.bAnnulerautorise				= FALSE
lnvRDV.sMsg								= "Veuillez prendre " + String ( lnvRDV.iNbreRdvADemander ) + " rendez-vous avec l'assur$$HEX1$$e900$$ENDHEX$$."

lnvRDV.tHeuMiniRdv			= 14:00:00
lnvRDV.tHeuMaxiRdv			= 18:00:00
lnvRDV.iIncrRdvMinute		= 10000

lnvRDV.iNbMinuteParPlageHoraire	= 240
lnvRDV.bJourOuvrable			= TRUE
lnvRDV.tJourOuvrableMaxRdvSamedi	= 13:00:00

lnvRDV.bGenerationForcee		= TRUE
lnvRDV.sTbDefinitionGenForcee [1]       = "08:00-13:00;14:00-18:00" // Lundi
lnvRDV.sTbDefinitionGenForcee [2]       = "08:00-13:00;14:00-18:00" // Mardi
lnvRDV.sTbDefinitionGenForcee [3]       = "08:00-13:00;14:00-18:00" // Mercredi
lnvRDV.sTbDefinitionGenForcee [4]       = "08:00-13:00;14:00-18:00" // Jeudi
lnvRDV.sTbDefinitionGenForcee [5]       = "08:00-13:00;14:00-18:00" // Vendredi
lnvRDV.sTbDefinitionGenForcee [6]       = "08:00-13:00" // Samedi
lnvRDV.sTbDefinitionGenForcee [7]       = "" //Dimanche

OpenWithParm(w_trt_choix_rdv, lnvRDV)
lnvRDV = message.PowerObjectParm
messagebox("DEBUG", lnvRDV.uf_getrdv( ))

destroy lnvRDV
/*
n_cst_attrib_rdc	nvrdc
datawindowchild dwMarque

nvrdc = CREATE n_cst_attrib_rdc

nvrdc.ibaltforcagepec = FALSE
nvrdc.idcmtpec = 125.00
//nvrdc.idwmarques = dwMarque

OpenWithParm ( w_sp_trt_saisie_rdc, nvrdc ) 
nvrdc = Message.PowerObjectParm

messagebox("toto",nvrdc.uf_getsaisie( ))
//destroy dwMarque

*/

//Open ( w_sp_trt_saisie_dept)
//messagebox("toto",Message.StringParm)



end event

type cb_2 from commandbutton within w_a_sp_cree_travail
integer x = 201
integer y = 164
integer width = 402
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "SQL CP"
end type

event clicked;

OpenSheet ( w_t_cpsql, W_Mdi_Sp) 
end event

