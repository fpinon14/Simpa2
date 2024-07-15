HA$PBExportHeader$spbsepa_bankresponse.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type spbsepa_bankResponse from nonvisualobject
    end type
end forward

global type spbsepa_bankResponse from nonvisualobject
end type

type variables
    string bankCode
    string counterCode
    string name
    string shortName
    string bic
    string adress
    string additionalAdress
    string zipCode
    string city
    long isoCodeCountry
end variables

on spbsepa_bankResponse.create
call super::create
TriggerEvent( this, "constructor" )
end on

on spbsepa_bankResponse.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

