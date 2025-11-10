HA$PBExportHeader$w_td_sp_confirmation.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement simple utilis$$HEX2$$e9002000$$ENDHEX$$comme un d$$HEX1$$e900$$ENDHEX$$tail de W_Td_Sp_Produit pour la saisie des confirmations des courriers.
forward
global type w_td_sp_confirmation from w_8_traitement
end type
end forward

global type w_td_sp_confirmation from w_8_traitement
int X=298
int Y=549
int Width=1898
int Height=1073
boolean TitleBar=true
string Title="Gestion des confirmations des courriers"
end type
global w_td_sp_confirmation w_td_sp_confirmation

type variables
W_tm_Sp_Produit		iwAppel

Long			ilLigne
Long			ilNbCol

u_sp_zn_confirmation	iuoZnconfirmation

Decimal			idcIdNatCour

// DDDW pour les premieres confirmations.
//DataWindowChild		idwIdConfDeb

// DDDW pour la derni$$HEX1$$e800$$ENDHEX$$re confirmation.
//DataWindowChild		idwIdConfFin


end variables

forward prototypes
public function boolean wf_preparermodifier ()
public function boolean wf_executervalider ()
public function string wf_controlersaisie ()
end prototypes

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_PreparerModifier
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 01/07/1997 15:50:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Op$$HEX1$$e900$$ENDHEX$$rations avant modification
//* Commentaires	: Aucun
//*
//* Arguments		: Aucun
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en	-->	True :  L'insertion peut continuer
//*										
//*
//*-----------------------------------------------------------------



	ilLigne = istPass.lTab[1]

	Dw_1.SetItem ( 1 , "ID_PROD" , &
						iwAppel.Uo_Courrier.Dw_Source.GetItemNumber ( ilLigne , "ID_PROD" ) )

	Dw_1.SetItem ( 1 , "ID_NAT_COUR" , &
						iwAppel.Uo_Courrier.Dw_Source.GetItemString ( ilLigne , "ID_NAT_COUR" ) )

	Dw_1.SetItem ( 1 , "LIB_CODE" , &
						iwAppel.Uo_Courrier.Dw_Source.GetItemString ( ilLigne , "LIB_CODE" ) )

	Dw_1.SetItem ( 1 , "ID_COUR" , &
						iwAppel.Uo_Courrier.Dw_Source.GetItemString ( ilLigne , "ID_COUR" ) )

	Dw_1.SetItem ( 1 , "ID_CONF_DEB" , &
						iwAppel.Uo_Courrier.Dw_Source.GetItemString ( ilLigne , "ID_CONF_DEB" ) )

	Dw_1.SetItem ( 1 , "ID_CONF_N" , &
						iwAppel.Uo_Courrier.Dw_Source.GetItemString ( ilLigne , "ID_CONF_N" ) )

	Dw_1.SetItem ( 1 , "ID_CONF_FIN" , &
						iwAppel.Uo_Courrier.Dw_Source.GetItemString ( ilLigne , "ID_CONF_FIN" ) )

	Dw_1.SetItem ( 1 , "ALT_CONF" , &
						iwAppel.Uo_Courrier.Dw_Source.GetItemString ( ilLigne , "ALT_CONF" ) )

	Dw_1.SetItem ( 1 , "CREE_LE" , &
						iwAppel.Uo_Courrier.Dw_Source.GetItemDateTime ( ilLigne , "CREE_LE" ) )

	Dw_1.SetItem ( 1 , "MAJ_LE" , &
						iwAppel.Uo_Courrier.Dw_Source.GetItemDateTime ( ilLigne , "MAJ_LE" ) )

	Dw_1.SetItem ( 1 , "MAJ_PAR" , &
						iwAppel.Uo_Courrier.Dw_Source.GetItemString ( ilLigne , "MAJ_PAR" ) )


Return True
end function

public function boolean wf_executervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_ExecuterValider
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	02/07/97 09:56:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Fonction d'Enregistrement.
//* Commentaires	:	Effectue la mise $$HEX2$$e0002000$$ENDHEX$$jour de la Dw appelante.
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Boolean		 TRUE = La validation peut continuer
//*
//*-----------------------------------------------------------------

Long		lI					// Variable compteur
Long		lTemp				// Variable Long pour $$HEX1$$e900$$ENDHEX$$viter les virgule Car GetItemNumber
								// Ram$$HEX1$$e800$$ENDHEX$$ne un decimal et le format d'afficharge dans les datawindow
								// est avec un point.

	For li = 1 To ilNbCol

		Choose Case li

			Case 1
					lTemp = dw_1.GetItemNumber   ( 1, lI )
					iwAppel.uo_Courrier.dw_Source.SetItem ( ilLigne , lI, lTemp )

			Case 9, 10
					iwAppel.uo_Courrier.dw_Source.SetItem ( ilLigne , lI, dw_1.GetItemDateTime ( 1, 10 ) )

			Case Else
					iwAppel.uo_Courrier.dw_Source.SetItem ( ilLigne , lI, dw_1.GetItemString   ( 1, lI ) )

		End Choose

	Next

Return True
end function

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		:	Wf_ControlerSaisie
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	02/07/1997 10:05:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le de saisie des zones relatives $$HEX2$$e0002000$$ENDHEX$$la table 
//*					 	COURRIER.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	String		"" -> On passe au controle de gestion
//*												Nom de colonne en erreur
//*
//*-----------------------------------------------------------------

String 		sCol [ 4 ]			// Nom des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sVal [ 4 ]			// Valeur du champ en v$$HEX1$$e900$$ENDHEX$$rification.
String		sErr [ 4 ]			// Erreur relative $$HEX2$$e0002000$$ENDHEX$$un champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String 		sNouvelleLigne		// Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne.
String		sText					// Variable relative a l'ensemble des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sPos					// Nom du premier champ non renseign$$HEX1$$e900$$ENDHEX$$.

String		sAltConf				// courrier de confirmation ou non.

Long 			lCpt					// Compteur pour les champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long			lNbrCol				// Nombre de champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.

sNouvelleLigne	= "~r~n"
lNbrCol			= UpperBound ( sCol )
sPos				= ""
sText				= sNouvelleLigne

sCol [ 1 ]		= "ID_COUR"
sCol [ 2 ]		= "ID_CONF_DEB"
sCol [ 3 ]		= "ID_CONF_N"
sCol [ 4 ]		= "ID_CONF_FIN"

sErr [ 1 ]		= " - Le code du courrier type"
sErr [ 2 ]		= " - Le courrier de premi$$HEX1$$e800$$ENDHEX$$re confirmation"
sErr [ 3 ]		= " - Les courriers suivants"
sErr [ 4 ]		= " - Le courrier de derni$$HEX1$$e800$$ENDHEX$$re confirmation"


/*------------------------------------------------------------------*/
/* Acquisition des valeurs $$HEX2$$e0002000$$ENDHEX$$contr$$HEX1$$f400$$ENDHEX$$ler                              */
/*------------------------------------------------------------------*/
sALtConf  = dw_1.GetItemString ( 1, "ALT_CONF"  )

For	lCpt = 1 To lNbrCol

	sVal [ lCpt ] = String ( dw_1.GetItemString ( 1, sCol [ lCpt ] ) )

Next

/*------------------------------------------------------------------*/
/* Test si les valeur sont renseign$$HEX1$$e900$$ENDHEX$$es.                             */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Le courrier type                                                 */
/*------------------------------------------------------------------*/

If ( IsNull ( sVal [ 1 ] ) or Trim ( sVal [ 1 ] ) = "" ) then
	sPos = sCol [ 1 ]
	sText = sText + sErr [ 1 ] + sNouvelleLigne
End If

/*------------------------------------------------------------------*/
/* Les courriers de confirmation et les delais                      */
/*------------------------------------------------------------------*/

If sALtConf = "O"	Then

	For lCpt = 2	To	4

		If ( IsNull ( sVal [ lCPt ] ) or Trim ( sVal [ lCpt ] ) = "" )	Then

			If ( sPos = "" ) 	Then 	sPos = sCol [ lCpt ]
			sText = sText + sErr [ lCpt ] + sNouvelleLigne

		End If

	Next

End If

/*------------------------------------------------------------------*/
/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur s'il y  */
/* en a une :												                    */
/*------------------------------------------------------------------*/

If	( sPos <> "" ) Then

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des Confirmations"
	stMessage.Icon			= Information!
	stMessage.sVar[1] 	= sText
	stMessage.sCode		= "GENE001"

	f_Message ( stMessage )

End If

Return ( sPos )
end function

on close;call w_8_traitement::close;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_td_sp_Confirmation
//* Evenement 		:	Close
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	08/07/1997 09:57:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations $$HEX2$$e0002000$$ENDHEX$$effectuer $$HEX2$$e0002000$$ENDHEX$$la fermeture de la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre.
//* Commentaires	:	Aucun
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Destruction du User Object de contr$$HEX1$$f400$$ENDHEX$$le de gestion et de saisie   */
/* pour le param$$HEX1$$e900$$ENDHEX$$trage des confirmations des courriers.             */
/*------------------------------------------------------------------*/
Destroy	iuoZnConfirmation

end on

on ue_initialiser;call w_8_traitement::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_Confirmation
//* Evenement 		: UE_INITIALISER - Extend
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 26/02/97 13:35:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement des 
//*					  confirmations des courriers.
//* Commentaires	: Aucun
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild	dwcCourMaitre		// DDDW des codes courriers de Uo_Courrier.Dw_Source sur
												// la fenetre des produits.
DataWindowChild	dwcCourType			// DDDW du code courrier.
DataWindowChild	dwcCourDeb			// DDDW de la premi$$HEX1$$e800$$ENDHEX$$re confirmation.
DataWindowChild	dwcCourN				// DDDW des confirmations suivantes.
DataWindowChild	dwcCourFin			// DDDW de la derni$$HEX1$$e800$$ENDHEX$$re confirmation.


iwAppel = iwParent

iuoZnConfirmation = Create u_sp_zn_Confirmation
iuoZnConfirmation.uf_initialisation ( itrTrans, Dw_1 )

/*------------------------------------------------------------------*/
/* Je d$$HEX1$$e900$$ENDHEX$$sire que la fen$$HEX1$$ea00$$ENDHEX$$tre se comporte comme une fen$$HEX1$$ea00$$ENDHEX$$tre de        */
/* d$$HEX1$$e900$$ENDHEX$$tail.                                                          */
/*------------------------------------------------------------------*/
Wf_ActiverModeDetail ( True )

/*------------------------------------------------------------------*/
/* Je ne d$$HEX1$$e900$$ENDHEX$$sire pas que la fen$$HEX1$$ea00$$ENDHEX$$tre mette $$HEX2$$e0002000$$ENDHEX$$jour une liste commme le */
/* ferai une fen$$HEX1$$ea00$$ENDHEX$$tre de traitement simple appel$$HEX2$$e9002000$$ENDHEX$$par une fen$$HEX1$$ea00$$ENDHEX$$tre    */
/* d'accueil.                                                       */
/*------------------------------------------------------------------*/
wf_ActiverMajAccueil ( False )

/*------------------------------------------------------------------*/
/* Nombre de colonne de la datawindow                               */
/*------------------------------------------------------------------*/
ilNbCol = Long ( iwAppel.uo_Courrier.dw_Source.Describe ( "Datawindow.Column.Count" ) )

Dw_1.InsertRow(0)

/*------------------------------------------------------------------*/
/* Initialisation des DropDown                                      */
/*------------------------------------------------------------------*/

/*----------------------------------------------------------------------------*/
/* La DDDW des courriers type 'pointe' sur celle du courrier type de la       */
/* fen$$HEX1$$ea00$$ENDHEX$$tre de gestion des produits.                                           */
/*----------------------------------------------------------------------------*/
iwAppel.Uo_Courrier.Dw_Source.GetChild ( "ID_COUR" , dwcCourMaitre )
Dw_1.GetChild ( "ID_COUR", dwcCourType )

dwcCourMaitre.ShareData ( dwcCourType )

/*------------------------------------------------------------------*/
/* Les courriers de confirmation doivent avoir 'L' en 2$$HEX1$$e800$$ENDHEX$$me lettre.  */
/* NB : Cette restriction est mise en oeuvre directement dans la    */
/* proc. stock$$HEX1$$e900$$ENDHEX$$e.                                                   */
/*------------------------------------------------------------------*/

Dw_1.GetChild ( "ID_CONF_DEB", dwcCourDeb )
dwcCourDeb.SetTransObject 	( itrTrans )
dwcCourDeb.Retrieve  		( )

Dw_1.GetChild ( "ID_CONF_N", dwcCourN )
dwcCourDeb.ShareData ( dwcCourN )

Dw_1.GetChild ( "ID_CONF_FIN", dwcCourFin )
dwcCourDeb.ShareData ( dwcCourFin )



end on

on w_td_sp_confirmation.create
call w_8_traitement::create
end on

on w_td_sp_confirmation.destroy
call w_8_traitement::destroy
end on

type dw_1 from w_8_traitement`dw_1 within w_td_sp_confirmation
event ue_keydown pbm_keydown
int X=14
int Y=189
int Width=1861
int Height=789
string DataObject="d_sp_confirmation"
boolean Border=false
end type

on dw_1::itemchanged;call w_8_traitement`dw_1::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			:	Dw_1
//* Evenement 		:	ItemChanged - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	01/07/1997 17:14:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le de champs
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String	sVal			// Valeur $$HEX2$$e0002000$$ENDHEX$$contr$$HEX1$$f400$$ENDHEX$$ler.

sVal 		= This.GetText ( )

Choose Case isNomCol

	Case "ALT_CONF"

		iuoZnConfirmation.Uf_Zn_InitConfirmation ( sVal )

End Choose
end on

type st_titre from w_8_traitement`st_titre within w_td_sp_confirmation
int X=10
int Y=917
boolean Visible=false
end type

type pb_retour from w_8_traitement`pb_retour within w_td_sp_confirmation
int Y=29
end type

type pb_valider from w_8_traitement`pb_valider within w_td_sp_confirmation
int X=284
int Y=29
int TabOrder=30
end type

type pb_imprimer from w_8_traitement`pb_imprimer within w_td_sp_confirmation
int X=513
int Y=917
int TabOrder=0
boolean Visible=false
string DisabledName=""
end type

type pb_controler from w_8_traitement`pb_controler within w_td_sp_confirmation
int X=266
int Y=913
int TabOrder=0
boolean Visible=false
end type

type pb_supprimer from w_8_traitement`pb_supprimer within w_td_sp_confirmation
int X=23
int Y=913
int TabOrder=0
boolean Visible=false
end type

