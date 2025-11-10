$PBExportHeader$w_trt_sp_saisie_lien_article.srw
$PBExportComments$[VDoc6993
forward
global type w_trt_sp_saisie_lien_article from w_8_accueil
end type
type pb_appliquer from picturebutton within w_trt_sp_saisie_lien_article
end type
type st_temoin_sav from statictext within w_trt_sp_saisie_lien_article
end type
type pb_extraire from picturebutton within w_trt_sp_saisie_lien_article
end type
type p_xls from picture within w_trt_sp_saisie_lien_article
end type
end forward

global type w_trt_sp_saisie_lien_article from w_8_accueil
integer width = 4741
integer height = 1892
string title = "Paramétrage des liens automatiques ARTICLE<=>IFR"
event ue_supprimerdetail pbm_custom72
pb_appliquer pb_appliquer
st_temoin_sav st_temoin_sav
pb_extraire pb_extraire
p_xls p_xls
end type
global w_trt_sp_saisie_lien_article w_trt_sp_saisie_lien_article

forward prototypes
public function integer wf_valider ()
public function integer wf_controler ()
public subroutine wf_set_maj_par ()
end prototypes

event ue_supprimerdetail;//*-----------------------------------------------------------------
//*
//* Fonction		: w_trt_sp_saisie_lien_article::ue_supprimerdetail
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 11:25:19
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
//* Fonction		: w_trt_sp_saisie_lien_article::wf_valider
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 16:22:25
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
//* Fonction		: w_trt_sp_saisie_lien_article::wf_controler
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 16:13:07
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

Long lRow, lCol
String sCols[]={"ID_FOUR","ID_REF_FOUR","MARQ_IFR","MODL_IFR"}
String sErrCol[]={"- le code fournisseur","- la référence fournisseur","- la marque IFR","- le modèle IFR"}
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
		stMessage.sTitre		= "Paramétrage des liens automatiques - SIMPA2"
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
//* Fonction		: w_trt_sp_saisie_lien_article::wf_set_maj_par
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 16:33:02
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

on w_trt_sp_saisie_lien_article.create
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

on w_trt_sp_saisie_lien_article.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_appliquer)
destroy(this.st_temoin_sav)
destroy(this.pb_extraire)
destroy(this.p_xls)
end on

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			: w_trt_sp_saisie_lien_article
//* Evenement 		: ue_initialiser
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 10:36:19
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

dw_1.getchild( "ID_REF_FOUR",dwChild)
dwChild.SetTransObject( SQLCA)

dw_1.getchild( "ID_FOUR",dwChild)
dwChild.SetTransObject( SQLCA)
dwChild.retrieve( )

dw_1.getchild( "MARQ_IFR",dwChild)
dwChild.SetTransObject( SQLCA)
dwChild.retrieve( "MARQUE")

dw_1.getchild( "MODL_IFR",dwChild)
dwChild.SetTransObject( SQLCA)
dwChild.retrieve( "MODELE")


dw_1.retrieve( )
dw_1.SetSort("id_four A,marq_four A, modl_four A, id_ref_four A")
dw_1.sort()


if dw_1.RowCount() > 0 Then dw_1.Event rowfocuschanged(1)

end event

event ue_creer;call super::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet			: w_trt_sp_saisie_lien_article
//* Evenement 		: ue_creer
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 11:26:30
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

lRow=dw_1.InsertRow(0)
dw_1.Scrolltorow( lRow)
dw_1.setColumn( 1)
dw_1.SetFocus( )
end event

event show;call super::show;gwmdi.Width+=1090
end event

event hide;call super::hide;gwmdi.Width -= 1090
end event

event open;call super::open;dw_1.istri="id_four A,marq_four A, modl_four A, id_ref_four A"
end event

type cb_debug from w_8_accueil`cb_debug within w_trt_sp_saisie_lien_article
end type

type pb_retour from w_8_accueil`pb_retour within w_trt_sp_saisie_lien_article
integer width = 242
integer height = 144
end type

type pb_interro from w_8_accueil`pb_interro within w_trt_sp_saisie_lien_article
boolean visible = false
integer width = 242
integer height = 144
end type

type pb_creer from w_8_accueil`pb_creer within w_trt_sp_saisie_lien_article
integer width = 242
integer height = 144
string text = "&Valider"
string picturename = "k:\pb4obj\bmp\8_valid.bmp"
end type

event pb_creer::clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_trt_sp_saisie_lien_article
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 16:04:41
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
	This.TriggerEvent ( "ue_retour" )
End If
end event

type dw_1 from w_8_accueil`dw_1 within w_trt_sp_saisie_lien_article
boolean visible = true
integer x = 18
integer y = 192
integer width = 4567
integer height = 1476
string dataobject = "d_trt_lien_article"
boolean ibselectionactive = true
end type

event dw_1::clicked;call super::clicked;//*-----------------------------------------------------------------
//*
//* Evènement		: w_trt_sp_saisie_lien_article::clicked
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 10:52:21
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
//* 
//*-----------------------------------------------------------------

String ls_old_sort, ls_column
Char lc_sort

If isNull(dwo) then Return

This.SelectRow(0, false)
This.SelectRow(row, true)
This.ScrollToRow (row)

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
//* Objet			: w_trt_sp_saisie_lien_article
//* Evenement 		: ue_modifiermenu
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 11:55:03
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
//* Objet			: w_trt_sp_saisie_lien_article
//* Evenement 		: itemchanged
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 12:00:40
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

SetNull(sNull)
iAction=0

If isNull(dwo) Then return 0

Choose Case Upper(dwo.Name)
	Case "ID_FOUR" 
		This.GetChild("ID_FOUR",dwChild)
		
		lRow=dwChild.Find("ID_CODE_FRN='" + data + "'", 1, dwChild.Rowcount( ))

		if lRow <=0 Then
			iAction = 1
		Else
			This.GetChild("ID_REF_FOUR",dwChild)
			dwChild.retrieve( data)
		End if
		
	Case "ID_REF_FOUR"
		This.GetChild("ID_REF_FOUR",dwChild)
		
		lRow=dwChild.Find("ID_REF_FOUR='" + data + "'", 1, dwChild.Rowcount( ))

		if lRow <=0 Then
			iAction = 1
		Else
			this.setItem(row,"MARQ_FOUR",dwChild.GetItemString(lRow,"ID_MARQ_ART"))
			this.setItem(row,"MODL_FOUR",dwChild.GetItemString(lRow,"ID_MODL_ART"))
		End if
	Case "MARQ_IFR"
		
		if isnull(data) or data="" Then
			This.SetItem(row,"MODL_IFR",sNull)
		Else
			This.GetChild("MARQ_IFR",dwChild)
		
			lRow=dwChild.Find("MARQUE='" + data + "'", 1, dwChild.Rowcount( ))
	
			if lRow <=0 Then
				iAction = 1
			Else
				This.GetChild("MODL_IFR",dwChild)
			
				dwChild.SetFilter("MARQUE='" + data + "'")
				dwChild.filter( )
			End if
		End if	
	Case "MODL_IFR"
		This.GetChild("MODL_IFR",dwChild)
		
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
//* Objet			: w_trt_sp_saisie_lien_article
//* Evenement 		: itemerror
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 14:48:55
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

stMessage.sTitre		= "Paramétrage des liens automatiques - SIMPA2"
stMessage.Icon			= Information!

stMessage.bErreurG	= TRUE

Choose Case isErrCol
	Case "ID_FOUR"
			stMessage.sVar[1] = "code fournisseur"
			stMessage.sCode	= "GENE003"
	Case "ID_REF_FOUR"
			stMessage.sVar[1] = "référence fournisseur"
			stMessage.sCode	= "GENE002"
	Case "MODL_IFR"
			stMessage.sVar[1] = "modèle IFR"
			stMessage.sCode	= "GENE003"
	Case "MARQ_IFR"
			stMessage.sVar[1] = "marque IFR"
			stMessage.sCode	= "GENE002"
End Choose

F_Message ( stMessage )

ll_return = This.Uf_Reinitialiser ()
Return ( ll_return )

end event

event dw_1::dberror;
//*-----------------------------------------------------------------
//*
//* Objet			: w_trt_sp_saisie_lien_article
//* Evenement 		: dberror
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 16:52:21
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
	stMessage.sTitre="Paramétrage des liens automatiques - SIMPA2"
	stMessage.sVar[1] = "Un des liens articles "
	f_message(stMessage)
End if

Return 1
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;String sMarque
DatawindowChild dwChild

If currentrow <=0 Then return

sMarque=this.GetItemString(currentrow,"MARQ_IFR")

If not isnull(sMarque) Then
	This.GetChild("MODL_IFR",dwChild)
		
	dwChild.SetFilter("MARQUE='" + sMarque + "'")
	dwChild.filter( )
End if

end event

event dw_1::constructor;call super::constructor;ilMaxLig=0 // [FPI.20130128]
end event

type pb_tri from w_8_accueil`pb_tri within w_trt_sp_saisie_lien_article
boolean visible = false
integer width = 242
integer height = 144
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_trt_sp_saisie_lien_article
end type

type pb_appliquer from picturebutton within w_trt_sp_saisie_lien_article
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
//* Objet			: w_trt_sp_saisie_lien_article
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 05/03/2012 16:05:29
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

type st_temoin_sav from statictext within w_trt_sp_saisie_lien_article
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

type pb_extraire from picturebutton within w_trt_sp_saisie_lien_article
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
//* Objet			: w_trt_sp_saisie_lien_article::pb_extraire
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

iRet = dw_1.Saveas(stglb.sreptempo + "LIENS_ARTICLE.XLS", Excel8!,TRUE) // [MIG_PB2022]

stMessage.sTitre  	= "Extraction des liens automatiques ARTICLE<=>IFR"
stMessage.Icon			= Information!
stMessage.Bouton		= Ok!
stMessage.sVar[1] = stglb.sreptempo + "LIENS_ARTICLE.XLS"

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

type p_xls from picture within w_trt_sp_saisie_lien_article
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

