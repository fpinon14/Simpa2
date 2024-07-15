HA$PBExportHeader$u_sp_gs_trait_etat_dde.sru
$PBExportComments$--- } UserObjet pour gestion des etats sur demande (h$$HEX1$$e900$$ENDHEX$$rit$$HEX2$$e9002000$$ENDHEX$$de u_sp_gs_trait_etat)
forward
global type u_sp_gs_trait_etat_dde from u_sp_gs_trait_etat
end type
end forward

global type u_sp_gs_trait_etat_dde from u_sp_gs_trait_etat
end type
global u_sp_gs_trait_etat_dde u_sp_gs_trait_etat_dde

type variables
Private :

U_DataWindow		iDwSaisie
U_DataWindow		iDw_2
end variables

forward prototypes
public subroutine uf_generer_dw ()
public function boolean uf_controler_lancer ()
public subroutine uf_populisation_dw1 ()
public subroutine uf_gestion_des_fleches (string assens)
public function boolean uf_controler_etat ()
private function boolean uf_lireperiode (ref long alperiodedeb, ref long alperiodefin, ref datetime adtdtedeb, ref datetime adtdtefin)
public subroutine uf_efface_col_en_cours ()
private subroutine uf_nom_fichier (ref string asnomcomplet, ref string asnomfic)
public subroutine uf_initialiser (ref u_datawindow_accueil adw_1, ref u_datawindow adw_2, ref u_datawindow adwsaisie, ref datawindow adwetat, ref u_volcane adw_volcane, ref u_barredefil auodefil, ref u_transaction atrtrans)
public function long uf_controler_saisie ()
public function long uf_erreur_saisie ()
end prototypes

public subroutine uf_generer_dw ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Generer_Dw (OverRide)
//* Auteur			: JFF
//* Date				: 28/02/1999 16:16:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Cr$$HEX1$$e900$$ENDHEX$$e la Datawindow d'accueil du traitement et la charge
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------
//Migration PB8-WYNIWYG-03/2006 FM
//String 					sTables[3]			//Tableau pour les tables d'o$$HEX2$$f9002000$$ENDHEX$$proviennent les champs de la datawindow
String 					sTables[]			//Tableau pour les tables d'o$$HEX2$$f9002000$$ENDHEX$$proviennent les champs de la datawindow
//afin de se conformer $$HEX2$$e0002000$$ENDHEX$$PB4 (o$$HEX2$$f9002000$$ENDHEX$$les variables sont pass$$HEX1$$e900$$ENDHEX$$es vides), il faut
//cr$$HEX1$$e900$$ENDHEX$$er les 3 premiers $$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ments du tableau avec des chaines vides
sTables[1] = ""
sTables[2] = ""
sTables[3] = ""
//Fin Migration PB8-WYNIWYG-03/2006 FM
// #1 PHG	17/12/2009 Agrandissment Zone Nom_fic $$HEX2$$e0002000$$ENDHEX$$270

/*------------------------------------------------------------------*/
/* Description de la DW d'accueil DW_1 (invisible)                  */
/*------------------------------------------------------------------*/

iDw_1.istCol[1].sDbName			=	"sysadm.traitement.id_prod"
iDw_1.istCol[1].sResultSet		=	"ID_PROD"
iDw_1.istCol[1].sType			=	"decimal(0)"
iDw_1.istCol[1].sHeaderName	=	"Prod."
iDw_1.istCol[1].ilargeur		=	7
iDw_1.istCol[1].sAlignement	=	"2"
iDw_1.istCol[1].sInvisible		=	"N"

iDw_1.istCol[2].sDbName			=	"sysadm.etat_stat.id_etat"
iDw_1.istCol[2].sResultSet		=	"ID_ETAT"
iDw_1.istCol[2].sType			=	"decimal(0)"
iDw_1.istCol[2].sHeaderName	=	"No"
iDw_1.istCol[2].ilargeur		=	3
iDw_1.istCol[2].sAlignement	=	"2"
iDw_1.istCol[2].sInvisible		= 	"N"

iDw_1.istCol[3].sDbName			=	"sysadm.etat_stat.lib_etat"
iDw_1.istCol[3].sResultSet		=	"LIB_ETAT"
iDw_1.istCol[3].sType			=	"char(35)"
iDw_1.istCol[3].sHeaderName	=	"Etat"
iDw_1.istCol[3].ilargeur		=	35
iDw_1.istCol[3].sAlignement	=	"0"
iDw_1.istCol[3].sInvisible		= 	"N"

iDw_1.istCol[4].sDbName			=	"sysadm.etat_stat.cod_dw"
iDw_1.istCol[4].sResultSet		=	"COD_DW"
iDw_1.istCol[4].sType			=	"char(35)"
iDw_1.istCol[4].sHeaderName	=	"Datawindow"
iDw_1.istCol[4].ilargeur		=	15
iDw_1.istCol[4].sAlignement	=	"0"
iDw_1.istCol[4].sInvisible		= 	"O"

iDw_1.istCol[5].sDbName			=	"sysadm.etat_stat.alt_arg1"
iDw_1.istCol[5].sResultSet		=	"ALT_ARG1"
iDw_1.istCol[5].sType			=	"char(1)"
iDw_1.istCol[5].sHeaderName	=	"Arg1"
iDw_1.istCol[5].ilargeur		=	4
iDw_1.istCol[5].sAlignement	=	"2"
iDw_1.istCol[5].sInvisible		= 	"O"

iDw_1.istCol[6].sDbName			=	"sysadm.etat_stat.alt_arg2"
iDw_1.istCol[6].sResultSet		=	"ALT_ARG2"
iDw_1.istCol[6].sType			=	"char(1)"
iDw_1.istCol[6].sHeaderName	=	"Arg2"
iDw_1.istCol[6].ilargeur		=	4
iDw_1.istCol[6].sAlignement	=	"2"
iDw_1.istCol[6].sInvisible		= 	"O"

iDw_1.istCol[7].sDbName			=	"sysadm.etat_stat.alt_dte_deb"
iDw_1.istCol[7].sResultSet		=	"ALT_DTE_DEB"
iDw_1.istCol[7].sType			=	"char(1)"
iDw_1.istCol[7].sHeaderName	=	"D"
iDw_1.istCol[7].ilargeur		=	2
iDw_1.istCol[7].sAlignement	=	"2"
iDw_1.istCol[7].sInvisible		= 	"O"
iDw_1.istCol[7].sBitMap			= 	"O"

iDw_1.istCol[8].sDbName			=	"sysadm.etat_stat.alt_dte_fin"
iDw_1.istCol[8].sResultSet		=	"ALT_DTE_FIN"
iDw_1.istCol[8].sType			=	"char(1)"
iDw_1.istCol[8].sHeaderName	=	"F"
iDw_1.istCol[8].ilargeur		=	2
iDw_1.istCol[8].sAlignement	=	"2"
iDw_1.istCol[8].sInvisible		= 	"O"
iDw_1.istCol[8].sBitMap			= 	"O"

iDw_1.istCol[9].sDbName			=	"sysadm.traitement.cod_arg1"
iDw_1.istCol[9].sResultSet		=	"COD_ARG1"
iDw_1.istCol[9].sType			=	"decimal(7)"
iDw_1.istCol[9].sHeaderName	=	"Arg1"
iDw_1.istCol[9].ilargeur		=	7
iDw_1.istCol[9].sAlignement	=	"0"
iDw_1.istCol[9].sInvisible		= 	"O"

iDw_1.istCol[10].sDbName		=	"sysadm.traitement.cod_arg2"
iDw_1.istCol[10].sResultSet	=	"COD_ARG2"
iDw_1.istCol[10].sType			=	"decimal(7)"
iDw_1.istCol[10].sHeaderName	=	"Arg2"
iDw_1.istCol[10].ilargeur		=	7
iDw_1.istCol[10].sAlignement	=	"0"
iDw_1.istCol[10].sInvisible	= 	"N"

iDw_1.istCol[11].sDbName		=	"sysadm.etat_stat.cod_typ_etat"
iDw_1.istCol[11].sResultSet	=	"COD_TYP_ETAT"
iDw_1.istCol[11].sType			=	"char(1)"
iDw_1.istCol[11].sHeaderName	=	"Type etat"
iDw_1.istCol[11].ilargeur		=	1
iDw_1.istCol[11].sAlignement	=	"2"
iDw_1.istCol[11].sInvisible	= 	"O"

iDw_1.istCol[12].sDbName		=	"sysadm.traitement.cod_edt"
iDw_1.istCol[12].sResultSet	=	"COD_EDT"
iDw_1.istCol[12].sType			=	"char(1)"
iDw_1.istCol[12].sHeaderName	=	"Edt"
iDw_1.istCol[12].ilargeur		=	1
iDw_1.istCol[12].sAlignement	=	"2"
iDw_1.istCol[12].sInvisible	= 	"O"

iDw_1.istCol[13].sDbName		=	"sysadm.traitement.nb_exp"
iDw_1.istCol[13].sResultSet	=	"NB_EXP"
iDw_1.istCol[13].sType			=	"decimal(0)"
iDw_1.istCol[13].sHeaderName	=	"Nb"
iDw_1.istCol[13].ilargeur		=	2
iDw_1.istCol[13].sAlignement	=	"2"
iDw_1.istCol[13].sInvisible	= 	"O"

iDw_1.istCol[14].sDbName		=	"sysadm.traitement.nom_fic"
iDw_1.istCol[14].sResultSet	=	"NOM_FIC"
iDw_1.istCol[14].sType			=	"char(255)" // #1 [MIGPB11]
iDw_1.istCol[14].sHeaderName	=	"Fichier"
iDw_1.istCol[14].ilargeur		=	30
iDw_1.istCol[14].sAlignement	=	"0"
iDw_1.istCol[14].sInvisible	= 	"O"

iDw_1.istCol[15].sDbName		=	"Convert ( VarChar(35), null )"
iDw_1.istCol[15].sResultSet	=	"MAJ_PAR"
iDw_1.istCol[15].sType			=	"char(35)"
iDw_1.istCol[15].sHeaderName	=	"En cours"
iDw_1.istCol[15].ilargeur		=	35
iDw_1.istCol[15].sAlignement	=	"0"
iDw_1.istCol[15].sInvisible	= 	"N"

iDw_1.istCol[16].sDbName		=	"sysadm.produit.id_dept"
iDw_1.istCol[16].sResultSet	=	"ID_DEPT"
iDw_1.istCol[16].sType			=	"decimal(7)"
iDw_1.istCol[16].sHeaderName	=	"Dept"
iDw_1.istCol[16].ilargeur		=	3
iDw_1.istCol[16].sAlignement	=	"0"
iDw_1.istCol[16].sInvisible	= 	"O"


iDw_1.Uf_Creer_Tout ( iDw_1.istCol, sTables, itrTrans )

/*------------------------------------------------------------------*/
/* Je d$$HEX1$$e900$$ENDHEX$$place la Dw_1 hors du contour de la fen$$HEX1$$ea00$$ENDHEX$$tre, car le fait    */
/* de faire un HIDE(), ne cache pas la Dw_1 (comprend pas !?!?)     */
/*------------------------------------------------------------------*/
idw_1.x = 5000
end subroutine

public function boolean uf_controler_lancer ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Controler_Lancer 
//* Auteur			: JFF
//* Date				: 03/03/1999 16:16:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le la coh$$HEX1$$e900$$ENDHEX$$rence des param$$HEX1$$e800$$ENDHEX$$tres saisis par
//*					  l'utilisateur, avant lancement
//* Commentaires	: (Click sur le bouton LANCER)
//*
//* Arguments		: 
//*
//* Retourne		: Boolean				bRet  // True : Contr$$HEX1$$f400$$ENDHEX$$le correcte
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF		07/04/99	Ajout d'un controle. CAS 8 : On v$$HEX1$$e900$$ENDHEX$$rifie que la p$$HEX1$$e900$$ENDHEX$$riode de fin
//*							existe bien sur la table cum_periode. Si ce n'est pas le cas
//*							on ne lance pas le traitement.
//*-----------------------------------------------------------------

Boolean 			 bRet = True 			// Booleen de retour
Long				 lRow						// Etat s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$
Long				 lPeriodeFin			// P$$HEX1$$e900$$ENDHEX$$riode de fin
Long				 lCpt						// Compteur
DataWindowChild dwcPeriode				// DWc des p$$HEX1$$e900$$ENDHEX$$riodes de fin
String			 sRech					// Chaine de Recherche

stMessage.sTitre  = "SIMPA2"
stMessage.Icon	  	= Information!
stMessage.bErreurG= False

iDwSaisie.AcceptText()

/*------------------------------------------------------------------*/
/* Si l'item n'est pas accept$$HEX1$$e900$$ENDHEX$$, on ne lance pas le contr$$HEX1$$f400$$ENDHEX$$le         */
/*------------------------------------------------------------------*/
If iDwSaisie.ibErreur then 
	bRet = False
	iDwSaisie.SetFocus()
End If


lRow = iDw_2.GetSelectedRow ( 0 )

/*-----------------------------------------------------------------*/
/* CAS 1 : La date de fin doit toujours $$HEX1$$ea00$$ENDHEX$$tre renseign$$HEX1$$e900$$ENDHEX$$e.			 	 */
/*-----------------------------------------------------------------*/
If bRet Then

	If IsNull ( iDwSaisie.GetItemString ( 1, "DTE_FIN" ) ) Then

		bRet= False
		stMessage.sCode	= "EWK0011"	
   	F_Message ( stMessage )

	End IF

End If


/*-----------------------------------------------------------------*/
/* CAS 2 : La s$$HEX1$$e900$$ENDHEX$$lection d'un $$HEX1$$e900$$ENDHEX$$tat est obligatoire.						 */
/*-----------------------------------------------------------------*/
If bRet Then

	If lRow < 1 Then 

		bRet= False
		stMessage.sCode	= "EWK0012"	
   	F_Message ( stMessage )

	End IF

End If


/*-----------------------------------------------------------------*/
/* CAS 3 : La date de d$$HEX1$$e900$$ENDHEX$$but doit toujours $$HEX1$$ea00$$ENDHEX$$tre renseign$$HEX1$$e900$$ENDHEX$$e si le    */
/*			  l'$$HEX1$$e900$$ENDHEX$$tat s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$n'est pas un traitement 'EN COURS'.	 */
/*-----------------------------------------------------------------*/
If bRet Then

	If ( IsNull ( iDwSaisie.GetItemString ( 1, "DTE_DEB" ) ) ) and &
		( iDw_2.GetItemString ( lRow, "ALT_DTE_DEB" ) <> 'N'  ) Then

		bRet= False
		stMessage.sCode	= "EWK0013"	
   	F_Message ( stMessage )

	End IF

End If


/*-----------------------------------------------------------------*/
/* CAS 4 : La s$$HEX1$$e900$$ENDHEX$$lection d'un produit est obligatoire.					 */
/*-----------------------------------------------------------------*/
If bRet Then

	If IsNull ( iDwSaisie.GetItemNumber ( 1, "NUM_PROD" ) ) then

		bRet= False
		stMessage.sCode	= "EWK0014"	
   	F_Message ( stMessage )

	End IF

End If


/*-----------------------------------------------------------------*/
/* CAS 5 : Si l'$$HEX1$$e900$$ENDHEX$$tat s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$attend un deuxi$$HEX1$$e800$$ENDHEX$$me param$$HEX1$$e800$$ENDHEX$$tre, la  */
/*			  s$$HEX1$$e900$$ENDHEX$$lection d'un $$HEX1$$e900$$ENDHEX$$tablissement est obligatoire.				 */
/*			  (Bien entendu, si l'on arrive ici, il existe au moins un*/
/*			  $$HEX1$$e900$$ENDHEX$$tablissement pour le produit, sinon l'$$HEX1$$e900$$ENDHEX$$tat est d$$HEX1$$e900$$ENDHEX$$s$$HEX1$$e900$$ENDHEX$$lec-*/
/*			  tionn$$HEX1$$e900$$ENDHEX$$.)																 */
/*-----------------------------------------------------------------*/
If bRet Then

	If ( iDw_2.GetItemString ( lRow, "ALT_ARG2" ) = 'O'      ) and &
		( IsNull ( iDwSaisie.GetItemNumber ( 1, "NUM_ETS" ) ) ) then

		bRet = False
		stMessage.sCode	= "EWK0015"	
   	F_Message ( stMessage )

	End IF

End If


/*-----------------------------------------------------------------*/
/* CAS 6 : Le choix d'au moins un support est obligatoire.			 */
/*-----------------------------------------------------------------*/
If bRet Then


	If ( iDwSaisie.GetItemString ( 1, "ALT_PAPIER" ) = 'N'      ) and &
		( iDwSaisie.GetItemString ( 1, "ALT_EXCEL" )  = 'N'      ) Then

		bRet= False
		stMessage.sCode	= "EWK0016"	
   	F_Message ( stMessage )

	End IF

End If


/*-----------------------------------------------------------------*/
/* CAS 7 : Pour le support papier, la saisie d'un nombre d'exem-   */
/*			  plaire est obligatoire.											 */
/*-----------------------------------------------------------------*/
If bRet Then

	If ( iDwSaisie.GetItemString ( 1, "ALT_PAPIER" ) = 'O'      ) and &
		( IsNull ( iDwSaisie.GetItemNumber ( 1, "NBRE_EX" ) )    ) Then

		bRet= False
		stMessage.sCode	= "EWK0017"	
   	F_Message ( stMessage )

	End IF

End If


/*------------------------------------------------------------------*/
/* CAS 8 : On v$$HEX1$$e900$$ENDHEX$$rifie que la p$$HEX1$$e900$$ENDHEX$$riode de fin	existe bien sur la     */
/* 		  table cum_periode. Si ce n'est pas le cas on ne lance    */
/*			  pas le traitement.                                       */
/*------------------------------------------------------------------*/
If bRet Then
	
	iDwSaisie.GetChild ( "DTE_FIN", dwcPeriode )
	dwcPeriode.SetTransObject ( SQLCA )

	sRech = "DTE_FIN = " + String ( Date ( iDwSaisie.GetItemString ( 1, "DTE_FIN" ) ) , "yyyy-mm-dd" )

	lPeriodeFin = dwcPeriode.GetItemNumber ( dwcPeriode.Find ( sRech , 1, dwcPeriode.RowCount() ), "ID_PERIODE" )

	/*------------------------------------------------------------------*/
	/* Je d$$HEX1$$e900$$ENDHEX$$cide ici de ne pas cr$$HEX1$$e900$$ENDHEX$$er une nouvelle proc$$HEX1$$e900$$ENDHEX$$dure stock$$HEX1$$e900$$ENDHEX$$e     */
	/* sur la base, afin de ne pas la surcharger un peu plus. Le        */
	/* traitement sur demande est bien moins utilis$$HEX1$$e900$$ENDHEX$$, que toutes les    */
	/* autres fen$$HEX1$$ea00$$ENDHEX$$tres de SIMPA2. Ainsi je pense qu'il est pr$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rable   */
	/* dans ce cas de faire un SELECT en PB (qui sera compil$$HEX4$$e9002000e0002000$$ENDHEX$$chaque  */
	/* lancement bien entendu.)                                         */
	/*------------------------------------------------------------------*/

	lCpt = 0
	SELECT COUNT (*)
	INTO	 :lCpt
	FROM   sysadm.cum_periode
   WHERE  id_periode = :lPeriodeFin
	USING SQLCA ;


	If lCpt <= 0 Then

		bRet= False
		stMessage.sCode	= "EWK0019"	
   	F_Message ( stMessage )

	End IF


End If

Return bRet
end function

public subroutine uf_populisation_dw1 ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Populisation_Dw1 (Public)
//* Auteur			: JFF
//* Date				: 05/03/1999 16:16:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Populise Dw_1 (invisible) en fonction des choix de l'utilisateur.
//*
//* Commentaires	: Dw_1 est identique aux Dw_1 des fen$$HEX1$$ea00$$ENDHEX$$tres mensuelle et trimestrielle.
//*					  La diff$$HEX1$$e900$$ENDHEX$$rence est que sur ces fen$$HEX1$$ea00$$ENDHEX$$tres (mens et trim), ce sont des 
//*					  Retrieve qui permettent de les populiser en fonction d'$$HEX1$$e900$$ENDHEX$$tats d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$finis
//*					  sur la table traitement, ici nous allons remplir Dw_1 selon la demande
//*					  de l'utilisateur.
//*
//* Arguments		: 
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------


Boolean		bRet				// Boolean de retour
Long			lRowSelDw2		// Row s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$sur Dw_2 (Dw des $$HEX1$$e900$$ENDHEX$$tats affich$$HEX1$$e900$$ENDHEX$$s)

/*------------------------------------------------------------------*/
/* Si l'on arrive dans cette fonction, c'est que tous les           */
/* contr$$HEX1$$f400$$ENDHEX$$les en amont n'ont pas d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$s d'incoh$$HEX1$$e900$$ENDHEX$$rence dans les     */
/* choix.                                                           */
/*------------------------------------------------------------------*/

lRowSelDw2 = iDw_2.GetSelectedRow ( 0 )

//... Initialisation de Dw_1
iDw_1.Reset ()
iDw_1.InsertRow ( 0 )
iDw_1.SelectRow ( 1, True )


/*------------------------------------------------------------------*/
/* On renseigne le num$$HEX1$$e900$$ENDHEX$$ro de produit.           						  */
/*------------------------------------------------------------------*/
iDw_1.SetItem ( 1, "ID_PROD", iDwSaisie.GetItemNumber ( 1, "NUM_PROD" ) )


/*------------------------------------------------------------------*/
/* On renseigne le num$$HEX1$$e900$$ENDHEX$$ro de l'$$HEX1$$e900$$ENDHEX$$tat.             						  */
/*------------------------------------------------------------------*/
iDw_1.SetItem ( 1, "ID_ETAT", iDw_2.GetItemNumber ( lRowSelDw2, "ID_ETAT" ) )


/*------------------------------------------------------------------*/
/* On renseigne le libell$$HEX2$$e9002000$$ENDHEX$$de l'$$HEX1$$e900$$ENDHEX$$tat.             						  */
/*------------------------------------------------------------------*/
iDw_1.SetItem ( 1, "LIB_ETAT", iDw_2.GetItemString ( lRowSelDw2, "LIB_ETAT" ) )


/*------------------------------------------------------------------*/
/* On renseigne le code du DataObect										  */
/*------------------------------------------------------------------*/
iDw_1.SetItem ( 1, "COD_DW", iDw_2.GetItemString ( lRowSelDw2, "COD_DW" ) )


/*------------------------------------------------------------------*/
/* Y a-t-il une date de d$$HEX1$$e900$$ENDHEX$$but $$HEX2$$e0002000$$ENDHEX$$prendre en compte ?					  */
/*------------------------------------------------------------------*/
iDw_1.SetItem ( 1, "ALT_DTE_DEB", iDw_2.GetItemString ( lRowSelDw2, "ALT_DTE_DEB" ) )


/*------------------------------------------------------------------*/
/* Y a-t-il une date de fin $$HEX2$$e0002000$$ENDHEX$$prendre en compte ?					  	  */
/*------------------------------------------------------------------*/
iDw_1.SetItem ( 1, "ALT_DTE_FIN", iDw_2.GetItemString ( lRowSelDw2, "ALT_DTE_FIN" ) )


/*------------------------------------------------------------------*/
/* On consid$$HEX1$$e800$$ENDHEX$$re que pour un traitement sur demande, ALT_ARG1 ne     */
/* sera jamais $$HEX2$$e0002000$$ENDHEX$$'N', cela n'aurait pas sens, car le COD_ARG1 sera  */
/* toujours le num$$HEX1$$e900$$ENDHEX$$ro du produit.                                   */
/*------------------------------------------------------------------*/
iDw_1.SetItem ( 1, "COD_ARG1", iDwSaisie.GetItemNumber ( 1, "NUM_PROD" ) )


/*------------------------------------------------------------------*/
/* Si ALT_ARG2 est $$HEX2$$e0002000$$ENDHEX$$'O', COD_ARG2 sera toujours un num$$HEX1$$e900$$ENDHEX$$ro          */
/* d'$$HEX1$$e900$$ENDHEX$$tablissement (id_grp sur table GROUPE)                        */
/*------------------------------------------------------------------*/
If iDw_2.GetItemString ( lRowSelDw2, "ALT_ARG2" ) = 'O' Then
	iDw_1.SetItem ( 1, "COD_ARG2", iDwSaisie.GetItemNumber ( 1, "NUM_ETS" ) )
End IF


/*------------------------------------------------------------------*/
/* On renseigne le fait qu'il faille faire un Retrieve avec         */
/* arguments, sans argument, ou pas de Retrieve.                    */
/*------------------------------------------------------------------*/
iDw_1.SetItem ( 1, "COD_TYP_ETAT", iDw_2.GetItemString ( lRowSelDw2, "COD_TYP_ETAT" )  )


/*------------------------------------------------------------------*/
/* On renseigne le type de support, Papier ->1, Excel ->2,          */
/* Papier+Excel -> 4.                                               */
/* On renseigne en m$$HEX1$$ea00$$ENDHEX$$me temps le nbre d'exemplaireet le nom du      */
/* fichier Excel.																	  */	
/*------------------------------------------------------------------*/
If ( iDwSaisie.GetItemString ( 1, "ALT_PAPIER" ) = 'O' ) and ( iDwSaisie.GetItemString ( 1, "ALT_EXCEL" ) = 'O' ) Then
	iDw_1.SetItem ( 1, "COD_EDT", '4')
	iDw_1.SetItem ( 1, "NB_EXP", iDwSaisie.GetItemNumber ( 1, "NBRE_EX" ))
	iDw_1.SetItem ( 1, "NOM_FIC", iDwSaisie.GetItemString ( 1, "NOM_FIC" ))

ElseIf  iDwSaisie.GetItemString ( 1, "ALT_PAPIER" ) = 'O' Then
	iDw_1.SetItem ( 1, "COD_EDT", '1')
	iDw_1.SetItem ( 1, "NB_EXP", iDwSaisie.GetItemNumber ( 1, "NBRE_EX" ))

Else
	iDw_1.SetItem ( 1, "COD_EDT", '2')
	iDw_1.SetItem ( 1, "NOM_FIC", iDwSaisie.GetItemString ( 1, "NOM_FIC" ))

End IF


end subroutine

public subroutine uf_gestion_des_fleches (string assens);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Gestion_Des_Fleches (Public)
//* Auteur			: Fabry JF
//* Date				: 08/03/1999 11:37:16
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Gestion du d$$HEX1$$e900$$ENDHEX$$placemen par les fl$$HEX1$$e800$$ENDHEX$$ches
//* Commentaires	: 
//*
//* Arguments		: String			asSens				(Val)	Indique le sens de la fl$$HEX1$$e900$$ENDHEX$$che (Haut, Bas)
//*
//* Retourne		: Boolean 		bSel					// True si, apr$$HEX1$$e800$$ENDHEX$$s contr$$HEX1$$f400$$ENDHEX$$le, la ligne reste bien s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e
//*
//*-----------------------------------------------------------------

Long 		lRow				// Row courant et s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$
Long 		lNbreRow			// Nbre de Row s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$dans le m$$HEX1$$ea00$$ENDHEX$$me tour
Boolean  bSel 				// True si, apr$$HEX1$$e800$$ENDHEX$$s contr$$HEX1$$f400$$ENDHEX$$le, la ligne reste bien s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e


lRow = iDw_2.GetSelectedRow ( 0 )

// ... Afin que l'on puisse toujours reprendre la main par les fl$$HEX1$$e800$$ENDHEX$$ches
If lRow = 0 Then 
	lRow = 1
End IF

bSel = False


/*------------------------------------------------------------------*/
/* Gestion du sens de d$$HEX1$$e900$$ENDHEX$$filement des fl$$HEX1$$e800$$ENDHEX$$ches                        */
/*------------------------------------------------------------------*/
CHOOSE CASE upper ( asSens )

	//... Fl$$HEX1$$e900$$ENDHEX$$che vers le bas
	CASE "BAS"

		iDw_2.SelectRow ( 0, False )

		If lRow = iDw_2.Rowcount () Then
			iDw_2.SelectRow ( 1, True )
			iDw_2.SetRow		( 1 )
		Else
			iDw_2.SelectRow ( lRow + 1, True )			
			iDw_2.SetRow		( lRow + 1 )
		End IF

		lNbreRow = 1

		Do While not bSel and lNbreRow <= iDw_2.RowCount()

			bSel = This.uf_Controler_etat ()

	  		//... La ligne a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e
			If Not bSel Then
		
				//... On remet a jour lRow
				//... (Attention il n'y a plus de ligne s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX4$$e9002000e0002000$$ENDHEX$$ce moment)
				lRow = iDw_2.GetRow ( )

				If lRow = iDw_2.Rowcount () Then
					iDw_2.SelectRow ( 1, True )
					iDw_2.SetRow		( 1 )
				Else
					iDw_2.SelectRow ( lRow + 1, True )			
					iDw_2.SetRow		( lRow + 1 )
				End IF

				lNbreRow += 1

			Else
				iDw_2.ScrollToRow ( iDw_2.GetRow() )					
			End IF
	
		Loop		


	//... Fl$$HEX1$$e900$$ENDHEX$$che vers le Haut
	CASE "HAUT"

		iDw_2.SelectRow ( 0, False 		  )
	
		If lRow = 1 Then
			iDw_2.SelectRow ( iDw_2.Rowcount () , True )			
			iDw_2.SetRow		( iDw_2.Rowcount ()  		  )
		Else
			iDw_2.SelectRow ( lRow - 1, True )			
			iDw_2.SetRow		( lRow - 1 		  )
		End IF
			
		lNbreRow = 1

		Do While not bSel and lNbreRow <= iDw_2.RowCount()

			bSel = This.uf_Controler_etat ()

			//... La ligne ligne a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e
			If Not bSel Then
			
				//... On remet a jour lRow
				//... (Attention il n'y a plus de ligne s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX4$$e9002000e0002000$$ENDHEX$$ce moment)
				lRow = iDw_2.GetRow ( )

				If lRow = 1 Then
					iDw_2.SelectRow ( iDw_2.Rowcount () , True )			
					iDw_2.SetRow		( iDw_2.Rowcount ()  		  )
				Else
					iDw_2.SelectRow ( lRow - 1, True )			
					iDw_2.SetRow		( lRow - 1 		  )
				End IF
			
				lNbreRow += 1

			Else
				iDw_2.ScrollToRow ( iDw_2.GetRow() )					
			End IF
		Loop

END CHOOSE


//... Aucune ligne ne peut $$HEX1$$ea00$$ENDHEX$$tre s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e
//... Car aucune ne correspond aux choix de l'utilisateur

If Not bSel Then
	iDw_2.SelectRow ( 0, False )
End If




end subroutine

public function boolean uf_controler_etat ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Controler_Etat (ItemChanged de Dw_2)
//* Auteur			: JFF
//* Date				: 03/03/1999 16:16:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controle de l'$$HEX1$$e900$$ENDHEX$$tat s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$
//*
//* Commentaires	: Le boolean de Retour, permet de replacer la s$$HEX1$$e900$$ENDHEX$$lection d'un $$HEX1$$e900$$ENDHEX$$tat sur une autre ligne
//*					  en cas de d$$HEX1$$e900$$ENDHEX$$s$$HEX1$$e900$$ENDHEX$$lection. Le choix de la nouvelle ligne s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e est d$$HEX1$$e900$$ENDHEX$$termin$$HEX2$$e9002000$$ENDHEX$$sur 
//*					  la fonction Uf_Gestion_Des_Fleches, via les $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nements we_touche et clicked de DW_2.
//*
//* Arguments		: 
//*
//* Retourne		: Int		bRet			 True  : on laisse l'$$HEX1$$e900$$ENDHEX$$tat s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$.
//*												 False : on D$$HEX1$$e900$$ENDHEX$$s$$HEX1$$e900$$ENDHEX$$lectionne l'$$HEX1$$e900$$ENDHEX$$tat.
//*
//*-----------------------------------------------------------------


Boolean				bRet = True
DataWindowChild	dwChild
Int					iActionCode
Long					lRow



iActionCode = 0
lRow			= iDw_2.GetSelectedRow ( 0 )

iDwSaisie.GetChild ( "NUM_ETS", dwChild )


/*-----------------------------------------------------------------*/
/* Si l'$$HEX1$$e900$$ENDHEX$$tat accepte un deuxi$$HEX1$$e800$$ENDHEX$$me argument, et qu'il existe au moins*/
/* un $$HEX1$$e900$$ENDHEX$$tablissement pour le produit s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$, alors on rend     */
/* visible la liste des $$HEX1$$e900$$ENDHEX$$tablissements (Attention, seulement s'il  */
/* y a un produit s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$! )											 */
/* SINON, on la rend invisible, et on d$$HEX1$$e900$$ENDHEX$$s$$HEX1$$e900$$ENDHEX$$lectionne l'$$HEX1$$e900$$ENDHEX$$tat.			 */
/*-----------------------------------------------------------------*/


If ( iDw_2.GetItemString ( lRow, "ALT_ARG2" ) = 'O'           ) and &
	( dwChild.RowCount( ) > 0 								 			  ) and &
	( Not IsNull ( iDwSaisie.GetItemNumber ( 1, "NUM_PROD" ) ) ) Then

		iDwSaisie.Modify ( "NUM_ETS.visible = 1" )
Else
		iDwSaisie.Modify ( "NUM_ETS.visible = 0" )

		If iDw_2.GetItemString ( lRow, "ALT_ARG2" ) = 'O' Then
			bRet = False
			iDw_2.SelectRow ( 0, False )
		End IF

End If



/*-----------------------------------------------------------------*/
/* Si l'$$HEX1$$e900$$ENDHEX$$tat est un 'EN COURS', on rend invisible la date de d$$HEX1$$e900$$ENDHEX$$but */
/* ( et on la remet $$HEX2$$e0002000$$ENDHEX$$null !!	)												 */
/*-----------------------------------------------------------------*/

// ... lRow a pu changer...
lRow			= iDw_2.GetSelectedRow ( 0 )

If lRow > 0 Then 
	If ( iDw_2.GetItemString ( lRow, "ALT_DTE_DEB" ) = 'N' ) Then
			iDwSaisie.Modify ( "DTE_DEB.visible = 0" )
			iDwSaisie.Modify ( "TXT_AU.visible = 0" )
			iDwSaisie.Modify ( "TXT_TRAIT.text = 'Traitement de'" )
			iDwSaisie.Modify ( "DTE_FIN.x = 394" )
			iDwSaisie.SetItem ( 1, "DTE_DEB", stNul.str )
	Else
			iDwSaisie.Modify ( "DTE_DEB.visible = 1" )
			iDwSaisie.Modify ( "TXT_AU.visible = 1" )
			iDwSaisie.Modify ( "TXT_TRAIT.text = 'Traitement du'" )
			iDwSaisie.Modify ( "DTE_FIN.x = 878" )
	End If
End IF


/*------------------------------------------------------------------*/
/* Si l'$$HEX1$$e900$$ENDHEX$$tat est un $$HEX1$$e900$$ENDHEX$$tat pour 'carte', et que le produit s$$HEX1$$e900$$ENDHEX$$lection- */
/* (s'il y en a un de s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$) n'est pas un produit $$HEX2$$e0002000$$ENDHEX$$adh$$HEX1$$e900$$ENDHEX$$sion  */
/* par carte, on remet $$HEX2$$e0002000$$ENDHEX$$NULL, la zone de s$$HEX1$$e900$$ENDHEX$$lection du produit.     */
/* On rend invisible la liste des $$HEX1$$e900$$ENDHEX$$tablissements, puisqu'il n'y a   */
/* pas de produit de s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$.											  */
/*------------------------------------------------------------------*/

If lRow > 0 Then

	iDwSaisie.GetChild ( "NUM_PROD", dwChild )

	If dwChild.GetRow( ) > 0 Then

		If ( iDw_2.GetItemString   ( lRow, "COD_TYP_ADH"       	  ) =  'C' ) and & 
			( dwChild.GetItemString ( dwChild.GetRow( ), "COD_ADH"  ) <> '3' ) Then
	
			iDwSaisie.SetItem ( 1, "NUM_PROD", stNul.dcm )

			// ... Attention, si pas de prod et ALT_ARG2 = 'O',
			// ... On d$$HEX1$$e900$$ENDHEX$$selectionne l'$$HEX1$$e900$$ENDHEX$$tat.
			If iDw_2.GetItemString ( lRow, "ALT_ARG2" ) = 'O' Then
				bRet = False
				iDw_2.SelectRow ( 0, False )
			End IF

			iDwSaisie.Modify ( "NUM_ETS.visible = 0" )

		End If

	End IF

End IF

Return bRet
end function

private function boolean uf_lireperiode (ref long alperiodedeb, ref long alperiodefin, ref datetime adtdtedeb, ref datetime adtdtefin);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_LirePeriode ( Private ) (OverRide)
//* Auteur			: JFF
//* Date				: 08/03/1998 13:46:52
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Lecture des p$$HEX1$$e900$$ENDHEX$$riodes de d$$HEX1$$e900$$ENDHEX$$but et de fin de traitement
//* Commentaires	: Tous les contr$$HEX1$$f400$$ENDHEX$$les de coh$$HEX1$$e900$$ENDHEX$$rence entre les deux dates sont fait en amonts.
//*
//* Arguments		: Long		alPeriodeDeb			(Val) 		// P$$HEX1$$e900$$ENDHEX$$riode de d$$HEX1$$e900$$ENDHEX$$but
//*					  Long		alPeriodeFin			(Val)			// P$$HEX1$$e900$$ENDHEX$$riode de fin
//*					  DateTime	adtDteDeb				(Val)			// DateTime
//*					  DateTime	adtDteFin				(Val)			// DateTime
//* Retourne		: Boolean 	True si Ok
//*										
//*
//*-----------------------------------------------------------------

Boolean				bRet	=	True
DataWindowChild	dwChild



adtDteDeb   =  DateTime ( Date ( iDwSaisie.GetItemString ( 1, "DTE_DEB" ) ), Time ( "00:00" ) )
adtDteFin   =  DateTime ( Date ( iDwSaisie.GetItemString ( 1, "DTE_FIN" ) ), Time ( "23:59" ) )

iDwSaisie.GetChild ( "DTE_DEB", dwChild )
alPeriodeDeb = dwChild.GetItemNumber ( dwChild.GetRow(), "ID_PERIODE" )

If IsNull ( alPeriodeDeb ) or ( alPeriodeDeb < 199401 ) Then
	bRet = False
End IF

If bRet Then
	iDwSaisie.GetChild ( "DTE_FIN", dwChild )
	alPeriodeFin = dwChild.GetItemNumber ( dwChild.GetRow(), "ID_PERIODE" )
End IF

If not bRet or IsNull ( alPeriodeFin ) or ( alPeriodeFin < 199401 ) Then
	bRet = False
End IF


Return ( bRet )
end function

public subroutine uf_efface_col_en_cours ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Efface_Col_En_Cours (Public)
//* Auteur			: Fabry JFF
//* Date				: 08/03/1999 15:47:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Efface l'affichage de la colonne 'EN COURS' (MAJ_PAR) $$HEX2$$e0002000$$ENDHEX$$chaque lancement de Traitement
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: 
//*										
//*
//*-----------------------------------------------------------------

Long 		lRow

For lRow = 1 to iDw_2.RowCount()
	iDw_2.SetItem ( lRow, "MAJ_PAR", stNul.str )
Next
end subroutine

private subroutine uf_nom_fichier (ref string asnomcomplet, ref string asnomfic);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Nom_Fichier
//* Auteur			: FABRY JF
//* Date				: 09/03/1999 14:16:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le le nom du fichier
//* Commentaires	: 
//*
//* Arguments		: String			asNomComplet				(Ref)	Nom complet (chemin + fichier)
//*					  String			asNomFic						(Ref) Nom Fichier uniquement
//*
//* Retourne		: 
//*						
//*
//*-----------------------------------------------------------------
//			FPI		06/01/2015	[ETAT_XLSX]
//*-----------------------------------------------------------------

String			sChemin
Int				iPos



/*------------------------------------------------------------------*/
/* On isole le chemin                                               */
/*------------------------------------------------------------------*/

iPos = len ( asNomComplet )

Do While iPos > 0 and mid ( asNomComplet, iPos, 1 ) <> '\'
	iPos -= 1
Loop

sChemin = Left ( asNomComplet, iPos )


/*------------------------------------------------------------------*/
/* On contr$$HEX1$$f400$$ENDHEX$$le le nom du fichier												  */
/*------------------------------------------------------------------*/

iPos = 1
Do While iPos <= Len ( asNomFic ) and mid ( asNomFic, iPos, 1 ) <> '.' and iPos <= 8
	iPos += 1
Loop

If Upper(Mid(asNomFic,iPos + 1)) <> "XLS" And Upper(Mid(asNomFic,iPos + 1)) <> "XLSX" Then // [ETAT_XLSX]
	asNomFic 	 = upper ( Left ( asNomFic, iPos - 1 ) + ".XLS" )
End if

asNomComplet = upper ( sChemin ) + asNomFic

end subroutine

public subroutine uf_initialiser (ref u_datawindow_accueil adw_1, ref u_datawindow adw_2, ref u_datawindow adwsaisie, ref datawindow adwetat, ref u_volcane adw_volcane, ref u_barredefil auodefil, ref u_transaction atrtrans);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Sp_Gs_Trait_Etat_Dde::Uf_Initialiser (PUBLIC) (OverRide)
//* Auteur			: JFF
//* Date				: 01/03/1999 15:56:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: U_DataWindow_Accueil	adw_1					(R$$HEX1$$e900$$ENDHEX$$f)	     // Fen$$HEX1$$ea00$$ENDHEX$$tre Dw_1 identique au Trt M,T. Mais invisible
//*					  U_DataWindow				adw_2					(R$$HEX1$$e900$$ENDHEX$$f)	     // Fen$$HEX1$$ea00$$ENDHEX$$tre Dw_2 Visible, pr$$HEX1$$e900$$ENDHEX$$sente les $$HEX1$$e900$$ENDHEX$$tats disponibles
//*					  U_Datawindow				adwSaisie			(R$$HEX1$$e900$$ENDHEX$$f)
//*					  DataWindow				adwEtat				(R$$HEX1$$e900$$ENDHEX$$f)
//*					  U_Volcane					adw_Volcane    	(R$$HEX1$$e900$$ENDHEX$$f)
//						  u_barredefil				auoDefil				(R$$HEX1$$e900$$ENDHEX$$f)
//*					  U_Transaction			atrTrans				(R$$HEX1$$e900$$ENDHEX$$f)
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

DataWindowChild	dwChild
String 				sFicPeriode
n_cst_string			lnvString // [MIGPB11] [EMD] : ImportFile d'une chaine vide

idw_1			= adw_1
idw_2			= adw_2
idwSaisie	= adwSaisie
idw_Etat		= adwEtat
idw_Volcane = adw_Volcane
iuoDefil		= auoDefil
itrTrans		= atrTrans


/*------------------------------------------------------------------*/
/* On populise la Dw_2, affichant les etats disponibles				  */
/*------------------------------------------------------------------*/

iDw_2.SetTransObject ( itrTrans )
iDw_2.Retrieve ()
iDw_2.SetSort ( "#2 A" )
iDw_2.Sort ( )

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le fichier pour les p$$HEX1$$e900$$ENDHEX$$riodes de traitement.          */
/*------------------------------------------------------------------*/
sFicPeriode = ProfileString ( stGLB.sFichierIni, "TRAITEMENT", "FICHIER_PERIODE", "" )

If Not lnvString.of_isEmpty ( sFicPeriode ) Then // [MIGPB11] [EMD] : ImportFile d'une chaine vide
	/*------------------------------------------------------------------*/
	/* Populise les deux DDDW des dates								*/
	/*------------------------------------------------------------------*/
	idwSaisie.GetChild ( "DTE_DEB", dwChild )
	dwChild.ImportFile ( sFicPeriode )
	dwChild.SetFilter ( "DTE_DEB < Today()" )
	dwChild.Filter()
	dwChild.Sort ( )
	
	
	idwSaisie.GetChild ( "DTE_FIN", dwChild )
	dwChild.ImportFile ( sFicPeriode )
	dwChild.SetFilter ( "DTE_DEB < Today()" )
	dwChild.Filter()
	dwChild.Sort ( )
End If // [MIGPB11] [EMD] : ImportFile d'une chaine vide

/*------------------------------------------------------------------*/
/* Populise les deux DDDW des produits et etablissements				  */
/*------------------------------------------------------------------*/
idwSaisie.GetChild ( "NUM_PROD", dwChild )
dwChild.SetTransObject ( itrTrans )
dwChild.Retrieve()

idwSaisie.GetChild ( "NUM_ETS", dwChild )
dwChild.SetTransObject ( itrTrans )
dwChild.Retrieve()

iDwSaisie.Modify ( "NUM_ETS.visible = 0" )


/*------------------------------------------------------------------*/
/* Initilisation des supports                                       */
/*------------------------------------------------------------------*/

idwSaisie.InsertRow ( 0 )
end subroutine

public function long uf_controler_saisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Controler_Saisie (ItemChanged de Dw_Saisie)
//* Auteur			: JFF
//* Date				: 02/03/1999 16:16:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Controle la saisie sur iDwSaisie
//* Commentaires	: 
//*
//* Arguments		: 
//*
//Migration PB8-WYNIWYG-03/2006 FM
////* Retourne		: 
//* Retourne		: long (au lien de (None)
//Fin Migration PB8-WYNIWYG-03/2006 FM
//*
//*-----------------------------------------------------------------
//			FPI		06/01/2015	[ETAT_XLSX]
//*-----------------------------------------------------------------

String 				sNomCol, sFiltre, sDateDeb, sDateFin, sNbEx, sNomComplet, sNomFic
DataWindowChild	dwChild
Int					iRetour, iActionCode


sNomCol 		= iDwSaisie.isNomCol
iActionCode = 0

CHOOSE CASE sNomCol

	// ... Date de d$$HEX1$$e900$$ENDHEX$$but
	CASE "DTE_DEB"
		
		sDateDeb = iDwSaisie.GetText ( )
		sDateFin = iDwSaisie.GetItemString ( 1, "DTE_FIN" )

		If Date ( sDateDeb ) > Date ( sDateFin ) Then

			 iDwSaisie.iiErreur = 1
			 iActionCode 		  = 1

		ElseIf Date ( sDateDeb ) >= Today( ) Then
			 iDwSaisie.iiErreur = 11
			 iActionCode 		  = 1
		End IF

	// ... Date de Fin
	CASE "DTE_FIN"
		
		sDateDeb = iDwSaisie.GetItemString ( 1, "DTE_DEB" )
		sDateFin = iDwSaisie.GetText (  )

		If Date ( sDateFin ) < Date ( sDateDeb ) Then
			 iDwSaisie.iiErreur = 2
			 iActionCode 		  = 1

		ElseIf Date ( sDateFin ) >= Today( ) Then
			 iDwSaisie.iiErreur = 21
			 iActionCode 		  = 1

		End IF


	// ... S$$HEX1$$e900$$ENDHEX$$lection du produit
	CASE "NUM_PROD"


		iDwSaisie.SetItem ( 1, "NUM_ETS", stNul.dcm ) 

		iDwSaisie.GetChild ( "NUM_PROD", dwChild )
		sFiltre = "ID_PROD = " + String ( dwChild.GetItemNumber ( dwChild.GetRow() , "ID_PROD" ) )

		iDwSaisie.GetChild ( "NUM_ETS", dwChild )
		dwChild.SetFilter ( sFiltre  )
		dwChild.Filter ()

		/*-----------------------------------------------------------------*/
		/* Liste $$HEX1$$e900$$ENDHEX$$tablissement invisible s'il n'y a pas d'$$HEX1$$e900$$ENDHEX$$tablissement	 */
		/* OU invisible si l'$$HEX1$$e900$$ENDHEX$$tat s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$n'accepte pas un deuxi$$HEX1$$e800$$ENDHEX$$me    */
      /* parametre																    	 */
		/* OU invisible s'il n'y a pas d'$$HEX1$$e900$$ENDHEX$$tat s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX8$$e9000900090009000900090009002000$$ENDHEX$$*/
		/*-----------------------------------------------------------------*/
		
		If iDw_2.GetSelectedRow( 0 ) > 0 then

			If ( dwChild.RowCount( ) < 1 ) or ( iDw_2.GetItemString ( iDw_2.GetSelectedRow( 0 ), "ALT_ARG2" ) = 'N' ) Then
				iDwSaisie.Modify ( "NUM_ETS.visible = 0" )
			Else
				iDwSaisie.Modify ( "NUM_ETS.visible = 1" )
			End IF
		
		Else

			iDwSaisie.Modify ( "NUM_ETS.visible = 0" )

		End If

		/*-----------------------------------------------------------------*/
		/* Si l'$$HEX1$$e900$$ENDHEX$$tat s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$attend un deuxi$$HEX1$$e800$$ENDHEX$$me param$$HEX1$$e800$$ENDHEX$$tre et que le    */
		/* produit s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$n'a pas d'$$HEX1$$e900$$ENDHEX$$tablissement, on d$$HEX1$$e900$$ENDHEX$$s$$HEX1$$e900$$ENDHEX$$lectionne   */
		/* alors l'$$HEX1$$e900$$ENDHEX$$tat. 																	 */
		/*-----------------------------------------------------------------*/
		
		If iDw_2.GetSelectedRow( 0 ) > 0 then

			If ( dwChild.RowCount( ) < 1 ) and ( iDw_2.GetItemString ( iDw_2.GetSelectedRow( 0 ), "ALT_ARG2" ) = 'O' ) Then
				iDw_2.SelectRow ( 0, False )
			End IF
		
		Else

			iDwSaisie.Modify ( "NUM_ETS.visible = 0" )

		End If



		/*------------------------------------------------------------------*/
		/* Si le produit s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$n'est pas un produit $$HEX2$$e0002000$$ENDHEX$$adh$$HEX1$$e900$$ENDHEX$$sion par 	  */
		/* cartes, et que l'$$HEX1$$e900$$ENDHEX$$tat s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$est un $$HEX1$$e900$$ENDHEX$$tat pour Cartes, on    */
		/* d$$HEX1$$e900$$ENDHEX$$selectionne l'$$HEX1$$e900$$ENDHEX$$tat.														  */
		/*------------------------------------------------------------------*/

		iDwSaisie.GetChild ( "NUM_PROD", dwChild )

		If iDw_2.GetSelectedRow ( 0 ) > 0 Then

			If ( dwChild.GetItemString ( dwChild.GetRow( ), "COD_ADH" 							  ) <>  '3' ) and &
				( iDw_2.GetItemString   ( iDw_2.GetSelectedRow ( 0 ), "COD_TYP_ADH"       	  ) = 'C' ) Then

				iDw_2.SelectRow ( 0, False )		

			End IF

		End IF


	// ... Etat Papier
	CASE "ALT_PAPIER"

		iDwSaisie.SetItem ( 1, "NBRE_EX", 1 )


	// ... Fen$$HEX1$$ea00$$ENDHEX$$tre saisie du nom de fichier
	CASE "ALT_EXCEL"

		If iDwSaisie.GetText () = 'O' Then 
			sNomComplet = ""

			// [ETAT_XLSX] - ajout de XLSX
			iRetour = GetFileSaveName( "Nom du fichier Excel", sNomComplet, sNomFic, "", &
												"Fichiers Excel (*.XLS),*.XLS, Fichiers Excel 2010 (*.XLSX),*.XLSX,Tous Fichiers (*.*),*.*")

			If iRetour > 0 Then 

				// ...Contr$$HEX1$$f400$$ENDHEX$$le le nom du fichier
				uf_Nom_Fichier ( sNomComplet, sNomFic )				

				iDwSaisie.SetItem ( 1, "NOM_FIC", sNomComplet )
				iDwSaisie.Modify ( "NOM_FIC.visible = 1" )
			Else
	 			iActionCode = 1
			End IF
		Else

			iDwSaisie.Modify ( "NOM_FIC.visible = 0" )

		End IF


END CHOOSE

//Migration PB8-WYNIWYG-03/2006 FM
//iDwSaisie.SetActionCode ( iActionCode )
Return iActionCode
//Fin Migration PB8-WYNIWYG-03/2006 FM

end function

public function long uf_erreur_saisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Erreur_Saisie (ItemError de Dw_Saisie)
//* Auteur			: JFF
//* Date				: 02/03/1999 16:16:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Gestion des erreurs de Dw_Saisie
//* Commentaires	: 
//*
//* Arguments		: 
//*
//Migration PB8-WYNIWYG-03/2006 FM
////* Retourne		: 
//* Retourne		: long au lien de (None)
//Fin Migration PB8-WYNIWYG-03/2006 FM
//*
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

If iDwSaisie.ibErreur Then

   stMessage.sTitre  = "SIMPA2"
   stMessage.Icon	   = Information!
	stMessage.bErreurG= False


	CHOOSE CASE iDwSaisie.iiErreur

		CASE 0 

			 // Gestion des erreurs d$$HEX1$$e900$$ENDHEX$$clench$$HEX1$$e900$$ENDHEX$$es via une r$$HEX1$$e800$$ENDHEX$$gle de validation
		    CHOOSE CASE iDwSaisie.isErrCol

					// ... Nombre d'exemplaires papier <= 10 et > 0
					CASE "NBRE_EX"

			          stMessage.sCode	 = "EWK0010"
						 F_Message ( stMessage )				

						 iDwSaisie.SetText("")
						 iDwSaisie.SetItem ( 1, iDwSaisie.isErrCol, stNul.inum )
						 

			 END CHOOSE


		// ... Date D$$HEX1$$e900$$ENDHEX$$but > Date Fin ou Date Fin < Date d$$HEX1$$e900$$ENDHEX$$but
		CASE 1, 2
          stMessage.sVar[1] = "date de d$$HEX1$$e900$$ENDHEX$$but"
          stMessage.sVar[2] = "date de fin"
          stMessage.sCode	 = "EWK0008"
			 stMessage.bErreurG= True

			 F_Message ( stMessage )				
			 iDwSaisie.SetText("")
			 iDwSaisie.SetItem ( 1, iDwSaisie.isErrCol, stNul.Str )


		// ... Date D$$HEX1$$e900$$ENDHEX$$but et Date de fin > Date jour
		CASE 11, 21

          stMessage.sCode	 = "EWK0004"
		 	 stMessage.bErreurG= TRUE

			 If iDwSaisie.iiErreur = 11 Then
	          stMessage.sVar[1] = "de d$$HEX1$$e900$$ENDHEX$$but"
			 Else
	          stMessage.sVar[1] = "de fin"
			 End IF

			 F_Message ( stMessage )				
			 iDwSaisie.SetText("")
			 iDwSaisie.SetItem ( 1, iDwSaisie.isErrCol, stNul.Str )

	END CHOOSE

iDwSaisie.iiErreur = 0
//Migration PB8-WYNIWYG-03/2006 FM
//iDwSaisie.SetActionCode ( 1 )
ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
End If

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end function

on u_sp_gs_trait_etat_dde.create
call super::create
end on

on u_sp_gs_trait_etat_dde.destroy
call super::destroy
end on

