HA$PBExportHeader$srr_createorderitem.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type srr_CreateOrderItem from nonvisualobject
    end type
end forward

global type srr_CreateOrderItem from nonvisualobject
end type

type variables
    long Quantite
    string CodeSAP
end variables

on srr_CreateOrderItem.create
call super::create
TriggerEvent( this, "constructor" )
end on

on srr_CreateOrderItem.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

