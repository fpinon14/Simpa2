HA$PBExportHeader$spbsepa_getbank.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type spbsepa_getBank from nonvisualobject
    end type
end forward

global type spbsepa_getBank from nonvisualobject
end type

type variables
    spbsepa_bankRequest bankRequest
end variables

on spbsepa_getBank.create
call super::create
TriggerEvent( this, "constructor" )
end on

on spbsepa_getBank.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

