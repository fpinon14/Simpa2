HA$PBExportHeader$u_sp_ifr_integration.sru
forward
global type u_sp_ifr_integration from nonvisualobject
end type
end forward

global type u_sp_ifr_integration from nonvisualobject
end type
global u_sp_ifr_integration u_sp_ifr_integration

type variables

Private :

Constant String	K_FICLOG = "FIC_REF.LOG"
Constant String	K_FICCHARG = "FIC_REF.TXT"

Datawindow idwTrt, idwCharg, idwLog, idwStkParam

Int		iiFicTrc

Boolean	bArret

String 	isCasTrtEnCours

end variables

forward prototypes
public subroutine uf_initialiser (s_pass astpass)
private function integer uf_trace (string ascas, string astexte)
public function integer uf_preparermodifier ()
public subroutine uf_pilotagebouton (string ascas)
public function integer uf_trtaction (string asbouton)
public function integer uf_stoppertrt ()
private function integer uf_trt_chargement ()
private function integer uf_trt_validerref ()
private function integer uf_trt_controlergen ()
public function String uf_gettrtencours ()
private function integer uf_trt_rechprxpack ()
private function integer uf_trt_majdefbase ()
end prototypes

public subroutine uf_initialiser (s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_integration::uf_initialiser (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 28/07/2008 11:53:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value s_pass astpass	 
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

DatawindowChild dwChild

idwTrt 		= astPass.dwNorm [1]
idwCharg		= astPass.dwNorm [2]
idwLog 		= astPass.dwNorm [3]
idwStkParam = astPass.dwNorm [4] 

idwTrt.InsertRow (0)

idwStkParam.SetTransObject ( SQLCA )

idwTrt.GetChild ( "NOM_REF", dwChild )
dwChild.SetTransObject ( SQLCA )
dwChild.Retrieve ( )



end subroutine

private function integer uf_trace (string ascas, string astexte);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_integration::uf_trace (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 30/07/2008 11:16:50
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value string ascas
//* 					  value string astexte
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Int	iRet
String sRepFicGen, sMes
Long	lRow

sRepFicGen =  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_GEN", "" ) + &
				  ProfileString ( stGlb.sFichierIni, "GEST_COMMANDES", "REP_REF", "" ) + K_FICLOG
iRet = 1

CHOOSE CASE Upper ( asCas )

	CASE "INIT"
		iiFicTrc = FileOpen ( sRepFicGen, LineMode!, Write!, Shared!, Append! )

		If iiFicTrc <= 0 Then 
			This.uf_PilotageBouton ( "INIT" )
			iRet = -1
			stMessage.sTitre = "Fichier Trace"
			stMessage.sCode = "COMD005"
			stMessage.icon = StopSign!
			F_Message ( stMessage )
		Else
			sMes = Fill( "*", 80 )
			FileWrite ( iiFicTrc, sMes )
			FileClose ( iiFicTrc )
		End If

	CASE "ECR"

			iiFicTrc = FileOpen ( sRepFicGen, LineMode!, Write!, Shared!, Append! )

			If iiFicTrc <= 0 Then 
				This.uf_PilotageBouton ( "INIT" )
				iRet = -1
				stMessage.sTitre = "Fichier Trace"
				stMessage.sCode = "COMD005"
				stMessage.icon = StopSign!
				F_Message ( stMessage )
			Else
				sMes = String ( Today() ) + "~t" + String ( Now () ) + "~t" + Upper ( stGlb.sCodOper ) + "~t" + asTexte
				FileWrite ( iiFicTrc, sMes )
				lRow = idwLog.InsertRow ( 0 )
				idwLog.SetItem ( lRow,  "TEXTE", String ( Today() ) + " " + String ( Now () ) + "   " + asTexte )
				FileClose ( iiFicTrc )
				idwLog.ScrollToRow ( lRow )				
			End If
			
END CHOOSE

Return iRet
end function

public function integer uf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_integration::uf_preparermodifier (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 30/07/2008 13:30:26
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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


This.uf_PilotageBouton ( "INIT" )

/*------------------------------------------------------------------*/
/* Initialisation de la trace.                                      */
/*------------------------------------------------------------------*/
If uf_Trace ( "INIT", "") <= 0 Then return -1

This.uf_PilotageBouton ( "TRT_CHARGEMENT" )

This.uf_Trace ( "ECR", "Fichier de trace initialis$$HEX1$$e900$$ENDHEX$$e, fen$$HEX1$$ea00$$ENDHEX$$tre pr$$HEX1$$ea00$$ENDHEX$$te au traitement") 

Return 1



end function

public subroutine uf_pilotagebouton (string ascas);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_integration::uf_PilotageBouton (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 30/07/2008 13:36:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value string asCas
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

String sVert, sRouge, sGras, sNormal
String sObjet [5,2]
Long lMaxTab, lCpt, lCpt2, lMaxDim

idwCharg.AcceptText ()

sObjet [1,1] = "gb_chargement"
sObjet [1,2] = "b_chargement"
sObjet [2,1] = "gb_validerref"
sObjet [2,2] = "b_validerref"
sObjet [3,1] = "gb_controlergen"
sObjet [3,2] = "b_controlergen"
sObjet [4,1] = "gb_rechprxpack"
sObjet [4,2] = "b_rechprxpack"
sObjet [5,1] = "gb_majdefbase"
sObjet [5,2] = "b_majdefbase"
lMaxTab = 5
lMaxDim = 2

sVert = "32768"
sRouge = "255"
sGras = "700"
sNormal = "400"


Choose Case True
	
	Case asCas = "INIT"

		isCasTrtEnCours = asCas
		
		For lCpt = 1 To lMaxTab 
			For lCpt2 = 1 To lMaxDim
				idwTrt.Modify ( sObjet [lCpt, lCpt2] + ".color = " + sRouge + sObjet [lCpt, lCpt2] + ".font.weight = " + sNormal ) 
			Next
		Next
		
	Case Left ( asCas, 4 ) = "TRT_"

		This.uf_PilotageBouton ( "INIT" )
		
		isCasTrtEnCours = Right ( asCas, Len ( asCas ) - 4 )
		
		For lCpt = 1 To lMaxTab 

			If sObjet [lCpt, 2] = "b_" + lower ( isCasTrtEnCours ) Then 
				For lCpt2 = 1 To lMaxDim
					idwTrt.Modify ( sObjet [lCpt, lCpt2] + ".color = " + sVert + sObjet [lCpt, lCpt2] + ".font.weight = " + sGras ) 
				Next
				Exit
			End If
		Next

End Choose


end subroutine

public function integer uf_trtaction (string asbouton);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_integration::uf_TrtAction (PUBLIC)
//* Date				: 30/07/2008 14:39:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Clique sur un Bouton de traitement
//* Commentaires	: 
//*
//* Arguments		: value string asBouton
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Int iRet

iRet = 1

asBouton = Lower ( Right ( asBouton, len ( asBouton ) - 2 ) )

If  asBouton = "stoppertrt" Then
	This.uf_StopperTrt ()
	Return 1
End If
	

If Lower ( isCasTrtEnCours ) <> asBouton Then
	stMessage.sTitre = "Traitement"
	stMessage.sCode = "INRF001"
	stMessage.icon = Information!
	F_Message ( stMessage )
	Return -1
End If


Choose Case asBouton

	Case "chargement"

		iRet = This.uf_trt_chargement ()
		If iRet > 0 Then
			This.uf_PilotageBouton ( "TRT_VALIDERREF" )
		End If

	Case "validerref"

		iRet = This.uf_trt_ValiderRef ()
		If iRet > 0 Then
			This.uf_PilotageBouton ( "TRT_CONTROLERGEN" )
		End If
		
	Case "controlergen"

		iRet = This.uf_trt_ControlerGen ()
		If iRet > 0 Then
			This.uf_PilotageBouton ( "TRT_RECHPRXPACK" )
		End If
		
	Case "rechprxpack"

		iRet = This.uf_trt_RechPrxPack ()
		iRet = 1 // [DEBUG][JFF][DCMP080388]
		If iRet > 0 Then
			This.uf_PilotageBouton ( "TRT_MAJDEFBASE" )
		End If
		
	Case "majdefbase"

		// Quoi qu'il puisse se passer lors de ce trt (erreur/succ$$HEX1$$e800$$ENDHEX$$s), on n'ira pas plus loin,
		// On r$$HEX1$$e900$$ENDHEX$$initialise les boutons avant, pour rejeter tout clique de souris intempestif 
		// Pendant le trt.
		This.uf_PilotageBouton ( "INIT" )
		iRet = This.	uf_trt_MajDefBase ()

	
End Choose

If iRet <= 0 Then
	This.uf_PilotageBouton ( "TRT_CHARGEMENT" )
	Return iRet
End If


Return 1

end function

public function integer uf_stoppertrt ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_integration::uf_StopperTrt (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 30/07/2008 14:53:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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


This.uf_PilotageBouton ( "TRT_CHARGEMENT" )

idwTrt.SetItem ( 1, "NOM_REF", stNul.str )
idwTrt.SetItem ( 1, "ID_TRAIT_ANN", stNul.lng )
idwCharg.Reset ()

idwTrt.SetItem ( 1, "PRIX_PACK_MINI", 0 )
idwTrt.SetRedraw ( TRUE )

This.uf_Trace ( "ECR", "Traitement stopp$$HEX1$$e900$$ENDHEX$$, fen$$HEX1$$ea00$$ENDHEX$$tre r$$HEX1$$e900$$ENDHEX$$initialis$$HEX1$$e900$$ENDHEX$$e") 

Return 1

end function

private function integer uf_trt_chargement ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_integration::uf_trt_chargement (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 30/07/2008 16:11:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Chargement simple du fichier r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rentiel provenant du fournisseur
//*  					  dans une DW.
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

String sFicRef 
Long lTotLig
Int iRet

sFicRef = stGlb.sRepTempo + K_FICCHARG
iRet = 1

If Not FileExists ( sFicRef ) Then
	stMessage.sTitre = "Traitement"
	stMessage.sCode = "INRF002"
	stMessage.icon = Information!
	stMessage.sVar[1] = sFicRef
	F_Message ( stMessage )
	
	Return -1
	
End If

idwCharg.Reset ()
lTotLig = idwCharg.ImportFile ( sFicRef )

If lTotLig = 0 Then
	This.uf_Trace ( "ECR", "Le fichier ne comporte aucune ligne" ) 
	iRet = 0
End If

If lTotLig <0 Then
	This.uf_Trace ( "ECR", "ERREUR ! code erreur d'importation : " + String ( lTotLig ) ) 
	iRet = -1	
End If

If lTotLig >0 Then
	This.uf_Trace ( "ECR", "Fichier charg$$HEX2$$e9002000$$ENDHEX$$pour traitement (" + String ( lTotLig ) + " ligne(s))" ) 
	iRet = 1
End If

Return iRet 



end function

private function integer uf_trt_validerref ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_integration::uf_trt_ValiderRef (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 30/07/2008 16:11:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Choix du r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rentiel en base dans lequel int$$HEX1$$e900$$ENDHEX$$gr$$HEX2$$e9002000$$ENDHEX$$les donn$$HEX1$$e900$$ENDHEX$$es du fichiers
//*
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

String sVal
Int iRet

iRet = 1

sVal = idwTrt.GetItemString ( 1, "NOM_REF" )

If IsNull ( sVal ) Or Trim ( sVal ) = "" Then
	stMessage.sTitre = "Traitement"
	stMessage.sCode = "INRF004"
	stMessage.icon = Information!
	F_Message ( stMessage )		
	Return -1
End If

This.uf_Trace ( "ECR", "R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rentiel choisi pour int$$HEX1$$e900$$ENDHEX$$grer le fichier : " + Upper ( sVal ) ) 

Return iRet 



end function

private function integer uf_trt_controlergen ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_integration::uf_trt_ControlerGen (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 30/07/2008 16:11:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$ler G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ral sur le fichier Charg$$HEX1$$e900$$ENDHEX$$.
//*  					  
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

String sReferentiel, sValCtrle, sValSource, sValCtrleColExcel, sTabVal [], sTabNull[], sVal
String sFiltreParam, sTriParam
Long lTotLigCtrle, lTotLigSource, lTotCol
Long lCptCol, lCptLigCtrle, lCptLigSource
Long lTot
Int iRet

iRet = 1

sReferentiel = Upper ( idwTrt.GetItemString ( 1, "NOM_REF" ))

Choose Case sReferentiel 
		
	Case "IFR_FRANCE", "IFR_SUISSE"

		idwStkParam.Retrieve ( sReferentiel )		
		

		
		/*------------------------------------------------------------------*/
		/* Affichage param avant les controles                              */
		/*------------------------------------------------------------------*/

		// Le prix pack
		sFiltreParam = "SUPPORT = 'PARAM' AND UPPER ( ID_VAL ) = 'PRIX_PACK'" 
		sTriParam = "ID_ORDRE A" 
		idwStkParam.SetFilter ( sFiltreParam  )
		idwStkParam.SetSort   ( sTriParam     )
		idwStkParam.Filter ()
		idwStkParam.Sort ()		

		If idwStkParam.RowCount ( ) <> 1 Then
			This.uf_Trace ( "ECR", "ALERTE : Probl$$HEX1$$e800$$ENDHEX$$me de param$$HEX1$$e800$$ENDHEX$$trage sur le prix pack mini, nombre de lignes trouv$$HEX1$$e900$$ENDHEX$$es : " + String ( idwStkParam.RowCount ( ) )  )
		End If

		sTabVal = sTabNull
		sTabVal [1] = idwStkParam.GetItemString ( 1, "VAL_BASE" ) // Valeur param$$HEX1$$e800$$ENDHEX$$trage prix pack mini
		
		IF Not IsNumber ( sTabVal [1] ) Then
			This.uf_Trace ( "ECR", "ALERTE : Probl$$HEX1$$e800$$ENDHEX$$me de param$$HEX1$$e800$$ENDHEX$$trage sur le prix pack mini, valeur param$$HEX1$$e800$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$e: " + sTabVal [1]  )
		End If

		IF dec ( sTabVal [1] ) <= 0 Then
			This.uf_Trace ( "ECR", "ALERTE : Probl$$HEX1$$e800$$ENDHEX$$me de param$$HEX1$$e800$$ENDHEX$$trage sur le prix pack mini, valeur n$$HEX1$$e900$$ENDHEX$$gative : " + sTabVal [1]  )
		End If

		// Le prix pack param$$HEX1$$e800$$ENDHEX$$tr$$HEX2$$e9002000$$ENDHEX$$est fiable, on l'affiche, il sera recontr$$HEX1$$f400$$ENDHEX$$l$$HEX2$$e9002000$$ENDHEX$$plus tard
		idwTrt.SetItem ( 1, "PRIX_PACK_MINI", Dec ( sTabVal [1] ) )
		idwTrt.SetRedraw ( TRUE )


		// Le mail SPB pour le CR de trt
		sFiltreParam = "SUPPORT = 'PARAM' AND UPPER ( ID_VAL ) = 'MAIL_SPB'" 
		sTriParam = "ID_ORDRE A" 
		idwStkParam.SetFilter ( sFiltreParam  )
		idwStkParam.SetSort   ( sTriParam     )
		idwStkParam.Filter ()
		idwStkParam.Sort ()			
		
		If idwStkParam.RowCount ( ) <> 1 Then
			This.uf_Trace ( "ECR", "ALERTE : Probl$$HEX1$$e800$$ENDHEX$$me de param$$HEX1$$e800$$ENDHEX$$trage sur le mail qui sera utilis$$HEX2$$e9002000$$ENDHEX$$pour le compte rendu de mises $$HEX2$$e0002000$$ENDHEX$$jour (nbre de ligne de param lue : " + String ( idwStkParam.RowCount ( ) ) + ")" )
		End If

		sTabVal = sTabNull
		sTabVal [1] = idwStkParam.GetItemString ( 1, "VAL_BASE" ) // Valeur param$$HEX1$$e800$$ENDHEX$$trage prix pack mini
		
		IF IsNull ( sTabVal [1] ) Or Trim ( sTabVal [1] ) = ""  Then
			This.uf_Trace ( "ECR", "ALERTE : Probl$$HEX1$$e800$$ENDHEX$$me de param$$HEX1$$e800$$ENDHEX$$trage sur le mail qui sera utilis$$HEX2$$e9002000$$ENDHEX$$pour le compte rendu de mises $$HEX2$$e0002000$$ENDHEX$$jour, il n'est pas renseign$$HEX1$$e900$$ENDHEX$$." )
		End If
		// Le mail est param$$HEX1$$e800$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$, on l'affiche, il sera recontr$$HEX1$$f400$$ENDHEX$$l$$HEX2$$e9002000$$ENDHEX$$plus tard
		idwTrt.SetItem ( 1, "ADRESSE_MAIL", sTabVal [1] )
		idwTrt.SetRedraw ( TRUE )

		/*------------------------------------------------------------------*/
		/* D$$HEX1$$e900$$ENDHEX$$but des Contr$$HEX1$$f400$$ENDHEX$$les                                              */
		/*------------------------------------------------------------------*/
	
		sFiltreParam = "SUPPORT = 'FICH' AND ID_VAL <> '-1'" 
		sTriParam = "ID_ORDRE A" 
		idwStkParam.SetFilter ( sFiltreParam  )
		idwStkParam.SetSort   ( sTriParam     )
		idwStkParam.Filter ()
		idwStkParam.Sort ()				
		
		lTotLigCtrle = idwStkParam.Rowcount ()
		lTotLigSource= idwCharg.RowCount ()
		lTotCol = Long ( idwCharg.Object.DataWindow.Column.Count )

		/*------------------------------------------------------------------*/
		/* Contr$$HEX1$$f400$$ENDHEX$$le des ent$$HEX1$$ea00$$ENDHEX$$tes                                             */
		/*------------------------------------------------------------------*/
		This.uf_Trace ( "ECR", "Contr$$HEX1$$f400$$ENDHEX$$le des ent$$HEX1$$ea00$$ENDHEX$$tes en cours...") 

		// On compte le nombre r$$HEX2$$e900e900$$ENDHEX$$l de colonne utilis$$HEX2$$e9002000$$ENDHEX$$dans le fich source Frn
		For lCptCol = 1 To lTotCol
			sVal = Upper( Trim ( idwCharg.GetItemString ( 1, lCptCol ) ))
			If IsNull ( sVal ) Or sVal ="" Then
				Exit
			End If
		Next
		lCptCol --

		If lTotLigCtrle <> lCptCol Then
			This.uf_Trace ( "ECR", "ERREUR : Le nombre de colonne du fichier source (" + String ( lCptCol ) + ") est diff$$HEX1$$e900$$ENDHEX$$rent du nombre de colonne d$$HEX1$$e900$$ENDHEX$$finit dans le param$$HEX1$$e800$$ENDHEX$$trage (" + String ( lTotLigCtrle ) + ")" ) 												
			iRet = -1
			Return iRet
		End If			

		If iRet = 1 Then
			This.uf_Trace ( "ECR", "Le nombre de colonne du fichier source (" + String ( lCptCol ) + ") correspond $$HEX2$$e0002000$$ENDHEX$$la d$$HEX1$$e900$$ENDHEX$$finition qui en est faite dans le param$$HEX1$$e800$$ENDHEX$$trage.") 			
		End If

		
		For lCptLigCtrle = 1 To lTotLigCtrle

			sValCtrle = Upper( Trim ( idwStkParam.GetItemString ( lCptLigCtrle, "VAL_FRN" ) ) )
			sValSource = Upper( Trim ( idwCharg.GetItemString ( 1, lCptLigCtrle ) ))
			
			If sValCtrle <> sValSource Then
				sValCtrleColExcel = Upper( Trim ( idwStkParam.GetItemString ( lCptLigCtrle, "ID_VAL" ) ) )
				This.uf_Trace ( "ECR", "ERREUR : La ligne d'ent$$HEX1$$ea00$$ENDHEX$$te du fichier source ne correspond pas $$HEX2$$e0002000$$ENDHEX$$la d$$HEX1$$e900$$ENDHEX$$finition qui en est faite en base") 
				This.uf_Trace ( "ECR", "ERREUR : Colonne Excel correspondante dans le fichier source : " + sValCtrleColExcel) 								
				This.uf_Trace ( "ECR", "ERREUR : Valeur ent$$HEX1$$ea00$$ENDHEX$$te de contr$$HEX1$$f400$$ENDHEX$$le : " + sValCtrle) 				
				This.uf_Trace ( "ECR", "ERREUR : Valeur ent$$HEX1$$ea00$$ENDHEX$$te fichier source, colonne Excel "+ sValCtrleColExcel + " : " + sValSource ) 
				This.uf_Trace ( "ECR", "ERREUR : 1/ V$$HEX1$$e900$$ENDHEX$$rifiez si l'erreur provient d'une manipulation de votre part et dans ce cas, corrigez la." ) 				
				This.uf_Trace ( "ECR", "ERREUR : 2/ Si vraiment il y a eu un mouvement de colonnes par le fournisseur (ajout/supp)," ) 								
				This.uf_Trace ( "ECR", "ERREUR :    Faite une DMDI $$HEX2$$e0002000$$ENDHEX$$ETUDES_SINISTRE pour faire mettre $$HEX2$$e0002000$$ENDHEX$$jour la d$$HEX1$$e900$$ENDHEX$$finition du fichier source en base." ) 												
				iRet = -1
				Return iRet
			End If 
			
		Next
		
		If iRet = 1 Then
			idwCharg.RowsDiscard ( 1, 1, Primary! ) // Suppression ligne d'ent$$HEX1$$ea00$$ENDHEX$$te pour la suite des contr$$HEX1$$f400$$ENDHEX$$les.
			This.uf_Trace ( "ECR", "Le fichier source contient " + String ( lTotLigSource - 1 ) + " lignes de donn$$HEX1$$e900$$ENDHEX$$es et 1 ligne d'ent$$HEX1$$ea00$$ENDHEX$$te") 			
			This.uf_Trace ( "ECR", "Contr$$HEX1$$f400$$ENDHEX$$le des ent$$HEX1$$ea00$$ENDHEX$$tes du fichier source : OK") 			
		End If

		/*------------------------------------------------------------------*/
		/* Contr$$HEX1$$f400$$ENDHEX$$le des fichier/r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rentiel (pays)								  */
		/*------------------------------------------------------------------*/
		This.uf_Trace ( "ECR", "Contr$$HEX1$$f400$$ENDHEX$$le fichier/r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rentiel (pays) en cours...") 

		sFiltreParam = "SUPPORT = 'FICH' AND ID_VAL = '-1'" 
		sTriParam = "ID_ORDRE A" 
		idwStkParam.SetFilter ( sFiltreParam  )
		idwStkParam.SetSort   ( sTriParam     )
		idwStkParam.Filter ()
		idwStkParam.Sort ()		
		
		sTabVal = sTabNull
		sTabVal [1] = Upper ( idwStkParam.GetItemString ( 1, "NOM_REF" )) // Nom du r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rentiel fichier dans le param
		sTabVal [2] = "2" // Colonne Pays
		
		lTotLigSource= idwCharg.RowCount ()
		
		lTot = UpperBound ( sTabVal )
		For lCptLigSource = 1 To lTotLigSource

			sValCtrle = Upper ( Trim ( idwCharg.GetItemString ( lCptLigSource, Long ( sTabVal [2] ) ) ) ) 
	
			If sValCtrle <> sTabVal [1] Then
				This.uf_Trace ( "ECR", "ERREUR : Un enregistrement colonne " + sTabVal [2] + " ne devrait pas se trouver dans ce r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rentiel :" )
				This.uf_Trace ( "ECR", "ERREUR : Valeur lue dans le fichier source : " + sValCtrle + ", valeur attendue dans le param$$HEX1$$e800$$ENDHEX$$trage : " + sTabVal [1] )
				This.uf_Trace ( "ECR", "ERREUR : Le fichier source que vous chercher $$HEX2$$e0002000$$ENDHEX$$int$$HEX1$$e900$$ENDHEX$$grer ne correspond pas au r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rentiel que vous avez choisi (pays)" )
				iRet = -1
				Return iRet
			End If
		Next

		If iRet = 1 Then
			This.uf_Trace ( "ECR", "Contr$$HEX1$$f400$$ENDHEX$$le fichier/r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rentiel (pays) sur le fichier : OK") 			
		Else
			Return iRet			
		End If		
		
		
		/*------------------------------------------------------------------*/
		/* Contr$$HEX1$$f400$$ENDHEX$$le des doublons                                            */
		/* Les colonne 3 et 4 d$$HEX1$$e900$$ENDHEX$$finissent la marque et le mod$$HEX1$$e800$$ENDHEX$$le pour ce    */
		/* r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rentiel                                                      */
		/*------------------------------------------------------------------*/
		This.uf_Trace ( "ECR", "Contr$$HEX1$$f400$$ENDHEX$$le des doublons en cours...") 
		sTabVal = sTabNull
		sTabVal [1] = "3"
		sTabVal [2] = "4"		

		lTotLigSource= idwCharg.RowCount ()	// Il peut avoir chang$$HEX1$$e900$$ENDHEX$$
		
		idwCharg.Setsort ( "#" + sTabVal [1] + " A," + "#" + sTabVal [2] +" A" )
		idwCharg.Dynamic Event ue_switchblocage ( TRUE )
		idwCharg.Sort ()
		idwCharg.Dynamic Event ue_switchblocage ( FALSE )

		sValSource = ""
		For lCptLigSource = 1 To lTotLigSource
			sValCtrle = Upper ( Trim ( idwCharg.GetItemString ( lCptLigSource, Long ( sTabVal [1] ) ) ) ) + " " + Upper ( Trim ( idwCharg.GetItemString ( lCptLigSource, Long ( sTabVal [2] ) ) ) )

			If sValCtrle = sValSource  Then
				This.uf_Trace ( "ECR", "ERREUR : Un doublon est pr$$HEX1$$e900$$ENDHEX$$sent dans le fichier source sur : " + sValCtrle ) 
				iRet = -1
			End If

			sValSource = sValCtrle
			
		Next

		If iRet = 1 Then
			This.uf_Trace ( "ECR", "Contr$$HEX1$$f400$$ENDHEX$$le des doublons sur le fichier source : OK") 			
		Else 
			Return iRet			
		End If

		/*------------------------------------------------------------------*/
		/* Contr$$HEX1$$f400$$ENDHEX$$le des types															  */
		/*------------------------------------------------------------------*/
		This.uf_Trace ( "ECR", "Contr$$HEX1$$f400$$ENDHEX$$le des types en cours...") 
		sTabVal = sTabNull
		sTabVal [1] = "5" // Frequence
		sTabVal [2] = "6" // Prix bas
		sTabVal [3] = "7" // Prix Haut
		
		lTotLigSource= idwCharg.RowCount ()
		
		lTot = UpperBound ( sTabVal )
		For lCptLigSource = 1 To lTotLigSource

			For lCptCol = 1 to lTot
				sValCtrle = Upper ( Trim ( idwCharg.GetItemString ( lCptLigSource, Long ( sTabVal [lCptCol] ) ) ) ) 
	
				If Not IsNumber ( sValCtrle )  Then
					This.uf_Trace ( "ECR", "ERREUR : Dans la colonne " + sTabVal [lCptCol] + " une valeur n'est pas un montant : " + sValCtrle ) 
					iRet = -1
				End If
			Next
		Next

		If iRet = 1 Then
			This.uf_Trace ( "ECR", "Contr$$HEX1$$f400$$ENDHEX$$le des types de donn$$HEX1$$e900$$ENDHEX$$es sur le fichier : OK") 			
		Else
			Return iRet			
		End If
		
		
End Choose

Return iRet 



end function

public function String uf_gettrtencours ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_integration::uf_GetTrtEnCours (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 31/07/2008 10:27:30
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Retourne le traitement en cours.
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Return isCasTrtEnCours
end function

private function integer uf_trt_rechprxpack ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_integration::uf_trt_RechPrxPack (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 30/07/2008 16:11:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$ler Particuliers des prix pack
//*  					  
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

String sReferentiel, sValCtrle, sValSource, sValCtrleColExcel, sTabVal [], sTabNull[], sVal
String sFiltreParam, sTriParam
Long lTotLigCtrle, lTotLigSource, lTotCol
Long lCptCol, lCptLigCtrle, lCptLigSource
Long lTot
Int iRet

iRet = 1

sReferentiel = Upper ( idwTrt.GetItemString ( 1, "NOM_REF" ))

Choose Case sReferentiel 
		
	Case "IFR_FRANCE", "IFR_SUISSE"

		/*------------------------------------------------------------------*/
		/* Contr$$HEX1$$f400$$ENDHEX$$le prix pack															  */
		/*------------------------------------------------------------------*/
		This.uf_Trace ( "ECR", "Contr$$HEX1$$f400$$ENDHEX$$le des prix pack en cours...") 

		sFiltreParam = "SUPPORT = 'PARAM' AND UPPER ( ID_VAL ) = 'PRIX_PACK'" 
		sTriParam = "ID_ORDRE A" 
		idwStkParam.SetFilter ( sFiltreParam  )
		idwStkParam.SetSort   ( sTriParam     )
		idwStkParam.Filter ()
		idwStkParam.Sort ()		

		If idwStkParam.RowCount ( ) <> 1 Then
			This.uf_Trace ( "ECR", "ERREUR : Probl$$HEX1$$e800$$ENDHEX$$me de param$$HEX1$$e800$$ENDHEX$$trage sur le prix pack mini, nombre de lignes trouv$$HEX1$$e900$$ENDHEX$$es : " + String ( idwStkParam.RowCount ( ) )  )
			iRet = -1
			Return iRet
		End If

		sTabVal = sTabNull
		sTabVal [1] = "5" // Colonne Frequence
		sTabVal [2] = idwStkParam.GetItemString ( 1, "VAL_BASE" ) // Valeur param$$HEX1$$e800$$ENDHEX$$trage prix pack mini
		sTabVal [3] = "3" // Colonne Marque
		sTabVal [4] = "4" // Colonne modele
		
		IF Not IsNumber ( sTabVal [2] ) Then
			This.uf_Trace ( "ECR", "ERREUR : Probl$$HEX1$$e800$$ENDHEX$$me de param$$HEX1$$e800$$ENDHEX$$trage sur le prix pack mini, valeur param$$HEX1$$e800$$ENDHEX$$tr$$HEX1$$e900$$ENDHEX$$e: " + sTabVal [2]  )
			iRet = -1
			Return iRet
		End If

		IF dec ( sTabVal [2] ) <= 0 Then
			This.uf_Trace ( "ECR", "ERREUR : Probl$$HEX1$$e800$$ENDHEX$$me de param$$HEX1$$e800$$ENDHEX$$trage sur le prix pack mini, valeur n$$HEX1$$e900$$ENDHEX$$gative : " + sTabVal [2]  )
			iRet = -1
			Return iRet
		End If

		// Le prix pack param$$HEX1$$e800$$ENDHEX$$tr$$HEX2$$e9002000$$ENDHEX$$est fiable, on l'affiche
		idwTrt.SetItem ( 1, "PRIX_PACK_MINI", Dec ( sTabVal [2] ) )
		idwTrt.SetRedraw ( TRUE )
		
		lTotLigSource= idwCharg.RowCount ()
		
		lTot = UpperBound ( sTabVal )
		For lCptLigSource = 1 To lTotLigSource

			sValCtrle = Upper ( Trim ( idwCharg.GetItemString ( lCptLigSource, Long ( sTabVal [1] ) ) ) ) 
	
			If Dec ( sValCtrle ) < Dec ( sTabVal [2] ) Then
				sVal = Upper ( Trim ( idwCharg.GetItemString ( lCptLigSource, Long ( sTabVal [3] ) ) ) ) + " " + Upper ( Trim ( idwCharg.GetItemString ( lCptLigSource, Long ( sTabVal [4] ) ) ) )		

				This.uf_Trace ( "ECR", "ERREUR : le prix fr$$HEX1$$e900$$ENDHEX$$quent du mod$$HEX1$$e800$$ENDHEX$$le " + sVal + " (" + sValCtrle + ") est sup$$HEX1$$e900$$ENDHEX$$rieur au prix pack mini (" + sTabVal [2] + ")" ) 
				iRet = -1

			End If
		Next

		If iRet = 1 Then
			This.uf_Trace ( "ECR", "Contr$$HEX1$$f400$$ENDHEX$$le des prix pack sur le fichier : OK") 			
		Else 
			Return iRet			
		End If

		
End Choose

Return iRet 



end function

private function integer uf_trt_majdefbase ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_ifr_integration::uf_trt_MajDefBase (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 30/07/2008 16:11:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Mise $$HEX2$$e0002000$$ENDHEX$$jour en base.
//*  					  
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

String sReferentiel, sValCtrle, sValSource, sValCtrleColExcel, sTabVal [], sTabNull[], sVal
String sFiltreParam, sTriParam, sValFrnFonctBase 
String sCasTrt, sLibRefRf, sMarque, sReference, sColFonct, sValFonct, sOperateur, sAdrMAilSPB 
String sMarModlSav
Long lTotLigCtrle, lTotLigSource, lTotCol, lTotLigFonctEnBase 
Long lCptCol, lCptLigCtrle, lCptLigSource, lCptLigFonctEnBase 
Long lTot, lIdTrait, lNumColFicSource, lValRet
Int iRet, iIdCtgApp
decimal {2} dcFrequence

iRet = 1
sMarModlSav = ""

sReferentiel = Upper ( idwTrt.GetItemString ( 1, "NOM_REF" ))
sAdrMAilSPB = Upper ( idwTrt.GetItemString ( 1, "ADRESSE_MAIL" ))
If IsNull ( sAdrMAilSPB ) Then sAdrMAilSPB = ""

//subroutine PS_I02_IFR ( string sCasTrt, string sLibRefRf, string sReference, Integer iIdCtgApp, decimal {2} dcFrequence, string sColFonct, string sValFonct, string sOperateur, Ref integer iIdTrait ) RPCFUNC ALIAS FOR "sysadm.PS_I02_IFR" // JFF [DCMP080388] le 05/08/2008

Choose Case sReferentiel 
		
	Case "IFR_FRANCE", "IFR_SUISSE"

		/*------------------------------------------------------------------*/
		/* Contr$$HEX1$$f400$$ENDHEX$$le prix pack															  */
		/*------------------------------------------------------------------*/
		This.uf_Trace ( "ECR", "Mise $$HEX2$$e0002000$$ENDHEX$$jour en base en cours...") 

		sCasTrt = "ID_TRAIT"

		// D$$HEX1$$e900$$ENDHEX$$termination d'un id_traitement
		SQLCA.PS_I02_IFR ( sCasTrt, sLibRefRf, sMarque, sReference, iIdCtgApp, dcFrequence, sColFonct, sValFonct, sOperateur, sAdrMAilSPB, lIdTrait, lValRet ) 
		If SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0 Then
			If IsNull ( lIdTrait ) Then lIdTrait = -100
			If lIdTrait > 0 Then
				F_commit ( SQLCA, True) 
				This.uf_Trace ( "ECR", "Identifiant de traitement en base : " + String ( lIdTrait ) + " (commit$$HEX1$$e900$$ENDHEX$$)." )
			Else
				F_commit ( SQLCA, False) 
				This.uf_Trace ( "ECR", "ERREUR : Identifiant de traitement en base non valide : " + String ( lIdTrait )) 
				This.uf_Trace ( "ECR", "ERREUR : Le traitement se termine anormalement !!, le fichier source n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$int$$HEX1$$e900$$ENDHEX$$gr$$HEX2$$e9002000$$ENDHEX$$en base !!.") 							
				This.uf_Trace ( "ECR", "Fin du traitement en erreur.") 											
				iRet = -1
			End If
		Else 
			F_commit ( SQLCA, False) 
			This.uf_Trace ( "ECR", "ERREUR : Probl$$HEX1$$e800$$ENDHEX$$me de r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration de l'identifiant de traitement (" + SQLCA.SQLErrText + ")" )
			This.uf_Trace ( "ECR", "ERREUR : Le traitement se termine anormalement !!, le fichier source n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$int$$HEX1$$e900$$ENDHEX$$gr$$HEX2$$e9002000$$ENDHEX$$en base !!.") 							
			This.uf_Trace ( "ECR", "Fin du traitement en erreur.") 											
			iRet = -1
		End If		
					
		If iRet = 1 Then
		// D$$HEX1$$e900$$ENDHEX$$but du traitement de maj
			This.uf_Trace ( "ECR", "Insertion des donn$$HEX1$$e900$$ENDHEX$$es en base en cours...") 		
			
			lTotLigSource= idwCharg.RowCount ()
			sLibRefRf = Upper ( idwTrt.GetItemString ( 1, "NOM_REF" ))
			sOperateur = stGlb.sCodOper
	
			sTabVal = sTabNull
			sTabVal [1] = "3" // Marque
			sTabVal [2] = "4" // Reference
			sTabVal [3] = "5" // Frequence
			sTabVal [4] = "8" // Cat$$HEX1$$e900$$ENDHEX$$gorie
			
			// Maj des donn$$HEX1$$e900$$ENDHEX$$es du fichier en base
//			For lCptLigSource = 1 To lTotLigSource  [DEBUG]
			For lCptLigSource = 1 To 2  // [DEBUG]
				
				// Insert initial pour un Row
				sCasTrt = "INSERT_ROW_INITIAL"
				
				sMarque = Upper ( Trim ( idwCharg.GetItemString ( lCptLigSource, Long ( sTabVal [1] ) ) ) ) 
				sReference = Upper ( Trim ( idwCharg.GetItemString ( lCptLigSource, Long ( sTabVal [2] ) ) ) ) 

				iIdCtgApp = Long ( idwCharg.GetItemString ( lCptLigSource, Long ( sTabVal [4] ) ) )
				If IsNull ( iIdCtgApp ) Then iIdCtgApp = 0
				dcFrequence = Dec ( idwCharg.GetItemString ( lCptLigSource, Long ( sTabVal [3] ) ) )
			
				SQLCA.PS_I02_IFR ( sCasTrt, sLibRefRf, sMarque, sReference, iIdCtgApp, dcFrequence, sColFonct, sValFonct, sOperateur, sAdrMAilSPB , lIdTrait, lValRet ) 			
				If Not ( SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0 ) Then
					F_commit ( SQLCA, False) 
					This.uf_Trace ( "ECR", "ERREUR : Probl$$HEX1$$e800$$ENDHEX$$me d'insertion en base pour l'enregistrement " + sMarque + " " + sReference + " ( prix " + String ( dcFrequence) + ")" )
					This.uf_Trace ( "ECR", "ERREUR : Le traitement se termine anormalement !!, le fichier source n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$int$$HEX1$$e900$$ENDHEX$$gr$$HEX2$$e9002000$$ENDHEX$$en base !!.") 							
					This.uf_Trace ( "ECR", "Fin du traitement en erreur.") 											
					iRet = -1
				End If
				
				If iRet = 1 Then
					// Mise $$HEX2$$e0002000$$ENDHEX$$jour final du Row 
					sCasTrt = "UPDATE_ROW_FONCT"
		
					sFiltreParam = "SUPPORT = 'TBLE' AND POS ( UPPER ( ID_VAL ), '_FONCT_', 1 ) > 0" 
					sTriParam = "ID_ORDRE A" 
					idwStkParam.SetFilter ( sFiltreParam  )
					idwStkParam.Filter ()
		
					lTotLigFonctEnBase = idwStkParam.Rowcount ()
					
					For lCptLigFonctEnBase = 1 To lTotLigFonctEnBase 
		
						sFiltreParam = "SUPPORT = 'TBLE' AND POS ( UPPER ( ID_VAL ), '_FONCT_', 1 ) > 0" 
						sTriParam = "ID_ORDRE A" 
						idwStkParam.SetFilter ( sFiltreParam  )
						idwStkParam.SetSort   ( sTriParam     )
						idwStkParam.Filter ()
						idwStkParam.Sort ()	
						
						sValFrnFonctBase = Upper ( idwStkParam.GetItemString ( lCptLigFonctEnBase, "VAL_FRN" ) ) 
						sColFonct = Lower ( idwStkParam.GetItemString ( lCptLigFonctEnBase, "ID_VAL" ) )
						
						sFiltreParam = "SUPPORT = 'FICH' AND ID_VAL <> '-1'" 
						sTriParam = "ID_ORDRE A" 
						idwStkParam.SetFilter ( sFiltreParam  )
						idwStkParam.SetSort   ( sTriParam     )
						idwStkParam.Filter ()
						idwStkParam.Sort ()
		
						lNumColFicSource = idwStkParam.Find ( "UPPER ( VAL_FRN ) = '" + sValFrnFonctBase + "'", 1, idwStkParam.RowCount () )
						
						// La fonctionnalit$$HEX2$$e9002000$$ENDHEX$$devant $$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$crite en base n'est pas trouv$$HEX1$$e900$$ENDHEX$$e dans le fichier source Frn.
						// Elle a pu exister avant, mais n'existe plus maintenant, on mets $$HEX2$$e0002000$$ENDHEX$$jour tout de m$$HEX1$$ea00$$ENDHEX$$me, obligatoirement! avec la valeur "NO"
						If lNumColFicSource <= 0 Then 
							sValFonct = "NO"
		
						// La fonctionnalit$$HEX2$$e9002000$$ENDHEX$$devant $$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$crite en base est trouv$$HEX1$$e900$$ENDHEX$$e dans le fichier source Frn.
						Else 
							sValFonct = Upper ( Trim ( idwCharg.GetItemString ( lCptLigSource, lNumColFicSource ) ) )
							If IsNull ( sValFonct ) Or sValFonct = "" Then 
								sValFonct = "NO" // La fonctionnalit$$HEX2$$e9002000$$ENDHEX$$du fichier peut $$HEX1$$ea00$$ENDHEX$$tre aussi vide, on compl$$HEX1$$e800$$ENDHEX$$te par NO
							ENd IF
						ENd If
						
						SQLCA.PS_I02_IFR ( sCasTrt, sLibRefRf, sMarque, sReference, iIdCtgApp, dcFrequence, sColFonct, sValFonct, sOperateur, sAdrMAilSPB ,lIdTrait, lValRet ) 			
						If Not ( SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0 ) Then
							F_commit ( SQLCA, False) 
							This.uf_Trace ( "ECR", "ERREUR : Probl$$HEX1$$e800$$ENDHEX$$me de mise $$HEX2$$e0002000$$ENDHEX$$jour en base colonne : " + sColFonct+ ", valeur : " + sValFonct + ", de l'enregistrement ins$$HEX1$$e900$$ENDHEX$$r$$HEX2$$e9002000$$ENDHEX$$" + sMarque + " " + sReference + " (prix " + String ( dcFrequence) + ")" )
							This.uf_Trace ( "ECR", "ERREUR : Le traitement se termine anormalement !!, le fichier source n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$int$$HEX1$$e900$$ENDHEX$$gr$$HEX2$$e9002000$$ENDHEX$$en base !!.") 							
							This.uf_Trace ( "ECR", "Fin du traitement en erreur.") 											
							iRet = -1
						Else 
							If lValRet > 0 And sMarque + sReference <> sMarModlSav Then 
								This.uf_Trace ( "ECR", "Nouveau mobile ! : " + sMarque + " " + sReference + " (prix " + String ( dcFrequence) + ")" )
								sMarModlSav = sMarque + sReference
							End If
						End If
						If iRet = -1 Then Exit					
					Next
				End If				
				If iRet = -1 Then Exit				
			Next
		End If
		
		If iRet = 1 Then
			F_commit ( SQLCA, True) 
			This.uf_Trace ( "ECR", "Insertion des donn$$HEX1$$e900$$ENDHEX$$es en base termin$$HEX1$$e900$$ENDHEX$$e") 			
			This.uf_Trace ( "ECR", "(Cette insertion est d$$HEX1$$e900$$ENDHEX$$finitive (commit$$HEX1$$e900$$ENDHEX$$e) quoi qu'il arrive dans la suite du traitement, utilisez le traitement d'annulation si besoin de supprimer le traitement en base)") 			
		End If


		// Suppression des lignes SPB
		If iRet = 1 Then
			sCasTrt = "SUPP_LIG_SPB"
			This.uf_Trace ( "ECR", "Fusion en base des provenances SPB/IFR en cours...") 				

			SQLCA.PS_I02_IFR ( sCasTrt, sLibRefRf, sMarque, sReference, iIdCtgApp, dcFrequence, sColFonct, sValFonct, sOperateur, sAdrMAilSPB, lIdTrait, lValRet )
			
			If Not ( SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0 ) Then
				F_commit ( SQLCA, False) 
				This.uf_Trace ( "ECR", "ERREUR : Probl$$HEX1$$e800$$ENDHEX$$me lors de la suppression des provenance SPB." )
				This.uf_Trace ( "ECR", "ERREUR : Le traitement se termine anormalement !!, le fichier source a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$partiellement int$$HEX1$$e900$$ENDHEX$$gr$$HEX2$$e9002000$$ENDHEX$$en base !!.") 							
				This.uf_Trace ( "ECR", "Fin du traitement en erreur.") 											
				iRet = -1
			Else
				F_commit ( SQLCA, True) 
				This.uf_Trace ( "ECR", "Fusion en base des provenances SPB/IFR termin$$HEX1$$e900$$ENDHEX$$e (" + String ( lValRet ) + ") (commit$$HEX1$$e900$$ENDHEX$$)" )
			End If
		End If
		
		// Maj des mauvais codes IFR connus.
		If iRet = 1 Then
			sCasTrt = "MAJ_MAUVAIS_CODE"
			
			This.uf_Trace ( "ECR", "Correction des codes IFR erron$$HEX1$$e900$$ENDHEX$$s en cours...") 				
			SQLCA.PS_I02_IFR ( sCasTrt, sLibRefRf, sMarque, sReference, iIdCtgApp, dcFrequence, sColFonct, sValFonct, sOperateur, sAdrMAilSPB, lIdTrait, lValRet )
			If Not ( SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0 ) Then
				F_commit ( SQLCA, False) 
				This.uf_Trace ( "ECR", "ERREUR : Probl$$HEX1$$e800$$ENDHEX$$me lors de la Correction des codes IFR erron$$HEX1$$e900$$ENDHEX$$s." )
				This.uf_Trace ( "ECR", "ERREUR : Le traitement se termine anormalement !!, le fichier source a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$partiellement int$$HEX1$$e900$$ENDHEX$$gr$$HEX2$$e9002000$$ENDHEX$$en base !!.") 							
				This.uf_Trace ( "ECR", "Fin du traitement en erreur.") 											
				iRet = -1
			Else
				F_commit ( SQLCA, True) 
				This.uf_Trace ( "ECR", "Correction des codes IFR erron$$HEX1$$e900$$ENDHEX$$s termin$$HEX1$$e900$$ENDHEX$$e (commit$$HEX1$$e900$$ENDHEX$$)" )
			End If
		End If
		
		// Contr$$HEX1$$f400$$ENDHEX$$le codes IFR (pour d$$HEX1$$e900$$ENDHEX$$tecter les mauvais codes inconnu).
		If iRet = 1 Then
			sCasTrt = "CTRL_VAL_CODE"
			
			This.uf_Trace ( "ECR", "Recherche et aggr$$HEX1$$e900$$ENDHEX$$gation des codes IFR en cours...")
			SQLCA.PS_I02_IFR ( sCasTrt, sLibRefRf, sMarque, sReference, iIdCtgApp, dcFrequence, sColFonct, sValFonct, sOperateur, sAdrMAilSPB, lIdTrait, lValRet )
			If Not ( SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0 ) Then
				F_commit ( SQLCA, False) 
				This.uf_Trace ( "ECR", "ERREUR : Probl$$HEX1$$e800$$ENDHEX$$me lors de la Recherche des codes IFR." )
				This.uf_Trace ( "ECR", "ERREUR : Le traitement se termine anormalement !!, le fichier source a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$partiellement int$$HEX1$$e900$$ENDHEX$$gr$$HEX2$$e9002000$$ENDHEX$$en base !!.") 							
				This.uf_Trace ( "ECR", "Fin du traitement en erreur.") 											
				iRet = -1
			Else
				F_commit ( SQLCA, True) 
				This.uf_Trace ( "ECR", "Recherche et aggr$$HEX1$$e900$$ENDHEX$$gation termin$$HEX1$$e900$$ENDHEX$$e, envoi du fichier Excel par mail $$HEX2$$e0002000$$ENDHEX$$" + sAdrMAilSPB )
				This.uf_Trace ( "ECR", "Traiter ce fichier le plus rapidement pour $$HEX1$$e900$$ENDHEX$$ventuellement d$$HEX1$$e900$$ENDHEX$$tecter des codes identiques mais libell$$HEX1$$e900$$ENDHEX$$s diff$$HEX1$$e900$$ENDHEX$$remment, pour une m$$HEX1$$ea00$$ENDHEX$$me colonne." )
				This.uf_Trace ( "ECR", "Si de tels cas sont trouv$$HEX1$$e900$$ENDHEX$$s, contactez d$$HEX1$$e800$$ENDHEX$$s que possible les $$HEX1$$e900$$ENDHEX$$tudes sinistre et faire une DMDI en pr$$HEX1$$e900$$ENDHEX$$cisant le code de la colonne, " )
				This.uf_Trace ( "ECR", "le nom fournisseur de la colonne, la valeur erron$$HEX1$$e900$$ENDHEX$$e, le nouvelle valeur de substitution " )			
			End If
		End If

		// Dans tous les cas
		sCasTrt = "FIN_DE_TRAITEMENT"
		
		SQLCA.PS_I02_IFR ( sCasTrt, sLibRefRf, sMarque, sReference, iIdCtgApp, dcFrequence, sColFonct, sValFonct, sOperateur, sAdrMAilSPB, lIdTrait, lValRet )
		If Not ( SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0 ) Then
			F_commit ( SQLCA, False) 
			This.uf_Trace ( "ECR", "ERREUR : Probl$$HEX1$$e800$$ENDHEX$$me sur la phase de 'fin de traitement'.") 							
			// On ne consid$$HEX1$$e800$$ENDHEX$$re pas cette erreur comme bloquante.
		Else 
			F_commit ( SQLCA, True) 			
		End If
		
		If iRet = 1 Then
			F_commit ( SQLCA, True) // Commit de s$$HEX1$$fb00$$ENDHEX$$ret$$HEX4$$e9002000e0002000$$ENDHEX$$la fin
			This.uf_Trace ( "ECR", "Mise $$HEX2$$e0002000$$ENDHEX$$jour en base du fichier source : OK") 			
			This.uf_Trace ( "ECR", "Le traitement se termine normalement, le fichier source a bien $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$int$$HEX1$$e900$$ENDHEX$$gr$$HEX2$$e9002000$$ENDHEX$$en base.") 							
			This.uf_Trace ( "ECR", "Fin du traitement.") 											
		Else
			F_commit ( SQLCA, False) // Rollback de s$$HEX1$$fb00$$ENDHEX$$ret$$HEX1$$e900$$ENDHEX$$
		End If
		
End Choose

Return iRet 



end function

on u_sp_ifr_integration.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_sp_ifr_integration.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

