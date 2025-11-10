HA$PBExportHeader$w_sp_trt_saisie_codeverrou.srw
$PBExportComments$[VDOC8041]
forward
global type w_sp_trt_saisie_codeverrou from window
end type
type cb_1 from commandbutton within w_sp_trt_saisie_codeverrou
end type
type dw_1 from datawindow within w_sp_trt_saisie_codeverrou
end type
end forward

global type w_sp_trt_saisie_codeverrou from window
integer width = 1111
integer height = 504
boolean titlebar = true
string title = "Saisie du code verrou"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
dw_1 dw_1
end type
global w_sp_trt_saisie_codeverrou w_sp_trt_saisie_codeverrou

type variables
private:

String isRetour

Boolean ibHupPresta

end variables

on w_sp_trt_saisie_codeverrou.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_1}
end on

on w_sp_trt_saisie_codeverrou.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;
dw_1.InsertRow ( 0 )

Dw_1.SetItem ( 1, "ALT_FLASH", "N" )

dw_1.Setcolumn ( "CODE_VERROU" )
dw_1.SetFocus ()

isRetour = "[RETOUR]"

// [HP252_276_HUB_PRESTA]
ibHupPresta = Message.StringParm = "HUB" 
If ibHupPresta Then
   dw_1.Modify ( "alt_flash.values = 'Code verrou non obtenu	O/Code verrou non obtenu	N'")
	dw_1.Modify ( "alt_flash.checkbox.text = 'Code verrou non obtenu'")
End IF 
// /[HP252_276_HUB_PRESTA]

end event

event close;
CloseWithReturn(This, isRetour)
end event

type cb_1 from commandbutton within w_sp_trt_saisie_codeverrou
integer x = 352
integer y = 260
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Valider"
end type

event clicked;
String sVal1, sVal2
Boolean bFerm

bFerm = True

dw_1.AcceptText()

sVal1 = Dw_1.GetItemString ( 1, "ALT_FLASH" )
sVal2 = Dw_1.GetItemString ( 1, "CODE_VERROU" )

If sVal1 = "N" And ( Trim ( sVal2 ) = "" Or IsNull ( sVal2 ) ) Then
	bFerm = False
	
	stMessage.sTitre		= "Saisie carte avoir"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= False
	stMessage.Bouton		= OK!
	stMessage.sCode		= "COMD743"

	isRetour = "[RETOUR]"
						
	f_message(stMessage)
	Return		
	
End If 

isRetour= "CODE_VERROU=" + sVal2 

If bFerm Then
	Close(Parent)
End If


end event

type dw_1 from datawindow within w_sp_trt_saisie_codeverrou
integer x = 32
integer y = 16
integer width = 1042
integer height = 204
integer taborder = 10
string title = "none"
string dataobject = "d_trt_saisie_code_verrou"
boolean border = false
boolean livescroll = true
end type

event itemchanged;

Choose Case dwo.name
	Case "alt_flash"
		
		If data = "O" Then
			// [HP252_276_HUB_PRESTA]
			If ibHupPresta Then
				dw_1.SetItem ( 1, "CODE_VERROU", "NON_OBTENU")
			Else 
				dw_1.SetItem ( 1, "CODE_VERROU", "A_FLASHER")
			ENd If 
			
			dw_1.Modify ( "code_verrou.protect = 1" )
		End If

		If data = "N" Then
			dw_1.Modify ( "code_verrou.protect = 0" )
			dw_1.Modify ( "code_verrou.visible = 1" )
			dw_1.SetItem ( 1, "CODE_VERROU", stNul.str )			
			dw_1.SetColumn ( "CODE_VERROU" ) 
			dw_1.SetFocus ()
			
		End If

		
End Choose

end event

