HA$PBExportHeader$w_a_sp_carte.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le param$$HEX1$$e800$$ENDHEX$$trage des cartes
forward
global type w_a_sp_carte from w_8_accueil
end type
end forward

global type w_a_sp_carte from w_8_accueil
integer x = 0
integer y = 0
integer width = 3639
integer height = 2000
string title = "Accueil - Gestion des cartes"
end type
global w_a_sp_carte w_a_sp_carte

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_carte
//* Evenement 		: ue_modifier
//* Auteur			: YP
//* Date				: 04/09/97 16:21:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: modification d'un enregistrement
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re l'identifiant de la carte                               */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 FM
//istPass.sTab[1] 	= String ( dw_1.GetItemNumber ( dw_1.ilLigneClick, "CARTE.ID_CARTE" ) )
istPass.sTab[1] 	= String ( dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_CARTE" ) )
//Fin Migration PB8-WYNIWYG-03/2006 FM


/*------------------------------------------------------------------*/
/* Autorise la suppression d'une carte.                             */
/*------------------------------------------------------------------*/

istPass.bSupprime	= TRUE

f_OuvreTraitement ( w_t_sp_carte, istPass )
end event

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_carte
//* Evenement 		: Open
//* Auteur			: YP
//* Date				: 04/09/97 16:13:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR		Date				Modification
//* #1	JCA		15/11/2006		DCMP 060825 - plus de limitation du nbr de ligne de retour
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//String sTables [ 2 ]		// Tables du SELECT
String sTables []		// Tables du SELECT
//Fin Migration PB8-WYNIWYG-03/2006 FM

itrTrans = SQLCA

This.isTitreLst = "Base : " + itrTrans.DataBase + ". Liste des cartes."

dw_1.ilMaxLig = 0 // #1

/*------------------------------------------------------------------*/
/*   Description de la DW d'accueil                                 */
/*------------------------------------------------------------------*/


dw_1.istCol[1].sDbName		=	"sysadm.carte.id_carte"
dw_1.istCol[1].sType			=	"Number"
dw_1.istCol[1].sHeaderName	=	"Id Carte"
dw_1.istCol[1].ilargeur		=	8
dw_1.istCol[1].sAlignement	=	"2"
dw_1.istCol[1].sInvisible	= 	"N"

dw_1.istCol[2].sDbName		=	"sysadm.carte.lib_carte"
dw_1.istCol[2].sType			=	"char(35)"
dw_1.istCol[2].sHeaderName	=	"Libell$$HEX1$$e900$$ENDHEX$$"
dw_1.istCol[2].ilargeur		=	20
dw_1.istCol[2].sAlignement	=	"0"
dw_1.istCol[2].sInvisible	= 	"N"

dw_1.istCol[3].sDbName		=	"sysadm.groupe.lib_grp"
dw_1.istCol[3].sType			=	"char(35)"
dw_1.istCol[3].sHeaderName	=	"Etablissement"
dw_1.istCol[3].ilargeur		=	20
dw_1.istCol[3].sAlignement	=	"0"
dw_1.istCol[3].sInvisible	= 	"N"

dw_1.istCol[4].sDbName		=	"sysadm.carte.val_rg_mini"
dw_1.istCol[4].sType			=	"char(19)"
dw_1.istCol[4].sHeaderName	=	"Rg Mini"
dw_1.istCol[4].sFormat     =  "@@@@-@@@@"
dw_1.istCol[4].ilargeur		=	10
dw_1.istCol[4].sAlignement	=	"2"
dw_1.istCol[4].sInvisible	= 	"N"

dw_1.istCol[5].sDbName		=	"sysadm.carte.val_rg_max"
dw_1.istCol[5].sType			=	"char(19)"
dw_1.istCol[5].sHeaderName	=	"Rg Maxi"
dw_1.istCol[5].sFormat     =  "@@@@-@@@@"
dw_1.istCol[5].ilargeur		=	10
dw_1.istCol[5].sAlignement	=	"2"
dw_1.istCol[5].sInvisible	= 	"N"

dw_1.istCol[6].sDbName		=	"sysadm.carte.maj_le"
dw_1.istCol[6].sType			=	"Datetime"
dw_1.istCol[6].sHeaderName	=	"Maj Le"
dw_1.istCol[6].sFormat		=	"dd/mm/yyyy hh:mm:ss"
dw_1.istCol[6].ilargeur		=	20
dw_1.istCol[6].sAlignement	=	"2"
dw_1.istCol[6].sInvisible	= 	"N"

dw_1.istCol[7].sDbName		=	"sysadm.carte.maj_par"
dw_1.istCol[7].sType			=	"char(4)"
dw_1.istCol[7].sHeaderName	=	"Par"
dw_1.istCol[7].ilargeur		=	4
dw_1.istCol[7].sAlignement	=	"2"
dw_1.istCol[7].sInvisible	= 	"N"

sTables [ 1 ] = "carte"
sTables [ 2 ] = "groupe"

/*------------------------------------------------------------------*/
/*  Jointure entre les 2 tables ci-dessus :                         */
/*------------------------------------------------------------------*/
dw_1.isJointure = "And sysadm.groupe.id_grp = sysadm.carte.id_grp"

/*------------------------------------------------------------------*/
/* Tri par d$$HEX1$$e900$$ENDHEX$$faut de la Data Window d'accueil.                      */
/*------------------------------------------------------------------*/
Dw_1.isTri = "#1 A"

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/
dw_1.Uf_Creer_Tout( dw_1.istCol, sTables, itrTrans )

wf_Construire_Chaine_Tri()

/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche                                             */
/*------------------------------------------------------------------*/
pb_Interro.istInterro.wAncetre				= This
pb_Interro.istInterro.sTitre 					= "Recherche des cartes"
pb_Interro.istInterro.sDataObject			= "d_sp_int_carte"
pb_Interro.istInterro.sCodeDw					= "CARTE"

pb_Interro.istInterro.sData[1].sNom			= "id_carte"
pb_Interro.istInterro.sData[1].sDbName		= "sysadm.carte.id_carte"
pb_Interro.istInterro.sData[1].sType		= "NUMBER"
pb_Interro.istInterro.sData[1].sOperande	= "="
pb_Interro.istInterro.sData[1].sMoteur		= "MSS"

pb_Interro.istInterro.sData[2].sNom			= "id_grp"
pb_Interro.istInterro.sData[2].sDbName		= "sysadm.carte.id_grp"
pb_Interro.istInterro.sData[2].sType		= "NUMBER"
pb_Interro.istInterro.sData[2].sOperande	= "="
pb_Interro.istInterro.sData[2].sMoteur		= "MSS"

pb_Interro.istInterro.sData[3].sNom			= "id_type_carte"
pb_Interro.istInterro.sData[3].sDbName		= "sysadm.carte.id_type_carte"
pb_Interro.istInterro.sData[3].sType		= "STRING"
pb_Interro.istInterro.sData[3].sOperande	= "="

pb_Interro.istInterro.sData[4].sNom			= "val_rg_mini"
pb_Interro.istInterro.sData[4].sDbName		= "sysadm.carte.val_rg_mini"
pb_Interro.istInterro.sData[4].sType		= "STRING"
pb_Interro.istInterro.sData[4].sOperande	= "="

pb_Interro.istInterro.sData[5].sNom			= "val_rg_max"
pb_Interro.istInterro.sData[5].sDbName		= "sysadm.carte.val_rg_max"
pb_Interro.istInterro.sData[5].sType		= "STRING"
pb_Interro.istInterro.sData[5].sOperande	= "="

/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= itrTrans
istPass.bControl	= False		// Utilisation du bouton VALIDER
end event

on ue_preparer_interro;call w_8_accueil::ue_preparer_interro;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_carte
//* Evenement 		: ue_preparer_interro
//* Auteur			: YP
//* Date				: 04/09/1997 16:19:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialise l'object de transaction pour la dddw
//*					  des types de cartes et des $$HEX1$$e900$$ENDHEX$$tablissements.
//* Commentaires	: Aucun
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
DataWindowChild		dwTypeDeCarte		// DDDW du type de carte
DataWindowChild		dwGrp					// DDDW de l'$$HEX1$$e900$$ENDHEX$$tablissement


W_Interro.Dw_1.GetChild ( "id_grp", dwGrp )
W_Interro.Dw_1.GetChild ( "id_type_carte", dwTypeDeCarte )


dwGrp.SetTransObject ( itrTrans )
dwGrp.Retrieve ( )

dwTypeDeCarte.SetTransObject ( itrTrans )
dwTypeDeCarte.Retrieve ( )

end on

on w_a_sp_carte.create
call super::create
end on

on w_a_sp_carte.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

on ue_creer;call w_8_accueil::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_carte
//* Evenement 		: ue_creer
//* Auteur			: YP
//* Date				: 04/09/97 16:19:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Cr$$HEX1$$e900$$ENDHEX$$ation d'un enregistrement
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


f_OuvreTraitement ( w_t_sp_carte, istPass )
end on

type pb_retour from w_8_accueil`pb_retour within w_a_sp_carte
end type

type pb_interro from w_8_accueil`pb_interro within w_a_sp_carte
end type

type pb_creer from w_8_accueil`pb_creer within w_a_sp_carte
end type

type dw_1 from w_8_accueil`dw_1 within w_a_sp_carte
end type

event dw_1::rbuttondown;//Migration PB8-WYNIWYG-03/2006 FM
//ce code remplace le code de l'anc$$HEX1$$ea00$$ENDHEX$$tre, 
//il permet la s$$HEX1$$e900$$ENDHEX$$lection de la ligne sur le click droit

If Row > 0 Then
	This.SetRow(Row)
	SelectRow(Row, True)
end if

call super::rButtonDown

Return AncestorReturnValue

//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event dw_1::constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_carte
//* Evenement 		: constructor
//* Auteur			: PHG
//* Date				: 02/06/2006 14:39:22
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

type pb_tri from w_8_accueil`pb_tri within w_a_sp_carte
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_sp_carte
boolean visible = true
boolean enabled = true
end type

