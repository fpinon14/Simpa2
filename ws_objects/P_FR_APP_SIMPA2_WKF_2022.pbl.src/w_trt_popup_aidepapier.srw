HA$PBExportHeader$w_trt_popup_aidepapier.srw
$PBExportComments$-} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement SIMPLE pour afficher une aide sur la tarification des papiers. (DCMP 010375)
forward
global type w_trt_popup_aidepapier from window
end type
type dw_papier from datawindow within w_trt_popup_aidepapier
end type
type dw_bandeau from datawindow within w_trt_popup_aidepapier
end type
type cb_fermer from commandbutton within w_trt_popup_aidepapier
end type
end forward

global type w_trt_popup_aidepapier from window
integer y = 2284
integer width = 1152
integer height = 712
boolean titlebar = true
string title = "Aide sur le TARIF de diff$$HEX1$$e900$$ENDHEX$$rents papiers"
windowtype windowtype = popup!
long backcolor = 12632256
dw_papier dw_papier
dw_bandeau dw_bandeau
cb_fermer cb_fermer
end type
global w_trt_popup_aidepapier w_trt_popup_aidepapier

type variables
Private :
	N_Cst_AidePapier		invAidePapier
end variables

forward prototypes
private subroutine wf_positionnerobjet ()
end prototypes

private subroutine wf_positionnerobjet ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Popup_AidePapier::Wf_PositionnerObjet		(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 13/10/2001 16:10:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Positionnement dynamique des objets de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//* #1 [DCMP-060643]-29/09/2006-PHG Gestion repertoire temporaire
//*-----------------------------------------------------------------

String sFicConfig, sSection
Long lX, lY
Environment		nvEnv

GetEnvironment ( nvEnv )
// #1 [DCMP-060643]-29/09/2006-PHG Gestion repertoire temporaire
//sFicConfig	= ProfileString ( stGlb.sWinDir + "\MAJPOST.INI", "PARAM", "DESTINATION", "C:" ) + "\INTERRO.INI"
sFicConfig	= stGlb.sRepTempo + "INTERRO.INI"
sSection		= 	stGLB.sCodAppli + " " + "TARIF_PAPIER"

If	nvEnv.ScreenHeight > 800	Then
	lY = ProfileInt ( sFicConfig, sSection, "Y", 2285 )
	lX	= ProfileInt ( sFicConfig, sSection, "X", 1 )
Else
	lY = ProfileInt ( sFicConfig, sSection, "Y", 320 )
	lX	= ProfileInt ( sFicConfig, sSection, "X", 360 )
End If

/*------------------------------------------------------------------*/
/* Position de la fen$$HEX1$$ea00$$ENDHEX$$tre.                                          */
/*------------------------------------------------------------------*/
This.X			=   lX
This.Y			=   lY
This.Width		= 3000
This.Height		= 1689

/*------------------------------------------------------------------*/
/* Position de la DataWindow servant au Bandeau de s$$HEX1$$e900$$ENDHEX$$lection.       */
/*------------------------------------------------------------------*/
Dw_Bandeau.X			=  310
Dw_Bandeau.Y			=   25
Dw_Bandeau.Width		= 2310
Dw_Bandeau.Height		=  175

/*------------------------------------------------------------------*/
/* DataWindow pour la visualisation des papiers.                    */
/*------------------------------------------------------------------*/
Dw_Papier.X				=   30
Dw_Papier.Y				=  231
Dw_Papier.Width		= 2885
Dw_Papier.Height		= 1295

/*------------------------------------------------------------------*/
/* Bouton FERMER.                                                   */
/*------------------------------------------------------------------*/
Cb_Fermer.X				=   14
Cb_Fermer.Y				=   13
Cb_Fermer.Width		=  284
Cb_Fermer.Height		=  109

end subroutine

on open;//*-----------------------------------------------------------------
//*
//* Objet			: W_Trt_Popup_AidePapier
//* Evenement 		: Open
//* Auteur			: Erick John Stark
//* Date				: 15/10/2001 14:58:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: 
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On s'occupe du positionnement dynamique de la fen$$HEX1$$ea00$$ENDHEX$$tre et des     */
/* objets.                                                          */
/*------------------------------------------------------------------*/
This.Wf_PositionnerObjet ()
/*------------------------------------------------------------------*/
/* On instancie le NVUO de traitement.                              */
/*------------------------------------------------------------------*/
invAidePapier	= CREATE N_Cst_AidePapier

invAidePapier.uf_Initialiser ( dw_Bandeau, dw_Papier )

end on

on w_trt_popup_aidepapier.create
this.dw_papier=create dw_papier
this.dw_bandeau=create dw_bandeau
this.cb_fermer=create cb_fermer
this.Control[]={this.dw_papier,&
this.dw_bandeau,&
this.cb_fermer}
end on

on w_trt_popup_aidepapier.destroy
destroy(this.dw_papier)
destroy(this.dw_bandeau)
destroy(this.cb_fermer)
end on

type dw_papier from datawindow within w_trt_popup_aidepapier
integer x = 23
integer y = 180
integer width = 608
integer height = 344
integer taborder = 30
string dataobject = "d_sp_aide_tarif_papier"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleshadowbox!
end type

type dw_bandeau from datawindow within w_trt_popup_aidepapier
integer x = 311
integer y = 24
integer width = 750
integer height = 96
integer taborder = 20
string dataobject = "d_sp_aide_tarif_papier_bandeau"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//*-----------------------------------------------------------------
//*
//* Objet			: W_Trt_PopUp_AidePapier::Dw_Bandeau		(EXTEND)
//* Evenement 		: ItemChanged				
//* Auteur			: Erick John Stark
//* Date				: 15/10/2001 14:58:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Contr$$HEX1$$f400$$ENDHEX$$le de champs
//*				  
//* Arguments		: 
//*
//* Retourne		: 
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

String sVal, sNomCol
Integer iAction

sNomCol	= Upper ( This.GetColumnName () )
sVal		= This.GetText ()

iAction = invAidePapier.Uf_ControlerZone ( sNomCol, sVal )


//Migration PB8-WYNIWYG-03/2006 CP
//This.SetActionCode ( iAction )
		Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 CP		


end event

type cb_fermer from commandbutton within w_trt_popup_aidepapier
integer x = 14
integer y = 12
integer width = 283
integer height = 108
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Fermer"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: W_Trt_PopUp_AidePapier::Cb_Fermer		(EXTEND)
//* Evenement 		: Clicked				
//* Auteur			: Erick John Stark
//* Date				: 15/10/2001 14:58:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Fermeture de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*				  
//* Arguments		: 
//*
//* Retourne		: 
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Long lCoord[2]

lCoord[1]	= Parent.X
lCoord[2]	= Parent.Y

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie s'il faut sauvegarder les coordonn$$HEX1$$e900$$ENDHEX$$es de la fen$$HEX1$$ea00$$ENDHEX$$tre.  */
/*------------------------------------------------------------------*/
If	dw_Bandeau.GetItemString ( 1, "ALT_SAUVE" ) = "O"	Then invAidePapier.uf_Sauvegarder_Position ( lCoord )

Close ( Parent )


end on

