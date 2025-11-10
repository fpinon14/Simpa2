HA$PBExportHeader$w_sp_trt_saisie_rdc.srw
$PBExportComments$[RUEDUCOMMERCE]
forward
global type w_sp_trt_saisie_rdc from window
end type
type cb_annuler from commandbutton within w_sp_trt_saisie_rdc
end type
type cb_valider from commandbutton within w_sp_trt_saisie_rdc
end type
type dw_1 from datawindow within w_sp_trt_saisie_rdc
end type
end forward

global type w_sp_trt_saisie_rdc from window
integer width = 2171
integer height = 1188
boolean titlebar = true
string title = "Commande RueDuCommerce"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_annuler cb_annuler
cb_valider cb_valider
dw_1 dw_1
end type
global w_sp_trt_saisie_rdc w_sp_trt_saisie_rdc

type variables
n_cst_attrib_rdc	invRdc
end variables

forward prototypes
public function integer wf_controler_saisie ()
end prototypes

public function integer wf_controler_saisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_saisie_rdc::wf_controler_saisie
//* Auteur			: F. Pinon
//* Date				: 15/06/2009 14:18:47
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
Integer	iRet, iCol
decimal 	dcMtTTC
String 	sVal, sText, sNouvelleLigne

string 	sCols[]={"ID_REF_FOUR","ID_MARQ_ART","ID_MODL_ART", &
						"REF_FDP","CODE_PAYS"}
					
string 	sLib[]={"La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence du produit","La marque de l'article", &
						"Le mod$$HEX1$$e800$$ENDHEX$$le de l'article", "La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence RueDuCommerce", &
						"Le code pays"}
datawindowChild ldwcMarq

sNouvelleLigne		= "~r~n"
sText = ""
iRet = 1

dw_1.AcceptText()

// Init du msg d'erreur
stMessage.sTitre  	= "Contr$$HEX1$$f400$$ENDHEX$$le de saisie"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= Ok!
	
// Champs obligatoires
For iCol = 1 To UpperBound(sCols)
	sVal = dw_1.getitemstring( 1, sCols[iCol])

	if isnull(sVal) Then
		sText = 	sText + " - " + sLib[iCol]	+ sNouvelleLigne
	End if
Next

dcMtTTC = dw_1.getitemdecimal( 1, "MT_TTC_CMDE" )

if isNull(dcMtTTC) Then
	sText = sText + " - Le prix TTC" + sNouvelleLigne
End if

if sText <> "" Then
	stMessage.scode 		= "GENE001"
	stMessage.sVar[1] 	= sText
	f_message(stMessage)
	iRet = -1
End if

//Contr$$HEX1$$f400$$ENDHEX$$les fonctionnels
if iRet = 1 Then
	sVal = dw_1.getitemstring( 1, "ID_MARQ_ART")
	dw_1.getChild("ID_MARQ_ART",ldwcMarq)	
	if ldwcMarq.find( "lib_code='" + sVal + "'", 1, ldwcMarq.RowCount() )  < 1 Then

		dw_1.setColumn( "ID_MARQ_ART")
		
		stMessage.scode 		= "COMD530"
		f_message(stMessage)

		iRet = -1
	End if
End if
	
if iRet = 1 Then
	If dcMtTTC > invrdc.idcMtpec Then
		
		dw_1.setColumn( "MT_TTC_CMDE")
		
		stMessage.scode 		= "COMD529"
		f_message(stMessage)
	
		iRet = -1
	End if
End if

If iRet = -1 Then dw_1.setFocus()

Return iRet




end function

on w_sp_trt_saisie_rdc.create
this.cb_annuler=create cb_annuler
this.cb_valider=create cb_valider
this.dw_1=create dw_1
this.Control[]={this.cb_annuler,&
this.cb_valider,&
this.dw_1}
end on

on w_sp_trt_saisie_rdc.destroy
destroy(this.cb_annuler)
destroy(this.cb_valider)
destroy(this.dw_1)
end on

event open;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_rdc
//* Evenement 		: open
//* Auteur			: F. Pinon
//* Date				: 15/06/2009 11:55:26
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

datawindowchild ldwChild
n_cst_string nvString
Long lDeb, lFin, lRow
String sListePays, sPays

// Verification de l'argument pass$$HEX1$$e900$$ENDHEX$$
if isvalid(message.powerobjectparm) then
	if lower(message.powerobjectparm.ClassName())<>"n_cst_attrib_rdc" then Close(This)
Else
	Close(This)
End If

// Arg Ok, on continue
invrdc = message.PowerObjectparm

This.setRedraw(FALSE)

dw_1.InsertRow(0)
dw_1.getchild("id_marq_art",ldwChild)
ldwChild.SetTransObject(SQLCA)

invrdc.idwMarques.sharedata( ldwChild)

dw_1.getchild("CODE_PAYS",ldwChild)
ldwChild.SetTransObject ( SQLCA )
ldwChild.Retrieve ( "-PY" )

// On supprime de la liste des pays ceux qui ne sont pas dans le -DP 114
f_rechdetpro(lDeb, lFin,invrdc.idwdetpro, invrdc.iiIdProd, '-DP', 114)
If lDeb > 0 Then
	sListePays = invrdc.idwdetpro.getItemString( lDeb, "VAL_CAR")
	sListePays = nvString.of_getkeyvalue( sListePays, "CODE_PAYS", ";")
	
	For lRow = ldwChild.RowCount() To 1 Step -1

		sPays = ldwChild.GetItemString(lRow, "ID_CODE")
		if Pos(sListePays, sPays) = 0 Then
			ldwChild.Rowsdiscard( lRow, lRow, Primary!)
		End if
		
	Next
End if

ldwChild.SetFilter("id_code <> '-1'")
ldwChild.Filter()

This.setRedraw(TRUE)


end event

event close;CloseWithReturn(This, invRDC)
end event

type cb_annuler from commandbutton within w_sp_trt_saisie_rdc
integer x = 1285
integer y = 932
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
//* Objet			: w_sp_trt_saisie_rdc
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 15/06/2009 14:55:13
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

type cb_valider from commandbutton within w_sp_trt_saisie_rdc
integer x = 571
integer y = 932
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
//* Objet			: w_sp_trt_saisie_rdc
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

if wf_controler_saisie( ) = 1 Then 
	invrdc.uf_setparams( dw_1)
	Close(Parent)
End if

end event

type dw_1 from datawindow within w_sp_trt_saisie_rdc
integer x = 37
integer y = 40
integer width = 2112
integer height = 832
integer taborder = 10
string title = "none"
string dataobject = "d_trt_saisie_rdc"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemerror;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_rdc
//* Evenement 		: itemerror
//* Auteur			: F. Pinon
//* Date				: 18/06/2009 10:18:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: value long row	 */
/* 	value dwobject dwo	 */
/* 	value string data	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

decimal dcMt

If Upper(dwo.Name) = "MT_TTC_CMDE" Then
	stMessage.sTitre		= "Saisie commande RueDuCommerce"
	stMessage.Icon			= Information!

	stMessage.bErreurG	= TRUE
	stMessage.sVar[1] = "prix TTC"			// Erreur de Validation - 
	stMessage.sCode	= "GENE003"
	
	f_message(stmessage)
	
	if data="" Then return 3

	dcMt = This.GetItemNumber ( row, "MT_TTC_CMDE")
	
	This.SetItem ( row, "MT_TTC_CMDE", dcMt	)
	
	Return 1
End if

end event

