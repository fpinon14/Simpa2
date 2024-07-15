HA$PBExportHeader$w_t_sp_saisie_libevt.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre de saisie des libell$$HEX1$$e900$$ENDHEX$$s par d$$HEX1$$e900$$ENDHEX$$faut des $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nements
forward
global type w_t_sp_saisie_libevt from w_ancetre
end type
type pb_1 from u_8_pbretour within w_t_sp_saisie_libevt
end type
type pb_2 from u_8_pbvalider within w_t_sp_saisie_libevt
end type
type dw_1 from u_datawindow within w_t_sp_saisie_libevt
end type
end forward

global type w_t_sp_saisie_libevt from w_ancetre
boolean visible = true
integer width = 1925
integer height = 420
boolean titlebar = true
string title = "Libell$$HEX2$$e9002000$$ENDHEX$$par d$$HEX1$$e900$$ENDHEX$$faut"
windowtype windowtype = response!
pb_1 pb_1
pb_2 pb_2
dw_1 dw_1
end type
global w_t_sp_saisie_libevt w_t_sp_saisie_libevt

on ue_valider;call w_ancetre::ue_valider;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_saisie_libevt
//* Evenement 		: ue_Valider
//* Auteur			: DBI
//* Date				: 03/03/1998 17:47:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Click sur bouton Valider
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass	stPass

stPass.sTab[1]	=	Dw_1.GetItemString ( 1, "LIB_EVT" )
stPass.sTab[2]	=	"ue_valider"

CloseWithReturn ( This, stPass )

end on

on w_t_sp_saisie_libevt.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_1
end on

on w_t_sp_saisie_libevt.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_1)
end on

on open;call w_ancetre::open;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_saisie_libevt
//* Evenement 		: Open
//* Auteur			: DBI
//* Date				: 03/03/1998 17:28:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Chargement de la Dw avec la valeur actuelle du libell$$HEX1$$e900$$ENDHEX$$
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass	stPass

stPass	=	Message.PowerObjectParm

Dw_1.InsertRow ( 0 )

Dw_1.SetItem ( 1, "LIB_EVT", stPass.sTab[1] )

end on

on ue_retour;call w_ancetre::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_saisie_libevt
//* Evenement 		: ue_retour
//* Auteur			: DBI
//* Date				: 03/03/1998 17:47:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Click sur bouton retour
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass	stPass

stPass.sTab[2]	=	"ue_retour"

CloseWithReturn ( This, stPass )

end on

type pb_1 from u_8_pbretour within w_t_sp_saisie_libevt
integer x = 23
integer y = 20
integer width = 233
integer height = 136
integer taborder = 20
end type

type pb_2 from u_8_pbvalider within w_t_sp_saisie_libevt
integer x = 265
integer y = 20
integer width = 233
integer height = 136
integer taborder = 30
end type

type dw_1 from u_datawindow within w_t_sp_saisie_libevt
integer x = 55
integer y = 192
integer width = 1819
integer height = 136
integer taborder = 10
string dataobject = "d_sp_prod_libvevt"
boolean border = false
end type

event itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			:	Dw_1
//* Evenement 		:	ITEMERROR - Extend 
//* Auteur			:	DBI
//* Date				:	09/03/1998 15:22:24
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Gestion des messages d'erreur suite aux erreurs 
//*					 	de saisies.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	ibErreur Then

	stMessage.sTitre	= "Saisie des libell$$HEX1$$e900$$ENDHEX$$s"
	stMessage.Icon		= Information!

	Choose Case isErrCol

		Case "LIB_EVT"
			stMessage.sVar[1] = "libell$$HEX2$$e9002000$$ENDHEX$$"
			stMessage.sCode	= "GENE003"

	End Choose

	f_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 FM
//	This.uf_Reinitialiser ()
	Return This.uf_Reinitialiser ()
//Fin Migration PB8-WYNIWYG-03/2006 FM

End If
//Migration PB8-WYNIWYG-03/2006 FM
return AncestorReturnValue
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on losefocus;call u_datawindow::losefocus;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_1
//* Evenement 		: LoseFocus
//* Auteur			: DBI
//* Date				: 03/03/1998 18:19:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: AcceptText ()
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.Accepttext ()
end on

