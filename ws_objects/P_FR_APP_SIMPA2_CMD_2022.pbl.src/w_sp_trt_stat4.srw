HA$PBExportHeader$w_sp_trt_stat4.srw
$PBExportComments$Extraction sur les Controles IMEIs
forward
global type w_sp_trt_stat4 from w_8_accueil
end type
type cb_lancer from commandbutton within w_sp_trt_stat4
end type
type dw_stat from datawindow within w_sp_trt_stat4
end type
end forward

global type w_sp_trt_stat4 from w_8_accueil
integer width = 2139
integer height = 1576
cb_lancer cb_lancer
dw_stat dw_stat
end type
global w_sp_trt_stat4 w_sp_trt_stat4

type variables
Private :

String	isRepWin, isRepExcel

String	K_TEMP = "\TEMP\"
String	K_FICSTAT = "_ENCIMEI.XLS"

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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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
Long			lIdSinDeb, lIdSinFin
DateTime		dteValMin, dteValMax

bOk = TRUE
dw_1.AcceptText ()

/*------------------------------------------------------------------*/
/* Controle de saisie de la partie Client.                          */
/*------------------------------------------------------------------*/
sCol[ 1 ] = "CTIMEI"
sCol[ 2 ] = "CRA_SUIVI_IMEI"
sCol[ 3 ] = "ID_PROD"
sCol[ 4 ] = "ID_SIN_DEB"
sCol[ 5 ] = "ID_SIN_FIN"
sCol[ 6 ] = "DTE_VALMIN"
sCol[ 7 ] = "DTE_VALMAX"

lNbrCol	 = UpperBound ( sCol )

stMessage.sTitre  	= "Controle de saisie"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= Ok!
stMessage.sCode		= "COMD025"

/*------------------------------------------------------------------*/
/* Centre Technique est Obligatoire                                 */
/*------------------------------------------------------------------*/

For lCpt = 1 To lNbrCol
	CHOOSE CASE lCpt
		CASE 1
			sVal = dw_1.GetItemString ( 1, sCol [ lCpt ] )
		CASE 2, 3
			sVal = String ( dw_1.GetItemNumber ( 1, sCol [ lCpt ] ) )
	END CHOOSE

	If IsNull ( sVal ) or sVal = ""	Then
		bOk = False
	End If
Next

/*------------------------------------------------------------------*/
/* Coh$$HEX1$$e900$$ENDHEX$$rence des deux dates.                                        */
/*------------------------------------------------------------------*/
dteValMin = datetime(dw_1.object.dte_valmin[1])
dteValMax = datetime(dw_1.object.dte_valmax[1])

If bOk And ( ( Not Isnull(dteValMin) ) Or ( Not Isnull(dteValMax) ) ) Then
	if IsNull(dteValMin) or IsNull(dteValMax)  then
		bOk = False
		stMessage.sCode = "COMD026" // Saisir un dteValMin & dteValMax
	End If
	if bOk And dteValMin > dteValMax Then
		bOk = False
		stMessage.sCode = "COMD026" // dteValMin > dteValMax
	End If
End If

/*------------------------------------------------------------------*/
/* Coh$$HEX1$$e900$$ENDHEX$$rence des id_sin.                                            */
/*------------------------------------------------------------------*/
lIdSinDeb = dw_1.object.id_sin_deb[1]
lIdSinFin = dw_1.object.id_sin_fin[1]

If bOk And ( ( Not Isnull(lIdSinDeb) ) Or ( Not Isnull(lIdSinFin) ) ) Then
	if IsNull(lIdSinDeb) or IsNull(lIdSinFin)  then
			bOk = False
			stMessage.sCode = "COMD439" // Saisir un Id sin de Debut et de Fin
	End If
	if bOk and lIdSinFin < lIdSinDeb then
			bOk = False
			stMessage.sCode = "COMD439" // IdSin Deb > IdSin Fin
	End If
End If

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
//* Objet 			: w_trt_stat4
//* Evenement 		: wf_PositionnerObjets
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1	FPI	27/01/2009 [DCMP080728] Agrandissement du libell$$HEX2$$e9002000$$ENDHEX$$long de produit
//*-----------------------------------------------------------------

dw_1.x	= 453 // #1 - 709
dw_1.y	= 441
dw_1.width	=  2700 // #1 - 2222
dw_1.height	= 793

cb_Lancer.x	= 750
cb_Lancer.y	= 1253
cb_Lancer.width	= 2131
cb_Lancer.height	= 169
end subroutine

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Trt_Stat1::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild dwChild
Long lRow
integer iNull
//u_DeclarationFuncky uoDeclarationFuncky //[I037] Migration FUNCKy

This.Title = "Extraction En-Cours Controle IMEI"

wf_PositionnerObjets ()

dw_1.GetChild ( "CTIMEI", dwChild )
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ( "-FC" )
lrow = dwChild.find("TRIM(ID_CODE)='-1'", 1, dwChild.RowCount()+1 )
if lRow >0 then dwChild.RowsDiscard(lRow,LRow, Primary!)

dw_1.GetChild ( "CRA_SUIVI_IMEI", dwChild )
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ( "-CR" )
lRow = dwChild.InsertRow ( 1 )
dwchild.SetItem ( lRow , "ID_CODE", 0 )
dwchild.SetItem ( lRow , "LIB_CODE", "Tous Status" )


dw_1.GetChild ( "ID_PROD", dwChild )
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ( )
lRow = dwChild.InsertRow ( 1 )
dwchild.SetItem ( lRow , "ID_PROD", iNull )
dwchild.SetItem ( lRow , "LIB_LONG", "Tous les produits d$$HEX1$$e900$$ENDHEX$$pendant du centre technique" )

dw_Stat.SetTransObject ( SQLCA )

/*----------------------------------------------------------------------------*/
/* Armement du nom du rep win                                                 */
/*----------------------------------------------------------------------------*/
//uoDeclarationFuncky	= Create u_DeclarationFuncky
//isRepWin	= uoDeclarationFuncky.Uf_WinDir () 
//Migration PB8-WYNIWYG-03/2006 FM
//Destroy uoDeclarationFuncky
//If IsValid(uoDeclarationFuncky) Then Destroy uoDeclarationFuncky
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*----------------------------------------------------------------------------*/
/* Armement du nom du Rep Excel en local.													*/
/*----------------------------------------------------------------------------*/
//isRepExcel = ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_EXCEL", "" )
isRepExcel=F_GetExcelPath() //[PI037]

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on show;call w_8_accueil::show;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Trt_Stat1::Show
//* Evenement 		: Show
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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

on w_sp_trt_stat4.create
int iCurrent
call super::create
this.cb_lancer=create cb_lancer
this.dw_stat=create dw_stat
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_lancer
this.Control[iCurrent+2]=this.dw_stat
end on

on w_sp_trt_stat4.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_lancer)
destroy(this.dw_stat)
end on

type cb_debug from w_8_accueil`cb_debug within w_sp_trt_stat4
end type

type pb_retour from w_8_accueil`pb_retour within w_sp_trt_stat4
integer taborder = 50
end type

type pb_interro from w_8_accueil`pb_interro within w_sp_trt_stat4
boolean visible = false
integer x = 3401
integer y = 32
integer taborder = 70
boolean enabled = false
end type

type pb_creer from w_8_accueil`pb_creer within w_sp_trt_stat4
boolean visible = false
integer x = 3159
integer y = 32
integer taborder = 60
boolean enabled = false
end type

type dw_1 from w_8_accueil`dw_1 within w_sp_trt_stat4
boolean visible = true
integer x = 82
integer y = 248
integer width = 411
integer height = 344
string dataobject = "d_choix_stat4"
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//SetActioncode (1)
Return 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
end event

event dw_1::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Trt_Stat1::dw_1
//* Evenement 		: itemChanged
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

choose case dwo.name
	case 'dte_valmin'
		this.object.dte_ValMax[row] = date(data)
	case 'id_sin_deb'
		this.object.id_Sin_Fin[row] = long(data)
End Choose

end event

type pb_tri from w_8_accueil`pb_tri within w_sp_trt_stat4
boolean visible = false
integer x = 3643
integer y = 32
integer taborder = 80
boolean enabled = false
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_sp_trt_stat4
integer x = 3886
integer y = 32
end type

type cb_lancer from commandbutton within w_sp_trt_stat4
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
string text = "Extraire les donn$$HEX1$$e900$$ENDHEX$$es"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Trt_Stat1::cb_Lancer
//* Evenement 		: cb_Lancer
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//  #1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//*-----------------------------------------------------------------

DateTime dtMin, dtMax
Long	lTotRow
String sNomFic

This.Enabled = False
SetPointer ( HourGlass! )

If wf_ControlerSaisie () Then

	dtMin	= DateTime ( dw_1.GetItemDate ( 1, "DTE_VALMIN" ), 00:00:00 )
	dtMax	= DateTime ( dw_1.GetItemDate ( 1, "DTE_VALMAX" ), 23:59:00 )
	
	lTotRow = dw_Stat.Retrieve ( &
		dw_1.GetItemString ( 1, "CTIMEI" ), &
		dw_1.GetItemNumber ( 1, "CRA_SUIVI_IMEI" ), &
		dw_1.GetItemNumber ( 1, "ID_PROD" ), &
		dw_1.GetItemNumber ( 1, "ID_SIN_DEB" ), &
		dw_1.GetItemNumber ( 1, "ID_SIN_FIn" ), &
		dtMin,& 
		dtMax ) 

	If lTotRow > 0 Then
		sNomFic = stGlb.sRepTempo + dw_1.GetItemString ( 1, "CTIMEI" ) + K_FICSTAT
		dw_Stat.SaveAs ( sNomFic,Text!, TRUE )
		RUN ( isRepExcel + " " + sNomFic )
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

type dw_stat from datawindow within w_sp_trt_stat4
boolean visible = false
integer x = 1088
integer y = 248
integer width = 411
integer height = 344
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_trt_stat4"
end type

