HA$PBExportHeader$u_sp_gs_groupecarte.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de gestion relatifs aux groupes ( contractant ).
forward
global type u_sp_gs_groupecarte from u_spb_gs_anc
end type
end forward

global type u_sp_gs_groupecarte from u_spb_gs_anc
end type
global u_sp_gs_groupecarte u_sp_gs_groupecarte

forward prototypes
public function string uf_gs_sup_grp (long adcidgrp)
end prototypes

public function string uf_gs_sup_grp (long adcidgrp);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_sup_grp
//* Auteur			:	YP
//* Date				:	13/08/97 14:43:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	V$$HEX1$$e900$$ENDHEX$$rification de l'absence de contrainte 
//*					 	d'int$$HEX1$$e900$$ENDHEX$$grit$$HEX2$$e9002000$$ENDHEX$$pour le groupe dans les cartes.
//*
//* Commentaires	:	
//*
//* Arguments		:	String		adcIdGrp	//Type de code $$HEX2$$e0002000$$ENDHEX$$supprimer  
//*
//*														
//* Retourne		: String		"" --> la suppression est possible
//*									Type d'information en relation avec le
//*									groupe $$HEX2$$e0002000$$ENDHEX$$supprimer.
//*
//*-----------------------------------------------------------------

String	 sRet 		// Valeur de retour de la fonction correspondant au 
							// type d'informations en relation avec le groupe

Long 		lNbCarte		// Nombre de cartes en relation avec le groupe.

sRet       = ""
lNbcarte   = 0

/*------------------------------------------------------------------*/
/* Recherche si ce groupe est li$$HEX4$$e9002000e0002000$$ENDHEX$$un produit Et/Ou $$HEX2$$e0002000$$ENDHEX$$un           */
/* $$HEX1$$e900$$ENDHEX$$tablissement.                                                   */
/*------------------------------------------------------------------*/
lNbCarte = itrTrans.IM_S01_CARTE ( adcIdGrp )

/*------------------------------------------------------------------*/
/* Construction de la chaine de retour.                             */
/*------------------------------------------------------------------*/
If f_procedure ( stMessage , iTrTrans , "IM_S01_CARTE" ) Then

	If lNbCarte <> 0 then

		sRet = "des cartes"

	End if

Else

	/*----------------------------------------------------------------------------*/
	/* On se trouve dans le cas o$$HEX2$$f9002000$$ENDHEX$$une erreur a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$e et g$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e (affichage  */
	/* d'un message d'erreur) par f_procedure, donc avec sText="PROC" on          */
	/* l'indique au code appelant.                                                */
	/*----------------------------------------------------------------------------*/
	sRet = "PROC"

End If

Return ( sRet )
end function

on u_sp_gs_groupecarte.create
TriggerEvent( this, "constructor" )
end on

on u_sp_gs_groupecarte.destroy
TriggerEvent( this, "destructor" )
end on

