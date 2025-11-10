HA$PBExportHeader$w_trt_sp_ifr_code_equivalence.srw
$PBExportComments$Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour modification code $$HEX1$$e900$$ENDHEX$$quivalence
forward
global type w_trt_sp_ifr_code_equivalence from w_8_traitement
end type
type pb_enregistrer from picturebutton within w_trt_sp_ifr_code_equivalence
end type
end forward

global type w_trt_sp_ifr_code_equivalence from w_8_traitement
integer x = 0
integer y = 0
integer width = 4261
integer height = 1752
pb_enregistrer pb_enregistrer
end type
global w_trt_sp_ifr_code_equivalence w_trt_sp_ifr_code_equivalence

type variables
long    ilLigne = 0
end variables

on ue_item5;call w_8_traitement::ue_item5;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Code_Equivalence
//* Evenement 		: ue_item5
//* Auteur			: PLJ
//* Date				: 02/11/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

Long		lLigne, lOrdreColSource
String	sIdSource, sCol, sLibCol 

If ilLigne <> 0 Then

	sIdSource		 = dw_1.GetItemString ( ilLigne, "ID_SOURCE"        )
	sCol				 = dw_1.GetItemString ( ilLigne, "ID_COL"           )
	sLibCol			 = dw_1.GetItemString ( ilLigne, "LIB_COL"          )
	lOrdreColSource = dw_1.GetItemNumber ( ilLigne, "ORDRE_COL_SOURCE" )


	lLigne = dw_1.InsertRow ( ilLigne + 1 )
	dw_1.SetItem ( lLigne, "ID_SOURCE",        sIdSource )
	dw_1.SetItem ( lLigne, "ID_COL",           sCol      )
	dw_1.SetItem ( lLigne, "LIB_COL",          '-1'      )
	dw_1.SetItem ( lLigne, "ORDRE_COL_SOURCE", lOrdreColSource )
	dw_1.SetItem ( lLigne, "ID_VAL",           ""        )
	dw_1.SetItem ( lLigne, "LIB_VAL",          ""        )

	f_CreeLe (dw_1, lLigne)
   f_MajPar (dw_1, lLigne)

	dw_1.GroupCalc()
	dw_1.SetRedraw (True)

	Dw_1.SetRow ( lLigne )
	Dw_1.ScrollToRow ( lLigne )
	Dw_1.SetColumn ( "ID_VAL" )

End If


end on

event show;call super::show;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Code_Equivalence
//* Evenement 		: Show
//* Auteur			: PLJ
//* Date				: 29/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//       JFF   23/05/2018 [PM373-2]
//*-----------------------------------------------------------------


dw_1.Retrieve ()

// [PM373-2]
dw_1.Setsort ( "ORDRE_COL_SOURCE A, ORDRE_VALEUR A")
dw_1.sort ()
dw_1.GroupCalc ()

gWMdi.Width += 1000
end event

on hide;call w_8_traitement::hide;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Code_Equivalence
//* Evenement 		: Show
//* Auteur			: PLJ
//* Date				: 29/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------


gWMdi.Width -= 1000
end on

on w_trt_sp_ifr_code_equivalence.create
int iCurrent
call super::create
this.pb_enregistrer=create pb_enregistrer
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_enregistrer
end on

on w_trt_sp_ifr_code_equivalence.destroy
call super::destroy
destroy(this.pb_enregistrer)
end on

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Code_Equivalence
//* Evenement 		: ue_initialiser
//* Auteur			: PLJ
//* Date				: 29/10/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//       JFF   23/05/2018 [PM373-2]
//*-----------------------------------------------------------------

dw_1.dataobject = "d_trt_sp_ifr_code_equivalence_v01"

dw_1.SetTransObject (SQLCA)
end event

type cb_debug from w_8_traitement`cb_debug within w_trt_sp_ifr_code_equivalence
end type

type dw_1 from w_8_traitement`dw_1 within w_trt_sp_ifr_code_equivalence
integer x = 41
integer y = 172
integer width = 4192
integer height = 1476
string dataobject = "d_trt_sp_ifr_code_equivalence"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::ue_modifiermenu;call super::ue_modifiermenu;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Code_Equivalence::dw_1
//* Evenement 		: ue_modifiermenu
//* Auteur			: PLJ
//* Date				: 02/11/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------

Long lCpt, lLigne, lPos
String stext, sCol

ilLigne = 0

For	lCpt = 1	To 5
		This.Uf_Mnu_CacherItem ( lCpt )
Next

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du num$$HEX1$$e900$$ENDHEX$$ro de ligne                                  */
/*------------------------------------------------------------------*/
sText = This.GetObjectAtPointer ()

If	sText <> "" Then
	lPos		= Pos ( sText, "~t" )
	lLigne   = Long ( Mid( sText, lPos + 1 ) )

	If lLigne > 0 Then		

		/*---------------------------------------------------------*/
      /* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du type de ligne                           */
      /*---------------------------------------------------------*/
		sCol = This.GetItemString ( lLigne, "LIB_COL" )
		If sCol <> '-1' Then  
			This.Uf_Mnu_ChangerText ( 5, "Ajouter une nouvelle valeur pour la colonne " + sCol )
			This.Uf_Mnu_MontrerItem ( 5 )
			ilLigne = lLigne
		End If

	End If

End If


end event

on dw_1::itemchanged;call w_8_traitement`dw_1::itemchanged;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Code_Equivalence::dw_1
//* Evenement 		: ItemChanged
//* Auteur			: PLJ
//* Date				: 02/11/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
If pb_Enregistrer.Enabled = False Then
	pb_Enregistrer.Enabled = True
End If
end on

type st_titre from w_8_traitement`st_titre within w_trt_sp_ifr_code_equivalence
boolean visible = false
integer x = 4626
integer y = 24
end type

type pb_retour from w_8_traitement`pb_retour within w_trt_sp_ifr_code_equivalence
integer y = 12
integer width = 242
integer height = 144
end type

type pb_valider from w_8_traitement`pb_valider within w_trt_sp_ifr_code_equivalence
boolean visible = false
integer x = 283
integer y = 12
boolean enabled = false
end type

type pb_imprimer from w_8_traitement`pb_imprimer within w_trt_sp_ifr_code_equivalence
boolean visible = false
integer x = 4741
integer y = 108
integer width = 274
integer height = 160
integer taborder = 70
boolean enabled = false
end type

type pb_controler from w_8_traitement`pb_controler within w_trt_sp_ifr_code_equivalence
boolean visible = false
integer x = 4270
integer y = 108
boolean enabled = false
end type

type pb_supprimer from w_8_traitement`pb_supprimer within w_trt_sp_ifr_code_equivalence
boolean visible = false
integer x = 4498
integer y = 112
integer taborder = 60
boolean enabled = false
end type

type pb_enregistrer from picturebutton within w_trt_sp_ifr_code_equivalence
integer x = 283
integer y = 12
integer width = 242
integer height = 144
integer taborder = 50
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Enregistrer"
string picturename = "k:\pb4obj\bmp\8_savfil.bmp"
string disabledname = "k:\pb4obj\bmp\8_savoff.bmp"
end type

event clicked;//*-----------------------------------------------------------------
//* Objet 			: W_Trt_Sp_Ifr_Code_Equivalence::pb_enregistrer
//* Evenement 		: ItemChanged
//* Auteur			: PLJ
//* Date				: 02/11/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//       JFF   23/05/2018 [PM373-2]
//*-----------------------------------------------------------------
Long lTot, lCpt, lTri
String sCodeCol, sCodeColSav, sIdVal

dw_1.AcceptText ()

lTot = dw_1.Rowcount()

sCodeColSav = ""

For lCpt = lTot To 1 Step -1
	sIdVal   = dw_1.GetItemString ( lCpt, "ID_VAL" )
	If Trim ( sIdVal ) = "" Or IsNull ( sIdVal ) Then
		dw_1.DeleteRow ( lCpt )
	End If

	If sIdVal = "-1" Then
		dw_1.SetItem ( lCpt, "ORDRE_VALEUR", 0)
	End If
Next 

dw_1.SetRedraw ( False ) 
dw_1.sort ()
dw_1.GroupCalc ()
dw_1.SetFilter ( "ID_VAL <> '-1'")
dw_1.Filter ()

lTot = dw_1.Rowcount()	

For lCpt = 1 To lTot 
	sCodeCol = dw_1.GetItemString ( lCpt, "ID_COL" )
	
	If sCodeCol = sCodeColSav Then
		lTri = lTri + 2
	Else
		lTri = 2
		sCodeColSav = sCodeCol 
	End If

	dw_1.SetItem ( lCpt, "ORDRE_VALEUR", lTri )
	
Next 

dw_1.SetFilter ( "")
dw_1.Filter ()
dw_1.sort ()
dw_1.GroupCalc ()
dw_1.SetRedraw ( True ) 



dw_1.update     ()
f_commit ( SqlCa, True )

pb_enregistrer.Enabled = False
end event

