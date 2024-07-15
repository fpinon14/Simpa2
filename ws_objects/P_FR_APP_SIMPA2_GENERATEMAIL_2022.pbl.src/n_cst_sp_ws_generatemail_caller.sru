HA$PBExportHeader$n_cst_sp_ws_generatemail_caller.sru
forward
global type n_cst_sp_ws_generatemail_caller from nonvisualobject
end type
end forward

global type n_cst_sp_ws_generatemail_caller from nonvisualobject autoinstantiate
end type

type variables
public:
	string mailFrom
	string mailTo
	string mailSubject
	integer mailTypeId
	
private:
	st_variable_mail datas[]
end variables

forward prototypes
public subroutine uf_reset_datas ()
private function string uf_buildrequest ()
public function boolean uf_sendmail (ref generatemail_response uoresult)
public function generatemail_response uf_parsejsonresult (string asjson)
public subroutine uf_add_data (string asvariable, string asvaleur)
public function string uf_get_data (string asvariable)
end prototypes

public subroutine uf_reset_datas ();SetNull(datas)

end subroutine

private function string uf_buildrequest ();string sRet
integer iIndex

sRet="{~n"
sRet+="~"refLabelMail~": {~n"
sRet+="~"businessId~": " + string(mailtypeid) + "~n"
sRet+="},~n"

sRet+="~"receiver~": ~"" + mailto + "~",~n"
sRet+="~"sender~": ~"" + mailfrom + "~",~n"
sRet+="~"subject~": ~"" + mailsubject + "~",~n"

//sRet += "~"claimNumber~": ~"0~",~n";

sRet+="~"datas~": {~n"

if not isnull(datas) Then
	for iIndex=1 to UpperBound(datas)
		sRet+="~"" + datas[iIndex].variable + "~": ~"" + datas[iIndex].valeur + "~""
		if iIndex <>UpperBound(datas) Then sRet+=","
		sRet+="~n"
	next
End if

sRet+="}~n}~n"

return sRet
end function

public function boolean uf_sendmail (ref generatemail_response uoresult);OleObject loo_xmlhttp
n_cst_String nvString
String sLogin, sPassword, lsAuth
n_cst_crypter_base64 nvBase64
string sUrl, sErreur
string ls_response_text
long ll_status_code
string srequest

Boolean bRet=true

if trim(mailFrom)="" or trim(mailto)="" or mailtypeid=0 Then
	// Set return code in st
	return false
End if


sUrl=ProfileString(stglb.sfichierini ,"ENVOI_MAIL","URL_WEBSERVICE_REST","*")
sLogin=ProfileString(stglb.sfichierini,"ENVOI_MAIL","User","*")
sPassword=ProfileString(stglb.sfichierini,"ENVOI_MAIL","Password","*")

if sUrl="*" or sLogin="*" or sPassword="*" Then
		// Set return code in st
	return false
End if

f_crypter(sLogin,FALSE)
f_crypter(sPassword,FALSE)
	
lsAuth=sLogin + ":" + sPassword

nvBase64=CREATE n_cst_crypter_base64
nvBase64.uf_crypter_utf8( lsAuth, true)

srequest=uf_buildrequest( )

try
	//Create an instance of our COM object
	loo_xmlhttp = CREATE oleobject
	loo_xmlhttp.ConnectToNewObject("Msxml2.XMLHTTP.6.0")
	
	loo_xmlhttp.open ("POST",sUrl, false)
	
	loo_xmlhttp.SetRequestHeader( "Content-Type", "application/json")
	loo_xmlhttp.setRequestHeader("Authorization", "Basic " + lsAuth)  
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
	f_trace_web_service("Mail Saga2 - generatemail",sUrl,Dec(uf_get_data( "id_sin")) , integer(ll_status_code), sErreur,srequest)
	f_trace_web_service("Mail Saga2 - generatemail - reponse",sUrl, Dec(uf_get_data( "id_sin")), integer(ll_status_code), sErreur,ls_response_text)
End if

Return bRet
end function

public function generatemail_response uf_parsejsonresult (string asjson);generatemail_response uoResult

uoResult=CREATE generatemail_response

uoResult.uf_fillfromjson( asjson)

Return uoResult
end function

public subroutine uf_add_data (string asvariable, string asvaleur);st_variable_mail ldatas[]
int iIndex

if isnull(datas) Then
	datas=ldatas	
	iIndex=1
else
	iIndex=UpperBound(datas) + 1
End if

datas[iIndex].variable=asvariable
datas[iIndex].valeur=asvaleur
end subroutine

public function string uf_get_data (string asvariable);String sRet=""
integer iPos

if isnull(datas) then return ""

For iPos=1 To UpperBound(datas)
	if upper(datas[iPos].variable)=upper(asVariable) Then
		sRet=datas[iPos].valeur
		exit 
	End if
Next

Return sRet
end function

on n_cst_sp_ws_generatemail_caller.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_sp_ws_generatemail_caller.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;mailfrom="noreply@spb.eu"
mailto=""

mailSubject=""

SetNull(datas)

mailTypeId=0
end event

