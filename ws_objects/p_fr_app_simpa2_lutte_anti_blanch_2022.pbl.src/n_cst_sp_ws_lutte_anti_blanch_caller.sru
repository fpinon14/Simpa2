HA$PBExportHeader$n_cst_sp_ws_lutte_anti_blanch_caller.sru
forward
global type n_cst_sp_ws_lutte_anti_blanch_caller from nonvisualobject
end type
end forward

global type n_cst_sp_ws_lutte_anti_blanch_caller from nonvisualobject autoinstantiate
end type

type variables
public:

private:

st_variable_lab istDatas[]



end variables

forward prototypes
public subroutine uf_reset_datas ()
private function string uf_buildrequest ()
public function string uf_get_data (string asvariable)
public subroutine uf_add_data (string asvariable, string asvaleur)
public function lutte_anti_blanch_response uf_parsejsonresult (string asjson)
public function boolean call_api_put_check_risk (ref lutte_anti_blanch_response uoresult)
end prototypes

public subroutine uf_reset_datas ();

SetNull(istDatas)

end subroutine

private function string uf_buildrequest ();// "{~n" si besoin de mettre des sauts

string sRet

sRet = ''

sRet += '{'
sRet += '  "identity": { '
sRet += '    "firstName": "' + This.uf_get_data( "IdentPrenom") + '", '
sRet += '    "lastName": "' + This.uf_get_data( "IdentNom") + '", '
sRet += '    "nationality": "' + This.uf_get_data( "IdentNationalite") + '", '
sRet += '    "birth": {' 
sRet += '       "date": "' + This.uf_get_data( "NaissDate") + '", '
sRet += '       "place": "' + This.uf_get_data( "NaissLieu") + '", '
sRet += '       "departement": "' + This.uf_get_data( "NaissDept") + '", '
sRet += '       "country": "' + This.uf_get_data( "NaissPays") + '" '
sRet += '    }'
sRet += '  },  '
sRet += '  "postalAddress": {  '
sRet += '    "address": "' + This.uf_get_data( "AdressAdr") + '", '
sRet += '    "zipCode": "' + This.uf_get_data( "AdressAdrcp") + '", '
sRet += '    "city": "' + This.uf_get_data( "AdressVille") + '", '
sRet += '    "country": "' + This.uf_get_data( "AdressPays") + '" '
sRet += '  }  '
sRet += '}'

return sRet
end function

public function string uf_get_data (string asvariable);String sRet=""
integer iPos

if isnull(istDatas) then return ""

For iPos=1 To UpperBound(istDatas)
	if upper(istDatas[iPos].variable)=upper(asVariable) Then
		sRet=istDatas[iPos].valeur
		If IsNull ( sRet ) Then sRet = ""
		exit 
	End if
Next

Return sRet
end function

public subroutine uf_add_data (string asvariable, string asvaleur);
st_variable_lab stDatas[]
int iIndex

asvariable = trim ( asvariable )
asvaleur = trim ( asvaleur )

if isnull(istDatas) Then
	istDatas = stDatas	
	iIndex = 1
else
	iIndex = UpperBound( istDatas ) + 1
End if

istDatas[iIndex].variable= asvariable 
istDatas[iIndex].valeur= asvaleur 

If asvariable = "NaissDate" Then istDatas[iIndex].valeur = Right ( asvaleur, 4 ) + '-' + Mid (asvaleur, 4, 2 ) + "-" + Left ( asvaleur, 2 )

/*
// Chargement pour le code client

iuoCaller.uf_Add_Data ( "id_sin", xxxx )     // 10 car max
iuoCaller.uf_Add_Data ( "IdentCivilite", xxxx )     // 2 car max
iuoCaller.uf_Add_Data ( "IdentNationalite", xxxx )  // 20 car max
iuoCaller.uf_Add_Data ( "IdentNom", xxxx )          // 50 car max  
iuoCaller.uf_Add_Data ( "IdentPrenom", xxxx )       // 50 car max  
iuoCaller.uf_Add_Data ( "NaissDate", xxxx )  // jj/mm/aaaa - 10 car max
iuoCaller.uf_Add_Data ( "NaissDept", xxxx )  // 2 car max
iuoCaller.uf_Add_Data ( "NaissLieu", xxxx )  // 25 car max
iuoCaller.uf_Add_Data ( "NaissPays", xxxx )  // 20 car max
iuoCaller.uf_Add_Data ( "AdressAdrcp", xxxx ) // 5 car max
iuoCaller.uf_Add_Data ( "AdressAdr", xxxx )   // 50 car max
iuoCaller.uf_Add_Data ( "AdressPays", xxxx )  // 20 car max
iuoCaller.uf_Add_Data ( "AdressVille", xxxx ) // 20 car max
*/

Return

end subroutine

public function lutte_anti_blanch_response uf_parsejsonresult (string asjson);lutte_anti_blanch_response uoResult

uoResult=CREATE lutte_anti_blanch_response

uoResult.uf_fillfromjson( asjson)

Return uoResult
end function

public function boolean call_api_put_check_risk (ref lutte_anti_blanch_response uoresult);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_sp_ws_lutte_anti_blanch_caller::call_api_put_check_risk ( PRIVATE )
//* Auteur        : JFF
//* Date          : 20/05/2020 14:35:15
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    28/02/2024  [MCO_190_191_BECLM]
//*-----------------------------------------------------------------


// la m$$HEX1$$e900$$ENDHEX$$thode CHECK_RISK (en m$$HEX1$$e900$$ENDHEX$$thode PUT) cr$$HEX3$$e900e9002000$$ENDHEX$$un dossier chez BeCLM

OleObject loo_xmlhttp
n_cst_String nvString
String sPassword, sCleAuthent
n_cst_crypter_base64 nvBase64
string sUrl, sErreur
string ls_response_text
long ll_status_code
string srequest

Boolean bRet=true

// [MCO_190_191_BECLM]
If F_CLE_A_TRUE ( "MCO_190_191_BECLM" ) Then
	sUrl = Trim ( ProfileString (stglb.sfichierini ,"LUTTE_ANTI_BLANCHIMENT","URL_WEBSERVICE_LAB_MCO190","*"))
	sCleAuthent = Trim ( ProfileString (stglb.sfichierini,"LUTTE_ANTI_BLANCHIMENT","AUTHKEY_WEBSERVICE_LAB_MCO190","*"))
Else 
	sUrl = Trim ( ProfileString (stglb.sfichierini ,"LUTTE_ANTI_BLANCHIMENT","URL_WEBSERVICE_LAB","*"))
	sCleAuthent = Trim ( ProfileString (stglb.sfichierini,"LUTTE_ANTI_BLANCHIMENT","AUTHKEY_WEBSERVICE_LAB","*"))
End If

if sUrl="*" or sCleAuthent="*" Then
		// Set return code in st
	return false
End if

// [MCO_190_191_BECLM]
If F_CLE_A_TRUE ( "MCO_190_191_BECLM" ) Then
	sUrl = F_REMPLACE ( sUrl, "{flow_name}", This.uf_get_data( "flow_name") )
	sUrl = F_REMPLACE ( sUrl, "{externalRefId}", This.uf_get_data( "id_client") )
Else 
	sUrl += "/" + This.uf_get_data( "id_client")
End If 

srequest=uf_buildrequest( )

try
	//Create an instance of our COM object
	loo_xmlhttp = CREATE oleobject
	loo_xmlhttp.ConnectToNewObject("Msxml2.XMLHTTP.6.0")
	
//	loo_xmlhttp.open ("GET",sUrl, false)
	loo_xmlhttp.open ("PUT",sUrl, false)
	
	loo_xmlhttp.SetRequestHeader( "Content-Type", "application/json")
	loo_xmlhttp.setRequestHeader( "X-login-token", sCleAuthent)  
	loo_xmlhttp.SetRequestHeader( "Accept-Encoding", "gzip,deflate")
	
	loo_xmlhttp.send(srequest)
	
	//Get our response
	ll_status_code =  loo_xmlhttp.Status
	
	//Check HTTP Response code for errors
	if ll_status_code >= 300 then
		ls_response_text=""
	else
		ls_response_text = loo_xmlhttp.ResponseText
		If isnull(ls_response_text) Then ls_response_text=""
	end if
	
	//Done so cleanup
	loo_xmlhttp.DisconnectObject()

catch (RuntimeError rte)

  sErreur =  "RuntimeError - " + rte.getMessage()
  bRet=false  

End try

if ls_response_text="" Then 
	sErreur = "Pas de r$$HEX1$$e900$$ENDHEX$$ponse"
	bRet = False
Else
	uoResult=uf_parsejsonresult(ls_response_text)
End if

if not bRet Then 
	f_trace_web_service("PM506 - Lutte Anti Blanchiment", "CHECKRISK(PUT)-" + sUrl,Dec(uf_get_data( "id_sin")) , integer(ll_status_code), sErreur,srequest)
	f_trace_web_service("PM506 - Lutte Anti Blanchiment - reponse","CHECKRISK(PUT)-" + sUrl, Dec(uf_get_data( "id_sin")), integer(ll_status_code), sErreur,ls_response_text)
End if


Return bRet
end function

on n_cst_sp_ws_lutte_anti_blanch_caller.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_sp_ws_lutte_anti_blanch_caller.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;

SetNull(istDatas)


end event

