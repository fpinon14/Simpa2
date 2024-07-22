HA$PBExportHeader$srr_destinataire.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type srr_Destinataire from nonvisualobject
    end type
end forward

global type srr_Destinataire from nonvisualobject
end type

type variables
    string Nom
    string Prenom
    string Adr1
    string Adr2
    string Adr3
    string CodePostal
    string Ville
    string Telephone
end variables

on srr_Destinataire.create
call super::create
TriggerEvent( this, "constructor" )
end on

on srr_Destinataire.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

