HA$PBExportHeader$spbsepa_isbankexist.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
global type spbsepa_isbankexist from nonvisualobject
end type
end forward

global type spbsepa_isbankexist from nonvisualobject
end type
global spbsepa_isbankexist spbsepa_isbankexist

type variables
    spbsepa_bankRequest bankRequest
end variables

on spbsepa_isbankexist.create
call super::create
TriggerEvent( this, "constructor" )
end on

on spbsepa_isbankexist.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;bankRequest=CREATE spbsepa_bankRequest
end event

