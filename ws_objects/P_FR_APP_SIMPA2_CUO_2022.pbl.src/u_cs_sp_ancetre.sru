HA$PBExportHeader$u_cs_sp_ancetre.sru
forward
global type u_cs_sp_ancetre from nonvisualobject
end type
end forward

global type u_cs_sp_ancetre from nonvisualobject
end type
global u_cs_sp_ancetre u_cs_sp_ancetre

type variables
Protected :

u_Transaction		itrTrans
s_Pass			istPass

DataWindow		idw_Si_Produit		// sur fen$$HEX1$$ea00$$ENDHEX$$tre consultation Sinistre
DataWindow		idw_Si_Frais
DataWindow		idw_Si_CodeGarantie
DataWindow		idw_Si_CodeCondition
DataWindow		idw_Si_CodeCarTc
DataWindow		idw_Si_Detail
DataWindow		idw_Si_Refus
DataWindow		idw_Si_Motif
DataWindow		idw_Si_RegGti
DataWindow		idw_Si_Corb
DataWindow		idddw_code_divsin_charg_tempo, idddw_codecar_divsin_charg_tempo

U_DataWindow		idw_Si_Sinistre		// sur fen$$HEX1$$ea00$$ENDHEX$$tre consultation Sinistre
U_DataWindow		idw_In_Inter		// sur fen$$HEX1$$ea00$$ENDHEX$$tre consultation Interlocuteur
U_DataWindow		idw_Ga_Gti		// sur fen$$HEX1$$ea00$$ENDHEX$$tre consultation Garantie
U_DataWindow		idw_Dt_Detail		// sur fen$$HEX1$$ea00$$ENDHEX$$tre consultation Detail
U_DataWindow		idw_Rg_Reglement	              // sur fen$$HEX1$$ea00$$ENDHEX$$tre consultation Reglement
U_DataWindow		idw_Rg_RegGti	              // sur fen$$HEX1$$ea00$$ENDHEX$$tre consultation Reglement
U_DataWindow		idw_Rg_RegFrais		// sur fen$$HEX1$$ea00$$ENDHEX$$tre consultation Reglement
U_DataWindow		idw_DosSuiviPar
U_DataWindow		idw_BoiteArchive
U_DataWindow		idw_DetPro
U_DataWindow		idw_DivSin
U_DataWindow		idw_DivDet

U_DataWindow_Detail	idw_Si_Inter		// sur fen$$HEX1$$ea00$$ENDHEX$$tre consultation Sinistre
U_DataWindow_Detail	idw_Si_Gti
U_DataWindow_Detail	idw_Si_Reglement
U_DataWindow_Detail	idw_In_Frais		// sur fen$$HEX1$$ea00$$ENDHEX$$tre consultation Interlocuteur
U_DataWindow_Detail	idw_Ga_Detail		// sur fen$$HEX1$$ea00$$ENDHEX$$tre consultation Garantie
U_DataWindow_Detail	idw_LstContact
U_DataWindow_Detail	idw_LstCmde

U_Tagger		iuo_Ga_Refus		// sur fen$$HEX1$$ea00$$ENDHEX$$tre consultation Garantie
U_Tagger		iuo_Dt_Refus		// sur fen$$HEX1$$ea00$$ENDHEX$$tre consultation Detail

U_Onglets		iuo_Onglet

Long			ilDernierIdProd  = -9
Long			ilDernierIdRev   = -9

//String			isRepWin

Boolean			ibAltContact
Boolean			ibAltContactSherpa 
Boolean			ibAltTelephonie 
Boolean			ibAltCmdeMobile 
end variables

event constructor;////*-----------------------------------------------------------------
////*
////* Objet			: U_Cs_Sp_Ancetre::Constructor
////* Evenement 		: Constructor
////* Auteur			: Erick John Stark
////* Date				: 17/07/2002 16:51:34
////* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
////* Commentaires	: //[I037] Migration FUNCKy
////*				  
////* Arguments		: (Aucun)
////*
////* Retourne		: (Rien)
////*				  
////*-----------------------------------------------------------------
////* MAJ   PAR      Date	     Modification
////* #..   ...   ../../....   
////* 
////*-----------------------------------------------------------------
//
//String sRepWin
//u_DeclarationFuncky uoDeclarationFuncky
//
//uoDeclarationFuncky = Create u_DeclarationFuncky
//sRepWin = uoDeclarationFuncky.Uf_WinDir ()
//Destroy uoDeclarationFuncky
//
///*------------------------------------------------------------------*/
///* On initialise aussi une variable d'instance qui contient le      */
///* r$$HEX1$$e900$$ENDHEX$$pertoire de Windows. Cette variable sera utilis$$HEX1$$e900$$ENDHEX$$e pour la      */
///* gestion des courriers Word. (PC, PS, CP).                        */
///*------------------------------------------------------------------*/
//isRepWin			= sRepWin
//
end event

on u_cs_sp_ancetre.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_cs_sp_ancetre.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

