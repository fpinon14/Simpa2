HA$PBExportHeader$u_spb_zn_codes_num.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de saisie relatifs aux codes num$$HEX1$$e900$$ENDHEX$$riques.
forward
global type u_spb_zn_codes_num from u_spb_zn_anc
end type
end forward

global type u_spb_zn_codes_num from u_spb_zn_anc
end type
global u_spb_zn_codes_num u_spb_zn_codes_num

forward prototypes
public function integer uf_zn_id_code (string astext, string asnomcol)
end prototypes

public function integer uf_zn_id_code (string astext, string asnomcol);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_zn_id_code
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	12/06/97 12:00:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le de saisie de l'identifiant des codes
//* Commentaires	:	
//*
//* Arguments		:	String	:  asText			// valeur saisie
//*						String	:	asNomCol			// Champ modifi$$HEX1$$e900$$ENDHEX$$e
//*						
//*
//* Retourne		:	Entier :	Correspondant $$HEX2$$e0002000$$ENDHEX$$l'action code $$HEX2$$e0002000$$ENDHEX$$utiliser 
//*					  				dans l'ItemChanged
//*
//*-----------------------------------------------------------------

Integer		iAction			// Valeur de retour de la fonction.

String		sIdCode			// Valeur du Code.
String		sIdTypCode		// Type de Code.

Boolean		bRet				// Variable pour test d'erreur.

iAction = 0
bRet    = True

/*------------------------------------------------------------------*/
/* Lecture des valeurs du code et du type de code saisies           */
/*------------------------------------------------------------------*/
Choose Case asNomCol

	Case "ID_TYP_CODE"
		
		sIdCode		=	String ( iDw_1.GetItemNumber ( 1, "ID_CODE" ) )
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
	/* V$$HEX1$$e900$$ENDHEX$$rifie que le code saisi est bien positif                       */
	/*------------------------------------------------------------------*/
	If Long ( sIdCode ) < 0 Then

		bRet = False
				
	End If

End If

If Not ( bRet )	Then 

	iAction        = 1
	iDw_1.iiErreur	= 1

End If

Return ( iAction )
end function

on u_spb_zn_codes_num.create
TriggerEvent( this, "constructor" )
end on

on u_spb_zn_codes_num.destroy
TriggerEvent( this, "destructor" )
end on

