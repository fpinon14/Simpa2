HA$PBExportHeader$w_a_sp_param_frais.srw
forward
global type w_a_sp_param_frais from w_8_accueil
end type
type cb_histo from commandbutton within w_a_sp_param_frais
end type
type p_xls from picture within w_a_sp_param_frais
end type
type pb_extraire from picturebutton within w_a_sp_param_frais
end type
end forward

global type w_a_sp_param_frais from w_8_accueil
integer width = 3602
integer height = 1504
string title = "Accueil - Param$$HEX1$$e900$$ENDHEX$$trage des frais"
cb_histo cb_histo
p_xls p_xls
pb_extraire pb_extraire
end type
global w_a_sp_param_frais w_a_sp_param_frais

type variables
s_Interro	istInterroHisto
end variables

on w_a_sp_param_frais.create
int iCurrent
call super::create
this.cb_histo=create cb_histo
this.p_xls=create p_xls
this.pb_extraire=create pb_extraire
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_histo
this.Control[iCurrent+2]=this.p_xls
this.Control[iCurrent+3]=this.pb_extraire
end on

on w_a_sp_param_frais.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_histo)
destroy(this.p_xls)
destroy(this.pb_extraire)
end on

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_param_frais
//* Evenement 		: open
//* Auteur			: F. Pinon
//* Date				: 19/10/2009 14:57:49
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
itrTrans=SQLCA

/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche                                             */
/*------------------------------------------------------------------*/
pb_Interro.istInterro.wAncetre				= This
pb_Interro.istInterro.sTitre 					= "Recherche de param$$HEX1$$e800$$ENDHEX$$tres frais"
pb_Interro.istInterro.sDataObject			= "d_sp_int_param_frais"
pb_Interro.istInterro.sCodeDw					= "PARAM_FRAIS"

pb_Interro.istInterro.sData[1].sNom			= "id_prod"
pb_Interro.istInterro.sData[1].sDbName		= "id_prod"
pb_Interro.istInterro.sData[1].sType		= "NUMBER"
pb_Interro.istInterro.sData[1].sOperande	= "="
pb_Interro.istInterro.sData[1].sMoteur		= "MSS"

pb_Interro.istInterro.sData[2].sNom			= "id_four"
pb_Interro.istInterro.sData[2].sDbName		= "id_four"
pb_Interro.istInterro.sData[2].sType		= "STRING"
pb_Interro.istInterro.sData[2].sOperande	= "="

pb_Interro.istInterro.sData[3].sNom			= "id_gti"
pb_Interro.istInterro.sData[3].sDbName		= "id_gti"
pb_Interro.istInterro.sData[3].sType		= "NUMBER"
pb_Interro.istInterro.sData[3].sOperande	= "="
pb_Interro.istInterro.sData[3].sMoteur		= "MSS"

pb_Interro.istInterro.sData[4].sNom			= "maj_par"
pb_Interro.istInterro.sData[4].sDbName		= "maj_par"
pb_Interro.istInterro.sData[4].sType		= "STRING"
pb_Interro.istInterro.sData[4].sOperande	= "="

pb_Interro.istInterro.sData[5].sNom			= "maj_le"
pb_Interro.istInterro.sData[5].sDbName		= "maj_le"
pb_Interro.istInterro.sData[5].sType		= "DATETIME" // [PI056]
pb_Interro.istInterro.sData[5].sOperande	= "="

/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche historique                                  */
/*------------------------------------------------------------------*/
istInterroHisto.wAncetre				= This
istInterroHisto.sTitre 					= "Historique de param$$HEX1$$e800$$ENDHEX$$tres frais"
istInterroHisto.sDataObject			= "d_sp_int_trace_param_frais"
istInterroHisto.sCodeDw					= "PARAM_FRAIS"

istInterroHisto.sData[1].sNom			= "id_prod"
istInterroHisto.sData[1].sDbName		= "id_prod"
istInterroHisto.sData[1].sType		= "NUMBER"
istInterroHisto.sData[1].sOperande	= "="
istInterroHisto.sData[1].sMoteur		= "MSS"

istInterroHisto.sData[2].sNom			= "id_four"
istInterroHisto.sData[2].sDbName		= "id_four"
istInterroHisto.sData[2].sType		= "STRING"
istInterroHisto.sData[2].sOperande	= "="

istInterroHisto.sData[3].sNom			= "id_gti"
istInterroHisto.sData[3].sDbName		= "id_gti"
istInterroHisto.sData[3].sType		= "NUMBER"
istInterroHisto.sData[3].sOperande	= "="
istInterroHisto.sData[3].sMoteur		= "MSS"

istInterroHisto.sData[4].sNom			= "id_process"
istInterroHisto.sData[4].sDbName		= "id_process"
istInterroHisto.sData[4].sType		= "NUMBER"
istInterroHisto.sData[4].sOperande	= "="
istInterroHisto.sData[4].sMoteur		= "MSS"

istInterroHisto.sData[5].sNom			= "maj_par"
istInterroHisto.sData[5].sDbName		= "maj_par"
istInterroHisto.sData[5].sType		= "STRING"
istInterroHisto.sData[5].sOperande	= "="

istInterroHisto.sData[6].sNom			= "maj_le"
istInterroHisto.sData[6].sDbName		= "maj_le"
istInterroHisto.sData[6].sType		= "DATETIME" // [PI056]
istInterroHisto.sData[6].sOperande	= "="

/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= itrTrans
istPass.bControl	= TRUE		// Utilisation du bouton Controler
end event

event ue_fin_interro;
//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_param_frais !! OVERRIDE !!
//* Evenement 		: ue_fin_interro
//* Auteur			: F. Pinon
//* Date				: 19/10/2009 15:43:33
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

String sClause, sDate
s_Pass stPass
String sCritere[], sVal[]
Int iPos
String sIdFour, sMajPar
Long lIdProd, lIdGti
Date	dtMajLe

SetPointer( HourGlass! )

// Init
SetNull(sIdFour)
SetNull(sMajPar)
SetNull(lIdProd)
SetNull(lIdGti)
SetNull(dtMajLe)

stPass = Message.PowerObjectParm
sClause				= stPass.sTab[1]

If sClause = "" Then return 1

sClause=Mid(sClause,8)

f_decomposerchaine(sClause," and ",sCritere)

For iPos=1 to UpperBound(sCritere) step 3
	Choose case sCritere[iPos]
		Case "id_prod"
			lIdProd=Long(sCritere[iPos+2])
		Case "id_four"
			sIdFour=sCritere[iPos+2]
			sIdFour=Mid(sIdFour, 2, Len(sIdFour) - 2)
		Case "id_gti"
			lIdGti=Long(sCritere[iPos+2])
		Case "maj_par"
			sMajPar=sCritere[iPos+2]
			sMajPar=Mid(sMajPar, 2, Len(sMajPar) - 2)
		Case "maj_le"
			sDate = sCritere[iPos+2]
			sDate=Mid(sDate, 2, Len(sDate) - 2)
			dtMajLe=Date(sDate)
		End Choose
Next

dw_1.Retrieve (lIdProd,sIdFour,lIdGti,Datetime(dtMajLe),sMajPar) // [PI056] - datetime

This.TriggerEvent( "Ue_TaillerHauteur" )

dw_1.SetFocus ()
end event

event ue_preparer_interro;call super::ue_preparer_interro;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_param_frais
//* Evenement 		: ue_preparer_interro
//* Auteur			: F. Pinon
//* Date				: 19/10/2009 16:18:31
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Charge les datawindow de la fen$$HEX1$$ea00$$ENDHEX$$tre d'interroration.
//* Commentaires	:	Chargement des produits et des garantie
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild	dwcProd	// DDDW des produits.
DataWindowChild	dwcGti	// DDDW des garanties.
DataWindowChild	dwcFour	// DDDW des fournisseurs.
DataWindowChild	dwcProcess	// DDDW des process

w_interro.dw_1.GetChild ( "id_prod", dwcProd )
dwcProd.SetTransObject ( itrTrans )
dwcProd.Retrieve()

w_interro.dw_1.GetChild ( "id_gti", dwcGti )
dwcGti.SetTransObject ( itrTrans )
dwcGti.Retrieve( -1,"-1" )

w_interro.dw_1.GetChild ( "id_four", dwcFour )
dwcFour.SetTransObject ( itrTrans )
dwcFour.Retrieve( -1 )

if Lower(w_interro.dw_1.dataObject) ="d_sp_int_trace_param_frais" Then
	w_interro.dw_1.GetChild ( "id_process", dwcProcess )
	dwcProcess.SetTransObject ( itrTrans )
	dwcProcess.Retrieve( -1,"-1",-1 )
End if

end event

event ue_creer;call super::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_param_frais
//* Evenement 		: ue_creer
//* Auteur			: F. Pinon
//* Date				: 20/10/2009 10:00:45
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

istPass.bInsert = True

f_OuvreTraitement ( W_T_Sp_Param_frais, istPass )
end event

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_param_frais
//* Evenement 		: ue_modifier
//* Auteur			: F. Pinon
//* Date				: 20/10/2009 10:02:45
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

istPass.bInsert = False

istPass.sTab[1] 	= String(dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_SEQ" ))

istPass.bSupprime	= TRUE

f_OuvreTraitement ( w_t_sp_param_frais, istPass ) 


end event

type cb_debug from w_8_accueil`cb_debug within w_a_sp_param_frais
end type

type pb_retour from w_8_accueil`pb_retour within w_a_sp_param_frais
integer width = 242
integer height = 144
end type

type pb_interro from w_8_accueil`pb_interro within w_a_sp_param_frais
integer width = 242
integer height = 144
end type

type pb_creer from w_8_accueil`pb_creer within w_a_sp_param_frais
integer width = 242
integer height = 144
end type

type dw_1 from w_8_accueil`dw_1 within w_a_sp_param_frais
integer x = 18
integer width = 3515
string dataobject = "d_sp_a_param_frais"
end type

event dw_1::constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_param_frais
//* Evenement 		: constructor
//* Auteur			: F. Pinon
//* Date				: 19/10/2009 14:53:41
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

This.SetTransObject(SQLCA)
This.iitmheight = 16
end event

type pb_tri from w_8_accueil`pb_tri within w_a_sp_param_frais
boolean visible = false
integer x = 1847
integer width = 242
integer height = 144
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_sp_param_frais
integer x = 2089
end type

type cb_histo from commandbutton within w_a_sp_param_frais
integer x = 763
integer y = 16
integer width = 343
integer height = 136
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Historique"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_sp_param_frais
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 02/11/2009 14:20:06
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

s_pass		stPass		// structure de passage pour l'appel de W_t_sp_c_trace_param_frais.
String 		sClause, sIdFour, sMajPar, sDate
String 		sCritere []
Long 			lIdProd, lIdGti, lIdProcess
Date			dtMajLe 
Integer 		iPos

SetPointer ( HourGlass! )

// Init
SetNull(sIdFour)
SetNull(sMajPar)
SetNull(lIdProd)
SetNull(lIdGti)
SetNull(lIdProcess)
SetNull(dtMajLe)

//  Fen$$HEX1$$ea00$$ENDHEX$$tre d'interro
OpenWithParm( w_Interro, istInterroHisto )

// R$$HEX1$$e900$$ENDHEX$$cup des infos
stPass = Message.PowerObjectParm
sClause				= stPass.sTab[1]

If sClause = "" Then return 1

sClause=Mid(sClause,8)

f_decomposerchaine(sClause," and ",sCritere)

For iPos=1 to UpperBound(sCritere) step 3
	Choose case sCritere[iPos]
		Case "id_prod"
			lIdProd=Long(sCritere[iPos+2])
		Case "id_four"
			sIdFour=sCritere[iPos+2]
			sIdFour=Mid(sIdFour, 2, Len(sIdFour) - 2)
		Case "id_gti"
			lIdGti=Long(sCritere[iPos+2])
		Case "id_process"
			lIdProcess=Long(sCritere[iPos+2])
		Case "maj_par"
			sMajPar=sCritere[iPos+2]
			sMajPar=Mid(sMajPar, 2, Len(sMajPar) - 2)
		Case "maj_le"
			sDate = sCritere[iPos+2]
			sDate=Mid(sDate, 2, Len(sDate) - 2)
			dtMajLe=Date(sDate)
		End Choose
Next

// Fen$$HEX1$$ea00$$ENDHEX$$tre de consult

If isValid ( W_t_sp_c_trace_param_frais )	= False	Then

	stPass.trTrans 		= istPass.trTrans
	stPass.wParent			= Parent.ParentWindow()
	stPass.bEnableParent	= False
	stPass.lTab [ 1 ] = lIdProd 
	stPass.lTab [ 2 ] = lIdGti  
	stPass.lTab [ 3 ] = lIdProcess
	stPass.sTab [ 1 ] = sIdFour
	stPass.sTab [ 2 ] = sMajPar
	stPass.dtab[1] = dtMajLe 

	OpenWithParm ( W_t_sp_c_trace_param_frais, stPass, stPass.wParent )

Else

	W_t_sp_c_trace_param_frais.ilIdProd    = lIdProd
	W_t_sp_c_trace_param_frais.ilIdGti     = lIdGti
	W_t_sp_c_trace_param_frais.ilIdProcess = lIdProcess
	W_t_sp_c_trace_param_frais.isIdFour    = sIdFour
	W_t_sp_c_trace_param_frais.idtMajLe    = dtMajLe
	W_t_sp_c_trace_param_frais.isMajPar    = sMajPar
	W_t_sp_c_trace_param_frais.ibFromAccueil = TRUE
	W_t_sp_c_trace_param_frais.Show ()

End If



end event

type p_xls from picture within w_a_sp_param_frais
integer x = 1225
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

pb_extraire.Event clicked()
end event

type pb_extraire from picturebutton within w_a_sp_param_frais
integer x = 1152
integer y = 16
integer width = 233
integer height = 136
integer taborder = 60
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
//* Objet			: w_a_sp_param_frais::pb_extraire
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 05/11/2009 11:46:42
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

Datastore dsParamFrais
Long lNull
String sNull
DateTime dtNull // [PI056] - passage de date en datetime
Integer iRet

SetNull(lNull)
SetNull(sNull)
SetNull(dtNull)

dsParamFrais = CREATE DataStore
dsParamFrais.dataobject="d_sp_a_param_frais"
dsParamFrais.SetTransObject(SQLCA)
dsParamFrais.Retrieve(lNull,sNull,lNull,dtNull, sNull)

iRet = dsParamFrais.Saveas(stglb.sreptempo + "PARAM_FRAIS.XLS", Excel!,TRUE)

stMessage.sTitre  	= "Extraction du param$$HEX1$$e900$$ENDHEX$$trage des frais"
stMessage.Icon			= Information!
stMessage.Bouton		= Ok!
stMessage.sVar[1] = stglb.sreptempo + "PARAM_FRAIS.XLS"

If iRet = 1 Then
	stMessage.bErreurG	= FALSE
	stMessage.sCode	= "GENE013"
	stMessage.sVar[1] = "Le fichier " + stMessage.sVar[1] + " a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$."
Else
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "ANCE008"
End if

Destroy dsParamFrais

f_message(stMessage)

end event

