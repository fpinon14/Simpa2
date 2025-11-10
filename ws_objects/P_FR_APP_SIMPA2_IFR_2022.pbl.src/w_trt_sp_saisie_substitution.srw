$PBExportHeader$w_trt_sp_saisie_substitution.srw
$PBExportComments$[VDoc18645]
forward
global type w_trt_sp_saisie_substitution from w_8_accueil
end type
type pb_appliquer from picturebutton within w_trt_sp_saisie_substitution
end type
type st_temoin_sav from statictext within w_trt_sp_saisie_substitution
end type
type pb_extraire from picturebutton within w_trt_sp_saisie_substitution
end type
type p_xls from picture within w_trt_sp_saisie_substitution
end type
end forward

global type w_trt_sp_saisie_substitution from w_8_accueil
integer width = 4571
integer height = 1892
string title = "Paramétrage des substitutions"
event ue_supprimerdetail pbm_custom72
pb_appliquer pb_appliquer
st_temoin_sav st_temoin_sav
pb_extraire pb_extraire
p_xls p_xls
end type
global w_trt_sp_saisie_substitution w_trt_sp_saisie_substitution

forward prototypes
public function integer wf_valider ()
public function integer wf_controler ()
public subroutine wf_set_maj_par ()
end prototypes

event ue_supprimerdetail;//*-----------------------------------------------------------------
//*
//* Fonction		: w_trt_sp_saisie_substitution::ue_supprimerdetail
//* Auteur			: F. Pinon
//* Date				: 08/10/2015 11:25:19
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: value unsignedlong wparam	 */
/* 	value long lparam	 */
//*
//* Retourne		: long	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
If dw_1.getselectedrow( 0) > 0 Then
	dw_1.deleteRow(dw_1.getselectedrow( 0))
	st_temoin_sav.visible=TRUE
End if
end event

public function integer wf_valider ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_trt_sp_saisie_substitution::wf_valider
//* Auteur			: F. Pinon
//* Date				: 08/10/2015 16:22:25
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Long lRet

lRet=wf_controler()

if lRet <=0 Then return -1

wf_set_maj_par( )

lRet=dw_1.Update()

if lRet <=0 Then
	F_Commit ( SQLCA, False )
Else
	F_Commit ( SQLCA, True )
	st_temoin_sav.Visible=FALSE
	dw_1.Retrieve()
End if

Return lRet
end function

public function integer wf_controler ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_trt_sp_saisie_substitution::wf_controler
//* Auteur			: F. Pinon
//* Date				: 08/10/2015 16:13:07
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Long lRow, lCol, lRow2
String sCols[]={"ID_PROD","CPT_SUBS","MARQ_APP_ORIG","MODL_APP_ORIG","MARQ_APP_SUBS","MODL_APP_SUBS"}
String sErrCol[]={"- le produit","- l'ordre","- la marque d'origine","- le modèle d'origine","- la marque de substitution","- le modèle de substitution"}
String sVal, sMsg
String sValeurs[]

If dw_1.accepttext( ) <=0 Then return -1

sMsg=""
stMessage.bErreurG	= FALSE

For lRow =1 to dw_1.RowCount()

	// Zones obligatoires
	For lCol=1 to UpperBound(sCols)

		if lCol < 3 Then
			if isNull(dw_1.GetItemNumber(lRow, sCols[lCol])) Then
				sMsg += sErrCol[lCol] + "~r~n"
				stMessage.sCode	= "GENE001"
				stMessage.bErreurG	= TRUE
			Else 
				sValeurs[lCol] = String(dw_1.GetItemNumber(lRow, sCols[lCol]))
			End if
		Else
			sVal=dw_1.GetItemString(lRow, sCols[lCol])
		
			sValeurs[lCol]=sVal
			
			If isnull(sVal) or Len(Trim(sVal)) = 0 Then
				sMsg += sErrCol[lCol] + "~r~n"
				stMessage.sCode	= "GENE001"
				stMessage.bErreurG	= TRUE
			End if
		End if
	Next
	
	// Marq & modl origine = marq & modl susbs
	if sMsg="" Then
		if sValeurs[3]= sValeurs[5] And sValeurs[4]=sValeurs[6] Then
			stMessage.sCode	= "IFR0106"
			sMsg="X"
		End if
	End if
	
	// Doublon ordre/produit/marq_orig/modl_orig
	if sMsg="" Then
		lRow2=dw_1.Find("ID_PROD=" + sValeurs[1] + " AND CPT_SUBS=" + sValeurs[2] + &
			" AND MARQ_APP_ORIG='" +  sValeurs[3] + "' AND MODL_APP_ORIG='" +  sValeurs[4] + "'", &
			1, dw_1.RowCount( ))
		if lRow > lRow2 Then
			stMessage.sCode	= "IFR0107"
			sMsg="X"
		End if
	End if

	// Doublon produit/marq_orig/modl_orig/marq_subs/modl_subs
	if sMsg="" Then
		lRow2=dw_1.Find("ID_PROD=" + sValeurs[1] + &
			" AND MARQ_APP_ORIG='" +  sValeurs[3] + "' AND MODL_APP_ORIG='" +  sValeurs[4] + "'" + &
			" AND MARQ_APP_SUBS='" +  sValeurs[5] + "' AND MODL_APP_SUBS='" +  sValeurs[6] + "'", &
			1, dw_1.RowCount( ))
		if lRow > lRow2 Then
			stMessage.sCode	= "IFR0108"
			sMsg="X"
		End if
	End if

	// Message d'erreur
	if sMsg <> "" Then
		stMessage.sTitre		= "Paramétrage des substitutions - SIMPA2"
		stMessage.Icon			= Information!
		stMessage.sVar[1] = sMsg
		
		f_message(stMessage)
		
		dw_1.selectrow( 0, False)
		dw_1.selectrow( lRow, True)
		dw_1.scrollToRow(lRow)
		Return -1
	End if
Next

Return 1
end function

public subroutine wf_set_maj_par ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_trt_sp_saisie_substitution::wf_set_maj_par
//* Auteur			: F. Pinon
//* Date				: 08/10/2015 16:33:02
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
Long lRow

For lRow=1 to dw_1.RowCount( )
	If dw_1.getItemStatus( lRow, 0, Primary!) <> NotModified! Then
		dw_1.SetItem(lRow, "MAJ_PAR",stglb.scodoper)
	End if
Next




end subroutine

on w_trt_sp_saisie_substitution.create
int iCurrent
call super::create
this.pb_appliquer=create pb_appliquer
this.st_temoin_sav=create st_temoin_sav
this.pb_extraire=create pb_extraire
this.p_xls=create p_xls
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_appliquer
this.Control[iCurrent+2]=this.st_temoin_sav
this.Control[iCurrent+3]=this.pb_extraire
this.Control[iCurrent+4]=this.p_xls
end on

on w_trt_sp_saisie_substitution.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_appliquer)
destroy(this.st_temoin_sav)
destroy(this.pb_extraire)
destroy(this.p_xls)
end on

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			: w_trt_sp_saisie_substitution
//* Evenement 		: ue_initialiser
//* Auteur			: F. Pinon
//* Date				: 08/10/2015 10:36:19
//* Libellé			: 
//* Commentaires	: 
//*				  
//* Arguments		: value unsignedlong wparam	 */
/* 	value long lparam	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
DatawindowChild dwChild

dw_1.SetTransObject( SQLCA)

dw_1.getchild( "MARQ_APP_ORIG",dwChild)
dwChild.SetTransObject( SQLCA)
dwChild.retrieve( "MARQUE")

dw_1.getchild( "MODL_APP_ORIG",dwChild)
dwChild.SetTransObject( SQLCA)
dwChild.retrieve( "MODELE")

dw_1.getchild( "MARQ_APP_SUBS",dwChild)
dwChild.SetTransObject( SQLCA)
dwChild.retrieve( "MARQUE")

dw_1.getchild( "MODL_APP_SUBS",dwChild)
dwChild.SetTransObject( SQLCA)
dwChild.retrieve( "MODELE")

dw_1.retrieve( )

dw_1.SetSort("MARQ_APP_ORIG, MODL_APP_ORIG, cpt_subs")
dw_1.Sort()

if dw_1.RowCount() > 0 Then dw_1.Event rowfocuschanged(1)

end event

event ue_creer;call super::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet			: w_trt_sp_saisie_substitution
//* Evenement 		: ue_creer
//* Auteur			: F. Pinon
//* Date				: 08/10/2015 11:26:30
//* Libellé			: 
//* Commentaires	: 
//*				  
//* Arguments		: value unsignedlong wparam	 */
/* 	value long lparam	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Long lRow

//lRow=dw_1.InsertRow(0)
lRow=dw_1.InsertRow(dw_1.getRow() + 1)
dw_1.Scrolltorow( lRow)
dw_1.setColumn( 1)
dw_1.SetFocus( )
end event

event show;call super::show;gwmdi.Width+=930
end event

event hide;call super::hide;gwmdi.Width -= 930
end event

type cb_debug from w_8_accueil`cb_debug within w_trt_sp_saisie_substitution
end type

type pb_retour from w_8_accueil`pb_retour within w_trt_sp_saisie_substitution
integer width = 242
integer height = 144
end type

type pb_interro from w_8_accueil`pb_interro within w_trt_sp_saisie_substitution
boolean visible = false
integer width = 242
integer height = 144
end type

type pb_creer from w_8_accueil`pb_creer within w_trt_sp_saisie_substitution
integer width = 242
integer height = 144
string text = "&Valider"
boolean originalsize = false
string picturename = "k:\pb4obj\bmp\8_valid.bmp"
end type

event pb_creer::clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_trt_sp_saisie_substitution
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 08/10/2015 16:04:41
//* Libellé			: 
//* Commentaires	: 
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

Int iRet

iRet = wf_Valider ()

If iRet > 0 Then
	Parent.TriggerEvent ( "ue_retour" )
End If
end event

type dw_1 from w_8_accueil`dw_1 within w_trt_sp_saisie_substitution
boolean visible = true
integer x = 18
integer y = 192
integer width = 4407
integer height = 1476
string dataobject = "d_trt_substitution"
boolean ibselectionactive = true
end type

event dw_1::clicked;call super::clicked;//*-----------------------------------------------------------------
//*
//* Evènement		: w_trt_sp_saisie_substitution::clicked
//* Auteur			: F. Pinon
//* Date				: 08/10/2015 10:52:21
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: value unsignedlong flags	 */
/* 	value integer xpos	 */
/* 	value integer ypos	 */
//*
//* Retourne		: long	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 		FPI	14/09/2017 	On enleve le tri
//*-----------------------------------------------------------------

String ls_old_sort, ls_column
Char lc_sort

If isNull(dwo) then Return

This.SelectRow(0, false)
This.SelectRow(row, true)
This.ScrollToRow (row)


/* Check whether the user clicks on the column header */
/*IF Right(dwo.Name,2) = '_t' THEN    
	ls_column = LEFT(dwo.Name, LEN(String(dwo.Name)) - 2)   
	ls_old_sort = This.Describe("Datawindow.Table.sort")    
	
	IF ls_column = LEFT(ls_old_sort, LEN(ls_old_sort) - 2) THEN        
		lc_sort = RIGHT(ls_old_sort, 1)        
		IF lc_sort = 'A' THEN            
			lc_sort = 'D'       
		ELSE             
			lc_sort = 'A'        
		END IF        
		dw_1.SetSort(ls_column+" "+lc_sort)    
	ELSE       
		dw_1.SetSort(ls_column+" A")   
	END IF   
	dw_1.Sort()
END IF*/
end event

event dw_1::ue_modifiermenu;call super::ue_modifiermenu;
//*-----------------------------------------------------------------
//*
//* Objet			: w_trt_sp_saisie_substitution
//* Evenement 		: ue_modifiermenu
//* Auteur			: F. Pinon
//* Date				: 08/10/2015 11:55:03
//* Libellé			: 
//* Commentaires	: 
//*				  
//* Arguments		: value unsignedlong wparam	 */
/* 	value long lparam	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

If This.getselectedrow( 0 ) > 0 Then
	uf_mnu_changertext( 1, "&Ajouter")
	uf_mnu_autoriseritem( 3 )
	uf_mnu_cacheritem( 4 )
	uf_mnu_cacheritem( 2 )
	uf_mnu_cacheritem( 5 )
End if
end event

event dw_1::itemchanged;call super::itemchanged;
//*-----------------------------------------------------------------
//*
//* Objet			: w_trt_sp_saisie_substitution
//* Evenement 		: itemchanged
//* Auteur			: F. Pinon
//* Date				: 08/10/2015 12:00:40
//* Libellé			: 
//* Commentaires	: 
//*				  
//* Arguments		: value long row	 */
/* 	value dwobject dwo	 */
/* 	value string data	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

DataWindowChild dwChild
Long lRow
Integer iAction
String sNull
String sZoneModele

SetNull(sNull)
iAction=0

If isNull(dwo) Then return 0

Choose Case Upper(dwo.Name)
	Case "MARQ_APP_ORIG", "MARQ_APP_SUBS"

		sZoneModele = "MODL" + Right(dwo.Name,9) 
		
		if isnull(data) or data="" Then
			This.SetItem(row,sZoneModele, sNull)
		Else
			This.GetChild(dwo.Name,dwChild)
		
			lRow=dwChild.Find("MARQUE='" + data + "'", 1, dwChild.Rowcount( ))
	
			if lRow <=0 Then
				iAction = 1
			Else
				This.SetItem(row,sZoneModele, sNull)
				This.GetChild(sZoneModele,dwChild)
			
				dwChild.SetFilter("MARQUE='" + data + "'")
				dwChild.filter( )
			End if
		End if	
	Case "MODL_APP_ORIG", "MODL_APP_SUBS"
		This.GetChild(dwo.Name, dwChild)
		
		lRow=dwChild.Find("reference='" + data + "'", 1, dwChild.Rowcount( ))

		if lRow <=0 Then
			iAction = 1
		End if
End Choose


st_temoin_sav.Visible=TRUE

Return iAction
end event

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet			: w_trt_sp_saisie_substitution
//* Evenement 		: itemerror
//* Auteur			: F. Pinon
//* Date				: 08/10/2015 14:48:55
//* Libellé			: 
//* Commentaires	: 
//*				  
//* Arguments		: value long row	 */
/* 	value dwobject dwo	 */
/* 	value string data	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Long ll_return

Call super::itemerror

stMessage.sTitre		= "Paramétrage des substitutions - SIMPA2"
stMessage.Icon			= Information!

stMessage.bErreurG	= TRUE

Choose Case isErrCol
	Case "MODL_APP_ORIG"
			stMessage.sVar[1] = "modèle de l'appareil d'origine"
			stMessage.sCode	= "GENE003"
	Case "MARQ_APP_ORIG"
			stMessage.sVar[1] = "marque de l'appareil d'origine"
			stMessage.sCode	= "GENE002"
	Case "MODL_APP_SUBS"
			stMessage.sVar[1] = "modèle de l'appareil de substitution"
			stMessage.sCode	= "GENE003"
	Case "MARQ_APP_SUBS"
			stMessage.sVar[1] = "marque de l'appareil de substitution"
			stMessage.sCode	= "GENE002"
End Choose

F_Message ( stMessage )

ll_return = This.Uf_Reinitialiser ()
Return ( ll_return )

end event

event dw_1::dberror;
//*-----------------------------------------------------------------
//*
//* Objet			: w_trt_sp_saisie_substitution
//* Evenement 		: dberror
//* Auteur			: F. Pinon
//* Date				: 08/10/2015 16:52:21
//* Libellé			: 
//* Commentaires	: 
//*				  
//* Arguments		: value long sqldbcode	 */
/* 	value string sqlerrtext	 */
/* 	value string sqlsyntax	 */
/* 	value dwbuffer buffer	 */
/* 	value long row	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

If sqldbcode =2627 Then // Violation contrainte PK
	stMessage.berreurg=FALSE
	stMessage.scode="GENE005"
	stMessage.sTitre="Paramétrage des substitutions - SIMPA2"
	stMessage.sVar[1] = "Une des substitutions"
	f_message(stMessage)
End if

Return 1
end event

event dw_1::constructor;call super::constructor;ilMaxLig=0 // [FPI.20130128]
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;String sMarque
DatawindowChild dwChild

If row <=0 Then return

if Left(upper(dwo.Name),8) = "MODL_APP" Then
	sMarque=this.GetItemString(row,"MARQ_APP" + Right(dwo.Name,5))
	If isNull(sMarque) Then sMarque=""
	
	This.GetChild(dwo.Name, dwChild)
	dwChild.SetFilter("MARQUE='" + sMarque + "'")
	dwChild.filter( )
End if

end event

type pb_tri from w_8_accueil`pb_tri within w_trt_sp_saisie_substitution
boolean visible = false
integer width = 242
integer height = 144
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_trt_sp_saisie_substitution
end type

type pb_appliquer from picturebutton within w_trt_sp_saisie_substitution
integer x = 503
integer y = 20
integer width = 233
integer height = 136
integer taborder = 80
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Appliquer"
string picturename = "k:\pb4obj\bmp\8_savfil.bmp"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_trt_sp_saisie_substitution
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 08/10/2015 16:05:29
//* Libellé			: 
//* Commentaires	: 
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

wf_valider()
end event

type st_temoin_sav from statictext within w_trt_sp_saisie_substitution
boolean visible = false
integer x = 741
integer y = 24
integer width = 69
integer height = 56
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "*"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_extraire from picturebutton within w_trt_sp_saisie_substitution
integer x = 1070
integer y = 16
integer width = 233
integer height = 136
integer taborder = 20
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Extraire"
boolean originalsize = true
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_trt_sp_saisie_substitution::pb_extraire
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 09/12/2014
//* Libellé			: [VDOC16211]
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//			FPI	23/07/2024	[MIG_PB2022] Sauvegarde Excel! remplacée par Excel8!
//*-----------------------------------------------------------------

Integer iRet

iRet = dw_1.Saveas(stglb.sreptempo + "SUBSTITUTION.XLS", Excel8!,TRUE) // [MIG_PB2022]

stMessage.sTitre  	= "Extraction des substitutions"
stMessage.Icon			= Information!
stMessage.Bouton		= Ok!
stMessage.sVar[1] = stglb.sreptempo + "SUBSTITUTION.XLS"

If iRet = 1 Then
	stMessage.bErreurG	= FALSE
	stMessage.sCode	= "GENE013"
	stMessage.sVar[1] = "Le fichier " + stMessage.sVar[1] + " a été généré."
Else
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "ANCE008"
End if

f_message(stMessage)

end event

type p_xls from picture within w_trt_sp_saisie_substitution
integer x = 1147
integer y = 24
integer width = 82
integer height = 68
boolean bringtotop = true
string picturename = "K:\PB4OBJ\BMP\excel.bmp"
boolean focusrectangle = false
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_param_frais
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 05/11/2009 12:03:39
//* Libellé			: 
//* Commentaires	: 
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

pb_extraire.Event clicked()
end event

