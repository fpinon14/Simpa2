HA$PBExportHeader$w_a_spb_codes_car.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le param$$HEX1$$e900$$ENDHEX$$trage des codes alphanumriques.
forward
global type w_a_spb_codes_car from w_a_spb_code_anc
end type
end forward

global type w_a_spb_codes_car from w_a_spb_code_anc
string title = "Accueil - Gestion des codes alphanum$$HEX1$$e900$$ENDHEX$$riques"
end type
global w_a_spb_codes_car w_a_spb_codes_car

on ue_config;call w_a_spb_code_anc::ue_config;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_codes_car
//* Evenement 		:	ue_config
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	12/06/97 12:30:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet d'utiliser la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour la gestion
//*						des codes, des pi$$HEX1$$e800$$ENDHEX$$ces, des motifs de refus, ...
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

event open;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_codes_car
//* Evenement 		:	OPEN - OVERRIDE
//* Auteur			:	YP
//* Date				:	19/08/97 14:12:08
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Organisation de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le  
//*					 	param$$HEX1$$e900$$ENDHEX$$trage des Codes alphanum$$HEX1$$e900$$ENDHEX$$riques des applications SPB.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1	JCA		15/11/2006		DCMP 060825 - plus de limitation du nbr de ligne de retour
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//String sTables [ 1 ]		// Tableau pour les tables d'o$$HEX2$$f9002000$$ENDHEX$$proviennent les champs de la Dw.
String sTables []		// Tableau pour les tables d'o$$HEX2$$f9002000$$ENDHEX$$proviennent les champs de la Dw.
//Fin Migration PB8-WYNIWYG-03/2006 FM

CALL w_accueil::OPEN

/*------------------------------------------------------------------*/
/* Affecte l'object de transaction $$HEX2$$e0002000$$ENDHEX$$la variable d'instance.        */
/*------------------------------------------------------------------*/
iTrTrans = SQLCA

/*------------------------------------------------------------------*/
/* porte la limitation du nombre de lignes s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$1000 au  */
/* lieu des 150 par d$$HEX1$$e900$$ENDHEX$$faut.                                         */
/*------------------------------------------------------------------*/
dw_1.ilMaxLig = 0 // #1

/*------------------------------------------------------------------*/
/* Positionne la variable pour le titre des listes $$HEX2$$e0002000$$ENDHEX$$imprimer.      */
/*------------------------------------------------------------------*/
This.isTitreLst = "Base : " + itrtrans.database + ". Liste des Codes Alphanum$$HEX1$$e900$$ENDHEX$$riques"

/*------------------------------------------------------------------*/
/* Permet de configurer la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour les besion de la  */
/* gestion des types de codes, des codes pi$$HEX1$$e800$$ENDHEX$$ces, des natures        */
/* d'exclusion.                                                     */
/*------------------------------------------------------------------*/
This.TriggerEvent ( "ue_config" )


/*------------------------------------------------------------------*/
/* Description de la DW d'accueil                                   */
/*------------------------------------------------------------------*/
dw_1.istCol [ 1 ].sDbName		=	"sysadm.code_car.id_typ_code"
dw_1.istCol [ 1 ].sType			=	"char(3)"
dw_1.istCol [ 1 ].sHeaderName	=	"Type"
dw_1.istCol [ 1 ].ilargeur		=	3
dw_1.istCol [ 1 ].sAlignement	=	"2"

If ibVisible	Then

	dw_1.istCol [ 1 ].sInvisible	= 	"N"

Else

	dw_1.istCol [ 1 ].sInvisible	= 	"O"

End If


dw_1.istCol [ 2 ].sDbName		=	"sysadm.code_car.id_code"
dw_1.istCol [ 2 ].sType			=	"char(6)"
dw_1.istCol [ 2 ].sHeaderName	=	"Code"
dw_1.istCol [ 2 ].ilargeur		=	6
dw_1.istCol [ 2 ].sAlignement	=	"2"
dw_1.istCol [ 2 ].sInvisible	= 	"N"

dw_1.istCol [ 3 ].sDbName		=	"sysadm.code_car.lib_code"
dw_1.istCol [ 3 ].sType			=	"char(35)"
dw_1.istCol [ 3 ].sHeaderName	=	"Libell$$HEX1$$e900$$ENDHEX$$"
dw_1.istCol [ 3 ].ilargeur		=	35
dw_1.istCol [ 3 ].sAlignement	=	"0"
dw_1.istCol [ 3 ].sInvisible	= 	"N"

dw_1.istCol [ 4 ].sDbName		=	"sysadm.code_car.maj_le"
dw_1.istCol [ 4 ].sType			=	"datetime"
dw_1.istCol [ 4 ].sHeaderName	=	"Maj le"
dw_1.istCol [ 4 ].sFormat		=	"dd/mm/yyyy hh:mm:ss"
dw_1.istCol [ 4 ].ilargeur		=	19
dw_1.istCol [ 4 ].sAlignement	=	"2"
dw_1.istCol [ 4 ].sInvisible	= 	"N"

dw_1.istCol [ 5 ].sDbName		=	"sysadm.code_car.maj_par"
dw_1.istCol [ 5 ].sType			=	"char(4)"
dw_1.istCol [ 5 ].sHeaderName	=	"Par"
dw_1.istCol [ 5 ].ilargeur		=	4
dw_1.istCol [ 5 ].sAlignement	=	"2"
dw_1.istCol [ 5 ].sInvisible	= 	"N"

sTables [  1  ]	= "code_car"

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/
dw_1.Uf_Creer_Tout( dw_1.istCol, sTables, itrTrans )


wf_Construire_Chaine_Tri()

/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= itrTrans
istPass.bControl	= False		// Utilisation de VALIDE uniquement

/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche                                             */
/*------------------------------------------------------------------*/
pb_Interro.istInterro.wAncetre					= This
pb_Interro.istInterro.sTitre 						= "Recherche des codes alphanum$$HEX1$$e900$$ENDHEX$$riques"
pb_Interro.istInterro.sDataObject				= "d_spb_int_codes_car"
pb_Interro.istInterro.sCodeDw						= "CODE_CAR"

pb_Interro.istInterro.sData [ 1 ].sNom			= "id_typ_code"
pb_Interro.istInterro.sData [ 1 ].sDbName		= "sysadm.code_car.id_typ_code"
pb_Interro.istInterro.sData [ 1 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 1 ].sOperande	= "="

pb_Interro.istInterro.sData [ 2 ].sNom			= "id_code"
pb_Interro.istInterro.sData [ 2 ].sDbName		= "sysadm.code_car.id_code"
pb_Interro.istInterro.sData [ 2 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 2 ].sOperande	= "="

pb_Interro.istInterro.sData [ 3 ].sNom			= "lib_code"
pb_Interro.istInterro.sData [ 3 ].sDbName		= "sysadm.code_car.lib_code"
pb_Interro.istInterro.sData [ 3 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 3 ].sOperande	= "="

pb_Interro.istInterro.sData [ 4 ].sNom			= "maj_le1"
pb_Interro.istInterro.sData [ 4 ].sDbName		= "sysadm.code_car.maj_le"
pb_Interro.istInterro.sData [ 4 ].sType		= "DATETIME"
pb_Interro.istInterro.sData [ 4 ].sOperande	= ">="

pb_Interro.istInterro.sData [ 5 ].sNom			= "maj_le2"
pb_Interro.istInterro.sData [ 5 ].sDbName		= "sysadm.code_car.maj_le"
pb_Interro.istInterro.sData [ 5 ].sType		= "DATETIME"
pb_Interro.istInterro.sData [ 5 ].sOperande	= "<="

pb_Interro.istInterro.sData [ 6 ].sNom			= "maj_par"
pb_Interro.istInterro.sData [ 6 ].sDbName		= "sysadm.code_car.maj_par"
pb_Interro.istInterro.sData [ 6 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 6 ].sOperande	= "="
end event

event ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_codes_car
//* Evenement 		:	UE_MODIFIER - OVERRIDE
//* Auteur			:	YP
//* Date				:	19/08/97 14:017:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification d'un Code
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

istPass.bInsert = False

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re l'identifiant du code                                   */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//istPass.sTab [ 1 ] = dw_1.GetItemString ( dw_1.ilLigneClick, "CODE_CAR.ID_TYP_CODE" 	)
//istPass.sTab [ 2 ] = dw_1.GetItemString ( dw_1.ilLigneClick, "CODE_CAR.ID_CODE" 		)
istPass.sTab [ 1 ] = dw_1.GetItemString ( dw_1.ilLigneClick, "ID_TYP_CODE" 	)
istPass.sTab [ 2 ] = dw_1.GetItemString ( dw_1.ilLigneClick, "ID_CODE" 		)
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Autorise la suppression d'un code.                               */
/*------------------------------------------------------------------*/
istPass.bSupprime	= TRUE

f_OuvreTraitement ( W_T_Spb_Codes_Car, istPass )

end event

on ue_creer;call w_a_spb_code_anc::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_codes_car
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

f_OuvreTraitement ( W_T_Spb_Codes_Car, istPass )

end on

on w_a_spb_codes_car.create
call super::create
end on

on w_a_spb_codes_car.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_retour from w_a_spb_code_anc`pb_retour within w_a_spb_codes_car
end type

type pb_interro from w_a_spb_code_anc`pb_interro within w_a_spb_codes_car
end type

type pb_creer from w_a_spb_code_anc`pb_creer within w_a_spb_codes_car
end type

type dw_1 from w_a_spb_code_anc`dw_1 within w_a_spb_codes_car
end type

type pb_tri from w_a_spb_code_anc`pb_tri within w_a_spb_codes_car
end type

type pb_imprimer from w_a_spb_code_anc`pb_imprimer within w_a_spb_codes_car
end type

