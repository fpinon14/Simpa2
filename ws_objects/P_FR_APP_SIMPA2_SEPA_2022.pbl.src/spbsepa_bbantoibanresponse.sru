HA$PBExportHeader$spbsepa_bbantoibanresponse.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type spbsepa_bbanToIbanResponse from nonvisualobject
    end type
end forward

global type spbsepa_bbanToIbanResponse from nonvisualobject
end type

type variables
    spbsepa_iban iban
end variables

on spbsepa_bbanToIbanResponse.create
call super::create
TriggerEvent( this, "constructor" )
end on

on spbsepa_bbanToIbanResponse.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

