HA$PBExportHeader$w_sp_trt_saisie_pt_balance.srw
$PBExportComments$[PT_BALANCE_LDE]
forward
global type w_sp_trt_saisie_pt_balance from window
end type
type st_1 from statictext within w_sp_trt_saisie_pt_balance
end type
type dw_1 from datawindow within w_sp_trt_saisie_pt_balance
end type
type cb_annuler from commandbutton within w_sp_trt_saisie_pt_balance
end type
type cb_valider from commandbutton within w_sp_trt_saisie_pt_balance
end type
end forward

global type w_sp_trt_saisie_pt_balance from window
integer width = 2976
integer height = 1188
boolean titlebar = true
string title = "S$$HEX1$$e900$$ENDHEX$$lection point de balance LDE"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_1 st_1
dw_1 dw_1
cb_annuler cb_annuler
cb_valider cb_valider
end type
global w_sp_trt_saisie_pt_balance w_sp_trt_saisie_pt_balance

type variables
String isRetour
end variables

forward prototypes
private function string uf_getretour ()
end prototypes

private function string uf_getretour ();Long lRow, lCol
String sResult=""

lRow=dw_1.getSelectedrow( 0)
if lRow=0 Then return "[RETOUR]"

sResult="ID_BOUTIQUE=" + String(dw_1.GetItemNumber( lRow,"ID_BOUTIQUE"))+ ";"

For lCol = 4 To 16
	sResult+=Upper(dw_1.Describe("#" + String(lCol) + ".Name"))
	sResult+="="
	If isNull(dw_1.GetItemString(lRow,lCol)) Then 
		sResult+=";"
	Else
		sResult+=dw_1.GetItemString(lRow,lCol) + ";"
	End if
Next


Return sResult
end function

on w_sp_trt_saisie_pt_balance.create
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_annuler=create cb_annuler
this.cb_valider=create cb_valider
this.Control[]={this.st_1,&
this.dw_1,&
this.cb_annuler,&
this.cb_valider}
end on

on w_sp_trt_saisie_pt_balance.destroy
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_annuler)
destroy(this.cb_valider)
end on

event open;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_pt_balance
//* Evenement 		: open
//* Auteur			: F. Pinon
//* Date				: 30/04/2012
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

This.setRedraw(FALSE)

dw_1.setTransobject( sqlca)
dw_1.retrieve(Dec(Message.DoubleParm))

This.setRedraw(TRUE)
isRetour="[RETOUR]"


end event

event close;CloseWithReturn(This, isRetour)
end event

type st_1 from statictext within w_sp_trt_saisie_pt_balance
integer x = 905
integer y = 56
integer width = 1147
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Merci de s$$HEX1$$e900$$ENDHEX$$lectionner un point de balance"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_sp_trt_saisie_pt_balance
integer x = 91
integer y = 156
integer width = 2729
integer height = 688
integer taborder = 10
string title = "none"
string dataobject = "d_lst_boutique_lde"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;If row > 0 Then
	This.SelectRow(0,FALSE)
	This.SelectRow(Row,TRUE)
End if
end event

type cb_annuler from commandbutton within w_sp_trt_saisie_pt_balance
integer x = 1563
integer y = 928
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Annuler"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_pt_balance
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 30/04/2011
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
Close(Parent)
end event

type cb_valider from commandbutton within w_sp_trt_saisie_pt_balance
integer x = 850
integer y = 928
integer width = 402
integer height = 112
integer taborder = 20
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
//* Objet			: w_sp_trt_saisie_pt_balance
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 15/06/2009 14:26:07
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
isRetour=uf_getRetour()
if isRetour = "[RETOUR]" Then return

Close(Parent)

end event

