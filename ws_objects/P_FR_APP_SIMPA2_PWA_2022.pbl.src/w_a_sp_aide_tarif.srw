HA$PBExportHeader$w_a_sp_aide_tarif.srw
$PBExportComments$--} fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le param$$HEX1$$e900$$ENDHEX$$trage aide tarif
forward
global type w_a_sp_aide_tarif from w_8_accueil
end type
type dw_code from datawindow within w_a_sp_aide_tarif
end type
end forward

global type w_a_sp_aide_tarif from w_8_accueil
integer width = 3639
integer height = 2000
string title = "Accueil - Gestion Aide Tarif"
dw_code dw_code
end type
global w_a_sp_aide_tarif w_a_sp_aide_tarif

on open;call w_8_accueil::open;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_aide_tarif
//* Evenement 		:	OPEN - Extend
//* Auteur			:	PLJ
//* Date				:	09/03/1998 09:41:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Organisation de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le  
//*					 	param$$HEX1$$e900$$ENDHEX$$trage des Tarifs.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
// [MIGPB11] [EMD] : Debut Migration : mise en commentaire de la double declaration de sTables [ 2 ]
//String sTables [ 2 ]		//Tableau pour les tables d'o$$HEX2$$f9002000$$ENDHEX$$proviennent les champs de la datawindow
// [MIGPB11] [EMD] : Fin Migration
String sTables []		//Tableau pour les tables d'o$$HEX2$$f9002000$$ENDHEX$$proviennent les champs de la datawindow
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Affecte l'object de transaction $$HEX2$$e0002000$$ENDHEX$$la variable d'instance.        */
/*------------------------------------------------------------------*/
iTrTrans = SQLCA

/*------------------------------------------------------------------*/
/* Positionne la variable pour le titre des listes $$HEX2$$e0002000$$ENDHEX$$imprimer.      */
/*------------------------------------------------------------------*/
This.isTitreLst = "Base : " + itrtrans.database + ". Aide Tarif."

/*------------------------------------------------------------------*/
/* Description de la DW d'accueil                                   */
/*------------------------------------------------------------------*/
dw_1.istCol [ 1 ].sDbName		=	"sysadm.aide_tarif.id_code"
dw_1.istCol [ 1 ].sType			=	"number"
dw_1.istCol [ 1 ].sHeaderName	=	"Code Tarif"
dw_1.istCol [ 1 ].sFormat		=	"0"
dw_1.istCol [ 1 ].ilargeur		=	2
dw_1.istCol [ 1 ].sAlignement	=	"2"
dw_1.istCol [ 1 ].sInvisible	= 	"N"

dw_1.istCol [ 2 ].sDbName		=	"sysadm.code.lib_code"
dw_1.istCol [ 2 ].sType			=	"char(35)"
dw_1.istCol [ 2 ].sHeaderName	=	"Garantie"
dw_1.istCol [ 2 ].ilargeur		=	20
dw_1.istCol [ 2 ].sAlignement	=	"0"
dw_1.istCol [ 2 ].sInvisible	= 	"N"


dw_1.istCol [ 3 ].sDbName		=	"sysadm.aide_tarif.lib_code"
dw_1.istCol [ 3 ].sType			=	"char(35)"
dw_1.istCol [ 3 ].sHeaderName	=	"Libell$$HEX2$$e9002000$$ENDHEX$$Tarif"
dw_1.istCol [ 3 ].ilargeur		=	35
dw_1.istCol [ 3 ].sAlignement	=	"0"
dw_1.istCol [ 3 ].sInvisible	= 	"N"

dw_1.istCol [ 4 ].sDbName		=	"sysadm.aide_tarif.maj_le"
dw_1.istCol [ 4 ].sType			=	"datetime"
dw_1.istCol [ 4 ].sHeaderName	=	"Maj le"
dw_1.istCol [ 4 ].sFormat		=	"dd/mm/yyyy hh:mm"
dw_1.istCol [ 4 ].ilargeur		=	16
dw_1.istCol [ 4 ].sAlignement	=	"2"
dw_1.istCol [ 4 ].sInvisible	= 	"N"

dw_1.istCol [ 5 ].sDbName		=	"sysadm.aide_tarif.maj_par"
dw_1.istCol [ 5 ].sType			=	"char(4)"
dw_1.istCol [ 5 ].sHeaderName	=	"Par"
dw_1.istCol [ 5 ].ilargeur		=	4
dw_1.istCol [ 5 ].sAlignement	=	"2"
dw_1.istCol [ 5 ].sInvisible	= 	"N"

sTables [ 1 ]	= "aide_tarif"
sTables [ 2 ]  = "code"

dw_1.isJointure = "AND sysadm.code.id_typ_code = '-GA'" + &
						"AND sysadm.code.id_code = sysadm.aide_tarif.id_gti"


/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/
dw_1.Uf_Creer_Tout( dw_1.istCol, sTables, itrTrans )

/*------------------------------------------------------------------*/
/* Tri par d$$HEX1$$e900$$ENDHEX$$faut sur l'identifiant des tarifs.                     */
/*------------------------------------------------------------------*/
dw_1.isTri = "#1 A"

wf_Construire_Chaine_Tri()


/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche                                             */
/*------------------------------------------------------------------*/

pb_Interro.istInterro.wAncetre					= This
pb_Interro.istInterro.sTitre 						= "Recherche des tarifs"
pb_Interro.istInterro.sDataObject				= "d_sp_int_aide_tarif"
pb_Interro.istInterro.sCodeDw						= "AIDE_TARIF"

pb_Interro.istInterro.sData [ 1 ].sNom			= "id_code"
pb_Interro.istInterro.sData [ 1 ].sDbName		= "sysadm.aide_tarif.id_code"
pb_Interro.istInterro.sData [ 1 ].sType		= "NUMBER"
pb_Interro.istInterro.sData [ 1 ].sOperande	= "="
pb_Interro.istInterro.sData [ 1 ].sMoteur		= "MSS"

pb_Interro.istInterro.sData [ 2 ].sNom			= "id_gti"
pb_Interro.istInterro.sData [ 2 ].sDbName		= "sysadm.aide_tarif.id_gti"
pb_Interro.istInterro.sData [ 2 ].sType		= "NUMBER"
pb_Interro.istInterro.sData [ 2 ].sOperande	= "="
pb_Interro.istInterro.sData [ 2 ].sMoteur		= "MSS"

pb_Interro.istInterro.sData [ 3 ].sNom			= "lib_code"
pb_Interro.istInterro.sData [ 3 ].sDbName		= "sysadm.aide_tarif.lib_code"
pb_Interro.istInterro.sData [ 3 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 3 ].sOperande	= "="
pb_Interro.istInterro.sData [ 3 ].sMoteur		= "MSS"

/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/

istPass.trTrans 	= itrTrans
istPass.bControl	= False		// Utilisation de VALIDE uniquement


/*------------------------------------------------------------------*/
/* Passage de l'objet de transaction $$HEX2$$e0002000$$ENDHEX$$dw_code (invisible)     	  */
/* Chargement des garanties dans la dropdowndatawindow dw_code      */
/*------------------------------------------------------------------*/

dw_code.SetTransObject ( itrTrans )
dw_code.Retrieve( "-GA" )
end on

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_carte
//* Evenement 		: ue_modifier
//* Auteur			: PLJ
//* Date				: 11/03/1998 16:20:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: modification d'un enregistrement
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re l'identifiant du code tarif                             */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 FM
//istPass.sTab[1] 	= String ( dw_1.GetItemNumber ( dw_1.ilLigneClick, "AIDE_TARIF.ID_CODE" ) )
istPass.sTab[1] 	= String ( dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_CODE" ) )
//Fin Migration PB8-WYNIWYG-03/2006 FM


/*------------------------------------------------------------------*/
/* Autorise la suppression d'une carte.                             */
/*------------------------------------------------------------------*/

istPass.bSupprime	= TRUE
istPass.dwnorm[1] = dw_code

f_OuvreTraitement ( w_t_sp_aide_tarif, istPass )
end event

on ue_creer;call w_8_accueil::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_aide_tarif
//* Evenement 		:	UE_CREER - Extend
//* Auteur			:	PLJ
//* Date				:	09/03/98 11:34:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Cr$$HEX1$$e900$$ENDHEX$$ation d'une nouvelle ligne pour aide tarif.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

//istPass.bSupprime = False

istPass.dwnorm[1] = dw_code

f_OuvreTraitement ( w_t_sp_aide_tarif, istPass )
end on

on ue_preparer_interro;call w_8_accueil::ue_preparer_interro;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_sp_aide_tarif
//* Evenement 		:	ue_preparer_interro
//* Auteur			:	PLJ
//* Date				:	10/03/1998 14:52:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Charge la datawindow de la fen$$HEX1$$ea00$$ENDHEX$$tre d'interrogation.
//* Commentaires	:	Chargement des garanties
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild	dwcGti	// DDDW des garanties.

w_interro.dw_1.GetChild ( "ID_GTI", dwcGti )
dw_code.sharedata(dwcGti)

end on

on w_a_sp_aide_tarif.create
int iCurrent
call super::create
this.dw_code=create dw_code
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_code
end on

on w_a_sp_aide_tarif.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_code)
end on

type pb_retour from w_8_accueil`pb_retour within w_a_sp_aide_tarif
integer taborder = 40
end type

type pb_interro from w_8_accueil`pb_interro within w_a_sp_aide_tarif
integer taborder = 60
end type

type pb_creer from w_8_accueil`pb_creer within w_a_sp_aide_tarif
integer taborder = 50
end type

type dw_1 from w_8_accueil`dw_1 within w_a_sp_aide_tarif
end type

event dw_1::constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_aide_tarif
//* Evenement 		: constructor
//* Auteur			: PHG
//* Date				: 02/06/2006 14:33:51
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
//*-----------------------------------------------------------------

ilMaxLig = 0

end event

type pb_tri from w_8_accueil`pb_tri within w_a_sp_aide_tarif
integer taborder = 70
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_sp_aide_tarif
end type

type dw_code from datawindow within w_a_sp_aide_tarif
boolean visible = false
integer x = 1486
integer y = 72
integer width = 494
integer height = 144
integer taborder = 30
boolean bringtotop = true
string dataobject = "dddw_spb_code"
boolean livescroll = true
end type

