HA$PBExportHeader$n_cst_sp_ws_spbsepa_caller.sru
$PBExportComments$[VDoc20041]
forward
global type n_cst_sp_ws_spbsepa_caller from n_cst_sp_ws_caller
end type
end forward

global type n_cst_sp_ws_spbsepa_caller from n_cst_sp_ws_caller
end type
global n_cst_sp_ws_spbsepa_caller n_cst_sp_ws_spbsepa_caller

type variables
spbsepa_bankreferentialwebservice iProxy
end variables

forward prototypes
public function integer createproxy (soapconnection asoapcnx)
public function boolean isbankcounterexist (string ascodebanque, string ascodeagence)
end prototypes

public function integer createproxy (soapconnection asoapcnx);long lRet
String sUrl

try
	sUrl=ProfileString(stglb.sfichierini,"SEPA","URL_WEBSERVICE_SEPA","")
	
	if sUrl="" Then Return -2
	
	lret = aSoapcnx.CreateInstance(iProxy, 	"spbsepa_bankreferentialwebservice")
	
	If lRet=0 Then lRet=1 Else lRet=-1

catch (RuntimeError re)

	lRet=-1

End try
 
return lRet

end function

public function boolean isbankcounterexist (string ascodebanque, string ascodeagence);// FPI - 29/04/2016 - [TRACE_WEB_SERVICE]
Boolean bRet
Decimal dcNull

spbsepa_isbankexist u_bce
spbsepa_isbankexistresponse u_bce_reponse

bRet=TRUE // si le ws ne fonctionne pas, on renvoie TRUE
SetNull(dcNull)

Try
	// Appel de la fonction du WebService
	u_bce=CREATE spbsepa_isbankexist
	u_bce.bankrequest.bankcode=asCodeBanque
	u_bce.bankrequest.countercode=asCodeAgence
	u_bce.bankrequest.isocodecountry=1
	
	u_bce_reponse=iProxy.isbankexist( u_bce)
	
	bRet=u_bce_reponse.isexist

catch ( SoapException e )
	uf_gestionexception( e)
	
	// [TRACE_WEB_SERVICE]
	f_trace_web_service("Sepa","https://saga2.spb.eu/spb-referential-bank/BankReferentialWebService?wsdl" , &
		dcNull, e.number , e.Text ,"Code banque=" + asCodeBanque + " - code_agence=" +asCodeAgence )
	
end try

Return bRet

end function

on n_cst_sp_ws_spbsepa_caller.create
call super::create
end on

on n_cst_sp_ws_spbsepa_caller.destroy
call super::destroy
end on

