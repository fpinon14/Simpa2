HA$PBExportHeader$spbsepa_getbankresponse.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type spbsepa_getBankResponse from nonvisualobject
    end type
end forward

global type spbsepa_getBankResponse from nonvisualobject
end type

type variables
    spbsepa_bankResponse bank
end variables

on spbsepa_getBankResponse.create
call super::create
TriggerEvent( this, "constructor" )
end on

on spbsepa_getBankResponse.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

