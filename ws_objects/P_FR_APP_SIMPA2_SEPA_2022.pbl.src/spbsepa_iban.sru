HA$PBExportHeader$spbsepa_iban.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type spbsepa_iban from nonvisualobject
    end type
end forward

global type spbsepa_iban from nonvisualobject
end type

type variables
    string iban1
    string bic
    long isoCodeCountry
end variables

on spbsepa_iban.create
call super::create
TriggerEvent( this, "constructor" )
end on

on spbsepa_iban.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

