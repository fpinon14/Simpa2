$PBExportHeader$w_sp_trt_stat2.srw
$PBExportComments$Statistique sur les Stocks/Articles
forward
global type w_sp_trt_stat2 from w_8_accueil
end type
type cb_lancer from commandbutton within w_sp_trt_stat2
end type
type dw_stat from datawindow within w_sp_trt_stat2
end type
type st_avertissement_monnaie from u_st_avertissement_monnaie within w_sp_trt_stat2
end type
end forward

global type w_sp_trt_stat2 from w_8_accueil
integer width = 2921
integer height = 1032
cb_lancer cb_lancer
dw_stat dw_stat
st_avertissement_monnaie st_avertissement_monnaie
end type
global w_sp_trt_stat2 w_sp_trt_stat2

type variables
Private :

String	isRepExcel

String	K_TEMP = "\TEMP\"
String	K_FICSTAT = "STATSTCK.XLS"

end variables

forward prototypes
public function boolean wf_controlersaisie ()
public subroutine wf_positionnerobjets ()
end prototypes

public function boolean wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_ControlerSaisie (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 06/10/2001
//* Libellé			: 
//* Commentaires	: Controle de saisie
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//  #1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//*-----------------------------------------------------------------
String sCol [ ]
String 		sVal
Long 			lCpt, lNbrCol
Boolean		bOk

bOk = TRUE
dw_1.AcceptText ()

/*------------------------------------------------------------------*/
/* Controle de saisie de la partie Client.                          */
/*------------------------------------------------------------------*/
sCol[ 1 ] = "ID_FOUR"

lNbrCol	 = UpperBound ( sCol )

stMessage.sTitre  	= "Controle de saisie"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= Ok!
stMessage.sCode		= "COMD025"

/*------------------------------------------------------------------*/
/* Controle de saisie normal.                                       */
/*------------------------------------------------------------------*/
For lCpt = 1 To lNbrCol

	CHOOSE CASE lCpt
		CASE 1
			sVal = dw_1.GetItemString ( 1, sCol [ lCpt ] )
	END CHOOSE

	If IsNull ( sVal ) or sVal = ""	Then
		bOk = False
	End If

Next

/*------------------------------------------------------------------*/
/* Suppression du fichier destination existant.                     */
/*------------------------------------------------------------------*/
If bOk then

//Migration PB8-WYNIWYG-03/2006 CP
//	If FileExists ( isRepWin + K_TEMP + K_FICSTAT ) Then
	//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
	If f_FileExists ( stGlb.sRepTempo + K_FICSTAT ) Then	
//Fin Migration PB8-WYNIWYG-03/2006 CP	
		//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
		If Not FileDelete ( stGlb.sRepTempo + K_FICSTAT ) Then
			stMessage.sCode		= "COMD027"
			//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
			stMessage.sVar[1]		= Upper ( stGlb.sRepTempo + K_FICSTAT )
			bOk = False
		End If
	End If
End If

/*------------------------------------------------------------------*/
/* Variable du chemin Excel, vide.                                  */
/*------------------------------------------------------------------*/
If bOk Then
	If isRepExcel = "" Then 			
		stMessage.sCode = "COMD029"
		bOk = False
	End If
End If

/*------------------------------------------------------------------*/
/* Chemin Excel introuvable.                                        */
/*------------------------------------------------------------------*/
If bOk Then

//Migration PB8-WYNIWYG-03/2006 CP	
//	If Not FileExists ( isRepExcel ) Then 			
	If Not f_FileExists ( isRepExcel ) Then 			
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
		stMessage.sCode = "COMD030"
		bOk = False
	End If
End If


If Not bOk Then F_Message ( stMessage )

Return bOk
end function

public subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Objet 			: w_trt_int_fic_article
//* Evenement 		: wf_PositionnerObjets
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

dw_1.x	= 837
dw_1.y	= 691
dw_1.width	= 1957
dw_1.height	= 197

cb_Lancer.x	= 750
cb_Lancer.y	= 1003
cb_Lancer.width	= 2131
cb_Lancer.height	= 169

// [SUISSE].LOT3
st_avertissement_monnaie.x = dw_1.x
st_avertissement_monnaie.y = dw_1.y/2 - st_avertissement_monnaie.height/2


end subroutine

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Trt_Stat1::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild dwChild
Long lRow
//u_DeclarationFuncky uoDeclarationFuncky //[I037] Migration FUNCKy

This.Title = "Statistiques sur les Stocks/Articles"

wf_PositionnerObjets ()

dw_1.GetChild ( "ID_FOUR", dwChild )
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ( "-FR" )
lRow = dwChild.InsertRow ( 1 )
dwchild.SetItem ( lRow , "ID_CODE", "*" )
dwchild.SetItem ( lRow , "LIB_CODE", "Tous les fournisseurs" )

dw_Stat.SetTransObject ( SQLCA )

/*----------------------------------------------------------------------------*/
/* Armement du nom du rep win                                                 */
/*----------------------------------------------------------------------------*/
//uoDeclarationFuncky	= Create u_DeclarationFuncky
//isRepWin	= uoDeclarationFuncky.Uf_WinDir () 
//Destroy uoDeclarationFuncky

/*----------------------------------------------------------------------------*/
/* Armement du nom du Rep Excel en local.													*/
/*----------------------------------------------------------------------------*/
//isRepExcel = ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_EXCEL", "" )
isRepExcel=F_GetExcelPath() //[PI037]

end event

on show;call w_8_accueil::show;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Trt_Stat1::Show
//* Evenement 		: Show
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

dw_1.Reset ()
dw_1.InsertRow ( 0 )
dw_1.SelectRow ( 0, FALSE )
end on

on w_sp_trt_stat2.create
int iCurrent
call super::create
this.cb_lancer=create cb_lancer
this.dw_stat=create dw_stat
this.st_avertissement_monnaie=create st_avertissement_monnaie
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_lancer
this.Control[iCurrent+2]=this.dw_stat
this.Control[iCurrent+3]=this.st_avertissement_monnaie
end on

on w_sp_trt_stat2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_lancer)
destroy(this.dw_stat)
destroy(this.st_avertissement_monnaie)
end on

type cb_debug from w_8_accueil`cb_debug within w_sp_trt_stat2
end type

type pb_retour from w_8_accueil`pb_retour within w_sp_trt_stat2
integer width = 242
integer height = 144
integer taborder = 50
end type

type pb_interro from w_8_accueil`pb_interro within w_sp_trt_stat2
boolean visible = false
integer x = 3401
integer y = 32
integer taborder = 70
boolean enabled = false
end type

type pb_creer from w_8_accueil`pb_creer within w_sp_trt_stat2
boolean visible = false
integer x = 3159
integer y = 32
integer taborder = 60
boolean enabled = false
end type

type dw_1 from w_8_accueil`dw_1 within w_sp_trt_stat2
boolean visible = true
integer x = 101
integer y = 248
integer width = 416
integer height = 328
string dataobject = "d_choix_stat2"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Trt_Stat1::dw_1
//* Evenement 		: itemerror
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*		FPI	26/07/2016	[SAISIE_FOUR_MANU] Saisie manuelle du fournisseur		  
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//SetActioncode (1)

// [SAISIE_FOUR_MANU]
if Upper(dwo.Name) = "ID_FOUR" Then
	stMessage.berreurg=TRUE
	stMessage.Icon=Information!
	stMessage.scode="GENE004"
	stMessage.sVar[1]="Ce code fournisseur"
	stMessage.sTitre="Extraction des stock/articles - Saisie du fournisseur"
	
	f_message(stMessage)
	
End if

Return 1
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event dw_1::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: w_sp_trt_stat2::dw_1
//* Evenement 		: itemchanged
//* Auteur			: FPI
//* Date				: 26/07/2016
//* Libellé			: [SAISIE_FOUR_MANU] Saisie manuelle du fournisseur		  
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------
Long lRow
DataWindowChild ldwc

// [SAISIE_FOUR_MANU]
This.getChild("ID_FOUR",ldwc)

lRow =ldwc.Find ( "ID_CODE = '" +  This.GetText ()  + "'", 1, ldwc.RowCount () )
If lRow <= 0 Then
	return  1
End if
// :[SAISIE_FOUR_MANU]
end event

type pb_tri from w_8_accueil`pb_tri within w_sp_trt_stat2
boolean visible = false
integer x = 3643
integer y = 32
integer taborder = 80
boolean enabled = false
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_sp_trt_stat2
integer x = 3886
integer y = 32
end type

type cb_lancer from commandbutton within w_sp_trt_stat2
integer x = 585
integer y = 248
integer width = 411
integer height = 344
integer taborder = 40
boolean bringtotop = true
integer textsize = -16
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Extraire les données"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Trt_Stat1::cb_Lancer
//* Evenement 		: cb_Lancer
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//  #1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//	#2		FPI	23/07/2024	[MIG_PB2022] Sauvegarde Excel! remplacée par Excel8!
//*-----------------------------------------------------------------

Long	lTotRow

This.Enabled = False
SetPointer ( HourGlass! )

If wf_ControlerSaisie () Then

	lTotRow = dw_Stat.Retrieve ( dw_1.GetItemString ( 1, "ID_FOUR" ) )

	If lTotRow > 0 Then
		//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
		dw_Stat.SaveAs ( stglb.sRepTempo + K_FICSTAT, Excel8!, TRUE ) // [MIG_PB2022]
		RUN ( isRepExcel + " " + stglb.sRepTempo + K_FICSTAT )

	Else

		stMessage.sTitre  	= "Extraction"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "COMD028"
		F_Message ( stMessage )

	End If

End If

This.Enabled = True
SetPointer ( Arrow! )
end event

type dw_stat from datawindow within w_sp_trt_stat2
boolean visible = false
integer x = 1088
integer y = 248
integer width = 411
integer height = 344
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_trt_stat2"
end type

type st_avertissement_monnaie from u_st_avertissement_monnaie within w_sp_trt_stat2
integer x = 457
integer y = 76
integer width = 1801
boolean bringtotop = true
string text = "Les montants du fichier Excel sont exprimés en"
end type

event constructor;//*-----------------------------------------------------------------
//*
//* Objet			: u_st_avertissement_monnaie
//* Evenement 		: constructor
//* Auteur			: 
//* Date				: 27/02/2008 14:43:58
//* Libellé			: 
//* Commentaires	: (OVERRIDE )
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

this.text += " " +stGlb.sMonnaieLitteralDesire+"s"
end event

