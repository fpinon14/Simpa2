HA$PBExportHeader$w_a_sp_c_garantie.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour la consultation du param$$HEX1$$e900$$ENDHEX$$trage des garanties
forward
global type w_a_sp_c_garantie from w_8_accueil_consultation
end type
end forward

global type w_a_sp_c_garantie from w_8_accueil_consultation
integer x = 0
integer y = 0
integer width = 3625
integer height = 2252
string title = "Consultation du param$$HEX1$$e900$$ENDHEX$$trage des garanties"
end type
global w_a_sp_c_garantie w_a_sp_c_garantie

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
//* #1	JCA		15/11/2006		DCMP 060825 - plus de limitation du nbr de ligne de retour
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//String sTables [ 2 ]			// Tables du SELECT
String sTables [ ]			// Tables du SELECT
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Affecte l'object de transaction $$HEX2$$e0002000$$ENDHEX$$la variable d'instance.        */
/*------------------------------------------------------------------*/
itrTrans = SQLCA

/*----------------------------------------------------------------------------*/
/* Initialisation de la DW courante.                                          */
/*----------------------------------------------------------------------------*/
iuAccueilCourrant = Dw_1

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
dw_1.istCol [ 1 ].sFormat	   =	"00000"
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
pb_Interro.istInterro.sDataObject			= "d_sp_int_garantie"
pb_Interro.istInterro.sCodeDw					= "GARANTIE"

pb_Interro.istInterro.sData [ 1 ].sNom					= "id_prod"
pb_Interro.istInterro.sData [ 1 ].sDbNameConsult	= { "sysadm.garantie.id_prod", "", "", "", "", "" }
pb_Interro.istInterro.sData [ 1 ].sType				= "NUMBER"
pb_Interro.istInterro.sData [ 1 ].sOperande			= "="
pb_Interro.istInterro.sData [ 1 ].sMoteur				= "MSS"

pb_Interro.istInterro.sData [ 2 ].sNom					= "id_gti"
pb_Interro.istInterro.sData [ 2 ].sDbNameConsult	= { "sysadm.garantie.id_gti", "", "", "", "", "" }
pb_Interro.istInterro.sData [ 2 ].sType				= "NUMBER"
pb_Interro.istInterro.sData [ 2 ].sOperande			= "="
pb_Interro.istInterro.sData [ 2 ].sMoteur				= "MSS"

pb_Interro.istInterro.sData [ 3 ].sNom					= "maj_le1"
pb_Interro.istInterro.sData [ 3 ].sDbNameConsult	= { "sysadm.garantie.maj_le", "", "", "", "", "" }
pb_Interro.istInterro.sData [ 3 ].sType				= "DATETIME"
pb_Interro.istInterro.sData [ 3 ].sOperande			= ">="

pb_Interro.istInterro.sData [ 4 ].sNom					= "maj_le2"
pb_Interro.istInterro.sData [ 4 ].sDbNameConsult	= { "sysadm.garantie.maj_le", "", "", "", "", "" }
pb_Interro.istInterro.sData [ 4 ].sType				= "DATETIME"
pb_Interro.istInterro.sData [ 4 ].sOperande			= "<="

pb_Interro.istInterro.sData [ 5 ].sNom			 		= "maj_par"
pb_Interro.istInterro.sData [ 5 ].sDbNameConsult	= { "sysadm.garantie.maj_par", "", "", "", "", "" }
pb_Interro.istInterro.sData [ 5 ].sType				= "STRING"
pb_Interro.istInterro.sData [ 5 ].sOperande			= "="

/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= itrTrans
istPass.bEnableParent = False

end event

event ue_modifier;call super::ue_modifier;istPass.bEnableParent = False

If Dw_1.IlLigneClick > 0 Then

//Migration PB8-WYNIWYG-03/2006 FM
//	istPass.lTab[ 1 ] = Dw_1.GetItemNumber( dw_1.ilLigneClick, "GARANTIE.ID_PROD" ) 
//	istPass.lTab[ 2 ] = Dw_1.GetItemNumber( dw_1.ilLigneClick, "GARANTIE.ID_REV" ) 
//	istPass.lTab[ 3 ] = Dw_1.GetItemNumber( dw_1.ilLigneClick, "GARANTIE.ID_GTI" ) 
	istPass.lTab[ 1 ] = Dw_1.GetItemNumber( dw_1.ilLigneClick, "ID_PROD" ) 
	istPass.lTab[ 2 ] = Dw_1.GetItemNumber( dw_1.ilLigneClick, "ID_REV" ) 
	istPass.lTab[ 3 ] = Dw_1.GetItemNumber( dw_1.ilLigneClick, "ID_GTI" ) 
//Fin Migration PB8-WYNIWYG-03/2006 FM


	f_OuvreConsultation (  w_t_sp_c_garantie, "", istPass )

End If




end event

on ue_fin_interro;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_si_garanties
//* Evenement 		: ue_fin_interro ( OVERRIDE )
//* Auteur			: YP
//* Date				: 16/09/97 17:00:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Retaille la fen$$HEX1$$ea00$$ENDHEX$$tre en hauteur.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*----------------------------------------------------------------------------*/
/* Le Visible FALSE/TRUE permet d'$$HEX1$$e900$$ENDHEX$$viter des probl$$HEX1$$e800$$ENDHEX$$mes de flicking.           */
/*----------------------------------------------------------------------------*/
Dw_1.Visible = FALSE

CALL w_accueil_consultation::ue_fin_interro

This.TriggerEvent( "Ue_TaillerHauteur" )

Dw_1.Visible = TRUE

Dw_1.SetFocus ( )
end on

on ue_preparer_interro;call w_8_accueil_consultation::ue_preparer_interro;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_sp_garantie
//* Evenement 		:	ue_preparer_interro
//* Auteur			:	V.Capelle
//* Date				:	05/11/97 14:22:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Charge les datawindow de la fen$$HEX1$$ea00$$ENDHEX$$tre d'interroration.
//* Commentaires	:	Chargement des produits et des garantie
//*				  
//*-----------------------------------------------------------------

DataWindowChild	dwcProd	// DDDW des produits.
DataWindowChild	dwcGti	// DDDW des garanties.

w_interro_consultation.dw_1.GetChild ( "id_prod", dwcProd )
dwcProd.SetTransObject ( itrTrans )
dwcProd.Retrieve()

w_interro_consultation.dw_1.GetChild ( "id_gti", dwcGti )
dwcGti.SetTransObject ( itrTrans )
dwcGti.Retrieve( "-GA" )


end on

on ue_centreracc;call w_8_accueil_consultation::ue_centreracc;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_sp_c_garantie
//* Evenement 		:	Ue_CentrerAcc
//* Auteur			:	V.Capelle
//* Date				:	12/12/1997 11:08:15
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
dw_1.Uf_Largeur ( This.Width , 0 )
end on

on w_a_sp_c_garantie.create
int iCurrent
call super::create
end on

on w_a_sp_c_garantie.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

on ue_taillerhauteur;call w_8_accueil_consultation::ue_taillerhauteur;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_sp_c_garantie
//* Evenement 		:	
//* Auteur			:	V.Capelle
//* Date				:	12/12/1997 11:07:36
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
dw_1.Uf_Hauteur ( This.Height, 0 )

If Dw_1.Visible = False Then Dw_1.Visible = TRUE
end on

type pb_retour from w_8_accueil_consultation`pb_retour within w_a_sp_c_garantie
end type

type pb_interro from w_8_accueil_consultation`pb_interro within w_a_sp_c_garantie
end type

type pb_tri from w_8_accueil_consultation`pb_tri within w_a_sp_c_garantie
end type

type uo_onglet from w_8_accueil_consultation`uo_onglet within w_a_sp_c_garantie
end type

type dw_1 from w_8_accueil_consultation`dw_1 within w_a_sp_c_garantie
boolean border = true
borderstyle borderstyle = stylelowered!
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

type dw_2 from w_8_accueil_consultation`dw_2 within w_a_sp_c_garantie
end type

type dw_3 from w_8_accueil_consultation`dw_3 within w_a_sp_c_garantie
end type

type dw_4 from w_8_accueil_consultation`dw_4 within w_a_sp_c_garantie
end type

type dw_5 from w_8_accueil_consultation`dw_5 within w_a_sp_c_garantie
end type

type dw_6 from w_8_accueil_consultation`dw_6 within w_a_sp_c_garantie
end type

type uo_1 from w_8_accueil_consultation`uo_1 within w_a_sp_c_garantie
boolean visible = false
end type

type pb_imprimer from w_8_accueil_consultation`pb_imprimer within w_a_sp_c_garantie
end type

