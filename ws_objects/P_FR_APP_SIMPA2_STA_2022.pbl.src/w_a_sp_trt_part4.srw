HA$PBExportHeader$w_a_sp_trt_part4.srw
$PBExportComments$--- } Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement particuliers 1 : Stat des nbre de motif de refus.
forward
global type w_a_sp_trt_part4 from w_8_accueil
end type
type st_2 from statictext within w_a_sp_trt_part4
end type
type uo_dte_deb from u_calendrier_w within w_a_sp_trt_part4
end type
type st_3 from statictext within w_a_sp_trt_part4
end type
type uo_dte_fin from u_calendrier_w within w_a_sp_trt_part4
end type
type st_1 from statictext within w_a_sp_trt_part4
end type
type st_4 from statictext within w_a_sp_trt_part4
end type
type gb_1 from groupbox within w_a_sp_trt_part4
end type
end forward

global type w_a_sp_trt_part4 from w_8_accueil
st_2 st_2
uo_dte_deb uo_dte_deb
st_3 st_3
uo_dte_fin uo_dte_fin
st_1 st_1
st_4 st_4
gb_1 gb_1
end type
global w_a_sp_trt_part4 w_a_sp_trt_part4

type variables
Private :

String	isRepWin, isRepExcel

String	K_TEMP = "\TEMP\"
String	K_FICSTAT = ".XLS"

end variables

forward prototypes
public function integer wf_lancer ()
public function boolean wf_controlerdate ()
end prototypes

public function integer wf_lancer ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_a_sp_trt_part4::wf_Lancer
//* Auteur        : JCA
//* Date          : 15/11/2007
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Lancement de l'extraction
//*
//* Retourne      : integer
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

String	sDataObj, sNomFic
StaticText  stText
DateTime		dtDeb, dtFin
Date			dDeb, dFin
Long	lTotRow, lProd

If Not wf_controlerDate () Then Return -1

sDataObj = "d_l_regl_fourn_sinistre"

lProd = 25500

Dw_1.DataObject = sDataObj
Dw_1.SetTransObject ( SQLCA )

dDeb = Date ( uo_Dte_Deb.sle_Affichage.Text )
dFin = Date ( uo_Dte_Fin.sle_Affichage.Text )
dtDeb = DateTime ( dDeb, 00:00:00 )
dtFin = DateTime ( dFin, 23:59:59 )

st_1.Text = "En cours de traitement..."

lTotRow = dw_1.Retrieve (dtDeb, dtFin, lProd ) 

If lTotRow = 0 Then
	st_1.Text = "Aucune donn$$HEX1$$e900$$ENDHEX$$e"
ElseIf lTotRow < 0 Then
	st_1.Text = "ERREUR !! (" + String ( lTotRow ) + ")"
Else
	sNomFic = stGlb.sRepTempo + Upper ( sDataObj ) + '_' + string(lProd) + K_FICSTAT 

	If Dw_1.SaveAs ( sNomFic , Excel!, True ) > 0 Then
		st_1.Text  = sNomFic 
		RUN ( isRepExcel + " " + sNomFic  )
	Else
		stText.Text  = "Impossible d'$$HEX1$$e900$$ENDHEX$$crire le fichier"
	End If	

End If

return 0
end function

public function boolean wf_controlerdate ();//*-----------------------------------------------------------------
//*
//* Fonction      : wf_ControlerDate::wf_ControlerDate
//* Auteur        : Fabry JF
//* Date          : 21/10/2002 17:10:07
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le des dates
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

String sVal, sMes
Long lCpt
Boolean	bRet

bRet = True

For lCpt = 1 To 2

	Choose Case lCpt
		Case 1 
			sVal = uo_Dte_Deb.sle_Affichage.Text
			sMes = " de d$$HEX1$$e900$$ENDHEX$$but"
		Case 2
			sVal = uo_Dte_Fin.sle_Affichage.Text				
			sMes = " de fin"
	End Choose

	If Not IsDate ( sVal ) Then

		bRet = False

		stMessage.sTitre  	= "Date invalide"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "GENE002"
		stMessage.sVar[1]		= "date" + sMes
		F_Message ( stMessage )

		Exit

	End If

Next

Return bRet
end function

on w_a_sp_trt_part4.create
int iCurrent
call super::create
this.st_2=create st_2
this.uo_dte_deb=create uo_dte_deb
this.st_3=create st_3
this.uo_dte_fin=create uo_dte_fin
this.st_1=create st_1
this.st_4=create st_4
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.uo_dte_deb
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.uo_dte_fin
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.gb_1
end on

on w_a_sp_trt_part4.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.uo_dte_deb)
destroy(this.st_3)
destroy(this.uo_dte_fin)
destroy(this.st_1)
destroy(this.st_4)
destroy(this.gb_1)
end on

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Fonction      : w_a_sp_trt_part4::ue_initialiser
//* Auteur        : JCA
//* Date          : 15/11/2007
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

//isRepExcel = ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_EXCEL", "" )
isRepExcel = F_GetExcelPath() //[PI037]


end event

type cb_debug from w_8_accueil`cb_debug within w_a_sp_trt_part4
end type

type pb_retour from w_8_accueil`pb_retour within w_a_sp_trt_part4
end type

type pb_interro from w_8_accueil`pb_interro within w_a_sp_trt_part4
boolean visible = false
integer x = 1298
integer y = 24
boolean enabled = false
end type

type pb_creer from w_8_accueil`pb_creer within w_a_sp_trt_part4
integer x = 1733
integer y = 420
string text = "&Lancer"
end type

event pb_creer::clicked;call super::clicked;//*-----------------------------------------------------------------
//*
//* Fonction      : w_a_sp_trt_part4::pb_creer::clicked
//* Auteur        : JCA
//* Date          : 15/11/2007
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Lancement de l'extraction
//*
//* Retourne      : integer
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------


wf_lancer()
end event

type dw_1 from w_8_accueil`dw_1 within w_a_sp_trt_part4
integer x = 160
integer y = 1048
end type

type pb_tri from w_8_accueil`pb_tri within w_a_sp_trt_part4
boolean visible = false
integer x = 722
integer y = 24
boolean enabled = false
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_sp_trt_part4
integer x = 1010
integer y = 24
end type

type st_2 from statictext within w_a_sp_trt_part4
integer x = 695
integer y = 392
integer width = 96
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Du"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_dte_deb from u_calendrier_w within w_a_sp_trt_part4
integer x = 791
integer y = 380
integer height = 96
integer taborder = 40
boolean bringtotop = true
end type

on uo_dte_deb.destroy
call u_calendrier_w::destroy
end on

type st_3 from statictext within w_a_sp_trt_part4
integer x = 695
integer y = 516
integer width = 101
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Au"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_dte_fin from u_calendrier_w within w_a_sp_trt_part4
integer x = 791
integer y = 504
integer height = 96
integer taborder = 50
boolean bringtotop = true
end type

on uo_dte_fin.destroy
call u_calendrier_w::destroy
end on

type st_1 from statictext within w_a_sp_trt_part4
integer x = 261
integer y = 680
integer width = 2016
integer height = 284
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Veuillez choisir les dates avant de lancer la statistique."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_a_sp_trt_part4
integer x = 462
integer y = 244
integer width = 1815
integer height = 108
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "R$$HEX1$$e900$$ENDHEX$$glements adress$$HEX1$$e900$$ENDHEX$$s aux boutiques Mondov$$HEX1$$e900$$ENDHEX$$lo par sinistre"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_a_sp_trt_part4
integer x = 672
integer y = 340
integer width = 1326
integer height = 284
integer taborder = 50
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

