HA$PBExportHeader$w_a_sp_anc_wkfs_w_queue.srw
$PBExportComments$Fenetre accueil ancetre pour le traitement de wkfs_w_queue : Centralisateur & Sold$$HEX2$$e9002000$$ENDHEX$$Priv$$HEX1$$e900$$ENDHEX$$
forward
global type w_a_sp_anc_wkfs_w_queue from w_8_accueil
end type
type dw_stk_operateur from datawindow within w_a_sp_anc_wkfs_w_queue
end type
type dw_trt_centraloper from datawindow within w_a_sp_anc_wkfs_w_queue
end type
end forward

global type w_a_sp_anc_wkfs_w_queue from w_8_accueil
integer x = 0
integer y = 0
integer width = 3639
integer height = 2000
string title = "Accueil - Archivage des dossiers papiers"
event ue_typ_trt pbm_custom01
dw_stk_operateur dw_stk_operateur
dw_trt_centraloper dw_trt_centraloper
end type
global w_a_sp_anc_wkfs_w_queue w_a_sp_anc_wkfs_w_queue

type variables
Protected:
Char	icOrigineTrt
end variables

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
//  #1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//*-----------------------------------------------------------------

DatawindowChild	dwChild
//Migration PB8-WYNIWYG-03/2006 FM
//String 				sTables [ 6 ]		// Tables du SELECT
String 				sTables []		// Tables du SELECT
//Fin Migration PB8-WYNIWYG-03/2006 FM
String 				sFichier, sOper, sPrvOper
Long					lCpt, lRet, lLigne


/*------------------------------------------------------------------*/
/* L' Origine de traitment sera arm$$HEX2$$e9002000$$ENDHEX$$sur les fen$$HEX1$$ea00$$ENDHEX$$tres descendantes  */
/*------------------------------------------------------------------*/
This.TriggerEvent ( "ue_typ_trt" )


itrTrans = SQLCA
This.isTitreLst = "Base : " + SQLCA.DataBase + ". Gestion de la queue d'archivage (bo$$HEX1$$ee00$$ENDHEX$$tes $$HEX2$$e0002000$$ENDHEX$$archive)."
dw_1.ilMaxLig = 0


/*------------------------------------------------------------------*/
/*   Description de la DW d'accueil                                 */
/*------------------------------------------------------------------*/
lCpt = 1
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_w_queue.id_sin"
dw_1.istCol[lCpt].sType			=	"Number"
dw_1.istCol[lCpt].sHeaderName	=	"Sinistre"
dw_1.istCol[lCpt].ilargeur		=	7
dw_1.istCol[lCpt].sAlignement	=	"2"
dw_1.istCol[lCpt].sInvisible	= 	"N"

lCpt++
dw_1.istCol[lCpt].sDbName		=	"sysadm.personne.nom"
//dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_w_queue.nom"
dw_1.istCol[lCpt].sType			=	"Char(35)"
dw_1.istCol[lCpt].sHeaderName	=	"Assur$$HEX1$$e900$$ENDHEX$$"
dw_1.istCol[lCpt].ilargeur		=	28
dw_1.istCol[lCpt].sAlignement	=	"0"
dw_1.istCol[lCpt].sInvisible	= 	"N"


lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_w_queue.id_prod"
dw_1.istCol[lCpt].sType			=	"Number"
dw_1.istCol[lCpt].sHeaderName	=	"Prod."
dw_1.istCol[lCpt].ilargeur		=	5
dw_1.istCol[lCpt].sAlignement	=	"2"
dw_1.istCol[lCpt].sInvisible	= 	"N"

lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.produit.lib_court"
dw_1.istCol[lCpt].sType			=	"Char(35)"
dw_1.istCol[lCpt].sHeaderName	=	"Libell$$HEX2$$e9002000$$ENDHEX$$Prod"
dw_1.istCol[lCpt].ilargeur		=	20
dw_1.istCol[lCpt].sAlignement	=	"0"
dw_1.istCol[lCpt].sInvisible	= 	"N"

lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_w_queue.id_cie"
dw_1.istCol[lCpt].sType			=	"Number"
//dw_1.istCol[lCpt].sHeaderName	=	"Cie"
//dw_1.istCol[lCpt].ilargeur		=	3
//dw_1.istCol[lCpt].sAlignement	=	"2"
dw_1.istCol[lCpt].sInvisible	= 	"O"

lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_w_queue.id_ets"
dw_1.istCol[lCpt].sType			=	"Number"
dw_1.istCol[lCpt].sInvisible	= 	"O"

//lCpt ++
//dw_1.istCol[lCpt].sDbName		=	"sysadm.compagnie.lib_cie"
//dw_1.istCol[lCpt].sType			=	"char(35)"
//dw_1.istCol[lCpt].sHeaderName	=	"Libelle Cie"
//dw_1.istCol[lCpt].ilargeur		=	20
//dw_1.istCol[lCpt].sAlignement	=	"0"
//dw_1.istCol[lCpt].sInvisible	= 	"N"

lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.code.lib_code"
//Migration PB8-WYNIWYG-03/2006 FM
//dw_1.istCol[lCpt].sType			=	"char(20)"
dw_1.istCol[lCpt].sType			=	"char(35)"
//Fin Migration PB8-WYNIWYG-03/2006 FM
dw_1.istCol[lCpt].sHeaderName	=	"Provenance"
dw_1.istCol[lCpt].ilargeur		=	15
dw_1.istCol[lCpt].sAlignement	=	"0"
dw_1.istCol[lCpt].sInvisible	= 	"N"

lCpt ++
//dw_1.istCol[lCpt].sDbName		=	"sysadm.sinistre.valide_le"
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_w_queue.valide_le_sin"
dw_1.istCol[lCpt].sType			=	"Datetime" // [PI056]
dw_1.istCol[lCpt].sHeaderName	=	"Valide le"
dw_1.istCol[lCpt].ilargeur		=	10
dw_1.istCol[lCpt].sAlignement	=	"2"
dw_1.istCol[lCpt].sInvisible	= 	"N"

lCpt ++
//dw_1.istCol[lCpt].sDbName		=	"sysadm.sinistre.valide_par"
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_w_queue.valide_par_sin"
dw_1.istCol[lCpt].sType			=	"Char(4)"
dw_1.istCol[lCpt].sHeaderName	=	"Par"
dw_1.istCol[lCpt].ilargeur		=	5
dw_1.istCol[lCpt].sAlignement	=	"2"
dw_1.istCol[lCpt].sInvisible	= 	"N"



sTables [ 1 ] = "wkfs_w_queue"
sTables [ 2 ] = "personne"
sTables [ 3 ] = "produit"
sTables [ 4 ] = "code"
sTables [ 5 ] = "sinistre"
sTables [ 6 ] = "routage"				// On effectue une jointure sur Routage pour savoir si on interroge :
												// - un soldage priv$$HEX1$$e900$$ENDHEX$$e 		routage.no_boite = -1  et wkfs_w_queue.id_prov =2
												// ou
												// - un dossier centralis$$HEX1$$e900$$ENDHEX$$e routage.no_boite = null
												//   venant aussi bien du soldage (id_prov = 2) que de la validation (id_prov = 1) 

/*------------------------------------------------------------------*/
/*  Jointure entre les 2 tables ci-dessus :                         */
/*------------------------------------------------------------------*/
dw_1.isJointure  = "AND sysadm.personne.id_ordre = sysadm.sinistre.id_ordre    "	 +&
						 "AND sysadm.produit.id_prod   = sysadm.wkfs_w_queue.id_prod "	 +&		
						 "AND sysadm.routage.id_sin    = sysadm.wkfs_w_queue.id_sin  "  +&
						 "AND sysadm.code.id_typ_code  = '-PW' "                        +&
						 "AND sysadm.code.id_code      = sysadm.wkfs_w_queue.id_prov "  +&
						 "AND sysadm.sinistre.id_sin   = sysadm.wkfs_w_queue.id_sin  "

/*------------------------------------------------------------------*/
/* Suivant l'origine :                                              */
/* Dossier Sold$$HEX12$$e90020002000200020002000200020002000200020002000$$ENDHEX$$m$$HEX1$$e900$$ENDHEX$$thode priv$$HEX1$$e900$$ENDHEX$$e     'P' cod_prov = 2      */
/* Dossier Sold$$HEX2$$e9002000$$ENDHEX$$ou Valid$$HEX2$$e9002000$$ENDHEX$$m$$HEX1$$e900$$ENDHEX$$thode centalis$$HEX1$$e900$$ENDHEX$$e 'C' cod_prov = 2 ou 1 */
/* On diff$$HEX1$$e900$$ENDHEX$$rencie le select                                         */
/*------------------------------------------------------------------*/
If icOrigineTrt = 'C' Then
	dw_1.isJointure += "AND sysadm.routage.no_boite	is null"
Else	
	dw_1.isJointure += "AND sysadm.routage.no_boite = '-1'"
End If



/*------------------------------------------------------------------*/
/* Tri par d$$HEX1$$e900$$ENDHEX$$faut de la Data Window d'accueil.                      */
/*------------------------------------------------------------------*/
Dw_1.isTri = "#1 A"

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/
dw_1.Uf_Creer_Tout ( dw_1.istCol, sTables, itrTrans )

wf_Construire_Chaine_Tri()


/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche                                             */
/*------------------------------------------------------------------*/
pb_Interro.istInterro.wAncetre				= This
pb_Interro.istInterro.sTitre 					= "Interrogation Regroupement"
pb_Interro.istInterro.sDataObject			= "d_sp_int_wkfs_w_queue"
pb_Interro.istInterro.sCodeDw					= "WKFS_W_QUEUE"

pb_Interro.istInterro.sData[1].sNom			= "id_sin"
pb_Interro.istInterro.sData[1].sDbName		= "sysadm.wkfs_w_queue.id_sin"
pb_Interro.istInterro.sData[1].sType		= "NUMBER"
pb_Interro.istInterro.sData[1].sOperande	= "="
pb_Interro.istInterro.sData[1].sMoteur		= "MSS"

pb_Interro.istInterro.sData[2].sNom			= "id_prod"
pb_Interro.istInterro.sData[2].sDbName		= "sysadm.wkfs_w_queue.id_prod"
pb_Interro.istInterro.sData[2].sType		= "NUMBER"
pb_Interro.istInterro.sData[2].sOperande	= "="
pb_Interro.istInterro.sData[2].sMoteur		= "MSS"

pb_Interro.istInterro.sData[3].sNom			= "id_cie"
pb_Interro.istInterro.sData[3].sDbName		= "sysadm.wkfs_w_queue.id_cie"
pb_Interro.istInterro.sData[3].sType		= "NUMBER"
pb_Interro.istInterro.sData[3].sOperande	= "="
pb_Interro.istInterro.sData[3].sMoteur		= "MSS"

pb_Interro.istInterro.sData[4].sNom			= "valide_par"
pb_Interro.istInterro.sData[4].sDbName		= "sysadm.wkfs_w_queue.valide_par_sin"
pb_Interro.istInterro.sData[4].sType		= "STRING"
pb_Interro.istInterro.sData[4].sOperande	= "="
pb_Interro.istInterro.sData[4].sMoteur		= "MSS"


/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= itrTrans


/*------------------------------------------------------------------*/
/* Chargement de la liste de tous les op$$HEX1$$e900$$ENDHEX$$rateurs                    */
/*------------------------------------------------------------------*/
//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//sFichier = stGlb.sWinDir + "\TEMP\OPAR" + stGlb.sCodAppli + ".TXT"
sFichier = stGlb.sRepTempo + "OPAR" + stGlb.sCodAppli + ".TXT"

lRet = dw_stk_operateur.ImportFile ( sFichier )

If lRet < 1 Then
	stMessage.sCode		= "BARC045"
	f_Message ( stMessage )
End IF

lLigne = dw_stk_Operateur.InsertRow (0)
dw_stk_Operateur.SetItem ( lLigne, "COD_OPER", "#SOL" )
dw_stk_Operateur.SetItem ( lLigne, "NOM",      "SOLDAGE AUTOMATIQUE" )

/*-------------------------------------------------------------------*/
/* Chargement de la liste des centres d'archivage                    */
/*-------------------------------------------------------------------*/
dw_trt_centralOper.InsertRow (0)
dw_trt_CentralOper.GetChild ( "ID_OPER", dwChild )
dwChild.SetTransObject ( SqlCa )
dwChild.Retrieve ( '-OA' )


end event

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_wkfs_w_queue
//* Evenement 		: ue_modifier
//* Auteur			: PLJ
//* Date				: 08/09/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: modification d'un enregistrement
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
Boolean	bok
String	sIdOper


bOk = True

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re l'identifiant du regroupement                           */
/* lTab[1] = ID_SIN                                                 */
/* lTab[2] = ID_PROD                                                */
/* lTab[3] = ID_ETS                                                 */
/* lTab[4] = ID_CIE                                                 */
/* sTab[1] = COD_OPER  (centralisateur #xxx)                        */
/* sTab[2] = CODE_FEN  pour ouvrir la fen$$HEX1$$ea00$$ENDHEX$$tre w_trt_sp_wkfs_w_queue */
/*                     soit fen$$HEX1$$ea00$$ENDHEX$$tre centralisateur                  */
/*                     soit fen$$HEX1$$ea00$$ENDHEX$$tre interro dossier sold$$HEX2$$e9002000$$ENDHEX$$et priv$$HEX3$$e90020002000$$ENDHEX$$*/
/*------------------------------------------------------------------*/

If icOrigineTrt = 'C' Then
	sIdOper = dw_Trt_CentralOper.GetItemString ( 1, "ID_OPER" )
	If isNull ( sIdOper ) Or sIdOper = '' Then
		stMessage.sCode		= "BARC040"
		f_Message ( stMessage )
		bOk =False
	End If
End If

If  icOrigineTrt = 'P' Then
	sIdOper = stglb.sCodOper
End If


If bOk Then

//Migration PB8-WYNIWYG-03/2006 FM
//	istPass.lTab [1] 	= dw_1.GetItemNumber ( dw_1.ilLigneClick, "WKFS_W_QUEUE.ID_SIN"  )
//	istPass.lTab [2] 	= dw_1.GetItemNumber ( dw_1.ilLigneClick, "WKFS_W_QUEUE.ID_PROD" )
//	istPass.lTab [3] 	= dw_1.GetItemNumber ( dw_1.ilLigneClick, "WKFS_W_QUEUE.ID_ETS"  )
//	istPass.lTab [4] 	= dw_1.GetItemNumber ( dw_1.ilLigneClick, "WKFS_W_QUEUE.ID_CIE"  )
	istPass.lTab [1] 	= dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_SIN"  )
	istPass.lTab [2] 	= dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_PROD" )
	istPass.lTab [3] 	= dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_ETS"  )
	istPass.lTab [4] 	= dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_CIE"  )
//Fin Migration PB8-WYNIWYG-03/2006 FM
	istPass.sTab [1]  = sIdOper
	istPass.sTab [2]  = icOrigineTrt


	/*------------------------------------------------------------------*/
	/* Autorise la suppression d'un regroupement                        */
	/* Active   le bouton controler                                     */
	/*------------------------------------------------------------------*/
	istPass.bSupprime	= False
	istPass.bControl	= False

	f_OuvreTraitement ( w_trt_sp_wkfs_w_queue, istPass ) 

End If
end event

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

W_Interro.Dw_1.GetChild ( "VALIDE_PAR", dwChild   )
dw_Stk_Operateur.ShareData (dwChild)







end on

on w_a_sp_anc_wkfs_w_queue.create
int iCurrent
call super::create
this.dw_stk_operateur=create dw_stk_operateur
this.dw_trt_centraloper=create dw_trt_centraloper
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_stk_operateur
this.Control[iCurrent+2]=this.dw_trt_centraloper
end on

on w_a_sp_anc_wkfs_w_queue.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_stk_operateur)
destroy(this.dw_trt_centraloper)
end on

type cb_debug from w_8_accueil`cb_debug within w_a_sp_anc_wkfs_w_queue
end type

type pb_retour from w_8_accueil`pb_retour within w_a_sp_anc_wkfs_w_queue
integer width = 242
integer height = 144
integer taborder = 50
end type

type pb_interro from w_8_accueil`pb_interro within w_a_sp_anc_wkfs_w_queue
integer x = 261
integer width = 242
integer height = 144
integer taborder = 70
end type

type pb_creer from w_8_accueil`pb_creer within w_a_sp_anc_wkfs_w_queue
boolean visible = false
integer width = 242
integer height = 144
integer taborder = 60
end type

type dw_1 from w_8_accueil`dw_1 within w_a_sp_anc_wkfs_w_queue
end type

on dw_1::ue_majaccueil;call w_8_accueil`dw_1::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_wkfs_regroup::dw_1
//* Evenement 		: ue_majaccueil
//* Auteur			: PLJ
//* Date				: 13/10/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: On se repositionne sur la premi$$HEX1$$e800$$ENDHEX$$re ligne
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.SetRow (1)
This.ScrollToRow (1)


end on

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

type pb_tri from w_8_accueil`pb_tri within w_a_sp_anc_wkfs_w_queue
integer x = 503
integer width = 242
integer height = 144
integer taborder = 80
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_sp_anc_wkfs_w_queue
boolean visible = true
integer x = 754
integer width = 242
integer height = 144
boolean enabled = true
end type

type dw_stk_operateur from datawindow within w_a_sp_anc_wkfs_w_queue
boolean visible = false
integer x = 2537
integer y = 500
integer width = 978
integer height = 1044
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_stk_sp_operateur_arch"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_trt_centraloper from datawindow within w_a_sp_anc_wkfs_w_queue
integer x = 1408
integer y = 36
integer width = 1874
integer height = 108
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_trt_sp_centraloper"
boolean border = false
boolean livescroll = true
end type

