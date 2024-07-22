HA$PBExportHeader$n_cst_sp_ws_cordon_caller.sru
$PBExportComments$[DT288-1]
forward
global type n_cst_sp_ws_cordon_caller from n_cst_sp_ws_caller
end type
end forward

global type n_cst_sp_ws_cordon_caller from n_cst_sp_ws_caller
end type
global n_cst_sp_ws_cordon_caller n_cst_sp_ws_cordon_caller

type prototypes
Function boolean CryptBinaryToString ( &
	Blob pbBinary, &
	ulong cbBinary, &
	ulong dwFlags, &
	Ref string pszString, &
	Ref ulong pcchString &
	) Library "crypt32.dll" Alias For "CryptBinaryToStringW"
end prototypes

type variables
//psm_shopwsport iProxy

Constant ULong CRYPT_STRING_BASE64	= 1
//psm2_shopws iProxy
end variables

forward prototypes
public function integer createproxy (soapconnection asoapcnx)
public function string of_encode64 (string aschaine)
public function integer uf_is_geolocalise (string asnumimei, decimal adcidsin)
public function long uf_get_infos (string asimei, string asnum_serie, ref cordon_inforesponse aoresult, decimal adcidsin)
end prototypes

public function integer createproxy (soapconnection asoapcnx);String endpointUrl

endpointURL= ProfileString(stglb.sfichierini,"PSM","URL_WEBSERVICE_CORDON","")

if endpointUrl="" Then return -1
 
return 1

end function

public function string of_encode64 (string aschaine);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_Encode64
//
// PURPOSE:    This function converts binary data to a Base64 encoded string.
//
//					Note: Requires Windows XP or Server 2003
//
// ARGUMENTS:  ablob_data - Blob containing data
//
// RETURN:     String containing encoded data
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/18/2011	RolandS		Initial Coding
// -----------------------------------------------------------------------------

String ls_encoded
ULong lul_len, lul_buflen
Boolean lb_rtn
Blob ablob_data
n_cst_string nvstring

ablob_data=Blob(asChaine,EncodingUTF8!)

lul_len = Len(ablob_data)

lul_buflen = lul_len * 2

ls_encoded = Space(lul_buflen)

lb_rtn = CryptBinaryToString(ablob_data, &
				lul_len, CRYPT_STRING_BASE64, &
				ls_encoded, lul_buflen)

If lb_rtn Then
	ls_encoded = nvstring.of_globalreplace( ls_encoded, "~r~n", "")
Else
	ls_encoded = ""
End If

Return ls_encoded

end function

public function integer uf_is_geolocalise (string asnumimei, decimal adcidsin);// 0 d$$HEX1$$e900$$ENDHEX$$g$$HEX1$$e900$$ENDHEX$$olocalis$$HEX1$$e900$$ENDHEX$$, 1 g$$HEX1$$e900$$ENDHEX$$olocalis$$HEX1$$e900$$ENDHEX$$
// -1 impossible de r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer les infos
// - 2 erreur de WebService
integer iResult
cordon_inforesponse nResult

iResult=-2

If uf_get_infos(asNumImei, "", nResult, adcIdSin) = 1 Then
	if nResult.is_ok <> "Y" Then Return -1
	
	If nResult.ib_isfmip Then Return 1
	
	Return 0
End if

Return iResult
end function

public function long uf_get_infos (string asimei, string asnum_serie, ref cordon_inforesponse aoresult, decimal adcidsin);String ls_post_url, ls_user, ls_passwd, ls_Auth
String ls_post_variables, ls_response
String ls_response_text
long   ll_status_code
Integer iRet
OleObject loo_xmlhttp
n_cst_crypter_base64 nvBase64

ls_response_text=""

ls_post_url= ProfileString(stglb.sfichierini,"CORDON","URL_WEBSERVICE_CORDON","")
ls_auth= ProfileString(stglb.sfichierini,"CORDON","AUTHKEY_WEBSERVICE_CORDON", &
	"09425f486195d1ed86b830fec53069931524a8befc1339afd3ee5e6b7b0f7941484277d6d7fc3c9105c3746169004feb920cac5b906f212b384ef2900dd9e2db")
	
iRet=1

try
	//Create an instance of our COM object
	loo_xmlhttp = CREATE oleobject
	loo_xmlhttp.ConnectToNewObject("Msxml2.XMLHTTP.6.0")
	
	ls_post_variables =   "<soapenv:Envelope xmlns:xsi=~"http://www.w3.org/2001/XMLSchema-instance~" xmlns:xsd=~"http://www.w3.org/2001/XMLSchema~" "
	ls_post_variables += "xmlns:soapenv=~"http://schemas.xmlsoap.org/soap/envelope/~" xmlns:web=~"https://sav.cordongroup.com/fr/webservice_gsx~">~n"
	ls_post_variables += "  <soapenv:Header/>~n"
	ls_post_variables += "  <soapenv:Body>~n"

	ls_post_variables += "      <web:getInfos soapenv:encodingStyle=~"http://schemas.xmlsoap.org/soap/encoding/~">~n"
	ls_post_variables += "         <imei xsi:type=~"xsd:string~">" + asimei + "</imei>~n"
	ls_post_variables += "         <numero_serie xsi:type=~"xsd:string~">" + asnum_serie + "</numero_serie>~n"
	ls_post_variables += "      </web:getInfos>~n"

	ls_post_variables += "  </soapenv:Body>~n"
	ls_post_variables += "</soapenv:Envelope>~n"
	
	loo_xmlhttp.open ("POST",ls_post_url, false)
	
	loo_xmlhttp.setRequestHeader("SOAPAction","")  
	loo_xmlhttp.setRequestHeader("Content-Type", "text/xml")
	
	loo_xmlhttp.setRequestHeader("Auth-Key", ls_Auth)
		
	loo_xmlhttp.send(ls_post_variables)
	
	//Get our response
	ll_status_code =  loo_xmlhttp.Status
	
	//Check HTTP Response code for errors
	if ll_status_code >= 300 then
		iRet=-1
		isSoapError=String(loo_xmlhttp.Status) 
		if isValid(loo_xmlhttp.statusText) And (not isnull(loo_xmlhttp.statusText)) Then 
			isSoapError+= " - " + loo_xmlhttp.statusText
		End if
	else
		ls_response_text = loo_xmlhttp.ResponseText
	end if
	
	//Done so cleanup
	loo_xmlhttp.DisconnectObject()

catch (RuntimeError rte)

  //MessageBox("Error", "RuntimeError - " + rte.getMessage()) 
  iRet=-10
  isSoapError=rte.getMessage()

end try

// Traitement du retour
if ls_response_text<>"" Then 
	aoResult=CREATE cordon_inforesponse
	aoResult.uf_fillfromxml(ls_response_text)
	
/*	if isnull(aoResult.is_ok) Then
		iRet=-3
	Else
		if Trim(aoResult.is_ok)="N" Then iRet=-3
	End if*/
Else
	SetNull(aoResult)
	if iRet > 0 Then iRet=-2 
End if

// [TRACE_WEB_SERVICE]
If iRet=-3 or iRet=-2 Then
	isSoapError=string(ll_status_code) + " - Erreur de Parsing"
	
End if

if iRet < 0 Then 
	If isnull(ls_response_text) Then ls_response_text=""
	f_trace_web_service("Cordon - getInfos",ls_post_url,adcIdSin, integer(iRet), isSoapError,ls_post_variables)
	f_trace_web_service("Cordon - getInfos - reponse",ls_post_url, adcIdSin, integer(iRet), isSoapError,ls_response_text)
End if

Return iRet

end function

on n_cst_sp_ws_cordon_caller.create
call super::create
end on

on n_cst_sp_ws_cordon_caller.destroy
call super::destroy
end on

