HA$PBExportHeader$w_trt_sp_param_pxpubmarch.srw
$PBExportComments$[VDoc8841]
forward
global type w_trt_sp_param_pxpubmarch from w_8_accueil
end type
type pb_appliquer from picturebutton within w_trt_sp_param_pxpubmarch
end type
type st_temoin_sav from statictext within w_trt_sp_param_pxpubmarch
end type
end forward

global type w_trt_sp_param_pxpubmarch from w_8_accueil
integer width = 5042
integer height = 1892
string title = "Param$$HEX1$$e900$$ENDHEX$$trage des alertes prix public/prix march$$HEX1$$e900$$ENDHEX$$"
event ue_supprimerdetail pbm_custom72
pb_appliquer pb_appliquer
st_temoin_sav st_temoin_sav
end type
global w_trt_sp_param_pxpubmarch w_trt_sp_param_pxpubmarch

forward prototypes
public function integer wf_valider ()
public function integer wf_controler ()
public subroutine wf_set_maj_par ()
public subroutine wf_raz_columns (long alrow, string ascols[])
end prototypes

event ue_supprimerdetail;//*-----------------------------------------------------------------
//*
//* Fonction		: w_trt_sp_param_pxpubmarch::ue_supprimerdetail
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 11:25:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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
//* Fonction		: w_trt_sp_param_pxpubmarch::wf_valider
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 16:22:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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
//* Fonction		: w_trt_sp_param_pxpubmarch::wf_controler
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 16:13:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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

Long lRow, lCol
String sCols[]={"ID_FOUR","ID_REF_FOUR","ID_MARQ_FOURN","ID_MODL_FOURN"}
String sErrCol[]={"- le code fournisseur","- la r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur","- la marque fournisseur","- le mod$$HEX1$$e800$$ENDHEX$$le fournisseur"}
String sVal, sMsg

If dw_1.accepttext( ) <=0 Then return -1

sMsg=""

For lRow =1 to dw_1.RowCount()
	For lCol=1 to UpperBound(sCols)

		sVal=dw_1.GetItemString(lRow, sCols[lCol])
		
		If isnull(sVal) or Len(Trim(sVal)) = 0 Then
			sMsg += sErrCol[lCol] + "~r~n"
		End if
	Next
	
	if sMsg <> "" Then
		stMessage.sTitre		= "Param$$HEX1$$e900$$ENDHEX$$trage des alertes prix public/prix march$$HEX2$$e9002000$$ENDHEX$$- SIMPA2"
		stMessage.Icon			= Information!
		stMessage.sVar[1] = sMsg
		stMessage.sCode	= "GENE001"
			
		stMessage.bErreurG	= TRUE
		
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
//* Fonction		: w_trt_sp_param_pxpubmarch::wf_set_maj_par
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 16:33:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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

public subroutine wf_raz_columns (long alrow, string ascols[]);Long lCol
String sNull

SetNull(sNull)

For lCol=1 to UpperBound(asCols)
	dw_1.Setitem(alRow, asCols[lCol], sNull)
Next
end subroutine

on w_trt_sp_param_pxpubmarch.create
int iCurrent
call super::create
this.pb_appliquer=create pb_appliquer
this.st_temoin_sav=create st_temoin_sav
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_appliquer
this.Control[iCurrent+2]=this.st_temoin_sav
end on

on w_trt_sp_param_pxpubmarch.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_appliquer)
destroy(this.st_temoin_sav)
end on

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			: w_trt_sp_param_pxpubmarch
//* Evenement 		: ue_initialiser
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 10:36:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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

dw_1.getchild( "ID_REF_FOUR",dwChild)
dwChild.SetTransObject( SQLCA)

dw_1.getchild( "ID_FOUR",dwChild)
dwChild.SetTransObject( SQLCA)
dwChild.retrieve( )

dw_1.getchild( "ID_MARQ_FOURN",dwChild)
dwChild.SetTransObject( SQLCA)

dw_1.getchild( "ID_MODL_FOURN",dwChild)
dwChild.SetTransObject( SQLCA)


dw_1.retrieve( )

if dw_1.RowCount() > 0 Then dw_1.Event rowfocuschanged(1)

end event

event ue_creer;call super::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet			: w_trt_sp_param_pxpubmarch
//* Evenement 		: ue_creer
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 11:26:30
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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

lRow=dw_1.InsertRow(0)
dw_1.Scrolltorow( lRow)
dw_1.setColumn( 1)
dw_1.SetFocus( )
dw_1.Modify( "id_ref_four.protect='0'")
end event

event show;call super::show;gwmdi.Width+=1464
end event

event hide;call super::hide;gwmdi.Width -= 1464
end event

type cb_debug from w_8_accueil`cb_debug within w_trt_sp_param_pxpubmarch
end type

type pb_retour from w_8_accueil`pb_retour within w_trt_sp_param_pxpubmarch
integer width = 242
integer height = 144
end type

type pb_interro from w_8_accueil`pb_interro within w_trt_sp_param_pxpubmarch
boolean visible = false
integer width = 242
integer height = 144
end type

type pb_creer from w_8_accueil`pb_creer within w_trt_sp_param_pxpubmarch
integer width = 242
integer height = 144
string text = "&Valider"
string picturename = "k:\pb4obj\bmp\8_valid.bmp"
end type

event pb_creer::clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_trt_sp_param_pxpubmarch
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 16:04:41
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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

type dw_1 from w_8_accueil`dw_1 within w_trt_sp_param_pxpubmarch
boolean visible = true
integer x = 18
integer y = 192
integer width = 4923
integer height = 1476
string dataobject = "d_trt_param_pxpubmarch"
boolean ibselectionactive = true
end type

event dw_1::clicked;call super::clicked;//*-----------------------------------------------------------------
//*
//* Ev$$HEX1$$e800$$ENDHEX$$nement		: w_trt_sp_param_pxpubmarch::clicked
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 10:52:21
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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
//* 
//*-----------------------------------------------------------------

String ls_old_sort, ls_column
Char lc_sort

If isNull(dwo) then Return

if row > 0 Then
	This.SelectRow(0, false)
	This.SelectRow(row, true)
	This.ScrollToRow (row)
End if

/* Check whether the user clicks on the column header */
IF Right(dwo.Name,2) = '_t' THEN    
	ls_column = LEFT(dwo.Name, LEN(String(dwo.Name)) - 2)   
	/* Get old sort, if any. */   
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
END IF
end event

event dw_1::ue_modifiermenu;call super::ue_modifiermenu;
//*-----------------------------------------------------------------
//*
//* Objet			: w_trt_sp_param_pxpubmarch
//* Evenement 		: ue_modifiermenu
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 11:55:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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
//* Objet			: w_trt_sp_param_pxpubmarch
//* Evenement 		: itemchanged
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 12:00:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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

SetNull(sNull)
iAction=0

If isNull(dwo) Then return 0

Choose Case Upper(dwo.Name)
	Case "ID_FOUR" 
		
		If data=this.GetItemString(row,"ID_FOUR") Then return 0
		
		This.GetChild("ID_FOUR",dwChild)
		
		lRow=dwChild.Find("ID_FOUR='" + data + "'", 1, dwChild.Rowcount( ))

		if lRow <=0 Then
			iAction = 1
		Else
			This.GetChild("ID_MARQ_FOURN",dwChild)
			dwChild.retrieve( data)
			wf_raz_columns(row, {"ID_MARQ_FOURN","ID_REF_FOUR","ID_MODL_FOURN", &
				"ID_MARQ_ART_IFR","ID_MODL_ART_IFR"} )
		End if
		
	Case "ID_MARQ_FOURN"
		
		If data=this.GetItemString(row,"ID_MARQ_FOURN") Then return 0

		if isnull(data) or data="" Then
			wf_raz_columns(row, {"ID_REF_FOUR","ID_MODL_FOURN", &
				"ID_MARQ_ART_IFR","ID_MODL_ART_IFR"} )
		Else
	
			This.GetChild("ID_MARQ_FOURN",dwChild)
		
			lRow=dwChild.Find("ID_MARQ_ART='" + data + "'", 1, dwChild.Rowcount( ))
	
			if lRow <=0 Then
				iAction = 1
			Else
				This.GetChild("ID_MODL_FOURN",dwChild)
				dwChild.retrieve( This.GetItemString(row,"ID_FOUR"), data)
				wf_raz_columns(row, {"ID_REF_FOUR","ID_MODL_FOURN", &
					"ID_MARQ_ART_IFR","ID_MODL_ART_IFR"} )

			End if
		End if	
	Case "ID_MODL_FOURN"
		
		If data=this.GetItemString(row,"ID_MODL_FOURN") Then return 0
		
		This.GetChild("ID_MODL_FOURN",dwChild)
		
		lRow=dwChild.Find("ID_MODL_ART='" + data + "'", 1, dwChild.Rowcount( ))

		if lRow <=0 Then
			iAction = 1
		Else
			This.GetChild("ID_REF_FOUR",dwChild)
			dwChild.retrieve( This.GetItemString(row,"ID_FOUR"), This.GetItemString(row,"ID_MARQ_FOURN"), data)
			if dwChild.Rowcount( ) = 1 Then
				This.SetItem(row,"ID_REF_FOUR",dwChild.GetItemString(1,"ID_REF_FOUR") )
				This.SetItem(row,"ID_MARQ_ART_IFR",dwChild.GetItemString(1,"ID_MARQ_ART_IFR") )
				This.SetItem(row,"ID_MODL_ART_IFR",dwChild.GetItemString(1,"ID_MODL_ART_IFR") )
				This.Modify( "id_ref_four.protect='1'")
			Else
				wf_raz_columns(row, {"ID_REF_FOUR",&
					"ID_MARQ_ART_IFR","ID_MODL_ART_IFR"} )
				This.Modify( "id_ref_four.protect='0'")
			End if
			// TODO : griser si un seul item + ajout ifr
		End if
		Case "ID_REF_FOUR"
		
		If data=this.GetItemString(row,"ID_REF_FOUR") Then return 0
		
		This.GetChild("ID_REF_FOUR",dwChild)
		
		lRow=dwChild.Find("ID_REF_FOUR='" + data + "'", 1, dwChild.Rowcount( ))

		if lRow <=0 Then
			iAction = 1
		Else
			This.SetItem(row,"ID_MARQ_ART_IFR",dwChild.GetItemString(lRow,"ID_MARQ_ART_IFR") )
			This.SetItem(row,"ID_MODL_ART_IFR",dwChild.GetItemString(lRow,"ID_MODL_ART_IFR") )
		End if
	
	Case "TAUX"
		if Dec(data) < 0 or Dec(data) > 1 Then
			iAction = 1
		End if
	
End Choose

st_temoin_sav.Visible=TRUE

Return iAction
end event

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet			: w_trt_sp_param_pxpubmarch
//* Evenement 		: itemerror
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 14:48:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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

stMessage.sTitre		= "Param$$HEX1$$e900$$ENDHEX$$trage des alertes prix public/prix march$$HEX1$$e900$$ENDHEX$$"
stMessage.Icon			= Information!

stMessage.bErreurG	= TRUE

Choose Case isErrCol
	Case "ID_FOUR"
			stMessage.sVar[1] = "code fournisseur"
			stMessage.sCode	= "GENE003"
	Case "ID_REF_FOUR"
			stMessage.sVar[1] = "r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur"
			stMessage.sCode	= "GENE002"
	Case "ID_MODL_FOURN"
			stMessage.sVar[1] = "mod$$HEX1$$e800$$ENDHEX$$le fournisseur"
			stMessage.sCode	= "GENE003"
	Case "ID_MARQ_FOURN"
			stMessage.sVar[1] = "marque fournisseur"
			stMessage.sCode	= "GENE002"
	Case "TAUX"
			stMessage.sVar[1] = "taux"
			stMessage.sCode	= "GENE003"
End Choose

F_Message ( stMessage )

ll_return = This.Uf_Reinitialiser ()
Return ( ll_return )

end event

event dw_1::dberror;
//*-----------------------------------------------------------------
//*
//* Objet			: w_trt_sp_param_pxpubmarch
//* Evenement 		: dberror
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 16:52:21
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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

If sqldbcode =2601 Then // Violation contrainte PK
	stMessage.berreurg=FALSE
	stMessage.scode="GENE005"
	stMessage.sTitre="Param$$HEX1$$e900$$ENDHEX$$trage des alertes prix public/prix march$$HEX1$$e900$$ENDHEX$$"
	stMessage.sVar[1] = "Cette alerte"
	dw_1.setRow(row)
	dw_1.selectRow(0,FALSE)
	dw_1.selectRow(row,TRUE)
	f_message(stMessage)
End if

Return 1
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;String sMarque, sIdFour, sModele, sRef
Long lRow
DatawindowChild dwChild

If currentrow <=0 Then return

sIdFour=This.GetItemString(currentrow,"ID_FOUR")
This.GetChild("ID_MARQ_FOURN",dwChild)
dwChild.retrieve( sIdFour)

sMarque=This.GetItemString(currentrow,"ID_MARQ_FOURN")
This.GetChild("ID_MODL_FOURN",dwChild)
dwChild.retrieve( sIdFour, sMarque)

sModele=This.GetItemString(currentrow,"ID_MODL_FOURN")
This.GetChild("ID_MODL_FOURN",dwChild)
dwChild.retrieve( sIdFour, sMarque, sModele)

sRef=This.GetItemString(currentrow,"ID_REF_FOUR")
This.GetChild("ID_REF_FOUR",dwChild)
dwChild.retrieve( sIdFour, sMarque, sModele, sRef)

If dwChild.Rowcount( ) = 1 Then
	this.Modify( "id_ref_four.protect='1'")
Else
	this.Modify( "id_ref_four.protect='0'")
End if


end event

event dw_1::constructor;call super::constructor;ilMaxLig = 0
end event

type pb_tri from w_8_accueil`pb_tri within w_trt_sp_param_pxpubmarch
boolean visible = false
integer width = 242
integer height = 144
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_trt_sp_param_pxpubmarch
end type

type pb_appliquer from picturebutton within w_trt_sp_param_pxpubmarch
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
//* Objet			: w_trt_sp_param_pxpubmarch
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 16:05:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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

type st_temoin_sav from statictext within w_trt_sp_param_pxpubmarch
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

