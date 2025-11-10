HA$PBExportHeader$w_a_sp_type_carte.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le param$$HEX1$$e900$$ENDHEX$$trage des types de cartes
forward
global type w_a_sp_type_carte from w_8_accueil
end type
end forward

global type w_a_sp_type_carte from w_8_accueil
integer x = 0
integer y = 0
integer width = 3639
integer height = 2000
string title = "Accueil - Gestion des types de carte"
end type
global w_a_sp_type_carte w_a_sp_type_carte

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_type_carte
//* Evenement 		: Ue_Modifier
//* Auteur			: YP
//* Date				: 04/09/1997 15:18:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Modification d'un Type de Carte
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re l'identifiant du type de carte                          */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 FM
//istPass.sTab[1] 	= dw_1.GetItemString ( dw_1.ilLigneClick, "TYPE_CARTE.ID_TYPE_CARTE" )
istPass.sTab[1] 	= dw_1.GetItemString ( dw_1.ilLigneClick, "ID_TYPE_CARTE" )
//Fin Migration PB8-WYNIWYG-03/2006 FM


/*------------------------------------------------------------------*/
/* Autorise la suppression d'un type de carte.                      */
/*------------------------------------------------------------------*/

istPass.bSupprime	= TRUE


f_OuvreTraitement ( w_t_sp_type_carte, istPass )

end event

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_type_carte
//* Evenement 		: Open
//* Auteur			: YP
//* Date				: 04/09/1997 18:31:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Organisation de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le  
//*					  param$$HEX1$$e900$$ENDHEX$$trage des Types de Carte 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1	JCA		15/11/2006		DCMP 060825 - plus de limitation du nbr de ligne de retour
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//String sTables[1]		//Tableau pour les tables d'o$$HEX2$$f9002000$$ENDHEX$$proviennent les champs de la datawindow
String sTables[]		//Tableau pour les tables d'o$$HEX2$$f9002000$$ENDHEX$$proviennent les champs de la datawindow
//Fin Migration PB8-WYNIWYG-03/2006 FM

itrTrans = SQLCA

This.isTitreLst = "Base : " + itrTrans.DataBase + ". Liste des types de carte."

dw_1.ilMaxLig = 0 // #1

/*------------------------------------------------------------------*/
/* Description de la DW d'accueil                                   */
/*------------------------------------------------------------------*/

dw_1.istCol[1].sDbName		=	"sysadm.type_carte.id_type_carte"
dw_1.istCol[1].sType			=	"char(3)"
dw_1.istCol[1].sHeaderName	=	"Type"
dw_1.istCol[1].ilargeur		=	5
dw_1.istCol[1].sAlignement	=	"2"
dw_1.istCol[1].sInvisible	= 	"N"

dw_1.istCol[2].sDbName		=	"sysadm.type_carte.lib_type_carte"
dw_1.istCol[2].sType			=	"char(35)"
dw_1.istCol[2].sHeaderName	=	"Libell$$HEX1$$e900$$ENDHEX$$"
dw_1.istCol[2].ilargeur		=	35
dw_1.istCol[2].sAlignement	=	"0"
dw_1.istCol[2].sInvisible	= 	"N"

dw_1.istCol[3].sDbName		=	"sysadm.type_carte.maj_le"
dw_1.istCol[3].sType			=	"datetime"
dw_1.istCol[3].sHeaderName	=	"Maj le"
dw_1.istCol[3].sFormat		=	"dd/mm/yyyy hh:mm:ss"
dw_1.istCol[3].ilargeur		=	19
dw_1.istCol[3].sAlignement	=	"2"
dw_1.istCol[3].sInvisible	= 	"N"

dw_1.istCol[4].sDbName		=	"sysadm.type_carte.maj_par"
dw_1.istCol[4].sType			=	"char(4)"
dw_1.istCol[4].sHeaderName	=	"Par"
dw_1.istCol[4].ilargeur		=	4
dw_1.istCol[4].sAlignement	=	"2"
dw_1.istCol[4].sInvisible	= 	"N"


sTables[ 1 ]	= "type_carte"


/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/

dw_1.Uf_Creer_Tout( dw_1.istCol, sTables, itrTrans )

wf_Construire_Chaine_Tri()


/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche                                             */
/*------------------------------------------------------------------*/

pb_Interro.istInterro.wAncetre				= This
pb_Interro.istInterro.sTitre 					= "Recherche des types de carte"
pb_Interro.istInterro.sDataObject			= "d_sp_int_type_carte"
pb_Interro.istInterro.sCodeDw					= "TYPE_CARTE"

pb_Interro.istInterro.sData[1].sNom			= "id_type_carte"
pb_Interro.istInterro.sData[1].sDbName		= "sysadm.type_carte.id_type_carte"
pb_Interro.istInterro.sData[1].sType		= "STRING"
pb_Interro.istInterro.sData[1].sOperande	= "="

pb_Interro.istInterro.sData[2].sNom			= "lib_type_carte"
pb_Interro.istInterro.sData[2].sDbName		= "sysadm.type_carte.lib_type_carte"
pb_Interro.istInterro.sData[2].sType		= "STRING"
pb_Interro.istInterro.sData[2].sOperande	= "="


/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/

istPass.trTrans 	= itrTrans
istPass.bControl	= False		// Utilisation de VALIDE uniquement

end event

on ue_creer;call w_8_accueil::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_type_carte
//* Evenement 		: Ue_Creer
//* Auteur			: YP
//* Date				: 04/09/1997 15:12:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Cr$$HEX1$$e900$$ENDHEX$$ation d'un nouveau Type de Carte
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

f_OuvreTraitement ( w_t_sp_type_carte, istPass )

end on

on ue_preparer_interro;call w_8_accueil::ue_preparer_interro;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_type_carte
//* Evenement 		: ue_preparer_interro
//* Auteur			: YP
//* Date				: 04/09/1997 18:45:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialise l'object de transaction pour la dddw
//*					  des Types de Carte
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild		dwTypeCarte

w_Interro.dw_1.Uf_SetTransObject ( itrTrans )

W_Interro.Dw_1.GetChild ( "id_type_carte", dwTypeCarte )

dwTypeCarte.SetTransObject ( itrTrans )
dwTypeCarte.Retrieve ( )

end on

on w_a_sp_type_carte.create
call super::create
end on

on w_a_sp_type_carte.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_retour from w_8_accueil`pb_retour within w_a_sp_type_carte
end type

type pb_interro from w_8_accueil`pb_interro within w_a_sp_type_carte
end type

type pb_creer from w_8_accueil`pb_creer within w_a_sp_type_carte
end type

type dw_1 from w_8_accueil`dw_1 within w_a_sp_type_carte
end type

type pb_tri from w_8_accueil`pb_tri within w_a_sp_type_carte
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_sp_type_carte
boolean visible = true
boolean enabled = true
end type

