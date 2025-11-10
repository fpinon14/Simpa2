HA$PBExportHeader$w_sp_boutique_psm_cmd.srw
$PBExportComments$[PM284-1]
forward
global type w_sp_boutique_psm_cmd from window
end type
type st_2 from statictext within w_sp_boutique_psm_cmd
end type
type cb_ok from commandbutton within w_sp_boutique_psm_cmd
end type
type dw_2 from datawindow within w_sp_boutique_psm_cmd
end type
type st_1 from statictext within w_sp_boutique_psm_cmd
end type
type dw_1 from datawindow within w_sp_boutique_psm_cmd
end type
end forward

global type w_sp_boutique_psm_cmd from window
integer width = 2514
integer height = 1916
boolean titlebar = true
string title = "Boutique PSM"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_2 st_2
cb_ok cb_ok
dw_2 dw_2
st_1 st_1
dw_1 dw_1
end type
global w_sp_boutique_psm_cmd w_sp_boutique_psm_cmd

forward prototypes
public subroutine uf_redim_fenetre ()
public subroutine uf_fill_datawindow (ref datawindow adwlisteboutique, string aslisteboutiques, long alidprod)
end prototypes

public subroutine uf_redim_fenetre ();
dw_1.height= 660 * dw_1.RowCount()

if dw_2.RowCount() = 0 Then
	st_2.Visible=FALSE
	dw_2.Visible=FALSE
	cb_ok.y=892 + (dw_1.RowCount() * 660) - 660
Else
	st_2.y=860 + (dw_1.RowCount() * 660) - 660
	dw_2.y = 100 + st_2.y
	dw_2.height= 660 * dw_2.RowCount()
	cb_ok.y=dw_2.y + (dw_2.RowCount() * 660) + 60
End if

This.height=cb_ok.y + 250
end subroutine

public subroutine uf_fill_datawindow (ref datawindow adwlisteboutique, string aslisteboutiques, long alidprod);n_cst_string nvString
string sboutiques[] 
Integer iIndex

nvString.of_parsetoarray( asListeBoutiques, "#", sboutiques)

adwlisteboutique.reset()

For iIndex=1 To UpperBound(sboutiques)
	if sBoutiques[iIndex] ="" Then Continue
	adwlisteboutique.Retrieve(alIdProd,sBoutiques[iIndex])
Next

end subroutine

on w_sp_boutique_psm_cmd.create
this.st_2=create st_2
this.cb_ok=create cb_ok
this.dw_2=create dw_2
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.st_2,&
this.cb_ok,&
this.dw_2,&
this.st_1,&
this.dw_1}
end on

on w_sp_boutique_psm_cmd.destroy
destroy(this.st_2)
destroy(this.cb_ok)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.dw_1)
end on

event open;/*
	19/10/2017	FPI	[ITSM494276] Ajout de la boutique Advise
*/

s_pass stPass
String sInfoSpbFrnCplt, sCodBoutique
Long lIdProd, lCpt
n_cst_string nvString
String sTabRech[]
string sTabSubst[]
Boolean bRelai=FALSE

If isValid(Message.PowerObjectParm) Then
	stPass=Message.PowerObjectParm
	
	This.title = "Boutique(s) PSM - commande " + string(stPass.lTab[1]) + "-" +  string(stPass.lTab[2])
	
	dw_1.SetTransObject(SQLCA)

	sInfoSpbFrnCplt = stPass.stab[1]
	lIdProd= stPass.lTab[3]

	// Pour la consult, transcription inverse
	sTabRech[1] = "Code Boutique Centrale PSM"	 
	sTabSubst [1] ="CODE_BTQ_PSM_CENTRALE"	

	sTabRech  [2] ="Boutique Relai PSM"
	sTabSubst [2] = "CODE_BTQ_RELAI_PSM"

	sTabRech  [3] ="Code boutiqueAI_PSM"
	sTabSubst [3] = "CODE_BTQ_RELAI_PSM"
	
	sTabRech  [4] ="Boutique PSM Advise"
	sTabSubst [4] = "BTQ_PSM_ADV"
	
	sTabRech  [5] =", "
	sTabSubst [5] =  ";"									
	sTabRech  [6] = " : "
	sTabSubst [6] = "="
	
	For lCpt = 1 To UpperBound(sTabRech)
		sInfoSpbFrnCplt = F_Remplace ( sInfoSpbFrnCplt, sTabRech  [lCpt], sTabSubst [lCpt] )
	Next

	// Remplissage de la 1$$HEX1$$e800$$ENDHEX$$re dw
	sCodBoutique=nvstring.of_getkeyvalue( sInfoSpbFrnCplt , "CODE_BTQ_PSM_CENTRALE", ";")
	if sCodBoutique="" Then
		sCodBoutique=nvstring.of_getkeyvalue( sInfoSpbFrnCplt , "CODE_BTQ_RELAI_PSM", ";")
		st_1.Text="Boutiques relais PSM : "
		bRelai=TRUE
	End if
	
	uf_fill_datawindow( dw_1, sCodBoutique, lidprod)

	if dw_1.RowCount() = 0 Then st_1.Visible=False
	
	if bRelai and dw_1.RowCount() >= 1 Then st_1.Text="Boutique relai PSM : "
	
	// Remplissage de la 2$$HEX1$$e800$$ENDHEX$$me dw
//	If not bRelai Then
		sCodBoutique=nvstring.of_getkeyvalue( sInfoSpbFrnCplt , "CODE_BTQ_PSM_PROXIMITE", ";")
		if sCodBoutique <> "" Then
			
			dw_2.SetTransObject(SQLCA)
			uf_fill_datawindow( dw_2, sCodBoutique, lidprod)
		End if
		
		If dw_2.RowCount() >= 1 Then st_2.Text="Boutique PSM de proximit$$HEX2$$e9002000$$ENDHEX$$:"
		
	//End if
	
	// [ITSM494276]
	if sCodBoutique="" Then
		sCodBoutique=nvstring.of_getkeyvalue( sInfoSpbFrnCplt , "BTQ_PSM_ADV", ";")
		if sCodBoutique <> "" Then
			
			dw_2.SetTransObject(SQLCA)
			uf_fill_datawindow( dw_2, sCodBoutique, lidprod)
		End if
		
		If dw_2.RowCount() >= 1 Then st_2.Text="Boutique PSM Advise :"
	End if
	// :[ITSM494276]
	
	// Redimensionnement
	 uf_redim_fenetre( )
End if
end event

type st_2 from statictext within w_sp_boutique_psm_cmd
integer x = 96
integer y = 860
integer width = 859
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Boutiques PSM de proximit$$HEX2$$e9002000$$ENDHEX$$:"
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_sp_boutique_psm_cmd
integer x = 1024
integer y = 1680
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "OK"
boolean cancel = true
boolean default = true
end type

event clicked;Close(Parent)
end event

type dw_2 from datawindow within w_sp_boutique_psm_cmd
integer x = 87
integer y = 960
integer width = 2226
integer height = 668
integer taborder = 10
string title = "none"
string dataobject = "d_adresse_psm"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
boolean righttoleft = true
end type

event retrievestart;Return 2 // Mode ajout
end event

type st_1 from statictext within w_sp_boutique_psm_cmd
integer x = 96
integer y = 56
integer width = 859
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Boutique PSM de centralisation :"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_sp_boutique_psm_cmd
integer x = 91
integer y = 156
integer width = 2226
integer height = 660
integer taborder = 10
string title = "none"
string dataobject = "d_adresse_psm"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrievestart;Return 2 // Mode ajout
end event

