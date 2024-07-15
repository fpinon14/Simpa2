HA$PBExportHeader$w_a_sp_wkfs_boite.srw
forward
global type w_a_sp_wkfs_boite from w_8_accueil
end type
type pb_fermer_boite from picturebutton within w_a_sp_wkfs_boite
end type
end forward

global type w_a_sp_wkfs_boite from w_8_accueil
integer width = 3685
pb_fermer_boite pb_fermer_boite
end type
global w_a_sp_wkfs_boite w_a_sp_wkfs_boite

on open;call w_8_accueil::open;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_wkfs_boite
//* Evenement 		: OPEN
//* Auteur			: PLJ
//* Date				: 09/09/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
//Migration PB8-WYNIWYG-03/2006 FM
//String sTables [ 2 ]		// Tables du SELECT
String sTables []		// Tables du SELECT
//Fin Migration PB8-WYNIWYG-03/2006 FM
Long	 lCpt


itrTrans = SQLCA

This.isTitreLst = "Base : " + itrTrans.DataBase + ". Liste des bo$$HEX1$$ee00$$ENDHEX$$tes (bo$$HEX1$$ee00$$ENDHEX$$tes $$HEX2$$e0002000$$ENDHEX$$archive)."

dw_1.ilMaxLig = 1000


/*------------------------------------------------------------------*/
/*   Description de la DW d'accueil                                 */
/*------------------------------------------------------------------*/
lCpt = 1
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_boite.no_boite"
dw_1.istCol[lCpt].sResultSet  =  "NO_BOITE"
dw_1.istCol[lCpt].sType			=	"Char(10)"
dw_1.istCol[lCpt].sHeaderName	=	"N$$HEX2$$b0002000$$ENDHEX$$Boite"
dw_1.istCol[lCpt].ilargeur		=	7
dw_1.istCol[lCpt].sAlignement	=	"0"
dw_1.istCol[lCpt].sInvisible	= 	"N"


lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_boite.id_oper"
dw_1.istCol[lCpt].sResultSet  =  "ID_OPER"
dw_1.istCol[lCpt].sType			=	"char(4)"
dw_1.istCol[lCpt].sHeaderName	=	"Oper"
dw_1.istCol[lCpt].ilargeur		=	4
dw_1.istCol[lCpt].sAlignement	=	"0"
dw_1.istCol[lCpt].sInvisible	= 	"N"


lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_profil.id_profil"
dw_1.istCol[lCpt].sResultSet  =  "ID_PROFIL"
dw_1.istCol[lCpt].sType			=	"Number"
dw_1.istCol[lCpt].sHeaderName	=	"N$$HEX1$$b000$$ENDHEX$$"
dw_1.istCol[lCpt].ilargeur		=	5
dw_1.istCol[lCpt].sAlignement	=	"2"
dw_1.istCol[lCpt].sInvisible	= 	"N"

lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_profil.lib_profil"
dw_1.istCol[lCpt].sResultSet  =  "LIB_PROFIL"
dw_1.istCol[lCpt].sType			=	"char(50)"
dw_1.istCol[lCpt].sHeaderName	=	"Libell$$HEX2$$e9002000$$ENDHEX$$profil"
dw_1.istCol[lCpt].ilargeur		=	50
dw_1.istCol[lCpt].sAlignement	=	"0"
dw_1.istCol[lCpt].sInvisible	= 	"N"


lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_boite.alt_ouverte"
dw_1.istCol[lCpt].sResultSet  =  "ALT_OUVERTE"
dw_1.istCol[lCpt].sType			=	"Char(1)"
dw_1.istCol[lCpt].sHeaderName	=	"Ouverte"
dw_1.istCol[lCpt].ilargeur		=	7
dw_1.istCol[lCpt].sAlignement	=	"2"
dw_1.istCol[lCpt].sInvisible	= 	"N"

lCpt ++
dw_1.istCol[lCpt].sDbName		=	"sysadm.wkfs_boite.cree_le"
dw_1.istCol[lCpt].sResultSet  =  "CREE_LE"
dw_1.istCol[lCpt].sType			=	"DateTime"
dw_1.istCol[lCpt].sHeaderName	=	"Cr$$HEX3$$e900e9002000$$ENDHEX$$le"
dw_1.istCol[lCpt].sFormat		=	"dd/mm/yyyy hh:mm"
dw_1.istCol[lCpt].ilargeur		=	17
dw_1.istCol[lCpt].sAlignement	=	"2"
dw_1.istCol[lCpt].sInvisible	= 	"N"




sTables [ 1 ] = "wkfs_profil"
sTables [ 2 ] = "wkfs_boite"

/*------------------------------------------------------------------*/
/*  Jointure entre les 2 tables ci-dessus :                         */
/*------------------------------------------------------------------*/
dw_1.isJointure  = "And sysadm.wkfs_boite.id_profil = sysadm.wkfs_profil.id_profil "

/*------------------------------------------------------------------*/
/* Tri par d$$HEX1$$e900$$ENDHEX$$faut de la Data Window d'accueil.                      */
/*------------------------------------------------------------------*/
Dw_1.isTri = "#2 A, #3 A, #1 A"

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/
dw_1.Uf_Creer_Tout( dw_1.istCol, sTables, itrTrans )

wf_Construire_Chaine_Tri()


//dw_1.Modify ( 	"no_boite.color='0~tIF(alt_ouverte=~~'N~~', 86, 3173376 )' "     +&		
//					"no_boite.Font.Weight='0~tIF(alt_ouverte=~~'N~~', 400, 700 )'"   +&
//					"id_oper.color='0~tIF(alt_ouverte=~~'N~~', 86, 3173376 )'"  	  +&
//					"id_oper.Font.Weight='0~tIF(alt_ouverte=~~'N~~', 400, 700 )'"    +&
//               "id_profil.color='0~tIF(alt_ouverte=~~'N~~', 86, 3173376 )'"     +&
//					"id_profil.Font.Weight='0~tIF(alt_ouverte=~~'N~~', 400, 700 )'"  +&
//               "lib_profil.color='0~tIF(alt_ouverte=~~'N~~', 86, 3173376 )'"    +&
//					"lib_profil.Font.Weight='0~tIF(alt_ouverte=~~'N~~', 400, 700 )'" +&
//               "alt_ouverte.color='0~tIF(alt_ouverte=~~'N~~', 86, 3173376 )'"   +&
//					"alt_ouverte.Font.Weight='0~tIF(alt_ouverte=~~'N~~', 400, 700 )'"+&
//               "cree_le.color='0~tIF(alt_ouverte=~~'N~~', 86, 3173376 )'"       +&
//					"cree_le.Font.Weight='0~tIF(alt_ouverte=~~'N~~', 400, 700 )'"    &
//)

dw_1.Modify ( 	"no_boite.color='0~tIF(alt_ouverte=~~'N~~', 86, 3173376 )' "     +&		
					"id_oper.color='0~tIF(alt_ouverte=~~'N~~', 86, 3173376 )'"  	  +&
               "id_profil.color='0~tIF(alt_ouverte=~~'N~~', 86, 3173376 )'"     +&
               "lib_profil.color='0~tIF(alt_ouverte=~~'N~~', 86, 7986521 )'"    +&
               "alt_ouverte.color='0~tIF(alt_ouverte=~~'N~~', 86, 3173376 )'"   +&
               "cree_le.color='0~tIF(alt_ouverte=~~'N~~', 86, 3173376 )'"        &
)

/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche                                             */
/*------------------------------------------------------------------*/
pb_Interro.istInterro.wAncetre				= This
pb_Interro.istInterro.sTitre 					= "Interrogation Profil"
pb_Interro.istInterro.sDataObject			= "d_sp_int_wkfs_Boite"
pb_Interro.istInterro.sCodeDw					= "PROFIL"

pb_Interro.istInterro.sData[1].sNom			= "id_profil"
pb_Interro.istInterro.sData[1].sDbName		= "sysadm.wkfs_profil.id_profil"
pb_Interro.istInterro.sData[1].sType		= "NUMBER"
pb_Interro.istInterro.sData[1].sOperande	= "="
pb_Interro.istInterro.sData[1].sMoteur		= "MSS"

pb_Interro.istInterro.sData[2].sNom			= "id_oper"
pb_Interro.istInterro.sData[2].sDbName		= "sysadm.wkfs_boite.id_oper"
pb_Interro.istInterro.sData[2].sType		= "NUMBER"
pb_Interro.istInterro.sData[2].sOperande	= "="
pb_Interro.istInterro.sData[2].sMoteur		= "MSS"


istPass.trTrans 	= itrTrans

end on

on ue_modifier;call w_8_accueil::ue_modifier;//s_Pass	stPass
//
//lLigne = Dw_1.GetRow()
//
//If dw_Stk_Boite.RowCount() = 0 Then
//	dw_Stk_Boite.InsertRow()
//End If
//
//dw_Stk_Boite.SetItem
//
//stPass.udwTab[1] = dw_stk_boite
//
//stPass.sTab[1]   = 'FERMER'
//OpenWithParm  ( w_trt_sp_wkfs_boite, stPass, Parent )
//
end on

on ue_preparer_interro;call w_8_accueil::ue_preparer_interro;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_wkfs_boite
//* Evenement 		: ue_preparer_interro
//* Auteur			: PLJ
//* Date				: 09/09/2004
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
end on

on w_a_sp_wkfs_boite.create
int iCurrent
call super::create
this.pb_fermer_boite=create pb_fermer_boite
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_fermer_boite
end on

on w_a_sp_wkfs_boite.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_fermer_boite)
end on

type pb_retour from w_8_accueil`pb_retour within w_a_sp_wkfs_boite
integer taborder = 40
end type

type pb_interro from w_8_accueil`pb_interro within w_a_sp_wkfs_boite
integer taborder = 60
end type

type pb_creer from w_8_accueil`pb_creer within w_a_sp_wkfs_boite
integer taborder = 50
end type

type dw_1 from w_8_accueil`dw_1 within w_a_sp_wkfs_boite
integer x = 32
integer width = 3515
integer taborder = 30
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

type pb_tri from w_8_accueil`pb_tri within w_a_sp_wkfs_boite
integer taborder = 70
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_sp_wkfs_boite
integer x = 1358
end type

type pb_fermer_boite from picturebutton within w_a_sp_wkfs_boite
integer x = 1001
integer y = 16
integer width = 334
integer height = 136
integer taborder = 20
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Fermer Boite"
string picturename = "k:\pb4obj\bmp\fermboit.bmp"
end type

event clicked;/* 
#1 10/04/2006 - MADM - Migration 
 		Modifs test retour de nombre de ligne
*/

Long lLigne, lRet 
String	sNoBoite

lLigne = Dw_1.GetRow ()

//#1
If lLigne = 0 Then return

stMessage.sTitre		= "FERMETURE BOITE ARCHIVE"
stMessage.Icon			= Question!
stMessage.bErreurG	= False
stMessage.Bouton		= YesNo!
stMessage.sCode		= "BARC050" 
stMessage.bTrace  	= False
stMessage.sVar[1]    = dw_1.GetItemString ( lLigne, "NO_BOITE"   )
stMessage.sVar[2] 	= dw_1.GetItemString ( lLigne, "LIB_PROFIL" )
stMessage.sVar[3] 	= dw_1.GetItemString ( lLigne, "ID_OPER"    )

lRet =  f_Message ( stMessage )

If lRet = 1 Then
	dw_1.SetItem ( lLigne, "ALT_OUVERTE", 'N' )

	sNoBoite = dw_1.GetItemString ( lLigne, "NO_BOITE" )

//	UPDATE sysadm.wkfs_boite SET alt_ouverte = 'N'
//    WHERE no_boite = :sNoBoite
//	 USING itrTrans;
//
//	f_Commit ( itrTrans, True )

End If


end event

