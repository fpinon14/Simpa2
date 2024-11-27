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
end prototypes

public function boolean uf_api_orange_reunion_caller (ref u_gs_sp_sinistre aiuogssinistre, ref statictext astattentediverse, ref u_datawindow adw_wdivsin, long alidsin, string asimei, date addtesurv, string asidadh);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::uf_api_orange_reunion_caller 
//* Auteur			: FABRY JF
//* Date				: 19/11/2024
//* Libellé			: APPEL API Orange Réunion (et Caraïbes)
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

	If iStatusApi >= 300 Then
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

on n_cst_gs_appel_api_generique.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_gs_appel_api_generique.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

