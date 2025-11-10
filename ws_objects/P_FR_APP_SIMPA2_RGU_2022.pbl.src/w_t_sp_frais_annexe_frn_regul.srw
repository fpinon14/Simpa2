$PBExportHeader$w_t_sp_frais_annexe_frn_regul.srw
$PBExportComments$PM80
forward
global type w_t_sp_frais_annexe_frn_regul from window
end type
type dw_reg_frais_anx from datawindow within w_t_sp_frais_annexe_frn_regul
end type
type cb_valider from commandbutton within w_t_sp_frais_annexe_frn_regul
end type
end forward

global type w_t_sp_frais_annexe_frn_regul from window
integer width = 4535
integer height = 1004
boolean titlebar = true
string title = "Saisie manuelle des frais annexes prestataires sur régularisation"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
dw_reg_frais_anx dw_reg_frais_anx
cb_valider cb_valider
end type
global w_t_sp_frais_annexe_frn_regul w_t_sp_frais_annexe_frn_regul

type variables

Integer iiErreur

s_Pass istPassFrAnx

Decimal {2} idcTabMtFraisAnex [11]
end variables

forward prototypes
public function integer wf_controler ()
end prototypes

public function integer wf_controler ();//*-----------------------------------------------------------------
//*
//* Objet 			: wf_controler
//* Evenement 		: 
//* Auteur			: FABRY JF
//* Date				: 07/10/2022
//* Libellé			: 
//* Commentaires	: 
//*				     
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Decimal {2} dcIdRegBase, dcMtFraisAnexExistant, dcMtFraisAPasser, dcMtDifFraisAnx
Long lIdSin 
String sVentilFraisOrig, sVentilFraisEnCoursAff, sVentilFraisEnCoursCtrle
Integer iRetCtrleSomFrais
Long lTypeDuFrais


If dw_reg_frais_anx.GetItemDecimal ( 1, "compute_2" ) <> 0 Then
 
 	stMessage.sCode		= "REGU285"		
 	stMessage.sTitre		= "Montant non ventilé"
 	stMessage.Icon			= Information!
 	stMessage.bErreurG	= FALSE
 	stMessage.Bouton		= OK!
 	
 	F_Message ( stMessage )	
	Return -1 
End If 

lIdSin = istPassFrAnx.lTab[1]
dcIdRegBase = istPassFrAnx.dcTab[2]
idcTabMtFraisAnex [1] = dw_reg_frais_anx.GetItemDecimal ( 1, "MtIndemPrinc_1")
idcTabMtFraisAnex [2] = dw_reg_frais_anx.GetItemDecimal ( 1, "MtFraisAnex_2")
idcTabMtFraisAnex [3] = dw_reg_frais_anx.GetItemDecimal ( 1, "MtFraisAnex_3")
idcTabMtFraisAnex [4] = dw_reg_frais_anx.GetItemDecimal ( 1, "MtFraisAnex_4")
idcTabMtFraisAnex [5] = dw_reg_frais_anx.GetItemDecimal ( 1, "MtFraisAnex_5")
idcTabMtFraisAnex [6] = dw_reg_frais_anx.GetItemDecimal ( 1, "MtFraisAnex_6")
idcTabMtFraisAnex [7] = dw_reg_frais_anx.GetItemDecimal ( 1, "MtFraisAnex_7")
idcTabMtFraisAnex [8] = dw_reg_frais_anx.GetItemDecimal ( 1, "MtFraisAnex_8")
idcTabMtFraisAnex [9] = dw_reg_frais_anx.GetItemDecimal ( 1, "MtFraisAnex_9")
idcTabMtFraisAnex [10] = dw_reg_frais_anx.GetItemDecimal ( 1, "MtFraisAnex_10")		
idcTabMtFraisAnex [11] = dw_reg_frais_anx.GetItemDecimal ( 1, "MtFraisAnex_11")			

If  dw_reg_frais_anx.GetItemString ( 1, "COD_MOT_REG" ) = "RM" Then
	
	sVentilFraisOrig = space ( 50 ) 
	sVentilFraisEnCoursAff = space ( 50 ) 
	sVentilFraisEnCoursCtrle = space ( 50 ) 
	
	SQLCA.PS_S_REG_FRAIS_ANNEXE_FRN_TYP_DIF ( lIdSin, dcIdRegBase, idcTabMtFraisAnex [1], idcTabMtFraisAnex [2], idcTabMtFraisAnex [3], idcTabMtFraisAnex [4], idcTabMtFraisAnex [5], idcTabMtFraisAnex [6], idcTabMtFraisAnex [7], idcTabMtFraisAnex [8], idcTabMtFraisAnex [9], idcTabMtFraisAnex [10], idcTabMtFraisAnex [11], sVentilFraisOrig, sVentilFraisEnCoursAff, sVentilFraisEnCoursCtrle ) 

	If sVentilFraisEncoursCtrle <> sVentilFraisOrig Then
	 	stMessage.sCode		= "REGU270"		
		stMessage.sTitre		= "Incohérence sur la ventilation"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sVar[1]		= "Un ou plusieurs types de frais du RM (" + sVentilFraisEncoursAff + ") n'ont jamais été réglé sur le RN d'origine ou RP lié au RN d'origine (" + sVentilFraisOrig + ")." 		
		F_Message ( stMessage )

		Return -1
	End If 

   iRetCtrleSomFrais = SQLCA.PS_S_REG_FRAIS_ANNEXE_FRN_SOM_REGL_INCO ( lIdSin, dcIdRegBase, idcTabMtFraisAnex [1], idcTabMtFraisAnex [2], idcTabMtFraisAnex [3], idcTabMtFraisAnex [4], idcTabMtFraisAnex [5], idcTabMtFraisAnex [6], idcTabMtFraisAnex [7], idcTabMtFraisAnex [8], idcTabMtFraisAnex [9], idcTabMtFraisAnex [10], idcTabMtFraisAnex [11], dcMtFraisAnexExistant, dcMtFraisAPasser, lTypeDuFrais, dcMtDifFraisAnx ) 

	If iRetCtrleSomFrais < 0 Then
	 	stMessage.sCode		= "REGU270"		
		stMessage.sTitre		= "Incohérence sur la ventilation"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sVar[1]		= "La somme des RN/RM/RP du frais " + String ( lTypeDuFrais ) + " (" + SQLCA.FN_CODE_NUM ( lTypeDuFrais, "-W7" ) + ") est de " + String ( dcMtFraisAnexExistant) + "€, vous ne pouvez donc soustraire un RM de -" + String ( abs (dcMtFraisAPasser )) + "€, cela donnerait un nombre négatif au final (" + string ( dcMtDifFraisAnx ) + "€)."
		F_Message ( stMessage )

		Return -1
	End If 
	
End If 

Return 1
end function

on w_t_sp_frais_annexe_frn_regul.create
this.dw_reg_frais_anx=create dw_reg_frais_anx
this.cb_valider=create cb_valider
this.Control[]={this.dw_reg_frais_anx,&
this.cb_valider}
end on

on w_t_sp_frais_annexe_frn_regul.destroy
destroy(this.dw_reg_frais_anx)
destroy(this.cb_valider)
end on

event open;//*-----------------------------------------------------------------
//*
//* Objet 			: Open
//* Evenement 		: Close
//* Auteur			: FABRY JF
//* Date				: 07/10/2022
//* Libellé			: 
//* Commentaires	: 
//*				     
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

dw_reg_frais_anx.Reset ()




end event

event show;//*-----------------------------------------------------------------
//*
//* Objet 			: Show
//* Evenement 		: 
//* Auteur			: FABRY JF
//* Date				: 07/10/2022
//* Libellé			: 
//* Commentaires	: 
//*				     
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

istPassFrAnx = Message.PowerObjectParm

dw_reg_frais_anx.RowsDiscard ( 1, dw_reg_frais_anx.RowCount(), primary!) 

dw_reg_frais_anx.InsertRow (0)
dw_reg_frais_anx.SetItem ( 1, "ID_SIN", istPassFrAnx.lTab[1] )
dw_reg_frais_anx.SetItem ( 1, "ID_I", istPassFrAnx.lTab[2] ) 
dw_reg_frais_anx.SetItem ( 1, "ID_GTI", istPassFrAnx.lTab[3] )
dw_reg_frais_anx.SetItem ( 1, "ID_DETAIL", istPassFrAnx.lTab[4] )
dw_reg_frais_anx.SetItem ( 1, "mt_tot_reg", istPassFrAnx.dcTab[1] )
dw_reg_frais_anx.SetItem ( 1, "lib_four", istPassFrAnx.sTab[3] )
dw_reg_frais_anx.SetItem ( 1, "cod_mot_reg", istPassFrAnx.sTab[2] )
dw_reg_frais_anx.SetItem ( 1, "mtindemprinc_1", 0 )
dw_reg_frais_anx.SetItem ( 1, "mtfraisanex_2", 0 ) 
dw_reg_frais_anx.SetItem ( 1, "mtfraisanex_3", 0 )
dw_reg_frais_anx.SetItem ( 1, "mtfraisanex_4", 0 )
dw_reg_frais_anx.SetItem ( 1, "mtfraisanex_5", 0 )
dw_reg_frais_anx.SetItem ( 1, "mtfraisanex_6", 0 )
dw_reg_frais_anx.SetItem ( 1, "mtfraisanex_7", 0 )
dw_reg_frais_anx.SetItem ( 1, "mtfraisanex_8", 0 )
dw_reg_frais_anx.SetItem ( 1, "mtfraisanex_9", 0 )
dw_reg_frais_anx.SetItem ( 1, "mtfraisanex_10", 0 )
dw_reg_frais_anx.SetItem ( 1, "mtfraisanex_11", 0 )

dw_reg_frais_anx.SetColumn ( "mtindemprinc_1" ) 
dw_reg_frais_anx.SetFocus ()

end event

type dw_reg_frais_anx from datawindow within w_t_sp_frais_annexe_frn_regul
integer x = 46
integer y = 168
integer width = 4379
integer height = 656
integer taborder = 20
string title = "none"
string dataobject = "d_sp_reg_frais_annexe_frn_regul"
boolean border = false
end type

event itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: itemchanged
//* Evenement 		: Close
//* Auteur			: FABRY JF
//* Date				: 07/10/2022
//* Libellé			: 
//* Commentaires	: 
//*				     
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String sCodMotReg

sCodMotReg = This.GetItemString ( row, "COD_MOT_REG" )

If Dec ( data ) < 0 And sCodMotReg = "RP" Then
	iiErreur = 1
	Return 1
End If 

If Dec ( data ) > 0 And sCodMotReg = "RM" Then
	iiErreur = 2
	Return 1
End If 


end event

event itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: itemerror
//* Evenement 		: Close
//* Auteur			: FABRY JF
//* Date				: 07/10/2022
//* Libellé			: 
//* Commentaires	: 
//*				     
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------



Choose Case iiErreur 
	Case 1 
		iiErreur = 0
		stMessage.sCode		= "REGU275"
		stMessage.sVar[1]    = "positif"

	Case 2 
		iiErreur = 0
		stMessage.sCode		= "REGU275"
		stMessage.sVar[1]    = "négatif"
		
	Case Else 	
		iiErreur = 0
		stMessage.sCode		= "REGU280"		
		
End Choose 

stMessage.sTitre		= "Données non valide"
stMessage.Icon			= Exclamation!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= OK!

F_Message ( stMessage )

//This.SetItem ( row, This.GetColumnName (), String ( This.GetItemNumber ( row, This.GetColumnName ())))
This.SetText ( String ( This.GetItemDecimal ( row, This.GetColumnName ()) ))
This.setColumn (This.GetColumnName ())
This.setFocus ()
Return 1

end event

type cb_valider from commandbutton within w_t_sp_frais_annexe_frn_regul
integer x = 37
integer y = 28
integer width = 402
integer height = 132
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Valider"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: Clicked
//* Evenement 		: Close
//* Auteur			: FABRY JF
//* Date				: 07/10/2022
//* Libellé			: 
//* Commentaires	: 
//*				     
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass stPass
Long lCpt

dw_reg_frais_anx.AcceptText ()

If Wf_controler () > 0  Then

	For lCpt = 1 To 11 
		stPass.dcTab [lCpt] = idcTabMtFraisAnex [lCpt]
	Next
	
	Message.Powerobjectparm = stPass
	CloseWithReturn(Parent, Message.Powerobjectparm )
End If 


end event

