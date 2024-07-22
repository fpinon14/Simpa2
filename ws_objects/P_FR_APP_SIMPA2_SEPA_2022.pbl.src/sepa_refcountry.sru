HA$PBExportHeader$sepa_refcountry.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_refCountry from nonvisualobject
    end type
end forward

global type sepa_refCountry from nonvisualobject
end type

type variables
    sepa_bankCounter bankCounters[]
    int code
    long id
    boolean idSpecified
    boolean isActive
    string isoCode
    string longLabel
    string shortLabel
end variables

on sepa_refCountry.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_refCountry.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

