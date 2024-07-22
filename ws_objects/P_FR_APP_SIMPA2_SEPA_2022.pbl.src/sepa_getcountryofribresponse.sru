HA$PBExportHeader$sepa_getcountryofribresponse.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_getCountryOfRibResponse from nonvisualobject
    end type
end forward

global type sepa_getCountryOfRibResponse from nonvisualobject
end type

type variables
    sepa_refCountry ws_return
end variables

on sepa_getCountryOfRibResponse.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_getCountryOfRibResponse.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

