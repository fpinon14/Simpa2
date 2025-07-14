$PBExportHeader$n_cst_saisie_validation_sinistre.sru
$PBExportComments$------} NVUO servant à la méthode Saisie/Validation/Edition pour la gestion du Sinistre.
forward
global type n_cst_saisie_validation_sinistre from nonvisualobject
end type
end forward

global type n_cst_saisie_validation_sinistre from nonvisualobject
end type
global n_cst_saisie_validation_sinistre n_cst_saisie_validation_sinistre

type prototypes
Function Ulong FindWindowA ( Long lClassName, Ref String sWindowName ) Library "USER32.DLL" alias for "FindWindowA;Ansi"
Function Ulong FindWindowA ( Ref string sClassName, Long sNull ) Library "USER32.DLL" alias for "FindWindowA;Ansi"
Function Ulong FindWindowA ( Ref string sClassName, Ref String sWindowName ) Library "USER32.DLL" alias for "FindWindowA;Ansi"
Function Ulong FindWindowA ( Long lClassName, Long lWindowName ) Library "USER32.DLL" alias for "FindWindowA;Ansi"

Function Ulong MoveWindow ( ULong ulWin, Long lX, Long lY, Long lWidth, Long lHeight, Long lRepaint ) Library "USER32.DLL"
Function Ulong SetWindowPos(long hwnd, long hmode, int ix, int iy, int cx,int cy, ulong flags) LIBRARY "USER32.DLL"

end prototypes

type variables
Private :
	ListBox			ilb_Fichier

	U_DataWindow_Detail	idwLstInter

	U_DeclarationWindows	invWin

	String			isIdAppli
	String			isZn_IdInter
	String			isZn_CodInter
	String			isFicEntete
	String			isMacro
	String			isAutresDroits
	String			isTypeTrt // [TRACE_TS_COURRIER]

	Long 			ilIdSin

	DataWindow		idwwCourSve
	DataWindow		idwwCourBlobSve
	DataWindow		idwGenCourrier
	DataWindow		idwChoixCourGen
	DataWindow		idwCompo
	DataWindow		idddwTypeDoc
	DataWindow		idwDetPro // [PC363][LOGO_AUCHAN]

	DataWindow		idwwPiece // [PI052]
	DataWindow		idwwRefus // [PI052]
	DataWindow		idwwParaPlafond // [PI052]
	DataWindow		idwwParaInfo // [PI052]
	DataWindow		idwwFranchise // [PI052]	

	u_DataWindow	idw_1 		// #1

	String			isDataInter[]

	StaticText		istPause

	Boolean			ibAltBloc
	Boolean			ibAltEdit

	Integer			iiDroitInter[]    // DCMP 040020 SVE

	s_Pass			iTabVariable[]	// [PI052] Tableau de tableaux des variables par interlocuteur.
	string			iTabCodeVar[]	// [PI052] Tableau des codes de variables.
	String			iTabCleFichier [] // [PI052] Tableau des clé de fichiers généré en XML et à récupérer en PDF.
	String			iTabCleFichierLocal [] // [PI052] Tableau des clé de fichiers PDF en local.	
	String			iTabCleKslEdt [] // [PI052] Tableau des clé pour l'édition sour KSL.	
	String 			isCleRep	// [PI052] Clé du répertoire.		
	String			isTextStPause // [PI052] Sav partie fixe
	String			isExtFicOut // [PI052] Extension du fichier de sortir PDF/DOC
	Constant String isFicFinGen = "FIN.TXT"

	Long				ilNbreTour // [PI052]
	constant Long 	K_FrequenceTimer = 0.5 // [PI052] en seconde

   Long ilPos[] = { 850,10,1014,740 } // [PI052] Coordonnées AcrobatReader           
//Long ilPos[] = { 10,10,200,200 } // [PI052] Coordonnées AcrobatReader           

	Long ilIdentityTraceTsCourrier // [TRACE_TS_COURRIER]


Public : 	
	Boolean			ibTimerPI052 // [PI052]
	Boolean			ibPI052_GenEdtKsl // [PI052]
	Boolean			ibFinGenerationPDFOk // [PI052]

end variables

forward prototypes
private function integer uf_populiser_dwgenerationcourrier ()
private function string uf_courword (integer aitypetrt)
private function integer uf_courword_majdwgencour ()
private function integer uf_courword_affichercourrier ()
public function integer uf_courword_viderword (boolean abtout)
public function integer uf_courword_purgercourrierslocal (boolean abforcer)
private function integer uf_courword_majwcourblob ()
private function integer uf_courword_majwcourrier ()
private function integer uf_courword_populiserdwchoix ()
private function integer uf_courword_lireblobbase ()
public subroutine uf_preparer_instance (string asidsin, ref u_datawindow_detail adwlstinter, string astypetrt)
private function integer uf_courword_lire_wcour (string astypetrt)
private function string uf_recuperercompo (string asidcour)
public function integer uf_positionner_focus ()
public function integer uf_courword_purgertouslescourriers ()
public subroutine uf_inscrire_droitsmodifcourrier (integer aiDroitInter[])
public subroutine uf_inscrire_autresdroits (string asautresdroits)
private function string uf_gestionbac (string asidcour)
public function Boolean uf_getautorisation (integer ainatoper)
public function integer uf_pi052_generer_xml ()
public function string uf_generer_courrier (ref string asdatainter[], string astypetrt, boolean abaltedit, boolean abaltbloc, ref boolean abaumoinuncourrier, ref s_pass anvtrtattribgencour, ref s_pass atabvariable[], ref string atabcodevar[])
public function integer uf_initialiser (string asidappli, ref listbox albfichier, ref datawindow adwgencourrier, ref datawindow adwchoixcourgen, ref statictext astpause, ref datawindow adddwtypedoc, ref datawindow adwwcoursve, ref datawindow adwwcourblobsve, ref datawindow adwcompo, ref u_datawindow adw_1, ref datawindow adwdetpro, ref datawindow adwwpiece, ref datawindow adwwrefus, ref datawindow adwwparaplafond, ref datawindow adwwparainfo)
public function integer uf_pi052_gestiontimer (string ascas, integer aidelai)
public function integer uf_pi052 (string ascas)
public function integer uf_pi052_afficherpdf ()
private function integer uf_courword_visuvalidation (ref string astypdoc)
public function boolean uf_pi052_droitparam (string ascas)
public function boolean uf_getautorisation2 (integer ainatoper, long alidprod)
public function integer uf_pi052_recuperationcourrier ()
public function integer uf_pi052_verif_presence_courrier ()
public function integer uf_pi052_afficherdoc ()
public subroutine uf_set_typetrt (string astypetrt)
private function integer uf_courword_ctrle_docpdf_et_date_docword ()
end prototypes

private function integer uf_populiser_dwgenerationcourrier ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_Populiser_DwGenerationCourrier		(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libellé			: 
//* Commentaires	: Populisation de la DW Dw_Generation_Courrier
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  		Modification
//* #1 		 DGA      19/09/2006 Gestion d'un répertoire temporaire DCMP-060643
//* #2		 PHG		 31/10/2006 [DNTMAIL1-2]
//*          JFF      18/07/2010 [PM159]
//*-----------------------------------------------------------------

Integer iRet
Long lTotInter, lCpt, lLig, lIdInter, lTotwCourSve, lIdSeq, lPos, lIdInterD, lNull
String sIdCourTyp, sTxtCompo1, sTxtCompo2, sTxtCompo, sCodBac
String sTxtData, sTitre, sCodInter, sAltPart, sRepTmp
String sIdInterD, sRech
DateTime dtCreeLe
String sId_canal, sAdrMail, sAltSuiviMail // #2	PHG 31/10/2006 [DNTMAIL1-2]
long	 lLigTrv  									// #2	PHG 31/10/2006 [DNTMAIL1-2]

iRet		= 1
dtCreeLe = DateTime ( Today (), Now () )
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sRepTmp	= stGLB.sWinDir + "\TEMP\"
sRepTmp	= stGLB.sRepTempo
SetNull ( lNull )
lTotInter = idwLstInter.RowCount ()

idwwCourBlobSve.RowsDiscard ( 1, 999, Primary! )

/*------------------------------------------------------------------*/
/* On s'occupe maintenant de l'armement de la DW pour la            */
/* génération des courriers.                                        */
/*------------------------------------------------------------------*/
idwGenCourrier.Reset ()

idwwCourSve.Sort () 

lTotwCourSve = idwwCourSve.RowCount ()
For	lCpt = 1 To lTotwCourSve

		lIdInter 	= idwwCourSve.GetItemNumber ( lCpt, isZn_IdInter )
		lIdSeq		= idwwCourSve.GetItemNumber ( lCpt, "ID_CPT" )
		sIdCourTyp	= idwwCourSve.GetItemString ( lCpt, "ID_COUR" )

		lIdInterD	= idwwCourSve.GetItemNumber ( lCpt, "ID_I_DB" 	)

		sTxtCompo1	= idwwCourSve.GetItemString ( lCpt, "TXT_COMPO1" )
		sTxtCompo2	= idwwCourSve.GetItemString ( lCpt, "TXT_COMPO2" )

		If IsNull ( sTxtCompo2 ) Then sTxtCompo2 = ""
		sTxtCompo	= sTxtCompo1 + sTxtCompo2

		sAltPart		= idwwCourSve.GetItemString ( lCpt, "ALT_PART" )

/*------------------------------------------------------------------*/
/* On donne un titre à la fenêtre. (XXXX99_X*.*)                    */
/*------------------------------------------------------------------*/
/* XXXX = Code de l'application sur 4 caractères obligatoires.      */
/* 99   = ID_INTER sur deux positions obligatoires (Ex:02,12).      */
/* 9    = COD_INTER.                                                */
/*------------------------------------------------------------------*/
		sRech			= isZn_IdInter + " = " + String ( lIdInter ) 
		lLig			= idwLstInter.Find ( sRech, 1, lTotInter )
		
		sCodInter	= idwLstInter.GetItemString ( lLig, isZn_CodInter )
		sTitre		= stGLB.sCodAppli + String ( lIdInter, "00" ) + "_" + sCodInter + ".DOC"

/*--------------------------------------------------------------------------------------------------*/
/* #2 30/10/2006 [DNTMAIL1-2] PHG                                                                   */
/* Report code de l'open de la fenetre appelante suivante point 4.4.1 spécification DNTMAIL1/2      */ 
/* Initialisation du canal selon la régle suivante : Si champ ADR_MAIL est renseigné                */
/* et que la zone ALT_SUIVI_MAIL est coché alors c'est un envoi par MAIL SINON envoi par COURRIER   */
/*--------------------------------------------------------------------------------------------------*/
		
		lLigTrv  = idwLstInter.Find ("ID_I = " + String ( lIdInter ), 1, idwLstInter.RowCount()+1)
		 			
		sAltSuiviMail = idwLstInter.GetItemString (lLigTrv , "ALT_SUIVI_MAIL")
		//[DNTMAIL1-2_MEP_DEF] Forçage à supprimer lors de la MEP finale.
		// [PM159]
		sAltSuiviMail = "O" // [PM159]				

		sAdrMail =      idwLstInter.GetItemString (lLigTrv , "ADR_MAIL")

		IF sAltSuiviMail = "O" And NOT (Isnull (sAdrMail) OR Trim ( sAdrMail ) = "" ) THEN
			sId_canal = "MA"
		Else
			sId_canal = "CO"
		End If
		// Fin [DNTMAIL1-2] PHG 30/10/2006

/*------------------------------------------------------------------*/
/* Tous les courriers sont édités sur le bac du BAS.                */
/*------------------------------------------------------------------*/
		sCodBac		= This.uf_GestionBac ( sIdCourTyp )

/*------------------------------------------------------------------*/
/* Par dédaut on charge les datas de l'inter.                       */
/*------------------------------------------------------------------*/
		sTxtData		= isDataInter[ lIdInter + 1 ]

		lLig = idwGenCourrier.InsertRow ( 0 )

		If	sAltPart = "O"	Then
			If	lIdInterD <> lIdInter And Not IsNull ( lIdInterD ) Then
				sTxtCompo = ""
			Else
				sTxtCompo = Upper ( sRepTmp + sTitre )
			End If
			idwGenCourrier.SetItem ( lLig, "TXT_COMPO", sTxtCompo )
			idwGenCourrier.SetItem ( lLig, "ALT_GEN", "N" )
			idwGenCourrier.SetItem ( lLig, "ALT_GESTION_PART", "O" )
		Else
			idwGenCourrier.SetItem ( lLig, "TXT_COMPO", sTxtCompo )
			idwGenCourrier.SetItem ( lLig, "ALT_GEN", "O" )
			idwGenCourrier.SetItem ( lLig, "ALT_GESTION_PART", "N" )
		End If

		If	lIdInterD <> lIdInter And Not IsNull ( lIdInterD ) Then
			idwGenCourrier.SetItem ( lLig, "ID_INTER_DOUBLE_PROV", lIdInterD )
			sTxtData	= isDataInter[ lIdInterD + 1 ]
		Else
			idwGenCourrier.SetItem ( lLig, "ID_INTER_DOUBLE_PROV", -1 )
		End If

		idwGenCourrier.SetItem ( lLig, "ID_SIN", ilIdSin )
		idwGenCourrier.SetItem ( lLig, "ID_INTER", lIdInter )
		idwGenCourrier.SetItem ( lLig, "ID_SEQ", lIdSeq )
		idwGenCourrier.SetItem ( lLig, "ID_COUR", sIdCourTyp )
		idwGenCourrier.SetItem ( lLig, "TXT_DATA", sTxtData )
		idwGenCourrier.SetItem ( lLig, "TITRE", sTitre )
		idwGenCourrier.SetItem ( lLig, "COD_BAC", sCodBac )
		idwGenCourrier.SetItem ( lLig, "FIC_ENTETE", isFicEntete )
		idwGenCourrier.SetItem ( lLig, "ID_CANAL", sId_Canal ) // #2 [DNTMAIL1-2] PHG 31/10/2006
			
Next

Return ( iRet )
end function

private function string uf_courword (integer aitypetrt);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_CourWord		(PRIVATE)
//* Auteur			: Erick Jo hn Stark
//* Date				: 15/10/2000 16:10:01
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: (Val)		Integer			aiTypeTrt		Type de traitement
//*
//* Retourne		: String							 "" = Tout est OK
//*														
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  	Modification
//           JFF   15/07/2025 [CONVERT_PDF_STOCK]
//*-----------------------------------------------------------------

String sRet
Integer iRet

iRet			= 1
sRet			= ""

Choose Case aiTypeTrt
/*------------------------------------------------------------------*/
/* Traitement à effectuer avant l'apparition de la fenêtre          */
/* RESPONSE ou se fera le choix de la regénération des courriers.   */
/*------------------------------------------------------------------*/
Case 1
/*------------------------------------------------------------------*/
/* On va maintenant fermer tous les documents WORD déjà ouverts.    */
/* Si l'un des documents n'est pas sauvegardé, on arrête tout. Le   */
/* gestionnaire devra décider d'une sauvegarde éventuelle puis      */
/* recommencer le contrôle.                                         */
/*------------------------------------------------------------------*/
		iRet = This.uf_CourWord_ViderWord ( FALSE )
/*------------------------------------------------------------------*/
/* On purge les documents WORD qui ne servent plus.                 */
/*------------------------------------------------------------------*/
		If iRet = 1 Then iRet = This.uf_CourWord_PurgerCourriersLocal ( FALSE )
/*------------------------------------------------------------------*/
/* On populise une DW pour le choix des courrier à générer.         */
/*------------------------------------------------------------------*/
		If iRet = 1 Then iRet = This.uf_CourWord_PopuliserDwChoix ()
Case 2
/*------------------------------------------------------------------*/
/* On vient de proposer une fenêtre de choix de regénération au     */
/* gestionnaire. On va remetter les zones à jour si besoin.         */
/*------------------------------------------------------------------*/
		If iRet = 1 Then iRet = This.uf_CourWord_MajDwGenCour ()
/*------------------------------------------------------------------*/
/* Affichage des courriers sous Word.                               */
/*------------------------------------------------------------------*/
		If iRet = 1 Then iRet = This.uf_CourWord_AfficherCourrier ()
Case 3
/*------------------------------------------------------------------*/
/* On va maintenant fermer tous les documents WORD déjà ouverts.    */
/* Si l'un des documents n'est pas sauvegardé, on arrête tout. Le   */
/* gestionnaire devra décider d'une sauvegarde éventuelle puis      */
/* recommencer le contrôle.                                         */
/*------------------------------------------------------------------*/
		iRet = This.uf_CourWord_ViderWord ( FALSE )

		If iRet = 1 Then iRet = uf_CourWord_MajwCourrier ()
		

Case 4

		// [CONVERT_PDF_STOCK]
		If F_CLE_A_TRUE ( "CONVERT_PDF_STOCK_1" ) Then
			If iRet = 1 Then iRet = uf_CourWord_Ctrle_docPDF_et_Date_DocWord ()			
		End If	

/*------------------------------------------------------------------*/
/* On est positionné dans la fonction Wf_SuiteValider () de la      */
/* fenêtre de sinistre. On va updater la table W_COUR_BLOB et       */
/* envoyer un COMMIT ou un ROLLBACk en fonction de la réussite de   */
/* l'opération.                                                     */
/*------------------------------------------------------------------*/
		iRet = uf_CourWord_MajwCourBlob ()

End Choose

If iRet < 0 Then sRet = "STOP"

Return ( sRet )
end function

private function integer uf_courword_majdwgencour ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_CourWord_MajDwGenCour		(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libellé			: 
//* Commentaires	: Mise à jour de la DW idwChoixCourGen au retour de la fenêtre RESPONSE
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  		Modification
//* #1 		 DGA      19/09/2006 Gestion d'un répertoire temporaire DCMP-060643
//* #2		JCA		19/09/2007	DCMP 40324 - Gestion des éditions pour le DSC
//*-----------------------------------------------------------------

Integer iRet
Long lTotLig, lCpt, lIdInter, lTotCourrier, lCptCourrier
Long lCptFic, lTotFichier, lTotInter, lLig
Long lTotGenCourrier, lIdInterDoubleProv, lLigInter
String sRepTmp, sFiltre, sAltGen, sTypeCour, sJoker, sCodInter
String sNomFic, sNomFicComplet, sRech, sAltPart

integer iInterLine, iInter, iGenCourrier, iDelLine, iDelLineDouble // #2
string sFindDelInter, sFindDelInterDouble // #2

iRet = 1

lTotInter	= idwLstInter.RowCount ()
lTotLig		= idwChoixCourGen.RowCount ()
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sRepTmp		= stGLB.sWinDir + "\TEMP\"
sRepTmp		= stGLB.sRepTempo

For	lCpt = 1 To lTotLig

		lIdInter = idwChoixCourGen.GetItemNumber ( lCpt, "ID_INTER" )

		sFiltre	= "ID_INTER = " + String ( lIdInter )
		idwGenCourrier.SetFilter ( sFiltre )
		idwGenCourrier.Filter ()
/*------------------------------------------------------------------*/
/* On recherche tous les courriers à générer pour cet               */
/* interlocuteur.                                                   */
/*------------------------------------------------------------------*/
		lTotCourrier	= idwGenCourrier.RowCount ()
		sTypeCour		= idwChoixCourGen.GetItemString ( lCpt, "TYPE_COUR" )

		If			sTypeCour = "CP"	Then
/*------------------------------------------------------------------*/
/* On positionne les bonnes valeurs dans la table W_INTER.          */
/* (ALT_PART, ID_COUR et ID_COURTYP).                               */
/*------------------------------------------------------------------*/
					sRech	= isZn_IdInter + " = " + String ( lIdInter ) 

					lLig	= idwLstInter.Find ( sRech, 1, lTotInter )
					idwLstInter.SetItem ( lLig, "ALT_PART", "O" )
					idwLstInter.SetItem ( lLig, "ID_COUR", "APART1" )
		End If

		idwGenCourrier.SetFilter ( "" )
		idwGenCourrier.Filter ()
Next

/*------------------------------------------------------------------*/
/* Gestion des doubles.                                             */
/*------------------------------------------------------------------*/
lTotGenCourrier = idwGenCourrier.RowCount ()
For	lCpt = 1 To lTotGenCourrier
		lIdInterDoubleProv = idwGenCourrier.GetItemNumber ( lCpt, "ID_INTER_DOUBLE_PROV" )
/*------------------------------------------------------------------*/
/* Ce courrier posséde t-il un double ?                             */
/*------------------------------------------------------------------*/
		If	lIdInterDoubleProv < 0	Then Continue
/*------------------------------------------------------------------*/
/* On va chercher l'inter de provenance.                            */
/*------------------------------------------------------------------*/
		sRech = "ID_INTER = " + String ( lIdInterDoubleProv )
		lLigInter = idwGenCourrier.Find ( sRech, 1, lTotGenCourrier )
/*------------------------------------------------------------------*/
/* Le courrier de l'inter de provenance est-il un CP.               */
/*------------------------------------------------------------------*/
		If	idwGenCourrier.GetItemString ( lLigInter, "ALT_GEN" ) = "N"	Then
			sAltPart = "O"
			sNomFic = stGLB.sCodAppli + String ( lIdInterDoubleProv, "00" ) + "_"

			sRech			= isZn_IdInter + " = " + String ( lIdInterDoubleProv ) 
			lLig			= idwLstInter.Find ( sRech, 1, lTotInter )
			sCodInter	= idwLstInter.GetItemString ( lLig, "COD_INTER" )

			sNomFicComplet = sRepTmp + sNomFic + sCodInter + ".DOC"
			idwGenCourrier.SetItem ( lCpt, "TXT_COMPO", sNomFicComplet )
		Else
			sAltPart = "N"
		End If

		idwGenCourrier.SetItem ( lCpt, "ALT_GESTION_PART", sAltPart )
Next

// #2
for lCpt = 1 to lTotLig
	iInterLine = idwChoixCourGen.find("ALT_EDITER = 'N' AND ID_INTER = " + string(idwChoixCourGen.object.id_inter[lCpt]), 1, lTotLig)
	
	if iInterLine > 0 then
		for iGenCourrier = 1 to idwGenCourrier.rowcount()
			// on supprime les courriers destinés à l'interlocuteur
			sFindDelInter = "ID_INTER = " + string(idwChoixCourGen.object.id_inter[lCpt])
			iDelLine = idwGenCourrier.find(sFindDelInter, 1, idwGenCourrier.rowcount())
			
			if iDelLine > 0 then
				idwGenCourrier.rowsdiscard( iDelLine, iDelLine, primary!)
				// on décremente car le rowdiscard fait remonter les lignes du dessous
				iGenCourrier --
			end if
			// pour que la remonter de ligne ne dépasse pas le compteur
			if idwGenCourrier.rowcount() = iGenCourrier then exit
	
			// on supprime les doubles de courrier concernant l'interlocuteur
			sFindDelInterDouble = "ID_INTER_DOUBLE_PROV = " + string(idwChoixCourGen.object.id_inter[lCpt])
			iDelLineDouble = idwGenCourrier.find(sFindDelInterDouble, 1, idwGenCourrier.rowcount())
			
			if iDelLineDouble > 0 then
				idwGenCourrier.rowsdiscard( iDelLineDouble, iDelLineDouble, primary!)
				// on décremente car le rowdiscard fait remonter les lignes du dessous
				iGenCourrier --
			end if
			// pour que la remonter de ligne ne dépasse pas le compteur
			if idwGenCourrier.rowcount() = iGenCourrier then exit
			
		next

	end if

next
// FIN - #2

Return ( iRet )
end function

private function integer uf_courword_affichercourrier ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_CourWord_AfficherCourrier			(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libellé			: 
//* Commentaires	: Affichage des courriers sous WORD
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification
//* #1		 JFF		29/03/04 DCMP 040020 SVE Inscription des droits de modification des courriers en fct de l'inter.
//* 		    JFF     25/10/2011  [PC363][LOGO_AUCHAN]
//           JFF     12/06/2014 [PI052]
//           JFF     03/12/2019 [TRACE_TS_COURRIER]
//       JFF   10/08/2021 [RS848_RS908]
//       JFF  26/04/2023 [RS5045_REF_MATP]
//*-----------------------------------------------------------------

n_Cst_Edition_Courrier	nvGenCourrier
Integer	iRet
Long lIdProd, lDeb, lFin, lCptIdCie, dcIdSin, dcIdRev, dcIdGti, lIdCie, lRowInter, dcIdI, lDebDp188
String sModele, sVarErr1, sVarErr2, sIdCie, sIdCanal, sFicIniApp, sCodInter, sIdCanalDetPro, sIdCieDetPro, sModele_idwwCourSve
String sAltGestionPart
n_cst_string lnvPFCString
Boolean bIdCieTrouve 
Int iTot_idwGenCourrier, iCpt_idwGenCourrier, iCptDetPro, iTot_idwwCourSve, iCpt_idwwCourSve
Int iTot_gTInterCP, iCpt_gTInterCP
Int TInter [], iTot_TInter, iCpt_TInter, iRow_idwwCourSve 
String TModele []

// [PI052]
/*
If F_CLE_A_TRUE ( "PI052" ) Then
	If ibPI052_GenEdtKsl Then
		iRet = uf_PI052 ( "1ER_TOUR" )
		Return iRet
	End If
End If 
*/

iRet = 1
lIdProd = iDw_1.GetItemNumber( 1, "ID_PROD" )
iTot_idwGenCourrier = idwGenCourrier.RowCount ()

If idwGenCourrier.RowCount () <= 0 Then Return 1

nvGenCourrier = Create N_Cst_Edition_Courrier

// #1
nvGenCourrier.uf_Inscrire_DroitsModifCourrier ( iiDroitInter )

nvGenCourrier.uf_Initialiser ( "E" )
If nvGenCourrier.uf_InitialiserWord ( FALSE ) = 1 then 
	
	// [RS5045_REF_MATP]
	// Gestion des modèles pour le média MAIL
	// Règles :
	// Si Média "Par mail" Et absence de DP368 Alors Modèle par défaut COURRIER_SPB.DOT pour A et T
	// Si Média "Par mail" Et présence de DP368 Alors Modèle de la DP368 pour l'Inter donné
	// On n'empêche l'armement plus général et existant de la DP188, mais la DP/368 l'emportera dans le traitement sur n_cst_edition_courrier

	F_RechDetPro ( lDebDp188, lFin, idwDetPro, lIdProd, "-DP", 188 )
	
	If F_CLE_NUMERIQUE ( "RS5045_REF_MATP" ) >= 3 Then

		For iCpt_idwGenCourrier = 1 To iTot_idwGenCourrier
			dcIdI = idwGenCourrier.GetItemNumber ( iCpt_idwGenCourrier, "ID_INTER" ) 
			sIdCanal = idwGenCourrier.GetItemString ( iCpt_idwGenCourrier, "ID_CANAL" ) 
			sAltGestionPart = idwGenCourrier.GetItemString ( iCpt_idwGenCourrier, "ALT_GESTION_PART" ) 

			If sAltGestionPart = "O" Then
				iTot_gTInterCP = UpperBound ( gTInterCP )
				For iCpt_gTInterCP = 1 To iTot_gTInterCP 
					If gTInterCP [ iCpt_gTInterCP ] = dcIdI Then
						TInter [iCpt_idwGenCourrier] = dcIdI
						TModele [iCpt_idwGenCourrier] = gTModeleCP [ iCpt_gTInterCP ] 
						Exit
					End If 
				Next 				
				
			End If 

			If F_CLE_NUMERIQUE ( "RS5045_REF_MATP" ) >= 4 Then
				If lDebDp188 <= 0 And sAltGestionPart <> "O" Then
					// Par défaut, si le canal est mail, on mets au moins le modèle courrier_spb.dot qui pourrai être écrasé ensuite
					TInter [iCpt_idwGenCourrier] = dcIdI
					
					Choose Case sIdCanal 
						Case "MA"
							TModele [iCpt_idwGenCourrier] = ProfileString ( stGLB.sFichierIni, "EDITION", "MODELE_MAIL",  "" )
						Case Else // CO défaut
							TModele [iCpt_idwGenCourrier] = ProfileString ( stGLB.sFichierIni, "EDITION", "MODELE",  "" )
					End Choose 
				End If 
			Else
				If sIdCanal = "MA" And lDebDp188 <= 0 And sAltGestionPart <> "O" Then
					// Par défaut, si le canal est mail, on mets au moins le modèle courrier_spb.dot qui pourrai être écrasé ensuite
					TInter [iCpt_idwGenCourrier] = dcIdI
					TModele [iCpt_idwGenCourrier] = ProfileString ( stGLB.sFichierIni, "EDITION", "MODELE_MAIL",  "" )
				End If 
			End If 

			// Mais si l'option 368 dit autre chose en fonction du contexte..., on écrase alors.
			F_RechDetPro ( lDeb, lFin, idwDetPro, lIdProd, "-DP", 368 )
			If lDeb > 0 And sAltGestionPart <> "O" Then

				lRowInter = idwLstInter.Find ( "ID_I = " + String ( dcIdI ), 1, idwLstInter.RowCount () )
				If lRowInter > 0 Then
					sCodInter = idwLstInter.GetItemString ( lRowInter, "COD_INTER" )
				End If 
	
				For iCptDetPro = lDeb To lFin
					If idwDetPro.GetItemString ( iCptDetPro, "ID_CODE_CAR" ) = sCodInter Then
						sIdCanalDetPro = lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( iCptDetPro, "VAL_CAR" ), "CANAL", ";")
						sIdCieDetPro = lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( iCptDetPro, "VAL_CAR" ), "ID_CIE", ";")							

						SQLCA.PS_S_ID_CIE ( dcIdSin, dcIdRev, dcIdGti, lIdCie )
						
						bIdCieTrouve = False
						If sIdCieDetPro <> "" Then
							dcIdSin = idw_1.GetItemNumber ( 1, "ID_SIN" ) 
							dcIdRev = idw_1.GetItemNumber ( 1, "ID_REV" ) 
							SetNull ( dcIdGti )
							
							If lIdCie = Long ( sIdCieDetPro ) Then
								bIdCieTrouve = True
							End IF 
							
						End If 
						
						If sIdCanalDetPro = sIdCanal And ( bIdCieTrouve Or sIdCieDetPro = "" ) Then	
							TInter [iCpt_idwGenCourrier] = dcIdI
							TModele [iCpt_idwGenCourrier] = lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( iCptDetPro, "VAL_CAR" ), "MODELE", ";")
						End IF 
					End If 
				Next 
			End If 
		Next 
		
		nvGenCourrier.uf_SetModeleParMediaEtInter ( TInter, TModele)
		
		// Maj dw_courrier (idwwCourSve)
		iTot_TInter = UpperBound ( TInter )
		For iCpt_TInter = 1 To iTot_TInter 
			dcIdI = TInter [ iCpt_TInter ]
			iRow_idwwCourSve = idwwCourSve.Find ( "ID_I = " + String ( dcIdI ), 1, idwwCourSve.RowCount())
			idwwCourSve.SetItem ( iRow_idwwCourSve, "MODELE_WORD", TModele [ iCpt_TInter ] )
		Next
		
	End If	
	
	// [PC363][LOGO_AUCHAN]
	// [RS848_RS908]
	F_RechDetPro ( lDeb, lFin, idwDetPro, lIdProd, "-DP", 188 )
	If lDeb > 0 Then
		sIdCie = lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( lDeb, "VAL_CAR" ), "ID_CIE", ";")
		If sIdCie = "" Then 
			lFin = lDeb // Si pas de param IdCir sur la première, on ne va pas plus loin
			bIdCieTrouve = TRUE
		End If 
		
		If lFin > lDeb Then
			dcIdSin = idw_1.GetItemNumber ( 1, "ID_SIN" ) 
			dcIdRev = idw_1.GetItemNumber ( 1, "ID_REV" ) 
			SetNull ( dcIdGti )
			SQLCA.PS_S_ID_CIE ( dcIdSin, dcIdRev, dcIdGti, lIdCie )
			
			bIdCieTrouve = False
			For lCptIdCie = lDeb To lFin
				sIdCie = lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( lCptIdCie, "VAL_CAR" ), "ID_CIE", ";")
				
				If lIdCie = Long ( sIdCie ) Then
					lDeb = lCptIdCie 
					bIdCieTrouve = TRUE
					Exit
				End If 
			Next 
		End If 
		
		// Si présence de dp/188 avec "des" modèles mais aucune correspondance id_cie, alors on garde courrier.dot.
		If bIdCieTrouve Then
			sModele = lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( lDeb, "VAL_CAR" ), "MODELE", ";")

			If F_CLE_NUMERIQUE ( "RS5045_REF_MATP" ) >= 3 Then

				// Maj dw_courrier (idwwCourSve)
				iTot_idwwCourSve = idwwCourSve.RowCount()
				iTot_TInter = UpperBound ( TInter )
	
				For iCpt_idwwCourSve = 1 To iTot_idwwCourSve 
					dcIdI = idwwCourSve.GetItemNumber ( iCpt_idwwCourSve, "ID_I" ) 
					sModele_idwwCourSve = Trim ( idwwCourSve.GetItemString ( iCpt_idwwCourSve, "MODELE_WORD" ) )
					
					If Not IsNull ( sModele_idwwCourSve ) And sModele_idwwCourSve <> "" Then Continue // Déjà un modèle par inter, on passe

					idwwCourSve.SetItem ( iCpt_idwwCourSve, "MODELE_WORD", sModele ) // Sinon on met le modèle par défaut général de la DP188
				Next
			End If 
			
			If Trim ( sModele ) <> "" And Not IsNull ( sModele ) Then 
				nvGenCourrier.uf_changerModele ( sModele )
			End If
		End IF 			
		
	End If 

	iRet = nvGenCourrier.uf_Generer_Courrier ( idwGenCourrier, TRUE )			

	
End If

//Migration PB8-WYNIWYG-03/2006 FM
//Destroy nvGenCourrier
If IsValid(nvGenCourrier) Then Destroy nvGenCourrier
//Fin Migration PB8-WYNIWYG-03/2006 FM

Return ( iRet )

end function

public function integer uf_courword_viderword (boolean abtout);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_CourWord_ViderWord		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libellé			: 
//* Commentaires	: Fermeture automatique de tous les courriers WORD
//*
//* Arguments		: (Val)		Boolean		abTout		Fermeture de tous les documents
//*
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification
//           JFF   12/06/2014 [PI052]
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Si abTout est à FALSE, fermeture de tous les courriers sans      */
/* demander l'enregistrement.                                       */
/* Si abTout est à TRUE, fermeture de tous les documents avec       */
/* demande de sauvegarde éventuelle.                                */
/*------------------------------------------------------------------*/

N_Cst_Edition_Courrier		nvEditionCourrier
Integer 							iRet

// [PI052]
/*
If F_CLE_A_TRUE ( "PI052" ) Then
	If  ibPI052_GenEdtKsl Then
		// On shunt pour le PI052, plus besoin d'appeler cette fonction.
		Return 1
	End If
End If 
*/

nvEditionCourrier = CREATE N_Cst_Edition_Courrier

iRet = nvEditionCourrier.uf_Verifier_Word_AvantGeneration ( abTout )

//Migration PB8-WYNIWYG-03/2006 FM
//DESTROY nvEditionCourrier
If IsValid(nvEditionCourrier) Then DESTROY nvEditionCourrier
//Fin Migration PB8-WYNIWYG-03/2006 FM

Return ( iRet )


end function

public function integer uf_courword_purgercourrierslocal (boolean abforcer);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_CourWord_PurgerCourriersLocal		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libellé			: 
//* Commentaires	: On efface les fichiers présents en local
//*
//* Arguments		: (Val)		Boolean		abForcer			On force la purge dans tous les cas
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  		Modification
//* #1 		 DGA      19/09/2006 Gestion d'un répertoire temporaire DCMP-060643
//           JFF      12/06/2014 [PI052]
//           JFF      15/07/2025 [CONVERT_PDF_STOCK]
//*-----------------------------------------------------------------

String sRepTmp, sNomFic, sJoker, sNomFicComplet, sRech
Long lTotInter, lTotFichier, lCpt, lIdSin, lTot2, lCpt2
Date dDateFic
Time tHeureFic
Integer iRet

/*------------------------------------------------------------------*/
/* On récupére tous les fichiers du type                            */
/* C:\WINNT\TEMP\XXXX99_X*.*.                                       */
/*------------------------------------------------------------------*/
/* XXXX = Code de l'application sur 4 caractères obligatoires.      */
/* 99   = ID_INTER sur deux positions obligatoires (Ex:02,12).      */
/* 9    = COD_INTER.                                                */
/*------------------------------------------------------------------*/
iRet		= 1
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sRepTmp	= stGLB.sWinDir + "\TEMP\"

// [PI052]
/*
If F_CLE_A_TRUE ( "PI052" ) Then
	lTot2 = 3
Else
*/	
// [CONVERT_PDF_STOCK]
If F_CLE_A_TRUE ( "CONVERT_PDF_STOCK_1" ) Then
	lTot2 = 2
Else
	lTot2 = 1
End If	
// End If 



// [PI052]
For lCpt2 = 1 To lTot2
	
	sRepTmp	= stGLB.sRepTempo
//	sJoker	= sRepTmp + stGLB.sCodAppli + "*.DOC"

	// [PI052]
	Choose Case lCpt2 
		Case 1
			sJoker	= sRepTmp + stGLB.sCodAppli + "*.DOC"	
		Case 2			
			// [CONVERT_PDF_STOCK]
			If F_CLE_A_TRUE ( "CONVERT_PDF_STOCK_1" ) Then
				// sJoker	= sRepTmp + stGLB.sCodAppli + "*.PDF"	
				sJoker	= sRepTmp + "*.PDF"
			Else 
				sJoker	= sRepTmp + "*.PDF"					
			End If
			
		Case 3
		
			sJoker	= sRepTmp + "*.DOC"	
			
	End Choose 
		
	ilb_Fichier.Reset ()
	ilb_Fichier.DirList ( sJoker, 0 )
	
	lTotFichier = ilb_Fichier.TotalItems ()
	lTotInter = idwLstInter.RowCount ()
	
	For	lCpt = 1 To lTotFichier
	
			If	Not abForcer	Then
	/*------------------------------------------------------------------*/
	/* On récupére la date et l'heure de chacun des fichiers trouvés.   */
	/*------------------------------------------------------------------*/
				ilb_Fichier.SelectItem ( lCpt )
				sNomFic			= ilb_Fichier.SelectedItem ()
				sNomFicComplet = Upper ( sRepTmp + sNomFic )

				// [PI052]	
				If lCpt2 = 1 Then					
					invWin.uf_GetLastWriteDateTime ( sNomFicComplet, dDateFic, tHeureFic )
		/*------------------------------------------------------------------*/
		/* Si la date est différente du 01/01/2000 et le time différent de  */
		/* 23:59 cela	signifie que le gestionnaire vient de modifier le    */
		/* document WORD.                                                   */
		/*------------------------------------------------------------------*/
					If	dDateFic <> 2000-01-01 Or Left ( String ( tHeureFic ), 5 ) <> "23:59"	Then
		/*------------------------------------------------------------------*/
		/* Si l'interlocuteur existe toujours dans la liste, on garde le    */
		/* document WORD sinon on l'efface.                                 */
		/*------------------------------------------------------------------*/
						sRech = isZn_IdInter + " = " + String ( Long ( Mid ( sNomFic, 5, 2 ) ) ) 
						If	idwLstInter.Find ( sRech, 1, lTotInter ) > 0	Then Continue
		
					End If
				End If
	/*------------------------------------------------------------------*/
	/* Dans tous les autres cas, on supprime le fichier WORD.           */
	/*------------------------------------------------------------------*/
				invWin.uf_SetFileAttributes ( sNomFicComplet , 0 ) // non protection du fichier
				If Not FileDelete ( sNomFicComplet ) Then
					iRet = -1
	
					stMessage.sTitre		= "1N_Cst_Saisie_Validation_Sinistre - uf_CourWord_PurgerCourriersLocal ()"
					stMessage.sVar[1]		= sNomFicComplet
					stMessage.Icon			= Exclamation!
					stMessage.bErreurG	= TRUE
					stMessage.sCode		= "SVAL10"
					
					// [PI052]
					/*
					If F_CLE_A_TRUE ( "PI052" ) Then
						stMessage.sCode		= "PI52010"
						stMessage.bErreurG	= False
					End If
					*/
					
					stMessage.bTrace  	= False
	
					F_Message ( stMessage )
	
				End If
			End If
	Next
Next

/*------------------------------------------------------------------*/
/* On supprime tous les fichiers temporaires générés par la macro   */
/* de courrier.                                                     */
/*------------------------------------------------------------------*/
ilb_Fichier.Reset ()
sJoker	= sRepTmp + "DOC_*.*"

ilb_Fichier.DirList ( sJoker, 0 )
lTotFichier = ilb_Fichier.TotalItems ()

For	lCpt = 1 To lTotFichier
		ilb_Fichier.SelectItem ( lCpt )
		sNomFic			= ilb_Fichier.SelectedItem ()
		sNomFicComplet = Upper ( sRepTmp + sNomFic )

		invWin.uf_SetFileAttributes ( sNomFicComplet , 0 ) // non protection du fichier
		FileDelete ( sNomFicComplet )
Next

Return ( iRet )
end function

private function integer uf_courword_majwcourblob ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_CourWord_MajwCourBlob				(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libellé			: 
//* Commentaires	: On va mettre à jour les BLOBS de la table W_COUR_BLOB
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1		 JFF	29/03/04   DCMP 040020 SVE
//* #2 		 DGA      19/09/2006 Gestion d'un répertoire temporaire DCMP-060643
//*    		 JFF   11/01/2011    [DECIMAL_PAPILLON]
//           JFF     12/06/2014 [PI052]
//           JFF   15/07/2025 [CONVERT_PDF_STOCK]
//*-----------------------------------------------------------------

Long lTotFichier, lCpt, lIdInter, lTotInter, lIdProd
String sIdI, sNomFic, sNomFicComplet, sRepTmp, sJoker, sNomFicCompletPDF
Integer iRet, iIdSeqCourrierPdf
Blob blBlob
Decimal {2} dcIdsin2, dcIdInter2, dcIdCpt2 


/*------------------------------------------------------------------*/  
/* #2. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sRepTmp		= stGLB.sWinDir + "\TEMP\"
sRepTmp		= stGLB.sRepTempo
sJoker		= sRepTmp + stGLB.sCodAppli + "*.DOC"
lIdProd = iDw_1.GetItemNumber( 1, "ID_PROD" )

// [PI052]
/*
If F_CLE_A_TRUE ( "PI052" ) Then
	If ibPI052_GenEdtKsl Then
		sJoker = sRepTmp + isCleRep + "*.PDF"		
		
		// Autorisation Word/KSL
		If This.uf_GetAutorisation2 ( 28, lIdProd ) Then
			sJoker = sRepTmp + isCleRep + "*.DOC"
		End If
		
		// [DEBUG][PI052]
		If stGlb.sCodOper = "JFF" Then		
			sJoker = sRepTmp + "4093528_20140625102800_SIMPA2" + "*.PDF"		
			// Autorisation Word/KSL
			If This.uf_GetAutorisation2 ( 28, lIdProd ) Then
				sJoker = sRepTmp + "4093528_20140625102800_SIMPA2" + "*.DOC"		
			End If
		End If
		// /[DEBUG][PI052]
	End If
End If
*/

iRet			= 1

ilb_Fichier.Reset ()
ilb_Fichier.DirList ( sJoker, 0 )

lTotFichier = ilb_Fichier.TotalItems ()

For	lCpt = 1 To lTotFichier
/*------------------------------------------------------------------*/
/* Il vient d'y avoir une erreur dans le traitement précédent.      */
/* (lCpt-1). On arrête tout et on envoi un ROLLBACK.                */
/*------------------------------------------------------------------*/
		If	iRet = -1	Then Exit

		ilb_Fichier.SelectItem ( lCpt )
		sNomFic			= Upper ( ilb_Fichier.SelectedItem () )
		sNomFicComplet = Upper ( sRepTmp + sNomFic )
		lIdInter			= Long ( Mid ( sNomFic, 5, 2 ) )
		
		sNomFicCompletPDF = F_Remplace ( sNomFicComplet, ".DOC", ".PDF" ) // [CONVERT_PDF_STOCK]
		
		// [PI052]
		/*
		If F_CLE_A_TRUE ( "PI052" ) Then
			If ibPI052_GenEdtKsl Then
				// 4093528_20140625102800_SIMPA2_00_A
				lIdInter = Long ( Mid ( sNomFic, Pos ( sNomFic , "_SIMPA2_" ) + 8, 2 ) ) 
			End If
		End If
		*/
		// [PI052]
		
		sIdI				= String ( lIdInter )
/*------------------------------------------------------------------*/
/* On va écrire le blob dans la table W_COUR_BLOB.                  */
/*------------------------------------------------------------------*/
		SetNull ( blBlob )

/*------------------------------------------------------------------*/
/* #1 : non protection du fichier avant sauvegarde                  */
/*------------------------------------------------------------------*/
		invWin.uf_SetFileAttributes ( sNomFicComplet, 0 ) 

		If F_LireFichierBlob ( blBlob, sNomFicComplet )	Then
		
			dcIdsin2 = Dec ( ilIdSin )
			dcIdInter2 = Dec ( lIdInter )
			dcIdCpt2 = Dec ( 0 )
			UPDATEBLOB	sysadm.w_cour_blob
			SET			txt_blob 	= :blBlob
			WHERE			id_sin		= :dcIdsin2			AND
							id_i			= :dcIdInter2		AND
							id_cpt		= :dcIdCpt2			AND
							id_typ_blob	= "DO"
			USING SQLCA		;
			
			If	SQLCA.SqlCode <> 0 Or SQLCA.SqlDbCode <> 0	Then
				iRet = -1
			End If
		Else
			iRet = -1
		End If
		
		// [CONVERT_PDF_STOCK]
		If F_CLE_A_TRUE ( "CONVERT_PDF_STOCK_1" ) Then
			If iRet > 0 Then
				SetNull ( blBlob )
				invWin.uf_SetFileAttributes ( sNomFicCompletPDF, 0 ) 
		
				If F_LireFichierBlob ( blBlob, sNomFicCompletPDF )	Then
					
					iRet = SQLCA.PS_I_COURRIER_PDF ( dcIdSin2, dcIdInter2, dcIdCpt2, stGlb.sCodOper, iIdSeqCourrierPdf ) 
					
					If	iRet <> 0 Or SQLCA.SqlCode <> 0 Or SQLCA.SqlDbCode <> 0	Then
						iRet = -1
					End If
					
					If iRet = 0 Then iRet = 1
					
					If iRet > 0 Then
						UPDATEBLOB	sysadm.courrier_pdf
						SET			txt_blob 	= :blBlob
						WHERE			id_seq 		= :iIdSeqCourrierPdf
						USING SQLCA		;
					End If  
				
					If	SQLCA.SqlCode <> 0 Or SQLCA.SqlDbCode <> 0	Then
						iRet = -1
					End If
				Else
					iRet = -1
				End If
			End If 
		End If
		
		
Next


If	iRet = 1	Then
//	COMMIT	using SQLCA		;
F_COMMIT ( SQLCA, TRUE ) // [PI056][TRANCOUNT][JFF][24/01/2020]
Else
//	ROLLBACK	using SQLCA		;
F_COMMIT ( SQLCA, FALSE ) // [PI056][TRANCOUNT][JFF][24/01/2020]

	stMessage.sTitre		= "N_Cst_Saisie_Validation_Sinistre - uf_Valider_Blob ()"
	stMessage.sVar[1]		= sNomFicComplet
	stMessage.sVar[2]		= String ( ilIdSin )
	stMessage.sVar[3]		= sIdI
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "SVAL40"
	stMessage.bTrace  	= False

	F_Message ( stMessage )
End If

Return ( iRet )
end function

private function integer uf_courword_majwcourrier ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_CourWord_MajwCourrier			(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libellé			: 
//* Commentaires	: On va armer les tables W_COUR et W_COUR_BLOB
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  		Modification
//* #1 		 DGA      19/09/2006 Gestion d'un répertoire temporaire DCMP-060643
//* #2		 PHG		 31/10/2006 [DNTMAIL1-2] (JFF)
//*          JFF      18/07/2010 [PM159]
//* 			 JFF      02/05/2014 [VDOC13888]
//           JFF      12/06/2014 [PI052]
// 	       JFF      26/04/2023 [RS5045_REF_MATP]
//*-----------------------------------------------------------------

Long lCpt, lTotInter, lTotFichier, lIdInter, lTotwCour, lLig, lLigInter, lTotwCourSve, lNull, lRow, lLigTrv
Long lCptSve, lTotSve, lIdProd, lFin
String sRepTmp, sJoker, sNomFic, sNomFicComplet, sRech, sCodInter, sAltSuiviMail, sAdrMail, sid_Canal, sModeleWord
String sAltPart, sIdCour, sIdCourTyp, sTxtCompo, sTxtCompo1, sNul, sFiltre, sIdCourOrig
Date dDateFic
Time tHeureFic
DateTime	dtCreele
Boolean bAuMoinsUnCp
Integer iRet, iTot_gTInterCP, iCpt_gTInterCP

dtCreeLe = DateTime ( Today (), Now () )
SetNull ( sNul )
SetNull ( lNull )

/*------------------------------------------------------------------*/
/* On vérifie s'il existe au moins un CP sur le disque.             */
/*------------------------------------------------------------------*/
/* On récupére tous les fichiers du type                            */
/* C:\WINNT\TEMP\XXXX*.*.                                           */
/*------------------------------------------------------------------*/
/* XXXX = Code de l'application sur 4 caractères obligatoires.      */
/* 99   = ID_INTER sur deux positions obligatoires (Ex:02,12).      */
/* 9    = COD_INTER.                                                */
/*------------------------------------------------------------------*/
bAuMoinsUnCp	= FALSE
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sRepTmp			= stGLB.sWinDir + "\TEMP\"
sRepTmp			= stGLB.sRepTempo
sJoker			= sRepTmp + stGLB.sCodAppli + "*.DOC"
lIdProd = iDw_1.GetItemNumber( 1, "ID_PROD" )


// [PI052]
/*
If F_CLE_A_TRUE ( "PI052" ) Then
	If ibPI052_GenEdtKsl Then
		sJoker = sRepTmp + isCleRep + "*.PDF"		
		
		// Autorisation Word/KSL
		If This.uf_GetAutorisation2 ( 28, lIdProd ) Then
			sJoker = sRepTmp + isCleRep + "*.DOC"
		End If
		
		// [DEBUG][PI052]
		If stGlb.sCodOper = "JFF" Then		
			sJoker = sRepTmp + "4093528_20140625102800_SIMPA2" + "*.PDF"		
			// Autorisation Word/KSL
			If This.uf_GetAutorisation2 ( 28, lIdProd ) Then
				sJoker = sRepTmp + "4093528_20140625102800_SIMPA2" + "*.DOC"		
			End If
		End If
		// /[DEBUG][PI052]
	End If
End If
*/

lTotInter		= idwLstInter.RowCount ()

ilb_Fichier.Reset ()
ilb_Fichier.DirList ( sJoker, 0 )

lTotFichier = ilb_Fichier.TotalItems ()

If	lTotFichier > 0	Then
	For	lCpt = 1 To lTotFichier

		ilb_Fichier.SelectItem ( lCpt )
		sNomFic			= Upper ( ilb_Fichier.SelectedItem () )
		sNomFicComplet = Upper ( sRepTmp + sNomFic )

		invWin.uf_GetLastWriteDateTime ( sNomFicComplet, dDateFic, tHeureFic )
		If	dDateFic <> 2000-01-01 Or Left ( String ( tHeureFic ), 5 ) <> "23:59"	Then
			bAuMoinsUnCp = TRUE
			Exit
		End If
	Next
End If
/*------------------------------------------------------------------*/
/* Si le dossier posséde au moisn un CP et que l'édition n'est pas  */
/* souhaitée alors le gestionnaire doit confirmer la poursuite du   */
/* traitement.                                                      */
/*------------------------------------------------------------------*/
If	bAuMoinsUnCp And Not ibAltEdit	Then
	stMessage.sTitre		= "N_Cst_Saisie_Validation_Sinistre - uf_CourWord_MajwCourrier ()"
	stMessage.Icon			= Exclamation!
	stMessage.Bouton		= YesNo!
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "SVAL50"
	stMessage.bTrace  	= False

	// [VDOC13888]
	If F_Message ( stMessage ) = 2	Then Return ( -1 )					
End If
/*------------------------------------------------------------------*/
/* Si on ne veut rien éditer, on ne sauvegarde aucun courrier.      */
/*------------------------------------------------------------------*/
If	Not ibAltEdit	Then idwwCourSve.Reset ()
/*------------------------------------------------------------------*/
/* Si le dossier est bloqué, on ne sauvegarde pas les courriers     */
/* automatiques puisqu'ils seront regénérés.                        */
/*------------------------------------------------------------------*/
If	ibAltBloc	Then
	idwwCourSve.SetFilter ( "ALT_PART = 'N' Or ( ALT_PART = 'O' And ISNULL ( ID_I_DB ) ) " )
	idwwCourSve.Filter ()

	lTotwCour = idwwCourSve.RowCount ()
	idwwCourSve.RowsDiscard ( 1, lTotwCour, Primary! )
	 
	idwwCourSve.SetFilter ( "" )
	idwwCourSve.Filter ()
End If

// [PM159].[BUG_PM159_DSC]
// BUG_PM159_DSC
// Je reforce à CO toute ligne se trouve dans idwwCourSve, car certaines, ne donneront pas de courrier
// puisque la case de générer a été décochée, l'enregistrement en CO est donc impératif.
// Plus loin, pour les courriers rééllement existant sur disque, un nouvelle modification de cette zone est faite
// en reprenant la valeur du canal de la fenêtre de génération pour ce courrier.
lTotSve = idwwCourSve.RowCount ()
For lCptSve = 1 To lTotSve 
	idwwCourSve.SetItem ( lCptSve, "ID_CANAL", "CO" ) 	
Next 

For	lCpt = 1 To lTotFichier
		ilb_Fichier.SelectItem ( lCpt )
		sNomFic			= ilb_Fichier.SelectedItem ()
		sNomFicComplet = Upper ( sRepTmp + sNomFic )

		If	Not ibAltEdit	Then
			invWin.uf_SetFileAttributes ( sNomFicComplet , 0 ) // non protection du fichier
			If	Not FileDelete ( sNomFicComplet )	Then
				iRet = -1

				stMessage.sTitre		= "2N_Cst_Saisie_Validation_Sinistre - uf_CourWord_MajwCourrier ()"
				stMessage.sVar[1]		= sNomFicComplet
				stMessage.Icon			= Exclamation!
				stMessage.bErreurG	= TRUE
				stMessage.sCode		= "SVAL10"
				
				// [PI052]
				/*
				If F_CLE_A_TRUE ( "PI052" ) Then
					stMessage.sCode		= "PI52010"
					stMessage.bErreurG	= False					
				End If
				*/
				
				stMessage.bTrace  	= False

				F_Message ( stMessage )

			Else
				Continue
			End If
		End If
/*------------------------------------------------------------------*/
/* On récupére la date de création du fichier.                      */
/*------------------------------------------------------------------*/
		invWin.uf_GetLastWriteDateTime ( sNomFicComplet, dDateFic, tHeureFic )
		lIdInter = Long ( Mid ( sNomFic, 5, 2 ) )
		
		// [PI052]
		/*
		If F_CLE_A_TRUE ( "PI052" ) Then
			If ibPI052_GenEdtKsl Then
				// 4093528_20140625102800_SIMPA2_00_A
				lIdInter = Long ( Mid ( sNomFic, Pos ( sNomFic, "_SIMPA2_" ) + 8, 2 ) ) 
			End If
		End If
		*/
		// [PI052]


/*--------------------------------------------------------------------------------------------------*/
/* #2 30/10/2006 [DNTMAIL1-2] PHG (Ajout JFF, report commentaire PHG)                                                                  */
/* Report code de l'open de la fenetre appelante suivante point 4.4.1 spécification DNTMAIL1/2      */ 
/* Initialisation du canal selon la régle suivante : Si champ ADR_MAIL est renseigné                */
/* et que la zone ALT_SUIVI_MAIL est coché alors c'est un envoi par MAIL SINON envoi par COURRIER   */
/*--------------------------------------------------------------------------------------------------*/
		lLigTrv  = idwLstInter.Find ("ID_I = " + String ( lIdInter ), 1, idwLstInter.RowCount()+1)
		 			
//		sAltSuiviMail = idwLstInter.GetItemString (lLigTrv , "ALT_SUIVI_MAIL") plus utile [PM159]
		sAdrMail =      idwLstInter.GetItemString (lLigTrv , "ADR_MAIL")
		//[DNTMAIL1-2_MEP_DEF] Forçage à supprimer lors de la MEP finale.
		// [PM159]
		lRow = idwChoixCourGen.Find ( "ID_INTER = " + String ( lIdInter ), 1, idwChoixCourGen.RowCount () )
		If lRow > 0 Then
			sId_canal = idwChoixCourGen.GetItemString ( lRow, "ID_CANAL" ) 
			If sId_canal = "MA" And NOT (Isnull (sAdrMail) OR Trim ( sAdrMail ) = "" ) Then
				sId_canal = "MA"
			Else
				sId_canal = "CO"
			End IF
		End If

		// Fin [DNTMAIL1-2] PHG 30/10/2006

		// [PI052] And Not ibPI052_GenEdtKsl
		If	( dDateFic <> 2000-01-01 Or Left ( String ( tHeureFic ), 5 ) <> "23:59"	) And Not ibPI052_GenEdtKsl Then
/*------------------------------------------------------------------*/
/* On vérifie si le N° de l'inter existe toujours.                  */
/*------------------------------------------------------------------*/
			sRech 		= isZn_IdInter + " = " + String ( lIdInter ) 
			lLigInter	= idwLstInter.Find ( sRech, 1, lTotInter )
			If lLigInter <= 0	Then

				invWin.uf_SetFileAttributes ( sNomFicComplet , 0 ) // non protection du fichier
				If	Not FileDelete ( sNomFicComplet )	Then
					iRet = -1
					stMessage.sTitre		= "3N_Cst_Saisie_Validation_Sinistre - uf_CourWord_MajwCourrier ()"
					stMessage.sVar[1]		= sNomFicComplet
					stMessage.Icon			= Exclamation!
					stMessage.bErreurG	= TRUE
					stMessage.sCode		= "SVAL10"
					
					// [PI052]
					/*
					If F_CLE_A_TRUE ( "PI052" ) Then
						stMessage.sCode		= "PI52010"
						stMessage.bErreurG	= False
					End If
					*/
					
					stMessage.bTrace  	= False

					F_Message ( stMessage )
					Exit
				Else
					Continue
				End If
			End If
/*------------------------------------------------------------------*/
/* On supprime de la DW toutes les lignes concernant                */
/* l'interlocuteur. On ne s'occupe pas des courriers automatiques   */
/* mais des courriers particuliers.                                 */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On mémorise le code courrier actuel.			                    */
/*------------------------------------------------------------------*/
			sIdCourOrig = idwLstInter.GetItemString ( lLigInter, "ID_NAT_COUR" )
			sFiltre = "ID_I = " + String ( lIdInter ) 
			
			idwwCourSve.SetFilter ( sFiltre )
			idwwCourSve.Filter ()
			
			// [RS5045_REF_MATP]
			If F_CLE_NUMERIQUE ( "RS5045_REF_MATP" ) >= 3 Then			
				sModeleWord = Trim ( idwwCourSve.GetItemString ( 1, "MODELE_WORD" ) )
				
				// Cas du blocage
				If sModeleWord = "" Or IsNull ( sModeleWord ) Then
					iTot_gTInterCP = UpperBound ( gTInterCP )
					For iCpt_gTInterCP = 1 To iTot_gTInterCP 
						If gTInterCP [ iCpt_gTInterCP ] = lIdInter Then
							sModeleWord = gTModeleCP [ iCpt_gTInterCP ] 
							Exit
						End If 
					Next 						
				End IF 
				
			End If 
		
			lTotwCour = idwwCourSve.RowCount ()
			idwwCourSve.RowsDiscard ( 1, lTotwCour, Primary! )
	 
			idwwCourSve.SetFilter ( "" )
			idwwCourSve.Filter ()
/*------------------------------------------------------------------*/
/* On insére une ligne dans la table W_COUR pour indiquer un        */
/* courrier particulier.                                            */
/*------------------------------------------------------------------*/
			lLig = idwwCourSve.InsertRow ( 0 )
			sIdCour		= "APART1"
			sIdCourTyp	= "APART1"
			sTxtCompo1	= "Courrier particulier (" + sNomFicComplet + ") modifié le : DTEMOD " + String ( dDateFic, "DD/MM/YYYY" ) + " " + String ( tHeureFic, "hh:mm:ss" )

			idwwCourSve.SetItem ( lLig, "ID_SIN", ilIdSin )
			idwwCourSve.SetItem ( lLig, "ID_I", lIdInter )
			idwwCourSve.SetItem ( lLig, "ID_CPT", 0 )
			idwwCourSve.SetItem ( lLig, "ID_COUR", sIdCour )
			idwwCourSve.SetItem ( lLig, "TXT_COMPO1", sTxtCompo1 )
			idwwCourSve.SetItem ( lLig, "TXT_COMPO2", sNul )
			idwwCourSve.SetItem ( lLig, "ALT_PART", "O" )
			idwwCourSve.SetItem ( lLig, "ALT_PCE", "N" )
			idwwCourSve.SetItem ( lLig, "ALT_PS", "N" )
			idwwCourSve.SetItem ( lLig, "CREE_LE", dtCreeLe )
			idwwCourSve.SetItem ( lLig, "MAJ_LE", dtCreeLe )
			idwwCourSve.SetItem ( lLig, "MAJ_PAR", stGLB.sCodOper )
			idwwCourSve.SetItem ( lLig, "ID_I_DB", lNull )
			idwwCourSve.SetItem ( lLig, "ID_COUR_ORIG", sIdCourOrig )
			idwwCourSve.SetItem ( lLig, "ID_CANAL", sId_Canal ) // #2 [DNTMAIL1-2] PHG 31/10/2006 (JFF)

			// [RS5045_REF_MATP]
			If F_CLE_NUMERIQUE ( "RS5045_REF_MATP" ) >= 3 Then			
				idwwCourSve.SetItem ( lLig, "MODELE_WORD", sModeleWord ) // #2 [DNTMAIL1-2] PHG 31/10/2006 (JFF)
			End If 		
			
		Else
/*------------------------------------------------------------------*/
/* Le documennt n'est pas un CP mais un courrier automatique.       */
/*------------------------------------------------------------------*/
/* Si le dossier est bloqué, on ne sauvegarde pas les courriers     */
/* automatiques.	Ils seront regénérés la fois suivante.             */
/*------------------------------------------------------------------*/

			// [PM159]
			lLig = idwwCourSve.Find ( "ID_I = " + String ( lIdInter) , 1, idwwCourSve.Rowcount()) 
			idwwCourSve.SetItem ( lLig, "ID_CANAL", sId_Canal ) 
			// :[PM159]

			// [PI052]
			/*
			If F_CLE_A_TRUE ( "PI052" ) Then
				If ibPI052_GenEdtKsl Then			
					idwwCourSve.SetItem ( lLig, "ALT_PS", "P" )	// [PI052] Marque répère PDF et non DOC
					
					// [PI052]
					// Autorisation Word/KSL
					If This.uf_GetAutorisation2 ( 28, lIdProd ) Then
						idwwCourSve.SetItem ( lLig, "ALT_PS", "D" ) // [PI052] Marque répère DOC et non PDF
					End If

					
					idwwCourSve.SetItem ( lLig, "TXT_COMPO2", iTabCleKslEdt [ lIdInter +1 ] ) // [PI052] Marque clé edt KSL
				End If
			End If
			*/
				
			sRech 		= isZn_IdInter + " = " + String ( lIdInter ) 
			lLigInter	= idwLstInter.Find ( sRech, 1, lTotInter )

			If	ibAltBloc	Then

				invWin.uf_SetFileAttributes ( sNomFicComplet , 0 ) // non protection du fichier
				If	Not FileDelete ( sNomFicComplet )	Then
					iRet = -1
					stMessage.sTitre		= "4N_Cst_Saisie_Validation_Sinistre - uf_CourWord_MajwCourrier ()"
					stMessage.sVar[1]		= sNomFicComplet
					stMessage.Icon			= Exclamation!
					stMessage.bErreurG	= TRUE
					stMessage.sCode		= "SVAL10"
					
					// [PI052]
					/*
					If F_CLE_A_TRUE ( "PI052" ) Then
						stMessage.sCode		= "PI52010"
						stMessage.bErreurG	= False						
					End If
					*/
					
					stMessage.bTrace  	= False

					F_Message ( stMessage )
					Exit
				Else
					Continue
				End If
			End If
		End If		

/*------------------------------------------------------------------*/
/* Insertion d'une ligne dans la DW pour la table W_COUR_BLOB.      */
/*------------------------------------------------------------------*/
		lLig = idwwCourBlobSve.InsertRow ( 0 )

		idwwCourBlobSve.SetItem ( lLig, "ID_SIN", ilIdSin )
		idwwCourBlobSve.SetItem ( lLig, "ID_I", lIdInter ) 
		idwwCourBlobSve.SetItem ( lLig, "ID_CPT", 0 )
		idwwCourBlobSve.SetItem ( lLig, "ID_TYP_BLOB", "DO" )

		lRow = idwChoixCourGen.Find ( "ID_INTER = " + String ( lIdInter ), 1, idwChoixCourGen.RowCount () )
		If lRow > 0 Then
			idwwCourBlobSve.SetItem ( lLig, "ID_TYP_DOC", idwChoixCourGen.GetItemNumber ( lRow, "ID_TYP_DOC" ) )
		Else
			idwwCourBlobSve.SetItem ( lLig, "ID_TYP_DOC", 0 )
		End If

		idwwCourBlobSve.SetItem ( lLig, "CREE_LE", dtCreeLe )
		idwwCourBlobSve.SetItem ( lLig, "MAJ_LE", dtCreeLe )
		idwwCourBlobSve.SetItem ( lLig, "MAJ_PAR", stGLB.sCodOper )

Next

/*------------------------------------------------------------------*/
/* Le 25/02/2002.                                                   */
/* La zone TXT_COMPO n'accepte pas les valeurs NULL dans la table.  */
/* Cette zone n'est pas armée dans le cas d'un double de courrier   */
/* pariculier. On arme manuellement cette zone.                     */
/*------------------------------------------------------------------*/
lTotwCourSve = idwwCourSve.RowCount ()
For	lCpt = 1 To lTotwCourSve
		sTxtCompo = idwwCourSve.GetItemString ( lCpt, "TXT_COMPO1" )
		If	IsNull ( sTxtCompo ) Or Len ( Trim ( sTxtCompo ) ) = 0	Then
			sTxtCompo = "Double Courrier Particulier"
			idwwCourSve.SetItem ( lCpt, "TXT_COMPO1", sTxtCompo )
		End If
Next


Return ( iRet )


end function

private function integer uf_courword_populiserdwchoix ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_CourWord_PopuliserDwChoix		(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libellé			: 
//* Commentaires	: Populisation de la DW proposant le choix des courriers à générer
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  		Modification
//* #1 		 DGA      19/09/2006 Gestion d'un répertoire temporaire DCMP-060643
//* #2		 PHG		 31/10/2006 [DNTMAIL1-2] PHG 31/10/2006
//*-----------------------------------------------------------------

Integer iRet
Long lTotInter, lCpt, lIdInter, lTotCourGen, lLig
String sRech, sCodInter, sNomFic, sNomFicComplet, sNom
Boolean bUnCourAGen
Date dDateFic
Time tHeureFic
Long lRow			// #2 [DNTMAIL1-2] PHG 31/10/2006
string sId_Canal	// #2 [DNTMAIL1-2] PHG 31/10/2006

iRet = 1

lTotInter	= idwLstInter.RowCount ()
lTotCourGen	= idwGenCourrier.RowCount ()
/*------------------------------------------------------------------*/
/* On remet la DW servant au choix des courriers à régénérer à      */
/* zéro.                                                            */
/*------------------------------------------------------------------*/
idwChoixCourGen.Reset ()

For	lCpt = 1 To lTotInter
		lIdInter 	= idwLstInter.GetItemNumber ( lCpt, isZn_IdInter )
		sCodInter	= idwLstInter.GetItemString ( lCpt, isZn_CodInter )
		sNom			= idwLstInter.GetItemString ( lCpt, "NOM" )

/*------------------------------------------------------------------*/
/*  #2 [DNTMAIL1-2] PHG 31/10/2006                                  */
/* On initialise le canal dans la dw de choix                       */
/*------------------------------------------------------------------*/

		sRech			= "ID_INTER = " + String ( lIdInter )
		lRow = idwGenCourrier.Find ( sRech, 1, lTotCourGen ) 
		
		bUnCourAGen = lRow > 0
		if bUnCourAGen then sId_canal = idwGenCourrier.object.id_canal[lRow]
//

/*------------------------------------------------------------------*/
/* On recherche si un courrier est chargé sur disque.               */
/* C:\WINNT\TEMP\XXXX99_X*.*.                                       */
/*------------------------------------------------------------------*/
/* XXXX = Code de l'application sur 4 caractères obligatoires.      */
/* 99   = ID_INTER sur deux positions obligatoires (Ex:02,12).      */
/* 9    = COD_INTER.                                                */
/*------------------------------------------------------------------*/
		sNomFic			= stGLB.sCodAppli + String ( lIdInter, "00" ) + "_" + sCodInter + ".DOC"
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//		sNomFicComplet	= stGLB.sWinDir + "\TEMP\" + sNomFic
		sNomFicComplet	= stGLB.sRepTempo + sNomFic

//Migration PB8-WYNIWYG-03/2006 FM
//		If	Not FileExists ( sNomFicComplet )	Then
		If	Not f_FileExists ( sNomFicComplet )	Then
//Fin Migration PB8-WYNIWYG-03/2006 FM
/*------------------------------------------------------------------*/
/* Si aucun courrier n'est à générer pour cet inter, on continue.   */
/*------------------------------------------------------------------*/
			If	Not bUnCourAGen	Then Continue
/*------------------------------------------------------------------*/
/* Sinon, on va insérer une ligne dans la DW pour le choix des      */
/* courriers.                                                       */
/*------------------------------------------------------------------*/
			lLig = idwChoixCourGen.InsertRow ( 0 )

			idwChoixCourGen.SetItem ( lLig, "ID_INTER", lIdInter )
			idwChoixCourGen.SetItem ( lLig, "COD_INTER", sCodInter )
			idwChoixCourGen.SetItem ( lLig, "NOM", sNom )
			idwChoixCourGen.SetItem ( lLig, "TYPE_COUR", "CA" )
			idwChoixCourGen.SetItem ( lLig, "MAJ_LE", "" )
			idwChoixCourGen.SetItem ( lLig, "DROIT", iiDroitInter [ lIdInter + 1 ] )
			idwChoixCourGen.SetItem ( lLig, "ID_CANAL", sId_Canal ) // #2 [DNTMAIL1-2] PHG 31/10/2006
		Else
/*------------------------------------------------------------------*/
/* Un courrier existe sur le disque pour cet inter.                 */
/*------------------------------------------------------------------*/
/* On récupére la date et l'heure du fichier.                       */
/*------------------------------------------------------------------*/
			invWin.uf_GetLastWriteDateTime ( sNomFicComplet, dDateFic, tHeureFic )
/*------------------------------------------------------------------*/
/* Si le document à été modifié par le gestionnaire, il va          */
/* apparaître maintenant comme un CP.                               */
/*------------------------------------------------------------------*/
			If	dDateFic <> 2000-01-01 Or Left ( String ( tHeureFic ), 5 ) <> "23:59"	Then
				lLig = idwChoixCourGen.InsertRow ( 0 )

				idwChoixCourGen.SetItem ( lLig, "ID_INTER", lIdInter )
				idwChoixCourGen.SetItem ( lLig, "COD_INTER", sCodInter )
				idwChoixCourGen.SetItem ( lLig, "NOM", sNom )
				idwChoixCourGen.SetItem ( lLig, "TYPE_COUR", "CP" )	
				idwChoixCourGen.SetItem ( lLig, "MAJ_LE", String ( dDateFic, "dd/mm/yyyy" ) + " à " + &
																		String ( Long ( Left ( String ( tHeureFic ), 2 ) ), "00" ) + "H" +&
																				String ( Long ( Mid  ( String ( tHeureFic ), 4, 2 ) ), "00" ) )	
				idwChoixCourGen.SetItem ( lLig, "DROIT", iiDroitInter [ lIdInter + 1 ] )
				idwChoixCourGen.SetItem ( lLig, "ID_CANAL", sId_Canal ) // #2 [DNTMAIL1-2] PHG 31/10/2006
			End IF
		End If
Next

Return ( iRet )
end function

private function integer uf_courword_lireblobbase ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_CourWord_LireBlobBase		(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libellé			: 
//* Commentaires	: On va lire les BLOBS
//*
//* Arguments		: Aucun
//*
//* Retourne		: Aucun
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  		Modification
//* #1 		 DGA      19/09/2006 Gestion d'un répertoire temporaire DCMP-060643
//*    		 JFF      11/01/2011 [DECIMAL_PAPILLON]
//*          JFF      xx/xx/2011 [ITSMxxxxx]
//           JFF      12/06/2014 [PI052]
//*-----------------------------------------------------------------

Long lTotInter, lCpt, lTotFichier, lTotBlob, lIdInter, lIdSeq, lLig, lTotwCour, lTot2, lCpt2
Integer iRet
String sRepTmp, sJoker, sNomFic, sNomFicComplet, sIdI, sRech, sCodInter, sDateTime
Date dDateFic
Time tHeureFic
Blob blBlob
Decimal {2} dcIdsin2, dcIdInter2, dcIdCpt2

lTotInter		= idwLstInter.RowCount ()
lTotwCour		= idwwCourSve.RowCount ()

/*------------------------------------------------------------------*/
/* On supprime tous les courriers précédents.                       */
/*------------------------------------------------------------------*/
ilb_Fichier.Reset ()
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sRepTmp	= stGLB.sWinDir + "\TEMP\" 

// [PI052]
/*
If F_CLE_A_TRUE ( "PI052" ) Then
	lTot2 = 3
Else*/
	lTot2 = 1
// End If 

// [PI052]
For lCpt2 = 1 To lTot2
	sRepTmp	= stGLB.sRepTempo
//	sJoker	= sRepTmp + stGLB.sCodAppli + "*.DOC"

	// [PI052]
	Choose Case lCpt2 
		Case 1
			sJoker	= sRepTmp + stGLB.sCodAppli + "*.DOC"	
		Case 2			
			sJoker	= sRepTmp + "*.PDF"	
		Case 3
			sJoker	= sRepTmp + "*.DOC"	
	End Choose 	
	
	ilb_Fichier.Reset ()
	ilb_Fichier.DirList ( sJoker, 0 )
	lTotFichier = ilb_Fichier.TotalItems ()
	
	For	lCpt = 1 To lTotFichier
			ilb_Fichier.SelectItem ( lCpt )
			sNomFic			= ilb_Fichier.SelectedItem ()
			sNomFicComplet = Upper ( sRepTmp + sNomFic )
	
			FileDelete ( sNomFicComplet )
	Next
Next



lTotBlob		= idwwCourBlobSve.RowCount ()

For	lCpt = 1 To lTotBlob
		sIdI		= String ( idwwCourBlobSve.GetItemNumber ( lCpt, isZn_IdInter ) )
		lIdInter = Long ( sIdI )
		lIdSeq	= idwwCourBlobSve.GetItemNumber ( lCpt, "ID_CPT" )

/*------------------------------------------------------------------*/
/* Il s'agit d'un courrier particulier. On va créer le courrier     */
/* particulier et positionner le bon DateTime sur le fichier.       */
/*------------------------------------------------------------------*/
/* Il faut récupérer la zone COD_INTER afin de créeer le courrier   */
/* particulier.                                                     */
/*------------------------------------------------------------------*/
		sRech = isZn_IdInter + " = " + String ( lIdInter ) 
		lLig	= idwLstInter.Find ( sRech, 1, lTotInter )

		sCodInter		= idwLstInter.GetItemString ( lLig, isZn_CodInter )
/*------------------------------------------------------------------*/
/* On récupére le DateTime de création du courrier particulier.     */
/* Cette donnée est stockée dans la zone TXT_COMPO.                 */
/*------------------------------------------------------------------*/
		sRech				= isZn_IdInter + " = " + String ( lIdInter ) + " AND ID_CPT = " + String ( lIdSeq )
		lLig				= idwwCourSve.Find ( sRech, 1, lTotwCour )

		If	idwwCourSve.GetItemString ( lLig, "ALT_PART" ) = "O"	Then
			sDateTime		= Right ( Trim ( idwwCourSve.GetItemString ( lLig, "TXT_COMPO1" ) ), 19 )
			dDateFic			= Date ( Left ( sDateTime, 10 ) )
			tHeureFic		= Time ( Right ( sDateTime, 8 ) )
		Else
			dDateFic			= Today ()
			tHeureFic		= Now ()
		End If

		sNomFic			= stGLB.sCodAppli + String ( lIdInter, "00" ) + "_" + sCodInter + ".DOC"
		
		// [PI052]
		/*
		If F_CLE_A_TRUE ( "PI052" ) Then
			This.uf_PI052_DroitParam ( "RECH" )
			If ibPI052_GenEdtKsl Then
				// Répère PDF et non Doc
				If	idwwCourSve.GetItemString ( lLig, "ALT_PS" ) = "P"	Then
					sNomFic = stGLB.sCodAppli + String ( lIdInter, "00" ) + "_" + sCodInter + ".PDF"					
				End If
				
				If	idwwCourSve.GetItemString ( lLig, "ALT_PS" ) = "D"	Then
					sNomFic = stGLB.sCodAppli + String ( lIdInter, "00" ) + "_" + sCodInter + ".DOC"					
				End If
				
			End If
		End If
		*/
		
		sNomFicComplet	= Upper ( sRepTmp + sNomFic )
/*------------------------------------------------------------------*/
/* On va lire le blob dans la table W_COUR_BLOB.                    */
/*------------------------------------------------------------------*/
		iRet				= 1
		SetNull ( blBlob )

		dcIdsin2 = Dec ( ilIdSin )
		dcIdInter2 = Dec ( lIdInter  )
		dcIdCpt2 = Dec ( lIdSeq )
	
		SELECTBLOB	txt_blob
		INTO			:blBlob
		FROM			sysadm.w_cour_blob
		WHERE			sysadm.w_cour_blob.id_sin			= :dcIdsin2		AND
						sysadm.w_cour_blob.id_i				= :dcIdInter2	AND
						sysadm.w_cour_blob.id_cpt			= :dcIdCpt2		AND
						sysadm.w_cour_blob.id_typ_blob	= 'DO'
		USING	SQLCA		;
	/*------------------------------------------------------------------*/
	/* Le BLOB peut ne pas être valide.                                 */
	/*------------------------------------------------------------------*/
		If Len ( blBlob ) <= 0 Or IsNull ( blBlob ) Then			// Or SQLCA.SqlnRows <> 1	Then
			iRet = -1
		Else
			If	Not F_EcrireFichierBlob ( blBlob, sNomFicComplet )	Then iRet = -1			
		End If
/*------------------------------------------------------------------*/
/* On affiche un message d'erreur non bloquant à l'utilisateur.     */
/*------------------------------------------------------------------*/
		If	 iRet < 0	Then

/* [ITSMxxxxx]
			stMessage.sTitre		= "N_Cst_Saisie_Validation_Sinistre - uf_Recup_wCour ()"
			stMessage.sVar[1]		= sNomFicComplet
			stMessage.sVar[2]		= String( ilIdSin )
			stMessage.sVar[3]		= sIdI
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= TRUE
			stMessage.sCode		= "SVAL30"
			stMessage.bTrace  	= False

			F_Message ( stMessage )
*/			
			// [ITSMxxxxx]
			F_Commit ( SQLCA, FALSE)
			F_Execute ( "Exec sysadm.PS_CORRIGE_BLOB_VIDE " + String ( ilIdSin ) + "., " + &
																			  String ( lIdInter ) + "., " + &
																			  String ( lIdSeq ) + "., " + &
																			  "'DO'" &
																			  , SQLCA)				
			F_Commit ( SQLCA, True )
			HALT
			// [ITSMxxxxx]
		Else
			invWin.uf_SetLastWriteDateTime ( sNomFicComplet, dDateFic, tHeureFic )
		End If
Next

Return ( 1 )
end function

public subroutine uf_preparer_instance (string asidsin, ref u_datawindow_detail adwlstinter, string astypetrt);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_Preparer_Instance		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libellé			: 
//* Commentaires	: Préparation des variables d'instances
//*
//* Arguments		: (Val)		String					asIdSin			N° de la référence sinistre en cours de traitement
//*					  (Réf)		U_DataWindow_Detail	adwLstInter		Liste des Interlocuteurs
//*					  (Val)		String					asTypeTrt		Type de traitement
//*
//* Retourne		: Aucun
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//           JFF      12/06/2014 [PI052]
//*-----------------------------------------------------------------

String sTypDoc // [PI052]

/*------------------------------------------------------------------*/
/* On arme les instances nécessaires au traitement des courriers.   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Cette fonction est appelée sur le Wf_PreparerModifier de la      */
/* fenêtre des sinistres. En effet, on utilise la fonction          */
/* uf_CourWord_PurgerCourriersLocal () sur l'événement Ue_Retour    */
/* de la fenêtre, et cette fonction se sert de idwLstInter et       */
/* ID_SIN.                                                          */
/*------------------------------------------------------------------*/
ilIdSin = Long ( asIdSin )
idwLstInter = adwLstInter
Choose Case asTypeTrt
Case "S"							// On est en saisie.
	This.uf_CourWord_Lire_wCour ( "CP" )
Case "V"							// On est en validation
	This.uf_CourWord_Lire_wCour ( "TOUT" )

	// [PI052]
	This.uf_CourWord_VisuValidation ( sTypDoc )

/*
	If F_CLE_A_TRUE ( "PI052" ) Then	
		If sTypDoc = "PDF" Then
			This.uf_PI052_AfficherPDF ()
		ElseIF sTypDoc = "DOC_KSL" Then
			This.uf_PI052_AfficherDOC ()		
		Else
			This.uf_CourWord_AfficherCourrier ()
		End If
	Else */
		This.uf_CourWord_AfficherCourrier ()		
//	End If
End Choose


end subroutine

private function integer uf_courword_lire_wcour (string astypetrt);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_Lire_wCour			(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libellé			: 
//* Commentaires	: On va lire la table W_COUR
//*
//* Arguments		: (Val)			asTypeTrt		String		Type de traitement
//*
//* Retourne		: Aucun
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//*
//*-----------------------------------------------------------------

Integer iRet

iRet = 1
idwwCourSve.Reset ()
idwwCourBlobSve.Reset ()

idwwCourSve.Retrieve ( ilIdSin )
idwwCourBlobSve.Retrieve ( ilIdSin, asTypeTrt )

If	This.uf_CourWord_LireBlobBase () < 0	Then iRet = -1


Return ( iRet )
end function

private function string uf_recuperercompo (string asidcour);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_RecupererCompo		(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libellé			: 
//* Commentaires	: Récupération de la composition pour la gestion des doubles.
//*
//* Arguments		: (Val)		String					asIdCour			Code courrier (Du Type XCOPIE)
//*
//* Retourne		: String						"" = Problème dans la récupération
//*
//*-----------------------------------------------------------------
//* MAJ  PAR      Date	  	Modification
//* #1 	JCA	16/05/2007 	DCMP 070051 - Fusion des tables [courrier] et composition] en [cour_prod]
//*-----------------------------------------------------------------

String sTxtCompo, sIdPara, sCptVer
Long lCpt, lNbrPara

Long lIdProd // #1

lIdProd = iDw_1.GetItemNumber( 1, 'ID_PROD' )

sTxtCompo = ""

idwCompo.Reset ()

// #1
//lNbrPara	= idwCompo.Retrieve ( asIdCour )
lNbrPara	= idwCompo.Retrieve ( asIdCour, lIdProd )
// #1 - FIN

idwCompo.Sort ()

For	lCpt = 1 To lNbrPara
		sIdPara	= idwCompo.GetItemString ( lCpt, "ID_PARA" )
		sCptVer	= idwCompo.GetItemString ( lCpt, "CPT_VER" )

		sTxtCompo = sTxtCompo + sIdPara + "." + sCptVer
Next

Return ( sTxtCompo )

end function

public function integer uf_positionner_focus ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_Positionner_Focus			(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 30/01/2002 16:10:01
//* Libellé			: 
//* Commentaires	: On positionne le focus sur la fenêtre WORD
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer						 1 = WORD n'est pas la fenêtre active
//*														-1 = WORD est déjà la fenêtre active
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Integer iRet
UnsignedLong ulRet
N_Cst_Word	nvWord

iRet = -1

F_SetVersionWord ( nvWord, TRUE )		

ulRet = nvWord.uf_WordOuvert ()

If	ulRet <> invWin.uf_GetActiveWindow ()	Then
	iRet = 1
	invWin.uf_SetActiveWindow ( ulRet )
	invWin.uf_SetFocus ( ulRet )
End If

F_SetVersionWord ( nvWord, FALSE )		

Return ( iRet )
end function

public function integer uf_courword_purgertouslescourriers ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_CourWord_PurgerTouslesCourriers	(PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 01/04/2004 16:10:01
//* Libellé			: 
//* Commentaires	: On efface tous les fichiers présents en local
//*
//* Arguments		: 
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  		Modification
//* #1 		 DGA      19/09/2006 Gestion d'un répertoire temporaire DCMP-060643
//           JFF      12/06/2014 [PI052]
//           JFF      15/07/2025 [CONVERT_PDF_STOCK]
//*-----------------------------------------------------------------

String sRepTmp, sNomFic, sJoker, sNomFicComplet, sRech
Long lTotFichier, lCpt, lIdSin, lTot2, lCpt2
Date dDateFic
Time tHeureFic
Integer iRet
Long dcIdSin 

/*------------------------------------------------------------------*/
/* On récupére tous les fichiers du type                            */
/* C:\WINNT\TEMP\XXXX99_X*.*.                                       */
/*------------------------------------------------------------------*/
/* XXXX = Code de l'application sur 4 caractères obligatoires.      */
/* 99   = ID_INTER sur deux positions obligatoires (Ex:02,12).      */
/* 9    = COD_INTER.                                                */
/*------------------------------------------------------------------*/
iRet		= 1
dcIdSin = idw_1.GetItemNumber ( 1, "ID_SIN" ) 

/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sRepTmp	= stGLB.sWinDir + "\TEMP\" 

// [PI052]
/*
If F_CLE_A_TRUE ( "PI052" ) Then
	lTot2 = 3
Else */
// [CONVERT_PDF_STOCK]
If F_CLE_A_TRUE ( "CONVERT_PDF_STOCK_1" ) Then
	lTot2 = 2
Else
	lTot2 = 1
End If	
// End If 

// End If 

// [PI052]
For lCpt2 = 1 To lTot2
	sRepTmp	= stGLB.sRepTempo

	// [PI052]
	Choose Case lCpt2 
		Case 1
			sJoker	= sRepTmp + stGLB.sCodAppli + "*.DOC"	
		Case 2			
			
			// [CONVERT_PDF_STOCK]
			If F_CLE_A_TRUE ( "CONVERT_PDF_STOCK_1" ) Then
				// sJoker	= sRepTmp + stGLB.sCodAppli + "*.PDF"	
				sJoker	= sRepTmp + "*.PDF"
			Else 
				sJoker	= sRepTmp + "*.PDF"	
			End If
			
		Case 3			

			// [CONVERT_PDF_STOCK]
			If F_CLE_A_TRUE ( "CONVERT_PDF_STOCK_1" ) Then
				sJoker	= sRepTmp + String ( dcIdSin ) + "*.PDF"	
			Else 
				sJoker	= sRepTmp + "*.DOC"	
			End If
			
			
			
	End Choose 
	
	ilb_Fichier.Reset ()
	ilb_Fichier.DirList ( sJoker, 0 )
	
	lTotFichier = ilb_Fichier.TotalItems ()
	
	For	lCpt = 1 To lTotFichier
	
		ilb_Fichier.SelectItem ( lCpt )
		sNomFic			= ilb_Fichier.SelectedItem ()
		sNomFicComplet = Upper ( sRepTmp + sNomFic )
	
		/*------------------------------------------------------------------*/
		/* Dans tous les autres cas, on supprime le fichier WORD.           */
		/*------------------------------------------------------------------*/
		invWin.uf_SetFileAttributes ( sNomFicComplet , 0 ) // non protection du fichier
		If Not FileDelete ( sNomFicComplet ) Then
			iRet = -1
	
			stMessage.sTitre		= "5N_Cst_Saisie_Validation_Sinistre - uf_CourWord_PurgerCourriersLocal ()"
			stMessage.sVar[1]		= sNomFicComplet
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= TRUE
			stMessage.sCode		= "SVAL10"

			// [PI052]
/*			
			If F_CLE_A_TRUE ( "PI052" ) Then
				stMessage.sCode		= "PI52010"
				stMessage.bErreurG	= False				
			End If
*/			
			stMessage.bTrace  	= False
	
			F_Message ( stMessage )
	
		End If
	
	Next
	
	/*------------------------------------------------------------------*/
	/* On supprime tous les fichiers temporaires générés par la macro   */
	/* de courrier.                                                     */
	/*------------------------------------------------------------------*/
	ilb_Fichier.Reset ()
	sJoker	= sRepTmp + "DOC_*.*"
	
	ilb_Fichier.DirList ( sJoker, 0 )
	lTotFichier = ilb_Fichier.TotalItems ()
	
	For	lCpt = 1 To lTotFichier
			ilb_Fichier.SelectItem ( lCpt )
			sNomFic			= ilb_Fichier.SelectedItem ()
			sNomFicComplet = Upper ( sRepTmp + sNomFic )
	
			invWin.uf_SetFileAttributes ( sNomFicComplet , 0 ) // non protection du fichier
			FileDelete ( sNomFicComplet )
	Next

Next

Return ( iRet )
end function

public subroutine uf_inscrire_droitsmodifcourrier (integer aiDroitInter[]);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Validation_Sinistre::uf_DroitsModifCourrier	(PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 29/03/2004 10:35:14
//* Libellé			: Inscription du tableau des droits de modifications des courriers par interlocuteur.
//* Commentaires	: DCMP 040020 SVE
//*
//* Arguments		: Integer		aiDroitInter       Val
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------


iiDroitInter = aiDroitInter


end subroutine

public subroutine uf_inscrire_autresdroits (string asautresdroits);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Validation_Sinistre::uf_Inscrire_AutresDroits	(PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 29/03/2004 10:35:14
//* Libellé			: Inscription d'une chaine de droit à exploiter sur la fenêtre de choix.
//* Commentaires	: DCMP 040020 SVE
//*
//* Arguments		: String			asAutreDroits			Val
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------


isAutresDroits = asAutresDroits


end subroutine

private function string uf_gestionbac (string asidcour);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_Saisie_Validation::uf_GestionBac (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 04/06/2004 15:48:42
//* Libellé       : Gestion des BACs
//* Commentaires  : 
//*
//* Arguments     : String			asIdCour			Val
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

String sBac

Choose Case Left ( asIdCour, 1 )

	/*------------------------------------------------------------------*/
	/* Questionnaire et Doc à joindre                                   */
	/*------------------------------------------------------------------*/
	Case "Q"
		sBac = "MILIEU"

	/*------------------------------------------------------------------*/
	/* BANQUE		                                                     */
	/*------------------------------------------------------------------*/
	Case "B" // Courrier Banque
		sBac = "HAUT"

	/*------------------------------------------------------------------*/
	/* Courrier Assuré + autres (CP)                                    */
	/*------------------------------------------------------------------*/
	Case Else	// Courrier Assuré + autres
		sBac = "BAS"

End Choose	

Return sBac

end function

public function Boolean uf_getautorisation (integer ainatoper);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::uf_getautorisation
//* Auteur			: FABRY JF
//* Date				: 09/09/2008 11:03:31
//* Libellé			: [VDOC13888]
//* Commentaires	: 
//*
//* Arguments		: value integer aiNatOper	 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Boolean bOk
Long lTrouve


SQLCA.ps_s01_autorisation(aiNatOper, stGlb.scodoper, -1, lTrouve )	

bOk = lTrouve > 0

Return bOk



end function

public function integer uf_pi052_generer_xml ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_PI052_Generer_XML			(PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 12/06/2014
//* Libellé			: 
//* Commentaires	: [PI052]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//*
//*-----------------------------------------------------------------

Integer 	iRet
Integer  iFic, iWrt

String 	sTGEnteteVersion, sFin, sDeb, sFerm, sEgaleGuill, FinGuill
String sTG_ListeDem, sTG_Demande, sTG_Tech, sTG_CodeAdhSin, sTG_CodeGest, sTG_CodeMaquet, sTG_Langue
String sTG_Courrier, sTG_IdCourj, sTG_IdIDB, sTG_IdInter, sTG_CodeInter, sTG_Entete
String sCleFicFixXML, sCleFicFixPDF, sCleFicVar, sIdInter, sCodInter, sExtFicXML, sPathXML, sPathPDF
String sChaine, sIdcour, sZvar, sTG_Col1, sTG_Col2
String sTG_Tableau, sTG_Tpiece, sTG_Trefus, sTG_TparaPlaf, sTG_TparaInter
String sTG_TpieceLig, sTG_TrefusLig, sTG_TparaPlafLig, sTG_TparaInterLig
String sVal, sIdPara
String sIdCourJ, sIdIDb
String sTG_FormatRet	

Long   lTotVar, lCpt_iTabVar, lRow, lTotCodVar, lCpt_iTabCodVar
Long   lTotPiece, lCpt_Piece
Long   lTotRefus, lCpt_Refus
Long   lTotParaPlaf, lCpt_ParaPlaf
Long   lTotParaInter, lCpt_ParaInter
Long   lIdProd 
iRet = 1

lIdProd = iDw_1.GetItemNumber( 1, "ID_PROD" )

// Entête 
sTGEnteteVersion = '<?xml version="1.0" encoding="UTF-8" ?>'

// Symboles
sFin = "/" ; sDeb = "<" ; sFerm = ">" ; sEgaleGuill = '="' ; FinGuill = '"'

// Tag Bruts
sTG_ListeDem 	= "liste_demande"
sTG_Demande  	= "demande"
sTG_Tech  		= "tech"
sTG_CodeAdhSin = "code_adhsin"
sTG_CodeGest   = "code_gestionnaire"
sTG_CodeMaquet = "code_maquette"
sTG_Langue     = "langue"
sTG_IdInter    = "id_inter"
sTG_CodeInter  = "code_inter"
sTG_IdCourj		= "courrier_a_joindre"
sTG_IdIDB		= "envoyer_un_double_du_courrier_adresse_a"
sTG_FormatRet	= "format_retour"
sTG_Courrier   = "courrier"
sTG_Entete		= "entete"
sTG_Tableau    = "tableaux"
sTG_Tpiece		= "T1"
sTG_Trefus		= "T2"
sTG_TparaPlaf	= "T3"
sTG_TparaInter	= "T4"
sTG_Col1			= "col1"
sTG_Col2			= "col2"
sTG_TpieceLig  = "t1lig"
sTG_TrefusLig  = "t2lig"
sTG_TparaPlafLig = "t3lig"
sTG_TparaInterLig = "t4lig"

sExtFicXML	   = ".XML"							
isExtFicOut		= ".PDF"

// Autorisation Word/KSL
If This.uf_GetAutorisation2 ( 28, lIdProd ) Then
	isExtFicOut	= ".DOC"
End If

// ex : 20140313141054
sCleFicFixXML  =  String ( ilIdSin ) + "_"
sCleFicFixXML +=  String ( year   ( Today () ), "0000" ) + &
					String ( Month  ( Today () ), "00" ) + &
					String ( Day    ( Today () ), "00" ) + &
					String ( Hour   ( Now () ), "00" ) + &
					String ( Minute ( Now () ), "00" ) + &
					String ( Second ( Now () ), "00" ) + &
					"_SIMPA2"

// [DEBUG][PI052]
If stGlb.sCodOper = "JFF" Then
	sCleFicFixXML  = "4093528_20140625102800_SIMPA2"
End If 
// /[DEBUG][PI052]


// Mémorisation en instance de la clé du futur répertoire PDF
isCleRep	= sCleFicFixXML				

// Je complète ensuite la partie fixe de clé des fichiers
sCleFicFixXML += "_"				

sPathPDF		= ProfileString ( stGlb.sFichierIni, "EDITION", "REP_PI052_KSL_RECUP_PDF", "" )
sCleFicFixPDF  = sPathPDF + isCleRep + "\" + sCleFicFixXML					
					
sPathXML	   = ProfileString ( stGlb.sFichierIni, "EDITION", "REP_PI052_KSL_DEPOT_XML", "" )
sCleFicFixXML  = sPathXML + sCleFicFixXML 

If IsNull ( sPathXML ) Or Len ( sPathXML ) <= 0 Then
	stMessage.sTitre		= "Chemin PI052 XML Absent"
	stMessage.Icon			= StopSign!
	stMessage.sCode		= "PI52001"
	stMessage.sVar [1]   = sCleFicFixXML
	F_Message ( stMessage )
	Return -1
End If 

lTotVar = UpperBound ( iTabVariable )

// Boucle sur le tableau des variable pour chaque inter
For lCpt_iTabVar = 1 To lTotVar 

	sIdInter = String ( lCpt_iTabVar - 1, "00" )
	lRow = idwLstInter.Find ( "ID_I = " + String (lCpt_iTabVar - 1), 1, idwLstInter.RowCount() )
	
	sCodInter = idwLstInter.GetItemString ( lRow, "COD_INTER" ) 
	sIdCourJ  = idwLstInter.GetItemString ( lRow, "ID_COURJ" ) 
	If IsNull ( sIdCourJ  ) Then sIdCourJ = ""
	sIdIDb    = String ( idwLstInter.GetItemNumber ( lRow, "ID_I_DB" ), "00" ) 
	If IsNull ( sIdIDb ) Then sIdIDb = ""
	
	sCleFicVar = sCleFicFixXML + sIdInter + "_" + sCodInter + sExtFicXML
	
	// Mémorisation en tableau instance de la clé de chaque fichier PDF
	iTabCleFichier [ lCpt_iTabVar ] = sCleFicFixPDF + sIdInter + "_" + sCodInter + isExtFicOut

	iFic = FileOpen ( sCleFicVar, LineMode!, Write!, LockWrite!, Replace!, EncodingUTF8! )
	If iFic < 0 Then 
		stMessage.sTitre		= "Impossible de creer le fichier XML"
		stMessage.Icon			= StopSign!
		stMessage.sCode		= "PI52002"
		F_Message ( stMessage )		
		Return -1
	End If
	
	// '<?xml version="1.0" encoding="UTF-8" ?>'
	iWrt = FileWrite ( iFic, sTGEnteteVersion )
	If iWrt < 0 Then 
		stMessage.sTitre		= "Impossible d'écrire le fichier XML"
		stMessage.Icon			= StopSign!
		stMessage.sCode		= "PI52003"
		F_Message ( stMessage )		
		Return -1
	End If
	
	// "liste_demande"
	sChaine = sDeb + sTG_ListeDem + sFerm
	iWrt = FileWrite ( iFic, sChaine)
	If iWrt < 0 Then 
		stMessage.sTitre		= "Impossible d'écrire le fichier XML"
		stMessage.Icon			= StopSign!
		stMessage.sCode		= "PI52003"
		F_Message ( stMessage )		
		Return -1
	End If
	
		// "demande"
		sChaine = Space (4) + sDeb + sTG_Demande + sFerm
		iWrt = FileWrite ( iFic, sChaine)
		If iWrt < 0 Then 
			stMessage.sTitre		= "Impossible d'écrire le fichier XML"
			stMessage.Icon			= StopSign!
			stMessage.sCode		= "PI52003"
			F_Message ( stMessage )		
			Return -1
		End If
	
			// "tech"
			sChaine  = Space (8) + sDeb + sTG_Tech + Space (1) 
			sChaine += sTG_CodeAdhSin + sEgaleGuill + "S" + FinGuill+ Space (1)
			sChaine += sTG_CodeGest + sEgaleGuill + "SPB\" + stGlb.sCodOper + FinGuill+ Space (1)

			lRow = idwGenCourrier.Find ( "ID_INTER = " + sIdInter, 1, idwGenCourrier.Rowcount () )
			If lRow <=0 Then 
				iWrt = FileClose ( iFic )
				FileDelete ( sCleFicVar )
				Continue
			End If
			
			sIdcour = idwGenCourrier.GetItemString ( lRow, "ID_COUR" )
			sChaine += sTG_CodeMaquet + sEgaleGuill + sIdcour + FinGuill + Space (1)
			sChaine += sTG_Langue     + sEgaleGuill + "FR" + FinGuill + Space (1)
			sChaine += sTG_IdInter    + sEgaleGuill + sIdInter + FinGuill + Space (1)
			sChaine += sTG_CodeInter  + sEgaleGuill + sCodInter + FinGuill + Space (1)
			sChaine += sTG_IdCourj    + sEgaleGuill + sIdCourJ	+ FinGuill + Space (1)
			sChaine += sTG_IdIDB      + sEgaleGuill + sIdIDb	+ FinGuill + Space (1)
			sChaine += sTG_FormatRet  + sEgaleGuill + Right ( isExtFicOut, 3)	+ FinGuill 
			
			// ...Ici si d'autres "tech"
			// sChaine += 

			sChaine += sFin + sFerm
			iWrt = FileWrite ( iFic, sChaine)
			If iWrt < 0 Then 
				stMessage.sTitre		= "Impossible d'écrire le fichier XML"
				stMessage.Icon			= StopSign!
				stMessage.sCode		= "PI52003"
				F_Message ( stMessage )		
				Return -1
			End If
			// "/tech"

			// "entete"
			sChaine  = Space (8) + sDeb + sTG_entete // + Space (1) 
			sChaine += sFin + sFerm

			iWrt = FileWrite ( iFic, sChaine)
			If iWrt < 0 Then 
				stMessage.sTitre		= "Impossible d'écrire le fichier XML"
				stMessage.Icon			= StopSign!
				stMessage.sCode		= "PI52003"
				F_Message ( stMessage )		
				Return -1
			End If
			// "/entete"			
			
			// "courrier"  (les ZVAR)
			sChaine  = Space (8) + sDeb + sTG_Courrier + Space (1) 

			lTotCodVar = UpperBound ( iTabCodeVar )
			
			// Boucle sur le tableau des variable pour l'inter
			For lCpt_iTabCodVar = 1 To lTotCodVar
				sZvar = iTabVariable[lCpt_iTabVar].sTab[lCpt_iTabCodVar]
				If IsNull ( sZvar ) Then sZvar = ""
				
				// Caractère interdit dans le XML.
				sZvar = F_Remplace ( sZvar, "&", " et " )
				sZvar = F_Remplace ( sZvar, '"', "''" )
				
				sChaine += iTabCodeVar[lCpt_iTabCodVar] + sEgaleGuill + sZvar + FinGuill+ Space (1)
			Next 

			sChaine += sFerm
			iWrt = FileWrite ( iFic, sChaine)
			If iWrt < 0 Then 
				stMessage.sTitre		= "Impossible d'écrire le fichier XML"
				stMessage.Icon			= StopSign!
				stMessage.sCode		= "PI52003"
				F_Message ( stMessage )		
				Return -1
			End If
			// "/courrier"

				// "tableaux"  (les tableaux de pièces, refus, para plaf, para inter etc...)
				sChaine  = Space (12) + sDeb + sTG_Tableau + sFerm
				iWrt = FileWrite ( iFic, sChaine)
				If iWrt < 0 Then 
					stMessage.sTitre		= "Impossible d'écrire le fichier XML"
					stMessage.Icon			= StopSign!
					stMessage.sCode		= "PI52003"
					F_Message ( stMessage )		
					Return -1
				End If
			
					// "T1"  (les tableaux de pièces)
					sChaine  = Space (16) + sDeb + sTG_Tpiece + sFerm
					iWrt = FileWrite ( iFic, sChaine)
					If iWrt < 0 Then 
						stMessage.sTitre		= "Impossible d'écrire le fichier XML"
						stMessage.Icon			= StopSign!
						stMessage.sCode		= "PI52003"
						F_Message ( stMessage )		
						Return -1
					End If

						// "t1Lig"  (les Pièces)
						sChaine  = Space (20) + sDeb + sTG_TpieceLig + Space (1) 

						lTotPiece = idwwPiece.RowCount () 
						
						// Boucle sur le tableau des variable pour l'inter
						For lCpt_Piece = 1 To lTotPiece
							
							If idwwPiece.GetItemNumber ( lCpt_Piece, "ID_I" ) <> Long ( sIdInter ) Then Continue
							
							sVal = String ( idwwPiece.GetItemNumber ( lCpt_Piece, "ID_PCE" ) )
							sIdPara = String ( idwwPiece.GetItemString ( lCpt_Piece, "ID_PARA" ) )
							If IsNull ( sVal ) Then sVal = ""
							If IsNull ( sIdPara  ) Then sIdPara = ""

							// Doublon, pièce déjà traitée
							If lCpt_Piece > 1 And idwwPiece.Find ( "ID_PCE = " + sVal + " AND ID_I = " + sIdInter + "", 1, lCpt_Piece - 1 ) > 0 Then Continue

							// Caractère interdit dans le XML.
							sVal = F_Remplace ( sVal, "&", " et " )
							sVal = F_Remplace ( sVal, '"', "''" )

							sIdPara = F_Remplace ( sIdPara, "&", " et " )
							sIdPara = F_Remplace ( sIdPara, '"', "''" )
							
							sChaine  = Space (24) + sDeb + sTG_TpieceLig + Space (1) 
							sChaine += sTG_Col1 + sEgaleGuill + sVal + FinGuill + Space (1) 
							sChaine += sTG_Col2 + sEgaleGuill + sIdPara + FinGuill + Space (1) 							
							sChaine += sFin + sFerm

							iWrt = FileWrite ( iFic, sChaine)
							If iWrt < 0 Then 
								stMessage.sTitre		= "Impossible d'écrire le fichier XML"
								stMessage.Icon			= StopSign!
								stMessage.sCode		= "PI52003"
								F_Message ( stMessage )		
								Return -1
							End If
							
						Next 
						// /"t1Lig"

					sChaine = Space (16) + sDeb + sFin + sTG_Tpiece + sFerm
					iWrt = FileWrite ( iFic, sChaine)
					If iWrt < 0 Then 
						stMessage.sTitre		= "Impossible d'écrire le fichier XML"
						stMessage.Icon			= StopSign!
						stMessage.sCode		= "PI52003"
						F_Message ( stMessage )		
						Return -1
					End If	
					// "/T1"


					// "T2"  (les tableaux de Refus)
					sChaine  = Space (16) + sDeb + sTG_Trefus + sFerm
					iWrt = FileWrite ( iFic, sChaine)
					If iWrt < 0 Then 
						stMessage.sTitre		= "Impossible d'écrire le fichier XML"
						stMessage.Icon			= StopSign!
						stMessage.sCode		= "PI52003"
						F_Message ( stMessage )		
						Return -1
					End If


						// "t2Lig"  (les Refus)
						sChaine  = Space (20) + sDeb + sTG_TRefusLig + Space (1) 

						lTotRefus = idwwRefus.RowCount () 
						
						// Boucle sur le tableau des variable pour l'inter
						For lCpt_Refus = 1 To lTotRefus
							
							If idwwRefus.GetItemNumber ( lCpt_Refus, "ID_I" ) <> Long ( sIdInter ) Then Continue
							
							sVal = String ( idwwRefus.GetItemNumber ( lCpt_Refus, "ID_MOTIF" ) )
							sIdPara = String ( idwwRefus.GetItemString  ( lCpt_Refus, "ID_PARA" ) )							
							If IsNull ( sVal ) Then sVal = ""
							If IsNull ( sIdPara  ) Then sIdPara = ""

							// Doublon, pièce déjà traitée
							If lCpt_Refus > 1 And idwwRefus.Find ( "ID_MOTIF = " + sVal + " AND ID_I = " + sIdInter + "", 1, lCpt_Refus - 1 ) > 0 Then Continue

							// Caractère interdit dans le XML.
							sVal = F_Remplace ( sVal, "&", " et " )
							sVal = F_Remplace ( sVal, '"', "''" )

							sIdPara = F_Remplace ( sIdPara, "&", " et " )
							sIdPara = F_Remplace ( sIdPara, '"', "''" )
							
							sChaine  = Space (24) + sDeb + sTG_TrefusLig + Space (1) 
							sChaine += sTG_Col1 + sEgaleGuill + sVal + FinGuill + Space (1) 
							sChaine += sTG_Col2 + sEgaleGuill + sIdPara + FinGuill + Space (1) 							
							sChaine += sFin + sFerm

							iWrt = FileWrite ( iFic, sChaine)
							If iWrt < 0 Then 
								stMessage.sTitre		= "Impossible d'écrire le fichier XML"
								stMessage.Icon			= StopSign!
								stMessage.sCode		= "PI52003"
								F_Message ( stMessage )		
								Return -1
							End If
							
						Next 
						// /"t2Lig"		

					sChaine = Space (16) + sDeb + sFin + sTG_Trefus + sFerm
					iWrt = FileWrite ( iFic, sChaine)
					If iWrt < 0 Then 
						stMessage.sTitre		= "Impossible d'écrire le fichier XML"
						stMessage.Icon			= StopSign!
						stMessage.sCode		= "PI52003"
						F_Message ( stMessage )		
						Return -1
					End If	
					// "/T2"

					// "T3"  (les tableaux de paraplaf)
					sChaine  = Space (16) + sDeb + sTG_TparaPlaf + sFerm
					iWrt = FileWrite ( iFic, sChaine)
					If iWrt < 0 Then 
						stMessage.sTitre		= "Impossible d'écrire le fichier XML"
						stMessage.Icon			= StopSign!
						stMessage.sCode		= "PI52003"
						F_Message ( stMessage )		
						Return -1
					End If


						// "t3Lig"  (les Paraplaf)
						sChaine  = Space (20) + sDeb + sTG_TparaPlafLig + Space (1) 

						lTotParaPlaf = idwwParaPlafond.RowCount () 

						// Boucle sur le tableau des variable pour l'inter
						For lCpt_ParaPlaf = 1 To lTotParaPlaf
							
							If idwwParaPlafond.GetItemNumber ( lCpt_ParaPlaf, "ID_I" ) <> Long ( sIdInter ) Then Continue
							
							sVal = idwwParaPlafond.GetItemString ( lCpt_ParaPlaf, "ID_PARA" ) 
							If IsNull ( sVal ) Then sVal = ""

							// Doublon, pièce déjà traitée
							If lCpt_ParaPlaf > 1 And idwwParaPlafond.Find ( "ID_PARA = '" + sVal + "' AND ID_I = " + sIdInter + "", 1, lCpt_ParaPlaf - 1 ) > 0 Then Continue

							// Caractère interdit dans le XML.
							sVal = F_Remplace ( sVal, "&", " et " )
							sVal = F_Remplace ( sVal, '"', "''" )
							
							sChaine  = Space (24) + sDeb + sTG_TparaPlafLig + Space (1) 
							sChaine += sTG_Col1 + sEgaleGuill + sVal + FinGuill + Space (1) 
							sChaine += sFin + sFerm

							iWrt = FileWrite ( iFic, sChaine)
							If iWrt < 0 Then 
								stMessage.sTitre		= "Impossible d'écrire le fichier XML"
								stMessage.Icon			= StopSign!
								stMessage.sCode		= "PI52003"
								F_Message ( stMessage )		
								Return -1
							End If
							
						Next 
						// /"t3Lig"

					sChaine = Space (16) + sDeb + sFin + sTG_TparaPlaf + sFerm
					iWrt = FileWrite ( iFic, sChaine)
					If iWrt < 0 Then 
						stMessage.sTitre		= "Impossible d'écrire le fichier XML"
						stMessage.Icon			= StopSign!
						stMessage.sCode		= "PI52003"
						F_Message ( stMessage )		
						Return -1
					End If	
					// "/T3"

					// "T4"  (les tableaux de parainter)
					sChaine  = Space (16) + sDeb + sTG_TparaInter + sFerm
					iWrt = FileWrite ( iFic, sChaine)
					If iWrt < 0 Then 
						stMessage.sTitre		= "Impossible d'écrire le fichier XML"
						stMessage.Icon			= StopSign!
						stMessage.sCode		= "PI52003"
						F_Message ( stMessage )		
						Return -1
					End If


						// "t4Lig"  (les Paraplaf)
						sChaine  = Space (20) + sDeb + sTG_TparaInterLig + Space (1) 

						lTotParaInter = idwwParaInfo.RowCount () 

						// Boucle sur le tableau des variable pour l'inter
						For lCpt_ParaInter = 1 To lTotParaInter
							
							If idwwParaInfo.GetItemNumber ( lCpt_ParaInter, "ID_I" ) <> Long ( sIdInter ) Then Continue
							
							sVal = idwwParaInfo.GetItemString ( lCpt_ParaInter, "ID_PARA" ) 
							If IsNull ( sVal ) Then sVal = ""

							// Doublon, pièce déjà traitée
							If lCpt_ParaInter > 1 And idwwParaInfo.Find ( "ID_PARA = '" + sVal + "' AND ID_I = " + sIdInter + "", 1, lCpt_ParaInter - 1 ) > 0 Then Continue

							// Caractère interdit dans le XML.
							sVal = F_Remplace ( sVal, "&", " et " )
							sVal = F_Remplace ( sVal, '"', "''" )
							
							sChaine  = Space (24) + sDeb + sTG_TparaInter + Space (1) 
							sChaine += sTG_Col1 + sEgaleGuill + sVal + FinGuill + Space (1) 
							sChaine += sFin + sFerm

							iWrt = FileWrite ( iFic, sChaine)
							If iWrt < 0 Then 
								stMessage.sTitre		= "Impossible d'écrire le fichier XML"
								stMessage.Icon			= StopSign!
								stMessage.sCode		= "PI52003"
								F_Message ( stMessage )		
								Return -1
							End If
							
						Next 
						// /"t4Lig"

					sChaine = Space (16) + sDeb + sFin + sTG_TparaInter + sFerm
					iWrt = FileWrite ( iFic, sChaine)
					If iWrt < 0 Then 
						stMessage.sTitre		= "Impossible d'écrire le fichier XML"
						stMessage.Icon			= StopSign!
						stMessage.sCode		= "PI52003"
						F_Message ( stMessage )		
						Return -1
					End If	
					// "/T4"


	

// *****  Balise de fermeture	*****

				// "/tableaux"
				sChaine = Space (12) + sDeb + sFin + sTG_Tableau + sFerm
				iWrt = FileWrite ( iFic, sChaine)
				If iWrt < 0 Then 
					stMessage.sTitre		= "Impossible d'écrire le fichier XML"
					stMessage.Icon			= StopSign!
					stMessage.sCode		= "PI52003"
					F_Message ( stMessage )		
					Return -1
				End If	

			// "/courrier"
			sChaine = Space (8) + sDeb + sFin + sTG_Courrier + sFerm
			iWrt = FileWrite ( iFic, sChaine)
			If iWrt < 0 Then 
				stMessage.sTitre		= "Impossible d'écrire le fichier XML"
				stMessage.Icon			= StopSign!
				stMessage.sCode		= "PI52003"
				F_Message ( stMessage )		
				Return -1
			End If					
				
		// "/demande"
		sChaine = Space (4) + sDeb + sFin + sTG_Demande + sFerm
		iWrt = FileWrite ( iFic, sChaine)
		If iWrt < 0 Then 
			stMessage.sTitre		= "Impossible d'écrire le fichier XML"
			stMessage.Icon			= StopSign!
			stMessage.sCode		= "PI52003"
			F_Message ( stMessage )		
			Return -1
		End If

	// "/liste_demande"
	sChaine = sDeb + sFin + sTG_ListeDem + sFerm
	iWrt = FileWrite ( iFic, sChaine)
	If iWrt < 0 Then 
		stMessage.sTitre		= "Impossible d'écrire le fichier XML"
		stMessage.Icon			= StopSign!
		stMessage.sCode		= "PI52003"
		F_Message ( stMessage )		
		Return -1
	End If
	
	iWrt = FileClose ( iFic )
	If iWrt < 0 Then 
		stMessage.sTitre		= "Impossible d'écrire le fichier XML"
		stMessage.Icon			= StopSign!
		stMessage.sCode		= "PI52003"
		F_Message ( stMessage )		
		Return -1
	End If
	
Next 

Return iRet
end function

public function string uf_generer_courrier (ref string asdatainter[], string astypetrt, boolean abaltedit, boolean abaltbloc, ref boolean abaumoinuncourrier, ref s_pass anvtrtattribgencour, ref s_pass atabvariable[], ref string atabcodevar[]);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_Generer_Courrier		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: (Réf)		String					asDataInter		Tableau des Datas pour les interlocuteurs
//*					  (Val)		String					asTypeTrt		Type de Traitement.
//*					  (Val)		Boolean					abAltEdit		Edition demandée sur le sinistre ?
//*					  (Val)		Boolean					abAltBloc		Blocage du dossier demandée sur le sinistre ?
//*					  (Réf)		Boolean					abAuMoinUnCourrier	Voir Objet sinistre, uf_controler_gestion
//*					  (Réf)		s_Pass					anvTrtAttribGenCour	Structure de retour #1
//*					  (Réf)		s_Pass					aTabVariable[]	[PI052] Tableau de tableaux des variables par interlocuteur
//*					  (Réf)		string					aTabCodeVar[]	[PI052] Tableau des codes de variables
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1		JFF/DGA  06/04/2006 Migration PB8-SPB-04/2006
//* #2      JFF		07/04/2006  Migration PB8-SPB-04/2006
//          JFF      12/06/2014 [PI052]
//          JFF      03/12/2019 [TRACE_TS_COURRIER]
//*-----------------------------------------------------------------

long ll_ret, lDeb, lFin 
String	sNul[]
String	sRet, sVal, sDecision 
n_cst_string lnvPFCString
Integer iRet

/*------------------------------------------------------------------*/
/* On arme les instances nécessaires au traitement des courriers.   */
/*------------------------------------------------------------------*/
isDataInter = sNul
isDataInter = asDataInter
ibAltEdit	= abAltEdit
ibAltBloc	= abAltBloc

/*------------------------------------------------------------------*/
/* On positionne le StaticText.                                     */
/*------------------------------------------------------------------*/

// [POSITION_SIMPA2]
istPause.text = space (70 ) + "Génération des courriers en cours, veuillez patienter... ~n~r~n~r(ne faites aucune action au clavier, ni à la souris pendant la génération des courriers svp !)" + space (150 )

istPause.BackColor 	= 12639424
istPause.X				=  950
istPause.Y				=  400
istPause.Height		=  350	

// [PI052]
/*
If F_CLE_A_TRUE ( "PI052" ) Then
	istPause.Width		= 1560
Else */
	istPause.Width		= 1540	
// End If


// [PI052]
iTabVariable = aTabVariable
iTabCodeVar  = aTabCodeVar


Choose Case asTypeTrt
Case "CHOIX"

	// [PI052]	
	This.uf_PI052_DroitParam ( "DESACT" )
	ibTimerPI052 = False
	ibFinGenerationPDFOk = False
	iTabCleFichier = sNul
	iTabCleKslEdt = sNul
	iTabCleFichierLocal = sNul 
	isCleRep = ""
	isExtFicOut = ""

	This.uf_PI052_DroitParam ( "RECH" )
	
	
/*------------------------------------------------------------------*/
/* On populise la DW pour la table W_COUR et la DW de stockage      */
/* pour la genération des courriers en automatique. Les codes       */
/* courriers, la composition et la zone ALT_PART sont correctement  */
/* armés à ce niveau. (Voir uf_CompositionCourrier de               */
/* U_Sa_Compo_Inter.)                                               */
/*------------------------------------------------------------------*/
	This.uf_Populiser_DwGenerationCourrier ()

/*------------------------------------------------------------------*/
/* Affichage des courriers WORD.                                    */
/*------------------------------------------------------------------*/
/* Premier passage.                                                 */
/*------------------------------------------------------------------*/
/* Uf_CourWord_ViderWord ( FALSE )                                  */
/* Uf_CourWord_PurgerCourriersLocal ( FALSE )                       */
/* Uf_CourWord_PopuliserDwChoix ()                                  */
/*------------------------------------------------------------------*/
	sRet = This.uf_CourWord ( 1 )
/*------------------------------------------------------------------*/
/* Y-a-t-il au moins un courrier à générer ?                        */
/*------------------------------------------------------------------*/
	abAuMoinUnCourrier = idwChoixCourGen.RowCount () > 0	

	// #2 Armement boolean dans la structure
	anvTrtAttribGenCour.bTab[1] = abAuMoinUnCourrier 

	If	abAuMoinUnCourrier Then
/*------------------------------------------------------------------*/
/* Ouverture de la fenêtre de choix de regénération.                */
/*------------------------------------------------------------------*/
		If	sRet = ""	Then
			anvTrtAttribGenCour.dwNorm[1]	= iDddwTypeDoc
			anvTrtAttribGenCour.dwNorm[2]	= idwChoixCourGen

			anvTrtAttribGenCour.dwTab[1]		= idwLstInter
			anvTrtAttribGenCour.sTab[1]		= isIdAppli
			anvTrtAttribGenCour.sTab[2]		= isAutresDroits
			
		End If
	End If

// #1 Nouveau cas pour gèrer la scission du cas "CHOIX"
Case "CHOIX_2"

	/*------------------------------------------------------------------*/
	/* Deuxiéme passage.                                                */
	/* Uf_CourWord_MajDwGenCour ()                                      */
	/* Uf_CourWord_AfficherCourrier ()                                  */
	/*------------------------------------------------------------------*/
	// #1 Code déporté
	istPause.Show ()
	
	// #1 Code déporté
	istPause.BringToTop	= TRUE

	// #1 Code déporté
	sRet = This.uf_CourWord ( 2 )

// #1 Nouveau cas pour gèrer la scission du cas "CHOIX"
Case "CHOIX_FIN"
	
	// #1 Dans tous les cas on remet la souris pointer flèche
	SetPointer ( Arrow! )

	// #1 Dans tous les cas on cache la statictext de pause.
	istPause.Hide ()
	
	// [PI052]
/*	
	If F_CLE_A_TRUE ( "PI052" ) Then
		sDecision = "CONTINUER"
		If UpperBound ( anvtrtattribgencour.sTab ) >= 2 Then
			If anvtrtattribgencour.sTab[2] = "ARRETER" Then
				sDecision = anvtrtattribgencour.sTab[2] 
			End If
		End If
		
		If ibPI052_GenEdtKsl And sDecision = "CONTINUER" Then
			iRet = uf_PI052 ( "2EME_TOUR" )
			If iRet < 0 Then
				sRet = "STOP"
			End If
		End If
	End If 
*/	

Case "VALIDER"
	
	// [CONVERT_PDF_STOCK]
	If F_CLE_A_TRUE ( "CONVERT_PDF_STOCK_1" ) Then
		istPause.text = space (70 ) + "~n~rLe système travaille, veuillez patienter svp... ~n~r~n~r(ne faites aucune action au clavier, ni à la souris, svp !)" + space (150 )
		
		istPause.BackColor 	= 12639424
		istPause.X				=  950
		istPause.Y				=  400
		istPause.Height		=  350	
		
		istPause.Show ()
		istPause.BringToTop	= TRUE
		
		sRet = uf_CourWord ( 3 )

	Else 		
		sRet = uf_CourWord ( 3 )
	End If	

Case "SUITE_VALIDER"
	
	// [CONVERT_PDF_STOCK]
	If F_CLE_A_TRUE ( "CONVERT_PDF_STOCK_1" ) Then
		istPause.text = space (70 ) + "~n~rLe système travaille, veuillez patienter svp... ~n~r~n~r(ne faites aucune action au clavier, ni à la souris, svp !)" + space (150 )
		
		istPause.BackColor 	= 12639424
		istPause.X				=  950
		istPause.Y				=  400
		istPause.Height		=  350	
		
		istPause.Show ()
		istPause.BringToTop	= TRUE
		
		sRet = uf_CourWord ( 4 )

		istPause.Hide ()		

	Else 		
		sRet = uf_CourWord ( 4 )
	End If	

End Choose

Return ( sRet )




end function

public function integer uf_initialiser (string asidappli, ref listbox albfichier, ref datawindow adwgencourrier, ref datawindow adwchoixcourgen, ref statictext astpause, ref datawindow adddwtypedoc, ref datawindow adwwcoursve, ref datawindow adwwcourblobsve, ref datawindow adwcompo, ref u_datawindow adw_1, ref datawindow adwdetpro, ref datawindow adwwpiece, ref datawindow adwwrefus, ref datawindow adwwparaplafond, ref datawindow adwwparainfo);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_Initialiser			(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libellé			: 
//* Commentaires	: On prépare toutes les variables dont on va avoir besoin
//*
//* Arguments		: (Val)		String					asIdAppli				Nom de l'application
//*					  (Réf)		ListBox					albFichier				ListBox posé sur la fenêtre
//*					  (Réf)		DataWindow				adwGenCourrier			DataWindow External posée sur la fenêtre
//*					  (Réf)		DataWindow				adwChoixCourRegen		DataWindow External posée sur la fenêtre
//*					  (Réf)		StaticText				astPause					StaticText posé sur la fenêtre
//*					  (Réf)		DataWindow				aDddwTypeDoc			DDDW sur les types de document
//*					  (Réf)		DataWindow				aDwwCourSve				DW sur la table W_COUR
//*					  (Réf)		DataWindow				aDwwCourBlobSve		DW sur la table W_COURRIER_BLOB
//*					  (Réf)		DataWindow				aDwCompo					DW pour la composition d'un courrier
//*					  (Réf)		Data						aDw_1						DW_1
//*					  (Réf)		U_DataWindow			aDwDetPro
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date		Modification
//* #1	JCA		16/05/2007	DCMP 070051 - Fusion des tables [courrier] et composition] en [cour_prod]
//* 		JFF      25/10/2011  [PC363][LOGO_AUCHAN]
//       JFF   	12/06/2014 	[PI052]
//*-----------------------------------------------------------------

isIdAppli = asIdAppli

/*------------------------------------------------------------------*/
/* En fonction de l'application SAVANE, SIMPA2, SINDI les noms de   */
/* colonnes sont différents. Il faut donc armer une constante pour  */
/* que cette fenêtre puisse fonctionner dans tous les cas de        */
/* figure.                                                          */
/*------------------------------------------------------------------*/
Choose Case isIdAppli
Case "SAVANE"
	isZn_IdInter	= "ID_I"
	isZn_CodInter	= "COD_I"
	isFicEntete		= ProfileString ( stGLB.sFichierIni, "EDITION", "ENTETE", "" )

Case "SIMPA2"
	isZn_IdInter	= "ID_I"
	isZn_CodInter	= "COD_INTER"

Case "SINDI"
	isZn_IdInter	= "ID_INTER"
	isZn_CodInter	= "COD_I"
End Choose

/*------------------------------------------------------------------*/
/* On positionne une instance pour la ListBox. Cet objet sert dans  */
/* la fonction uf_CourWord_PurgerCourriersLocal ().                 */
/*------------------------------------------------------------------*/
ilb_Fichier = albFichier

/*------------------------------------------------------------------*/
/* On positionne une instance pour le NVUO sur les fonctions        */
/* Windows.                                                         */
/*------------------------------------------------------------------*/
invWin = stGLB.uoWin

/*------------------------------------------------------------------*/
/* On positionne le DataObjet pour la DW servant au stockage des    */
/* courriers à générer.                                             */
/*------------------------------------------------------------------*/
idwGenCourrier = adwGenCourrier

/*------------------------------------------------------------------*/
/* On positionne le DataObjet pour la DW servant au traitement du   */
/* choix des courriers à générer.                                   */
/*------------------------------------------------------------------*/
idwChoixCourGen = adwChoixCourGen
istPause = astPause

/*------------------------------------------------------------------*/
/* On positionne une instance sur la DDDW qui contient les types    */
/* de documents.                                                    */
/*------------------------------------------------------------------*/
iDddwTypeDoc = aDddwTypeDoc

/*------------------------------------------------------------------*/
/* On positionne une instance sur la DW qui permet de récupérer     */
/* les lignes de la table W_COUR.                                   */
/*------------------------------------------------------------------*/
idwwCourSve	= adwwCourSve

/*------------------------------------------------------------------*/
/* On positionne une instance sur la DW qui permet de récupérer     */
/* les lignes de la table W_COUR_BLOB.                              */
/*------------------------------------------------------------------*/
idwwCourBlobSve	= adwwCourBlobSve

/*------------------------------------------------------------------*/
/* DataWindow pour récupérer la composition lors de la création     */
/* d'un double du courrier.                                         */
/*------------------------------------------------------------------*/
idwCompo	= adwCompo

/*------------------------------------------------------------------*/
/* La DW D_Sa_Lst_Paragraphe ne posséde par d'ordre de Tri. Pour    */
/* le pas perturber le 'bon' fonctionnement de SAVANE, je           */
/* positionne ici un ordre de tri dynamique.                        */
/*------------------------------------------------------------------*/
idwCompo.SetSort ( "ID_ORDRE A" )

/*------------------------------------------------------------------*/
/* DataWindow pour récupérer la dw_1									     */
/*------------------------------------------------------------------*/
idw_1	= adw_1

// [PC363][LOGO_AUCHAN]
idwDetPro = adwDetPro

// [PI052]
idwwPiece = adwwPiece 
idwwRefus = adwwRefus 
idwwParaPlafond = adwwParaPlafond 
idwwParaInfo = adwwParaInfo 
isTextStPause = istPause.text
// :[PI052]


Return ( 1 )
end function

public function integer uf_pi052_gestiontimer (string ascas, integer aidelai);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_PI052_GestionTimer			(PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 12/06/2014
//* Libellé			: 
//* Commentaires	: [PI052]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification
//*-----------------------------------------------------------------

String  sCleFicFix
String  sPathPDF
Integer iRet
Long 	  lDelaiAttenteMaxTimer

iRet = 1

// [PI052] en seconde, pas en seconde, voir la fréquence timer pour faire le calcul.
lDelaiAttenteMaxTimer = Long ( ProfileString ( stGlb.sFichierIni, "EDITION", "DELAI_PI052_ATTENTE_MAX_TIMER", "20" ) )


Choose Case Upper ( asCas ) 
	Case "DECLENCHER_TIMER"

		SetPointer ( HourGlass! )
		istPause.Show ()
		istPause.BringToTop	= TRUE
		
		ilNbreTour = 0
		ibTimerPI052 = True
		Timer ( 0.1 )
		Timer ( aidelai  )
		
	Case "ARRETER_TIMER"

		ibTimerPI052 = FALSE
		Timer ( 0 )

	Case "SCRUTER"

		// 15 tour max sinion arrêt
		If ilNbreTour >= lDelaiAttenteMaxTimer And Not ibFinGenerationPDFOk Then
			SetPointer ( Arrow! )
			istPause.Hide ()			
			Return -1
		End If 
		
		// Incrément du nombre de tour, pour avoir le temps total : nbre tour x délai
		ilNbreTour ++

		istPause.text = isTextStPause + " " + String ( ( lDelaiAttenteMaxTimer * K_FrequenceTimer ) - ( ilNbreTour * K_FrequenceTimer ) ) + "s"
		
		sPathPDF	   = ProfileString ( stGlb.sFichierIni, "EDITION", "REP_PI052_KSL_RECUP_PDF", "" )
		sCleFicFix  = sPathPDF + isCleRep + "\"
		
		// [DEBUG][PI052]
		If stGlb.sCodOper = "JFF" Then
			sCleFicFix  = sPathPDF + "4093528_20140625102800_SIMPA2\"
		End If
		// /[DEBUG][PI052]
		
		If FileExists ( sCleFicFix + isFicFinGen ) Then 
			Timer (0.1)
			ibFinGenerationPDFOk = True
		End If
		
End Choose

Return iRet

end function

public function integer uf_pi052 (string ascas);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_PI052			(PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 12/06/2014
//* Libellé			: 
//* Commentaires	: [PI052]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification
//*-----------------------------------------------------------------

Integer iRet
String  sNul[]
Long    lTot

Choose Case ascas
	Case "1ER_TOUR"
		// Génération des courriers XML
		iRet = This.uf_PI052_Generer_XML ()
		
		// Déclenchement du timer d'attente de réception des courriers PDF toutes les K_FrequenceTimer secondes
		If iRet > 0 Then
			iRet = This.uf_PI052_GestionTimer ( "DECLENCHER_TIMER", K_FrequenceTimer  ) 
		End If

	Case "2EME_TOUR"
		
		// Récupération des PDF en local et suppression structure sur server
		iRet = This.uf_PI052_RecuperationCourrier ()
		
		// Affichage à l'écran si tout est ok.
		If iRet > 0 Then

			stMessage.sTitre		= "Afficher courrier ?"
			stMessage.Icon			= question!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= YESNO!
			stMessage.sCode		= "PI52007"
			
			if F_Message ( stMessage ) = 1 Then
				Choose Case Right ( isExtFicOut, 3 ) 
					Case "PDF"
						iRet = This.uf_PI052_AfficherPDF () 
					Case "DOC"
						iRet = This.uf_PI052_AfficherDoc () 					
				End CHoose 
			Else 
				lTot = UpperBound ( iTabCleFichierLocal )
				stMessage.sTitre		= "Courrier(s) généré(s)"
				stMessage.Icon			= INFORMATION!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sVar [1]   = String ( lTot )
				stMessage.sCode		= "PI52008"
				F_Message ( stMessage ) 
				
			End If
		End If

		// [PI052]	
// 	ibPI052_GenEdtKsl = False  Gêne à cet endroit pour la majdu Blob
		ibTimerPI052 = False
		ibFinGenerationPDFOk = False
		iTabCleFichier = sNul
//		iTabCleFichierLocal = sNul  j'aurai besoin des noms des fichiers pour les blober.
//		isCleRep = "" Gêne à cet endroit pour la majdu Blob

		// On remet le Enabled sur Valider et Disabled sur contrôler
		Yield ()
		idw_1.TriggerEvent ( "ue_MajEnabledBouton" )


End Choose 

Return iRet
end function

public function integer uf_pi052_afficherpdf ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_PI052_AfficherPDF			(PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 12/06/2014
//* Libellé			: 
//* Commentaires	: [PI052]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification

//*-----------------------------------------------------------------

Integer iRet, iCnt
Long    lTot, lCpt
String  sPathExeFix, sPathExeFic, sClassePdf
String sWindowClass
Ulong ulWnd

iRet = 1
sPathExeFix = F_GetPathAcrobatReader ()

lTot = UpperBound ( iTabCleFichierLocal )

// affichage
For lCpt = 1 To lTot
	sPathExeFic = F_Remplace ( sPathExeFix, "%1", iTabCleFichierLocal [ lCpt ]  )
	Run ( sPathExeFic, Normal! )
	
	// Redimension
	RegistryGet( "HKEY_CLASSES_ROOT\.pdf", "", sClassePdf ) 
	// Nom réél actuellement sous version 11  => sClassePdf = AcroExch.Document.11

	sWindowClass=""
                
	For iCnt=1 to 2
		 if Pos ( Upper ( sClassePdf ),"ACRO") > 0 Then 
			  if iCnt=1 Then sWindowClass="AdobeAcrobat"
			  if iCnt=2 Then sWindowClass="AcrobatSDIWindow"
		 End if

		 if Pos(Upper(sClassePdf),"FOX") > 0 Then sWindowClass="classFoxitReader"		 
		 
		 ulWnd= FindWindowA(sWindowClass,0) 
	
		 If ulWnd > 0 Then
			  MoveWindow(ulWnd,ilPos[1],ilPos[2],ilPos[4],ilPos[3],1)
//			  SetwindowPos(ulWnd,0,ilPos[1],ilPos[2],ilPos[4],ilPos[3],0)
			  exit
		 End if
	Next
	
	

Next 

Yield ()

// On remet le Enabled sur Valider et Disabled sur contrôler
idw_1.TriggerEvent ( "ue_MajEnabledBouton" )

Return iRet
end function

private function integer uf_courword_visuvalidation (ref string astypdoc);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_CourWord_VisuValidation		(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libellé			: 
//* Commentaires	: Visualisation des courriers en Validation
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  		Modification
//* #1 		 DGA      19/09/2006 Gestion d'un répertoire temporaire DCMP-060643
//* 
//*-----------------------------------------------------------------

Integer iRet
Long lTotInter, lCpt, lLig, lIdInter, lTotFichier, lIdProd 
String sTitre, sCodInter, sCodBac, sRepTmp, sJoker, sNomFic, sNomFicComplet, sRech
String  sNul []

iTabCleFichierLocal = sNul // [PI052]
iRet = 1

/*------------------------------------------------------------------*/
/* La première chose à faire est de populiser la DW pour la         */
/* génération des courrriers.                                       */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sRepTmp	= stGLB.sWinDir + "\TEMP\" 
sRepTmp	= stGLB.sRepTempo
sJoker	= sRepTmp + stGLB.sCodAppli + "*.DOC"
asTypDoc = "DOC" // [PI052]
lIdProd = iDw_1.GetItemNumber( 1, "ID_PROD" )


ilb_Fichier.Reset ()
ilb_Fichier.DirList ( sJoker, 0 )

lTotFichier = ilb_Fichier.TotalItems ()
lTotInter	= idwLstInter.RowCount ()
idwGenCourrier.Reset ()


// [PI052]
/*
If F_CLE_A_TRUE ( "PI052" ) Then
	If This.uf_PI052_DroitParam ( "INFO" )Then
			// [PI052]
		sRepTmp	= stGLB.sRepTempo
		sJoker	= sRepTmp + stGLB.sCodAppli + "*.PDF"
		asTypDoc = "PDF" // [PI052]		

		ilb_Fichier.Reset ()
		ilb_Fichier.DirList ( sJoker, 0 )
		
		lTotFichier = ilb_Fichier.TotalItems ()

		If lTotFichier <= 0 Then 
			// Autorisation Word/KSL
			sJoker	= sRepTmp + stGLB.sCodAppli + "*.DOC"
			asTypDoc = "DOC_KSL" // [PI052]	
		End If

		ilb_Fichier.Reset ()
		ilb_Fichier.DirList ( sJoker, 0 )
		
		lTotFichier = ilb_Fichier.TotalItems ()
	
		lTotInter	= idwLstInter.RowCount ()
		idwGenCourrier.Reset ()
	End If 
End If	
*/


For	lCpt = 1 To lTotFichier
		ilb_Fichier.SelectItem ( lCpt )
		sNomFic			= ilb_Fichier.SelectedItem ()
		sNomFicComplet = Upper ( sRepTmp + sNomFic )

		lIdInter			= Long ( Mid ( sNomFic, 5, 2 ) )
		sRech				= isZn_IdInter + " = " + String ( lIdInter ) 

		lLig				= idwLstInter.Find ( sRech, 1, lTotInter )
		sCodInter		= idwLstInter.GetItemString ( lLig, isZn_CodInter )
	
	   // [PI052]
		Choose Case asTypDoc
			Case "DOC"
				sTitre	= stGLB.sCodAppli + String ( lIdInter, "00" ) + "_" + sCodInter + ".DOC"		
			Case "DOC_KSL"				
				sTitre	= stGLB.sCodAppli + String ( lIdInter, "00" ) + "_" + sCodInter + ".DOC"						
				iTabCleFichierLocal [ lIdInter + 1 ] = sRepTmp + sTitre				
			Case "PDF"
			   // [PI052]
				sTitre	= stGLB.sCodAppli + String ( lIdInter, "00" ) + "_" + sCodInter + ".PDF"
				iTabCleFichierLocal [ lIdInter + 1 ] = sRepTmp + sTitre
		End Choose

		lLig = idwGenCourrier.InsertRow ( 0 )
		idwGenCourrier.SetItem ( lLig, "ID_SIN", ilIdSin )
		idwGenCourrier.SetItem ( lLig, "ID_INTER", lIdInter )
		idwGenCourrier.SetItem ( lLig, "ID_SEQ", 1 )
		idwGenCourrier.SetItem ( lLig, "ID_COUR", "BIDON" )
		idwGenCourrier.SetItem ( lLig, "TXT_COMPO", "BIDON" )
		idwGenCourrier.SetItem ( lLig, "TXT_DATA", "BIDON" )
		idwGenCourrier.SetItem ( lLig, "TITRE", sTitre )
		idwGenCourrier.SetItem ( lLig, "COD_BAC", "BAS" )
		idwGenCourrier.SetItem ( lLig, "ALT_GEN", "N" )
Next

Return ( iRet )
end function

public function boolean uf_pi052_droitparam (string ascas);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_PI052_DroitParam			(PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 12/06/2014
//* Libellé			: 
//* Commentaires	: [PI052]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification
//*-----------------------------------------------------------------
Long lDeb, lFin
String sVal
n_cst_string lnvPFCString
boolean bPI052_GenEdtKsl

/*
If F_CLE_A_TRUE ( "PI052" ) Then
	Choose Case asCas 
		Case "RECH", "INFO"
		
			// Recherche si le produit (et User en recette) est éligible au PI052
			F_RechDetPro ( lDeb, lFin, idwDetPro, iDw_1.GetItemNumber( 1, "ID_PROD" ), "-DP", 262 )
			If lDeb > 0 Then
				
				sVal = lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( lDeb, "VAL_CAR" ), "PHASE_RECETTE", ";")
				
				If Len ( Trim ( sVal ) ) = 0 Then
					If asCas = "INFO" Then
						bPI052_GenEdtKsl = TRUE
					Else
						ibPI052_GenEdtKsl = TRUE
					End If
				End If
				
				If Len ( Trim ( sVal ) ) > 0 Then
					If Pos ( sVal, "#" + stGlb.sCodOper + "#" ) > 0 Then
						If asCas = "INFO" Then
							bPI052_GenEdtKsl = TRUE
						Else
							ibPI052_GenEdtKsl = TRUE
						End If
					End If
				End If
				
			End If 
		Case Else // "DESACT"
			
			ibPI052_GenEdtKsl = FALSE

	End Choose
	
End If	
*/

Return bPI052_GenEdtKsl



end function

public function boolean uf_getautorisation2 (integer ainatoper, long alidprod);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_sinistre::uf_getautorisation2
//* Auteur			: FABRY JF
//* Date				: 09/09/2008 11:03:31
//* Libellé			: [VDOC13888]
//* Commentaires	: 
//*
//* Arguments		: value integer aiNatOper	 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Boolean bOk
Long lTrouve


SQLCA.ps_s01_autorisation (aiNatOper, stGlb.scodoper, alIdProd, lTrouve )	

bOk = lTrouve > 0

Return bOk



end function

public function integer uf_pi052_recuperationcourrier ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_PI052_RecuperationCourrier			(PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 12/06/2014
//* Libellé			: 
//* Commentaires	: [PI052]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification

//*-----------------------------------------------------------------

Integer iRet
Long    lTot, lCpt
String  sFicPDFSource, sFicPDFDest, sRepTmp, sPathPDF	
String  sNul []

iRet = 1
iTabCleFichierLocal = sNul 

sRepTmp	= stGLB.sRepTempo
sPathPDF	= ProfileString ( stGlb.sFichierIni, "EDITION", "REP_PI052_KSL_RECUP_PDF", "" )
lTot = UpperBound ( iTabCleFichier )

// Récup et copie en local.
For lCpt = 1 To lTot
	sFicPDFSource = iTabCleFichier [ lCpt ] 
	sFicPDFDest   = F_Remplace ( iTabCleFichier [ lCpt ], sPathPDF + isCleRep + "\", sRepTmp )

	iTabCleFichierLocal [ lCpt ] = sFicPDFDest
	iTabCleKslEdt [ lCpt ] = F_Remplace ( sFicPDFDest, sRepTmp, "" )
	iTabCleKslEdt [ lCpt ] = F_Remplace ( iTabCleKslEdt [ lCpt ], isExtFicOut, "" )
	
   iRet = FileCopy ( sFicPDFSource, sFicPDFDest , TRUE )

	If iRet <= 0 Then Exit	

	// On supprime la source du serveur
	// [DEBUG][PI052]
	If stGlb.sCodOper <> "JFF" Then
		FileDelete ( sFicPDFSource )
	End If

Next 

// Supp de marqueur fin.txt
If iRet > 0 Then
	// [DEBUG][PI052]
	If stGlb.sCodOper <> "JFF" Then
		FileDelete ( sPathPDF + isCleRep + "\" + isFicFinGen ) 
		RemoveDirectory ( sPathPDF + isCleRep )
	End If
End IF

Return iRet
end function

public function integer uf_pi052_verif_presence_courrier ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_pi052_verif_presence_courrier	(PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 22/08/2014
//* Libellé			: [PI052]
//* Commentaires	: On teste la présence de PDF sur le disque
//*
//* Arguments		: 
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  		Modification
//*-----------------------------------------------------------------

String sRepTmp, sNomFic, sJoker, sNomFicComplet, sRech, sTypDoc
Long lTotFichier, lCpt, lIdSin, lTot2, lCpt2
Date dDateFic
Time tHeureFic
Integer iRet

/*------------------------------------------------------------------*/
/* On récupére tous les fichiers du type                            */
/* C:\WINNT\TEMP\XXXX99_X*.*.                                       */
/*------------------------------------------------------------------*/
/* XXXX = Code de l'application sur 4 caractères obligatoires.      */
/* 99   = ID_INTER sur deux positions obligatoires (Ex:02,12).      */
/* 9    = COD_INTER.                                                */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sRepTmp	= stGLB.sWinDir + "\TEMP\" 

// [PI052]
For lCpt2 = 1 To 2

	iRet		= -1
	sRepTmp	= stGLB.sRepTempo

	// [PI052]
	Choose Case lCpt2 
		Case 1
			sJoker	= sRepTmp + "*.DOC"
			sTypDoc  = "Word"
		Case 2			
			sJoker	= sRepTmp + "*.PDF"	
			sTypDoc  = "PDF"			
		
	End Choose 

	ilb_Fichier.Reset ()
	ilb_Fichier.DirList ( sJoker, 0 )
	
	lTotFichier = ilb_Fichier.TotalItems ()
	
	If lTotFichier <= 0 Then 
		iRet = 1
	End If
	
	DO While iRet < 0 
		For	lCpt = 1 To lTotFichier
		
			ilb_Fichier.SelectItem ( lCpt )
			sNomFic			= ilb_Fichier.SelectedItem ()
			sNomFicComplet = Upper ( sRepTmp + sNomFic )
		
			/*------------------------------------------------------------------*/
			/* Dans tous les autres cas, on supprime le fichier WORD.           */
			/*------------------------------------------------------------------*/
			invWin.uf_SetFileAttributes ( sNomFicComplet , 0 ) // non protection du fichier
			If Not FileDelete ( sNomFicComplet ) Then
				iRet = -1
		
				stMessage.sTitre		= "uf_PI052_Verif_Presence_PDF"
				stMessage.Icon			= Information!
				stMessage.sCode		= "PI52011"
				stMessage.sVar[1]		= sTypDoc
				stMessage.bErreurG	= False				
				stMessage.bTrace  	= False
		
				F_Message ( stMessage )
				Exit
			Else 
				iRet = 1
			End If
		
		Next
	Loop
Next 

Return ( iRet )
end function

public function integer uf_pi052_afficherdoc ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_PI052_AfficherDoc			(PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 12/06/2014
//* Libellé			: 
//* Commentaires	: [PI052]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification

//*-----------------------------------------------------------------

Integer iRet, iCnt
Long    lTot, lCpt
String  sPathExeFix, sPathExeFic, sClasseWord
String sWindowClass
Ulong ulWnd

iRet = 1
sPathExeFix = F_GetPathWord ()

lTot = UpperBound ( iTabCleFichierLocal )

// affichage
For lCpt = 1 To lTot
	sPathExeFic = F_Remplace ( sPathExeFix, "%1", iTabCleFichierLocal [ lCpt ]  )
	Run ( sPathExeFic, Normal! )
	
	// Redimension
	RegistryGet( "HKEY_CLASSES_ROOT\.doc", "", sClasseWord ) 
	// Nom réél actuellement sous version 11  => sClasseWord = AcroExch.Document.11

	sWindowClass=""
                
	For iCnt=1 to 1
		 if Pos ( Upper ( sClasseWord ),"WORD") > 0 Then 
			  if iCnt=1 Then sWindowClass="OpusApp"
		 End if
	
		 ulWnd= FindWindowA(sWindowClass,0) 

		 If ulWnd > 0 Then
			  MoveWindow(ulWnd,ilPos[1],ilPos[2],ilPos[4],ilPos[3],1)
//			  SetwindowPos(ulWnd,0,ilPos[1],ilPos[2],ilPos[4],ilPos[3],0)
			  exit
		 End if
	Next
	
	

Next 

Yield ()

// On remet le Enabled sur Valider et Disabled sur contrôler
idw_1.TriggerEvent ( "ue_MajEnabledBouton" )

Return iRet
end function

public subroutine uf_set_typetrt (string astypetrt);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_Set_TypeTrt			(PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 10/12/2019
//* Libellé			: 
//* Commentaires	: Gestion de la trace des courriers sur TS
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification
//*-----------------------------------------------------------------

isTypeTrt = asTypeTrt


end subroutine

private function integer uf_courword_ctrle_docpdf_et_date_docword ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Saisie_Validation_Sinistre::uf_CourWord_Ctrle_docPDF_et_Date_DocWord	(PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 15/07/2025
//* Libellé			: 
//* Commentaires	: contrôle de la présence des PDF et des dates des Doc Word
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//*-----------------------------------------------------------------
Long lTotFichier, lCpt, lIdInter, lTotInter, lIdProd
String sIdI, sNomFic, sNomFicComplet, sRepTmp, sJoker, sNomFicCompletPDF
Integer iRet, iIdSeqCourrierPdf
Blob blBlob
Decimal {2} dcIdsin2, dcIdInter2, dcIdCpt2 
DateTime dtDateFichier
Date dDateFic
Time tHeureFic
OLEObject ole_word, ole_doc
Integer li_rc

/*------------------------------------------------------------------*/  
/* #2. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sRepTmp		= stGLB.sWinDir + "\TEMP\"
sRepTmp		= stGLB.sRepTempo
sJoker		= sRepTmp + stGLB.sCodAppli + "*.DOC"
lIdProd = iDw_1.GetItemNumber( 1, "ID_PROD" )

iRet			= 1

ilb_Fichier.Reset ()
ilb_Fichier.DirList ( sJoker, 0 )

lTotFichier = ilb_Fichier.TotalItems ()

For	lCpt = 1 To lTotFichier
/*------------------------------------------------------------------*/
/* Il vient d'y avoir une erreur dans le traitement précédent.      */
/* (lCpt-1). On arrête tout et on envoi un ROLLBACK.                */
/*------------------------------------------------------------------*/
		If	iRet = -1	Then Exit

		ilb_Fichier.SelectItem ( lCpt )
		sNomFic			= Upper ( ilb_Fichier.SelectedItem () )
		sNomFicComplet = Upper ( sRepTmp + sNomFic )
		lIdInter			= Long ( Mid ( sNomFic, 5, 2 ) )
		
		sNomFicCompletPDF = F_Remplace ( sNomFicComplet, ".DOC", ".PDF" ) // [CONVERT_PDF_STOCK]
		
		sIdI				= String ( lIdInter )

		invWin.uf_SetFileAttributes ( sNomFicComplet, 0 ) 

/*
		invWin.uf_GetLastWriteDateTime ( sNomFicComplet, dDateFic, tHeureFic )
		If	dDateFic = 2000-01-01 And FileExists ( sNomFicCompletPDF ) Then Continue
		If dDateFic <> 2000-01-01 Or Not FileExists ( sNomFicCompletPDF )Then
*/			
		FileDelete ( sNomFicCompletPDF )
		
		// Construction du PDF, Instanciation de Word via OLE
		If Not IsValid ( ole_word ) Then
			ole_word = CREATE OLEObject
			li_rc = ole_word.ConnectToNewObject ( "Word.Application" )
			ole_word.Visible = FALSE
		End IF 
		
		// Ouvrir le document Word
		ole_doc = ole_word.Documents.Open ( sNomFicComplet )
	
		// Sauvegarder au format PDF
		// Format 17 = wdFormatPDF
		ole_doc.SaveAs ( sNomFicCompletPDF, 17 )
	
		// Fermer le document
		ole_doc.Close(FALSE)
			
Next 

If IsValid ( ole_word ) Then 
	ole_word.Quit()
   SetNull ( ole_doc ) 
   ole_word.DisconnectObject()
   DESTROY ole_word	
End If 


Return ( iRet )
end function

on n_cst_saisie_validation_sinistre.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_saisie_validation_sinistre.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

