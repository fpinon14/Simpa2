HA$PBExportHeader$w_acc_sp_ifr_consultation.srw
$PBExportComments$Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour consultation $$HEX1$$e900$$ENDHEX$$quivalence fonctionnelle
forward
global type w_acc_sp_ifr_consultation from w_8_accueil
end type
type pb_consulter from picturebutton within w_acc_sp_ifr_consultation
end type
type dw_stk_ifr from datawindow within w_acc_sp_ifr_consultation
end type
type dw_stk_code_equivalence from datawindow within w_acc_sp_ifr_consultation
end type
type dw_trt_choix from u_datawindow within w_acc_sp_ifr_consultation
end type
type st_1 from statictext within w_acc_sp_ifr_consultation
end type
type st_2 from statictext within w_acc_sp_ifr_consultation
end type
type dw_trt_imei from datawindow within w_acc_sp_ifr_consultation
end type
type cb_rech_imei from commandbutton within w_acc_sp_ifr_consultation
end type
type st_msg_imei from statictext within w_acc_sp_ifr_consultation
end type
type ln_1 from line within w_acc_sp_ifr_consultation
end type
type ln_2 from line within w_acc_sp_ifr_consultation
end type
end forward

global type w_acc_sp_ifr_consultation from w_8_accueil
integer width = 3639
integer height = 1928
string title = "Recherche IFR/IMEI"
pb_consulter pb_consulter
dw_stk_ifr dw_stk_ifr
dw_stk_code_equivalence dw_stk_code_equivalence
dw_trt_choix dw_trt_choix
st_1 st_1
st_2 st_2
dw_trt_imei dw_trt_imei
cb_rech_imei cb_rech_imei
st_msg_imei st_msg_imei
ln_1 ln_1
ln_2 ln_2
end type
global w_acc_sp_ifr_consultation w_acc_sp_ifr_consultation

event show;call super::show;// #1 FPI - 13/01/2010 	[20100113.FPI] Ajout de la recherche de modl/marq depuis IMEI

dw_trt_choix.InsertRow (1)

// #1
dw_trt_imei.Reset( )
dw_trt_imei.insertrow( 0)
end event

event open;call super::open;DataWindowChild	dwChild

dw_stk_ifr.SetTransObject (Sqlca)
dw_stk_code_equivalence.SetTransObject (Sqlca)
dw_stk_ifr.Retrieve ()
dw_stk_code_equivalence.Retrieve ()

dw_trt_choix.GetChild ( "MARQUE", dwChild )
dwChild.setTransObject (SqlCa)
dwChild.Retrieve( "MARQUE" )

dw_trt_choix.GetChild ( "REFERENCE", dwChild )
dwChild.setTransObject (SqlCa)
dwChild.Retrieve( "REFERENCE" )




end event

on w_acc_sp_ifr_consultation.create
int iCurrent
call super::create
this.pb_consulter=create pb_consulter
this.dw_stk_ifr=create dw_stk_ifr
this.dw_stk_code_equivalence=create dw_stk_code_equivalence
this.dw_trt_choix=create dw_trt_choix
this.st_1=create st_1
this.st_2=create st_2
this.dw_trt_imei=create dw_trt_imei
this.cb_rech_imei=create cb_rech_imei
this.st_msg_imei=create st_msg_imei
this.ln_1=create ln_1
this.ln_2=create ln_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_consulter
this.Control[iCurrent+2]=this.dw_stk_ifr
this.Control[iCurrent+3]=this.dw_stk_code_equivalence
this.Control[iCurrent+4]=this.dw_trt_choix
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.dw_trt_imei
this.Control[iCurrent+8]=this.cb_rech_imei
this.Control[iCurrent+9]=this.st_msg_imei
this.Control[iCurrent+10]=this.ln_1
this.Control[iCurrent+11]=this.ln_2
end on

on w_acc_sp_ifr_consultation.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_consulter)
destroy(this.dw_stk_ifr)
destroy(this.dw_stk_code_equivalence)
destroy(this.dw_trt_choix)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_trt_imei)
destroy(this.cb_rech_imei)
destroy(this.st_msg_imei)
destroy(this.ln_1)
destroy(this.ln_2)
end on

type cb_debug from w_8_accueil`cb_debug within w_acc_sp_ifr_consultation
end type

type pb_retour from w_8_accueil`pb_retour within w_acc_sp_ifr_consultation
integer x = 73
integer width = 242
integer height = 144
integer taborder = 70
end type

type pb_interro from w_8_accueil`pb_interro within w_acc_sp_ifr_consultation
boolean visible = false
integer width = 242
integer height = 144
integer taborder = 90
end type

type pb_creer from w_8_accueil`pb_creer within w_acc_sp_ifr_consultation
boolean visible = false
integer width = 242
integer height = 144
integer taborder = 80
end type

type dw_1 from w_8_accueil`dw_1 within w_acc_sp_ifr_consultation
integer x = 50
integer y = 1056
integer taborder = 30
end type

type pb_tri from w_8_accueil`pb_tri within w_acc_sp_ifr_consultation
boolean visible = false
integer width = 242
integer height = 144
integer taborder = 100
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_acc_sp_ifr_consultation
integer taborder = 20
end type

type pb_consulter from picturebutton within w_acc_sp_ifr_consultation
integer x = 539
integer y = 756
integer width = 425
integer height = 232
integer taborder = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Equivalence IFR"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\tel4.bmp"
vtextalign vtextalign = top!
end type

on clicked;s_Pass stPass

dw_Trt_choix.AcceptText ()

stPass.sTab   [1] = "CS"
stPass.sTab   [2] = dw_Trt_choix.getitemstring ( 1, "MARQUE"    )
stPass.sTab   [3] = dw_Trt_choix.getitemstring ( 1, "REFERENCE" )
stPass.dwNorm [1] = dw_stk_ifr
stPass.dwNorm [2] = dw_stk_code_equivalence

If Not ( IsNull ( stPass.sTab [2] ) ) And Not ( IsNull ( stPass.sTab [3] ) ) And Trim ( stPass.sTab [2] ) <> "" And Trim ( stPass.sTab [3] ) <> "" Then
	OpenWithParm ( w_Trt_Sp_Ifr_Consultation_Equiv, stPass )
End If 



end on

type dw_stk_ifr from datawindow within w_acc_sp_ifr_consultation
boolean visible = false
integer x = 55
integer y = 1332
integer width = 494
integer height = 360
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_trt_sp_ifr_consult_marge"
boolean livescroll = true
end type

type dw_stk_code_equivalence from datawindow within w_acc_sp_ifr_consultation
boolean visible = false
integer x = 594
integer y = 1340
integer width = 494
integer height = 360
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_lst_code_equivalence"
boolean livescroll = true
end type

type dw_trt_choix from u_datawindow within w_acc_sp_ifr_consultation
integer x = 69
integer y = 392
integer width = 1422
integer height = 316
integer taborder = 10
string dataobject = "d_trt_sp_ifr_consult_choix"
boolean border = false
end type

event itemchanged;call super::itemchanged;//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

DatawindowChild dwChild
String	sMarque

Choose Case UPPER (isNomCol) 

	Case "MARQUE" 

		dw_trt_choix.GetChild ( "MARQUE", dwChild )
	   If dwChild.Find ( "MARQUE = TRIM ( UPPER (' " + This.GetText() + "' ) ) ", 1, dwchild.RowCount () ) <= 0 Then
			This.iiErreur = 1
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
//			Return
			ll_ret = 1
			return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM
		End If

		sMarque = This.GetText()
		dw_trt_choix.GetChild ( "REFERENCE", dwChild  )
		dwChild.SetFilter     ( "MARQUE='" + sMArque + "'" )
		dwChild.Filter        ()

	Case "REFERENCE" 

		dw_trt_choix.GetChild ( "REFERENCE", dwChild )
	   If dwChild.Find ( "REFERENCE = TRIM ( UPPER (' " + This.GetText() + "' ) ) ", 1, dwchild.RowCount () ) <= 0 Then
			This.iiErreur = 1
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
//			Return
			ll_ret = 1
			return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM
		End If

End Choose 

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event itemerror;call super::itemerror;If	ibErreur Then

	stMessage.sTitre		= "Gestion des sinistres - SIMPA2"
	stMessage.Icon			= Information!

	stMessage.bErreurG	= TRUE

	Choose Case isErrCol

	Case "MARQUE"
		Choose Case This.iiErreur
		Case 1
			stMessage.bErreurG	= False
			stMessage.sVar[1] 	= "La marque de l'appareil"
			stMessage.sCode		= "WSIN130"

		End Choose

	Case "REFERENCE"
		Choose Case This.iiErreur
		Case 1
			stMessage.bErreurG	= False
			stMessage.sVar[1] 	= "Le mod$$HEX1$$e800$$ENDHEX$$le de l'appareil"
			stMessage.sCode		= "WSIN131"

		End Choose

	End Choose

	F_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 FM
//	This.Uf_Reinitialiser ()
	return This.Uf_Reinitialiser ()
//Fin Migration PB8-WYNIWYG-03/2006 FM

End If

//Migration PB8-WYNIWYG-03/2006 FM
return AncestorReturnValue
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type st_1 from statictext within w_acc_sp_ifr_consultation
integer x = 315
integer y = 264
integer width = 905
integer height = 64
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Recherche sur base IFR"
boolean focusrectangle = false
end type

type st_2 from statictext within w_acc_sp_ifr_consultation
integer x = 1874
integer y = 264
integer width = 1253
integer height = 64
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Recherche marque et mod$$HEX1$$e800$$ENDHEX$$le par IMEI"
boolean focusrectangle = false
end type

type dw_trt_imei from datawindow within w_acc_sp_ifr_consultation
integer x = 1824
integer y = 384
integer width = 1385
integer height = 484
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_trt_sp_ifr_search_imei"
boolean border = false
boolean livescroll = true
end type

type cb_rech_imei from commandbutton within w_acc_sp_ifr_consultation
integer x = 2322
integer y = 1020
integer width = 462
integer height = 108
integer taborder = 70
boolean bringtotop = true
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
//* Objet			: w_acc_sp_ifr_consultation
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 13/01/2010 15:13:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [20100113.FPI]
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
String sImei, sImeiCorrige
String sMarque, sModele

st_msg_imei.Visible=FALSE
dw_trt_imei.SetItem(1,"MARQUE","")
dw_trt_imei.SetItem(1,"REFERENCE","")

dw_trt_imei.AcceptText()

sImei=dw_trt_imei.GetItemString(1,"IMEI")

if isnull(sImei) or Trim(sImei)="" Then return 0

sImei=Trim(sImei) 

If Len(sImei) <> 15 or not isnumber(sImei) Then
	st_msg_imei.Text = "Le num$$HEX1$$e900$$ENDHEX$$ro d'IMEI doit comporter exactement 15 chiffres."
	st_msg_imei.Visible=TRUE
	Return 0
End if

If not f_imei(sImei, sImeiCorrige) Then
	st_msg_imei.Text = "Le num$$HEX1$$e900$$ENDHEX$$ro d'IMEI est incorrect."
	st_msg_imei.Visible=TRUE
	Return 0
End if

sMarque=Fill(' ',35)
smodele=Fill(' ',35)

SQLCA.PS_s01_tac_imei( Long(Left(sImei,8)) , smarque, smodele)

if sMarque = "" Then
	st_msg_imei.Text = "Marque et mod$$HEX1$$e800$$ENDHEX$$le introuvables."
	st_msg_imei.Visible=TRUE
	Return 0
End if

dw_trt_imei.SetItem(1,"MARQUE",sMarque)
dw_trt_imei.SetItem(1,"REFERENCE",sModele )

end event

type st_msg_imei from statictext within w_acc_sp_ifr_consultation
boolean visible = false
integer x = 1824
integer y = 888
integer width = 1591
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
string text = "Message d~'erreur"
boolean focusrectangle = false
end type

type ln_1 from line within w_acc_sp_ifr_consultation
long linecolor = 8421504
integer linethickness = 4
integer beginx = 1650
integer beginy = 152
integer endx = 1650
integer endy = 1300
end type

type ln_2 from line within w_acc_sp_ifr_consultation
long linecolor = 16777215
integer linethickness = 4
integer beginx = 1655
integer beginy = 152
integer endx = 1655
integer endy = 1300
end type

