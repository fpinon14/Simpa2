HA$PBExportHeader$u_gs_sp_sinistre_creer_lst_detail.sru
$PBExportComments$---} User Object permettant la cr$$HEX1$$e900$$ENDHEX$$ation de DW de d$$HEX1$$e900$$ENDHEX$$tail.
forward
global type u_gs_sp_sinistre_creer_lst_detail from nonvisualobject
end type
end forward

global type u_gs_sp_sinistre_creer_lst_detail from nonvisualobject
end type
global u_gs_sp_sinistre_creer_lst_detail u_gs_sp_sinistre_creer_lst_detail

type variables
Private :
	u_Transaction		itrTrans
	u_DataWindow_Detail	idwDet
	String			isSysadm = "sysadm."
end variables

forward prototypes
private subroutine uf_maj_par (integer aicol, string astable)
public subroutine uf_creer_detail (integer aitype, ref u_datawindow_detail adw_1, ref u_transaction atrtrans)
private subroutine uf_maj_le (integer aicol, string astable)
private subroutine uf_cree_le (integer aicol, string astable)
private subroutine uf_agence ()
private subroutine uf_wdetail ()
end prototypes

private subroutine uf_maj_par (integer aicol, string astable);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Maj_Par ( Private )
//* Auteur			: Erick John Stark
//* Date				: 24/10/1997 15:12:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cr$$HEX1$$e900$$ENDHEX$$ation d'une colonne MAJ_PAR standard sur dw d$$HEX1$$e900$$ENDHEX$$tail
//*
//* Arguments		: Integer		aiCol					(Val)	N$$HEX2$$b0002000$$ENDHEX$$de la colonne de d$$HEX1$$e900$$ENDHEX$$tail
//*					  String			asTable				(Val)	Nom de la table
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

idwDet.istCol[ aiCol ].sDbName		=	asTable + ".maj_par"
idwDet.istCol[ aiCol ].sResultSet	=	"maj_par"
idwDet.istCol[ aiCol ].sType			=	"char(4)"
idwDet.istCol[ aiCol ].sHeaderName	=	"Par"
idwDet.istCol[ aiCol ].ilargeur		=	4
idwDet.istCol[ aiCol ].sAlignement	=	"0"
idwDet.istCol[ aiCol ].sInvisible	= 	"N"
idwDet.istCol[ aiCol ].sUpdate		= 	"O"
idwDet.istCol[ aiCol ].sCle			= 	"N"


end subroutine

public subroutine uf_creer_detail (integer aitype, ref u_datawindow_detail adw_1, ref u_transaction atrtrans);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Creer_Detail (Public)
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:47:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cr$$HEX1$$e900$$ENDHEX$$ation d'une Data Window de D$$HEX1$$e900$$ENDHEX$$tail
//*
//* Arguments		: Integer					aiType	(Val)	Type de choix
//*					  U_DataWindow_Detail	adw_1		(R$$HEX1$$e900$$ENDHEX$$f)	DataWindow de d$$HEX1$$e900$$ENDHEX$$tail
//*					  u_Transaction			atrTrans	(R$$HEX1$$e900$$ENDHEX$$f)	Objet de transaction
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

idwDet	= adw_1
itrTrans	= atrTrans

Choose Case aiType
Case 1
	Uf_Agence ()

Case 2
	Uf_wDetail ()

End Choose

idwDet.Visible = True






end subroutine

private subroutine uf_maj_le (integer aicol, string astable);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Maj_Le ( Private )
//* Auteur			: Erick John Stark
//* Date				: 24/10/1997 15:12:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cr$$HEX1$$e900$$ENDHEX$$ation d'une colonne MAJ_LE standard sur dw d$$HEX1$$e900$$ENDHEX$$tail
//*
//* Arguments		: Integer		aiCol					(Val)	N$$HEX2$$b0002000$$ENDHEX$$de la colonne de d$$HEX1$$e900$$ENDHEX$$tail
//*					  String			asTable				(Val)	Nom de la table
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

idwDet.istCol[ aiCol ].sDbName		=	asTable + ".maj_le"
idwDet.istCol[ aiCol ].sResultSet	=	"maj_le"
idwDet.istCol[ aiCol ].sType			=	"datetime"
idwDet.istCol[ aiCol ].sHeaderName	=	"Maj Le"
idwDet.istCol[ aiCol ].sFormat		=	"dd/mm/yyyy hh:mm"
idwDet.istCol[ aiCol ].ilargeur		=	16
idwDet.istCol[ aiCol ].sAlignement	=	"2"
idwDet.istCol[ aiCol ].sInvisible	= 	"N"
idwDet.istCol[ aiCol ].sUpdate		= 	"O"
idwDet.istCol[ aiCol ].sCle			= 	"N"

end subroutine

private subroutine uf_cree_le (integer aicol, string astable);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Cree_Le ( Private )
//* Auteur			: Erick John Stark
//* Date				: 24/10/1997 15:12:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cr$$HEX1$$e900$$ENDHEX$$ation d'une colonne CREE_LE standard sur dw d$$HEX1$$e900$$ENDHEX$$tail
//*
//* Arguments		: Integer		aiCol					(Val)	N$$HEX2$$b0002000$$ENDHEX$$de la colonne de d$$HEX1$$e900$$ENDHEX$$tail
//*					  String			asTable				(Val)	Nom de la table
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

idwDet.istCol[ aiCol ].sDbName		=	asTable + ".cree_le"
idwDet.istCol[ aiCol ].sResultSet	=	"cree_le"
idwDet.istCol[ aiCol ].sType			=	"datetime"
idwDet.istCol[ aiCol ].sHeaderName	=	"Cr$$HEX1$$e900$$ENDHEX$$ation"
idwDet.istCol[ aiCol ].sFormat		=	"dd/mm/yyyy"
idwDet.istCol[ aiCol ].ilargeur		=	10
idwDet.istCol[ aiCol ].sAlignement	=	"2"
idwDet.istCol[ aiCol ].sInvisible	= 	"O"
idwDet.istCol[ aiCol ].sUpdate		= 	"O"
idwDet.istCol[ aiCol ].sCle			= 	"N"

end subroutine

private subroutine uf_agence ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Agence ( PRIVATE )
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:58:27
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cr$$HEX1$$e900$$ENDHEX$$ation de la DW d'accueil
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 OR
//String sTables[1]
String sTables[]
//Fin Migration PB8-WYNIWYG-03/2006 OR

String sTable

sTables[ 1 ]	= "agence"
sTable			= "agence"

/*------------------------------------------------------------------*/
/* Il y a un BUG, en effet la fonction ne g$$HEX1$$e900$$ENDHEX$$re pas le principe du   */
/* sysadm (SQL Server) et/ou du result set. La cr$$HEX1$$e900$$ENDHEX$$ation marche,     */
/* mais l'autorisation pour l'update va poser des probl$$HEX1$$e800$$ENDHEX$$mes, donc   */
/* il vaut mieux enlever "sysadm.".                                 */
/*------------------------------------------------------------------*/
idwDet.istCol[1].sDbName		=	"agence.id_bq"
idwDet.istCol[1].sResultSet	=	"id_bq"
idwDet.istCol[1].sType			=	"char(5)"
idwDet.istCol[1].sHeaderName	=	"Banque"
idwDet.istCol[1].ilargeur		=	6
idwDet.istCol[1].sAlignement	=	"2"
idwDet.istCol[1].sInvisible	= 	"N"
idwDet.istCol[1].sUpdate		= 	"N"
idwDet.istCol[1].sCle			= 	"O"

idwDet.istCol[2].sDbName		=	"agence.id_ag"
idwDet.istCol[2].sResultSet	=	"id_ag"
idwDet.istCol[2].sType			=	"char(5)"
idwDet.istCol[2].sHeaderName	=	"Agence"
idwDet.istCol[2].ilargeur		=	6
idwDet.istCol[2].sAlignement	=	"2"
idwDet.istCol[2].sInvisible	= 	"N"
idwDet.istCol[2].sUpdate		= 	"N"
idwDet.istCol[2].sCle			= 	"O"

idwDet.istCol[3].sDbName		=	"agence.lib_ag"
idwDet.istCol[3].sResultSet	=	"lib_ag"
idwDet.istCol[3].sType			=	"char(35)"
idwDet.istCol[3].sHeaderName	=	"Libell$$HEX2$$e9002000$$ENDHEX$$Agence"
idwDet.istCol[3].ilargeur		=	30
idwDet.istCol[3].sAlignement	=	"0"
idwDet.istCol[3].sInvisible	= 	"N"
idwDet.istCol[3].sUpdate		= 	"N"
idwDet.istCol[3].sCle			= 	"N"

idwDet.istCol[4].sDbName		=	"agence.adr_1"
idwDet.istCol[4].sResultSet	=	"adr_1"
idwDet.istCol[4].sType			=	"char(35)"
idwDet.istCol[4].sHeaderName	=	"Adresse"
idwDet.istCol[4].ilargeur		=	20
idwDet.istCol[4].sAlignement	=	"0"
idwDet.istCol[4].sInvisible	= 	"N"
idwDet.istCol[4].sUpdate		= 	"N"
idwDet.istCol[4].sCle			= 	"N"

idwDet.istCol[5].sDbName		=	"agence.adr_2"
idwDet.istCol[5].sResultSet	=	"adr_2"
idwDet.istCol[5].sType			=	"char(35)"
idwDet.istCol[5].sHeaderName	=	"Adresse 2"
idwDet.istCol[5].ilargeur		=	35
idwDet.istCol[5].sAlignement	=	"0"
idwDet.istCol[5].sInvisible	= 	"O"
idwDet.istCol[5].sUpdate		= 	"N"
idwDet.istCol[5].sCle			= 	"N"

idwDet.istCol[6].sDbName		=	"agence.adr_cp"
idwDet.istCol[6].sResultSet	=	"adr_cp"
idwDet.istCol[6].sType			=	"char(5)"
idwDet.istCol[6].sHeaderName	=	"Postal"
idwDet.istCol[6].ilargeur		=	5
idwDet.istCol[6].sAlignement	=	"0"
idwDet.istCol[6].sInvisible	= 	"O"
idwDet.istCol[6].sUpdate		= 	"N"
idwDet.istCol[6].sCle			= 	"N"

idwDet.istCol[7].sDbName		=	"agence.adr_ville"
idwDet.istCol[7].sResultSet	=	"adr_ville"
idwDet.istCol[7].sType			=	"char(35)"
idwDet.istCol[7].sHeaderName	=	"Ville"
idwDet.istCol[7].ilargeur		=	25
idwDet.istCol[7].sAlignement	=	"0"
idwDet.istCol[7].sInvisible	= 	"N"
idwDet.istCol[7].sUpdate		= 	"N"
idwDet.istCol[7].sCle			= 	"N"

idwDet.istCol[8].sDbName		=	"agence.lib_service"
idwDet.istCol[8].sResultSet	=	"lib_service"
idwDet.istCol[8].sType			=	"char(35)"
idwDet.istCol[8].sHeaderName	=	"Service"
idwDet.istCol[8].ilargeur		=	35
idwDet.istCol[8].sAlignement	=	"0"
idwDet.istCol[8].sInvisible	= 	"O"
idwDet.istCol[8].sUpdate		= 	"N"
idwDet.istCol[8].sCle			= 	"N"

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window de d$$HEX1$$e900$$ENDHEX$$tail                             */
/*------------------------------------------------------------------*/
idwDet.Uf_Creer_Tout( idwDet.istCol, sTables, iTrTrans )

/*------------------------------------------------------------------*/
/* La DataWindow de d$$HEX1$$e900$$ENDHEX$$tail sera tri$$HEX1$$e900$$ENDHEX$$e sur ID_BQ, ADR_VILLE, ID_AG   */
/*------------------------------------------------------------------*/
idwDet.isTri = "ID_BQ A, ADR_VILLE A, ID_AG"

/*------------------------------------------------------------------*/
/* La premi$$HEX1$$e800$$ENDHEX$$re ligne est s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e par d$$HEX1$$e900$$ENDHEX$$faut.                   */
/*------------------------------------------------------------------*/
idwDet.Uf_Activer_Selection ( True )




end subroutine

private subroutine uf_wdetail ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_WDetail ( PRIVATE )
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:58:27
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cr$$HEX1$$e900$$ENDHEX$$ation de la DW d'accueil
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1	PHG	15/02/2008 [SUISSE].LOT3 : Gestion Dynamique de la monnaie
//Migration PB8-WYNIWYG-03/2006 OR
//String sTables[1]
String sTables[]
//Fin Migration PB8-WYNIWYG-03/2006 OR

sTables[ 1 ]	= "w_detail"

/*------------------------------------------------------------------*/
/* Il y a un BUG, en effet la fonction ne g$$HEX1$$e900$$ENDHEX$$re pas le principe du   */
/* sysadm (SQL Server) et/ou du result set. La cr$$HEX1$$e900$$ENDHEX$$ation marche,     */
/* mais l'autorisation pour l'update va poser des probl$$HEX1$$e800$$ENDHEX$$mes, donc   */
/* il vaut mieux enlever "sysadm.".                                 */
/*------------------------------------------------------------------*/
idwDet.istCol[1].sDbName		=	"w_detail.id_sin"
idwDet.istCol[1].sResultSet	=	"id_sin"
idwDet.istCol[1].sType			=	"decimal(0)"
idwDet.istCol[1].sHeaderName	=	"Id Sin"
idwDet.istCol[1].ilargeur		=	6
idwDet.istCol[1].sAlignement	=	"2"
idwDet.istCol[1].sInvisible	= 	"O"
idwDet.istCol[1].sUpdate		= 	"N"
idwDet.istCol[1].sCle			= 	"N"

idwDet.istCol[2].sDbName		=	"w_detail.id_gti"
idwDet.istCol[2].sResultSet	=	"id_gti"
idwDet.istCol[2].sType			=	"decimal(0)"
idwDet.istCol[2].sHeaderName	=	"Garantie"
idwDet.istCol[2].ilargeur		=	6
idwDet.istCol[2].sAlignement	=	"2"
idwDet.istCol[2].sInvisible	= 	"O"
idwDet.istCol[2].sUpdate		= 	"N"
idwDet.istCol[2].sCle			= 	"N"

idwDet.istCol[3].sDbName		=	"w_detail.id_detail"
idwDet.istCol[3].sResultSet	=	"id_detail"
idwDet.istCol[3].sType			=	"decimal(0)"
idwDet.istCol[3].sHeaderName	=	"N$$HEX1$$b000$$ENDHEX$$"
idwDet.istCol[3].ilargeur		=	1
idwDet.istCol[3].sAlignement	=	"1"
idwDet.istCol[3].sInvisible	= 	"N"
idwDet.istCol[3].sUpdate		= 	"N"
idwDet.istCol[3].sCle			= 	"N"

idwDet.istCol[4].sDbName		=	"w_detail.id_evt"
idwDet.istCol[4].sResultSet	=	"id_evt"
idwDet.istCol[4].sType			=	"decimal(0)"
idwDet.istCol[4].sHeaderName	=	"Ev$$HEX1$$e800$$ENDHEX$$nement"
idwDet.istCol[4].ilargeur		=	26
idwDet.istCol[4].sAlignement	=	"0"
idwDet.istCol[4].sInvisible	= 	"N"
idwDet.istCol[4].sUpdate		= 	"N"
idwDet.istCol[4].sCle			= 	"N"

idwDet.istCol[5].sDbName		=	"w_detail.lib_det"
idwDet.istCol[5].sResultSet	=	"lib_det"
idwDet.istCol[5].sType			=	"char(65)"
idwDet.istCol[5].sHeaderName	=	"Libell$$HEX1$$e900$$ENDHEX$$"
idwDet.istCol[5].ilargeur		=	25
idwDet.istCol[5].sAlignement	=	"0"
idwDet.istCol[5].sInvisible	= 	"O"
idwDet.istCol[5].sUpdate		= 	"N"
idwDet.istCol[5].sCle			= 	"N"

idwDet.istCol[6].sDbName		=	"w_detail.dte_det"
idwDet.istCol[6].sResultSet	=	"dte_det"
idwDet.istCol[6].sType			=	"datetime"
idwDet.istCol[6].sHeaderName	=	"Date Evt"
idwDet.istCol[6].ilargeur		=	10
idwDet.istCol[6].sAlignement	=	"0"
idwDet.istCol[6].sInvisible	= 	"N"
idwDet.istCol[6].sUpdate		= 	"N"
idwDet.istCol[6].sCle			= 	"N"

idwDet.istCol[7].sDbName		=	"w_detail.heu_det"
idwDet.istCol[7].sResultSet	=	"hey_det"
idwDet.istCol[7].sType			=	"char(4)"
idwDet.istCol[7].sHeaderName	=	"Heure"
idwDet.istCol[7].ilargeur		=	4
idwDet.istCol[7].sAlignement	=	"0"
idwDet.istCol[7].sInvisible	= 	"O"
idwDet.istCol[7].sUpdate		= 	"N"
idwDet.istCol[7].sCle			= 	"N"

idwDet.istCol[8].sDbName		=	"w_detail.num_carte"
idwDet.istCol[8].sResultSet	=	"num_carte"
idwDet.istCol[8].sType			=	"char(19)"
idwDet.istCol[8].sHeaderName	=	"N$$HEX2$$b0002000$$ENDHEX$$Carte"
idwDet.istCol[8].ilargeur		=	20
idwDet.istCol[8].sAlignement	=	"0"
idwDet.istCol[8].sInvisible	= 	"O"
idwDet.istCol[8].sUpdate		= 	"N"
idwDet.istCol[8].sCle			= 	"N"

idwDet.istCol[9].sDbName		=	"w_detail.mt_prej"
idwDet.istCol[9].sResultSet	=	"mt_prej"
idwDet.istCol[9].sType			=	"decimal(2)"
idwDet.istCol[9].sHeaderName	=	"Mt Prej"
idwDet.istCol[9].ilargeur		=	13
idwDet.istCol[9].sAlignement	=	"1"
idwDet.istCol[9].sFormat		=	"#,##0.00 \"+stGlb.sMonnaieSymboleDesire // #1 [SUISSE].LOT3
idwDet.istCol[9].sInvisible	= 	"N"
idwDet.istCol[9].sUpdate		= 	"N"
idwDet.istCol[9].sCle			= 	"N"

idwDet.istCol[10].sDbName		=	"w_detail.mt_fran"
idwDet.istCol[10].sResultSet	=	"mt_fran"
idwDet.istCol[10].sType			=	"decimal(2)"
idwDet.istCol[10].sHeaderName	=	"Mt Fran"
idwDet.istCol[10].sFormat		=	"#.0.00"
idwDet.istCol[10].ilargeur		=	10
idwDet.istCol[10].sAlignement	=	"0"
idwDet.istCol[10].sInvisible	= 	"O"
idwDet.istCol[10].sUpdate		= 	"N"
idwDet.istCol[10].sCle			= 	"N"

idwDet.istCol[11].sDbName		=	"w_detail.mt_nplaf"
idwDet.istCol[11].sResultSet	=	"mt_nplaf"
idwDet.istCol[11].sType			=	"decimal(2)"
idwDet.istCol[11].sHeaderName	=	"Mt N.Plaf."
idwDet.istCol[11].ilargeur		=	8
idwDet.istCol[11].sAlignement	=	"0"
idwDet.istCol[11].sInvisible	= 	"O"
idwDet.istCol[11].sUpdate		= 	"N"
idwDet.istCol[11].sCle			= 	"N"

idwDet.istCol[12].sDbName		=	"w_detail.mt_plaf"
idwDet.istCol[12].sResultSet	=	"mt_plaf"
idwDet.istCol[12].sType			=	"decimal(2)"
idwDet.istCol[12].sHeaderName	=	"Mt R$$HEX1$$e800$$ENDHEX$$g."
idwDet.istCol[12].ilargeur		=	13
idwDet.istCol[12].sFormat		=	"#,##0.00 \"+stGlb.sMonnaieSymboleDesire // #1 [SUISSE].LOT3
idwDet.istCol[12].sAlignement	=	"1"
idwDet.istCol[12].sInvisible	= 	"N"
idwDet.istCol[12].sUpdate		= 	"N"
idwDet.istCol[12].sCle			= 	"N"

idwDet.istCol[13].sDbName		=	"w_detail.id_i_reg"
idwDet.istCol[13].sResultSet	=	"id_i_reg"
idwDet.istCol[13].sType			=	"decimal(0)"
idwDet.istCol[13].sHeaderName	=	"Id I"
idwDet.istCol[13].ilargeur		=	2
idwDet.istCol[13].sAlignement	=	"0"
idwDet.istCol[13].sInvisible	= 	"O"
idwDet.istCol[13].sUpdate		= 	"N"
idwDet.istCol[13].sCle			= 	"N"

idwDet.istCol[14].sDbName		=	"w_detail.alt_bloc"
idwDet.istCol[14].sResultSet	=	"alt_bloc"
idwDet.istCol[14].sType			=	"char(1)"
idwDet.istCol[14].sHeaderName	=	"B"
idwDet.istCol[14].ilargeur		=	1
idwDet.istCol[14].sAlignement	=	"2"
idwDet.istCol[14].sInvisible	= 	"N"
idwDet.istCol[14].sUpdate		= 	"N"
idwDet.istCol[14].sCle			= 	"N"

idwDet.istCol[15].sDbName		=	"w_detail.alt_cour"
idwDet.istCol[15].sResultSet	=	"alt_cour"
idwDet.istCol[15].sType			=	"char(1)"
idwDet.istCol[15].sHeaderName	=	"Cour."
idwDet.istCol[15].ilargeur		=	1
idwDet.istCol[15].sAlignement	=	"0"
idwDet.istCol[15].sInvisible	= 	"O"
idwDet.istCol[15].sUpdate		= 	"N"
idwDet.istCol[15].sCle			= 	"N"

idwDet.istCol[16].sDbName		=	"w_detail.alt_plaf"
idwDet.istCol[16].sResultSet	=	"alt_plaf"
idwDet.istCol[16].sType			=	"char(1)"
idwDet.istCol[16].sHeaderName	=	"Plaf."
idwDet.istCol[16].ilargeur		=	1
idwDet.istCol[16].sAlignement	=	"0"
idwDet.istCol[16].sInvisible	= 	"O"
idwDet.istCol[16].sUpdate		= 	"N"
idwDet.istCol[16].sCle			= 	"N"

idwDet.istCol[17].sDbName		=	"w_detail.alt_reg"
idwDet.istCol[17].sResultSet	=	"alt_reg"
idwDet.istCol[17].sType			=	"char(1)"
idwDet.istCol[17].sHeaderName	=	"Reg."
idwDet.istCol[17].ilargeur		=	1
idwDet.istCol[17].sAlignement	=	"0"
idwDet.istCol[17].sInvisible	= 	"O"
idwDet.istCol[17].sUpdate		= 	"N"
idwDet.istCol[17].sCle			= 	"N"

idwDet.istCol[18].sDbName		=	"w_detail.alt_att"
idwDet.istCol[18].sResultSet	=	"alt_att"
idwDet.istCol[18].sType			=	"char(1)"
idwDet.istCol[18].sHeaderName	=	"Att."
idwDet.istCol[18].ilargeur		=	1
idwDet.istCol[18].sAlignement	=	"0"
idwDet.istCol[18].sInvisible	= 	"O"
idwDet.istCol[18].sUpdate		= 	"N"
idwDet.istCol[18].sCle			= 	"N"

idwDet.istCol[19].sDbName		=	"w_detail.alt_valide"
idwDet.istCol[19].sResultSet	=	"alt_valide"
idwDet.istCol[19].sType			=	"char(1)"
idwDet.istCol[19].sHeaderName	=	"Valid."
idwDet.istCol[19].ilargeur		=	1
idwDet.istCol[19].sAlignement	=	"0"
idwDet.istCol[19].sInvisible	= 	"O"
idwDet.istCol[19].sUpdate		= 	"N"
idwDet.istCol[19].sCle			= 	"N"

idwDet.istCol[20].sDbName		=	"w_detail.cpt_valide"
idwDet.istCol[20].sResultSet	=	"cpt_valide"
idwDet.istCol[20].sType			=	"decimal(0)"
idwDet.istCol[20].sHeaderName	=	"Nbr Valid."
idwDet.istCol[20].ilargeur		=	2
idwDet.istCol[20].sAlignement	=	"0"
idwDet.istCol[20].sInvisible	= 	"O"
idwDet.istCol[20].sUpdate		= 	"N"
idwDet.istCol[20].sCle			= 	"N"

idwDet.istCol[21].sDbName		=	"w_detail.alt_ssui"
idwDet.istCol[21].sResultSet	=	"alt_ssui"
idwDet.istCol[21].sType			=	"char(1)"
idwDet.istCol[21].sHeaderName	=	"S.Suite"
idwDet.istCol[21].ilargeur		=	1
idwDet.istCol[21].sAlignement	=	"0"
idwDet.istCol[21].sInvisible	= 	"O"
idwDet.istCol[21].sUpdate		= 	"N"
idwDet.istCol[21].sCle			= 	"N"

idwDet.istCol[22].sDbName		=	"w_detail.cod_mot_ssui"
idwDet.istCol[22].sResultSet	=	"cod_mot_ssui"
idwDet.istCol[22].sType			=	"decimal(0)"
idwDet.istCol[22].sHeaderName	=	"Motif"
idwDet.istCol[22].ilargeur		=	1
idwDet.istCol[22].sAlignement	=	"0"
idwDet.istCol[22].sInvisible	= 	"O"
idwDet.istCol[22].sUpdate		= 	"N"
idwDet.istCol[22].sCle			= 	"N"

idwDet.istCol[23].sDbName		=	"w_detail.cod_dec_mac"
idwDet.istCol[23].sResultSet	=	"cod_dec_mac"
idwDet.istCol[23].sType			=	"decimal(0)"
idwDet.istCol[23].sHeaderName	=	"Dec.Mac."
idwDet.istCol[23].ilargeur		=	1
idwDet.istCol[23].sAlignement	=	"0"
idwDet.istCol[23].sInvisible	= 	"O"
idwDet.istCol[23].sUpdate		= 	"N"
idwDet.istCol[23].sCle			= 	"N"

idwDet.istCol[24].sDbName		=	"w_detail.cod_dec_ope"
idwDet.istCol[24].sResultSet	=	"cod_dec_ope"
idwDet.istCol[24].sType			=	"decimal(0)"
idwDet.istCol[24].sHeaderName	=	"Dec.Op$$HEX1$$e900$$ENDHEX$$."
idwDet.istCol[24].ilargeur		=	1
idwDet.istCol[24].sAlignement	=	"0"
idwDet.istCol[24].sInvisible	= 	"O"
idwDet.istCol[24].sUpdate		= 	"N"
idwDet.istCol[24].sCle			= 	"N"

idwDet.istCol[25].sDbName		=	"w_detail.cod_etat"
idwDet.istCol[25].sResultSet	=	"cod_etat"
idwDet.istCol[25].sType			=	"decimal(0)"
idwDet.istCol[25].sHeaderName	=	"Et."
idwDet.istCol[25].ilargeur		=	1
idwDet.istCol[25].sAlignement	=	"2"
idwDet.istCol[25].sInvisible	= 	"N"
idwDet.istCol[25].sUpdate		= 	"N"
idwDet.istCol[25].sCle			= 	"N"

idwDet.istCol[26].sDbName		=	"w_detail.id_carte"
idwDet.istCol[26].sResultSet	=	"id_carte"
idwDet.istCol[26].sType			=	"decimal(0)"
idwDet.istCol[26].sHeaderName	=	"Id Carte"
idwDet.istCol[26].ilargeur		=	5
idwDet.istCol[26].sAlignement	=	"0"
idwDet.istCol[26].sInvisible	= 	"O"
idwDet.istCol[26].sUpdate		= 	"N"
idwDet.istCol[26].sCle			= 	"N"

idwDet.istCol[27].sDbName		=	"w_detail.id_type_carte"
idwDet.istCol[27].sResultSet	=	"id_type_carte"
idwDet.istCol[27].sType			=	"char(3)"
idwDet.istCol[27].sHeaderName	=	"Type Carte"
idwDet.istCol[27].ilargeur		=	3
idwDet.istCol[27].sAlignement	=	"0"
idwDet.istCol[27].sInvisible	= 	"O"
idwDet.istCol[27].sUpdate		= 	"N"
idwDet.istCol[27].sCle			= 	"N"

idwDet.istCol[28].sDbName		=	"w_detail.cree_le"
idwDet.istCol[28].sResultSet	=	"cree_le"
idwDet.istCol[28].sType			=	"datetime"
idwDet.istCol[28].sHeaderName	=	"Cr$$HEX1$$e900$$ENDHEX$$ation"
idwDet.istCol[28].ilargeur		=	10
idwDet.istCol[28].sAlignement	=	"0"
idwDet.istCol[28].sInvisible	= 	"O"
idwDet.istCol[28].sUpdate		= 	"N"
idwDet.istCol[28].sCle			= 	"N"

idwDet.istCol[29].sDbName		=	"w_detail.maj_le"
idwDet.istCol[29].sResultSet	=	"maj_le"
idwDet.istCol[29].sType			=	"datetime"
idwDet.istCol[29].sHeaderName	=	"Maj Le"
idwDet.istCol[29].sFormat		=	"dd/mm/yyyy hh:mm"
idwDet.istCol[29].ilargeur		=	16
idwDet.istCol[29].sAlignement	=	"2"
idwDet.istCol[29].sInvisible	= 	"N"
idwDet.istCol[29].sUpdate		= 	"N"
idwDet.istCol[29].sCle			= 	"N"

idwDet.istCol[30].sDbName		=	"w_detail.maj_par"
idwDet.istCol[30].sResultSet	=	"maj_par"
idwDet.istCol[30].sType			=	"char(4)"
idwDet.istCol[30].sHeaderName	=	"Par"
idwDet.istCol[30].ilargeur		=	4
idwDet.istCol[30].sAlignement	=	"2"
idwDet.istCol[30].sInvisible	= 	"N"
idwDet.istCol[30].sUpdate		= 	"N"
idwDet.istCol[30].sCle			= 	"N"

idwDet.istCol[31].sDbName		=	"w_detail.alt_modif_piece"
idwDet.istCol[31].sResultSet	=	"alt_modif_piece"
idwDet.istCol[31].sType			=	"char(1)"
idwDet.istCol[31].sHeaderName	=	"Pce"
idwDet.istCol[31].ilargeur		=	4
idwDet.istCol[31].sAlignement	=	"0"
idwDet.istCol[31].sInvisible	= 	"O"
idwDet.istCol[31].sUpdate		= 	"N"
idwDet.istCol[31].sCle			= 	"N"

idwDet.istCol[32].sDbName		=	"w_detail.alt_modif_refus"
idwDet.istCol[32].sResultSet	=	"alt_modif_refus"
idwDet.istCol[32].sType			=	"char(1)"
idwDet.istCol[32].sHeaderName	=	"Refus"
idwDet.istCol[32].ilargeur		=	4
idwDet.istCol[32].sAlignement	=	"0"
idwDet.istCol[32].sInvisible	= 	"O"
idwDet.istCol[32].sUpdate		= 	"N"
idwDet.istCol[32].sCle			= 	"N"

idwDet.istCol[33].sDbName		=	"w_detail.alt_modif_plafond"
idwDet.istCol[33].sResultSet	=	"alt_modif_plafond"
idwDet.istCol[33].sType			=	"char(1)"
idwDet.istCol[33].sHeaderName	=	"Plaf"
idwDet.istCol[33].ilargeur		=	4
idwDet.istCol[33].sAlignement	=	"0"
idwDet.istCol[33].sInvisible	= 	"O"
idwDet.istCol[33].sUpdate		= 	"N"
idwDet.istCol[33].sCle			= 	"N"

idwDet.istCol[34].sDbName		=	"w_detail.dte_det_date"
idwDet.istCol[34].sResultSet	=	"dte_det_date"
idwDet.istCol[34].sType			=	"date"
idwDet.istCol[34].sHeaderName	=	"a"
idwDet.istCol[34].ilargeur		=	10
idwDet.istCol[34].sAlignement	=	"0"
idwDet.istCol[34].sInvisible	= 	"O"
idwDet.istCol[34].sUpdate		= 	"N"
idwDet.istCol[34].sCle			= 	"N"

idwDet.istCol[35].sDbName		=	"w_detail.dte_cmd"
idwDet.istCol[35].sResultSet	=	"dte_cmd"
idwDet.istCol[35].sType			=	"date"
idwDet.istCol[35].sHeaderName	=	"a"
idwDet.istCol[35].ilargeur		=	10
idwDet.istCol[35].sAlignement	=	"0"
idwDet.istCol[35].sInvisible	= 	"O"
idwDet.istCol[35].sUpdate		= 	"N"
idwDet.istCol[35].sCle			= 	"N"

idwDet.istCol[36].sDbName		=	"w_detail.dte_livr"
idwDet.istCol[36].sResultSet	=	"dte_livr"
idwDet.istCol[36].sType			=	"datetime" // [PI056]
idwDet.istCol[36].sHeaderName	=	"a"
idwDet.istCol[36].ilargeur		=	10
idwDet.istCol[36].sAlignement	=	"0"
idwDet.istCol[36].sInvisible	= 	"O"
idwDet.istCol[36].sUpdate		= 	"N"
idwDet.istCol[36].sCle			= 	"N"

idwDet.istCol[37].sDbName		=	"w_detail.mt_val_achat"
idwDet.istCol[37].sResultSet	=	"mt_val_achat"
idwDet.istCol[37].sType			=	"decimal(2)"
idwDet.istCol[37].sHeaderName	=	"Val Achat "
idwDet.istCol[37].ilargeur		=	11
idwDet.istCol[37].sAlignement	=	"0"
idwDet.istCol[37].sFormat		=	"#,##0.00 \"+stGlb.sMonnaieSymboleDesire // #1 [SUISSE].LOT3
idwDet.istCol[37].sInvisible	= 	"O"
idwDet.istCol[37].sUpdate		= 	"N"
idwDet.istCol[37].sCle			= 	"N"

idwDet.istCol[38].sDbName		=	"w_detail.mt_val_publique"
idwDet.istCol[38].sResultSet	=	"mt_val_publique"
idwDet.istCol[38].sType			=	"decimal(2)"
idwDet.istCol[38].sHeaderName	=	"Val Publique "
idwDet.istCol[38].ilargeur		=	11
idwDet.istCol[38].sAlignement	=	"0"
idwDet.istCol[38].sFormat		=	"#,##0.00 \"+stGlb.sMonnaieSymboleDesire // #1 [SUISSE].LOT3
idwDet.istCol[38].sInvisible	= 	"O"
idwDet.istCol[38].sUpdate		= 	"N"
idwDet.istCol[38].sCle			= 	"N"

idwDet.istCol[39].sDbName		=	"w_detail.num_facture"
idwDet.istCol[39].sResultSet	=	"num_facture"
idwDet.istCol[39].sType			=	"char(35)"
idwDet.istCol[39].sHeaderName	=	"Num Fact. "
idwDet.istCol[39].ilargeur		=	35
idwDet.istCol[39].sAlignement	=	"0"
idwDet.istCol[39].sFormat		=	""
idwDet.istCol[39].sInvisible	= 	"O"
idwDet.istCol[39].sUpdate		= 	"N"
idwDet.istCol[39].sCle			= 	"N"

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window de d$$HEX1$$e900$$ENDHEX$$tail                             */
/*------------------------------------------------------------------*/
idwDet.Uf_Creer_Tout( idwDet.istCol, sTables, iTrTrans )

/*------------------------------------------------------------------*/
/* La DataWindow de d$$HEX1$$e900$$ENDHEX$$tail sera tri$$HEX1$$e900$$ENDHEX$$e sur                           */
/*------------------------------------------------------------------*/
idwDet.isTri = "ID_DETAIL A"

/*------------------------------------------------------------------*/
/* La premi$$HEX1$$e800$$ENDHEX$$re ligne est s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e par d$$HEX1$$e900$$ENDHEX$$faut.                   */
/*------------------------------------------------------------------*/
idwDet.Uf_Activer_Selection ( True )

/*------------------------------------------------------------------*/
/* Modification DBI le 22/10/1998                                   */
/* Affichage de l'id_evt sous forme de DDDw                         */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Il y a un un sharedate d'effectu$$HEX2$$e9002000$$ENDHEX$$sur initialisation de la       */
/* fen$$HEX1$$ea00$$ENDHEX$$tre des garanties                                            */
/*------------------------------------------------------------------*/
idwDet.Modify ( "id_evt.dddw.name=dddw_sp_sin_code_condition_evt 	" + &
					 "id_evt.dddw.displaycolumn=lib_code 					" + &
					 "id_evt.dddw.datacolumn=id_code" )




end subroutine

on u_gs_sp_sinistre_creer_lst_detail.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_gs_sp_sinistre_creer_lst_detail.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

