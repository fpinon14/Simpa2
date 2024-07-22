HA$PBExportHeader$chrono_listehoraireouverturepourunjour.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
global type chrono_listehoraireouverturepourunjour from nonvisualobject
end type
end forward

global type chrono_listehoraireouverturepourunjour from nonvisualobject
end type
global chrono_listehoraireouverturepourunjour chrono_listehoraireouverturepourunjour

type variables
    string horairesAsString
    long jour
    chrono_horaireOuverture listeHoraireOuverture[]
end variables

forward prototypes
public subroutine uf_parse (ref oleobject aonode)
end prototypes

public subroutine uf_parse (ref oleobject aonode);OleObject xmlNode,xmlChildNode
Long lIndex

xmlNode=aoNode.getElementsByTagName("horairesAsString")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then horairesAsString=xmlNode.Item(0).Text
End if


xmlNode=aoNode.getElementsByTagName("jour")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then jour=Long(xmlNode.Item(0).Text)
End if

xmlNode=aoNode.getElementsByTagName("listeHoraireOuverture")
if isValid(xmlNode) Then 
	if xmlNode.length > 0 Then 
		For lIndex=0 to xmlNode.length - 1
			xmlChildNode=		xmlNode.item(lIndex)
			listeHoraireOuverture[lIndex + 1] = CREATE chrono_horaireouverture
			listeHoraireOuverture[lIndex + 1].uf_parse(xmlChildNode)
		Next
	End if
End if

end subroutine

on chrono_listehoraireouverturepourunjour.create
call super::create
TriggerEvent( this, "constructor" )
end on

on chrono_listehoraireouverturepourunjour.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

