HA$PBExportHeader$spbsepa_verifyiban.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type spbsepa_verifyIban from nonvisualobject
    end type
end forward

global type spbsepa_verifyIban from nonvisualobject
end type

type variables
    spbsepa_iban iban
end variables

on spbsepa_verifyIban.create
call super::create
TriggerEvent( this, "constructor" )
end on

on spbsepa_verifyIban.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

