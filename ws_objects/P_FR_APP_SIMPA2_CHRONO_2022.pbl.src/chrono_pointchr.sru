HA$PBExportHeader$chrono_pointchr.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
global type chrono_pointchr from nonvisualobject
end type
end forward

global type chrono_pointchr from nonvisualobject
end type
global chrono_pointchr chrono_pointchr

type variables
    boolean accesPersonneMobiliteReduite
    boolean actif
    string adresse1
    string adresse2
    string adresse3
    string codePays
    string codePostal
    string coordGeolocalisationLatitude
    string coordGeolocalisationLongitude
    long distanceEnMetre
    string identifiant
    string indiceDeLocalisation
    chrono_listeHoraireOuverturePourUnJour listeHoraireOuverture[]
    chrono_periodeFermeture listePeriodeFermeture[]
    string localite
    string nom
    long poidsMaxi
    string typeDePoint
    string urlGoogleMaps
end variables

forward prototypes
public subroutine uf_parserelai (ref oleobject aonode)
public function string uf_get_horaires_semaine ()
public function string uf_get_horaires_jour (integer aijour)
end prototypes

public subroutine uf_parserelai (ref oleobject aonode);OleObject xmlNode,xmlChildNode
Long lIndex
n_cst_string nvString

xmlNode=aoNode.getElementsByTagName("accesPersonneMobiliteReduite")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then accespersonnemobilitereduite=(xmlNode.Item(0).Text="true")
End if


xmlNode=aoNode.getElementsByTagName("actif")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then actif=(xmlNode.Item(0).Text = "true")
End if

xmlNode=aoNode.getElementsByTagName("distanceEnMetre")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then distanceEnMetre=Long(xmlNode.Item(0).Text)
End if

xmlNode=aoNode.getElementsByTagName("poidsMaxi")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then poidsMaxi=Long(xmlNode.Item(0).Text)
End if


xmlNode=aoNode.getElementsByTagName("adresse1")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then adresse1=xmlNode.Item(0).Text
End if

xmlNode=aoNode.getElementsByTagName("adresse2")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then adresse2=xmlNode.Item(0).Text
End if

xmlNode=aoNode.getElementsByTagName("adresse3")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then adresse3=xmlNode.Item(0).Text
End if

xmlNode=aoNode.getElementsByTagName("codePays")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then codepays=xmlNode.Item(0).Text
End if


xmlNode=aoNode.getElementsByTagName("codePostal")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then codePostal=xmlNode.Item(0).Text
End if


xmlNode=aoNode.getElementsByTagName("coordGeolocalisationLatitude")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then coordGeolocalisationLatitude=xmlNode.Item(0).Text
End if


xmlNode=aoNode.getElementsByTagName("coordGeolocalisationLongitude")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then adresse3=xmlNode.Item(0).Text
End if


xmlNode=aoNode.getElementsByTagName("identifiant")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then identifiant=xmlNode.Item(0).Text
End if


xmlNode=aoNode.getElementsByTagName("indiceDeLocalisation")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then adresse3=xmlNode.Item(0).Text
End if


xmlNode=aoNode.getElementsByTagName("localite")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then localite=xmlNode.Item(0).Text
End if


xmlNode=aoNode.getElementsByTagName("nom")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then nom=xmlNode.Item(0).Text
End if



xmlNode=aoNode.getElementsByTagName("typeDePoint")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then typeDePoint=xmlNode.Item(0).Text
End if


xmlNode=aoNode.getElementsByTagName("urlGoogleMaps")
if isValid(xmlNode) Then 
	if xmlNode.length = 1 Then urlGoogleMaps=xmlNode.Item(0).Text
End if

// [ITSM274083]
adresse1=nvString.of_globalreplace( adresse1, "~"", "'")
adresse2=nvString.of_globalreplace( adresse2, "~"", "'")
adresse3=nvString.of_globalreplace( adresse3, "~"", "'")

nom=nvString.of_globalreplace( nom, "~"", "'")
localite=nvString.of_globalreplace( localite, "~"", "'")
// :[ITSM274083]

xmlNode=aoNode.getElementsByTagName("listeHoraireOuverture")
if isValid(xmlNode) Then 
	if xmlNode.length > 0 Then 
		For lIndex=0 to xmlNode.length - 1
			xmlChildNode=		xmlNode.item(lIndex)
			listehoraireouverture[lIndex + 1] = CREATE chrono_listeHoraireOuverturePourUnJour
			listehoraireouverture[lIndex + 1].uf_parse(xmlChildNode)
		Next
	End if
End if

xmlNode=aoNode.getElementsByTagName("listePeriodeFermeture")
if isValid(xmlNode) Then 
	if xmlNode.length > 0 Then 
		For lIndex=0 to xmlNode.length - 1
			xmlChildNode=		xmlNode.item(lIndex)
			listePeriodeFermeture[lIndex + 1] = CREATE chrono_periodeFermeture
			listePeriodeFermeture[lIndex + 1].uf_parse(xmlChildNode)
		Next
	End if
End if
end subroutine

public function string uf_get_horaires_semaine ();String sHoraires=""
String sCrLf=Char(11)

If UpperBound(listehoraireouverture) = 0 Then return ""

// Cr$$HEX1$$e900$$ENDHEX$$ation de la chaine de retour
sHoraires+="Lundi : " + uf_get_horaires_jour( 1 ) + sCrLf
sHoraires+="Mardi : " + uf_get_horaires_jour( 2 ) + sCrLf
sHoraires+="Mercredi : " + uf_get_horaires_jour( 3 ) + sCrLf
sHoraires+="Jeudi : " + uf_get_horaires_jour( 4 ) + sCrLf
sHoraires+="Vendredi : " + uf_get_horaires_jour( 5 ) + sCrLf
sHoraires+="Samedi : " + uf_get_horaires_jour( 6 ) + sCrLf
sHoraires+="Dimanche : " + uf_get_horaires_jour( 7 ) + sCrLf

Return sHoraires
end function

public function string uf_get_horaires_jour (integer aijour);String sHoraire="-"
Long lIndex

For lIndex=1 to UpperBound(listehoraireouverture)
	If listehoraireouverture[lIndex].jour=aiJour Then
		sHoraire=listehoraireouverture[lIndex].horairesAsString
		exit
	End if
Next

Return sHoraire
end function

on chrono_pointchr.create
call super::create
TriggerEvent( this, "constructor" )
end on

on chrono_pointchr.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

