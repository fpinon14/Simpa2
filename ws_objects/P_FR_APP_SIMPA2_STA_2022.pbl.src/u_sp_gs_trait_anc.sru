HA$PBExportHeader$u_sp_gs_trait_anc.sru
$PBExportComments$--- } UserObjet pour gestion traitements p$$HEX1$$e900$$ENDHEX$$riodiques
forward
global type u_sp_gs_trait_anc from nonvisualobject
end type
end forward

global type u_sp_gs_trait_anc from nonvisualobject
end type
global u_sp_gs_trait_anc u_sp_gs_trait_anc

type variables
Protected :

	U_Transaction		itrTrans

	u_Datawindow_Detail	idw_1

	Datawindow		idw_Dept
	Datawindow		idw_Dates
	Datawindow		idw_Etat

	u_BarreDefil		iuoDefil
	Int			iiFicLog	//Pointeur pour le fichier de log
	String			isFicLog	//Nom du fichier de log



Public :

	Long			ilNbLig
	Long			ilNumEtat
end variables

forward prototypes
public subroutine uf_departement ()
public subroutine uf_choix_periode ()
public function boolean uf_verifierdatestrt (string astypetrt)
protected function boolean uf_log (integer aityplog, string asligne, string astyptrt)
public subroutine uf_initialiser (ref u_datawindow_detail adw_1, ref datawindow adw_dates, ref datawindow adw_dept, ref u_barredefil auodefil, ref u_transaction atrtrans)
end prototypes

public subroutine uf_departement ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Sp_Gs_Trait_Anc::Uf_Init_Dept
//* Auteur			: Erick John Stark
//* Date				: 24/11/1998 16:02:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation de la DDDW sur les d$$HEX1$$e900$$ENDHEX$$partements
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

DataWindowChild	dwChild
String sImport, sTab

sTab = "~t"

idw_Dept.GetChild ( "ID_DEPT", dwChild )
dwChild.SetTransObject ( iTrTrans )
dwChild.Retrieve ()

/*------------------------------------------------------------------*/
/* On importe une ligne comprenant tous les d$$HEX1$$e900$$ENDHEX$$partements.           */
/*------------------------------------------------------------------*/
sImport = "" + sTab + "Tous les d$$HEX1$$e900$$ENDHEX$$partements"
dwChild.ImportString ( sImport )

dwChild.Sort ()

idw_Dept.Visible	= True
idw_Dept.Enabled	= True

end subroutine

public subroutine uf_choix_periode ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Sp_Gs_Trait_Anc::Uf_Choix_Periode (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/11/1998 16:27:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va populiser les p$$HEX1$$e900$$ENDHEX$$riodes de traitement
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
DataWindowChild	dwChild
n_cst_string lnvString // [MIGPB11] [EMD] : ImportFile d'une chaine vide
String sFicPeriode

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le fichier pour les p$$HEX1$$e900$$ENDHEX$$riodes de traitement.          */
/*------------------------------------------------------------------*/
sFicPeriode = ProfileString ( stGLB.sFichierIni, "TRAITEMENT", "FICHIER_PERIODE", "" )

/*------------------------------------------------------------------*/
/* La saisie des dates se fera en utilisant la date de fin de       */
/* traitement. La date de d$$HEX1$$e900$$ENDHEX$$but de traitement sera calcul$$HEX1$$e900$$ENDHEX$$e en      */
/* fonction du type de traitement sur la fonction                   */
/* Uf_VerifierDatesTrt ().                                          */
/*------------------------------------------------------------------*/
idw_Dates.InsertRow ( 0 )
idw_Dates.GetChild ( "DTE_FIN", dwChild )

If Not lnvString.of_isEmpty ( sFicPeriode ) Then // [MIGPB11] [EMD] : ImportFile d'une chaine vide
	dwChild.ImportFile ( sFicPeriode )

	dwChild.Sort ( )
End If // [MIGPB11] [EMD] : ImportFile d'une chaine vide

idw_Dates.Visible = True
idw_Dates.Enabled = True



end subroutine

public function boolean uf_verifierdatestrt (string astypetrt);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_Trait_Anc::Uf_VerifierDatesTrt
//* Auteur			: Erick John Stark
//* Date				: 27/11/1998 10:51:15
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: String			asTypeTrt			(Val)	Type de traitement
//*
//* Retourne		: Boolean		True		= Tout est OK
//*										False		= Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------

DataWindowChild	dwChild
Boolean bRet
Date dDteFin, dDteDeb
Long	lIdPeriode, lLig
Integer iType

/*------------------------------------------------------------------*/
/* La date de fin est-elle saisie ?                                 */
/*------------------------------------------------------------------*/
dDteFin	= idw_Dates.GetItemDate ( 1, "DTE_FIN" )
bRet 		= True

If	IsNull ( dDteFin ) Then

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le des dates de traitement"
	stMessage.bErreurG	= FALSE
	stMessage.sCode		= "STAT100"
	stMessage.Icon			= StopSign!

	F_Message ( stMessage )
	bRet = False
Else

/*------------------------------------------------------------------*/
/* En fonction du type de traitement (M)ensuel, (T)rimestriel,      */
/* (S)emestriel, on calcule la date de d$$HEX1$$e900$$ENDHEX$$but de traitement. On      */
/* part du principe que le fichier PERIODE est correctement         */
/* positionn$$HEX1$$e900$$ENDHEX$$. Il faut aussi positionner la valeur de ID_PERIODE.   */
/*------------------------------------------------------------------*/
	Choose Case asTypeTrt
	Case "M"
		iType = 0

	Case "T"
		iType = 2

	Case "S"
		iType = 5

	End Choose
/*------------------------------------------------------------------*/
/* On doit $$HEX1$$ea00$$ENDHEX$$tre logiquement positionn$$HEX2$$e9002000$$ENDHEX$$sur la bonne ligne. Il n'y   */
/* a pas besoin de faire un FIND.                                   */
/*------------------------------------------------------------------*/

	idw_Dates.GetChild ( "DTE_FIN", dwChild )
	lLig 			= dwChild.GetRow ()
	lIdPeriode 	= dwChild.GetItemNumber ( lLig, "ID_PERIODE" )

	lLig = lLig + iType
	dDteDeb = dwChild.GetItemDate ( lLig, "DTE_DEB" )

	idw_Dates.SetItem ( 1, "DTE_DEB", dDteDeb )
	idw_Dates.SetItem ( 1, "ID_PERIODE", lIdPeriode )

End If

Return ( bRet )


end function

protected function boolean uf_log (integer aityplog, string asligne, string astyptrt);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_log (Protected)
//* Auteur			: JFF
//* Date				: 12/01/1999
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Gestion de la trace du traitement
//* Commentaires	: Les Cas :   1 - Ouverture du fichier de trace
//*									  2 - Ecriture d'une ligne de 108 '-'
//*									  3 - Ecriture d'une ligne dans le fichier sans retour chariot
//*									  4 - Fermeture du fichier de trace		
//*
//* Arguments		: Integer		aiTyplog				(Val)	Type de traitement de trace $$HEX2$$e0002000$$ENDHEX$$lancer
//*				  	  String			asLigne				(Val) Ligne $$HEX3$$e0002000e900$$ENDHEX$$crire dans le fichier
//*				  	  String			asTypTrt				(Val) Type de traitement mensuel ( "M","T",..)
//*
//* Retourne		: Ne retourne rien. Si l'on ne peut pas $$HEX1$$e900$$ENDHEX$$crire dans le fichier de Trace
//*					  on en averti l'utilisateur par un message $$HEX2$$e0002000$$ENDHEX$$l'$$HEX1$$e900$$ENDHEX$$cran, et on trace cette
//*					  information dans le fichier de trace qui va bien.
//*
//*					  Modif JFF le 08/03/99 : Changement de programme !
//*					  Si l'on ne peut pas ouvrir le fichier de Trace on ne lance pas le Traitement Mensuel
//*					  vu avec Denis, le 08/03/99. Ceci pour ne pas surcharger SQ1 par les traitements sur demande.
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//* #1	JFF	21/07/1999	Si la trace ne s'ouvre pas, le message affich$$HEX2$$e9002000$$ENDHEX$$pour ADD, et diff$$HEX1$$e900$$ENDHEX$$rent du message pour
//*                     	les utilisateurs du Traitement sur Demande.
//* --	PHG	20/04/2010	[BUGTRTMENS].PHG.20100420 Acces en partage des fichiers de log.
//*-----------------------------------------------------------------

Boolean 		bRet = True


Choose Case aiTypLog

	/*-------------------------------------------------------------*/
	/* Ouverture du fichier de trace											*/
	/*-------------------------------------------------------------*/
	Case 1   
		
		isFicLog = ProfileString (stGlb.sFichierIni, "TRACE", "REP_TRACE_T", "K:\SIMPA2\" )

		isFicLog+= "TRT_" + astyptrt + ".LOG"
		// [BUGTRTMENS].PHG.20100420 LockReadWrite! -> Shared !
		iiFicLog = FileOpen ( isFicLog, LineMode!, Write!, Shared!, Append! )

	/*-------------------------------------------------------------*/
	/* Si la trace ne peut pas s'$$HEX1$$e900$$ENDHEX$$crire, on averti l'utilisateur   */
	/* Mais cela ne g$$HEX1$$e800$$ENDHEX$$nera en rien le lancement du traitement.		*/
	/*-------------------------------------------------------------*/
		If iiFicLog = -1 Then

			bRet = False

			/*------------------------------------------------------------------*/
			/* La variable sVar[1] sera trac$$HEX2$$e9002000$$ENDHEX$$dans le fichier d'erreur, mais    */
			/* ne sera pas affich$$HEX1$$e900$$ENDHEX$$e. Le message affich$$HEX2$$e9002000$$ENDHEX$$sera un message clair   */
			/* et compr$$HEX1$$e900$$ENDHEX$$hensible pour l'utilisateur.                            */
			/*------------------------------------------------------------------*/
			If asTypTrt = "D" then
				// #1 Message clair pour l'utilisateur du Traitement sur demande
				stMessage.sCode	= "EWK0018"
			Else
				// #1 Message pour ADD, pour autres Traitements.
				stMessage.sCode	= "EWK0023"
			End If

			stMessage.sTitre	= "Fichier de trace du traitement"
	   	stMessage.sVar[1] = "Impossible d'ouvrir le fichier:  " + isFicLog
			stMessage.bErreurG= FALSE
			stMessage.Icon		= INFORMATION!
			stMessage.bTrace  = True
			F_Message ( stMessage )


		End If


	/*-------------------------------------------------------------*/
	/* Ecriture d'une ligne de 108 '-'										*/
	/*-------------------------------------------------------------*/
	Case 2    
		If iiFicLog <> - 1 then
			FileWrite ( iiFicLog, Fill( "-", 108 ) )			
		End If


	/*-------------------------------------------------------------*/
	/* Ecriture d'une ligne dans le fichier 								*/
	/*-------------------------------------------------------------*/
	Case 3    
		If iiFicLog <> - 1 then
			FileWrite ( iiFicLog, asLigne )			
		End If


	/*-------------------------------------------------------------*/
	/* Fermeture du fichier de trace											*/
	/*-------------------------------------------------------------*/
	Case 4 	
		If iiFicLog <> - 1 then
			FileClose ( iiFicLog )			
		End If

End Choose

Return bRet
end function

public subroutine uf_initialiser (ref u_datawindow_detail adw_1, ref datawindow adw_dates, ref datawindow adw_dept, ref u_barredefil auodefil, ref u_transaction atrtrans);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Sp_Gs_Trai_Anc::Uf_Initialiser (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/11/1998 15:56:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: U_DataWindow_Detail	adw_1					(R$$HEX1$$e900$$ENDHEX$$f)	
//*					  DataWindow				adw_Dates			(R$$HEX1$$e900$$ENDHEX$$f)
//*					  DataWindow				adw_Dept				(R$$HEX1$$e900$$ENDHEX$$f)
//*					  U_BarreDefif				auoDefil				(R$$HEX1$$e900$$ENDHEX$$f)
//*					  U_Transaction			atrTrans				(R$$HEX1$$e900$$ENDHEX$$f)
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

idw_1			= adw_1
idw_Dates	= adw_Dates
idw_Dept		= adw_Dept
iuoDefil		= auoDefil
itrTrans		= atrTrans


end subroutine

on u_sp_gs_trait_anc.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_sp_gs_trait_anc.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

