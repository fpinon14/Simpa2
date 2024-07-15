HA$PBExportHeader$w_t_sp_homonyme.srw
$PBExportComments$-} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement SIMPLE pour la recherche des homonymes.
forward
global type w_t_sp_homonyme from w_ancetre
end type
type pb_valider from u_8_pbvalider within w_t_sp_homonyme
end type
type pb_retour from u_8_pbretour within w_t_sp_homonyme
end type
type dw_1 from datawindow within w_t_sp_homonyme
end type
type dw_2 from datawindow within w_t_sp_homonyme
end type
type p_focus from picture within w_t_sp_homonyme
end type
end forward

global type w_t_sp_homonyme from w_ancetre
int X=1
int Y=1
int Width=3571
int Height=1745
boolean Visible=true
boolean TitleBar=true
string Title="Recherche des homonymes"
pb_valider pb_valider
pb_retour pb_retour
dw_1 dw_1
dw_2 dw_2
p_focus p_focus
end type
global w_t_sp_homonyme w_t_sp_homonyme

type variables
Private :
	w_Ancetre_Traitement	iwParentDet

	Long			ilRetour
end variables

on ue_initialiser;call w_ancetre::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Homonyme::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 09:55:15
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lTotHomonyme, lIdOrdre, lLig, lCpt

DataWindowChild dwChild, dwChild1

String sTitre, sRech

/*------------------------------------------------------------------*/
/* On positionne la variable qui permet d'attaquer la DW de la      */
/* fen$$HEX1$$ea00$$ENDHEX$$tre PARENT.                                                  */
/*------------------------------------------------------------------*/
iwParentDet = istPass.wParent

/*------------------------------------------------------------------*/
/* On rend la fen$$HEX1$$ea00$$ENDHEX$$tre PARENT non saisissable.                       */
/*------------------------------------------------------------------*/
iwParentDet.Enabled = False

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re toutes les lignes pour les homonymes.                */
/*------------------------------------------------------------------*/
istPass.dwNorm[1].ShareData ( dw_1 )

/*------------------------------------------------------------------*/
/* La DW dw_2 sert $$HEX2$$e0002000$$ENDHEX$$afficher les sinistres li$$HEX1$$e900$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$la personne.     */
/*------------------------------------------------------------------*/
lTotHomonyme = istPass.dwNorm[1].RowCount ()
istPass.dwNorm[1].RowsCopy ( 1, lTotHomonyme, Primary!, dw_2, 1, Primary! )

/*------------------------------------------------------------------*/
/* On affiche un indicateur sur DW_1.                               */
/*------------------------------------------------------------------*/
dw_1.SetRowFocusIndicator ( p_Focus, 50, 90 )

/*------------------------------------------------------------------*/
/* On s'occupe de faire apparaitre la civilit$$HEX2$$e9002000$$ENDHEX$$correctement.        */
/*------------------------------------------------------------------*/
istPass.dwNorm[1].GetChild ( "COD_CIV", dwChild )
dw_1.GetChild ( "COD_CIV", dwChild1 )
dwChild.ShareData ( dwChild1 )

/*------------------------------------------------------------------*/
/* On affiche le titre dans dw_1.                                   */
/*------------------------------------------------------------------*/
sTitre = "Le nom commence par " + Left ( iwParentDet.dw_1.GetItemString ( 1, "NOM" ), 5 ) + & 
			" - Le pr$$HEX1$$e900$$ENDHEX$$nom commence par " + Left ( iwParentDet.dw_1.GetItemString ( 1, "PRENOM" ), 5 )

sTitre = "st_Titre.Text = '" + sTitre  + "'"
dw_1.Modify ( sTitre )

/*------------------------------------------------------------------*/
/* On fait un petit traitement pour $$HEX1$$e900$$ENDHEX$$jecter les doublons sur dw_1.  */
/*------------------------------------------------------------------*/
lIdOrdre = 0
For	lCpt = lTotHomonyme To 1 Step -1
		If lIdOrdre = dw_1.GetItemNumber ( lCpt, "ID_ORDRE" ) Then
			dw_1.RowsDiscard ( lCpt, lCpt, Primary! )
		Else
			lIdOrdre = dw_1.GetItemNumber ( lCpt, "ID_ORDRE" )
		End If
Next

/*------------------------------------------------------------------*/
/* On recalcule le nombre de lignes restantes.                      */
/*------------------------------------------------------------------*/
lTotHomonyme = dw_1.RowCount ()

/*------------------------------------------------------------------*/
/* S'il existe un N$$HEX2$$b0002000$$ENDHEX$$d'ordre de positionn$$HEX1$$e900$$ENDHEX$$, on se met dessus,       */
/* sinon on se positionne sur la premi$$HEX1$$e800$$ENDHEX$$re ligne.                    */
/*------------------------------------------------------------------*/
lIdOrdre = iwParentDet.dw_1.GetItemNumber ( 1, "ID_ORDRE" )

If	Not IsNull ( lIdOrdre ) Then
	sRech	= "ID_ORDRE = " + String ( lIdOrdre )
	lLig	= dw_1.Find ( sRech, 1, lTotHomonyme )
Else
	lLig = 1
End If

dw_1.SetRow ( lLig )
dw_1.TriggerEvent ( RowFocusChanged! )

/*------------------------------------------------------------------*/
/* On affiche les deux DW.                                          */
/*------------------------------------------------------------------*/
dw_1.Visible = True
dw_2.Visible = True

pb_Retour.SetFocus ()

	
end on

on ue_valider;call w_ancetre::ue_valider;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Homonyme::Ue_Valider
//* Evenement 		: Ue_Valider
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 10:02:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lLig, lIdOrdre, lIdOrdreDepart, lIdSin
Boolean bErreur, bSinLie

/*------------------------------------------------------------------*/
/* La variable ilRetour sert $$HEX2$$e0002000$$ENDHEX$$savoir si on appuie sur le bouton    */
/* PRENDRE ou le bouton RETOUR. On vient d'appuyer sur le bouton    */
/* PRENDRE, on arme donc la valeur avec le N$$HEX2$$b0002000$$ENDHEX$$d'ordre de la ligne   */
/* s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e.                                                    */
/*------------------------------------------------------------------*/
lLig		= dw_1.GetRow ()
bErreur	= False

If	lLig > 0 Then
	lIdOrdre = dw_1.GetItemNumber ( lLig, "ID_ORDRE" )

/*------------------------------------------------------------------*/
/* Si le N$$HEX2$$b0002000$$ENDHEX$$d'ordre est NULL, le gestionnaire doit d'abord valider  */
/* le sinistre de cet assur$$HEX1$$e900$$ENDHEX$$.                                       */
/*------------------------------------------------------------------*/
	If	IsNull ( lIdOrdre ) Then
		bErreur = True
		
		lIdSin = dw_2.GetItemNumber ( 1, "ID_SIN" )

		stMessage.sTitre		= "Gestion des homonymes"
		stMessage.Icon			= StopSign!
		stMessage.bErreurG	= False
		stMessage.bTrace		= False
		stMessage.sVar[1]		= String ( lIdSin )
		stMessage.sCode		= "WORK290"

		F_Message ( stMessage )
	Else
		lIdOrdreDepart = iwParentDet.dw_1.GetItemNumber ( 1, "ID_ORDRE" )
/*------------------------------------------------------------------*/
/* Si le gestionnaire choisit un N$$HEX2$$b0002000$$ENDHEX$$d'ordre diff$$HEX1$$e900$$ENDHEX$$rent de celui      */
/* r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX2$$e9002000$$ENDHEX$$lors des sinistres li$$HEX1$$e900$$ENDHEX$$s, il y a une erreur. Il faut     */
/* corriger la base manuellement.                                   */
/*------------------------------------------------------------------*/
		bSinLie = istPass.bRetour
		If	lIdOrdre <> lIdOrdreDepart And bSinLie Then
			bErreur = True
		
			stMessage.sTitre		= "Gestion des homonymes"
			stMessage.Icon			= StopSign!
			stMessage.bErreurG	= False
			stMessage.bTrace		= False
			stMessage.sVar[1]		= String ( lIdOrdre )
			stMessage.sVar[2]		= String ( lIdOrdreDepart )
			stMessage.sCode		= "WORK300"

			F_Message ( stMessage )
		End If
	End If

	If	Not bErreur Then
		ilRetour = lIdOrdre

		This.TriggerEvent ( "Ue_Retour" )

	End If
End If
end on

on ue_retour;call w_ancetre::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Homonyme::Ue_Retour
//* Evenement 		: Ue_Retour
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 10:02:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On rend la fen$$HEX1$$ea00$$ENDHEX$$tre PARENT saisissable.                           */
/*------------------------------------------------------------------*/
iwParentDet.Enabled = True

/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$clenche le script de la fen$$HEX1$$ea00$$ENDHEX$$tre parent. On lui passe en     */
/* param$$HEX1$$e800$$ENDHEX$$tre la valeur ilRetour. Cela $$HEX1$$e900$$ENDHEX$$vite d'avoir deux            */
/* $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nements $$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$crire.                                            */
/*------------------------------------------------------------------*/
iwParentDet.TriggerEvent ( "Ue_Homonyme", 0, ilRetour )

/*------------------------------------------------------------------*/
/* On referme la fen$$HEX1$$ea00$$ENDHEX$$tre.                                           */
/*------------------------------------------------------------------*/
Close ( This )
end on

on we_childactivate;call w_ancetre::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Homonyme::We_ChildActivate
//* Evenement 		: We_ChildActivate
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:53:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.X			=    1
This.Y			=    1
This.Height		= 1769
This.Width		= 3598
end on

on open;call w_ancetre::open;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Homonyme::Open
//* Evenement 		: Open
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 09:49:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

istPass = Message.PowerObjectParm

/*------------------------------------------------------------------*/
/* La variable ilRetour sert $$HEX2$$e0002000$$ENDHEX$$savoir si on appuie sur le bouton    */
/* PRENDRE ou le bouton RETOUR. Par d$$HEX1$$e900$$ENDHEX$$faut on arme la valeur $$HEX2$$e0002000$$ENDHEX$$0,   */
/* ce qui correspond au bouton RETOUR.                              */
/*------------------------------------------------------------------*/
ilRetour = 0

This.PostEvent ( "Ue_Initialiser" )


end on

on w_t_sp_homonyme.create
int iCurrent
call w_ancetre::create
this.pb_valider=create pb_valider
this.pb_retour=create pb_retour
this.dw_1=create dw_1
this.dw_2=create dw_2
this.p_focus=create p_focus
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=pb_valider
this.Control[iCurrent+2]=pb_retour
this.Control[iCurrent+3]=dw_1
this.Control[iCurrent+4]=dw_2
this.Control[iCurrent+5]=p_focus
end on

on w_t_sp_homonyme.destroy
call w_ancetre::destroy
destroy(this.pb_valider)
destroy(this.pb_retour)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.p_focus)
end on

type pb_valider from u_8_pbvalider within w_t_sp_homonyme
int X=279
int Y=29
int TabOrder=20
string Text="&Prendre"
int TextSize=-7
string FaceName="Arial"
end type

type pb_retour from u_8_pbretour within w_t_sp_homonyme
int X=33
int Y=29
int TabOrder=10
boolean Cancel=true
end type

type dw_1 from datawindow within w_t_sp_homonyme
int X=37
int Y=181
int Width=2177
int Height=1453
int TabOrder=30
boolean Visible=false
string DataObject="d_sp_wkf_homonyme"
BorderStyle BorderStyle=StyleShadowBox!
boolean VScrollBar=true
end type

on rowfocuschanged;//*-----------------------------------------------------------------
//*
//* Objet 			: 
//* Evenement 		: RowFocusChanged
//* Auteur			: Erick John Stark
//* Date				: 27/08/1998 12:07:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lLigne, lIdOrdre, lTotSin
String sFiltre, sTitre

lLigne	=	This.GetRow ( )

If	lLigne > 0 Then

	This.ScrollToRow ( lLigne )
	This.SetRow ( lLigne )

	lIdOrdre = This.GetItemNumber ( lLigne, "ID_ORDRE" )
	If	IsNull ( lIdOrdre ) Then
		sFiltre = "IsNull ( ID_ORDRE )"
	Else
		sFiltre = "ID_ORDRE = " + String ( lIdOrdre )
	End If

	dw_2.SetFilter ( sFiltre )
	dw_2.Filter ()
	dw_2.Sort ()
	lTotSin = dw_2.RowCount ()

/*------------------------------------------------------------------*/
/* On affiche le titre dans dw_2.                                   */
/*------------------------------------------------------------------*/
	sTitre = "Liste des sinistres (" + String ( lTotSin ) + ") de " + dw_1.GetItemString ( lLigne, "NOM" ) + " " + dw_1.GetItemString ( lLigne, "PRENOM" )

	sTitre = "st_Titre.Text = '" + sTitre  + "'"
	dw_2.Modify ( sTitre )

End If




end on

type dw_2 from datawindow within w_t_sp_homonyme
int X=2250
int Y=189
int Width=1294
int Height=1449
int TabOrder=40
boolean Visible=false
string DataObject="d_sp_wkf_homonyme_sin"
boolean VScrollBar=true
end type

type p_focus from picture within w_t_sp_homonyme
int X=3383
int Y=33
int Width=92
int Height=77
boolean Visible=false
string PictureName="k:\pb4obj\bmp\focus_1.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

