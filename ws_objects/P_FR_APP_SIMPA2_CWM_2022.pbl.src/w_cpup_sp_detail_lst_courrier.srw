$PBExportHeader$w_cpup_sp_detail_lst_courrier.srw
$PBExportComments$---} Fenêtre de consultation des travaux
forward
global type w_cpup_sp_detail_lst_courrier from window
end type
type dw_1 from datawindow within w_cpup_sp_detail_lst_courrier
end type
type cb_retour from commandbutton within w_cpup_sp_detail_lst_courrier
end type
end forward

global type w_cpup_sp_detail_lst_courrier from window
integer width = 4133
integer height = 1900
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_retour cb_retour
end type
global w_cpup_sp_detail_lst_courrier w_cpup_sp_detail_lst_courrier

type variables
s_Pass istPassData1

end variables

on w_cpup_sp_detail_lst_courrier.create
this.dw_1=create dw_1
this.cb_retour=create cb_retour
this.Control[]={this.dw_1,&
this.cb_retour}
end on

on w_cpup_sp_detail_lst_courrier.destroy
destroy(this.dw_1)
destroy(this.cb_retour)
end on

event open;//*-----------------------------------------------------------------
//*
//* Evenement 		: Open
//* Auteur			: JFF
//* Date				: 27/12/2022
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

istPassData1 = Message.PowerObjectParm
Int iCoef 

dw_1.SetTransObject ( SQLCA ) 
dw_1.Retrieve ( istPassData1.lTab[1] )

This.Title = "Liste détaillée des courriers du sinistre " + String ( istPassData1.lTab[1] ) + ", assuré " + dw_1.GetItemString ( 1, "NOM_ASS" )  

This.width  = 7200 // + 300 // [PB2022_TAILLE_FEN] 
This.Height = 1000 // + 300 // [PB2022_TAILLE_FEN] 
This.x 		= 10
This.y 		= 10

iCoef = Int ( dw_1.RowCount () / 5 ) 
IF iCoef > 5 Then iCoef = 5 

If iCoef >= 1 Then
	This.Height += ( 400 * iCoef - 1 )
End If 

dw_1.width = This.width - 75 - 50 // [PB2022_TAILLE_FEN]
dw_1.height = This.Height - 335 - 50 // [PB2022_TAILLE_FEN]
dw_1.X		= 18
dw_1.Y		= 200

dw_1.SelectRow (1, TRUE)

end event

event close;//*-----------------------------------------------------------------
//*
//* Evenement 		: Close
//* Auteur			: JFF
//* Date				: 27/12/2022
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

If Upperbound ( istPassData1.sTab) > 0 Then
	IF istPassData1.sTab[1] <> "COURRIER_A_OUVRIR" Then
		istPassData1.sTab[1] = "RETOUR"	
	End If 
Else
	istPassData1.sTab[1] = "RETOUR"		
End If 
CloseWithReturn ( This, istPassData1 )

end event

type dw_1 from datawindow within w_cpup_sp_detail_lst_courrier
integer x = 46
integer y = 164
integer width = 3982
integer height = 1328
integer taborder = 20
string title = "none"
string dataobject = "d_sp_c_detail_lst_courrier"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;This.SelectRow ( 0, False)

If row > 0 Then 
	This.SelectRow ( row, TRUE )
	This.SetRow ( row )
End IF 


end event

event doubleclicked;Int iRow
Long lIdInter, lIdDoc

This.SelectRow ( 0, False)
This.SelectRow ( row, TRUE )

iRow = This.GetSelectedRow (0)

lIdInter = This.GetItemNumber ( iRow, "ID_INTER" ) 
lIdDoc = This.GetItemNumber ( iRow, "ID_DOC" ) 

istPassData1.lTab[2] = lIdInter 
istPassData1.lTab[3] = lIdDoc

istPassData1.sTab[1] = "COURRIER_A_OUVRIR"

Parent.PostEvent ( "close")

end event

type cb_retour from commandbutton within w_cpup_sp_detail_lst_courrier
integer x = 37
integer y = 40
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
Parent.PostEvent ( "close")



end event

