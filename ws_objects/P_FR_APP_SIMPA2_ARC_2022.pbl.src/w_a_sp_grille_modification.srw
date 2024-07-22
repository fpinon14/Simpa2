HA$PBExportHeader$w_a_sp_grille_modification.srw
forward
global type w_a_sp_grille_modification from w_8_accueil
end type
type mle_sql from multilineedit within w_a_sp_grille_modification
end type
type mle_result from multilineedit within w_a_sp_grille_modification
end type
type cb_modif from commandbutton within w_a_sp_grille_modification
end type
type st_result from statictext within w_a_sp_grille_modification
end type
type mle_fait from multilineedit within w_a_sp_grille_modification
end type
type st_sql from statictext within w_a_sp_grille_modification
end type
type st_2 from statictext within w_a_sp_grille_modification
end type
type cb_effacer from commandbutton within w_a_sp_grille_modification
end type
type cb_envoi_mail from commandbutton within w_a_sp_grille_modification
end type
type cb_1 from commandbutton within w_a_sp_grille_modification
end type
end forward

global type w_a_sp_grille_modification from w_8_accueil
integer width = 3666
integer height = 2368
string title = "Grille de modification"
mle_sql mle_sql
mle_result mle_result
cb_modif cb_modif
st_result st_result
mle_fait mle_fait
st_sql st_sql
st_2 st_2
cb_effacer cb_effacer
cb_envoi_mail cb_envoi_mail
cb_1 cb_1
end type
global w_a_sp_grille_modification w_a_sp_grille_modification

forward prototypes
public function boolean wf_executer ()
end prototypes

public function boolean wf_executer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	w_a_sp_grille_modification::wf_executer
//* Auteur			:	JFF
//* Date				:	13/11/2015
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	
//*
//* Arguments		:	
//*
//* Retourne		:	
//*
//*-----------------------------------------------------------------

String sSql, sSqlCode, sSqlDbCode, sSqlErrText
Boolean bRet
String sSaut

sSaut = Char ( 13 ) + "~n~r"

sSql = Trim ( mle_Sql.text ) 
mle_Sql.text = sSql 

F_Execute ( sSql, SQLCA )

sSqlCode = String ( SQLCA.SQLCode )
sSqlDbCode = String ( SQLCA.SQLDBCode )
sSqlErrText = String ( SQLCA.SqlErrText )

bRet = long ( sSqlCode ) = 0 And Long ( sSqlDbCode ) = 0 

F_Commit ( SQLCA, bRet )

If bRet Then 
	Mle_Result.Text += String ( Today() ) + " " + String ( Now () ) + " : " + " Modification effectu$$HEX1$$e900$$ENDHEX$$e" + sSaut 
	st_result.BackColor = 65280		
Else 	
	Mle_Result.Text += String ( Today() ) + " " + String ( Now () ) + " : " + "ERREUR ! Modification rejet$$HEX1$$e900$$ENDHEX$$e" + sSaut 
	Mle_Result.Text += String ( Today() ) + " " + String ( Now () ) + " : " + "SqlCode = " + sSqlCode + sSaut 
	Mle_Result.Text += String ( Today() ) + " " + String ( Now () ) + " : " + "SqlDBCode = " + sSqlDbCode + sSaut 
	Mle_Result.Text += String ( Today() ) + " " + String ( Now () ) + " : " + "SqlErrText = " + sSqlErrText + sSaut 	
	st_result.BackColor = 255	
End If

Mle_Result.Text += "******* Fin ********" + sSaut 

If bRet Then
	Mle_Fait.Text += mle_Sql.Text + sSaut + sSaut
	Mle_Fait.Text += "******* Fin ******** ( " + String ( Today() ) + " " + String ( Now () ) + " )" + sSaut 
	mle_Sql.Text = ""
End If

Return bRet

end function

on w_a_sp_grille_modification.create
int iCurrent
call super::create
this.mle_sql=create mle_sql
this.mle_result=create mle_result
this.cb_modif=create cb_modif
this.st_result=create st_result
this.mle_fait=create mle_fait
this.st_sql=create st_sql
this.st_2=create st_2
this.cb_effacer=create cb_effacer
this.cb_envoi_mail=create cb_envoi_mail
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_sql
this.Control[iCurrent+2]=this.mle_result
this.Control[iCurrent+3]=this.cb_modif
this.Control[iCurrent+4]=this.st_result
this.Control[iCurrent+5]=this.mle_fait
this.Control[iCurrent+6]=this.st_sql
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.cb_effacer
this.Control[iCurrent+9]=this.cb_envoi_mail
this.Control[iCurrent+10]=this.cb_1
end on

on w_a_sp_grille_modification.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mle_sql)
destroy(this.mle_result)
destroy(this.cb_modif)
destroy(this.st_result)
destroy(this.mle_fait)
destroy(this.st_sql)
destroy(this.st_2)
destroy(this.cb_effacer)
destroy(this.cb_envoi_mail)
destroy(this.cb_1)
end on

event show;call super::show;//*-----------------------------------------------------------------
//*
//* Fonction		:	w_a_sp_grille_modification::show
//* Auteur			:	JFF
//* Date				:	13/11/2015
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	
//*
//* Arguments		:	
//*
//* Retourne		:	
//*
//*-----------------------------------------------------------------

mle_Sql.text = ""
mle_Result.text = ""

st_result.BackColor = 12632256

gWMdi.Height += 370
This.Height += 370

end event

type cb_debug from w_8_accueil`cb_debug within w_a_sp_grille_modification
end type

type pb_retour from w_8_accueil`pb_retour within w_a_sp_grille_modification
integer width = 242
integer height = 144
end type

event pb_retour::clicked;call super::clicked;gWMdi.Height -= 370

end event

type pb_interro from w_8_accueil`pb_interro within w_a_sp_grille_modification
boolean visible = false
integer x = 3890
integer y = 468
integer width = 242
integer height = 144
end type

type pb_creer from w_8_accueil`pb_creer within w_a_sp_grille_modification
boolean visible = false
integer x = 3881
integer y = 308
integer width = 242
integer height = 144
end type

type dw_1 from w_8_accueil`dw_1 within w_a_sp_grille_modification
integer x = 3835
integer y = 44
integer width = 320
integer height = 232
boolean enabled = false
end type

type pb_tri from w_8_accueil`pb_tri within w_a_sp_grille_modification
boolean visible = false
integer x = 3895
integer y = 624
integer width = 242
integer height = 144
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_sp_grille_modification
boolean visible = true
integer x = 3918
integer y = 788
end type

type mle_sql from multilineedit within w_a_sp_grille_modification
integer x = 32
integer y = 252
integer width = 2345
integer height = 800
integer taborder = 40
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type mle_result from multilineedit within w_a_sp_grille_modification
integer x = 37
integer y = 1320
integer width = 3465
integer height = 780
integer taborder = 50
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_modif from commandbutton within w_a_sp_grille_modification
integer x = 27
integer y = 1068
integer width = 2354
integer height = 140
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Modifier !"
end type

event clicked;
wf_Executer ()
end event

type st_result from statictext within w_a_sp_grille_modification
integer x = 37
integer y = 1244
integer width = 3424
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "R$$HEX1$$e900$$ENDHEX$$sultat"
alignment alignment = center!
boolean focusrectangle = false
end type

type mle_fait from multilineedit within w_a_sp_grille_modification
integer x = 2409
integer y = 252
integer width = 1093
integer height = 956
integer taborder = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421504
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_sql from statictext within w_a_sp_grille_modification
integer x = 32
integer y = 184
integer width = 645
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Modification $$HEX2$$e0002000$$ENDHEX$$effectuer"
boolean focusrectangle = false
end type

type st_2 from statictext within w_a_sp_grille_modification
integer x = 2409
integer y = 184
integer width = 864
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Modifications faites"
boolean focusrectangle = false
end type

type cb_effacer from commandbutton within w_a_sp_grille_modification
integer x = 718
integer y = 164
integer width = 288
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Effacer"
end type

event clicked;
mle_sql.text = ""
end event

type cb_envoi_mail from commandbutton within w_a_sp_grille_modification
integer x = 3054
integer y = 48
integer width = 434
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "test envoi mail"
end type

event clicked;n_cst_sp_ws_generatemail_caller wsCaller

generatemail_response uo_result

if MessageBox("A qui on envoie ?","Envoi $$HEX2$$e0002000$$ENDHEX$$Fabien ou Jean-Fran$$HEX1$$e700$$ENDHEX$$ois ?~n~nOui pour Fabien, Non pour Jean-Fran$$HEX1$$e700$$ENDHEX$$ois", &
	Question!,YesNo!)=1 Then
	wsCaller.mailto="fpinon@spb.eu"
Else
	wsCaller.mailto="jfabry@spb.eu"
End if

wsCaller.mailsubject="Test premier"
wsCaller.mailtypeid=728

wsCaller.uf_add_data( "nom", "toto")
wsCaller.uf_add_data( "prenom", "toto")
wsCaller.uf_add_data( "date_naissance", "toto")
wsCaller.uf_add_data( "num_adh1", "toto")
wsCaller.uf_add_data( "num_adh2", "toto")
wsCaller.uf_add_data( "date_adh1", "toto")
wsCaller.uf_add_data( "date_adh2", "toto")
wsCaller.uf_add_data( "formule1", "toto")
wsCaller.uf_add_data( "formule2", "toto")
wsCaller.uf_sendmail( uo_result )
end event

type cb_1 from commandbutton within w_a_sp_grille_modification
integer x = 2423
integer y = 52
integer width = 626
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Test Fic Excel Onglets"
end type

event clicked;String ls_file 
Int li_rtn
OLEObject lole_excel, lole_workbook

lole_excel = CREATE OLEObject

// Exemple Nomenclature nom de fichier justificatif : JUST_expl987987_20090928_122536.xls
ls_file = "testExcelOnglet.xls"
// this.ids_rapport.saveas("c:\FH\Justificatifs\"+ls_file, Excel!, true)

li_rtn = lole_excel.ConnectToNewObject("excel.application")

if li_rtn <> 0 then
      MessageBox( "Error", 'Error running MS Excel api.')
      destroy lole_Excel
else

  lole_workbook = lole_excel.WorkBooks.add ()
//  lole_workbook.saveas ( "C:\Temp\"+ls_file )
//  lole_excel.WorkBooks.Open("C:\Temp\"+ls_file ) 

  lole_workbook.worksheets(1).name = "monOng1"
  lole_workbook.worksheets(2).name = "monOng2"
  lole_workbook.worksheets(3).name = "monOng3"
  
  Int lCountSheet
  lCountSheet = lole_workbook.WorkSheets.count
  If lCountSheet < 0 Or IsNull ( lCountSheet ) Then lCountSheet = 0
  
  lole_workbook.WorkSheets.Add ()
  lole_workbook.worksheets(4).name = "monOng4"
  
  lole_workbook.worksheets(1).cells(1,1).value = "Activit$$HEX1$$e900$$ENDHEX$$1"
  lole_workbook.worksheets(2).cells(1,1).value = "Activit$$HEX1$$e900$$ENDHEX$$2"  
  lole_workbook.worksheets(3).cells(1,1).value = "Activit$$HEX1$$e900$$ENDHEX$$3"  
  lole_workbook.worksheets(4).cells(1,1).value = "Activit$$HEX1$$e900$$ENDHEX$$4"  
  
  // Set the cell value
  /*
  lole_excel.application.workbooks(1).worksheets(1).cells(1,11).value = "Activit$$HEX1$$e900$$ENDHEX$$1"
  lole_excel.application.workbooks(2).worksheets(1).cells(1,11).value = "Activit$$HEX1$$e900$$ENDHEX$$2"  
  lole_excel.application.workbooks(3).worksheets(1).cells(1,11).value = "Activit$$HEX1$$e900$$ENDHEX$$3"  
 */
/*
  ls_range = "A1:F"+string(ll_excel_rows)
  lole_excel.application.workbooks(1).worksheets(1).Range(ls_range).Select
  lole_excel.application.workbooks(1).worksheets(1).Range(ls_range).Locked = True
  ls_range = "H1:K"+string(ll_excel_rows)
  lole_excel.application.workbooks(1).worksheets(1).Range(ls_range).Select
  lole_excel.application.workbooks(1).worksheets(1).Range(ls_range).Locked = True
*/

  // Save
//  lole_excel.application.workbooks(1).save()
lole_workbook.saveas( "C:\Temp\"+ls_file )
  // Quit
  lole_excel.application.quit()
  lole_excel.DisconnectObject()
  destroy lole_excel
end if
end event

