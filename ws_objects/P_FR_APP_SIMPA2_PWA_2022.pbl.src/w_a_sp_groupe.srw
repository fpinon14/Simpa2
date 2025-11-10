HA$PBExportHeader$w_a_sp_groupe.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le param$$HEX1$$e900$$ENDHEX$$trage des $$HEX1$$e900$$ENDHEX$$tablissements
forward
global type w_a_sp_groupe from w_a_spb_groupe
end type
end forward

global type w_a_sp_groupe from w_a_spb_groupe
end type
global w_a_sp_groupe w_a_sp_groupe

event ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_sp_groupe ( OVERRIDE )
//* Evenement 		:	UE_MODIFIER - Extend
//* Auteur			:	YP
//* Date				:	13/08/1997 14:41:30
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification d'un groupe dans SIMPA 2.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re l'identifiant du groupe                                 */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//istPass.sTab [ 1 ] = String ( dw_1.GetItemNumber ( dw_1.ilLigneClick, "GROUPE.ID_GRP" ) )
istPass.sTab [ 1 ] = String ( dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_GRP" ) )
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Autorise la suppression d'un groupe.                             */
/*------------------------------------------------------------------*/
istPass.bSupprime	= TRUE

istPass.bInsert = False

f_OuvreTraitement ( w_t_sp_groupe, istPass )

end event

on ue_creer;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_sp_groupe ( OVERRIDE )
//* Evenement 		:	UE_CREER
//* Auteur			:	YP
//* Date				:	13/08/1997 14:40:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Cr$$HEX1$$e900$$ENDHEX$$ation d'un nouveau groupe dans SIMPA 2.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

istPass.bInsert = TRUE

f_OuvreTraitement ( w_t_sp_groupe, istPass )

end on

on w_a_sp_groupe.create
call super::create
end on

on w_a_sp_groupe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_retour from w_a_spb_groupe`pb_retour within w_a_sp_groupe
end type

type pb_interro from w_a_spb_groupe`pb_interro within w_a_sp_groupe
end type

type pb_creer from w_a_spb_groupe`pb_creer within w_a_sp_groupe
end type

type dw_1 from w_a_spb_groupe`dw_1 within w_a_sp_groupe
end type

event dw_1::constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_groupe
//* Evenement 		: constructor
//* Auteur			: PHG
//* Date				: 02/06/2006 14:41:53
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [PNOLIMIT]
//* Commentaires	: On enl$$HEX1$$e800$$ENDHEX$$ve la limite des 150 lignes
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

ilMaxLig = 0


end event

type pb_tri from w_a_spb_groupe`pb_tri within w_a_sp_groupe
end type

type pb_imprimer from w_a_spb_groupe`pb_imprimer within w_a_sp_groupe
string text = "&Imprimer"
end type

