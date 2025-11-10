HA$PBExportHeader$n_cst_sp_ws_btqpsm_caller.sru
$PBExportComments$[PM257-1]
forward
global type n_cst_sp_ws_btqpsm_caller from n_cst_sp_ws_caller
end type
end forward

global type n_cst_sp_ws_btqpsm_caller from n_cst_sp_ws_caller
end type
global n_cst_sp_ws_btqpsm_caller n_cst_sp_ws_btqpsm_caller

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
public function long uf_get_boutiques_centralisation (string asaction, long alcodeproduit, string ascodepostal, string asmarque, string asmodele, string asidsin, string astypart, ref psm_psmdataresponse aoresult)
public function long uf_get_boutiques_proximite (string asaction, long alcodeproduit, string ascodepostal, string asmarque, string asmodele, string asidsin, string astypart, ref psm_psmdataresponse aoresult)
public function long uf_get_boutiques_proximites (string asaction, long alcodeproduit, string ascodepostal, string asmarque, string asmodele, string asidsin, string astypart, ref string sresult)
public subroutine uf_check_boutique_psm (psm_psmdataresponse ureponse, integer adcidprod)
public subroutine uf_trace_btq_fermee (string asidsin, psm_psmdataresponse aoreponse, string asrequest, string asresponse)
end prototypes

public function integer createproxy (soapconnection asoapcnx);long lRet
String endpointUrl
String userId, password
n_cst_string nvString 

try
	endpointURL= ProfileString(stglb.sfichierini,"PSM","URL_WEBSERVICE_PSM","")

	userId= ProfileString(stglb.sfichierini,"PSM","USERNAME","")
	password= ProfileString(stglb.sfichierini,"PSM","PASSWORD","")
	
	aSoapcnx.SetOptions("UserID='" + userId + "', Password='" + password + "'")
//	endPointURL=nvString.of_globalreplace( endpointUrl, "http://", "http://" + userId + ":" + password + "@")
	

//	lret = aSoapcnx.CreateInstance(iProxy, 	"psm_shopwsport", endpointURL)
	/*
	lret = aSoapcnx.CreateInstance(iProxy, 	"psm2_shopws", endpointURL)
	*/
	If lRet=0 Then lRet=1 Else lRet=-1

catch (RuntimeError re)

	lRet=-1

End try
 
return lRet

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

public function long uf_get_boutiques_centralisation (string asaction, long alcodeproduit, string ascodepostal, string asmarque, string asmodele, string asidsin, string astypart, ref psm_psmdataresponse aoresult);// 14/01/2016 - FPI - [VDOC19646]

String ls_post_url, ls_user, ls_passwd, ls_Auth
String ls_post_variables, ls_response
String ls_response_text
long   ll_status_code
Integer iRet
OleObject loo_xmlhttp
n_cst_crypter_base64 nvBase64

ls_response_text=""

ls_post_url=ProfileString(stGlb.sfichierini ,"PSM","URL_WEBSERVICE_PSM","*")
ls_user=ProfileString(stGlb.sfichierini ,"PSM","USERNAME","*")
ls_passwd=ProfileString(stGlb.sfichierini ,"PSM","PASSWORD","*")

iRet=1

nvBase64=CREATE n_cst_crypter_base64

ls_Auth=ls_user + ":" + ls_passwd
ls_Auth=of_encode64( ls_Auth)

try
	//Create an instance of our COM object
	loo_xmlhttp = CREATE oleobject
	loo_xmlhttp.ConnectToNewObject("Msxml2.XMLHTTP.6.0")
	
	ls_post_variables =   "<soapenv:Envelope xmlns:soapenv=~"http://schemas.xmlsoap.org/soap/envelope/~" xmlns:v2=~"http://v2.webservice.web.psm.com/~">~n"
	ls_post_variables += "  <soapenv:Header/>~n"
	ls_post_variables += "  <soapenv:Body>~n"
	ls_post_variables += "    <v2:getPSMCentralisationWithInformationV2>~n" // [VDOC19646]

	ls_post_variables += "      <arg0>~n"
	ls_post_variables += "        <ACTION>"+ asAction +"</ACTION>~n"
	ls_post_variables += "        <CODE_PROD>" + String(alcodeproduit) + "</CODE_PROD>~n"
	ls_post_variables += "        <MARQUE>"+ asmarque +"</MARQUE>~n"
	ls_post_variables += "        <MODELE>"+ asmodele +"</MODELE>~n"
	ls_post_variables += "        <TYPE_ART>"+ astypart +"</TYPE_ART>~n"
	ls_post_variables += "        <CP>"+ ascodepostal + "</CP>~n"
	ls_post_variables += "        <NUMERO_DOSSIER>" + asIdSin + "</NUMERO_DOSSIER>~n"
	ls_post_variables += "      </arg0>~n"
	
	ls_post_variables += "    </v2:getPSMCentralisationWithInformationV2>~n"

	ls_post_variables += "  </soapenv:Body>~n"
	ls_post_variables += "</soapenv:Envelope>~n"
	
	loo_xmlhttp.open ("POST",ls_post_url, false)
	
	loo_xmlhttp.setRequestHeader("SOAPAction","")  
	loo_xmlhttp.setRequestHeader("Content-Type", "text/xml")
	
	loo_xmlhttp.setRequestHeader("Authorization", "Basic " + ls_Auth)
		
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

  if stGlb.sCodOper="FPI" Then MessageBox("Error", "RuntimeError - " + rte.getMessage()) 

end try

// Traitement du retour
if ls_response_text<>"" Then 
	aoResult=CREATE psm_psmdataresponse 
	aoResult.uf_fillfromxml(ls_response_text)
	
	// [ITSM216013]
		if isnull(aoResult.centralisation) Then
			iRet=-3
		Else
			if Trim(aoResult.centralisation)="" Then iRet=-3
		End if
	// :[ITSM216013]
Else
	SetNull(aoResult)
	if iRet > 0 Then iRet=-2 // FPI - 01/09/2016
End if

// [TRACE_WEB_SERVICE]
If iRet=-3 or iRet=-2 Then
	isSoapError=string(ll_status_code) + " - Erreur de Parsing"
	
End if

if iRet < 0 Then 
	If isnull(ls_response_text) Then ls_response_text=""
	f_trace_web_service("PSM - centralisation",ls_post_url, dec(asidsin), integer(iRet), isSoapError,ls_post_variables)
	f_trace_web_service("PSM - centralisation - reponse",ls_post_url, dec(asidsin), integer(iRet), isSoapError,ls_response_text)
else
	uf_trace_btq_fermee( asidsin, aoResult, ls_post_variables, ls_response_text) // [PSM_FERME]
End if

Return iRet

end function

public function long uf_get_boutiques_proximite (string asaction, long alcodeproduit, string ascodepostal, string asmarque, string asmodele, string asidsin, string astypart, ref psm_psmdataresponse aoresult);String ls_post_url, ls_user, ls_passwd, ls_Auth
String ls_post_variables, ls_response
String ls_response_text
long   ll_status_code
Integer iRet
OleObject loo_xmlhttp
n_cst_crypter_base64 nvBase64
OleObject loo_xmlresponse

ls_post_url=ProfileString(stGlb.sfichierini ,"PSM","URL_WEBSERVICE_PSM","*")
ls_user=ProfileString(stGlb.sfichierini ,"PSM","USERNAME","*")
ls_passwd=ProfileString(stGlb.sfichierini ,"PSM","PASSWORD","*")

iRet=1

nvBase64=CREATE n_cst_crypter_base64

ls_Auth=ls_user + ":" + ls_passwd
ls_Auth=of_encode64( ls_Auth)

try
	//Create an instance of our COM object
	loo_xmlhttp = CREATE oleobject
	loo_xmlhttp.ConnectToNewObject("Msxml2.XMLHTTP.6.0")
	
	ls_post_variables =   "<soapenv:Envelope xmlns:soapenv=~"http://schemas.xmlsoap.org/soap/envelope/~" xmlns:v2=~"http://v2.webservice.web.psm.com/~">~n"
	ls_post_variables += "  <soapenv:Header/>~n"
	ls_post_variables += "  <soapenv:Body>~n"
	ls_post_variables += "    <v2:getPSMCentralisationWithInformationV2>~n" // [VDOC19646]
	
	ls_post_variables += "      <arg0>~n"
	ls_post_variables += "        <ACTION>"+ asAction +"</ACTION>~n"
	ls_post_variables += "        <CODE_PROD>" + String(alcodeproduit) + "</CODE_PROD>~n"
	ls_post_variables += "        <MARQUE>"+ asmarque +"</MARQUE>~n"
	ls_post_variables += "        <MODELE>"+ asmodele +"</MODELE>~n"
	ls_post_variables += "        <TYPE_ART>"+ astypart +"</TYPE_ART>~n"
	ls_post_variables += "        <CP>"+ ascodepostal + "</CP>~n"
	ls_post_variables += "        <NUMERO_DOSSIER>" + asIdSin + "</NUMERO_DOSSIER>~n"
	ls_post_variables += "      </arg0>~n"
	
	ls_post_variables += "    </v2:getPSMCentralisationWithInformationV2>~n"
	
	ls_post_variables += "  </soapenv:Body>~n"
	ls_post_variables += "</soapenv:Envelope>~n"
	
	loo_xmlhttp.open ("POST",ls_post_url, false)
	
	loo_xmlhttp.setRequestHeader("SOAPAction","")  
	loo_xmlhttp.setRequestHeader("Content-Type", "text/xml")
	
	loo_xmlhttp.setRequestHeader("Authorization", "Basic " + ls_Auth)
		
	loo_xmlhttp.send(ls_post_variables)
	
	//Get our response
	ll_status_code =  loo_xmlhttp.Status
	
	//Check HTTP Response code for errors
	if ll_status_code >= 300 then
		iRet=-1
	else
		ls_response_text=loo_xmlhttp.ResponseText
		loo_xmlresponse = loo_xmlhttp.ResponseXml
	end if
	
	//Done so cleanup
	loo_xmlhttp.DisconnectObject()

catch (RuntimeError rte)

    if stGlb.sCodOper="FPI" Then MessageBox("Error", "RuntimeError - " + rte.getMessage()) 

end try


// Traitement du retour
if iRet=1 And isValid(loo_xmlresponse) Then
	aoResult=CREATE psm_psmdataresponse 
	//iRet=aoResult.uf_parse(loo_xmlresponse)
	aoResult.uf_fillfromxml(ls_response_text)
//	if iRet < 1 Then iRet=-3
Else
	SetNull(aoresult)
	iRet=-2
End if

// [TRACE_WEB_SERVICE]
If iRet=-2 Then
	isSoapError=string(ll_status_code) + " - Erreur de Parsing"
End if

if iRet < 0 Then 
	f_trace_web_service("PSM - proximit$$HEX1$$e900$$ENDHEX$$",ls_post_url, dec(asidsin), integer(iRet), isSoapError,ls_post_variables)
else
	uf_trace_btq_fermee( asidsin, aoResult, ls_post_variables, ls_response_text) // [PSM_FERME]
End if

Return iRet


end function

public function long uf_get_boutiques_proximites (string asaction, long alcodeproduit, string ascodepostal, string asmarque, string asmodele, string asidsin, string astypart, ref string sresult);//			FPI		08/12/2017	[VDoc25239]

Integer iRet
psm_psmdataresponse oresult
sResult=""
iRet=1

iRet=uf_get_boutiques_proximite( asaction, alcodeproduit, ascodepostal, asmarque, asmodele, asidsin,astypart, oResult )

if iRet=1 Then sResult=oresult.uf_getproximites( )

if iRet=1 Then
	uf_check_boutique_psm( oresult, alCodeProduit ) // [VDoc25239]
End if

Return iRet


end function

public subroutine uf_check_boutique_psm (psm_psmdataresponse ureponse, integer adcidprod);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_w_commande3::uf_check_boutique_psm
//* Auteur			: F. Pinon
//* Date				: 01/12/2017
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [VDoc25239]
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

int i
long dcidprod
string  sadrmail, sadrnom, sadr1, sadr2, sadrville, sadrcp, sAdrTel, sCodMag
n_cst_string nvstring

// Pas d'infos, on sort
if UpperBound(uReponse.shopInfos) = 0 Then return

For i=1 To UpperBound(uReponse.shopInfos) 
	
	sadrmail = Space (128) 
	sadrnom= Space (35)
	sadr1= Space (40)
	sadr2= Space (40)
	sadrville= Space (35)
	sadrcp= Space (5)
	sAdrTel=Space(20)
	
	uReponse.shopInfos[i].uf_transforme_en_boutique_simpa2()
	
	sCodMag=uReponse.shopInfos[i].shopid
	
	sCodMag=string(long(sCodMag))
	
	SQLCA.PS_S_BOUTIQUE_ADRESSE_4(adcIdProd, "PSM", sCodMag, sadrmail, sadrnom, sadr1, sadr2, sadrville, sadrcp, sAdrTel) 
	
	if Trim(sAdrCp) ="" Then
		
		string sVal
		
		sVal="exec sysadm.PS_I03_BOUTIQUE '" + sCodMag + "','" + uReponse.shopInfos[i].shopName + "','" +  uReponse.shopInfos[i].address1 + "','" +  uReponse.shopInfos[i].address2 + "','" +  	&	
			uReponse.shopInfos[i].zipCode + "','" +  uReponse.shopInfos[i].city + "','" + "" + "','" + uReponse.shopInfos[i].email + "','" +  stGlb.sCodOper
		// Cr$$HEX1$$e900$$ENDHEX$$ation
		SQLCA.PS_I03_BOUTIQUE(sCodMag, uReponse.shopInfos[i].shopName, uReponse.shopInfos[i].address1, uReponse.shopInfos[i].address2, 	&	
			uReponse.shopInfos[i].zipCode, uReponse.shopInfos[i].city,"",uReponse.shopInfos[i].email, stGlb.sCodOper)
			
		f_commit(SQLCA,true)
	
	Else
		if sadr1 <> uReponse.shopInfos[i].address1 or &
			sadr2 <> uReponse.shopInfos[i].address2 or &
			sadrville <> uReponse.shopInfos[i].city or &
			sadrcp <> uReponse.shopInfos[i].zipCode or &
			sadrmail <> uReponse.shopInfos[i].email or &
			sadrnom <> uReponse.shopInfos[i].shopName Then
			// Mise $$HEX2$$e0002000$$ENDHEX$$jour
			SQLCA.PS_I03_BOUTIQUE(sCodMag, uReponse.shopInfos[i].shopName, uReponse.shopInfos[i].address1, uReponse.shopInfos[i].address2, 	&	
			uReponse.shopInfos[i].zipCode, uReponse.shopInfos[i].city,"",uReponse.shopInfos[i].email, stGlb.sCodOper)
	
			f_commit(SQLCA,true)
		End if
		
	End if
			
Next
end subroutine

public subroutine uf_trace_btq_fermee (string asidsin, psm_psmdataresponse aoreponse, string asrequest, string asresponse);// [PSM_FERME]
String sSql
n_cst_string nvString

return // Cette fonction n'a plus d'utilit$$HEX1$$e900$$ENDHEX$$, JFF, le 08/11/18.

asrequest=nvString.of_globalreplace(asrequest,"~n","")

if not isnull(aoreponse.centralisation) Then
	if aoreponse.centralisation <> "" Then
		
		SQLCA.PS_I_CTL_BOUTIQUE_PSM(  dec(asIdSin), aoreponse.centralisation, stgLb.sCodOper, asRequest, asResponse)
	End if
End if

if not isnull(aoreponse.proximity1) Then
	if aoreponse.proximity1 <> "" Then
		
		SQLCA.PS_I_CTL_BOUTIQUE_PSM(  dec(asIdSin), aoreponse.proximity1, stgLb.sCodOper, asRequest, asResponse)

	End if
End if

if not isnull(aoreponse.proximity2) Then
	if aoreponse.proximity2 <> "" Then
		
		SQLCA.PS_I_CTL_BOUTIQUE_PSM(  dec(asIdSin), aoreponse.proximity2, stgLb.sCodOper, asRequest, asResponse)
		
	End if
End if
end subroutine

on n_cst_sp_ws_btqpsm_caller.create
call super::create
end on

on n_cst_sp_ws_btqpsm_caller.destroy
call super::destroy
end on

