HA$PBExportHeader$w_sp_trt_saisie_carte_conforama.srw
$PBExportComments$[CONFO][CUISINE]
forward
global type w_sp_trt_saisie_carte_conforama from window
end type
type dw_1 from u_datawindow within w_sp_trt_saisie_carte_conforama
end type
type cb_retour from commandbutton within w_sp_trt_saisie_carte_conforama
end type
type cb_valider from commandbutton within w_sp_trt_saisie_carte_conforama
end type
end forward

global type w_sp_trt_saisie_carte_conforama from window
integer width = 1797
integer height = 688
boolean titlebar = true
string title = "Saisie carte avoir"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_retour cb_retour
cb_valider cb_valider
end type
global w_sp_trt_saisie_carte_conforama w_sp_trt_saisie_carte_conforama

type variables
private:

String isRetour
end variables

event open;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_carte_conforama
//* Evenement 		: open
//* Auteur			: F. Pinon
//* Date				: 25/01/2012 10:02:37
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
dw_1.setItem(1,"DTE_CREATION", Today())
dw_1.Setcolumn( "NUM_CARTE_AVOIR")
end event

event close;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_carte_conforama
//* Evenement 		: close
//* Auteur			: F. Pinon
//* Date				: 25/01/2012 10:02:21
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

on w_sp_trt_saisie_carte_conforama.create
this.dw_1=create dw_1
this.cb_retour=create cb_retour
this.cb_valider=create cb_valider
this.Control[]={this.dw_1,&
this.cb_retour,&
this.cb_valider}
end on

on w_sp_trt_saisie_carte_conforama.destroy
destroy(this.dw_1)
destroy(this.cb_retour)
destroy(this.cb_valider)
end on

type dw_1 from u_datawindow within w_sp_trt_saisie_carte_conforama
integer x = 32
integer y = 56
integer width = 1691
integer height = 252
integer taborder = 10
string dataobject = "d_trt_saisie_carte_conforama"
boolean border = false
boolean livescroll = false
end type

type cb_retour from commandbutton within w_sp_trt_saisie_carte_conforama
integer x = 919
integer y = 396
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
//* Objet			: w_sp_trt_saisie_carte_conforama
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 25/01/2012 10:02:11
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

type cb_valider from commandbutton within w_sp_trt_saisie_carte_conforama
integer x = 411
integer y = 396
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
//* Objet			: w_sp_trt_saisie_carte_conforama
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 25/01/2012 10:02:00
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
String sNumCarte
Date dteCreation

dw_1.AcceptText()

sNumCarte = dw_1.getItemString(1,"NUM_CARTE_AVOIR")
dteCreation = dw_1.GetItemDate(1,"DTE_CREATION")

If IsNull(sNumCarte) Then sNumCarte=""

if isnull(dteCreation) Or Len(Trim(sNumCarte)) = 0 Then
	stMessage.sTitre		= "Saisie carte avoir"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= TRUE
	stMessage.Bouton		= OK!
	stMessage.sCode		= "GENE016"
						
	f_message(stMessage)
	Return	
End if

isRetour= "NUM_CARTE=" + sNumCarte + ";DATE_CREATION=" + String(dteCreation)

Close(Parent)
end event

