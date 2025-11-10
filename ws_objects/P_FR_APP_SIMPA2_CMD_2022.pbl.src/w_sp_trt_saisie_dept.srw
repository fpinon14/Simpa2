HA$PBExportHeader$w_sp_trt_saisie_dept.srw
$PBExportComments$[DCMP090327]
forward
global type w_sp_trt_saisie_dept from window
end type
type dw_1 from datawindow within w_sp_trt_saisie_dept
end type
type cb_retour from commandbutton within w_sp_trt_saisie_dept
end type
type cb_valider from commandbutton within w_sp_trt_saisie_dept
end type
end forward

global type w_sp_trt_saisie_dept from window
integer width = 1618
integer height = 504
boolean titlebar = true
string title = "Saisie d$$HEX1$$e900$$ENDHEX$$partement"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_retour cb_retour
cb_valider cb_valider
end type
global w_sp_trt_saisie_dept w_sp_trt_saisie_dept

type variables
private:

String isRetour
end variables

event open;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_sbe
//* Evenement 		: open
//* Auteur			: F. Pinon
//* Date				: 02/09/2009 10:02:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

isRetour="[RETOUR]"

dw_1.InsertRow(0)
end event

event close;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_sbe
//* Evenement 		: close
//* Auteur			: F. Pinon
//* Date				: 02/09/2009 10:02:21
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

CloseWithReturn(This, isRetour)
end event

on w_sp_trt_saisie_dept.create
this.dw_1=create dw_1
this.cb_retour=create cb_retour
this.cb_valider=create cb_valider
this.Control[]={this.dw_1,&
this.cb_retour,&
this.cb_valider}
end on

on w_sp_trt_saisie_dept.destroy
destroy(this.dw_1)
destroy(this.cb_retour)
destroy(this.cb_valider)
end on

type dw_1 from datawindow within w_sp_trt_saisie_dept
integer x = 23
integer y = 32
integer width = 1568
integer height = 180
integer taborder = 10
string title = "none"
string dataobject = "d_trt_saisie_dept"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_retour from commandbutton within w_sp_trt_saisie_dept
integer x = 859
integer y = 260
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Retour"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_sbe
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 02/09/2009 10:02:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Close(Parent)
end event

type cb_valider from commandbutton within w_sp_trt_saisie_dept
integer x = 352
integer y = 260
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Valider"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_sbe
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 02/09/2009 10:02:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
Integer iDept

dw_1.AcceptText()

iDept = dw_1.getItemNumber(1,"DEPT")

if isnull(iDept) Or iDept <= 0 Then
	stMessage.sTitre		= "Saisie d$$HEX1$$e900$$ENDHEX$$partement"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= TRUE
	stMessage.Bouton		= OK!
	stMessage.sCode		= "GENE016"
						
	f_message(stMessage)
	Return	
End if

isRetour= "DEPT=" + string(iDept)

Close(Parent)
end event

