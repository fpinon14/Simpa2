$PBExportHeader$n_cst_gs_appel_api_generique.sru
forward
global type n_cst_gs_appel_api_generique from nonvisualobject
end type
end forward

global type n_cst_gs_appel_api_generique from nonvisualobject
end type
global n_cst_gs_appel_api_generique n_cst_gs_appel_api_generique

forward prototypes
public function boolean uf_api_orange_reunion_caller (ref u_gs_sp_sinistre aiuogssinistre, ref statictext astattentediverse, ref u_datawindow adw_wdivsin, long alidsin, string asimei, date addtesurv, string asidadh)
public subroutine uf_api_maxi_coffee_maj_presta (string ascas, ref u_datawindow adw_wsin, long alsinistreid, integer aiidseq, integer aistatusapi, string asinfospbfrncplt, string asinfofrnspbcplt)
public function boolean uf_api_maxi_coffee_caller (ref u_datawindow adw_wsin, ref u_datawindow_detail adw_lstwcommande, integer aiidseq, ref statictext astattentediverse, string asemail, long alamoutcts, long alorderid, string asmodel, long alwarrantyid, long alsinistreid)
end prototypes

public function boolean uf_api_orange_reunion_caller (ref u_gs_sp_sinistre aiuogssinistre, ref statictext astattentediverse, ref u_datawindow adw_wdivsin, long alidsin, string asimei, date addtesurv, string asidadh);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::uf_api_orange_reunion_caller 
//* Auteur			: FABRY JF
//* Date				: 19/11/2024
//* Libellé			: APPEL API Orange Réunion 
//* Commentaires	: [KSV649_ORREUCARA]
//*
//*-----------------------------------------------------------------

String sDteSurv, sUrl, sCleAuthent, sResponseApi, sJson, sStatusApi, sRequest
Int iRetApi, iStatusApi, iTour
HTTPClient ObjApi
JsonParser ObjJsonParser
Long lRootObject, lRow 
Boolean bTransitActive, bModeHorsAppel, bFin 


bModeHorsAppel = False
//bModeHorsAppel = True
iTour = 0

sDteSurv = String ( addtesurv, "dd-mm-yyyy" )
asIdAdh = Right ( Fill ( "0", 12 ) + asIdAdh, 12 )


sUrl = Trim ( ProfileString (stglb.sfichierini ,"API_ORANGE_REUNION","URL_API","*"))

/*
Pour la simulation : 
User : spb
PassWord : 2qGcN_tTIoi87A
Crypté par PostMan en Format 64 : c3BiOjJxR2NOX3RUSW9pODdB

Pour la production : 
User : spb
PassWord : 572jb5T8aASuCh
Crypté par PostMan en Format 64 : c3BiOjU3MmpiNVQ4YUFTdUNo


*/
sCleAuthent = Trim ( ProfileString (stglb.sfichierini,"API_ORANGE_REUNION","AUTHKEY","*"))

If sUrl = "*" Or sCleAuthent ="*" Then
	stMessage.sTitre		= "URL API ORANGE REUNION"
	stMessage.Icon			= StopSign!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sVar [1]   = "API_ORANGE_REUNION"
	stMessage.sCode		= "API0001"
	F_Message ( stMessage ) 	
	Return False
End If 	

// ajout des argument sur l'URL 
sUrl += "imei=" + asImei + "&dateSinistre=" + sDteSurv + "&subscriptionId=" + asIdAdh

// Complèment sur la méthode d'autorisation donné par PostMan
sCleAuthent = "Basic " + sCleAuthent 

ObjApi = Create HTTPClient 

ObjApi.SetRequestHeader ( "Authorization", sCleAuthent )

lRow = adw_wdivsin.Find("upper(nom_zone)='CRA_DAT_GEN'", 1 , adw_wdivsin.Rowcount())
If lRow > 0 Then 
	aiuoGsSinistre.uf_gestong_divers_majzone( "CRA_DAT_GEN", lRow, 2, DateTime ( Today(), now()))
End If 

lRow = adw_wdivsin.Find("upper(nom_zone)='CRA_SUIVI_IMEI'", 1 , adw_wdivsin.Rowcount())
If lRow > 0 Then 
	aiuoGsSinistre.uf_gestong_divers_majzone( "CRA_SUIVI_IMEI", lRow, 2, 10 )
End If 


// On fait 3 essais
For iTour = 1 To 3 

	lRow = adw_wdivsin.Find("upper(nom_zone)='CRA_CPT_DMDE'", 1 , adw_wdivsin.Rowcount())
	If lRow > 0 Then 
		aiuoGsSinistre.uf_gestong_divers_majzone( "CRA_CPT_DMDE", lRow, 2, iTour )
	End If 

	astAttenteDiverse.text = " ~n~rAppel de l'API Orange Réunion (extérieure à l'entreprise)~n~r~n~rVeuillez patienter...."
	astAttenteDiverse.X			=  941
	astAttenteDiverse.Y			=  390
	astAttenteDiverse.Height	=  300
	astAttenteDiverse.Width		= 1585
	astAttenteDiverse.BringToTop = True
	astAttenteDiverse.Show()

	If Not bModeHorsAppel Then
		iRetApi = ObjApi.SendRequest( "GET", sUrl )
		iStatusApi = ObjApi.GetResponseStatusCode( ) 
		sStatusApi = ObjApi.GetResponseStatusText()
		ObjApi.GetResponseBody ( sResponseApi )
	Else 
		iStatusApi =200
		sResponseApi = '{ "imei": "123456789123456", "dateSinistre": "01-01-2024", "subscriptionId": "subscription123", "usage": true }'
	End If 

	astAttenteDiverse.Hide ()

	If iStatusApi = 200 Then Exit
	
	// MessageBox  ( "Retour", sResponseApi + ", Statut " + String ( iStatusApi ) + ", Retour " + String ( iRetApi ) )

	If iStatusApi >= 300 Or iStatusApi < 0 Or iRetApi < 0 Then
		If iTour = 1 Then
			sRequest = "Pas de requête de Json pour le GET, tout est dans l''URL"
			f_trace_web_service("API ORANGE REUNION", "GET-" + sUrl, Dec(alIdSin) , 0, "", sRequest )
			f_trace_web_service("API ORANGE REUNION - reponse", "GET-" + sUrl, Dec(alIdSin) , iStatusApi, sStatusApi, sResponseApi )			
		End If
		
		CHoose Case iTour
			Case 1,2
				stMessage.sTitre		= "URL API ORANGE REUNION"
				stMessage.Icon			= Exclamation!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= YesNo!
				If iTour = 1 Then stMessage.sVar[1]   = "2ème"
				If iTour = 2 Then stMessage.sVar[1]   = "3ème et dernière"
				stMessage.sCode		= "API0003"

				If F_Message ( stMessage ) = 1 Then
					Continue // Tour suivant
				Else
				
					bFin = False
					Do While Not bFin
						stMessage.sTitre		= "URL API ORANGE REUNION"
						stMessage.Icon			= Information!
						stMessage.bErreurG	= FALSE
						stMessage.Bouton		= YesNo!
						stMessage.sCode		= "API0004"
						stMessage.sVar[1]		= "30"
						If F_Message ( stMessage ) = 1 Then bFin = TRUE
					Loop
			
					lRow = adw_wdivsin.Find("upper(nom_zone)='CRA_SUIVI_IMEI'", 1 , adw_wdivsin.Rowcount())
					If lRow > 0 Then 
						aiuoGsSinistre.uf_gestong_divers_majzone( "CRA_SUIVI_IMEI", lRow, 2, 20 )
						adw_wdivsin.SetItem ( lRow, "ALT_PROT", "N" )
					End If
			
					Exit
				End IF 

			Case 3 
				bFin = False
				Do While Not bFin
					stMessage.sTitre		= "URL API ORANGE REUNION"
					stMessage.Icon			= Information!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= YesNo!
					stMessage.sCode = "API0005"
					stMessage.sVar[1]		= "30"
					If F_Message ( stMessage ) = 1 Then bFin = TRUE
				Loop
	
				lRow = adw_wdivsin.Find("upper(nom_zone)='CRA_SUIVI_IMEI'", 1 , adw_wdivsin.Rowcount())
				If lRow > 0 Then 
					aiuoGsSinistre.uf_gestong_divers_majzone( "CRA_SUIVI_IMEI", lRow, 2, 20 )
					adw_wdivsin.SetItem ( lRow, "ALT_PROT", "N" )
				End If
			
		End Choose

	
	End If 	
Next 

If iStatusApi = 200 Then
	ObjJsonParser = Create JsonParser
	sJson = sResponseApi
	ObjJsonParser.LoadString(sJson)
	lRootObject = ObjJsonParser.GetRootItem()
	bTransitActive = ObjJsonParser.GetItemBoolean(lRootObject, "usage")
	
	If IsNull ( bTransitActive ) Then
		
		bFin = False
		Do While Not bFin
			stMessage.sTitre		= "URL API ORANGE REUNION"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= YesNo!
			stMessage.sVar[1]		= "30"
			stMessage.sCode = "API0006"
			If F_Message ( stMessage ) = 1 Then bFin = TRUE
		Loop

		lRow = adw_wdivsin.Find("upper(nom_zone)='CRA_SUIVI_IMEI'", 1 , adw_wdivsin.Rowcount())
		If lRow > 0 Then 
			aiuoGsSinistre.uf_gestong_divers_majzone( "CRA_SUIVI_IMEI", lRow, 2, 20 )
			adw_wdivsin.SetItem ( lRow, "ALT_PROT", "N" )			
		End If
			
	End If 
	
	// Succès total
	If Not IsNull ( bTransitActive ) Then
		stMessage.sTitre		= "URL API ORANGE REUNION"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode = "API0007"
		F_Message ( stMessage )
		
		lRow = adw_wdivsin.Find("upper(nom_zone)='CRA_SUIVI_IMEI'", 1 , adw_wdivsin.Rowcount())
		If lRow > 0 Then 
			If bTransitActive Then
				aiuoGsSinistre.uf_gestong_divers_majzone( "CRA_SUIVI_IMEI", lRow, 2, 2 )
			Else
				aiuoGsSinistre.uf_gestong_divers_majzone( "CRA_SUIVI_IMEI", lRow, 2, 100 )				
			End IF 
		End If		
		
	End If 
	
End IF 

//Messagebox ( "Usage", String ( bTransitActive )  )


If IsValid ( ObjApi ) Then Destroy ObjApi 
If IsValid ( ObjJsonParser ) Then Destroy ObjJsonParser 





end function

public subroutine uf_api_maxi_coffee_maj_presta (string ascas, ref u_datawindow adw_wsin, long alsinistreid, integer aiidseq, integer aistatusapi, string asinfospbfrncplt, string asinfofrnspbcplt);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::uf_api_maxi_coffee_maj_presta 
//* Auteur			: FABRY JF
//* Date				: 24/02/2025
//* Libellé			: APPEL API MAXI COFFEE
//* Commentaires	: [PMO268_MIG48]
//*
//*-----------------------------------------------------------------

String sSql, sMessContact, sVal
Boolean bRet 

Choose Case asCas
	Case "PRESTA"

		sSql = "Exec sysadm.PS_U_MAJ_PRESTA_API_MAXI_COFFEE " + &
					String ( alsinistreid ) + "., " + & 
					String ( aiidseq ) + ", " + &
					String ( aiStatusApi ) + ", " + &
					"'" + asInfoSpbFrnCplt + "', " + &
					"'" + asInfoFrnSpbCplt + "'," + &
					"'" + stGlb.sCodOper + "'"
		
		F_Execute ( sSql, SQLCA )
		bRet = SQLCA.SqlCode = 0 And SQLCA.SqlDBCode = 0
		F_Commit ( SQLCA, bRet )

	Case "TRAVAIL"

		sMessContact  = "/!\ ATTENTION, l'appel automatique de l'API MAXI COFFEE après la validation du dossier, a échoué le " + F_CLE_VAL ( "DTE_APPEL", asInfoSpbFrnCplt, ";") + ", l'assuré n'a donc pas le BA."
		sMessContact += "Le système a donc recréé un travail (workflow) en phase de validation afin que vous validiez de nouveau ce dossier pour appeler l'API MAXI COFFEE et générer le BA."
		
		If aiStatusApi = 1000 Then
			sMessContact  = "/!\ ATTENTION, l'appel automatique de l'API MAXI COFFEE après la validation du dossier, n'a même pas pu se faire car l'URL/AUTH de l'API est absente du paramétrage, prévenez le service informatique, l'assuré n'a donc pas le BA."
			sMessContact += " Le système a donc recréé un travail (workflow) en phase de validation afin que vous validiez de nouveau ce dossier pour appeler l'API MAXI COFFEE et générer le BA."
		End If 
	
		gsSeriaTransfert = "" 
		F_CLE_VAL_E ( "ID_SIN", String ( alsinistreid ), gsSeriaTransfert, ";" )
		F_CLE_VAL_E ( "ETAT", String ( 5 ), gsSeriaTransfert, ";" )	
		F_CLE_VAL_E ( "OPER", stGlb.sCodOper, gsSeriaTransfert, ";" )		
		F_CLE_VAL_E ( "MESS", sMessContact, gsSeriaTransfert, ";" )		
		
		adw_WSin.PostEvent ( "ue_ReCreer_un_trv", 0, 0 ) 

End Choose 
end subroutine

public function boolean uf_api_maxi_coffee_caller (ref u_datawindow adw_wsin, ref u_datawindow_detail adw_lstwcommande, integer aiidseq, ref statictext astattentediverse, string asemail, long alamoutcts, long alorderid, string asmodel, long alwarrantyid, long alsinistreid);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::uf_api_maxi_coffee_caller 
//* Auteur			: FABRY JF
//* Date				: 24/02/2025
//* Libellé			: APPEL API MAXI COFFEE
//* Commentaires	: [PMO268_MIG48]
//*
//*-----------------------------------------------------------------

String sUrl, sCleAuthent, sResponseApiJSon, sJson, sStatusApi, sRequestResult, sRequestBody, sInfoSpbFrnCplt, sInfoFrnSpbCplt
String sDtAppel, sDtRetour, sSql, sMessContact  
Int iRetApi, iStatusApi
HTTPClient ObjApi
JSONPackage ObJsonPackage
Long lRootObject, lRow, lCouponId
Boolean bBAemis, bModeHorsAppel, bFin, bRet


bModeHorsAppel = False
//bModeHorsAppel = True

sInfoSpbFrnCplt = adw_lstwcommande.GetItemString ( aiIdSeq, "INFO_SPB_FRN_CPLT" ) 
sInfoFrnSpbCplt = adw_lstwcommande.GetItemString ( aiIdSeq, "INFO_FRN_SPB_CPLT" ) 
asModel = F_REMPLACE ( asModel, "'", " " ) 

If IsNull ( sInfoSpbFrnCplt ) Then sInfoSpbFrnCplt = ""
If IsNull ( sInfoFrnSpbCplt ) Then sInfoFrnSpbCplt = ""

bBAemis = False

sUrl = Trim ( ProfileString (stglb.sfichierini ,"API_MAXI_COFFEE","URL_API","*"))

/*
Pour la simulation : 
apiKey : %JR9&_[#dP(IpR^=V(I&Nqa!x_AaaoDqX

Pour la production : 
apiKey : s}:,8e-BByrfrg83;*|z=BEg9j[fg32@AsV0
*/
sCleAuthent = Trim ( ProfileString (stglb.sfichierini,"API_MAXI_COFFEE","AUTHKEY","*"))

If sUrl = "*" Or sCleAuthent ="*" Then

	// Maj de la prestation
	iStatusApi = 1000
	sDtAppel = String ( Today (), "dd/mm/yyyy" ) + " " + String ( Now (), "hh:mm:ss" ) 	
	F_CLE_VAL_E ( "DTE_APPEL", sDtAppel, sInfoSpbFrnCplt, ";" )  // Aller 
	
	This.uf_api_maxi_coffee_maj_presta ( "PRESTA", adw_wsin, alsinistreid, aiidseq, iStatusApi, sInfoSpbFrnCplt, sInfoFrnSpbCplt )
	
	stMessage.sTitre		= "URL API MAXI COFFEE"
	stMessage.Icon			= StopSign!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sVar [1]   = "URL API MAXI COFFEE"
	stMessage.sCode		= "API0001"
	F_Message ( stMessage ) 	
	
	This.uf_api_maxi_coffee_maj_presta ( "TRAVAIL", adw_wsin, alsinistreid, aiidseq, iStatusApi, sInfoSpbFrnCplt, sInfoFrnSpbCplt )	
	
	Return False
End If 	

// ajout des argument sur l'URL 
// Aucun ajout sur l'URL de Maxi 
// sUrl += 

// Construction de la requête JSON (Resquest Body )
ObJsonPackage = Create JSONPackage 

ObJsonPackage.SetValueString ( "email", asEmail )
ObJsonPackage.SetValueNumber ( "amountCts", alAmoutCts )
ObJsonPackage.SetValueNumber ( "orderId", alOrderId )
ObJsonPackage.SetValueString ( "model", asModel )
ObJsonPackage.SetValueNumber ( "warrantyId", alWarrantyId )
ObJsonPackage.SetValueNumber ( "sinistreId", alSinistreId )

sRequestBody = ObJsonPackage.GetJsonString ()


// Complèment sur la méthode d'autorisation donné par PostMan
// Demander à Matthieu, Lisette, Marlène le type d’authentification
// sCleAuthent = "Basic " + sCleAuthent  [20250410100203163]

ObjApi = Create HTTPClient 

ObjApi.SetRequestHeader ( "apiKey", sCleAuthent )
ObjApi.SetRequestHeader ( "Content-Type", "application/json") // [20250410100203163]
ObjApi.SetRequestHeader ( "Accept-Encoding", "gzip, deflate, br") // [20250410100203163]

astAttenteDiverse.text = " ~n~rAppel de l'API Maxi Coffee (extérieure à l'entreprise)~n~rpour validation du bon d'achat~n~r~n~rVeuillez patienter...."
astAttenteDiverse.X			=  941
astAttenteDiverse.Y			=  390
astAttenteDiverse.Height	=  300
astAttenteDiverse.Width		= 1585
astAttenteDiverse.BringToTop = True
astAttenteDiverse.Show()

sDtAppel = String ( Today (), "dd/mm/yyyy" ) + " " + String ( Now (), "hh:mm:ss" ) 

If Not bModeHorsAppel Then
	iRetApi = ObjApi.SendRequest( "POST", sUrl, sRequestBody )
	iStatusApi = ObjApi.GetResponseStatusCode( ) 
	sStatusApi = ObjApi.GetResponseStatusText()
	ObjApi.GetResponseBody ( sResponseApiJSon )
Else 
	// Succès
	iStatusApi =200
	sResponseApiJSon = '{ "couponId": 1354895 }'
	
	// Erreur
   //iStatusApi =400
	//sResponseApiJSon = '{ "error" : { "code": "1AE58", "message": "Error Description" } }'
	
End If 

sDtRetour = String ( Today (), "dd/mm/yyyy" ) + " " + String ( Now (), "hh:mm:ss" ) 


astAttenteDiverse.Hide ()

// Prépa Maj de la prestation
F_CLE_VAL_E ( "REQUEST_BODY", sRequestBody, sInfoSpbFrnCplt, ";" )  // Aller 
F_CLE_VAL_E ( "DTE_APPEL", sDtAppel, sInfoSpbFrnCplt, ";" )  // Aller 

F_CLE_VAL_E ( "RESPONSE_API", sResponseApiJSon, sInfoFrnSpbCplt, ";" )	// Retour
F_CLE_VAL_E ( "DTE_RETOUR", sDtRetour, sInfoFrnSpbCplt, ";" )	// Retour	
F_CLE_VAL_E ( "STATUT_API", String ( iStatusApi ), sInfoFrnSpbCplt, ";" )	// Retour	


// MessageBox  ( "Retour", sResponseApiJSon + ", Statut " + String ( iStatusApi ) + ", Retour " + String ( iRetApi ) )

// Echec
If iStatusApi >= 300 Or iStatusApi < 0 Or iRetApi < 0 Then
	f_trace_web_service("API MAXI COFFEE", "POST-" + sUrl, alSinistreId, 0, "", sRequestBody )
	f_trace_web_service("API MAXI COFFEE - reponse", "POST-" + sUrl, alSinistreId , iStatusApi, sStatusApi, sResponseApiJSon )			
End If


// Succès
If iStatusApi = 200 Then
	bBAemis = True
	ObJsonPackage.LoadString (sResponseApiJSon )
	lCouponId = ObJsonPackage.GetValueNumber ( "couponId")

	F_CLE_VAL_E ( "COUPON_ID", String ( lCouponId ), sInfoFrnSpbCplt, ";" )	// Retour

End If 

// Maj de la prestation
This. uf_api_maxi_coffee_maj_presta ( "PRESTA", adw_wsin, alsinistreid, aiidseq, iStatusApi, sInfoSpbFrnCplt, sInfoFrnSpbCplt )


If bBAemis Then
	stMessage.sTitre		= "APPEL API MAXI COFFEE SUCCES"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "API0011 "
	stMessage.sVar[1]		= Mid ( String ( alAmoutCts ), 1, Len ( String ( alAmoutCts ) ) - 2 ) + "." + Right ( String ( alAmoutCts ), 2 )
	F_Message ( stMessage )
Else 
	bFin = False
	Do While Not bFin
		stMessage.sTitre		= "APPEL API MAXI COFFEE ECHEC"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= YESNO!
		stMessage.sCode		= "API0010 "
		stMessage.sVar[1]		= stGlb.sCodOper
		If F_Message ( stMessage ) = 1 Then bFin = TRUE
	Loop	

	
End If 	

If ( iStatusApi >= 300 And iStatusApi <= 1000 ) Or iStatusApi = -1 Then

	This.uf_api_maxi_coffee_maj_presta ( "TRAVAIL", adw_wsin, alsinistreid, aiidseq, iStatusApi, sInfoSpbFrnCplt, sInfoFrnSpbCplt )	

End IF 



If IsValid ( ObjApi ) Then Destroy ObjApi 
If IsValid ( ObJsonPackage ) Then Destroy ObJsonPackage 

Return bBAemis
end function

on n_cst_gs_appel_api_generique.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_gs_appel_api_generique.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

