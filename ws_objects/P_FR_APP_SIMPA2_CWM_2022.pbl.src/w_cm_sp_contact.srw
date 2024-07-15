HA$PBExportHeader$w_cm_sp_contact.srw
$PBExportComments$Fen$$HEX1$$ea00$$ENDHEX$$tre cons perm des contacts
forward
global type w_cm_sp_contact from w_8_ancetre_consultation
end type
type dw_1 from u_datawindow within w_cm_sp_contact
end type
type pb_controler from u_pbcontroler within w_cm_sp_contact
end type
type pb_valider from u_pbvalider within w_cm_sp_contact
end type
type pb_supprimer from u_pbsupprimer within w_cm_sp_contact
end type
type dw_a_traiter_par from u_datawindow within w_cm_sp_contact
end type
end forward

global type w_cm_sp_contact from w_8_ancetre_consultation
integer x = 1075
integer y = 481
integer height = 1637
boolean controlmenu = false
boolean minbox = false
dw_1 dw_1
pb_controler pb_controler
pb_valider pb_valider
pb_supprimer pb_supprimer
dw_a_traiter_par dw_a_traiter_par
end type
global w_cm_sp_contact w_cm_sp_contact

type variables
Private :

u_gs_sp_sinistre_Contact	iuoCpSpContact
String			isTypeTrt
String			isMajAccueil
end variables

forward prototypes
public subroutine wf_positionnerobjets ()
public function boolean wf_preparerinserer ()
public function boolean wf_preparersupprimer ()
public function string wf_controlersaisie ()
public function string wf_controlergestion ()
public function boolean Wf_PreparerModifier ()
public function boolean wf_controler ()
end prototypes

public subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Cm_Sp_Contact::Wf_PositionnerObjets (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 24/04/2001 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On positionne et on taille tous les objets
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Dw_1																				  */
/*------------------------------------------------------------------*/
Dw_1.X			=  691
Dw_1.Y			=  397
Dw_1.Width		= 2959
Dw_1.Height		=  945

dw_a_traiter_par.X			=  2369
dw_a_traiter_par.Y			=  41
dw_a_traiter_par.Width		= 1203
dw_a_traiter_par.Height		=  113


end subroutine

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_W_Contact::Wf_PreparerInserer
//* Auteur			: Fabry JF
//* Date				: 25/04/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Op$$HEX1$$e900$$ENDHEX$$ration avant insertion
//*
//* Arguments		: Rien
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On arme le titre de la fen$$HEX1$$ea00$$ENDHEX$$tre avec le titre de la fen$$HEX1$$ea00$$ENDHEX$$tre       */
/* Parent.                                                          */
/*------------------------------------------------------------------*/
This.Title = istPass.sTab [ 1 ]

iuoCpSpContact.Uf_PreparerInserer ( istPass )

Return True
end function

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_PreparerSupprimer
//* Auteur			: Fabry JF
//* Date				: 27/04/01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Demande de confirmation avant suppression
//* Commentaires	: Aucun
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean			TRUE = La suppression peut continuer
//*
//*-----------------------------------------------------------------

Return ( iuoCpSpContact.uf_PreparerSupprimer () )
end function

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_ControlerSaisie
//* Auteur			: Fabry JF
//* Date				: 26/04/2001 13:59:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de saisie des zones
//*					  
//* Commentaires	: Aucun
//*
//* Arguments		: Aucun
//*
//* Retourne		: String		"" -> On passe au controle de gestion
//*											Nom de colonne en erreur
//*
//*-----------------------------------------------------------------

Return ( iuoCpSpContact.uf_ControlerSaisie () )

end function

public function string wf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_ControlerGestion
//* Auteur			: Fabry JF
//* Date				: 26/04/2001 13:59:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de gestion
//*					  
//* Commentaires	: Aucun
//*
//* Arguments		: Aucun
//*
//* Retourne		: String		"" -> On passe au controle de gestion
//*											Nom de colonne en erreur
//*
//*-----------------------------------------------------------------

Return ( iuoCpSpContact.uf_ControlerGestion () )
end function

public function boolean Wf_PreparerModifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Cm_Sp_Contact::Wf_PreparerModifier
//* Auteur			: Fabry JF
//* Date				: 25/04/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Op$$HEX1$$e900$$ENDHEX$$ration avant modification
//*
//* Arguments		: Rien
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On arme le titre de la fen$$HEX1$$ea00$$ENDHEX$$tre avec le titre de la fen$$HEX1$$ea00$$ENDHEX$$tre       */
/* Parent.                                                          */
/*------------------------------------------------------------------*/
This.Title = istPass.sTab [ 1 ]

iuoCpSpContact.Uf_PreparerModifier ( istPass )

Return True
end function

public function boolean wf_controler ();//*******************************************************************************************
// Fonction            	: w_Traitement::wf_Controler
//	Auteur              	: D.Bizien
//	Date 					 	: 11/03/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Proc$$HEX1$$e900$$ENDHEX$$dure centrale de controle 
// Commentaires			: Elle appelle les fonctions de controles de saisie et de controle de gestion
// Arguments				: Aucun
//
// Retourne					: Bool$$HEX1$$e900$$ENDHEX$$en - Vrai si tout Ok
//								  
//*******************************************************************************************

Boolean		bRet = True		// Retour de la fonction
String		sCol				// Colonne sur laquelle on doit repositionner le focus si erreur

// ---------- Controle de remplissage des zones obligatoires

sCol = wf_ControlerSaisie( )

If ( sCol <> "" ) Then

	//	----------	Gestion du bouton de contr$$HEX1$$f400$$ENDHEX$$le.

	pb_Controler.Enabled		=	True
	pb_Valider.Enabled		=	False
	
	//	----------	Aller sur la colonne en erreur

	Dw_1.SetRedraw ( False )
	Dw_1.SetFocus	( )
	Dw_1.SetColumn ( sCol )
	Dw_1.SetRedraw ( True )

	bRet = False

Else

	//	----------	Contr$$HEX1$$f400$$ENDHEX$$le de gestion et bouton de contr$$HEX1$$f400$$ENDHEX$$le.

	sCol	= wf_ControlerGestion ( )

	If ( sCol <> "" ) Then

		//	----------	Gestion du bouton de contr$$HEX1$$f400$$ENDHEX$$le.

		pb_Controler.Enabled		=	True
		pb_Valider.Enabled		=	False


		//	----------	Aller sur la colonne en erreur

		Dw_1.SetRedraw ( False )
		Dw_1.SetFocus	( )
		Dw_1.SetColumn ( sCol )
		Dw_1.SetRedraw ( True )

		bRet = False

	Else

		pb_Valider.Enabled		=	True
		pb_Controler.Enabled		=	False
		pb_Valider.SetFocus ()

		f_MajPar ( Dw_1, 1 )
		Dw_1.SetRedraw ( False )
		Pb_Valider.SetFocus ( )
		Dw_1.SetRedraw ( True )

	End If

End If


Return ( bRet )

end function

on ue_valider;call w_8_ancetre_consultation::ue_valider;//*****************************************************************************
//
// Objet 		: w_Traitement
// Evenement 	: ue_Valider
//	Auteur		: D.Bizien
//	Date			: 13/03/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Enregistrement des informations
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//	La Recrue	20/02/97	MOD-0017
// $$HEX2$$e0002000$$ENDHEX$$la fin du script execution d'un PostEvent pour la fermeture de la fen$$HEX1$$ea00$$ENDHEX$$tre
// apr$$HEX1$$e800$$ENDHEX$$s une validation.
//*****************************************************************************

Boolean bRet
String	sIdMsgSeq
Long		lRow, lTotLig, lCpt
DwItemStatus	lStatus

SetPointer( HourGlass! )

sIdMsgSeq = String ( Dw_1.GetItemNumber ( 1, "ID_MSG_SEQ" ) )

If Not istPass.bInsert Then
	lRow = istPass.dwTab [1].Find ( "ID_MSG_SEQ = " + sIdMsgSeq, 1, istPass.dwTab [1].RowCount () ) 
	If lRow > 0 Then istPass.dwTab [1].DeleteRow ( lRow )
End If

// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration des Initiales de la personne qui va traiter le dossier
// $$HEX2$$e0002000$$ENDHEX$$partir de la fen$$HEX1$$ea00$$ENDHEX$$tre de sinistre.
If iuoCpSpContact.uf_Valider () Then iwParent.TriggerEvent ("ue_Item5")

lTotLig = istPass.dwTab [1].RowCount ()
If lTotLig <= 0 Then lTotLig = 1
Dw_1.RowsCopy ( 1, 1, Primary!, istPass.dwTab [1], lTotLig, Primary! ) 

istPass.dwTab [ 1 ].Sort ()

lRow = istPass.dwTab [1].Find ( "ID_MSG_SEQ = " + sIdMsgSeq, 1, istPass.dwTab [1].RowCount () ) 

istPass.dwTab [1].SelectRow ( 0, False )

SetPointer( Arrow! )

This.PostEvent( "ue_retour" )


end on

on close;call w_8_ancetre_consultation::close;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Cm_Sp_Contact::Close
//* Evenement 		: Close
//* Auteur			: Fabry JF
//* Date				: 25/04/2001 18:46:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Destroy iUoCpSpContact
end on

on ue_supprimer;call w_8_ancetre_consultation::ue_supprimer;//*****************************************************************************
//
// Objet 		: w_Traitement
// Evenement 	: ue_Supprimer
//	Auteur		: D.Bizien
//	Date			: 18/03/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Suppression des informations
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//	La Recrue	20/02/97	MOD-0017
// $$HEX2$$e0002000$$ENDHEX$$la fin du script execution d'un PostEvent pour la fermeture de la fen$$HEX1$$ea00$$ENDHEX$$tre
// apr$$HEX1$$e800$$ENDHEX$$s une suppression.
//*****************************************************************************

Boolean bRet
String	sIdMsgSeq
Long		lRow

SetPointer( HourGlass! )

dw_1.SetRedraw ( False )

If wf_PreparerSupprimer () Then

	sIdMsgSeq = String ( Dw_1.GetItemNumber ( 1, "ID_MSG_SEQ" ) )
	
	lRow = istPass.dwTab [1].Find ( "ID_MSG_SEQ = " + sIdMsgSeq, 1, istPass.dwTab [1].RowCount () ) 
	If lRow > 0 Then istPass.dwTab [1].DeleteRow ( lRow )
	
	IF istPass.dwTab [1].RowCount () > 0 Then
		istPass.dwTab [1].SelectRow ( 0, False )
		istPass.dwTab [1].SelectRow ( 1, True )
		istPass.dwTab [1].SCrollToRow ( 1 ) 
		istPass.dwTab [1].SetRow ( 1 ) 
	End If
	
	This.PostEvent( "ue_retour" )

End If

dw_1.SetRedraw( True )

SetPointer( Arrow! )








end on

on ue_controler;call w_8_ancetre_consultation::ue_controler;//*****************************************************************************
//
// Objet 		: w_Traitement
// Evenement 	: ue_Controler
//	Auteur		: D.Bizien
//	Date			: 11/03/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Controle des informations de la fen$$HEX1$$ea00$$ENDHEX$$tre
// Commentaires: Le 07/04/1996 -> Erick John Stark 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//	
// EJS			07/04/1996 Ajout d'un AcceptText pour envoyer un ItemChanged()
//
//*****************************************************************************

If	dw_1.AcceptText () > 0 Then
	wf_Controler ()
Else
	dw_1.SetFocus ()
End If
end on

on we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Cm_Sp_Contact::We_ChildActivate (OVERRIDE )
//* Evenement 		: We_ChildActivate
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:53:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean					bOk

This.X			=    1
This.Y			=    1
This.Height		= 1769
This.Width		= 3598


If ( ibAInitialiser ) Then

	ibAInitialiser  = False

	istPass = Message.PowerObjectParm

	itrTrans						=  istPass.trTrans	// Objet transaction de la fenetre appelante
	iwParent						=	istPass.wParent	// Fenetre Appelante ( utilis$$HEX1$$e900$$ENDHEX$$e pour enable )	

	istPass.wParent			=	This					// Fenetre appelante pour fenetre de traitment
	istPass.trTrans			=	itrTrans				// Objet de transaction par defaut

	If ( ibOpen ) Then

		This.TriggerEvent ( "ue_Initialiser" )
		IbOpen = False

	End If

	If ( Not istPass.bEnableParent ) Then
		iwParent.TriggerEvent ( "ue_DisableFenetre" )
	End If

	// Initialisation des variables d'instance

	Dw_1.ibErreur 	= False
	Dw_1.isNomCol	= ""
	Dw_1.isErrCol	= ""

	// Positionnement des boutons Controle et valider

	If Not istPass.bControl Then

		// Directement bouton valider		
		pb_Controler.Enabled = False
		pb_Valider.Enabled = True
		pb_Controler.Hide ()
		pb_Valider.Show ()
		
	Else

		// Controle + Valide
		pb_controler.Enabled = True
		pb_Valider.Enabled = False
		pb_Valider.Show ()
		pb_Controler.Show ()

	End If

	// Preparation avant affichage

	If istPass.bInsert Then

		pb_Supprimer.Enabled = False
		Dw_1.Reset ()
		Dw_1.InsertRow ( 0 )
		f_CreeLe ( Dw_1, 1 )
		f_MajPar ( Dw_1, 1 )
		bOk = wf_PreparerInserer ()
	
	Else

		pb_Supprimer.Enabled = istPass.bSupprime
		bOk = wf_PreparerModifier ()

	End If

	// Arr$$HEX1$$ea00$$ENDHEX$$t d'ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre si probl$$HEX1$$e800$$ENDHEX$$me

	If Not bOk Then

		This.TriggerEvent ( "ue_retour" )
	Else
//		wf_Changer_Controle( Dw_1 )
//
//		If ( ibModeDetail ) Then
//
///*------------------------------------------------------------------*/
///* Uniquement pour que la datawindow puisse retrouver ses petits    */
///* lors d'un RowCopy. ( Bug Pb )                                    */
///*------------------------------------------------------------------*/
//
//			dw_1.SetSort(dw_1.isTri)
//			dw_1.Sort()
//
//		End If

		This.Show()
		Dw_1.SetFocus ()

	End If

End If

end on

on ue_initialiser;call w_8_ancetre_consultation::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Cm_Sp_Contact::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Fabry JF
//* Date				: 05/01/1998 17:59:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass	stPass

Wf_PositionnerObjets ()

//Wf_ActiverModeDetail ( True )
dw_1.Uf_DetailParent ( istPass.dwTab[ 1 ] )

/*------------------------------------------------------------------*/
/* Nous sommes en saisie (S) ou en Consultation/Validation (C)(V)   */
/*------------------------------------------------------------------*/
isTypeTrt = istPass.sTab[ 2 ]


/*------------------------------------------------------------------*/
/* On commence $$HEX2$$e0002000$$ENDHEX$$initialiser les NVUO.                              */
/*------------------------------------------------------------------*/
iuoCpSpContact = Create U_Gs_Sp_Sinistre_Contact

stPass.dwMaster  = Dw_1  // Trt Contact
stPass.dwTab [1] = istPass.dwTab [ 1 ]
stPass.dwTab [2] = istPass.dwTab [ 2 ]

stPass.udwTab [1] = istPass.udwTab [ 1 ]
stPass.udwTab [2] = dw_a_traiter_par

stPass.dwNorm [ 1 ]	= istPass.dwNorm [ 1 ]	
stPass.dwNorm [ 2 ]	= istPass.dwNorm [ 2 ]	

stPass.sTab [2]  = istPass.sTab [ 2 ]

iuoCpSpContact.uf_Initialiser ( 	stPass 			,&
										  	pb_Controler	,&
										  	pb_Supprimer	,&
										  	pb_Valider		,&
											iTrTrans			,&
											istPass.dwMaster &
									   )


end on

on w_cm_sp_contact.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.pb_controler=create pb_controler
this.pb_valider=create pb_valider
this.pb_supprimer=create pb_supprimer
this.dw_a_traiter_par=create dw_a_traiter_par
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.pb_controler
this.Control[iCurrent+3]=this.pb_valider
this.Control[iCurrent+4]=this.pb_supprimer
this.Control[iCurrent+5]=this.dw_a_traiter_par
end on

on w_cm_sp_contact.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.pb_controler)
destroy(this.pb_valider)
destroy(this.pb_supprimer)
destroy(this.dw_a_traiter_par)
end on

type st_titre from w_8_ancetre_consultation`st_titre within w_cm_sp_contact
boolean visible = false
end type

type pb_retour from w_8_ancetre_consultation`pb_retour within w_cm_sp_contact
integer x = 9
integer y = 8
integer taborder = 60
end type

type dw_1 from u_datawindow within w_cm_sp_contact
integer x = 27
integer y = 216
integer width = 622
integer height = 504
integer taborder = 50
string dataobject = "d_sp_sin_w_contact"
boolean border = false
end type

on itemchanged;call u_datawindow::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Cm_Cp_Contact::itemChanged
//* Evenement 		: itemChanged
//* Auteur			: Fabry JF
//* Date				: 05/01/1998 17:59:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iuoCpSpContact.uf_ControlerZone ( Upper ( This.isNomCol ) ) 

end on

on itemerror;call u_datawindow::itemerror;
//*-----------------------------------------------------------------
//*
//* Objet 			: W_Cm_Sp_Contact::itemError
//* Evenement 		: itemError
//* Auteur			: Fabry JF
//* Date				: 05/01/1998 17:59:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iuoCpSpContact.uf_GererMessage ( Upper ( This.isErrCol ) )
end on

type pb_controler from u_pbcontroler within w_cm_sp_contact
integer x = 251
integer y = 8
integer width = 233
integer height = 136
integer taborder = 40
integer textsize = -7
string facename = "Arial"
string picturename = "k:\pb4obj\bmp\8_ctl.bmp"
end type

type pb_valider from u_pbvalider within w_cm_sp_contact
integer x = 494
integer y = 8
integer width = 233
integer height = 136
integer taborder = 30
integer textsize = -7
string facename = "Arial"
string picturename = "k:\pb4obj\bmp\8_valid.bmp"
end type

on losefocus;call u_pbvalider::losefocus;
pb_Controler.Enabled		=	True
pb_Valider.Enabled		=	False
end on

type pb_supprimer from u_pbsupprimer within w_cm_sp_contact
integer x = 736
integer y = 8
integer width = 233
integer height = 136
integer taborder = 20
integer textsize = -7
string facename = "Arial"
string picturename = "k:\pb4obj\bmp\8_annu.bmp"
end type

type dw_a_traiter_par from u_datawindow within w_cm_sp_contact
integer x = 727
integer y = 216
integer width = 576
integer taborder = 10
string dataobject = "dddw_sp_wkf_dosuivipar"
boolean border = false
boolean livescroll = false
end type

on constructor;call u_datawindow::constructor;ilPremCol = 0
ilDernCol = 0

end on

event itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Fonction		: ItemChanged
//* Auteur			: Fabry JF
//* Date				: 05/01/1998 18:25:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Rien
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

DataWindowChild dwChild
String	sData

sData = Upper ( This.GetText () )
This.GetChild ( "DOS_SUIVI_PAR", dwChild ) 

If dwChild.Find ( "COD_OPER = '" + sData + "'", 1, dwChild.Rowcount () ) <= 0 And Not IsNull ( sData ) Then
//Migration PB8-WYNIWYG-03/2006 FM
//	SetActionCode ( 1 )
	ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
End If

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Fonction		: ItemError
//* Auteur			: Fabry JF
//* Date				: 05/01/1998 18:25:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Rien
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------


stMessage.sTitre		= "Dossier $$HEX2$$e0002000$$ENDHEX$$traiter par"
stMessage.Icon			= Information!
stMessage.sCode		= "CONT019"
stMessage.bErreurG	= False

f_Message ( stMessage )
//Migration PB8-WYNIWYG-03/2006 FM
//SetActionCode ( 1 )
Return 1
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

