HA$PBExportHeader$u_gs_sp_relance.sru
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
String		isSolAltRl2    // Le soldage sera diff$$HEX1$$e900$$ENDHEX$$rent si le traitement pr$$HEX1$$e900$$ENDHEX$$voit des 2$$HEX1$$e800$$ENDHEX$$mes relances.
String		isAltSoldRl    // Le produit pr$$HEX1$$e900$$ENDHEX$$voit (O/N) le soldage des dossiers r$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$mment relanc$$HEX1$$e900$$ENDHEX$$s. 
String		isFicSig    // Fichier de sign pers
String		isRepSig, isFmtSig	// Sign Pers 
Int			iiHautFooter
Int			iiTotLigPol    // Nombre de ligne dans Dw_Police

Decimal		iDcIdSin
Decimal		iDcIdInter

// On compare ces dates par rapport $$HEX2$$e0002000$$ENDHEX$$la date du jour
// donc idtDateMin est une date ant$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$idtDateMax
// qui est elle m$$HEX1$$ea00$$ENDHEX$$me ant$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$la date du jour.
DateTime		idtDateDuJour,idtDateMin, idtDateMax
DateTime		idtDateMaxSolRl, idtDateMaxSolPc

//Libell$$HEX2$$e9002000$$ENDHEX$$du produit pour PageBlanche dossier sold$$HEX1$$e900$$ENDHEX$$
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Pr$$HEX1$$e900$$ENDHEX$$pare le lancement du Traitement
//* Commentaires	: - Controle La saisie
//*					  - Charge le param$$HEX1$$e800$$ENDHEX$$trage du produit s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$.
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
/* On Contr$$HEX1$$f400$$ENDHEX$$le la saisie.                                           */
/*------------------------------------------------------------------*/
//bOk = This.uf_ControlerSaisie ( 1 ) // JCA - POLE


/*------------------------------------------------------------------*/
/* On Charge le param$$HEX1$$e800$$ENDHEX$$trage. (except$$HEX2$$e9002000$$ENDHEX$$pour les R1P et DR1)          */
/*------------------------------------------------------------------*/
If bOk Then
	bOk = This.uf_ChargerDwParaProd ()
End If


/*------------------------------------------------------------------*/
/* Ram$$HEX1$$e800$$ENDHEX$$ne la date du jour du serveur, dans idtDateDuJour.           */
/*------------------------------------------------------------------*/
If bOk Then
	bOk = This.uf_DateDuJour ()
End If

// JCA - POLE - Code d$$HEX1$$e900$$ENDHEX$$port$$HEX2$$e9002000$$ENDHEX$$dans la fonction uf_ChargerDw1() afin de ppouvoir
//						r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer tous les produits du p$$HEX1$$f400$$ENDHEX$$le choisi


///*------------------------------------------------------------------*/
///* On d$$HEX1$$e900$$ENDHEX$$termine les dates de traitement. On charge idtDateMin ( et  */
///* $$HEX1$$e900$$ENDHEX$$ventuellement idtDateMax ).                                     */
///*------------------------------------------------------------------*/
//If bOk Then
//	bOk = This.uf_DeterminerDateTrt ()
//
//	/*------------------------------------------------------------------*/
//	/* JFF le 27/05/2003 : Pour Must il faut d'abord faire les          */
//	/* dossiers de PANNE via la fen$$HEX1$$ea00$$ENDHEX$$tre de rep$$HEX1$$e900$$ENDHEX$$rage.                    */
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
///* Chargement des donn$$HEX1$$e900$$ENDHEX$$es dans Dw_courrier.                         */
///*------------------------------------------------------------------*/
//If bOk Then
//	bOk = This.uf_ChargerDwCourrier ()
//End If

/*------------------------------------------------------------------*/
/* Chargement des donn$$HEX1$$e900$$ENDHEX$$es dans Dw1.                                 */
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: D$$HEX1$$e900$$ENDHEX$$termine les dates de traitements
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
Int		iDurRlMin		// D$$HEX1$$e900$$ENDHEX$$lai concernant les relances
Int		iDurRlMax      // D$$HEX1$$e900$$ENDHEX$$lai concernant les relances
Int		iDurSolMinRl   // D$$HEX1$$e900$$ENDHEX$$lai concernant le soldage lorsqu'il y a eut relances
Int		iDurSolMinPc   // D$$HEX1$$e900$$ENDHEX$$lai concernant le soldage lorsqu'il n'y a jamais de courriers,
								// ou lorsqu'il y a eu courriers sans relance.
Int		iMes				// Message $$HEX2$$e0002000$$ENDHEX$$afficher
String	sUntRl1
String	sMes[ 3 ]		// Messages


iDtDateMin 		 = stNul.Dtm
iDtDateMax 		 = stNul.Dtm
iDtDateMaxSolRl = stNul.Dtm
iDtDateMaxSolPc = stNul.Dtm


sMes[ 1 ] = "premi$$HEX1$$e800$$ENDHEX$$res relances"
sMes[ 2 ] = "deuxi$$HEX1$$e800$$ENDHEX$$mes relances"
sMes[ 3 ] = "soldage de dossiers"


/*------------------------------------------------------------------*/
/* Le produit pr$$HEX1$$e900$$ENDHEX$$voit-il ce type de traitement ?						  */
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
		/* On ne tient pas compte du param$$HEX1$$e800$$ENDHEX$$trage pour ce cas de traitement. */
		/* On ne calcule aucun d$$HEX1$$e900$$ENDHEX$$lai.													  */
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
/* On Charge les d$$HEX1$$e900$$ENDHEX$$lais	(except$$HEX2$$e9002000$$ENDHEX$$pour les trt R1P, DR1)  			  */
/* Ces d$$HEX1$$e900$$ENDHEX$$lais sont $$HEX2$$e0002000$$ENDHEX$$prendre en compte $$HEX2$$e0002000$$ENDHEX$$partir de la date du jour. */
/* DUR_RL1_MAX >= DUR_RL1_MIN (mais idtDateMin <= idtDateMax )      */
/*------------------------------------------------------------------*/
If bOk and isTypTrt <> "R1P" and isTypTrt <> "DR1" Then

	// L'unit$$HEX2$$e9002000$$ENDHEX$$de temps pour tous les traitements est d$$HEX1$$e900$$ENDHEX$$termin$$HEX1$$e900$$ENDHEX$$s
	// $$HEX2$$e0002000$$ENDHEX$$partir de UNT_RL1, voir le param$$HEX1$$e800$$ENDHEX$$trage.
	sUntRl1	  = iDwParaProd.GetItemString ( 1, "UNT_RL1" )

	CHOOSE CASE isTypTrt

		CASE "R1A", "R1U", "R1T"
			iDurRlMin = iDwParaProd.GetItemNumber ( 1, "DUR_RL1_MIN" )
			iDurRlMax = iDwParaProd.GetItemNumber ( 1, "DUR_RL1_MAX" )
	
		CASE "R2"
			iDurRlMin = iDwParaProd.GetItemNumber ( 1, "DUR_RL2" )

	END CHOOSE


/*--------------------------------------------------------------------------*/
/* D$$HEX1$$e900$$ENDHEX$$termination des dates.                                                 */
/* On d$$HEX1$$e900$$ENDHEX$$termine les dates, sachant que idtDateMin <= idtDateMax             */
/* Ex: idtDateMin = 25/02/1999 00:00:00 -au-> idtDateMax 15/05/1999 23:59:59*/
/*     La date du jour $$HEX1$$e900$$ENDHEX$$tant le 27/07/1999 15:35:25                         */
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: D$$HEX1$$e900$$ENDHEX$$termine la date du jour.
//* Commentaires	: Ram$$HEX1$$e800$$ENDHEX$$ne la date du jour et l'heure, du serveur
//*					  Cela n$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$ssite bien $$HEX1$$e900$$ENDHEX$$videmment que la table param$$HEX1$$e800$$ENDHEX$$tre 
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
	stMessage.sVar[1]  = "Impossible de lire la date du serveur. Le traitement n'est pas lanc$$HEX1$$e900$$ENDHEX$$."

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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Chargement de Dw_1.
//* Commentaires	: On charge tous les courriers qui vont $$HEX1$$ea00$$ENDHEX$$tre $$HEX2$$e0002000$$ENDHEX$$relancer
//*					  pour la premi$$HEX1$$e800$$ENDHEX$$re fois.
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
	/* On d$$HEX1$$e900$$ENDHEX$$termine les dates de traitement. On charge idtDateMin ( et  */
	/* $$HEX1$$e900$$ENDHEX$$ventuellement idtDateMax ).                                     */
	/*------------------------------------------------------------------*/
	If bOk Then
		bOk = This.uf_DeterminerDateTrt ()
	
		/*------------------------------------------------------------------*/
		/* JFF le 27/05/2003 : Pour Must il faut d'abord faire les          */
		/* dossiers de PANNE via la fen$$HEX1$$ea00$$ENDHEX$$tre de rep$$HEX1$$e900$$ENDHEX$$rage.                    */
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
	/* Chargement des donn$$HEX1$$e900$$ENDHEX$$es dans Dw_courrier.                         */
	/*------------------------------------------------------------------*/
	If bOk Then
		bOk = This.uf_ChargerDwCourrier ()
	End If

	/*------------------------------------------------------------------*/
	/* Diff$$HEX1$$e900$$ENDHEX$$rents retrieves en fonction du type de relance.             */
	/*------------------------------------------------------------------*/
	CHOOSE CASE isTypTrt
	
		// Premi$$HEX1$$e800$$ENDHEX$$res Relances Automatique.
		CASE "R1A"
	
			ilNbrRowDw1 = iDw1.Retrieve ( ilProd, idtDateMin, idtDateMax )
				
			sTitreR = " courrier(s) valid$$HEX1$$e900$$ENDHEX$$(s) entre le " + String ( Date ( idtDateMin) ) + " et le " + String ( Date ( idtDateMax) ) + ".'" 		
			sProd  = " : Premi$$HEX1$$e800$$ENDHEX$$res Relances Automatiques"
	
		// Premi$$HEX1$$e800$$ENDHEX$$res Relances Automatique pour les Gti Uf avec Dem. Pces $$HEX2$$e0002000$$ENDHEX$$la banque.
//		CASE "R1U"
//	
//			ilNbrRowDw1 = iDw1.Retrieve ( ilProd, idtDateMin, idtDateMax )
//	
//			// Aucun Group by n'$$HEX1$$e900$$ENDHEX$$tant fait dans la requ$$HEX1$$ea00$$ENDHEX$$te pour des raisons techniques
//			//	Il faut $$HEX1$$e900$$ENDHEX$$purer les doublons de sinistres.
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
//			sTitre = "st_Titre.text = 'Liste de " + String ( ilNbrRowDw1 ) + " courrier(s) valid$$HEX1$$e900$$ENDHEX$$(s) entre le " + String ( Date ( idtDateMin) ) + & 
//						" et le " + String ( Date ( idtDateMax) ) + ".'" 	
//	
//			sProd  = " : Premi$$HEX1$$e800$$ENDHEX$$res Relances Automatiques (Garanties Uf avec Dem. Pces. $$HEX2$$e0002000$$ENDHEX$$la banque)"
	
	
			
	
		// Premi$$HEX1$$e800$$ENDHEX$$res Relances Particuli$$HEX1$$e800$$ENDHEX$$res
		CASE "R1T"
	
			iDw1.Retrieve ( ilProd, idtDateMin, idtDateMax )
			sTitreR = " courrier(s) valid$$HEX1$$e900$$ENDHEX$$(s) entre le " + String ( Date ( idtDateMin) ) + " et le " + String ( Date ( idtDateMax) ) + ".'" 
			sProd  = " : Premi$$HEX1$$e800$$ENDHEX$$res Relances Particuli$$HEX1$$e800$$ENDHEX$$res"
	
		// Premi$$HEX1$$e800$$ENDHEX$$res Relances Ponctuelles.
		CASE "R1P"
	
			dcIdSin 		= iDwSaisieSin.GetItemNumber ( 1, "ID_SIN" )
			ilNbrRowDw1 = iDw1.Retrieve ( dcIdSin, ilProd )
	
			sTitreR = " courrier(s) n~~'ayant jamais $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$relanc$$HEX1$$e900$$ENDHEX$$(s).'" 	
			sProd  = " : Premi$$HEX1$$e800$$ENDHEX$$res Relances Ponctuelles"
	
		// Destruction d'une Premi$$HEX1$$e800$$ENDHEX$$re Relance.
		CASE "DR1"
	
			dcIdSin 		= iDwSaisieSin.GetItemNumber ( 1, "ID_SIN" )
			ilNbrRowDw1 = iDw1.Retrieve ( dcIdSin )
	
			sTitreR = " courrier(s) de premi$$HEX1$$e800$$ENDHEX$$re relance $$HEX2$$e0002000$$ENDHEX$$annuler.'" 	
			sProd  = " : Annulation d~~'une Premi$$HEX1$$e800$$ENDHEX$$re Relance"
	
		// Deuxi$$HEX1$$e800$$ENDHEX$$me Relances
		CASE "R2"
	
			ilNbrRowDw1 = iDw1.Retrieve ( ilProd, idtDateMax )

			sTitreR = " courrier(s) de premi$$HEX1$$e800$$ENDHEX$$re relance $$HEX1$$e900$$ENDHEX$$dit$$HEX1$$e900$$ENDHEX$$s avant le " + String ( Date ( idtDateMax) ) + ".'"
			sProd  = " : Deuxi$$HEX1$$e800$$ENDHEX$$me Relances"
	
	END CHOOSE
	
	iDw1.rowscopy(1, iDw1.rowcount( ), Primary!, dtsRelance, dtsRelance.rowcount()+1, Primary!)

	/*------------------------------------------------------------------*/
	/* On commit pour les tables temporaires utilis$$HEX1$$e900$$ENDHEX$$es.                 */
	/*------------------------------------------------------------------*/
	F_Commit ( iTrTrans, True )

	i += 1

LOOP

iDw1.reset()
dtsRelance.rowscopy(1, dtsRelance.rowcount( ), Primary!, iDw1, iDw1.rowcount()+1, Primary!)

ilNbrRowDw1 = iDw1.rowcount()
sTitre = "st_Titre.text = 'Liste de " + String ( ilNbrRowDw1 ) + sTitreR

/*------------------------------------------------------------------*/
/* Le retrieve s'est mal pass$$HEX1$$e900$$ENDHEX$$, on arr$$HEX1$$ea00$$ENDHEX$$te tout.                     */
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
/* Aucune ligne ramen$$HEX1$$e900$$ENDHEX$$e.														  */
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
			sProd = "st_Produit.text = ' P$$HEX1$$f400$$ENDHEX$$le " + sLibCode + sProd + "'"
	
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Cache le header de Dw1
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
/* Dw_1 peut $$HEX1$$ea00$$ENDHEX$$tre diff$$HEX1$$e900$$ENDHEX$$rente fonction des trt.          				  */
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Impression de la liste des dossiers $$HEX2$$e0002000$$ENDHEX$$relancer.
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Cr$$HEX1$$e900$$ENDHEX$$ation du blob de donn$$HEX1$$e900$$ENDHEX$$es.
//* Commentaires	: 
//*
//* Arguments		: Long		alRow			// Row du dossier $$HEX2$$e0002000$$ENDHEX$$Traiter
//*
//* Retourne		: Boolean
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF   15/04/04  DCMP 040020 SVE : Gestion de la Sign Pers
//* #2  MADM  04/08/06  Projet DNTMAIL1/2 Mails sortant en remplacement des courriers
//* #3  DGA   19/09/2006	Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire DCMP-060643
//* #4	FPI	28/09/2009	[DCMP090552] Gestion des no de tel $$HEX1$$e900$$ENDHEX$$tranger
//* #5   FPI   24/11/2009   [POLICE_PARTICULIERE] 
//			FPI	13/10/2010	[VDoc1416] civilit$$HEX2$$e9002000$$ENDHEX$$longue 4 $$HEX2$$e0002000$$ENDHEX$$"Madame, Monsieur" 
//*-----------------------------------------------------------------

Boolean 		bOk = True
Boolean		bVal, bOkDp66
String		sNomFic			// Nom du fichier Blob
String		sVide[]			// Tableau de variables $$HEX2$$e0002000$$ENDHEX$$ins$$HEX1$$e900$$ENDHEX$$rer dans le blob.
String		sVal, sVal2, sDpParam			
String		sRech				// Cha$$HEX1$$ee00$$ENDHEX$$ne de recherche
String		sChaine			// Cha$$HEX1$$ce00$$ENDHEX$$ne $$HEX3$$e0002000e900$$ENDHEX$$crire dans le fichier, qui constituera le blob.
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
/* n'y ait pas de conflits $$HEX1$$e900$$ENDHEX$$ventuels.                               */
/*------------------------------------------------------------------*/
//u_DeclarationFuncky uoDeclarationFuncky
//uoDeclarationFuncky = Create u_DeclarationFuncky
/*------------------------------------------------------------------*/  
/* #3. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire parametrable.  */
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
/* On r$$HEX1$$e900$$ENDHEX$$arme le tableau des variables $$HEX2$$e0002000$$ENDHEX$$vide.                       */
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
/* ACIVAS		=	CIVILITE DE L$$HEX1$$1920$$ENDHEX$$ASSURE							( personne.cod_civ )						  */	
/* ANOMAS		=	NOM DE L$$HEX1$$1920$$ENDHEX$$ASSURE								( personne.nom )							  */
/* APREAS		=	PRENOM DE L$$HEX1$$1920$$ENDHEX$$ASSURE							( personne.prenom )						  */
/* ZVAR01		=	DATE D$$HEX1$$1920$$ENDHEX$$ENVOI DU COURRIER QUE L$$HEX1$$1920$$ENDHEX$$ON RELANCE (archive.dte_edit)					  */
/* ARIBBQ		=	RIB BANQUE DE L$$HEX1$$1920$$ENDHEX$$ASSURE						( inter.rib_bq where cod_inter = A )  */
/* ARIBCL		=	RIB CLE DE L$$HEX1$$1920$$ENDHEX$$ASSURE							( inter.rib_bq where cod_inter = A )  */
/* ARIBCP		=	RIB COMPTE DE L$$HEX1$$1920$$ENDHEX$$ASSURE   					( inter.rib_bq where cod_inter = A )  */
/* ARIBGU		=	RIB GUICHET DE L$$HEX1$$1920$$ENDHEX$$ASSURE						( inter.rib_bq where cod_inter = A )  */
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

/* Lib$$HEX1$$e900$$ENDHEX$$ll$$HEX2$$e9002000$$ENDHEX$$du sous d$$HEX1$$e900$$ENDHEX$$partement   											  */
/*------------------------------------------------------------------*/
sLibDept = space ( 35 )
itrTrans.IM_S01_DEPARTEMENT( Dec(sVal), sLibDept )
iuoLibelle.Uf_SetValue ( "ZVAR28", sLibDept )

sVal = String ( iDw1.GetItemNumber ( alRow, "PROD_ID_DEPT" ) )
iuoLibelle.Uf_SetValue ( "PCODDP", sVal )	

/*------------------------------------------------------------------*/
/* Deux cas possibles pour la cie & la police.                      */
/* Voir uf_ChargerDwPolice, dw_police peut ne pas contenir certaines*/
/* r$$HEX1$$e900$$ENDHEX$$visions.                                                        */
/*------------------------------------------------------------------*/

iDwPolice.saveas("c:\temp\test\iDwPolice.xls", excel!, true)
iDw1.saveas("c:\temp\test\iDw1.xls", excel!, true)
iDwParaProd.saveas("c:\temp\test\iDwParaProd.xls", excel!, true)

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

// Prise en compte des modification de l'ent$$HEX1$$ea00$$ENDHEX$$te des courriers
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
/* #3 : Renseignement de la variable ZVAR05 (idem $$HEX2$$e0002000$$ENDHEX$$SAVANE) avec le */
/* Pr$$HEX1$$e900$$ENDHEX$$nom et nom du Gestionnaire.											  */
/*------------------------------------------------------------------*/

/*----------------------------------------------------------------------------*/
/* #2 : Ajout de l'identifiant interlocuteur $$HEX2$$e0002000$$ENDHEX$$la fonction uf_GetAutorisation */
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
/* Variable donnant le d$$HEX1$$e900$$ENDHEX$$lai en jour 										  */
/* pour r$$HEX1$$e900$$ENDHEX$$ponse au deuxi$$HEX1$$e800$$ENDHEX$$me relance											  */
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
/* On cr$$HEX3$$e900e9002000$$ENDHEX$$maintenant le blob lui-m$$HEX1$$ea00$$ENDHEX$$me										  */
/*------------------------------------------------------------------*/
sChaine = ""
iuoLibelle.Uf_Creer_Chaine ( sChaine, stSpb )

isChaineData = sChaine 

// [MIGPB11] [EMD] : Debut Migration : Forcer la cr$$HEX1$$e900$$ENDHEX$$ation de Blob en ANSI
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: D$$HEX1$$e900$$ENDHEX$$termination de la composition des courriers de relance
//*
//* Arguments		: Long		alRow			(Val)			// Dossier courant dans Dw1
//*
//* Retourne		: Boolean	True, tout s'est bien pass$$HEX1$$e900$$ENDHEX$$
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
	isMess = "Probl$$HEX1$$e800$$ENDHEX$$me lors l'execution de PS_S01_COUR_PROD"
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ecriture de l'enregistrement dans ARCHIVE et ARCHIVE_BLOB
//* Commentaires	: 
//*
//* Arguments		: Long		alRow			(Val)			// aRow du dossier $$HEX2$$e0002000$$ENDHEX$$Traiter dans iDw1.
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF    11/10/99 Gestion de l'Id_Adh $$HEX2$$e0002000$$ENDHEX$$Null				  
//* #2  JFF    11/10/99 On Trace uniquement si l'execution de la Proc$$HEX1$$e900$$ENDHEX$$dure
//*							d'insertion s'est bien d$$HEX1$$e900$$ENDHEX$$roul$$HEX1$$e900$$ENDHEX$$e.
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

idcIdDoc = -1   // idcId_Doc sera pass$$HEX2$$e9002000$$ENDHEX$$par Ref $$HEX2$$e0002000$$ENDHEX$$PS_S02_ARCHIVE_RELANCES.
					 // et reviendra avec le nouvel Id_Doc cr$$HEX2$$e900e900$$ENDHEX$$.

/*------------------------------------------------------------------*/
/* Armement des variables.                                 			  */
/*------------------------------------------------------------------*/
sTypBlob = "DO"

dcIdSin 		= iDw1.GetItemNumber ( alRow, "ID_SIN"	  )
dcIdInter	= iDw1.GetItemNumber ( alRow, "ID_I" 	  )
idcIdDoc    = iDw1.GetItemNumber ( alRow, "ID_DOC"	  )  // Armement qui ne sert pas, puisque ser mis $$HEX2$$e0002000$$ENDHEX$$jour en retour de PS_I02_ARCHIVE_RELANCES
dcIdOrdre	= iDw1.GetItemNumber ( alRow, "ID_ORDRE" )
sIdAdh		= iDw1.GetItemString ( alRow, "ID_ADH"   )
sCodInter	= iDw1.GetItemString ( alRow, "COD_INTER")
sNom			= iDw1.GetItemString ( alRow, "NOM_INTER")
sMajPar		= stGlb.sCodOper
sValidePar	= iDw1.GetItemString ( alRow, "VALIDE_PAR")

/*------------------------------------------------------------------*/
/* #1 ,11/10/99, Gestion de l'Id_Adh $$HEX2$$e0002000$$ENDHEX$$Null					           */
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Mis $$HEX2$$e0002000$$ENDHEX$$jour du courrier original.
//* Commentaires	: On update Nbr_Conf $$HEX2$$e0002000$$ENDHEX$$1
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
Long		dcIdDoc			// n$$HEX2$$b0002000$$ENDHEX$$du document lu sur iDw1 et non pas le dernier Id_Doc pr$$HEX1$$e900$$ENDHEX$$sent
								// sur archive pour ce m$$HEX1$$ea00$$ENDHEX$$me interlocuteur, car il correspondrait au courrier
								// de relance qui vient juste d'$$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$crit.
Decimal {2} dcIdsin2, dcIdInter2, dcIdDoc2

dcIdSin 	 = iDw1.GetItemNumber ( alRow, "ID_SIN" )
dcIdInter = iDw1.GetItemNumber ( alRow, "ID_I"   )
dcIdDoc	 = iDw1.GetItemNumber ( alRow, "ID_DOC" )

If bOk Then

	/*------------------------------------------------------------------*/
	/* Pour un update, je ne cr$$HEX1$$e900$$ENDHEX$$e pas une nouvelle PS afin de ne pas    */
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


	isMess = "Probl$$HEX1$$e800$$ENDHEX$$me sur UPDATE, uf_MajAJourCourrierOriginal, u_Rl_Sp_Rel_Anc."

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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Chargement du param$$HEX1$$e800$$ENDHEX$$trage
//* Commentaires	: On Charge le param$$HEX1$$e800$$ENDHEX$$trage. (except$$HEX2$$e9002000$$ENDHEX$$pour les R1P et DR1)
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
			stMessage.sVar[1]  = "Probl$$HEX1$$e800$$ENDHEX$$me lors du chargement du param$$HEX1$$e800$$ENDHEX$$trage du produit. Le traitement n'est pas lanc$$HEX1$$e900$$ENDHEX$$."

			F_Message ( stMessage )
	
		End If


//	CASE "R1P", "DR1"
//		/*------------------------------------------------------------------*/
//		/* La procedure d'insertion du courrier de relance dans la base     */
//		/* attend l'idprod, voila pourquoi on va le chercher maintenant.    */
//		/* De plus si l'idprod revient $$HEX2$$e0002000$$ENDHEX$$0, cela nous indique que le        */
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Destruction d'une premi$$HEX1$$e800$$ENDHEX$$re relance.
//* Commentaires	: Le courrier original ne pourra jamais plus $$HEX1$$ea00$$ENDHEX$$tre relanc$$HEX1$$e900$$ENDHEX$$.
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

isMess = "Probl$$HEX1$$e800$$ENDHEX$$me sur DELETE FROM sysadm.w_cour_blob_arch, uf_DetruirePremiereRelance, u_Rl_Sp_Relance."

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
	
	
	isMess = "Probl$$HEX1$$e800$$ENDHEX$$me sur DELETE FROM sysadm.archive_blob, uf_DetruirePremiereRelance, u_Rl_Sp_Rel_Anc."
	
	
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
	
		isMess = "Probl$$HEX1$$e800$$ENDHEX$$me sur DELETE FROM sysadm.archive, uf_DetruirePremiereRelance, u_Rl_Sp_Rel_Anc."
	
		stMessage.bTrace = True
		If	Not F_Procedure ( stMessage, itrTrans, isMess )	Then
	
			bOk = False
			F_Commit ( iTrTrans, False )
			F_Message ( stMessage )
	
		End If
	
	End If
	
End If

/*------------------------------------------------------------------*/
/* On laisse la zone nbre_conf du courrier original $$HEX2$$e0002000$$ENDHEX$$1, de cette   */
/* fa$$HEX1$$e700$$ENDHEX$$ons il ne sera jamais relanc$$HEX1$$e900$$ENDHEX$$.                                */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On commit le tout.                                               */
/*------------------------------------------------------------------*/
If bOk Then

	F_Commit ( iTrTrans, True )
	isMess = "N$$HEX2$$b0002000$$ENDHEX$$du Row d$$HEX1$$e900$$ENDHEX$$truit dans la DataWindow : " + String ( lRow ) + ", Sinistre : " + String ( dcIdSin )
	iDw1.DeleteRow ( lRow )

End If

Return bOk

end function

public function boolean uf_lancertrt (ref boolean absaisie);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_LancerTrt	(Public)
//* Auteur			: Fabry JF
//* Date				: 11/06/1999 10:23:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Lancement du Traitement.
//* Commentaires	: Cette fonction contient une partie du lancement
//*					  du traitement, la suite est sur ue_Item7 de la fen$$HEX1$$ea00$$ENDHEX$$tre.
//*
//* Arguments		: Boolean 		abSaisie				(Ref)    Valeur de retour bool$$HEX1$$e900$$ENDHEX$$enne indiquant que le traitement 
//*																			n'est pas lanc$$HEX1$$e900$$ENDHEX$$, non pas pour un probl$$HEX1$$e800$$ENDHEX$$me quelconque mais
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

//		D$$HEX1$$e900$$ENDHEX$$port$$HEX2$$e9002000$$ENDHEX$$dans l'objet fen$$HEX1$$ea00$$ENDHEX$$tre w_a_sp_relance::spb_imprimerdossier
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

//		D$$HEX1$$e900$$ENDHEX$$port$$HEX2$$e9002000$$ENDHEX$$dans l'objet fen$$HEX1$$ea00$$ENDHEX$$tre w_a_sp_relance::spb_imprimerdossier
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controle la saisie 
//* Commentaires	: Contr$$HEX1$$f400$$ENDHEX$$le de la saisie sur 3 DataWindows diff$$HEX1$$e900$$ENDHEX$$rentes.
//*					  $$HEX2$$e0002000$$ENDHEX$$des moments diff$$HEX1$$e900$$ENDHEX$$rents, c'est $$HEX2$$e0002000$$ENDHEX$$dire au chargement et au lancement.
//*					  
//*
//* Arguments		: Integer		aCas			(Val)			1 : Contr$$HEX1$$f400$$ENDHEX$$le de saisie pour chargement
//*																		2 : Contr$$HEX1$$f400$$ENDHEX$$le de saisie pour Lancement
//*
//* Retourne		: Boolean, True tout est renseign$$HEX1$$e900$$ENDHEX$$.
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
sErr[ 2 ]  = "- La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence sinistre"


sSautLigne = "~r"
sText 	  = sSautLigne


/*------------------------------------------------------------------*/
/* Contr$$HEX1$$f400$$ENDHEX$$le de la saisie au chargement des donn$$HEX1$$e900$$ENDHEX$$es, suite au click  */
/* sur le bouton CHARGER.                                           */
/*------------------------------------------------------------------*/
If aCas = 1 Then

 CHOOSE CASE isTypTrt

	CASE "R1A", "R1U", "R2"

		/*------------------------------------------------------------------*/
		/* Contr$$HEX1$$f400$$ENDHEX$$le de la saisie sur Dw_Produit                             */
		/*------------------------------------------------------------------*/
		If IsNull ( iDwProduit.GetItemNumber ( 1, sCol[ 1 ] ) ) Then
			bOk = False	
			sText += sErr[ 1 ] + sSautLigne
		End If



	CASE "R1T", "SOL"

		/*------------------------------------------------------------------*/
		/* Contr$$HEX1$$f400$$ENDHEX$$le de la saisie sur Dw_Produit                             */
		/*------------------------------------------------------------------*/
		If IsNull ( iDwProduit.GetItemNumber ( 1, sCol[ 1 ] ) ) Then
			bOk = False	
			sText += sErr[ 1 ] + sSautLigne
		End If



	CASE "R1P", "DR1"

		/*------------------------------------------------------------------*/
		/* Contr$$HEX1$$f400$$ENDHEX$$le de la saisie sur Dw_SaisieSin									  */
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
/* Contr$$HEX1$$f400$$ENDHEX$$le de la saisie au lancement du traitement, suite au       */
/* click sur le(s) boutons LANCER, DETRUIRE, SOLDER.                */
/*------------------------------------------------------------------*/
If aCas = 2 Then

 CHOOSE CASE isTypTrt

	CASE "R1P", "DR1"

		/*------------------------------------------------------------------*/
		/* Contr$$HEX1$$f400$$ENDHEX$$le de la s$$HEX1$$e900$$ENDHEX$$lection d'un courrier									  */
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du libell$$HEX2$$e9002000$$ENDHEX$$de produit ayant permis de charger
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
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Gestion de la signature $$HEX1$$e900$$ENDHEX$$lectronique.
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
/* Immediatement par d$$HEX1$$e900$$ENDHEX$$faut on alloue une signature SPB             */
/*------------------------------------------------------------------*/
isFicSig = isRepSig + "DEFAUT." + isFmtSig

/*------------------------------------------------------------------*/
/* y a-t-il alors une signature par d$$HEX1$$e900$$ENDHEX$$faut pour ce produit ? 		  */
/*------------------------------------------------------------------*/
sFic = isRepSig + String ( alIdProd ) + "\DEFAUT." + isFmtSig
//Migration PB8-WYNIWYG-03/2006 FM
//If FileExists ( sFic ) Then
If f_FileExists ( sFic ) Then
//Fin Migration PB8-WYNIWYG-03/2006 FM
	isFicSig = sFic
End If

/*-------------------------------------------------------------------*/
/* Le Gestionnaire qui a $$HEX1$$e900$$ENDHEX$$crit le courrier d'origine a-t-il le droit */
/* d'utiliser la signature personnalis$$HEX1$$e900$$ENDHEX$$e ?                           */
/*-------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/* #1 : Ajout de l'identifiant interlocuteur $$HEX2$$e0002000$$ENDHEX$$la fonction uf_GetAutorisation */
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
/* On remplace "\" par "\\" pour interpr$$HEX1$$e900$$ENDHEX$$tation correcte dans word  */
/*------------------------------------------------------------------*/
isFicSig  = F_Remplace ( isFicSig, "\", "\\" )



end subroutine

public function long uf_zn_taillelot (integer acas);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Zn_TailleLot	  (Public)
//* Auteur			: Fabry JF
//* Date				: 11/06/1999 16:01:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de la zone Dw_TailleLot
//* Commentaires	: (ItemChanged de Dw_TailleLot)
//*
//* Arguments		: Int			aCas			(Val)			1 --> Contr$$HEX1$$f400$$ENDHEX$$le de la zone
//*																   2 --> Gestion de l'erreur
//*
//Migration PB8-WYNIWYG-03/2006 FM
////* Retourne		: Rien
//*	Retourne		: long  r$$HEX1$$e900$$ENDHEX$$sultat du SetActionCode
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
/* Cont$$HEX1$$f400$$ENDHEX$$le de la zone (ItemChanged).                                */
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le de la zone Id_Sin 
//* Commentaires	: (ItemChanged de Dw_SaisieSin)
//*
//* Arguments		: Int			aCas			(Val)			1 --> Contr$$HEX1$$f400$$ENDHEX$$le de la zone
//*																   2 --> Gestion de l'erreur
//*
//Migration PB8-WYNIWYG-03/2006 FM
////* Retourne		: Rien
//*	Retourne		: long  r$$HEX1$$e900$$ENDHEX$$sultat du SetActionCode
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
/* Cont$$HEX1$$f400$$ENDHEX$$le de la zone (ItemChanged).                                */
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
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Lecture des droits d'autorisation/refus, pour ce gestionnaire et 
//*					  ce produit (ou tout produit), permettant de modifier le contenu des courriers.
//*					  Le BIN de retour indique $$HEX1$$e900$$ENDHEX$$galement si le gestionnaire est en validation
//*					  autonome ou pas.
//* Commentaires  :  ! MAINTENANCE A FAIRE AUSSI L'OBJET DE SINISTRE !
//*
//* Arguments     : 	String		asIdNatCour		val	Nature du courrier compos$$HEX2$$e9002000$$ENDHEX$$et $$HEX2$$e0002000$$ENDHEX$$analyser
//*						String		asBIN				r$$HEX1$$e900$$ENDHEX$$f	Bin de retour (voir ci-dessous d$$HEX1$$e900$$ENDHEX$$codage)
//*						Boolean		abModifCour		r$$HEX1$$e900$$ENDHEX$$f	TRUE : Le courrier compos$$HEX2$$e9002000$$ENDHEX$$peut $$HEX1$$ea00$$ENDHEX$$tre modifi$$HEX2$$e9000900$$ENDHEX$$et donc sauvegard$$HEX1$$e900$$ENDHEX$$.
//*						Boolean		abValAuto		r$$HEX1$$e900$$ENDHEX$$f	TRUE : Le gestionnaire est en mode Validation autonome
//*						Boolean		abValidation	r$$HEX1$$e900$$ENDHEX$$f	TRUE : Le gestionnaire a le droit de Valider (phase validation)
//*						Long			alIdProd			Val	Code Produit
//*						String		asCodOper		Val	Code User
//							Integer     aiIdi				Val   Code Interlocuteur
//*
//*						D$$HEX1$$e900$$ENDHEX$$codage du BIN de 6 chiffres $$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$couper sous la forme
//*					   1er    0/1     $$HEX2$$e0002000$$ENDHEX$$1 --> Autoriser modif Cr. Questionnaire 
//*					   2$$HEX1$$e800$$ENDHEX$$me   0/1     $$HEX2$$e0002000$$ENDHEX$$1 --> Autoriser modif Cr. Dem. Pi$$HEX1$$e800$$ENDHEX$$ce
//*					   3$$HEX1$$e800$$ENDHEX$$me   0/1     $$HEX2$$e0002000$$ENDHEX$$1 --> Autoriser modif Cr. Prise en charge
//*					   4$$HEX1$$e800$$ENDHEX$$me   0/1     $$HEX2$$e0002000$$ENDHEX$$1 --> Autoriser modif Cr. Refus
//*					   5$$HEX1$$e800$$ENDHEX$$me   0/1     $$HEX2$$e0002000$$ENDHEX$$1 --> Autoriser modif Cr. R$$HEX1$$e900$$ENDHEX$$glement
//*                  6$$HEX1$$e800$$ENDHEX$$me   0/1     $$HEX2$$e0002000$$ENDHEX$$1 --> Autoriser Validation autonome
//*					   7$$HEX1$$e800$$ENDHEX$$me	 0/1		$$HEX2$$e0002000$$ENDHEX$$1 --> Autoriser Phase Validation
//*					   8$$HEX1$$e800$$ENDHEX$$me	 0/1		$$HEX2$$e0002000$$ENDHEX$$1 --> Autoriser Signature $$HEX1$$e900$$ENDHEX$$lectronique
//*						9$$HEX1$$e800$$ENDHEX$$me	 0/1		$$HEX2$$e0002000$$ENDHEX$$1 --> Autoriser Gestionnaire DSC
//*					   10$$HEX1$$e800$$ENDHEX$$me	 0/1		$$HEX2$$e0002000$$ENDHEX$$1 --> Autoriser Nom&Pr$$HEX1$$e900$$ENDHEX$$nom gestionnaire sur Courrier
//*					   11$$HEX1$$e800$$ENDHEX$$me	 0/1		$$HEX2$$e0002000$$ENDHEX$$1 --> Autoriser Aucune signature
//*						12$$HEX1$$e800$$ENDHEX$$me  0/1     $$HEX2$$e0002000$$ENDHEX$$1 --> Autoriser envoi mail
//*                  13$$HEX1$$e800$$ENDHEX$$me  0/1     $$HEX2$$e0002000$$ENDHEX$$1 --> Autoriser modif mail
//*						14$$HEX1$$e800$$ENDHEX$$me  0/1     $$HEX2$$e0002000$$ENDHEX$$1 --> Autoriser modif mail R$$HEX1$$e900$$ENDHEX$$glement
//*						15$$HEX1$$e800$$ENDHEX$$me  0/1     $$HEX2$$e0002000$$ENDHEX$$1 --> Autoriser modif mail Refus
//*						16$$HEX1$$e800$$ENDHEX$$me  0/1     $$HEX2$$e0002000$$ENDHEX$$1 --> Autoriser envoi mail Cr. Particulier	 
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
/* D$$HEX1$$e900$$ENDHEX$$finiton des droits.                                            */
/*------------------------------------------------------------------*/
sTabDroit [1] = "1"		// Autoriser modif Cr. Questionnaire 
sTabDroit [2] = "2"		// Autoriser modif Cr. Dem. Pi$$HEX1$$e800$$ENDHEX$$ce
sTabDroit [3] = "3"		// Autoriser modif Cr. Prise en charge
sTabDroit [4] = "4"		// Autoriser modif Cr. Refus
sTabDroit [5] = "5"		// Autoriser modif Cr. R$$HEX1$$e900$$ENDHEX$$glement
sTabDroit [6] = "6"		// Autoriser Validation autonome
sTabDroit [7] = "7"		// Autoriser $$HEX2$$e0002000$$ENDHEX$$Valider (phase validation)
sTabDroit [8] = "8"		// Autoriser $$HEX2$$e0002000$$ENDHEX$$utiliser la signature $$HEX1$$e900$$ENDHEX$$lectronique.
sTabDroit [9] = "9"		// Autoriser Gestionnaire DSC.
sTabDroit [10] = "10"	// Autoriser Nom&Pr$$HEX1$$e900$$ENDHEX$$nom gestionnaire sur courrier
sTabDroit [11] = "11"	// Autoriser Aucune signature

/*------------------------------------------------------------------*/
/* #1 04/08/2006 MADM D$$HEX1$$e900$$ENDHEX$$finiton des nouveaux  droits.               */
/*------------------------------------------------------------------*/
sTabDroit [12] = "12"		// Autoriser envoi mail
sTabDroit [13] = "13"		// Autoriser modif mail
sTabDroit [14] = "14"		// Autoriser modif mail R$$HEX1$$e900$$ENDHEX$$glement
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
	/* alors un droit par d$$HEX1$$e900$$ENDHEX$$faut.                                       */
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
	/* Sinon si aucun droit n'est affect$$HEX1$$e900$$ENDHEX$$, c'est par d$$HEX1$$e900$$ENDHEX$$faut un refus de */
	/* modifier.                                                        */
	/*------------------------------------------------------------------*/
	asBIN += "0"

Next	

/*------------------------------------------------------------------*/
/* Correction du BIN pour le cas de certaines incoh$$HEX1$$e900$$ENDHEX$$rence.          */
/*------------------------------------------------------------------*/
/* Impossible d'avoir 8 et 11 en m$$HEX1$$ea00$$ENDHEX$$me temps et pourtant le          */
/* param$$HEX1$$e800$$ENDHEX$$trage permet de le faire.                                  */
/*------------------------------------------------------------------*/
If Mid ( asBIN, 8, 1 ) = "1" And Mid ( asBIN, 11, 1 ) = "1" Then
	sFindTrt = sFindOrig + sTabDroit [ 8 ] + " AND ID_PROD = " + sIdProd
	lRow = idwAutorisation.Find ( sFindTrt, 1, lTotAuto )

	/*------------------------------------------------------------------*/
	/* 8 est plus fort dans ce cas puiqu'associ$$HEX2$$e9002000$$ENDHEX$$au produit, on annule  */
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
/* A-t-on un code courrier $$HEX2$$e0002000$$ENDHEX$$analyser ?                             */
/*------------------------------------------------------------------*/
If asIdNatCour <> "" Then

	bFin = False
	
	/*------------------------------------------------------------------*/
	/* #1 MADM 04/08/2006 : gestion des droits 13 Autoriser Modif Mail  */
	/* en fonction du canal de l'interlocuteur                          */
	/*------------------------------------------------------------------*/
	 lRow = idw1.Find ( "ID_I = " + String ( aiIdi ), 1, idw1.Rowcount () )
	/*------------------------------------------------------------------*/
	/* #1 On d$$HEX1$$e900$$ENDHEX$$termine le canal (Mail ou courrier) de l'interlocuteur   */
	/*------------------------------------------------------------------*/
	 sAltSuiviMail = idw1.GetItemString (lRow , "ALT_SUIVI_MAIL")
	//[DNTMAIL1-2_MEP_DEF] For$$HEX1$$e700$$ENDHEX$$age $$HEX2$$e0002000$$ENDHEX$$supprimer lors de la MEP finale.
	sAltSuiviMail = "N"
	
	/*--------------------------------------------------------------------------------------------*/
	/* #1 Si le canal est $$HEX1$$e900$$ENDHEX$$gal $$HEX2$$e0002000$$ENDHEX$$Mail et que le droit 13 est $$HEX1$$e900$$ENDHEX$$gal $$HEX2$$e0002000$$ENDHEX$$1 alors abModifCour est vraie */
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
		/* Droit $$HEX2$$e0002000$$ENDHEX$$modifier les courriers de r$$HEX1$$e900$$ENDHEX$$glement                      */
		/*------------------------------------------------------------------*/
		If abModifCour Then
			Choose Case Mid ( asIdNatCour, 3, 1 )
				Case "C", "V"   // Ch$$HEX1$$e900$$ENDHEX$$que et virement
				/*------------------------------------------------------------------*/
				/* #1 Si le canal est diff$$HEX1$$e900$$ENDHEX$$rent de Mail alors abModifCour est vraie */
				/*------------------------------------------------------------------*/ 
				 If sAltSuiviMail <> "O" Then
					 abModifCour = Mid ( asBIN, 5, 1 ) = "1" 
				 Else
				/*--------------------------------------------------------------------------------------------*/
				/* #1 Si le canal est $$HEX1$$e900$$ENDHEX$$gal $$HEX2$$e0002000$$ENDHEX$$Mail et que le droit 14 est $$HEX1$$e900$$ENDHEX$$gal $$HEX2$$e0002000$$ENDHEX$$1 alors abModifCour est vraie */
				/*--------------------------------------------------------------------------------------------*/
				    abModifCour = Mid ( asBIN, 5, 1 ) = "1" And Mid ( asBIN, 14, 1 ) = "1" 
				 End If	 

				/*------------------------------------------------------------------*/
				/* Droit $$HEX2$$e0002000$$ENDHEX$$modifier les courriers de prise en charge                */
				/*------------------------------------------------------------------*/
				Case "E"
					abModifCour = Mid ( asBIN, 3, 1 ) = "1" 
	
			End Choose
		End If	
		/*------------------------------------------------------------------*/
		/* Droit $$HEX2$$e0002000$$ENDHEX$$modifier les courriers de demande de pi$$HEX1$$e800$$ENDHEX$$ce.				  */
		/*------------------------------------------------------------------*/
		If abModifCour Then
			If Mid ( asIdNatCour, 4, 1 ) = "P" Then
				abModifCour = Mid ( asBIN, 2, 1 ) = "1" 
			End If
		End If
		
		/*------------------------------------------------------------------*/
		/* Droit $$HEX2$$e0002000$$ENDHEX$$modifier les courriers de refus.								  */
		/*------------------------------------------------------------------*/
		If abModifCour Then
			If Mid ( asIdNatCour, 5, 1 ) = "R" Then
				/*------------------------------------------------------------------*/
				/* #1 Si le canal est diff$$HEX1$$e900$$ENDHEX$$rent de Mail alors abModifCour est vraie */
				/*------------------------------------------------------------------*/ 
				If sAltSuiviMail <> "O" Then
					abModifCour = Mid ( asBIN, 4, 1 ) = "1" 
				Else 
					/*--------------------------------------------------------------------------------------------*/
					/* #1 Si le canal est $$HEX1$$e900$$ENDHEX$$gal $$HEX2$$e0002000$$ENDHEX$$Mail et que le droit 15 est $$HEX1$$e900$$ENDHEX$$gal $$HEX2$$e0002000$$ENDHEX$$1 alors abModifCour est vraie */
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
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : Ecriture du courrier de relance fusionn$$HEX1$$e900$$ENDHEX$$, en base type DO
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
	sTitre		= mid(isTxtCompoOri, len(stglb.sreptempo)+1) // pour extraire le nom du fichier g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$
	sTxtCompo 	= isTxtCompoOri
	sAltPart		= "O"
end if

Choose Case Left ( iDw1.GetitemString ( alRow, "ID_COUR" ), 1 )
	Case "Q"		// Questionnaire
		sBac = "MILIEU"
	Case "B"		// Courrier Banque
		sBac = "HAUT"
	Case Else	// Courrier Assur$$HEX2$$e9002000$$ENDHEX$$+ autres
		sBac = "BAS"
End Choose	

/*------------------------------------------------------------------*/
/* Insertion d'un enregistrement populis$$HEX2$$e9002000$$ENDHEX$$dans DwGenCourrier.       */
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Chargement de Dw_Courrier
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
	
	// Premi$$HEX1$$e800$$ENDHEX$$res Relances Automatique.
	CASE "R1A", "R1U", "R1T", "R1P"
		lNbrRowDwCourrier = iDwCourrier.Retrieve ( string(ilProd), "1" )

	// Deuxi$$HEX1$$e800$$ENDHEX$$me Relances
	CASE "R2"
		lNbrRowDwCourrier = iDwCourrier.Retrieve ( string(ilProd), "2" )

END CHOOSE

/*------------------------------------------------------------------*/
/* Le retrieve s'est mal pass$$HEX1$$e900$$ENDHEX$$, on arr$$HEX1$$ea00$$ENDHEX$$te tout.                     */
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
/* Aucune ligne ramen$$HEX1$$e900$$ENDHEX$$e.														  */
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

//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre anc$$HEX1$$ea00$$ENDHEX$$tre
//* Commentaires	: Cette initialisation sera commune $$HEX2$$e0002000$$ENDHEX$$toutes les fen$$HEX1$$ea00$$ENDHEX$$tres descendantes.
//*					  - R1A  --> Premi$$HEX1$$e800$$ENDHEX$$res Relances Automatiques.
//*									 Edite les premi$$HEX1$$e800$$ENDHEX$$res relances des courriers Qxxxx, xxxPxx
//*
//*					  - R1U  --> Premi$$HEX1$$e800$$ENDHEX$$res Relances Automatiques pour les garanties UF avec Dem. Pces. $$HEX2$$e0002000$$ENDHEX$$la banque.
//*								  	 Suite DCMP000285 B. Levesque, Edite les premi$$HEX1$$e800$$ENDHEX$$res relances des courriers Qxxxx, xCxPxx, APART1
//*
//*					  - R1T  --> Premi$$HEX1$$e800$$ENDHEX$$res Relances Particuli$$HEX1$$e800$$ENDHEX$$res
//*                            Edite une LISTE des courriers APART1
//*                            Apr$$HEX1$$e800$$ENDHEX$$s un contr$$HEX1$$f400$$ENDHEX$$le visuel par la consultation, ces courriers pourront $$HEX1$$ea00$$ENDHEX$$tre
//*									 Relanc$$HEX1$$e900$$ENDHEX$$s par la fen$$HEX1$$ea00$$ENDHEX$$tre des relances ponctuelles.
//*
//*					  - R1P  --> Premi$$HEX1$$e800$$ENDHEX$$res Relances Ponctuelles.
//*									 Edite une premi$$HEX1$$e800$$ENDHEX$$re relance d'un courrier (n'ayant jamais $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$relanc$$HEX1$$e900$$ENDHEX$$), sans tenir
//*									 compte du param$$HEX1$$e800$$ENDHEX$$trage.
//*
//*					  - DR1  --> Annuler (D$$HEX1$$e900$$ENDHEX$$truire) une premi$$HEX1$$e800$$ENDHEX$$re relance.
//*									 Destruction d'une premi$$HEX1$$e800$$ENDHEX$$re relance, notamment pour les APART1. Une fois la relance d$$HEX1$$e900$$ENDHEX$$truite
//*									 le courrier original ne pourra jamais plus $$HEX1$$ea00$$ENDHEX$$tre relanc$$HEX1$$e900$$ENDHEX$$.
//*
//*					  - R2   --> Deuxi$$HEX1$$e800$$ENDHEX$$mes Relances.				
//*									 
//*
//* Arguments		: u_DataWindow					aDwProduit			(Ref) // S$$HEX1$$e900$$ENDHEX$$lection du produit
//*					  u_DataWindow					aDwSaisieSinot		(Ref)	// Saisie d'un num$$HEX1$$e900$$ENDHEX$$ro de sinistre
//*					  u_DataWindow_Accueil		aDw1					(Ref) // Dw_1 principale
//*					  DataWindow					aDwParaProd			(Ref) // DataWindow r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rant le param. du prod. S$$HEX1$$e900$$ENDHEX$$lect.
//*					  Datawindow					aDwPolice			(Ref) // DataWindow r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rant les polices, Cie.
//*					  Datawindow					aDwCivilite			(Ref) // Dw des civilit$$HEX1$$e900$$ENDHEX$$s (long, court)
//*					  String							asTypTrt				(Val) // Type de Relances
//*					  u_libelle_dga				auoLibelle			(Ref) // Objet servant $$HEX2$$e0002000$$ENDHEX$$construire le blob
//*					  u_Transaction				aTrTrans				(Ref) // Objet de transaction
//*					  u_BarreDefil					auoDefil				(Ref) // Jauge
//*					  DataWindow					adw_BoiteArchive	(Ref) // DW pour la gestion des boites archives
//*					  DataWindow					adw_DetPro			(Ref) // DW sur DET_PRO
//*				 	  DataWindow					adwGenCourrier		(R$$HEX1$$e900$$ENDHEX$$f) // Dw Gen Cour SVE DCMP 040020
//*					  Datawindow					adwAutorisation   (R$$HEX1$$e900$$ENDHEX$$f) // Dw des autorisation pour la Sign Elec.
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
/* Initialisation du le signature $$HEX1$$e900$$ENDHEX$$lectronique.                     */
/*------------------------------------------------------------------*/
isRepSig	= ProfileString ( stGLB.sFichierIni, "EDITION", "REP_SIGNATURE", "K:\SIGNPERS\" )
isFmtSig	= ProfileString ( stGLB.sFichierIni, "EDITION", "FMT_SIGNATURE", "TIF" )

idw_DetPro = adw_DetPro
idw_DetPro.SetTransObject ( itrTrans )

//* #1
idw_DetPro.Retrieve ( -1 )
idw_DetPro.Sort ()

/*------------------------------------------------------------------*/
/* On arme une variable contenant le r$$HEX1$$e900$$ENDHEX$$pertoire Windows             */
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

// On Ram$$HEX1$$e800$$ENDHEX$$ne dans la Dw1 toutes les lignes du select.
iDw1.ilMaxLig = 0
iuoDefil.uf_Init ( 0 )

/*------------------------------------------------------------------*/
/* Choix du dataobject en fonction du traitement de relance.        */
/*------------------------------------------------------------------*/
CHOOSE CASE isTypTrt
	
	/*------------------------------------------------------------------*/
	/* 1$$HEX1$$e800$$ENDHEX$$res Relances Automatiques                                      */
	/*------------------------------------------------------------------*/
	CASE "R1A"
		iDw1.DataObject = "D_SP_RELANCE_NORMALE"
		
	/*------------------------------------------------------------------*/
	/* 1$$HEX1$$e800$$ENDHEX$$res Relances Automatiques Gti Uf avec Dem. Pces BQ             */
	/*------------------------------------------------------------------*/
	CASE "R1U"
		iDw1.DataObject = "D_SP_REL1_AUTO_UFBQ"
		
	/*------------------------------------------------------------------*/
	/* 1$$HEX1$$e800$$ENDHEX$$res Relances Particuli$$HEX1$$e800$$ENDHEX$$res												  */
	/*------------------------------------------------------------------*/
	CASE "R1T"
		iDw1.DataObject = "D_SP_RELANCE_PARTICULIERE"

	/*------------------------------------------------------------------*/
	/* 1$$HEX1$$e800$$ENDHEX$$res Relances Ponctuelles                                       */
	/*------------------------------------------------------------------*/
	CASE "R1P"
		iDw1.DataObject = "D_SP_REL1_PONC"
		
	/*------------------------------------------------------------------*/
	/* D$$HEX1$$e900$$ENDHEX$$estruction d'une premi$$HEX1$$e800$$ENDHEX$$re relance.                             */
	/*------------------------------------------------------------------*/
	CASE "DR1"
		iDw1.DataObject = "D_SP_REL1_ANNUL"

	/*------------------------------------------------------------------*/
	/* 2$$HEX1$$e800$$ENDHEX$$mes Relances Automatiques                                      */
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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
/* G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration du courrier fusionn$$HEX1$$e900$$ENDHEX$$.                                 */
/*------------------------------------------------------------------*/
nvGenCourrier = Create N_Cst_Edition_Courrier

nvGenCourrier.uf_Initialiser ( "E" )
If nvGenCourrier.uf_InitialiserWord ( FALSE ) = 1 then 

	/*------------------------------------------------------------------*/
	/* G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration dans ouverture du Word par la suite (FALSE)           */
	/*------------------------------------------------------------------*/
	iRet = nvGenCourrier.uf_Generer_Courrier ( idwGenCourrier, FALSE )	
End If

Destroy nvGenCourrier

/*------------------------------------------------------------------*/
/* On relit le fichier DOC complet fusionn$$HEX13$$e900200020002000090009000900090009000900090020002000$$ENDHEX$$*/
/*------------------------------------------------------------------*/
If iRet > 0 Then 
	/*------------------------------------------------------------------*/  
	/* #1. DCMP-060643                                                  */
	/* Le 19/09/2006. Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire parametrable.  */
	/*------------------------------------------------------------------*/
	bRet = F_LireFichierBlob ( iblBlobDoc, stGLB.sRepTempo + "RELANCE.DOC" )

	If Not bRet Or Len ( iblBlobDoc ) < 5 Then 
		bRet = false

	end if

End If

if bRet then 
	/*------------------------------------------------------------------*/
	/* Ajout dans w_cour_blob_arch pour $$HEX1$$e900$$ENDHEX$$dition								  */
	/*------------------------------------------------------------------*/
	bRet = uf_maj_w_cour_blob_arch (alLigne)	
	
end if

if bRet then 
	isMess = "La g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration du courrier de relance a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$effectu$$HEX1$$e900$$ENDHEX$$e."
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Cr$$HEX1$$e900$$ENDHEX$$ation du courrier de relance.
//* Commentaires	: appel sur ue_ImprimerDossier.
//*
//* Arguments		: Long			alDossier			(Val)			Row du dossier $$HEX2$$e0002000$$ENDHEX$$traiter sur Dw_1
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean bOk = True

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation du Blob stock$$HEX2$$e9000900$$ENDHEX$$dans iblBlobData								  */
/*------------------------------------------------------------------*/
bOk = This.Uf_CreerBlob ( alDossier )

/*------------------------------------------------------------------*/
/* D$$HEX1$$e900$$ENDHEX$$termination du courrier, en fonction de l'interlocuteur et du  */
/* type de traitement, et d$$HEX1$$e900$$ENDHEX$$termination de la composition du code   */
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
/* On Update maintenant NBR_CONF $$HEX2$$e0002000$$ENDHEX$$1.                               */
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ecriture de la trace
//*
//* Commentaires	: 
//*					  
//*
//* Arguments		: Long	alRow			Row du dossier en cours sur Dw_1
//*																
//*					  String	asMessage	Message $$HEX2$$e0002000$$ENDHEX$$tracer.			
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
		// procedure de mise $$HEX2$$e0002000$$ENDHEX$$jour de la trace [trace_recap_relance]
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
	stMessage.sVar[1]   = "Probl$$HEX1$$e800$$ENDHEX$$me lors de l'$$HEX1$$e900$$ENDHEX$$criture de l'historique des relances."
	stMessage.sVar[1]  += " Le traitement est arr$$HEX1$$ea00$$ENDHEX$$t$$HEX1$$e900$$ENDHEX$$." 

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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Chargement de Dw_Police
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

Int			iRow				// Nombre de ligne Charg$$HEX1$$e900$$ENDHEX$$es
Int			iCpt				// Compteur
Int			iTotRow			// Nombre total de Row dans DwPolice
Int			iRevSav			// Sauvegarde du la Revision dans DwPolice
Int			iRevCour			// Revision courante dans Dw_Police
String		sRech				// Cha$$HEX1$$ee00$$ENDHEX$$ne de recherche

iiTotLigPol = -1
iDwPolice.Reset ()

iRow = iDwPolice.Retrieve ( lIdProd )

/*------------------------------------------------------------------*/
/* Le retrieve s'est mal pass$$HEX1$$e900$$ENDHEX$$, on arr$$HEX1$$ea00$$ENDHEX$$te tout.                     */
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
	stMessage.sVar[1]  = "Probl$$HEX1$$e800$$ENDHEX$$me lors du chargement des polices. Le traitement n'est pas lanc$$HEX1$$e900$$ENDHEX$$"

	F_Message ( stMessage )

End If


/*------------------------------------------------------------------*/
/* sinon on nettoie    DwPolice afin de ne pas garder dans la DW    */
/* les lignes pour lesquelles, il y a deux n$$HEX2$$b0002000$$ENDHEX$$de police diff$$HEX1$$e900$$ENDHEX$$rents  */
/* pour la m$$HEX1$$ea00$$ENDHEX$$me r$$HEX1$$e900$$ENDHEX$$vision.                                           */
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
				
			//.. Cas de la premi$$HEX1$$e800$$ENDHEX$$re ligne, un peu sp$$HEX1$$e900$$ENDHEX$$cial.
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
	/* On affecte d$$HEX1$$e900$$ENDHEX$$finitivement le nombre de lignes de Dw_Police dans  */
	/* une variable d'instance afin de ne pas avoir $$HEX2$$e0002000$$ENDHEX$$le recalculer $$HEX4$$e000200020002000$$ENDHEX$$*/
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [DCMP090552] Gestion des num$$HEX1$$e900$$ENDHEX$$ros de tel $$HEX1$$e900$$ENDHEX$$tranger
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

