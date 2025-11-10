$PBExportHeader$w_trt_choix_regen_courrier_simpa2.srw
forward
global type w_trt_choix_regen_courrier_simpa2 from window
end type
type cb_continuer from commandbutton within w_trt_choix_regen_courrier_simpa2
end type
type cb_arreter from commandbutton within w_trt_choix_regen_courrier_simpa2
end type
type dw_1 from datawindow within w_trt_choix_regen_courrier_simpa2
end type
end forward

global type w_trt_choix_regen_courrier_simpa2 from window
integer x = 215
integer y = 220
integer width = 1504
integer height = 580
boolean titlebar = true
string title = "Préparation des courriers"
windowtype windowtype = response!
long backcolor = 12632256
cb_continuer cb_continuer
cb_arreter cb_arreter
dw_1 dw_1
end type
global w_trt_choix_regen_courrier_simpa2 w_trt_choix_regen_courrier_simpa2

type variables
Private :
	S_Pass		invTrtAttrib
	
	

	Boolean		ibFermerFenetre

	String		isZn_IdInter

	String		isZn_CodInter
	String      isZn_IdCanal
	String		isAutresDroits
end variables

forward prototypes
private subroutine wf_positionnerobjet ()
private subroutine wf_affecter_typdoc ()
private subroutine wf_controlergestion ()
private function boolean wf_controler_canal (string ascas, long alrow, string asdata)
end prototypes

private subroutine wf_positionnerobjet ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Choix_Regen_Courrier::Wf_PositionnerObjet		(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 13/10/2001 16:10:01
//* Libellé			: 
//* Commentaires	: Positionnement dynamique des objets de la fenêtre
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1	PHG	02/09/2009	[PHG].[20090902] Correction Taille fenetre pour montrer Sens interdit
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* Position de la fenêtre.                                          */
/*------------------------------------------------------------------*/
This.X			=  900
This.Y			= 1500
This.Width		= 4370 + 50 // [PB2022_TAILLE_FEN]
This.Height		=  790 + 50 // [PB2022_TAILLE_FEN]

/*------------------------------------------------------------------*/
/* Position de la DataWindow.                                       */
/*------------------------------------------------------------------*/
Dw_1.X			=   15
Dw_1.Y			=   35
Dw_1.Width		= 4370 // #1 4270  //3990
Dw_1.Height		=  480  //440

/*------------------------------------------------------------------*/
/* Position des Boutons de commande.                                */
/*------------------------------------------------------------------*/
Cb_Arreter.X	=  1665  //1560
Cb_Arreter.Y	=   530

Cb_Continuer.X	=  2160  //2030
Cb_Continuer.Y	=   530


end subroutine

private subroutine wf_affecter_typdoc ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Choix_Regen_Courrier_simpa2::Wf_Affecter_TypDoc		(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 13/10/2001 16:10:01
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ     PAR      Date	    	Modification
//* #1		JFF		04/05/04  	DCMP 040020 SVE
//* #2		JCA		05/09/06		DCMP 60574 - Ajout de nouvelle nature de document
//* #3		PHG		06/08/08		[DCMP080573] Option DP/103 : 
//*										Autorisation Choix Catégorie de courrier
//* #4		PHG		12/01/08		[DCMP090023] Extension DP/103 : 
//*										Affectation de la catégorie suivant 
//*										un code courrier paramétré.
//*         JFF      12/10/10    [20101012145945137] ajout ctg LCL
//			FPI	18/04/2011	[VDoc3573] Modification de l'option 69
// 			FPI	19/06/2014	[VDOC14696] Si DR, on ne tient pas compte de la 103
//       JFF   11/06/2019 [PM425-1]
//*-----------------------------------------------------------------

Long		lTotLig, lCpt, lLig, lTotInter
String	sRech
n_cst_attrib_key lnvKey[]
//* #2
long lDeb, lFin, lGrp, lLigInter, lIdIDB
string sRechInter, sCodInter
//* #2 - FIN
//* #4
constant string sKeyForcage = "FORCAGE_ID_COUR_ASS"
n_cst_string lnvString
string	sTabIdCour[]
boolean  bIdCourOk =FALSE
long		lCpt2
//* #4 - FIN
String sVal

/*------------------------------------------------------------------*/
/* Pour SAVANE, on ne conserve pas le COD_BQ de l'interlocuteur de  */
/* type BANQUE, donc la gestion des courriers BNP est impossible.   */
/*------------------------------------------------------------------*/
If	invTrtAttrib.sTab[1] = "SAVANE" Then Return

/*------------------------------------------------------------------*/
/* Si le Code Banque appartient à BNP, on le positionne dans le     */
/* type de document afin de prévenir le gestionnaire.               */
/*------------------------------------------------------------------*/
lTotLig		= dw_1.RowCount ()
lTotInter	= invTrtAttrib.dwTab[1].RowCount ()

For	lCpt = 1 To lTotLig 

/*------------------------------------------------------------------*/
/* #1 : Priorité au droits fournis par le BIN.                      */
/*------------------------------------------------------------------*/
/* Rang 9 : Gestionnaire DSC                                        */
/*------------------------------------------------------------------*/
		If Mid ( isAutresDroits, 9, 1 ) = "1" Then
			dw_1.SetItem ( lCpt, "ID_TYP_DOC", 5 ) 		// ... Retour DSC
			
			// [VDOC14696]
			sRechInter	= isZn_IdInter + " = " + String ( dw_1.GetItemNumber ( lCpt, "ID_INTER" ) )
			lLigInter = invTrtAttrib.dwTab[1].Find ( sRechInter, 1, lTotInter )
		
			if invTrtAttrib.dwTab[1].GetItemString ( lLigInter, "COD_MODE_REG") = "C" and & 
				invTrtAttrib.dwTab[1].GetItemNumber ( lLigInter, "MT_A_REG") > 0  then 
				dw_1.SetItem ( lCpt, "ID_TYP_DOC", 82 )  // Retour au DR - Chèque à joindre
			End if
			// :[VDOC14696]
			
			// [PM425-1]
			lIdIDB = invTrtAttrib.dwTab[1].GetItemNumber ( lLigInter, "ID_I_DB" ) 			
			sCodInter = invTrtAttrib.dwTab[1].GetItemString ( lLigInter, "COD_INTER" ) 			
			
			Choose Case True
				Case Not IsNull ( lIdIDB ) And sCodInter = "A"
					dw_1.SetItem ( lCpt, "ID_TYP_DOC", 88 )  // DR - Assuré avec double banque

				Case Not IsNull ( lIdIDB ) And sCodInter = "B"
					dw_1.SetItem ( lCpt, "ID_TYP_DOC", 87 )  // DR - Banque avec double assuré
					
			End Choose 
			// /[PM425-1]			
	
			Continue			
		End If

		If Upper ( dw_1.GetItemString ( lCpt, "COD_INTER" ) ) = "B" Then
/*------------------------------------------------------------------*/
/* On recherche la ligne correspondant à l'interlocuteur BANQUE     */
/* dans la liste des interlocuteurs.                                */
/*------------------------------------------------------------------*/
			Choose Case invTrtAttrib.sTab[1]
			Case "SAVANE"
				sRech	= isZn_IdInter + " = '" + String ( dw_1.GetItemNumber ( lCpt, "ID_INTER" ) ) + "'"
			Case "SIMPA2", "SINDI"
				sRech	= isZn_IdInter + " = " + String ( dw_1.GetItemNumber ( lCpt, "ID_INTER"  ) )
			End Choose

			lLig	= invTrtAttrib.dwTab[1].Find ( sRech, 1, lTotInter )
/*------------------------------------------------------------------*/
/* On vérifie s'il s'agit de la BNP.                                */
/*------------------------------------------------------------------*/
			If invTrtAttrib.dwTab[1].GetItemString ( lLig, "COD_BQ" ) = "30004" Then
				dw_1.SetItem ( lCpt, "ID_TYP_DOC", 1 ) 		// ... BNP
				Continue
			End If
			
			// [20101012145945137]
			If invTrtAttrib.dwTab[1].GetItemString ( lLig, "COD_BQ" ) = "30002" Then
				dw_1.SetItem ( lCpt, "ID_TYP_DOC", 60 ) 		// ... LCL
				Continue
			End If
			// [20101012145945137]		
	
		End If	

//* #2
/*	dwProduit 	= invTrtAttrib.dwNorm[3]	*/
/*	dwDetPro 	= invTrtAttrib.dwNorm[4]	*/
/*	Id_Prod		= invTrtAttrib.lTab[1] 		*/

	lGrp = invTrtAttrib.dwNorm[3].GetItemNumber ( 1, "ID_GRP" )
	sRechInter	= isZn_IdInter + " = " + String ( dw_1.GetItemNumber ( lCpt, "ID_INTER" ) )
	lLigInter = invTrtAttrib.dwTab[1].Find ( sRechInter, 1, lTotInter )

	F_RechDetPro ( lDeb, lFin, invTrtAttrib.dwNorm[4], invTrtAttrib.lTab[1], "-DP", 69 )
	If lDeb > 0 Then
		// [VDoc3573]
		sVal=invTrtAttrib.dwNorm[4].GetItemString(lDeb,"VAL_CAR")
		if invTrtAttrib.dwTab[1].GetItemString ( lLigInter, "COD_MODE_REG") = "C" and & 
			invTrtAttrib.dwTab[1].GetItemNumber ( lLigInter, "MT_A_REG") > 0  then 
			sVal=lnvString.of_getkeyvalue( sVal, "ID_TYP_DOC_AVEC_CHEQUE",";")
		Else
			sVal=lnvString.of_getkeyvalue( sVal, "ID_TYP_DOC_SANS_CHEQUE",";")
		End if
		
		If Len(sVal) > 0 Then
			dw_1.SetItem ( lCpt, "ID_TYP_DOC",Long(sVal))
			Continue
		End if
		
		/*Choose case lGrp
			Case 223 // ID_GRP de SFR
				if invTrtAttrib.dwTab[1].GetItemString ( lLigInter, "COD_MODE_REG") = "C" and & 
						invTrtAttrib.dwTab[1].GetItemNumber ( lLigInter, "MT_A_REG") > 0  then 
					dw_1.SetItem ( lCpt, "ID_TYP_DOC", 21 ) 		// SFR+Chèque à joindre	
					Continue
				else
					dw_1.SetItem ( lCpt, "ID_TYP_DOC", 20 ) 		// SFR			
					Continue
				end if	

			Case 254 // ID_GRP d'ORANGE
				if invTrtAttrib.dwTab[1].GetItemString ( lLigInter, "COD_MODE_REG") = "C" and & 
						invTrtAttrib.dwTab[1].GetItemNumber ( lLigInter, "MT_A_REG") > 0  then 
					dw_1.SetItem ( lCpt, "ID_TYP_DOC", 24 ) 		// Orange+Chèque à joindre	
					Continue
				else
					dw_1.SetItem ( lCpt, "ID_TYP_DOC", 23 ) 		// Orange
					Continue					
				end if
				
			Case else
				if invTrtAttrib.dwTab[1].GetItemString ( lLigInter, "COD_MODE_REG") = "C" and & 
						invTrtAttrib.dwTab[1].GetItemNumber ( lLigInter, "MT_A_REG") > 0  then 
					dw_1.SetItem ( lCpt, "ID_TYP_DOC", 27 ) 		// Distrib+Chèque à joindre	
					Continue					
				else
					dw_1.SetItem ( lCpt, "ID_TYP_DOC", 26 ) 		// Distrib
					Continue					
				end if				
		end choose*/
		// :[VDoc3573]
	Else
		// #4 [DCMP090023] L'algorithme de l'option 103 est le suivant
		// Si Option trouvée, avec Clé FORCAGE_ID_COUR_ASS paramétrée, et inter = A
		// Alors positionnement de la catégorie de courrier si le code courrier est l'un 
		// des codes courrier paramétré.
		// Sinon, utilisation du code de gestion du mot Clé "DEFAUT" existant.
		lDeb = 0
		F_RechDetPro ( lDeb, lFin, invTrtAttrib.dwNorm[4], invTrtAttrib.lTab[1], "-DP", 103) // Option 103
		if lDeb > 0 and Upper ( dw_1.GetItemString ( lCpt, "COD_INTER" ) ) = "A" Then // Inter = Assuré
			do while lDeb > 0 // On recherche une option det_pro 103 parmi celle trouvé avec la clé FORCAGE...
									// dans val_car.
				lDeb = invTrtAttrib.dwNorm[4].Find("VAL_CAR LIKE '%"+sKeyForcage+"%'", lDeb, lFin+1)
				
				// On lit la valeur de la clé FORCAGE... avec of_GetKeyValue, puis on découpe cette valeur
				// avec of_parsetoarray, afin de pouvoir effectuer la comparaison sur chacun des codes
				// courriers paramétrés.
				if lDeb > 0 Then 
					lnvString.of_parsetoarray( &
						lnvString.of_getkeyvalue( invTrtAttrib.dwNorm[4].object.val_car[lDeb], sKeyForcage, ";"), &
						"/", &
						sTabIdCour)
					
					// on compare les code courrier paramétré avec le code courrier présent sur l'inter.
					if upperbound(sTabIdCour) = 0 Then
						bIdCourOk = FALSE
					Else
						For lCpt2 = 1 to upperbound(sTabIdCour)
							bIdCourOk = ( sTabIdCour[lCpt2] = invTrtAttrib.dwTab[1].GetItemString ( lLigInter, "ID_COUR") )
							if bIdCourOk Then Exit
						Next 
					End If
					if bIdCourOk Then 
						Exit // Si courrier trouvé on sort, lDeb point sur la bonne option det_pro avec la
							  // catégorie de courrier.
					Else
						// On incrémente le lDeb de 1 car la ligne det_pro en cours a été traitée
						// et correspondait à un paramétrage FORCAGE..., mais le l'id_cour n'a
						// pas été trouvé.
						lDeb ++
					End If
				Else // Si pas de FORCAGE... défini, on sort, on passe à la version "DEFAUT"
					  // de l'option 103
					bIdCourOk = FALSE
				End If
			loop
			If bIdCourOk Then
				dw_1.SetItem ( lCpt, "ID_TYP_DOC", invTrtAttrib.dwNorm[4].object.id_code_num[lDeb] )
			End IF
		End If
		if Not bIdCourOk Then // Si pas de code courrier trouvé ci-dessus, on fait l'option 103 classique
			// #3 [DCMP080573] Si Option 103, et catégorie par défaut => forcage
			lDeb = 0
			lnvKey[1].iskeyname = "DEFAUT"
			lnvKey[1].iakeyvalue = "OUI"
			F_RechDetPro_withkey ( lDeb, invTrtAttrib.dwNorm[4], invTrtAttrib.lTab[1], "-DP", 103, lnvKey )
			if lDeb > 0 and upperbound(lnvKey)>0 Then
				If string(lnvKey[1].iakeyValue) = "OUI" Then
					dw_1.SetItem ( lCpt, "ID_TYP_DOC", invTrtAttrib.dwNorm[4].object.id_code_num[lDeb] )
				End IF
			End If
			// #3
		End If
	end if
	
	// [PM425-1]
	lIdIDB = invTrtAttrib.dwTab[1].GetItemNumber ( lLigInter, "ID_I_DB" ) 			
	sCodInter = invTrtAttrib.dwTab[1].GetItemString ( lLigInter, "COD_INTER" ) 			
	
	Choose Case True
		Case Not IsNull ( lIdIDB ) And sCodInter = "A"
			dw_1.SetItem ( lCpt, "ID_TYP_DOC", 13 )  // Assuré avec double banque

		Case Not IsNull ( lIdIDB ) And sCodInter = "B"
			dw_1.SetItem ( lCpt, "ID_TYP_DOC", 12 )  // Banque avec double assuré
			
	End Choose 
	// /[PM425-1]
	
//* #2 - FIN
Next

end subroutine

private subroutine wf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_ControlerGestion
//* Auteur			: MADM
//* Date				: 14/08/2006 14:21:37
//* Libellé			: Contrôle de gestion de la saisie
//* Commentaires	: 
//*
//* Arguments		: Aucun 
//*
//* Retourne		: Rien
//*					  	
//*
//*-----------------------------------------------------------------
//* MAJ	Le				Par	Description
//* #1	07/08/2008	PHG	[DCMP080573] Option 103 : Controle si 
//*								catégorie de courrier autorisée
// 			19/06/2014	FPI	[VDOC14696] Si DR, on ne tient pas compte de la 103
//*-----------------------------------------------------------------

String   sTypeCour, sIdCanal
Long     ltotligne, Lcpt, lDEb, lFin

ltotligne = dw_1.RowCount ()

invTrtAttrib.sTab[2] = "CONTINUER"

For lcpt = 1 to ltotligne

	// #1 [DCMP080573] Controle si catégorie de courrier autorisée, si Option 103
	F_RechDetPro ( lDeb, lFin, invTrtAttrib.dwNorm[4], invTrtAttrib.lTab[1], "-DP", 103 )
	
	// [VDOC14696]
	If Mid ( isAutresDroits, 9, 1 ) = "1" Then
		// Si membre du DR, on n'autorise que les natures de courriers DR
		Choose Case dw_1.object.id_typ_doc[lCpt]
			Case 5, 80, 81, 82, 83, 84, 85, 86
			Case Else
					invTrtAttrib.sTab[2] = "ARRETER5" 
						stMessage.svar[1] = 	dw_1.describe("Evaluate('LookupDisplay(COD_INTER)',"+string(lCpt)+")") + &
									" "+dw_1.object.nom[lCpt]
		End Choose
		
		lDeb=0 			// On enlève le contrôle de la DP 103
	End if
	// :[VDOC14696]
	
	if lDeb > 0 Then
		if invTrtAttrib.dwNorm[4].Find("ID_CODE_DP = 103 AND ID_TYP_CODE_DP = '-DP' AND " + &
												 "ID_PROD = "+ string(invTrtAttrib.lTab[1]) + " AND " +&
												 "ID_CODE_NUM = "+string(dw_1.object.id_typ_doc[lCpt]),&
												 lDeb, lFin+1) = 0 Then
		   invTrtAttrib.sTab[2] = "ARRETER4" // Si *NON* trouvé, on arrete
			stMessage.svar[1] = 	dw_1.describe("Evaluate('LookupDisplay(COD_INTER)',"+string(lCpt)+")") + &
										" "+dw_1.object.nom[lCpt]
			Exit
		End If
	End If
	// #1
	
	sIdCanal  = dw_1.GetItemString (lcpt , "ID_CANAL")
	sTypeCour = dw_1.GetItemString (lcpt , "TYPE_COUR")

	If sIdCanal = "CO" Then	Continue
	
	IF lTotLigne > 1 and sIdCanal = "MA" THEN
	   invTrtAttrib.sTab[2] = "ARRETER1"
		Exit
	END IF

	/* [PM159]
	CHOOSE CASE UPPER (sTypeCour)
	  CASE "CA"
	  
	   IF Not ( sIdCanal = "MA" And Mid (isAutresDroits, 12, 1) = "1" ) THEN
			invTrtAttrib.sTab[2] = "ARRETER2"
			Exit
		End If	  

	  CASE "CP" 
	   IF Not ( sIdCanal = "MA" And Mid (isAutresDroits, 12, 1) = "1" And Mid (isAutresDroits, 16, 1) = "1" ) Then
			invTrtAttrib.sTab[2] = "ARRETER3"
			Exit
		End If	

	END CHOOSE		
	*/

Next	

end subroutine

private function boolean wf_controler_canal (string ascas, long alrow, string asdata);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Choix_Regen_Courrier_simpa2::Wf_Controler_Canal		(PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 20/07/2011
//* Libellé			: [PM159]
//* Commentaires	: 
//*
//* Arguments		: String	 	asCas  (val)   "TOUT", "ROW"
//*					  Long		alRow	 (val)   le row à ctrler (si besoin de lecture d'une donnée)
//*					  String 	asData (val)	La nouvelle donnée 
//*
//* Retourne		: Boolean
//*
//*-----------------------------------------------------------------
//* MAJ     PAR      Date	    	Modification
//*
//*-----------------------------------------------------------------

Long lTot, lCpt, lDeb, lFin, lLigInter, lRow, lCptDeb, lCptFin
Boolean	bRet 
String sIdTypDoc, sCodInter, sIdCanal, sValCar, sCodInterParam, sIdTypDocParam, sAdrMail 
n_cst_string lnvPFCString

bRet = True


If asCas = "TOUT" Then
	lCptDeb = 1
	lCptFin = dw_1.RowCount()
End If

If asCas = "ROW" Then
	lCptDeb = alRow
	lCptFin = alRow
	sIdTypDoc = asData
End If

F_RechDetPro ( lDeb, lFin, invTrtAttrib.dwNorm[4], invTrtAttrib.lTab[1], "-DP", 173 )

For lCpt = lCptDeb To lCptFin
	
	// ITSM 81555 ajout du égal
	If lDeb <= 0 Then 
		dw_1.SetItem ( lCpt, "ID_CANAL", "CO" )
		Continue
	End If 

	sCodInter = dw_1.GetItemString ( lCpt , "COD_INTER" ) 

	lRow = invTrtAttrib.dwNorm[4].Find ( "VAL_CAR LIKE '%COD_INTER=" + sCodInter + "%'", lDeb, lFin )
	If lRow <=0 Then
		dw_1.SetItem ( lCpt, "ID_CANAL", "CO" )
		Continue
	End If

	sIdCanal  = dw_1.GetItemString ( lCpt, "ID_CANAL" ) 
	If asCas = "TOUT" Then
		sIdTypDoc = String ( dw_1.GetItemNumber ( lCpt, "ID_TYP_DOC" ))
	End If


	lLigInter = invTrtAttrib.dwTab[1].Find ( "COD_INTER = '" + sCodInter + "'", 1, invTrtAttrib.dwTab[1].RowCount() )
	sAdrMail = invTrtAttrib.dwTab[1].GetItemString ( lLigInter, "ADR_MAIL" ) 

	sValCar = invTrtAttrib.dwNorm[4].GetItemString ( lRow, "VAL_CAR" )
	sCodInterParam= lnvPFCString.of_getkeyvalue (invTrtAttrib.dwNorm[4].GetItemString ( lRow, "VAL_CAR" ), "COD_INTER", ";")
	sIdTypDocParam= lnvPFCString.of_getkeyvalue (invTrtAttrib.dwNorm[4].GetItemString ( lRow, "VAL_CAR" ), "ID_TYP_DOC", ";")

	// Si une adresse mail valide est présente.
	If NOT (Isnull (sAdrMail) OR Trim ( sAdrMail ) = "" ) Then
		If sCodInterParam = sCodInter And Pos ( sIdTypDocParam, "#" + sIdTypDoc + "#", 1 ) > 0 Then
			dw_1.SetItem ( lCpt, "ID_CANAL", "MA" ) 
		Else
			// Binome inter+id_typ_doc non autorisé pour le mode Mail, je reforce à COurrier.
			dw_1.SetItem ( lCpt, "ID_CANAL", "CO" ) 
		End If
	Else
		dw_1.SetItem ( lCpt, "ID_CANAL", "CO" ) 				
	End If

Next 
		
Return bRet

end function

event open;//*-----------------------------------------------------------------
//*
//* Objet			: W_Trt_Choix_Regen_Courrier_simpa2
//* Evenement 		: Open
//* Auteur			: Erick John Stark
//* Date				: 15/10/2001 14:58:03
//* Libellé			: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: 
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    04/05/2004  DCMP 04020 SVE
//* #2   MADM    01/08/2006  Projet DNTMAIL1/2
//* 		PHG	  31/10/2006  [DNTMAIL1-2] Deport de code dans
//*									n_cst_saisie_validation_sinistre
//* 										uf_populiser_DwGenerationcourrier
//*       JFF    20/07/2011  [PM159]
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* La structure de passage doit être armée de la manière suivante.  */
/*------------------------------------------------------------------*/
/* dwNorm[1] = Liste des types de documents.                        */
/* dwNorm[2] = Liste des courriers à recopier dans Dw_1.            */
/*                                                                  */
/* dwTab[1]  = Liste des Interlocuteurs. U_DataWindow_Detail        */
/*                                                                  */
/* sTab[1]   = Nom de l'application (SAVANE,SIMPA2,SINDI)           */
/* sTab[2]   = Armée en sortie de fenêtre par CONTINUER/ARRETER.    */
/*------------------------------------------------------------------*/
invTrtAttrib = Message.PowerObjectParm
DataWindowchild	dwChild, dwChild1, dwchildcanal
Long					lTotLigne, lCpt, lLigTot, lIdInter, lLigTrv, lTotLigInter, lCpt2, lTotCourrier
String 				sFiltre, sAltSuiviMail, sAdrMail

/*------------------------------------------------------------------*/
/* Positionnement des objets dans la fenêtre.                       */
/*------------------------------------------------------------------*/
This.Wf_PositionnerObjet ()

/*------------------------------------------------------------------*/
/* Droit à découper (voir u_gs_sp_sinistre::uf_GetAutorisation)     */
/*------------------------------------------------------------------*/
isAutresDroits = invTrtAttrib.sTab[2]


/*------------------------------------------------------------------*/
/* En fonction de l'application SAVANE, SIMPA2, SINDI les noms de   */
/* colonnes sont différents. Il faut donc armer une constante pour  */
/* que cette fenêtre puisse fonctionner dans tous les cas de        */
/* figure.                                                          */
/*------------------------------------------------------------------*/
Choose Case invTrtAttrib.sTab[1]
Case "SAVANE"
	isZn_IdInter	= "ID_I"
	isZn_CodInter	= "COD_I"
Case "SIMPA2"
	isZn_IdInter	= "ID_I"
	isZn_CodInter	= "COD_INTER"
	isZn_IdCanal   = "ID_CANAL"
	dw_1.DataObject = "d_stk_choix_regen_courrier_sim2"
End Choose




//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret
ll_ret = Dw_1.Reset ()
//Fin Migration PB8-WYNIWYG-03/2006 FM

This.Title = "Préparation des courriers."
dw_1.Modify ( "p_attention.filename = 'K:\PB4OBJ\BMP\EXCL2.BMP'" )
ibFermerFenetre = FALSE

/*------------------------------------------------------------------*/
/* Armement des DDDW.                                               */
/*------------------------------------------------------------------*/
ll_ret = dw_1.GetChild ( "ID_TYP_DOC", dwChild )	//dddw_spb_code
//Migration PB8-WYNIWYG-03/2006 FM
ll_ret = dwChild.SetTransObject(SQLCA)
//Fin Migration PB8-WYNIWYG-03/2006 FM
ll_ret = invTrtAttrib.dwNorm[1].ShareData ( dwChild )

ll_ret = dw_1.GetChild ( "COD_INTER", ( dwChild ) )	//dddw_sp_code_car
//Migration PB8-WYNIWYG-03/2006 FM
ll_ret = dwChild.SetTransObject(SQLCA)
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*-----------------------------------------------------------------------*/
/* #2 : 01/08/206 MADM																	 */	
/* Armement de la DDDW des médias de sortie à partir de dddw_sp_code_car.*/
/*-----------------------------------------------------------------------*/
ll_ret = dw_1.GetChild ( "ID_CANAL", ( dwchildcanal ) )
ll_ret = dwchildcanal.SetTransObject(SQLCA)
dwchildcanal.Retrieve ( "-MS" )
//Fin MADM


Choose Case invTrtAttrib.sTab[1]
	Case "SAVANE"
		invTrtAttrib.dwTab[1].GetChild ( "COD_I", ( dwChild1 ) )
	Case "SIMPA2"
		ll_ret = invTrtAttrib.dwTab[1].GetChild ( "COD_INTER", ( dwChild1 ) )
		//ll_ret = dw_1.GetChild ( "ID_CANAL", ( dwchildcanal ) )
				
End Choose


ll_ret = dwChild1.ShareData ( dwChild )


/*------------------------------------------------------------------*/
/* Recopie des lignes dans Dw_1.                                    */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//ll_ret = Dw_1.Reset ()
//Fin Migration PB8-WYNIWYG-03/2006 FM
lTotLigne = invTrtAttrib.dwNorm[2].RowCount ()
invTrtAttrib.dwNorm[2].RowsCopy ( 1, lTotLigne, Primary!, dw_1, 1, Primary! )

/*------------------------------------------------------------------*/
/* Affectation des types de documents.                              */
/*------------------------------------------------------------------*/
This.wf_Affecter_TypDoc ()

// [PM159]
This.Wf_Controler_Canal ( "TOUT", 0, "" ) 

/*------------------------------------------------------------------*/
/* On positionne le focus sur le bouton Continuer.                  */
/*------------------------------------------------------------------*/
cb_Continuer.SetFocus ()

end event

on w_trt_choix_regen_courrier_simpa2.create
this.cb_continuer=create cb_continuer
this.cb_arreter=create cb_arreter
this.dw_1=create dw_1
this.Control[]={this.cb_continuer,&
this.cb_arreter,&
this.dw_1}
end on

on w_trt_choix_regen_courrier_simpa2.destroy
destroy(this.cb_continuer)
destroy(this.cb_arreter)
destroy(this.dw_1)
end on

type cb_continuer from commandbutton within w_trt_choix_regen_courrier_simpa2
integer x = 910
integer y = 44
integer width = 306
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Continuer"
boolean default = true
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: W_Trt_Choix_Regen_Courrier_simpa2::Cb_Continuer
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 15/10/2001 14:58:03
//* Libellé			: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: 
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//* #1   DGA   01/02/2002	Gestion du WORD
//* #1   MADM  30/08/2006	Projet DNTMAIL1/2
//* #2	JCA	28/09/2007	DCMP 40324 - Gestion edition pour le DSC
//* #3	PHG   07/08/2008	[DCMP080573] - Option 103, Msg erreur si pas autorisé
//*      JFF   18/07/2010  [PM159]
//			FPI	20/06/2014	 [VDOC14696]
//*-----------------------------------------------------------------

Long lTotLig, lCpt, lCpt1
String sWord
N_Cst_Word	nvWord

SetPointer ( HourGlass! )

/*--------------------------------------------------------------------*/
/* #1 : MADM le 30/08/06  Appel de la fonction wf_controlergestion () */
/*--------------------------------------------------------------------*/
Parent.wf_controlergestion ()

//MADM 14/08/2006 Projet DNTMAIL1/2

/*--------------------------------------------------------------------*/
/* #1 : MADM le 30/08/06  En fonction du cas dans lequel on se trouve */
/*      On affiche le message correspondant                           */ 
/*--------------------------------------------------------------------*/
If Pos ( invTrtAttrib.sTab[2], "ARRETER", 1 ) >0 Then 

	Choose Case invTrtAttrib.sTab[2]
		Case "ARRETER1"
		
//			 stMessage.sCode = "GENE138"			// [PM159]				
			 invTrtAttrib.sTab[2] = "CONTINUER" // [PM159]				
			
		Case "ARRETER2"
//			stMessage.sCode = "GENE139"			// [PM159]				
			 invTrtAttrib.sTab[2] = "CONTINUER" // [PM159]				
		Case "ARRETER3"			
//			stMessage.sCode = "GENE140"			// [PM159]				
			 invTrtAttrib.sTab[2] = "CONTINUER" // [PM159]		
			 
		Case "ARRETER4"						// #3 [DCMP080573]	
			stMessage.sCode = "GENE141"
		Case "ARRETER5"						// [VDOC14696]
			stMessage.sCode = "GENE142"
			
	End Choose

	// [PM159]				
	If invTrtAttrib.sTab[2] <> "CONTINUER" Then
		stMessage.sTitre		= "INFORMATION MAIL"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= False
		stMessage.Bouton		= Ok!
		F_Message ( stMessage )
		
		invTrtAttrib.sTab[2] = "ARRETER"	
	
		Return
	End If
	// [PM159]				
End If 

/*------------------------------------------------------------------*/
/* On recopie la DataWindow Dw_1 dans la structure de passage. On   */
/* positionne l'option qui indique que l'on peut continuer le       */
/* traitement.                                                      */
/*------------------------------------------------------------------*/
invTrtAttrib.dwNorm[2].Reset ()
lTotLig = dw_1.RowCount ()

//* #2 DCMP 40324
//dw_1.saveas("c:\temp\test\regencourrier.xls", EXCEL!, true)
//
//dw_1.setfilter( "alt_editer = 'O'" )
//dw_1.filter()
//
//dw_1.saveas("c:\temp\regencourrier_filtrer.xls", EXCEL!, true)
//
dw_1.RowsCopy ( 1, lTotLig, Primary!, invTrtAttrib.dwNorm[2], 1, Primary! )
//
//invTrtAttrib.dwNorm[2].saveas("c:\temp\regencourrier_pass.xls", EXCEL!, true)
//* FIN - #2

ibFermerFenetre = TRUE

invTrtAttrib.sTab[2] = "CONTINUER"
		
//F_SetVersionWord ( nvWord, TRUE )																	// #1  MISE EN COMMENTAIRE DE CES LIGNES
//sWord = ProfileString ( stGLB.sFichierIni, "EDITION", "REP_WORD", "" )				// #1  CF fonction 
//If	nvWord.uf_WordOuvert () = 0	Then Run ( sWord, Minimized! )						// #1  w_tm_sa_sinistre::Wf_Script_Client_Focus 
//
//For	lCpt = 1 To 5000																					// #1
//		Yield ()																								// #1
//		Yield ()																								// #1
//Next																										// #1
//
//F_SetVersionWord ( nvWord, FALSE )																// #1

// On cale l'appli bien à droite pour laisser le word à gauche
// afin d'avoir le bouton valider visible.

// [POSITION_SIMPA2]
w_mdi_sp.x = 3500 	// ... Coordonnées de l'application
w_mdi_sp.y = 600

CloseWithReturn ( Parent, invTrtAttrib )

end event

type cb_arreter from commandbutton within w_trt_choix_regen_courrier_simpa2
integer x = 567
integer y = 44
integer width = 306
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Arrêter"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: W_Trt_Choix_Regen_Courrier::Cb_Arreter
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 15/10/2001 14:58:03
//* Libellé			: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: 
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------


SetPointer ( HourGlass! )

ibFermerFenetre = TRUE

invTrtAttrib.sTab[2] = "ARRETER"

CloseWithReturn ( Parent, invTrtAttrib )


end on

type dw_1 from datawindow within w_trt_choix_regen_courrier_simpa2
integer x = 23
integer y = 44
integer width = 494
integer height = 360
integer taborder = 10
string dataobject = "d_stk_choix_regen_courrier"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event itemchanged;//*-----------------------------------------------------------------
//* Objet 			: w_trt_choix_regen_courrier_simpa2::dw_1
//* Evenement 		: ItemChanged
//* Auteur			: JCA
//* Date				: 19/09/2007
//* Libellé			: 
//* Commentaires	: DCMP 40324
//*-----------------------------------------------------------------
//		FPI	18/10/2011	[ITSM83504] Interdire type de courrier retour DSC si opérateur pas du DSC
//    JFF   11/06/2019  [PM425-1]
//*-----------------------------------------------------------------

integer iAction

iAction = 0

choose case dwo.name 
	case "alt_editer"
		if mid ( isAutresDroits, 9, 1 ) <> "1" then
			iAction = 1
		end if		

	Case "id_typ_doc"
	// [PM159]
		Parent.Wf_Controler_Canal ( "ROW", row, data ) 

		// [PM425-1]
		// [ITSM83504] 
		Choose Case data
			Case "5", "80", "81", "82", "83", "84", "85", "86", "87", "88"
				if mid ( isAutresDroits, 9, 1 ) <> "1" and data="5" then
					iAction = 1
				end if		
		End Choose

		Choose Case dw_1.GetItemNumber ( row, "ID_TYP_DOC" ) 
			Case 12, 13 , 87, 88
				iAction = 1
		End Choose 
		// /[PM425-1]

end choose




return iAction
end event

event itemerror;
//*-----------------------------------------------------------------
//* Objet 			: w_trt_choix_regen_courrier_simpa2::dw_1
//* Evenement 		: ItemChanged
//* Auteur			: JCA
//* Date				: 19/09/2007
//* Libellé			: 
//* Commentaires	: DCMP 40324
//*-----------------------------------------------------------------
//		FPI	18/10/2011	[ITSM83504] Interdire type de courrier retour DSC si opérateur pas du DSC
//   JFF   11/06/2019 [PM425-1]
//*-----------------------------------------------------------------

integer iAction

iAction = 0
stMessage.sTitre		= "Gestion des éditions - SIMPA2"
stMessage.Icon			= Information!
stMessage.berreurg	= false

choose case dwo.name
	case "alt_editer"
		stMessage.sCode	= "GENE158"
		f_message ( stMessage )
		iAction = 3
	
	// 	[ITSM83504]
	case "id_typ_doc"
		stMessage.sCode	= "GENE003"
		stMessage.sVar[1] = "type de courrier"
		f_message ( stMessage )
		iAction = 3

		// [PM425-1]
		This.SetItem ( row, "ID_TYP_DOC", This.GetItemNumber ( row, "ID_TYP_DOC" ) ) 			
		// [PM425-1]

	
end choose

return iAction
end event

