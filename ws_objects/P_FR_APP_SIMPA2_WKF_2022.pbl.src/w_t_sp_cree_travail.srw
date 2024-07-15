HA$PBExportHeader$w_t_sp_cree_travail.srw
$PBExportComments$-} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement SIMPLE pour la cr$$HEX1$$e900$$ENDHEX$$ation d'un travail.
forward
global type w_t_sp_cree_travail from w_8_traitement
end type
type uo_3d from u_bord3d within w_t_sp_cree_travail
end type
type uo_ong from u_onglets within w_t_sp_cree_travail
end type
type dw_wkf_inter from datawindow within w_t_sp_cree_travail
end type
type dw_wkf_routage from datawindow within w_t_sp_cree_travail
end type
type dw_wkf_sinistre from datawindow within w_t_sp_cree_travail
end type
type p_focus from picture within w_t_sp_cree_travail
end type
type dw_wkf_sinistres_lies from datawindow within w_t_sp_cree_travail
end type
type dw_edms_clx_adh from datawindow within w_t_sp_cree_travail
end type
type dw_edms_pxxx_adh from datawindow within w_t_sp_cree_travail
end type
type dw_edms_cic_adh from datawindow within w_t_sp_cree_travail
end type
type dw_option_adh from datawindow within w_t_sp_cree_travail
end type
type dw_banque from datawindow within w_t_sp_cree_travail
end type
type dw_wkf_homonyme from datawindow within w_t_sp_cree_travail
end type
type dw_adh from datawindow within w_t_sp_cree_travail
end type
type dw_edms_clx_mvts from datawindow within w_t_sp_cree_travail
end type
type dw_edms_pxxx_mvts from datawindow within w_t_sp_cree_travail
end type
type dw_edms_cic_mvts from datawindow within w_t_sp_cree_travail
end type
type dw_mvts from datawindow within w_t_sp_cree_travail
end type
type st_pochette from statictext within w_t_sp_cree_travail
end type
type dw_edms_sri_adh from datawindow within w_t_sp_cree_travail
end type
type dw_edms_sri_mvts from datawindow within w_t_sp_cree_travail
end type
type dw_edms_tel_adh from datawindow within w_t_sp_cree_travail
end type
type dw_edms_tel_mvts from datawindow within w_t_sp_cree_travail
end type
type dw_dossuivipar from datawindow within w_t_sp_cree_travail
end type
type dw_edms_sri_ref_facturation from datawindow within w_t_sp_cree_travail
end type
type dw_edms_sri_lig_facturation from datawindow within w_t_sp_cree_travail
end type
type cb_tarif from commandbutton within w_t_sp_cree_travail
end type
type st_message from statictext within w_t_sp_cree_travail
end type
type cb_aide from u_aidecontrat within w_t_sp_cree_travail
end type
type cb_notice from u_aidecontrat within w_t_sp_cree_travail
end type
type cb_1 from commandbutton within w_t_sp_cree_travail
end type
end forward

global type w_t_sp_cree_travail from w_8_traitement
integer x = 0
integer y = 0
integer width = 3598
integer height = 1768
string title = "Gestion des travaux"
event ue_quitteronglet011 pbm_custom01
event ue_sinistres_lies pbm_custom02
event ue_homonyme pbm_custom03
event ue_ouvrir_fensaisie pbm_custom04
uo_3d uo_3d
uo_ong uo_ong
dw_wkf_inter dw_wkf_inter
dw_wkf_routage dw_wkf_routage
dw_wkf_sinistre dw_wkf_sinistre
p_focus p_focus
dw_wkf_sinistres_lies dw_wkf_sinistres_lies
dw_edms_clx_adh dw_edms_clx_adh
dw_edms_pxxx_adh dw_edms_pxxx_adh
dw_edms_cic_adh dw_edms_cic_adh
dw_option_adh dw_option_adh
dw_banque dw_banque
dw_wkf_homonyme dw_wkf_homonyme
dw_adh dw_adh
dw_edms_clx_mvts dw_edms_clx_mvts
dw_edms_pxxx_mvts dw_edms_pxxx_mvts
dw_edms_cic_mvts dw_edms_cic_mvts
dw_mvts dw_mvts
st_pochette st_pochette
dw_edms_sri_adh dw_edms_sri_adh
dw_edms_sri_mvts dw_edms_sri_mvts
dw_edms_tel_adh dw_edms_tel_adh
dw_edms_tel_mvts dw_edms_tel_mvts
dw_dossuivipar dw_dossuivipar
dw_edms_sri_ref_facturation dw_edms_sri_ref_facturation
dw_edms_sri_lig_facturation dw_edms_sri_lig_facturation
cb_tarif cb_tarif
st_message st_message
cb_aide cb_aide
cb_notice cb_notice
cb_1 cb_1
end type
global w_t_sp_cree_travail w_t_sp_cree_travail

type variables
Private :

	U_Gs_Sp_Cree_Wkf	iuoGsSpWkf


	Long			ilNbrHomonyme
	Long			ilMaxHomonyme = 50


end variables

forward prototypes
private subroutine wf_positionnerobjets ()
public function string wf_controlersaisie ()
public function boolean wf_preparermodifier ()
public function boolean wf_preparerinserer ()
public function boolean wf_valider ()
end prototypes

on ue_quitteronglet011;call w_8_traitement::ue_quitteronglet011;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Cree_Travail::Ue_QuitterOngler011
//* Evenement 		: Ue_QuitterOngler011
//* Auteur			: Erick John Stark
//* Date				: 05/02/1998 15:50:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lIdProd, lIdEts, lIdsDos

String sIdAdh

If	dw_1.AcceptText () > 0 Then
	If	dw_1.RowCount () > 0 Then
		lIdProd	= dw_1.GetItemNumber ( 1, "ID_PROD" )
		lIdEts	= dw_1.GetItemNumber ( 1, "ID_ETS" )
		sIdAdh	= dw_1.GetItemString ( 1, "ID_ADH" )
		lIdsDos	= dw_1.GetItemNumber ( 1, "ID_SDOS" )

		If	IsNull ( lIdProd ) Or IsNull ( lIdEts ) Or IsNull ( sIdAdh ) Or IsNull ( lIdsDos ) Then
			uo_Ong.ibStop = True
		End If
	End If
End If


end on

on ue_sinistres_lies;call w_8_traitement::ue_sinistres_lies;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Cree_Travail::Ue_Sinistres_Lies
//* Evenement 		: Ue_Sinistres_Lies
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 14:29:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass	stPass_Dga

/*------------------------------------------------------------------*/
/* Cet $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement est d$$HEX1$$e900$$ENDHEX$$clench$$HEX2$$e9002000$$ENDHEX$$par la fen$$HEX1$$ea00$$ENDHEX$$tre de recherche des      */
/* sinistres li$$HEX1$$e900$$ENDHEX$$s. Il faut r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer le param$$HEX1$$e800$$ENDHEX$$tre pour savoir si    */
/* on prend la r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence de la personne, ou si on abandonne.        */
/*------------------------------------------------------------------*/
stPass_Dga.lTab[1] = Message.LongParm

iuoGsSpWkf.Uf_Traitement ( 8, stPass_Dga )

end on

on ue_homonyme;call w_8_traitement::ue_homonyme;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Cree_Travail::Ue_Homonyme
//* Evenement 		: Ue_Sinistres_Lies
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 14:29:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lIdOrdre

/*------------------------------------------------------------------*/
/* Cet $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement est d$$HEX1$$e900$$ENDHEX$$clench$$HEX2$$e9002000$$ENDHEX$$par la fen$$HEX1$$ea00$$ENDHEX$$tre de recherche des      */
/* homonymes. Il faut r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer le param$$HEX1$$e800$$ENDHEX$$tre pour conna$$HEX1$$ee00$$ENDHEX$$tre le N$$HEX4$$b000200020002000$$ENDHEX$$*/
/* d'ordre.                                                         */
/*------------------------------------------------------------------*/
lIdOrdre = Message.LongParm

If	lIdOrdre <> 0 Then
	dw_1.SetItem ( 1, "ID_ORDRE", lIdOrdre )
	dw_1.SetItem ( 1, "COD_PROV_PERS", "P" )
End If

This.Pb_Controler.Enabled = False
This.Pb_Valider.Enabled = True

This.SetFocus ()
pb_Valider.SetFocus ()




end on

on ue_ouvrir_fensaisie;call w_8_traitement::ue_ouvrir_fensaisie;//*-----------------------------------------------------------------
//*
//* Objet			: Dw_1
//* Evenement 		: ue_Ouvrir_FenSaisie
//* Auteur			: FABRY JF
//* Date				: 09/05/2001 14:02:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Overture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil dce saisie de sinistre
//* Commentaires	: 
//*				 
//* Arguments		: 
//*
//* Retourne		: NotFound
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
String sMesErr

sMesErr = stGlb.sMessageErreur
stGlb.sMessageErreur = String ( Dw_1.GetItemNumber ( 1, "ID_SIN" ) )

/*----------------------------------------------------------------------------*/
/* Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil de saisie de sinistre.                   */
/*----------------------------------------------------------------------------*/
SetPointer ( HourGlass! )

If IsValid ( W_a_Sp_Wkf_Saisie ) Then 
	W_a_Sp_Wkf_Saisie.Show()
Else
	OpenSheetWithParm ( W_a_Sp_Wkf_Saisie, stGLB, W_Mdi_Sp, 0, Layered! )
End If

W_a_Sp_Wkf_Saisie.BringToTop = True

W_a_Sp_Wkf_Saisie.TriggerEvent ("ue_Saisie_Automatique")

stGlb.sMessageErreur = sMesErr
end on

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_T_Sp_Cree_Wkf::Wf_PositionnerObjets (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 15:27:47
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On positionne et on taille tous les objets
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ 			PAR		Date		Modification
//* DCMP990451 JFF		29/09/99 On positionne le static text informant 
//*										de l'ouverture d'une pochette ou pas.
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne tous les objets n$$HEX1$$e900$$ENDHEX$$cessaires $$HEX2$$e0002000$$ENDHEX$$la gestion, pour     */
/* faciliter le d$$HEX1$$e900$$ENDHEX$$veloppement. (On peut bouger les objets).         */
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
Dw_1.Width		= 3510
Dw_1.Height		= 1345

Dw_Adh.X			=   33
Dw_Adh.Y			=  273
Dw_Adh.Width	= 3510
Dw_Adh.Height	= 1345

/*------------------------------------------------------------------*/
/* Le static Text : St_Pochette DCMP990451								  */
/*------------------------------------------------------------------*/
st_Pochette.X			= 1710
st_Pochette.Y			=   13
st_Pochette.Width		= 1852
st_Pochette.Height	=  205


dw_DosSuiviPar.X = 2026
dw_DosSuiviPar.Y = 57
dw_DosSuiviPar.width = 1495
dw_DosSuiviPar.Height = 101
end subroutine

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_T_Sp_Cree_Travail::Wf_ControlerSaisie (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:50:46
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Contr$$HEX1$$f400$$ENDHEX$$le de la saisie
//*
//* Arguments		: Aucun
//*
//* Retourne		: String			"" = Tout va bien
//*
//*-----------------------------------------------------------------
//* MAJ 			PAR		Date		Modification
//*-----------------------------------------------------------------

Long		lPochette
Long 		lTotHomonyme

s_Pass	stPass_Dga

iuoGsSpWkf.Uf_Traitement ( 4, stPass_Dga )

/*------------------------------------------------------------------*/
/*  Le controle de saisie se passe bien, on v$$HEX1$$e900$$ENDHEX$$rifie s'il existe     */
/* des homonymes dans la DW. Il faut v$$HEX1$$e900$$ENDHEX$$rifier le traitement dans    */
/* la fonction Uf_ControlerSaisie () si besoin.                     */
/*------------------------------------------------------------------*/
If	stPass_Dga.sTab [ 1 ] = ""	Then
	lTotHomonyme = dw_Wkf_Homonyme.RowCount ()

	If	lTotHomonyme > 0 Then
		stPass_Dga.trTrans 	= itrTrans
		stPass_Dga.wParent	= This
		stPass_Dga.dwNorm[1] = dw_Wkf_Homonyme

		OpenWithParm ( W_T_Sp_Homonyme, stPass_Dga, stPass_Dga.wParent.ParentWindow () )	
	End If

End If

Return ( stPass_Dga.sTab [ 1 ] ) 




end function

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_T_Sp_Cree_Travail::Wf_PreparerModifier
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 18:25:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Op$$HEX1$$e900$$ENDHEX$$ration avant modification
//*
//* Arguments		: Rien
//*
//* Retourne		: Boolean		Vrai = On peut continuer
//*										Faux = Il y a une erreur
//*
//*-----------------------------------------------------------------

s_Pass	stPass_Dga

stPass_Dga.sTab [ 1 ] = istPass.sTab [ 1 ]			// ID_SIN en cours de traitement

iuoGsSpWkf.Uf_Traitement ( 3, stPass_Dga )

Return ( stPass_Dga.bRetour )

end function

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_T_Sp_Cree_Travail::Wf_PreparerInserer
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 18:25:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Op$$HEX1$$e900$$ENDHEX$$ration avant insertion
//*
//* Arguments		: Rien
//*
//* Retourne		: Boolean		Vrai = On peut continuer
//*										Faux = Il y a une erreur
//*
//*-----------------------------------------------------------------

s_Pass	stPass_Dga

stPass_Dga.sTab [3] = istPass.sTab [3] // DEC par TEL ou Normale

iuoGsSpWkf.Uf_Traitement ( 2, stPass_Dga )

/*------------------------------------------------------------------*/
/* Le 28/11/2001.                                                   */
/* Modif DGA. DCMP 010375                                           */
/*------------------------------------------------------------------*/
If	IsValid ( W_Trt_Popup_AidePapier )	Then Close ( W_Trt_Popup_AidePapier )

Return ( stPass_Dga.bRetour )

end function

public function boolean wf_valider ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_T_Sp_Cree_Travail::Wf_Valider (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 18:25:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On g$$HEX1$$e900$$ENDHEX$$re enti$$HEX1$$e900$$ENDHEX$$rement la validation, sans faire appel $$HEX2$$e0002000$$ENDHEX$$la fonction anc$$HEX1$$ea00$$ENDHEX$$tre
//*
//* Arguments		: Rien
//*
//* Retourne		: Boolean		Vrai = On peut continuer
//*										Faux = Il y a une erreur
//*
//*-----------------------------------------------------------------
//* MAJ 			PAR		Date		Modification
//* DCMP990451	JFF		29/09/99 Affichage du message d'ouverture de 
//*										de pochette				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Dans la fonction du NVUO, on va appeler la fonction de           */
/* validation. Il n'y a pas besoin de faire d'Update sur DW_1. Il   */
/* n'y a pas besoin de faire appel aux fonctions                    */
/* Uf_PreparerValider (), Uf_ExecuterValider (),                    */
/* Uf_TerminerValider (). La gestion du COMMIT ou du ROLLBACK, est  */
/* du ressort du NVUO.                                              */
/*------------------------------------------------------------------*/

s_Pass	stPass_Dga

iuoGsSpWkf.Uf_Traitement ( 7, stPass_Dga )


/*------------------------------------------------------------------*/
/* Modif suite DCMP990451                                           */
/*------------------------------------------------------------------*/
If stPass_Dga.bRetour Then	st_Pochette.Hide()

/*----------------------------------------------------------------------------*/
/* Ouverture automatique de la fen$$HEX1$$ea00$$ENDHEX$$tre de sinistre.                           */
/*----------------------------------------------------------------------------*/
CHOOSE CASE istPass.sTab [3]
	CASE "TEL", "COURRIER"
		This.TriggerEvent ( "ue_Ouvrir_FenSaisie" )
END CHOOSE



Return ( stPass_Dga.bRetour )





end function

on ue_initialiser;call w_8_traitement::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Cree_Travail::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:59:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass stPass_Dga
DataWindow	dwNorm[]

Wf_PositionnerObjets ()

/*------------------------------------------------------------------*/
/* On commence $$HEX2$$e0002000$$ENDHEX$$initialiser les NVUO.                              */
/*------------------------------------------------------------------*/
iuoGsSpWkf = Create U_Gs_Sp_Cree_Wkf

/*------------------------------------------------------------------*/
/* Ces fonctions sont issues du NVUO anc$$HEX1$$ea00$$ENDHEX$$tre.                       */
/*------------------------------------------------------------------*/
iuoGsSpWkf.Uf_Initialisation ( dw_1, itrTrans, Uo_Ong, st_Pochette, st_Message )

/*------------------------------------------------------------------*/
/* Cette fonction n'appartient qu'au NVUO descendant.               */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On arme les DW dans le bon ordre. (SVP)                          */
/*------------------------------------------------------------------*/
dwNorm[ 1] = dw_Wkf_Inter
dwNorm[ 2] = dw_Wkf_Routage
dwNorm[ 3] = dw_Wkf_Sinistre
dwNorm[ 4] = dw_Wkf_Sinistres_Lies

dwNorm[ 5] = dw_Edms_Clx_Adh
dwNorm[ 6] = dw_Edms_Pxxx_Adh
dwNorm[ 7] = dw_Edms_Cic_Adh

dwNorm[ 8] = dw_Edms_Clx_Mvts
dwNorm[ 9] = dw_Edms_Pxxx_Mvts
dwNorm[10] = dw_Edms_Cic_Mvts

dwNorm[11] = dw_Option_Adh
dwNorm[12] = dw_Adh
dwNorm[13] = dw_Mvts
dwNorm[14] = dw_Wkf_Homonyme

dwNorm[15] = dw_Edms_Sri_Adh
dwNorm[16] = dw_Edms_Sri_Mvts

dwNorm[17] = dw_Edms_Tel_Adh
dwNorm[18] = dw_Edms_Tel_Mvts

dwNorm[19] = dw_DosSuiviPar
/*------------------------------------------------------------------*/
/* Le 26/09/2001. Modification DGA (Suite demande AMO LUC).         */
/* Facturation ESPRIT LIBRE DCMP 010302                             */
/*------------------------------------------------------------------*/
dwNorm[20] = dw_Edms_Sri_Ref_Facturation
dwNorm[21] = dw_Edms_Sri_Lig_Facturation

iuoGsSpWkf.Uf_Initialiser_Dw_Desc ( dwNorm[] )

/*------------------------------------------------------------------*/
/* Initialisation de l'onglet.                                      */
/*------------------------------------------------------------------*/
Uo_Ong.Uf_Initialiser ( 3, 1 )
Uo_Ong.Uf_EnregistrerOnglet ( "01", "Travail", 		"", dw_1,			True )
Uo_Ong.Uf_EnregistrerOnglet ( "02", "Adh$$HEX1$$e900$$ENDHEX$$sion", 	"", dw_Adh,			False )
Uo_Ong.Uf_EnregistrerOnglet ( "03", "R$$HEX1$$e900$$ENDHEX$$ponses", 	"", dw_1,			False )

Uo_Ong.Uf_ActiverOnglet ( "03", False )

iuoGsSpWkf.Uf_Traitement ( 1, stPass_Dga )

/*------------------------------------------------------------------*/
/* Initialisation de l'objet u_AideContrat                          */
/*------------------------------------------------------------------*/
cb_Aide.uf_Initialiser ( "AIDE", "Aide" )
cb_Notice.uf_Initialiser ( "NOTICE", "Notice" )

end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Cree_Travail::Close
//* Evenement 		: Close
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 18:46:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Fermeture d$$HEX1$$e900$$ENDHEX$$finitive de la fen$$HEX1$$ea00$$ENDHEX$$tre.
//*				     On supprime tous les NVUO.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//Destroy iUoGsSpWkf
If IsValid(iUoGsSpWkf) Then Destroy iUoGsSpWkf
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Le 28/11/2001.                                                   */
/* Modif DGA. DCMP 010375                                           */
/*------------------------------------------------------------------*/
If	IsValid ( W_Trt_Popup_AidePapier )	Then Close ( W_Trt_Popup_AidePapier )


end event

on ue_majaccueil;call w_8_traitement::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Cree_Travail::Ue_MajAccueil
//* Evenement 		: Ue_MajAccueil
//* Auteur			: Erick John Stark
//* Date				: 28/08/1998 16:03:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Construction de la chaine pour mettre $$HEX2$$e0002000$$ENDHEX$$jour la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild dwChild
String 	sTab, sCreeLe, sLibCourt, sNom, sIdSin, sRech
Long lLig, lTotprod

dw_1.GetChild ( "ID_PROD", dwChild )
lLig = dwChild.GetRow ()

If	dw_1.GetItemString ( 1, "COD_TYP_RECU" ) = "D"	Then
	sLibCourt	= dwChild.GetItemString ( lLig, "LIB_COURT" )
Else
	lTotProd		= dwChild.RowCount ()
	sRech			= "ID_PROD = " + String ( dw_1.GetItemNumber ( 1, "ID_PROD" ) )
	lLig			= dwChild.Find ( sRech, 1, lTotProd )

	sLibCourt	= dwChild.GetItemString ( lLig, "LIB_COURT" )
End If
 
sIdSin		= String ( dw_1.GetItemNumber ( 1, "ID_SIN" ) )
sNom			= dw_1.GetItemString ( 1, "NOM" ) + " " + dw_1.GetItemString ( 1, "PRENOM" )
sCreeLe		= String ( dw_1.GetItemDateTime ( 1, "CREE_LE" ), "dd/mm/yyyy hh:mm" )

sTab    = "~t"

isMajAccueil	= sCreeLe		+ sTab + &
					  sLibCourt		+ sTab + &
					  sIdSin			+ sTab + &
					  sNom			+ sTab
					

end on

on ue_retour;call w_8_traitement::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_sp_cree_travail
//* Evenement 		: ue_Retour
//* Auteur			: Fabry JF
//* Date				: 29/09/1999 11:08:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Click sur le bouton Retour
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* DCMP990451                                           				  */
/*------------------------------------------------------------------*/
st_Pochette.Hide()
/*------------------------------------------------------------------*/
/* Le 28/11/2001.                                                   */
/* Modif DGA. DCMP 010375                                           */
/*------------------------------------------------------------------*/
If	IsValid ( W_Trt_Popup_AidePapier )	Then Close ( W_Trt_Popup_AidePapier )

end on

event we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Cree_Travail::We_ChildActivate (OVERRIDE !!)
//* Evenement 		: We_ChildActivate
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:53:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
Boolean					bOk
w_traitement_master	wMasterParent

If ( ibAInitialiser ) Then

	ibAInitialiser  = False

	istPass = Message.PowerObjectParm

	itrTrans						=  istPass.trTrans	// Objet transaction de la fenetre appelante
	iwParent						=	istPass.wParent	// Fenetre Appelante ( utilis$$HEX1$$e900$$ENDHEX$$e pour enable )	

	istPass.wParent			=	This			// Fenetre appelante pour fenetre de traitment
	istPass.trTrans			=	itrTrans		// Objet de transaction par defaut
//	istPass.bEnableParent	= 	False			// Doit on rendre la fenetre appelante disable
														// lors de l'appel d'une fen$$HEX1$$ea00$$ENDHEX$$tre de traitement	This.TriggerEvent ( "ue_Initialiser" )
//	istPass.bCloseRetour		=	False			// Doit on fermer la fen$$HEX1$$ea00$$ENDHEX$$tre sur le bouton retour. D$$HEX1$$e900$$ENDHEX$$cision du script client

	wf_ActiverMajAccueil( True )	

	// Si il s'agit d'une fen$$HEX1$$ea00$$ENDHEX$$tre fille d'un master on la stock pour pouvoir la fermer

	If ( ibOpen ) Then

		If ( iwParent.WindowType = Child! ) Or ( iwParent.windowType = Popup! ) Then

			CHOOSE CASE istPass.sTab[2]
	
				CASE "WORKFLOW_EN_SAISIE"
					wMasterParent = iwParent
					wMasterParent.wf_AjouterDetail( This )

				CASE "WORKFLOW_EN_CONSULT_SAISIE", "WORKFLOW_EN_CONSULT_PERM"

					// Aucune affectation, les fen$$HEX1$$ea00$$ENDHEX$$tres ne sont pas du m$$HEX1$$ea00$$ENDHEX$$me types.					

			END CHOOSE
		End If

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
		Dw_1.Reset ()
		Dw_1.InsertRow ( 0 )
		f_CreeLe ( Dw_1, 1 )
		f_MajPar ( Dw_1, 1 )
		bOk = wf_PreparerInserer ()
	
	Else

		pb_Supprimer.Enabled = istPass.bSupprime
		bOk = wf_PreparerModifier ()

	End If

	// Arr$$HEX1$$ea00$$ENDHEX$$t d'ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre si probl$$HEX1$$e800$$ENDHEX$$me

	If Not bOk Then

		This.TriggerEvent ( "ue_retour" )
	Else
		wf_Changer_Controle( Dw_1 )

		If ( ibModeDetail ) Then

/*------------------------------------------------------------------*/
/* Uniquement pour que la datawindow puisse retrouver ses petits    */
/* lors d'un RowCopy. ( Bug Pb )                                    */
/*------------------------------------------------------------------*/

			dw_1.SetSort(dw_1.isTri)
			dw_1.Sort()

		End If

		This.Show()
		Dw_1.SetFocus ()

	End If

End If

CHOOSE CASE istPass.sTab[2]

	CASE "WORKFLOW_EN_SAISIE"
		This.X			=    1
		This.Y			=    1
		This.Height		= 1769
		This.Width		= 3598

	CASE "WORKFLOW_EN_CONSULT_SAISIE", "WORKFLOW_EN_CONSULT_PERM"

		// On cache la fen$$HEX1$$ea00$$ENDHEX$$tre en la d$$HEX1$$e900$$ENDHEX$$portant hors de l'$$HEX1$$e900$$ENDHEX$$cran
		This.X			= 10000
		This.Y			= 10000
		This.Height		= 1769
		This.Width		= 3598

END CHOOSE

end event

on w_t_sp_cree_travail.create
int iCurrent
call super::create
this.uo_3d=create uo_3d
this.uo_ong=create uo_ong
this.dw_wkf_inter=create dw_wkf_inter
this.dw_wkf_routage=create dw_wkf_routage
this.dw_wkf_sinistre=create dw_wkf_sinistre
this.p_focus=create p_focus
this.dw_wkf_sinistres_lies=create dw_wkf_sinistres_lies
this.dw_edms_clx_adh=create dw_edms_clx_adh
this.dw_edms_pxxx_adh=create dw_edms_pxxx_adh
this.dw_edms_cic_adh=create dw_edms_cic_adh
this.dw_option_adh=create dw_option_adh
this.dw_banque=create dw_banque
this.dw_wkf_homonyme=create dw_wkf_homonyme
this.dw_adh=create dw_adh
this.dw_edms_clx_mvts=create dw_edms_clx_mvts
this.dw_edms_pxxx_mvts=create dw_edms_pxxx_mvts
this.dw_edms_cic_mvts=create dw_edms_cic_mvts
this.dw_mvts=create dw_mvts
this.st_pochette=create st_pochette
this.dw_edms_sri_adh=create dw_edms_sri_adh
this.dw_edms_sri_mvts=create dw_edms_sri_mvts
this.dw_edms_tel_adh=create dw_edms_tel_adh
this.dw_edms_tel_mvts=create dw_edms_tel_mvts
this.dw_dossuivipar=create dw_dossuivipar
this.dw_edms_sri_ref_facturation=create dw_edms_sri_ref_facturation
this.dw_edms_sri_lig_facturation=create dw_edms_sri_lig_facturation
this.cb_tarif=create cb_tarif
this.st_message=create st_message
this.cb_aide=create cb_aide
this.cb_notice=create cb_notice
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_3d
this.Control[iCurrent+2]=this.uo_ong
this.Control[iCurrent+3]=this.dw_wkf_inter
this.Control[iCurrent+4]=this.dw_wkf_routage
this.Control[iCurrent+5]=this.dw_wkf_sinistre
this.Control[iCurrent+6]=this.p_focus
this.Control[iCurrent+7]=this.dw_wkf_sinistres_lies
this.Control[iCurrent+8]=this.dw_edms_clx_adh
this.Control[iCurrent+9]=this.dw_edms_pxxx_adh
this.Control[iCurrent+10]=this.dw_edms_cic_adh
this.Control[iCurrent+11]=this.dw_option_adh
this.Control[iCurrent+12]=this.dw_banque
this.Control[iCurrent+13]=this.dw_wkf_homonyme
this.Control[iCurrent+14]=this.dw_adh
this.Control[iCurrent+15]=this.dw_edms_clx_mvts
this.Control[iCurrent+16]=this.dw_edms_pxxx_mvts
this.Control[iCurrent+17]=this.dw_edms_cic_mvts
this.Control[iCurrent+18]=this.dw_mvts
this.Control[iCurrent+19]=this.st_pochette
this.Control[iCurrent+20]=this.dw_edms_sri_adh
this.Control[iCurrent+21]=this.dw_edms_sri_mvts
this.Control[iCurrent+22]=this.dw_edms_tel_adh
this.Control[iCurrent+23]=this.dw_edms_tel_mvts
this.Control[iCurrent+24]=this.dw_dossuivipar
this.Control[iCurrent+25]=this.dw_edms_sri_ref_facturation
this.Control[iCurrent+26]=this.dw_edms_sri_lig_facturation
this.Control[iCurrent+27]=this.cb_tarif
this.Control[iCurrent+28]=this.st_message
this.Control[iCurrent+29]=this.cb_aide
this.Control[iCurrent+30]=this.cb_notice
this.Control[iCurrent+31]=this.cb_1
end on

on w_t_sp_cree_travail.destroy
call super::destroy
destroy(this.uo_3d)
destroy(this.uo_ong)
destroy(this.dw_wkf_inter)
destroy(this.dw_wkf_routage)
destroy(this.dw_wkf_sinistre)
destroy(this.p_focus)
destroy(this.dw_wkf_sinistres_lies)
destroy(this.dw_edms_clx_adh)
destroy(this.dw_edms_pxxx_adh)
destroy(this.dw_edms_cic_adh)
destroy(this.dw_option_adh)
destroy(this.dw_banque)
destroy(this.dw_wkf_homonyme)
destroy(this.dw_adh)
destroy(this.dw_edms_clx_mvts)
destroy(this.dw_edms_pxxx_mvts)
destroy(this.dw_edms_cic_mvts)
destroy(this.dw_mvts)
destroy(this.st_pochette)
destroy(this.dw_edms_sri_adh)
destroy(this.dw_edms_sri_mvts)
destroy(this.dw_edms_tel_adh)
destroy(this.dw_edms_tel_mvts)
destroy(this.dw_dossuivipar)
destroy(this.dw_edms_sri_ref_facturation)
destroy(this.dw_edms_sri_lig_facturation)
destroy(this.cb_tarif)
destroy(this.st_message)
destroy(this.cb_aide)
destroy(this.cb_notice)
destroy(this.cb_1)
end on

type dw_1 from w_8_traitement`dw_1 within w_t_sp_cree_travail
integer x = 41
integer y = 328
integer width = 530
integer height = 460
integer taborder = 30
string dataobject = "d_sp_w_queue"
boolean border = false
boolean livescroll = false
end type

event dw_1::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Cree_Travail::dw_1
//* Evenement 		: ItemChanged
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:35:04
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Modification des zones
//*				  
//*-----------------------------------------------------------------
//* MAJ 			PAR		Date		Modification
//*-----------------------------------------------------------------

String	sPochette
s_Pass	stPass_Dga
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

stPass_Dga.sTab[2] = istPass.sTab[2]

/*------------------------------------------------------------------*/
/* Si on est en Saisie, on lance le traitement des zones.           */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//iuoGsSpWkf.Uf_Zn_Trt ( stPass_Dga )
ll_ret = iuoGsSpWkf.Uf_Zn_Trt ( stPass_Dga )
//Fin Migration PB8-WYNIWYG-03/2006 FM


Choose Case This.isNomCol

Case "ID_ADH", "ID_SDOS"

	If	stPass_Dga.lTab[1] > 0 Then
		stPass_Dga.trTrans 	= itrTrans
		stPass_Dga.wParent	= Parent
		stPass_Dga.dwNorm[1] = dw_Wkf_Sinistres_Lies

		OpenWithParm ( W_T_Sp_Sinistres_Lies, stPass_Dga, stPass_Dga.wParent.ParentWindow () )
	End If

End Choose

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Cree_Travail::dw_1
//* Evenement 		: ItemError
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:47:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion des messages d'erreur
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	ibErreur Then

	stMessage.sTitre		= "Cr$$HEX1$$e900$$ENDHEX$$ation d'un travail - SIMPA2"
	stMessage.Icon			= Information!

	stMessage.bErreurG	= TRUE

	Choose Case isErrCol
	Case "DTE_COUR_CLI"
		Choose Case This.iiErreur
		Case 0
			stMessage.sVar[1] = "date du courrier client"		// Erreur de Validation - Date sup$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$date du jour
			stMessage.sCode	= "GENE002"
		Case 1
			stMessage.sVar[1] = "date du courrier client"		// Date du courrier client > Date Recu
			stMessage.sVar[2] = "inf$$HEX1$$e900$$ENDHEX$$rieure ou $$HEX1$$e900$$ENDHEX$$gale"
			stMessage.sVar[3] = "date de r$$HEX1$$e900$$ENDHEX$$ception SPB"
			stMessage.sCode	= "GENE007"
		Case 2
			stMessage.sVar[1] = "date du courrier client"		// Date du courrier client < Date de survenance
			stMessage.sVar[2] = "sup$$HEX1$$e900$$ENDHEX$$rieure ou $$HEX1$$e900$$ENDHEX$$gale"
			stMessage.sVar[3] = "date de survenance"
			stMessage.sCode	= "GENE007"
		End Choose

	Case "DTE_RECU"
		Choose Case This.iiErreur
		Case 0
			stMessage.sVar[1] = "date de r$$HEX1$$e900$$ENDHEX$$ception"				// Erreur de Validation - Date sup$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$date du jour
			stMessage.sCode	= "GENE002"
		Case 1
			stMessage.sVar[1] = "date de r$$HEX1$$e900$$ENDHEX$$ception SPB"			// Date du courrier client > Date Recu
			stMessage.sVar[2] = "sup$$HEX1$$e900$$ENDHEX$$rieure ou $$HEX1$$e900$$ENDHEX$$gale"
			stMessage.sVar[3] = "date du courrier client"		
			stMessage.sCode	= "GENE007"
		Case 2
			stMessage.sVar[1] = "date de r$$HEX1$$e900$$ENDHEX$$ception SPB"			// Date Recu < Date de survenance
			stMessage.sVar[2] = "sup$$HEX1$$e900$$ENDHEX$$rieure ou $$HEX1$$e900$$ENDHEX$$gale"
			stMessage.sVar[3] = "date de survenance"
			stMessage.sCode	= "GENE007"
		End Choose

	Case "NB_PAGE"
		Choose Case This.iiErreur
		Case 0
			stMessage.bErreurG= False									// Erreur de Validation - Le nombre de page est inf$$HEX1$$e900$$ENDHEX$$rieur $$HEX2$$e0002000$$ENDHEX$$0
			stMessage.sCode	= "WORK110"
		End Choose

	Case "ID_SIN"
		Choose Case This.iiErreur
		Case 0
			stMessage.sVar[1] = "r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence sinistre"				// Erreur de Validation - 
			stMessage.sCode	= "GENE002"
		Case 1
			stMessage.bErreurG= False									// Erreur de saisie - Le N$$HEX2$$b0002000$$ENDHEX$$de r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence sinistre n'existe pas
			stMessage.sCode	= "WORK100"
		End Choose

	Case "ID_ADH"
/*------------------------------------------------------------------*/
/* Pour la zone ID_ADH, on garde la valeur que la personne vient    */
/* de saisir.                                                       */
/*------------------------------------------------------------------*/
		This.iiReset = 2

		Choose Case This.iiErreur
		Case 0
			stMessage.sVar[1] = "num$$HEX1$$e900$$ENDHEX$$ro d'adh$$HEX1$$e900$$ENDHEX$$sion"				// Erreur de Validation - 
			stMessage.sCode	= "GENE003"
		Case 1
			stMessage.bErreurG= False									// Erreur de saisie - Le N$$HEX2$$b0002000$$ENDHEX$$de carte est incorrect.
			stMessage.sCode	= "WORK130"
		Case 2
/*------------------------------------------------------------------*/
/* La commande PS_S01_CARTE_SINISTRE vient d'$$HEX1$$e900$$ENDHEX$$chouer. La structure  */
/* de message est arm$$HEX1$$e900$$ENDHEX$$e sur F_Procedure.                            */
/*------------------------------------------------------------------*/
			stMessage.sTitre		= "Cr$$HEX1$$e900$$ENDHEX$$ation d'un travail - SIMPA2"
			stMessage.Icon			= StopSign!
		Case 3
			stMessage.bErreurG	= False								// Cette carte n'est pas couverte
			stMessage.sCode		= "WORK120"
		End Choose

	Case "ID_SDOS"
		Choose Case This.iiErreur
		Case 0
			stMessage.sVar[1] = "num$$HEX1$$e900$$ENDHEX$$ro de sous dossier"			// Erreur de Validation - ID_SDOS doit $$HEX1$$ea00$$ENDHEX$$tre num$$HEX1$$e900$$ENDHEX$$rique
			stMessage.sCode	= "GENE003"
		End Choose

	Case "NOM"
		stMessage.sVar[1] = "nom de l'assur$$HEX1$$e900$$ENDHEX$$"						// Erreur de Validation - 
		stMessage.sCode	= "GENE003"

	Case "PRENOM"
		stMessage.sVar[1] = "pr$$HEX1$$e900$$ENDHEX$$nom de l'assur$$HEX1$$e900$$ENDHEX$$"					// Erreur de Validation - 
		stMessage.sCode	= "GENE003"

	Case "ADR_1"
		stMessage.sVar[1] = "adresse 1 de l'assur$$HEX1$$e900$$ENDHEX$$"				// Erreur de Validation - 
		stMessage.sCode	= "GENE008"

	Case "ADR_2"
		stMessage.sVar[1] = "adresse 2 de l'assur$$HEX1$$e900$$ENDHEX$$"				// Erreur de Validation - 
		stMessage.sCode	= "GENE008"

	Case "ADR_CP"
		stMessage.sVar[1] = "code postal de l'assur$$HEX1$$e900$$ENDHEX$$"			// Erreur de Validation - 
		stMessage.sCode	= "GENE003"

	Case "ADR_VILLE"
		stMessage.sVar[1] = "ville de l'assur$$HEX1$$e900$$ENDHEX$$"					// Erreur de Validation - 
		stMessage.sCode	= "GENE003"

	Case "DTE_ADH"
		Choose Case This.iiErreur
		Case 0
			stMessage.sVar[1] = "date d'adh$$HEX1$$e900$$ENDHEX$$sion"					// Erreur de Validation - Date sup$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$date du jour
			stMessage.sCode	= "GENE002"
		End Choose

	Case "DTE_SURV"
		Choose Case This.iiErreur
		Case 0
			stMessage.sVar[1] = "date de survenance"				// Erreur de Validation - Date sup$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$date du jour
			stMessage.sCode	= "GENE002"
		Case 1
			stMessage.sVar[1] = "date de survenance" 				// Date du courrier client < Date de survenance
			stMessage.sVar[2] = "inf$$HEX1$$e900$$ENDHEX$$rieure ou $$HEX1$$e900$$ENDHEX$$gale"
			stMessage.sVar[3] = "date du courrier client"
			stMessage.sCode	= "GENE007"
		Case 2
			stMessage.sVar[1] = "date de survenance"				// Date Recu < Date de survenance
			stMessage.sVar[2] = "inf$$HEX1$$e900$$ENDHEX$$rieure ou $$HEX1$$e900$$ENDHEX$$gale"
			stMessage.sVar[3] = "date de r$$HEX1$$e900$$ENDHEX$$ception SPB"
			stMessage.sCode	= "GENE007"
		End Choose

	Case "NUM_PORT"
		Choose Case This.iiErreur
		Case 0
			stMessage.sVar[1] = "num$$HEX1$$e900$$ENDHEX$$ro de portable"				// Erreur de Validation - Saisir des chiffres
			stMessage.sCode	= "GENE003"
		End Choose

	Case "NUM_IMEI_PORT"
		Choose Case This.iiErreur
		Case 0
			stMessage.sVar[1] = "num$$HEX1$$e900$$ENDHEX$$ro IMEI"						// Erreur de Validation - Saisir des chiffres
			stMessage.sCode	= "GENE003"
		End Choose

	Case "MARQ_PORT"
		Choose Case This.iiErreur
		Case 0
			stMessage.sVar[1] = "marque du portable"				// Erreur de Validation - Saisie incorrecte
			stMessage.sCode	= "GENE002"
		End Choose

	Case "MODL_PORT"
		Choose Case This.iiErreur
		Case 0
			stMessage.sVar[1] = "mod$$HEX1$$e900$$ENDHEX$$le du portable"				// Erreur de Validation - Saisie incorrecte
			stMessage.sCode	= "GENE002"
		End Choose

	Case "DTE_ACH_PORT"
		Choose Case This.iiErreur
		Case 0
			stMessage.sVar[1] = "date d'achat du portable"		// Erreur de Validation - Date incorrecte
			stMessage.sCode	= "GENE002"
		End Choose

	Case "DTE_OUVLIG_PORT"
		Choose Case This.iiErreur
		Case 0
			stMessage.sVar[1] = "date d'ouverture de ligne"		// Erreur de Validation - Date incorrecte
			stMessage.sCode	= "GENE002"
		End Choose

	Case "TXT_MESS1"
		stMessage.sVar[1] = "zone de message"						// Erreur de Validation
		stMessage.sCode	= "GENE002"

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

type st_titre from w_8_traitement`st_titre within w_t_sp_cree_travail
boolean visible = false
integer x = 3401
integer y = 24
integer width = 119
end type

type pb_retour from w_8_traitement`pb_retour within w_t_sp_cree_travail
integer x = 14
integer y = 12
integer taborder = 110
end type

type pb_valider from w_8_traitement`pb_valider within w_t_sp_cree_travail
integer x = 507
integer y = 12
integer taborder = 130
end type

type pb_imprimer from w_8_traitement`pb_imprimer within w_t_sp_cree_travail
integer x = 1006
integer y = 12
integer taborder = 150
end type

type pb_controler from w_8_traitement`pb_controler within w_t_sp_cree_travail
integer x = 261
integer y = 12
integer taborder = 120
end type

type pb_supprimer from w_8_traitement`pb_supprimer within w_t_sp_cree_travail
integer x = 754
integer y = 12
integer taborder = 140
end type

type uo_3d from u_bord3d within w_t_sp_cree_travail
integer x = 1984
integer y = 32
integer width = 357
integer height = 144
end type

on constructor;call u_bord3d::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_3d::Constructor (OVERRIDE)
//* Evenement 		: Constructor
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 14:57:30
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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
This.Width		= 3540
This.Height		= 1420

Call U_Bord3D::Constructor
end on

on uo_3d.destroy
call u_bord3d::destroy
end on

type uo_ong from u_onglets within w_t_sp_cree_travail
integer x = 9
integer y = 156
integer width = 946
integer height = 108
integer taborder = 90
boolean border = false
end type

type dw_wkf_inter from datawindow within w_t_sp_cree_travail
boolean visible = false
integer x = 457
integer y = 1532
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_wkf_inter_winter"
end type

type dw_wkf_routage from datawindow within w_t_sp_cree_travail
boolean visible = false
integer x = 736
integer y = 1536
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_wkf_routage"
end type

type dw_wkf_sinistre from datawindow within w_t_sp_cree_travail
boolean visible = false
integer x = 1015
integer y = 1532
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_wkf_sinistre_wsin"
end type

type p_focus from picture within w_t_sp_cree_travail
boolean visible = false
integer x = 3227
integer y = 24
integer width = 91
integer height = 76
boolean bringtotop = true
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\focus_1.bmp"
boolean focusrectangle = false
end type

type dw_wkf_sinistres_lies from datawindow within w_t_sp_cree_travail
boolean visible = false
integer x = 1294
integer y = 1532
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_wkf_sinistres_lies"
end type

type dw_edms_clx_adh from datawindow within w_t_sp_cree_travail
boolean visible = false
integer x = 1609
integer y = 1532
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_dms_clx_adh"
end type

type dw_edms_pxxx_adh from datawindow within w_t_sp_cree_travail
boolean visible = false
integer x = 1925
integer y = 1532
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_dms_pxxx_adh"
end type

type dw_edms_cic_adh from datawindow within w_t_sp_cree_travail
boolean visible = false
integer x = 2240
integer y = 1532
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_dms_cic_adh"
end type

type dw_option_adh from datawindow within w_t_sp_cree_travail
boolean visible = false
integer x = 3186
integer y = 1400
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_wkf_option_adh"
end type

type dw_banque from datawindow within w_t_sp_cree_travail
boolean visible = false
integer x = 3186
integer y = 1284
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_wkf_banque"
end type

type dw_wkf_homonyme from datawindow within w_t_sp_cree_travail
boolean visible = false
integer x = 3186
integer y = 1532
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_wkf_homonyme"
end type

on retrieverow;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Cree_Travail::dw_Wkf_Homonyme
//* Evenement 		: RetrieveRow
//* Auteur			: Erick John Stark
//* Date				: 27/08/1998 14:50:24
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

SetPointer ( HourGlass! )

ilNbrHomonyme ++

If	ilNbrHomonyme = ilMaxHomonyme Then
	This.DbCancel ()

	stMessage.sTitre		= "Recherche des homonymes - cr$$HEX1$$e900$$ENDHEX$$ation d'un travail"
	stMessage.Icon			= StopSign!
	stMessage.bErreurG	= False
	stMessage.bTrace		= False
	stMessage.sCode		= "WORK280"

	F_Message ( stMessage )

End If	


end on

on retrievestart;//*-----------------------------------------------------------------
//*
//* Objet 			: W_T_Sp_Cree_Travail::dw_Wkf_Homonyme
//* Evenement 		: RetrieveStart
//* Auteur			: Erick John Stark
//* Date				: 27/08/1998 14:45:36
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

ilNbrHomonyme = 0
end on

type dw_adh from datawindow within w_t_sp_cree_travail
integer x = 773
integer y = 328
integer width = 530
integer height = 460
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_sp_wkf_adh"
boolean border = false
end type

type dw_edms_clx_mvts from datawindow within w_t_sp_cree_travail
boolean visible = false
integer x = 1609
integer y = 1396
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_dms_clx_mvts"
end type

type dw_edms_pxxx_mvts from datawindow within w_t_sp_cree_travail
boolean visible = false
integer x = 1929
integer y = 1400
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_dms_pxxx_mvts"
end type

type dw_edms_cic_mvts from datawindow within w_t_sp_cree_travail
boolean visible = false
integer x = 2235
integer y = 1396
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_dms_cic_mvts"
end type

type dw_mvts from datawindow within w_t_sp_cree_travail
boolean visible = false
integer x = 1929
integer y = 1260
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_wkf_mvts"
end type

type st_pochette from statictext within w_t_sp_cree_travail
boolean visible = false
integer x = 2889
integer y = 20
integer width = 137
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 65535
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type dw_edms_sri_adh from datawindow within w_t_sp_cree_travail
boolean visible = false
integer x = 2546
integer y = 1532
integer width = 242
integer height = 100
integer taborder = 70
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_dms_sri_adh"
end type

type dw_edms_sri_mvts from datawindow within w_t_sp_cree_travail
boolean visible = false
integer x = 2546
integer y = 1400
integer width = 242
integer height = 100
integer taborder = 50
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_dms_sri_mvts"
end type

type dw_edms_tel_adh from datawindow within w_t_sp_cree_travail
boolean visible = false
integer x = 2843
integer y = 1532
integer width = 242
integer height = 100
integer taborder = 80
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_dms_tel_adh"
end type

type dw_edms_tel_mvts from datawindow within w_t_sp_cree_travail
boolean visible = false
integer x = 2848
integer y = 1404
integer width = 242
integer height = 100
integer taborder = 60
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_dms_tel_mvts"
end type

type dw_dossuivipar from datawindow within w_t_sp_cree_travail
integer x = 1376
integer y = 356
integer width = 229
integer height = 220
integer taborder = 170
boolean bringtotop = true
string dataobject = "dddw_sp_wkf_dosuivipar"
boolean border = false
end type

on losefocus;This.AcceptText ()
end on

event itemchanged;//*-----------------------------------------------------------------
//*
//* Fonction		: ItemChanged
//* Auteur			: Fabry JF
//* Date				: 05/01/1998 18:25:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Rien
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------

DataWindowChild dwChild
String	sData

//Migration PB8-WYNIWYG-03/2006 CP
Long ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP

sData = Upper ( This.GetText () )
This.GetChild ( "DOS_SUIVI_PAR", dwChild ) 

If dwChild.Find ( "COD_OPER = '" + sData + "'", 1, dwChild.Rowcount () ) <= 0 And Not IsNull ( sData ) Then

//Migration PB8-WYNIWYG-03/2006 CP
//	SetActionCode ( 1 )
		ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		

End If

//Migration PB8-WYNIWYG-03/2006 CP
//
		Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP		




end event

event itemerror;//*-----------------------------------------------------------------
//*
//* Fonction		: ItemError
//* Auteur			: Fabry JF
//* Date				: 05/01/1998 18:25:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Rien
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------


stMessage.sTitre		= "Dossier $$HEX2$$e0002000$$ENDHEX$$traiter par"
stMessage.Icon			= Information!
stMessage.sCode		= "CONT019"
stMessage.bErreurG	= False

f_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 CP
//SetActionCode ( 1 )
		Return 1
//Fin Migration PB8-WYNIWYG-03/2006 CP		


end event

type dw_edms_sri_ref_facturation from datawindow within w_t_sp_cree_travail
boolean visible = false
integer x = 2546
integer y = 1268
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_dms_sri_ref_facturation"
end type

type dw_edms_sri_lig_facturation from datawindow within w_t_sp_cree_travail
boolean visible = false
integer x = 2546
integer y = 1136
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_dms_sri_lig_facturation"
end type

type cb_tarif from commandbutton within w_t_sp_cree_travail
integer x = 1440
integer y = 12
integer width = 334
integer height = 136
integer taborder = 160
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
//* Objet			: W_T_Sp_Cree_Travail::Cb_Tarif		(EXTEND)
//* Evenement 		: Clicked				
//* Auteur			: Erick John Stark
//* Date				: 15/10/2001 14:58:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre des tarifs pour les papiers.
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

type st_message from statictext within w_t_sp_cree_travail
boolean visible = false
integer x = 654
integer y = 876
integer width = 1463
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 15909506
boolean enabled = false
string text = "Veuillez patienter, recherche en cours..."
alignment alignment = center!
boolean border = true
long bordercolor = 16777215
boolean focusrectangle = false
end type

type cb_aide from u_aidecontrat within w_t_sp_cree_travail
integer x = 1243
integer y = 12
integer width = 192
integer height = 68
integer taborder = 20
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : cb_Aide (OVERRIDE !!)
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 27/02/2002 12:06:40
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
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
Long lIdProd

lIdProd = dw_1.GetItemNumber ( 1, "ID_PROD" )
If Not IsNull ( lIdProd ) Then 
	cb_Aide.uf_SetIdProd ( lIdProd  )
	Call Super::Clicked
End If
end on

type cb_notice from u_aidecontrat within w_t_sp_cree_travail
integer x = 1243
integer y = 80
integer width = 192
integer height = 68
integer taborder = 10
boolean bringtotop = true
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : cb_Notice  (OVERRIDE !!)
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 27/02/2002 12:06:40
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
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

Long lIdProd

lIdProd = dw_1.GetItemNumber ( 1, "ID_PROD" )
If Not IsNull ( lIdProd ) Then 
	cb_Notice.uf_SetIdProd ( lIdProd  )
	Call Super::Clicked
End If

end on

type cb_1 from commandbutton within w_t_sp_cree_travail
integer x = 1778
integer y = 12
integer width = 347
integer height = 108
integer taborder = 170
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "R$$HEX1$$e900$$ENDHEX$$serv$$HEX2$$e9002000$$ENDHEX$$JF"
end type

event clicked;dw_1.SetItem ( 1, "COD_CIV", 1 )
dw_1.SetItem ( 1, "NOM", "FABRY" )
dw_1.SetItem ( 1, "PRENOM", "JF" )
dw_1.SetItem ( 1, "ADR_1", "20 rue" )
dw_1.SetItem ( 1, "ADR_CP", "76000" )
dw_1.SetItem ( 1, "ADR_VILLE", "ROUEN" )


end event

