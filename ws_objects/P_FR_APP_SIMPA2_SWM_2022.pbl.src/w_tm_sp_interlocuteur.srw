$PBExportHeader$w_tm_sp_interlocuteur.srw
$PBExportComments$-} Fenêtre de traitement détail pour la saisie des interlocuteurs.
forward
global type w_tm_sp_interlocuteur from w_8_traitement_master
end type
type uo_ong from u_onglets within w_tm_sp_interlocuteur
end type
type uo_3d from u_bord3d within w_tm_sp_interlocuteur
end type
type gb_coordonnees from groupbox within w_tm_sp_interlocuteur
end type
type pb_bq from picturebutton within w_tm_sp_interlocuteur
end type
type pb_effacer from picturebutton within w_tm_sp_interlocuteur
end type
type uo_ajout from u_spb_ajout_courtyp within w_tm_sp_interlocuteur
end type
type dw_lst_frais from u_datawindow_detail within w_tm_sp_interlocuteur
end type
type p_focus from picture within w_tm_sp_interlocuteur
end type
type dw_wfrais_supp from datawindow within w_tm_sp_interlocuteur
end type
type uo_courrier_word from u_spb_cp_2000 within w_tm_sp_interlocuteur
end type
type uo_consult_euro from u_consultation_euro within w_tm_sp_interlocuteur
end type
type cb_commune from commandbutton within w_tm_sp_interlocuteur
end type
type lb_fichier from listbox within w_tm_sp_interlocuteur
end type
type cb_courpart from commandbutton within w_tm_sp_interlocuteur
end type
type cb_effacer from commandbutton within w_tm_sp_interlocuteur
end type
type dw_compo from datawindow within w_tm_sp_interlocuteur
end type
type dw_gencourrier from datawindow within w_tm_sp_interlocuteur
end type
end forward

global type w_tm_sp_interlocuteur from w_8_traitement_master
integer x = 0
integer y = 0
integer width = 3598
integer height = 1768
string title = ""
event ue_banque pbm_custom01
event ue_quitteronglet011 pbm_custom02
event ue_entreronglet021 pbm_custom03
event ue_btt_commune pbm_custom04
event ue_taillefenetre ( )
uo_ong uo_ong
uo_3d uo_3d
gb_coordonnees gb_coordonnees
pb_bq pb_bq
pb_effacer pb_effacer
uo_ajout uo_ajout
dw_lst_frais dw_lst_frais
p_focus p_focus
dw_wfrais_supp dw_wfrais_supp
uo_courrier_word uo_courrier_word
uo_consult_euro uo_consult_euro
cb_commune cb_commune
lb_fichier lb_fichier
cb_courpart cb_courpart
cb_effacer cb_effacer
dw_compo dw_compo
dw_gencourrier dw_gencourrier
end type
global w_tm_sp_interlocuteur w_tm_sp_interlocuteur

type variables
Private :
	u_gs_sp_Sinistre_Interlocuteur	iuoGsSpInterlocuteur
	String				isTypeTrt
	String				isDetailConsult
	String 				isBlobDataCP  // SVE DCMP 040020

	Boolean			ibAltCommune   // DCMP 030362 Gestion des commune O/N

	Boolean			ibSaisieValidation

	DataWindow		idw_Desc[2] // [PM72.1] Ajout d'un élément
	DataWindow		idw_DetPro

	U_DataWindow		idw_wSin

	U_DataWindow_Detail	idw_LstInter, idwDivSin, idw_LstCommande

	W_Td_Sp_W_Frais		iW_Td_Sp_W_Frais

	N_Cst_Saisie_Validation_Interlocuteur	invSaisieValInter

	Boolean		ibCPartVisible
	Boolean		ibEffacerVisib
	
end variables

forward prototypes
private subroutine wf_positionnerobjets ()
public function boolean wf_preparermodifier ()
public function boolean wf_preparerinserer ()
public function string wf_controlersaisie ()
public function boolean wf_preparersupprimer ()
public function boolean wf_preparervalider ()
public function boolean wf_preparerabandonner ()
private subroutine wf_tb_consultation ()
private subroutine wf_verifiermodeleword ()
end prototypes

on ue_banque;call w_8_traitement_master::ue_banque;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Interlocuteur::Ue_Banque
//* Evenement 		: Ue_Banque
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 14:29:14
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass	stPass_Dga

/*------------------------------------------------------------------*/
/* Cet événement est déclenché par la fenêtre de recherche des      */
/* AGENCES. On vient de positionner les coordonnées de l'agence     */
/* dans dw_1. Il faut interdire la saisie de ces zones.             */
/*------------------------------------------------------------------*/

iuoGsSpInterlocuteur.Uf_Traitement ( 9, stPass_Dga )

end on

on ue_entreronglet021;call w_8_traitement_master::ue_entreronglet021;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Interlocuteur::Ue_EntrerOnglet011
//* Evenement 		: Ue_EntrerOnglet021
//* Auteur			: Erick John Stark
//* Date				: 23/01/1998 10:54:04
//* Libellé			: 
//* Commentaires	: On est en train de terminer un Uf_ChangerOnglet ( 02 )
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	uo_Ajout.dw_Cible.RowCount () > 0 Then
	uo_Ajout.dw_Cible.SetFocus ()
	uo_Ajout.dw_Cible.SetRow ( 1 )
	uo_Ajout.dw_Cible.ScrollToRow ( 1 )
	uo_Ajout.dw_Cible.SelectRow ( 1, True )
Else
	uo_Ajout.dw_Source.SetFocus ()
	uo_Ajout.dw_Source.SetRow ( 1 )
	uo_Ajout.dw_Source.ScrollToRow ( 1 )
	uo_Ajout.dw_Source.SelectRow ( 1, True )
End If


end on

on ue_btt_commune;call w_8_traitement_master::ue_btt_commune;//*-----------------------------------------------------------------
//*
//* Objet         : w_tm_sp_Interlocuteur
//* Evenement     : ue_btt_Commune
//* Auteur        : Fabry JF
//* Date          : 10/09/2003 15:12:19
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


cb_commune.BringToTop = TRUE
end on

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

// This.Height = 1810 [PB2022_TAILLE_FEN] Je commente
end event

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Interlocuteur::Wf_PositionnerObjets (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 15:27:47
//* Libellé			: 
//* Commentaires	: On positionne et on taille tous les objets
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1	JCA	19/05/2005	deplacement des boutons effacer et courrier particulier
//       JFF   30/05/2023 [PMO89_RS4822]
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne tous les objets nécessaires à la gestion, pour     */
/* faciliter le développement. (On peut bouger les objets).         */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Barre Onglet                                                     */
/*------------------------------------------------------------------*/
Uo_Ong.X			=   10
Uo_Ong.Y			=  157
Uo_Ong.Width	=  109


/*------------------------------------------------------------------*/
/* Dw_1 et les autres comprises dans l'onglet.                      */
/*------------------------------------------------------------------*/
Dw_1.X			=   51
Dw_1.Y			=  273
Dw_1.Width		= 3440  // 2500  [PMO89_RS4822]
Dw_1.Height		= 1400

/*------------------------------------------------------------------*/
/* On positionne l'objet u_Ajout au milieu de l'onglet.             */
/*------------------------------------------------------------------*/
Uo_Ajout.X			= 475
Uo_Ajout.Y			= 280
Uo_Ajout.Width		= 1480
Uo_Ajout.Height	= 1350

/*------------------------------------------------------------------*/
/* On positionne la liste des frais.                                */
/*------------------------------------------------------------------*/
dw_Lst_Frais.X			= Dw_1.X
dw_Lst_Frais.Y			= Dw_1.Y
dw_Lst_Frais.Width	= Dw_1.Width
dw_Lst_Frais.Height	= Dw_1.Height

/*------------------------------------------------------------------*/
/* On positionne le bouton des communes									  */
/*------------------------------------------------------------------*/
cb_Commune.X			= 2385
cb_Commune.Y			= 518
cb_Commune.Width		= 83
cb_Commune.Height		= 73

// #1 
/*------------------------------------------------------------------*/
/* On positionne le bouton du courier particulier						  */
/*------------------------------------------------------------------*/
cb_CourPart.X			= 89
cb_CourPart.Y			= 1467
cb_CourPart.Width		= 394
cb_CourPart.Height	= 77

/*------------------------------------------------------------------*/
/* On positionne le bouton effacer	   									  */
/*------------------------------------------------------------------*/
cb_Effacer.X			= 2190
cb_Effacer.Y			= cb_CourPart.Y
cb_Effacer.Width		= 284
cb_Effacer.Height		= cb_CourPart.Height
// #1 FIN

// [PMO89_RS4822]
gb_coordonnees.X = 2903
gb_coordonnees.Y = 4
gb_coordonnees.Width = 649
gb_coordonnees.Height = 224

end subroutine

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Interlocuteur::Wf_PreparerModifier
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 18:25:09
//* Libellé			: 
//* Commentaires	: Opération avant modification
//*
//* Arguments		: Rien
//*
//* Retourne		: Boolean		Vrai = On peut continuer
//*										Faux = Il y a une erreur
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  CAG 15/09/2003	correction DCMP 030390 : ce n'est pas la décl. du sin qu'il faut
//*								prendre en compte, mais le média du travail
//*								(cod_recu de w_queue au lieu de cod_decl de w_sin)
//*-----------------------------------------------------------------
s_Pass	stPass_Dga
String sMonnaie

/*------------------------------------------------------------------*/
/* On arme le titre de la fenêtre avec le titre de la fenêtre       */
/* Parent.                                                          */
/*------------------------------------------------------------------*/
This.Title = istPass.sTab [ 1 ]
isBlobDataCP = istPass.sTab [ 6 ]

/*------------------------------------------------------------------*/
/* #1 CAG 15/09/03                                                  */
/*------------------------------------------------------------------*/
stPass_Dga.sTab [ 4 ] = istPass.sTab [ 4 ]

iuoGsSpInterlocuteur.Uf_Traitement ( 2, stPass_Dga )

/*------------------------------------------------------------------*/
/* L'accés au bouton SUPPRIMER est géré dans la fonction du NVUO.   */
/*------------------------------------------------------------------*/
pb_Supprimer.Enabled = stPass_Dga.bSupprime

/*------------------------------------------------------------------*/
/* On arme la valeur de la monnaie avec celle de la fenêtre de      */
/* SINISTRE. (En consultation uniquement).                          */
/*------------------------------------------------------------------*/
If	isTypeTrt = "C"	Then
	sMonnaie = istPass.sTab [ 3 ]
	Uo_Consult_Euro.Uf_Changer_Monnaie ( sMonnaie )
End If

Return ( stPass_Dga.bRetour )

end function

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Interlocuteur::Wf_PreparerInserer
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 18:25:09
//* Libellé			: 
//* Commentaires	: Opération avant insertion
//*
//* Arguments		: Rien
//*
//* Retourne		: Boolean		Vrai = On peut continuer
//*										Faux = Il y a une erreur
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #2  JFF  15/01/2004 DCMP 030483 : Courrier ORANGE
//*-----------------------------------------------------------------

s_Pass	stPass_Dga

/*------------------------------------------------------------------*/
/* On arme le titre de la fenêtre avec le titre de la fenêtre       */
/* Parent.                                                          */
/*------------------------------------------------------------------*/
This.Title = istPass.sTab [ 1 ]
isBlobDataCP = istPass.sTab [ 6 ]

/*------------------------------------------------------------------*/
/* #1 CAG 15/09/03                                                  */
/*------------------------------------------------------------------*/
stPass_Dga.sTab [ 4 ] = istPass.sTab [ 4 ]

iuoGsSpInterlocuteur.Uf_Traitement ( 3, stPass_Dga )

Return ( stPass_Dga.bRetour )

end function

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_ControlerSaisie (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:50:46
//* Libellé			: 
//* Commentaires	: Contrôle de la saisie
//*
//* Arguments		: Aucun
//*
//* Retourne		: String			"" = Tout va bien
//*
//*-----------------------------------------------------------------

s_Pass	stPass_Dga

stPass_Dga.bInsert = istPass.bInsert
iuoGsSpInterlocuteur.Uf_Traitement ( 4, stPass_Dga )

Return ( stPass_Dga.sTab [ 1 ] ) 




end function

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Interlocuteur::Wf_PreparerSupprimer
//* Auteur			: Erick John Stark
//* Date				: 28/01/1998 09:27:24
//* Libellé			: 
//* Commentaires	: On veut supprimer l'interlocuteur
//*
//* Arguments		: 
//*
//* Retourne		: Boolean		True	= La suppression va continuer
//*										False = La suppression s'arrete.
//*
//*-----------------------------------------------------------------

s_Pass stPass_Dga

iuoGsSpInterlocuteur.Uf_Traitement ( 10, stPass_Dga )

Return ( stPass_Dga.bRetour )

end function

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_W_Interlocuteur::Wf_PreparerValider
//* Auteur			: Erick John Stark
//* Date				: 28/01/1998 09:27:24
//* Libellé			: 
//* Commentaires	: On veut valider l'interlocuteur
//*
//* Arguments		: 
//*
//* Retourne		: Boolean		True	= La validation va continuer
//*										False = La validation s'arrete.
//*
//*-----------------------------------------------------------------

s_Pass stPass_Dga

stPass_Dga.bInsert = istPass.bInsert
iuoGsSpInterlocuteur.Uf_Traitement ( 6, stPass_Dga )

Return ( True )

end function

public function boolean wf_preparerabandonner ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Interlocuteur::Wf_PreparerAbandonner
//* Auteur			: Erick John Stark
//* Date				: 28/01/1998 09:27:24
//* Libellé			: 
//* Commentaires	: On veut abandonner la saisie de l'interlocuteur
//*
//* Arguments		: 
//*
//* Retourne		: Boolean		True	= On peut continuer l'abandon
//*										False = Problème
//*
//*-----------------------------------------------------------------

s_Pass stPass_Dga

iuoGsSpInterlocuteur.Uf_Traitement ( 7, stPass_Dga )

Return ( stPass_Dga.bRetour )

end function

private subroutine wf_tb_consultation ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Interlocuteur::Wf_Tb_Consultation (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 23/07/1998 15:44:13
//* Libellé			: 
//* Commentaires	: On est en validation/Consultation, on rend les boutons invisibles
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 CP
//DataWindow dwNorm[2]
DataWindow dwNorm[]
//Fin Migration PB8-WYNIWYG-03/2006 CP

/*------------------------------------------------------------------*/
/* Cette fonction est appelée sur Ue_Initialiser de la fenêtre.     */
/*------------------------------------------------------------------*/
cb_Commune.Visible 	= False
cb_Commune.Enabled 	= False

pb_Controler.Visible 	= False
pb_Controler.Enabled 	= False

pb_Valider.Visible 		= False
pb_Valider.Enabled 		= False

pb_Supprimer.Visible 	= False
pb_Supprimer.Enabled 	= False

pb_Imprimer.Visible 		= False
pb_Imprimer.Enabled 		= False

Uo_Courrier_Word.Visible = False
Uo_Courrier_Word.Enabled = False

gb_Coordonnees.Visible 	= False

pb_Bq.Visible				= False
pb_Bq.Enabled				= False

pb_Effacer.Visible		= False
pb_Effacer.Enabled		= False

Uo_Consult_Euro.X			= 252
Uo_Consult_Euro.Y			= 9

Uo_Consult_Euro.Visible	= False // [SUISSE].LOT3 Bouton Invisible
Uo_Consult_Euro.Enabled	= False // [SUISSE].LOT3

/*------------------------------------------------------------------*/
/* On initialise le tableau de DW pour la consultation EURO.        */
/*------------------------------------------------------------------*/

dwNorm [ 1 ] = dw_1
dwNorm [ 2 ] = dw_Lst_Frais

Uo_Consult_Euro.Uf_Initialiser ( dwNorm[] )


end subroutine

private subroutine wf_verifiermodeleword ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_tm_sp_Interlocuteur::wf_VerifierModeleWord (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 15/01/2004 15:43:06
//* Libellé       : On verifie si le modele de courrier Word
//*					  est adapté au courrier du produit.
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

Long lDeb, lFin
String	sModele

/*------------------------------------------------------------------*/
/* Recherche d'une Gestion de modele particulier.						  */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-MD", 1 )

Choose Case lDeb

	/*------------------------------------------------------------------*/
	/* Gestion Modele ORANGE GRAND PUBLIC, on change le modèle en 		  */
	/* ORANGE.DOT	  																	  */
	/*------------------------------------------------------------------*/
	Case 1

		sModele = "ORANGE.DOT"

	/*------------------------------------------------------------------*/
	/* Sinon On lit le modele du fichier INI.									  */
	/*------------------------------------------------------------------*/
	Case Else
		sModele   = ProfileString ( stGlb.sFichierIni, "EDITION", "MODELE", "" )

End Choose

uo_Courrier_Word.uf_ChangerModele ( Upper ( sModele ) )
end subroutine

event ue_creer;call super::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Interlocuteur::Ue_Creer
//* Evenement 		: Ue_Creer
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 16:37:38
//* Libellé			: 
//* Commentaires	: Ouverture de la  Fenêtre de frais.
//*				     (On est en création d'un frais)
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  CAG	12/02/2003  Suite DCMP 030027 : Ajout de la dw DET_PRO
// 			FPI	27/07/2010	[PM72] ajout de idw_lstcommande
 // 			FPI	18/10/2010	[PM72.1] ajout de idw_cmdtypfrn
//*-----------------------------------------------------------------

s_Pass stPass_Dga

stPass_Dga = istPass

If	isTypeTrt <> "S"	Then Return

Choose Case isDetailActif
Case "dw_lst_frais"

	If dw_1.GetItemString ( 1, "COD_INTER" ) = "F" Then
			stMessage.sTitre		= "Frais fournisseurs"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "GENE136"
			F_Message ( stMessage )
			Return
	End If 

	SetPointer ( HourGlass! )


	stPass_Dga.bInsert		= True
	stPass_Dga.bControl		= False

	stPass_Dga.sTab [ 1 ]	= This.Title
	stPass_Dga.sTab [ 2 ]	= isTypeTrt

	stPass_Dga.dwTab [ 1 ]	= Dw_Lst_Frais
	stPass_Dga.dwTab [ 2 ]	= idw_LstInter
	stPass_Dga.dwTab [ 3 ]	= idw_LstCommande	// [PM72]

	stPass_Dga.dwMaster		= idw_wSin
	stPass_Dga.dwMaster1		= dw_1

	stPass_Dga.dwNorm [  1 ]	= idw_Desc [  1 ] 		// DataWindow PRODUIT
	stPass_Dga.dwNorm [  2 ]	= dw_wFrais_Supp 			// DataWindow External permettant de conserver les frais supprimés
	stPass_Dga.dwNorm [ 3 ] = istPass.dwNorm [ 8 ]		// DataWindow DET_PRO // #1
	stPass_Dga.dwNorm [  4 ]	= idw_Desc [  2 ] 		// [PM72.1] idw_cmdtypfrn

	stPass_Dga.udwTab [ 1 ] = 	idwDivSin 
	
	F_OuvreTraitement ( iW_Td_Sp_W_Frais, stPass_Dga )

End Choose

end event

event ue_valider;//*-----------------------------------------------------------------
//*
//* Objet         : w_tm_sp_interlocuteur
//* Evenement     : ue_valider (!!OVERRIDE!!)
//* Auteur        : Fabry JF
//* Date          : 24/05/2005 11:08:27
//* Libellé       : 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ	PAR	Date			Modification
//* #1	JCA   24/05/2006	Dnt Mail - concatenation adr_mail_name + @ + adr_mail_domain
//*      JFF   18/07/2010  [PM159]
//*-----------------------------------------------------------------

String	sIdFour

// #1
String	sAdrMailName, sAdrMailDomain, sAdrMail
Long		lRow
Boolean	bCtrlMail
// #1 FIN

// #1 dans le cas de modification si click sur bouton valider sans changement de focus
dw_1.accepttext()

If dw_1.GetItemString ( 1, "COD_INTER" )  = "F" And istPass.bInsert Then
	sIdFour = Upper ( dw_1.GetItemString ( 1, "ID_FOUR" ) )
	
	If idw_LstInter.Find ( "UPPER ( ID_FOUR ) = '" + sIdFour + "'", 1, idw_LstInter.RowCount ()) > 0 Then

		stMessage.sTitre		= "Gestion des interlocuteur fournisseurs"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "GENE135"

		F_Message ( stMessage )

		Return
	End If

End If

// #1
lRow = dw_1.GetRow()
sAdrMailName = dw_1.GetItemString(lRow, "ADR_MAIL_NAME")
sAdrMailDomain = dw_1.GetItemString(lRow, "ADR_MAIL_DOMAIN")

if not ((isnull(sAdrMailName) and isnull(sAdrMailDomain)) or (sAdrMailName="" and sAdrMailDomain="")) then
	sAdrMail = lower ( trim ( sAdrMailName ) + '@' + trim ( sAdrMailDomain ) )
	
	if f_libelle(sAdrMail, 8) then
		dw_1.SetItem(lRow, "ADR_MAIL_NAME", lower ( trim ( sAdrMailName ) ) )
		dw_1.SetItem(lRow, "ADR_MAIL_DOMAIN", lower ( trim ( sAdrMailDomain ) ) )
		dw_1.SetItem(lRow, "ADR_MAIL", sAdrMail )
	else
		stMessage.sTitre		= "Contrôle de saisie d'un interlocuteur"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= False
		stMessage.sVar[1] 	= "L'Email saisie est invalide"	
		stMessage.sCode		= "GENE013"
	
		F_Message ( stMessage )
		
		return
	end if
else
	SetNull(sAdrMail)
	dw_1.SetItem(lRow, "ADR_MAIL", sAdrMail)
end if
// #1 FIN

Call super::ue_valider
end event

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Interlocuteur::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//* #1	CAG	12/02/2003	Suite DCMP 030027 : Ajout de dw sur Det_Pro
//* #2	JFF	22/03/2004	SVE DCMP 040020
//* #3	JCA	26/05/2006	DntMail - Decomposition adr_mail en adr_mail_name et adr_mail_domain
//* #4	JCA	16/05/2007	DCMP 070051 - Fusion des tables [courrier] et composition] en [cour_prod]
// 			FPI	27/07/2010	[PM72] ajout de idw_lstcommande 
// 			FPI	18/10/2010	[PM72.1] ajout de idw_cmdtypfrn
//* 		   JFF   25/10/2011  [PC363][LOGO_AUCHAN]
//			FPI	21/02/2013	[PM64] Bouton IBAN
//       JFF   30/05/2023 [PMO89_RS4822]
//*-----------------------------------------------------------------

s_Pass		stPass_Dga

//Migration PB8-WYNIWYG-03/2006 CP
//DataWindow	dwNorm[8]
//DataWindow	dwPassageEuro[2]
DataWindow	dwNorm[]
DataWindow	dwPassageEuro[]
//Fin Migration PB8-WYNIWYG-03/2006 CP

DataWindowChild dwChild_EF

Wf_PositionnerObjets ()

Wf_ActiverModeDetail ( True )
dw_1.Uf_DetailParent ( istPass.dwTab[ 1 ] )

/*------------------------------------------------------------------*/
/* Nous sommes en saisie (S) ou en Consultation/Validation (C)(V)   */
/*------------------------------------------------------------------*/
isTypeTrt = istPass.sTab[ 2 ]  
ibSaisieValidation = istPass.bTab[ 2 ]

If Not ibSaisieValidation Then dw_1.Modify ( "p_cpart.filename = ''" )

uo_courrier_word.visible = Not ibSaisieValidation 

/*------------------------------------------------------------------*/
/* On commence à initialiser les NVUO.                              */
/*------------------------------------------------------------------*/
iuoGsSpInterlocuteur = Create U_Gs_Sp_Sinistre_Interlocuteur

/*------------------------------------------------------------------*/
/* On garde la référence aux DW dans un tableau propre à la         */
/* fenêtre, pour pouvoir ouvrir la fenêtre de traitement des        */
/* frais. Cela évite de poser des contrôles DW sur la fenêtre.      */
/* (Rapidité ouverture)                                             */
/*------------------------------------------------------------------*/
idw_Desc[1]		= istPass.dwNorm[1]	// PRODUIT
idw_Desc[2]		= istPass.dwNorm[10]	// [PM72.1]

idw_wSin			= istPass.dwMaster
idw_LstInter	= istPass.dwTab[1]
idw_LstCommande 	= istPass.dwTab[2] // [PM72]

ibAltCommune   = istPass.bTab[1] // DCMP 030362 Gestion des commune O/N
stPass_Dga.bTab[1] = ibAltCommune

/*------------------------------------------------------------------*/
/* #2 Gestion Saisie/Validation.                                    */
/*------------------------------------------------------------------*/
invSaisieValInter	= CREATE N_CSt_Saisie_Validation_Interlocuteur

// #4// [PC363][LOGO_AUCHAN] 
invSaisieValInter.Uf_Initialiser ( "SIMPA2", lb_Fichier, cb_CourPart, cb_Effacer, dw_Compo, dw_GenCourrier, idw_WSin, istPass.dwNorm [ 8 ] )
// #4 - FIN

stPass_Dga.bTab[2] = ibSaisieValidation 

/*------------------------------------------------------------------*/
/* Ces fonctions sont issues du NVUO ancêtre.                       */
/*------------------------------------------------------------------*/
dwNorm[1] = istPass.dwNorm [ 2 ]		// PARA_PROD
dwNorm[2] = istPass.dwNorm [ 3 ]		// W_PARA_INFO
dwNorm[3] = istPass.dwNorm [ 4 ]		// W_PIECE
dwNorm[4] = istPass.dwNorm [ 5 ]		// W_REFUS
dwNorm[5] = istPass.dwNorm [ 6 ]		// W_FRAIS

dwNorm[6] = dw_wFrais_Supp
dwNorm[7] = istPass.dwNorm [ 7 ]		// W_DETAIL
idw_DetPro = istPass.dwNorm [ 8 ]   // existe, mais n'est pas inscrite dans le dwNorm[]
dwNorm[8] = istPass.dwNorm [ 9 ]		// Dw des communes

dwNorm[11] = istPass.dwNorm [ 11 ]		// [VDoc12394] - on garde le même index dans le tab pour + de lisibilité

idwDivSin = istPass.udwTab [ 1 ]

iuoGsSpInterlocuteur.Uf_Initialisation ( istPass.dwMaster, itrTrans, Uo_Ong, isTypeTrt )
/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
iuoGsSpInterlocuteur.Uf_Initialiser_Dw ( istPass.dwNorm [ 1 ], istPass.dwNorm [ 8 ], False )
//Migration PB8-WYNIWYG-03/2006 FM
//CP iuoGsSpInterlocuteur.Uf_Initialiser_Dw_Desc ( dw_Lst_Frais, dw_1, dwNorm[] )
//cette ligne de code est nécessaire
iuoGsSpInterlocuteur.Uf_Initialiser_Dw_Desc ( dw_Lst_Frais, dw_1, dwNorm[] )
//Fin Migration PB8-WYNIWYG-03/2006 FM
dw_Lst_Frais.SetRowFocusIndicator ( p_Focus, 50, 260 )

/*------------------------------------------------------------------*/
/* On initialise l'objet de gestion des paragraphes d'information.  */
/* Il faut le faire aprés l'initialisation de DW.                   */
/*------------------------------------------------------------------*/
iuoGsSpInterlocuteur.Uf_Initialiser_Objets (	Uo_Ajout, Uo_Courrier_Word, cb_Commune, invSaisieValInter )

/*------------------------------------------------------------------*/
/* #3	*/
/*------------------------------------------------------------------*/
/*
int ret
ret = iuoGsSpInterlocuteur.Uf_Decompo_Adr_Mail()
*/

/*------------------------------------------------------------------*/
/* Initialisation de l'onglet.                                      */
/*------------------------------------------------------------------*/
Uo_Ong.Uf_Initialiser ( 3, 1 )
Uo_Ong.Uf_EnregistrerOnglet ( "01", "Interlocuteurs", 	"", dw_1,			True )
Uo_Ong.Uf_EnregistrerOnglet ( "02", "Informations", 		"", Uo_Ajout,		False )
Uo_Ong.Uf_EnregistrerOnglet ( "03", "Frais", 				"", dw_Lst_Frais,	False )

/*------------------------------------------------------------------*/
/* Si on est en Consultation/Validation (C)(V), on bouge la         */
/* cosmétique de la fenêtre.                                        */
/*------------------------------------------------------------------*/
If	isTypeTrt <> "S"	Then
	Wf_Tb_Consultation ()
End If

iuoGsSpInterlocuteur.Uf_Traitement ( 1, stPass_Dga )

/*------------------------------------------------------------------*/
/* Gestion du Passage à l'EURO.                                     */
/*------------------------------------------------------------------*/
N_Cst_Passage_Euro	nvPassageEuro

dwPassageEuro[ 1 ] = dw_1
dwPassageEuro[ 2 ] = dw_Lst_Frais

nvPassageEuro = CREATE N_Cst_Passage_Euro
nvPassageEuro.uf_Initialiser ( dwPassageEuro[] )

DESTROY nvPassageEuro

// [PM64]
If istypetrt<> 'S' Then dw_1.Modify("cb_iban.Visible=0")


// 	[PMO89_RS4822]
dw_1.GetChild ( "COD_ETAT_CTRLE_INTER", dwChild_EF )
dwChild_EF.SetTransObject ( SQLCA)
dwChild_EF.Retrieve ( "-EF")
dwChild_EF.SetFilter ( "ID_TYP_CODE = '-EF' AND ID_CODE > 0" )
dwChild_EF.Filter ()
dwChild_EF.Sort ()

end event

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Interlocuteur::Ue_Modifier
//* Evenement 		: Ue_Creer
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 16:37:38
//* Libellé			: 
//* Commentaires	: Ouverture de la  Fenêtre de frais.
//*				     (On est en modification d'un frais)
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  CAG	12/02/2003  Suite DCMP 030027 : Ajout de la dw DET_PRO
 // 			FPI	27/07/2010	[PM72] ajout de idw_lstcommande
 // 			FPI	18/10/2010	[PM72.1] ajout de idw_cmdtypfrn
//*-----------------------------------------------------------------

s_Pass stPass_Dga

stPass_Dga = istPass

Choose Case isDetailActif
Case "dw_lst_frais"

	isDetailConsult = "dw_lst_frais"

	SetPointer ( HourGlass! )

	stPass_Dga.bInsert		= False
	stPass_Dga.bSupprime		= True
	stPass_Dga.bControl		= False

	stPass_Dga.sTab [ 1 ]	= This.Title
	stPass_Dga.sTab [ 2 ]	= isTypeTrt
	stPass_Dga.sTab [ 3 ]	= Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()

	stPass_Dga.dwTab [ 1 ]	= Dw_Lst_Frais
	stPass_Dga.dwTab [ 2 ]	= idw_LstInter
	stPass_Dga.dwTab [ 3 ]	= idw_LstCommande	// [PM72]

	stPass_Dga.dwMaster		= idw_wSin
	stPass_Dga.dwMaster1		= dw_1

	stPass_Dga.dwNorm [  1 ]	= idw_Desc [  1 ] 		// DataWindow PRODUIT

	stPass_Dga.dwNorm [  2 ]	= dw_wFrais_Supp 			// DataWindow External permettant de conserver les frais supprimés
	
	If	stPass_Dga.sTab [ 3 ]	<> stGLB.sMonnaieFormatDesire	Then	Uo_Consult_Euro.Uf_Changer_Monnaie ( stGLB.sMonnaieFormatDesire )

	/*------------------------------------------------------------------*/
	/* #1                                                               */
	/*------------------------------------------------------------------*/
	stPass_Dga.dwNorm [ 3 ] = istPass.dwNorm [ 8 ]		// DataWindow DET_PRO
	stPass_Dga.dwNorm [ 4 ]	= idw_Desc [  2 ] 		// [PM72.1]

	F_OuvreTraitement ( iW_Td_Sp_W_Frais, stPass_Dga )

End Choose

end event

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Interlocuteur::Close
//* Evenement 		: Close
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 18:46:48
//* Libellé			: 
//* Commentaires	: Fermeture définitive de la fenêtre.
//*				     On supprime tous les NVUO.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//Destroy iUoGsSpInterlocuteur
If IsValid(iUoGsSpInterlocuteur) Then Destroy iUoGsSpInterlocuteur
//Fin Migration PB8-WYNIWYG-03/2006 FM

If isValid ( iW_Td_Sp_W_Frais	) Then Close ( iW_Td_Sp_W_Frais )

/*------------------------------------------------------------------*/
/* Gestion Saisie/Validation.                                       */
/*------------------------------------------------------------------*/
If	IsValid ( invSaisieValInter )	Then DESTROY	invSaisieValInter


end event

event show;call super::show;//*-----------------------------------------------------------------
//*
//* Objet         : w_tm_sp_Interlocuteur
//* Evenement     : Show
//* Auteur        : Fabry JF
//* Date          : 26/08/2003 13:53:38
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


cb_Commune.Enabled = ibAltCommune

This.PostEvent ("ue_btt_Commune" )
This.PostEvent ( "ue_TailleFenetre" )
end event

on ue_enablefenetre;call w_8_traitement_master::ue_enablefenetre;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Interlocuteur::Ue_EnableFenetre
//* Evenement 		: Ue_EnableFenetre
//* Auteur			: Erick John Stark
//* Date				: 09/06/1998 17:20:28
//* Libellé			: 
//* Commentaires	: On vient de la fenêtre des Frais
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String sMonnaie

/*------------------------------------------------------------------*/
/* Si on est en saisie, il faut regénérer le TreeView.              */
/*------------------------------------------------------------------*/
Choose Case isTypeTrt
Case "C"
/*------------------------------------------------------------------*/
/* On est en consultation, on vient forcément de la fenêtre des     */
/* FRAIS. On récupére la valeur de la monnaie pour cette fenêtre,   */
/* et on positionne la même valeur pour la fenêtre en cours.        */
/*------------------------------------------------------------------*/
	Choose Case isDetailConsult
	Case "dw_lst_frais"
		sMonnaie = iW_Td_Sp_W_Frais.Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()

	End Choose

	If	This.Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante () <> sMonnaie	Then
		Uo_Consult_Euro.Uf_Changer_Monnaie ( sMonnaie )
	End If

End Choose

end on

event we_childactivate;call super::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Interlocuteur::We_ChildActivate
//* Evenement 		: We_ChildActivate
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:53:35
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.X			=    1
This.Y			=    1

// [PB2022_TAILLE_FEN] + xxx
This.Height		= 1769 + 90


// [PB2022_TAILLE_FEN] + xxx
This.Width		= 3598 + 50
end event

on w_tm_sp_interlocuteur.create
int iCurrent
call super::create
this.uo_ong=create uo_ong
this.uo_3d=create uo_3d
this.gb_coordonnees=create gb_coordonnees
this.pb_bq=create pb_bq
this.pb_effacer=create pb_effacer
this.uo_ajout=create uo_ajout
this.dw_lst_frais=create dw_lst_frais
this.p_focus=create p_focus
this.dw_wfrais_supp=create dw_wfrais_supp
this.uo_courrier_word=create uo_courrier_word
this.uo_consult_euro=create uo_consult_euro
this.cb_commune=create cb_commune
this.lb_fichier=create lb_fichier
this.cb_courpart=create cb_courpart
this.cb_effacer=create cb_effacer
this.dw_compo=create dw_compo
this.dw_gencourrier=create dw_gencourrier
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_ong
this.Control[iCurrent+2]=this.uo_3d
this.Control[iCurrent+3]=this.gb_coordonnees
this.Control[iCurrent+4]=this.pb_bq
this.Control[iCurrent+5]=this.pb_effacer
this.Control[iCurrent+6]=this.uo_ajout
this.Control[iCurrent+7]=this.dw_lst_frais
this.Control[iCurrent+8]=this.p_focus
this.Control[iCurrent+9]=this.dw_wfrais_supp
this.Control[iCurrent+10]=this.uo_courrier_word
this.Control[iCurrent+11]=this.uo_consult_euro
this.Control[iCurrent+12]=this.cb_commune
this.Control[iCurrent+13]=this.lb_fichier
this.Control[iCurrent+14]=this.cb_courpart
this.Control[iCurrent+15]=this.cb_effacer
this.Control[iCurrent+16]=this.dw_compo
this.Control[iCurrent+17]=this.dw_gencourrier
end on

on w_tm_sp_interlocuteur.destroy
call super::destroy
destroy(this.uo_ong)
destroy(this.uo_3d)
destroy(this.gb_coordonnees)
destroy(this.pb_bq)
destroy(this.pb_effacer)
destroy(this.uo_ajout)
destroy(this.dw_lst_frais)
destroy(this.p_focus)
destroy(this.dw_wfrais_supp)
destroy(this.uo_courrier_word)
destroy(this.uo_consult_euro)
destroy(this.cb_commune)
destroy(this.lb_fichier)
destroy(this.cb_courpart)
destroy(this.cb_effacer)
destroy(this.dw_compo)
destroy(this.dw_gencourrier)
end on

type cb_debug from w_8_traitement_master`cb_debug within w_tm_sp_interlocuteur
end type

type dw_1 from w_8_traitement_master`dw_1 within w_tm_sp_interlocuteur
integer x = 37
integer y = 312
integer width = 590
integer height = 276
string dataobject = "d_sp_sin_interlocuteur"
boolean border = false
end type

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Interlocuteur::dw_1
//* Evenement 		: ItemError
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:47:59
//* Libellé			: 
//* Commentaires	: Gestion des messages d'erreur
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR		Date			Modification
//* #1	JCA		29/05/2006	DntMail		
//		FPI	11/10/2013	[VDoc12394]
//    JFF   12/06/2014  [PI052]
//		FPI	15/06/2015 [BLOC_COUR_FRN]
//		FPI	22/06/2015	[DT158]
//    JFF   12/11/2018 [PM452-1]
//	   JFF - 10/01/2018 - [SHUNT_WS_SEPA]
//		JFF   31/10/2019	[VDOC28559]
//    JFF   26/04/2023 [RS5045_REF_MATP]
//    JFF   19/12/2024 [MIG1_COUR_EMAILING]
//*-----------------------------------------------------------------

If	ibErreur Then

	stMessage.sTitre		= "Gestion des interlocuteurs - SIMPA2"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= True

	// [PM452-1]
	Choose Case isErrCol
	Case "COD_CIV"	
		Choose Case iiErreur
			Case 0
				stMessage.sCode	= "WINT306"
				stMessage.bErreurG	= False				
		End Choose 
	
	Case "NOM"
		stMessage.sVar[1] = "nom de l'interlocuteur"
		stMessage.sCode	= "GENE003"

	Case "ADR_1"
		stMessage.sVar[1] = "première ligne d'adresse"
		stMessage.sCode	= "GENE002"

	Case "ADR_2"
		stMessage.sVar[1] = "seconde ligne d'adresse"
		stMessage.sCode	= "GENE002"

	Case "ADR_CP"
		stMessage.sVar[1] = "code postal"
		stMessage.sCode	= "GENE003"

	Case "ADR_VILLE"
		stMessage.sVar[1] = "ville"
		stMessage.sCode	= "GENE002"

	Case "NUM_TELD", "NUM_TELB"
		stMessage.sVar[1] = "numéro de téléphone"
		stMessage.sCode	= "GENE003"

	Case "NUM_FAX"
		stMessage.sVar[1] = "numéro de fax"
		stMessage.sCode	= "GENE003"

	Case "ADR_ATT"
		stMessage.sVar[1] = "zone 'A l'attention de'"
		stMessage.sCode	= "GENE002"

	Case "V_REF1"
		stMessage.sVar[1] = "première référence"
		stMessage.sCode	= "GENE002"

	Case "V_REF2"
		stMessage.sVar[1] = "seconde référence"
		stMessage.sCode	= "GENE002"

	Case "RIB_BQ"
		stMessage.sVar[1] = "code de la banque"
		stMessage.sCode	= "GENE003"

	Case "RIB_GUI"
		stMessage.sVar[1] = "code du guichet"
		stMessage.sCode	= "GENE003"

	Case "RIB_CPT"
		stMessage.sVar[1] = "numéro du compte"
		stMessage.sCode	= "GENE003"

	Case "RIB_CLE"
		Choose Case iiErreur
		Case 0
			stMessage.sVar[1] = "clé RIB"
			stMessage.sCode	= "GENE002"

		Case 1
			stMessage.bErreurG	= False
			stMessage.sCode  		= "REFU005"

		Case 2	// [VDoc12394]
			stMessage.bErreurG	= False
			stMessage.sCode  		= "WSIN760"

		Case 3   //	[VDOC28559]
			stMessage.bErreurG	= False
			stMessage.sCode  		= "WINT307"
			

		End Choose

	Case "ALT_COURGEST"
		stMessage.bErreurG = False
		stMessage.sCode	= "SVE0001"
		
		If iiErreur=2 Then 		stMessage.sCode	= "SVE0031" // [BLOC_COUR_FRN]
		If iiErreur=3 Then 		stMessage.sCode	= "WINT316" // [MIG1_COUR_EMAILING]
		
	
	// [PI052]
	Case "ALT_QUEST"
		stMessage.bErreurG = False
		stMessage.sCode	= "PI52006"

	Case "COD_MODE_REG"
	
		Choose Case iiErreur
			Case 1
				stMessage.sCode	= "GENE134"
				stMessage.Icon			= Exclamation!
				stMessage.bErreurG	= False
			
			Case 2
				stMessage.sCode	= "WINT303"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= False
				
		End Choose

	// [RS5045_REF_MATP]
	Case "ADR_MAIL_NAME", "ADR_MAIL_DOMAIN"
		stMessage.bErreurG	= False
		stMessage.Icon			= Exclamation!		
		stMessage.sCode	= "WINT313"

	Case "ID_NAT_COUR"  // [DT158]
		Choose Case iiErreur
			Case 1
				stMessage.sCode	= "COUR008"
				stMessage.Icon			= Exclamation!
				stMessage.bErreurG	= False
			Case 2
				stMessage.sCode	= "WINT304"
				stMessage.Icon			= Exclamation!
				stMessage.bErreurG	= False
		End Choose
End Choose

	F_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 FM
//	This.Uf_Reinitialiser ()
	Return This.Uf_Reinitialiser ()
//Fin Migration PB8-WYNIWYG-03/2006 FM

End If

//Migration PB8-WYNIWYG-03/2006 FM
return AncestorReturnValue
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event dw_1::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Interlocuteur::dw_1
//* Evenement 		: ItemChanged
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:35:04
//* Libellé			: 
//* Commentaires	: Modification des zones
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass	stPass_Dga

/*------------------------------------------------------------------*/
/* Si on est en Saisie, on lance le traitement des zones.           */
/*------------------------------------------------------------------*/
If	isTypeTrt = "S" Then
//If	isTypeTrt = "S" And This.iiCarNul = 0 Then
	// [MIGPB8COR] PHG
	Return iuoGsSpInterlocuteur.Uf_Zn_Trt ( stPass_Dga )
End If
end event

event dw_1::buttonclicked;call super::buttonclicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Interlocuteur::dw_1
//* Evenement 		: ButtonClicked
//* Auteur			: FPI
//* Date				: 21/02/2013
//* Libellé			: 
//* Commentaires	: [PM64]
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//       JFF   18/08/2020 [PM497-1]
//       JFF   19/12/2024 [MIG1_COUR_EMAILING]
//*-----------------------------------------------------------------
n_cst_spb_params		uParams	
s_Pass stPass
String sVal, sIdCour, sIdNatCour, sTypMail
Boolean bEmailingKsl
Long lDeb, lFin

Choose Case upper(dwo.Name)
	Case "CB_IBAN"

		// Message d'avertissement si au moins une zone de RIB est déjà saisie
		If f_getitem3(dw_1,1,"RIB_BQ") <> "" or  f_getitem3(dw_1,1,"RIB_GUI")<> "" or &
			f_getitem3(dw_1,1,"RIB_CPT") <> "" or f_getitem3(dw_1,1,"RIB_CLE") <> "" Then
	
			stMessage.berreurg=FALSE
			stMessage.sCode="CONF009"
			stMessage.bouton=YesNo!
			stMessage.icon=Question!
			
			if f_message(stMessage) = 2 Then Return 0
		End if
		
		uParams = CREATE n_cst_spb_params
	
		// On passe le RIB à vide
		uParams.istparams[1].isvaleurstr[1] = "RIB_BQ=" 
		uParams.istparams[1].isvaleurstr[2] = "RIB_GUI="
		uParams.istparams[1].isvaleurstr[3] = "RIB_CPT=" 
		uParams.istparams[1].isvaleurstr[4] = "RIB_CLE=" 
	
		OpenWithParm(W_tm_sp_iban,uParams)
		
		If Message.StringParm ="ANNULER" Then 
			Destroy uParams
			Return 0
		End if
	
		uParams = Message.Powerobjectparm
	
		dw_1.SetItem(1,"RIB_BQ",uParams.uf_getvaluestr(1,"RIB_BQ"))
		dw_1.SetItem(1,"RIB_GUI",uParams.uf_getvaluestr(1,"RIB_GUI"))
		dw_1.SetItem(1,"RIB_CPT",uParams.uf_getvaluestr(1,"RIB_CPT"))
		dw_1.SetItem(1,"RIB_CLE",uParams.uf_getvaluestr(1,"RIB_CLE"))
		
		Destroy uParams
		
	Case "B_TYPO_COURRIER"
		
		// [PM497-1]
		stPass.lTab[1] = idw_WSin.GetItemNumber ( 1, "ID_PROD" )
		
		// [MIG1_COUR_EMAILING]
		bEmailingKsl = False
		If F_CLE_A_TRUE ( "MIG1_COUR_EMAILING" ) Then
			// [MIG1_COUR_EMAILING]
			F_RechDetPro ( lDeb, lFin, idw_DetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 390 )
			bEmailingKsl = lDeb > 0 
			
			If bEmailingKsl Then
				OpenWithParm( w_t_sp_emailing_ksl, stPass )
				
				stPass = Message.Powerobjectparm
				
				If UpperBound ( stPass.sTab ) > 0 Then 
				
					sTypMail    = Trim ( stPass.sTab [1] )
					
					If sTypMail = "" Then sTypMail = stNul.str
		
//					If sTypMail <> "" Then	On peut sortir de la fenêtre en effacer le code acutel			
						this.SetItem ( 1, "ALT_COURGEST", "R" ) 
	
						This.SetItem ( 1, "ID_NAT_COUR", sTypMail ) 
						This.SetColumn ( "ID_NAT_COUR" )

						This.SetItem ( 1, "ID_COUR", sTypMail ) 
						This.SetColumn ( "ID_COUR" )

						This.SetFocus ( )
						TriggerEvent ( This, "itemchanged" )
//					End If 
					
				End If 			
				
				Return									

			End If 

			
		End IF 			
		
		
		// Non Emailing, donc traitement normal SIMPA2
		OpenWithParm( w_tm_sp_typo_courrier, stPass )
		
		stPass = Message.Powerobjectparm
		
		If UpperBound ( stPass.sTab ) > 0 Then 
		
			sIdNatCour = Trim ( stPass.sTab [1] )
			sIdCour    = Trim ( stPass.sTab [2] )
			
			If IsNull ( sIdNatCour ) Then sIdNatCour = ""
			If IsNull ( sIdCour ) Then sIdCour = ""				

			If sIdCour <> "" Then				
				Choose Case this.GetItemString ( 1, "ALT_COURGEST" ) 
					Case "R"
						/*
						This.SetItem ( 1, "ID_NAT_COUR", sVal ) 
						This.SetColumn ( "ID_NAT_COUR" )
						*/

						This.SetItem ( 1, "ID_NAT_COUR", sIdNatCour ) 
						This.SetColumn ( "ID_NAT_COUR" )

						This.SetItem ( 1, "ID_COUR", sIdCour ) 
						This.SetColumn ( "ID_COUR" )


					Case "J"
						This.SetItem ( 1, "ID_COURJ", sIdCour ) 
						This.SetColumn ( "ID_COURJ" )
					
				End CHoose 
				This.SetFocus ( )
				TriggerEvent ( This, "itemchanged" )
			End If 
		End If 			


End Choose 

end event

type st_titre from w_8_traitement_master`st_titre within w_tm_sp_interlocuteur
boolean visible = false
integer x = 3287
integer y = 172
integer width = 133
end type

type pb_retour from w_8_traitement_master`pb_retour within w_tm_sp_interlocuteur
integer x = 9
integer y = 8
integer width = 242
integer height = 144
integer taborder = 70
end type

type pb_valider from w_8_traitement_master`pb_valider within w_tm_sp_interlocuteur
integer x = 251
integer y = 8
integer width = 242
integer height = 144
integer taborder = 80
end type

type pb_imprimer from w_8_traitement_master`pb_imprimer within w_tm_sp_interlocuteur
integer x = 736
integer y = 8
integer width = 242
integer height = 144
integer taborder = 100
end type

type pb_controler from w_8_traitement_master`pb_controler within w_tm_sp_interlocuteur
boolean visible = false
integer x = 256
integer y = 8
integer taborder = 190
boolean enabled = false
end type

type pb_supprimer from w_8_traitement_master`pb_supprimer within w_tm_sp_interlocuteur
integer x = 494
integer y = 8
integer width = 242
integer height = 144
integer taborder = 90
end type

type uo_ong from u_onglets within w_tm_sp_interlocuteur
integer x = 9
integer y = 156
integer width = 1070
integer height = 108
integer taborder = 40
boolean border = false
end type

on clicked;call u_onglets::clicked;//*-----------------------------------------------------------------
//*
//* Objet         : dw_regle_coherence
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 08/09/2003 14:06:46
//* Libellé       : Gestion du bouton Commune
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


cb_Commune.Visible = This.uf_RecupererOngletCourant () = "01"

cb_CourPart.Visible = This.uf_RecupererOngletCourant () = "01" And ibSaisieValidation And Not istPass.bInsert
cb_Effacer.Visible = This.uf_RecupererOngletCourant () = "01" AND dw_1.GetItemString ( 1, "ALT_PART" ) = "O" And ibSaisieValidation &
							And Not istPass.bInsert


Parent.PostEvent ("ue_btt_Commune" )
end on

type uo_3d from u_bord3d within w_tm_sp_interlocuteur
integer x = 1335
integer y = 40
integer width = 411
integer height = 188
end type

event constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_3d::Constructor (OVERRIDE)
//* Evenement 		: Constructor
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 14:57:30
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//       JFF   30/05/2023 [PMO89_RS4822]
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne le Bord en 3D, puis on appelle la construction     */
/* normale.                                                         */
/*------------------------------------------------------------------*/

This.X			=   19
This.Y			=  248  // 253  // [PMO89_RS4822]
This.Width		= 3500  // 2550 // [PMO89_RS4822] 
This.Height		= 1430  // 1420 // [PMO89_RS4822]

Call U_Bord3D::Constructor
end event

on uo_3d.destroy
call u_bord3d::destroy
end on

type gb_coordonnees from groupbox within w_tm_sp_interlocuteur
integer x = 2903
integer y = 4
integer width = 649
integer height = 224
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Coordonnées"
end type

type pb_bq from picturebutton within w_tm_sp_interlocuteur
integer x = 2967
integer y = 52
integer width = 242
integer height = 144
integer taborder = 50
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Banque"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_bq.bmp"
string disabledname = "k:\pb4obj\bmp\8_bq.bmp"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: Pb_Bq::Clicked!
//* Evenement 		: Clicked!
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 10:33:01
//* Libellé			: 
//* Commentaires	: Ouverture de la fenêtre pour la recherche des agences.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date			Modification
//* JFF			09/03/2015	[MANTIS14653][DT133_CASTO]
//*-----------------------------------------------------------------

s_Pass	stPass_Dga
Long lRow, lDeb, lFin
String sValCar, sCodInter
n_cst_string	lnvString 

/*------------------------------------------------------------------*/
/* On ne peut ouvrir la fenêtre de recherche que si :               */
/*  - On est en saisie.                                             */
/*  - L'interlocuteur n'a jamais été validé.                        */
/*------------------------------------------------------------------*/

If	dw_1.GetItemNumber ( 1, "CPT_VALIDE" ) = 0 And isTypeTrt = "S" Then
	stPass_Dga.trTrans 	= itrTrans
	stPass_Dga.wParent	= Parent

	// [MANTIS14653]
	F_RechDetPro ( lDeb, lFin, idw_DetPro, iDw_Wsin.GetItemNumber( 1, "ID_PROD" ), "-DP", 43 )
	If lDeb > 0 Then
		lRow = idwDivSin.Find ( "NOM_ZONE = 'num_mag'", 1,  idwDivSin.RowCount () )
		If lRow > 0 Then
			stPass_Dga.lTab[1] = 23400
			stPass_Dga.lTab[2] = idwDivSin.GetItemNumber ( lRow, "VAL_NBRE" )
		End If 
	End If 			

/*------------------------------------------------------------------*/
/* On se positionne sur l'onglet 01, éventuellement.                */
/*------------------------------------------------------------------*/
	If	Uo_Ong.Uf_RecupererOngletCourant () <> "01" Then Uo_Ong.Uf_ChangerOnglet ( "01" )

	OpenWithParm ( W_T_Sp_Banque, stPass_Dga, stPass_Dga.wParent.ParentWindow () )

	// [PMO89_RS4822]
	dw_1.uf_proteger( {"DTE_NAISS", "VILLE_NAISS", "PAYS_NAISS" }, "1")		

End If

end event

type pb_effacer from picturebutton within w_tm_sp_interlocuteur
integer x = 3246
integer y = 52
integer width = 242
integer height = 144
integer taborder = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Effacer"
string picturename = "k:\pb4obj\bmp\8_gomme.bmp"
string disabledname = "k:\pb4obj\bmp\8_gomme.bmp"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: Pb_Effacer::Clicked
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 16/01/1998 17:14:23
//* Libellé			: 
//* Commentaires	: On efface les coordonnées saisies
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR	Date			Modification
//* #1	JCA	29/05/2006	DntMail 			  
//*-----------------------------------------------------------------

s_Pass	stPass_Dga

/*------------------------------------------------------------------*/
/* On ne peut effacer les coordonnées que si :                      */
/*  - On est en saisie.                                             */
/*  - L'interlocuteur n'a jamais été validé.                        */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On ne peut ouvrir la fenêtre de recherche que si :               */
/*  - On est en saisie.                                             */
/*  - L'interlocuteur n'a jamais été validé.                        */
/*------------------------------------------------------------------*/

If	dw_1.GetItemNumber ( 1, "CPT_VALIDE" ) = 0 And isTypeTrt = "S" Then

	dw_1.SetItem ( 1, "COD_INTER", 	stNul.str )
	dw_1.SetItem ( 1, "COD_CIV", 		stNul.str )
	dw_1.SetItem ( 1, "NOM",			stNul.str )
	dw_1.SetItem ( 1, "ADR_1",			stNul.str )
	dw_1.SetItem ( 1, "ADR_2",			stNul.str )
	dw_1.SetItem ( 1, "ADR_CP",		stNul.str )
	dw_1.SetItem ( 1, "ADR_VILLE",	stNul.str )
	dw_1.SetItem ( 1, "NUM_TELD",		stNul.str )
	dw_1.SetItem ( 1, "NUM_TELB",		stNul.str )
	dw_1.SetItem ( 1, "NUM_FAX",		stNul.str )

	dw_1.SetItem ( 1, "RIB_BQ",		stNul.str )
	dw_1.SetItem ( 1, "RIB_GUI",		stNul.str )
	dw_1.SetItem ( 1, "RIB_CPT",		stNul.str )
	dw_1.SetItem ( 1, "RIB_CLE",		stNul.str )

	// #1
	dw_1.SetItem ( 1, "ALT_SUIVI_MAIL",	"N" )
	dw_1.SetItem ( 1, "ADR_MAIL_NAME",	stNul.str )
	dw_1.SetItem ( 1, "ADR_MAIL_DOMAIN",	stNul.str )

	iuoGsSpInterlocuteur.Uf_Traitement ( 9, stPass_Dga )
	dw_1.SetFocus ()
	dw_1.SetColumn ( dw_1.ilPremCol )
	
End If
end event

type uo_ajout from u_spb_ajout_courtyp within w_tm_sp_interlocuteur
integer x = 873
integer y = 316
integer width = 590
integer height = 276
integer taborder = 20
end type

on constructor;call u_spb_ajout_courtyp::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Ajout::Constructor (EXTEND)
//* Evenement 		: Constructor
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 14:57:30
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Les DataWindows sont placées de maniére horizontale.             */
/*------------------------------------------------------------------*/
ibHorizontal	= True

/*------------------------------------------------------------------*/
/* L'objet ne posséde pas de titre.                                 */
/*------------------------------------------------------------------*/
ibTitre			= False

/*------------------------------------------------------------------*/
/* On utilise les boutons en 800x600.                               */
/*------------------------------------------------------------------*/
isTaille			= "8_"

/*------------------------------------------------------------------*/
/* On ne veut pas de RowFocusIndicator.                             */
/*------------------------------------------------------------------*/
ibIndicateur	= False

/*------------------------------------------------------------------*/
/* On ne veut pas de sélection multiple dans la source.             */
/*------------------------------------------------------------------*/
ibSourceSelMul	= False

/*------------------------------------------------------------------*/
/* On ne veut pas d'effet 3D pour l'objet.                          */
/*------------------------------------------------------------------*/
ibEffet3D		= False

/*------------------------------------------------------------------*/
/* On enléve la bordure, qui permet de mieux l'objet pendant le     */
/* développement.                                                   */
/*------------------------------------------------------------------*/
This.Border = False

end on

on ue_dwcible_supprime;call u_spb_ajout_courtyp::ue_dwcible_supprime;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Ajout::Ue_DwCible_Supprime
//* Evenement 		: Ue_DwCible_Supprime
//* Auteur			: Erick John Stark
//* Date				: 27/01/1998 10:55:19
//* Libellé			: 
//* Commentaires	: On positionne un bitmap sur l'onglet
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lTotSource

lTotSource = This.dw_Source.RowCount ()

/*------------------------------------------------------------------*/
/* On positionne un BitMap sur l'onglet pour avertir le             */
/* gestionnaire que des paragraphes sont réclamés.                  */
/*------------------------------------------------------------------*/

If	lTotSource = 0 Then
	Uo_Ong.Uf_ChangerBitmap ( "02", 	"K:\PB4OBJ\BMP\8_ALPCE.BMP" )
End If

This.dw_Cible.SetItem ( ilLigSourceSupp, "CPT_TRI", lTotSource + 1 )

/*------------------------------------------------------------------*/
/* On arme la chaine de recherche pour se positionner sur la ligne  */
/* sélectionnée.                                                    */
/*------------------------------------------------------------------*/
This.isRech = "ID_PARA = '" + This.dw_Cible.GetItemString ( ilLigSourceSupp, "ID_PARA" ) + "'"



end on

on ue_dwsource_supprime;call u_spb_ajout_courtyp::ue_dwsource_supprime;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Ajout::Ue_DwSource_Supprime
//* Evenement 		: Ue_DwSource_Supprime
//* Auteur			: Erick John Stark
//* Date				: 27/01/1998 10:57:27
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lTot, lCptTri, lCpt

lTot = This.dw_Source.RowCount ()

/*------------------------------------------------------------------*/
/* Cet événement est déclenché avant la suppression. S'il ne reste  */
/* qu'une ligne dans dwSource, on enléve le Bitmap.                 */
/*------------------------------------------------------------------*/
If	lTot = 1	Then
	Uo_Ong.Uf_ChangerBitmap ( "02", 	"" )
End If

lCptTri = This.dw_Source.GetItemNumber ( ilLigSourceSupp, "CPT_TRI" )

/*------------------------------------------------------------------*/
/* On arme la chaine de recherche pour se positionner sur la ligne  */
/* sélectionnée.                                                    */
/*------------------------------------------------------------------*/
This.isRech = "ID_PARA = '" + This.dw_Source.GetItemString ( ilLigSourceSupp, "ID_PARA" ) + "'"

For	lCpt = ( ilLigSourceSupp + 1 ) To lTot
		This.dw_Source.SetItem ( lCpt, "CPT_TRI", lCptTri )
		lCptTri ++
Next

end on

on ue_click_plus;call u_spb_ajout_courtyp::ue_click_plus;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_Ajout::Ue_Click_Plus
//* Evenement 		: ue_click_plus
//* Auteur			: Erick John Stark
//* Date				: 12/02/1998 16:39:05
//* Libellé			: Modification ordre du compteur de tri
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Decimal{0}	dcCptTriActuel
Decimal{0}	dcCptTriFutur

Long			lNbLig
Long			lLigCour

String 		sObjet

lNbLig	=	This.Dw_Source.RowCount ( )
lLigCour	=	This.Dw_Source.GetRow ( )
sObjet	=	This.Dw_Source.GetObjectAtPointer ( )

If Pos ( sObjet, "b_moins" ) > 0 Then

	If lLigCour < lNbLig Then

		dcCptTriActuel	=	This.Dw_Source.GetItemNumber ( lLigCour, 	   "CPT_TRI" )
		dcCptTriFutur	=	This.Dw_Source.GetItemNumber ( lLigCour + 1, "CPT_TRI" )

		This.Dw_Source.SetItem ( lLigCour, 		"CPT_TRI", dcCptTriFutur 	)
		This.Dw_Source.SetItem ( lLigCour + 1, "CPT_TRI", dcCptTriActuel 	)
	End If	
ElseIf Pos ( sObjet, "b_plus" ) > 0 Then

	If lLigCour > 1 Then

		dcCptTriActuel	=	This.Dw_Source.GetItemNumber ( lLigCour, 	   "CPT_TRI" )
		dcCptTriFutur	=	This.Dw_Source.GetItemNumber ( lLigCour - 1, "CPT_TRI" )

		This.Dw_Source.SetItem ( lLigCour, 		"CPT_TRI", dcCptTriFutur 	)
		This.Dw_Source.SetItem ( lLigCour - 1, "CPT_TRI", dcCptTriActuel 	)
	End If
End If
end on

on ue_dimensionner;call u_spb_ajout_courtyp::ue_dimensionner;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Ajout::Ue_Dimensionner
//* Evenement 		: Ue_Dimensionner
//* Auteur			: Erick John Stark
//* Date				: 22/01/1998 11:51:31
//* Libellé			: 
//* Commentaires	: On rend invisible les boutons permettant de supprimer ou d'ajouter tout
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.pb_Enlever_Tout.Visible = False
This.pb_Ajouter_Tout.Visible = False
end on

on uo_ajout.destroy
call u_spb_ajout_courtyp::destroy
end on

type dw_lst_frais from u_datawindow_detail within w_tm_sp_interlocuteur
integer x = 1682
integer y = 300
integer width = 443
integer height = 276
integer taborder = 30
string dataobject = "d_sp_sin_lst_frais"
boolean vscrollbar = true
boolean border = false
boolean livescroll = false
end type

on ue_modifiermenu;call u_datawindow_detail::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_Lst_Frais::Ue_ModifierMenu
//* Evenement 		: Ue_ModifierMenu
//* Auteur			: Erick John Stark
//* Date				: 15/01/1998 14:25:28
//* Libellé			: 
//* Commentaires	: Pas de suppresiion d'un frais à partir du menu contextuel
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.Uf_Mnu_SupprimerItem ( 3 )

/*------------------------------------------------------------------*/
/* En validation ou en consultation, on ne doit pas voir le PopUp   */
/* Menu CREER                                                       */
/*------------------------------------------------------------------*/



If isTypeTrt <> "S" Then 
	This.Uf_Mnu_CacherItem  ( 1 )
	This.Uf_Mnu_ChangerText ( 2, "&Consulter" )
End If


end on

type p_focus from picture within w_tm_sp_interlocuteur
boolean visible = false
integer x = 3141
integer y = 172
integer width = 91
integer height = 76
boolean bringtotop = true
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\focus_1.bmp"
boolean focusrectangle = false
end type

type dw_wfrais_supp from datawindow within w_tm_sp_interlocuteur
boolean visible = false
integer x = 2711
integer y = 68
integer width = 192
integer height = 88
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_lst_sin_w_frais_supp"
end type

type uo_courrier_word from u_spb_cp_2000 within w_tm_sp_interlocuteur
integer x = 2633
integer y = 856
integer taborder = 130
end type

on ue_part_saisir;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Courrier_Word::Ue_Part_Saisir (OVERRIDE)
//* Evenement 		: Ue_Part_Saisir
//* Auteur			: Erick John Stark
//* Date				: 15/07/1998 14:05:09
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ 			PAR		Date		Modification
//*	?			DBI		18/11/98 Ajout insertion auto paragraphe entête 	  
//* DCMP990453	JFF		29/09/99 Ajout insertion auto formule politesse
//*										et coupon réponse sur CP.
//* DCMP030483 JFF  #1  07/01/04 Ajout d'une nouvelle fonctionnalité permettant
//*										de choisir son modèle de CP parmi toutes les natures
//* 										dispo pour le produit.
//*-----------------------------------------------------------------

String	sPara, sParaTempo[], sVersion, sCompoCPart, sVal
Int		iCpt, iTot
s_Choix_Modele_CP stModCour
DataWindowChild dwChild

stMessage.sTitre		= "Gestion des interlocuteurs - SIMPA2"
stMessage.bErreurG	= False
stMessage.Icon			= Information!
stMessage.bouton		= Ok!
stMessage.sCode		= "WINT150"

/*------------------------------------------------------------------*/
/* Si le gestionnaire réclame un questionnaire, la saisie d'un      */
/* courrier particulier est interdite.                              */
/*------------------------------------------------------------------*/
If	dw_1.GetItemString ( 1, "ALT_QUEST" ) = "O"	Then

	stMessage.sVar[1]		= "un QUESTIONNAIRE"
	stMessage.sVar[2]		= "un COURRIER PARTICULIER"

	F_Message ( stMessage )

/*------------------------------------------------------------------*/
/* Si la personne réclame un courrier gestionnaire, la saisie d'un  */
/* courrier particulier est interdite.                              */
/*------------------------------------------------------------------*/
ElseIf dw_1.GetItemString ( 1, "ALT_COURGEST" ) = "R"	Then

	stMessage.sVar[1]		= "un COURRIER GESTIONNAIRE"
	stMessage.sVar[2]		= "un COURRIER PARTICULIER"

	F_Message ( stMessage )

/*------------------------------------------------------------------*/
/* S'il existe des paragraphes d'informations, la saisie d'un       */
/* courrier particulier est interdite.                              */
/*------------------------------------------------------------------*/
ElseIf uo_Ajout.dw_Source.RowCount () > 0	Then

	stMessage.sVar[1]		= "des PARAGRAPHES D'INFORMATIONS"
	stMessage.sVar[2]		= "un COURRIER PARTICULIER"

	F_Message ( stMessage )

Else

/*------------------------------------------------------------------*/
/* Insertion du paragraphe d'entête banque ou assuré en fonction    */
/* du type d'interlocuteur                                          */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* DCMP990453 : Ajout insertion auto formule politesse et coupon    */
/*              réponse sur CP.												  */
/*------------------------------------------------------------------*/
   sPara = ""
/*------------------------------------------------------------------*/
/* #1 DCMP030483 JFF le 07/01/2004                                  */
/*------------------------------------------------------------------*/
/* Ouverture d'une Response.                                        */
/*------------------------------------------------------------------*/
	Choose Case dw_1.GetItemString ( 1, "ALT_PART" ) 

		Case "N", "E"
			dw_1.GetChild ( "ID_NAT_COUR", dwChild )
			stModCour.dwNatCour = dwChild
		
			OpenWithParm ( w_t_sp_choix_courrier_cp, stModCour )
			stModCour = Message.PowerObjectParm

			If stModCour.sIdCour = "RETOUR" Then
				Return 
			End If

		Case "O"
			stModCour.sIdCour = "" 		
	End Choose 

/*------------------------------------------------------------------*/
/* #2 On vérifie si le modele Word est adapté au Produit, sinon on  */
/* le modifie.                                                      */
/*------------------------------------------------------------------*/
Parent.Wf_VerifierModeleWord ( )

/*------------------------------------------------------------------*/
/* #1 Si la compo revient vide, le gestionnaire a choisi le CP      */
/* standard SPB, donc on aiguille vers le code existant ci-dessous. */
/*------------------------------------------------------------------*/
	If stModCour.sIdCour = "" Then 
		Choose Case Dw_1.GetItemString ( 1, "COD_INTER" )
			Case "B"						// Interlocuteur type banque
				sParaTempo[1]	=	"IB01"
				sParaTempo[2]	=	"FP02"
				sParaTempo[3]	=	"CR01"

			Case Else					// tous les autres cas ( assuré inclus )
				sParaTempo[1]	=	"IA01"
				sParaTempo[2]	=	"FP01"
				sParaTempo[3]	=	"CR01"
		End Choose

	/*------------------------------------------------------------------*/
	/* Lecture de la version actuelle du paragraphe                     */
	/*------------------------------------------------------------------*/
		iTot  = UpperBound ( sParaTempo )
		For iCpt = 1 to iTot  

			sVersion = "   "

			itrTrans.IM_S02_PARAGRAPHE ( sParaTempo [ iCpt ], sVersion )
			If	Not F_Procedure ( stMessage, itrTrans, "IM_S02_PARAGRAPHE" )	Then 

	/*------------------------------------------------------------------*/
	/* Il y a une erreur dans l'appel de la procédure, la structure     */
	/* stMessage vient d'être armée, on affiche le message.             */
	/*------------------------------------------------------------------*/

				f_Message ( stMessage )
				sParaTempo [ iCpt ]	= ""
			Else

				sParaTempo [ iCpt ] += "." + sVersion

			End If

		   sPara += sParaTempo [ iCpt ]
		Next
	End If

/*------------------------------------------------------------------*/
/* #1 Si la compo ne revient pas vide, le gestionnaire a alors      */
/* choisi comme modèle de CP une composition de courrier existant.  */
/* On aiguille alors sur le nouveau code ci-dessous.					  */
/*------------------------------------------------------------------*/
	If stModCour.sIdCour <> "" Then 

		sCompoCPart = Space ( 248 )
		itrTrans.PS_S01_COMPOSITION ( stModCour.sIdCour, sCompoCPart  )

		iTot = Len ( sCompoCPart ) / 8
		For iCpt = 1 To iTot
			sVal = Upper ( Mid ( sCompoCPart, 1 + ( 8 * ( iCpt - 1) ) , 8 ) )

			// On supprime tout ce qui ne servira pas
			Choose Case Left ( sVal, 4 )
				Case "MACP", "PIEC", "MACI", "POST"	
					Continue
			End Choose
			sPara += sVal
		Next
	End If

/*------------------------------------------------------------------*/
/* Armement du paragraphe à insérer                                 */
/*------------------------------------------------------------------*/
	uf_Init_Para ( { "", "", sPara } )
	Call Super::Ue_Part_Saisir
End If


end on

on ue_piece_saisir;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Courrier_Word::Ue_Piece_Saisir (OVERRIDE)
//* Evenement 		: Ue_Piece_Saisir
//* Auteur			: Erick John Stark
//* Date				: 15/07/1998 14:05:09
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

stMessage.sTitre		= "Gestion des interlocuteurs - SIMPA2"
stMessage.bErreurG	= False
stMessage.Icon			= Information!
stMessage.bouton		= Ok!
stMessage.sCode		= "WINT150"

/*------------------------------------------------------------------*/
/* Si le gestionnaire réclame un questionnaire, la saisie d'une     */
/* autre pièce est interdite.                                       */
/*------------------------------------------------------------------*/
If	dw_1.GetItemString ( 1, "ALT_QUEST" ) = "O"	Then

	stMessage.sVar[1]		= "un QUESTIONNAIRE"
	stMessage.sVar[2]		= "une AUTRE PIECE"

	F_Message ( stMessage )

/*------------------------------------------------------------------*/
/* Si la personne réclame un courrier gestionnaire, la saisie d'une */
/* autre pièce est interdite.                                       */
/*------------------------------------------------------------------*/
ElseIf dw_1.GetItemString ( 1, "ALT_COURGEST" ) = "R"	Then

	stMessage.sVar[1]		= "un COURRIER GESTIONNAIRE"
	stMessage.sVar[2]		= "une AUTRE PIECE"

	F_Message ( stMessage )

Else
	Call Super::Ue_Piece_Saisir
End If
end on

on ue_part_effacer;call u_spb_cp_2000::ue_part_effacer;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Courrier_Word::Ue_Part_Effacer (EXTEND)
//* Evenement 		: Ue_Part_Effacer
//* Auteur			: Erick John Stark
//* Date				: 15/07/1998 14:05:09
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On vient de supprimer un courrier particulier. On vient de       */
/* faire un SetItem sur ALT_PART à E, donc on rend l'onglet sur     */
/* les paragraphes d'info accessible. (Si besoin)                   */
/*------------------------------------------------------------------*/
iUoGsSpInterlocuteur.Uf_Gestion_Onglet ( 4 )



end on

on ue_part_sauver;call u_spb_cp_2000::ue_part_sauver;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Courrier_Word::Ue_Part_Sauver (EXTEND)
//* Evenement 		: Ue_Part_Sauver
//* Auteur			: Erick John Stark
//* Date				: 15/07/1998 14:05:09
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On vient de sauvegarder un courrier particulier. On vient de     */
/* faire un SetItem sur ALT_PART à OUI, donc on rend l'onglet sur   */
/* les paragraphes d'info inaccessible.                             */
/*------------------------------------------------------------------*/
iUoGsSpInterlocuteur.Uf_Gestion_Onglet ( 3 )



end on

on ue_part_select;call u_spb_cp_2000::ue_part_select;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Courrier_Word::Ue_Part_Select (EXTEND)
//* Evenement 		: Ue_Part_Select
//* Auteur			: Erick John Stark
//* Date				: 23/06/1998 16:09:14
//* Libellé			: 
//* Commentaires	: On recupére le Courrier particulier
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lIdSin, lIdInter

lIdSin	= dw_1.GetItemNumber ( 1, "ID_SIN" )
lIdInter	= dw_1.GetItemNumber ( 1, "ID_I" )

SELECTBLOB	sysadm.w_inter_blob.txt_blob
INTO			:iblDoc
FROM			sysadm.w_inter_blob
WHERE			sysadm.w_inter_blob.id_sin				= :lIdSin
AND			sysadm.w_inter_blob.id_i				= :lIdInter
AND			sysadm.w_inter_blob.id_typ_blob		= 'CP'
USING			itrTrans		;
end on

on ue_piece_select;call u_spb_cp_2000::ue_piece_select;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Courrier_Word::Ue_Piece_Select (EXTEND)
//* Evenement 		: Ue_Piece_Select
//* Auteur			: Erick John Stark
//* Date				: 23/06/1998 16:09:14
//* Libellé			: 
//* Commentaires	: On récupére le paragraphe AUTRE PIECE
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lIdSin, lIdInter

lIdSin	= dw_1.GetItemNumber ( 1, "ID_SIN" )
lIdInter	= dw_1.GetItemNumber ( 1, "ID_I" )

SELECTBLOB	sysadm.w_inter_blob.txt_blob
INTO			:iblDoc
FROM			sysadm.w_inter_blob
WHERE			sysadm.w_inter_blob.id_sin				= :lIdSin
AND			sysadm.w_inter_blob.id_i				= :lIdInter
AND			sysadm.w_inter_blob.id_typ_blob		= 'PC'
USING			itrTrans		;



end on

on uo_courrier_word.destroy
call u_spb_cp_2000::destroy
end on

on ue_post_select;call u_spb_cp_2000::ue_post_select;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Courrier_Word::Ue_Post_Select (EXTEND)
//* Evenement 		: Ue_Post_Select
//* Auteur			: Erick John Stark
//* Date				: 23/06/1998 16:09:14
//* Libellé			: 
//* Commentaires	: On recupére le Post-Scriptum
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lIdSin, lIdInter

lIdSin	= dw_1.GetItemNumber ( 1, "ID_SIN" )
lIdInter	= dw_1.GetItemNumber ( 1, "ID_I" )

SELECTBLOB	sysadm.w_inter_blob.txt_blob
INTO			:iblDoc
FROM			sysadm.w_inter_blob
WHERE			sysadm.w_inter_blob.id_sin				= :lIdSin
AND			sysadm.w_inter_blob.id_i				= :lIdInter
AND			sysadm.w_inter_blob.id_typ_blob		= 'PS'
USING			itrTrans		;



end on

on ue_post_saisir;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Courrier_Word::Ue_Post_Saisir (OVERRIDE)
//* Evenement 		: Ue_Post_Saisir
//* Auteur			: Erick John Stark
//* Date				: 15/07/1998 14:05:09
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

stMessage.sTitre		= "Gestion des interlocuteurs - SIMPA2"
stMessage.bErreurG	= False
stMessage.Icon			= Information!
stMessage.sCode		= "WINT150"
stMessage.bouton		= Ok!

/*------------------------------------------------------------------*/
/* Si le gestionnaire réclame un questionnaire, la saisie du        */
/* post-scriptum est interdite.                                     */
/*------------------------------------------------------------------*/
If	dw_1.GetItemString ( 1, "ALT_QUEST" ) = "O"	Then

	stMessage.sVar[1]		= "un QUESTIONNAIRE"
	stMessage.sVar[2]		= "un POST_SCRIPTUM"

	F_Message ( stMessage )

/*------------------------------------------------------------------*/
/* Si la personne réclame un courrier gestionnaire, la saisie d'un  */
/* post-scriptum est interdite.                                     */
/*------------------------------------------------------------------*/
ElseIf dw_1.GetItemString ( 1, "ALT_COURGEST" ) = "R"	Then

	stMessage.sVar[1]		= "un COURRIER GESTIONNAIRE"
	stMessage.sVar[2]		= "un POST_SCRIPTUM"

	F_Message ( stMessage )

Else
	Call Super::Ue_Post_Saisir
End If

end on

type uo_consult_euro from u_consultation_euro within w_tm_sp_interlocuteur
integer x = 978
integer y = 8
integer taborder = 110
end type

on uo_consult_euro.destroy
call u_consultation_euro::destroy
end on

type cb_commune from commandbutton within w_tm_sp_interlocuteur
integer x = 2651
integer y = 252
integer width = 82
integer height = 72
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "..."
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : cb_Commune
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
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

s_Commune	stCom			// Structure dw_Commune

This.Enabled = FALSE

stCom.dw_Commune = istPass.dwNorm [ 9 ]


/*------------------------------------------------------------------*/
/* Ouverture d'une Response.                                        */
/*------------------------------------------------------------------*/
OpenWithParm ( w_rech_Commune, stCom )

stCom = Message.PowerObjectParm

/*------------------------------------------------------------------*/
/* On est ressorti en validant notre choix.                         */
/*------------------------------------------------------------------*/
If stCom.bValider Then
	dw_1.SetItem ( 1, "ADR_CP", stCom.sCP )
	dw_1.SetItem ( 1, "ADR_VILLE", stCom.sCommune )
End If 

This.Enabled = TRUE



end on

type lb_fichier from listbox within w_tm_sp_interlocuteur
boolean visible = false
integer x = 457
integer y = 1104
integer width = 165
integer height = 120
integer taborder = 150
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type cb_courpart from commandbutton within w_tm_sp_interlocuteur
boolean visible = false
integer x = 174
integer y = 1368
integer width = 407
integer height = 88
integer taborder = 170
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Courrier Part."
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: Cb_CourPart			(EXTEND)
//* Evénement		: Clicked!
//* Auteur			: Fabry JF
//* Date				: 22/03/2004 16:10:01
//* Libellé			: 
//* Commentaires	: On génére un courrier particulier pour l'interlocuteur
//*
//* Arguments		: 
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification
//           JFF   12/06/2014 [PI052]
//*-----------------------------------------------------------------

String sDataInter[], sVal
Long lIdInter
Boolean bPI052_GenEdtKsl 
Long lDeb, lFin
n_cst_string lnvPFCString

bPI052_GenEdtKsl = False // [PI052]

Dw_1.AcceptText ()

/*------------------------------------------------------------------*/
/* En Validation et en Consultation, le bouton est interdit.        */
/*------------------------------------------------------------------*/
If	isTypeTrt = "C"	Then
	stMessage.sTitre		= "Cb_CourPart ()"
	stMessage.sVar[1]		= "consultation"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "SVAL60"
	stMessage.bTrace  	= False

	F_Message ( stMessage )

	Return
End If

If	isTypeTrt = "V"	Then
	stMessage.sTitre		= "Cb_CourPart ()"
	stMessage.sVar[1]		= "validation"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "SVAL60"
	stMessage.bTrace  	= False

	F_Message ( stMessage )

	Return
End If

/*------------------------------------------------------------------*/
/* Je suis obligé d'utiliser cette manipulation monstrueuse afin    */
/* de récupérer les variables de l'interlocuteur en cours de        */
/* traitement.                                                      */
/*------------------------------------------------------------------*/

// [PI052]
/*
If F_CLE_A_TRUE ( "PI052" ) Then
	F_RechDetPro ( lDeb, lFin, idw_DetPro, iDw_Wsin.GetItemNumber( 1, "ID_PROD" ), "-DP", 262 )
	If lDeb > 0 Then
		
		sVal = lnvPFCString.of_getkeyvalue (idw_DetPro.GetItemString ( lDeb, "VAL_CAR" ), "PHASE_RECETTE", ";")
		
		If Len ( Trim ( sVal ) ) = 0 Then
			bPI052_GenEdtKsl = TRUE
		End If
		
		If Len ( Trim ( sVal ) ) > 0 Then
			If Pos ( sVal, "#" + stGlb.sCodOper + "#" ) > 0 Then
				bPI052_GenEdtKsl = TRUE
			End If
		End If
	End If 
	
	If Not bPI052_GenEdtKsl Then 
		invSaisieValInter.uf_BtCPart_SIMPA2 ( isBlobDataCP )	
	Else
		stMessage.sTitre		= "PI052 Courrier KSL"
		stMessage.Icon			= Information!
		stMessage.sCode		= "PI52005"
		stMessage.bTrace  	= False
		F_Message ( stMessage )
		
	End If
	
Else */
	invSaisieValInter.uf_BtCPart_SIMPA2 ( isBlobDataCP )
// End If	

end event

type cb_effacer from commandbutton within w_tm_sp_interlocuteur
boolean visible = false
integer x = 174
integer y = 1472
integer width = 407
integer height = 88
integer taborder = 180
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Effacer"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: Cb_Effacer			(EXTEND)
//* Evénement		: Clicked!
//* Auteur			: Fabry JF
//* Date				: 22/02/2004 16:10:01
//* Libellé			: 
//* Commentaires	: On efface les fichiers présents en local
//*
//* Arguments		: 
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* En Validation et en Consultation, le bouton est interdit.        */
/*------------------------------------------------------------------*/
If	isTypeTrt = "C"	Then
	stMessage.sTitre		= "Cb_CourPart ()"
	stMessage.sVar[1]		= "consultation"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "SVAL60"
	stMessage.bTrace  	= False

	F_Message ( stMessage )

	Return
End If

If	isTypeTrt = "V"	Then
	stMessage.sTitre		= "Cb_CourPart ()"
	stMessage.sVar[1]		= "validation"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "SVAL60"
	stMessage.bTrace  	= False

	F_Message ( stMessage )

	Return
End If

invSaisieValInter.uf_BtSupCPart ( 1 )
end on

type dw_compo from datawindow within w_tm_sp_interlocuteur
boolean visible = false
integer x = 169
integer y = 1232
integer width = 256
integer height = 120
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_sp_sve_lst_paragraphe"
end type

type dw_gencourrier from datawindow within w_tm_sp_interlocuteur
boolean visible = false
integer x = 165
integer y = 1096
integer width = 265
integer height = 120
integer taborder = 160
boolean bringtotop = true
string dataobject = "d_stk_generation_courrier"
boolean livescroll = true
end type

