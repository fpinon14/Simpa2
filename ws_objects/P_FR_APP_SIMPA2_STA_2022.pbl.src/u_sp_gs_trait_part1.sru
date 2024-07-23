$PBExportHeader$u_sp_gs_trait_part1.sru
$PBExportComments$--- } UserObjet pour traitement particulier 1
forward
global type u_sp_gs_trait_part1 from nonvisualobject
end type
end forward

global type u_sp_gs_trait_part1 from nonvisualobject
end type
global u_sp_gs_trait_part1 u_sp_gs_trait_part1

type variables
Protected :

U_Transaction		iTrTrans

U_DataWindow		iDwSaisie
U_DataWindow_Accueil	iDw1

StaticText		istEnCours

Int			iiHautHeader, iiHautFooter
end variables

forward prototypes
private function boolean uf_controlersaisie ()
public subroutine uf_initialiser (ref u_datawindow adwsaisie, ref u_datawindow_accueil adw1, ref statictext astencours, ref u_transaction atrtrans)
public subroutine uf_imprimer ()
public subroutine uf_lancer (ref picturebutton apbimprimer, ref picturebutton apbexcel)
public subroutine uf_excel ()
private function boolean uf_zn_ctrl ()
private function boolean uf_zn_perdecdeb ()
private function boolean uf_zn_perdecfin ()
private subroutine uf_zn_zerreur (string ascolerr)
private function boolean uf_zn_perdebarret ()
private function boolean uf_zn_perfinarret ()
end prototypes

private function boolean uf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_ControlerSaisie (Private)
//* Auteur			: Fabry JF
//* Date				: 10/05/1999 19:32:28
//* Libellé			: Contrôle la saisie de iDwSaisie.
//* Commentaires	: Les zones étant contrôlées chacune au moment de la
//*					  saisie, cette fonction regarde uniquement si tous les
//*					  champs ont été saisies.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean			    bRet = true
DataWindowChild    dwcPeriode
Long					 lPeriodeArret, lCpt

stMessage.sTitre  = "SIMPA2"
stMessage.Icon	  	= Information!

iDwSaisie.AcceptText()

/*------------------------------------------------------------------*/
/* Si l'item n'est pas accepté, on ne lance pas le contrôle         */
/*------------------------------------------------------------------*/
If iDwSaisie.ibErreur then 
	bRet = False
	iDwSaisie.SetFocus()
End If


/*------------------------------------------------------------------*/
/* Controle de la coherence des zones entre elles.                  */
/*------------------------------------------------------------------*/
bRet = This.Uf_Zn_Ctrl ()


/*-----------------------------------------------------------------*/
/* CAS 1 : La date de début de déclaration doit toujours être      */
/*			  renseignée.			 	 											 */
/*-----------------------------------------------------------------*/
If bRet Then

	If IsNull ( iDwSaisie.GetItemString ( 1, "PERDECDEB" ) ) Then

		bRet= False
		stMessage.bErreurG= TRUE
		stMessage.sCode	= "EWK0012"	
		stMessage.sVar[1] = "la date de début de déclaration"
   	F_Message ( stMessage )

	End IF

End If


/*-----------------------------------------------------------------*/
/* CAS 2 : La date de fin   de déclaration doit toujours être      */
/*			  renseignée.			 	 											 */
/*-----------------------------------------------------------------*/
If bRet Then

	If IsNull ( iDwSaisie.GetItemString ( 1, "PERDECFIN" ) ) Then

		bRet= False
		stMessage.bErreurG= TRUE
		stMessage.sCode	= "EWK0012"	
		stMessage.sVar[1] = "la date de fin de déclaration"
   	F_Message ( stMessage )

	End IF

End If

/*-----------------------------------------------------------------*/
/* CAS 3 : La date de début d'arrêt des refus doit toujours être   */
/*			  renseignée.			 	 											 */
/*-----------------------------------------------------------------*/
If bRet Then

	If IsNull ( iDwSaisie.GetItemString ( 1, "PERDEBARRET" ) ) Then

		bRet= False
		stMessage.bErreurG= TRUE
		stMessage.sCode	= "EWK0012"	
		stMessage.sVar[1] = "la date de début des refus"
   	F_Message ( stMessage )

	End IF

End If


/*-----------------------------------------------------------------*/
/* CAS 4 : La date de fin d'arrêt des refus doit toujours être     */
/*			  renseignée.			 	 											 */
/*-----------------------------------------------------------------*/
If bRet Then

	If IsNull ( iDwSaisie.GetItemString ( 1, "PERFINARRET" ) ) Then

		bRet= False
		stMessage.bErreurG= TRUE
		stMessage.sCode	= "EWK0012"	
		stMessage.sVar[1] = "la date de fin des refus"
   	F_Message ( stMessage )

	End IF

End If


/*-----------------------------------------------------------------*/
/* CAS 5 : Le produit doit toujours être renseigné.					 */
/*-----------------------------------------------------------------*/
If bRet Then

	If IsNull ( iDwSaisie.GetItemNumber ( 1, "NUM_PROD" ) ) Then

		bRet= False
		stMessage.bErreurG= TRUE
		stMessage.sCode	= "EWK0012"	
		stMessage.sVar[1] = "le produit"
   	F_Message ( stMessage )

	End IF

End If


/*------------------------------------------------------------------*/
/* CAS 6 : On vérifie que la période d'arrêt des refus existe bien  */
/*         sur la table cum_periode. Si ce n'est pas le cas on ne   */
/* 		  lance pas le traitement.                                 */
/*         Par logique, si la période d'arrêt des refus existe, les */
/*         périodes de début et de fin de déclaration existe aussi. */
/*------------------------------------------------------------------*/
If bRet Then
	
	iDwSaisie.GetChild ( "PERFINARRET", dwcPeriode )
	dwcPeriode.SetTransObject ( iTrTrans )

	lPeriodeArret = dwcPeriode.GetItemNumber ( dwcPeriode.GetRow(), "ID_PERIODE" )

	/*------------------------------------------------------------------*/
	/* Je décide ici de ne pas créer une nouvelle procédure stockée     */
	/* sur la base, afin de ne pas la surcharger un peu plus. Le        */
	/* traitement sur demande est bien moins utilisé, que toutes les    */
	/* autres fenêtres de SIMPA2. Ainsi je pense qu'il est préférable   */
	/* dans ce cas de faire un SELECT en PB (qui sera compilé à chaque  */
	/* lancement bien entendu.)                                         */
	/*------------------------------------------------------------------*/

	lCpt = 0
	SELECT COUNT (*)
	INTO	 :lCpt
	FROM   sysadm.cum_periode
   WHERE  id_periode = :lPeriodeArret
	USING  iTrTrans ;


	If lCpt <= 0 Then

		bRet= False
		stMessage.bErreurG= FALSE
		stMessage.sCode	= "EWK0020"	
		stMessage.sVar[1] = "période des refus"
   	F_Message ( stMessage )

	End IF


End If




Return bRet
end function

public subroutine uf_initialiser (ref u_datawindow adwsaisie, ref u_datawindow_accueil adw1, ref statictext astencours, ref u_transaction atrtrans);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Initialisation (Public)
//* Auteur			: Fabry JF
//* Date				: 07/05/1999 17:03:49
//* Libellé			: Initialisation de l'objet
//* Commentaires	: 
//*
//* Arguments		: U_DataWindow				aDwSaisie		(REF) 	DW de saisie des arguments
//*					  U_Datawindow_Accueil	aDw1				(REF)		DW d'affichage de l'état
//*					  StaticText				stEnCours		(REF)		Static Text indiquant la progression
//*					  U_Transaction			aTrTrans			(REF)	
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild	dwChild
String 				sFicPeriode
n_cst_string			lnvString // [MIGPB11] [EMD] : ImportFile d'une chaine vide

iDw1			= aDw1
idwSaisie	= adwSaisie
istEnCours  = astEnCours
itrTrans		= atrTrans

/*------------------------------------------------------------------*/
/* Intialistation de iDw1														  */
/*------------------------------------------------------------------*/
iDw1.Hide ()

iDw1.DataObject = "D_R_REF5"


iiHautHeader = Integer ( iDw1.Describe("DataWindow.Header.Height") )
iiHautFooter = Integer ( iDw1.Describe("DataWindow.Footer.Height") )
iDw1.Modify("datawindow.Header.Height=0")
iDw1.Modify("datawindow.Footer.Height=0")

iDw1.ilMaxLig	 = 0


/*------------------------------------------------------------------*/
/* Le texte de StEncours (statictext) est rentré une fois pour      */
/* toute. on jouera ensuite avec Show() et Hide() pour l'affichage. */
/*------------------------------------------------------------------*/
iStEnCours.Hide()
iStEnCours.Text = "Traitement en cours, veuillez patienter..."

/*------------------------------------------------------------------*/
/* On récupére le fichier pour les périodes de traitement.          */
/*------------------------------------------------------------------*/
sFicPeriode = ProfileString ( stGLB.sFichierIni, "TRAITEMENT", "FICHIER_PERIODE", "" )

If Not lnvString.of_isEmpty ( sFicPeriode ) Then // [MIGPB11] [EMD] : ImportFile d'une chaine vide
	/*------------------------------------------------------------------*/
	/* Populise les Trois DDDW des dates							*/
	/*------------------------------------------------------------------*/
	idwSaisie.GetChild ( "PERDECDEB", dwChild )
	dwChild.ImportFile ( sFicPeriode )
	dwChild.SetFilter ( "DTE_DEB < Today()" )
	dwChild.Filter()
	dwChild.Sort ( )
	
	idwSaisie.GetChild ( "PERDECFIN", dwChild )
	dwChild.ImportFile ( sFicPeriode )
	dwChild.SetFilter ( "DTE_DEB < Today()" )
	dwChild.Filter()
	dwChild.Sort ( )
	
	idwSaisie.GetChild ( "PERDEBARRET", dwChild )
	dwChild.ImportFile ( sFicPeriode )
	dwChild.SetFilter ( "DTE_DEB < Today()" )
	dwChild.Filter()
	dwChild.Sort ( )
	
	idwSaisie.GetChild ( "PERFINARRET", dwChild )
	dwChild.ImportFile ( sFicPeriode )
	dwChild.SetFilter ( "DTE_DEB < Today()" )
	dwChild.Filter()
	dwChild.Sort ( )
End If // [MIGPB11] [EMD] : ImportFile d'une chaine vide

/*------------------------------------------------------------------*/
/* Populise la DDDW des produits												  */
/*------------------------------------------------------------------*/
idwSaisie.GetChild ( "NUM_PROD", dwChild )
dwChild.SetTransObject ( itrTrans )
dwChild.Retrieve()


/*------------------------------------------------------------------*/
/* Initialisation de iDwSaisie												  */
/*------------------------------------------------------------------*/
idwSaisie.InsertRow ( 0 )


end subroutine

public subroutine uf_imprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Imprimer (Public)
//* Auteur			: Fabry JF
//* Date				: 19/05/1999 11:50:48
//* Libellé			: Impression de l'état.
//* Commentaires	: Lancé à partir du bouton pb_Imprimer de la fenêtre
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iDw1.SetRedraw ( False )

iDw1.Modify("datawindow.Header.Height=" + String ( iiHautHeader ) )
iDw1.Modify("datawindow.Footer.Height=" + String ( iiHautFooter ) )

iDw1.Print()

iDw1.Modify("datawindow.Header.Height=0")
iDw1.Modify("datawindow.Footer.Height=0")

iDw1.SetRedraw ( True )

/*------------------------------------------------------------------*/
/* Box indiquant la fin de l'impression de l'état.                  */
/*------------------------------------------------------------------*/
Beep(1)
stMessage.bErreurG = False
stMessage.sCode	 = "EWK0021"
stMessage.sTitre   = "Traitement Particulier - SIMPA2"
stMessage.Icon	    = Information!
stMessage.Bouton   = Ok!

F_Message ( stMessage )

end subroutine

public subroutine uf_lancer (ref picturebutton apbimprimer, ref picturebutton apbexcel);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Lancer (Public)
//* Auteur			: Fabry JF
//* Date				: 11/05/1999 15:38:12
//* Libellé			: Lance le retrieve après contrôle
//* Commentaires	: 
//*
//* Arguments		: PictureButton			aPbImprimer				Bouton imprimer sur fenêtre.
//*					  PictureButton			aPbExcel					Bouton Fichier Excel sur fenêtre.
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long					lPerDecDeb, lPerDecFin, lPerDebArret, lPerFinArret, lProd
String				sNbPage												// Nombre de pages de l'état
DataWindowChild	dwcPeriode

If This.Uf_ControlerSaisie () Then

	idw1.Hide()
	iStEncours.Show()
	aPbImprimer.enabled = False
	aPbExcel.enabled 	  = False

	iDwSaisie.GetChild ( "PERDECDEB", dwcPeriode )
	dwcPeriode.SetTransObject ( iTrTrans )
	lPerDecDeb = dwcPeriode.GetItemNumber ( dwcPeriode.GetRow(), "ID_PERIODE" )

	iDwSaisie.GetChild ( "PERDECFIN", dwcPeriode )
	dwcPeriode.SetTransObject ( iTrTrans )
	lPerDecFin = dwcPeriode.GetItemNumber ( dwcPeriode.GetRow(), "ID_PERIODE" )

	iDwSaisie.GetChild ( "PERDEBARRET", dwcPeriode )
	dwcPeriode.SetTransObject ( iTrTrans )
	lPerDebArret = dwcPeriode.GetItemNumber ( dwcPeriode.GetRow(), "ID_PERIODE" )

	iDwSaisie.GetChild ( "PERFINARRET", dwcPeriode )
	dwcPeriode.SetTransObject ( iTrTrans )
	lPerFinArret = dwcPeriode.GetItemNumber ( dwcPeriode.GetRow(), "ID_PERIODE" )

	lProd = iDwSaisie.GetItemNumber ( 1, "NUM_PROD" ) 


	iDw1.SetTransObject ( iTrTrans )
	iDw1.Retrieve ( lPerDecDeb, lPerDecFin, lPerDebArret, lPerFinArret, lProd )

	/*------------------------------------------------------------------*/
	/* IMPORTANT ! : Il faut commiter après le Retrieve, car la         */
	/* requête contient des Insert dans une table temporaire.           */
	/*------------------------------------------------------------------*/
	f_Commit ( itrTrans, True )

	iStEncours.Hide()

	/*------------------------------------------------------------------*/
	/* Des données ont été trouvées...                                  */
	/*------------------------------------------------------------------*/
	If iDw1.RowCount() > 0 then

		idw1.Show()

		aPbImprimer.enabled = True
		aPbExcel.enabled 	  = True

	/*------------------------------------------------------------------*/
	/* Aucune donnée trouvée...                                         */
	/*------------------------------------------------------------------*/
	Else

		aPbImprimer.enabled = False
		aPbExcel.enabled 	  = False

		Beep(1)

		/*------------------------------------------------------------------*/
		/* Box indiquant qu'aucune donnée ne répond à la demande.			  */
		/*------------------------------------------------------------------*/
		stMessage.bErreurG = False
		stMessage.sCode	 = "EWK0022"
		stMessage.sTitre   = "Traitement Particulier - SIMPA2"
		stMessage.Icon	    = Information!
		stMessage.Bouton   = Ok!

		F_Message ( stMessage )

	End If

End If





end subroutine

public subroutine uf_excel ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Excel (Public)
//* Auteur			: Fabry JF
//* Date				: 20/05/1999 10:59:09
//* Libellé			: Sauve les données au format Excel
//* Commentaires	: lancer à partir de ue_Item6 sur la fenêtre
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//			FPI	23/07/2024	[MIG_PB2022] Sauvegarde Excel! remplacée par Excel8!		  
//*-----------------------------------------------------------------

Int 		iRet
String	sNomFic

sNomFic = F_GetNomFichier ( "", "Fichier Excel (*.XLS),*.XLS,Tous Fichiers (*.*),*.*", "XLS", TRUE )

If sNomFic <> "" Then

	iRet = iDw1.SaveAs ( sNomFic , EXCEL8!, TRUE ) // [MIG_PB2022]

	If iRet < 0 Then

		stMessage.bErreurG= TRUE
		stMessage.sCode	= "ANCE008"
		stMessage.sTitre  = "SIMPA2 - Fichier Excel"
		stMessage.Icon	   = EXCLAMATION!
		stMessage.Bouton  = Ok!
		stMessage.sVar[1] = sNomFic

		F_Message ( stMessage )

	End IF

End If
end subroutine

private function boolean uf_zn_ctrl ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_Ctrl (Private)
//* Auteur			: Fabry JF
//* Date				: 07/05/1999 17:45:31
//* Libellé			: Contrôle La cohérence des champs de iDwSaisie
//* Commentaires	: Cette fonction appelle d'autres fonctions 
//*					  privées. Il existe une fonction pour chaque zone.
//*					  Cette Fonction n'est pas déclenché sur l'ItemChanged
//*					  mais dans la fonction uf_ControlerSaisie, afin de 
//*					  ne pas gêner l'utilisateur dans le choix des trois dates.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		bSuite			A True, aucune erreur de cohérence
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean 	bSuite = True
String	sNomColErr


// ... Période de déclaration de début
If bSuite Then
	sNomColErr = "PERDECDEB"
	bsuite 	  = This.Uf_Zn_PerDecDeb ()
End If

// ... Période de déclaration de Fin
If bSuite Then
	sNomColErr = "PERDECFIN"
	bSuite	  = This.Uf_Zn_PerDecFin ()
End If

// ... Période de début d'arrêt des refus
If bSuite Then
	sNomColErr = "PERDEBARRET"
	bSuite	  = This.Uf_Zn_PerDebArret ()
End If

// ... Période de début d'arrêt des refus
If bSuite Then
	sNomColErr = "PERFINARRET"
//	bSuite	  = This.Uf_Zn_PerFinArret ()
End If



If Not bSuite Then
	This.Uf_Zn_ZErreur ( sNomColErr )
End If


Return bSuite
end function

private function boolean uf_zn_perdecdeb ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Zn_PerDecDeb (Private)
//* Auteur			: Fabry JF
//* Date				: 10/05/1999 16:33:28
//* Libellé			: Contrôle de la zone PerDecDeb (Periode Declaration début)
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		bRet			A True, aucune erreur.
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean				bRet = True
Date  				dPerDecDeb, dPerDecFin, dPerDebArret, dPerFinArret
DataWindowChild	dwChild

dPerDecDeb	= Date ( iDwSaisie.GetItemString ( 1 ,"PERDECDEB" ) )
dPerDecFin 	= Date ( iDwSaisie.GetItemString ( 1 ,"PERDECFIN" ) )
dPerDebArret= Date ( iDwSaisie.GetItemString ( 1 ,"PERDEBARRET"  ) )
dPerFinArret= Date ( iDwSaisie.GetItemString ( 1 ,"PERFINARRET"  ) )


/*------------------------------------------------------------------*/
/* La date de début de déclaration doit être strictement            */
/* antérieure à la date du jour.												  */
/*------------------------------------------------------------------*/
If dPerDecDeb >= Today () Then 

	bRet = False
	iDwSaisie.iiErreur = 05

End If

/*------------------------------------------------------------------*/
/* On ne controle que si la PerDecFin ou la PerDebArret ou          */
/* la PerFinArret ont été saisies.											  */
/*------------------------------------------------------------------*/
If  ( Not IsNull ( dPerDecFin ) or Not IsNull ( dPerDebArret ) or Not IsNull ( dPerFinArret ) ) and bRet Then


	If Not IsNull ( dPerDecFin ) Then
		
		/*------------------------------------------------------------------*/
		/* La date de début de déclaration doit être strictement            */
		/* antérieure à la date de fin de déclaration                       */
		/*------------------------------------------------------------------*/
		If dPerDecDeb >= dPerDecFin Then
			bRet = False
			iDwSaisie.iiErreur = 10
		End IF

	End IF

	If Not IsNull ( dPerDebArret ) and bRet Then

		/*------------------------------------------------------------------*/
		/* La date de début de déclaration doit être antérieure             */
		/* ou égale à la date de début d'arrêt  des refus.			   		  */
		/*------------------------------------------------------------------*/
		If dPerDecDeb > dPerDebArret Then
			bRet = False
			iDwSaisie.iiErreur = 20
		End IF

	End IF

	If Not IsNull ( dPerFinArret ) and bRet Then

		/*------------------------------------------------------------------*/
		/* La date de début de déclaration doit être strictement            */
		/* antérieure à la date de fin d'arrêt des refus.			   	     */
		/*------------------------------------------------------------------*/
		If dPerDecDeb >= dPerFinArret Then
			bRet = False
			iDwSaisie.iiErreur = 30
		End IF

	End IF


End IF

Return bRet

end function

private function boolean uf_zn_perdecfin ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Zn_PerDecFin (Private)
//* Auteur			: Fabry JF
//* Date				: 10/05/1999 16:33:28
//* Libellé			: Contrôle de la zone PerDecFin (Periode Declaration Fin)
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		bRet			A True, aucune erreur.
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean				bRet = True
Date  				dPerDecDeb, dPerDecFin, dPerFinArret
DataWindowChild	dwChild


dPerDecFin	= Date ( iDwSaisie.GetItemString ( 1 ,"PERDECFIN" ) )
dPerDecDeb 	= Date ( iDwSaisie.GetItemString ( 1 ,"PERDECDEB" ) )
dPerFinArret= Date ( iDwSaisie.GetItemString ( 1 ,"PERFINARRET"  ) )


/*------------------------------------------------------------------*/
/* La date de fin de déclaration doit être strictement              */
/* antérieure à la date du jour.												  */
/*------------------------------------------------------------------*/
If dPerDecFin >= Today () Then 

	bRet = False
	iDwSaisie.iiErreur = 05

End If

/*------------------------------------------------------------------*/
/* On ne controle que si la PerDecDeb ou la PerFinArret ont 		  */
/* été saisies.																	  */
/* Il n'y a pas de contrôles entre PerDecFin et PerDebArret.		  */
/*------------------------------------------------------------------*/
If  ( Not IsNull ( dPerDecDeb ) or Not IsNull ( dPerFinArret ) ) and bRet Then

	If Not IsNull ( dPerDecDeb ) Then

		/*------------------------------------------------------------------*/
		/* La date de fin de déclaration doit être strictement              */
		/* postérieure à la date de début de déclaration                    */
		/*------------------------------------------------------------------*/
		If dPerDecFin <= dPerDecDeb Then
			bRet = False
			iDwSaisie.iiErreur = 10
		End IF

	End IF

	If Not IsNull ( dPerFinArret ) and bRet Then

		/*------------------------------------------------------------------*/
		/* La date de fin de déclaration doit antérieure ou égale			  */
		/* à la date de fin d'arrêt des refus										  */
		/*------------------------------------------------------------------*/
		If dPerDecFin > dPerFinArret Then
			bRet = False
			iDwSaisie.iiErreur = 20
		End IF

	End IF

End IF


Return bRet

end function

private subroutine uf_zn_zerreur (string ascolerr);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Zn_ZErreur (Private)
//* Auteur			: Fabry JF
//* Date				: 10/05/1999 18:11:58
//* Libellé			: Gestion des erreurs sur les zones
//* Commentaires	: Lancer à partir de uf_Zn_Ctrl.
//*
//*					EWK0004 = La 1 doit être antérieure à la date du jour
//*					EWK0010 = La 1 doit être antérieure à la 2
//*					EWK0011 = La 1 doit être postérieure à la 2
//*
//*
//* Arguments		: String			asColErr			(Val)			Colonne en erreur
//*
//* Retourne		: Rien
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

stMessage.bErreurG = TRUE
stMessage.sTitre   = "Traitement Particulier - SIMPA2"
stMessage.Icon	    = Information!
stMessage.Bouton   = OK!


CHOOSE CASE asColErr

	CASE "PERDECDEB"
			
		CHOOSE CASE iDwSaisie.iiErreur

			CASE 05
	         stMessage.sCode	 = "EWK0004"
				stMessage.sVar[1] = "date de début de déclaration"

			CASE 10
	         stMessage.sCode	 = "EWK0010"
				stMessage.sVar[1] = "date de début de déclaration"
				stMessage.sVar[2] = "date de fin de déclaration"

			CASE 20
	         stMessage.sCode	 = "EWK0010"
				stMessage.sVar[1] = "date de début de déclaration"
				stMessage.sVar[2] = "date de début des refus"

			CASE 30
	         stMessage.sCode	 = "EWK0010"
				stMessage.sVar[1] = "date de début de déclaration"
				stMessage.sVar[2] = "date de fin des refus"


		END CHOOSE


	CASE "PERDECFIN"
			
		CHOOSE CASE iDwSaisie.iiErreur
			CASE 05
	         stMessage.sCode	 = "EWK0004"
				stMessage.sVar[1] = "date de fin de déclaration"

			CASE 10
	         stMessage.sCode	 = "EWK0011"
				stMessage.sVar[1] = "date de fin de déclaration"
				stMessage.sVar[2] = "date de début de déclaration"

			CASE 20

	         stMessage.sCode	 = "EWK0010"
				stMessage.sVar[1] = "date de fin de déclaration"
				stMessage.sVar[2] = "date de fin des refus"


		END CHOOSE


	CASE "PERDEBARRET"
			
		CHOOSE CASE iDwSaisie.iiErreur
			CASE 05
	         stMessage.sCode	 = "EWK0004"
				stMessage.sVar[1] = "date de début des refus"

			CASE 10
	         stMessage.sCode	 = "EWK0011"
				stMessage.sVar[1] = "date de début des refus"
				stMessage.sVar[2] = "date de début de déclaration"

			CASE 20

	         stMessage.sCode	 = "EWK0010"
				stMessage.sVar[1] = "date de début des refus"
				stMessage.sVar[2] = "date de fin des refus"

		END CHOOSE
		

	CASE "PERFINARRET"
			
		CHOOSE CASE iDwSaisie.iiErreur
			CASE 05
	         stMessage.sCode	 = "EWK0004"
				stMessage.sVar[1] = "date de fin des refus"

			CASE 10
	         stMessage.sCode	 = "EWK0011"
				stMessage.sVar[1] = "date de fin des refus"
				stMessage.sVar[2] = "date de début de déclaration"

			CASE 20

	         stMessage.sCode	 = "EWK0011"
				stMessage.sVar[1] = "date de fin des refus"
				stMessage.sVar[2] = "date de début des refus"

			CASE 30

	         stMessage.sCode	 = "EWK0011"
				stMessage.sVar[1] = "date de fin des refus"
				stMessage.sVar[2] = "date de fin de déclaration"


		END CHOOSE



END CHOOSE

F_Message ( stMessage )
iDwSaisie.iiErreur = 0


end subroutine

private function boolean uf_zn_perdebarret ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Zn_PerDebArret (Private)
//* Auteur			: Fabry JF
//* Date				: 10/05/1999 16:33:28
//* Libellé			: Contrôle de la zone PerDebArret ( début de la Periode d'arret des refus)
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		bRet			A True, aucune erreur.
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean				bRet = True
Date  				dPerDecDeb, dPerDebArret, dPerFinArret
DataWindowChild	dwChild

dPerDebArret= Date ( iDwSaisie.GetItemString ( 1 ,"PERDEBARRET" ) )
dPerFinArret= Date ( iDwSaisie.GetItemString ( 1 ,"PERFINARRET"  ) )
dPerDecDeb 	= Date ( iDwSaisie.GetItemString ( 1 ,"PERDECDEB" ) )



/*------------------------------------------------------------------*/
/* La date de début d'arrêt des refus doit être strictement         */
/* antérieure à la date du jour.												  */
/*------------------------------------------------------------------*/
If dPerDebArret >= Today () Then 

	bRet = False
	iDwSaisie.iiErreur = 05

End If

/*-------------------------------------------------------------------*/
/* On ne controle que si la PerDecDeb ou la PerDebArret ont          */
/* été saisies																		   */
/*-------------------------------------------------------------------*/
If  ( Not IsNull ( dPerDecDeb ) or Not IsNull ( dPerDebArret ) ) and bRet Then


	If Not IsNull ( dPerDecDeb ) Then

		/*------------------------------------------------------------------*/
		/* La date de début d'arrêt des refus doit être postérieure         */
		/* ou égale à la date de début de déclaration                       */
		/*------------------------------------------------------------------*/
		If dPerDebArret < dPerDecDeb Then
			bRet = False
			iDwSaisie.iiErreur = 10
		End IF

	End IF

	If Not IsNull ( dPerFinArret ) and bRet Then

		/*------------------------------------------------------------------*/
		/* La date de ébut d'arrêt des refus doit strictement antérieure    */
		/* à la date de fin d'arrêt des refus.										  */
		/*------------------------------------------------------------------*/
		If dPerDebArret >= dPerFinArret Then
			bRet = False
			iDwSaisie.iiErreur = 20
		End IF

	End IF

End IF


Return bRet

end function

private function boolean uf_zn_perfinarret ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Zn_PerFinArret (Private)
//* Auteur			: Fabry JF
//* Date				: 10/05/1999 16:33:28
//* Libellé			: Contrôle de la zone PerFinArret (Fin de la Periode d'arret des refus)
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		bRet			A True, aucune erreur.
//*			
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean				bRet = True
Date  				dPerDecDeb, dPerDecFin, dPerDebArret, dPerFinArret  
DataWindowChild	dwChild

dPerDebArret= Date ( iDwSaisie.GetItemString ( 1 ,"PERDEBARRET" ) )
dPerFinArret= Date ( iDwSaisie.GetItemString ( 1 ,"PERFINARRET"  ) )
dPerDecDeb 	= Date ( iDwSaisie.GetItemString ( 1 ,"PERDECDEB" ) )
dPerDecFin 	= Date ( iDwSaisie.GetItemString ( 1 ,"PERDECFIN" ) )



/*------------------------------------------------------------------*/
/* La date de fin d'arrêt des refus doit être strictement           */
/* antérieure à la date du jour.												  */
/*------------------------------------------------------------------*/
If dPerFinArret >= Today () Then 

	bRet = False
	iDwSaisie.iiErreur = 05

End If

/*-------------------------------------------------------------------*/
/* On ne controle que si la PerDecDeb ou la PerDecFin ou la          */
/* PerFinArret ont été saisie														*/
/*-------------------------------------------------------------------*/
If  ( Not IsNull ( dPerDecDeb ) or Not IsNull ( dPerDecFin ) or Not IsNull ( dPerDebArret ) ) and bRet Then


	If Not IsNull ( dPerDecDeb ) Then

		/*------------------------------------------------------------------*/
		/* La date de fin d'arrêt des refus doit être Strictement           */
		/* postérieure à la date de début de déclaration                    */
		/*------------------------------------------------------------------*/
		If dPerFinArret <= dPerDecDeb Then
			bRet = False
			iDwSaisie.iiErreur = 10
		End IF

	End IF

	If Not IsNull ( dPerDebArret ) and bRet Then

		/*------------------------------------------------------------------*/
		/* La date de fin d'arrêt des refus doit strictement postérieure    */
		/* à la date de début d'arrêt des refus.									  */
		/*------------------------------------------------------------------*/
		If dPerFinArret <= dPerDebArret Then
			bRet = False
			iDwSaisie.iiErreur = 20
		End IF

	End IF

	If Not IsNull ( dPerDecFin ) and bRet Then

		/*------------------------------------------------------------------*/
		/* La date de fin d'arrêt des refus doit postérieure ou égale       */
		/* à la date de fin de déclaration.										     */
		/*------------------------------------------------------------------*/
		If dPerFinArret < dPerDecFin Then
			bRet = False
			iDwSaisie.iiErreur = 30
		End IF

	End IF

End IF


Return bRet

end function

on u_sp_gs_trait_part1.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_sp_gs_trait_part1.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

