HA$PBExportHeader$chrono_horaireouverture.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
global type chrono_horaireouverture from nonvisualobject
end type
end forward

global type chrono_horaireouverture from nonvisualobject
end type
global chrono_horaireouverture chrono_horaireouverture

type variables
    string debut
    string fin
end variables

forward prototypes
public subroutine uf_parse (ref oleobject aonode)
end prototypes

public subroutine uf_parse (ref oleobject aonode);OleObject xmlNode

xmlNode=aoNode.getElementsByTagName("debut")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then debut=xmlNode.Item(0).Text
End if

xmlNode=aoNode.getElementsByTagName("fin")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then fin=xmlNode.Item(0).Text
End if
end subroutine

on chrono_horaireouverture.create
call super::create
TriggerEvent( this, "constructor" )
end on

on chrono_horaireouverture.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

