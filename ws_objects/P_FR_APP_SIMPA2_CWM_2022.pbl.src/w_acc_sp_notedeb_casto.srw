HA$PBExportHeader$w_acc_sp_notedeb_casto.srw
$PBExportComments$consultation des notes de d$$HEX1$$e900$$ENDHEX$$bit casto [DCMP080371]
forward
global type w_acc_sp_notedeb_casto from w_8_accueil
end type
type sle_notedebit from singlelineedit within w_acc_sp_notedeb_casto
end type
type st_ndb from statictext within w_acc_sp_notedeb_casto
end type
type cb_recherche from commandbutton within w_acc_sp_notedeb_casto
end type
type cb_init from commandbutton within w_acc_sp_notedeb_casto
end type
type st_info from statictext within w_acc_sp_notedeb_casto
end type
end forward

global type w_acc_sp_notedeb_casto from w_8_accueil
integer width = 3625
integer height = 1928
string title = "Recherche Note de d$$HEX1$$e900$$ENDHEX$$bit Castorama"
sle_notedebit sle_notedebit
st_ndb st_ndb
cb_recherche cb_recherche
cb_init cb_init
st_info st_info
end type
global w_acc_sp_notedeb_casto w_acc_sp_notedeb_casto

on w_acc_sp_notedeb_casto.create
int iCurrent
call super::create
this.sle_notedebit=create sle_notedebit
this.st_ndb=create st_ndb
this.cb_recherche=create cb_recherche
this.cb_init=create cb_init
this.st_info=create st_info
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_notedebit
this.Control[iCurrent+2]=this.st_ndb
this.Control[iCurrent+3]=this.cb_recherche
this.Control[iCurrent+4]=this.cb_init
this.Control[iCurrent+5]=this.st_info
end on

on w_acc_sp_notedeb_casto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.sle_notedebit)
destroy(this.st_ndb)
destroy(this.cb_recherche)
destroy(this.cb_init)
destroy(this.st_info)
end on

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_acc_sp_notedeb_casto
//* Evenement 		:	ue_initialiser
//* Auteur			:	Fabry JF
//* Date				:	08/07/2008
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//*					 	
//* Commentaires	:
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

dw_1.SetTransObject ( SQLCA )
sle_notedebit.SetFocus ()
end event

type cb_debug from w_8_accueil`cb_debug within w_acc_sp_notedeb_casto
end type

type pb_retour from w_8_accueil`pb_retour within w_acc_sp_notedeb_casto
integer width = 242
integer height = 144
end type

type pb_interro from w_8_accueil`pb_interro within w_acc_sp_notedeb_casto
boolean visible = false
integer width = 242
integer height = 144
end type

type pb_creer from w_8_accueil`pb_creer within w_acc_sp_notedeb_casto
boolean visible = false
integer width = 242
integer height = 144
end type

type dw_1 from w_8_accueil`dw_1 within w_acc_sp_notedeb_casto
boolean visible = true
integer x = 27
integer y = 576
integer width = 3506
integer height = 1128
string dataobject = "d_lst_div_det_notedebit"
end type

type pb_tri from w_8_accueil`pb_tri within w_acc_sp_notedeb_casto
boolean visible = false
integer width = 242
integer height = 144
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_acc_sp_notedeb_casto
end type

type sle_notedebit from singlelineedit within w_acc_sp_notedeb_casto
integer x = 434
integer y = 220
integer width = 1737
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
integer limit = 35
borderstyle borderstyle = stylelowered!
end type

type st_ndb from statictext within w_acc_sp_notedeb_casto
integer x = 23
integer y = 236
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Note de d$$HEX1$$e900$$ENDHEX$$bit"
boolean focusrectangle = false
end type

type cb_recherche from commandbutton within w_acc_sp_notedeb_casto
integer x = 439
integer y = 340
integer width = 846
integer height = 112
integer taborder = 40
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
//* Objet 			:	w_acc_sp_notedeb_casto::cb_Recherche
//* Evenement 		:	Clicked
//* Auteur			:	Fabry JF
//* Date				:	08/07/2008
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//*					 	
//* Commentaires	:
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
// 	FPI				14/06/2017	[VDOC23995]		  
//*-----------------------------------------------------------------
String sVal
Long ltot

sVal = sle_NoteDebit.text

If IsNull ( sVal ) Or Trim ( sVal ) = "" then 
	st_info.Text = "Saisissez une donn$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$rechercher"
	Return
End IF

If Pos ( sVal, "%", 1 ) > 0 Then 
	st_info.Text = "Caract$$HEX1$$e800$$ENDHEX$$re % interdit"
	Return
End IF

If Len ( sVal ) < 4 Or Len ( sVal ) > 10   then // [VDOC23995] passage de 8 $$HEX2$$e0002000$$ENDHEX$$10 caract$$HEX1$$e800$$ENDHEX$$res
	st_info.Text = "Une note de d$$HEX1$$e900$$ENDHEX$$bit contient entre 4 et 10 caract$$HEX1$$e800$$ENDHEX$$res"
	Return
End IF


st_info.Text = "Recherche en cours"
cb_recherche.enabled = False
cb_init.enabled = False

dw_1.Reset ()
lTot = dw_1.Retrieve ( sVal )

cb_recherche.enabled = True
cb_init.enabled = True

st_info.Text = "Recherche termin$$HEX1$$e900$$ENDHEX$$e (" + String ( lTot ) + ")"

sle_notedebit.SetFocus ()

end event

type cb_init from commandbutton within w_acc_sp_notedeb_casto
integer x = 1294
integer y = 340
integer width = 873
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Effacer la saisie"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_acc_sp_notedeb_casto::cb_init
//* Evenement 		:	ue_clicked
//* Auteur			:	Fabry JF
//* Date				:	08/07/2008
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//*					 	
//* Commentaires	:
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


st_info.Text = ""
sle_notedebit.Text = ""

sle_notedebit.SetFocus ()

end event

type st_info from statictext within w_acc_sp_notedeb_casto
integer x = 439
integer y = 468
integer width = 1737
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

