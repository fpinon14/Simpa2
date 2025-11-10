HA$PBExportHeader$w_trt_sp_wkfs_boite.srw
$PBExportComments$Fen$$HEX1$$ea00$$ENDHEX$$tre de type response pour la gestion des bo$$HEX1$$ee00$$ENDHEX$$tes (ouverture/fermeture)
forward
global type w_trt_sp_wkfs_boite from w_ancetre
end type
type dw_stk_boite from u_datawindow within w_trt_sp_wkfs_boite
end type
type dw_trt_boite from datawindow within w_trt_sp_wkfs_boite
end type
type pb_nvlle_boite from picturebutton within w_trt_sp_wkfs_boite
end type
type pb_retour from picturebutton within w_trt_sp_wkfs_boite
end type
type pb_valider from picturebutton within w_trt_sp_wkfs_boite
end type
type pb_fermer_boite from picturebutton within w_trt_sp_wkfs_boite
end type
type dw_stk_histo from datawindow within w_trt_sp_wkfs_boite
end type
end forward

global type w_trt_sp_wkfs_boite from w_ancetre
boolean visible = true
integer x = 1075
integer y = 481
integer width = 2638
integer height = 744
boolean titlebar = true
string title = "Gestion des bo$$HEX1$$ee00$$ENDHEX$$tes"
windowtype windowtype = response!
dw_stk_boite dw_stk_boite
dw_trt_boite dw_trt_boite
pb_nvlle_boite pb_nvlle_boite
pb_retour pb_retour
pb_valider pb_valider
pb_fermer_boite pb_fermer_boite
dw_stk_histo dw_stk_histo
end type
global w_trt_sp_wkfs_boite w_trt_sp_wkfs_boite

type variables
Long	ilNbBoiteOuv
String	isIdOper

String	isTypeTrt //CS ou VAL
end variables

forward prototypes
private function boolean wf_controleboite ()
end prototypes

private function boolean wf_controleboite ();Boolean	bOk = False
String	sNoBoite, sCompMess = "", sAltValide
Long		lNbBoite, lCpt, lTot


/*------------------------------------------------------------------*/
/* V$$HEX1$$e900$$ENDHEX$$rification que tous les num$$HEX1$$e900$$ENDHEX$$ros de boite ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$saisis        */
/*------------------------------------------------------------------*/
lTot = dw_Trt_Boite.RowCount()

For lCpt = 1 To lTot
	bOk        = False
	sAltValide = dw_Trt_Boite.GetItemString ( lCpt, "ALT_VALIDE" )
	sNoBoite   = dw_Trt_Boite.GetItemString ( lCpt, "NO_BOITE"   )

	/*-----------------------------------------------------------------------*/
	/* La bo$$HEX1$$ee00$$ENDHEX$$te se trouve en base, on ne peut pas la modifier, on effectue   */
	/* donc aucun contr$$HEX1$$f400$$ENDHEX$$le.                                                  */
	/*-----------------------------------------------------------------------*/
	If sAltValide = 'O' Then
		bOk = True
	End If


	If bOk = False And len ( sNoBoite ) = 7 Then
	
		If left ( sNoBoite, 2 ) = 'SP' And isNumber ( Right ( sNoBoite, 5 ) ) Then

			SELECT count (*) INTO :lNbBoite
   	     FROM sysadm.wkfs_boite
      	 WHERE no_boite = :sNoBoite
			 USING SqlCa;

			If lNbBoite = 0 Then bOk = True Else sCompMess = "Ce num$$HEX1$$e900$$ENDHEX$$ro de boite existe d$$HEX1$$e900$$ENDHEX$$j$$HEX1$$e000$$ENDHEX$$"

		End If

	End If


	If bOk = False Then
		stMessage.sCode		= "PROF009"
		stMessage.sVar[1]    = sCompMess
		f_Message ( stMessage )
		
		dw_Trt_Boite.SetRow 		 ( lCpt )
		dw_Trt_Boite.ScrollToRow ( lCpt )
		dw_Trt_Boite.SetColumn   ( "NO_BOITE")
		dw_Trt_Boite.SetFocus    ()
	End If

	If bOk = False Then Exit

Next

If lTot = 0 Then bOk = True

Return bOk
end function

on open;call w_ancetre::open;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_tm_sp_wkfs_boite
//* Evenement 		:	Open
//* Auteur			:	PLJ
//* Date				:	29/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Ouverture d'une nvlle boite
//*					 	
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild	dwChild

s_Pass	stPass
long		lIdProfil, lTypArch, lTot, lIdSin


stPass	= Message.PowerObjectParm





/*----------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du type de traitement                       */
/* CS  appel pour consultation de l'historique (wkfs_histo) */
/* VAL appel pour Ouverture/fermeture de boite              */
/*----------------------------------------------------------*/
isTypeTrt = stPass.sTab[1]

/*----------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration de la datawindow pass$$HEX1$$e900$$ENDHEX$$e en parametre        */
/*----------------------------------------------------------*/
lTot = stPass.udwTab[1].RowCount()
stPass.udwTab[1].RowsCopy ( 1, lTot, Primary!, dw_Stk_Boite, 1, Primary! )





If isTypeTrt = 'VAL' Then

	pb_fermer_boite.Visible = True
	pb_nvlle_boite.Visible	= True
	pb_valider.Visible		= True

	dw_stk_histo.Visible		= False
	dw_Trt_Boite.Visible		= True

	This.width					= 2640

	/*----------------------------------------------------------*/
	/* Chargement de la DDDW des profils                        */
	/*----------------------------------------------------------*/
	dw_Trt_Boite.GetChild ( "ID_PROFIL", dwChild )
	dwChild.SetTransObject ( SqlCa )
	dwChild.Retrieve ()

	/*----------------------------------------------------------*/
	/* Chargement de la derni$$HEX1$$e800$$ENDHEX$$re boite Ouverte                  */
	/* 1 : M$$HEX1$$e900$$ENDHEX$$thode priv$$HEX1$$e900$$ENDHEX$$e   2: M$$HEX1$$e900$$ENDHEX$$thode centralis$$HEX1$$e900$$ENDHEX$$e              */
	/*----------------------------------------------------------*/
	lIdProfil = dw_Stk_Boite.GetItemNumber ( 1, "ID_PROFIL"   )
	lTypArch  = dw_Stk_Boite.GetItemNumber ( 1, "ID_TYP_ARCH" )

	If lTypArch = 1 Then isIdOper = stglb.sCodOper Else isIdOper = stPass.sTab[2]

	dw_trt_Boite.SetTransObject ( SqlCa )
	dw_Trt_Boite.Retrieve ( lIdProfil, isIdOper )


	/*--------------------------------------------------------------*/
	/* Axiome de base                                               */
	/* Il a bien $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$fini que l'on ne g$$HEX1$$e800$$ENDHEX$$re pas de zone ALT_OCCUPE */
	/* sur la table wkfs_boite.                                     */
	/* Ce qui veut dire qu'une seule personne (id_oper) pour un     */
	/* profil donn$$HEX2$$e9002000$$ENDHEX$$devra acc$$HEX1$$e900$$ENDHEX$$der $$HEX2$$e0002000$$ENDHEX$$la gestion des bo$$HEX1$$ee00$$ENDHEX$$tes           */
	/*--------------------------------------------------------------*/
	If ilNbBoiteOuv > 1 Then
		/*-----------------------------------------------------------*/
		/* Probl$$HEX1$$e800$$ENDHEX$$me : On ne peut pour un profil et un operateur      */
   	/*            qu'avoir une seule boite $$HEX2$$e0002000$$ENDHEX$$archive d'ouverte   */
		/*-----------------------------------------------------------*/

		stMessage.sTitre		= "Gestion des bo$$HEX1$$ee00$$ENDHEX$$tes"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= False
		stMessage.sCode		= "PROF005"
		stMessage.bouton		= Ok!
		stMessage.sVar[1]		= String ( dw_Stk_Boite.GetItemString ( 1, "ID_CIE" ) )
	
		f_Message ( stMessage )

	End If

ELSE

	IF isTypeTrt = 'FERMER' Then
		pb_Fermer_boite.Visible = True
		pb_nvlle_boite.Visible	= False
		pb_valider.Visible		= False

		dw_stk_histo.Visible		= True
		dw_Trt_Boite.Visible		= False

		This.width					= 1530
	Else
		pb_fermer_boite.Visible = False
		pb_nvlle_boite.Visible	= False
		pb_valider.Visible		= False
	
		dw_stk_histo.Visible		= True
		dw_Trt_Boite.Visible		= False

		This.width					= 1530

		lIdSin = dw_Stk_Boite.GetItemNumber ( 1, "ID_SIN" )
		dw_stk_histo.SetTransObject ( SqlCa )
		dw_stk_histo.Retrieve ( lIdSin )
	End If

End If


/*------------------------------------------------------------------*/
/* Positionnement de la fen$$HEX1$$ea00$$ENDHEX$$tre par rapport $$HEX2$$e0002000$$ENDHEX$$la mdi                */
/*------------------------------------------------------------------*/
This.x = ( w_mdi_sp.x + w_mdi_sp.width  /2 ) - This.width / 2
This.y = ( w_mdi_sp.y + w_mdi_sp.height /2 ) - This.height/ 2

end on

on w_trt_sp_wkfs_boite.create
int iCurrent
call super::create
this.dw_stk_boite=create dw_stk_boite
this.dw_trt_boite=create dw_trt_boite
this.pb_nvlle_boite=create pb_nvlle_boite
this.pb_retour=create pb_retour
this.pb_valider=create pb_valider
this.pb_fermer_boite=create pb_fermer_boite
this.dw_stk_histo=create dw_stk_histo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_stk_boite
this.Control[iCurrent+2]=this.dw_trt_boite
this.Control[iCurrent+3]=this.pb_nvlle_boite
this.Control[iCurrent+4]=this.pb_retour
this.Control[iCurrent+5]=this.pb_valider
this.Control[iCurrent+6]=this.pb_fermer_boite
this.Control[iCurrent+7]=this.dw_stk_histo
end on

on w_trt_sp_wkfs_boite.destroy
call super::destroy
destroy(this.dw_stk_boite)
destroy(this.dw_trt_boite)
destroy(this.pb_nvlle_boite)
destroy(this.pb_retour)
destroy(this.pb_valider)
destroy(this.pb_fermer_boite)
destroy(this.dw_stk_histo)
end on

type dw_stk_boite from u_datawindow within w_trt_sp_wkfs_boite
boolean visible = false
integer x = 78
integer y = 628
integer taborder = 50
string dataobject = "d_sp_sin_boite_archive"
end type

type dw_trt_boite from datawindow within w_trt_sp_wkfs_boite
integer x = 59
integer y = 204
integer width = 2523
integer height = 376
integer taborder = 70
string dataobject = "dw_trt_sp_wkfs_boite"
boolean vscrollbar = true
boolean livescroll = true
end type

type pb_nvlle_boite from picturebutton within w_trt_sp_wkfs_boite
integer x = 663
integer y = 28
integer width = 329
integer height = 136
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cr$$HEX1$$e900$$ENDHEX$$er Boite"
string picturename = "k:\pb4obj\bmp\nv_boite.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_tm_sp_wkfs_boite::pb_nvlle_boite
//* Evenement 		:	Cliked
//* Auteur			:	PLJ
//* Date				:	29/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Ouverture d'une nvlle boite
//*					 	
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


Boolean		bOk = True
long			lLigne, lNewLigne, lTot, lRet
DateTime		dtNull

SetNull ( dtNull )

dw_Trt_Boite.AcceptText ()
bOK = wf_ControleBoite ()


/*------------------------------------------------------------------*/
/* Si c'est une boite que l'on vient d'ouvrir, il faut absolument   */
/* que son num$$HEX1$$e900$$ENDHEX$$ro soit saisi                                        */
/*------------------------------------------------------------------*/
If bOk Then

	/*-----------------------------------------------------------------*/
	/* Il ne peut y avoir qu'une seule bo$$HEX1$$ee00$$ENDHEX$$te d'ouverte, cf axiome de   */
	/* l'Open.                                                         */
	/*-----------------------------------------------------------------*/
	lTot   = dw_Trt_Boite.RowCount ()
	lLigne = dw_trt_Boite.Find ( "ALT_OUVERTE = 'O'", 1, lTot )

	If lLigne > 0 Then
		stMessage.sVar[1]    = "(La bo$$HEX1$$ee00$$ENDHEX$$te " + dw_trt_Boite.GetItemString ( lLigne, "NO_BOITE" ) + " va automatiquement $$HEX1$$ea00$$ENDHEX$$tre ferm$$HEX1$$e900$$ENDHEX$$e)"
	Else
		stMessage.sVar[1]    = " "
	End If

	/*------------------------------------------------------------------*/
	/* Avertissement que cette op$$HEX1$$e900$$ENDHEX$$ration est irr$$HEX1$$e900$$ENDHEX$$versible               */
	/*------------------------------------------------------------------*/
	stMessage.sTitre		= "Gestion des bo$$HEX1$$ee00$$ENDHEX$$tes"
	stMessage.Icon			= Question!
	stMessage.bErreurG	= False
	stMessage.sCode		= "PROF006"
	stMessage.bTrace  	= False
	stMessage.bouton		= YesNo!

	
	lRet = F_Message ( stMessage )

	If lRet = 2 Then
		bOk = False
	End If

End If



If bOK Then

	/*---------------------------------------------------------------*/
	/* Fermeture de la bo$$HEX1$$ee00$$ENDHEX$$te ouverte                                 */	
	/*---------------------------------------------------------------*/
	If lLigne > 0 Then
		dw_trt_Boite.SetItem ( lLigne, "ALT_OUVERTE", 'N' )
		dw_trt_Boite.SetItem ( lLigne, "DTE_FERM",  datetime ( today(), now() ) )
	End If

	/*---------------------------------------------------------------*/
	/* Ouverture d'une nouvelle bo$$HEX1$$ee00$$ENDHEX$$te                                */
	/*---------------------------------------------------------------*/
	lNewLigne = dw_Trt_Boite.InsertRow ( 0 )
	dw_Trt_Boite.SetItem ( lNewLigne, "ID_PROFIL", 		dw_stk_Boite.GetItemNumber ( 1, "ID_PROFIL" ) )
	dw_Trt_Boite.SetItem ( lNewLigne, "ALT_OUVERTE", 	'O' 														 )
	dw_Trt_Boite.SetItem ( lNewLigne, "NO_BOITE", 		'SP' 														 )
	dw_Trt_Boite.SetItem ( lNewLigne, "ID_OPER",       isIdOper                                      )
	dw_Trt_Boite.SetItem ( lNewLigne, "DTE_OUV",       datetime ( today(), now() )                   )
	dw_Trt_Boite.SetItem ( lNewLigne, "DTE_FERM",      dtNull                                        )
	dw_Trt_Boite.SetItem ( lNewLigne, "CREE_LE",       datetime ( today(), now() )                   )
	dw_Trt_Boite.SetItem ( lNewLigne, "MAJ_LE",        datetime ( today(), now() )                   )
	dw_Trt_Boite.SetItem ( lNewLigne, "MAJ_PAR",       stglb.sCodOper                                )
	dw_Trt_Boite.SetItem ( lNewLigne, "ALT_VALIDE",    'N'                                           )


	dw_Trt_Boite.SetRow      (lNewLigne )
	dw_Trt_Boite.ScrollToRow (lNewLigne )
	dw_Trt_Boite.SetColumn   ("NO_BOITE")
	dw_Trt_Boite.SetFocus    ()
	

End If


end on

type pb_retour from picturebutton within w_trt_sp_wkfs_boite
integer x = 64
integer y = 28
integer width = 233
integer height = 136
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Retour"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_quit.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : w_trt_sp_wkfs_boite::pb_retour
//* Evenement     : clicked
//* Auteur        : PLJ
//* Date          : 05/09/2003 09:53:32
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


/*---------------------------------------*/
/* Nous retournons la chaine RETOUR      */
/*---------------------------------------*/
CloseWithReturn ( Parent, "RETOUR" )
end on

type pb_valider from picturebutton within w_trt_sp_wkfs_boite
integer x = 1015
integer y = 28
integer width = 233
integer height = 136
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Valider"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_valid.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_tm_sp_wkfs_boite::pb_Valider
//* Evenement 		:	Cliked
//* Auteur			:	PLJ
//* Date				:	30/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Ouverture d'une nvlle boite
//*					 	
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean	bOk
String	sNoBoite

Long	lLigne, lTot


dw_Trt_Boite.AcceptText()

/*------------------------------------------------------------------*/
/* V$$HEX1$$e900$$ENDHEX$$rification que tous les num$$HEX1$$e900$$ENDHEX$$ros de boite ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$saisis        */
/*------------------------------------------------------------------*/
bOk = wf_ControleBoite ()	


If bOk Then

	dw_Trt_Boite.Update ()

	If SqlCa.SqlCode <> 0 Or SqlCa.SqlDbCode <> 0 Then
		stMessage.sTitre		= "Gestion Boite"
		stMessage.Icon			= StopSign!
		stMessage.bErreurG	= False
		stMessage.sCode		= "PROF001"
	   stMessage.bTrace  	= False
		stMessage.sVar[1]    = "Fermeture/ouverture boite"
		stMessage.sVar[2] 	= String ( SqlCa.SqlCode    )
		stMessage.sVar[3] 	= String ( SqlCa.SqlDBCode  )
		stMessage.sVar[4] 	= String ( SqlCa.SqlErrText )
		f_Message ( stMessage )
		bOk = False
	End IF

	f_Commit ( SqlCa, bOk )

End If


If bOk Then

	/*------------------------------------------------------------------*/
	/* Il ne peut y avoir qu'une seule bo$$HEX1$$ee00$$ENDHEX$$te d'ouverte $$HEX2$$e0002000$$ENDHEX$$la fois        */
	/* on renvoie donc le num$$HEX1$$e900$$ENDHEX$$ro de la derni$$HEX1$$e800$$ENDHEX$$re boite ouverte           */
	/* s'il n'y a plus de boite ouverte on retourne la chaine vide      */
	/*------------------------------------------------------------------*/
	lTot   = dw_Trt_Boite.RowCount()
	lLigne = dw_Trt_Boite.find ( "ALT_OUVERTE = 'O'", 1, lTot )

	If lLigne > 0 Then
		sNoBoite = dw_Trt_Boite.GetItemString ( lLigne, "NO_BOITE" )
	Else
		sNoBoite = ""
	End If

	CloseWithReturn ( Parent, sNoBoite )

End If


end on

type pb_fermer_boite from picturebutton within w_trt_sp_wkfs_boite
integer x = 315
integer y = 28
integer width = 329
integer height = 136
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Fermer Bo$$HEX1$$ee00$$ENDHEX$$te"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\fermboit.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_tm_sp_wkfs_boite::pb_fermer_boite
//* Evenement 		:	Cliked
//* Auteur			:	PLJ
//* Date				:	04/09/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Fermeture de la bo$$HEX1$$ee00$$ENDHEX$$te courante
//*					 	
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


Boolean		bOk = True
long			lLigne, lTot, lRet

dw_Trt_Boite.AcceptText()
bOK = wf_ControleBoite ()

IF bOk Then
	/*-----------------------------------------------------------------*/
	/* Il ne peut y avoir qu'une seule bo$$HEX1$$ee00$$ENDHEX$$te d'ouverte, cf axiome de   */
	/* l'Open.                                                         */
	/*-----------------------------------------------------------------*/
	lTot   = dw_Trt_Boite.RowCount ()
	lLigne = dw_trt_Boite.Find ( "ALT_OUVERTE = 'O'", 1, lTot )

	If lLigne > 0 Then

		/*------------------------------------------------------------------*/
		/* Avertissement que cette op$$HEX1$$e900$$ENDHEX$$ration est irr$$HEX1$$e900$$ENDHEX$$versible               */
		/*------------------------------------------------------------------*/
		stMessage.sTitre		= "Gestion des bo$$HEX1$$ee00$$ENDHEX$$tes"
		stMessage.Icon			= StopSign!
		stMessage.bErreurG	= False
		stMessage.sCode		= "PROF007"
		stMessage.bTrace  	= False
		stMessage.bouton		= YesNo!

		lRet = F_Message ( stMessage )

		If lRet = 1 Then
			dw_trt_Boite.SetItem ( lLigne, "ALT_OUVERTE", 'N' )
			dw_trt_Boite.SetItem ( lLigne, "DTE_FERM",  datetime ( today(), now() ) )
		End If

	End If

End If
end on

type dw_stk_histo from datawindow within w_trt_sp_wkfs_boite
integer x = 59
integer y = 204
integer width = 1408
integer height = 408
integer taborder = 60
string dataobject = "dw_stk_sp_wkfs_histo"
boolean vscrollbar = true
boolean livescroll = true
end type

