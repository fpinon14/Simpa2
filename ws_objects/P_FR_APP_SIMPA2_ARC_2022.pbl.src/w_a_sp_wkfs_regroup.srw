HA$PBExportHeader$w_a_sp_wkfs_regroup.srw
forward
global type w_a_sp_wkfs_regroup from w_8_accueil
end type
end forward

global type w_a_sp_wkfs_regroup from w_8_accueil
integer x = 0
integer y = 0
integer width = 3639
integer height = 2000
string title = "Accueil - Gestion des regroupements"
end type
global w_a_sp_wkfs_regroup w_a_sp_wkfs_regroup

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_wkfs_regroup
//* Evenement 		: OPEN
//* Auteur			: PLJ
//* Date				: 20/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
//Migration PB8-WYNIWYG-03/2006 FM
//String 	sTables [ 3 ]		// Tables du SELECT
String 	sTables []		// Tables du SELECT
//Fin Migration PB8-WYNIWYG-03/2006 FM
Long		lCpt


itrTrans = SQLCA

This.isTitreLst = "Base : " + SQLCA.DataBase + ". Liste des regroupements (bo$$HEX1$$ee00$$ENDHEX$$tes $$HEX2$$e0002000$$ENDHEX$$archive)."

dw_1.ilMaxLig = 1000


/*------------------------------------------------------------------*/
/*   Description de la DW d'accueil                                 */
/*------------------------------------------------------------------*/
lCpt = 1
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_regroup.id_prod"
dw_1.istCol[lCpt].sType			=	"Number"
dw_1.istCol[lCpt].sHeaderName	=	"Prod."
dw_1.istCol[lCpt].ilargeur		=	4
dw_1.istCol[lCpt].sAlignement	=	"2"
dw_1.istCol[lCpt].sInvisible	= 	"N"

lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_regroup.id_ets"
dw_1.istCol[lCpt].sType			=	"Number"
dw_1.istCol[lCpt].sHeaderName	=	"Ets"
dw_1.istCol[lCpt].ilargeur		=	6
dw_1.istCol[lCpt].sAlignement	=	"2"
dw_1.istCol[lCpt].sInvisible	= 	"N"

lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_regroup.id_cie"
dw_1.istCol[lCpt].sType			=	"Number"
dw_1.istCol[lCpt].sHeaderName	=	"Cie"
dw_1.istCol[lCpt].ilargeur		=	6
dw_1.istCol[lCpt].sAlignement	=	"2"
dw_1.istCol[lCpt].sInvisible	= 	"N"

lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.compagnie.lib_cie"
dw_1.istCol[lCpt].sType			=	"char(35)"
dw_1.istCol[lCpt].sHeaderName	=	"Libelle Cie"
dw_1.istCol[lCpt].ilargeur		=	20
dw_1.istCol[lCpt].sAlignement	=	"0"
dw_1.istCol[lCpt].sInvisible	= 	"N"

lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_regroup.id_profil"
dw_1.istCol[lCpt].sType			=	"Number"
dw_1.istCol[lCpt].sHeaderName	=	"Profil"
dw_1.istCol[lCpt].ilargeur		=	6
dw_1.istCol[lCpt].sAlignement	=	"2"
dw_1.istCol[lCpt].sInvisible	= 	"O"

lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_profil.lib_profil"
dw_1.istCol[lCpt].sType			=	"Char(50)"
dw_1.istCol[lCpt].sHeaderName	=	"Libelle Profil"
dw_1.istCol[lCpt].ilargeur		=	50
dw_1.istCol[lCpt].sAlignement	=	"0"
dw_1.istCol[lCpt].sInvisible	= 	"N"

lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_regroup.cree_le"
dw_1.istCol[lCpt].sType			=	"Datetime"
dw_1.istCol[lCpt].sHeaderName	=	"Cr$$HEX3$$e900e9002000$$ENDHEX$$le"
dw_1.istCol[lCpt].sFormat		=	"dd/mm/yyyy hh:mm:ss"
dw_1.istCol[lCpt].ilargeur		=	20
dw_1.istCol[lCpt].sAlignement	=	"2"
dw_1.istCol[lCpt].sInvisible	= 	"O"

lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_regroup.maj_le"
dw_1.istCol[lCpt].sType			=	"Datetime"
dw_1.istCol[lCpt].sHeaderName	=	"Maj Le"
dw_1.istCol[lCpt].sFormat		=	"dd/mm/yyyy hh:mm:ss"
dw_1.istCol[lCpt].ilargeur		=	20
dw_1.istCol[lCpt].sAlignement	=	"2"
dw_1.istCol[lCpt].sInvisible	= 	"O"

lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_regroup.maj_par"
dw_1.istCol[lCpt].sType			=	"char(4)"
dw_1.istCol[lCpt].sHeaderName	=	"Par"
dw_1.istCol[lCpt].ilargeur		=	4
dw_1.istCol[lCpt].sAlignement	=	"2"
dw_1.istCol[lCpt].sInvisible	= 	"O"

lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_regroup.dte_val_deb"
dw_1.istCol[lCpt].sType			=	"Datetime" // [PI056]
dw_1.istCol[lCpt].sInvisible	= 	"O"

lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_regroup.dte_val_fin"
dw_1.istCol[lCpt].sType			=	"Datetime" // [PI056]
dw_1.istCol[lCpt].sInvisible	= 	"O"


sTables [ 1 ] = "wkfs_regroup"
sTables [ 2 ] = "wkfs_profil"
sTables [ 3 ] = "compagnie"


/*------------------------------------------------------------------*/
/*  Jointure entre les 3 tables ci-dessus :                         */
/*------------------------------------------------------------------*/
dw_1.isJointure  = "And sysadm.compagnie.id_cie = sysadm.wkfs_regroup.id_cie " +&		
						 "And sysadm.wkfs_regroup.id_profil = sysadm.wkfs_profil.id_profil " 

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
pb_Interro.istInterro.sTitre 					= "Interrogation Regroupement"
pb_Interro.istInterro.sDataObject			= "d_sp_int_wkfs_Regroup"
pb_Interro.istInterro.sCodeDw					= "PROFIL"

pb_Interro.istInterro.sData[1].sNom			= "id_prod"
pb_Interro.istInterro.sData[1].sDbName		= "sysadm.wkfs_regroup.id_prod"
pb_Interro.istInterro.sData[1].sType		= "NUMBER"
pb_Interro.istInterro.sData[1].sOperande	= "="
pb_Interro.istInterro.sData[1].sMoteur		= "MSS"

pb_Interro.istInterro.sData[2].sNom			= "id_ets"
pb_Interro.istInterro.sData[2].sDbName		= "sysadm.wkfs_regroup.id_ets"
pb_Interro.istInterro.sData[2].sType		= "NUMBER"
pb_Interro.istInterro.sData[2].sOperande	= "="
pb_Interro.istInterro.sData[2].sMoteur		= "MSS"

pb_Interro.istInterro.sData[3].sNom			= "id_cie"
pb_Interro.istInterro.sData[3].sDbName		= "sysadm.wkfs_regroup.id_cie"
pb_Interro.istInterro.sData[3].sType		= "NUMBER"
pb_Interro.istInterro.sData[3].sOperande	= "="
pb_Interro.istInterro.sData[3].sMoteur		= "MSS"

pb_Interro.istInterro.sData[4].sNom			= "id_profil"
pb_Interro.istInterro.sData[4].sDbName		= "sysadm.wkfs_regroup.id_profil"
pb_Interro.istInterro.sData[4].sType		= "NUMBER"
pb_Interro.istInterro.sData[4].sOperande	= "="
pb_Interro.istInterro.sData[4].sMoteur		= "MSS"

/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= itrTrans

end event

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_wkfs_regroup
//* Evenement 		: ue_modifier
//* Auteur			: PLJ
//* Date				: 20/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: modification d'un enregistrement
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re l'identifiant du regroupement                           */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//istPass.lTab [1] 	= dw_1.GetItemNumber ( dw_1.ilLigneClick, "WKFS_REGROUP.ID_PROD"      )
//istPass.lTab [2] 	= dw_1.GetItemNumber ( dw_1.ilLigneClick, "WKFS_REGROUP.ID_ETS"       )
//istPass.lTab [3] 	= dw_1.GetItemNumber ( dw_1.ilLigneClick, "WKFS_REGROUP.ID_CIE"       )
//istPass.dTab [1] 	= dw_1.GetItemDate   ( dw_1.ilLigneClick, "WKFS_REGROUP.DTE_VAL_DEB"  )
istPass.lTab [1] 	= dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_PROD"      )
istPass.lTab [2] 	= dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_ETS"       )
istPass.lTab [3] 	= dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_CIE"       )
istPass.dTab [1] 	= Date(dw_1.GetItemDatetime   ( dw_1.ilLigneClick, "DTE_VAL_DEB"  )) // [PI056]
//Fin Migration PB8-WYNIWYG-03/2006 FM


/*------------------------------------------------------------------*/
/* Autorise la suppression d'un regroupement                        */
/* Active   le bouton controler                                     */
/*------------------------------------------------------------------*/
istPass.bSupprime	= TRUE
istPass.bControl	= TRUE

f_OuvreTraitement ( w_trt_sp_wkfs_regroup, istPass ) 
end event

on ue_creer;call w_8_accueil::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_wkfs_regroup
//* Evenement 		: ue_creer
//* Auteur			: PLJ
//* Date				: 20/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Cr$$HEX1$$e900$$ENDHEX$$ation d'un nouveau profil
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long  lNull
Date	dtNull

SetNull ( lNull )

/*------------------------------------------------------------------*/
/* Active   le bouton controler sur la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement        */
/*------------------------------------------------------------------*/

istPass.bControl	= TRUE
istPass.lTab[1] 	= lNull
istPass.lTab[2] 	= lNull
istPass.lTab[3] 	= lNull
istPass.dTab[1] 	= dtNull

f_OuvreTraitement ( w_trt_sp_wkfs_regroup, istPass )


end on

on ue_preparer_interro;call w_8_accueil::ue_preparer_interro;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_wkfs_regroup
//* Evenement 		: ue_preparer_interro
//* Auteur			: PLJ
//* Date				: 20/08/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation des DDDW de la fen$$HEX1$$ea00$$ENDHEX$$tre d'interrogation
//*
//* Commentaires	: Aucun
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild		dwChild


W_Interro.Dw_1.GetChild ( "id_prod", dwChild  ) 
dwChild.SetTransObject  ( SQLCA )
dwChild.Retrieve        ()

W_Interro.Dw_1.GetChild ( "id_cie", dwChild   )
dwChild.SetTransObject  ( SQLCA )
dwChild.Retrieve        ()

W_Interro.Dw_1.GetChild ( "id_profil", dwChild)
dwChild.SetTransObject  ( SQLCA )
dwChild.Retrieve        ()




end on

on w_a_sp_wkfs_regroup.create
call super::create
end on

on w_a_sp_wkfs_regroup.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type cb_debug from w_8_accueil`cb_debug within w_a_sp_wkfs_regroup
end type

type pb_retour from w_8_accueil`pb_retour within w_a_sp_wkfs_regroup
integer width = 242
integer height = 144
end type

type pb_interro from w_8_accueil`pb_interro within w_a_sp_wkfs_regroup
integer width = 242
integer height = 144
end type

type pb_creer from w_8_accueil`pb_creer within w_a_sp_wkfs_regroup
integer width = 242
integer height = 144
end type

type dw_1 from w_8_accueil`dw_1 within w_a_sp_wkfs_regroup
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

type pb_tri from w_8_accueil`pb_tri within w_a_sp_wkfs_regroup
integer width = 242
integer height = 144
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_sp_wkfs_regroup
boolean visible = true
integer width = 242
integer height = 144
boolean enabled = true
end type

