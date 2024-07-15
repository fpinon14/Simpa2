HA$PBExportHeader$n_cst_opcon_xps.sru
$PBExportComments$Gestion de l'automatisation des commandes via OpCon/XPS(SMA)
forward
global type n_cst_opcon_xps from nonvisualobject
end type
end forward

global type n_cst_opcon_xps from nonvisualobject
end type
global n_cst_opcon_xps n_cst_opcon_xps

type variables
Private :

// Tableau des fournisseurs pour l'int$$HEX1$$e900$$ENDHEX$$gration des articles
String isTabFrIntArt[]   

// Tableau des fournisseurs pour l'int$$HEX1$$e900$$ENDHEX$$gration du suivi
String isTabFrIntSui[]   

// Tableau des fournisseurs pour la g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration des commandes
String isTabFrGenCmd[]   

// Tableau des fournisseurs pour l'int$$HEX1$$e900$$ENDHEX$$gration IMEI
String isTabFrTrtImei[]   

// Tableau des fournisseurs pour l'int$$HEX1$$e900$$ENDHEX$$gration des boutiques
String isTabFrIntBtq[]   

Menu	iMenu

String	K_FIC_SORTIE_OPCON = "ERRSP2.DAT"
//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//String	K_FIC_PROFIL = "\TEMP\OPCOJOB.TXT"
String	K_FIC_PROFIL = "OPCOJOB.TXT"
String	K_FICFINTRT = "FIN_TRT"

String	isRepFicOpcon
String	isRepFicProfilIni

Int	ilMenuIntegration
Int	ilMenuInt_StockArticle
Int	ilMenuInt_FichierSuivi 

Int	ilMenuExtraction
Int	ilMenuGen_FichierCommande

// [PC175]
Int ilMenuDivers
Int ilMenuIntegration_AutreFic
end variables

forward prototypes
public subroutine uf_initialiser (ref menu amenu)
private function integer uf_sortie_opcon (string ascas, integer aicodeerreur, string astexte)
public subroutine uf_lancertrt (string ascas)
private function boolean uf_getprofil ()
end prototypes

public subroutine uf_initialiser (ref menu amenu);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_opcon_xps::uf_Initialiser (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 16/12/2002 10:21:52
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Initialisation des la gestion automatique des commandes.
//* Commentaires  : 
//*
//* Arguments     : Ref		Menu		aMenu			// Menu de la fen$$HEX1$$ea00$$ENDHEX$$tre Main
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//* #1	 CAG	 20/09/2004	  DCMP 040381 : Ajout du frn MSS
//* #2    MADM  07/02/2006   [DCMP060119]: Ajout du frn AEVUM/AVM
//* #3    MADM  09/05/2006   [DCMP060356]: Rempl du frn AEVUM/AVM par CORDON/COR
//* #4	 JFF   18/09/2007   [ALAPAGE]
//* #5	 PHG	 29/11/2007	  [PHG]		  : Ajout du frn O2M
//* #6    JFF   05/09/2008   [MICROMANIA]
//* #7    JFF   21/04/2009   [DCMP090102]
//* #8    JFF   21/04/2009   [DCMP090140]
//* #9    JFF   10/06/2009   [RUEDUCOMMERCE]
//* #10   JFF   18/06/2009   [MOBISTORE_CYBERPHONE]
//* #11   JFF   02/09/2009   [DCMP090327].[SBETV]
//* #12   JFF   09/11/2009   [FNAC_PROD_ECH_TECH].[BGE].[20091109111253560]
//* #13   JFF   09/11/2009   [MSS_DIAG]
//*       JFF   30/06/2010   [PC363_AUCHAN]
//* 		 FPI	 21/04/2011	  [PC514] Ajout de ACUBE
//* 		 JFF   03/05/2011   [PM178][CORIOLIS]
//			 FPI	 27/06/2012	  [PC10-2] ajout de Converlance
//			 JFF	 03/09/2012	  [PC853]
//			FPI	18/04/2013	[PC874] Ajout OMT
//				FPI	18/09/2013	[VDOC12140]
//			FPI	26/09/2013	[PC767-1]
//       JFF   30/12/2013 [PC13348&13408]
//			FPI	11/02/2014	[PC925]
//			FPI	18/12/2014	[PC13321]
//       JFF   02/01/2015 [PC801_6_TAMET]
//       JFF   02/03/2015 [PM289_CDP]
//       JFF   28/09/2015 [PM319-1]
//       JFF   05/10/2015 [PM319-2]
//		FPI	12/05/2016	[DT111]
//       JFF   11/10/2016 [DT076-2]
//       JFF   03/09/2018 [DT361]
//       JFF   17/09/2018 [PM444-1]
//       JFF   02/09/2019 [DT424]
//       JFF   30/05/2023 [PMO89_RS4822]
//       JFF   12/06/2023 [RS-5297-HP-178]
//       JFF   12/04/2024 J'ajoute boost oubli$$HEX2$$e9002000$$ENDHEX$$pour les fichier articles
//*-----------------------------------------------------------------

String	sTabCode[], sCodeFr
Long		lTotFour, lCpt

iMenu = aMenu


/*------------------------------------------------------------------*/
/* Initialisation du fichier de Sortie OpCon                        */
/*------------------------------------------------------------------*/
If This.uf_Sortie_OpCon ( "INIT", 0, "" ) < 0 Then Halt

/*------------------------------------------------------------------*/
/* Si Aucun profil n'est d$$HEX1$$e900$$ENDHEX$$fini, on ne va pas plus loin.            */
/*------------------------------------------------------------------*/
If Not This.uf_GetProfil () Then Halt

/*------------------------------------------------------------------*/
/* Fournisseur $$HEX2$$e0002000$$ENDHEX$$traiter en automatique.                            */
/*------------------------------------------------------------------*/
sTabCode [1] = "CEG"
sTabCode [2] = "DME"
sTabCode [3] = "SBE"
sTabCode [4] = "MSS"
sTabCode [5] = "CDS"
sTabCode [6] = "GOM" // #4
sTabCode [7] = "O2M" // #5 [O2M] Ajout frn O2M
sTabCode [8] = "MCM" // #6 [MICROMANIA]
sTabCode [9] = "PAP" // #8 [DCMP090140]
sTabCode [10] = "RDC" // #9 [RUEDUCOMMERCE]
sTabCode [11] = "SB1" // #10 [DCMP090327].[SBETV]
sTabCode [12] = "FNC" // #12 [FNAC_PROD_ECH_TECH].[BGE].[20091109111253560]
sTabCode [13] = "MS1" // #13 [MSS_DIAG]
sTabCode [14] = "AUC" // [PC363_AUCHAN]
sTabCode [15] = "CAR" // [PC301].[LOT2]
sTabCode [16] = "CMA" // [PC301].[LOT2]
sTabCode [17] = "CIS" // [PM178][CORIOLIS]
sTabCode [18] = "PSM" // [PM200][PSM]
sTabCode [19] = "CVC" // [PC10-2]
sTabCode [20] = "COR"
sTabCode [21] = "LBE" // [PC721]
sTabCode [22] = "VPP" // [PC929]
sTabCode [23] = "OMT" // [PC874]
sTabCode [24] = "IMEI_ORANGE" // [VDOC12140]
sTabCode [25] = "ORE" // [PC767-1]
sTabCode [26] = "MTT" // [PC13348&13408]
sTabCode [27] = "SRR" // [PC925]
sTabCode [28] = "ELD" // [PC13321]
sTabCode [29] = "TMT" // [PC801_6_TAMET]
sTabCode [30] = "CDA" // [PM289_CDP]
sTabCode [31] = "PPO" // [PM319-1]
sTabCode [32] = "PPB" // [PM319-2]
sTabCode [33] = "ATC" // [PC13442-2]
sTabCode [34] = "BK2" // [DT076-2]
sTabCode [35] = "RTB" // [DT328-1]
sTabCode [36] = "CEA" // [DT361]
sTabCode [37] = "AGP" // [PM444-1]
sTabCode [38] = "OGP" // [DT424]
sTabCode [39] = "OOP" // [DT424]
sTabCode [40] = "CDP" // #7 [DCMP090102]
sTabCode [41] = "TLS" // [RS3200]
sTabCode [42] = "CDF" // [PMO89_RS4822]
sTabCode [43] = "IFR" // [RS-5297-HP-178]
sTabCode [44] = "BST" 

lTotFour = UpperBound ( sTabCode )

/*------------------------------------------------------------------*/
/* Pour chaque fournisseur, on charge le param$$HEX1$$e800$$ENDHEX$$trage du fichier INI */
/*------------------------------------------------------------------*/
For lCpt = 1 To lTotFour
	sCodeFr = Upper ( sTabCode [lCpt] )

	/*------------------------------------------------------------------*/
	/* Faut-il traiter ce fournisseur ?                                 */
	/*------------------------------------------------------------------*/
	If Trim ( ProfileString ( isRepFicProfilIni, sCodeFr, "TRT", "0" ) ) = "0" Then Continue

	/*------------------------------------------------------------------*/
	/* Faudra-t-il faire l'integration du fichier article ?             */
	/*------------------------------------------------------------------*/
	If Trim ( ProfileString ( isRepFicProfilIni, sCodeFr, "INT_ART", "0" ) ) = "1" Then
		isTabFrIntArt [ UpperBound (isTabFrIntArt) + 1 ] = sCodeFr
	End If

	/*------------------------------------------------------------------*/
	/* Faudra-t-il faire l'integration du fichier suivi ?               */
	/*------------------------------------------------------------------*/
	If Trim ( ProfileString ( isRepFicProfilIni, sCodeFr, "INT_SUIVI", "0" ) ) = "1" Then
		isTabFrIntSui [ UpperBound (isTabFrIntSui) + 1 ] = sCodeFr
	End If

	/*------------------------------------------------------------------*/
	/* Faudra-t-il faire la g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration du fichier commande ?            */
	/*------------------------------------------------------------------*/
	If Trim ( ProfileString ( isRepFicProfilIni, sCodeFr, "GEN_CMD", "0" ) ) = "1" Then
		isTabFrGenCmd [ UpperBound (isTabFrGenCmd) + 1 ] = sCodeFr
	End If

	// [VDOC12140]
	/*------------------------------------------------------------------*/
	/* Faudra-t-il faire l'int$$HEX1$$e900$$ENDHEX$$gration du fichier de boutique ?            */
	/*------------------------------------------------------------------*/
	If Trim ( ProfileString ( isRepFicProfilIni, sCodeFr, "INT_BTQ", "0" ) ) = "1" Then
		isTabFrIntBtq [ UpperBound (isTabFrIntBtq) + 1 ] = sCodeFr
	End If

	/*------------------------------------------------------------------*/
	/* Faudra-t-il faire l'int$$HEX1$$e900$$ENDHEX$$gration du fichier d'IMEI ?            */
	/*------------------------------------------------------------------*/
	If Trim ( ProfileString ( isRepFicProfilIni, sCodeFr, "INT_IMEI", "0" ) ) = "1" Then
		isTabFrTrtImei [ UpperBound (isTabFrTrtImei) + 1 ] = sCodeFr
	End If

Next


/*------------------------------------------------------------------*/
/* Ordre des menus principaux.                                      */
/*------------------------------------------------------------------*/
ilMenuIntegration = 1
	ilMenuInt_StockArticle = 1 
	ilMenuInt_FichierSuivi = 2 

ilMenuExtraction  = 2
	ilMenuGen_FichierCommande = 1
	
//[PC175]
ilMenuDivers  = 3
	ilMenuIntegration_AutreFic = 16

end subroutine

private function integer uf_sortie_opcon (string ascas, integer aicodeerreur, string astexte);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_OpCon_XPS::uf_Sortie_OpCon (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 16/12/2002
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Fichier de sortie des erreurs pour OpCon
//* Commentaires	: 
//*
//* Arguments		: asCas			String		Val
//*					  aiCodeErreur	Integer		Val
//*					  asTexte		String		Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1    JFF    05/04/2006  ajout du "+ K_FIC_SORTIE_OPCON" derri$$HEX1$$e800$$ENDHEX$$re isRepFicOpcon  
//* #2    JFF    05/04/2006  suppr. "+ K_FIC_SORTIE_OPCON" 
//* 
//*-----------------------------------------------------------------

Int	iRet, iFicOpcon, iFicFinTrt 
String sMes
Long	lRow


/*------------------------------------------------------------------*/
/* Fichier de sortie Erreur pour OpCon                              */
/*------------------------------------------------------------------*/

CHOOSE CASE Upper ( asCas )

	CASE "INIT"

		isRepFicOpcon =  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "OPCON_OUT", &
							ProfileString ( stGlb.sWinDir + "\MAJPOST.INI", "PARAM", "DESTINATION", "C:" ) + "\" ) // #2
		iRet = 1

//Migration PB8-WYNIWYG-03/2006 CP
//		If FileExists ( isRepFicOpcon ) Then 
		If f_FileExists ( isRepFicOpcon + K_FIC_SORTIE_OPCON ) Then //#1
//Fin Migration PB8-WYNIWYG-03/2006 CP	

			If Not FileDelete ( isRepFicOpcon + K_FIC_SORTIE_OPCON ) Then //#1
				iRet = -1
			End If 
		End If 


	CASE "ECR"

		/*------------------------------------------------------------------*/
		/* On est connect$$HEX2$$e9002000$$ENDHEX$$avec OpCon, donc sortie en fichier Erreur.       */
		/*------------------------------------------------------------------*/
		If gbOpCon Then 

			iFicOpcon = FileOpen ( isRepFicOpCon + K_FIC_SORTIE_OPCON , LineMode!, Write!, Shared!, Replace! ) // #1
			FileWrite ( iFicOpcon, String ( aiCodeErreur ) + "|" + asTexte )
			FileClose ( iFicOpcon )

		End If

	// Si fichier Absent alors Ok (iRet = 1)
	CASE "ABSENCE"			
		iRet = 1

//Migration PB8-WYNIWYG-03/2006 CP		
//		If FileExists ( isRepFicOpcon ) Then iRet = -1
		If f_FileExists ( isRepFicOpcon + K_FIC_SORTIE_OPCON  ) Then iRet = -1 // #1
//Fin Migration PB8-WYNIWYG-03/2006 CP		

	// On marque la fin du traitemnt (si pas de traitement)
	CASE "FIN_TRT"			
		iRet = 1
//#1 [DCMP-060643]-19/09/2006-JFF Exeception $$HEX2$$e0002000$$ENDHEX$$la r$$HEX1$$e800$$ENDHEX$$gle pour OpCon
/*
		iFicFinTrt = FileOpen ( ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "OPCON_OUT", & 
										ProfileString ( stGlb.sWinDir + "\MAJPOST.INI", "PARAM", "DESTINATION", "C:" ) + "\" ) + K_FICFINTRT, LineMode!, Write!, Shared!, Replace! )
*/
		iFicFinTrt = FileOpen ( isRepFicOpcon + K_FICFINTRT, LineMode!, Write!, Shared!, Replace! )

		FileClose ( iFicFinTrt )



END CHOOSE



Return iRet
end function

public subroutine uf_lancertrt (string ascas);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_opcon_xps::uf_LancerTrt (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 16/12/2002 11:16:22
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Lancement du traitement
//* Commentaires  : 
//*
//* Arguments     : Val		String		asCas
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//* 		FPI	03/12/2010	[PC175]
//				FPI	18/09/2013	[VDOC12140]
//*-----------------------------------------------------------------

String	sTabNull[]

stGlb.sTab_OpCon_Xps = sTabNull[]

Choose Case asCas

	Case "INT_FIC_ARTICLE"

		/*------------------------------------------------------------------*/
		/* Y a-t-il au moins un fournisseur pour l'int$$HEX1$$e900$$ENDHEX$$gration du fichier   */
		/* article ?                                                        */
		/*------------------------------------------------------------------*/
		If UpperBound ( isTabFrIntArt ) > 0 And This.uf_Sortie_OpCon ( "ABSENCE", 0, "" ) > 0 Then

			/*------------------------------------------------------------------*/
			/*	Afin de pouvoir r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer le tableau arm$$HEX2$$e9002000$$ENDHEX$$sur la fen$$HEX1$$ea00$$ENDHEX$$tre de      */
			/* traitement des articles.                                         */
			/*------------------------------------------------------------------*/
			stGlb.sTab_OpCon_Xps = isTabFrIntArt

			/*------------------------------------------------------------------*/
			/* Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'int$$HEX1$$e900$$ENDHEX$$gration du fichier article.        */
			/* RDV sur l'w_trt_int_fic_article::ue_Initialiser pour la gestion  */
			/* de l'automatisation.															  */
			/*------------------------------------------------------------------*/
			iMenu.Item [ ilMenuIntegration ].Item [ ilMenuInt_StockArticle ].TriggerEvent ( Clicked! )

		Else
			This.uf_Sortie_OpCon ( "FIN_TRT", 0, "" ) 
		End If

	Case "INT_FIC_SUIVICMD"

		/*------------------------------------------------------------------*/
		/* Y a-t-il au moins un fournisseur pour l'int$$HEX1$$e900$$ENDHEX$$gration du fichier   */
		/* Suivi de commandes ?                                             */
		/*------------------------------------------------------------------*/
		If UpperBound ( isTabFrIntSui ) > 0 And This.uf_Sortie_OpCon ( "ABSENCE", 0, "" ) > 0 Then

			/*------------------------------------------------------------------*/
			/*	Afin de pouvoir r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer le tableau arm$$HEX2$$e9002000$$ENDHEX$$sur la fen$$HEX1$$ea00$$ENDHEX$$tre de      */
			/* traitement 																		  */
			/*------------------------------------------------------------------*/
			stGlb.sTab_OpCon_Xps = isTabFrIntSui

			/*------------------------------------------------------------------*/
			/* Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'int$$HEX1$$e900$$ENDHEX$$gration du fichier article.        */
			/* RDV sur l'w_trt_int_fic_SuiviCmd::ue_Initialiser pour la gestion */
			/* de l'automatisation.															  */
			/*------------------------------------------------------------------*/
			iMenu.Item [ ilMenuIntegration ].Item [ ilMenuInt_FichierSuivi ].TriggerEvent ( Clicked! )

		Else
			This.uf_Sortie_OpCon ( "FIN_TRT", 0, "" ) 
		End If

	Case "GEN_FIC_CMD"

		/*------------------------------------------------------------------*/
		/* Y a-t-il au moins un fournisseur pour la g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration des commandes*/
		/*------------------------------------------------------------------*/
		If UpperBound ( isTabFrGenCmd ) > 0 And This.uf_Sortie_OpCon ( "ABSENCE", 0, "" ) > 0 Then

			/*------------------------------------------------------------------*/
			/*	Afin de pouvoir r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer le tableau arm$$HEX2$$e9002000$$ENDHEX$$sur la fen$$HEX1$$ea00$$ENDHEX$$tre de      */
			/* traitement 																		  */
			/*------------------------------------------------------------------*/
			stGlb.sTab_OpCon_Xps = isTabFrGenCmd

			/*------------------------------------------------------------------*/
			/* Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration des commandes.				  */
			/* RDV sur l'w_trt_gen_fic_commande::ue_Initialiser pour la gestion */
			/* de l'automatisation.															  */
			/*------------------------------------------------------------------*/
			iMenu.Item [ ilMenuExtraction ].Item [ ilMenuGen_FichierCommande ].TriggerEvent ( Clicked! )

		Else
			This.uf_Sortie_OpCon ( "FIN_TRT", 0, "" ) 
		End If

	// [PC175]
	Case "INT_FIC_MAG_MCM" // [VDOC12140].MEP case $$HEX2$$e0002000$$ENDHEX$$supprimer lors de la suppr de cl$$HEX1$$e900$$ENDHEX$$
		if This.uf_Sortie_OpCon ( "ABSENCE", 0, "" ) > 0 Then
			iMenu.Item [ ilmenudivers ].Item [ ilmenuintegration_autrefic ].TriggerEvent ( Clicked! )
		Else
			This.uf_Sortie_OpCon ( "FIN_TRT", 0, "" ) 
		End If
	
	 // [VDOC12140]
	Case "INT_FIC_AUTRE" 
		If (UpperBound ( isTabFrIntBtq ) > 0 or UpperBound ( isTabFrTrtImei ) > 0) & 
			And This.uf_Sortie_OpCon ( "ABSENCE", 0, "" ) > 0 Then
			
			// Int$$HEX1$$e900$$ENDHEX$$gration des boutiques
			If UpperBound ( isTabFrIntBtq ) > 0 Then
				stGlb.sTab_OpCon_Xps = isTabFrIntBtq
				stGlb.sMessageErreur="INT_BOUTIQUE" // Traitement $$HEX2$$e0002000$$ENDHEX$$effectuer
				
				iMenu.Item [ ilmenudivers ].Item [ ilmenuintegration_autrefic ].TriggerEvent ( Clicked! )
			End if
		
			// Int$$HEX1$$e900$$ENDHEX$$gration des IMEI
			If UpperBound ( isTabFrTrtImei ) > 0 Then
				stGlb.sTab_OpCon_Xps = isTabFrTrtImei
				stGlb.sMessageErreur="INT_IMEI" // Traitement $$HEX2$$e0002000$$ENDHEX$$effectuer
				
				iMenu.Item [ ilmenudivers ].Item [ ilmenuintegration_autrefic ].TriggerEvent ( Clicked! )
			End if
		
		Else
			This.uf_Sortie_OpCon ( "FIN_TRT", 0, "" ) 
		End If
	
	Case "OK?"

		/*------------------------------------------------------------------*/
		/* Si Tout s'est bien d$$HEX1$$e900$$ENDHEX$$roul$$HEX1$$e900$$ENDHEX$$, donc si pas de fichier de sortie     */
		/* pr$$HEX1$$e900$$ENDHEX$$sent, alors on $$HEX1$$e900$$ENDHEX$$crit le fichier de sortie pour OpCon avec OK  */
		/*------------------------------------------------------------------*/
		If This.uf_Sortie_OpCon ( "ABSENCE", 0, "" ) > 0 Then
			This.uf_Sortie_OpCon ( "ECR", 0, "OK" ) 
		End If

End Choose
end subroutine

private function boolean uf_getprofil ();//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_opcon_xps::uf_GetProfil (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 31/12/2002 10:21:52
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Obtention du profil s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$pour le traitement
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

Boolean	bOk
Int		iFicGetProfil 	// Fichier d'obtention du profil
String	sProfil 			// Fichier de profil
String	sRepProfil 		// R$$HEX1$$e900$$ENDHEX$$pertoire des profil Opcon

bOk = True

//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//iFicGetProfil = FileOpen ( stGlb.sWinDir + K_FIC_PROFIL, LineMode!, Read!, Shared!, Append! )
//#2 [DCMP-060643]-19/09/2006-JFF Exeception $$HEX2$$e0002000$$ENDHEX$$la r$$HEX1$$e800$$ENDHEX$$gle pour OpCon
iFicGetProfil = FileOpen ( isRepFicOpcon + K_FIC_PROFIL, LineMode!, Read!, Shared!, Append! )

If iFicGetProfil < 0 Then Return False

FileRead ( iFicGetProfil, sProfil )

If IsNull ( sProfil ) Or sProfil = "" Then Return False

sProfil = Trim ( sProfil )

sRepProfil = ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "PROFIL_AUTO", "" )

If IsNull ( sRepProfil ) Or sRepProfil = "" Then Return False

/*------------------------------------------------------------------*/
/* Fichier profil ex : K:\SIMPA2\OPCONXPS\JOBMIDI.INI               */
/*------------------------------------------------------------------*/
isRepFicProfilIni = Upper ( sRepProfil + sProfil + ".INI" )

Return bOk
end function

on n_cst_opcon_xps.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_opcon_xps.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

