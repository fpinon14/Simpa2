HA$PBExportHeader$w_a_sp_garantie.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le param$$HEX1$$e900$$ENDHEX$$trage des garanties
forward
global type w_a_sp_garantie from w_8_accueil
end type
end forward

global type w_a_sp_garantie from w_8_accueil
integer x = 0
integer y = 0
integer width = 3639
integer height = 2000
string title = "Accueil - Gestion des garanties"
end type
global w_a_sp_garantie w_a_sp_garantie

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_sp_garantie
//* Evenement 		:	Open
//* Auteur			:	V.Capelle
//* Date				:	05/11/97 10:30:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil des garantie
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1	JCA	15/11/2006		DCMP 060825 - plus de limitation du nbr de ligne de retour
//       JFF   12/05/2020 [PI085]
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
Dw_1.ilMaxLig = 0 // #1


/*------------------------------------------------------------------*/
/* Positionne la variable pour le titre des listes $$HEX2$$e0002000$$ENDHEX$$imprimer.      */
/*------------------------------------------------------------------*/
This.isTitreLst = "Base : " + itrtrans.database + ". Liste des Garanties."

/*------------------------------------------------------------------*/
/*   Description de la DW d'accueil                                 */
/*------------------------------------------------------------------*/
Dw_1.istCol [ 1 ].sDbName		=	"sysadm.garantie.id_prod"
Dw_1.istCol [ 1 ].sType			=	"number"
Dw_1.istCol [ 1 ].sHeaderName	=	"Produit"
Dw_1.istCol [ 1 ].ilargeur		=	8
dw_1.istCol [ 1 ].sFormat	   =	"0000000"  // [PI085]
Dw_1.istCol [ 1 ].sAlignement	=	"2"
Dw_1.istCol [ 1 ].sInvisible	= 	"N"

Dw_1.istCol [ 2 ].sDbName		=	"sysadm.garantie.id_rev"
Dw_1.istCol [ 2 ].sType			=	"number"
Dw_1.istCol [ 2 ].sHeaderName	=	"R$$HEX1$$e900$$ENDHEX$$vision"
Dw_1.istCol [ 2 ].ilargeur		=	8
Dw_1.istCol [ 2 ].sAlignement	=	"2"
Dw_1.istCol [ 2 ].sInvisible	= 	"N"

Dw_1.istCol [ 3 ].sDbName		=	"sysadm.garantie.id_gti"
Dw_1.istCol [ 3 ].sType			=	"number"
Dw_1.istCol [ 3 ].sHeaderName	=	"Garantie"
Dw_1.istCol [ 3 ].ilargeur		=	8
Dw_1.istCol [ 3 ].sAlignement	=	"2"
Dw_1.istCol [ 3 ].sInvisible	= 	"N"

Dw_1.istCol [ 4 ].sDbName		=	"sysadm.code_garantie.lib_gti"
Dw_1.istCol [ 4 ].sType			=	"Char(35)"
Dw_1.istCol [ 4 ].sHeaderName	=	"Libell$$HEX1$$e900$$ENDHEX$$"
Dw_1.istCol [ 4 ].ilargeur		=	35
Dw_1.istCol [ 4 ].sAlignement	=	"0"
Dw_1.istCol [ 4 ].sInvisible	= 	"N"

Dw_1.istCol [ 5 ].sDbName		=	"sysadm.garantie.maj_le"
Dw_1.istCol [ 5 ].sType			=	"Datetime"
Dw_1.istCol [ 5 ].sHeaderName	=	"Maj Le"
Dw_1.istCol [ 5 ].sFormat		=	"dd/mm/yyyy hh:mm:ss"
Dw_1.istCol [ 5 ].ilargeur		=	20
Dw_1.istCol [ 5 ].sAlignement	=	"2"
Dw_1.istCol [ 5 ].sInvisible	= 	"N"

Dw_1.istCol [ 6 ].sDbName		=	"sysadm.garantie.maj_par"
Dw_1.istCol [ 6 ].sType			=	"char(4)"
Dw_1.istCol [ 6 ].sHeaderName	=	"Par"
Dw_1.istCol [ 6 ].ilargeur		=	4
Dw_1.istCol [ 6 ].sAlignement	=	"2"
Dw_1.istCol [ 6 ].sInvisible	= 	"N"

sTables [ 1 ] = "garantie"
sTables [ 2 ] = "code_garantie"

Dw_1.isJointure = " AND sysadm.garantie.id_gti  = sysadm.code_garantie.id_gti" + &
                  " AND sysadm.garantie.id_prod = sysadm.code_garantie.id_prod "


/*------------------------------------------------------------------*/
/* Tri : colonne des produits                                       */
/*------------------------------------------------------------------*/
Dw_1.isTri = "#1 A, #2 A, #3 A"

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/
Dw_1.Uf_Creer_Tout ( Dw_1.istCol, sTables, itrTrans )

wf_Construire_Chaine_Tri ( )

/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche                                             */
/*------------------------------------------------------------------*/
pb_Interro.istInterro.wAncetre				= This
pb_Interro.istInterro.sTitre 					= "Recherche des Garanties"
pb_Interro.istInterro.sDataObject			= "d_sp_int_garantie" // [PI085]
pb_Interro.istInterro.sCodeDw					= "GARANTIE"

pb_Interro.istInterro.sData [ 1 ].sNom			= "id_prod"
pb_Interro.istInterro.sData [ 1 ].sDbName		= "sysadm.garantie.id_prod"
pb_Interro.istInterro.sData [ 1 ].sType		= "NUMBER"
pb_Interro.istInterro.sData [ 1 ].sOperande	= "="
pb_Interro.istInterro.sData [ 1 ].sMoteur		= "MSS"

pb_Interro.istInterro.sData [ 2 ].sNom			= "id_gti"
pb_Interro.istInterro.sData [ 2 ].sDbName		= "sysadm.garantie.id_gti"
pb_Interro.istInterro.sData [ 2 ].sType		= "NUMBER"
pb_Interro.istInterro.sData [ 2 ].sOperande	= "="
pb_Interro.istInterro.sData [ 2 ].sMoteur		= "MSS"

pb_Interro.istInterro.sData [ 3 ].sNom			= "maj_le1"
pb_Interro.istInterro.sData [ 3 ].sDbName		= "sysadm.garantie.maj_le"
pb_Interro.istInterro.sData [ 3 ].sType		= "DATETIME"
pb_Interro.istInterro.sData [ 3 ].sOperande	= ">="

pb_Interro.istInterro.sData [ 4 ].sNom			= "maj_le2"
pb_Interro.istInterro.sData [ 4 ].sDbName		= "sysadm.garantie.maj_le"
pb_Interro.istInterro.sData [ 4 ].sType		= "DATETIME"
pb_Interro.istInterro.sData [ 4 ].sOperande	= "<="

pb_Interro.istInterro.sData [ 5 ].sNom			= "maj_par"
pb_Interro.istInterro.sData [ 5 ].sDbName		= "sysadm.garantie.maj_par"
pb_Interro.istInterro.sData [ 5 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 5 ].sOperande	= "="

/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= itrTrans
istPass.bControl	= TRUE		// Utilisation du bouton CONTROLER
end event

on ue_preparer_interro;call w_8_accueil::ue_preparer_interro;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_sp_garantie
//* Evenement 		:	ue_preparer_interro
//* Auteur			:	V.Capelle
//* Date				:	05/11/97 14:22:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Charge les datawindow de la fen$$HEX1$$ea00$$ENDHEX$$tre d'interroration.
//* Commentaires	:	Chargement des produits et des garantie
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild	dwcProd	// DDDW des produits.
DataWindowChild	dwcGti	// DDDW des garanties.

w_interro.dw_1.GetChild ( "id_prod", dwcProd )
dwcProd.SetTransObject ( itrTrans )
dwcProd.Retrieve()

w_interro.dw_1.GetChild ( "id_gti", dwcGti )
dwcGti.SetTransObject ( itrTrans )
dwcGti.Retrieve( "-GA" )


end on

on ue_creer;call w_8_accueil::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_sp_garantie
//* Evenement 		:	ue_creer
//* Auteur			:	V.Capelle
//* Date				:	05/11/1997 09:58:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Cr$$HEX1$$e900$$ENDHEX$$ation d'une garantie
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
SetPointer ( HourGlass! )

f_OuvreTraitement ( w_Tm_Sp_Garantie, istPass )
end on

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_sp_garantie
//* Evenement 		:	ue_modifier 
//* Auteur			:	V.Capelle
//* Date				:	05/11/1997 09:57:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification d'une garantie
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
SetPointer ( HourGlass! )

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re l'identifiant de l'identifiant de la garantie           */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//istPass.lTab [ 1 ] =  Dw_1.GetItemNumber ( Dw_1.ilLigneClick, "GARANTIE.ID_PROD" ) 
//istPass.lTab [ 2 ] =  Dw_1.GetItemNumber ( Dw_1.ilLigneClick, "GARANTIE.ID_REV" ) 
//istPass.lTab [ 3 ] =  Dw_1.GetItemNumber ( Dw_1.ilLigneClick, "GARANTIE.ID_GTI" ) 
istPass.lTab [ 1 ] =  Dw_1.GetItemNumber ( Dw_1.ilLigneClick, "ID_PROD" ) 
istPass.lTab [ 2 ] =  Dw_1.GetItemNumber ( Dw_1.ilLigneClick, "ID_REV" ) 
istPass.lTab [ 3 ] =  Dw_1.GetItemNumber ( Dw_1.ilLigneClick, "ID_GTI" ) 
//Fin Migration PB8-WYNIWYG-03/2006 FM


/*------------------------------------------------------------------*/
/* Autorise la suppression d'une garantie.                          */
/*------------------------------------------------------------------*/
istPass.bSupprime	= TRUE

f_OuvreTraitement ( w_Tm_Sp_Garantie, istPass )
end event

on w_a_sp_garantie.create
call super::create
end on

on w_a_sp_garantie.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type cb_debug from w_8_accueil`cb_debug within w_a_sp_garantie
end type

type pb_retour from w_8_accueil`pb_retour within w_a_sp_garantie
integer width = 242
integer height = 144
end type

type pb_interro from w_8_accueil`pb_interro within w_a_sp_garantie
integer width = 242
integer height = 144
end type

type pb_creer from w_8_accueil`pb_creer within w_a_sp_garantie
integer width = 242
integer height = 144
end type

type dw_1 from w_8_accueil`dw_1 within w_a_sp_garantie
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

type pb_tri from w_8_accueil`pb_tri within w_a_sp_garantie
integer width = 242
integer height = 144
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_sp_garantie
boolean visible = true
integer width = 242
integer height = 144
boolean enabled = true
end type

