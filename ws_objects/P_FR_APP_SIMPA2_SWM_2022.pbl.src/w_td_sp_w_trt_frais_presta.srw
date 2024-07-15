HA$PBExportHeader$w_td_sp_w_trt_frais_presta.srw
$PBExportComments$-} Fen$$HEX1$$ea00$$ENDHEX$$tre d'information des frai presta
forward
global type w_td_sp_w_trt_frais_presta from window
end type
type cb_2 from commandbutton within w_td_sp_w_trt_frais_presta
end type
type st_1 from statictext within w_td_sp_w_trt_frais_presta
end type
type cb_1 from commandbutton within w_td_sp_w_trt_frais_presta
end type
type dw_1 from datawindow within w_td_sp_w_trt_frais_presta
end type
end forward

global type w_td_sp_w_trt_frais_presta from window
integer width = 3378
integer height = 820
boolean titlebar = true
string title = "Frais prestataires"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
st_1 st_1
cb_1 cb_1
dw_1 dw_1
end type
global w_td_sp_w_trt_frais_presta w_td_sp_w_trt_frais_presta

type variables
s_pass	invTrtAttrib
end variables

on w_td_sp_w_trt_frais_presta.create
this.cb_2=create cb_2
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.st_1,&
this.cb_1,&
this.dw_1}
end on

on w_td_sp_w_trt_frais_presta.destroy
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;//*-----------------------------------------------------------------
//*
//* Objet			: w_td_sp_w_trt_frais_presta
//* Evenement 		: open
//* Auteur			: F. Pinon
//* Date				: 04/01/2010 17:23:46
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
Long lIdSin

invtrtattrib=Message.Powerobjectparm

lIdSin = invtrtattrib.ltab[1]

This.Title="Frais prestataire / Sinistre N$$HEX2$$b0002000$$ENDHEX$$" + string(lIdSin)

dw_1.SetTransobject( SQLCA)

if dw_1.Retrieve( Dec(lIdSin) ) = 0 Then
	invTrtAttrib.sTab[1] = "CONTINUER"

	CloseWithReturn ( this, invTrtAttrib )
End if
end event

type cb_2 from commandbutton within w_td_sp_w_trt_frais_presta
integer x = 1627
integer y = 588
integer width = 256
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Arr$$HEX1$$ea00$$ENDHEX$$ter"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_td_sp_w_trt_frais_presta
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 04/01/2010 17:31:43
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

invTrtAttrib.sTab[1] = "ARRETER"

CloseWithReturn ( Parent, invTrtAttrib )

end event

type st_1 from statictext within w_td_sp_w_trt_frais_presta
integer x = 37
integer y = 52
integer width = 2578
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Les frais d~'envoi suivants ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$automatiquement pass$$HEX1$$e900$$ENDHEX$$s sur ce dossier lors de l~'int$$HEX1$$e900$$ENDHEX$$gration du suivi de commande."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_td_sp_w_trt_frais_presta
integer x = 1225
integer y = 588
integer width = 256
integer height = 108
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuer"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_td_sp_w_trt_frais_presta
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 04/01/2010 17:31:36
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

invTrtAttrib.sTab[1] = "CONTINUER"

CloseWithReturn ( Parent, invTrtAttrib )
end event

type dw_1 from datawindow within w_td_sp_w_trt_frais_presta
integer x = 37
integer y = 144
integer width = 3301
integer height = 400
integer taborder = 10
string title = "none"
string dataobject = "d_lst_trt_frais_presta"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

