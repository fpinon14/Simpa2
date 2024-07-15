HA$PBExportHeader$n_cst_sp_paragraphe_2000.sru
forward
global type n_cst_sp_paragraphe_2000 from nonvisualobject
end type
end forward

global type n_cst_sp_paragraphe_2000 from nonvisualobject
end type
global n_cst_sp_paragraphe_2000 n_cst_sp_paragraphe_2000

type variables
Private :
	U_DataWindow		idw_1

	U_DeclarationWindows	invWin

	String			isFicSauve
	String			isTypeTrt

	String			isK_PARA_TMP = "PARA_TMP.DOC"
	String			isK_PARA_MODELE = "PARAGRAP.DOT"

	Date			idK_DATECREATION = Date ( "01/01/2000" )
	Time			itK_TIMECREATION = Time ( "23:59:00" )


	Statictext     istencours
	PictureButton  ipbencours
	PictureButton  iPbvalider
	PictureButton  iPbretour
	DataStore      ids_scission
Public Boolean        ibScission
end variables

forward prototypes
public function string uf_controlergestion ()
public function integer uf_controlerzone (string asnomcol, string asdata)
public function integer uf_gerermessage (string asnomcol)
private function integer uf_zn_altversion (string asnomcol, string asdata)
public function string uf_controlersaisie ()
public function integer uf_gestion_paragraphe ()
private function integer uf_recuperer_para_tmp ()
public function boolean uf_supprimer ()
public function boolean uf_valider ()
private function integer uf_sauvegarder_paragraphe (integer aitype)
private function string uf_verifier_sql (integer aitype, string asidpara, string asidcanal)
private function integer uf_traitement_datastore ()
public function boolean uf_preparer (string astypetrt, string asidpara, string asidcanal)
public function integer uf_annuler_encours ()
public subroutine uf_initialiser (ref u_datawindow adw_1, ref u_transaction atrtrans, ref statictext astencours, ref picturebutton apbencours, ref picturebutton apbvalider, ref picturebutton apbretour)
end prototypes

public function string uf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Spb_Paragraphe::uf_ControlerGestion		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 25/02/2000 15:40:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de Saisie
//*
//* Arguments		: Aucun
//*
//* Retourne		: String				"" ou Nom de la colonne en erreur
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1 MADM 08/06/2006 En mode cr$$HEX1$$e900$$ENDHEX$$ation on force la version  $$HEX2$$e0002000$$ENDHEX$$1
//*-----------------------------------------------------------------

String 		sNouvelleLigne, sPos, sAltEnCours, sTxtPara, sAltversion
Date			dModif
Time			tModif
String		sVarErr[]
Integer		iRet
Boolean		bOuvert

OleObject	OleWord
N_Cst_Word	nvWord

sNouvelleLigne	= "~r~n"
sPos				= ""
sVarErr[1] 		= sNouvelleLigne + " - Le paragraphe WORD " + sNouvelleLigne

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie s'il existe des documents ouverts dans WORD et non    */
/* sauvegard$$HEX1$$e900$$ENDHEX$$s. Si c'est le cas, on arr$$HEX1$$ea00$$ENDHEX$$te le controle de gestion.  */
/*------------------------------------------------------------------*/
OleWord = CREATE OleObject
F_SetVersionWord ( nvWord, TRUE )

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie si WORD est ouvert.                                   */
/*------------------------------------------------------------------*/
If	nvWord.uf_WordOuvert () > 0	Then bOuvert = TRUE

iRet = nvWord.uf_CreerOleObject_Word ( OleWord )
If	iRet < 0	Then
	F_SetVersionWord ( nvWord, FALSE )
	DESTROY OleWord

	stMessage.sTitre		= "N_Cst_Sp_Paragraphe_2000 - uf_ControlerGestion ()"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= True
	stMessage.sCode		= "EDI020"
	stMessage.bTrace		= FALSE

	f_Message ( stMessage )

	Return ( "ID_PARA" )
End If

If	bOuvert Then
/*------------------------------------------------------------------*/
/* Word est ouvert, on v$$HEX1$$e900$$ENDHEX$$rifie s'il existe des documents non        */
/* enregistr$$HEX1$$e900$$ENDHEX$$s. Si c'est le cas, on arr$$HEX1$$ea00$$ENDHEX$$te tout. Si ce n'est pas    */
/* le cas, on ferme tous les fichiers ouverts dans WORD.            */
/*------------------------------------------------------------------*/
	iRet = nvWord.uf_FichierOuvertDansWord ( OleWord, TRUE, FALSE )
	If	iRet < 0	Then
		F_SetVersionWord ( nvWord, FALSE )

		DESTROY OleWord
		Return ( "ID_PARA" )
	End If
End If
/*------------------------------------------------------------------*/
/* On positionne WORD en icone dans la barre de t$$HEX1$$e200$$ENDHEX$$ches.             */
/*------------------------------------------------------------------*/
nvWord.uf_AgrandirWord ( FALSE )
/*------------------------------------------------------------------*/
/* On est en cr$$HEX1$$e900$$ENDHEX$$ation ou en modification, on v$$HEX1$$e900$$ENDHEX$$rifie s'il existe    */
/* un fichier PARA_TMP.DOC dans le r$$HEX1$$e900$$ENDHEX$$pertoire temporaire de         */
/* WINDOWS. Si ce n'est pas le cas, ou si le fichier poss$$HEX1$$e900$$ENDHEX$$de une    */
/* date au 23/01/2001 23:59 cela signifie que la personne n'a       */
/* jamais sauvegard$$HEX2$$e9002000$$ENDHEX$$le document.                                   */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//If Not FileExists ( isFicSauve )	Then
If Not f_FileExists ( isFicSauve )	Then
//Fin Migration PB8-WYNIWYG-03/2006 CP


	stMessage.sTitre		= "N_Cst_Sp_Paragraphe_2000 - uf_ControlerGestion ()"
	stMessage.sVar			= sVarErr
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= True
	stMessage.sCode		= "PAR_023"
	stMessage.bTrace		= FALSE

	f_Message ( stMessage )

	sPos = "ID_PARA"
Else
	invWin.uf_GetLastWriteDateTime ( isFicSauve, dModif, tModif )
		
	If	String ( tModif ) = "23:59:00"	Then 
		stMessage.sTitre		= "N_Cst_Sp_Paragraphe_2000 - uf_ControlerGestion ()"
		stMessage.sVar			= sVarErr
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= True
		stMessage.sCode		= "PAR_023"
		stMessage.bTrace		= FALSE

		f_Message ( stMessage )

		sPos = "ID_PARA"
	Else
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le contenu du fichier dans le presse papier.         */
/*------------------------------------------------------------------*/
		nvWord.uf_CommandeWord ( 12, isFicSauve, OleWord )
		sTxtPara = ClipBoard ()
		idw_1.SetItem ( 1, "TXT_PARA", sTxtPara )
	End If
End If

F_SetVersionWord ( nvWord, FALSE )
DESTROY OleWord

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie si l'utilisateur va cr$$HEX1$$e900$$ENDHEX$$er une nouvelle r$$HEX1$$e900$$ENDHEX$$vision.      */
/* #1                                                               */
/*------------------------------------------------------------------*/
If	sPos = ""	Then
	If	isTypeTrt = "C"	Then
	   sAltversion = idw_1.GetItemString ( 1, "ALT_VERSION" )
		sAltversion  = "O"
		sAltEnCours = "N"
	Else
		IF idw_1.GetItemString ( 1, "ALT_VERSION" )  = "O"	Then
		   sAltEnCours = "N"
		ELSE
			sAltEnCours = "O"
		END IF	
	End If
	idw_1.SetItem ( 1, "ALT_ENCOURS", sAltEnCours )
End If

Return ( sPos )


end function

public function integer uf_controlerzone (string asnomcol, string asdata);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Spb_Paragraphe::uf_ControlerZone (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 25/02/2000 15:19:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On g$$HEX1$$e900$$ENDHEX$$re les zone en saisie
//*
//* Arguments		: (Val)	String		asNomCol
//*					  (Val)	String		asData
//*
//* Retourne		: Integer				Valeur de retour pour ItemChanged
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1  MADM 08/06/2006 projet DNTMAIL1 Ajout de la colonne ID_CANAL
//*     et traitement de la scission d'un paragraphe Multim$$HEX1$$e900$$ENDHEX$$dias en plusieurs paragraphes Monom$$HEX1$$e900$$ENDHEX$$dias
//*-----------------------------------------------------------------

Integer iRet, iAction, lcpt
Boolean 	bRet, bOkScission
String sFiltre, sIdPara, sIdCanal, sSQL, scanal, sPos, idpara
long   lNbTotMedias
String sMedias[2]
String  ls_Null

sPos				= ""

DatawindowChild   dwchildcanal

iRet = 0
SetNull (ls_Null)

sMedias[1] = "CO"
sMedias[2] = "MA"	

scanal = "MU"

Choose Case Upper ( asNomCol )
Case "ID_PARA"

	
	
 /*-------------------------------------------------------------------------------------------------*/
 /*En Mode Cr$$HEX1$$e900$$ENDHEX$$ation, on emp$$HEX1$$ea00$$ENDHEX$$che la cr$$HEX1$$e900$$ENDHEX$$ation d'un paragraphe qui a d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$fait l'objet d'une scission  */
 /*-------------------------------------------------------------------------------------------------*/	   
 IF	isTypeTrt = "C"	Then
	
 	Select id_para
 	Into  :sidpara
 	From sysadm.paragraphe
	Where id_canal <> :scanal
	And   id_para = :asdata 
 	USING	SQLCA		;
 
  IF sidpara = asdata then
	  stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des Paragraphes"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "PAR_032"

		f_Message ( stMessage )
		iRet = 1
		RETURN  1
	  	  
  END IF	 

 END IF


/*--------------------------------*/
/*#1 Ajout de la colonne ID_CANAL */
/*--------------------------------*/
Case "ID_CANAL"	

Case "LIB_PARA"
	
Case "ALT_VERSION"
	uf_Zn_AltVersion ( asNomCol, asData )

/*------------------------------------------------------------------*/
/* #1 Action sur la colonne alt_scinder qui d$$HEX1$$e900$$ENDHEX$$clenchera la scission */
/*------------------------------------------------------------------*/	
Case "ALT_SCINDER"

	// Cette partie est temporaire $$HEX2$$e0002000$$ENDHEX$$supprimer le jour de la mise en production d$$HEX1$$e900$$ENDHEX$$finitive
	Choose Case Upper (  stGlb.sCodOper )
		Case "JFF", "DGA", "MADM", "JCA", "PHG"
			bOkScission = True
		Case Else
			bOkScission = False
			Messagebox ("Information Op$$HEX1$$e900$$ENDHEX$$rateur" , "Cette fonctionnalit$$HEX2$$e9002000$$ENDHEX$$n'est pas encore en production, d'o$$HEX2$$f9002000$$ENDHEX$$l'impossibilit$$HEX2$$e9002000$$ENDHEX$$de proc$$HEX1$$e900$$ENDHEX$$der $$HEX2$$e0002000$$ENDHEX$$la scission pour le moment", Exclamation!)
			iRet = 2
			idw_1.Object.ALT_SCINDER[1] = 'N'
			idw_1.Uf_Proteger ( { "ID_CANAL" }, "1" )
			RETURN (iRET)
	End Choose
	// Fin temporaire
	
	
	IF asData= "O" And bOkScission THEN
			idw_1.Uf_Proteger ( { "ID_CANAL" }, "0" )
									
		/*------------------------------------------------------------------*/
		/* Demande de Confirmation avant Scission			    						*/
		/*------------------------------------------------------------------*/
		 stMessage.sTitre 		= "Scission d'un Paragraphe multim$$HEX1$$e900$$ENDHEX$$dia"
		 stMessage.sVar[ 1 ] 	= "le paragraphe"
		 stMessage.Bouton		= YesNo!
		 stMessage.Icon			= Exclamation!
		 stMessage.bErreurG	= FALSE
		 stMessage.sCode		= "CONF008"
		 stMessage.iDefautBouton	= 2	
		 iAction = f_Message ( stMessage )

		/*------------------------------------------------------------------*/
		/* Traitement suivant confirmation ou non de l'op$$HEX1$$e900$$ENDHEX$$rateur            */
		/*------------------------------------------------------------------*/
			//L'op$$HEX1$$e900$$ENDHEX$$rateur annule la scission
			If iAction = 2 Then 	
				iRet = 2
				idw_1.Object.ALT_SCINDER[1] = 'N'
				idw_1.Uf_Proteger ( { "ID_CANAL" }, "1" )
				RETURN (iRET)
				
			//L'op$$HEX1$$e900$$ENDHEX$$rateur confirme la scission	
			Else	
				
				sIdPara	= idw_1.GetItemString ( 1, "ID_PARA" )
								
				lNbTotMedias = UpperBound ( sMedias )
				For lcpt = 1 to lNbTotMedias
					sSQL = "Exec sysadm.PS_I01_PARAGRAPHE_SCISSION '" + sIdPara + "', '" + sMedias[lcpt] + "', 'DUPLICATION' "
					F_Execute ( sSQL, SQLCA )
					bRet = SQLCA.SqlCode = 0 And SQLCA.SqlDbCode = 0 
					If Not bRet Then 
						F_Commit ( SQLCA, FALSE )
						Exit
					End If 

				Next

				If bRet Then
	 		      sSQL = "Exec sysadm.PS_I01_PARAGRAPHE_SCISSION '"+ sIdPara +"', '', 'SUPPRESSION' "
					F_Execute ( sSQL, SQLCA )				
					bRet = SQLCA.SqlCode = 0 And SQLCA.SqlDbCode = 0 
					If Not bRet Then F_Commit ( SQLCA, FALSE )
				End If 
				
				//Commit final
				If bRet Then
					F_Commit (SQLCA , TRUE )
				End If
				
				sIdPara	= idw_1.GetItemString ( 1, "ID_PARA" )
				sIdCanal	= idw_1.GetItemString ( 1, "ID_CANAL" )			
      		// 22/05/2006 : MADM Projet DNTMAIL1 Ajout du canal
				idw_1.GetChild ( "ID_CANAL", dwchildcanal )
				sFiltre = "ID_CODE <> 'MU' "
				dwchildcanal.SetFilter ( sFiltre )
				dwchildcanal.Filter( )
				//idw_1.SetItem (1 , "ID_CANAL" , ls_Null)
				
				ipbvalider.Enabled = FALSE
				
				// 16/06/2006 : MADM Projet DNTMAIL1 La scission a eu lieu 
				ibScission = True
				
				ipbretour.TriggerEvent (Clicked!)
				
				
			END IF
	    ELSE
      	idw_1.Uf_Proteger ( { "ID_CANAL" }, "1" )
	   END IF
	
End Choose

Return ( iRet )



end function

public function integer uf_gerermessage (string asnomcol);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Spb_Paragraphe::uf_GererMessage		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 25/02/2000 15:23:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On g$$HEX1$$e900$$ENDHEX$$re les messages d'erreur de Dw_1 (ItemError)
//*
//* Arguments		: (Val)		String		asNomCol
//*
//* Retourne		: Integer				Valeur de retour pour ItemChanged
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1 MADM 08/06/2006 Projet DNTMAIL1 Ajout de la colonne ID_CANAL
//*-----------------------------------------------------------------

Integer	iRet
String 	sVarErr[]

iRet = 1

If	idw_1.ibErreur	Then

	stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des Paragraphes"
	stMessage.Icon		= Information!

	Choose Case Upper ( asNomCol )
	Case "ID_PARA", "ID_CANAL"
		stMessage.sCode		= "GENE003"
		stMessage.sVar[1] 	= "code du paragraphe"

	Case "LIB_PARA"
		idw_1.iiReset = 2

		stMessage.sVar[1] 	= "libell$$HEX2$$e9002000$$ENDHEX$$du paragraphe"
		stMessage.sCode		= "GENE003"

	End Choose

	F_Message ( stMessage )
	
	// [MIGPB8COR]
	//idw_1.uf_Reinitialiser ()
	iRet = idw_1.uf_Reinitialiser ()

End If

Return ( iRet )




end function

private function integer uf_zn_altversion (string asnomcol, string asdata);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Spb_Paragraphe::uf_Zn_AltVersion		(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 03/05/2000 17:06:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On veut cr$$HEX1$$e900$$ENDHEX$$er une nouvelle r$$HEX1$$e900$$ENDHEX$$vision
//*
//* Arguments		: (Val)		String		asNomCol
//*					  (Val)		String		asData
//*
//* Retourne		: Integer
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

String 				sCptVer
Integer 				iRet, iCptVer

iRet = 0
Choose Case asData
Case "O"
	sCptVer = idw_1.GetItemString ( 1, "CPT_VER", Primary!, TRUE )
	iCptVer = Long ( sCptVer )
	
	iCptVer ++
	sCptVer = String ( iCptVer, "000" )
	
	idw_1.SetItem ( 1, "CPT_VER", sCptVer )
	
Case "N"
	If	isTypeTrt = "C"	Then 
		sCptVer = "000"
	Else
		sCptVer = idw_1.GetItemString ( 1, "CPT_VER", Primary!, TRUE )
	End If
	
	idw_1.SetItem ( 1, "CPT_VER", sCptVer )
End Choose	
	
Return ( iRet )



end function

public function string uf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Spb_Paragraphe::uf_ControlerSaisie		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 25/02/2000 15:40:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Controle de Saisie
//*
//* Arguments		: Aucun
//*
//* Retourne		: String				"" ou Nom de la colonne en erreur
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1 MADM 08/06/2006 Projet DNTMAIL Ajout de la colonne ID_CANAL
//*-----------------------------------------------------------------

String 		sCol[ 3 ]			//sCol[ 2 ]
String		sErr[ 3 ]			//sErr[ 2 ]
String		sVal[ 3 ]			//sVal[ 2 ]
String		sVarErr[]
String 		sNouvelleLigne, sText, sPos, sRet 
Long 			lCpt, lNbrCol

sNouvelleLigne	= "~r~n"
lNbrCol			= UpperBound ( sCol )
sPos				= ""
sText				= sNouvelleLigne

lCpt = 1

sCol[ lCpt ]	= "ID_PARA"
lCpt ++
/*------------------------------------------------------------------*/
/* #1																					  */
/*------------------------------------------------------------------*/
sCol[ lCpt ]	= "ID_CANAL"
lCpt ++

sCol[ lCpt ]	= "LIB_PARA"

lCpt = 1

sErr[ lCpt ]	= " - Le code du paragraphe"
lCpt ++

sErr[ lCpt ]	= " - Le canal du paragraphe"
lCpt ++

sErr[ lCpt ]	= " - Le libell$$HEX2$$e9002000$$ENDHEX$$du paragraphe"

/*------------------------------------------------------------------*/
/* On transforme toutes les chaines vides en NULL avant de          */
/* commencer.                                                       */
/*------------------------------------------------------------------*/
//Uf_Str2Null ()

/*------------------------------------------------------------------*/
/* Test des zones																	  */
/*------------------------------------------------------------------*/
sVal[ 1 ] = idw_1.GetItemString ( 1, sCol[ 1 ] )
sVal[ 2 ] = idw_1.GetItemString ( 1, sCol[ 2 ] )
sVal[ 3 ] = idw_1.GetItemString ( 1, sCol[ 3 ] )

For	lCpt = 1 To lNbrCol

		If ( IsNull ( sVal[ lCpt ] ) or Len ( Trim ( sVal[ lCpt ] ) ) = 0 )	Then
			If	sPos = "" 	Then	sPos = sCol[ lCpt ]
		
			sText = sText + sErr[ lCpt ] + sNouvelleLigne
		End If
Next
/*------------------------------------------------------------------*/
/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur         */
/*------------------------------------------------------------------*/
If	sPos <> "" Then
	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des Paragraphes"
	stMessage.Icon			= Information!
	stMessage.sVar[1] 	= sText
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "GENE001"

	f_Message ( stMessage )
Else
/*------------------------------------------------------------------*/
/* La zone ID_PARA doit contenir exactement 4 caract$$HEX1$$e800$$ENDHEX$$res.           */
/*------------------------------------------------------------------*/
	//If	Len ( Trim ( sVal[ 1 ] ) ) <> 4	Then
	If	Len ( Trim ( sVal[ 1 ] ) ) <> 4 OR Len (Trim ( sVal[ 2 ] )) <> 2	Then
		sPos = sCol[ 1 ]

		stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des Paragraphes"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "PAR_022"

		f_Message ( stMessage )
	End If
End If
/*------------------------------------------------------------------*/
/*#1 on va v$$HEX1$$e900$$ENDHEX$$rifier l'unicit$$HEX2$$e9002000$$ENDHEX$$du code paragraphe.                   */
/*------------------------------------------------------------------*/
If	sPos = "" And isTypeTrt = "C" Then
	
	sRet = This.uf_Verifier_Sql ( 2, idw_1.GetItemString ( 1, "ID_PARA" ), idw_1.GetItemString ( 1, "ID_CANAL" ) )
	If	sRet <> ""	Then

		stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des Paragraphes"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "PAR_025"

		f_Message ( stMessage )
		sPos = "ID_PARA"
	End If
End If


If sPos <> ""	Then
	idw_1.SetColumn ( sPos )
	idw_1.SetFocus ()
End If

Return ( sPos )


end function

public function integer uf_gestion_paragraphe ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Spb_Paragraphe::uf_Gestion_Paragraphe		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 23/03/2000 17:37:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rer un fichier PAR_TMP.DOC dans le r$$HEX1$$e900$$ENDHEX$$pertoire temporaire de WINDOWS.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer					 1 = Tout est OK
//*													-1 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1 MADM 08/06/2006 projet DNTMAIL1 Ajout de la colonne ID_CANAL
//*-----------------------------------------------------------------

Date					dModif
Time					tModif

OleObject			OleWord
N_Cst_Word			nvWord

Integer				iRet
String 				sFicIniApp, sModele, sRepCourrier, sWord, sCptVer, sFicPrec
String				sAltVersion, sAltEncours, sIdCanal, sRepPara, sRepModele

Boolean				bCreation, bOuvert

sFicIniApp			= stGLB.sFichierIni

/*------------------------------------------------------------------*/
/* Sur le clic du bouton Word on v$$HEX1$$e900$$ENDHEX$$rifie l'encours du paragraphe    */
/* Si Alt_encours est $$HEX2$$e0002000$$ENDHEX$$oui on alertera l'op$$HEX1$$e900$$ENDHEX$$rateur que le paragraphe*/
/* qui va $$HEX1$$ea00$$ENDHEX$$tre ouvert n'st pas celui pr$$HEX1$$e900$$ENDHEX$$sent dans le closier         */ 
/*------------------------------------------------------------------*/
sAltEncours = idw_1.getitemstring (1 , "ALT_ENCOURS" )
 IF sAltEncours = "O" THEN
	stMessage.sTitre		= "Information Op$$HEX1$$e900$$ENDHEX$$rateur"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= TRUE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "PAR_029"

	F_Message ( stMessage )
 End If

idw_1.Uf_Proteger ( { "ALT_VERSION" }, "0" )
/*------------------------------------------------------------------*/
/* On instancie un objet WORD. On ferme tous les documents          */
/* actuellement ouvert.                                             */
/*------------------------------------------------------------------*/
OleWord = CREATE OleObject
F_SetVersionWord ( nvWord, TRUE )

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie si WORD est ouvert.                                   */
/*------------------------------------------------------------------*/
If	nvWord.uf_WordOuvert () > 0	Then bOuvert = TRUE

iRet = nvWord.uf_CreerOleObject_Word ( OleWord )
If	iRet < 0	Then
	F_SetVersionWord ( nvWord, FALSE )
//Migration PB8-WYNIWYG-03/2006 FM
	If IsValid(OleWord) Then DESTROY OleWord	//	DESTROY OleWord
//Fin Migration PB8-WYNIWYG-03/2006 FM

	stMessage.sTitre		= "N_Cst_Sp_Paragraphe_2000 - uf_Gestion_Paragraphe()"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "EDI020"
	stMessage.bTrace  	= False

	F_Message ( stMessage )

	Return ( -1 )
End If

If	bOuvert Then
/*------------------------------------------------------------------*/
/* Word est ouvert, on v$$HEX1$$e900$$ENDHEX$$rifie s'il existe des documents non        */
/* enregistr$$HEX1$$e900$$ENDHEX$$s. Si c'est le cas, on arr$$HEX1$$ea00$$ENDHEX$$te tout. Si ce n'est pas    */
/* le cas, on ferme tous les fichiers ouverts dans WORD.            */
/*------------------------------------------------------------------*/
	iRet = nvWord.uf_FichierOuvertDansWord ( OleWord, TRUE, FALSE )
	If	iRet < 0	Then
		F_SetVersionWord ( nvWord, FALSE )

//Migration PB8-WYNIWYG-03/2006 FM
		If IsValid(OleWord) Then DESTROY OleWord	//DESTROY OleWord
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Return ( -1 ) 
	End If
End If

/*------------------------------------------------------------------*/
/* On positionne WORD en icone dans la barre de t$$HEX1$$e200$$ENDHEX$$ches.             */
/*------------------------------------------------------------------*/
nvWord.uf_AgrandirWord ( FALSE )
/*------------------------------------------------------------------*/
/* Si le fichier PARA_TMP.DOC existe et que sa date de cr$$HEX1$$e900$$ENDHEX$$ation     */
/* est toujours le 01/01/2000 23:59:00, on ne fait rien. On         */
/* affiche simplement le fichier.                                   */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//If	FileExists ( isFicSauve ) Then
If	f_FileExists ( isFicSauve ) Then
//Fin Migration PB8-WYNIWYG-03/2006 CP	
	
	invWin.uf_GetLastWriteDateTime ( isFicSauve, dModif, tModif )
	If	String ( tModif ) = "23:59:00" Then 
		bCreation = FALSE
	Else
/*------------------------------------------------------------------*/
/* Le fichier vient d'$$HEX1$$ea00$$ENDHEX$$tre sauvegard$$HEX1$$e900$$ENDHEX$$. On propose de le supprimer.  */
/*------------------------------------------------------------------*/
		stMessage.sTitre		= "N_Cst_Sp_Paragraphe_2000 - uf_Gestion_Paragraphe()"
		stMessage.Icon			= Question!
		stMessage.Bouton		= YesNo!
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "PAR_024"
		stMessage.bTrace  	= False

		iRet = F_Message ( stMessage )

		If	iRet = 1	Then	bCreation = TRUE
	End If
Else
	bCreation = TRUE
End If

If	bCreation Then
/*------------------------------------------------------------------*/
/* On va utiliser un mod$$HEX1$$e900$$ENDHEX$$le PARAGRAP.DOT qui est logiquement le     */
/* m$$HEX1$$ea00$$ENDHEX$$me que celui de l'application. Le mod$$HEX1$$e900$$ENDHEX$$le PARAGRAP.DOT poss$$HEX1$$e900$$ENDHEX$$de  */
/* simplement une liaison pour la fusion.                           */
/*------------------------------------------------------------------*/

/*--------------------------------------------------------------------*/
/* Selon le canal on va chercher le paragraphe dans le bon r$$HEX1$$e900$$ENDHEX$$pertoire */
/* 																					    */
/*                           													    */
/*--------------------------------------------------------------------*/
sIdCanal = idw_1.GetItemString ( 1, "ID_CANAL" )
	CHOOSE CASE sIdCanal
		Case 	"MU" , "CO"
			sRepModele	= ProfileString ( sFicIniApp, "EDITION", "REP_COURRIER", "" )
			sModele		= sRepModele + isK_PARA_MODELE

			sRepPara		= sRepModele

		
		Case 	"MA" 
			sRepModele	= ProfileString ( sFicIniApp, "EDITION", "REP_COURRIER", "" )
			sModele		= sRepModele + isK_PARA_MODELE

			sRepPara		= ProfileString ( sFicIniApp, "EDITION", "REP_COURMAIL", "" )


	END CHOOSE
	
/*------------------------------------------------------------------*/
/* On ouvre un fichier bas$$HEX2$$e9002000$$ENDHEX$$sur le mod$$HEX1$$e900$$ENDHEX$$le de document. On le        */
/* sauvegarde en fichier PARA_TMP.DOC                               */
/*------------------------------------------------------------------*/
	nvWord.uf_CommandeWord ( 1, sModele, OleWord )
/*------------------------------------------------------------------*/
/* Si la version du document est sup$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$0, on ins$$HEX1$$e900$$ENDHEX$$re          */
/* l'ancien document.                                               */
/*------------------------------------------------------------------*/
	sCptVer = idw_1.GetItemString ( 1, "CPT_VER" )
	If	Long ( sCptVer )	> 0	Then
		sFicPrec = sRepPara + idw_1.GetItemString ( 1, "ID_PARA" ) + "." + sCptVer
		nvWord.uf_CommandeWord ( 7, sFicPrec, OleWord )
	End If
	nvWord.uf_CommandeWord ( 8, isFicSauve, OleWord )
	nvWord.uf_CommandeWord ( 10, "", OleWord )

	invWin.uf_SetLastWriteDateTime ( isFicSauve, idK_DATECREATION, itK_TIMECREATION )
End If
/*------------------------------------------------------------------*/
/* Word $$HEX1$$e900$$ENDHEX$$tait en ouvert, on peut donc afficher le document via les  */
/* commandes OLE.                                                   */
/*------------------------------------------------------------------*/
If	bOuvert Then
	nvWord.uf_CommandeWord ( 3, isFicSauve, OleWord )
	nvWord.uf_AgrandirWord ( TRUE )
	nvWord.uf_CommandeWord ( 4, "POSITION WORD", OleWord )
Else
//	sWord = ProfileString ( sFicIniApp, "EDITION", "REP_WORD", "" )
//	sWord = sWord + " " + isFicSauve
// If	Not bOuvert	Then Run ( sWord, Maximized! )

	nvWord.uf_CommandeWord ( 3, isFicSauve, OleWord )
	nvWord.uf_AgrandirWord ( TRUE )
	nvWord.uf_CommandeWord ( 4, "POSITION WORD", OleWord )

End If

F_SetVersionWord ( nvWord, FALSE )
//Migration PB8-WYNIWYG-03/2006 FM
If IsValid(OleWord) Then DESTROY OleWord	//DESTROY OleWord
//Fin Migration PB8-WYNIWYG-03/2006 FM

Return ( 1 )

end function

private function integer uf_recuperer_para_tmp ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Spb_Paragraphe::uf_Recuperer_Para_Tmp		(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 25/02/2000 15:40:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer le BLOB qui contient le paragraphe.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer					 1 = Tout est OK
//*													-1 = Impossible de retrouver le fichier temporaire
//*													-2 = Erreur WORD
//*													-3 = Il existe des documents ouverts non sauvegard$$HEX1$$e900$$ENDHEX$$s
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1 MADM 08/06/2006 Projet DNTMAI1 Ajout de la colonne ID_CANAL
//*-----------------------------------------------------------------

Blob			blBlob
String		sIdPara, sIdCanal
Integer		iRet

N_Cst_Word	nvWord
OleObject	OleWord

/*------------------------------------------------------------------*/
/* Si WORD est ouvert, on supprime tous les documents ouverts       */
/* actuellement dans WORD.                                          */
/*------------------------------------------------------------------*/
OleWord = CREATE OleObject
F_SetVersionWord ( nvWord, TRUE )

If	nvWord.uf_WordOuvert () > 0	Then 
	iRet = nvWord.uf_CreerOleObject_Word ( OleWord )
	
	If	iRet < 0	Then
		F_SetVersionWord ( nvWord, FALSE )
		DESTROY OleWord

		stMessage.sTitre		= "N_Cst_Sp_Paragraphe_2000 - uf_Gestion_Paragraphe()"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "EDI020"
		stMessage.bTrace  	= False

		F_Message ( stMessage )

		Return ( -2 )
	End If
	
	iRet = nvWord.uf_FichierOuvertDansWord ( OleWord, TRUE, FALSE )
	
	If	iRet < 0	Then
		F_SetVersionWord ( nvWord, FALSE )

		DESTROY OleWord
		Return ( -3 ) 
	End If
End If
/*------------------------------------------------------------------*/
/* On positionne WORD en icone dans la barre de t$$HEX1$$e200$$ENDHEX$$ches.             */
/*------------------------------------------------------------------*/
nvWord.uf_AgrandirWord ( FALSE )

DESTROY OleWord
F_SetVersionWord ( nvWord, FALSE )
/*------------------------------------------------------------------*/
/* On est en cr$$HEX1$$e900$$ENDHEX$$ation, on ne fait rien. Le fichier sera cr$$HEX1$$e900$$ENDHEX$$e en     */
/* appuyant sur le bouton PARAGRAPHE.                               */
/*------------------------------------------------------------------*/
If	isTypeTrt = "C"	Then Return ( 1 )
/*------------------------------------------------------------------*/
/* S$$HEX1$$e900$$ENDHEX$$lection du BLOB dans la table PARAGRAPHE.                      */
/*------------------------------------------------------------------*/
iRet = 1

If	idw_1.GetItemString ( 1, "ALT_ENCOURS" ) = "O"	Then
	sIdPara = idw_1.GetItemString ( 1, "ID_PARA" )
	/*------------------------------------------------------------------*/
	/* #1 R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du canal pour la s$$HEX1$$e900$$ENDHEX$$lection du Blob               */
   /*------------------------------------------------------------------*/
	sIdCanal = idw_1.GetItemString ( 1, "ID_CANAL" )
	
	SELECTBLOB	txt_blob
	INTO			:blBlob
	FROM			sysadm.paragraphe
	WHERE			id_para = :sIdPara
	AND         id_canal = :sIdCanal
	USING	SQLCA		;
	/*------------------------------------------------------------------*/
	/* Le BLOB peut ne pas $$HEX1$$ea00$$ENDHEX$$tre valide.                                 */
	/*------------------------------------------------------------------*/
	If Len ( blBlob ) <= 0 Or IsNull ( blBlob ) Or SQLCA.SqlnRows <> 1	Then
		iRet = -1
	Else
	/*------------------------------------------------------------------*/
	/* On va cr$$HEX1$$e900$$ENDHEX$$er le fichier PARA_TMP.DOC dans le r$$HEX1$$e900$$ENDHEX$$pertoire           */
	/* temporaire de WINDOWS. Normalement, le fichier est supprim$$HEX7$$e900200020002000200020002000$$ENDHEX$$*/
	/* dans la fonction uf_Preparer ().                                 */
	/*------------------------------------------------------------------*/
		If	Not F_EcrireFichierBlob ( blBlob, isFicSauve )	Then Return ( -1 )
	/*------------------------------------------------------------------*/
	/* On positionne la date de CREATION du fichier.                    */
	/*------------------------------------------------------------------*/
		If	iRet = 1	Then 	invWin.uf_SetLastWriteDateTime ( isFicSauve, idK_DATECREATION, itK_TIMECREATION )
	End If
End If

Return ( iRet )

end function

public function boolean uf_supprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Spb_Paragraphe::uf_Supprimer			(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 25/02/2000 14:34:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation du NVUO
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1 MADM 08/06/2006 Projet DNTMAIL1 Ajout de la colonne ID_CANAL
//*-----------------------------------------------------------------

Boolean 	bRet
String 	sIdPara, sCptVer, sFichier, sRepCourrier, sFlag, sFicIniApp, sIdCanal
String 	sRet
Integer	iRet

/*------------------------------------------------------------------*/
/* Demande de Confirmation avant suppression                        */
/*------------------------------------------------------------------*/
stMessage.sTitre 		= "Suppression d'un Paragraphe"
stMessage.sVar[ 1 ] 	= "ce paragraphe"
stMessage.Bouton		= YesNo!
stMessage.Icon			= Exclamation!
stMessage.bErreurG	= TRUE
stMessage.sCode		= "CONF001"

iRet						= f_Message ( stMessage )

/*------------------------------------------------------------------*/
/* Traitement suivant confirmation ou non de l'op$$HEX1$$e900$$ENDHEX$$rateur            */
/*------------------------------------------------------------------*/
If iRet = 2 Then 	
	bRet = False
Else
	/*------------------------------------------------------------------*/
	/* V$$HEX1$$e900$$ENDHEX$$rification de l'int$$HEX1$$e900$$ENDHEX$$grit$$HEX2$$e9002000$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rencielle vis $$HEX2$$e0002000$$ENDHEX$$vis de la table  */
	/* COMPOSITION, MOTIF, PIECE et PARA_PROD                           */
	/*------------------------------------------------------------------*/
	sIdPAra 	= idw_1.GetItemString ( 1, "ID_PARA" )
	
	sIdCanal = idw_1.GetItemString ( 1, "ID_CANAL" )
	sRet		= uf_Verifier_Sql ( 1, sIdPara, sIdCanal )

	If ( sRet <> "" ) Then
		stMessage.sTitre 		= "Contr$$HEX1$$f400$$ENDHEX$$le avant Suppression d'un Paragraphe"
		stMessage.sVar[ 1 ] 	= sRet  
		stMessage.sVar[ 2 ] 	= "ce paragraphe"
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "REFU002"
		bRet 						= False

		f_Message ( stMessage )
	Else
		sFicIniApp		= stGLB.sFichierIni 
		sRepCourrier	= ProfileString ( sFicIniApp, "EDITION", "REP_COURRIER", "" )

		sIdPara			= idw_1.GetItemString ( 1, "ID_PARA" )
		sCptVer			= idw_1.GetItemString ( 1, "CPT_VER" )
		sFichier 		= sRepCourrier + sIdPara + "." + sCptVer

		sFlag = ProfileString ( sFicIniApp, "EDITION", "FLAG", "E:\PUBLIC\FLAG.EXE" )
		sFlag = sFlag + " " + sFichier + " +RW -SH -DI -RI"
		Run ( sFlag, Minimized! )

		FileDelete ( sFichier )
		/*------------------------------------------------------------------*/
		/* Suppression si aucun probl$$HEX1$$e800$$ENDHEX$$me d'int$$HEX1$$e900$$ENDHEX$$grit$$HEX25$$e900200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
		/*------------------------------------------------------------------*/
		idw_1.DeleteRow ( 0 )		
		bRet = True

	End If
End If

Return ( bRet )

end function

public function boolean uf_valider ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Spb_Paragraphe::uf_Valider		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 25/02/2000 15:40:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Validation Finale
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1 MADM 08/06/2006 Projet DNTMAIL Ajout de la colonne ID_CANAL 
//*-----------------------------------------------------------------

Boolean 	bRet, bLecture
Blob		blBlob
String	sAltEnCours, sIdPara, sAltversion, sIdCanal, sRepPara, sFichier, sCptVer
Integer	iRet
String 	sMedias[2,2], sFicIniApp


/*------------------------------------------------------------------*/	
/*MADM  On arme le r$$HEX1$$e900$$ENDHEX$$pertoire des m$$HEX1$$e900$$ENDHEX$$dias.                           */
/*------------------------------------------------------------------*/
sMedias[1,2] = ProfileString ( sFicIniApp, "EDITION", "REP_COURRIER", "" )
sMedias[2,2] = ProfileString ( sFicIniApp, "EDITION", "REP_COURMAIL", "" )


bRet = TRUE

sAltEnCours = idw_1.GetItemString ( 1, "ALT_ENCOURS" )

If	sAltEnCours = "O"	Then
/*------------------------------------------------------------------*/	
/* On va cr$$HEX1$$e900$$ENDHEX$$er un BLOB $$HEX2$$e0002000$$ENDHEX$$partir du fichier PARA_TMP. Si cela se     */
/* passe mal, on affiche un message d'erreur. Cela ne pose pas de   */
/* probl$$HEX1$$e800$$ENDHEX$$me puisqu'il n'y a pas de transaction en cours.            */
/*------------------------------------------------------------------*/
	bLecture = F_LireFichierBlob ( blBlob, isFicSauve )
	If	Not bLecture Then

		stMessage.sTitre		= "N_Cst_Sp_Paragraphe_2000 - uf_Valider ()"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= True
		stMessage.sCode		= "PAR_027"
		stMessage.bTrace		= FALSE

		f_Message ( stMessage )
		Return ( FALSE )
	End If
End If

Choose Case isTypeTrt
 Case "C"
/*------------------------------------------------------------------*/	
/* On positionne $$HEX2$$e0002000$$ENDHEX$$nouveau la valeur pour CREE_LE, MAJ_LE, MAJ_PAR. */
/*------------------------------------------------------------------*/
	F_CreeLe ( idw_1, 1 )
	F_MajPar ( idw_1, 1 )
	
/*------------------------------------------------------------------*/	
/* #1 En mode cr$$HEX1$$e900$$ENDHEX$$ation On force la version $$HEX2$$e0002000$$ENDHEX$$1, l'encours $$HEX2$$e0002000$$ENDHEX$$NON     */
/* Le champ canal est prot$$HEX1$$e900$$ENDHEX$$g$$HEX2$$e9002000$$ENDHEX$$et sa valeur est multim$$HEX1$$e900$$ENDHEX$$dias (MU)     */
/* Le champ scinder est invisible et prot$$HEX1$$e900$$ENDHEX$$g$$HEX25$$e900200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
/*------------------------------------------------------------------*/
   idw_1.SetItem ( 1, "CPT_VER", "001" )
   idw_1.SetItem ( 1, "ALT_ENCOURS", "N" )
	
	idw_1.SetItem ( 1, "ID_CANAL", "MU" )
   idw_1.Uf_Proteger ( { "ID_CANAL" }, "1" )
	
   idw_1.modify ("ALT_SCINDER.visible = 0")
   idw_1.Uf_Proteger ( { "ALT_SCINDER" }, "1" )
			
 Case "M"
/*------------------------------------------------------------------*/
/* On positionne $$HEX2$$e0002000$$ENDHEX$$nouveau la valeur pour MAJ_LE, MAJ_PAR.          */
/*------------------------------------------------------------------*/
	F_MajPar ( idw_1, 1 )
	
/*--------------------------------------------------------------------------*/	
/* #1 En mode Modification On se positionne sur la colonne alt_version      */
/* Si apr$$HEX1$$e900$$ENDHEX$$s modification du paragraphe on a coch$$HEX2$$e9002000$$ENDHEX$$le champ version          */
/* un message informera l'op$$HEX1$$e900$$ENDHEX$$rateur que le paragraphe modifi$$HEX2$$e9002000$$ENDHEX$$sera celui    */
/* de production (Pr$$HEX1$$e900$$ENDHEX$$sent dans le closier) sinon le paragraphe sera modifi$$HEX2$$e9002000$$ENDHEX$$*/
/* seulement en base.                                                       */
/*--------------------------------------------------------------------------*/	
   idw_1.SetRow(1)
	idw_1.SetColumn( "ALT_VERSION" )
	idw_1.TriggerEvent(ItemChanged!)
	
	sAltversion = idw_1.GetItemString ( 1, "ALT_VERSION" )
     IF sAltversion = "O" THEN
		  stMessage.sTitre		= "Information Op$$HEX1$$e900$$ENDHEX$$rateur"
		  stMessage.Icon			= Exclamation!
	     stMessage.bErreurG	= TRUE
	     stMessage.Bouton		= Ok!
	     stMessage.sCode		= "PAR_030"
		  
        F_Message ( stMessage )
	  ELSE
		  stMessage.sTitre		= "Information Op$$HEX1$$e900$$ENDHEX$$rateur"
		  stMessage.Icon			= Exclamation!
	     stMessage.bErreurG	= TRUE
	     stMessage.Bouton		= Ok!
	     stMessage.sCode		= "PAR_031"
		  
        F_Message ( stMessage )
     End If

End Choose

If	idw_1.Update () <= 0	Then bRet = FALSE
/*------------------------------------------------------------------*/
/* L'update se passe bien, on v$$HEX1$$e900$$ENDHEX$$rifie s'il faut positionner le      */
/* BLOB.                                                            */
/*------------------------------------------------------------------*/
If	bRet	Then
/*------------------------------------------------------------------*/	
/* Il faut d'abord faire un premier COMMIT afin de positionner la   */
/* valeur pour le BLOB.                                             */
/*------------------------------------------------------------------*/
	// COMMIT using idw_1.itrTrans		;
	F_COMMIT ( idw_1.itrTrans, TRUE ) // [PI056][TRANCOUNT][JFF][24/01/2020]
	
	sIdPara = idw_1.GetItemString ( 1, "ID_PARA" )
	/*------------------------------------------------------------------*/
	/*MADM #1 On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la valeur du canal (m$$HEX1$$e900$$ENDHEX$$dia)                    */
	/* Et on l'ajoute $$HEX2$$e0002000$$ENDHEX$$la clause where                                 */
	/*------------------------------------------------------------------*/
	sIdCanal = idw_1.GetItemString ( 1, "ID_CANAL" )

	/*------------------------------------------------------------------*/
	/* Probl$$HEX1$$e800$$ENDHEX$$me Myst$$HEX1$$e800$$ENDHEX$$re du 30/03/2004 (JFF): Voir SQLPreview de Dw_1    */
	/*------------------------------------------------------------------*/
	UPDATE sysadm.paragraphe
	SET    txt_blob = ' '
	WHERE	 id_para	 = :sIdPara
	AND    id_canal = :sIdCanal
	USING  idw_1.itrTrans	;

//	COMMIT using idw_1.itrTrans		;
	F_COMMIT ( idw_1.itrTrans, TRUE ) // [PI056][TRANCOUNT][JFF][24/01/2020]

	If	sAltEnCours = "O"	Then
		UPDATEBLOB	sysadm.paragraphe
		SET			txt_blob = :blBlob
		WHERE			id_para	= :sIdPara
		AND    	   id_canal = :sIdCanal
		USING idw_1.itrTrans	;
	Else
		// [MIGPB11] [EMD] : Debut Migration : Forcer la cr$$HEX1$$e900$$ENDHEX$$ation de Blob en ANSI
		//blBlob = Blob ( " " )
		blBlob = Blob ( " ", EncodingANSI! )
		// [MIGPB11] [EMD] : Fin Migration
		
		UPDATEBLOB	sysadm.paragraphe
		SET			txt_blob = :blBlob
		WHERE			id_para	= :sIdPara
		AND    		id_canal = :sIdCanal
		USING idw_1.itrTrans	;
	End If
	 
		
	If	idw_1.itrTrans.SqlCode <> 0	Or idw_1.itrTrans.SqlDbCode <> 0	Then
//		ROLLBACK using idw_1.itrTrans ;
   	F_COMMIT ( idw_1.itrTrans, FALSE ) // [PI056][TRANCOUNT][JFF][24/01/2020]

		stMessage.sTitre		= "N_Cst_Sp_Paragraphe_2000 - uf_Valider ()"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= True
		stMessage.sCode		= "PAR_027"
		stMessage.bTrace		= FALSE

		f_Message ( stMessage )
		bRet = FALSE
	Else
/*------------------------------------------------------------------*/
/* On va ouvrir le fichier PARA_TMP.DOC dans WORD, enlever le lien  */
/* de fusion et red$$HEX1$$e900$$ENDHEX$$finir le mod$$HEX1$$e900$$ENDHEX$$le. On va sauvegarder ce fichier   */
/* PARA_TMP.DOC en ID_PARA.CPT_VER                                  */
/*------------------------------------------------------------------*/
		If	uf_Sauvegarder_Paragraphe ( 1 ) > 0	Then
//			COMMIT using idw_1.itrTrans		;
			F_COMMIT ( idw_1.itrTrans, TRUE ) // [PI056][TRANCOUNT][JFF][24/01/2020]
		Else
//			ROLLBACK using idw_1.itrTrans ;
			F_COMMIT ( idw_1.itrTrans, FALSE ) // [PI056][TRANCOUNT][JFF][24/01/2020]
			
			stMessage.sTitre		= "N_Cst_Sp_Paragraphe_2000 - uf_Valider ()"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= True
			stMessage.sCode		= "PAR_027"
			stMessage.bTrace		= FALSE

			f_Message ( stMessage )
			bRet = FALSE
		End If
	End If
End If

Return ( bRet )

end function

private function integer uf_sauvegarder_paragraphe (integer aitype);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Spb_Paragraphe::uf_Sauvegarder_Paragraphe		(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 23/03/2000 17:37:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: (Val)		Integer		aiType		Type de traitement
//*
//* Retourne		: Integer					 1 = Tout est OK
//*													-1 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1 		 MADM 08/06/2006 Projet DNTMAIL Ajout de la colonne ID_CANAL
//*          JFF  17/10/2019 Je shunte l'$$HEX1$$e900$$ENDHEX$$criture dans COURMAIL
//*-----------------------------------------------------------------

N_Cst_Word			nvWord

OleObject			OleWord
Integer				iRet, I
String 				sFicIniApp, sModele, sRepCourrier, sIdPara, sCptVer, sFichier, sFlag
String            sIdCanal, sFichierNew, sRep[], sMedias[2,2]
Long 					lNbTotMedias, lCpt
/*------------------------------------------------------------------*/
/* Pas de cr$$HEX1$$e900$$ENDHEX$$ation de r$$HEX1$$e900$$ENDHEX$$vision, inutile d'aller plus loin.          */
/*------------------------------------------------------------------*/
If	idw_1.GetItemString ( 1, "ALT_ENCOURS" ) = "O"	Then Return ( 1 )

sFicIniApp			= stGLB.sFichierIni 
/*-------------------------------------------------------------------------*/
/*MADM 08/06/2006 Projet DNTMAIL1 : On arme les diff$$HEX1$$e900$$ENDHEX$$rents m$$HEX1$$e900$$ENDHEX$$dias existants*/
/*-------------------------------------------------------------------------*/
sMedias[1,1] = "CO"
sMedias[2,1] = "MA"

/*------------------------------------------------------------------*/
/*MADM 08/06/2006 Projet DNTMAIL1 : On arme les r$$HEX1$$e900$$ENDHEX$$partoires         */
/*------------------------------------------------------------------*/
sMedias[1,2] = ProfileString ( sFicIniApp, "EDITION", "REP_COURRIER", "" )
sMedias[2,2] = ProfileString ( sFicIniApp, "EDITION", "REP_COURMAIL", "" )

lNbTotMedias = UpperBound ( sMedias )


/*------------------------------------------------------------------*/
/* On instancie un objet WORD. On ferme tous les documents          */
/* actuellement ouvert.                                             */
/*------------------------------------------------------------------*/
OleWord = CREATE OleObject
F_SetVersionWord ( nvWord, TRUE )

iRet = nvWord.uf_CreerOleObject_Word ( OleWord )
If	iRet < 0	Then
	F_SetVersionWord ( nvWord, FALSE )
	DESTROY OleWord
	Return ( -1 )
End If

iRet = 1
/*------------------------------------------------------------------*/
/* On positionne WORD en icone dans la barre de t$$HEX1$$e200$$ENDHEX$$ches.             */
/*------------------------------------------------------------------*/
nvWord.uf_AgrandirWord ( FALSE )

/*-------------------------------------------------------------------------------------------*/
/*MADM 08/06/2006 Projet DNTMAIL1 : le modele est $$HEX2$$e0002000$$ENDHEX$$chercher dans le r$$HEX1$$e900$$ENDHEX$$pertoire des courriers*/
/*-------------------------------------------------------------------------------------------*/
sModele				= sMedias[1,2] + ProfileString ( sFicIniApp, "EDITION", "MODELE", "" )

/*------------------------------------------------------------------*/
/* On ouvre le fichier PARA_TMP.DOC.                                */
/*------------------------------------------------------------------*/
nvWord.uf_CommandeWord ( 3, isFicSauve, OleWord )
/*------------------------------------------------------------------*/
/* On enl$$HEX1$$e900$$ENDHEX$$ve la liaison en tant que document de fusion, et on       */
/* positionne la nouvelle valeur du mod$$HEX1$$e900$$ENDHEX$$le. (Ex: PARAGRAP.DOT en    */
/* COURRIER.DOT).                                                   */
/*------------------------------------------------------------------*/
nvWord.uf_CommandeWord ( 11, sModele, OleWord )
/*------------------------------------------------------------------*/
/* On sauvegarde le fichier en tant que K:\APPLI\ID_PARA.CPT_VER.   */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* MADM 08/06/2006 Projet DNTMAIL1 :On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le m$$HEX1$$e900$$ENDHEX$$dia (canal).   */
/*------------------------------------------------------------------*/
sIdCanal = idw_1.GetItemString ( 1, "ID_CANAL" )
sIdPara	= idw_1.GetItemString ( 1, "ID_PARA" )
sCptVer	= idw_1.GetItemString ( 1, "CPT_VER" )
//sFichier = sRepCourrier + sIdPara + "." + sCptVer

/*-------------------------------------------------------------------------------*/
/*MADM 08/06/2006                 																*/
/*Si c'est Multim$$HEX1$$e900$$ENDHEX$$dias le fichier est sauvegard$$HEX2$$e9002000$$ENDHEX$$dans le r$$HEX1$$e900$$ENDHEX$$pertoire des courriers*/ 
/*-------------------------------------------------------------------------------*/
If sIdCanal = "MU" Then
	sFichier = sMedias [ 1, 2 ] + sIdPara + "." + sCptVer		
Else
/*------------------------------------------------------------------*/	
/*Sinon on parcourt le tableau des m$$HEX1$$e900$$ENDHEX$$dias (Mail ou courrier) et en  */  
/*Fonction du canal on sauvegarde le fichier dans le bon r$$HEX1$$e900$$ENDHEX$$pertoire */
/*------------------------------------------------------------------*/
	For lCpt = 1 to lNbTotMedias
		If sIdCanal = sMedias [ lCpt, 1 ] Then
			sFichier = sMedias [ lCpt, 2 ] + sIdPara + "." + sCptVer		
			Exit
		End If 
	Next
End IF
/*------------------------------------------------------------------*/
/* Si le fichier existe d$$HEX1$$e900$$ENDHEX$$j$$HEX1$$e000$$ENDHEX$$, on arr$$HEX1$$ea00$$ENDHEX$$te tout. Il y a forc$$HEX1$$e900$$ENDHEX$$ment un   */
/* probl$$HEX1$$e800$$ENDHEX$$me.                                                        */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//If	FileExists ( sFichier )	Then
If	f_FileExists ( sFichier )	Then
//Fin Migration PB8-WYNIWYG-03/2006 CP	
	
	iRet = -1
Else
	nvWord.uf_CommandeWord ( 8, sFichier, OleWord )
/*------------------------------------------------------------------*/
/* On ferme tout les fichiers.                                      */
/*------------------------------------------------------------------*/
	nvWord.uf_CommandeWord ( 10, "", OleWord )
/*------------------------------------------------------------------*/
/*#1 MADM 08/06/2006 On prot$$HEX1$$e900$$ENDHEX$$ge le fichier en lecture seule			  */	
/*------------------------------------------------------------------*/
	IF	f_FileExists (sFichier ) Then invWin.uf_SetFileAttributes(sFichier, 1)
End If

F_SetVersionWord ( nvWord, FALSE )
if isvalid(OleWord) Then // [OFFICE_2010] On verifie la validit$$HEX2$$e9002000$$ENDHEX$$de l'objet avant de le d$$HEX1$$e900$$ENDHEX$$triure
	DESTROY OleWord
	Yield() // Avec Office 2010, On laisse le temps $$HEX2$$e0002000$$ENDHEX$$la destruction de l'objet sinon plantage.
End If

/*------------------------------------------------------------------*/
/* Si on trouve le fichier et que le canal est Multim$$HEX1$$e900$$ENDHEX$$dias          */
/*	on parcourt le tableau des m$$HEX1$$e900$$ENDHEX$$dias (Mail ou courrier) et si       */
/*	la canal trouv$$HEX2$$e9002000$$ENDHEX$$est "CO" on ne traite pas								  */		
/*------------------------------------------------------------------*/


IF	Not ( f_FileExists (sFichier ) AND sIdCanal = "MU" ) Then

/*------------------------------------------------------------------*/	
/*Traitement des paragraphes Monom$$HEX1$$e900$$ENDHEX$$dia (COURRIER ou MAIL)           */
/*via la fonction de traitement de la datastore                     */
/*------------------------------------------------------------------*/
  uf_traitement_datastore ()
	
End IF

Return ( iRet )

end function

private function string uf_verifier_sql (integer aitype, string asidpara, string asidcanal);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Spb_Paragraphe::uf_VerifierSql		(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 25/02/2000 15:40:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: V$$HEX1$$e900$$ENDHEX$$rification au moment de la cr$$HEX1$$e900$$ENDHEX$$ation (Doublon) et de la suppression
//*
//* Arguments		: Integer		aiTypeTrt	Type de traitement	
//*					  String			asIdPara		Identifiant du paragraphe
//*
//* Retourne		: String				"" ou Erreur g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1 MADM 08/06/2006 Projet DNTMAIL1 Ajout de la colonne ID_CANAL
//*-----------------------------------------------------------------

String 	sRet			= ""				// Cha$$HEX1$$ee00$$ENDHEX$$ne de retour de la fonction.
String	sLiaison							// Mot de liaison de la chaine de message.
String	sLibPara		= ""

String 	sCompo		= ""				// Texte de presence de compo.
String 	sRefus		= ""				// Texte de presence de motif.
String 	sPiece		= ""				// Texte de presence de piece.
String	sProd			= ""				// Texte de pr$$HEX1$$e900$$ENDHEX$$sence de paragraphes d'infos pour un produit.

Long		lNbCompo							// Nombre de compositions en relation avec 
												// le paragraphe.
Long		lNbRefus							// Nombre de motifs en relation avec 
												// le paragraphe.
Long		lNbPiece							// Nombre de pieces en relation avec 
												// le paragraphe.
Long		lNbProd							// Nombre de Produit en relation avec 
												// le paragraphe.
lNbCompo		= 0
lNbRefus		= 0
lNbPiece		= 0
lNbProd		= 0

Choose Case aiType
Case 1									// SUPPRESSION
/*-------------------------------------------------------------------*/
/* Recherche du nombre de composition en relation avec le paragraphe */
/*-------------------------------------------------------------------*/
	idw_1.itrTrans.IM_S02_COMPOSITION ( asIdPara, lNbCompo )

/*------------------------------------------------------------------*/
/* Recherche du nombre de Motifs en relation avec le paragraphe     */
/*------------------------------------------------------------------*/
	idw_1.itrTrans.IM_S03_MOTIF ( asIdPara, lNbRefus )

/*------------------------------------------------------------------*/
/* Recherche du nombre de Pieces en relation avec le paragraphe     */
/*------------------------------------------------------------------*/
	idw_1.itrTrans.IM_S03_PIECE ( asIdPara, lNbPiece )

/*------------------------------------------------------------------*/
/* Recherche du nombre de Produits en relation avec le paragraphe   */
/*------------------------------------------------------------------*/
	idw_1.itrTrans.IM_S01_PARAPROD ( asIdPara, lNbProd )

/*------------------------------------------------------------------*/
/* Construction de la chaine de retour.                             */
/*------------------------------------------------------------------*/
	sLiaison = " et "

	If lNbCompo <> 0 then
		sCompo = "des compositions"

		If lNbRefus <> 0 or lNbPiece <> 0 Or lNbProd <> 0 Then
			sCompo = sLiaison + sCompo
			sLiaison = ", "
		End If
	End if

	If lNbRefus <> 0 then
		sRefus = "des motifs de refus"
   
		If lNbPiece <> 0 Or lNbProd <> 0 Then
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

Case 2										// CREATION (Doublon)
	/*------------------------------------------------------------------*/
   /* #1										                                   */
  /*-------------------------------------------------------------------*/
	idw_1.itrTrans.IM_S01_PARAGRAPHE ( asIdPara, asIdCanal, sLibPara )
	If	IsNull ( sLibPara ) Or Len ( Trim ( sLibPara ) ) = 0	Then
		sRet = ""
	Else
		sRet = sLibPara
	End If

End Choose

Return ( sRet )

end function

private function integer uf_traitement_datastore ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Spb_Paragraphe::uf_traitement_datastore		(PRIVATE)
//* Auteur			: MADM
//* Date				: 08/06/2006 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Permet de traiter le m$$HEX1$$e900$$ENDHEX$$dia (apr$$HEX1$$e900$$ENDHEX$$s la scission) qui 
//*					  n'a pas fait l'objet d'une modification (traitement par datastore)	
//* Arguments		: Aucun
//*
//* Retourne		: Integer					 
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------



Boolean    bRet
integer   icpt , iCptVer, iRet
long      ltotligneScission
String    sIdPara, sIdCanal, sCptVer, sFicIniApp, sFichiercourrier, sRep, sFichierMail, sFichier

string sCptVerbis, sFichieranc

ltotligneScission = ids_scission.RowCount()
sFicIniApp			= stGLB.sFichierIni 

bRet = TRUE

/*---------------------------------------------------------------------------------------*/
/* On boucle sur la datastore, on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le code, le m$$HEX1$$e900$$ENDHEX$$dia et la version du paragraphe */
/*---------------------------------------------------------------------------------------*/

For icpt = 1  to   ltotligneScission
  
  sIdPara  = ids_scission.GetItemString (icpt , "ID_PARA")
  sIdCanal  = ids_scission.GetItemString (icpt , "ID_CANAL")
  sCptVer  = ids_scission.GetItemString (icpt , "CPT_VER")

  /*------------------------------------------------*/
  /* On incr$$HEX1$$e900$$ENDHEX$$mente le compteur de version           */
  /*------------------------------------------------*/
  iCptVer = Long ( sCptVer )
  iCptVer ++
  sCptVerbis = String ( iCptVer, "000" )

 /*-------------------------------------------------*/
 /* On d$$HEX1$$e900$$ENDHEX$$termine le r$$HEX1$$e900$$ENDHEX$$pertoire en fonction du canal */
 /*-------------------------------------------------*/
  CHOOSE CASE   sIdCanal
      Case  "MA"
        sRep	= ProfileString ( sFicIniApp, "EDITION", "REP_COURMAIL", "" )   

		Case  "CO"
        sRep	= ProfileString ( sFicIniApp, "EDITION", "REP_COURRIER", "" )
     
  END CHOOSE  
  
 /*--------------------------------------------------------*/
 /* On arme le nom du fichier dans le r$$HEX1$$e900$$ENDHEX$$pertoire appropri$$HEX2$$e9002000$$ENDHEX$$*/
 /* Avec la version (qui sera n+1) pour le nouveau			  */
 /*--------------------------------------------------------*/
  sFichieranc = sRep + sIdPara + "." + sCptVer
  sFichier    = sRep + sIdPara + "." + sCptVerbis
/*------------------------------------------------------------------*/
/* On fait une copie du fichier existant vers le nouveau				  */
/*									     												  */
/*	On prot$$HEX1$$e900$$ENDHEX$$ge les 2 fichiers en lecture seule   						  */		
/*------------------------------------------------------------------*/
    // [OFFICE_2010] Remplacement de F_COpy par FileCopy
    //F_Copy (invWin, sFichieranc, sFichier )
    FileCopy ( sFichieranc, sFichier )
	 invWin.uf_SetFileAttributes(sFichier, 1)
	 invWin.uf_SetFileAttributes(sFichieranc, 1)
	 
	 /*-----------------------------------------------------------------------*/
	 /* on incr$$HEX1$$e900$$ENDHEX$$mente le num$$HEX1$$e900$$ENDHEX$$ro de version en base du paragraphe non trait$$HEX4$$e900200020002000$$ENDHEX$$*/ 
	 /* pour $$HEX1$$ea00$$ENDHEX$$tre en phase avec le paragraphe trait$$HEX27$$e90020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
	 /*-----------------------------------------------------------------------*/
    ids_scission.SetItem ( icpt, "CPT_VER", sCptVerbis )

NEXT    


ids_scission.SetTransObject (SQLCA)

/*--------------------------------------------------------------------*/
/*Si l'update de la datastore se passe bien, on commit sinon rollback */
/*--------------------------------------------------------------------*/
 F_Commit (SQLCA , ids_scission.Update () > 0 )

 
 Return ( iRet )
end function

public function boolean uf_preparer (string astypetrt, string asidpara, string asidcanal);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Spb_Paragraphe::uf_Preparer		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 25/02/2000 14:39:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On vient de l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement SHOW de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement
//*
//* Arguments		: (Val)		String			asTypeTrt		(C)r$$HEX1$$e900$$ENDHEX$$ation, (M)odification
//*
//* Retourne		: Boolean				TRUE 	= Tout est OK
//*												FALSE	= Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1 MADM 08/06/2006 Projet DNTMAIL Ajout de la colonne ID_CANAL
//*-----------------------------------------------------------------

Long lRet, lLigne
Boolean bRet
string  sAltEncours

/*------------------------------------------------------------------*/
/* On arme le type de traitement en cours. (C)r$$HEX1$$e900$$ENDHEX$$ation,              */
/* (M)odification.                                                  */
/*------------------------------------------------------------------*/
isTypeTrt = asTypeTrt
bRet = TRUE

/*------------------------------------------------------------------*/
/* On supprime le fichier PARA_TMP.DOC s'il existe.                 */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//If	FileExists ( isFicSauve )	Then FileDelete ( isFicSauve )
If	f_FileExists ( isFicSauve )	Then FileDelete ( isFicSauve )
//Fin Migration PB8-WYNIWYG-03/2006 CP

/*------------------------------------------------------------------*/
/* On est en cr$$HEX1$$e900$$ENDHEX$$ation d'un paragraphe.                              */
/*------------------------------------------------------------------*/
If isTypeTrt = "C"	Then
	idw_1.Reset ()
	idw_1.InsertRow ( 0 )
/*------------------------------------------------------------------*/	
/* On positionne les valeurs CREE_LE, MAJ_LE, MAJ_PAR.              */
/*------------------------------------------------------------------*/
	F_CreeLe ( idw_1, 1 )
	F_MajPar ( idw_1, 1 )
/*---------------------------------------------------------------------------*/	
/* #1 MADM le bouton permettant la modif de l'encours est invisible.         */
/* 																								  */
/*---------------------------------------------------------------------------*/	
	ipbencours.Hide ()
/*----------------------------------------------------------------------*/
/* #1 MADM en mode cr$$HEX1$$e900$$ENDHEX$$ation On positionne le compteur de r$$HEX1$$e900$$ENDHEX$$vision $$HEX2$$e0002000$$ENDHEX$$000.*/
/* Le champ ID_PARA est accessible et le curseur est positionn$$HEX2$$e9002000$$ENDHEX$$dessus  */
/*----------------------------------------------------------------------*/
	idw_1.SetItem ( 1, "CPT_VER", "000" )
	idw_1.Uf_Proteger ( { "ID_PARA" }, "0" )
	idw_1.SetColumn ( "ID_PARA" )
/*---------------------------------------------------------------------------*/	
/* #1 MADM																				           */
/* Le texte du message d'alerte de l'encours est invisible (ALT_ENCOURS = N) */
/*---------------------------------------------------------------------------*/
   istencours.hide()
/*----------------------------------------------------------------------*/
/* #1 MADM On positionne la valeur du canal (M$$HEX1$$e900$$ENDHEX$$dia) $$HEX2$$e0002000$$ENDHEX$$"MU"              */
/* Le champ ID_CANAL est prot$$HEX1$$e900$$ENDHEX$$g$$HEX17$$e9000900090009000900090009000900090009000900090009000900200020002000$$ENDHEX$$*/
/* Le champ scinder est invisible et prot$$HEX1$$e900$$ENDHEX$$g$$HEX29$$e9002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
/* Le champ Version est invisible                                       */
/*----------------------------------------------------------------------*/ 
   idw_1.SetItem ( 1, "ID_CANAL", "MU" )
   idw_1.Uf_Proteger ( { "ID_CANAL" }, "1" )
   idw_1.modify ("ALT_SCINDER.visible = 0")
   idw_1.Uf_Proteger ( { "ALT_SCINDER" }, "1" )

   idw_1.modify ("ALT_VERSION.visible = 0") 
	
Else
/*------------------------------------------------------------------*/
/* On est en Mode Modification d'un paragraphe.                     */
/*------------------------------------------------------------------*/	
	idw_1.Reset ()
/*------------------------------------------------------------------*/
/* #1 MADM On recherche la ligne correspondante sur la base.        */
/*------------------------------------------------------------------*/
	lRet = idw_1.Retrieve ( asIdPara, asIdCanal )
		
/*------------------------------------------------------------------*/
/* #1 MADM Si m$$HEX1$$e900$$ENDHEX$$dia est diff$$HEX1$$e900$$ENDHEX$$rent de "MU" On recherche la ligne     */
/* correspondante sur la base via le datastore.                     */
/*------------------------------------------------------------------*/	
	IF asidcanal <> "MU" THEN
		lret = ids_scission.Retrieve ( asIdPara, asIdCanal)
	END IF	
/*------------------------------------------------------------------*/
/* #1 MADM Le champ Version est visible et accessible.              */
/*------------------------------------------------------------------*/
  idw_1.modify ("ALT_VERSION.visible = 1") 	
  idw_1.Uf_Proteger ( { "ALT_VERSION" }, "1" )
/*----------------------------------------------------------------------------------------------------*/
/* #1 MADM Si canal = "MU" et l'encours  = "N" laisser la colonne alt_scinder visible et non prot$$HEX1$$e900$$ENDHEX$$g$$HEX1$$e900$$ENDHEX$$e.*/             
/*----------------------------------------------------------------------------------------------------*/  
	lLigne = idw_1.GetRow ()
	If lLigne = 0 Then return False
	
	sAltEncours = idw_1.getitemstring (1 , "ALT_ENCOURS" )
    
	IF asIdCanal = "MU" AND sAltEncours = "N"  THEN
      idw_1.modify ("ALT_SCINDER.visible = 1")
      idw_1.Uf_Proteger ( { "ALT_SCINDER" }, "0" )	
	ELSE
		idw_1.modify ("ALT_SCINDER.visible = 0")
      idw_1.Uf_Proteger ( { "ALT_SCINDER" }, "1" )
	END IF
	
/*----------------------------------------------------------------------------------------------------*/
/* #1 MADM si le paragraphe est en cours de modification rendre visible le texte d'alerte et le bouton*/
/*    qui permet d'annuler l'encours                                                                  */ 
/*----------------------------------------------------------------------------------------------------*/	
 IF sAltEncours = "O" THEN
     istencours.show ()
	  ipbencours.show ()
 ELSE
 	 istencours.Hide ()
	 ipbencours.Hide ()
 END IF 
 
 
 idw_1.Uf_Proteger ( { "ID_PARA" }, "1" )
 idw_1.SetColumn ( "LIB_PARA" )
 
 
  
	
	If	lRet <> 1	Then
		bRet = FALSE
	End If
End If

If	bRet Then
	lRet = uf_Recuperer_Para_Tmp () 
	If	lRet < 0	Then bRet = FALSE

	If	lRet = -1	Then
		stMessage.sTitre		= "N_Cst_Sp_Paragraphe_2000 - uf_Preparer()"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "PAR_026"
		stMessage.bTrace  	= False

		F_Message ( stMessage )
	End If

End If

Return ( bRet )


end function

public function integer uf_annuler_encours ();//*-----------------------------------------------------------------
//*
//* Objet 			: pb_AnnulerEncours
//* Evenement 		: Clicked
//* Auteur			: MADM
//* Date			: 27/06/2006 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Permet de modifier l'encours d'un paragraphe de Oui $$HEX2$$e0002000$$ENDHEX$$Non et
//*                   mettre $$HEX2$$e0002000$$ENDHEX$$jour le Blob 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String	sAltEncours, sIdCanal, sIdPara, stxtpara

Integer iRet 
Boolean 	bRet 
		
bRet = True

		
		
		 stMessage.sTitre 		= "Information op$$HEX1$$e900$$ENDHEX$$rateur"
		 stMessage.sVar[ 1 ] 	= "le paragraphe"
		 stMessage.Bouton		= YesNo!
		 stMessage.Icon			= Exclamation!
		 stMessage.bErreurG	    = TRUE
		 stMessage.sCode		= "PAR_028"
		 stMessage.iDefautBouton	= 2	
		 
		 iRet = f_Message ( stMessage )
		 
		 
		 
		 //L'op$$HEX1$$e900$$ENDHEX$$rateur renonce $$HEX2$$e0002000$$ENDHEX$$annuler l'encours
				
				If iRet = 2 Then 
				   bRet = False
					
				ELSE
				
		  //L'op$$HEX1$$e900$$ENDHEX$$rateur annule l'encours		
				    sIdPara  	= idw_1.GetItemString ( 1, "ID_PARA")
					sIdCanal    = idw_1.GetItemString ( 1, "ID_CANAL" )
					sAltEncours = idw_1.GetItemString (1 , "Alt_ENCOURS")
					stxtpara 	= idw_1.GetItemString (1 , "TXT_PARA")


   					UPDATE sysadm.paragraphe
					SET     alt_encours = "N" ,
		    				txt_blob = " " ,
			 				txt_para = NULL         
					WHERE	id_para	 = :sIdPara
					AND     id_canal = :sIdCanal
					USING  SQLCA	;
	
						If	SQLCA.SqlCode <> 0	Or SQLCA.SqlDbCode <> 0	Then
//							ROLLBACK using SQLCA ;
							F_COMMIT ( SQLCA, FALSE ) // [PI056][TRANCOUNT][JFF][24/01/2020]
						ELSE
//							COMMIT using SQLCA ;
							F_COMMIT ( SQLCA, TRUE ) // [PI056][TRANCOUNT][JFF][24/01/2020]
						END IF	
                
				

						/*---------------------------------------------------------------------------------------------------*/
						/* Rendre invisible le texte d'alerte et le bouton "Annuler l'encours"	et executer le bouton Retour */
						/*---------------------------------------------------------------------------------------------------*/ 
						istencours.Visible = FALSE
						ipbencours.Visible = FALSE

						iPbretour.TriggerEvent (Clicked!)  
				END IF		
				
				
RETURN (1)
				
				
				
				
				

end function

public subroutine uf_initialiser (ref u_datawindow adw_1, ref u_transaction atrtrans, ref statictext astencours, ref picturebutton apbencours, ref picturebutton apbvalider, ref picturebutton apbretour);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Spb_Paragraphe::uf_Initialiser		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 25/02/2000 14:34:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation du NVUO
//*
//* Arguments		: (R$$HEX1$$e900$$ENDHEX$$f)		U_DataWindow		adw_1
//*					  (R$$HEX1$$e900$$ENDHEX$$f)		U_TrTrans			atrTrans
//*					  (R$$HEX1$$e900$$ENDHEX$$f)		Statictext			astencours
//*                 (R$$HEX1$$e900$$ENDHEX$$f)     Picturebutton     apbencours
//*                 (R$$HEX1$$e900$$ENDHEX$$f)     Picturebutton     apbvalider
//*                 (R$$HEX1$$e900$$ENDHEX$$f)     Picturebutton     apbretour
//*					  (R$$HEX1$$e900$$ENDHEX$$f)     Boolean           abscission 	
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1 MADM 08/06/2006 projet DNTMAIL1 
//* #2 DGA  19/09/2006 Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire DCMP-060643
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On initialise la valeur pour la DW de saisie.                    */
/*------------------------------------------------------------------*/
idw_1 = adw_1

/*---------------------------------------------------------------------------------*/
/* #1 MADM On initialise la valeur du Static text.                                 */
/* On affiche un message d'alerte quand le document n'est pas celui de production  */ 
/*---------------------------------------------------------------------------------*/
istencours = astencours

/*-------------------------------------------------------------------------*/
/* #1 MADM On initialise la valeur du picturebutton de l'encours.          */
/* Gerer le Picture bouton qui permet de modifier l'encours d'un paragraphe*/
/*-------------------------------------------------------------------------*/
ipbencours = apbencours


/*---------------------------------------------------------------------------------------*/
/* #1 MADM On initialise la valeur du picturebutton Valider et Retour.                   */
/* Au moment de la scission rendre le bouton valider inaccessible et declencher le retour*/
/*---------------------------------------------------------------------------------------*/
ipbvalider = apbvalider
ipbretour  = apbretour



/*------------------------------------------------------------------*/
/* On instancie un NVUO en instance pour la gestion des fichiers.   */
/*------------------------------------------------------------------*/
invWin = stGLB.uoWin

/*---------------------------------------------------------------------------------------*/
/* #1 MADM On initialise la valeur du Booleen qui permet de savoir si on a d$$HEX1$$e900$$ENDHEX$$clench$$HEX2$$e9002000$$ENDHEX$$la  */
/* scission                                                                              */
/*---------------------------------------------------------------------------------------*/
//ibScission = abscission

/*------------------------------------------------------------------*/
/* #1 MADM On instancie le datastore et on l'initialise.            */
/*------------------------------------------------------------------*/
ids_scission = CREATE DataStore
ids_scission.dataobject = 'd_trt_monomedia'
ids_scission.SetTransObject (SQLCA)

/*------------------------------------------------------------------*/
/* On positionne une variable d'instance pour le nom du fichier     */
/* WORD temporaire. (Ex:C:\WINDOWS\TEMP\PARA_TMP.DOC)               */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/  
/* #2. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//isFicSauve = stGLB.sWinDir + "\TEMP" + "\" + isK_PARA_TMP
isFicSauve = stGLB.sRepTempo + isK_PARA_TMP

/*---------------------------------------------------------------------------------*/
/* #1 MADM                                                                         */
/* On affiche un message d'alerte quand le document n'est pas celui de production  */ 
/*---------------------------------------------------------------------------------*/
istencours.hide()
istencours.text = "Attention : Le document en cours n'est pas celui de production" 

ipbencours.hide()


end subroutine

on n_cst_sp_paragraphe_2000.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_sp_paragraphe_2000.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

