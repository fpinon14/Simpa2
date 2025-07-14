$PBExportHeader$u_gs_sp_rel_anc.sru
$PBExportComments$---} Objet pour les Relances et le Soldage.
forward
global type u_gs_sp_rel_anc from nonvisualobject
end type
end forward

global type u_gs_sp_rel_anc from nonvisualobject
end type
global u_gs_sp_rel_anc u_gs_sp_rel_anc

type variables
Protected:

u_DataWindow		iDwProduit
u_DataWindow_Accueil	iDw1
u_DataWindow		iDwTailleLot
u_DataWindow		iDwSaisieSin
DataWindow		iDwParaProd
DataWindow		iDwPolice
Datawindow		iDwCivilite
Datawindow		idw_BoiteArchive
Datawindow		idw_DetPro
DataWindow		idwGenCourrier
DataWindow		idwAutorisation

u_Libelle_Dga		iuoLibelle
u_Transaction		iTrTrans
u_BarreDefil		iuoDefil

Blob			iblBlobData, iblBlobDoc, iblBlob
Long			ilProd			
Long			ilTotVar	     // Nbre de variables possibles dans la table code_car
Long			idcIdDoc	     // IdDoc du courrier de relances.
Long			ilNbrRowDw1 // Nombre de row dans Dw_1
String			isChaineData
String			isTypTrt
//String			isRepWin	
String			isTxtCompo  // Composition du courrier de relance
String			isIdCour	    // Courrier de relances
String			isNomFicTrace // Nom du fichier de trace.	
String			isSolAltRl2    // Le soldage sera différent si le traitement prévoit des 2èmes relances.
String			isAltSoldRl    // Le produit prévoit (O/N) le soldage des dossiers récémment relancés. 
String			isFicSig    // Fichier de sign pers
String			isRepSig, isFmtSig	// Sign Pers 
String 			isModeleDefaut // Modele de la section [EDITION] variable MODELE //       JFF  26/04/2023 [RS5045_REF_MATP]
Int			iiHautFooter
Int			iiTailleDuLot	
Int			iiTotLigPol    // Nombre de ligne dans Dw_Police


// On compare ces dates par rapport à la date du jour
// donc idtDateMin est une date antérieure à idtDateMax
// qui est elle même antérieure à la date du jour.
DateTime			idtDateDuJour,idtDateMin, idtDateMax
DateTime			idtDateMaxSolRl, idtDateMaxSolPc


//Libellé du produit pour PageBlanche dossier soldé
String			isLibProd 


s_Pass			iTabVariable[]	// [PI052] Tableau de tableaux des variables par interlocuteur.
string			iTabCodeVar[]	// [PI052] Tableau des codes de variables.
String			iTabCleFichier [] // [PI052] Tableau des clé de fichiers généré en XML et à récupérer en PDF.
String			iTabCleFichierLocal [] // [PI052] Tableau des clé de fichiers PDF en local.	
String 			isCleRep	// [PI052] Clé du répertoire.		
String			isTextStPause // [PI052] Sav partie fixe
String			isExtFicOut // [PI052] Extension du fichier de sortir PDF/DOC
String			iTabCleKslEdt [] // [PI052] Tableau des clé pour l'édition sour KSL.	
Constant String isFicFinGen = "FIN.TXT"

Long				ilNbreTour // [PI052]
constant Long 	K_FrequenceTimer = 0.5 // [PI052] en seconde

Boolean 			ibEnvRelParMail // [RS6044_REL_MAIL]

Public : 	
	Boolean			ibTimerPI052 // [PI052]
	Boolean			ibPI052_GenEdtKsl // [PI052]
	Boolean			ibFinGenerationPDFOk // [PI052]
	Long				ilIdRelKSL // [PI052]


end variables

forward prototypes
public function boolean uf_preparerlancer ()
protected function boolean uf_determinerdatetrt ()
protected function boolean uf_datedujour ()
protected function boolean uf_chargerdw1 ()
public subroutine uf_cachertextdw1 (string ascas)
public function boolean uf_imprimerliste ()
protected function boolean uf_chargerdwpolice ()
protected function boolean uf_creerblob (long alrow)
protected function boolean uf_determinercomposition (long alrow)
protected function boolean uf_ecrirecourrierdansarchive (long alrow)
protected function boolean uf_misajourcourrieroriginal (long alrow)
public function boolean uf_ecriretrace (integer aicas, string astypsql, long alrow, string asmessagelibre)
protected function boolean uf_chargerdwparaprod ()
protected function boolean uf_detruirepremiererelance ()
protected function boolean uf_solderlesdossiers ()
public function boolean uf_lancertrt (ref boolean absaisie)
protected function boolean uf_controlersaisie (integer acas)
private function boolean uf_gestionboitearchive (long alidsin, long alligne)
public function string uf_get_libprod ()
public subroutine uf_initialiser_anc (ref u_datawindow adwproduit, ref u_datawindow adwtaillelot, ref u_datawindow adwsaisiesin, ref u_datawindow_accueil adw1, ref datawindow adwparaprod, ref datawindow adwpolice, ref datawindow adwcivilite, string astyptrt, ref u_libelle_dga auolibelle, ref u_transaction atrtrans, ref u_barredefil auodefil, ref datawindow adw_boitearchive, ref datawindow adw_detpro, ref datawindow adwgencourrier, ref datawindow adwautorisation)
private subroutine uf_initialiser_sigelec (long alidprod, string ascodoper)
public function long uf_zn_taillelot (integer acas)
public function long uf_zn_refsin (integer acas)
public subroutine uf_getautorisation (string asidnatcour, ref string asbin, ref boolean abmodifcour, ref boolean abvalauto, ref boolean abvalidation, long alidprod, string ascodoper, integer aiidi)
private function integer uf_ecrirecourrierdansarchive_sve (decimal adcidsin, decimal adcidinter, long alidprod)
public function string uf_format_numtel (string asvarstr)
public function integer uf_pi052_generer_xml (long alrow)
public function integer uf_pi052_gestiontimer (string ascas, integer aidelai)
public function integer uf_pi052 (string ascas, long alrow)
public function boolean uf_pi052_droitparam (string ascas)
public function boolean uf_creercourrierrelance (long aldossier, ref string asidcourrel, ref string astxtcomporel, ref blob ablblobdata, boolean ab2emetourpi052)
public function integer uf_pi052_recuperationcourrier ()
public function Long uf_get_iddoc ()
public function boolean uf_gestionrepcourrierlocal ()
end prototypes

public function boolean uf_preparerlancer ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_PreparerLancer (Public)
//* Auteur			: Fabry JF
//* Date				: 08/06/1999 15:47:17
//* Libellé			: Prépare le lancement du Traitement
//* Commentaires	: - Controle La saisie
//*					  - Charge le paramètrage du produit sélectionné.
//*
//* Arguments		: 
//*
//* Retourne		: 
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean		bOk 	= True
Int			iRow 	= 0


/*------------------------------------------------------------------*/
/* On Initialise Dw_1 et on cache son Header.                       */
/*------------------------------------------------------------------*/
iDw1.Reset ()
This.uf_CacherTextDw1 ( "OUI" )

/*------------------------------------------------------------------*/
/* On Contrôle la saisie.                                           */
/*------------------------------------------------------------------*/
bOk = This.uf_ControlerSaisie ( 1 )


/*------------------------------------------------------------------*/
/* On Charge le paramètrage. (excepté pour les R1P et DR1)          */
/*------------------------------------------------------------------*/
If bOk Then
	bOk = This.uf_ChargerDwParaProd ()
End If


/*------------------------------------------------------------------*/
/* Ramène la date du jour du serveur, dans idtDateDuJour.           */
/*------------------------------------------------------------------*/
If bOk Then
	bOk = This.uf_DateDuJour ()
End If

/*------------------------------------------------------------------*/
/* On détermine les dates de traitement. On charge idtDateMin ( et  */
/* éventuellement idtDateMax ).                                     */
/*------------------------------------------------------------------*/
If bOk Then
	bOk = This.uf_DeterminerDateTrt ()

	/*------------------------------------------------------------------*/
	/* JFF le 27/05/2003 : Pour Must il faut d'abord faire les          */
	/* dossiers de PANNE via la fenêtre de repérage.                    */
	/*------------------------------------------------------------------*/
	If ilProd = 5712 Then

		stMessage.bErreurG = FALSE
		stMessage.sCode	 = "RELA180"
		stMessage.sTitre   = "SIMPA2 - Soldage"
		stMessage.Icon	    = Exclamation!
		stMessage.Bouton   = YesNo!
		stMessage.sVar[1]  = String ( Date ( idtDateMaxSolPc ) )
		stMessage.bTrace   = False
		If F_Message ( stMessage ) = 2 Then bOk = FALSE

	End If
End If

/*------------------------------------------------------------------*/
/* Chargement des données dans Dw1.                                 */
/*------------------------------------------------------------------*/
If bOk Then
	bOk = This.uf_ChargerDw1 ()
End If



Return bOk

end function

protected function boolean uf_determinerdatetrt ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_DeterminerDateTrt (Protected) 
//* Auteur			: Fabry JF
//* Date				: 08/06/1999 16:57:55
//* Libellé			: Détermine les dates de traitements
//* Commentaires	: 
//*
//* Arguments		: Aucun 
//*
//* Retourne		: Boolean
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date	 	 Modification
//*     JFF   25/10/2022 [EVOL_PARAM_RELSOLD]
//*-----------------------------------------------------------------

Boolean 	bOk = True
DateTime	dtDtMin, dDtMax
Int		iDurRlMin		// Délai concernant les relances
Int		iDurRlMax      // Délai concernant les relances
Int		iDurSolMinRl   // Délai concernant le soldage lorsqu'il y a eut relances
Int		iDurSolMinPc   // Délai concernant le soldage lorsqu'il n'y a jamais de courriers,
								// ou lorsqu'il y a eu courriers sans relance.
Int		iMes				// Message à afficher
String	sUntRl1
String	sMes[ 3 ]		// Messages
String   sUntRl2, sUntSoldRl, sUntSoldPc

iDtDateMin 		 = stNul.Dtm
iDtDateMax 		 = stNul.Dtm
iDtDateMaxSolRl = stNul.Dtm
iDtDateMaxSolPc = stNul.Dtm


sMes[ 1 ] = "premières relances"
sMes[ 2 ] = "deuxièmes relances"
sMes[ 3 ] = "soldage de dossiers"


/*------------------------------------------------------------------*/
/* Le produit prévoit-il ce type de traitement ?						  */
/*------------------------------------------------------------------*/
CHOOSE CASE isTypTrt

	CASE "R1A", "R1U", "R1T"
		If  iDwParaProd.GetItemString ( 1, "ALT_RL1" ) = "N" Then
			iMes = 1
			bOk  = False
			stMessage.sCode	 = "RELA100"
		End If


	CASE "R2"
		If  iDwParaProd.GetItemString ( 1, "ALT_RL2" ) = "N" Then
			iMes = 2
			bOk  = False
			stMessage.sCode	 = "RELA100"
		End If


	CASE "R1P", "DR1"
		/*------------------------------------------------------------------*/
		/* On ne tient pas compte du paramètrage pour ce cas de traitement. */
		/* On ne calcule aucun délai.													  */
		/*------------------------------------------------------------------*/


	CASE "SOL"
		If  iDwParaProd.GetItemString ( 1, "ALT_SOLD" ) = "N" Then
			iMes = 3
			bOk  = False
			stMessage.sCode	 = "RELA100"
		End If

END CHOOSE


If Not bOk Then

	stMessage.bErreurG = FALSE
	stMessage.sTitre   = "SIMPA2 - Relances"
	stMessage.Icon	    = Information!
	stMessage.Bouton   = Ok!
	stMessage.sVar[1]  = sMes[ iMes ]
	stMessage.bTrace   = False
	F_Message ( stMessage )

End If


/*------------------------------------------------------------------*/
/* On Charge les délais	(excepté pour les trt R1P, DR1)  			  */
/* Ces délais sont à prendre en compte à partir de la date du jour. */
/* DUR_RL1_MAX >= DUR_RL1_MIN (mais idtDateMin <= idtDateMax )      */
/*------------------------------------------------------------------*/
If bOk and isTypTrt <> "R1P" and isTypTrt <> "DR1" Then

	// L'unité de temps pour tous les traitements est déterminés
	// à partir de UNT_RL1, voir le paramètrage.
	//	sUntRl1	  = iDwParaProd.GetItemString ( 1, "UNT_RL1" )

	CHOOSE CASE isTypTrt

		CASE "R1A", "R1U", "R1T"
			iDurRlMin = iDwParaProd.GetItemNumber ( 1, "DUR_RL1_MIN" )
			iDurRlMax = iDwParaProd.GetItemNumber ( 1, "DUR_RL1_MAX" )

			sUntRl1	  = iDwParaProd.GetItemString ( 1, "UNT_RL1" )

	
		CASE "R2"
			iDurRlMin = iDwParaProd.GetItemNumber ( 1, "DUR_RL2" )

			sUntRl2	  = iDwParaProd.GetItemString ( 1, "UNT_RL2" )


		CASE "SOL"
			iDurSolMinRl   = iDwParaProd.GetItemNumber ( 1, "DUR_SOLD_RL" )
			iDurSolMinPc   = iDwParaProd.GetItemNumber ( 1, "DUR_SOLD_PC" )

			// On stocke l'info indiquant que le produit prévoit ou pas des 2èmes 
			// relances, cela influera sur le soldage.
			isSolAltRl2 = iDwParaProd.GetItemString ( 1, "ALT_RL2" )

			sUntSoldRl = iDwParaProd.GetItemString ( 1, "UNT_SOLD_RL" )
			sUntSoldPc = iDwParaProd.GetItemString ( 1, "UNT_SOLD_PC" )
			

	END CHOOSE


/*--------------------------------------------------------------------------*/
/* Détermination des dates.                                                 */
/* On détermine les dates, sachant que idtDateMin <= idtDateMax             */
/* Ex: idtDateMin = 25/02/1999 00:00:00 -au-> idtDateMax 15/05/1999 23:59:59*/
/*     La date du jour étant le 27/07/1999 15:35:25                         */
/*--------------------------------------------------------------------------*/

	CHOOSE CASE isTypTrt

		CASE "R1A", "R1U", "R1T"
			idtDateMin = DateTime ( F_Plus_Date ( Date ( idtDateDuJour ) , ( iDurRlMax * (-1) ), sUntRl1 ), 00:00:00 )
			idtDateMax = DateTime ( F_Plus_Date ( Date ( idtDateDuJour ) , ( iDurRlMin * (-1) ), sUntRl1 ), 23:59:59 )

			// Les dates sont-elles valides ?
			bOk = Not ( Not F_Date ( String ( idtDateMin), 4 ) Or Not F_Date ( String ( idtDateMax ), 4 )	&
  	   		         Or  idtDateMax >= idtDateDuJour Or idtDateMin >= idtDateDuJour 				         & 
					      Or  idtDateMin > idtDateMax																         & 
                   )

		CASE "R2"
			//	[EVOL_PARAM_RELSOLD]
			idtDateMax = DateTime ( F_Plus_Date ( Date ( idtDateDuJour ) , ( iDurRlMin * (-1) ), sUntRl2 ), 23:59:59 )

			// La date est-elle valide ?
			bOk = Not ( Not F_Date ( String ( idtDateMax ), 4 ) Or idtDateMax >= idtDateDuJour  )


		CASE "SOL"

			// Si iDurSolMinRl est à 0, cela signifie qu'on souhaite ne
			// pas solder les dossiers qui ont eu "Récemment" une relance.
			// On ne soldera qu'en fonction de la date de validation pour les dossiers 
         // sans courrier, et en fonction de maj_le du dernier courrier édité pour les
         // dossiers ayant au moins un courrier en utilisant pour les deux cas le délai iDurSolMinPc.

			If iDurSolMinRl <> 0 Then
				isAltSoldRl     = "O"

				//	[EVOL_PARAM_RELSOLD]				
				idtDateMaxSolRl = DateTime ( F_Plus_Date ( Date ( idtDateDuJour ) , ( iDurSolMinRl * (-1) ), sUntSoldRl ), 23:59:59 )

				// La date est-elle valide ?
				bOk = Not ( Not F_Date ( String ( idtDateMaxSolRl), 4 ) Or  idtDateMaxSolRl >= idtDateDuJour )

			Else
				isAltSoldRl = "N"
			End If

			If bOk Then 

				//	[EVOL_PARAM_RELSOLD]
				idtDateMaxSolPc = DateTime ( F_Plus_Date ( Date ( idtDateDuJour ) , ( iDurSolMinPc * (-1) ), sUntSoldPc ), 23:59:59 )

				// La date est-elle valide ?
				bOk = Not ( Not F_Date ( String ( idtDateMaxSolPc ), 4 )	Or idtDateMaxSolPc >= idtDateDuJour )

	
				If bOk and isAltSoldRl = "O" Then
					bOk = Not ( idtDateMaxSolPc > idtDateMaxSolRl )
				End If

			End If


	END CHOOSE

	/*------------------------------------------------------------------*/
	/* Les dates ne sont pas valides, on ne lance pas le Trt            */
	/*------------------------------------------------------------------*/
	If Not bOk Then

		stMessage.bErreurG = FALSE
		stMessage.sCode	 = "RELA105"
		stMessage.sTitre   = "SIMPA2 - Relances"
		stMessage.Icon	    = Exclamation!
		stMessage.Bouton   = Ok!
		stMessage.bTrace   = True
		F_Message ( stMessage )

	End If


End If


Return bOk



end function

protected function boolean uf_datedujour ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_DateDuJour ( Protected )
//* Auteur			: Fabry JF
//* Date				: 08/06/1999 17:07:55
//* Libellé			: Détermine la date du jour.
//* Commentaires	: Ramène la date du jour et l'heure, du serveur
//*					  Cela nécéssite bien évidemment que la table paramètre 
//*					  ne soit pas vide, ce qui ne doit jamais arriver.
//* Arguments		: Aucun
//*
//* Retourne		: Boolean
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
 //* 			FPI	15/09/2014	[OPTIM_SQL]
 //*-----------------------------------------------------------------

Boolean   bOk = True
DateTime  dtDateDuJour

dtDateDuJour = stNul.dtm

// [OPTIM_SQL]
dtDateDuJour=Datetime( Today(), Now() )
// :[OPTIM_SQL]


If IsNull ( dtDateDuJour ) Then
	bOk = False

	stMessage.bErreurG = False
	stMessage.sCode	 = "GENE012"
	stMessage.sTitre   = "SIMPA2 - Relances"
	stMessage.Icon	    = Exclamation!
	stMessage.Bouton   = Ok!
	stMessage.bTrace   = True
	stMessage.sVar[1]  = "Impossible de lire la date du serveur. Le traitement n'est pas lancé."

	F_Message ( stMessage )	

Else

	idtDateDuJour = dtDateDuJour

End If


Return bOk 

end function

protected function boolean uf_chargerdw1 ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_ChargerDw1 (Protected)
//* Auteur			: Fabry JF
//* Date				: 09/06/1999 13:58:21
//* Libellé			: Chargement de Dw_1.
//* Commentaires	: On charge tous les courriers qui vont être à relancer
//*					  pour la première fois.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*    JFF   11/01/2011    [DECIMAL_PAPILLON]
//*-----------------------------------------------------------------

Boolean		bOk 	= True
String		sTitre, sProd, sProdLong, sTriActuel
Long			dcIdSin, lCpt, lIdSinSav, lIdSinLu
Decimal {2} dcIdProd

iDw1.SetRedraw ( False )

/*------------------------------------------------------------------*/
/* Différents retrieves en fonction du type de relance.             */
/*------------------------------------------------------------------*/
CHOOSE CASE isTypTrt

	// Premières Relances Automatique.
	CASE "R1A"

		ilNbrRowDw1 = iDw1.Retrieve ( ilProd, idtDateMin, idtDateMax )

		sTitre = "st_Titre.text = 'Liste de " + String ( ilNbrRowDw1 ) + " courrier(s) validé(s) entre le " + String ( Date ( idtDateMin) ) + & 
					" et le " + String ( Date ( idtDateMax) ) + ".'" 	

		sProd  = " : Premières Relances Automatiques"



	// Premières Relances Automatique pour les Gti Uf avec Dem. Pces à la banque.
	CASE "R1U"

		ilNbrRowDw1 = iDw1.Retrieve ( ilProd, idtDateMin, idtDateMax )

		// Aucun Group by n'étant fait dans la requête pour des raisons techniques
		//	Il faut épurer les doublons de sinistres.

		sTriActuel = iDw1.Describe ( "datawindow.table.Sort" )
		iDw1.Modify ( "datawindow.table.Sort = '1A'" )
		iDw1.Sort ()

		lIdSinSav = 0
		For lCpt = ilNbrRowDw1 To 1 Step -1 
			
			lIdSinLu = iDw1.GetItemNumber ( lCpt, "ID_SIN" )
			
			If lIdSinLu = lIdSinSav Then iDw1.DeleteRow ( lCpt )
		
			lIdSinSav = lIdSinLu

		Next		

		iDw1.Modify ( "datawindow.table.Sort = '" + sTriActuel + "'" )
		iDw1.Sort ()

		ilNbrRowDw1 = iDw1.RowCount ()

		sTitre = "st_Titre.text = 'Liste de " + String ( ilNbrRowDw1 ) + " courrier(s) validé(s) entre le " + String ( Date ( idtDateMin) ) + & 
					" et le " + String ( Date ( idtDateMax) ) + ".'" 	

		sProd  = " : Premières Relances Automatiques (Garanties Uf avec Dem. Pces. à la banque)"


		

	// Premières Relances Particulières
	CASE "R1T"

		iDw1.Retrieve ( ilProd, idtDateMin, idtDateMax )

		ilNbrRowDw1 = iDw1.RowCount ()

		sTitre = "st_Titre.text = 'Liste de " + String ( ilNbrRowDw1 ) + " courrier(s) validé(s) entre le " + String ( Date ( idtDateMin) ) + & 
					" et le " + String ( Date ( idtDateMax) ) + ".'" 	

		sProd  = " : Premières Relances Particulières"



	// Premières Relances Ponctuelles.
	CASE "R1P"

		dcIdSin 		= iDwSaisieSin.GetItemNumber ( 1, "ID_SIN" )
		ilNbrRowDw1 = iDw1.Retrieve ( dcIdSin, ilProd )


		sTitre = "st_Titre.text = 'Liste de " + String ( ilNbrRowDw1 ) + " courrier(s) n~~'ayant jamais été relancé(s).'" 	

		sProd  = " : Premières Relances Ponctuelles"



	// Destruction d'une Première Relance.
	CASE "DR1"

		dcIdSin 		= iDwSaisieSin.GetItemNumber ( 1, "ID_SIN" )
		ilNbrRowDw1 = iDw1.Retrieve ( dcIdSin )

		sTitre = "st_Titre.text = 'Liste de " + String ( ilNbrRowDw1 ) + " courrier(s) de première relance à annuler.'" 	

		sProd  = " : Annulation d~~'une Première Relance"



	// Deuxième Relances
	CASE "R2"

		ilNbrRowDw1 = iDw1.Retrieve ( ilProd, idtDateMax )

		sTitre = "st_Titre.text = 'Liste de " + String ( ilNbrRowDw1 ) + " courrier(s) de première relance édités avant le " + String ( Date ( idtDateMax) ) + ".'"

		sProd  = " : Deuxième Relances"



	// Soldage des dossiers
	CASE "SOL"

		ilNbrRowDw1 = iDw1.Retrieve ( ilProd, isSolAltRl2, isAltSoldRl, idtDateMaxSolRl, idtDateMaxSolPc )

		sTitre = "st_Titre.text = 'Liste de " + String ( ilNbrRowDw1 ) + " dossier(s) à solder.'" 	

		sProd  = " : Soldage des dossiers"





END CHOOSE

iDw1.SetRedraw ( True )

/*------------------------------------------------------------------*/
/* Le retrieve s'est mal passé, on arrête tout.                     */
/*------------------------------------------------------------------*/
If ilNbrRowDw1 < 0 Then

	bOk = False
	iDw1.Reset ()
	This.uf_CacherTextDw1 ( "OUI" )
	
	stMessage.bErreurG	= False
	stMessage.sCode	  	= "RELA110"
	stMessage.sTitre  	= "SIMPA2 - Relances"
	stMessage.Icon	  		= Exclamation!
	stMessage.Bouton  	= Ok!
	stMessage.bTrace     = True

	F_Message ( stMessage )


/*------------------------------------------------------------------*/
/* Aucune ligne ramenée.														  */
/*------------------------------------------------------------------*/
ElseIf ilNbrRowDw1 = 0 Then

	bOk = False
	iDw1.Reset ()
	This.uf_CacherTextDw1 ( "OUI" )

	stMessage.bErreurG	= False
	stMessage.sTitre  	= "SIMPA2 - Relances"
	stMessage.Icon	  		= Information!
	stMessage.Bouton  	= Ok!

	CHOOSE CASE isTypTrt
		CASE "R1A", "R1U", "R1P", "R1T"
			stMessage.sCode = "RELA130"				

		CASE "R2"
			stMessage.sCode = "RELA133"
				
		CASE "DR1"
			stMessage.sCode = "RELA131"				

		CASE "SOL"
			stMessage.sCode = "RELA132"				
	END CHOOSE


	F_Message ( stMessage )


/*------------------------------------------------------------------*/
/* On affiche le Header de Dw_1                                     */
/*------------------------------------------------------------------*/
Else

   CHOOSE CASE isTypTrt

		CASE "R1T", "DR1", "SOL"

			sProdLong = ""

			// [DECIMAL_PAPILLON]
			dcIdProd = dec (ilProd)
			SELECT lib_long
			INTO	 :sProdLong
			FROM   sysadm.produit
			WHERE  id_prod = :dcIdProd
			USING  iTrTrans ;

			sProd = "st_Produit.text = '" + sProdLong + sProd + "'"			
			isLibProd = sProdLong

		CASE ELSE
			sProd = "st_Produit.text = '" + iDw1.GetItemString ( 1, "PROD_LONG" ) + sProd + "'"
	
	END CHOOSE


	iDw1.Modify ( sTitre )
	iDw1.Modify ( sProd )

	This.uf_CacherTextDw1 ( "NON" )
	SetPointer ( Arrow! )	

End If

/*------------------------------------------------------------------*/
/* On commit pour les tables temporaires utilisées.                 */
/*------------------------------------------------------------------*/
F_Commit ( iTrTrans, True )

Return bOk

end function

public subroutine uf_cachertextdw1 (string ascas);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_CacherTextDw1	(Public)
//* Auteur			: Fabry JF
//* Date				: 09/06/1999 15:38:24
//* Libellé			: Cache le header de Dw1
//* Commentaires	: 
//*
//* Arguments		: String			asCas			(Val)			OUI on cache, NON on ne cache pas
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Int	iCache

If asCas = "OUI" Then
	iCache = 0
Else 
	iCache = 1
End If

/*------------------------------------------------------------------*/
/* Dw_1 peut être différente fonction des trt.          				  */
/*------------------------------------------------------------------*/
CHOOSE CASE isTypTrt

	CASE "R1A", "R1U", "R1T", "R1P", "DR1", "R2"

		iDw1.Modify("st_Produit.visible=" 	+ String ( iCache ) )
		iDw1.Modify("st_titre.visible=" 		+ String ( iCache ) )
		iDw1.Modify("id_sin_t.visible="		+ String ( iCache ) )
		iDw1.Modify("cod_inter_t.visible=" 	+ String ( iCache ) )
		iDw1.Modify("nom_inter_t.visible=" 	+ String ( iCache ) )
		iDw1.Modify("id_cour_t.visible=" 	+ String ( iCache ) )
		iDw1.Modify("valide_par_t.visible=" + String ( iCache ) )
		iDw1.Modify("valide_le_t.visible=" 	+ String ( iCache ) )



	CASE "SOL"

		iDw1.Modify("st_Produit.visible=" 	+ String ( iCache ) )
		iDw1.Modify("st_titre.visible=" 		+ String ( iCache ) )
		iDw1.Modify("id_sin_t.visible="		+ String ( iCache ) )
		iDw1.Modify("cod_inter_t.visible=" 	+ String ( iCache ) )
		iDw1.Modify("nom_inter_t.visible=" 	+ String ( iCache ) )
		iDw1.Modify("id_cour_t.visible=" 	+ String ( iCache ) )
		iDw1.Modify("valide_par_t.visible=" + String ( iCache ) )
		iDw1.Modify("valide_le_t.visible=" 	+ String ( iCache ) )
		iDw1.Modify("etat_trt_t.visible=" 	+ String ( iCache ) )
		iDw1.Modify("arch_code_t.visible=" 	+ String ( iCache ) )



END CHOOSE



end subroutine

public function boolean uf_imprimerliste ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_ImprimerListe	(Public) 
//* Auteur			: Fabry JF
//* Date				: 09/06/1999 15:13:37
//* Libellé			: Impression de la liste des dossiers à relancer.
//* Commentaires	: 	
//*
//* Arguments		: Rien
//*
//* Retourne		: Boolean
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean 	bOk = True

iDw1.SetReDraw ( False )
iDw1.Modify("datawindow.Footer.Height=" + String ( iiHautFooter ) )
iDw1.Print ()
iDw1.Modify("datawindow.Footer.Height=0" )
iDw1.SetReDraw ( True )

Return bOk
end function

protected function boolean uf_chargerdwpolice ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_ChargerDwPolice	(Protected)
//* Auteur			: Fabry JF
//* Date				: 11/06/1999 10:32:39
//* Libellé			: Chargement de Dw_Police
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


Boolean		bOk 	 = True
Boolean		bDelete

Int			iRow				// Nombre de ligne Chargées
Int			iCpt				// Compteur
Int			iTotRow			// Nombre total de Row dans DwPolice
Int			iRevSav			// Sauvegarde du la Revision dans DwPolice
Int			iRevCour			// Revision courante dans Dw_Police
String		sRech				// Chaîne de recherche

iiTotLigPol = -1
iDwPolice.Reset ()

iRow = iDwPolice.Retrieve ( ilProd )


/*------------------------------------------------------------------*/
/* Le retrieve s'est mal passé, on arrête tout.                     */
/*------------------------------------------------------------------*/
If iRow < 0 Then

	bOk = False
	iDwPolice.Reset ()

	stMessage.bErreurG = False
	stMessage.sCode	 = "GENE012"
	stMessage.sTitre   = "SIMPA2 - Relances"
	stMessage.Icon	    = Exclamation!
	stMessage.Bouton   = Ok!
	stMessage.bTrace   = False
	stMessage.sVar[1]  = "Problème lors du chargement des polices. Le traitement n'est pas lancé"

	F_Message ( stMessage )

End If


/*------------------------------------------------------------------*/
/* sinon on nettoie    DwPolice afin de ne pas garder dans la DW    */
/* les lignes pour lesquelles, il y a deux n° de police différents  */
/* pour la même révision.                                           */
/* (Vu avec Denis)																  */
/*------------------------------------------------------------------*/
If bOk Then

	iTotRow  = iDwPolice.RowCount ()
	iRevSav  = stNul.inum
	iRevCour = stNul.inum
	bDelete	= False

	For iCpt = iTotRow To 1 Step -1

		iRevCour = iDwPolice.GetItemNumber ( iCpt, "ID_REV" )
			
		If Not IsNull ( iRevSav ) And iRevCour = iRevSav Then
			
			iDwPolice.DeleteRow ( iCpt + 1 )
			bDelete = True
				
			//.. Cas de la première ligne, un peu spécial.
			If iCpt = 1 Then
				iDwPolice.DeleteRow ( iCpt )
			End If

		ElseIf bDelete Then
	
			iDwPolice.DeleteRow ( iCpt + 1 )
			bDelete = False
				
		End If
		
		iRevSav = iRevCour

	Next		

	/*------------------------------------------------------------------*/
	/* On affecte définitivement le nombre de lignes de Dw_Police dans  */
	/* une variable d'instance afin de ne pas avoir à le recalculer à   */
	/* chaque appel de uf_CreerBlob.                                    */
	/*------------------------------------------------------------------*/
	iiTotLigPol = iDwPolice.RowCount ()

End If



Return bOk



end function

protected function boolean uf_creerblob (long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_CreerBlob	(Protected)
//* Auteur			: Fabry JF
//* Date				: 14/06/1999 12:08:29
//* Libellé			: Création du blob de données.
//* Commentaires	: 
//*
//* Arguments		: Long		alRow			// Row du dossier à Traiter
//*
//* Retourne		: Boolean
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF   15/04/04  DCMP 040020 SVE : Gestion de la Sign Pers
//* #2  MADM  04/08/06  Projet DNTMAIL1/2 Mails sortant en remplacement des courriers
//* #3  DGA   19/09/2006	Gestion d'un répertoire temporaire DCMP-060643
//* #4	FPI	28/09/2009	[DCMP090552] Gestion des no de tel étranger
//* #4   FPI   24/11/2009   [POLICE_PARTICULIERE] 
//			FPI	13/10/2010	[VDoc1416] civilité longue 4 à "Madame, Monsieur" 
//       JFF   06/11/2018 [PM451-1]
//       JFF   09/11/2018 [20231109] Correctif sur la civilité entre le row et la valeur
//*-----------------------------------------------------------------

Boolean 		bOk = True
Boolean		bVal
String		sNomFic			// Nom du fichier Blob
String		sVide[]			// Tableau de variables à insérer dans le blob.
String		sVal			
String		sRech				// Chaîne de recherche
String		sChaine			// ChaÎne à écrire dans le fichier, qui constituera le blob.
String		sMes				// Message
String		sBin
Int			iRowPol			// Row dans Dw_Police
Int			iFic				// Pointeur sur fichier
String 		sLibDept, sVal2, sDpParam, sVarNonArmee 
Long 			lDeb, lFin
Int 			iRow
Boolean 		bOkDp66 
n_cst_string nvString

Long lIdSin, lIdProd, lIdRev   // #4

string	asTabNull[]	  // [PI052] Tableau Null
s_Pass		aspTabNull[]	  // [PI052] Tableau Null

// [PI052] 
iTabVariable = aspTabNull
iTabCodeVar = 	asTabNull 

/*------------------------------------------------------------------*/
/* On efface tous les fichiers de data pouvant exister afin qu'il   */
/* n'y ait pas de conflits éventuels.                               */
/*------------------------------------------------------------------*/
//u_DeclarationFuncky uoDeclarationFuncky //[I037] Migration FUNCKy
//uoDeclarationFuncky = Create u_DeclarationFuncky
/*------------------------------------------------------------------*/  
/* #3. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sNomFic = isRepWin + "\TEMP\" + stGlb.sCodAppli + "*.DT"
sNomFic = stGLB.sRepTempo + stGlb.sCodAppli + "*.DT"
//uoDeclarationFuncky.Uf_FEraseAll ( sNomFic )
stglb.uoWin.Uf_FEraseAll ( sNomFic )
//Destroy uoDeclarationFuncky

/*------------------------------------------------------------------*/
/* On initialise le UserObjet pour la gestion des variables.        */
/*------------------------------------------------------------------*/
iuoLibelle.Uf_Initialisation ( iTrTrans )
ilTotVar = iuoLibelle.Uf_Retrieve ( "-VA" )

/*------------------------------------------------------------------*/
/* On réarme le tableau des variables à vide.                       */
/*------------------------------------------------------------------*/
//String sVide[] // [MIGPB11] [EMD] : mise en commentaire de la double declaration de sVide[]
sVide [ ilTotVar ] = ""
iuoLibelle.Uf_Initialiser_Tableau ( sVide [] )

sVarNonArmee = ""

/*------------------------------------------------------------------*/
/* Description du blob.                                             */
/*------------------------------------------------------------------*/
/***********************************************************************************************/
/* ICIVIC		= 	CIVILITE COURTE DE L'INTERLOCUTEUR  	( inter.cod_civ )                 	  */	
/* ICIVIL		= 	CIVILITE LONGUE DE L'INTERLOCUTEUR  	( inter.cod_civ )                	  */	
/* INTLIB		= 	NOM DE L'INTERLOCUTEUR                	( inter.lib )     						  */	
/* IADR01		= 	ADRESSE 1 DE L'INTERLOCUTEUR          	( inter.adr_1 )                       */	
/* IADR02		= 	ADRESSE 2 DE L'INTERLOCUTEUR          	( inter.adr_2 )                       */	
/* IADCPO		=	CODE POSTAL DE L'INTERLOCUTEUR        	( inter.adr_cp )                      */	
/* IADVIL		=	VILLE DE L'INTERLOCUTEUR 					( inter.adr_ville )                   */	
/* ADRATT		=	A L'ATTENTION DE                       ( inter.adr_cp ) 							  */		
/* IREF01		=	VOS REFERENCES 1                       ( inter.vref_1 )							  */	
/* IREF02		=	VOS REFERENCES 2                       ( inter.vref_2 )							  */		
/* IRIBBQ		=	RIB BANQUE DE L'INTERLOCUTEUR          ( inter.rib_bq )							  */			
/* IRIBCL		=	RIB CLE DE L'INTERLOCUTEUR     			( inter.rib_cle )							  */	 	
/* IRIBCP		=	RIB COMPTE DE L'INTERLOCUTEUR          ( inter.rib_cpt )							  */	
/* IRIBGU		=	RIB GUICHET DE L'INTERLOCUTEUR			( inter.rib_gui ) 						  */		 
/* ACIVAS		=	CIVILITE DE L’ASSURE							( personne.cod_civ )						  */	
/* ANOMAS		=	NOM DE L’ASSURE								( personne.nom )							  */
/* APREAS		=	PRENOM DE L’ASSURE							( personne.prenom )						  */
/* ZVAR01		=	DATE D’ENVOI DU COURRIER QUE L’ON RELANCE (archive.dte_edit)					  */
/* ARIBBQ		=	RIB BANQUE DE L’ASSURE						( inter.rib_bq where cod_inter = A )  */
/* ARIBCL		=	RIB CLE DE L’ASSURE							( inter.rib_bq where cod_inter = A )  */
/* ARIBCP		=	RIB COMPTE DE L’ASSURE   					( inter.rib_bq where cod_inter = A )  */
/* ARIBGU		=	RIB GUICHET DE L’ASSURE						( inter.rib_bq where cod_inter = A )  */
/* PCODDG		=	CODE SECTEUR									( produit.id_depts )                  */
/* PCODDP 		=	CODE DEPARTEMENT DU PRODUIT				( produit.id_dept    )                */
/* PCOMPA		=	NOM DE LA COMPAGNIE D'ASSURANCE			( compagnie.lib_cie )                 */
/* PPOLIC 		=	NO DE LA POLICE								( police.lib_police )                 */
/* PIDPRO		=	CODE PRODUIT									( archive.id_prod )                   */
/* PLIBCO 		=	LIBELLE COURT DU PRODUIT               ( produit.lib_court )                 */
/* PLIBLO 		=	LIBELLE LONG DU PRODUIT						( produit.lib_long )                  */
/* PNOFAX 		=	NUMERO DE FAX PRODUIT						( produit.num_fax )                   */
/* PNOTEL 		=	NUMERO DE TELEPHONE PRODUIT				( produit.num_tel )                   */
/* SCODOP 		=	OPERATEUR AYANT MIS A JOUR DOSSIER		( stGlb.sCodOper )                    */
/* SDTADH 		=	DATE D'ADHESION                       	( sinistre.dte_adh )                  */
/* SDTESU 		=	DATE DE SURVENANCE DU SINISTRE        	( sinistre.dte_surv sans heure)	     */
/* SIDADH 		=	NUMERO DE CARTE OU D'ADHESION				( sinistre.id_adh )                   */
/* SIDSIN 		=	NUMERO DE SINISTRE							( archive.id_sin )                    */
/* SIDETS 		=	NUMERO ETS                             ( sinistre.id_ets )                   */
/* SLIETS 		=	LIBELLE ASSOCIE A ID_ETS               ( groupe.lib_grp )                    */
/***********************************************************************************************/

sVal = iDw1.GetItemString ( alRow, "INT_CIVIL" )
sVal = iDwCivilite.GetItemString ( Integer ( sVal ), "LIB_CODE" )
iuoLibelle.Uf_SetValue ( "ICIVIC", sVal )	

//sVal = iDw1.GetItemString ( alRow, "INT_CIVIL" )
//sVal = iDwCivilite.GetItemString ( Integer ( sVal ), "LIB_CODE_LONG" )
//iuoLibelle.Uf_SetValue ( "ICIVIL", sVal )	

/*------------------------------------------------------------------*/
/* CIVILITE L'INTERLOCUTEUR      			                          */
/*------------------------------------------------------------------*/
sVal = iDw1.GetItemString ( alRow, "INT_CIVIL" )
//If sVal  = "4" Or sVal = "5" Then
// [PM451-1]
If sVal = "5" Then //[VDoc1416] [PM451-1]
	sVal = "4"
End If

iRow = iDwCivilite.Find ( "ID_CODE = " + sVal, 1, iDwCivilite.RowCount () )  // [20231109]
sval = iDwCivilite.GetItemString ( iRow, "LIB_CODE_LONG" )

iuoLibelle.Uf_SetValue ( "ICIVIL", sVal )

sVal = iDw1.GetItemString ( alRow, "NOM_INTER" )
iuoLibelle.Uf_SetValue ( "INTLIB", sVal )	

sVal = iDw1.GetItemString ( alRow, "INT_ADR1" )
iuoLibelle.Uf_SetValue ( "IADR01", sVal )	

sVal = iDw1.GetItemString ( alRow, "INT_ADR2" )
iuoLibelle.Uf_SetValue ( "IADR02", sVal )	

sVal = iDw1.GetItemString ( alRow, "INT_ADR_CP" )
iuoLibelle.Uf_SetValue ( "IADCPO", sVal )	

sVal = iDw1.GetItemString ( alRow, "INT_ADR_VILLE" )
iuoLibelle.Uf_SetValue ( "IADVIL", sVal )	

sVal = iDw1.GetItemString ( alRow, "INT_ADR_CP" )
iuoLibelle.Uf_SetValue ( "ADRATT", sVal )	

sVal = iDw1.GetItemString ( alRow, "INT_VREF1" )
iuoLibelle.Uf_SetValue ( "IREF01", sVal )	

sVal = iDw1.GetItemString ( alRow, "INT_VREF2" )
iuoLibelle.Uf_SetValue ( "IREF02", sVal )	

sVal = iDw1.GetItemString ( alRow, "INT_RIB_BQ" )
iuoLibelle.Uf_SetValue ( "IRIBBQ", sVal )	

sVal = iDw1.GetItemString ( alRow, "INT_RIB_CLE" )
iuoLibelle.Uf_SetValue ( "IRIBCL", sVal )	

sVal = iDw1.GetItemString ( alRow, "INT_RIB_CPT" )
iuoLibelle.Uf_SetValue ( "IRIBCP", sVal )	

sVal = iDw1.GetItemString ( alRow, "INT_RIB_GUI" )
iuoLibelle.Uf_SetValue ( "IRIBGU", sVal )	

sVal = iDw1.GetItemString ( alRow, "PERS_CIVIL" )
sVal = iDwCivilite.GetItemString ( Integer ( sVal ), "LIB_CODE" )
iuoLibelle.Uf_SetValue ( "ACIVAS", sVal )	

sVal = iDw1.GetItemString ( alRow, "PERS_NOM" )
iuoLibelle.Uf_SetValue ( "ANOMAS", sVal )	

sVal = iDw1.GetItemString ( alRow, "PERS_PRENOM" )
iuoLibelle.Uf_SetValue ( "APREAS", sVal )

sVal = String ( iDw1.GetItemDate ( alRow, "DTE_EDIT" ), "dd/mm/yyyy" ) 
iuoLibelle.Uf_SetValue ( "ZVAR01", sVal )

sVal = iDw1.GetItemString ( alRow, "INTASS_RIB_BQ" )
iuoLibelle.Uf_SetValue ( "ARIBBQ", sVal )	

sVal = iDw1.GetItemString ( alRow, "INTASS_RIB_CLE" )
iuoLibelle.Uf_SetValue ( "ARIBCL", sVal )	

sVal = iDw1.GetItemString ( alRow, "INTASS_RIB_CPT" )
iuoLibelle.Uf_SetValue ( "ARIBCP", sVal )	

sVal = iDw1.GetItemString ( alRow, "INTASS_RIB_GUI" )
iuoLibelle.Uf_SetValue ( "ARIBGU", sVal )	

sVal = String ( iDw1.GetItemNumber ( alRow, "PROD_ID_DEPTS" ) )
iuoLibelle.Uf_SetValue ( "PCODDG", sVal )	

/* Libéllé du sous département   											  */
/*------------------------------------------------------------------*/
sLibDept = space ( 35 )
itrTrans.IM_S01_DEPARTEMENT( Dec(sVal), sLibDept )
iuoLibelle.Uf_SetValue ( "ZVAR28", sLibDept )

sVal = String ( iDw1.GetItemNumber ( alRow, "PROD_ID_DEPT" ) )
iuoLibelle.Uf_SetValue ( "PCODDP", sVal )	

/*------------------------------------------------------------------*/
/* Deux cas possibles pour la cie & la police.                      */
/* Voir uf_ChargerDwPolice, dw_police peut ne pas contenir certaines*/
/* révisions.																		  */
/*------------------------------------------------------------------*/
sRech = "ID_REV = " + String ( iDw1.GetItemNumber ( alRow, "ID_REV" ) )
iRowPol = iDwPolice.Find ( sRech, 1, iiTotLigPol )

If iRowPol = 0 Then

	sVal = ""	
	iuoLibelle.Uf_SetValue ( "PCOMPA", sVal )	
	//iuoLibelle.Uf_SetValue ( "PPOLIC", sVal )   // #4

Else

   sVal = iDwPolice.GetItemString ( iRowPol, "LIB_CIE" )
   iuoLibelle.Uf_SetValue ( "PCOMPA", sVal )   

   sVal = iDwPolice.GetItemString ( iRowPol, "LIB_POLICE" )
   //   iuoLibelle.Uf_SetValue ( "PPOLIC", sVal )      // #4

End If
// #4 [POLICE_PARTICULIERE]
sVal = Fill ( " ", 35 )

lIdSin = iDw1.GetItemNumber ( alRow, "ID_SIN" )
lIdProd = iDw1.GetItemNumber ( alRow, "ID_PROD" )
lIdRev = iDw1.GetItemNumber ( alRow, "ID_REV" )

SQLCA.PS_S01_LIB_POLICE ( lIdSin, lIdProd, lIdRev, -1, sVal ) 
iuoLibelle.Uf_SetValue ( "PPOLIC", sVal )
// Fin #4

sVal = String ( iDw1.GetItemNumber ( alRow, "ID_PROD" ) )
iuoLibelle.Uf_SetValue ( "PIDPRO", sVal )	

//sVal = iDw1.GetItemString ( alRow, "PROD_COURT" ) 
//iuoLibelle.Uf_SetValue ( "PLIBCO", sVal )	
//
//sVal = iDw1.GetItemString ( alRow, "PROD_LONG" ) 
//iuoLibelle.Uf_SetValue ( "PLIBLO", sVal )	

F_RechDetPro ( lDeb, lFin, idw_DetPro, iDw1.GetItemNumber ( 1, "ID_PROD" ), "-DP", 22 )
If lDeb > 0 Then
	sVal = iDw1.GetItemString ( 1, "PROD_LONG" )
Else
	sVal = iDw1.GetItemString ( 1, "PROD_COURT" )
End If

iuoLibelle.Uf_SetValue ( "PLIBCO", sVal )

iuoLibelle.Uf_SetValue ( "ZVAR25", sVal )		 	

bOkDp66 = FALSE
F_RechDetPro ( lDeb, lFin, idw_DetPro, iDw1.GetItemNumber ( 1, "ID_PROD" ), '-DP', 66 )
If lDeb > 0 Then
	sVal = Trim ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ) )

	If sVal <> "" And Not IsNull ( sVal ) Then
		iuoLibelle.Uf_SetValue ( "ZVAR25", sVal )
		bOkDp66 = TRUE
	End If
End If 

F_RechDetPro ( lDeb, lFin, idw_DetPro, iDw1.GetItemNumber ( 1, "ID_PROD" ), '-DP', 67 )
If lDeb > 0 And bOkDp66 Then
	sVal = Trim ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ) )

	If sVal <> "" And Not IsNull ( sVal ) Then
		iuoLibelle.Uf_SetValue ( "ZVAR26", sVal )
	Else
		iuoLibelle.Uf_SetValue ( "ZVAR26", "" )		 			
	End If
Else 	 
	iuoLibelle.Uf_SetValue ( "ZVAR26", "" )		 	
End If 


// #4- [DCMP090552]
/*sVal = String ( iDw1.GetItemString ( alRow, "PROD_FAX" ), "@@ @@ @@ @@ @@" )
iuoLibelle.Uf_SetValue ( "PNOFAX", sVal )	

sVal = String ( iDw1.GetItemString ( alRow, "PROD_TEL" ), "@@ @@ @@ @@ @@" )
iuoLibelle.Uf_SetValue ( "PNOTEL", sVal )	*/
sVal2 = iDw1.GetItemString ( alRow, "INT_ADR_CP" )
lDeb = 0

if sVal2 = "00000" or sVal2="98000" Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, iDw1.GetItemNumber ( 1, "ID_PROD" ), '-DP', 120 )
End if

if lDeb > 0 Then
	sDpParam = idw_detpro.getItemString(lDeb, "VAL_CAR")
	sDpParam = nvString.of_getkeyvalue( sDpParam, "INDICATIF", ";")
	
	sVal=iDw1.GetItemString ( alRow, "PROD_FAX" )
	sVal = Mid(sVal,2)
	sVal = String (sVal, "@@@ @@@ @@@" )
	sVal= sDpParam + " " + sVal
	iuoLibelle.Uf_SetValue ( "PNOFAX", sVal )	
	
	sVal=iDw1.GetItemString ( alRow, "PROD_TEL" )
	sVal = Mid(sVal,2)
	sVal = String (sVal, "@@@ @@@ @@@" )
	sVal= sDpParam + " " + sVal
	iuoLibelle.Uf_SetValue ( "PNOTEL", sVal )	
Else
	sVal=iDw1.GetItemString ( alRow, "PROD_FAX" )
	sVal = Uf_Format_NumTel ( sVal )
	iuoLibelle.Uf_SetValue ( "PNOFAX", sVal )	
	
	sVal=iDw1.GetItemString ( alRow, "PROD_TEL" )

	iuoLibelle.Uf_SetValue ( "PNOTEL", sVal )	
End If
// Fin #4

sVal = stGlb.sCodOper
iuoLibelle.Uf_SetValue ( "SCODOP", sVal )	

sVal = String ( iDw1.GetItemDate ( alRow, "DTE_ADH" ), "dd/mm/yyyy" )
iuoLibelle.Uf_SetValue ( "SDTADH", sVal )	

sVal = String ( iDw1.GetItemDate ( alRow, "DTE_SURV" ), "dd/mm/yyyy" )
iuoLibelle.Uf_SetValue ( "SDTESU", sVal )	

sVal = iDw1.GetItemString ( alRow, "ID_ADH" )
iuoLibelle.Uf_SetValue ( "SIDADH", sVal )	

sVal = String ( iDw1.GetItemNumber ( alRow, "ID_SIN" ) ) 
iuoLibelle.Uf_SetValue ( "SIDSIN", sVal )	

sVal = String ( iDw1.GetItemNumber ( alRow, "ID_ETS" ) ) 
iuoLibelle.Uf_SetValue ( "SIDETS", sVal )	

sVal = iDw1.GetItemString ( alRow, "LIB_GRP" )
iuoLibelle.Uf_SetValue ( "SLIETS", sVal )	

/*------------------------------------------------------------------*/
/* #3 : Renseignement de la variable ZVAR05 (idem à SAVANE) avec le */
/* Prénom et nom du Gestionnaire.											  */
/*------------------------------------------------------------------*/

/*----------------------------------------------------------------------------*/
/* #2 : Ajout de l'identifiant interlocuteur à la fonction uf_GetAutorisation */
/*----------------------------------------------------------------------------*/
This.uf_GetAutorisation ( "", sBIN, bVal, bVal, bVal, iDw1.GetItemNumber ( alRow, "ID_PROD" ), stGlb.sCodOper, iDw1.GetItemNumber ( alRow, "ID_I" ) )
If Mid ( sBIN, 10, 1 ) = "1" Then
	iUoLibelle.Uf_SetValue ( "ZVAR05" ,  stGlb.sPrenomOper + " " + stGlb.sNomOper )
Else
	iUoLibelle.Uf_SetValue ( "ZVAR05" ,  "Pour SPB" )
End If

/*------------------------------------------------------------------*/
/* #1 : DCMP 040020 SVE                                             */
/*------------------------------------------------------------------*/
If stGLB.bSaiValEdt Then
  This.uf_Initialiser_SigElec ( iDw1.GetItemNumber ( alRow, "ID_PROD" ) , iDw1.GetItemString ( alRow, "VALIDE_PAR") )
  iuoLibelle.Uf_SetValue ( "ZVAR21", isFicSig )	
End If

/*------------------------------------------------------------------*/
/* Variable donnant le délai en jour 										  */
/* pour réponse au deuxième relance											  */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, iDw1.GetItemNumber ( alRow, "ID_PROD" ), "-DP", 97 )
if lDeb > 0 then
	iuoLibelle.Uf_SetValue ( "ZVAR34", string(idw_DetPro.object.val_num[lDeb]) )	
else
	iuoLibelle.Uf_SetValue ( "ZVAR34", "30")
end if

/* On charge dans la variable ZVAR02, le COD_INTER.					  */
/*------------------------------------------------------------------*/
sVal = iDw1.GetItemString ( alRow, "COD_INTER" )
iuoLibelle.Uf_SetValue ( "ZVAR02", sVal )

F_RechDetPro ( lDeb, lFin, idw_DetPro, iDw1.GetItemNumber ( 1, "ID_PROD" ), '-DP', 70 )
If lDeb > 0 Then
	sVal =  idw_DetPro.GetItemString ( lDeb, "VAL_CAR" )
	iuoLibelle.Uf_SetValue ( "ZVAR29", sVal )
Else
	iuoLibelle.Uf_SetValue ( "ZVAR29", sVarNonArmee )		 	
End If

// [ISM144182]
F_RechDetPro ( lDeb, lFin, idw_DetPro, iDw1.GetItemNumber ( 1, "ID_PROD" ), '-DP', 136 )
If lDeb > 0 Then
	sVal = Trim ( idw_DetPro.GetItemString ( lDeb, "VAL_CAR") )
	sVal = nvString.of_getkeyvalue (sVal, "ADR_MAIL_PROD", ";")
	iUoLibelle.Uf_SetValue ( "ZVAR51" ,  sVal )  			
End if	

/*------------------------------------------------------------------*/
/* On créé maintenant le blob lui-même										  */
/*------------------------------------------------------------------*/
sChaine = ""
iuoLibelle.Uf_Creer_Chaine ( sChaine, stSpb )

isChaineData = sChaine 

// [MIGPB11] [EMD] : Debut Migration : Forcer la création de Blob en ANSI
//iblBlobData = Blob ( sChaine )
iblBlobData = Blob ( sChaine, EncodingANSI! )
// [MIGPB11] [EMD] : Fin Migration

// [PI052] Récupére le code des variables
/*
If F_CLE_A_TRUE ( "PI052" ) Then
	iuoLibelle.Uf_Recuperer_Tableau_Variable_PI052 ( iTabCodeVar[] )			
	iuoLibelle.Uf_Recuperer_Tableau_Variable ( iTabVariable[ 1 ].sTab [] )	
End If
*/

Return bOk
end function

protected function boolean uf_determinercomposition (long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_DeterminerComposition
//* Auteur			: Fabry JF
//* Date				: 15/06/1999 13:57:00
//* Libellé			: Détermination de la composition des courriers de relance
//*					  soit pour l'assuré ALAX01 soit pour la banque BLAX01
//* Commentaires	: Vu avec Denis : Si l'inter n'est ni A ni B on determine un courrier de 
//*					  relance identique à celui envoyé à l'inter B.
//*
//* Arguments		: Long		alRow			(Val)			// Dossier courant dans Dw1
//*
//* Retourne		: Boolean	True, tout s'est bien passé
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF  19/06/2007	[DCMP070051] Uniformisation des relances avec le nouveau système.
//*-----------------------------------------------------------------

Boolean 		bOk = True
String		sCodInter				// Code de l'interlocuteur
String		sTypeCourrier			// Type de courrier A.. B.. Q..
String		sMes
Long 			lIdProd // #1

sCodInter  		= iDw1.GetItemString ( alRow, "COD_INTER" )
sTypeCourrier  = Left ( iDw1.GetItemString ( alRow, "ID_COUR" ), 1 )

// #1
lIdProd = iDw1.GetItemNumber ( alRow, "ID_PROD" )

isTxtCompo = Space ( 248 )

CHOOSE CASE isTypTrt

	//.. Première relances Automatiques et ponctuelles
	CASE "R1A", "R1U", "R1P"

		CHOOSE CASE sCodInter

			// Assuré	
			CASE "A"

				CHOOSE CASE sTypeCourrier
					
					// Courrier Assuré
					CASE "A"
						isIdCour = "ALAX01"				

					// Questionnaire
					CASE "Q"
						isIdCour = "ALQ001"

				END CHOOSE


			// Banque
			CASE "B"
				isIdCour = "BLAX01"

			// Autre
			CASE ELSE
				isIdCour = "BLAX01"

		END CHOOSE


	// Deuxième relance
	CASE "R2"

		CHOOSE CASE sCodInter
			CASE "A"
				isIdCour = "ALAX02"

			CASE "B"
				isIdCour = "BLAX02"

			CASE ELSE
				isIdCour = "BLAX02"

		END CHOOSE


END CHOOSE


iTrTrans.PS_S01_COUR_PROD_V02 ( lIdProd, isIdCour, isIdCour, isTxtCompo )

stMessage.bTrace = True
If	Not F_Procedure ( stMessage, itrTrans, "PS_S01_COMPOSITION" )	Then

	bOk = False

	sMes = "Problème lors l'execution de PS_S01_COMPOSITION"
	This.uf_EcrireTrace ( 3, "", 0, sMes )

	F_Message ( stMessage )

End If

Return bOk

end function

protected function boolean uf_ecrirecourrierdansarchive (long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_EcrireCourrierDansArchive (Protected)
//* Auteur			: Fabry JF
//* Date				: 15/06/1999 16:26:32
//* Libellé			: Ecriture de l'enregistrement dans ARCHIVE et ARCHIVE_BLOB
//* Commentaires	: 
//*
//* Arguments		: Long		alRow			(Val)			// aRow du dossier à Traiter dans iDw1.
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF    11/10/99 Gestion de l'Id_Adh à Null				  
//* #2  JFF    11/10/99 On Trace uniquement si l'execution de la Procédure
//*							d'insertion s'est bien déroulée.
//* #3  JFF		15/04/04 DCMP 040020 SVE : On fusionne le courrier de relance
//*    JFF   11/01/2011    [DECIMAL_PAPILLON]
//			FPI	28/09/2011	[PM73-2] Code barre courrier sortant
//       JFF   12/06/2014 [PI052]
//       JFF   18/10/2023 [RS6044_REL_MAIL]
//       JFF   30/05/2023 [RS6044_REL_MAIL][BUG] 
//*-----------------------------------------------------------------

Boolean 	bOk = True
Boolean 	bRel1 
Long	  	dcIdSin		
Long	  	dcIdInter
Long	  	dcIdDocOrig // [RS6044_REL_MAIL]
Long	  	dcIdOrdre, lIdentityCourPdf
Long 		lIdArchCourRel // [RS6044_REL_MAIL]
Long 		lIdArchCourOrig // [RS6044_REL_MAIL]
String  	sIdAdh
String  	sCodInter
String  	sNom
String  	sMajPar
String  	sValidePar
String  	sTypBlob 
String  	sIdCourTyp 	
String   sAdrMail // [RS6044_REL_MAIL]
String   sIdCanal // [RS6044_REL_MAIL]
Int		iRet
Decimal {2} dcIdsin2, dcIdInter2, dcIdDoc2
Long lIdProd
String sSQL, sNomFicCompletDOC, sNomFicCompletPDF, sNomFicCompletDOCOrig, sNomFicCompletPDFOrig
long lRet

Boolean bF_CLE_A_TRUE_CONVERT_PDF_STOCK_2 // [CONVERT_PDF_STOCK]
Blob blBlobPdf, bBlobDocCourOrig // [CONVERT_PDF_STOCK]
OLEObject ole_word, ole_doc, ole_field, ole_fields // [CONVERT_PDF_STOCK]
Int lCptField // [CONVERT_PDF_STOCK]
String sDteEdit, sMoisDteEdit  // [CONVERT_PDF_STOCK]
bF_CLE_A_TRUE_CONVERT_PDF_STOCK_2 = F_CLE_A_TRUE ( "CONVERT_PDF_STOCK_2" ) // [CONVERT_PDF_STOCK]

idcIdDoc = -1   // idcId_Doc sera passé par Ref à PS_S02_ARCHIVE_RELANCES.
					 // et reviendra avec le nouvel Id_Doc créé.
/*------------------------------------------------------------------*/
/* Armement de certaines variables.                                 */
/*------------------------------------------------------------------*/
If stGLB.bSaiValEdt Then
	sTypBlob = "DO"
Else
	sTypBlob = "DT"
End If

dcIdSin 		= iDw1.GetItemNumber ( alRow, "ID_SIN"	  )
dcIdInter	= iDw1.GetItemNumber ( alRow, "ID_I" 	  )

// [RS6044_REL_MAIL]
dcIdDocOrig = iDw1.GetItemNumber ( alRow, "ID_DOC"	  ) 
idcIdDoc = dcIdDocOrig 
//	idcIdDoc    = iDw1.GetItemNumber ( alRow, "ID_DOC"	  )  // Armement qui ne sert pas, puisque ser mis à jour en retour de PS_I02_ARCHIVE_RELANCES

dcIdOrdre	= iDw1.GetItemNumber ( alRow, "ID_ORDRE" )
sIdAdh		= iDw1.GetItemString ( alRow, "ID_ADH"   )
sCodInter	= iDw1.GetItemString ( alRow, "COD_INTER")
sNom			= iDw1.GetItemString ( alRow, "NOM_INTER")
sMajPar		= stGlb.sCodOper
sValidePar	= iDw1.GetItemString ( alRow, "VALIDE_PAR")
lIdProd		= iDw1.GetItemNumber ( alRow, "ID_PROD") // [PM73-2]
sIdCourTyp 	= iDw1.GetitemString ( alRow, "ID_COUR" )  // [RS6044_REL_MAIL]

// [RS6044_REL_MAIL]
sAdrMail = Space (128)
SQLCA.PS_S_INTER_ADR_MAIL_INTER ( dcIdSin, dcIdInter, sAdrMail )
ibEnvRelParMail = sAdrMail <> "" 
If ibEnvRelParMail then sIdCanal = "MA" Else sIdCanal = "CO"

/*------------------------------------------------------------------*/
/* #1 ,11/10/99, Gestion de l'Id_Adh à Null					           */
/*------------------------------------------------------------------*/
If IsNull ( sIdAdh ) Then
	sIdAdh = ""
End If


/*------------------------------------------------------------------*/
/* Ecriture de l'enregistrement dans ARCHIVE et ARCHIVE_BLOB.       */
/*------------------------------------------------------------------*/
// [RS5045_REF_MATP]
If F_CLE_A_TRUE ( "RS5045_REF_MATP" ) Then
	

	// [RS6044_REL_MAIL]

	iTrTrans.PS_I02_ARCHIVE_RELANCES_V02 ( 	 &
													 &
	  idtDateDuJour							,&
	  idcIdDoc									,&
	  dcIdSin									,&
	  dcIdInter									,&
	  isIdCour									,&				
	  ilProd										,&
	  dcIdOrdre									,&
	  sIdAdh										,&
	  sCodInter									,&
	  sNom										,&
	  isTxtCompo								,&
	  sValidePar								,&
	  sMajPar									,&
	  sTypBlob									,&
	  isModeleDefaut							,&
	  sIdCanal									,&
	  lIdArchCourRel							&
												)		
Else 
	iTrTrans.PS_I02_ARCHIVE_RELANCES ( 	 &
													 &
	  idtDateDuJour							,&
	  idcIdDoc									,&
	  dcIdSin									,&
	  dcIdInter									,&
	  isIdCour									,&				
	  ilProd										,&
	  dcIdOrdre									,&
	  sIdAdh										,&
	  sCodInter									,&
	  sNom										,&
	  isTxtCompo								,&
	  sValidePar								,&
	  sMajPar									,&
	  sTypBlob									 &
												)		
End If 

If	Not F_Procedure ( stMessage, itrTrans, "PS_I02_ARCHIVE_RELANCES" ) or idcIdDoc < 0 Then

	bOk = False
	F_Commit ( iTrTrans, False )
	F_Message ( stMessage )

Else
	F_Commit ( iTrTrans, True )

	/*------------------------------------------------------------------*/
	/* On trace la commande SQL qui permettra d'annuler les deux        */
	/* INSERT envoyés via la PS précédente (qu'elle ait fonctionné ou   */
	/* pas).																				  */
	/*------------------------------------------------------------------*/
	/*------------------------------------------------------------------*/
	/* #2, 11/10/99, On Trace uniquement si l'execution de la Procédure */
	/* s'est bien déroulée.															  */ 
	/*------------------------------------------------------------------*/

	bOk = This.uf_EcrireTrace ( 2, "INSERT", alRow, "" )

End If

/*------------------------------------------------------------------*/
/* #3 : DCMP 040020 SVE                                             */
/*------------------------------------------------------------------*/
// [PI052]
/*
If F_CLE_A_TRUE ( "PI052" ) Then
	// rattraper ici le PDF de KSL.
	If Not ibPI052_GenEdtKsl Then
		If bOk And stGLB.bSaiValEdt Then
			iRet = This.uf_EcrireCourrierDansArchive_SVE ( dcIdSin, dcIdInter, lIdProd ) // [PM73-2] Ajout de l'id_prod
			If iRet < 0 Then bOk = False
		End If
	End If
Else
*/	
	If bOk And stGLB.bSaiValEdt Then
		iRet = This.uf_EcrireCourrierDansArchive_SVE ( dcIdSin, dcIdInter, lIdProd ) // [PM73-2] Ajout de l'id_prod
		If iRet < 0 Then bOk = False
	End If
// End If

/*------------------------------------------------------------------*/
/* #3 : Selon la méthode on upate le blob de Data ou le blob DOC    */
/*------------------------------------------------------------------*/
If bOk Then
	If stGLB.bSaiValEdt Then
		iblBlob = iblBlobDoc
	Else
		iblBlob = iblBlobData
	End If
	
End If

/*------------------------------------------------------------------*/
/* #3 : A ce moment et selon la méthode SEV ou SVE, iblBlobData     */
/* est armé avec le blob de Data (DT) ou le courrier complet        */
/* fusionné (DO) en SVE.                                            */
/*------------------------------------------------------------------*/
/* On update maintenant le blob.                                    */
/* dcIdDoc a été armé par PS_I02_ARCHIVE_RELANCES						  */
/*------------------------------------------------------------------*/
// [CONVERT_PDF_STOCK]
If bF_CLE_A_TRUE_CONVERT_PDF_STOCK_2 Then
	sNomFicCompletDOC = stGLB.sRepTempo + "SIM2_REL.DOC"
	sNomFicCompletPDF = stGLB.sRepTempo + "SIM2_REL.PDF"

	If Not IsValid ( ole_word ) Then
		ole_word = CREATE OLEObject
		ole_word.ConnectToNewObject ( "Word.Application" )
		ole_word.Visible = FALSE
	End IF 	
	
	// Ouvrir le document Word
	ole_doc = ole_word.Documents.Open ( sNomFicCompletDOC )
	
	// Sauvegarder au format PDF
	// Format 17 = wdFormatPDF
	ole_doc.SaveAs ( sNomFicCompletPDF, 17 )
	
	// Fermer le document
	ole_doc.Close(FALSE)

	SetNull ( blBlobPdf )
	
	F_LireFichierBlob ( blBlobPdf, sNomFicCompletPDF )
End If


If bOk Then
	// [DECIMAL_PAPILLON]
	dcIdsin2 = dec (dcIdSin)
	dcIdInter2 = dec (dcIdInter)
	dcIdDoc2 = Dec ( idcIdDoc )
	UPDATEBLOB	sysadm.archive_blob
	SET			txt_blob		= :iblBlob
	WHERE			id_sin		= :dcIdsin2
	AND			id_inter		= :dcIdInter2
	AND			id_doc		= :dcIdDoc2
	AND			id_typ_blob	= :sTypBlob
	USING			itrTrans;

End If

// [CONVERT_PDF_STOCK]
If bF_CLE_A_TRUE_CONVERT_PDF_STOCK_2 Then
	lRet = itrTrans.PS_I_COURRIER_PDF_AVEC_ID_ARCH ( dcIdsin2, dcIdInter2, stGlb.sCodOper, lIdArchCourRel, lIdentityCourPdf )

	If	lRet <> 0 Or itrTrans.SqlCode <> 0 Or itrTrans.SqlDbCode <> 0	Then
		iRet = -1
		bOk = False
	End If
	
	If iRet = 0 Then iRet = 1
	
	If iRet > 0 Then
		UPDATEBLOB	sysadm.courrier_pdf
		SET			txt_blob 	= :blBlobPdf
		WHERE			id_seq 		= :lIdentityCourPdf
		USING SQLCA		;
	End If  

	If	itrTrans.SqlCode <> 0 Or itrTrans.SqlDbCode <> 0	Then
		iRet = -1
		bOk = False
	End If

End IF 

If	Not F_Procedure ( stMessage, itrTrans, "UPDATEBLOB, uf_EcrireCourrierDansArchive, u_Rl_Sp_Rel_Anc" )	Then
	bOk = False
	F_Commit ( iTrTrans, False )
	F_Message ( stMessage )

Else
	F_Commit ( iTrTrans, True )

	// [CONVERT_PDF_STOCK]
	If bF_CLE_A_TRUE_CONVERT_PDF_STOCK_2 Then
		FileDelete ( sNomFicCompletPDF )
	End If 
End If


// [RS6044_REL_MAIL]
If bOk Then
	// [RS6044_REL_MAIL][BUG] 
	bRel1 = Left ( sIdCourTyp, 1 ) <> "Q" 
	
	// Envoi de la relance
	If ibEnvRelParMail And bRel1 Then

		lIdArchCourOrig = 0			
		CHOOSE CASE isTypTrt
			CASE "R1A", "R1U", "R1P"
				SQLCA.PS_U_AFFECTER_UN_ID_ARCH ( dcIdSin, dcIdInter, dcIdDocOrig, lIdArchCourOrig )
				F_Commit ( SQLCA, SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0 ) 
			
		End CHoose 

		// [CONVERT_PDF_STOCK]
		// Conversion en PDF du courrier d'origne
		If bF_CLE_A_TRUE_CONVERT_PDF_STOCK_2 Then
				SELECTBLOB	txt_blob
						INTO	:bBlobDocCourOrig
						FROM	sysadm.archive_blob
					  WHERE  sysadm.archive_blob.id_sin      = :dcIdSin 
				 		 AND	sysadm.archive_blob.id_inter    = :dcIdInter 
					 	 AND	sysadm.archive_blob.id_doc      = :dcIdDocOrig
						 AND	sysadm.archive_blob.id_typ_blob = 'DO'
					  USING	itrtrans	;
			
				sNomFicCompletDOCOrig = stGLB.sRepTempo + "SIM2_COUR_ORIG.DOC"
				sNomFicCompletPDFOrig = stGLB.sRepTempo + "SIM2_COUR_ORIG.PDF"

				F_EcrireFichierBlob ( bBlobDocCourOrig, sNomFicCompletDOCOrig )
				
				// Ouvrir le document Word
				ole_doc = ole_word.Documents.Open ( sNomFicCompletDOCOrig )

				
				 // Parcourir tous les champs du document
				 ole_fields = ole_doc.Fields

				 sDteEdit = String ( iDw1.GetItemDate ( alRow, "DTE_EDIT" ), "dd/mm/yyyy" ) 
				 sMoisDteEdit = F_Mois_En_Lettre ( Integer ( Mid ( sDteEdit, 4, 2 )))
				 sMoisDteEdit = Lower ( Left ( sMoisDteEdit, 1 ) ) + Right ( sMoisDteEdit, Len ( sMoisDteEdit ) - 1 ) 
				 sDteEdit = Left ( sDteEdit, 2 ) + " " + sMoisDteEdit + " " + Right ( sDteEdit, 4 )
				 
				 // Replacer la date d'édition
				 FOR lCptField = ole_fields.Count TO 1 STEP -1
					  ole_field = ole_fields.Item(lCptField)
			
					  IF Pos(Upper(ole_field.Code.Text), "DATE") > 0 THEN
							ole_field.Select()
							ole_word.Selection.Text = sDteEdit
					  END IF
				 NEXT
				
				// Sauvegarder au format PDF
				// Format 17 = wdFormatPDF
				ole_doc.SaveAs ( sNomFicCompletPDFOrig, 17 )
				
				// Fermer le document
				ole_doc.Close(FALSE)

				If IsValid ( ole_word ) Then 
					ole_word.Quit()
					SetNull ( ole_doc ) 
					ole_word.DisconnectObject()
					DESTROY ole_word	
				End If 
		
				SetNull ( blBlobPdf )
				
				F_LireFichierBlob ( blBlobPdf, sNomFicCompletPDFOrig )

				lIdentityCourPdf = 0
				lRet = itrTrans.PS_I_COURRIER_PDF_AVEC_ID_ARCH ( dcIdSin, dcIdInter, stGlb.sCodOper, lIdArchCourOrig, lIdentityCourPdf )
				
				If	lRet <> 0 Or itrTrans.SqlCode <> 0 Or itrTrans.SqlDbCode <> 0	Then
					iRet = -1
					bOk = False
				End If
				
				If iRet = 0 Then iRet = 1
				
				If iRet > 0 Then
					UPDATEBLOB	sysadm.courrier_pdf
					SET			txt_blob 	= :blBlobPdf
					WHERE			id_seq 		= :lIdentityCourPdf
					USING SQLCA		;
				End If  
				
				If	itrTrans.SqlCode <> 0 Or itrTrans.SqlDbCode <> 0	Then
					iRet = -1
					bOk = False
				End If

				If	Not F_Procedure ( stMessage, itrTrans, "UPDATEBLOB, uf_EcrireCourrierDansArchive, u_Rl_Sp_Rel_Anc" )	Then
					bOk = False
					F_Commit ( iTrTrans, False )
					F_Message ( stMessage )
				
				Else
					F_Commit ( iTrTrans, True )
				
					// [CONVERT_PDF_STOCK]
					FileDelete ( sNomFicCompletDOCOrig )
					FileDelete ( sNomFicCompletPDFOrig )
				End If			

				If bOk Then
					sSql  = "Exec sysadm.PS_I_ENVOYER_RELANCE_PAR_MAIL "
					sSql += String ( dcIdSin ) + ".,"
					sSql += String ( dcIdInter ) + ".,"
					sSql += String ( lIdArchCourRel ) + ","
					sSql += String ( lIdArchCourOrig ) + ","
					sSql += "'" + String ( isIdCour ) + "'"
					
					F_Execute ( sSql, SQLCA )
					F_Commit ( SQLCA, SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0 ) 						
					
				End IF 

		Else			
			sSql  = "Exec sysadm.PS_I_ENVOYER_RELANCE_PAR_MAIL "
			sSql += String ( dcIdSin ) + ".,"
			sSql += String ( dcIdInter ) + ".,"
			sSql += String ( lIdArchCourRel ) + ","
			sSql += String ( lIdArchCourOrig ) + ","
			sSql += "'" + String ( isIdCour ) + "'"
			
			F_Execute ( sSql, SQLCA )
			F_Commit ( SQLCA, SQLCA.SQLCode = 0 And SQLCA.SQLDBCode = 0 ) 				
		End If 
		
	End If 
	
End If 


// [PI052] Ecrire ici l'enreg sur table édition
// [PI052]
/*
If F_CLE_A_TRUE ( "PI052" ) Then
	If ibPI052_GenEdtKsl Then
		sSQL  = "Exec sysadm.PS_I_WCBA_KSL_COUR_RELANCE "
		sSQL += String ( dcIdSin ) + "., "
		sSQL += String ( dcIdInter ) + "., "
		sSQL += String ( idcIdDoc ) + "., "
		sSQL += "'PDF',"
		sSQL += "'" + iTabCleKslEdt [ 1 ] + "',"
		sSQL += "'RELANCE_RELA', "	
		sSQL += String ( ilIdRelKSL )
		
		F_Execute ( sSql, SQLCA )
	End If
	
	If	Not F_Procedure ( stMessage, itrTrans, "PS_I_WCBA_KSL_COUR_RELANCE(RELANCE_RELA), uf_EcrireCourrierDansArchive, u_Rl_Sp_Rel_Anc" )	Then
	
		bOk = False
		F_Commit ( iTrTrans, False )
		F_Message ( stMessage )
	
	Else
		F_Commit ( iTrTrans, True )
	End If	
		
End If
*/
// [PI052]


Return bOk
end function

protected function boolean uf_misajourcourrieroriginal (long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_MajAJourCourrierOriginal (Protected)
//* Auteur			: Fabry JF
//* Date				: 16/06/1999 15:24:45
//* Libellé			: Mis à jour du courrier original.
//* Commentaires	: On update Nbr_Conf à 1
//*
//* Arguments		: Long			alRow				(Val)				Dossier en cours sur Dw_1
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*    JFF   11/01/2011    [DECIMAL_PAPILLON]
//*    JFF   10/11/2023    [OPTIM_TRT_RELANCE]
//*-----------------------------------------------------------------

Boolean bOk = True

Long		dcIdSin			// Sinistre
Long		dcIdInter		// Interlocuteur
Long		dcIdDoc			// n° du document lu sur iDw1 et non pas le dernier Id_Doc présent
								// sur archive pour ce même interlocuteur, car il correspondrait au courrier
								// de relance qui vient juste d'être écrit.
String	sMes, sSql
Decimal {2} dcIdsin2, dcIdInter2, dcIdDoc2



dcIdSin 	 = iDw1.GetItemNumber ( alRow, "ID_SIN" )
dcIdInter = iDw1.GetItemNumber ( alRow, "ID_I"   )
dcIdDoc	 = iDw1.GetItemNumber ( alRow, "ID_DOC" )

/*------------------------------------------------------------------*/
/* On trace la commande SQL qui permettra d'annuler l'UPDATE qui    */
/* suit, en cas de besoin.                                          */
/*------------------------------------------------------------------*/
bOk = This.uf_EcrireTrace ( 2, "UPDATE", alRow, "" )

If bOk Then

	/*------------------------------------------------------------------*/
	/* Pour un update, je ne crée pas une nouvelle PS afin de ne pas    */
	/* alourdir un peu plus u_transaction.                              */
	/*------------------------------------------------------------------*/
	// [DECIMAL_PAPILLON]
	dcIdsin2 = dec (dcIdSin)
	dcIdInter2 = dec (dcIdInter)
	dcIdDoc2 = dec (dcIdDoc)
	UPDATE	sysadm.archive
	SET		nbr_conf  = 1, dte_conf = :idtDateDuJour
	WHERE		id_sin = :dcIdsin2
	AND		id_inter = :dcIdInter2
	AND		id_doc = :dcIdDoc2
	USING		SQLCA;


	// [OPTIM_TRT_RELANCE]
	sSql = "Exec sysadm.PS_D_PRE_TRT_RELANCE " + String ( dcIdsin2 ) + "," + String ( dcIdInter2 ) + ", " + String ( dcIdDoc2 ) 
	F_Execute ( sSql, SQLCA )

	sMes = "Problème sur UPDATE, uf_MajAJourCourrierOriginal, u_Rl_Sp_Rel_Anc."

	stMessage.bTrace = True
	If	Not F_Procedure ( stMessage, itrTrans, sMes )	Then

		bOk = False

		This.uf_EcrireTrace ( 3, "", 0, sMes )

		F_Commit ( iTrTrans, False )
		F_Message ( stMessage )

	Else
		F_Commit ( iTrTrans, True )
	End If
End If

Return bOk
end function

public function boolean uf_ecriretrace (integer aicas, string astypsql, long alrow, string asmessagelibre);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_EcrireTrace 	( Public )
//* Auteur			: Fabry JF
//* Date				: 11/06/1999 10:39:01
//* Libellé			: Ecriture de la trace
//* Commentaires	: - On écrit dans un répertoire de trace, un fichier texte contenant toutes les données de Dw1 (via un SaveAs)
//*					    afin de pouvoir rééditer	la liste si problème lors du lancement du Traitement.
//*					  - On écrit aussi toutes les commandes SQL permettant de "ROLLBACKer" tout ce qui a été écrit en base, en cas de problème.
//*					  
//*
//* Arguments		: Integer		aiCas		(Val)		Cas 1 : - On écrit le contenu de Dw_1 dans la trace
//*																		  - On écrit les données concernant le traitement ( Type de Trt, Dates ...)
//*																Cas 2 : - On écrit toutes les commandes SQL qui serviront à annuler cette session de relances
//*																			 si un problème survenait.		
//*																Cas 3 : - Message libre à trace.
//*
//*					  String			asTypSQL (Val)		Uniquement utilisé pour le CAS 2 :
//*																"UPDATE" : Signifie qu'un update de Nbr_Conf à 1 VA ETRE éffectué sur archive.
//*																"INSERT" : Signifie qu'un enregistrement A ETE inséré sur ARCHIVE et ARCHIBLOB
//*																En fonction de ces deux options, on trace les commandes inverses pour revenir en arrière.
//*															
//*					  Long			alRow					Uniquement utilisé pour le CAS 2 : 
//*																Row du dossier en cours sur Dw_1
//*																	
//*					  String			asMessageLibre		Uniquement utilisé pour le CAS 3 : 
//*																Message à tracer.			
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*  #1 JFF		17/09/99 On vérifie que le fichier de trace n'existe pas déjà
//* 							afin de ne pas l'écraser.
//*-----------------------------------------------------------------


Boolean 	bOk = True
Boolean  bFicExiste = True       // #1 True : Le nom du fichier de trace existe déjà sur disque.
	
String	sRepTraceRel				// Nom du répertoire de trace des relances.
String	sTypBlob						// Typ du blob selon la méthode
Int		iFichier, iEcriture		// Pointeur sur le fichier de trace
Long		lCpt							// Compteur Long
Long		lNbrRow						// Nombre de row dans Dw_1	

/*------------------------------------------------------------------*/
/* Variables pour le cas 2                                          */
/*------------------------------------------------------------------*/
Long		dcIdSin						// Sinistre
Long		dcIdInter					// Interlocuteur
Long		dcIdDoc						// n° du document lu sur iDw1 (ne pas confondre avec idcIdDoc
											// variable d'instance contenant l'Id_Doc du courrier de relance ! )
String	sLigTrace					// Ligne à écrire dans la trace	

dcIdSin 	 = -1
dcIdInter = -1
dcIdDoc   = -1
sLigTrace = ""

If stGLB.bSaiValEdt Then
	sTypBlob = "DO"
Else
	sTypBlob = "DT"
End If

CHOOSE CASE aiCas

	/*------------------------------------------------------------------*/
	/* CAS n° 1 (n'est appelé qu'une seule fois ) :                     */
	/* - On écrit le contenu de Dw_1 dans la trace                      */
	/* - On écrit les données concernant le traitement ( Type de Trt,   */
	/* Dates ...)                                                       */
	/*------------------------------------------------------------------*/
	CASE 1 
		/*------------------------------------------------------------------*/
		/* Récupération du Nom du répertoire de Trace. Si le fichier ini    */
		/* n'est pas accessible, on arrête tout.                            */
		/*------------------------------------------------------------------*/
		sRepTraceRel = ProfileString ( stGlb.sFichierIni, "TRACE", "REP_TRACE_REL", "" )

		If sRepTraceRel = "" Then

			bOk = False
	
			stMessage.bErreurG  = False
			stMessage.sCode	  = "GENE012"
			stMessage.sTitre    = "SIMPA2 - Relances"
			stMessage.Icon	  	  = Exclamation!
			stMessage.Bouton    = Ok!
			stMessage.bTrace    = True
			stMessage.sVar[1]   = "Impossible de lire le nom du répertoire de trace dans le fichier INI."
			stMessage.sVar[1]  += " Le traitement n'est pas lancé."

			F_Message ( stMessage )

		End If


		/*------------------------------------------------------------------*/
		/* Construction du nom de fichier trace.                            */
		/* Si ce nom est mal construit, on arrête tout.						     */
		/*------------------------------------------------------------------*/

		If bOk and Not F_Date ( String ( idtDateDuJour ), 4 ) Then
			bOk = False

			stMessage.bErreurG  = False
			stMessage.sCode	  = "GENE012"
			stMessage.sTitre    = "SIMPA2 - Relances"
			stMessage.Icon	  	  = Exclamation!
			stMessage.Bouton    = Ok!
			stMessage.bTrace    = True
			stMessage.sVar[1]   = "Impossible de construire le nom du fichier de trace car la date du jour n'est pas valide." 
			stMessage.sVar[1]  += " Le traitement n'est pas lancé." 

			F_Message ( stMessage )

		End If

		/*-------------------------------------------------------------------*/
		/* #1 :																					*/
		/* Afin de rentrer dans la boucle, on considère que le nom du fichier*/
		/* de trace existe déjà. On ne sortira de la boucle que si cette     */
		/* info n'est pas vérifiée.													   */
		/*-------------------------------------------------------------------*/
		Do While bOk and bFicExiste

				isNomFicTrace  = ""
				
				/*------------------------------------------------------------------*/
				/* Le nom du fichier de trace est codé de manière à ce qu'il y ait  */
				/* le moins de chance possible pour qu'il soit écrasé au fil des    */
				/* jours.                                                           */
				/* Ex : R1A28540.JFF                                                */
				/* soit R1A    2       8     5        40                            */
				/*      Trt   12j     18h   25min     40s                           */
				/*------------------------------------------------------------------*/
				/* #1 : L'existance du fichier sur disque est testée, afin qu'il n'y*/
				/*      ait pas d'écrasement.													  */
				/*------------------------------------------------------------------*/
	
				isNomFicTrace  = Left ( isTypTrt, 3 )
				isNomFicTrace += Mid  ( String ( Date ( idtDateDuJour) ), 2, 1 )
				isNomFicTrace += Mid  ( String ( Time ( idtDateDuJour) ), 2, 1 )
				isNomFicTrace += Mid  ( String ( Time ( idtDateDuJour) ), 5, 1 )
				isNomFicTrace += Mid  ( String ( Time ( idtDateDuJour) ), 7, 2 )

	
			If isNomFicTrace = "" Then
				bOk = False
		
				stMessage.bErreurG  = False
				stMessage.sCode	  = "GENE012"
				stMessage.sTitre    = "SIMPA2 - Relances"
				stMessage.Icon	  	  = Exclamation!
				stMessage.Bouton    = Ok!
				stMessage.bTrace    = True
				stMessage.sVar[1]   = "Impossible de construire le nom du fichier de trace car la date du jour n'est pas valide." 
				stMessage.sVar[1]  += " Le traitement n'est pas lancé." 
	
				F_Message ( stMessage )
	
			End If
	
			If bOk Then
				isNomFicTrace += "." + stGlb.sCodOper
				isNomFicTrace = sRepTraceRel + isNomFicTrace

				// #1
//Migration PB8-WYNIWYG-03/2006 FM
//				bFicExiste = FileExists ( isNomFicTrace )
				bFicExiste = f_FileExists ( isNomFicTrace )
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If
		Loop 

		/*------------------------------------------------------------------*/
		/* On écrit le contenu de la DataWindow dans le fichier de trace.   */
		/*------------------------------------------------------------------*/
		If bOk Then

			If  iDw1.SaveAs ( isNomFicTrace, TEXT!, TRUE ) = -1 Then
				bOk = False

				stMessage.bErreurG  = False
				stMessage.sCode	  = "GENE012"
				stMessage.sTitre    = "SIMPA2 - Relances"
				stMessage.Icon	  	  = Exclamation!
				stMessage.Bouton    = Ok!
				stMessage.bTrace    = True
				stMessage.sVar[1]   = "Impossible d'écrire le contenu de Dw_1 dans le fichier de trace."
				stMessage.sVar[1]  += " Le traitement n'est pas lancé." 

				F_Message ( stMessage )
			End If
	
		End If

		/*--------------------------------------------------------------------*/
		/* On écrit les données concernant le traitement (Type trt, dates,...)*/
		/*--------------------------------------------------------------------*/
		If bOk Then
			iFichier = FileOpen ( isNomFicTrace, LineMode!, Write!, LockWrite!, Append! )
	
			If iFichier < 0 Then
				bOk = False

				stMessage.bErreurG  = False
				stMessage.sCode	  = "GENE012"
				stMessage.sTitre    = "SIMPA2 - Relances"
				stMessage.Icon	  	  = Exclamation!
				stMessage.Bouton    = Ok!
				stMessage.bTrace    = True
				stMessage.sVar[1]   = "Problème lors de l'ouverture du fichier de trace en écriture."
				stMessage.sVar[1]  += " Le traitement n'est pas lancé." 

				F_Message ( stMessage )

			End If

		End If


		If bOk Then

			FileWrite ( iFichier, Char ( 13 ) ) 
			FileWrite ( iFichier, Char ( 13 ) )		
			FileWrite ( iFichier, Fill ( "*", 91 ) )
			FileWrite ( iFichier, "*                            Données concernant le traitement                             *" )
			FileWrite ( iFichier, Fill ( "*", 91 ) )
			FileWrite ( iFichier, Char ( 13 ) )		


			// On écrit le type de traitement dont il s'agit.
			FileWrite ( iFichier, "Type de traitement : " + isTypTrt )
			FileWrite ( iFichier, "Lancé par          : " + stGlb.sCodOper )			

			If ilProd > 0 Then 
				FileWrite ( iFichier, "Produit            : " + String ( ilProd ) )
			End If	
	
			FileWrite ( iFichier, "Nombre de dossiers : " + String ( ilNbrRowDw1 ) )

			If F_Date ( String ( idtDateDuJour ), 4 ) Then
				FileWrite ( iFichier, "Date du jour       : " + String ( idtDateDuJour ) )
			End If

			CHOOSE CASE isTypTrt
				CASE "SOL"

					If F_Date ( String ( idtDateMaxSolRl ), 4 ) Then
						FileWrite ( iFichier, "Date Max Sold RL   : " + String ( idtDateMaxSolRl ) )
					End If

					If F_Date ( String ( idtDateMaxSolPc ), 4 ) Then
						FileWrite ( iFichier, "Date Max Sold PC   : " + String ( idtDateMaxSolPc ) )
					End If


				CASE ELSE

					If F_Date ( String ( idtDateMin ), 4 ) Then
						FileWrite ( iFichier, "Date Mini          : " + String ( idtDateMin ) )
					End If

					If F_Date ( String ( idtDateMax ), 4 ) Then
						FileWrite ( iFichier, "Date Max           : " + String ( idtDateMax ) )
					End If
		
			END CHOOSE



			FileWrite ( iFichier, Char ( 13 ) ) 
			FileWrite ( iFichier, Char ( 13 ) )		
			FileWrite ( iFichier, Fill ( "*", 91 ) )
			
			CHOOSE CASE isTypTrt
				CASE "R1A", "R1U", "R1P", "R2"
					FileWrite ( iFichier, "*  Commandes SQL permettant de revenir en arrière et d'annuler entièrement le traitement  *" )	
				CASE ELSE
					FileWrite ( iFichier, "*        Pas de commandes SQL, impossible de revenir en arrière pour ce traitement        *" )	
			END CHOOSE


			FileWrite ( iFichier, Fill ( "*", 91 ) )
			FileWrite ( iFichier, Char ( 13 ) )		

			FileClose ( iFichier )

		End If



	/*-------------------------------------------------------------------*/
	/* CAS n° 2 (est appelé autant de fois qu'il y a de dossier dans DW1)*/
	/* - On écrit toutes les commandes SQL qui serviront à annuler       */
	/* cette sessions de relances si un problème survenait.              */
	/*-------------------------------------------------------------------*/
	/*-------------------------------------------------------------------*/
	/* Rappel : dcIdDoc, variable locale contenant l'Id_Doc du courrier  */
	/* original.                                                         */
	/*          idcIdDoc, variable d'instance contenant l'Id_Doc du      */
	/* courrier de relance.                                              */
	/*-------------------------------------------------------------------*/

	CASE 2

			iFichier = FileOpen ( isNomFicTrace, LineMode!, Write!, LockWrite!, Append! )
			
			If iFichier < 0 Then
				bOk = False

				stMessage.bErreurG  = False
				stMessage.sCode	  = "GENE012"
				stMessage.sTitre    = "SIMPA2 - Relances"
				stMessage.Icon	  	  = Exclamation!
				stMessage.Bouton    = Ok!
				stMessage.bTrace    = True
				stMessage.sVar[1]   = "Problème lors de l'ouverture du fichier de trace en écriture."
				stMessage.sVar[1]  += " Le traitement est arrêté." 

				F_Message ( stMessage )

			End If


			If bOk Then

				dcIdSin 	 = iDw1.GetItemNumber ( alRow, "ID_SIN" )
				dcIdInter = iDw1.GetItemNumber ( alRow, "ID_I"   )

				CHOOSE CASE upper ( asTypSQL )

					// "UPDATE" : Signifie qu'un update de Nbr_Conf à 1 va être éffectué sur archive.
					CASE "UPDATE"

						dcIdDoc	 = iDw1.GetItemNumber ( alRow, "ID_DOC" )

						// Voici la commande qui permettra de << ROLLBACKer >>
						sLigTrace = "UPDATE sysadm.archive SET nbr_conf = 0, dte_conf = null "   + &
										"WHERE  id_sin   = " + String ( dcIdSin  )  + &
										" AND   id_inter = " + String ( dcIdInter)  + &
										" AND   id_doc   = " + String ( dcIdDoc  )
				
							
						iEcriture = FileWrite ( iFichier, sLigTrace )

					// "INSERT" : Signifie qu'un enregistrement a été inséré sur ARCHIVE et ARCHIBLOB
					CASE "INSERT"
								
						sLigTrace = "DELETE FROM sysadm.archive_blob " 			  + &
										"WHERE  id_sin   = " + String ( dcIdSin  )  + &
										" AND   id_inter = " + String ( dcIdInter)  + &
										" AND   id_doc   = " + String ( idcIdDoc  ) + &
										" AND   id_typ_blob = '" + sTypBlob + "'"

						iEcriture = FileWrite ( iFichier, sLigTrace )

						If iEcriture > 0 Then
							sLigTrace = "DELETE FROM sysadm.archive " 				  + &
											"WHERE  id_sin   = " + String ( dcIdSin  )  + &
											" AND   id_inter = " + String ( dcIdInter)  + &
											" AND   id_doc   = " + String ( idcIdDoc  )
	
							iEcriture = FileWrite ( iFichier, sLigTrace )
						End If

				END CHOOSE

				If iEcriture <= 0 Then

					bOk = False

					stMessage.bErreurG  = False
					stMessage.sCode	  = "GENE012"
					stMessage.sTitre    = "SIMPA2 - Relances"
					stMessage.Icon	  	  = Exclamation!
					stMessage.Bouton    = Ok!
					stMessage.bTrace    = True
					stMessage.sVar[1]   = "Problème lors de l'écriture des commandes SQL dans le fichier trace."
					stMessage.sVar[1]  += " Le traitement est arrêté." 

				End If
			


			End If		
			

			FileClose ( iFichier )


	/*------------------------------------------------------------------*/
	/* CAS n° 3 : Message libre à Tracer.                               */
	/*------------------------------------------------------------------*/
	CASE 3

			iFichier = FileOpen ( isNomFicTrace, LineMode!, Write!, LockWrite!, Append! )

			If iFichier < 0 Then
				bOk = False

				stMessage.bErreurG  = False
				stMessage.sCode	  = "GENE012"
				stMessage.sTitre    = "SIMPA2 - Relances"
				stMessage.Icon	  	  = Exclamation!
				stMessage.Bouton    = Ok!
				stMessage.bTrace    = True
				stMessage.sVar[1]   = "Problème lors de l'ouverture du fichier de trace en écriture."
				stMessage.sVar[1]  += " Le traitement est arrêté." 

				F_Message ( stMessage )

			End If


			If bOk Then

				iEcriture = FileWrite ( iFichier, asMessageLibre )

				If iEcriture <= 0 Then

					bOk = False
	
					stMessage.bErreurG  = False
					stMessage.sCode	  = "GENE012"
					stMessage.sTitre    = "SIMPA2 - Relances"
					stMessage.Icon	  	  = Exclamation!
					stMessage.Bouton    = Ok!
					stMessage.bTrace    = True
					stMessage.sVar[1]   = "Problème lors de l'écriture dans le fichier trace (Cas 3 )."
					stMessage.sVar[1]  += " Le traitement est arrêté." 

				End If

			End If

			FileClose ( iFichier )


END CHOOSE


Return bOk


end function

protected function boolean uf_chargerdwparaprod ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_ChargerDwParaProd (Protected)
//* Auteur			: Fabry JF
//* Date				: 24/06/1999 17:23:09
//* Libellé			: Chargement du paramètrage
//* Commentaires	: On Charge le paramètrage. (excepté pour les R1P et DR1)
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*    JFF   11/01/2011    [DECIMAL_PAPILLON]
//*-----------------------------------------------------------------

Boolean bOk = True
Int	  iRow
Long	  dcIdSin
Decimal {2} dcIdsin2

idw_DetPro.Retrieve ( iDwProduit.GetItemNumber ( 1, "ID_PROD" ) )
idw_DetPro.Sort ()

CHOOSE CASE isTypTrt

	CASE "R1A", "R1U", "R1T", "R2", "SOL"

		ilProd = iDwProduit.GetItemNumber ( 1, "ID_PROD" )
//		ilProd = iDwProduit.GetItemNumber ( 1, "ID_CODE" ) // JCA - POLE

		iRow	 = iDwParaProd.Retrieve ( ilProd )

		If iRow <> 1 Then
			bOk = False
	
			stMessage.bErreurG = False
			stMessage.sCode	 = "GENE012"
			stMessage.sTitre   = "SIMPA2 - Relances"
			stMessage.Icon	    = Exclamation!
			stMessage.Bouton   = Ok!
			stMessage.bTrace   = False
			stMessage.sVar[1]  = "Problème lors du chargement du paramètrage du produit. Le traitement n'est pas lancé."

			F_Message ( stMessage )
	
		End If


	CASE "R1P", "DR1"
		/*------------------------------------------------------------------*/
		/* La procedure d'insertion du courrier de relance dans la base     */
		/* attend l'idprod, voila pourquoi on va le chercher maintenant.    */
		/* De plus si l'idprod revient à 0, cela nous indique que le        */
		/* sinistre n'existe pas, on ne va pas plus loin alors.             */
		/*------------------------------------------------------------------*/
		
		dcIdSin = iDwSaisieSin.GetItemNumber ( 1, "ID_SIN" )
		ilProd  = 0

		// [DECIMAL_PAPILLON]
		dcIdsin2 = dec (dcIdSin)
		SELECT id_prod
		INTO	 :ilProd
		FROM	 sysadm.sinistre
		WHERE  id_sin = :dcIdSin2
		USING  iTrTrans ;				

		If ilProd = 0 then
			
			bOk = False
	
			stMessage.bErreurG = False
			stMessage.sCode	 = "RELA170"
			stMessage.sTitre   = "SIMPA2 - Relances"
			stMessage.Icon	    = Information!
			stMessage.bTrace 	 = True
			stMessage.Bouton   = Ok!

			F_Message ( stMessage )

		End If


END CHOOSE


Return bOk
end function

protected function boolean uf_detruirepremiererelance ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_DetruirePremiereRelance (Protected)
//* Auteur			: Fabry JF
//* Date				: 24/06/1999 17:43:19
//* Libellé			: Destruction d'une première relance.
//* Commentaires	: Le courrier original ne pourra jamais plus être relancé.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//       JFF   12/06/2014 [PI052]
//*-----------------------------------------------------------------

Boolean  bOk = True, bRet 
String	sMes, sSql
Long		lRow
Long		dcIdSin
Long		dcIdInter
Long		dcIdDoc


lRow    = iDw1.GetSelectedRow ( 0 )

dcIdSin   = iDw1.GetItemNumber ( lRow, "ID_SIN" )
dcIdInter = iDw1.GetItemNumber ( lRow, "ID_I"   )
dcIdDoc   = iDw1.GetItemNumber ( lRow, "ID_DOC" )


/*------------------------------------------------------------------*/
/* On delete le blob sur ARCHIVE_BLOB.                              */
/*------------------------------------------------------------------*/
DELETE FROM sysadm.archive_blob 
WHERE  id_sin      = :dcIdSin
AND    id_inter    = :dcIdInter
AND    id_doc      = :dcIdDoc
AND    id_typ_blob = 'DO'
USING  iTrTrans ;

sMes = "Problème sur DELETE FROM sysadm.archive_blob, uf_DetruirePremiereRelance, u_Rl_Sp_Rel_Anc."


If	Not F_Procedure ( stMessage, itrTrans, sMes )	Then

	bOk = False

	This.uf_EcrireTrace ( 3, "", 0, sMes )

	F_Commit  ( iTrTrans, False )
	F_Message ( stMessage )

End If

/*------------------------------------------------------------------*/
/* On delete le courrier sur ARCHIVE.                               */
/*------------------------------------------------------------------*/
If bOk Then

	DELETE FROM sysadm.archive
	WHERE  id_sin      = :dcIdSin
	AND    id_inter    = :dcIdInter
	AND    id_doc      = :dcIdDoc
	USING  iTrTrans ;

	sMes = "Problème sur DELETE FROM sysadm.archive, uf_DetruirePremiereRelance, u_Rl_Sp_Rel_Anc."

	stMessage.bTrace = True
	If	Not F_Procedure ( stMessage, itrTrans, sMes )	Then

		bOk = False

		This.uf_EcrireTrace ( 3, "", 0, sMes )

		F_Commit ( iTrTrans, False )
		F_Message ( stMessage )

	End If

End If

/*------------------------------------------------------------------*/
/* On laisse la zone nbre_conf du courrier original à 1, de cette   */
/* façons il ne sera jamais relancé.                                */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On commit le tout.                                               */
/*------------------------------------------------------------------*/
If bOk Then

	F_Commit ( iTrTrans, True )
	uf_EcrireTrace ( 3, "", 0, "N° du Row détruit dans la DataWindow : " + String ( lRow ) + ", Sinistre : " + String ( dcIdSin )  )
	iDw1.DeleteRow ( lRow )

End If




Return bOk
end function

protected function boolean uf_solderlesdossiers ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_SolderLesDossiers (Protected)
//* Auteur			: Fabry JF
//* Date				: 28/06/1999 17:13:47
//* Libellé			: Soldage des dossiers
//* Commentaires	: Tous les rows sont sélectionnés et se désélectionne au fur et à mesure 
//*					  de l'avancé du traitement. Cette sélection ne sert à rien puisque les rows
//*					  sont pris séquentiellement via une boucle, mais cela permet de ne pas troubler
//*					  l'utilisateur et de garder la même méthode d'affichage.
//*					  On ne delete pas les Rows, car un rapport de fin est imprimé.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean  bOk = True
Boolean	bTrtBoite
Long		lCpt			// Compteur
Long		lTotRow		// Nombre total de row dans DW1
Long		dcIdSin		// Id_sin à Traiter sur Dw1
String	sAltqueue   // Argument passé par réf à PS_D01_ARCHIVE_SOLDAGE.
                     // Si un travail existe au moment du soldage, on ne solde plus le dossier.
String	sMes, sBoite


lTotRow   = iDw1.RowCount ()
sAltQueue = "N"
iuoDefil.uf_Init ( ltotRow )

lCpt = 1


DO WHILE bOk and lCpt <= lTotRow

	iuoDefil.uf_Progression ( lCpt )

	dcIdSin = iDw1.GetItemNumber ( lCpt, "ID_SIN" )
/*------------------------------------------------------------------*/
/* DGA. Le 21/08/2003.                                              */
/* Gestion des boites archives.                                     */
/*------------------------------------------------------------------*/
	bTrtBoite = This.uf_GestionBoiteArchive ( dcIdSin, lCpt )
	If	Not bTrtBoite	Then

		sMes = "Dossier " + String ( dcIdSin ) + ", Non Soldé, " + "Problème ARCHIVAGE : " + iDw1.GetItemString ( lCpt, "ARCH_CODE" )
		This.uf_EcrireTrace ( 3, "", 0, sMes )

		iDw1.SetItem ( lCpt, "ETAT_TRT", "NON Soldé (Arch)" )

		lCpt ++
		Continue
	End If
/*------------------------------------------------------------------*/
/* On arme le N0_BOITE avec '-1' ou 'CENTRALISE' dans la procédure  */
/* stockée.                                                         */
/*------------------------------------------------------------------*/
	Choose Case iDw1.GetItemString ( lCpt, "ARCH_CODE" )
	Case "Privée"
		sBoite = "-1"
	Case "Centralisé"
		sBoite = "CENTRALISE"
	Case Else
		sBoite = ""
	End Choose

	itrTrans.PS_D01_ARCHIVE_SOLDAGE (	dcIdSin			,	&
													stGlb.sCodOper	,	&
													idtDateDuJour	,	&
													sAltQueue		,	&
													sBoite				&
												)

	stMessage.bTrace = True	
	If	Not F_Procedure ( stMessage, itrTrans, "PS_D01_ARCHIVE_SOLDAGE" ) Then

		bOk  = False
		sMes = "Problème lors du soldage du sinistre " + String ( dcIdSin ) + ", le traitement est arrêté."
		iDw1.SetItem ( lCpt, "ETAT_TRT", "!! ERREUR !!" )
		F_Commit ( iTrTrans, False )
		F_Message ( stMessage )

	End If


	If bOk Then
		F_Commit ( iTrTrans, True )
		iDw1.SelectRow ( lCpt, False )
		iDw1.ScrollToRow ( iDw1.GetSelectedRow ( 0 ) )

		If sAltQueue = "N" Then

			sMes = "Dossier " + String ( dcIdSin ) + ", Soldé."
			iDw1.SetItem ( lCpt, "ETAT_TRT", "Soldé" )

		Else

			sMes = "Dossier " + String ( dcIdSin ) + ", Non Soldé, Travail en cours."
			iDw1.SetItem ( lCpt, "ETAT_TRT", "NON Soldé (trv)" )
	
		End If


	End If

	This.uf_EcrireTrace ( 3, "", 0, sMes )

	lCpt ++


LOOP


Return bOk
end function

public function boolean uf_lancertrt (ref boolean absaisie);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_LancerTrt	(Public)
//* Auteur			: Fabry JF
//* Date				: 11/06/1999 10:23:39
//* Libellé			: Lancement du Traitement.
//* Commentaires	: Cette fonction contient une partie du lancement
//*					  du traitement, la suite est sur ue_Item7 de la fenêtre.
//*
//* Arguments		: Boolean 		abSaisie				(Ref)    Valeur de retour booléenne indiquant que le traitement 
//*																			n'est pas lancé, non pas pour un problème quelconque mais
//*																			pour une saisie invalide.
//*
//* Retourne		: Boolean
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean	bOk = True
String	sNul[]

// [PI052]	
If F_CLE_A_TRUE ( "PI052" ) Then
	This.uf_PI052_DroitParam ( "DESACT" )
End IF
ibTimerPI052 = False
ibFinGenerationPDFOk = False
iTabCleFichier = sNul
iTabCleKslEdt = sNul
iTabCleFichierLocal = sNul 
isCleRep = ""
isExtFicOut = ""

/*
If F_CLE_A_TRUE ( "PI052" ) Then
	Choose Case isTypTrt
		Case "SOL", "DR1"
			// Pas la peine
		Case Else
			This.uf_PI052_DroitParam ( "RECH" ) // [PI052]	
	End Choose 
End If


// [PI052]
If F_CLE_A_TRUE ( "PI052" ) Then
	IF ibPI052_GenEdtKsl Then

		Choose Case isTypTrt
			Case "SOL", "DR1"
				// Pas la peine
			Case Else
				SQLCA.PS_X_Incrementer( "ID_REL_KSL", ilIdRelKSL) // [PI052]	
				
				If SQLCA.SQLCode <> 0 Or SQLCA.SQLDBCode <> 0 or ilIdRelKSL < 0 Then
					F_Commit ( SQLCA, False)
					stMessage.bErreurg = FALSE
					stMessage.Icon      = Exclamation!
					stMessage.sCode   = "SFRP100"
					stMessage.sVar[1]    = String ( SQLCA.SqlDbCode )
					stMessage.sVar[2]    = SQLCA.SqlErrText
					stMessage.sTitre = "ID_REL_KSL, problème"
					F_Message ( stMessage )
					Return False
				Else
					F_Commit ( SQLCA, True)
				End If
		End Choose
	End IF
End IF
*/

CHOOSE CASE isTypTrt

	CASE "R1A", "R1U", "R2"

		bOk 		= This.uf_ControlerSaisie ( 2 )		
		abSaisie = bOk

		If bOk Then
			bOk = This.uf_ChargerDwPolice ()
		End If

		If bOk Then
			bOk = This.uf_EcrireTrace ( 1, "", 0, "" )
		End If 

		If bOk Then
			iDw1.SelectRow ( 0, True )
		End If 

		If bOk Then
			bOk = This.uf_ImprimerListe ()
		End If

		/*
		If bOk Then
			If F_CLE_A_TRUE ( "PI052" ) Then		
				If Not ibPI052_GenEdtKsl Then
					bOk = This.uf_ImprimerListe ()				
				End If 
			Else
				bOk = This.uf_ImprimerListe ()
			End If 
		End If 
		*/
		

	CASE "R1T"


		If bOk Then
			bOk = This.uf_EcrireTrace ( 1, "", 0, "" )
		End If 

		If bOk Then
			bOk = This.uf_ImprimerListe ()
		End If

		/*
		If bOk Then
			If F_CLE_A_TRUE ( "PI052" ) Then		
				If Not ibPI052_GenEdtKsl Then
					bOk = This.uf_ImprimerListe ()				
				End If 
			Else
				bOk = This.uf_ImprimerListe ()
			End If 
		End If 
		*/

	CASE "R1P"

		bOk 		= This.uf_ControlerSaisie ( 2 )		
		abSaisie = bOk

		If bOk Then
			bOk = This.uf_ChargerDwPolice ()
		End If

		If bOk Then
			bOk = This.uf_EcrireTrace ( 1, "", 0, "" )
		End If 

		If bOk Then
			bOk = This.uf_ImprimerListe ()
		End If

		/*
		If bOk Then
			If F_CLE_A_TRUE ( "PI052" ) Then		
				If Not ibPI052_GenEdtKsl Then
					bOk = This.uf_ImprimerListe ()				
				End If 
			Else
				bOk = This.uf_ImprimerListe ()
			End If 
		End If 
		*/

	CASE "DR1"

		bOk 		= This.uf_ControlerSaisie ( 2 )		
		abSaisie = bOk

		If bOk Then
			bOk = This.uf_EcrireTrace ( 1, "", 0, "" )
		End If 

		If bOk Then
			bOk = This.uf_ImprimerListe ()
		End If

		/*
		If bOk Then
			If F_CLE_A_TRUE ( "PI052" ) Then		
				If Not ibPI052_GenEdtKsl Then
					bOk = This.uf_ImprimerListe ()				
				End If 
			Else
				bOk = This.uf_ImprimerListe ()
			End If 
		End If 
		*/

		If bOk Then
			bOk = This.uf_DetruirePremiereRelance ()
		End If 


	CASE "SOL"


		If bOk Then
			bOk = This.uf_EcrireTrace ( 1, "", 0, "" )
		End If 

		If bOk Then
			iDw1.SelectRow ( 0, True )
		End If 

		If bOk Then
			bOk = This.uf_SolderLesDossiers ()

			// On imprime la liste, comme rapport de traitement.
			// (Quelque que soit l'issue du traitement)
			This.Uf_ImprimerListe()

		End If 



END CHOOSE


Return bOk
end function

protected function boolean uf_controlersaisie (integer acas);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_ControlerSaisie (Protected)
//* Auteur			: Fabry JF
//* Date				: 08/06/1999 15:21:03
//* Libellé			: Controle la saisie 
//* Commentaires	: Contrôle de la saisie sur 3 DataWindows différentes.
//*					  à des moments différents, c'est à dire au chargement et au lancement.
//*					  
//*
//* Arguments		: Integer		aCas			(Val)			1 : Contrôle de saisie pour chargement
//*																		2 : Contrôle de saisie pour Lancement
//*
//* Retourne		: Boolean, True tout est renseigné.
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean		bOk = True
String		sText
String		sCol [ 3 ]
String		sErr [ 3 ]
String		sSautLigne

iDwTailleLot.AcceptText()
iDwSaisieSin.AcceptText()

sCol[ 1 ]  = "ID_PROD"			// sur Dw_Produit
sCol[ 2 ]  = "TAILLELOT"		// sur Dw_TailleLot
sCol[ 3 ]  = "ID_SIN"		   // sur Dw_SaisieSin

sErr[ 1 ]  = "- Le produit"
sErr[ 2 ]  = "- La taille du lot"
sErr[ 3 ]  = "- La référence sinistre"


sSautLigne = "~r"
sText 	  = sSautLigne


/*------------------------------------------------------------------*/
/* Contrôle de la saisie au chargement des données, suite au click  */
/* sur le bouton CHARGER.                                           */
/*------------------------------------------------------------------*/
If aCas = 1 Then

 CHOOSE CASE isTypTrt

	CASE "R1A", "R1U", "R2"

		/*------------------------------------------------------------------*/
		/* Contrôle de la saisie sur Dw_Produit                             */
		/*------------------------------------------------------------------*/
		If IsNull ( iDwProduit.GetItemNumber ( 1, sCol[ 1 ] ) ) Then
			bOk = False	
			sText += sErr[ 1 ] + sSautLigne
		End If



	CASE "R1T", "SOL"

		/*------------------------------------------------------------------*/
		/* Contrôle de la saisie sur Dw_Produit                             */
		/*------------------------------------------------------------------*/
		If IsNull ( iDwProduit.GetItemNumber ( 1, sCol[ 1 ] ) ) Then
			bOk = False	
			sText += sErr[ 1 ] + sSautLigne
		End If



	CASE "R1P", "DR1"

		/*------------------------------------------------------------------*/
		/* Contrôle de la saisie sur Dw_SaisieSin									  */
		/*------------------------------------------------------------------*/
		If Not iDwSaisieSin.ibErreur Then

			If IsNull ( iDwSaisieSin.GetItemNumber ( 1, sCol[ 3 ] ) ) Then

				bOk = False	
				sText += sErr[ 3 ] + sSautLigne
				iDwSaisieSin.SetFocus ()

			End If

		Else
	
			bOk = False	
			iDwSaisieSin.ibErreur = False
			iDwSaisieSin.SetFocus ()

		End If


 END CHOOSE

End If


/*------------------------------------------------------------------*/
/* Contrôle de la saisie au lancement du traitement, suite au       */
/* click sur le(s) boutons LANCER, DETRUIRE, SOLDER.                */
/*------------------------------------------------------------------*/
If aCas = 2 Then

 CHOOSE CASE isTypTrt

	CASE "R1A", "R1U", "R2"

		/*------------------------------------------------------------------*/
		/* Contrôle de la saisie sur Dw_TailleLot                           */
		/*------------------------------------------------------------------*/
		If Not iDwTailleLot.ibErreur Then

			If IsNull ( iDwTailleLot.GetItemNumber ( 1, sCol [ 2 ] ) ) Then
	
				bOk = False	
				sText += sErr[ 2 ] + sSautLigne
				iDwTailleLot.SetFocus ()

			End If

		Else
	
			bOk = False	
			iDwTailleLot.ibErreur = False
			iDwTailleLot.SetFocus ()

		End If



	CASE "R1P", "DR1"

		/*------------------------------------------------------------------*/
		/* Contrôle de la sélection d'un courrier									  */
		/*------------------------------------------------------------------*/

		If iDw1.GetSelectedRow ( 0 ) = 0 Then

			bOk = False	

			stMessage.bErreurG = False
			stMessage.sCode	 = "RELA150"
			stMessage.sTitre   = "SIMPA2 - Relances"
			stMessage.Icon	    = Information!
			stMessage.Bouton   = Ok!
			stMessage.bTrace 	 = False
			F_Message ( stMessage )
	
		End IF


 END CHOOSE

End If




If sText <> sSautLigne Then

	stMessage.bErreurG = False
	stMessage.sCode	 = "GENE001"
	stMessage.sTitre   = "SIMPA2 - Relances"
	stMessage.Icon	    = Information!
	stMessage.Bouton   = Ok!
	stMessage.sVar[1]  = sText

	F_Message ( stMessage )	

End If



Return bOk 
end function

private function boolean uf_gestionboitearchive (long alidsin, long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Sp_Rel_Anc::uf_GestionBoiteArchive			(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 26/08/2003 10:03:22
//* Libellé			: 
//* Commentaires	: On s'occupe de la gestion des boites à archive
//*
//* Arguments		: Long		alIdSin			(Val)	Référénce Sinistre en cours de traitement
//*					  Long		alLigne			(Val)	N° de la ligne en cours de traitement
//*
//* Retourne		: Boolean			TRUE 	= Tout se passe bien
//*										 	FALSE	= Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1 	 JCA   22/08/2006   Suppression chargement DetPro déporté sur uf_preparer_consulter
//*-----------------------------------------------------------------

Long lDeb, lFin, lIdProd, lIdCie, lIdProfil, lIdTypArch, lNbrHisto
String sBoiteCourante, sCode
Boolean bRet

bRet = TRUE

/*------------------------------------------------------------------*/
/* DGA. Le 21/08/2003.                                              */
/* Gestion des boites archives.                                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/*   /\        J'ajoute une colonne sur la DW dw_1. (ARCH_CODE).    */
/*  /!!\       Mais je ne touche pas à la procédure stockée         */
/* / !! \      DW_S06_ARCHIVE_SOLDAGE.                              */
/* ------                                                           */
/*------------------------------------------------------------------*/
idw_BoiteArchive.Reset ()

//* #1
/*------------------------------------------------------------------*/
/* Chargement de la table DET_PRO s'il existe aucune ligne.         */
/*------------------------------------------------------------------*/
//If	idw_DetPro.RowCount () = 0	Then
//	idw_DetPro.Retrieve ()
//	idw_DetPro.Sort ()
//End If

/*------------------------------------------------------------------*/
/* Le code produit est déjà armé en variable d'instance.            */
/*------------------------------------------------------------------*/
lIdProd		= ilProd

F_RechDetPro ( lDeb, lFin, idw_DetPro, lIdProd, "-DP", 4 )
If	lDeb > 0	Then
/*------------------------------------------------------------------*/
/* On va armer toutes les valeurs nécessaires dans la DW            */
/* (PROCEDURE PS_S01_BOITE_ARCHIVE).                                */
/*------------------------------------------------------------------*/
	idw_BoiteArchive.Retrieve ( alIdSin, stGLB.sCodOper )
/*------------------------------------------------------------------*/
/* Récupération des données impossible.                             */
/*------------------------------------------------------------------*/
	If	idw_BoiteArchive.RowCount () <> 1	Then 
		bRet = FALSE
		sCode		= "BARC005"
	Else
		lIdCie 			= idw_BoiteArchive.GetItemNumber ( 1, "ID_CIE" )
		lIdProfil		= idw_BoiteArchive.GetItemNumber ( 1, "ID_PROFIL" )
		lIdTypArch		= idw_BoiteArchive.GetItemNumber ( 1, "ID_TYP_ARCH" )
		sBoiteCourante	= idw_BoiteArchive.GetItemString ( 1, "ID_BOITE_COURANTE" )
	End If
/*------------------------------------------------------------------*/
/* Impossible de déterminer la compagnie d'assurance.               */
/*------------------------------------------------------------------*/
	If	bRet And lIdCie = -1	Then
		bRet = FALSE
		sCode		= "BARC010"
	End If
/*------------------------------------------------------------------*/
/* Le profil n'existe pas pour ce produit/compagnie.                */
/*------------------------------------------------------------------*/
	If	bRet And lIdProfil = -1	Then
		bRet = FALSE
		sCode		= "BARC015"
	End If
/*------------------------------------------------------------------*/
/* Il existe plusieurs boites ouvertes en même temps pour un        */
/* gestionnaire donné dans le cas d'une méthode PRIVEE.             */
/*------------------------------------------------------------------*/
	If bRet And lIdTypArch = 1 And sBoiteCourante = "ERREUR 01"	Then
		bRet = FALSE
		sCode		= "BARC020"
	End If
/*------------------------------------------------------------------*/
/* Dans le cas d'une méthode PRIVEE, on arme le N° de boite à -1.   */
/*------------------------------------------------------------------*/
	If bRet And lIdTypArch = 1	Then
		idw_BoiteArchive.SetItem ( 1, "NO_BOITE", "-1" )
		sCode = "Privée"
	End If
/*------------------------------------------------------------------*/
/* Dans le cas d'une méthode CENTRALISEE, on arme le N° de boite    */
/* avec un libellé précis.                                          */
/*------------------------------------------------------------------*/
	If bRet And lIdTypArch = 2	Then
		idw_BoiteArchive.SetItem ( 1, "NO_BOITE", "CENTRALISE" )
		sCode = "Centralisé"
	End If
End If

If	Not IsNull ( sCode )	Then iDw1.SetItem ( alLigne, "ARCH_CODE", sCode )

Return ( bRet )
end function

public function string uf_get_libprod ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Get_LibProd
//* Auteur			: PLJ
//* Date				: 26/03/2004
//* Libellé			: 
//* Commentaires	: Récupération du libellé de produit ayant permis de charger
//*                 le soldage
//*					  
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Return isLibProd 

end function

public subroutine uf_initialiser_anc (ref u_datawindow adwproduit, ref u_datawindow adwtaillelot, ref u_datawindow adwsaisiesin, ref u_datawindow_accueil adw1, ref datawindow adwparaprod, ref datawindow adwpolice, ref datawindow adwcivilite, string astyptrt, ref u_libelle_dga auolibelle, ref u_transaction atrtrans, ref u_barredefil auodefil, ref datawindow adw_boitearchive, ref datawindow adw_detpro, ref datawindow adwgencourrier, ref datawindow adwautorisation);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Initialiser_Anc	(Public)
//* Auteur			: Fabry JF
//* Date				: 08/06/1999 13:44:02
//* Libellé			: Initialisation de la fenêtre ancêtre
//* Commentaires	: Cette initialisation sera commune à toutes les fenêtres descendantes.
//*					  - R1A  --> Premières Relances Automatiques.
//*									 Edite les premières relances des courriers Qxxxx, xCxPxx, APART1
//*
//*					  - R1U  --> Premières Relances Automatiques pour les garanties UF avec Dem. Pces. à la banque.
//*								  	 Suite DCMP000285 B. Levesque, Edite les premières relances des courriers Qxxxx, xCxPxx, APART1
//*
//*					  - R1T  --> Premières Relances Particulières
//*                            Edite une LISTE des courriers qui sont différents de Qxxxx, xCxPxx, APART1
//*                            Après un contrôle visuel par la consultation, ces courriers pourront être
//*									 Relancés par la fenêtre des relances ponctuelles.
//*
//*					  - R1P  --> Premières Relances Ponctuelles.
//*									 Edite une première relance d'un courrier (n'ayant jamais été relancé), sans tenir
//*									 compte du paramètrage.
//*
//*					  - DR1  --> Annuler (Détruire) une première relance.
//*									 Destruction d'une première relance, notamment pour les APART1. Une fois la relance détruite
//*									 le courrier original ne pourra jamais plus être relancé.
//*
//*					  - R2   --> Deuxièmes Relances.				
//*									 
//*					  - SOL  --> soldages des dossiers
//*
//* Arguments		: u_DataWindow					aDwProduit			(Ref) // Sélection du produit
//*					  u_DataWindow					aDwTailleLot		(Ref)	// Taille du lot d'édition
//*					  u_DataWindow					aDwSaisieSinot		(Ref)	// Saisie d'un numéro de sinistre
//*					  u_DataWindow_Accueil		aDw1					(Ref) // Dw_1 principale
//*					  DataWindow					aDwParaProd			(Ref) // DataWindow récupérant le param. du prod. Sélect.
//*					  Datawindow					aDwPolice			(Ref) // DataWindow récupérant les polices, Cie.
//*					  Datawindow					aDwCivilite			(Ref) // Dw des civilités (long, court)
//*					  String							asTypTrt				(Val) // Type de Relances
//*					  u_libelle_dga				auoLibelle			(Ref) // Objet servant à construire le blob
//*					  u_Transaction				aTrTrans				(Ref) // Objet de transaction
//*					  u_BarreDefil					auoDefil				(Ref) // Jauge
//*					  DataWindow					adw_BoiteArchive	(Ref) // DW pour la gestion des boites archives
//*					  DataWindow					adw_DetPro			(Ref) // DW sur DET_PRO
//*				 	  DataWindow					adwGenCourrier		(Réf) // Dw Gen Cour SVE DCMP 040020
//*					  Datawindow					adwAutorisation   (Réf) // Dw des autorisation pour la Sign Elec.
//* Retourne		: 
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date			Modification
//* #1	JCA	28/08/2006	chargement de det_pro		
//*      JFF   28/04/2021   [OPTIM_MENU_EDT][RS-331]
//       JFF   26/04/2023   [RS5045_REF_MATP]
//*-----------------------------------------------------------------
DataWindowChild		dwChild

/*------------------------------------------------------------------*/
/* Affectation des Arguments, aux Instances.             			  */
/*------------------------------------------------------------------*/
iDwProduit	 = aDwProduit
iDwTailleLot = aDwTailleLot
iDwSaisieSin = aDwSaisieSin 
iDw1			 = aDw1
iDwParaProd  = aDwParaProd
iDwPolice	 = aDwPolice
iDwCivilite	 = aDwCivilite
idwGenCourrier = adwGenCourrier		
isTypTrt		 = asTypTrt
iuoLibelle	 = auoLibelle
iTrTrans		 = aTrTrans
iuoDefil		 = auoDefil
/*------------------------------------------------------------------*/
/* DGA. Le 21/08/2003.                                              */
/* Gestion des boites archives.                                     */
/*------------------------------------------------------------------*/
idw_BoiteArchive = adw_BoiteArchive
idw_BoiteArchive.SetTransObject ( itrTrans )

idwAutorisation = adwAutorisation
idwAutorisation.SetTransObject ( itrTrans )
idwAutorisation.Retrieve ( "*", -100 )

/*------------------------------------------------------------------*/
/* Initialisation du le signature électronique.                     */
/*------------------------------------------------------------------*/
isRepSig	= ProfileString ( stGLB.sFichierIni, "EDITION", "REP_SIGNATURE", "K:\SIGNPERS\" )
isFmtSig	= ProfileString ( stGLB.sFichierIni, "EDITION", "FMT_SIGNATURE", "TIF" )

isModeleDefaut = ProfileString ( stGLB.sFichierIni, "EDITION", "MODELE",  "" ) // [RS5045_REF_MATP]

idw_DetPro = adw_DetPro
idw_DetPro.SetTransObject ( itrTrans )

/*------------------------------------------------------------------*/
/* On arme une variable contenant le répertoire Windows             */
/*------------------------------------------------------------------*/
//u_DeclarationFuncky uoDeclarationFuncky //[I037] Migration FUNCKy
//uoDeclarationFuncky = Create u_DeclarationFuncky
//isRepWin = uoDeclarationFuncky.Uf_WinDir ()
//Destroy uoDeclarationFuncky

/*------------------------------------------------------------------*/
/* Initialisation des Dw.                                           */
/*------------------------------------------------------------------*/
iDwProduit.SetTransObject	 ( iTrTrans )
iDwParaProd.SetTransObject  ( iTrTrans )
iDwPolice.SetTransObject 	 ( iTrTrans )
iDwTailleLot.SetTransObject ( iTrTrans )
iDwCivilite.SetTransObject  ( iTrTrans )
iDwSaisieSin.SetTransObject ( iTrTrans )

// On Ramène dans la Dw1 toutes les lignes du select.
iDw1.ilMaxLig = 0
iuoDefil.uf_Init ( 0 )

/*------------------------------------------------------------------*/
/* Choix du dataobject en fonction du traitement de relance.        */
/*------------------------------------------------------------------*/
CHOOSE CASE isTypTrt
	
	/*------------------------------------------------------------------*/
	/* 1ères Relances Automatiques                                      */
	/*------------------------------------------------------------------*/
	CASE "R1A"
		iDw1.DataObject = "D_SP_REL1_AUTO"
		
		iiTailleDuLot = 25


	/*------------------------------------------------------------------*/
	/* 1ères Relances Automatiques Gti Uf avec Dem. Pces BQ             */
	/*------------------------------------------------------------------*/
	CASE "R1U"
		iDw1.DataObject = "D_SP_REL1_AUTO_UFBQ"
		
		iiTailleDuLot = 25


	/*------------------------------------------------------------------*/
	/* 1ères Relances Particulières												  */
	/*------------------------------------------------------------------*/
	CASE "R1T"
		iDw1.DataObject = "D_SP_REL1_PART"


	/*------------------------------------------------------------------*/
	/* 1ères Relances Ponctuelles                                       */
	/*------------------------------------------------------------------*/
	CASE "R1P"
		iDw1.DataObject = "D_SP_REL1_PONC"
		
		iiTailleDuLot = 1
		

	/*------------------------------------------------------------------*/
	/* Déestruction d'une première relance.                             */
	/*------------------------------------------------------------------*/
	CASE "DR1"
		iDw1.DataObject = "D_SP_REL1_ANNUL"


	/*------------------------------------------------------------------*/
	/* 2èmes Relances Automatiques                                      */
	/*------------------------------------------------------------------*/
	CASE "R2"
		iDw1.DataObject = "D_SP_REL2"
		
		iiTailleDuLot = 50


	/*------------------------------------------------------------------*/
	/* Soldage des dossiers															  */
	/*------------------------------------------------------------------*/
	CASE "SOL"
		iDw1.DataObject = "D_SP_SOLDAGE"
		


END CHOOSE

/*------------------------------------------------------------------*/
/* Regroupement des actions communes.										  */
/*------------------------------------------------------------------*/
CHOOSE CASE isTypTrt

	CASE "R1A", "R1U", "R2"

      idwProduit.GetChild ( "ID_PROD", dwChild )
//		iDwProduit.GetChild ( "ID_CODE", dwChild  ) // JCA - POLE

      dwChild.SetTransObject ( itrTrans )
		
		// [OPTIM_MENU_EDT][RS-331]
      dwChild.Retrieve( isTypTrt )			

		// [OPTIM_MENU_EDT][RS-331]
		If dwChild.RowCount () > 0 Then
			iDwProduit.InsertRow ( 0 )
			iDwProduit.SetItem ( 1, "ID_PROD", stNul.Dcm )
		Else
			Choose Case isTypTrt
				Case "R1A"
					stMessage.sTitre		= "Premières relances automatiques"
					stMessage.sVar[1]		= "première relance automatique"
				Case "R1U"
					stMessage.sTitre		= "Premières relances UF"
					stMessage.sVar[1]		= "première relance UF"
				Case "R2"
					stMessage.sTitre		= "Deuxièmes relances"
					stMessage.sVar[1]		= "deuxième relance"
			End CHoose 

			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "RELA200"
			
			F_Message ( stMessage )			
		End IF 
//		iDwProduit.SetItem ( 1, "ID_CODE", stNul.Dcm ) // JCA -POLE

		iDwTailleLot.InsertRow ( 0 )
		iDwTailleLot.SetItem ( 1, "TAILLELOT", iiTailleDuLot )

		iDwCivilite.Retrieve ( "-CI", "-CL" )

		iDw1.GetChild ( "COD_INTER", dwChild )
		dwChild.SetTransObject ( iTrTrans )
		dwChild.Retrieve ( "-IN" )

		iDwProduit.Show ()	
		iDwProduit.SetFocus ()


	CASE "R1T"

      idwProduit.GetChild ( "ID_PROD", dwChild )
//		iDwProduit.GetChild ( "ID_CODE", dwChild  ) // JCA - POLE

      dwChild.SetTransObject ( itrTrans )
      dwChild.Retrieve()
		iDwProduit.InsertRow ( 0 )
		iDwProduit.SetItem ( 1, "ID_PROD", stNul.Dcm )
//		iDwProduit.SetItem ( 1, "ID_CODE", stNul.Dcm ) // JCA -POLE

		iDw1.GetChild ( "COD_INTER", dwChild )
		dwChild.SetTransObject ( iTrTrans )
		dwChild.Retrieve ( "-IN" )

		iDwProduit.Show ()	
		iDwProduit.SetFocus ()


	CASE "R1P"

      idwProduit.GetChild ( "ID_PROD", dwChild )
//		iDwProduit.GetChild ( "ID_CODE", dwChild  ) // JCA - POLE

      dwChild.SetTransObject ( itrTrans )
      dwChild.Retrieve()
		iDwProduit.InsertRow ( 0 )
		iDwProduit.SetItem ( 1, "ID_PROD", stNul.Dcm )
//		iDwProduit.SetItem ( 1, "ID_CODE", stNul.Dcm ) // JCA -POLE

		iDwTailleLot.InsertRow ( 0 )
		iDwTailleLot.SetItem ( 1, "TAILLELOT", iiTailleDuLot )

		iDwCivilite.Retrieve ( "-CI", "-CL" )

		iDw1.GetChild ( "COD_INTER", dwChild )
		dwChild.SetTransObject ( iTrTrans )
		dwChild.Retrieve ( "-IN" )

		iDwSaisieSin.InsertRow ( 0 )
		iDwSaisieSin.Show()	
		iDwSaisieSin.SetFocus ()



	CASE "DR1"

		iDw1.GetChild ( "COD_INTER", dwChild )
		dwChild.SetTransObject ( iTrTrans )
		dwChild.Retrieve ( "-IN" )

		iDwSaisieSin.InsertRow ( 0 )
		iDwSaisieSin.Show()	
		iDwSaisieSin.SetFocus ()



	CASE "SOL"

      idwProduit.GetChild ( "ID_PROD", dwChild )
//		iDwProduit.GetChild ( "ID_CODE", dwChild  ) // JCA - POLE

      dwChild.SetTransObject ( itrTrans )
      dwChild.Retrieve()
		iDwProduit.InsertRow ( 0 )
		iDwProduit.SetItem ( 1, "ID_PROD", stNul.Dcm )
//		iDwProduit.SetItem ( 1, "ID_CODE", stNul.Dcm ) // JCA -POLE

		iDwProduit.Show ()	
		iDwProduit.SetFocus ()



END CHOOSE


/*------------------------------------------------------------------*/
/* On Initialise Dw_1 et on cache son Header.                       */
/*------------------------------------------------------------------*/
iDw1.SetTransObject ( iTrTrans )
This.uf_CacherTextDw1 ( "OUI" )

/*------------------------------------------------------------------*/
/* On cache le pied de Dw_1.                                        */
/*------------------------------------------------------------------*/
iiHautFooter = Integer ( iDw1.Describe("DataWindow.Footer.Height") )
iDw1.Modify ("datawindow.Footer.Height=0")

iDw1.Show ()

end subroutine

private subroutine uf_initialiser_sigelec (long alidprod, string ascodoper);//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_RelAnc::uf_Initialiser_SigElec (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 05/04/2004 17:03:43
//* Libellé       : Gestion de la signature électronique.
//* Commentaires  : 
//*
//* Arguments     : Long		alIdProd			Val 
//*					  String		asCodOper		Val
//*
//* Retourne      : Rien 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1  MADM  04/08/06  Projet DNTMAIL1/2 Mails sortant en remplacement des courriers
//*
//*-----------------------------------------------------------------

String sFic, sBin
Boolean bVal, bDroitSigElec

/*------------------------------------------------------------------*/
/* Immediatement par défaut on alloue une signature SPB             */
/*------------------------------------------------------------------*/
isFicSig = isRepSig + "DEFAUT." + isFmtSig

/*------------------------------------------------------------------*/
/* y a-t-il alors une signature par défaut pour ce produit ? 		  */
/*------------------------------------------------------------------*/
sFic = isRepSig + String ( alIdProd ) + "\DEFAUT." + isFmtSig
//Migration PB8-WYNIWYG-03/2006 FM
//If FileExists ( sFic ) Then
If f_FileExists ( sFic ) Then
//Fin Migration PB8-WYNIWYG-03/2006 FM
	isFicSig = sFic
End If

/*-------------------------------------------------------------------*/
/* Le Gestionnaire qui a écrit le courrier d'origine a-t-il le droit */
/* d'utiliser la signature personnalisée ?                           */
/*-------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/* #1 : Ajout de l'identifiant interlocuteur à la fonction uf_GetAutorisation */
/*----------------------------------------------------------------------------*/
This.uf_GetAutorisation ( "", sBIN, bVal, bVal, bVal, alIdProd, asCodOper, -1 )
bDroitSigElec = Mid ( sBIN, 8, 1 ) = "1" 

If bDroitSigElec Then

	sFic = isRepSig + asCodOper + "." + isFmtSig

//Migration PB8-WYNIWYG-03/2006 FM
//	If FileExists ( sFic ) Then
	If f_FileExists ( sFic ) Then
//Fin Migration PB8-WYNIWYG-03/2006 FM
		isFicSig = sFic
	End If

End If

/*------------------------------------------------------------------*/
/* On remplace "\" par "\\" pour interprétation correcte dans word  */
/*------------------------------------------------------------------*/
isFicSig  = F_Remplace ( isFicSig, "\", "\\" )



end subroutine

public function long uf_zn_taillelot (integer acas);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Zn_TailleLot	  (Public)
//* Auteur			: Fabry JF
//* Date				: 11/06/1999 16:01:20
//* Libellé			: Contrôle de la zone Dw_TailleLot
//* Commentaires	: (ItemChanged de Dw_TailleLot)
//*
//* Arguments		: Int			aCas			(Val)			1 --> Contrôle de la zone
//*																   2 --> Gestion de l'erreur
//*
//Migration PB8-WYNIWYG-03/2006 FM
////* Retourne		: Rien
//*	Retourne		: long  résultat du SetActionCode
//Fin Migration PB8-WYNIWYG-03/2006 FM
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Int 	iVal, iActionCode
String	sVal
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Contôle de la zone (ItemChanged).                                */
/*------------------------------------------------------------------*/
If aCas = 1 Then

	iVal = Integer ( iDwTailleLot.GetText () )
	iActioncode = 0

	If ( iVal < 1 ) or ( iVal > iiTailleDuLot )  Then
		iActionCode = 1
	Else
		iActionCode = 0 
	End If

//Migration PB8-WYNIWYG-03/2006 FM
//	iDwTailleLot.SetActionCode ( iActionCode )
	ll_ret = iActionCode
//Fin Migration PB8-WYNIWYG-03/2006 FM

End If

/*------------------------------------------------------------------*/
/* Gestion de l'erreur (ItemError).                                 */
/*------------------------------------------------------------------*/
If aCas = 2 and iDwTailleLot.ibErreur Then

	stMessage.bErreurG	= False
	stMessage.sCode	  	= "RELA120"
	stMessage.sTitre  	= "SIMPA2 - Relances"
	stMessage.Icon	  		= Information!
	stMessage.Bouton  	= Ok!
	stMessage.bTrace 		= False
	stMessage.sVar[1]  	= String ( iiTailleDuLot )

	F_Message ( stMessage )

	// On remet la zone à null
	iDwTailleLot.iiReset = 1
	iDwTailleLot.uf_Reinitialiser ()

End If
//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end function

public function long uf_zn_refsin (integer acas);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Zn_RefSin	  (Public)
//* Auteur			: Fabry JF
//* Date				: 23/06/1999 16:01:20
//* Libellé			: Contrôle de la zone Id_Sin 
//* Commentaires	: (ItemChanged de Dw_SaisieSin)
//*
//* Arguments		: Int			aCas			(Val)			1 --> Contrôle de la zone
//*																   2 --> Gestion de l'erreur
//*
//Migration PB8-WYNIWYG-03/2006 FM
////* Retourne		: Rien
//*	Retourne		: long  résultat du SetActionCode
//Fin Migration PB8-WYNIWYG-03/2006 FM
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long		lVal
Int 	   iActionCode
String	sVal
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Contôle de la zone (ItemChanged).                                */
/*------------------------------------------------------------------*/
If aCas = 1 Then

	sVal = iDwSaisieSin.GetText ()
	lVal = Long ( sVal )
	iActioncode = 0

	If Not IsNumber ( sVal ) or lVal < 0  Then
		iActionCode = 1
	Else
		iActionCode = 0 
	End If
//Migration PB8-WYNIWYG-03/2006 FM
//	iDwSaisieSin.SetActionCode ( iActionCode )
	ll_ret = iActionCode
//Fin Migration PB8-WYNIWYG-03/2006 FM

End If

/*------------------------------------------------------------------*/
/* Gestion de l'erreur (ItemError).                                 */
/*------------------------------------------------------------------*/
If aCas = 2 and iDwSaisieSin.ibErreur Then

	stMessage.bErreurG	= False
	stMessage.sCode	  	= "RELA160"
	stMessage.sTitre  	= "SIMPA2 - Relances"
	stMessage.Icon	  		= Information!
	stMessage.bTrace 		= False
	stMessage.Bouton  	= Ok!

	F_Message ( stMessage )

	iDwSaisieSin.iiReset = 1
	iDwSaisieSin.uf_Reinitialiser ()

End If
//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end function

public subroutine uf_getautorisation (string asidnatcour, ref string asbin, ref boolean abmodifcour, ref boolean abvalauto, ref boolean abvalidation, long alidprod, string ascodoper, integer aiidi);//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_Rel_Anc::uf_GetAutorisation (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 02/03/2004 10:01:09
//* Libellé       : Lecture des droits d'autorisation/refus, pour ce gestionnaire et 
//*					  ce produit (ou tout produit), permettant de modifier le contenu des courriers.
//*					  Le BIN de retour indique également si le gestionnaire est en validation
//*					  autonome ou pas.
//* Commentaires  :  ! MAINTENANCE A FAIRE AUSSI L'OBJET DE SINISTRE !
//*
//* Arguments     : 	String		asIdNatCour		val	Nature du courrier composé et à analyser
//*						String		asBIN				réf	Bin de retour (voir ci-dessous décodage)
//*						Boolean		abModifCour		réf	TRUE : Le courrier composé peut être modifié	et donc sauvegardé.
//*						Boolean		abValAuto		réf	TRUE : Le gestionnaire est en mode Validation autonome
//*						Boolean		abValidation	réf	TRUE : Le gestionnaire a le droit de Valider (phase validation)
//*						Long			alIdProd			Val	Code Produit
//*						String		asCodOper		Val	Code User
//							Integer     aiIdi				Val   Code Interlocuteur
//*
//*						Décodage du BIN de 6 chiffres à découper sous la forme
//*					   1er    0/1     à 1 --> Autoriser modif Cr. Questionnaire 
//*					   2ème   0/1     à 1 --> Autoriser modif Cr. Dem. Pièce
//*					   3ème   0/1     à 1 --> Autoriser modif Cr. Prise en charge
//*					   4ème   0/1     à 1 --> Autoriser modif Cr. Refus
//*					   5ème   0/1     à 1 --> Autoriser modif Cr. Réglement
//*                  6ème   0/1     à 1 --> Autoriser Validation autonome
//*					   7ème	 0/1		à 1 --> Autoriser Phase Validation
//*					   8ème	 0/1		à 1 --> Autoriser Signature électronique
//*						9ème	 0/1		à 1 --> Autoriser Gestionnaire DSC
//*					   10ème	 0/1		à 1 --> Autoriser Nom&Prénom gestionnaire sur Courrier
//*					   11ème	 0/1		à 1 --> Autoriser Aucune signature
//*						12ème  0/1     à 1 --> Autoriser envoi mail
//*                  13ème  0/1     à 1 --> Autoriser modif mail
//*						14ème  0/1     à 1 --> Autoriser modif mail Réglement
//*						15ème  0/1     à 1 --> Autoriser modif mail Refus
//*						16ème  0/1     à 1 --> Autoriser envoi mail Cr. Particulier	 
//*
//*					  ex BIN : 0110101
//*
//* Retourne      : RIEN
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1   MADM   04/08/2006	  Projet DNTMAIL1/2 Mails sortant en remplacement des courriers
//*
//*-----------------------------------------------------------------

String sFiltre, sTabDroit[], sFindOrig, sIdProd, sFindTrt, sAltSuiviMail
Long   lTotTab, lTotAuto, lCpt, lRow
Boolean bFin

/*------------------------------------------------------------------*/
/* Définiton des droits.                                            */
/*------------------------------------------------------------------*/
sTabDroit [1] = "1"		// Autoriser modif Cr. Questionnaire 
sTabDroit [2] = "2"		// Autoriser modif Cr. Dem. Pièce
sTabDroit [3] = "3"		// Autoriser modif Cr. Prise en charge
sTabDroit [4] = "4"		// Autoriser modif Cr. Refus
sTabDroit [5] = "5"		// Autoriser modif Cr. Réglement
sTabDroit [6] = "6"		// Autoriser Validation autonome
sTabDroit [7] = "7"		// Autoriser à Valider (phase validation)
sTabDroit [8] = "8"		// Autoriser à utiliser la signature électronique.
sTabDroit [9] = "9"		// Autoriser Gestionnaire DSC.
sTabDroit [10] = "10"	// Autoriser Nom&Prénom gestionnaire sur courrier
sTabDroit [11] = "11"	// Autoriser Aucune signature

/*------------------------------------------------------------------*/
/* #1 04/08/2006 MADM Définiton des nouveaux  droits.               */
/*------------------------------------------------------------------*/
sTabDroit [12] = "12"		// Autoriser envoi mail
sTabDroit [13] = "13"		// Autoriser modif mail
sTabDroit [14] = "14"		// Autoriser modif mail Réglement
sTabDroit [15] = "15"		// Autoriser modif mail Refus
sTabDroit [16] = "16"		// Autoriser envoi mail Cr. Particulier	


idwAutorisation.SetFilter ( "ID_OPER = '" + Upper ( asCodOper ) + "' AND ( ID_PROD = -1 OR ID_PROD = " + String ( alIdProd ) + " )" )
idwAutorisation.Filter ()

asBIN   		= ""
abModifCour = FALSE
sIdProd = String ( alIdProd )
asIdNatCour = Upper ( asIdNatCour )

sFindOrig   = "ID_OPER = '" + Upper ( asCodOper ) + "' AND " + &
				  "ID_NAT_OPER = "

lTotTab = UpperBound ( sTabDroit )

lTotAuto = idwAutorisation.RowCount ()
/*------------------------------------------------------------------*/
/* A-t-on le droit de modifier les questionnaires ?                 */
/*------------------------------------------------------------------*/
For lCpt = 1 To lTotTab

	/*------------------------------------------------------------------*/
	/* Recherche d'abord si un droit d'autorisation particulier existe  */
	/* pour le produit.                                                 */
	/*------------------------------------------------------------------*/
	sFindTrt = sFindOrig + sTabDroit [ lCpt ] + " AND ID_PROD = " + sIdProd
	lRow = idwAutorisation.Find ( sFindTrt, 1, lTotAuto )

	/*------------------------------------------------------------------*/
	/* On affecte le droit d'autorisation au bin.                       */
	/*------------------------------------------------------------------*/
	If lRow > 0 Then 
		asBIN += "1"
		Continue
	End If

	/*------------------------------------------------------------------*/
	/* Recherche si un droit de refus particulier existe pour le produit*/
	/*------------------------------------------------------------------*/
	sFindTrt = sFindOrig + String ( Integer ( sTabDroit [ lCpt ] ) + 100 ) + " AND ID_PROD = " + sIdProd
	lRow = idwAutorisation.Find ( sFindTrt, 1, lTotAuto )
	/*------------------------------------------------------------------*/
	/* On affecte le droit de refus au bin.                             */
	/*------------------------------------------------------------------*/
	If lRow > 0 Then 
		asBIN += "0"
		Continue
	End If

	/*------------------------------------------------------------------*/
	/* S'il n'y a aucun droit particulier pour ce produit, y a-t-il     */
	/* alors un droit par défaut.                                       */
	/*------------------------------------------------------------------*/
	sFindTrt = sFindOrig + sTabDroit [ lCpt ] + " AND ID_PROD = -1"
	lRow = idwAutorisation.Find ( sFindTrt, 1, lTotAuto ) 

	/*------------------------------------------------------------------*/
	/* On affecte le droit d'autorisation au bin.                       */
	/*------------------------------------------------------------------*/
	If lRow > 0 Then 
		asBIN += "1"
		Continue
	End If

	sFindTrt = sFindOrig + String ( Integer ( sTabDroit [ lCpt ] ) + 100 ) + " AND ID_PROD = -1"
	lRow = idwAutorisation.Find ( sFindTrt, 1, lTotAuto ) 

	/*------------------------------------------------------------------*/
	/* On affecte le droit de refus au bin.                             */
	/*------------------------------------------------------------------*/
	If lRow > 0 Then 
		asBIN += "0"
		Continue
	End If
	
	/*------------------------------------------------------------------*/
	/* Sinon si aucun droit n'est affecté, c'est par défaut un refus de */
	/* modifier.                                                        */
	/*------------------------------------------------------------------*/
	asBIN += "0"

Next	

/*------------------------------------------------------------------*/
/* Correction du BIN pour le cas de certaines incohérence.          */
/*------------------------------------------------------------------*/
/* Impossible d'avoir 8 et 11 en même temps et pourtant le          */
/* paramètrage permet de le faire.                                  */
/*------------------------------------------------------------------*/
If Mid ( asBIN, 8, 1 ) = "1" And Mid ( asBIN, 11, 1 ) = "1" Then
	sFindTrt = sFindOrig + sTabDroit [ 8 ] + " AND ID_PROD = " + sIdProd
	lRow = idwAutorisation.Find ( sFindTrt, 1, lTotAuto )

	/*------------------------------------------------------------------*/
	/* 8 est plus fort dans ce cas puiqu'associé au produit, on annule  */
	/* donc 11.																			  */
	/*------------------------------------------------------------------*/
	If lRow > 0 Then
		asBIN = Replace ( asBIN, 11, 1, "0" )
	Else
		asBIN = Replace ( asBIN, 8, 1, "0" )
	End If
End If

/*------------------------------------------------------------------*/
/* Armement Boolean de validation                                   */
/*------------------------------------------------------------------*/
abValAuto = Mid ( asBIN, 6, 1 ) = "1"
abValidation = Mid ( asBIN, 7, 1 ) = "1"

/*------------------------------------------------------------------*/
/* A-t-on un code courrier à analyser ?                             */
/*------------------------------------------------------------------*/
If asIdNatCour <> "" Then

	bFin = False
	
	/*------------------------------------------------------------------*/
	/* #1 MADM 04/08/2006 : gestion des droits 13 Autoriser Modif Mail  */
	/* en fonction du canal de l'interlocuteur                          */
	/*------------------------------------------------------------------*/
	 lRow = idw1.Find ( "ID_I = " + String ( aiIdi ), 1, idw1.Rowcount () )
	/*------------------------------------------------------------------*/
	/* #1 On détermine le canal (Mail ou courrier) de l'interlocuteur   */
	/*------------------------------------------------------------------*/
	 sAltSuiviMail = idw1.GetItemString (lRow , "ALT_SUIVI_MAIL")
	//[DNTMAIL1-2_MEP_DEF] Forçage à supprimer lors de la MEP finale.
	sAltSuiviMail = "N"
	
	/*--------------------------------------------------------------------------------------------*/
	/* #1 Si le canal est égal à Mail et que le droit 13 est égal à 1 alors abModifCour est vraie */
	/*--------------------------------------------------------------------------------------------*/ 
	 abModifCour = sAltSuiviMail <> "O" Or ( sAltSuiviMail =  "O" And Mid ( asBIN, 13, 1 ) = "1" ) 

	/*------------------------------------------------------------------*/
	/* Est-ce CP, une relance, une info ? si oui c'est Ok				     */
	/*------------------------------------------------------------------*/
	If abModifCour And Not bFin Then
		Choose Case Left ( asIdNatCour, 2 ) 
			Case "AP", "AL", "BL"
				bFin = TRUE
		End Choose 	
	End If

	If abModifCour And Not bFin Then	
		Choose Case Left ( asIdNatCour, 1 ) 
			Case "Z"
				bFin = TRUE
		End Choose 	
	End If
		
	/*------------------------------------------------------------------*/
	/* Est-ce un questionnaire ?	                                      */
	/*------------------------------------------------------------------*/
	If abModifCour And Not bFin Then 
		If Left ( asIdNatCour, 1 ) = "Q" Then
			abModifCour = Mid ( asBIN, 1, 1 ) = "1" 
			bFin = TRUE
		End If
	End If

	/*------------------------------------------------------------------*/
	/* Sinon autre courrier automatique.                                */
	/*------------------------------------------------------------------*/
	If Not bFin And abModifCour Then 

		/*------------------------------------------------------------------*/
		/* Droit à modifier les courriers de réglement                      */
		/*------------------------------------------------------------------*/
		If abModifCour Then
			Choose Case Mid ( asIdNatCour, 3, 1 )
				Case "C", "V"   // Chéque et virement
				/*------------------------------------------------------------------*/
				/* #1 Si le canal est différent de Mail alors abModifCour est vraie */
				/*------------------------------------------------------------------*/ 
				 If sAltSuiviMail <> "O" Then
					 abModifCour = Mid ( asBIN, 5, 1 ) = "1" 
				 Else
				/*--------------------------------------------------------------------------------------------*/
				/* #1 Si le canal est égal à Mail et que le droit 14 est égal à 1 alors abModifCour est vraie */
				/*--------------------------------------------------------------------------------------------*/
				    abModifCour = Mid ( asBIN, 5, 1 ) = "1" And Mid ( asBIN, 14, 1 ) = "1" 
				 End If	 

				/*------------------------------------------------------------------*/
				/* Droit à modifier les courriers de prise en charge                */
				/*------------------------------------------------------------------*/
				Case "E"
					abModifCour = Mid ( asBIN, 3, 1 ) = "1" 
	
			End Choose
		End If	
		/*------------------------------------------------------------------*/
		/* Droit à modifier les courriers de demande de pièce.				  */
		/*------------------------------------------------------------------*/
		If abModifCour Then
			If Mid ( asIdNatCour, 4, 1 ) = "P" Then
				abModifCour = Mid ( asBIN, 2, 1 ) = "1" 
			End If
		End If
		
		/*------------------------------------------------------------------*/
		/* Droit à modifier les courriers de refus.								  */
		/*------------------------------------------------------------------*/
		If abModifCour Then
			If Mid ( asIdNatCour, 5, 1 ) = "R" Then
				/*------------------------------------------------------------------*/
				/* #1 Si le canal est différent de Mail alors abModifCour est vraie */
				/*------------------------------------------------------------------*/ 
				If sAltSuiviMail <> "O" Then
					abModifCour = Mid ( asBIN, 4, 1 ) = "1" 
				Else 
					/*--------------------------------------------------------------------------------------------*/
					/* #1 Si le canal est égal à Mail et que le droit 15 est égal à 1 alors abModifCour est vraie */
					/*--------------------------------------------------------------------------------------------*/
					abModifCour = Mid ( asBIN, 4, 1 ) = "1" And Mid ( asBIN, 15, 1 ) = "1"
				End If
			End If
		End If
		
		
	End If
End If


idwAutorisation.SetFilter ( "" )
idwAutorisation.Filter ()

end subroutine

private function integer uf_ecrirecourrierdansarchive_sve (decimal adcidsin, decimal adcidinter, long alidprod);//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_Rel_Anc::uf_EcrireCourrierDansArchive (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 15/04/2004 15:35:25
//* Libellé       : Gestion particulière pour la SVE
//* Commentaires  : Ecriture du courrier de relance fusionné, en base type DO
//*
//* Arguments     : Decimal		adcIdSin			Val
//*					  Decimal		adcIdInter		Val
//*
//* Retourne      : Integer
//*
//*-----------------------------------------------------------------
//* MAJ  PAR      Date	     Modification
//* #1 	DGA      19/09/2006 Gestion d'un répertoire temporaire DCMP-060643
//* #..   ...   ../../....
//*		FPI		29/09/2011	[PM73-2] Ajout du paramètre id_prod
//       JFF      18/10/2023 [RS6044_REL_MAIL]
//*-----------------------------------------------------------------
Int iRow, iRet
n_Cst_Edition_Courrier	nvGenCourrier
Boolean bRet
String sBac

iRet = 1
SetNull ( iblBlobDoc )


Choose Case Left ( isIdCour, 1 )
	Case "Q" // Questionnaire
		sBac = "MILIEU"
	Case "B" // Courrier Banque
		sBac = "HAUT"
	Case Else	// Courrier Assuré + autres
		sBac = "BAS"
End Choose	

// [RS6044_REL_MAIL]
sBac = "0"

/*------------------------------------------------------------------*/
/* Insertion d'un enregistrement populisé dans DwGenCourrier.       */
/*------------------------------------------------------------------*/
idwGenCourrier.Reset ()
iRow = idwGenCourrier.InsertRow ( 0 )
idwGenCourrier.SetItem ( iRow, "ID_SIN"		, adcIdSin )
idwGenCourrier.SetItem ( iRow, "ID_INTER"		, adcIdInter )
idwGenCourrier.SetItem ( iRow, "ID_SEQ"		, idcIdDoc )
idwGenCourrier.SetItem ( iRow, "ID_COUR"		, isIdCour )
idwGenCourrier.SetItem ( iRow, "TXT_COMPO"	, isTxtCompo )
idwGenCourrier.SetItem ( iRow, "TXT_DATA"		, isChaineData )
idwGenCourrier.SetItem ( iRow, "TITRE"			, "SIM2_REL.DOC" )
idwGenCourrier.SetItem ( iRow, "COD_BAC"		, sBac )
idwGenCourrier.SetItem ( iRow, "ALT_GEN"		, "O" )
idwGenCourrier.SetItem ( iRow, "ALT_GESTION_PART", "N" )
idwGenCourrier.SetItem ( iRow, "ID_INTER_DOUBLE_PROV", -1 )

// JCA en cours...
idwGenCourrier.SetItem ( iRow, "ID_CANAL", "CO" )

// [PRBLE_PATCH_MS_WORD][20210601]
This.uf_GestionRepCourrierLocal ()

/*------------------------------------------------------------------*/
/* Génération du courrier fusionné.                                 */
/*------------------------------------------------------------------*/
nvGenCourrier = Create N_Cst_Edition_Courrier

nvGenCourrier.uf_Initialiser ( "E" )
If nvGenCourrier.uf_InitialiserWord ( FALSE ) = 1 then 

/*------------------------------------------------------------------*/
/* Génération dans ouverture du Word par la suite (FALSE)           */
/*------------------------------------------------------------------*/
	iRet = nvGenCourrier.uf_Generer_Courrier ( idwGenCourrier, FALSE )
End If

Destroy nvGenCourrier

/*------------------------------------------------------------------*/
/* On relit le fichier DOC complet fusionné et c'est ce fichier qui */
/* ira en base en type DO.       											  */
/*------------------------------------------------------------------*/
If iRet > 0 Then 
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//	bRet = F_LireFichierBlob ( iblBlobDoc, stGlb.sWinDir + "\TEMP\SIM2_REL.DOC" )
	bRet = F_LireFichierBlob ( iblBlobDoc, stGLB.sRepTempo + "SIM2_REL.DOC" )

	If Not bRet Or Len ( iblBlobDoc ) < 5 Then iRet = -1

End If

/*------------------------------------------------------------------*/
/* On laisse le fichier stGlb.sWinDir + "\TEMP\SIM2_REL.DOC" sur    */
/* disque, on ne le supprime pas, il sera repris sur l'evt          */
/* spb_imprimerdossier sur la fenêtre.                              */
/*------------------------------------------------------------------*/

Return ( iRet )
end function

public function string uf_format_numtel (string asvarstr);//*-----------------------------------------------------------------
//*
//* Fonction		: u_gs_sp_relance::uf_format_numtel
//* Auteur			: F. Pinon
//* Date				: 28/09/2009 17:23:39
//* Libellé			: 
//* Commentaires	: [DCMP090552] Gestion des numéros de tel étranger
//*
//* Arguments		: asVarStr
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

String sVar1
Long	 lTot, lCpt

asVarStr = Trim ( asVarStr ) 

lTot = Len ( asVarStr ) 
sVar1 = ""
For lCpt = 1 to lTot
	If Mid ( asVarStr, lCpt, 1 ) <> " " Then sVar1 += Mid ( asVarStr, lCpt, 1 )
Next

lTot = Len ( sVar1 )
asVarStr = ""

Choose Case Left ( sVar1, 2 )
	Case "08"
		For lCpt = 1 to lTot

			CHOOSE CASE lCpt
				CASE 2,5,8
					asVarStr += " "
			END CHOOSE

			asVarStr += Mid ( sVar1, lCpt, 1 )
		Next
		
	Case "09"
		For lCpt = 1 to lTot

			CHOOSE CASE lCpt
				CASE 5,8
					asVarStr += " "
			END CHOOSE

			asVarStr += Mid ( sVar1, lCpt, 1 )
		Next
	Case Else
		For lCpt = 1 to lTot

			CHOOSE CASE lCpt
				CASE 3,5,7,9
					asVarStr += " "
			END CHOOSE

			asVarStr += Mid ( sVar1, lCpt, 1 )
		Next
End Choose

Return asVarStr
end function

public function integer uf_pi052_generer_xml (long alrow);//*-----------------------------------------------------------------
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
String sTG_Courrier, sTG_IdCourj, sTG_IdIDB, sTG_IdInter, sTG_CodeInter
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
Long   lIdProd, dcIdSin

iRet = 1


lIdProd = iDw1.GetItemNumber ( alRow, "ID_PROD") 
dcIdSin = iDw1.GetItemNumber ( alRow, "ID_SIN" )

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
sTG_Tableau    = "tableaux"
sTG_Tpiece		= "T1"
sTG_Trefus		= "T2"
sTG_TparaPlaf	= "T3"
sTG_TparaInter	= "T4"
sTG_Col1			= "col1"
sTG_Col2			= "col2"
sTG_TpieceLig  = "t1Lig"
sTG_TrefusLig  = "t2Lig"
sTG_TparaPlafLig = "t3Lig"
sTG_TparaInterLig = "t4Lig"

sExtFicXML	   = ".XML"							
isExtFicOut		= ".PDF"

// ex : 20140313141054
sCleFicFixXML  =  String ( dcIdSin ) + "_"
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

sPathPDF		= ProfileString ( stGlb.sFichierIni, "EDITION", "REP_PI052_KSL_REL_RECUP_PDF", "" )
sCleFicFixPDF  = sPathPDF + isCleRep + "\" + sCleFicFixXML					
					
sPathXML	   = ProfileString ( stGlb.sFichierIni, "EDITION", "REP_PI052_KSL_REL_DEPOT_XML", "" )
sCleFicFixXML  = sPathXML + sCleFicFixXML 

If IsNull ( sPathXML ) Or Len ( sPathXML ) <= 0 Then
	stMessage.sTitre		= "Chemin PI052 Relance XML Absent"
	stMessage.Icon			= StopSign!
	stMessage.sCode		= "PI52012"
	stMessage.sVar [1]   = sCleFicFixXML
	F_Message ( stMessage )
	Return -1
End If 

lTotVar = UpperBound ( iTabVariable )

// Boucle sur le tableau des variable pour chaque inter
For lCpt_iTabVar = 1 To lTotVar 

	sIdInter = String ( lCpt_iTabVar - 1, "00" )
	
	sCodInter = iDw1.GetItemString ( alRow, "COD_INTER" )
	sIdCourJ  = ""
	If IsNull ( sIdCourJ  ) Then sIdCourJ = ""
	sIdIDb    = ""
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

			sIdcour = isIdCour
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
/*
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
*/

	

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
			Return -1
		End If 
		
		// Incrément du nombre de tour, pour avoir le temps total : nbre tour x délai
		ilNbreTour ++
		
		sPathPDF	   = ProfileString ( stGlb.sFichierIni, "EDITION", "REP_PI052_KSL_REL_RECUP_PDF", "" )
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

public function integer uf_pi052 (string ascas, long alrow);//*-----------------------------------------------------------------
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
		iRet = This.uf_PI052_Generer_XML ( alRow )
		
		// Déclenchement du timer d'attente de réception des courriers PDF toutes les K_FrequenceTimer secondes
		If iRet > 0 Then
			iRet = This.uf_PI052_GestionTimer ( "DECLENCHER_TIMER", K_FrequenceTimer  ) 
		End If

	Case "2EME_TOUR"
		
		// Récupération des PDF en local et suppression structure sur server
		iRet = This.uf_PI052_RecuperationCourrier ()

		// [PI052]	
// 	ibPI052_GenEdtKsl = False  Gêne à cet endroit pour la majdu Blob
		ibTimerPI052 = False
		ibFinGenerationPDFOk = False
		iTabCleFichier = sNul
//		iTabCleFichierLocal = sNul  j'aurai besoin des noms des fichiers pour les blober.
//		isCleRep = "" Gêne à cet endroit pour la majdu Blob

		// On remet le Enabled sur Valider et Disabled sur contrôler
		Yield ()


End Choose 

Return iRet
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

Choose Case asCas 
	Case "RECH", "INFO"
	
		// Recherche si le produit (et User en recette) est éligible au PI052
		F_RechDetPro ( lDeb, lFin, idw_DetPro, iDw1.GetItemNumber( 1, "ID_PROD" ), "-DP", 262 )
		If lDeb > 0 Then
			
			sVal = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "PHASE_RECETTE", ";")
			
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
	


Return bPI052_GenEdtKsl



end function

public function boolean uf_creercourrierrelance (long aldossier, ref string asidcourrel, ref string astxtcomporel, ref blob ablblobdata, boolean ab2emetourpi052);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_CreerCourrierRelance  (Public)
//* Auteur			: Fabry JF
//* Date				: 14/06/1999 11:36:12
//* Libellé			: Création du courrier de relance.
//* Commentaires	: appel sur ue_ImprimerDossier.
//*
//* Arguments		: Long			alDossier			(Val)			Row du dossier à traiter sur Dw_1
//*					  String			asIdCourRel			(Ref)			Retourne l'Id_Cour du courrier de relance.
//*					  String			asTxtCompoRel		(Ref)			Retourne la composition du courrier de relance.
//*					  Blob			aBlBlobData			(Ref)			Retourne le Blob du courrier de relance.
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//       JFF   12/06/2014 [PI052]
//       JFF   18/10/2023 [RS6044_REL_MAIL]
//*-----------------------------------------------------------------

Boolean bOk = True
Integer iRet

asIdCourRel		= stNul.Str
asTxtCompoRel  = stNul.Str
aBlBlobData    = stNul.Blb

ibEnvRelParMail = False  // [RS6044_REL_MAIL]

/*------------------------------------------------------------------*/
/* Création du Blob stocké	dans iblBlobData								  */
/*------------------------------------------------------------------*/

// [PI052]
/*
If F_CLE_A_TRUE ( "PI052" ) Then
	If ibPI052_GenEdtKsl Then
		If Not ab2EmeTourPI052 Then
			bOk = This.Uf_CreerBlob ( alDossier )
			
			If bOk Then
				bOk = This.Uf_DeterminerComposition ( alDossier )
			End If			
			
			If bOk Then 
				iRet = uf_PI052 ( "1ER_TOUR", alDossier )
				bOk = iRet > 0 
			End If
			Return bOk
		Else
			iRet = uf_PI052 ( "2EME_TOUR", alDossier )
			bOk = iRet > 0 
		End IF
	Else 
		bOk = This.Uf_CreerBlob ( alDossier )		
	End If
Else
*/	
	bOk = This.Uf_CreerBlob ( alDossier )
//End If

/*------------------------------------------------------------------*/
/* Détermination du courrier, en fonction de l'interlocuteur et du  */
/* type de traitement, et détermination de la composition du code   */
/* courrier.                                                        */
/*------------------------------------------------------------------*/
// [PI052]
If bOk And Not ibPI052_GenEdtKsl Then
	bOk = This.Uf_DeterminerComposition ( alDossier )
End If

/*------------------------------------------------------------------*/
/* Ecriture du courrier dans Archive et Archive_Blob.               */
/*------------------------------------------------------------------*/
If bOk Then
	bOk = This.Uf_EcrireCourrierDansArchive ( alDossier )
End If

/*------------------------------------------------------------------*/
/* A ce moment voici l'état des choses si tout s'est bien déroulé   */
/* :                                                                */
/* - Le courrier de relance est écrit en base dans archive et       */
/* archive_blob.                                                    */
/* - la zone nbr_conf du courrier original n'est pas encore         */
/* updaté à 1.                                                      */
/* - le courrier n'est pas encore édité.                            */
/*                                                                  */
/* On Update maintenant NBR_CONF à 1.                               */
/*------------------------------------------------------------------*/
If bOk Then
	bOk = This.Uf_MisAJourCourrierOriginal ( alDossier )
End If


/*------------------------------------------------------------------*/
/* Si tout s'est déroulé normalement on arme les arguments passés   */
/* par références qui seront utilisés dans ue_ImprimerDossier.      */
/*------------------------------------------------------------------*/
If bOk Then

	asIdCourRel		= isIdCour
	asTxtCompoRel  = isTxtCompo
	ablBlobData		= iblBlobData

End If 


// [RS6044_REL_MAIL]
If ibEnvRelParMail Then bOk = False // Tag pour dire que c'est parti par mail, exploité sur spb_imprimerdossier

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
Boolean bRet 

iRet = 1
iTabCleFichierLocal = sNul 

sRepTmp	= stGLB.sRepTempo
sPathPDF	= ProfileString ( stGlb.sFichierIni, "EDITION", "REP_PI052_KSL_REL_RECUP_PDF", "" )
lTot = UpperBound ( iTabCleFichier )

// Récup et copie en local.
For lCpt = 1 To lTot
	sFicPDFSource = iTabCleFichier [ lCpt ] 
	sFicPDFDest   = F_Remplace ( iTabCleFichier [ lCpt ], sPathPDF + isCleRep + "\", sRepTmp )

	iTabCleKslEdt [ lCpt ] = F_Remplace ( sFicPDFDest, sRepTmp, "" )
	iTabCleKslEdt [ lCpt ] = F_Remplace ( iTabCleKslEdt [ lCpt ], isExtFicOut, "" )

	sFicPDFDest   = stGLB.sRepTempo + "SIM2_REL.DOC"
	iTabCleFichierLocal [ lCpt ] = sFicPDFDest
	
   iRet = FileCopy ( sFicPDFSource, sFicPDFDest , TRUE )

	If iRet <= 0 Then Exit	
		
	bRet = F_LireFichierBlob ( iblBlobDoc, sFicPDFDest )

	If Not bRet Or Len ( iblBlobDoc ) < 5 Then iRet = -1		


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

public function Long uf_get_iddoc ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Get_IdDoc
//* Auteur			: JFF
//* Date				: 20/06/2019
//* Libellé			: 
//* Commentaires	: [PM425-1] Récupération du numéro d'IdDoc
//*                 
//*					  
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Return idcIdDoc 

end function

public function boolean uf_gestionrepcourrierlocal ();//*-----------------------------------------------------------------
//*
//* Fonction      : uf_GestionRepCourrierLocal  (PRIVATE)
//* Auteur        : JFF
//* Date          : 01/06/2021
//* Libellé       : Gestion du répertoire local du courrier sous c:\temp\trg\courrier
//* Commentaires  : 	[PRBLE_PATCH_MS_WORD]
//*
//* Arguments     : 
//*
//* Retourne      : Boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Boolean bRet
String sNomDir, sCheminRepCourrierLocal
Integer iRet

sCheminRepCourrierLocal = stGlb.sRepTempo + "COURRIER\"

bRet = True

CreateDirectory ( sCheminRepCourrierLocal )
stGLB.uoWin.Uf_FEraseAll ( sCheminRepCourrierLocal + "*.*")


// This.uf_creerdossier(sCheminRepCourrierLocal)
If RemoveDirectory ( sCheminRepCourrierLocal ) < 0 Then 

	stMessage.sTitre		= "Répertoire Courrier Local"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sVar[1]    = sCheminRepCourrierLocal
	stMessage.sCode		= "WSIN869"

	F_Message ( stMessage ) 	
	
	Return False 
End If 

Yield () // Impératif !

If CreateDirectory ( sCheminRepCourrierLocal ) < 0 Then 
	stMessage.sTitre		= "Répertoire Courrier Local"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sVar[1]    = sCheminRepCourrierLocal
	stMessage.sCode		= "WSIN870"

	F_Message ( stMessage ) 	

	Return False 
End If 

Return bRet 

end function

on u_gs_sp_rel_anc.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_gs_sp_rel_anc.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

