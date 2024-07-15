HA$PBExportHeader$w_a_sp_cas_maj_nom.srw
forward
global type w_a_sp_cas_maj_nom from w_8_accueil
end type
end forward

global type w_a_sp_cas_maj_nom from w_8_accueil
integer x = 0
integer y = 0
integer width = 3639
integer height = 2000
string title = "Accueil - Modification Nom/Pr$$HEX1$$e900$$ENDHEX$$nom/Civilit$$HEX1$$e900$$ENDHEX$$"
end type
global w_a_sp_cas_maj_nom w_a_sp_cas_maj_nom

type variables
Private:
	String	isIdSin
	String	isProcedure
end variables

on ue_modifier;call w_8_accueil::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_cas_maj_nom
//* Evenement 		: ue_modifier
//* Auteur			: DBI
//* Date				: 28/03/2000 16:21:59
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

istPass.sTab[1] 	= String ( dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_SIN" ) )
istPass.sTab[2] 	= dw_1.GetItemString ( dw_1.ilLigneClick, "ALT_QUEUE" )


/*------------------------------------------------------------------*/
/* Autorise la suppression d'une carte.                             */
/*------------------------------------------------------------------*/

istPass.bSupprime	= False
istPass.bControl	= True

f_OuvreTraitement ( w_t_sp_cas_maj_nom, istPass )
end on

event ue_fin_interro;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_cas_maj_nom
//* Evenement 		: ue_fin_interro
//* Auteur			: DBI
//* Date				: 28/03/2000 13:41:47
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Appel retrieve avec N$$HEX2$$b0002000$$ENDHEX$$de sinistre saisi
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: 
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------


If isIdSin <> "" Then

	Dw_1.Modify ( "datawindow.table.procedure=~'" + isProcedure + isIdSin + "~';" )
	Dw_1.Retrieve ()

	SetPointer ( Arrow! )
End If
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
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
//Migration PB8-WYNIWYG-03/2006 FM
//String sTables [ 4 ]		// Tables du SELECT
String sTables []		// Tables du SELECT
//Fin Migration PB8-WYNIWYG-03/2006 FM
Int	 iCpt

itrTrans = SQLCA

dw_1.ilMaxLig = 1000

/*------------------------------------------------------------------*/
/*   Description de la DW d'accueil                                 */
/*------------------------------------------------------------------*/

iCpt = 1

dw_1.istCol[iCpt].sDbName		=	"sysadm.sinistre.id_sin"
dw_1.istCol[iCpt].sResultSet	=	"ID_SIN"
dw_1.istCol[iCpt].sType			=	"Number"
dw_1.istCol[iCpt].sHeaderName	=	"Id Sin"
dw_1.istCol[iCpt].ilargeur		=	10   // [PI062]
dw_1.istCol[iCpt].sAlignement	=	"2"
dw_1.istCol[iCpt].sInvisible	= 	"N"

iCpt ++

dw_1.istCol[iCpt].sDbName		=	"sysadm.personne.cod_civ"
dw_1.istCol[iCpt].sType			=	"char(1)"
dw_1.istCol[iCpt].sHeaderName	=	"Civ"
dw_1.istCol[iCpt].ilargeur		=	5
dw_1.istCol[iCpt].sAlignement	=	"0"
dw_1.istCol[iCpt].sInvisible	= 	"O"

iCpt ++

dw_1.istCol[iCpt].sDbName		=	"sysadm.code.lib_code"
dw_1.istCol[iCpt].sType			=	"char(35)"
dw_1.istCol[iCpt].sHeaderName	=	"Civ"
dw_1.istCol[iCpt].ilargeur		=	5
dw_1.istCol[iCpt].sAlignement	=	"2"
dw_1.istCol[iCpt].sInvisible	= 	"N"

iCpt ++

dw_1.istCol[iCpt].sDbName		=	"sysadm.personne.nom"
dw_1.istCol[iCpt].sType			=	"char(35)"
dw_1.istCol[iCpt].sHeaderName	=	"Nom"
dw_1.istCol[iCpt].ilargeur		=	20
dw_1.istCol[iCpt].sAlignement	=	"0"
dw_1.istCol[iCpt].sInvisible	= 	"N"

iCpt ++

dw_1.istCol[iCpt].sDbName		=	"sysadm.personne.prenom"
dw_1.istCol[iCpt].sType			=	"char(35)"
dw_1.istCol[iCpt].sHeaderName	=	"Pr$$HEX1$$e900$$ENDHEX$$nom"
dw_1.istCol[iCpt].ilargeur		=	20
dw_1.istCol[iCpt].sAlignement	=	"0"
dw_1.istCol[iCpt].sInvisible	= 	"N"

iCpt ++

dw_1.istCol[iCpt].sDbName		=	"sysadm.produit.lib_court"
dw_1.istCol[iCpt].sType			=	"char(20)"
dw_1.istCol[iCpt].sHeaderName	=	"Produit"
dw_1.istCol[iCpt].ilargeur		=	20
dw_1.istCol[iCpt].sAlignement	=	"0"
dw_1.istCol[iCpt].sInvisible	= 	"N"

iCpt ++

dw_1.istCol[iCpt].sDbName		=	"sysadm.routage.alt_queue"
dw_1.istCol[iCpt].sType			=	"char(1)"
dw_1.istCol[iCpt].sResultSet	=	"ALT_QUEUE"
dw_1.istCol[iCpt].ilargeur		=	1
dw_1.istCol[iCpt].sInvisible	= 	"O"

sTables [ 1 ] = "sinistre"
sTables [ 2 ] = "personne"
sTables [ 3 ] = "routage"
sTables [ 4 ] = "produit"

/*------------------------------------------------------------------*/
/*  Jointure entre les 2 tables ci-dessus :                         */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Tri par d$$HEX1$$e900$$ENDHEX$$faut de la Data Window d'accueil.                      */
/*------------------------------------------------------------------*/
Dw_1.isTri = "#1 A"

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/
dw_1.Uf_Creer_Tout( dw_1.istCol, sTables, itrTrans )

/*------------------------------------------------------------------*/
/* La recherche va $$HEX1$$ea00$$ENDHEX$$tre r$$HEX1$$e900$$ENDHEX$$alis$$HEX1$$e900$$ENDHEX$$e par un proc$$HEX1$$e900$$ENDHEX$$dure SQL car il faut   */
/* ramener les enregistrements de w_sin et sinistre en fonction de  */
/* routage.alt_queue ( c'est plus simple avec proc$$HEX1$$e900$$ENDHEX$$dure sql         */
/*------------------------------------------------------------------*/

dw_1.modify ( "datawindow.table.procedure= ~'EXECUTE sysadm.DW_SACC_W_SIN_CAS2 ~'" )

isProcedure	=	dw_1.describe ( "datawindow.table.procedure" )


wf_Construire_Chaine_Tri()

/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche                                             */
/*------------------------------------------------------------------*/
pb_Interro.istInterro.wAncetre				= This
pb_Interro.istInterro.sTitre 					= "Recherche des sinistres"
pb_Interro.istInterro.sDataObject			= "d_sp_int_maj_nom"
pb_Interro.istInterro.sCodeDw					= "SIN"

iCpt = 1

pb_Interro.istInterro.sData[iCpt].sNom			= "id_sin"
pb_Interro.istInterro.sData[iCpt].sDbName		= "sysadm.sinistre.id_sin"
pb_Interro.istInterro.sData[iCpt].sType		= "NUMBER"
pb_Interro.istInterro.sData[iCpt].sOperande	= "="
pb_Interro.istInterro.sData[iCpt].sMoteur		= "MSS"

/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= itrTrans
istPass.bControl	= False		// Utilisation du bouton VALIDER
end event

on ue_fermer_interro;call w_8_accueil::ue_fermer_interro;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_cas_maj_nom
//* Evenement 		: ue_fermer_interro
//* Auteur			: DBI
//* Date				: 28/03/2000 14:00:17
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Lecture Id_Sin sur w_interro avent fermeture
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: 
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

String	sIdSin

sIdSin = w_Interro.Dw_1.GetItemString ( 1, "ID_SIN" )

If Not isNull ( sIdSin ) And isNumber ( sIdSin ) Then

	isIdSin = sIdSin 
End If

end on

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

on w_a_sp_cas_maj_nom.create
call super::create
end on

on w_a_sp_cas_maj_nom.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type cb_debug from w_8_accueil`cb_debug within w_a_sp_cas_maj_nom
end type

type pb_retour from w_8_accueil`pb_retour within w_a_sp_cas_maj_nom
integer width = 242
integer height = 144
end type

type pb_interro from w_8_accueil`pb_interro within w_a_sp_cas_maj_nom
integer x = 261
integer width = 242
integer height = 144
end type

type pb_creer from w_8_accueil`pb_creer within w_a_sp_cas_maj_nom
boolean visible = false
integer width = 242
integer height = 144
end type

type dw_1 from w_8_accueil`dw_1 within w_a_sp_cas_maj_nom
end type

type pb_tri from w_8_accueil`pb_tri within w_a_sp_cas_maj_nom
integer x = 503
integer width = 242
integer height = 144
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_sp_cas_maj_nom
boolean visible = true
integer x = 745
integer width = 242
integer height = 144
boolean enabled = true
end type

