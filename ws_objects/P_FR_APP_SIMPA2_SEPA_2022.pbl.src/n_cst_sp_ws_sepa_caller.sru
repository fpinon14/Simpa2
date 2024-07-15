HA$PBExportHeader$n_cst_sp_ws_sepa_caller.sru
$PBExportComments$[VDoc12394]
forward
global type n_cst_sp_ws_sepa_caller from n_cst_sp_ws_caller
end type
end forward

global type n_cst_sp_ws_sepa_caller from n_cst_sp_ws_caller
end type
global n_cst_sp_ws_sepa_caller n_cst_sp_ws_sepa_caller

type variables
sepa_sepawebservice iProxy
end variables

forward prototypes
public function integer createproxy (soapconnection asoapcnx)
public function boolean isbankcounterexist (string ascodebanque, string ascodeagence)
end prototypes

public function integer createproxy (soapconnection asoapcnx);long lRet

try
	lret = aSoapcnx.CreateInstance(iProxy, 	"sepa_sepawebservice")
	
	If lRet=0 Then lRet=1 Else lRet=-1

catch (RuntimeError re)

	lRet=-1

End try
 
return lRet

end function

public function boolean isbankcounterexist (string ascodebanque, string ascodeagence);Boolean bRet
sepa_isbankcounterexist u_bce
sepa_isbankcounterexistresponse u_bce_reponse

bRet=TRUE // si le ws ne fonctionne pas, on renvoie TRUE

Try
	// Appel de la fonction du WebService
	u_bce=CREATE sepa_isbankcounterexist
	u_bce.bankcode=asCodeBanque
	u_bce.countercode=asCodeAgence
	
	u_bce_reponse=iProxy.isbankcounterexist( u_bce)
	
	bRet=u_bce_reponse.ws_return

catch ( SoapException e )
	uf_gestionexception( e)
end try

Return bRet

end function

on n_cst_sp_ws_sepa_caller.create
call super::create
end on

on n_cst_sp_ws_sepa_caller.destroy
call super::destroy
end on

