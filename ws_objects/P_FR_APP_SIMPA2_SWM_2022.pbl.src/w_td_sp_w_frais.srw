$PBExportHeader$w_td_sp_w_frais.srw
$PBExportComments$-} Fenêtre de traitement pour la saisie des frais.
forward
global type w_td_sp_w_frais from w_8_traitement_detail
end type
type uo_3d from u_bord3d within w_td_sp_w_frais
end type
type uo_ong from u_onglets within w_td_sp_w_frais
end type
type uo_consult_euro from u_consultation_euro within w_td_sp_w_frais
end type
end forward

global type w_td_sp_w_frais from w_8_traitement_detail
integer x = 0
integer y = 0
integer width = 3598
integer height = 1768
string title = ""
uo_3d uo_3d
uo_ong uo_ong
uo_consult_euro uo_consult_euro
end type
global w_td_sp_w_frais w_td_sp_w_frais

type variables
Private :
	u_gs_sp_Sinistre_wFrais	iuoGsSpwFrais
	String			isTypeTrt

	u_DataWindow_Detail idwDivSin
	
end variables

forward prototypes
private subroutine wf_positionnerobjets ()
public function boolean wf_preparermodifier ()
public function boolean wf_preparerinserer ()
public function boolean wf_preparervalider ()
public function boolean wf_preparersupprimer ()
public function string wf_controlersaisie ()
private subroutine wf_tb_consultation ()
end prototypes

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_W_Frais::Wf_PositionnerObjets (PRIVATE)
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

/*------------------------------------------------------------------*/
/* On positionne tous les objets nécessaires à la gestion, pour     */
/* faciliter le développement. (On peut bouger les objets).         */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Dw_1 et les autres comprises dans l'onglet.                      */
/*------------------------------------------------------------------*/
Dw_1.X			=   33
Dw_1.Y			=  273
Dw_1.Width		= 3484
Dw_1.Height		= 1230






end subroutine

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_W_Frais::Wf_PreparerModifier
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

s_Pass	stPass_Dga
String sMonnaie

/*------------------------------------------------------------------*/
/* On arme le titre de la fenêtre avec le titre de la fenêtre       */
/* Parent.                                                          */
/*------------------------------------------------------------------*/
This.Title = istPass.sTab [ 1 ]

iuoGsSpwFrais.Uf_Traitement ( 2, stPass_Dga )

/*------------------------------------------------------------------*/
/* L'accés au bouton SUPPRIMER est géré dans la fonction du NVUO.   */
/*------------------------------------------------------------------*/
pb_Supprimer.Enabled = stPass_Dga.bSupprime

/*------------------------------------------------------------------*/
/* L'accés au bouton CONTROLER est géré dans la fonction du NVUO.   */
/* En effet dans le cas d'un frais REGLE, il est impossible de      */
/* faire un CTL-VAL.                                                */
/*------------------------------------------------------------------*/
If	stPass_Dga.lTab[1] = 0	Then
	This.pb_Controler.Enabled = False
Else
	This.pb_Controler.Enabled = True
End If

/*------------------------------------------------------------------*/
/* On arme la valeur de la monnaie avec celle de la fenêtre des     */
/* INTERLOCUTEURS. (En consultation uniquement).                    */
/*------------------------------------------------------------------*/
If	isTypeTrt = "C"	Then
	sMonnaie = istPass.sTab [ 3 ]
	Uo_Consult_Euro.Uf_Changer_Monnaie ( sMonnaie )
End If

Return ( stPass_Dga.bRetour )



end function

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_W_Frais::Wf_PreparerInserer
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

s_Pass	stPass_Dga

/*------------------------------------------------------------------*/
/* On arme le titre de la fenêtre avec le titre de la fenêtre       */
/* Parent.                                                          */
/*------------------------------------------------------------------*/
This.Title = istPass.sTab [ 1 ]

iuoGsSpwFrais.Uf_Traitement ( 3, stPass_Dga )

/*------------------------------------------------------------------*/
/* On autorise le bouton CONTROLE. Il est peut-être désactivé (Cas  */
/* d'un frais REGLE).                                               */
/*------------------------------------------------------------------*/
This.pb_Controler.Enabled = True

Return ( True )




end function

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_W_Frais::Wf_PreparerValider
//* Auteur			: Erick John Stark
//* Date				: 28/01/1998 09:27:24
//* Libellé			: 
//* Commentaires	: On veut valider un frais
//*
//* Arguments		: 
//*
//* Retourne		: Boolean		True	= La validation va continuer
//*										False = La validation s'arrete.
//*
//*-----------------------------------------------------------------
//* #1	FPI	[FRAIS_O2M] Fenêtre d'information sur les frais presta
//* #2	PHG   [FRAIS_O2M] Mise en attente du code suite merge MSS_DIAG
//*-----------------------------------------------------------------


s_Pass stPass_Dga
//
//Boolean bRet 		// #1
//
//// #1
//bRet = TRUE
//stPass_Dga.ltab[1] = dw_1.getitemnumber( 1, "ID_SIN")
//
//OpenWithParm(w_td_sp_w_trt_frais_presta,stPass_dga)
//
//stPass_dga=Message.PowerObjectParm
//
//if not isnull(stPass_dga) Then 
//	bRet = (stPass_Dga.stab[1] = "CONTINUER")
//Else
//	bRet = FALSE
//End if
//// #1

stPass_Dga.bInsert = istPass.bInsert
iuoGsSpwFrais.Uf_Traitement ( 6, stPass_Dga )

////Return ( True )
//Return bRet
Return ( True )

end function

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_W_Frais::Wf_PreparerSupprimer
//* Auteur			: Erick John Stark
//* Date				: 28/01/1998 09:27:24
//* Libellé			: 
//* Commentaires	: On veut supprimer le frais
//*
//* Arguments		: 
//*
//* Retourne		: Boolean		True	= La suppression va continuer
//*										False = La suppression s'arrete.
//*
//*-----------------------------------------------------------------

s_Pass stPass_Dga

iuoGsSpwFrais.Uf_Traitement ( 10, stPass_Dga )

Return ( stPass_Dga.bRetour )

end function

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_W_Frais::Wf_ControlerSaisie (PUBLIC)
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

iuoGsSpwFrais.Uf_Traitement ( 4, stPass_Dga )

Return ( stPass_Dga.sTab [ 1 ] ) 




end function

private subroutine wf_tb_consultation ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_W_Frais::Wf_Tb_Consultation (PRIVATE)
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
//DataWindow dwNorm[1]
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
/* On initialise le tableau de DW pour la consultation EURO.        */
/*------------------------------------------------------------------*/
dwNorm [ 1 ] = dw_1

Uo_Consult_Euro.Uf_Initialiser ( dwNorm[] )

end subroutine

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_W_Frais::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  CAG	12/02/2003  Suite DCMP 030027 : Ajout de la dw DET_PRO
//* 		FPI	27/07/2010	[PM72] ajout de dw_commande
// 			FPI	18/10/2010 [PM72.1] ajout commande_type_frn
//*-----------------------------------------------------------------

s_Pass	stPass_Dga

//Migration PB8-WYNIWYG-03/2006 CP
//DataWindow	dwNorm[1]
//DataWindow	dwPassageEuro[1]
DataWindow	dwNorm[]
DataWindow	dwPassageEuro[]
//Fin Migration PB8-WYNIWYG-03/2006 CP

Wf_PositionnerObjets ()

/*------------------------------------------------------------------*/
/* Nous sommes en saisie (S) ou en Consultation/Validation (C)(V)   */
/*------------------------------------------------------------------*/
isTypeTrt = istPass.sTab[ 2 ]

/*------------------------------------------------------------------*/
/* On commence à initialiser les NVUO.                              */
/*------------------------------------------------------------------*/
iuoGsSpwFrais = Create U_Gs_Sp_Sinistre_wFrais

/*------------------------------------------------------------------*/
/* On arme les DW dans le bon ordre. (SVP)                          */
/*------------------------------------------------------------------*/
dwNorm[ 1] = istPass.dwNorm [  2 ]		// DataWindow External W_FRAIS_SUPP
dwNorm [2] = istPass.dwtab[3]			// [PM72]
dwNorm[ 3] = istPass.dwNorm [ 4 ]		// [PM72.1] commande_type_frn

idwDivSin = istPass.udwTab [ 1 ]

/*------------------------------------------------------------------*/
/* Ces fonctions sont issues du NVUO ancêtre.                       */
/*------------------------------------------------------------------*/
/* #1                                                               */
/*------------------------------------------------------------------*/
iuoGsSpwFrais.Uf_Initialisation ( istPass.dwMaster, itrTrans, Uo_Ong, isTypeTrt )
iuoGsSpwFrais.Uf_Initialiser_Dw ( istPass.dwNorm [ 1 ], istPass.dwNorm [ 3 ], False )

/*------------------------------------------------------------------*/
/* istPass.sTab[2] = u_DataWindow_Detail -> Lst des interlocuteurs  */
/* istPass.dwMaster1 = u_DataWindow      -> Interlocuteur en cours  */
/*------------------------------------------------------------------*/
dwNorm[4] = istPass.dwTab [  1 ] // [PM72.1] liste des frais

iuoGsSpwFrais.Uf_Initialiser_Dw_Desc ( istPass.dwTab[2], dw_1, istPass.dwMaster1, idwDivSin, dwNorm[] )

/*------------------------------------------------------------------*/
/* Initialisation de l'onglet.                                      */
/*------------------------------------------------------------------*/
Uo_Ong.Uf_Initialiser ( 1, 1 )
Uo_Ong.Uf_EnregistrerOnglet ( "01", "Frais", 			"", dw_1,			True )

/*------------------------------------------------------------------*/
/* Si on est en Consultation/Validation (C)(V), on bouge la         */
/* cosmétique de la fenêtre.                                        */
/*------------------------------------------------------------------*/
If	isTypeTrt <> "S"	Then
	Wf_Tb_Consultation ()
End If

iuoGsSpwFrais.Uf_Traitement ( 1, stPass_Dga )

/*------------------------------------------------------------------*/
/* Gestion du Passage à l'EURO.                                     */
/*------------------------------------------------------------------*/
N_Cst_Passage_Euro	nvPassageEuro

dwPassageEuro[ 1 ] = dw_1

nvPassageEuro = CREATE N_Cst_Passage_Euro
nvPassageEuro.uf_Initialiser ( dwPassageEuro[] )

DESTROY nvPassageEuro





end event

on close;call w_8_traitement_detail::close;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_W_Frais::Close
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

Destroy iUoGsSpwFrais


end on

event we_childactivate;call super::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_W_Frais::We_ChildActivate
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

on w_td_sp_w_frais.create
int iCurrent
call super::create
this.uo_3d=create uo_3d
this.uo_ong=create uo_ong
this.uo_consult_euro=create uo_consult_euro
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_3d
this.Control[iCurrent+2]=this.uo_ong
this.Control[iCurrent+3]=this.uo_consult_euro
end on

on w_td_sp_w_frais.destroy
call super::destroy
destroy(this.uo_3d)
destroy(this.uo_ong)
destroy(this.uo_consult_euro)
end on

type cb_debug from w_8_traitement_detail`cb_debug within w_td_sp_w_frais
end type

type dw_1 from w_8_traitement_detail`dw_1 within w_td_sp_w_frais
integer x = 37
integer y = 296
integer width = 530
integer height = 460
string dataobject = "d_sp_sin_w_frais_saisie_ff"
boolean border = false
end type

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_w_Frais::dw_1
//* Evenement 		: ItemError
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:47:59
//* Libellé			: 
//* Commentaires	: Gestion des messages d'erreur
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*	 JFF    19/02/2015 [VDOC15553]
//     JFF    01/06/2018 [PC151425-1]
//     JFF    23/08/2021 [RS919_FRAIS_DIVERS]
//     JFF    29/08/2023 [RS5545_FRAIS_DP]
//*-----------------------------------------------------------------

If	ibErreur Then

	stMessage.sTitre		= "Gestion des frais - SIMPA2"
	stMessage.Icon			= Information!

	stMessage.bErreurG	= TRUE

	Choose Case isErrCol
	Case "LIB_FRAIS"
		stMessage.sVar[1] = "libellé du frais"					// Erreur de Validation - 
		stMessage.sCode	= "GENE003"

	Case "MT_FRAIS"
		stMessage.sVar[1] = "montant du frais"				// Erreur de Validation - 
		stMessage.sCode	= "GENE003"

	// [VDOC15553]
	Case "ID_TYP_FRAIS"
		
		Choose case iiErreur
			Case 1
				stMessage.bErreurG	= FALSE
				stMessage.sCode	= "WFRA017"

			// [PC151425-1]
			Case 2
				stMessage.bErreurG	= FALSE
				stMessage.sCode	= "WFRA018"

			// [RS919_FRAIS_DIVERS]				
			Case 3			
				stMessage.bErreurG	= FALSE
				stMessage.sCode	= "WFRA021"

			// [RS5545_FRAIS_DP]				
			Case 4			
				stMessage.bErreurG	= FALSE
				stMessage.sCode	= "WFRA022"				
				
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
//* Objet 			: W_Td_Sp_W_Frais::dw_1
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
Integer  iRet 

/*------------------------------------------------------------------*/
/* Si on est en Saisie, on lance le traitement des zones.           */
/*------------------------------------------------------------------*/
If	isTypeTrt = "S" Then
	iRet = iuoGsSpwFrais.Uf_Zn_Trt ( stPass_Dga )
End If

Return iRet 

end event

type st_titre from w_8_traitement_detail`st_titre within w_td_sp_w_frais
boolean visible = false
integer x = 3287
integer y = 168
integer width = 133
end type

type pb_retour from w_8_traitement_detail`pb_retour within w_td_sp_w_frais
integer x = 9
integer y = 8
integer width = 242
integer height = 144
integer taborder = 30
end type

type pb_valider from w_8_traitement_detail`pb_valider within w_td_sp_w_frais
integer x = 251
integer y = 8
integer width = 242
integer height = 144
integer taborder = 50
end type

type pb_imprimer from w_8_traitement_detail`pb_imprimer within w_td_sp_w_frais
boolean visible = false
integer x = 736
integer y = 8
integer taborder = 70
boolean enabled = false
end type

type pb_controler from w_8_traitement_detail`pb_controler within w_td_sp_w_frais
boolean visible = false
integer x = 256
integer y = 8
integer taborder = 40
boolean enabled = false
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

type pb_supprimer from w_8_traitement_detail`pb_supprimer within w_td_sp_w_frais
integer x = 494
integer y = 8
integer width = 242
integer height = 144
integer taborder = 60
end type

type uo_3d from u_bord3d within w_td_sp_w_frais
integer x = 1618
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
This.Height		= 1290

Call U_Bord3D::Constructor
end on

on uo_3d.destroy
call u_bord3d::destroy
end on

type uo_ong from u_onglets within w_td_sp_w_frais
integer x = 9
integer y = 156
integer width = 992
integer height = 108
integer taborder = 20
boolean border = false
end type

type uo_consult_euro from u_consultation_euro within w_td_sp_w_frais
integer x = 978
integer y = 8
integer taborder = 80
end type

on uo_consult_euro.destroy
call u_consultation_euro::destroy
end on

