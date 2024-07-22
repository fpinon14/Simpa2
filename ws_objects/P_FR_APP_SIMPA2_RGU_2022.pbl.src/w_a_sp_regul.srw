HA$PBExportHeader$w_a_sp_regul.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour la saisie des r$$HEX1$$e900$$ENDHEX$$gularisations.
forward
global type w_a_sp_regul from w_8_accueil
end type
end forward

global type w_a_sp_regul from w_8_accueil
integer x = 0
integer y = 0
integer width = 3456
integer height = 1772
string title = "Accueil - Gestion des r$$HEX1$$e900$$ENDHEX$$gularisations SIMPA2"
end type
global w_a_sp_regul w_a_sp_regul

on ue_modifier;call w_8_accueil::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet			:	W_A_Sp_Regul::Ue_Modifier
//* Evenement 		:	UE_MODIFIER - Extend
//* Auteur			:	Erick John Stark
//* Date				:	09/06/97 16:36:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification d'un sinistre. On va ajouter une r$$HEX1$$e900$$ENDHEX$$gularisation.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re l'identifiant du sinistre.                           */
/*------------------------------------------------------------------*/
istPass.sTab [ 1 ] 	= String ( dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_SIN" ) )

/*------------------------------------------------------------------*/
/* On ne peut rien supprimer sur la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement.          */
/*------------------------------------------------------------------*/
istPass.bSupprime	= FALSE

F_OuvreTraitement ( W_Tm_Sp_Regul, istPass )

end on

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Sp_Regul::Open
//* Evenement 		: Open
//* Auteur			: Erick John Stark
//* Date				: 26/01/1999 14:37:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le traitement des r$$HEX1$$e900$$ENDHEX$$gularisations
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//String sTables [ 4 ]		//Tableau pour les tables d'o$$HEX2$$f9002000$$ENDHEX$$proviennent les champs de la datawindow
String sTables []		//Tableau pour les tables d'o$$HEX2$$f9002000$$ENDHEX$$proviennent les champs de la datawindow
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Affecte l'object de transaction $$HEX2$$e0002000$$ENDHEX$$la variable d'instance.        */
/*------------------------------------------------------------------*/
iTrTrans = SQLCA

/*------------------------------------------------------------------*/
/* Description de la DW d'accueil                                   */
/*------------------------------------------------------------------*/
dw_1.istCol [ 1 ].sDbName		=	"sysadm.produit.lib_court"
dw_1.istCol [ 1 ].sResultSet	=	"lib_court"
dw_1.istCol [ 1 ].sType			=	"char(20)"
dw_1.istCol [ 1 ].sHeaderName	=	"Produit"
dw_1.istCol [ 1 ].ilargeur		=	20
dw_1.istCol [ 1 ].sAlignement	=	"0"
dw_1.istCol [ 1 ].sInvisible	= 	"N"

dw_1.istCol [ 2 ].sDbName		=	"sysadm.sinistre.id_sin"
dw_1.istCol [ 2 ].sResultSet	=	"id_sin"
dw_1.istCol [ 2 ].sType			=	"number"
dw_1.istCol [ 2 ].sHeaderName	=	"Sinistre"
dw_1.istCol [ 2 ].ilargeur		=	10  // [PI062]
dw_1.istCol [ 2 ].sAlignement	=	"2"
dw_1.istCol [ 2 ].sInvisible	= 	"N"

dw_1.istCol [ 3 ].sDbName		=	"sysadm.personne.nom"
dw_1.istCol [ 3 ].sResultSet	=	"nom"
dw_1.istCol [ 3 ].sType			=	"char(35)"
dw_1.istCol [ 3 ].sHeaderName	=	"Nom"
dw_1.istCol [ 3 ].ilargeur		=	15
dw_1.istCol [ 3 ].sAlignement	=	"0"
dw_1.istCol [ 3 ].sInvisible	= 	"N"

dw_1.istCol [ 4 ].sDbName		=	"sysadm.personne.prenom"
dw_1.istCol [ 4 ].sResultSet	=	"prenom"
dw_1.istCol [ 4 ].sType			=	"char(35)"
dw_1.istCol [ 4 ].sHeaderName	=	"Pr$$HEX1$$e900$$ENDHEX$$nom"
dw_1.istCol [ 4 ].ilargeur		=	15
dw_1.istCol [ 4 ].sAlignement	=	"0"
dw_1.istCol [ 4 ].sInvisible	= 	"N"

dw_1.istCol [ 5 ].sDbName		=	"sysadm.code.lib_code"
dw_1.istCol [ 5 ].sResultSet	=	"lib_code"
//Migration PB8-WYNIWYG-03/2006 FM
//dw_1.istCol [ 5 ].sType			=	"char(20)"
dw_1.istCol [ 5 ].sType			=	"char(35)"
//Fin Migration PB8-WYNIWYG-03/2006 FM
dw_1.istCol [ 5 ].sHeaderName	=	"Code Etat"
dw_1.istCol [ 5 ].ilargeur		=	25
dw_1.istCol [ 5 ].sAlignement	=	"0"
dw_1.istCol [ 5 ].sInvisible	= 	"N"

dw_1.istCol [ 6 ].sDbName		=	"sysadm.sinistre.cod_etat"
dw_1.istCol [ 6 ].sResultSet	=	"cod_etat"
dw_1.istCol [ 6 ].sType			=	"number"
dw_1.istCol [ 6 ].sHeaderName	=	"Etat"
dw_1.istCol [ 6 ].ilargeur		=	20
dw_1.istCol [ 6 ].sAlignement	=	"2"
dw_1.istCol [ 6 ].sInvisible	= 	"O"

sTables [ 1 ] = "sinistre"
sTables [ 2 ] = "produit"
sTables [ 3 ] = "personne"
sTables [ 4 ] = "code"

/*------------------------------------------------------------------*/
/* Jointure de la Data Window d'accueil.                            */
/*------------------------------------------------------------------*/
Dw_1.isJointure = " And sysadm.sinistre.id_prod  	= sysadm.produit.id_prod "				+	&
                  " And sysadm.sinistre.id_ordre	= sysadm.personne.id_ordre "			+	&
                  " And sysadm.code.id_typ_code		= '-ET' "									+	&
                  " And sysadm.sinistre.cod_etat	= sysadm.code.id_code " 

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/
dw_1.Uf_Creer_Tout( dw_1.istCol, sTables, itrTrans )

/*------------------------------------------------------------------*/
/* Tri par d$$HEX1$$e900$$ENDHEX$$faut sur la zone ID_SIN.                               */
/*------------------------------------------------------------------*/
dw_1.isTri = "#1 A"

wf_Construire_Chaine_Tri()

/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche                                             */
/*------------------------------------------------------------------*/
pb_Interro.istInterro.wAncetre					= This
pb_Interro.istInterro.sTitre 						= "Recherche des compagnies"
pb_Interro.istInterro.sDataObject				= "d_sp_int_regul"
pb_Interro.istInterro.sCodeDw						= "REGUL"

pb_Interro.istInterro.sData [ 1 ].sNom			= "id_sin"
pb_Interro.istInterro.sData [ 1 ].sDbName		= "sysadm.sinistre.id_sin"
pb_Interro.istInterro.sData [ 1 ].sType		= "NUMBER"
pb_Interro.istInterro.sData [ 1 ].sOperande	= "="
pb_Interro.istInterro.sData [ 1 ].sMoteur		= "MSS"

pb_Interro.istInterro.sData [ 2 ].sNom			= "nom"
pb_Interro.istInterro.sData [ 2 ].sDbName		= "sysadm.personne.nom"
pb_Interro.istInterro.sData [ 2 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 2 ].sOperande	= "="
pb_Interro.istInterro.sData [ 2 ].sMoteur		= "MSS"

pb_Interro.istInterro.sData [ 3 ].sNom			= "prenom"
pb_Interro.istInterro.sData [ 3 ].sDbName		= "sysadm.personne.prenom"
pb_Interro.istInterro.sData [ 3 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 3 ].sOperande	= "="
pb_Interro.istInterro.sData [ 3 ].sMoteur		= "MSS"

/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= itrTrans
istPass.bControl	= TRUE			// Utilisation de CTRL+VALIDE
end event

on w_a_sp_regul.create
call super::create
end on

on w_a_sp_regul.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type cb_debug from w_8_accueil`cb_debug within w_a_sp_regul
end type

type pb_retour from w_8_accueil`pb_retour within w_a_sp_regul
integer width = 242
integer height = 144
end type

type pb_interro from w_8_accueil`pb_interro within w_a_sp_regul
integer x = 261
integer width = 242
integer height = 144
integer taborder = 40
end type

type pb_creer from w_8_accueil`pb_creer within w_a_sp_regul
boolean visible = false
integer taborder = 0
boolean enabled = false
end type

type dw_1 from w_8_accueil`dw_1 within w_a_sp_regul
end type

type pb_tri from w_8_accueil`pb_tri within w_a_sp_regul
integer x = 503
integer width = 242
integer height = 144
integer taborder = 50
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_sp_regul
boolean visible = true
integer x = 745
integer width = 242
integer height = 144
boolean enabled = true
end type

