HA$PBExportHeader$w_a_sp_trt.srw
$PBExportComments$--- } Fen$$HEX1$$ea00$$ENDHEX$$tre anc$$HEX1$$ea00$$ENDHEX$$tre des traitements p$$HEX1$$e900$$ENDHEX$$riodiques
forward
global type w_a_sp_trt from w_a_sp_traitement
end type
type pb_lancer from picturebutton within w_a_sp_trt
end type
type cb_sel from commandbutton within w_a_sp_trt
end type
type cb_desel from commandbutton within w_a_sp_trt
end type
type cb_selpart from commandbutton within w_a_sp_trt
end type
end forward

global type w_a_sp_trt from w_a_sp_traitement
integer width = 3730
event ue_definirtrt pbm_custom01
pb_lancer pb_lancer
cb_sel cb_sel
cb_desel cb_desel
cb_selpart cb_selpart
end type
global w_a_sp_trt w_a_sp_trt

type variables
Private :

	u_sp_gs_Trait_Etat		iuoTrtEtat
end variables

on open;call w_a_sp_traitement::open;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_trt_m
//* Evenement 		: Open
//* Auteur			: DBI
//* Date				: 12/11/1998 16:33:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Cr$$HEX1$$e900$$ENDHEX$$ation de la Dw
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Dw_1.Visible	=	True

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la datawindow en fonction du traitement              */
/*------------------------------------------------------------------*/

iuoTrtEtat = Create u_sp_gs_Trait_Etat

/*------------------------------------------------------------------*/
/* Permet de d$$HEX1$$e900$$ENDHEX$$finir s'il s'agit d'un traitement mensuel, trim....  */
/* armer la variable isTypTrt  												  */
/*------------------------------------------------------------------*/

This.TriggerEvent ( "ue_DefinirTrt" )

itrTrans	  = SQLCA

iuoTrtEtat.Uf_Initialiser ( dw_1, dw_Dates, dw_volcane, dw_Dept, uo_Defil, Dw_Etat, itrTrans )
iuoTrtEtat.Uf_Departement ()
iuoTrtEtat.Uf_Choix_Periode ()

iuoTrtEtat.uf_Generer_Dw ( isTypTrt )

/*----------------------------------------------------------------------------*/
/* On retaille la DW                                                          */
/*----------------------------------------------------------------------------*/
This.TriggerEvent ( "Ue_TaillerHauteur" )
Dw_1.Visible	=	True

/*------------------------------------------------------------------*/
/* On remet le focus par d$$HEX1$$e900$$ENDHEX$$faut sur le bouton RETOUR. En effet, la  */
/* fen$$HEX1$$ea00$$ENDHEX$$tre anc$$HEX1$$ea00$$ENDHEX$$tre positionne le focus sur le bouton INTERRO, qui   */
/* est invisible actuellement.                                      */
/*------------------------------------------------------------------*/

Pb_Retour.SetFocus ()

end on

on close;call w_a_sp_traitement::close;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_trt_m
//* Evenement 		: Close
//* Auteur			: dbi
//* Date				: 22/12/1998 10:25:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Destruction du userobject iuotrt
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


Destroy iuoTrtEtat
end on

on w_a_sp_trt.create
int iCurrent
call super::create
this.pb_lancer=create pb_lancer
this.cb_sel=create cb_sel
this.cb_desel=create cb_desel
this.cb_selpart=create cb_selpart
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_lancer
this.Control[iCurrent+2]=this.cb_sel
this.Control[iCurrent+3]=this.cb_desel
this.Control[iCurrent+4]=this.cb_selpart
end on

on w_a_sp_trt.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_lancer)
destroy(this.cb_sel)
destroy(this.cb_desel)
destroy(this.cb_selpart)
end on

type cb_debug from w_a_sp_traitement`cb_debug within w_a_sp_trt
end type

type pb_retour from w_a_sp_traitement`pb_retour within w_a_sp_trt
integer x = 9
integer y = 32
integer taborder = 70
end type

type pb_interro from w_a_sp_traitement`pb_interro within w_a_sp_trt
end type

type pb_creer from w_a_sp_traitement`pb_creer within w_a_sp_trt
end type

type dw_1 from w_a_sp_traitement`dw_1 within w_a_sp_trt
integer taborder = 80
end type

on dw_1::constructor;call w_a_sp_traitement`dw_1::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_traitement::dw_1
//* Evenement 		: constructor
//* Auteur			: DBI
//* Date				: 18/01/1999 11:09:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

ilMaxLig = 0
end on

type pb_tri from w_a_sp_traitement`pb_tri within w_a_sp_trt
end type

type pb_imprimer from w_a_sp_traitement`pb_imprimer within w_a_sp_trt
end type

type dw_dates from w_a_sp_traitement`dw_dates within w_a_sp_trt
integer x = 855
integer y = 0
end type

on dw_dates::itemchanged;call w_a_sp_traitement`dw_dates::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_Dates
//* Evenement 		: ItemChanged
//* Auteur			: FABRY JF
//* Date				: 12/11/1998 12:10:12
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le l'existance d'une date de d$$HEX1$$e900$$ENDHEX$$but de p$$HEX1$$e900$$ENDHEX$$riode, en fonction de la 
//*					  date de fin, et du type de traitement.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String sNomCol
String sVal
Boolean bOk

sNomCol = Upper ( This.GetColumnName () )
sVal    = This.GetText()

Choose Case sNomCol

	Case "DTE_FIN"						// ... Initialisation de DTE_DEB 

		bOk = iuoTrtEtat.Uf_Zn_DteFin ( istyptrt, sVal )

		pb_lancer.Enabled = bOk		// .... Activation du bouton si dates correctement renseign$$HEX1$$e900$$ENDHEX$$es

End Choose
	
end on

type dw_dept from w_a_sp_traitement`dw_dept within w_a_sp_trt
integer x = 2405
integer y = 0
integer width = 1211
integer height = 100
string dataobject = "d_sp_choix_dept"
end type

type uo_defil from w_a_sp_traitement`uo_defil within w_a_sp_trt
integer x = 750
integer y = 100
integer width = 1655
end type

type dw_volcane from w_a_sp_traitement`dw_volcane within w_a_sp_trt
end type

type dw_etat from w_a_sp_traitement`dw_etat within w_a_sp_trt
event ue_personnaliser pbm_custom01
integer x = 2350
integer y = 384
integer height = 264
end type

type pb_lancer from picturebutton within w_a_sp_trt
integer x = 251
integer y = 32
integer width = 233
integer height = 136
integer taborder = 50
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Lancer"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_valid.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Trt_Etat::Pb_Lancer (EXTEND)
//* Evenement 		: Lancement du traitement
//* Auteur			: DBI
//* Date				: 28/12/1998 11:42:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration du traitement 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
iUoTrtEtat.Uf_LancerTrt ( Dw_1, isTypTrt )

end on

type cb_sel from commandbutton within w_a_sp_trt
integer x = 494
integer y = 28
integer width = 256
integer height = 52
integer taborder = 40
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "S$$HEX1$$e900$$ENDHEX$$lection"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: cb_sel
//* Evenement 		: Clicked
//* Auteur			: DBI
//* Date				: 26/03/1999 11:17:36
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: S$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ction tous les $$HEX1$$e900$$ENDHEX$$tats
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Dw_1.SelectRow ( 0, True )
end on

type cb_desel from commandbutton within w_a_sp_trt
integer x = 494
integer y = 80
integer width = 256
integer height = 52
integer taborder = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "D$$HEX1$$e900$$ENDHEX$$s$$HEX1$$e900$$ENDHEX$$lection"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: cb_sel
//* Evenement 		: Clicked
//* Auteur			: DBI
//* Date				: 26/03/1999 11:17:36
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: S$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ction tous les $$HEX1$$e900$$ENDHEX$$tats
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Dw_1.SelectRow ( 0, False )
end on

type cb_selpart from commandbutton within w_a_sp_trt
integer x = 494
integer y = 132
integer width = 256
integer height = 52
integer taborder = 70
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "S$$HEX1$$e900$$ENDHEX$$lect. Part."
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: cb_selpart
//* Evenement 		: Clicked
//* Auteur			: JFF
//* Date				: 16/04/2008 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: S$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ction Partielle 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lRow, lRow1, lTotRow, lCpt, lRowSav

lTotRow = Dw_1.RowCount()

lRow = Dw_1.GetSelectedRow (0)
If lRow <= 0 Then Return

lRowSav = 0
For lCpt = lRow To lTotRow 
	lRow1 = Dw_1.GetSelectedRow ( lCpt )	
	If lRow1 > 0 Then lRowSav = lRow1
Next
lRow1 = lRowSav

If lRow1 <= 0 Then lRow1 = lTotRow

For lCpt = lRow To lRow1
	Dw_1.SelectRow ( lcpt, True )
Next

end event

