HA$PBExportHeader$game_inputvalidatenumber.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type game_InPutValidateNumber from nonvisualobject
    end type
end forward

global type game_InPutValidateNumber from nonvisualobject
end type

type variables
    string ClaimReference
    string VoucherNumber
end variables

on game_InPutValidateNumber.create
call super::create
TriggerEvent( this, "constructor" )
end on

on game_InPutValidateNumber.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

