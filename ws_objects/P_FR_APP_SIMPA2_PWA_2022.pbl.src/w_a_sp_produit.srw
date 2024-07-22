HA$PBExportHeader$w_a_sp_produit.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le param$$HEX1$$e800$$ENDHEX$$trage des produits
forward
global type w_a_sp_produit from w_8_accueil
end type
end forward

global type w_a_sp_produit from w_8_accueil
integer x = 0
integer y = 0
integer width = 3639
integer height = 2000
string title = "Accueil - Gestion des produits"
end type
global w_a_sp_produit w_a_sp_produit

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_a_sp_produit
//* Evenement 		:	ue_modifier 
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	19/06/97 14:30:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification d'un enregistrement
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ 	PAR		Date		Modification
//*-----------------------------------------------------------------

SetPointer ( HourGlass! )

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re l'identifiant du produit                                */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//istPass.sTab [ 1 ] = String ( dw_1.GetItemNumber ( dw_1.ilLigneClick, "PRODUIT.ID_PROD" ) )
istPass.sTab [ 1 ] = String ( dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_PROD" ) )
//Fin Migration PB8-WYNIWYG-03/2006 FM


/*------------------------------------------------------------------*/
/* Autorise la suppression d'un produit.                            */
/*------------------------------------------------------------------*/
istPass.bSupprime	= TRUE

f_OuvreTraitement ( w_tm_sp_produit, istPass )

end event

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_a_sp_produit
//* Evenement 		:	open - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	19/06/97 14:25:26
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1	JCA		15/11/2006		DCMP 060825 - plus de limitation du nbr de ligne de retour
//* #2	FPI		23/01/2009		[DCMP080728] Agrandissement lib_long
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//String sTables [ 2 ]			// Tables du SELECT
String sTables []			// Tables du SELECT
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Affecte l'object de transaction $$HEX2$$e0002000$$ENDHEX$$la variable d'instance.        */
/*------------------------------------------------------------------*/
itrTrans = SQLCA

/*------------------------------------------------------------------*/
/* porte la limitation du nombre de lignes s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$1000 au  */
/* lieu des 150 par d$$HEX1$$e900$$ENDHEX$$faut.                                         */
/*------------------------------------------------------------------*/
dw_1.ilMaxLig = 0 // #1

/*------------------------------------------------------------------*/
/* Positionne la variable pour le titre des listes $$HEX2$$e0002000$$ENDHEX$$imprimer.      */
/*------------------------------------------------------------------*/
This.isTitreLst = "Base : " + itrtrans.database + ". Liste des Produits"

/*------------------------------------------------------------------*/
/*   Description de la DW d'accueil                                 */
/*------------------------------------------------------------------*/


dw_1.istCol[1].sDbName		=	"sysadm.produit.id_prod"
dw_1.istCol[1].sType			=	"number"
dw_1.istCol[1].sHeaderName	=	"Id Prod"
dw_1.istCol[1].sFormat		=	"00000"
dw_1.istCol[1].ilargeur		=	8
dw_1.istCol[1].sAlignement	=	"2"
dw_1.istCol[1].sInvisible	= 	"N"

dw_1.istCol[2].sDbName		=	"sysadm.produit.lib_long"
//dw_1.istCol[2].sType			=	"char(35)"
dw_1.istCol[2].sType			=	"char(65)" // #2
dw_1.istCol[2].sHeaderName	=	"Libell$$HEX1$$e900$$ENDHEX$$"
dw_1.istCol[2].ilargeur		=	30
dw_1.istCol[2].sAlignement	=	"0"
dw_1.istCol[2].sInvisible	= 	"N"

dw_1.istCol[3].sDbName		=	"sysadm.departement.lib_dept"
dw_1.istCol[3].sType			=	"char(35)"
dw_1.istCol[3].sHeaderName	=	"D$$HEX1$$e900$$ENDHEX$$partement"
dw_1.istCol[3].ilargeur		=	30
dw_1.istCol[3].sAlignement	=	"0"
dw_1.istCol[3].sInvisible	= 	"N"

dw_1.istCol[4].sDbName		=	"sysadm.produit.maj_le"
dw_1.istCol[4].sType			=	"Datetime"
dw_1.istCol[4].sHeaderName	=	"Maj Le"
dw_1.istCol[4].sFormat		=	"dd/mm/yyyy hh:mm:ss"
dw_1.istCol[4].ilargeur		=	20
dw_1.istCol[4].sAlignement	=	"2"
dw_1.istCol[4].sInvisible	= 	"N"

dw_1.istCol[5].sDbName		=	"sysadm.produit.maj_par"
dw_1.istCol[5].sType			=	"char(4)"
dw_1.istCol[5].sHeaderName	=	"Par"
dw_1.istCol[5].ilargeur		=	4
dw_1.istCol[5].sAlignement	=	"2"
dw_1.istCol[5].sInvisible	= 	"N"

sTables [ 1 ] = "produit"
sTables [ 2 ] = "departement"

/*------------------------------------------------------------------*/
/*  Jointure entre les 2 tables ci-dessus :                         */
/*------------------------------------------------------------------*/
dw_1.isJointure = "And sysadm.produit.id_dept = sysadm.departement.id_dept"

/*------------------------------------------------------------------*/
/* Tri : colonne des produits                                       */
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
pb_Interro.istInterro.sTitre 					= "Recherche des produits"
pb_Interro.istInterro.sDataObject			= "d_sp_int_produit"
pb_Interro.istInterro.sCodeDw					= "PRODUIT"

pb_Interro.istInterro.sData[1].sNom			= "id_prod"
pb_Interro.istInterro.sData[1].sDbName		= "sysadm.produit.id_prod"
pb_Interro.istInterro.sData[1].sType		= "NUMBER"
pb_Interro.istInterro.sData[1].sOperande	= "="
pb_Interro.istInterro.sData[1].sMoteur		= "MSS"

pb_Interro.istInterro.sData[2].sNom			= "lib_long"
pb_Interro.istInterro.sData[2].sDbName		= "sysadm.produit.lib_long"
pb_Interro.istInterro.sData[2].sType		= "STRING"
pb_Interro.istInterro.sData[2].sOperande	= "="

pb_Interro.istInterro.sData[3].sNom			= "maj_le1"
pb_Interro.istInterro.sData[3].sDbName		= "sysadm.produit.maj_le"
pb_Interro.istInterro.sData[3].sType		= "DATETIME"
pb_Interro.istInterro.sData[3].sOperande	= ">="

pb_Interro.istInterro.sData[4].sNom			= "maj_le2"
pb_Interro.istInterro.sData[4].sDbName		= "sysadm.produit.maj_le"
pb_Interro.istInterro.sData[4].sType		= "DATETIME"
pb_Interro.istInterro.sData[4].sOperande	= "<="

pb_Interro.istInterro.sData[5].sNom			= "maj_par"
pb_Interro.istInterro.sData[5].sDbName		= "sysadm.produit.maj_par"
pb_Interro.istInterro.sData[5].sType		= "STRING"
pb_Interro.istInterro.sData[5].sOperande	= "="

/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= itrTrans
istPass.bControl	= TRUE		// Utilisation du bouton CONTROLER
end event

on ue_creer;call w_8_accueil::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_a_sp_produit
//* Evenement 		:	ue_creer
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	19/06/97 14:31:26
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Cr$$HEX1$$e900$$ENDHEX$$ation d'un enregistrement
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

SetPointer ( HourGlass! )

f_OuvreTraitement ( w_tm_sp_produit, istPass )
end on

on w_a_sp_produit.create
call super::create
end on

on w_a_sp_produit.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type cb_debug from w_8_accueil`cb_debug within w_a_sp_produit
end type

type pb_retour from w_8_accueil`pb_retour within w_a_sp_produit
end type

type pb_interro from w_8_accueil`pb_interro within w_a_sp_produit
end type

type pb_creer from w_8_accueil`pb_creer within w_a_sp_produit
end type

type dw_1 from w_8_accueil`dw_1 within w_a_sp_produit
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

type pb_tri from w_8_accueil`pb_tri within w_a_sp_produit
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_sp_produit
boolean visible = true
boolean enabled = true
end type

