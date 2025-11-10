$PBExportHeader$w_a_sp_trt_consult_w_queue.srw
$PBExportComments$--- }Consultation en ligne de w_queue
forward
global type w_a_sp_trt_consult_w_queue from w_8_accueil
end type
type cb_1 from commandbutton within w_a_sp_trt_consult_w_queue
end type
type dw_stat from datawindow within w_a_sp_trt_consult_w_queue
end type
end forward

global type w_a_sp_trt_consult_w_queue from w_8_accueil
integer width = 2999
integer height = 1820
string title = "Consultation en ligne de tous les travaux"
cb_1 cb_1
dw_stat dw_stat
end type
global w_a_sp_trt_consult_w_queue w_a_sp_trt_consult_w_queue

type variables
Private :

String	isRepExcel

String	K_TEMP = "\TEMP\"
String	K_FICSTAT = "TRAVAUX.XLS"
end variables

forward prototypes
private function boolean wf_controlersaisie ()
end prototypes

private function boolean wf_controlersaisie ();//*-----------------------------------------------------------------
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
dw_Stat.AcceptText ()


stMessage.sTitre  	= "Controle de saisie"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= Ok!
stMessage.sCode		= "COMD025"


/*------------------------------------------------------------------*/
/* Suppression du fichier destination existant.                     */
/*------------------------------------------------------------------*/
If bOk then
//Migration PB8-WYNIWYG-03/2006 FM
//	If FileExists ( isRepWin + K_TEMP + K_FICSTAT ) Then
	//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
	//If f_FileExists ( isRepWin + K_TEMP + K_FICSTAT ) Then
	If f_FileExists ( stGlb.sRepTempo + K_FICSTAT ) Then
//Fin Migration PB8-WYNIWYG-03/2006 FM
		//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
		//If Not FileDelete ( isRepWin + K_TEMP + K_FICSTAT ) Then
		If Not FileDelete ( stGlb.sRepTempo + K_FICSTAT ) Then
			stMessage.sCode		= "COMD027"
			//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
			//stMessage.sVar[1]		= Upper ( isRepWin + K_TEMP + K_FICSTAT )
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
//Migration PB8-WYNIWYG-03/2006 FM
//	If Not FileExists ( isRepExcel ) Then 			
	If Not f_FileExists ( isRepExcel ) Then 			
//Fin Migration PB8-WYNIWYG-03/2006 FM
		stMessage.sCode = "COMD030"
		bOk = False
	End If
End If

If Not bOk Then F_Message ( stMessage )

Return bOk
end function

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_a_sp_trt_consult_w_queue::Ue_Initialiser
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
//u_DeclarationFuncky uoDeclarationFuncky

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
isRepExcel = F_GetExcelPath() //[PI037]

end event

on w_a_sp_trt_consult_w_queue.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_stat=create dw_stat
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_stat
end on

on w_a_sp_trt_consult_w_queue.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.dw_stat)
end on

type cb_debug from w_8_accueil`cb_debug within w_a_sp_trt_consult_w_queue
end type

type pb_retour from w_8_accueil`pb_retour within w_a_sp_trt_consult_w_queue
integer width = 242
integer height = 144
integer taborder = 50
end type

type pb_interro from w_8_accueil`pb_interro within w_a_sp_trt_consult_w_queue
boolean visible = false
integer taborder = 70
boolean enabled = false
end type

type pb_creer from w_8_accueil`pb_creer within w_a_sp_trt_consult_w_queue
boolean visible = false
integer taborder = 60
boolean enabled = false
end type

type dw_1 from w_8_accueil`dw_1 within w_a_sp_trt_consult_w_queue
integer x = 73
integer y = 260
integer width = 251
integer height = 188
boolean enabled = false
end type

type pb_tri from w_8_accueil`pb_tri within w_a_sp_trt_consult_w_queue
boolean visible = false
integer taborder = 80
boolean enabled = false
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_sp_trt_consult_w_queue
end type

type cb_1 from commandbutton within w_a_sp_trt_consult_w_queue
integer x = 1015
integer y = 720
integer width = 1705
integer height = 320
integer taborder = 40
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Lancer l~'extraction des travaux sous Excel"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: cb_Lancer
//* Evenement 		: Click
//* Auteur			: Fabry JF
//* Date				: 20/09/2002 17:59:48
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

	lTotRow = dw_Stat.Retrieve () 

	If lTotRow > 0 Then
		//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
		//dw_Stat.SaveAs ( isRepWin + K_TEMP + K_FICSTAT,Excel!, TRUE )
		//RUN ( isRepExcel + " " + isRepWin + K_TEMP + K_FICSTAT )
		dw_Stat.SaveAs ( stGlb.sRepTempo + K_FICSTAT,Excel8!, TRUE ) //[MIG_PB2022]
		RUN ( isRepExcel + " " + stGlb.sRepTempo + K_FICSTAT )
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

type dw_stat from datawindow within w_a_sp_trt_consult_w_queue
boolean visible = false
integer x = 361
integer y = 256
integer width = 251
integer height = 184
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_w_queue_stat"
end type

