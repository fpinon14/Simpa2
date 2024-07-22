HA$PBExportHeader$u_transaction_hub_prestataire.sru
forward
global type u_transaction_hub_prestataire from transaction
end type
end forward

global type u_transaction_hub_prestataire from transaction
end type
global u_transaction_hub_prestataire u_transaction_hub_prestataire

type prototypes
Function long PS_HP276_SIU_EXECUTE_SQL_CMDE (string asCmde , Ref Long alIdentity, Ref Long alRowCount ) RPCFUNC ALIAS FOR "edi.PS_HP276_SIU_EXECUTE_SQL_CMDE"


end prototypes
type variables
Private:
	CONSTANT String	K_IDSQL="SQL"
	String idSql=""
	
end variables
forward prototypes
public subroutine uf_setidsql ()
public function string uf_getidsql ()
end prototypes

public subroutine uf_setidsql ();ContextKeyword Cnx_KeyWord
String  sRet[]

This.GetContextService ( "Keyword", Cnx_KeyWord )
Cnx_KeyWord.GetContextKeyWords ( K_IDSQL, sRet )

This.idSql=""

if UpperBound ( sRet ) = 1 Then
	If	IsNull ( sRet[1] ) Or Len ( Trim ( sRet[1] ) ) = 0	Then
		sRet[1] = ""
	End If
	
	idSql=sRet[1]
End if
end subroutine

public function string uf_getidsql ();if isNull(idSql) Then idSql=""

If idSql="" Then uf_setidsql( )

Return idSql

end function

on u_transaction_hub_prestataire.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_transaction_hub_prestataire.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;uf_setidsql( )

end event

