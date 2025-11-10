HA$PBExportHeader$w_sp_trt_gen_fic_commande.srw
$PBExportComments$Fen$$HEX1$$ea00$$ENDHEX$$tre de g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration du fichier de commandes $$HEX2$$e0002000$$ENDHEX$$destination du fournisseur.
forward
global type w_sp_trt_gen_fic_commande from w_8_accueil
end type
type dw_fournisseur from datawindow within w_sp_trt_gen_fic_commande
end type
type pb_lancer from picturebutton within w_sp_trt_gen_fic_commande
end type
type dw_chargement from datawindow within w_sp_trt_gen_fic_commande
end type
type dw_suivi_trt from datawindow within w_sp_trt_gen_fic_commande
end type
type lb_liste_fichiers from listbox within w_sp_trt_gen_fic_commande
end type
type st_titre from statictext within w_sp_trt_gen_fic_commande
end type
type dw_gen_commande from datawindow within w_sp_trt_gen_fic_commande
end type
type dw_liste_lots from datawindow within w_sp_trt_gen_fic_commande
end type
type pb_trace from picturebutton within w_sp_trt_gen_fic_commande
end type
type dw_stk_rep_fourn from datawindow within w_sp_trt_gen_fic_commande
end type
type dw_charg_articles from datawindow within w_sp_trt_gen_fic_commande
end type
type dw_charg_hlr from datawindow within w_sp_trt_gen_fic_commande
end type
type dw_detpro from datawindow within w_sp_trt_gen_fic_commande
end type
type dw_chargement2 from datawindow within w_sp_trt_gen_fic_commande
end type
end forward

global type w_sp_trt_gen_fic_commande from w_8_accueil
integer width = 4041
integer height = 2408
dw_fournisseur dw_fournisseur
pb_lancer pb_lancer
dw_chargement dw_chargement
dw_suivi_trt dw_suivi_trt
lb_liste_fichiers lb_liste_fichiers
st_titre st_titre
dw_gen_commande dw_gen_commande
dw_liste_lots dw_liste_lots
pb_trace pb_trace
dw_stk_rep_fourn dw_stk_rep_fourn
dw_charg_articles dw_charg_articles
dw_charg_hlr dw_charg_hlr
dw_detpro dw_detpro
dw_chargement2 dw_chargement2
end type
global w_sp_trt_gen_fic_commande w_sp_trt_gen_fic_commande

type variables
Private :

n_cst_gen_fic_commande	invFicCmde
String			isTypTrt
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
//* MAJ PAR		Date				Modification
//*
//* #1  CAG		08/10/2002		Modification SFR : Ajout d'une colonne pour la dw de reg$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration
//*-----------------------------------------------------------------

st_Titre.x	= 1669
st_Titre.y	=   69
st_Titre.width	= 1861
st_Titre.height	=   93

dw_Fournisseur.x	= 220
dw_Fournisseur.y	= 277
dw_Fournisseur.width	= 1395
dw_Fournisseur.height	=  109

dw_suivi_trt.x	= 133
dw_suivi_trt.y	= 869
dw_suivi_trt.width	= 3347
dw_suivi_trt.height	=  809

/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
dw_liste_lots.width	= 1880
dw_liste_lots.x	= dw_suivi_trt.x + ( ( dw_suivi_trt.width - dw_liste_lots.width ) / 2 )
dw_liste_lots.y	= 221
dw_liste_lots.height	=  573

end subroutine

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: w_trt_int_fic_article
//* Evenement 		: ue_initialiser
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//*
//* #1	CAG		08/10/02	Modification SFR : Ajout d'une dw
//*						      pour les articles des commandes Cegetel
//* #2	 FPI	 28/10/2009	[FNAC_EPT.BGE].FPI Ajout d'un param dw_det_pro
//        JFF    06/08/2012  [BLCODE]
//*-----------------------------------------------------------------

s_Pass	stPass

wf_PositionnerObjets ()

CHOOSE CASE stGlb.sMessageErreur
	CASE "GENERER"
		This.Title = "G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration des fichiers de commandes"
		st_Titre.Text = "G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration des fichiers de commandes"
		isTypTrt = "G"
		dw_Liste_Lots.Hide ()
		dw_fournisseur.show ()

	CASE "REGENERER"
		This.Title = "Reg$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rer un fichier $$HEX2$$e0002000$$ENDHEX$$partir d'un lot"
		st_Titre.Text = "Reg$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rer un fichier $$HEX2$$e0002000$$ENDHEX$$partir d'un lot"
		isTypTrt = "R"
		dw_Liste_Lots.show ()
		dw_fournisseur.Hide ()
END CHOOSE

stPass.sTab [1] = isTypTrt

invFicCmde = Create n_cst_gen_fic_commande

stPass.dwNorm [1] = dw_Fournisseur
stPass.dwNorm [2] = dw_Chargement
stPass.dwNorm [3] = dw_Suivi_Trt
stPass.dwNorm [4] = dw_gen_commande
stPass.dwNorm [5] = dw_liste_lots
stPass.dwNorm [6] = dw_Stk_Rep_Fourn
/*------------------------------------------------------------------*/
/* #1										                                   */
/*------------------------------------------------------------------*/
stPass.dwNorm [7] = dw_Charg_Articles
stPass.dwNorm [8] = dw_Charg_Hlr

stPass.dwNorm [9] = dw_detpro // #2 [FNAC_EPT.BGE].FPI

// [BLCODE]
stPass.dwNorm [10] = dw_Chargement2

invFicCmde.uf_Initialiser ( stPass		,&
									lb_Liste_Fichiers  )


/*------------------------------------------------------------------*/
/* Lancement automatique par OpCon/XPS                              */
/*------------------------------------------------------------------*/
If gbOpCon Then
	pb_Lancer.PostEvent ( Clicked! )
End If

end event

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

invFicCmde.uf_Preparer ( )
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

If IsValid ( invFicCmde ) Then Destroy invFicCmde


end on

on w_sp_trt_gen_fic_commande.create
int iCurrent
call super::create
this.dw_fournisseur=create dw_fournisseur
this.pb_lancer=create pb_lancer
this.dw_chargement=create dw_chargement
this.dw_suivi_trt=create dw_suivi_trt
this.lb_liste_fichiers=create lb_liste_fichiers
this.st_titre=create st_titre
this.dw_gen_commande=create dw_gen_commande
this.dw_liste_lots=create dw_liste_lots
this.pb_trace=create pb_trace
this.dw_stk_rep_fourn=create dw_stk_rep_fourn
this.dw_charg_articles=create dw_charg_articles
this.dw_charg_hlr=create dw_charg_hlr
this.dw_detpro=create dw_detpro
this.dw_chargement2=create dw_chargement2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_fournisseur
this.Control[iCurrent+2]=this.pb_lancer
this.Control[iCurrent+3]=this.dw_chargement
this.Control[iCurrent+4]=this.dw_suivi_trt
this.Control[iCurrent+5]=this.lb_liste_fichiers
this.Control[iCurrent+6]=this.st_titre
this.Control[iCurrent+7]=this.dw_gen_commande
this.Control[iCurrent+8]=this.dw_liste_lots
this.Control[iCurrent+9]=this.pb_trace
this.Control[iCurrent+10]=this.dw_stk_rep_fourn
this.Control[iCurrent+11]=this.dw_charg_articles
this.Control[iCurrent+12]=this.dw_charg_hlr
this.Control[iCurrent+13]=this.dw_detpro
this.Control[iCurrent+14]=this.dw_chargement2
end on

on w_sp_trt_gen_fic_commande.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_fournisseur)
destroy(this.pb_lancer)
destroy(this.dw_chargement)
destroy(this.dw_suivi_trt)
destroy(this.lb_liste_fichiers)
destroy(this.st_titre)
destroy(this.dw_gen_commande)
destroy(this.dw_liste_lots)
destroy(this.pb_trace)
destroy(this.dw_stk_rep_fourn)
destroy(this.dw_charg_articles)
destroy(this.dw_charg_hlr)
destroy(this.dw_detpro)
destroy(this.dw_chargement2)
end on

type cb_debug from w_8_accueil`cb_debug within w_sp_trt_gen_fic_commande
end type

type pb_retour from w_8_accueil`pb_retour within w_sp_trt_gen_fic_commande
integer width = 242
integer height = 144
integer taborder = 80
end type

type pb_interro from w_8_accueil`pb_interro within w_sp_trt_gen_fic_commande
boolean visible = false
integer x = 2601
integer y = 40
integer taborder = 100
boolean enabled = false
end type

type pb_creer from w_8_accueil`pb_creer within w_sp_trt_gen_fic_commande
boolean visible = false
integer x = 2359
integer y = 40
integer taborder = 90
boolean enabled = false
end type

type dw_1 from w_8_accueil`dw_1 within w_sp_trt_gen_fic_commande
integer x = 3337
integer y = 36
integer width = 297
integer height = 268
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

type pb_tri from w_8_accueil`pb_tri within w_sp_trt_gen_fic_commande
boolean visible = false
integer x = 2843
integer y = 40
integer taborder = 170
boolean enabled = false
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_sp_trt_gen_fic_commande
integer x = 3086
integer y = 40
end type

type dw_fournisseur from datawindow within w_sp_trt_gen_fic_commande
integer x = 219
integer y = 276
integer width = 384
integer height = 288
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_choix_fournisseur"
boolean border = false
end type

event itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: w_sp_trt_gen_fic_commande::dw_Fournisseur
//* Evenement 		: itemchanged
//* Auteur			: FPI
//* Date				: 19/04/2012
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [SAISIE_FOUR_MANU] Saisie manuelle du fournisseur		  
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------
Long lRow
DataWindowChild ldwc

// [SAISIE_FOUR_MANU]
This.getChild("ID_FOURN",ldwc)

lRow =ldwc.Find ( "ID_CODE = '" +  This.GetText ()  + "'", 1, ldwc.RowCount () )
If lRow <= 0 Then
	return  1
End if
// :[SAISIE_FOUR_MANU]
end event

event itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: w_sp_trt_gen_fic_commande::dw_Fournisseur
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
	stMessage.sTitre="G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration de fichiers de commandes - Saisie du fournisseur"
	
	f_message(stMessage)
	
	Return 1
End if
end event

type pb_lancer from picturebutton within w_sp_trt_gen_fic_commande
integer x = 512
integer y = 16
integer width = 233
integer height = 136
integer taborder = 150
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
	iErr = invFicCmde.uf_Trt_OpCon ( "LANCER" )

/*------------------------------------------------------------------*/
/* Traitement Manuel, $$HEX2$$e0002000$$ENDHEX$$l'ancienne !                                */
/*------------------------------------------------------------------*/
Else
	If invFicCmde.uf_Controler_Saisie () > 0 Then
		iErr = invFicCmde.uf_Lancer_Trt () 
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
	iErr = invFicCmde.uf_Trt_OpCon ( "FIN_TRT" )
	Pb_Retour.TriggerEvent ( Clicked! )
End If

end event

type dw_chargement from datawindow within w_sp_trt_gen_fic_commande
boolean visible = false
integer x = 174
integer y = 1784
integer width = 247
integer height = 196
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_article"
boolean livescroll = true
end type

event sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			: Dw_chargement
//* Evenement 		: SqlPreview
//* Auteur			: FABRY JF
//* Date				: 13/12/2010 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Suite bug relev$$HEX2$$e9002000$$ENDHEX$$par Arian Papillon, j'ajoute un "." pour 
//*					  transformer en d$$HEX1$$e900$$ENDHEX$$cimal
//* Commentaires	: [DECIMAL_PAPILLON]
//*				 
//* Arguments		: 
//*
//* Retourne		: NotFound
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF   13/12/2010   [DECIMAL_PAPILLON]
//* 
//*-----------------------------------------------------------------

Choose Case Left ( sqlsyntax, 4 )

	Case "UPDA"
	
		sqlsyntax = F_Critere_Decimal ( sqlsyntax )

		// Variante pour ce cas, le nom_zone est une string donc je retire le point de fin
		sqlsyntax = Left ( Trim ( sqlsyntax), Len ( Trim (sqlsyntax )) - 1 ) + " "
		This.SetSqlPreview ( sqlsyntax ) 
		
End Choose

end event

type dw_suivi_trt from datawindow within w_sp_trt_gen_fic_commande
integer x = 663
integer y = 276
integer width = 384
integer height = 288
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_suivi_trt"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type lb_liste_fichiers from listbox within w_sp_trt_gen_fic_commande
boolean visible = false
integer x = 434
integer y = 1792
integer width = 247
integer height = 196
integer taborder = 110
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

type st_titre from statictext within w_sp_trt_gen_fic_commande
integer x = 1106
integer y = 276
integer width = 384
integer height = 288
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration des fichiers de commandes"
alignment alignment = center!
boolean border = true
long bordercolor = 12632256
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_gen_commande from datawindow within w_sp_trt_gen_fic_commande
boolean visible = false
integer x = 704
integer y = 1792
integer width = 247
integer height = 196
integer taborder = 120
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_article"
boolean livescroll = true
end type

type dw_liste_lots from datawindow within w_sp_trt_gen_fic_commande
integer x = 1550
integer y = 276
integer width = 384
integer height = 288
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_liste_des_lots"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: w_trt_int_fic_article::dw_liste_lots
//* Evenement 		: clicked
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lRow

lRow = This.GetClickedRow ()

If lRow > 0 And lRow <= This.Rowcount () Then

	This.SelectRow ( 0, False )
	This.SelectRow ( lRow, True )
	This.ScrollToRow ( lRow ) 
	This.SetRow ( lRow ) 

End If
end on

type pb_trace from picturebutton within w_sp_trt_gen_fic_commande
integer x = 754
integer y = 16
integer width = 233
integer height = 136
integer taborder = 160
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Trace"
string picturename = "k:\pb4obj\bmp\ctl.bmp"
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

Run ( "NOTEPAD.EXE " + ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_GEN", "" ) + "LOGCMD\FIC_CMD.LOG" )


end event

type dw_stk_rep_fourn from datawindow within w_sp_trt_gen_fic_commande
boolean visible = false
integer x = 1993
integer y = 276
integer width = 384
integer height = 288
integer taborder = 50
boolean bringtotop = true
boolean enabled = false
string dataobject = "dddw_liste_fournisseurs"
boolean livescroll = true
end type

type dw_charg_articles from datawindow within w_sp_trt_gen_fic_commande
boolean visible = false
integer x = 174
integer y = 2016
integer width = 247
integer height = 196
integer taborder = 130
boolean bringtotop = true
boolean enabled = false
boolean livescroll = true
end type

type dw_charg_hlr from datawindow within w_sp_trt_gen_fic_commande
integer x = 434
integer y = 2016
integer width = 247
integer height = 196
integer taborder = 140
boolean bringtotop = true
boolean livescroll = true
end type

type dw_detpro from datawindow within w_sp_trt_gen_fic_commande
string tag = "[FNAC_EPT.BGE].FPI"
boolean visible = false
integer x = 37
integer y = 932
integer width = 169
integer height = 124
integer taborder = 40
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_lst_det_pro"
boolean livescroll = true
end type

type dw_chargement2 from datawindow within w_sp_trt_gen_fic_commande
boolean visible = false
integer x = 174
integer y = 1564
integer width = 247
integer height = 196
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_article"
boolean livescroll = true
end type

event sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			: Dw_chargement
//* Evenement 		: SqlPreview
//* Auteur			: FABRY JF
//* Date				: 13/12/2010 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Suite bug relev$$HEX2$$e9002000$$ENDHEX$$par Arian Papillon, j'ajoute un "." pour 
//*					  transformer en d$$HEX1$$e900$$ENDHEX$$cimal
//* Commentaires	: [DECIMAL_PAPILLON]
//*				 
//* Arguments		: 
//*
//* Retourne		: NotFound
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF   13/12/2010   [DECIMAL_PAPILLON]
//* 
//*-----------------------------------------------------------------

Choose Case Left ( sqlsyntax, 4 )

	Case "UPDA"
	
		sqlsyntax = F_Critere_Decimal ( sqlsyntax )

		// Variante pour ce cas, le nom_zone est une string donc je retire le point de fin
		sqlsyntax = Left ( Trim ( sqlsyntax), Len ( Trim (sqlsyntax )) - 1 ) + " "
		This.SetSqlPreview ( sqlsyntax ) 
		
End Choose

end event

