HA$PBExportHeader$u_sp_gs_trait_etat.sru
$PBExportComments$--- } UserObjet pour gestion des etats p$$HEX1$$e900$$ENDHEX$$riodiques
forward
global type u_sp_gs_trait_etat from u_sp_gs_trait_anc
end type
end forward

global type u_sp_gs_trait_etat from u_sp_gs_trait_anc
end type
global u_sp_gs_trait_etat u_sp_gs_trait_etat

type variables
Public :

//Migration PB8-WYNIWYG-03/2006 FM
//Ces variables sont d$$HEX1$$e900$$ENDHEX$$clar$$HEX1$$e900$$ENDHEX$$es dans l'anc$$HEX1$$ea00$$ENDHEX$$tre
//	Long			ilNbLig
//	Long			ilNumEtat
//Fin Migration PB8-WYNIWYG-03/2006 FM
	u_Volcane		iDw_volcane
	
constant string 	K_FICTRTSMA  = "TRTSP2.DAT"// [DCMP080109] Nom du Fichier de Sortie SMA
constant long		K_BASEERRSMA = 10000			// [DCMP080109]N$$HEX2$$b0002000$$ENDHEX$$de base pour Code Erreur SMA


end variables

forward prototypes
public subroutine uf_generer_dw (string astyptrt)
private subroutine uf_initdefil ()
private function boolean uf_lireperiode (ref long alperiodedeb, ref long alperiodefin, ref datetime adtDteDeb, ref datetime adtDteFin)
public function boolean uf_zn_dtefin (string astypetrt, string asval)
public subroutine uf_d_l_reg1 ()
public subroutine uf_lancertrt (ref u_datawindow adwaff, string astyptrt)
private function boolean uf_editionetat (ref u_datawindow adwaff, string ascodedt, integer ainbexp, string asnomfic, long alligtrt)
public subroutine uf_personnaliser ()
public subroutine uf_initialiser (ref u_datawindow_detail adw_1, ref datawindow adw_dates, ref u_volcane adw_volcane, ref datawindow adw_dept, ref u_barredefil auodefil, ref datawindow adwetat, ref u_transaction atrtrans)
public subroutine uf_d_l_reg13 ()
private function integer uf_d_l_relance_btq_broker (string asnomfic)
private function integer uf_d_l_pm02_fic_xxxx (string asnomfic)
protected subroutine uf_creerdossier (string asnomfichier)
private function integer uf_d_l_stat_frais_presta_2 (string asnomfic)
public function integer uf_d_l_reg_frais_presta_volcane (string asnomfic)
public subroutine uf_d_l_reg_rassureo ()
public function string uf_format_nomfic (string asnomfic)
public function long uf_saveas_csv_point_virugule (string asnomfic)
end prototypes

public subroutine uf_generer_dw (string astyptrt);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Generer_Dw
//* Auteur			: DBI
//* Date				: 12/11/1998 16:16:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Cr$$HEX1$$e900$$ENDHEX$$e la Datawindow d'accueil du traitement et la charge
//* Commentaires	: 
//*
//* Arguments		: String			asTypTrt				// Type Traitement ( Mensuel, trimestriel... )
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//String 					sTables[3]			//Tableau pour les tables d'o$$HEX2$$f9002000$$ENDHEX$$proviennent les champs de la datawindow
String 					sTables[]			//Tableau pour les tables d'o$$HEX2$$f9002000$$ENDHEX$$proviennent les champs de la datawindow
//Fin Migration PB8-WYNIWYG-03/2006 FM
// [SQL_2K8_CH] [I027] - Variables pour l'insertion de la jointure externe $$HEX2$$e0002000$$ENDHEX$$la norme SQL ANSI-92
string sFromClause

// [DCMP060192] Forcage du DEPARTMENT a 9999 (DFC) pour les etat utilisant les dataobjects
// dr_reg1, dl_reg11, dl_reg4, dl_reg5
// La colonne 'sysadm.produit.id_dept' est remplac$$HEX1$$e900$$ENDHEX$$e par le CASE ci-dessous
// #1	PHG	17/12/2009 [MIGPB11] Agrandissement Zone nom_fic $$HEX2$$e0002000$$ENDHEX$$255

string ls_PatchClauseSelect = &
" CASE "+ &
" WHEN sysadm.etat_stat.cod_dw IN (~~'D_R_REG1~~', ~~'D_L_REG11~~', ~~'D_L_REG4_TEL~~', ~~'D_L_REG5_TEL~~') THEN 9999 "+ &
" ELSE sysadm.produit.id_dept " + &
" END "

/*------------------------------------------------------------------*/
/* Description de la DW d'accueil                                   */
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
iDw_1.istCol[14].sType			=	"char(255)" //#1 [MIGPB11]
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

sTables[ 1 ]	= "etat_stat"
sTables[ 2 ]   = "traitement"
sTables[ 3 ]   = "produit"

/*------------------------------------------------------------------*/
/* Positionnement de la jointure en fonction de de la p$$HEX1$$e900$$ENDHEX$$riodicit$$HEX4$$e900200020002000$$ENDHEX$$*/
/* du traitement                                                    */
/*------------------------------------------------------------------*/

// [SQL_2K8_CH] [I027] Optimisation et suppression de jointure externe
// CE qui suit rempalc$$HEX2$$e9002000$$ENDHEX$$par ce qui est tagg$$HEX2$$e9002000$$ENDHEX$$: [SQL_2K8_CH] [I027]
/*
Choose Case asTypTrt

	Case "M"
		iDw_1.isJointure= " WHERE sysadm.etat_stat.id_etat = sysadm.traitement.id_etat and " + &
								" sysadm.traitement.id_prod *= sysadm.produit.id_prod        and " + &
								" sysadm.traitement.alt_m = ~~'O~~'"

	Case "T"
		iDw_1.isJointure= " WHERE sysadm.etat_stat.id_etat = sysadm.traitement.id_etat and " + &
								" sysadm.traitement.id_prod *= sysadm.produit.id_prod        and " + &
								" sysadm.traitement.alt_t = ~~'O~~'"

	Case "S"
		iDw_1.isJointure= " WHERE sysadm.etat_stat.id_etat = sysadm.traitement.id_etat and " + &
								" sysadm.traitement.id_prod *= sysadm.produit.id_prod        and " + &
								" sysadm.traitement.alt_s = ~~'O~~'"

	Case "A"
		iDw_1.isJointure= " WHERE sysadm.etat_stat.id_etat = sysadm.traitement.id_etat and " + &
								" sysadm.traitement.id_prod *= sysadm.produit.id_prod        and " + &
								" sysadm.traitement.alt_a = ~~'O~~'"
*/

//[SQL_2K8_CH] [I027] la jointure exerne en *= a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$supprim$$HEX1$$e900$$ENDHEX$$e
iDw_1.isJointure=" WHERE sysadm.etat_stat.id_etat = sysadm.traitement.id_etat and "
Choose Case asTypTrt
	Case "M"
		iDw_1.isJointure+=" sysadm.traitement.alt_m = ~~'O~~'"
	Case "T"
		iDw_1.isJointure+=" sysadm.traitement.alt_t = ~~'O~~'"
	Case "S"
		iDw_1.isJointure+=" sysadm.traitement.alt_s = ~~'O~~'"
	Case "A"
		iDw_1.isJointure+=" sysadm.traitement.alt_a = ~~'O~~'"
End Choose

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/
iDw_1.Uf_Creer_Tout ( iDw_1.istCol, sTables, itrTrans )
iDw_1.isTri = "#16 A, #1 A"

// [DCMP060192] On patch le select avant constitution
iDw_1.isSelect = f_remplace ( iDw_1.isSelect, 'sysadm.produit.id_dept', ls_PatchClauseSelect)

iDw_1.isSelect += iDw_1.isJointure

//[SQL_2K8_CH] [I027] Remplacement de la clause FROM autog$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e pour int$$HEX1$$e900$$ENDHEX$$grer une clause FROM  avec la 
// jointure externe au format ANSI
sFromClause = "sysadm."+sTables[ 1 ]	+', sysadm.' + sTables[ 2 ] + ' LEFT OUTER JOIN sysadm.' + sTables[ 3 ] + ' ON ( sysadm.traitement.id_prod = sysadm.produit.id_prod ) '
iDw_1.uf_Setfromclause( sFromClause )
// Fin [SQL_2K8_CH] [I027]

iDw_1.Modify ( "datawindow.table.select = ~'" + iDw_1.isSelect  + "~'")

iDw_1.Retrieve()

iDw_1.SelectRow ( 0, True )
end subroutine

private subroutine uf_initdefil ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_InitDefil	( Private )
//* Auteur			: DBI
//* Date				: 28/12/1998 16:21:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: initialisation de l'objet de d$$HEX1$$e900$$ENDHEX$$filement
//* Commentaires	: Lecture du nombre d'$$HEX1$$e900$$ENDHEX$$tat s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$avant mis $$HEX1$$e000$$ENDHEX$$
//*						jour de uo_defil
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*						
//*-----------------------------------------------------------------

UnsignedLong		ulNbEtat	= 0
Long					lLig

/*------------------------------------------------------------------*/
/* Recherche du nombre d'$$HEX1$$e900$$ENDHEX$$tats s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$s                         */
/*------------------------------------------------------------------*/

lLig = iDw_1.GetSelectedRow ( 0 )

If lLig > 0 Then
	Do
		ulNbEtat ++
		lLig = iDw_1.GetSelectedRow ( lLig )
	Loop While lLig > 0
End If

/*------------------------------------------------------------------*/
/* Initialisation Uo_Defil                                          */
/*------------------------------------------------------------------*/

iuodefil.Uf_Init ( ulNbEtat )
end subroutine

private function boolean uf_lireperiode (ref long alperiodedeb, ref long alperiodefin, ref datetime adtDteDeb, ref datetime adtDteFin);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_LirePeriode ( Private )
//* Auteur			: DBI
//* Date				: 28/12/1998 13:46:52
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Lecture des p$$HEX1$$e900$$ENDHEX$$riodes de d$$HEX1$$e900$$ENDHEX$$but et de fin de traitement
//* Commentaires	: 
//*
//* Arguments		: Long	alPeriodeDeb	
//*					  Long	alPeriodeFin
//* Retourne		: Boolean 	True si Ok
//*										
//*
//*-----------------------------------------------------------------

Date					dDateDebut
Date					dDateFin
DataWindowChild	dwChild

String				sRech

Long					lLig

Boolean				bRet	=	True

/*------------------------------------------------------------------*/
/* La zone p$$HEX1$$e900$$ENDHEX$$riode est positionn$$HEX1$$e900$$ENDHEX$$e dans la fonction                 */
/* uf_verifierdates avec la valeur de DTE_FIN                       */
/*------------------------------------------------------------------*/

alPeriodeFin=	idw_Dates.GetItemNumber ( 1, "ID_PERIODE" )

/*------------------------------------------------------------------*/
/* Chargement de la p$$HEX1$$e900$$ENDHEX$$riode de d$$HEX1$$e900$$ENDHEX$$but                                */
/*------------------------------------------------------------------*/

idw_Dates.GetChild ( "DTE_FIN", dwChild )

dDateDebut	=	idw_Dates.GetItemDate   ( 1, "DTE_DEB" )
dDateFin		=	idw_Dates.GetItemDate   ( 1, "DTE_FIN" )

sRech			=	"DTE_DEB = " + String ( dDateDebut, "yyyy-mm-dd" )
lLig			=	dwChild.Find ( sRech, 1, dwChild.RowCount () )

If lLig > 0 Then

	alPeriodeDeb=	dwChild.GetItemNumber ( lLig, "ID_PERIODE" )
Else

	bRet = False
End If

/*------------------------------------------------------------------*/
/* Il faut positionner une heure mini sur dteDeb et une heure maxi  */
/* sur dteFin                                                       */
/* sinon on risque d'oublier une journ$$HEX1$$e900$$ENDHEX$$e dans les select            */
/*------------------------------------------------------------------*/

adtDteDeb	=	Datetime ( dDateDebut, Time ( "00:00" ) )
adtDteFin	=	Datetime ( dDateFin  , Time ( "23:59" ) )

Return ( bRet )
end function

public function boolean uf_zn_dtefin (string astypetrt, string asval);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_zn_dtefin (Public)
//* Auteur			: JFF
//* Date				: 12/01/1999
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Calcul de la date de d$$HEX1$$e900$$ENDHEX$$but en fonction 
//* Commentaires	: de la date de fin et de la p$$HEX1$$e900$$ENDHEX$$riode de traitement
//*
//* Arguments		: String			asTypeTrt			(Val)	Type de traitement
//*				  	  String			asVal					(Val) La date de fin
//*
//* Retourne		: True si aucun probl$$HEX1$$e800$$ENDHEX$$me ( On consid$$HEX1$$e800$$ENDHEX$$re que le fichier est toujours correctement renseign$$HEX2$$e9002000$$ENDHEX$$)
//* 					  False si la p$$HEX1$$e900$$ENDHEX$$riode de d$$HEX1$$e900$$ENDHEX$$but est incalculable en fonction de la p$$HEX1$$e900$$ENDHEX$$riode de fin
//*-----------------------------------------------------------------

DataWindowChild	dwChild
Date 					dDteFin, dDteDeb
Long					lIdPeriode, lLig
Integer 				iType
Boolean				bOk = True

dDteFin	= Date ( asVal )

/*------------------------------------------------------------------*/
/* En fonction du type de traitement (M)ensuel, (T)rimestriel,      */
/* (S)emestriel, on calcule la date de d$$HEX1$$e900$$ENDHEX$$but de traitement. On      */
/* part du principe que le fichier PERIODE est correctement         */
/* positionn$$HEX1$$e900$$ENDHEX$$. Il faut aussi positionner la valeur de ID_PERIODE.   */
/*------------------------------------------------------------------*/

Choose Case asTypeTrt
	Case "M"
		iType = 0

	Case "T", "D"		// ...."D" Trimestriel d$$HEX1$$e900$$ENDHEX$$cal$$HEX1$$e900$$ENDHEX$$
		iType = 2

	Case "S"
		iType = 5

End Choose


// ... D$$HEX1$$e900$$ENDHEX$$termination de la p$$HEX1$$e900$$ENDHEX$$riode $$HEX2$$e0002000$$ENDHEX$$partir de la ligne actuelle

	idw_Dates.GetChild ( "DTE_FIN", dwChild )
	lLig 			= dwChild.GetRow ()
	lIdPeriode 	= dwChild.GetItemNumber ( lLig, "ID_PERIODE" )


/*------------------------------------------------------------------*/
/* ATTENTION ! : La dropdown doit $$HEX1$$ea00$$ENDHEX$$tre tri$$HEX2$$e9002000$$ENDHEX$$dans un d$$HEX1$$e900$$ENDHEX$$croissant     */
/* ce qui explique le '+' si dessous (et non un '-')					  */
/*------------------------------------------------------------------*/
	lLig = lLig + iType


// ... Sortie imm$$HEX1$$e900$$ENDHEX$$diate si on tombe en dehors de la datawindow

	If lLig > dwChild.RowCount() Then 
		bok = False

		stMessage.sTitre  = "Contr$$HEX1$$f400$$ENDHEX$$le des dates"	
		stMessage.sCode   = "EWK0009"	
		stMessage.icon	   = StopSign!
		f_Message ( stMessage )

	End If

	

// ... Calcul de la date de d$$HEX1$$e900$$ENDHEX$$but

	dDteDeb = dwChild.GetItemDate ( lLig, "DTE_DEB" )

	idw_Dates.SetItem ( 1, "DTE_DEB", dDteDeb )
	idw_Dates.SetItem ( 1, "ID_PERIODE", lIdPeriode )


Return bOk

end function

public subroutine uf_d_l_reg1 ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_d_l_reg1
//* Auteur			: DBI
//* Date				: 13/01/1999 11:21:21
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Traitement particulier pour $$HEX1$$e900$$ENDHEX$$tat D_L_REG1
//* Commentaires	: Permet de supprimer les montants en double de reg_gti
//*
//* Arguments		: 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lCpt

Decimal {2}	dcIdSinLu
Decimal {2}	dcIdSin
Decimal {2}	dcIdRegLu
Decimal {2}	dcIdReg
Decimal {2}	dcIdGtiLu
Decimal {2}	dcIdGti
Decimal {2}	dcIdRgptLu
Decimal {2}	dcIdRgpt

For lCpt = 1 to ilNbLig

	dcIdSinLu	=	idw_Etat.GetItemNumber ( lCpt, "ID_SIN" )
	dcIdRegLu	=	idw_Etat.GetItemNumber ( lCpt, "ID_REG" )
	dcIdGtiLu	=	idw_Etat.GetItemNumber ( lCpt, "ID_GTI" )
	dcIdRgptLu	=	idw_Etat.GetItemNumber ( lCpt, "ID_RGPT" )

	If ( dcIdSinLu		=	dcIdSin	)	And 	&
		( dcIdRegLu		=	dcIdReg	)	And 	&
		( dcIdGtiLu		=	dcIdGti	)	And 	&
		( dcIdRgptLu	=	dcIdRgpt	)	Then

		idw_Etat.SetItem ( lCpt, "MT_REG", 0 )
	Else

		dcIdSin		=	dcIdSinLu	
		dcIdReg		=	dcIdRegLu	
		dcIdGti		=	dcIdGtiLu	
		dcIdRgpt		=	dcIdRgptLu	
	End If
Next



end subroutine

public subroutine uf_lancertrt (ref u_datawindow adwaff, string astyptrt);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_LancerTrt
//* Auteur			: DBI
//* Date				: 22/12/1998 14:36:12
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Lancement du traitement 
//* Commentaires	: 
//*
//* Arguments		: 	u_DataWindow	aDwAff		(Ref)	 DataWindow d'affichage, (peut $$HEX1$$ea00$$ENDHEX$$tre diff$$HEX1$$e900$$ENDHEX$$rent de Dw_1, notamment pour le traitement
//*																	 $$HEX2$$e0002000$$ENDHEX$$la demande.) 
//*						String			asTypTrt		(Val)  Type de traitement ( M:Mensuel, T:Trimestriel... )
//*					  
//* Retourne		: Rien
//*						
//*
//*-----------------------------------------------------------------
//* MAJ 			PAR		Date		Modification
//* #1  			JFF		21/05/99	Ajout d'un COMMIT apr$$HEX1$$e800$$ENDHEX$$s le retrieve de 
//*										chaque $$HEX1$$e900$$ENDHEX$$tat. Le COMMIT se fait juste apr$$HEX1$$e800$$ENDHEX$$s
//*										le End Choose.				  
//* #2			JFF		05/03/01 DEEI1799 : Modification afin que certains $$HEX1$$e900$$ENDHEX$$tat sortent en Euros.
//* #3			PHG		04/02/08 [DCMP080109] Mise en Place d'un code de Sortie pour SMA
//					FPI		05/12/2016	[ITSM430676]
// 	   		JFF      09/03/2023  [RS4721_TRT_EXC8]
//*-----------------------------------------------------------------

Long					lTrt, lTrtAff		// Etat trait$$HEX2$$e9002000$$ENDHEX$$sur Dw_1, Ligne d'affiche sur aDwAff
Long					lPeriodeDeb			// P$$HEX1$$e900$$ENDHEX$$riode de d$$HEX1$$e900$$ENDHEX$$but de traitement
Long					lPeriodeFin			// P$$HEX1$$e900$$ENDHEX$$riode de fin de traitement

DateTime				dtDteDeb				// Date de d$$HEX1$$e900$$ENDHEX$$but de traitement
DateTime				dtDteFin				// Date de fin de traitement

String				sDw					//Nom de la datawindow pour l'$$HEX1$$e900$$ENDHEX$$tat en cours
String				sAltDteDeb			//Sp$$HEX1$$e900$$ENDHEX$$cifie si on doit prendre en compte la date de 
												//d$$HEX1$$e900$$ENDHEX$$but pour le retrieve
String				sAltDteFin			//Sp$$HEX1$$e900$$ENDHEX$$cifie si on doit prendre en compte la date de 
												//fin pour le retrieve
String				sCodTypEtat			//Type d'$$HEX1$$e900$$ENDHEX$$tat $$HEX2$$e0002000$$ENDHEX$$produire
String				sCodEdt				//Format de g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration de l'$$HEX1$$e900$$ENDHEX$$tat
String				sMod					//Variable pour le modify de la datawindow des $$HEX1$$e900$$ENDHEX$$tats
String				sNomFic				//Nom du fichier $$HEX2$$e0002000$$ENDHEX$$g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rer
String 				sNomMachine			//Nom de la machine 
String				sDebTrt				//Heure de d$$HEX1$$e900$$ENDHEX$$but de traitement
String				sFinTrt				//Heure de Fin de traitement
String				sRet					//Retour test describe
String				sLibEtat				//Nom de l'$$HEX1$$e900$$ENDHEX$$tat pour affichage job edition
String				sDocName				//Libell$$HEX2$$e9002000$$ENDHEX$$affich$$HEX2$$e9002000$$ENDHEX$$pour edition
String            sText					//Ligne $$HEX3$$e0002000e900$$ENDHEX$$crire dans le fichier de log
String				sTempo				//Chaine de caract$$HEX1$$e800$$ENDHEX$$res temporaire

UnsignedLong 		ulCptEtat	= 0	//Compteur des etats trait$$HEX1$$e900$$ENDHEX$$s

Int					iNbrExp				//Nombre d'exemplaire $$HEX3$$e0002000e900$$ENDHEX$$diter
Int					i						//Compteur
Long					iIdProd				//Identifiant Produit

Decimal{0}			dcCodArg1			//Valeur du premier argument
Decimal{0}			dcCodArg2			//Valeur du second argument

Boolean				bOk
Boolean				bSuite = True		// True : On pase $$HEX2$$e0002000$$ENDHEX$$la suite.
long					lErrSMA	= 0		// #3 [DCMP080109] Code Erreur de Sortie SMA : 	0 		-> OK
												//															>	10000	-> Erreur
string				sLibErrSMA			// #3 [DCMP080109] Libelle Erreur de Sortie SMA
string				sFileSMA				// #3 [DCMP080109] Nom du Fichier de Sortie SMA
long					lFileSMA				// #3 [DCMP080109] Handle du Fichier de Sortie SMA


//u_DeclarationFuncky uoDeclarationFuncky //[I037] Migration FUNCKy
n_cst_string	lnv_string // [SUISSE].LOT3

// #3 [DCMP080109] Initialisation du Fichier de Sorie SMA
sFileSMA = ProfileString(stglb.sfichierini, "GEST_COMMANDES", "OPCON_OUT", "") + K_FICTRTSMA
FileDelete(sFileSMA)
// #3 [DCMP080109]
//Ceci est la petite ligne de code $$HEX2$$e0002000$$ENDHEX$$ajouter $$HEX2$$e0002000$$ENDHEX$$chaque d$$HEX1$$e900$$ENDHEX$$tection d'erreur :
//		lErrSMA=K_BASEERRSMA + 10; sLibErrSMA = string(lErrSMA)+"/Erreur" // #3 [DCMP080109]


/*----------------------------------------------------------------------------*/
/* #2 : Lorsqu'un nouvel $$HEX1$$e900$$ENDHEX$$tat doit g$$HEX1$$e900$$ENDHEX$$rer l'euro :                             */
/*  - Modifier la requ$$HEX1$$ea00$$ENDHEX$$te SQL                                                 */
/*  - Mettre dans la table Traitement le produit ( COD_ARG1 ) en n$$HEX1$$e900$$ENDHEX$$gatif      */
/*  - Ouvrir la Dw et y posait un St_text indiquant EURO en haut $$HEX2$$e0002000$$ENDHEX$$gauche		*/
/*----------------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On va d'abord v$$HEX1$$e900$$ENDHEX$$rifier les dates de traitement. On va aussi      */
/* armer la date de d$$HEX1$$e900$$ENDHEX$$but de traitement et la periode.              */
/* Modif JFF le 08/03/99 : Seulement si ce n'est pas un trt $$HEX2$$e0002000$$ENDHEX$$la dde*/
/*------------------------------------------------------------------*/
If asTypTrt <> "D" Then
	If Not Uf_VerifierDatesTrt ( asTypTrt ) Then 
		bSuite = False
		lErrSMA=K_BASEERRSMA + 10; sLibErrSMA = string(lErrSMA)+"/DATESNOK" // #3 [DCMP080109]
	End IF
End IF

/*------------------------------------------------------------------*/
/* Lecture de la p$$HEX1$$e900$$ENDHEX$$riode de d$$HEX1$$e900$$ENDHEX$$but de traitement de de la p$$HEX1$$e900$$ENDHEX$$riode    */
/* de fin de traitement                                             */
/*------------------------------------------------------------------*/
If bSuite Then
	If Not Uf_LirePeriode ( lPeriodeDeb, lPeriodeFin, dtDteDeb, dtDteFin ) Then
		bSuite = False
		lErrSMA=K_BASEERRSMA + 20; sLibErrSMA = string(lErrSMA)+"/PERIODESNOK" // #3 [DCMP080109]
	End IF
End IF

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du nom de la machine puis destruction du user       */
/* object                                                           */
/* pour $$HEX1$$e900$$ENDHEX$$criture du fichier de trace                                */
/*------------------------------------------------------------------*/
If bSuite Then
//	uoDeclarationFuncky	= Create u_DeclarationFuncky
//	sNomMachine 			= uoDeclarationFuncky.Uf_GetEnv ( "SQL" )
	sNomMachine 			= stGLB.uoWin.uf_getenvironment( "SQL")
//	Destroy					uoDeclarationFuncky


	/*------------------------------------------------------------------*/
	/* Initialisation du fichier de log											  */
	/* & Informations pour l'ent$$HEX1$$ea00$$ENDHEX$$te du fichier de log                   */
	/*------------------------------------------------------------------*/

	// ... Si le fichier ne s'ouvre pas, on ne lance pas le traitement
	// ... et on referme le fichier de trace ($$HEX2$$e0002000$$ENDHEX$$la fin du script),
   // ... car on a tent$$HEX2$$e9002000$$ENDHEX$$de l'ouvrir.
	bSuite = This.Uf_Log ( 1, "", asTypTrt) and sFileSMA <> "" // #3 [DCMP080109]Il faut que le fichier de Sortie
																				  // SMA ai pu etre initialis$$HEX1$$e900$$ENDHEX$$.
	if not bSuite Then lErrSMA=K_BASEERRSMA + 30; sLibErrSMA = string(lErrSMA)+"/LOG_OU_SMA_NOK" // #3 [DCMP080109]

End IF


If bSuite Then

	This.Uf_Log ( 2, "", asTypTrt)

	sText = "Le " + String ( Datetime( Today(), Now() ), "dd/mm/yyyy hh:mm" ) + &
   	     " Lanc$$HEX2$$e9002000$$ENDHEX$$par Op$$HEX1$$e900$$ENDHEX$$rateur " + stglb.sCodOper + " (Machine " + sNomMachine + ") " + &
      	  "Traitement du " + String ( dtDteDeb,"dd/mm/yyyy" ) + " au " + String ( dtDteFin, "dd/mm/yyyy" )

	This.Uf_Log ( 3, sText, asTypTrt )

	// ... On $$HEX1$$e900$$ENDHEX$$crit de quelle(s) p$$HEX1$$e900$$ENDHEX$$riode(s) il s'agit


	If lPeriodeDeb <> lPeriodeFin Then
		sText = "P$$HEX1$$e900$$ENDHEX$$riode de " + F_Mois_En_Lettre ( Integer ( Right ( String ( lPeriodeDeb ), 2 ) ) ) + " " + Left ( String ( lPeriodeDeb ), 4 ) + &
				  " $$HEX2$$e0002000$$ENDHEX$$" + F_Mois_En_Lettre ( Integer ( Right ( String ( lPeriodeFin ), 2 ) ) ) + " " + Left ( String ( lPeriodeFin ), 4 ) 
	Else 
		sText = "P$$HEX1$$e900$$ENDHEX$$riode de " + F_Mois_En_Lettre ( Integer ( Right ( String ( lPeriodeDeb ), 2 ) ) ) + " " + Left ( String ( lPeriodeDeb ), 4 )

	End If

	sText += ", lanc$$HEX2$$e9002000$$ENDHEX$$sur le serveur " + ItrTrans.ServerName + ", base " + ItrTrans.DataBase

	This.Uf_Log ( 3, sText, asTypTrt )
	This.Uf_Log ( 2, "", asTypTrt)


	/*------------------------------------------------------------------*/
	/* Initialiation objet d$$HEX1$$e900$$ENDHEX$$filement                                   */
	/*------------------------------------------------------------------*/
	Uf_InitDefil ()

	/*------------------------------------------------------------------*/
	/* D$$HEX1$$e900$$ENDHEX$$marrage du traitement                                          */
	/*------------------------------------------------------------------*/
	/*------------------------------------------------------------------*/
	/* Recherche du prochain $$HEX1$$e900$$ENDHEX$$tat $$HEX2$$e0002000$$ENDHEX$$traiter                             */
	/*------------------------------------------------------------------*/
	lTrt = iDw_1.GetSelectedRow ( lTrt )
	If lTrt > 0 Then 

		iDw_1.SetRow ( lTrt )
		iDw_1.ScrollToRow ( lTrt )
	Else
		bSuite = False
		lErrSMA=K_BASEERRSMA + 40; sLibErrSMA = string(lErrSMA)+"/STATNOSELECT" // #3 [DCMP080109]
	End If

End IF

/*------------------------------------------------------------------*/
/* Modif JFF le 08/03/99 (d$$HEX2$$fb002000$$ENDHEX$$au traitement sur demande)				  */
/* Recherche de la premi$$HEX1$$e800$$ENDHEX$$re ligne s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e sur aDwAff			  */
/*------------------------------------------------------------------*/
If bSuite Then
	lTrtAff = aDwAff.GetSelectedRow ( lTrtAff )
	If lTrtAff < 1 Then 
		bSuite = False
		lErrSMA=K_BASEERRSMA + 40; sLibErrSMA = string(lErrSMA)+"/STATNOSELECT" // #3 [DCMP080109]
	End If
End IF

/*------------------------------------------------------------------*/
/* Lancement des $$HEX1$$e900$$ENDHEX$$tats.                                             */
/*------------------------------------------------------------------*/
If bSuite Then
	Do

		// [ITSM430676]
		ilNbLig=0
		
		ulCptEtat	= ulCptEtat + 1
		sDebTrt		= String ( Now(), "hh:mm" )
		aDwAff.SetItem	 ( lTrtAff, "MAJ_PAR", "En Cours...D$$HEX1$$e900$$ENDHEX$$but : " + sDebTrt )		

		For i = 1 To 2
			Yield ()
		Next

		/*----------------------------------------------------------------------------*/
		/* Lecture des informations de l'$$HEX1$$e900$$ENDHEX$$tat $$HEX2$$e0002000$$ENDHEX$$produire.                             */
		/*----------------------------------------------------------------------------*/
		
		iIdProd			= iDw_1.GetItemNumber 	( lTrt, "ID_PROD" 		)
		ilNumEtat		= iDw_1.GetItemNumber 	( lTrt, "ID_ETAT" 		)
		sDw				= iDw_1.GetItemString 	( lTrt, "COD_DW" 			)
		sAltDteDeb		= iDw_1.GetItemString 	( lTrt, "ALT_DTE_DEB"	)
		sAltDteFin		= iDw_1.GetItemString 	( lTrt, "ALT_DTE_FIN"	)
		sCodTypEtat		= iDw_1.GetItemString 	( lTrt, "COD_TYP_ETAT" 	)
		dcCodArg1		= iDw_1.GetItemNumber	( lTrt, "COD_ARG1" 		)
		dcCodArg2		= iDw_1.GetItemNumber	( lTrt, "COD_ARG2" 		)
		sCodEdt			= iDw_1.GetItemString	( lTrt, "COD_EDT" 		)
		iNbrExp			= iDw_1.GetItemNumber 	( lTrt, "NB_EXP"			)
		sNomFic			= iDw_1.GetItemString	( lTrt, "NOM_FIC"			)
		sLibEtat			= iDw_1.GetItemString	( lTrt, "LIB_ETAT"		)

/*------------------------------------------------------------------*/
/* Renseignement pour le log													  */
/*------------------------------------------------------------------*/
/* MODIF JFF le 26/01/1999 : Je teste TOUTES les variables que je   */
/* concat$$HEX1$$e800$$ENDHEX$$ne afin qu'elles ne soient pas $$HEX2$$e0002000$$ENDHEX$$NULL, m$$HEX1$$ea00$$ENDHEX$$me si certaines  */
/* ne le seront jamais, comme sDw par exemple, je pr$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e800$$ENDHEX$$re g$$HEX1$$e900$$ENDHEX$$rer     */
/* tous les cas afin que nous n'ayant aucun doute par la suite.	  */	
/*------------------------------------------------------------------*/
		sText = ""

		If IsNull ( iIdProd ) Then
			sText += "(null)"							+ "~t"
		Else
			sText += String ( iIdProd )			+ "~t"
		End If

		If IsNull ( ilNumEtat ) Then
			sText += "(null)"							+ "~t"
		Else
			sText += String ( ilNumEtat )			+ "~t"
		End If

		If IsNull ( sDw ) Then
			sText += "(null)"							+ "~t"
		Else
			sText += sDw								+ "~t"
		End If

		If IsNull ( dcCodArg1 ) Then
			sText += "(null)"							+ "~t"
		Else
			sText += String ( dcCodArg1 )			+ "~t"
		End If

		If IsNull ( dcCodArg2 ) Then
			sText += "(null)"							+ "~t"
		Else
			sText += String ( dcCodArg2 )			+ "~t"
		End If

		If IsNull ( sCodEdt ) Then
			sText += "(null)"							+ "~t"
		Else
			sText += sCodEdt							+ "~t"
		End If

		If IsNull ( iNbrExp ) Then
			sText += "(null)"							+ "~t"
		Else
			sText += String ( iNbrExp )			+ "~t"
		End If			

		If IsNull ( sLibEtat ) Then
			sText += "(null)"							+ "~t"
		Else
			sText += sLibEtat							+ "~t"
		End If

		If IsNull ( sNomFic ) Then
			sText += "(null)"							+ "~t"
		Else
			sText += sNomFic							+ "~t"
		End If

			
/*------------------------------------------------------------------*/
/* Pr$$HEX1$$e900$$ENDHEX$$paration de la datawindow pour le traitement de l'$$HEX1$$e900$$ENDHEX$$tat.       */
/*------------------------------------------------------------------*/
		iDw_Etat.dataObject = sDw
		iDw_Etat.SetTransObject ( itrTrans )
		iDw_Etat.Reset ()

/*------------------------------------------------------------------*/
/* Armement des champs texte unite et cod_dw s'ils existent         */
/*------------------------------------------------------------------*/

		sRet				= iDw_Etat.Describe ( "unite.visible" )

		If ( sRet <> "!" ) Then

			Choose Case stGlb.sMonnaieFormatDesire

				// La base est en francs fran$$HEX1$$e700$$ENDHEX$$ais
				// On garde la possibilit$$HEX2$$e9002000$$ENDHEX$$de sortir des $$HEX1$$e900$$ENDHEX$$tats Francs / Euros
				Case "F"

					/*------------------------------------------------------------------*/
					/* #2	: si le code produit est positif, les montants seront exprim$$HEX1$$e900$$ENDHEX$$s*/
					/* en FRF, sinon si prod n$$HEX1$$e900$$ENDHEX$$gatif alors montants en Euros.			  */
					/*------------------------------------------------------------------*/
					If dcCodArg1 >= 0 Then 
						idw_Etat.Modify ( "unite.text='Les montants sont exprim$$HEX1$$e900$$ENDHEX$$s en Francs Fran$$HEX1$$e700$$ENDHEX$$ais'" )
					Else
						idw_Etat.Modify ( "unite.text='Les montants sont exprim$$HEX1$$e900$$ENDHEX$$s en $$HEX1$$ac20$$ENDHEX$$UROS'" )
					End If

				// La base est en Euros
				// on ne sort que des $$HEX1$$e900$$ENDHEX$$tats en Euros
				Case "EURO" // [SUISSE].LOT3 Remplacement de "E" en "EURO"
					
					dcCodArg1 = Abs ( dcCodArg1 )
					idw_Etat.Modify ( "unite.text='Les montants sont exprim$$HEX1$$e900$$ENDHEX$$s en $$HEX1$$ac20$$ENDHEX$$UROS'" )
		
				// Monnaie non reconnue
				// [SUISSE].LOT3 On g$$HEX1$$e800$$ENDHEX$$re le cas : Monnaie non d$$HEX1$$e900$$ENDHEX$$finie
				//					  Sinon, on fais une phrase avec le Symbole Mon$$HEX1$$e900$$ENDHEX$$taire
				Case Else
					if lnv_string.of_isEmpty( stGlb.sMonnaieFormatDesire) Then
						This.Uf_Log ( 3, "ERREUR ! - Pas de monnaie dans le fichier INI", asTypTrt )
						sCodTypEtat = "ERR"
						lErrSMA=K_BASEERRSMA + 50; sLibErrSMA = string(lErrSMA)+"/MONNAIENOK" // #3 [DCMP080109]
					Else
						dcCodArg1 = Abs ( dcCodArg1 )
						idw_Etat.Modify ( "unite.text='Les montants sont exprim$$HEX1$$e900$$ENDHEX$$s en "+ stGlb.sMonnaieLitteralDesire +"'" )
					End If

			End Choose
		End If

		sRet				= iDw_Etat.Describe ( "cod_dw.visible" )

		If ( sRet <> "!" ) Then

			idw_Etat.Modify ( "cod_dw.text='" + sDw + "'" )
		End If

/*------------------------------------------------------------------*/
/* Chargement id_prod + nom etat pour job edition                   */
/*------------------------------------------------------------------*/

		If Not isNull ( dcCodArg1 ) Then

			sDocName = String ( dcCodArg1 ) + "-" + sLibEtat
		Else

			sDocName = sLibEtat
		End If

		idw_Etat.Modify ( "DataWindow.Print.DocumentName = '" + sDocName + "'" )

/*------------------------------------------------------------------*/
/* Traitement selon le type d'$$HEX1$$e900$$ENDHEX$$tat $$HEX2$$e0002000$$ENDHEX$$produire                       */
/*------------------------------------------------------------------*/
		Choose Case sCodTypEtat

		Case "R"		// Retrieve avec Argument

			/*------------------------------------------------------------------*/
			/* Traitement des combinaisons d'arguments possibles                */
			/* Si la date de d$$HEX1$$e900$$ENDHEX$$but est $$HEX2$$e0002000$$ENDHEX$$utiliser la date de fin est obligatoire*/
			/*------------------------------------------------------------------*/

			/*------------------------------------------------------------------*/
			/* Date de d$$HEX1$$e900$$ENDHEX$$but + date fin + arg1 + Arg2                           */
			/*------------------------------------------------------------------*/
			If ( sAltDteDeb <> "N" ) And ( Not isNull( dcCodArg1 ) ) And ( Not isNull( dcCodArg2 ) ) Then 

					If ( sAltDteDeb = "P" ) Then

						ilNbLig = iDw_Etat.Retrieve( dtDteDeb, dtDteFin, lPeriodeDeb, lPeriodeFin, dcCodArg1, dcCodArg2 )	
					Else

						ilNbLig = iDw_Etat.Retrieve( dtDteDeb, dtDteFin, dcCodArg1, dcCodArg2 )	
					End If						
			End If

			/*------------------------------------------------------------------*/
			/* Date de d$$HEX1$$e900$$ENDHEX$$but + date fin + arg1                                  */
			/*------------------------------------------------------------------*/
			If ( sAltDteDeb <> "N" ) And ( Not isNull( dcCodArg1 ) ) And ( isNull( dcCodArg2 ) ) Then 

					If ( sAltDteDeb = "P" ) Then

						ilNbLig = iDw_Etat.Retrieve( dtDteDeb, dtDteFin, lPeriodeDeb, lPeriodeFin, dcCodArg1 )	
					Else

						ilNbLig = iDw_Etat.Retrieve( dtDteDeb, dtDteFin, dcCodArg1 )	
					End If
			End If

			/*------------------------------------------------------------------*/
			/* Date de d$$HEX1$$e900$$ENDHEX$$but + date fin                                         */
			/*------------------------------------------------------------------*/
			If ( sAltDteDeb <> "N" ) And ( isNull( dcCodArg1 ) ) And ( isNull( dcCodArg2 ) ) Then 

					If ( sAltDteDeb = "P" ) Then

						ilNbLig = iDw_Etat.Retrieve( dtDteDeb, dtDteFin, lPeriodeDeb, lPeriodeFin )	
					Else

						ilNbLig = iDw_Etat.Retrieve( dtDteDeb, dtDteFin )	
					End If
			End If

			/*------------------------------------------------------------------*/
			/* date fin + arg1 + Arg2                           					  */
			/*------------------------------------------------------------------*/
			If ( sAltDteDeb = "N" ) And ( sAltDteFin <> "N" ) And ( Not isNull( dcCodArg1 ) ) And ( Not isNull( dcCodArg2 ) ) Then 
		
					If ( sAltDteFin = "P" ) Then

						ilNbLig = iDw_Etat.Retrieve( dtDteFin, lPeriodeFin, dcCodArg1, dcCodArg2 )	
					Else

						ilNbLig = iDw_Etat.Retrieve( dtDteFin, dcCodArg1, dcCodArg2 )	
					End If						
			End If	
	
			/*------------------------------------------------------------------*/
			/* date fin + arg1																  */
			/*------------------------------------------------------------------*/
			If ( sAltDteDeb = "N" ) And ( sAltDteFin <> "N" ) And ( Not isNull( dcCodArg1 ) ) And ( isNull( dcCodArg2 ) ) Then 
		
				If ( sAltDteFin = "P" ) Then

					ilNbLig = iDw_Etat.Retrieve( dtDteFin, lPeriodeFin, dcCodArg1 )	
				Else

					ilNbLig = iDw_Etat.Retrieve( dtDteFin, dcCodArg1 )	
				End If						
			End If	

			/*------------------------------------------------------------------*/
			/* date fin 				                           					  */
			/*------------------------------------------------------------------*/
			If ( sAltDteDeb = "N" ) And ( sAltDteFin <> "N" ) And ( isNull( dcCodArg1 ) ) And ( isNull( dcCodArg2 ) ) Then 
		
				If ( sAltDteFin = "P" ) Then

					ilNbLig = iDw_Etat.Retrieve( dtDteFin, lPeriodeFin )	
				Else

					ilNbLig = iDw_Etat.Retrieve( dtDteFin )	
				End If						
			End If	

			/*------------------------------------------------------------------*/
			/* arg1 + Arg2                                                      */
			/*------------------------------------------------------------------*/

			If ( sAltDteDeb = "N" ) And ( sAltDteFin = "N" ) And ( Not isNull( dcCodArg1 ) ) And ( Not isNull( dcCodArg2 ) ) Then 
		
				ilNbLig = iDw_Etat.Retrieve( dcCodArg1, dcCodArg2 )				
			End If

			/*------------------------------------------------------------------*/
			/* arg1			                                                     */
			/*------------------------------------------------------------------*/

			If ( sAltDteDeb = "N" ) And ( sAltDteFin = "N" ) And ( Not isNull( dcCodArg1 ) ) And ( isNull( dcCodArg2 ) ) Then 
		
				ilNbLig = iDw_Etat.Retrieve( dcCodArg1 )						
			End If
		

		Case "S"

			ilNbLig = iDw_Etat.Retrieve()

		Case "X"

/*------------------------------------------------------------------*/
/* On ne fait pas de retrieve                                       */
/*------------------------------------------------------------------*/

		Case "ERR"
			// ERREUR

		End Choose

		/*------------------------------------------------------------------*/
		/* #1 IMPORTANT ! : Il faut "commiter" apr$$HEX1$$e800$$ENDHEX$$s le Retrieve, car les   */
		/* requ$$HEX1$$ea00$$ENDHEX$$tes peuvent contenir des Insert dans une table temporaire.  */
		/*------------------------------------------------------------------*/
		F_Commit ( iTrTrans, True )

/*------------------------------------------------------------------*/
/* D$$HEX1$$e900$$ENDHEX$$clenche l'$$HEX1$$e900$$ENDHEX$$vt ue_Personnaliser de la fen$$HEX1$$ea00$$ENDHEX$$tre du traitement     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* MODIF JFF Le 15/03/99 : On ne d$$HEX1$$e900$$ENDHEX$$clenche plus un $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement sur    */
/* Dw_Etat, mais une fonction sur l'objet de traitement             */
/* (uf_personnaliser)                                               */
/*------------------------------------------------------------------*/
		This.Uf_Personnaliser()

		If	ilNbLig > 0 Then

/*------------------------------------------------------------------*/
/* Tri et r$$HEX1$$e900$$ENDHEX$$organisation de l'$$HEX1$$e900$$ENDHEX$$tat suite au retrieve.               */
/*------------------------------------------------------------------*/
			iDw_Etat.Sort ()
			iDw_Etat.GroupCalc ()

  /*------------------------------------------------------------------*/
  /* Lancement de l'$$HEX1$$e900$$ENDHEX$$dition de l'$$HEX1$$e900$$ENDHEX$$tat trait$$HEX1$$e900$$ENDHEX$$.                         */
  /*------------------------------------------------------------------*/
			If sCodTypEtat <> "ERR" Then 
				FileDelete(sNomFic) // #3 [DCMP080109] Suppression de l'ancien fichier avant cr$$HEX1$$e900$$ENDHEX$$ation.
				bOk = uf_EditionEtat	( aDwAff, sCodEdt, iNbrExp, sNomFic, lTrtAff )
			Else	
				bOk = False
			End If
			sFinTrt		= String ( Now(), "hh:mm" )


			If ( Not bOk ) Then
				
				If sCodTypEtat = "ERR" Then 
					aDwAff.SetItem	 ( lTrtAff, "MAJ_PAR", "!!Erreur - Pas de monnaie - Fin: " +sFinTrt )
				Else
					aDwAff.SetItem	 ( lTrtAff, "MAJ_PAR", "!!Erreur - D$$HEX1$$e900$$ENDHEX$$b: " + sDebTrt + " - Fin: " +sFinTrt )
					lErrSMA=K_BASEERRSMA + 60; sLibErrSMA = string(lErrSMA)+"/ERREURSTAT" // #3 [DCMP080109]

				End If
			Else

				aDwAff.SetItem	 ( lTrtAff, "MAJ_PAR", "Termin$$HEX2$$e9002000$$ENDHEX$$- D$$HEX1$$e900$$ENDHEX$$b: " + sDebTrt + " - Fin: " +sFinTrt )
			End If
			
		Else
		
			sFinTrt		= String ( Now(), "hh:mm" )

			If sCodTypEtat = "ERR" Then 
					aDwAff.SetItem	 ( lTrtAff, "MAJ_PAR", "!!Erreur - Pas de monnaie - Fin: " +sFinTrt )
			Else

				If ilNbLig < 0 Then		// Erreur sur chargement Dw

					aDwAff.SetItem	 ( lTrtAff, "MAJ_PAR", "!!Erreur - D$$HEX1$$e900$$ENDHEX$$b: " + sDebTrt + " - Fin: " +sFinTrt )
					bOk	=	False
					lErrSMA=K_BASEERRSMA + 60; sLibErrSMA = string(lErrSMA)+"/ERREURSTAT" // #3 [DCMP080109]
				Else							// Pas de ligne sur Dw
		
					aDwAff.SetItem	 ( lTrtAff, "MAJ_PAR", "Aucun - D$$HEX1$$e900$$ENDHEX$$b: " + sDebTrt + " - Fin: " +sFinTrt )
					bOk	=	True
				End If
			End If
		End If
  /*------------------------------------------------------------------*/
  /* Renseignement du fichier de log											 */
  /*------------------------------------------------------------------*/
	sTempo = aDwAff.GetItemString( lTrtAff, "MAJ_PAR" )

	If IsNull ( sTempo ) Then
		sText += "(null)"							+ "~t"
	Else
		sText += sTempo							+ "~t"
	End If

	This.Uf_Log ( 3, sText, asTypTrt )

	/*------------------------------------------------------------------*/
	/* Arr$$HEX1$$ea00$$ENDHEX$$t du traitement si erreur                                    */
	/*------------------------------------------------------------------*/

	If ( Not bOk ) Then Exit

	/*----------------------------------------------------------------------------*/
	/* Mise $$HEX2$$e0002000$$ENDHEX$$jour de la variable d'instance du nombre d'$$HEX1$$e900$$ENDHEX$$tats trait$$HEX1$$e900$$ENDHEX$$s            */
	/*----------------------------------------------------------------------------*/
	iUoDefil.Uf_Progression ( ulCptEtat )

	/*----------------------------------------------------------------------------*/
	/* D$$HEX1$$e900$$ENDHEX$$s$$HEX1$$e900$$ENDHEX$$lection de l'$$HEX1$$e900$$ENDHEX$$tat trait$$HEX48$$e90020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
	/*----------------------------------------------------------------------------*/
	aDwAff.SelectRow ( lTrtAff, False )

	/*----------------------------------------------------------------------------*/
	/* Recherche du prochain $$HEX1$$e900$$ENDHEX$$tat $$HEX2$$e0002000$$ENDHEX$$traiter.                                      */
	/*----------------------------------------------------------------------------*/
	//... Pour l'affichage
	lTrtAff = aDwAff.GetSelectedRow ( lTrtAff )

	lTrt 	  = iDw_1.GetSelectedRow   ( lTrt )
	If lTrt > 0 Then 
		iDw_1.SetRow ( lTrt )
		iDw_1.ScrollToRow ( lTrt )
	End If


	Loop While lTrt > 0  

End IF

/*------------------------------------------------------------------*/
/* Fermeture du log quoi qu'il arrive										  */
/*------------------------------------------------------------------*/
This.Uf_Log ( 4, "", asTypTrt )

// #3 [DCMP080109] Ecriture du Fichier de Sortie pour SMA
If lErrSMA = 0 Then
	sLibErrSMA = "0|OK"
Else
	sLibErrSMA = string(lErrSMA)+"|"+sLibErrSMA
End if

lFileSMA = FileOpen(sFileSMA, LineMode!, Write!, LockWrite!, Replace! )

if lFileSMA > 0 then 
	FileWrite (lFileSMA, sLibErrSMA)
	FileClose(lFileSMA)
End If
//


end subroutine

private function boolean uf_editionetat (ref u_datawindow adwaff, string ascodedt, integer ainbexp, string asnomfic, long alligtrt);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_EditionEtat
//* Auteur			:	DBI
//* Date				:	28/12/1998 16:52:17
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration de l'$$HEX1$$e900$$ENDHEX$$tat selectionn$$HEX2$$e9002000$$ENDHEX$$au format d$$HEX1$$e900$$ENDHEX$$sir$$HEX1$$e900$$ENDHEX$$
//*
//* Commentaires	:	
//*
//* Arguments		:	u_DataWindow	aDwAff		(Ref)	 DataWindow d'affichage, (peut $$HEX1$$ea00$$ENDHEX$$tre diff$$HEX1$$e900$$ENDHEX$$rent de Dw_1, notamment pour le traitement
//*																	 $$HEX2$$e0002000$$ENDHEX$$la demande.) 
//*						String			asCodEdt		( Val )	Format d$$HEX1$$e900$$ENDHEX$$sir$$HEX1$$e900$$ENDHEX$$
//*						Integer			aiNbExp		( Val )	Nombre d'exemplaire ( utilis$$HEX2$$e9002000$$ENDHEX$$pour etats papier )	
//*						String			asNomFic		( Val )	Nom du fichier $$HEX2$$e0002000$$ENDHEX$$g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rer ( Utilis$$HEX2$$e9002000$$ENDHEX$$pour g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration de fichiers Excel )
//*						Long     		alLigTrt		( Val )  Ligne de l'$$HEX1$$e900$$ENDHEX$$tat en cours de traitement
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF	  21/01/2010  [O2M_DIAG_NOMADE].Lot2.JFF
//*				  24/03/2011  [PM02].[TRT_MENS_EXTR]
//			FPI	07/12/2011	[FPI.20111207] Cr$$HEX1$$e900$$ENDHEX$$ation automatique des r$$HEX1$$e900$$ENDHEX$$pertoires
//			FPI	06/09/2012	[PM72-4]
//			FPI		10/10/2013	[VDoc11966]
//			FPI		26/12/2014	[ETAT_XLSX]
// 	   JFF      09/03/2023  [RS4721_TRT_EXC8]
//*-----------------------------------------------------------------
Boolean	bRet 			= True	//Valeur de retour
Int		iCpt						//Compteur pour le nombre d'exemplaires
Int		iRet						//Valeur de retour de la g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration du fichier
String	sAvancement				//Point de l'avancement de l'$$HEX1$$e900$$ENDHEX$$dition

// 	[ETAT_XLSX]
If Right(idw_1.isselect,1)="." Then // Etat sur demande, on v$$HEX1$$e900$$ENDHEX$$rifie que le fichier sortira
	if (ascodedt="2" or ascodedt="4") &
		and idw_etat.RowCount() > 65000 and Upper(Right(asNomFic,3)) = "XLS" Then
			asNomFic+="X"
			MessageBox("Information", "Le nombre de lignes d$$HEX1$$e900$$ENDHEX$$passe 65000. ~nLe fichier sera enregistr$$HEX2$$e9002000$$ENDHEX$$sous " + asNomfic)
	End if

End if

Choose Case asCodEdt

	/*----------------------------------------------------------------------------*/
	/* G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration de l'$$HEX1$$e900$$ENDHEX$$tat statistique sur papier                                */
	/*----------------------------------------------------------------------------*/
	Case "1" 

		For iCpt = 1 To aiNbExp
			sAvancement = "Edition " + String ( iCpt ) + "/" + String ( aiNbExp ) + "..."
			aDwAff.SetItem 	( alLigTrt	, "MAJ_PAR", sAvancement  	)
			If iDw_Etat.Print( False ) <> 1 Then 
				bRet = False
				Exit
			End If
		Next
		aDwAff.SetItem	( alLigTrt, "MAJ_PAR", "Termin$$HEX1$$e900$$ENDHEX$$."  )
	

	/*----------------------------------------------------------------------------*/
	/* G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration de l'$$HEX1$$e900$$ENDHEX$$tat statistique sous forme de fichier Excel               */
	/*----------------------------------------------------------------------------*/
	Case "2" 

		aDwAff.SetItem 	( alLigTrt	, "MAJ_PAR", "G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration du fichier..." )
// #1 [O2M_DIAG_NOMADE].Lot2.JFF	
//		iRet = iDw_Etat.SaveAs ( asNomFic, EXCEL!, TRUE ) 

		Choose Case ilNumEtat
			Case 84
				iRet = Uf_d_l_relance_btq_broker ( asNomFic )
				
			Case 97
				iRet = Uf_d_l_stat_frais_presta_2 ( asNomFic )
				
/*
			Case 86, 87, 88 // [PM02].[TRT_MENS_EXTR]
				iRet = Uf_d_l_pm02_fic_xxxx ( asNomFic )
*/
			Case 99 // [PM72-4]
				uf_creerdossier( asNomFic) 
				iRet=uf_d_l_reg_frais_presta_volcane( asNomFic)
				
			Case Else
				uf_creerdossier( asNomFic) // [FPI.20111207]
				asNomFic=uf_format_nomfic(asNomFic) //	[VDoc11966]
				
				If Right(Upper(asNomFic), 4) = "XLSX" Then // [ETAT_XLSX]
					iRet = iDw_Etat.SaveAs ( asNomFic, XLSX!, TRUE ) 
				Else
					// [RS4721_TRT_EXC8]
					iRet = iDw_Etat.SaveAs ( asNomFic, EXCEL8!, TRUE ) 
				End if
		End Choose

// #1 [O2M_DIAG_NOMADE].Lot2.JFF	

		/*----------------------------------------------------------------------------*/
		/* V$$HEX1$$e900$$ENDHEX$$rification du r$$HEX1$$e900$$ENDHEX$$sultat.                                                  */
		/*----------------------------------------------------------------------------*/
		If iRet = 1 Then 

			aDwAff.SetItem 	( alLigTrt, "MAJ_PAR", asNomFic	)
		Else 

			bRet = False
		End If

	/*----------------------------------------------------------------------------*/
	/* G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration de l'$$HEX1$$e900$$ENDHEX$$tat statistique sous forme de fichier Excel + papier      */
	/*----------------------------------------------------------------------------*/
	Case "4" 

		For iCpt = 1 To aiNbExp
			sAvancement = "Edition " + String ( iCpt ) + "/" + String ( aiNbExp ) + "..."
			aDwAff.SetItem 	( alLigTrt	, "MAJ_PAR", sAvancement  	)
			If iDw_Etat.Print( False ) <> 1 Then 
				bRet = False
				Exit
			End If
		Next

		aDwAff.SetItem 	( alLigTrt	, "MAJ_PAR", "G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration du fichier..." )
		uf_creerdossier( asNomFic) //[FPI.20111207]
		
		If Right(Upper(asNomFic), 4) = "XLSX" Then // [ETAT_XLSX]
			iRet = iDw_Etat.SaveAs ( asNomFic, XLSX!, TRUE ) 
		Else
			// [RS4721_TRT_EXC8]
			iRet = iDw_Etat.SaveAs ( asNomFic, EXCEL8!, TRUE ) 
		End if

		/*----------------------------------------------------------------------------*/
		/* V$$HEX1$$e900$$ENDHEX$$rification du r$$HEX1$$e900$$ENDHEX$$sultat.                                                  */
		/*----------------------------------------------------------------------------*/
		If iRet = 1 Then 

			aDwAff.SetItem 	( alLigTrt, "MAJ_PAR", asNomFic	)
		Else 

			bRet = False
		End If
		
	Case "5" // [VDoc17201]
		uf_creerdossier( asNomFic) 
		asNomFic=uf_format_nomfic(asNomFic)
				
		iRet = uf_saveas_csv_point_virugule( asNomFic) 
				
End Choose

Return ( bRet )
end function

public subroutine uf_personnaliser ();//*-----------------------------------------------------------------
//*
//* Fonction 		: uf_Personnaliser
//* Auteur			: DBI
//* Date				: 28/12/1998 16:33:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Personnalisation des $$HEX1$$e900$$ENDHEX$$tats Stats
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* JFF        15/03/99	Je d$$HEX1$$e900$$ENDHEX$$place cet $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement de la Dw_Etat, en une fonction
//*							que je positionne sur l'objet de traitement. 
//			FPI	19/08/2013	[PC932]
//			JFF   23/04/2024  [MCO389] ajout 139
//*-----------------------------------------------------------------

Date dtDteDeb		// Date d$$HEX1$$e900$$ENDHEX$$but Trt
Date dtDteFin		// Date d$$HEX1$$e900$$ENDHEX$$but Fin

Choose Case This.ilNumEtat

Case 2		// Fichier Volcane
	
	dtDteDeb = iDw_Dates.GetItemDate ( 1, "DTE_DEB" )
	dtDteFin = iDw_Dates.GetItemDate ( 1, "DTE_FIN" )

	This.ilNbLig	= idw_Volcane.Uf_Volcane ( stGLB, itrTrans, dtDteDeb, dtDteFin )

Case 9, 11, 51, 52, 57, 59, 139 // Etat d$$HEX1$$e900$$ENDHEX$$riv$$HEX1$$e900$$ENDHEX$$s d_l_reg1, d_l_reg2	: Liste des dossiers r$$HEX1$$e900$$ENDHEX$$gl$$HEX1$$e900$$ENDHEX$$s

	This.Uf_d_l_Reg1 ( )	

Case 66							//Etat relative au GAN DCMP 050537

	This.Uf_d_l_Reg13 ( )	
	
Case 103
	This.uf_d_l_reg_rassureo()

End Choose


end subroutine

public subroutine uf_initialiser (ref u_datawindow_detail adw_1, ref datawindow adw_dates, ref u_volcane adw_volcane, ref datawindow adw_dept, ref u_barredefil auodefil, ref datawindow adwetat, ref u_transaction atrtrans);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Sp_Gs_Trai_Anc::Uf_Initialiser (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/11/1998 15:56:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: U_DataWindow_Detail	adw_1					(R$$HEX1$$e900$$ENDHEX$$f)	
//*					  DataWindow				adw_Dates			(R$$HEX1$$e900$$ENDHEX$$f)
//*					  u_Volcane					adw_Volcane			(R$$HEX1$$e900$$ENDHEX$$f)
//*					  DataWindow				adw_Dept				(R$$HEX1$$e900$$ENDHEX$$f)
//*					  U_BarreDefif				auoDefil				(R$$HEX1$$e900$$ENDHEX$$f)
//*					  Datawindow				adwEtat				(R$$HEX1$$e900$$ENDHEX$$f)
//*					  U_Transaction			atrTrans				(R$$HEX1$$e900$$ENDHEX$$f)
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

idw_1			= adw_1
idw_Dates	= adw_Dates
idw_Volcane = adw_volcane
idw_Dept		= adw_Dept
iuoDefil		= auoDefil
idw_Etat		= adwEtat
itrTrans		= atrTrans


end subroutine

public subroutine uf_d_l_reg13 ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_d_l_reg13
//* Auteur			: MADM
//* Date				: 27/12/2005 17:45:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Traitement particulier pour $$HEX1$$e900$$ENDHEX$$tat D_L_REG13
//* Commentaires	: Permet pour un m$$HEX1$$ea00$$ENDHEX$$me sinistre et la m$$HEX1$$ea00$$ENDHEX$$me garantie ouverte de ne renseigner qu'une seule fois 
//*					: les colonnes suivantes MONTANT_DECLARE , VALEUR_ACHAT_ORIGINE , VALEUR_PUBLIQUE_ARGUS	
//*
//* Arguments		: 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------



Long lCpt

Long			lIdSinLu , lIdSin
String		sGarantilu , sLibGti	

For lCpt = 1 to ilNbLig

	lIdSinLu	  =  idw_Etat.GetItemNumber ( lCpt, "REF_SINISTRE" )
	sGarantilu =  idw_Etat.GetItemString ( lCpt, "GARANTIE_OUVERTE" )

	
	If ( lIdSinLu			=	lIdSin	)	And 	&
		( sGarantilu		=	sLibGti	)	Then
		
		idw_Etat.SetItem ( lCpt, "MONTANT_DECLARE", 0 )
		idw_Etat.SetItem ( lCpt, "VALEUR_ACHAT_ORIGINE", 0 )
		idw_Etat.SetItem ( lCpt, "VALEUR_PUBLIQUE_ARGUS", 0 )
		
	Else
		
		lIdSin		=	lIdSinLu 
		sLibGti		=	sGarantilu 
			
	End If

Next



end subroutine

private function integer uf_d_l_relance_btq_broker (string asnomfic);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_d_l_relance_btq_broker (PRIVATE)
//* Auteur			: JFF
//* Date				: 21/01/2010
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Traitement particulier pour $$HEX1$$e900$$ENDHEX$$tat d_l_relance_btq_broker
//* Commentaires	: Plusieurs fichiers vont se g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rer 
//*
//* Arguments		: Value	String	asNomFic
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF	  21/01/2010  [O2M_DIAG_NOMADE].Lot2.JFF	
//			FPI	07/12/2011	[FPI.20111207] Cr$$HEX1$$e900$$ENDHEX$$ation automatique des r$$HEX1$$e900$$ENDHEX$$pertoires
// 	   JFF      09/03/2023  [RS4721_TRT_EXC8]
//*-----------------------------------------------------------------

Long lLigne
String sSavAdrMail, sAdrMail, sNomFicTrv, sVal
Int iRet, iPos

sSavAdrMail = ""
idw_Etat.SetFilter ( "" )
idw_Etat.Filter ( )
idw_Etat.Sort ()

lLigne = 1
iRet = 1

sVal = Reverse ( asNomFic )
iPos = Pos ( sVal, '\', 1 )
sVal = Left ( asNomFic, Len ( asNomFic ) - iPos )
iRet = f_initdirectory ( sVal )


DO UNTIL lLigne > ilNbLig

	sAdrMail = Trim ( idw_Etat.GetItemString ( lLigne, "MAIL_BOUTIQUE" ) )
	If IsNull ( sAdrMail ) Or sAdrMail = "" Or sAdrMail = sSavAdrMail Then 
		lLigne ++
		Continue
	End If
		
	sSavAdrMail = sAdrMail 
	
	idw_Etat.SetFilter ( "MAIL_BOUTIQUE = '" + sAdrMail + "'" )
	idw_Etat.Filter ( )
	idw_Etat.Sort ()

	sNomFicTrv = F_Remplace ( asNomFic, "[EMAIL_BTQ]", sAdrMail )

	uf_creerdossier( sNomFicTrv ) //	[FPI.20111207] 

	// [RS4721_TRT_EXC8]
	iRet = iDw_Etat.SaveAs ( sNomFicTrv, EXCEL8!, TRUE ) 

	idw_Etat.SetFilter ( "" )
	idw_Etat.Filter ( )
	idw_Etat.Sort ()

	If iRet < 0 Then Exit

LOOP

If iRet > 0 Then iRet = 1
If iRet < 0 Then iRet = -1

Return iRet 

end function

private function integer uf_d_l_pm02_fic_xxxx (string asnomfic);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_d_l_pm02_fic_xxxx (PRIVATE)
//* Auteur			: JFF
//* Date				: 24/03/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [PM02].[TRT_MENS_EXTR]
//* Commentaires	: Etats li$$HEX2$$e9002000$$ENDHEX$$au PM02
//*
//* Arguments		: Value	String	asNomFic
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//			FPI	07/12/2011	[FPI.20111207] Cr$$HEX1$$e900$$ENDHEX$$ation automatique des r$$HEX1$$e900$$ENDHEX$$pertoires
// 	   JFF      09/03/2023  [RS4721_TRT_EXC8]
//*-----------------------------------------------------------------

String sSavIdBrk, sIdBrk, sNomFicTrv, sVal
Long 	 lLigne, lIdPeriode, lIdTrt
Int	 iRet

sSavIdBrk = ""

idw_Etat.SetFilter ( "" )
idw_Etat.Filter ( )
idw_Etat.Sort ()

lLigne = 1
iRet = 1

Choose Case ilNumEtat

	Case 86 // Fic Sortie

		DO UNTIL lLigne > ilNbLig
		
			sIdBrk = Trim ( idw_Etat.GetItemString ( lLigne, "ID_BRK" ) )
			If IsNull ( sIdBrk ) Or sIdBrk = "" Or sIdBrk = sSavIdBrk Then 
				lLigne ++
				Continue
			End If
				
			sSavIdBrk = sIdBrk 
			
			idw_Etat.SetFilter ( "ID_BRK = '" + sIdBrk + "'" )
			idw_Etat.Filter ( )
			idw_Etat.Sort ()

			// la ligne est forc$$HEX1$$e900$$ENDHEX$$ment pr$$HEX1$$e900$$ENDHEX$$sente
			lIdPeriode = iDw_Etat.GetItemNumber ( 1, "ID_PERIODE" ) 
			lIdTrt = iDw_Etat.GetItemNumber ( 1, "ID_TRT" ) 
			
			If IsNull ( lIdPeriode ) Then lIdPeriode = 0
			If IsNull ( lIdTrt ) Then lIdTrt = 0				
		
			sNomFicTrv = F_Remplace ( asNomFic, "[BRK]", sIdBrk )
			sNomFicTrv = F_Remplace ( sNomFicTrv, "[PER]", String ( lIdPeriode ) )
			sNomFicTrv = F_Remplace ( sNomFicTrv, "[ID_TRT]", String ( lIdTrt ) )			
	
			uf_creerdossier( sNomFicTrv ) //	[FPI.20111207] 
		
			// [RS4721_TRT_EXC8]
			iRet = iDw_Etat.SaveAs ( sNomFicTrv, EXCEL8!, TRUE ) 
		
			idw_Etat.SetFilter ( "" )
			idw_Etat.Filter ( )
			idw_Etat.Sort ()
		
			If iRet < 0 Then Exit
		
		LOOP		
		
	Case 87 
				
		If iDw_Etat.RowCount () > 0 Then
			sVal = iDw_Etat.GetItemString ( 1, "CHAINE" ) 

			lIdTrt = Long ( Mid ( sVal, 3, 8 ) )
			lIdPeriode = Long ( Mid ( sVal, 11, 6 ) )
			
			sNomFicTrv = F_Remplace ( asNomFic, "[PER]", String ( lIdPeriode ) )
			sNomFicTrv = F_Remplace ( sNomFicTrv, "[ID_TRT]", String ( lIdTrt ) )			
			sNomFicTrv = F_Remplace ( sNomFicTrv, "[EXT]", Char ( 64 + Long ( Right ( String ( lIdPeriode ), 2 ) ) ) )			

			uf_creerdossier( sNomFicTrv ) //	[FPI.20111207] 
			iRet = iDw_Etat.SaveAs ( sNomFicTrv, TEXT!, FALSE) 
		
			idw_Etat.SetFilter ( "" )
			idw_Etat.Filter ( )
			idw_Etat.Sort ()
			
		End If 
		
	Case 88 // Fic Rejet

		If iDw_Etat.RowCount () > 0 Then
		
			lIdPeriode = iDw_Etat.GetItemNumber ( 1, "ID_PERIODE" ) 
			lIdTrt = iDw_Etat.GetItemNumber ( 1, "ID_TRT" ) 
			
			If IsNull ( lIdPeriode ) Then lIdPeriode = 0
			If IsNull ( lIdTrt ) Then lIdTrt = 0			
		
			sNomFicTrv = F_Remplace ( asNomFic, "[PER]", String ( lIdPeriode ) )
			sNomFicTrv = F_Remplace ( sNomFicTrv, "[ID_TRT]", String ( lIdTrt ) )			

			uf_creerdossier( sNomFicTrv ) //	[FPI.20111207] 

			// [RS4721_TRT_EXC8]
			iRet = iDw_Etat.SaveAs ( sNomFicTrv, EXCEL8!, TRUE ) 
		End If
		
End Choose 


If iRet > 0 Then iRet = 1
If iRet < 0 Then iRet = -1

Return iRet 


end function

protected subroutine uf_creerdossier (string asnomfichier);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sp_gs_trait_etat::uf_creerdossier
//* Auteur			: F. Pinon
//* Date				: 07/12/2011 09:56:12
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [FPI.20111207]
//*
//* Arguments		: value string asnomfichier	 */
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
String sNomDir
Integer iRet

sNomDir=LeftA(asnomfichier,LenA(asnomfichier) - PosA(Reverse(asnomfichier), "\"))

if LenA(sNomDir) < 4 Then return // ne devrait pas arriver.

If not DirectoryExists(sNomDir) Then
	iRet=CreateDirectory ( sNomDir )
	If iRet=-1 Then uf_creerdossier(sNomDir)
	iRet=CreateDirectory ( sNomDir )
End if



end subroutine

private function integer uf_d_l_stat_frais_presta_2 (string asnomfic);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_d_l_stat_frais_presta_2 (PRIVATE)
//* Auteur			: FPI
//* Date				: 29/06/2012
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Traitement particulier pour $$HEX1$$e900$$ENDHEX$$tat d_l_stat_frais_presta_2
//* Commentaires	: [PM72-4] 
//*
//* Arguments		: Value	String	asNomFic
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
// 	    JFF      09/03/2023  [RS4721_TRT_EXC8]
//*-----------------------------------------------------------------

String sNomFicTrv, sVal
Int iRet
n_cst_string nvString

iRet = 1

sVal=idw_Etat.GetItemString(1,"PERIODE_FACTURATION")

sNomFicTrv=nvString.of_globalreplace( asnomfic, "aaaamm.xls", sVal + ".xls")

uf_creerdossier( sNomFicTrv ) 

// [RS4721_TRT_EXC8]
iRet = iDw_Etat.SaveAs ( sNomFicTrv, EXCEL8!, TRUE ) 

Return iRet 

end function

public function integer uf_d_l_reg_frais_presta_volcane (string asnomfic);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_d_l_reg_frais_presta_volcane
//* Auteur			: FPI
//* Date				: 06/09/2012
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [PM72-4] G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e800$$ENDHEX$$re le fichier frais-presta pour volcane
//* Commentaires	: Si un fichier du m$$HEX1$$ea00$$ENDHEX$$me nom existait, il est $$HEX1$$e900$$ENDHEX$$cras$$HEX1$$e900$$ENDHEX$$
//*
//* Arguments		: 	String			asNomFic - Nom Complet du fichier Volcane
//*						
//* Retourne		: 	Long 		1 si Ok , Valeur n$$HEX1$$e900$$ENDHEX$$gative si Pb
//*										
//*
//*-----------------------------------------------------------------
//     JFF 12/02/2016  [PI062]
//     JFF 12/05/2020  [PI085]
//*-----------------------------------------------------------------


String		sCodAppli		// Code de l'application
String		sIdSin			// Num$$HEX1$$e900$$ENDHEX$$ro de sinistre
String		sIdProdSin			// Num$$HEX1$$e900$$ENDHEX$$ro de produit du sinistre
String		sIdProdAdh			// Num$$HEX1$$e900$$ENDHEX$$ro de produit adh$$HEX1$$e900$$ENDHEX$$sion
String		sMtRbt			// Montant du r$$HEX1$$e800$$ENDHEX$$glement
String 	sPeriode, sLibProd, sNoContrat, sLibCie
String 	sNom, sPrenom, sTypeApp
String 	sCodeProcess, sLibProcess, sDateTraitement, sOrgRbt

String		sEnr				// Enregistrement $$HEX3$$e0002000e900$$ENDHEX$$crire dans le fichier

Decimal{2}	dcMtSin			// Montant du r$$HEX1$$e800$$ENDHEX$$glement

Integer		iFic				// Fichier Dans lequel on va $$HEX1$$e900$$ENDHEX$$crire
Integer		iRet				// Utilis$$HEX2$$e9002000$$ENDHEX$$Pour Test FileWrite

Long			lCpt				// Compteur de boucle
Long			lRet = 1			// Valeur de retour de la fonction
Long			lNbLig			// Nombre de lignes de Dw_1
n_cst_string nvString

sCodAppli		=	"02"
sPeriode=idw_Etat.GetItemString ( 1, "PERIODE_FACTURATION" ) 

asNomFic=nvString.of_globalreplace( asnomfic, "aaaamm", sPeriode)

iFic	=	FileOpen ( asNomFic, LineMode!, Write!, LockReadWrite!, Replace! )

If iFic > 0 Then

	 lNbLig	=	idw_Etat.RowCount ()
	 For lCpt	=	1 To lNbLig

		//--------------------------------------------------------------------
		// Chargement de toutes les variables du fichier avec une longueur fixe
		//--------------------------------------------------------------------


		// [PI085]
		If F_CLE_A_TRUE ( "PI085" ) Then
			sIdProdAdh			=	String (idw_Etat.GetItemNumber ( lCpt, "ID_PROD_ADH" ),"00000")			
		Else 
			sIdProdAdh			=	String (idw_Etat.GetItemNumber ( lCpt, "ID_PROD_ADH" ),"000")			
		End If		

		// [PI085]
		If F_CLE_A_TRUE ( "PI085" ) Then
			sIdProdSin			=	String (idw_Etat.GetItemNumber ( lCpt, "ID_PROD_SIN" ),"0000000")
		Else 
			sIdProdSin			=	String (idw_Etat.GetItemNumber ( lCpt, "ID_PROD_SIN" ),"00000")
		End If 
		
		sLibProd=Left  (idw_Etat.GetItemString ( lCpt, "LIB_PRODUIT" ) + Space(65), 65 ) 

		sNoContrat=Left  (idw_Etat.GetItemString ( lCpt, "NO_CONTRAT" ) + Space(60), 60 ) 
		sLibCie=Left  (idw_Etat.GetItemString ( lCpt, "LIB_CIE" ) + Space(35), 35 ) 

		// [PI062] +3
		If F_CLE_A_TRUE ( "PI062_VOLC_MENS" ) Then
			sIdSin			=	String ( idw_Etat.GetItemNumber ( lCpt, "ID_SIN" ), "0000000000" )
		Else
			sIdSin			=	String ( idw_Etat.GetItemNumber ( lCpt, "ID_SIN" ), "0000000" )
		End If
		
		sNom=Left  (idw_Etat.GetItemString ( lCpt, "NOM" ) + Space(35), 35 ) 
		sPrenom=Left  (idw_Etat.GetItemString ( lCpt, "PRENOM" ) + Space(35), 35 ) 

		
		sTypeApp=Left  (idw_Etat.GetItemString ( lCpt, "LIB_TYP_APPAREIL" ) + Space(35), 35 ) 
	
		sCodeProcess=	String ( idw_Etat.GetItemNumber ( lCpt, "CODE_PROCESS" ), "0000" )
		sLibProcess=Left  (idw_Etat.GetItemString ( lCpt, "LIB_PROCESS" ) + Space(35), 35 ) 

		sDateTraitement=String(idw_Etat.GetItemDateTime(lCpt,"DTE_TRT"),"dd/mm/yyyy")
		
		dcMtSin			=	idw_Etat.GetItemNumber ( lCpt, "MONTANT" )

		// le montant du rbt est multipli$$HEX2$$e9002000$$ENDHEX$$par 100 pour supprimer la virgule

		sMtRbt			=	Right ( "000000000000"							+ &
								String ( dcMtSin*100,								 		+ &
										  "###########0" ), 12 ) 

		sOrgRbt=Left  (idw_Etat.GetItemString ( lCpt, "ORGANISME_PEC_RBT" ) + Space(35), 35 ) 
		
		sEnr			=	sIdProdAdh + &
							sIdProdSin + &
							sLibProd + &
							sNoContrat + &
							sLibCie + &
							sIdSin + &
							sNom + &
							sPrenom + &
							sTypeApp + &
							sCodeProcess + &
							sLibProcess + &
							sDateTraitement + &
							Space(13) + &
							sMtRbt + &
							sOrgRbt + &
							sPeriode + &
							sCodAppli
							
		iRet	=	FileWrite ( iFic, sEnr )
		If iRet < 0 Then

			lRet	=	-3 		// Erreur Ecriture Enregistrement
			Exit
		End IF
	 Next
Else

	lRet	=	-2				// Erreur Ouverture Fichier 
End If

iRet 	=	FileClose ( iFic )

If iRet < 0 And lRet > 0 Then

	lRet	= -4		// Erreur $$HEX2$$e0002000$$ENDHEX$$la fermeture du fichier
End If

Return lRet
end function

public subroutine uf_d_l_reg_rassureo ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_d_l_reg_rassureo
//* Auteur			: FPI
//* Date				: 19/08/2013
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Traitement particulier pour $$HEX1$$e900$$ENDHEX$$tat D_L_REG_RASSUREO
//* Commentaires	: [PC932]
//*
//* Arguments		: 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------



Long lCpt
Decimal dcTotal=0

For lCpt = 1 to ilNbLig

	dcTotal+=idw_Etat.GetItemDecimal(lCpt,"montant_de_l_indemnit$$HEX1$$e900$$ENDHEX$$")
Next

lCpt=idw_Etat.InsertRow(0)

idw_Etat.SetItem(lCpt,"point_de_vente_ou_centrale","TOTAL GENERAL")
idw_Etat.SetItem(lCpt,"montant_de_l_indemnit$$HEX1$$e900$$ENDHEX$$", dcTotal)


end subroutine

public function string uf_format_nomfic (string asnomfic);// FPI - [VDoc11966]
long lperiodedeb, lperiodefin
datetime dtdtedeb, dtdtefin
String sRet
Long lPosPoint

uf_lireperiode( lperiodedeb, lperiodefin, dtdtedeb, dtdtefin )

lPosPoint=LastPos(asNomFic,".")

sRet=Left(asNomFic, lPosPoint - 1) + "_" + string(lPeriodeFin) + Right(asNomFic, Len(asNomFic) - lPosPoint + 1)

Return sRet

end function

public function long uf_saveas_csv_point_virugule (string asnomfic);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_saveas_csv_point_virugule
//* Auteur			: FPI
//* Date				: 27/03/2015
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [VDoc17201] G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e800$$ENDHEX$$re le fichier CSV avec le s$$HEX1$$e900$$ENDHEX$$parateur ;
//* Commentaires	: Si un fichier du m$$HEX1$$ea00$$ENDHEX$$me nom existait, il est $$HEX1$$e900$$ENDHEX$$cras$$HEX1$$e900$$ENDHEX$$
//*
//* Arguments		: 	String			asNomFic - Nom Complet du fichier 
//*						
//* Retourne		: 	Long 		1 si Ok , Valeur n$$HEX1$$e900$$ENDHEX$$gative si Pb
//*										
//*
//*-----------------------------------------------------------------

Integer iFic, iRet
Long lTotCol, lCpt, lRow
String sEnr, sVal, sTypeZone
Boolean bLu

lTotCol	= Long ( idw_Etat.Describe ( "DataWindow.Column.Count" ) )
iFic	=	FileOpen ( asNomFic, LineMode!, Write!, LockReadWrite!, Replace! )

If iFic > 0 Then

	// Ecriture de l'ent$$HEX1$$ea00$$ENDHEX$$te
	sEnr=""
	For lCpt=1 to lTotCol
		sEnr+= idw_Etat.Describe ( "#" + String(lCpt) + ".DbName" ) + ";"
	Next
	
	sEnr=Left(sEnr,Len(sEnr) - 1) 
	
	iRet	=	FileWrite ( iFic, sEnr )
	
	If iRet < 0 Then
		iRet=-3 // Erreur d'$$HEX1$$e900$$ENDHEX$$criture
	End if
	
	// Ecriture du contenu de la dw
	If iRet > 0 Then
		For lRow=1 to idw_Etat.RowCount()
			sEnr=""
			For lCpt=1 to lTotCol
				
				sVal=""
				bLu=FALSE
				
				sTypeZone=idw_Etat.Describe(	"#" + String(lCpt) + ".ColType")
				
				If Pos(Upper(sTypeZone),"CHAR") = 1 Then
					sVal=idw_Etat.GetItemString(lRow,lCpt)
					bLu=TRUE
				End if
			
				If Pos(Upper(sTypeZone),"DATE") = 1 Then
					If Upper(sTypeZone) = "DATETIME" Then
						sVal=String(idw_Etat.GetItemDateTime(lRow,lCpt))
					Else
						sVal=String(idw_Etat.GetItemDate(lRow,lCpt))
					End if
					bLu=TRUE
				End if
			
				If Pos(Upper(sTypeZone),"DECIMAL") = 1 Then
					sVal=String(idw_Etat.GetItemDecimal(lRow,lCpt))
					bLu=TRUE
				End if
				
				If not bLu Then
					sVal=String(idw_Etat.GetItemNumber(lRow,lCpt))
				End if
				
				If isNull(sVal) Then sVal=""
				
				sEnr+=sVal + ";"
			Next
	
			sEnr=Left(sEnr,Len(sEnr) - 1)
			iRet	=	FileWrite ( iFic, sEnr )
			
			If iRet < 0 Then
				iRet=-3 // Erreur d'$$HEX1$$e900$$ENDHEX$$criture
				exit 
			End if
			
		Next
	End if
	
	// Fermeture du fichier
	iRet 	=	FileClose ( iFic )
	If iRet < 0 Then
		iRet	= -4		// Erreur $$HEX2$$e0002000$$ENDHEX$$la fermeture du fichier
	End If
	
Else
	iRet=-2 // Erreur d'ouverture
End if

If iRet > 0 Then iRet=1

Return iRet
	

end function

on u_sp_gs_trait_etat.create
call super::create
end on

on u_sp_gs_trait_etat.destroy
call super::destroy
end on

