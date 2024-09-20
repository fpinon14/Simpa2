$PBExportHeader$w_cd_sp_reg_annexes.srw
$PBExportComments$PM80
forward
global type w_cd_sp_reg_annexes from window
end type
type dw_1 from datawindow within w_cd_sp_reg_annexes
end type
type cb_retour from commandbutton within w_cd_sp_reg_annexes
end type
end forward

global type w_cd_sp_reg_annexes from window
integer width = 2053
integer height = 1708
boolean titlebar = true
string title = "Ventilation des frais annexes fournisseurs"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_retour cb_retour
end type
global w_cd_sp_reg_annexes w_cd_sp_reg_annexes

on w_cd_sp_reg_annexes.create
this.dw_1=create dw_1
this.cb_retour=create cb_retour
this.Control[]={this.dw_1,&
this.cb_retour}
end on

on w_cd_sp_reg_annexes.destroy
destroy(this.dw_1)
destroy(this.cb_retour)
end on

event open;
s_Pass stPass

stPass = Message.Powerobjectparm

dw_1.SetTransObject ( SQLCA )
Long l
l = dw_1.Retrieve ( stPass.lTab[1], stPass.lTab[2] )

end event

type dw_1 from datawindow within w_cd_sp_reg_annexes
integer x = 37
integer y = 176
integer width = 1970
integer height = 1416
integer taborder = 20
string title = "none"
string dataobject = "d_sp_c_detail_reg_frais_annexe"
boolean border = false
end type

type cb_retour from commandbutton within w_cd_sp_reg_annexes
integer x = 37
integer y = 36
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Retour"
end type

event clicked;


s_Pass stPass

Message.Powerobjectparm = stPass


CloseWithReturn(Parent, Message.Powerobjectparm )



end event

