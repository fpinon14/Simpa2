HA$PBExportHeader$sepa_bankcounter.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_bankCounter from nonvisualobject
    end type
end forward

global type sepa_bankCounter from nonvisualobject
end type

type variables
    string adress3
    string adress4
    string adress5
    string adress6
    string bankCode
    string bic
    string counterCode
    sepa_dataset dataset
    long id
    boolean idSpecified
    string name
    sepa_refCountry refCountry
    string shortName
    boolean xxx
end variables

on sepa_bankCounter.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_bankCounter.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

