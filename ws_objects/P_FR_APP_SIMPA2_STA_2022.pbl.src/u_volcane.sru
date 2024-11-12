$PBExportHeader$u_volcane.sru
$PBExportComments$--- } Génération du fichier volcane
forward
global type u_volcane from datawindow
end type
end forward

global type u_volcane from datawindow
integer width = 494
integer height = 360
integer taborder = 1
string dataobject = "d_volcane"
boolean livescroll = true
end type
global u_volcane u_volcane

forward prototypes
public function long uf_ecrirefichier (string asnomfic, s_glb astglb, date addtedeb, date addtefin, string asseparateur)
public function long uf_volcane (s_glb astglb, transaction atrtrans, date addtedeb, date addtefin)
public function long uf_nouveaufichier (ref string asnomfic, s_glb astglb, date addtefic)
end prototypes

public function long uf_ecrirefichier (string asnomfic, s_glb astglb, date addtedeb, date addtefin, string asseparateur);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Volcane::Uf_EcrireFichier
//* Auteur			: DBI
//* Date				: 22/09/1997 16:09:31
//* Libellé			: Lit la DataWindow Dw_Volcanes Pour Générer le Fichier Volcane
//* Commentaires	: Si un fichier du même nom existait, il est écrasé
//*
//* Arguments		: 	String			asNomFic - Nom Complet du fichier Volcane
//*						s_GLB				astGLB	- Structure globale de l'application
//*						adDteDeb			Date	  	- Date de début de traitement
//*						adDteFin			Date	  	- Date de fin de traitement
//*						asSeparateur	String	- Séparateur de champ du fichier
//*						
//* Retourne		: 	Long 		1 si Ok , Valeur négative si Pb
//*										
//*
//*-----------------------------------------------------------------
//* #1 JCA 118/05/2006 DCMP 60291 passage d'id_cie de 2 à 3 caractères
//* #2 JCA 20/11/2007  DCMP 70864 Ajout du code produit sur 5 caractères
//		 FPI 11/06/2012  [VDoc7448] Passage du lib_police à 60 caractères
//     JFF 25/03/2013  [PC801_LOT1_V2]
//     JFF 07/05/2013  [PC938_ORANGE_V3_V10]
//     JFF 07/10/2013  [DT044-1_V5]
//     JFF 12/02/2016  [PI062]
//     JFF 01/06/2018  [PC151425-1]
//     JFF 04/10/2019  [PM462-1][V3]
//     JFF 12/05/2020  [PI085]
//     JFF 21/04/2021  [PC202553] SELECTRA
//*-----------------------------------------------------------------

String		sCodAppli		// Code de l'application
String		sIdSin			// Numéro de sinistre
String		sIdI				// Suite demande Denis, le 09/03/1999, ajouter Interlocuteru réglé
String		sIdReg			// Numéro de règlement
String		sIdSeq			// Suite DCMP990009, ajout d'une zone ID_SEQ toujours à 0 pour SIMPA2, 
									// et ne servant à rien. Cette zone ne sert en faite que pour l'appli PEGED
									// Mais cela évite de traiter plusieurs format de fichier
String		sIdEnreg			// 1 si réglement de sinistre, 2 si remboursement reçu
String		sIdProd			// Numéro de produit du sinistre
String		sIdEts			// Id_ets du sinistre
String		sIdAdh			// Numéro d'adhésion ou numéro de carte
String		sNosDoss			// Numéro de sous dossier si Adhésion Mini 0 sinon
String		sIdCie			// Numéro de compagnie
String		sCodContrat		// Numéro de contrat ou de police
String		sCodReg			// Mode de règlement VA : Virt Auto, VM: Virt Manu, C: Chèque
String		sCodDest			// A : Assuré, B : Banque ...
String		sMtSin			// Montant du règlement
String		sDteReg			// Date de validation du règlement
String		sRadical			// Radical SGCC associé au dossier ou chaine vide si inconnu
String		sEnr				// Enregistrement à écrire dans le fichier
String		sDteDeb			// Date de début de traitement au format Volcane yyyymmdd
String		sDteFin			// Date de fin de traitement au format Volcane yyyymmdd
String		sDteJour			// Date du jour au format Volcane yyyymmdd
String		sSigne			// Signe positif ou négatif du montant
String		sIdPdr			// Suite DCMP990042, ajout d'une zone ID_PDR toujours à 001 pour SIMPA2, 
									// et ne servant à rien. Cette zone ne sert en faite que pour l'appli PEGED
									// Mais cela évite de traiter plusieurs format de fichier
String		sIdFour

String		SIdProdSin			// Numéro de produit sur 5 caractères // #2
String		sChaine, sFiller1

Decimal{2}	dcMtSin			// Montant du règlement

Integer		iFic				// Fichier Dans lequel on va écrire
Integer		iRet				// Utilisé Pour Test FileWrite

Long			lCpt				// Compteur de boucle
Long			lRet = 1			// Valeur de retour de la fonction
Long			lNbLig			// Nombre de lignes de Dw_1

Boolean 		bPI062_VOLC_MENS, bPI085

//--------------------------------------------------------------------
// Ouverture du fichier Volcane en Replace Exclusif
//--------------------------------------------------------------------

bPI062_VOLC_MENS = F_CLE_A_TRUE ( "PI062_VOLC_MENS" )
// bPC151425_1		  = F_CLE_A_TRUE ( "PC151425-1" )
// bPM462_1			  = F_CLE_A_TRUE ( "PM462-1" ) 
bPI085			  = F_CLE_A_TRUE ( "PI085" ) 


sCodAppli		=	"BSP2"			// Suite demande Sylvie

iFic	=	FileOpen ( asNomFic, LineMode!, Write!, LockReadWrite!, Replace! )

If iFic > 0 Then

	//--------------------------------------------------------------------
	// Le premier enregistrement du fichier doit contenir les dates de 
	// début de traitement, de fin de traitement et la date du jour au format Volcane
	//--------------------------------------------------------------------

	sDteDeb	=	String ( Year ( adDteDeb ) ) 						+ &
				Right  ( "0" + String ( Month ( adDteDeb ) ), 2 )	+ &
				Right  ( "0" + String ( Day   ( adDteDeb ) ), 2 )

	sDteFin	=	String ( Year ( adDteFin ) ) 						+ &
				Right  ( "0" + String ( Month ( adDteFin ) ), 2 )	+ &
				Right  ( "0" + String ( Day   ( adDteFin ) ), 2 ) 	

	sDteJour=	String ( Year ( Today () ) ) 						+ &
				Right  ( "0" + String ( Month ( Today () ) ), 2 )	+ &
				Right  ( "0" + String ( Day   ( Today () ) ), 2 ) 	


	//--------------------------------------------------------------------
	// MODIF JFF le 17/02/99 : Suite au DCMP990009 et DCMP 990042, et suite
	// à la demande de Sylvie, ce jour, je rajoute 5 espace sur le premier
	// enregistrement afin que les colonnes ne se chevauchent pas. je passe
	// donc de 86 à 91 la valeur de 'SPACE'.
	// MODIF JFF le 09/03/99 : Suite modif demandée par denis, on passe de
	// 91 à 95 (id_i + 2 sur id_seq)
   // MODIF JFF le 10/03/05 : je passe de 95 à 96 pour gèrer les sinistres 
	// sur 7 Chiffres au lieu de 6
   // MODIF JFF le 21/06/05 : Ajout 3 car en fin pour gestion ID_Four
	// #1 Ajout 1 espace : Space ( 97 )
	//--------------------------------------------------------------------

	// [PI062] +3
	// F_CLE_A_TRUE ( "PI062_VOLC_MENS" )
	If bPI062_VOLC_MENS Then
		sEnr	=	sCodAppli + Space ( 100 ) + sDteDeb		+	sDteFin		+ sDteJour + Space ( 8 ) // #2
	Else
		sEnr	=	sCodAppli + Space ( 97 ) + sDteDeb		+	sDteFin		+ sDteJour + Space ( 8 ) // #2
	End If
	
	iRet	=	FileWrite ( iFic, sEnr )
	If iRet < 0 Then

		lRet	=	-3 		// Erreur Ecriture Enregistrement
	End IF

	//--------------------------------------------------------------------
	// Traitement des écritures
	//--------------------------------------------------------------------
	If lRet > 0 Then

	 lNbLig	=	This.RowCount ()
	 For lCpt	=	1 To lNbLig

		//--------------------------------------------------------------------
		// Chargement de toutes les variables du fichier avec une longueur fixe
		//--------------------------------------------------------------------

		// [PI062] +3
		// F_CLE_A_TRUE ( "PI062_VOLC_MENS" )
		If bPI062_VOLC_MENS Then
			sIdSin			=	String ( This.GetItemNumber ( lCpt, "ID_SIN" ), "0000000000" )
		Else
			sIdSin			=	String ( This.GetItemNumber ( lCpt, "ID_SIN" ), "0000000" )
		End If
		
		sIdI				=  String ( This.GetItemNumber ( lCpt, "ID_I" ), "00" )
		sIdReg			=	String ( This.GetItemNumber ( lCpt, "ID_REG" ), "00"     )
		sIdSeq			=  "0001"
		sIdEnreg			=	This.GetItemString ( lCpt, "ID_ENREG" )

		sIdProd			=	This.GetItemString ( lCpt, "ID_PROD" )
		sIdEts			=	String ( This.GetItemNumber ( lCpt, "ID_ETS" ) , "00000" )
		sIdAdh			=	Right  ( "0000000000000000000" + This.GetItemString ( lCpt, "ID_ADH" ), 19 ) 
		sNosDoss			=	String ( This.GetItemNumber ( lCpt, "NO_SDOSS" ) )

		// #1
		//sIdCie			=	String ( This.GetItemNumber ( lCpt, "ID_CIE" ) , "00"		)
		sIdCie			=	String ( This.GetItemNumber ( lCpt, "ID_CIE" ) , "000"	)
		// #1 FIN
		sCodContrat		=	Left   ( This.GetItemString ( lCpt, "COD_CONTRAT" ) 	+ Space ( 60 ), 60 )  //[VDoc7448]
		sCodReg			=	Left   ( This.GetItemString ( lCpt, "COD_REG" ) 		+ Space ( 2 ), 2 )
		sCodDest			=	This.GetItemString ( lCpt, "COD_DEST" )
		sDteReg			=	This.GetItemString ( lCpt, "DTE_REG" )
		sRadical			=	String ( This.GetItemNumber ( lCpt, "ID_RADICAL" ), "000" )

		dcMtSin			=	This.GetItemNumber ( lCpt, "MT_SIN" )

		// Modif DBI le 16/03/1999
		// Positionnement de l'id_seq = 0002 si il s'agit du montant négatif du RI
		// sinon doublon dans le chargement volcanes

		If ( sIdEnreg = '4' ) And ( dcMtSin < 0 ) Then

			sIdSeq			=  "0002"
		Else

			sIdSeq			=  "0001"
		End If

		If dcMtSin >= 0 Then	

			sSigne = "0"
		Else

			sSigne	= "-"			
			dcMtSin  = dcMtSin * -1
		End If


		// le montant du sinistre est multiplié par 100 pour supprimer la virgule

		sMtSin			=	sSigne + Right ( "00000000000"							+ &
								String ( dcMtSin*100,								 		+ &
										  "###########0" ), 12 ) 

		sIdPdr 			= "001"

		sIdFour			=  This.GetItemString ( lCpt, "ID_FOUR" )
		
		// [PI085]
		If bPI085 Then
			SIdProdSin = String ( This.GetItemNumber ( lCpt, "id_prodsin" ), "0000000"  ) // #2
		Else 
			SIdProdSin = String ( This.GetItemNumber ( lCpt, "id_prodsin" ), "00000"  ) // #2
		End If 
		
		Choose Case TRUE
			Case  IsNull ( sIdFour ) Or Len ( sIdFour ) <> 3 Or sIdFour = "-1"
				sIdFour = Fill ( " ", 3 )
		End Choose 

		//--------------------------------------------------------------------
		// Le radical est positionné à "   " s'il n'est pas connu : exemple PE
		//--------------------------------------------------------------------

		If isNull ( sRadical ) Or Trim ( sRadical ) = "" Then sRadical = "000"

		// [PC801_LOT1_V2]
		sFiller1 = Space ( 24 )

		// [PC151425-1]
		// "1" = RN  // Remboursement de Franchise
		If sIdEnreg = "1" Then
			sChaine = Space ( 5 )  // 10 max pour la PS
			SQLCA.PS_S_REMB_RNFR ( long ( sIdSin) , Long ( sIdReg ) , sChaine ) 
			If IsNull ( sChaine ) Or Trim ( sChaine ) = "" Then sChaine = Space ( 5 )
			sFiller1 = sChaine + Right ( sFiller1, Len ( sFiller1 ) - 5 )
		End IF

		// [PC801_LOT1_V2]
		// "2" = RM  // Franchise Auchan
		If sIdEnreg = "2" Then
			sChaine = Space ( 5 )  // 10 max pour la PS
			SQLCA.PS_S_RMFR ( long ( sIdSin) , Long ( sIdReg ) , sChaine ) 
			If IsNull ( sChaine ) Or Trim ( sChaine ) = "" Then sChaine = Space ( 5 )
			sFiller1 = sChaine + Right ( sFiller1, Len ( sFiller1 ) - 5 )
		End If
		// :[PC801_LOT1_V2]		


		// [PC938_ORANGE_V3_V10]
		IF sFiller1 = Space ( 24 ) Then
			// "2" = RM, "3" = RP  Caution Orange V3
			Choose Case sIdEnreg 
				Case "2", "3"
				sChaine = Space ( 50 )  // 10 max pour la PS
				SQLCA.PS_S_RMRP_CAUTION ( long ( sIdSin) , Long ( sIdReg ), sIdEnreg, sChaine ) 
				If IsNull ( sChaine ) Or Trim ( sChaine ) = "" Then sChaine = ""
				sFiller1 = Left ( sChaine + Space ( 24 ), 24 )
			End Choose 
		End If			
		
		IF sFiller1 = Space ( 24 ) Then
			// "1" = RN, Frais spéciaux Orange V3
			Choose Case sIdEnreg 
				Case "1"
					sChaine = Space ( 50 )  // 10 max pour la PS
					SQLCA.PS_S_RN_FRAIS_SPECIAUX ( long ( sIdSin) , Long ( sIdReg ), sIdEnreg, sChaine ) 
					If IsNull ( sChaine ) Or Trim ( sChaine ) = "" Then sChaine = ""
					sFiller1 = Left ( sChaine + Space ( 24 ), 24 )
			End Choose 
		End If			
		// :[PC938_ORANGE_V3_V10]		

		// [DT044-1_V5]
		IF sFiller1 = Space ( 24 ) Then
			sChaine = Space ( 50 )  // 10 max pour la PS
			SQLCA.PS_S_RN_FM_SPECIAUX_SANS_RAPPROCHEMENT ( long ( sIdSin) , Long ( sIdReg ), sIdEnreg, sCodReg, sChaine ) 
			If IsNull ( sChaine ) Or Trim ( sChaine ) = "" Then sChaine = ""
			sFiller1 = Left ( sChaine + Space ( 24 ), 24 )
		End If
		// :[DT044-1_V5]
		
		// DT386_COST_CENTER Axa Buy Back Filler de 6 à 9 (4 position)
		sChaine = Left ( sFiller1 + Space (24), 24 )
		SQLCA.PS_S_RN_AVEC_COST_CENTER ( long ( sIdSin) , Long ( sIdReg ), sIdEnreg, sCodReg, sChaine ) 
		If IsNull ( sChaine ) Or Trim ( sChaine ) = "" Then sChaine = ""
		sFiller1 = Left ( sChaine + Space ( 24 ), 24 )
	
		
		// [PM462-1][V3]
/*
		If bPM462_1 Then
			// Pour les FM/RM et FM/RP particulier lié à la franchise on passe FM à Sylvie (même si nous nous avons C)
			sChaine = sCodReg
			SQLCA.PS_S_FM_ALD_C_CAS_PART ( long ( sIdSin) , Long ( sIdReg ) , sChaine ) 
			sCodReg = Left ( sChaine + Space ( 2 ), 2 )

			sChaine = sIdFour
			SQLCA.PS_S_RETROUVER_ID_FOURN_FM_C_CAS_PART ( long ( sIdSin) , Long ( sIdReg ) , sChaine ) 
			sIdFour = Left ( sChaine + Space ( 3 ), 3 )
			
			IF sFiller1 = Space ( 24 ) Then
				// "3" = RP  // Remboursement de Franchise Site Choix Mobile
				If sIdEnreg = "3" Then
					sChaine = Space ( 5 )  // 10 max pour la PS
					SQLCA.PS_S_RPFR ( long ( sIdSin) , Long ( sIdReg ) , sChaine ) 
					If IsNull ( sChaine ) Or Trim ( sChaine ) = "" Then sChaine = Space ( 5 )
					sFiller1 = sChaine + Right ( sFiller1, Len ( sFiller1 ) - 5 )
				End If
			End IF 
		End If
*/

		sEnr			=	sCodAppli			+ asSeparateur + &
							sIdSin				+ asSeparateur + &
							sIdI					+ asSeparateur + &
							sIdReg				+ asSeparateur + &
							sIdSeq				+ asSeparateur + &
							sIdEnreg				+ asSeparateur + &		
							sIdProd				+ asSeparateur + &		
							sIdEts				+ asSeparateur + &			
							sIdAdh				+ asSeparateur + &			
							sNosDoss				+ asSeparateur + &		
							sIdCie				+ asSeparateur + &			
							sCodContrat			+ asSeparateur + &	
							sCodReg				+ asSeparateur + &			
							sCodDest				+ asSeparateur + &		
							sMtSin				+ asSeparateur + &			
							sDteReg				+ asSeparateur + &			
							sRadical				+ asSeparateur + &
							sIdPdr				+ asSeparateur + &		
							sFiller1 			+ asSeparateur + &		
							sIdFour				+ asSeparateur + &
							SIdProdSin

		iRet	=	FileWrite ( iFic, sEnr )
		If iRet < 0 Then

			lRet	=	-3 		// Erreur Ecriture Enregistrement
			Exit
		End IF
	 Next
	End If
Else

	lRet	=	-2				// Erreur Ouverture Fichier Volcane
End If

iRet 	=	FileClose ( iFic )

If iRet < 0 And lRet > 0 Then

	lRet	= -4		// Erreur à la fermeture du fichier
End If

Return lRet
end function

public function long uf_volcane (s_glb astglb, transaction atrtrans, date addtedeb, date addtefin);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Volcane::Uf_Volcane
//* Auteur			: DBI
//* Date			: 23/09/1997 16:09:31
//* Libellé		: Génération automatique du fichier Volcane
//* Commentaires	: Enchaine toutes les fonctions nécessaires pour générer le fichier
//*					  La procédure PS_S01_VOLCANE doit être compilée sur la base de donnée
//* Arguments		: 	s_GLB			astGLB	- Structure globale de l'application
//*						atrTrans		Transaction	- Objet de transaction
//*						adDteDeb		Date	- Date de début de traitement
//*						adDteFin		Date	- Date de fin de traitement
//*						
//* Retourne		: 	Long 		Nombre de lignes trouvées
//*						ou nombre négatif si erreur
//*						-1	 Entrée Rep_Volcane inexistante dans fichier Ini
//*						-2	 Impossible d'ouvrir le fichier Volcane
//*						-3	 Erreur lors de l'écriture d'un enregistrement
//*						-4	 Erreur à la fermeture du fichier Volcane
//*										
//*
//*-----------------------------------------------------------------
//*       JFF   06/10/2014 [PM266]
//		  FPI	  29/10/2014 [PI056]
//*-----------------------------------------------------------------

String			sNomFic		// Nom du fichier Volcane à Générer

Long			lRet = 1	// Valeur de retour des fonctions		
Long			lNbLig 		// Nombre de lignes du retrieve

SetPointer ( HourGlass! )

//*-----------------------------------------------------------------
//* Détermination du nom du fichier à générer
//*-----------------------------------------------------------------

lRet = Uf_NouveauFichier ( sNomFic, astGLB, adDteFin )



If lRet > 0 Then


//*-----------------------------------------------------------------
//* Chargement des enregistrements
//*-----------------------------------------------------------------

	This.SetTransObject 		( atrTrans )
	
	// [PM266]
	/*If F_CLE_A_TRUE ( "PM266" ) Then
		lNbLig	=	This.Retrieve 	( adDteDeb, adDteFin, "EXCLU_ASSUREUR" )
	Else
		lNbLig	=	This.Retrieve 	( adDteDeb, adDteFin, "TOUT_ASSUREUR" )
	End If
*/
	// [PI056]
	If F_CLE_A_TRUE ( "PM266" ) Then
		lNbLig	=	This.Retrieve 	( datetime(adDteDeb), datetime(adDteFin), "EXCLU_ASSUREUR" )
	Else
		lNbLig	=	This.Retrieve 	( datetime(adDteDeb), datetime(adDteFin), "TOUT_ASSUREUR" )
	End If


//*-----------------------------------------------------------------
//* Génération du fichier
//*-----------------------------------------------------------------

	lRet = Uf_EcrireFichier ( sNomFic, astGLB, adDteDeb, adDteFin, "" )
End If

If lRet > 0 Then lRet	 = lNbLig

SetPointer ( Arrow! )

Return ( lRet )
end function

public function long uf_nouveaufichier (ref string asnomfic, s_glb astglb, date addtefic);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Volcane::Uf_FichierNouveau
//* Auteur			: DBI
//* Date			: 22/09/1997 16:09:31
//* Libellé		: Crée un nouveau fichier Volcane au format de transfert
//* Commentaires	: Le nom du fichier Volcane se compose du répertoire associé
//* 				  à l'entrée REP_VOLCANE du  fichier Ini de l'appli suivi de
//*
//* 					Cod_Appli									-	Char (4)
//* 					Compteur Séquentiel au sein appli		-	Char (2)
//*						.
//*						Jour en cours sur 2 caractères			-  	Char (2)
//*						Mois en lettre 							-	Char (1)
//*
//*						suivant le principe suivant :
//*
//*						A	Janvier
//*						B	Février
//*						C	Mars
//*						D	Avril
//*						E	Mai
//*						F	Juin
//*						G	Juillet
//*						H	Aout
//*						I	Septembre
//*						J	Octobre
//*						K	Novembre
//*						L	Décembre
//*
//* Arguments		: 	s_GLB			astGLB	- Structure globale de l'application
//*						REF String		asNomFic - Nom Complet du fichier Volcane
//*						Date 			adDteFic - Date de référence pour la génération du fichier 
//*										( en général date de fin de traitement )
//* Retourne		: 	Long 		1 si Ok , Valeur négative si Pb
//*										
//*
//*-----------------------------------------------------------------

String		sExtension 	// Extension du fichier Volcane
String		sRepVolcane	// Nom du répertoire pour la génération du fichier 
String		sTabMois[12]	// Liste des mois en lettre

Long		lRet 	= 1			// Valeur de retour de la fonction

sTabMois[]			= { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L" }
sRepVolcane 		= ProfileString ( astGlb.sFichierIni, "APPLICATION", "REP_VOLCANE", "" )

If sRepVolcane		<>	"" Then

	sExtension		=	"." + String ( Day ( adDteFic ), "00" ) + sTabMois [ Month ( adDteFic ) ]
	asNomFic		= 	sRepVolcane + astGLB.sCodAppli + sExtension
Else

	lRet 		=	-1		// Rep_Volcane incorrect
End If

Return lRet
end function

on u_volcane.create
end on

on u_volcane.destroy
end on

