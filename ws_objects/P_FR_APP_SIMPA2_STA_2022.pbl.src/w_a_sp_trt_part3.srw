$PBExportHeader$w_a_sp_trt_part3.srw
$PBExportComments$--- } Fenêtre de traitement particuliers 3 : Stat Hebdo pour SFR MUST (DNT) Temporairement
forward
global type w_a_sp_trt_part3 from w_8_accueil
end type
type st_l_ouv4_tel from statictext within w_a_sp_trt_part3
end type
type st_d_l_reg6_tel from statictext within w_a_sp_trt_part3
end type
type st_d_l_ref3_tel from statictext within w_a_sp_trt_part3
end type
type st_d_l_ref4_tel from statictext within w_a_sp_trt_part3
end type
type st_d_l_enc4_tel from statictext within w_a_sp_trt_part3
end type
type cb_lancer_ouv4 from commandbutton within w_a_sp_trt_part3
end type
type st_trt_ouv4 from statictext within w_a_sp_trt_part3
end type
type cb_lancer_reg6 from commandbutton within w_a_sp_trt_part3
end type
type st_trt_reg6 from statictext within w_a_sp_trt_part3
end type
type cb_lancer_ref3 from commandbutton within w_a_sp_trt_part3
end type
type st_trt_ref3 from statictext within w_a_sp_trt_part3
end type
type cb_lancer_ref4 from commandbutton within w_a_sp_trt_part3
end type
type st_trt_ref4 from statictext within w_a_sp_trt_part3
end type
type cb_lancer_enc4 from commandbutton within w_a_sp_trt_part3
end type
type st_trt_enc4 from statictext within w_a_sp_trt_part3
end type
type st_1 from statictext within w_a_sp_trt_part3
end type
type uo_dte_deb from u_calendrier_w within w_a_sp_trt_part3
end type
type uo_dte_fin from u_calendrier_w within w_a_sp_trt_part3
end type
type st_2 from statictext within w_a_sp_trt_part3
end type
type st_3 from statictext within w_a_sp_trt_part3
end type
type dw_trt from datawindow within w_a_sp_trt_part3
end type
end forward

global type w_a_sp_trt_part3 from w_8_accueil
integer width = 3465
integer height = 2040
st_l_ouv4_tel st_l_ouv4_tel
st_d_l_reg6_tel st_d_l_reg6_tel
st_d_l_ref3_tel st_d_l_ref3_tel
st_d_l_ref4_tel st_d_l_ref4_tel
st_d_l_enc4_tel st_d_l_enc4_tel
cb_lancer_ouv4 cb_lancer_ouv4
st_trt_ouv4 st_trt_ouv4
cb_lancer_reg6 cb_lancer_reg6
st_trt_reg6 st_trt_reg6
cb_lancer_ref3 cb_lancer_ref3
st_trt_ref3 st_trt_ref3
cb_lancer_ref4 cb_lancer_ref4
st_trt_ref4 st_trt_ref4
cb_lancer_enc4 cb_lancer_enc4
st_trt_enc4 st_trt_enc4
st_1 st_1
uo_dte_deb uo_dte_deb
uo_dte_fin uo_dte_fin
st_2 st_2
st_3 st_3
dw_trt dw_trt
end type
global w_a_sp_trt_part3 w_a_sp_trt_part3

type variables
Private :

String	isRepExcel

String	K_TEMP = "\TEMP\"
String	K_FICSTAT = ".XLS"

end variables

forward prototypes
public function boolean wf_controlerdate ()
public subroutine wf_lancer (string ascas)
end prototypes

public function boolean wf_controlerdate ();//*-----------------------------------------------------------------
//*
//* Fonction      : wf_ControlerDate::wf_ControlerDate
//* Auteur        : Fabry JF
//* Date          : 21/10/2002 17:10:07
//* Libellé       : Contrôle des dates
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
			sMes = " de début"
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

public subroutine wf_lancer (string ascas);//*-----------------------------------------------------------------
//*
//* Fonction      : wf_ControlerDate::wf_Lancer
//* Auteur        : Fabry JF
//* Date          : 21/10/2002 17:10:07
//* Libellé       : Contrôle des dates
//* Commentaires  : 
//*
//* Arguments     : String		asCas		(Val)
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//			FPI	23/07/2024	[MIG_PB2022] Sauvegarde Excel! remplacée par Excel8!
//*-----------------------------------------------------------------

String	sDataObj, sNomFic
StaticText  stText
DateTime		dtDeb, dtFin
Date			dDeb, dFin
Long	lTotRow

If Not wf_controlerDate () Then Return

Choose Case asCas

	Case "D_L_OUV4_TEL"
		sDataObj = "D_L_OUV4_TEL"
		stText   = st_trt_Ouv4

	Case "D_L_REG6_TEL"
		sDataObj = "D_L_REG6_TEL"
		stText   = st_trt_Reg6

	Case "D_L_REF3_TEL"
		sDataObj = "D_L_REF3_TEL"
		stText   = st_trt_Ref3

	Case "D_L_REF4_TEL"
		sDataObj = "D_L_REF4_TEL"
		stText   = st_trt_Ref4

	Case "D_L_ENC4_TEL"
		sDataObj = "D_L_ENC4_TEL"
		stText   = st_trt_Enc4

End Choose

Dw_Trt.DataObject = sDataObj
Dw_Trt.SetTransObject ( SQLCA )

dDeb = Date ( uo_Dte_Deb.sle_Affichage.Text )
dFin = Date ( uo_Dte_Fin.sle_Affichage.Text )
dtDeb = DateTime ( dDeb, 00:00:00 )
dtFin = DateTime ( dFin, 23:59:59 )

stText.Text = "En cours de traitement..."

lTotRow = dw_Trt.Retrieve ( 5712, dtDeb, dtFin ) 

If lTotRow = 0 Then
	stText.Text = "Aucune donnée"
ElseIf lTotRow < 0 Then
	stText.Text = "ERREUR !! (" + String ( lTotRow ) + ")"
Else
	//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
	//sNomFic = isRepWin + K_TEMP + Upper ( Right ( sDataObj, 8) ) + K_FICSTAT 
	sNomFic = stGlb.sRepTempo + Upper ( Right ( sDataObj, 8) ) + K_FICSTAT 

	If Dw_Trt.SaveAs ( sNomFic , Excel8!, True ) > 0 Then // [MIG_PB2022]
		stText.Text  = sNomFic 
		RUN ( isRepExcel + " " + sNomFic  )
	Else
		stText.Text  = "Impossible d'écrire le fichier"
	End If	

End If




end subroutine

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_trt_part2
//* Evenement 		: Initiliaser
//* Auteur			: Fabry JF
//* Date				: 04/10/2002 15:14:40
//* Libellé			: Initialisation de la fenêtres
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lRow
//u_DeclarationFuncky uoDeclarationFuncky

This.Title = "Traitement PARTICULIER : Stat Hebdomadaire SFR MUST (5712)"


/*----------------------------------------------------------------------------*/
/* Armement du nom du rep win                                                 */
/*----------------------------------------------------------------------------*/
//uoDeclarationFuncky	= Create u_DeclarationFuncky
//isRepWin	= uoDeclarationFuncky.Uf_WinDir () 
//Destroy uoDeclarationFuncky

/*----------------------------------------------------------------------------*/
/* Armement du nom du Rep Excel en local.													*/
/*----------------------------------------------------------------------------*/
//isRepExcel = ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_EXCEL", "" )
isRepExcel = F_GetExcelPath() //[PI037]


end event

on w_a_sp_trt_part3.create
int iCurrent
call super::create
this.st_l_ouv4_tel=create st_l_ouv4_tel
this.st_d_l_reg6_tel=create st_d_l_reg6_tel
this.st_d_l_ref3_tel=create st_d_l_ref3_tel
this.st_d_l_ref4_tel=create st_d_l_ref4_tel
this.st_d_l_enc4_tel=create st_d_l_enc4_tel
this.cb_lancer_ouv4=create cb_lancer_ouv4
this.st_trt_ouv4=create st_trt_ouv4
this.cb_lancer_reg6=create cb_lancer_reg6
this.st_trt_reg6=create st_trt_reg6
this.cb_lancer_ref3=create cb_lancer_ref3
this.st_trt_ref3=create st_trt_ref3
this.cb_lancer_ref4=create cb_lancer_ref4
this.st_trt_ref4=create st_trt_ref4
this.cb_lancer_enc4=create cb_lancer_enc4
this.st_trt_enc4=create st_trt_enc4
this.st_1=create st_1
this.uo_dte_deb=create uo_dte_deb
this.uo_dte_fin=create uo_dte_fin
this.st_2=create st_2
this.st_3=create st_3
this.dw_trt=create dw_trt
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_l_ouv4_tel
this.Control[iCurrent+2]=this.st_d_l_reg6_tel
this.Control[iCurrent+3]=this.st_d_l_ref3_tel
this.Control[iCurrent+4]=this.st_d_l_ref4_tel
this.Control[iCurrent+5]=this.st_d_l_enc4_tel
this.Control[iCurrent+6]=this.cb_lancer_ouv4
this.Control[iCurrent+7]=this.st_trt_ouv4
this.Control[iCurrent+8]=this.cb_lancer_reg6
this.Control[iCurrent+9]=this.st_trt_reg6
this.Control[iCurrent+10]=this.cb_lancer_ref3
this.Control[iCurrent+11]=this.st_trt_ref3
this.Control[iCurrent+12]=this.cb_lancer_ref4
this.Control[iCurrent+13]=this.st_trt_ref4
this.Control[iCurrent+14]=this.cb_lancer_enc4
this.Control[iCurrent+15]=this.st_trt_enc4
this.Control[iCurrent+16]=this.st_1
this.Control[iCurrent+17]=this.uo_dte_deb
this.Control[iCurrent+18]=this.uo_dte_fin
this.Control[iCurrent+19]=this.st_2
this.Control[iCurrent+20]=this.st_3
this.Control[iCurrent+21]=this.dw_trt
end on

on w_a_sp_trt_part3.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_l_ouv4_tel)
destroy(this.st_d_l_reg6_tel)
destroy(this.st_d_l_ref3_tel)
destroy(this.st_d_l_ref4_tel)
destroy(this.st_d_l_enc4_tel)
destroy(this.cb_lancer_ouv4)
destroy(this.st_trt_ouv4)
destroy(this.cb_lancer_reg6)
destroy(this.st_trt_reg6)
destroy(this.cb_lancer_ref3)
destroy(this.st_trt_ref3)
destroy(this.cb_lancer_ref4)
destroy(this.st_trt_ref4)
destroy(this.cb_lancer_enc4)
destroy(this.st_trt_enc4)
destroy(this.st_1)
destroy(this.uo_dte_deb)
destroy(this.uo_dte_fin)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_trt)
end on

type cb_debug from w_8_accueil`cb_debug within w_a_sp_trt_part3
end type

type pb_retour from w_8_accueil`pb_retour within w_a_sp_trt_part3
integer width = 242
integer height = 144
integer taborder = 110
end type

type pb_interro from w_8_accueil`pb_interro within w_a_sp_trt_part3
boolean visible = false
integer taborder = 130
boolean enabled = false
end type

type pb_creer from w_8_accueil`pb_creer within w_a_sp_trt_part3
boolean visible = false
integer taborder = 120
boolean enabled = false
end type

type dw_1 from w_8_accueil`dw_1 within w_a_sp_trt_part3
integer x = 3493
integer y = 120
integer width = 311
integer height = 200
end type

type pb_tri from w_8_accueil`pb_tri within w_a_sp_trt_part3
boolean visible = false
integer taborder = 140
boolean enabled = false
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_sp_trt_part3
end type

type st_l_ouv4_tel from statictext within w_a_sp_trt_part3
integer x = 46
integer y = 412
integer width = 2007
integer height = 216
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "D_L_OUV4_TEL : Tous les dossiers sauf les réglés et réfusés (Cela afin de prendre en compte les sans suite qui n~'ont pas de garantie ni de détail). Critère de recherche sur la date de création du dossier dans SIMPA2."
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_d_l_reg6_tel from statictext within w_a_sp_trt_part3
integer x = 46
integer y = 652
integer width = 2007
integer height = 216
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "D_L_REG6_TEL : Tous les dossiers réglés et en cours de réglement (Un dossier réglé a au moins une garantie et un détail réglé). Critère de recherche sur la date du premier réglement sur le dossier dans SIMPA2."
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_d_l_ref3_tel from statictext within w_a_sp_trt_part3
integer x = 46
integer y = 892
integer width = 2007
integer height = 216
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "D_L_REF3_TEL : Tous les dossiers refusés ayant une garantie refusées (On ne regarde pas si les détails sont refusés, vu avec JLQ et MPL). Critère de recherche sur la date de dernière validation du dossier dans SIMPA2."
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_d_l_ref4_tel from statictext within w_a_sp_trt_part3
integer x = 46
integer y = 1132
integer width = 2007
integer height = 264
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "D_L_REF4_TEL : Tous les motifs de refus sur les dossiers refusés ayant leur garantie refusée, Pécision : on ne compte pas des dossiers, mais des motifs de refus. Critère de recherche sur la date de création du refus dans SIMPA2."
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_d_l_enc4_tel from statictext within w_a_sp_trt_part3
integer x = 46
integer y = 1420
integer width = 2007
integer height = 216
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "D_L_ENC4_TEL : Montant du préjudice des détails en attente. Critère de recherche sur la date de création du détail dans SIMPA2. Le dossier a au moins été validé une fois"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_lancer_ouv4 from commandbutton within w_a_sp_trt_part3
integer x = 2062
integer y = 408
integer width = 1294
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Lancer D_L_OUV4_TEL"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : cb_Lancer_Ouv4
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 21/10/2002 17:27:11
//* Libellé       : 
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

wf_Lancer ( "D_L_OUV4_TEL" )
end on

type st_trt_ouv4 from statictext within w_a_sp_trt_part3
integer x = 2066
integer y = 536
integer width = 1285
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_lancer_reg6 from commandbutton within w_a_sp_trt_part3
integer x = 2062
integer y = 644
integer width = 1294
integer height = 116
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Lancer D_L_REG6_TEL"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : cb_Lancer_Reg6
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 21/10/2002 17:27:11
//* Libellé       : 
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

wf_Lancer ( "D_L_REG6_TEL" )
end on

type st_trt_reg6 from statictext within w_a_sp_trt_part3
integer x = 2071
integer y = 776
integer width = 1285
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_lancer_ref3 from commandbutton within w_a_sp_trt_part3
integer x = 2066
integer y = 884
integer width = 1294
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Lancer D_L_REF3_TEL"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : cb_Lancer_Ref3
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 21/10/2002 17:27:11
//* Libellé       : 
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

wf_Lancer ( "D_L_REF3_TEL" )
end on

type st_trt_ref3 from statictext within w_a_sp_trt_part3
integer x = 2075
integer y = 1016
integer width = 1285
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_lancer_ref4 from commandbutton within w_a_sp_trt_part3
integer x = 2066
integer y = 1128
integer width = 1294
integer height = 164
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Lancer D_L_REF4_TEL"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : cb_Lancer_Ref4
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 21/10/2002 17:27:11
//* Libellé       : 
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

wf_Lancer ( "D_L_REF4_TEL" )
end on

type st_trt_ref4 from statictext within w_a_sp_trt_part3
integer x = 2075
integer y = 1308
integer width = 1285
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_lancer_enc4 from commandbutton within w_a_sp_trt_part3
integer x = 2071
integer y = 1416
integer width = 1294
integer height = 108
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Lancer D_L_ENC4_TEL"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : cb_Lancer_Enc4
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 21/10/2002 17:27:11
//* Libellé       : 
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

wf_Lancer ( "D_L_ENC4_TEL" )
end on

type st_trt_enc4 from statictext within w_a_sp_trt_part3
integer x = 2080
integer y = 1540
integer width = 1285
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_1 from statictext within w_a_sp_trt_part3
integer x = 731
integer y = 64
integer width = 1943
integer height = 112
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "SFR MUST (5712), Statistiques sur base réélle"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type uo_dte_deb from u_calendrier_w within w_a_sp_trt_part3
integer x = 745
integer y = 240
integer height = 96
integer taborder = 30
end type

on uo_dte_deb.destroy
call u_calendrier_w::destroy
end on

type uo_dte_fin from u_calendrier_w within w_a_sp_trt_part3
integer x = 1760
integer y = 240
integer height = 96
integer taborder = 40
boolean bringtotop = true
end type

on uo_dte_fin.destroy
call u_calendrier_w::destroy
end on

type st_2 from statictext within w_a_sp_trt_part3
integer x = 649
integer y = 252
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

type st_3 from statictext within w_a_sp_trt_part3
integer x = 1659
integer y = 252
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

type dw_trt from datawindow within w_a_sp_trt_part3
boolean visible = false
integer x = 3191
integer y = 28
integer width = 215
integer height = 160
integer taborder = 50
boolean bringtotop = true
boolean enabled = false
end type

