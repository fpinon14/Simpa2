HA$PBExportHeader$spbsepa_ibantobban.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type spbsepa_ibanToBban from nonvisualobject
    end type
end forward

global type spbsepa_ibanToBban from nonvisualobject
end type

type variables
    spbsepa_iban iban
end variables

on spbsepa_ibanToBban.create
call super::create
TriggerEvent( this, "constructor" )
end on

on spbsepa_ibanToBban.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

