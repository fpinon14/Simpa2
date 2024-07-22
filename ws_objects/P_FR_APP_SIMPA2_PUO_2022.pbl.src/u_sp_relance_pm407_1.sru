HA$PBExportHeader$u_sp_relance_pm407_1.sru
$PBExportComments$[PM407-1] Nouveau syst$$HEX1$$e800$$ENDHEX$$me de relances
forward
global type u_sp_relance_pm407_1 from userobject
end type
type cb_creer_sup from commandbutton within u_sp_relance_pm407_1
end type
type cb_creer_prem from commandbutton within u_sp_relance_pm407_1
end type
type dw_soldage from u_datawindow_detail within u_sp_relance_pm407_1
end type
type dw_relance_sup from datawindow within u_sp_relance_pm407_1
end type
type dw_relance1 from datawindow within u_sp_relance_pm407_1
end type
type gb_prem_rel from groupbox within u_sp_relance_pm407_1
end type
type gb_1 from groupbox within u_sp_relance_pm407_1
end type
type gb_2 from groupbox within u_sp_relance_pm407_1
end type
end forward

global type u_sp_relance_pm407_1 from userobject
integer width = 3141
integer height = 1172
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_creer_sup cb_creer_sup
cb_creer_prem cb_creer_prem
dw_soldage dw_soldage
dw_relance_sup dw_relance_sup
dw_relance1 dw_relance1
gb_prem_rel gb_prem_rel
gb_1 gb_1
gb_2 gb_2
end type
global u_sp_relance_pm407_1 u_sp_relance_pm407_1

type variables
Datawindow idw_DetPro
Decimal idcIdProd
end variables

forward prototypes
public subroutine uf_initialiser (ref datawindow adw_detpro, decimal adcidprod)
public subroutine uf_preparer_valider ()
public function integer uf_controler_relance (string asdata, long alrow, ref datawindow adw_relance, string asnomcolonne)
public function string uf_controler ()
public subroutine uf_set_detpro (long alrow, string ascodecar, string asvalcar, integer aicpttri)
public function boolean uf_terminer_valider ()
end prototypes

public subroutine uf_initialiser (ref datawindow adw_detpro, decimal adcidprod);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_initialiser
//* Auteur			:	FPI	
//* Date				:	24/01/2018
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de l'objet
//* Commentaires	: 
//*
//* Arguments		:	adcIdProd	code produit
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------
Long lDeb, lFin, lRow
n_cst_string nvString
String sValCar, sVal
String sFiltreOri
DataWindow lDwRelance

idw_DetPro=adw_detpro
idcIdProd=adcIdProd

// Init de la fen$$HEX1$$ea00$$ENDHEX$$tre
f_rechdetpro(lDeb, lFin, adw_detpro, adcIdProd,"-DP",323)

// Soldage
dw_soldage.uf_initialisercouleur( {"delai_relance_sold","delai_relance_sold_unite","delai_soldage","delai_soldage_unite"})

dw_soldage.Reset()
dw_soldage.InsertRow(0)
dw_soldage.uf_proteger( {"soldage"}, "0")
	
lRow=idw_DetPro.Find("ID_CODE_CAR='SOLDAG'",lDeb, lFin)

If lRow > 0 Then
	
	dw_soldage.uf_proteger({"delai_relance_sold","delai_relance_sold_unite","delai_soldage","delai_soldage_unite"},"0")
	
	dw_soldage.SetItem( 1, "SOLDAGE","O")
	sValCar=idw_DetPro.GetItemString(lRow,"VAL_CAR")
	
	sVal=nvString.of_getkeyvalue( sValCar, "UNITE_DEL_SOLD_DERN_REL", ";")
	dw_soldage.SetItem(1,"delai_relance_sold_unite",sVal)
	
	sVal=nvString.of_getkeyvalue( sValCar, "DEL_SOLD_DERN_REL", ";")
	dw_soldage.SetItem(1,"delai_relance_sold",Long(sVal))
	
	sVal=nvString.of_getkeyvalue( sValCar, "UNITE_DEL_SOLD_OBLIG", ";")
	dw_soldage.SetItem(1,"delai_soldage_unite",sVal)
	
	sVal=nvString.of_getkeyvalue( sValCar, "DEL_SOLD_OBLIG", ";")
	dw_soldage.SetItem(1,"delai_soldage",Long(sVal)	)
Else
	dw_soldage.SetItem( 1, "SOLDAGE","N")
	dw_soldage.uf_proteger({"delai_relance_sold","delai_relance_sold_unite","delai_soldage","delai_soldage_unite"},"1")
End if

// Relances
dw_relance1.Reset()
dw_relance_sup.Reset()

cb_creer_sup.Enabled=FALSE
cb_creer_prem.Enabled=TRUE

sFiltreOri = idw_DetPro.Describe ( "datawindow.table.filter" )
if sFiltreOri = "?" then sFiltreOri = ""

idw_DetPro.SetFilter("ID_CODE_CAR='RELANC' AND ID_CODE_DP=323")
idw_DetPro.Filter()
adw_detpro.Sort ()


 For lRow=1 To idw_detpro.RowCount()
	sValCar=idw_DetPro.GetItemString(lRow,"VAL_CAR")

	If lRow=1 Then 
		lDwRelance=dw_relance1
		
		dw_relance1.InsertRow(0)
		
		sVal=nvString.of_getkeyvalue( sValCar, "DEL_REL_MIN", ";")
		dw_relance1.SetItem(1,"delai_min",Long(sVal)	)
		sVal=nvString.of_getkeyvalue( sValCar, "DEL_REL_MAX", ";")
		dw_relance1.SetItem(1,"delai_max",Long(sVal))

		cb_creer_sup.Enabled=TRUE
		cb_creer_prem.Enabled=FALSE
	Else
		lDwRelance=dw_relance_sup
		dw_relance_sup.InsertRow(0)
		sVal=nvString.of_getkeyvalue( sValCar, "DEL_REL", ";")
		dw_relance_sup.SetItem(lRow - 1,"delai_max",Long(sVal))			
	End if
	
	sVal=nvString.of_getkeyvalue( sValCar, "ID_REL", ";")
	lDwRelance.SetItem(lDwRelance.RowCount(),"id_relance",Long(sVal))	
		
	sVal=nvString.of_getkeyvalue( sValCar, "UNITE_DEL", ";")
	lDwRelance.SetItem(lDwRelance.RowCount(),"delai_unt",sVal)

	sVal=nvString.of_getkeyvalue( sValCar, "ENV_RECOM", ";")
	lDwRelance.SetItem(lDwRelance.RowCount(),"envoi_reco",sVal)

	sVal=nvString.of_getkeyvalue( sValCar, "ENV_MAIL", ";")
	lDwRelance.SetItem(lDwRelance.RowCount(),"envoi_mail",sVal)
	
	sVal=nvString.of_getkeyvalue( sValCar, "JOINDRE_ORIG", ";")
	lDwRelance.SetItem(lDwRelance.RowCount(),"joindre",sVal)
 Next
 
idw_DetPro.SetFilter(sFiltreOri)
idw_DetPro.Filter()
adw_detpro.Sort ()

dw_relance1.Sort()
dw_relance_sup.Sort()

// Si pr$$HEX1$$e900$$ENDHEX$$sence de l$$HEX1$$1920$$ENDHEX$$option 309 sur le produit, alors aucune relance ne peut $$HEX1$$ea00$$ENDHEX$$tre param$$HEX1$$e800$$ENDHEX$$tr$$HEX2$$e9002000$$ENDHEX$$sur le DP/323 ni sur la table produit.
f_rechdetpro(lDeb, lFin, adw_detpro, adcIdProd,"-DP",309)

if lDeb > 0 Then
	dw_relance1.Reset()
	dw_relance_sup.Reset()
	
	cb_creer_sup.Enabled=FALSE
	cb_creer_prem.Enabled=FALSE
End if

// Si pr$$HEX1$$e900$$ENDHEX$$sence de l$$HEX1$$1920$$ENDHEX$$option 244 sur le produit, alors aucun soldage ne peut $$HEX1$$ea00$$ENDHEX$$tre param$$HEX1$$e800$$ENDHEX$$tr$$HEX2$$e9002000$$ENDHEX$$sur le DP/323 ni sur la table produit.
f_rechdetpro(lDeb, lFin, adw_detpro, adcIdProd,"-DP",244)

if lDeb > 0 Then
	
	dw_soldage.Reset()
	dw_soldage.InsertRow(0)
	
	dw_soldage.uf_proteger( {"soldage"}, "1")
	
	dw_soldage.SetItem( 1, "SOLDAGE","N")
	dw_soldage.uf_proteger({"delai_relance_sold","delai_relance_sold_unite","delai_soldage","delai_soldage_unite"},"1")
End if


end subroutine

public subroutine uf_preparer_valider ();Long lDeb, lFin, lLastRelance, lRow
String sValCar, sFiltreOri

// Soldage
lDeb=idw_detpro.Find("id_code_dp=323 and id_code_car='SOLDAG' and id_prod=" + string(idcIdProd),1,idw_detpro.RowCount())

if dw_soldage.GetItemString( 1, "SOLDAGE") = "N" Then
	if lDeb > 0 Then idw_detpro.DeleteRow(lDeb)
Else
		sValCar="UNITE_DEL_SOLD_DERN_REL=" + dw_soldage.GetItemString(1,"delai_relance_sold_unite")
		sValCar+=";DEL_SOLD_DERN_REL=" + string(dw_soldage.GetItemNumber(1,"delai_relance_sold"))
		sValCar+=";UNITE_DEL_SOLD_OBLIG=" + dw_soldage.GetItemString(1,"delai_soldage_unite")
		sValCar+=";DEL_SOLD_OBLIG=" + string(dw_soldage.GetItemNumber(1,"delai_soldage"))
		
		uf_set_detpro (lDeb,"SOLDAG",sValCar,1)
End if	
		
// Relances
lLastRelance=0

sFiltreOri = idw_DetPro.Describe ( "datawindow.table.filter" )
if sFiltreOri = "?" then sFiltreOri = ""

idw_DetPro.SetFilter("ID_CODE_CAR='RELANC' AND ID_CODE_DP=323")
idw_DetPro.Filter()

if dw_relance1.RowCount()=1 Then
	sValCar="ID_REL=1;UNITE_DEL=" + dw_relance1.GetItemString(1,"delai_unt")
	sValCar+=";DEL_REL_MIN=" + string(dw_relance1.GetItemNumber(1,"delai_min"))
	sValCar+=";DEL_REL_MAX=" + string(dw_relance1.GetItemNumber(1,"delai_max"))
	sValCar+=";ENV_RECOM=" + dw_relance1.GetItemString(1,"envoi_reco")
	sValCar+=";ENV_MAIL=" + dw_relance1.GetItemString(1,"envoi_mail")
	sValCar+=";JOINDRE_ORIG=" + dw_relance1.GetItemString(1,"joindre")
	
	if dw_relance_sup.RowCount() > 0 Then
		sValCar+=";DERN_REL=NON"
	Else
		sValCar+=";DERN_REL=OUI"
	End if
	
	if idw_DetPro.RowCount()=0 Then
		uf_set_detpro (0,"RELANC",sValCar,1)
	Else
		uf_set_detpro (1,"RELANC",sValCar,1)
	End if

	lLastRelance=1
	
	if dw_relance_sup.RowCount() > 0 Then
		For lRow=1 To dw_relance_sup.RowCount()  
			lLastRelance+=1
			
			sValCar="ID_REL=" + string(lLastRelance)
			sValCar+=";UNITE_DEL=" + dw_relance_sup.GetItemString(lRow,"delai_unt")
			sValCar+=";DEL_REL=" + string(dw_relance_sup.GetItemNumber(lRow,"delai_max"))
			sValCar+=";ENV_RECOM=" + dw_relance_sup.GetItemString(lRow,"envoi_reco")
			sValCar+=";ENV_MAIL=" + dw_relance_sup.GetItemString(lRow,"envoi_mail")
			sValCar+=";JOINDRE_ORIG=" + dw_relance_sup.GetItemString(lRow,"joindre")
			
			if dw_relance_sup.RowCount() =lRow Then
				sValCar+=";DERN_REL=OUI"
			Else
				sValCar+=";DERN_REL=NON"
			End if
			
			lDeb=idw_detpro.Find("TRI=" + string(lLastRelance),1,idw_detpro.RowCount())
			
			uf_set_detpro (lDeb,"RELANC",sValCar,lLastRelance)
		Next
	End if
End if


// On supprime les relances en trop
For lDeb=idw_DetPro.RowCount() to lLastRelance + 1 step -1
	idw_DetPro.DeleteRow(lDeb)
Next

idw_DetPro.SetFilter(sFiltreOri)
idw_DetPro.Filter()


end subroutine

public function integer uf_controler_relance (string asdata, long alrow, ref datawindow adw_relance, string asnomcolonne);Long lRet=0
Long lVal

stMessage.sTitre		= "Param$$HEX1$$e900$$ENDHEX$$trage des relances"
stMessage.bErreurG	= False

Choose Case Lower(asnomColonne)
	Case "envoi_mail" 
		If asData="OUI" Then
			adw_relance.SetItem(alRow,"envoi_reco","NON")
		End if
	Case "envoi_reco"
		stMessage.bouton=YesNo!
		
		If asData="OUI" Then
			stMessage.icon			= Exclamation!
			stMessage.scode="RELA071"
			
			if f_message(stMessage) <> 1 Then 
				lRet=2
			Else
				adw_relance.SetItem(alRow,"envoi_mail","NON")
			End if
		Else
			stMessage.Icon			= Information!
			stMessage.scode="RELA072"
			
			if f_message(stMessage) = 1 Then 
				adw_relance.SetItem(alRow,"envoi_mail","OUI")
			End if
		End if	
	Case "delai_min"
		if Long(asData) <= 0 Then 
				stMessage.bouton=OK!
				stMessage.icon			= Exclamation!
				stMessage.scode="RELA010"
				
				f_message(stMessage)
				lRet=2
		End if
		
		if lRet= 0 Then
			lVal=adw_relance.GetItemNumber(1,"delai_max")
			if not isnull(lVal) and lVal <= long(asData) Then
				stMessage.bouton=OK!
				stMessage.icon			= Exclamation!
				stMessage.scode="RELA075"
				
				f_message(stMessage)
				lRet=2
			End if
		End if			

	Case "delai_max"
		if Long(asData) <= 0 Then 
				stMessage.bouton=OK!
				stMessage.icon			= Exclamation!
				stMessage.scode="RELA010"
				
				f_message(stMessage)
				lRet=2
		End if
		
		if lRet= 0 And lower(adw_relance.DataObject) = "d_sp_prem_relance" Then
			lVal=adw_relance.GetItemNumber(1,"delai_min")
			if not isnull(lVal) and lVal >= long(asData) Then
				stMessage.bouton=OK!
				stMessage.icon			= Exclamation!
				stMessage.scode="RELA030"
				
				f_message(stMessage)
				lRet=2
			End if
		End if			
		
End Choose

Return lRet

end function

public function string uf_controler ();String sPos, sText, sCol
DataWindow dw
Long lRow

sCol=""

// Relances
If dw_relance1.AcceptText() <> 1 Then return "dw_relance1.delai_min"

if dw_relance1.RowCount()=1 Then
	If isNull(dw_relance1.GetItemString(1,"delai_unt")) Then
		sText+=" - l'unit$$HEX2$$e9002000$$ENDHEX$$de d$$HEX1$$e900$$ENDHEX$$lai de la premi$$HEX1$$e800$$ENDHEX$$re relance~n"
		sCol="dw_relance1.delai_unt"
	End if
	If isNull(dw_relance1.GetItemNumber(1,"delai_min")) Then
		sText+=" - le d$$HEX1$$e900$$ENDHEX$$lai minimum de la premi$$HEX1$$e800$$ENDHEX$$re relance~n"
		sCol="dw_relance1.delai_min"
	Else
		If dw_relance1.GetItemNumber(1,"delai_min") <=0 Then
				sText+=" - le d$$HEX1$$e900$$ENDHEX$$lai minimum de la premi$$HEX1$$e800$$ENDHEX$$re relance~n"
				sCol="dw_relance1.delai_min"
		End if
	End if

	If isNull(dw_relance1.GetItemNumber(1,"delai_max")) Then
		sText+=" - le d$$HEX1$$e900$$ENDHEX$$lai maximum de la premi$$HEX1$$e800$$ENDHEX$$re relance~n"
		sCol="dw_relance1.delai_max"
	Else
		If dw_relance1.GetItemNumber(1,"delai_max") <=0 Then
				sText+=" - le d$$HEX1$$e900$$ENDHEX$$lai maximum de la premi$$HEX1$$e800$$ENDHEX$$re relance~n"
				sCol="dw_relance1.delai_max"
		End if
	End if
End if

If  dw_relance_sup.AcceptText() <> 1 Then return "dw_relance_sup.delai_max"

if sCol="" Then
	For lRow=1 To dw_relance_sup.RowCount()
		If isNull(dw_relance_sup.GetItemString(lRow,"delai_unt")) Then
			sText+=" - l'unit$$HEX2$$e9002000$$ENDHEX$$de d$$HEX1$$e900$$ENDHEX$$lai de la relance~n"
			sCol="dw_relance_sup.delai_unt"
		End if
		If isNull(dw_relance_sup.GetItemNumber(lRow,"delai_max")) Then
			sText+=" - le d$$HEX1$$e900$$ENDHEX$$lai maximum de la relance~n"
			sCol="dw_relance_sup.delai_max"
		Else 
			If dw_relance_sup.GetItemNumber(lRow,"delai_max") <=0 Then
				sText+=" - le d$$HEX1$$e900$$ENDHEX$$lai maximum de la relance~n"
				sCol="dw_relance_sup.delai_max"
			End if
		End if
		
		if sCol <> "" Then exit 
	Next
End if

If  dw_soldage.AcceptText() <> 1 Then return "dw_soldage.soldage"

if sCol="" Then
		If  dw_soldage.GetItemString(1,"soldage") = "O" Then
				If isNull(dw_soldage.GetItemNumber(1,"delai_soldage")) Then
					sText+=" - le d$$HEX1$$e900$$ENDHEX$$lai minimum de soldage~n"
					sCol="dw_soldage.delai_soldage"
				Else
					If dw_soldage.GetItemNumber(1,"delai_soldage") <=0 Then
							sText+=" - le d$$HEX1$$e900$$ENDHEX$$lai minimum de soldage~n"
							sCol="dw_soldage.delai_soldage"
					End if
				End if
				
				If isNull(dw_soldage.GetItemNumber(1,"delai_relance_sold")) Then
					dw_soldage.SetItem(1,"delai_relance_sold",0)
				End if

				If dw_soldage.GetItemNumber(1,"delai_relance_sold")=0 Then
					dw_soldage.SetItem(1,"delai_relance_sold_unite","J")
				End if

				If isNull(dw_soldage.GetItemString(1,"delai_soldage_unite")) Then
					sText+=" - l'unit$$HEX2$$e9002000$$ENDHEX$$de d$$HEX1$$e900$$ENDHEX$$lai minimum de soldage~n"
					sCol="dw_soldage.delai_soldage_unite"
				End if
		End if
End if

if sCol <> "" Then 

	stMessage.sTitre	= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des relances"
	stMessage.Icon		= Information!
	stMessage.sVar[1] = "~n" + sText
	stMessage.sCode	= "GENE001"
	f_Message ( stMessage )
	
End If


Return sCol

end function

public subroutine uf_set_detpro (long alrow, string ascodecar, string asvalcar, integer aicpttri);if alRow=0 Then
	alRow=idw_detpro.InsertRow(0)
	idw_detpro.SetItem(alRow,"ID_PROD", idcIdProd)
	idw_detpro.SetItem(alRow,"ID_CODE_DP", 323)
	idw_detpro.SetItem(alRow,"ID_TYP_CALC", "-XX")
	idw_detpro.SetItem(alRow,"ID_TYP_CODE_DP", "-DP")
	idw_detpro.SetItem(alRow,"ID_CODE_NUM", -1)
	idw_detpro.SetItem(alRow,"ID_CODE_CAR", asCodeCar)
	idw_detpro.SetItem(alRow,"VAL_NUM", -1)
	idw_detpro.SetItem(alRow,"UNT", "X")
	idw_detpro.SetItem(alRow,"TRI",aicpttri)
	idw_detpro.SetItem(alRow,"VAL_CAR2", "")
	f_creele(idw_detpro,alRow)
End if
		
idw_detpro.SetItem(alRow,"VAL_CAR", asValcar)
f_majpar(idw_detpro,alRow)
end subroutine

public function boolean uf_terminer_valider ();//*-----------------------------------------------------------------
//*
//* Fonction		:	Uf_TerminerValider ()
//* Auteur			:	FPI
//* Date				:	29/01/2018
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	:	Update les Datawindows : det_pro
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Boolean : True la validation peut se poursuivre.
//*
//*-----------------------------------------------------------------
Boolean		bRet = True		// Valeur de retour de la fonction

idw_detpro.SaveAs("c:\temp\toto.csv",CSV!	,true)

If ( idw_detpro.Update () = -1 ) Then bRet = False

Return ( bRet )

end function

on u_sp_relance_pm407_1.create
this.cb_creer_sup=create cb_creer_sup
this.cb_creer_prem=create cb_creer_prem
this.dw_soldage=create dw_soldage
this.dw_relance_sup=create dw_relance_sup
this.dw_relance1=create dw_relance1
this.gb_prem_rel=create gb_prem_rel
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.cb_creer_sup,&
this.cb_creer_prem,&
this.dw_soldage,&
this.dw_relance_sup,&
this.dw_relance1,&
this.gb_prem_rel,&
this.gb_1,&
this.gb_2}
end on

on u_sp_relance_pm407_1.destroy
destroy(this.cb_creer_sup)
destroy(this.cb_creer_prem)
destroy(this.dw_soldage)
destroy(this.dw_relance_sup)
destroy(this.dw_relance1)
destroy(this.gb_prem_rel)
destroy(this.gb_1)
destroy(this.gb_2)
end on

type cb_creer_sup from commandbutton within u_sp_relance_pm407_1
integer x = 82
integer y = 412
integer width = 201
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cr$$HEX2$$e900e900$$ENDHEX$$r"
end type

event clicked;dw_relance_sup.InsertRow(0)
dw_relance_sup.SetItem( dw_relance_sup.RowCount(), "id_relance",dw_relance_sup.RowCount() +1)
end event

type cb_creer_prem from commandbutton within u_sp_relance_pm407_1
integer x = 82
integer y = 80
integer width = 201
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cr$$HEX2$$e900e900$$ENDHEX$$r"
end type

event clicked;dw_relance1.InsertRow(0)

dw_relance1.SetItem( 1, "id_relance",1)

This.Enabled=FALSE
cb_creer_sup.Enabled=TRUE
end event

type dw_soldage from u_datawindow_detail within u_sp_relance_pm407_1
integer x = 59
integer y = 836
integer width = 3003
integer height = 260
integer taborder = 20
string title = "none"
string dataobject = "d_sp_param_soldage"
boolean border = false
borderstyle borderstyle = stylelowered!
end type

event itemchanged;call super::itemchanged;Long lRet=0

stMessage.berreurg=FALSE
stMessage.sTitre="Param$$HEX1$$e900$$ENDHEX$$trage des relances"
stMessage.bouton=OK!
stMessage.icon			= Exclamation!
		

Choose Case lower(dwo.name)
	Case "soldage" 
		If data="O"  Then
			dw_soldage.uf_proteger({"delai_relance_sold","delai_relance_sold_unite","delai_soldage","delai_soldage_unite"},"0")
		Else
			dw_soldage.uf_proteger({"delai_relance_sold","delai_relance_sold_unite","delai_soldage","delai_soldage_unite"},"1")
		End if
	Case "delai_relance_sold"
		if Long(data) < 0 Then 
				stMessage.scode="RELA015"
				f_message(stMessage)
				lRet=2
		End if
		
	Case "delai_soldage"
		if Long(data) <= 0 Then 
				stMessage.scode="RELA010"
				f_message(stMessage)
				lRet=2
		Else
			if not isnull(This.GetItemNumber(1,"delai_relance_sold")) Then
				If Long(data) <= This.GetItemNumber(1,"delai_relance_sold") Then
					stMessage.scode="RELA060"
					f_message(stMessage)
					lRet=2
				End if
			End if
		End if

End Choose

Return lRet
end event

event itemerror;call super::itemerror;RETURN 1
end event

event rbuttondown;Return 0
end event

type dw_relance_sup from datawindow within u_sp_relance_pm407_1
integer x = 352
integer y = 400
integer width = 2738
integer height = 372
integer taborder = 10
string title = "none"
string dataobject = "d_sp_relance_suppl"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;Return uf_controler_relance(data, row, dw_relance_sup, dwo.Name)
end event

event buttonclicked;Long lRow

If Lower(dwo.name) = "b_suppr" Then
	stMessage.sTitre		= "Param$$HEX1$$e900$$ENDHEX$$trage des relances"
	stMessage.bErreurG	= False
	stMessage.bouton=YesNo!
		
	stMessage.icon			= Exclamation!
	stMessage.scode="RELA074"
	
	if f_message(stMessage) = 1 Then

		This.AcceptText()
		
		For lRow=This.RowCount() to row Step -1
			This.DeleteRow(lRow)
		Next
	End if
End if
end event

event itemerror;RETURN 1
end event

type dw_relance1 from datawindow within u_sp_relance_pm407_1
integer x = 352
integer y = 72
integer width = 2670
integer height = 216
integer taborder = 10
string title = "none"
string dataobject = "d_sp_prem_relance"
boolean border = false
borderstyle borderstyle = stylelowered!
end type

event itemchanged;Return uf_controler_relance(data, row, dw_relance1, dwo.Name)
end event

event buttonclicked;If Lower(dwo.name) = "b_suppr" Then
	stMessage.sTitre		= "Param$$HEX1$$e900$$ENDHEX$$trage des relances"
	stMessage.bErreurG	= False
	stMessage.bouton=YesNo!
		
	stMessage.icon			= Exclamation!
	stMessage.scode="RELA073"
	
	if f_message(stMessage) = 1 Then
		dw_relance_sup.Reset()
		dw_relance1.Reset()
		
		cb_creer_sup.Enabled=FALSE
		cb_creer_prem.Enabled=TRUE
	End if
End if
end event

event itemerror;
RETURN 1
end event

type gb_prem_rel from groupbox within u_sp_relance_pm407_1
integer x = 46
integer y = 8
integer width = 3054
integer height = 308
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Premi$$HEX1$$e800$$ENDHEX$$re relance"
end type

type gb_1 from groupbox within u_sp_relance_pm407_1
integer x = 46
integer y = 336
integer width = 3054
integer height = 460
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Relances suppl$$HEX1$$e900$$ENDHEX$$mentaires"
end type

type gb_2 from groupbox within u_sp_relance_pm407_1
integer x = 46
integer y = 792
integer width = 3054
integer height = 308
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

