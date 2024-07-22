HA$PBExportHeader$w_t_sp_droit_courrier.srw
$PBExportComments$---} Param$$HEX1$$e900$$ENDHEX$$trage des droits courrier et validation autonome
forward
global type w_t_sp_droit_courrier from w_8_traitement
end type
type dw_produit from datawindow within w_t_sp_droit_courrier
end type
type dw_param_droit from datawindow within w_t_sp_droit_courrier
end type
type dw_droit_existant from datawindow within w_t_sp_droit_courrier
end type
type pb_appliquer from picturebutton within w_t_sp_droit_courrier
end type
type st_temoin_sav from statictext within w_t_sp_droit_courrier
end type
type dw_recherche from datawindow within w_t_sp_droit_courrier
end type
type pb_recherche from picturebutton within w_t_sp_droit_courrier
end type
end forward

global type w_t_sp_droit_courrier from w_8_traitement
integer width = 3616
integer height = 1776
dw_produit dw_produit
dw_param_droit dw_param_droit
dw_droit_existant dw_droit_existant
pb_appliquer pb_appliquer
st_temoin_sav st_temoin_sav
dw_recherche dw_recherche
pb_recherche pb_recherche
end type
global w_t_sp_droit_courrier w_t_sp_droit_courrier

type variables
Private:

n_cst_sp_droit_courrier  invDrtCour

end variables

forward prototypes
public function boolean wf_preparermodifier ()
public subroutine wf_appliquer ()
public subroutine wf_valider_desc ()
end prototypes

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_t_sp_droit_courrier::wf_preparer
//* Auteur        : Fabry JF
//* Date          : 19/02/2004 17:21:10
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
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

Int iRet
DataWindowChild ldwc

iRet = invDrtCour.uf_Preparer  ()

dw_recherche.InsertRow(0)
dw_recherche.getchild( "nom", ldwc)
dw_1.sharedata(ldwc)

Return iRet > 0
end function

public subroutine wf_appliquer ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_t_sp_droit_courrier::wf_Appliquer (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 20/02/2004 16:11:40
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Sauvegarde sans quitter la fen$$HEX1$$ea00$$ENDHEX$$tre
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

Int iRet

iRet = invDrtCour.Uf_Valider ()


end subroutine

public subroutine wf_valider_desc ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_t_sp_droit_courrier::wf_Valider (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 20/02/2004 16:11:40
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
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

Int iRet

iRet = invDrtCour.Uf_Valider ()

If iRet > 0 Then
	This.TriggerEvent ( "ue_retour" )
End If
end subroutine

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet         : w_t_sp_droit_courrier
//* Evenement     : ue_initialiser
//* Auteur        : Fabry JF
//* Date          : 19/02/2004 16:47:55
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: DCMP040020
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

s_Pass stPass

This.Title = "Param$$HEX1$$e800$$ENDHEX$$trage des droits li$$HEX1$$e900$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$la gestion des dossiers"

st_temoin_sav.Text = ""

invDrtCour = Create n_cst_sp_droit_courrier  

stPass.dwNorm [1] =  dw_droit_existant
stPass.dwNorm [2] =  dw_param_droit
stPass.dwNorm [3] =  dw_produit

invDrtCour.uf_initialiser ( dw_1, stPass, st_temoin_sav )




end event

on we_childactivate;call w_8_traitement::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Trt_Corb_Oper::We_ChildActivate
//* Evenement 		: We_ChildActivate
//* Auteur			: Fabry JF
//* Date				: 30/11/2002 11:13:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Si on d$$HEX1$$e900$$ENDHEX$$place la fen$$HEX1$$ea00$$ENDHEX$$tre, elle revient au m$$HEX1$$ea00$$ENDHEX$$me endroit. 
//*				  
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

This.X			=    1
This.Y			=    1
This.Height		= 1775
This.Width		= 3595
end on

on ue_retour;call w_8_traitement::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet         : w_t_sp_droit_courrier
//* Evenement     : ue_retour
//* Auteur        : Fabry JF
//* Date          : 19/02/2004 17:43:30
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
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

iwParent.TriggerEvent ( "Ue_MajAccueil" )
end on

on w_t_sp_droit_courrier.create
int iCurrent
call super::create
this.dw_produit=create dw_produit
this.dw_param_droit=create dw_param_droit
this.dw_droit_existant=create dw_droit_existant
this.pb_appliquer=create pb_appliquer
this.st_temoin_sav=create st_temoin_sav
this.dw_recherche=create dw_recherche
this.pb_recherche=create pb_recherche
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_produit
this.Control[iCurrent+2]=this.dw_param_droit
this.Control[iCurrent+3]=this.dw_droit_existant
this.Control[iCurrent+4]=this.pb_appliquer
this.Control[iCurrent+5]=this.st_temoin_sav
this.Control[iCurrent+6]=this.dw_recherche
this.Control[iCurrent+7]=this.pb_recherche
end on

on w_t_sp_droit_courrier.destroy
call super::destroy
destroy(this.dw_produit)
destroy(this.dw_param_droit)
destroy(this.dw_droit_existant)
destroy(this.pb_appliquer)
destroy(this.st_temoin_sav)
destroy(this.dw_recherche)
destroy(this.pb_recherche)
end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet         : w_t_sp_droit_courrier
//* Evenement     : close
//* Auteur        : Fabry JF
//* Date          : 19/02/2004 16:47:12
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
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

//Migration PB8-WYNIWYG-03/2006 FM
//Destroy ( invDrtCour )
If IsValid(invDrtCour) Then Destroy ( invDrtCour )
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type cb_debug from w_8_traitement`cb_debug within w_t_sp_droit_courrier
end type

type dw_1 from w_8_traitement`dw_1 within w_t_sp_droit_courrier
integer x = 27
integer y = 196
integer width = 1714
integer height = 696
string dataobject = "d_sp_droit_courrier_operateur"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event dw_1::clicked;call super::clicked;//*-----------------------------------------------------------------
//*
//* Evenement		: Clicked
//* Auteur			: Fabry JF
//* Date				: 20/02/2004 16:16:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Gestion du click sur un $$HEX1$$e900$$ENDHEX$$tat.
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------

Long 		lRow
String sCurrentSort, sNewSort

lRow = This.GetClickedRow()

If lRow > 0 then 
	This.SelectRow ( 0, False 	 )
	This.SelectRow ( lRow, True )
	This.SetRow		( lRow 	    )
End IF

if lRow=0 Then
	sCurrentSort=This.Describe("DataWindow.Table.Sort")
	sNewSort=""
	
	if xPos < 60 Then
		sNewSort="ID_OPER"
	Else
		sNewSort="NOM"
	End if
	
	if upper(sCurrentSort)=sNewSort + " A" Then
		sNewSort+=" D"
	Else 
		sNewSort+=" A"
	End if
	
	dw_1.setSort(sNewSort)
	dw_1.Sort()
End if
end event

on dw_1::rowfocuschanged;call w_8_traitement`dw_1::rowfocuschanged;//*-----------------------------------------------------------------
//*
//* Objet         : w_t_sp_droit_courrier
//* Evenement     : RowFocusChanged
//* Auteur        : Fabry JF
//* Date          : 20/02/2004 09:26:41
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
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

String sIdOper, sNom

sIdOper = ""

If This.GetRow () > 0 Then
	sIdOper = This.GetItemString ( This.GetRow (), "ID_OPER" )
	sNom    = This.GetItemString ( This.GetRow (), "PRENOM" ) + " " + &
				 This.GetItemString ( This.GetRow (), "NOM" ) + " (" + sIdOper + ")"
End If

invDrtCour.uf_Filtre_DwProduit ( sIdOper, sNom )



end on

type st_titre from w_8_traitement`st_titre within w_t_sp_droit_courrier
boolean visible = false
end type

type pb_retour from w_8_traitement`pb_retour within w_t_sp_droit_courrier
integer x = 18
integer y = 20
integer width = 242
integer height = 144
integer taborder = 40
end type

type pb_valider from w_8_traitement`pb_valider within w_t_sp_droit_courrier
integer x = 261
integer y = 20
integer width = 242
integer height = 144
integer taborder = 60
end type

on pb_valider::clicked;//*-----------------------------------------------------------------
//*
//* Objet         : pb_Valider (!OVERRIDE!)
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 20/02/2004 16:09:42
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
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

Parent.Wf_Valider_Desc ()
end on

type pb_imprimer from w_8_traitement`pb_imprimer within w_t_sp_droit_courrier
boolean visible = false
integer width = 274
integer height = 160
integer taborder = 100
boolean enabled = false
end type

type pb_controler from w_8_traitement`pb_controler within w_t_sp_droit_courrier
boolean visible = false
integer taborder = 50
boolean enabled = false
end type

type pb_supprimer from w_8_traitement`pb_supprimer within w_t_sp_droit_courrier
boolean visible = false
integer taborder = 90
boolean enabled = false
end type

type dw_produit from datawindow within w_t_sp_droit_courrier
integer x = 27
integer y = 904
integer width = 1714
integer height = 760
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_sp_droit_courrier_produit"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;//*-----------------------------------------------------------------
//*
//* Objet         : w_t_sp_droit_courrier
//* Evenement     : RowFocusChanged
//* Auteur        : Fabry JF
//* Date          : 20/02/2004 10:40:39
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
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

String sIdOper
Long	 lIdProd

sIdOper = ""
lIdProd = 0

If This.GetRow () > 0 Then
	sIdOper = This.GetItemString ( This.GetRow (), "ID_OPER" )
	lIdProd = This.GetItemNumber ( This.GetRow (), "ID_PROD" )

	If IsNull ( sIdOper ) Then 
//Migration PB8-WYNIWYG-03/2006 FM
//		sIdOper = Upper ( Dw_1.GetItemString ( Dw_1.GetSelectedRow ( 0 ), "ID_OPER" ) )
		sIdOper = Upper ( Dw_1.GetItemString ( Dw_1.GetRow(), "ID_OPER" ) )
//Fin Migration PB8-WYNIWYG-03/2006 FM
	End If
End If

invDrtCour.uf_Afficher_Droit ( sIdOper, lIdProd )
end event

on clicked;//*-----------------------------------------------------------------
//*
//* Evenement		: Clicked
//* Auteur			: Fabry JF
//* Date				: 20/02/2004 16:16:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Gestion du click sur un $$HEX1$$e900$$ENDHEX$$tat.
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------

Long 		lRow

lRow = This.GetClickedRow()

If lRow > 0 then 
	This.SelectRow ( 0, False 	 )
	This.SelectRow ( lRow, True )
	This.SetRow		( lRow 	    )
End IF


end on

type dw_param_droit from datawindow within w_t_sp_droit_courrier
integer x = 1760
integer y = 196
integer width = 1792
integer height = 1468
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_sp_droit_courrier_param_vide"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;//*-----------------------------------------------------------------
//*
//* Objet         : w_t_sp_droit_courrier
//* Evenement     : ItemChanged
//* Auteur        : Fabry JF
//* Date          : 20/02/2004 11:09:17
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//		FPI	03/07/2014		[VDOC14806] exploitation du retour de controler
//*-----------------------------------------------------------------
Integer iRet

iRet=invDrtCour.Uf_ControlerZone ( GetColumnName (), GetText (), GetRow () )

Return iRet
end event

type dw_droit_existant from datawindow within w_t_sp_droit_courrier
boolean visible = false
integer x = 2679
integer y = 12
integer width = 357
integer height = 144
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_sp_droit_courrier_existant"
boolean livescroll = true
end type

type pb_appliquer from picturebutton within w_t_sp_droit_courrier
integer x = 503
integer y = 20
integer width = 233
integer height = 136
integer taborder = 70
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Appliquer"
string picturename = "k:\pb4obj\bmp\8_savfil.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : pb_Appliquer
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 20/02/2004 16:09:42
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
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

Parent.Wf_Appliquer ()
end on

type st_temoin_sav from statictext within w_t_sp_droit_courrier
integer x = 741
integer y = 24
integer width = 69
integer height = 56
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "*"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_recherche from datawindow within w_t_sp_droit_courrier
integer x = 846
integer y = 60
integer width = 1966
integer height = 92
integer taborder = 110
boolean bringtotop = true
string title = "none"
string dataobject = "d_sp_droit_courrier_recherche"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event editchanged;String sTxt
Long lRow=0

if data="" Then return

if Upper(dwo.Name)="CODE" Then
	dw_1.SetSort("ID_OPER A")
	dw_1.sort()
	lRow=dw_1.Find("ID_OPER LIKE '" + data + "%'",1,dw_1.rowcount())
End if

if lRow > 0 Then
	dw_1.selectrow( 0, FALSE)
	dw_1.selectrow( lRow, TRUE)
	dw_1.scrolltorow( lRow)
End if
end event

type pb_recherche from picturebutton within w_t_sp_droit_courrier
integer x = 2843
integer y = 52
integer width = 110
integer height = 96
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "Search!"
alignment htextalign = left!
end type

event clicked;String sIdOper, sNom, sSearch
Long lRow=0

dw_recherche.accepttext()

sIdOper=dw_recherche.GetItemString( 1, "CODE")
sNom=dw_recherche.GetItemString( 1, "NOM")

sSearch=""

if not isNull(sIdOper) Then 
	sSearch="Pos(ID_OPER,'" + sIdOper + "')=1"
End if

if not isNull(sNom) Then 
	if sSearch <> "" Then sSearch+=" AND "
	sSearch+="Pos(NOM,'" + sNom + "')=1"
End if

If sSearch="" Then return 

lRow=dw_1.Find(sSearch,1,dw_1.rowcount())

if lRow > 0 Then
	dw_1.selectrow( 0, FALSE)
	dw_1.selectrow( lRow, TRUE)
	dw_1.scrolltorow( lRow)
End if
end event

