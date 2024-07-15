HA$PBExportHeader$spbsepa_isbiccodeexist.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type spbsepa_isBicCodeExist from nonvisualobject
    end type
end forward

global type spbsepa_isBicCodeExist from nonvisualobject
end type

type variables
    spbsepa_bicRequest bicRequest
end variables

on spbsepa_isBicCodeExist.create
call super::create
TriggerEvent( this, "constructor" )
end on

on spbsepa_isBicCodeExist.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

