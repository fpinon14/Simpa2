HA$PBExportHeader$sepa_dataset.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type sepa_dataset from nonvisualobject
    end type
end forward

global type sepa_dataset from nonvisualobject
end type

type variables
    sepa_bankCounter bankCounters[]
    datetime dateLoad
    boolean dateLoadSpecified
    long id
    boolean idSpecified
    boolean isValidLoad
end variables

on sepa_dataset.create
call super::create
TriggerEvent( this, "constructor" )
end on

on sepa_dataset.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

