HA$PBExportHeader$spbsepa_bicrequest.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type spbsepa_bicRequest from nonvisualobject
    end type
end forward

global type spbsepa_bicRequest from nonvisualobject
end type

type variables
    string bic
    string isoCodeCountry
end variables

on spbsepa_bicRequest.create
call super::create
TriggerEvent( this, "constructor" )
end on

on spbsepa_bicRequest.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

