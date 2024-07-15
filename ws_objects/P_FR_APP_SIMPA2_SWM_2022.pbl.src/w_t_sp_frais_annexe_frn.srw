HA$PBExportHeader$w_t_sp_frais_annexe_frn.srw
forward
global type w_t_sp_frais_annexe_frn from window
end type
type dw_reg_frais_anx from datawindow within w_t_sp_frais_annexe_frn
end type
type cb_valider from commandbutton within w_t_sp_frais_annexe_frn
end type
end forward

global type w_t_sp_frais_annexe_frn from window
integer width = 4448
integer height = 952
boolean titlebar = true
string title = "Saisie manuelle des frais annexes prestataires"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
dw_reg_frais_anx dw_reg_frais_anx
cb_valider cb_valider
end type
global w_t_sp_frais_annexe_frn w_t_sp_frais_annexe_frn

type variables

Integer iiErreur
end variables

on w_t_sp_frais_annexe_frn.create
this.dw_reg_frais_anx=create dw_reg_frais_anx
this.cb_valider=create cb_valider
this.Control[]={this.dw_reg_frais_anx,&
this.cb_valider}
end on

on w_t_sp_frais_annexe_frn.destroy
destroy(this.dw_reg_frais_anx)
destroy(this.cb_valider)
end on

event open;//*-----------------------------------------------------------------
//*
//* Objet 			: Open
//* Evenement 		: Close
//* Auteur			: FABRY JF
//* Date				: 07/10/2022
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				     
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass stPassFrAnx

stPassFrAnx = Message.PowerObjectParm


/*
stPassFrAnx.dwNorm[1]	= idw_wreg_frais_annexe_frn
stPassFrAnx.lTab[1]		= lIdSin
stPassFrAnx.lTab[2]		= lIdI
stPassFrAnx.lTab[3]		= lIdGti
stPassFrAnx.lTab[4]		= lIdDetail
stPassFrAnx.dcTab[1]		= idw_LstInter.GetItemDecimal ( lRowInter, "MT_A_REG" ) 
stPassFrAnx.sTab[1]		= idw_LstInter.GetItemString ( lRowInter, "NOM" )
*/


dw_reg_frais_anx.Reset ()
stPassFrAnx.dwNorm[1].ShareData ( dw_reg_frais_anx )



end event

event show;s_Pass stPassFrAnx

stPassFrAnx = Message.PowerObjectParm

dw_reg_frais_anx.RowsDiscard ( 1, dw_reg_frais_anx.RowCount(), primary!) 

dw_reg_frais_anx.InsertRow (0)
dw_reg_frais_anx.SetItem ( 1, "ID_SIN", stPassFrAnx.lTab[1] )
dw_reg_frais_anx.SetItem ( 1, "ID_I", stPassFrAnx.lTab[2] ) 
dw_reg_frais_anx.SetItem ( 1, "ID_GTI", stPassFrAnx.lTab[3] )
dw_reg_frais_anx.SetItem ( 1, "ID_DETAIL", stPassFrAnx.lTab[4] )
dw_reg_frais_anx.SetItem ( 1, "mt_fact_fourn", stPassFrAnx.dcTab[1] )
dw_reg_frais_anx.SetItem ( 1, "lib_four", stPassFrAnx.sTab[1] )
dw_reg_frais_anx.SetItem ( 1, "mtindemprinc_1", 0 )
dw_reg_frais_anx.SetItem ( 1, "mtfraisanex_2", 0 ) 
dw_reg_frais_anx.SetItem ( 1, "mtfraisanex_3", 0 )
dw_reg_frais_anx.SetItem ( 1, "mtfraisanex_4", 0 )
dw_reg_frais_anx.SetItem ( 1, "mtfraisanex_5", 0 )
dw_reg_frais_anx.SetItem ( 1, "mtfraisanex_6", 0 )
dw_reg_frais_anx.SetItem ( 1, "mtfraisanex_7", 0 )
dw_reg_frais_anx.SetItem ( 1, "mtfraisanex_8", 0 )
dw_reg_frais_anx.SetItem ( 1, "mtfraisanex_9", 0 )
dw_reg_frais_anx.SetItem ( 1, "mtfraisanex_10", 0 )
dw_reg_frais_anx.SetItem ( 1, "mtfraisanex_11", 0 )


dw_reg_frais_anx.SetColumn ( "mtindemprinc_1" ) 
dw_reg_frais_anx.SetFocus ()

end event

type dw_reg_frais_anx from datawindow within w_t_sp_frais_annexe_frn
integer x = 46
integer y = 168
integer width = 4379
integer height = 656
integer taborder = 20
string title = "none"
string dataobject = "d_sp_sin_w_reg_frais_annexe_frn"
boolean border = false
end type

event itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: itemchanged
//* Evenement 		: Close
//* Auteur			: FABRY JF
//* Date				: 07/10/2022
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				     
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


If Dec ( data ) < 0 Then
	iiErreur = 1
	Return 1
End If 



end event

event itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: itemerror
//* Evenement 		: Close
//* Auteur			: FABRY JF
//* Date				: 07/10/2022
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				     
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------



Choose Case iiErreur 
	Case 1 
		iiErreur = 0
		stMessage.sCode		= "WSIN887"
		
	Case Else 	
		iiErreur = 0
		stMessage.sCode		= "WSIN888"		
		
End Choose 

stMessage.sTitre		= "Donn$$HEX1$$e900$$ENDHEX$$es non valide"
stMessage.Icon			= Exclamation!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= OK!

F_Message ( stMessage )

//This.SetItem ( row, This.GetColumnName (), String ( This.GetItemNumber ( row, This.GetColumnName ())))
This.SetText ( String ( This.GetItemDecimal ( row, This.GetColumnName ()) ))
This.setColumn (This.GetColumnName ())
This.setFocus ()
Return 1

end event

type cb_valider from commandbutton within w_t_sp_frais_annexe_frn
integer x = 37
integer y = 28
integer width = 402
integer height = 132
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Valider"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: Clicked
//* Evenement 		: Close
//* Auteur			: FABRY JF
//* Date				: 07/10/2022
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				     
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass stPass

dw_reg_frais_anx.AcceptText ()

If dw_reg_frais_anx.GetItemDecimal ( 1, "compute_2" ) <> 0 Then

	stMessage.sCode		= "WSIN889"		
	stMessage.sTitre		= "Montant non ventil$$HEX1$$e900$$ENDHEX$$"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	
	F_Message ( stMessage )	
Else
	Message.Powerobjectparm = stPass
	CloseWithReturn(Parent, Message.Powerobjectparm )
End If 


end event

