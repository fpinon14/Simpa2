HA$PBExportHeader$u_gs_sp_sinistre_contact.sru
$PBExportComments$---} User Object pour la gestion des contacts
forward
global type u_gs_sp_sinistre_contact from nonvisualobject
end type
end forward

global type u_gs_sp_sinistre_contact from nonvisualobject
end type
global u_gs_sp_sinistre_contact u_gs_sp_sinistre_contact

type variables
Private :

u_DataWindow		idw_TrtContact
u_DataWindow		idw_TrtWSin
u_DataWindow		idw_TrtATraiterPar
u_DataWindow		idw_DosSuiviPar

u_DataWindow_Detail	idw_LstContact
u_DataWindow_Detail	idw_LstInter

DataWindow		idw_Corbeille
DataWindow		idw_Produit

PictureButton		iPbControler
PictureButton		iPbSupprimer
PictureButton		iPbValider

Boolean			ibAltNouveau

u_Transaction		iTrTrans

String			isTypTrt
Long			ilIdSin
end variables

forward prototypes
public subroutine uf_preparermodifier (ref s_pass astpass)
public subroutine uf_preparerinserer (ref s_pass astpass)
public subroutine uf_gerermessage (string aserrcol)
public function string uf_controlersaisie ()
public function string uf_controlergestion ()
private function string uf_controlergestion_type ()
public function boolean uf_preparersupprimer ()
private function boolean uf_droitaccescorbeille ()
private function boolean uf_droitaccestravail ()
public subroutine uf_initialiser (ref s_pass astpass, ref picturebutton apbcontroler, ref picturebutton apbsupprimer, ref picturebutton apbvalider, ref u_transaction atrtrans, ref u_datawindow adwsin)
public function boolean uf_valider ()
public function long uf_controlerzone (string asnomcol)
end prototypes

public subroutine uf_preparermodifier (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerModifier (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 25/04/2001 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Pr$$HEX1$$e900$$ENDHEX$$paration de la modification d'un contact
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Date	dDteCree, 	dDteJour
DataWindowChild	dwcTemp

idw_TrtATraiterPar.Reset ()
idw_TrtATraiterPar.Hide ()

/*------------------------------------------------------------------*/
/* On recopie la ligne du d$$HEX1$$e900$$ENDHEX$$tail de la fen$$HEX1$$ea00$$ENDHEX$$tre parent dans          */
/* dw_wGarSin de GARANTIE.                                          */
/*------------------------------------------------------------------*/
idw_TrtContact.Uf_CopierLigne ()

/*----------------------------------------------------------------------------*/
/* L'enregistrement est-il nouveau ou pas ?.                                  */
/*----------------------------------------------------------------------------*/
ibAltNouveau = iDw_LstContact.GetItemStatus ( iDw_LstContact.GetSelectedRow (0), 0, Primary! ) = New! Or &
					iDw_LstContact.GetItemStatus ( iDw_LstContact.GetSelectedRow (0), 0, Primary! ) = NewModified! 

/*------------------------------------------------------------------*/
/* Si l'enregistrement a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$valid$$HEX1$$e900$$ENDHEX$$, impossible de le modifier ou   */
/* supprimer                                                        */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* istPass.sTab[3] Contient nouveau si la ligne recopi$$HEX1$$e900$$ENDHEX$$e est new!   */
/* ou NewModified!                                                  */
/*------------------------------------------------------------------*/
idw_TrtContact.GetChild 		(    "ID_TYP_MSG", dwcTemp )
DwcTemp.SetFilter (    "ID_CANAL = '"+ idw_TrtContact.GetItemString ( 1, "ID_CANAL" ) + "'" )
DwcTemp.Filter		( )

idw_TrtContact.GetChild 		(    "ID_NAT_MSG", dwcTemp )
DwcTemp.SetFilter (    "ID_CANAL = '"+ idw_TrtContact.GetItemString ( 1, "ID_CANAL" ) + "' AND " + &
							  "ID_TYP_MSG = '" + idw_TrtContact.GetItemString ( 1, "ID_TYP_MSG" ) + "'" )
DwcTemp.Filter		( )

If ( idw_TrtContact.GetItemString ( 1, "ALT_VALIDE" ) = 'N' And Not ibAltNouveau ) Or &
   ( isTypTrt = 'V' ) Then 

	ipbSupprimer.Enabled = False
	ipbControler.Enabled	= False
	ipbValider.Enabled 	= False
	idw_TrtContact.uf_Proteger &
		( {	"ID_CANAL"			, &
			 	"COD_I_PROV"		, & 
				"ID_TYP_MSG"		, &
			 	"ID_NAT_MSG" 		, &
				"TXT_MESS1" 		, &
				"TXT_MESS2" 		  &
				}, "1" )
Else

	ipbSupprimer.Enabled = astPass.bSupprime
	ipbControler.Enabled = True
	ipbValider.Enabled 	= False
	idw_TrtContact.uf_Proteger  &
		( {	"ID_CANAL"			, &
			 	"COD_I_PROV"		, & 
				"ID_TYP_MSG"		, &
			 	"ID_NAT_MSG" 		, &
				"TXT_MESS1" 		, &
				"TXT_MESS2" 		  &
				}, "0" )

End If
end subroutine

public subroutine uf_preparerinserer (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerInserer (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 25/04/2001 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Pr$$HEX1$$e900$$ENDHEX$$paration de l'insertion d'un contact
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

DataWindowChild	dwcTemp

idw_TrtATraiterPar.Reset ()
idw_TrtATraiterPar.Hide ()

/*------------------------------------------------------------------*/
/* Incr$$HEX1$$e900$$ENDHEX$$mentation du compteur de message                            */
/*------------------------------------------------------------------*/
idw_TrtContact.SetItem ( 1, "ID_MSG_SEQ",  Dec ( idw_LstContact.Describe ( "Evaluate('max ( id_msg_seq )', 0)" ) ) + 1 ) 

ilIdSin = idw_TrtWSin.GetItemNumber ( 1, "ID_SIN" )
idw_TrtContact.SetItem ( 1, "ID_SIN",  ilIdSin ) 

/*------------------------------------------------------------------*/
/* Protection des zones id_typ_msg et id_nat_msg                    */
/*------------------------------------------------------------------*/
idw_TrtContact.GetChild 		( "ID_TYP_MSG", dwcTemp )
DwcTemp.SetFilter ( "ID_CANAL = '-1'" )
DwcTemp.Filter 	(  )

idw_TrtContact.GetChild 		( "ID_NAT_MSG", dwcTemp )
DwcTemp.SetFilter ( "ID_CANAL = '-1'" )
DwcTemp.Filter 	(  )

iPbControler.Enabled = True

idw_TrtContact.uf_Proteger  &
	( {	"ID_CANAL"			, &
		 	"COD_I_PROV"		, & 
			"TXT_MESS1" 		, &
			"TXT_MESS2" 		  &
			}, "0" )

idw_TrtContact.uf_Proteger ( { "ID_TYP_MSG", "ID_NAT_MSG" }, "1" )

end subroutine

public subroutine uf_gerermessage (string aserrcol);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GererMessage (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 25/04/2001 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de zone
//*
//* Arguments		: Val		String		asErrCol
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

stMessage.sTitre	= "Saisie des contacts"
stMessage.Icon		= Information!

Choose Case asErrCol

	Case "TXT_MESS1", "TXT_MESS2"
		stMessage.sVar[1] = "texte du message"
		stMessage.sCode	= "GENE003"
		idw_TrtContact.iiReset				= 2		// Pas de reset

	Case "ID_TYP_MSG"

		stMessage.sVar[1] = "Ce type de contact"
		Choose case isTypTrt
			Case "C"
				stMessage.sVar[2] = "consultation"

			Case "S"
				stMessage.sVar[2] = "saisie"

			Case "V"
				stMessage.sVar[2] = "validation"

		End Choose
		stMessage.sCode	= "CONT002"

	Case "ID_NAT_MSG"

		Choose Case idw_TrtContact.iiErreur

			Case 0 
				stMessage.sVar[1] = "Cette nature de contact"
				Choose case isTypTrt

					Case "C"
						stMessage.sVar[2] = "consultation"

					Case "S"
						stMessage.sVar[2] = "saisie"

					Case "V"
						stMessage.sVar[2] = "validation"

				End Choose

				stMessage.sCode	= "CONT002"


			// LE User n'a pas acc$$HEX1$$e800$$ENDHEX$$s aux module des travaux
			Case 1
					stMessage.sCode	= "CONT015"


			// LE User n'a pas acc$$HEX1$$e800$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$la corbeille
			Case 2
					stMessage.sCode	= "CONT014"



		End Choose


End Choose

f_Message ( stMessage )

idw_TrtContact.uf_Reinitialiser ()

end subroutine

public function string uf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_ControlerSaisie (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 26/04/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de saisie des zones 
//*					  W_ASSURE
//* Commentaires	: Aucun
//*
//* Arguments		: Aucun
//*
//* Retourne		: String		"" -> On passe au controle de gestion
//*											Nom de colonne en erreur
//*
//*-----------------------------------------------------------------

String 		sCol[4]				//Nom des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
String		sErr[4]				//Erreur relative $$HEX2$$e0002000$$ENDHEX$$un champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier 
String 		sNouvelleLigne		//Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne
String		sText					//Variable relative a l'ensemble des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier 
String		sPos					//Nom du premier champ non renseign$$HEX1$$e900$$ENDHEX$$
String		sVal					//Valeur du champ en v$$HEX1$$e900$$ENDHEX$$rification
Long 			lCpt					//Compteur pour les champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
Long			lNbrCol				//Nombre de champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier

sNouvelleLigne	= "~r~n"
lNbrCol			= UpperBound ( sCol )
sPos				= ""
sText				= sNouvelleLigne

sCol[ 1 ]		= "ID_CANAL"
sCol[ 2 ]		= "COD_I_PROV"
sCol[ 3 ]		= "ID_TYP_MSG"
sCol[ 4 ]		= "ID_NAT_MSG"

sErr[ 1 ]		= " - Le canal de communication utilis$$HEX2$$e9002000$$ENDHEX$$par le client"
sErr[ 2 ]		= " - L'interlocuteur dont provient le contact"
sErr[ 3 ]		= " - Le type du contact"
sErr[ 4 ]		= " - La nature du contact"

/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/

For	lCpt = 1 To lNbrCol

	Choose Case lCpt
		Case 1,2,3
			sVal = idw_TrtContact.GetItemString ( 1, sCol[ lCpt ] )
		Case 4
			sVal = String ( idw_TrtContact.GetItemNumber ( 1, sCol[ lCpt ] ) )
			If Long ( sVal ) = 0 Then sVal = ""

	End Choose
	If ( IsNull ( sVal ) or Trim ( sVal ) = "" )	Then

		If ( sPos = "" ) 	Then 	sPos = sCol[ lCpt ]
		sText = sText + sErr[ lCpt ] + sNouvelleLigne

	End If

Next

/*------------------------------------------------------------------*/
/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur s'il y  */
/* en a une :												                    */
/*------------------------------------------------------------------*/

If	( sPos <> "" ) Then

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des Contacts"
	stMessage.Icon			= Information!
	stMessage.sVar[1] 	= sText
	stMessage.sCode		= "GENE001"

	f_Message ( stMessage )

End If

Return ( sPos )
end function

public function string uf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_ControlerGestion (PUBLIC)
//* Auteur			: Fabyr JF
//* Date				: 26/04/2001 10:37:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controle Message Obligatoire
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

String					sIdNat, sTxtMess1, sCol	=	""
String					sIdCanal, sIdTyp, sFind, sAltMess
Long						lLig
DataWindowChild		dwcTemp	

sTxtMess1	=		Trim ( idw_TrtContact.GetItemString ( 1, "TXT_MESS1" )	)

sIdCanal		=		idw_TrtContact.GetItemString ( 1, "ID_CANAL"   )
sIdTyp		=		idw_TrtContact.GetItemString ( 1, "ID_TYP_MSG" )
sIdNat		=		String ( idw_TrtContact.GetItemNumber ( 1, "ID_NAT_MSG" ) )

sFind			=	 	"ID_CANAL   = '" + sIdCanal + "' AND " +&
						"ID_TYP_MSG = '" + sIdTyp   + "' AND " +&
						"ID_NAT_MSG = " + sIdNat  

idw_TrtContact.GetChild ( "ID_NAT_MSG", dwcTemp )

lLig	=	dwcTemp.Find  ( sFind, 1, DwcTemp.RowCount () )

If lLig	> 0 Then

/*------------------------------------------------------------------*/
/*  Je v$$HEX1$$e900$$ENDHEX$$rifie qu'un message est saisi si la nature de message le   */
/* pr$$HEX1$$e900$$ENDHEX$$voit  comme obligatoire                                       */
/*------------------------------------------------------------------*/

	If sTxtMess1 = "" Or isNull ( sTxtMess1 ) Then

		sAltMess	=	dwcTemp.GetItemString ( lLig, "ALT_MESS" )
		If sAltMess = "O" Then

/*------------------------------------------------------------------*/
/* Message obligatoire non saisi                                    */
/*------------------------------------------------------------------*/
			sCol 					=	"TXT_MESS1"

			stMessage.sTitre	=	"Contr$$HEX1$$f400$$ENDHEX$$le de gestion"
			stMessage.sCode	=	"CONT003"

			f_Message ( stMessage )

		End If
	End If

	idw_TrtContact.SetItem ( 1, "ALT_VALIDE", dwcTemp.GetITemString ( lLig, "ALT_VALIDE" ) )

End If

/*------------------------------------------------------------------*/
/* Controle de conh$$HEX1$$e900$$ENDHEX$$rence des contacts                              */
/*------------------------------------------------------------------*/

If sCol = "" Then	sCol = uf_ControlerGestion_Type ( )


Return ( sCol )
end function

private function string uf_controlergestion_type ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_controlergestion_type (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 24/04/2001 16:33:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controle de coh$$HEX1$$e900$$ENDHEX$$rence des types de contacts 
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

String	sType, sMsg, sRech
String	sCol = ""
Long		lLig, lNbLig

sType		=	idw_TrtContact.GetItemString ( 1, "ID_TYP_MSG" )
sMsg		=	String ( idw_TrtContact.GetItemNumber ( 1, "ID_MSG_SEQ" ) )

lNbLig	=	iDw_LstContact.RowCount ()

Choose Case	sType

	Case 'D'			// D$$HEX1$$e900$$ENDHEX$$claration

/*------------------------------------------------------------------*/
/* Saisie possible uniquement si aucun contact                      */
/*------------------------------------------------------------------*/

	sRech	=	"ID_MSG_SEQ <> " + sMsg 
	lLig	=	iDw_LstContact.Find ( sRech, 1, lNbLig )

	If lLig	> 0 Then

		sCol = "ID_CANAL"
		stMessage.sTitre	=	"Contr$$HEX1$$f400$$ENDHEX$$le de gestion du contact"
		stMessage.sCode	=	"CONT005"
		stMessage.sVar[1]	=	"d$$HEX1$$e900$$ENDHEX$$claration"
		f_Message ( stMessage )
	End If

	Case 'PI'		// Pr$$HEX1$$e900$$ENDHEX$$instruction

/*------------------------------------------------------------------*/
/* Message si compl$$HEX1$$e900$$ENDHEX$$ment C/CS/CP                                    */
/*------------------------------------------------------------------*/

	sRech	=	"(ID_TYP_MSG = 'C' Or ID_TYP_MSG = 'CS' Or ID_TYP_MSG = 'CP' ) AND ID_MSG_SEQ <> " + sMsg
	lLig	=	iDw_LstContact.Find ( sRech, 1, lNbLig )

	If lLig	> 0 Then

		stMessage.sTitre	=	"Contr$$HEX1$$f400$$ENDHEX$$le de gestion du contact"
		stMessage.sCode	=	"CONT004"
		stMessage.sVar[1]	=	"pr$$HEX1$$e900$$ENDHEX$$-instruction"
		stMessage.sVar[2]	=	"Compl$$HEX1$$e900$$ENDHEX$$ment"
		stMessage.bouton	=	OKCancel!

		If f_Message ( stMessage ) = 2 Then		// Stop

			sCol = "ID_CANAL" 
		End If

	End If

/*------------------------------------------------------------------*/
/* Message si pas contact de d$$HEX1$$e900$$ENDHEX$$claration                            */
/*------------------------------------------------------------------*/

	If sCol = "" Then

		sRech	=	"ID_TYP_MSG = 'D' AND ID_MSG_SEQ <> " + sMsg
		lLig	=	iDw_LstContact.Find ( sRech, 1, lNbLig )

		If lLig	<= 0 Then

			stMessage.sTitre	=	"Contr$$HEX1$$f400$$ENDHEX$$le de gestion du contact"
			stMessage.sCode	=	"CONT004"
			stMessage.sVar[1]	=	"pr$$HEX1$$e900$$ENDHEX$$-instruction"
			stMessage.sVar[2]	=	"d$$HEX1$$e900$$ENDHEX$$claration"
			stMessage.bouton	=	OKCancel!

			If f_Message ( stMessage ) = 2 Then		// Stop

				sCol = "ID_CANAL" 
			End If
		End If
	End If

/*------------------------------------------------------------------*/
/* Message si Existe d$$HEX1$$e900$$ENDHEX$$j$$HEX44$$e0002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
/*------------------------------------------------------------------*/

	If sCol = "" Then

		sRech	=	"ID_TYP_MSG = 'PI' AND ID_MSG_SEQ <> " + sMsg
		lLig	=	idw_LstContact.Find ( sRech, 1, lNbLig )

		If lLig	> 0 Then

			stMessage.sTitre	=	"Contr$$HEX1$$f400$$ENDHEX$$le de gestion du contact"
			stMessage.sCode	=	"CONT006"
			stMessage.sVar[1]	=	"pr$$HEX1$$e900$$ENDHEX$$-instruction"
			stMessage.sVar[2]	=	"pr$$HEX1$$e900$$ENDHEX$$-instruction"
			stMessage.bouton	=	OKCancel!

			If f_Message ( stMessage ) = 2 Then		// Stop

				sCol = "ID_CANAL" 
			End If
		End If
	End If

	Case 'C'			// Compl$$HEX1$$e900$$ENDHEX$$ment T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonique

/*------------------------------------------------------------------*/
/* Message d'information si pas de d$$HEX1$$e900$$ENDHEX$$claration,ni de                */
/* pr$$HEX1$$e900$$ENDHEX$$-instruction                                                  */
/*------------------------------------------------------------------*/
		sRech	=	"( ID_TYP_MSG = 'D' ) AND ID_MSG_SEQ <> " + sMsg
		lLig	=	idw_LstContact.Find ( sRech, 1, lNbLig )

		If lLig	<= 0 Then

			stMessage.sTitre	=	"Contr$$HEX1$$f400$$ENDHEX$$le de gestion du contact"
			stMessage.sCode	=	"CONT004"
			stMessage.sVar[1]	=	"compl$$HEX1$$e900$$ENDHEX$$ment t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonique"
			stMessage.sVar[2]	=	"d$$HEX1$$e900$$ENDHEX$$claration"
			stMessage.bouton	=	OKCancel!

			If f_Message ( stMessage ) = 2 Then		// Stop

				sCol = "ID_CANAL" 
			End If
		End If

		If sCol = "" Then

			sRech	=	"( ID_TYP_MSG = 'PI' ) AND ID_MSG_SEQ <> " + sMsg
			lLig	=	idw_LstContact.Find ( sRech, 1, lNbLig )

			If lLig	<= 0 Then

				stMessage.sTitre	=	"Contr$$HEX1$$f400$$ENDHEX$$le de gestion du contact"
				stMessage.sCode	=	"CONT004"
				stMessage.sVar[1]	=	"compl$$HEX1$$e900$$ENDHEX$$ment t$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phonique"
				stMessage.sVar[2]	=	"pr$$HEX1$$e900$$ENDHEX$$-instruction"
				stMessage.bouton	=	OKCancel!

				If f_Message ( stMessage ) = 2 Then		// Stop

					sCol = "ID_CANAL" 
				End If
			End If
		End If


	Case 'CS'		// Compl$$HEX1$$e900$$ENDHEX$$ment sans pr$$HEX1$$e900$$ENDHEX$$-instruction

/*------------------------------------------------------------------*/
/* Message d'information si pas de d$$HEX1$$e900$$ENDHEX$$claration                      */
/*------------------------------------------------------------------*/

		sRech	=	"ID_TYP_MSG = 'D' AND ID_MSG_SEQ <> " + sMsg 
		lLig	=	idw_LstContact.Find ( sRech, 1, lNbLig )

		If lLig	<= 0 Then

			stMessage.sTitre	=	"Contr$$HEX1$$f400$$ENDHEX$$le de gestion du contact"
			stMessage.sCode	=	"CONT004"
			stMessage.sVar[1]	=	"compl$$HEX1$$e900$$ENDHEX$$ment sans pr$$HEX1$$e900$$ENDHEX$$-instruction"
			stMessage.sVar[2]	=	"d$$HEX1$$e900$$ENDHEX$$claration"
			stMessage.bouton	=	OKCancel!

			If f_Message ( stMessage ) = 2 Then		// Stop

				sCol = "ID_CANAL" 
			End If
		End If

	Case 'CP'		// Compl$$HEX1$$e900$$ENDHEX$$ment avec pr$$HEX1$$e900$$ENDHEX$$-instruction

/*------------------------------------------------------------------*/
/* Message d'information si pas de d$$HEX1$$e900$$ENDHEX$$claration ni de                */
/* pr$$HEX1$$e900$$ENDHEX$$-instruction                                                  */
/*------------------------------------------------------------------*/

		sRech	=	"( ID_TYP_MSG = 'D' ) AND ID_MSG_SEQ <> " + sMsg
		lLig	=	idw_LstContact.Find ( sRech, 1, lNbLig )

		If lLig	<= 0 Then

			stMessage.sTitre	=	"Contr$$HEX1$$f400$$ENDHEX$$le de gestion du contact"
			stMessage.sCode	=	"CONT004"
			stMessage.sVar[1]	=	"compl$$HEX1$$e900$$ENDHEX$$ment suite pr$$HEX1$$e900$$ENDHEX$$-instruction"
			stMessage.sVar[2]	=	"d$$HEX1$$e900$$ENDHEX$$claration"
			stMessage.bouton	=	OKCancel!

			If f_Message ( stMessage ) = 2 Then		// Stop

				sCol = "ID_CANAL" 
			End If
		End If

		If sCol = "" Then

			sRech	=	"( ID_TYP_MSG = 'PI' ) AND ID_MSG_SEQ <> " + sMsg
			lLig	=	idw_LstContact.Find ( sRech, 1, lNbLig )

			If lLig	<= 0 Then

				stMessage.sTitre	=	"Contr$$HEX1$$f400$$ENDHEX$$le de gestion du contact"
				stMessage.sCode	=	"CONT004"
				stMessage.sVar[1]	=	"compl$$HEX1$$e900$$ENDHEX$$ment suite pr$$HEX1$$e900$$ENDHEX$$-instruction"
				stMessage.sVar[2]	=	"pr$$HEX1$$e900$$ENDHEX$$-instruction"
				stMessage.bouton	=	OKCancel!

				If f_Message ( stMessage ) = 2 Then		// Stop

					sCol = "ID_CANAL" 
				End If
			End If
		End If
End choose

Return ( sCol )
end function

public function boolean uf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerSupprimer (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 25/04/2001 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Pr$$HEX1$$e900$$ENDHEX$$paration de l'insertion d'un contact
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Boolean 	bRet 			// Variable de retour de la fonction.

String	sIdSin 		// Sinistre .
String 	sIdMsg		// Msg $$HEX2$$e0002000$$ENDHEX$$supprimer.

Integer	iRet			// Confirmation de l'op$$HEX1$$e900$$ENDHEX$$rateur.

bRet = True

/*------------------------------------------------------------------*/
/* Demande de Confirmation avant suppression                        */
/*------------------------------------------------------------------*/
stMessage.sTitre 		= "Suppression d'un contact"
stMessage.sVar[ 1 ] 	= "ce contact"
stMessage.Bouton		= OkCancel!
stMessage.Icon			= Exclamation!
stMessage.sCode		= "CONF001"

iRet						= f_Message ( stMessage )

/*------------------------------------------------------------------*/
/* Traitement suivant confirmation ou non de l'op$$HEX1$$e900$$ENDHEX$$rateur            */
/*------------------------------------------------------------------*/
If iRet = 2 Then 	
	bRet = False
End If

Return bRet
end function

private function boolean uf_droitaccescorbeille ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_DroitAccesCorb (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 11:30:12
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: V$$HEX1$$e900$$ENDHEX$$rif le droit d'acc$$HEX1$$e800$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$la corbeille
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: NotFound	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

String	sCorb

sCorb = String (idw_Produit.GetItemNumber ( 1, "ID_CORB" ) )

If Trim ( sCorb ) = "" Then Return FALSE

Return idw_Corbeille.Find ( "ID_CORB = " + sCorb, 1, idw_Corbeille.RowCount () ) > 0



end function

private function boolean uf_droitaccestravail ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_DroitAccesTravail (PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 13:38:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: NotFound	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Return stGlb.bCreationTrv

end function

public subroutine uf_initialiser (ref s_pass astpass, ref picturebutton apbcontroler, ref picturebutton apbsupprimer, ref picturebutton apbvalider, ref u_transaction atrtrans, ref u_datawindow adwsin);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::Uf_Initialiser (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 25/04/2001 17:58:24
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

DatawindowChild dwChild, dwChild1

idw_TrtContact = astPass.dwMaster
idw_LstContact = astPass.dwTab [1]
idw_LstInter	= astPass.dwTab [2]
idw_DosSuiviPar	= astPass.udwTab [1]
idw_TrtATraiterPar= astPass.udwTab [2]
idw_TrtWSin		= adwSin
idw_Corbeille	= astPass.dwNorm [1]
idw_Produit		= astPass.dwNorm [2]


ipbControler = apbControler
ipbSupprimer = apbSupprimer
ipbValider 	 = apbValider

iTrTrans		 = aTrTrans

isTypTrt	 	 = astPass.sTab [2]

idw_LstInter.GetChild ( "COD_INTER", dwChild )
idw_TrtContact.GetChild ( "COD_I_PROV", dwChild1 )
dwChild.ShareData ( dwChild1 )

idw_LstContact.GetChild ( "ID_CANAL", dwChild )
idw_TrtContact.GetChild ( "ID_CANAL", dwChild1 )
dwChild.ShareData ( dwChild1 )


/*------------------------------------------------------------------*/
/* Initialisation des DDDW                                          */
/*------------------------------------------------------------------*/
idw_TrtContact.GetChild ( "ID_TYP_MSG", dwChild )
dwChild.SetTransObject ( iTrTrans )
If ( dwChild.Retrieve ( ) <= 0 )	Then dwChild.InsertRow ( 0 )

idw_TrtContact.GetChild ( "ID_NAT_MSG", dwChild )
dwChild.SetTransObject ( iTrTrans )
If ( dwChild.Retrieve ( ) <= 0 )	Then dwChild.InsertRow ( 0 )


idw_DosSuiviPar	= astPass.udwTab [1]
idw_TrtATraiterPar= astPass.udwTab [2]

idw_TrtATraiterPar.GetChild ( "DOS_SUIVI_PAR", dwChild )
idw_DosSuiviPar.GetChild ( "DOS_SUIVI_PAR", dwChild1 )
dwChild1.ShareData (dwChild)
idw_TrtATraiterPar.InsertRow(0)

/*------------------------------------------------------------------*/
/* Initialisation des champs dont la couleur changera en fonction   */
/* de la protection                                                 */
/*------------------------------------------------------------------*/
idw_TrtContact.uf_InitialiserCouleur &
		( {	"ID_CANAL"			,& 
				"COD_I_PROV"		,&
				"ID_TYP_MSG"		,&
				"ID_NAT_MSG" 		,&
				"TXT_MESS1"			,&
				"TXT_MESS2"			&
		} )



end subroutine

public function boolean uf_valider ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Valider (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 01/02/2002 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Validation contact
//*
//* Arguments		: 
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------

String sUser, sMess2
Boolean bOk

bOk = False

If idw_TrtContact.GetItemNumber ( 1, "ID_NAT_MSG" ) = 5 And idw_TrtATraiterPar.RowCount () > 0 Then
	sUser = idw_TrtATraiterPar.GetItemString ( 1, "DOS_SUIVI_PAR" )
	If Not IsNull ( sUser ) And sUser <> "" Then
		sMess2 = idw_TrtContact.GetItemString ( 1, "TXT_MESS2" ) 
		If IsNull ( sMess2 ) Then sMess2 = ""
		sMess2 += " A TRAITER PAR : " + Upper ( sUser)
		idw_TrtContact.SetItem ( 1, "TXT_MESS2", sMess2 ) 
		bOk = True
	End If	
End If

Return bOk
end function

public function long uf_controlerzone (string asnomcol);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ControlerZone (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 25/04/2001 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de zone
//*
//* Arguments		: Val		String		asNomCol
//*
//Migration PB8-WYNIWYG-03/2006 OR
////* Retourne		: Rien
//* Retourne		: long
//Fin Migration PB8-WYNIWYG-03/2006 OR
//*
//*-----------------------------------------------------------------

Int	iRet
DataWindowChild	dwcTemp, dwChild
String	sVal, sAltSc, sCorb,sDosSuiviPar, sNull
Long		lLig

asNomCol = Upper ( asNomCol )
SetNull ( sNull )

iRet  = 0
sVal 	= iDw_TrtContact.GetText ( )

Choose Case asNomCol

	Case "ID_CANAL"

		iDw_TrtContact.SetItem			( 1, "ID_TYP_MSG", stNul.str )
		iDw_TrtContact.uf_Proteger 	( {  "ID_TYP_MSG" }, "0" )
		iDw_TrtContact.GetChild 		(    "ID_TYP_MSG", dwcTemp )
		DwcTemp.SetFilter (    "ID_CANAL = '" + sVal + "'" )
		DwcTemp.Filter		( )
		DwcTemp.Sort      ( )

		iDw_TrtContact.SetItem			( 1, "ID_NAT_MSG", stNul.Dcm )
		iDw_TrtContact.uf_Proteger 	( {  "ID_NAT_MSG" }, "1" )
		iDw_TrtContact.GetChild 		(    "ID_NAT_MSG", dwcTemp )
		DwcTemp.SetFilter (    "ID_CANAL = '-1'" )
		DwcTemp.Filter		( )
		DwcTemp.Sort      ( )


	Case "ID_TYP_MSG"

/*------------------------------------------------------------------*/
/* Je recherche si le contact peut $$HEX1$$ea00$$ENDHEX$$tre saisi dans le mode          */
/* Saisie/Consultation                                              */
/* ou on se trouve                                                  */
/*------------------------------------------------------------------*/

		idw_TrtContact.GetChild 	(    "ID_TYP_MSG", dwcTemp )
		lLig	=	dwcTemp.Find      (    "ID_CANAL = '"+ idw_TrtContact.GetItemString ( 1, "ID_CANAL" ) + &
												  "' AND ID_TYP_MSG = '" + sVal + "'", 1, dwcTemp.RowCount () )

		If lLig > 0 Then 
			sAltSc=	dwcTemp.GetItemString ( lLig, "ALT_SC" )

			If Pos ( sAltSc, isTypTrt ) > 0 Then // Acc$$HEX1$$e800$$ENDHEX$$s autoris$$HEX1$$e900$$ENDHEX$$

				idw_TrtContact.SetItem		( 1, "ID_NAT_MSG", stNul.Dcm )
				idw_TrtContact.uf_Proteger ( {  "ID_NAT_MSG" }, "0" )
				idw_TrtContact.GetChild 	(    "ID_NAT_MSG", dwcTemp )
				DwcTemp.SetFilter (    "ID_CANAL = '"+ idw_TrtContact.GetItemString ( 1, "ID_CANAL" ) + &
															"' AND ID_TYP_MSG = '" + sVal + "'" )
				DwcTemp.Filter		( )
				DwcTemp.Sort      ( )
				idw_TrtContact.SetItem		( 1, "ID_NAT_MSG", stNul.str )
			Else
				iRet = 1

			End If

		Else
			iRet = 1

		End If

	Case "ID_NAT_MSG"

/*------------------------------------------------------------------*/
/* Je recherche si le contact peut $$HEX1$$ea00$$ENDHEX$$tre saisi dans le mode          */
/* Saisie/Consultation                                              */
/* ou on se trouve                                                  */
/*------------------------------------------------------------------*/
		idw_TrtATraiterPar.Hide ()

		idw_TrtContact.GetChild 	(    "ID_NAT_MSG", dwcTemp )
		lLig	=	dwcTemp.Find      (    "ID_CANAL = '" 				+ idw_TrtContact.GetItemString ( 1, "ID_CANAL"   ) + &
												  "' AND ID_TYP_MSG = '" 	+ idw_TrtContact.GetItemString ( 1, "ID_TYP_MSG" ) + &
												  "' AND ID_NAT_MSG = " + sVal, 1, dwcTemp.RowCount () )

		If lLig > 0 Then 
			sAltSc=	dwcTemp.GetItemString ( lLig, "ALT_SC" )

			If Pos ( sAltSc, isTypTrt ) <= 0 Then // Acc$$HEX1$$e800$$ENDHEX$$s non autoris$$HEX1$$e900$$ENDHEX$$

				idw_TrtContact.iiErreur = 0
				iRet = 1

			ElseIf dwcTemp.GetItemString ( lLig, "ALT_CREE_TRV" ) = "O" Then

					/*----------------------------------------------------------------------------*/
					/* Je recherche si le user courant $$HEX2$$e0002000$$ENDHEX$$l'acc$$HEX1$$e800$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$la corbeille du produit.       */
					/*----------------------------------------------------------------------------*/
					If Not This.uf_DroitAccesTravail () Then

						idw_TrtContact.iiErreur = 1
						iRet = 1

					/*----------------------------------------------------------------------------*/
					/* Je recherche si le user courant $$HEX2$$e0002000$$ENDHEX$$l'acc$$HEX1$$e800$$ENDHEX$$s au module des travaux.           */
					/*----------------------------------------------------------------------------*/
					ElseIf Not This.uf_DroitAccesCorbeille () Then

						idw_TrtContact.iiErreur = 2
						iRet = 1

					End If


					/*------------------------------------------------------------------*/
					/* Si la nature est 5 : "A TRAITER PAR", on rend visible la liste   */
					/* des gens ayant acc$$HEX1$$e800$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$ce produit.                               */
					/*------------------------------------------------------------------*/
					If iRet = 0 and sVal = "5" And isTypTrt = "C" Then 
						sDosSuiviPar = idw_DosSuiviPar.GetItemString ( 1, "DOS_SUIVI_PAR" )
						sCorb = String (idw_Produit.GetItemNumber ( 1, "ID_CORB" ) )

						idw_TrtATraiterPar.Reset () 
						idw_TrtATraiterPar.InsertRow ( 0 )

						idw_TrtATraiterPar.GetChild ( "DOS_SUIVI_PAR", dwChild )
						dwChild.SetFilter ( "ID_CORB = " + sCorb )
						dwChild.Filter ()

						If sDosSuiviPar <> "" And Not IsNull ( sDosSuiviPar ) Then
							If dwChild.Find (  "COD_OPER = '" + sDosSuiviPar + "'", 1, dwChild.RowCount() ) > 0 Then 
								idw_TrtATraiterPar.SetItem ( 1, "DOS_SUIVI_PAR", sDosSuiviPar)
							Else
								idw_TrtATraiterPar.SetItem ( 1, "DOS_SUIVI_PAR", sNull )
							End If
						Else 
							idw_TrtATraiterPar.SetItem ( 1, "DOS_SUIVI_PAR", sNull )
						End If

						idw_TrtATraiterPar.Show ()

					End If
					
			End If
		Else
			idw_TrtContact.iiErreur = 0
			iRet = 1

		End If

End Choose

//Migration PB8-WYNIWYG-03/2006 OR
//idw_TrtContact.SetActionCode ( iRet )
Return iRet
//Fin Migration PB8-WYNIWYG-03/2006 OR

end function

on u_gs_sp_sinistre_contact.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_gs_sp_sinistre_contact.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

