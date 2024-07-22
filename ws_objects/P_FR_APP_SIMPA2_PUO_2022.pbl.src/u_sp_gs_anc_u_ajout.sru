HA$PBExportHeader$u_sp_gs_anc_u_ajout.sru
$PBExportComments$---} User Object anc$$HEX1$$ea00$$ENDHEX$$tre de contr$$HEX1$$f400$$ENDHEX$$le de gestion  pour les User Object de type U_Ajout
forward
global type u_sp_gs_anc_u_ajout from nonvisualobject
end type
end forward

global type u_sp_gs_anc_u_ajout from nonvisualobject
end type
global u_sp_gs_anc_u_ajout u_sp_gs_anc_u_ajout

type variables
Transaction	itrTrans
u_Ajout		iuAjout
end variables

forward prototypes
public subroutine uf_initialisation (u_transaction atrTrans, ref u_ajout auAjout)
end prototypes

public subroutine uf_initialisation (u_transaction atrtrans, ref u_ajout auajout);//*-----------------------------------------------------------------
//*
//* Fonction		:	Uf_Initialisation
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	19/06/1997 14:10:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialise la variable iuAjout et l'objet de transaction. 
//* Commentaires	: 
//*
//* Arguments		:	u_transaction	atrtrans ( Val ) : objet de transaction
//*					 	u_Ajout			auAjout  ( Ref ) : objet de type contenu/contenant
//*
//* Retourne		:	Rien
//*					
//*
//*-----------------------------------------------------------------

itrTrans = atrTrans
iuajout  = auAjout
end subroutine

on u_sp_gs_anc_u_ajout.create
TriggerEvent( this, "constructor" )
end on

on u_sp_gs_anc_u_ajout.destroy
TriggerEvent( this, "destructor" )
end on

