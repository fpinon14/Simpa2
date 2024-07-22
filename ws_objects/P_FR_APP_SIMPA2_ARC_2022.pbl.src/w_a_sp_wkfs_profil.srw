HA$PBExportHeader$w_a_sp_wkfs_profil.srw
forward
global type w_a_sp_wkfs_profil from w_8_accueil
end type
end forward

global type w_a_sp_wkfs_profil from w_8_accueil
integer x = 0
integer y = 0
integer width = 3639
integer height = 2000
string title = "Accueil - Gestion des profils"
end type
global w_a_sp_wkfs_profil w_a_sp_wkfs_profil

on ue_preparer_interro;call w_8_accueil::ue_preparer_interro;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_wkfs_profil
//* Evenement 		: ue_preparer_interro
//* Auteur			: PLJ
//* Date				: 14/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation des DDDW de la fen$$HEX1$$ea00$$ENDHEX$$tre d'interrogation
//*
//* Commentaires	: Aucun
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild		dwChild


W_Interro.Dw_1.GetChild ( "id_profil", dwChild)
dwChild.SetTransObject  ( itrTrans )
dwChild.Retrieve        ()


W_Interro.Dw_1.GetChild ( "id_cie", dwChild)
dwChild.SetTransObject  ( itrTrans )
dwChild.Retrieve        ()


W_Interro.Dw_1.GetChild ( "id_typ_arch", dwChild)
dwChild.SetTransObject  ( itrTrans )
dwChild.Retrieve        ( '-MC')

end on

on open;call w_8_accueil::open;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_wkfs_profil
//* Evenement 		: OPEN
//* Auteur			: PLJ
//* Date				: 14/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
//Migration PB8-WYNIWYG-03/2006 FM
//String sTables [ 3 ]		// Tables du SELECT
String sTables []		// Tables du SELECT
//Fin Migration PB8-WYNIWYG-03/2006 FM
Long	 lCpt


itrTrans = SQLCA

This.isTitreLst = "Base : " + itrTrans.DataBase + ". Liste des profils (bo$$HEX1$$ee00$$ENDHEX$$tes $$HEX2$$e0002000$$ENDHEX$$archive)."

dw_1.ilMaxLig = 1000


/*------------------------------------------------------------------*/
/*   Description de la DW d'accueil                                 */
/*------------------------------------------------------------------*/
lCpt = 1
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_profil.id_profil"
dw_1.istCol[lCpt].sType			=	"Number"
dw_1.istCol[lCpt].sHeaderName	=	"Profil"
dw_1.istCol[lCpt].ilargeur		=	4
dw_1.istCol[lCpt].sAlignement	=	"2"
dw_1.istCol[lCpt].sInvisible	= 	"N"


lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_profil.lib_profil"
dw_1.istCol[lCpt].sType			=	"char(50)"
dw_1.istCol[lCpt].sHeaderName	=	"Libell$$HEX1$$e900$$ENDHEX$$"
dw_1.istCol[lCpt].ilargeur		=	40
dw_1.istCol[lCpt].sAlignement	=	"0"
dw_1.istCol[lCpt].sInvisible	= 	"N"


lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_profil.cree_le"
dw_1.istCol[lCpt].sType			=	"Datetime"
dw_1.istCol[lCpt].sHeaderName	=	"Cr$$HEX3$$e900e9002000$$ENDHEX$$le"
dw_1.istCol[lCpt].sFormat		=	"dd/mm/yyyy hh:mm:ss"
dw_1.istCol[lCpt].ilargeur		=	20
dw_1.istCol[lCpt].sAlignement	=	"2"
dw_1.istCol[lCpt].sInvisible	= 	"N"

lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_profil.maj_le"
dw_1.istCol[lCpt].sType			=	"Datetime"
dw_1.istCol[lCpt].sHeaderName	=	"Maj Le"
dw_1.istCol[lCpt].sFormat		=	"dd/mm/yyyy hh:mm:ss"
dw_1.istCol[lCpt].ilargeur		=	20
dw_1.istCol[lCpt].sAlignement	=	"2"
dw_1.istCol[lCpt].sInvisible	= 	"N"

lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_profil.maj_par"
dw_1.istCol[lCpt].sType			=	"char(4)"
dw_1.istCol[lCpt].sHeaderName	=	"Par"
dw_1.istCol[lCpt].ilargeur		=	4
dw_1.istCol[lCpt].sAlignement	=	"2"
dw_1.istCol[lCpt].sInvisible	= 	"N"

sTables [ 1 ] = "wkfs_profil"
sTables [ 2 ] = "compagnie"
sTables [ 3 ] = "code"

/*------------------------------------------------------------------*/
/*  Jointure entre les 2 tables ci-dessus :                         */
/*------------------------------------------------------------------*/
dw_1.isJointure  = "And sysadm.compagnie.id_cie = sysadm.wkfs_profil.id_cie "			+&
						 "And sysadm.code.id_typ_code = '-MC' "									+&
						 "And sysadm.code.id_code     = sysadm.wkfs_profil.id_typ_arch" 	

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
pb_Interro.istInterro.sTitre 					= "Interrogation Profil"
pb_Interro.istInterro.sDataObject			= "d_sp_int_wkfs_Profil"
pb_Interro.istInterro.sCodeDw					= "PROFIL"

pb_Interro.istInterro.sData[1].sNom			= "id_profil"
pb_Interro.istInterro.sData[1].sDbName		= "sysadm.wkfs_profil.id_profil"
pb_Interro.istInterro.sData[1].sType		= "NUMBER"
pb_Interro.istInterro.sData[1].sOperande	= "="
pb_Interro.istInterro.sData[1].sMoteur		= "MSS"

pb_Interro.istInterro.sData[2].sNom			= "id_cie"
pb_Interro.istInterro.sData[2].sDbName		= "sysadm.compagnie.id_cie"
pb_Interro.istInterro.sData[2].sType		= "NUMBER"
pb_Interro.istInterro.sData[2].sOperande	= "="
pb_Interro.istInterro.sData[2].sMoteur		= "MSS"

pb_Interro.istInterro.sData[3].sNom			= "id_typ_arch"
pb_Interro.istInterro.sData[3].sDbName		= "sysadm.wkfs_profil.id_typ_arch"
pb_Interro.istInterro.sData[3].sType		= "NUMBER"
pb_Interro.istInterro.sData[3].sOperande	= "="
pb_Interro.istInterro.sData[3].sMoteur		= "MSS"


istPass.trTrans 	= itrTrans



end on

on ue_creer;call w_8_accueil::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_wkfs_profil
//* Evenement 		: ue_creer
//* Auteur			: PLJ
//* Date				: 14/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Cr$$HEX1$$e900$$ENDHEX$$ation d'un nouveau profil
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Active   le bouton controler                                     */
/*------------------------------------------------------------------*/
istPass.bControl	= TRUE

f_OuvreTraitement ( w_trt_sp_wkfs_profil, istPass )
end on

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_wkfs_profil
//* Evenement 		: ue_modifier
//* Auteur			: PLJ
//* Date				: 14/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: modification d'un enregistrement
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re l'identifiant du profil                                 */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//istPass.sTab[1] 	= String ( dw_1.GetItemNumber ( dw_1.ilLigneClick, "WKFS_PROFIL.ID_PROFIL" ) )
istPass.sTab[1] 	= String ( dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_PROFIL" ) )
//Fin Migration PB8-WYNIWYG-03/2006 FM


/*------------------------------------------------------------------*/
/* Autorise la suppression d'un profil                              */
/* Active   le bouton controler                                     */
/*------------------------------------------------------------------*/
istPass.bSupprime	= TRUE
istPass.bControl	= TRUE

f_OuvreTraitement ( w_trt_sp_wkfs_profil, istPass ) 
end event

on w_a_sp_wkfs_profil.create
call super::create
end on

on w_a_sp_wkfs_profil.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_retour from w_8_accueil`pb_retour within w_a_sp_wkfs_profil
end type

type pb_interro from w_8_accueil`pb_interro within w_a_sp_wkfs_profil
end type

type pb_creer from w_8_accueil`pb_creer within w_a_sp_wkfs_profil
end type

type dw_1 from w_8_accueil`dw_1 within w_a_sp_wkfs_profil
integer width = 3241
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

type pb_tri from w_8_accueil`pb_tri within w_a_sp_wkfs_profil
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_sp_wkfs_profil
boolean visible = true
boolean enabled = true
end type

