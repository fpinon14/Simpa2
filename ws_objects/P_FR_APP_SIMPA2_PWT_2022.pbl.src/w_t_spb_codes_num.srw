HA$PBExportHeader$w_t_spb_codes_num.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour le param$$HEX1$$e900$$ENDHEX$$trage des codes num$$HEX1$$e900$$ENDHEX$$riques.
forward
global type w_t_spb_codes_num from w_t_spb_code_anc
end type
end forward

global type w_t_spb_codes_num from w_t_spb_code_anc
string title = "Gestion des codes num$$HEX1$$e900$$ENDHEX$$riques"
end type
global w_t_spb_codes_num w_t_spb_codes_num

type variables
u_spb_gs_codes_num	iUoGsCodesNum
u_spb_zn_codes_num	iUoZnCodesNum
end variables

forward prototypes
public function boolean wf_preparersupprimer ()
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

	sRet 			= iuoGsCodesNum.uf_Gs_Sup_Code ( sIdTypCode, dcIdCode )

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
//* Objet			:	w_t_spb_codes_num
//* Evenement 		:	UE_INITIALISER - Extend
//* Auteur			:	YP
//* Date				:	14/08/97 09:55:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement des 
//*					 	Codes num$$HEX1$$e900$$ENDHEX$$riques.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iuoGsCodesNum	= Create u_spb_gs_Codes_num
iuoZnCodesNum 	= Create u_spb_zn_Codes_num


iuoGsCodesNum.uf_initialisation ( itrTrans, Dw_1 )
iuoZnCodesNum.uf_initialisation ( itrTrans, Dw_1 )
end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_spb_Codes_Num
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
//Destroy iuoGsCodesNum
//Destroy iuoZnCodesNum
If IsValid(iuoGsCodesNum) Then Destroy iuoGsCodesNum
If IsValid(iuoZnCodesNum) Then Destroy iuoZnCodesNum
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on w_t_spb_codes_num.create
call super::create
end on

on w_t_spb_codes_num.destroy
call super::destroy
end on

type dw_1 from w_t_spb_code_anc`dw_1 within w_t_spb_codes_num
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
				iiSetActionCode 	= iuoZnCodesNum.uf_Zn_Id_Code ( sVal, isNomCol )
		
	End Choose

End If
//Migration PB8-WYNIWYG-03/2006 FM
//This.SetActionCode ( iiSetActionCode )
Return iiSetActionCode
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type st_titre from w_t_spb_code_anc`st_titre within w_t_spb_codes_num
end type

type pb_retour from w_t_spb_code_anc`pb_retour within w_t_spb_codes_num
end type

type pb_valider from w_t_spb_code_anc`pb_valider within w_t_spb_codes_num
end type

type pb_imprimer from w_t_spb_code_anc`pb_imprimer within w_t_spb_codes_num
end type

type pb_controler from w_t_spb_code_anc`pb_controler within w_t_spb_codes_num
end type

type pb_supprimer from w_t_spb_code_anc`pb_supprimer within w_t_spb_codes_num
end type

