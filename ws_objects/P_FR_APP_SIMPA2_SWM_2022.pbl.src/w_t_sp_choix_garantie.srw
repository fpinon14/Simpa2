HA$PBExportHeader$w_t_sp_choix_garantie.srw
$PBExportComments$-} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour le choix d'une garantie.
forward
global type w_t_sp_choix_garantie from w_ancetre
end type
type pb_valider from u_8_pbvalider within w_t_sp_choix_garantie
end type
type pb_retour from u_8_pbretour within w_t_sp_choix_garantie
end type
type dw_choixgti from datawindow within w_t_sp_choix_garantie
end type
end forward

global type w_t_sp_choix_garantie from w_ancetre
boolean visible = true
integer x = 919
integer y = 388
integer width = 1367
integer height = 924
pb_valider pb_valider
pb_retour pb_retour
dw_choixgti dw_choixgti
end type
global w_t_sp_choix_garantie w_t_sp_choix_garantie

type variables
Private :
	w_Ancetre_Traitement	iwParentDet

	Long			ilRetour
end variables

event ue_retour;call super::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Choix_Garantie::Ue_Retour
//* Evenement 		: Ue_Retour
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 10:02:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On referme la fen$$HEX1$$ea00$$ENDHEX$$tre.                                           */
/*------------------------------------------------------------------*/
//dw_ChoixGti.ShareDataOff ()

/*------------------------------------------------------------------*/
/* On rend la fen$$HEX1$$ea00$$ENDHEX$$tre PARENT saisissable.                           */
/*------------------------------------------------------------------*/
iwParentDet.Enabled = True

/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$clenche le script de la fen$$HEX1$$ea00$$ENDHEX$$tre parent. On lui passe en     */
/* param$$HEX1$$e800$$ENDHEX$$tre la valeur ilRetour.                                    */
/*------------------------------------------------------------------*/
iwParentDet.TriggerEvent ( "Ue_Choix_Garantie", 0, ilRetour )

/*------------------------------------------------------------------*/
/* On referme la fen$$HEX1$$ea00$$ENDHEX$$tre.                                           */
/*------------------------------------------------------------------*/
Close ( This )


end event

on ue_initialiser;call w_ancetre::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Choix_Garantie::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 09:55:15
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne la variable qui permet d'attaquer la DW de la      */
/* fen$$HEX1$$ea00$$ENDHEX$$tre PARENT.                                                  */
/*------------------------------------------------------------------*/
iwParentDet = istPass.wParent

/*------------------------------------------------------------------*/
/* On rend la fen$$HEX1$$ea00$$ENDHEX$$tre PARENT non saisissable.                       */
/*------------------------------------------------------------------*/
iwParentDet.Enabled = False

/*------------------------------------------------------------------*/
/* On positionne la variable qui permet d'attaquer la DW de la      */
/* fen$$HEX1$$ea00$$ENDHEX$$tre PARENT.                                                  */
/*------------------------------------------------------------------*/
istPass.dwNorm[1].ShareData ( dw_ChoixGti )

/*------------------------------------------------------------------*/
/* On s$$HEX1$$e900$$ENDHEX$$lectionne la 1$$HEX1$$e900$$ENDHEX$$re ligne de la DW par d$$HEX1$$e900$$ENDHEX$$faut.                */
/*------------------------------------------------------------------*/
dw_ChoixGti.SelectRow ( 1, True )

/*------------------------------------------------------------------*/
/* Par d$$HEX1$$e900$$ENDHEX$$faut, on initialise la valeur de retour $$HEX2$$e0002000$$ENDHEX$$-1, donc pas de  */
/* garantie choisie.                                                */
/* Cette valeur est positionn$$HEX1$$e900$$ENDHEX$$e uniquement sur Ue_Valider.          */
/*------------------------------------------------------------------*/
ilRetour = -1






end on

on ue_valider;call w_ancetre::ue_valider;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Banque::Ue_Valider
//* Evenement 		: Ue_Valider
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 10:02:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lLig

lLig = dw_ChoixGti.GetSelectedRow ( 0 )

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$clenche l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement Ue_Retour, uniquement si la ligne de    */
/* dw_ChoixGti est valide.                                          */
/*------------------------------------------------------------------*/
	ilRetour	= dw_ChoixGti.GetItemNumber ( lLig, "ID_GTI" )

	This.TriggerEvent ( "Ue_Retour" )
End If
end on

on open;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Choix_Garantie::Open
//* Evenement 		: Open
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 09:49:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

istPass = Message.PowerObjectParm

This.PostEvent ( "Ue_Initialiser" )


end on

on w_t_sp_choix_garantie.create
int iCurrent
call super::create
this.pb_valider=create pb_valider
this.pb_retour=create pb_retour
this.dw_choixgti=create dw_choixgti
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_valider
this.Control[iCurrent+2]=this.pb_retour
this.Control[iCurrent+3]=this.dw_choixgti
end on

on w_t_sp_choix_garantie.destroy
call super::destroy
destroy(this.pb_valider)
destroy(this.pb_retour)
destroy(this.dw_choixgti)
end on

type cb_debug from w_ancetre`cb_debug within w_t_sp_choix_garantie
end type

type pb_valider from u_8_pbvalider within w_t_sp_choix_garantie
integer x = 718
integer y = 760
integer width = 242
integer height = 144
integer taborder = 30
integer textsize = -7
string facename = "Arial"
string text = "&Prendre"
boolean default = true
end type

type pb_retour from u_8_pbretour within w_t_sp_choix_garantie
integer x = 471
integer y = 760
integer width = 242
integer height = 144
integer taborder = 20
boolean cancel = true
end type

type dw_choixgti from datawindow within w_t_sp_choix_garantie
integer x = 32
integer y = 32
integer width = 1275
integer height = 696
integer taborder = 10
string dataobject = "d_sp_sin_code_garantie"
boolean vscrollbar = true
borderstyle borderstyle = styleshadowbox!
end type

on doubleclicked;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_ChoixGti::DoubleClicked! (OVERRIDE)
//* Evenement 		: DoubleClicked!
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 11:36:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.TriggerEvent ( "Ue_Valider" )

end on

on rowfocuschanged;//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_ChoixGti::RowFocusChanged!
//* Evenement 		: RowFocusChanged
//* Auteur			: Erick John Stark
//* Date				: 27/01/1998 16:27:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lLigne

lLigne	=	This.GetRow ( )

If	lLigne > 0 Then

	This.SelectRow ( 0, False )
	This.ScrollToRow ( lLigne )
	This.SetRow ( lLigne )
	This.SelectRow ( lLigne, True )

End If
end on

