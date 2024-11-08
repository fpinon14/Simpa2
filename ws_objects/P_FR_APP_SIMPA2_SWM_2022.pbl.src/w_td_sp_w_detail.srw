$PBExportHeader$w_td_sp_w_detail.srw
$PBExportComments$-} Fenêtre de traitement pour la saisie des détails.
forward
global type w_td_sp_w_detail from w_8_traitement_detail
end type
type uo_ong from u_onglets within w_td_sp_w_detail
end type
type uo_3d from u_bord3d within w_td_sp_w_detail
end type
type uo_piece from u_tagger within w_td_sp_w_detail
end type
type uo_refus from u_tagger within w_td_sp_w_detail
end type
type dw_wplaf_detail from datawindow within w_td_sp_w_detail
end type
type uo_consult_euro from u_consultation_euro within w_td_sp_w_detail
end type
type cb_supp_cmde from commandbutton within w_td_sp_w_detail
end type
type dw_w_commande from u_datawindow_detail within w_td_sp_w_detail
end type
type dw_info_cmde from datawindow within w_td_sp_w_detail
end type
type cb_commander from commandbutton within w_td_sp_w_detail
end type
type cb_tarif from commandbutton within w_td_sp_w_detail
end type
type cb_gamme from picturebutton within w_td_sp_w_detail
end type
type dw_choix_action from datawindow within w_td_sp_w_detail
end type
type cb_valachdef from commandbutton within w_td_sp_w_detail
end type
type dw_w_div_det from u_datawindow_detail within w_td_sp_w_detail
end type
type st_pec from statictext within w_td_sp_w_detail
end type
type st_labpec from statictext within w_td_sp_w_detail
end type
type cb_valid_factu from commandbutton within w_td_sp_w_detail
end type
type cb_dty_jff from commandbutton within w_td_sp_w_detail
end type
type st_mode_reprise from statictext within w_td_sp_w_detail
end type
type cb_aide_mode_reprise from commandbutton within w_td_sp_w_detail
end type
end forward

global type w_td_sp_w_detail from w_8_traitement_detail
integer width = 3598
integer height = 1768
event ue_quitteronglet011 pbm_custom01
event ue_quitteronglet021 pbm_custom02
event ue_quitteronglet031 pbm_custom03
event ue_affichage pbm_custom04
event ue_entreronglet011 pbm_custom05
event ue_entreronglet041 pbm_custom06
event ue_setfocus pbm_custom69
event ue_taillefenetre ( )
uo_ong uo_ong
uo_3d uo_3d
uo_piece uo_piece
uo_refus uo_refus
dw_wplaf_detail dw_wplaf_detail
uo_consult_euro uo_consult_euro
cb_supp_cmde cb_supp_cmde
dw_w_commande dw_w_commande
dw_info_cmde dw_info_cmde
cb_commander cb_commander
cb_tarif cb_tarif
cb_gamme cb_gamme
dw_choix_action dw_choix_action
cb_valachdef cb_valachdef
dw_w_div_det dw_w_div_det
st_pec st_pec
st_labpec st_labpec
cb_valid_factu cb_valid_factu
cb_dty_jff cb_dty_jff
st_mode_reprise st_mode_reprise
cb_aide_mode_reprise cb_aide_mode_reprise
end type
global w_td_sp_w_detail w_td_sp_w_detail

type variables
Private :
	u_DataWindow		idwWsin

	u_gs_sp_Sinistre_wDetail	iuoGsSpwDetail
	String			isTypeTrt
	String			isDetailActif
	String			isReferentiel

	W_Sp_Gs_W_Commande3	iW_Sp_Gs_W_Commande3

	Long			ilRetGamme
	Long			ilMarquaGeBLCODE // [BLCODE]

	Boolean		ibBrisEcran // [DT447]

	u_DataWindow		idwWDivSin, idwLstCmdeSin, idwLstDetail
	u_DataWindow_Detail	idwDivDetGti

	DataWindow		idwDetPro
	DataWindow		idwProduit
	DataWindow		idwStkIfr, idwCodEquiv
	DataWindow		idwFourn
	DataWindow		idwStkCodicDarty 
	DataWindow		idwAutorisation
	DataWindow		idwDivPDet
	Datawindow			idwPieceGti	// [VDoc4274]
end variables

forward prototypes
private subroutine wf_positionnerobjets ()
public function boolean wf_preparermodifier ()
public function boolean wf_preparerinserer ()
public function boolean wf_preparervalider ()
public function boolean wf_preparersupprimer ()
public function string wf_controlersaisie ()
private subroutine wf_fermer_consulter_paragraphe ()
private subroutine wf_tb_consultation ()
private function boolean wf_cmde_sur_gti ()
private function boolean wf_condition_ouverture (string aschoixaction)
public function boolean wf_vdoc17797 ()
public subroutine wf_marquageetatpiecesherpa (integer aid_pce, string asetat_pce, integer aiidi)
public subroutine wf_marquageetatpiecesherpa_rs5656 (integer aid_gti, integer aid_detail, integer aid_pce, string asetat_pce, integer aiidi)
end prototypes

on ue_quitteronglet011;call w_8_traitement_detail::ue_quitteronglet011;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_W_Detail::Ue_QuitterOngler011
//* Evenement 		: Ue_QuitterOngler011
//* Auteur			: Erick John Stark
//* Date				: 05/02/1998 15:50:39
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Si la fenêtre de consultation des paragraphes est visible, on    */
/* la rend invisible.                                               */
/*------------------------------------------------------------------*/
Wf_Fermer_Consulter_Paragraphe ()

cb_valachdef.Visible = False

/*------------------------------------------------------------------*/
/* On déclenche un ItemFocusChanged avant toute chose. Cela         */
/* concerne la zone ID_EVT.                                         */
/*------------------------------------------------------------------*/

If	dw_1.AcceptText () > 0 Then
	dw_1.TriggerEvent ( ItemFocusChanged! )
Else
	uo_Ong.ibStop = True
End If


end on

on ue_quitteronglet021;call w_8_traitement_detail::ue_quitteronglet021;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_W_Detail::Ue_QuitterOngler021
//* Evenement 		: Ue_QuitterOngler021
//* Auteur			: Erick John Stark
//* Date				: 05/02/1998 15:50:39
//* Libellé			: 
//* Commentaires	: On va quitter l'onglet 02
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Si la fenêtre de consultation des paragraphes est visible, on    */
/* la rend invisible.                                               */
/*------------------------------------------------------------------*/
Wf_Fermer_Consulter_Paragraphe ()

end on

on ue_quitteronglet031;call w_8_traitement_detail::ue_quitteronglet031;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_W_Detail::Ue_QuitterOngler031
//* Evenement 		: Ue_QuitterOngler031
//* Auteur			: Erick John Stark
//* Date				: 05/02/1998 15:50:39
//* Libellé			: 
//* Commentaires	: On va quitter l'onglet 03
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Si la fenêtre de consultation des paragraphes est visible, on    */
/* la rend invisible.                                               */
/*------------------------------------------------------------------*/
Wf_Fermer_Consulter_Paragraphe ()

end on

on ue_affichage;call w_8_traitement_detail::ue_affichage;//*-----------------------------------------------------------------
//*
//* Objet         : w_td_sp_w_detail
//* Evenement     : ue_Affichage
//* Auteur        : Fabry JF
//* Date          : 12/05/2005 16:29:10
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

Long lDeb, lFin, lDeb2

dw_1.SetRedraw ( False )
// Zone Val achat
F_RechDetPro ( lDeb, lFin, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 9 )

// Pour Casto, on affice pas le bouton
F_RechDetPro ( lDeb2, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 43 )

cb_valachdef.Visible = lDeb > 0 And lDeb2 <= 0
cb_valachdef.BringToTop = lDeb > 0 And lDeb2 <= 0

dw_1.SetRedraw ( True )

end on

on ue_entreronglet011;call w_8_traitement_detail::ue_entreronglet011;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_W_Detail::Ue_EntrerOnglet011
//* Evenement 		: Ue_EntrerOnglet011
//* Auteur			: Fabry JF
//* Date				: 18/07/2005
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

TriggerEvent ("ue_affichage")

end on

on ue_entreronglet041;call w_8_traitement_detail::ue_entreronglet041;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_W_Detail::Ue_EntrerOnglet011
//* Evenement 		: Ue_EntrerOnglet011
//* Auteur			: Fabry JF
//* Date				: 18/07/2005
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

dw_w_div_det.SetFocus ()

end on

event ue_setfocus;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_W_Detail::Ue_EntrerOnglet011
//* Evenement 		: Ue_EntrerOnglet011
//* Auteur			: Fabry JF
//* Date				: 18/07/2005
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.PostEvent ("ue_SetFocus", 0, 41 )

end event

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
//* Fonction		: W_Td_Sp_W_Detail::Wf_PositionnerObjets (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 15:27:47
//* Libellé			: 
//* Commentaires	: On positionne et on taille tous les objets
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//      JFF   23/05/2012 [PM103][1]
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne tous les objets nécessaires à la gestion, pour     */
/* faciliter le développement. (On peut bouger les objets).         */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Barre Onglet                                                     */
/*------------------------------------------------------------------*/
Uo_Ong.X			=   10
Uo_Ong.Y			=  269 
Uo_Ong.Width	=  109

/*------------------------------------------------------------------*/
/* Dw_1 et les autres comprises dans l'onglet.                      */
/*------------------------------------------------------------------*/
Dw_1.X			=   33
Dw_1.Y			=  385
Dw_1.Width		= 3484
Dw_1.Height		= 1230

/*------------------------------------------------------------------*/
/* On positionne l'obet de marquage des pièces.                     */
/*------------------------------------------------------------------*/
Uo_Piece.X				= Dw_1.X
Uo_Piece.Y				= Dw_1.Y
Uo_Piece.Width			= Dw_1.Width
Uo_Piece.Height		= Dw_1.Height

/*------------------------------------------------------------------*/
/* On positionne l'obet de marquage des refus.                      */
/*------------------------------------------------------------------*/
Uo_Refus.X				= Dw_1.X
Uo_Refus.Y				= Dw_1.Y
Uo_Refus.Width			= Dw_1.Width
Uo_Refus.Height		= Dw_1.Height

/*------------------------------------------------------------------*/
/* On positionne le bouton Commander.										  */
/*------------------------------------------------------------------*/
cb_Commander.X				= 3031
cb_Commander.Y				= 9
cb_Commander.Width		= 499
cb_Commander.Height		= 89

/*------------------------------------------------------------------*/
/* Datawindow Info Commande.													  */
/*------------------------------------------------------------------*/
dw_info_cmde.X				= 3036
dw_info_cmde.Y				=   101
dw_info_cmde.Width		=  499
dw_info_cmde.Height		=  169

/*------------------------------------------------------------------*/
/* Datawindow Choix Action.													  */
/*------------------------------------------------------------------*/
dw_Choix_Action.X			=  2580
dw_Choix_Action.Y			=  cb_Commander.Y	+ 80
dw_Choix_Action.Width	=  449
dw_Choix_Action.Height	=  217

st_labpec.X			=  2570
st_labpec.Y			=  cb_Commander.Y	+ 10
st_labpec.Width	=  169
st_labpec.Height	=  cb_Commander.Height - 5

st_Pec.X			=  2580 + 172 - 15
st_Pec.Y			=  cb_Commander.Y	
st_Pec.Width	=  449 - 172
st_Pec.Height	=  cb_Commander.Height - 10


/*------------------------------------------------------------------*/
/* On positionne le bouton Annuler commandes								  */
/*------------------------------------------------------------------*/
cb_supp_cmde.X				= 3031
cb_supp_cmde.Y				= 265
cb_supp_cmde.Width		= 499
cb_supp_cmde.Height		= 77

/*------------------------------------------------------------------*/
/* Modification SFR # Le 27/09/02                                   */
/*------------------------------------------------------------------*/
cb_Gamme.X					= cb_Commander.X - 180
cb_Gamme.Y					= dw_info_cmde.Y + 4
cb_Gamme.Width				= 174
cb_Gamme.Height			= 153

/*------------------------------------------------------------------*/
/* Bouton Valeur Achat par Défaut											  */
/*------------------------------------------------------------------*/
cb_valachdef.X				= 2131
cb_valachdef.Y				=  733
cb_valachdef.Width		=  119
cb_valachdef.Height		=   69

dw_w_div_det.X = Dw_1.X
dw_w_div_det.Y = Dw_1.Y
dw_w_div_det.Width =  Dw_1.Width
dw_w_div_det.Height = Dw_1.Height

cb_valid_factu.X = 1687
cb_valid_factu.Y = 8 
cb_valid_factu.Width = 599
cb_valid_factu.Height = 136

// [PM103][1]
st_mode_reprise.X = 1541
st_mode_reprise.Y = 8
st_mode_reprise.Width = 727
st_mode_reprise.Height = 152

cb_aide_mode_reprise.X = 2272
cb_aide_mode_reprise.Y = 8
cb_aide_mode_reprise.Width = 251
cb_aide_mode_reprise.Height = 152
// :[PM103][1]


end subroutine

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_W_Detail::Wf_PreparerModifier
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
//* #1	jca	15/09/2006	dcmp05530 - on grise l'onglet "pieces" si on ne peut pas déterminer la revision
//* #2   JFF   28/01/2008  [DCMP080028]
//* #3	FPI	06/10/2009	[DCMP090595] Ajout du bouton cb_valid_factu
//* #4	FPI	09/02/2010 [DCMP090595.Correctif] On cache le bouton cb_valid_factu quand controler disable
//*		FPI	10/05/2010	 [20100510.FPI] Correction affichage btn valid. factu
//*		FPI	29/07/2010	 [20100729.FPI] Correction activation btn valid. factu
//       JFF   23/05/2012 [PM103][1]
//       JFF   17/09/2019 [DT447]
//*-----------------------------------------------------------------

s_Pass	stPass_Dga
String sMonnaie, sFind
Long		lCodEtatDet, lIdGti, lNumLgn, lDeb, lFin
Boolean	bVisible
boolean bIdRev // #1

/*------------------------------------------------------------------*/
/* Modification SFR # Le 27/09/02 : initialisation de la gamme. La  */
/* valeur -1 signifie que la fenêtre des gammes n'a pas été         */
/* ouverte.                                                         */
/*------------------------------------------------------------------*/
ilRetGamme = -1

ibBrisEcran = False // [DT447]

/*
If stGlb.sCodOper = "JFF" Then
	cb_dty_JFF.Visible = True
	cb_dty_JFF.Enabled = True
End If
*/

/* le 10/03/2006 JFF : Je courcircuite cet init. à cet endroit, cause d'un bug gênant.
   L'init. se fait un fois pour toute sur u_gs_sp_sinitre::uf_preparer_modifier
*/
// gsCasGestionDartyNomade = ""

/*------------------------------------------------------------------*/
/* On arme le titre de la fenêtre avec le titre de la fenêtre       */
/* Parent.                                                          */
/*------------------------------------------------------------------*/
This.Title = istPass.sTab [ 1 ]
isReferentiel  = istPass.sTab [ 8 ]		

stPass_Dga.sTab [1] = isReferentiel

iuoGsSpwDetail.Uf_Traitement ( 2, stPass_Dga )
ilMarquaGeBLCODE = 0

/*------------------------------------------------------------------*/
/* L'accès au bouton 'COMMANDER' est donné en fonction du           */
/* paramètrage (apparition seulement en saisie).                    */
/*------------------------------------------------------------------*/
lCodEtatDet = dw_1.GetItemNumber ( 1, "COD_ETAT" ) 

bVisible = istPass.bTab [ 1 ]	And isTypeTrt = "S" And lCodEtatDet <> 600 And wf_Cmde_Sur_Gti ()
cb_Commander.Visible = bVisible
cb_Commander.Enabled = bVisible
cb_Supp_Cmde.Visible = bVisible
cb_Supp_Cmde.Enabled = bVisible
dw_Info_Cmde.Visible = bVisible

dw_Choix_Action.Visible = cb_Commander.Visible
Choose Case dw_1.GetItemNumber ( 1, "ID_GTI" )
	Case 10
		dw_Choix_Action.SetItem ( 1, "CHOIX_ACTION", "C" )
		cb_Commander.Text = "Commander >>"

	Case 11
		dw_Choix_Action.SetItem ( 1, "CHOIX_ACTION", "R" )
		cb_Commander.Text = "Réparer >>"

	Case else
		dw_Choix_Action.SetItem ( 1, "CHOIX_ACTION", "R" )
		cb_Commander.Text = "Réparer >>"

End Choose 


/*------------------------------------------------------------------*/
/* Zone MT prix publique visible uniquement si Cod_Tel > 0          */
/*------------------------------------------------------------------*/
/* #2 Ce code n'est plus necessaire du fait de la présence de l'option 41 plus bas.
If istPass.dwNorm [ 1 ].GetItemNumber ( 1, "COD_TEL" ) > 0 Then
	dw_1.Modify ( "mt_val_publique.visible = 1 mt_val_publique_t.visible = 1" )
Else 
	dw_1.Modify ( "mt_val_publique.visible = 0 mt_val_publique_t.visible = 0" )
End If
*/

/*------------------------------------------------------------------*/
/* L'accés au bouton SUPPRIMER est géré dans la fonction du NVUO.   */
/*------------------------------------------------------------------*/
pb_Supprimer.Enabled = stPass_Dga.bSupprime

/*------------------------------------------------------------------*/
/* L'accés au bouton CONTROLER est géré dans la fonction du NVUO.   */
/* En effet dans le cas d'un dossier REGLE, il est impossible de    */
/* faire un CTL-VAL.                                                */
/*------------------------------------------------------------------*/
If	stPass_Dga.lTab[1] = 0	Then
	This.pb_Controler.Enabled = False
Else
	This.pb_Controler.Enabled = True
End If

/*------------------------------------------------------------------*/
/* Modification SFR # Le 27/09/2002 : le bouton des gammes est      */
/* visible sur codtel = 21                                          */
/*------------------------------------------------------------------*/
bVisible = FALSE
lIdGti = dw_1.GetItemNumber ( 1, "ID_GTI" )
sFind = "ID_GTI = " + String ( lIdGti ) + " AND ID_CODE_ART = 'TEL'"
lNumLgn = istPass.dwNorm [ 15 ].Find ( sFind, 1, istPass.dwNorm [ 15 ].RowCount () )

If istPass.dwNorm [ 1 ].GetItemNumber ( 1, "COD_TEL" ) = 21 And isTypeTrt = "S" And lNumLgn > 0 Then
	bVisible = TRUE
End If
cb_Gamme.Visible	=	FALSE
cb_Gamme.Enabled	=	FALSE

/*------------------------------------------------------------------*/
/* On arme la valeur de la monnaie avec celle de la fenêtre de      */
/* GARANTIE. (En consultation uniquement).                          */
/*------------------------------------------------------------------*/
If	isTypeTrt = "C"	Then
	sMonnaie = istPass.sTab [ 3 ]
	Uo_Consult_Euro.Uf_Changer_Monnaie ( sMonnaie )
End If

/*------------------------------------------------------------------*/
/* Gestion affichage Zone Valeur publique                           */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idwDetPro, istPass.dwMaster.GetItemNumber ( 1, "ID_PROD" ), '-DP', 41 )
IF lDeb > 0 Then
	dw_1.Modify ( "mt_val_publique_t.visible = 1 mt_val_publique.visible = 1" )
Else 
	dw_1.Modify ( "mt_val_publique_t.visible = 0 mt_val_publique.visible = 0" )
End If 

Uo_Ong.Uf_ActiverOnglet ( "04", dw_w_div_det.RowCount () > 0 )

// Mise en commentaire suite à problème fonctionnel avec le scripting
/*
// #1
// istPass.dwNorm[11] --> datawindow de w_piece
// id_detail <> -1  --> piece demandée au niveau detail de garantie (evenement)
if idwWsin.GetItemNumber ( 1, "ID_REV") = -1 and &
		istPass.dwNorm [ 11 ].Find ( "ID_DETAIL <> -1", 1, istPass.dwNorm [ 11 ].rowcount() ) = 0 then
	bIdRev = false
else 
	bIdRev = true
end if
//Uo_Ong.Uf_ActiverOnglet ( "02", bIdRev ) // pieces
// #1 - FIN
*/

// #3 - [DCMP090595]
if not iuoGsSpwDetail.uf_getautorisation( 208 )Then 
	cb_valid_factu.Enabled = FALSE
	cb_valid_factu.Visible = FALSE
Else // #4 [DCMP090595.Correctif]  - Ajout de l'activation - 
	// [20100510.FPI] 10/05/2010 - pb_controler.Enabled->Visible
	// [20100729.FPI]
	If isTypeTrt ="S" Then
		cb_valid_factu.Enabled = pb_controler.enabled
	Else
		cb_valid_factu.Enabled = FALSE
	End If
//	cb_valid_factu.Enabled = pb_controler.visible
	// :[20100729.FPI]
	cb_valid_factu.Visible = pb_controler.visible
End if
// Fin #3

// [PM103][1]
// A supprimer quand ce sera en prod
cb_aide_mode_reprise.Visible = FALSE
st_mode_reprise.Visible = FALSE
cb_aide_mode_reprise.Visible = iuoGsSpwDetail.uf_GetAutorisation ( 223 )
st_mode_reprise.Visible = iuoGsSpwDetail.uf_GetAutorisation ( 223 )
// :[PM103][1]


Return ( stPass_Dga.bRetour )



end function

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_W_Detail::Wf_PreparerInserer
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 18:25:09
//* Libellé			: 
//* Commentaires	: Opération avant insertion
//*
//* Arguments		: Rien
//*
//* Retourne		: Boolean		Vrai = On peut continuer
//*										Faux = Il y a une erreur
//*
//*-----------------------------------------------------------------
//* #1	jca	15/09/2006	dcmp05530 - on grise l'onglet "pieces" si on ne peut pas déterminer la revision
//* #2	FPI	06/10/2009	[DCMP090595] Ajout du bouton cb_valid_factu
//* #3	FPI	09/02/2010 [DCMP090595.Correctif] On cache le bouton cb_valid_factu quand controler disable
//       JFF   23/05/2012 [PM103][1]
//*-----------------------------------------------------------------

s_Pass	stPass_Dga
Boolean	bVisible
Long		lIdGti, lNumLgn, lDeb, lFin
String	sFind
boolean bIdRev // #1

/*------------------------------------------------------------------*/
/* Modification SFR # Le 27/09/02 : initialisation de la gamme. La  */
/* valeur -1 signifie que la fenêtre des gammes n'a pas été         */
/* ouverte.                                                         */
/*------------------------------------------------------------------*/
ilRetGamme = -1

/*
If stGlb.sCodOper = "JFF" Then
	cb_dty_JFF.Visible = True
	cb_dty_JFF.Enabled = True
End If
*/

/* le 10/03/2006 JFF : Je courcircuite cet init. à cet endroit, cause d'un bug gênant.
   L'init. se fait un fois pour toute sur u_gs_sp_sinitre::uf_preparer_modifier
*/
// gsCasGestionDartyNomade = ""

/*------------------------------------------------------------------*/
/* On arme le titre de la fenêtre avec le titre de la fenêtre       */
/* Parent.                                                          */
/*------------------------------------------------------------------*/
This.Title = istPass.sTab [ 1 ]
isReferentiel  = istPass.sTab [ 8 ]		

stPass_Dga.sTab [1] = isReferentiel

ilMarquaGeBLCODE = 0

iuoGsSpwDetail.Uf_Traitement ( 3, stPass_Dga )

/*------------------------------------------------------------------*/
/* L'accès au bouton 'COMMANDER' est donné en fonction du           */
/* paramètrage (apparition seulement en saisie).                    */
/*------------------------------------------------------------------*/
bVisible = istPass.bTab [ 1 ]	And isTypeTrt = "S" And wf_Cmde_Sur_Gti ()

cb_Commander.Visible = bVisible
cb_Commander.Enabled = bVisible
cb_Supp_Cmde.Visible = bVisible
cb_Supp_Cmde.Enabled = bVisible
dw_Info_Cmde.Visible = bVisible

dw_Choix_Action.Visible = cb_Commander.Visible
Choose Case dw_1.GetItemNumber ( 1, "ID_GTI" )
	Case 10
		dw_Choix_Action.SetItem ( 1, "CHOIX_ACTION", "C" )
		cb_Commander.Text = "Commander >>"

	Case 11
		dw_Choix_Action.SetItem ( 1, "CHOIX_ACTION", "R" )
		cb_Commander.Text = "Réparer >>"

	Case else
		dw_Choix_Action.SetItem ( 1, "CHOIX_ACTION", "R" )
		cb_Commander.Text = "Réparer >>"

End Choose 

/*------------------------------------------------------------------*/
/* Modification SFR # Le 27/09/2002 : le bouton des gammes est      */
/* visible sur codtel = 21                                          */
/*------------------------------------------------------------------*/
bVisible = FALSE
lIdGti = dw_1.GetItemNumber ( 1, "ID_GTI" )
sFind = "ID_GTI = " + String ( lIdGti ) + " AND ID_CODE_ART = 'TEL'"
lNumLgn = istPass.dwNorm [ 15 ].Find ( sFind, 1, istPass.dwNorm [ 15 ].RowCount () )

If istPass.dwNorm [ 1 ].GetItemNumber ( 1, "COD_TEL" ) = 21 And isTypeTrt = "S" And lNumLgn > 0 Then
	bVisible = TRUE
End If
cb_Gamme.Visible	=	FALSE
cb_Gamme.Enabled	=	FALSE

/*------------------------------------------------------------------*/
/* On autorise le bouton CONTROLE. Il est peut-être désactivé (Cas  */
/* d'un dossier REGLE).                                             */
/*------------------------------------------------------------------*/
This.pb_Controler.Enabled = True

/*------------------------------------------------------------------*/
/* Gestion affichage Zone Valeur publique                           */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idwDetPro, istPass.dwMaster.GetItemNumber ( 1, "ID_PROD" ), '-DP', 41 )
IF lDeb > 0 Then
	dw_1.Modify ( "mt_val_publique_t.visible = 1 mt_val_publique.visible = 1" )
Else 
	dw_1.Modify ( "mt_val_publique_t.visible = 0 mt_val_publique.visible = 0" )
End If 


Uo_Ong.Uf_ActiverOnglet ( "04", dw_w_div_det.RowCount () > 0 )

// Mise en commentaire suite à problème fonctionnel avec le scripting
/*
// #1
// istPass.dwNorm[11] --> datawindow de w_piece
// id_detail <> -1  --> piece demandée au niveau detail de garantie (evenement)

if idwWsin.GetItemNumber ( 1, "ID_REV") = -1 and &
		istPass.dwNorm [ 11 ].Find ( "ID_DETAIL <> -1", 1, istPass.dwNorm [ 11 ].rowcount() ) = 0 then
	bIdRev = false
else 
	bIdRev = true
end if
//Uo_Ong.Uf_ActiverOnglet ( "02", bIdRev ) // pieces
// #1 - FIN
*/

// #2 - [DCMP090595]
if not iuoGsSpwDetail.uf_getautorisation( 208 ) Then
	cb_valid_factu.Enabled = FALSE
	cb_valid_factu.Visible = FALSE
	
Else	//* #3 [DCMP090595.Correctif] 
	cb_valid_factu.Enabled = pb_controler.Enabled
	cb_valid_factu.Visible = pb_controler.Enabled
End if
// Fin #2

// [PM103][1]
// A supprimer quand ce sera en prod
cb_aide_mode_reprise.Visible = FALSE
st_mode_reprise.Visible = FALSE
cb_aide_mode_reprise.Visible = iuoGsSpwDetail.uf_GetAutorisation ( 223 )
st_mode_reprise.Visible = iuoGsSpwDetail.uf_GetAutorisation ( 223 )
// :[PM103][1]


Return ( True )




end function

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_W_Detail::Wf_PreparerValider
//* Auteur			: Erick John Stark
//* Date				: 28/01/1998 09:27:24
//* Libellé			: 
//* Commentaires	: On veut valider un détail
//*
//* Arguments		: 
//*
//* Retourne		: Boolean		True	= La validation va continuer
//*										False = La validation s'arrete.
//*
//*-----------------------------------------------------------------

s_Pass stPass_Dga

/*------------------------------------------------------------------*/
/* Si la fenêtre de consultation des paragraphes est visible, on    */
/* la rend invisible.                                               */
/*------------------------------------------------------------------*/
Wf_Fermer_Consulter_Paragraphe ()

stPass_Dga.bInsert = istPass.bInsert
iuoGsSpwDetail.Uf_Traitement ( 6, stPass_Dga )

Return ( True )

end function

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_W_Detail::Wf_PreparerSupprimer
//* Auteur			: Erick John Stark
//* Date				: 28/01/1998 09:27:24
//* Libellé			: 
//* Commentaires	: On veut supprimer le détail
//*
//* Arguments		: 
//*
//* Retourne		: Boolean		True	= La suppression va continuer
//*										False = La suppression s'arrete.
//*
//*-----------------------------------------------------------------

s_Pass stPass_Dga

/*------------------------------------------------------------------*/
/* Si la fenêtre de consultation des paragraphes est visible, on    */
/* la rend invisible.                                               */
/*------------------------------------------------------------------*/
Wf_Fermer_Consulter_Paragraphe ()

iuoGsSpwDetail.Uf_Traitement ( 10, stPass_Dga )

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

/*------------------------------------------------------------------*/
/* Si la fenêtre de consultation des paragraphes est visible, on    */
/* la rend invisible.                                               */
/*------------------------------------------------------------------*/
Wf_Fermer_Consulter_Paragraphe ()

iuoGsSpwDetail.Uf_Traitement ( 4, stPass_Dga )

If	stPass_Dga.lTab [ 1 ] = 1 Then
	Wf_Changer_Controle ( stPass_Dga.dwNorm [ 1 ] )
End If

Return ( stPass_Dga.sTab [ 1 ] ) 




end function

private subroutine wf_fermer_consulter_paragraphe ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_W_Detail::Wf_Fermer_Consulter_Paragraphe (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 16/07/1998 15:00:13
//* Libellé			: 
//* Commentaires	: Si la fenêtre de consultation est ouverte, on la rend invisible
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

If	IsValid ( W_Consulter_Paragraphe ) Then
	If W_Consulter_Paragraphe.Visible = True Then W_Consulter_Paragraphe.Hide ()
End If

/*------------------------------------------------------------------*/
/* Le 28/11/2001.                                                   */
/* Modif DGA. DCMP 010375                                           */
/*------------------------------------------------------------------*/
If	IsValid ( W_Trt_Popup_AidePapier )	Then Close ( W_Trt_Popup_AidePapier )
end subroutine

private subroutine wf_tb_consultation ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_W_Detail::Wf_Tb_Consultation (PRIVATE)
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
//* #1	FPI	06/10/2009	[DCMP090595] Ajout du bouton cb_valid_factu
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 CP
//DataWindow	dwNorm[1]
DataWindow	dwNorm[]
//Fin Migration PB8-WYNIWYG-03/2006 CP

/*------------------------------------------------------------------*/
/* Cette fonction est appelée sur Ue_Initialiser de la fenêtre.     */
/*------------------------------------------------------------------*/

pb_Controler.Visible 	= False
pb_Controler.Enabled 	= False

pb_Valider.Visible 		= False
pb_Valider.Enabled 		= False

pb_Supprimer.Visible 	= False
pb_Supprimer.Enabled 	= False

pb_Imprimer.Visible 		= False
pb_Imprimer.Enabled 		= False

Uo_Consult_Euro.X			= 252
Uo_Consult_Euro.Y			= 9

Uo_Consult_Euro.Visible	= False // [SUISSE].LOT3 Bouton Invisible
Uo_Consult_Euro.Enabled	= False // [SUISSE].LOT3

/*------------------------------------------------------------------*/
/* Le 28/11/2001.                                                   */
/* Modif DGA. DCMP 010375                                           */
/*------------------------------------------------------------------*/
Cb_Tarif.Visible			= FALSE
Cb_Tarif.Enabled			= FALSE

/*------------------------------------------------------------------*/
/* On initialise le tableau de DW pour la consultation EURO.        */
/*------------------------------------------------------------------*/
dwNorm [ 1 ] = dw_1

Uo_Consult_Euro.Uf_Initialiser ( dwNorm[] )

// #1 - [DCMP090595]
cb_valid_factu.Visible = FALSE
cb_valid_factu.Enabled = FALSE
end subroutine

private function boolean wf_cmde_sur_gti ();//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_W_Detail::wf_Cmde_Sur_Gti
//* Evenement 		: 
//* Auteur			: Fabry JF
//* Date				: 13/09/1998 16:37:38
//* Libellé			: 
//* Commentaires	: Cette Gti gère-t-elle les commandes
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Boolean bRet

// istPass.dwNorm  [ 15 ] = Dw sur COMMANDE_TYPE
istPass.dwNorm  [ 15 ]. SetFilter ( "ID_GTI = " + String ( dw_1.GetItemNumber ( 1, "ID_GTI" ) ) )
istPass.dwNorm  [ 15 ]. Filter ()

bRet = istPass.dwNorm  [ 15 ]. RowCount () > 0

istPass.dwNorm  [ 15 ]. SetFilter ( "" )
istPass.dwNorm  [ 15 ]. Filter ()

Return bRet
end function

private function boolean wf_condition_ouverture (string aschoixaction);//*-----------------------------------------------------------------
//*
//* Fonction      : w_td_sp_w_detail::wf_Condition_Ouverture (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 05/10/2004 14:40:47
//* Libellé       : Vérification des conditions d'ouverture de la fenêtre de commandes
//* Commentaires  : 
//*
//* Arguments     : String		asChoixAction		String
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    22/03/2005  DCMP 050160 M LEGAC
//* #2	 JFF	  16/10/2006  Optimisation (détectée suite dév et tests MEDIA SATURN)
//* #3	 JFF	  06/02/2006  [SITE_CMDE] Gestion des nouvelles option d'autorisation 79, 80, 81
//* #4    JFF    04/06/2007  [DCMP070163-070164-070248-070318] Gestion Prise en charge
//* #5    JFF    27/08/2007  [DCMP070431] : Autorisation pour commander suite irreparable.
//* #6    JFF    17/09/2007  Gestion de l'existant
//* #7	 JCA	  12/11/2007  [DCMP070811] Pas plus de trois prestations sur le dossier si au moins deux prestations sont en RPC
//* #8	 PHG	  10/12/2007  [O2M]Désactivation du Controle de la PEC si Informer + EDI avec O2M
//* #9	 JCA	  11/12/2007  DCMP 70920 / 70943 
//* #10   JFF    05/02/2008  [DCMP070921]
//* #11   JFF    08/09/2008  Modif JFF suite Bug JCA sur #7
//* #12	 FPI    24/03/2009  [DCMP090051] Bloquer envoi en réparation si prix IFR < un forfait
//* #13	 JFF    15/04/2009  [DMDI25498] tranformation < en <=
//* #14   JFF    02/09/2009  [DCMP090327].[SBETV]
//* #15   JFF    26/09/2009  [DCMP090474]
//* #16   JFF    16/10/2009  [DMDI26886]
//* #17   JFF    25/11/2009  [MSS_DIAG]
//* #18	 PHG	  [O2M_DIAG_NOMADE].Lot2
//*       JFF    07/04/2010  [20100407142602717]
//* 		 JFF    04/11/2010  [PC301].[LOT2]
//*		 JFF    05/01/2011  [PC202].[DOM_COM]
//*       JFF    27/05/2011  [VDOC4132]
//*       JFF    27/07/2011  [PLAF_REF]
//*		 FPI	  25/08/2011  [PC469] Ajout du flux demande d'enlèvement
//*       JFF    19/09/2011  [PM82][LOT1]
//		FPI	24/10/2011	  [VDoc4274] Avertissement dem. pièces+presta
//        JFF    24/01/2012  [CONFO][CUISINE][PC680]
//        JFF    01/03/2012  [CONFO][LITERIE][PC543]
//        JFF   01/03/2012  [CONFO][SIEGE][PC716]
//		FPI	19/07/2012	[PC801]
//    JFF   16/08/2012  [VDOC8428]
//    JFF   20/08/2012  [BLCODE]
//    JFF   11/02/2013  [PC896_CDISCOUNT]	
//	  FPI	 14/02/2013	[PC467-2] Econocom Samsung
//       JFF   07/05/2013 [PC938_ORANGE_V3]
//		FPI	14/08/2013	[DT058]
//    JFF   30/12/2013 [PC13348&13408]
//    JFF   13/01/2014 [PM246]
//     JFF   30/07/2014 [PM234-4_V1]
//       JFF   29/01/2015 [PM280-1]
//       JFF   18/02/2015 [ITSM274734]
// 		FPI	27/02/2015	[VDOC16821] On se base sur le cp de l'assuré ald la caisse
//       JFF   10/03/2014 [PC13321]
//       JFF   20/03/2015 [PC13321][MANTIS14803]
//       JFF   09/04/2015 [DT141]
//			JFF   04/06/2015 [VDOC17797]
//			JFF   09/06/2015 [DT141][MANTIS15744]
//       JFF   13/07/2015 [PC151270_ORANGE_V3]
//       JFF   22/07/2015 [DT168]
//		FPI	27/08/2014	[DT173]
//		FPI	19/02/2016 [DT075-2]
//     JFF   23/02/2016 [PM330-1]
//       JFF   17/05/2016 [PM280-2]
//       JFF   28/06/2016 [BUG_FORFAIT]
//    JFF   17/08/2016  [VDOC21471]
//       JFF   02/11/2016 [DT276]
//       JFF   04/05/2017 [DT288-1_LOT2]
//       JFF   01/08/2017 [DT288-1][MODIF_CHRISTINE]
//       JFF   23/08/2017 [DT288-3_LOT1][PM280]
//       JFF   29/08/2017 [DT288-3_LOT1_2EME_VS]
// 		FPI	20/02/2018 [FPI.20180220] Ajout de l'id_sin dans l'appel Cordon pour traces d'erreurs
// 		JFF   16/04/2018 [ITSM529150]
//       JFF   01/10/2018 [PM445-1]
//       JFF   26/11/2018 [PC874_2_V1]
// 		JFF   05/04/2019 [VDOC27799]
//       JFF   23/06/2020 [PC202553_SELECTRA]
//       JFF   06/04/2023 [PMO139_RS4926]
//       JFF   07/03/2024 [HP252_276_HUB_PRESTA]
//       JFF   05/08/2024 [MCO602_PNEU]
//       JFF   06/09/2024 [KSV516]
//*-----------------------------------------------------------------

String sTypApp, sMarque, sModele, sMes, sTypArt, sFiltreFrn, sIdGti, sDteProdEqvFc, sBVIEPresent, sSortOri, sChaine, sInterdictionAutor
Long   lRow, lRow1, lDeb, lFin, lVal, lCaisse, lIdEvt, lCodeRgprElt , lTailleArticle, lCptEligible, lCptDetPro, lRow2, lIdSeq
Boolean bOk, bPec, bO2MPresent, bCDiscount, bTSF, bPRS_Retour_153_154, bConfo, bConfoMeuble, bAutorise, bConfoLiterie, bConfoSiege, bValPubliqueOblig, bFirstAssur
Decimal {2} dcMtValAchat, dcMtValPublique, dcIdCie, dcMtValAchat2
Long		lTotTb, lCpt, lPos, LAccordRepml2, lStatusGC1erePresta, lStatusGC2emePrestaEnBVIE, lBVIEPresent
String 	sLibEvt, sTbLibEvt [], sVal, sTabNull[], sVarianteELD
Int		iRet, iIdNatSin
DateTime	dtCreeLe
Long lCountDiv1, lMarquageCC, lCptDiv1, lIdDetailDiv1, lRowDiv1, lRowDet1, lIdEvt1, lCodeEtatDet, lEnlvBien, lLig, lTotFranchise
Decimal {2} dcMtPec1, dcMtVal, dcMtFran
Boolean bCDiscountTachDech 
Boolean bDeclaWebAtlas, bDcnxWebAtlas
Boolean bManqueInfoAtlas, bPRS_Retour_21
String  sIMEI, sIMEICorrige, sRech, sChaineBcv
DateTime dtMajLe
Long lRowForPec 
Boolean bBlocageGeoloc, bFranchiseAuchan, bFranchiseSelectra, bPrestaHubCodeVerrouManquant
Boolean bVarianteSelectra2024 // [KSV516]

string sFiltreOri, sFiltrePrs // #7
String sPathIE 

long lForce // #9
Decimal {2} 	dcMtForfait, dcMtPec // #12
Long lIdGti, lIdDetail	// #12
n_cst_string lnvPFCString // #12

DateTime dtDtePivotDT288-1_LOT2, dtCreeLeDos

// [DT288-1_LOT2]
n_cst_sp_ws_cordon_caller nWsCordon
cordon_inforesponse oCordonResult 
integer iGeolocalise


// [DT288]
dtCreeLeDos = idwWSin.GetItemDateTime ( 1, "CREE_LE")
sIMEI = Trim ( idwWSin.GetItemString ( 1, "NUM_IMEI_PORT" ))

sPathIE = ProfileString ( stGlb.sFichierIni, "DOCUMENTATION", "IE_W7", "" ) // [DT276]

bOk = True
sMes = ""
sIdGti = String ( dw_1.GetItemNumber ( 1, "ID_GTI" ) )
lIdGti = dw_1.GetItemNumber ( 1, "ID_GTI" )
lIdEvt = dw_1.GetItemNumber ( 1, "ID_EVT" )
lIdDetail = dw_1.GetItemNumber ( 1, "ID_DETAIL" )

// [PM234-4_V1]
bDeclaWebAtlas = FALSE
bDeclaWebAtlas = idwWDivsin.Find ( "NOM_ZONE = 'decla_atlas' AND VAL_CAR = 'O'", 1, idwWDivSin.RowCount () ) > 0

bDcnxWebAtlas = idwWDivsin.Find ( "NOM_ZONE = 'dcnx_decla_atlas' AND VAL_CAR = 'O'", 1, idwWDivSin.RowCount () ) > 0

If bDcnxWebAtlas Then
	bDeclaWebAtlas = False
End If

lRow = idwWDivsin.Find ( "NOM_ZONE = 'manque_info_atlas'", 1, idwWDivSin.RowCount () )
If lRow > 0 Then 
	bManqueInfoAtlas = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) = "O"
End If
// [PM234-4_V1]


// [PM234-4_V1]
If bDeclaWebAtlas And bManqueInfoAtlas Then
	bOk = False
	stMessage.sTitre		= "Décla Atlas/Infos manquantes"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sCode		= "P234017"

	F_Message ( stMessage )
	Return bOk
End If

// [PM246][MANTIS10235]
Choose Case lIdEvt 
	Case 1083 
		// On ne réinitilise pas.
	Case Else
		gAutoriseDiag = FALSE
End CHoose

Choose Case lIdEvt 
	Case 841, 936 
		// On ne réinitilise pas.
	Case Else
		gAutoriseRempl = FALSE
End CHoose
// [PM246][MANTIS10235]		


// [MCO602_PNEU]
/*
If F_CLE_A_TRUE ( "MCO602_PNEU" ) Then

	CHoose Case lIdEvt 
		Case 1391, 1397
			stMessage.sTitre		= "Evt non éligible à une prestation"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WDET681"
	
			F_Message ( stMessage )
			
			Return False			
	End Choose

End If
*/

// #15 [DCMP090474]
sMarque = Upper ( idwWSin.GetItemString ( 1, "MARQ_PORT" ) )
sModele = Upper ( idwWSin.GetItemString ( 1, "MODL_PORT" ) )
// #15 [DCMP090474]

// [CONFO][SIEGE][PC716]
iIdNatSin = idwWSin.GetItemNumber ( 1, "ID_NATSIN" )

idwFourn.SetFilter ( "" ) // #8 JFF
idwFourn.Filter () // #8 JFF

lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, idwWDivSin.RowCount () ) 
If lRow <= 0 Then Return FALSE

sTypApp = Upper ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) )

dcMtValAchat = dw_1.GetItemDecimal ( 1, "MT_VAL_ACHAT" )
If IsNull ( dcMtValAchat ) Then dcMtValAchat = 0

dcMtValPublique = dw_1.GetItemDecimal ( 1, "MT_VAL_PUBLIQUE" )
If IsNull ( dcMtValPublique ) Then dcMtValPublique = 0

// [DT058]
If not iuoGsSpwDetail.uf_controler_sanction_eco( ) Then return FALSE

// [VDOC8428]
F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 107 )
bValPubliqueOblig = lDeb > 0

F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 37 )
bCDiscount = lDeb > 0 
// [PC896_CDISCOUNT]
If bCDiscount Then
	sVal = lnvPFCString.of_getkeyvalue ( idwDetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")
	bCDiscountTachDech = sVal = "TACHE_DECH"
End If
// :[PC896_CDISCOUNT]

// [PC469]
F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 166 )
bTSF = lDeb > 0 
// :[PC469]

// [PC467-2]
If not bTSF Then
	F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 234)
	bTSF = lDeb > 0 
End if
// :[PC467-2]

// [PC13321]
F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 266 )
If lDeb > 0 Then
	sVarianteELD = lnvPFCString.of_getkeyvalue ( idwDetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")
End If

// [CONFO][CUISINE][PC680]
F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 207 )
bConfo = lDeb > 0 
bConfoMeuble = False
If lDeb > 0 Then 
	
	// [CONFO][MEUBLE][PC542]
	// [CONFO][LITERIE][PC543]
	// [CONFO][SIEGE][PC716]
	Choose Case lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( lDeb, "VAL_CAR" ), "VARIANTE", ";")  
		Case "MEUBLE"
			bConfoMeuble = TRUE
		Case "LITERIE"	
			bConfoLiterie = TRUE
		Case "SIEGE"	
			bConfoSiege = TRUE
			
	End Choose
End If

If bConfo Then
	lIdEvt = dw_1.GetItemNumber ( 1, "ID_EVT" )
	Choose Case lIdEvt
		Case 1317, 1083
			// Autorisé
		Case Else
			
			stMessage.sTitre		= "Prise en charge"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WDET602"
		
			f_Message ( stMessage )
			
			Return FALSE
	End Choose
	
	// [CONFO][MEUBLE][PC542] (BLCODE)
	// [CONFO][SIEGE][PC716]
	If ( bConfoMeuble Or bConfoLiterie Or bConfoSiege ) And asChoixAction = "I" Then

		// On ne lit pas la valeur d'achat, mais on fait la somme des MT_PEC des autres détail.
		// dcMtPec = idw_wDetailFF.GetItemDecimal ( 1, "MT_VAL_ACHAT" )

		dcMtPec = 0

		idwDivDetGti.SetFilter ( &
		"ID_GTI = " + String ( lIdGti ) + " AND " + &
		"UPPER ( NOM_ZONE ) IN ( 'MT_PEC', 'ALT_PEC', 'REMPL_CARTE_CADEAU', 'PRIS_PRESTA_BLCODE', 'CODE_RGPR_ELEMENT', 'ENLV_BIEN' )" )

		idwDivDetGti.Filter ()

		lCountDiv1 = idwDivDetGti.RowCount()
		lMarquageCC = Long ( String ( Day ( Today () ) ) + String ( Hour ( Now () ) ) + String ( Minute ( Now () ) ) + String ( Second ( Now () ) ) )
		ilMarquaGeBLCODE = lMarquageCC // [BLCODE]
		sChaine = ""
		bAutorise = False
		lCptEligible = 0

		For lCptDiv1 = 1 To lCountDiv1 
			If Upper ( idwDivDetGti.GetItemString ( lCptDiv1, "NOM_ZONE" ) ) <> "MT_PEC" Then Continue
			
			dcMtPec1 = idwDivDetGti.GetItemDecimal ( lCptDiv1, "VAL_MT" )  // En prévision...
			If IsNull ( dcMtPec1 ) Then dcMtPec1 = 0
			If dcMtPec1 <= 0 Then continue
			
			lIdDetailDiv1 = idwDivDetGti.GetItemNumber ( lCptDiv1, "ID_DETAIL" )
			
			lRowDiv1 = idwDivDetGti.Find ( &
				"ID_GTI = " + String ( lIdGti ) + " AND " + &
				"ID_DETAIL = " + String ( lIdDetailDiv1 ) + " AND " + &
				"UPPER ( NOM_ZONE ) IN ('REMPL_CARTE_CADEAU', 'PRIS_PRESTA_BLCODE') " + " AND " + &
				"VAL_NBRE > 1" &
				, 1, lCountDiv1 )
										
			If lRowDiv1 > 0 Then
				Continue // Déjà pris sur une carte Cadeau ou une presta blcode
			End If

			// istPass.dwTab[1] = idw_LstDetail

			lRowDet1 = istPass.dwTab[1].Find ( &
				"ID_GTI = " + String ( lIdGti ) + " AND " + &
				"ID_DETAIL = " + String ( lIdDetailDiv1 ) &
				, 1, istPass.dwTab[1].Rowcount () )
			
			lIdEvt1 = istPass.dwTab[1].GetItemNumber ( lRowDet1, "ID_EVT" )
			dcMtValAchat2 = istPass.dwTab[1].GetItemDecimal ( lRowDet1, "MT_VAL_ACHAT" )
			Choose Case lIdEvt1 
					
				Case 1317, 1083
					continue
			End Choose

			lCodeEtatDet = istPass.dwTab[1].GetItemNumber ( lRowDet1, "COD_ETAT" )
			Choose Case lCodeEtatDet 
				Case 100
					// Ok on prend
				Case 200
					lRowDiv1 = idwDivDetGti.Find ( &
					"ID_GTI = " + String ( lIdGti ) + " AND " + &
					"ID_DETAIL = " + String ( lIdDetailDiv1 ) + " AND " + &
					"UPPER ( NOM_ZONE ) = 'ALT_PEC' " + " AND " + &
					"VAL_CAR = 'O'" &
					, 1, lCountDiv1 )
					
					If lRowDiv1 <=0 Then
						Continue // Refusé sans force, on passe.
					End If
				Case 500, 600, 900, 0
					Continue // On passe
					
			End Choose

			lRowDiv1 = idwDivDetGti.Find ( &
				"ID_GTI = " + String ( lIdGti ) + " AND " + &
				"ID_DETAIL = " + String ( lIdDetailDiv1 ) + " AND " + &
				"UPPER ( NOM_ZONE ) = 'CODE_RGPR_ELEMENT' " &
				, 1, lCountDiv1 )

			lCodeRgprElt = idwDivDetGti.GetItemNumber ( lRowDiv1, "VAL_NBRE" ) 

/* // [CONFO][NV_PROCESS]
			If Not bConfoLiterie Then 
				lRowDiv1 = idwDivDetGti.Find ( &
					"ID_GTI = " + String ( lIdGti ) + " AND " + &
					"ID_DETAIL = " + String ( lIdDetailDiv1 ) + " AND " + &
					"UPPER ( NOM_ZONE ) = 'TAILLE_ARTICLE' " &
					, 1, lCountDiv1 )
	
				lTailleArticle = idwDivDetGti.GetItemNumber ( lRowDiv1, "VAL_NBRE" ) 
			End If

			// [CONFO][SIEGE][PC716]
			If dcMtValAchat2 > 200 And lTailleArticle = 1 And ( bConfoMeuble Or ( bConfoSiege And iIdNatSin <> 38) ) Then
				sInterdictionAutor = "interdite (Val.Achat > 200€ et petit bien)"
				lCptEligible ++
			Else
*/				
			// [CONFO][NV_PROCESS]
			lRowDiv1 = idwDivDetGti.Find ( &
				"ID_GTI = " + String ( lIdGti ) + " AND " + &
				"ID_DETAIL = " + String ( lIdDetailDiv1 ) + " AND " + &
				"UPPER ( NOM_ZONE ) = 'ENLV_BIEN' " &
				, 1, lCountDiv1 )

			lEnlvBien = Long ( idwDivDetGti.GetItemString ( lRowDiv1, "VAL_CAR" ) )
			
			If ( bConfoMeuble Or bConfoSiege ) And lEnlvBien <> 2 Then
				sInterdictionAutor = "interdite (l'assuré n'en a pas émis le souhait)"
				lCptEligible ++
			Else
				sInterdictionAutor = "autorisée"				
				bAutorise = True
				lCptEligible ++
				// Marquage
				lRowDiv1 = idwDivDetGti.Find ( &
					"ID_GTI = " + String ( lIdGti ) + " AND " + &
					"ID_DETAIL = " + String ( lIdDetailDiv1 ) + " AND " + &
					"UPPER ( NOM_ZONE ) = 'PRIS_PRESTA_BLCODE' " &
					, 1, lCountDiv1 )
					
				idwDivDetGti.SetItem ( lRowDiv1, "VAL_NBRE", lMarquageCC ) // Marqué
			End If	
			
			sChaine += "Detail n°" + String ( lIdDetailDiv1 ) + ", Meuble n°" + String ( lCodeRgprElt ) + ", prestation BLCODE " + sInterdictionAutor + Char (13)
	
		Next

		If Not bAutorise And lCptEligible > 0 Then 
			stMessage.sTitre		= "Prise en charge"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sVar[1]		= "200"
			stMessage.sCode		= "WDET615" // [CONFO][NV_PROCESS]
			f_Message ( stMessage )
			
			Return FALSE

		ElseIf lCptEligible <= 0 Then
			stMessage.sTitre		= "Prise en charge"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WDET614"
			f_Message ( stMessage )
			
			Return FALSE
			
		Else
			stMessage.sTitre		= "Prise en charge"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sVar[1]		= String ( lMarquageCC )
			stMessage.sVar[2]		= sChaine
			stMessage.sCode		= "WDET612"
			f_Message ( stMessage )
		End If

	End If 

//		lVal = Long ( iuoGsSpwDetail.uf_GestOng_Divers_Trouver ( "TAILLE_ARTICLE" ))
		// Si va > 200 et petit bien
//		If dcMtValAchat > 200 and lVal = 1 Then
//			stMessage.sTitre		= "Prise en charge"
//			stMessage.Icon			= Information!
//			stMessage.bErreurG	= FALSE
//			stMessage.Bouton		= OK!
//			stMessage.sVar[1]		= "200"
//			stMessage.sCode		= "WDET612"
//			f_Message ( stMessage )
//			Return FALSE
//		End If			

	// [CONFO][MEUBLE][PC542]

End If
// :[CONFO][CUISINE][PC680]

sLibEvt  = Upper ( dw_1.Describe ( "Evaluate ('LookUpDisplay ( ID_EVT )', 1)" ) )

//* #14 [DCMP090327].[SBETV]
//* #17 [MSS_DIAG]
// [CONFO][MEUBLE][PC542]
// [PC467-2] Ajout SAM
// [PC13348&13408]
// [DT141] Ajout SBE
bO2MPresent = idwFourn.Find("ID_GTI = " + sIdGti 		+		&
											" AND ID_CODE_FRN IN ('O2M', 'SB1', 'MS1','TSF', 'BLC','SAM','MTT','SBE')" + 		& 
											" AND ID_CODE_ART = 'EDI'" , &
											1, idwFourn.RowCount()+1)>0

// #8 [O2M]Désactivation du controle PEC si "Informer" et EDI pour O2M

// [PLAF_REF]
bPec = 	iuoGsSpwDetail.uf_GestOng_Divers_Trouver ("PEC" ) = "O"
// [PLAF_REF]

If Not bPec Then
	stMessage.sTitre		= "Prise en charge"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sCode		= "WDET527"

	f_Message ( stMessage )
	Return False
End If

// #18 [O2M_DIAG_NOMADE].Lot2 Point 3.3 :
//Si Déclenchement du contrôle 435 (*)
//ET
//Si absence de *forçage* de la pec du détail courant, Alors msg WDET571

if	iuoGsSpwDetail.uf_GestOng_Divers_Trouver ("" ) <> "O" and	&
	iuoGsSpwDetail.uf_controlergestion_o2m_apprecuprecycl() Then

	stMessage.sTitre		= "Prise en charge"
	stMessage.Icon		= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sCode		= "WDET571"

	f_Message ( stMessage )
	Return False
End If
// Fin #18 [O2M_DIAG_NOMADE].Lot2 Point 3.3


Choose Case asChoixAction
	Case "I"
		// [VDOC8428]
		lIdEvt = dw_1.GetItemNumber ( 1, "ID_EVT" )
		dcMtVal = dw_1.GetItemDecimal ( 1, "MT_VAL_PUBLIQUE" )
		If	IsNull ( dcMtVal ) Then dcMtVal = 0
		
		If bValPubliqueOblig And dcMtVal = 0 And lIdEvt = 1083 Then
			sMes += "la valeur publique est obligatoire."
			bOk = False
		End If


	Case "R"
		sMes = "Pour effectuer une réparation, "

		bOk = dcMtValAchat <> 0
		sMes += "la valeur d'achat est obligatoire."

	Case "C", "S"
		If asChoixAction = "C" Then
			sMes = "Pour effectuer une commande, "
		Else
			sMes = "Pour effectuer une sélection sur courrier, "
		End If

		bOk = sTypApp <> "AUT" 
		If Not bOk Then 

			// #2
			sFiltreFrn = "ID_GTI = " + sIdGti + "AND ID_CODE_ART IN ( 'CAF', 'AEF' ) AND ID_CODE_ART <> '-1' AND ID_TYP_CODE = '-XX' "
		
			idwFourn.SetFilter ( sFiltreFrn )
			idwFourn.Filter ( )
		
			bOk =	idwFourn.RowCount ( ) > 0
		
			idwFourn.SetFilter ( "" )
			idwFourn.Filter ( )

			If Not bOk Then sMes += "le type d'appareil doit être différent de 'AUTRE APPAREIL' (Onglet divers)."			
			
		End If

		If bOk Then	
			bOk = dcMtValAchat <> 0
			If Not bOk Then sMes += "la valeur d'achat est obligatoire."
		End If

		If bOk Then 
			/*------------------------------------------------------------------*/
			/* Date de mise en production de l'Equiv Fct.                       */
			/*------------------------------------------------------------------*/
			sDteProdEqvFc = ProfileString ( stGlb.sFichierIni, "DIVERS", "DATE_PRODUCTION_EQV_FCT", "01/01/2000" )
			sDteProdEqvFc = Right (sDteProdEqvFc, 4) + "-" + Mid (sDteProdEqvFc, 4, 2 ) + "-" + Left (sDteProdEqvFc, 2) 

			bOk = dcMtValPublique <> 0 
	
			/*------------------------------------------------------------------*/
			/* Si dossier créé avant date de mise en production de l'EQF,       */
			/* alors on force le controle                                       */
			/*------------------------------------------------------------------*/
			If Date ( idwwSin.GetItemDateTime ( 1, "CREE_LE" ) ) < Date (sDteProdEqvFc) Then bOk = TRUE

			/*------------------------------------------------------------------*/
			/* Si EQF déconnecté, on force le controle aussi                    */
			/*------------------------------------------------------------------*/
			F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 24 )
			If lDeb > 0 Then bOk = True

			If Not bOk Then sMes += "la valeur publique est obligatoire."
		End If

		// #5

End Choose 




If Not bOk Then
		stMessage.sTitre		= "Identification du mobile"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sVar[1]		= sMes
		stMessage.sCode		= "GENE013"

		F_Message ( stMessage )
End If 

/*------------------------------------------------------------------*/
/* Y a-t-il au un Frn répondant à l'action choisie ?					  */
/*------------------------------------------------------------------*/
If bOk Then

	sMes = "Aucun fournisseur n'est paramètré pour ce choix d'action (pour ce produit et cette garantie)."

	Choose Case asChoixAction
		Case "I"
			sTypArt = " AND ID_CODE_ART = 'EDI' "

		Case "C", "S"
			sTypArt = " AND ID_CODE_ART <> 'PRS' "
	
		Case "R"
			sTypArt = " AND ID_CODE_ART = 'PRS' "
	End Choose

	sFiltreFrn = "ID_GTI = " + sIdGti + sTypArt + " AND ID_CODE_ART <> '-1' AND ID_TYP_CODE = '-XX' "

	idwFourn.SetFilter ( sFiltreFrn )
	idwFourn.Filter ( )

	bOk =	idwFourn.RowCount ( ) > 0

	idwFourn.SetFilter ( "" )
	idwFourn.Filter ( )

	If Not bOk Then
			stMessage.sTitre		= "Identification du mobile"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sVar[1]		= sMes
			stMessage.sCode		= "GENE013"

			F_Message ( stMessage )
	End If 
End If

// #7
if bOk then

/*	#11 Je shunte ce contrôle sur l'option 25 qui s'avère gênant pour l'asus et qui ne sert à rien à l'arrivée.
       On bloque pour tout appareil la troisième réparation et plus, du moment où il y en a déjà eu deux en RPC.
	// Le référentiel de téléphonie est-il lié
	F_RechDetPro ( lDeb, lFin, idwDetPro, istPass.dwMaster.GetItemNumber ( 1, "ID_PROD" ), '-DP',  25 )    
	If lDeb > 0 Then
		// Param de téléphonie Présent.
		If idwDetPro.GetItemString ( lDeb, "ID_CODE_CAR" ) = "TEL" Then
*/
	
			sFiltreOri = idwLstCmdeSin.Describe ( "datawindow.table.filter" )
			if sFiltreOri = "?" then sFiltreOri = ""
			
			sSortOri = idwLstCmdeSin.Describe ( "datawindow.table.Sort" )
			if sSortOri = "?" then sSortOri = ""
			
			// [20100407142602717]		
			// sFiltrePrs = "ID_TYP_ART = 'PRS' AND COD_ETAT = 'RPC'"
			sFiltrePrs = "ID_TYP_ART = 'PRS' AND COD_ETAT IN ('RPC', 'RFO')"
			// :[20100407142602717]		
			
			idwLstCmdeSin.setfilter(sFiltrePrs)
			idwLstCmdeSin.filter()
			idwLstCmdeSin.SetSort ( "ID_SEQ A" )
			idwLstCmdeSin.Sort ()
			lRow = idwLstCmdeSin.RowCount ()
		
			idwLstCmdeSin.setfilter(sFiltreOri)
			idwLstCmdeSin.filter()
			idwLstCmdeSin.SetSort ( sSortOri ) // [JFF20120312]
			idwLstCmdeSin.Sort ()	

			//[VDOC4132] Shunt sur condition particulier données par A. Rault
			If lRow >= 2 Then
				sFiltrePrs = "ID_TYP_ART = 'PRS' AND COD_ETAT IN ('RPC', 'RFO')"
				idwLstCmdeSin.setfilter(sFiltrePrs)
				idwLstCmdeSin.filter()
				idwLstCmdeSin.Sort ()

				lStatusGC1erePresta = idwLstCmdeSin.GetItemNumber ( 1, "STATUS_GC" )
				lStatusGC2emePrestaEnBVIE = idwLstCmdeSin.GetItemNumber ( 2, "STATUS_GC" )
				// [PC929-1]
				lBVIEPresent = Pos ( idwLstCmdeSin.GetItemString ( 2, "COMMENT_FRN") , "[BVIE]", 1) + Pos ( idwLstCmdeSin.GetItemString ( 2, "COMMENT_FRN") , "[PIE]", 1) 

				If lStatusGC1erePresta = 2 And ( lStatusGC2emePrestaEnBVIE =21 And lBVIEPresent > 0 ) Then
					// Dans ce cas, on ne bloque pas
					lRow = 0
				End If

				idwLstCmdeSin.setfilter(sFiltreOri)
				idwLstCmdeSin.filter()
				idwLstCmdeSin.SetSort(sSortOri)
				idwLstCmdeSin.Sort ()	
			
			End If
			// :[VDOC4132]

			
	/*	End if #11
	End If */
end if
// FIN - #7 #10

// Cas GO MICRO, (ALAPAGE) Si Réparation alors uniquement pour les PCP et PCB
F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 89 )
If lDeb > 0 And asChoixAction = "R" Then
	Choose Case sTypApp
		Case "PCP", "PCB"
			// Ok
		Case Else

			bOk = False
			stMessage.sTitre		= "Réparation"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WDET537"

			F_Message ( stMessage )
		
	End choose
	
End If

// [PC301].[LOT2]
If bOk Then
	F_RechDetPro ( lDeb, lFin, idwDetPro, istPass.dwMaster.GetItemNumber ( 1, "ID_PROD" ), "-DP", 152 )
	If lDeb > 0 Then
		Choose Case dw_1.GetItemNumber ( 1, "ID_EVT" ) 
			Case 936
				Choose Case asChoixAction
					Case "C"
						lRow1 = dw_w_div_det.find ( "ID_GTI = " + String ( dw_1.GetItemNumber ( 1, "ID_GTI" )) + " AND " + &
							"ID_DETAIL = " + String ( dw_1.GetItemNumber ( 1, "ID_DETAIL" )) + " AND " + &
							" UPPER ( NOM_ZONE ) = 'ADR_IMM_PAV'", 1, dw_w_div_det.rowcount() )
						
						If lRow1 > 0 Then
							sVal = dw_w_div_det.GetItemString ( lRow1, "VAL_LST_CAR" )
							If IsNull ( sVal ) Or Trim ( sVal ) = "" Then
								bOk = False
							Else
								lRow1 = dw_w_div_det.find ( "ID_GTI = " + String ( dw_1.GetItemNumber ( 1, "ID_GTI" )) + " AND " + &
									"ID_DETAIL = " + String ( dw_1.GetItemNumber ( 1, "ID_DETAIL" )) + " AND " + &
									" UPPER ( NOM_ZONE ) = 'ADR_IMM_ETG'", 1, dw_w_div_det.rowcount() )
		
								If sVal = "IMM" Then
									If lRow1 > 0 Then
										sVal = dw_w_div_det.GetItemString ( lRow1, "VAL_CAR" )
										If IsNull ( sVal ) Or Trim ( sVal ) = "" Then
											bOk = False
										End IF		
									End If
								Else
									dw_w_div_det.SetItem ( lRow1, "VAL_CAR", stNul.str )
								End If
							End If
						End If
		
						If Not bOk Then
							stMessage.sTitre		= "Zones à saisie"
							stMessage.Icon			= Information!
							stMessage.bErreurG	= FALSE
							stMessage.Bouton		= OK!
							stMessage.sCode		= "COMD648"
						
							F_Message ( stMessage )
						End If
		
				End Choose
		End Choose
	End If		
End If


F_RechDetPro ( lDeb, lFin, idwDetPro, istPass.dwMaster.GetItemNumber ( 1, "ID_PROD" ), "-DP", 138 )
If lDeb > 0 Then
	If asChoixAction = "C" Then
		//  [PC202].[DOM_COM]
		// 	[VDOC16821] 
		sVal=idwwsin.GetItemString(1,"ADR_CP")
		if Len(trim(sVal)) = 5 Then 
			sVal=Left(sVal,3)
		Else 
			sVal=""
		End if

		Choose case sVal
			Case "971","972","973","974","975","976","984","986","987","988"
				//(971) Guadeloupe 
				// (972) Martinique 
				// (973) Guyane 
				// (974) La Réunion 
				// (975) Saint-Pierre-et-Miquelon 
				// (976) Mayotte 
				// (984) Terres Australes et Antarctiques 
				// (986) Wallis et Futuna 
				// (987) Polynésie Française 
				// (988) Nouvelle-Calédonie 
				// ON contredit le process alors 
				bOk = False
				stMessage.sTitre		= "Pas de commande pour les DOM COM"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET587"
			
				F_Message ( stMessage )
		End choose
		// 	:[VDOC16821] 
		//  [PC202].[DOM_COM]	
	End If
End If 

// [VDOC4274]
F_RechDetPro ( lDeb, lFin, idwDetPro, istPass.dwMaster.GetItemNumber ( 1, "ID_PROD" ), "-DP", 187 )
If bOk And lDeb > 0 Then
	sVal=idwDetPro.GetItemString(lDeb,"VAL_CAR")
	
	lIdGti = dw_1.GetItemNumber ( 1, "ID_GTI" )
	
	iRet= SQLCA.PS_S01_POLICE(   idwWSin.GetItemNumber ( 1, "ID_PROD" ), &
		 idwWSin.GetItemNumber ( 1, "ID_REV" ),  lIdGti, dcIdCie)
	
	If iRet = 1 Then
		lDeb=Pos(sVal, "#" + String(dcIdCie,"######0") + "#")
		
		If lDeb > 0 And &
			(uo_piece.dw_trt.Find("ALT_RECLAME='O'",1,uo_piece.dw_trt.Rowcount( )) > 0 &
				Or idwPieceGti.Find("ALT_RECLAME='O'",1,idwPieceGti.Rowcount( )) > 0) Then
			stMessage.sTitre		= "VDoc 4274"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WDET594"
	
			F_Message ( stMessage )
		End if
	End if
End if
// Fin [VDOC4274]


// [PC202553_SELECTRA]
If bOk Then
	
	// Recherche forçage Pec
	lRow = dw_w_div_det.Find ( &
						"ID_GTI = " + String ( lIdGti ) + " AND " + &
						"ID_DETAIL = " + String ( lIdDetail ) + " AND " + &
						"NOM_ZONE = 'alt_pec' AND " + &
						"VAL_LST_CAR = 'O'" &																		
						, 1, dw_w_div_det.Rowcount() ) 
	
	// Si Pec Forcé => pas de blocage
	If lRow <= 0 Then 
		lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'FRANCHISE_PAYBOX'", 1, idwWDivSin.RowCount () ) 
		If lRow <=0 Then sVal = "N"
		If lRow > 0 Then sVal=idwWDivSin.GetItemString(lRow,"VAL_CAR")
		If IsNull ( sVal ) Then sVal = "N"
		
		F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 140 )
		bFranchiseAuchan = lDeb > 0 
		
		F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 348 )
		bFranchiseSelectra = lDeb > 0 

		// [KSV516]
		bVarianteSelectra2024 = FALSE
		If bFranchiseSelectra Then 
			bVarianteSelectra2024 = F_CLE_VAL ( "VARIANTE", idwDetPro.GetItemString ( lDeb, "VAL_CAR" ), ";" ) = "SELECTRA_OFFRE_2024"
		End If 		
		
		sRech	=		"ID_PROD = "		+ String ( idwWSin.GetItemNumber ( 1, "ID_PROD" ) ) 			+ " AND " 	+ &
						"ID_REV = "			+ String ( idwWSin.GetItemNumber ( 1, "ID_REV" ) ) 			+ " AND " 	+ &
						"ID_GTI = "			+ String ( lIdGti )		+ " AND " 	+ &
						"ID_CPT_FRA = 1"																					+ " AND " 	+ &
						"ID_TYP_FRA = "   + "5"
	
		lLig = istPass.dwNorm [6].Find ( sRech, 1, istPass.dwNorm [6].RowCount())
	
		If lLig > 0 Then	
			dcMtFran = istPass.dwNorm [6].GetItemDecimal ( lLig, "MT_FRA" )
		End If 
		
		
		Choose Case True 
			Case bFranchiseAuchan

				if sVal="N" And asChoixAction="C" Then 
					stMessage.sTitre		= "Franchise Paybox"
					stMessage.Icon			= Information!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= OK!
					stMessage.sCode		= "WDET678"
					stMessage.sVar[1]		= String ( dcMtFran )
			
					F_Message ( stMessage )
					
					bOk=False
				End if
				
			// [KSV516]
			Case bFranchiseSelectra And Not bVarianteSelectra2024 
				if sVal="N" Then 
					stMessage.sTitre		= "Franchise Paybox"
					stMessage.Icon			= Information!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= OK!
					stMessage.sCode		= "WDET678"
					stMessage.sVar[1]		= String ( dcMtFran )
			
					F_Message ( stMessage )
					
					bOk=False
				End if				
				
		End Choose
	End If 
	
End If

// [PC896_CDISCOUNT]
If bOk And bCDiscountTachDech Then
	lIdEvt = dw_1.GetItemNumber ( 1, "ID_EVT" )
	
	If lIdEvt = 1083 And dcMtValAchat < 300 Then
		stMessage.sTitre		= "Contrat cDiscount Tach&Dech."
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sVar[1]		= "300"
		stMessage.sCode		= "COMD771"

		F_Message ( stMessage )
		
		bOk=False			
	End If
End If
// :[PC896_CDISCOUNT]	


// [PC13321-3]
// [PC13321][MANTIS14803] BLANC
If bOk And sVarianteELD = "BLANC" Then
	
	lIdEvt = dw_1.GetItemNumber ( 1, "ID_EVT" )
	
	If lIdEvt = 1083 And dcMtValAchat >= 200 Then
		stMessage.sTitre		= "Contrainte Electro Dépôt"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sVar[1]		= "200"
		stMessage.sCode		= "COMD904"

		F_Message ( stMessage )
		
		bOk=False			
	End If

	If lIdEvt = 937 And dcMtValAchat < 200 Then
		stMessage.sTitre		= "Contrainte Electro Dépôt"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sVar[1]		= "200"
		stMessage.sCode		= "COMD895"

		F_Message ( stMessage )
		
		bOk=False			
	End If

End If
// [PC13321]

If bOk And sVarianteELD = "GRIS" Then
	lIdEvt = dw_1.GetItemNumber ( 1, "ID_EVT" )

	If lIdEvt = 1083 And dcMtValAchat >= 200 Then
		stMessage.sTitre		= "Contrainte Electro Dépôt"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sVar[1]		= "200"
		stMessage.sCode		= "COMD966"

		F_Message ( stMessage )
		
		bOk=False			
	End If

	lRow = idwLstCmdeSin.Find ( "ID_FOUR = 'O2M' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER'", 1, idwLstCmdeSin.Rowcount ())

	If bOk And lIdEvt = 1083 And lRow <= 0 And dcMtValAchat < 200 Then
		lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'TELEDIAG_OK'", 1, idwWDivSin.RowCount () ) 
		If lRow > 0 Then 
			If Upper ( idwWDivSin.GetItemString ( lRow, "VAL_ALT" ) ) = "O" Then
				stMessage.sTitre		= "Contrainte Electro Dépôt"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode = "COMD965"
				F_Message ( stMessage )	
				bOk=False						
			End If
		End If
	End If

	If lIdEvt = 937 And dcMtValAchat < 200 Then
		stMessage.sTitre		= "Contrainte Electro Dépôt"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sVar[1]		= "200"
		stMessage.sCode		= "COMD895"

		F_Message ( stMessage )
		
		bOk=False			
	End If



End If

If bOk And sVarianteELD = "BRUN" Then
	lIdEvt = dw_1.GetItemNumber ( 1, "ID_EVT" )
	lRow = idwLstCmdeSin.Find ( "ID_FOUR = 'O2M' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER'", 1, idwLstCmdeSin.Rowcount ())

	If lIdEvt = 1083 And lRow <= 0 Then
		lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'TELEDIAG_OK'", 1, idwWDivSin.RowCount () ) 
		If lRow > 0 Then 
			If Upper ( idwWDivSin.GetItemString ( lRow, "VAL_ALT" ) ) = "O" Then
				stMessage.sTitre		= "Contrainte Electro Dépôt"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode = "COMD965"
				F_Message ( stMessage )	
				bOk=False						
			End If
		End If
	End If
End If	
// [PC13321]


/*------------------------------------------------------------------*/
/* #3 Y a-t-il au mois une option 79, 80, 81 ? 							  */
/*------------------------------------------------------------------*/
If bOk Then

	// Autor Cmde Gestionnaire
	F_RechDetPro ( lDeb, lFin, idwDetPro, istPass.dwMaster.GetItemNumber ( 1, "ID_PROD" ), '-DP', 79 )

	// Autor Cmde Assuré
	IF lDeb <= 0 Then
		F_RechDetPro ( lDeb, lFin, idwDetPro, istPass.dwMaster.GetItemNumber ( 1, "ID_PROD" ), '-DP', 80 )
	End If

	// Autor Cmde Boutique
	IF lDeb <= 0 Then
		F_RechDetPro ( lDeb, lFin, idwDetPro, istPass.dwMaster.GetItemNumber ( 1, "ID_PROD" ), '-DP', 81 )
	End If

	bOk = lDeb > 0 

	If Not bOk Then
			sMes = "Le paramètrage n'autorise pas cette action, contactez la cellule paramètrage au 2245 (-DP/79/80/81)"
			
			stMessage.sTitre		= "Paramètrage"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sVar[1]		= sMes
			stMessage.sCode		= "GENE013"

			F_Message ( stMessage )
	End If 
	
End If

// [PM280-1]
// [PM280-2]
// [DT288-3_LOT1][PM280]
lRow2 = idwLstCmdeSin.Find ( &
"ID_FOUR IN ( 'O2M' ) AND " + &
"COD_ETAT <> 'ANN' AND " + &
"( ID_TYP_ART NOT IN ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' ) " + &
"  OR " + &
"  ( ID_TYP_ART = 'RST' AND POS ( INFO_SPB_FRN_CPLT, 'RST_CMDE+SUIVI=OUI' ) > 0 ) " + &
") " + &
" AND STATUS_GC NOT IN ( 176, 239, 203 )" &
, 1, idwLstCmdeSin.RowCount () ) 

If lRow2 <= 0 Then
	Choose Case lIdEvt 
		Case 1422, 1426
			bOk = False
			stMessage.sTitre		= "Paramètrage"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WDET644"
		
			F_Message ( stMessage )		
	End Choose
End If


// #1
/*------------------------------------------------------------------*/
/* L'action est-elle valide avec le choix de l'événement.           */
/*------------------------------------------------------------------*/
If bOk Then
	sTbLibEvt [1] = "REMPL"
	sTbLibEvt [2] = "REPAR"
	sTbLibEvt [3] = "RÉPAR"

	//* #14 [DCMP090327].[SBETV]
	sTbLibEvt [4] = "DIAG/BROKER" // #8 JFF
   sTbLibEvt [5] = "DEMANDE ENL" // [PC469]
	sTbLibEvt [6] = "BON EMARGE"  // [DT209]
	sTbLibEvt [7] = "BON ÉMARGÉ" // [DT209]
	sTbLibEvt [8] = "CONTESTATION" // [DT209]
	sTbLibEvt [9] = "INFORMER" // [DT288-3_LOT1_2EME_VS]
	sTbLibEvt [10] = "CONTRÔLE IMEI" // [PC874_2_V1]	

	//[MCO602_PNEU]
	sTbLibEvt [11] = "BANQUE EDEL" 


// [PM82][LOT1]
// [ITSM274734]
	bPRS_Retour_153_154 = False
	idwLstCmdeSin.Sort ()
	lRow2 = idwLstCmdeSin.Find ( "COD_ETAT <> 'ANN' AND ID_TYP_ART = 'PRS' AND STATUS_GC IN ( 153, 154 )", 1, idwLstCmdeSin.RowCount() )
	If lRow2 > 0 Then
		lIdSeq = idwLstCmdeSin.GetItemNumber ( lRow2, "ID_SEQ" )
		
		lRow2 = idwLstCmdeSin.Find ( "COD_ETAT <> 'ANN' AND ID_REF_FOUR IN ( 'REFUSE_A_REEXP', 'A_REPARER_FORCE' ) AND ID_SEQ > " + String ( lIdSeq ), 1, idwLstCmdeSin.RowCount() )
		bPRS_Retour_153_154 = lRow2 <= 0
	End If

	// [PM330-1]
	lRow2 = idwLstCmdeSin.Find ( "COD_ETAT <> 'ANN' AND ID_TYP_ART = 'PRS' AND STATUS_GC IN ( 21, 23 )", 1, idwLstCmdeSin.RowCount() )
	If lRow2 > 0 Then
		lIdSeq = idwLstCmdeSin.GetItemNumber ( lRow2, "ID_SEQ" )
		
		lRow2 = idwLstCmdeSin.Find ( "COD_ETAT <> 'ANN' AND ID_REF_FOUR IN ( 'REFUSE_A_REEXP', 'PEC_A_RECYCLER' ) AND ID_SEQ > " + String ( lIdSeq ), 1, idwLstCmdeSin.RowCount() )
		bPRS_Retour_21 = lRow2 <= 0
	End If
	
	// [HP252_276_HUB_PRESTA]
	bPrestaHubCodeVerrouManquant = False
	If F_CLE_A_TRUE ( "HP252_276_HUB_PRESTA" ) Then
		lRow2 = idwLstCmdeSin.Find ( & 
						"ID_GTI    = " + String ( lIdGti ) + " AND " + & 
						"ID_DETAIL = " + String ( lIdDetail ) + " AND " + & 
						"COD_ETAT  = 'ECT' AND " + &
						"STATUS_GC IN ( 232 ) AND " + &
						"POS ( info_spb_frn_cplt, 'HP_ID_HUB_PRESTA' ) > 0", 1, idwLstCmdeSin.RowCount() )

		bPrestaHubCodeVerrouManquant = lRow2 > 0 
	End If
	
	
	lTotTb = UpperBound ( sTbLibEvt )

	For lCpt = 1 to lTotTb 
		lPos = Pos ( sLibEvt, sTbLibEvt [lCpt], 1 )
		If lPos > 0 Then
			sVal = sTbLibEvt [lCpt]
			Exit
		End If
	Next

	Choose Case asChoixAction

		Case "I"
			Choose Case sVal   // #8 JFF

				//* #14 [DCMP090327].[SBETV]
				Case "DIAG/BROKER"
					If Not bO2MPresent Then
						bOk = False
						stMessage.sCode = "COMD390"
					End If					
				
					// [DT141] 
					F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 275 )
					lRow = idwLstCmdeSin.Find ( "ID_FOUR = 'O2M' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER'", 1, idwLstCmdeSin.RowCount() )									

					If lDeb > 0 And sMarque <> "APPLE" And lRow <= 0 Then

						F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 110 )

						// [BUG_FORFAIT]
						If lDeb > 0 Then
							lDeb = idwDetPro.Find ( "ID_CODE_CAR = '" + sTypApp + "'", lDeb, lFin ) 
						End If

						If lDeb > 0 Then
							dcMtForfait = Dec ( lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( lDeb, "VAL_CAR" ), "FORFAIT", ";") )
							
							lIdGti = dw_1.GetItemNumber ( 1, "ID_GTI" )
							lIdDetail = dw_1.GetItemNumber ( 1, "ID_DETAIL" )
			
							// Recherche Pec
							lRow = dw_w_div_det.Find ( &
												"ID_GTI = " + String ( lIdGti ) + " AND " + &
												"ID_DETAIL = " + String ( lIdDetail ) + " AND " + &
												"NOM_ZONE = 'pec' AND " + &
												"VAL_LST_CAR = 'O'" &									
												, 1, dw_w_div_det.Rowcount() ) 
							
							If lRow > 0 Then
								lRow = dw_w_div_det.Find ( &
											"ID_GTI = " + String ( lIdGti ) + " AND " + &
											"ID_DETAIL = " + String ( lIdDetail ) + " AND " + &
											"NOM_ZONE = 'mt_pec'" &
											, 1, dw_w_div_det.Rowcount() ) 
		
								If lRow > 0 Then
									dcMtPec = dw_w_div_det.GetItemDecimal ( lRow, "VAL_MT" ) 
									If IsNull ( dcMtPec ) Then dcMtPec = 0
									If dcMtPec > dcMtForfait Then							
										bOk = False
		
										stMessage.sCode = "COMD910"
										
									End If
								Else
									bOk = False
									stMessage.sCode = "COMD910"										
								End If
							End If
						Else 
							bOk = False
							stMessage.sCode = "COMD910"
						End If

					End If
					
					// [DT173]
					F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 110 )

					// [BUG_FORFAIT]
					If lDeb > 0 Then
						lDeb = idwDetPro.Find ( "ID_CODE_CAR = '" + sTypApp + "'", lDeb, lFin ) 
					End If

					// [DT075-2]
					if lDeb > 0 Then
						sChaine=idwDetPro.GetItemString(lDeb,"VAL_CAR")
						If isNull(sChaine) Then sChaine=""
						schaine=lnvPFCString.of_getkeyvalue( sChaine, "TYP_APP_REPAR_OBLIG", ";")
						if sChaine <> "" Then
							if Pos(sChaine, "#" + sTypApp + "#") <= 0 Then lDeb=0							
						End if
					End if
					// :[DT075_2]
											
					If lDeb > 0 Then
						sVal=lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( lDeb, "VAL_CAR" ), "REPAR_OBLIG_SI_SUP", ";")
						If sVal="OUI" Then
							
							lRow  = idwLstCmdeSin.Find ( "ID_FOUR = 'O2M' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT IN ( 'RPC', 'RFO' ) AND STATUS_GC > 0", 1, idwLstCmdeSin.RowCount() )									
							dcMtForfait = Dec ( lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( lDeb, "VAL_CAR" ), "FORFAIT", ";") )
	
							dcMtPec=Dec(iuogsspwdetail.uf_gestong_divers_trouver("MT_PEC"))
							If dcMtPec > dcMtForfait And lRow<=0 Then							
								bOk = False
								stMessage.sCode = "COMD923"
							End If
						End if
					End if
					//: [DT173]	
				
				// [PC469]
				Case "DEMANDE ENL"
					If Not bTSF Then
						bOk = False
						stMessage.sCode = "COMD390"
					End If					
				// :[PC469]
				
				// [PM82][LOT1]
				// [HP252_276_HUB_PRESTA] bPrestaHubCodeVerrouManquant 
				Case "REPAR", "RÉPAR"
				
					// [PM330-1]
					If Not bPRS_Retour_153_154 And Not bPRS_Retour_21 And Not bPrestaHubCodeVerrouManquant Then
						bOk = False
						stMessage.sCode = "COMD390"
					End If
				// [PM82][LOT1]
				
				Case "BON EMARGE", "BON ÉMARGÉ"
				
					lRow  = idwLstCmdeSin.Find ( "ID_FOUR = 'SBE' AND COD_ETAT IN ( 'RPC', 'RFO' ) AND STATUS_GC IN ( 2, 21, 152, 178)", 1, idwLstCmdeSin.RowCount() )									
					If lRow <= 0 Then
						bOk = False
						stMessage.sCode = "COMD942"
					End If

				Case "CONTESTATION"
					// Ok (blocage fait plus haut WDET644)
					
				Case "INFORMER"					
					// [DT288-3_LOT1_2EME_VS]
					lRow = idwLstCmdeSin.Find ( "ID_FOUR IN ( 'COR', 'O2M', 'PSM' ) AND COD_ETAT <> 'ANN' AND ( POS ( INFO_FRN_SPB_CPLT, 'SWAP_AUTO_CTR=OUI' ) > 0 OR ( ID_REF_FOUR = 'A_REPARER' AND STATUS_GC = 2) )", 1, idwLstCmdeSin.RowCount ())  

					// [PM445-1]
					lRow1 = 0

					lVal = idwLstCmdeSin.Find ( &
							"ID_REF_FOUR IN ( 'A_REPARER', 'A_DESOXYDER', 'A_DIAGNOSTIQUER' ) AND " + &
							"ISNULL ( DTE_RCP_FRN ) AND LEN ( ID_BON_TRANSP ) > 0 AND " + &
							"POS ( INFO_FRN_SPB_CPLT, 'PRBLE_LIVRAISON' ) > 0 AND " + &
							"POS ( INFO_FRN_SPB_CPLT, 'PERTE_ALLER' ) > 0 AND " + &
							"COD_ETAT IN ( 'ECT', 'ECL' )", &
							1, idwLstCmdeSin.RoWCount () )
				
					If lVal > 0 Then 
							lRow1 = 1
					End If 
		
					If lRow <= 0 And lRow1 <= 0 Then
						bOk = False
						stMessage.sCode = "COMD978"
					End IF 
				
				Case "CONTRÔLE IMEI"
					// [PC874_2_V1]
					// OK
				
				Case Else
					If Not bCDiscount Then
						bOk = False
						stMessage.sCode = "COMD390"
					End If

			End Choose 



/*------------------------------------------------------------------*/
/* Le 25/03/2005 JFF : Courcircuité suite entretien verbal avec M.  */
/* Legac, ce contrôle est gênant pour MSS.                          */
/*------------------------------------------------------------------*/
		Case "R"  // #2
			Choose Case sVal
				Case  "REPAR", "RÉPAR"
					// OK
				Case Else
					bOk = False
					stMessage.sCode = "COMD390"


			End Choose				

			// [HP252_276_HUB_PRESTA]
			If F_CLE_A_TRUE ( "HP252_276_HUB_PRESTA" ) Then
				lRow = idwLstCmdeSin.Find ( & 
								"ID_REF_FOUR = 'A_REPARER' AND " + &
								"COD_ETAT IN ( 'RFO', 'RPC' ) AND " + &
								"POS ( info_spb_frn_cplt, 'HP_ID_HUB_PRESTA' ) > 0", 1, idwLstCmdeSin.RowCount() )
								
				If lRow > 0 Then
					stMessage.sTitre		= "SAV Interdit sur presta HUB"
					stMessage.Icon			= Information!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= OK!
					stMessage.sCode		= "HUBP015"
				
//					F_Message ( stMessage )		
					bOk = False
				End IF 

			End If 
			
			// [DT168] 
			F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 275 )
			lRow = idwLstCmdeSin.Find ( "ID_FOUR = 'SBE' AND ID_REF_FOUR = 'A_REPARER' AND STATUS_GC = 2", 1, idwLstCmdeSin.RowCount() )									
			lRow1 = idwLstCmdeSin.Find ( "ID_FOUR = 'SBE' AND ID_REF_FOUR = 'A_REPARER' AND STATUS_GC = 21 AND ( POS ( COMMENT_FRN, '[BVIE]' ) > 0 OR POS ( COMMENT_FRN, '[BVID]' ) > 0 OR POS ( COMMENT_FRN, '[BVIP]' ) > 0 OR POS ( COMMENT_FRN, '[BVIT]' ) > 0 ) ", 1, idwLstCmdeSin.RowCount() )
			lRow2 = idwLstCmdeSin.Find ( "ID_FOUR = 'SBE' AND ID_REF_FOUR = 'A_REPARER' AND STATUS_GC = 21 AND POS ( COMMENT_FRN, '[BNV]' ) > 0 ", 1, idwLstCmdeSin.RowCount() )													
			
			If ( lRow > 0 Or lRow1 > 0 ) And lRow2 <= 0 And lDeb > 0 Then
				
				If lRow > 0 And ( lRow < lRow1 Or lRow1 = 0 )Then
					bOk = False
					stMessage.sCode = "COMD919"
				End If
				
				If lRow1 > 0 And ( lRow1 < lRow Or lRow = 0 ) Then
					bOk = False
					stMessage.sCode = "COMD920"
				End If
			
			End If

			// [PMO139_RS4926]
			If F_CLE_A_TRUE ( "PMO139_RS4926" ) Then
				F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 152)
				If lDeb > 0 Then
					sChaineBcv = idwDetPro.GetItemString ( lDeb, "VAL_CAR" )
					sVal = lnvPFCString.of_getkeyvalue (sChaineBcv, "PMO139", ";")
					If sVal = "OUI" Then
						lRow = idwWDivSin.Find ( "NOM_ZONE = 'taille_tv'", 1, idwWDivSin.RowCount () ) 
						If lRow > 0 Then sVal=idwWDivSin.GetItemString(lRow,"VAL_CAR")
						If IsNull ( sVal ) Then sVal = ""						
						If sTypApp= "TLC" And sVal = "TI3" Then
							bOk = False
							stMessage.sCode = "COMD391"							
						End IF 
					End If 
				End If 
			End If


			// #12 [DCMP090051]			
			F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 110 )

			// [BUG_FORFAIT]
			If lDeb > 0 Then
				lDeb = idwDetPro.Find ( "ID_CODE_DP = 110 AND ID_CODE_CAR = '" + sTypApp + "'", lDeb, lFin ) 
			End If

			// [DT168] 
			If Not bOk Then lDeb = -1

			// #15 [DCMP090474] Pour ces cas, on shunt dans tous les cas le retour de l'option en forçant à -1
			// #16 [DMDI26886]
			Choose Case sMarque 
				 Case "SAMSUNG"
						Choose Case sModele
							Case "SGHU600", "SGHU600HELLOKITTY"
								lDeb = -1
							
						End Choose

					 Case "LG"
						Choose Case sModele
							Case "KG800", "KG800BLK"
								lDeb = -1
							
						End Choose
			End Choose			
			// #15 [DCMP090474]
			
			// [PM280]
			If lIdEvt = 1422 Then
				lDeb = -1
			End If
			
			//	[VDOC17797]
			If This.wf_vDoc17797 () Then
				lDeb = -1
			End If

			If lDeb > 0 Then
				dcMtForfait = Dec ( lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( lDeb, "VAL_CAR" ), "FORFAIT", ";") )
				
				lIdGti = dw_1.GetItemNumber ( 1, "ID_GTI" )
				lIdDetail = dw_1.GetItemNumber ( 1, "ID_DETAIL" )


				// Recherche forçage Pec
				lRow = dw_w_div_det.Find ( &
									"ID_GTI = " + String ( lIdGti ) + " AND " + &
									"ID_DETAIL = " + String ( lIdDetail ) + " AND " + &
									"NOM_ZONE = 'alt_pec' AND " + &
									"VAL_LST_CAR = 'O'" &																		
									, 1, dw_w_div_det.Rowcount() ) 

			
				If lRow <= 0 Then

					// Recherche Pec
					lRow = dw_w_div_det.Find ( &
										"ID_GTI = " + String ( lIdGti ) + " AND " + &
										"ID_DETAIL = " + String ( lIdDetail ) + " AND " + &
										"NOM_ZONE = 'pec' AND " + &
										"VAL_LST_CAR = 'O'" &									
										, 1, dw_w_div_det.Rowcount() ) 
					
					If lRow > 0 Then
						lRow = dw_w_div_det.Find ( &
									"ID_GTI = " + String ( lIdGti ) + " AND " + &
									"ID_DETAIL = " + String ( lIdDetail ) + " AND " + &
									"NOM_ZONE = 'mt_pec'" &
									, 1, dw_w_div_det.Rowcount() ) 

						If lRow > 0 Then
							dcMtPec = dw_w_div_det.GetItemDecimal ( lRow, "VAL_MT" ) 
							If IsNull ( dcMtPec ) Then dcMtPec = 0
//* #13 [DMDI25498] tranformation < en <=
//						If dcMtPec < dcMtForfait Then

						If dcMtPec <= dcMtForfait Then							
								bOk = False

								stMessage.sCode = "COMD516"

								// [PC938_ORANGE_V3][MANTIS7581]
								F_RechDetPro ( lDeb, lFin, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 239)
								If lDeb > 0 Then
									stMessage.sCode = "COMD805"
								End If 
								
								// [PM246][MANTIS10235]
								// [PC151270_ORANGE_V3]
								F_RechDetPro ( lDeb, lFin, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 94 )
								For lCptDetPro = lDeb To lFin
									sVal = lnvPFCString.of_getkeyvalue ( idwDetPro.GetItemString ( lCptDetPro, "VAL_CAR" ), "COD_DW", ";")
									
									Choose Case sVal 
										Case "ORANGE_V3", "ORANGE_V2BIS", "ORANGE_V3BIS", "ORANGE_V3TER"
											
											If stMessage.sCode = "COMD805" Then
												// les vraie V3 dp/239
												gAutoriseRempl = TRUE
											Else 
												gAutoriseDiag = TRUE
											End If
											
									End Choose 
								Next
								// [PM246][MANTIS10235]
								
							End If
						End If
					End If
				End If
			End If
			// #12 [DCMP090051] - Fin
			
			// [DT276]
			If sMarque = "APPLE" And &
				idwWDivsin.Find ( "NOM_ZONE = 'app_degeoloc' AND VAL_CAR = 'N'", 1, idwWDivSin.RowCount () ) > 0 And &
				idwLstCmdeSin.Find ( "ID_TYP_ART = 'PRS'", 1, idwLstCmdeSin.RowCount ()) <= 0 Then
				
				bOk = False
				stMessage.sCode = "COMD950"
			End If
			

			// [DT288-1_LOT2]
			F_RechDetPro ( lDeb, lFin, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), "-DP", 315)
			If lDeb > 0 Then
				dtDtePivotDT288-1_LOT2 = DateTime ( lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( lDeb, "VAL_CAR" ), "DTE_PIVOT_DT288_1_LOT2", ";") )

				// [DT288-1][MODIF_CHRISTINE]
				bBlocageGeoloc = lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( lDeb, "VAL_CAR" ), "BLOCAGE_GEOLOC", ";")  = "OUI"
				sVal = ""
				
				// Recherche forçage Pec
				lRowForPec = dw_w_div_det.Find ( &
									"ID_GTI = " + String ( lIdGti ) + " AND " + &
									"ID_DETAIL = " + String ( lIdDetail ) + " AND " + &
									"NOM_ZONE = 'alt_pec' AND " + &
									"VAL_LST_CAR = 'O'" &																		
									, 1, dw_w_div_det.Rowcount() ) 

				// Condition d'appel du WS revu avec Hélène par rapport à la NDC
				// [DT288-1][MODIF_CHRISTINE]
				If ( ( sVal = "ORANGE_V3BIS" OR sVal = "ORANGE_V3TER" ) &
					  Or &
					  ( bBlocageGeoloc ) &
					) &
					And &
					sMarque = "APPLE" And & 
					sTypApp = "TEL" And &
					dtCreeLeDos >= dtDtePivotDT288-1_LOT2 And &
					idwLstCmdeSin.RowCount () <= 0 And &
					lRowForPec <= 0 &
					Then
					
					If F_IMEI ( sIMEI, sIMEICorrige ) Then
						
						// Je préviens le GT par un msgbox que l'appel peut prendre en tre 15 et 30s
						stMessage.sTitre		= "Appel de WebService Extérieur"
						stMessage.Icon			= Information!
						stMessage.bErreurG	= FALSE
						stMessage.Bouton		= OK!
						stMessage.sCode		= "WDET659"
					
						F_Message ( stMessage )		
						
						SetPointer ( HOURGLASS! )
						nWsCordon=CREATE n_cst_sp_ws_cordon_caller
						iGeolocalise = nWsCordon.uf_is_geolocalise(sIMEI, dw_1.GetItemNumber(1,"ID_SIN")) // [FPI.20180220]
						SetPointer ( ARROW! )
						
						// iGeolocalise = 0  // Shunt

						If iGeolocalise = -1 Then
							stMessage.sTitre		= "Géolocalisé"
							stMessage.Icon			= Information!
							stMessage.bErreurG	= FALSE
							stMessage.Bouton		= OK!
							stMessage.sCode		= "WDET663"
						
						End If
						
						// Géolo par défaut car invalide (vu avec Hélène)
						If iGeolocalise < 0 And iGeolocalise <> -1 Then
							stMessage.sTitre		= "Géolocalisé"
							stMessage.Icon			= Information!
							stMessage.bErreurG	= FALSE
							stMessage.Bouton		= OK!
							stMessage.sCode		= "WDET661"
						
						End If
						
						// Géoloc normal
						If iGeolocalise = 1 Then
							stMessage.sTitre		= "Géolocalisé"
							stMessage.Icon			= Information!
							stMessage.bErreurG	= FALSE
							stMessage.Bouton		= OK!
							stMessage.sCode		= "WDET660"
							
						End If
						
						// Dégéolc
						If iGeolocalise = 0 Then
							stMessage.sTitre		= "Dégéolocalisé"
							stMessage.Icon			= Information!
							stMessage.bErreurG	= FALSE
							stMessage.Bouton		= OK!
							stMessage.sCode		= "WDET662"
						
							F_Message ( stMessage )		
						
						// Marquage DéGéoloc								
							lRow = idwWDivSin.Find("Upper(NOM_ZONE)='GEOLOC_SIMPA2'", 1, idwWDivSin.RowCount())
							If lRow > 0 Then
								idwWDivSin.SetItem(lRow,"VAL_CAR","N")
								dtMajLe = DateTime ( Today (), Now () )
								idwWDivSin.SetItem ( lRow, "MAJ_LE", dtMajLe  )
								idwWDivSin.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )
								idwWDivSin.SetItem ( lRow, "ALT_SUPP", "N" )
							End If
							
						End If

						// Marquage Géoloc
						If iGeolocalise < 0 Or iGeolocalise = 1 Then
							bOk = False
							lRow = idwWDivSin.Find("Upper(NOM_ZONE)='GEOLOC_SIMPA2'", 1, idwWDivSin.RowCount())
							If lRow > 0 Then
								idwWDivSin.SetItem(lRow,"VAL_CAR","O")
								dtMajLe = DateTime ( Today (), Now () )
								idwWDivSin.SetItem ( lRow, "MAJ_LE", dtMajLe  )
								idwWDivSin.SetItem ( lRow, "MAJ_PAR", stGlb.sCodOper )
								idwWDivSin.SetItem ( lRow, "ALT_SUPP", "N" )
							End If
							
						End If

						Destroy nWsCordon
					
					Else
						// Géoloc par défaut car aucun IMEI n'est saisi
					
					End If 						

				End If
							
			End If				
			
			
			
		Case "C", "S"
			Choose Case sVal
				Case  "REMPL"
					// Ok 
					
					// [DT141] 
					F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 275 )
					If lDeb > 0 And sMarque = "APPLE" Then
						Choose Case lIdGti
							Case 10, 8, 24, 12
								// Pas de diag SBE, c'est normal
							Case Else
								// En revanche pour le reste, on doit d'abord avoir un diag SBE
								lRow  = idwLstCmdeSin.Find ( "ID_FOUR = 'SBE' AND ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT IN ( 'RPC', 'RFO' ) AND STATUS_GC > 0", 1, idwLstCmdeSin.RowCount() )									
								// [MANTIS15744]
								lRow1 = idwLstCmdeSin.Find ( "ID_FOUR IN ('PSM','O2M') AND ID_REF_FOUR IN ('A_REPARER', 'A_DIAGNOSTIQUER')", 1, idwLstCmdeSin.RowCount() )																		
								
								If lRow <= 0 And lRow1 <= 0 Then
									bOk = False
									stMessage.sCode = "COMD911"
								End If
								
						End Choose
					End If


					// [VDOC27799]
					// X. Robert a eu "la bonne idée" (hum...) de marquer sur KSL la possibilité de n'émettre qu'un seul BGE ELD sur un même sinistre
					// Nous sommes donc obligés de bloquer l'envoi d'un deuxième car il ne sera jamais généré par KSL.
/*
						F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 266 )
						If lDeb > 0 Then
							lRow  = idwLstCmdeSin.Find ( "ID_FOUR = 'ELD'", 1, idwLstCmdeSin.RowCount() )																
							
							If lRow > 0 Then
								bOk = False
								stMessage.sCode = "COMD990"							
							End If 
						End If 
*/
					
					// [PM246]
					// [PM246][MANTIS10235]
					// [PC151270_ORANGE_V3]
					// [VDOC21471]
					If iuoGsSpwDetail.uf_GestOng_Divers_Trouver ("ALT_PEC" ) <> "O" And &
						Not gAutoriseDiag And &
						Not gAutoriseRempl And &
				 		lIdEvt <> 1423 &
						Then
						
						// [ITSM529150]
						Choose Case lIdGti
							Case 10, 8, 12
								// Pas de réparation, c'est normal
							Case Else
								Choose case lIdEvt 
									Case 1396
										// On laisse passer
									Case Else
										F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 94 )
										For lCptDetPro = lDeb To lFin
											sVal = lnvPFCString.of_getkeyvalue ( idwDetPro.GetItemString ( lCptDetPro, "VAL_CAR" ), "COD_DW", ";")
											
											Choose Case sVal 
												Case "ORANGE_V3", "ORANGE_V2BIS", "ORANGE_V3BIS", "ORANGE_V3TER"
													lRow = idwLstCmdeSin.Find ( "ID_TYP_ART = 'PRS' AND COD_ETAT <> 'ANN' AND CPT_VALIDE > 0", 1, idwLstCmdeSin.RowCount ()) 
													
													// ITSM214537
													lRow1 = idwLstCmdeSin.Find ( "ID_REF_FOUR = 'A_DIAGNOSTIQUER' AND COD_ETAT <> 'ANN' AND CPT_VALIDE > 0", 1, idwLstCmdeSin.RowCount ()) 
													
													If lRow <= 0 And lRow1 <= 0 And Not iuoGsSpwDetail.uf_GetAutorisation ( 208 ) Then
														bOk = False
														stMessage.sCode = "COMD841"
														stMessage.sVar [1] = "une commande de remplacement"
													End If
											End Choose 
										
										Next
								End Choose 
						End Choose
						
					End If
					// :[PM246]
					
				//[MCO602_PNEU]
				Case "BANQUE EDEL"

					// OK 					
					
					
				Case Else 
					bOk = False
					stMessage.sCode = "COMD390"
			End Choose
				
	End Choose				

	If Not bOk Then

		stMessage.bErreurG	= FALSE
		stMessage.sTitre		= "Contrôle de saisie du détail"
		stMessage.Icon			= Information!

		f_Message ( stMessage )
		
		// [DT276]
		If stMessage.sCode = "COMD950" Then
			Run( sPathIE + " " + "https://www.icloud.com/activationlock/", Maximized!)
		End If
	End If

End If

Return bOk


end function

public function boolean wf_vdoc17797 ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_td_sp_w_detail::wf_vDoc17797 (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 04/06/2015 
//* Libellé       : Pour Tamet, on ne tient pas compte du forfait
//* Commentaires  : [VDOC17797]
//*
//* Arguments     : 
//*
//* Retourne      : TRUE si on court-cicuit le forfait
//*					  FALSE sinon
//*
//*-----------------------------------------------------------------

Boolean bShunt
Long lDeb, lFin, lRow, lCpt
String sTypApp, sMarque, sVal
n_cst_string lnvPFCString

bShunt = FALSE

F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 140 )
If lDeb <= 0 Then Return FALSE

sMarque = Upper ( idwWSin.GetItemString ( 1, "MARQ_PORT" ) )
lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, idwWDivSin.RowCount () ) 
If lRow <= 0 Then 
	sTypApp = ""
Else
	sTypApp = Upper ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) )
End If

F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 148 )

For lCpt = lDeb To lFin
	
	If idwDetPro.GetItemString ( lCpt, "ID_CODE_CAR" )	<> "TMT" Then
		Continue
	End If
	
	sVal = lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( lCpt, "VAL_CAR" ), "TYPE_APP", ";")
	
	If Pos ( sVal, "#" + sTypApp + "#" ) > 0 Then
		sVal = lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( lCpt, "VAL_CAR" ), "MARQUE", ";")
		
		If Pos ( sVal, "#" + sMarque + "#" ) > 0 Then
			bShunt = TRUE
			Exit
		End If
	End If
Next

Return bShunt

end function

public subroutine wf_marquageetatpiecesherpa (integer aid_pce, string asetat_pce, integer aiidi);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_w_detail::Wf_MarquageEtatPieceSherpa (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 03/01/2020
//* Libellé			: 
//* Commentaires	: [PC192290]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Int iRow
DateTime dtJour

iRow = gdsPieceSherpa.Find ( "ID_PCE = " + String ( aid_pce ), 1, gdsPieceSherpa.RowCount ()) 

If iRow <= 0 Then
	iRow = gdsPieceSherpa.InsertRow ( 0 )
	gdsPieceSherpa.SetItem ( iRow, "ID_PCE", aid_pce ) 
End If 

dtJour = DateTime ( Today(), Now())

gdsPieceSherpa.SetItem ( iRow, "ETAT_PCE", Trim ( Upper ( asEtat_Pce ) ) ) 
gdsPieceSherpa.SetItem ( iRow, "DTE_ANALYSE_PCE", dtJour ) 
gdsPieceSherpa.SetItem ( iRow, "ID_I", aiIdI ) 

end subroutine

public subroutine wf_marquageetatpiecesherpa_rs5656 (integer aid_gti, integer aid_detail, integer aid_pce, string asetat_pce, integer aiidi);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_w_detail::Wf_MarquageEtatPieceSherpa_RS5656 (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 03/01/2020
//* Libellé			: 
//* Commentaires	: [PC192290]
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Int iRow
DateTime dtJour
String sModeFctDp345, sCodePce
n_cst_string lnvPFCString
Long lDeb, lFin

// Determination de la Méthode  // [RS5656_MOD_PCE_DIF]
F_RechDetPro(lDeb, lFin, idwdetpro, idwProduit.GetItemNumber( 1,"ID_PROD"),"-DP",345)
sModeFctDp345 = lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( lDeb, "VAL_CAR" ), "MODE_FCT", ";")
If sModeFctDp345 = "" Then sModeFctDp345 = "UNIQUE"

Choose Case sModeFctDp345 
	Case "UNIQUE"
		aId_Gti = -1
		aId_Detail = -1		
		iRow = gdsPieceSherpa.Find ( "ID_PCE = " + String ( aId_Pce ), 1, gdsPieceSherpa.RowCount ()) 
	Case "DET_GARANTIE"
		iRow = gdsPieceSherpa.Find ( "ID_GTI = " + String ( aId_Gti ) + " AND ID_DETAIL = " + String ( aId_Detail ) + " AND ID_PCE = " + String ( aId_Pce ), 1, gdsPieceSherpa.RowCount ()) 
End Choose 


If iRow <= 0 Then
	iRow = gdsPieceSherpa.InsertRow ( 0 )
	gdsPieceSherpa.SetItem ( iRow, "ID_GTI", aid_gti ) 
	gdsPieceSherpa.SetItem ( iRow, "ID_DETAIL", aId_Detail ) 	
	gdsPieceSherpa.SetItem ( iRow, "ID_PCE", aid_pce ) 
End If 

dtJour = DateTime ( Today(), Now())

gdsPieceSherpa.SetItem ( iRow, "ETAT_PCE", Trim ( Upper ( asEtat_Pce ) ) ) 
gdsPieceSherpa.SetItem ( iRow, "DTE_ANALYSE_PCE", dtJour ) 
gdsPieceSherpa.SetItem ( iRow, "ID_I", aiIdI ) 

end subroutine

event ue_item5;call super::ue_item5;//*------------------------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_W_Detail
//* Evenement 		: ue_Item5
//* Auteur			: Fabry JF
//* Date				: 19/09/01
//* Libellé			: Déclenchement du Click sur le bouton Commander
//* Commentaires	: 
//*				  
//*--------------------------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  CAG  18/02/2003 DCMP 030103 : Ajout d'une box pour confirmer
//*								saisie d'une cmde/prs alors qu'il en existe
//*								déjà.
//* #2  JFF  30/10/2003	MtValAchat (si DET_PRO=9) obligatoire pour commander
//* #3  JFF		03/03/2004 DCMP 040098 : Modification pour ORANGE Marketing.
//*   MADM	09/01/2006 DCMP 060007 : HANDSPRING peut être commandée maintenant.
//* #4  JFF  22/03/2006  Réinitialisation du sRech (Bug sinon)
//* #5 MADM  20/07/2007  DCMP 060538 bloquer l'envoi en centre de réparation de la marque VK
//* #6 MADM  28/07/2006  DCMP 060555 bloquer l'envoi en centre de réparation des marques ETEN et MIO
//* #7 MADM  03/08/2006 DCMP 060562 bloquer l'envoi en centre de réparation de la marque PALMONE et PALM (Même marque)
//* #8 MADM  09/10/2006 DCMP 060693 Gestion Media Saturn
//* -- JFF   06/11/2006 DCMP 060805 Interdiction "Asus"
//* -- JFF   20/11/2006 DCMP 060842 Interdiction "BENQ SIEMENS"
//* #9 PHG	 25/11/2006 [CRAO_LOT2] Desactivation Option 19
//* #10 JFF    01/10/2007   [DCMP070689] complèment Darty Swap&DartyMP
//* #11 JFF	 20/12/2007 [O2M]
//* #12 JFF  31/10/2007 [DCMP070819]
//* #13 JFF  10/01/2007 [DCMP080033] Ajout APPLE en interdiction Totale
//* #14 PHG	 18/01/2008 [DCMP080058] Retrait ASUS en Interdiction Totale
//* #15 PHG  21/01/2008 [DCMP080073] Retrait RIM BLACKBERRY en Interdiction Totale
//*										    & Routage RIM BLACKBERRY vers SBE.
//* #16 JFF  28/01/2008 [DCMP080028]
//* #17 JFF  29/01/2008 [DCMP080099]
//* #18 PHG  31/01/2008 [DCMP080110] Interdiction Totale Marque SIEMENS
//* #19 JFF  13/05/2008 [DMDI22776]
//* #20 JFF  10/06/2008 [DCMP080204]
//* #21 JFF  10/06/2008 [DCMP080426]
//* #22 JFF  25/09/2008 [DMDI23918]
//* #23 JFF  06/01/2009 [DMDI24606]
//* #24 JFF  06/01/2009 [DMDI24655]
//* #25 FPI  20/03/2009 [DCMP090109] O2M Réparateur IPhone
//* #26 JFF	 20/04/2009 [DMDI25515][DMDI25516]
//* #27 JFF  12/06/2009 [DCMP090243]
//* #28 JFF  12/06/2009 [DMDI25906]
//* #29 JFF  24/06/2009 [DMDI25985]
//* #30 JFF  24/06/2009 [DCMP090355]
//* #31 JFF  31/08/2009 [O2M_DIAG_NOMADE].[JFF].[20090831160025717]
//* #32 JFF  03/08/2009 [SCCCG13]
//* #33 JFF  22/10/2009 [O2M_DIAG_NOMADE].[JFF].[20091022224855853]
//* #34 JFF  30/12/2009 [DCMP090751]
//* #35 FPI	 13/01/2010	[DCMP090760] 
//* #36 JFF  19/01/2009 [DCMP100026]
//* #37 FPI	 29/03/2010	[DCMP100233]
//* #38 FPI	 30/03/2010	[DCMP100183]
// 	  FPI  27/04/2010 [DCMP100306] Ajout de 39400 à 39404
//      JFF	 29/04/2010 [MSS_LOT2].[20100429165933570]
//      JFF  03/06/2010 [PC397/443_IPAD]
//      JFF  29/06/2010 [PC41]
//      JFF  22/07/2010 [PM140]
//		  FPI	 27/10/2010	[VDoc1338] Interdiction réparation mobile DELL
//      JFF  13/12/2010 [PC551]
//      JFF  21/12/2010 [PC474]
//		FPI	18/02/2011	[PC321]
//      JFF  08/04/2011 [PC430][V10]
//      FPI	 11/04/2011	[PC434]
//      FPI	 11/04/2011	[PC442]
//		  JFF  15/04/2011 [PC323]	9620		
//		FPI	18/04/2011	[VDoc3926] Interdiction de réparer la marque OWASYS
//		FPI	19/04/2011	[PC581] ajout du 10940 pour la réparation d'IPAD
//		FPI	02/05/2011	[PC595]
//		FPI	11/05/2011	[PC514]
//		FPI	31/05/2011	 [PC581] [PC514] [PC512-1] Ajout d'IPhone en réparation
//		FPI	04/07/2011	 [PC514-1] 
//    JFF   12/07/2011   [PC547] Ajout produit 30800 à 30803
//	FPI	01/08/2011	 [PC413-1_Lot1] Ajout 22511 to 22514
//		FPI	16/08/2011	[VDoc4995] Interdiction de MTT en réparation
//	FPI	16/08/2011	 [PC521] Ajout de 44500 pour l'IPhone
//*       JFF   19/09/2011   [PM82][LOT1]
// 		FPI	27/09/2011	[PC514-1] Ajout 36812,36813 pour l'IPad
// 		FPI	05/10/2011	[VDoc4564] Option 200 pour les IPad & Iphones
// 		FPI	30/11/2011	[VDoc6143] Ajout modèles d'Iphone 4S
//*      JFF    16/02/2012   [ITSM105388]
//*      JFF    23/02/2012   [VDOC7066]
//*      JFF    22/03/2012   [VDOC7214]
// 		FPI	30/03/2012	[VDoc7440] Ajout des IPad2
//       JFF   12/04/2012  [VDOC7507][VDOC7577]
//       JFF   17/09/2012  [MANTIS3276]
//		FPI	20/09/2012	[VDoc8903] Iphone 5
//		JFF	10/10/2012	[PC869]
//		JFF	20/10/2012	[MANTIS6300]
//    JFF   07/01/2013  [PC202][LOT2][PC041][LOT2]
// 	JFF	29/01/2013 [PC801_MANTIS6481]
//      JFF   19/02/2013	   [VDOC9304_PM82_LOT1]
//      JFF   10/04/2013	   [VDOC10886]
//       JFF   07/05/2013 [PC938_ORANGE_V3]
//       JFF   20/06/2013 [VDOC10659]
//       JFF   09/09/2013 [PM222-1]
//    JFF   04/10/2013 [PC980_MANTIS8945]
//		FPI	08/11/2013	[VDOC12693]
//    JFF	10/10/2013 [VDOC12436]
//       JFF   12/12/2013 [PC947&977]
//       JFF   18/02/2014 [PM246][MANTIS10235]
// 		JFF 	05/05/2014 [VDOC14301]
//        JFF   01/07/2014   [PC786-1_AUCHAN_GEM][MANTIS11397] 
//        JFF    26/05/2013  [DT87][MANTIS12320]
//		FPI	10/09/2014		[DT088]
//    JFF   23/09/2014 		[VDOC15439]
//       JFF   02/10/2014 [VDOC15485]
//       JFF   14/10/2014 [OPTIM_IPHONE]
//       JFF   04/11/2014 [PM280-1]
// 		FPI	10/11/2014	[VDOC15936]
//       JFF   27/01/2015 [PM222-1]
//       JFF   03/04/2015 [PM222-1] V4
//       JFF   21/05/2015 [ITSM294822]
//       JFF   03/07/2015 [PM280-1][ITSM304152]
//       JFF   13/07/2015 [PC151270_ORANGE_V3]
//		FPI	14/09/2015 [DT173].Mt17057
//       JFF   22/09/2015 [VDOC18734]
//     JFF     12/10/2015 [ITSM332030]
//		JFF	23/12/2015 [DT173].Mt17057 suite erreur FPI.
//       JFF   06/01/2016 [PC13313]
//       JFF   08/02/2016 [PC151522]
//      JFF    29/03/2016 [DT200]
//       JFF   17/05/2016 [PM280-2]
//       JFF   03/04/2017 [DT288][M24507]
//       JFF   18/05/2017 [DT288-1][M25113]
//       JFF   19/05/2017 [BUG_ID_I_REG]
//       JFF   23/08/2017 [DT288-3_LOT1][PM280]
//       JFF   29/08/2017 [PM395-1]
//       JFF   09/11/2017 [VDOC25048] Retrait de la marque HP de l'interdiction, PA TASSEL / MYRELIS
// 		JFF	15/05/2018 [VDOC26046] ajout A_RECUP_A_RECYCLER
// 		JFF	30/11/2018 [ITSM576546]
// 		JFF	10/05/2019 [PM445-1]
//       JFF   17/09/2019 [DT447]
// 		JFF	29/10/2020 [VDOC29781] 
//*----------------------------------------------------------------------------------

Boolean	bCommander, bCmd, bCdiscount, bSavRDC, bDartyIPAD, bPRSTropVieille ,bPRSSAVTropVieille, bDejaEuMsg
String	sRech, sChoixAction, sVal, sCasGestion, sMarque, sTypApp, sModele, sCle, sMessDurGti, sLibEvt, sCodTypRecu, sVal1, sVal2
Long		lDeb, lFin, lTrouve, lIdEvt, lROW, lTotCmd, lCptCmd, lMois, lIdProd, lDeb2, lFin2, lRow2, lIdDetail, lIdGti, lRow3, lRow4, lCptDetPro, lIdSin
Decimal{2} dcMtValAchat
DateTime	dtJour, dtDtePivotDT447, dtCreeLeDos
Date     dJour, dtEnvcli 
n_cst_string nvstring
Boolean bRefusIPad
n_cst_attrib_key	lnv_key[] // [VDoc4564]
Long 	lMoisApple, lMoisHApple1, lMoisHApple2
Boolean bARepGti // [PM280-1][ITSM304152]
Boolean bCmdeRempl 
Boolean bDelaiSavLaParisienne // [PM395-1]
Long  lCodEtat // [BUG_ID_I_REG]
Decimal dcIdProd, dcIdRev, dcIdGti, dcIdCie // [PM395-1]

bCmd = True
bRefusIpad=FALSE
bDejaEuMsg = False
bARepGti = False
bDelaiSavLaParisienne = False // [PM395-1]

lIdProd = istPass.dwMaster.GetItemNumber ( 1, "ID_PROD" ) // #25 [DCMP090109]
lIdSin = Dw_1.GetItemNumber ( 1, "ID_SIN" )
lIdDetail = Dw_1.GetItemNumber ( 1, "ID_DETAIL" )
lIdGti = Dw_1.GetItemNumber ( 1, "ID_GTI" )
sLibEvt  = Upper ( dw_1.Describe ( "Evaluate ('LookUpDisplay ( ID_EVT )', 1)" ) )
lCodEtat = Dw_1.GetItemNumber ( 1, "COD_ETAT" ) // [BUG_ID_I_REG]
dcIdRev = idwWSin.GetItemDecimal ( 1, "ID_REV" ) // [PM395-1]
dcIdProd = Dec ( lIdProd )
dcIdGti = Dec ( lIdGti ) 

dtCreeLeDos = idwWSin.GetItemDateTime ( 1, "CREE_LE" ) // [DT447]

// [BUG_ID_I_REG]
If lCodEtat <> 600 Then
	Dw_1.SetItem ( 1, "ID_I_REG", stNul.lng)
End If

F_RechDetPro ( lDeb, lFin, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 37 )
bCdiscount = lDeb > 0

// [PC321]
F_RechDetPro ( lDeb, lFin, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 141 )
bSavRDC = lDeb > 0
// :[PC321]

// #20 [DCMP080204]
lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, idwWDivSin.RowCount () ) 
//Si Row non trouvé alors HP interdit
If lRow <= 0 Then 
	sTypApp = ""
Else
	sTypApp = Upper ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) )
End If

// [OPTIM_SQL]
dtJour=Datetime( Today(), Now() )
// :[OPTIM_SQL]

dJour = Date ( dtJour )
// :#20

Dw_Choix_Action.AcceptText ()
If Dw_1.AcceptText () <= 0 Then Return

sChoixAction = dw_Choix_Action.GetItemString ( 1, "CHOIX_ACTION" )
lIdEvt = dw_1.GetItemNumber ( 1, "ID_EVT" )

bCmd = This.wf_Condition_Ouverture ( sChoixAction )

If Not bCmd Then Return

/*------------------------------------------------------------------*/
/* DCMP 050009 : C Chauvin                                          */
/*------------------------------------------------------------------*/
// FPI - 23/10/2013 - Suppr des autorisations 206,207
/*
Choose Case sChoixAction 
	Case "R"
		sRech = "ID_NAT_OPER = 206 AND " + &
			  "ID_OPER     = '" + stGlb.sCodOper + "' AND " + &
			  "( ID_PROD     = " + String ( lIdProd ) + " OR " + &
			  "  ID_PROD     = -1 )" 

		SQLCA.PS_S01_AUTORISATION ( 206, '*', lIdProd, lTrouve )
		If lTrouve <= 0 Then sRech = ""

		stMessage.sVar [1]  = "d'une réparation"

	Case "C"
		sRech = "ID_NAT_OPER = 207 AND " + &
			  "ID_OPER     = '" + stGlb.sCodOper + "' AND " + &
			  "( ID_PROD     = " + String ( lIdProd ) + " OR " + &
			  "  ID_PROD     = -1 )" 

		SQLCA.PS_S01_AUTORISATION ( 207, '*', lIdProd, lTrouve )
		If lTrouve <= 0 Then sRech = ""

		stMessage.sVar [1]	= "d'un remplacement"

	Case "I"
		sRech = ""

   Case Else 
		sRech = ""

End Choose
*/

If sRech <> "" Then
	If idwAutorisation.Find ( sRech, 1, idwAutorisation.RowCount () ) <= 0 Then	
		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "COMD110"

		bCmd = False
		F_Message ( stMessage )
		Return 
	End If
End If

/*------------------------------------------------------------------*/
/* DCMP 050029 : M Legac														  */
/*------------------------------------------------------------------*/
sMarque = Upper ( idwWSin.GetItemString ( 1, "MARQ_PORT" ) )
sModele = Upper ( idwWSin.GetItemString ( 1, "MODL_PORT" ) ) // #18

// #4
sRech = ""
// Fin #4

// Interdiction par marque modèle pour tout produit, tout réparateur
Choose Case sChoixAction 
	Case "R"

		Choose Case sMarque 
			 // #19
			 Case "PACK ASUS / HUAWEI"
					Choose Case sModele
						Case "EEEPC / CLE3G+"
							sRech = "TROUVE"
							stMessage.sVar [1]  = sMarque + " modèle " + sModele
							stMessage.sCode	  = "COMD113"
							
					End Choose

			 Case "HUAWEI" //* #23 
					Choose Case sModele
						Case "CLE3G+ E172", "228"
							sRech = "TROUVE"
							stMessage.sVar [1]  = sMarque + " modèle " + sModele
							stMessage.sCode	  = "COMD113"
							
					End Choose

				 Case "SFR" //* #23 #24
					Choose Case sModele
						Case "111", "227", "228", "231", "MY POCKET 521"
							sRech = "TROUVE"
							stMessage.sVar [1]  = sMarque + " modèle " + sModele
							stMessage.sCode	  = "COMD113"
							
					End Choose

				 Case "COMPAL" //* #24
					Choose Case sModele
						Case "MY POCKET 521"
							sRech = "TROUVE"
							stMessage.sVar [1]  = sMarque + " modèle " + sModele
							stMessage.sCode	  = "COMD113"
							
					End Choose

				 Case "ARCHOS" //* #24
					Choose Case sModele
						Case "3G+"
							sRech = "TROUVE"
							stMessage.sVar [1]  = sMarque + " modèle " + sModele
							stMessage.sCode	  = "COMD113"
							
					End Choose

				 Case "SAMSUNG" //* #24 #28
					Choose Case sModele
						Case "PC P200", "SGHE900HUMMER"
							sRech = "TROUVE"
							stMessage.sVar [1]  = sMarque + " modèle " + sModele
							stMessage.sCode	  = "COMD113"
							
					End Choose


			
			/*------------------------------------------------------------------*/
			/* #5 DCMP 060538 : M Legac													  */
			/* #6 DCMP 060555                                                   */
			/*--------------------------------------------------------------------------------------------------------------------------*/	
			/*MADM 20/04/2006 : DCMP 060184 : La Marque HP ne doit plus être envoyé en réparation mais fera l'objet d'un retour ches SPB*/
			/*Cela ne concerne que la téléphonie     										    																	 */
			/* #7 MADM 18/08/2006 DCMP 060562 IDEM pour la marque PALMONE, PALM							   											 */
			/*--------------------------------------------------------------------------------------------------------------------------*/	
			// #38 -[DCMP100183] Ajout ALCATEL et SAGEM
			
// Interdiction pour toutes ces marques.
// [PM140] Retrait "PALMONE", "PALM"
// [VDOC10886] Retrait Alcatel de l'interdiction.
// [VDOC25048] Retrait de la marque HP de l'interdiction, PA TASSEL / MYRELIS
			Case "SENDO", "VK", "MIO", "BENQ SIEMENS", "APPLE", &
					"BENQ", "DIRLAND", "DREAMPHONE", "GRUNDIG", "HANDSPRING", "MALATA", "MITAC", &
					"MITSUBISHI ELECTRIC", "MYWAY", "OPTION", "WONU", "XCUTE", "SIEMENS", "PANASONIC", "CECT", "SAGEM" // #13 #12 "ETEN" #14 "ASUS", #17, #18, #22

				If	sTypApp = "" Then Return // #20 [DCMP080204]

				// [PC397/443_IPAD]
				Choose Case sTypApp 
					Case "TEL", "TPC"

						sRech = "TROUVE"
						stMessage.sVar [1]  = sMarque 
						stMessage.sCode		= "COMD113"
						
						// [DT87][MANTIS12320] Cas du SAV
						If idwLstCmdeSin.Find ( "ID_REF_FOUR = 'A_REPARER'", 1, idwLstCmdeSin.Rowcount() ) > 0 Then
							sRech = ""
							stMessage.sVar [1]  = ""
							stMessage.sCode		= ""
						End If
						
					Case ELSE
					//Ok on laisse passer
				End Choose
				// :[PC397/443_IPAD]

			// 	[VDoc1338] 
			Case "DELL"
				If	sTypApp = "" Then Return 
	
				Choose Case sTypApp 
					Case "TEL"
						sRech = "TROUVE"
						stMessage.sVar [1]  = sMarque 
						stMessage.sCode		= "COMD113"
					Case ELSE
					//Ok on laisse passer
				End Choose
			// :[VDoc1338] 
			
			//	[VDoc3926] 
			Case "OWASYS"
				If	sTypApp = "" Then Return 
	
				Choose Case sTypApp 
					Case "TEL"
						sRech = "TROUVE"
						stMessage.sVar [1]  = sMarque 
						stMessage.sCode		= "COMD113"
					Case ELSE
					//Ok on laisse passer
				End Choose
			// :[VDoc3926] 

			
		End Choose

	Case Else 
		sRech = ""

End Choose 

// [PC442]
F_RechDetPro ( lDeb, lFin, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 168 )
If lDeb > 0 and sChoixAction = "R" Then
	sVal=nvstring.of_getkeyvalue( idwDetPro.GetItemString(lDeb,"VAL_CAR"), "TYPE_APP",";")
	If Pos(sVal, "#" + sTypApp + "#") > 0 Then
		sRech = "TROUVE"
		stMessage.sVar [1]  = "pour ce produit et ce type d'appareil"
		stMessage.sCode	  = "COMD517"
	End if
End if
// :[PC442]

// [PC947&977]
F_RechDetPro ( lDeb, lFin, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 253 )
If lDeb > 0 and sChoixAction = "C" Then
	sVal=nvstring.of_getkeyvalue( idwDetPro.GetItemString(lDeb,"VAL_CAR"), "TYPE_APP",";")
	If Pos(sVal, "#" + sTypApp + "#") > 0 Then
		sRech = "TROUVE"
		stMessage.sVar [1]  = "pour ce produit et ce type d'appareil"
		stMessage.sCode		= "COMD837"
	End if
End if

F_RechDetPro ( lDeb, lFin, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 252 )
If lDeb > 0 and ( sChoixAction = "C" Or sChoixAction = "R") Then
	lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'AUT_ACC_SIN'", 1, idwWDivSin.RowCount () ) 
	If lRow > 0 Then 
		sVal=idwWDivSin.GetItemString(lRow,"VAL_CAR")
		If sVal = "O" Then
			sRech = "TROUVE"
			stMessage.sCode = "COMD838"
		End If
	End If
End If
// [PC947&977]

// [PM280-1]
// [PM280-2]
// [DT288-3_LOT1][PM280]
lRow=idwLstCmdeSin.Find ( &
	"ID_FOUR IN ( 'O2M' ) AND " + &
	"STATUS_GC <> 176 AND " + &
	"COD_ETAT <> 'ANN' AND " + &
	"( ID_TYP_ART NOT IN ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' ) " + &
	"  OR " + &
	"  ( ID_TYP_ART = 'RST' AND POS ( INFO_SPB_FRN_CPLT, 'RST_CMDE+SUIVI=OUI' ) > 0 ) " + &
	") " &
	, 1, idwLstCmdeSin.RowCount () )

IF sChoixAction = "R" And lRow > 0 Then
	stMessage.sTitre		= "Commandes"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "COMD887"
	
	F_Message ( stMessage )		

	istPass.sTab [ 4 ]=  idwLstCmdeSin.GetItemString(lRow, "ID_SERIE_NOUV") // n° IMEI provenant de l'adhésion (a pu être modifié depuis l'ouverture du sinistre)
	istPass.sTab [ 5 ] = idwLstCmdeSin.GetItemString(lRow, "ID_MARQ_ART") // Marque portable adhésion.
	istPass.sTab [ 6 ] = idwLstCmdeSin.GetItemString(lRow, "ID_MODL_ART")  // Modèle portable adhésion.
	
	sRech = ""
	// [PM280-1][ITSM304152]
	bARepGti = True // [ITSM304152]
	bDejaEuMsg=TRUE // [ITSM287089]	

End If 

IF lIdEvt = 1426 And sChoixAction = "I" And lRow > 0 And &
	idwLstCmdeSin.Find ( "ID_REF_FOUR = 'CONTEST_SUR_REMPL' AND ID_GTI = " + String ( lIdGti ) + " AND ID_DETAIL = " + String ( lIdDEtail), 1, idwLstCmdeSin.RowCount ()) <=0 &
Then
	stMessage.sTitre		= "Commandes"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "COMD943"
	
	F_Message ( stMessage )		

	istPass.sTab [ 4 ]=  idwLstCmdeSin.GetItemString(lRow, "ID_SERIE_NOUV") // n° IMEI provenant de l'adhésion (a pu être modifié depuis l'ouverture du sinistre)
	istPass.sTab [ 5 ] = idwLstCmdeSin.GetItemString(lRow, "ID_MARQ_ART") // Marque portable adhésion.
	istPass.sTab [ 6 ] = idwLstCmdeSin.GetItemString(lRow, "ID_MODL_ART")  // Modèle portable adhésion.
	
	sRech = ""
	// [PM280-1][ITSM304152]
	bARepGti = True // [ITSM304152]
	bDejaEuMsg=TRUE // [ITSM287089]	

End If 


// [ITSM332030]
F_RechDetPro ( lDeb, lFin, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 256 )
If lDeb > 0 And sRech = "TROUVE" And sChoixAction = "R" And sMarque = "APPLE" Then
	sRech = "" // Car ça va chez SRR et non O2M
End If

// [PC13313]
F_RechDetPro ( lDeb, lFin, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 294)
If lDeb > 0 And sRech = "TROUVE" And sChoixAction = "R" Then
	sRech = "" 
End If

// #25 [DCMP090109]
// contradiction interdiction
If sRech = "TROUVE" Then
	Choose Case sChoixAction 
		Case "R"
			Choose Case sMarque 
				 Case "APPLE"
					
					Choose Case TRUE 
						
						Case Pos ( sModele, "IPHONE" ) > 0
							
							lnv_key[1].iskeyname = "MODELE"
							lnv_key[1].iakeyValue = "IPHONE"
							lnv_key[2].iskeyname = "METHODE"
							f_rechdetpro_withkey(lRow, idwDetPro, lIdProd,"-DP", 200, lnv_key)

							// [PC801_MANTIS6481]
							If lIdEvt = 1377 Then 
								lRow = 0
								sRech=""
							End If 
							// [PC801_MANTIS6481]
							
							// [PM246][MANTIS10235]
							// [PC151270_ORANGE_V3]
							F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 94 )
							For lCptDetPro = lDeb To lFin
								sVal = nvstring.of_getkeyvalue ( idwDetPro.GetItemString ( lCptDetPro, "VAL_CAR" ), "COD_DW", ";")
								
								Choose Case sVal 
									Case "ORANGE_V3", "ORANGE_V2BIS", "ORANGE_V3BIS", "ORANGE_V3TER"
										// On coupe, vu avec Lisette et ML Gasnier suite mantis 10235 le 17/12/2014
										lRow = 0
										sRech=""
								End Choose 
							Next
							// [PM246][MANTIS10235]							
							
							// [DT288-1][M25113]
							F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 315 )
							If lDeb > 0 Then
								lRow = 0
								sRech=""
							End If
								
							If lRow > 0 Then
								If lnv_key[2].iakeyValue = "ACCORD_48H" Then
									// Question si bris concerne uniquement l'écran ?WDET566
									stMessage.sTitre		= "Commandes"
									stMessage.Icon			= Question!
									stMessage.bErreurG	= FALSE
									stMessage.Bouton		= YesNo!
									
									stMessage.sCode = "WDET566"
									bDejaEuMsg = TRUE
									
									If F_Message ( stMessage ) = 1 Then
										// Oui donc assuré ok pour réparation ou pas ?
											stMessage.sTitre		= "Commandes"
											stMessage.Icon			= Question!
											stMessage.bErreurG	= FALSE
											stMessage.Bouton		= YesNo!
										
											stMessage.sCode = "WDET568"
										
											if F_Message ( stMessage ) = 1 Then
												sRech=""
											Else
												// Refus de réparation par l'assuré, passer une demande de diagnostic
												stMessage.sCode = "WDET569"
												
												F_RechDetPro ( lDeb, lFin, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 239)
												If lDeb > 0 Then
													stMessage.sCode = "WDET630"			
												End If													
												
											End If
											
									Else 
										// Ce cas ne relève pas d’une réparation, passez par une demande de diagnostic.
										stMessage.sCode = "WDET567"	
										
										F_RechDetPro ( lDeb, lFin, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 239)
										If lDeb > 0 Then
											stMessage.sCode = "WDET626"			
										End If										
									End if

								Else
								
									// [PC869]
									If lnv_key[2].iakeyValue <> "AUCUNE" And lnv_key[2].iakeyValue <> "REPA_PSM" Then // [DT173].Mt17057
										// Méthode Standard
										// Question si bris concerne uniquement l'écran ?WDET566
										stMessage.sTitre		= "Commandes"
										stMessage.Icon			= Question!
										stMessage.bErreurG	= FALSE
										stMessage.Bouton		= YesNo!
										
										stMessage.sCode = "WDET566"
										bDejaEuMsg = TRUE
										
										if F_Message ( stMessage ) = 1 Then
											// Oui on passe, 	sRech = ""
											sRech=""
										Else 
											// Ce cas ne relève pas d’une réparation, passez par une demande de diagnostic.
											stMessage.sCode = "WDET567"			
											// [PC938_ORANGE_V3]
											F_RechDetPro ( lDeb, lFin, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 239)
											If lDeb > 0 Then
												stMessage.sCode = "WDET626"			
											End If
										End if
									End if
									
									// [PC869]
									If lnv_key[2].iakeyValue = "AUCUNE" Then
										sRech=""
									End If
									
									// [DT173].Mt17057
									If lnv_key[2].iakeyValue = "REPA_PSM" Then
										sRech=""
									End If
									
								End If
							End if
					End Choose // modèle

					// toujours le modèle mais de façons différente 'demande d'Aurélien)
					// [VDOC7507][VDOC7577]
					Choose Case True
						Case Pos ( sModele, "IPAD" ) > 0
							// [VDoc4564]
							lnv_key[1].iskeyname = "MODELE"
							lnv_key[1].iakeyValue = "IPAD"
							lnv_key[2].iskeyname = "METHODE"							
							f_rechdetpro_withkey(lRow, idwDetPro, lIdProd,"-DP", 200, lnv_key)

							// [PM246][MANTIS10235]
							// [PC151270_ORANGE_V3]
						
							
							// [DT288-1][M25113]
							F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 94 )
							For lCptDetPro = lDeb To lFin
								sVal = nvstring.of_getkeyvalue ( idwDetPro.GetItemString ( lCptDetPro, "VAL_CAR" ), "COD_DW", ";")
								
								Choose Case sVal 
									Case "ORANGE_V3", "ORANGE_V2BIS", "ORANGE_V3BIS", "ORANGE_V3TER"
										// On coupe, vu avec Lisette et ML Gasnier suite mantis 10235 le 17/12/2014
										lRow = 0
										sRech=""
								End Choose 
							Next
							// [PM246][MANTIS10235]									
							
							F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 315 )
							If lDeb > 0 Then
								lRow = 0
								sRech=""
							End If

							// [PC869]						
							If lRow > 0 Then
								
								// [PC980_MANTIS8945]
								If lIdEvt = 1377 Then
									lnv_key[2].iakeyValue = "AUCUNE"
								End If

								//[DT173].Mt17057 suite erreur FPI.
								If lnv_key[2].iakeyValue <> "AUCUNE" Then // [DT173].Mt17057
									// Question si bris concerne uniquement l'écran ?WDET566
									stMessage.sTitre		= "Commandes"
									stMessage.Icon			= Question!
									stMessage.bErreurG	= FALSE
									stMessage.Bouton		= YesNo!
									
									stMessage.sCode = "WDET566"
									bDejaEuMsg = TRUE
									
									if F_Message ( stMessage ) = 1 Then
										// Oui on passe, 	sRech = ""
										sRech=""
									Else 
										// Ce cas ne relève pas d’une réparation, passez par une demande de diagnostic.
										stMessage.sCode = "WDET567"		
										bRefusIpad=TRUE // [PC413-1Lot1]
									End if
								End If								

								// [PC869]
								If lnv_key[2].iakeyValue = "AUCUNE" Then
									sRech=""
								End If
								
							End if							
							
							// [VDOC12693]
							if lRow <=0 Then
								// On autorise la presta de réparation d'IPAD pour les produits Carrefour Casse/Vol
								F_RechDetPro ( lDeb, lFin, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 141)
								If lDeb > 0 Then
									sRech=""
								End if
							End if
							// :[VDOC12693]
							
					End Choose // Modèle
			End Choose // marque
			
	End Choose // action
End If
// Fin #25 [DCMP090109]

//* #32 JFF  03/08/2009 [SCCCG13]
If sRech = "TROUVE" Then
	Choose Case sChoixAction 
		Case "R"
			// [SCCCG13]
			F_RechDetPro ( lDeb, lFin, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 121 )

			// [VDOC15936]
			if lDeb <=0 Then F_RechDetPro ( lDeb, lFin, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 141 )
			
			// [PC474] ajout bCdiscount 
			If lDeb > 0 Or (bCdiscount and not bRefusIpad) Then // [PC413-1Lot1] Ajout de bRefusIpad
				sRech = ""
			End If

	End CHoose 
End If
//* #32 JFF  03/08/2009 [SCCCG13]

// [PC202][LOT2][PC041][LOT2]
If sRech <> "TROUVE" And Not bDejaEuMsg Then
	Choose Case sChoixAction 
		Case "R"

			F_RechDetPro ( lDeb, lFin, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 232 )
			If lDeb > 0 Then
				
				If idwDetPro.Find ( "ID_CODE_CAR = '" + sTypApp + "'", lDeb, lFin ) > 0 Then
				
					stMessage.sTitre		= "Commandes"
					stMessage.Icon			= Question!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= YesNo!
					
					stMessage.sCode = "WDET566"

					// [DT447]
					F_RechDetPro ( lDeb, lFin, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 342 )
					If lDeb > 0 Then

						sVal = nvstring.of_getkeyvalue (idwDetPro.GetItemString ( lDeb, "VAL_CAR" ), "DTE_PIVOT_DT447", ";")
						sVal1 = nvString.of_getkeyvalue (idwDetPro.GetItemString ( lDeb, "VAL_CAR" ), "CAS", ";")			
						sval2 = nvString.of_getkeyvalue (idwDetPro.GetItemString ( lDeb, "VAL_CAR" ), "TYP_APP", ";")			
						If isNull ( sval2 ) Then sval2 = ""
						
						If sVal <> "" And IsDate ( sVal ) Then
							dtDtePivotDT447 = DateTime ( sVal )
			
							// Traitement après MEP DT447
							If dtCreeLeDos >= dtDtePivotDT447 Then
							
								Choose Case sVal1
									Case "80500", "35800"
									
										If Pos ( sVal2, "#" + sTypApp + "#" ) > 0 Then
											sRech=""
											ibBrisEcran = False
										Else
											if F_Message ( stMessage ) = 1 Then
												// Oui on passe, 	sRech = "" (On ira en répar chez PSM)
												sRech=""
												ibBrisEcran = True
											Else 
												// Oui on passe, 	sRech = "" (On ira en répar chez O2M)
												sRech=""
												ibBrisEcran = False
											End if								
										End If 

									Case Else 
										if F_Message ( stMessage ) = 1 Then
											// Oui on passe, 	sRech = ""
											sRech=""
										Else 
											// Ce cas ne relève pas d’une réparation, passez par une demande de diagnostic.
											sRech="TROUVE"
											stMessage.sCode = "WDET567"			
										End if	
										
								End Choose
							// Traitement avant MEP DT447
							Else
								if F_Message ( stMessage ) = 1 Then
									// Oui on passe, 	sRech = ""
									sRech=""
								Else 
									// Ce cas ne relève pas d’une réparation, passez par une demande de diagnostic.
									sRech="TROUVE"
									stMessage.sCode = "WDET567"			
								End if								
							End If

						Else 
							if F_Message ( stMessage ) = 1 Then
								// Oui on passe, 	sRech = ""
								sRech=""
							Else 
								// Ce cas ne relève pas d’une réparation, passez par une demande de diagnostic.
								sRech="TROUVE"
								stMessage.sCode = "WDET567"			
							End if							
						End If 
					Else 
						if F_Message ( stMessage ) = 1 Then
							// Oui on passe, 	sRech = ""
							sRech=""
						Else 
							// Ce cas ne relève pas d’une réparation, passez par une demande de diagnostic.
							sRech="TROUVE"
							stMessage.sCode = "WDET567"			
						End if							
					End If 
				End If		
			End If
	End Choose
End If
// [PC202][LOT2][PC041][LOT2]

// [VDOC18734] Doit rester à cet endroit en dernier avant le message, pour les contrôles suivant, coder au dessus.
If sRech <> "TROUVE" Then
	Choose Case sChoixAction 
		Case "R"

			F_RechDetPro ( lDeb, lFin, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 290 )
			For lCptDetPro = lDeb To lFin
		
				sVal = idwDetPro.GetItemString ( lCptDetPro, "VAL_CAR" ) 
				sVal = nvstring.of_getkeyvalue (sVal, "MODL", ";")								

				bCmdeRempl = False

				idwLstCmdeSin.SetFilter ( &
						"ID_FOUR = 'O2M' AND " + &
						"STATUS_GC <> 176 AND " + &
						"COD_ETAT <> 'ANN' AND " + &
						"( ID_TYP_ART NOT IN ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' ) " + &
						"  OR " + &
						"  ( ID_TYP_ART = 'RST' AND POS ( INFO_SPB_FRN_CPLT, 'RST_CMDE+SUIVI=OUI' ) > 0 ) " + &
						") " ) 
				
				idwLstCmdeSin.Filter ()
				
				bCmdeRempl = idwLstCmdeSin.RowCount () > 0 
				
				idwLstCmdeSin.SetFilter ( "" )
				idwLstCmdeSin.Filter ()
				
				If Pos ( sModele, sVal ) > 0 And Not bCmdeRempl Then
					// [DT200]
					
					sRech="TROUVE"					
					
					sCodTypRecu = Space ( 1 )
					SQLCA.PS_S_W_QUEUE_COD_TYP_RECU ( lIdSin, sCodTypRecu )
					
					If sCodTypRecu = "D" Then
						stMessage.sCode = "WDET646"
					End If 

					If sCodTypRecu <> "D" Then
						stMessage.sCode = "WDET648"
						stMessage.Bouton = YESNO!

						If F_Message ( stMessage ) = 1 Then
							stMessage.sCode = "WDET646"
							stMessage.Bouton = Ok!
						Else
							stMessage.sCode = "WDET649"
							stMessage.Bouton = Ok!								
							F_Message ( stMessage )
							sRech = ""
						End If

					End If 
					
				End If
				
			Next
	End Choose
End If
// [VDOC18734]

If sRech <> "" Then
	stMessage.sTitre		= "Commandes"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	bCmd = False
	F_Message ( stMessage )
	Return 
End If

/*------------------------------------------------------------------*/
/* #3 : Si IMEI de controle non renseignée, on ne commande pas      */
/* Si option 19																	  */
/*------------------------------------------------------------------*/
/* #9 [CRAO_LOT2] Désactivation Option 19 : On report               */
/* reporter ce controle pour l'option 75 et #cra_suivi_imei# <> 2    */
/*------------------------------------------------------------------*/
//F_RechDetPro ( lDeb, lFin, idwDetPro, istPass.dwMaster.GetItemNumber ( 1, "ID_PROD" ), '-DP', 19 )
//IF lDeb > 0 Then
//	sVal = istPass.dwMaster.GetItemString ( 1, "REF_CIE" )
//	If IsNull ( sVal ) Or sVal = "" Then
//		stMessage.sTitre		= "Commandes"
//		stMessage.Icon			= Information!
//		stMessage.bErreurG	= FALSE
//		stMessage.Bouton		= Ok!
//		stMessage.sCode		= "COMD066"
//
//		bCmd = False
//		F_Message ( stMessage )
//		Return 
//	End If
//End If 
// remplacé par :
F_RechDetPro ( lDeb, lFin, idwDetPro, istPass.dwMaster.GetItemNumber ( 1, "ID_PROD" ), '-DP', 75 )
IF lDeb > 0 Then
	lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'CRA_SUIVI_IMEI'", 1, idwWDivSin.RowCount () ) 
	If lRow > 0  then
		sVal = String ( idwWDivSin.GetItemNumber ( lRow, "VAL_NBRE" ) )
	else
		setNull(sVal)
	End If
	
	If IsNull ( sVal ) Or sVal = "" Or sVal <> '2' Then
		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "COMD066"

		bCmd = False
		F_Message ( stMessage )
		Return 
	End If
End If 

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
If	iuoGsSpwDetail.uf_bt_Commander () < 1	Then Return

/*------------------------------------------------------------------*/
/* Cas ou l'on ne peut pas passer une 2ème commande (sauf pour      */
/* AG/RG)  DCMP20103                                                */
/*------------------------------------------------------------------*/
// #11
If bCDiscount  Then 
	sRech = "ID_TYP_ART <> 'EDI' AND ( COD_ETAT IN ( 'RCF', 'ECT', 'CNV', 'CWE' ) OR ( COD_ETAT = 'ECL' AND ID_TYP_ART <> 'PRS' ))"
Else 
	sRech = "( COD_ETAT IN ( 'RCF', 'ECT', 'CNV', 'CWE' ) OR ( COD_ETAT = 'ECL' AND ID_TYP_ART <> 'PRS' ))"	
End If 

// [PC321]
If bSavRDC Then
	sRech = "ID_TYP_ART <> 'EDI' AND ( COD_ETAT IN ( 'RCF', 'ECT', 'CNV', 'CWE' ) OR ( COD_ETAT = 'ECL' AND ID_TYP_ART <> 'PRS' )) AND (INFO_SPB_FRN <> 1425)"
End if
// :[PC321]

bCommander = istPass.dwTab [ 5 ].Find ( sRech, 1, istPass.dwTab [ 5 ].RowCount () ) <= 0

/*------------------------------------------------------------------*/
/* #2 JFF 01/11/2003                                                */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 9 )
dcMtValAchat = dw_1.GetItemDecimal ( 1, "MT_VAL_ACHAT" )  

If IsNull ( lIdEvt ) Then
	stMessage.sTitre		= "Commandes"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "COMD400"

	Choose Case sChoixAction
		Case "C"
			stMessage.sVar [1]	= "de commander"
		Case "R"
			stMessage.sVar [1]	= "de réparer"
		Case "S"
			stMessage.sVar [1]	= "de sélectionner"
		Case "I"
			stMessage.sVar [1]	= "d'informer"
	End Choose 

	bCmd = False
	F_Message ( stMessage )


/*------------------------------------------------------------------*/
/* #2 JFF 01/11/2003                                                */
/*------------------------------------------------------------------*/
ElseIf lDeb > 0 And ( dcMtValAchat <= 0 Or IsNull ( dcMtValAchat ) ) Then
	stMessage.sTitre		= "Commandes"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "COMD061"

	bCmd = False
	F_Message ( stMessage )


/*------------------------------------------------------------------*/
/* Si l'on ne peut pas commander et que l'on est gestionnaire       */
/* alors...                                                         */
/* DCMP20103																		  */
/*------------------------------------------------------------------*/
ElseIf Not bCommander And stGlb.sTypOper < "5" And ( sChoixAction = "C" Or sChoixAction = "R" Or sChoixAction = "I") Then

	// [MSS_LOT2].[20100429165933570] Cas d'exception ou on laisse passé tout de même
	// [VDOC4097] ajout Or sChoixAction = "C" )
	// [PC292]
	// [VDOC9304_PM82_LOT1]

	// [VDOC4970] ajout ( 'PEC_A_RECYCLER', 'REFUS_A_REEXPEDIER' )
	//	[MANTIS6300]	
	// [PC786-1_AUCHAN_GEM][MANTIS11397] (52)
	// [VDOC15485]
	// [VDOC26046] ajout A_RECUP_A_RECYCLER
	// [PM445-1]
	If (&
			( sChoixAction = "I" Or sChoixAction = "C" ) And &
			( istPass.dwTab [ 5 ].Find ( "ID_FOUR IN ( 'MS1', 'BLC') AND COD_ETAT NOT IN ( 'RFO', 'ANN')", 1, istPass.dwTab [ 5 ].RowCount () ) > 0  Or &
			  ( istPass.dwTab [ 5 ].Find ( "ID_FOUR = 'SB1' AND ID_REF_FOUR IN ( 'A_DIAGNOSTIQUER' ) AND COD_ETAT IN ( 'RFO' )", 1, istPass.dwTab [ 5 ].RowCount () ) > 0  And &		
				 istPass.dwTab [ 5 ].Find ( "ID_FOUR = 'O2M' AND ID_REF_FOUR IN ( 'A_DIAGNOSTIQUER' ) AND COD_ETAT IN ( 'ECT' )", 1, istPass.dwTab [ 5 ].RowCount () ) > 0  ) OR &
			  istPass.dwTab [ 5 ].Find ( "ID_TYP_ART = 'PRS' AND STATUS_GC IN ( 153, 154, 235, 236) AND COD_ETAT NOT IN ( 'ANN' )", 1, istPass.dwTab [ 5 ].RowCount () ) > 0 OR &
			  istPass.dwTab [ 5 ].Find ( "ID_REF_FOUR IN ( 'PEC_A_RECYCLER', 'REFUS_A_REEXPEDIER', 'A_RECUP_A_RECYCLER' ) AND COD_ETAT IN ( 'CNV' )", 1, istPass.dwTab [ 5 ].RowCount () ) > 0 OR &
			  istPass.dwTab [ 5 ].Find ( "ID_TYP_ART = 'PST' AND STATUS_GC IN ( 234, 235, 236) AND COD_ETAT NOT IN ( 'ANN' )", 1, istPass.dwTab [ 5 ].RowCount () ) > 0 OR ( &
			  lIdEvt = 1398 And istPass.dwTab [ 5 ].Find ( "ID_FOUR = 'O2M' AND ID_TYP_ART NOT IN ( 'PST', 'EDI', 'PRS', 'RES', 'RST' ) AND STATUS_GC IN ( 262, 233 ) AND COD_ETAT NOT IN ( 'ANN' )", 1, istPass.dwTab [ 5 ].RowCount () ) > 0 ) OR ( &
			  lIdEvt = 1410 And istPass.dwTab [ 5 ].Find ( "ID_FOUR = 'O2M' AND ID_REF_FOUR IN ( 'A_DIAGNOSTIQUER' ) AND COD_ETAT NOT IN ( 'ANN' )", 1, istPass.dwTab [ 5 ].RowCount () ) > 0 ) OR &
			  lIdEvt = 1439 And istPass.dwTab [ 5 ].Find ( "ID_FOUR = 'O2M' AND POS ( INFO_FRN_SPB_CPLT, 'PERTE_ALLER=OUI' ) > 0 AND COD_ETAT NOT IN ( 'ANN' )", 1, istPass.dwTab [ 5 ].RowCount () ) > 0 &
			) &			 
		) OR &
		( ( sChoixAction = "R" ) AND &
			  istPass.dwTab [ 5 ].Find ( "ID_TYP_ART = 'PRS' AND STATUS_GC IN ( 235, 236, 232) AND COD_ETAT NOT IN ( 'ANN' )", 1, istPass.dwTab [ 5 ].RowCount () ) > 0 &
 	   ) &
		Or	( sChoixAction = "C" And Left ( sLibEvt, 5 ) = "REMPL" AND &
	  		  idwLstCmdeSin.Find ( "ID_GTI = " + String ( lIdGti ) + " AND ID_DETAIL = " + String ( lIdDetail ) + " AND ID_FOUR = 'WBA' AND COD_ETAT = 'CWE'", 1, idwLstCmdeSin.RowCount ()) > 0 &
  	   ) &
		Or	( sChoixAction = "C" And Left ( sLibEvt, 5 ) = "REMPL" AND lIdGti = 52 ) &
		Or	( sChoixAction = "C" And Left ( sLibEvt, 5 ) = "REMPL" AND &
	  		  idwLstCmdeSin.Find ( "ID_FOUR = 'O2M' AND POS ( INFO_FRN_SPB_CPLT, 'PERTE_ALLER=OUI' ) > 0 AND COD_ETAT NOT IN ( 'ANN' )", 1, idwLstCmdeSin.RowCount () ) > 0 ) &
		Then
		// Dans ce cas, on ne bloque pas, on laisse passer.
	Else
		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "COMD035"
	
		bCmd = False
		F_Message ( stMessage )
	End If
	// :[MSS_LOT2].[20100429165933570] 

End If 

/*------------------------------------------------------------------*/
/* Gestion Très particulière DARTY NOMADE                           */
/*------------------------------------------------------------------*/
/* le 10/03/2006 JFF : Je courcircuite cet init. à cet endroit, cause d'un bug gênant.
   L'init. se fait un fois pour toute sur u_gs_sp_sinitre::uf_preparer_modifier
*/
// gsCasGestionDartyNomade = ""

F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 31 )
// [PC151522]
If lDeb > 0 Then
	If nvstring.of_getkeyvalue (idwDetPro.GetItemString ( lDeb, "VAL_CAR"), "OPT_31_ASSOUPLIE", ";") = "OUI" Then
		lDeb = 0
	End If
End If

If lDeb > 0 Then 

	If sChoixAction = "S" Then
		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "COMD170"

		bCmd = False
		F_Message ( stMessage )
	End If

	If dw_1.GetItemNumber ( 1, "ID_EVT" ) = 965 Then
		stMessage.sTitre		= "Commandes"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "COMD360"

		bCmd = False
		F_Message ( stMessage )
	End If


	If bCmd then 

		// #31 [O2M_DIAG_NOMADE].[JFF].[20091022224855853]
		sCasGestion = iuoGsSpwDetail.uf_Gestion_DartyNomade ( dw_1.GetItemDecimal ( 1, "MT_VAL_ACHAT" ), "" )
		gsCasGestion = sCasGestion
		F_RechDetPro ( lDeb, lFin, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 167 )
		F_RechDetPro ( lDeb2, lFin2, idwDetPro, idwProduit.GetItemNumber ( 1, "ID_PROD" ), '-DP', 31 )

		// [PC430][V10]
		// [PC547] Ajout produit 30800 à 30803
		// [ITSM105388]
		bDartyIPAD = lDeb > 0 Or ( lDeb2 > 0 And sTypApp = "TPC"  And Pos ( sModele, "IPAD", 1 ) >0 )

		Choose Case sCasGestion 
			Case "11/NPCP/>300/PRS_DST_EC"
				bCmd = False

			Case "11/PCP/PRS_DTY", "11/NPCP/>300/PRS_DST"

				If sChoixAction = "C" Then
					stMessage.sTitre		= "Commandes"
					stMessage.Icon			= Exclamation!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= Ok!
					stMessage.sCode		= "COMD180"

					bCmd = False
					F_Message ( stMessage )
				End If

				Choose Case sCasGestion 
					Case "11/NPCP/>300/PRS_DST"
						If lIdEvt <> 964 Then
							stMessage.sTitre		= "Commandes"
							stMessage.Icon			= Exclamation!
							stMessage.bErreurG	= FALSE
							stMessage.Bouton		= Ok!
							stMessage.sCode		= "COMD230"
							bCmd = False
							F_Message ( stMessage )
						End If

					Case "11/PCP/PRS_DTY" 
						If lIdEvt <> 963 Then
							stMessage.sTitre		= "Commandes"
							stMessage.Icon			= Exclamation!
							stMessage.bErreurG	= FALSE
							stMessage.Bouton		= Ok!
							stMessage.sCode		= "COMD220"
							bCmd = False
							F_Message ( stMessage )
						End If

				End Choose 


//#16 AJout de cas
			Case "11/PCP/CMD_DTY","11/NPCP/<=300/CMD_DTY", "10/PCP/CMD_DTY", &
				  "10/NPCP/CMD_DTY", "11/NPCP/>300/PRS_DST_ANN/CMD_DTY",&
				  "11/NPCP/PROPO/<=300/CMD_DTY", "11/NPCP/PROPO/>300/DST_ANN/CMD_DTY",&
				  "10/NPCP/PROPO/CMD_DTY"

				// [PC430][V10]
				If sChoixAction = "R" And Not bDartyIPAD Then 
					stMessage.sTitre		= "Commandes"
					stMessage.Icon			= Exclamation!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= Ok!
					stMessage.sCode		= "COMD190"

					bCmd = False
					F_Message ( stMessage )
				End If

				Choose Case sCasGestion 

//#16 AJout de cas
					Case "11/NPCP/>300/PRS_DST_ANN/CMD_DTY"
						If lIdEvt <> 962 Then
							stMessage.sTitre		= "Commandes"
							stMessage.Icon			= Exclamation!
							stMessage.bErreurG	= FALSE
							stMessage.Bouton		= Ok!
							stMessage.sCode		= "COMD270"
							bCmd = False
							F_Message ( stMessage )
						End If

//#16 AJout de cas
					Case "11/NPCP/<=300/CMD_DTY", "10/NPCP/CMD_DTY"
						// [PC430][V10]
						If lIdEvt <> 962 And Not bDartyIPAD Then
							stMessage.sTitre		= "Commandes"
							stMessage.Icon			= Exclamation!
							stMessage.bErreurG	= FALSE
							stMessage.Bouton		= Ok!
							stMessage.sCode		= "COMD210"
							bCmd = False
							F_Message ( stMessage )
						End If

					Case "10/PCP/CMD_DTY", "11/PCP/CMD_DTY", "10/NPCP/PROPO/CMD_DTY", &
						  "11/NPCP/PROPO/>300/DST_ANN/CMD_DTY", "11/NPCP/PROPO/<=300/CMD_DTY"	// #10 #16
						
						// [PC430][V10]
						If lIdEvt <> 1087 And Not bDartyIPAD Then  // #16
							stMessage.sTitre		= "Commandes"
							stMessage.Icon			= Exclamation!
							stMessage.bErreurG	= FALSE
							stMessage.Bouton		= Ok!
							stMessage.sCode		= "COMD200"
							bCmd = False
							F_Message ( stMessage )
						End If

				End Choose 
			// #31 JFF [O2M_DIAG_NOMADE].[JFF].[20090831160025717]
			Case "11/NPCP/DIAG_O2M", "11/PCP/DIAG_O2M"
				If sChoixAction <> "I" And &
					iuoGsSpwDetail.uf_GestOng_Divers_Trouver ( "ALT_PEC" ) <> "O" Then 
					
						stMessage.sTitre		= "Commandes"
						stMessage.Icon			= Exclamation!
						stMessage.bErreurG	= FALSE
						stMessage.Bouton		= Ok!
						stMessage.sCode		= "COMD191"
	
						bCmd = False
						F_Message ( stMessage )

				// #31 [O2M_DIAG_NOMADE].[JFF].[20091022224855853]
				ElseIf sChoixAction <> "I" And &
					iuoGsSpwDetail.uf_GestOng_Divers_Trouver ( "ALT_PEC" ) = "O" Then 

					sCasGestion = iuoGsSpwDetail.uf_Gestion_DartyNomade ( dw_1.GetItemDecimal ( 1, "MT_VAL_ACHAT" ), sChoixAction )
					gsCasGestion = sCasGestion

				End If
				// :#31 [O2M_DIAG_NOMADE].[JFF].[20091022224855853]				

				If lIdEvt <> 1083 And iuoGsSpwDetail.uf_GestOng_Divers_Trouver ( "ALT_PEC" ) <> "O" Then  
					stMessage.sTitre		= "Commandes"
					stMessage.Icon			= Exclamation!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= Ok!
					stMessage.sCode		= "COMD192"
					bCmd = False
					F_Message ( stMessage )
				End If
			// #31 JFF [O2M_DIAG_NOMADE].[JFF].[20090831160025717]					

			Case Else
				
		End Choose

	End If
End If

// #8 Gestion Media Saturn
F_RechDetPro ( lDeb, lFin, idwDetPro, idwWSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 71 )
If lDeb > 0 and bCmd Then 
	sCasGestion = iuoGsSpwDetail.uf_Gestion_MediaSaturn (  )
	gsCasGestion = sCasGestion
End If

// [PC938_ORANGE_V3]
lRow2 = 0
lRow2 = idwLstCmdeSin.Find ( "ID_FOUR = 'PSM' AND ID_TYP_ART = 'PRS' AND STATUS_GC IN ( 235, 236 ) AND COD_ETAT <> 'ANN'", 1, idwLstCmdeSin.RowCount ()) 

// [VDOC10659]
If lRow2 <=0 And Left ( sLibEvt, 5 ) = "REMPL" Then
	lRow2 = idwLstCmdeSin.Find ( "ID_GTI = " + String ( lIdGti ) + " AND ID_DETAIL = " + String ( lIdDetail ) + " AND ID_FOUR = 'WBA' AND COD_ETAT = 'CWE'", 1, idwLstCmdeSin.RowCount ()) 		
End If

If dw_Info_Cmde.GetItemNumber ( 1, "NBRE_DET" ) > 0 And sChoixAction <> "I" AND lRow2 <= 0 Then
	stMessage.sTitre		= "Commandes"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "COMD040"

	bCmd = False
	F_Message ( stMessage )
	
End If

//* #20 [DCMP080204]
// [PM395-1] TPC
If bCmd And ( sTypApp = "TEL" OR ( sTypApp = "TPC" ))  AND Not iuoGsSpwDetail.uf_GestOng_Divers_Trouver ("ALT_PEC" ) = "O" Then
	// On cherche les prestas Réglées non irréparables dont l'envoi au client date de plus de 3 mois.
	// Si la PEC n'est pas Forcée.

	// [PM395-1]
	SQLCA.PS_S01_POLICE ( dcIdProd, dcIdRev, dcIdGti, dcIdCie )

	lRow2=idwLstCmdeSin.Find ( &
		"ID_FOUR IN ( 'O2M' ) AND " + &
		"COD_ETAT <> 'ANN' AND " + &
		"( " + &
		"  ( STATUS_GC <> 176 AND " + &
		"    ID_TYP_ART NOT IN ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' ) " + &
		"    OR " + &
		"    ( ID_TYP_ART = 'RST' AND POS ( INFO_SPB_FRN_CPLT, 'RST_CMDE+SUIVI=OUI' ) > 0 ) " + &
		"  ) " + &
		"  OR " + &
		"  (  " + &
		"    ID_REF_FOUR = 'A_REPARER' AND STATUS_GC = 2" + &
		"  )  " + &
		")    " &
		, 1, idwLstCmdeSin.RowCount () )
	
	If lRow2 >= 0 And dcIdCie = 135 Then
		bDelaiSavLaParisienne = TRUE
	End If	

	// [PM222-1]
	lMoisApple =0
	lMoisHApple1 = 0
	lMoisHApple2 = 0

	//* #27 [DCMP090243]
	Choose Case sMarque 

		Case "APPLE"

			// [PM222-1]
			lMoisApple = 12 // Variable en mois à modifier si besoin, durée de la gti de la réparation par le CTR
			lMois = 12 // Variable en mois à modifier si besoin, durée de la gti de la réparation par le CTR
			
			// [PM395-1]
			If bDelaiSavLaParisienne Then
				lMoisApple = 3 
				lMois = 3 
			End If					
			
			sMessDurGti = "COMD527"
			
			// [PM280-2]
			Choose Case lIdEvt 
				Case 1422, 1426 
					sMessDurGti = "COMD945"
			End Choose 

		Case Else	

			lMoisHApple1 = 3  // Variable en mois à modifier si besoin, durée de la gti de la réparation par le CTR
			lMoisHApple2 = 12  // Variable en mois à modifier si besoin, durée de la gti de la réparation par le CTR				
			lMois = 12  // Variable en mois à modifier si besoin, durée de la gti de la réparation par le CTR
			
			// [PM395-1]
			If bDelaiSavLaParisienne Then
				lMoisHApple1 = 3 
				lMoisHApple2 = 3 
				lMois = 3  
			End If					
		
			sMessDurGti = "COMD473"
			
	End Choose
	//* :#27 [DCMP090243]

	// [PM280-1][ITSM304152]
	If bARepGti Then
		idwLstCmdeSin.SetFilter ( &
				"ID_FOUR = 'O2M' AND " + &
				"COD_ETAT <> 'ANN' AND " + &
				"STATUS_GC <> 176 AND " + &
				"( ID_TYP_ART NOT IN ( 'DEV', 'AEF', 'CAS', 'SMS', 'BAM', 'ALE', 'ACC', 'PCM', 'MAI', 'REL', 'PST', 'RES', 'REA', 'PRS', 'EDI', 'RST' ) " + &
				"  OR " + &
				"  ( ID_TYP_ART = 'RST' AND POS ( INFO_SPB_FRN_CPLT, 'RST_CMDE+SUIVI=OUI' ) > 0 ) " + &
				") " ) 

		idwLstCmdeSin.Filter ()
		idwLstCmdeSin.Sort ()
		
		lMoisHApple1 = 12
		lMois = 12
		
		// [PM395-1]
		If bDelaiSavLaParisienne Then
			lMoisHApple1 = 3
			lMois = 3
		End If					
		
	End If		

	lTotCmd = idwLstCmdeSin.RowCount ()

	// Clé permanente à ne pas supprimer	
	If F_CLE_A_TRUE ( "SHUNT_CTRLE_PRS3MOIS" ) Then
		Choose Case stGlb.sCodOper
			Case "JFF", "FPI"
				lTotCmd = 0
		End Choose
	End If
	
	bPRSTropVieille = False 

	// [PM222-1] V4 modif date du 01/01/2015 en 01/11/2014
	For lCptCmd = 1 To lTotCmd 
		
		dtEnvcli = Date ( idwLstCmdeSin.GetItemDateTime ( lCptCmd, "DTE_ENV_CLI") )
		
		// [PM280-1][ITSM304152]
		// [PM395-1] on coupe le dtEnvcli < 2014-11-01
		If ( Upper ( idwLstCmdeSin.GetItemString ( lCptCmd, "ID_TYP_ART" ) ) = "PRS" OR &
			  ( Upper ( idwLstCmdeSin.GetItemString ( lCptCmd, "ID_TYP_ART" ) ) = sTypApp And bARepGti ) &
			) &
			And &
			( Upper ( idwLstCmdeSin.GetItemString ( lCptCmd, "COD_ETAT" ) ) = "RPC" OR &
			  Upper ( idwLstCmdeSin.GetItemString ( lCptCmd, "COD_ETAT" ) ) = "RFO" &
			) &
			And &
			( &
				( lMoisApple > 0 And F_PLUS_DATE ( dJour, lMoisApple * (-1), "M" ) > dtEnvcli ) &
				Or &
				( lMoisApple <= 0 And dtEnvcli >= 2014-11-01 &
				  And F_PLUS_DATE ( dJour, lMoisHApple2 * (-1), "M" ) > dtEnvcli ) &
			)&
			Then

			bCmd = False
			stMessage.sTitre		= "Commandes"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!
			stMessage.sVar[1]    = String ( lMois ) + " mois"
			stMessage.sCode		= sMessDurGti
			
			bPRSTropVieille = TRUE

			Exit
		End IF			
	Next

	// [PM222-1]
	// [PM222-1] V4 modif date du 01/01/2015 en 01/11/2014
	// [PM395-1] on coupe le dtEnvcli < 2014-11-01
	If bPRSTropVieille Then
		For lCptCmd = 1 To lTotCmd 

			dtEnvcli = Date ( idwLstCmdeSin.GetItemDateTime ( lCptCmd, "DTE_ENV_CLI") )

			// [PM395-1] on coupe le dtEnvcli < 2014-11-01			
			If Upper ( idwLstCmdeSin.GetItemString ( lCptCmd, "ID_TYP_ART" ) ) = "PRS" And &
				( Upper ( idwLstCmdeSin.GetItemString ( lCptCmd, "COD_ETAT" ) ) = "RPC" OR &
					( Upper ( idwLstCmdeSin.GetItemString ( lCptCmd, "COD_ETAT" ) ) = "RFO" )&
				) And &
				( nvstring.of_getkeyvalue (idwLstCmdeSin.GetItemString ( lCptCmd, "INFO_SPB_FRN_CPLT" ), "A_REPARER_SAV", ";") = "OUI" OR &
				  nvstring.of_getkeyvalue (idwLstCmdeSin.GetItemString ( lCptCmd, "INFO_SPB_FRN_CPLT" ), "A_DESOXYDER_SAV", ";") = "OUI" ) And &
				idwLstCmdeSin.GetItemNumber ( lCptCmd, "STATUS_GC" ) = 2 &
				And &
				( &
					( lMoisApple > 0 And F_PLUS_DATE ( dJour, lMoisApple * (-1), "M" ) > dtEnvcli ) &
					Or &
					( lMoisApple <= 0 And dtEnvcli >= 2014-11-01 &
					  And F_PLUS_DATE ( dJour, lMoisHApple2 * (-1), "M" ) > dtEnvcli ) &
				)&
				Then					

				// [ITSM294822]
				// [PM395-1] on coupe le dtEnvcli < 2014-11-01
				If lMoisApple > 0 Then
					lMois = lMoisApple
				Else
					lMois = lMoisHApple2
				End If
				
				bCmd = False
				stMessage.sTitre		= "Commandes"
				stMessage.Icon			= Exclamation!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= Ok!
				stMessage.sVar[1]    = String ( lMois ) + " mois"
				stMessage.sVar[2]    = stMessage.sVar[1]
				stMessage.sCode		= "COMD826"
				
				bPRSTropVieille = FALSE
//					F_Message ( stMessage )
				bPRSSAVTropVieille = TRUE
				
				Exit
			End IF			
		Next		
		
		lRow4 = idwLstCmdeSin.find ( "( POS ( INFO_SPB_FRN_CPLT, 'A_REPARER_SAV=OUI') > 0 OR POS ( INFO_SPB_FRN_CPLT, 'A_DESOXYDER_SAV=OUI') > 0 ) AND COD_ETAT IN ( 'RPC', 'RFO') AND STATUS_GC IN ( 2,22 )", 1, idwLstCmdeSin.rowcount() )

		// [ITSM576546]
		IF lIdEvt = 1426 And sChoixAction = "I" And &
			idwLstCmdeSin.Find ( "ID_REF_FOUR = 'CONTEST_SUR_REMPL' AND ID_GTI = " + String ( lIdGti ) + " AND ID_DETAIL = " + String ( lIdDEtail) + " AND STATUS_GC IN ( 151, 152 )", 1, idwLstCmdeSin.RowCount ()) > 0 Then
			bPRSSAVTropVieille = FALSE
			bPRSTropVieille = FALSE
			bCmd = True
		End If 
		
		IF bPRSTropVieille And lRow4 <=0 Then
			F_Message ( stMessage )
		End If
		
		IF bPRSTropVieille And lRow4 > 0 And Not bPRSSAVTropVieille Then
			bCmd = True
		End If

		// [PM222-1] V4 modif date du 01/01/2015 en 01/11/2014	
		// [PM395-1] on coupe le dtEnvcli < 2014-11-01
		If bPRSSAVTropVieille Then
			For lCptCmd = 1 To lTotCmd 
				If Upper ( idwLstCmdeSin.GetItemString ( lCptCmd, "ID_TYP_ART" ) ) = "PRS" And &
					( Upper ( idwLstCmdeSin.GetItemString ( lCptCmd, "COD_ETAT" ) ) = "RPC" OR &
						( Upper ( idwLstCmdeSin.GetItemString ( lCptCmd, "COD_ETAT" ) ) = "RFO" )&
					) And &
					nvstring.of_getkeyvalue (idwLstCmdeSin.GetItemString ( lCptCmd, "INFO_SPB_FRN_CPLT" ), "A_CONTROLER_SAV", ";") = "OUI" And &
					idwLstCmdeSin.GetItemNumber ( lCptCmd, "STATUS_GC" ) = 2 &
					And &
					( &
						( lMoisApple > 0 And F_PLUS_DATE ( dJour, lMoisApple * (-1), "M" ) > dtEnvcli ) &
						Or &
						( lMoisApple <= 0 And dtEnvcli >= 2014-11-01 &
						  And F_PLUS_DATE ( dJour, lMoisHApple2 * (-1), "M" ) > dtEnvcli ) &
					)&
					Then
		
					// [ITSM294822]
					// [PM395-1] on coupe le dtEnvcli < 2014-11-01
					If lMoisApple > 0 Then
						lMois = lMoisApple
					Else
						lMois = lMoisHApple2
					End If
		
					bCmd = False
					stMessage.sTitre		= "Commandes"
					stMessage.Icon			= Exclamation!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= Ok!
					stMessage.sVar[1]    = String ( lMois ) + " mois"
					stMessage.sVar[2]    = stMessage.sVar[1]
					stMessage.sVar[3]    = stMessage.sVar[1]						
					stMessage.sCode		= "COMD827"
					
					bPRSTropVieille = FALSE
					bPRSSAVTropVieille = False
					F_Message ( stMessage )

					
					Exit
				End IF			
			Next					
		End IF
		
		IF bPRSSAVTropVieille Then
			F_Message ( stMessage )
		End If
	End If 
	
	
End If
//* :#20 [DCMP080204]

// [PM280-1][ITSM304152]
idwLstCmdeSin.SetFilter ( "" )
idwLstCmdeSin.Filter ()
idwLstCmdeSin.Sort ()

//* #21 [DCMP080426]
// [DT288][M24507] suppression de ce contrôle pour tout fournisseur, vu avec Smaïn et Hélène le 03/04/2017
/*
If bCmd And sTypApp = "TEL" AND Not iuoGsSpwDetail.uf_GestOng_Divers_Trouver ("ALT_PEC" ) = "O" Then
	// On interdit les nouvelles PRS si AMU PRS précédente à un comment [BNV]
	// ET Si la PEC n'est pas Forcée.

	sCle = "[BNV]" // clé à trouver
	
	lTotCmd = idwLstCmdeSin.RowCount ()
	For lCptCmd = 1 To lTotCmd 
		If Upper ( idwLstCmdeSin.GetItemString ( lCptCmd, "ID_TYP_ART" ) ) = "PRS" And &
			Pos ( Upper ( idwLstCmdeSin.GetItemString ( lCptCmd, "COMMENT_FRN" )) , sCle, 1 ) > 0 Then

			bCmd = False
			stMessage.sTitre		= "Commandes"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!
			stMessage.sCode		= "COMD474"
		
			bCmd = False
			F_Message ( stMessage )
			Exit
		End IF			
	Next
End If
*/
//* :#21 [DCMP080426]

// #35 [DCMP090760]
If bCmd And sTypApp = "TEL" AND Not iuoGsSpwDetail.uf_GestOng_Divers_Trouver ("ALT_PEC" ) = "O" Then

	// [PM82][LOT1]
	// [MANTIS3276]
/* // [MANTIS3276] je shunte définitvement cette partie, elle n'a plus de à présent avec la vDoc7285 en aval.
	sRech =  "ID_FOUR = 'O2M' AND ID_TYP_ART = 'PRS' AND POS ( ID_MODL_ART, 'IPHONE', 1 ) > 0 "
	sRech += "AND COD_ETAT NOT IN ( 'ANN' ) AND STATUS_GC NOT IN ( 153, 154 )"
	
	If idwLstCmdeSin.Find ( sRech, 1,idwLstCmdeSin.RowCount())  > 0 and sChoixAction = "I" Then
			bCmd = False
			stMessage.sTitre		= "Commandes"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!
			stMessage.sCode		= "COMD587" 
		
			F_Message ( stMessage )
	End if
*/	
End if
// Fin #35

If bCmd Then
	isDetailActif = "dw_w_commande"
	TriggerEvent ("ue_creer" )
End If
end event

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_W_Detail::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF  27/08/2007 DCMP 070431
//*     JFF  26/06/2012 [CONFO][NV_PROCESS]
//*-----------------------------------------------------------------

s_Pass	stPass_Dga
DataWindow	dwNorm[]

//Migration PB8-WYNIWYG-03/2006 CP
//DataWindow	dwPassageEuro[1]
DataWindow	dwPassageEuro[]
//Fin Migration PB8-WYNIWYG-03/2006 CP

u_DataWindow_Detail	dwUDwDet []

Wf_PositionnerObjets ()

/*------------------------------------------------------------------*/
/* Nous sommes en saisie (S) ou en Consultation/Validation (C)(V)   */
/*------------------------------------------------------------------*/
isTypeTrt = istPass.sTab[ 2 ]

/*------------------------------------------------------------------*/
/* On commence à initialiser les NVUO.                              */
/*------------------------------------------------------------------*/
iuoGsSpwDetail = Create U_Gs_Sp_Sinistre_wDetail

idwDetPro  			= istPass.dwNorm [ 22 ]
idwProduit 			= istPass.dwNorm [  1 ]
idwStkIfr   		= istPass.dwNorm [ 25 ] // Dw des Données IFR
idwCodEquiv 		= istPass.dwNorm [ 26 ] // Dw des Libellés IFR Traduits
idwFourn				= istPass.dwNorm [ 15 ]  // Dw choix des fournisseurs
idwAutorisation 	= istPass.dwNorm [ 27 ]  // Table des autorisations
idwStkCodicDarty 	= istPass.dwNorm [ 28 ]   // Table données CODIC DARTY
idwDivPDet 			= istPass.dwNorm [ 30 ] // DataWindow Stockage Données param onglet divers details
idwPieceGti 			= istPass.dwNorm [ 33 ] // DataWindow Piece de la garantie - [VDoc4274]

idwWSin	   		= istPass.dwMaster	
idwWDivSin  		= istPass.udwTab [  1 ]  // Dw_w_Div_Sin
idwDivDetGti 		= istPass.udwTab [  2 ]    // DataWindow Stockage Données onglet divers details

idwLstCmdeSin		= istPass.dwTab[5] // #1
idwLstDetail		= istPass.dwTab[1]

/*------------------------------------------------------------------*/
/* On arme les DW dans le bon ordre. (SVP)                          */
/*------------------------------------------------------------------*/
dwNorm[ 1] = istPass.dwNorm [  2 ]		// CODE_GARANTIE
dwNorm[ 2] = istPass.dwNorm [  3 ]		// CODE_CONDITION
dwNorm[ 3] = istPass.dwNorm [  4 ]		// PIECE
dwNorm[ 4] = istPass.dwNorm [  5 ]		// MOTIF
dwNorm[ 5] = istPass.dwNorm [  6 ]		// FRANCHISE
dwNorm[ 6] = istPass.dwNorm [  7 ]		// PLAFOND
dwNorm[ 7] = istPass.dwNorm [  8 ]		// DELAI
dwNorm[ 8] = istPass.dwNorm [  9 ]		// GARANTIE
dwNorm[ 9] = istPass.dwNorm [ 10 ]		// CONDITION
dwNorm[10] = istPass.dwNorm [ 11 ]		// W_PIECE_DETAIL
dwNorm[11] = istPass.dwNorm [ 12 ]		// W_REFUS_DETAIL
dwNorm[12] = istPass.dwNorm [ 13 ]		// W_PPLAFOND_DETAIL
dwNorm[13] = dw_wPlaf_Detail
dwNorm[14] = istPass.dwNorm [ 14 ]		// DataWindow External W_DETAIL_SUPP
dwNorm[15] = dw_Info_Cmde
dwNorm[16] = dw_Choix_Action
dwNorm[17] = idwStkIfr   
dwNorm[18] = idwCodEquiv 
dwNorm[19] = idwStkCodicDarty
dwNorm[20] = idwAutorisation
dwNorm[21] = idwDivPDet 			
dwNorm[22] = istPass.dwNorm [ 31 ] // Chargement tempo des codes pour W_Div_Det
dwNorm[23] = istPass.dwNorm [ 32 ] // Chargement tempo des codes pour W_Div_Det
dwNorm[24] = istPass.dwNorm [ 34 ] // [CONFO][NV_PROCESS] dw detail de plus haut niveau

/*------------------------------------------------------------------*/
/* Les u_Datawindow_Detail locals.											  */
/*------------------------------------------------------------------*/
dwUDwDet [1] = dw_w_commande

/*------------------------------------------------------------------*/
/* Ces fonctions sont issues du NVUO ancêtre.                       */
/*------------------------------------------------------------------*/
iuoGsSpwDetail.Uf_Initialisation ( istPass.dwMaster, itrTrans, Uo_Ong, isTypeTrt )
iuoGsSpwDetail.Uf_Initialiser_Dw ( idwProduit, idwDetPro , False )

/*------------------------------------------------------------------*/
/* istPass.dwTab[1] = u_DataWindow_Detail -> Lst des détails        */
/* istPass.dwTab[2] = u_DataWindow_Detail -> Lst des garanties      */
/* istPass.dwTab[3] = u_DataWindow_Detail -> Lst des interlocuteurs */
/* istPass.dwTab[4] = u_DataWindow_Detail -> Lst des Commandes	(Gti)*/
/*	istPass.dwTab[5] = u_DataWindow_Detail -> Lst des Commandes	(Sin)*/
/* istPass.dwMaster1 = u_DataWindow      -> Garantie en cours       */
/*------------------------------------------------------------------*/
iuoGsSpwDetail.Uf_Initialiser_Dw_Desc &
	( istPass.dwTab[2]	,&
	  istPass.dwTab[3]	,&
	  istPass.dwTab[1]   ,&
	  istPass.dwTab[4]   ,&
	  istPass.dwTab[5]   ,&
	  idwWDivSin  			,&
     idwDivDetGti			,&
	  dw_w_div_det			,&
	  dw_1					,&
	  istPass.dwMaster1  ,&
	  dwNorm[]				,&
	  dwUDwDet []  )

/*------------------------------------------------------------------*/
/* On initialise l'objet de marquage des pièces et des refus.       */
/*------------------------------------------------------------------*/
/* Le 28/11/2001.                                                   */
/* Modif DGA. DCMP 010375                                           */
/*------------------------------------------------------------------*/
iuoGsSpwDetail.Uf_Initialiser_Objets ( Uo_Piece, Uo_Refus, Cb_Tarif, Cb_Commander, cb_valachdef, st_Pec, st_labpec )

/*------------------------------------------------------------------*/
/* Initialisation de l'onglet.                                      */
/*------------------------------------------------------------------*/
Uo_Ong.Uf_Initialiser ( 4, 1 )
Uo_Ong.Uf_EnregistrerOnglet ( "01", "Détail", 			"", dw_1,			True )
Uo_Ong.Uf_EnregistrerOnglet ( "02", "Pièces", 			"", Uo_Piece,			False )
Uo_Ong.Uf_EnregistrerOnglet ( "03", "Refus",				"", Uo_Refus,			False )
Uo_Ong.Uf_EnregistrerOnglet ( "04", "Divers",			"", dw_w_div_det,	False )

/*------------------------------------------------------------------*/
/* Si on est en Consultation/Validation (C)(V), on bouge la         */
/* cosmétique de la fenêtre.                                        */
/*------------------------------------------------------------------*/
If	isTypeTrt <> "S"	Then
	Wf_Tb_Consultation ()
End If

iuoGsSpwDetail.Uf_Traitement ( 1, stPass_Dga )

/*------------------------------------------------------------------*/
/* Gestion du Passage à l'EURO.                                     */
/*------------------------------------------------------------------*/
N_Cst_Passage_Euro	nvPassageEuro

dwPassageEuro[ 1 ] = dw_1
dwPassageEuro[ 2 ] = dw_w_div_det

nvPassageEuro = CREATE N_Cst_Passage_Euro
nvPassageEuro.uf_Initialiser ( dwPassageEuro[] )

//Migration PB8-WYNIWYG-03/2006 FM
//DESTROY nvPassageEuro
If IsValid(nvPassageEuro) Then DESTROY nvPassageEuro
//Fin Migration PB8-WYNIWYG-03/2006 FM


end event

event show;call super::show;//*-----------------------------------------------------------------
//*
//* Objet         : w_td_sp_w_detail
//* Evenement     : Show
//* Auteur        : Fabry JF
//* Date          : 12/05/2005 16:29:10
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

PostEvent ( "ue_Affichage" )
PostEvent ( "ue_TailleFenetre" )
end event

event ue_creer;call super::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_W_Detail::Ue_Creer
//* Evenement 		: Ue_Creer
//* Auteur			: Fabry JF
//* Date				: 13/09/1998 16:37:38
//* Libellé			: 
//* Commentaires	: Ouverture des Fenêtres de détail.
//*				     (On est en modification d'un détail)
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  CAG	 25/02/2003 Ajout de dw sur Det_Pro
//* #2  JFF  04/06/2007 [DCMP070163-070164-070248-070318] Gestion Prise en charge
//* #3  JFF  13/02/2008 [FNAC_PROD_ECH_TECH].[20090224144248310]
//      JFF  06/08/2012 [BLCODE]
//      JFF  17/09/2019 [DT447]
//*-----------------------------------------------------------------

s_Pass stPass

stPass = istPass

/*------------------------------------------------------------------*/
/* Si la fenêtre de consultation des paragraphes est visible, on    */
/* la rend invisible.                                               */
/*------------------------------------------------------------------*/
Wf_Fermer_Consulter_Paragraphe ()

Choose Case isDetailActif
	Case "dw_w_commande"

		SetPointer ( HourGlass! )

		stPass.bInsert		= True
		stPass.bControl	= True

		stPass.sTab [ 1 ]	= This.Title
		stPass.sTab [ 2 ]	= isTypeTrt
		stPass.sTab [ 3 ]	= Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()
		stPass.sTab [ 4 ]	= istPass.sTab [ 4 ]  // n° IMEI provenant de l'adhésion (a pu être modifié depuis l'ouverture du sinistre)
		stPass.sTab [ 5 ]	= istPass.sTab [ 5 ]  // Marque portable adhésion.
		stPass.sTab [ 6 ]	= istPass.sTab [ 6 ]  // Modèle portable adhésion.
		stPass.sTab [ 7 ]	= istPass.sTab [ 7 ]  // DCMP 030407 n° IMEI provenant de l'adhésion (N'A PAS ETE modifié depuis l'ouverture du sinistre)
		stPass.sTab [ 8 ]	= Upper ( dw_Choix_Action.GetItemString ( 1, "CHOIX_ACTION" ) ) // Choix Action "C"ommander/"S"électionner courrier
		stPass.sTab [ 9 ]	= gsCasGestion

		stPass.lTab [ 1 ]	= ilMarquaGeBLCODE  // [BLCODE]


		stPass.bTab [ 1 ]	= istPass.bTab [ 1 ] // Accès ou pas aux commandes.
		stPass.bTab [ 2 ]	= istPass.bTab [ 2 ] // Accès ou pas aux communes.
		stPass.bTab [ 3 ] = ibBrisEcran        // [DT447]


		stPass.dwTab [ 1 ]	= istPass.dwTab [ 2 ]   // Gar_Sin Sup
		stPass.dwTab [ 2 ]	= istPass.dwTab [ 3 ]   // LSt Inter
		stPass.dwTab [ 3 ]	= dw_w_Commande			// En local sur fen Detail
		stPass.dwTab [ 4 ]	= istPass.dwTab [ 5 ]	// dw_w_Commande au niveau sinistre pour récupérer les DDDW en Share.
		stPass.dwTab [ 5 ]	= istPass.dwTab [ 4 ]	// dw_w_Commande au niveau garantie.
		stPass.dwTab [ 6 ]   = dw_w_div_det  // #2
		stPass.dwTab [ 7 ]   = idwLstDetail		// [BLCODE]

		stPass.dwMaster  = istPass.dwMaster
		stPass.dwMaster1 = dw_1

		stPass.udwTab [ 1 ] = istPass.udwTab [ 1 ]   // Dw_w_Div_Sin
		stPass.udwTab [ 2 ] = idwDivDetGti  // [BLCODE]

		stPass.dwNorm [ 1 ]	= istPass.dwNorm [ 7 ]  // DataWindow PLAFOND
		stPass.dwNorm [ 2 ]	= istPass.dwNorm [ 1 ]  // DataWindow PRODUIT
		stPass.dwNorm [ 3 ]	= dw_Info_cmde				// DataWindow INFO COMMANDES

		stPass.dwNorm [ 4 ]	= istPass.dwNorm  [ 15 ] // DataWindow sur COMMANDE_TYPE, pour le choix des fournisseurs
		stPass.dwNorm [ 5 ]	= istPass.dwNorm  [ 16 ] // DataWindow sur COMMANDE_TYPE, pour le choix des articles
/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
		stPass.dwNorm [ 6 ]	= istPass.dwNorm  [ 17 ]	// DataWindow pour les horaires de rendez-vous
		stPass.dwNorm [ 7 ]	= istPass.dwNorm  [ 18 ]	// DataWindow sur la table ZONE_COGEPAR

		/*------------------------------------------------------------------*/
		/* #1                                                               */
		/*------------------------------------------------------------------*/
		stPass.dwNorm [ 8  ]  = istPass.dwNorm  [ 22 ]   // DataWindow sur la table DET_PRO
		stPass.dwNorm [ 9  ]  = istPass.dwNorm  [ 23 ]   // DataWindow des Communes
		stPass.dwNorm [ 10 ]  = istPass.dwNorm  [ 24 ]   // DataWindow des Communes
		stPass.dwNorm [ 11 ]  = istPass.dwNorm  [ 25 ]   // Dw des Données IFR
		stPass.dwNorm [ 12 ]  = istPass.dwNorm  [ 26 ]   // Dw des Libellés IFR Traduits
  		stPass.dwNorm [ 13 ]  = idwAutorisation   		 // [ 27 ] Table autorisation
		//* #2 [FNAC_PROD_ECH_TECH].[20090224144248310]
  		stPass.dwNorm [ 14 ]  = istPass.dwNorm  [ 33 ]   // Pièce coché actuellement sur la garantie.

		If	stPass.sTab [ 3 ]	<> stGLB.sMonnaieFormatDesire		Then	Uo_Consult_Euro.Uf_Changer_Monnaie ( stGLB.sMonnaieFormatDesire )

		isDetailActif = ""
		F_OuvreTraitement ( iW_Sp_Gs_W_Commande3, stPass )

End Choose
end event

event we_childactivate;call super::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_W_Detail::We_ChildActivate
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

event ue_retour;call super::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_W_Detail::Ue_Retour
//* Evenement 		: Ue_Retour
//* Auteur			: Erick John Stark
//* Date				: 05/02/1998 15:50:39
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild	dwChild
String sFiltre

If iuoGsSpwDetail.ibCochageCCConfoEncours Then
		stMessage.sCode = "WDET609"
		stMessage.icon  = Information!
		stMessage.bErreurG = False
		stMessage.bouton = Ok!
		F_Message ( stMessage )
		Return
End If

/*------------------------------------------------------------------*/
/* Si la fenêtre de consultation des paragraphes est visible, on    */
/* la rend invisible.                                               */
/*------------------------------------------------------------------*/
Wf_Fermer_Consulter_Paragraphe ()

/*------------------------------------------------------------------*/
/* Le 21/04/1999. Modif. pour la couverture UF des autres cartes.   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On désactive le filtre sur ID_TYPE_CARTE. Ce filtre peut être    */
/* positionné dans la fonction Uf_Zn_IdEvt ()                       */
/*------------------------------------------------------------------*/
sFiltre = ""

dw_1.GetChild ( "ID_TYPE_CARTE", dwChild )
dwChild.SetFilter  ( sFiltre )
dwChild.Filter ()

end event

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_W_Detail::Close
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
//Destroy iUoGsSpwDetail
If IsValid(iUoGsSpwDetail) Then Destroy iUoGsSpwDetail
//Fin Migration PB8-WYNIWYG-03/2006 FM


end event

on w_td_sp_w_detail.create
int iCurrent
call super::create
this.uo_ong=create uo_ong
this.uo_3d=create uo_3d
this.uo_piece=create uo_piece
this.uo_refus=create uo_refus
this.dw_wplaf_detail=create dw_wplaf_detail
this.uo_consult_euro=create uo_consult_euro
this.cb_supp_cmde=create cb_supp_cmde
this.dw_w_commande=create dw_w_commande
this.dw_info_cmde=create dw_info_cmde
this.cb_commander=create cb_commander
this.cb_tarif=create cb_tarif
this.cb_gamme=create cb_gamme
this.dw_choix_action=create dw_choix_action
this.cb_valachdef=create cb_valachdef
this.dw_w_div_det=create dw_w_div_det
this.st_pec=create st_pec
this.st_labpec=create st_labpec
this.cb_valid_factu=create cb_valid_factu
this.cb_dty_jff=create cb_dty_jff
this.st_mode_reprise=create st_mode_reprise
this.cb_aide_mode_reprise=create cb_aide_mode_reprise
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_ong
this.Control[iCurrent+2]=this.uo_3d
this.Control[iCurrent+3]=this.uo_piece
this.Control[iCurrent+4]=this.uo_refus
this.Control[iCurrent+5]=this.dw_wplaf_detail
this.Control[iCurrent+6]=this.uo_consult_euro
this.Control[iCurrent+7]=this.cb_supp_cmde
this.Control[iCurrent+8]=this.dw_w_commande
this.Control[iCurrent+9]=this.dw_info_cmde
this.Control[iCurrent+10]=this.cb_commander
this.Control[iCurrent+11]=this.cb_tarif
this.Control[iCurrent+12]=this.cb_gamme
this.Control[iCurrent+13]=this.dw_choix_action
this.Control[iCurrent+14]=this.cb_valachdef
this.Control[iCurrent+15]=this.dw_w_div_det
this.Control[iCurrent+16]=this.st_pec
this.Control[iCurrent+17]=this.st_labpec
this.Control[iCurrent+18]=this.cb_valid_factu
this.Control[iCurrent+19]=this.cb_dty_jff
this.Control[iCurrent+20]=this.st_mode_reprise
this.Control[iCurrent+21]=this.cb_aide_mode_reprise
end on

on w_td_sp_w_detail.destroy
call super::destroy
destroy(this.uo_ong)
destroy(this.uo_3d)
destroy(this.uo_piece)
destroy(this.uo_refus)
destroy(this.dw_wplaf_detail)
destroy(this.uo_consult_euro)
destroy(this.cb_supp_cmde)
destroy(this.dw_w_commande)
destroy(this.dw_info_cmde)
destroy(this.cb_commander)
destroy(this.cb_tarif)
destroy(this.cb_gamme)
destroy(this.dw_choix_action)
destroy(this.cb_valachdef)
destroy(this.dw_w_div_det)
destroy(this.st_pec)
destroy(this.st_labpec)
destroy(this.cb_valid_factu)
destroy(this.cb_dty_jff)
destroy(this.st_mode_reprise)
destroy(this.cb_aide_mode_reprise)
end on

event ue_valider;this.Hide()

call super::ue_valider
end event

type cb_debug from w_8_traitement_detail`cb_debug within w_td_sp_w_detail
end type

type dw_1 from w_8_traitement_detail`dw_1 within w_td_sp_w_detail
event ue_btcontroler pbm_custom71
integer x = 27
integer y = 296
integer width = 338
integer height = 300
integer taborder = 20
string dataobject = "d_sp_sin_w_detail_saisie_ff"
boolean border = false
end type

on dw_1::ue_btcontroler;call w_8_traitement_detail`dw_1::ue_btcontroler;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_W_Detail::dw_1
//* Evenement 		: ue_Btcontroler
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:35:04
//* Libellé			: 
//* Commentaires	: Modification des zones
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.pb_controler.TriggerEvent ( "Clicked" )
end on

event dw_1::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_w_Detail::dw_1 ( !!! OVERRIDE !!! )
//* Evenement 		: ItemError
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:47:59
//* Libellé			: 
//* Commentaires	: Gestion des messages d'erreur
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF		13/11/03 La valeur d'achat ne peut pas être null, sinon 
//*							problème avec les mobiles déjà choisi.
//*							Le fonctionnement de u_datawindow accepte dans tous les
//*							null (itemerror sur l'ancetre), je courcircuite cela pour
//*							la zone MT_VAL_ACHAT uniquement.
//* #2  JFF    14/12/06 Ajout d'un iiErreur
//* #3  PHG	   26/04/2007 [DCMP070275] Ajout de nvx motifs Sans suite pour la facturation
//* #3  JFF    28/01/2008 [DCMP080028]
//* #4  JFF    25/03/2008 [DCMP080200]
//* #5  JFF    26/09/2009 [GEST_VAL_ACH_ADH]
//* #6  JFF    02/03/2010 [MSS_LOT2]
//*     JFF    21/12/2010 [PC301][VESTUSTE]
//		  JFF    19/09/2012 [MANTIS4026]
//		FPI	06/02/2014	[ITSM198506] 
//		FPI	06/10/2014	[PC13174]
//       JFF   28/09/2015 [PM319-1]
//       JFF   20/12/2023 [RS6269_EVOL_CONFO]
//*-----------------------------------------------------------------
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM
n_cst_string lnv_String //[SUISSE].LOT3 : Gestion msg Err avec monnaie

/*------------------------------------------------------------------*/
/* On ne peut pas remettre la valeur d'achat à null.                */
/*------------------------------------------------------------------*/
Choose Case Upper ( This.GetColumnName () ) 
	Case "MT_VAL_ACHAT" , "NUM_FACTURE", "MT_VAL_PUBLIQUE" // #3
		// Gestion pour l'override
		ibErreur = TRUE
		isErrCol		= Upper ( This.GetColumnName () )

	Case "DTE_DET_DATE"
		// Gestion pour l'override
		ibErreur = TRUE
		If This.GetText () = "" Then 
			This.TriggerEvent ("ItemChanged" )
			If This.iiErreur <> 1 Then
				This.SetItem ( 1, "DTE_DET_DATE", stNul.dat )
				ibErreur = FALSE
			Else	
				ibErreur = TRUE
			End If
		End If
		isErrCol		= Upper ( This.GetColumnName () )

	Case Else
		// Sinon on déclenche l'ancêtre, et la suite ci-dessous
		Call super::itemerror
//Migration PB8-WYNIWYG-03/2006 FM
		ll_ret = AncestorReturnValue
//Fin Migration PB8-WYNIWYG-03/2006 FM

End Choose 

If	ibErreur Then

	stMessage.sTitre		= "Gestion des détails - SIMPA2"
	stMessage.Icon			= Information!

	stMessage.bErreurG	= TRUE

	Choose Case isErrCol

	Case "ID_EVT"
		stMessage.bErreurG	= False
		Choose Case This.iiErreur
		Case 1
			stMessage.sTitre		= "Gestion SFR"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= Ok!
			stMessage.sCode		= "SFRP071"
//		Case 2 // [SUISSE].LOT3 : Gestion msg Err avec monnaie => Ce cas n'est pas utilisé. Vu avec JFF
//			stMessage.bErreurG	= FALSE
//			stMessage.sVar[1] = "l'événement"		
//			stMessage.sCode	= "COMD062"

		Case 3	// ID_EVT : Casto / Aucune modif si PEC
			stMessage.sTitre		= "Modification interdite"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WDET310"
			
//* #4  JFF    25/03/2008 [DCMP080200]			
		Case 4  // ID_EVT : événement réservé à la facturation
			stMessage.sTitre		= "Modification interdite"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WDET564"

// #6 [MSS_LOT2]
		Case 5  // ID_EVT : événement réservé à la facturation
			stMessage.sTitre		= "Evènement interdit"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WDET573"

		// [MANTIS4026]
		Case 6  // ID_EVT : 1377 interdit si IPHONE
			stMessage.sTitre		= "Evènement interdit"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WDET620"
		
		// [PC13174]
		Case 7 // ID_EVT=1419 interdit si pas coché dans div_sin
			stMessage.sTitre		= "Evénement interdit"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WDET640"
			
		Case 8 // [PM319-1] Interdit de moifier si prix Orange utilisé
			stMessage.sTitre		= "Prix Orange déjà utilisé"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WDET647"
			
		Case 9 // [RS6269_EVOL_CONFO]
			stMessage.sTitre		= "Evènement interdit en 1er détail"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WDET680"
		
		End Choose

	Case "DTE_DET_DATE"
		Choose Case This.iiErreur
		Case 1	// ID_EVT : Casto / Aucune modif si PEC
			stMessage.sTitre		= "Modification interdite"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WDET310"
		Case Else 
			stMessage.sVar[1] = "date"
			stMessage.sCode	= "GENE002"
		End Choose


	Case "HEU_DET"
		stMessage.bErreurG	= False
		Choose Case This.iiErreur
		Case 1
			stMessage.sVar[1] 	= "l'heure du détail"			// Erreur de saisie - Il faut saisir 4 caractères
			stMessage.bErreurG	= False
			stMessage.sCode		= "WSIN120"

		Case 2
			stMessage.sVar[1] 	= "L'heure du détail"			// Erreur de saisie - L'heure est incorrecte
			stMessage.bErreurG	= False
			stMessage.sCode		= "WSIN130"
		End Choose

	Case "NUM_CARTE"
/*------------------------------------------------------------------*/
/* Pour la zone NUM_CARTE, on garde la valeur que la personne vient */
/* de saisir.                                                       */
/*------------------------------------------------------------------*/
		This.iiReset = 2

		Choose Case This.iiErreur
		Case 0
			stMessage.sVar[1] = "numéro de carte"				// Erreur de Validation - - Le N° de carte est incorrect
			stMessage.sCode	= "GENE003"
		Case 1
			stMessage.bErreurG= False								// Erreur de saisie - Le N° de carte est incorrect.
			stMessage.sCode	= "WORK130"
		Case 2
/*------------------------------------------------------------------*/
/* La commande PS_S01_CARTE_SINISTRE vient d'échouer. La structure  */
/* de message est armée sur F_Procedure.                            */
/*------------------------------------------------------------------*/
			stMessage.Icon			= StopSign!
		Case 3
			stMessage.bErreurG	= False							// Cette carte n'est pas couverte
			stMessage.sCode		= "WORK120"
		Case 4
			stMessage.bErreurG	= False							// Echec sur la procédure PS_S01_CARTE_UF
			stMessage.sCode		= "WDET636" 					// [ITSM198506] ald WDET220
		End Choose

	Case "LIB_DET"
		stMessage.sVar[1] = "libellé du détail"				// Erreur de Validation - 
		stMessage.sCode	= "GENE003"

	Case "MT_PREJ"

		// [PC301][VESTUSTE]
		Choose Case This.iiErreur		
			Case 0
				stMessage.sVar[1] = "montant du préjudice"			// Erreur de Validation - 
				stMessage.sCode	= "GENE003"
			Case 1
				stMessage.bErreurG= FALSE
				stMessage.sCode	= "WDET585"
				
			Case 24	// PEC : Manque zone duree gti origine
				stMessage.bErreurG= FALSE
				stMessage.sTitre		= "Règlement"
				stMessage.sCode		= "WDET581"

			Case 25	// PEC : duree gti origine négative ou null
				stMessage.bErreurG= FALSE
				stMessage.sTitre		= "Règlement"
				stMessage.sCode		= "WDET582"

			Case 26	// PEC : Vetuste absente.
				stMessage.bErreurG= FALSE
				stMessage.sTitre		= "Règlement"
				stMessage.sCode		= "WDET583"
				
			Case ELSE
				stMessage.sVar[1] = "montant du préjudice"			// Erreur de Validation - 
				stMessage.sCode	= "GENE003"
		End Choose		

	Case "MT_PLAF"
		stMessage.sVar[1] = "montant plafonné"					// Erreur de Validation - 
		stMessage.sCode	= "GENE003"

	Case "MT_VAL_ACHAT"
		This.iiReset = 0
		Choose Case This.iiErreur
			Case 0
				stMessage.sVar[1] = "montant de la valeur d'achat"		// Erreur de Validation - 
				stMessage.sCode	= "GENE003"
			Case 1
				stMessage.bErreurG	= FALSE
				stMessage.sVar[1]	= String ( iuoGsSpwDetail.uf_MaxTTC_MobileChoisi () )
				stMessage.sVar[2]	= lnv_string.of_GlobalReplace( stGlb.smonnaiesymboledesire, "\", "" ) // [SUISSE].LOT3 : Gestion msg Err avec monnaie
				stMessage.sVar[3] = "le montant de la valeur d'achat"		// Erreur de Validation - 
				stMessage.sCode	= "COMD062"

			Case 2	// MT_VAL_ACHAT : Casto / Aucune modif si PEC
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET310"

			//* #5  [GEST_VAL_ACH_ADH][GEST_VAL_ACH_ADH]
			Case 3	// MT_VAL_ACHAT : Modif sur droit si présence val_achat_adh
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET311"
			// [VDoc10924] 
			Case 4
				// Message affiché dans le uf_zn de l'objet de détail		
	End Choose

// #3
	Case "MT_VAL_PUBLIQUE"
		This.iiReset = 0
		Choose Case This.iiErreur
			Case 0
				stMessage.sVar[1] = "montant de la valeur publique"		// Erreur de Validation - 
				stMessage.sCode	= "GENE003"
			Case 1
				stMessage.bErreurG	= FALSE
				stMessage.sVar[1]	= String ( iuoGsSpwDetail.uf_MaxTTC_MobileChoisi () )
				stMessage.sVar[2] = lnv_string.of_GlobalReplace( stGlb.smonnaiesymboledesire, "\", "" ) // [SUISSE].LOT3 : Gestion msg Err avec monnaie
				stMessage.sVar[3] = "le montant de la valeur publique"		// Erreur de Validation - 
				stMessage.sCode	= "COMD062"

			Case 2	
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET310"				

			Case 3	
				stMessage.sTitre		= "Valeur publique"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET563"	

	End Choose
// :#3

	Case "DTE_FACTURE"
		stMessage.sVar[1] = "date"
		stMessage.sCode	= "GENE002"

	Case "NUM_FACTURE"
		stMessage.sVar[1] = "numéro de facture"
		stMessage.sCode	= "GENE003"

	Case "ID_I_REG"

		Choose Case This.iiErreur
			Case 2 // #2
				stMessage.bErreurG= FALSE
				stMessage.sCode	= "WDET251"
				
			Case Else 
				stMessage.bErreurG= FALSE
				stMessage.sCode	= "WDET260"

				
			End Choose
	// #3 [DCMP070275]Code motif sans suite reservé à la facturation
	Case "COD_MOT_SSUI"
			Choose Case This.iiErreur
				Case 1
				stMessage.bErreurG	= False
				stMessage.sCode		= "WSIN560"
			End Choose

	End Choose


	If stMessage.sCode <> "" Then F_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 FM
//	This.Uf_Reinitialiser ()
	ll_ret = This.Uf_Reinitialiser ()
//Fin Migration PB8-WYNIWYG-03/2006 FM

End If

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on dw_1::itemfocuschanged;call w_8_traitement_detail`dw_1::itemfocuschanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_W_Detail::dw_1
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
	Choose Case This.isNomCol
	Case "ID_EVT"
		iuoGsSpwDetail.Uf_Zn_Trt_Focus ( stPass_Dga )
		This.isNomCol = ""
	End Choose
End If

If iuoGsSpwDetail.uf_GetAutorisation ( 208 ) Then 
	If Upper ( This.GetColumnName () ) = "LIB_DET" then 
		This.SetColumn ( "MT_PREJ" )
	End IF
End IF
end on

event dw_1::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_W_Detail::dw_1
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
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

s_Pass	stPass_Dga

/*------------------------------------------------------------------*/
/* Si on est en Saisie, on lance le traitement des zones.           */
/*------------------------------------------------------------------*/
If	isTypeTrt = "S" Then
	ll_ret = iuoGsSpwDetail.Uf_Zn_Trt ( stPass_Dga )
End If

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type st_titre from w_8_traitement_detail`st_titre within w_td_sp_w_detail
boolean visible = false
integer x = 3296
integer y = 184
integer width = 133
end type

type pb_retour from w_8_traitement_detail`pb_retour within w_td_sp_w_detail
integer x = 9
integer y = 8
integer width = 242
integer height = 144
integer taborder = 90
end type

event pb_retour::clicked;// OVERRIDE !!
//       JFF   24/01/2012  [CONFO][CUISINE][PC680]

// [CONFO][CUISINE][PC680]
If iuoGsSpwDetail.ibCochageCCConfoEncours Then
		stMessage.sCode = "WDET609"
		stMessage.icon  = Information!
		stMessage.bErreurG = False
		stMessage.bouton = Ok!
		F_Message ( stMessage )
		Return
End If

If iuoGsSpwDetail.ibDeCochageCCConfoEncours Then
		stMessage.sCode = "WDET610"
		stMessage.icon  = Information!
		stMessage.bErreurG = False
		stMessage.bouton = Ok!
		F_Message ( stMessage )
		Return
End If

Call super::clicked

end event

type pb_valider from w_8_traitement_detail`pb_valider within w_td_sp_w_detail
integer x = 494
integer y = 8
integer width = 242
integer height = 144
integer taborder = 110
end type

type pb_imprimer from w_8_traitement_detail`pb_imprimer within w_td_sp_w_detail
boolean visible = false
integer x = 978
integer y = 8
integer taborder = 130
boolean enabled = false
end type

type pb_controler from w_8_traitement_detail`pb_controler within w_td_sp_w_detail
integer x = 251
integer y = 8
integer width = 242
integer height = 144
integer taborder = 100
end type

on pb_controler::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_W_Detail::pb_controler (OVERRIDE)
//* Evenement 		: 
//* Auteur			: Erick John Stark
//* Date				: 05/02/1998 15:50:39
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On déclenche un ItemFocusChanged avant toute chose. Cela         */
/* concerne la zone ID_EVT.                                         */
/*------------------------------------------------------------------*/

dw_1.TriggerEvent ( ItemFocusChanged! )

Call u_pbControler::Clicked

end on

type pb_supprimer from w_8_traitement_detail`pb_supprimer within w_td_sp_w_detail
integer x = 736
integer y = 8
integer width = 242
integer height = 144
integer taborder = 120
end type

type uo_ong from u_onglets within w_td_sp_w_detail
integer x = 9
integer y = 156
integer width = 1481
integer height = 108
integer taborder = 70
boolean border = false
end type

type uo_3d from u_bord3d within w_td_sp_w_detail
integer x = 2953
integer y = 40
integer width = 411
integer height = 188
end type

on constructor;//*-----------------------------------------------------------------
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
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne le Bord en 3D, puis on appelle la construction     */
/* normale.                                                         */
/*------------------------------------------------------------------*/

This.X			=   19
This.Y			=  365
This.Width		= 3534
This.Height		= 1290

Call U_Bord3D::Constructor
end on

on uo_3d.destroy
call u_bord3d::destroy
end on

type uo_piece from u_tagger within w_td_sp_w_detail
integer x = 411
integer y = 296
integer width = 338
integer height = 300
integer taborder = 40
end type

on ue_dwtrt_rbuttondown;call u_tagger::ue_dwtrt_rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Piece::Ue_DwTrt_rButtonDown
//* Evenement 		: Ue_DwTrt_rButtonDown
//* Auteur			: Erick John Stark
//* Date				: 16/07/1998 11:00:16
//* Libellé			: 
//* Commentaires	: On va visualiser le texte associé au paragraphe
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lLig

String sCol, sIdPara, sCptVer

s_Pass	stPass_Dga

/*------------------------------------------------------------------*/
/* On détermine si on se trouve sur une ligne valide.               */
/*------------------------------------------------------------------*/
lLig = F_GetObjectAtPointer ( This.dw_Trt, sCol )

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On a besoin d'un objet de transaction. Le seul valide qui        */
/* existe est celui de la fenêtre. Il n'y a aucun objet de          */
/* transaction sur les DW.                                          */
/*------------------------------------------------------------------*/

	stPass_Dga.trTrans = Parent.itrTrans

	sIdPara				= This.dw_Trt.GetItemString ( lLig, "ID_PARA" )
	sCptVer					= This.dw_Trt.GetItemString ( lLig, "CPT_VER" )

	stPass_Dga.sTab[1]	= sIdPara
	stPass_Dga.sTab[2] 	= "Paragraphe : " + sIdPara + "." + sCptVer + " - " + This.dw_Trt.GetItemString ( lLig, "LIB_PCE" )

	If	IsValid ( W_Consulter_Paragraphe )	Then
		W_Consulter_Paragraphe.Show ()
	Else
		Open ( W_Consulter_Paragraphe )
	End If

	W_Consulter_Paragraphe.Wf_AfficherParagraphe ( stPass_Dga )

End If




end on

event ue_dwtrt_itemchanged;call super::ue_dwtrt_itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_W_Detail::Uo_Piece::Ue_DwTrt_ItemChanged
//* Evenement 		: Ue_DwTrt_ItemChanged
//* Auteur			: Erick John Stark
//* Date				: 11/02/1998 14:38:47
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//		FPI	01/09/2016	[VDoc21594]		
//		JFF   03/01/2020	[PC192290]
//    JFF   04/09/2023  [RS5656_MOD_PCE_DIF]
//*-----------------------------------------------------------------

String sNomCol, sVal, sRech, sCodePce, sEtatPce, sLibEtatPce, sModeFctDp345 
n_cst_string lnvPFCString
Int iRow, iIdi, iIdGti, iIdDetail
Long lLigne, lTot, ll_return
Long lDeb, lFin, lCpt
DataWindowChild dwc
Boolean bFin

sNomCol	= Upper ( This.dw_Trt.GetColumnName () )
sVal		= This.dw_Trt.GetText ()

lLigne	= This.dw_Trt.GetRow ()

iIdGti	= dw_1.GetItemNumber (1,"ID_GTI")  // [RS5656_MOD_PCE_DIF]
iIdDetail = dw_1.GetItemNumber (1,"ID_DETAIL")  // [RS5656_MOD_PCE_DIF]

/*------------------------------------------------------------------*/
/* Si le détail posséde un code état "REGLE" (COD_ETAT=600), on ne  */
/* peut pas toucher aux pièces.                                     */
/*------------------------------------------------------------------*/
If	dw_1.GetItemNumber ( 1, "COD_ETAT" ) = 600	Then

//Migration PB8-WYNIWYG-03/2006 CP
//	This.dw_Trt.SetActionCode ( 2 )
//Fin Migration PB8-WYNIWYG-03/2006 CP

//Migration PB8-WYNIWYG-03/2006 CP
//	Return
Return 2
//Fin Migration PB8-WYNIWYG-03/2006 CP
	
End If

Choose Case sNomCol
Case "ALT_RECLAME"
	If	sVal = "N"	Then
		F_RechDetPro(lDeb, lFin, idwdetpro, idwProduit.GetItemNumber( 1,"ID_PROD"),"-DP",345)
		If lDeb <= 0 Then
			This.dw_Trt.SetItem ( lLigne, "ALT_RECLAME", "N" )
			This.dw_Trt.SetItem ( lLigne, "ID_I", stNul.dcm )
		End If 				
		
	Else
/*------------------------------------------------------------------*/
/* Si la zone ALT_SSUI est positionnée à OUI, on ne peut pas        */
/* cocher de pièce.                                                 */
/*------------------------------------------------------------------*/
		If	dw_1.GetItemString ( 1, "ALT_SSUI" ) = "O"	Then
			stMessage.sTitre		= "Contrôle sur le détail"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= False
			stMessage.sCode		= "WDET100"

			f_Message ( stMessage )
		Else
			This.dw_Trt.SetItem ( lLigne, "ALT_RECLAME", "O" )
		End If
	End If

	// [VDoc21594]
	if  sVal="O" Then
		f_rechdetpro(lDeb,  lFin, idwDetPro, idwProduit.getItemNumber(1,"ID_PROD"), "-DP",305)
		lDeb=idwDetPro.Find("ID_CODE_NUM=" + String(This.dw_Trt.GetItemNumber ( lLigne, "ID_PCE" )), lDeb, lFin)
		
		if lDeb > 0 Then 
			This.dw_Trt.Getchild( "ID_I", dwc)
			lCpt=dwc.Find("COD_INTER='" + idwDetPro.GetItemString(lDeb, "ID_CODE_CAR") + "'",1,dwc.RowCount())
			if lCpt > 0 Then
				This.dw_Trt.SetItem ( lLigne, "ID_I", dwc.GetItemNumber(lCpt,"ID_I"))
			End if
		End if
	End if
	// :[VDoc21594]
	
	// [PC192290]
	// Service de validation de pièce relié à SHERPA
	sCodePce = String ( This.dw_Trt.GetItemNumber ( lLigne, "ID_PCE" ))

	iIdI = This.dw_Trt.GetItemNumber ( lLigne, "ID_I" )
	If ( iIdI <> 0 OR IsNull ( iIdI ) ) And sVal = "N" Then
		This.dw_Trt.SetItem ( lLigne, "ALT_RECLAME", "N" )
		This.dw_Trt.SetItem ( lLigne, "ID_I", stNul.dcm )	
	End IF 

	F_RechDetPro(lDeb, lFin, idwdetpro, idwProduit.GetItemNumber( 1,"ID_PROD"),"-DP",345)
	If lDeb > 0 And iIdI = 0 Then

		// Determination de la Méthode  // [RS5656_MOD_PCE_DIF]
		sModeFctDp345 = lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( lDeb, "VAL_CAR" ), "MODE_FCT", ";")
		If sModeFctDp345 = "" Then sModeFctDp345 = "UNIQUE"
		
		If sVal = "O" Then 
			
			// [RS5656_MOD_PCE_DIF]
			Choose Case sModeFctDp345 
				Case "UNIQUE"
					iRow = gdsPieceSherpa.Find ( "ID_PCE = " + String ( sCodePce ), 1, gdsPieceSherpa.RowCount ()) 
				Case "DET_GARANTIE"
					iRow = gdsPieceSherpa.Find ( "ID_GTI = " + String ( iIdGti ) + " AND ID_DETAIL = " + String ( iIdDetail ) + " AND ID_PCE = " + String ( sCodePce ), 1, gdsPieceSherpa.RowCount ())
			End Choose 
			// /[RS5656_MOD_PCE_DIF]

			If iRow > 0 Then
				sEtatPce = gdsPieceSherpa.GetItemString ( iRow, "ETAT_PCE" ) 
				If sEtatPce <> "" Then
					Choose Case sEtatPce 
						Case "PVL"
							sLibEtatPce = "Conforme"
						Case "PNV"
							sLibEtatPce = "Non conforme"							
					End Choose 

					stMessage.sTitre		= "Nouvelle demande pièce"
					stMessage.Icon			= Exclamation!
					stMessage.bErreurG	= False
					stMessage.sCode		= "WGAR431"
					stMessage.sVar[1]		= sCodePce
					stMessage.sVar[2]		= sLibEtatPce				
					stMessage.bouton 		= YesNo!
					
					// OUI, erase et réclame à nouveau
					If F_Message ( stMessage ) = 1 Then					
						
						// TRT : ROWSDISCARD
						gdsPieceSherpa.RowsDiscard ( iRow, iRow, primary!)
						// On laisse cocher nativement
					
					// NON, on ne touche à rien
					Else 
					
						// TRT : On décoche !!
						This.dw_Trt.SetItem ( lLigne, "ALT_RECLAME", "N" )
						This.dw_Trt.SetItem ( lLigne, "ID_I", stNul.dcm )
					
					End If 									
				End If 
			End If 
		End If 
		
		If sVal = "N" Then
			stMessage.sTitre		= "Validation de la pièce"
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= False
			stMessage.sCode		= "WGAR426"
			stMessage.sVar[1]		= sCodePce
			stMessage.bouton = YesNo!
			
			// Avez-vous reçu cette pièce # ?@@OUI, je l'ai reçu@@NON, je ne l'ai pas reçu et je ne veux plus la réclamer.
			// OUI reçu
			If F_Message ( stMessage ) = 1 Then
				stMessage.sTitre		= "Validation de la pièce"
				stMessage.Icon			= Exclamation!
				stMessage.bErreurG	= False
				stMessage.sCode		= "WGAR428"
				stMessage.sVar[1]		= sCodePce
				stMessage.bouton 		= YesNo!
				
				// OUI, conforme
				If F_Message ( stMessage ) = 1 Then

					// [RS5656_MOD_PCE_DIF]
					// TRT : Marquage id_sin, id_pce pour sherpa PVL
					Parent.Wf_MarquageEtatPieceSherpa_RS5656 ( iIdGti, iIdDetail, Integer ( sCodePce ), "PVL", iIdI )
					
					// Décochage natif
					This.dw_Trt.SetItem ( lLigne, "ALT_RECLAME", "N" )
					This.dw_Trt.SetItem ( lLigne, "ID_I", stNul.dcm )						
					
				// NON, Non conforme
				Else 
					stMessage.sTitre		= "Validation de la pièce"
					stMessage.Icon			= Exclamation!
					stMessage.bErreurG	= False
					stMessage.sCode		= "WGAR429"
					stMessage.sVar[1]		= sCodePce
					stMessage.bouton = YesNo!
					
					// OUI, de nouveau la réclamer
					If F_Message ( stMessage ) = 1 Then

						Do While Not bFin
							stMessage.sTitre		= "Validation de la pièce"
							stMessage.Icon			= Exclamation!
							stMessage.bErreurG	= False
							stMessage.sCode		= "WGAR430"
							stMessage.sVar[1]		= sCodePce
							stMessage.bouton 		= YesNo!
							If F_Message ( stMessage ) = 1 Then bFin = TRUE
						Loop
						
						// [RS5656_MOD_PCE_DIF]
						// TRT : Marquage id_sin, id_pce pour sherpa PVL
						Parent.Wf_MarquageEtatPieceSherpa_RS5656 ( iIdGti, iIdDetail, Integer ( sCodePce ), "PNV", iIdI )
						
						// TRT : on laisse cocher !!
						This.dw_Trt.SetItem ( lLigne, "ALT_RECLAME", "O" )
						
					// NON, ne plus la réclamer
					Else 
						
						// [RS5656_MOD_PCE_DIF]
						// TRT : Marquage id_sin, id_pce pour sherpa PVL
						Parent.Wf_MarquageEtatPieceSherpa_RS5656 ( iIdGti, iIdDetail, Integer ( sCodePce ), "PNV", iIdI )
						
						// Décochage natif
						This.dw_Trt.SetItem ( lLigne, "ALT_RECLAME", "N" )
						This.dw_Trt.SetItem ( lLigne, "ID_I", stNul.dcm )
						
					End IF 
	
					
				End If 


			// NON pas reçu
			Else 
				// Souhaitez-vous toujours la réclamer # ? @@OUI, je souhaite toujours la réclamer@@NON, je ne souhaite plus la réclamer.				
				stMessage.sTitre		= "Validation de la pièce"
				stMessage.Icon			= Exclamation!
				stMessage.bErreurG	= False
				stMessage.sCode		= "WGAR427"
				stMessage.sVar[1]		= sCodePce
				stMessage.bouton = YesNo!
				
				// OUI la réclamer
				If F_Message ( stMessage ) = 1 Then
					
					// TRT on laisse cocher !!
					This.dw_Trt.SetItem ( lLigne, "ALT_RECLAME", "O" )					
					
				// NON, ne plus la réclamer
				Else 
					
					// On laisse filer, décoche natif
					This.dw_Trt.SetItem ( lLigne, "ALT_RECLAME", "N" )
					This.dw_Trt.SetItem ( lLigne, "ID_I", stNul.dcm )
					
				End If 					
			End If 
		End If 				
	End If 

	
	
/*------------------------------------------------------------------*/
/* On affiche un bitmap sur l'onglet si au moins l'une des pièces   */
/* est réclamée.                                                    */
/*------------------------------------------------------------------*/
	lTot		= This.dw_Trt.RowCount ()
	sRech 	= "ALT_RECLAME = 'O'"
	lLigne	= This.dw_Trt.Find ( sRech, 1, lTot )

	If	lLigne = 0 Then
		uo_Ong.Uf_ChangerBitmap ( "02", "" )
	Else
		uo_Ong.Uf_ChangerBitmap ( "02", "K:\PB4OBJ\BMP\8_ALPCE.BMP" )
	End If

//Migration PB8-WYNIWYG-03/2006 CP
//	This.dw_Trt.SetActionCode ( 2 )
Return 2
//Fin Migration PB8-WYNIWYG-03/2006 CP


End Choose

end event

on constructor;call u_tagger::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Piece::Constructor (EXTEND)
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
/* L'objet ne posséde pas de titre.                                 */
/*------------------------------------------------------------------*/
ibTitre			= False

/*------------------------------------------------------------------*/
/* On ne veut pas de RowFocusIndicator.                             */
/*------------------------------------------------------------------*/
ibIndicateur	= False

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

on uo_piece.destroy
call u_tagger::destroy
end on

type uo_refus from u_tagger within w_td_sp_w_detail
integer x = 795
integer y = 296
integer width = 338
integer height = 300
integer taborder = 60
boolean bringtotop = true
end type

on ue_dwtrt_rbuttondown;call u_tagger::ue_dwtrt_rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Refus::Ue_DwTrt_rButtonDown
//* Evenement 		: Ue_DwTrt_rButtonDown
//* Auteur			: Erick John Stark
//* Date				: 16/07/1998 11:00:16
//* Libellé			: 
//* Commentaires	: On va visualiser le texte associé au paragraphe
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lLig

String sCol, sIdPara, sCptVer

s_Pass	stPass_Dga

/*------------------------------------------------------------------*/
/* On détermine si on se trouve sur une ligne valide.               */
/*------------------------------------------------------------------*/
lLig = F_GetObjectAtPointer ( This.dw_Trt, sCol )

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On a besoin d'un objet de transaction. Le seul valide qui        */
/* existe est celui de la fenêtre. Il n'y a aucun objet de          */
/* transaction sur les DW.                                          */
/*------------------------------------------------------------------*/
	stPass_Dga.trTrans = Parent.itrTrans

	sIdPara				= This.dw_Trt.GetItemString ( lLig, "ID_PARA" )
	sCptVer					= This.dw_Trt.GetItemString ( lLig, "CPT_VER" )

	stPass_Dga.sTab[1]	= sIdPara
	stPass_Dga.sTab[2] 	= "Paragraphe : " + sIdPara + "." + sCptVer + " - " + This.dw_Trt.GetItemString ( lLig, "LIB_MOTIF" )

	If	IsValid ( W_Consulter_Paragraphe )	Then
		W_Consulter_Paragraphe.Show ()
	Else
		Open ( W_Consulter_Paragraphe )
	End If

	W_Consulter_Paragraphe.Wf_AfficherParagraphe ( stPass_Dga )

End If



end on

event ue_dwtrt_itemchanged;call super::ue_dwtrt_itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_W_Detail::Uo_Refus::Ue_DwTrt_ItemChanged
//* Evenement 		: Ue_DwTrt_ItemChanged
//* Auteur			: Erick John Stark
//* Date				: 11/02/1998 14:38:47
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String sNomCol, sVal, sRech

Long lLigne, lTot, ll_return

sNomCol	= Upper ( This.dw_Trt.GetColumnName () )
sVal		= This.dw_Trt.GetText ()

lLigne	= This.dw_Trt.GetRow ()

/*------------------------------------------------------------------*/
/* Si le détail posséde un code état "REGLE" (COD_ETAT=600), on ne  */
/* peut pas toucher aux refus.                                      */
/*------------------------------------------------------------------*/
If	dw_1.GetItemNumber ( 1, "COD_ETAT" ) = 600	Then

//Migration PB8-WYNIWYG-03/2006 CP
//	This.dw_Trt.SetActionCode ( 2 )
//	Return
	Return 2
//Fin Migration PB8-WYNIWYG-03/2006 CP

End If

Choose Case sNomCol
Case "ALT_INIT_ID_I"
	This.dw_Trt.SetItem ( lLigne, "ID_I", stNul.dcm )
	This.dw_Trt.SetItem ( lLigne, "ALT_INIT_ID_I", "N" )

//Migration PB8-WYNIWYG-03/2006 CP
//	This.dw_Trt.SetActionCode ( 2 )
	ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP



Case "ALT_OPE"
	If	sVal = "O"	Then
/*------------------------------------------------------------------*/
/* Si la zone ALT_SSUI est positionnée à OUI, on ne peut pas        */
/* cocher de refus.                                                 */
/*------------------------------------------------------------------*/
		If	dw_1.GetItemString ( 1, "ALT_SSUI" ) = "O"	Then
			stMessage.sTitre		= "Contrôle sur le détail"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= False
			stMessage.sCode		= "WDET110"

			f_Message ( stMessage )
	
		Else
			This.dw_Trt.SetItem ( lLigne, "ALT_INIT_ID_I", "N" )
			This.dw_Trt.SetItem ( lLigne, "ALT_OPE", "O" )
		End If
	Else
		This.dw_Trt.SetItem ( lLigne, "ALT_INIT_ID_I", "O" )
		This.dw_Trt.SetItem ( lLigne, "ID_I", stNul.dcm )
		This.dw_Trt.SetItem ( lLigne, "ALT_OPE", "N" )
	End If

/*------------------------------------------------------------------*/
/* On affiche un bitmap sur l'onglet si au moins l'un des refus     */
/* opérateur est coché.                                             */
/*------------------------------------------------------------------*/
	lTot		= This.dw_Trt.RowCount ()
	sRech 	= "ALT_OPE = 'O'"
	lLigne	= This.dw_Trt.Find ( sRech, 1, lTot )

	If	lLigne = 0 Then
		uo_Ong.Uf_ChangerBitmap ( "03", "" )
	Else
		uo_Ong.Uf_ChangerBitmap ( "03", "K:\PB4OBJ\BMP\8_REF.BMP" )
	End If

//Migration PB8-WYNIWYG-03/2006 CP
//	This.dw_Trt.SetActionCode ( 2 )
	ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP

End Choose

//Migration PB8-WYNIWYG-03/2006 CP
	Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP

end event

on constructor;call u_tagger::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Refus::Constructor (EXTEND)
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
/* L'objet ne posséde pas de titre.                                 */
/*------------------------------------------------------------------*/
ibTitre			= False

/*------------------------------------------------------------------*/
/* On ne veut pas de RowFocusIndicator.                             */
/*------------------------------------------------------------------*/
ibIndicateur	= False

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

on uo_refus.destroy
call u_tagger::destroy
end on

type dw_wplaf_detail from datawindow within w_td_sp_w_detail
boolean visible = false
integer x = 3269
integer y = 284
integer width = 242
integer height = 100
integer taborder = 50
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_w_para_plafond_detail"
end type

type uo_consult_euro from u_consultation_euro within w_td_sp_w_detail
integer x = 1221
integer y = 8
integer taborder = 140
end type

on uo_consult_euro.destroy
call u_consultation_euro::destroy
end on

type cb_supp_cmde from commandbutton within w_td_sp_w_detail
integer x = 283
integer y = 904
integer width = 498
integer height = 76
integer taborder = 190
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Suppr. Nouv. Cmdes"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_W_Detail::Click
//* Evenement 		: Click
//* Auteur			: Fabry JF
//* Date				: 19/09/01
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iuoGsSpwDetail.uf_Bt_Annuler_Commande ()
end on

type dw_w_commande from u_datawindow_detail within w_td_sp_w_detail
boolean visible = false
integer x = 1161
integer y = 296
integer width = 320
integer height = 304
integer taborder = 30
boolean enabled = false
string dataobject = "d_gs_w_commande"
boolean livescroll = false
end type

type dw_info_cmde from datawindow within w_td_sp_w_detail
integer x = 288
integer y = 740
integer width = 498
integer height = 168
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_info_cmde"
boolean border = false
boolean livescroll = true
end type

type cb_commander from commandbutton within w_td_sp_w_detail
integer x = 283
integer y = 648
integer width = 498
integer height = 88
integer taborder = 180
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Commander >>"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_W_Detail::Click
//* Evenement 		: Click
//* Auteur			: Fabry JF
//* Date				: 19/09/01
//* Libellé			: 
//* Commentaires	: 
//*				  
//*
//*-----------------------------------------------------------------


Parent.TriggerEvent ("ue_item5")
end on

type cb_tarif from commandbutton within w_td_sp_w_detail
integer x = 974
integer y = 8
integer width = 343
integer height = 136
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Tarifs Papiers"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: W_Td_Sp_W_Detail::Cb_Tarif			(EXTEND)
//* Evenement 		: Clicked				
//* Auteur			: Erick John Stark
//* Date				: 15/10/2001 14:58:03
//* Libellé			: 
//* Commentaires	: Ouverture de la fenêtre des tarifs pour les papiers.
//*				  
//* Arguments		: 
//*
//* Retourne		: 
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Le 28/11/2001.                                                   */
/* Modif DGA. DCMP 010375                                           */
/*------------------------------------------------------------------*/
OpenWithParm ( W_Trt_Popup_AidePapier, "" )

end on

type cb_gamme from picturebutton within w_td_sp_w_detail
boolean visible = false
integer x = 101
integer y = 744
integer width = 174
integer height = 152
integer taborder = 160
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string picturename = "k:\pb4obj\bmp\tel_port.bmp"
string disabledname = "k:\pb4obj\bmp\tel_pord.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : W_Tm_Sp_WDetail :: Cb_Gamme
//* Evenement     : Clicked
//* Auteur        : Catherine ABDMEZIEM
//* Date          : 27/09/2002 10:57:19
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

s_Pass	stPass

		If isTypeTrt = "S" Then
			stPass = istPass

			stPass.sTab [ 1 ] = Parent.Title

			stPass.dwNorm [ 2 ]	= istPass.dwNorm [ 19 ]	// DataWindow GAMME
			stPass.dwNorm [ 3 ] = istPass.dwTab [ 5 ]		// DataWindow dw_W_Commande de sin pour la populisation de id_four

			stPass.wParent	= Parent

			OpenWithParm ( W_Sp_Gamme, stPass )
			ilRetGamme = Message.DoubleParm

			iuoGsSpwDetail.uf_MajVarGamme ( ilRetGamme )

		End If

end on

type dw_choix_action from datawindow within w_td_sp_w_detail
integer x = 832
integer y = 656
integer width = 448
integer height = 216
integer taborder = 200
boolean bringtotop = true
string dataobject = "d_choix_action"
boolean border = false
end type

on itemchanged;//*-----------------------------------------------------------------
//*
//* Objet         : dw_Choix_Action
//* Evenement     : ItemChanged
//* Auteur        : Fabry JF
//* Date          : 31/12/2003 15:38:29
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

Choose Case Upper ( This.GetText () )
	Case "C"
		cb_Commander.Text = "Commander >>"
	Case "S"
		cb_Commander.Text = "Sél.Courrier >>"
	Case "R"
		cb_Commander.Text = "Réparer >>"
	Case "I"
		cb_Commander.Text = "Informer >>"
End Choose


end on

type cb_valachdef from commandbutton within w_td_sp_w_detail
integer x = 846
integer y = 884
integer width = 119
integer height = 68
integer taborder = 170
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Déf."
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : cb_ValAchDef
//* Evenement     : clicked
//* Auteur        : Fabry JF
//* Date          : 12/05/2005 16:54:48
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


iuoGsSpwDetail.uf_bt_ValAchatDefaut ()
end on

type dw_w_div_det from u_datawindow_detail within w_td_sp_w_detail
boolean visible = false
integer x = 1518
integer y = 292
integer width = 361
integer height = 304
string dataobject = "d_lst_w_div_det"
boolean vscrollbar = true
boolean border = false
end type

event itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::dw_w_Diw_Sin
//* Evenement 		: ItemError
//* Auteur			: Fabry JF
//* Date				: 17/06/2004 09:47:59
//* Libellé			: 
//* Commentaires	: Gestion des messages d'erreur
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF   04/06/2007   [DCMP070163-070164-070248-070318] Gestion Prise en charge
//* #2    JFF   27/08/2007   [DCMP070431]
//* #3    JFF   28/01/2008   [DCMP080028]
//* #4    JFF   05/02/2008   [DCMP070921]
//* #5	 JFF	 20/10/2008	  [FNAC_PROD_ECH_TECH]
//* #6    JFF	 28/07/2009   [DCMP090427]
//*       JFF	 06/05/2010   [20100506164646807]
//*		 JFF   07/05/2010   [DCMP100331]
//* 		 JFF   04/11/2010   [PC301].[LOT2]
//*       JFF   21/12/2010   [PC301][VESTUSTE]
//*       JFF   13/07/2011   [VDOC4684]
//* 		 FPI	 24/08/2011	  [VDoc5059]
//*       JFF   24/01/2012   [CONFO][CUISINE][PC680]
//        JFF   01/03/2012   [CONFO][MEUBLE][PC542]
//        JFF   24/09/2018   [DT344]
//        JFF   24/05/2019   [DT391-1]
//*-----------------------------------------------------------------
n_cst_string lnv_string

//* #5 [FNAC_PROD_ECH_TECH]
// Si 1000, message prioritaire de rejet cause absence de droit.
If This.iiErreur = 1000 Then
	stMessage.sTitre		= "Aucune marque"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sCode		= "WDET565"
	
	F_Message ( stMessage )
	return This.Uf_Reinitialiser ()
	
End If

Choose Case isErrCol

	Case "VAL_LST_CAR"

		Choose case This.iiErreur
			// #2
			// [CONFO][MEUBLE][PC542]
			Case 1	// MARQ_APP/MODL_APP : Casto / Aucune modif si PEC
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET310"

			// [CONFO][NV_PROCESS]
			Case 2
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET616"

			// [CONFO][NV_PROCESS]
			Case 3
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET617"			

			// [DT344]
			Case 4
				stMessage.sTitre		= "Souplesse interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET666"
				
			// [DT391-1]
			Case 5
				stMessage.sTitre		= "Refus SCB"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET670"
				
			Case Else
				stMessage.sTitre		= "Gestion des sinistres - SIMPA2"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= TRUE
				stMessage.sCode	= "GENE016"  // Saisie Incorrecte
		End Choose				
				

	Case "VAL_LST_NBRE"

		Choose case This.iiErreur
			// #2
			Case 1	// Accord remplacement : Vous n'avez pas les droits suffisants
				stMessage.sTitre		= "Accord remplacement suite irréparable"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sVar [1]   = "210"
				stMessage.sCode		= "WDET500"

			// #2
			Case 2	// Accord remplacement : décochage impossible car CMDE TEL présent
				stMessage.sTitre		= "Accord remplacement suite irréparable"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET533"

			// #3
			Case 3	// Accord remplacement2: Vous n'avez pas les droits suffisants
				stMessage.sTitre		= "Accord remplacement suite 2 réparations"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sVar [1]   = "212"
				stMessage.sCode		= "WDET500"

			// #4
			Case 4	// MT_PEC : Impossible de modifier si présence d'une commande
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET352"

			// [CONFO][MEUBLE][PC542]
			Case 5	// MARQ_APP/MODL_APP : Casto / Aucune modif si PEC
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET310"


		End Choose

	Case "VAL_DTE"
		Choose case This.iiErreur
			Case 1	
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET310"

			Case Else
				stMessage.sTitre		= "Date non valide"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sVar[1]		= "date"
				stMessage.sCode		= "GENE002"
		End Choose

	Case "VAL_MT"
		Choose case This.iiErreur
			
			Case 1	// MT_PEC : Veuillez forcer la prise en charge pour pouvoir modifier le montant de prise en charge.
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET526"

			// #1
			Case 2	// MT_PEC : Impossible de modifier si présence d'une commande
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET352"

			// #1
			Case 3	// PEC : Impossible de décocher PEC si CPT_VALIDE > 0 et PEC = "O"
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET351"		
				
			// #1
			Case 4	// PEC : -DP/86 manquante pour PEC (hors Casto)
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET522"				

			// [VDOC4684]
			Case 5	// MT_PEC : Impossible de modifier si présence d'une commande
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET592"

			// [ITSM137898]
			Case 6	// PEC : Impossible de décocher PEC si CPT_VALIDE > 0 et PEC = "O"
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET351"				

			// [VDoc5059]
			Case 0
				stMessage.sTitre		= "Gestion des sinistres - SIMPA2"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= TRUE
				stMessage.sCode	= "GENE016"  // Saisie Incorrecte
		
		End CHoose 

	Case "VAL_CAR"
		Choose case This.iiErreur
			Case 1	// MARQ_APP : Casto
				stMessage.sTitre		= "Aucune marque"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET280"

			Case 2	// MARQ_APP/MODL_APP : Casto / Aucune modif si PEC
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET310"

		// [DCMP100331]					
			Case 3
				stMessage.sTitre		= "Numéro de réparation"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET577"

			Case 4
				stMessage.sTitre		= "Numéro de réparation"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET578"
		// [DCMP100331]					

		// [PC301].[LOT2]
			Case 5
				stMessage.sTitre		= "Etage immeuble"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET580"		
		// [PC301].[LOT2]

		
		End Choose

	Case "VAL_ALT"
		Choose case This.iiErreur
			Case 1	// PEC : Casto / Impossible car MtValAchat à 0
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET290"
				stMessage.svar[1]		= lnv_string.of_GlobalReplace( stGlb.smonnaiesymboledesire, "\", "" ) // [SUISSE].LOT3 : Gestion msg Err avec monnaie

			Case 2	// PEC : Casto / Impossible car Qté à 0
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET300"

			Case 3	// AUCUNE_MARQ : Casto / Aucune modif si PEC
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET310"

			Case 4	// PEC : Casto / Impossible car Marque ou Modèle non renseignés
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET320"

			Case 5	// PEC : Casto / Impossible car Date achat non renseignée
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET330"

			Case 6	// PEC : Casto / Impossible de décocher PEC si CPT_VALIDE > 0 et PEC = "O"
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET350"

			Case 7	// ALT_PEC : Casto / forçage PEC Réservé aux personne habilité.
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET360"

			Case 8	// ALT_PEC : Casto / Pour forcer, il faut cocher la PEC d'abord
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET370"

			Case 9	// PEC : Casto / Si Pec forcer, impossible décocher PEC
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET380"

			Case 10	// PEC/ALT_PEC : impossible si pour certain etat 
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET440"

			Case 11	// DOS_CHARGE_SPB : Vous n'êtes pas autorisé 
				stMessage.sTitre		= "Dossier à charge SPB"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sVar [1]   = "209"
				stMessage.sCode		= "WDET500"

			// #1
			Case 12	// PEC : -DP/86 manquante pour PEC (hors Casto)
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET522"

			// #1
			Case 13	// PEC : L'evt est obligatoire
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET524"

			// #1
			Case 14	// PEC : Le param n'autorise pas le réglement
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET523"

			// #1
			Case 15	// PEC : Erreur de param liée à la -DP/86
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET525"
	
			// #1
			Case 16	// PEC : Impossible de décocher PEC si CPT_VALIDE > 0 et PEC = "O"
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET351"

			// #1
			Case 17	// PEC : Impossible de cocher si présence d'une commande
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET352"

			// #1
			Case 18	// PEC : Pour prendre en charge, la valeur d'achat d'origine est obligatoire.
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET291"

			Case 19	// PEC : Impossible car Date achat non renseignée sur sinistre
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET331"

			Case 20	// PEC : Le param ne couvre pas 
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET536"

// #3
			Case 21	// PEC : Pour prendre en charge, la valeur d'achat d'origine est obligatoire.
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET292"
// :#3
			// #6 [DCMP090427]
			Case 22	// PEC : L'evt 1083 Action O2M interdit la PEC
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET570"


// [20100506164646807]
			Case 23	// PEC : L'evt 1083 Action O2M interdit la PEC
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET575"
// :[20100506164646807]

// [PC301][VESTUSTE]
			Case 24	// PEC : Manque zone duree gti origine
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET581"

			Case 25	// PEC : duree gti origine négative ou null
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET582"

			Case 26	// PEC : Vetuste absente.
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET583"
				
			Case 27	// PEC : Veuillez saisir la date de survenance
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET586"

  			//[CONFO][CUISINE][PC680]
			Case 28
				stMessage.sTitre		= "Code Article"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET598"		

			Case 29
				stMessage.sTitre		= "Libellé de l'Article"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET599"		


			Case 30
				stMessage.sTitre		= "Date de fin de garantie"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET600"		

			Case 31
				stMessage.sTitre		= "Code de regroupement (meuble)"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET601"		
	
			Case 32
				stMessage.sTitre		= "Quantité"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET603"
	
			Case 33
				stMessage.sTitre		= "Code Article"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET604"		

			Case 34
				stMessage.sTitre		= "Libellé de l'Article"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET605"		

			Case 35
				stMessage.sTitre		= "Date de fin de garantie"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET606"		

			Case 36
				stMessage.sTitre		= "Code de regroupement (meuble)"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET607"		

			Case 37
				stMessage.sTitre		= "Montant de carte cadeau à 0€"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET608"	

				//[CONFO][CUISINE][PC680]		
			
			// [CONFO][MEUBLE][PC542]
			Case 38	
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET353"

			// [CONFO][MEUBLE][PC542]
			Case 39	
				stMessage.sTitre		= "Prise en charge"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET618"

					
					
// [PC301][VESTUSTE]

		End CHoose

	Case "VAL_NBRE"
		Choose case This.iiErreur
			Case 1	// QTE : Casto / Aucune modif si PEC
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET310"

			Case 2	// QTE : Casto / QTE doit être > 0
				stMessage.sTitre		= "Quantité"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET410"
				
// [PC301][VESTUSTE]				
			Case 3	// VETUSTE : Aucune modif si PEC
				stMessage.sTitre		= "Modification interdite"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WDET310"				

			Case Else
				stMessage.sTitre		= "Nombre valide"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sVar[1]		= "nombre"
				stMessage.sCode		= "GENE003"

		End Choose

	Case Else

		stMessage.sTitre		= "Gestion des sinistres - SIMPA2"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= TRUE
		stMessage.sCode	= "GENE016"

End Choose	

F_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 FM
//This.Uf_Reinitialiser ()
return This.Uf_Reinitialiser ()
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre_Detail::dw_w_Div_Det
//* Evenement 		: ItemChanged
//* Auteur			: Fabry JF
//* Date				: 04/10/2005
//* Libellé			: 
//* Commentaires	: Modification des zones
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Si on est en Saisie, on lance le traitement des zones.           */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

If	isTypeTrt = "S" Then
//Migration PB8-WYNIWYG-03/2006 FM
//	iuoGsSpwDetail.Uf_Zn_Trt_DivDet ( This.GetText (), Upper ( isNomCol) , This.GetRow (), This.GetItemString (This.GetRow (), "NOM_ZONE" ) )
	ll_ret = iuoGsSpwDetail.Uf_Zn_Trt_DivDet ( This.GetText (), Upper ( isNomCol) , This.GetRow (), This.GetItemString (This.GetRow (), "NOM_ZONE" ) )
//Fin Migration PB8-WYNIWYG-03/2006 FM
End If

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on losefocus;call u_datawindow_detail::losefocus;//*-----------------------------------------------------------------
//*
//* Objet         : dw_w_Div_Det
//* Evenement     : LoseFocus
//* Auteur        : Fabry JF
//* Date          : 17/06/2004 16:09:21
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


 dw_w_Div_Det.AcceptText () 
end on

on rowfocuschanged;call u_datawindow_detail::rowfocuschanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre_Detail::dw_w_Div_Det
//* Evenement 		: RowFocusChanged
//* Auteur			: Fabry JF
//* Date				: 04/10/2005
//* Libellé			: 
//* Commentaires	: Changement de zone 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Si on est en Saisie, on lance le traitement des zones.           */
/*------------------------------------------------------------------*/

If	isTypeTrt = "S" Then
	iuoGsSpwDetail.uf_GestOng_Divers_DDDW ( This.GetText (), Upper ( This.GetColumnName () ) , This.GetRow () )
End If


end on

type st_pec from statictext within w_td_sp_w_detail
integer x = 288
integer y = 988
integer width = 448
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 12632256
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_labpec from statictext within w_td_sp_w_detail
integer x = 293
integer y = 1104
integer width = 169
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Mt PEC"
boolean focusrectangle = false
end type

type cb_valid_factu from commandbutton within w_td_sp_w_detail
integer x = 55
integer y = 1208
integer width = 599
integer height = 136
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Validation &Facturation"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_tm_sp_w_detail:cb_valid_factu
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 06/10/2009 11:47:43
//* Libellé			: 
//* Commentaires	: [DCMP090595]
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

pb_controler.TriggerEvent(clicked!)

if pb_valider.Enabled=TRUE Then
	pb_valider.Enabled=FALSE
	Parent.TriggerEvent ( "ue_Valider" )
End if
end event

type cb_dty_jff from commandbutton within w_td_sp_w_detail
boolean visible = false
integer x = 1472
integer y = 12
integer width = 128
integer height = 132
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "JFF"
end type

event clicked;
If stGlb.sCodOper = "JFF" Then
	gsCasGestion = iuoGsSpwDetail.uf_Gestion_DartyNomade ( dw_1.GetItemDecimal ( 1, "MT_VAL_ACHAT" ), "C" )
End If

end event

type st_mode_reprise from statictext within w_td_sp_w_detail
integer x = 1541
integer y = 8
integer width = 727
integer height = 152
boolean bringtotop = true
integer textsize = -12
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

type cb_aide_mode_reprise from commandbutton within w_td_sp_w_detail
integer x = 2272
integer y = 8
integer width = 251
integer height = 152
integer taborder = 480
boolean bringtotop = true
integer textsize = -12
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

