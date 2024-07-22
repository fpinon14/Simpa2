HA$PBExportHeader$n_cst_sp_ws_chronopost_caller.sru
$PBExportComments$[PM200-5]
forward
global type n_cst_sp_ws_chronopost_caller from n_cst_sp_ws_caller
end type
end forward

global type n_cst_sp_ws_chronopost_caller from n_cst_sp_ws_caller
end type
global n_cst_sp_ws_chronopost_caller n_cst_sp_ws_chronopost_caller

type variables
String isAccountNumber
String isPassword
String isUrlWebservice

String isErrorCode
String isErrorMessage
end variables

forward prototypes
public function integer createproxy (soapconnection asoapcnx)
public function integer uf_parse (oleobject asxmldoc, ref chrono_pointchr aslistepoints[])
public function long uf_get_pointrelais (string asadresse, string ascodepostal, string asville, ref chrono_pointchr aslistepoints[])
public function integer uf_get_pointrelai (string asidentifiant, ref chrono_pointchr aopointrelai)
public function integer uf_parse (oleobject asxmldoc, ref chrono_pointchr aopointrelai)
public function string uf_getlasterrorcode ()
public function string uf_getlasterrormessage ()
private function boolean uf_is_node_valid (ref oleobject xmlnode)
end prototypes

public function integer createproxy (soapconnection asoapcnx);Return 1
end function

public function integer uf_parse (oleobject asxmldoc, ref chrono_pointchr aslistepoints[]);OleObject xmlNode, xmlChildNode
Long lIndex
chrono_pointchr pointRelai

xmlNode=asXmlDoc.getElementsByTagName("errorCode")
if not isValid(xmlNode) Then Return -1

isErrorcode=xmlNode.Item(0).Text

xmlNode=asXmlDoc.getElementsByTagName("errorMessage")
if isValid(xmlNode) Then 
	isErrorMessage=xmlNode.Item(0).Text
End if

If isErrorcode <> "0" Then return -1

xmlNode=asXmlDoc.getElementsByTagName("listePointRelais")

If isValid(xmlNode) Then
	For lIndex=0 to  xmlNode.length - 1
		pointRelai=CREATE chrono_pointchr
		xmlChildNode=xmlNode.item(lIndex)
		pointRelai.uf_parseRelai(xmlChildNode) 
		asListePoints[lIndex + 1]=pointRelai
	Next
End if

Return 1

end function

public function long uf_get_pointrelais (string asadresse, string ascodepostal, string asville, ref chrono_pointchr aslistepoints[]);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_get_pointrelai (PRIVATE)
//* Auteur			: FPI
//* Date				: 17/04/2014
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PM255-1]
//*
//* Arguments		: Aucun
//*
//* Retourne		: 1 si OK, -1 si erreur du webService, -2 si pas de r$$HEX1$$e900$$ENDHEX$$ponse, 
//						  -3 si XML en retour non conforme, -4 si le webservice ne r$$HEX1$$e900$$ENDHEX$$pond pas
//*
//*-----------------------------------------------------------------
// 	FPI	29/04/2016 - [TRACE_WEB_SERVICE]
//*-----------------------------------------------------------------
String ls_post_variables, ls_response
String ls_response_text
long   ll_status_code
Integer iRet
OleObject loo_xmlhttp
n_cst_crypter_base64 nvBase64
String sJourSuivant
Decimal dcNull

SetNull(dcNull)

OleObject loo_xmlresponse
ls_response_text=""

sJourSuivant=String(RelativeDate(Today(), 1) , "dd/mm/yyyy")

iRet=1

try
	//Create an instance of our COM object
	loo_xmlhttp = CREATE oleobject
	loo_xmlhttp.ConnectToNewObject("Msxml2.XMLHTTP.6.0")
	
	ls_post_variables =   "<soapenv:Envelope xmlns:soapenv=~"http://schemas.xmlsoap.org/soap/envelope/~" xmlns:cxf=~"http://cxf.rechercheBt.soap.chronopost.fr/~">~n"
	ls_post_variables += "  <soapenv:Header/>~n"
	ls_post_variables += "  <soapenv:Body>~n"
	ls_post_variables += "    <cxf:recherchePointChronopost>~n"
	ls_post_variables += "      <accountNumber>" + isAccountNumber + "</accountNumber>~n"
	ls_post_variables += "      <password>" + isPassword + "</password>~n"
	ls_post_variables += "      <address>" + asadresse + "</address>~n"
	ls_post_variables += "      <zipCode>" + ascodepostal + "</zipCode>~n"
	ls_post_variables += "      <city>" + asville + "</city>~n"
	ls_post_variables += "      <countryCode>FR</countryCode>~n"
	ls_post_variables += "      <type>P</type>~n"
	ls_post_variables += "      <service>T</service>~n"
	ls_post_variables += "      <weight>1000</weight>~n"
	ls_post_variables += "      <shippingDate>" + sJourSuivant + "</shippingDate> ~n"
	ls_post_variables += "      <maxPointChronopost>3</maxPointChronopost>~n"
	ls_post_variables += "      <maxDistanceSearch>40</maxDistanceSearch>~n" // [PM255-1] - Mantis 14637
	ls_post_variables += "      <holidayTolerant>1</holidayTolerant>~n"
	ls_post_variables += "  </cxf:recherchePointChronopost>~n"
	ls_post_variables += "  </soapenv:Body>~n"
	ls_post_variables += "</soapenv:Envelope>~n"
	
	loo_xmlhttp.open ("POST",isUrlWebservice, false)
	
	loo_xmlhttp.setRequestHeader("SOAPAction","")  
	loo_xmlhttp.setRequestHeader("Content-Type", "text/xml")
	
	loo_xmlhttp.send(ls_post_variables)
	
	//Get our response
	ll_status_code =  loo_xmlhttp.Status
	
	//Check HTTP Response code for errors
	if ll_status_code >= 300 then
		iRet=-1
		isErrorcode=String(ll_status_code)
		isErrorMessage="Error Appel WS"
	else
		loo_xmlresponse = loo_xmlhttp.ResponseXml
	end if
	
	//Done so cleanup
	loo_xmlhttp.DisconnectObject()

catch (RuntimeError rte)

	iRet=-4
	 isErrorcode=String(rte.Number)
	 isErrorMessage="RuntimeError : " + rte.Text

end try

// Traitement du retour
if iRet=1 And isValid(loo_xmlresponse) Then
	iRet=uf_parse(loo_xmlresponse,aslistepoints)
	if iRet < 1 Then iRet=-3
Else
	SetNull(aslistepoints)
	iRet=-2
End if

// [TRACE_WEB_SERVICE]
If iRet=-3 or iRet=-2 Then
	isErrorcode=String(iRet)
	isErrorMessage="Erreur de Parsing"
End if

if iRet < 0 Then 
	f_trace_web_service("Chronopost",isUrlWebservice, dcNull, integer(isErrorcode), isErrorMessage,ls_post_variables)
End if

Return iRet

end function

public function integer uf_get_pointrelai (string asidentifiant, ref chrono_pointchr aopointrelai);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_get_pointrelai (PRIVATE)
//* Auteur			: FPI
//* Date				: 17/04/2014
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PM255-1]
//*
//* Arguments		: Aucun
//*
//* Retourne		: 1 si OK, -1 si erreur du webService, -2 si pas de r$$HEX1$$e900$$ENDHEX$$ponse, 
//						  -3 si XML en retour non conforme, -4 si le webservice ne r$$HEX1$$e900$$ENDHEX$$pond pas
//*
//*-----------------------------------------------------------------
// 	FPI	29/04/2016 - [TRACE_WEB_SERVICE]
//*-----------------------------------------------------------------

String ls_post_variables, ls_response
String ls_response_text
long   ll_status_code
Integer iRet
OleObject loo_xmlhttp
chrono_pointchr result
Decimal dcNull

OleObject loo_xmlresponse
ls_response_text=""

iRet=1
SetNull(dcNull)

try
	//Create an instance of our COM object
	loo_xmlhttp = CREATE oleobject
	loo_xmlhttp.ConnectToNewObject("Msxml2.XMLHTTP.6.0")
	
	ls_post_variables =   "<soapenv:Envelope xmlns:soapenv=~"http://schemas.xmlsoap.org/soap/envelope/~" xmlns:cxf=~"http://cxf.rechercheBt.soap.chronopost.fr/~">~n"
	ls_post_variables += "  <soapenv:Header/>~n"
	ls_post_variables += "  <soapenv:Body>~n"
	ls_post_variables += "    <cxf:rechercheDetailPointChronopost>~n"
	ls_post_variables += "      <accountNumber>" + isAccountNumber + "</accountNumber>~n"
	ls_post_variables += "      <password>" + isPassword + "</password>~n"
	ls_post_variables += "      <identifiant>" + asidentifiant + "</identifiant>~n"
	ls_post_variables += "  </cxf:rechercheDetailPointChronopost>~n"
	ls_post_variables += "  </soapenv:Body>~n"
	ls_post_variables += "</soapenv:Envelope>~n"
	
	loo_xmlhttp.open ("POST",isUrlWebservice, false)
	
	loo_xmlhttp.setRequestHeader("SOAPAction","")  
	loo_xmlhttp.setRequestHeader("Content-Type", "text/xml")
	
	loo_xmlhttp.send(ls_post_variables)
	
	//Get our response
	ll_status_code =  loo_xmlhttp.Status
	
	//Check HTTP Response code for errors
	if ll_status_code >= 300 then
		iRet=-1
		isErrorcode=String(ll_status_code)
		isErrorMessage="Error Appel WS"
	else
		loo_xmlresponse = loo_xmlhttp.ResponseXml
	end if
	
	//Done so cleanup
	loo_xmlhttp.DisconnectObject()

catch (RuntimeError rte)

  iRet=-4
  isErrorcode=String(rte.Number)
  isErrorMessage="RuntimeError : " + rte.Text

end try

// Traitement du retour
if iRet=1 And isValid(loo_xmlresponse) Then
	iRet=uf_parse(loo_xmlresponse,aoPointRelai)
	if iRet < 1 Then iRet=-3
Else
	SetNull(aoPointRelai)
	If iRet=1 Then iRet=-2
End if

// [TRACE_WEB_SERVICE]
If iRet=-3 or iRet=-2 Then
	isErrorcode=String(iRet)
	isErrorMessage="Erreur de Parsing"
End if

if iRet < 0 Then 
	f_trace_web_service("Chronopost",isUrlWebservice, dcNull, integer(isErrorcode), isErrorMessage,ls_post_variables)
End if

Return iRet

end function

public function integer uf_parse (oleobject asxmldoc, ref chrono_pointchr aopointrelai);OleObject xmlNode, xmlChildNode
Long lIndex

xmlNode=asXmlDoc.getElementsByTagName("errorCode")
if not uf_is_node_valid(xmlNode) Then Return -1

isErrorcode=xmlNode.Item(0).Text

xmlNode=asXmlDoc.getElementsByTagName("errorMessage")
if uf_is_node_valid(xmlNode) Then 
	isErrorMessage=xmlNode.Item(0).Text
End if

If isErrorcode <> "0" Then return -1

xmlNode=asXmlDoc.getElementsByTagName("listePointRelais")

If isValid(xmlNode) Then
	aoPointRelai=CREATE chrono_pointchr
	If uf_is_node_valid(xmlNode) Then 
		xmlChildNode=xmlNode.item(0)
		aoPointRelai.uf_parseRelai(xmlChildNode) 
	End if
End if

Return 1

end function

public function string uf_getlasterrorcode ();Return isErrorcode
end function

public function string uf_getlasterrormessage ();Return isErrormessage
end function

private function boolean uf_is_node_valid (ref oleobject xmlnode);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_is_node_valid (PRIVATE)
//* Auteur			: FPI
//* Date				: 03/02/2015
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: true si le noeud XML est valide
//*
//*-----------------------------------------------------------------

If Not isValid(xmlnode) Then return false
If xmlNode.Length = 0 Then return false

Return True
end function

on n_cst_sp_ws_chronopost_caller.create
call super::create
end on

on n_cst_sp_ws_chronopost_caller.destroy
call super::destroy
end on

event constructor;call super::constructor;isAccountNumber=ProfileString(stglb.sfichierini,"CHRONOPOST","ACCOUNTNUMBER","")
isPassword=ProfileString(stglb.sfichierini,"CHRONOPOST","PASSWORD","")
isUrlWebservice= ProfileString(stglb.sfichierini,"CHRONOPOST","URL_WEBSERVICE_CHRONOPOST","")


end event

