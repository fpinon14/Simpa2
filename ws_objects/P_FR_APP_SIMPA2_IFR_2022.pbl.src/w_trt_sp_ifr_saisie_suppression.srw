HA$PBExportHeader$w_trt_sp_ifr_saisie_suppression.srw
forward
global type w_trt_sp_ifr_saisie_suppression from window
end type
type cb_annuler from commandbutton within w_trt_sp_ifr_saisie_suppression
end type
type st_2 from statictext within w_trt_sp_ifr_saisie_suppression
end type
type dw_choix_supp from datawindow within w_trt_sp_ifr_saisie_suppression
end type
type st_1 from statictext within w_trt_sp_ifr_saisie_suppression
end type
type st_ref_supp from statictext within w_trt_sp_ifr_saisie_suppression
end type
type cb_ok from commandbutton within w_trt_sp_ifr_saisie_suppression
end type
end forward

global type w_trt_sp_ifr_saisie_suppression from window
integer width = 2217
integer height = 1048
boolean titlebar = true
string title = "Choix du mobile IFR correspondant"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "Asterisk!"
boolean center = true
cb_annuler cb_annuler
st_2 st_2
dw_choix_supp dw_choix_supp
st_1 st_1
st_ref_supp st_ref_supp
cb_ok cb_ok
end type
global w_trt_sp_ifr_saisie_suppression w_trt_sp_ifr_saisie_suppression

type variables
s_pass stPassSupp
W_Trt_Sp_Ifr_Saisie iw_W_Ifr_Saisie
end variables

forward prototypes
public function boolean wf_supp_ligne_spb (s_pass stpass)
end prototypes

public function boolean wf_supp_ligne_spb (s_pass stpass);//*-----------------------------------------------------------------
//* Fonction		: W_Trt_Sp_Ifr_Saisie::wf_supp_ligne_spb 
//* Auteur			: JCA
//* Date				: 28/06/2006
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 
//*-----------------------------------------------------------------
string sMarque, sReference, sNewMarq, sNewRef, sSql
long lTot, lLigneSupp
boolean bRetSql, bRetFonc

sMarque =	stPass.sTab[1]
sReference =	stPass.sTab[2]
sNewMarq =	stPass.sTab[3]
sNewRef	=	stPass.sTab[4]

sSql = "Exec sysadm.PS_U01_IFR_SUPP_SPB '" + sMarque + "','" + sReference + "','" + sNewMarq + "','" + sNewRef +"'"

F_Execute ( sSql, SQLCA )
bRetSql = SQLCA.SqlCode = 0 And SQLCA.SqlDbCode = 0

if bRetSql then
	iw_W_Ifr_Saisie.dw_1.DeleteRow (lLigneSupp)
	bRetSql = iw_W_Ifr_Saisie.wf_enregistrer ()
	iw_W_Ifr_Saisie.wf_Afficher_Compteur ()
	
	If lLigneSupp > iw_W_Ifr_Saisie.dw_1.RowCount() Then
		lLigneSupp = iw_W_Ifr_Saisie.dw_1.RowCount()
	End If
	
	iw_W_Ifr_Saisie.dw_1.SetRow (lLigneSupp)
	iw_W_Ifr_Saisie.dw_1.ScrollToRow (lLigneSupp)
	
	iw_W_Ifr_Saisie.dw_1.SetRedraw (True)
	iw_W_Ifr_Saisie.dw_2.SetRedraw (True)
	
	bRetFonc = true
else
	bRetFonc = false
	F_Commit ( SQLCA, bRetSql)
end if

return bRetFonc
end function

on w_trt_sp_ifr_saisie_suppression.create
this.cb_annuler=create cb_annuler
this.st_2=create st_2
this.dw_choix_supp=create dw_choix_supp
this.st_1=create st_1
this.st_ref_supp=create st_ref_supp
this.cb_ok=create cb_ok
this.Control[]={this.cb_annuler,&
this.st_2,&
this.dw_choix_supp,&
this.st_1,&
this.st_ref_supp,&
this.cb_ok}
end on

on w_trt_sp_ifr_saisie_suppression.destroy
destroy(this.cb_annuler)
destroy(this.st_2)
destroy(this.dw_choix_supp)
destroy(this.st_1)
destroy(this.st_ref_supp)
destroy(this.cb_ok)
end on

event open;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie_Suppression
//* Evenement 		: open
//* Auteur			: JCA
//* Date				: 27/06/2006
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Recherche des marques ressemblantes $$HEX2$$e0002000$$ENDHEX$$celle supprimer
//*						avec tous les modeles
//*-----------------------------------------------------------------
//* #1	JCA	20/07/2006	modification de recherche sur la marque
//* #2	FPI	23/06/2009  [DMDI25957] Suppression du filtre IFR
//*-----------------------------------------------------------------

string sMarq, sRef
string sFilter // #2

if isvalid(Message.PowerObjectParm) then
	stPassSupp = Message.PowerObjectParm
	iw_W_Ifr_Saisie = stPassSupp.wparent

	st_ref_supp.Text = stPassSupp.stab[1]+" "+stPassSupp.stab[2]
	
//	sMarq =	left(stPassSupp.stab[1], 1)+"%"+right(stPassSupp.stab[1], 1)
	sMarq =	"%" + stPassSupp.stab[1] + "%"
	sRef	=	"%"
	
	dw_choix_supp.SetTransObject (Sqlca)
	dw_choix_supp.retrieve(sMarq, sRef)
	// #2
	sFilter = "not (marque='" + stPassSupp.stab[1] + "' and reference = '" + stPassSupp.stab[2] + "')"
	if not isNull(sFilter) Then
		dw_choix_supp.SetFilter(sFilter)
		dw_choix_supp.Filter()
	End if
	// Fin #2
end if
end event

type cb_annuler from commandbutton within w_trt_sp_ifr_saisie_suppression
integer x = 814
integer y = 796
integer width = 233
integer height = 136
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annuler"
end type

event clicked;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie_Suppression : cb_annuler
//* Evenement 		: clicked
//* Auteur			: JCA
//* Date				: 27/06/2006
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Pour afficher la marque et le modele qui va $$HEX1$$ea00$$ENDHEX$$tre supprime
//* 						ou mis a jour
//*-----------------------------------------------------------------

iw_W_Ifr_Saisie.dw_1.SetRedraw (True)
iw_W_Ifr_Saisie.dw_2.SetRedraw (True)

close(parent)
end event

type st_2 from statictext within w_trt_sp_ifr_saisie_suppression
integer x = 37
integer y = 192
integer width = 622
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Pour la remplacer par :"
boolean focusrectangle = false
end type

type dw_choix_supp from datawindow within w_trt_sp_ifr_saisie_suppression
integer x = 27
integer y = 268
integer width = 2149
integer height = 508
integer taborder = 10
string title = "none"
string dataobject = "d_trt_sp_ifr_choix_supp"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie_Suppression : dw_1
//* Evenement 		: itemchanged
//* Auteur			: JCA
//* Date				: 27/06/2006
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Autorise la coche d'une seule case $$HEX2$$e0002000$$ENDHEX$$cocher
//*-----------------------------------------------------------------

long lFind, lEnd
string sCheck

sCheck = "ALT_SELECT = '1'"
lEnd = RowCount()
lFind = Find(sCheck, 1, lEnd) 

if lFind > 0 then
	SetItem(lFind, 'ALT_SELECT', '0')
end if

end event

type st_1 from statictext within w_trt_sp_ifr_saisie_suppression
integer x = 32
integer y = 28
integer width = 1074
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Vous allez supprimer la r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence SPB :"
boolean focusrectangle = false
end type

type st_ref_supp from statictext within w_trt_sp_ifr_saisie_suppression
integer x = 50
integer y = 112
integer width = 2130
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "reference supprimee"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_trt_sp_ifr_saisie_suppression
integer x = 1257
integer y = 796
integer width = 233
integer height = 136
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Saisie_Suppression : cb_ok
//* Evenement 		: clicked
//* Auteur			: JCA
//* Date				: 27/06/2006
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Appel du traitement de remplacement et 
//*						de suppression de la ligne selectionnee
//*-----------------------------------------------------------------

long lFind, lEnd
string sCheck
boolean bRet

sCheck = "ALT_SELECT = '1'"
lEnd = dw_choix_supp.RowCount()
lFind = dw_choix_supp.Find(sCheck, 1, lEnd) 

SetPointer (HourGlass!)
this.enabled = false

if not lFind > 0 then
	SetPointer (Arrow!)
	this.enabled = true
	MessageBox("Attention", "Vous devez selectionner une ligne")
else
	
	stPassSupp.sTab[3] = dw_choix_supp.GetItemString(lFind, "MARQUE")
	stPassSupp.sTab[4] = dw_choix_supp.GetItemString(lFind, "REFERENCE")

	stMessage.sTitre  	= "Contr$$HEX1$$f400$$ENDHEX$$le ES"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= YESNO!
	stMessage.sCode = "IFR0104"
	
	If F_Message ( stMessage ) = 1 Then
		bRet = wf_supp_ligne_spb(stPassSupp)
	Else
		bRet = False
	End If

	if bRet then
		close(parent)
	else
		SetPointer (Arrow!)
		this.enabled = true
		MessageBox("Echec", "Echec de la mise $$HEX2$$e0002000$$ENDHEX$$jour !", Exclamation!)
	end if
end if
end event

