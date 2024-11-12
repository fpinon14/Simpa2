$PBExportHeader$u_gs_sp_sinistre_2.sru
$PBExportComments$Cause objet Trop grand en taille, je déporte des fonction
forward
global type u_gs_sp_sinistre_2 from nonvisualobject
end type
end forward

global type u_gs_sp_sinistre_2 from nonvisualobject
end type
global u_gs_sp_sinistre_2 u_gs_sp_sinistre_2

type variables
Private :



end variables

forward prototypes
public subroutine uf_initialiser ()
end prototypes

public subroutine uf_initialiser ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialiser (Public)
//* Auteur			: FABRY JF
//* Date				: 12/11/2024
//* Libellé			: 
//* Commentaires	: Initialisation des instances pour l'objet numéro 2
//*
//* Arguments		: Voir arguments
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------



end subroutine

on u_gs_sp_sinistre_2.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_gs_sp_sinistre_2.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

