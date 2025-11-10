HA$PBExportHeader$spbsepa_bankrequest.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type spbsepa_bankRequest from nonvisualobject
    end type
end forward

global type spbsepa_bankRequest from nonvisualobject
end type

type variables
    string bankCode
    string counterCode
    long isoCodeCountry
end variables

on spbsepa_bankRequest.create
call super::create
TriggerEvent( this, "constructor" )
end on

on spbsepa_bankRequest.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

