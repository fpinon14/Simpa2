$PBExportHeader$u_sp_gs_paragraphe.sru
$PBExportComments$---} User Object pour les contrôles de gestion relatifs aux paragraphes.
forward
global type u_sp_gs_paragraphe from u_spb_gs_anc
end type
end forward

global type u_sp_gs_paragraphe from u_spb_gs_anc
end type
global u_sp_gs_paragraphe u_sp_gs_paragraphe

type variables
Private :
String	isFicIni	// Fichier Ini de la Bible des Para.
end variables

forward prototypes
public function string uf_gs_sup_para (string asidpara)
private function string uf_nomfichierword ()
private function boolean uf_creerliste (string asnomdocword)
public subroutine uf_bibleparagraphes (ref u_datawindow_accueil adw_1, ref statictext ast_encours)
private function boolean uf_creerdocword (string asnomdocword, ref statictext ast_encours)
end prototypes

public function string uf_gs_sup_para (string asidpara);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_sup_para
//* Auteur			:	YP
//* Date				:	13/06/1997 17:28:19
//* Libellé			:	Vérification de l'absence de composition, de motif, de piece ou
//*					 	de produit en relation avec le paragraphe avant la suppression
//*					 	de celui-ci.
//* Commentaires	:
//*
//* Arguments		:	String		asIdPara		// Identifiant du paragraphe
//*														// à supprimer.
//* Retourne		:	String			"" 			--> Aucune contrainte d'intégrité
//*										sinon chaîne décrivant la/les contrainte(s)				
//*
//*-----------------------------------------------------------------

String 	sRet			= ""				// Chaîne de retour de la fonction.
String	sLiaison							// Mot de liaison de la chaine de message.

String 	sCompo		= ""				// Texte de presence de compo.
String 	sRefus		= ""				// Texte de presence de motif.
String 	sPiece		= ""				// Texte de presence de piece.
String	sProd			= ""				// Texte de présence de paragraphes d'infos pour un produit.

Long		lNbCompo						// Nombre de compositions en relation avec 
											// le paragraphe.
Long		lNbRefus						// Nombre de motifs en relation avec 
											// le paragraphe.
Long		lNbPiece						// Nombre de pieces en relation avec 
											// le paragraphe.
Long		lNbProd						// Nombre de Produit en relation avec 
											// le paragraphe.
lNbCompo		= 0
lNbRefus		= 0
lNbPiece		= 0
lNbProd = 0

/*-------------------------------------------------------------------*/
/* Recherche du nombre de composition en relation avec le paragraphe */
/*-------------------------------------------------------------------*/
itrTrans.IM_S02_COMPOSITION ( asIdPara, lNbCompo )


/*------------------------------------------------------------------*/
/* Recherche du nombre de Motifs en relation avec le paragraphe     */
/*------------------------------------------------------------------*/
itrTrans.IM_S03_MOTIF ( asIdPara, lNbRefus )


/*------------------------------------------------------------------*/
/* Recherche du nombre de Pieces en relation avec le paragraphe     */
/*------------------------------------------------------------------*/
itrTrans.IM_S03_PIECE ( asIdPara, lNbPiece )

/*------------------------------------------------------------------*/
/* Recherche du nombre de Produits en relation avec le paragraphe   */
/*------------------------------------------------------------------*/
itrTrans.IM_S01_PARAPROD ( asIdPara, lNbProd )


/*------------------------------------------------------------------*/
/* Construction de la chaine de retour.                             */
/*------------------------------------------------------------------*/

sLiaison = " et "

If lNbCompo <> 0 then

	sCompo = "des compositions"
   
	If lNbRefus <> 0 or lNbPiece <> 0 Or lNbProd <> 0 then

		sCompo = sLiaison + sCompo

		sLiaison = ", "

	End If

End if

If lNbRefus <> 0 then

	sRefus = "des motifs de refus"
   
	If lNbPiece <> 0 Or lNbProd <> 0 then
		
		sRefus = sLiaison + sRefus

		sLiaison = ", "

	End If

End if

If lNbPiece <> 0	Then	

	sPiece = "des pieces"

	If lNbProd <> 0 Then 

		sPiece = sLiaison + sPiece

		sLiaison = ", "

	End If

End If

If lNbProd <> 0 Then sProd = "des produits"


sRet = sProd + sPiece + sRefus + sCompo

Return ( sRet )
end function

private function string uf_nomfichierword ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_NomFichierWord  (Private)
//* Auteur			: Fabry JF
//* Date				: 09/04/1999 15:18:21
//* Libellé			: Ramène le nom du fichier word (choisi par l'utilisateur)
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: String, Nom du fichier
//*			
//*
//*-----------------------------------------------------------------
//* #1 DGA              19/09/2006              Gestion d'un répertoire temporaire DCMP-060643
//*-----------------------------------------------------------------

String			sNomComplet, sNomFic, sChemin, sNomDefaut
Int				iRetour, iPos, iRepMessBox
Boolean			bSuite = True
Int				iNbrPara												// Nbre de paragraphe qui vont être traités.

stMessage.bErreurG= TRUE
stMessage.sTitre  = "SIMPA2 - Bible des paragraphes"

sNomComplet = ""

//u_DeclarationFuncky	iuoDeclarationFuncky
//iuoDeclarationFuncky = CREATE u_DeclarationFuncky
//sNomDefaut	=	iuoDeclarationFuncky.uf_Windir () + "\TEMP\PARA" + stGlb.sCodAppli + ".DOC"
//DESTROY iuoDeclarationFuncky
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
sNomDefaut	=	stGLB.sRepTempo + "PARA" + stGlb.sCodAppli + ".DOC"

iNbrPara = iDw_1.RowCount()


stMessage.sCode	= "PARA020"
stMessage.Icon	   = QUESTION!
stMessage.Bouton	= YESNOCANCEL!
stMessage.sVar[1] = String ( iNbrPara )
stMessage.sVar[2] = sNomDefaut 

iRepMessBox = F_Message ( stMessage )


CHOOSE CASE iRepMessBox
	
	// OUI, on utilise le fichier par défaut
	CASE 1
		
		sNomComplet = sNomDefaut


	// NON, on n'utilise pas le fichier par défaut
	CASE 2


		iRetour = GetFileSaveName( "Nom du fichier word", sNomComplet, sNomFic, "", "Fichiers Word (*.DOC),*.DOC, Tous Fichiers (*.*),*.*")


		If iRetour > 0 Then 

			/*------------------------------------------------------------------*/
			/* On isole le chemin                                               */
			/*------------------------------------------------------------------*/

			iPos = len ( sNomComplet )

			Do While iPos > 0 and mid ( sNomComplet, iPos, 1 ) <> '\'
				iPos -= 1
			Loop

			sChemin = Left ( sNomComplet, iPos )


			/*------------------------------------------------------------------*/
			/* On contrôle le nom du fichier												  */
			/*------------------------------------------------------------------*/

			iPos = 1
			Do While iPos <= Len ( sNomFic ) and mid ( sNomFic, iPos, 1 ) <> '.' and iPos <= 8
				iPos += 1
			Loop

			sNomFic 	 = upper ( Left ( sNomFic, iPos - 1 ) + ".DOC" )
			sNomComplet = upper ( sChemin ) + sNomFic

		Else 

			/*------------------------------------------------------------------*/
			/* Dans ce cas l'utilisateur choisi d'ANNULER.                      */
			/*------------------------------------------------------------------*/

			sNomComplet = ""

		End IF



END CHOOSE


Return sNomComplet
end function

private function boolean uf_creerliste (string asnomdocword);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_CreerListe  (Private)
//* Auteur			: Fabry JF
//* Date				: 16/04/1999 11:13:14
//* Libellé			: Création d'une liste des paragraphes sur disque.
//* Commentaires	: Crée un fichier texte sur le répertoire temporaire de Windows
//*					  contenant la liste des paragraphes, qui sera utilisé ultérieurement par la macro Word.
//*					  J'utilise le même fichier que la fonction de Daniel dans w_accueil, soit C:\WIN\TEMP\LISTE.TXT.
//*					  De plus on suppose que la Dw_1 n'est pas vide, sans quoi on arrive pas jusqu'ici.
//*			
//* Arguments		: String		asNomDocWord		(VAL) 	// Nom du futur Document Word
//*
//* Retourne		: Boolean indiquant que l'écriture du fichier s'est déroulé normalement.
//*			
//*
//*-----------------------------------------------------------------
//* #1 DGA              19/09/2006              Gestion d'un répertoire temporaire DCMP-060643
//*-----------------------------------------------------------------

//u_DeclarationFuncky uoDeclarationFuncky //[I037] Migration FUNCKy
Boolean 		bOk = True
String		sEntete										// Ligne d'entete du fichier LISTE.TXT
String      sTab, sNew, sLigne, sRep  				// Variables de construction de chaînes
String		sFicData							
Int			iFichier										// Pointeur sur fichier Texte					
Int 			iCpt											// Compteur
Int			iNbreParaSel								// Nbre de paragraphes contenu dans la DataWindow

stMessage.bErreurG = TRUE
stMessage.sTitre  = "SIMPA2 - Bible des paragraphes"

/*------------------------------------------------------------------*/
/* On récupére le nom du fichier à créer                            */
/*------------------------------------------------------------------*/
//uoDeclarationFuncky = Create u_DeclarationFuncky
//sRep = uoDeclarationFuncky.uf_WinDir ()

// [DBG20241015131529340][CS_USPR_ALD_WINDIR] 
If F_CLE_NUMERIQUE ( "CS_USPR_ALD_WINDIR" ) >= 2 Then
	sRep= stGlb.uoWin.uf_getenvironment("USERPROFILE") 
Else
	sRep = stGlb.uoWin.uf_getwindowsdirectory( )
End IF 

/*------------------------------------------------------------------*/
/* On écrit cette information dans le fichier WIN.INI, pour que     */
/* l'on puisse le relire dans WORD                                  */
/*------------------------------------------------------------------*/
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//SetProfileString ( sRep + "\WIN.INI", "PB4OBJ", "ListeWinDir", sRep )
SetProfileString ( sRep + "\WIN.INI", "PB4OBJ", "ListeWinDir", stGLB.sRepTempo )

//Destroy uoDeclarationFuncky

/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sFicData	 = sRep + "\TEMP\LISTE.TXT"
//isFicIni  = sRep + "\TEMP\LISTE.INI"
sFicData		= stGLB.sRepTempo + "LISTE.TXT"
isFicIni		= stGLB.sRepTempo + "LISTE.INI"

/*------------------------------------------------------------------*/
/* On écrit les variables dans le fichier INI							  */
/*------------------------------------------------------------------*/

iFichier = FileOpen( isFicINI, LineMode!, Write!, Shared!, Replace!)

If iFichier > -1 Then
	
	FileWrite ( iFichier, "[Liste]" )

	//..Fichier Ini de l'application.
	FileWrite ( iFichier, "FichierIni=" + stglb.sFichierIni )

	//..Personne qui lance le traitement
	FileWrite ( iFichier, "User=" + stglb.sCodOper )

	//..Nom du doc Word à créer
	FileWrite ( iFichier, "DocWord=" + asNomDocWord )

	//..A la fin de la l'execution de la Macro, Terminé sera à Oui
	//..cela indiquera à l'Appli SIMPA2, que l'on peut détruire
	//..l'objet OLE.
	FileWrite ( iFichier, "Termine=Non" )

	//..En Retour, Nbre de paragraphes ouvert par word
	FileWrite ( iFichier, "NbrePara=0" )

	FileClose ( iFichier )

End If

/*------------------------------------------------------------------*/
/* Problème lors de l'ouverture du fichier.                         */
/*------------------------------------------------------------------*/
If iFichier = -1 Then

	bOk = False

	stMessage.sCode	= "PARA021"
	stMessage.Icon	   = EXCLAMATION!
	stMessage.Bouton	= OK!

	F_Message ( stMessage )

End If

/*------------------------------------------------------------------*/
/* Le fichier de données LISTE.TXT ne contiendra que trois	 		  */
/* colonne de iDw_1, soit id_para(1), cpt_ver(2), lib_para(3).      */
/* on construit une ligne d'entêtes pour le fichier Texte.		     */
/* Cette ligne d'entête ne servira pas dans la macro, c'est juste   */
/* pour comprendre le fichier et savoir de quelles colonnes il 	  */
/* s'agit en cas d'ouverture manuelle.										  */	
/*------------------------------------------------------------------*/

If bOk Then

	//..Je sépare les champs par un ';', car je ne peux pas 
   //..découper la chaîne sous word, s'il s'agit d'une tabulation.
	sTab		= ";"
	sEntete  = "ID_PARA" + sTab + "CPT_VER" + sTab + "LIB_PARA"


	/*------------------------------------------------------------------*/
	/* On écrit maintenant le fichier texte.                            */
	/*------------------------------------------------------------------*/

	iFichier = FileOpen( sFicData, LineMode!, Write!, Shared!, Replace!)

	If iFichier > -1 Then
	
		//..Ecriture de l'entête.
		FileWrite ( iFichier, sEntete )

		//..Nbre de paragraphes contenus dans la DataWindow d'accueil
		iNbreParaSel = iDw_1.RowCount()

		For iCpt = 1 To iNbreParaSel
			sLigne = ""
			sLigne = iDw_1.GetItemString ( iCpt, 1 )  + sTab +  &
						iDw_1.GetItemString ( iCpt, 2 )  + sTab +  &
						iDw_1.GetItemString ( iCpt, 3 ) 
	
			/*------------------------------------------------------------------*/
			/* On écrit la ligne, et on gère un problème éventuel.              */
			/*------------------------------------------------------------------*/
			If ( FileWrite ( iFichier, sLigne ) ) <= 0 Then
				bOk = False

				stMessage.sCode	= "PARA022"
				stMessage.Icon	   = EXCLAMATION!
				stMessage.Bouton	= OK!
				stMessage.sVar[1] = String (iCpt)

				F_Message ( stMessage )

				Exit

			End IF

		Next

		FileClose ( iFichier )

	End If

	/*------------------------------------------------------------------*/
	/* Problème lors de l'ouverture du fichier.                         */
	/*------------------------------------------------------------------*/
	If iFichier = -1 Then

		bOk = False

		stMessage.sCode	= "PARA023"
		stMessage.Icon	   = EXCLAMATION!
		stMessage.Bouton	= OK!

		F_Message ( stMessage )

	End If

End IF
Return bOk
end function

public subroutine uf_bibleparagraphes (ref u_datawindow_accueil adw_1, ref statictext ast_encours);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_BibleParagraphes (Public)
//* Auteur			: Fabry JF
//* Date				: 09/04/1999 14:50:24
//* Libellé			: Création d'un Document Word contenant la liste des paragraphe.
//* Commentaires	: 
//*
//* Arguments		: U_DataWindow_Accueil		aDw_1				(REF)	// Dw_1 posée sur w_a_sp_paragraphe
//*					  StaticText					ast_EnCours 	(VAL) // Affiche un message "En cours.."
//*
//* Retourne		: Rien
//*			
//*
//*-----------------------------------------------------------------


Boolean 			bSuite = True
String			sNomDocWord

iDw_1 = aDw_1

stMessage.bErreurG = TRUE
stMessage.sTitre  = "SIMPA2 - Bible des paragraphes"

/*------------------------------------------------------------------*/
/* S'il n'y a pas de paragraphes sélectionnés, on ne lance rien.    */
/*------------------------------------------------------------------*/
If iDw_1.RowCount() <= 0 Then
		
	bSuite = False

	stMessage.sCode	= "PARA024" 
	stMessage.Icon	   = INFORMATION!
	stMessage.Bouton	= OK!
	
	F_Message ( stMessage )

End IF


/*------------------------------------------------------------------*/
/* On détermine le nom du fichier WORD  dans lequel on écrira les   */
/* paragraphes.                                                     */
/*------------------------------------------------------------------*/
If bSuite Then

	sNomDocWord = uf_NomFichierWord ()

	If sNomDocWord = "" Then
		bSuite = False
	End If

End IF


/*------------------------------------------------------------------*/
/* Construction du fichier Texte contenant le code des              */
/* paragraphes,  le libéllé des paragraphes, la révision des        */
/* paragraphes.                                                     */
/*------------------------------------------------------------------*/
If bSuite Then

	bSuite = uf_CreerListe ( sNomDocWord )

End If


/*------------------------------------------------------------------*/
/* Ouverture de Word et lancement de la macro.                      */
/*------------------------------------------------------------------*/
If bSuite Then

	bSuite = uf_CreerDocWord ( sNomDocWord, ast_EnCours )

End If








end subroutine

private function boolean uf_creerdocword (string asnomdocword, ref statictext ast_encours);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_CreerDocWord (Private)
//* Auteur			: Fabry JF
//* Date				: 27/04/1999 14:24:00
//* Libellé			: Lancement de word et appel de la macro.
//* Commentaires	: On va maintenant créer le document Word contenant
//*					  les paragraphes sélectionnés, via Word.
//*
//* Arguments		: String			asNomDocWord		(VAL)	// Nom du document word à Ecrire.
//*					  StaticText	ast_EnCours			(REF)	// Affichage message "en cours..."
//*
//* Retourne		: Boolean
//*			
//*
//*-----------------------------------------------------------------

OleObject		OleWordBasic				// Objet word Basic
Boolean			bOk = True					// Booleen de retour
Int				iNbreDocOuv					// Nombre de document ouvert
String			sModele, sMacro


stMessage.sTitre  = "SIMPA2 - Bible des paragraphes"

/*------------------------------------------------------------------*/
/* Il faut d'abord récupérer les informations suivantes             */
/*  Modéle à utiliser                                               */
/*  Macro à lancer                                                  */
/*------------------------------------------------------------------*/

sMacro	= ProfileString ( stGLB.sFichierIni, "BIBLEPARA", "DEFAUTMACRO", "" )
sModele	= ProfileString ( stGLB.sFichierIni, "BIBLEPARA", "DEFAUTMODELE", "" )

If	sMacro = "" Or sModele = "" Then
	bOk = False

	stMessage.bErreurG = TRUE
	stMessage.sCode	 = "PARA025"
	stMessage.Icon	    = EXCLAMATION!
	stMessage.Bouton	 = OK!

	F_Message ( stMessage )

End If

/*------------------------------------------------------------------*/
/* Création de l'objet WordBasic                                    */
/*------------------------------------------------------------------*/
If bOk Then
	OleWordBasic  = Create OleObject
End IF

/*------------------------------------------------------------------*/
/* La connexion à Word doit fonctionner                             */
/*------------------------------------------------------------------*/

If bOk Then
	If ( OleWordBasic.ConnectToNewObject( "Word.Basic" ) < 0 ) Then

		bOk = False
		stMessage.sCode		= "ANCE007"
		stMessage.bErreurG	= TRUE
		stMessage.Icon	   	= EXCLAMATION!
		stMessage.Bouton		= OK!
		F_Message ( stMessage )	

	End If
End IF


/*------------------------------------------------------------------*/
/* Ouverture du modèle  Word.                                       */
/*------------------------------------------------------------------*/
If bOk Then

	SetPointer ( HourGlass! )

	ast_EnCours.Show()
	ast_EnCours.Text = "Création de la liste des paragraphes en cours, cela peut prendre plusieurs minutes, veuillez patienter..."

	OleWordBasic.FichierNouveau ( sModele, 0 )
	OleWordBasic.OutilsMacro ( sMacro, True )

	ast_EnCours.Hide()
	ast_EnCours.Text = ""

	SetPointer ( Arrow! )

End IF

/*------------------------------------------------------------------*/
/* Destruction de l'objet WordBasic, quel que soit l'état de fin du */
/* Traitement.																		  */
/*------------------------------------------------------------------*/
If bOk Then
	OleWordBasic.DisconnectObject()
End IF

Destroy OleWordBasic


/*------------------------------------------------------------------*/
/* On vérifie la bonne execution du traitement...                   */
/*------------------------------------------------------------------*/
If bOk Then
		
		Beep (1)
		stMessage.bErreurG = TRUE
		stMessage.Bouton	= OK!

		/*------------------------------------------------------------------*/
		/* Tout s'est déroulé normalement...										  */
		/*------------------------------------------------------------------*/
		If Upper ( ProfileString ( isFicIni, "LISTE", "TERMINE", "" ) ) = "OUI" Then
			iNbreDocOuv = ProfileInt ( isFicIni, "LISTE", "NBREPARA", 0 )			

			stMessage.sCode	= "PARA026"
			stMessage.Icon	   = INFORMATION!
			stMessage.sVar[1] = asNomDocWord
			stMessage.sVar[2] = String ( iNbreDocOuv )

			F_Message ( stMessage )


		/*------------------------------------------------------------------*/
		/* Le document existe déjà, et il impossible de l'effacer car il    */
		/* est ouvert par quelqu'un.                                        */
		/*------------------------------------------------------------------*/
		ElseIf Upper ( ProfileString ( isFicIni, "LISTE", "TERMINE", "" ) ) = "PBEFDOCWORD" Then

			stMessage.sCode	= "PARA027" 
			stMessage.Icon	   = EXCLAMATION! 
			stMessage.sVar[1] = asNomDocWord

			F_Message ( stMessage )


		/*------------------------------------------------------------------*/
		/* La macro ne s'est pas terminée normalement.                      */
		/*------------------------------------------------------------------*/
		Else

			stMessage.sCode	= "PARA028" 
			stMessage.Icon	   = EXCLAMATION! 
			stMessage.sVar[1] = asNomDocWord

			F_Message ( stMessage )


		End IF

End If


Return bOk




end function

on u_sp_gs_paragraphe.create
call super::create
end on

on u_sp_gs_paragraphe.destroy
call super::destroy
end on

