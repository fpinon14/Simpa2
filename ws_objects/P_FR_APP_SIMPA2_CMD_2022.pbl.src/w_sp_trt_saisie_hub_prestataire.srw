$PBExportHeader$w_sp_trt_saisie_hub_prestataire.srw
$PBExportComments$[HP252_276_HUB_PRESTA]
forward
global type w_sp_trt_saisie_hub_prestataire from window
end type
type st_info from statictext within w_sp_trt_saisie_hub_prestataire
end type
type st_attente_hub from statictext within w_sp_trt_saisie_hub_prestataire
end type
type cb_abandonner from commandbutton within w_sp_trt_saisie_hub_prestataire
end type
type cb_valider from commandbutton within w_sp_trt_saisie_hub_prestataire
end type
type dw_1 from datawindow within w_sp_trt_saisie_hub_prestataire
end type
end forward

global type w_sp_trt_saisie_hub_prestataire from window
integer width = 3328
integer height = 1292
boolean titlebar = true
string title = "Connexion au HUB PRESTATAIRE"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean righttoleft = true
boolean center = true
event chargement_typ_dommage ( )
event chargement_consult_aller_s2_vers_hub ( )
event chargement_consult_retour_hub_vers_s2 ( )
st_info st_info
st_attente_hub st_attente_hub
cb_abandonner cb_abandonner
cb_valider cb_valider
dw_1 dw_1
end type
global w_sp_trt_saisie_hub_prestataire w_sp_trt_saisie_hub_prestataire

type variables
private:

String isRetour
String isTrtFen
String isChaineRetour

String isMarqAppSin
String isModlAppSin
String isTypAppSin
String isTypActionS2

String isAdrNom		
String isAdrPreNom	
String isAdrLivr1		
String isAdrLivr2		
String isAdrCplt		
String isAdrCp			
String isAdrVille		

String isNomAssure
String isPrenomAssure

String isAdrNomPickUp
String isAdrReferenceAssPickUp
String isAdr1PickUp
String isAdr2PickUp
String isAdrCpltPickUp
String isAdrCpPickUp
String isAdrVillePickUp
String isCodePickUp

String isAdrMailAss
String isIdHubPresta

String isIdAdh, isLibGrpContractant
String isPays
String isEtatAppSin

Decimal { 2 } idcMtValAchat
Decimal { 2 } idcMtPec

DateTime idtDteAchat

Int 	 iiIdGrpContractant

Long   ilIdprod
Long   ilIdGti
Long   ilAdrCodCiv	
Long   ilIdSin		
Long 	 ilIdSeq
Long   ilIdDepotS2


u_Transaction_Hub_Prestataire itrHubPrestataire

end variables

forward prototypes
public subroutine wf_deconnexion_hub_prestataire ()
public function boolean wf_connexion_hub_prestataire ()
public subroutine wf_recuperation_point_service ()
public function boolean wf_valider_process_acheminement ()
public function boolean wf_valider_point_service ()
public function boolean wf_valider_type_dommage_et_action ()
public subroutine wf_consultation_aller_s2_vers_hub ()
public function boolean wf_appel_relais_pickup ()
public subroutine wf_recuperation_process_acheminement ()
end prototypes

event chargement_typ_dommage();//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_hub_prestataire
//* Evenement 		: chargement_typ_dommage
//* Auteur			: JFF
//* Date				: 11/03/2024
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
//*-----------------------------------------------------------------

Long lTotRow
Int iCle

iCle = F_CLE_NUMERIQUE ( "HP252_276_HUB_PRESTA" )

This.Title = "Connexion au HUB PRESTATAIRE : Choix du type de dommage"

cb_valider.Hide ()
cb_abandonner.Hide ()

dw_1.DataObject = "d_trt_saisie_hub_type_dommage"
dw_1.SetTransObject ( itrHubPrestataire ) 
lTotRow = dw_1.Retrieve ( iCle, ilIdprod, ilIdGti, isMarqAppSin, isModlAppSin, isTypAppSin )

If lTotRow = 1 And Upper ( dw_1.GetItemString ( 1, "id_code_td_hp" )) = "AUCUN" Then 
	dw_1.SelectRow ( 1, TRUE )
	cb_valider.PostEvent ( Clicked!)	
	Return
End If 


cb_valider.Show ()
cb_abandonner.Show ()

st_attente_hub.Hide()
dw_1.Show ()
dw_1.BringToTop = TRUE
dw_1.SetFocus ()

If lTotRow <= 0 Then
	dw_1.Reset ()
	stMessage.sTitre		= "Erreur Hub Prestataire"	
	stMessage.sCode		= "HUBP010"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!

	stMessage.sVar[1]    = string ( ilIdprod )
	stMessage.sVar[2]    = string ( ilIdGti )
	stMessage.sVar[3]    = isMarqAppSin
	stMessage.sVar[4]    = isModlAppSin
	stMessage.sVar[5]    = isTypAppSin	
	
	F_message(stMessage)
	cb_Abandonner.PostEvent ( Clicked!)	
End IF 
	


end event

event chargement_consult_aller_s2_vers_hub();//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_hub_prestataire
//* Evenement 		: Chargement_consult_aller_s2_vers_hub
//* Auteur			: JFF
//* Date				: 11/03/2024
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
//*-----------------------------------------------------------------

Long lTotRow
Int iCle, iCpt, iTotRow 
String sVal1, sVal2

dw_1.DataObject = "d_cons_hub_donnees_simpa2"
dw_1.SetTransObject ( itrHubPrestataire ) 
iTotRow = dw_1.Retrieve ( ilIdSin, ilIdSeq, ilIdDepotS2 )

// Poupuliser Lib_four
sVal1 = dw_1.GetItemString ( 1, "Id_Four" ) 
sVal2 = SQLCA.FN_CODE_CAR (sVal1 , "-FR")
dw_1.SetITem ( 1, "Id_Four", sVal2 + " (" + sVal1 + ")" )


st_attente_hub.Hide()
dw_1.Show ()
dw_1.BringToTop = TRUE

dw_1.SetFocus ()


end event

event chargement_consult_retour_hub_vers_s2();//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_hub_prestataire
//* Evenement 		: Chargement_consult_retour_hub_vers_s2
//* Auteur			: JFF
//* Date				: 11/03/2024
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
//*-----------------------------------------------------------------

Long lTotRow
Int iCle, iCpt, iTotRow
String sVal1, sVal2, sActivityCode, sActivityReturnCode, sActivityReasonCode, sLibActivity

dw_1.DataObject = "d_cons_hub_donnees_hub"

dw_1.SetTransObject ( itrHubPrestataire ) 
iTotRow = dw_1.Retrieve ( isIdHubPresta )

dw_1.SetdetailHeight ( 1, iTotRow, 840 )


// Poupuliser Lib_activty

For iCpt = 1 to iTotRow
	sActivityCode =  dw_1.GetItemString ( iCpt, "ACTIVITY_CODE" ) 
	sActivityReturnCode = dw_1.GetItemString ( iCpt, "ACTIVITY_RETURN_CODE" ) 
	sActivityReasonCode = dw_1.GetItemString ( iCpt, "ACTIVITY_REASON_CODE" ) 
	sLibActivity = Space ( 255 )
	SQLCA.PS_HP276_S_S2_LIB_ACTIVITY_MAPPING ( sActivityCode, sActivityReturnCode, sActivityReasonCode, sLibActivity ) 
	
	dw_1.SetItem ( iCpt, "LIB_ACTIVITY", sLibActivity ) 
	
Next 

st_attente_hub.Hide()
dw_1.Show ()
dw_1.BringToTop = TRUE

dw_1.SetFocus ()


end event

public subroutine wf_deconnexion_hub_prestataire ();//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_hub_prestataire
//* Fonction 		: wf_deconnexion_hub_prestataire
//* Auteur			: JFF
//* Date				: 11/03/2024
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
//*-----------------------------------------------------------------

Disconnect using itrHubPrestataire ;

If IsValid ( itrHubPrestataire ) Then Destroy itrHubPrestataire

end subroutine

public function boolean wf_connexion_hub_prestataire ();//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_hub_prestataire
//* Fonction 		: wf_connexion_hub_prestataire
//* Auteur			: JFF
//* Date				: 11/03/2024
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
//*-----------------------------------------------------------------

itrHubPrestataire = Create u_Transaction_Hub_Prestataire 

If Not f_ConnectSqlServer_Hub_Prestataire ( stGLB.sFichierIni   , &
									 "HUB PRESTATAIRE BASE" , &
									 itrHubPrestataire    , &
									 stGLB.sMessageErreur, &
									 stGlb.slibcourtappli, &
									 stGlb.sCodOper          ) Then

	
	stMessage.sTitre  	= "Connexion Hub Presta impossible"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "HUBP006"
	stMessage.sVar[1]    = stGLB.sMessageErreur
	stMessage.bouton 		= Ok!
	F_message(stMessage)
	
	Return False
End If 

Return True
end function

public subroutine wf_recuperation_point_service ();//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_hub_prestataire
//* Fonction 		: wf_recuperation_point_service
//* Auteur			: JFF
//* Date				: 11/03/2024
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 		 JFF  27/11/2024  [20241127082353640]
//*-----------------------------------------------------------------


String sTypDom, sVal, sCodePays, sVal1 
n_cst_string lnvPFCString
Int iCoefH, iCoefV, iTotRow, iAjoutCoefV 
Int iCle, iIdGrpContractant, iCpt 

sCodePays = ""
If Len ( Trim ( isAdrCp) ) = 5 And Trim ( isAdrCp ) <> '00000' Then sCodePays = "FR"

iCle = F_CLE_NUMERIQUE ( "HP252_276_HUB_PRESTA" )

This.Title = "Connexion au HUB PRESTATAIRE : Choix du point de service"

isTrtFen = "POINTSERVICE"

st_attente_hub.Height = 690
st_attente_hub.Y = 200
st_attente_hub.text  = "~n~rEn attente de réponse du HUB PRESTATAIRE....~n~r"
st_attente_hub.text += "~n~r"
st_attente_hub.text += "Appel extérieur par API~n~r"
st_attente_hub.text += "Recherche des points de services disponibles~n~r"
st_attente_hub.text += "~n~r"
st_attente_hub.text += "Cela peut prendre quelques minutes...~n~r"
st_attente_hub.Show()
st_attente_hub.BringToTop = TRUE

cb_valider.Hide()
cb_abandonner.Hide()

dw_1.Hide ()

isIdAdh = Fill ( " ", 50)
isLibGrpContractant = Fill ( " ", 35)
SQLCA.PS_HP276_S_S2_DATA_DOSSIER  ( ilIdSin, isIdAdh, iiIdGrpContractant, isLibGrpContractant )

dw_1.DataObject = "d_trt_saisie_hub_point_de_service"
dw_1.SetTransObject ( itrHubPrestataire )

sTypDom = lnvPFCString.of_Getkeyvalue ( isChaineRetour, "HP_TYP_DOM", ";")


// [20241127082353640] ajout idcMtValAchat à isEtatAppSin
iTotRow = dw_1.Retrieve ( & 
	iCle, &
	ilIdprod, &
	ilIdGti, &
	isMarqAppSin, &
	isModlAppSin, &
	isTypAppSin, &
	sTypDom, &
	isTypActionS2, &
	isIdAdh, &
	ilIdSin, &
	iiIdGrpContractant, &
	isLibGrpContractant, &
	ilAdrCodCiv, &
	isAdrNom, &
	isAdrPreNom, &
	isAdrLivr1, &
	isAdrLivr2, &
	isAdrCplt, &
	isAdrCp, &
	isAdrVille, &
	sCodePays, &
	idcMtValAchat, &		
	idcMtPec, &		
	String ( idtDteAchat, "dd/mm/yyyy" ), &
	isEtatAppSin )	

If iTotRow = 1 And Upper ( dw_1.GetItemString ( 1, "idHubPresta" )) = "AUCUN" Then 
	iTotRow = 0
	dw_1.Reset ()
End If 

// Populiser Lib_four
For iCpt = 1 To iTotRow
	sVal = dw_1.GetItemString ( iCpt, "IdFour" ) 
	sVal1 = dw_1.GetItemString ( iCpt, "idpointserv" ) 

	If Trim ( sVal ) = "" Or IsNull ( sVal ) Then
		stMessage.sTitre		= "Erreur Hub Prestataire"
		stMessage.sCode		= "HUBP012"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!

		stMessage.sVar[1]    = sVal1
		
		dw_1.Show ()
		dw_1.BringToTop = TRUE
		dw_1.SetFocus ()
		
		F_message(stMessage)
		cb_Abandonner.PostEvent ( Clicked!)
	End IF 
	
	sVal1 = sVal
	sVal = SQLCA.FN_CODE_CAR (sVal , "-FR")
	
	If Trim ( sVal ) = "" Or IsNull ( sVal ) Then
		stMessage.sTitre		= "Erreur Hub Prestataire"
		stMessage.sCode		= "HUBP013"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!

		stMessage.sVar[1]    = sVal1
		
		dw_1.Show ()
		dw_1.BringToTop = TRUE
		dw_1.SetFocus ()
		
		F_message(stMessage)
		cb_Abandonner.PostEvent ( Clicked!)	
	End IF 

	
	dw_1.SetITem ( iCpt, "LibFour", sVal )
	
	/* Plus nécessaire, on garde le code du mode tel que donné par le Hub et on a à présent la variable de libellé donné par BLN
	sVal = dw_1.GetItemString ( iCpt, "idModeLogis" ) 
	Choose Case sVal 
		Case "CENTRALIZATION" 
			sVal = "Centralisation"
			dw_1.SetItem ( icpt, "StatutPointServ", "Accepté" ) // forcé dans ts les cas si CENTRAL, vu avec Boulenouar
		Case "PROXIMITY" 
			sVal = "Proximité"
	End Choose 
	dw_1.SetITem ( iCpt, "idModeLogis", sVal ) 
	*/  
		
	sVal = dw_1.GetItemString ( iCpt, "codePaysPointServ" ) 		
	Choose Case sVal 
		Case "FR" 
			sVal = "France"
	End Choose 
	dw_1.SetITem ( iCpt, "codePaysPointServ", sVal )			
	
	sVal = dw_1.GetItemString ( iCpt, "statutPointServ" ) 		
	Choose Case sVal 
		Case "ACCEPTED" 
			sVal = "Accepté"
		Case "REJECTED"
			sVal = "Rejeté"
		Case "UNAVAILABLE" 
			sVal = "Indisponible"
		case "UNVERIFIED" 
			sVal = "Non vérifié"
	End Choose 
	dw_1.SetITem ( iCpt, "statutPointServ", sVal )			

Next 

iCoefH = 500
iCoefV = 500
iAjoutCoefV = 500
iCoefV = iTotRow * iCoefV 
If iCoefV > 1800 Then iCoefV = 1800

This.X = This.X - iCoefH / 2
This.Y = This.Y - iCoefV / 2

This.Width = This.Width + iCoefH
dw_1.Width = dw_1.Width + iCoefH

If iTotRow >= 4 Then
	This.Height = This.Height + iCoefV + iAjoutCoefV
	dw_1.Height = dw_1.Height + iCoefV + iAjoutCoefV
	cb_abandonner.Y = cb_abandonner.Y  + iCoefV + iAjoutCoefV
	cb_Valider.Y = cb_Valider.Y + iCoefV + iAjoutCoefV	
	st_info.Y = st_info.Y + iCoefV + iAjoutCoefV	
Else 	
	This.Height = This.Height + iCoefV 
	dw_1.Height = dw_1.Height + iCoefV
	cb_abandonner.Y = cb_abandonner.Y  + iCoefV 
	cb_Valider.Y = cb_Valider.Y + iCoefV 	
	st_info.Y = st_info.Y + iCoefV 
End If 

cb_abandonner.X = cb_abandonner.X + iCoefH / 2
cb_Valider.X = cb_Valider.X + iCoefH / 2
st_info.X = st_info.X + iCoefH / 2

If iTotRow > 4 Then 
	st_info.Text = String ( iTotRow ) + " points de service disponibles, utilisez l'ascenseur ou la molette de la souris."
	st_info.Show()
End IF 

cb_valider.enabled = FALSE

st_attente_hub.Hide()
st_attente_hub.Height = 228
st_attente_hub.Y = 412
st_attente_hub.text = "~n~rEn attente de réponse du HUB PRESTATAIRE...."

cb_valider.Show ()
cb_abandonner.Show ()

If iTotRow <= 0 Then
	stMessage.sTitre		= "Pas de retour Hub Prestataire"
	stMessage.sCode		= "HUBP011"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!

	stMessage.sVar[1]    = string ( ilIdprod )
	stMessage.sVar[2]    = string ( ilIdGti )
	stMessage.sVar[3]    = isMarqAppSin
	stMessage.sVar[4]    = isModlAppSin
	stMessage.sVar[5]    = isTypAppSin	
	stMessage.sVar[6]    = sTypDom
	stMessage.sVar[7]    = isTypActionS2

	dw_1.Show ()
	dw_1.BringToTop = TRUE
	dw_1.SetFocus ()
	
	F_message(stMessage)
	cb_Abandonner.PostEvent ( Clicked!)	
End IF 

/* même pour un point de service, je veux que le GT le vois et le choissise, pas d'automatisation
If isTypActionS2 = "A_COMMANDER" And dw_1.RowCount() = 1 Then
	dw_1.SelectRow (1, True)
	cb_Valider.PostEvent ( Clicked! )
Else	
*/	
dw_1.Show ()
dw_1.BringToTop = TRUE
dw_1.SetFocus ()

end subroutine

public function boolean wf_valider_process_acheminement ();//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_hub_prestataire
//* Fonction 		: wf_valider_process_acheminement
//* Auteur			: JFF
//* Date				: 11/03/2024
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
//*-----------------------------------------------------------------

n_cst_string lnvPFCString
String sIdModeLogis, sRetAPI, sIdHubProcessAchem
st_point_relai_chronopost relai_chrono
Integer iTotRow, iCpt, iRowSelect
Boolean bDecision

bDecision = False

dw_1.AcceptText()

iRowSelect = Dw_1.GetSelectedRow ( 0 ) 

sIdHubProcessAchem = Dw_1.GetItemString ( iRowSelect, "id_process_achem_hp" ) 

If IsNull ( sIdHubProcessAchem ) Or Trim ( sIdHubProcessAchem ) = "" Then
	stMessage.sTitre		= "Pas de retour Hub Prestataire"
	stMessage.sCode		= "HUBP017"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!

	If IsNull ( sIdHubProcessAchem ) Then stMessage.sVar[1]    = "null"
	If Trim ( sIdHubProcessAchem ) = "" Then stMessage.sVar[1]    = "vide"	

	dw_1.Show ()
	dw_1.BringToTop = TRUE
	dw_1.SetFocus ()
	
	F_message(stMessage)
	cb_Abandonner.PostEvent ( Clicked!)	
	Return False
End IF 

If sIdHubProcessAchem = "AUCUN" Then
	lnvPFCString.of_Setkeyvalue ( isChaineRetour, "HP_INFO_SPB_FRN", "3520", ";")
	
	stMessage.sTitre		= "Pas de retour Hub Prestataire"
	stMessage.sCode		= "HUBP019"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!	
	
	F_message(stMessage)
	
Else 
	lnvPFCString.of_Setkeyvalue ( isChaineRetour, "HP_INFO_SPB_FRN", "3510", ";")  
End If 

lnvPFCString.of_Setkeyvalue ( isChaineRetour, "HP_ID_PROCESS_ACHEM", sIdHubProcessAchem , ";")	

// CAS du Relais Pick Up client/assuré
If sIdHubProcessAchem = "PICK_UP_POINT" Then

	Do While NOT bDecision
	
		bDecision = This.wf_appel_relais_pickup ()
		
		If NOT bDecision Then
			stMessage.sTitre		= "Abandon de la prestation ?"
			stMessage.sCode		= "HUBP018 "
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= YESNO!
			
			If F_message(stMessage) = 1 Then 
				bDecision = TRUE
				cb_Abandonner.PostEvent ( Clicked!)	
				Return False
			End If 

		End If 
		
	Loop 		
End IF 

Return True




/*
Choose case isTypActionS2 
	Case "A_REPARER", "A_DIAGNOSTIQUER"

		sIdModeLogis = Upper( lnvPFCString.of_Getkeyvalue ( isChaineRetour, "HP_ID_MODE_LOGIS", ";")) 
		
		If sIdModeLogis = "PROXIMITY" Then
			lnvPFCString.of_Setkeyvalue ( isChaineRetour, "HP_INFO_SPB_FRN", "3530", ";")
			Return True
		End If 
		
		If sIdModeLogis = "CENTRALIZATION" Then
			
			Do While NOT bDecision
			
				stMessage.sTitre		= "Choix mode logistique Centralisation" 
				stMessage.Icon			= Question!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= YESNO!
				stMessage.sCode		= "HUBP003"
				
				// Bureau de Poste
				If F_Message ( stMessage ) = 1 Then 
					lnvPFCString.of_Setkeyvalue ( isChaineRetour, "HP_INFO_SPB_FRN", "3510", ";")
					bDecision = True
					Return True
				End IF 
	
				bDecision = This.wf_appel_relais_pickup ()
			   
				If bDecision Then lnvPFCString.of_Setkeyvalue ( isChaineRetour, "HP_INFO_SPB_FRN", "3520", ";")
				
			Loop 		
		End If 

	Case "A_COMMANDER"

			Do While NOT bDecision
		
				stMessage.sTitre		= "Choix mode logistique Centralisation" 
				stMessage.Icon			= Question!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= YESNO!
				stMessage.sCode		= "HUBP009"
				
				// Bureau de Poste
				If F_Message ( stMessage ) = 1 Then 
					lnvPFCString.of_Setkeyvalue ( isChaineRetour, "HP_INFO_SPB_FRN", "3540", ";")
					bDecision = True
					Return True
				End IF 
	
				bDecision = This.wf_appel_relais_pickup ()
			
				If bDecision Then lnvPFCString.of_Setkeyvalue ( isChaineRetour, "HP_INFO_SPB_FRN", "3550", ";")
				
			Loop 		

End CHoose 
*/


end function

public function boolean wf_valider_point_service ();//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_hub_prestataire
//* Fonction 		: wf_valider_point_service
//* Auteur			: JFF
//* Date				: 11/03/2024
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
//*-----------------------------------------------------------------

String sIdFour, sIdPointService, sIdModeLogis, sIdHubPresta, sMesErr
Integer iTotRow, iCpt, iRowSelect, iRow
n_cst_string lnvPFCString
Boolean bRet

bRet = True
sMesErr = ""

dw_1.AcceptText()

iRowSelect = Dw_1.GetSelectedRow ( 0 ) 

If iRowSelect <= 0 Then Return False

sIdFour = Dw_1.GetItemString ( iRowSelect, "idFour" ) 
sIdPointService = Dw_1.GetItemString ( iRowSelect, "idPointServ" ) 
sIdModeLogis = Dw_1.GetItemString ( iRowSelect, "idModeLogis" ) 
sIdHubPresta = Dw_1.GetItemString ( iRowSelect, "idHubPresta" ) 

IF IsNull ( sIdFour ) Or sIdFour = "" Then
	bRet = False
	sMesErr += "- Le code fournisseur officiel SPB" + "~n~r"
End If 

IF IsNull ( sIdPointService ) Or sIdPointService = "" Then
	bRet = False
	sMesErr += "- Le code du point de service" + "~n~r"
End If 

IF IsNull ( sIdModeLogis ) Or sIdModeLogis = "" Then
	bRet = False
	sMesErr += "- Le mode logistic" + "~n~r" 
End If 

IF IsNull ( sIdHubPresta ) Or sIdHubPresta = "" Then
	bRet = False
	sMesErr += "- L'Identifiant (I.D.) de la prestation sur le Hub Prestataire" + "~n~r"
End If 


If Not bRet Then
	stMessage.sTitre  	= "Donnée non fournie par le HUB PRESTATAIRE"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "HUBP007"
	stMessage.sVar[1]    = sMesErr
	stMessage.bouton 		= Ok!
	F_message(stMessage)	
	Return False
End If 	


lnvPFCString.of_Setkeyvalue ( isChaineRetour, "HP_ID_HUB_PRESTA", sIdHubPresta , ";")
lnvPFCString.of_Setkeyvalue ( isChaineRetour, "HP_ID_FOUR", sIdFour, ";")
lnvPFCString.of_Setkeyvalue ( isChaineRetour, "HP_ID_POINT_SERV", sIdPointService, ";")
lnvPFCString.of_Setkeyvalue ( isChaineRetour, "HP_ID_MODE_LOGIS", sIdModeLogis, ";")

Return True
end function

public function boolean wf_valider_type_dommage_et_action ();//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_hub_prestataire
//* Fonction 		: wf_valider_type_dommage_et_action
//* Auteur			: JFF
//* Date				: 11/03/2024
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 		 JFF  27/11/2024  [20241127082353640]
//*-----------------------------------------------------------------


String sSelectionTypDom
Integer iTotRow, iCpt, iRowSelect, iRow
dataStore dsTypActionHub
n_cst_string lnvPFCString
Int iCle

iCle = F_CLE_NUMERIQUE ( "HP252_276_HUB_PRESTA" )

Choose Case isTypActionS2 
	Case "A_REPARER", "A_DIAGNOSTIQUER"
		sSelectionTypDom = "#"
		
		dw_1.AcceptText()
		iTotRow = dw_1.RowCount ()
		
		iCpt = 0
		
		Do While Dw_1.GetSelectedRow ( iCpt ) > 0 
			iRowSelect = Dw_1.GetSelectedRow ( iCpt )
			If iRowSelect > 0 Then
				sSelectionTypDom += Dw_1.GetItemString ( iRowSelect, "id_code_td_hp" ) + "#"
			End If 
			iCpt = iRowSelect 
		Loop

		If sSelectionTypDom = "#AUCUN#" Then sSelectionTypDom = ""

		stMessage.sCode		= "HUBP001"
		stMessage.sVar[1]    = string ( ilIdprod )
		stMessage.sVar[2]    = string ( ilIdGti )
		stMessage.sVar[3]    = isMarqAppSin
		stMessage.sVar[4]    = isModlAppSin
		stMessage.sVar[5]    = isTypAppSin	
		stMessage.sVar[6]    = sSelectionTypDom
		stMessage.sVar[7]    = isTypActionS2	

		// [20241127082353640]
		stMessage.sVar[8]    = isAdrCp
		stMessage.sVar[9]    = isPays
		stMessage.sVar[10]   = String ( idcMtValAchat, "#,##0.00 \"+stGlb.smonnaiesymboledesire )
		stMessage.sVar[11]   = String ( idcMtPec, "#,##0.00 \"+stGlb.smonnaiesymboledesire )
		stMessage.sVar[12]   = String ( idtDteAchat, "dd/mm/yyyy" )		
		stMessage.sVar[13]   = isEtatAppSin 			
		stMessage.sVar[14]   = isTypActionS2	


	Case Else
		sSelectionTypDom = ""
		stMessage.sCode		= "HUBP008"
		stMessage.sVar[1]    = string ( ilIdprod )
		stMessage.sVar[2]    = string ( ilIdGti )
		stMessage.sVar[3]    = isMarqAppSin
		stMessage.sVar[4]    = isModlAppSin
		stMessage.sVar[5]    = isTypAppSin	
		stMessage.sVar[6]    = isTypActionS2


		// [20241127082353640]		
		stMessage.sVar[7]    = isAdrCp
		stMessage.sVar[8]    = isPays
		stMessage.sVar[9]   = String ( idcMtValAchat, "#,##0.00 \"+stGlb.smonnaiesymboledesire )
		stMessage.sVar[10]   = String ( idcMtPec, "#,##0.00 \"+stGlb.smonnaiesymboledesire )
		stMessage.sVar[11]   = String ( idtDteAchat, "dd/mm/yyyy" )		
		stMessage.sVar[12]   = isEtatAppSin 			
		stMessage.sVar[13]    = isTypActionS2
	
End Choose 

// Détermination du type d'action et controle de cohérence
dsTypActionHub = Create dataStore
dsTypActionHub.DataObject = "d_trt_saisie_hub_type_action"
dsTypActionHub.SetTransObject ( itrHubPrestataire )

// [20241127082353640] ajout isAdrCp à isEtatAppSin
iRow = dsTypActionHub.Retrieve ( &
		iCle, &
		ilIdprod, &
		ilIdGti, &
		isMarqAppSin, &
		isModlAppSin, &
		isTypAppSin, &
		sSelectionTypDom, &
		isTypActionS2, &
		isAdrCp, &
		isPays, &
		idcMtValAchat, &
		idcMtPec, &				
		String ( idtDteAchat, "dd/mm/yyyy" ), &
		isEtatAppSin &
		)


Choose Case isTypActionS2
	Case "PEC_A_RECYCLER", "REFUSE_A_REEXP"
		iRow = 1
	
	Case Else
		iRow = dsTypActionHub.Find ( "id_code_action_hp = '" + isTypActionS2 + "'", 1, dsTypActionHub.RowCount() )
End CHoose 

Destroy dsTypActionHub


If iRow <= 0 Then
	st_attente_hub.Hide()
	stMessage.sTitre  	= "Incohérence type d'action HUB PRESTATAIRE"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.bouton 		= Ok!
	
	F_message(stMessage)
	cb_Abandonner.PostEvent ( Clicked!)
	Return False	
End If 


Choose Case isTypActionS2 
	Case "A_REPARER", "A_DIAGNOSTIQUER"
		lnvPFCString.of_Setkeyvalue ( isChaineRetour, "HP_TYP_DOM", sSelectionTypDom, ";")
End Choose 



Return True


end function

public subroutine wf_consultation_aller_s2_vers_hub ();//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_hub_prestataire
//* Fonction 		: wf_consultation_aller_s2_vers_hub
//* Auteur			: JFF
//* Date				: 11/03/2024
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
//*-----------------------------------------------------------------

Int iCoefH, iCoefV, iAjoutCoefV 

iCoefH = 2450
iCoefV = 2700

This.X = This.X - iCoefH / 2
This.Y = This.Y - iCoefV / 2

This.Width = This.Width + iCoefH
dw_1.Width = dw_1.Width + iCoefH

This.Height = This.Height + iCoefV 
dw_1.Height = dw_1.Height + iCoefV
cb_abandonner.Y = cb_abandonner.Y  + iCoefV 
cb_Valider.Y = cb_Valider.Y + iCoefV 	
st_info.Y = st_info.Y + iCoefV 

cb_abandonner.X = cb_abandonner.X + iCoefH / 2
cb_Valider.X = cb_Valider.X + iCoefH / 2
st_info.X = st_info.X + iCoefH / 2

cb_valider.Hide ()
cb_abandonner.Text = "Retour"
cb_abandonner.X = ( This.Width / 2 ) - ( cb_abandonner.Width / 2 )

st_attente_hub.Hide()
st_attente_hub.Height = 228
st_attente_hub.Y = 412
st_attente_hub.text = "~n~rEn attente de réponse du HUB PRESTATAIRE...."
dw_1.Show ()
dw_1.BringToTop = TRUE
dw_1.SetFocus ()

end subroutine

public function boolean wf_appel_relais_pickup ();//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_hub_prestataire
//* Fonction 		: wf_appel_relais_pickup
//* Auteur			: JFF
//* Date				: 11/03/2024
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
//*-----------------------------------------------------------------


n_cst_string lnvPFCString
String sIdModeLogis, sRetAPI
st_point_relai_chronopost relai_chrono

			
// Relais PickUp
isAdrNomPickUp   = ""
isAdrReferenceAssPickUp = ""
isAdr1PickUp     = ""
isAdr2PickUp     = ""
isAdrCpltPickUp  = ""
isAdrCpPickUp    = ""
isAdrVillePickUp = ""
isCodePickUp 	  = ""


If isAdrMailAss = "" Then
	stMessage.sTitre		= "Commandes"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sCode		= "HUBP004"	
	
	f_Message ( stMessage ) 		
End IF 

relai_chrono.nomassure		=	isAdrNom
relai_chrono.prenomassure	=	isAdrPreNom
relai_chrono.adresse1		=	isAdrLivr1
relai_chrono.adresse2		=	isAdrLivr2
relai_chrono.adresse3		=	isAdrCplt
relai_chrono.codepostal		=	isAdrCp
relai_chrono.ville			=	isAdrVille


OpenWithParm(w_sp_trt_saisie_relai_pickup, relai_chrono)
	
relai_chrono=Message.Powerobjectparm

sRetAPI = relai_chrono.returncode

If sRetAPI = "[RETOUR]" Then
	
	stMessage.sTitre		= "Commandes"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sCode		= "COMD937"	
	
	f_Message ( stMessage ) 

	Return False
End If

isAdrNomPickUp   = relai_chrono.pointrelais.nom
isAdrReferenceAssPickUp = String ( ilIdSin ) + " " + isNomAssure + " " + isPrenomAssure // A laisser
isAdr1PickUp     = relai_chrono.pointrelais.adresse1
isAdr2PickUp     = relai_chrono.pointrelais.adresse2
isAdrCpltPickUp  = relai_chrono.pointrelais.adresse3
isAdrCpPickUp    = relai_chrono.pointrelais.codepostal
isAdrVillePickUp = relai_chrono.pointrelais.localite

// Le code 
isCodePickUp     = relai_chrono.pointrelais.identifiant	

lnvPFCString.of_Setkeyvalue ( isChaineRetour, "CODE_PICK_UP", isCodePickUp, ";")
lnvPFCString.of_Setkeyvalue ( isChaineRetour, "NOM_PICK_UP", isAdrNomPickUp, ";")	
lnvPFCString.of_Setkeyvalue ( isChaineRetour, "REFASS_PICK_UP", isAdrReferenceAssPickUp, ";")		
lnvPFCString.of_Setkeyvalue ( isChaineRetour, "ADR1_PICK_UP", isAdr1PickUp, ";")		
lnvPFCString.of_Setkeyvalue ( isChaineRetour, "ADR2_PICK_UP", isAdr2PickUp, ";")			
lnvPFCString.of_Setkeyvalue ( isChaineRetour, "ADR3_PICK_UP", isAdrCpltPickUp, ";")		
lnvPFCString.of_Setkeyvalue ( isChaineRetour, "ADRCP_PICK_UP", isAdrCpPickUp, ";")		
lnvPFCString.of_Setkeyvalue ( isChaineRetour, "ADRVILLE_PICK_UP", isAdrVillePickUp, ";")	
			
Return True
end function

public subroutine wf_recuperation_process_acheminement ();//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_hub_prestataire
//* Fonction 		: wf_recuperation_Process_Acheminement
//* Auteur			: JFF
//* Date				: 11/03/2024
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 		 JFF  27/11/2024  [20241127082353640]
//*-----------------------------------------------------------------

String sTypDom, sVal, sCodePays, sVal1
String sIdFour, sIdPointService, sIdModeLogis 
n_cst_string lnvPFCString
Int iCoefH, iCoefV, iTotRow, iAjoutCoefV 
Int iCle, iCpt 

sCodePays = ""
If Len ( Trim ( isAdrCp) ) = 5 And Trim ( isAdrCp ) <> '00000' Then sCodePays = "FR"

iCle = F_CLE_NUMERIQUE ( "HP252_276_HUB_PRESTA" )

This.Title = "Connexion au HUB PRESTATAIRE : Choix du process d'acheminement"

isTrtFen = "PROCESS_ACHEMINEMENT"

st_attente_hub.Height = 690
st_attente_hub.Y = 200
st_attente_hub.text  = "~n~rEn attente de réponse du HUB PRESTATAIRE....~n~r"
st_attente_hub.text += "~n~r"
st_attente_hub.text += "Appel extérieur par API~n~r"
st_attente_hub.text += "Recherche des process d~'acheminement disponibles~n~r"
st_attente_hub.text += "~n~r"
st_attente_hub.text += "Cela peut prendre quelques minutes...~n~r"
st_attente_hub.Show()
st_attente_hub.BringToTop = TRUE

This.Height = 1350
This.Width  = 3560
dw_1.X = 23
dw_1.Y = 16
dw_1.Height = 980
dw_1.Width  = This.Width - 120
cb_abandonner.X = 1247
cb_abandonner.Y = 1032
cb_Valider.X = 1737
cb_Valider.Y = 1032

cb_valider.Hide()
cb_abandonner.Hide()
st_info.Hide ()
dw_1.Hide ()

/*
isIdAdh = Fill ( "", 50)
isLibGrpContractant = Fill ( "", 35)
SQLCA.PS_HP276_S_S2_DATA_DOSSIER  ( ilIdSin, isIdAdh, iiIdGrpContractant, isLibGrpContractant )
*/

dw_1.DataObject = "d_trt_saisie_hub_process_acheminement"
dw_1.SetTransObject ( itrHubPrestataire )



sTypDom = lnvPFCString.of_Getkeyvalue ( isChaineRetour, "HP_TYP_DOM", ";")
sIdFour = F_CLE_VAL ( "HP_ID_FOUR", isChaineRetour, ";")
sIdPointService = F_CLE_VAL ( "HP_ID_POINT_SERV", isChaineRetour, ";")
sIdModeLogis = F_CLE_VAL ( "HP_ID_MODE_LOGIS", sIdModeLogis, ";")

// [20241127082353640] ajout idcMtValAchat à isEtatAppSin
iTotRow = dw_1.Retrieve ( & 
	iCle, &
	ilIdprod, &
	ilIdGti, &
	isMarqAppSin, &
	isModlAppSin, &
	isTypAppSin, &
	sTypDom, &
	isTypActionS2, &
	isIdAdh, &
	ilIdSin, &
	iiIdGrpContractant, &
	isLibGrpContractant, &
	ilAdrCodCiv, &
	isAdrNom, &
	isAdrPreNom, &
	isAdrLivr1, &
	isAdrLivr2, &
	isAdrCplt, &
	isAdrCp, &
	isAdrVille, &
	sCodePays, &
	sIdFour, &
	sIdPointService, &
	sIdModeLogis, &
	idcMtValAchat, &		
	idcMtPec, &		
	String ( idtDteAchat, "dd/mm/yyyy" ), &
	isEtatAppSin )		

If iTotRow <= 0 Then
	stMessage.sTitre		= "Erreur Hub Prestataire"
	stMessage.sCode		= "HUBP016"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	
	dw_1.Show ()
	dw_1.BringToTop = TRUE
	dw_1.SetFocus ()
	
	F_message(stMessage)
	cb_Abandonner.PostEvent ( Clicked!)		
End If 

dw_1.Sort ()

sVal1 = Upper ( dw_1.GetItemString ( 1, "id_process_achem_hp" ))

If iTotRow = 1 And sVal1 = "AUCUN" Then 
	st_attente_hub.Hide()
	dw_1.SelectRow (1, True)
	cb_Valider.PostEvent ( Clicked! )
	Return
End If 




/*
iCoefH = 500
iCoefV = 500
iAjoutCoefV = 500
iCoefV = iTotRow * iCoefV 
If iCoefV > 1800 Then iCoefV = 1800

This.X = This.X - iCoefH / 2
This.Y = This.Y - iCoefV / 2

This.Width = This.Width + iCoefH
dw_1.Width = dw_1.Width + iCoefH

If iTotRow >= 4 Then
	This.Height = This.Height + iCoefV + iAjoutCoefV
	dw_1.Height = dw_1.Height + iCoefV + iAjoutCoefV
	cb_abandonner.Y = cb_abandonner.Y  + iCoefV + iAjoutCoefV
	cb_Valider.Y = cb_Valider.Y + iCoefV + iAjoutCoefV	
	st_info.Y = st_info.Y + iCoefV + iAjoutCoefV	
Else 	
	This.Height = This.Height + iCoefV 
	dw_1.Height = dw_1.Height + iCoefV
	cb_abandonner.Y = cb_abandonner.Y  + iCoefV 
	cb_Valider.Y = cb_Valider.Y + iCoefV 	
	st_info.Y = st_info.Y + iCoefV 
End If 

cb_abandonner.X = cb_abandonner.X + iCoefH / 2
cb_Valider.X = cb_Valider.X + iCoefH / 2
st_info.X = st_info.X + iCoefH / 2
*/

cb_valider.enabled = FALSE

st_attente_hub.Hide()
st_attente_hub.Height = 228
st_attente_hub.Y = 412
st_attente_hub.text = "~n~rEn attente de réponse du HUB PRESTATAIRE...."

dw_1.Show ()
cb_valider.Show ()
cb_abandonner.Show ()


end subroutine

on w_sp_trt_saisie_hub_prestataire.create
this.st_info=create st_info
this.st_attente_hub=create st_attente_hub
this.cb_abandonner=create cb_abandonner
this.cb_valider=create cb_valider
this.dw_1=create dw_1
this.Control[]={this.st_info,&
this.st_attente_hub,&
this.cb_abandonner,&
this.cb_valider,&
this.dw_1}
end on

on w_sp_trt_saisie_hub_prestataire.destroy
destroy(this.st_info)
destroy(this.st_attente_hub)
destroy(this.cb_abandonner)
destroy(this.cb_valider)
destroy(this.dw_1)
end on

event open;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_hub_prestataire
//* Evenement 		: open
//* Auteur			: JFF
//* Date				: 11/03/2024
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 		 JFF  27/11/2024  [20241127082353640]
//*-----------------------------------------------------------------

s_pass stPass

stPass=Message.PowerObjectParm

isRetour = "[RETOUR]"

Choose Case stPass.sTab[50] 
	Case "CREATION_PRESTATION" 
		isTrtFen = "TYPDOM"
		
	Case "CONSULTATION_PRESTATION_ALLER" 
		isTrtFen = "CONS_ALLER"
		ilIdSin			= stPass.lTab[1]
		ilIdSeq			= stPass.lTab[2]
		ilIdDepotS2		= stPass.lTab[3]		
		
		This.wf_consultation_aller_s2_vers_hub ()

	Case "CONSULTATION_PRESTATION_RETOUR" 
		isTrtFen = "CONS_RETOUR"
		isIdHubPresta  = stPass.sTab[1]

		// action idem.
		This.wf_consultation_aller_s2_vers_hub ()

		
End Choose 

Choose Case isTrtFen 
	Case "TYPDOM" 
	
		ilIdprod			= stPass.lTab[1]
		ilIdGti			= stPass.lTab[2]
		ilIdSin			= stPass.lTab[3]
		ilAdrCodCiv		= stPass.lTab[4]
		
		
		isMarqAppSin 	= stPass.sTab[1]
		isModlAppSin 	= stPass.sTab[2]
		isTypAppSin 	= stPass.sTab[3]
		isTypActionS2  = stPass.sTab[4]
		isAdrNom			= stPass.sTab[5]
		isAdrPreNom		= stPass.sTab[6]
		isAdrLivr1		= stPass.sTab[7]
		isAdrLivr2		= stPass.sTab[8]
		isAdrCplt		= stPass.sTab[9]
		isAdrCp			= stPass.sTab[10]
		isAdrVille		= stPass.sTab[11]
		
		isNomAssure    = stPass.sTab[12]
		isPrenomAssure = stPass.sTab[13]
		
		isAdrMailAss   = stPass.sTab[14]

		isPays			= stPass.sTab[15] // [20241127082353640]
		isEtatAppSin	= stPass.sTab[16] // [20241127082353640]
		
		idcMtValAchat	= stPass.dcTab[1] // [20241127082353640]
		idcMtPec			= stPass.dcTab[2] // [20241127082353640]		

		idtDteAchat    = stPass.dtTab[1] // [20241127082353640]		


		If isTypActionS2 = "A_COMMANDER" Then
			cb_valider.PostEvent ( clicked! )
		Else
			PostEvent ( "Chargement_typ_dommage" )
		End If 

	Case "CONS_ALLER"
		
		PostEvent ( "Chargement_consult_aller_s2_vers_hub" )

	Case "CONS_RETOUR"
		
		PostEvent ( "Chargement_consult_retour_hub_vers_s2" )
		
End Choose 


st_attente_hub.text = "~n~rEn attente de réponse du HUB PRESTATAIRE...."
st_attente_hub.Show()
st_attente_hub.BringToTop = TRUE

dw_1.Hide ()
st_info.Hide()
cb_valider.enabled = False
/*
cb_valider.BringToTop = TRUE
cb_abandonner.BringToTop = TRUE
*/

this.wf_connexion_hub_prestataire ()









end event

event close;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_hub_prestataire
//* Evenement 		: close
//* Auteur			: JFF
//* Date				: 11/03/2024
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
//*-----------------------------------------------------------------

this.wf_deconnexion_hub_prestataire ()

CloseWithReturn(This, isRetour)


end event

type st_info from statictext within w_sp_trt_saisie_hub_prestataire
integer x = 2162
integer y = 1024
integer width = 1115
integer height = 140
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388736
long backcolor = 67108864
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type st_attente_hub from statictext within w_sp_trt_saisie_hub_prestataire
integer x = 553
integer y = 412
integer width = 2190
integer height = 228
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 15780518
boolean enabled = false
string text = "En attente de réponse du HUB PRESTATAIRE...."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_abandonner from commandbutton within w_sp_trt_saisie_hub_prestataire
integer x = 1147
integer y = 1032
integer width = 457
integer height = 128
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Abandonner"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_hub_prestataire::cb_abandonner
//* Evenement 		: clicked
//* Auteur			: JFF
//* Date				: 11/03/2024
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
//*-----------------------------------------------------------------



Close(Parent)
end event

type cb_valider from commandbutton within w_sp_trt_saisie_hub_prestataire
integer x = 1637
integer y = 1032
integer width = 457
integer height = 128
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Valider"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_hub_prestataire::cb_valider
//* Evenement 		: clicked
//* Auteur			: JFF
//* Date				: 11/03/2024
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
//*-----------------------------------------------------------------

Boolean bRet

Choose Case isTrtFen
	Case "TYPDOM"
		bRet = Parent.wf_Valider_Type_Dommage_Et_Action()
		
		If bRet then
			Parent.wf_Recuperation_Point_Service ()
		End If 
		
	Case "POINTSERVICE"
		bRet = Parent.wf_Valider_Point_Service ()
		
		If bRet then
			Parent.wf_Recuperation_Process_Acheminement ()
		End If 
		
	Case "PROCESS_ACHEMINEMENT"
		
		bRet = Parent.wf_Valider_Process_Acheminement ()
		
		If bRet Then
			// messagebox ("", isChaineRetour )
			isRetour = isChaineRetour	
			Close(Parent)			
		End If 
		
End Choose 		


end event

type dw_1 from datawindow within w_sp_trt_saisie_hub_prestataire
integer x = 23
integer y = 16
integer width = 3264
integer height = 980
integer taborder = 10
string title = "none"
string dataobject = "d_trt_saisie_hub_type_dommage"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_hub_prestataire::dw_1
//* Evenement 		: clicked
//* Auteur			: JFF
//* Date				: 11/03/2024
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
//*-----------------------------------------------------------------

Int iRowSelected
String sVal 

If isTrtFen = "CONS_ALLER"	Then Return	
If isTrtFen = "CONS_RETOUR"	Then Return	
		
If isTrtFen = "POINTSERVICE" Then 
	sVal = This.GetItemString ( row, "StatutPointServ" )
	
	If sVal <> "Accepté" Then Return
	
	If row > 0 Then This.SelectRow ( 0, False)

End If 


If isTrtFen = "PROCESS_ACHEMINEMENT" Then 
	If row > 0 Then This.SelectRow ( 0, False)
End If 


If row > 0 Then 
	
	iRowSelected = This.GetSelectedRow ( row - 1 ) 
	
	If iRowSelected = row Then
		This.SelectRow ( row, False )
	Else 
		This.SelectRow ( row, True )
		This.SetRow ( row )
	End If 
	
	cb_valider.enabled = This.GetSelectedRow ( 0 ) > 0 
	
	
End IF 




end event

event buttonclicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_sp_trt_saisie_hub_prestataire::dw_1::buttonclicked
//* Evenement 		: clicked
//* Auteur			: JFF
//* Date				: 11/03/2024
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
//*-----------------------------------------------------------------

String sVal 

Choose Case  dwo.name

	// [DT424]
	Case "b_detail_presta"
		
		sVal = This.GetItemString ( Row, "alt_b_detail_presta" ) 
		
		If sVal = "N" Then
			dw_1.SetdetailHeight ( Row, Row, 2576 )
			dw_1.SetItem ( Row, "alt_b_detail_presta", "O" )
		Else 
			dw_1.SetdetailHeight ( Row, Row, 840 )
			dw_1.SetItem ( Row, "alt_b_detail_presta", "N" )			
		End If 

		dw_1.SetRow (Row)
		dw_1.ScrollToRow ( Row )
		dw_1.SetFocus ()
		
		
End Choose 
end event

