HA$PBExportHeader$w_a_spb_detsin.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le param$$HEX1$$e900$$ENDHEX$$trage des d$$HEX1$$e900$$ENDHEX$$tails de sinistre.
forward
global type w_a_spb_detsin from w_a_spb_code_anc
end type
end forward

global type w_a_spb_detsin from w_a_spb_code_anc
string title = "Accueil - Gestion des d$$HEX1$$e900$$ENDHEX$$tails de sinistre"
end type
global w_a_spb_detsin w_a_spb_detsin

type variables
W_T_Spb_Codes_Plus iwFenetreAOuvrir
end variables

on ue_modifier;call w_a_spb_code_anc::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_detsin
//* Evenement 		:	UE_MODIFIER - Extend
//* Auteur			:	YP
//* Date				:	19/08/97 15:24:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification d'un Code
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

f_OuvreTraitement ( iwFenetreAOuvrir, istPass )

end on

on ue_config;call w_a_spb_code_anc::ue_config;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_detsin
//* Evenement 		:	Ue_Config
//* Auteur			:	Y. Picard
//* Date				:	19/08/1997 14:55:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialise Le type de code des d$$HEX1$$e900$$ENDHEX$$tails de sinistre.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Est $$HEX2$$e0002000$$ENDHEX$$True lorsque la colonne ID_TYP_CODE est visible.           */
/*------------------------------------------------------------------*/
ibVisible = False

/*------------------------------------------------------------------*/
/* Tri par d$$HEX1$$e900$$ENDHEX$$faut sur : l'identifiant du code.                      */
/*------------------------------------------------------------------*/
dw_1.isTri = "#2 A"

/*------------------------------------------------------------------*/
/* Le champ ID_TYP_CODE ne sera pas saisissable                     */
/*------------------------------------------------------------------*/
istPass.lTab [ 1 ] = 1

/*----------------------------------------------------------------------------*/
/* Indique sur quel code on travaille (D$$HEX1$$e900$$ENDHEX$$tail de Sinistre).                   */
/*----------------------------------------------------------------------------*/
Dw_1.isJointure = " AND sysadm.code.id_typ_code = '+DT'"
end on

on open;call w_a_spb_code_anc::open;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_detsin
//* Evenement 		:	OPEN - Extend
//* Auteur			:	YP
//* Date				:	19/06/97 15:21:08
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Organisation de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le  
//*					 	param$$HEX1$$e900$$ENDHEX$$trage des d$$HEX1$$e900$$ENDHEX$$tails de sinistre.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche                                             */
/*------------------------------------------------------------------*/
pb_Interro.istInterro.wAncetre					= This
pb_Interro.istInterro.sTitre 						= "Recherche des d$$HEX1$$e900$$ENDHEX$$tails de sinistre"
pb_Interro.istInterro.sDataObject				= "d_spb_int_code"
pb_Interro.istInterro.sCodeDw						= "CODE"

pb_Interro.istInterro.sData [ 1 ].sNom			= "id_code"
pb_Interro.istInterro.sData [ 1 ].sDbName		= "sysadm.code.id_code"
pb_Interro.istInterro.sData [ 1 ].sType		= "NUMBER"
pb_Interro.istInterro.sData [ 1 ].sOperande	= "="
pb_Interro.istInterro.sData [ 1 ].sMoteur		= "MSS"

pb_Interro.istInterro.sData [ 2 ].sNom			= "lib_code"
pb_Interro.istInterro.sData [ 2 ].sDbName		= "sysadm.code.lib_code"
pb_Interro.istInterro.sData [ 2 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 2 ].sOperande	= "="

pb_Interro.istInterro.sData [ 3 ].sNom			= "maj_le1"
pb_Interro.istInterro.sData [ 3 ].sDbName		= "sysadm.code.maj_le"
pb_Interro.istInterro.sData [ 3 ].sType		= "DATETIME"
pb_Interro.istInterro.sData [ 3 ].sOperande	= ">="

pb_Interro.istInterro.sData [ 4 ].sNom			= "maj_le2"
pb_Interro.istInterro.sData [ 4 ].sDbName		= "sysadm.code.maj_le"
pb_Interro.istInterro.sData [ 4 ].sType		= "DATETIME"
pb_Interro.istInterro.sData [ 4 ].sOperande	= "<="

pb_Interro.istInterro.sData [ 5 ].sNom			= "maj_par"
pb_Interro.istInterro.sData [ 5 ].sDbName		= "sysadm.code.maj_par"
pb_Interro.istInterro.sData [ 5 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 5 ].sOperande	= "="

/*------------------------------------------------------------------*/
/* Positionne la variable pour le titre des listes $$HEX2$$e0002000$$ENDHEX$$imprimer.      */
/*------------------------------------------------------------------*/
This.isTitreLst = "Base : " + itrtrans.database + ". Liste des D$$HEX1$$e900$$ENDHEX$$tails de Sinistre"
end on

on ue_creer;call w_a_spb_code_anc::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_detsin
//* Evenement 		:	UE_CREER - Extend
//* Auteur			:	YP
//* Date				:	19/08/97 15:23:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Cr$$HEX1$$e900$$ENDHEX$$ation d'un nouveau Code
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

istPass.sTab [ 1 ] = "+DT"

f_OuvreTraitement ( iwFenetreAOuvrir, istPass )
end on

on w_a_spb_detsin.create
call super::create
end on

on w_a_spb_detsin.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_retour from w_a_spb_code_anc`pb_retour within w_a_spb_detsin
end type

type pb_interro from w_a_spb_code_anc`pb_interro within w_a_spb_detsin
end type

type pb_creer from w_a_spb_code_anc`pb_creer within w_a_spb_detsin
end type

type dw_1 from w_a_spb_code_anc`dw_1 within w_a_spb_detsin
end type

event dw_1::constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_spb_detsin
//* Evenement 		: constructor
//* Auteur			: PHG
//* Date				: 02/06/2006 15:08:12
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

type pb_tri from w_a_spb_code_anc`pb_tri within w_a_spb_detsin
end type

type pb_imprimer from w_a_spb_code_anc`pb_imprimer within w_a_spb_detsin
end type

