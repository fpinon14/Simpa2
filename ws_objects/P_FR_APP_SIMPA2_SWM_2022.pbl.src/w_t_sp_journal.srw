HA$PBExportHeader$w_t_sp_journal.srw
forward
global type w_t_sp_journal from window
end type
type cb_eff from commandbutton within w_t_sp_journal
end type
type cb_rech from commandbutton within w_t_sp_journal
end type
type sle_rech from singlelineedit within w_t_sp_journal
end type
type cbx_mep from checkbox within w_t_sp_journal
end type
type rb_3 from radiobutton within w_t_sp_journal
end type
type rb_2 from radiobutton within w_t_sp_journal
end type
type rb_1 from radiobutton within w_t_sp_journal
end type
type cb_retour from commandbutton within w_t_sp_journal
end type
type dw_1 from datawindow within w_t_sp_journal
end type
end forward

global type w_t_sp_journal from window
integer width = 3872
integer height = 2332
boolean titlebar = true
string title = "Journal des modifications/cr$$HEX1$$e900$$ENDHEX$$ations fonctionnelles sur SIMPA2"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_eff cb_eff
cb_rech cb_rech
sle_rech sle_rech
cbx_mep cbx_mep
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
cb_retour cb_retour
dw_1 dw_1
end type
global w_t_sp_journal w_t_sp_journal

type variables
Private : 

s_Pass istPass

String	isRepWin, isRepWord, isFic

String	K_FTUTEMP = "FTU.DOCX"



end variables

on w_t_sp_journal.create
this.cb_eff=create cb_eff
this.cb_rech=create cb_rech
this.sle_rech=create sle_rech
this.cbx_mep=create cbx_mep
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_retour=create cb_retour
this.dw_1=create dw_1
this.Control[]={this.cb_eff,&
this.cb_rech,&
this.sle_rech,&
this.cbx_mep,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.cb_retour,&
this.dw_1}
end on

on w_t_sp_journal.destroy
destroy(this.cb_eff)
destroy(this.cb_rech)
destroy(this.sle_rech)
destroy(this.cbx_mep)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_retour)
destroy(this.dw_1)
end on

event open;
String sSql


rb_3.checked = True
rb_2.checked = False
rb_1.checked = False

dw_1.SetTransObject ( SQLCA )
dw_1.Retrieve ()

istPass = Message.PowerObjectParm

cbx_MEP.Visible = upper ( SQLCA.DataBase ) <> "SIMPA2_PRO"

This.X			=   50
This.Y			=  20
This.Width		= 3863
This.Height		= 3820

Dw_1.X			=   50
Dw_1.Y			=  376
Dw_1.Width		= 3770
Dw_1.Height		= 3300


sSql = "Exec sysadm.PS_I_TRACE_JOURNAL '" + stGlb.sCodOper + "', 'ENTREE'"
F_Execute ( sSql, SQLCA )
F_Commit ( SQLCA, SQLCA.SqlCode = 0 And SQLCA.SqlDBCode = 0 )

end event

event close;

String sSql 
sSql = "Exec sysadm.PS_I_TRACE_JOURNAL '" + stGlb.sCodOper + "', 'SORTIE'"
F_Execute ( sSql, SQLCA )
F_Commit ( SQLCA, SQLCA.SqlCode = 0 And SQLCA.SqlDBCode = 0 )



end event

type cb_eff from commandbutton within w_t_sp_journal
integer x = 114
integer y = 260
integer width = 402
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Effacer"
end type

event clicked;rb_1.checked = False
rb_2.checked = False
rb_3.checked = True

sle_rech.text = ""

rb_3.triggerevent ( "clicked" )


end event

type cb_rech from commandbutton within w_t_sp_journal
integer x = 2080
integer y = 260
integer width = 608
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Rechercher un projet"
end type

event clicked;String sFiltre

rb_1.checked = False
rb_2.checked = False
rb_3.checked = True

sFiltre = Trim ( sle_rech.text )

If IsNull ( sFiltre ) Or sFiltre = "" Then return

sFiltre = Upper ( F_Remplace ( sFiltre, "'", "" ))

sFiltre = "(POS ( UPPER ( OBJET ), '" + sFiltre + "') >0 OR POS ( UPPER ( TXT_1), '" + sFiltre + "') >0 OR POS ( UPPER ( TXT_2), '" + sFiltre + "') >0)"

If cbx_mep.Checked Then sFiltre += " AND Left ( OBJET, 7 ) <> 'RECETTE'"

Dw_1.SetFilter ( sFiltre )
Dw_1.Filter ( )
Dw_1.Sort ()


end event

type sle_rech from singlelineedit within w_t_sp_journal
integer x = 526
integer y = 264
integer width = 1545
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cbx_mep from checkbox within w_t_sp_journal
integer x = 3173
integer y = 96
integer width = 631
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ne voir que les MEP"
end type

event clicked;

rb_1.checked = False
rb_2.checked = False
rb_3.checked = True
rb_3.triggerevent ( "clicked" )


end event

type rb_3 from radiobutton within w_t_sp_journal
integer x = 521
integer y = 16
integer width = 1586
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Informations g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rales"
end type

event clicked;
String sFiltre

sle_Rech.text = ""

sFiltre = ""

If cbx_mep.Checked Then sFiltre = "Left ( OBJET, 7 ) <> 'RECETTE'"

Dw_1.SetFilter ( sFiltre )
Dw_1.Filter ( )
Dw_1.Sort ()


end event

type rb_2 from radiobutton within w_t_sp_journal
integer x = 521
integer y = 96
integer width = 1586
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Informations hors produit"
end type

event clicked;
String sFiltre

sle_Rech.text = ""

sFiltre = "CH_PROD = ''"

If cbx_mep.Checked Then sFiltre += " AND Left ( OBJET, 7 ) <> 'RECETTE'"

Dw_1.SetFilter ( sFiltre )
Dw_1.Filter ( )
Dw_1.Sort ()

end event

type rb_1 from radiobutton within w_t_sp_journal
integer x = 521
integer y = 176
integer width = 1605
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Informations li$$HEX1$$e900$$ENDHEX$$es uniquement au produit de ce sinistre"
end type

event clicked;

String sFiltre

sle_Rech.text = ""

sFiltre = "POS ( CH_PROD, '," + String ( istPass.lTab[1]) + ",') > 0"

If cbx_mep.Checked Then sFiltre += " AND Left ( OBJET, 7 ) <> 'RECETTE'"

Dw_1.SetFilter ( sFiltre )
Dw_1.Filter ( )
Dw_1.Sort ()

end event

type cb_retour from commandbutton within w_t_sp_journal
integer x = 37
integer y = 36
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Retour"
end type

event clicked;


s_Pass stPass

Message.Powerobjectparm = stPass


CloseWithReturn(Parent, Message.Powerobjectparm )



end event

type dw_1 from datawindow within w_t_sp_journal
integer x = 55
integer y = 376
integer width = 3785
integer height = 1428
integer taborder = 10
string title = "Journal d~'informations SIMPA2"
string dataobject = "d_lst_journal"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;String sFtu
String sClasseWord, sRepWord, sRun, sFicSource, sFicTmp
Boolean bOk
Blob	 blBlob
Int iPos

Choose Case  dwo.name
	Case "b_ftu"
		sFtu = This.GetItemString ( row, "FTU" ) 
		
		If sFtu = "" Or IsNull ( sFtu )Then
			stMessage.sTitre		= "Pas de doc disponible"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.sCode		= "JOUR0001"
			stMessage.Bouton		= OK!
		
			F_Message ( stMessage ) 
			Return 
		End IF		

	sFicSource = ProfileString ( stGlb.sFichierIni, "JOURNAL", "FTU", "" )
	sFicSource += sFtu
	sFicTmp = Upper ( stGLB.sRepTempo + K_FTUTEMP )

	if RegistryGet("HKEY_CLASSES_ROOT\.doc", "", sClasseWord) = -1 Then sRepWord = "Winword.exe"
	if RegistryGet("HKEY_CLASSES_ROOT\"+sClasseWord + "\shell\open\command", "", sRepWord ) = -1 Then sRepWord = "Winword.exe"
	
	// Oblig$$HEX2$$e9002000$$ENDHEX$$d'ajouter $$HEX1$$e700$$ENDHEX$$a car il y a e la merde $$HEX2$$e0002000$$ENDHEX$$la fin de la chaine.
	// "C:\Program Files\Microsoft Office\Office16\WINWORD.EXE" /n "%1" /o "%u"
	iPos = Pos ( sRepWord , '"' )
	If iPos > 0 Then iPos = Pos ( sRepWord , '"', iPos + 1 )
	IF iPos > 0 Then sRepWord = Left ( sRepWord, iPos ) 

	sRun = sRepWord + " " + sFicTmp 
	
	/*------------------------------------------------------------------*/
	/* La suppression du fichier temporaire $$HEX3$$e0002000e900$$ENDHEX$$chou$$HEX1$$e900$$ENDHEX$$.						  */
	/*------------------------------------------------------------------*/
	
	If f_FileExists ( sFicTmp ) Then 
		bOk = FileDelete ( sFicTmp )
		If Not bOk Then
			Return
		End If
	End If
	
	/*------------------------------------------------------------------*/
	/* Lecture du fichier source.                                       */
	/*------------------------------------------------------------------*/
	bOk = F_LireFichierBlob ( blBlob, sFicSource )
	If Not bOk Then
		Return
	End If
	
	/*------------------------------------------------------------------*/
	/* Ecriture en local vers fichier destination.							  */
	/*------------------------------------------------------------------*/
	bOk = F_EcrireFichierBlob ( blBlob, sFicTmp)
	If Not bOk Then
		Return
	End If
	
	RUN ( sRun )		
			
		
End Choose 
end event

