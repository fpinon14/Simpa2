HA$PBExportHeader$u_spb_gs_codes_car.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de gestion relatifs aux codes alphanum$$HEX1$$e900$$ENDHEX$$riques.
forward
global type u_spb_gs_codes_car from u_spb_gs_anc
end type
end forward

global type u_spb_gs_codes_car from u_spb_gs_anc
end type
global u_spb_gs_codes_car u_spb_gs_codes_car

forward prototypes
public function string uf_gs_sup_code (string asidtypcode, string asidcode)
public function boolean uf_gs_id_code (string asIdTypCode, string asIdCode)
end prototypes

public function string uf_gs_sup_code (string asidtypcode, string asidcode);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_sup_code
//* Auteur			:	YP
//* Date				:	19/08/97 12:08:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	V$$HEX1$$e900$$ENDHEX$$rification de l'absence de contrainte 
//*					 	d'int$$HEX1$$e900$$ENDHEX$$grit$$HEX2$$e9002000$$ENDHEX$$en fontion du type de code, pour la 
//*					 	suppression d'un code.
//* Commentaires	:	
//*
//* Arguments		:	String		asIdTypCode	// Type de code $$HEX2$$e0002000$$ENDHEX$$supprimer.
//*						String		asIdCode		// Code $$HEX2$$e0002000$$ENDHEX$$supprimer.
//*														
//* Retourne		: String		"" --> la suppression est possible
//*									Type d'information en relation avec le
//*									code $$HEX2$$e0002000$$ENDHEX$$supprimer.
//*
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//* #1	JCA	16/05/2007	DCMP 070051 - Fusion des tables [courrier] et [composition] en [cour_prod]
//*-----------------------------------------------------------------

String	 sProcedure					// Nom de la procedure declenchee.
String	 sRet 			= ""		// Valeur de retour de la fonction correspondant au 
											// type d'informations en relation avec le code

Long 		lNbCode						// Nombre de code en relation.


Choose Case Upper ( asIdTypCode )

	Case "-CC" 

		/*------------------------------------------------------------------*/
		/* Recherche si le code courrier est li$$HEX1$$e800$$ENDHEX$$s a un courrier             */
		/*------------------------------------------------------------------*/
		// #1
		//itrTrans.IM_S01_COURRIER ( asIdCode, lNbCode )
		itrTrans.IM_S01_COUR_PROD ( asIdCode, lNbCode )

		sRet			= "des courriers de produit"
		//sProcedure	= "IM_S01_COURRIER"
		sProcedure	= "IM_S01_COUR_PROD"
		// #1 - FIN

	Case "-DL" 

		/*------------------------------------------------------------------*/
		/* Recherche si le code d$$HEX1$$e900$$ENDHEX$$lai a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$affect$$HEX4$$e9002000e0002000$$ENDHEX$$une garantie.         */
		/*------------------------------------------------------------------*/
		itrTrans.IM_S01_DELAI ( asIdCode, lNbCode )

		sRet	= "des d$$HEX1$$e900$$ENDHEX$$lais d'une garantie"
		sProcedure	= "IM_S01_DELAI"


	Case "-PL" 

		/*------------------------------------------------------------------*/
		/* Recherche si le code plafond a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$affect$$HEX4$$e9002000e0002000$$ENDHEX$$une garantie.       */
		/*------------------------------------------------------------------*/
		itrTrans.IM_S01_PLAFOND( asIdCode, lNbCode )

		sRet	= "des plafonds d'une garantie"
		sProcedure	= "IM_S01_PLAFOND"

	Case "-MA" 

		/*------------------------------------------------------------------*/
		/* Recherche si le code adh$$HEX1$$e900$$ENDHEX$$sion a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$affect$$HEX4$$e9002000e0002000$$ENDHEX$$un produit         */
		/*------------------------------------------------------------------*/
		itrTrans.IM_S06_PRODUIT( asIdCode, lNbCode )

		sRet	= "des modes d'adh$$HEX1$$e900$$ENDHEX$$sion de produit"
		sProcedure	= "IM_S02_PRODUIT"

End Choose

If ( lNbCode = 0 ) And f_Procedure ( stMessage, itrTrans, sProcedure ) Then sRet = ""

Return ( sRet )

end function

public function boolean uf_gs_id_code (string asIdTypCode, string asIdCode);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_id_code
//* Auteur			:	YP
//* Date				:	19/08/97 14:00:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	V$$HEX1$$e900$$ENDHEX$$rification de l'unicit$$HEX2$$e9002000$$ENDHEX$$de l'identifiant des
//*					 	codes.
//*
//* Arguments		: String		asIdTypCode		//Identifiant du type de Code
//*									asIdCode			//Identifiant du Code
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en
//*
//*-----------------------------------------------------------------

Boolean bRet					// Variable de retour de la fonction.

String 	sLibCode				// Libell$$HEX2$$e9002000$$ENDHEX$$du Code correspondant aux identifiants 
									// pass$$HEX1$$e900$$ENDHEX$$s en parametre.

bRet 		= True
sLibCode = space ( 35 )

/*------------------------------------------------------------------*/
/* Recherche s'il existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$un code avec l'identifiant pass$$HEX2$$e9002000$$ENDHEX$$en   */
/* parametre                                                        */
/*------------------------------------------------------------------*/
itrtrans.IM_S01_CODECAR ( asIdTypCode, asIdCode, slibCode )

/*------------------------------------------------------------------*/
/* Traitement si l'identifiant existe d$$HEX1$$e900$$ENDHEX$$j$$HEX1$$e000$$ENDHEX$$.                         */
/*------------------------------------------------------------------*/

If Trim ( sLibCode ) <> "" Or Not f_Procedure ( stMessage, itrTrans, "IM_S01_CODECAR" ) Then

	stMessage.sTitre  	= "Contr$$HEX1$$f400$$ENDHEX$$le de Gestion des Codes"
	stMessage.sVar[1] 	= asIdCode
	stMessage.sVar[2] 	= "au code"
	stMessage.sVar[3] 	= sLibCode
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "REFU001"

	bRet					= False

	f_Message ( stMessage )

End If

Return ( bRet )
end function

on u_spb_gs_codes_car.create
call super::create
end on

on u_spb_gs_codes_car.destroy
call super::destroy
end on

