HA$PBExportHeader$w_sp_trt_saisie_boutiques.srw
$PBExportComments$[PM200][PSM]
forward
global type w_sp_trt_saisie_boutiques from window
end type
type st_aucune_boutique from statictext within w_sp_trt_saisie_boutiques
end type
type cb_ajouter from commandbutton within w_sp_trt_saisie_boutiques
end type
type dw_1 from u_datawindow within w_sp_trt_saisie_boutiques
end type
type dw_lst_boutiques from u_datawindow within w_sp_trt_saisie_boutiques
end type
type cb_retour from commandbutton within w_sp_trt_saisie_boutiques
end type
type cb_valider from commandbutton within w_sp_trt_saisie_boutiques
end type
end forward

global type w_sp_trt_saisie_boutiques from window
integer width = 2651
integer height = 1024
boolean titlebar = true
string title = "Saisie boutiques de proximit$$HEX1$$e900$$ENDHEX$$"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_aucune_boutique st_aucune_boutique
cb_ajouter cb_ajouter
dw_1 dw_1
dw_lst_boutiques dw_lst_boutiques
cb_retour cb_retour
cb_valider cb_valider
end type
global w_sp_trt_saisie_boutiques w_sp_trt_saisie_boutiques

type variables
private:

String isRetour
Decimal idcIdSin

Integer K_NB_MAX_MAGASIN=2

Boolean ibNouvelleMethodeWS // [PM200_5]

soapconnection isoapcnx

// [VDOC18634]
string isAction
Long ilIdProd
string isMarque
string isModele
string isTypeApp
String isIdSin
end variables

forward prototypes
public subroutine wf_set_boutique ()
public subroutine wf_search_by_cp ()
public subroutine wf_search_by_cp2 ()
end prototypes

public subroutine wf_set_boutique ();Long lIdBoutique, lNull, lRow, lFind
String sLibBoutique=""
string  snomligne1, snomligne2, sadrligne1, sadrligne2, scp, sville

SetNull(lNull)

snomligne1=Space(35)
snomligne2=Space(35)
sadrligne1=Space(35)
sadrligne2=Space(35)
scp=Space(35)
sville=Space(35)

dw_1.accepttext( )
lIdBoutique=dw_1.getItemNumber(1,"CODE_BOUTIQUE")

SQLCA.PS_S_adresse_centrale_psm( idcidsin, String(lIdBoutique), 'SEL_BOUTIQUE', snomligne1, snomligne2, sadrligne1, sadrligne2, scp, sville)

// JFF : Si elle n'existe pas, on ne la mets pas.
If IsNull ( snomligne1 ) Or snomligne1 = "" Then
	stMessage.sTitre		= "Saisie boutique(s) de proximit$$HEX1$$e900$$ENDHEX$$"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sCode		= "COMD704 "
	stMessage.sVar[1] =  String(lIdBoutique)
	
	f_message(stMessage)
	Return
End If
// :JFF


lFind=0
If dw_lst_boutiques.RowCount( ) > 0 Then lFind=dw_lst_boutiques.Find("ID_BOUTIQUE=" + String(lIdBoutique),1,dw_lst_boutiques.RowCount( ))

If lFind <=0 Then
	// On ne l'ajoute que s'il n'est pas dans la liste
	lRow=dw_lst_boutiques.InsertRow( 0)
	dw_lst_boutiques.SetItem(lRow,"ID_BOUTIQUE",lIdBoutique)
	
	If (not isnull(sNomLigne1)) and  len(trim(sNomLigne1)) > 0 Then sLibBoutique+=sNomLigne1 + ", " 
	If (not isnull(sNomLigne2)) and  len(trim(sNomLigne2)) > 0 Then sLibBoutique+=sNomLigne2 + ", " 
	
	If (not isnull(sAdrLigne1)) and  len(trim(sAdrLigne1)) > 0 Then sLibBoutique+=sAdrLigne1 + ", " 
	If (not isnull(sAdrLigne2)) and  len(trim(sAdrLigne2)) > 0 Then sLibBoutique+=sAdrLigne2 + ", " 
	
	If (not isnull(sCp)) and  len(trim(sCp)) > 0 Then sLibBoutique+=sCp + "  " 
	If (not isnull(sVille)) and  len(trim(sVille)) > 0 Then sLibBoutique+=sVille
	
	if right(sLibBoutique,2) = ", " Then sLibBoutique=Left(sLibBoutique,Len(sLibBoutique) - 2)
	
	dw_lst_boutiques.SetItem(lRow,"LIB_BOUTIQUE",sLibBoutique)
End if

dw_1.SetItem(1,"CODE_BOUTIQUE",lNull)
end subroutine

public subroutine wf_search_by_cp ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_saisie_boutiques::wf_search_by_cp (PRIVATE)
//* Auteur			: FPI
//* Date				: 17/08/2013
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PM200-5]
//*
//* Arguments		:
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*----------------------------------------------------------------
string sRet=""
String sCp, sCode
Long lRet, lCpt
n_cst_sp_ws_psm_caller uoWsCaller
n_cst_string nvString
String sListeBtq[]

st_aucune_boutique.visible=FALSE

uoWsCaller=CREATE n_cst_sp_ws_psm_caller

If not isValid (isoapcnx) Then isoapcnx = CREATE soapconnection

lRet=uoWsCaller.createproxy(isoapcnx )

if lRet=-1 Then	
	// Erreur appel du WS
	stMessage.sTitre		= "Saisie boutique(s) de proximit$$HEX1$$e900$$ENDHEX$$"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sCode		= "COMD821 "
	
	f_message(stMessage)
End if

dw_1.accepttext( )

sCp=dw_1.GetItemString(1,"code_postal")

lRet=uoWsCaller.uf_get_boutiques( sCp, sRet)

If lRet > 0 and sRet <> "" Then
	If Pos(sRet,"#",2) <> LastPos(sRet,"#") and K_NB_MAX_MAGASIN=1 Then
		// 2 boutiques renvoy$$HEX1$$e900$$ENDHEX$$es, on prend la premi$$HEX1$$e800$$ENDHEX$$re
		sRet=Left(sRet, Pos(sRet,"#",2) - 1)
	End if
else
	if lRet < 0 Then
		stMessage.bErreurG=FALSE
		stMessage.Icon=Information!
		stMessage.Bouton=OK!
		stMessage.sTitre="Recherche de boutiques PSM"
		stMessage.sCode="GENE013"
		stMessage.sVar[1]=uoWsCaller.uf_getlastsoaperror()
		
		f_message(stMessage)
	End if
End if
							
destroy uoWsCaller

If sRet="" Then
	/*stMessage.sTitre		= "Saisie boutique(s) de proximit$$HEX1$$e900$$ENDHEX$$"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sCode		= "COMD820 "
	
	f_message(stMessage)*/
	st_aucune_boutique.visible=true
	Return
End if

nvString.of_parsetoarray ( sRet, "#", sListeBtq)

For lCpt=1 to UpperBound(sListeBtq)
	sCode=sListeBtq[lCpt]
	if sCode <> "" Then
		dw_1.SetItem(1,"CODE_BOUTIQUE",Long(sCode))
		wf_set_boutique( )
	End if
Next
end subroutine

public subroutine wf_search_by_cp2 ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_saisie_boutiques::wf_search_by_cp2 (PRIVATE)
//* Auteur			: FPI
//* Date				: 11/09/2015
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [VDoc18634]
//*
//* Arguments		:
//*					  
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
// 			FPI	15/07/2016	[VDOC21323]
//*----------------------------------------------------------------
string sRet=""
String sCp, sCode
Long lRet, lCpt
n_cst_sp_ws_btqpsm_caller uoWsCaller
n_cst_string nvString
String sListeBtq[]

st_aucune_boutique.visible=FALSE

uoWsCaller = Create n_cst_sp_ws_btqpsm_caller

dw_1.accepttext( )

sCp=dw_1.GetItemString(1,"code_postal")

lRet= uoWsCaller.uf_get_boutiques_proximites (isAction, ilIdProd, sCp, ismarque , ismodele, isIdSin, istypeapp, sRet )

If lRet > 0 and sRet <> "" Then
	If Pos(sRet,"#",2) <> LastPos(sRet,"#") and K_NB_MAX_MAGASIN=1 Then
		// 2 boutiques renvoy$$HEX1$$e900$$ENDHEX$$es, on prend la premi$$HEX1$$e800$$ENDHEX$$re
		sRet=Left(sRet, Pos(sRet,"#",2) - 1)
	End if
	// [FPI.20190930] - on zappe le message d'erreur
/*else
	if lRet < 0 Then
		stMessage.bErreurG=FALSE
		stMessage.Icon=Information!
		stMessage.Bouton=OK!
		stMessage.sTitre="Recherche de boutiques PSM"
		stMessage.sCode="GENE013"
		stMessage.sVar[1]=uoWsCaller.uf_getlastsoaperror()
		
		f_message(stMessage)
	End if*/
End if
							
destroy uoWsCaller

If sRet="" or lRet <=0 Then // [FPI.20190930]
	/*stMessage.sTitre		= "Saisie boutique(s) de proximit$$HEX1$$e900$$ENDHEX$$"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sCode		= "COMD820 "
	
	f_message(stMessage)*/
	st_aucune_boutique.visible=true
	Return
End if

nvString.of_parsetoarray ( sRet, "#", sListeBtq)

For lCpt=1 to UpperBound(sListeBtq)
	sCode=sListeBtq[lCpt]
	if sCode <> "" Then
		
		// [VDOC21323]
		Do While Len(sCode) > 0 and not isNumber(sCode)
			sCode=Mid(sCode,2)
		Loop
		// :[VDOC21323]
	
		dw_1.SetItem(1,"CODE_BOUTIQUE",Long(sCode))
		wf_set_boutique( )
	End if
Next
end subroutine

event open;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_boutiques
//* Evenement 		: open
//* Auteur			: F. Pinon
//* Date				: 14/02/2012
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  stPass.dcTab[1] = id_sin
//*				  stPass.sTab[1] = titre de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*				  stPass.sTab[2] = code postal
//*				  stPass.sTab[3] = marque
//*				  stPass.sTab[4] = mod$$HEX1$$e800$$ENDHEX$$le
//*				  stPass.sTab[5] = type appareil
//*				  stPass.lTab[1] = nombre de btq s$$HEX1$$e900$$ENDHEX$$lectionnable
//*				  stPass.lTab[2] = id_evt
//*				  stPass.lTab[3] =id_prod
//*				  stPass.bTab[1] = ibNouvelleMethodeWS
//*
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 	FPI	13/05/2013	[PC938]
//		FPI	18/07/2013	[PM200_5]
//		FPI	11/09/2015	[VDoc18634]
//		FPI	13/12/2016	[ITSM432979] Correction du n$$HEX2$$b0002000$$ENDHEX$$de dossier en string avec .00
//*-----------------------------------------------------------------
s_pass stPass
String sTitre

isRetour="[RETOUR]"
ibNouvelleMethodeWS=FALSE

st_aucune_boutique.visible=FALSE

// [PC938]
If isvalid(Message.PowerObjectParm) Then
	stPass=Message.PowerObjectParm
	idcIdSin=stPass.dctab[1]
	If upperbound(stPass.ltab) > 0 Then K_nb_max_magasin=stPass.ltab[1]
	
	If upperbound(stPass.stab) > 0 Then 
		sTitre=stPass.sTab[1]
		If sTitre <> "" Then This.Title=sTitre
	End if
	
	If upperbound(stPass.btab) > 0 Then ibNouvelleMethodeWS=stPass.bTab[1] // [PM200_5]
Else
	idcIdSin=Message.doubleparm
End if

dw_1.InsertRow(0)

// [PM200_5]
If not ibNouvellemethodews Then
	dw_1.width=1135
	cb_ajouter.x=1211
	dw_1.modify("code_postal.Protect=1")
Else
	dw_1.uf_proteger( {"code_boutique"},"1")
	
	dw_1.modify("code_boutique_t.Visible=0")
	dw_1.modify("code_boutique.Visible=0")
	
	dw_1.modify("t_1.x=18")
	dw_1.modify("code_postal.x=416")
	
	cb_ajouter.x=820
	
	If upperbound(stPass.stab) > 1 Then 
		dw_1.SetItem(1,"code_postal",stPass.sTab[2])
		
		isAction="A_REPARER"
		If stPass.lTab[2]=1377 Then isAction="A_DESOXYDER"
		
		ilIdprod=stPass.lTab[3]
		isMarque=stPass.sTab[3]
		isModele=stPass.sTab[4]
		isTypeApp=stPass.sTab[5]
		
		//isIdSin=String(idcIdSin)
		isIdSin=String(Long(idcIdSin)) // [ITSM432979]
		
		If K_nb_max_magasin=0 Then K_nb_max_magasin=2 
		
		cb_ajouter.event clicked( )
	End if
End if

end event

event close;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_boutiques
//* Evenement 		: close
//* Auteur			: F. Pinon
//* Date				: 14/02/2012
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

CloseWithReturn(This, isRetour)
end event

on w_sp_trt_saisie_boutiques.create
this.st_aucune_boutique=create st_aucune_boutique
this.cb_ajouter=create cb_ajouter
this.dw_1=create dw_1
this.dw_lst_boutiques=create dw_lst_boutiques
this.cb_retour=create cb_retour
this.cb_valider=create cb_valider
this.Control[]={this.st_aucune_boutique,&
this.cb_ajouter,&
this.dw_1,&
this.dw_lst_boutiques,&
this.cb_retour,&
this.cb_valider}
end on

on w_sp_trt_saisie_boutiques.destroy
destroy(this.st_aucune_boutique)
destroy(this.cb_ajouter)
destroy(this.dw_1)
destroy(this.dw_lst_boutiques)
destroy(this.cb_retour)
destroy(this.cb_valider)
end on

type st_aucune_boutique from statictext within w_sp_trt_saisie_boutiques
integer x = 704
integer y = 356
integer width = 1216
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Aucune boutique trouv$$HEX1$$e900$$ENDHEX$$e pour ce code postal."
boolean focusrectangle = false
end type

type cb_ajouter from commandbutton within w_sp_trt_saisie_boutiques
integer x = 1902
integer y = 28
integer width = 334
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ajouter"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_boutiques
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 14/02/2012 11:28:57
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
//* 		FPI	11/09/2015	[VDoc18634]
//*-----------------------------------------------------------------

Long lIdBoutique, lNull, lRow, lFind
String sLibBoutique=""
string  snomligne1, snomligne2, sadrligne1, sadrligne2, scp, sville

If (dw_lst_boutiques.RowCount() = K_NB_MAX_MAGASIN) Then
	stMessage.sTitre		= "Saisie boutique(s) de proximit$$HEX1$$e900$$ENDHEX$$"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sCode		= "COMD701"
	stMessage.sVar[1] = String(K_NB_MAX_MAGASIN)
	
	f_message(stMessage)
	Return	
End if

If ibnouvellemethodews Then
	// [VDoc18634]
	wf_search_by_cp2( )
Else
	wf_set_boutique( )
End if

end event

type dw_1 from u_datawindow within w_sp_trt_saisie_boutiques
integer x = 37
integer y = 32
integer width = 1815
integer height = 92
integer taborder = 10
string dataobject = "d_trt_saisie_code_boutique"
boolean border = false
end type

type dw_lst_boutiques from u_datawindow within w_sp_trt_saisie_boutiques
integer x = 37
integer y = 184
integer width = 2542
integer taborder = 10
string dataobject = "d_trt_saisie_lst_boutiques"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_boutiques
//* Evenement 		: buttonclicked
//* Auteur			: F. Pinon
//* Date				: 14/02/2012 13:42:57
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: value long row	 */
/* 	value long actionreturncode	 */
/* 	value dwobject dwo	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

if Upper(dwo.Name) = "B_SUPPR" Then
	If row > 0 Then This.deleterow( row)
End if
end event

type cb_retour from commandbutton within w_sp_trt_saisie_boutiques
integer x = 1307
integer y = 780
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Retour"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_boutiques
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 14/02/2012
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

Close(Parent)
end event

type cb_valider from commandbutton within w_sp_trt_saisie_boutiques
integer x = 800
integer y = 780
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Valider"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_boutiques
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 14/02/2012
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
String sListeBoutiques
Integer iLig

sListeBoutiques=""

If dw_lst_boutiques.Rowcount( ) =0 Then
	// [PM200-5]
	cb_retour.event clicked( )
	Return
End if

For iLig=1 To dw_lst_boutiques.Rowcount( )
	If sListeBoutiques="" Then sListeBoutiques="#"
	sListeBoutiques+=String(dw_lst_boutiques.GetItemNumber( iLig, "ID_BOUTIQUE")) + "#"
Next

isRetour= "BOUTIQUES=" + sListeBoutiques

Close(Parent)
end event

