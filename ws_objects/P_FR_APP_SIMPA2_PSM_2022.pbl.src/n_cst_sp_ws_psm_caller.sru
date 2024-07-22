HA$PBExportHeader$n_cst_sp_ws_psm_caller.sru
$PBExportComments$[PM200-5]
forward
global type n_cst_sp_ws_psm_caller from n_cst_sp_ws_caller
end type
end forward

global type n_cst_sp_ws_psm_caller from n_cst_sp_ws_caller
end type
global n_cst_sp_ws_psm_caller n_cst_sp_ws_psm_caller

type variables
psm_psmshopmanagementsoap iProxy
end variables

forward prototypes
public function integer createproxy (soapconnection asoapcnx)
public function long uf_get_boutiques (string ascodepostal, ref string aslisteboutiques)
end prototypes

public function integer createproxy (soapconnection asoapcnx);long lRet

try
	lret = aSoapcnx.CreateInstance(iProxy, 	"psm_psmshopmanagementsoap")
	
	If lRet=0 Then lRet=1 Else lRet=-1

catch (RuntimeError re)

	lRet=-1

End try
 
return lRet

end function

public function long uf_get_boutiques (string ascodepostal, ref string aslisteboutiques);long lRet=1

Try
	// Appel de la fonction du WebService
	aslisteBoutiques=iProxy.getpsmshop( asCodePostal)

	if isnull(asListeBoutiques) Then
		lRet=0
	Elseif trim(aslisteboutiques) = "" Then
		lRet=0
	End if
	
catch ( SoapException e )
	lRet = uf_gestionexception( e)
end try

Return lRet

end function

on n_cst_sp_ws_psm_caller.create
call super::create
end on

on n_cst_sp_ws_psm_caller.destroy
call super::destroy
end on

