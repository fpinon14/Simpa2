$PBExportHeader$w_sp_gs_w_commande3.srw
$PBExportComments$Fenêtre en dessous du niveau détail permettant de passer une commande
forward
global type w_sp_gs_w_commande3 from w_8_traitement_detail
end type
type dw_type_article from datawindow within w_sp_gs_w_commande3
end type
type dw_article from datawindow within w_sp_gs_w_commande3
end type
type dw_article_prs from datawindow within w_sp_gs_w_commande3
end type
type gb_2 from groupbox within w_sp_gs_w_commande3
end type
type dw_bandeau from datawindow within w_sp_gs_w_commande3
end type
type gb_3 from groupbox within w_sp_gs_w_commande3
end type
type p_curseur from picture within w_sp_gs_w_commande3
end type
type cb_prec from commandbutton within w_sp_gs_w_commande3
end type
type cb_suiv from commandbutton within w_sp_gs_w_commande3
end type
type dw_commande from u_datawindow_detail within w_sp_gs_w_commande3
end type
type dw_fournisseur from datawindow within w_sp_gs_w_commande3
end type
type gb_1 from groupbox within w_sp_gs_w_commande3
end type
type cb_commune_livr from commandbutton within w_sp_gs_w_commande3
end type
type cb_commune_fact from commandbutton within w_sp_gs_w_commande3
end type
type cb_imei from commandbutton within w_sp_gs_w_commande3
end type
type cb_dern from commandbutton within w_sp_gs_w_commande3
end type
type cb_prem from commandbutton within w_sp_gs_w_commande3
end type
type aff_pg_cmd_t from statictext within w_sp_gs_w_commande3
end type
type pb_tout from picturebutton within w_sp_gs_w_commande3
end type
type st_altpec from statictext within w_sp_gs_w_commande3
end type
type st_mode_reprise from statictext within w_sp_gs_w_commande3
end type
type cb_aide_mode_reprise from commandbutton within w_sp_gs_w_commande3
end type
type uo_equiv_fonct from u_sp_ifr_pilote within w_sp_gs_w_commande3
end type
end forward

global type w_sp_gs_w_commande3 from w_8_traitement_detail
integer width = 3575
integer height = 1976
event ue_taillefenetre ( )
dw_type_article dw_type_article
dw_article dw_article
dw_article_prs dw_article_prs
gb_2 gb_2
dw_bandeau dw_bandeau
gb_3 gb_3
p_curseur p_curseur
cb_prec cb_prec
cb_suiv cb_suiv
dw_commande dw_commande
dw_fournisseur dw_fournisseur
gb_1 gb_1
cb_commune_livr cb_commune_livr
cb_commune_fact cb_commune_fact
cb_imei cb_imei
cb_dern cb_dern
cb_prem cb_prem
aff_pg_cmd_t aff_pg_cmd_t
pb_tout pb_tout
st_altpec st_altpec
st_mode_reprise st_mode_reprise
cb_aide_mode_reprise cb_aide_mode_reprise
uo_equiv_fonct uo_equiv_fonct
end type
global w_sp_gs_w_commande3 w_sp_gs_w_commande3

type variables
Private :

n_cst_w_commande3	invCmd
String			isTypeTrt
String			isBtClick
String			isChoixAction
String 			isTypApp

Boolean			ibAltCommune   // DCMP 030362 Gestion des commune O/N
Boolean			ibTrigger_RFC_TypArt

u_DataWindow_Detail	idwCmdeSin

/*--------------------------------------------------------------------*/
/* CAG 06/01/04 : ajout de boutons prem et dern */
/*--------------------------------------------------------------------*/
Integer			iiNbMaxPg 	//  nbre de pages max à gérer
Integer 			iiNbMinPg
Integer			iiCptPgCte	//  compteur de page courante

DataWindow		idwAutorisation

u_DataWindow		idwWDivsin


end variables

forward prototypes
private function boolean wf_preparerinserer ()
public function boolean wf_controler ()
public function boolean wf_preparervalider ()
public function integer wf_positionnerobjets ()
private subroutine wf_passage_euro ()
private subroutine wf_boutons (integer ainumpg, string asbouton)
end prototypes

event ue_taillefenetre();//*-----------------------------------------------------------------
//*
//* Objet 			: Ue_TailleFenetre
//* Evenement 		: Ue_TailleFenetre
//* Auteur			: Fabry JF
//* Date				: 16/10/2019
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

// Je réajuste la hauteur pour W10

// This.Height = 1810 // [PB2022_TAILLE_FEN] Je commente

st_Titre.X     = 851
st_Titre.Y     =   20
st_Titre.Width = 1450
st_Titre.Height=  115


end event

private function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Contact::wf_PreparerInserer
//* Evenement 		: wf_PreparerInserer
//* Auteur			: Fabry JF
//* Date				: 18/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  CAG	  06/01/04  Ajout de boutons prem et dern : chgt d'arg de wf_boutons
//* #2  JFF   20/12/07  [O2M]
//* #3  JFF	  09/06/08  [DCMP070798]
//*     JFF	  29/11/10  [PC474]
//      JFF   23/05/2012 [PM103][1]
//		FPI	19/08/2015	[REPAR_GTI] - pour une réparation on n'active pas la page d'équiv fonct
//       JFF   17/05/2016 [PM280-2]
//       JFF   17/09/2019 [DT447]
//        JFF   12/02/2025   [HUB875]
//*-----------------------------------------------------------------

s_Pass  stPass
Boolean	bDroit204, bParamDP79, bCDiscount 
This.Title =  istPass.sTab[ 1 ] + " / Commandes"
Long lRow, lDeb, lFin, lIdEvt

// [PM280-2]
lIdEvt = istPass.dwMaster1.GetItemNumber ( 1, "ID_EVT" ) 

stPass.sTab [ 1 ]	= istPass.sTab [ 4 ]  // n° IMEI provenant de l'adhésion (a pu être modifié depuis l'ouverture du sinistre)
stPass.sTab [ 2 ]	= istPass.sTab [ 5 ]  // Marque portable adhésion.
stPass.sTab [ 3 ]	= istPass.sTab [ 6 ]  // Modèle portable adhésion.
stPass.sTab [ 4 ]	= istPass.sTab [ 7 ]  // DCMP 030407 n° IMEI provenant de l'adhésion (N'A PAS ETE modifié depuis l'ouverture du sinistre)
stPass.sTab [ 5 ]	= istPass.sTab [ 8 ]  // Choix Action "C"ommander/"S"électionner courrier
stPass.sTab [ 6 ]	= istPass.sTab [ 9 ]  // Cas de Gestion DARTY NOMADE

stPass.bTab [ 3 ]	= istPass.bTab [ 3 ]  // [DT447] Bris Ecran O/N


ibTrigger_RFC_TypArt = TRUE

/*------------------------------------------------------------------*/
/* On commande ou on sélectionne pour le courrier                   */
/*------------------------------------------------------------------*/
isChoixAction = istPass.sTab[8]

Choose Case isChoixAction 
	Case "C"
		st_Titre.Text = "Commander un appareil"		
	Case "S"
		st_Titre.Text = "Sélection sur courrier"		
	Case "R"
		st_Titre.Text = "Réparer un appareil"
		
		// [HUB875]
		If F_CLE_A_TRUE ( "HUB875" ) Then		
			F_RechDetPro ( lDeb, lFin, istPass.dwNorm [8], istPass.dwNorm [2].GetItemNumber ( 1, "ID_PROD" ), "-DP", 393 )
			If lDeb > 0 Then
				Choose Case lIdEvt
					Case 1491
						st_Titre.Text = "Ordre de service vers le HUB"
				End Choose
			End If 				
		End If 
		
	Case "I"
		st_Titre.Text = "Envoyer des informations"		

		// [HUB875]
		If F_CLE_A_TRUE ( "HUB875" ) Then				
			F_RechDetPro ( lDeb, lFin, istPass.dwNorm [8], istPass.dwNorm [2].GetItemNumber ( 1, "ID_PROD" ), "-DP", 393 )
			If lDeb > 0 Then
				Choose Case lIdEvt
					Case 1491
						st_Titre.Text = "Complèment d’infos vers le HUB"
				End Choose
			End If 				
		End If 

End Choose 

/*------------------------------------------------------------------*/
/* Disponibilité bouton tout pouvoir.                               */
/* Droit 204 dans table Autorisation (-NA)								  */
/*------------------------------------------------------------------*/
bDroit204 = idwAutorisation.Find ( "ID_NAT_OPER = 204", 1, idwAutorisation.RowCount () ) > 0 

// #2 On ajoute en plus le droit 79 
F_RechDetPro ( lDeb, lFin, istPass.dwNorm [8], istPass.dwNorm [2].GetItemNumber ( 1, "ID_PROD" ), "-DP", 79 )
bParamDP79 = lDeb > 0 
pb_tout.Enabled = bDroit204 And isChoixAction <> "R" And isChoixAction <> "I" And bParamDP79  // #2

/*------------------------------------------------------------------*/
/* #1 CAG : 06/01/2004										                 */
/*------------------------------------------------------------------*/
iiCptPgCte = 0

/*------------------------------------------------------------------*/
/* Si Typ appareil = AUT, pas de première page.                     */
/*------------------------------------------------------------------*/
lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, idwWDivSin.RowCount () ) 
If lRow > 0 Then 
	isTypApp = Upper ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) )
	If IsNull ( isTypApp) Then isTypApp = "AUT" 
End If

// #2
F_RechDetPro ( lDeb, lFin, istPass.dwNorm [8], istPass.dwNorm [2].GetItemNumber ( 1, "ID_PROD" ), "-DP", 37 )
bCDiscount = lDeb > 0 
// :#2
 
// [PC474]
//If isChoixAction = "S" Or ( isChoixAction = "I" And bCDiscount ) Then
If isChoixAction = "S" Then
	iiNbMaxPg  = 2
Else
	iiNbMaxPg  = 3
End IF

/* #3 [DCMP070798]
If isTypApp <> "TEL" Then
	iiNbMinPg  = 2
Else
	iiNbMinPg  = 1
End IF
*/

Choose Case isTypApp 
	Case "TEL", "PC2"
		// [REPAR_GTI] - pour une réparation on n'active pas la page d'équiv fonct
		if isChoixaction="R" Or lIdEvt = 1426 Then 
			iiNbMinPg  = 2
		// [HUB875]			
		ElseIf F_CLE_A_TRUE ( "HUB875" ) And isChoixaction="I" Then
			iiNbMinPg  = 2
		else 
			iiNbMinPg  = 1
		End if
		// :[REPAR_GTI] 
	Case Else
		iiNbMinPg  = 2
End Choose
// :#3 [DCMP070798]

This.wf_Boutons ( iiNbMinPg, "" )

// [PM103][1]
// A supprimer quand ce sera en prod
cb_aide_mode_reprise.Visible = FALSE
st_mode_reprise.Visible = FALSE
cb_aide_mode_reprise.Visible = invCmd.uf_GetAutorisation ( 223 )
st_mode_reprise.Visible = invCmd.uf_GetAutorisation ( 223 )
// :[PM103][1]

invCmd.uf_PreparerInserer ( stPass )

// [PM280-2]
If lIdEvt = 1426 Then
	cb_suiv.TriggerEvent(Clicked!)
	cb_prec.TriggerEvent(Clicked!)
End If

Return True
end function

public function boolean wf_controler ();//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Commande3::wf_Controler
//* Evenement 		: wf_controler
//* Auteur			: Fabry JF
//* Date				: 18/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  CAG	  06/01/04  Ajout de boutons prem et dern : chgt d'arg de wf_boutons
//* #2  JFF	  06/02/2006  [SITE_CMDE] Gestion des nouvelles option d'autorisation 79, 80, 81
//*			FPI 16/06/2010	 [Bug.Char13_Probleme]
//*-----------------------------------------------------------------

String sPos
Int	 iRet
Long	 lCpt
Boolean	bRet

This.SetRedraw ( False )

For lCpt = 1 To 2

	/*------------------------------------------------------------------*/
	/* Contrôle de saisie.                                              */
	/*------------------------------------------------------------------*/
	If lCpt = 1 Then
		Choose Case isChoixAction 
			Case "C", "R" 
				sPos = invCmd.uf_ControlerSaisie ()
			Case "I"
				sPos = invCmd.Uf_ControlerSaisieEDI ()
			Case "S"
				sPos = invCmd.Uf_ControlerSaisieSelection ()
		End Choose 
	End If

	/*------------------------------------------------------------------*/
	/* Contrôle de Gestion.                                             */
	/*------------------------------------------------------------------*/
	If lCpt = 2 Then
		Choose Case isChoixAction 
			Case "C", "R" 
				sPos = invCmd.uf_ControlerGestion ()
			Case "I"
				sPos = invCmd.uf_ControlerGestionEDI ()
			Case "S"
				sPos = invCmd.Uf_ControlerGestionSelection ()
		End Choose 
	End If

	If sPos <> "" Then

		/*------------------------------------------------------------------*/
		/* Quelle dataobject afficher ?												  */
		/*------------------------------------------------------------------*/
		CHOOSE CASE Left ( sPos, 1 )
			CASE "D"
				This.wf_Boutons ( 3, "" )
				sPos = Right ( sPos, Len ( sPos ) - 1 )

				If sPos <> "" Then dw_Commande.SetColumn ( sPos )
				dw_Commande.SetFocus ()

			CASE "G"
				invCmd.uf_RowFocusChanged ( "DWFOURN" )
				This.wf_Boutons ( 2, "" )
				dw_Fournisseur.SetFocus ()

		END CHOOSE

		bRet = False
		Exit
	Else
		bRet = True
		This.wf_Boutons ( 2, "" )
		invCmd.uf_RowFocusChanged ( "DWFOURN" )
		dw_Fournisseur.SetFocus ()
	End If
Next


invCmd.uf_epuration_probleme( ) //  [Bug.Char13_Probleme]

dw_Article.SetRedraw ( True ) // #2
dw_Article_Prs.SetRedraw ( True ) // #2
dw_Fournisseur.SetRedraw ( True ) // #2
dw_Type_Article.SetRedraw ( True ) // #2

This.SetRedraw ( True )


Return bRet


end function

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Contact::wf_PreparerInserer
//* Evenement 		: wf_PreparerInserer
//* Auteur			: Fabry JF
//* Date				: 18/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Return invCmd.uf_PreparerValider ( )


end function

public function integer wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Sp_Gs_Commande3::Wf_PositionnerObjets
//* Auteur			: Fabry JF
//* Date				: 26/09/2001
//* Libellé			: 
//* Commentaires	: Positionnement des objets
//*
//* Arguments		: Rien
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* 
//* #1	 CAG		05/01/04		Modif gestion des boutons prec et suiv
//*								 (ajout boutons prem et dern + zone affichage)
//* #2    JFF   04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
//*-----------------------------------------------------------------

dw_Commande.x		= 60
dw_Commande.y		= 189
dw_Commande.width	= 3489
dw_Commande.height	= 1421

dw_bandeau.x		= 55
dw_bandeau.y		= 197
dw_bandeau.width	= 3489
dw_bandeau.height	= 137

dw_fournisseur.x	= 97
dw_fournisseur.y	= 349
dw_fournisseur.width	= 1454
dw_fournisseur.height	= 597

dw_type_article.x	= 97
dw_type_article.y	= 1021
dw_type_article.width	= 1454
dw_type_article.height	= 597

dw_article.x		= 1623
dw_article.y		= 353
dw_article.width	= 1884
dw_article.height	= 1245

dw_article_prs.x	= 1623
dw_article_prs.y	= 353
dw_article_prs.width	= 1884
dw_article_prs.height	= 1245

/*------------------------------------------------------------------*/
/* #1 : CAG 05/01/2004                                              */
/*------------------------------------------------------------------*/
cb_prem.x		= 2849
cb_prem.y		= 73
cb_prem.width	= 161
cb_prem.height	= 65

cb_prec.x		= 3013
cb_prec.y		= 73
cb_prec.width	= 161
cb_prec.height	= 65

cb_suiv.x		= 3178
cb_suiv.y		= 73
cb_suiv.width	= 161
cb_suiv.height	= 65

cb_dern.x		= 3342
cb_dern.y		= 73
cb_dern.width	= 161
cb_dern.height	= 65

aff_pg_cmd_t.x	= 3054
aff_pg_cmd_t.y	= 137

gb_1.x			= 69
gb_1.y			= 301
gb_1.width		= 1505
gb_1.height		= 665

gb_2.x			= 69
gb_2.y			= 969
gb_2.width		= 1505
gb_2.height		= 669

gb_3.x			= 1596
gb_3.y			= 301
gb_3.width		= 1934
gb_3.height		= 1337

cb_commune_livr.x		= 1648
cb_commune_livr.y		= 795
cb_commune_livr.width	= 83
cb_commune_livr.height	= 73


cb_commune_fact.Hide () // Cacher car l'adresse de facturation n'est plus nécéssaire.
cb_commune_fact.x		= 3400
cb_commune_fact.y		= 795
cb_commune_fact.width	= 83
cb_commune_fact.height	= 73

//cb_Imei.x		= 1943
//cb_Imei.y		= 9
//cb_Imei.width	= 595
//cb_Imei.height	= 137

pb_Tout.X		= 2587
pb_Tout.Y		= 8
pb_Tout.width	= 251
pb_Tout.height	= 136

// #2
st_altpec.X = 2331
st_altpec.Y = 8
st_altpec.Width = 247
st_altpec.Height = 136

st_Titre.X     = 851
st_Titre.Y     =   45
st_Titre.Width = 1455
st_Titre.Height=  109

uo_equiv_fonct.X     = 23
uo_equiv_fonct.Y     = 221
uo_equiv_fonct.Width = 3484
uo_equiv_fonct.Height= 1453

// [PM103][1]
st_mode_reprise.X = 1006
st_mode_reprise.Y = 144
st_mode_reprise.Width = 933
st_mode_reprise.Height = 56

cb_aide_mode_reprise.X = 1943
cb_aide_mode_reprise.Y = 140
cb_aide_mode_reprise.Width = 178
cb_aide_mode_reprise.Height = 64
// :[PM103][1]

Return 1
end function

private subroutine wf_passage_euro ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_sp_gs_w_commande3::wf_Passage_Euro (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 24/03/1999 10:34:41
//* Libellé			: 
//* Commentaires	: Modification des colonnes qui ne peuvent être modifiée
//*					  par l'objet de Daniel.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1	PHG	15/02/2008 [SUISSE].LOT3 Gestion Dynamique de la monnaie

String sFormat

// #1 [SUISSE].LOT3 Gestion Dynamique de la monnaie
//CHOOSE CASE stGLB.sMonnaieFormatDesire
//	CASE "E"
//		sFormat = ".Format='#,##0.00 \€'"
//	CASE "F"
//		sFormat = ".Format='#,##0.00 \F'"
//END CHOOSE
//remplacé par
sFormat = ".Format='#,##0.00 \" + stGLB.sMonnaieSymboleDesire+ "'"

dw_Article.Modify ( "mt_prix_ttc" + sFormat )
dw_Article_Prs.Modify ( "mt_prix_ttc" + sFormat )




end subroutine

private subroutine wf_boutons (integer ainumpg, string asbouton);//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Contact::wf_Boutons
//* Evenement 		: wf_Boutons
//* Auteur			: Fabry JF
//* Date				: 18/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//* Arguments	   : ( Val )	Integer	aiNumPg	:	indique la page sur laquelle on se positionne (0 si appui sur un bouton)
//*					  ( Val )	String	asBouton	:	indique le bouton sur lequel on a appuyé (vide si on se positionne sur une pg précise)
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF   31/12/03  DCMP 030483 				  
//* #2  CAG	  06/01/04  Ajout de boutons prem et dern : chgt d'arguments
//*-----------------------------------------------------------------

Boolean	bVisible

/*------------------------------------------------------------------*/
/* #2 CAG : 06/01/2004										                 */
/*------------------------------------------------------------------*/
If aiNumPg = iiCptPgCte Then Return

If aiNumPg = 0 Then
	Choose Case asBouton
		Case "PREM"
			iiCptPgCte = iiNbMinPg
		Case "PREC"
			iiCptPgCte --
		Case "SUIV"
			iiCptPgCte ++
		Case "DERN"
			iiCptPgCte = iiNbMaxPg
	End Choose
Else
	iiCptPgCte = aiNumPg
End If

This.SetRedraw ( FALSE )

/*------------------------------------------------------------------*/
/* #2 CAG : 06/01/2004										                 */
/*------------------------------------------------------------------*/
/* Gestion des boutons de défilement de page								  */
/*------------------------------------------------------------------*/
Choose Case TRUE
	Case (iiCptPgCte = iiNbMaxPg) And (iiCptPgCte = iiNbMinPg)
		cb_Prem.Enabled = FALSE
		cb_Prec.Enabled = FALSE
		cb_Suiv.Enabled = FALSE
		cb_Dern.Enabled = FALSE
	Case iiCptPgCte = iiNbMinPg
		cb_Prem.Enabled = FALSE
		cb_Prec.Enabled = FALSE
		cb_Suiv.Enabled = TRUE
		cb_Dern.Enabled = TRUE
	Case iiCptPgCte = iiNbMaxPg
		cb_Prem.Enabled = TRUE
		cb_Prec.Enabled = TRUE
		cb_Suiv.Enabled = FALSE
		cb_Dern.Enabled = FALSE
	Case Else
		cb_Prem.Enabled = TRUE
		cb_Prec.Enabled = TRUE
		cb_Suiv.Enabled = TRUE
		cb_Dern.Enabled = TRUE
End Choose

/*------------------------------------------------------------------*/
/* Par défaut on rends tout non visible                             */
/*------------------------------------------------------------------*/
dw_Commande.visible 		= FALSE
cb_Commune_Livr.visible = FALSE
cb_Commune_Fact.visible = FALSE
dw_Fournisseur.visible  = FALSE
dw_Type_Article.visible = FALSE
dw_Article.visible 		= FALSE
dw_Article_Prs.visible  = FALSE
dw_bandeau.visible      = FALSE
gb_1.visible 				= FALSE
gb_2.visible 				= FALSE
gb_3.visible 				= FALSE
uo_equiv_fonct.Visible  = FALSE
cb_Commune_Livr.Enabled = FALSE

/*------------------------------------------------------------------*/
/* Les AcceptText quelques soit la page.                            */
/*------------------------------------------------------------------*/
dw_Article.AcceptText ()
dw_Article_Prs.AcceptText ()
dw_Commande.AcceptText ()

/*------------------------------------------------------------------*/
/* Par la suite, selon le cas on ne rends visible que ce qui doit   */
/* l'être                                                           */
/*------------------------------------------------------------------*/
Choose Case iiCptPgCte
	Case 1
		uo_equiv_fonct.Visible  = TRUE

	Case 2
		dw_Fournisseur.visible  = TRUE
		dw_Type_Article.visible = TRUE
		dw_Article.visible 		= TRUE
		dw_Article_Prs.visible  = TRUE
		dw_bandeau.visible      = TRUE
		gb_1.visible 				= TRUE
		gb_2.visible 				= TRUE
		gb_3.visible 				= TRUE

	Case 3
		dw_Commande.visible 		= TRUE
		cb_Commune_Livr.visible = TRUE
		cb_Commune_Livr.Enabled = ibAltCommune

		cb_Commune_Livr.Bringtotop = TRUE


End Choose

/*------------------------------------------------------------------*/
/* Traitement spéciaux et raffraîchissement                         */
/*------------------------------------------------------------------*/
Choose Case iiCptPgCte
	Case 1

		uo_Equiv_Fonct.SetRedraw ( TRUE )

	Case 2
		dw_Fournisseur.SetRedraw ( True )
		dw_Type_Article.SetRedraw ( True )
		dw_Article.SetRedraw ( True )
		dw_Article_Prs.SetRedraw ( True )
		dw_bandeau.SetRedraw ( True )
		dw_Fournisseur.SetFocus ()
		invCmd.Uf_RowfocusChanged ( "DWTYPART" )

		gb_1.BringToTop			= FALSE
		gb_2.BringToTop			= FALSE
		gb_3.BringToTop			= FALSE


	Case 3
		dw_Commande.SetRedraw ( True )

		/*------------------------------------------------------------------*/
		/* # Modification SFR # Le 10/09/2002.                              */
		/*------------------------------------------------------------------*/
		/* # CAG : Remplacement de ADR_NOM par ADR_COD_CIV                  */
		/*------------------------------------------------------------------*/
		dw_Commande.Setcolumn ( "ADR_COD_CIV" )
		dw_Commande.SetFocus ()
End Choose

/*------------------------------------------------------------------*/
/* #2 CAG : 06/01/2004										                 */
/*------------------------------------------------------------------*/
Aff_Pg_Cmd_t.Text = "page " + String ( iiCptPgCte ) + " / " + String ( iiNbMaxPg )

This.SetRedraw ( TRUE )

end subroutine

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Contact::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  CAG	 25/02/2003 Suite DCMP 030027 : Ajout de dw sur Det_Pro
//* #2  JFF  04/06/2007 [DCMP070163-070164-070248-070318] Gestion Prise en charge
//* #3  JFF  13/02/2008 [FNAC_PROD_ECH_TECH].[20090224144248310]
//*-----------------------------------------------------------------

s_Pass	stPass
//Migration PB8-WYNIWYG-03/2006 FM
//DataWindow	dwPassageEuro[3]
DataWindow	dwPassageEuro[]
//Fin Migration PB8-WYNIWYG-03/2006 FM
DataWindow	dwTab1, dwTab2, dwTab3
Long	lDeb, lFin

Wf_PositionnerObjets ()

Wf_ActiverModeDetail ( True )
dw_fournisseur.SetRowFocusIndicator ( p_curseur,1,5 )
dw_type_article.SetRowFocusIndicator ( p_curseur,1,5 )

idwWDivsin = istPass.udwTab [ 1 ]

/*------------------------------------------------------------------*/
/* Le bouton de récupération de l'IMEI adh corrigé n'est            */
/* disponible que sur Option.                                       */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, istPass.dwNorm [8], istPass.dwNorm [2].GetItemNumber ( 1, "ID_PROD" ), '-DP', 7 )
cb_Imei.Enabled = lDeb > 0

/*------------------------------------------------------------------*/
/* Nous sommes en saisie (S) ou en Consultation/Validation (C)(V)   */
/* Bien que cette fenêtre n'apparaîtra qu'en Saisie.					  */
/*------------------------------------------------------------------*/
isTypeTrt = istPass.sTab[ 2 ]

/*------------------------------------------------------------------*/
/* DCMP 030362 : Accès ou pas au contrôle des communes.             */
/*------------------------------------------------------------------*/
ibAltCommune = istPass.bTab[ 2 ]
stPass.bTab [1] = ibAltCommune 

/*------------------------------------------------------------------*/
/* On commence à initialiser les NVUO.                              */
/*------------------------------------------------------------------*/
invCmd = Create n_cst_w_commande3

stPass.dwTab  [1] = dw_commande			 // dw_commande en local sur cette fenêtre.
stPass.dwTab  [2]	= istPass.dwTab [2]   // LSt Inter

stPass.dwTab  [3]	= istPass.dwTab [4]	 // dw_w_Commande au niveau sinistre pour récupérer les DDDW en Share.
idwCmdeSin = istPass.dwTab [4]

stPass.lTab   [1] = istPass.lTab [1]   // ilMarquaGeBLCODE = // [BLCODE]


stPass.dwTab  [4]	= istPass.dwTab [3]	 // dw_w_Commande au niveau du détail, on y remontera les lignes.
stPass.dwTab  [5]	= istPass.dwTab [5]	 // dw_w_Commande au niveau garantie
stPass.dwTab  [6]	= istPass.dwTab [6]	 // dw_w_div_det  au niveau détail // #2
stPass.dwTab  [7]	= istPass.dwTab [7]	 // idwLstDetail  // [BLCODE]

stPass.dwNorm [1] = dw_Fournisseur
stPass.dwNorm [2] = dw_Type_Article
stPass.dwNorm [3] = dw_Article
stPass.dwNorm [4] = dw_Bandeau
stPass.dwNorm [5]	= istPass.dwNorm [1]  // DataWindow PLAFOND
stPass.dwNorm [6]	= dw_Article_Prs
stPass.dwNorm [7]	= istPass.dwNorm [2]  // DataWindow PRODUIT
stPass.dwNorm [8]	= istPass.dwNorm [3]  // DataWindow INFO COMMANDE
stPass.dwNorm [9]	= istPass.dwNorm [4]  // DataWindow sur COMMANDE_TYPE, pour le choix des fournisseurs
stPass.dwNorm [10]= istPass.dwNorm [5]  // DataWindow sur COMMANDE_TYPE, pour le choix des articles

stPass.dwNorm [11]= istPass.dwNorm [9]  // DataWindow des communes
stPass.dwNorm [12]= istPass.dwNorm [10]  // DataWindow des TAC_IMEI
stPass.dwNorm [13]= istPass.dwNorm [ 11 ]  // Dw des Données IFR
stPass.dwNorm [14]= istPass.dwNorm [ 12 ]  // Dw des Libellés IFR Traduits
stPass.dwNorm [15]= istPass.dwNorm [ 13 ] // Table autorisation

//* #3 [FNAC_PROD_ECH_TECH].[20090224144248310]
stPass.dwNorm [16]= istPass.dwNorm [ 14 ] // Pièce cochée sur la garantie


// #2
stPass.sttab  [1] = st_altpec

idwAutorisation = istPass.dwNorm [ 13 ] // Table autorisation

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002. + CAG 12/09/02 : à compléter : dwTabX à initialiser */
/*------------------------------------------------------------------*/
invCmd.Uf_Initialiser_Dw_Sfr ( istPass.dwNorm [6], istPass.dwNorm [7], dwTab1, dwTab2, dwTab3, FALSE )

/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
invCmd.Uf_Initialiser_Dw ( istPass.dwNorm [2], istPass.dwNorm [8], False )

stPass.dwMaster  = istPass.dwMaster       // Fen Sinistre de plus niveau
stPass.dwMaster1 = istPass.dwMaster1      // Dw_1 sur fen Detail afin de récupérer ID_GTI, ID_DETAIL

stPass.udwTab [ 1 ] = istPass.udwTab [ 1 ]   // Dw_w_Div_Sin
stPass.udwTab [ 2 ] = istPass.udwTab [ 2 ]   // idwDivDetGti = // [BLCODE]

invCmd.uf_Initialiser ( stPass, uo_equiv_fonct )

/*------------------------------------------------------------------*/
/* Gestion du Passage à l'EURO.                                     */
/*------------------------------------------------------------------*/
N_Cst_Passage_Euro	nvPassageEuro

dwPassageEuro [ 1 ] = dw_Article
dwPassageEuro [ 2 ] = dw_Article_Prs
dwPassageEuro [ 3 ] = dw_bandeau

nvPassageEuro = CREATE N_Cst_Passage_Euro
nvPassageEuro.uf_Initialiser ( dwPassageEuro[] )

//Migration PB8-WYNIWYG-03/2006 FM
//DESTROY nvPassageEuro
If IsValid(nvPassageEuro) Then DESTROY nvPassageEuro
//Fin Migration PB8-WYNIWYG-03/2006 FM

// Les champs calculés ne peuvent être modifiés par cet Objet
wf_Passage_Euro ()


end event

on ue_item7;call w_8_traitement_detail::ue_item7;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_gs_Commande3
//* Evenement     : ue_item7
//* Auteur        : Fabry JF
//* Date          : 07/10/2004 09:57:42
//* Libellé       : Déclencher par un PostEvent, après tous les uf_RowFocusChanged 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

If iiNbMinPg <> 2 Then
	dw_article.Hide ()
	dw_article_prs.Hide ()
End If

invCmd.uf_Switch_CtrlSaisie ( FALSE )
end on

event ue_retour;//*****************************************************************************
//
// Objet 		: w_sp_gs_w_commande3 (OVERRIDE !!)
// Evenement 	: Ue_Retour
//	Auteur		: Fabry JF
//	Date			: 20/09/2001
// Libellé		: 
// Commentaires: 
// ----------------------------------------------------------------------------
// MAJ PAR		Date			Modification
//       JFF   07/05/2013 [PC938_ORANGE_V3]
//*****************************************************************************

// [PC938_ORANGE_V3]
If gProcessTempoOrangeV3Action Then
	gProcessTempoOrangeV3 = False
End If

If isBtClick = "RETOUR" Then 
	stMessage.sTitre  	= "Quitter la fenêtre de commandes"
	stMessage.Icon			= Question!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= YesNo!
	stMessage.sCode		= "COMD020"

	If F_Message ( stMessage ) = 1 Then 
		Call Super::ue_Retour
	End If

Else
	Call Super::ue_Retour
End If


invCmd.iuoEqvFct.uf_Filtrer_Init ()


end event

event show;call super::show;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_gs_Commande3
//* Evenement     : Show
//* Auteur        : Fabry JF
//* Date          : 31/12/2003 16:34:35
//* Libellé       : 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------


invCmd.uf_Switch_CtrlSaisie ( TRUE )

/*------------------------------------------------------------------*/
/* On cache dw_Article, car cette page n'est plus la première.      */
/*------------------------------------------------------------------*/
This.PostEvent ( "ue_item7" )
This.PostEvent ( "ue_TailleFenetre" )



end event

event ue_controler;//*****************************************************************************
//
// Objet 		: w_Traitement (OVERRIDE)
// Evenement 	: ue_Controler
//	Auteur		: Fabry JF
//	Date			: 20/09/01
// Libellé		: Controle des informations de la fenêtre
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//* #1  CAG	  06/01/04  Ajout de boutons prem et dern : chgt d'arg de wf_boutons
//*			FPI	20/10/2010	 [PC321] Correction si saisie dans problème
//*****************************************************************************


invCmd.uf_Switch_CtrlSaisie ( TRUE )

If	dw_Commande.AcceptText () > 0 Then
	If	dw_Article.AcceptText () > 0 Then
		If	dw_Article_Prs.AcceptText () > 0 Then
			If wf_AcceptText() Then
				If wf_Controler () Then wf_Pb_Ctl_Vld ( 1 )	
			End If
		Else
			This.wf_boutons ( 2, "" ) // [PC321] Correction si saisie dans problème (2 ald 1)
		End If
	Else
		This.wf_boutons ( 2, "" ) // [PC321] Correction si saisie dans problème
	End If
Else
	This.wf_boutons ( 2, "" )
End If

invCmd.uf_Switch_CtrlSaisie ( FALSE )


end event

on ue_item6;call w_8_traitement_detail::ue_item6;//*-----------------------------------------------------------------
//*
//* Objet         : w_sp_gs_w_commande3
//* Evenement     : ue_Item6
//* Auteur        : Fabry JF
//* Date          : 23/09/2003 17:22:30
//* Libellé       : Armement de l'IMEI de l'adhésion, corrigé
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

String sIMEIAdh, sIMEICorrige
Boolean bRet

sIMEIAdh = istPass.sTab [ 7 ]  

bRet = F_IMEI ( sIMEIAdh, sIMEICorrige )

/*------------------------------------------------------------------*/
/* Placement de l'IMEI Corrigé (ou pas) dans le clipboard.          */
/*------------------------------------------------------------------*/
ClipBoard ( sIMEICorrige )

/*------------------------------------------------------------------*/
/* S'il est bon sur l'adhésion												  */
/*------------------------------------------------------------------*/
If bRet Then
	stMessage.sCode		= "SFRP130"
	stMessage.sVar[1]		= sIMEICorrige 

/*------------------------------------------------------------------*/
/* S'il a été corrigé.                                              */
/*------------------------------------------------------------------*/
ElseIf Not bRet And sIMEICorrige <> "" Then
	stMessage.sCode		= "SFRP140"
	stMessage.sVar[1]		= sIMEICorrige 

/*------------------------------------------------------------------*/
/* Sinon                                                            */
/*------------------------------------------------------------------*/
Else 
	stMessage.sCode		= "SFRP150"

End If

stMessage.sTitre		= "Armement IMEI provenant de l'adhésion"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.Bouton		= Ok!


F_Message ( stMessage )


end on

event close;call super::close;//*****************************************************************************
//
// Objet 		: w_sp_gs_w_commande3
// Evenement 	: Destroy
//	Auteur		: La Recrue
//	Date			: 17/12/1996
// Libellé		: 
// Commentaires: 
// ----------------------------------------------------------------------------
// MAJ PAR		Date			Modification
//
//*****************************************************************************

//Migration PB8-WYNIWYG-03/2006 FM
//Destroy invCmd
If IsValid(invCmd) Then Destroy invCmd
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on ue_valider;//*****************************************************************************
//
// Objet 		: w_Traitement (OVERRIDE)
// Evenement 	: ue_Valider
//	Auteur		: FABRY JF
//	Date			: 24/09/2001
// Libellé		: 
// Commentaires: 
//					  
//*****************************************************************************

Pb_Valider.enabled = FALSE
Pb_Controler.enabled = FALSE
wf_PreparerValider ()
This.PostEvent( "ue_retour" )



end on

event we_childactivate;//*****************************************************************************
//
// Objet 		: w_Ancetre_Traitement (OVERRIDE !!!!)
// Evenement 	: we_ChildActivate
//	Auteur		: La Recrue
//	Date			: 17/12/1996
// Libellé		: 
// Commentaires: Est déclanché lorsque la fenêtre est montrée qu'elle soit de type
//					  Chil! ou Popup! effectue ce qui était coder sur l'Open
// ----------------------------------------------------------------------------
// MAJ PAR		Date			Modification
//
//*****************************************************************************

Boolean					bOk
w_traitement_master	wMasterParent
long	ll_ret

This.X			=    1
This.Y			=    1
// [PB2022_TAILLE_FEN] + xxx
This.Height		= 1769 + 90


// [PB2022_TAILLE_FEN] + xxx
This.Width		= 3598 + 50

If ( ibAInitialiser ) Then

	ibAInitialiser  = False

	istPass = Message.PowerObjectParm

	itrTrans						=  istPass.trTrans	// Objet transaction de la fenetre appelante
	iwParent						=	istPass.wParent	// Fenetre Appelante ( utilisée pour enable )	

	istPass.wParent			=	This			// Fenetre appelante pour fenetre de traitment
	istPass.trTrans			=	itrTrans		// Objet de transaction par defaut
//	istPass.bEnableParent	= 	False			// Doit on rendre la fenetre appelante disable
														// lors de l'appel d'une fenêtre de traitement	This.TriggerEvent ( "ue_Initialiser" )
//	istPass.bCloseRetour		=	False			// Doit on fermer la fenêtre sur le bouton retour. Décision du script client


	wf_ActiverMajAccueil( True )	

	// Si il s'agit d'une fenêtre fille d'un master on la stock pour pouvoir la fermer

	If ( ibOpen ) Then

//		If ( iwParent.WindowType = Child! ) Or ( iwParent.windowType = Popup! ) Then
//			wMasterParent = iwParent
//			wMasterParent.wf_AjouterDetail( This )
//		End If

		This.TriggerEvent ( "ue_Initialiser" )
		IbOpen = False

	End If

	If ( Not istPass.bEnableParent ) Then
		iwParent.TriggerEvent ( "ue_DisableFenetre" )
	End If

	// Initialisation des variables d'instance

	Dw_1.ibErreur 	= False
	Dw_1.isNomCol	= ""
	Dw_1.isErrCol	= ""

	// Positionnement des boutons Controle et valider

	If Not istPass.bControl Then

		wf_Pb_Ctl_Vld ( 1 )	// Directement bouton valider

	Else

		wf_Pb_Ctl_Vld ( 0 )	// Controle + Valide

	End If

	// Preparation avant affichage

	If istPass.bInsert Then

		pb_Supprimer.Enabled = False
		//Dw_1.Reset ()
		//Dw_1.InsertRow ( 0 )
		//f_CreeLe ( Dw_1, 1 )
		//f_MajPar ( Dw_1, 1 )
		bOk = wf_PreparerInserer ()
	
	Else

		pb_Supprimer.Enabled = istPass.bSupprime
		bOk = wf_PreparerModifier ()

	End If

	// Arrêt d'ouverture de la fenêtre si problème

	If Not bOk Then

		This.TriggerEvent ( "ue_retour" )
	Else
		wf_Changer_Controle( Dw_1 )

		If ( ibModeDetail ) Then

/*------------------------------------------------------------------*/
/* Uniquement pour que la datawindow puisse retrouver ses petits    */
/* lors d'un RowCopy. ( Bug Pb )                                    */
/*------------------------------------------------------------------*/

			ll_ret = dw_1.SetSort(dw_1.isTri)
			ll_ret = dw_1.Sort()

		End If

		This.Show()
		ll_ret = Dw_1.SetFocus ()

	End If

End If
end event

on w_sp_gs_w_commande3.create
int iCurrent
call super::create
this.dw_type_article=create dw_type_article
this.dw_article=create dw_article
this.dw_article_prs=create dw_article_prs
this.gb_2=create gb_2
this.dw_bandeau=create dw_bandeau
this.gb_3=create gb_3
this.p_curseur=create p_curseur
this.cb_prec=create cb_prec
this.cb_suiv=create cb_suiv
this.dw_commande=create dw_commande
this.dw_fournisseur=create dw_fournisseur
this.gb_1=create gb_1
this.cb_commune_livr=create cb_commune_livr
this.cb_commune_fact=create cb_commune_fact
this.cb_imei=create cb_imei
this.cb_dern=create cb_dern
this.cb_prem=create cb_prem
this.aff_pg_cmd_t=create aff_pg_cmd_t
this.pb_tout=create pb_tout
this.st_altpec=create st_altpec
this.st_mode_reprise=create st_mode_reprise
this.cb_aide_mode_reprise=create cb_aide_mode_reprise
this.uo_equiv_fonct=create uo_equiv_fonct
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_type_article
this.Control[iCurrent+2]=this.dw_article
this.Control[iCurrent+3]=this.dw_article_prs
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.dw_bandeau
this.Control[iCurrent+6]=this.gb_3
this.Control[iCurrent+7]=this.p_curseur
this.Control[iCurrent+8]=this.cb_prec
this.Control[iCurrent+9]=this.cb_suiv
this.Control[iCurrent+10]=this.dw_commande
this.Control[iCurrent+11]=this.dw_fournisseur
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.cb_commune_livr
this.Control[iCurrent+14]=this.cb_commune_fact
this.Control[iCurrent+15]=this.cb_imei
this.Control[iCurrent+16]=this.cb_dern
this.Control[iCurrent+17]=this.cb_prem
this.Control[iCurrent+18]=this.aff_pg_cmd_t
this.Control[iCurrent+19]=this.pb_tout
this.Control[iCurrent+20]=this.st_altpec
this.Control[iCurrent+21]=this.st_mode_reprise
this.Control[iCurrent+22]=this.cb_aide_mode_reprise
this.Control[iCurrent+23]=this.uo_equiv_fonct
end on

on w_sp_gs_w_commande3.destroy
call super::destroy
destroy(this.dw_type_article)
destroy(this.dw_article)
destroy(this.dw_article_prs)
destroy(this.gb_2)
destroy(this.dw_bandeau)
destroy(this.gb_3)
destroy(this.p_curseur)
destroy(this.cb_prec)
destroy(this.cb_suiv)
destroy(this.dw_commande)
destroy(this.dw_fournisseur)
destroy(this.gb_1)
destroy(this.cb_commune_livr)
destroy(this.cb_commune_fact)
destroy(this.cb_imei)
destroy(this.cb_dern)
destroy(this.cb_prem)
destroy(this.aff_pg_cmd_t)
destroy(this.pb_tout)
destroy(this.st_altpec)
destroy(this.st_mode_reprise)
destroy(this.cb_aide_mode_reprise)
destroy(this.uo_equiv_fonct)
end on

type cb_debug from w_8_traitement_detail`cb_debug within w_sp_gs_w_commande3
end type

type dw_1 from w_8_traitement_detail`dw_1 within w_sp_gs_w_commande3
boolean visible = false
integer x = 3982
integer y = 36
integer width = 238
integer height = 168
boolean enabled = false
boolean livescroll = false
end type

type st_titre from w_8_traitement_detail`st_titre within w_sp_gs_w_commande3
integer x = 850
integer y = 20
integer width = 1449
integer height = 108
integer textsize = -14
long textcolor = 8388608
long backcolor = 553648127
end type

type pb_retour from w_8_traitement_detail`pb_retour within w_sp_gs_w_commande3
integer x = 9
integer y = 8
integer width = 242
integer height = 144
integer taborder = 170
end type

event pb_retour::clicked;call super::clicked;//*****************************************************************************
//
// Objet 		: w_sp_gs_w_commande3 
// Evenement 	: Ue_Retour
//	Auteur		: Fabry JF
//	Date			: 20/09/2001
// Libellé		: 
// Commentaires: 
// ----------------------------------------------------------------------------
// MAJ PAR		Date			Modification
//*#8  JFF    27/01/2010   [DCMP090283].[20100203161827340]
//*****************************************************************************
isBtClick = "RETOUR"

// #8  [DCMP090283].[20100203161827340]
Choose Case gsCasGestion 
	Case "MAIL_SANS_PROPO", "MAIL_AVEC_PROPO"

		gsCasGestion = ""
		
End Choose
// :#8  [DCMP090283].[20100203161827340]

end event

type pb_valider from w_8_traitement_detail`pb_valider within w_sp_gs_w_commande3
integer x = 494
integer y = 8
integer width = 242
integer height = 144
integer taborder = 190
end type

on pb_valider::clicked;call w_8_traitement_detail`pb_valider::clicked;//*****************************************************************************
//
// Objet 		: w_sp_gs_w_commande3 
// Evenement 	: Ue_Valider
//	Auteur		: Fabry JF
//	Date			: 20/09/2001
// Libellé		: 
// Commentaires: 
// ----------------------------------------------------------------------------
// MAJ PAR		Date			Modification
//
//*****************************************************************************

isBtClick = "VALIDER"
end on

type pb_imprimer from w_8_traitement_detail`pb_imprimer within w_sp_gs_w_commande3
boolean visible = false
integer x = 3941
integer y = 248
integer taborder = 220
boolean enabled = false
end type

type pb_controler from w_8_traitement_detail`pb_controler within w_sp_gs_w_commande3
integer x = 251
integer y = 8
integer width = 242
integer height = 144
integer taborder = 180
end type

type pb_supprimer from w_8_traitement_detail`pb_supprimer within w_sp_gs_w_commande3
boolean visible = false
integer x = 3694
integer y = 248
integer taborder = 210
boolean enabled = false
end type

type dw_type_article from datawindow within w_sp_gs_w_commande3
event ue_rfc_true pbm_custom01
event ue_rfc_false pbm_custom02
boolean visible = false
integer x = 1070
integer y = 228
integer width = 261
integer height = 224
integer taborder = 150
string dataobject = "d_gs_commande_type_art"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

on ue_rfc_true;//*-----------------------------------------------------------------
//*
//* Objet         : dw_typ_article
//* Evenement     : ue_RFC_True
//* Auteur        : Fabry JF
//* Date          : 21/01/2005 15:09:16
//* Libellé       : autorise le RowFocusChanged
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

ibTrigger_RFC_TypArt = TRUE

end on

on ue_rfc_false;//*-----------------------------------------------------------------
//*
//* Objet         : dw_typ_article
//* Evenement     : ue_RFC_False
//* Auteur        : Fabry JF
//* Date          : 21/01/2005 15:09:16
//* Libellé       : n'autorise pas le RowFocusChanged
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

ibTrigger_RFC_TypArt = FALSE
end on

on rowfocuschanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Contact::RowFocusChanged
//* Evenement 		: RowFocusChanged
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

// Je met un IsValid, en effet une erreur bizarre
// apparaît sur cette fonction (objet à null) à la 
// fermeture de la fenêtre d'accueil sinistre ???

If ibTrigger_RFC_TypArt Then
	Parent.SetRedraw ( False )
	If IsValid ( invCmd ) Then invCmd.Uf_RowfocusChanged ( "DWTYPART" )
	Parent.SetRedraw ( True )
End If

end on

type dw_article from datawindow within w_sp_gs_w_commande3
boolean visible = false
integer x = 1737
integer y = 228
integer width = 261
integer height = 224
integer taborder = 230
string dataobject = "d_article1"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Contact::Clicked
//* Evenement 		: Clicked
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.SetRedraw ( False )
invCmd.uf_InfoArticle ( "DW_ARTICLE", "CLICK" )
Parent.SetRedraw ( True )

end on

event itemerror;//*****************************************************************************
//
// Objet 		: w_Traitement::DW_ARTICLE_PRS
// Evenement 	: ItemError
//	Auteur		: Fabry JF
//	Date			: 05/09/01
// Libellé		: Controle des zones
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//	#1 PHG	14/12/2007  [O2M] Gestion du retour de uf_gerermessage, pour interdire
//*									la saisie d'eventuel champs. ( info_spb_frn )
//*****************************************************************************

return invCmd.Uf_GererMessage ( "DW_ARTICLE" )
end event

event itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Commande2::ItemChanged
//* Evenement 		: ItemChanged
//* Auteur			: Fabry JF
//* Date				: 18/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

// [MIGPB8COR] PHG
// invCmd.Uf_ControlerZone ( "DW_ARTICLE", GetColumnName (), GetText (), GetRow () )
return invCmd.Uf_ControlerZone ( "DW_ARTICLE", GetColumnName (), GetText (), GetRow () )



end event

type dw_article_prs from datawindow within w_sp_gs_w_commande3
boolean visible = false
integer x = 1440
integer y = 228
integer width = 261
integer height = 224
integer taborder = 240
string dataobject = "d_article2"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event itemerror;//*****************************************************************************
//
// Objet 		: w_Traitement::DW_ARTICLE_PRS
// Evenement 	: ItemError
//	Auteur		: Fabry JF
//	Date			: 05/09/01
// Libellé		: Controle des zones
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
// 		FPI	15/07/2010	 [PC321] - Ajout du return
//*****************************************************************************

return invCmd.Uf_GererMessage ( "DW_ARTICLE_PRS" )
end event

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Contact::Clicked
//* Evenement 		: Clicked
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.SetRedraw ( False )
invCmd.uf_InfoArticle ( "DW_ARTICLE_PRS", "CLICK" )
Parent.SetRedraw ( True )

end on

event itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Commande2::ItemChanged
//* Evenement 		: ItemChanged
//* Auteur			: Fabry JF
//* Date				: 18/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

// [MIGPB8COR] PHG
//invCmd.Uf_ControlerZone ( "DW_ARTICLE_PRS", GetColumnName (), GetText (), GetRow () )
return invCmd.Uf_ControlerZone ( "DW_ARTICLE_PRS", GetColumnName (), GetText (), GetRow () )

end event

type gb_2 from groupbox within w_sp_gs_w_commande3
boolean visible = false
integer x = 1070
integer y = 500
integer width = 261
integer height = 116
integer taborder = 120
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_bandeau from datawindow within w_sp_gs_w_commande3
integer x = 78
integer y = 524
integer width = 293
integer height = 300
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_bandeau"
boolean border = false
boolean livescroll = true
end type

type gb_3 from groupbox within w_sp_gs_w_commande3
boolean visible = false
integer x = 1440
integer y = 504
integer width = 567
integer height = 116
integer taborder = 130
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type p_curseur from picture within w_sp_gs_w_commande3
boolean visible = false
integer x = 4261
integer y = 56
integer width = 73
integer height = 60
boolean bringtotop = true
string picturename = "k:\pb4obj\bmp\suiv.bmp"
boolean focusrectangle = false
end type

type cb_prec from commandbutton within w_sp_gs_w_commande3
integer x = 2235
integer y = 184
integer width = 160
integer height = 64
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = "3"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Contact::cb_Prec
//* Evenement 		: cb_Prec
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.wf_boutons ( 0, "PREC" )
end on

type cb_suiv from commandbutton within w_sp_gs_w_commande3
integer x = 2066
integer y = 252
integer width = 160
integer height = 64
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = "4"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Contact::cb_Suiv
//* Evenement 		: cb_Suiv
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.wf_boutons ( 0, "SUIV" )
end on

type dw_commande from u_datawindow_detail within w_sp_gs_w_commande3
event ue_retour pbm_custom01
event ue_init_par_defaut ( )
boolean visible = false
integer x = 425
integer y = 236
integer width = 261
integer height = 224
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_gs_w_commande3"
boolean border = false
boolean livescroll = false
end type

event ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Commande3::ue_retour
//* Evenement 		: ItemChanged
//* Auteur			: Fabry JF
//* Date				: 18/09/2001 17:59:48
//* Libellé			: Déclenché à partir de n_cst_w_commande3::uf_ExistenceMobile
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


isBtClick = ""
Parent.PostEvent ("ue_Retour", 1, 1 )


end event

event ue_Init_Par_defaut();//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Commande3::ue_Chgt_Fourn_Fct_Mobile
//* Evenement 		: ue_Chgt_Fourn_Fct_Mobile
//* Auteur			: Fabry JF
//* Date				: 03/09/2009
//* Libellé			: Déclenché à partir de n_cst_w_commande3::uf_ExistenceMobile
//* Commentaires	: Obligé de passer par ce biais cuase plantage PB sinon pour ouverture Response.
//*					  [DCMP090327].[SBETV]
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

invCmd.uf_InitParDefaut ( 2 )
end event

event itemerror;call super::itemerror;//*****************************************************************************
//
// Objet 		: w_Traitement::DW_ARTICLE_PRS
// Evenement 	: ItemError
//	Auteur		: Fabry JF
//	Date			: 05/09/01
// Libellé		: Controle des zones
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//	
//*****************************************************************************

return invCmd.Uf_GererMessage ( "DW_COMMANDE" )


end event

event itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Commande3::ItemChanged
//* Evenement 		: ItemChanged
//* Auteur			: Fabry JF
//* Date				: 18/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

// [MIGPB8COR] PHG
return invCmd.Uf_ControlerZone ( "DW_COMMANDE", GetColumnName (), GetText (), GetRow () )

end event

type dw_fournisseur from datawindow within w_sp_gs_w_commande3
event ue_share ( )
boolean visible = false
integer x = 763
integer y = 228
integer width = 261
integer height = 224
integer taborder = 160
boolean bringtotop = true
string dataobject = "d_gs_commande_type_frn"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_share();//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Commande3::ue_Share
//* Evenement 		: Ue_Share
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DatawindowChild dwChild, dwChild1

idwCmdeSin.GetChild ( "ID_FOUR", dwChild )
This.GetChild ( "ID_CODE_FRN", dwChild1)

dwChild.ShareData ( dwChild1 )
Parent.idwCmdeSin.SetRedraw (TRUE )

end event

on rowfocuschanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Contact::RowFocusChanged
//* Evenement 		: RowFocusChanged
//* Auteur			: Fabry JF
//* Date				: 04/09/2001 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

// Je met un IsValid, en effet une erreur bizarre
// apparaît sur cette fonction (objet à null) à la 
// fermeture de la fenêtre d'accueil sinistre ???

Parent.SetRedraw ( False )
If IsValid ( invCmd ) Then invCmd.Uf_RowfocusChanged ( "DWFOURN" )
Parent.SetRedraw ( True )


end on

type gb_1 from groupbox within w_sp_gs_w_commande3
boolean visible = false
integer x = 763
integer y = 500
integer width = 261
integer height = 116
integer taborder = 110
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type cb_commune_livr from commandbutton within w_sp_gs_w_commande3
integer x = 2066
integer y = 376
integer width = 82
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "..."
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet         : cb_Commune_livr
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 20/08/2003 17:07:58
//* Libellé       : Bouton d'ouverture de la fenêtre de recherche
//*					  des communes
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//        JFF   07/03/2024   [HP252_276_HUB_PRESTA]
//*-----------------------------------------------------------------

s_Commune	stCom			// Structure dw_Commune

// [HP252_276_HUB_PRESTA]
If F_CLE_A_TRUE ( "HP252_276_HUB_PRESTA" ) Then
	If invCmd.ibModifAdrInterdite Then Return
End If

This.Enabled = FALSE

stCom.dw_Commune =  istPass.dwNorm [9] 

/*------------------------------------------------------------------*/
/* Ouverture d'une Response.                                        */
/*------------------------------------------------------------------*/
OpenWithParm ( w_rech_Commune, stCom )

stCom = Message.PowerObjectParm

/*------------------------------------------------------------------*/
/* On est ressorti en validant notre choix.                         */
/*------------------------------------------------------------------*/
If stCom.bValider Then
	dw_commande.SetItem ( 1, "ADR_CP", stCom.sCP )
	dw_commande.SetItem ( 1, "ADR_VILLE", stCom.sCommune )
End If 

This.Enabled = TRUE



end event

type cb_commune_fact from commandbutton within w_sp_gs_w_commande3
integer x = 2194
integer y = 376
integer width = 82
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "..."
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet         : cb_Commune_Fact
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 20/08/2003 17:07:58
//* Libellé       : Bouton d'ouverture de la fenêtre de recherche
//*					  des communes
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//        JFF   07/03/2024   [HP252_276_HUB_PRESTA]
//*-----------------------------------------------------------------

s_Commune	stCom			// Structure dw_Commune

// [HP252_276_HUB_PRESTA]
If F_CLE_A_TRUE ( "HP252_276_HUB_PRESTA" ) Then
	If invCmd.ibModifAdrInterdite Then Return
End If

This.Enabled = FALSE

stCom.dw_Commune =  istPass.dwNorm [9] 


/*------------------------------------------------------------------*/
/* Ouverture d'une Response.                                        */
/*------------------------------------------------------------------*/
OpenWithParm ( w_rech_Commune, stCom )

stCom = Message.PowerObjectParm

/*------------------------------------------------------------------*/
/* On est ressorti en validant notre choix.                         */
/*------------------------------------------------------------------*/
If stCom.bValider Then
	dw_commande.SetItem ( 1, "ADRFC_CP", stCom.sCP )
	dw_commande.SetItem ( 1, "ADRFC_VILLE", stCom.sCommune )
End If 

This.Enabled = TRUE



end event

type cb_imei from commandbutton within w_sp_gs_w_commande3
integer x = 4338
integer y = 40
integer width = 594
integer height = 136
integer taborder = 200
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Récup. IMEI Adh. Corrigé"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : cb_IMEI
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 23/09/2003 17:24:44
//* Libellé       : Armement IMEI de l'adhésion Corrigé
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------


Parent.TriggerEvent ("ue_item6")
end on

type cb_dern from commandbutton within w_sp_gs_w_commande3
integer x = 2235
integer y = 252
integer width = 160
integer height = 64
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = ":"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Contact::cb_Dern
//* Evenement 		: cb_Dern
//* Auteur			: Abdmeziem Catherine
//* Date				: 06/01/2004 11:35:00
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.wf_boutons ( 0, "DERN" )
end on

type cb_prem from commandbutton within w_sp_gs_w_commande3
integer x = 2071
integer y = 184
integer width = 160
integer height = 64
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Webdings"
string text = "9"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Sp_Gs_W_Contact::cb_Prem
//* Evenement 		: cb_Prem
//* Auteur			: Abdmeziem Catherine
//* Date				: 06/01/2004 11:35:00
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.wf_boutons ( 0, "PREM" )

end on

type aff_pg_cmd_t from statictext within w_sp_gs_w_commande3
integer x = 2107
integer y = 320
integer width = 247
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "page 1 / 3"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_tout from picturebutton within w_sp_gs_w_commande3
integer x = 2587
integer y = 8
integer width = 251
integer height = 136
integer taborder = 20
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Tout mobile"
string picturename = "k:\pb4obj\bmp\8_filtre.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : pb_tout
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 15/10/2004 13:57:15
//* Libellé       : 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

invCmd.uf_Deconnecter_Equiv_Fct ("BOUTON")

This.Enabled = FALSE

end on

type st_altpec from statictext within w_sp_gs_w_commande3
integer x = 2331
integer y = 8
integer width = 247
integer height = 136
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
string text = "PEC Forcée !"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_mode_reprise from statictext within w_sp_gs_w_commande3
integer x = 1006
integer y = 144
integer width = 933
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 255
string text = "MODE REPRISE DE BASE MANUELLE"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_aide_mode_reprise from commandbutton within w_sp_gs_w_commande3
integer x = 1943
integer y = 140
integer width = 178
integer height = 64
integer taborder = 480
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Aide !!"
end type

event clicked;//*
//* Fonction		: Clicked
//* Auteur			: JFF
//* Date				: 23/05/2012
//* Libellé			: 
//* Commentaires	: [PM103]
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------


stMessage.sTitre		= "Mode reprise de base manuelle"
stMessage.Icon			= Information!
stMessage.bErreurG	= FALSE
stMessage.bouton		= Ok!
stMessage.sCode		= "WSIN723"
F_Message ( stMessage )

end event

type uo_equiv_fonct from u_sp_ifr_pilote within w_sp_gs_w_commande3
integer x = 69
integer y = 220
integer width = 329
integer height = 248
integer taborder = 140
boolean border = false
end type

on ue_cocher;call u_sp_ifr_pilote::ue_cocher;//*-----------------------------------------------------------------
//*
//* Objet         : n_cst_w_command3
//* Evenement     : 
//* Auteur        : Fabry JF
//* Date          : 25/10/2004 10:35:24
//* Libellé       : 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

invCmd.uf_Zn_Cocher_Equiv_Fct ()
end on

on uo_equiv_fonct.destroy
call u_sp_ifr_pilote::destroy
end on

