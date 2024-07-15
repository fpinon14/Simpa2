HA$PBExportHeader$n_cst_int_fic_article.sru
$PBExportComments$Objet g$$HEX1$$e900$$ENDHEX$$rant l'int$$HEX1$$e900$$ENDHEX$$gration du fichier article
forward
global type n_cst_int_fic_article from nonvisualobject
end type
end forward

global type n_cst_int_fic_article from nonvisualobject
end type
global n_cst_int_fic_article n_cst_int_fic_article

type variables
Private :

Datawindow	idwFourn
Datawindow	idwFicFourn
Datawindow	idwSuiviTrt
Datawindow	idwArtSpb
Datawindow	idwArticle
Datawindow	idwTri
Datawindow	idwStkRepFourn

StaticText	istxtNomFic	
ListBox		ilbListeFic

String		K_FIC       = "STK"
String		K_FICLOG = "FIC_ART.LOG"
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//String		K_FICTMP = "\TEMP\FICFOURN.TXT"
String		K_FICTMP = "FICFOURN.TXT"
String		K_FIC_SORTIE_OPCON = "ERRSP2.DAT"
//String		K_FIC_FIN_OPCO = "\TEMP\FINOPCO"
String		K_FICFINTRT = "FIN_TRT"
String		K_FICTMP2 = "FICFOURN_TMP.TXT"  //* [PC874]

String  		isRepFicOpCon	
String 		isTabFrIntArt[]   
String 		isNomTrace2
String 		isIdFour  // [PI065]
String 		isIdTypMvt  // [PI065]
String 		isNomFicOrig // [PI065]

Boolean		ibErrIntegr // [PI065]

Int			iiFicTrc
	
Long 			ilIdLotLog // [PI065]

Long 			ilNumLigErrImport
String 		isColLigErrImport // [PI065]
String 		isDataErrImport // [PI065]


end variables

forward prototypes
public subroutine uf_preparer ()
public subroutine uf_bouton_chxfichier ()
public function integer uf_controler_saisie ()
public function integer uf_lancer_trt ()
private function long uf_charger_fichierfourn ()
private function integer uf_ctrl_fichier_fournisseur ()
private function integer uf_integration_fichier_fournisseur ()
public subroutine uf_initialiser (ref s_pass astpass, ref statictext astxtnomfic, ref listbox alblistefic)
private function integer uf_purge_fichier_auto (string aidfourn)
private function integer uf_sortie_opcon (string ascas, integer aicodeerreur, string astexte, boolean abbox)
public function integer uf_trt_opcon (string ascas)
private function integer uf_ctrl_fichier_dme ()
private function integer uf_ctrl_fichier_darty ()
private function integer uf_trace (string ascas, string astexte)
private function integer uf_trace_2 (string ascas, integer aicodetat, string asidfour, string asidreffour, string asidmarqart, string asidmodlart, string astexte)
private subroutine uf_mail_cr_integration (integer ainbmaj, integer ainbinsert, integer ainbsupp)
private function integer uf_integration_fichier_darty (ref long alnblig, ref long alnbinsert, long alnbdelete)
private function integer uf_integration_fichier_dme (ref long alnblig, ref long alnbinsert, ref long alnbdelete)
private function integer uf_ctrl_fichier_cegetel ()
private function integer uf_integration_fichier_cegetel (ref long alnblig, ref long alnbinsert, ref long alnbdelete)
private function integer uf_integration_fichier_mobistore (ref long alnblig, ref long alnbinsert, long alnbdelete)
private function integer uf_ctrl_fichier_mobistore ()
private function integer uf_ctrl_fichier_cordon ()
public function integer uf_controler_monnaie_fichier (string asunt_monnaie, integer alcpt)
private function integer uf_ctrl_fichier_phoneandphone ()
private function integer uf_integration_fichier_phoneandphone (ref long alnblig, ref long alnbinsert, ref long alnbdelete)
private function string uf_correspondance_code (string asidfour, string ascas, string asvalrech)
private function integer uf_ctrl_fichier_carrefour ()
private function integer uf_integration_fichier_carrefour (ref long alnblig, ref long alnbinsert, ref long alnbdelete)
private function integer uf_ctrl_fichier_o2m ()
private function integer uf_integration_fichier_o2m (string ascas, ref long alnblig, ref long alnbinsert, ref long alnbdelete)
private function integer uf_ctrl_fichier_coriolis ()
private function integer uf_integration_fichier_coriolis (string ascas, ref long alnblig, ref long alnbinsert, ref long alnbdelete)
private function integer uf_ctrl_fichier_converlance ()
private function integer uf_integration_fichier_converlance (ref long alnblig, ref long alnbinsert, ref long alnbdelete)
private function integer uf_ctrl_fichier_ore ()
private function boolean uf_check_montant (string asval, ref string aserr)
private function integer uf_integration_fichier_ore (ref long alnblig, ref long alnbinsert, ref long alnbdelete)
private function integer uf_ctrl_fichier_omt ()
private function integer uf_integration_fichier_omt (ref long alnblig, ref long alnbinsert, ref long alnbdelete)
private function integer uf_ctrl_fichier_mtt ()
private function integer uf_integration_fichier_mtt (ref long alnblig, ref long alnbinsert, ref long alnbdelete)
private function integer uf_ctrl_fichier_srr ()
private function integer uf_integration_fichier_srr (ref long alnblig, ref long alnbinsert, ref long alnbdelete)
public function string uf_detection_auto_nomfic (string aidfourn, string ascas)
private function integer uf_transformationseparateur (string asfichiersource, string asseporig, string assepsubst, string ascas)
private function integer uf_ctrl_fichier_pp_orange ()
private function integer uf_integration_fichier_pp_orange (ref long alnblig, ref long alnbinsert, ref long alnbdelete)
private function integer uf_ctrl_fichier_pp_bouygues ()
private function integer uf_integration_fichier_pp_bouygues (ref long alnblig, ref long alnbinsert, ref long alnbdelete)
private function integer uf_ctrl_fichier_atech ()
private function integer uf_integration_fichier_atech (ref long alnblig, ref long alnbinsert, ref long alnbdelete)
private function integer uf_ctrl_fichier_boost ()
private function integer uf_integration_fichier_boost (ref long alnblig, ref long alnbinsert, ref long alnbdelete)
private function integer uf_ctrl_fichier_bak2 ()
private function integer uf_integration_fichier_bak2 (ref long alnblig, ref long alnbinsert, ref long alnbdelete)
private function integer uf_ctrl_fichier_rt_bouygues ()
private function integer uf_integration_fichier_rt_bouygues (ref long alnblig, ref long alnbinsert, ref long alnbdelete)
private function integer uf_ctrl_fichier_agora_place ()
private function integer uf_integration_fichier_agora_place (string ascas, ref long alnblig, ref long alnbinsert, ref long alnbdelete)
private function integer uf_ctrl_fichier_cdiscountpro ()
private function integer uf_integration_fichier_cdiscountpro (string ascas, ref long alnblig, ref long alnbinsert, ref long alnbdelete)
public function long uf_charger_fichierfournhalt (long alnumligerrimport, string ascolligerrimport, string asdata)
public subroutine uf_set_numligerrimport (long alnumligerrimport, string ascolligerrimport, string asdataerrimport)
end prototypes

public subroutine uf_preparer ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Preparer (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Preparer avant traitement
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//        JFF   02/03/2015   [PM289_CDP]
//        JFF   21/03/2017 [PI065]
//*-----------------------------------------------------------------

DatawindowChild 	dwChild


/*------------------------------------------------------------------*/
/* Pr$$HEX1$$e900$$ENDHEX$$paration dw fournisseur.                                      */
/*------------------------------------------------------------------*/
idwFourn.Reset ()
idwFourn.InsertRow ( 0 )
idwFourn.GetChild ( "ID_FOURN", dwChild )

isIdFour = "" // [PI065]
isIdTypMvt = "ART" // [PI065]
ilIdLotLog = -1 // [PI065]
ibErrIntegr = False // [PI065]
isNomFicOrig = "" // [PI065]

If dwChild.Rowcount () = 1 Then 
	idwFourn.SetItem ( 1, "ID_FOURN", dwChild.GetItemString ( 1, "ID_CODE" ) )
 	This.uf_Detection_Auto_NomFic ( dwChild.GetItemString ( 1, "ID_CODE" ), "NORMAL" ) // [PM289_CDP]	
End If

/*------------------------------------------------------------------*/
/* Chargement de la liste des articles $$HEX2$$e0002000$$ENDHEX$$chaque fois, car elle      */
/* peut changer.                                                    */
/* Cette liste servira de contr$$HEX1$$f400$$ENDHEX$$le.                                 */
/*------------------------------------------------------------------*/
idwArtSpb.Retrieve ( "-AR" )




end subroutine

public subroutine uf_bouton_chxfichier ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Bouton_ChxFichier (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Choix du fichier manuellement
//* Commentaires	: 
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    30/08/2002  Le nom du r$$HEX1$$e900$$ENDHEX$$pertoire de g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration n'est plus le code
//*								  du fournisseur -FR mais le nom complet (<8 car) -FL
//* 
//*-----------------------------------------------------------------

String 	sNomComplet, sNomFic, sIdFourn, sRepFourn
String	sRepFicArt, sNomFicArt, sJoker
Int		iRetour
Long 		lRow
			
idwFourn.AcceptText ()

sIdFourn = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sRepFourn = ""

/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
lRow = idwStkRepFourn.Find ( "ID_CODE = '" + sIdFourn + "'", 1, idwStkRepFourn.RowCount () )
If lRow > 0 Then
	sRepFourn = Upper ( idwStkRepFourn.GetItemString ( lRow, "LIB_CODE" ) )
End If

If sRepfourn = "" Then
	sRepFicArt =  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_GEN", "" ) 
Else
	sRepFicArt =  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_GEN", "" ) + &
					  sRepFourn  + &
					  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_FIC_ART", "" )

End If

sNomFicArt = K_FIC + &
			 String ( Day   ( Today () ), "00" ) + &
			 String ( Month ( Today () ), "00" ) + &
			 Right  ( String ( Year  ( Today () ) ), 1 )

sJoker = sNomFicArt + ".*"
sNomComplet = Left ( sRepFicArt, Len ( sRepFicArt ) -1 )

iRetour = GetFileSaveName( "Fichier Aticles/Stocks", sNomComplet, sNomFic, "", &
									"Du jour (" + sJoker + ")," + sJoker + "," + &
									"Non Trait$$HEX2$$e9002000$$ENDHEX$$(STK*.0*),STK*.0*," + &
									"Tous (STK*.*),STK*.*," + &
									"Tous Fichiers (*.*),*.*")

If iRetour = 0 Then 
	isTxtNomFic.Text = ""
ElseIf iRetour = 1 Then
	isTxtNomFic.Text = sNomComplet 
End If


end subroutine

public function integer uf_controler_saisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Controler_Saisie (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler de la saisie
//* Commentaires	: 
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    30/08/2002  Le nom du r$$HEX1$$e900$$ENDHEX$$pertoire de g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration n'est plus le code
//* 
//*-----------------------------------------------------------------

Int iRet
String	sIdFourn, sNomFic, sRepFicArt, sVal, sRepFourn
Long 	   lRow

iRet = 1

/*------------------------------------------------------------------*/
/* 1 : Le fournisseur est-il renseign$$HEX2$$e9002000$$ENDHEX$$?                            */
/*------------------------------------------------------------------*/
sIdfourn = idwFourn.GetItemString ( 1, "ID_FOURN" ) 
If IsNull ( sIdFourn ) Then 
	stMessage.sTitre = "Controle de saisie"
	stMessage.sCode = "COMD002"
	stMessage.icon = Information!

	This.uf_Sortie_OpCon ( "ECR", 10, "ERR10/CTRLSAI/1", TRUE )
	iRet = -1
End If

/*------------------------------------------------------------------*/
/* 2 : Le Nom du fichier est-il renseign$$HEX2$$e9002000$$ENDHEX$$?                         */
/*------------------------------------------------------------------*/
If iRet > 0 Then 
	sNomFic = isTxtNomFic.Text
	If IsNull ( sNomFic ) Or sNomFic = "" Then 
		stMessage.sTitre = "Controle de saisie"
		stMessage.sCode = "COMD003"
		stMessage.icon = Information!
	
		This.uf_Sortie_OpCon ( "ECR", 20, "ERR20/CTRLSAI/2", TRUE )
		iRet = -1
	End If
End If

/*------------------------------------------------------------------*/
/* 3 : Le Nom du fichier est-il correct par rapport au fournisseur  */
/*------------------------------------------------------------------*/
If iRet > 0 Then 

	/*------------------------------------------------------------------*/
	/* #1                                                               */
	/*------------------------------------------------------------------*/
	lRow = idwStkRepFourn.Find ( "ID_CODE = '" + sIdFourn + "'", 1, idwStkRepFourn.RowCount () )
	If lRow > 0 Then
		sRepFourn = Upper ( idwStkRepFourn.GetItemString ( lRow, "LIB_CODE" ) )

		sRepFicArt =  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_GEN", "" ) + &
						  sRepFourn + &
						  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_FIC_ART", "" )	

		If Pos ( Upper(sNomFic), Upper(sRepFicArt), 1 ) <= 0 Then // [PC767] On ne tient pas compte de la casse du r$$HEX1$$e900$$ENDHEX$$pertoire
			stMessage.sTitre = "Controle de saisie"
			stMessage.sCode = "COMD004"
			stMessage.icon = Information!
	
			This.uf_Sortie_OpCon ( "ECR", 30, "ERR30/CTRLSAI/3", TRUE )
			iRet = -1
		End If
	End If
End If

/*------------------------------------------------------------------*/
/* 4 : Le Nom du fichier n'est pas $$HEX2$$e0002000$$ENDHEX$$la date du jour.					  */
/*------------------------------------------------------------------*/
/* Le 20/11/2001, JFF : Pour l'instant, je shunt ce contr$$HEX1$$f400$$ENDHEX$$le sans   */
/* supprimer le code, en effet cette box "trouble" l'$$HEX1$$e900$$ENDHEX$$quipe ADD.    */
/*------------------------------------------------------------------*/

//If iRet > 0 Then 
//
//	// sur ...\STK31081.009 on obtient 31081
//	sVal = Right ( Left ( Right ( sNomFic, 12 ), 8 ), 5 )
//	sVal = Left ( sVal, 2) + "/" + Mid ( sVal, 3, 2) + "/200" + Right ( sVal, 1 )
//
//	If Date ( sVal ) <> Today () Then
//		stMessage.sTitre = "Controle de saisie"
//		stMessage.sCode = "COMD007"
//		stMessage.icon = Exclamation!
//		stMessage.bouton = YesNo!
//		If F_Message ( stMessage ) = 2 Then iRet = -1
//	End If
//
//End If

/*------------------------------------------------------------------*/
/* 5 : Le Fichier a d$$HEX1$$e900$$ENDHEX$$j$$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$trait$$HEX1$$e900$$ENDHEX$$.										  */
/*------------------------------------------------------------------*/
If iRet > 0 Then 

	If Upper ( Mid ( isTxtNomFic.Text, Len ( isTxtNomFic.Text ) - 2, 1 ) ) = "X" Then

		stMessage.sTitre = "Controle de saisie"
		stMessage.sCode = "COMD010"
		stMessage.icon = Exclamation!
		stMessage.bouton = Ok!

		This.uf_Sortie_OpCon ( "ECR", 50, "ERR50/CTRLSAI/5", TRUE )
		iRet = -1
	End If



End If



return iRet
end function

public function integer uf_lancer_trt ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Lancer_Trt (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 31/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Lancement du Traitement
//* Commentaires	: 
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     		Modification
//* #1 	 DGA      19/09/2006    Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire DCMP-060643
//*       JFF      02/03/2015 	[PM289_CDP]
//        JFF      21/03/2017 [PI065]
//*-----------------------------------------------------------------

Int		iRet
String	sNomFic, sIdFourn
Long		lTotLig

iRet = 1

sIdFourn = idwFourn.GetItemString ( 1, "ID_FOURN" )
isIdFour = sIdFourn // [PI065]

/*------------------------------------------------------------------*/
/* Initialisation de la trace.                                      */
/*------------------------------------------------------------------*/
If uf_Trace ( "INIT", "") <= 0 Then iRet = -1

// [PI065]
This.uf_Trace ( "ECR", "Num$$HEX1$$e900$$ENDHEX$$ro de lot d'int$$HEX1$$e900$$ENDHEX$$gration : " + String ( ilIdLotLog ) )

/*------------------------------------------------------------------*/
/* Purge des fichiers du mois pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dent.                            */
/*------------------------------------------------------------------*/
This.uf_Purge_Fichier_Auto ( sIdFourn )

/*------------------------------------------------------------------*/
/* Chargement du fichier fournisseur.                               */
/*------------------------------------------------------------------*/
If iRet > 0 Then
	If uf_Charger_FichierFourn () <= 0 Then 
		iRet = -1
		This.uf_Sortie_OpCon ( "ECR", 70, "ERR70/CHARGFICFOUR", FALSE )						
	End If
End If

/*------------------------------------------------------------------*/
/* Contr$$HEX1$$f400$$ENDHEX$$le de la validit$$HEX2$$e9002000$$ENDHEX$$du fichier fournisseur.                  */
/*------------------------------------------------------------------*/
If iRet > 0 Then
	If uf_Ctrl_Fichier_Fournisseur () <= 0 Then iRet = -1
End If

/*------------------------------------------------------------------*/
/* Int$$HEX1$$e900$$ENDHEX$$gration du fichier fournisseur dans la base.                 */
/*------------------------------------------------------------------*/
If iRet > 0 Then
	If uf_Integration_Fichier_Fournisseur () <= 0 Then iRet = -1
End If

If iRet <= 0 Then 
	This.uf_Trace ( "ECR", "Le traitement se termine anormalement, le fichier n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$trait$$HEX2$$e9002000$$ENDHEX$$!!!." )
Else
	This.uf_Trace ( "ECR", "Le traitement se termine normalement, le fichier a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$trait$$HEX1$$e900$$ENDHEX$$." )
End If

idwSuiviTrt.ScrollToRow ( idwSuiviTrt.RowCount () )

/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$truit le fichier temporaire.                                */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//If FileExists ( stGlb.sWinDir + K_FICTMP ) Then FileDelete ( stGlb.sWinDir + K_FICTMP )
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//If f_FileExists ( stGlb.sWinDir + K_FICTMP ) Then FileDelete ( stGlb.sWinDir + K_FICTMP )
If f_FileExists ( stGLB.sRepTempo + K_FICTMP ) Then FileDelete ( stGLB.sRepTempo + K_FICTMP )
//Fin Migration PB8-WYNIWYG-03/2006 CP

/*------------------------------------------------------------------*/
/* Enfin on regarde si un autre fichier est $$HEX2$$e0002000$$ENDHEX$$traiter.              */
/*------------------------------------------------------------------*/
// [PM289_CDP]
Choose Case sIdFourn
	Case "CDP"
		This.uf_Detection_Auto_NomFic ( sIdFourn, "CAS_CDP" ) // [PM289_CDP]				
	Case Else
		This.uf_Detection_Auto_NomFic ( sIdFourn, "NORMAL" ) // [PM289_CDP]				
End Choose

Return iRet
end function

private function long uf_charger_fichierfourn ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Charger_FichierFourn (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 31/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Chargement du fichier fournisseur
//* Commentaires	: 
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF  	04/04/2003 Ajout du fournisseur DEBITEL/DDF  
//* #2    MADM    07/03/2006 Ajout du fournisseur BRIGHTPOINT/BTP 
//* #3 	 DGA     19/09/2006 Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire DCMP-060643
//* #4	 JFF     18/09/2007 [ALAPAGE]
//* #5    JFF     16/04/2009 [DCMP090102]
//* #6    JFF     13/05/2009 [DCMP090140]
//* #7    JFF     18/06/2009 [MOBISTORE_CYBERPHONE]
//*		 FPI		29/09/2010 [PC514] Ajout du fournisseur 'ACU'
//* 		 JFF     04/11/2010 [PC301].[LOT2]
//* 		 JFF     03/05/2011 [PM166][O2M]
//* 		 JFF     03/05/2011 [PM178][CORIOLIS]
//			FPI	27/06/2011	[PC10-2] Converlance
//			FPI	21/08/2012	[PC767] Orange R$$HEX1$$e900$$ENDHEX$$union
//			JFF	03/09/2012	[PC853]
//			FPI	19/02/2013	[PC874]
//       JFF   30/12/2013  [PC13348&13408]
//			FPI	11/02/2014	[PC925]
//       JFF   07/05/2013  [PC938_ORANGE_V3]
//       JFF   28/09/2015 [PM319-1]
//       JFF   05/10/2015 [PM319-2]
//		FPI	05/11/2015	[VDOC18821] on transforme OMT en Tab-separated
//		FPI	25/11/2015 [PC13442-2]
//       JFF   21/03/2016 [PM289-3]
//       JFF   28/06/2016 [PC151549]
//       JFF   11/10/2016 [DT076-2]
//       JFF   21/03/2017 [PI065]
//		   FPI	15/09/2017 [DT328-1]
//       JFF   17/09/2018 [PM444-1]
//       JFF   10/02/2020 [PM289-5]
//*-----------------------------------------------------------------

Int		iRet
String	sIdFourn, sNomFicOrig, sNomFicTmp
Long		lTotLig
Blob		blBlob

iRet = 1

sIdFourn = idwFourn.GetItemString ( 1, "ID_FOURN" )
sNomFicOrig = isTxtNomFic.Text
isNomFicOrig = sNomFicOrig // [PI065]
idwFicFourn.Reset ()
idwFicFourn.DataObject = ""

This.uf_Trace ( "ECR", "R$$HEX1$$e900$$ENDHEX$$vision SVN : " + stGLB.sRevisionSvn )

This.uf_Trace ( "ECR", "Fournisseur s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$: (" + sIdFourn + ") " + &
								Upper ( idwFourn.Describe ( "Evaluate ( 'LookUpDisplay ( ID_FOURN )', 1 )" ) ) )
This.uf_Trace ( "ECR", "Fichier s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$: " + Upper ( sNomFicOrig ) )

/*------------------------------------------------------------------*/
/* Recopie du fichier original en un fichier temporaire en local    */
/* dont l'ext. est "TXT".                                           */
/*------------------------------------------------------------------*/
F_LireFichierBlob ( blBlob, sNomFicOrig ) 
/*------------------------------------------------------------------*/  
/* #3. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sNomFicTmp = stGlb.sWinDir + K_FICTMP
sNomFicTmp = stGLB.sRepTempo + K_FICTMP
F_EcrireFichierBlob ( blBlob, sNomFicTmp ) 

/*------------------------------------------------------------------*/
/* Choix du dataobject (format du fichier), en fonction du          */
/* fournisseur, en effet le fichier peut $$HEX1$$ea00$$ENDHEX$$tre diff$$HEX1$$e900$$ENDHEX$$rent d'un        */
/* fournisseur $$HEX2$$e0002000$$ENDHEX$$l'autre.                                           */
/*------------------------------------------------------------------*/
CHOOSE CASE Upper ( sIdFourn )
	
	/*------------------------------------------------------------------*/
	/* Fournisseur : ORANGE/DME													  */
	/*------------------------------------------------------------------*/
	CASE "DME"
		idwFicFourn.DataObject = "d_trt_int_fic_article_DME"

	/*------------------------------------------------------------------*/
	/* Fournisseur : DARTY/DTY												  		  */
	/*------------------------------------------------------------------*/
	CASE "DTY"
		idwFicFourn.DataObject = "d_trt_int_fic_article_DARTY"

	/*------------------------------------------------------------------*/
	/* Fournisseur : SFR-CEGETEL/CEG												  */
	/*------------------------------------------------------------------*/
	CASE "CEG"
		idwFicFourn.DataObject = "d_trt_int_fic_article_CEGETEL"

 	/*------------------------------------------------------------------*/
	/* Fournisseur : MOBISTORE/MBS	 											  */
	/*------------------------------------------------------------------*/
	CASE "MBS"
		idwFicFourn.DataObject = "d_trt_int_fic_article_MOBISTORE"

	//* #5 [DCMP090102]
	CASE "CDP"
		
		// [PC938_ORANGE_V3]
		// [PM289-3]
		
		// [PM289-5]
		idwFicFourn.DataObject = "d_trt_int_fic_article_cdiscountpro_pm289_5"
		
		If This.uf_TransformationSeparateur ( sNomFicTmp, ";", "~t", "CAS_CDP" ) < 0 Then
			This.uf_Trace ( "ECR", "ERREUR : Erreur lors de la substition du s$$HEX1$$e900$$ENDHEX$$parateur" )
			Return -1
		End If


	//* #6 [DCMP090140]
	CASE "PAP"
		
		idwFicFourn.DataObject = "d_trt_int_fic_article_phoneandphone"

	// [PC301].[LOT2]
	CASE "CAR"
		idwFicFourn.DataObject = "d_trt_int_fic_article_carrefour"

	// [PM166][O2M]
	CASE "O2M"
		idwFicFourn.DataObject = "d_trt_int_fic_article_O2M"

	//[PM178][CORIOLIS]
	CASE "CIS"
		idwFicFourn.DataObject = "d_trt_int_fic_article_CORIOLIS"
	
	//[PC10-2]
	CASE "CVC"
		idwFicFourn.DataObject = "d_trt_int_fic_article_CONVERLANCE"
	
	//[PC767]
	CASE "ORE"
		idwFicFourn.DataObject = "d_trt_int_fic_article_ORE"
	
	//[PC874]
	CASE "OMT"
		idwFicFourn.DataObject = "d_trt_int_fic_article_OMT"

	// [PC13348&13408]
	CASE "MTT"
		idwFicFourn.DataObject = "d_trt_int_fic_article_MTT"

	// [PC925]
	CASE "SRR"
		idwFicFourn.DataObject = "d_trt_int_fic_article_SRR"

	// [PM319-1]
	CASE "PPO" 
		idwFicFourn.DataObject = "d_trt_int_fic_article_PP_ORANGE"

	// [PM319-2]
	CASE "PPB" 
		idwFicFourn.DataObject = "d_trt_int_fic_article_PP_BOUYGUES"
		
	//[PC13442-2]
	CASE "ATC"
		idwFicFourn.DataObject = "d_trt_int_fic_article_ATECH"

	//[PC151549]
	CASE "BST"
		idwFicFourn.DataObject = "d_trt_int_fic_article_BOOST"
	
	//[DT076-2]
	CASE "BK2"
		idwFicFourn.DataObject = "d_trt_int_fic_article_BAK2"

	// [DT328-1]
	CASE "RTB"
		idwFicFourn.DataObject = "d_trt_int_fic_article_rt_bouygues"

	// [PM444-1]
	CASE "AGP"
		idwFicFourn.DataObject = "d_trt_int_fic_article_agora_place"

	CASE Else

		This.uf_Trace ( "ECR", "ERREUR : Ce fournisseur n'est pas d$$HEX1$$e900$$ENDHEX$$clar$$HEX2$$e9002000$$ENDHEX$$dans le programme, il faut modifier le code pour ajouter son traitement" ) 
		Return -1

END CHOOSE

/*------------------------------------------------------------------*/
/* Chargement du fichier.                                           */
/*------------------------------------------------------------------*/
Choose Case  Upper ( sIdFourn )
	Case "ORE" // [PC767] 	
		lTotLig = idwFicFourn.ImportFile ( CSV!, sNomFicTmp,2 )
	Case  "OMT", "RTB"   // [PC874] // [DT328-1]
		// [VDOC18821] on le transforme en Tab-separated
		uf_transformationseparateur( sNomFicTmp, ";", "	", "NORMAL")
		lTotLig = idwFicFourn.ImportFile ( Text!, sNomFicTmp) 
	Case Else
		lTotLig = idwFicFourn.ImportFile ( sNomFicTmp )
End Choose


// If lTotLig <= 0 Then [20221221161945610]
If lTotLig < -1 Then	
	iRet = -1
	ibErrIntegr = True // [PI065]
	This.uf_Trace ( "ECR", "Chargement du fichier : ERREUR IMPORTFILE (" + String ( lTotLig ) + ") ligne " + string (ilNumLigErrImport) + ", colonne " + Upper ( isColLigErrImport ) + ", probl$$HEX1$$e800$$ENDHEX$$me de format de fichier, une donn$$HEX1$$e900$$ENDHEX$$e n'est pas du bon type ou est trop longue."  ) // [PI065]
	This.uf_Trace ( "ECR", "Chargement du fichier : Text posant probl$$HEX1$$e800$$ENDHEX$$me : " + Trim ( isDataErrImport )  ) // [PI065]
Else
	// [20221221161945610]
	If lTotLig <= 0 Then lTotLig = 0 
	
	This.uf_Trace ( "ECR", "Chargement du fichier : " + String ( lTotLig ) + " ligne(s)"  )
End If

Return iRet
end function

private function integer uf_ctrl_fichier_fournisseur ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Crtl_Fichier_Fournisseur (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler de la validit$$HEX2$$e9002000$$ENDHEX$$du fichier fournisseur
//* Commentaires	: 
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF  	04/04/2003 Ajout du fournisseur DEBITEL/DDF  
//* #2    MADM  	07/03/2006 Ajout du fournisseur BRIGHTPOINT/BTP   
//* #3	 JFF     28/09/2007 [ALAPAGE]
//* #4    JFF     16/04/2009 [DCMP090102]
//* #5    JFF     17/04/2009 [DCMP090140]
//* #6    JFF     18/06/2009 [MOBISTORE_CYBERPHONE]
//*		 FPI	   29/09/2010 [PC514] Ajout de ACU
//* 		 JFF     04/11/2010 [PC301].[LOT2]
//* 		 JFF     03/05/2011 [PM166][O2M]
//* 		 JFF     03/05/2011 [PM178][CORIOLIS]
//			FPI	27/06/2011	[PC10-2] Converlance
//			FPI	21/08/2012	[PC767] Orange R$$HEX1$$e900$$ENDHEX$$union
//			JFF	03/09/2012	[PC853]
//			FPI	19/02/2013	[PC874]
//       JFF   30/12/2013  [PC13348&13408]
//			FPI	11/02/2014	[PC925]
//       JFF   28/09/2015  [PM319-1]
//       JFF   05/10/2015  [PM319-2]
// 		FPI	25/11/2015	[PC13442-2]
//       JFF   28/06/2016  [PC151549]
//       JFF   11/10/2016  [DT076-2]
//       JFF   21/03/2017 [PI065]
//       JFF   17/09/2018 [PM444-1]
//*-----------------------------------------------------------------

Int iRet 
String	sIdFourn

iRet = 1

sIdFourn = idwFourn.GetItemString ( 1, "ID_FOURN" )

CHOOSE CASE Upper ( sIdFourn )

	/*------------------------------------------------------------------*/
	/* Fournisseur : ORANGE/DME			                                */
	/*------------------------------------------------------------------*/
	CASE "DME"
		iRet = This.uf_Ctrl_Fichier_DME ()

	/*------------------------------------------------------------------*/
	/* Fournisseur : DARTY/DTY					                             */
	/*------------------------------------------------------------------*/
	CASE "DTY"
		iRet = This.uf_Ctrl_Fichier_Darty ()

	/*------------------------------------------------------------------*/
	/* Fournisseur : CEGETEL/CEG								  					  */
	/*------------------------------------------------------------------*/
	CASE "CEG"
		iRet = This.uf_Ctrl_Fichier_CEGETEL ()

	/*------------------------------------------------------------------*/
	/* Fournisseur : MOBISTORE														  */
	/*------------------------------------------------------------------*/
	CASE "MBS"
		iRet = This.uf_Ctrl_Fichier_MOBISTORE ()

	/*------------------------------------------------------------------*/
	/* #4 [DCMP090102] 																  */
	/*------------------------------------------------------------------*/
	CASE "CDP"
		// [PM289_CDP]
		iRet = This.uf_Ctrl_Fichier_CDISCOUNTPRO ()
		
	/*------------------------------------------------------------------*/
	/* #5 [DCMP090140] 																  */
	/*------------------------------------------------------------------*/
	CASE "PAP"
		iRet = This.uf_Ctrl_Fichier_PHONEANDPHONE ()

	// [PC301].[LOT2]
	CASE "CAR"
		iRet = This.uf_Ctrl_Fichier_CARREFOUR ()

	// [PM166][O2M]
	CASE "O2M"
		iRet = This.uf_Ctrl_Fichier_O2M ()

	// [PM178][CORIOLIS]
	CASE "CIS"
		iRet = This.uf_Ctrl_Fichier_CORIOLIS ()

	// [PC10-2]
	CASE "CVC"
		iRet = This.uf_Ctrl_Fichier_CONVERLANCE ()

	// [PC767]
	CASE "ORE"
		iRet = This.uf_Ctrl_Fichier_ORE( )

	// [PC874]
	CASE "OMT"
		iRet = This.uf_Ctrl_Fichier_OMT( )
		
	// [PC13348&13408]
	CASE "MTT"
		iRet = This.uf_Ctrl_Fichier_MTT( )

	// [PC925]
	CASE "SRR"
		iRet = This.uf_Ctrl_Fichier_SRR( )

	// [PM319-1]
	CASE "PPO"
		iRet = This.uf_Ctrl_Fichier_PP_Orange ()

	// [PM319-2]
	CASE "PPB"
		iRet = This.uf_Ctrl_Fichier_PP_Bouygues ()

	// [PC13442-2]
	CASE "ATC"
		iRet = This.uf_Ctrl_Fichier_Atech( )

   // [PC151549]
	CASE "BST"
		iRet = This.uf_Ctrl_Fichier_BOOST ( )

	// [DT076-2]
	CASE "BK2"
		iRet = This.uf_Ctrl_Fichier_BAK2 ( )

	// [DT328-1]
	CASE "RTB"
		iRet = This.uf_Ctrl_Fichier_rt_bouygues ( )

	// [PM444-1]
	CASE "AGP"
		iRet = This.uf_Ctrl_Fichier_Agora_Place ( )
		
		
END CHOOSE

If iRet < 0 Then 
	stMessage.sTitre = "Chargement Fichier Fournisseur"
	stMessage.sCode = "COMD006"
	stMessage.icon = Exclamation!
	ibErrIntegr = True // [PI065]
	This.uf_Sortie_OpCon ( "ECR", 80, "ERR80/CHARGFICFOUR", TRUE )								
End If

Return iRet

end function

private function integer uf_integration_fichier_fournisseur ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Integration_Fichier_Fournisseur (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 31/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Int$$HEX1$$e900$$ENDHEX$$gration du fichier fournisseur dans la base.
//* Commentaires	: 
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF  	04/04/2003 Ajout du fournisseur DEBITEL/DDF   
//* #2    MADM  	07/03/2006 Ajout du fournisseur BRIGHTPOINT/BTP
//* #3	 JFF     18/09/2007 [ALAPAGE]
//* #4    JFF     16/04/2009 [DCMP090102]
//* #5    JFF     16/04/2009 [DCMP090140]
//* #6    JFF     18/06/2009 [MOBISTORE_CYBERPHONE]
//* 		 FPI	   29/09/2010 [PC514] Ajout ACU
//* 		 JFF     04/11/2010 [PC301].[LOT2]
//* 		 JFF     03/05/2011 [PM166][O2M]
//* 		 JFF     03/05/2011 [PM178][CORIOLIS]
// 			FPI	25/07/2011	 [ITSM75595] Correction r$$HEX1$$e900$$ENDHEX$$init des compteurs d'insert/delete
//			FPI	27/06/2011	[PC10-2] Converlance
//			FPI	21/08/2012	[PC767] Orange R$$HEX1$$e900$$ENDHEX$$union
//			JFF	03/09/2012	[PC853]
//			FPI	19/02/2013	[PC874]
//       JFF   30/12/2013  [PC13348&13408]
//			FPI	11/02/2014	[PC925]
//       JFF   28/09/2015  [PM319-1]
//       JFF   05/10/2015  [PM319-2]
//       JFF   11/10/2016  [DT076-2]
//			FPI	15/09/2017	 [DT328-1]
//       JFF   17/09/2018 [PM444-1]
//*-----------------------------------------------------------------

Int iRet 
String	sIdFourn, sNomFicOrig, sNomFicRen
Long		lNbInsert, lNbLig, lNbDelete, lNbInsert2, lNbLig2, lNbDelete2
Boolean	bRet
Blob		blBlob
iRet = 1

sIdFourn = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )

/*------------------------------------------------------------------*/
/* Je verrouille imm$$HEX1$$e900$$ENDHEX$$diatement toute les lignes, afin que           */
/* personnes d'autres ne viennent les modifier pendant le  			  */
/*	traitement, bien entendu je ne commit pas maintenant !.			  */
/*------------------------------------------------------------------*/
F_Execute ( "Execute sysadm.PS_U01_ARTICLE '" +  sIdFourn + "'", SQLCA )

CHOOSE CASE Upper ( sIdFourn )

	/*------------------------------------------------------------------*/
	/* Fournisseur : ORANGE/DME                                         */
	/*------------------------------------------------------------------*/
	CASE "DME"
		iRet = This.uf_Integration_Fichier_DME ( lNbLig, lNbInsert, lNbDelete )


	/*------------------------------------------------------------------*/
	/* Fournisseur : DARTY/DTY						                       	  */
	/*------------------------------------------------------------------*/
	CASE "DTY"
		iRet = This.uf_Integration_Fichier_Darty ( lNbLig, lNbInsert, lNbDelete )

	/*------------------------------------------------------------------*/
	/* Fournisseur : SFR-CEGETEL/CEG												  */
	/*------------------------------------------------------------------*/
	CASE "CEG"
		iRet = This.uf_Integration_Fichier_CEGETEL ( lNbLig, lNbInsert, lNbDelete )

	/*------------------------------------------------------------------*/
	/* Fournisseur : MOBISTORE/MBS                       	  				  */
	/*------------------------------------------------------------------*/
	CASE "MBS"
		iRet = This.uf_Integration_Fichier_MOBISTORE ( lNbLig, lNbInsert, lNbDelete )
	
	//* #4 [DCMP090102]
	CASE "CDP"
		// [PM289_CDP]
		iRet = This.uf_Integration_Fichier_CDISCOUNTPRO ( "1ER_TOUR", lNbLig, lNbInsert, lNbDelete )
	
	//* #5 [DCMP090140]
	CASE "PAP"
		iRet = This.uf_Integration_Fichier_PHONEANDPHONE ( lNbLig, lNbInsert, lNbDelete )

	// [PC301].[LOT2]
	CASE "CAR"
		iRet = This.uf_Integration_Fichier_CARREFOUR ( lNbLig, lNbInsert, lNbDelete )

	// [PM166][O2M]
	CASE "O2M"
		iRet = This.uf_Integration_Fichier_O2M ( "1ER_TOUR", lNbLig, lNbInsert, lNbDelete )

	// [PM178][CORIOLIS]
	CASE "CIS"
		iRet = This.uf_Integration_Fichier_CORIOLIS ( "1ER_TOUR", lNbLig, lNbInsert, lNbDelete )

	// [PC10-2]
	CASE "CVC"
		iRet = This.uf_integration_fichier_converlance(  lNbLig, lNbInsert, lNbDelete )
		
	//	[PC767]
	CASE "ORE"
		iRet = This.uf_integration_fichier_ORE(  lNbLig, lNbInsert, lNbDelete )

	//	[PC874]
	CASE "OMT"
		iRet = This.uf_integration_fichier_OMT(  lNbLig, lNbInsert, lNbDelete )
		
		
	//	[PC13348&13408]
	CASE "MTT"
		iRet = This.uf_integration_fichier_MTT(  lNbLig, lNbInsert, lNbDelete )

	//	[PC925]
	CASE "SRR"
		iRet = This.uf_integration_fichier_SRR(  lNbLig, lNbInsert, lNbDelete )

	// [PM319-1]
	CASE "PPO"
		iRet = This.uf_Integration_Fichier_PP_Orange (  lNbLig, lNbInsert, lNbDelete )
		
	// [PM319-2]
	CASE "PPB"
		iRet = This.uf_Integration_Fichier_PP_Bouygues (  lNbLig, lNbInsert, lNbDelete )
		
	// [PC13442-2]
	CASE "ATC"
		iRet = This.uf_integration_fichier_Atech(  lNbLig, lNbInsert, lNbDelete )
		
	// [PC151549]
	CASE "BST"
		iRet = This.uf_Integration_Fichier_Boost(  lNbLig, lNbInsert, lNbDelete )

	// [DT076-2]
	CASE "BK2"
 		iRet = This.uf_Integration_Fichier_BAK2 (  lNbLig, lNbInsert, lNbDelete )
		 
	// [DT328-1]
	Case "RTB"
		iRet = This.uf_Integration_Fichier_RT_Bouygues (  lNbLig, lNbInsert, lNbDelete )

	// [PM444-1]
	Case "AGP"
		iRet = This.uf_Integration_Fichier_AGORA_PLACE ( "1ER_TOUR", lNbLig, lNbInsert, lNbDelete )
		 
		 
END CHOOSE


/*------------------------------------------------------------------*/
/* MAJ de la table Article en base.                                 */
/* Le Commit ou le rollback d$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rouillage l'Update du d$$HEX1$$e900$$ENDHEX$$part.       */
/*------------------------------------------------------------------*/
If idwArticle.Update ()  > 0 Then 

	// #3 Traitement compl$$HEX1$$e800$$ENDHEX$$mentaire
	CHOOSE CASE Upper ( sIdFourn )	
		
		//* #4 [DCMP090102]
		CASE "CDP"
		// [PM289_CDP]
		iRet = This.uf_Integration_Fichier_CDISCOUNTPRO ( "2EME_TOUR", lNbLig2, lNbInsert2, lNbDelete2 )
		
		// [PM166][O2M]
		CASE "O2M"
//			iRet = This.uf_Integration_Fichier_O2M ( "2EME_TOUR", lNbLig, lNbInsert, lNbDelete )
			iRet = This.uf_Integration_Fichier_O2M ( "2EME_TOUR", lNbLig2, lNbInsert2, lNbDelete2 ) // [ITSM75595]

		// [PM178][CORIOLIS]
		CASE "CIS"
			//iRet = This.uf_Integration_Fichier_CORIOLIS ( "2EME_TOUR", lNbLig, lNbInsert, lNbDelete )
			iRet = This.uf_Integration_Fichier_CORIOLIS ( "2EME_TOUR", lNbLig2, lNbInsert2, lNbDelete2 ) // [ITSM75595]

		// [PM444-1]
		Case "AGP"
			iRet = This.uf_Integration_Fichier_AGORA_PLACE ( "2EME_TOUR", lNbLig, lNbInsert, lNbDelete )
	

	END CHOOSE	
	
	F_Commit ( SQLCA, True )

	This.Uf_Mail_CR_Integration ( lNbLig -1, lNbInsert, lNbDelete )

	This.uf_Trace ( "ECR", String ( lNbLig -1 ) + " lignes mises $$HEX2$$e0002000$$ENDHEX$$jour en base, dont " + String ( lNbInsert ) + " nouvelles en insertion." )
	This.uf_Trace ( "ECR", String ( lNbDelete ) + " lignes supprim$$HEX1$$e900$$ENDHEX$$es de la table (inexistantes dans fichier fournisseur)." )
	This.uf_Trace ( "ECR", "Table Article mise $$HEX2$$e0002000$$ENDHEX$$jour normalement." )

	/*------------------------------------------------------------------*/
	/* On renomme le fichier fournisseur, afin de marquer le fait       */
	/* qu'il a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$trait$$HEX1$$e900$$ENDHEX$$.                                              */
	/*------------------------------------------------------------------*/
	sNomFicOrig = isTxtNomFic.Text
	sNomFicRen  = Left ( sNomFicOrig, Len ( sNomFicOrig ) - 3 ) + "X" + Right ( sNomFicOrig, 2 ) 

	// [PM289_CDP]
	If Upper ( sIdFourn ) = "CDP" Then
		sNomFicRen  = Left ( sNomFicOrig, Len ( sNomFicOrig ) - 4 ) + "_" + &
					  String ( year    ( Today () ), "0000" ) + &
					  String ( Month  ( Today () ), "00" ) + &
					  String ( Day    ( Today () ), "00" ) + "_" + &
					  String ( Now(), "hhmmss")+ &			
					  ".X" + Right ( sNomFicOrig, 2 ) 			
	End If

	/*------------------------------------------------------------------*/
	/* Recopie du fichier original vers le fichier renomm$$HEX1$$e900$$ENDHEX$$.				  */
	/* dont l'ext. est "TXT".                                           */
	/*------------------------------------------------------------------*/
	If Upper ( sNomFicOrig ) <> Upper ( sNomFicRen ) then 
		bRet = F_LireFichierBlob ( blBlob, sNomFicOrig )
		If bRet Then bRet = F_EcrireFichierBlob ( blBlob, sNomFicRen )
		If bRet Then FileDelete ( sNomFicOrig )
	Else 
		bRet = True
	End If

	If Not bRet Then 
		This.uf_Trace ( "ECR", "ERREUR : Impossible de renommer le fichier fournisseur !" )
		stMessage.sTitre = "Int$$HEX1$$e900$$ENDHEX$$gration Fichier Fournisseur"
		stMessage.sCode = "COMD009"
		stMessage.icon = Exclamation!
		This.uf_Sortie_OpCon ( "ECR", 90, "ERR90/INTFICFOUR", FALSE )							
	Else
		This.uf_Trace ( "ECR", "Fichier fournisseur renomm$$HEX2$$e9002000$$ENDHEX$$en " + Upper ( sNomFicRen ) )
		isTxtNomFic.Text = ""
	End If

Else
	iRet = -1
	F_Commit ( SQLCA, False )
	This.uf_Trace ( "ECR", "ERREUR : Probl$$HEX1$$e800$$ENDHEX$$me lors de l'UPDATE en base de la DW Article." )
End If

If iRet < 0 Then 
	stMessage.sTitre = "Int$$HEX1$$e900$$ENDHEX$$gration Fichier Fournisseur"
	stMessage.sCode = "COMD009"
	stMessage.icon = Exclamation!
	This.uf_Sortie_OpCon ( "ECR", 100, "ERR100/INTFICFOUR", FALSE )							
End If



Return iRet
end function

public subroutine uf_initialiser (ref s_pass astpass, ref statictext astxtnomfic, ref listbox alblistefic);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Initialiser (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation de l'objet
//* Commentaires	: 
//*
//* Arguments		: astPass		s_Pass		Ref
//*					  asTxtNomFic  StaticText	Ref					
//*					  aLbListeFic  ListBox		Ref					
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

DatawindowChild 	dwChild

idwFourn 		= astPass.dwNorm [1]
idwFicFourn 	= astPass.dwNorm [2]
idwSuiviTrt 	= astPass.dwNorm [3]
idwArtSpb	 	= astPass.dwNorm [4]
idwArticle	 	= astPass.dwNorm [5]
idwTri		 	= astPass.dwNorm [6]
idwStkRepFourn = astPass.dwNorm [7]
isTxtNomFic	 	= asTxtNomFic
ilbListeFic		= albListeFic

/*------------------------------------------------------------------*/
/* Chargement liste fourns.                                         */
/*------------------------------------------------------------------*/
idwFourn.GetChild ( "ID_FOURN", dwChild )
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ( "-FR" )

/*------------------------------------------------------------------*/
/* Chargement liste Rep fourns.                                     */
/*------------------------------------------------------------------*/
idwStkRepFourn.SetTransObject ( SQLCA )
idwStkRepFourn.Retrieve ( "-FL" )

idwArtSpb.SetTransObject ( SQLCA )
idwArticle.SetTransObject ( SQLCA )

/*------------------------------------------------------------------*/
/* Tableau des fournisseurs $$HEX2$$e0002000$$ENDHEX$$traiter par OpCon/XPS.                */
/*------------------------------------------------------------------*/
isTabFrIntArt = stGlb.sTab_OpCon_XPS

/*------------------------------------------------------------------*/
/* Initialisation du fichier de Sortie OpCon                        */
/*------------------------------------------------------------------*/
If This.uf_Sortie_OpCon ( "INIT", 0, "", FALSE ) < 0 Then Halt

end subroutine

private function integer uf_purge_fichier_auto (string aidfourn);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Purge_Fichier_Auto (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 05/09/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Purge Automatique des fichier trait$$HEX2$$e9002000$$ENDHEX$$apr$$HEX1$$e800$$ENDHEX$$s 6 mois
//* Commentaires	: 
//*
//* Arguments		: String		aIdfourn		Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    30/08/2002  Le nom du r$$HEX1$$e900$$ENDHEX$$pertoire de g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration n'est plus le code
//*								  du fournisseur -FR mais le nom complet (<8 car) -FL
//* 
//*-----------------------------------------------------------------

Int	iRet
String sJoker, sRepFicArt, sMoisPrec, sRepFourn
Long	lTotLig, lCpt, lErreur, lRow

iRet = 1

// JFF le 28/02/2002 : Je shunte pour le moment la purge
Return 1

sMoisPrec = Trim ( String ( Month ( Today () ) - 6, "00" ) )
If Long ( sMoisPrec ) <= 0 Then sMoisPrec = String ( Long ( sMoisPrec ) + 12, "00" )

/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
lRow = idwStkRepFourn.Find ( "ID_CODE = '" + aIdFourn + "'", 1, idwStkRepFourn.RowCount () )
If lRow > 0 Then
	sRepFourn = Upper ( idwStkRepFourn.GetItemString ( lRow, "LIB_CODE" ) )
Else
	Return -1
End If

sRepFicArt =  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_GEN", "" ) + &
				  sRepFourn + &
				  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_FIC_ART", "" )

sJoker = sRepFicArt + K_FIC + "??" + sMoisPrec + "?.X*"
ilbListeFic.DirList ( sJoker, 0 )

lTotLig = ilbListeFic.TotalItems ()

lErreur = 0
For lCpt = lTotLig To 1 Step -1
	ilbListeFic.SelectItem ( lCpt )
	If Not FileDelete ( sRepFicArt + ilbListeFic.SelectedItem ( ) ) Then lErreur++
	ilbListeFic.DeleteItem ( lCpt )
Next

If lErreur > 0 Then
	This.Uf_Trace ( "ECR", "ERREUR lors de la purge de fichiers, " + String ( lErreur ) + " fichiers non purg$$HEX1$$e900$$ENDHEX$$s" )
End If
This.Uf_Trace ( "ECR", String ( lTotLig - lErreur ) + " fichiers sur " + String ( lTotLig ) + " ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$purg$$HEX1$$e900$$ENDHEX$$s" )

Return iRet
end function

private function integer uf_sortie_opcon (string ascas, integer aicodeerreur, string astexte, boolean abbox);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Sortie_OpCon (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 16/12/2002
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Fichier de sortie des erreurs pour OpCon
//* Commentaires	: 
//*
//* Arguments		: asCas			String		Val
//*					  aiCodeErreur	Integer		Val
//*					  asTexte		String		Val
//*					  abBox			Boolean		Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1    JFF    05/04/2006  ajout du "+ K_FIC_SORTIE_OPCON" derri$$HEX1$$e800$$ENDHEX$$re isRepFicOpcon  
//        JFF    21/03/2017  [PI065]
//*-----------------------------------------------------------------

Int	iRet, iFicOpcon
String sMes, sNomFicRen, sSql  
Long	lRow


/*------------------------------------------------------------------*/
/* Fichier de sortie Erreur pour OpCon                              */
/*------------------------------------------------------------------*/

CHOOSE CASE Upper ( asCas )

	CASE "INIT"

		isRepFicOpcon =  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "OPCON_OUT", &
							  ProfileString ( stGlb.sWinDir + "\MAJPOST.INI", "PARAM", "DESTINATION", "C:" ) + "\" )

		iRet = 1

//Migration PB8-WYNIWYG-03/2006 CP
//		If FileExists ( isRepFicOpcon ) Then 
		If f_FileExists ( isRepFicOpcon + K_FIC_SORTIE_OPCON ) Then // #1
//Fin Migration PB8-WYNIWYG-03/2006 CP			
			
			If Not FileDelete ( isRepFicOpcon + K_FIC_SORTIE_OPCON ) Then // #1
				iRet = -1
			End If 
		End If 

	CASE "ECR"

		// [PI065]
		If ibErrIntegr Then
			sNomFicRen = F_Remplace ( isNomFicOrig, ".", ".BAD" ) + "__BAD_" + String ( DateTime ( Today(), Now()), "yyyymmddhhmmss" ) + "_" + stGlb.sCodOper
			iRet = FileMove ( isNomFicOrig, sNomFicRen )
			If iRet < 0 Then
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR renommage BAD " + &
				" : le syst$$HEX1$$e800$$ENDHEX$$me n'a pas pu renommer le fichier " + isNomFicOrig + " en BAD !" )					
			End If
			
			sSql  = "Exec sysadm.PS_S_ENVOI_MAIL_LOG_PRESTA "
			sSql += "'" + isIdFour + "'," 
			sSql += string ( ilIdLotLog ) + ","
			sSql += isIdTypMvt + ","
			sSql += "'" + isNomFicOrig + "'" 
			
			If F_Execute ( sSql, SQLCA ) Then 
				If SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0 Then
					F_commit ( SQLCA, True ) 
				Else 
					iRet = -1
					F_commit ( SQLCA, False ) 
					This.uf_Trace ( "ECR", "ERREUR mail presta : Probl$$HEX1$$e800$$ENDHEX$$me envoi mail/log presta PS_S_ENVOI_MAIL_LOG_PRESTA" ) 
				End If
			Else
				iRet = -1
				F_commit ( SQLCA, False ) 
				This.uf_Trace ( "ECR", "ERREUR mail presta : Probl$$HEX1$$e800$$ENDHEX$$me envoi mail/log presta PS_S_ENVOI_MAIL_LOG_PRESTA" ) 
			End If					
			
			
		End If

		/*------------------------------------------------------------------*/
		/* On est connect$$HEX2$$e9002000$$ENDHEX$$avec OpCon, donc sortie en fichier Erreur.       */
		/*------------------------------------------------------------------*/
		If gbOpCon Then 

			iFicOpcon = FileOpen ( isRepFicOpCon + K_FIC_SORTIE_OPCON, LineMode!, Write!, Shared!, Append! )
			FileWrite ( iFicOpcon, String ( aiCodeErreur ) + "|" + asTexte )
			FileClose ( iFicOpcon )

		/*------------------------------------------------------------------*/
		/* Sinon Mes Box sur Demande                                        */
		/*------------------------------------------------------------------*/
		ElseIf abBox Then
			
			F_Message ( stMessage )

		End If
	

END CHOOSE



Return iRet
end function

public function integer uf_trt_opcon (string ascas);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Trt_OpCon (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 16/12/2002
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Traitement de certaines partie en Automatique
//* Commentaires	: 
//*
//* Arguments		: asCas			String		Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF   02/03/2015   [PM289_CDP]
//*-----------------------------------------------------------------

Int iRet, iFicFinTrt
Long	lTotFour, lCptFour

iRet = 1

Choose Case Upper ( asCas )

	Case "LANCER"

		lTotFour = UpperBound ( isTabFrIntArt )

		/*------------------------------------------------------------------*/
		/* Compte de fournisseur                                            */
		/*------------------------------------------------------------------*/
		For lCptFour = 1 To lTotFour

			/*------------------------------------------------------------------*/
			/* On Force le fournisseur.                                         */
			/*------------------------------------------------------------------*/
			idwFourn.SetItem ( 1, "ID_FOURN", isTabFrIntArt [ lCptFour ] ) 
			istxtNomFic.Text = ""
			
			This.uf_Detection_Auto_NomFic ( isTabFrIntArt [ lCptFour ], "NORMAL" ) // [PM289_CDP]			

			/*------------------------------------------------------------------*/
			/* Compteur de fichier pour un m$$HEX1$$ea00$$ENDHEX$$me fournisseur                     */
			/*------------------------------------------------------------------*/
			DO UNTIL istxtNomFic.Text = "" Or iRet < 0
				iRet = This.uf_Lancer_Trt ()
			LOOP

			If iRet < 0 Then Exit

		Next

	Case "FIN_TRT"

		iFicFinTrt = FileOpen ( isRepFicOpCon + K_FICFINTRT, LineMode!, Write!, Shared!, Replace! )
		FileClose ( iFicFinTrt )


End Choose


Return iRet

end function

private function integer uf_ctrl_fichier_dme ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Ctrl_Fichier_DME (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 04/04/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler de la validit$$HEX2$$e9002000$$ENDHEX$$du fichier de ORANGE/DME
//* Commentaires	: 
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 CAG	 02/06/2003   Ajout d'un ctrl d'unicit$$HEX2$$e9002000$$ENDHEX$$+ non null sur id_ref_four
//*       JFF   20/05/2011   [PC501][PC545] Shunt d'un contr$$HEX1$$f400$$ENDHEX$$le
//*-----------------------------------------------------------------

Int iRet 
String	sIdFour, sVal, sCar, sSort, sIdRefFourPrec, sTypArtSAV
Long		lTotLig, lCpt, lCptVal, lTotArt, lLen
Boolean	bTrouve

iRet = 1

lTotLig = idwFicFourn.RowCount ()
lTotArt = idwArtSpb.RowCount ()
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sTypArtSav = ""

// JFF 20/01/2011 : le tri imp$$HEX1$$e900$$ENDHEX$$ratif sur ID_REF_FOUR $$HEX1$$e900$$ENDHEX$$tait visiblement manquant (?..)
idwFicFourn.SetSort ( "ID_REF_FOUR A" )
idwFicFourn.Sort ()

sIdRefFourPrec = ""

For lCpt = 1 To lTotLig 

	/*------------------------------------------------------------------*/
	/* ZONE 1 : ID_FOUR                                                */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone fournisseur est vide." )
	End If 

	If sVal <> sIdFour Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fournisseur " + sVal + " ne correspond pas au fournisseur s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$" + sIdFour )
	End If 

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La longueur du fournisseur doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If
	
	/*------------------------------------------------------------------*/
	/* ZONE 2 : ID_TYP_ART                                              */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_TYP_ART" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Type Article est vide." )
	End If 

	// Le fichier ne doit que contenir que des appareils du m$$HEX1$$ea00$$ENDHEX$$me type
	// [PC501][PC545] Shunt d'un contr$$HEX1$$f400$$ENDHEX$$le
	/*
	If sTypArtSav <> sVal And sTypArtSav <> "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fichier contient des types d'appareils diff$$HEX1$$e900$$ENDHEX$$rents !" )
	End If
	*/

	If Not IsNull ( sVal ) And sVal <> "" Then
	  sTypArtSav = sVal
	End If

	bTrouve = False
	lCptVal = 1
	Do While Not bTrouve And lCptVal <= lTotArt
		bTrouve = sVal = Upper ( idwArtSpb.GetItemString ( lCptVal, "ID_CODE" ) )
		lCptVal ++
	Loop

	If Not bTrouve Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type d'article " + sVal + " n'existe pas dans la base SIMPA2.")
	End If

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type de l'article doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If		

	/*------------------------------------------------------------------*/
	/* ZONE 3 : ID_MARQ_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MARQ_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Marque Article est vide." )
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 4 : ID_MODL_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MODL_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone mod$$HEX1$$e800$$ENDHEX$$le article est vide." )
	Else

		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (ID_MODL_ART) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "ID_MODL_ART", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 5 : MT_PRIX_HT															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemDecimal ( lCpt, "MT_PRIX_HT" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Prix Hors Taxe est vide." )
	End If 

	lLen = Len ( sVal )
	
	// Marque la virgule
	bTrouve = False

	For lCptVal = 1 To lLen 
		sCar = Mid ( sVal, lCptVal, 1 )
		If sCar = "." Then
			If Not bTrouve Then 
				bTrouve = True
			Else
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, il y a deux virgules." )
				Exit
			End If

		Else
			If Not ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) Then
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, un caract$$HEX1$$e800$$ENDHEX$$re n'est pas un chiffre." )
				Exit
			End If
		End If
	Next	

	If Real ( sVal ) > 5000 Then		
		This.uf_Trace ( "ECR", "AVERTISSEMENT ligne " + String ( lCpt ) + &
		" : Le montant " + sVal + " para$$HEX1$$ee00$$ENDHEX$$t anormalement grand." )
	End If

	
	/*------------------------------------------------------------------*/
	/* ZONE 6 : UNT_MONNAIE															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "UNT_MONNAIE" ) ) )
	// [SUISSE].LOT3 Controle de la monnaie du fichier
	// Si pas de coh$$HEX1$$e900$$ENDHEX$$rence : erreur bloquante d'int$$HEX1$$e900$$ENDHEX$$gration.
	if uf_controler_monnaie_fichier (sVal, lCpt) < 0 Then iRet = -1
	
//	If IsNull ( sVal ) Or sVal = "" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : L'unit$$HEX2$$e9002000$$ENDHEX$$de la monnaie est vide." )
//	End If 
//
//	If sVal <> "FRF" And sVal <> "EUR" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : La monnaie " + sVal + " n'est pas valide." )
//		Exit
//	End If

	/*------------------------------------------------------------------*/
	/* ZONE 7 : QT_DISP																  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemNumber ( lCpt, "QT_DISP" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		idwFicFourn.SetItem ( lCpt, "QT_DISP", 0 ) 
		sVal = "0"
	End If 

	If Not IsNumber ( sVal ) Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La quantit$$HEX2$$e9002000$$ENDHEX$$" + sVal + " n'est pas valide, ce n'est pas un nombre." )
		
	End If

	/*------------------------------------------------------------------*/
	/* ZONE 8 : OBSERV_FRN 															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )

	If Not IsNull ( sVal ) And sVal <> "" Then
		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (OBSERV_FRN) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "OBSERV_FRN", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 


	/*------------------------------------------------------------------*/
	/* #1																					  */
	/*------------------------------------------------------------------*/
	/* ZONE 1 BIS : ID_REF_FOUR													  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur est vide." )
	ElseIf sIdRefFourPrec <> "" And sVal = sIdRefFourPrec Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sVal + " n'est pas unique." )
		
	End If

	sIdRefFourPrec = sVal

Next

If iRet < 0 Then This.uf_Trace ( "ECR", "ERREUR : Le fichier fournisseur n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$.")

Return iRet


end function

private function integer uf_ctrl_fichier_darty ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Ctrl_Fichier_DARTY (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 04/04/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler de la validit$$HEX2$$e9002000$$ENDHEX$$du fichier de DARTY
//* Commentaires	: 
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Int iRet 
String	sIdFour, sVal, sCar, sSort, sIdRefFourPrec, sTypArtSav
Long		lTotLig, lCpt, lCptVal, lTotArt, lLen
Boolean	bTrouve

iRet = 1

lTotLig = idwFicFourn.RowCount ()
lTotArt = idwArtSpb.RowCount ()
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sTypArtSav = ""

// JFF 20/01/2011 : le tri imp$$HEX1$$e900$$ENDHEX$$ratif sur ID_REF_FOUR $$HEX1$$e900$$ENDHEX$$tait visiblement manquant (?..)
idwFicFourn.SetSort ( "ID_REF_FOUR A" )
idwFicFourn.Sort ()

sIdRefFourPrec = ""

For lCpt = 1 To lTotLig 

	/*------------------------------------------------------------------*/
	/* ZONE 1 : ID_FOUR                                                 */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone fournisseur est vide." )
	End If 

	If sVal <> sIdFour Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fournisseur " + sVal + " ne correspond pas au fournisseur s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$" + sIdFour )
	End If 

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La longueur du fournisseur doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If
	
	/*------------------------------------------------------------------*/
	/* ZONE 2 : ID_TYP_ART                                              */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_TYP_ART" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Type Article est vide." )
	End If 

	// Le fichier ne doit que contenir que des appareils du m$$HEX1$$ea00$$ENDHEX$$me type
/* DT066
	If sTypArtSav <> sVal And sTypArtSav <> "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fichier contient des types d'appareils diff$$HEX1$$e900$$ENDHEX$$rents !" )
	End If

	If Not IsNull ( sVal ) And sVal <> "" Then
	  sTypArtSav = sVal
	End If
*/

	bTrouve = False
	lCptVal = 1
	Do While Not bTrouve And lCptVal <= lTotArt
		bTrouve = sVal = Upper ( idwArtSpb.GetItemString ( lCptVal, "ID_CODE" ) )
		lCptVal ++
	Loop

	If Not bTrouve Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type d'article " + sVal + " n'existe pas dans la base SIMPA2.")
	End If

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type de l'article doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If		

	/*------------------------------------------------------------------*/
	/* ZONE 3 : ID_MARQ_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MARQ_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Marque Article est vide." )
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 4 : ID_MODL_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MODL_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone mod$$HEX1$$e800$$ENDHEX$$le article est vide." )
	Else

		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (ID_MODL_ART) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "ID_MODL_ART", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 5 : MT_PRIX_HT															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemDecimal ( lCpt, "MT_PRIX_HT" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Prix Hors Taxe est vide." )
	End If 

	lLen = Len ( sVal )
	
	// Marque la virgule
	bTrouve = False

	For lCptVal = 1 To lLen 
		sCar = Mid ( sVal, lCptVal, 1 )
		If sCar = "." Then
			If Not bTrouve Then 
				bTrouve = True
			Else
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, il y a deux virgules." )
				Exit
			End If

		Else
			If Not ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) Then
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, un caract$$HEX1$$e800$$ENDHEX$$re n'est pas un chiffre." )
				Exit
			End If
		End If
	Next	

	If Real ( sVal ) > 5000 Then		
		This.uf_Trace ( "ECR", "AVERTISSEMENT ligne " + String ( lCpt ) + &
		" : Le montant " + sVal + " para$$HEX1$$ee00$$ENDHEX$$t anormalement grand." )
	End If

	
	/*------------------------------------------------------------------*/
	/* ZONE 6 : UNT_MONNAIE															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "UNT_MONNAIE" ) ) )
	// [SUISSE].LOT3 Controle de la monnaie du fichier
	// Si pas de coh$$HEX1$$e900$$ENDHEX$$rence : erreur bloquante d'int$$HEX1$$e900$$ENDHEX$$gration.
	if uf_controler_monnaie_fichier (sVal, lCpt) < 0 Then iRet = -1
	
//	If IsNull ( sVal ) Or sVal = "" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : L'unit$$HEX2$$e9002000$$ENDHEX$$de la monnaie est vide." )
//	End If 
//
//	If sVal <> "FRF" And sVal <> "EUR" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : La monnaie " + sVal + " n'est pas valide." )
//		Exit
//	End If

	/*------------------------------------------------------------------*/
	/* ZONE 7 : QT_DISP																  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemNumber ( lCpt, "QT_DISP" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		idwFicFourn.SetItem ( lCpt, "QT_DISP", 0 ) 
		sVal = "0"
	End If 

	If Not IsNumber ( sVal ) Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La quantit$$HEX2$$e9002000$$ENDHEX$$" + sVal + " n'est pas valide, ce n'est pas un nombre." )
		
	End If

	/*------------------------------------------------------------------*/
	/* ZONE 8 : OBSERV_FRN 															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )

	If Not IsNull ( sVal ) And sVal <> "" Then
		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (OBSERV_FRN) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "OBSERV_FRN", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 


	/*------------------------------------------------------------------*/
	/* #1																					  */
	/*------------------------------------------------------------------*/
	/* ZONE 1 BIS : ID_REF_FOUR													  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur est vide." )
	ElseIf sIdRefFourPrec <> "" And sVal = sIdRefFourPrec Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sVal + " n'est pas unique." )
		
	End If

	sIdRefFourPrec = sVal

Next

If iRet < 0 Then This.uf_Trace ( "ECR", "ERREUR : Le fichier fournisseur n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$.")

Return iRet


end function

private function integer uf_trace (string ascas, string astexte);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Trace (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Trace des op$$HEX1$$e900$$ENDHEX$$rations
//* Commentaires	: 
//*
//* Arguments		: asCas			String		Val
//*					  asTexte		String		Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*      JFF   21/03/2017 [PI065]
//*-----------------------------------------------------------------

Int	iRet
String sRepFicGen, sMes, sSql
Long	lRow

sRepFicGen =  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_GEN", "" ) + & 
				  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_LOG", "" ) + K_FICLOG
iRet = 1

CHOOSE CASE Upper ( asCas )

	CASE "INIT"
		iiFicTrc = FileOpen ( sRepFicGen, LineMode!, Write!, Shared!, Append! )

		If iiFicTrc <= 0 Then 
			iRet = -1
			stMessage.sTitre = "Fichier Trace"
			stMessage.sCode = "COMD005"
			stMessage.icon = StopSign!

			This.uf_Sortie_OpCon ( "ECR", 60, "ERR60/TRACE/INIT", TRUE )

		Else
			sMes = Fill( "*", 80 )
			FileWrite ( iiFicTrc, sMes )
			FileClose ( iiFicTrc )
			

			// [PI065]
			ilIdLotLog = -1
			SQLCA.PS_X_Incrementer( "ID_LOT_LOG", ilIdLotLog) 
	
			If SQLCA.SQLCODE <> 0 Or SQLCA.SQLDBCODE <> 0 Or IsNull ( ilIdLotLog ) Or ilIdLotLog <= 0 Then 
			
				f_Commit ( SQLCA, FALSE )
		
				stMessage.sTitre = "Fichier Trace en base"
				stMessage.sCode = "COMD964"
				stMessage.icon = StopSign!
	
				This.uf_Sortie_OpCon ( "ECR", 62, "ERR62/TRACE/INIT", TRUE )

			ELSE
				F_COMMIT ( SQLCA, TRUE  ) // Commit du num$$HEX1$$e900$$ENDHEX$$ro de lot
				
				sSql  = "Exec sysadm.PS_I_TRACE_LOG_MPR "
				sSql += "'" + isIdFour + "'," 
				sSql += string ( ilIdLotLog ) + ","
				sSql += "'" + isIdTypMvt + "',"
				sSql += "'" + Fill( "*", 80 ) + "',"
				sSql += "'" + stGlb.sCodOper + "'"		
				
				If F_Execute ( sSql, SQLCA ) Then 
					If SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0 Then
						F_commit ( SQLCA, True ) 
					Else 
						iRet = -1
						F_commit ( SQLCA, False ) 
						This.uf_Trace ( "ECR", "ERREUR Trace1/Base : Probl$$HEX1$$e800$$ENDHEX$$me d'Insert sur la table de trace sysadm.trace_log_mpr" ) 
					End If
				Else
					iRet = -1
					F_commit ( SQLCA, False ) 
					This.uf_Trace ( "ECR", "ERREUR Trace1/Base : Probl$$HEX1$$e800$$ENDHEX$$me d'Insert sur la table de trace sysadm.trace_log_mpr" ) 
				End If					
				
			End If				
			
		End If

	CASE "ECR"

			iiFicTrc = FileOpen ( sRepFicGen, LineMode!, Write!, Shared!, Append! )

			sMes = String ( Today() ) + "~t" + String ( Now () ) + "~t" + Upper ( stGlb.sCodOper ) + "~t" + asTexte
			FileWrite ( iiFicTrc, sMes )
			lRow = idwSuiviTrt.InsertRow ( 0 )
			idwSuiviTrt.SetItem ( lRow,  "TEXTE", String ( Today() ) + " " + String ( Now () ) + "   " + asTexte )

			FileClose ( iiFicTrc )
			
			// [PI065]
			asTexte = F_Remplace ( asTexte, "'", "''" )
			
			sSql  = "Exec sysadm.PS_I_TRACE_LOG_MPR "
			sSql += "'" + isIdFour + "'," 
			sSql += string ( ilIdLotLog ) + ","
			sSql += "'" + isIdTypMvt + "',"
			sSql += "'" + asTexte + "',"
			sSql += "'" + stGlb.sCodOper + "'"		
			
			If F_Execute ( sSql, SQLCA ) Then 
				If SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0 Then
					F_commit ( SQLCA, True ) 
				Else 
					iRet = -1
					F_commit ( SQLCA, False ) 
					This.uf_Trace ( "ECR", "ERREUR Trace2/Base : Probl$$HEX1$$e800$$ENDHEX$$me d'Insert sur la table de trace sysadm.trace_log_mpr" ) 
				End If
			Else
				iRet = -1
				F_commit ( SQLCA, False ) 
				This.uf_Trace ( "ECR", "ERREUR Trace2/Base : Probl$$HEX1$$e800$$ENDHEX$$me d'Insert sur la table de trace sysadm.trace_log_mpr" ) 
			End If					

END CHOOSE



Return iRet
end function

private function integer uf_trace_2 (string ascas, integer aicodetat, string asidfour, string asidreffour, string asidmarqart, string asidmodlart, string astexte);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Trace_2 (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Fichier retracant une seule int$$HEX1$$e900$$ENDHEX$$gration.
//* Commentaires	: sur W:\LOGCMD\TRACE\FIC_ART\<< fournisseur >>\STKjjmma.TRi
//*
//* Arguments		: asCas			String		Val
//*					  aiCodEtat		Integer 		Val
//*					  asIdFour		String		Val
//*					  asIdRefFour  String		Val
//*					  asIdMarqArt  String		Val
//*					  asIdModlArt  String		Val
//*					  asTexte		String		Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Int	iRet
String sRepFicGen, sMes, sRepFourn, sNomFour, sNomFicTrc, sMobile
Long	lRow

iRet = 1
sRepFicGen =  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_GEN", "" ) + & 
				  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_TRC", "" ) 

lRow = idwStkRepFourn.Find ( "ID_CODE = '" + asIdFour + "'", 1, idwStkRepFourn.RowCount () )
If lRow > 0 Then
	sRepFourn = Upper ( idwStkRepFourn.GetItemString ( lRow, "LIB_CODE" ) )
Else
	Return -1
End If

/*------------------------------------------------------------------*/
/* Ex : W:\LOGCMD\TRACE\FIC_ART\O2M\                           */
/*------------------------------------------------------------------*/
sRepFicGen =  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_GEN", "" ) + & 
				  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_TRC", "" ) + &
				  sRepFourn + "\"

sNomFicTrc  =  Right ( isTxtNomFic.Text, 12 )
sNomFicTrc  =  Left  ( sNomFicTrc, 9 ) + "TR" +  Right ( sNomFicTrc, 1 )

/*------------------------------------------------------------------*/
/* Ex : W:\LOGCMD\TRACE\FIC_ART\O2M\STK21074.TR1               */
/*------------------------------------------------------------------*/
sRepFicGen += sNomFicTrc  
sRepFicGen = Upper ( sRepFicGen )
isNomTrace2 = sRepFicGen 

/*------------------------------------------------------------------*/
/* Nom du fournisseur (-FR)                                         */
/*------------------------------------------------------------------*/
sNomFour = Upper ( idwFourn.Describe ( "Evaluate ('LookUpDisplay ( ID_FOURN )', 1)" ) )

/*------------------------------------------------------------------*/
/* Ex : (47A87B5,NOKIA,3310)                                        */
/*------------------------------------------------------------------*/
sMobile  = Upper ( "(" + asIdRefFOur + "," + asIdMarqArt + "," + asIdModlArt + ")" )


CHOOSE CASE Upper ( asCas )

/*------------------------------------------------------------------*/
/* Initialisation du fichier de trace                               */
/*------------------------------------------------------------------*/
	CASE "INIT"
		iiFicTrc = FileOpen ( sRepFicGen, LineMode!, Write!, Shared!, Append! )

		If iiFicTrc <= 0 Then 
			iRet = -1
			stMessage.sTitre = "Fichier Trace"
			stMessage.sCode = "COMD005"
			stMessage.icon = StopSign!

			This.uf_Sortie_OpCon ( "ECR", 61, "ERR61/TRACE/INIT", TRUE )

		Else
			sMes = Fill( "*", 80 )
			FileWrite ( iiFicTrc, sMes )

			FileWrite ( iiFicTrc, "Fournisseur       : " + sNomFour  )		
			FileWrite ( iiFicTrc, "Dt&He int$$HEX1$$e900$$ENDHEX$$gration : " + "Le " + String ( Today () ) + " $$HEX2$$e0002000$$ENDHEX$$" + String ( Now () ))		
			FileWrite ( iiFicTrc, "Fichier trait$$HEX5$$e9002000200020002000$$ENDHEX$$: " + Upper ( isTxtNomFic.Text ) )
			FileWrite ( iiFicTrc, "" )

			FileClose ( iiFicTrc )
		End If

/*------------------------------------------------------------------*/
/* Ecritue automatique format$$HEX1$$e900$$ENDHEX$$e.												  */
/*------------------------------------------------------------------*/
	CASE "ECR_AUTO"

			iiFicTrc = FileOpen ( sRepFicGen, LineMode!, Write!, Shared!, Append! )

			sMes  = String ( Today() ) + "~t" + String ( Now () ) + "~t" + Upper ( stGlb.sCodOper ) + "~t" 

			Choose Case aiCodEtat 

				Case 100
					sMes += "[100:MAJ_OK]" + "~t" + "Mobile fournisseur " +  sMobile + " existant dans la table article SIMPA2 et mis $$HEX2$$e0002000$$ENDHEX$$jour"
				Case 200
					sMes += "[200:NOV_MB]" + "~t" + "Nouveau Mobile fournisseur " + sMobile + " inexistant dans la table article SIMPA2. R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence IFR $$HEX2$$e0002000$$ENDHEX$$placer $$HEX2$$e0002000$$ENDHEX$$la main."
				Case 300
					sMes += "[300:SUP_OK]" + "~t" + "Suppression du mobile " + sMobile + " de la table article SIMPA2, car inexistant dans le fichier fournisseur."

			End Choose

			FileWrite ( iiFicTrc, sMes )

			FileClose ( iiFicTrc )

/*------------------------------------------------------------------*/
/* Ecriture texte libre															  */
/*------------------------------------------------------------------*/
	CASE "ECR_LIBRE"

			iiFicTrc = FileOpen ( sRepFicGen, LineMode!, Write!, Shared!, Append! )

			sMes  = String ( Today() ) + "~t" + String ( Now () ) + "~t" + Upper ( stGlb.sCodOper ) + "~t" 

			FileWrite ( iiFicTrc, sMes )

			FileClose ( iiFicTrc )

END CHOOSE



Return iRet
end function

private subroutine uf_mail_cr_integration (integer ainbmaj, integer ainbinsert, integer ainbsupp);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_int_fic_article::Uf_Mail_CR_Integration (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 28/07/2004 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Envoi d'un compte rendu d'int$$HEX1$$e900$$ENDHEX$$gration par mail.
//* Commentaires	: 
//*
//* Arguments		: Integer 	aiNbmaj			Val
//*					  Integer 	aiNbInsert		Val
//*					  Integer 	aiNbSupp			Val
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* JFF  08/06/2023  [20230608] Envoyer le mail uniquement s'il y a de l'insertion (nouveau article)
//*-----------------------------------------------------------------

String  sEnt, sTextBody, sSubject, sTo, sMail, sCc, sFrom, sSql, sCivNom, sFin, sNomFour, sDh, sIFR
Boolean bMail

// [20230608]
If aiNbInsert <= 0 Then Return


sMail = ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "MAIL_CR_INT_FIC_ARTICLE", "jff@spb.fr" )
sIfr  = "  (donc r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence IFR $$HEX2$$e0002000$$ENDHEX$$placer $$HEX2$$e0002000$$ENDHEX$$la main sur " + String ( aiNbInsert ) + " mobile(s))"

/*------------------------------------------------------------------*/
/* Nom du fournisseur (-FR)                                         */
/*------------------------------------------------------------------*/
sNomFour = Upper ( idwFourn.Describe ( "Evaluate ('LookUpDisplay ( ID_FOURN )', 1)" ) )
sDh = String ( Today ()) + " $$HEX2$$e0002000$$ENDHEX$$" + String ( Now () )

bMail = False
sSubject = "SIMPA2/CR Int$$HEX1$$e900$$ENDHEX$$gration fichier article " + sNomFour + " le " + sDh 
sTo = sMail
sCc = ""
sFrom = "SIMPA2_ARTICLE@SPB.FR"
sEnt = "~n~r"

/*------------------------------------------------------------------*/
/* Pr$$HEX1$$e900$$ENDHEX$$paration du corps du mail.                                    */
/*------------------------------------------------------------------*/
sTextBody  = "Fournisseur : " + sNomFour + sEnt
sTextBody += "Date et Heure d''int$$HEX1$$e900$$ENDHEX$$gration : " + sDh + sEnt + sEnt
//sTextBody += sEnt + sEnt
sTextBody += "Trace consultable : " + isNomTrace2 + sEnt + sEnt
sTextBody += sEnt + sEnt
sTextBody += "Nombre de mises $$HEX2$$e0002000$$ENDHEX$$jour sur la table : " + String ( aiNbmaj )    + sEnt 
sTextBody += "Nombre de nouvels articles (inclus) : " + String ( aiNbInsert ) 

If aiNbInsert > 0 Then
	sTextBody += sIfr  
End If

sTextBody += sEnt 
sTextBody += "Nombre de suppressions              : " + String ( aiNbSupp )   + sEnt + sEnt

// DCMP060582
sTextBody += sEnt 
sTextBody += sEnt 
sTextBody += "MERCI DE VERIFIER LA DISPONIBILITE DES MODELES DANS LA TABLE ARTICLE DE SIMPA2 SUITE A CES NOUVELLES MISES A JOUR !" + sEnt + sEnt


/*------------------------------------------------------------------*/
/* Envoi du mail                                                    */
/*------------------------------------------------------------------*/
sSql = "Exec sysadm.PS_S01_MAIL " + &
        "'" + sTo + "'"				 + ", " + &
        "'" + sTextBody + "'"		 + ", " + &
        "'" + sSubject + "'"		 + ", " + &
        "'" + sFrom + "'"		    + ", " + &
        "'" + sCc + "'"		 		 + ", " + &
        "null"   				 		 + ", " + &
        "null"   				 		 + ", " + &
        "null"   				 		 + ", " + &
        "null"   				 		 + ", " + &
        "null"

F_Execute ( sSql, SQLCA )







end subroutine

private function integer uf_integration_fichier_darty (ref long alnblig, ref long alnbinsert, long alnbdelete);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Integration_Fichier_DARTY (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 04/04/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Int$$HEX1$$e900$$ENDHEX$$gration du fichier DEBITEL dans la base
//* Commentaires	: 
//*
//* Arguments		: Long		alNbLig		Ref
//*					  Long		alNbInsert	Ref
//*					  Long		alNbDelete	Ref
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JCA	01/09/2006	Si id_typ_art = 'PCP' on force la disponibilit$$HEX4$$e9002000e0002000$$ENDHEX$$oui
//* #2	 JFF	02/02/2007	on remplace les " par P
//* #3    JFF  28/01/2007  [DCMP080028]
//* #4    JFF  10/03/2008  Modif suite Bug [SUISSE].LOT3
//* #5    JFF  24/04/2008  [DCMP080329] Rechercher existance appareil pour DARTY TEL
//*       JFF  02/12/2011  [VDOC6178] plus de TVA pour DARTY, les prix sont en TTC. 
//*-----------------------------------------------------------------

Int iRet
Long	lTotLigFourn, lRow, lCount, lCpt, lTotLigArticle
String	sIdFour, sIdRefFour, sIdTypArt, sIdMarqArt, sIdModlArt, sUntMonnaie, sNull, sIdMqIfr, sIdModlIfr, sIdTypArtRef
String sIdMarqArtIFr , sIdModlArtIFr 
Decimal {2}	dcTvaParDefaut
Boolean bBaseEuro, bInsert
Decimal {2} dcPrixHt
DateTime dt

iRet = 1
alNbInsert = 0
alNbDelete = 0
SetNull ( sNull )
dt = DateTime ( Today (), Now () )

// [VDOC6178] 
//dcTvaParDefaut = 19.6
dcTvaParDefaut = 0

/*------------------------------------------------------------------*/
/* Article de R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour le filtre sur l'existant en base       */
/*------------------------------------------------------------------*/
// #3
sIdTypArtRef = Upper ( Trim ( idwFicFourn.GetItemString ( 1, "ID_TYP_ART"  ) ) )

idwArticle.Reset ()
// [SUISSE].LOT3 Suppression mecanique conversion $$HEX2$$e0002000$$ENDHEX$$l'integration article
///*------------------------------------------------------------------*/
///* Euro ou Frf ?                                                    */
///*------------------------------------------------------------------*/
//lCount = 0
//SELECT Count (*)
//INTO	 :lCount
//FROM   sysadm.parametre
//WHERE  ref_cpt = 'EURO'
//USING  SQLCA ;
//		
//bBaseEuro = lCount > 0 	

/*------------------------------------------------------------------*/
/* Chargement de la table actuelle                                  */
/*------------------------------------------------------------------*/
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
idwArticle.Retrieve ( sIdFour, "*" )

idwArticle.SetFilter ( "ID_TYP_ART = '" + sIdTypArtRef + "'" )
idwArticle.Filter ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans le fichier                                    */
/*------------------------------------------------------------------*/
lTotLigFourn = idwFicFourn.RowCount ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table                                      */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Initilisation de la trace d'int$$HEX1$$e900$$ENDHEX$$gration.                         */
/*------------------------------------------------------------------*/
This.uf_Trace_2 ( "INIT", 0, sIdFour, "", "", "", "" )

/*------------------------------------------------------------------*/
/* MAJ de la DW avec le fichier.                                    */
/*------------------------------------------------------------------*/
For alNbLig = 1 To lTotLigFourn

	sIdFour 	   = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_REF_FOUR" ) ) )

	sIdModlArt = f_remplace( sIdModlArt , '"', 'P') // #2

	lRow = idwArticle.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwArticle.RowCount () )

	If lRow <= 0 Then 
		bInsert = True
		lRow = idwArticle.InsertRow ( 0 )
		alNbInsert ++
		idwArticle.SetItem ( lRow, "ID_FOUR", 	 sIdFour	  )				
		idwArticle.SetItem ( lRow, "ID_REF_FOUR",  sIdRefFour  )				
		idwArticle.SetItem ( lRow, "ID_TYP_ART",	 sIdTypArt	  )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART",	 sIdMarqArt	  )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART",	 sIdModlArt	  )				
		idwArticle.SetItem ( lRow, "ALT_DISPO",	 "N"	 )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "TVA", dcTvaParDefaut )
		idwArticle.SetItem ( lRow, "CREE_LE", dt )		
	Else
		bInsert = False
	End If

	If lRow > 0 Then 
// [SUISSE].LOT3 Suppression mecanique conversion $$HEX2$$e0002000$$ENDHEX$$l'integration article
//		dcPrixHt = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_HT" )
//		sUntMonnaie = Upper ( idwFicFourn.GetItemString ( alNbLig, "UNT_MONNAIE" ) )
//
//		// Base SIMPA2 en FRANCS Fran$$HEX1$$e700$$ENDHEX$$ais
//		If Not bBaseEuro Then
//		
//			CHOOSE CASE  sUntMonnaie 
//				CASE "FRF"
//					idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								
//				CASE "EUR"
//					idwArticle.SetItem ( lRow, "MT_PRIX_HT", Round ( dcPrixHt  * stGlb.tx_Euro, 2 )  )								
//			END CHOOSE
//
//		// Base SIMPA2 en EUROS
//		Else
//			CHOOSE CASE  sUntMonnaie 
//				CASE "FRF"
//					idwArticle.SetItem ( lRow, "MT_PRIX_HT", Round ( dcPrixHt  / stGlb.tx_Euro, 2 )  )								
//				CASE "EUR"
//					idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt  )								
//			END CHOOSE
//
//		End If

		// #4 [SUISSE].LOT3
		dcPrixHt = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_HT" )
		idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								
		// :#4

		/*------------------------------------------------------------------*/
		/* Code $$HEX1$$e900$$ENDHEX$$tat (-EI)                                                  */
		/* 200 Nouveau                                                      */
		/* 100 MAj_Ok sur existant                                          */
		/*------------------------------------------------------------------*/
		If bInsert Then
			idwArticle.SetItem ( lRow, "COD_ETAT", 200 )		
			This.uf_Trace_2 ( "ECR_AUTO", 200, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		Else
			idwArticle.SetItem ( lRow, "COD_ETAT", 100 )		

			sIdMqIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MARQ_ART_IFR" ) )
			sIdModlIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MODL_ART_IFR" ) )

			/*------------------------------------------------------------------*/
			/* Si les marques et mod$$HEX1$$e800$$ENDHEX$$les IFR sont absent de l'enregistrement    */
			/* exisant, on force ALT_DIPSPO $$HEX2$$e0002000$$ENDHEX$$NON.                              */
			/*------------------------------------------------------------------*/
			If Isnull ( sIdMqIfr ) Or sIdMqIfr = "" Or Isnull ( sIdModlIfr ) Or sIdModlIfr = "" Then
				idwArticle.SetItem ( lRow, "ALT_DISPO", "N" )				
			End If

			This.uf_Trace_2 ( "ECR_AUTO", 100, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		End If

		// #1 #3
		// [VDOC6993]
		Choose Case sIdTypArt 
			Case "TEL", "PC1", "PC2" 
				// Doit $$HEX1$$ea00$$ENDHEX$$tre mis $$HEX2$$e0002000$$ENDHEX$$la main pas Cell. Parte.

				// [VDOC6993]
				If bInsert Then
					sIdMarqArtIFr = Space (35) 
					sIdModlArtIFr = Space (35) 
					SQLCA.PS_S_VDOC6993_LIEN_ARTICLE ( sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, sIdMarqArtIFr, sIdModlArtIFr ) 
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR", sIdMarqArtIFr )				
					End If
					
					If Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR", sIdModlArtIFr )				
					End If
					
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) And &
						Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
					End If
				End If
			Case Else
				idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
		End Choose
		// #1 FIN
		
// #5 [DCMP080329] 
// 	idwArticle.SetItem ( lRow, "QT_DISP", idwFicFourn.GetItemNumber ( alNbLig, "QT_DISP" ) )
		idwArticle.SetItem ( lRow, "QT_DISP", 20000 )
// :#5 [DCMP080329] 		
		idwArticle.SetItem ( lRow, "OBSERV_FRN", Upper ( idwFicFourn.GetItemString ( alNbLig, "OBSERV_FRN" ) ) )
		idwArticle.SetItem ( lRow, "VERROU", 1 )
		idwArticle.SetItem ( lRow, "MAJ_LE", dt )		
		idwArticle.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )		

	End If

Next

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table (r$$HEX1$$e900$$ENDHEX$$actualis$$HEX1$$e900$$ENDHEX$$)                        */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Suppression des lignes pr$$HEX1$$e900$$ENDHEX$$sentes dans la table articles et       */
/* absentes du fichier.                                             */
/*------------------------------------------------------------------*/
For lCpt = lTotLigArticle To 1 Step -1

	sIdFour 	   = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	lRow = idwFicFourn.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwFicFourn.RowCount () )

	If lRow <= 0 Then 
		alNbDelete ++
		idwArticle.DeleteRow ( lCpt )
		This.uf_Trace_2 ( "ECR_AUTO", 300, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
	End If

Next 

idwArticle.SetFilter ( "" )
idwArticle.Filter ()

return iRet 
end function

private function integer uf_integration_fichier_dme (ref long alnblig, ref long alnbinsert, ref long alnbdelete);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Integration_Fichier_DME (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 04/04/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Int$$HEX1$$e900$$ENDHEX$$gration du fichier ORANGE/DME dans la base
//* Commentaires	: 
//*
//* Arguments		: Long		alNbLig		Ref
//*					  Long		alNbInsert	Ref
//*					  Long		alNbDelete	Ref
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1    JFF    10/03/2008  Modif suite Bug [SUISSE].LOT3
//*       JFF    26/05/2011  [PC505]
//        JFF    19/11/2013 [DT_60_AUGM_TVA]
//*-----------------------------------------------------------------

Int iRet
Long	lTotLigFourn, lRow, lCount, lCpt, lTotLigArticle
String	sIdFour, sIdRefFour, sIdTypArt, sIdMarqArt, sIdModlArt, sUntMonnaie, sNull, sIdMqIfr, sIdModlIfr, sIdTypArtRef
String sIdMarqArtIFr , sIdModlArtIFr 
Decimal {2}	dcTvaParDefaut
Boolean bBaseEuro, bInsert
Decimal {2} dcPrixHt
DateTime dt

iRet = 1
alNbInsert = 0
alNbDelete = 0
SetNull ( sNull )

// [DT_60_AUGM_TVA] 1.196
dcTvaParDefaut = 20

dt = DateTime ( Today (), Now () )

/*------------------------------------------------------------------*/
/* Article de R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour le filtre sur l'existant en base       */
/*------------------------------------------------------------------*/
// [PC505]
// sIdTypArtRef = Upper ( Trim ( idwFicFourn.GetItemString ( 1, "ID_TYP_ART"  ) ) )

idwArticle.Reset ()

/*------------------------------------------------------------------*/
/* Chargement de la table actuelle                                  */
/*------------------------------------------------------------------*/
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
idwArticle.Retrieve ( sIdFour, "*" )

// [PC505]
// idwArticle.SetFilter ( "ID_TYP_ART = '" + sIdTypArtRef + "'" )
// idwArticle.Filter ()


/*------------------------------------------------------------------*/
/* Nbre de ligne dans le fichier                                    */
/*------------------------------------------------------------------*/
lTotLigFourn = idwFicFourn.RowCount ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table                                      */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Initilisation de la trace d'int$$HEX1$$e900$$ENDHEX$$gration.                         */
/*------------------------------------------------------------------*/
This.uf_Trace_2 ( "INIT", 0, sIdFour, "", "", "", "" )

/*------------------------------------------------------------------*/
/* MAJ de la DW avec le fichier.                                    */
/*------------------------------------------------------------------*/
For alNbLig = 1 To lTotLigFourn

	sIdFour 	   = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_REF_FOUR" ) ) )

	lRow = idwArticle.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwArticle.RowCount () )

	If lRow <= 0 Then 
		bInsert = True
		lRow = idwArticle.InsertRow ( 0 )
		alNbInsert ++
		idwArticle.SetItem ( lRow, "ID_FOUR", 	 sIdFour	  )				
		idwArticle.SetItem ( lRow, "ID_REF_FOUR",  sIdRefFour  )				
		idwArticle.SetItem ( lRow, "ID_TYP_ART",	 sIdTypArt	  )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART",	 sIdMarqArt	  )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART",	 sIdModlArt	  )				
		idwArticle.SetItem ( lRow, "ALT_DISPO",	 "N"	 )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "TVA", dcTvaParDefaut )		
		idwArticle.SetItem ( lRow, "CREE_LE", dt )		
	Else
		bInsert = False
	End If

	If lRow > 0 Then 
// [SUISSE].LOT3 Suppression mecanique conversion $$HEX2$$e0002000$$ENDHEX$$l'integration article
//		dcPrixHt = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_HT" )
//		sUntMonnaie = Upper ( idwFicFourn.GetItemString ( alNbLig, "UNT_MONNAIE" ) )
//
//		// Base SIMPA2 en FRANCS Fran$$HEX1$$e700$$ENDHEX$$ais
//		If Not bBaseEuro Then
//		
//			CHOOSE CASE  sUntMonnaie 
//				CASE "FRF"
//					idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								
//				CASE "EUR"
//					idwArticle.SetItem ( lRow, "MT_PRIX_HT", Round ( dcPrixHt  * stGlb.tx_Euro, 2 )  )								
//			END CHOOSE
//
//		// Base SIMPA2 en EUROS
//		Else
//			CHOOSE CASE  sUntMonnaie 
//				CASE "FRF"
//					idwArticle.SetItem ( lRow, "MT_PRIX_HT", Round ( dcPrixHt  / stGlb.tx_Euro, 2 )  )								
//				CASE "EUR"
//					idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt  )								
//			END CHOOSE
//
//		End If

		// #1 [SUISSE].LOT3
		dcPrixHt = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_HT" )
		idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								
		// :#1

		/*------------------------------------------------------------------*/
		/* Code $$HEX1$$e900$$ENDHEX$$tat (-EI)                                                  */
		/* 200 Nouveau                                                      */
		/* 100 MAj_Ok sur existant                                          */
		/*------------------------------------------------------------------*/
		If bInsert Then
			idwArticle.SetItem ( lRow, "COD_ETAT", 200 )		
			This.uf_Trace_2 ( "ECR_AUTO", 200, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		Else
			idwArticle.SetItem ( lRow, "COD_ETAT", 100 )		

			sIdMqIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MARQ_ART_IFR" ) )
			sIdModlIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MODL_ART_IFR" ) )

			/*------------------------------------------------------------------*/
			/* Si les marques et mod$$HEX1$$e800$$ENDHEX$$les IFR sont absent de l'enregistrement    */
			/* exisant, on force ALT_DIPSPO $$HEX2$$e0002000$$ENDHEX$$NON.                              */
			/*------------------------------------------------------------------*/
			If Isnull ( sIdMqIfr ) Or sIdMqIfr = "" Or Isnull ( sIdModlIfr ) Or sIdModlIfr = "" Then
				idwArticle.SetItem ( lRow, "ALT_DISPO", "N" )				
			End If

			This.uf_Trace_2 ( "ECR_AUTO", 100, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		End If

		Choose Case sIdTypArt 
			Case "TEL", "PC1", "PC2" 
				// Doit $$HEX1$$ea00$$ENDHEX$$tre mis $$HEX2$$e0002000$$ENDHEX$$la main pas Cell. Parte.
				// [VDOC6993]
				If bInsert Then
					sIdMarqArtIFr = Space (35) 
					sIdModlArtIFr = Space (35) 
					SQLCA.PS_S_VDOC6993_LIEN_ARTICLE ( sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, sIdMarqArtIFr, sIdModlArtIFr ) 
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR", sIdMarqArtIFr )				
					End If
					
					If Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR", sIdModlArtIFr )				
					End If
					
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) And &
						Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
					End If
				End If				
			Case Else
				idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
		End Choose

		idwArticle.SetItem ( lRow, "QT_DISP", idwFicFourn.GetItemNumber ( alNbLig, "QT_DISP" ) )
		idwArticle.SetItem ( lRow, "OBSERV_FRN", Upper ( idwFicFourn.GetItemString ( alNbLig, "OBSERV_FRN" ) ) )
		idwArticle.SetItem ( lRow, "VERROU", 1 )
		idwArticle.SetItem ( lRow, "MAJ_LE", dt )		
		idwArticle.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )		

	End If

Next

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table (r$$HEX1$$e900$$ENDHEX$$actualis$$HEX1$$e900$$ENDHEX$$)                        */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Suppression des lignes pr$$HEX1$$e900$$ENDHEX$$sentes dans la table articles et       */
/* absentes du fichier.                                             */
/*------------------------------------------------------------------*/
For lCpt = lTotLigArticle To 1 Step -1

	sIdFour 	   = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	lRow = idwFicFourn.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwFicFourn.RowCount () )

	If lRow <= 0 Then 
		alNbDelete ++
		idwArticle.DeleteRow ( lCpt )
		This.uf_Trace_2 ( "ECR_AUTO", 300, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
	End If

Next 

idwArticle.SetFilter ( "" )
idwArticle.Filter ()

return iRet 
end function

private function integer uf_ctrl_fichier_cegetel ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Ctrl_Fichier_CEGETEL (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 16/06/2005
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler de la validit$$HEX2$$e9002000$$ENDHEX$$du fichier Article de CEGETEL
//* Commentaires	: 
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    19/10/2009  [DCMP090615]
//* 		 JFF     03/05/2011 [PM166][O2M]
//			FPI	27/07/2012	[DT018] ajout du code 1F4
//*-----------------------------------------------------------------

Int iRet 
String	sIdFour, sVal, sCar, sSort, sIdRefFourPrec, sTypArtSav
Long		lTotLig, lCpt, lCptVal, lTotArt, lLen
Boolean	bTrouve

iRet = 1

lTotLig = idwFicFourn.RowCount ()
lTotArt = idwArtSpb.RowCount ()
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sTypArtSav = ""

// JFF 20/01/2011 : le tri imp$$HEX1$$e900$$ENDHEX$$ratif sur ID_REF_FOUR $$HEX1$$e900$$ENDHEX$$tait visiblement manquant (?..)
idwFicFourn.SetSort ( "ID_REF_FOUR A" )
idwFicFourn.Sort ()

sIdRefFourPrec = ""

/*------------------------------------------------------------------*/
/* Attention, pour ce fournisseur, l'int$$HEX1$$e900$$ENDHEX$$gration d'article n'est pos*/
/* n'est possible que s'il ne reste pas de commande $$HEX2$$e0002000$$ENDHEX$$g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rer       */
/*------------------------------------------------------------------*/
If SQLCA.PS_S08_COMMANDE ( sIdFour ) > 0  Then
		iRet = -1
		This.uf_Trace ( "ECR", "ARRET ! : Chargement Fic article impossible, il reste des commandes $$HEX2$$e0002000$$ENDHEX$$g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rer pour le fournisseur " + sIdFour )
		This.uf_Trace ( "ECR", "ARRET ! : G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rer d'abord un fichier de commande pour " + sIdFour + " et relancer le trt d int$$HEX1$$e900$$ENDHEX$$gration article." )
		Return iRet
End IF


For lCpt = 1 To lTotLig 

	/*------------------------------------------------------------------*/
	/* ZONE 1 : ID_FOUR                                                */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone fournisseur est vide." )
	End If 

	If sVal <> sIdFour Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fournisseur " + sVal + " ne correspond pas au fournisseur s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$" + sIdFour )
	End If 

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La longueur du fournisseur doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If
	
	/*------------------------------------------------------------------*/
	/* ZONE 2 : ID_TYP_ART                                              */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_TYP_ART" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Type Article est vide." )
	End If 

	// Le fichier ne doit que contenir que des appareils du m$$HEX1$$ea00$$ENDHEX$$me type
	/*
	// #1 [DCMP090615]
	If sTypArtSav <> sVal And sTypArtSav <> "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fichier contient des types d'appareils diff$$HEX1$$e900$$ENDHEX$$rents !" )
	End If
	*/

	If Not IsNull ( sVal ) And sVal <> "" Then
	  sTypArtSav = sVal
	End If

	bTrouve = False
	lCptVal = 1
	Do While Not bTrouve And lCptVal <= lTotArt
		bTrouve = sVal = Upper ( idwArtSpb.GetItemString ( lCptVal, "ID_CODE" ) )
		lCptVal ++
	Loop

	If Not bTrouve Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type d'article " + sVal + " n'existe pas dans la base SIMPA2.")
	End If

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type de l'article doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If		

	/*------------------------------------------------------------------*/
	/* ZONE 3 : ID_MARQ_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MARQ_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Marque Article est vide." )
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 4 : ID_MODL_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MODL_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone mod$$HEX1$$e800$$ENDHEX$$le article est vide." )
	Else

		If Pos ( sVal, "'", 1 ) > 0 Then
			This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (ID_MODL_ART) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "ID_MODL_ART", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 5 : MT_PRIX_HT															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemDecimal ( lCpt, "MT_PRIX_HT" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Prix Hors Taxe est vide." )
	End If 

	lLen = Len ( sVal )
	
	// Marque la virgule
	bTrouve = False

	For lCptVal = 1 To lLen 
		sCar = Mid ( sVal, lCptVal, 1 )
		If sCar = "." Then
			If Not bTrouve Then 
				bTrouve = True
			Else
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, il y a deux virgules." )
				Exit
			End If

		Else
			If Not ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) Then
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, un caract$$HEX1$$e800$$ENDHEX$$re n'est pas un chiffre." )
				Exit
			End If
		End If
	Next	

	If Real ( sVal ) > 5000 Then		
		This.uf_Trace ( "ECR", "AVERTISSEMENT ligne " + String ( lCpt ) + &
		" : Le montant " + sVal + " para$$HEX1$$ee00$$ENDHEX$$t anormalement grand." )
	End If

	
	/*------------------------------------------------------------------*/
	/* ZONE 6 : UNT_MONNAIE															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "UNT_MONNAIE" ) ) )
	// [SUISSE].LOT3 Controle de la monnaie du fichier
	// Si pas de coh$$HEX1$$e900$$ENDHEX$$rence : erreur bloquante d'int$$HEX1$$e900$$ENDHEX$$gration.
	if uf_controler_monnaie_fichier (sVal, lCpt) < 0 Then iRet = -1
	
//	If IsNull ( sVal ) Or sVal = "" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : L'unit$$HEX2$$e9002000$$ENDHEX$$de la monnaie est vide." )
//	End If 
//
//	If sVal <> "FRF" And sVal <> "EUR" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : La monnaie " + sVal + " n'est pas valide." )
//		Exit
//	End If

	/*------------------------------------------------------------------*/
	/* ZONE 8 : OBSERV_FRN 															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )

	If Not IsNull ( sVal ) And sVal <> "" Then
		If Pos ( sVal, "'", 1 ) > 0 Then
			This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (OBSERV_FRN) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "OBSERV_FRN", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 
	// [PM166][O2M]
	If IsNull ( sVal ) Then sVal = "" 
	sVal += "[#2F1#]" 
	sVal+= "[#1F4#]" // [DT018] 
	idwFicFourn.SetItem ( lCpt, "OBSERV_FRN", sVal ) 
	// :[PM166][O2M]
	
	/*------------------------------------------------------------------*/
	/* #1																					  */
	/*------------------------------------------------------------------*/
	/* ZONE 1 BIS : ID_REF_FOUR													  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur est vide." )
	ElseIf sIdRefFourPrec <> "" And sVal = sIdRefFourPrec Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sVal + " n'est pas unique." )
		
	End If

	sIdRefFourPrec = sVal

Next

If iRet < 0 Then This.uf_Trace ( "ECR", "ERREUR : Le fichier fournisseur n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$.")

Return iRet


end function

private function integer uf_integration_fichier_cegetel (ref long alnblig, ref long alnbinsert, ref long alnbdelete);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Integration_Fichier_CEGETEL (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 04/04/2003
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Int$$HEX1$$e900$$ENDHEX$$gration du fichier DEBITEL dans la base
//* Commentaires	: 
//*
//* Arguments		: Long		alNbLig		Ref
//*					  Long		alNbInsert	Ref
//*					  Long		alNbDelete	Ref
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1		JCA	01/09/2006	On force la quantit$$HEX4$$e9002000e0002000$$ENDHEX$$5000
//* #2		JFF	12/09/2006	[DCMP070645] On ajoute 20 Euros au montant HT lors de l'int$$HEX1$$e900$$ENDHEX$$gration
//*									sur demain d'OMG (Mathias)
//* #3    JFF    10/03/2008  Modif suite Bug [SUISSE].LOT3
//* #4    JFF    17/04/2008  [DCMP080322] suppression des 20 Euros
//* #5    JFF    19/10/2009  [DCMP090615]
//			FPI	24/01/2012	[PC581] Int$$HEX1$$e900$$ENDHEX$$gration de TPC
//       JFF   26/08/2013 [DT57_CMDE_IPHONE_SFR]
//        JFF   19/11/2013 [DT_60_AUGM_TVA]
//*-----------------------------------------------------------------

Int iRet
Long	lTotLigFourn, lRow, lCount, lCpt, lTotLigArticle, lPosSlash 
String	sIdFour, sIdRefFour, sIdTypArt, sIdMarqArt, sIdModlArt, sUntMonnaie, sNull, sIdMqIfr, sIdModlIfr, sIdTypArtRef
String sIdMarqArtIFr , sIdModlArtIFr, sDonneurOrdre, sDonneurOrdreSav, sIdRefFourSeul, sIdRefFourSeulSav, sObservFrn 
Decimal {2}	dcTvaParDefaut, dcPrixHtSav
Boolean bBaseEuro, bInsert
Decimal {2} dcPrixHt
DateTime dt

iRet = 1
alNbInsert = 0
alNbDelete = 0
SetNull ( sNull )

// [DT_60_AUGM_TVA] 1.196
dcTvaParDefaut = 20

dt = DateTime ( Today (), Now () )

/*------------------------------------------------------------------*/
/* Article de R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour le filtre sur l'existant en base       */
/*------------------------------------------------------------------*/
//* #5    JFF    19/10/2009  [DCMP090615]
// sIdTypArtRef = Upper ( Trim ( idwFicFourn.GetItemString ( 1, "ID_TYP_ART" ) ) )
//* :#5    JFF    19/10/2009  [DCMP090615]

idwArticle.Reset ()


/*------------------------------------------------------------------*/
/* Chargement de la table actuelle                                  */
/*------------------------------------------------------------------*/
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
idwArticle.Retrieve ( sIdFour, "*" )
//* #5    JFF    19/10/2009  [DCMP090615]
// idwArticle.SetFilter ( "ID_TYP_ART = '" + sIdTypArtRef + "'" )
// idwArticle.Filter ()
//* :#5    JFF    19/10/2009  [DCMP090615]

/*------------------------------------------------------------------*/
/* Nbre de ligne dans le fichier                                    */
/*------------------------------------------------------------------*/
lTotLigFourn = idwFicFourn.RowCount ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table                                      */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Initilisation de la trace d'int$$HEX1$$e900$$ENDHEX$$gration.                         */
/*------------------------------------------------------------------*/
This.uf_Trace_2 ( "INIT", 0, sIdFour, "", "", "", "" )

/*------------------------------------------------------------------*/
/* MAJ de la DW avec le fichier.                                    */
/*------------------------------------------------------------------*/
For alNbLig = 1 To lTotLigFourn

	sIdFour 	   = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_REF_FOUR" ) ) )

	lRow = idwArticle.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwArticle.RowCount () )

	If lRow <= 0 Then 
		bInsert = True
		lRow = idwArticle.InsertRow ( 0 )
		alNbInsert ++
		idwArticle.SetItem ( lRow, "ID_FOUR", 	 sIdFour	  )				
		idwArticle.SetItem ( lRow, "ID_REF_FOUR",  sIdRefFour  )				
		idwArticle.SetItem ( lRow, "ID_TYP_ART",	 sIdTypArt	  )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART",	 sIdMarqArt	  )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART",	 sIdModlArt	  )				
		idwArticle.SetItem ( lRow, "ALT_DISPO",	 "N"	 )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "TVA", dcTvaParDefaut )		
		idwArticle.SetItem ( lRow, "CREE_LE", dt )		
	Else
		bInsert = False
	End If

	If lRow > 0 Then 

		// #3 [SUISSE].LOT3
		dcPrixHt = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_HT" )
		idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								
		// :#3

		/*------------------------------------------------------------------*/
		/* Code $$HEX1$$e900$$ENDHEX$$tat (-EI)                                                  */
		/* 200 Nouveau                                                      */
		/* 100 MAj_Ok sur existant                                          */
		/*------------------------------------------------------------------*/
		If bInsert Then
			idwArticle.SetItem ( lRow, "COD_ETAT", 200 )		
			This.uf_Trace_2 ( "ECR_AUTO", 200, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		Else
			idwArticle.SetItem ( lRow, "COD_ETAT", 100 )		
			sIdMqIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MARQ_ART_IFR" ) )
			sIdModlIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MODL_ART_IFR" ) )

			/*------------------------------------------------------------------*/
			/* Si les marques et mod$$HEX1$$e800$$ENDHEX$$les IFR sont absent de l'enregistrement    */
			/* exisant, on force ALT_DIPSPO $$HEX2$$e0002000$$ENDHEX$$NON.                              */
			/*------------------------------------------------------------------*/
			If Isnull ( sIdMqIfr ) Or sIdMqIfr = "" Or Isnull ( sIdModlIfr ) Or sIdModlIfr = "" Then
				idwArticle.SetItem ( lRow, "ALT_DISPO", "N" )				
			End If

			This.uf_Trace_2 ( "ECR_AUTO", 100, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		End If

		// [PC581] - Int$$HEX1$$e900$$ENDHEX$$gration de TPC -> ALT_DISPO $$HEX2$$e0002000$$ENDHEX$$Oui
		Choose Case sIdTypArt 
			Case "TEL", "PC1", "PC2" 
				// Doit $$HEX1$$ea00$$ENDHEX$$tre mis $$HEX2$$e0002000$$ENDHEX$$la main pas Cell. Parte.
				// [VDOC6993]
				If bInsert Then
					sIdMarqArtIFr = Space (35) 
					sIdModlArtIFr = Space (35) 
					SQLCA.PS_S_VDOC6993_LIEN_ARTICLE ( sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, sIdMarqArtIFr, sIdModlArtIFr ) 
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR", sIdMarqArtIFr )				
					End If
					
					If Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR", sIdModlArtIFr )				
					End If
					
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) And &
						Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
					End If
				End If				
			Case Else
				idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
		End Choose

		// #1
		idwArticle.SetItem ( lRow, "QT_DISP", 5000 )
		idwArticle.SetItem ( lRow, "OBSERV_FRN", Upper ( idwFicFourn.GetItemString ( alNbLig, "OBSERV_FRN" ) ) )
		idwArticle.SetItem ( lRow, "VERROU", 1 )
		idwArticle.SetItem ( lRow, "MAJ_LE", dt )		
		idwArticle.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )		

	End If

Next

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table (r$$HEX1$$e900$$ENDHEX$$actualis$$HEX1$$e900$$ENDHEX$$)                        */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Suppression des lignes pr$$HEX1$$e900$$ENDHEX$$sentes dans la table articles et       */
/* absentes du fichier.                                             */
/*------------------------------------------------------------------*/
For lCpt = lTotLigArticle To 1 Step -1

	sIdFour 	   = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	lRow = idwFicFourn.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwFicFourn.RowCount () )

	If lRow <= 0 Then 
		alNbDelete ++
		idwArticle.DeleteRow ( lCpt )
		This.uf_Trace_2 ( "ECR_AUTO", 300, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
	End If

Next 

idwArticle.SetFilter ( "" )
idwArticle.Filter ()

return iRet 
end function

private function integer uf_integration_fichier_mobistore (ref long alnblig, ref long alnbinsert, long alnbdelete);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Integration_Fichier_MOBISTORE (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 09/11/2005
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Int$$HEX1$$e900$$ENDHEX$$gration du fichier DEBITEL dans la base
//* Commentaires	: 
//*
//* Arguments		: Long		alNbLig		Ref
//*					  Long		alNbInsert	Ref
//*					  Long		alNbDelete	Ref
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1    JFF    10/03/2008  Modif suite Bug [SUISSE].LOT3
//* #2    JFF    27/03/2009  [DCMP090130] Mobistore
//*       JFF    01/09/2011  [PC10][DIAG_NOMADE]
//			 JFF	  03/09/2012  [PC853]
//*-----------------------------------------------------------------

Int iRet
Long	lTotLigFourn, lRow, lCount, lCpt, lTotLigArticle
String	sIdFour, sIdRefFour, sIdTypArt, sIdMarqArt, sIdModlArt, sUntMonnaie, sNull, sIdMqIfr, sIdModlIfr, sIdTypArtRef
String sIdMarqArtIFr , sIdModlArtIFr 
Decimal {2}	dcTvaParDefaut
Boolean bBaseEuro, bInsert
Decimal {2} dcPrixHt
DateTime dt

iRet = 1
alNbInsert = 0
alNbDelete = 0
SetNull ( sNull )
dcTvaParDefaut = 20
dt = DateTime ( Today (), Now () )

//	[PC853][VDOC10913]
dcTvaParDefaut = 0

/*------------------------------------------------------------------*/
/* Article de R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour le filtre sur l'existant en base       */
/*------------------------------------------------------------------*/

// [PC10][DIAG_NOMADE]
// sIdTypArtRef = Upper ( Trim ( idwFicFourn.GetItemString ( 1, "ID_TYP_ART"  ) ) )

idwArticle.Reset ()

// [SUISSE].LOT3 Suppression mecanique conversion $$HEX2$$e0002000$$ENDHEX$$l'integration article
///*------------------------------------------------------------------*/
///* Euro ou Frf ?                                                    */
///*------------------------------------------------------------------*/
//lCount = 0
//SELECT Count (*)
//INTO	 :lCount
//FROM   sysadm.parametre
//WHERE  ref_cpt = 'EURO'
//USING  SQLCA ;
//		
//bBaseEuro = lCount > 0 	

/*------------------------------------------------------------------*/
/* Chargement de la table actuelle                                  */
/*------------------------------------------------------------------*/
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
idwArticle.Retrieve ( sIdFour, "*" )

// [PC10][DIAG_NOMADE]
// idwArticle.SetFilter ( "ID_TYP_ART = '" + sIdTypArtRef + "'" )
// idwArticle.Filter ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans le fichier                                    */
/*------------------------------------------------------------------*/
lTotLigFourn = idwFicFourn.RowCount ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table                                      */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Initilisation de la trace d'int$$HEX1$$e900$$ENDHEX$$gration.                         */
/*------------------------------------------------------------------*/
This.uf_Trace_2 ( "INIT", 0, sIdFour, "", "", "", "" )

/*------------------------------------------------------------------*/
/* MAJ de la DW avec le fichier.                                    */
/*------------------------------------------------------------------*/
For alNbLig = 1 To lTotLigFourn

	sIdFour 	   = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_REF_FOUR" ) ) )

	lRow = idwArticle.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwArticle.RowCount () )

	If lRow <= 0 Then 
		bInsert = True
		lRow = idwArticle.InsertRow ( 0 )
		alNbInsert ++
		idwArticle.SetItem ( lRow, "ID_FOUR", 	 sIdFour	  )				
		idwArticle.SetItem ( lRow, "ID_REF_FOUR",  sIdRefFour  )				
		idwArticle.SetItem ( lRow, "ID_TYP_ART",	 sIdTypArt	  )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART",	 sIdMarqArt	  )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART",	 sIdModlArt	  )				
		idwArticle.SetItem ( lRow, "ALT_DISPO",	 "N"	 )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "TVA", dcTvaParDefaut )
		idwArticle.SetItem ( lRow, "CREE_LE", dt )		
	Else
		bInsert = False
	End If

	If lRow > 0 Then 
// [SUISSE].LOT3 Suppression mecanique conversion $$HEX2$$e0002000$$ENDHEX$$l'integration article
//		dcPrixHt = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_HT" )
//		sUntMonnaie = Upper ( idwFicFourn.GetItemString ( alNbLig, "UNT_MONNAIE" ) )
//
//		// Base SIMPA2 en FRANCS Fran$$HEX1$$e700$$ENDHEX$$ais
//		If Not bBaseEuro Then
//		
//			CHOOSE CASE  sUntMonnaie 
//				CASE "FRF"
//					idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								
//				CASE "EUR"
//					idwArticle.SetItem ( lRow, "MT_PRIX_HT", Round ( dcPrixHt  * stGlb.tx_Euro, 2 )  )								
//			END CHOOSE
//
//		// Base SIMPA2 en EUROS
//		Else
//			CHOOSE CASE  sUntMonnaie 
//				CASE "FRF"
//					idwArticle.SetItem ( lRow, "MT_PRIX_HT", Round ( dcPrixHt  / stGlb.tx_Euro, 2 )  )								
//				CASE "EUR"
//					idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt  )								
//			END CHOOSE
//
//		End If

		// #1 [SUISSE].LOT3
		dcPrixHt = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_HT" )
		idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								
		// :#1

		/*------------------------------------------------------------------*/
		/* Code $$HEX1$$e900$$ENDHEX$$tat (-EI)                                                  */
		/* 200 Nouveau                                                      */
		/* 100 MAj_Ok sur existant                                          */
		/*------------------------------------------------------------------*/
		If bInsert Then
			idwArticle.SetItem ( lRow, "COD_ETAT", 200 )		
			This.uf_Trace_2 ( "ECR_AUTO", 200, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		Else
			idwArticle.SetItem ( lRow, "COD_ETAT", 100 )		

			sIdMqIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MARQ_ART_IFR" ) )
			sIdModlIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MODL_ART_IFR" ) )

			/*------------------------------------------------------------------*/
			/* Si les marques et mod$$HEX1$$e800$$ENDHEX$$les IFR sont absent de l'enregistrement    */
			/* exisant, on force ALT_DIPSPO $$HEX2$$e0002000$$ENDHEX$$NON.                              */
			/*------------------------------------------------------------------*/
			If Isnull ( sIdMqIfr ) Or sIdMqIfr = "" Or Isnull ( sIdModlIfr ) Or sIdModlIfr = "" Then
				idwArticle.SetItem ( lRow, "ALT_DISPO", "N" )				
			End If

			This.uf_Trace_2 ( "ECR_AUTO", 100, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		End If

		// [PC10][DIAG_NOMADE]
		Choose Case sIdTypArt 
			Case "TEL", "PC1", "PC2" 
				// Doit $$HEX1$$ea00$$ENDHEX$$tre mis $$HEX2$$e0002000$$ENDHEX$$la main pas Cell. Parte.
				// [VDOC6993]
				If bInsert Then
					sIdMarqArtIFr = Space (35) 
					sIdModlArtIFr = Space (35) 
					SQLCA.PS_S_VDOC6993_LIEN_ARTICLE ( sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, sIdMarqArtIFr, sIdModlArtIFr ) 
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR", sIdMarqArtIFr )				
					End If
					
					If Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR", sIdModlArtIFr )				
					End If
					
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) And &
						Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
					End If
				End If				
			Case Else
				idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
		End Choose

		idwArticle.SetItem ( lRow, "QT_DISP", 20000 ) // #2 [DCMP090130] 
		idwArticle.SetItem ( lRow, "OBSERV_FRN", Upper ( idwFicFourn.GetItemString ( alNbLig, "OBSERV_FRN" ) ) )
		idwArticle.SetItem ( lRow, "VERROU", 1 )
		idwArticle.SetItem ( lRow, "MAJ_LE", dt )		
		idwArticle.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )		

	End If

Next

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table (r$$HEX1$$e900$$ENDHEX$$actualis$$HEX1$$e900$$ENDHEX$$)                        */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Suppression des lignes pr$$HEX1$$e900$$ENDHEX$$sentes dans la table articles et       */
/* absentes du fichier.                                             */
/*------------------------------------------------------------------*/
For lCpt = lTotLigArticle To 1 Step -1

	sIdFour 	   = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	// [PC10][DIAG_NOMADE]
	Choose Case sIdTypArt
		Case "AEF", "CAF","DEV"
			Continue
	End Choose

	lRow = idwFicFourn.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwFicFourn.RowCount () )

	If lRow <= 0 Then 
		alNbDelete ++
		idwArticle.DeleteRow ( lCpt )
		This.uf_Trace_2 ( "ECR_AUTO", 300, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
	End If

Next 

idwArticle.SetFilter ( "" )
idwArticle.Filter ()

return iRet 
end function

private function integer uf_ctrl_fichier_mobistore ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Ctrl_Fichier_MOBISTORE (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 10/11/2005
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler de la validit$$HEX2$$e9002000$$ENDHEX$$du fichier de MOBISTORE
//* Commentaires	: 
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*      JFF   01/09/2011  [PC10][DIAG_NOMADE]
//*-----------------------------------------------------------------

Int iRet 
String	sIdFour, sVal, sCar, sSort, sIdRefFourPrec, sTypArtSav
Long		lTotLig, lCpt, lCptVal, lTotArt, lLen
Boolean	bTrouve

iRet = 1

lTotLig = idwFicFourn.RowCount ()
lTotArt = idwArtSpb.RowCount ()
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sTypArtSav = ""

// JFF 20/01/2011 : le tri imp$$HEX1$$e900$$ENDHEX$$ratif sur ID_REF_FOUR $$HEX1$$e900$$ENDHEX$$tait visiblement manquant (?..)
idwFicFourn.SetSort ( "ID_REF_FOUR A" )
idwFicFourn.Sort ()

sIdRefFourPrec = ""

For lCpt = 1 To lTotLig 

	/*------------------------------------------------------------------*/
	/* ZONE 1 : ID_FOUR                                                 */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone fournisseur est vide." )
	End If 

	If sVal <> sIdFour Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fournisseur " + sVal + " ne correspond pas au fournisseur s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$" + sIdFour )
	End If 

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La longueur du fournisseur doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If
	
	/*------------------------------------------------------------------*/
	/* ZONE 2 : ID_TYP_ART                                              */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_TYP_ART" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Type Article est vide." )
	End If 

	// Le fichier ne doit que contenir que des appareils du m$$HEX1$$ea00$$ENDHEX$$me type
	// [PC10][DIAG_NOMADE]
	/*
	If sTypArtSav <> sVal And sTypArtSav <> "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fichier contient des types d'appareils diff$$HEX1$$e900$$ENDHEX$$rents !" )
	End If
	*/

	If Not IsNull ( sVal ) And sVal <> "" Then
	  sTypArtSav = sVal
	End If

	bTrouve = False
	lCptVal = 1
	Do While Not bTrouve And lCptVal <= lTotArt
		bTrouve = sVal = Upper ( idwArtSpb.GetItemString ( lCptVal, "ID_CODE" ) )
		lCptVal ++
	Loop

	If Not bTrouve Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type d'article " + sVal + " n'existe pas dans la base SIMPA2.")
	End If

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type de l'article doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If		

	/*------------------------------------------------------------------*/
	/* ZONE 3 : ID_MARQ_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MARQ_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Marque Article est vide." )
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 4 : ID_MODL_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MODL_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone mod$$HEX1$$e800$$ENDHEX$$le article est vide." )
	Else

		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (ID_MODL_ART) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "ID_MODL_ART", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 5 : MT_PRIX_HT															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemDecimal ( lCpt, "MT_PRIX_HT" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Prix Hors Taxe est vide." )
	End If 

	lLen = Len ( sVal )
	
	// Marque la virgule
	bTrouve = False

	For lCptVal = 1 To lLen 
		sCar = Mid ( sVal, lCptVal, 1 )
		If sCar = "." Then
			If Not bTrouve Then 
				bTrouve = True
			Else
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, il y a deux virgules." )
				Exit
			End If

		Else
			If Not ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) Then
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, un caract$$HEX1$$e800$$ENDHEX$$re n'est pas un chiffre." )
				Exit
			End If
		End If
	Next	

	If Real ( sVal ) > 5000 Then		
		This.uf_Trace ( "ECR", "AVERTISSEMENT ligne " + String ( lCpt ) + &
		" : Le montant " + sVal + " para$$HEX1$$ee00$$ENDHEX$$t anormalement grand." )
	End If

	
	/*------------------------------------------------------------------*/
	/* ZONE 6 : UNT_MONNAIE															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "UNT_MONNAIE" ) ) )
	// [SUISSE].LOT3 Controle de la monnaie du fichier
	// Si pas de coh$$HEX1$$e900$$ENDHEX$$rence : erreur bloquante d'int$$HEX1$$e900$$ENDHEX$$gration.
	if uf_controler_monnaie_fichier (sVal, lCpt) < 0 Then iRet = -1
	
//	If IsNull ( sVal ) Or sVal = "" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : L'unit$$HEX2$$e9002000$$ENDHEX$$de la monnaie est vide." )
//	End If 
//
//	If sVal <> "FRF" And sVal <> "EUR" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : La monnaie " + sVal + " n'est pas valide." )
//		Exit
//	End If

	/*------------------------------------------------------------------*/
	/* ZONE 7 : QT_DISP																  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemNumber ( lCpt, "QT_DISP" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		idwFicFourn.SetItem ( lCpt, "QT_DISP", 0 ) 
		sVal = "0"
	End If 

	If Not IsNumber ( sVal ) Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La quantit$$HEX2$$e9002000$$ENDHEX$$" + sVal + " n'est pas valide, ce n'est pas un nombre." )
		
	End If


	/*------------------------------------------------------------------*/
	/* ZONE 8 : OBSERV_FRN 															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )

	If Not IsNull ( sVal ) And sVal <> "" Then
		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (OBSERV_FRN) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "OBSERV_FRN", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 


	/*------------------------------------------------------------------*/
	/* #1																					  */
	/*------------------------------------------------------------------*/
	/* ZONE 1 BIS : ID_REF_FOUR													  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur est vide." )
	ElseIf sIdRefFourPrec <> "" And sVal = sIdRefFourPrec Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sVal + " n'est pas unique." )
		
	End If

	sIdRefFourPrec = sVal

Next

If iRet < 0 Then This.uf_Trace ( "ECR", "ERREUR : Le fichier fournisseur n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$.")

Return iRet


end function

private function integer uf_ctrl_fichier_cordon ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_int_fic_article::uf_Ctrl_Fichier_CORDON (PRIVATE)
//* Auteur			: MADM
//* Date				: 10/05/2006
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler la validit$$HEX2$$e9002000$$ENDHEX$$du fichier de CORDON
//* Commentaires	: 
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

Int iRet 
String	sIdFour, sVal, sCar, sSort, sIdRefFourPrec, sTypArtSav
Long		lTotLig, lCpt, lCptVal, lTotArt, lLen
Boolean	bTrouve

iRet = 1

lTotLig = idwFicFourn.RowCount ()
lTotArt = idwArtSpb.RowCount ()
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sTypArtSav = ""

// JFF 20/01/2011 : le tri imp$$HEX1$$e900$$ENDHEX$$ratif sur ID_REF_FOUR $$HEX1$$e900$$ENDHEX$$tait visiblement manquant (?..)
idwFicFourn.SetSort ( "ID_REF_FOUR A" )
idwFicFourn.Sort ()

sIdRefFourPrec = ""

For lCpt = 1 To lTotLig 

	/*------------------------------------------------------------------*/
	/* ZONE 1 : ID_FOUR                                                */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone fournisseur est vide." )
	End If 

	If sVal <> sIdFour Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fournisseur " + sVal + " ne correspond pas au fournisseur s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$" + sIdFour )
	End If 

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La longueur du fournisseur doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If
	
	/*------------------------------------------------------------------*/
	/* ZONE 2 : ID_TYP_ART                                              */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_TYP_ART" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Type Article est vide." )
	End If 

	// Le fichier ne doit que contenir que des appareils du m$$HEX1$$ea00$$ENDHEX$$me type
	If sTypArtSav <> sVal And sTypArtSav <> "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fichier contient des types d'appareils diff$$HEX1$$e900$$ENDHEX$$rents !" )
	End If

	If Not IsNull ( sVal ) And sVal <> "" Then
	  sTypArtSav = sVal
	End If

	bTrouve = False
	lCptVal = 1
	Do While Not bTrouve And lCptVal <= lTotArt
		bTrouve = sVal = Upper ( idwArtSpb.GetItemString ( lCptVal, "ID_CODE" ) )
		lCptVal ++
	Loop

	If Not bTrouve Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type d'article " + sVal + " n'existe pas dans la base SIMPA2.")
	End If

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type de l'article doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If		

	/*------------------------------------------------------------------*/
	/* ZONE 3 : ID_MARQ_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MARQ_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Marque Article est vide." )
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 4 : ID_MODL_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MODL_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone mod$$HEX1$$e800$$ENDHEX$$le article est vide." )
	Else

		If Pos ( sVal, "'", 1 ) > 0 Then
			This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (ID_MODL_ART) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "ID_MODL_ART", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 5 : MT_PRIX_HT															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemDecimal ( lCpt, "MT_PRIX_HT" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Prix Hors Taxe est vide." )
	End If 

	lLen = Len ( sVal )
	
	// Marque la virgule
	bTrouve = False

	For lCptVal = 1 To lLen 
		sCar = Mid ( sVal, lCptVal, 1 )
		If sCar = "." Then
			If Not bTrouve Then 
				bTrouve = True
			Else
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, il y a deux virgules." )
				Exit
			End If

		Else
			If Not ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) Then
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, un caract$$HEX1$$e800$$ENDHEX$$re n'est pas un chiffre." )
				Exit
			End If
		End If
	Next	

	If Real ( sVal ) > 5000 Then		
		This.uf_Trace ( "ECR", "AVERTISSEMENT ligne " + String ( lCpt ) + &
		" : Le montant " + sVal + " para$$HEX1$$ee00$$ENDHEX$$t anormalement grand." )
	End If

	
	/*------------------------------------------------------------------*/
	/* ZONE 6 : UNT_MONNAIE															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "UNT_MONNAIE" ) ) )
	// [SUISSE].LOT3 Controle de la monnaie du fichier
	// Si pas de coh$$HEX1$$e900$$ENDHEX$$rence : erreur bloquante d'int$$HEX1$$e900$$ENDHEX$$gration.
	if uf_controler_monnaie_fichier (sVal, lCpt) < 0 Then iRet = -1
	
//	If IsNull ( sVal ) Or sVal = "" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : L'unit$$HEX2$$e9002000$$ENDHEX$$de la monnaie est vide." )
//	End If 
//
//	If sVal <> "FRF" And sVal <> "EUR" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : La monnaie " + sVal + " n'est pas valide." )
//		Exit
//	End If

	/*------------------------------------------------------------------*/
	/* ZONE 7 : QT_DISP																  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemNumber ( lCpt, "QT_DISP" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		idwFicFourn.SetItem ( lCpt, "QT_DISP", 0 ) 
		sVal = "0"
	End If 

	If Not IsNumber ( sVal ) Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La quantit$$HEX2$$e9002000$$ENDHEX$$" + sVal + " n'est pas valide, ce n'est pas un nombre." )
		
	End If

	/*------------------------------------------------------------------*/
	/* ZONE 8 : OBSERV_FRN 															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )

	If Not IsNull ( sVal ) And sVal <> "" Then
		If Pos ( sVal, "'", 1 ) > 0 Then
			This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (OBSERV_FRN) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "OBSERV_FRN", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 


	/*------------------------------------------------------------------*/
	/* #1																					  */
	/*------------------------------------------------------------------*/
	/* ZONE 1 BIS : ID_REF_FOUR													  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur est vide." )
	ElseIf sIdRefFourPrec <> "" And sVal = sIdRefFourPrec Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sVal + " n'est pas unique." )
		
	End If

	sIdRefFourPrec = sVal

Next

If iRet < 0 Then This.uf_Trace ( "ECR", "ERREUR : Le fichier fournisseur n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$.")

Return iRet


end function

public function integer uf_controler_monnaie_fichier (string asunt_monnaie, integer alcpt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_int_fic_article::uf_controler_monnaie_fichier
//* Auteur			: 
//* Date				: 19/02/2008 17:09:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controle la coh$$HEX1$$e900$$ENDHEX$$rence entre la monnaie du fichier $$HEX2$$e0002000$$ENDHEX$$integrer
//*					  et la monnaie de la base de donn$$HEX1$$e900$$ENDHEX$$e
//* Commentaires	: [SUISSE].LOT3 focntion de Controle de Coh$$HEX1$$e900$$ENDHEX$$rence Monnaie avec le fichier fournisseur
//*
//* Arguments		: value string asunt_monnaie	 */
//*
//* Retourne		: integer	
// Si l'Unit$$HEX2$$e9002000$$ENDHEX$$n'est pas d$$HEX1$$e900$$ENDHEX$$finie : On retourne -1
// Si ps de coh$$HEX1$$e900$$ENDHEX$$rence monnaie   : On retourne -2
// Si Ok								  : On retourne 1
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

//
// Gestion de l'historique Fran$$HEX1$$e700$$ENDHEX$$ais : 
//
// Les codes d'unit$$HEX1$$e900$$ENDHEX$$s de monnaie des fournisseurs sont :
// -	FRF pour Francs
// -	EUR pour Euros
// Pour ces deux cas on fait un code sp$$HEX1$$e900$$ENDHEX$$cifique d'association
// EUR s'associe avec le Format desire EURO
// FRF s'associe avec la format desire F
//
// Logique de la fonction sinon :
//
// L'unit$$HEX2$$e9002000$$ENDHEX$$de monnaie du Fournisseur *DOIT* matcher avec le contenu de la Cl$$HEX1$$e900$$ENDHEX$$
// [MONNAIE] -> Format_Desire du .INI de l'application.
// qui lui meme matche forcement avec La Monnaie de la base ( Voir F_coherence_monnaie )
//
// Donc :

integer 	lRet = 1
n_cst_string	lnv_string

// Test de presence du Code unite Monnaie
if lnv_String.of_isempty(asUnt_Monnaie) then 
	lRet = -1
	This.uf_Trace ( "ECR", "ERREUR ligne " + String ( alCpt ) + &
		" : L'unit$$HEX2$$e9002000$$ENDHEX$$de la monnaie est vide." )
End If

// Test de Coh$$HEX1$$e900$$ENDHEX$$rence
if lRet > 0 then
	choose Case asUnt_Monnaie
		case "FRF"
			if stGlb.sMonnaieFormatDesire <> "F" Then lRet = -2
		case "EUR"
			if stGlb.sMonnaieFormatDesire <> "EURO" Then lRet = -2
		case else
			if stGlb.sMonnaieFormatDesire <> asUnt_Monnaie Then lRet = -2
	End Choose
	If lRet = -2 then
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( alCpt ) + &
			" : La monnaie " + asunt_monnaie + " n'est pas valide." )
	End If
End If

return lRet

end function

private function integer uf_ctrl_fichier_phoneandphone ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Ctrl_Fichier_PHONEANDPHONE (PRIVATE)
//* Auteur			: JFF
//* Date				: 07/03/2006
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler de la validit$$HEX2$$e9002000$$ENDHEX$$du fichier de PHONEANDPHONE
//* Commentaires	: [DCMP090140]
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

Int iRet 
String	sIdFour, sVal, sCar, sSort, sIdRefFourPrec, sTypArtSav
Long		lTotLig, lCpt, lCptVal, lTotArt, lLen
Boolean	bTrouve

iRet = 1

lTotLig = idwFicFourn.RowCount ()
lTotArt = idwArtSpb.RowCount ()
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sTypArtSav = ""

// JFF 20/01/2011 : le tri imp$$HEX1$$e900$$ENDHEX$$ratif sur ID_REF_FOUR $$HEX1$$e900$$ENDHEX$$tait visiblement manquant (?..)
idwFicFourn.SetSort ( "ID_REF_FOUR A" )
idwFicFourn.Sort ()

sIdRefFourPrec = ""

For lCpt = 1 To lTotLig 

	/*------------------------------------------------------------------*/
	/* ZONE 1 : ID_FOUR                                                */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone fournisseur est vide." )
	End If 

	If sVal <> sIdFour Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fournisseur " + sVal + " ne correspond pas au fournisseur s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$" + sIdFour )
	End If 

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La longueur du fournisseur doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If
	
	/*------------------------------------------------------------------*/
	/* ZONE 2 : ID_TYP_ART                                              */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_TYP_ART" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Type Article est vide." )
	End If 

	// Le fichier ne doit que contenir que des appareils du m$$HEX1$$ea00$$ENDHEX$$me type
	// #2 [DCMP090615]
	/*
	If sTypArtSav <> sVal And sTypArtSav <> "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fichier contient des types d'appareils diff$$HEX1$$e900$$ENDHEX$$rents !" )
	End If
	*/
	// :#2 [DCMP090615]

	If Not IsNull ( sVal ) And sVal <> "" Then
	  sTypArtSav = sVal
	End If

	bTrouve = False
	lCptVal = 1
	Do While Not bTrouve And lCptVal <= lTotArt
		bTrouve = sVal = Upper ( idwArtSpb.GetItemString ( lCptVal, "ID_CODE" ) )
		lCptVal ++
	Loop

	If Not bTrouve Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type d'article " + sVal + " n'existe pas dans la base SIMPA2.")
	End If

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type de l'article doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If		

	/*------------------------------------------------------------------*/
	/* ZONE 3 : ID_MARQ_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MARQ_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Marque Article est vide." )
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 4 : ID_MODL_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MODL_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone mod$$HEX1$$e800$$ENDHEX$$le article est vide." )
	Else

		If Pos ( sVal, "'", 1 ) > 0 Then
//			This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (ID_MODL_ART) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "ID_MODL_ART", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 5 : MT_PRIX_HT															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemDecimal ( lCpt, "MT_PRIX_HT" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Prix Hors Taxe est vide." )
	End If 

	lLen = Len ( sVal )
	
	// Marque la virgule
	bTrouve = False

	For lCptVal = 1 To lLen 
		sCar = Mid ( sVal, lCptVal, 1 )
		If sCar = "." Then
			If Not bTrouve Then 
				bTrouve = True
			Else
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, il y a deux virgules." )
				Exit
			End If

		Else
			If Not ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) Then
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, un caract$$HEX1$$e800$$ENDHEX$$re n'est pas un chiffre." )
				Exit
			End If
		End If
	Next	

	If Real ( sVal ) > 5000 Then		
		This.uf_Trace ( "ECR", "AVERTISSEMENT ligne " + String ( lCpt ) + &
		" : Le montant " + sVal + " para$$HEX1$$ee00$$ENDHEX$$t anormalement grand." )
	End If

	
	/*------------------------------------------------------------------*/
	/* ZONE 6 : UNT_MONNAIE															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "UNT_MONNAIE" ) ) )
	// [SUISSE].LOT3 Controle de la monnaie du fichier
	// Si pas de coh$$HEX1$$e900$$ENDHEX$$rence : erreur bloquante d'int$$HEX1$$e900$$ENDHEX$$gration.
	if uf_controler_monnaie_fichier (sVal, lCpt) < 0 Then iRet = -1
	
//	If IsNull ( sVal ) Or sVal = "" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : L'unit$$HEX2$$e9002000$$ENDHEX$$de la monnaie est vide." )
//	End If 
//
//	If sVal <> "FRF" And sVal <> "EUR" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : La monnaie " + sVal + " n'est pas valide." )
//		Exit
//	End If

	/*------------------------------------------------------------------*/
	/* ZONE 7 : QT_DISP																  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemNumber ( lCpt, "QT_DISP" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		idwFicFourn.SetItem ( lCpt, "QT_DISP", 0 ) 
		sVal = "0"
	End If 

	If Not IsNumber ( sVal ) Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La quantit$$HEX2$$e9002000$$ENDHEX$$" + sVal + " n'est pas valide, ce n'est pas un nombre." )
		
	End If

	/*------------------------------------------------------------------*/
	/* ZONE 8 : OBSERV_FRN 															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )

	If Not IsNull ( sVal ) And sVal <> "" Then
		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (OBSERV_FRN) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "OBSERV_FRN", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 
	
	/*------------------------------------------------------------------*/
	/* ZONE 1 BIS : ID_REF_FOUR													  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur est vide." )
	ElseIf sIdRefFourPrec <> "" And sVal = sIdRefFourPrec Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sVal + " n'est pas unique." )
		
	End If

	sIdRefFourPrec = sVal

Next

If iRet < 0 Then This.uf_Trace ( "ECR", "ERREUR : Le fichier fournisseur n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$.")

Return iRet


end function

private function integer uf_integration_fichier_phoneandphone (ref long alnblig, ref long alnbinsert, ref long alnbdelete);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Integration_Fichier_PHONEANDPHONE (PRIVATE)
//* Auteur			: JFF
//* Date				: 17/04/2009
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Int$$HEX1$$e900$$ENDHEX$$gration du fichier PHONEANDPHONE dans la base
//* Commentaires	: [DCMP090140]
//*
//* Arguments		: Long		alNbLig		Ref
//*					  Long		alNbInsert	Ref
//*					  Long		alNbDelete	Ref
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1    JFF    10/03/2008  Modif suite Bug [SUISSE].LOT3
//        JFF    19/11/2013  [DT_60_AUGM_TVA]
//        JFF    06/11/2017 [PC171933]
//*-----------------------------------------------------------------

Int iRet
Long	lTotLigFourn, lRow, lCount, lCpt, lTotLigArticle
String	sIdFour, sIdRefFour, sIdTypArt, sIdMarqArt, sIdModlArt, sUntMonnaie, sNull, sIdMqIfr, sIdModlIfr, sIdTypArtRef
String sIdMarqArtIFr , sIdModlArtIFr 
Decimal {2}	dcTvaParDefaut
Boolean bBaseEuro, bInsert
Decimal {2} dcPrixHt
DateTime dt

iRet = 1
alNbInsert = 0
alNbDelete = 0
SetNull ( sNull )

// [DT_60_AUGM_TVA] 1.196
dcTvaParDefaut = 20

dt = DateTime ( Today (), Now () )

/*------------------------------------------------------------------*/
/* Article de R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour le filtre sur l'existant en base       */
/*------------------------------------------------------------------*/
sIdTypArtRef = Upper ( Trim ( idwFicFourn.GetItemString ( 1, "ID_TYP_ART"  ) ) )

idwArticle.Reset ()

// [SUISSE].LOT3 Suppression mecanique conversion $$HEX2$$e0002000$$ENDHEX$$l'integration article
///*------------------------------------------------------------------*/
///* Euro ou Frf ?                                                    */
///*------------------------------------------------------------------*/
//lCount = 0
//SELECT Count (*)
//INTO	 :lCount
//FROM   sysadm.parametre
//WHERE  ref_cpt = 'EURO'
//USING  SQLCA ;
//		
//bBaseEuro = lCount > 0 	

/*------------------------------------------------------------------*/
/* Chargement de la table actuelle                                  */
/*------------------------------------------------------------------*/
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
idwArticle.Retrieve ( sIdFour, "*" )
idwArticle.SetFilter ( "ID_TYP_ART = '" + sIdTypArtRef + "'" )
idwArticle.Filter ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans le fichier                                    */
/*------------------------------------------------------------------*/
lTotLigFourn = idwFicFourn.RowCount ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table                                      */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Initilisation de la trace d'int$$HEX1$$e900$$ENDHEX$$gration.                         */
/*------------------------------------------------------------------*/
This.uf_Trace_2 ( "INIT", 0, sIdFour, "", "", "", "" )

/*------------------------------------------------------------------*/
/* MAJ de la DW avec le fichier.                                    */
/*------------------------------------------------------------------*/
For alNbLig = 1 To lTotLigFourn

	sIdFour 	   = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_REF_FOUR" ) ) )

	lRow = idwArticle.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwArticle.RowCount () )

	If lRow <= 0 Then 
		bInsert = True
		lRow = idwArticle.InsertRow ( 0 )
		alNbInsert ++
		idwArticle.SetItem ( lRow, "ID_FOUR", 	 sIdFour	  )				
		idwArticle.SetItem ( lRow, "ID_REF_FOUR",  sIdRefFour  )				
		idwArticle.SetItem ( lRow, "ID_TYP_ART",	 sIdTypArt	  )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART",	 sIdMarqArt	  )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART",	 sIdModlArt	  )				
		idwArticle.SetItem ( lRow, "ALT_DISPO",	 "N"	 )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "TVA", dcTvaParDefaut )		
		idwArticle.SetItem ( lRow, "CREE_LE", dt )		
	Else
		bInsert = False
	End If

	If lRow > 0 Then 
// [SUISSE].LOT3 Suppression mecanique conversion $$HEX2$$e0002000$$ENDHEX$$l'integration article
//		dcPrixHt = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_HT" )
//		sUntMonnaie = Upper ( idwFicFourn.GetItemString ( alNbLig, "UNT_MONNAIE" ) )
//		
//		// [SUISSE].LOT3 
//		idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )
//		// Ci-dessous d$$HEX1$$e900$$ENDHEX$$sactiv$$HEX2$$e9002000$$ENDHEX$$:
//		// Base SIMPA2 en FRANCS Fran$$HEX1$$e700$$ENDHEX$$ais
//		If Not bBaseEuro Then
//		
//			CHOOSE CASE  sUntMonnaie 
//				CASE "FRF"
//					idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								
//				CASE "EUR"
//					idwArticle.SetItem ( lRow, "MT_PRIX_HT", Round ( dcPrixHt  * stGlb.tx_Euro, 2 )  )								
//			END CHOOSE
//
//		// Base SIMPA2 en EUROS
//		Else
//			CHOOSE CASE  sUntMonnaie 
//				CASE "FRF"
//					idwArticle.SetItem ( lRow, "MT_PRIX_HT", Round ( dcPrixHt  / stGlb.tx_Euro, 2 )  )								
//				CASE "EUR"
//					idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt  )								
//			END CHOOSE
//
//		End If

		// #1 [SUISSE].LOT3
		dcPrixHt = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_HT" )
		idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								
		// :#1


		/*------------------------------------------------------------------*/
		/* Code $$HEX1$$e900$$ENDHEX$$tat (-EI)                                                  */
		/* 200 Nouveau                                                      */
		/* 100 MAj_Ok sur existant                                          */
		/*------------------------------------------------------------------*/
		If bInsert Then
			idwArticle.SetItem ( lRow, "COD_ETAT", 200 )		
			This.uf_Trace_2 ( "ECR_AUTO", 200, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		Else
			idwArticle.SetItem ( lRow, "COD_ETAT", 100 )		
			sIdMqIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MARQ_ART_IFR" ) )
			sIdModlIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MODL_ART_IFR" ) )

			/*------------------------------------------------------------------*/
			/* Si les marques et mod$$HEX1$$e800$$ENDHEX$$les IFR sont absent de l'enregistrement    */
			/* exisant, on force ALT_DIPSPO $$HEX2$$e0002000$$ENDHEX$$NON.                              */
			/*------------------------------------------------------------------*/
			If Isnull ( sIdMqIfr ) Or sIdMqIfr = "" Or Isnull ( sIdModlIfr ) Or sIdModlIfr = "" Then
				idwArticle.SetItem ( lRow, "ALT_DISPO", "N" )				
			End If

			This.uf_Trace_2 ( "ECR_AUTO", 100, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		End If

		// [VDOC6993]
		Choose Case sIdTypArt 
			Case "TEL", "PC1", "PC2" 
				// Doit $$HEX1$$ea00$$ENDHEX$$tre mis $$HEX2$$e0002000$$ENDHEX$$la main pas Cell. Parte.
				// [VDOC6993]
				If bInsert Then
					sIdMarqArtIFr = Space (35) 
					sIdModlArtIFr = Space (35) 
					SQLCA.PS_S_VDOC6993_LIEN_ARTICLE ( sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, sIdMarqArtIFr, sIdModlArtIFr ) 
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR", sIdMarqArtIFr )				
					End If
					
					If Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR", sIdModlArtIFr )				
					End If
					
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) And &
						Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
					End If
				End If
				
			Case Else
				idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
		End Choose
		// :[VDOC6993]			

		idwArticle.SetItem ( lRow, "QT_DISP", idwFicFourn.GetItemNumber ( alNbLig, "QT_DISP" ) )
		
		// [PC171933]
		idwArticle.SetItem ( lRow, "OBSERV_FRN",  "[#1F5#][#REC#]" ) // Upper ( idwFicFourn.GetItemString ( alNbLig, "OBSERV_FRN" ) ) +
		idwArticle.SetItem ( lRow, "VERROU", 1 )
		idwArticle.SetItem ( lRow, "MAJ_LE", dt )		
		idwArticle.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )		

	End If

Next

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table (r$$HEX1$$e900$$ENDHEX$$actualis$$HEX1$$e900$$ENDHEX$$)                        */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Suppression des lignes pr$$HEX1$$e900$$ENDHEX$$sentes dans la table articles et       */
/* absentes du fichier.                                             */
/*------------------------------------------------------------------*/
For lCpt = lTotLigArticle To 1 Step -1

	sIdFour 	   = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	lRow = idwFicFourn.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwFicFourn.RowCount () )

	If lRow <= 0 Then 
		alNbDelete ++
		idwArticle.DeleteRow ( lCpt )
		This.uf_Trace_2 ( "ECR_AUTO", 300, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
	End If

Next 

idwArticle.SetFilter ( "" )
idwArticle.Filter ()

return iRet 
end function

private function string uf_correspondance_code (string asidfour, string ascas, string asvalrech);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_int_fic_article::uf_correspondance_code (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 20/04/2009
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Correspondance des codes
//* Commentaires	: [DCMP090102]
//*
//* Arguments		: String		asIdFour		Val
//*					  String		asCas			Val
//*					  String		asValRech	Val		
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1	 JFF    28/07/2009  [DMDI26287]
//* #2	 JFF    11/08/2009  [DMDI26381]
//*          SBA   17/06/2010	 [DCMP100437]	
// 			FPI	01/07/2010	[Bug.stock] Correction taille tableau 
//			FPI	08/11/2010	[VDoc1276] Mise $$HEX2$$e0002000$$ENDHEX$$jour totale des sous-rayons
//			FPI	19/04/2013	[VDoc10476] Renommage rayon TPC
//			JFF   16/05/2014  [VDOC14454]
//       JFF   21/03/2016  [PM289-3]
//*-----------------------------------------------------------------

String sValRet, sTabVal[18,2] // [Bug.stock]
long	lTot, lCpt
String sCodeSPB

sValRet = ""

Choose Case asIdFour
		
	Case "CDP"
		
		Choose Case asCas
				
			Case "ID_TYP_ART"
	
				sCodeSPB = Fill ( " ", 200 )
				
				// [PM289-3]
				SQLCA.PS_S_CODE_CORRES_V01 (asIdFour, Trim ( asValRech ), sCodeSPB )
				
				sCodeSPB = Trim ( sCodeSPB )

				sValRet = sCodeSPB 

		End Choose
		
End Choose


Return sValRet
end function

private function integer uf_ctrl_fichier_carrefour ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Ctrl_Fichier_Carrefour (PRIVATE)
//* Auteur			: JFF
//* Date				: 04/11/2010
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler de la validit$$HEX2$$e9002000$$ENDHEX$$du fichier de CARREFOUR
//* Commentaires	: [PC301].[LOT2]
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Int iRet 
String	sIdFour, sVal, sCar, sSort, sIdRefFourPrec, sTypArtSav
Long		lTotLig, lCpt, lCptVal, lTotArt, lLen
Boolean	bTrouve

iRet = 1

lTotLig = idwFicFourn.RowCount ()
lTotArt = idwArtSpb.RowCount ()
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sTypArtSav = ""

// JFF 20/01/2011 : le tri imp$$HEX1$$e900$$ENDHEX$$ratif sur ID_REF_FOUR $$HEX1$$e900$$ENDHEX$$tait visiblement manquant (?..)
idwFicFourn.SetSort ( "ID_REF_FOUR A" )
idwFicFourn.Sort ()

sIdRefFourPrec = ""

For lCpt = 1 To lTotLig 

	/*------------------------------------------------------------------*/
	/* ZONE 1 : ID_FOUR                                                */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone fournisseur est vide." )
	End If 

	If sVal <> sIdFour Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fournisseur " + sVal + " ne correspond pas au fournisseur s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$" + sIdFour )
	End If 

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La longueur du fournisseur doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If
	
	/*------------------------------------------------------------------*/
	/* ZONE 2 : ID_TYP_ART                                              */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_TYP_ART" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Type Article est vide." )
	End If 

	// Le fichier ne doit que contenir que des appareils du m$$HEX1$$ea00$$ENDHEX$$me type
	// #2 [DCMP090615]
	/*
	If sTypArtSav <> sVal And sTypArtSav <> "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fichier contient des types d'appareils diff$$HEX1$$e900$$ENDHEX$$rents !" )
	End If
	*/
	// :#2 [DCMP090615]

	If Not IsNull ( sVal ) And sVal <> "" Then
	  sTypArtSav = sVal
	End If

	bTrouve = False
	lCptVal = 1
	Do While Not bTrouve And lCptVal <= lTotArt
		bTrouve = sVal = Upper ( idwArtSpb.GetItemString ( lCptVal, "ID_CODE" ) )
		lCptVal ++
	Loop

	If Not bTrouve Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type d'article " + sVal + " n'existe pas dans la base SIMPA2.")
	End If

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type de l'article doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If		

	/*------------------------------------------------------------------*/
	/* ZONE 3 : ID_MARQ_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MARQ_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Marque Article est vide." )
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 4 : ID_MODL_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MODL_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone mod$$HEX1$$e800$$ENDHEX$$le article est vide." )
	Else

		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (ID_MODL_ART) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "ID_MODL_ART", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 5 : MT_PRIX_HT															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemDecimal ( lCpt, "MT_PRIX_HT" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Prix TTC est vide." )
	End If 

	lLen = Len ( sVal )
	
	// Marque la virgule
	bTrouve = False

	For lCptVal = 1 To lLen 
		sCar = Mid ( sVal, lCptVal, 1 )
		If sCar = "." Then
			If Not bTrouve Then 
				bTrouve = True
			Else
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, il y a deux virgules." )
				Exit
			End If

		Else
			If Not ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) Then
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, un caract$$HEX1$$e800$$ENDHEX$$re n'est pas un chiffre." )
				Exit
			End If
		End If
	Next	

	If Real ( sVal ) > 5000 Then		
		This.uf_Trace ( "ECR", "AVERTISSEMENT ligne " + String ( lCpt ) + &
		" : Le montant " + sVal + " para$$HEX1$$ee00$$ENDHEX$$t anormalement grand." )
	End If

	
	/*------------------------------------------------------------------*/
	/* ZONE 6 : UNT_MONNAIE															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "UNT_MONNAIE" ) ) )
	// [SUISSE].LOT3 Controle de la monnaie du fichier
	// Si pas de coh$$HEX1$$e900$$ENDHEX$$rence : erreur bloquante d'int$$HEX1$$e900$$ENDHEX$$gration.
	if uf_controler_monnaie_fichier (sVal, lCpt) < 0 Then iRet = -1
	
//	If IsNull ( sVal ) Or sVal = "" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : L'unit$$HEX2$$e9002000$$ENDHEX$$de la monnaie est vide." )
//	End If 
//
//	If sVal <> "FRF" And sVal <> "EUR" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : La monnaie " + sVal + " n'est pas valide." )
//		Exit
//	End If

	/*------------------------------------------------------------------*/
	/* ZONE 7 : QT_DISP																  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemNumber ( lCpt, "QT_DISP" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		idwFicFourn.SetItem ( lCpt, "QT_DISP", 0 ) 
		sVal = "0"
	End If 

	If Not IsNumber ( sVal ) Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La quantit$$HEX2$$e9002000$$ENDHEX$$" + sVal + " n'est pas valide, ce n'est pas un nombre." )
		
	End If

	/*------------------------------------------------------------------*/
	/* ZONE 8 : OBSERV_FRN 															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )

	If Not IsNull ( sVal ) And sVal <> "" Then
		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (OBSERV_FRN) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "OBSERV_FRN", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 


	
	/*------------------------------------------------------------------*/
	/* ZONE 1 BIS : ID_REF_FOUR													  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur est vide." )
	ElseIf sIdRefFourPrec <> "" And sVal = sIdRefFourPrec Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sVal + " n'est pas unique." )
		
	End If

	sIdRefFourPrec = sVal

Next

If iRet < 0 Then This.uf_Trace ( "ECR", "ERREUR : Le fichier fournisseur n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$.")

Return iRet


end function

private function integer uf_integration_fichier_carrefour (ref long alnblig, ref long alnbinsert, ref long alnbdelete);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Integration_Fichier_CARREFOUR (PRIVATE)
//* Auteur			: JFF
//* Date				: 07/03/2010
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Int$$HEX1$$e900$$ENDHEX$$gration du fichier CARREFOUR dans la base
//* Commentaires	: 
//*
//* Arguments		: Long		alNbLig		Ref
//*					  Long		alNbInsert	Ref
//*					  Long		alNbDelete	Ref
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1    JFF    10/03/2008  Modif suite Bug [SUISSE].LOT3
//* #2    JFF    19/10/2009  [DCMP090615]
//*       JFF    06/05/2010  [VDOC4063]
//			FPI	11/12/2012	[VDOC9492]
//*-----------------------------------------------------------------

Int iRet
Long	lTotLigFourn, lRow, lCount, lCpt, lTotLigArticle, lQtDisp
String	sIdFour, sIdRefFour, sIdTypArt, sIdMarqArt, sIdModlArt, sUntMonnaie, sNull, sIdMqIfr, sIdModlIfr, sIdTypArtRef
Decimal {2}	dcTvaParDefaut
Boolean bBaseEuro, bInsert
Decimal {2} dcPrixHt
DateTime dt

iRet = 1
alNbInsert = 0
alNbDelete = 0
SetNull ( sNull )

// !!!!!!!!!!!!!!!!!!!! Particularit$$HEX2$$e9002000$$ENDHEX$$de CARREFOUR !!!!!!!!!!!!!!!!!!!!!!!
// dcTvaParDefaut = 19.6 
dcTvaParDefaut = 0 
// Le montant re$$HEX1$$e700$$ENDHEX$$u est TTC, pas d'ajout de TVA.


dt = DateTime ( Today (), Now () )

/*------------------------------------------------------------------*/
/* Article de R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour le filtre sur l'existant en base       */
/*------------------------------------------------------------------*/
//* #2 [DCMP090615]
// sIdTypArtRef = Upper ( Trim ( idwFicFourn.GetItemString ( 1, "ID_TYP_ART"  ) ) )
//* :#2 [DCMP090615]

idwArticle.Reset ()

// [SUISSE].LOT3 Suppression mecanique conversion $$HEX2$$e0002000$$ENDHEX$$l'integration article
///*------------------------------------------------------------------*/
///* Euro ou Frf ?                                                    */
///*------------------------------------------------------------------*/
//lCount = 0
//SELECT Count (*)
//INTO	 :lCount
//FROM   sysadm.parametre
//WHERE  ref_cpt = 'EURO'
//USING  SQLCA ;
//		
//bBaseEuro = lCount > 0 	

/*------------------------------------------------------------------*/
/* Chargement de la table actuelle                                  */
/*------------------------------------------------------------------*/
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
// idwArticle.Retrieve ( sIdFour, "*" )

//* #2 [DCMP090615]
//idwArticle.SetFilter ( "ID_TYP_ART = '" + sIdTypArtRef + "'" )
//idwArticle.Filter ()
//* :#2 [DCMP090615]

/*------------------------------------------------------------------*/
/* Nbre de ligne dans le fichier                                    */
/*------------------------------------------------------------------*/
lTotLigFourn = idwFicFourn.RowCount ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table                                      */
/*------------------------------------------------------------------*/
// lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Initilisation de la trace d'int$$HEX1$$e900$$ENDHEX$$gration.                         */
/*------------------------------------------------------------------*/
This.uf_Trace_2 ( "INIT", 0, sIdFour, "", "", "", "" )
F_Execute ( "Exec sysadm.PS_D02_ARTICLE 'CAR'", SQLCA )

/*------------------------------------------------------------------*/
/* MAJ de la DW avec le fichier.                                    */
/*------------------------------------------------------------------*/
For alNbLig = 1 To lTotLigFourn

	sIdFour 	   = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_REF_FOUR" ) ) )
	dcPrixHt    = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_HT" )
	lQtDisp		= idwFicFourn.GetItemNumber ( alNbLig, "QT_DISP" )

	// !!!!!!!!!! R$$HEX1$$e800$$ENDHEX$$gles donn$$HEX1$$e900$$ENDHEX$$es lors de la r$$HEX1$$e900$$ENDHEX$$union du Mercredi 27/10/2010, 
	// On arr$$HEX1$$ea00$$ENDHEX$$te les stocks $$HEX2$$e0002000$$ENDHEX$$un seuil de 50 pour carrefour, ne pas descendre en dessous.
	// Pour g$$HEX1$$e900$$ENDHEX$$rer cela, je r$$HEX1$$e900$$ENDHEX$$duis d'entr$$HEX1$$e900$$ENDHEX$$e le stock de chaque article de -50 unit$$HEX1$$e900$$ENDHEX$$s.
	lQtDisp		= lQtDisp - 20 // [VDoc9492] - Passage de 50 $$HEX2$$e0002000$$ENDHEX$$20 unit$$HEX1$$e900$$ENDHEX$$s
	
	If lQtDisp < 0 Then lQtDisp = 0
	

	lRow = idwArticle.InsertRow ( 0 )
	alNbInsert ++
	idwArticle.SetItem ( lRow, "ID_FOUR", 	 sIdFour	  )				
	idwArticle.SetItem ( lRow, "ID_REF_FOUR",  sIdRefFour  )				
	idwArticle.SetItem ( lRow, "ID_TYP_ART",	 sIdTypArt	  )				
	idwArticle.SetItem ( lRow, "ID_MARQ_ART",	 sIdMarqArt	  )				
	idwArticle.SetItem ( lRow, "ID_MODL_ART",	 sIdModlArt	  )				
	idwArticle.SetItem ( lRow, "ALT_DISPO",	 "N"	 )				
	idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR",	 sNull )				
	idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR",	 sNull )				
	idwArticle.SetItem ( lRow, "TVA", dcTvaParDefaut )		
	idwArticle.SetItem ( lRow, "CREE_LE", dt )		
	idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								

	idwArticle.SetItem ( lRow, "COD_ETAT", 200 )		
	This.uf_Trace_2 ( "ECR_AUTO", 200, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
	
	idwArticle.SetItem ( lRow, "ALT_DISPO",	 "O"	 )
	
	idwArticle.SetItem ( lRow, "QT_DISP", lQtDisp )
	idwArticle.SetItem ( lRow, "OBSERV_FRN", Upper ( idwFicFourn.GetItemString ( alNbLig, "OBSERV_FRN" ) ) + " (Prix : " + String ( dcPrixHt, "######.00" ) + " $$HEX1$$ac20$$ENDHEX$$)" ) 	// [VDOC4063] ajout du prix pour info
	idwArticle.SetItem ( lRow, "VERROU", 1 )
	idwArticle.SetItem ( lRow, "MAJ_LE", dt )		
	idwArticle.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )		

Next

idwArticle.SetFilter ( "" )
idwArticle.Filter ()

return iRet 
end function

private function integer uf_ctrl_fichier_o2m ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Ctrl_Fichier_O2M (PRIVATE)
//* Auteur			: JFF
//* Date				: 03/05/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler de la validit$$HEX2$$e9002000$$ENDHEX$$du fichier de O2M
//* Commentaires	: [PM166][O2M]
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    19/10/2009  [DCMP090615]
//        JFF    02/04/2011  [PC694][SFR2012]
//        JFF    09/05/2011  [ITSM114795]
//        JFF    07/02/2017  [VDOC25657]
//        JFF    22/02/2017  [VDOC25770]
//        JFF    18/12/2018  [PM471-1]
//        JFF    20/09/2021  [BUG_RST_PRIX_O2M]
//*-----------------------------------------------------------------

Int iRet 
String sIdFour, sVal, sCar, sSort, sIdRefFourPrec, sTypArtSav
String sMarque, sModele
Long		lTotLig, lCpt, lCptVal, lTotArt, lLen
Boolean	bTrouve
Int iPos1, iPos2

iRet = 1

lTotLig = idwFicFourn.RowCount ()
lTotArt = idwArtSpb.RowCount ()
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sTypArtSav = ""

// JFF 20/01/2011 : le tri imp$$HEX1$$e900$$ENDHEX$$ratif sur ID_REF_FOUR $$HEX1$$e900$$ENDHEX$$tait visiblement manquant (?..)
idwFicFourn.SetSort ( "ID_REF_FOUR A" )
idwFicFourn.Sort ()

sIdRefFourPrec = ""

For lCpt = 1 To lTotLig 

	/*------------------------------------------------------------------*/
	/* ZONE 1 : ID_FOUR                                                */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone fournisseur est vide." )
	End If 

	If sVal <> sIdFour Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fournisseur " + sVal + " ne correspond pas au fournisseur s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$" + sIdFour )
	End If 

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La longueur du fournisseur doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If
	
	/*------------------------------------------------------------------*/
	/* ZONE 2 : ID_TYP_ART                                              */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_TYP_ART" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Type Article est vide." )
	End If 

	// Le fichier ne doit que contenir que des appareils du m$$HEX1$$ea00$$ENDHEX$$me type
	// #2 [DCMP090615]
	/*
	If sTypArtSav <> sVal And sTypArtSav <> "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fichier contient des types d'appareils diff$$HEX1$$e900$$ENDHEX$$rents !" )
	End If
	*/
	// :#2 [DCMP090615]

	If Not IsNull ( sVal ) And sVal <> "" Then
	  sTypArtSav = sVal
	End If

	bTrouve = False
	lCptVal = 1
	Do While Not bTrouve And lCptVal <= lTotArt
		bTrouve = sVal = Upper ( idwArtSpb.GetItemString ( lCptVal, "ID_CODE" ) )
		lCptVal ++
	Loop

	If Not bTrouve Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type d'article " + sVal + " n'existe pas dans la base SIMPA2.")
	End If

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type de l'article doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If		

	/*------------------------------------------------------------------*/
	/* ZONE 3 : ID_MARQ_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MARQ_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Marque Article est vide." )
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 4 : ID_MODL_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MODL_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone mod$$HEX1$$e800$$ENDHEX$$le article est vide." )
	Else

		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (ID_MODL_ART) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "ID_MODL_ART", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 5 : MT_PRIX_HT															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemDecimal ( lCpt, "MT_PRIX_HT" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Prix Hors Taxe est vide." )
	End If 

	lLen = Len ( sVal )
	
	// Marque la virgule
	bTrouve = False

	For lCptVal = 1 To lLen 
		sCar = Mid ( sVal, lCptVal, 1 )
		If sCar = "." Then
			If Not bTrouve Then 
				bTrouve = True
			Else
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, il y a deux virgules." )
				Exit
			End If

		Else
			If Not ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) Then
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, un caract$$HEX1$$e800$$ENDHEX$$re n'est pas un chiffre." )
				Exit
			End If
		End If
	Next	

	If Real ( sVal ) > 5000 Then		
		This.uf_Trace ( "ECR", "AVERTISSEMENT ligne " + String ( lCpt ) + &
		" : Le montant " + sVal + " para$$HEX1$$ee00$$ENDHEX$$t anormalement grand." )
	End If

	// [BUG_RST_PRIX_O2M]
	If Real ( sVal ) <= 0 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Prix Hors Taxe doit $$HEX1$$ea00$$ENDHEX$$tre un montant positif." )
	End If 
	
	/*------------------------------------------------------------------*/
	/* ZONE 6 : UNT_MONNAIE															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "UNT_MONNAIE" ) ) )
	// [SUISSE].LOT3 Controle de la monnaie du fichier
	// Si pas de coh$$HEX1$$e900$$ENDHEX$$rence : erreur bloquante d'int$$HEX1$$e900$$ENDHEX$$gration.
	if uf_controler_monnaie_fichier (sVal, lCpt) < 0 Then iRet = -1
	
//	If IsNull ( sVal ) Or sVal = "" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : L'unit$$HEX2$$e9002000$$ENDHEX$$de la monnaie est vide." )
//	End If 
//
//	If sVal <> "FRF" And sVal <> "EUR" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : La monnaie " + sVal + " n'est pas valide." )
//		Exit
//	End If

	/*------------------------------------------------------------------*/
	/* ZONE 7 : QT_DISP																  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemNumber ( lCpt, "QT_DISP" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		idwFicFourn.SetItem ( lCpt, "QT_DISP", 0 ) 
		sVal = "0"
	End If 

	If Not IsNumber ( sVal ) Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La quantit$$HEX2$$e9002000$$ENDHEX$$" + sVal + " n'est pas valide, ce n'est pas un nombre." )
		
	End If

	/*------------------------------------------------------------------*/
	/* ZONE 8 : OBSERV_FRN 															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )

	If Not IsNull ( sVal ) And sVal <> "" Then
		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (OBSERV_FRN) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "OBSERV_FRN", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	// [VDOC25657]
	// [PM471-1] si besoin de reporter sur autre frn
	If Pos ( sVal, "[#GR#" ) > 0 Then
		sVal = Mid ( sVal, Pos ( sVal, "[#GR#" ) + 5, 1 ) 
		If Not IsNumber ( sVal ) Then 
			iRet = -1
			If IsNull ( sVal ) Then sVal = "'vide'"
			This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" (vDoc25657/PM471-1) : La valeur " + sVal + " n'est pas autoris$$HEX1$$e900$$ENDHEX$$e pour le mot cl$$HEX2$$e9002000$$ENDHEX$$[#GR#]. La valeur doit $$HEX1$$ea00$$ENDHEX$$tre num$$HEX1$$e900$$ENDHEX$$rique entre 0 et 9." )
		End If 
	End If 

	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )

	// [VDOC25770]
	If Pos ( sVal, "[#PR#" ) > 0 Then
		sVal = Mid ( sVal, Pos ( sVal, "[#PR#" ) + 5, 3 ) 
		If IsNull ( sVal ) Then sVal = "'vide'"
		
		Choose Case sVal
			Case "AIG", "O2M"
				// OK
			Case Else
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
					" (vDoc25770) : La valeur " + sVal + " n'est pas autoris$$HEX1$$e900$$ENDHEX$$e pour le mot cl$$HEX2$$e9002000$$ENDHEX$$[#PR#]. La valeur doit $$HEX1$$ea00$$ENDHEX$$tre AIG ou O2M." )
		End CHoose 
			
	End If 
	
	// [PM471-1]
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )

	If Pos ( sVal, "[#RSASS#" ) > 0 Then
		iPos1 = Pos ( sVal, "[#RSASS#" )
		iPos2 = Pos ( sVal, "#]", iPos1 )
		sVal = Mid ( sVal, iPos1 + 8, iPos2 - ( iPos1 + 8 ) ) 
		If IsNull ( sVal ) Then sVal = "'vide'"
		
		Choose Case sVal
			Case "AIG", "CARDIF", "PACIFICA", "PARISIENNE", "AMTRUST", "DAS" // D$$HEX1$$e900$$ENDHEX$$finir ici les autres assureurs
				// OK
			Case Else
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
					" (PM471-1) : La valeur " + sVal + " n'est pas autoris$$HEX1$$e900$$ENDHEX$$e pour le mot cl$$HEX2$$e9002000$$ENDHEX$$[#RSASS#]. La valeur doit $$HEX1$$ea00$$ENDHEX$$tre un libell$$HEX2$$e9002000$$ENDHEX$$assureur donn$$HEX2$$e9002000$$ENDHEX$$par SPB." )
		End CHoose 
			
	End If 

	// [PC694][SFR2012]
	sMarque = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MARQ_ART" ), 35 ) ) )
	sModele = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MODL_ART" ), 35 ) ) )

	/* [ITSM114795]
	
	Classe enlev$$HEX1$$e900$$ENDHEX$$e par Lisette sur ITSM 114795
	"IPHONE 4G 16GO- BLANC",&
	"IPHONE 4G 16GO- NOIR",&
	*/

	Choose Case sMarque 
		Case "APPLE"
			Choose Case sModele 
				Case 	"IPHONE 4G 8GO- BLANC",&
						"IPHONE 4G 8GO- NOIR",&
						"IPHONE 4S 16GO- BLANC",&
						"IPHONE 4S 16GO- NOIR",&
						"IPHONE 4S 32GO- BLANC",&
						"IPHONE 4S 32GO- NOIR",&
						"IPHONE 4S 64GO- BLANC",&
						"IPHONE 4S 64GO- NOIR"
		
						If Pos ( sVal, "[#2F1#]" ) > 0 Then
							If Pos ( sVal, "[#CM") <= 0 Then
								sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )
								iRet = -1
								This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
								" : Le nouveau code filtre SFR [#CMx#] est absent de la r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$nce " + sVal + "." )
							End If
						End If
					
			End Choose
	End Choose
	// [PC694][SFR2012]
	
	/*------------------------------------------------------------------*/
	/* ZONE 1 BIS : ID_REF_FOUR													  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur est vide." )
	ElseIf sIdRefFourPrec <> "" And sVal = sIdRefFourPrec Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sVal + " n'est pas unique." )
		
	End If

	sIdRefFourPrec = sVal

Next

If iRet < 0 Then This.uf_Trace ( "ECR", "ERREUR : Le fichier fournisseur n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$.")

Return iRet


end function

private function integer uf_integration_fichier_o2m (string ascas, ref long alnblig, ref long alnbinsert, ref long alnbdelete);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Integration_Fichier_O2M (PRIVATE)
//* Auteur			: JFF
//* Date				: 03/05/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Int$$HEX1$$e900$$ENDHEX$$gration du fichier O2M dans la base
//* Commentaires	: // [PM166][O2M]
//*
//* Arguments		: Long		alNbLig		Ref
//*					  Long		alNbInsert	Ref
//*					  Long		alNbDelete	Ref
//*					  String 	asCas			Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1    JFF    10/03/2008  Modif suite Bug [SUISSE].LOT3
//* #2    JFF    19/10/2009  [DCMP090615]
//*       JFF    29/02/2012  [VDOC6993]
//*       JFF    11/02/2012  [VDOC10307]
//		    FPI	  06/03/2013  [ITSM148817]
//        JFF    19/11/2013  [DT_60_AUGM_TVA]
// 		 JFF	  11/06/2015  [VDOC17887]
//*-----------------------------------------------------------------

Int iRet
Long	lTotLigFourn, lRow, lCount, lCpt, lTotLigArticle, lNbreCmdeValNonGen, lQteFic
String	sIdFour, sIdRefFour, sIdTypArt, sIdMarqArt, sIdModlArt, sUntMonnaie, sNull, sIdMqIfr, sIdModlIfr, sIdTypArtRef, sSql
String sIdMarqArtIFr , sIdModlArtIFr 
Decimal {2}	dcTvaParDefaut, dcMtPrixLog 
Boolean bBaseEuro, bInsert
Decimal {2} dcPrixHt
DateTime dt

iRet = 1
alNbInsert = 0
alNbDelete = 0
SetNull ( sNull )

// [DT_60_AUGM_TVA] 1.196
dcTvaParDefaut = 20

dt = DateTime ( Today (), Now () )

/*------------------------------------------------------------------*/
/* Article de R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour le filtre sur l'existant en base       */
/*------------------------------------------------------------------*/
//* #2 [DCMP090615]
// sIdTypArtRef = Upper ( Trim ( idwFicFourn.GetItemString ( 1, "ID_TYP_ART"  ) ) )
//* :#2 [DCMP090615]

idwArticle.Reset ()

// [SUISSE].LOT3 Suppression mecanique conversion $$HEX2$$e0002000$$ENDHEX$$l'integration article
///*------------------------------------------------------------------*/
///* Euro ou Frf ?                                                    */
///*------------------------------------------------------------------*/
//lCount = 0
//SELECT Count (*)
//INTO	 :lCount
//FROM   sysadm.parametre
//WHERE  ref_cpt = 'EURO'
//USING  SQLCA ;
//		
//bBaseEuro = lCount > 0 	

/*------------------------------------------------------------------*/
/* Chargement de la table actuelle                                  */
/*------------------------------------------------------------------*/
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )

If asCas = "1ER_TOUR" Then
//	[VDOC10307]
	// [ITSM148817]
	idwArticle.Retrieve ( sIdFour, "*" )  
End If

/*------------------------------------------------------------------*/
/* Nbre de ligne dans le fichier                                    */
/*------------------------------------------------------------------*/
lTotLigFourn = idwFicFourn.RowCount ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table                                      */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Initilisation de la trace d'int$$HEX1$$e900$$ENDHEX$$gration.                         */
/*------------------------------------------------------------------*/
If asCas = "1ER_TOUR" Then
	This.uf_Trace_2 ( "INIT", 0, sIdFour, "", "", "", "" )
End If

/*------------------------------------------------------------------*/
/* MAJ de la DW avec le fichier.                                    */
/*------------------------------------------------------------------*/
For alNbLig = 1 To lTotLigFourn

	sIdFour 	   = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_REF_FOUR" ) ) )

	If asCas = "1ER_TOUR" Then

		lRow = idwArticle.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
										 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
										 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
										 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
										 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
										 1, idwArticle.RowCount () )
	
		If lRow <= 0 Then 
			bInsert = True
			lRow = idwArticle.InsertRow ( 0 )
			alNbInsert ++
			idwArticle.SetItem ( lRow, "ID_FOUR", 	 sIdFour	  )				
			idwArticle.SetItem ( lRow, "ID_REF_FOUR",  sIdRefFour  )				
			idwArticle.SetItem ( lRow, "ID_TYP_ART",	 sIdTypArt	  )				
			idwArticle.SetItem ( lRow, "ID_MARQ_ART",	 sIdMarqArt	  )				
			idwArticle.SetItem ( lRow, "ID_MODL_ART",	 sIdModlArt	  )				
			idwArticle.SetItem ( lRow, "ALT_DISPO",	 "N"	 )				
			idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR",	 sNull )				
			idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR",	 sNull )				
			idwArticle.SetItem ( lRow, "TVA", dcTvaParDefaut )		
			idwArticle.SetItem ( lRow, "CREE_LE", dt )		
		Else
			bInsert = False
		End If
	
		If lRow > 0 Then 
	
			// #1 [SUISSE].LOT3
			dcPrixHt = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_HT" )
			idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								
			// :#1
	
	
			/*------------------------------------------------------------------*/
			/* Code $$HEX1$$e900$$ENDHEX$$tat (-EI)                                                  */
			/* 200 Nouveau                                                      */
			/* 100 MAj_Ok sur existant                                          */
			/*------------------------------------------------------------------*/
			If bInsert Then
				idwArticle.SetItem ( lRow, "COD_ETAT", 200 )		
				This.uf_Trace_2 ( "ECR_AUTO", 200, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
			Else
				idwArticle.SetItem ( lRow, "COD_ETAT", 100 )		
				sIdMqIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MARQ_ART_IFR" ) )
				sIdModlIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MODL_ART_IFR" ) )
	
				/*------------------------------------------------------------------*/
				/* Si les marques et mod$$HEX1$$e800$$ENDHEX$$les IFR sont absent de l'enregistrement    */
				/* exisant, on force ALT_DIPSPO $$HEX2$$e0002000$$ENDHEX$$NON.                              */
				/*------------------------------------------------------------------*/
				If Isnull ( sIdMqIfr ) Or sIdMqIfr = "" Or Isnull ( sIdModlIfr ) Or sIdModlIfr = "" Then
					idwArticle.SetItem ( lRow, "ALT_DISPO", "N" )				
				End If
	
				This.uf_Trace_2 ( "ECR_AUTO", 100, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
			End If
	
			// [VDOC6993]
			Choose Case sIdTypArt 
				Case "TEL", "PC1", "PC2" 
					// Doit $$HEX1$$ea00$$ENDHEX$$tre mis $$HEX2$$e0002000$$ENDHEX$$la main pas Cell. Parte.
					// [VDOC6993]
					If bInsert Then
						sIdMarqArtIFr = Space (35) 
						sIdModlArtIFr = Space (35) 
						SQLCA.PS_S_VDOC6993_LIEN_ARTICLE ( sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, sIdMarqArtIFr, sIdModlArtIFr ) 
						If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) Then
							idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR", sIdMarqArtIFr )				
						End If
						
						If Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
							idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR", sIdModlArtIFr )				
						End If
						
						If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) And &
							Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
							idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
						End If
					End If
				Case Else
					idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
			End Choose
			// :[VDOC6993]			
	
			// [VDOC17887]
			lQteFic = idwFicFourn.GetItemNumber ( alNbLig, "QT_DISP" )			

			// [VDOC17887]
			lNbreCmdeValNonGen = SQLCA.PS_S_CMDE_VAL_NON_GEN ( sIdFour, sIdTypArt, sIdRefFour, sIdMarqArt, sIdModlArt) 
			If IsNull ( lNbreCmdeValNonGen ) Then lNbreCmdeValNonGen = 0
			lQteFic = lQteFic - lNbreCmdeValNonGen 
			If lQteFic < 0 Then lQteFic = 0
			
			idwArticle.SetItem ( lRow, "QT_DISP", lQteFic )
			idwArticle.SetItem ( lRow, "OBSERV_FRN", Upper ( idwFicFourn.GetItemString ( alNbLig, "OBSERV_FRN" ) ) )
			idwArticle.SetItem ( lRow, "VERROU", 1 )
			idwArticle.SetItem ( lRow, "MAJ_LE", dt )		
			idwArticle.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )		
	
		End If
	End If
	
// Maj det_article pour le prix_log
	If asCas = "2EME_TOUR" Then

		dcMtPrixLog = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_LOG" )

		lRow = SQLCA.PS_S01_DET_ARTICLE_TEST_PRESENCE ( sIdFour, sIdRefFour) 

		// On n'int$$HEX1$$e900$$ENDHEX$$gre que certaines c$$HEX1$$e900$$ENDHEX$$t$$HEX1$$e900$$ENDHEX$$gorie.
		If lRow <= 0 Then 
		
			sSql  = "Exec sysadm.DW_I01_DET_ARTICLE "
			sSql += "'" + sIdFour + "'," 
			sSql += "'" + sIdRefFour + "',"
			sSql += "'-1',"
			sSql += "'LOG',"
			sSql += "'" + String ( dcMtPrixLog  ) + "'"
	
			F_Execute ( sSql, SQLCA )
		Else 

			sSql  = "Exec sysadm.DW_U01_DET_ARTICLE "
			sSql += "'" + sIdFour + "'," 
			sSql += "'" + sIdRefFour + "',"
			sSql += "'-1',"
			sSql += "'LOG',"
			sSql += "'" + String ( dcMtPrixLog ) + "'"

			F_Execute ( sSql, SQLCA )
		End If
	End If	
	
Next

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table (r$$HEX1$$e900$$ENDHEX$$actualis$$HEX1$$e900$$ENDHEX$$)                        */
/*------------------------------------------------------------------*/
If asCas = "1ER_TOUR" Then
	lTotLigArticle = idwArticle.RowCount ()
	
	/*------------------------------------------------------------------*/
	/* Suppression des lignes pr$$HEX1$$e900$$ENDHEX$$sentes dans la table articles et       */
	/* absentes du fichier.                                             */
	/*------------------------------------------------------------------*/
	For lCpt = lTotLigArticle To 1 Step -1
	
		sIdFour 	   = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_FOUR"    ) ) )
		sIdTypArt 	= Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_TYP_ART"  ) ) )
		sIdMarqArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MARQ_ART" ) ) )
		sIdModlArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MODL_ART" ) ) )
		sIdRefFour  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )
	
		lRow = idwFicFourn.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
										 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
										 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
										 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
										 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
										 1, idwFicFourn.RowCount () )
	
		If lRow <= 0 Then 

			sSql  = "Exec sysadm.DW_D01_DET_ARTICLE "
			sSql += "'" + sIdFour + "'," 
			sSql += "'" + sIdRefFour + "'"
		
			F_Execute ( sSql, SQLCA )
			
			alNbDelete ++
			idwArticle.DeleteRow ( lCpt )
			This.uf_Trace_2 ( "ECR_AUTO", 300, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		End If
	
	Next 
End If 

idwArticle.SetFilter ( "" )
idwArticle.Filter ()

return iRet 
end function

private function integer uf_ctrl_fichier_coriolis ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Ctrl_Fichier_Coriolis (PRIVATE)
//* Auteur			: JFF
//* Date				: 03/05/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler de la validit$$HEX2$$e9002000$$ENDHEX$$du fichier de O2M
//* Commentaires	: [PM178][CORIOLIS]
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    19/10/2009  [DCMP090615]
//*-----------------------------------------------------------------

Int iRet 
String	sIdFour, sVal, sCar, sSort, sIdRefFourPrec, sTypArtSav
Long		lTotLig, lCpt, lCptVal, lTotArt, lLen
Boolean	bTrouve

iRet = 1

lTotLig = idwFicFourn.RowCount ()
lTotArt = idwArtSpb.RowCount ()
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sTypArtSav = ""

// JFF 20/01/2011 : le tri imp$$HEX1$$e900$$ENDHEX$$ratif sur ID_REF_FOUR $$HEX1$$e900$$ENDHEX$$tait visiblement manquant (?..)
idwFicFourn.SetSort ( "ID_REF_FOUR A" )
idwFicFourn.Sort ()

sIdRefFourPrec = ""

For lCpt = 1 To lTotLig 

	/*------------------------------------------------------------------*/
	/* ZONE 1 : ID_FOUR                                                */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone fournisseur est vide." )
	End If 

	If sVal <> sIdFour Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fournisseur " + sVal + " ne correspond pas au fournisseur s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$" + sIdFour )
	End If 

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La longueur du fournisseur doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If
	
	/*------------------------------------------------------------------*/
	/* ZONE 2 : ID_TYP_ART                                              */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_TYP_ART" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Type Article est vide." )
	End If 

	// Le fichier ne doit que contenir que des appareils du m$$HEX1$$ea00$$ENDHEX$$me type
	// #2 [DCMP090615]
	/*
	If sTypArtSav <> sVal And sTypArtSav <> "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fichier contient des types d'appareils diff$$HEX1$$e900$$ENDHEX$$rents !" )
	End If
	*/
	// :#2 [DCMP090615]

	If Not IsNull ( sVal ) And sVal <> "" Then
	  sTypArtSav = sVal
	End If

	bTrouve = False
	lCptVal = 1
	Do While Not bTrouve And lCptVal <= lTotArt
		bTrouve = sVal = Upper ( idwArtSpb.GetItemString ( lCptVal, "ID_CODE" ) )
		lCptVal ++
	Loop

	If Not bTrouve Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type d'article " + sVal + " n'existe pas dans la base SIMPA2.")
	End If

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type de l'article doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If		

	/*------------------------------------------------------------------*/
	/* ZONE 3 : ID_MARQ_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MARQ_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Marque Article est vide." )
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 4 : ID_MODL_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MODL_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone mod$$HEX1$$e800$$ENDHEX$$le article est vide." )
	Else

		If Pos ( sVal, "'", 1 ) > 0 Then
//			This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (ID_MODL_ART) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "ID_MODL_ART", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 5 : MT_PRIX_HT															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemDecimal ( lCpt, "MT_PRIX_HT" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Prix Hors Taxe est vide." )
	End If 

	lLen = Len ( sVal )
	
	// Marque la virgule
	bTrouve = False

	For lCptVal = 1 To lLen 
		sCar = Mid ( sVal, lCptVal, 1 )
		If sCar = "." Then
			If Not bTrouve Then 
				bTrouve = True
			Else
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, il y a deux virgules." )
				Exit
			End If

		Else
			If Not ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) Then
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, un caract$$HEX1$$e800$$ENDHEX$$re n'est pas un chiffre." )
				Exit
			End If
		End If
	Next	

	If Real ( sVal ) > 5000 Then		
		This.uf_Trace ( "ECR", "AVERTISSEMENT ligne " + String ( lCpt ) + &
		" : Le montant " + sVal + " para$$HEX1$$ee00$$ENDHEX$$t anormalement grand." )
	End If

	
	/*------------------------------------------------------------------*/
	/* ZONE 6 : UNT_MONNAIE															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "UNT_MONNAIE" ) ) )
	// [SUISSE].LOT3 Controle de la monnaie du fichier
	// Si pas de coh$$HEX1$$e900$$ENDHEX$$rence : erreur bloquante d'int$$HEX1$$e900$$ENDHEX$$gration.
	if uf_controler_monnaie_fichier (sVal, lCpt) < 0 Then iRet = -1
	
//	If IsNull ( sVal ) Or sVal = "" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : L'unit$$HEX2$$e9002000$$ENDHEX$$de la monnaie est vide." )
//	End If 
//
//	If sVal <> "FRF" And sVal <> "EUR" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : La monnaie " + sVal + " n'est pas valide." )
//		Exit
//	End If

	/*------------------------------------------------------------------*/
	/* ZONE 7 : QT_DISP																  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemNumber ( lCpt, "QT_DISP" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		idwFicFourn.SetItem ( lCpt, "QT_DISP", 0 ) 
		sVal = "0"
	End If 

	If Not IsNumber ( sVal ) Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La quantit$$HEX2$$e9002000$$ENDHEX$$" + sVal + " n'est pas valide, ce n'est pas un nombre." )
		
	End If

	/*------------------------------------------------------------------*/
	/* ZONE 8 : OBSERV_FRN 															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )

	If Not IsNull ( sVal ) And sVal <> "" Then
		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (OBSERV_FRN) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "OBSERV_FRN", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 
	
	/*------------------------------------------------------------------*/
	/* ZONE 1 BIS : ID_REF_FOUR													  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur est vide." )
	ElseIf sIdRefFourPrec <> "" And sVal = sIdRefFourPrec Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sVal + " n'est pas unique." )
		
	End If

	sIdRefFourPrec = sVal

Next

If iRet < 0 Then This.uf_Trace ( "ECR", "ERREUR : Le fichier fournisseur n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$.")

Return iRet


end function

private function integer uf_integration_fichier_coriolis (string ascas, ref long alnblig, ref long alnbinsert, ref long alnbdelete);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Integration_Fichier_Coriolis (PRIVATE)
//* Auteur			: JFF
//* Date				: 03/05/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Int$$HEX1$$e900$$ENDHEX$$gration du fichier O2M dans la base
//* Commentaires	: //[PM178][CORIOLIS]
//*
//* Arguments		: Long		alNbLig		Ref
//*					  Long		alNbInsert	Ref
//*					  Long		alNbDelete	Ref
//*					  String 	asCas			Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1    JFF    10/03/2008  Modif suite Bug [SUISSE].LOT3
//* #2    JFF    19/10/2009  [DCMP090615]
//*       JFF    01/02/2012  [VDOC6846]
//        JFF    19/11/2013  [DT_60_AUGM_TVA]
//        JFF    21/09/2016  [VDOC21822]
//        JFF    28/10/2020  [VDOC29759] On lib$$HEX1$$e800$$ENDHEX$$re la marque APPLE
//*-----------------------------------------------------------------

Int iRet
Long	lTotLigFourn, lRow, lCount, lCpt, lTotLigArticle
String	sIdFour, sIdRefFour, sIdTypArt, sIdMarqArt, sIdModlArt, sUntMonnaie, sNull, sIdMqIfr, sIdModlIfr, sIdTypArtRef, sSql
String sIdMarqArtIFr , sIdModlArtIFr 
Decimal {2}	dcTvaParDefaut, dcMtPrixLog 
Boolean bBaseEuro, bInsert
Decimal {2} dcPrixHt
DateTime dt

iRet = 1
alNbInsert = 0
alNbDelete = 0
SetNull ( sNull )

// [DT_60_AUGM_TVA] 1.196
dcTvaParDefaut = 20

dt = DateTime ( Today (), Now () )

/*------------------------------------------------------------------*/
/* Article de R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour le filtre sur l'existant en base       */
/*------------------------------------------------------------------*/
//* #2 [DCMP090615]
// sIdTypArtRef = Upper ( Trim ( idwFicFourn.GetItemString ( 1, "ID_TYP_ART"  ) ) )
//* :#2 [DCMP090615]

idwArticle.Reset ()

// [SUISSE].LOT3 Suppression mecanique conversion $$HEX2$$e0002000$$ENDHEX$$l'integration article
///*------------------------------------------------------------------*/
///* Euro ou Frf ?                                                    */
///*------------------------------------------------------------------*/
//lCount = 0
//SELECT Count (*)
//INTO	 :lCount
//FROM   sysadm.parametre
//WHERE  ref_cpt = 'EURO'
//USING  SQLCA ;
//		
//bBaseEuro = lCount > 0 	

/*------------------------------------------------------------------*/
/* Chargement de la table actuelle                                  */
/*------------------------------------------------------------------*/
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )

If asCas = "1ER_TOUR" Then
	idwArticle.Retrieve ( sIdFour, "*" )
End If

/*------------------------------------------------------------------*/
/* Nbre de ligne dans le fichier                                    */
/*------------------------------------------------------------------*/
lTotLigFourn = idwFicFourn.RowCount ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table                                      */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Initilisation de la trace d'int$$HEX1$$e900$$ENDHEX$$gration.                         */
/*------------------------------------------------------------------*/
If asCas = "1ER_TOUR" Then
	This.uf_Trace_2 ( "INIT", 0, sIdFour, "", "", "", "" )
End If

/*------------------------------------------------------------------*/
/* MAJ de la DW avec le fichier.                                    */
/*------------------------------------------------------------------*/
For alNbLig = 1 To lTotLigFourn

	sIdFour 	   = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_REF_FOUR" ) ) )

	If asCas = "1ER_TOUR" Then

		lRow = idwArticle.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
										 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
										 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
										 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
										 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
										 1, idwArticle.RowCount () )
	
		If lRow <= 0 Then 
			bInsert = True
			lRow = idwArticle.InsertRow ( 0 )
			alNbInsert ++
			idwArticle.SetItem ( lRow, "ID_FOUR", 	 sIdFour	  )				
			idwArticle.SetItem ( lRow, "ID_REF_FOUR",  sIdRefFour  )				
			idwArticle.SetItem ( lRow, "ID_TYP_ART",	 sIdTypArt	  )				
			idwArticle.SetItem ( lRow, "ID_MARQ_ART",	 sIdMarqArt	  )				
			idwArticle.SetItem ( lRow, "ID_MODL_ART",	 sIdModlArt	  )				
			idwArticle.SetItem ( lRow, "ALT_DISPO",	 "N"	 )				
			idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR",	 sNull )				
			idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR",	 sNull )				
			idwArticle.SetItem ( lRow, "TVA", dcTvaParDefaut )		
			idwArticle.SetItem ( lRow, "CREE_LE", dt )		
		Else
			bInsert = False
		End If
	
		If lRow > 0 Then 
	
			// #1 [SUISSE].LOT3
			dcPrixHt = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_HT" )
			idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								
			// :#1
	
	
			/*------------------------------------------------------------------*/
			/* Code $$HEX1$$e900$$ENDHEX$$tat (-EI)                                                  */
			/* 200 Nouveau                                                      */
			/* 100 MAj_Ok sur existant                                          */
			/*------------------------------------------------------------------*/
			If bInsert Then
				idwArticle.SetItem ( lRow, "COD_ETAT", 200 )		
				This.uf_Trace_2 ( "ECR_AUTO", 200, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
			Else
				idwArticle.SetItem ( lRow, "COD_ETAT", 100 )		
				sIdMqIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MARQ_ART_IFR" ) )
				sIdModlIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MODL_ART_IFR" ) )
	
				/*------------------------------------------------------------------*/
				/* Si les marques et mod$$HEX1$$e800$$ENDHEX$$les IFR sont absent de l'enregistrement    */
				/* exisant, on force ALT_DIPSPO $$HEX2$$e0002000$$ENDHEX$$NON.                              */
				/*------------------------------------------------------------------*/
				If Isnull ( sIdMqIfr ) Or sIdMqIfr = "" Or Isnull ( sIdModlIfr ) Or sIdModlIfr = "" Then
					idwArticle.SetItem ( lRow, "ALT_DISPO", "N" )				
				End If
	
				This.uf_Trace_2 ( "ECR_AUTO", 100, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
			End If

			// [VDOC6846]
			Choose Case sIdTypArt 
				Case "TEL", "PC1", "PC2" 
					// Doit $$HEX1$$ea00$$ENDHEX$$tre mis $$HEX2$$e0002000$$ENDHEX$$la main pas Cell. Parte.
					// [VDOC6993]
					If bInsert Then
						sIdMarqArtIFr = Space (35) 
						sIdModlArtIFr = Space (35) 
						SQLCA.PS_S_VDOC6993_LIEN_ARTICLE ( sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, sIdMarqArtIFr, sIdModlArtIFr ) 
						If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) Then
							idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR", sIdMarqArtIFr )				
						End If
						
						If Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
							idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR", sIdModlArtIFr )				
						End If
						
						If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) And &
							Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
							idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
						End If
					End If					
				Case Else
					idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
			End Choose
			// :[VDOC6846]
		
			idwArticle.SetItem ( lRow, "QT_DISP", idwFicFourn.GetItemNumber ( alNbLig, "QT_DISP" ) )

			// [VDOC21822]
			idwArticle.SetItem ( lRow, "OBSERV_FRN", Upper ( idwFicFourn.GetItemString ( alNbLig, "OBSERV_FRN" ) ) + "[#NEU#]" )

//			CORIOLIS le mets directement maintenant, plus la peine de l'ajouter.			
			
			idwArticle.SetItem ( lRow, "VERROU", 1 )
			idwArticle.SetItem ( lRow, "MAJ_LE", dt )		
			idwArticle.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )		
	
		End If
	End If
	
// Maj det_article pour le prix_log
	If asCas = "2EME_TOUR" Then

		dcMtPrixLog = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_LOG" )

		lRow = SQLCA.PS_S01_DET_ARTICLE_TEST_PRESENCE ( sIdFour, sIdRefFour) 

		// On n'int$$HEX1$$e900$$ENDHEX$$gre que certaines c$$HEX1$$e900$$ENDHEX$$t$$HEX1$$e900$$ENDHEX$$gorie.
		If lRow <= 0 Then 
		
			sSql  = "Exec sysadm.DW_I01_DET_ARTICLE "
			sSql += "'" + sIdFour + "'," 
			sSql += "'" + sIdRefFour + "',"
			sSql += "'-1',"
			sSql += "'LOG',"
			sSql += "'" + String ( dcMtPrixLog  ) + "'"
	
			F_Execute ( sSql, SQLCA )
		Else 

			sSql  = "Exec sysadm.DW_U01_DET_ARTICLE "
			sSql += "'" + sIdFour + "'," 
			sSql += "'" + sIdRefFour + "',"
			sSql += "'-1',"
			sSql += "'LOG',"
			sSql += "'" + String ( dcMtPrixLog ) + "'"

			F_Execute ( sSql, SQLCA )
		End If
	End If	
	
Next

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table (r$$HEX1$$e900$$ENDHEX$$actualis$$HEX1$$e900$$ENDHEX$$)                        */
/*------------------------------------------------------------------*/
If asCas = "1ER_TOUR" Then
	lTotLigArticle = idwArticle.RowCount ()
	
	/*------------------------------------------------------------------*/
	/* Suppression des lignes pr$$HEX1$$e900$$ENDHEX$$sentes dans la table articles et       */
	/* absentes du fichier.                                             */
	/*------------------------------------------------------------------*/
	For lCpt = lTotLigArticle To 1 Step -1
	
		sIdFour 	   = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_FOUR"    ) ) )
		sIdTypArt 	= Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_TYP_ART"  ) ) )
		sIdMarqArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MARQ_ART" ) ) )
		sIdModlArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MODL_ART" ) ) )
		sIdRefFour  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )
	
		lRow = idwFicFourn.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
										 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
										 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
										 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
										 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
										 1, idwFicFourn.RowCount () )
	
		If lRow <= 0 Then 

			sSql  = "Exec sysadm.DW_D01_DET_ARTICLE "
			sSql += "'" + sIdFour + "'," 
			sSql += "'" + sIdRefFour + "'"
		
			F_Execute ( sSql, SQLCA )
			
			alNbDelete ++
			idwArticle.DeleteRow ( lCpt )
			This.uf_Trace_2 ( "ECR_AUTO", 300, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		End If
	
	Next 
End If 

idwArticle.SetFilter ( "" )
idwArticle.Filter ()

return iRet 
end function

private function integer uf_ctrl_fichier_converlance ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Ctrl_Fichier_Converlance (PRIVATE)
//* Auteur			: FPI
//* Date				: 27/06/2012
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler de la validit$$HEX2$$e9002000$$ENDHEX$$du fichier de CONVERLANCE
//* Commentaires	: [PC10-2]
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Int iRet 
String	sIdFour, sVal, sCar, sSort, sIdRefFourPrec, sTypArtSav
Long		lTotLig, lCpt, lCptVal, lTotArt, lLen
Boolean	bTrouve

iRet = 1

lTotLig = idwFicFourn.RowCount ()
lTotArt = idwArtSpb.RowCount ()
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sTypArtSav = ""

idwFicFourn.SetSort ( "ID_REF_FOUR A" )
idwFicFourn.Sort ()

sIdRefFourPrec = ""

For lCpt = 1 To lTotLig 

	/*------------------------------------------------------------------*/
	/* ZONE 1 : ID_FOUR                                                 */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone fournisseur est vide." )
	End If 

	If sVal <> sIdFour Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fournisseur " + sVal + " ne correspond pas au fournisseur s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$" + sIdFour )
	End If 

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La longueur du fournisseur doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If
	
	/*------------------------------------------------------------------*/
	/* ZONE 2 : ID_TYP_ART                                              */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_TYP_ART" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Type Article est vide." )
	End If 

	If Not IsNull ( sVal ) And sVal <> "" Then
	  sTypArtSav = sVal
	End If

	bTrouve = False
	lCptVal = 1
	Do While Not bTrouve And lCptVal <= lTotArt
		bTrouve = sVal = Upper ( idwArtSpb.GetItemString ( lCptVal, "ID_CODE" ) )
		lCptVal ++
	Loop

	If Not bTrouve Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type d'article " + sVal + " n'existe pas dans la base SIMPA2.")
	End If

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type de l'article doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If		

	/*------------------------------------------------------------------*/
	/* ZONE 3 : ID_MARQ_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MARQ_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Marque Article est vide." )
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 4 : ID_MODL_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MODL_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone mod$$HEX1$$e800$$ENDHEX$$le article est vide." )
	Else

		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (ID_MODL_ART) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "ID_MODL_ART", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 5 : MT_PRIX_HT															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemDecimal ( lCpt, "MT_PRIX_HT" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Prix Hors Taxe est vide." )
	End If 

	lLen = Len ( sVal )
	
	// Marque la virgule
	bTrouve = False

	For lCptVal = 1 To lLen 
		sCar = Mid ( sVal, lCptVal, 1 )
		If sCar = "." Then
			If Not bTrouve Then 
				bTrouve = True
			Else
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, il y a deux virgules." )
				Exit
			End If

		Else
			If Not ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) Then
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, un caract$$HEX1$$e800$$ENDHEX$$re n'est pas un chiffre." )
				Exit
			End If
		End If
	Next	

	If Real ( sVal ) > 5000 Then		
		This.uf_Trace ( "ECR", "AVERTISSEMENT ligne " + String ( lCpt ) + &
		" : Le montant " + sVal + " para$$HEX1$$ee00$$ENDHEX$$t anormalement grand." )
	End If

	
	/*------------------------------------------------------------------*/
	/* ZONE 6 : UNT_MONNAIE															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "UNT_MONNAIE" ) ) )
	if uf_controler_monnaie_fichier (sVal, lCpt) < 0 Then iRet = -1
	
	/*------------------------------------------------------------------*/
	/* ZONE 7 : QT_DISP																  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemNumber ( lCpt, "QT_DISP" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		idwFicFourn.SetItem ( lCpt, "QT_DISP", 0 ) 
		sVal = "0"
	End If 

	If Not IsNumber ( sVal ) Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La quantit$$HEX2$$e9002000$$ENDHEX$$" + sVal + " n'est pas valide, ce n'est pas un nombre." )
		
	End If


	/*------------------------------------------------------------------*/
	/* ZONE 8 : OBSERV_FRN 															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )

	If Not IsNull ( sVal ) And sVal <> "" Then
		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (OBSERV_FRN) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "OBSERV_FRN", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 1 BIS : ID_REF_FOUR													  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur est vide." )
	ElseIf sIdRefFourPrec <> "" And sVal = sIdRefFourPrec Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sVal + " n'est pas unique." )
		
	End If

	sIdRefFourPrec = sVal

Next

If iRet < 0 Then This.uf_Trace ( "ECR", "ERREUR : Le fichier fournisseur n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$.")

Return iRet


end function

private function integer uf_integration_fichier_converlance (ref long alnblig, ref long alnbinsert, ref long alnbdelete);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Integration_Fichier_converlance (PRIVATE)
//* Auteur			: FPI
//* Date				: 27/06/2012
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Int$$HEX1$$e900$$ENDHEX$$gration du fichier CONVERLANCE dans la base
//* Commentaires	: [PC10-2]
//*
//* Arguments		: Long		alNbLig		Ref
//*					  Long		alNbInsert	Ref
//*					  Long		alNbDelete	Ref
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
///*-----------------------------------------------------------------

Int iRet
Long	lTotLigFourn, lRow, lCount, lCpt, lTotLigArticle
String	sIdFour, sIdRefFour, sIdTypArt, sIdMarqArt, sIdModlArt, sUntMonnaie, sNull, sIdMqIfr, sIdModlIfr, sIdTypArtRef
String sIdMarqArtIFr , sIdModlArtIFr 
Decimal {2}	dcTvaParDefaut
Boolean bBaseEuro, bInsert
Decimal {2} dcPrixHt
DateTime dt

iRet = 1
alNbInsert = 0
alNbDelete = 0
SetNull ( sNull )
dcTvaParDefaut = 20
dt = DateTime ( Today (), Now () )

//	[PC853] [VDOC10913]
dcTvaParDefaut = 0

/*------------------------------------------------------------------*/
/* Article de R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour le filtre sur l'existant en base       */
/*------------------------------------------------------------------*/


idwArticle.Reset ()

/*------------------------------------------------------------------*/
/* Chargement de la table actuelle                                  */
/*------------------------------------------------------------------*/
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
idwArticle.Retrieve ( sIdFour, "*" )

/*------------------------------------------------------------------*/
/* Nbre de ligne dans le fichier                                    */
/*------------------------------------------------------------------*/
lTotLigFourn = idwFicFourn.RowCount ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table                                      */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Initilisation de la trace d'int$$HEX1$$e900$$ENDHEX$$gration.                         */
/*------------------------------------------------------------------*/
This.uf_Trace_2 ( "INIT", 0, sIdFour, "", "", "", "" )

/*------------------------------------------------------------------*/
/* MAJ de la DW avec le fichier.                                    */
/*------------------------------------------------------------------*/
For alNbLig = 1 To lTotLigFourn

	sIdFour 	   = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_REF_FOUR" ) ) )

	lRow = idwArticle.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwArticle.RowCount () )

	If lRow <= 0 Then 
		bInsert = True
		lRow = idwArticle.InsertRow ( 0 )
		alNbInsert ++
		idwArticle.SetItem ( lRow, "ID_FOUR", 	 sIdFour	  )				
		idwArticle.SetItem ( lRow, "ID_REF_FOUR",  sIdRefFour  )				
		idwArticle.SetItem ( lRow, "ID_TYP_ART",	 sIdTypArt	  )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART",	 sIdMarqArt	  )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART",	 sIdModlArt	  )				
		idwArticle.SetItem ( lRow, "ALT_DISPO",	 "N"	 )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "TVA", dcTvaParDefaut )
		idwArticle.SetItem ( lRow, "CREE_LE", dt )		
	Else
		bInsert = False
	End If

	If lRow > 0 Then 
		dcPrixHt = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_HT" )
		idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								

		/*------------------------------------------------------------------*/
		/* Code $$HEX1$$e900$$ENDHEX$$tat (-EI)                                                  */
		/* 200 Nouveau                                                      */
		/* 100 MAj_Ok sur existant                                          */
		/*------------------------------------------------------------------*/
		If bInsert Then
			idwArticle.SetItem ( lRow, "COD_ETAT", 200 )		
			This.uf_Trace_2 ( "ECR_AUTO", 200, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		Else
			idwArticle.SetItem ( lRow, "COD_ETAT", 100 )		

			sIdMqIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MARQ_ART_IFR" ) )
			sIdModlIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MODL_ART_IFR" ) )

			/*------------------------------------------------------------------*/
			/* Si les marques et mod$$HEX1$$e800$$ENDHEX$$les IFR sont absent de l'enregistrement    */
			/* exisant, on force ALT_DIPSPO $$HEX2$$e0002000$$ENDHEX$$NON.                              */
			/*------------------------------------------------------------------*/
			If Isnull ( sIdMqIfr ) Or sIdMqIfr = "" Or Isnull ( sIdModlIfr ) Or sIdModlIfr = "" Then
				idwArticle.SetItem ( lRow, "ALT_DISPO", "N" )				
			End If

			This.uf_Trace_2 ( "ECR_AUTO", 100, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		End If

		// [PC10][DIAG_NOMADE]
		Choose Case sIdTypArt 
			Case "TEL", "PC1", "PC2" 
				// Doit $$HEX1$$ea00$$ENDHEX$$tre mis $$HEX2$$e0002000$$ENDHEX$$la main pas Cell. Parte.
				// [VDOC6993]
				If bInsert Then
					sIdMarqArtIFr = Space (35) 
					sIdModlArtIFr = Space (35) 
					SQLCA.PS_S_VDOC6993_LIEN_ARTICLE ( sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, sIdMarqArtIFr, sIdModlArtIFr ) 
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR", sIdMarqArtIFr )				
					End If
					
					If Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR", sIdModlArtIFr )				
					End If
					
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) And &
						Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
					End If
				End If				
			Case Else
				idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
		End Choose

		idwArticle.SetItem ( lRow, "QT_DISP", 20000 ) // #2 [DCMP090130] 
		idwArticle.SetItem ( lRow, "OBSERV_FRN", Upper ( idwFicFourn.GetItemString ( alNbLig, "OBSERV_FRN" ) ) )
		idwArticle.SetItem ( lRow, "VERROU", 1 )
		idwArticle.SetItem ( lRow, "MAJ_LE", dt )		
		idwArticle.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )		

	End If

Next

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table (r$$HEX1$$e900$$ENDHEX$$actualis$$HEX1$$e900$$ENDHEX$$)                        */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Suppression des lignes pr$$HEX1$$e900$$ENDHEX$$sentes dans la table articles et       */
/* absentes du fichier.                                             */
/*------------------------------------------------------------------*/
For lCpt = lTotLigArticle To 1 Step -1

	sIdFour 	   = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	// [PC10][DIAG_NOMADE]
	Choose Case sIdTypArt
		Case "AEF", "CAF","DEV"
			Continue
	End Choose

	lRow = idwFicFourn.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwFicFourn.RowCount () )

	If lRow <= 0 Then 
		alNbDelete ++
		idwArticle.DeleteRow ( lCpt )
		This.uf_Trace_2 ( "ECR_AUTO", 300, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
	End If

Next 

idwArticle.SetFilter ( "" )
idwArticle.Filter ()

return iRet 
end function

private function integer uf_ctrl_fichier_ore ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Ctrl_Fichier_ORE (PRIVATE)
//* Auteur			: FPI
//* Date				: 21/08/2012
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler de la validit$$HEX2$$e9002000$$ENDHEX$$du fichier de ORE
//* Commentaires	: [PC767]
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

Int iRet 
String	sIdFour, sVal, sCar, sIdRefFourPrec, sTypArtSav, sErr
Long		lTotLig, lCpt, lCptVal, lTotArt, lLen
Boolean	bTrouve

iRet = 1

idwFicFourn.SetFilter ( "Trim(ID_REF_FOUR) <> ''" )
idwFicFourn.Filter ()

lTotLig = idwFicFourn.RowCount ()
lTotArt = idwArtSpb.RowCount ()
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sTypArtSav = ""

// JFF 20/01/2011 : le tri imp$$HEX1$$e900$$ENDHEX$$ratif sur ID_REF_FOUR $$HEX1$$e900$$ENDHEX$$tait visiblement manquant (?..)
idwFicFourn.SetSort ( "ID_REF_FOUR A" )
idwFicFourn.Sort ()

sIdRefFourPrec = ""

For lCpt = 1 To lTotLig 

	/*------------------------------------------------------------------*/
	/* ZONE 1 : ID_FOUR                                                */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone fournisseur est vide." )
	End If 

	If sVal <> sIdFour Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fournisseur " + sVal + " ne correspond pas au fournisseur s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$" + sIdFour )
	End If 

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La longueur du fournisseur doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If

	/*------------------------------------------------------------------*/
	/* ZONE 2 : ID_REF_FOUR													  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur est vide." )
	ElseIf sIdRefFourPrec <> "" And sVal = sIdRefFourPrec Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sVal + " n'est pas unique." )
		
	End If

	sIdRefFourPrec = sVal

	/*------------------------------------------------------------------*/
	/* ZONE 3 : ID_TYP_ART                                              */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_TYP_ART" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Type Article est vide." )
	End If 

	// Le fichier ne doit que contenir que des appareils du m$$HEX1$$ea00$$ENDHEX$$me type
	If sTypArtSav <> sVal And sTypArtSav <> "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fichier contient des types d'appareils diff$$HEX1$$e900$$ENDHEX$$rents !" )
	End If

	If Not IsNull ( sVal ) And sVal <> "" Then
	  sTypArtSav = sVal
	End If

	bTrouve = False
	lCptVal = 1
	Do While Not bTrouve And lCptVal <= lTotArt
		bTrouve = sVal = Upper ( idwArtSpb.GetItemString ( lCptVal, "ID_CODE" ) )
		lCptVal ++
	Loop

	If Not bTrouve Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type d'article " + sVal + " n'existe pas dans la base SIMPA2.")
	End If

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type de l'article doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If		

	/*------------------------------------------------------------------*/
	/* ZONE 4 : ID_MARQ_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MARQ_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Marque Article est vide." )
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 5 : ID_MODL_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MODL_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone mod$$HEX1$$e800$$ENDHEX$$le article est vide." )
	Else

		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (ID_MODL_ART) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "ID_MODL_ART", F_Remplace ( sVal, "'", " " ) )
		End If
		
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 6 : MT_PRIX_HT															  */
	/*------------------------------------------------------------------*/
//	sVal = Trim ( String ( idwFicFourn.GetItemDecimal ( lCpt, "MT_PRIX_HT" ) ) )
	sVal = Trim (idwFicFourn.GetItemString ( lCpt, "MT_PRIX_HT" )  )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Prix Hors Taxe est vide." )
	End If 

	If not uf_check_montant( sval, sErr) Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : " + sErr )
	End If 
	
	If Real ( sVal ) > 5000 Then		
		This.uf_Trace ( "ECR", "AVERTISSEMENT ligne " + String ( lCpt ) + &
		" : Le montant " + sVal + " para$$HEX1$$ee00$$ENDHEX$$t anormalement grand." )
	End If
	
	/*------------------------------------------------------------------*/
	/* ZONE 7 : UNT_MONNAIE															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "UNT_MONNAIE" ) ) )

	if uf_controler_monnaie_fichier (sVal, lCpt) < 0 Then iRet = -1
	
	/*------------------------------------------------------------------*/
	/* ZONE 8 : QT_DISP																  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemNumber ( lCpt, "QT_DISP" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		idwFicFourn.SetItem ( lCpt, "QT_DISP", 0 ) 
		sVal = "0"
	End If 

	If Not IsNumber ( sVal ) Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La quantit$$HEX2$$e9002000$$ENDHEX$$" + sVal + " n'est pas valide, ce n'est pas un nombre." )
		
	End If

	/*------------------------------------------------------------------*/
	/* ZONE 9 : OBSERV_FRN 															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )

	If Not IsNull ( sVal ) And sVal <> "" Then
		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (OBSERV_FRN) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "OBSERV_FRN", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

Next

If iRet < 0 Then This.uf_Trace ( "ECR", "ERREUR : Le fichier fournisseur n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$.")

Return iRet


end function

private function boolean uf_check_montant (string asval, ref string aserr);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_check_montant (PRIVATE)
//* Auteur			: FPI
//* Date				: 21/08/2012
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler de la validit$$HEX2$$e9002000$$ENDHEX$$d'un montant
//* Commentaires	: [PC767]
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------	

Boolean bTrouve, bRet
Long lCptVal,lLen
String sCar

lLen = Len (asVal )
bRet=TRUE
bTrouve = False

For lCptVal = 1 To lLen 
	sCar = Mid ( asVal, lCptVal, 1 )
	If sCar = "." Then
		If Not bTrouve Then 
			bTrouve = True
		Else
			bRet=FALSE
			asErr="Le montant " + asVal + " n'est pas valide, il y a deux virgules." 
			Exit
		End If

	Else
		If Not ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) Then
			bRet=FALSE
			asErr="Le montant " + asVal + " n'est pas valide, un caract$$HEX1$$e800$$ENDHEX$$re n'est pas un chiffre." 
			Exit
		End If
	End If
Next	

Return bRet
end function

private function integer uf_integration_fichier_ore (ref long alnblig, ref long alnbinsert, ref long alnbdelete);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_int_fic_article::uf_Integration_Fichier_ORE (PRIVATE)
//* Auteur			: FPI
//* Date				: 30/10/2012
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Int$$HEX1$$e900$$ENDHEX$$gration du fichier ORE dans la base
//* Commentaires	: 
//*
//* Arguments		: Long		alNbLig		Ref
//*					  Long		alNbInsert	Ref
//*					  Long		alNbDelete	Ref
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//        JFF   19/11/2013 [DT_60_AUGM_TVA]
//*-----------------------------------------------------------------

Int iRet
Long	lTotLigFourn, lRow, lCount, lCpt, lTotLigArticle
String	sIdFour, sIdRefFour, sIdTypArt, sIdMarqArt, sIdModlArt, sUntMonnaie, sNull, sIdMqIfr, sIdModlIfr, sIdTypArtRef , sMtHT
Decimal {2}	dcTvaParDefaut
Boolean bBaseEuro, bInsert
Decimal {2} dcPrixHt
DateTime dt
n_cst_string nvString

iRet = 1
alNbInsert = 0
alNbDelete = 0
SetNull ( sNull )

// [DT_60_AUGM_TVA] 1.196
dcTvaParDefaut = 20

dt = DateTime ( Today (), Now () )

/*------------------------------------------------------------------*/
/* Article de R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour le filtre sur l'existant en base       */
/*------------------------------------------------------------------*/
sIdTypArtRef = Upper ( Trim ( idwFicFourn.GetItemString ( 1, "ID_TYP_ART"  ) ) )

idwArticle.Reset ()

/*------------------------------------------------------------------*/
/* Chargement de la table actuelle                                  */
/*------------------------------------------------------------------*/
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
idwArticle.Retrieve ( sIdFour, "*" )
idwArticle.SetFilter ( "ID_TYP_ART = '" + sIdTypArtRef + "'" )
idwArticle.Filter ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans le fichier                                    */
/*------------------------------------------------------------------*/
lTotLigFourn = idwFicFourn.RowCount ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table                                      */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Initilisation de la trace d'int$$HEX1$$e900$$ENDHEX$$gration.                         */
/*------------------------------------------------------------------*/
This.uf_Trace_2 ( "INIT", 0, sIdFour, "", "", "", "" )

/*------------------------------------------------------------------*/
/* MAJ de la DW avec le fichier.                                    */
/*------------------------------------------------------------------*/
For alNbLig = 1 To lTotLigFourn

	sIdFour 	   = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_REF_FOUR" ) ) )

	// Ajustement du mod$$HEX1$$e800$$ENDHEX$$le
	If Pos(sIdModlArt,sIdMarqArt) = 1 Then
		sIdModlArt=Mid(sIdModlArt,Len(sIdMarqArt)+1)
		sIdModlArt=nvString.of_globalreplace( sIdModlArt , "(", "")
		sIdModlArt=nvString.of_globalreplace( sIdModlArt , ")", "")
		sIdModlArt=Trim(sIdModlArt)
		
		idwFicFourn.SetItem( alNbLig, "ID_MODL_ART", sIdModlArt) 
	End if
	
	lRow = idwArticle.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwArticle.RowCount () )

	If lRow <= 0 Then 
		bInsert = True
		lRow = idwArticle.InsertRow ( 0 )
		alNbInsert ++
		idwArticle.SetItem ( lRow, "ID_FOUR", 	 sIdFour	  )				
		idwArticle.SetItem ( lRow, "ID_REF_FOUR",  sIdRefFour  )				
		idwArticle.SetItem ( lRow, "ID_TYP_ART",	 sIdTypArt	  )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART",	 sIdMarqArt	  )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART",	 sIdModlArt	  )				
		idwArticle.SetItem ( lRow, "ALT_DISPO",	 "N"	 )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "TVA", dcTvaParDefaut )		
		idwArticle.SetItem ( lRow, "CREE_LE", dt )		
	Else
		bInsert = False
	End If

	If lRow > 0 Then 

		sMtHT = idwFicFourn.GetItemString ( alNbLig, "MT_PRIX_HT" )
		sMtHT = nvstring.of_globalreplace( sMtHT , ",", ".")
		
		dcPrixHt=Dec(sMtHT)
		idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								


		/*------------------------------------------------------------------*/
		/* Code $$HEX1$$e900$$ENDHEX$$tat (-EI)                                                  */
		/* 200 Nouveau                                                      */
		/* 100 MAj_Ok sur existant                                          */
		/*------------------------------------------------------------------*/
		If bInsert Then
			idwArticle.SetItem ( lRow, "COD_ETAT", 200 )		
			This.uf_Trace_2 ( "ECR_AUTO", 200, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		Else
			idwArticle.SetItem ( lRow, "COD_ETAT", 100 )		

			sIdMqIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MARQ_ART_IFR" ) )
			sIdModlIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MODL_ART_IFR" ) )

			/*------------------------------------------------------------------*/
			/* Si les marques et mod$$HEX1$$e800$$ENDHEX$$les IFR sont absent de l'enregistrement    */
			/* exisant, on force ALT_DIPSPO $$HEX2$$e0002000$$ENDHEX$$NON.                              */
			/*------------------------------------------------------------------*/
			If Isnull ( sIdMqIfr ) Or sIdMqIfr = "" Or Isnull ( sIdModlIfr ) Or sIdModlIfr = "" Then
				idwArticle.SetItem ( lRow, "ALT_DISPO", "N" )				
			End If

			This.uf_Trace_2 ( "ECR_AUTO", 100, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		End If

		idwArticle.SetItem ( lRow, "QT_DISP", idwFicFourn.GetItemNumber ( alNbLig, "QT_DISP" ) )
		idwArticle.SetItem ( lRow, "OBSERV_FRN", Upper ( idwFicFourn.GetItemString ( alNbLig, "OBSERV_FRN" ) ) )
		idwArticle.SetItem ( lRow, "VERROU", 1 )
		idwArticle.SetItem ( lRow, "MAJ_LE", dt )		
		idwArticle.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )		

	End If

Next

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table (r$$HEX1$$e900$$ENDHEX$$actualis$$HEX1$$e900$$ENDHEX$$)                        */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Suppression des lignes pr$$HEX1$$e900$$ENDHEX$$sentes dans la table articles et       */
/* absentes du fichier.                                             */
/*------------------------------------------------------------------*/
For lCpt = lTotLigArticle To 1 Step -1

	sIdFour 	   = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	lRow = idwFicFourn.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwFicFourn.RowCount () )

	If lRow <= 0 Then 
		alNbDelete ++
		idwArticle.DeleteRow ( lCpt )
		This.uf_Trace_2 ( "ECR_AUTO", 300, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
	End If

Next 

idwArticle.SetFilter ( "" )
idwArticle.Filter ()

return iRet 
end function

private function integer uf_ctrl_fichier_omt ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Ctrl_Fichier_OMT (PRIVATE)
//* Auteur			: FPI
//* Date				: 19/02/2013
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler de la validit$$HEX2$$e9002000$$ENDHEX$$du fichier de OMT
//* Commentaires	: [PC874]
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

Int iRet 
String	sIdFour, sVal, sCar, sIdRefFourPrec, sTypArtSav, sErr
Long		lTotLig, lCpt, lCptVal, lTotArt, lLen
Boolean	bTrouve

iRet = 1

idwFicFourn.SetFilter ( "Trim(ID_REF_FOUR) <> ''" )
idwFicFourn.Filter ()

lTotLig = idwFicFourn.RowCount ()
lTotArt = idwArtSpb.RowCount ()
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sTypArtSav = ""

idwFicFourn.SetSort ( "ID_REF_FOUR A" )
idwFicFourn.Sort ()

sIdRefFourPrec = ""

For lCpt = 1 To lTotLig 

	/*------------------------------------------------------------------*/
	/* ZONE 1 : ID_FOUR                                                */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone fournisseur est vide." )
	End If 

	If sVal <> sIdFour Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fournisseur " + sVal + " ne correspond pas au fournisseur s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$" + sIdFour )
	End If 

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La longueur du fournisseur doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If

	/*------------------------------------------------------------------*/
	/* ZONE 2 : ID_REF_FOUR													  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur est vide." )
	ElseIf sIdRefFourPrec <> "" And sVal = sIdRefFourPrec Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sVal + " n'est pas unique." )
		
	End If

	sIdRefFourPrec = sVal

	/*------------------------------------------------------------------*/
	/* ZONE 3 : ID_TYP_ART                                              */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_TYP_ART" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Type Article est vide." )
	End If 

	// Le fichier ne doit que contenir que des appareils du m$$HEX1$$ea00$$ENDHEX$$me type
	If sTypArtSav <> sVal And sTypArtSav <> "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fichier contient des types d'appareils diff$$HEX1$$e900$$ENDHEX$$rents !" )
	End If

	If Not IsNull ( sVal ) And sVal <> "" Then
	  sTypArtSav = sVal
	End If

	bTrouve = False
	lCptVal = 1
	Do While Not bTrouve And lCptVal <= lTotArt
		bTrouve = sVal = Upper ( idwArtSpb.GetItemString ( lCptVal, "ID_CODE" ) )
		lCptVal ++
	Loop

	If Not bTrouve Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type d'article " + sVal + " n'existe pas dans la base SIMPA2.")
	End If

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type de l'article doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If		

	/*------------------------------------------------------------------*/
	/* ZONE 4 : ID_MARQ_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MARQ_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Marque Article est vide." )
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 5 : ID_MODL_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MODL_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone mod$$HEX1$$e800$$ENDHEX$$le article est vide." )
	Else

		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (ID_MODL_ART) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "ID_MODL_ART", F_Remplace ( sVal, "'", " " ) )
		End If
		
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 6 : MT_PRIX_HT															  */
	/*------------------------------------------------------------------*/
//	sVal = Trim ( String ( idwFicFourn.GetItemDecimal ( lCpt, "MT_PRIX_HT" ) ) )
	sVal = Trim (idwFicFourn.GetItemString ( lCpt, "MT_PRIX_HT" )  )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Prix Hors Taxe est vide." )
	End If 

	If not uf_check_montant( sval, sErr) Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : " + sErr )
	End If 
	
	If Real ( sVal ) > 5000 Then		
		This.uf_Trace ( "ECR", "AVERTISSEMENT ligne " + String ( lCpt ) + &
		" : Le montant " + sVal + " para$$HEX1$$ee00$$ENDHEX$$t anormalement grand." )
	End If
Next

If iRet < 0 Then This.uf_Trace ( "ECR", "ERREUR : Le fichier fournisseur n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$.")

Return iRet


end function

private function integer uf_integration_fichier_omt (ref long alnblig, ref long alnbinsert, ref long alnbdelete);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_int_fic_article::uf_Integration_Fichier_OMT (PRIVATE)
//* Auteur			: FPI
//* Date				: 19/02/2013
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Int$$HEX1$$e900$$ENDHEX$$gration du fichier OMT dans la base
//* Commentaires	: [PC874]
//*
//* Arguments		: Long		alNbLig		Ref
//*					  Long		alNbInsert	Ref
//*					  Long		alNbDelete	Ref
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

Int iRet
Long	lTotLigFourn, lRow, lCount, lCpt, lTotLigArticle
String	sIdFour, sIdRefFour, sIdTypArt, sIdMarqArt, sIdModlArt, sUntMonnaie, sNull, sIdMqIfr, sIdModlIfr, sIdTypArtRef , sMtHT
Decimal {2}	dcTvaParDefaut
Boolean bBaseEuro, bInsert
Decimal {2} dcPrixHt
DateTime dt
n_cst_string nvString

iRet = 1
alNbInsert = 0
alNbDelete = 0
SetNull ( sNull )
// 1.196
dcTvaParDefaut = 9.0 // Taux sp$$HEX1$$e900$$ENDHEX$$cifique $$HEX2$$e0002000$$ENDHEX$$OMT
dt = DateTime ( Today (), Now () )

/*------------------------------------------------------------------*/
/* Article de R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour le filtre sur l'existant en base       */
/*------------------------------------------------------------------*/
sIdTypArtRef = Upper ( Trim ( idwFicFourn.GetItemString ( 1, "ID_TYP_ART"  ) ) )

idwArticle.Reset ()

/*------------------------------------------------------------------*/
/* Chargement de la table actuelle                                  */
/*------------------------------------------------------------------*/
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
idwArticle.Retrieve ( sIdFour, "*" )
idwArticle.SetFilter ( "ID_TYP_ART = '" + sIdTypArtRef + "'" )
idwArticle.Filter ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans le fichier                                    */
/*------------------------------------------------------------------*/
lTotLigFourn = idwFicFourn.RowCount ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table                                      */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Initilisation de la trace d'int$$HEX1$$e900$$ENDHEX$$gration.                         */
/*------------------------------------------------------------------*/
This.uf_Trace_2 ( "INIT", 0, sIdFour, "", "", "", "" )

/*------------------------------------------------------------------*/
/* MAJ de la DW avec le fichier.                                    */
/*------------------------------------------------------------------*/
For alNbLig = 1 To lTotLigFourn

	sIdFour 	   = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_REF_FOUR" ) ) )

	// Ajustement du mod$$HEX1$$e800$$ENDHEX$$le
	If Pos(sIdModlArt,sIdMarqArt) = 1 Then
		sIdModlArt=Mid(sIdModlArt,Len(sIdMarqArt)+1)
		sIdModlArt=nvString.of_globalreplace( sIdModlArt , "(", "")
		sIdModlArt=nvString.of_globalreplace( sIdModlArt , ")", "")
		sIdModlArt=Trim(sIdModlArt)
		
		idwFicFourn.SetItem( alNbLig, "ID_MODL_ART", sIdModlArt) 
	End if
	
	lRow = idwArticle.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwArticle.RowCount () )

	If lRow <= 0 Then 
		bInsert = True
		lRow = idwArticle.InsertRow ( 0 )
		alNbInsert ++
		idwArticle.SetItem ( lRow, "ID_FOUR", 	 sIdFour	  )				
		idwArticle.SetItem ( lRow, "ID_REF_FOUR",  sIdRefFour  )				
		idwArticle.SetItem ( lRow, "ID_TYP_ART",	 sIdTypArt	  )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART",	 sIdMarqArt	  )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART",	 sIdModlArt	  )				
		idwArticle.SetItem ( lRow, "ALT_DISPO",	 "N"	 )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "TVA", dcTvaParDefaut )		
		idwArticle.SetItem ( lRow, "CREE_LE", dt )		
	Else
		bInsert = False
	End If

	If lRow > 0 Then 

		sMtHT = idwFicFourn.GetItemString ( alNbLig, "MT_PRIX_HT" )
		sMtHT = nvstring.of_globalreplace( sMtHT , ",", ".")
		
		dcPrixHt=Dec(sMtHT)
		idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								


		/*------------------------------------------------------------------*/
		/* Code $$HEX1$$e900$$ENDHEX$$tat (-EI)                                                  */
		/* 200 Nouveau                                                      */
		/* 100 MAj_Ok sur existant                                          */
		/*------------------------------------------------------------------*/
		If bInsert Then
			idwArticle.SetItem ( lRow, "COD_ETAT", 200 )		
			This.uf_Trace_2 ( "ECR_AUTO", 200, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		Else
			idwArticle.SetItem ( lRow, "COD_ETAT", 100 )		

			sIdMqIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MARQ_ART_IFR" ) )
			sIdModlIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MODL_ART_IFR" ) )

			/*------------------------------------------------------------------*/
			/* Si les marques et mod$$HEX1$$e800$$ENDHEX$$les IFR sont absent de l'enregistrement    */
			/* exisant, on force ALT_DIPSPO $$HEX2$$e0002000$$ENDHEX$$NON.                              */
			/*------------------------------------------------------------------*/
			If Isnull ( sIdMqIfr ) Or sIdMqIfr = "" Or Isnull ( sIdModlIfr ) Or sIdModlIfr = "" Then
				idwArticle.SetItem ( lRow, "ALT_DISPO", "N" )				
			End If

			This.uf_Trace_2 ( "ECR_AUTO", 100, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		End If

		idwArticle.SetItem ( lRow, "QT_DISP", 9999 )
		idwArticle.SetItem ( lRow, "OBSERV_FRN", sNull )
		idwArticle.SetItem ( lRow, "VERROU", 1 )
		idwArticle.SetItem ( lRow, "MAJ_LE", dt )		
		idwArticle.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )		

	End If

Next

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table (r$$HEX1$$e900$$ENDHEX$$actualis$$HEX1$$e900$$ENDHEX$$)                        */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Suppression des lignes pr$$HEX1$$e900$$ENDHEX$$sentes dans la table articles et       */
/* absentes du fichier.                                             */
/*------------------------------------------------------------------*/
For lCpt = lTotLigArticle To 1 Step -1

	sIdFour 	   = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	lRow = idwFicFourn.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwFicFourn.RowCount () )

	If lRow <= 0 Then 
		alNbDelete ++
		idwArticle.DeleteRow ( lCpt )
		This.uf_Trace_2 ( "ECR_AUTO", 300, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
	End If

Next 

idwArticle.SetFilter ( "" )
idwArticle.Filter ()

return iRet 
end function

private function integer uf_ctrl_fichier_mtt ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Ctrl_Fichier_MTT (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 30/12/2013
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler de la validit$$HEX2$$e9002000$$ENDHEX$$du fichier Article de CEGETEL
//* Commentaires	: [PC13348&13408]
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    19/10/2009  [DCMP090615]
//* 		 JFF     03/05/2011 [PM166][O2M]
//			FPI	27/07/2012	[DT018] ajout du code 1F4
//*-----------------------------------------------------------------

Int iRet 
String	sIdFour, sVal, sCar, sSort, sIdRefFourPrec, sTypArtSav
Long		lTotLig, lCpt, lCptVal, lTotArt, lLen
Boolean	bTrouve

iRet = 1

lTotLig = idwFicFourn.RowCount ()
lTotArt = idwArtSpb.RowCount ()
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sTypArtSav = ""

// JFF 20/01/2011 : le tri imp$$HEX1$$e900$$ENDHEX$$ratif sur ID_REF_FOUR $$HEX1$$e900$$ENDHEX$$tait visiblement manquant (?..)
idwFicFourn.SetSort ( "ID_REF_FOUR A" )
idwFicFourn.Sort ()

sIdRefFourPrec = ""


For lCpt = 1 To lTotLig 

	/*------------------------------------------------------------------*/
	/* ZONE 1 : ID_FOUR                                                */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone fournisseur est vide." )
	End If 

	If sVal <> sIdFour Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fournisseur " + sVal + " ne correspond pas au fournisseur s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$" + sIdFour )
	End If 

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La longueur du fournisseur doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If
	
	/*------------------------------------------------------------------*/
	/* ZONE 2 : ID_TYP_ART                                              */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_TYP_ART" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Type Article est vide." )
	End If 

	// Le fichier ne doit que contenir que des appareils du m$$HEX1$$ea00$$ENDHEX$$me type
	/*
	// #1 [DCMP090615]
	If sTypArtSav <> sVal And sTypArtSav <> "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fichier contient des types d'appareils diff$$HEX1$$e900$$ENDHEX$$rents !" )
	End If
	*/

	If Not IsNull ( sVal ) And sVal <> "" Then
	  sTypArtSav = sVal
	End If

	bTrouve = False
	lCptVal = 1
	Do While Not bTrouve And lCptVal <= lTotArt
		bTrouve = sVal = Upper ( idwArtSpb.GetItemString ( lCptVal, "ID_CODE" ) )
		lCptVal ++
	Loop

	If Not bTrouve Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type d'article " + sVal + " n'existe pas dans la base SIMPA2.")
	End If

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type de l'article doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If		

	/*------------------------------------------------------------------*/
	/* ZONE 3 : ID_MARQ_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MARQ_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Marque Article est vide." )
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 4 : ID_MODL_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MODL_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone mod$$HEX1$$e800$$ENDHEX$$le article est vide." )
	Else

		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (ID_MODL_ART) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "ID_MODL_ART", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 5 : MT_PRIX_HT															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemDecimal ( lCpt, "MT_PRIX_HT" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Prix Hors Taxe est vide." )
	End If 

	lLen = Len ( sVal )
	
	// Marque la virgule
	bTrouve = False

	For lCptVal = 1 To lLen 
		sCar = Mid ( sVal, lCptVal, 1 )
		If sCar = "." Then
			If Not bTrouve Then 
				bTrouve = True
			Else
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, il y a deux virgules." )
				Exit
			End If

		Else
			If Not ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) Then
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, un caract$$HEX1$$e800$$ENDHEX$$re n'est pas un chiffre." )
				Exit
			End If
		End If
	Next	

	If Real ( sVal ) > 5000 Then		
		This.uf_Trace ( "ECR", "AVERTISSEMENT ligne " + String ( lCpt ) + &
		" : Le montant " + sVal + " para$$HEX1$$ee00$$ENDHEX$$t anormalement grand." )
	End If

	
	/*------------------------------------------------------------------*/
	/* ZONE 6 : UNT_MONNAIE															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "UNT_MONNAIE" ) ) )
	// [SUISSE].LOT3 Controle de la monnaie du fichier
	// Si pas de coh$$HEX1$$e900$$ENDHEX$$rence : erreur bloquante d'int$$HEX1$$e900$$ENDHEX$$gration.
	if uf_controler_monnaie_fichier (sVal, lCpt) < 0 Then iRet = -1
	
//	If IsNull ( sVal ) Or sVal = "" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : L'unit$$HEX2$$e9002000$$ENDHEX$$de la monnaie est vide." )
//	End If 
//
//	If sVal <> "FRF" And sVal <> "EUR" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : La monnaie " + sVal + " n'est pas valide." )
//		Exit
//	End If

	/*------------------------------------------------------------------*/
	/* ZONE 8 : OBSERV_FRN 															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )

	If Not IsNull ( sVal ) And sVal <> "" Then
		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (OBSERV_FRN) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "OBSERV_FRN", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	
	/*------------------------------------------------------------------*/
	/* #1																					  */
	/*------------------------------------------------------------------*/
	/* ZONE 1 BIS : ID_REF_FOUR													  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur est vide." )
	ElseIf sIdRefFourPrec <> "" And sVal = sIdRefFourPrec Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sVal + " n'est pas unique." )
		
	End If

	sIdRefFourPrec = sVal

Next

If iRet < 0 Then This.uf_Trace ( "ECR", "ERREUR : Le fichier fournisseur n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$.")

Return iRet


end function

private function integer uf_integration_fichier_mtt (ref long alnblig, ref long alnbinsert, ref long alnbdelete);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Integration_Fichier_MTT (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 30/12/2013
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [PC13348&13408]
//* Commentaires	: 
//*
//* Arguments		: Long		alNbLig		Ref
//*					  Long		alNbInsert	Ref
//*					  Long		alNbDelete	Ref
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1		JCA	01/09/2006	On force la quantit$$HEX4$$e9002000e0002000$$ENDHEX$$5000
//* #2		JFF	12/09/2006	[DCMP070645] On ajoute 20 Euros au montant HT lors de l'int$$HEX1$$e900$$ENDHEX$$gration
//*									sur demain d'OMG (Mathias)
//* #3    JFF    10/03/2008  Modif suite Bug [SUISSE].LOT3
//* #4    JFF    17/04/2008  [DCMP080322] suppression des 20 Euros
//* #5    JFF    19/10/2009  [DCMP090615]
//			FPI	24/01/2012	[PC581] Int$$HEX1$$e900$$ENDHEX$$gration de TPC
//       JFF   26/08/2013 [DT57_CMDE_IPHONE_SFR]
//        JFF   19/11/2013 [DT_60_AUGM_TVA]
//*-----------------------------------------------------------------

Int iRet
Long	lTotLigFourn, lRow, lCount, lCpt, lTotLigArticle
String	sIdFour, sIdRefFour, sIdTypArt, sIdMarqArt, sIdModlArt, sUntMonnaie, sNull, sIdMqIfr, sIdModlIfr, sIdTypArtRef
String sIdMarqArtIFr , sIdModlArtIFr
Decimal {2}	dcTvaParDefaut
Boolean bBaseEuro, bInsert
Decimal {2} dcPrixHt
DateTime dt

iRet = 1
alNbInsert = 0
alNbDelete = 0
SetNull ( sNull )

// [DT_60_AUGM_TVA] 1.196
dcTvaParDefaut = 20

dt = DateTime ( Today (), Now () )

/*------------------------------------------------------------------*/
/* Article de R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour le filtre sur l'existant en base       */
/*------------------------------------------------------------------*/
//* #5    JFF    19/10/2009  [DCMP090615]
// sIdTypArtRef = Upper ( Trim ( idwFicFourn.GetItemString ( 1, "ID_TYP_ART" ) ) )
//* :#5    JFF    19/10/2009  [DCMP090615]

idwArticle.Reset ()


/*------------------------------------------------------------------*/
/* Chargement de la table actuelle                                  */
/*------------------------------------------------------------------*/
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
idwArticle.Retrieve ( sIdFour, "*" )
//* #5    JFF    19/10/2009  [DCMP090615]
// idwArticle.SetFilter ( "ID_TYP_ART = '" + sIdTypArtRef + "'" )
// idwArticle.Filter ()
//* :#5    JFF    19/10/2009  [DCMP090615]

/*------------------------------------------------------------------*/
/* Nbre de ligne dans le fichier                                    */
/*------------------------------------------------------------------*/
lTotLigFourn = idwFicFourn.RowCount ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table                                      */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Initilisation de la trace d'int$$HEX1$$e900$$ENDHEX$$gration.                         */
/*------------------------------------------------------------------*/
This.uf_Trace_2 ( "INIT", 0, sIdFour, "", "", "", "" )

/*------------------------------------------------------------------*/
/* MAJ de la DW avec le fichier.                                    */
/*------------------------------------------------------------------*/
For alNbLig = 1 To lTotLigFourn

	sIdFour 	   = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_REF_FOUR" ) ) )

	lRow = idwArticle.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwArticle.RowCount () )

	If lRow <= 0 Then 
		bInsert = True
		lRow = idwArticle.InsertRow ( 0 )
		alNbInsert ++
		idwArticle.SetItem ( lRow, "ID_FOUR", 	 sIdFour	  )				
		idwArticle.SetItem ( lRow, "ID_REF_FOUR",  sIdRefFour  )				
		idwArticle.SetItem ( lRow, "ID_TYP_ART",	 sIdTypArt	  )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART",	 sIdMarqArt	  )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART",	 sIdModlArt	  )				
		idwArticle.SetItem ( lRow, "ALT_DISPO",	 "N"	 )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "TVA", dcTvaParDefaut )		
		idwArticle.SetItem ( lRow, "CREE_LE", dt )		
	Else
		bInsert = False
	End If

	If lRow > 0 Then 

		// #3 [SUISSE].LOT3
		dcPrixHt = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_HT" )
		idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								
		// :#3

		/*------------------------------------------------------------------*/
		/* Code $$HEX1$$e900$$ENDHEX$$tat (-EI)                                                  */
		/* 200 Nouveau                                                      */
		/* 100 MAj_Ok sur existant                                          */
		/*------------------------------------------------------------------*/
		If bInsert Then
			idwArticle.SetItem ( lRow, "COD_ETAT", 200 )		
			This.uf_Trace_2 ( "ECR_AUTO", 200, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		Else
			idwArticle.SetItem ( lRow, "COD_ETAT", 100 )		
			sIdMqIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MARQ_ART_IFR" ) )
			sIdModlIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MODL_ART_IFR" ) )

			/*------------------------------------------------------------------*/
			/* Si les marques et mod$$HEX1$$e800$$ENDHEX$$les IFR sont absent de l'enregistrement    */
			/* exisant, on force ALT_DIPSPO $$HEX2$$e0002000$$ENDHEX$$NON.                              */
			/*------------------------------------------------------------------*/
			If Isnull ( sIdMqIfr ) Or sIdMqIfr = "" Or Isnull ( sIdModlIfr ) Or sIdModlIfr = "" Then
				idwArticle.SetItem ( lRow, "ALT_DISPO", "N" )				
			End If

			This.uf_Trace_2 ( "ECR_AUTO", 100, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		End If

		// [PC581] - Int$$HEX1$$e900$$ENDHEX$$gration de TPC -> ALT_DISPO $$HEX2$$e0002000$$ENDHEX$$Oui
		Choose Case sIdTypArt 
			Case "TEL", "PC1", "PC2" 
				// Doit $$HEX1$$ea00$$ENDHEX$$tre mis $$HEX2$$e0002000$$ENDHEX$$la main pas Cell. Parte.
				// [VDOC6993]
				If bInsert Then
					sIdMarqArtIFr = Space (35) 
					sIdModlArtIFr = Space (35) 
					SQLCA.PS_S_VDOC6993_LIEN_ARTICLE ( sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, sIdMarqArtIFr, sIdModlArtIFr ) 
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR", sIdMarqArtIFr )				
					End If
					
					If Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR", sIdModlArtIFr )				
					End If
					
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) And &
						Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
					End If
				End If				
			Case Else
				idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
		End Choose

		// #1
		idwArticle.SetItem ( lRow, "QT_DISP", idwFicFourn.GetItemNumber ( alNbLig, "QT_DISP" ) )
		idwArticle.SetItem ( lRow, "OBSERV_FRN", Upper ( idwFicFourn.GetItemString ( alNbLig, "OBSERV_FRN" ) ) )
		idwArticle.SetItem ( lRow, "VERROU", 1 )
		idwArticle.SetItem ( lRow, "MAJ_LE", dt )		
		idwArticle.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )		

	End If

Next

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table (r$$HEX1$$e900$$ENDHEX$$actualis$$HEX1$$e900$$ENDHEX$$)                        */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Suppression des lignes pr$$HEX1$$e900$$ENDHEX$$sentes dans la table articles et       */
/* absentes du fichier.                                             */
/*------------------------------------------------------------------*/
For lCpt = lTotLigArticle To 1 Step -1

	sIdFour 	   = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	lRow = idwFicFourn.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwFicFourn.RowCount () )


	If lRow <= 0 Then 
		alNbDelete ++
		idwArticle.DeleteRow ( lCpt )
		This.uf_Trace_2 ( "ECR_AUTO", 300, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
	End If

Next 

idwArticle.SetFilter ( "" )
idwArticle.Filter ()

return iRet 
end function

private function integer uf_ctrl_fichier_srr ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Ctrl_Fichier_SRR (PRIVATE)
//* Auteur			: FPI
//* Date				: 11/02/2014
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler de la validit$$HEX2$$e9002000$$ENDHEX$$du fichier Article de SRR
//* Commentaires	: 
//*
//* Arguments		: [PC925]
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Int iRet 
String	sIdFour, sVal, sCar, sSort, sIdRefFourPrec, sTypArtSav
Long		lTotLig, lCpt, lCptVal, lTotArt, lLen
Boolean	bTrouve

iRet = 1

lTotLig = idwFicFourn.RowCount ()
lTotArt = idwArtSpb.RowCount ()
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sTypArtSav = ""

idwFicFourn.SetSort ( "ID_REF_FOUR A" )
idwFicFourn.Sort ()

sIdRefFourPrec = ""

For lCpt = 1 To lTotLig 

	/*------------------------------------------------------------------*/
	/* ZONE 1 : ID_FOUR                                                */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone fournisseur est vide." )
	End If 

	If sVal <> sIdFour Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fournisseur " + sVal + " ne correspond pas au fournisseur s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$" + sIdFour )
	End If 

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La longueur du fournisseur doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If
	
	/*------------------------------------------------------------------*/
	/* ZONE 2 : ID_TYP_ART                                              */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_TYP_ART" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Type Article est vide." )
	End If 

	If Not IsNull ( sVal ) And sVal <> "" Then
	  sTypArtSav = sVal
	End If

	bTrouve = False
	lCptVal = 1
	Do While Not bTrouve And lCptVal <= lTotArt
		bTrouve = sVal = Upper ( idwArtSpb.GetItemString ( lCptVal, "ID_CODE" ) )
		lCptVal ++
	Loop

	If Not bTrouve Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type d'article " + sVal + " n'existe pas dans la base SIMPA2.")
	End If

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type de l'article doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If		

	/*------------------------------------------------------------------*/
	/* ZONE 3 : ID_MARQ_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MARQ_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Marque Article est vide." )
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 4 : ID_MODL_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MODL_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone mod$$HEX1$$e800$$ENDHEX$$le article est vide." )
	Else

		If Pos ( sVal, "'", 1 ) > 0 Then
			//This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (ID_MODL_ART) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "ID_MODL_ART", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 5 : MT_PRIX_HT															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemDecimal ( lCpt, "MT_PRIX_HT" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Prix Hors Taxe est vide." )
	End If 

	lLen = Len ( sVal )
	
	// Marque la virgule
	bTrouve = False

	For lCptVal = 1 To lLen 
		sCar = Mid ( sVal, lCptVal, 1 )
		If sCar = "." Then
			If Not bTrouve Then 
				bTrouve = True
			Else
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, il y a deux virgules." )
				Exit
			End If

		Else
			If Not ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) Then
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, un caract$$HEX1$$e800$$ENDHEX$$re n'est pas un chiffre." )
				Exit
			End If
		End If
	Next	

	If Real ( sVal ) > 5000 Then		
		This.uf_Trace ( "ECR", "AVERTISSEMENT ligne " + String ( lCpt ) + &
		" : Le montant " + sVal + " para$$HEX1$$ee00$$ENDHEX$$t anormalement grand." )
	End If

	
	/*------------------------------------------------------------------*/
	/* ZONE 6 : UNT_MONNAIE															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "UNT_MONNAIE" ) ) )

	if uf_controler_monnaie_fichier (sVal, lCpt) < 0 Then iRet = -1
	
	/*------------------------------------------------------------------*/
	/* ZONE 7 : QT_DISP																  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemNumber ( lCpt, "QT_DISP" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		idwFicFourn.SetItem ( lCpt, "QT_DISP", 0 ) 
		sVal = "0"
	End If 

	If Not IsNumber ( sVal ) Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La quantit$$HEX2$$e9002000$$ENDHEX$$" + sVal + " n'est pas valide, ce n'est pas un nombre." )
		
	End If

	/*------------------------------------------------------------------*/
	/* ZONE 8 : OBSERV_FRN 															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )

	If Not IsNull ( sVal ) And sVal <> "" Then
		If Pos ( sVal, "'", 1 ) > 0 Then
			//This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (OBSERV_FRN) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "OBSERV_FRN", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	If IsNull ( sVal ) Then sVal = "" 
	
	idwFicFourn.SetItem ( lCpt, "OBSERV_FRN", sVal ) 
	
	/*------------------------------------------------------------------*/
	/* #1																					  */
	/*------------------------------------------------------------------*/
	/* ZONE 1 BIS : ID_REF_FOUR													  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur est vide." )
	ElseIf sIdRefFourPrec <> "" And sVal = sIdRefFourPrec Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sVal + " n'est pas unique." )
		
	End If

	sIdRefFourPrec = sVal

Next

If iRet < 0 Then This.uf_Trace ( "ECR", "ERREUR : Le fichier fournisseur n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$.")

Return iRet


end function

private function integer uf_integration_fichier_srr (ref long alnblig, ref long alnbinsert, ref long alnbdelete);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_int_fic_article::uf_Integration_Fichier_SRR (PRIVATE)
//* Auteur			: FPI
//* Date				: 11/02/2014
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Int$$HEX1$$e900$$ENDHEX$$gration du fichier SRR dans la base
//* Commentaires	: [PC925]
//*
//* Arguments		: Long		alNbLig		Ref
//*					  Long		alNbInsert	Ref
//*					  Long		alNbDelete	Ref
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Int iRet
Long	lTotLigFourn, lRow, lCount, lCpt, lTotLigArticle, lQtDisp
String	sIdFour, sIdRefFour, sIdTypArt, sIdMarqArt, sIdModlArt, sUntMonnaie, sNull, sIdMqIfr, sIdModlIfr, sIdTypArtRef , sMtHT
Decimal {2}	dcTvaParDefaut
Boolean bBaseEuro, bInsert
Decimal {2} dcPrixHt
DateTime dt
n_cst_string nvString
String sIdMarqArtIFr, sIdModlArtIFr

iRet = 1
alNbInsert = 0
alNbDelete = 0
SetNull ( sNull )

// [DT_60_AUGM_TVA] 1.196
// Vu avec St$$HEX1$$e900$$ENDHEX$$phanie Vabre le 11/02/2014, prix TTC dans le fichier
dcTvaParDefaut=0

dt = DateTime ( Today (), Now () )

/*------------------------------------------------------------------*/
/* Article de R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour le filtre sur l'existant en base       */
/*------------------------------------------------------------------*/
sIdTypArtRef = Upper ( Trim ( idwFicFourn.GetItemString ( 1, "ID_TYP_ART"  ) ) )

idwArticle.Reset ()

/*------------------------------------------------------------------*/
/* Chargement de la table actuelle                                  */
/*------------------------------------------------------------------*/
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
idwArticle.Retrieve ( sIdFour, "*" )
/*idwArticle.SetFilter ( "ID_TYP_ART = '" + sIdTypArtRef + "'" )
idwArticle.Filter ()
*/
/*------------------------------------------------------------------*/
/* Nbre de ligne dans le fichier                                    */
/*------------------------------------------------------------------*/
lTotLigFourn = idwFicFourn.RowCount ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table                                      */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Initilisation de la trace d'int$$HEX1$$e900$$ENDHEX$$gration.                         */
/*------------------------------------------------------------------*/
This.uf_Trace_2 ( "INIT", 0, sIdFour, "", "", "", "" )

/*------------------------------------------------------------------*/
/* MAJ de la DW avec le fichier.                                    */
/*------------------------------------------------------------------*/
For alNbLig = 1 To lTotLigFourn

	sIdFour 	   = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_REF_FOUR" ) ) )
	dcPrixHt    = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_HT" )
	lQtDisp		= idwFicFourn.GetItemNumber ( alNbLig, "QT_DISP" )
	
	// Ajustement du mod$$HEX1$$e800$$ENDHEX$$le
	If Pos(sIdModlArt,sIdMarqArt) = 1 Then
		sIdModlArt=Mid(sIdModlArt,Len(sIdMarqArt)+1)
		sIdModlArt=nvString.of_globalreplace( sIdModlArt , "(", "")
		sIdModlArt=nvString.of_globalreplace( sIdModlArt , ")", "")
		sIdModlArt=Trim(sIdModlArt)
		
		idwFicFourn.SetItem( alNbLig, "ID_MODL_ART", sIdModlArt) 
	End if
	
	lRow = idwArticle.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwArticle.RowCount () )

	If lRow <= 0 Then 
		bInsert = True
		lRow = idwArticle.InsertRow ( 0 )
		alNbInsert ++
		idwArticle.SetItem ( lRow, "ID_FOUR", 	 sIdFour	  )				
		idwArticle.SetItem ( lRow, "ID_REF_FOUR",  sIdRefFour  )				
		idwArticle.SetItem ( lRow, "ID_TYP_ART",	 sIdTypArt	  )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART",	 sIdMarqArt	  )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART",	 sIdModlArt	  )				
		idwArticle.SetItem ( lRow, "ALT_DISPO",	 "N"	 )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "TVA", dcTvaParDefaut )		
		idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								
		idwArticle.SetItem ( lRow, "QT_DISP", lQtDisp )
		idwArticle.SetItem ( lRow, "CREE_LE", dt )	
		idwArticle.SetItem ( lRow, "OBSERV_FRN", Upper ( idwFicFourn.GetItemString ( alNbLig, "OBSERV_FRN" ) ))
	Else
		bInsert = False
	End If

	If lRow > 0 Then 

		idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								


		/*------------------------------------------------------------------*/
		/* Code $$HEX1$$e900$$ENDHEX$$tat (-EI)                                                  */
		/* 200 Nouveau                                                      */
		/* 100 MAj_Ok sur existant                                          */
		/*------------------------------------------------------------------*/
		If bInsert Then
			idwArticle.SetItem ( lRow, "COD_ETAT", 200 )		
			This.uf_Trace_2 ( "ECR_AUTO", 200, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		Else
			idwArticle.SetItem ( lRow, "COD_ETAT", 100 )		

			sIdMqIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MARQ_ART_IFR" ) )
			sIdModlIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MODL_ART_IFR" ) )

			/*------------------------------------------------------------------*/
			/* Si les marques et mod$$HEX1$$e800$$ENDHEX$$les IFR sont absent de l'enregistrement    */
			/* exisant, on force ALT_DIPSPO $$HEX2$$e0002000$$ENDHEX$$NON.                              */
			/*------------------------------------------------------------------*/
			If Isnull ( sIdMqIfr ) Or sIdMqIfr = "" Or Isnull ( sIdModlIfr ) Or sIdModlIfr = "" Then
				idwArticle.SetItem ( lRow, "ALT_DISPO", "N" )				
			End If

			This.uf_Trace_2 ( "ECR_AUTO", 100, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		End If

		idwArticle.SetItem ( lRow, "QT_DISP", idwFicFourn.GetItemNumber ( alNbLig, "QT_DISP" ) )
		idwArticle.SetItem ( lRow, "OBSERV_FRN", Upper ( idwFicFourn.GetItemString ( alNbLig, "OBSERV_FRN" ) ) )
		idwArticle.SetItem ( lRow, "VERROU", 1 )
		idwArticle.SetItem ( lRow, "MAJ_LE", dt )		
		idwArticle.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )		

		// [VDOC6993]
		Choose Case sIdTypArt 
				Case "TEL", "PC1", "PC2" 
					// Doit $$HEX1$$ea00$$ENDHEX$$tre mis $$HEX2$$e0002000$$ENDHEX$$la main pas Cell. Parte.
					// [VDOC6993]
					If bInsert Then
						sIdMarqArtIFr = Space (35) 
						sIdModlArtIFr = Space (35) 
						SQLCA.PS_S_VDOC6993_LIEN_ARTICLE ( sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, sIdMarqArtIFr, sIdModlArtIFr ) 
						If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) Then
							idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR", sIdMarqArtIFr )				
						End If
						
						If Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
							idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR", sIdModlArtIFr )				
						End If
						
						If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) And &
							Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
							idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
						End If
					End If
				Case Else
					idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
			End Choose
			// :[VDOC6993]			
	End If

Next

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table (r$$HEX1$$e900$$ENDHEX$$actualis$$HEX1$$e900$$ENDHEX$$)                        */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Suppression des lignes pr$$HEX1$$e900$$ENDHEX$$sentes dans la table articles et       */
/* absentes du fichier.                                             */
/*------------------------------------------------------------------*/
For lCpt = lTotLigArticle To 1 Step -1

	sIdFour 	   = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	lRow = idwFicFourn.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwFicFourn.RowCount () )

	If lRow <= 0 Then 
		alNbDelete ++
		idwArticle.DeleteRow ( lCpt )
		This.uf_Trace_2 ( "ECR_AUTO", 300, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
	End If

Next 

idwArticle.SetFilter ( "" )
idwArticle.Filter ()

return iRet 
end function

public function string uf_detection_auto_nomfic (string aidfourn, string ascas);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Detection_Auto_nomFic (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 30/08/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: D$$HEX1$$e900$$ENDHEX$$tection automatique du nom de fichier
//* Commentaires	: 
//*
//* Arguments		: aIdFourn		String		Val
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    30/08/2002  Le nom du r$$HEX1$$e900$$ENDHEX$$pertoire de g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration n'est plus le code
//*								  du fournisseur -FR mais le nom complet (<8 car) -FL
//* 		FPI	  31/10/2012	[PC767] Ajout des .csv
//*      JFF     24/03/2016  [VDOC20359]
//*-----------------------------------------------------------------

String	sRepFicArt, sNomFicArt, sFichier, sInd, sItem, sJoker, sRepFourn, sCas, sVar
Long		lInd, lRow, lTotLig, lCpt, lCptCas
Boolean  bFicTrouve

sCas=""
/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
lRow = idwStkRepFourn.Find ( "ID_CODE = '" + aIdFourn + "'", 1, idwStkRepFourn.RowCount () )

If lRow > 0 Then
	sRepFourn = Upper ( idwStkRepFourn.GetItemString ( lRow, "LIB_CODE" ) )
Else
	Return ""
End If

sRepFicArt =  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_GEN", "" ) + &
				  sRepFourn + &
				  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_FIC_ART", "" )

// [PC767]
For lCptCas = 1 TO 2

// Ordre extr$$HEX1$$ea00$$ENDHEX$$mement important !
	CHOOSE CASE lCptCas
		CASE 1
			sVar = K_FIC
			sNomFicArt = sVar + "*.0*"			
			sCas = ""
			
		CASE 2
			sNomFicArt = "*.csv"
			sCas = "CSV"

			// [PM289_CDP]
			If asCas = "CAS_CDP" Then
				sCas = asCas 
			End If
			
	
	END CHOOSE

	sJoker = sRepFicArt + sNomFicArt
	ilbListeFic.DirList ( sJoker, 0 )
	
	lTotLig = ilbListeFic.TotalItems ()
	If lTotLig > 0 Then Exit
Next
// :[PC767]

idwTri.Reset ()

For lCpt = lTotLig To 1 Step -1
	
	ilbListeFic.SelectItem ( lCpt )
	sItem = ilbListeFic.SelectedItem ( )
	lRow = idwTri.InsertRow ( 0 )	
	
	Choose Case sCas
		// [PM289_CDP]
		Case "CAS_CDP"
			// [VDOC20359]
			// Je prends les 50 premiers, $$HEX2$$e0002000$$ENDHEX$$savoir : toutes les chaine 
			idwTri.SetItem ( lRow, "TYPE_FIC", Upper ( Left ( sItem, 50 ) ) )
			
		Case "CSV"
			idwTri.SetItem ( lRow, "TYPE_FIC", Upper ( Right  ( sItem, 4 ) ) )
			idwTri.SetItem ( lRow, "EXTENTION",   Right  ( sItem, 4 ) ) 
			
			sItem=Left(sItem,Len(sItem) - 4)
			idwTri.SetItem ( lRow, "JOUR",     Mid  ( sItem, 1, 20) ) 
			idwTri.SetItem ( lRow, "MOIS",     Mid  ( sItem, 21, 20 ) ) 
			idwTri.SetItem ( lRow, "ANNEE",    Mid  ( sItem, 41, 20 ) ) 
			
		Case Else
			idwTri.SetItem ( lRow, "TYPE_FIC", Upper ( Left ( sItem, 3 ) ) )
			idwTri.SetItem ( lRow, "JOUR",     Mid  ( sItem, 4, 2 ) ) 
			idwTri.SetItem ( lRow, "MOIS",     Mid  ( sItem, 6, 2 ) ) 
			idwTri.SetItem ( lRow, "ANNEE",    Mid  ( sItem, 8, 1 ) ) 
			idwTri.SetItem ( lRow, "EXTENTION",   Right  ( sItem, 4 ) ) 
		
			ilbListeFic.DeleteItem ( lCpt )
	End Choose
Next

idwTri.Sort ()

If idwTri.Rowcount () > 0 Then 
	Choose Case sCas
		// [PM289_CDP]
		Case "CAS_CDP"
			// [VDOC20359]
			sFichier = idwTri.GetItemString ( 1, "TYPE_FIC" )
			
		Case "CSV"
			sFichier = idwTri.GetItemString ( 1, "JOUR" )	  + &
						  idwTri.GetItemString ( 1, "MOIS" )	  + &
						  idwTri.GetItemString ( 1, "ANNEE" )	  + &
						  idwTri.GetItemString ( 1, "EXTENTION" )
		Case Else
			sFichier = idwTri.GetItemString ( 1, "TYPE_FIC" ) + &
						  idwTri.GetItemString ( 1, "JOUR" )	  + &
						  idwTri.GetItemString ( 1, "MOIS" )	  + &
						  idwTri.GetItemString ( 1, "ANNEE" )	  + &
						  idwTri.GetItemString ( 1, "EXTENTION" )
	End Choose
	sFichier = sRepFicArt + sFichier

Else
	sFichier = ""
End If

isTxtNomFic.Text = sFichier

Return sFichier
end function

private function integer uf_transformationseparateur (string asfichiersource, string asseporig, string assepsubst, string ascas);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_int_fic_article::uf_TransformationSeparateur (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 18/09/2008 13:46:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 	value string asFichierSource
//* 						value string asSepOrig
//* 						value string asSepSubst
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//        JFF   02/03/2015   [PM289_CDP]
//*-----------------------------------------------------------------

Int iiFicSource, iiFicDest
Long lNbre
String sNomFicTmp, schaine
Blob blBlob

sNomFicTmp = stGLB.sRepTempo + K_FICTMP2
asSepOrig = Trim ( asSepOrig )
asSepSubst = Trim ( asSepSubst )

iiFicSource = FileOpen ( asFichierSource, LineMode!, Read!, LockRead!, Append! )

If FileExists ( sNomFicTmp ) Then
	If Not FileDelete ( sNomFicTmp ) Then Return -1
End If
iiFicDest  = FileOpen ( sNomFicTmp, LineMode!, Write!, LockWrite!, Replace! )

If iiFicSource < 0 Or iiFicDest < 0 Then return -1

lNbre	= 0

Do While ( FileRead ( iiFicSource, schaine)  > 0 )
	
	lNbre ++

	If asCas = "CAS_CDP" And lNbre = 1 Then
		// On passe la ligne d'entete
		Continue
	End If 

	sChaine = F_Remplace ( sChaine, asSepOrig, asSepSubst )
	If FileWrite ( iiFicDest, schaine ) < 0 Then
			Return -1
	End If
	
Loop

If Fileclose ( iiFicDest ) < 0 Then Return -1
If Fileclose ( iiFicSource ) < 0 Then Return -1

If Not FileDelete ( asFichierSource ) Then Return -1

F_LireFichierBlob ( blBlob, sNomFicTmp ) 
F_EcrireFichierBlob ( blBlob, asFichierSource ) 

If Not FileDelete ( sNomFicTmp ) Then Return -1


Return 1




end function

private function integer uf_ctrl_fichier_pp_orange ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Ctrl_Fichier_PP_Orange (PRIVATE)
//* Auteur			: JFF
//* Date				: 28/09/2015
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PM319-1]
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Int iRet 
String	sIdFour, sVal, sCar, sSort, sIdRefFourPrec, sTypArtSav
Long		lTotLig, lCpt, lCptVal, lTotArt, lLen
Boolean	bTrouve

iRet = 1

lTotLig = idwFicFourn.RowCount ()
lTotArt = idwArtSpb.RowCount ()
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sTypArtSav = ""

// JFF 20/01/2011 : le tri imp$$HEX1$$e900$$ENDHEX$$ratif sur ID_REF_FOUR $$HEX1$$e900$$ENDHEX$$tait visiblement manquant (?..)
idwFicFourn.SetSort ( "ID_REF_FOUR A" )
idwFicFourn.Sort ()

sIdRefFourPrec = ""

For lCpt = 1 To lTotLig 

	/*------------------------------------------------------------------*/
	/* ZONE 1 : ID_FOUR                                                */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone fournisseur est vide." )
	End If 

	If sVal <> sIdFour Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fournisseur " + sVal + " ne correspond pas au fournisseur s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$" + sIdFour )
	End If 

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La longueur du fournisseur doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If
	
	/*------------------------------------------------------------------*/
	/* ZONE 2 : ID_TYP_ART                                              */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_TYP_ART" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Type Article est vide." )
	End If 

	// Le fichier ne doit que contenir que des appareils du m$$HEX1$$ea00$$ENDHEX$$me type
	// #2 [DCMP090615]
	/*
	If sTypArtSav <> sVal And sTypArtSav <> "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fichier contient des types d'appareils diff$$HEX1$$e900$$ENDHEX$$rents !" )
	End If
	*/
	// :#2 [DCMP090615]

	If Not IsNull ( sVal ) And sVal <> "" Then
	  sTypArtSav = sVal
	End If

	bTrouve = False
	lCptVal = 1
	Do While Not bTrouve And lCptVal <= lTotArt
		bTrouve = sVal = Upper ( idwArtSpb.GetItemString ( lCptVal, "ID_CODE" ) )
		lCptVal ++
	Loop

	If Not bTrouve Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type d'article " + sVal + " n'existe pas dans la base SIMPA2.")
	End If

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type de l'article doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If		

	/*------------------------------------------------------------------*/
	/* ZONE 3 : ID_MARQ_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MARQ_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Marque Article est vide." )
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 4 : ID_MODL_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MODL_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone mod$$HEX1$$e800$$ENDHEX$$le article est vide." )
	Else

		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (ID_MODL_ART) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "ID_MODL_ART", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 5 : MT_PRIX_HT															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemDecimal ( lCpt, "MT_PRIX_HT" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Prix Hors Taxe est vide." )
	End If 

	lLen = Len ( sVal )
	
	// Marque la virgule
	bTrouve = False

	For lCptVal = 1 To lLen 
		sCar = Mid ( sVal, lCptVal, 1 )
		If sCar = "." Then
			If Not bTrouve Then 
				bTrouve = True
			Else
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, il y a deux virgules." )
				Exit
			End If

		Else
			If Not ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) Then
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, un caract$$HEX1$$e800$$ENDHEX$$re n'est pas un chiffre." )
				Exit
			End If
		End If
	Next	

	If Real ( sVal ) > 5000 Then		
		This.uf_Trace ( "ECR", "AVERTISSEMENT ligne " + String ( lCpt ) + &
		" : Le montant " + sVal + " para$$HEX1$$ee00$$ENDHEX$$t anormalement grand." )
	End If

	
	/*------------------------------------------------------------------*/
	/* ZONE 6 : UNT_MONNAIE															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "UNT_MONNAIE" ) ) )
	// [SUISSE].LOT3 Controle de la monnaie du fichier
	// Si pas de coh$$HEX1$$e900$$ENDHEX$$rence : erreur bloquante d'int$$HEX1$$e900$$ENDHEX$$gration.
	if uf_controler_monnaie_fichier (sVal, lCpt) < 0 Then iRet = -1
	
	/*------------------------------------------------------------------*/
	/* ZONE 8 : OBSERV_FRN 															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )

	If Not IsNull ( sVal ) And sVal <> "" Then
		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (OBSERV_FRN) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "OBSERV_FRN", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 
	
	/*------------------------------------------------------------------*/
	/* ZONE 1 BIS : ID_REF_FOUR													  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur est vide." )
	ElseIf sIdRefFourPrec <> "" And sVal = sIdRefFourPrec Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sVal + " n'est pas unique." )
		
	End If

	sIdRefFourPrec = sVal

Next

If iRet < 0 Then This.uf_Trace ( "ECR", "ERREUR : Le fichier fournisseur n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$.")

Return iRet


end function

private function integer uf_integration_fichier_pp_orange (ref long alnblig, ref long alnbinsert, ref long alnbdelete);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Integration_Fichier_PP_Orange (PRIVATE)
//* Auteur			: JFF
//* Date				: 28/09/2015
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Int$$HEX1$$e900$$ENDHEX$$gration du fichier de prix public Orange dans la base
//* Commentaires	: //[PM319-1]
//*
//* Arguments		: Long		alNbLig		Ref
//*					  Long		alNbInsert	Ref
//*					  Long		alNbDelete	Ref
//*					  String 	asCas			Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1    JFF    10/03/2008  Modif suite Bug [SUISSE].LOT3
//* #2    JFF    19/10/2009  [DCMP090615]
//*       JFF    01/02/2012  [VDOC6846]
//        JFF    19/11/2013  [DT_60_AUGM_TVA]
//*-----------------------------------------------------------------

Int iRet
Long	lTotLigFourn, lRow, lCount, lCpt, lTotLigArticle, lQtDisp
String	sIdFour, sIdRefFour, sIdTypArt, sIdMarqArt, sIdModlArt, sUntMonnaie, sNull, sIdMqIfr, sIdModlIfr, sIdTypArtRef , sMtHT
Decimal {2}	dcTvaParDefaut
Boolean bBaseEuro, bInsert
Decimal {2} dcPrixHt
DateTime dt
n_cst_string nvString
String sIdMarqArtIFr
String sIdModlArtIFr

iRet = 1
alNbInsert = 0
alNbDelete = 0
SetNull ( sNull )

// [DT_60_AUGM_TVA] 1.196
// Vu avec Marion le 26/11/2014, prix TTC dans le fichier
// dcTvaParDefaut=20
dcTvaParDefaut = 0

dt = DateTime ( Today (), Now () )

/*------------------------------------------------------------------*/
/* Article de R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour le filtre sur l'existant en base       */
/*------------------------------------------------------------------*/
sIdTypArtRef = Upper ( Trim ( idwFicFourn.GetItemString ( 1, "ID_TYP_ART"  ) ) )

idwArticle.Reset ()

/*------------------------------------------------------------------*/
/* Chargement de la table actuelle                                  */
/*------------------------------------------------------------------*/
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
idwArticle.Retrieve ( sIdFour, "*" )
/*idwArticle.SetFilter ( "ID_TYP_ART = '" + sIdTypArtRef + "'" )
idwArticle.Filter ()
*/
/*------------------------------------------------------------------*/
/* Nbre de ligne dans le fichier                                    */
/*------------------------------------------------------------------*/
lTotLigFourn = idwFicFourn.RowCount ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table                                      */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Initilisation de la trace d'int$$HEX1$$e900$$ENDHEX$$gration.                         */
/*------------------------------------------------------------------*/
This.uf_Trace_2 ( "INIT", 0, sIdFour, "", "", "", "" )

/*------------------------------------------------------------------*/
/* MAJ de la DW avec le fichier.                                    */
/*------------------------------------------------------------------*/
For alNbLig = 1 To lTotLigFourn

	sIdFour 	   = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_REF_FOUR" ) ) )
	dcPrixHt    = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_HT" )
	lQtDisp		= 1
	
	// Ajustement du mod$$HEX1$$e800$$ENDHEX$$le
	If Pos(sIdModlArt,sIdMarqArt) = 1 Then
		sIdModlArt=Mid(sIdModlArt,Len(sIdMarqArt)+1)
		sIdModlArt=nvString.of_globalreplace( sIdModlArt , "(", "")
		sIdModlArt=nvString.of_globalreplace( sIdModlArt , ")", "")
		sIdModlArt=Trim(sIdModlArt)
		
		idwFicFourn.SetItem( alNbLig, "ID_MODL_ART", sIdModlArt) 
	End if
	
//	 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
// Je supprime l'ID_REF_FOUR car le fichier original n'en a pas et c'est un num$$HEX1$$e900$$ENDHEX$$ro bidon g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX2$$e9002000$$ENDHEX$$par l'ETL mais pas forc$$HEX1$$e900$$ENDHEX$$ment 
// sur le m$$HEX1$$ea00$$ENDHEX$$me tel.
	lRow = idwArticle.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwArticle.RowCount () )

	If lRow <= 0 Then 
		bInsert = True
		lRow = idwArticle.InsertRow ( 0 )
		alNbInsert ++
		idwArticle.SetItem ( lRow, "ID_FOUR", 	 sIdFour	  )				
		idwArticle.SetItem ( lRow, "ID_REF_FOUR",  sIdRefFour  )				
		idwArticle.SetItem ( lRow, "ID_TYP_ART",	 sIdTypArt	  )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART",	 sIdMarqArt	  )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART",	 sIdModlArt	  )				
		idwArticle.SetItem ( lRow, "ALT_DISPO",	 "N"	 )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "TVA", dcTvaParDefaut )		
		idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								
		idwArticle.SetItem ( lRow, "QT_DISP", lQtDisp )
		idwArticle.SetItem ( lRow, "CREE_LE", dt )	
		idwArticle.SetItem ( lRow, "OBSERV_FRN", Left ( "PRIX TTC !!!." + Upper ( idwFicFourn.GetItemString ( alNbLig, "OBSERV_FRN" )), 35 ))
	Else
		bInsert = False
	End If

	If lRow > 0 Then 

		idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								


		/*------------------------------------------------------------------*/
		/* Code $$HEX1$$e900$$ENDHEX$$tat (-EI)                                                  */
		/* 200 Nouveau                                                      */
		/* 100 MAj_Ok sur existant                                          */
		/*------------------------------------------------------------------*/
		If bInsert Then
			idwArticle.SetItem ( lRow, "COD_ETAT", 200 )		
			This.uf_Trace_2 ( "ECR_AUTO", 200, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		Else
			idwArticle.SetItem ( lRow, "COD_ETAT", 100 )		

			sIdMqIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MARQ_ART_IFR" ) )
			sIdModlIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MODL_ART_IFR" ) )

			/*------------------------------------------------------------------*/
			/* Si les marques et mod$$HEX1$$e800$$ENDHEX$$les IFR sont absent de l'enregistrement    */
			/* exisant, on force ALT_DIPSPO $$HEX2$$e0002000$$ENDHEX$$NON.                              */
			/*------------------------------------------------------------------*/
			If Isnull ( sIdMqIfr ) Or sIdMqIfr = "" Or Isnull ( sIdModlIfr ) Or sIdModlIfr = "" Then
				idwArticle.SetItem ( lRow, "ALT_DISPO", "N" )				
			End If

			This.uf_Trace_2 ( "ECR_AUTO", 100, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		End If

		// [VDOC6846]
		Choose Case sIdTypArt 
			Case "TEL"
				// Doit $$HEX1$$ea00$$ENDHEX$$tre mis $$HEX2$$e0002000$$ENDHEX$$la main pas Cell. Parte.
				// [VDOC6993]
				If bInsert Then
					sIdMarqArtIFr = Space (35) 
					sIdModlArtIFr = Space (35) 
					SQLCA.PS_S_VDOC6993_LIEN_ARTICLE ( sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, sIdMarqArtIFr, sIdModlArtIFr ) 
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR", sIdMarqArtIFr )				
					End If
					
					If Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR", sIdModlArtIFr )				
					End If
					
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) And &
						Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
					End If
				End If					
			Case Else
				idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
		End Choose
		// :[VDOC6846]

		idwArticle.SetItem ( lRow, "QT_DISP", 1 ) // On n'a pas besoin de quantit$$HEX1$$e900$$ENDHEX$$.
		idwArticle.SetItem ( lRow, "OBSERV_FRN", Upper ( idwFicFourn.GetItemString ( alNbLig, "OBSERV_FRN" ) ) )
		idwArticle.SetItem ( lRow, "VERROU", 1 )
		idwArticle.SetItem ( lRow, "MAJ_LE", dt )		
		idwArticle.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )		
	
	End If

Next

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table (r$$HEX1$$e900$$ENDHEX$$actualis$$HEX1$$e900$$ENDHEX$$)                        */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Suppression des lignes pr$$HEX1$$e900$$ENDHEX$$sentes dans la table articles et       */
/* absentes du fichier.                                             */
/*------------------------------------------------------------------*/
For lCpt = lTotLigArticle To 1 Step -1

	sIdFour 	   = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	lRow = idwFicFourn.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwFicFourn.RowCount () )

	If lRow <= 0 Then 
		alNbDelete ++
		idwArticle.DeleteRow ( lCpt )
		This.uf_Trace_2 ( "ECR_AUTO", 300, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
	End If

Next 

idwArticle.SetFilter ( "" )
idwArticle.Filter ()

return iRet 
end function

private function integer uf_ctrl_fichier_pp_bouygues ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Ctrl_Fichier_PP_Orange (PRIVATE)
//* Auteur			: JFF
//* Date				: 28/09/2015
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [PM319-2]
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Int iRet 
String	sIdFour, sVal, sCar, sSort, sIdRefFourPrec, sTypArtSav
Long		lTotLig, lCpt, lCptVal, lTotArt, lLen
Boolean	bTrouve

iRet = 1

lTotLig = idwFicFourn.RowCount ()
lTotArt = idwArtSpb.RowCount ()
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sTypArtSav = ""

// JFF 20/01/2011 : le tri imp$$HEX1$$e900$$ENDHEX$$ratif sur ID_REF_FOUR $$HEX1$$e900$$ENDHEX$$tait visiblement manquant (?..)
idwFicFourn.SetSort ( "ID_REF_FOUR A" )
idwFicFourn.Sort ()

sIdRefFourPrec = ""

For lCpt = 1 To lTotLig 

	/*------------------------------------------------------------------*/
	/* ZONE 1 : ID_FOUR                                                */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone fournisseur est vide." )
	End If 

	If sVal <> sIdFour Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fournisseur " + sVal + " ne correspond pas au fournisseur s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$" + sIdFour )
	End If 

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La longueur du fournisseur doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If
	
	/*------------------------------------------------------------------*/
	/* ZONE 2 : ID_TYP_ART                                              */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_TYP_ART" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Type Article est vide." )
	End If 

	// Le fichier ne doit que contenir que des appareils du m$$HEX1$$ea00$$ENDHEX$$me type
	// #2 [DCMP090615]
	/*
	If sTypArtSav <> sVal And sTypArtSav <> "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fichier contient des types d'appareils diff$$HEX1$$e900$$ENDHEX$$rents !" )
	End If
	*/
	// :#2 [DCMP090615]

	If Not IsNull ( sVal ) And sVal <> "" Then
	  sTypArtSav = sVal
	End If

	bTrouve = False
	lCptVal = 1
	Do While Not bTrouve And lCptVal <= lTotArt
		bTrouve = sVal = Upper ( idwArtSpb.GetItemString ( lCptVal, "ID_CODE" ) )
		lCptVal ++
	Loop

	If Not bTrouve Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type d'article " + sVal + " n'existe pas dans la base SIMPA2.")
	End If

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type de l'article doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If		

	/*------------------------------------------------------------------*/
	/* ZONE 3 : ID_MARQ_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MARQ_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Marque Article est vide." )
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 4 : ID_MODL_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MODL_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone mod$$HEX1$$e800$$ENDHEX$$le article est vide." )
	Else

		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (ID_MODL_ART) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "ID_MODL_ART", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 5 : MT_PRIX_HT															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemDecimal ( lCpt, "MT_PRIX_HT" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Prix Hors Taxe est vide." )
	End If 

	lLen = Len ( sVal )
	
	// Marque la virgule
	bTrouve = False

	For lCptVal = 1 To lLen 
		sCar = Mid ( sVal, lCptVal, 1 )
		If sCar = "." Then
			If Not bTrouve Then 
				bTrouve = True
			Else
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, il y a deux virgules." )
				Exit
			End If

		Else
			If Not ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) Then
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, un caract$$HEX1$$e800$$ENDHEX$$re n'est pas un chiffre." )
				Exit
			End If
		End If
	Next	

	If Real ( sVal ) > 5000 Then		
		This.uf_Trace ( "ECR", "AVERTISSEMENT ligne " + String ( lCpt ) + &
		" : Le montant " + sVal + " para$$HEX1$$ee00$$ENDHEX$$t anormalement grand." )
	End If

	
	/*------------------------------------------------------------------*/
	/* ZONE 6 : UNT_MONNAIE															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "UNT_MONNAIE" ) ) )
	// [SUISSE].LOT3 Controle de la monnaie du fichier
	// Si pas de coh$$HEX1$$e900$$ENDHEX$$rence : erreur bloquante d'int$$HEX1$$e900$$ENDHEX$$gration.
	if uf_controler_monnaie_fichier (sVal, lCpt) < 0 Then iRet = -1
	
	/*------------------------------------------------------------------*/
	/* ZONE 8 : OBSERV_FRN 															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )

	If Not IsNull ( sVal ) And sVal <> "" Then
		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (OBSERV_FRN) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "OBSERV_FRN", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 
	
	/*------------------------------------------------------------------*/
	/* ZONE 1 BIS : ID_REF_FOUR													  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur est vide." )
	ElseIf sIdRefFourPrec <> "" And sVal = sIdRefFourPrec Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sVal + " n'est pas unique." )
		
	End If

	sIdRefFourPrec = sVal

Next

If iRet < 0 Then This.uf_Trace ( "ECR", "ERREUR : Le fichier fournisseur n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$.")

Return iRet


end function

private function integer uf_integration_fichier_pp_bouygues (ref long alnblig, ref long alnbinsert, ref long alnbdelete);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Integration_Fichier_PP_Bouygues (PRIVATE)
//* Auteur			: JFF
//* Date				: 28/09/2015
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Int$$HEX1$$e900$$ENDHEX$$gration du fichier de prix public Orange dans la base
//* Commentaires	: //[PM319-2]
//*
//* Arguments		: Long		alNbLig		Ref
//*					  Long		alNbInsert	Ref
//*					  Long		alNbDelete	Ref
//*					  String 	asCas			Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1    JFF    10/03/2008  Modif suite Bug [SUISSE].LOT3
//* #2    JFF    19/10/2009  [DCMP090615]
//*       JFF    01/02/2012  [VDOC6846]
//        JFF    19/11/2013  [DT_60_AUGM_TVA]
//*-----------------------------------------------------------------

Int iRet
Long	lTotLigFourn, lRow, lCount, lCpt, lTotLigArticle, lQtDisp
String	sIdFour, sIdRefFour, sIdTypArt, sIdMarqArt, sIdModlArt, sUntMonnaie, sNull, sIdMqIfr, sIdModlIfr, sIdTypArtRef , sMtHT
Decimal {2}	dcTvaParDefaut
Boolean bBaseEuro, bInsert
Decimal {2} dcPrixHt
DateTime dt
n_cst_string nvString
String sIdMarqArtIFr, sIdModlArtIFr

iRet = 1
alNbInsert = 0
alNbDelete = 0
SetNull ( sNull )

// [DT_60_AUGM_TVA] 1.196
// Marion le 18/12/15 : Renseignements pris, les tarifs communiqu$$HEX1$$e900$$ENDHEX$$s par Bouygues sont TTC.
// dcTvaParDefaut=20
dcTvaParDefaut=0

dt = DateTime ( Today (), Now () )

/*------------------------------------------------------------------*/
/* Article de R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour le filtre sur l'existant en base       */
/*------------------------------------------------------------------*/
sIdTypArtRef = Upper ( Trim ( idwFicFourn.GetItemString ( 1, "ID_TYP_ART"  ) ) )

idwArticle.Reset ()

/*------------------------------------------------------------------*/
/* Chargement de la table actuelle                                  */
/*------------------------------------------------------------------*/
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
idwArticle.Retrieve ( sIdFour, "*" )
/*idwArticle.SetFilter ( "ID_TYP_ART = '" + sIdTypArtRef + "'" )
idwArticle.Filter ()
*/
/*------------------------------------------------------------------*/
/* Nbre de ligne dans le fichier                                    */
/*------------------------------------------------------------------*/
lTotLigFourn = idwFicFourn.RowCount ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table                                      */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Initilisation de la trace d'int$$HEX1$$e900$$ENDHEX$$gration.                         */
/*------------------------------------------------------------------*/
This.uf_Trace_2 ( "INIT", 0, sIdFour, "", "", "", "" )

/*------------------------------------------------------------------*/
/* MAJ de la DW avec le fichier.                                    */
/*------------------------------------------------------------------*/
For alNbLig = 1 To lTotLigFourn

	sIdFour 	   = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_REF_FOUR" ) ) )
	dcPrixHt    = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_HT" )
	lQtDisp		= 1
	
	// Ajustement du mod$$HEX1$$e800$$ENDHEX$$le
	If Pos(sIdModlArt,sIdMarqArt) = 1 Then
		sIdModlArt=Mid(sIdModlArt,Len(sIdMarqArt)+1)
		sIdModlArt=nvString.of_globalreplace( sIdModlArt , "(", "")
		sIdModlArt=nvString.of_globalreplace( sIdModlArt , ")", "")
		sIdModlArt=Trim(sIdModlArt)
		
		idwFicFourn.SetItem( alNbLig, "ID_MODL_ART", sIdModlArt) 
	End if
	
	lRow = idwArticle.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwArticle.RowCount () )

	If lRow <= 0 Then 
		bInsert = True
		lRow = idwArticle.InsertRow ( 0 )
		alNbInsert ++
		idwArticle.SetItem ( lRow, "ID_FOUR", 	 sIdFour	  )				
		idwArticle.SetItem ( lRow, "ID_REF_FOUR",  sIdRefFour  )				
		idwArticle.SetItem ( lRow, "ID_TYP_ART",	 sIdTypArt	  )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART",	 sIdMarqArt	  )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART",	 sIdModlArt	  )				
		idwArticle.SetItem ( lRow, "ALT_DISPO",	 "N"	 )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "TVA", dcTvaParDefaut )		
		idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								
		idwArticle.SetItem ( lRow, "QT_DISP", lQtDisp )
		idwArticle.SetItem ( lRow, "CREE_LE", dt )	
		idwArticle.SetItem ( lRow, "OBSERV_FRN", Left ( "PRIX TTC !!!." + Upper ( idwFicFourn.GetItemString ( alNbLig, "OBSERV_FRN" )), 35 ))
	Else
		bInsert = False
	End If

	If lRow > 0 Then 

		idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								


		/*------------------------------------------------------------------*/
		/* Code $$HEX1$$e900$$ENDHEX$$tat (-EI)                                                  */
		/* 200 Nouveau                                                      */
		/* 100 MAj_Ok sur existant                                          */
		/*------------------------------------------------------------------*/
		If bInsert Then
			idwArticle.SetItem ( lRow, "COD_ETAT", 200 )		
			This.uf_Trace_2 ( "ECR_AUTO", 200, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		Else
			idwArticle.SetItem ( lRow, "COD_ETAT", 100 )		

			sIdMqIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MARQ_ART_IFR" ) )
			sIdModlIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MODL_ART_IFR" ) )

			/*------------------------------------------------------------------*/
			/* Si les marques et mod$$HEX1$$e800$$ENDHEX$$les IFR sont absent de l'enregistrement    */
			/* exisant, on force ALT_DIPSPO $$HEX2$$e0002000$$ENDHEX$$NON.                              */
			/*------------------------------------------------------------------*/
			If Isnull ( sIdMqIfr ) Or sIdMqIfr = "" Or Isnull ( sIdModlIfr ) Or sIdModlIfr = "" Then
				idwArticle.SetItem ( lRow, "ALT_DISPO", "N" )				
			End If

			This.uf_Trace_2 ( "ECR_AUTO", 100, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		End If

		// [VDOC6846]
		Choose Case sIdTypArt 
			Case "TEL"
				// Doit $$HEX1$$ea00$$ENDHEX$$tre mis $$HEX2$$e0002000$$ENDHEX$$la main pas Cell. Parte.
				// [VDOC6993]
				If bInsert Then
					sIdMarqArtIFr = Space (35) 
					sIdModlArtIFr = Space (35) 
					SQLCA.PS_S_VDOC6993_LIEN_ARTICLE ( sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, sIdMarqArtIFr, sIdModlArtIFr ) 
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR", sIdMarqArtIFr )				
					End If
					
					If Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR", sIdModlArtIFr )				
					End If
					
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) And &
						Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
					End If
				End If					
			Case Else
				idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
		End Choose
		// :[VDOC6846]

		idwArticle.SetItem ( lRow, "QT_DISP", 1 ) // On n'a pas besoin de quantit$$HEX1$$e900$$ENDHEX$$.
		idwArticle.SetItem ( lRow, "OBSERV_FRN", Upper ( idwFicFourn.GetItemString ( alNbLig, "OBSERV_FRN" ) ) )
		idwArticle.SetItem ( lRow, "VERROU", 1 )
		idwArticle.SetItem ( lRow, "MAJ_LE", dt )		
		idwArticle.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )		
	
	End If

Next

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table (r$$HEX1$$e900$$ENDHEX$$actualis$$HEX1$$e900$$ENDHEX$$)                        */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Suppression des lignes pr$$HEX1$$e900$$ENDHEX$$sentes dans la table articles et       */
/* absentes du fichier.                                             */
/*------------------------------------------------------------------*/
For lCpt = lTotLigArticle To 1 Step -1

	sIdFour 	   = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	lRow = idwFicFourn.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwFicFourn.RowCount () )

	If lRow <= 0 Then 
		alNbDelete ++
		idwArticle.DeleteRow ( lCpt )
		This.uf_Trace_2 ( "ECR_AUTO", 300, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
	End If

Next 

idwArticle.SetFilter ( "" )
idwArticle.Filter ()

return iRet 
end function

private function integer uf_ctrl_fichier_atech ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Ctrl_Fichier_ATECH (PRIVATE)
//* Auteur			: FPI
//* Date				: 25/11/2015
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler de la validit$$HEX2$$e9002000$$ENDHEX$$du fichier de ATECH 
//* Commentaires	: [PC13442-2]
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Int iRet 
String	sIdFour, sVal, sCar, sSort, sIdRefFourPrec, sTypArtSav
Long		lTotLig, lCpt, lCptVal, lTotArt, lLen
Boolean	bTrouve

iRet = 1

lTotLig = idwFicFourn.RowCount ()
lTotArt = idwArtSpb.RowCount ()
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sTypArtSav = ""

idwFicFourn.SetSort ( "ID_REF_FOUR A" )
idwFicFourn.Sort ()

sIdRefFourPrec = ""

For lCpt = 1 To lTotLig 

	/*------------------------------------------------------------------*/
	/* ZONE 1 : ID_FOUR                                                 */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone fournisseur est vide." )
	End If 

	If sVal <> sIdFour Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fournisseur " + sVal + " ne correspond pas au fournisseur s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$" + sIdFour )
	End If 

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La longueur du fournisseur doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If
	
	/*------------------------------------------------------------------*/
	/* ZONE 2 : ID_TYP_ART                                              */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_TYP_ART" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Type Article est vide." )
	End If 

	If Not IsNull ( sVal ) And sVal <> "" Then
	  sTypArtSav = sVal
	End If

	bTrouve = False
	lCptVal = 1
	Do While Not bTrouve And lCptVal <= lTotArt
		bTrouve = sVal = Upper ( idwArtSpb.GetItemString ( lCptVal, "ID_CODE" ) )
		lCptVal ++
	Loop

	If Not bTrouve Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type d'article " + sVal + " n'existe pas dans la base SIMPA2.")
	End If

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type de l'article doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If		

	/*------------------------------------------------------------------*/
	/* ZONE 3 : ID_MARQ_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MARQ_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Marque Article est vide." )
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 4 : ID_MODL_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MODL_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone mod$$HEX1$$e800$$ENDHEX$$le article est vide." )
	Else

		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (ID_MODL_ART) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "ID_MODL_ART", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 5 : MT_PRIX_HT															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemDecimal ( lCpt, "MT_PRIX_HT" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Prix Hors Taxe est vide." )
	End If 

	lLen = Len ( sVal )
	
	// Marque la virgule
	bTrouve = False

	For lCptVal = 1 To lLen 
		sCar = Mid ( sVal, lCptVal, 1 )
		If sCar = "." Then
			If Not bTrouve Then 
				bTrouve = True
			Else
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, il y a deux virgules." )
				Exit
			End If

		Else
			If Not ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) Then
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, un caract$$HEX1$$e800$$ENDHEX$$re n'est pas un chiffre." )
				Exit
			End If
		End If
	Next	

	If Real ( sVal ) > 5000 Then		
		This.uf_Trace ( "ECR", "AVERTISSEMENT ligne " + String ( lCpt ) + &
		" : Le montant " + sVal + " para$$HEX1$$ee00$$ENDHEX$$t anormalement grand." )
	End If

	
	/*------------------------------------------------------------------*/
	/* ZONE 6 : UNT_MONNAIE															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "UNT_MONNAIE" ) ) )
	if uf_controler_monnaie_fichier (sVal, lCpt) < 0 Then iRet = -1
	
	/*------------------------------------------------------------------*/
	/* ZONE 7 : QT_DISP																  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemNumber ( lCpt, "QT_DISP" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		idwFicFourn.SetItem ( lCpt, "QT_DISP", 0 ) 
		sVal = "0"
	End If 

	If Not IsNumber ( sVal ) Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La quantit$$HEX2$$e9002000$$ENDHEX$$" + sVal + " n'est pas valide, ce n'est pas un nombre." )
		
	End If


	/*------------------------------------------------------------------*/
	/* ZONE 8 : OBSERV_FRN 															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )

	If Not IsNull ( sVal ) And sVal <> "" Then
		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (OBSERV_FRN) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "OBSERV_FRN", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 1 BIS : ID_REF_FOUR													  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur est vide." )
	ElseIf sIdRefFourPrec <> "" And sVal = sIdRefFourPrec Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sVal + " n'est pas unique." )
		
	End If

	sIdRefFourPrec = sVal

Next

If iRet < 0 Then This.uf_Trace ( "ECR", "ERREUR : Le fichier fournisseur n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$.")

Return iRet


end function

private function integer uf_integration_fichier_atech (ref long alnblig, ref long alnbinsert, ref long alnbdelete);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Integration_Fichier_Atech (PRIVATE)
//* Auteur			: FPI
//* Date				: 25/11/2015
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Int$$HEX1$$e900$$ENDHEX$$gration du fichier ATECH dans la base
//* Commentaires	: [PC13442-2]
//*
//* Arguments		: Long		alNbLig		Ref
//*					  Long		alNbInsert	Ref
//*					  Long		alNbDelete	Ref
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
///*-----------------------------------------------------------------

Int iRet
Long	lTotLigFourn, lRow, lCount, lCpt, lTotLigArticle
String	sIdFour, sIdRefFour, sIdTypArt, sIdMarqArt, sIdModlArt, sUntMonnaie, sNull, sIdMqIfr, sIdModlIfr, sIdTypArtRef
String sIdMarqArtIFr , sIdModlArtIFr 
Decimal {2}	dcTvaParDefaut
Boolean bBaseEuro, bInsert
Decimal {2} dcPrixHt
DateTime dt

iRet = 1
alNbInsert = 0
alNbDelete = 0
SetNull ( sNull )
dcTvaParDefaut = 20
dt = DateTime ( Today (), Now () )

dcTvaParDefaut = 0

/*------------------------------------------------------------------*/
/* Article de R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour le filtre sur l'existant en base       */
/*------------------------------------------------------------------*/


idwArticle.Reset ()

/*------------------------------------------------------------------*/
/* Chargement de la table actuelle                                  */
/*------------------------------------------------------------------*/
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
idwArticle.Retrieve ( sIdFour, "*" )

/*------------------------------------------------------------------*/
/* Nbre de ligne dans le fichier                                    */
/*------------------------------------------------------------------*/
lTotLigFourn = idwFicFourn.RowCount ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table                                      */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Initilisation de la trace d'int$$HEX1$$e900$$ENDHEX$$gration.                         */
/*------------------------------------------------------------------*/
This.uf_Trace_2 ( "INIT", 0, sIdFour, "", "", "", "" )

/*------------------------------------------------------------------*/
/* MAJ de la DW avec le fichier.                                    */
/*------------------------------------------------------------------*/
For alNbLig = 1 To lTotLigFourn

	sIdFour 	   = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_REF_FOUR" ) ) )

	lRow = idwArticle.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwArticle.RowCount () )

	If lRow <= 0 Then 
		bInsert = True
		lRow = idwArticle.InsertRow ( 0 )
		alNbInsert ++
		idwArticle.SetItem ( lRow, "ID_FOUR", 	 sIdFour	  )				
		idwArticle.SetItem ( lRow, "ID_REF_FOUR",  sIdRefFour  )				
		idwArticle.SetItem ( lRow, "ID_TYP_ART",	 sIdTypArt	  )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART",	 sIdMarqArt	  )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART",	 sIdModlArt	  )				
		idwArticle.SetItem ( lRow, "ALT_DISPO",	 "N"	 )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "TVA", dcTvaParDefaut )
		idwArticle.SetItem ( lRow, "CREE_LE", dt )		
	Else
		bInsert = False
	End If

	If lRow > 0 Then 
		dcPrixHt = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_HT" )
		idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								

		/*------------------------------------------------------------------*/
		/* Code $$HEX1$$e900$$ENDHEX$$tat (-EI)                                                  */
		/* 200 Nouveau                                                      */
		/* 100 MAj_Ok sur existant                                          */
		/*------------------------------------------------------------------*/
		If bInsert Then
			idwArticle.SetItem ( lRow, "COD_ETAT", 200 )		
			This.uf_Trace_2 ( "ECR_AUTO", 200, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		Else
			idwArticle.SetItem ( lRow, "COD_ETAT", 100 )		

			sIdMqIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MARQ_ART_IFR" ) )
			sIdModlIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MODL_ART_IFR" ) )

			/*------------------------------------------------------------------*/
			/* Si les marques et mod$$HEX1$$e800$$ENDHEX$$les IFR sont absent de l'enregistrement    */
			/* exisant, on force ALT_DIPSPO $$HEX2$$e0002000$$ENDHEX$$NON.                              */
			/*------------------------------------------------------------------*/
			If Isnull ( sIdMqIfr ) Or sIdMqIfr = "" Or Isnull ( sIdModlIfr ) Or sIdModlIfr = "" Then
				idwArticle.SetItem ( lRow, "ALT_DISPO", "N" )				
			End If

			This.uf_Trace_2 ( "ECR_AUTO", 100, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		End If

		// [PC10][DIAG_NOMADE]
		Choose Case sIdTypArt 
			Case "TEL", "PC1", "PC2" 
				// Doit $$HEX1$$ea00$$ENDHEX$$tre mis $$HEX2$$e0002000$$ENDHEX$$la main pas Cell. Parte.
				// [VDOC6993]
				If bInsert Then
					sIdMarqArtIFr = Space (35) 
					sIdModlArtIFr = Space (35) 
					SQLCA.PS_S_VDOC6993_LIEN_ARTICLE ( sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, sIdMarqArtIFr, sIdModlArtIFr ) 
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR", sIdMarqArtIFr )				
					End If
					
					If Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR", sIdModlArtIFr )				
					End If
					
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) And &
						Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
					End If
				End If				
			Case Else
				idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
		End Choose

		idwArticle.SetItem ( lRow, "QT_DISP", 20000 ) // #2 [DCMP090130] 
		idwArticle.SetItem ( lRow, "OBSERV_FRN", Upper ( idwFicFourn.GetItemString ( alNbLig, "OBSERV_FRN" ) ) )
		idwArticle.SetItem ( lRow, "VERROU", 1 )
		idwArticle.SetItem ( lRow, "MAJ_LE", dt )		
		idwArticle.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )		

	End If

Next

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table (r$$HEX1$$e900$$ENDHEX$$actualis$$HEX1$$e900$$ENDHEX$$)                        */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Suppression des lignes pr$$HEX1$$e900$$ENDHEX$$sentes dans la table articles et       */
/* absentes du fichier.                                             */
/*------------------------------------------------------------------*/
For lCpt = lTotLigArticle To 1 Step -1

	sIdFour 	   = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	// [PC10][DIAG_NOMADE]
	Choose Case sIdTypArt
		Case "AEF", "CAF","DEV"
			Continue
	End Choose

	lRow = idwFicFourn.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwFicFourn.RowCount () )

	If lRow <= 0 Then 
		alNbDelete ++
		idwArticle.DeleteRow ( lCpt )
		This.uf_Trace_2 ( "ECR_AUTO", 300, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
	End If

Next 

idwArticle.SetFilter ( "" )
idwArticle.Filter ()

return iRet 
end function

private function integer uf_ctrl_fichier_boost ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Ctrl_Fichier_BOOST (PRIVATE)
//* Auteur			: FPI
//* Date				: 28/06/2016
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler de la validit$$HEX2$$e9002000$$ENDHEX$$du fichier de BOOST
//* Commentaires	: [PC151549]
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    13/12/2016  [VDOC22133]
//*-----------------------------------------------------------------

Int iRet 
String	sIdFour, sVal, sCar, sSort, sIdRefFourPrec, sTypArtSav
Long		lTotLig, lCpt, lCptVal, lTotArt, lLen
Boolean	bTrouve

iRet = 1

lTotLig = idwFicFourn.RowCount ()
lTotArt = idwArtSpb.RowCount ()
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sTypArtSav = ""

idwFicFourn.SetSort ( "ID_REF_FOUR A" )
idwFicFourn.Sort ()

sIdRefFourPrec = ""

For lCpt = 1 To lTotLig 

	/*------------------------------------------------------------------*/
	/* ZONE 1 : ID_FOUR                                                 */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone fournisseur est vide." )
	End If 

	If sVal <> sIdFour Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fournisseur " + sVal + " ne correspond pas au fournisseur s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$" + sIdFour )
	End If 

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La longueur du fournisseur doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If
	
	/*------------------------------------------------------------------*/
	/* ZONE 2 : ID_TYP_ART                                              */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_TYP_ART" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Type Article est vide." )
	End If 

	If Not IsNull ( sVal ) And sVal <> "" Then
	  sTypArtSav = sVal
	End If

	bTrouve = False
	lCptVal = 1
	Do While Not bTrouve And lCptVal <= lTotArt
		bTrouve = sVal = Upper ( idwArtSpb.GetItemString ( lCptVal, "ID_CODE" ) )
		lCptVal ++
	Loop

	If Not bTrouve Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type d'article " + sVal + " n'existe pas dans la base SIMPA2.")
	End If

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type de l'article doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If		

	/*------------------------------------------------------------------*/
	/* ZONE 3 : ID_MARQ_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MARQ_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Marque Article est vide." )
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 4 : ID_MODL_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MODL_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone mod$$HEX1$$e800$$ENDHEX$$le article est vide." )
	Else

		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (ID_MODL_ART) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "ID_MODL_ART", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 5 : MT_PRIX_HT															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemDecimal ( lCpt, "MT_PRIX_HT" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Prix Hors Taxe est vide." )
	End If 

	lLen = Len ( sVal )
	
	// Marque la virgule
	bTrouve = False

	For lCptVal = 1 To lLen 
		sCar = Mid ( sVal, lCptVal, 1 )
		If sCar = "." Then
			If Not bTrouve Then 
				bTrouve = True
			Else
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, il y a deux virgules." )
				Exit
			End If

		Else
			If Not ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) Then
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, un caract$$HEX1$$e800$$ENDHEX$$re n'est pas un chiffre." )
				Exit
			End If
		End If
	Next	

	If Real ( sVal ) > 5000 Then		
		This.uf_Trace ( "ECR", "AVERTISSEMENT ligne " + String ( lCpt ) + &
		" : Le montant " + sVal + " para$$HEX1$$ee00$$ENDHEX$$t anormalement grand." )
	End If

	
	/*------------------------------------------------------------------*/
	/* ZONE 6 : UNT_MONNAIE															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "UNT_MONNAIE" ) ) )
	if uf_controler_monnaie_fichier (sVal, lCpt) < 0 Then iRet = -1
	
	/*------------------------------------------------------------------*/
	/* ZONE 7 : QT_DISP																  */
	/*------------------------------------------------------------------*/
/* [VDOC22133]
	sVal = Trim ( String ( idwFicFourn.GetItemNumber ( lCpt, "QT_DISP" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		idwFicFourn.SetItem ( lCpt, "QT_DISP", 0 ) 
		sVal = "0"
	End If 

	If Not IsNumber ( sVal ) Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La quantit$$HEX2$$e9002000$$ENDHEX$$" + sVal + " n'est pas valide, ce n'est pas un nombre." )
		
	End If
*/

	/*------------------------------------------------------------------*/
	/* ZONE 8 : OBSERV_FRN 															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )

	If Not IsNull ( sVal ) And sVal <> "" Then
		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (OBSERV_FRN) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "OBSERV_FRN", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 1 BIS : ID_REF_FOUR													  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur est vide." )
	ElseIf sIdRefFourPrec <> "" And sVal = sIdRefFourPrec Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sVal + " n'est pas unique." )
		
	End If

	sIdRefFourPrec = sVal

Next

If iRet < 0 Then This.uf_Trace ( "ECR", "ERREUR : Le fichier fournisseur n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$.")

Return iRet


end function

private function integer uf_integration_fichier_boost (ref long alnblig, ref long alnbinsert, ref long alnbdelete);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Integration_Fichier_Boost (PRIVATE)
//* Auteur			: JFF
//* Date				: 28/06/2016
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Int$$HEX1$$e900$$ENDHEX$$gration du fichier BOOST dans la base
//* Commentaires	: [PC151549]
//*
//* Arguments		: Long		alNbLig		Ref
//*					  Long		alNbInsert	Ref
//*					  Long		alNbDelete	Ref
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*       JFF   30/08/2021   [RS972][OPTIM_MB3&4]
///*-----------------------------------------------------------------

Int iRet
Long	lTotLigFourn, lRow, lCount, lCpt, lTotLigArticle
String	sIdFour, sIdRefFour, sIdTypArt, sIdMarqArt, sIdModlArt, sUntMonnaie, sNull, sIdMqIfr, sIdModlIfr, sIdTypArtRef
String sIdMarqArtIFr , sIdModlArtIFr 
Decimal {2}	dcTvaParDefaut
Boolean bBaseEuro, bInsert
Decimal {2} dcPrixHt
DateTime dt

iRet = 1
alNbInsert = 0
alNbDelete = 0
SetNull ( sNull )

// [RS972][OPTIM_MB3&4]
// dcTvaParDefaut = 20
dcTvaParDefaut = 0

dt = DateTime ( Today (), Now () )

/*------------------------------------------------------------------*/
/* Article de R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour le filtre sur l'existant en base       */
/*------------------------------------------------------------------*/


idwArticle.Reset ()

/*------------------------------------------------------------------*/
/* Chargement de la table actuelle                                  */
/*------------------------------------------------------------------*/
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
idwArticle.Retrieve ( sIdFour, "*" )

/*------------------------------------------------------------------*/
/* Nbre de ligne dans le fichier                                    */
/*------------------------------------------------------------------*/
lTotLigFourn = idwFicFourn.RowCount ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table                                      */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Initilisation de la trace d'int$$HEX1$$e900$$ENDHEX$$gration.                         */
/*------------------------------------------------------------------*/
This.uf_Trace_2 ( "INIT", 0, sIdFour, "", "", "", "" )

/*------------------------------------------------------------------*/
/* MAJ de la DW avec le fichier.                                    */
/*------------------------------------------------------------------*/
For alNbLig = 1 To lTotLigFourn

	sIdFour 	   = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_REF_FOUR" ) ) )

	lRow = idwArticle.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwArticle.RowCount () )

	If lRow <= 0 Then 
		bInsert = True
		lRow = idwArticle.InsertRow ( 0 )
		alNbInsert ++
		idwArticle.SetItem ( lRow, "ID_FOUR", 	 sIdFour	  )				
		idwArticle.SetItem ( lRow, "ID_REF_FOUR",  sIdRefFour  )				
		idwArticle.SetItem ( lRow, "ID_TYP_ART",	 sIdTypArt	  )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART",	 sIdMarqArt	  )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART",	 sIdModlArt	  )				
		idwArticle.SetItem ( lRow, "ALT_DISPO",	 "N"	 )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "TVA", dcTvaParDefaut )
		idwArticle.SetItem ( lRow, "CREE_LE", dt )		
	Else
		bInsert = False
	End If

	If lRow > 0 Then 
		dcPrixHt = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_HT" )
		idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								

		/*------------------------------------------------------------------*/
		/* Code $$HEX1$$e900$$ENDHEX$$tat (-EI)                                                  */
		/* 200 Nouveau                                                      */
		/* 100 MAj_Ok sur existant                                          */
		/*------------------------------------------------------------------*/
		If bInsert Then
			idwArticle.SetItem ( lRow, "COD_ETAT", 200 )		
			This.uf_Trace_2 ( "ECR_AUTO", 200, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		Else
			idwArticle.SetItem ( lRow, "COD_ETAT", 100 )		

			sIdMqIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MARQ_ART_IFR" ) )
			sIdModlIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MODL_ART_IFR" ) )

			/*------------------------------------------------------------------*/
			/* Si les marques et mod$$HEX1$$e800$$ENDHEX$$les IFR sont absent de l'enregistrement    */
			/* exisant, on force ALT_DIPSPO $$HEX2$$e0002000$$ENDHEX$$NON.                              */
			/*------------------------------------------------------------------*/
			If Isnull ( sIdMqIfr ) Or sIdMqIfr = "" Or Isnull ( sIdModlIfr ) Or sIdModlIfr = "" Then
				idwArticle.SetItem ( lRow, "ALT_DISPO", "N" )				
			End If

			This.uf_Trace_2 ( "ECR_AUTO", 100, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		End If

		// [PC10][DIAG_NOMADE]
		Choose Case sIdTypArt 
			Case "TEL", "PC1", "PC2", "TPC", "MCS" 
				// Doit $$HEX1$$ea00$$ENDHEX$$tre mis $$HEX2$$e0002000$$ENDHEX$$la main pas Cell. Parte.
				// [VDOC6993]
				If bInsert Then
					sIdMarqArtIFr = Space (35) 
					sIdModlArtIFr = Space (35) 
					SQLCA.PS_S_VDOC6993_LIEN_ARTICLE ( sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, sIdMarqArtIFr, sIdModlArtIFr ) 
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR", sIdMarqArtIFr )				
					End If
					
					If Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR", sIdModlArtIFr )				
					End If
					
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) And &
						Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
					End If
				End If				
			Case Else
				idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
		End Choose

		idwArticle.SetItem ( lRow, "QT_DISP", 20000 ) // #2 [DCMP090130] 
		
		// LE REC pour le filtre O2M dp/226 fonctionne aussi sur Boost.
		// [RS972][OPTIM_MB3&4]
		// idwArticle.SetItem ( lRow, "OBSERV_FRN", "[#1F1#][#NEU#]" ) // [PC151549]
		idwArticle.SetItem ( lRow, "OBSERV_FRN", Upper ( idwFicFourn.GetItemString ( alNbLig, "OBSERV_FRN" ) ) )		
		
		idwArticle.SetItem ( lRow, "VERROU", 1 )
		idwArticle.SetItem ( lRow, "MAJ_LE", dt )		
		idwArticle.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )		

	End If

Next

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table (r$$HEX1$$e900$$ENDHEX$$actualis$$HEX1$$e900$$ENDHEX$$)                        */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Suppression des lignes pr$$HEX1$$e900$$ENDHEX$$sentes dans la table articles et       */
/* absentes du fichier.                                             */
/*------------------------------------------------------------------*/
For lCpt = lTotLigArticle To 1 Step -1

	sIdFour 	   = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	// [PC10][DIAG_NOMADE]
	Choose Case sIdTypArt
		Case "AEF", "CAF","DEV"
			Continue
	End Choose

	lRow = idwFicFourn.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwFicFourn.RowCount () )

	If lRow <= 0 Then 
		alNbDelete ++
		idwArticle.DeleteRow ( lCpt )
		This.uf_Trace_2 ( "ECR_AUTO", 300, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
	End If

Next 

idwArticle.SetFilter ( "" )
idwArticle.Filter ()

return iRet 
end function

private function integer uf_ctrl_fichier_bak2 ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Ctrl_Fichier_BAK2 (PRIVATE)
//* Auteur			: JFF
//* Date				: 11/10/2016
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler de la validit$$HEX2$$e9002000$$ENDHEX$$du fichier de O2M
//* Commentaires	: [DT076-2]
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Int iRet 
String	sIdFour, sVal, sCar, sSort, sIdRefFourPrec, sTypArtSav
Long		lTotLig, lCpt, lCptVal, lTotArt, lLen
Boolean	bTrouve

iRet = 1

lTotLig = idwFicFourn.RowCount ()
lTotArt = idwArtSpb.RowCount ()
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sTypArtSav = ""

// JFF 20/01/2011 : le tri imp$$HEX1$$e900$$ENDHEX$$ratif sur ID_REF_FOUR $$HEX1$$e900$$ENDHEX$$tait visiblement manquant (?..)
idwFicFourn.SetSort ( "ID_REF_FOUR A" )
idwFicFourn.Sort ()

sIdRefFourPrec = ""

For lCpt = 1 To lTotLig 

	/*------------------------------------------------------------------*/
	/* ZONE 1 : ID_FOUR                                                */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone fournisseur est vide." )
	End If 

	If sVal <> sIdFour Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fournisseur " + sVal + " ne correspond pas au fournisseur s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$" + sIdFour )
	End If 

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La longueur du fournisseur doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If
	
	/*------------------------------------------------------------------*/
	/* ZONE 2 : ID_TYP_ART                                              */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_TYP_ART" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Type Article est vide." )
	End If 

	// Le fichier ne doit que contenir que des appareils du m$$HEX1$$ea00$$ENDHEX$$me type
	// #2 [DCMP090615]
	/*
	If sTypArtSav <> sVal And sTypArtSav <> "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fichier contient des types d'appareils diff$$HEX1$$e900$$ENDHEX$$rents !" )
	End If
	*/
	// :#2 [DCMP090615]

	If Not IsNull ( sVal ) And sVal <> "" Then
	  sTypArtSav = sVal
	End If

	bTrouve = False
	lCptVal = 1
	Do While Not bTrouve And lCptVal <= lTotArt
		bTrouve = sVal = Upper ( idwArtSpb.GetItemString ( lCptVal, "ID_CODE" ) )
		lCptVal ++
	Loop

	If Not bTrouve Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type d'article " + sVal + " n'existe pas dans la base SIMPA2.")
	End If

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type de l'article doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If		

	/*------------------------------------------------------------------*/
	/* ZONE 3 : ID_MARQ_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MARQ_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Marque Article est vide." )
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 4 : ID_MODL_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MODL_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone mod$$HEX1$$e800$$ENDHEX$$le article est vide." )
	Else

		If Pos ( sVal, "'", 1 ) > 0 Then
//			This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (ID_MODL_ART) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "ID_MODL_ART", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 5 : MT_PRIX_HT															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemDecimal ( lCpt, "MT_PRIX_HT" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Prix Hors Taxe est vide." )
	End If 

	lLen = Len ( sVal )
	
	// Marque la virgule
	bTrouve = False

	For lCptVal = 1 To lLen 
		sCar = Mid ( sVal, lCptVal, 1 )
		If sCar = "." Then
			If Not bTrouve Then 
				bTrouve = True
			Else
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, il y a deux virgules." )
				Exit
			End If

		Else
			If Not ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) Then
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, un caract$$HEX1$$e800$$ENDHEX$$re n'est pas un chiffre." )
				Exit
			End If
		End If
	Next	

	If Real ( sVal ) > 5000 Then		
		This.uf_Trace ( "ECR", "AVERTISSEMENT ligne " + String ( lCpt ) + &
		" : Le montant " + sVal + " para$$HEX1$$ee00$$ENDHEX$$t anormalement grand." )
	End If

	
	/*------------------------------------------------------------------*/
	/* ZONE 6 : UNT_MONNAIE															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "UNT_MONNAIE" ) ) )
	// [SUISSE].LOT3 Controle de la monnaie du fichier
	// Si pas de coh$$HEX1$$e900$$ENDHEX$$rence : erreur bloquante d'int$$HEX1$$e900$$ENDHEX$$gration.
	if uf_controler_monnaie_fichier (sVal, lCpt) < 0 Then iRet = -1
	
//	If IsNull ( sVal ) Or sVal = "" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : L'unit$$HEX2$$e9002000$$ENDHEX$$de la monnaie est vide." )
//	End If 
//
//	If sVal <> "FRF" And sVal <> "EUR" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : La monnaie " + sVal + " n'est pas valide." )
//		Exit
//	End If

	/*------------------------------------------------------------------*/
	/* ZONE 7 : QT_DISP																  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemNumber ( lCpt, "QT_DISP" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		idwFicFourn.SetItem ( lCpt, "QT_DISP", 0 ) 
		sVal = "0"
	End If 

	If Not IsNumber ( sVal ) Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La quantit$$HEX2$$e9002000$$ENDHEX$$" + sVal + " n'est pas valide, ce n'est pas un nombre." )
		
	End If

	/*------------------------------------------------------------------*/
	/* ZONE 8 : OBSERV_FRN 															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )

	If Not IsNull ( sVal ) And sVal <> "" Then
		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (OBSERV_FRN) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "OBSERV_FRN", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 
	
	/*------------------------------------------------------------------*/
	/* ZONE 1 BIS : ID_REF_FOUR													  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur est vide." )
	ElseIf sIdRefFourPrec <> "" And sVal = sIdRefFourPrec Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sVal + " n'est pas unique." )
		
	End If

	sIdRefFourPrec = sVal

Next

If iRet < 0 Then This.uf_Trace ( "ECR", "ERREUR : Le fichier fournisseur n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$.")

Return iRet


end function

private function integer uf_integration_fichier_bak2 (ref long alnblig, ref long alnbinsert, ref long alnbdelete);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Integration_Fichier_BAK2 (PRIVATE)
//* Auteur			: JFF
//* Date				: 11/10/2016
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Int$$HEX1$$e900$$ENDHEX$$gration du fichier O2M dans la base
//* Commentaires	: //[DT076-2]
//*
//* Arguments		: Long		alNbLig		Ref
//*					  Long		alNbInsert	Ref
//*					  Long		alNbDelete	Ref
//*					  String 	asCas			Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//			FPI	19/12/2016	[FPI.20161219] Multiplication des r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences par 10
//       JFF   12/09/2017  [PC151259-3]
//*-----------------------------------------------------------------

Int iRet
Long	lTotLigFourn, lRow, lCount, lCpt, lTotLigArticle
String	sIdFour, sIdRefFour, sIdTypArt, sIdMarqArt, sIdModlArt, sUntMonnaie, sNull, sIdMqIfr, sIdModlIfr, sIdTypArtRef, sSql
String sIdMarqArtIFr , sIdModlArtIFr 
Decimal {2}	dcTvaParDefaut, dcMtPrixLog 
Boolean bBaseEuro, bInsert
Decimal {2} dcPrixHt
DateTime dt

iRet = 1
alNbInsert = 0
alNbDelete = 0
SetNull ( sNull )

// [DT_60_AUGM_TVA] 1.196
dcTvaParDefaut = 20

dt = DateTime ( Today (), Now () )

idwArticle.Reset ()
	
// [FPI.20161219] - Multiplication des lignes
lTotLigFourn = idwFicFourn.RowCount ()
For lCount=1 To lTotLigFourn
	
	sIdRefFour  = Upper ( Trim ( idwFicFourn.GetItemString ( lCount, "ID_REF_FOUR" ) ) )

	For lCpt=2 to 10
		idwFicFourn.RowsCopy(lCount, lCount, Primary!, idwFicFourn,idwFicFourn.RowCount() + 1, Primary!)
		idwFicFourn.SetItem(idwFicFourn.RowCount(), "ID_REF_FOUR", sIdRefFour + "_" + string(lCpt))
	Next
	
	idwFicFourn.SetItem(lCount,"ID_REF_FOUR",sIdRefFour + "_1")
Next
// :[FPI.20161219]

/*------------------------------------------------------------------*/
/* Chargement de la table actuelle                                  */
/*------------------------------------------------------------------*/
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )

F_Execute ( "Exec sysadm.PS_D01_ARTICLE_FOURN '"+ sIdFour + "'" , SQLCA )

idwArticle.Retrieve ( sIdFour, "*" )

/*------------------------------------------------------------------*/
/* Nbre de ligne dans le fichier                                    */
/*------------------------------------------------------------------*/
lTotLigFourn = idwFicFourn.RowCount ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table                                      */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Initilisation de la trace d'int$$HEX1$$e900$$ENDHEX$$gration.                         */
/*------------------------------------------------------------------*/
This.uf_Trace_2 ( "INIT", 0, sIdFour, "", "", "", "" )

/*------------------------------------------------------------------*/
/* MAJ de la DW avec le fichier.                                    */
/*------------------------------------------------------------------*/
For alNbLig = 1 To lTotLigFourn

	sIdFour 	   = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_REF_FOUR" ) ) )


	lRow = idwArticle.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwArticle.RowCount () )

	If lRow <= 0 Then 
		bInsert = True
		lRow = idwArticle.InsertRow ( 0 )
		alNbInsert ++
		idwArticle.SetItem ( lRow, "ID_FOUR", 	 sIdFour	  )				
		idwArticle.SetItem ( lRow, "ID_REF_FOUR",  sIdRefFour  )				
		idwArticle.SetItem ( lRow, "ID_TYP_ART",	 sIdTypArt	  )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART",	 sIdMarqArt	  )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART",	 sIdModlArt	  )				
		idwArticle.SetItem ( lRow, "ALT_DISPO",	 "N"	 )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "TVA", dcTvaParDefaut )		
		idwArticle.SetItem ( lRow, "CREE_LE", dt )		
	Else
		bInsert = False
	End If

	If lRow > 0 Then 

		// #1 [SUISSE].LOT3
		dcPrixHt = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_HT" )
		idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								
		// :#1


		/*------------------------------------------------------------------*/
		/* Code $$HEX1$$e900$$ENDHEX$$tat (-EI)                                                  */
		/* 200 Nouveau                                                      */
		/* 100 MAj_Ok sur existant                                          */
		/*------------------------------------------------------------------*/
		If bInsert Then
			idwArticle.SetItem ( lRow, "COD_ETAT", 200 )		
			This.uf_Trace_2 ( "ECR_AUTO", 200, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		Else
			idwArticle.SetItem ( lRow, "COD_ETAT", 100 )		
			sIdMqIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MARQ_ART_IFR" ) )
			sIdModlIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MODL_ART_IFR" ) )

			/*------------------------------------------------------------------*/
			/* Si les marques et mod$$HEX1$$e800$$ENDHEX$$les IFR sont absent de l'enregistrement    */
			/* exisant, on force ALT_DIPSPO $$HEX2$$e0002000$$ENDHEX$$NON.                              */
			/*------------------------------------------------------------------*/
			If Isnull ( sIdMqIfr ) Or sIdMqIfr = "" Or Isnull ( sIdModlIfr ) Or sIdModlIfr = "" Then
				idwArticle.SetItem ( lRow, "ALT_DISPO", "N" )				
			End If

			This.uf_Trace_2 ( "ECR_AUTO", 100, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		End If

		// [VDOC6846]
		Choose Case sIdTypArt 
			Case "TEL", "PC1", "PC2" 
				// Doit $$HEX1$$ea00$$ENDHEX$$tre mis $$HEX2$$e0002000$$ENDHEX$$la main pas Cell. Parte.
				// [VDOC6993]
				If bInsert Then
					sIdMarqArtIFr = Space (35) 
					sIdModlArtIFr = Space (35) 
					SQLCA.PS_S_VDOC6993_LIEN_ARTICLE ( sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, sIdMarqArtIFr, sIdModlArtIFr ) 
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR", sIdMarqArtIFr )				
					End If
					
					If Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR", sIdModlArtIFr )				
					End If
					
					If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) And &
						Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
						idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
					End If
				End If					
			Case Else
				idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
		End Choose
		// :[VDOC6846]
	
		idwArticle.SetItem ( lRow, "QT_DISP", idwFicFourn.GetItemNumber ( alNbLig, "QT_DISP" ) )
		// [PC151259-3]
		idwArticle.SetItem ( lRow, "OBSERV_FRN",  "[#1F5#][#REC#]" ) // Upper ( idwFicFourn.GetItemString ( alNbLig, "OBSERV_FRN" ) ) +
		
		idwArticle.SetItem ( lRow, "VERROU", 1 )
		idwArticle.SetItem ( lRow, "MAJ_LE", dt )		
		idwArticle.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )		
	
		End If

Next


idwArticle.SetFilter ( "" )
idwArticle.Filter ()

return iRet 
end function

private function integer uf_ctrl_fichier_rt_bouygues ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_int_fic_article::uf_Ctrl_Fichier_rt_bouygues (PRIVATE)
//* Auteur			: FPI
//* Date				: 15/09/2017
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [DT328-1]
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Int iRet 
String	sIdFour, sVal, sCar, sSort, sIdRefFourPrec, sTypArtSav
Long		lTotLig, lCpt, lCptVal, lTotArt, lLen
Boolean	bTrouve
n_cst_string nvString

iRet = 1

// Suppression de la ligne d'ent$$HEX1$$ea00$$ENDHEX$$te
idwFicFourn.DeleteRow(1)

lTotLig = idwFicFourn.RowCount ()
lTotArt = idwArtSpb.RowCount ()
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sTypArtSav = ""

// JFF 20/01/2011 : le tri imp$$HEX1$$e900$$ENDHEX$$ratif sur ID_REF_FOUR $$HEX1$$e900$$ENDHEX$$tait visiblement manquant (?..)
idwFicFourn.SetSort ( "GENCOD A" )
idwFicFourn.Sort ()

sIdRefFourPrec = ""

For lCpt = 1 To lTotLig 


	/*------------------------------------------------------------------*/
	/* ZONE 1 : GENCOD													*/
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "GENCOD" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone GenCod est vide." )
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 1 : ID_MARQ_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "MARQUE" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Marque est vide." )
	Else
		sVal=nvString.of_globalreplace( sVal, "~"", "")
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 4 : ID_MODL_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "Libelle_commercial" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Libelle_commercial est vide." )
	Else
		sVal=nvString.of_globalreplace( sVal, "~"", "p")
		sVal=nvString.of_globalreplace( sVal, "''", "p")
		sVal=nvString.of_globalreplace( sVal, "'", "p")
		idwFicFourn.SetItem ( lCpt, "Libelle_commercial", sVal) // On coupe $$HEX2$$e0002000$$ENDHEX$$35 au cas o$$HEX1$$f900$$ENDHEX$$
	End If 

	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "Designation" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Designation est vide." )
	Else
		sVal=nvString.of_globalreplace( sVal, "~"", "p")
		sVal=nvString.of_globalreplace( sVal, "''", "p")
		sVal=nvString.of_globalreplace( sVal, "'", "p")
		idwFicFourn.SetItem ( lCpt, "Designation", sVal) // On coupe $$HEX2$$e0002000$$ENDHEX$$35 au cas o$$HEX1$$f900$$ENDHEX$$
	End If 
Next

// Doublon
For lCpt = lTotLig To 2 STEP -1
	sVal=idwFicFourn.GetItemString ( lCpt, "GENCOD" )
	if idwFicFourn.Find("GENCOD='"  + sVal + "'", 1,lCpt -1) > 0 Then
		idwFicFourn.DeleteRow(lCpt)
	End if
Next

If iRet < 0 Then This.uf_Trace ( "ECR", "ERREUR : Le fichier r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rentiel des terminaux Bouygues n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$.")

Return iRet


end function

private function integer uf_integration_fichier_rt_bouygues (ref long alnblig, ref long alnbinsert, ref long alnbdelete);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_int_fic_article::uf_Integration_Fichier_rt_Bouygues (PRIVATE)
//* Auteur			: FPI
//* Date				: 28/09/2015
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Int$$HEX1$$e900$$ENDHEX$$gration du fichier de prix public Orange dans la base
//* Commentaires	: [DT328-1]
//*
//* Arguments		: Long		alNbLig		Ref
//*					  Long		alNbInsert	Ref
//*					  Long		alNbDelete	Ref
//*					  String 	asCas			Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Int iRet
Long	lTotLigFourn, lRow, lCount, lCpt, lTotLigArticle, lQtDisp
String	sIdFour, sIdRefFour, sIdTypArt, sIdMarqArt, sIdModlArt, sUntMonnaie, sNull, sIdMqIfr, sIdModlIfr, sIdTypArtRef , sMtHT
Decimal {2}	dcTvaParDefaut
Boolean bBaseEuro, bInsert
Decimal {2} dcPrixHt
DateTime dt
n_cst_string nvString

iRet = 1
alNbInsert = 0
alNbDelete = 0
SetNull ( sNull )

dcTvaParDefaut=0

dt = DateTime ( Today (), Now () )

/*------------------------------------------------------------------*/
/* Article de R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour le filtre sur l'existant en base       */
/*------------------------------------------------------------------*/
sIdTypArtRef = "TEL"

idwArticle.Reset ()

/*------------------------------------------------------------------*/
/* Chargement de la table actuelle                                  */
/*------------------------------------------------------------------*/
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
idwArticle.Retrieve ( sIdFour, "*" )

/*------------------------------------------------------------------*/
/* Nbre de ligne dans le fichier                                    */
/*------------------------------------------------------------------*/
lTotLigFourn = idwFicFourn.RowCount ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table                                      */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Initilisation de la trace d'int$$HEX1$$e900$$ENDHEX$$gration.                         */
/*------------------------------------------------------------------*/
This.uf_Trace_2 ( "INIT", 0, sIdFour, "", "", "", "" )

/*------------------------------------------------------------------*/
/* MAJ de la DW avec le fichier.                                    */
/*------------------------------------------------------------------*/
For alNbLig = 1 To lTotLigFourn

	sIdTypArt 	= sIdTypArtRef
	sIdMarqArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "MARQUE" ) ) )
	
	sIdModlArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "Designation" ) ) )
	sIdModlArt  = Trim(nvString.of_globalreplace( sIdModlArt, sIdMarqArt, ""))
	sIdModlArt=Left(sIdModlArt,35)
	
	sIdRefFour  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "GENCOD" ) ) )
	dcPrixHt    = 9999
	lQtDisp		= 1
	
	try
	lRow = idwArticle.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwArticle.RowCount () )
								Catch (Exception e)
									lRow=-1
								End try
	If lRow <= 0 Then 
		bInsert = True
		lRow = idwArticle.InsertRow ( 0 )
		alNbInsert ++
		idwArticle.SetItem ( lRow, "ID_FOUR", 	 sIdFour	  )				
		idwArticle.SetItem ( lRow, "ID_REF_FOUR",  sIdRefFour  )				
		idwArticle.SetItem ( lRow, "ID_TYP_ART",	 sIdTypArt	  )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART",	 sIdMarqArt	  )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART",	 sIdModlArt	  )				
		idwArticle.SetItem ( lRow, "ALT_DISPO",	 "N"	 )				
		idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR",	 sNull )				
		idwArticle.SetItem ( lRow, "TVA", dcTvaParDefaut )		
		idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								
		idwArticle.SetItem ( lRow, "QT_DISP", lQtDisp )
		idwArticle.SetItem ( lRow, "CREE_LE", dt )	
	Else
		bInsert = False
	End If

	If lRow > 0 Then 

		idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								


		/*------------------------------------------------------------------*/
		/* Code $$HEX1$$e900$$ENDHEX$$tat (-EI)                                                  */
		/* 200 Nouveau                                                      */
		/* 100 MAj_Ok sur existant                                          */
		/*------------------------------------------------------------------*/
		If bInsert Then
			idwArticle.SetItem ( lRow, "COD_ETAT", 200 )		
			This.uf_Trace_2 ( "ECR_AUTO", 200, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		Else
			idwArticle.SetItem ( lRow, "COD_ETAT", 100 )		

			sIdMqIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MARQ_ART_IFR" ) )
			sIdModlIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MODL_ART_IFR" ) )

			/*------------------------------------------------------------------*/
			/* Si les marques et mod$$HEX1$$e800$$ENDHEX$$les IFR sont absent de l'enregistrement    */
			/* exisant, on force ALT_DIPSPO $$HEX2$$e0002000$$ENDHEX$$NON.                              */
			/*------------------------------------------------------------------*/
			If Isnull ( sIdMqIfr ) Or sIdMqIfr = "" Or Isnull ( sIdModlIfr ) Or sIdModlIfr = "" Then
				idwArticle.SetItem ( lRow, "ALT_DISPO", "N" )				
			End If

			This.uf_Trace_2 ( "ECR_AUTO", 100, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		End If

		idwArticle.SetItem ( lRow, "QT_DISP", 1 ) // On n'a pas besoin de quantit$$HEX1$$e900$$ENDHEX$$.
		idwArticle.SetItem ( lRow, "VERROU", 1 )
		idwArticle.SetItem ( lRow, "MAJ_LE", dt )		
		idwArticle.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )		
	
	End If

Next

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table (r$$HEX1$$e900$$ENDHEX$$actualis$$HEX1$$e900$$ENDHEX$$)                        */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Suppression des lignes pr$$HEX1$$e900$$ENDHEX$$sentes dans la table articles et       */
/* absentes du fichier.                                             */
/*------------------------------------------------------------------*/
/*For lCpt = lTotLigArticle To 1 Step -1

	sIdFour 	   = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	lRow = idwFicFourn.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
									 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
									 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
									 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
									 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
									 1, idwFicFourn.RowCount () )

	If lRow <= 0 Then 
		alNbDelete ++
		idwArticle.DeleteRow ( lCpt )
		This.uf_Trace_2 ( "ECR_AUTO", 300, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
	End If

Next 
*/
idwArticle.SetFilter ( "" )
idwArticle.Filter ()

return iRet 
end function

private function integer uf_ctrl_fichier_agora_place ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Ctrl_Fichier_Agora_Place (PRIVATE)
//* Auteur			: JFF
//* Date				: 17/09/2018
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler de la validit$$HEX2$$e9002000$$ENDHEX$$du fichier de AGORA PLACE
//* Commentaires	: [PM444-1]
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Int iRet 
String	sIdFour, sVal, sCar, sSort, sIdRefFourPrec, sTypArtSav
Long		lTotLig, lCpt, lCptVal, lTotArt, lLen
Boolean	bTrouve
Int iPos1, iPos2

iRet = 1

lTotLig = idwFicFourn.RowCount ()
lTotArt = idwArtSpb.RowCount ()
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sTypArtSav = ""

// JFF 20/01/2011 : le tri imp$$HEX1$$e900$$ENDHEX$$ratif sur ID_REF_FOUR $$HEX1$$e900$$ENDHEX$$tait visiblement manquant (?..)
idwFicFourn.SetSort ( "ID_REF_FOUR A" )
idwFicFourn.Sort ()

sIdRefFourPrec = ""

For lCpt = 1 To lTotLig 

	/*------------------------------------------------------------------*/
	/* ZONE 1 : ID_FOUR                                                */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone fournisseur est vide." )
	End If 

	If sVal <> sIdFour Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fournisseur " + sVal + " ne correspond pas au fournisseur s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$" + sIdFour )
	End If 

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La longueur du fournisseur doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If
	
	/*------------------------------------------------------------------*/
	/* ZONE 2 : ID_TYP_ART                                              */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_TYP_ART" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Type Article est vide." )
	End If 

	// Le fichier ne doit que contenir que des appareils du m$$HEX1$$ea00$$ENDHEX$$me type
	// #2 [DCMP090615]
	/*
	If sTypArtSav <> sVal And sTypArtSav <> "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fichier contient des types d'appareils diff$$HEX1$$e900$$ENDHEX$$rents !" )
	End If
	*/
	// :#2 [DCMP090615]

	If Not IsNull ( sVal ) And sVal <> "" Then
	  sTypArtSav = sVal
	End If

	bTrouve = False
	lCptVal = 1
	Do While Not bTrouve And lCptVal <= lTotArt
		bTrouve = sVal = Upper ( idwArtSpb.GetItemString ( lCptVal, "ID_CODE" ) )
		lCptVal ++
	Loop

	If Not bTrouve Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type d'article " + sVal + " n'existe pas dans la base SIMPA2.")
	End If

	If Len ( sVal ) > 3 Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le type de l'article doit $$HEX1$$ea00$$ENDHEX$$tre sur 3 caract$$HEX1$$e800$$ENDHEX$$res." )
	End If		

	/*------------------------------------------------------------------*/
	/* ZONE 3 : ID_MARQ_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MARQ_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Marque Article est vide." )
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 4 : ID_MODL_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MODL_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone mod$$HEX1$$e800$$ENDHEX$$le article est vide." )
	Else

		If Pos ( sVal, "'", 1 ) > 0 Then
//			This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (ID_MODL_ART) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "ID_MODL_ART", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 5 : MT_PRIX_HT															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemDecimal ( lCpt, "MT_PRIX_HT" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Prix Hors Taxe est vide." )
	End If 

	lLen = Len ( sVal )
	
	// Marque la virgule
	bTrouve = False

	For lCptVal = 1 To lLen 
		sCar = Mid ( sVal, lCptVal, 1 )
		If sCar = "." Then
			If Not bTrouve Then 
				bTrouve = True
			Else
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, il y a deux virgules." )
				Exit
			End If

		Else
			If Not ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) Then
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, un caract$$HEX1$$e800$$ENDHEX$$re n'est pas un chiffre." )
				Exit
			End If
		End If
	Next	

	If Real ( sVal ) > 5000 Then		
		This.uf_Trace ( "ECR", "AVERTISSEMENT ligne " + String ( lCpt ) + &
		" : Le montant " + sVal + " para$$HEX1$$ee00$$ENDHEX$$t anormalement grand." )
	End If

	
	/*------------------------------------------------------------------*/
	/* ZONE 6 : UNT_MONNAIE															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "UNT_MONNAIE" ) ) )
	// [SUISSE].LOT3 Controle de la monnaie du fichier
	// Si pas de coh$$HEX1$$e900$$ENDHEX$$rence : erreur bloquante d'int$$HEX1$$e900$$ENDHEX$$gration.
	if uf_controler_monnaie_fichier (sVal, lCpt) < 0 Then iRet = -1
	
//	If IsNull ( sVal ) Or sVal = "" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : L'unit$$HEX2$$e9002000$$ENDHEX$$de la monnaie est vide." )
//	End If 
//
//	If sVal <> "FRF" And sVal <> "EUR" Then
//		iRet = -1
//		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
//		" : La monnaie " + sVal + " n'est pas valide." )
//		Exit
//	End If

	/*------------------------------------------------------------------*/
	/* ZONE 7 : QT_DISP																  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( String ( idwFicFourn.GetItemNumber ( lCpt, "QT_DISP" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		idwFicFourn.SetItem ( lCpt, "QT_DISP", 0 ) 
		sVal = "0"
	End If 

	If Not IsNumber ( sVal ) Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La quantit$$HEX2$$e9002000$$ENDHEX$$" + sVal + " n'est pas valide, ce n'est pas un nombre." )
		
	End If

	/*------------------------------------------------------------------*/
	/* ZONE 8 : OBSERV_FRN 															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )

	If Not IsNull ( sVal ) And sVal <> "" Then
		If Pos ( sVal, "'", 1 ) > 0 Then
			// This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (OBSERV_FRN) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "OBSERV_FRN", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

		// [VDOC25657]
		// [PM471-1] si besoin de reporter sur autre frn
	If Pos ( sVal, "[#GR#" ) > 0 Then
		sVal = Mid ( sVal, Pos ( sVal, "[#GR#" ) + 5, 1 ) 
		If Not IsNumber ( sVal ) Then 
			iRet = -1
			If IsNull ( sVal ) Then sVal = "'vide'"
			This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" (vDoc25657) : La valeur " + sVal + " n'est pas autoris$$HEX1$$e900$$ENDHEX$$e pour le mot cl$$HEX2$$e9002000$$ENDHEX$$[#GR#]. La valeur doit $$HEX1$$ea00$$ENDHEX$$tre num$$HEX1$$e900$$ENDHEX$$rique entre 0 et 9." )
		End If 
	End If 

	// [PM471-1]
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )
	
	If Pos ( sVal, "[#RSASS#" ) > 0 Then
		iPos1 = Pos ( sVal, "[#RSASS#" )
		iPos2 = Pos ( sVal, "#]", iPos1 )
		sVal = Mid ( sVal, iPos1 + 8, iPos2 - ( iPos1 + 8 ) ) 
		If IsNull ( sVal ) Then sVal = "'vide'"
		
		Choose Case sVal
			Case "AIG", "CARDIF", "PACIFICA", "PARISIENNE", "AMTRUST", "DAS"  // D$$HEX1$$e900$$ENDHEX$$finir ici les autres assureurs
				// OK
			Case Else
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
					" (PM471-1) : La valeur " + sVal + " n'est pas autoris$$HEX1$$e900$$ENDHEX$$e pour le mot cl$$HEX2$$e9002000$$ENDHEX$$[#RSASS#]. La valeur doit $$HEX1$$ea00$$ENDHEX$$tre un libell$$HEX2$$e9002000$$ENDHEX$$assureur donn$$HEX2$$e9002000$$ENDHEX$$par SPB." )
		End CHoose 
			
	End If 
	
	/*------------------------------------------------------------------*/
	/* ZONE 1 BIS : ID_REF_FOUR													  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur est vide." )
	ElseIf sIdRefFourPrec <> "" And sVal = sIdRefFourPrec Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sVal + " n'est pas unique." )
		
	End If



	sIdRefFourPrec = sVal

Next

If iRet < 0 Then This.uf_Trace ( "ECR", "ERREUR : Le fichier fournisseur n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$.")

Return iRet


end function

private function integer uf_integration_fichier_agora_place (string ascas, ref long alnblig, ref long alnbinsert, ref long alnbdelete);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Integration_Fichier_AGORA_PLACE (PRIVATE)
//* Auteur			: JFF
//* Date				: 17/09/2018
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Int$$HEX1$$e900$$ENDHEX$$gration du fichier AGORA PLACE dans la base
//* Commentaires	: //[PM444-1]
//*
//* Arguments		: Long		alNbLig		Ref
//*					  Long		alNbInsert	Ref
//*					  Long		alNbDelete	Ref
//*					  String 	asCas			Val
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------

Int iRet
Long	lTotLigFourn, lRow, lCount, lCpt, lTotLigArticle
String	sIdFour, sIdRefFour, sIdTypArt, sIdMarqArt, sIdModlArt, sUntMonnaie, sNull, sIdMqIfr, sIdModlIfr, sIdTypArtRef, sSql
String sIdMarqArtIFr , sIdModlArtIFr 
Decimal {2}	dcTvaParDefaut, dcMtPrixLog 
Boolean bBaseEuro, bInsert
Decimal {2} dcPrixHt
DateTime dt

iRet = 1
alNbInsert = 0
alNbDelete = 0
SetNull ( sNull )

// [DT_60_AUGM_TVA] 1.196
dcTvaParDefaut = 0 // Le prix est net TTC, pas de tva $$HEX2$$e0002000$$ENDHEX$$ajouter

dt = DateTime ( Today (), Now () )

/*------------------------------------------------------------------*/
/* Article de R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence pour le filtre sur l'existant en base       */
/*------------------------------------------------------------------*/
//* #2 [DCMP090615]
// sIdTypArtRef = Upper ( Trim ( idwFicFourn.GetItemString ( 1, "ID_TYP_ART"  ) ) )
//* :#2 [DCMP090615]

idwArticle.Reset ()

// [SUISSE].LOT3 Suppression mecanique conversion $$HEX2$$e0002000$$ENDHEX$$l'integration article
///*------------------------------------------------------------------*/
///* Euro ou Frf ?                                                    */
///*------------------------------------------------------------------*/
//lCount = 0
//SELECT Count (*)
//INTO	 :lCount
//FROM   sysadm.parametre
//WHERE  ref_cpt = 'EURO'
//USING  SQLCA ;
//		
//bBaseEuro = lCount > 0 	

/*------------------------------------------------------------------*/
/* Chargement de la table actuelle                                  */
/*------------------------------------------------------------------*/
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )

If asCas = "1ER_TOUR" Then
	idwArticle.Retrieve ( sIdFour, "*" )
End If

/*------------------------------------------------------------------*/
/* Nbre de ligne dans le fichier                                    */
/*------------------------------------------------------------------*/
lTotLigFourn = idwFicFourn.RowCount ()

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table                                      */
/*------------------------------------------------------------------*/
lTotLigArticle = idwArticle.RowCount ()

/*------------------------------------------------------------------*/
/* Initilisation de la trace d'int$$HEX1$$e900$$ENDHEX$$gration.                         */
/*------------------------------------------------------------------*/
If asCas = "1ER_TOUR" Then
	This.uf_Trace_2 ( "INIT", 0, sIdFour, "", "", "", "" )
End If

/*------------------------------------------------------------------*/
/* MAJ de la DW avec le fichier.                                    */
/*------------------------------------------------------------------*/
For alNbLig = 1 To lTotLigFourn

	sIdFour 	   = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_FOUR"    ) ) )
	sIdTypArt 	= Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_TYP_ART"  ) ) )
	sIdMarqArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MARQ_ART" ) ) )
	sIdModlArt  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MODL_ART" ) ) )
	sIdRefFour  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_REF_FOUR" ) ) )

	If asCas = "1ER_TOUR" Then

		lRow = idwArticle.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
										 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
										 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
										 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
										 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
										 1, idwArticle.RowCount () )
	
		If lRow <= 0 Then 
			bInsert = True
			lRow = idwArticle.InsertRow ( 0 )
			alNbInsert ++
			idwArticle.SetItem ( lRow, "ID_FOUR", 	 sIdFour	  )				
			idwArticle.SetItem ( lRow, "ID_REF_FOUR",  sIdRefFour  )				
			idwArticle.SetItem ( lRow, "ID_TYP_ART",	 sIdTypArt	  )				
			idwArticle.SetItem ( lRow, "ID_MARQ_ART",	 sIdMarqArt	  )				
			idwArticle.SetItem ( lRow, "ID_MODL_ART",	 sIdModlArt	  )				
			idwArticle.SetItem ( lRow, "ALT_DISPO",	 "N"	 )				
			idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR",	 sNull )				
			idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR",	 sNull )				
			idwArticle.SetItem ( lRow, "TVA", dcTvaParDefaut )		
			idwArticle.SetItem ( lRow, "CREE_LE", dt )		
		Else
			bInsert = False
		End If
	
		If lRow > 0 Then 
	
			// #1 [SUISSE].LOT3
			dcPrixHt = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_HT" )
			idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								
			// :#1
	
	
			/*------------------------------------------------------------------*/
			/* Code $$HEX1$$e900$$ENDHEX$$tat (-EI)                                                  */
			/* 200 Nouveau                                                      */
			/* 100 MAj_Ok sur existant                                          */
			/*------------------------------------------------------------------*/
			If bInsert Then
				idwArticle.SetItem ( lRow, "COD_ETAT", 200 )		
				This.uf_Trace_2 ( "ECR_AUTO", 200, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
			Else
				idwArticle.SetItem ( lRow, "COD_ETAT", 100 )		
				sIdMqIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MARQ_ART_IFR" ) )
				sIdModlIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MODL_ART_IFR" ) )
	
				/*------------------------------------------------------------------*/
				/* Si les marques et mod$$HEX1$$e800$$ENDHEX$$les IFR sont absent de l'enregistrement    */
				/* exisant, on force ALT_DIPSPO $$HEX2$$e0002000$$ENDHEX$$NON.                              */
				/*------------------------------------------------------------------*/
				If Isnull ( sIdMqIfr ) Or sIdMqIfr = "" Or Isnull ( sIdModlIfr ) Or sIdModlIfr = "" Then
					idwArticle.SetItem ( lRow, "ALT_DISPO", "N" )				
				End If
	
				This.uf_Trace_2 ( "ECR_AUTO", 100, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
			End If

			// [VDOC6846]
			Choose Case sIdTypArt 
				Case "TEL", "PC1", "PC2" 
					// Doit $$HEX1$$ea00$$ENDHEX$$tre mis $$HEX2$$e0002000$$ENDHEX$$la main pas Cell. Parte.
					// [VDOC6993]
					If bInsert Then
						sIdMarqArtIFr = Space (35) 
						sIdModlArtIFr = Space (35) 
						SQLCA.PS_S_VDOC6993_LIEN_ARTICLE ( sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, sIdMarqArtIFr, sIdModlArtIFr ) 
						If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) Then
							idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR", sIdMarqArtIFr )				
						End If
						
						If Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
							idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR", sIdModlArtIFr )				
						End If
						
						If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) And &
							Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
							idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
						End If
					End If					
				Case Else
					idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
			End Choose
			// :[VDOC6846]
		
			idwArticle.SetItem ( lRow, "QT_DISP", idwFicFourn.GetItemNumber ( alNbLig, "QT_DISP" ) )

			// [VDOC21822]
			idwArticle.SetItem ( lRow, "OBSERV_FRN", Upper ( idwFicFourn.GetItemString ( alNbLig, "OBSERV_FRN" ) ) )

			idwArticle.SetItem ( lRow, "VERROU", 1 )
			idwArticle.SetItem ( lRow, "MAJ_LE", dt )		
			idwArticle.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )		
	
		End If
	End If
	
// Maj det_article pour le prix_log
	If asCas = "2EME_TOUR" Then

		dcMtPrixLog = idwFicFourn.GetItemDecimal ( alNbLig, "MT_PRIX_LOG" )

		lRow = SQLCA.PS_S01_DET_ARTICLE_TEST_PRESENCE ( sIdFour, sIdRefFour) 

		// On n'int$$HEX1$$e900$$ENDHEX$$gre que certaines c$$HEX1$$e900$$ENDHEX$$t$$HEX1$$e900$$ENDHEX$$gorie.
		If lRow <= 0 Then 
		
			sSql  = "Exec sysadm.DW_I01_DET_ARTICLE "
			sSql += "'" + sIdFour + "'," 
			sSql += "'" + sIdRefFour + "',"
			sSql += "'-1',"
			sSql += "'LOG',"
			sSql += "'" + String ( dcMtPrixLog  ) + "'"
	
			F_Execute ( sSql, SQLCA )
		Else 

			sSql  = "Exec sysadm.DW_U01_DET_ARTICLE "
			sSql += "'" + sIdFour + "'," 
			sSql += "'" + sIdRefFour + "',"
			sSql += "'-1',"
			sSql += "'LOG',"
			sSql += "'" + String ( dcMtPrixLog ) + "'"

			F_Execute ( sSql, SQLCA )
		End If
	End If	
	
Next

/*------------------------------------------------------------------*/
/* Nbre de ligne dans la Table (r$$HEX1$$e900$$ENDHEX$$actualis$$HEX1$$e900$$ENDHEX$$)                        */
/*------------------------------------------------------------------*/
If asCas = "1ER_TOUR" Then
	lTotLigArticle = idwArticle.RowCount ()
	
	/*------------------------------------------------------------------*/
	/* Suppression des lignes pr$$HEX1$$e900$$ENDHEX$$sentes dans la table articles et       */
	/* absentes du fichier.                                             */
	/*------------------------------------------------------------------*/
	For lCpt = lTotLigArticle To 1 Step -1
	
		sIdFour 	   = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_FOUR"    ) ) )
		sIdTypArt 	= Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_TYP_ART"  ) ) )
		sIdMarqArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MARQ_ART" ) ) )
		sIdModlArt  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_MODL_ART" ) ) )
		sIdRefFour  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )
	
		lRow = idwFicFourn.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
										 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
										 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "' And " + &
										 "UPPER ( TRIM ( ID_MARQ_ART ))= '" + sIdMarqArt   + "' And " + &
										 "UPPER ( TRIM ( ID_MODL_ART ))= '" + sIdModlArt   + "'", &
										 1, idwFicFourn.RowCount () )
	
		If lRow <= 0 Then 

			sSql  = "Exec sysadm.DW_D01_DET_ARTICLE "
			sSql += "'" + sIdFour + "'," 
			sSql += "'" + sIdRefFour + "'"
		
			F_Execute ( sSql, SQLCA )
			
			alNbDelete ++
			idwArticle.DeleteRow ( lCpt )
			This.uf_Trace_2 ( "ECR_AUTO", 300, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		End If
	
	Next 
End If 

idwArticle.SetFilter ( "" )
idwArticle.Filter ()

return iRet 
end function

private function integer uf_ctrl_fichier_cdiscountpro ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Ctrl_Fichier_CDISCOUNTPRO (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 16/04/2008
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controler de la validit$$HEX2$$e9002000$$ENDHEX$$du fichier de ALAPAGE
//* Commentaires	: [DCMP090102]
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*       JFF    13/04/2012  [ITSM112677]
//        JFF    21/03/2016  [PM289-3]
//        JFF    10/02/2020  [PM289-5]
//			 JFF    09/03/2020  [VDOC29116] Demande d'H$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e800$$ENDHEX$$ne, les erreurs ne sont plus bloquantes,
//							 	     On les signale, mais on ne bloque pas.
//*-----------------------------------------------------------------

Int iRet 
String	sIdFour, sVal, sCar, sSort, sIdRefFourPrec, sTypArtSav, sVal2
Long		lTotLig, lCpt, lCptVal, lTotArt, lLen, lDeb
Decimal  {5} dcVal // [PM289-3]
Boolean	bTrouve


iRet = 1

lTotLig = idwFicFourn.RowCount ()
lTotArt = idwArtSpb.RowCount ()
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )
sTypArtSav = ""

// JFF 20/01/2011 : le tri imp$$HEX1$$e900$$ENDHEX$$ratif sur ID_REF_FOUR $$HEX1$$e900$$ENDHEX$$tait visiblement manquant (?..)
idwFicFourn.SetSort ( "ID_REF_FOUR A" )
idwFicFourn.Sort ()

sIdRefFourPrec = ""


For lCpt = 1 To lTotLig 

	/*------------------------------------------------------------------*/
	/* ZONE 1 BIS : ID_REF_FOUR													  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence fournisseur est vide." )
	ElseIf sIdRefFourPrec <> "" And sVal = sIdRefFourPrec Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence " + sVal + " n'est pas unique." )
		
	End If

	sIdRefFourPrec = sVal
	
	
	/*------------------------------------------------------------------*/
	/* ZONE 2 : ID_TYP_ART                                              */
	/*------------------------------------------------------------------*/
	// !! Pas d'upper volontairement, tr$$HEX1$$e800$$ENDHEX$$s important.
	// [PM289-3]
	sVal = Trim ( idwFicFourn.GetItemString ( lCpt, "ID_CTG3" ) )		

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Type Article est vide." )
	End If 

	// Le fichier ne doit que contenir que des appareils du m$$HEX1$$ea00$$ENDHEX$$me type
/* Pas pour CDP !
	If sTypArtSav <> sVal And sTypArtSav <> "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : Le fichier contient des types d'appareils diff$$HEX1$$e900$$ENDHEX$$rents !" )
	End If

	If Not IsNull ( sVal ) And sVal <> "" Then
	  sTypArtSav = sVal
	End If
*/

	sVal2 = This.uf_correspondance_code ( sIdFour, "ID_TYP_ART", sVal )
	If sVal2 = "" Then
	
		Continue
	End If
	
	/*------------------------------------------------------------------*/
	/* ZONE 3 : ID_MARQ_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MARQ_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Marque Article est vide." )
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 4 : ID_MODL_ART															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( Left ( idwFicFourn.GetItemString ( lCpt, "ID_MODL_ART" ), 35 ) ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone mod$$HEX1$$e800$$ENDHEX$$le article est vide." )
	Else

		If Pos ( sVal, "'", 1 ) > 0 Then
//			This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (ID_MODL_ART) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "ID_MODL_ART", F_Remplace ( sVal, "'", " " ) )
		End If
		
		// [ITSM112677] JFF 13/04/12
		If Pos ( sVal, '"', 1 ) > 0 Then
//			This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (ID_MODL_ART) Les double quote d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des P" )
			idwFicFourn.SetItem ( lCpt, "ID_MODL_ART", F_Remplace ( sVal, '"', "P" ) )
		End If
		
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 5 : MT_PRIX_HT															  */
	/*------------------------------------------------------------------*/
	// [PM289-5]
	sVal = Trim ( idwFicFourn.GetItemString ( lCpt, "MT_PRIX_HT" ) )
	sVal = F_Remplace ( sVal, ",", "." ) 
	
	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone Prix Hors Taxe est vide." )
	End If 

	lLen = Len ( sVal )
	
	// Marque la virgule
	bTrouve = False

	For lCptVal = 1 To lLen 
		sCar = Mid ( sVal, lCptVal, 1 )
		If sCar = "." Then
			If Not bTrouve Then 
				bTrouve = True
			Else
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, il y a deux virgules." )
				Exit
			End If

		Else
			If Not ( Asc ( sCar ) >= 48 And Asc ( sCar ) <= 57 ) Then
				iRet = -1
				This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
				" : Le montant " + sVal + " n'est pas valide, un caract$$HEX1$$e800$$ENDHEX$$re n'est pas un chiffre." )
				Exit
			End If
		End If
	Next	

	If Real ( sVal ) > 5000 Then		
		This.uf_Trace ( "ECR", "AVERTISSEMENT ligne " + String ( lCpt ) + &
		" : Le montant " + sVal + " para$$HEX1$$ee00$$ENDHEX$$t anormalement grand." )
	End If


	/*------------------------------------------------------------------*/
	/* ZONE 8 : OBSERV_FRN 															  */
	/*------------------------------------------------------------------*/
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "OBSERV_FRN" ) ) )

	If Not IsNull ( sVal ) And sVal <> "" Then
		If Pos ( sVal, "'", 1 ) > 0 Then
//			This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (OBSERV_FRN) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "OBSERV_FRN", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 

	/*------------------------------------------------------------------*/
	/* ZONE 9 : Fiche_produit 														  */
	/*------------------------------------------------------------------*/
/*
	sVal = Trim ( Upper ( idwFicFourn.GetItemString ( lCpt, "FICHE_PRODUIT" ) ) )

	If Not IsNull ( sVal ) And sVal <> "" Then
		If Pos ( sVal, "'", 1 ) > 0 Then
//			This.uf_Trace ( "ECR", "INFO ligne " + String ( lCpt ) + " : (FICHE PRODUIT) Les apostrophes d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$substitu$$HEX1$$e900$$ENDHEX$$s par des blancs" )
			idwFicFourn.SetItem ( lCpt, "FICHE_PRODUIT", F_Remplace ( sVal, "'", " " ) )
		End If
	End If 
*/

	/*------------------------------------------------------------------*/
	/* ZONE  : indication stock													  */
	/*------------------------------------------------------------------*/
	// [PM289-5]
	sVal = Trim ( idwFicFourn.GetItemString  ( lCpt, "INDICATION_STOCK" ) )

	If IsNull ( sVal ) Or sVal = "" Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone INDICATION_STOCK est vide." )
	End If 
	
	If sVal <> "" And Not IsNumber ( sVal )  Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : La zone INDICATION_STOCK doit $$HEX1$$ea00$$ENDHEX$$tre un nombre." )
	End If 
		

	/*------------------------------------------------------------------*/
	/* ZONE  : REMISE																	  */
	/*------------------------------------------------------------------*/
	// [PM289-5]
	sVal = Trim ( idwFicFourn.GetItemString  ( lCpt, "REMISE" ) )	
	sVal = F_Remplace ( sVal, ",", "." ) 
	
	If Not IsNull ( sVal ) And sVal <> "" Then
		If Not IsNumber ( sVal ) Then
			iRet = -1
			This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
			" : La remise doit $$HEX1$$ea00$$ENDHEX$$tre un montant (donc un nombre, $$HEX1$$e900$$ENDHEX$$ventuellement d$$HEX1$$e900$$ENDHEX$$cimal)" )
		End IF 
	End If 		

/*------------------------------------------------------------------*/
/* ZONE  : ID_CTG3																  */
/*------------------------------------------------------------------*/
	sVal = Trim ( idwFicFourn.GetItemString ( lCpt, "ID_CTG3" ))
	If Not IsNumber ( sVal ) Then
		iRet = -1
		This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
		" : L'ID Cat$$HEX1$$e900$$ENDHEX$$gorie3 doit $$HEX1$$ea00$$ENDHEX$$tre un num$$HEX1$$e900$$ENDHEX$$rique" )
	End If 

	If IsNumber ( sVal ) Then
		If Long ( sVal ) < 0 Then 
			iRet = -1
			This.uf_Trace ( "ECR", "ERREUR ligne " + String ( lCpt ) + &
			" : L'ID Cat$$HEX1$$e900$$ENDHEX$$gorie3 doit $$HEX1$$ea00$$ENDHEX$$tre un num$$HEX1$$e900$$ENDHEX$$rique strictement positif" )
		End If 
	End If 


	// [VDOC29116]
	If iRet = -1 Then
		idwFicFourn.SetItem ( lCpt, "ID_REF_FOUR", "A_SUPPRIMER" ) 
		iRet = 1
	End If 

Next

// [VDOC29116]
idwFicFourn.SetFilter ( "ID_REF_FOUR = 'A_SUPPRIMER'" ) 
idwFicFourn.Filter ( )

If idwFicFourn.RowCount() > 0 Then
	iRet = -1
	This.uf_Trace ( "ECR", "SUCCES : Des erreurs ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$es, les lignes en erreurs ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$supprim$$HEX1$$e900$$ENDHEX$$es et le fichier est tout de m$$HEX1$$ea00$$ENDHEX$$me trait$$HEX1$$e900$$ENDHEX$$.")
	idwFicFourn.RowsDiscard ( 1, idwFicFourn.RowCount(), Primary!)
End If 

idwFicFourn.SetFilter ( "" ) 
idwFicFourn.Filter ( )
idwFicFourn.Sort ( )

Return iRet


end function

private function integer uf_integration_fichier_cdiscountpro (string ascas, ref long alnblig, ref long alnbinsert, ref long alnbdelete);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_pg_in_fic_article::uf_Integration_Fichier_CDISCOUNTPRO (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 18/09/2007
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Int$$HEX1$$e900$$ENDHEX$$gration du fichier CDISCOUNTPRO dans la base
//* Commentaires	: 18/09/2007 [DCMP090102]
//*
//* Arguments		: String		asCas			Val  "1ER_TOUR", "2EME_TOUR"
//*					  Long		alNbLig		Ref
//*					  Long		alNbInsert	Ref
//*					  Long		alNbDelete	Ref
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1    JFF    10/03/2008  Modif suite Bug [SUISSE].LOT3
//* 		 JFF    09/08/2012  Ajout du montant des frais de transport dans le montant Hors Taxe de l'article  
//*       JFF    20/11/2012  [PC869][NDCV10]
//        JFF    19/11/2013  [DT_60_AUGM_TVA]
//        JFF    02/03/2015  [PM289_CDP]
//        JFF    08/12/2015  [PM289-2]
//        JFF    21/03/2016  [PM289-3]
//        JFF    05/09/2016  [PM371-1]
//        JFF    21/09/2016  [VDOC21822] 
//        JFF    10/02/2020  [PM289-5]
//*-----------------------------------------------------------------

Int iRet, iPos1, iPos2, iNbreDiese, iTot1, iCpt2, iCptRef 
Long	lTotLigFourn, lRow, lCount, lCpt, lTotLigArticle, lCptPM289_3, lDeb, lFin
String	sIdFour, sIdRefFour, sIdTypArt, sIdMarqArt, sIdModlArt, sIdModlArt1, sSql, sVal, sIdCtg3 
String   sUntMonnaie, sNull, sIdMqIfr, sIdModlIfr, sIdTypArtRef, sMediaCode, sCategoryCode, sFiltreOrig 
String sIdMarqArtIFr , sIdModlArtIFr, sIdTypArtSav, sIdRefFourRacine, sIdCtg2, sIndicationStock
Decimal {2}	dcTvaParDefaut, dcEcoTaxeTTC, dcRemiseTTC
Decimal {5} dcEcoTaxeHT, dcRemisePctDc
Boolean bBaseEuro, bInsert, bTrouve
Decimal {2} dcPrixHt, dcPrixHTTrsp, dcPrixHTTrspFixePM289
DateTime dt

iRet = 1
alNbInsert = 0
alNbDelete = 0
SetNull ( sNull )

// [DT_60_AUGM_TVA] 1.196
dcTvaParDefaut = 20
dcPrixHTTrspFixePM289 = 9

dt = DateTime ( Today (), Now () )

idwArticle.Reset ()


/*------------------------------------------------------------------*/
/* Chargement de la table actuelle                                  */
/*------------------------------------------------------------------*/
sIdFour = Upper ( idwFourn.GetItemString ( 1, "ID_FOURN" ) )

/*
If asCas = "1ER_TOUR" Then
	idwArticle.Retrieve ( sIdFour, "*" )
	idwArticle.Filter ()
End If 
*/

/*------------------------------------------------------------------*/
/* Nbre de ligne dans le fichier                                    */
/*------------------------------------------------------------------*/
lTotLigFourn = idwFicFourn.RowCount ()

/*------------------------------------------------------------------*/
/* Initilisation de la trace d'int$$HEX1$$e900$$ENDHEX$$gration.                         */
/*------------------------------------------------------------------*/
If asCas = "1ER_TOUR" Then
	This.uf_Trace_2 ( "INIT", 0, sIdFour, "", "", "", "" )

/*------------------------------------------------------------------*/
/* Suppression des lignes pr$$HEX1$$e900$$ENDHEX$$sentes dans la table articles et       */
/* absentes du fichier.                                             */
/*------------------------------------------------------------------*/
	F_Execute ( "Exec sysadm.PS_D01_ARTICLE_CDISCOUNTPRO", SQLCA )
End If

/*------------------------------------------------------------------*/
/* MAJ de la DW avec le fichier.                                    */
/*------------------------------------------------------------------*/
For alNbLig = 1 To lTotLigFourn

	sIdTypArt   = Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_TYP_ART"  ) )  // Surtout pas d'upper !!!
	sIdMarqArt  = Left ( Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MARQ_ART" ) ) ), 35 )

	sIdModlArt  = Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_MODL_ART" ) ) 
	sIdModlArt  = Upper ( sIdModlArt )
	sIdModlArt1  = F_REMPLACE ( sIdModlArt, sIdMarqArt, "" )
	sIdModlArt1  = F_REMPLACE ( sIdModlArt1, " - ", " " )
	sIdModlArt1  = F_REMPLACE ( sIdModlArt1, " + ", " " )
	sIdModlArt1  = F_REMPLACE ( sIdModlArt1, " / ", " " )		
	sIdModlArt1  = F_REMPLACE ( sIdModlArt1, "TABLETTE", "TAB" )		
	sIdModlArt1  = F_REMPLACE ( sIdModlArt1, "TACTILE", "TAC" )				
	sIdModlArt1  = F_REMPLACE ( sIdModlArt1, "GALAXY", "GAL" )						
	sIdModlArt1  = F_REMPLACE ( sIdModlArt1, "STOCKAGE", "STK" )		
	sIdModlArt1  = F_REMPLACE ( sIdModlArt1, "COQUE", "COQ" )		
	sIdModlArt1  = F_REMPLACE ( sIdModlArt1, "ANDROID", "ANDR" )		
	sIdModlArt1  = F_REMPLACE ( sIdModlArt1, "G$$HEX1$$c900$$ENDHEX$$N$$HEX1$$c900$$ENDHEX$$RATION", "GEN" )		
	sIdModlArt1  = F_REMPLACE ( sIdModlArt1, "CELLULAR", "CELL" )		
	sIdModlArt1  = F_REMPLACE ( sIdModlArt1, "CELLULAIRE", "CELL" )		
	sIdModlArt1  = F_REMPLACE ( sIdModlArt1, "NOUVEAU", "" )		
	sIdModlArt1  = F_REMPLACE ( sIdModlArt1, "BLUETOOTH", "BLUETH")		
	sIdModlArt1  = F_REMPLACE ( sIdModlArt1, "RETINA", "RETI")		
	
	
	
	sIdModlArt  = Right ( sIdModlArt1, 35 )
	sIdModlArt1 = Left ( sIdModlArt1, 35 ) // servira plus bas $$HEX2$$e0002000$$ENDHEX$$coller dans le commentaire
	
	sIdRefFour  = Upper ( Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_REF_FOUR" ) ) )
	sIdRefFourRacine = sIdRefFour  // [PM289-3]
	
	
	// [PM289-5]
	sIndicationStock = Trim ( idwFicFourn.GetItemString ( alNbLig, "INDICATION_STOCK"  ) )
	

	// [PM289-2]
	// [PM289-3]
	sIdCtg3 = Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_CTG3"  ) )
	sIdTypArt = sIdCtg3
	dcEcoTaxeTTC = 0 // On ne tient plus compte de l'$$HEX1$$e900$$ENDHEX$$cotaxe, elle est $$HEX2$$e0002000$$ENDHEX$$pr$$HEX1$$e900$$ENDHEX$$sent comprise dans le TTC.

	// [PM289-5]
	sVal = idwFicFourn.GetItemString ( alNbLig, "REMISE" )
	sVal = F_Remplace ( sVal, ",", "." )
	dcRemiseTTC = 0 
	If IsNumber ( sVal ) Then
		dcRemiseTTC = Dec ( sVal )	
		If IsNull ( dcRemiseTTC ) Then dcRemiseTTC = 0
	End If 
	
	dcEcoTaxeHT  = dcEcoTaxeTTC / ( 1 + dcTvaParDefaut / 100 )


	If asCas = "1ER_TOUR" Then
		
		sIdTypArt = This.uf_correspondance_code ( sIdFour, "ID_TYP_ART", sIdTypArt )
		sIdTypArtSav = sIdTypArt // [PM289-3]
		
		If sIdTypArt = "" Then
			continue
		End If

		// [PM289-3]
		
		iNbreDiese = 0
		iTot1 = Len ( sIdTypArtSav )
		For iCpt2 = 1 To iTot1 
			If Mid ( sIdTypArtSav, iCpt2, 1 ) = "#" Then
				iNbreDiese ++ 
			End If
		Next

		// [PM289-3]
		iCptRef = 0
		Do While Len ( sIdTypArtSav ) > 0 
	
			// [PM289-3]
			iPos1 = Pos ( sIdTypArtSav, "#", 1 )
			iPos2 = Pos ( sIdTypArtSav, "#", iPos1 + 1 )
			sIdTypArt = Mid ( sIdTypArtSav, iPos1 + 1, iPos2 - iPos1 - 1 )
			sIdTypArtSav = Right ( sIdTypArtSav, Len ( sIdTypArtSav ) - iPos2 + 1 )
			If sIdTypArtSav = "#" Then sIdTypArtSav = ""
			
			If iNbreDiese > 0 Then
				iCptRef ++
				sIdRefFour = sIdRefFourRacine + "_" + String ( iCptRef )
			End If
	
			lRow = 0
			If sIdTypArt = "TEL" Then 
				lRow = idwArticle.Find ( "UPPER ( TRIM ( ID_FOUR ))    = '" + sIdFour 		+ "' And " + &
												 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
												 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "'", &
												 1, idwArticle.RowCount () )
			End If
	
			// On n'int$$HEX1$$e900$$ENDHEX$$gre que certaines c$$HEX1$$e900$$ENDHEX$$t$$HEX1$$e900$$ENDHEX$$gorie.
			If lRow <= 0 Then 
				bInsert = True
				lRow = idwArticle.InsertRow ( 0 )
				alNbInsert ++
				idwArticle.SetItem ( lRow, "ID_FOUR", 	 sIdFour	  )				
				idwArticle.SetItem ( lRow, "ID_REF_FOUR",  sIdRefFour  )				
				idwArticle.SetItem ( lRow, "ID_TYP_ART",	 sIdTypArt	  )				
				idwArticle.SetItem ( lRow, "ID_MARQ_ART",	 sIdMarqArt	  )				
				idwArticle.SetItem ( lRow, "ID_MODL_ART",	 sIdModlArt	  )				
				idwArticle.SetItem ( lRow, "ALT_DISPO",	 "N"	 )				
				idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR",	 sNull )				
				idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR",	 sNull )				
				idwArticle.SetItem ( lRow, "TVA", dcTvaParDefaut )		
				idwArticle.SetItem ( lRow, "CREE_LE", dt )		
			Else
				bInsert = False
			End If			
	
			// #1 [SUISSE].LOT3
			// [PM289-5]
			sVal = idwFicFourn.GetItemString ( alNbLig, "MT_PRIX_HT" )
			sVal = F_Remplace ( sVal, ",", "." )
			dcPrixHt = Dec ( sVal  )				
			
			// [PM289-3]
			// [PM289-5]
			// Mail H$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e800$$ENDHEX$$ne le 11/02/2020 08:59
			If dcRemiseTTC > 0 Then dcPrixHt = dcRemiseTTC 
			
			// [VDOC8076] // [PM289_CDP]
			dcPrixHt += dcPrixHTTrspFixePM289
	
			// [PM289-2]
			dcPrixHt += dcEcoTaxeHT 
					
			idwArticle.SetItem ( lRow, "MT_PRIX_HT", dcPrixHt   )								
			// :#1
		
			/*------------------------------------------------------------------*/
			/* Code $$HEX1$$e900$$ENDHEX$$tat (-EI)                                                  */
			/* 200 Nouveau                                                      */
			/* 100 MAj_Ok sur existant                                          */
			/*------------------------------------------------------------------*/
			If bInsert Then
				idwArticle.SetItem ( lRow, "COD_ETAT", 200 )		
		//		This.uf_Trace_2 ( "ECR_AUTO", 200, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
			Else
				idwArticle.SetItem ( lRow, "COD_ETAT", 100 )		
				sIdMqIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MARQ_ART_IFR" ) )
				sIdModlIfr = Trim ( idwArticle.GetItemString  ( lRow, "ID_MODL_ART_IFR" ) )
		
				/*------------------------------------------------------------------*/
				/* Si les marques et mod$$HEX1$$e800$$ENDHEX$$les IFR sont absent de l'enregistrement    */
				/* exisant, on force ALT_DIPSPO $$HEX2$$e0002000$$ENDHEX$$NON.                              */
				/*------------------------------------------------------------------*/
				If Isnull ( sIdMqIfr ) Or sIdMqIfr = "" Or Isnull ( sIdModlIfr ) Or sIdModlIfr = "" Then
					idwArticle.SetItem ( lRow, "ALT_DISPO", "N" )				
				End If
		
		//		This.uf_Trace_2 ( "ECR_AUTO", 100, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
			End If
	
			// [VDOC6993]
			Choose Case sIdTypArt 
				Case "TEL", "PC1", "PC2" 
					// Doit $$HEX1$$ea00$$ENDHEX$$tre mis $$HEX2$$e0002000$$ENDHEX$$la main pas Cell. Parte.
					// [VDOC6993]
					If bInsert Then
						sIdMarqArtIFr = Space (35) 
						sIdModlArtIFr = Space (35) 
						SQLCA.PS_S_VDOC6993_LIEN_ARTICLE ( sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, sIdMarqArtIFr, sIdModlArtIFr ) 
						If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) Then
							idwArticle.SetItem ( lRow, "ID_MARQ_ART_IFR", sIdMarqArtIFr )				
						End If
						
						If Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
							idwArticle.SetItem ( lRow, "ID_MODL_ART_IFR", sIdModlArtIFr )				
						End If
						
						If Trim ( sIdMarqArtIFr ) <> "" And Not IsNull ( sIdMarqArtIFr ) And &
							Trim ( sIdModlArtIFr ) <> "" And Not IsNull ( sIdModlArtIFr ) Then
							idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
						End If
					End If					
				Case Else
					idwArticle.SetItem ( lRow, "ALT_DISPO", "O" )
			End Choose		
			
	
			// [PM289-5]
			idwArticle.SetItem ( lRow, "QT_DISP", Integer ( sIndicationStock ) )
	
			sVal = Upper ( idwFicFourn.GetItemString ( alNbLig, "OBSERV_FRN" ) )
	
			// [PC869][NDCV10]
			If IsNull ( sVal ) Then sVal = "" 
			sVal = "[#1F1#]" 

			// [PM371-1]
			// [VDOC21822] Ajout NEU
			sIdCtg2 = Trim ( idwFicFourn.GetItemString ( alNbLig, "ID_CTG2"  ) )
			If sIdCtg2 = "1000013432" Then
				sVal += "[#REC#]"
			Else
				sVal += "[#NEU#]"
			End If
	
			If Not IsNull ( sIdModlArt1 ) And len ( sIdModlArt1 ) > 0 Then
				If IsNull ( sVal ) Then sVal = "" 
				sVal = sVal + Left ( sIdModlArt1, 35 - Len ( sVal ) )
			End IF 
	
			idwArticle.SetItem ( lRow, "OBSERV_FRN", sVal )
			
			idwArticle.SetItem ( lRow, "VERROU", 1 )
			idwArticle.SetItem ( lRow, "MAJ_LE", dt )		
			idwArticle.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )	
			
		Loop // [PM289-3]
	End If

// Maj det_article pour le m$$HEX1$$e900$$ENDHEX$$dia code et le category code
	If asCas = "2EME_TOUR" Then

		dcPrixHTTrsp = dcPrixHTTrspFixePM289

		lRow = 0
		If sIdTypArt = "TEL" Then 
			lRow = SQLCA.PS_S01_DET_ARTICLE_TEST_PRESENCE ( sIdFour, sIdRefFour) 
		End If

		// On n'int$$HEX1$$e900$$ENDHEX$$gre que certaines c$$HEX1$$e900$$ENDHEX$$t$$HEX1$$e900$$ENDHEX$$gorie.
		If lRow <= 0 Then 
		
			sSql  = "Exec sysadm.DW_I01_DET_ARTICLE "
			sSql += "'" + sIdFour + "'," 
			sSql += "'" + sIdRefFour + "',"
			sSql += "'-1',"
			sSql += "'TRP',"
			sSql += "'" + String ( dcPrixHTTrsp ) + "'"
	
			F_Execute ( sSql, SQLCA )
			
			// [PM289-2]
			sSql  = "Exec sysadm.DW_I01_DET_ARTICLE "
			sSql += "'" + sIdFour + "'," 
			sSql += "'" + sIdRefFour + "',"
			sSql += "'-1',"
			sSql += "'ECO',"
			sSql += "'" + String ( dcEcoTaxeHT ) + "'"
	
			F_Execute ( sSql, SQLCA )
			
		Else 

			sSql  = "Exec sysadm.DW_U01_DET_ARTICLE "
			sSql += "'" + sIdFour + "'," 
			sSql += "'" + sIdRefFour + "',"
			sSql += "'-1',"
			sSql += "'TRP',"
			sSql += "'" + String ( dcPrixHTTrsp ) + "'"

			F_Execute ( sSql, SQLCA )
			
			// [PM289-2]
			sSql  = "Exec sysadm.DW_U01_DET_ARTICLE "
			sSql += "'" + sIdFour + "'," 
			sSql += "'" + sIdRefFour + "',"
			sSql += "'-1',"
			sSql += "'ECO',"
			sSql += "'" + String ( dcEcoTaxeHT ) + "'"
	
			F_Execute ( sSql, SQLCA )
			
		End If
		

		
	End If

Next


/*------------------------------------------------------------------*/
/* Suppression des lignes pr$$HEX1$$e900$$ENDHEX$$sentes dans la table articles et       */
/* absentes du fichier.                                             */
/*------------------------------------------------------------------*/
/*
If asCas = "1ER_TOUR" Then
	idwArticle.SetFilter ( "ID_TYP_ART = 'TEL'" )
	idwArticle.Filter ()
	
	lTotLigArticle = idwArticle.RowCount ()

	For lCpt = lTotLigArticle To 1 Step -1
	
		sIdFour 	   = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_FOUR"    ) ) )
		sIdTypArt 	= Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_TYP_ART"  ) ) )
		sIdRefFour  = Upper ( Trim ( idwArticle.GetItemString ( lCpt, "ID_REF_FOUR" ) ) )

		lRow = idwFicFourn.Find ( "UPPER ( TRIM ( ID_FOUR ))   = '" + sIdFour 		+ "' And " + &
										 "UPPER ( TRIM ( ID_TYP_ART )) = '" + sIdTypArt	 	+ "' And " + &
										 "UPPER ( TRIM ( ID_REF_FOUR ))= '" + sIdRefFour   + "'" , &
										 1, idwFicFourn.RowCount () )
	
		If lRow <= 0 Then 

			sSql  = "Exec sysadm.DW_D01_DET_ARTICLE "
			sSql += "'" + sIdFour + "'," 
			sSql += "'" + sIdRefFour + "'"
		
			F_Execute ( sSql, SQLCA )	
			
			alNbDelete ++
			idwArticle.DeleteRow ( lCpt )
//			This.uf_Trace_2 ( "ECR_AUTO", 300, sIdFour, sIdRefFour, sIdMarqArt, sIdModlArt, "" )
		End If
	
	Next 
End If
*/

idwArticle.SetFilter ( "" )
idwArticle.Filter ()

If asCas = "2EME_TOUR" Then
	idwArticle.Reset ()
End If

return iRet 
end function

public function long uf_charger_fichierfournhalt (long alnumligerrimport, string ascolligerrimport, string asdata);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_int_fic_article::uf_Charger_FichierFournHALT (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 18/02/2020
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Stoppe l'appli sans blocage sur la fen$$HEX1$$ea00$$ENDHEX$$tre Continue de l'importfile.
//* Commentaires	: 
//*
//* Arguments		: 
//*					  
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Int		iRet
Long     lTotLig 

iRet = 1 // C'est le 1 du return ItemError, mais $$HEX1$$e700$$ENDHEX$$a n'aura pas d'importance, je stoppe l'appli $$HEX2$$e0002000$$ENDHEX$$cet endroit

If Not gbOpCon Then Return 0

iRet = -1
lTotLig = -4
ibErrIntegr = True // [PI065]
This.uf_Trace ( "ECR", "Chargement du fichier : ERREUR IMPORTFILE (" + String ( lTotLig ) + ") ligne " + string (alNumLigErrImport) + ", colonne " + Upper ( asColLigErrImport ) + ", probl$$HEX1$$e800$$ENDHEX$$me de format de fichier, une donn$$HEX1$$e900$$ENDHEX$$e n'est pas du bon type ou est trop longue."  ) // [PI065]
This.uf_Trace ( "ECR", "Chargement du fichier : Text posant probl$$HEX1$$e800$$ENDHEX$$me : " + Trim ( asData)  ) // [PI065]

This.uf_Sortie_OpCon ( "ECR", 341, "ERR341/CHARGFICFOUR", FALSE )						

This.uf_Trace ( "ECR", "Le traitement se termine anormalement, le fichier n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$trait$$HEX2$$e9002000$$ENDHEX$$!!!." )

// idwSuiviTrt.ScrollToRow ( idwSuiviTrt.RowCount () )

If f_FileExists ( stGlb.sRepTempo + K_FICTMP ) Then FileDelete ( stGLB.sRepTempo + K_FICTMP )

This.uf_Trt_OpCon ( "FIN_TRT" )

// Test RunTime
RUN ( "taskkill /f  /im P_FR_APP_Simpa2_main_121.EXE /T", minimized! )

Return iRet
end function

public subroutine uf_set_numligerrimport (long alnumligerrimport, string ascolligerrimport, string asdataerrimport);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_int_fic_suivicmd::uf_Set_NumLigErrImport (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 07/04/2017
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//*					  retourn$$HEX2$$e9002000$$ENDHEX$$dans le fichier.
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

ilNumLigErrImport = alNumLigErrImport
isColLigErrImport = asColLigErrImport
isDataErrImport  = asDataErrImport 

end subroutine

on n_cst_int_fic_article.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_int_fic_article.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

