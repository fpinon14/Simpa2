$PBExportHeader$u_gs_sp_sinistre_2.sru
$PBExportComments$Cause objet Trop grand en taille, je déporte des fonction
forward
global type u_gs_sp_sinistre_2 from nonvisualobject
end type
end forward

global type u_gs_sp_sinistre_2 from nonvisualobject
end type
global u_gs_sp_sinistre_2 u_gs_sp_sinistre_2

on u_gs_sp_sinistre_2.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_gs_sp_sinistre_2.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

