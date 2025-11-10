HA$PBExportHeader$w_t_sp_message.srw
$PBExportComments$-} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour la saisie des zones messages.
forward
global type w_t_sp_message from w_ancetre
end type
type pb_valider from u_8_pbvalider within w_t_sp_message
end type
type pb_retour from u_8_pbretour within w_t_sp_message
end type
type dw_1 from datawindow within w_t_sp_message
end type
end forward

global type w_t_sp_message from w_ancetre
boolean visible = true
integer x = 247
integer y = 148
integer width = 3022
integer height = 1320
boolean titlebar = true
pb_valider pb_valider
pb_retour pb_retour
dw_1 dw_1
end type
global w_t_sp_message w_t_sp_message

type variables
Private :
	String				isTypeTrt
	w_Ancetre_Traitement		iwParentMaster


end variables

on ue_retour;call w_ancetre::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Message::Ue_Retour
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
/* On rend la fen$$HEX1$$ea00$$ENDHEX$$tre PARENT saisissable.                           */
/*------------------------------------------------------------------*/
iwParentMaster.Enabled = True

/*------------------------------------------------------------------*/
/* On referme la fen$$HEX1$$ea00$$ENDHEX$$tre.                                           */
/*------------------------------------------------------------------*/
Close ( This )
end on

on ue_initialiser;call w_ancetre::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Message::Ue_Initialiser
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

String sTitre

/*------------------------------------------------------------------*/
/* On ins$$HEX1$$e900$$ENDHEX$$re une ligne dans la DW dw_1 pour permettre la saisie.    */
/*------------------------------------------------------------------*/
dw_1.InsertRow ( 0 )
dw_1.SetItem ( 1, "TXT_MESS", istPass.sTab[3] )

/*------------------------------------------------------------------*/
/* On positionne le titre de la fen$$HEX1$$ea00$$ENDHEX$$tre.                            */
/*------------------------------------------------------------------*/
This.Title = istPass.sTab[1]

/*------------------------------------------------------------------*/
/* Si on est en (C)onsultation/(V)alidation, on rend le bouton      */
/* Valider invisible.                                               */
/*------------------------------------------------------------------*/
If	istPass.sTab[2] = "C" Then
	pb_Valider.Visible = False
	pb_Valider.Enabled = False
End If

/*------------------------------------------------------------------*/
/* On positionne la variable qui permet d'attaquer la DW de la      */
/* fen$$HEX1$$ea00$$ENDHEX$$tre PARENT.                                                  */
/*------------------------------------------------------------------*/
iwParentMaster = istPass.wParent

/*------------------------------------------------------------------*/
/* On rend la fen$$HEX1$$ea00$$ENDHEX$$tre PARENT non saisissable.                       */
/*------------------------------------------------------------------*/
iwParentMaster.Enabled = False

/*------------------------------------------------------------------*/
/* On positionne un titre pour expliquer si on est dans le          */
/* sinistre ou dans une garantie.                                   */
/*------------------------------------------------------------------*/
If	istPass.sTab[4] = "S"	Then
	sTitre = "Message pour le sinistre"
Else
	sTitre = "Garantie : " + istPass.sTab[5]
End If

dw_1.Modify ( 'st_titre.Text="' + sTitre + '"' )
end on

on we_childactivate;call w_ancetre::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Message::We_ChildActivate
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

This.X			=  247
This.Y			=  149
This.Height		= 1321
This.Width		= 3022
end on

on ue_valider;call w_ancetre::ue_valider;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Message::Ue_Valider
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

String sMess

If	dw_1.AcceptText () > 0 Then
	sMess = Trim ( dw_1.GetItemString ( 1, "TXT_MESS" ) )
	If	sMess = "" Then sMess = stNul.str

	iwParentMaster.dw_1.SetItem ( 1, "TXT_MESS", sMess )

	This.TriggerEvent ( "Ue_Retour" )
End If 

end on

on open;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Message::Open
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

on w_t_sp_message.create
int iCurrent
call super::create
this.pb_valider=create pb_valider
this.pb_retour=create pb_retour
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_valider
this.Control[iCurrent+2]=this.pb_retour
this.Control[iCurrent+3]=this.dw_1
end on

on w_t_sp_message.destroy
call super::destroy
destroy(this.pb_valider)
destroy(this.pb_retour)
destroy(this.dw_1)
end on

type pb_valider from u_8_pbvalider within w_t_sp_message
integer x = 325
integer y = 56
integer width = 233
integer height = 136
integer taborder = 30
end type

type pb_retour from u_8_pbretour within w_t_sp_message
integer x = 78
integer y = 56
integer width = 233
integer height = 136
integer taborder = 20
boolean cancel = true
end type

type dw_1 from datawindow within w_t_sp_message
integer x = 375
integer y = 268
integer width = 2299
integer height = 812
integer taborder = 10
string dataobject = "d_sp_sin_message"
boolean border = false
end type

event itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Messaga::dw_1
//* Evenement 		: ItemError
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:47:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion des messages d'erreur
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

stMessage.sTitre		= "Gestion des messages - SIMPA2"
stMessage.Icon			= Information!

stMessage.bErreurG	= TRUE

stMessage.sVar[1] = "message"
stMessage.sCode	= "GENE003"

F_Message ( stMessage )


//Migration PB8-WYNIWYG-03/2006 CP
//This.SetActionCode ( 1 )
Return 1
//Fin Migration PB8-WYNIWYG-03/2006 CP



end event

