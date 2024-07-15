HA$PBExportHeader$w_sp_trt_int_fic_suivicmde.srw
$PBExportComments$Fen$$HEX1$$ea00$$ENDHEX$$tre d'int$$HEX1$$e900$$ENDHEX$$gration du fichier suivi des cmdes en provenance du FOURNISSEUR.
forward
global type w_sp_trt_int_fic_suivicmde from w_8_accueil
end type
type dw_fournisseur from datawindow within w_sp_trt_int_fic_suivicmde
end type
type pb_lancer from picturebutton within w_sp_trt_int_fic_suivicmde
end type
type cb_fic from commandbutton within w_sp_trt_int_fic_suivicmde
end type
type st_1 from statictext within w_sp_trt_int_fic_suivicmde
end type
type st_nomfic from statictext within w_sp_trt_int_fic_suivicmde
end type
type dw_fichier_fournisseur from datawindow within w_sp_trt_int_fic_suivicmde
end type
type dw_suivi_trt from datawindow within w_sp_trt_int_fic_suivicmde
end type
type lb_liste_fichiers from listbox within w_sp_trt_int_fic_suivicmde
end type
type st_titre from statictext within w_sp_trt_int_fic_suivicmde
end type
type pb_trace from picturebutton within w_sp_trt_int_fic_suivicmde
end type
type dw_tri from datawindow within w_sp_trt_int_fic_suivicmde
end type
type dw_stk_rep_fourn from datawindow within w_sp_trt_int_fic_suivicmde
end type
end forward

global type w_sp_trt_int_fic_suivicmde from w_8_accueil
integer width = 2981
integer height = 1208
dw_fournisseur dw_fournisseur
pb_lancer pb_lancer
cb_fic cb_fic
st_1 st_1
st_nomfic st_nomfic
dw_fichier_fournisseur dw_fichier_fournisseur
dw_suivi_trt dw_suivi_trt
lb_liste_fichiers lb_liste_fichiers
st_titre st_titre
pb_trace pb_trace
dw_tri dw_tri
dw_stk_rep_fourn dw_stk_rep_fourn
end type
global w_sp_trt_int_fic_suivicmde w_sp_trt_int_fic_suivicmde

type variables
Private :

n_cst_int_fic_suivicmd	invFicSuiviCmd
end variables

forward prototypes
public subroutine wf_positionnerobjets ()
end prototypes

public subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Objet 			: w_trt_int_fic_article
//* Evenement 		: wf_PositionnerObjets
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

st_Titre.x	= 1523
st_Titre.y	=   53
st_Titre.width	= 2026
st_Titre.height	=   93

dw_Fournisseur.x	= 220
dw_Fournisseur.y	= 277
dw_Fournisseur.width	= 1395
dw_Fournisseur.height	=  109

st_1.x	= 129
st_1.y	= 421
st_1.width	= 380
st_1.height	=  73

st_Nomfic.x	= 540
st_Nomfic.y	= 421
st_Nomfic.width	= 2500
st_Nomfic.height	=  73

cb_fic.x	= 3050 
cb_fic.y	= 413
cb_fic.width	= 106
cb_fic.height	= 85

dw_suivi_trt.x	= 133
dw_suivi_trt.y	= 549
dw_suivi_trt.width	= 3347
dw_suivi_trt.height	=  1129
end subroutine

on ue_initialiser;call w_8_accueil::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: w_trt_int_fic_article
//* Evenement 		: ue_initialiser
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass	stPass

wf_PositionnerObjets ()

invFicSuiviCmd = Create n_cst_int_fic_SuiviCmd

This.Title = "Int$$HEX1$$e900$$ENDHEX$$gration du fichier de suivi des commandes"
st_Titre.Text = "Int$$HEX1$$e900$$ENDHEX$$gration du fichier de suivi des commandes"

stPass.dwNorm [1] = dw_Fournisseur
stPass.dwNorm [2] = dw_Fichier_Fournisseur
stPass.dwNorm [3] = dw_Suivi_Trt
stPass.dwNorm [4] = dw_Tri
stPass.dwNorm [5] = dw_Stk_Rep_Fourn

invFicSuiviCmd.uf_Initialiser ( stPass		,&
									st_nomfic 	,&
									lb_Liste_Fichiers  )

/*------------------------------------------------------------------*/
/* Lancement automatique par OpCon/XPS                              */
/*------------------------------------------------------------------*/
If gbOpCon Then
	pb_Lancer.PostEvent ( Clicked! )
End If

end on

on show;call w_8_accueil::show;//*-----------------------------------------------------------------
//*
//* Objet 			: w_trt_int_fic_article
//* Evenement 		: show
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

invFicSuiviCmd.uf_Preparer ( )
end on

on close;call w_8_accueil::close;//*-----------------------------------------------------------------
//*
//* Objet 			: w_trt_int_fic_article
//* Evenement 		: Close
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If IsValid ( invFicSuiviCmd ) Then Destroy invFicSuiviCmd


end on

on w_sp_trt_int_fic_suivicmde.create
int iCurrent
call super::create
this.dw_fournisseur=create dw_fournisseur
this.pb_lancer=create pb_lancer
this.cb_fic=create cb_fic
this.st_1=create st_1
this.st_nomfic=create st_nomfic
this.dw_fichier_fournisseur=create dw_fichier_fournisseur
this.dw_suivi_trt=create dw_suivi_trt
this.lb_liste_fichiers=create lb_liste_fichiers
this.st_titre=create st_titre
this.pb_trace=create pb_trace
this.dw_tri=create dw_tri
this.dw_stk_rep_fourn=create dw_stk_rep_fourn
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_fournisseur
this.Control[iCurrent+2]=this.pb_lancer
this.Control[iCurrent+3]=this.cb_fic
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_nomfic
this.Control[iCurrent+6]=this.dw_fichier_fournisseur
this.Control[iCurrent+7]=this.dw_suivi_trt
this.Control[iCurrent+8]=this.lb_liste_fichiers
this.Control[iCurrent+9]=this.st_titre
this.Control[iCurrent+10]=this.pb_trace
this.Control[iCurrent+11]=this.dw_tri
this.Control[iCurrent+12]=this.dw_stk_rep_fourn
end on

on w_sp_trt_int_fic_suivicmde.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_fournisseur)
destroy(this.pb_lancer)
destroy(this.cb_fic)
destroy(this.st_1)
destroy(this.st_nomfic)
destroy(this.dw_fichier_fournisseur)
destroy(this.dw_suivi_trt)
destroy(this.lb_liste_fichiers)
destroy(this.st_titre)
destroy(this.pb_trace)
destroy(this.dw_tri)
destroy(this.dw_stk_rep_fourn)
end on

type cb_debug from w_8_accueil`cb_debug within w_sp_trt_int_fic_suivicmde
end type

type pb_retour from w_8_accueil`pb_retour within w_sp_trt_int_fic_suivicmde
integer width = 242
integer height = 144
integer taborder = 90
end type

type pb_interro from w_8_accueil`pb_interro within w_sp_trt_int_fic_suivicmde
boolean visible = false
integer x = 2601
integer y = 40
integer taborder = 110
boolean enabled = false
end type

type pb_creer from w_8_accueil`pb_creer within w_sp_trt_int_fic_suivicmde
boolean visible = false
integer x = 2359
integer y = 40
integer taborder = 100
boolean enabled = false
end type

type dw_1 from w_8_accueil`dw_1 within w_sp_trt_int_fic_suivicmde
integer x = 3337
integer y = 36
integer width = 297
integer height = 268
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

type pb_tri from w_8_accueil`pb_tri within w_sp_trt_int_fic_suivicmde
boolean visible = false
integer x = 2843
integer y = 40
integer taborder = 150
boolean enabled = false
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_sp_trt_int_fic_suivicmde
integer x = 3086
integer y = 40
end type

type dw_fournisseur from datawindow within w_sp_trt_int_fic_suivicmde
integer x = 187
integer y = 256
integer width = 375
integer height = 308
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_choix_fournisseur"
boolean border = false
end type

event itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: w_sp_trt_int_fic_article::dw_Fournisseur
//* Evenement 		: itemchanged
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*		FPI	    19/04/2012	[SAISIE_FOUR_MANU] Saisie manuelle du fournisseur		  
//*-----------------------------------------------------------------
Long lRow
DataWindowChild ldwc

St_Nomfic.Text = ""

// [SAISIE_FOUR_MANU]
This.getChild("ID_FOURN",ldwc)

lRow =ldwc.Find ( "ID_CODE = '" +  This.GetText ()  + "'", 1, ldwc.RowCount () )
If lRow <= 0 Then
	return  1
End if
// :[SAISIE_FOUR_MANU]

invFicSuiviCmd.uf_Detection_Auto_NomFic ( This.GetText () )
end event

event itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: w_sp_trt_int_fic_suivicmde::dw_Fournisseur
//* Evenement 		: itemerror
//* Auteur			: FPI
//* Date				: 19/04/2012
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [SAISIE_FOUR_MANU] Saisie manuelle du fournisseur		  
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

if Upper(dwo.Name) = "ID_FOURN" Then
	stMessage.berreurg=TRUE
	stMessage.Icon=Information!
	stMessage.scode="GENE004"
	stMessage.sVar[1]="Ce code fournisseur"
	stMessage.sTitre="Int$$HEX1$$e900$$ENDHEX$$gration des fichiers suivi de commandes - Saisie du fournisseur"
	
	f_message(stMessage)
	
	Return 1
End if
end event

type pb_lancer from picturebutton within w_sp_trt_int_fic_suivicmde
integer x = 512
integer y = 16
integer width = 233
integer height = 136
integer taborder = 140
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Lancer"
string picturename = "k:\pb4obj\bmp\8_valid.bmp"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: w_trt_int_fic_article::pb_lancer
//* Evenement 		: Clicked
//* Auteur			: Fabry JF
//* Date				: 31/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Int iErr

If dw_fournisseur.AcceptText( ) <> 1 Then Return

iErr = 0
This.Enabled = False

st_Titre.BackColor = 12632256

/*------------------------------------------------------------------*/
/* Pour le traitement automatique par OpCon/XPS, le controle de     */
/* saisie se fait dans le nvuo.                                     */
/*------------------------------------------------------------------*/
If gbOpCon Then
	iErr = invFicSuiviCmd.uf_Trt_OpCon ( "LANCER" )

/*------------------------------------------------------------------*/
/* Traitement Manuel, $$HEX2$$e0002000$$ENDHEX$$l'ancienne !                                */
/*------------------------------------------------------------------*/
Else
	If invFicSuiviCmd.uf_Controler_Saisie () > 0 Then
		iErr = invFicSuiviCmd.uf_Lancer_Trt () 
	End If 
End If


If iErr > 0 Then
	st_Titre.BackColor = 65280
Else
	st_Titre.BackColor = 255
End If 

This.Enabled = True

/*------------------------------------------------------------------*/
/* OpCon/XPS                                                        */
/*------------------------------------------------------------------*/
If gbOpCon Then 
	iErr = invFicSuiviCmd.uf_Trt_OpCon ( "FIN_TRT" )
	Pb_Retour.TriggerEvent ( Clicked! )
End If
end event

type cb_fic from commandbutton within w_sp_trt_int_fic_suivicmde
integer x = 1851
integer y = 256
integer width = 375
integer height = 308
integer taborder = 40
boolean bringtotop = true
integer textsize = -15
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "..."
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: w_trt_int_fic_article::cb_Fic
//* Evenement 		: ue_initialiser
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If IsNull ( dw_Fournisseur.GetItemString ( 1, "ID_FOURN" ) ) Then
	stMessage.sTitre = "Choix du fichier"
	stMessage.sCode = "COMD001"
	stMessage.icon = Information!
	F_Message ( stMessage )
Else
	invFicSuiviCmd.uf_Bouton_ChxFichier ( )
End If


end on

type st_1 from statictext within w_sp_trt_int_fic_suivicmde
integer x = 603
integer y = 256
integer width = 375
integer height = 308
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fichier $$HEX2$$e0002000$$ENDHEX$$int$$HEX1$$e900$$ENDHEX$$grer"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_nomfic from statictext within w_sp_trt_int_fic_suivicmde
integer x = 1019
integer y = 256
integer width = 375
integer height = 308
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_fichier_fournisseur from datawindow within w_sp_trt_int_fic_suivicmde
boolean visible = false
integer x = 69
integer y = 744
integer width = 247
integer height = 196
integer taborder = 60
boolean bringtotop = true
boolean livescroll = true
end type

event itemerror;
invFicSuiviCmd.uf_Set_NumLigErrImport ( row, dwo.name, data )

invFicSuiviCmd.uf_Charger_FichierFournHALT ( row, dwo.name, data )
	
	

end event

type dw_suivi_trt from datawindow within w_sp_trt_int_fic_suivicmde
integer x = 1435
integer y = 256
integer width = 375
integer height = 308
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_suivi_trt"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type lb_liste_fichiers from listbox within w_sp_trt_int_fic_suivicmde
boolean visible = false
integer x = 393
integer y = 744
integer width = 247
integer height = 196
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type st_titre from statictext within w_sp_trt_int_fic_suivicmde
integer x = 2267
integer y = 256
integer width = 375
integer height = 308
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type pb_trace from picturebutton within w_sp_trt_int_fic_suivicmde
integer x = 754
integer y = 16
integer width = 233
integer height = 136
integer taborder = 120
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Trace"
string picturename = "k:\pb4obj\bmp\ctl.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: w_trt_int_fic_article::pb_lancer
//* Evenement 		: Clicked
//* Auteur			: Fabry JF
//* Date				: 31/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Run ( "NOTEPAD.EXE " + ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_GEN", "" ) + "LOGCMD\FIC_MOV.LOG" )



end on

type dw_tri from datawindow within w_sp_trt_int_fic_suivicmde
boolean visible = false
integer x = 718
integer y = 744
integer width = 247
integer height = 196
integer taborder = 70
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_trt_tri"
end type

type dw_stk_rep_fourn from datawindow within w_sp_trt_int_fic_suivicmde
boolean visible = false
integer x = 1042
integer y = 744
integer width = 247
integer height = 196
integer taborder = 80
boolean bringtotop = true
boolean enabled = false
string dataobject = "dddw_liste_fournisseurs"
boolean livescroll = true
end type

