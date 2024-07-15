HA$PBExportHeader$w_t_spb_codes_car.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour le param$$HEX1$$e900$$ENDHEX$$trage des codes alphanum$$HEX1$$e900$$ENDHEX$$riques.
forward
global type w_t_spb_codes_car from w_t_spb_code_anc
end type
end forward

global type w_t_spb_codes_car from w_t_spb_code_anc
string title = "Gestion des codes alphanum$$HEX1$$e900$$ENDHEX$$riques"
end type
global w_t_spb_codes_car w_t_spb_codes_car

type variables
u_spb_gs_codes_car	iUoGsCodesCar
u_spb_zn_codes_car	iUoZnCodesCar
end variables

forward prototypes
public function boolean wf_preparersupprimer ()
public function string wf_controlersaisie ()
public function string wf_controlergestion ()
public function boolean wf_preparermodifier ()
end prototypes

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparersupprimer
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	11/06/97 14:44:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Demande de confirmation avant suppression.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai -->	La suppression peut continuer
//*
//*-----------------------------------------------------------------

Boolean 	bRet 				// Variable de retour de la fonction.
String 	sRet				// Valeur de retour de la fonction de contr$$HEX1$$f400$$ENDHEX$$le d'int$$HEX1$$e900$$ENDHEX$$grite.
								// Renseign$$HEX2$$e9002000$$ENDHEX$$avec le nom de la table utilisant le code.
String 	sIdTypCode		// Identifiant du type de code du code $$HEX2$$e0002000$$ENDHEX$$supprimere

String	sIdCode			// Identifiant du code $$HEX2$$e0002000$$ENDHEX$$supprimer.

Integer	iRet				// Confirmation de l'op$$HEX1$$e900$$ENDHEX$$rateur.

bRet = True

/*------------------------------------------------------------------*/
/* Demande de Confirmation avant suppression                        */
/*------------------------------------------------------------------*/
stMessage.sTitre 		= "Suppression d'un Code"
stMessage.sVar[ 1 ] 	= "ce code"
stMessage.Bouton		= YesNo!
stMessage.Icon			= Exclamation!
stMessage.bErreurG	= TRUE
stMessage.sCode		= "CONF001"

iRet						= f_Message ( stMessage )

/*------------------------------------------------------------------*/
/* Traitement suivant confirmation ou non de l'op$$HEX1$$e900$$ENDHEX$$rateur            */
/*------------------------------------------------------------------*/
If iRet = 2 Then 	

	bRet = False

Else

	/*------------------------------------------------------------------*/
	/* V$$HEX1$$e900$$ENDHEX$$rification de l'int$$HEX1$$e900$$ENDHEX$$grit$$HEX2$$e9002000$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rencielle vis $$HEX2$$e0002000$$ENDHEX$$vis des tables   */
	/* d$$HEX1$$e900$$ENDHEX$$pendantes                                                      */
	/*------------------------------------------------------------------*/
	sIdTypCode 	= Dw_1.GetItemString ( 1, "ID_TYP_CODE" )
	sIdCode		= Dw_1.GetItemString ( 1, "ID_CODE" )
	sRet 			= iuoGsCodesCar.uf_Gs_Sup_Code ( sIdTypCode, sIdCode )

	If ( Trim ( sRet ) <> "" ) Then

		stMessage.sTitre 		= "Contr$$HEX1$$f400$$ENDHEX$$le avant Suppression d'un Code"
		stMessage.sVar[ 1 ] 	= sRet  
		stMessage.sVar[ 2 ] 	= "ce code"
		stMessage.sCode		= "REFU002"
		bRet 						= False
		f_Message ( stMessage )

	Else

		/*------------------------------------------------------------------*/
		/* Suppression si aucun probl$$HEX1$$e800$$ENDHEX$$me d'int$$HEX1$$e900$$ENDHEX$$grit$$HEX25$$e900200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
		/*------------------------------------------------------------------*/
		Dw_1.DeleteRow ( 0 )
		bRet 	= true

	End If

End If

Return ( bRet )
end function

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_controlersaisie
//* Auteur			:	YP
//* Date				:	19/08/97 13:54:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le de saisie des zones relatives $$HEX2$$e0002000$$ENDHEX$$la table 
//*					 	CODE_CAR
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: String		"" -> On passe au contr$$HEX1$$f400$$ENDHEX$$le de gestion
//*											Nom de colonne en erreur
//*
//*-----------------------------------------------------------------

String 		sCol [ 3 ]			// Nom des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sErr [ 3 ]			// Erreur relative a un champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String 		sNouvelleLigne		// Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne.
String		sText					// Variable relative a l'ensemble des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sPos					// Nom du premier champ non renseign$$HEX1$$e900$$ENDHEX$$.
String		sVal					// Valeur du champ en v$$HEX1$$e900$$ENDHEX$$rification.

Long			lDebCpt				// Valeur de d$$HEX1$$e900$$ENDHEX$$but du compteur.
Long 			lCpt					// Compteur pour les champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long			lNbrCol				// Nombre de champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.

sNouvelleLigne	= "~r~n"
lNbrCol			= UpperBound ( sCol )
sPos				= ""
sText				= sNouvelleLigne

sCol [ 1 ]		= "ID_CODE"
sCol [ 2 ]		= "ID_TYP_CODE"
sCol [ 3 ]		= "LIB_CODE"

sErr [ 1 ]		= " - Le code"
sErr [ 2 ]		= " - Le type code"
sErr [ 3 ]		= " - Le libell$$HEX2$$e9002000$$ENDHEX$$du code"

/*------------------------------------------------------------------*/
/* Si l'identifiant du code est renseign$$HEX2$$e9002000$$ENDHEX$$par un compteur il na     */
/* faut pas en verifier la saisie.                                  */
/*------------------------------------------------------------------*/
If ibCompteur	Then

	lDebCpt = 2

Else

	lDebCpt = 1

End If

/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/

For	lCpt = lDebCpt		To		lNbrCol

	sVal = Dw_1.GetItemString ( 1, sCol[ lCpt ] )

	If ( IsNull ( sVal ) or Trim ( sVal ) = "" )	Then

		If ( sPos = "" ) 	Then 	sPos = sCol[ lCpt ]
		sText = sText + sErr[ lCpt ] + sNouvelleLigne

	End If

Next

/*------------------------------------------------------------------*/
/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur         */
/*------------------------------------------------------------------*/

If	( sPos <> "" ) Then

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des Codes"
	stMessage.Icon			= Information!
	stMessage.sVar[1] 	= sText
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "GENE001"

	f_Message ( stMessage )

End If

Return ( sPos )
end function

public function string wf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_controlergestion
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	11/06/97 14:49:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Controle de gestion de la saisie.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	String	"" -> Ok
//*											Nom de colonne en erreur
//*
//*-----------------------------------------------------------------

String		sCol 			// Nom de la colonne en Erreur.
String		sIdTypCode	// Identifiant du type de code.

String		sIdCode		// Identifiant du code.

sCol = ""

/*------------------------------------------------------------------*/
/* Il y a contr$$HEX1$$f400$$ENDHEX$$le d'unicit$$HEX2$$e9002000$$ENDHEX$$de l'identifiant du code que s'il est  */
/* saisissable : pas de compteur.                                   */
/*------------------------------------------------------------------*/
If ( istPass.bInsert = True ) AND ( ibCompteur = False )  Then

	sIdTypCode 	= Dw_1.GetItemString ( 1, "ID_TYP_CODE" )
	sIdCode 		= Dw_1.GetItemString ( 1, "ID_CODE" )

	If ( iUoGsCodesCar.uf_gs_id_Code ( sIdTypCode, sIdCode ) = False ) Then

		sCol 		= "ID_CODE"

	End If

End If

Return ( sCol )
end function

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparermodifier
//* Auteur			:	YP
//* Date				:	19/08/97 14:27:08
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$ration avant modification
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai : La Modification peut continuer
//*
//*-----------------------------------------------------------------

Boolean 	bRet = True		// Valeur de Retour.

String	sMod				// Chaine tampon pour un modify.
String  	sCol [ 2 ]		// Liste des champs $$HEX2$$e0002000$$ENDHEX$$prot$$HEX1$$e900$$ENDHEX$$ger.

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")


sCol [ 1 ] 		= "ID_CODE"
sCol [ 2 ] 		= "ID_TYP_CODE"

Dw_1.ilPremCol = 3
Dw_1.ilDernCol = 3

Dw_1.Uf_Proteger ( sCol, "1" )

/*------------------------------------------------------------------*/
/* le type du code n'est pas modifiable, pas de fl$$HEX1$$ea00$$ENDHEX$$che pour la DDDW */
/*------------------------------------------------------------------*/
sMod = "Id_TYP_CODE.DDDW.UseAsBorder=No "

Dw_1.uf_Modify ( sMod )

If Dw_1.Retrieve ( istPass.sTab [ 1 ], istPass.sTab [ 2 ] ) <= 0 Then bRet = False

Return ( bRet )
end function

on ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_spb_code_anc 
//* Evenement 		:	UE_MAJACCUEIL - OVERRIDE
//* Auteur			:	YP
//* Date				:	19/08/97 14:08:50
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Construction de la cha$$HEX1$$ee00$$ENDHEX$$ne pour mettre $$HEX2$$e0002000$$ENDHEX$$jour la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String 	sTab			// Code tabulation
String	sMajLe		// Variable tampon pour MAJ_LE
String	sIdCode		// Variable tampon pour ID_CODE

sTab    = "~t"
sIdCode = dw_1.GetItemString ( 1, "ID_CODE" )
sMajLe  = String ( dw_1.GetItemDateTime ( 1, "MAJ_LE" ), "dd/mm/yyyy hh:mm:ss" )

isMajAccueil 	=	dw_1.GetItemString ( 1, "ID_TYP_CODE" ) 	+ sTab	+ &
 						sIdCode												+ sTab	+ &
 						dw_1.GetItemString ( 1, "LIB_CODE" ) 		+ sTab	+ &
						sMajLe								 				+ sTab	+ &
						dw_1.GetItemString ( 1, "MAJ_PAR" )

end on

on ue_initialiser;call w_t_spb_code_anc::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_spb_codes_car
//* Evenement 		:	UE_INITIALISER - Extend
//* Auteur			:	YP
//* Date				:	14/08/97 09:55:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement des 
//*					 	Codes alphanum$$HEX1$$e900$$ENDHEX$$riques.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iuoGsCodesCar		= Create u_spb_gs_Codes_Car
iuoZnCodesCar 		= Create u_spb_zn_Codes_Car


iuoGsCodesCar.uf_initialisation ( itrTrans, Dw_1 )
iuoZnCodesCar.uf_initialisation ( itrTrans, Dw_1 )
end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_spb_Codes_car
//* Evenement 		:	Close
//* Auteur			:	YP
//* Date				:	14/08/97 09:56:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations $$HEX2$$e0002000$$ENDHEX$$effectuer $$HEX2$$e0002000$$ENDHEX$$la fermeture de la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre .
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Destruction des User Objects de contr$$HEX1$$f400$$ENDHEX$$le de gestion et de saisie */
/* pour le param$$HEX1$$e900$$ENDHEX$$trage des codes                                    */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//Destroy iuoGsCodesCar
//Destroy iuoZnCodesCar
If IsValid(iuoGsCodesCar) Then Destroy iuoGsCodesCar
If IsValid(iuoZnCodesCar) Then Destroy iuoZnCodesCar
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on w_t_spb_codes_car.create
call super::create
end on

on w_t_spb_codes_car.destroy
call super::destroy
end on

type dw_1 from w_t_spb_code_anc`dw_1 within w_t_spb_codes_car
string dataobject = "d_spb_code_car"
end type

event dw_1::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_1 ( OVERRIDE )
//* Evenement 		:	SQLPREVIEW
//* Auteur			:	YP
//* Date				:	11/06/97 17:27:26
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification du SqlPreview de la datawindow Dw_1
//*					 	dans le cas de l'insertion d'un nouveau code.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String	sSqlPreview		// SqlPreview de la datawindow Dw_1.
String	sIdTypcode		// Identifiant du type de code.
String	sLibCode			// Libell$$HEX2$$e9002000$$ENDHEX$$du code.
String	sNomCompteur
String	sMajPar
String	sTable			// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String	sType				// Type d'action effectuer sur la table.
String	sCle [ 2 ]		// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.
//Migration PB8-WYNIWYG-03/2006 FM
//String	sCol [ 6 ]		// Tableau des colonnes de la table : nom de ces colonnes.
//String	sVal [ 6 ]		// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
String	sCol []		// Tableau des colonnes de la table : nom de ces colonnes.
String	sVal []		// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
//Fin Migration PB8-WYNIWYG-03/2006 FM

String	sIdCode			// Identifiant du code.

DateTime	dtCreeLe				
DateTime	dtMajLe
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

//Migration PB8-WYNIWYG-03/2006 FM
//sSqlPreview 		= Dw_1.GetSQLPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "CODE"

Choose Case Left ( sSqlPreview, 4 )

	Case	"INSE"

		sIdTypCode   = This.GetItemString   ( 1, "ID_TYP_CODE" )

		If Not ( ibCompteur )	then

//Migration PB8-WYNIWYG-03/2006 FM
//			sNomCompteur 	= ""
			sNomCompteur 	= " "
//Fin Migration PB8-WYNIWYG-03/2006 FM
			sIdCode 			= This.GetItemString ( 1, "ID_CODE" )

		Else

			sNomCompteur = 'ID_' + Right ( sIdTypCode, 2 )

		End If

		sLibCode     = This.GetItemString   ( 1, "LIB_CODE"    )
		dtCreele     = This.GetItemDateTime ( 1, "CREE_LE"     )
		dtMajLe      = This.GetItemDateTime ( 1, "MAJ_LE"      )
		sMajPar      = This.GetItemString   ( 1, "MAJ_PAR"     )

		/*------------------------------------------------------------------*/
		/* Proc$$HEX1$$e900$$ENDHEX$$dure d'insertion.                                           */
		/*------------------------------------------------------------------*/
		itrTrans.DW_I01_CODECAR (  sIdTypCode , &
									 		sIdCode    , &
									 		sLibCode   , &
									 		dtCreeLe   , &
									 		dtMajLe    , &
									 		sMajPar    , &
									 		sNomCompteur )

		If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			If ibCompteur	Then	This.SetItem ( 1, "ID_CODE", sIdCode )

			sCol = { "ID_TYP_CODE" , "ID_CODE" , "LIB_CODE" }

			sVal [ 1 ] = "'" + sIdTypCode  	+ "'"
			sVal [ 2 ] = "'" + sIdCode 		+ "'"
			sVal [ 3 ] = "'" + sLibCode 		+ "'"

			sCle [ 1 ]	= sVal [ 1 ]
			sCle [ 2 ]  = sVal [ 2 ]

			sType = 'I'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If

		End If

	Case	"UPDA" 

		uoGsTrace.uf_PreparerTrace ( sSqlPreview, sCol, sVal )

		sCle [ 1 ] = "'" + This.GetItemString ( 1, "ID_TYP_CODE" ) 	+ "'"
		sCle [ 2 ] = "'" + This.GetItemString ( 1, "ID_CODE" 		)	+ "'"

		sType = 'U'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			Dw_1.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		End If

	Case	"DELE"

		sIdTypCode 	= This.GetItemString (  1, "ID_TYP_CODE", DELETE!, False	)
		sIdCode   	= This.GetItemString (  1, "ID_CODE"    , DELETE!, False	)

		/*------------------------------------------------------------------*/
		/* Proc$$HEX1$$e900$$ENDHEX$$dure de suppression.                                        */
		/*------------------------------------------------------------------*/
		F_Execute ( "Exec sysadm.DW_D01_CODECAR '" + sIdTypCode + "', '" + sIdCode + "'", itrTrans )

		If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCle [ 1 ] = "'" + sIdTypCode + "'"
			sCle [ 2 ] = "'" + sIdCode		+ "'"
			sType = 'D'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If

		End If

End Choose
//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_1
//* Evenement 		:	ITEMERROR - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	11/06/97 15:45:41
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Gestion des messages d'erreur suite aux erreurs 
//*					   de saisies.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	ibErreur And stMessage.sCode = "" Then

	stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des Codes"
	stMessage.Icon		= Information!

	Choose Case isErrCol

		Case "ID_CODE"

			Choose Case iiErreur

				Case 1

					stMessage.bErreurG	= TRUE
					stMessage.sCode		= "GENE006"
			
			End Choose

	End Choose

	stMessage.bErreurG	=	TRUE
	f_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 FM
//	This.uf_Reinitialiser ()
	Return This.uf_Reinitialiser ()
//Fin Migration PB8-WYNIWYG-03/2006 FM

elseIf ibErreur Then

	stMessage.bErreurG	=	TRUE
	f_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 FM
//	This.uf_Reinitialiser ()
	Return This.uf_Reinitialiser ()
//Fin Migration PB8-WYNIWYG-03/2006 FM

End If

//Migration PB8-WYNIWYG-03/2006 FM
return AncestorReturnValue
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event dw_1::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			:	Dw_1
//* Evenement 		:	ITEMCHANGED - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	11/06/97 15:05:46
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le des champs en cas de modification.
//* Commentaires	:	NB : Du Code existe sur l'ancetre pour effectuer des controles sur le
//*                  champ id_type_code.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
String 	sVal			// Valeur du champ saisi.

/*----------------------------------------------------------------------------*/
/* Si un SetActionCode a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$positionn$$HEX2$$e9002000$$ENDHEX$$dans l'ancetre, on effectue pas de    */
/* controle $$HEX2$$e0002000$$ENDHEX$$ce niveau.                                                      */
/*----------------------------------------------------------------------------*/
If iiSetACtionCode = 0 then

	sVal		= This.GetText( )

	Choose Case isNomCol

			Case "ID_CODE"
				iiSetActionCode 	= iuoZnCodesCar.uf_Zn_Id_Code (  stMessage, sVal, isNomCol )
		
	End Choose

End If

//Migration PB8-WYNIWYG-03/2006 FM
//This.SetActionCode ( iiSetActionCode )
Return iiSetActionCode
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type st_titre from w_t_spb_code_anc`st_titre within w_t_spb_codes_car
end type

type pb_retour from w_t_spb_code_anc`pb_retour within w_t_spb_codes_car
integer width = 224
boolean originalsize = false
end type

type pb_valider from w_t_spb_code_anc`pb_valider within w_t_spb_codes_car
integer width = 224
boolean originalsize = false
end type

type pb_imprimer from w_t_spb_code_anc`pb_imprimer within w_t_spb_codes_car
end type

type pb_controler from w_t_spb_code_anc`pb_controler within w_t_spb_codes_car
integer y = 0
end type

type pb_supprimer from w_t_spb_code_anc`pb_supprimer within w_t_spb_codes_car
end type

