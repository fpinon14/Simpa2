HA$PBExportHeader$u_sp_gs_condition.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les relatifs aux conditions de garantie
forward
global type u_sp_gs_condition from u_sp_gs_anc_u_ajout
end type
end forward

global type u_sp_gs_condition from u_sp_gs_anc_u_ajout
end type
global u_sp_gs_condition u_sp_gs_condition

forward prototypes
public function boolean uf_terminervalider ()
end prototypes

public function boolean uf_terminervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_Terminervalider
//* Auteur			:	V.Capelle
//* Date				:	07/11/1997 14:33:24
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	D$$HEX1$$e900$$ENDHEX$$clenche l'update pour les conditions de
//*						garantie.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en		Vrai si l'update s'est bien pass$$HEX1$$e900$$ENDHEX$$
//*
//*-----------------------------------------------------------------
Boolean		bRet = True		// Valeur de retour de la fonction

If ( iuAjout.Dw_Source.Update () = -1 ) Then bRet = False

Return ( bRet )
end function

on u_sp_gs_condition.create
TriggerEvent( this, "constructor" )
end on

on u_sp_gs_condition.destroy
TriggerEvent( this, "destructor" )
end on

