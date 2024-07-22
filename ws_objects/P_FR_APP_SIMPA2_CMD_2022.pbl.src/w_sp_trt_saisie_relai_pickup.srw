HA$PBExportHeader$w_sp_trt_saisie_relai_pickup.srw
$PBExportComments$[PM255-1]
forward
global type w_sp_trt_saisie_relai_pickup from window
end type
type st_info from statictext within w_sp_trt_saisie_relai_pickup
end type
type st_aucun_relai from statictext within w_sp_trt_saisie_relai_pickup
end type
type cb_rechercher from commandbutton within w_sp_trt_saisie_relai_pickup
end type
type dw_1 from u_datawindow within w_sp_trt_saisie_relai_pickup
end type
type cb_retour from commandbutton within w_sp_trt_saisie_relai_pickup
end type
type cb_valider from commandbutton within w_sp_trt_saisie_relai_pickup
end type
type dw_lst_relais from u_datawindow within w_sp_trt_saisie_relai_pickup
end type
end forward

global type w_sp_trt_saisie_relai_pickup from window
integer width = 4727
integer height = 2304
boolean titlebar = true
string title = "Saisie relais pickup"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_info st_info
st_aucun_relai st_aucun_relai
cb_rechercher cb_rechercher
dw_1 dw_1
cb_retour cb_retour
cb_valider cb_valider
dw_lst_relais dw_lst_relais
end type
global w_sp_trt_saisie_relai_pickup w_sp_trt_saisie_relai_pickup

type variables
private:

String isRetour

chrono_pointchr listePointsChronopost[]

Long ilRowSelected

st_point_relai_chronopost relai
end variables

forward prototypes
public subroutine wf_fill_liste_pr ()
public function string wf_epure_car_speciaux (string asval)
end prototypes

public subroutine wf_fill_liste_pr ();Long lRow
Long lDate
Long lJour
Long lNbrePointsChronopost
String sHoraires

lNbrePointsChronopost = UpperBound(listepointschronopost)

If isNull(listepointschronopost) Then return

If lNbrePointsChronopost > 2 Then 
	st_info.Text = String ( lNbrePointsChronopost ) + " relais pickup disponibles, utilisez l'ascenseur ou la molette de la souris."
	st_info.Show()
End IF 


For lRow=1 To lNbrePointsChronopost 
	dw_lst_relais.InsertRow(0)
	
	dw_lst_relais.SetItem(lRow,"identifiantchronopost", listepointschronopost[lRow].identifiant)
	dw_lst_relais.SetItem(lRow,"nomenseigne", listepointschronopost[lRow].nom)
	dw_lst_relais.SetItem(lRow,"adresse1", listepointschronopost[lRow].adresse1)
	dw_lst_relais.SetItem(lRow,"adresse2", listepointschronopost[lRow].adresse2)
	dw_lst_relais.SetItem(lRow,"adresse3", listepointschronopost[lRow].adresse3)
	dw_lst_relais.SetItem(lRow,"codepostal", listepointschronopost[lRow].codepostal)
	dw_lst_relais.SetItem(lRow,"localite", listepointschronopost[lRow].localite)
	
	If not isNull(listepointschronopost[lRow].listehoraireouverture ) Then
		For lDate=1 To UpperBound(listepointschronopost[lRow].listehoraireouverture)

			lJour= listepointschronopost[lRow].listehoraireouverture[lDate].jour
			sHoraires = listepointschronopost[lRow].listehoraireouverture[lDate].horairesasstring

			Choose Case lJour
				Case 1
					dw_lst_relais.SetItem(lRow,"horaireslundi", sHoraires)
				Case 2
					dw_lst_relais.SetItem(lRow,"horairesmardi", sHoraires)
				Case 3
					dw_lst_relais.SetItem(lRow,"horairesmercredi", sHoraires)
				Case 4
					dw_lst_relais.SetItem(lRow,"horairesjeudi", sHoraires)
				Case 5
					dw_lst_relais.SetItem(lRow,"horairesvendredi", sHoraires)
				Case 6
					dw_lst_relais.SetItem(lRow,"horairessamedi", sHoraires)
				Case 7
					dw_lst_relais.SetItem(lRow,"horairesdimanche", sHoraires)
					
			End Choose
		Next
	End if
	
Next
end subroutine

public function string wf_epure_car_speciaux (string asval);//* 		FPI	20/01/2017	[EPURE_PT_RELAI]
string sCarSpeciaux,sCarRemplace
int i

sCarSpeciaux="$$HEX65$$e000e800ec00f200f900c000c800cc00d200d9002000e400eb00ef00f600fc00c400cb00cf00d600dc002000e200ea00ee00f400fb00c200ca00ce00d400db002000e100e900ed00f300fa00c100c900cd00d300da00f000d000fd00dd002000e300f100f500c300d100d500610160017e017d01e700c700e500c500f800d8002000$$ENDHEX$$*'^$$HEX3$$a300a800b000$$ENDHEX$$\/.-"
sCarRemplace="aeiouAEIOU aeiouAEIOU aeiouAEIOU aeiouAEIOUdDyY anoANOsSzZcCaAoO           "

If isnull(asVal) Then 
	return asVal
End if

If Len(trim(asVal)) = 0 Then 
	return asVal
End if

For i=1 to Len(sCarSpeciaux)
	asVal=f_remplace(asVal, Mid(sCarSpeciaux,i,1),Mid(sCarRemplace,i,1))
Next

Return asVal

end function

event open;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_boutiques
//* Evenement 		: open
//* Auteur			: F. Pinon
//* Date				: 14/02/2012
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
//* 	FPI	13/05/2013	[PC938]
//		FPI	18/07/2013	[PM200_5]
//*-----------------------------------------------------------------
s_pass stPass
String sTitre

ilRowSelected=0

dw_1.InsertRow(0)

cb_valider.enabled = False
st_info.Hide ()

If isvalid(Message.PowerObjectParm) Then
	relai=Message.PowerObjectParm
	
	dw_1.setitem(1,"nom",relai.nomassure)
	dw_1.setitem(1,"prenom",relai.prenomassure)
	dw_1.setitem(1,"adresse1",relai.adresse1)
	dw_1.setitem(1,"adresse2",relai.adresse2)
	dw_1.setitem(1,"adresse3",relai.adresse3)
	dw_1.setitem(1,"code_postal",relai.codepostal )
	dw_1.setitem(1,"ville",relai.ville )
	
	relai.returncode="[RETOUR]"
	
	cb_rechercher.event clicked( )
	
End if




end event

event close;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_boutiques
//* Evenement 		: close
//* Auteur			: F. Pinon
//* Date				: 14/02/2012
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

CloseWithReturn(This, relai)
end event

on w_sp_trt_saisie_relai_pickup.create
this.st_info=create st_info
this.st_aucun_relai=create st_aucun_relai
this.cb_rechercher=create cb_rechercher
this.dw_1=create dw_1
this.cb_retour=create cb_retour
this.cb_valider=create cb_valider
this.dw_lst_relais=create dw_lst_relais
this.Control[]={this.st_info,&
this.st_aucun_relai,&
this.cb_rechercher,&
this.dw_1,&
this.cb_retour,&
this.cb_valider,&
this.dw_lst_relais}
end on

on w_sp_trt_saisie_relai_pickup.destroy
destroy(this.st_info)
destroy(this.st_aucun_relai)
destroy(this.cb_rechercher)
destroy(this.dw_1)
destroy(this.cb_retour)
destroy(this.cb_valider)
destroy(this.dw_lst_relais)
end on

type st_info from statictext within w_sp_trt_saisie_relai_pickup
integer x = 2999
integer y = 2052
integer width = 1623
integer height = 140
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388736
long backcolor = 67108864
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type st_aucun_relai from statictext within w_sp_trt_saisie_relai_pickup
boolean visible = false
integer x = 1714
integer y = 1032
integer width = 1266
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Aucun relais boutique trouv$$HEX2$$e9002000$$ENDHEX$$pour cette adresse"
boolean focusrectangle = false
end type

type cb_rechercher from commandbutton within w_sp_trt_saisie_relai_pickup
integer x = 2181
integer y = 228
integer width = 407
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Rechercher"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_boutiques
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 14/02/2012 11:28:57
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

Long lRet
n_cst_sp_ws_chronopost_caller uoWsCaller
string sadresse, scodepostal, sville
chrono_pointchr emptyList[]

ilRowSelected=0

st_aucun_relai.Visible=FALSE

uoWsCaller=CREATE n_cst_sp_ws_chronopost_caller

dw_1.accepttext( )

sAdresse=dw_1.GetItemString(1,"adresse1")
sCodePostal=dw_1.GetItemString(1,"code_postal")
sVille=dw_1.GetItemString(1,"ville")

if trim(sCodePostal)="" Then SetNull(sCodePostal)
if trim(sVille)="" Then SetNull(sVille)

If isNull(sCodePostal) or isNull(sVille) Then
	stMessage.bErreurG=FALSE
	stMessage.Icon=Information!
	stMessage.Bouton=OK!
	stMessage.sTitre="Saisie relais pickup"
	stMessage.sCode="GENE001"
	stMessage.sVar[1]=""
	
	If isNull(sCodePostal) Then	stMessage.sVar[1]+="- Le code postal~n"
	If isNull(sVille) Then	stMessage.sVar[1]+="- La ville~n"
		
	f_message(stMessage)
	dw_1.SetFocus( )
	Return
End if

If isnull(sAdresse) Then sAdresse=""

listePointsChronopost=emptyList

lRet=uoWsCaller.uf_get_pointrelais( sAdresse, sCodePostal,sVille, listePointsChronopost)

If lRet > 0  Then
	dw_lst_relais.Reset()
	wf_fill_liste_pr()
	
	if dw_lst_relais.RowCount()=0 Then st_aucun_relai.Visible=TRUE
Else
	if lRet < 0 Then
		stMessage.bErreurG=FALSE
		stMessage.Icon=Information!
		stMessage.Bouton=OK!
		stMessage.sTitre="Saisie relais pickup"
		
		/* [MANTIS14084] 29/01/2015 JFF
		Choose case lRet
			Case -1
				// Erreur du WS
				stMessage.sTitre+=" - Erreur du WebService"
			Case -2
				// Pas de r$$HEX1$$e900$$ENDHEX$$ponse
				stMessage.sTitre+=" - R$$HEX1$$e900$$ENDHEX$$ponse WS vide"
			Case -3
				// XML non-conforme
				stMessage.sTitre+=" - Retour WS non-conforme"
			Case -4
				// WS indispo
				stMessage.sTitre+=" - WebService indisponible"
		End Choose
		*/
		
		// [MANTIS14084] 29/01/2015 JFF
		stMessage.sTitre+= " - Retour WS " + String ( lRet )
		
		stMessage.sCode="COMD867"
				
		f_message(stMessage)
		
		Close(Parent)
	End if
End if

destroy uoWsCaller

end event

type dw_1 from u_datawindow within w_sp_trt_saisie_relai_pickup
integer x = 37
integer y = 32
integer width = 2089
integer height = 472
integer taborder = 10
string dataobject = "d_trt_saisie_adresse"
boolean border = false
end type

event itemchanged;call super::itemchanged;If Upper(dwo.Name)="CODE_POSTAL" Then
	If data <> "" Then
		This.SetItem(row, dwo.Name,Right("00000" + data ,5))
		Return 2
	End if
End if
end event

type cb_retour from commandbutton within w_sp_trt_saisie_relai_pickup
integer x = 1819
integer y = 2064
integer width = 466
integer height = 112
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Abandonner"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_relai_pickup
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 09/04/2014
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
Integer iRet
chrono_pointchr relaiNull

If ilRowSelected > 0 Then
	stMessage.bErreurG=FALSE
	stMessage.Icon=Information!
	stMessage.Bouton=YesNo!
	stMessage.sTitre="Saisie relais pickup"
	stMessage.sCode="GENE013"
	stMessage.sVar[1]="Une boutique est coch$$HEX1$$e900$$ENDHEX$$e, souhaitez-vous vraiment faire Retour ? ~n"
		
	iRet=f_message(stMessage)
	
	If iRet=2 Then return
End if

ilRowSelected=0
relai.pointrelais=relaiNull
relai.returncode="[RETOUR]"

Close(Parent)
end event

type cb_valider from commandbutton within w_sp_trt_saisie_relai_pickup
integer x = 2354
integer y = 2064
integer width = 466
integer height = 112
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Valider"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_relai_pickup
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 09/04/2014
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
//* 		FPI	20/01/2017	[EPURE_PT_RELAI]
//*-----------------------------------------------------------------
String sListeBoutiques
Integer iLig

sListeBoutiques=""

ilrowselected = dw_lst_relais.GetSelectedRow ( 0 )

If dw_lst_relais.Rowcount( ) =0 or ilrowselected=0 Then
	stMessage.bErreurG=FALSE
	stMessage.Icon=Information!
	stMessage.Bouton=OK!
	stMessage.sTitre="Saisie relais pickup"
	stMessage.sCode="GENE001"
	stMessage.sVar[1]="Un relais pickup~n"
		
	f_message(stMessage)
	dw_lst_relais.SetFocus( )
	
	//cb_retour.event clicked( )
	Return
End if

relai.pointrelais=listePointsChronopost[ilrowselected]

relai.pointrelais.adresse1=wf_epure_car_speciaux(relai.pointrelais.adresse1)
relai.pointrelais.adresse2=wf_epure_car_speciaux(relai.pointrelais.adresse2)
relai.pointrelais.adresse3=wf_epure_car_speciaux(relai.pointrelais.adresse3)
relai.pointrelais.nom=wf_epure_car_speciaux(relai.pointrelais.nom)

relai.returncode="[VALIDER]"

Close(Parent)
end event

type dw_lst_relais from u_datawindow within w_sp_trt_saisie_relai_pickup
integer x = 37
integer y = 520
integer width = 4594
integer height = 1524
integer taborder = 10
string dataobject = "d_lst_relais_pickup"
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "AppIcon!"
boolean livescroll = false
borderstyle borderstyle = stylelowered!
end type

event itemchanged;call super::itemchanged;
if Upper(dwo.Name) = "ALT_SELECTED" Then
	If row > 0 Then 
		If ilRowSelected > 0 Then 
			This.SetItem(ilRowselected,"ALT_SELECTED","N")
		End if
		ilRowSelected=row
	End if
End if
end event

event constructor;call super::constructor;ibMenuActif=FALSE
end event

event rbuttondown;// OVERRIDE
end event

event clicked;call super::clicked;
Int iRowSelected

		
This.SelectRow ( 0, False)

If row > 0 Then 
	
	iRowSelected = This.GetSelectedRow ( row - 1 ) 
	
	If iRowSelected = row Then
		This.SelectRow ( row, False )
	Else 
		This.SelectRow ( row, True )
		This.SetRow ( row )
	End If 
	
	cb_valider.enabled = This.GetSelectedRow ( 0 ) > 0 
	
End IF 
end event

