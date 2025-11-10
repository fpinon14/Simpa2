HA$PBExportHeader$u_sp_gs_parainfo.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de gestion relatifs aux Paragraphes d'informations d'un Produit.
forward
global type u_sp_gs_parainfo from nonvisualobject
end type
end forward

global type u_sp_gs_parainfo from nonvisualobject
end type
global u_sp_gs_parainfo u_sp_gs_parainfo

type variables
u_transaction	itrTrans

u_Ajout		iuAjout
end variables

forward prototypes
public function boolean uf_terminervalider ()
public subroutine uf_initialisation (u_transaction atrtrans, ref u_ajout auajout)
end prototypes

public function boolean uf_terminervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_TerminerValider ()
//* Auteur			: YP
//* Date				: 26/08/1997 10:58:17
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Update de la Datawindow.
//*
//* Arguments		: 
//*
//* Retourne		: Boolean : True la validation peut se poursuivre.
//*
//*-----------------------------------------------------------------

Return ( Not ( iuAjout.dw_Source.Update () = -1 ) )
end function

public subroutine uf_initialisation (u_transaction atrtrans, ref u_ajout auajout);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_initialisation
//* Auteur			: YP
//* Date				: 26/08/1997 10:58:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialise la variable iuAjout et l'objet de transaction
//* Commentaires	: 
//*
//* Arguments		: u_transaction	atrTrans ( Val ) objet de transaction
//*					  u_Ajout			auAjout  ( Ref ) objet contenu/contenant
//*
//* Retourne		: Rien
//*					
//*
//*-----------------------------------------------------------------

itrTrans = atrTrans
iuajout  = auAjout
end subroutine

on u_sp_gs_parainfo.create
TriggerEvent( this, "constructor" )
end on

on u_sp_gs_parainfo.destroy
TriggerEvent( this, "destructor" )
end on

