HA$PBExportHeader$u_spb_zn_codes_car.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de saisie relatifs aux codes alphanum$$HEX1$$e900$$ENDHEX$$riques.
forward
global type u_spb_zn_codes_car from u_spb_zn_anc
end type
end forward

global type u_spb_zn_codes_car from u_spb_zn_anc
end type
global u_spb_zn_codes_car u_spb_zn_codes_car

forward prototypes
public function integer uf_zn_id_code (ref s_message astmessage, string astext, string asnomcol)
end prototypes

public function integer uf_zn_id_code (ref s_message astmessage, string astext, string asnomcol);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Zn_Id_Code
//* Auteur			: YP
//* Date				: 19/08/1997 12:32:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de saisie de l'identifiant des codes alphanum$$HEX1$$e900$$ENDHEX$$riques.
//* Commentaires	: 
//*
//* Arguments		: 	S_Message:	astMessage		//structure des messages d'erreur.
//*						String	:	asNomCol			//Champ modifi$$HEX1$$e900$$ENDHEX$$e.
//*						string	:	asText			//valeur saisie.
//*
//* Retourne		: Entier :	Correspondant $$HEX2$$e0002000$$ENDHEX$$l'action code $$HEX2$$e0002000$$ENDHEX$$utiliser 
//*					  				dans l'ItemChanged
//*-----------------------------------------------------------------					

Integer		iActionCode 	= 0		//Valeur de retour de la fonction
String 		sIdCode						//Valeur du Code
String		sIdTypCode					//Type de Code
Boolean		bRet				= True	//Variable pour test d'erreur

/*------------------------------------------------------------------*/
/* Lecture des valeurs du code et du type de code saisies           */
/*------------------------------------------------------------------*/

Choose Case asNomCol

	Case "ID_TYP_CODE"
		
		sIdCode		=	iDw_1.GetItemString ( 1, "ID_CODE" )
		sIdTypCode	=  asText

	Case "ID_CODE"

		sIdCode		=	asText
		sIdTypCode	=  iDw_1.GetItemString ( 1, "ID_TYP_CODE" )

End Choose


/*------------------------------------------------------------------*/
/* Traitement si les deux champs sont renseign$$HEX1$$e900$$ENDHEX$$s                    */
/*------------------------------------------------------------------*/

If Not isNull ( sIdCode ) And Not isNull ( sIdTypCode ) Then

	/*------------------------------------------------------------------*/
	/* V$$HEX1$$e900$$ENDHEX$$rification de la longueur du code suivant le type de code      */
	/*------------------------------------------------------------------*/

	Choose Case sIdTypCode

		/*------------------------------------------------------------------*/
		/* V$$HEX1$$e900$$ENDHEX$$rification du code pour les courriers                          */
		/*------------------------------------------------------------------*/

		Case "-CC", "-VA"

			If Not ( Match( sIdCode, "^[A-Z][A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]$" ) ) Then

				astMessage.sVar [1]	= "de 6 lettres et chiffres et d$$HEX1$$e900$$ENDHEX$$buter par une lettre"
				bRet 						= False

			End If

		/*------------------------------------------------------------------*/
		/* V$$HEX1$$e900$$ENDHEX$$rification du code pour                                        */
		/* - Les D$$HEX1$$e900$$ENDHEX$$lais                                                     */
		/* - Les Plafonds                                                   */
		/*------------------------------------------------------------------*/

		Case "-DL", "-PL"

			If Not ( Match( sIdCode, "^[A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]$" ) ) Then

				astMessage.sVar [1]	= "de 4 lettres et chiffres" 
				bRet 						= False

			End If

		/*------------------------------------------------------------------*/
		/* V$$HEX1$$e900$$ENDHEX$$rification du code pour                                        */
		/* - Les Modes de R$$HEX1$$e900$$ENDHEX$$glement                                         */
		/*------------------------------------------------------------------*/

		Case "-MR"

			If Not ( Match ( sIdCode, "^[A-Z]+$" )  AND  ( Len( sIdCode ) <= 2 ) ) Then

				astMessage.sVar [1]	= "d'une ou deux lettres" 
				bRet 						= False

			End If

		/*------------------------------------------------------------------*/
		/* V$$HEX1$$e900$$ENDHEX$$rification du code pour                                        */
		/* - les interlocuteurs.                                            */
		/*------------------------------------------------------------------*/

		Case "-IN", "-MA"

			If Not ( Match ( sIdCode, "^[A-Z]$" ) ) Then

				astMessage.sVar [1]	= "d'une lettre" 
				bRet 						= False

			End If

	End Choose

End If

If bRet = False Then 
	iActionCode 	= 1
	iDw_1.iiErreur	= 1
End If

Return ( iActionCode )
end function

on u_spb_zn_codes_car.create
TriggerEvent( this, "constructor" )
end on

on u_spb_zn_codes_car.destroy
TriggerEvent( this, "destructor" )
end on

