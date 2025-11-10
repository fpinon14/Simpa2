HA$PBExportHeader$spbsepa_bban.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type spbsepa_bban from nonvisualobject
    end type
end forward

global type spbsepa_bban from nonvisualobject
end type

type variables
    string bankCode
    string counterCode
    string accountNumber
    string key
    long isoCodeCountry
end variables

on spbsepa_bban.create
call super::create
TriggerEvent( this, "constructor" )
end on

on spbsepa_bban.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

