HA$PBExportHeader$w_sp_trt_imei_force_ok.srw
$PBExportComments$Ecran de Forcage $$HEX2$$e0002000$$ENDHEX$$OK des IMEI
forward
global type w_sp_trt_imei_force_ok from w_8_accueil
end type
type cb_charger from commandbutton within w_sp_trt_imei_force_ok
end type
type cb_annuler from commandbutton within w_sp_trt_imei_force_ok
end type
type st_charger from statictext within w_sp_trt_imei_force_ok
end type
type st_extraire from statictext within w_sp_trt_imei_force_ok
end type
type cb_controler from commandbutton within w_sp_trt_imei_force_ok
end type
type cb_maj from commandbutton within w_sp_trt_imei_force_ok
end type
type dw_charger from datawindow within w_sp_trt_imei_force_ok
end type
type hpb_trt from hprogressbar within w_sp_trt_imei_force_ok
end type
type ddlb_typ_fichier from dropdownlistbox within w_sp_trt_imei_force_ok
end type
type st_typ_fichier from statictext within w_sp_trt_imei_force_ok
end type
end forward

global type w_sp_trt_imei_force_ok from w_8_accueil
integer width = 3538
integer height = 1952
long backcolor = 67108864
cb_charger cb_charger
cb_annuler cb_annuler
st_charger st_charger
st_extraire st_extraire
cb_controler cb_controler
cb_maj cb_maj
dw_charger dw_charger
hpb_trt hpb_trt
ddlb_typ_fichier ddlb_typ_fichier
st_typ_fichier st_typ_fichier
end type
global w_sp_trt_imei_force_ok w_sp_trt_imei_force_ok

type prototypes

Function Uint	SetCurrentDirectoryA ( ref string sDir ) library "KERNEL32.DLL" alias for "SetCurrentDirectoryA;Ansi"
Function ULong	GetCurrentDirectoryA ( ulong ulSize, ref string sDir ) library "KERNEL32.DLL" alias for "GetCurrentDirectoryA;Ansi"


//SetCurrentDirectoryA
end prototypes

type variables
Private :

//constant String	K_FICCHARG = "FICFOURN.TXT" // Nom du fichier de donn$$HEX1$$e900$$ENDHEX$$e de facturation
constant String	K_TYP_FIC_ENC = "Fichier Extraction En-cours"
constant String	K_TYP_FIC_REJ = "Fichier Rejet"

datastore ids_charger
end variables

forward prototypes
private function boolean wf_chargerdonnees ()
private function boolean wf_controler ()
private function boolean wf_maj ()
end prototypes

private function boolean wf_chargerdonnees ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_trt_autofact::wf_ChargerDonnees (PRIVATE)
//* Auteur        : PHG
//* Date          : 22/11/2006
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Chargement des donn$$HEX1$$e900$$ENDHEX$$es
//* Commentaires  : Chargement des r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences commandes SPB se trouvant
//*					  sur <REP_TEMPO>\FICFOURN.TXT
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Boolean bOk
Long	lTotRow
String sPath, sFicImport, sSavPAth
integer iRet
stMessage.sTitre  	= "Controle de saisie"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= Ok!

bOk = True

//sPath = stGlb.sRepTempo

sSavPath = Space(254)
iRet = GetCurrentDirectoryA(254, sSavPath)
if iRet <> 0 then
	iRet = SetCurrentDirectoryA(stGlb.sRepTempo)
end If
if iRet <> 0 then
	iRet = GetFileOpenName("Ouvrir un fichier de Dossier $$HEX2$$e0002000$$ENDHEX$$Forcer", &
		 + sPath, sFicImport, "txt", &
		 + "Fichier Texte s$$HEX1$$e900$$ENDHEX$$parateur tabulation (*.Txt), *.txt")
	sFicImport = sPath 
End If
if iRet <> 0 then
	iRet = SetCurrentDirectoryA(sSavPath)
end If

//Messagebox("debug", sFicImport)
//return true

/*------------------------------------------------------------------*/
/* Chemin ou Fichier Excel introuvable.                             */
/*------------------------------------------------------------------*/

If Not f_FileExists ( sFicImport ) Then
	stMessage.sCode = "COMD036" 
	stMessage.sVar [1] = sFicImport
	bOk = False
End If

/*------------------------------------------------------------------*/
/* Chargement des donn$$HEX1$$e900$$ENDHEX$$es.                                          */
/*------------------------------------------------------------------*/
If bOk Then
	lTotRow = dw_Charger.ImportFile ( sFicImport )

	If lTotRow < 0 Then
		stMessage.sCode = "COMD037"
		stMessage.sVar [1] = String ( lTotRow )
		bOk = False
	End If
	
End If

/*------------------------------------------------------------------*/
/* MAJ du static text                                               */
/*------------------------------------------------------------------*/
If bOk Then
	st_Charger.Text = String ( lTotRow ) + " sinistres charg$$HEX1$$e900$$ENDHEX$$s."
End If


If Not bOk Then F_Message ( stMessage )

Return bOk


end function

private function boolean wf_controler ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_trt_autofact::wf_Controler (PRIVATE)
//* Auteur        : PHG, d'apr$$HEX1$$e800$$ENDHEX$$s JFF ( w_sp_trt_stat3 )
//* Date          : 21/11/2006
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le des donn$$HEX1$$e900$$ENDHEX$$es
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

Long		lTotRow, lCpt, lPos
Boolean	bOk, bError
String	sDteEnvoi, sNomPrenom, sDteSurv, sIdSin, sNumImeiPort, &
			sNumPort, dDteDdu, sSuiviImei, sReponse
String 	sErreur

Long	 	lIdSin


bOk = True
sErreur = ''

lTotRow = dw_Charger.RowCount ()
hpb_trt.MaxPosition = lTotRow

// On vide le datastore de traitement.
ids_Charger.reset()

SetPointer(HourGlass!)

For lCpt = 1 to lTotRow
	// Chargement dans les variables de controle
	sIdSin 		= string(dw_charger.object.id_sin[lCpt])
	sDteEnvoi 	= string(dw_charger.object.dte_envoi[lCpt])
	sNomPrenom 	= string(dw_charger.object.nom_prenom[lCpt])
	sDteSurv 	= string(dw_charger.object.dte_surv[lCpt])
	sIdSin 		= string(dw_charger.object.id_sin[lCpt])
	sNumImeiPort = string(dw_charger.object.num_imei_port[lCpt])
	sNumPort 	= string(dw_charger.object.num_port[lCpt])
	if dw_charger.dataobject = "d_trt_charge_extraction_imei" then
		dDteDdu 		= string(dw_charger.object.dte_ddu[lCpt])
		sSuiviImei 	= string(dw_charger.object.suivi_imei[lCpt])
	else
		sReponse 	= string(dw_charger.object.reponse[lCpt])
	end If

	// Controle Forme Id-Sin : Il doit $$HEX1$$ea00$$ENDHEX$$tre num$$HEX1$$e900$$ENDHEX$$rique et <= 7 chiffres
	// Utilisation des codes retour des cast de Long et Integer
	// pour ce faire.
	
	lIdSin = Long(sIdSin)
	bOk = (lIdSin<>0) and ( Not IsNull (lIdSin) ) and len(trim(sIdSin)) <= 10   // [PI062]
	if Not bOk then sErreur = "Dossier de sinistre " + sIdSin + " invalide."
	if bOk then
		// Copie des champs dans le ds de stockage
		lPos = ids_charger.InsertRow(0)

		ids_charger.object.dte_envoi[lCpt] 		= sDteEnvoi
		ids_charger.object.nom_prenom[lCpt] 	= sNomPrenom
		ids_charger.object.dte_surv[lCpt]		= sDteSurv
		ids_charger.object.id_sin[lPos] 			= lIdSin
		ids_charger.object.num_imei_port[lCpt] = sNumImeiPort
		ids_charger.object.num_port[lCpt] 		= sNumPort
		if dw_charger.dataobject = "d_trt_charge_extraction_imei" then
			ids_charger.object.dte_ddu[lCpt]		= dDteDdu
			ids_charger.object.suivi_imei[lCpt] = sSuiviImei
		else
			ids_charger.object.reponse[lCpt]		= sReponse
		end If

		SetNull(lPos)
		hpb_trt.Position++
	End If
Next

If bOk Then
	st_Extraire.Text  = "Contr$$HEX1$$f400$$ENDHEX$$le Ok !"
else
	st_Extraire.Text  = "Erreur sur la ligne n$$HEX1$$b000$$ENDHEX$$"+string(lCpt)+" "+sErreur
End If
SetPointer(Arrow!)

Return bOk
end function

private function boolean wf_maj ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_sp_trt_autofact::wf_Maj (PRIVATE)
//* Auteur        : PHG, d'apr$$HEX1$$e800$$ENDHEX$$s JFF
//* Date          : 21/11/2006
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : 
//*					  
//*
//* Arguments     : 
//*
//* Retourne      : Boolean	bRet
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*-----------------------------------------------------------------

Long		lCpt, lTot, lNbTraite, lRet
String	sTraite = 'N'
Boolean	bRet

lNbTraite = 0
bRet = False
lTot = dw_Charger.RowCount()
hpb_trt.Position = 0
hpb_trt.MaxPosition = lTot

stMessage.sTitre		= "Forcage $$HEX2$$e0002000$$ENDHEX$$Ok des dossiers." 
stMessage.Icon			= Exclamation!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= YesNo!
stMessage.sCode		= "COMD436" 
stMessage.sVar[1]		= String ( lTot )

If F_Message ( stMessage ) = 1 Then

	bRet = True

	For lCpt = 1 To lTot
		lRet = sqlca.PS_U01_EXCEPTION_FORCAGE_OK (long(ids_charger.object.id_sin[lCpt]),	&
												 stGlb.sCodOper,		&
												 sTraite )
									
		bRet = ( SQLCA.sqlcode = 0 And SQLCA.sqlDBcode = 0  And lRet = 0 )

		if sTraite = 'O' then lNbTraite++
		if bRet then 
			hpb_trt.Position++
			F_Commit ( SQLCA, True )
		else
			exit
		End If
	Next

	If Not bRet Then
		stMessage.Icon		= Exclamation!
		stMessage.sCode	= "SFRP100"
		stMessage.sVar[1] 	= String ( SQLCA.SqlDbCode )
		stMessage.sVar[2] 	= SQLCA.SqlErrText
		F_Commit ( SQLCA, False )
	Else
		stMessage.Icon		= Information!
		stMessage.sCode	= "COMD437"
		stMessage.sVar[1]	= String ( lNbTraite )
	End If

	stMessage.sTitre		= "Forcage des sinistres $$HEX2$$e0002000$$ENDHEX$$Ok effectu$$HEX1$$e900$$ENDHEX$$s."
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!

	F_Message ( stMessage )

End If

Return bRet
end function

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Trt_Extr1::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: PHG, d'apr$$HEX1$$e800$$ENDHEX$$s JFF ( w_sp_trt_stat3 )
//* Date				: 20/11/2006
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

DataWindowChild dwChild
Long lRow

This.Title = "Proc$$HEX1$$e900$$ENDHEX$$dure Exception Controle IMEI"

ids_charger = create datastore
ddlb_typ_fichier.SelectItem( K_TYP_FIC_ENC, 1)
ids_charger.dataobject = "d_trt_charge_extraction_imei"
dw_charger.dataobject = "d_trt_charge_extraction_imei"
end event

event show;call super::show;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_autofact
//* Evenement     : Show
//* Auteur        : PHG, d'apr$$HEX1$$e800$$ENDHEX$$s JFF ( w_sp_trt_stat3 )
//* Date          : 20/11/2006
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Chargement des donn$$HEX1$$e900$$ENDHEX$$es
//* Commentaires  : Chargement des r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences commandes SPB se trouvant
//*					  sur C:\WINNT\TEMP\DEVIS.TXT
//*
//* Arguments     : Aucun
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

String	sIdFourn, sModif


cb_Charger.Enabled = ddlb_typ_fichier.text <> ""


cb_Annuler.Enabled = False
cb_Controler.Enabled = False
cb_Maj.Enabled = False
hpb_trt.Position = 0

st_charger.Text = ""
st_Extraire.Text = ""

Dw_Charger.Reset ()
if isvalid(ids_Charger) then ids_Charger.reset ()

end event

on w_sp_trt_imei_force_ok.create
int iCurrent
call super::create
this.cb_charger=create cb_charger
this.cb_annuler=create cb_annuler
this.st_charger=create st_charger
this.st_extraire=create st_extraire
this.cb_controler=create cb_controler
this.cb_maj=create cb_maj
this.dw_charger=create dw_charger
this.hpb_trt=create hpb_trt
this.ddlb_typ_fichier=create ddlb_typ_fichier
this.st_typ_fichier=create st_typ_fichier
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_charger
this.Control[iCurrent+2]=this.cb_annuler
this.Control[iCurrent+3]=this.st_charger
this.Control[iCurrent+4]=this.st_extraire
this.Control[iCurrent+5]=this.cb_controler
this.Control[iCurrent+6]=this.cb_maj
this.Control[iCurrent+7]=this.dw_charger
this.Control[iCurrent+8]=this.hpb_trt
this.Control[iCurrent+9]=this.ddlb_typ_fichier
this.Control[iCurrent+10]=this.st_typ_fichier
end on

on w_sp_trt_imei_force_ok.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_charger)
destroy(this.cb_annuler)
destroy(this.st_charger)
destroy(this.st_extraire)
destroy(this.cb_controler)
destroy(this.cb_maj)
destroy(this.dw_charger)
destroy(this.hpb_trt)
destroy(this.ddlb_typ_fichier)
destroy(this.st_typ_fichier)
end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_autofact
//* Evenement 		: close
//* Auteur			: Pierre-Henri Gillot
//* Date				: 23/11/2006 13:27:36
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

if isvalid(ids_charger) then destroy ids_charger
end event

type cb_debug from w_8_accueil`cb_debug within w_sp_trt_imei_force_ok
end type

type pb_retour from w_8_accueil`pb_retour within w_sp_trt_imei_force_ok
integer width = 242
integer height = 144
integer taborder = 130
end type

type pb_interro from w_8_accueil`pb_interro within w_sp_trt_imei_force_ok
boolean visible = false
integer taborder = 150
boolean enabled = false
end type

type pb_creer from w_8_accueil`pb_creer within w_sp_trt_imei_force_ok
boolean visible = false
integer taborder = 140
boolean enabled = false
end type

type dw_1 from w_8_accueil`dw_1 within w_sp_trt_imei_force_ok
integer x = 0
integer y = 1520
integer width = 302
integer height = 244
integer taborder = 30
end type

type pb_tri from w_8_accueil`pb_tri within w_sp_trt_imei_force_ok
boolean visible = false
integer taborder = 160
boolean enabled = false
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_sp_trt_imei_force_ok
integer taborder = 20
end type

type cb_charger from commandbutton within w_sp_trt_imei_force_ok
integer x = 101
integer y = 312
integer width = 873
integer height = 172
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Charger les r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_autofact::cb_Charger
//* Evenement     : Clicked
//* Auteur        : PHG, d'apr$$HEX1$$e800$$ENDHEX$$s JFF ( w_sp_trt_stat3 )
//* Date          : 20/11/2006
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Chargement des donn$$HEX1$$e900$$ENDHEX$$es
//* Commentaires  : Chargement des r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences commandes SPB se trouvant
//*					  sur C:\WINNT\TEMP\DEVIS.TXT
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//* #1	 CAG	 06/11/2002	  Modification SFR # Ajout du ctrl facturation CEGETEL
//* #2	 CAG	 30/01/2003	  Annexe 22 : Ajout du bouton maj cod_etat = "RPC"
//*-----------------------------------------------------------------

String	sModif

If Parent.wf_ChargerDonnees () Then 

	cb_Charger.Enabled = False
	cb_Annuler.Enabled = True
	cb_Controler.Enabled = True

	/*------------------------------------------------------------------*/
	/* #2                                                               */
	/*------------------------------------------------------------------*/
	cb_Maj.Enabled = False

	hpb_trt.Position = 0
	
End If

end event

type cb_annuler from commandbutton within w_sp_trt_imei_force_ok
integer x = 101
integer y = 484
integer width = 873
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annuler le chargement"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_extr1::cb_Annuler
//* Evenement     : cb_Annuler
//* Auteur        : PHG, d'apr$$HEX1$$e800$$ENDHEX$$s JFF ( w_sp_trt_stat3 )
//* Date          : 20/11/2006
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

Parent.TriggerEvent ("show")

end on

type st_charger from statictext within w_sp_trt_imei_force_ok
integer x = 1088
integer y = 1484
integer width = 2373
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "1 sinistre charg$$HEX1$$e900$$ENDHEX$$"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_extraire from statictext within w_sp_trt_imei_force_ok
integer x = 1088
integer y = 1580
integer width = 2373
integer height = 152
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_controler from commandbutton within w_sp_trt_imei_force_ok
integer x = 101
integer y = 580
integer width = 873
integer height = 172
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Contr$$HEX1$$f400$$ENDHEX$$ler les donn$$HEX1$$e900$$ENDHEX$$es charg$$HEX1$$e900$$ENDHEX$$es"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_autofact::cb_Controler
//* Evenement     : Clicked
//* Auteur        : PHG, d'apr$$HEX1$$e800$$ENDHEX$$s JFF ( w_sp_trt_stat3 )
//* Date          : 20/11/2006
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Controle des donn$$HEX1$$e900$$ENDHEX$$es
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

If Parent.wf_Controler () Then 

	cb_Charger.Enabled = False
	cb_Annuler.Enabled = True
	cb_Controler.Enabled = False
	cb_Maj.enabled = True

	hpb_trt.Position = 0

End If

end event

type cb_maj from commandbutton within w_sp_trt_imei_force_ok
integer x = 101
integer y = 752
integer width = 873
integer height = 172
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Forcer $$HEX2$$e0002000$$ENDHEX$$OK"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_trt_autofact::cb_Maj
//* Evenement     : Clicked
//* Auteur        : PHG
//* Date          : 21/11/2006
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Lancement du traitement
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

cb_Maj.Enabled = False
cb_Annuler.Enabled = False
pb_retour.enabled = False

SetPointer(HourGlass!)
If Parent.wf_Maj () Then 
	cb_Charger.Enabled = False
	cb_Controler.Enabled = False
End If
cb_Annuler.Enabled = True
pb_retour.Enabled = True

SetPointer(Arrow!)
end event

type dw_charger from datawindow within w_sp_trt_imei_force_ok
integer x = 1088
integer y = 312
integer width = 2368
integer height = 1064
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_trt_charge_extraction_imei"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type hpb_trt from hprogressbar within w_sp_trt_imei_force_ok
integer x = 1088
integer y = 1396
integer width = 2368
integer height = 64
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 10
end type

type ddlb_typ_fichier from dropdownlistbox within w_sp_trt_imei_force_ok
integer x = 2016
integer y = 180
integer width = 1015
integer height = 400
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Fichier Extraction En-cours","Fichier Rejet"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_trt_imei_force_ok::selectionchanged
//* Auteur			: Pierre-Henri Gillot
//* Date				: 02/02/2007 18:55:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value integer index	 */
//*
//* Retourne		: long	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

if isvalid(ids_charger) then 
	choose case index
	case 1
		ids_charger.dataobject = "d_trt_charge_extraction_imei"
		dw_charger.dataobject = "d_trt_charge_extraction_imei"
	case 2
		ids_charger.dataobject = "d_trt_charge_rejet_imei"
		dw_charger.dataobject = "d_trt_charge_rejet_imei"
	end choose
End If
end event

type st_typ_fichier from statictext within w_sp_trt_imei_force_ok
integer x = 1527
integer y = 196
integer width = 457
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Type de Fichier :"
boolean focusrectangle = false
end type

