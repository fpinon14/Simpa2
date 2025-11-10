HA$PBExportHeader$n_cst_sp_ws_game_caller.sru
forward
global type n_cst_sp_ws_game_caller from n_cst_sp_ws_caller
end type
end forward

global type n_cst_sp_ws_game_caller from n_cst_sp_ws_caller
end type
global n_cst_sp_ws_game_caller n_cst_sp_ws_game_caller

type variables
game_wsbonechangegame iProxy
String isErrorcode
end variables

forward prototypes
public function integer createproxy (soapconnection asoapcnx)
public function long uf_get_no_bon_game (decimal adcidsin, decimal adcmontant, datetime adtdteadh, string asidadh, ref string asnobon)
end prototypes

public function integer createproxy (soapconnection asoapcnx);
//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_sp_ws_game_caller::createproxy
//* Auteur			: F. Pinon
//* Date				: 21/11/2011 14:37:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value soapconnection asoapcnx	 */
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	10/07/2012	[PR09.3] Utilisation de la base d'int$$HEX1$$e900$$ENDHEX$$gration
//			FPI	20/03/2017	[URL_GAME] externalisation de l'URL du WS Game
//*-----------------------------------------------------------------

long lRet
String endpointURL

try
	endpointURL= ProfileString(stglb.sfichierini,"GAME","URL_WEBSERVICE_GAME","") // [URL_GAME]

	// [URL_GAME]
   lret = aSoapcnx.CreateInstance(iProxy, 	"game_wsbonechangegame", endpointURL)
	
	If lRet=0 Then lRet=1 Else lRet=-1
catch (RuntimeError re)
	
	lRet=-1
	
End try

 
return lRet
end function

public function long uf_get_no_bon_game (decimal adcidsin, decimal adcmontant, datetime adtdteadh, string asidadh, ref string asnobon);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_sp_ws_game_caller::uf_get_no_bon_game
//* Auteur			: F. Pinon
//* Date				: 21/11/2011 15:04:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value decimal adcidsin	 */
/* 	value decimal adcmontant	 */
/* 	value datetime adtdteadh	 */
/* 	value string asidadh	 */
/* 	ref string asnobon	 */
//*
//* Retourne		: 1 si OK
//*						-1 erreur de communication
//*						-2 erreur de format
//*						-3 demande d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$effectu$$HEX1$$e900$$ENDHEX$$e
//*						-4 police inexistante
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//			FPI	20/03/2017	[URL_GAME] externalisation de l'URL du WS Game
//* 
//*-----------------------------------------------------------------

long lRet=1
String sUrl

game_inputgetnumber uoInputGetNumber
game_outputgetnumber uoOutputGetNumber

Try

	uoInputGetNumber = CREATE game_inputgetnumber
	uoOutputGetNumber = CREATE game_outputgetnumber // [ITSM110270] PHG, 21/03/2012, tentative de r$$HEX1$$e900$$ENDHEX$$solution.
	
	uoInputGetNumber.amount = adcmontant
	uoInputGetNumber.claimreference = string( adcIdSin)
	uoInputGetNumber.ws_date = adtdteadh
	uoInputGetNumber.insurancepolicynumber = asIdAdh
	
	uoOutputGetNumber=iProxy.wsgetnumber_bonechange( uoInputGetNumber )
	
	If isValid(uoOutputGetNumber)Then
		If uoOutputGetNumber.operation <> "00" Then
			lRet=-Long(uoOutputGetNumber.operation)
			
			// [GAME_SIM]
			If Upper(SQLCA.Database) <> "SIMPA2_PRO" Then
				lRet=1
				asNobon=String(Rand(999999999999))
			Else 
				isErrorcode=String(lRet)
				isSoapError="Retour incorrect : zone operation"
			End if
			// :[GAME_SIM]
			
		Else
			asNobon=uoOutputGetNumber.numbon
		End if
	Else
		isErrorcode="0"
		isSoapError="Retour invalide"
	End if
			
catch ( SoapException e )
	lRet = uf_gestionexception( e)
	
	isErrorcode=String(e.Number)
	isSoapError="SoapException : " + e.Text
end try

// [TRACE_WEB_SERVICE]
 // [URL_GAME]
sUrl= ProfileString(stglb.sfichierini,"GAME","URL_WEBSERVICE_GAME","") 

// :[URL_GAME]
 
if lRet < 0 Then 
	f_trace_web_service("Game",sUrl, adcidsin, integer(isErrorcode), isSoapError,uoInputGetNumber.uf_getstring())
End if

If isValid(uoInputGetNumber) Then Destroy uoInputGetNumber
If isValid(uoOutputGetNumber) Then Destroy uoInputGetNumber


Return lRet
end function

on n_cst_sp_ws_game_caller.create
call super::create
end on

on n_cst_sp_ws_game_caller.destroy
call super::destroy
end on

