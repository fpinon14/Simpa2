HA$PBExportHeader$w_mdi_sp.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre MDI de l'application SIMPA 2.
forward
global type w_mdi_sp from w_mdi
end type
end forward

global type w_mdi_sp from w_mdi
integer width = 3735
integer height = 2392
string title = "DECES/INVALIDITE"
string menuname = "m_mdi_sp"
long backcolor = 276856960
event ue_saisie_automatique pbm_custom74
event ue_saisie_automatique_sherpa pbm_custom01
event ue_ctrle_rep_courrier ( )
end type
global w_mdi_sp w_mdi_sp

type prototypes
FUNCTION Long		GetDesktopWindow () LIBRARY "user32"
FUNCTION Long		GetWindow ( Long lHandle, Long lCmd ) LIBRARY "user32"
FUNCTION Long		GetClassNameA ( Long lHandle, Ref String sClassName, Long lMax ) LIBRARY "user32" alias for "GetClassNameA;Ansi"
FUNCTION Long		GetWindowTextA ( Long lHandle, Ref String sBuffer, Long lMax ) LIBRARY "user32" alias for "GetWindowTextA;Ansi"
FUNCTION Boolean	IsWindowVisible ( Long lHandle ) LIBRARY "user32"

end prototypes

type variables
Private :

Int	iiTimer // Gestion d'OpCon/XPS

Boolean	ibActiverSend	= FALSE
Long		ilWordParm
Long		ilLongParm

end variables

forward prototypes
public function integer wf_browse_fenetre (string astitre)
public function integer wf_browse_fenetre (string astitre, string asclassname[])
end prototypes

event ue_saisie_automatique;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Mdi_Sp
//* Evenement 		: ue_saisie_automatique
//* Auteur			: FS
//* Date				: 12/02/2002
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ouverture de fen$$HEX1$$ea00$$ENDHEX$$tres en automatique
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  PLJ  25/07/2002	Ajout de l'ouverture automatique pour la validation Via Sherpa	
//* #2  FS   20/09/2002 Gestion des ordres de tests si fen$$HEX1$$ea00$$ENDHEX$$tres saisie/validation ouvertes		  
//*      JFF  17/01/2020 Modif position de l'appli en consultation et ajout en gestion
//*-----------------------------------------------------------------
String sMesErr
String sRetour, sCmd, sWordParm
Long   lHandle, lRet, lHandleSherpa, lMessageIdSherpa

Choose Case gsAction

	CASE "CONSULTER"

	/*----------------------------------------------------------------------------*/
	/* Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil de consultation de sinistre.             */
	/*----------------------------------------------------------------------------*/

		SetPointer ( HourGlass! )

		// [POSITION_SIMPA2]
		This.x = 3500 	// ... Coordonn$$HEX1$$e900$$ENDHEX$$es de l'application
		This.y = 600
		
		If IsValid ( W_Ac_Sp_Dossier_2000 ) Then 
			W_Ac_Sp_Dossier_2000.Show()
		Else
			OpenSheetWithParm ( W_Ac_Sp_Dossier_2000 , stGLB, w_mdi_sp, 0, Layered! )
		End If

		W_Ac_Sp_Dossier_2000.BringToTop = True

		W_Ac_Sp_Dossier_2000.TriggerEvent ("ue_Saisie_Automatique")

   CASE "FIN_CONSULTER"

		/*----------------------------------------------------------------------------*/
		/* Fermeture du dossier ouvert sur la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation de sinistre     */
		/*----------------------------------------------------------------------------*/

		If IsValid ( W_Ac_Sp_Dossier_2000 ) Then

			If W_Ac_Sp_Dossier_2000.visible Then W_Ac_Sp_Dossier_2000.TriggerEvent ( "ue_Retour", 1, 1 )
			
      End If

   CASE "TEST_CONSULTER"

	/*----------------------------------------------------------------------------*/
	/* Test La fen$$HEX1$$ea00$$ENDHEX$$tre de consultation est-elle ouverte                           */
	/*----------------------------------------------------------------------------*/

      gsParam = "FERME"

		If IsValid ( W_Ac_Sp_Dossier_2000 ) Then

         If w_Ac_Sp_Dossier_2000.Visible Then w_ac_Sp_Dossier_2000.TriggerEvent ( "ue_saisie_automatique" )

      End If

      sRetour = gsParam


	CASE "GERER"

	/*------------------------------------------------------------------*/
	/* Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de gestion du dossier                    */
	/*------------------------------------------------------------------*/
		// [POSITION_SIMPA2]
		This.x = 3500 	// ... Coordonn$$HEX1$$e900$$ENDHEX$$es de l'application
		This.y = 600
	
		If IsValid ( w_a_sp_Wkf_Saisie ) Then 
			w_a_sp_Wkf_Saisie.Show()
		Else
			OpenSheetWithParm ( w_a_sp_Wkf_Saisie , stGLB, w_mdi_sp, 0, Layered! )
		End If

		w_a_sp_Wkf_Saisie.BringToTop = True

		w_a_sp_Wkf_Saisie.TriggerEvent ("ue_Saisie_Automatique")


   CASE "TEST_GERER"

	/*------------------------------------------------------------------*/
	/* Test : La fen$$HEX1$$ea00$$ENDHEX$$tre de gestion est-elle ouverte ?                  */
	/*------------------------------------------------------------------*/

     gsParam = "FERME"

		If IsValid ( w_a_sp_Wkf_Saisie ) Then   // ... La fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil est ouverte

         If w_a_sp_wkf_Saisie.Visible Then w_a_sp_wkf_Saisie.TriggerEvent ( "ue_saisie_automatique" )

	   End If

      sRetour = gsParam


	// #1 DEBUT

	CASE "VALIDER"
		/*------------------------------------------------------------------*/
		/* Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de validation du dossier                 */
		/*------------------------------------------------------------------*/
		If IsValid ( w_a_sp_Wkf_Validation ) Then 
			w_a_sp_Wkf_Validation.Show()
		Else
			OpenSheetWithParm ( w_a_sp_Wkf_Validation , stGLB, w_mdi_sp, 0, Layered! )
		End If

		w_a_sp_Wkf_Validation.BringToTop = True

/*------------------------------------------------------------------*/
/* [MIGPB8COR]                                                      */
/* DGA. Probl$$HEX1$$e800$$ENDHEX$$me affichage Word. On essaye avec un PostEvent.       */
/*------------------------------------------------------------------*/
//		w_a_sp_Wkf_Validation.TriggerEvent ("ue_Saisie_Automatique")
		W_A_Sp_Wkf_Validation.Event Post ue_Saisie_Automatique (0,0)
		
	// #1 FIN

   CASE "TEST_VALIDER"

	/*------------------------------------------------------------------*/
	/* Test : La fen$$HEX1$$ea00$$ENDHEX$$tre de validation est-elle ouverte ?               */
	/*------------------------------------------------------------------*/

     gsParam = "FERME"

		If IsValid ( w_a_sp_Wkf_Validation ) Then   	// ... La fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil est ouverte

         If w_a_sp_wkf_Validation.Visible Then w_a_sp_wkf_Validation.TriggerEvent ( "ue_saisie_automatique" )

      End If

      sRetour = gsParam

  CASE "EDITER"

		/*------------------------------------------------------------------*/
		/* Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'$$HEX1$$e900$$ENDHEX$$dition des courriers                  */
		/*------------------------------------------------------------------*/
		/* Si on est en SVE                                                 */
		/*------------------------------------------------------------------*/
		If stGLB.bSaiValEdt Then
			If IsValid ( W_Ae_Sp_Edition_Dcmp060589 ) Then 
				W_Ae_Sp_Edition_Dcmp060589.Show()
			Else
				OpenSheetWithParm ( W_Ae_Sp_Edition_Dcmp060589, stGLB, W_Mdi_Sp, 0, Layered! )
			End If

			W_Ae_Sp_Edition_Dcmp060589.BringToTop = True
			W_Ae_Sp_Edition_Dcmp060589.TriggerEvent ("ue_Saisie_Automatique")

		Else 
			If IsValid ( w_ae_sp_edit_sinistre_wkf_2000 ) Then 
				w_ae_sp_edit_sinistre_wkf_2000.Show()
			Else
				OpenSheetWithParm ( w_ae_sp_edit_sinistre_wkf_2000 , stGLB, W_Mdi_Sp, 0, Layered! )
			End If

			w_ae_sp_edit_sinistre_wkf_2000.BringToTop = True
			w_ae_sp_edit_sinistre_wkf_2000.TriggerEvent ("ue_Saisie_Automatique")

		End If


   CASE "REEDITER"

		/*------------------------------------------------------------------*/
		/* Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de r$$HEX2$$e900e900$$ENDHEX$$dition des courriers               */
		/*------------------------------------------------------------------*/
		/* Si on est en SVE                                                 */
		/*------------------------------------------------------------------*/
		If stGLB.bSaiValEdt Then
			If IsValid ( W_Ae_Sp_ReEdition_Dcmp060589 ) Then 
				W_Ae_Sp_ReEdition_Dcmp060589.Show()
			Else
				OpenSheetWithParm ( W_Ae_Sp_ReEdition_Dcmp060589, stGLB, W_Mdi_Sp, 0, Layered! )
			End If

			W_Ae_Sp_ReEdition_Dcmp060589.BringToTop = True
			W_Ae_Sp_ReEdition_Dcmp060589.TriggerEvent ("ue_Saisie_Automatique")

		/*------------------------------------------------------------------*/
		/* Sinon m$$HEX1$$e900$$ENDHEX$$thode ancienne                                           */
		/*------------------------------------------------------------------*/
		Else	
			If IsValid (  W_ae_Sp_ReEdit_Sinistre_Wkf_2000 ) Then 
				 W_ae_Sp_ReEdit_Sinistre_Wkf_2000.Show()
			Else
				OpenSheetWithParm ( W_ae_Sp_ReEdit_Sinistre_Wkf_2000 , stGLB, w_mdi_sp, 0, Layered! )
			End If

			W_ae_Sp_ReEdit_Sinistre_Wkf_2000.BringToTop = True

			W_ae_Sp_ReEdit_Sinistre_Wkf_2000.TriggerEvent ("ue_Saisie_Automatique")
		End If

END CHOOSE

/*------------------------------------------------------------------*/
/* Gestion de la valeur de retour pour SHERPA                       */
/*------------------------------------------------------------------*/
/* Uniquement si demande de test                                    */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modification DGA. Le 30/03/2006.                                 */
/*------------------------------------------------------------------*/
/* Il ne faut pas faire un OpenChannel ( WarmLink ), car il y a un  */
/* probl$$HEX1$$e800$$ENDHEX$$me avec le CloseChannel. Il vaut mieux essayer un          */
/* ColdLink (Lancement du ExecRemote uniquement)                    */
/*------------------------------------------------------------------*/
If Left ( gsAction, 4 ) = "TEST" Then
	If	ibActiverSend	Then
		lHandleSherpa = Wf_Browse_Fenetre ( "SHERPA" )
		sWordParm = String ( ilWordParm )
		If	sRetour = "FERME"	Then	
			sWordParm = sWordParm + "9"
		Else
			sWordParm = sWordParm + "0"
		End If
		
		If	lHandleSherpa > 0	Then
			lMessageIdSherpa = 1023 + 1
			
			Boolean bRet
			lRet = Send ( lHandleSherpa, lMessageIdSherpa, Long ( sWordParm ), Long ( ilLongParm ) )

		Else
				lRet = -1
		End If
	End If
End If

ibActiverSend = False
ilWordParm = 0
ilLongParm = 0

end event

event ue_saisie_automatique_sherpa;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Mdi_Sp
//* Evenement 		: ue_saisie_automatique
//* Auteur			: FS
//* Date				: 12/02/2002
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ouverture de fen$$HEX1$$ea00$$ENDHEX$$tres en automatique
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  PLJ  25/07/2002	Ajout de l'ouverture automatique pour la validation Via Sherpa	
//* #2  FS   20/09/2002 Gestion des ordres de tests si fen$$HEX1$$ea00$$ENDHEX$$tres saisie/validation ouvertes		  
//*-----------------------------------------------------------------

If	lParam = 0	Then gsParam = ""
If	lParam > 0	Then gsParam = String ( lParam )

Choose Case wParam
Case 100000
	gsAction = "CONSULTER"

Case 100200
	gsAction = "FIN_CONSULTER"

Case 100100
	gsAction = "TEST_CONSULTER"

Case 300000
	gsAction = "GERER"
	
Case 300100
	gsAction = "TEST_GERER"
	
Case 600000
	gsAction = "VALIDER"	

Case 600100
	gsAction = "TEST_VALIDER"

Case 400000
	gsAction = "EDITER"

Case 500000
	gsAction = "REEDITER"

End Choose

ibActiverSend = True
ilLongParm	= lParam
ilWordParm	= wParam

This.TriggerEvent ( "Ue_Saisie_Automatique" )

end event

event ue_ctrle_rep_courrier();//*-----------------------------------------------------------------
//*
//* Objet 			: W_Mdi_Sp
//* Evenement 		: ue_Ctrle_Rep_Courrier
//* Auteur			: JFF
//* Date				: 27/12/2022
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

s_Pass stPassData1	

	
stPassData1.lTab[1] = this.Width
stPassData1.lTab[2] = this.Height
stPassData1.lTab[3] = this.X
stPassData1.lTab[4] = this.Y

OpenWithParm ( w_ctrle_rep_courrier, stPassData1 ) 
stPassData1 = Message.PowerObjectParm
If Isvalid ( w_ctrle_rep_courrier ) Then Destroy w_ctrle_rep_courrier

end event

public function integer wf_browse_fenetre (string astitre);////*-----------------------------------------------------------------
////*
////* Fonction		: W_Mdi_Sp::Wf_Browse_Fenetre	(PUBLIC)
////* Auteur			: Erick John Stark
////* Date				: 04/04/2005 03:10:01
////* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
////* Commentaires	: On va browser l'ensemble des fen$$HEX1$$ea00$$ENDHEX$$tres ouvertes afin de trouver les applications SIMPA2 et SAVANE
////*
////* Arguments		: String			asTitre				(Val)	Titre de la fen$$HEX1$$ea00$$ENDHEX$$tre
////*
////* Retourne		: Long			Identifiant de la fen$$HEX1$$ea00$$ENDHEX$$tre
////*
////*-----------------------------------------------------------------
////* MAJ      PAR      Date	  Modification
//* #1		FPI		06/11/2009 [MIGPB11] Communication avec Sherpa PB 11
//				PHG		22/09/2011 [I037] Communication avec Sherpa PB12
////*-----------------------------------------------------------------
//

String sClassNamePB[]
//sClassNamePB = { "FNWND380", "FNWNS380", "FNWND3115", "FNWNS3115"} // #1 Ajout de classes
sClassNamePB = { "FNWND380", "FNWNS380", "FNWND3115", "FNWNS3115", "FNWND3120", "FNWNS3120"} // #1 Ajout de classes

return Wf_Browse_Fenetre ( astitre, sClassNamePB )

///*------------------------------------------------------------------*/
///* Attention, la variable asClassName ne doit pas d$$HEX1$$e900$$ENDHEX$$passer 255      */
///* caract$$HEX1$$e800$$ENDHEX$$res de long.                                              */
///*------------------------------------------------------------------*/
//String sNomWindow, sNomClasse
//
//Long lHandleDesktop, lHandleChild
//
//Constant Long GW_HWNDFIRST		= 0
//Constant Long GW_HWNDLAST		= 1
//Constant Long GW_HWNDNEXT		= 2
//Constant Long GW_HWNDPREV		= 3
//Constant Long GW_OWNER			= 4
//Constant Long GW_CHILD			= 5
//Constant Long GW_MAX				= 5
//Constant Long MAX_WIDTH			= 255
//
//lHandleDesktop	= GetDesktopWindow ()
//lHandleChild	= GetWindow ( lHandleDesktop, GW_CHILD )
//
//Do	While	lHandleChild > 0
//	sNomWindow	= Space ( MAX_WIDTH )
//	sNomClasse	= Space ( MAX_WIDTH )
///*------------------------------------------------------------------*/
///* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le ClassName de la fen$$HEX1$$ea00$$ENDHEX$$tre que l'on vient de         */
///* trouver.                                                         */
///*------------------------------------------------------------------*/
//	GetClassNameA ( lHandleChild, sNomClasse, MAX_WIDTH )
///*------------------------------------------------------------------*/
///* S'agit-il d'une fen$$HEX1$$ea00$$ENDHEX$$tre PowerBuilder 8.                          */
///*------------------------------------------------------------------*/
//	If	sNomClasse = sClassNamePB[1] Or sNomClasse = sClassNamePB[2]	Then
///*------------------------------------------------------------------*/
///* Oui, donc on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nom de la fen$$HEX1$$ea00$$ENDHEX$$tre.                      */
///*------------------------------------------------------------------*/
//		GetWindowTextA ( lHandleChild, sNomWindow, MAX_WIDTH )
///*------------------------------------------------------------------*/
///* Le titre de la fen$$HEX1$$ea00$$ENDHEX$$tre correspond $$HEX2$$e0002000$$ENDHEX$$la fen$$HEX1$$ea00$$ENDHEX$$tre recherch$$HEX1$$e900$$ENDHEX$$e.       */
///*------------------------------------------------------------------*/
//		If	Left ( sNomWindow, Len ( asTitre ) ) = asTitre	Then
//			Return ( lHandleChild )
//		End If
//	End If
//	lHandleChild	= GetWindow ( lHandleChild, GW_HWNDNEXT )
//Loop
//

end function

public function integer wf_browse_fenetre (string astitre, string asclassname[]);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Mdi_Sp::Wf_Browse_Fenetre	(PUBLIC)
//* Auteur			: Erick John Stark		: JCA
//* Date				: 04/04/2005 03:10:01	: 22/02/2008
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va browser l'ensemble des fen$$HEX1$$ea00$$ENDHEX$$tres ouvertes afin de trouver les applications SIMPA2 et SAVANE
//*
//* Arguments		: String			asTitre				(Val)	Titre de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*
//* Retourne		: Long			Identifiant de la fen$$HEX1$$ea00$$ENDHEX$$tre
//* 					  string array	Classe des fen$$HEX1$$ea00$$ENDHEX$$tres que l'on recherche
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

String sClassNamePB[]
integer i

//sClassNamePB = { "FNWND380", "FNWNS380" }
sClassNamePB = asclassname

/*------------------------------------------------------------------*/
/* Attention, la variable asClassName ne doit pas d$$HEX1$$e900$$ENDHEX$$passer 255      */
/* caract$$HEX1$$e800$$ENDHEX$$res de long.                                              */
/*------------------------------------------------------------------*/
String sNomWindow, sNomClasse

Long lHandleDesktop, lHandleChild

Constant Long GW_HWNDFIRST		= 0
Constant Long GW_HWNDLAST		= 1
Constant Long GW_HWNDNEXT		= 2
Constant Long GW_HWNDPREV		= 3
Constant Long GW_OWNER			= 4
Constant Long GW_CHILD			= 5
Constant Long GW_MAX				= 5
Constant Long MAX_WIDTH			= 255

lHandleDesktop	= GetDesktopWindow ()
lHandleChild	= GetWindow ( lHandleDesktop, GW_CHILD )

Do	While	lHandleChild > 0
	sNomWindow	= Space ( MAX_WIDTH )
	sNomClasse	= Space ( MAX_WIDTH )
	
	/*------------------------------------------------------------------*/
	/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le ClassName de la fen$$HEX1$$ea00$$ENDHEX$$tre que l'on vient de         */
	/* trouver.                                                         */
	/*------------------------------------------------------------------*/
	GetClassNameA ( lHandleChild, sNomClasse, MAX_WIDTH )
	
	/*------------------------------------------------------------------*/
	/* S'agit-il d'une fen$$HEX1$$ea00$$ENDHEX$$tre PowerBuilder 8.                          */
	/*------------------------------------------------------------------*/
	for i = 1 to upperbound(sClassNamePB)
		if sNomClasse = sClassNamePB[i]  then
			/*------------------------------------------------------------------*/
			/* Oui, donc on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nom de la fen$$HEX1$$ea00$$ENDHEX$$tre.                      */
			/*------------------------------------------------------------------*/
			GetWindowTextA ( lHandleChild, sNomWindow, MAX_WIDTH )
			
			/*------------------------------------------------------------------*/
			/* Le titre de la fen$$HEX1$$ea00$$ENDHEX$$tre correspond $$HEX2$$e0002000$$ENDHEX$$la fen$$HEX1$$ea00$$ENDHEX$$tre recherch$$HEX1$$e900$$ENDHEX$$e.       */
			/*------------------------------------------------------------------*/
			If	pos ( lower(sNomWindow), lower(asTitre) ) > 0	Then
				Return ( lHandleChild )
			End If
			
		End If
	next
	
	lHandleChild	= GetWindow ( lHandleChild, GW_HWNDNEXT )
Loop

Return ( 0 )
end function

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet			: w_mdi_sp
//* Evenement 		: Open
//* Auteur			: FS
//* Date				: 12/02/2002
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: D$$HEX1$$e900$$ENDHEX$$marrage comme serveur DDE
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: NotFound
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 CAG	 09/07/2004   Ajout du bouton pour affichage polices et 
//*									assurances des gti du produit du dr DCMP 030381
//* 		 JFF   08/11/2018   [MSG_SIM_VERSION_BASE]
//*       JFF   26/11/2019 [PC192290]
//*       JFF   26/12/2022 Contr$$HEX1$$f400$$ENDHEX$$le r$$HEX1$$e900$$ENDHEX$$pertoire courrier
//        JFF   04/09/2023 [RS5656_MOD_PCE_DIF]
//*-----------------------------------------------------------------

String sChaine 
Long lRevSvn, lRetAccordRevSvn 
Datetime dtDteVersBaseSim, dtDteSqlQuotBaseSim
Integer iAlerte, iAlerteSqlQuot

// V$$HEX1$$e900$$ENDHEX$$rifie si acc$$HEX1$$e800$$ENDHEX$$s SIMPA2 autoris$$HEX1$$e900$$ENDHEX$$
F_Couper_Acces_SIMPA2 ()

/*------------------------------------------------------------------*/
/* #1 CAG 09/07/04 : r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration de la ref de la mdi pas seulement */
/*							dans le cas de OpCon (cf timer)					  */
/*------------------------------------------------------------------*/
gWMdi = This	

/*------------------------------------------------------------------*/
/* JFF 16/12/2002 : Gestion du mode Automatique avec OPCON/XPS(SMA) */
/*------------------------------------------------------------------*/
If gbOpCon Then

	iiTimer = 0
	Timer ( 1, This )

End If

// [VERIF_REVSVN]
If F_CLE_A_TRUE ( "VERIF_REVSVN" ) Then
	If Upper(SQLCA.Database) = "SIMPA2_PRO" Then
		sChaine = ""

		gdtCnx = DateTime ( Today (), Now () )
//		gdtCnx = DateTime ( 2015-07-08 ,12:02:00 )  Test

		If IsNumber ( stGLB.sRevisionSvn ) Then
			lRevSvn = Long ( stGLB.sRevisionSvn )
		End If 
		
		If Not IsNumber ( stGLB.sRevisionSvn ) Then
			lRevSvn = -1
		End If 

//		lRevSvn = 19920   // Test
		
		lRetAccordRevSvn = SQLCA.PS_S_VERIF_REV_SVN ( lRevSvn, stGLB.sCodOper, sChaine )
		F_Commit ( SQLCA, SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0 )
		
		If lRetAccordRevSvn < 0 Then
		
			stMessage.berreurg=FALSE
			stMessage.bouton=Ok!
			stMessage.icon=Exclamation!
			stMessage.stitre="Version SIMPA2 Obsol$$HEX1$$e800$$ENDHEX$$te"
			stMessage.scode ="WSIN783"
			stMessage.sVar [1] = String ( lRevSvn )
			
			f_message(stMessage)
			Halt
		End If
	End IF
End If

// [MSG_SIM_VERSION_BASE]
If Upper(SQLCA.Database) <> "SIMPA2_PRO" Then
	
	SQLCA.PS_S_DETECT_SQL_QUOT_BASE_SIM ( dtDteSqlQuotBaseSim , iAlerteSqlQuot ) 
	If iAlerteSqlQuot = 1 Then
		stMessage.berreurg=FALSE
		stMessage.bouton=Ok!
		stMessage.icon=Exclamation!
		stMessage.stitre="Base de Simulation non disponible"
		stMessage.scode ="WSIN854"
		
		f_message(stMessage)			
		HALT
	End If		
	

	SQLCA.PS_S_DETECT_VERSION_BASE_SIM ( dtDteVersBaseSim , iAlerte ) 
	
	If iAlerte > 0 Then
		stMessage.berreurg=FALSE
		stMessage.bouton=Ok!
		stMessage.icon=Exclamation!
		stMessage.stitre="Base de Simulation Obsol$$HEX1$$e800$$ENDHEX$$te"
		stMessage.scode ="WSIN832"
		stMessage.sVar [1] = String ( dtDteVersBaseSim, "dd/mm/yyyy hh:mm:ss" )
		
		f_message(stMessage)			
	End If	
	
	
	If iAlerteSqlQuot = 2 Then
		stMessage.berreurg=FALSE
		stMessage.bouton=YESNO!
		stMessage.icon=Exclamation!
		stMessage.stitre="Attention au recettes !"
		stMessage.scode ="WSIN855"
		stMessage.sVar [1] = String ( dtDteSqlQuotBaseSim, "dd/mm/yyyy hh:mm:ss" )
		
		Do While f_message(stMessage)	<> 1 
			stMessage.berreurg=FALSE
			stMessage.bouton=YESNO!
			stMessage.icon=Exclamation!
			stMessage.stitre="Attention au recettes !"
			stMessage.scode ="WSIN855"
			stMessage.sVar [1] = String ( dtDteSqlQuotBaseSim, "dd/mm/yyyy hh:mm:ss" )
		Loop	
	End If		

	
End If 

// [PC192290]
gdsPieceSherpa = Create DataStore 		

// [RS5656_MOD_PCE_DIF]
If F_CLE_A_TRUE ( "RS5656_MOD_PCE_DIF" ) Then
	gdsPieceSherpa.DataObject = "d_stk_gestion_piece_sherpa_RS5656"
Else
	gdsPieceSherpa.DataObject = "d_stk_gestion_piece_sherpa"	
End If

gdsPieceSherpa.Reset ()

// [POSITION_SIMPA2]
This.x = 1980 	// ... Coordonn$$HEX1$$e900$$ENDHEX$$es de l'application
This.y = 600


end event

on timer;call w_mdi::timer;//*-----------------------------------------------------------------
//*
//* Objet         : w_mdi_sp
//* Evenement     : timer
//* Auteur        : Fabry JF
//* Date          : 19/12/2002 14:16:19
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

iiTimer ++

If iiTimer > 5 Then	

	Timer ( 0, This )

	/*------------------------------------------------------------------*/
	/* Affectation de la MDI une instance globale afin d'avoir une      */
	/* r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence sur w_main_sp_commandes pour pouvoir quitter SIMPA2.   */
	/* Cette affectation ne se fait que pour si le user est OPCO.       */
	/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//	gWMdi = This	

	/*------------------------------------------------------------------*/
	/* Click simul$$HEX2$$e9002000$$ENDHEX$$surle module des Commandes                          */
	/*------------------------------------------------------------------*/
	This.MenuId.Item[6].TriggerEvent ( Clicked! )

End If
end on

event closequery;//*-----------------------------------------------------------------
//*
//* Objet         : w_mdi_sp ( !! OVERRIDE !! )
//* Evenement     : closequery
//* Auteur        : Fabry JF
//* Date          : 16/12/2002 16:37:30
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF   26/11/2019 [PC192290]
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Le 16/12/2002 : On ferme sans message pour le traitement         */
/* Automatique d'OpCon/XPS (SMA)                                    */
/*------------------------------------------------------------------*/

// [PC192290]
If IsValid ( gdsPieceSherpa ) Then Destroy gdsPieceSherpa 


If Not gbOpCon Then Call Super::CloseQuery

end event

on w_mdi_sp.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_mdi_sp" then this.MenuID = create m_mdi_sp
end on

on w_mdi_sp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_initialisation;call super::ue_initialisation;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Mdi_Sp
//* Evenement 		: ue_Initialisation
//* Auteur			: JFF
//* Date				: 27/12/2022
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

// Contr$$HEX1$$f400$$ENDHEX$$le r$$HEX1$$e900$$ENDHEX$$pertoire courrier
If Not F_CLE_A_TRUE ( "CTRLE_PARA_REP_COURR" ) Then Return

String sRepDestProduction, sFrequenceMin, sRacineUNCDest
Long lRet

Choose Case stGlb.sCodOper 
	Case "OPCO"
		Return
End Choose

sRepDestProduction = ProfileString(stglb.sfichierini,"EDITION","SAV_QUOT_REP_DEST_PROD","")
sFrequenceMin = ProfileString(stglb.sfichierini,"EDITION","SAV_QUOT_FREQUENCE_EN_MINUTE","5")
sRacineUNCDest = ProfileString(stglb.sfichierini,"EDITION","SAV_QUOT_RACINE_UNC","")
sRacineUNCDest = sRacineUNCDest + Right ( sRepDestProduction, len ( sRepDestProduction ) - 3 ) 

lRet = SQLCA.PS_U_DATE_PIVOT_CTRLE_REP_COURRIER_V01 ( "CTRLE_REP_COURRIER", Long ( sFrequenceMin ), sRacineUNCDest )
F_Commit ( SQLCA, SQLCA.SqlCode = 0 And SQLCA.SqlDBCode = 0)

If lRet > 0 Then 
	This.PostEvent ("ue_Ctrle_Rep_Courrier")
End If 	
end event

