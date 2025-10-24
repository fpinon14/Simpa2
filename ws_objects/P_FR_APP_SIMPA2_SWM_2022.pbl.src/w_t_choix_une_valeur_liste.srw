$PBExportHeader$w_t_choix_une_valeur_liste.srw
forward
global type w_t_choix_une_valeur_liste from window
end type
type dw_liste from datawindow within w_t_choix_une_valeur_liste
end type
end forward

global type w_t_choix_une_valeur_liste from window
integer width = 1943
integer height = 268
boolean titlebar = true
string title = "Choix de valeur de liste"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 15793151
string icon = "AppIcon!"
boolean center = true
dw_liste dw_liste
end type
global w_t_choix_une_valeur_liste w_t_choix_une_valeur_liste

type variables
String isRetour

end variables

on w_t_choix_une_valeur_liste.create
this.dw_liste=create dw_liste
this.Control[]={this.dw_liste}
end on

on w_t_choix_une_valeur_liste.destroy
destroy(this.dw_liste)
end on

event open;s_Pass stPass
DataWindowChild dwChild
String sCodeDefaut, sLibDefaut
Int iRow

stPass=Message.PowerObjectParm

This.title = stPass.sTab [2]
dw_liste.InsertRow ( 0 )

dw_liste.GetChild ( "LIB_CODE", dwChild )
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ( stPass.sTab [1] )

sCodeDefaut = stPass.sTab [3]
iRow = dwChild.Find ( "ID_CODE = '" + sCodeDefaut + "'", 1, dwChild.RowCount () ) 

If iRow > 0 Then
	sLibDefaut = dwChild.GetItemString ( iRow, "LIB_CODE" ) 

	dw_liste.SetItem ( 1, "ID_CODE",  sCodeDefaut )
	dw_liste.SetItem ( 1, "LIB_CODE",  sLibDefaut )	
End IF 




end event

event close;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_choix_une_valeur_liste::ItemChanged
//* Evenement 		: 
//* Auteur			: Fabry JF
//* Date				: 24/10/2025
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//    [20251024135148363][JFF][MIG165_BOUYGUES]
//*-----------------------------------------------------------------

String sLibCode, sIdCode

isRetour = dw_liste.GetItemString ( 1, "ID_CODE" ) 
sLibCode = dw_liste.GetItemString ( 1, "LIB_CODE" ) 


stMessage.sTitre		= "Validez votre choix"
stMessage.Icon			= Information!
stMessage.bErreurG	= False
stMessage.sCode		= "WGAR450"
stMessage.sVar[1]		= sLibCode
stMessage.bouton 		= YesNo!
If F_Message ( stMessage ) = 1 Then 
	CloseWithReturn(This, isRetour)
Else
	Message.Processed = False
	Message.ReturnValue 	= 0
ENd If 




end event

type dw_liste from datawindow within w_t_choix_une_valeur_liste
integer x = 32
integer y = 24
integer width = 1865
integer height = 120
integer taborder = 10
string title = "none"
string dataobject = "d_valeur_de_liste"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_choix_une_valeur_liste::ItemChanged
//* Evenement 		: 
//* Auteur			: Fabry JF
//* Date				: 24/10/2025
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//    [20251024135148363][JFF][MIG165_BOUYGUES]
//*-----------------------------------------------------------------

This.AcceptText() 

Parent.PostEvent ( "Close" )



end event

