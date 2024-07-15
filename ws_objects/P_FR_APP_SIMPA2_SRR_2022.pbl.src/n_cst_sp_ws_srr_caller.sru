HA$PBExportHeader$n_cst_sp_ws_srr_caller.sru
forward
global type n_cst_sp_ws_srr_caller from n_cst_sp_ws_caller
end type
end forward

global type n_cst_sp_ws_srr_caller from n_cst_sp_ws_caller
end type
global n_cst_sp_ws_srr_caller n_cst_sp_ws_srr_caller

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
srr_assuranceservice 	iProxy

Constant ULong CRYPT_STRING_BASE64	= 1

String isendpointURL
end variables

forward prototypes
public function integer createproxy (soapconnection asoapcnx)
public function integer uf_createorder_old (datawindow adwcommande, long alrow)
public function string of_encode64 (string aschaine)
public function integer uf_createorder (datawindow adwcommande, long alrow, ref srr_createorderresult aoresult)
public function integer uf_validateorder (datawindow adwcommande, long alrow, ref srr_validateorderresult aoresult)
end prototypes

public function integer createproxy (soapconnection asoapcnx);long lRet
String endpointURL
String user, password
n_cst_string nvString

Try
	isendpointURL= ProfileString(stglb.sfichierini,"SRR","URL_WEBSERVICE_SRR","")
	user=ProfileString(stglb.sfichierini,"SRR","USERNAME","")
	password=ProfileString(stglb.sfichierini,"SRR","PASSWORD","")
	
	endPointURL=nvString.of_globalreplace( isendpointURL, "http://", "http://" + user + ":" + password + "@")
	
	lret = aSoapcnx.CreateInstance(iProxy, 	"srr_assuranceservice", endpointURL)

	aSoapCnx.SetBasicAuthentication("",user,password)

	If lRet=0 Then lRet=1 Else lRet=-1

catch (RuntimeError re)

	lRet=-1

End try
 
return lRet

end function

public function integer uf_createorder_old (datawindow adwcommande, long alrow);long lRet=1

srr_destinataire uoDestinataire
srr_createorderitem tabItems[]

srr_createorderresult uoOutput // Objet de retour de la fonction 	du WebService

Try

	uoDestinataire = CREATE srr_destinataire
	tabItems[1] = CREATE srr_createorderitem
	
	// Remplissage de l$$HEX1$$1920$$ENDHEX$$objet en param$$HEX1$$e800$$ENDHEX$$tre

	// Destinataire
	uoDestinataire.nom=adwCommande.GetItemString(alRow,"ADR_NOM")
	uoDestinataire.prenom=adwCommande.GetItemString(alRow,"ADR_PRENOM")	
	
	uoDestinataire.adr1=adwCommande.GetItemString(alRow,"ADR_LIVR1")	
	uoDestinataire.adr2=adwCommande.GetItemString(alRow,"ADR_LIVR2")	
	uoDestinataire.adr3=adwCommande.GetItemString(alRow,"ADR_LIVR_CPL")	
	
	uoDestinataire.codepostal=adwCommande.GetItemString(alRow,"ADR_CP")	
	uoDestinataire.ville=adwCommande.GetItemString(alRow,"ADR_VILLE")	
	
	uoDestinataire.telephone=adwCommande.GetItemString(alRow,"ADR_TEL1")	
	
	// Item
	tabItems[1].codesap=adwCommande.GetItemString(alRow,"ID_REF_FOUR")
	tabItems[1].quantite=1
	
	// Appel de la fonction du WebService
	Try 
	uoOutput=iproxy.createorder( "123",uoDestinataire, tabItems)
	catch ( SoapException ex )
	finally
		uoOutput=iproxy.createorder( "123",uoDestinataire, tabItems)
	End try
	// Traitement sur l$$HEX1$$1920$$ENDHEX$$objet en retour	- TODO : $$HEX2$$e0002000$$ENDHEX$$revoir
	if uoOutput.returncode <> "OK" Then 
		lRet=-1
	Else
		adwCommande.SetItem(alRow,"ID_CMD_FRN",uoOutput.idcommande)
	End if
				
catch ( SoapException e )
	lRet = uf_gestionexception( e)
end try

If isValid(uoDestinataire) Then Destroy uoDestinataire
If isValid(uoOutput) Then Destroy uoOutput

Return lRet

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

public function integer uf_createorder (datawindow adwcommande, long alrow, ref srr_createorderresult aoresult);String ls_post_url, ls_user, ls_passwd, ls_Auth
String ls_post_variables, ls_response
String ls_response_text
long   ll_status_code
Integer iRet
OleObject loo_xmlhttp
n_cst_crypter_base64 nvBase64
String sIdCommandeSPB

ls_response_text=""

ls_post_url=ProfileString(stGlb.sfichierini ,"SRR","URL_WEBSERVICE_SRR","*")
ls_user=ProfileString(stGlb.sfichierini ,"SRR","USERNAME","*")
ls_passwd=ProfileString(stGlb.sfichierini ,"SRR","PASSWORD","*")

sIdCommandeSPB=String(adwCommande.GetItemDecimal(alRow,"ID_SIN")) + "-" + String(adwCommande.GetItemNumber(alRow,"ID_SEQ"))

iRet=1

nvBase64=CREATE n_cst_crypter_base64

ls_Auth=ls_user + ":" + ls_passwd
ls_Auth=of_encode64( ls_Auth)

try
	//Create an instance of our COM object
	loo_xmlhttp = CREATE oleobject
	loo_xmlhttp.ConnectToNewObject("Msxml2.XMLHTTP.6.0")
	
	ls_post_variables =   "<soapenv:Envelope xmlns:soapenv=~"http://schemas.xmlsoap.org/soap/envelope/~" xmlns:ass=~"http://sfr.re/sismo/assurance~">~n"
	ls_post_variables += "  <soapenv:Header/>~n"
	ls_post_variables += "  <soapenv:Body>~n"
	ls_post_variables += "    <ass:CreateOrder>~n"
	ls_post_variables += "      <ass:idExterne>" + sIdCommandeSPB + "</ass:idExterne>~n"
	ls_post_variables += "      <ass:destinataire>~n"
	ls_post_variables += "        <ass:Nom>" + f_getitem3(adwCommande, alRow,"ADR_NOM") + "</ass:Nom>~n"
	ls_post_variables += "        <ass:Prenom>" + f_getitem3(adwCommande, alRow, "ADR_PRENOM") + "</ass:Prenom>~n"
	ls_post_variables += "        <ass:Adr1>" + f_getitem3(adwCommande, alRow, "ADR_LIVR1") + "</ass:Adr1>~n"
	ls_post_variables += "        <ass:Adr2>" + f_getitem3(adwCommande, alRow, "ADR_LIVR2") + "</ass:Adr2>~n"
	ls_post_variables += "        <ass:Adr3>" + f_getitem3(adwCommande, alRow, "ADR_LIVR_CPL") + "</ass:Adr3>~n"
	ls_post_variables += "        <ass:CodePostal>" + f_getitem3(adwCommande, alRow, "ADR_CP") + "</ass:CodePostal>~n"
	ls_post_variables += "        <ass:Ville>" + f_getitem3(adwCommande, alRow, "ADR_VILLE") + "</ass:Ville>~n"
	ls_post_variables += "        <ass:Telephone>" + f_getitem3(adwCommande, alRow, "ADR_TEL1") + "</ass:Telephone>~n"
	ls_post_variables += "      </ass:destinataire>~n"
	ls_post_variables += "      <ass:items>~n"
	ls_post_variables += "        <ass:CreateOrderItem>~n"
	ls_post_variables += "          <ass:CodeSAP>" + f_getitem3(adwCommande, alRow, "ID_REF_FOUR") + "</ass:CodeSAP>~n"
	ls_post_variables += "          <ass:Quantite>1</ass:Quantite>~n"
	ls_post_variables += "        </ass:CreateOrderItem>~n"
	ls_post_variables += "      </ass:items>~n"
	ls_post_variables += "    </ass:CreateOrder>~n"
	ls_post_variables += "  </soapenv:Body>~n"
	ls_post_variables += "</soapenv:Envelope>~n"
	
	loo_xmlhttp.open ("POST",ls_post_url, false)
	
	loo_xmlhttp.setRequestHeader("SOAPAction","http://sfr.re/sismo/assurance/CreateOrder")  
	loo_xmlhttp.setRequestHeader("Content-Type", "text/xml")
	
	loo_xmlhttp.setRequestHeader("Authorization", "Basic " + ls_Auth)
		
	loo_xmlhttp.send(ls_post_variables)
	
	//Get our response
	ll_status_code =  loo_xmlhttp.Status
	
	//Check HTTP Response code for errors
	if ll_status_code >= 300 then
		ls_response_text = "<Message>" + loo_xmlhttp.statusText + "</Message>"
		iRet=-1
	else
		ls_response_text = loo_xmlhttp.ResponseText
	end if
	
	//Done so cleanup
	loo_xmlhttp.DisconnectObject()

catch (RuntimeError rte)

  If not gbOpcon Then MessageBox("Error", "RuntimeError - " + rte.getMessage()) 
  
  ls_response_text = "<Message>" + rte.Text + "</Message>"

end try

// Traitement du retour
if ls_response_text<>"" Then 
	aoResult=CREATE srr_createorderresult 
	aoResult.uf_fillfromxml(ls_response_text)
	
	If aoResult.returncode = "OK" Then 
		adwCommande.SetItem(alRow,"ID_CMD_FRN",aoResult.idcommande)
	Else
		iRet=-1 // Erreur du WS	
	End if
Else
	SetNull(aoResult)
	iRet=-2
End if

// [TRACE_WEB_SERVICE]
If iRet < 0 Then
	f_trace_web_service("SRR", isendpointURL , adwCommande.getItemDecimal(alRow,"ID_SIN"), iRet, ls_response_text,ls_post_variables)
End if

Return iRet

end function

public function integer uf_validateorder (datawindow adwcommande, long alrow, ref srr_validateorderresult aoresult);String ls_post_url, ls_user, ls_passwd, ls_Auth
String ls_post_variables, ls_response
String ls_response_text
long   ll_status_code
Integer iRet
OleObject loo_xmlhttp
n_cst_crypter_base64 nvBase64
String sIdCommandeSPB

ls_response_text=""

ls_post_url=ProfileString(stGlb.sfichierini ,"SRR","URL_WEBSERVICE_SRR","*")
ls_user=ProfileString(stGlb.sfichierini ,"SRR","USERNAME","*")
ls_passwd=ProfileString(stGlb.sfichierini ,"SRR","PASSWORD","*")

sIdCommandeSPB=String(adwCommande.GetItemDecimal(alRow,"ID_SIN")) + "-" + String(adwCommande.GetItemNumber(alRow,"ID_SEQ"))

iRet=1

nvBase64=CREATE n_cst_crypter_base64

ls_Auth=ls_user + ":" + ls_passwd
ls_Auth=of_encode64( ls_Auth)

try
	//Create an instance of our COM object
	loo_xmlhttp = CREATE oleobject
	loo_xmlhttp.ConnectToNewObject("Msxml2.XMLHTTP.6.0")
	
	ls_post_variables =   "<soapenv:Envelope xmlns:soapenv=~"http://schemas.xmlsoap.org/soap/envelope/~" xmlns:ass=~"http://sfr.re/sismo/assurance~">~n"
	ls_post_variables += "  <soapenv:Header/>~n"
	ls_post_variables += "  <soapenv:Body>~n"
	ls_post_variables += "    <ass:ValidateOrder>~n"
	ls_post_variables += "      <ass:idExterne>" + sIdCommandeSPB + "</ass:idExterne>~n"
	ls_post_variables += "      <ass:idCommande>" + f_getitem3(adwCommande, alRow, "ID_CMD_FRN") + "</ass:idCommande>~n"
     ls_post_variables += "      <ass:destinataire>~n"
	ls_post_variables += "        <ass:Nom>" + adwCommande.GetItemString(alRow,"ADR_NOM") + "</ass:Nom>~n"
	ls_post_variables += "        <ass:Prenom>" + f_getitem3(adwCommande, alRow, "ADR_PRENOM") + "</ass:Prenom>~n"
	ls_post_variables += "        <ass:Adr1>" + f_getitem3(adwCommande, alRow, "ADR_LIVR1") + "</ass:Adr1>~n"
	ls_post_variables += "        <ass:Adr2>" + f_getitem3(adwCommande, alRow, "ADR_LIVR2") + "</ass:Adr2>~n"
	ls_post_variables += "        <ass:Adr3>" + f_getitem3(adwCommande, alRow, "ADR_LIVR_CPL") + "</ass:Adr3>~n"
	ls_post_variables += "        <ass:CodePostal>" + f_getitem3(adwCommande, alRow, "ADR_CP") + "</ass:CodePostal>~n"
	ls_post_variables += "        <ass:Ville>" + f_getitem3(adwCommande, alRow, "ADR_VILLE") + "</ass:Ville>~n"
	ls_post_variables += "        <ass:Telephone>" + f_getitem3(adwCommande, alRow, "ADR_TEL1") + "</ass:Telephone>~n"
	ls_post_variables += "      </ass:destinataire>~n"
	ls_post_variables += "    </ass:ValidateOrder>~n"
	ls_post_variables += "  </soapenv:Body>~n"
	ls_post_variables += "</soapenv:Envelope>~n"
	
	loo_xmlhttp.open ("POST",ls_post_url, false)
	
	loo_xmlhttp.setRequestHeader("SOAPAction","http://sfr.re/sismo/assurance/ValidateOrder")  
	loo_xmlhttp.setRequestHeader("Content-Type", "text/xml")
	
	loo_xmlhttp.setRequestHeader("Authorization", "Basic " + ls_Auth)
		
	loo_xmlhttp.send(ls_post_variables)
	
	//Get our response
	ll_status_code =  loo_xmlhttp.Status
	
	//Check HTTP Response code for errors
	if ll_status_code >= 300 then
		iRet=-1
	else
		ls_response_text = loo_xmlhttp.ResponseText
	end if
	
	//Done so cleanup
	loo_xmlhttp.DisconnectObject()

catch (RuntimeError rte)

  MessageBox("Error", "RuntimeError - " + rte.getMessage()) 

end try

// Traitement du retour
if ls_response_text<>"" Then 
	aoResult=CREATE srr_validateorderresult 
	aoResult.uf_fillfromxml(ls_response_text)
	
	If aoResult.returncode <> "OK" Then 
		iRet=-1 // Erreur du WS
	End if
Else
	SetNull(aoResult)
	iRet=-2
End if

// [TRACE_WEB_SERVICE]
If iRet < 0 Then
	f_trace_web_service("SRR", isendpointURL , adwCommande.getItemDecimal(alRow,"ID_SIN"), iRet, ls_response_text,ls_post_variables)
End if

Return iRet

end function

on n_cst_sp_ws_srr_caller.create
call super::create
end on

on n_cst_sp_ws_srr_caller.destroy
call super::destroy
end on

