HA$PBExportHeader$chrono_periodefermeture.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
global type chrono_periodefermeture from nonvisualobject
end type
end forward

global type chrono_periodefermeture from nonvisualobject
end type
global chrono_periodefermeture chrono_periodefermeture

type variables
    datetime calendarDeDebut
    boolean calendarDeDebutSpecified=false
    datetime calendarDeFin
    boolean calendarDeFinSpecified=false
    long numero
end variables
forward prototypes
public subroutine uf_parse (ref oleobject aonode)
end prototypes

public subroutine uf_parse (ref oleobject aonode);OleObject xmlNode,xmlChildNode
Long lIndex

xmlNode=aoNode.getElementsByTagName("calendarDeDebut")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then 
		calendarDeDebut=DateTime(xmlNode.Item(0).Text)
		calendarDeDebutSpecified=true
	End if
End if

xmlNode=aoNode.getElementsByTagName("calendarDeFin")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then 
		calendarDeFin=DateTime(xmlNode.Item(0).Text)
		calendarDeFinSpecified=true
	End if
End if

xmlNode=aoNode.getElementsByTagName("numero")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then numero=Long(xmlNode.Item(0).Text)
End if

end subroutine

on chrono_periodefermeture.create
call super::create
TriggerEvent( this, "constructor" )
end on

on chrono_periodefermeture.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

