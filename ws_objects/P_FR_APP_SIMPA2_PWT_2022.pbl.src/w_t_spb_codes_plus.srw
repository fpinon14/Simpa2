HA$PBExportHeader$w_t_spb_codes_plus.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour le param$$HEX1$$e900$$ENDHEX$$trage des codes commen$$HEX1$$e700$$ENDHEX$$ant par +.
forward
global type w_t_spb_codes_plus from w_t_spb_code_anc
end type
end forward

global type w_t_spb_codes_plus from w_t_spb_code_anc
end type
global w_t_spb_codes_plus w_t_spb_codes_plus

type variables
u_spb_gs_codes_num	iUoGsCodesNum
u_spb_zn_codes_num	iUOZnCodesNum
end variables

forward prototypes
public function boolean wf_preparersupprimer ()
end prototypes

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparersupprimer
//* Auteur			:	YP
//* Date				:	19/08/97 15:06:14
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

Long 		dcIdCode			// Identifiant du code $$HEX2$$e0002000$$ENDHEX$$supprimer.

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
	dcIdCode 	= Dw_1.GetItemNumber ( 1, "ID_CODE" )

//	sRet 			= iuoGsCodesNum.uf_Gs_Sup_Code ( sIdTypCode, dcIdCode )

	If ( Trim ( sRet ) <> "" ) Then

		stMessage.sTitre 		= "Contr$$HEX1$$f400$$ENDHEX$$le avant Suppression d'un Code"
		stMessage.sVar[ 1 ] 	= sRet  
		stMessage.sVar[ 2 ] 	= "ce code"
		stMessage.bErreurG	= TRUE
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

on ue_initialiser;call w_t_spb_code_anc::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_spb_codes_plus
//* Evenement 		:	Ue_Initialiser
//* Auteur			:	Y. Picard
//* Date				:	19/08/1997 14:58:28
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Met $$HEX2$$e0002000$$ENDHEX$$jour le titre de la fen$$HEX1$$ea00$$ENDHEX$$tre en fonction du type de code.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------


isTypcode = istPass.sTab [ 1 ]

Choose Case isTypCode

	Case "+DT"
		This.Title = "Gestion des d$$HEX1$$e900$$ENDHEX$$tails de sinistre"

	Case "+EV"
		This.Title = "Gestion des $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nements"

	Case "+RE"
		This.Title = "Gestion des motifs de refus"

	Case "+NS"
		This.Title = "Gestion des natures de sinistre"

	Case "+PC"
		This.Title = "Gestion des pi$$HEX1$$e800$$ENDHEX$$ces"

	Case "+TR"
		This.Title = "Gestion des territorialit$$HEX1$$e900$$ENDHEX$$s"

End Choose
end on

on open;call w_t_spb_code_anc::open;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_spb_codes_plus
//* Evenement 		:	open
//* Auteur			:	Y. Picard
//* Date				:	19/08/1997 15:07:18
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation des Uo.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

iUOGsCodesNum	=	CREATE u_spb_gs_codes_num
iUOZnCodesNum	=	CREATE u_spb_zn_codes_num

iUoGsCodesNum.Uf_Initialisation ( iTrTrans, Dw_1 )
iUoZnCodesNum.Uf_Initialisation ( iTrTrans, Dw_1 )
end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_spb_codes_plus
//* Evenement 		:	Close
//* Auteur			:	Y. Picard
//* Date				:	19/08/1997 15:07:18
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Destruction des Uo.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//DESTROY iUOGsCodesNum
//DESTROY iUOZnCodesNum
If IsValid(iUOGsCodesNum) Then DESTROY iUOGsCodesNum
If IsValid(iUOZnCodesNum) Then DESTROY iUOZnCodesNum
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on w_t_spb_codes_plus.create
call super::create
end on

on w_t_spb_codes_plus.destroy
call super::destroy
end on

type dw_1 from w_t_spb_code_anc`dw_1 within w_t_spb_codes_plus
end type

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_1
//* Evenement 		:	ITEMERROR - Extend
//* Auteur			:	YP
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

					stMessage.sCode	= "CODE001"

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
				iiSetActionCode 	= iUoZnCodesNum.uf_Zn_Id_Code ( sVal, isNomCol )
		
	End Choose

End If
//Migration PB8-WYNIWYG-03/2006 FM
//This.SetActionCode ( iiSetActionCode )
Return iiSetActionCode
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type st_titre from w_t_spb_code_anc`st_titre within w_t_spb_codes_plus
end type

type pb_retour from w_t_spb_code_anc`pb_retour within w_t_spb_codes_plus
end type

type pb_valider from w_t_spb_code_anc`pb_valider within w_t_spb_codes_plus
end type

type pb_imprimer from w_t_spb_code_anc`pb_imprimer within w_t_spb_codes_plus
end type

type pb_controler from w_t_spb_code_anc`pb_controler within w_t_spb_codes_plus
end type

type pb_supprimer from w_t_spb_code_anc`pb_supprimer within w_t_spb_codes_plus
end type

