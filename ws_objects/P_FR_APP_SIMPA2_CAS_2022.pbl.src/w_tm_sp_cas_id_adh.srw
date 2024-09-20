$PBExportHeader$w_tm_sp_cas_id_adh.srw
forward
global type w_tm_sp_cas_id_adh from w_8_traitement_master
end type
type uo_3d from u_bord3d within w_tm_sp_cas_id_adh
end type
type uo_ong from u_onglets within w_tm_sp_cas_id_adh
end type
type dw_produit from datawindow within w_tm_sp_cas_id_adh
end type
type dw_sinistre_lie from datawindow within w_tm_sp_cas_id_adh
end type
type dw_wdetail from datawindow within w_tm_sp_cas_id_adh
end type
type dw_sinistre_lie_nouveau from datawindow within w_tm_sp_cas_id_adh
end type
type dw_idordre_lie from datawindow within w_tm_sp_cas_id_adh
end type
end forward

global type w_tm_sp_cas_id_adh from w_8_traitement_master
integer x = 0
integer y = 0
integer width = 3598
integer height = 1768
string title = ""
uo_3d uo_3d
uo_ong uo_ong
dw_produit dw_produit
dw_sinistre_lie dw_sinistre_lie
dw_wdetail dw_wdetail
dw_sinistre_lie_nouveau dw_sinistre_lie_nouveau
dw_idordre_lie dw_idordre_lie
end type
global w_tm_sp_cas_id_adh w_tm_sp_cas_id_adh

type variables
Private :
	u_gs_sp_Cas_Id_Adh	iuoGsSpCasIdAdh
	String			isTypeTrt


end variables

forward prototypes
private subroutine wf_positionnerobjets ()
public function boolean wf_preparermodifier ()
public function string wf_controlersaisie ()
public function boolean wf_valider ()
end prototypes

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Cas_Id_Adh::Wf_PositionnerObjets (PRIVATE)
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
Uo_Ong.X			=   10
Uo_Ong.Y			=  157
Uo_Ong.Width	=  109

/*------------------------------------------------------------------*/
/* Dw_1 et les autres comprises dans l'onglet.                      */
/*------------------------------------------------------------------*/
Dw_1.X			=   60
Dw_1.Y			=  310
Dw_1.Width		= 2980
Dw_1.Height		= 1080

/*------------------------------------------------------------------*/
/* Sinistres Liés avant modification.                               */
/*------------------------------------------------------------------*/
Dw_Sinistre_Lie.X			= Dw_1.X
Dw_Sinistre_Lie.Y			= Dw_1.Y
Dw_Sinistre_Lie.Width	= Dw_1.Width
Dw_Sinistre_Lie.Height	= Dw_1.Height

/*------------------------------------------------------------------*/
/* Sinistres Liés aprés modification.                               */
/*------------------------------------------------------------------*/
Dw_Sinistre_Lie_Nouveau.X			= Dw_1.X
Dw_Sinistre_Lie_Nouveau.Y			= Dw_1.Y
Dw_Sinistre_Lie_Nouveau.Width		= Dw_1.Width
Dw_Sinistre_Lie_Nouveau.Height	= Dw_1.Height
end subroutine

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_Cas_Id_Adh::Wf_PreparerModifier
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

stPass_Dga.sTab [ 1 ] = istPass.sTab [ 1 ]			// ID_SIN en cours de traitement
stPass_Dga.sTab [ 2 ] = istPass.sTab [ 2 ]			// Nous sommes en saisie

iuoGsSpCasIdAdh.Uf_Traitement ( 2, stPass_Dga )

/*------------------------------------------------------------------*/
/* Au retour, on arme le titre de la fenêtre de la manière          */
/* suivante.                                                        */
/* Code Produit + Libellé Produit + N° Dossier + Nom + Prénom.      */
/*------------------------------------------------------------------*/

If	stPass_Dga.bRetour Then
	This.Title = stPass_Dga.sTab [ 1 ]
End If

/*------------------------------------------------------------------*/
/* L'accés au bouton CONTROLER est géré dans la fonction du NVUO.   */
/* En effet, si le dossier en cours posséde plusieurs ID_ORDRE, il  */
/* est impossible de faire un CTL-VAL.                              */
/*------------------------------------------------------------------*/

If	stPass_Dga.lTab[1] = 0	Then
	This.pb_Controler.Enabled = False
Else
	This.pb_Controler.Enabled = True
End If

Return ( stPass_Dga.bRetour )

end function

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_T_Sp_Cas_Id_Adh::Wf_ControlerSaisie (PUBLIC)
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

iuoGsSpCasIdAdh.Uf_Traitement ( 4, stPass_Dga )

Return ( stPass_Dga.sTab [ 1 ] ) 




end function

public function boolean wf_valider ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_T_Sp_Cas_Id_Adh::Wf_Valider (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 18:25:09
//* Libellé			: 
//* Commentaires	: On gére entiérement la validation, sans faire appel à la fonction ancêtre
//*
//* Arguments		: Rien
//*
//* Retourne		: Boolean		Vrai = On peut continuer
//*										Faux = Il y a une erreur
//*
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

iuoGsSpCasIdAdh.Uf_Traitement ( 7, stPass_Dga )

Return ( stPass_Dga.bRetour )


end function

on ue_initialiser;call w_8_traitement_master::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Cas_Id_Ad::Ue_Initialiser
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

s_Pass stPass_Dga
DataWindow	dwNorm[5]
//Migration PB8-WYNIWYG-03/2006 FM
//DataWindow	dwPassageEuro[1]
DataWindow	dwPassageEuro[]
//Fin Migration PB8-WYNIWYG-03/2006 FM

Wf_PositionnerObjets ()

/*------------------------------------------------------------------*/
/* Nous sommes en saisie (S).                                       */
/*------------------------------------------------------------------*/
isTypeTrt = istPass.sTab[ 2 ]

/*------------------------------------------------------------------*/
/* On commence à initialiser les NVUO.                              */
/*------------------------------------------------------------------*/
iuoGsSpCasIdAdh = Create U_Gs_Sp_Cas_Id_Adh

/*------------------------------------------------------------------*/
/* On arme les DW dans le bon ordre. (SVP)                          */
/*------------------------------------------------------------------*/
dwNorm[ 1] = dw_Produit
dwNorm[ 2] = dw_Sinistre_Lie
dwNorm[ 3] = dw_wDetail
dwNorm[ 4] = dw_Sinistre_Lie_Nouveau
dwNorm[ 5] = dw_IdOrdre_Lie

iuoGsSpCasIdAdh .Uf_Initialisation ( dw_1, itrTrans, Uo_Ong, isTypeTrt )
iuoGsSpCasIdAdh .Uf_Initialiser_Dw ( dwNorm[] )

//dw_Lst_Inter.SetRowFocusIndicator ( p_Focus, 50, 260 )

/*------------------------------------------------------------------*/
/* Initialisation de l'onglet.                                      */
/*------------------------------------------------------------------*/
Uo_Ong.Uf_Initialiser ( 3, 1 )
Uo_Ong.Uf_EnregistrerOnglet ( "01", "Sinistre", 			"", dw_1,							True )
Uo_Ong.Uf_EnregistrerOnglet ( "02", "Sin. Liés Avt", 	"", dw_Sinistre_Lie,				False )
Uo_Ong.Uf_EnregistrerOnglet ( "03", "Sin. Liés Apr", 	"", dw_Sinistre_Lie_Nouveau,	False )

iuoGsSpCasIdAdh.Uf_Traitement ( 1, stPass_Dga )

/*------------------------------------------------------------------*/
/* Gestion du Passage à l'EURO.                                     */
/*------------------------------------------------------------------*/
N_Cst_Passage_Euro	nvPassageEuro

dwPassageEuro [ 1 ] = dw_1

nvPassageEuro = CREATE N_Cst_Passage_Euro
nvPassageEuro.uf_Initialiser ( dwPassageEuro[] )

DESTROY nvPassageEuro



end on

on ue_majaccueil;call w_8_traitement_master::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Cas_Id_Adh::Ue_MajAccueil
//* Evenement 		: Ue_MajAccueil
//* Auteur			: Erick John Stark
//* Date				: 03/06/1997 11:57:04
//* Libellé			: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*----------------------------------------------------------------------------*/
/* Appel de la mise à jour du WorkFlow                                        */
/*----------------------------------------------------------------------------*/

istPass.sTab[1]	=	"MAN"						// Mise à jour manuelle de la fenêtre de WORKFLOW

Message.PowerObjectParm = istPass

iwParent.TriggerEvent ( "UE_MAJACCUEIL" )	// Réalise les mises à jour liées au WorkFlow
end on

on ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Cas_Id_Adh::Ue_Retour (OverRide!!)
//* Evenement 		: Ue_Retour
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:29:51
//* Libellé			: 
//* Commentaires	: Opérations  à effectuer avant la fermeture de la fenêtre
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Il faut mettre le script en OVERRIDE.                            */
/* Appel de l'événement UE_MajAccueil avant le retour de la         */
/* fenêtre.                                                         */
/* En effet UE_Retour ne traite pas Ue_MajAccueil si la variable    */
/* ibMajAccueil est à Faux.                                         */
/*------------------------------------------------------------------*/

This.TriggerEvent ( "UE_MajAccueil" )
Call Super::Ue_Retour

end on

on w_tm_sp_cas_id_adh.create
int iCurrent
call super::create
this.uo_3d=create uo_3d
this.uo_ong=create uo_ong
this.dw_produit=create dw_produit
this.dw_sinistre_lie=create dw_sinistre_lie
this.dw_wdetail=create dw_wdetail
this.dw_sinistre_lie_nouveau=create dw_sinistre_lie_nouveau
this.dw_idordre_lie=create dw_idordre_lie
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_3d
this.Control[iCurrent+2]=this.uo_ong
this.Control[iCurrent+3]=this.dw_produit
this.Control[iCurrent+4]=this.dw_sinistre_lie
this.Control[iCurrent+5]=this.dw_wdetail
this.Control[iCurrent+6]=this.dw_sinistre_lie_nouveau
this.Control[iCurrent+7]=this.dw_idordre_lie
end on

on w_tm_sp_cas_id_adh.destroy
call super::destroy
destroy(this.uo_3d)
destroy(this.uo_ong)
destroy(this.dw_produit)
destroy(this.dw_sinistre_lie)
destroy(this.dw_wdetail)
destroy(this.dw_sinistre_lie_nouveau)
destroy(this.dw_idordre_lie)
end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Cas_Id_Adh::Close
//* Evenement 		: Close
//* Auteur			: Erick John Stark
//* Date				: 29/01/1999 16:27:07
//* Libellé			: 
//* Commentaires	: Fermeture définitive de la fenêtre
//*					  On supprime tous les NVUO
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//Destroy iUoGsSpCasIdAdh
If IsValid(iUoGsSpCasIdAdh) Then Destroy iUoGsSpCasIdAdh
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on show;call w_8_traitement_master::show;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Cas_Id_Adh::Show
//* Evenement 		: Show
//* Auteur			: Erick John Stark
//* Date				: 05/12/1997 16:25:00
//* Libellé			: 
//* Commentaires	: Initialisation de la variable ibMajAccueil à Faux
//*				  	  pour que la gestion automatique de la fenêtre d'accueil
//*				     ne soit pas effectuée. La mise à jour de l'accueil est réalisée
//*				     dans W_ACCUEIL_WORKFLOW.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

ibMajAccueil = False

end on

event we_childactivate;call super::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Cas_Id_Adh::We_ChildActivate
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

type cb_debug from w_8_traitement_master`cb_debug within w_tm_sp_cas_id_adh
end type

type dw_1 from w_8_traitement_master`dw_1 within w_tm_sp_cas_id_adh
integer x = 41
integer y = 328
integer width = 530
integer height = 460
string dataobject = "d_sp_cas_id_adh_carte"
boolean border = false
boolean livescroll = false
end type

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Cas_Id_Adh::dw_1
//* Evenement 		: ItemError
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:47:59
//* Libellé			: 
//* Commentaires	: Gestion des messages d'erreur
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	ibErreur Then

	stMessage.sTitre		= "Gestion des cas particuliers - SIMPA2"
	stMessage.Icon			= Information!

	stMessage.bErreurG	= TRUE

	Choose Case isErrCol
	Case "ID_ADH_NOUVEAU"
/*------------------------------------------------------------------*/
/* Pour la zone ID_ADH, on garde la valeur que la personne vient    */
/* de saisir.                                                       */
/*------------------------------------------------------------------*/
		This.iiReset = 2

		Choose Case This.iiErreur
		Case 0
			stMessage.sVar[1] = "numéro d'adhésion"				// Erreur de Validation - 
			stMessage.sCode	= "GENE003"
		Case 1
			stMessage.bErreurG= False									// Erreur de saisie - Le N° de carte est incorrect.
			stMessage.sCode	= "WORK130"
		Case 2
/*------------------------------------------------------------------*/
/* La commande PS_S01_CARTE_SINISTRE vient d'échouer. La structure  */
/* de message est armée sur F_Procedure.                            */
/*------------------------------------------------------------------*/
			stMessage.sTitre		= "Gestion des cas particuliers - SIMPA2"
			stMessage.Icon			= StopSign!
		Case 3
			stMessage.bErreurG	= False								// Cette carte n'est pas couverte
			stMessage.sCode		= "WORK120"
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
//* Objet 			: W_Tm_Sp_Cas_Id_Adh::dw_1
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

/*------------------------------------------------------------------*/
/* Si on est en Saisie, on lance le traitement des zones.           */
/*------------------------------------------------------------------*/

If	isTypeTrt = "S" Then
//Migration PB8-WYNIWYG-03/2006 FM
//	iuoGsSpCasIdAdh.Uf_Zn_Trt ( stPass_Dga )
	ll_ret = iuoGsSpCasIdAdh.Uf_Zn_Trt ( stPass_Dga )
//Fin Migration PB8-WYNIWYG-03/2006 FM
End If

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type st_titre from w_8_traitement_master`st_titre within w_tm_sp_cas_id_adh
boolean visible = false
integer x = 3456
integer y = 24
integer width = 110
end type

type pb_retour from w_8_traitement_master`pb_retour within w_tm_sp_cas_id_adh
integer x = 9
integer y = 8
integer width = 242
integer height = 144
integer taborder = 50
end type

on pb_retour::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Cas_Id_Adh::Pb_Retour::Clicked (OVERRIDE)
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 05/12/1997 16:45:25
//* Libellé			: 
//* Commentaires	: Positionnement du code action
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.TriggerEvent ( "Ue_Retour", 1, 1 )


end on

type pb_valider from w_8_traitement_master`pb_valider within w_tm_sp_cas_id_adh
integer x = 494
integer y = 8
integer width = 242
integer height = 144
integer taborder = 70
end type

type pb_imprimer from w_8_traitement_master`pb_imprimer within w_tm_sp_cas_id_adh
boolean visible = false
integer x = 978
integer y = 8
integer taborder = 90
boolean enabled = false
end type

type pb_controler from w_8_traitement_master`pb_controler within w_tm_sp_cas_id_adh
integer x = 251
integer y = 8
integer width = 242
integer height = 144
integer taborder = 60
end type

type pb_supprimer from w_8_traitement_master`pb_supprimer within w_tm_sp_cas_id_adh
boolean visible = false
integer x = 736
integer y = 8
integer taborder = 80
boolean enabled = false
end type

type uo_3d from u_bord3d within w_tm_sp_cas_id_adh
integer x = 1367
integer y = 52
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
This.Width		= 3050
This.Height		= 1200

Call U_Bord3D::Constructor
end on

on uo_3d.destroy
call u_bord3d::destroy
end on

type uo_ong from u_onglets within w_tm_sp_cas_id_adh
integer x = 9
integer y = 156
integer width = 946
integer height = 108
integer taborder = 40
boolean border = false
end type

type dw_produit from datawindow within w_tm_sp_cas_id_adh
boolean visible = false
integer x = 389
integer y = 1520
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_produit"
end type

type dw_sinistre_lie from datawindow within w_tm_sp_cas_id_adh
integer x = 731
integer y = 328
integer width = 530
integer height = 460
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_sp_wkf_sinistres_lies"
boolean vscrollbar = true
boolean border = false
end type

type dw_wdetail from datawindow within w_tm_sp_cas_id_adh
boolean visible = false
integer x = 667
integer y = 1516
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_sin_w_detail"
end type

type dw_sinistre_lie_nouveau from datawindow within w_tm_sp_cas_id_adh
integer x = 1467
integer y = 332
integer width = 530
integer height = 460
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_sp_wkf_sinistres_lies"
boolean vscrollbar = true
boolean border = false
end type

type dw_idordre_lie from datawindow within w_tm_sp_cas_id_adh
boolean visible = false
integer x = 969
integer y = 1520
integer width = 242
integer height = 100
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_sp_cas_carte_id_ordre"
end type

