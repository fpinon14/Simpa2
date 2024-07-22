HA$PBExportHeader$w_t_rech_ifr.srw
forward
global type w_t_rech_ifr from window
end type
type dw_rech_ifr_saisie from datawindow within w_t_rech_ifr
end type
type dw_rech_ifr from datawindow within w_t_rech_ifr
end type
type cb_1 from commandbutton within w_t_rech_ifr
end type
end forward

global type w_t_rech_ifr from window
integer width = 2971
integer height = 3412
boolean titlebar = true
string title = "Moteur de recherche des appareils li$$HEX1$$e900$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$la base IFR"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_rech_ifr_saisie dw_rech_ifr_saisie
dw_rech_ifr dw_rech_ifr
cb_1 cb_1
end type
global w_t_rech_ifr w_t_rech_ifr

type variables
s_Pass isPass


end variables

on w_t_rech_ifr.create
this.dw_rech_ifr_saisie=create dw_rech_ifr_saisie
this.dw_rech_ifr=create dw_rech_ifr
this.cb_1=create cb_1
this.Control[]={this.dw_rech_ifr_saisie,&
this.dw_rech_ifr,&
this.cb_1}
end on

on w_t_rech_ifr.destroy
destroy(this.dw_rech_ifr_saisie)
destroy(this.dw_rech_ifr)
destroy(this.cb_1)
end on

event close;CloseWithReturn ( This, isPass )

end event

event open;
dw_rech_ifr_saisie.InsertRow ( 0 )

dw_rech_ifr_saisie.Setcolumn ( "CHAINERECH" )
dw_rech_ifr_saisie.SetFocus ()

dw_rech_ifr.SetTransObject ( SQLCA ) 

isPass.sTab[1] = "RETOUR"
end event

type dw_rech_ifr_saisie from datawindow within w_t_rech_ifr
integer x = 9
integer y = 156
integer width = 2921
integer height = 248
integer taborder = 20
string title = "none"
string dataobject = "d_lst_rech_ifr_saisie"
boolean border = false
boolean livescroll = true
end type

event buttonclicked;dw_rech_ifr_saisie.object.b_rech_mots_cles_elg.enabled = "NO"

Choose Case Upper ( dwo.name )
		
	Case "B_RECH_PRECISE"
		dw_rech_ifr_saisie.AcceptText ()
		dw_rech_ifr.Retrieve ( Trim ( This.GetItemString ( 1, "CHAINERECH" )), "JAI_DE_LA_CHANCE" )

	Case "B_RECH_MOTS_CLES"		
		dw_rech_ifr_saisie.AcceptText ()		
		dw_rech_ifr.Retrieve ( Trim ( This.GetItemString ( 1, "CHAINERECH" )), "MOTS_CLES" )		

	Case "B_RECH_MOTS_CLES_ELG"		
		dw_rech_ifr_saisie.AcceptText ()		
		dw_rech_ifr.Retrieve ( Trim ( This.GetItemString ( 1, "CHAINERECH" )), "MOTS_CLES_PLUS" )		
		
		
	Case "B_EFF"				

		This.SetItem ( 1, "CHAINERECH", "" )
		dw_rech_ifr.Reset ()
		dw_rech_ifr_saisie.object.b_rech_mots_cles_elg.enabled = "NO"
		
End Choose

If dw_rech_ifr.RowCount ( ) > 0 Then
	If dw_rech_ifr.GetItemString ( 1, "PLUSPOSSIBLE" ) = "OUI" Then
		dw_rech_ifr_saisie.object.b_rech_mots_cles_elg.enabled = "YES"
	End If
End If

If dw_rech_ifr.RowCount ( ) <= 0 And Trim ( This.GetItemString ( 1, "CHAINERECH" )) <> "" Then
	dw_rech_ifr_saisie.object.b_rech_mots_cles_elg.enabled = "YES"
End If


end event

event itemchanged;dw_rech_ifr_saisie.object.b_rech_mots_cles_elg.enabled = "NO"

end event

event editchanged;dw_rech_ifr_saisie.object.b_rech_mots_cles_elg.enabled = "NO"

end event

type dw_rech_ifr from datawindow within w_t_rech_ifr
integer x = 46
integer y = 400
integer width = 2871
integer height = 2884
integer taborder = 20
string title = "none"
string dataobject = "d_lst_rech_ifr"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event buttonclicked;Choose Case Upper ( dwo.name )
		
	Case "B_CHOISIR"
		
		isPass.sTab [1] = ""
		isPass.sTab [2] = dw_rech_ifr.GetItemString ( row, "MARQUE" )
		isPass.sTab [3] = dw_rech_ifr.GetItemString ( row, "MODELE" )		
		
		Close ( Parent )
		
End Choose

end event

type cb_1 from commandbutton within w_t_rech_ifr
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

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_t_rech_ifr
//* Evenement 		: close
//* Auteur			: JFF
//* Date				: 12/05/2016
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


CloseWithReturn ( Parent, isPass )
end event

