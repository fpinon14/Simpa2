$PBExportHeader$w_tm_sp_w_gar_sin.srw
$PBExportComments$-} Fenêtre de traitement pour la saisie des garanties.
forward
global type w_tm_sp_w_gar_sin from w_8_traitement_master
end type
type uo_ong from u_onglets within w_tm_sp_w_gar_sin
end type
type p_focus from picture within w_tm_sp_w_gar_sin
end type
type uo_3d from u_bord3d within w_tm_sp_w_gar_sin
end type
type dw_lst_detail from u_datawindow_detail within w_tm_sp_w_gar_sin
end type
type uo_piece from u_tagger within w_tm_sp_w_gar_sin
end type
type uo_refus from u_tagger within w_tm_sp_w_gar_sin
end type
type dw_wpiece_detail from datawindow within w_tm_sp_w_gar_sin
end type
type dw_wrefus_detail from datawindow within w_tm_sp_w_gar_sin
end type
type dw_wdetail_supp from datawindow within w_tm_sp_w_gar_sin
end type
type dw_wpplafond_detail from datawindow within w_tm_sp_w_gar_sin
end type
type dw_wpplafond_gti from datawindow within w_tm_sp_w_gar_sin
end type
type dw_wparaplafond from datawindow within w_tm_sp_w_gar_sin
end type
type uo_consult_euro from u_consultation_euro within w_tm_sp_w_gar_sin
end type
type dw_w_commande from u_datawindow_detail within w_tm_sp_w_gar_sin
end type
type cb_tarif from commandbutton within w_tm_sp_w_gar_sin
end type
type dw_w_div_det from u_datawindow_detail within w_tm_sp_w_gar_sin
end type
type cb_valid_factu from commandbutton within w_tm_sp_w_gar_sin
end type
type st_mode_reprise from statictext within w_tm_sp_w_gar_sin
end type
type cb_aide_mode_reprise from commandbutton within w_tm_sp_w_gar_sin
end type
end forward

global type w_tm_sp_w_gar_sin from w_8_traitement_master
integer x = 0
integer y = 0
integer width = 3616
integer height = 1916
string title = ""
event ue_quitteronglet011 pbm_custom01
event ue_quitteronglet021 pbm_custom02
event ue_quitteronglet031 pbm_custom03
event ue_taillefenetre ( )
uo_ong uo_ong
p_focus p_focus
uo_3d uo_3d
dw_lst_detail dw_lst_detail
uo_piece uo_piece
uo_refus uo_refus
dw_wpiece_detail dw_wpiece_detail
dw_wrefus_detail dw_wrefus_detail
dw_wdetail_supp dw_wdetail_supp
dw_wpplafond_detail dw_wpplafond_detail
dw_wpplafond_gti dw_wpplafond_gti
dw_wparaplafond dw_wparaplafond
uo_consult_euro uo_consult_euro
dw_w_commande dw_w_commande
cb_tarif cb_tarif
dw_w_div_det dw_w_div_det
cb_valid_factu cb_valid_factu
st_mode_reprise st_mode_reprise
cb_aide_mode_reprise cb_aide_mode_reprise
end type
global w_tm_sp_w_gar_sin w_tm_sp_w_gar_sin

type variables
Private :
	u_gs_sp_sinistre_garantie	iuoGsSpGarantie
	String			isTypeTrt
	String			isDetailConsult
	String			isReferentiel  

	DataWindow		idw_Desc[10]
	DataWindow		idwCmdTypFrn
	DataWindow		idwCmdTypArt
	DataWindow		idwDetPro
	DataWindow		idwTacImei
	DataWindow		idwProduit
	DataWindow		idw_Zone_Cogepar
	DataWindow		idw_Horaire_Rdv
	DataWindow		idw_Gamme
	DataWindow		idw_DetArt
	DataWindow		idw_DetHlr
	DataWindow		idwStkIFR 
	DataWindow		idwStkCodicDarty 
	DataWindow		idwStkCodeMB
	DataWindow		idwAutorisation
	DataWindow		idwArticle // [PC10].[DP150]
	
	U_DataWindow		idw_wSin
	U_DataWindow		idwWDivSin

	U_DataWindow_Detail	idw_LstGarSin
	U_DataWindow_Detail	idw_LstInter
	U_DataWindow_Detail	idw_LstCmdeSin
	U_DataWindow_Detail	idw_DivDetSin

	W_Td_Sp_W_Detail	iW_Td_Sp_W_Detail
	W_T_Sp_Message		iW_T_Sp_Message


end variables

forward prototypes
private subroutine wf_positionnerobjets ()
public function boolean wf_preparermodifier ()
public function boolean wf_preparerinserer ()
public function string wf_controlersaisie ()
public function boolean wf_preparervalider ()
public function boolean wf_preparersupprimer ()
private subroutine wf_fermer_consulter_paragraphe ()
private subroutine wf_tb_consultation ()
private function boolean wf_condition_ouverture ()
private function boolean wf_condition_tac ()
private function boolean wf_condition_ouverture_dt269 ()
private function boolean wf_condition_ouverture_dt386 ()
private subroutine wf_marquageetatpiecesherpa (integer aid_pce, string asetat_pce, integer aiidi)
private subroutine wf_marquageetatpiecesherpa_rs5656 (integer aid_gti, integer aid_pce, string asetat_pce, integer aiidi)
end prototypes

on ue_quitteronglet011;call w_8_traitement_master::ue_quitteronglet011;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_W_Gar_Sin::Ue_QuitterOnglet011
//* Evenement 		: Ue_QuitterOnglet011
//* Auteur			: Erick John Stark
//* Date				: 16/07/1998 14:58:37
//* Libellé			: 
//* Commentaires	: On va quitter l'onglet 01
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

on ue_quitteronglet021;call w_8_traitement_master::ue_quitteronglet021;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_W_Gar_Sin::Ue_QuitterOnglet021
//* Evenement 		: Ue_QuitterOnglet021
//* Auteur			: Erick John Stark
//* Date				: 16/07/1998 14:58:37
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

on ue_quitteronglet031;call w_8_traitement_master::ue_quitteronglet031;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_W_Gar_Sin::Ue_QuitterOnglet031
//* Evenement 		: Ue_QuitterOnglet031
//* Auteur			: Erick John Stark
//* Date				: 16/07/1998 14:58:37
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

This.Height = 1810

end event

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Garantie::Wf_PositionnerObjets (PRIVATE)
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
//* MAJ   PAR      Date	     Modification
//* #1	 CAG	 02/09/2004	  Suite DCMP 040355 Repositionnement du Bouton tarif papier
//* #2	 FPI	 06/10/2009		[DCMP090595] Ajout du bouton cb_valid_factu
//        JFF   23/05/2012   [PM103][1]
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
Dw_1.X			=   33
Dw_1.Y			=  273
Dw_1.Width		= 3484
Dw_1.Height		=  917

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
/* Liste des Details.                                               */
/*------------------------------------------------------------------*/
Dw_Lst_Detail.X		= Uo_3D.X
Dw_Lst_Detail.Y		= Dw_1.Y + Dw_1.Height + 40
Dw_Lst_Detail.Width	= Uo_3D.Width
Dw_Lst_Detail.Height	= 430

/*------------------------------------------------------------------*/
/* #1 CAG : 02/09/2004                                              */
/*------------------------------------------------------------------*/
If Uo_Consult_Euro.Visible = False Then
	Cb_Tarif.X = 1221
End If

If Pb_Imprimer.Visible = False Then
	Cb_Tarif.X = 979
End If

// #2 - [DCMP090595]
cb_valid_factu.X = 1687


// [PM103][1]
st_mode_reprise.X = 2501
st_mode_reprise.Y = 84
st_mode_reprise.Width = 727
st_mode_reprise.Height = 152

cb_aide_mode_reprise.X = 3232
cb_aide_mode_reprise.Y = 84
cb_aide_mode_reprise.Width = 251
cb_aide_mode_reprise.Height = 152
// :[PM103][1]
end subroutine

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_W_Gar_Sin::Wf_PreparerModifier
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
//* #2	FPI	06/10/2009	[DCMP090595] Ajout du bouton cb_valid_factu
//      JFF    23/05/2012 [PM103][1]
//*-----------------------------------------------------------------

s_Pass	stPass_Dga
String sMonnaie
boolean bIdRev // #1

/*------------------------------------------------------------------*/
/* On arme le titre de la fenêtre avec le titre de la fenêtre       */
/* Parent.                                                          */
/*------------------------------------------------------------------*/
This.Title = istPass.sTab [ 1 ]

iuoGsSpGarantie.Uf_Traitement ( 2, stPass_Dga )

isReferentiel  = istPass.sTab [ 8 ]		

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

// Mise en commentaire suite à problème fonctionnel avec le scripting
/*
// #1
// istPass.dwNorm[12] --> datawindow de w_piece
// id_detail = -1  --> piece demandée au niveau garantie
if idw_wSin.GetItemNumber ( 1, "ID_REV") = -1 and &
		istPass.dwNorm [ 12 ].Find ( "ID_DETAIL = -1", 1, istPass.dwNorm [ 12 ].rowcount() ) = 0 then
	bIdRev = false
else 
	bIdRev = true
end if
//Uo_Ong.Uf_ActiverOnglet ( "02", bIdRev ) // pieces
// #1 - FIN
*/

// #2 - [DCMP090595]
if not iuogsspgarantie.uf_getautorisation( 208 ) Then
	cb_valid_factu.Enabled = FALSE
	cb_valid_factu.Visible = FALSE
End if
// Fin #2


// [PM103][1]
// A supprimer quand ce sera en prod
cb_aide_mode_reprise.Visible = FALSE
st_mode_reprise.Visible = FALSE
cb_aide_mode_reprise.Visible = iuoGsSpGarantie.uf_GetAutorisation ( 223 )
st_mode_reprise.Visible = iuoGsSpGarantie.uf_GetAutorisation ( 223 )
// :[PM103][1]


Return ( stPass_Dga.bRetour )

end function

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_Garantie::Wf_PreparerInserer
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
//      JFF   23/05/2012 [PM103][1]
//*-----------------------------------------------------------------

s_Pass	stPass_Dga
boolean bIdRev // #1

/*------------------------------------------------------------------*/
/* On arme le titre de la fenêtre avec le titre de la fenêtre       */
/* Parent.                                                          */
/*------------------------------------------------------------------*/
This.Title = istPass.sTab [ 1 ]
isReferentiel  = istPass.sTab [ 8 ]		

/*------------------------------------------------------------------*/
/* On arme la valeur de la garantie que l'on vient de               */
/* sélectionner. Ainsi que le montant moyen pour les provisions.    */
/*------------------------------------------------------------------*/
stPass_Dga.lTab[1] = istPass.lTab[1]
stPass_Dga.lTab[2] = istPass.lTab[2]

iuoGsSpGarantie.Uf_Traitement ( 3, stPass_Dga )

// Mise en commentaire suite à problème fonctionnel avec le scripting
/*
// #1 
// istPass.dwNorm[12] --> datawindow de w_piece
// id_detail = -1  --> piece demandée au niveau garantie
if idw_wSin.GetItemNumber ( 1, "ID_REV") = -1 and &
		istPass.dwNorm [ 12 ].Find ( "ID_DETAIL = -1", 1, istPass.dwNorm [ 12 ].rowcount() ) = 0 then 
	bIdRev = false
else 
	bIdRev = true
end if
Uo_Ong.Uf_ActiverOnglet ( "02", bIdRev ) // pieces
// #1 - FIN
*/

// #2 - [DCMP090595]
if not iuogsspgarantie.uf_getautorisation( 208 ) Then
	cb_valid_factu.Enabled = FALSE
	cb_valid_factu.Visible = FALSE
End if
// Fin #2

// [PM103][1]
// A supprimer quand ce sera en prod
cb_aide_mode_reprise.Visible = FALSE
st_mode_reprise.Visible = FALSE
cb_aide_mode_reprise.Visible = iuoGsSpGarantie.uf_GetAutorisation ( 223 )
st_mode_reprise.Visible = iuoGsSpGarantie.uf_GetAutorisation ( 223 )
// :[PM103][1]


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

Wf_Fermer_Consulter_Paragraphe ()

stPass_Dga.lTab [ 2 ] = istPass.dwMaster.GetItemNumber ( 1, "ID_PROD" ) 

iuoGsSpGarantie.Uf_Traitement ( 4, stPass_Dga )

If	stPass_Dga.lTab [ 1 ] = 1 Then
	Wf_Changer_Controle ( stPass_Dga.dwNorm [ 1 ] )
End If

Return ( stPass_Dga.sTab [ 1 ] ) 




end function

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_W_Gar_Sin::Wf_PreparerValider
//* Auteur			: Erick John Stark
//* Date				: 28/01/1998 09:27:24
//* Libellé			: 
//* Commentaires	: On veut valider une garantie
//*
//* Arguments		: 
//*
//* Retourne		: Boolean		True	= La validation va continuer
//*										False = La validation s'arrete.
//*
//*-----------------------------------------------------------------

s_Pass stPass_Dga

stPass_Dga.bInsert = istPass.bInsert
iuoGsSpGarantie.Uf_Traitement ( 6, stPass_Dga )

Return ( True )

end function

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_W_Gar_Sin::Wf_PreparerSupprimer
//* Auteur			: Erick John Stark
//* Date				: 28/01/1998 09:27:24
//* Libellé			: 
//* Commentaires	: On veut supprimer la garantie
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

iuoGsSpGarantie.Uf_Traitement ( 10, stPass_Dga )

Return ( stPass_Dga.bRetour )

end function

private subroutine wf_fermer_consulter_paragraphe ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_W_Gar_Sin::Wf_Fermer_Consulter_Paragraphe (PRIVATE)
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
//* Fonction		: W_Tm_Sp_W_Gar_Sin::Wf_Tb_Consultation (PRIVATE)
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
//DataWindow dwNorm[2]
DataWindow dwNorm[]
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

// #1 - [DCMP090595]
cb_valid_factu.Visible 	= FALSE
cb_valid_factu.Enabled 	= FALSE

/*------------------------------------------------------------------*/
/* On initialise le tableau de DW pour la consultation EURO.        */
/*------------------------------------------------------------------*/

dwNorm [ 1 ] = dw_1
dwNorm [ 2 ] = dw_Lst_Detail

Uo_Consult_Euro.Uf_Initialiser ( dwNorm[] )


end subroutine

private function boolean wf_condition_ouverture ();//*-----------------------------------------------------------------
//*
//* Fonction      : dw_regle_coherence::wf_Condition_Ouverture (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 05/10/2004 14:40:47
//* Libellé       : Vérifier les conditions d'ouverture de détail si type d'app. TEL
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF     19/06/2006 DCMP060480 TELECOM1
//* #2    JFF     10/04/2007 DCMP070256 Fixer la val publique sur le sinistre
//* #3	 JCA		01/06/2007 DCMP 070304 Possibilité de mettre "sans suite" un détail de garantie si l'option 75 est paramétrée
//* #4    JFF     02/10/2007 [ALAPAGE]
//* #5	 JFF	   20/10/2008 [FNAC_PROD_ECH_TECH]
//* #6	 JFF	   20/10/2008 [FNAC_PROD_ECH_TECH].[20090123153948237] Suite demande de R.Peim en copil Fnac EPT
//* #7    JFF     10/06/2009 [RUEDUCOMMERCE]
//* #8    PHG     23/06/2009 [O2M_DIAG_NOMADE] Controle pour reprise dossier
//*                           antérieur process O2M sur C-Discount
//* #9    JFF     06/11/2009 [20091106201707453] Shunt du contrôle si Factu
//* #10	 PHG	   07/11/2010 [O2M_DIAG_NOMADE].Lot2 Généralisation du Controle pour reprise dossier
//*                           antérieur process O2M sur C-Discount et process similaire
//* #11   JFF     02/03/2010 [MSS_LOT2]
//        JFF     03/06/2010 [PC397/443_IPAD]
//*       JFF     22/10/2010 [PC10].[DP150]
//* 		 JFF     04/11/2010 [PC301].[LOT2]
//*       JFF     27/05/2011 [PC10].[DP150]
//*       JFF     05/01/2012 [RECUP_DONNEE_O2M]
//        JFF     14/11/2012 [VDOC9376]
//        JFF     07/05/2013 [PC946_ORANGE_OPPRO]
// 		 JFF     02/12/2013 [ITSM186841]
//        JFF     20/02/2014 [VDOC13754]
//        JFF     30/07/2014 [PM234-4_V1]
//		FPI	29/09/2014	[PC987]
//		JFF	15/09/2014	[OPTIM_IFR]
//       JFF   28/09/2015 [PM319-1]
//    JFF   06/04/2016 [ITSM374196]
//       JFF   07/06/2016 [DT227]
//       JFF   28/09/2016 [DT262]
//       JFF   12/12/2016 [DT269]
//       JFF   16/10/2018 [PC171999]
//       JFF   15/05/2019 [DT386_EXTR_AXA]
//       JFF   26/11/2019 [PC192290]
//       JFF   30/08/2021 [RS972][OPTIM_MB3&4]
//       JFF   11/05/2022  [RS2980_IFR]
//       JFF   06/04/2023 [PMO139_RS4926]
//       JFF   05/08/2024  [MCO602_PNEU]
//*-----------------------------------------------------------------

String sTypApp, sVal, sMarque, sModele, sIMEI, sIMEICorrige, sTypeApp, sIMEIOrigLu, sResult, sChaineBcv, sCodeRet
Long   lRow, lCodTel, lDeb, lFin, lVal, lRowDS, lRowDet, lIdGti, lCptDetPro, lRow1, lRow2, lIdSin, lVal1, lVal2, lVal3 
Decimal {2} dcMtValPub
Boolean bOk, bTelephonie, bAppSin, bAlimSin, bBattSin, bModeRempl, bAccSin, bRecupDonnee, bRecupMateriel, bVarOrange, bFin 
Integer iNatSinCplt
Int iAppSin, iAlimSin, iBattSin, iAccSin 	//* #5 [FNAC_PROD_ECH_TECH]
Int iMethode205 
Date dDteTicket
DateTime dtValDte 
// #3 
boolean bSansSuite
Boolean bDP150
n_cst_string lnvPFCString
DateTime dtCreeLeSin
DateTime dtDt1, dtDt2, dtDt3

dtCreeLeSin = idw_wSin.GetItemDateTime ( 1, "CREE_LE") // [DT227]

iNatSinCplt = 0
bDP150 = FALSE
bVarOrange = False 
sChaineBcv = ""

// [FNAC_PROD_ECH_TECH]
If isTypeTrt <> "S" Then Return True

// #11 [MSS_LOT2].[P3]
iAppSin = 0; iAlimSin =0; iBattSin =0 ; iAccSin = 0
bAppSin = FALSE ; bAlimSin = FALSE ; bBattSin = FALSE; bAccSin = False

bOk = True
bTelephonie = False
lCodTel = idwProduit.GetItemNumber ( 1, "COD_TEL" )

// Castorama
F_RechDetPro ( lDeb, lFin, idwDetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 43 )
If lDeb > 0 Then
	dDteTicket = Date(idwWDivSin.GetItemDateTime ( idwWDivSin.Find ( "NOM_ZONE = 'dte_ticket'", 1, idwWDivSin.RowCount () ), "VAL_DTE" )	) // [PI056].20190926
	If IsNull ( dDteTicket ) Or dDteTicket = 1900-01-01 Then
		stMessage.sTitre		= "Date achat/Date ticket"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "WGAR300"

		F_Message ( stMessage )
		ReTurn False
	End If 

	Return TRUE
End If

// #4
lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, idwWDivSin.RowCount () ) 
If lRow >0 Then 
	sTypApp = Upper ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) )
	If IsNull ( sTypApp ) Or Trim ( sTypApp ) = "" Then
		bOk = False
		stMessage.sTitre		= "Identification de l'appareil"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "WGAR320"

		F_Message ( stMessage )
		Return bOk
	End If
End If
// :#4

//* #5 [FNAC_PROD_ECH_TECH]
//* #7 [RUEDUCOMMERCE]
// 
If bOk Then 
	lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'APP_SIN'", 1, idwWDivSin.RowCount () ) 
	If lRow >0 Then 
		iAppSin = 1
		bAppSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
	End If

	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'ALIM_SIN'", 1, idwWDivSin.RowCount () )
	If lRow >0 Then 
		iAlimSin = 1
		bAlimSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
	End If

	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'BATT_SIN'", 1, idwWDivSin.RowCount () )
	If lRow >0 Then 
		iBattSin = 1
		bBattSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
	End If

// #11 [MSS_LOT2].[P3]
	lRow = idwWDivsin.Find ( "Upper (NOM_ZONE) = 'AUT_ACC_SIN'", 1, idwWDivSin.RowCount () )
	If lRow >0 Then 
		iAccSin = 1
		bAccSin = Upper ( Trim ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) ) = "O"
	End If
// :#11 [MSS_LOT2].[P3]

	// 0 : zones absentes
	// 1 : zones présentes, mais non renseignée
	// 2 : zones présentes et renseignées 
	If iNatSinCplt < 2 And iAppSin= 1 Then
		If Not bAppSin Then 
// #11 [MSS_LOT2].[P3]
//			If iNatSinCplt < 2 Then iNatSinCplt = 1
			iNatSinCplt = 1
// :#11 [MSS_LOT2].[P3]			
		Else
			iNatSinCplt = 2
		End If
	End If

	If iNatSinCplt < 2 And iAlimSin = 1 Then
		If Not bAlimSin Then
// #11 [MSS_LOT2].[P3]
//			If iAlimSin < 2 Then iNatSinCplt = 1
			iNatSinCplt = 1			
// :#11 [MSS_LOT2].[P3]			
		Else
			iNatSinCplt = 2
		End If	
	End If

	If iNatSinCplt < 2 And iBattSin = 1 Then
		If Not bBattSin Then
// #11 [MSS_LOT2].[P3]
//			If iBattSin < 2 Then iNatSinCplt = 1
			iNatSinCplt = 1
// :#11 [MSS_LOT2].[P3]			
		Else
			iNatSinCplt = 2
		End If			
	End If

// #11 [MSS_LOT2].[P3]
	If iNatSinCplt < 2 And iAccSin = 1 Then
		If Not bAccSin Then
			iNatSinCplt = 1
		Else
			iNatSinCplt = 2
		End If			
	End If	
// :#11 [MSS_LOT2].[P3]
	
	If iNatSinCplt = 1 Then
		bOk = False
		stMessage.sTitre		= "Identification de l'appareil"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "WGAR345"
	
		F_Message ( stMessage )
		Return bOk
	End If
	
//* #7 [RUEDUCOMMERCE]
// #11 [MSS_LOT2].[P3]
	If ( bAppSin And iAppSin= 1 ) And &
	 	( ( bAlimSin And iAlimSin = 1 )  Or ( bBattSin And iBattSin = 1 ) Or ( bAccSin And iAccSin = 1 ) ) Then
//	If bAppSin And ( ( bAlimSin )  Or ( bBattSin ) ) Then
		bOk = False
		stMessage.sTitre		= "Identification de l'appareil"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "WGAR350"
	
		F_Message ( stMessage )
		Return bOk
	End If

// #11 [MSS_LOT2].[P3]
	If ( ( bAlimSin And iAlimSin = 1 )  Or ( bBattSin And iBattSin = 1 ) ) And ( bAccSin And iAccSin = 1 ) Then

		bOk = False
		stMessage.sTitre		= "Identification de l'appareil"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "WGAR355"
	
		F_Message ( stMessage )
		Return bOk
	End If
// :#11 [MSS_LOT2].[P3]

End If
//* :#5 [FNAC_PROD_ECH_TECH]


// [PC171999]
lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'PERSONNE_SIN'", 1, idwWDivSin.RowCount () ) 
If lRow >0 Then 
	sVal = Upper ( idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) )
	If IsNull ( sVal ) Or Trim ( sVal ) = "" Then
		bOk = False
		stMessage.sTitre		= "PC171999"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "WGAR417"
		F_Message ( stMessage )
		Return bOk
	End If
End If


// Téléphonie
/*------------------------------------------------------------------*/
/* Aucun Référentiel, donc on permet l'ouverture dans tous les cas. */
/*------------------------------------------------------------------*/
If isReferentiel = "" Then Return TRUE

Choose Case isReferentiel 
	Case "IFR"
		sMarque = Trim ( idw_wSin.GetItemString ( 1, "MARQ_PORT2" ))
		sModele = Trim ( idw_wSin.GetItemString ( 1, "MODL_PORT2" ))
      dcMtValPub = 0
		
      bOk = Not ( IsNull ( sMarque ) Or sMarque = "" Or IsNull ( sModele ) Or sModele = "" )
		
		// [PC397/443_IPAD]
		Choose Case sTypApp
			Case "TEL", "PC1", "PC2", "PC3"
				bTelephonie = True
			Case Else
				bTelephonie = False
		End Choose
		// [PC397/443_IPAD]

		If bOk Then
			lRow = idwStkIfr.Find ( "MARQUE = Upper ('" + sMarque + "') AND REFERENCE = Upper ('" + sModele + "')", 1, idwStkIfr.RowCount() )

			//#2 y a-t-il déjà eu un détail instruit avec un VP > 0
			lRowDet = dw_Lst_Detail.Find ( "MT_VAL_PUBLIQUE > 0", 1, dw_Lst_Detail.RowCount () )
			If lRowDet > 0 Then
				dcMtValPub = dw_Lst_Detail.GetItemDecimal ( lRowDet, "MT_VAL_PUBLIQUE" )
			End IF

			// [PC10].[DP150]
			// [RS972][OPTIM_MB3&4]
			F_RechDetPro ( lDeb, lFin, idwDetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 150 )
			If lDeb > 0 Then

				// [PM319-1]				
				sChaineBcv = idwDetPro.GetItemString ( lDeb, "VAL_CAR" )
				sVal = lnvPFCString.of_getkeyvalue (sChaineBcv, "VARIANTE", ";")
				bVarOrange = sVal = "PRIX_ORANGE"
				
				// [RS972][OPTIM_MB3&4] V02
				lnvPFCString.of_Setkeyvalue ( sChaineBcv, "TYP_APP", sTypApp, ";")
				
				// [PM319-1]
				If Not bVarOrange Then
					// Armement dcMtValPub 
					// [RS972][OPTIM_MB3&4] V02
					SQLCA.PS_S01_ARTICLE_DP150_V02 (idw_WSin.GetItemNumber ( 1, "ID_PROD" ), sMarque, sModele, dcMtValPub, sChaineBcv )
	
					If dcMtValPub = 0 Then
						bDP150 = TRUE
	
						// [VDOC13754]
						If Not iuoGsSpGarantie.uf_getautorisation( 208 ) Then
						
							stMessage.sTitre		= "Valeur Publique Fournisseur Absente (PC10/Lisette Small)"
							stMessage.Icon			= Information!
							stMessage.bErreurG	= FALSE
							stMessage.Bouton		= OK!
							stMessage.sVar[1]		= sMarque + " " + sModele 
							stMessage.sCode		= "WGAR380"
					
							F_Message ( stMessage )
						End If
					End If
				End If
			End If

			/*------------------------------------------------------------------*/
			/* Mobile trouvé/non trouvé, donc on ne permet ou pas l'ouverture.  */
			/*------------------------------------------------------------------*/
			bOk = lRow > 0 
			
			// #2 mémorisation de la VPublique sur le sinistre
			If bOk Then
				
				// [PC10].[DP150]
				If ( dcMtValPub = 0 Or IsNull ( dcMtValPub )) And Not bDP150 Then
					dcMtValPub = idwStkIfr.GetItemDecimal ( lRow, "FREQUENCE" )
					
					// [RS2980_IFR]
					gsCodeRetPrixIfr = "" // On réinitialise puisqu'on rappelle

					sCodeRet = Space ( 20 )

					SQLCA.PS_U_MARQUAGE_PRIX_IFR_A_REVOIR ( sMarque, sModele, sCodeRet ) 
					F_Commit ( SQLCA, SQLCA.SqlCode = 0 And SQLCA.SqlDBCode = 0)


					If sCodeRet = "URGE" Then
						dcMtValPub = 0
	
						gsCodeRetPrixIfr = sCodeRet
						
						bFin = False
						Do While Not bFin
							stMessage.sTitre		= "RS2980 : Prix IFR à revoir"
							stMessage.Icon			= Exclamation!
							stMessage.bErreurG	= FALSE
							stMessage.Bouton		= YESNO!
							stMessage.sCode		= "WSIN882"
							stMessage.sVar[1]    = sMarque
							stMessage.sVar[2]    = sModele		
							
							If Time (Today()) < 14:00:00 Then
								stMessage.sVar[3] = "aujourd'hui"
								stMessage.sVar[4] = "15"									
							Else
								stMessage.sVar[3] = "demain"
								stMessage.sVar[4] = "10"									
							End If 
							
							If F_Message ( stMessage ) = 1 Then bFin = TRUE
						Loop
						
					End if 
						
					// /[RS2980_IFR]						
					
					
				End If
				
				lRowDS = idwWDivSin.Find ( "NOM_ZONE = 'mt_val_publique'", 1, idwWDivSin.RowCount () )				
				If lRowDS <= 0 Then
					lRowDS = idwwDivSin.InsertRow (0)
		
					idwwDivSin.SetItem ( lRowDS, "ID_SIN", idw_wSin.GetItemNumber ( 1, "ID_SIN" ) )
					idwwDivSin.SetItem ( lRowDS, "NOM_ZONE", "mt_val_publique" )
					idwwDivSin.SetItem ( lRowDS, "LIB_LABEL", "Valeur publique de l'appareil" )
					idwwDivSin.SetItem ( lRowDS, "ID_TYP_LISTE", "-XX" )
					idwwDivSin.SetItem ( lRowDS, "ALT_LISTE_CODECAR", "N")
					idwwDivSin.SetItem ( lRowDS, "ID_TYP_ZONE", "S" )
					idwwDivSin.SetItem ( lRowDS, "ALT_OBLIG", "N" )
					idwwDivSin.SetItem ( lRowDS, "ALT_PROT", "O" )
					idwwDivSin.SetItem ( lRowDS, "CPT_TRI", 500 )
					idwwDivSin.SetItem ( lRowDS, "VAL_DTE", stNul.dtm )	// [PI056].20190926
					idwwDivSin.SetItem ( lRowDS, "VAL_CAR", stNul.str )
					idwwDivSin.SetItem ( lRowDS, "VAL_NBRE", stNul.lng )
					idwwDivSin.SetItem ( lRowDS, "VAL_MT", dcMtValPub )
					idwwDivSin.SetItem ( lRowDS, "ALT_SUPP", "N" )
					idwwDivSin.SetItem ( lRowDS, "CREE_LE", DateTime ( Today (), Now () ) )
					idwwDivSin.SetItem ( lRowDS, "MAJ_LE", DateTime ( Today (), Now () ) )
					idwwDivSin.SetItem ( lRowDS, "MAJ_PAR", stGlb.sCodOper )

				Else 
					If idwwDivSin.GetItemDecimal ( lRowDS, "VAL_MT" ) = 0 Then
						idwwDivSin.SetItem ( lRowDS, "VAL_MT", dcMtValPub )

						idwwDivSin.SetItem ( lRowDS, "ALT_SUPP", "N" )						
						idwwDivSin.SetItem ( lRowDS, "MAJ_LE", DateTime ( Today (), Now () ) )
						idwwDivSin.SetItem ( lRowDS, "MAJ_PAR", stGlb.sCodOper )
					End If
				End If
				
				idwwDivSin.Sort ()
				
			End If 
			// Fin #2
		End If

	Case "REF_CODIC_DARTY"
		sMarque = Trim ( idw_wSin.GetItemString ( 1, "MARQ_PORT3" ))
		sModele = Trim ( idw_wSin.GetItemString ( 1, "MODL_PORT3" ))
		sTypeApp = idwWDivSin.GetItemString ( idwWDivSin.Find ( "NOM_ZONE = 'type_app'", 1, idwWDivSin.RowCount () ), "VAL_LST_CAR" )

		bOk = Not ( IsNull ( sMarque ) Or sMarque = "" Or IsNull ( sModele ) Or sModele = "" )

		If bOk Then
			lRow = idwStkCodicDarty.Find ( "MARQUE = Upper ('" + sMarque + "') AND MODELE = Upper ('" + sModele + "') AND TYPE_APP = '" + sTypeApp + "'", 1, idwStkCodicDarty.RowCount() )

			/*------------------------------------------------------------------*/
			/* Appareil trouvé/non trouvé, donc on ne permet ou pas l'ouverture.*/
			/*------------------------------------------------------------------*/
			bOk = lRow > 0 
		End If

	Case "REF_SIMPA2_CODE_MB"
		sMarque = Trim ( idw_wSin.GetItemString ( 1, "MARQ_PORT" ))
		sModele = Trim ( idw_wSin.GetItemString ( 1, "MODL_PORT" ))

		bOk = Not ( IsNull ( sMarque ) Or sMarque = "" Or IsNull ( sModele ) Or sModele = "" )

		If bOk Then
			// [DT386_EXTR_AXA]
			If F_CLE_A_TRUE ( "DT386_EXTR_AXA" ) Then
				F_RechDetPro ( lDeb, lFin, idwDetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 336 )
				If lDeb > 0 Then
					bOk =True
				Else
					lRow = idwStkCodeMB.Find ( "LIB_CODE = Upper ('" + sMarque + "')", 1, idwStkCodeMB.RowCount() )
		
					/*------------------------------------------------------------------*/
					/* Appareil trouvé/non trouvé, donc on ne permet ou pas l'ouverture.*/
					/*------------------------------------------------------------------*/
					bOk = lRow > 0 
				End If 			
			Else			
				lRow = idwStkCodeMB.Find ( "LIB_CODE = Upper ('" + sMarque + "')", 1, idwStkCodeMB.RowCount() )
	
				/*------------------------------------------------------------------*/
				/* Appareil trouvé/non trouvé, donc on ne permet ou pas l'ouverture.*/
				/*------------------------------------------------------------------*/
				bOk = lRow > 0 
			End If 
		End If

/*------------------------------------------------------------------*/
/* Autre																				  */
/*------------------------------------------------------------------*/
	Case Else

		sMarque = Trim ( idw_wSin.GetItemString ( 1, "MARQ_PORT" ))
		sModele = Trim ( idw_wSin.GetItemString ( 1, "MODL_PORT" ))

		bOk = Not ( IsNull ( sMarque ) Or sMarque = "" Or IsNull ( sModele ) Or sModele = "" )

End Choose 

// [DT227]
F_RechDetPro ( lDeb, lFin, idwDetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 299 )	
If lDeb > 0 And Not bOk Then
	// JFF 07/06/2016 [DT227]
	SQLCA.PS_S_DATE_PIVOT ( "DT227", dtDt1, dtDt2, dtDt3 ) 
			
	If dtCreeLeSin < dtDt1 Then
		bOk = TRUE
	End If 
End If


If Not bOk Then
		stMessage.sTitre		= "Identification du mobile"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "IFR0050"

		F_Message ( stMessage )
End If 

If bOk And bTelephonie Then bOk = This.wf_Condition_Tac ()

sIMEI = idw_wSin.GetItemString ( 1, "NUM_IMEI_PORT" )
sIMEIOrigLu = Trim ( idw_wSin.GetItemString ( 1, "NUM_IMEI_PORT", Primary!, TRUE ) )

/*------------------------------------------------------------------*/
/* Traitement des TELEPHONES                                        */
/*------------------------------------------------------------------*/
If bOk And bTelephonie And lCodTel > 0 Then
	// Validité IMEI
	If bOk And ( sIMEIOrigLu <> Fill ( "0", 15 ) Or Date ( idw_wSin.GetItemDateTime ( 1, "CREE_LE") ) > 2006-02-01 ) Then
		
		F_RechDetPro ( lDeb, lFin, idwDetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 75 )
		if lDeb > 0 then
			bSansSuite = true
		end if
		// #3 - FIN

		If Not F_IMEI ( sIMEI, sIMEICorrige ) and not bSansSuite Then // #3 ajout de [not bSansSuite]

			// [DT262]
			F_RechDetPro ( lDeb, lFin, idwDetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 308 )
			If lDeb <= 0 Or ( lDeb > 0 And sIMEI <> "" And Not IsNull ( sIMEI ) ) Then
				bOk = False
				stMessage.sTitre		= "Identification du mobile"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "IFR0080"
		
				F_Message ( stMessage )
			End If
		End If
	End If
End If

// #10 [O2M_DIAG_NOMADE].Lot2 Généralisation du Controle Ci-dessous.
// #8 [O2M_DIAG_NOMADE] Controle pour reprise dossier antérieur process O2M sur C-Discount
// #9 [20091106201707453] Shunt du contrôle si Factu
F_RechDetPro ( lDeb, lFin, idwDetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 25 )
if bOk and lDeb > 0 And Not iuoGsSpGarantie.uf_getautorisation( 208 ) Then
	// Si Option 25 et Type Appareil  'Autre' non présent en paramétrage det_pro
	if idwdetpro.Find ( "ID_PROD="+string(idw_WSin.GetItemNumber( 1, "ID_PROD" ))+&
							" AND ID_CODE_DP=25" + &
							" AND UPPER(ID_CODE_CAR)= 'AUT'", lDeb, lFin ) = 0 Then
		// Et Si Type Appareil du dossier  ='Autre' Alors Obligation de régulariser le dossier.
		lRow = idwWDivSin.Find ( "UPPER(NOM_ZONE )= 'TYPE_APP'", 1, idwWDivSin.RowCount () )
		If lRow > 0 Then
			sVal = idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" )   
			If sVal = "AUT" Then
				bOk = False
				stMessage.sTitre      = "Régularisation de dossier"
				stMessage.Icon         = Information!
				stMessage.bErreurG   = FALSE
				stMessage.Bouton      = OK!
				stMessage.sCode      = "WSIN680" // [O2M_DIAG_NOMADE] Message : Vous devez régulariser ce dossier
															// en choisissant un type d'appareil précis.
															// ATTENTION : Choisissez bien, car une fois validé
															// aucune modification ultérieur ne sera possible.
				F_Message ( stMessage )
			End If
		End If
	End If
End If

// :#8 [O2M_DIAG_NOMADE]
// #1 : Gestion du filtre pour BTP TELECOM 1 060480
F_RechDetPro ( lDeb, lFin, idwDetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 56 )
If bOk And lDeb > 0 Then
	lRow = idwWDivSin.Find ( "NOM_ZONE = 'choix_pack'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then
		sVal = idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" )	
		If IsNull ( sVal ) OR sVal = "" Then
			bOk = False
			stMessage.sTitre		= "Choix du pack"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WGAR310"
	
			F_Message ( stMessage )
		End If 
	End If
End If

// [VDOC9376]
F_RechDetPro ( lDeb, lFin, idwDetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 226 )
If bOk And lDeb > 0 Then
	lRow = idwWDivSin.Find ( "NOM_ZONE = 'typapp_rec_neu'", 1, idwWDivSin.RowCount () )
	If lRow > 0 Then
		sVal = idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" )	
		If IsNull ( sVal ) OR sVal = "" Then
			bOk = False
			stMessage.sTitre		= "Reconditionné/Neuf"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WGAR396"
	
			F_Message ( stMessage )
		End If 
	End If
End If
// :[VDOC9376]

// [PC301].[LOT2]
F_RechDetPro ( lDeb, lFin, idwDetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 152 )
If bOk And lDeb > 0 Then
	lVal = idw_wSin.GetItemNumber ( 1, "ID_ORIAN_BOUTIQUE" )
	
	If IsNull ( lVal ) Then
		bOk = False
		stMessage.sTitre		= "Boutique"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "WGAR365"

		F_Message ( stMessage )
	End If
	
	// [PMO139_RS4926]
	If F_CLE_A_TRUE ( "PMO139_RS4926" ) Then
		sChaineBcv = idwDetPro.GetItemString ( lDeb, "VAL_CAR" )
		sVal = lnvPFCString.of_getkeyvalue (sChaineBcv, "PMO139", ";")
		If sVal = "OUI" Then
			sTypeApp = idwWDivSin.GetItemString ( idwWDivSin.Find ( "NOM_ZONE = 'type_app'", 1, idwWDivSin.RowCount () ), "VAL_LST_CAR" )
			sVal = idwWDivSin.GetItemString ( idwWDivSin.Find ( "NOM_ZONE = 'taille_tv'", 1, idwWDivSin.RowCount () ), "VAL_LST_CAR" )
			If sTypeApp = "TLC" and ( IsNull ( sVal ) or sVal = "" Or sVal = "AUC" ) Then
				bOk = False
				stMessage.sTitre		= "Taille TV"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WGAR436"
		
				F_Message ( stMessage )
			End IF 
		End IF 
	End If
	
	
End If

If bOk Then
	
	F_RechDetPro ( lDeb, lFin, idwDetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 141 )
	If lDeb > 0 Then
		sChaineBcv = idwDetPro.GetItemString ( lDeb, "VAL_CAR" )
		sVal = lnvPFCString.of_getkeyvalue (sChaineBcv, "EXCLU_CTRLE_EAN", ";")
	End If
	
	lRow = idwWDivSin.Find ( "NOM_ZONE = 'code_ean'", 1, idwWDivSin.RowCount () )
	If lRow > 0 And ( lDeb <= 0 Or ( lDeb > 0 And sVal <> "OUI" )) Then
		sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" )	
		If IsNull ( sVal ) OR sVal = "" Then
			bOk = False
			stMessage.sTitre		= "code EAN"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WGAR370"
	
			F_Message ( stMessage )
		End If 
	End If
	
End If
// :[PC301].[LOT2]

// [RECUP_DONNEE_O2M]
F_RechDetPro ( lDeb, lFin, idwDetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 205 )
If lDeb > 0 Then
	iMethode205 = Integer ( lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( lDeb, "VAL_CAR" ), "METHODE", ";")) 
	lIdGti = dw_1.GetItemNumber ( 1, "ID_GTI" ) 

	lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'RECUP_DONNEES'", 1, idwWDivSin.RowCount () ) 
	If lRow >0 Then 
		bRecupDonnee = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) = "O"
	Else
		bOk = False
	End If

	If Not bOk Then
		stMessage.sTitre		= "Problème de paramètrage"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "WGAR390"
		stMessage.sVar[1]		= "recup_donnees"

		F_Message ( stMessage )
	End If

	If bOk Then 
		lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'RECUP_MATERIEL'", 1, idwWDivSin.RowCount () ) 
		If lRow >0 Then 
			bRecupMateriel = idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) = "O"
		Else
			bOk = False
		End If

		If Not bOk Then
			stMessage.sTitre		= "Problème de paramètrage"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WGAR390"
			stMessage.sVar[1]		= "recup_materiel"
	
			F_Message ( stMessage )
		End If
	End If	
		
	If bOk Then 	
		
		Choose case lIdGti
			Case 10
				If bRecupDonnee Or bRecupMateriel Then
					bOk = False
					stMessage.sTitre		= "Contrôle de données "
					stMessage.Icon			= Information!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= OK!
					stMessage.sCode		= "WGAR391"
					F_Message ( stMessage )						
				End IF

			Case 44		
				If Not bRecupDonnee Then
					bOk = False
					stMessage.sTitre		= "Contrôle de données "
					stMessage.Icon			= Information!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= OK!
					stMessage.sCode		= "WGAR392"
					F_Message ( stMessage )						
				End IF
				
			Case 11
				If bRecupMateriel Then
					bOk = False
					stMessage.sTitre		= "Contrôle de données "
					stMessage.Icon			= Information!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= OK!
					stMessage.sCode		= "WGAR393"
					F_Message ( stMessage )						
				End IF
			
			Case Else				
				If bRecupMateriel Then
					bOk = False
					stMessage.sTitre		= "Contrôle de données "
					stMessage.Icon			= Information!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= OK!
					stMessage.sCode		= "WGAR393"
					F_Message ( stMessage )						
				End IF
		End Choose
	End If
	
	If bOk and iMethode205 = 2 Then
		lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, idwWDivSin.RowCount () ) 
		If lRow >0 Then 
			sTypeApp = idwWDivSin.GetItemString ( lRow, "VAL_CAR" )
			sMarque = Trim ( idw_wSin.GetItemString ( 1, "MARQ_PORT" ))
			sModele = Trim ( idw_wSin.GetItemString ( 1, "MODL_PORT" ))

			If Not ( sTypeApp = "TEL" And sMarque = "APPLE" And Pos ( sModele, "IPHONE" ) > 0 ) And ( bRecupDonnee ) Then
				bOk = False
				stMessage.sTitre		= "Contrôle de données "
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WGAR394"
				F_Message ( stMessage )						
				
			End If
		End If
	End If
	
	If bOk And bRecupMateriel And Not bRecupDonnee Then
		bOk = False
		stMessage.sTitre		= "Contrôle de données "
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "WGAR395"
		F_Message ( stMessage )						
	End If
	
End If
// [RECUP_DONNEE_O2M]

/*------------------------------------------------------------------*/
/* Traitement des AUTRES APP.                                       */
/*------------------------------------------------------------------*/
// [DT262]
If IsNull ( sIMEI ) Then sIMEI = ""

F_RechDetPro ( lDeb, lFin, idwDetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 308 )

If bOk And Not bTelephonie And lCodTel > 0 And Trim ( sIMEI ) = "" And lDeb <= 0 Then
	bOk = False
	stMessage.sTitre		= "Identification de l'appareil"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sCode		= "IFR0081"

	F_Message ( stMessage )
End If

// [PC946_ORANGE_OPPRO]
lRow = idwWDivSin.Find ( "NOM_ZONE = 'lieu_livraison'", 1, idwWDivSin.RowCount () )
If bOk And lRow > 0 Then
	sVal = idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" )	
	If IsNull ( sVal ) OR sVal = "" Then
		bOk = False
		stMessage.sTitre		= "Lieu livraison"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "WGAR401"

		F_Message ( stMessage )
	End If 
End If

lRow = idwWDivSin.Find ( "NOM_ZONE = 'lieu_livraison'", 1, idwWDivSin.RowCount () )
If bOk And lRow > 0 Then
	sVal = idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" )	
	If sVal = "PSM" Then		
		lRow = idwWDivSin.Find ( "NOM_ZONE = 'btq_psm'", 1, idwWDivSin.RowCount () )			
		If lRow > 0 Then
			lVal = idwWDivSin.GetItemNumber ( lRow, "VAL_NBRE" )
			If IsNull ( lVal ) Then lVal = 0
			If lVal = 0  Then
				bOk = False
				stMessage.sTitre		= "Lieu livraison"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WGAR402"
		
				F_Message ( stMessage )	
			End If
		End If				
	End If			
End If		

lRow = idwWDivSin.Find ( "NOM_ZONE = 'lieu_livraison'", 1, idwWDivSin.RowCount () )
If bOk And lRow > 0 Then
	sVal = idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" )	
	If sVal = "LPR" Then		
		lRow = idwWDivSin.Find ( "NOM_ZONE = 'lprof_civ'", 1, idwWDivSin.RowCount () )			
		If lRow > 0 Then
			lVal = idwWDivSin.GetItemNumber ( lRow, "VAL_NBRE" )

			// [ITSM186841]
			lVal = lVal / 1000  // car seconde liste -C1
			
			If IsNull ( lVal ) Then lVal = 0				
			If lVal = 0 Then
				bOk = False
				stMessage.sTitre		= "Lieu livraison"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WGAR403"
				stMessage.sVar[1] 	= "une civilité"
				F_Message ( stMessage )	
			End If
		End If				
		
		lRow = idwWDivSin.Find ( "NOM_ZONE = 'lprof_nom'", 1, idwWDivSin.RowCount () )			
		If bOk And lRow > 0 Then
			sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" )
			If IsNull ( sVal ) Or Trim ( sVal ) = "" Then
				bOk = False
				stMessage.sTitre		= "Lieu livraison"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WGAR403"
				stMessage.sVar[1] 	= "un nom"			
				F_Message ( stMessage )	
			End If
		End If				
		
		lRow = idwWDivSin.Find ( "NOM_ZONE = 'lprof_prenom'", 1, idwWDivSin.RowCount () )			
		If bOk And lRow > 0 Then
			sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" )
			If IsNull ( sVal ) Or Trim ( sVal ) = "" Then
				bOk = False
				stMessage.sTitre		= "Lieu livraison"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WGAR403"
				stMessage.sVar[1] 	= "un prénom"			
				F_Message ( stMessage )	
			End If
		End If				

		lRow = idwWDivSin.Find ( "NOM_ZONE = 'lprof_adr1'", 1, idwWDivSin.RowCount () )			
		If bOk And lRow > 0 Then
			sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" )
			If IsNull ( sVal ) Or Trim ( sVal ) = "" Then
				bOk = False
				stMessage.sTitre		= "Lieu livraison"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WGAR403"
				stMessage.sVar[1] 	= "la première ligne d'adresse"			
				F_Message ( stMessage )	
			End If
		End If		
		
		lRow = idwWDivSin.Find ( "NOM_ZONE = 'lprof_adrcp'", 1, idwWDivSin.RowCount () )			
		If bOk And lRow > 0 Then
			sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" )
			If IsNull ( sVal ) Or Trim ( sVal ) = "" Then
				bOk = False
				stMessage.sTitre		= "Lieu livraison"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WGAR403"
				stMessage.sVar[1] 	= "le code postal"			
				F_Message ( stMessage )	
			End If
		End If	

		lRow = idwWDivSin.Find ( "NOM_ZONE = 'lprof_adrville'", 1, idwWDivSin.RowCount () )			
		If bOk And lRow > 0 Then
			sVal = idwWDivSin.GetItemString ( lRow, "VAL_CAR" )
			If IsNull ( sVal ) Or Trim ( sVal ) = "" Then
				bOk = False
				stMessage.sTitre		= "Lieu livraison"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WGAR403"
				stMessage.sVar[1] 	= "la ville"			
				F_Message ( stMessage )	
			End If
		End If			
		
	End If			
End If	
// [PC946_ORANGE_OPPRO]

// [PM234-4_V1]
F_RechDetPro ( lDeb, lFin, idwDetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 94 )

For lCptDetPro = lDeb To lFin
	sVal = lnvPFCString.of_getkeyvalue ( idwDetPro.GetItemString ( lCptDetPro, "VAL_CAR" ), "COD_DW", ";")
	
	Choose Case sVal 
		Case "ORANGE_V2BIS"

			lRow = idwWDivSin.Find ( "NOM_ZONE = 'decla_atlas' AND VAL_CAR = 'O'", 1,  idwWDivSin.RowCount () )

			lRow2 = idwWDivSin.Find ( "NOM_ZONE = 'dcnx_decla_atlas' AND VAL_CAR = 'O'", 1,  idwWDivSin.RowCount () )
			If lRow2 > 0 Then lRow = 0				
			
			lRow1 = idwWDivSin.Find ( "NOM_ZONE = 'fin_script' AND VAL_CAR = 'O'", 1,  idwWDivSin.RowCount () )
			If lRow > 0 And lRow1 <= 0 Then 
				bOk = False
				stMessage.sTitre		= "Orange V2/V2BIS"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "P234011"
				F_Message ( stMessage )										
			End If
			
	End Choose
Next
// [PM234-4_V1]

// [PC987]
If bOk Then
	lRow=idwWDivSin.Find("NOM_ZONE='ass_pro_tva' And VAL_CAR='O'",1,idwWDivSin.RowCount())
	If lRow > 0 Then
		stMessage.sTitre		= "Assuré PRO assujetti à la TVA"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "WGAR406"
		F_Message ( stMessage )	
	End if
End if	

// [OPTIM_IFR]
lIdSin = idw_wSin.GetItemNumber ( 1, "ID_SIN" )
sMarque = idw_wSin.GetItemString ( 1, "MARQ_PORT" )
sModele = idw_wSin.GetItemString ( 1, "MODL_PORT" )
lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, idwWDivSin.RowCount () ) 
If lRow >0 Then 
	sTypApp = Upper ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) )
End If

If IsNull ( sMarque ) Then sMarque = ""
If IsNull ( sModele ) Then sModele = ""
If IsNull ( sTypApp ) Then sTypApp = ""

lVal1 = idw_LstInter.Find ( "MT_REG >0 OR MT_A_REG >0", 1, idw_LstInter.RowCount ())
lVal2 = idw_LstCmdeSin.RowCount ()
lVal3 = idw_DivDetSin.Find ( "UPPER ( NOM_ZONE ) = 'PEC' AND VAL_CAR = 'O'", 1, idw_DivDetSin.RowCount () )

If lVal1 <= 0 And lVal2 <=0 And lVal3 <=0 Then

	sResult = space ( 50 )
	SQLCA.PS_S_VERIF_TYPE_MARQ_MODL ( lIdSin, sMarque, sModele, sTypApp, sResult ) 

	If sResult = 'TYPE_APP_DIFF_MARQ_MODL_IFR' Then
		bOk = False
		stMessage.sTitre		= "Marq/Modl IFR"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "WGAR407"
		F_Message ( stMessage )
	End If
End If

// [DT227]
F_RechDetPro ( lDeb, lFin, idwDetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 299 )	
If lDeb > 0 Then
	// JFF 07/06/2016 [DT227]
	SQLCA.PS_S_DATE_PIVOT ( "DT227", dtDt1, dtDt2, dtDt3 ) 
			
	If dtCreeLeSin >= dtDt1 Then
		lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'LIEU_REPAR'", 1, idwWDivSin.RowCount () ) 
		If lRow >0 Then 
			sVal = Upper ( idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) )
			If IsNull ( sVal ) Or Trim ( sVal ) = "" Then
				bOk = False
				stMessage.sTitre		= "Centre auto"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= FALSE
				stMessage.Bouton		= OK!
				stMessage.sCode		= "WGAR414"
				F_Message ( stMessage )
			End If
		End If

		// [MCO602_PNEU]
		If F_CLE_A_TRUE ( "MCO602_PNEU" ) Then
			lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'TYP_PRESTA'", 1, idwWDivSin.RowCount () ) 
			If lRow >0 Then 
				sVal = Upper ( idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) )
				If IsNull ( sVal ) Or Trim ( sVal ) = "" Then
					bOk = False
					stMessage.sTitre		= "Type prestation "
					stMessage.Icon			= Information!
					stMessage.bErreurG	= FALSE
					stMessage.Bouton		= OK!
					stMessage.sCode		= "WGAR439"
					F_Message ( stMessage )
				End If
			End If 
		End If
		
	End If

End If

// [DT269]
If F_CLE_A_TRUE ( "DT269" ) Then
	If bOk Then
		bOk = This.wf_Condition_Ouverture_DT269 ( )
	End If
End If

// [DT386_EXTR_AXA]
If F_CLE_A_TRUE ( "DT386_EXTR_AXA" ) Then
	If bOk Then
		bOk = This.wf_Condition_Ouverture_DT386 ( )
	End If
End If

// [PC192290]
F_RechDetPro ( lDeb, lFin, idwDetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 10 )
If lDeb > 0 Then
	dtValDte = idw_wSin.GetItemDateTime ( 1, "DTE_ACH_PORT" ) 
	If IsNull ( dtValDte ) Or Date ( dtValDte ) = 1900-01-01 Then
		stMessage.sTitre		= "Date achat"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "WGAR433 "

		F_Message ( stMessage )
		bOk = False
	End If 
End If

Return bOk

end function

private function boolean wf_condition_tac ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_tm_sp_w_gar_sin::wf_Condition_Tac (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 02/09/2003 15:04:10
//* Libellé       : Contrôle du TAC_IMEI
//* Commentaires  : 
//*
//* Arguments     : 
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*  #1   MADM    23/06/2006  DCMP 060491 : Gestion des TAC IMEI sur 8 chiffres au lieu de 6
//*  #2	 PHG	   13/09/2007 [DCMP070612] : PAs de controle Tac/Imei en role 208
//* #3	FPI	15/01/2010	[DCMP100022] Refone du message GENE130
//*-----------------------------------------------------------------

String	sTacImei, sMarqTacTmp, sImeiCorrige
String	sMarqPort, sMarqTAC, sModlTAC
Long 		lTotTAC, lRow, lDeb, lFin
Integer	iPosD, iPosF, iRet
Boolean	bOk

bOk = True

// #2 [DCMP070612]
if iuoGsSpGarantie.uf_getautorisation( 208 ) Then Return True

// Déconnexion du Ctrl TAC option 17 ?
F_RechDetPro ( lDeb, lFin, idwDetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 17 )
If lDeb > 0 Then Return TRUE

If Not F_IMEI ( Trim ( idw_wsin.GetItemString ( 1, "NUM_IMEI_PORT" )), sImeiCorrige ) Then Return True

/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/

sTacImei = Left ( Trim ( idw_wsin.GetItemString ( 1, "NUM_IMEI_PORT" )) , 8 )
sMarqPort = Trim ( Upper ( idw_wsin.GetItemString ( 1, "MARQ_PORT" ) ) )

If sTacImei = "00000000" Then Return TRUE

/*------------------------------------------------------------------*/
/* On ne fait le contrôle de cohérence que si les deux zones sont   */
/* renseignées.                                                     */
/*------------------------------------------------------------------*/
If IsNull ( sMarqPort ) Or sMarqPort = "" Or IsNull ( sTacImei ) Or sTacImei = "" Then Return TRUE

sMarqTac = Fill ( " ", 35 )
sModlTac = Fill ( " ", 35 )
// SQLCA.PS_S01_TAC_IMEI ( long ( sTacImei), sMarqTAC, sModlTAC )

/*------------------------------------------------------------------*/
/* TAC Trouvé dans la base.                                         */
/*------------------------------------------------------------------*/
If Trim ( sMarqTAC ) <> "" Then

	/*------------------------------------------------------------------*/
	/* Mais le TAC ne correspond pas à la Marque.                       */
	/*------------------------------------------------------------------*/
	If sMarqPort <> sMarqTac Then

  		iPosD = 1
		//tant qu'un # sera trouvé ...
		Do While iPosD > 0 
 			iPosD = Pos ( sMarqTac , "#", iPosD ) 
			If iPosD > 0 Then
				iPosF = Pos ( sMarqTac , "#", iPosD + 1 ) 
				If iPosF <= 0 Then
					iPosF = len ( sMarqTac ) + 1
				End If 

         	sMarqTACTmp = Trim ( Mid (sMarqTac , iPosD + 1 ,  iPosF - ( iPosD + 1 ) ) )

				If sMarqPort = sMarqTACTmp Then 					
					bOk = True
					iPosD = -1
				Else
					iPosD = iPosF
					If iPosD >= Len ( sMarqTac ) Then 
						bOk = False
						iPosD = -1
					End If
				End If
			Else
				bOk = False
				iPosD = -1
			End If
		Loop

		If Not bOk Then

			If left ( sMarqTac, 1 ) = "#" Then sMarqTac = Right ( sMarqTac, Len ( sMarqTac ) - 1 )

			stMessage.sTitre		= "Contrôle de validité du TAC IMEI"
			stMessage.Bouton		= YesNo!
			stMessage.Icon			= Exclamation!
			stMessage.bErreurG	= FALSE
			stMessage.sVar[1]		= sTacImei
			stMessage.sVar[2]		= F_Remplace ( sMarqTac, "#", "/" )
			// #3
			stMessage.sVar [3] = sModlTAC
			stMessage.sCode		= "GENE164"
			//stMessage.sCode		= "GENE130"
			// Fin #3
			iRet = f_Message ( stMessage )

			If iRet = 2 Then
				bOk = False
			Else
				bOk = True
	      End if
		End If

	End If

End If

Return bOk
end function

private function boolean wf_condition_ouverture_dt269 ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_td_sp_w_detail::wf_Condition_Ouverture_DT269 (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 05/10/2004 14:40:47
//* Libellé       : Vérification des conditions d'ouverture de la fenêtre de commandes
//* Commentaires  : [DT269]
//*
//* Arguments     : String		asChoixAction		String
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//*-----------------------------------------------------------------

Boolean bOk
Long lRow
String sTypApp, sListeOblig, sTailleEcran, sListeInterditSupEg50p




lRow = idw_LstCmdeSin.RowCount()
If lRow > 0 Then Return TRUE

lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'TAILLE_ECRAN'", 1, idwWDivSin.RowCount () ) 
If lRow <= 0 Then Return TRUE

bOk = True

sTailleEcran = Trim ( Upper ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ))

If IsNull ( sTailleEcran ) Then sTailleEcran = "AC0"

lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'TYPE_APP'", 1, idwWDivSin.RowCount () ) 
sTypApp = Trim ( Upper ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) )

sListeOblig = "#TLP#TL7#TL8#TL9#TL1#TL2#TL3#TL4#TL5#TL6#TP1#TP2#TV1#TV2#TT1#TT2#TTC#TLC#TPS#TLO#TVS#"
sListeInterditSupEg50p = "#TL8#TL9#TL1#TL3#TL5#TP1#TV1#TT1#"

// Veuillez saisir la taille de l'écran sur l'onglet Divers du sinistre. 
If sTailleEcran = "AC0" And Pos (sListeOblig,  "#" + sTypApp + "#") > 0 Then 
	
	bOk = False
	stMessage.sTitre		= "Taille écran DT269"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sCode		= "WDET656"

	F_Message ( stMessage )
	Return bOk		
	
End If

// Votre appareil n'a pas de taille d'écran, veuillez saisir "AUCUN" sur l'onglet Divers du sinistre. 
If Pos ( sListeOblig, "#" + sTypApp + "#" ) <= 0 And sTailleEcran <> "AC0" And Len ( sTailleEcran ) = 3  Then 
	
	bOk = False
	stMessage.sTitre		= "Taille écran DT269"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sCode		= "WDET657"

	F_Message ( stMessage )
	Return bOk		
	
End If


// Votre appareil n'a pas de taille d'écran, veuillez saisir "AUCUN" sur l'onglet Divers du sinistre. 
If ( Pos ( sListeInterditSupEg50p, "#" + sTypApp + "#" ) > 0 And sTailleEcran = "S50" And Len ( sTailleEcran ) = 3 ) Then 
	
	bOk = False
	stMessage.sTitre		= "Taille écran DT269"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= FALSE
	stMessage.Bouton		= OK!
	stMessage.sCode		= "WDET658"

	F_Message ( stMessage )
	Return bOk		
	
End If

Return bOk


end function

private function boolean wf_condition_ouverture_dt386 ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_td_sp_w_detail::wf_Condition_Ouverture_DT386 (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 20/05/2019
//* Libellé       : Vérification des conditions d'ouverture de la fenêtre de commandes
//* Commentaires  : [DT386_EXTR_AXA]
//*
//* Arguments     : String		asChoixAction		String
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//        JFF   25/09/2019   [DT386_EXTR_AXA_V8]
//*-----------------------------------------------------------------

Boolean bOk
Long lRow, lDeb, lFin
String sTypApp, sVal 
Date dDteDelivrPI, dDteFinValPI

bOk = True

F_RechDetPro ( lDeb, lFin, idwDetPro, idw_WSin.GetItemNumber ( 1, "ID_PROD" ), "-DP", 335 )	
If lDeb <= 0 Then Return bOk 

lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'TYPE_PCE_IDENTITE'", 1, idwWDivSin.RowCount () ) 
If lRow > 0 Then
	sVal = Trim ( Upper ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) )
	If IsNull ( sVal ) Or Trim ( sVal ) = "" Then
		bOk = False
		stMessage.sTitre		= "Type pièce identité"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "WGAR420"
		F_Message ( stMessage )	
	End If
End If

lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'AUTORITE_PCE_IDENTITE'", 1, idwWDivSin.RowCount () ) 
If lRow > 0 Then
	sVal = Trim ( Upper ( idwWDivSin.GetItemString ( lRow, "VAL_LST_CAR" ) ) )
	If IsNull ( sVal ) Or Trim ( sVal ) = "" Then
		bOk = False
		stMessage.sTitre		= "Autorité pièce identité"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "WGAR421"
		F_Message ( stMessage )	
	End If
End If

// [DT386_EXTR_AXA_V8]
If F_CLE_NUMERIQUE ( "DT386_EXTR_AXA" ) >= 2 Then

	lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'NUM_PCE_IDENTITE'", 1, idwWDivSin.RowCount () ) 
	If lRow > 0 Then
		sVal = Trim ( Upper ( idwWDivSin.GetItemString ( lRow, "VAL_CAR" ) ) )
		If IsNull ( sVal ) Or Trim ( sVal ) = "" Then
			bOk = False
			stMessage.sTitre		= "Numéro pièce identité"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WGAR422"
			F_Message ( stMessage )	
		End If
	End If

	lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'DTE_DELIVRANCE_PI'", 1, idwWDivSin.RowCount () ) 
	If lRow > 0 Then
		dDteDelivrPI = Date(idwWDivSin.GetItemDateTime ( lRow, "VAL_DTE" ))	// [PI056].20190926
		sVal = String ( dDteDelivrPI ) 
		If IsNull ( sVal ) Or Trim ( sVal ) = "" Then
			bOk = False
			stMessage.sTitre		= "Date délivrance pièce identité"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WGAR423"
			F_Message ( stMessage )	
		End If
	End If

	lRow = idwWDivSin.Find ( "Upper (NOM_ZONE) = 'DTE_FIN_VAL_PI'", 1, idwWDivSin.RowCount () ) 
	If lRow > 0 Then
		dDteFinValPI = Date(idwWDivSin.GetItemDateTime ( lRow, "VAL_DTE" ))	// [PI056].20190926
		sVal = String ( dDteFinValPI )
		If IsNull ( sVal ) Or Trim ( sVal ) = "" Then
			bOk = False
			stMessage.sTitre		= "Date fin validité pièce identité"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= FALSE
			stMessage.Bouton		= OK!
			stMessage.sCode		= "WGAR424"
			F_Message ( stMessage )	
		End If
	End If

	IF dDteDelivrPI >= dDteFinValPI Then 
		bOk = False
		stMessage.sTitre		= "Incohérence Date PI"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= OK!
		stMessage.sCode		= "WGAR425"
		F_Message ( stMessage )			
	End If 


End If

Return bOk


end function

private subroutine wf_marquageetatpiecesherpa (integer aid_pce, string asetat_pce, integer aiidi);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Garantie::Wf_MarquageEtatPieceSherpa (PRIVATE)
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
//        JFF   04/09/2023  [RS5656_MOD_PCE_DIF]
//*-----------------------------------------------------------------

Int iRow
DateTime dtJour
String sModeFctDp345, sCodePce
n_cst_string lnvPFCString
Long lDeb, lFin

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

private subroutine wf_marquageetatpiecesherpa_rs5656 (integer aid_gti, integer aid_pce, string asetat_pce, integer aiidi);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Garantie::Wf_MarquageEtatPieceSherpa_RS5656 (PRIVATE)
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
//        JFF   04/09/2023  [RS5656_MOD_PCE_DIF]
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
		iRow = gdsPieceSherpa.Find ( "ID_PCE = " + String ( aid_pce ), 1, gdsPieceSherpa.RowCount ()) 
	Case "DET_GARANTIE"
		iRow = gdsPieceSherpa.Find ( "ID_GTI = " + String ( aId_Gti) + " AND ID_DETAIL = -1 AND ID_PCE = " + String ( aid_pce ), 1, gdsPieceSherpa.RowCount ()) 
End Choose 

If iRow <= 0 Then

	iRow = gdsPieceSherpa.InsertRow ( 0 )	
	
	gdsPieceSherpa.SetItem ( iRow, "ID_GTI", aid_gti ) 
	gdsPieceSherpa.SetItem ( iRow, "ID_DETAIL", -1 ) 			
	gdsPieceSherpa.SetItem ( iRow, "ID_PCE", aid_pce ) 
End If 

dtJour = DateTime ( Today(), Now())

gdsPieceSherpa.SetItem ( iRow, "ETAT_PCE", Trim ( Upper ( asEtat_Pce ) ) ) 
gdsPieceSherpa.SetItem ( iRow, "DTE_ANALYSE_PCE", dtJour ) 
gdsPieceSherpa.SetItem ( iRow, "ID_I", aiIdI ) 


end subroutine

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_W_Gar_Sin::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  CAG  06/02/2003 Suite DCMP 030027 : Ajout de la dw sur DetPro
//* #2  CAG	 02/09/2004	DCMP 040355 Bouton tarif papier accessible en validation également
//* #3  PHG	 26/01/2007 [CRAO_LOT2] Gestion Controle IMEI sur champ de div_sin
//* 							Ajout de la reference de w_tm_sp_sinistre::dw_w_div_sin
//*							passée à l'objet de gestion des garanties.
//      JFF  18/04/2012 [201204181055][PROBLEME_PLAF_MARYSE]
//*     JFF  26/06/2012 [CONFO][NV_PROCESS]
//*-----------------------------------------------------------------

s_Pass stPass_Dga

//Migration PB8-WYNIWYG-03/2006 CP
//DataWindow	dwNorm[19]
//DataWindow	dwPassageEuro[2]
DataWindow	dwNorm[]
DataWindow	dwPassageEuro[]
//Fin Migration PB8-WYNIWYG-03/2006 CP

Wf_PositionnerObjets ()

Wf_ActiverModeDetail ( True )
dw_1.Uf_DetailParent ( istPass.dwTab[ 1 ] )

/*------------------------------------------------------------------*/
/* Nous sommes en saisie (S) ou en Consultation (C)                 */
/*------------------------------------------------------------------*/
isTypeTrt = istPass.sTab[ 2 ]

/*------------------------------------------------------------------*/
/* On commence à initialiser les NVUO.                              */
/*------------------------------------------------------------------*/
iuoGsSpGarantie = Create U_Gs_Sp_Sinistre_Garantie

/*------------------------------------------------------------------*/
/* On garde la référence aux DW, dans un tableau propre à la        */
/* fenêtre, pour pouvoir ouvrir la fenêtre de traitement des        */
/* détails.                                                         */
/* Cela évite de poser des contrôles DW sur la fenêtre. (Rapidité   */
/* ouverture)                                                       */
/*------------------------------------------------------------------*/
idw_Desc			= istPass.dwNorm
idw_wSin			= istPass.dwMaster
idw_LstGarSin	= istPass.dwTab[1]
idw_LstInter	= istPass.dwTab[2]
idw_LstCmdeSin = istPass.dwTab[3]
idwCmdTypFrn	= istPass.dwNorm[15]
idwCmdTypArt	= istPass.dwNorm[16]
idwWDivSin     = istPass.udwTab [ 1 ]    // Dw_w_Div_Sin
idwStkIFR		= istPass.dwNorm [ 25 ]   // Dw des Données IFR
idwDetPro		= istPass.dwNorm [ 22 ]
idwTAcImei		= istPass.dwNorm [ 24 ]
idwAutorisation  = istPass.dwNorm [ 27 ] 
idwStkCodicDarty = istPass.dwNorm [ 28 ]	
idwStkCodeMB = istPass.dwNorm [ 29 ]
idw_DivDetSin = istPass.udwTab [ 2 ]

/*------------------------------------------------------------------*/
/* On arme les DW dans le bon ordre. (SVP)                          */
/*------------------------------------------------------------------*/
idwProduit = istPass.dwNorm [  1 ]		// PRODUIT
dwNorm[ 1] = istPass.dwNorm [  2 ]		// CODE_GARANTIE
dwNorm[ 2] = istPass.dwNorm [  3 ]		// CODE_CONDITION
dwNorm[ 3] = istPass.dwNorm [  4 ]		// PIECE
dwNorm[ 4] = istPass.dwNorm [  5 ]		// MOTIF
dwNorm[ 5] = istPass.dwNorm [  6 ]		// FRANCHISE
dwNorm[ 6] = istPass.dwNorm [  7 ]		// PLAFOND
dwNorm[ 7] = istPass.dwNorm [  8 ]		// DELAI
dwNorm[ 8] = istPass.dwNorm [  9 ]		// GARANTIE
dwNorm[ 9] = istPass.dwNorm [ 10 ]		// CONDITION
dwNorm[10] = istPass.dwNorm [ 11 ]		// W_DETAIL
dwNorm[11] = istPass.dwNorm [ 12 ]		// W_PIECE
dwNorm[12] = istPass.dwNorm [ 13 ]		// W_REFUS
dwNorm[13] = istPass.dwNorm [ 14 ]		// W_PARA_PLAFOND

dwNorm[14] = dw_wPiece_Detail			// DW de stockage temporaire pour les pièces des détails.
dwNorm[15] = dw_wRefus_Detail			// DW de stockage temporaire pour les refus des détails.
dwNorm[16] = dw_wPPlafond_Gti			// DW de stockage temporaire pour les plafonds sur la garantie
dwNorm[17] = dw_wPPlafond_Detail		// DW de stockage temporaire pour les plafonds sur les détails de la garantie

dwNorm[18] = dw_wDetail_Supp			// DW de stockage temporaire détails supprimés.
dwNorm[19] = idwAutorisation
dwNorm[20] = istPass.dwNorm [ 33 ]  // [CONFO][NV_PROCESS] dw_detail de plus haut niveau


/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
/* Sauvegarde temporaire des DataWindows pour les transmetter à la  */
/* fenêtre des détails.                                             */
/*------------------------------------------------------------------*/
idw_Horaire_Rdv	= istPass.dwNorm [ 17 ]
idw_Zone_Cogepar	= istPass.dwNorm [ 18 ]
// CAG : le 27/09/02
idw_Gamme			= istPass.dwNorm [ 19 ]
//CAG : le 03/10/02
idw_DetArt			= istPass.dwNorm [ 20 ]
idw_DetHlr			= istPass.dwNorm [ 21 ]


/*------------------------------------------------------------------*/
/* Ces fonctions sont issues du NVUO ancêtre.                       */
/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
iuoGsSpGarantie.Uf_Initialisation ( istPass.dwMaster, itrTrans, Uo_Ong, isTypeTrt )
iuoGsSpGarantie.Uf_Initialiser_Dw ( istPass.dwNorm [ 1 ], idwDetPro, False )

/*------------------------------------------------------------------*/
/* istPass.sTab[2] = u_DataWindow_Detail -> Liste des               */
/* interlocuteurs                                                   */
/*------------------------------------------------------------------*/

gdwlstdetail = dw_Lst_Detail // [201204181055][PROBLEME_PLAF_MARYSE]

iuoGsSpGarantie.Uf_Initialiser_Dw_Desc &
	( 	istPass.dwTab[2]	, &
	   istPass.dwTab[1]	, &
		dw_Lst_Detail		, &
		dw_w_commande		, &
		idw_LstCmdeSin		, &
		dw_w_div_det 		, &
		idw_divdetsin     , &
		dw_1, dwNorm[]		, &
		idwWDivSin ) // [CRAO_LOT2] On ajoute la reference de w_tm_sp_sinistre::dw_wdivsin

/*------------------------------------------------------------------*/
/* On initialise l'objet de marquage des pièces et des refus.       */
/*------------------------------------------------------------------*/
/* Le 28/11/2001.                                                   */
/* Modif DGA. DCMP 010375                                           */
/*------------------------------------------------------------------*/
iuoGsSpGarantie.Uf_Initialiser_Objets ( Uo_Piece, Uo_Refus, Cb_Tarif )

/*------------------------------------------------------------------*/
/* Initialisation de l'onglet.                                      */
/*------------------------------------------------------------------*/
Uo_Ong.Uf_Initialiser ( 3, 1 )
Uo_Ong.Uf_EnregistrerOnglet ( "01", "Garantie", 		"", dw_1,			True )
Uo_Ong.Uf_EnregistrerOnglet ( "02", "Pièces", 			"", Uo_Piece,		False )
Uo_Ong.Uf_EnregistrerOnglet ( "03", "Refus",				"", Uo_Refus,		False )

iuoGsSpGarantie.Uf_Traitement ( 1, stPass_Dga )

/*------------------------------------------------------------------*/
/* Si on est en Consultation/Validation (C)(V), on bouge la         */
/* cosmétique de la fenêtre.                                        */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Attention, il faut se mettre ici aprés la création de            */
/* dw_Lst_Detail. Cette création dynamique est réalisée dans        */
/* Uf_InitialiserFenetre () du UserObjet.                           */
/*------------------------------------------------------------------*/
/* #2 CAG : 02/09/2004                                              */
/*------------------------------------------------------------------*/
If	isTypeTrt <> "S"	Then
	Wf_Tb_Consultation ()
End If

/*------------------------------------------------------------------*/
/* Gestion du Passage à l'EURO.                                     */
/*------------------------------------------------------------------*/
N_Cst_Passage_Euro	nvPassageEuro

dwPassageEuro [ 1 ] = dw_1
dwPassageEuro [ 2 ] = dw_Lst_Detail

nvPassageEuro = CREATE N_Cst_Passage_Euro
nvPassageEuro.uf_Initialiser ( dwPassageEuro[] )

//Migration PB8-WYNIWYG-03/2006 FM
//DESTROY nvPassageEuro
If IsValid(nvPassageEuro) Then DESTROY nvPassageEuro
//Fin Migration PB8-WYNIWYG-03/2006 FM



end event

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_W_Detail::Ue_Modifier
//* Evenement 		: Ue_Modifier
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 16:37:38
//* Libellé			: 
//* Commentaires	: Ouverture des Fenêtres de détail.
//*				     (On est en modification d'un détail)
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  CAG	 12/02/2003 Suite DCMP 030027 : Ajout de dw sur Det_Pro
//* #2  JFF  13/02/2008 [FNAC_PROD_ECH_TECH].[20090224144248310]
//*     JFF  26/06/2012 [CONFO][NV_PROCESS]
//*-----------------------------------------------------------------

s_Pass stPass_Dga

stPass_Dga = istPass

/*------------------------------------------------------------------*/
/* Si la fenêtre de consultation des paragraphes est visible, on    */
/* la rend invisible.                                               */
/*------------------------------------------------------------------*/
Wf_Fermer_Consulter_Paragraphe ()

Choose Case isDetailActif
Case "dw_lst_detail"

	isDetailConsult = "dw_lst_detail"

	SetPointer ( HourGlass! )

	stPass_Dga.bInsert		= False
	stPass_Dga.bControl		= True

	stPass_Dga.sTab [ 1 ]	= This.Title
	stPass_Dga.sTab [ 2 ]	= isTypeTrt
	stPass_Dga.sTab [ 3 ]	= Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()
	stPass_Dga.sTab [ 4 ]	= istPass.sTab [ 4 ]  // n° IMEI provenant de l'adhésion (a pu être modifié depuis l'ouverture du sinistre).
	stPass_Dga.sTab [ 5 ]	= istPass.sTab [ 5 ]  // Marque portable adhésion.
	stPass_Dga.sTab [ 6 ]	= istPass.sTab [ 6 ]  // Modèle portable adhésion.
	stPass_Dga.sTab [ 7 ]	= istPass.sTab [ 7 ]  // DCMP 030407 n° IMEI provenant de l'adhésion (N'A PAS ETE modifié depuis l'ouverture du sinistre)
	stPass_Dga.sTab [ 8 ]	= istPass.sTab [ 8 ]  // Référentiel utilisé (Téléphonie) 

	stPass_Dga.bTab [ 1 ]	= istPass.bTab [ 1 ] // Accès ou pas aux commandes.
	stPass_Dga.bTab [ 2 ]	= istPass.bTab [ 2 ] // Accès ou pas aux communes.

	stPass_Dga.dwTab [ 1 ]	= Dw_Lst_Detail
	stPass_Dga.dwTab [ 2 ]	= idw_LstGarSin
	stPass_Dga.dwTab [ 3 ]	= idw_LstInter
	stPass_Dga.dwTab [ 4 ]	= dw_w_Commande
	stPass_Dga.dwTab [ 5 ]	= idw_LstCmdeSin // Dw_w_Commande au niveau Sinistre afin de récupérer les DDDW en Share.

	stPass_Dga.udwTab [ 1 ]	= istPass.udwTab [ 1 ]    // Dw_w_Div_Sin
	stPass_Dga.udwTab [ 2 ]	= dw_w_div_det			     // DataWindow Stockage Données onglet divers details

	stPass_Dga.dwMaster		= idw_wSin
	stPass_Dga.dwMaster1		= dw_1

	stPass_Dga.dwNorm [  1 ]	= idw_Desc [  1 ] 		// DataWindow PRODUIT
	stPass_Dga.dwNorm [  2 ]	= idw_Desc [  2 ] 		// DataWindow CODE_GARANTIE
	stPass_Dga.dwNorm [  3 ]	= idw_Desc [  3 ] 		// DataWindow CODE_CONDITION
	stPass_Dga.dwNorm [  4 ]	= idw_Desc [  4 ] 		// DataWindow PIECE
	stPass_Dga.dwNorm [  5 ]	= idw_Desc [  5 ] 		// DataWindow MOTIF
	stPass_Dga.dwNorm [  6 ]	= idw_Desc [  6 ] 		// DataWindow FRANCHISE
	stPass_Dga.dwNorm [  7 ]	= idw_Desc [  7 ] 		// DataWindow PLAFOND
	stPass_Dga.dwNorm [  8 ]	= idw_Desc [  8 ] 		// DataWindow DELAI
	stPass_Dga.dwNorm [  9 ]	= idw_Desc [  9 ] 		// DataWindow GARANTIE
	stPass_Dga.dwNorm [ 10 ]	= idw_Desc [ 10 ] 		// DataWindow CONDITION

	stPass_Dga.dwNorm [ 11 ]	= dw_wPiece_Detail 		// DataWindow W_PIECE_DETAIL
	stPass_Dga.dwNorm [ 12 ]	= dw_wRefus_Detail 		// DataWindow W_REFUS_DETAIL
	stPass_Dga.dwNorm [ 13 ]	= dw_wPPlafond_Detail 	// DataWindow W_PPLAFOND_DETAIL
	stPass_Dga.dwNorm [ 14 ]	= dw_wDetail_Supp 		// DataWindow External

	stPass_Dga.dwNorm [ 15 ]	= idwCmdTypFrn				// DataWindow sur COMMANDE_TYPE, pour le choix des fournisseurs
	stPass_Dga.dwNorm [ 16 ]	= idwCmdTypArt				// DataWindow sur COMMANDE_TYPE, pour le choix des articles

/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
	stPass_Dga.dwNorm [ 17 ]	= idw_Horaire_Rdv			// DataWindow pour les horaires de rendez-vous
	stPass_Dga.dwNorm [ 18 ]	= idw_Zone_Cogepar		// DataWindow sur la table ZONE_COGEPAR

/*------------------------------------------------------------------*/
/* Modification SFR # Le 27/09/02                                   */
/*------------------------------------------------------------------*/
	stPass_Dga.dwNorm [ 19 ]	= idw_Gamme					// DataWindow sur la table GAMME
	stPass_Dga.dwNorm [ 20 ]	= idw_DetArt				// DataWindow sur la table DET_ARTICLE
	stPass_Dga.dwNorm [ 21 ]	= idw_DetHlr				// DataWindow sur la table DET_HLR

	/*------------------------------------------------------------------*/
	/* #1                                                               */
	/*------------------------------------------------------------------*/
	stPass_Dga.dwNorm [ 22 ]   = istPass.dwNorm [ 22 ]	// DataWindow sur la table DET_PRO
	stPass_Dga.dwNorm [ 23 ]   = istPass.dwNorm [ 23 ] // Dw des communes
	stPass_Dga.dwNorm [ 24 ]   = istPass.dwNorm [ 24 ] // Dw des TacImei
	stPass_Dga.dwNorm [ 25 ]   = istPass.dwNorm [ 25 ] // Dw des Données IFR
	stPass_Dga.dwNorm [ 26 ]   = istPass.dwNorm [ 26 ] // Dw des Libellés IFR Traduits
	stPass_Dga.dwNorm [ 27 ]	= istPass.dwNorm [ 27 ] // Table autorisation
	stPass_Dga.dwNorm [ 28 ]	= istPass.dwNorm [ 28 ] // Table données CODIC DARTY
	stPass_Dga.dwNorm [ 30 ]	= istPass.dwNorm [ 30 ] // DataWindow Stockage Données param onglet divers details
	stPass_Dga.dwNorm [ 31 ]	= istPass.dwNorm [ 31 ] // Chargement tempo des codes pour W_Div_Det
	stPass_Dga.dwNorm [ 32 ]	= istPass.dwNorm [ 32 ] // Chargement tempo des codes pour W_Div_Det
	//* #2 [FNAC_PROD_ECH_TECH].[20090224144248310]
	stPass_Dga.dwNorm [ 33 ]	= uo_piece.dw_Trt // Pièce coché actuellement sur la garantie.
	stPass_Dga.dwNorm [ 34 ]	= istPass.dwNorm [ 33 ] // [CONFO][NV_PROCESS] dw detail de plus haut niveau

	If	stPass_Dga.sTab [ 3 ]	<> stGLB.sMonnaieFormatDesire		Then	Uo_Consult_Euro.Uf_Changer_Monnaie ( stGLB.sMonnaieFormatDesire )


	If This.wf_Condition_Ouverture () Then
		F_OuvreTraitement ( iW_Td_Sp_W_Detail, stPass_Dga )
	End If	

End Choose

end event

event ue_creer;call super::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_W_Detail::Ue_Creer
//* Evenement 		: Ue_Creer
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 16:37:38
//* Libellé			: 
//* Commentaires	: Ouverture des Fenêtres de détail.
//*				     (On est en création d'un détail)
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  CAG	 12/02/2003 Suite DCMP 030027 : Ajout de dw sur Det_Pro
//* #2  JFF  13/02/2008 [FNAC_PROD_ECH_TECH].[20090224144248310]
//*     JFF  26/06/2012 [CONFO][NV_PROCESS]
//*-----------------------------------------------------------------

s_Pass stPass_Dga

stPass_Dga = istPass

/*------------------------------------------------------------------*/
/* Si la fenêtre de consultation des paragraphes est visible, on    */
/* la rend invisible.                                               */
/*------------------------------------------------------------------*/
Wf_Fermer_Consulter_Paragraphe ()

If	isTypeTrt <> "S"	Then Return

Choose Case isDetailActif
Case "dw_lst_detail"

	SetPointer ( HourGlass! )

	stPass_Dga.bInsert		= True
	stPass_Dga.bControl		= True

	stPass_Dga.sTab [ 1 ]	= This.Title
	stPass_Dga.sTab [ 2 ]	= isTypeTrt
	stPass_Dga.sTab [ 4 ]	= istPass.sTab [ 4 ]  // n° IMEI provenant de l'adhésion (a pu être modifié depuis l'ouverture du sinistre).
	stPass_Dga.sTab [ 5 ]	= istPass.sTab [ 5 ]  // Marque portable adhésion.
	stPass_Dga.sTab [ 6 ]	= istPass.sTab [ 6 ]  // Modèle portable adhésion.
	stPass_Dga.sTab [ 7 ]	= istPass.sTab [ 7 ]  // DCMP 030407 n° IMEI provenant de l'adhésion (N'A PAS ETE modifié depuis l'ouverture du sinistre)
	stPass_Dga.sTab [ 8 ]	= istPass.sTab [ 8 ]  // Référentiel utilisé (Téléphonie) 

	stPass_Dga.bTab [ 1 ]	= istPass.bTab [ 1 ] // Accès ou pas aux commandes.
	stPass_Dga.bTab [ 2 ]	= istPass.bTab [ 2 ] // Accès ou pas aux communes.

	stPass_Dga.dwTab [ 1 ]	= Dw_Lst_Detail
	stPass_Dga.dwTab [ 2 ]	= idw_LstGarSin
	stPass_Dga.dwTab [ 3 ]	= idw_LstInter
	stPass_Dga.dwTab [ 4 ]	= dw_w_Commande	  // Dw_w_Commande en local au niveau Garantie
	stPass_Dga.dwTab [ 5 ]	= idw_LstCmdeSin    // Dw_w_Commande au niveau Sinistre afin de récupérer les DDDW en Share.

	stPass_Dga.udwTab [ 1 ]	= istPass.udwTab [ 1 ]    // Dw_w_Div_Sin
	stPass_Dga.udwTab [ 2 ]	= dw_w_div_det 		     // DataWindow Stockage Données onglet divers details

	stPass_Dga.dwMaster		= idw_wSin
	stPass_Dga.dwMaster1		= dw_1

	stPass_Dga.dwNorm [  1 ]	= idw_Desc [  1 ] 		// DataWindow PRODUIT
	stPass_Dga.dwNorm [  2 ]	= idw_Desc [  2 ] 		// DataWindow CODE_GARANTIE
	stPass_Dga.dwNorm [  3 ]	= idw_Desc [  3 ] 		// DataWindow CODE_CONDITION
	stPass_Dga.dwNorm [  4 ]	= idw_Desc [  4 ] 		// DataWindow PIECE
	stPass_Dga.dwNorm [  5 ]	= idw_Desc [  5 ] 		// DataWindow MOTIF
	stPass_Dga.dwNorm [  6 ]	= idw_Desc [  6 ] 		// DataWindow FRANCHISE
	stPass_Dga.dwNorm [  7 ]	= idw_Desc [  7 ] 		// DataWindow PLAFOND
	stPass_Dga.dwNorm [  8 ]	= idw_Desc [  8 ] 		// DataWindow DELAI
	stPass_Dga.dwNorm [  9 ]	= idw_Desc [  9 ] 		// DataWindow GARANTIE
	stPass_Dga.dwNorm [ 10 ]	= idw_Desc [ 10 ] 		// DataWindow CONDITION

	stPass_Dga.dwNorm [ 11 ]	= dw_wPiece_Detail 		// DataWindow W_PIECE_DETAIL
	stPass_Dga.dwNorm [ 12 ]	= dw_wRefus_Detail 		// DataWindow W_REFUS_DETAIL
	stPass_Dga.dwNorm [ 13 ]	= dw_wPPlafond_Detail 	// DataWindow W_PPLAFOND_DETAIL

	stPass_Dga.dwNorm [ 14 ]	= dw_wDetail_Supp 		// DataWindow External

	stPass_Dga.dwNorm [ 15 ]	= idwCmdTypFrn				// DataWindow sur COMMANDE_TYPE, pour le choix des fournisseurs
	stPass_Dga.dwNorm [ 16 ]	= idwCmdTypArt				// DataWindow sur COMMANDE_TYPE, pour le choix des articles
/*------------------------------------------------------------------*/
/* # Modification SFR # Le 17/07/2002.                              */
/*------------------------------------------------------------------*/
	stPass_Dga.dwNorm [ 17 ]	= idw_Horaire_Rdv			// DataWindow pour les horaires de rendez-vous
	stPass_Dga.dwNorm [ 18 ]	= idw_Zone_Cogepar		// DataWindow sur la table ZONE_COGEPAR

/*------------------------------------------------------------------*/
/* Modification SFR # Le 27/09/02                                   */
/*------------------------------------------------------------------*/
	stPass_Dga.dwNorm [ 19 ]	= idw_Gamme					// DataWindow sur la table GAMME
	stPass_Dga.dwNorm [ 20 ]	= idw_DetArt				// DataWindow sur la table DET_ARTICLE
	stPass_Dga.dwNorm [ 21 ]	= idw_DetHlr				// DataWindow sur la table DET_HLR

	/*------------------------------------------------------------------*/
	/* #1                                                               */
	/*------------------------------------------------------------------*/
	stPass_Dga.dwNorm [ 22 ]   = istPass.dwNorm [ 22 ]	// DataWindow sur la table DET_PRO
	stPass_Dga.dwNorm [ 23 ]   = istPass.dwNorm [ 23 ] // Dw des communes
	stPass_Dga.dwNorm [ 24 ]   = istPass.dwNorm [ 24 ] // Dw des TacImei
	stPass_Dga.dwNorm [ 25 ]   = istPass.dwNorm [ 25 ] // Dw des Données IFR
	stPass_Dga.dwNorm [ 26 ]   = istPass.dwNorm [ 26 ] // Dw des Libellés IFR Traduits
	stPass_Dga.dwNorm [ 27 ]	= istPass.dwNorm [ 27 ] // Table autorisation
	stPass_Dga.dwNorm [ 28 ]	= istPass.dwNorm [ 28 ] // Table données CODIC DARTY
	stPass_Dga.dwNorm [ 30 ]	= istPass.dwNorm [ 30 ] // DataWindow Stockage Données param onglet divers details
	stPass_Dga.dwNorm [ 31 ]	= istPass.dwNorm [ 31 ] // Chargement tempo des codes pour W_Div_Det
	stPass_Dga.dwNorm [ 32 ]	= istPass.dwNorm [ 32 ] // Chargement tempo des codes pour W_Div_Det
	//* #2 [FNAC_PROD_ECH_TECH].[20090224144248310]
	stPass_Dga.dwNorm [ 33 ]	= uo_piece.dw_Trt // Pièce coché actuellement sur la garantie.
	stPass_Dga.dwNorm [ 34 ]	= istPass.dwNorm [ 33 ] // [CONFO][NV_PROCESS] dw detail de plus haut niveau


	If This.wf_Condition_Ouverture () Then
		F_OuvreTraitement ( iW_Td_Sp_W_Detail, stPass_Dga )
	End If

End Choose

end event

on ue_supprimer;//*-----------------------------------------------------------------
//*
//* Objet         : w_tm_sp_w_gar_sin
//* Evenement     : ue_supprimer !! OVERRIDE !!
//* Auteur        : Fabry JF
//* Date          : 24/03/2005 17:05:47
//* Libellé       : 
//* Commentaires  : DCMP 040530
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

/*------------------------------------------------------------------*/
/* Attention, si presence de l'option -DP/33 (gestion refus 694),   */
/* alors impossibilité de supprimer l'UF si CLE présente.           */
/*------------------------------------------------------------------*/
/* Option 33, Gestion refus 694												  */
/*------------------------------------------------------------------*/
F_RechDetPro ( lDeb, lFin, idwDetPro, idw_wSin.GetItemNumber ( 1, "ID_PROD" ), '-DP', 33 )
If lDeb > 0 Then 
	If dw_1.GetItemNumber ( 1, "ID_GTI" ) = 7 And idw_LstGarSin.Find ( "ID_GTI = 1", 1, idw_LstGarSin.RowCount () ) > 0 Then

		stMessage.sTitre		= "Suppression Garantie"
		stMessage.Bouton		= Ok!
		stMessage.Icon			= Information!
		stMessage.bErreurG	= FALSE
		stMessage.sCode		= "GENE133"
		f_Message ( stMessage )

	Else 
		Call super::ue_supprimer
	End If
Else
	Call super::ue_supprimer
End If

end on

on ue_retour;call w_8_traitement_master::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_W_Gar_Sin::Ue_Retour (EXTEND)
//* Evenement 		: Ue_Retour
//* Auteur			: Erick John Stark
//* Date				: 16/07/1998 15:15:02
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

end on

on ue_enablefenetre;call w_8_traitement_master::ue_enablefenetre;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_W_Gar_Sin::Ue_EnableFenetre
//* Evenement 		: Ue_EnableFenetre
//* Auteur			: Erick John Stark
//* Date				: 09/06/1998 17:20:28
//* Libellé			: 
//* Commentaires	: On vient de la fenêtre des Détails
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String sMonnaie

Choose Case isTypeTrt
/*------------------------------------------------------------------*/
/* On est en consultation, on détermine d'ou l'on vient (GTI ou     */
/* INTER), on récupére la valeur de la monnaie pour cette fenêtre,  */
/* et on positionne la même valeur pour la fenêtre en cours.        */
/*------------------------------------------------------------------*/
Case "C"
	Choose Case isDetailConsult
	Case "dw_lst_detail"
		sMonnaie = iW_Td_Sp_W_Detail.Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()

	End Choose

	If	This.Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante () <> sMonnaie	Then
		Uo_Consult_Euro.Uf_Changer_Monnaie ( sMonnaie )
	End If

End Choose

end on

on ue_changerdetail;call w_8_traitement_master::ue_changerdetail;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_W_Gar_Sin::Ue_ChangerDetail (EXTEND)
//* Evenement 		: Ue_ChangerDetail
//* Auteur			: Erick John Stark
//* Date				: 30/10/1998 14:24:56
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lRetour

/*------------------------------------------------------------------*/
/* On vient dans cet événement au moment du GetFocus () ou du       */
/* LoseFocus () sur le U_DataWindow_Detail. Il faut faire un        */
/* AcceptText de Dw_1 pour toujous avoir le bon contenu des zones   */
/* DTE_OPPO_DATE, HEu_OPPO.                                         */
/*------------------------------------------------------------------*/
lRetour = Message.LongParm

If	lRetour = 0 Then		// on vient de faire un GetFocus sur U_Data_Window_Detail
	If	dw_1.AcceptText () > 0 Then
		dw_1.TriggerEvent ( ItemFocusChanged! )
	Else
		dw_1.SetFocus ()
	End If
End If
end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_W_Gar_Sin::Close
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
//Destroy iUoGsSpGarantie
If IsValid(iUoGsSpGarantie) Then Destroy iUoGsSpGarantie
//Fin Migration PB8-WYNIWYG-03/2006 FM

If IsValid ( iW_Td_Sp_W_Detail 	) Then Close ( iW_Td_Sp_W_Detail )
If IsValid ( iW_T_Sp_Message 		) Then Close ( iW_T_Sp_Message	)

end event

on w_tm_sp_w_gar_sin.create
int iCurrent
call super::create
this.uo_ong=create uo_ong
this.p_focus=create p_focus
this.uo_3d=create uo_3d
this.dw_lst_detail=create dw_lst_detail
this.uo_piece=create uo_piece
this.uo_refus=create uo_refus
this.dw_wpiece_detail=create dw_wpiece_detail
this.dw_wrefus_detail=create dw_wrefus_detail
this.dw_wdetail_supp=create dw_wdetail_supp
this.dw_wpplafond_detail=create dw_wpplafond_detail
this.dw_wpplafond_gti=create dw_wpplafond_gti
this.dw_wparaplafond=create dw_wparaplafond
this.uo_consult_euro=create uo_consult_euro
this.dw_w_commande=create dw_w_commande
this.cb_tarif=create cb_tarif
this.dw_w_div_det=create dw_w_div_det
this.cb_valid_factu=create cb_valid_factu
this.st_mode_reprise=create st_mode_reprise
this.cb_aide_mode_reprise=create cb_aide_mode_reprise
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_ong
this.Control[iCurrent+2]=this.p_focus
this.Control[iCurrent+3]=this.uo_3d
this.Control[iCurrent+4]=this.dw_lst_detail
this.Control[iCurrent+5]=this.uo_piece
this.Control[iCurrent+6]=this.uo_refus
this.Control[iCurrent+7]=this.dw_wpiece_detail
this.Control[iCurrent+8]=this.dw_wrefus_detail
this.Control[iCurrent+9]=this.dw_wdetail_supp
this.Control[iCurrent+10]=this.dw_wpplafond_detail
this.Control[iCurrent+11]=this.dw_wpplafond_gti
this.Control[iCurrent+12]=this.dw_wparaplafond
this.Control[iCurrent+13]=this.uo_consult_euro
this.Control[iCurrent+14]=this.dw_w_commande
this.Control[iCurrent+15]=this.cb_tarif
this.Control[iCurrent+16]=this.dw_w_div_det
this.Control[iCurrent+17]=this.cb_valid_factu
this.Control[iCurrent+18]=this.st_mode_reprise
this.Control[iCurrent+19]=this.cb_aide_mode_reprise
end on

on w_tm_sp_w_gar_sin.destroy
call super::destroy
destroy(this.uo_ong)
destroy(this.p_focus)
destroy(this.uo_3d)
destroy(this.dw_lst_detail)
destroy(this.uo_piece)
destroy(this.uo_refus)
destroy(this.dw_wpiece_detail)
destroy(this.dw_wrefus_detail)
destroy(this.dw_wdetail_supp)
destroy(this.dw_wpplafond_detail)
destroy(this.dw_wpplafond_gti)
destroy(this.dw_wparaplafond)
destroy(this.uo_consult_euro)
destroy(this.dw_w_commande)
destroy(this.cb_tarif)
destroy(this.dw_w_div_det)
destroy(this.cb_valid_factu)
destroy(this.st_mode_reprise)
destroy(this.cb_aide_mode_reprise)
end on

event we_childactivate;call super::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_W_Gar_Sin::We_ChildActivate
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
This.Height		= 1769
This.Width		= 3598

//Migration PB8-WYNIWYG-03/2006 FM
//sélection de la 1ere ligne de la liste s' elle existe
//if dw_lst_detail.RowCount() > 0 then
//	dw_lst_detail.SelectRow(1, true)
//end if
long	ll_ret
ll_ret = dw_lst_detail.TriggerEvent ("RetrieveEnd")
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event show;call super::show;//*-----------------------------------------------------------------
//*
//* Objet 			: Show
//* Evenement 		: Show
//* Auteur			: Fabry JF
//* Date				: 16/10/2019
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

PostEvent ( "ue_TailleFenetre" )

end event

type cb_debug from w_8_traitement_master`cb_debug within w_tm_sp_w_gar_sin
end type

type dw_1 from w_8_traitement_master`dw_1 within w_tm_sp_w_gar_sin
integer x = 41
integer y = 328
integer width = 530
integer height = 460
string dataobject = "d_sp_sin_w_gti"
boolean border = false
boolean livescroll = false
end type

event dw_1::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_W_Gar_Sin::dw_1
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

Long lRet
s_Pass	stPass_Dga

lRet = 0
/*------------------------------------------------------------------*/
/* Si on est en Saisie, on lance le traitement des zones.           */
/*------------------------------------------------------------------*/

If	isTypeTrt = "S" Then
	lRet = iuoGsSpGarantie.Uf_Zn_Trt ( stPass_Dga )
End If

Return lRet
end event

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_W_Gar_Sin::dw_1
//* Evenement 		: ItemError
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:47:59
//* Libellé			: 
//* Commentaires	: Gestion des messages d'erreur
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//* #1	 PHG	 26/04/2007   [DCMP070275] Ajout de nvx motifs sans suite pour la facturation
//*-----------------------------------------------------------------

If	ibErreur Then

	stMessage.sTitre		= "Gestion des garanties - SIMPA2"
	stMessage.Icon			= Information!

	stMessage.bErreurG	= TRUE

	Choose Case isErrCol
	Case "MT_PROV"
		stMessage.sVar[1] = "montant pour la provision"			// Erreur de Validation - 
		stMessage.sCode	= "GENE003"

	Case "MT_DEDU_AREG"
		stMessage.sVar[1] = "montant à déduire"					// Erreur de Validation - 
		stMessage.sCode	= "GENE003"


	Case "DTE_OPPO_DATE"
		Choose Case This.iiErreur
		Case 0
			stMessage.sVar[1] = "date d'opposition"				// Erreur de Validation - Date supérieure à date du jour
			stMessage.sCode	= "GENE002"

		Case 1
			stMessage.sVar[1] = "date d'opposition"				// Erreur de saisie - Date inférieure à la date de survenance
			stMessage.sVar[2] = "supérieure ou égale"
			stMessage.sVar[3] = "date de survenance"

			stMessage.sCode	= "GENE007"

		End Choose

	Case "HEU_OPPO"
		stMessage.bErreurG	= False
		Choose Case This.iiErreur
		Case 1
			stMessage.sVar[1] 	= "l'heure d'opposition"		// Erreur de saisie - Il faut saisir 4 caractères
			stMessage.bErreurG	= False
			stMessage.sCode		= "WSIN120"

		Case 2
			stMessage.sVar[1] 	= "L'heure d'opposition"		// Erreur de saisie - L'heure est incorrecte
			stMessage.bErreurG	= False
			stMessage.sCode		= "WSIN130"

		Case 3
			stMessage.sVar[1] 	= "date d'opposition"				// Erreur de saisie - Date inférieure à la date de survenance
			stMessage.sVar[2] 	= "supérieure ou égale"
			stMessage.sVar[3] 	= "date de survenance"

			stMessage.bErreurG	= TRUE
			stMessage.sCode		= "GENE007"
		End Choose

	// #1 [DCMP070275]Code motif sans suite reservé à la facturation
	Case "COD_MOT_SSUI"
			Choose Case This.iiErreur
				Case 1
				stMessage.bErreurG	= False
				stMessage.sCode		= "WSIN560"
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

on dw_1::doubleclicked;call w_8_traitement_master`dw_1::doubleclicked;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_1::DoubleClicked
//* Evenement 		: DoubleClicked
//* Auteur			: Erick John Stark
//* Date				: 02/02/1998 21:46:41
//* Libellé			: 
//* Commentaires	: Modification du message de la garantie
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass	stPass_Dga

stPass_Dga.sTab[1] = Parent.Title
stPass_Dga.sTab[2] = isTypeTrt
stPass_Dga.sTab[3] = dw_1.GetItemString ( 1, "TXT_MESS" )
stPass_Dga.sTab[4] = "G"
stPass_Dga.sTab[5] = This.Describe ( "Evaluate ( 'LookUpDisplay ( ID_GTI )', 1 ) " )

stPass_Dga.wParent	= Parent

If ( Upper ( Left ( GetObjectAtPointer (), 8 ) ) = "TXT_MESS" ) Then
	OpenWithParm ( iW_T_Sp_Message, stPass_Dga, stPass_Dga.wParent.ParentWindow () )
End If
end on

type st_titre from w_8_traitement_master`st_titre within w_tm_sp_w_gar_sin
boolean visible = false
integer x = 3415
integer y = 140
integer width = 137
end type

type pb_retour from w_8_traitement_master`pb_retour within w_tm_sp_w_gar_sin
integer x = 0
integer y = 8
integer width = 242
integer height = 144
integer taborder = 80
end type

type pb_valider from w_8_traitement_master`pb_valider within w_tm_sp_w_gar_sin
integer x = 494
integer y = 8
integer width = 242
integer height = 144
integer taborder = 100
end type

type pb_imprimer from w_8_traitement_master`pb_imprimer within w_tm_sp_w_gar_sin
boolean visible = false
integer x = 978
integer y = 8
integer taborder = 120
boolean enabled = false
end type

type pb_controler from w_8_traitement_master`pb_controler within w_tm_sp_w_gar_sin
integer x = 251
integer y = 8
integer width = 242
integer height = 144
integer taborder = 90
end type

type pb_supprimer from w_8_traitement_master`pb_supprimer within w_tm_sp_w_gar_sin
integer x = 736
integer y = 8
integer width = 242
integer height = 144
integer taborder = 110
end type

type uo_ong from u_onglets within w_tm_sp_w_gar_sin
integer x = 9
integer y = 156
integer width = 1481
integer height = 108
integer taborder = 70
boolean border = false
end type

type p_focus from picture within w_tm_sp_w_gar_sin
boolean visible = false
integer x = 3273
integer y = 140
integer width = 91
integer height = 76
boolean bringtotop = true
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\focus_1.bmp"
boolean focusrectangle = false
end type

type uo_3d from u_bord3d within w_tm_sp_w_gar_sin
integer x = 2519
integer y = 28
integer width = 320
integer height = 120
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
This.Y			=  253
This.Width		= 3534
This.Height		=  950

Call U_Bord3D::Constructor
end on

on uo_3d.destroy
call u_bord3d::destroy
end on

type dw_lst_detail from u_datawindow_detail within w_tm_sp_w_gar_sin
integer x = 864
integer y = 336
integer width = 530
integer height = 460
integer taborder = 40
boolean vscrollbar = true
boolean livescroll = false
borderstyle borderstyle = styleshadowbox!
end type

on ue_modifiermenu;call u_datawindow_detail::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_Lst_Detail::Ue_ModifierMenu
//* Evenement 		: Ue_ModifierMenu
//* Auteur			: Erick John Stark
//* Date				: 15/01/1998 14:25:28
//* Libellé			: 
//* Commentaires	: Pas de suppresiion d'un détail à partir du menu contextuel
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

event rbuttondown;//Migration PB8-WYNIWYG-03/2006 FM
//ce code remplace le code de l'ancêtre, 
//il permet la sélection de la ligne sur le click droit

If Row > 0 Then
	This.SetRow(Row)
	SelectRow(Row, True)
end if

call super::rButtonDown

Return AncestorReturnValue

//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type uo_piece from u_tagger within w_tm_sp_w_gar_sin
event ue_quitteronglet011 pbm_custom01
integer x = 1705
integer y = 328
integer width = 530
integer height = 460
integer taborder = 50
end type

event ue_dwtrt_itemchanged;call super::ue_dwtrt_itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_W_Gar_Sin::Uo_Piece::Ue_DwTrt_ItemChanged
//* Evenement 		: Ue_DwTrt_ItemChanged
//* Auteur			: Erick John Stark
//* Date				: 11/02/1998 14:38:47
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*	FPI	13/05/2013	[PC938_ORANGE_V3]
//		FPI	01/09/2016	[VDoc21594]
//		JFF   03/01/2020	[PC192290]
//    JFF   04/09/2023  [RS5656_MOD_PCE_DIF]
//*-----------------------------------------------------------------

String sNomCol, sVal, sRech, sEtatPce, sLibEtatPce, sModeFctDp345 
n_cst_string lnvPFCString
Boolean bFin
Long lLigne, lTot, lTotDetail, lCpt, lDeb, lFin
Integer iRow, iIdI, iIdGti

//Migration PB8-WYNIWYG-03/2006 CP
Long ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP
datetime dtMajLe
Boolean bRet
n_cst_attrib_key nvAttrib[]
datawindowchild dwc
String sCodePce

sNomCol	= Upper ( This.dw_Trt.GetColumnName () )
sVal		= This.dw_Trt.GetText ()

lLigne	= This.dw_Trt.GetRow ()

iIdGti	= dw_1.GetItemNumber (1,"ID_GTI")  // [RS5656_MOD_PCE_DIF]

Choose Case sNomCol
Case "ALT_RECLAME"
	If	sVal = "N"	Then
		F_RechDetPro(lDeb, lFin, idwdetpro, idw_wsin.GetItemNumber( 1,"ID_PROD"),"-DP",345)
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
			stMessage.sTitre		= "Contrôle sur la garantie"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= False
			stMessage.sCode		= "WGAR105"

			f_Message ( stMessage )

/*------------------------------------------------------------------*/
/* Modification DBI le 14/08/1998                                   */
/* Gestion indetique aux refus si au moins 1 détail réglé           */
/*------------------------------------------------------------------*/
/* Si l'un des détails est REGLE (COD_ETAT=600), on ne peut plus    */
/* cocher de pièces pour la garantie.                               */
/*------------------------------------------------------------------*/
		Else

				lTotDetail = dw_Lst_detail.RowCount ()
				bRet = True
				For	lCpt = 1 To lTotDetail
						If	dw_Lst_Detail.GetItemNumber ( lCpt, "COD_ETAT" ) = 600	Then
							stMessage.sTitre		= "Contrôle sur la garantie"
							stMessage.Icon			= Information!
							stMessage.sVar[1]		= String ( dw_Lst_Detail.GetItemNumber ( lCpt, "ID_DETAIL" ) )
							stMessage.bErreurG	= False
							stMessage.sCode		= "WGAR240"

							f_Message ( stMessage )
							bRet = False
							Exit
						End If
				Next

				If bRet Then This.dw_Trt.SetItem ( lLigne, "ALT_RECLAME", "O" )
		End If
		
	End If

	// [VDoc21594]
	if bRet and sVal="O" Then
		f_rechdetpro(lDeb,  lFin, idwDetPro, idw_wsin.getItemNumber(1,"ID_PROD"), "-DP",305)
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

	// [PC938_ORANGE_V3] - Ctrl cochage/décochage pce 275
	f_rechdetpro(lDeb, lFin, idwdetpro, idw_wsin.GetItemNumber( 1,"ID_PROD"),"-DP",239)
	If lDeb > 0 And &
		dw_1.GetItemNumber(1,"ID_GTI") = 10 And &
		This.dw_Trt.GetItemNumber ( lLigne, "ID_PCE" )=275 Then
		
		lCpt=idwWDivSin.Find("Upper(NOM_ZONE)='PCE_PV_RECU'", 1, idwWDivSin.RowCount())
		if lCpt > 0 Then
			
			if idwWDivSin.GetItemString(lCpt,"VAL_CAR")="O" And sVal = "O" Then // Cochage
				stMessage.sTitre		= "Contrôle sur la garantie"
				stMessage.Icon			= Information!
				stMessage.bErreurG	= False
				stMessage.sCode		= "WGAR397"
				stMessage.bouton = OK!

				f_Message ( stMessage )
				
				This.dw_Trt.SetItem ( lLigne, "ALT_RECLAME", "N" )
				This.dw_Trt.SetItem ( lLigne, "ID_I", stNul.dcm )
			End if

			if idwWDivSin.GetItemString(lCpt,"VAL_CAR")="N" And sVal = "N" Then // Décochage
				stMessage.sTitre		= "Contrôle sur la garantie"
				stMessage.Icon			= Exclamation!
				stMessage.bErreurG	= False
				stMessage.sCode		= "WGAR398"
				stMessage.bouton = YesNo!

				if f_Message ( stMessage ) = 1 Then
					idwWDivSin.SetItem(lCpt,"VAL_CAR","O")
					dtMajLe = DateTime ( Today (), Now () )
					idwWDivSin.SetItem ( lCpt, "MAJ_LE", dtMajLe  )
					idwWDivSin.SetItem ( lCpt, "MAJ_PAR", stGlb.sCodOper )
					idwWDivSin.SetItem ( lCpt, "ALT_SUPP", "N" )
				End if
				
				This.dw_Trt.SetItem ( lLigne, "ALT_RECLAME", "N" )
				This.dw_Trt.SetItem ( lLigne, "ID_I", stNul.dcm )
			End if
			
		End if
	End if
	// :[PC938_ORANGE_V3]
	
	// [PC192290]
	// Service de validation de pièce relié à SHERPA
	sCodePce = String ( This.dw_Trt.GetItemNumber ( lLigne, "ID_PCE" ))

	iIdI = This.dw_Trt.GetItemNumber ( lLigne, "ID_I" )
	If ( iIdI <> 0 OR IsNull ( iIdI ))  And sVal = "N" Then
		This.dw_Trt.SetItem ( lLigne, "ALT_RECLAME", "N" )
		This.dw_Trt.SetItem ( lLigne, "ID_I", stNul.dcm )	
	End IF 

	F_RechDetPro(lDeb, lFin, idwdetpro, idw_wsin.GetItemNumber( 1,"ID_PROD"),"-DP",345)
	If lDeb > 0 Then
		
		// Determination de la Méthode  // [RS5656_MOD_PCE_DIF]
		sModeFctDp345 = lnvPFCString.of_getkeyvalue (idwDetPro.GetItemString ( lDeb, "VAL_CAR" ), "MODE_FCT", ";")
		If sModeFctDp345 = "" Then sModeFctDp345 = "UNIQUE"
		
		If sVal = "O" Then 
			// [RS5656_MOD_PCE_DIF]
			If F_CLE_A_TRUE ( "RS5656_MOD_PCE_DIF" ) Then
				Choose Case sModeFctDp345 
					Case "UNIQUE"
						iRow = gdsPieceSherpa.Find ( "ID_PCE = " + String ( sCodePce ), 1, gdsPieceSherpa.RowCount ()) 
					Case "DET_GARANTIE"
						iRow = gdsPieceSherpa.Find ( "ID_GTI = " + String ( iIdGti) + " AND ID_DETAIL = -1 AND ID_PCE = " + String ( sCodePce ), 1, gdsPieceSherpa.RowCount ()) 
				End Choose 
				
			Else
				iRow = gdsPieceSherpa.Find ( "ID_PCE = " + String ( sCodePce ), 1, gdsPieceSherpa.RowCount ()) 
			End If
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
		
		If sVal = "N" And iIdI = 0 Then
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
					
					// TRT : Marquage id_sin, id_pce pour sherpa PVL
					
					// [RS5656_MOD_PCE_DIF]
					If F_CLE_A_TRUE ( "RS5656_MOD_PCE_DIF" ) Then
						Parent.Wf_MarquageEtatPieceSherpa_RS5656 ( iIdGti, Integer ( sCodePce ), "PVL", iIdI )
					Else
						Parent.Wf_MarquageEtatPieceSherpa ( Integer ( sCodePce ), "PVL", iIdI )
					End If 
					
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
					If F_CLE_A_TRUE ( "RS5656_MOD_PCE_DIF" ) Then
						// TRT : Marquage id_sin, id_pce pour sherpa PNV
						Parent.Wf_MarquageEtatPieceSherpa_RS5656 ( iIdGti, Integer ( sCodePce ), "PNV", iIdI )
					Else
						// TRT : Marquage id_sin, id_pce pour sherpa PNV
						Parent.Wf_MarquageEtatPieceSherpa ( Integer ( sCodePce ), "PNV", iIdI )
					End If 
					
					// TRT : on laisse cocher !!
					This.dw_Trt.SetItem ( lLigne, "ALT_RECLAME", "O" )
						
					// NON, ne plus la réclamer
					Else 
						
						// [RS5656_MOD_PCE_DIF]
						If F_CLE_A_TRUE ( "RS5656_MOD_PCE_DIF" ) Then
							// TRT : Marquage id_sin, id_pce pour sherpa PNV
							Parent.Wf_MarquageEtatPieceSherpa_RS5656 ( iIdGti, Integer ( sCodePce ), "PNV", iIdI )
						Else
							// TRT : Marquage id_sin, id_pce pour sherpa PNV
							Parent.Wf_MarquageEtatPieceSherpa ( Integer ( sCodePce ), "PNV", iIdI )
						End If 
						
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
		ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		

End Choose

//Migration PB8-WYNIWYG-03/2006 CP
//
Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP		

end event

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

type uo_refus from u_tagger within w_tm_sp_w_gar_sin
integer x = 2377
integer y = 328
integer width = 530
integer height = 460
integer taborder = 60
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
//* Objet 			: W_Tm_Sp_W_Gar_Sin::Uo_Refus::Ue_DwTrt_ItemChanged
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

Long lLigne, lTot, lTotDetail, lCpt

//Migration PB8-WYNIWYG-03/2006 CP
Long ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP

Boolean bRet

sNomCol	= Upper ( This.dw_Trt.GetColumnName () )
sVal		= This.dw_Trt.GetText ()

lLigne	= This.dw_Trt.GetRow ()

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
			stMessage.sTitre		= "Contrôle sur la garantie"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= False
			stMessage.sCode		= "WGAR110"

			f_Message ( stMessage )
/*------------------------------------------------------------------*/
/* Si l'un des détails est REGLE (COD_ETAT=600), on ne peut plus    */
/* cocher de refus opérateur pour la garantie.                      */
/*------------------------------------------------------------------*/
		Else
				lTotDetail = dw_Lst_detail.RowCount ()
				bRet = True
				For	lCpt = 1 To lTotDetail
						If	dw_Lst_Detail.GetItemNumber ( lCpt, "COD_ETAT" ) = 600	Then
							stMessage.sTitre		= "Contrôle sur la garantie"
							stMessage.Icon			= Information!
							stMessage.sVar[1]		= String ( dw_Lst_Detail.GetItemNumber ( lCpt, "ID_DETAIL" ) )
							stMessage.bErreurG	= False
							stMessage.sCode		= "WGAR150"

							f_Message ( stMessage )
							bRet = False
							Exit
							
						End If
				Next

				If	bRet Then
					This.dw_Trt.SetItem ( lLigne, "ALT_INIT_ID_I", "N" )
					This.dw_Trt.SetItem ( lLigne, "ALT_OPE", "O" )
				End If				

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
//
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

type dw_wpiece_detail from datawindow within w_tm_sp_w_gar_sin
boolean visible = false
integer x = 3282
integer y = 724
integer width = 247
integer height = 112
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_w_piece_detail"
end type

type dw_wrefus_detail from datawindow within w_tm_sp_w_gar_sin
boolean visible = false
integer x = 3282
integer y = 576
integer width = 247
integer height = 112
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_w_refus_detail"
end type

type dw_wdetail_supp from datawindow within w_tm_sp_w_gar_sin
boolean visible = false
integer x = 3282
integer y = 428
integer width = 247
integer height = 112
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_lst_sin_w_detail_supp"
end type

type dw_wpplafond_detail from datawindow within w_tm_sp_w_gar_sin
boolean visible = false
integer x = 3282
integer y = 872
integer width = 247
integer height = 112
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_w_para_plafond_detail"
end type

type dw_wpplafond_gti from datawindow within w_tm_sp_w_gar_sin
boolean visible = false
integer x = 3282
integer y = 1020
integer width = 247
integer height = 112
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_w_para_plafond_gti"
end type

type dw_wparaplafond from datawindow within w_tm_sp_w_gar_sin
boolean visible = false
integer x = 3282
integer y = 1168
integer width = 247
integer height = 112
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_w_para_plafond"
end type

type uo_consult_euro from u_consultation_euro within w_tm_sp_w_gar_sin
integer x = 1221
integer y = 8
integer taborder = 130
end type

on uo_consult_euro.destroy
call u_consultation_euro::destroy
end on

type dw_w_commande from u_datawindow_detail within w_tm_sp_w_gar_sin
boolean visible = false
integer x = 3282
integer y = 1308
integer width = 247
integer height = 112
integer taborder = 20
boolean enabled = false
string dataobject = "d_gs_w_commande"
boolean livescroll = false
end type

type cb_tarif from commandbutton within w_tm_sp_w_gar_sin
integer x = 1481
integer y = 36
integer width = 448
integer height = 108
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Tarifs des Papiers"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: W_Tm_Sp_W_Gar_Sin::Cb_Tarif			(EXTEND)
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

type dw_w_div_det from u_datawindow_detail within w_tm_sp_w_gar_sin
boolean visible = false
integer x = 3287
integer y = 1448
integer width = 247
integer height = 112
integer taborder = 30
boolean enabled = false
string dataobject = "d_lst_w_div_det"
boolean vscrollbar = true
boolean livescroll = false
end type

type cb_valid_factu from commandbutton within w_tm_sp_w_gar_sin
integer x = 1943
integer y = 8
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
//* Objet			: w_tm_sp_w_gar_sin:cb_valid_factu
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

Parent.TriggerEvent("ue_controler")

if pb_valider.Enabled=TRUE Then
	pb_valider.Enabled=FALSE
	Parent.TriggerEvent ( "ue_Valider" )
End if
end event

type st_mode_reprise from statictext within w_tm_sp_w_gar_sin
integer x = 2501
integer y = 84
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

type cb_aide_mode_reprise from commandbutton within w_tm_sp_w_gar_sin
integer x = 3232
integer y = 84
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

