HA$PBExportHeader$w_a_spb_codes_num.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le param$$HEX1$$e900$$ENDHEX$$trage des codes num$$HEX1$$e900$$ENDHEX$$riques.
forward
global type w_a_spb_codes_num from w_a_spb_code_anc
end type
end forward

global type w_a_spb_codes_num from w_a_spb_code_anc
string title = "Accueil - Gestion des codes num$$HEX1$$e900$$ENDHEX$$riques"
end type
global w_a_spb_codes_num w_a_spb_codes_num

on ue_config;call w_a_spb_code_anc::ue_config;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_codes_num
//* Evenement 		:	ue_config
//* Auteur			:	YP
//* Date				:	12/06/97 12:30:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet d'utiliser la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour la gestion
//*						des codes, des pi$$HEX1$$e800$$ENDHEX$$ces, des motifs de refus.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Est $$HEX2$$e0002000$$ENDHEX$$True lorsque la colonne ID_TYP_CODE est visible.           */
/*------------------------------------------------------------------*/
ibVisible = True

/*------------------------------------------------------------------*/
/* Tri par d$$HEX1$$e900$$ENDHEX$$faut sur : le type de code et l'identifiant du code.   */
/*------------------------------------------------------------------*/
dw_1.isTri = "#1 A, #2 A"

/*------------------------------------------------------------------*/
/* Le champ ID_TYP_CODE sera saisissables                           */
/*------------------------------------------------------------------*/
istPass.lTab [ 1 ] = 0
end on

on open;call w_a_spb_code_anc::open;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_codes_num
//* Evenement 		:	OPEN - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	12/06/97 13:20:08
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Organisation de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le  
//*					 	param$$HEX1$$e900$$ENDHEX$$trage des Codes Num$$HEX1$$e900$$ENDHEX$$riques.
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
pb_Interro.istInterro.sTitre 						= "Recherche des codes num$$HEX1$$e900$$ENDHEX$$riques"
pb_Interro.istInterro.sDataObject				= "d_spb_int_codes_num"
pb_Interro.istInterro.sCodeDw						= "CODE"

pb_Interro.istInterro.sData [ 1 ].sNom			= "id_typ_code"
pb_Interro.istInterro.sData [ 1 ].sDbName		= "sysadm.code.id_typ_code"
pb_Interro.istInterro.sData [ 1 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 1 ].sOperande	= "="

pb_Interro.istInterro.sData [ 2 ].sNom			= "id_code"
pb_Interro.istInterro.sData [ 2 ].sDbName		= "sysadm.code.id_code"
pb_Interro.istInterro.sData [ 2 ].sType		= "NUMBER"
pb_Interro.istInterro.sData [ 2 ].sOperande	= "="
pb_Interro.istInterro.sData [ 2 ].sMoteur		= "MSS"

pb_Interro.istInterro.sData [ 3 ].sNom			= "lib_code"
pb_Interro.istInterro.sData [ 3 ].sDbName		= "sysadm.code.lib_code"
pb_Interro.istInterro.sData [ 3 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 3 ].sOperande	= "="

pb_Interro.istInterro.sData [ 4 ].sNom			= "maj_le1"
pb_Interro.istInterro.sData [ 4 ].sDbName		= "sysadm.code.maj_le"
pb_Interro.istInterro.sData [ 4 ].sType		= "DATETIME"
pb_Interro.istInterro.sData [ 4 ].sOperande	= ">="

pb_Interro.istInterro.sData [ 5 ].sNom			= "maj_le2"
pb_Interro.istInterro.sData [ 5 ].sDbName		= "sysadm.code.maj_le"
pb_Interro.istInterro.sData [ 5 ].sType		= "DATETIME"
pb_Interro.istInterro.sData [ 5 ].sOperande	= "<="

pb_Interro.istInterro.sData [ 6 ].sNom			= "maj_par"
pb_Interro.istInterro.sData [ 6 ].sDbName		= "sysadm.code.maj_par"
pb_Interro.istInterro.sData [ 6 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 6 ].sOperande	= "="

/*------------------------------------------------------------------*/
/* Positionne la variable pour le titre des listes $$HEX2$$e0002000$$ENDHEX$$imprimer.      */
/*------------------------------------------------------------------*/
This.isTitreLst = "Base : " + itrtrans.database + ". Liste des Codes Num$$HEX1$$e900$$ENDHEX$$riques"
end on

on ue_creer;call w_a_spb_code_anc::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_codes_num
//* Evenement 		:	UE_CREER - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	11/06/97 12:05:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Cr$$HEX1$$e900$$ENDHEX$$ation d'un nouveau Code
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

f_OuvreTraitement ( W_T_Spb_Codes_Num, istPass )

end on

on ue_modifier;call w_a_spb_code_anc::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_codes_num
//* Evenement 		:	UE_MODIFIER - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	11/06/97 12:06:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification d'un Code
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

f_OuvreTraitement ( W_T_Spb_Codes_Num, istPass )

end on

on w_a_spb_codes_num.create
call super::create
end on

on w_a_spb_codes_num.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_retour from w_a_spb_code_anc`pb_retour within w_a_spb_codes_num
end type

type pb_interro from w_a_spb_code_anc`pb_interro within w_a_spb_codes_num
end type

type pb_creer from w_a_spb_code_anc`pb_creer within w_a_spb_codes_num
end type

type dw_1 from w_a_spb_code_anc`dw_1 within w_a_spb_codes_num
end type

event dw_1::constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_spb_codes_num
//* Evenement 		: constructor
//* Auteur			: PHG
//* Date				: 02/06/2006 14:59:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [PNOLIMIT]
//* Commentaires	: On porte la limite $$HEX2$$e0002000$$ENDHEX$$1000 lignes, comme pour code_car
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	JCA		15/11/2006		DCMP 060825 - plus de limitation du nbr de ligne de retour
//*-----------------------------------------------------------------


ilMaxLig = 0 // #1

end event

type pb_tri from w_a_spb_code_anc`pb_tri within w_a_spb_codes_num
end type

type pb_imprimer from w_a_spb_code_anc`pb_imprimer within w_a_spb_codes_num
end type

