$PBExportHeader$w_td_sp_saisie_regul.srw
$PBExportComments$-} Fenêtre de traitement détail pour la saisie des régularisations.
forward
global type w_td_sp_saisie_regul from w_8_traitement_detail
end type
type uo_3d from u_bord3d within w_td_sp_saisie_regul
end type
type uo_ong from u_onglets within w_td_sp_saisie_regul
end type
type dw_regul_ff from u_datawindow within w_td_sp_saisie_regul
end type
end forward

global type w_td_sp_saisie_regul from w_8_traitement_detail
integer x = 0
integer y = 0
integer width = 3598
integer height = 1768
string title = ""
boolean controlmenu = true
event ue_taillefenetre ( )
event setfocus ( )
uo_3d uo_3d
uo_ong uo_ong
dw_regul_ff dw_regul_ff
end type
global w_td_sp_saisie_regul w_td_sp_saisie_regul

type variables
Private :
	u_gs_sp_Regul_Detail	iuoGsSpRegulDetail


end variables

forward prototypes
private subroutine wf_positionnerobjets ()
public function boolean wf_preparermodifier ()
public function boolean wf_preparervalider ()
public function string wf_controlersaisie ()
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

// This.Height = 1825 // [PB2022_TAILLE_FEN] je commente

end event

event setfocus();
If dw_regul_ff.GetItemString ( 1, "COD_MOT_REG" ) <> "RI" Then
	dw_regul_ff.SetItem ( 1, "MT_TOT_REG", 0  )
	dw_regul_ff.SetColumn ( "MT_TOT_REG" )
End If 

dw_regul_ff.SetFocus ()

end event

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_Saisie_Regul::Wf_PositionnerObjets (PRIVATE)
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
/* Barre Onglet                                                     */
/*------------------------------------------------------------------*/
Uo_Ong.X					=   10
Uo_Ong.Y					=  157
Uo_Ong.Width			=  109

/*------------------------------------------------------------------*/
/* DataWindow pour la saisie de la régularisation.                  */
/*------------------------------------------------------------------*/
Dw_Regul_FF.X			=   60
Dw_Regul_FF.Y			=  310
Dw_Regul_FF.Width		= 1720
Dw_Regul_FF.Height	= 1250

/*------------------------------------------------------------------*/
/* Dw_1 et les autres comprises dans l'onglet.                      */
/*------------------------------------------------------------------*/
Dw_1.X					= 1900
Dw_1.Y					=  150
Dw_1.Width				= 1650
Dw_1.Height				= 1500






end subroutine

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_Saisie_Regul::Wf_PreparerModifier
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

/*------------------------------------------------------------------*/
/* On arme le titre de la fenêtre avec le titre de la fenêtre       */
/* Parent.                                                          */
/*------------------------------------------------------------------*/
This.Title = istPass.sTab [ 1 ]

/*------------------------------------------------------------------*/
/* On récupére le type de régularisation (RI, RM, RP)               */
/*------------------------------------------------------------------*/
stPass_Dga.sTab[1] = istPass.sTab [ 2 ]

iuoGsSpRegulDetail.Uf_Traitement ( 2, stPass_Dga )

This.PostEvent ( "SetFocus" ) 

Return ( stPass_Dga.bRetour )



end function

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_Saisie_Regul::Wf_PreparerValider
//* Auteur			: Erick John Stark
//* Date				: 28/01/1998 09:27:24
//* Libellé			: 
//* Commentaires	: On veut valider une régularisaton
//*
//* Arguments		: 
//*
//* Retourne		: Boolean		True	= La validation va continuer
//*										False = La validation s'arrete.
//*
//*-----------------------------------------------------------------

s_Pass stPass_Dga

stPass_Dga.bInsert = istPass.bInsert
iuoGsSpRegulDetail.Uf_Traitement ( 6, stPass_Dga )

Return ( True )

end function

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Td_Sp_Saisie_Regul::Wf_ControlerSaisie (PUBLIC)
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

If	dw_Regul_FF.AcceptText () > 0	Then
	iuoGsSpRegulDetail.Uf_Traitement ( 4, stPass_Dga )

/*------------------------------------------------------------------*/
/* Il faut positionner le focus sur la DW en cours de saisie.       */
/*------------------------------------------------------------------*/
	Wf_Changer_Controle ( dw_Regul_FF )

	Return ( stPass_Dga.sTab [ 1 ] ) 
Else
	Wf_Changer_Controle ( dw_Regul_FF )

	Return ( dw_Regul_FF.isNomCol )
End If






end function

on ue_initialiser;call w_8_traitement_detail::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_Saisie_Regul::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:59:48
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass	stPass_Dga
DataWindow	dwNorm[4]
//Migration PB8-WYNIWYG-03/2006 FM
//DataWindow	dwPassageEuro[2]
DataWindow	dwPassageEuro[]
//Fin Migration PB8-WYNIWYG-03/2006 FM

Wf_PositionnerObjets ()

/*------------------------------------------------------------------*/
/* On arme les DW dans le bon ordre. (SVP)                          */
/*------------------------------------------------------------------*/
dwNorm[1] = istPass.dwNorm[1]		// DataWindow PRODUIT
dwNorm[2] = istPass.dwNorm[2]		// DataWindow INTERLOCUTEUR
dwNorm[3] = istPass.dwNorm[3]		// DataWindow FRAIS
dwNorm[4] = istPass.dwNorm[4]		// DataWindow REG_GTI

/*------------------------------------------------------------------*/
/* On commence à initialiser les NVUO.                              */
/*------------------------------------------------------------------*/
iuoGsSpRegulDetail = Create U_Gs_Sp_Regul_Detail

iuoGsSpRegulDetail.Uf_Initialisation ( istPass.dwMaster, itrTrans, Uo_Ong )
iuoGsSpRegulDetail.Uf_Initialiser_Dw ( istPass.dwTab[1], dw_1, dw_Regul_FF, istPass.dwMaster1, dwNorm[] )

/*------------------------------------------------------------------*/
/* Initialisation de l'onglet.                                      */
/*------------------------------------------------------------------*/
Uo_Ong.Uf_Initialiser ( 1, 1 )
Uo_Ong.Uf_EnregistrerOnglet ( "01", "Régularisation", 	"", dw_Regul_FF,			True )


iuoGsSpRegulDetail.Uf_Traitement ( 1, stPass_Dga )

/*------------------------------------------------------------------*/
/* Gestion du Passage à l'EURO.                                     */
/*------------------------------------------------------------------*/
N_Cst_Passage_Euro	nvPassageEuro

dwPassageEuro[ 1 ] = dw_1
dwPassageEuro[ 2 ] = dw_Regul_FF

nvPassageEuro = CREATE N_Cst_Passage_Euro
nvPassageEuro.uf_Initialiser ( dwPassageEuro[] )

DESTROY nvPassageEuro


end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_Saisie_Regul::Close
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
//Destroy iUoGsSpRegulDetail
If IsValid(iUoGsSpRegulDetail) Then Destroy iUoGsSpRegulDetail
//Fin Migration PB8-WYNIWYG-03/2006 FM


end event

event we_childactivate;call super::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_Saisie_Regul::We_ChildActivate
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

on w_td_sp_saisie_regul.create
int iCurrent
call super::create
this.uo_3d=create uo_3d
this.uo_ong=create uo_ong
this.dw_regul_ff=create dw_regul_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_3d
this.Control[iCurrent+2]=this.uo_ong
this.Control[iCurrent+3]=this.dw_regul_ff
end on

on w_td_sp_saisie_regul.destroy
call super::destroy
destroy(this.uo_3d)
destroy(this.uo_ong)
destroy(this.dw_regul_ff)
end on

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

type cb_debug from w_8_traitement_detail`cb_debug within w_td_sp_saisie_regul
end type

type dw_1 from w_8_traitement_detail`dw_1 within w_td_sp_saisie_regul
integer x = 837
integer y = 328
integer width = 530
integer height = 460
integer taborder = 0
string dataobject = "d_sp_detail_reglement_regul"
borderstyle borderstyle = styleshadowbox!
end type

type st_titre from w_8_traitement_detail`st_titre within w_td_sp_saisie_regul
boolean visible = false
integer x = 3287
integer y = 16
integer width = 133
end type

type pb_retour from w_8_traitement_detail`pb_retour within w_td_sp_saisie_regul
integer x = 9
integer y = 8
integer width = 242
integer height = 144
integer taborder = 30
end type

type pb_valider from w_8_traitement_detail`pb_valider within w_td_sp_saisie_regul
integer x = 503
integer y = 8
integer width = 242
integer height = 144
integer taborder = 50
end type

type pb_imprimer from w_8_traitement_detail`pb_imprimer within w_td_sp_saisie_regul
boolean visible = false
integer x = 750
integer y = 8
boolean enabled = false
end type

type pb_controler from w_8_traitement_detail`pb_controler within w_td_sp_saisie_regul
integer x = 256
integer y = 8
integer width = 242
integer height = 144
integer taborder = 40
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

type pb_supprimer from w_8_traitement_detail`pb_supprimer within w_td_sp_saisie_regul
boolean visible = false
integer x = 750
integer y = 8
integer taborder = 0
boolean enabled = false
end type

type uo_3d from u_bord3d within w_td_sp_saisie_regul
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
This.Width		= 1800
This.Height		= 1350

Call U_Bord3D::Constructor
end on

on uo_3d.destroy
call u_bord3d::destroy
end on

type uo_ong from u_onglets within w_td_sp_saisie_regul
integer x = 9
integer y = 156
integer width = 992
integer height = 108
integer taborder = 20
boolean border = false
end type

type dw_regul_ff from u_datawindow within w_td_sp_saisie_regul
integer x = 46
integer y = 328
integer width = 530
integer height = 460
integer taborder = 10
string dataobject = "d_sp_detail_saisie_regul"
boolean border = false
boolean livescroll = false
end type

event itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_Saisie_Regul::dw_1
//* Evenement 		: ItemError
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:47:59
//* Libellé			: 
//* Commentaires	: Gestion des messages d'erreur
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//		  JFF  31/10/2019	[VDOC28559]
//*-----------------------------------------------------------------

If	ibErreur Then

	stMessage.sTitre		= "Gestion des régularisations - SIMPA2"
	stMessage.Icon			= Information!

	stMessage.bErreurG	= TRUE

	Choose Case isErrCol
	Case "LIB_REG"
		stMessage.sVar[1] 		= "libellé de la régularisation"					// Erreur de Validation - 
		stMessage.sCode			= "GENE003"

	Case "RIB_BQ"
		stMessage.sVar[1] 		= "code de la banque"								// Erreur de Validation - 
		stMessage.sCode			= "GENE003"

	Case "RIB_GUI"
		stMessage.sVar[1] 		= "code du guichet"									// Erreur de Validation - 
		stMessage.sCode			= "GENE003"

	Case "RIB_CPT"
		stMessage.sVar[1]			= "numéro du compte"									// Erreur de Validation - 
		stMessage.sCode			= "GENE003"

	Case "RIB_CLE"
		Choose Case iiErreur
		Case 0
			stMessage.sVar[1] 	= "clé RIB"												// Erreur de Validation - 
			stMessage.sCode		= "GENE002"

		Case 1
			stMessage.bErreurG	= False
			stMessage.sCode  		= "REFU005"												// Cle RIB incorrecte

		// [VDOC28559]
		Case 2
			stMessage.bErreurG	= False
			stMessage.sCode  		= "WINT307"												// Modif RIB interdit


		End Choose

	Case "MT_TOT_REG"
		Choose Case iiErreur
		Case 1
			stMessage.sVar[1] 		= "négatif"											// Montant incorrect (RM)
			stMessage.bErreurG		= False
			stMessage.sCode			= "REGU120"

		Case 2
			stMessage.sVar[1] 		= "positif"											// Montant incorrect (RP)
			stMessage.bErreurG		= False
			stMessage.sCode			= "REGU120"

		End Choose

	Case "COD_MODE_REG"
		Choose Case iiErreur
		Case 1
			stMessage.bErreurG		= False
			stMessage.sCode			= "REGU160"
		End Choose

	Case "ID_I"
		Choose Case iiErreur
		Case 1
			stMessage.bErreurG		= False
			stMessage.sCode			= "REGU180"
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

event itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Td_Sp_Saisie_Regul::dw_1
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
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

If	This.iiCarNul = 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//	iuoGsSpRegulDetail.Uf_Zn_Trt ( stPass_Dga )
	ll_ret = iuoGsSpRegulDetail.Uf_Zn_Trt ( stPass_Dga )
//Fin Migration PB8-WYNIWYG-03/2006 FM
End If

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

