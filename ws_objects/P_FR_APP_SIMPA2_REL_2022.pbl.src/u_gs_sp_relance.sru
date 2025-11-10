$PBExportHeader$u_gs_sp_relance.sru
$PBExportComments$---} Objet pour les Relances et le Soldage.
forward
global type u_gs_sp_relance from nonvisualobject
end type
end forward

global type u_gs_sp_relance from nonvisualobject
end type
global u_gs_sp_relance u_gs_sp_relance

type variables
Protected:

u_DataWindow	iDwProduit
u_DataWindow_Accueil	iDw1
u_DataWindow	iDwSaisieSin
DataWindow		iDwParaProd
DataWindow		iDwPolice
Datawindow		iDwCivilite
Datawindow		idw_BoiteArchive
Datawindow		idw_DetPro
DataWindow		idwGenCourrier
DataWindow		idwAutorisation
DataWindow		idwCourrier

u_Libelle_Dga		iuoLibelle
u_Transaction		iTrTrans
u_BarreDefil		iuoDefil

Blob			iblBlobData, iblBlobDoc, iblBlob
Long			ilProd

Long			ilPole

Long			ilTotVar	     // Nbre de variables possibles dans la table code_car
Long			idcIdDoc	     // IdDoc du courrier de relances.
Long			ilNbrRowDw1 // Nombre de row dans Dw_1
String		isChaineData

String		isTypTrt
datetime		idtDate
integer		iidTrt

String		isTxtCompo  // Composition du courrier de relance
String		isIdCour	    // Courrier de relances
String		isNomFicTrace // Nom du fichier de trace.	
String		isSolAltRl2    // Le soldage sera différent si le traitement prévoit des 2èmes relances.
String		isAltSoldRl    // Le produit prévoit (O/N) le soldage des dossiers récémment relancés. 
String		isFicSig    // Fichier de sign pers
String		isRepSig, isFmtSig	// Sign Pers 
Int			iiHautFooter
Int			iiTotLigPol    // Nombre de ligne dans Dw_Police

Decimal		iDcIdSin
Decimal		iDcIdInter

// On compare ces dates par rapport à la date du jour
// donc idtDateMin est une date antérieure à idtDateMax
// qui est elle même antérieure à la date du jour.
DateTime		idtDateDuJour,idtDateMin, idtDateMax
DateTime		idtDateMaxSolRl, idtDateMaxSolPc

//Libellé du produit pour PageBlanche dossier soldé
String		isLibProd 

// DCMP 70809
Public:
String		isTxtCompoOri 	// Composition du courrier original
string		isMess
integer		iCptTraite

end variables

forward prototypes
public function boolean uf_preparerlancer ()
protected function boolean uf_determinerdatetrt ()
protected function boolean uf_datedujour ()
protected function boolean uf_chargerdw1 ()
public subroutine uf_cachertextdw1 (string ascas)
public function boolean uf_imprimerliste ()
protected function boolean uf_creerblob (long alrow)
protected function boolean uf_determinercomposition (long alrow)
protected function boolean uf_ecrirecourrierdansarchive (long alrow)
protected function boolean uf_misajourcourrieroriginal (long alrow)
protected function boolean uf_chargerdwparaprod ()
protected function boolean uf_detruirepremiererelance ()
public function boolean uf_lancertrt (ref boolean absaisie)
protected function boolean uf_controlersaisie (integer acas)
public function string uf_get_libprod ()
private subroutine uf_initialiser_sigelec (long alidprod, string ascodoper)
public function long uf_zn_taillelot (integer acas)
public function long uf_zn_refsin (integer acas)
public subroutine uf_getautorisation (string asidnatcour, ref string asbin, ref boolean abmodifcour, ref boolean abvalauto, ref boolean abvalidation, long alidprod, string ascodoper, integer aiidi)
public function boolean uf_ecriredwgencourrier (long alrow, string astype)
protected function boolean uf_chargerdwcourrier ()
public subroutine uf_initialiser_anc (ref u_datawindow adwproduit, ref u_datawindow adwsaisiesin, ref u_datawindow_accueil adw1, ref datawindow adwparaprod, ref datawindow adwpolice, ref datawindow adwcivilite, string astyptrt, ref u_libelle_dga auolibelle, ref u_transaction atrtrans, ref u_barredefil auodefil, ref datawindow adw_boitearchive, ref datawindow adw_detpro, ref datawindow adwgencourrier, ref datawindow adwautorisation, ref datawindow adwcourrierrelance)
public function boolean uf_generer_courrier (long alligne)
public function boolean uf_maj_w_cour_blob_arch (long alligne)
public function boolean uf_creercourrierrelance (long aldossier)
public function boolean uf_ecriretrace (long alrow, integer itypetrace)
public function boolean uf_chargerdwpolice (long lidprod)
private function string uf_format_numtel (string asvarstr)
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
//bOk = This.uf_ControlerSaisie ( 1 ) // JCA - POLE


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

// JCA - POLE - Code déporté dans la fonction uf_ChargerDw1() afin de ppouvoir
//						récupérer tous les produits du pôle choisi


///*------------------------------------------------------------------*/
///* On détermine les dates de traitement. On charge idtDateMin ( et  */
///* éventuellement idtDateMax ).                                     */
///*------------------------------------------------------------------*/
//If bOk Then
//	bOk = This.uf_DeterminerDateTrt ()
//
//	/*------------------------------------------------------------------*/
//	/* JFF le 27/05/2003 : Pour Must il faut d'abord faire les          */
//	/* dossiers de PANNE via la fenêtre de repérage.                    */
//	/*------------------------------------------------------------------*/
//	If ilProd = 5712 Then
//
//		stMessage.bErreurG = FALSE
//		stMessage.sCode	 = "RELA180"
//		stMessage.sTitre   = "SIMPA2 - Soldage"
//		stMessage.Icon	    = Exclamation!
//		stMessage.Bouton   = YesNo!
//		stMessage.sVar[1]  = String ( Date ( idtDateMaxSolPc ) )
//		stMessage.bTrace   = False
//		If F_Message ( stMessage ) = 2 Then bOk = FALSE
//
//	End If
//End If
//
///*------------------------------------------------------------------*/
///* Chargement des données dans Dw_courrier.                         */
///*------------------------------------------------------------------*/
//If bOk Then
//	bOk = This.uf_ChargerDwCourrier ()
//End If

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
//* MAJ PAR		Date		Modification
//*				  
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
	sUntRl1	  = iDwParaProd.GetItemString ( 1, "UNT_RL1" )

	CHOOSE CASE isTypTrt

		CASE "R1A", "R1U", "R1T"
			iDurRlMin = iDwParaProd.GetItemNumber ( 1, "DUR_RL1_MIN" )
			iDurRlMax = iDwParaProd.GetItemNumber ( 1, "DUR_RL1_MAX" )
	
		CASE "R2"
			iDurRlMin = iDwParaProd.GetItemNumber ( 1, "DUR_RL2" )

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
			idtDateMax = DateTime ( F_Plus_Date ( Date ( idtDateDuJour ) , ( iDurRlMin * (-1) ), sUntRl1 ), 23:59:59 )

			// La date est-elle valide ?
			bOk = Not ( Not F_Date ( String ( idtDateMax ), 4 ) Or idtDateMax >= idtDateDuJour  )

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

Boolean	bOk = True
String	sTitre, sProd, sProdLong, sTriActuel, sTitreR, sLibCode
Long		dcIdSin, lCpt, lIdSinSav, lIdSinLu
Integer	iFind
iDw1.SetRedraw ( False )
Decimal {2} dcIdProd

// JCA - POLE 
datastore dtsRelance
dtsRelance = create datastore
dtsRelance.dataobject = idw1.dataobject

int j, i = 1
j = iDwParaProd.rowcount( )

DO UNTIL i > j
	
	ilProd =  iDwParaProd.object.id_prod[i]

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
	/* Chargement des données dans Dw_courrier.                         */
	/*------------------------------------------------------------------*/
	If bOk Then
		bOk = This.uf_ChargerDwCourrier ()
	End If

	/*------------------------------------------------------------------*/
	/* Différents retrieves en fonction du type de relance.             */
	/*------------------------------------------------------------------*/
	CHOOSE CASE isTypTrt
	
		// Premières Relances Automatique.
		CASE "R1A"
	
			ilNbrRowDw1 = iDw1.Retrieve ( ilProd, idtDateMin, idtDateMax )
				
			sTitreR = " courrier(s) validé(s) entre le " + String ( Date ( idtDateMin) ) + " et le " + String ( Date ( idtDateMax) ) + ".'" 		
			sProd  = " : Premières Relances Automatiques"
	
		// Premières Relances Automatique pour les Gti Uf avec Dem. Pces à la banque.
//		CASE "R1U"
//	
//			ilNbrRowDw1 = iDw1.Retrieve ( ilProd, idtDateMin, idtDateMax )
//	
//			// Aucun Group by n'étant fait dans la requête pour des raisons techniques
//			//	Il faut épurer les doublons de sinistres.
//	
//			sTriActuel = iDw1.Describe ( "datawindow.table.Sort" )
//			iDw1.Modify ( "datawindow.table.Sort = '1A'" )
//			iDw1.Sort ()
//	
//			lIdSinSav = 0
//			For lCpt = ilNbrRowDw1 To 1 Step -1 
//				
//				lIdSinLu = iDw1.GetItemNumber ( lCpt, "ID_SIN" )
//				
//				If lIdSinLu = lIdSinSav Then iDw1.DeleteRow ( lCpt )
//			
//				lIdSinSav = lIdSinLu
//	
//			Next		
//	
//			iDw1.Modify ( "datawindow.table.Sort = '" + sTriActuel + "'" )
//			iDw1.Sort ()
//	
//			ilNbrRowDw1 = iDw1.RowCount ()
//	
//			sTitre = "st_Titre.text = 'Liste de " + String ( ilNbrRowDw1 ) + " courrier(s) validé(s) entre le " + String ( Date ( idtDateMin) ) + & 
//						" et le " + String ( Date ( idtDateMax) ) + ".'" 	
//	
//			sProd  = " : Premières Relances Automatiques (Garanties Uf avec Dem. Pces. à la banque)"
	
	
			
	
		// Premières Relances Particulières
		CASE "R1T"
	
			iDw1.Retrieve ( ilProd, idtDateMin, idtDateMax )
			sTitreR = " courrier(s) validé(s) entre le " + String ( Date ( idtDateMin) ) + " et le " + String ( Date ( idtDateMax) ) + ".'" 
			sProd  = " : Premières Relances Particulières"
	
		// Premières Relances Ponctuelles.
		CASE "R1P"
	
			dcIdSin 		= iDwSaisieSin.GetItemNumber ( 1, "ID_SIN" )
			ilNbrRowDw1 = iDw1.Retrieve ( dcIdSin, ilProd )
	
			sTitreR = " courrier(s) n~~'ayant jamais été relancé(s).'" 	
			sProd  = " : Premières Relances Ponctuelles"
	
		// Destruction d'une Première Relance.
		CASE "DR1"
	
			dcIdSin 		= iDwSaisieSin.GetItemNumber ( 1, "ID_SIN" )
			ilNbrRowDw1 = iDw1.Retrieve ( dcIdSin )
	
			sTitreR = " courrier(s) de première relance à annuler.'" 	
			sProd  = " : Annulation d~~'une Première Relance"
	
		// Deuxième Relances
		CASE "R2"
	
			ilNbrRowDw1 = iDw1.Retrieve ( ilProd, idtDateMax )

			sTitreR = " courrier(s) de première relance édités avant le " + String ( Date ( idtDateMax) ) + ".'"
			sProd  = " : Deuxième Relances"
	
	END CHOOSE
	
	iDw1.rowscopy(1, iDw1.rowcount( ), Primary!, dtsRelance, dtsRelance.rowcount()+1, Primary!)

	/*------------------------------------------------------------------*/
	/* On commit pour les tables temporaires utilisées.                 */
	/*------------------------------------------------------------------*/
	F_Commit ( iTrTrans, True )

	i += 1

LOOP

iDw1.reset()
dtsRelance.rowscopy(1, dtsRelance.rowcount( ), Primary!, iDw1, iDw1.rowcount()+1, Primary!)

ilNbrRowDw1 = iDw1.rowcount()
sTitre = "st_Titre.text = 'Liste de " + String ( ilNbrRowDw1 ) + sTitreR

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

		CASE "DR1", "SOL" // "R1T",

			sProdLong = ""

			// [DECIMAL_PAPILLON]
			dcIdProd = dec (ilProd)
			SELECT 	lib_long
			INTO		:sProdLong
			FROM   	sysadm.produit
			WHERE  	id_prod = :ilProd
			USING  	iTrTrans ;
			
			iFind = idwparaprod.find ( "ID_PROD = " + string(ilProd), 1, idwparaprod.rowcount() )
			sProdLong = idwparaprod.object.lib_long [iFind]

			sProd = "st_Produit.text = '" + sProdLong + sProd + "'"			
			isLibProd = sProdLong

		CASE ELSE
			//iDwProduit.accepttext( )
			sLibCode = iDwProduit.Describe ( "Evaluate ( 'LookUpDisplay ( ID_CODE )', 1 ) " )
			sProd = "st_Produit.text = ' Pôle " + sLibCode + sProd + "'"
	
	END CHOOSE

	iDw1.Modify ( sTitre )
	iDw1.Modify ( sProd )

	This.uf_CacherTextDw1 ( "NON" )
	SetPointer ( Arrow! )	

End If

iDw1.SetRedraw ( True )

Destroy(dtsRelance)

Return bOk

end function

public subroutine uf_cachertextdw1 (string ascas);
//*-----------------------------------------------------------------
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
//* #5   FPI   24/11/2009   [POLICE_PARTICULIERE] 
//			FPI	13/10/2010	[VDoc1416] civilité longue 4 à "Madame, Monsieur" 
//			FPI	23/07/2024	[MIG_PB2022] Sauvegarde Excel! remplacée par Excel8!
//*-----------------------------------------------------------------

Boolean 		bOk = True
Boolean		bVal, bOkDp66
String		sNomFic			// Nom du fichier Blob
String		sVide[]			// Tableau de variables à insérer dans le blob.
String		sVal, sVal2, sDpParam			
String		sRech				// Chaîne de recherche
String		sChaine			// ChaÎne à écrire dans le fichier, qui constituera le blob.
String		sMes				// Message
String		sBin
Int			iRowPol			// Row dans Dw_Police
Int			iFic				// Pointeur sur fichier
String 		sLibDept, sVarNonArmee

Long lDeb, lFin
n_cst_string	nvString		// #4

Long lIdSin, lIdProd, lIdRev   // #5

/*------------------------------------------------------------------*/
/* On efface tous les fichiers de data pouvant exister afin qu'il   */
/* n'y ait pas de conflits éventuels.                               */
/*------------------------------------------------------------------*/
//u_DeclarationFuncky uoDeclarationFuncky
//uoDeclarationFuncky = Create u_DeclarationFuncky
/*------------------------------------------------------------------*/  
/* #3. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sNomFic = isRepWin + "\TEMP\" + stGlb.sCodAppli + "*.DT"
sNomFic = stGLB.sRepTempo + stGlb.sCodAppli + "*.DT"
//uoDeclarationFuncky.Uf_FEraseAll ( sNomFic )
stGLB.uoWin.Uf_FEraseAll ( sNomFic )
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

sVarNonArmee = "!! VARIABLE NON ARMEE=>PROBLEME DE PARAMETRAGE, CONTACTEZ OMG/SO AU 2245"

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
/* ZVAR28		=	LIBELLE ASSOCIE CODE SECTEUR				( produit.id_depts ) 					  */
/* ZVAR02		=	CODE INTER										( inter.cod_i )	 					  	  */
/* ZVAR25		=	OPTION 66										( det_pro.id_code )	 					  */
/* ZVAR26		=	OPTION 67										( det_pro.id_code )					  	  */
/* ZVAR29		=	OPTION 70										( det_pro.id_code )					  	  */
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

sval = iDwCivilite.GetItemString ( Integer ( sVal ), "LIB_CODE_LONG" )

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
/* révisions.                                                        */
/*------------------------------------------------------------------*/

iDwPolice.saveas("c:\temp\test\iDwPolice.xls", excel8!, true) // [MIG_PB2022]
iDw1.saveas("c:\temp\test\iDw1.xls", excel8!, true)  // [MIG_PB2022]
iDwParaProd.saveas("c:\temp\test\iDwParaProd.xls", excel8!, true)  // [MIG_PB2022]

sRech = "ID_REV = " + String ( iDw1.GetItemNumber ( alRow, "ID_REV" ) )
iRowPol = iDwPolice.Find ( sRech, 1, iiTotLigPol )

If iRowPol = 0 Then

   sVal = ""   
   iuoLibelle.Uf_SetValue ( "PCOMPA", sVal )   
   //iuoLibelle.Uf_SetValue ( "PPOLIC", sVal )    // #5

Else

   sVal = iDwPolice.GetItemString ( iRowPol, "LIB_CIE" )
   iuoLibelle.Uf_SetValue ( "PCOMPA", sVal )   

   sVal = iDwPolice.GetItemString ( iRowPol, "LIB_POLICE" )
//   iuoLibelle.Uf_SetValue ( "PPOLIC", sVal )      // #5

End If

// #5 [POLICE_PARTICULIERE]
sVal = Fill ( " ", 35 )

lIdSin = iDw1.GetItemNumber ( alRow, "ID_SIN" )
lIdProd = iDw1.GetItemNumber ( alRow, "ID_PROD" )
lIdRev = iDw1.GetItemNumber ( alRow, "ID_REV" )

SQLCA.PS_S01_LIB_POLICE ( lIdSin, lIdProd, lIdRev, -1, sVal ) 
iuoLibelle.Uf_SetValue ( "PPOLIC", sVal )
// Fin #5 [POLICE_PARTICULIERE]

sVal = String ( iDw1.GetItemNumber ( alRow, "ID_PROD" ) )
iuoLibelle.Uf_SetValue ( "PIDPRO", sVal )   

// Prise en compte des modification de l'entête des courriers
/////////////////////////////////////////////////////////

//sVal = iDw1.GetItemString ( alRow, "PROD_COURT" ) 
//iuoLibelle.Uf_SetValue ( "PLIBCO", sVal )	

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
	sVal = Uf_Format_NumTel ( sVal )
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

Return bOk
end function

protected function boolean uf_determinercomposition (long alrow);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_DeterminerComposition
//* Auteur			: JCA
//* Date				: 28/01/2008
//* Libellé			: Détermination de la composition des courriers de relance
//*
//* Arguments		: Long		alRow			(Val)			// Dossier courant dans Dw1
//*
//* Retourne		: Boolean	True, tout s'est bien passé
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

Boolean 		bOk = True
String		sCodInter, sFind
Long 			lIdProd, lTot, lFind

isTxtCompo	= Space ( 248 )

sCodInter	= iDw1.GetItemString ( alRow, "COD_INTER" )
lTot 			= iDwCourrier.rowcount()

sFind			= "ID_COUR like '" + sCodInter + "%'"
lFind			= iDwCourrier.find ( sFind, 1, lTot )
isIdCour  	= iDwCourrier.GetItemString ( lFind, "ID_COUR" )

lIdProd 		= iDw1.GetItemNumber ( alRow, "ID_PROD" )

iTrTrans.PS_S01_COUR_PROD_V02 ( lIdProd, isIdCour, isIdCour, isTxtCompo )

stMessage.bTrace = True

If	Not F_Procedure ( stMessage, itrTrans, "PS_S01_COUR_PROD" )	Then

	bOk = False
	isMess = "Problème lors l'execution de PS_S01_COUR_PROD"
	F_Message ( stMessage )

End If

Return bOk

end function

protected function boolean uf_ecrirecourrierdansarchive (long alrow);
//*-----------------------------------------------------------------
//*
//* Fonction		: uf_EcrireCourrierDansArchive (Protected)
//* Auteur			: JCA
//* Date				: 23/01/2008
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
//*-----------------------------------------------------------------

Boolean 	bOk = True
Long	  	dcIdSin		
Long	  	dcIdInter
Long	  	dcIdOrdre
String  	sIdAdh
String  	sCodInter
String  	sNom
String  	sMajPar
String  	sValidePar
String  	sTypBlob
Int		iRet

idcIdDoc = -1   // idcId_Doc sera passé par Ref à PS_S02_ARCHIVE_RELANCES.
					 // et reviendra avec le nouvel Id_Doc créé.

/*------------------------------------------------------------------*/
/* Armement des variables.                                 			  */
/*------------------------------------------------------------------*/
sTypBlob = "DO"

dcIdSin 		= iDw1.GetItemNumber ( alRow, "ID_SIN"	  )
dcIdInter	= iDw1.GetItemNumber ( alRow, "ID_I" 	  )
idcIdDoc    = iDw1.GetItemNumber ( alRow, "ID_DOC"	  )  // Armement qui ne sert pas, puisque ser mis à jour en retour de PS_I02_ARCHIVE_RELANCES
dcIdOrdre	= iDw1.GetItemNumber ( alRow, "ID_ORDRE" )
sIdAdh		= iDw1.GetItemString ( alRow, "ID_ADH"   )
sCodInter	= iDw1.GetItemString ( alRow, "COD_INTER")
sNom			= iDw1.GetItemString ( alRow, "NOM_INTER")
sMajPar		= stGlb.sCodOper
sValidePar	= iDw1.GetItemString ( alRow, "VALIDE_PAR")

/*------------------------------------------------------------------*/
/* #1 ,11/10/99, Gestion de l'Id_Adh à Null					           */
/*------------------------------------------------------------------*/
If IsNull ( sIdAdh ) Then
	sIdAdh = ""
End If

/*------------------------------------------------------------------*/
/* Ecriture de l'enregistrement dans ARCHIVE et ARCHIVE_BLOB.       */
/*------------------------------------------------------------------*/
iTrTrans.PS_I02_ARCHIVE_RELANCE_ORANGE ( idtDateDuJour	,&
													  idcIdDoc			,&
													  dcIdSin			,&
													  dcIdInter			,&
													  isIdCour			,&				
													  ilProd				,&
													  dcIdOrdre			,&
													  sIdAdh				,&
													  sCodInter			,&
													  sNom				,&
													  isTxtCompo		,&
													  sValidePar		,&
													  sMajPar			,&
													  sTypBlob			&
													)		

If	Not F_Procedure ( stMessage, itrTrans, "PS_I02_ARCHIVE_RELANCE_ORANGE" ) or idcIdDoc < 0 Then
	bOk = False
	F_Commit ( iTrTrans, False )
	F_Message ( stMessage )

Else
	F_Commit ( iTrTrans, True )
	
End If

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
//*-----------------------------------------------------------------

Boolean bOk = True

Long		dcIdSin			// Sinistre
Long		dcIdInter		// Interlocuteur
Long		dcIdDoc			// n° du document lu sur iDw1 et non pas le dernier Id_Doc présent
								// sur archive pour ce même interlocuteur, car il correspondrait au courrier
								// de relance qui vient juste d'être écrit.
Decimal {2} dcIdsin2, dcIdInter2, dcIdDoc2

dcIdSin 	 = iDw1.GetItemNumber ( alRow, "ID_SIN" )
dcIdInter = iDw1.GetItemNumber ( alRow, "ID_I"   )
dcIdDoc	 = iDw1.GetItemNumber ( alRow, "ID_DOC" )

If bOk Then

	/*------------------------------------------------------------------*/
	/* Pour un update, je ne crée pas une nouvelle PS afin de ne pas    */
	/* alourdir un peu plus u_transaction.                              */
	/*------------------------------------------------------------------*/
	dcIdsin2 = Dec ( dcIdSin )
	dcIdInter2 = Dec ( dcIdInter )
	dcIdDoc2 = Dec ( dcIdDoc )
	UPDATE	sysadm.archive
	SET		nbr_conf  = 1, dte_conf = :idtDateDuJour
	WHERE		id_sin	 = :dcIdSin2
	AND		id_inter	 = :dcIdInter2
	AND		id_doc	 = :dcIdDoc2
	USING		iTrTrans ;


	isMess = "Problème sur UPDATE, uf_MajAJourCourrierOriginal, u_Rl_Sp_Rel_Anc."

	stMessage.bTrace = True
	If	Not F_Procedure ( stMessage, itrTrans, isMess )	Then

		bOk = False
		F_Commit ( iTrTrans, False )
		F_Message ( stMessage )

	Else
		F_Commit ( iTrTrans, True )
	End If
End If

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
//*				  
//*-----------------------------------------------------------------

Boolean bOk = True
Int	  iRow, iTypeRel
Long	  dcIdSin

iTypeRel = integer ( mid(isTypTrt,2,1) )

CHOOSE CASE isTypTrt

	CASE "R1A", "R1T", "R2" //, "SOL", "R1U"

//		ilProd = iDwProduit.GetItemNumber ( 1, "ID_PROD" )
		ilPole = iDwProduit.GetItemNumber ( 1, "ID_CODE" ) // JCA - POLE

//		iRow	 = iDwParaProd.Retrieve ( ilProd )
		iRow	 = iDwParaProd.Retrieve ( ilPole, iTypeRel ) // JCA - POLE

//		If iRow <> 1 Then
		If iRow = 0 Then // JCA - POLE
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


//	CASE "R1P", "DR1"
//		/*------------------------------------------------------------------*/
//		/* La procedure d'insertion du courrier de relance dans la base     */
//		/* attend l'idprod, voila pourquoi on va le chercher maintenant.    */
//		/* De plus si l'idprod revient à 0, cela nous indique que le        */
//		/* sinistre n'existe pas, on ne va pas plus loin alors.             */
//		/*------------------------------------------------------------------*/
//		
//		dcIdSin = iDwSaisieSin.GetItemNumber ( 1, "ID_SIN" )
//		ilProd  = 0
//
//		SELECT id_prod
//		INTO	 :ilProd
//		FROM	 sysadm.sinistre
//		WHERE  id_sin = :dcIdSin
//		USING  iTrTrans ;				
//
//		If ilProd = 0 then
//			
//			bOk = False
//	
//			stMessage.bErreurG = False
//			stMessage.sCode	 = "RELA170"
//			stMessage.sTitre   = "SIMPA2 - Relances"
//			stMessage.Icon	    = Information!
//			stMessage.bTrace 	 = True
//			stMessage.Bouton   = Ok!
//
//			F_Message ( stMessage )
//
//		End If


END CHOOSE


Return bOk
end function

protected function boolean uf_detruirepremiererelance ();
//*-----------------------------------------------------------------
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
//*				  
//*-----------------------------------------------------------------

Boolean  bOk = True
Long		lRow
Long		dcIdSin
Long		dcIdInter
Long		dcIdDoc
Long		dcIdArch

lRow    = iDw1.GetSelectedRow ( 0 )

dcIdSin   = iDw1.GetItemNumber ( lRow, "ID_SIN" )
dcIdInter = iDw1.GetItemNumber ( lRow, "ID_I"   )
dcIdDoc   = iDw1.GetItemNumber ( lRow, "ID_DOC" )

/*------------------------------------------------------------------*/
/* On delete le blob sur W_COUR_BLOB_ARCH.                          */
/*------------------------------------------------------------------*/

DELETE FROM sysadm.w_cour_blob_arch
WHERE  id_arch = (	SELECT	id_arch FROM sysadm.archive 
								WHERE	id_sin      = :dcIdSin
								AND	id_inter    = :dcIdInter
								AND	id_cour    	like '%LAX01'
							)
USING  iTrTrans ;

isMess = "Problème sur DELETE FROM sysadm.w_cour_blob_arch, uf_DetruirePremiereRelance, u_Rl_Sp_Relance."

If	Not F_Procedure ( stMessage, itrTrans, isMess )	Then

	bOk = False
	F_Commit  ( iTrTrans, False )
	F_Message ( stMessage )

End If

If bOk Then
	/*------------------------------------------------------------------*/
	/* On delete le blob sur ARCHIVE_BLOB.                              */
	/*------------------------------------------------------------------*/
	DELETE FROM sysadm.archive_blob 
	WHERE  id_sin      = :dcIdSin
	AND    id_inter    = :dcIdInter
	AND    id_doc      = :dcIdDoc
	AND    id_typ_blob = 'DO'
	USING  iTrTrans ;
	
	
	isMess = "Problème sur DELETE FROM sysadm.archive_blob, uf_DetruirePremiereRelance, u_Rl_Sp_Rel_Anc."
	
	
	If	Not F_Procedure ( stMessage, itrTrans, isMess )	Then
	
		bOk = False
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
	
		isMess = "Problème sur DELETE FROM sysadm.archive, uf_DetruirePremiereRelance, u_Rl_Sp_Rel_Anc."
	
		stMessage.bTrace = True
		If	Not F_Procedure ( stMessage, itrTrans, isMess )	Then
	
			bOk = False
			F_Commit ( iTrTrans, False )
			F_Message ( stMessage )
	
		End If
	
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
	isMess = "N° du Row détruit dans la DataWindow : " + String ( lRow ) + ", Sinistre : " + String ( dcIdSin )
	iDw1.DeleteRow ( lRow )

End If

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


CHOOSE CASE isTypTrt

	CASE "R1A", "R1U", "R2", "R1T"

		bOk 		= This.uf_ControlerSaisie ( 2 )		
		abSaisie = bOk

//		Déporté dans l'objet fenêtre w_a_sp_relance::spb_imprimerdossier
//		If bOk Then
//			bOk = This.uf_ChargerDwPolice ()
//		End If

		If bOk Then
			iDw1.SelectRow ( 0, True )
		End If 

		If bOk Then
			bOk = This.uf_ImprimerListe ()
		End If 

	CASE "R1P"

		bOk 		= This.uf_ControlerSaisie ( 2 )		
		abSaisie = bOk

//		Déporté dans l'objet fenêtre w_a_sp_relance::spb_imprimerdossier
//		If bOk Then
//			bOk = This.uf_ChargerDwPolice ()
//		End If

		If bOk Then
			bOk = This.uf_ImprimerListe ()
		End If 

	CASE "DR1"

		bOk 		= This.uf_ControlerSaisie ( 2 )		
		abSaisie = bOk

		If bOk Then
			bOk = This.uf_ImprimerListe ()
		End If 

		If bOk Then
			bOk = This.uf_DetruirePremiereRelance ()
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

iDwSaisieSin.AcceptText()

sCol[ 1 ]  = "ID_PROD"			// sur Dw_Produit
sCol[ 2 ]  = "ID_SIN"		   // sur Dw_SaisieSin

sErr[ 1 ]  = "- Le produit"
sErr[ 2 ]  = "- La référence sinistre"


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

Int 		iActionCode
String	sVal
long		ll_ret = 0

/*------------------------------------------------------------------*/
/* Contôle de la zone (ItemChanged).                                */
/*------------------------------------------------------------------*/
If aCas = 1 Then

	iActioncode = 0
	ll_ret = iActionCode

End If

/*------------------------------------------------------------------*/
/* Gestion de l'erreur (ItemError).                                 */
/*------------------------------------------------------------------*/
If aCas = 2 Then

	stMessage.bErreurG	= False
	stMessage.sCode	  	= "RELA120"
	stMessage.sTitre  	= "SIMPA2 - Relances"
	stMessage.Icon	  		= Information!
	stMessage.Bouton  	= Ok!
	stMessage.bTrace 		= False
	stMessage.sVar[1]  	= '0'

	F_Message ( stMessage )

End If

return ll_ret

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

public function boolean uf_ecriredwgencourrier (long alrow, string astype);
//*-----------------------------------------------------------------
//*
//* Fonction      : u_gs_sp_Relance::uf_EcrireCourrierDansArchive_sve (PRIVATE)
//* Auteur        : JCA
//* Date          : 23/01/2008
//* Libellé       : 
//* Commentaires  : Ecriture du courrier de relance fusionné, en base type DO
//*
//* Arguments     : Long			alRow			Val
//*
//* Retourne      : Integer
//*
//*-----------------------------------------------------------------
//* MAJ  PAR      Date	     Modification
//*
//*-----------------------------------------------------------------

Integer	iRow
boolean	bRet
String	sBac, sIdCour, sTxtCompo, sAltPart, sTitre
String	sAltGen = "O"
Long		dcIdSin, dcIdInter, dcIdDoc

bRet = true

dcIdSin 		= iDw1.GetItemNumber ( alRow, "ID_SIN"	  )
dcIdInter	= iDw1.GetItemNumber ( alRow, "ID_I" 	  )

if asType = "R" then
	dcIdDoc		= 1
	sIdCour		= isIdCour
	sTitre		= "RELANCE.DOC"
	sTxtCompo 	= isTxtCompo
	sAltPart		= "N"
else
	dcIdDoc		= 2
	sIdCour		= iDw1.GetitemString ( alRow, "ID_COUR" )
	sTitre		= mid(isTxtCompoOri, len(stglb.sreptempo)+1) // pour extraire le nom du fichier généré
	sTxtCompo 	= isTxtCompoOri
	sAltPart		= "O"
end if

Choose Case Left ( iDw1.GetitemString ( alRow, "ID_COUR" ), 1 )
	Case "Q"		// Questionnaire
		sBac = "MILIEU"
	Case "B"		// Courrier Banque
		sBac = "HAUT"
	Case Else	// Courrier Assuré + autres
		sBac = "BAS"
End Choose	

/*------------------------------------------------------------------*/
/* Insertion d'un enregistrement populisé dans DwGenCourrier.       */
/*------------------------------------------------------------------*/
iRow = idwGenCourrier.InsertRow ( 0 )

idwGenCourrier.SetItem ( iRow, "ID_SIN"					, dcIdSin )
idwGenCourrier.SetItem ( iRow, "ID_INTER"					, dcIdInter )
idwGenCourrier.SetItem ( iRow, "ID_SEQ"					, dcIdDoc )
idwGenCourrier.SetItem ( iRow, "ID_COUR"					, sIdCour )
idwGenCourrier.SetItem ( iRow, "TXT_COMPO"				, sTxtCompo )
idwGenCourrier.SetItem ( iRow, "TXT_DATA"					, isChaineData )
idwGenCourrier.SetItem ( iRow, "TITRE"						, sTitre )
idwGenCourrier.SetItem ( iRow, "COD_BAC"					, sBac )
idwGenCourrier.SetItem ( iRow, "ALT_GEN"					, sAltGen )
idwGenCourrier.SetItem ( iRow, "ALT_GESTION_PART"		, sAltPart )
idwGenCourrier.SetItem ( iRow, "ID_INTER_DOUBLE_PROV"	, -1 )
idwGenCourrier.SetItem ( iRow, "ID_CANAL"					, "CO" )

Return bRet

end function

protected function boolean uf_chargerdwcourrier ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_ChargerDwCourrier (Protected)
//* Auteur			: JCA
//* Date				: 31/02/2008
//* Libellé			: Chargement de Dw_Courrier
//* Commentaires	: On charge tous les types de courriers
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean	bOk 	= True
String	sCodInter
Long		lNbrRowDwCourrier

CHOOSE CASE isTypTrt
	
	// Premières Relances Automatique.
	CASE "R1A", "R1U", "R1T", "R1P"
		lNbrRowDwCourrier = iDwCourrier.Retrieve ( string(ilProd), "1" )

	// Deuxième Relances
	CASE "R2"
		lNbrRowDwCourrier = iDwCourrier.Retrieve ( string(ilProd), "2" )

END CHOOSE

/*------------------------------------------------------------------*/
/* Le retrieve s'est mal passé, on arrête tout.                     */
/*------------------------------------------------------------------*/
If lNbrRowDwCourrier < 0 Then

	bOk = False
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
ElseIf lNbrRowDwCourrier = 0 Then

	bOk = False
	stMessage.bErreurG	= False
	stMessage.sTitre  	= "SIMPA2 - Relances"
	stMessage.Icon	  		= Information!
	stMessage.Bouton  	= Ok!
	stMessage.sCode 		= "RELA132"				
	F_Message ( stMessage )

End If

Return bOk

end function

public subroutine uf_initialiser_anc (ref u_datawindow adwproduit, ref u_datawindow adwsaisiesin, ref u_datawindow_accueil adw1, ref datawindow adwparaprod, ref datawindow adwpolice, ref datawindow adwcivilite, string astyptrt, ref u_libelle_dga auolibelle, ref u_transaction atrtrans, ref u_barredefil auodefil, ref datawindow adw_boitearchive, ref datawindow adw_detpro, ref datawindow adwgencourrier, ref datawindow adwautorisation, ref datawindow adwcourrierrelance);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Initialiser_Anc	(Public)
//* Auteur			: Fabry JF
//* Date				: 08/06/1999 13:44:02

//* CO-Auteur		: JCA (refonte relance orange)
//* Date				: 15/01/2008

//* Libellé			: Initialisation de la fenêtre ancêtre
//* Commentaires	: Cette initialisation sera commune à toutes les fenêtres descendantes.
//*					  - R1A  --> Premières Relances Automatiques.
//*									 Edite les premières relances des courriers Qxxxx, xxxPxx
//*
//*					  - R1U  --> Premières Relances Automatiques pour les garanties UF avec Dem. Pces. à la banque.
//*								  	 Suite DCMP000285 B. Levesque, Edite les premières relances des courriers Qxxxx, xCxPxx, APART1
//*
//*					  - R1T  --> Premières Relances Particulières
//*                            Edite une LISTE des courriers APART1
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
//*
//* Arguments		: u_DataWindow					aDwProduit			(Ref) // Sélection du produit
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
//*-----------------------------------------------------------------

DataWindowChild		dwChild

/*------------------------------------------------------------------*/
/* Affectation des Arguments, aux Instances.             			  */
/*------------------------------------------------------------------*/
iDwProduit	 = aDwProduit
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
idwCourrier  = adwcourrierrelance

idtDate		= DateTime ( Today(), Now() )

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

idw_DetPro = adw_DetPro
idw_DetPro.SetTransObject ( itrTrans )

//* #1
idw_DetPro.Retrieve ( -1 )
idw_DetPro.Sort ()

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
iDwCivilite.SetTransObject  ( iTrTrans )
iDwSaisieSin.SetTransObject ( iTrTrans )
idwCourrier.SetTransObject	 ( iTrTrans )

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
		iDw1.DataObject = "D_SP_RELANCE_NORMALE"
		
	/*------------------------------------------------------------------*/
	/* 1ères Relances Automatiques Gti Uf avec Dem. Pces BQ             */
	/*------------------------------------------------------------------*/
	CASE "R1U"
		iDw1.DataObject = "D_SP_REL1_AUTO_UFBQ"
		
	/*------------------------------------------------------------------*/
	/* 1ères Relances Particulières												  */
	/*------------------------------------------------------------------*/
	CASE "R1T"
		iDw1.DataObject = "D_SP_RELANCE_PARTICULIERE"

	/*------------------------------------------------------------------*/
	/* 1ères Relances Ponctuelles                                       */
	/*------------------------------------------------------------------*/
	CASE "R1P"
		iDw1.DataObject = "D_SP_REL1_PONC"
		
	/*------------------------------------------------------------------*/
	/* Déestruction d'une première relance.                             */
	/*------------------------------------------------------------------*/
	CASE "DR1"
		iDw1.DataObject = "D_SP_REL1_ANNUL"

	/*------------------------------------------------------------------*/
	/* 2èmes Relances Automatiques                                      */
	/*------------------------------------------------------------------*/
	CASE "R2"
		iDw1.DataObject = "D_SP_SECONDE_RELANCE"

END CHOOSE

/*------------------------------------------------------------------*/
/* Regroupement des actions communes.										  */
/*------------------------------------------------------------------*/
CHOOSE CASE isTypTrt

	CASE "R1A", "R1U", "R2", "R1T"

//      idwProduit.GetChild ( "ID_PROD", dwChild )
		idwProduit.GetChild ( "ID_CODE", dwChild ) // JCA - POLE
		
      dwChild.SetTransObject ( itrTrans )
      dwChild.Retrieve()
		iDwProduit.InsertRow ( 0 )
//		iDwProduit.SetItem ( 1, "ID_PROD", stNul.Dcm )
		iDwProduit.SetItem ( 1, "ID_CODE", stNul.Dcm ) // JCA - POLE

		iDwCivilite.Retrieve ( "-CI", "-CL" )

		iDw1.GetChild ( "COD_INTER", dwChild )
		dwChild.SetTransObject ( iTrTrans )
		dwChild.Retrieve ( "-IN" )

		iDwProduit.Show ()	
		iDwProduit.SetFocus ()

//	CASE "R1T"
//
//    idwProduit.GetChild ( "ID_PROD", dwChild )
//    dwChild.SetTransObject ( itrTrans )
//    dwChild.Retrieve()
//		iDwProduit.InsertRow ( 0 )
//		iDwProduit.SetItem ( 1, "ID_PROD", stNul.Dcm )
//
//		iDw1.GetChild ( "COD_INTER", dwChild )
//		dwChild.SetTransObject ( iTrTrans )
//		dwChild.Retrieve ( "-IN" )
//
//		iDwProduit.Show ()	
//		iDwProduit.SetFocus ()

	CASE "R1P"

//      idwProduit.GetChild ( "ID_PROD", dwChild )
		idwProduit.GetChild ( "ID_CODE", dwChild ) // JCA - POLE

      dwChild.SetTransObject ( itrTrans )
      dwChild.Retrieve()
		iDwProduit.InsertRow ( 0 )
//		iDwProduit.SetItem ( 1, "ID_PROD", stNul.Dcm )
		iDwProduit.SetItem ( 1, "ID_CODE", stNul.Dcm ) // JCA - POLE

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

public function boolean uf_generer_courrier (long alligne);//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_Sp_Relances (OVERRIDE)
//* Evenement 		: uf_generer_courrier
//* Auteur			: JCA
//* Date				: 20/01/2008
//* Libellé			: 
//* Commentaires	: DCMP 70809
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

boolean bRet
integer iRet
boolean bOK
Long lIdProd

n_Cst_Edition_Courrier	nvGenCourrier

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
/* On relit le fichier DOC complet fusionné   							  */
/*------------------------------------------------------------------*/
If iRet > 0 Then 
	/*------------------------------------------------------------------*/  
	/* #1. DCMP-060643                                                  */
	/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
	/*------------------------------------------------------------------*/
	bRet = F_LireFichierBlob ( iblBlobDoc, stGLB.sRepTempo + "RELANCE.DOC" )

	If Not bRet Or Len ( iblBlobDoc ) < 5 Then 
		bRet = false

	end if

End If

if bRet then 
	/*------------------------------------------------------------------*/
	/* Ajout dans w_cour_blob_arch pour édition								  */
	/*------------------------------------------------------------------*/
	bRet = uf_maj_w_cour_blob_arch (alLigne)	
	
end if

if bRet then 
	isMess = "La génération du courrier de relance a été effectuée."
end if

return bRet

end function

public function boolean uf_maj_w_cour_blob_arch (long alligne);//
////
//// JCA DCMP 07809
//
//*    JFF   11/01/2011    [DECIMAL_PAPILLON]

boolean bOk = true
string sTypBlob, sMajPar
decimal dcIdSin, dcIdInter
integer iIdTypDoc
Decimal {2} dcIdsin2, dcIdInter2, dcIdDoc2

iIdTypDoc	= 50 // Relance Orange
sTypBlob 	= "DO"

dcIdSin 			= iDw1.GetItemNumber ( alligne, "ID_SIN"	  )
dcIdInter		= iDw1.GetItemNumber ( alligne, "ID_I" 	  )

// insert de la ligne dans [w_cour_blob_arch]
iTrTrans.PS_I02_W_COUR_BLOB_ARCH ( dcIdSin, dcIdInter, idcIdDoc, sTypBlob, iIdTypDoc, sMajPar ) 

if	not F_Procedure ( stMessage, iTrTrans, "PS_I02_W_COUR_BLOB_ARCH, uf_maj_w_cour_blob_arch, u_Rl_Sp_Relance" )	then

	bOk = False
	F_Commit ( iTrTrans, False )
	F_Message ( stMessage )
	
else
	
	F_Commit ( iTrTrans, True )
	
	// update du blob sur l'enregistrement de [w_cour_blob_arch]
	//
	dcIdsin2 = Dec ( dcIdSin )
	dcIdInter2 = Dec ( dcIdInter )
	dcIdDoc2 = Dec ( idcIdDoc )
	UPDATEBLOB	sysadm.w_cour_blob_arch
	SET			txt_blob		= :iblBlobDoc
	WHERE			id_sin		= :dcIdsin2
	AND			id_inter		= :dcIdInter2
	AND			id_seq		= :dcIdDoc2 // id_doc du courrier de relance
	AND			id_typ_blob	= :sTypBlob
	USING			iTrTrans;
	
	If	Not F_Procedure ( stMessage, iTrTrans, "UPDATEBLOB, uf_maj_w_cour_blob_arch, u_Rl_Sp_Relance" )	Then
	
		bOk = False
		F_Commit ( iTrTrans, False )
		F_Message ( stMessage )
	
	Else
		F_Commit ( iTrTrans, True )

	End If
	
end if

return bOk

end function

public function boolean uf_creercourrierrelance (long aldossier);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_CreerCourrierRelance  (Public)
//* Auteur			: Fabry JF
//* Date				: 14/06/1999 11:36:12
//* Libellé			: Création du courrier de relance.
//* Commentaires	: appel sur ue_ImprimerDossier.
//*
//* Arguments		: Long			alDossier			(Val)			Row du dossier à traiter sur Dw_1
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean bOk = True

/*------------------------------------------------------------------*/
/* Création du Blob stocké	dans iblBlobData								  */
/*------------------------------------------------------------------*/
bOk = This.Uf_CreerBlob ( alDossier )

/*------------------------------------------------------------------*/
/* Détermination du courrier, en fonction de l'interlocuteur et du  */
/* type de traitement, et détermination de la composition du code   */
/* courrier.                                                        */
/*------------------------------------------------------------------*/
If bOk Then
	bOk = This.Uf_DeterminerComposition ( alDossier )
End If

/*------------------------------------------------------------------*/
/* Ecriture du courrier dans Archive et Archive_Blob.               */
/*------------------------------------------------------------------*/
If bOk Then
	bOk = This.Uf_EcrireCourrierDansArchive ( alDossier )
End If


/*------------------------------------------------------------------*/
/* Ecriture du courrier dans datawindow de generation des courriers.*/
/*------------------------------------------------------------------*/
If bOk Then
	bOk = This.uf_EcrireDwGenCourrier ( alDossier, "R" )
End If

/*------------------------------------------------------------------*/
/* On Update maintenant NBR_CONF à 1.                               */
/*------------------------------------------------------------------*/
If bOk Then
	bOk = This.Uf_MisAJourCourrierOriginal ( alDossier )
End If


Return bOk
end function

public function boolean uf_ecriretrace (long alrow, integer itypetrace);
//*-----------------------------------------------------------------
//*
//* Fonction		: uf_EcrireTrace 	( Public )
//* Auteur			: JCA
//* Date				: 04/02/2008
//* Libellé			: Ecriture de la trace
//*
//* Commentaires	: 
//*					  
//*
//* Arguments		: Long	alRow			Row du dossier en cours sur Dw_1
//*																
//*					  String	asMessage	Message à tracer.			
//*
//* Retourne		: boolean
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------


Boolean 	bOk = True
Long		dcIdSin						// Sinistre
Long		dcIdInter					// Interlocuteur
Long		dcIdDocOri					// Id_Doc du courrier original
Long		dcIdDocRel					// Id_Doc du courrier de relance

choose case itypetrace
	case 1
		// procedure d'ajout de la trace [trace_recap_relance]
		iIdTrt = iTrTrans.PS_I01_TRACE_RECAP_RELANCE ( stGlb.sCodOper, isTypTrt, idtDate, idw1.rowcount() )

	case 2
		dcIdSin		= iDw1.GetItemNumber ( alRow, "ID_SIN" )
		dcIdInter 	= iDw1.GetItemNumber ( alRow, "ID_I"   )
		dcIdDocOri	= iDw1.GetItemNumber ( alRow, "ID_DOC" )
		dcIdDocRel	= idcIdDoc
		
		// procedure d'ajout de la trace [trace_relance]
		iTrTrans.PS_I01_TRACE_RELANCE ( iIdTrt, dcIdSin, dcIdInter, dcIdDocOri, dcIdDocRel, isMess)
		
	case 3
		// procedure de mise à jour de la trace [trace_recap_relance]
		iTrTrans.PS_U01_TRACE_RECAP_RELANCE ( iIdTrt, iCptTraite )

end choose

if iTrTrans.sqlcode <> 0 or iTrTrans.sqldbcode <> 0 then

	bOk = false
	f_Commit (iTrTrans, bOk )

	stMessage.bErreurG  = False
	stMessage.sCode	  = "GENE012"
	stMessage.sTitre    = "SIMPA2 - Relances"
	stMessage.Icon	  	  = Exclamation!
	stMessage.Bouton    = Ok!
	stMessage.bTrace    = True
	stMessage.sVar[1]   = "Problème lors de l'écriture de l'historique des relances."
	stMessage.sVar[1]  += " Le traitement est arrêté." 

else
	
	f_Commit (iTrTrans, bOk )

end if

Return bOk

end function

public function boolean uf_chargerdwpolice (long lidprod);//*-----------------------------------------------------------------
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

iRow = iDwPolice.Retrieve ( lIdProd )

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

private function string uf_format_numtel (string asvarstr);//*-----------------------------------------------------------------
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

on u_gs_sp_relance.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_gs_sp_relance.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

