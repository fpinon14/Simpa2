$PBExportHeader$game_inputgetnumber.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
global type game_inputgetnumber from nonvisualobject
end type
end forward

global type game_inputgetnumber from nonvisualobject
end type
global game_inputgetnumber game_inputgetnumber

type variables
    string InsurancePolicyNumber
    string ClaimReference
    datetime ws_Date
    decimal Amount
end variables

forward prototypes
public function string uf_getstring ()
end prototypes

public function string uf_getstring ();String sRet=""

sRet="InsurancePolicyNumber="
If isnull(InsurancePolicyNumber) Then
	sRet+="NULL-"
Else 
	sRet+=InsurancePolicyNumber + "-"
End if

sRet+="ClaimReference="
If isnull(ClaimReference) Then
	sRet+="NULL-"
Else 
	sRet+=ClaimReference + "-"
End if

sRet+="ws_Date="
If isnull(ws_Date) Then
	sRet+="NULL-"
Else 
	sRet+=String(ws_Date) + "-"
End if

sRet+="Amount="
If isnull(Amount) Then
	sRet+="NULL-"
Else 
	sRet+=String(Amount) + "-"
End if

Return sRet
end function

on game_inputgetnumber.create
call super::create
TriggerEvent( this, "constructor" )
end on

on game_inputgetnumber.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

