HA$PBExportHeader$game_outputvalidatenumber.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type game_OutPutValidateNumber from nonvisualobject
    end type
end forward

global type game_OutPutValidateNumber from nonvisualobject
end type

type variables
    string ClaimReference
    string VoucherNumber
    string RetourMess
    string CodeRetour
end variables

on game_OutPutValidateNumber.create
call super::create
TriggerEvent( this, "constructor" )
end on

on game_OutPutValidateNumber.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

