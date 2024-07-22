HA$PBExportHeader$w_cd_sp_detail.srw
forward
global type w_cd_sp_detail from w_8_ancetre_consultation
end type
type uo_bord3d from u_bord3d within w_cd_sp_detail
end type
type uo_onglet from u_onglets within w_cd_sp_detail
end type
type dw_1 from u_datawindow within w_cd_sp_detail
end type
type uo_refus from u_tagger within w_cd_sp_detail
end type
type uo_consult_euro from u_consultation_euro within w_cd_sp_detail
end type
type dw_div_det from u_datawindow within w_cd_sp_detail
end type
end forward

global type w_cd_sp_detail from w_8_ancetre_consultation
integer x = 0
integer y = 0
integer width = 3598
integer height = 1768
boolean controlmenu = false
boolean minbox = false
event ue_quitteronglet011 pbm_custom01
event ue_quitteronglet021 pbm_custom02
event ue_taillefenetre ( )
uo_bord3d uo_bord3d
uo_onglet uo_onglet
dw_1 dw_1
uo_refus uo_refus
uo_consult_euro uo_consult_euro
dw_div_det dw_div_det
end type
global w_cd_sp_detail w_cd_sp_detail

type variables
Private:
u_Cs_Sp_Detail		iuoConsultation
end variables

forward prototypes
private subroutine wf_positionnerobjets ()
public function boolean wf_preparerconsulter ()
private subroutine wf_fermer_consulter_paragraphe ()
end prototypes

on ue_quitteronglet011;call w_8_ancetre_consultation::ue_quitteronglet011;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Cm_Sp_Detail
//* Evenement 		: Ue_QuitterOnglet011
//* Auteur			: PLJ
//* Date				: 13/08/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va quitter l'onglet 01
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Si la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation des paragraphes est visible, on    */
/* la rend invisible.                                               */
/*------------------------------------------------------------------*/
Wf_Fermer_Consulter_Paragraphe ()
end on

on ue_quitteronglet021;call w_8_ancetre_consultation::ue_quitteronglet021;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Cm_Sp_Detail
//* Evenement 		: Ue_QuitterOnglet021
//* Auteur			: PLJ
//* Date				: 13/08/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va quitter l'onglet 02
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Si la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation des paragraphes est visible, on    */
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

// Je r$$HEX1$$e900$$ENDHEX$$ajuste la hauteur pour W10

This.Height = 1810
end event

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_cd_sp_Detail::Wf_PositionnerObjets (PRIVATE)
//* Auteur			: PLJ
//* Date				: 29/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On positionne et on taille tous les objets
//*                 sauf uo_bord3d qui est positionn$$HEX2$$e9002000$$ENDHEX$$et taill$$HEX1$$e900$$ENDHEX$$
//*                 par son constructor
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne tous les objets n$$HEX1$$e900$$ENDHEX$$cessaires $$HEX2$$e0002000$$ENDHEX$$la gestion, pour     */
/* faciliter le d$$HEX1$$e900$$ENDHEX$$veloppement. (On peut bouger les objets).         */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Barre Onglet                                                     */
/*------------------------------------------------------------------*/
Uo_Onglet.X			=   10
Uo_Onglet.Y			=  157
Uo_Onglet.Height	=  109

/*------------------------------------------------------------------*/
/* Dw_1  DataWindow : En-t$$HEX1$$ea00$$ENDHEX$$te D$$HEX1$$e900$$ENDHEX$$tail		                          */
/*------------------------------------------------------------------*/
Dw_1.X				=   33
Dw_1.Y				=  273
Dw_1.Width			= 3484
Dw_1.Height			= 1280

dw_div_det.X		= Dw_1.X
dw_div_det.Y		= Dw_1.Y			
dw_div_det.Width	= Dw_1.Width	
dw_div_det.Height	= Dw_1.Height	

/*------------------------------------------------------------------*/
/* Uo_Refus U_Tagger : Liste des refus.		                       */
/*------------------------------------------------------------------*/
Uo_Refus.X				= Dw_1.X
Uo_Refus.Y				= Dw_1.Y
Uo_Refus.Width			= Dw_1.Width
Uo_Refus.Height		= Dw_1.Height
end subroutine

public function boolean wf_preparerconsulter ();//*-----------------------------------------------------------------
//* 
//* Objet			: w_Cd_Sp_Garantie
//* Fonction		: wf_PreparerConsulter
//* Auteur			: PLJ
//* Date				: 27/07/1998 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Appel de uf_preparer_consulter
//* Commentaires	: 
//*
//* Arguments		: Aucun.
//*
//* Retourne		: boolean 	TRUE  : si OK
//*									FALSE : sinon
//*
//*-----------------------------------------------------------------

Boolean 	bOk
String sMonnaie

bOk = iuoConsultation.Uf_Preparer_Consulter ()	

This.Title = istPass.sTab [ 1 ]

/*------------------------------------------------------------------*/
/* On affiche le dernier type de monnaie connu.                     */
/*------------------------------------------------------------------*/
sMonnaie = istPass.sTab [ 2 ]
Uo_Consult_Euro.Uf_Changer_Monnaie ( sMonnaie )

Uo_Onglet.Uf_ActiverOnglet ( "03", dw_div_det.RowCount () > 0 )

Return ( bOk )
end function

private subroutine wf_fermer_consulter_paragraphe ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Cm_Sp_Detail::Wf_Fermer_Consulter_Paragraphe (PRIVATE)
//* Auteur			: PLJ
//* Date				: 13/08/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Si la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation est ouverte, on la rend invisible
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

If	IsValid ( W_Consulter_Paragraphe ) Then
	If W_Consulter_Paragraphe.Visible = True Then W_Consulter_Paragraphe.Hide ()
End If
end subroutine

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_Cd_Sp_Detail
//* Evenement 		:	UE_INITIALISER - Extend
//* Auteur			:	PLJ
//* Date				:	29/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation  
//*					 	d'Interlocuteur
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
// 			FPI		24/08/2011 [VDoc5059] 
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//DataWindow	dwNorm[1]
DataWindow	dwNorm[]
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Positionnement des objets de la fen$$HEX1$$ea00$$ENDHEX$$tre                          */
/*------------------------------------------------------------------*/
wf_PositionnerObjets()

/*------------------------------------------------------------------*/
/* Initialisation de l'onglet                                       */
/*------------------------------------------------------------------*/
Uo_Onglet.Uf_Initialiser ( 3, 1 )

Uo_Onglet.Uf_EnregistrerOnglet ( "01", "D$$HEX1$$e900$$ENDHEX$$tail", "", Dw_1    , True  )
Uo_Onglet.Uf_EnregistrerOnglet ( "02", "Refus",  "", Uo_Refus, False )
Uo_Onglet.Uf_EnregistrerOnglet ( "03", "Divers", "", dw_div_det,	False )

/*------------------------------------------------------------------*/
/* D$$HEX1$$e900$$ENDHEX$$claration du nvuo li$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$la fen$$HEX1$$ea00$$ENDHEX$$tre                            */
/*------------------------------------------------------------------*/

iuoConsultation = Create u_Cs_Sp_Detail

/*------------------------------------------------------------------*/
/* istPass.dwMaster			( w_Cm_Sp_Sinistre.Dw_1			      )	  */
/* istPass.dwNorm[4]			( w_Cm_Sp_Sinistre.Dw_CodeCondition )    */
/* istPass.dwNorm[5]			( w_Cm_Sp_Sinistre.Dw_CodeGarantie  )	  */
/* istPass.dwNorm[2]			( W_Cm_Sp_Sinistre.Dw_Refus         )	  */
/* istPass.dwNorm[6]			( W_Cm_Sp_Sinistre.Dw_Motif         )	  */
/*	istPass.dwNorm[7]			( W_Cm_Sp_Sinistre.Dw_CodeCarTc     )	  */
/*	istPass.dwNorm[8]			( W_Cm_Sp_Sinistre.Dw_Inter	      )	  */
/* istPass.dwTab [2]       ( w_Cm_Sp_Garantie.Dw_Detail	      )	  */
/*------------------------------------------------------------------*/

iuoConsultation.uf_Init_Detail (	iTrTrans,				&
											istPass.dwMaster,		&
											istPass.dwNorm[4],   & 
											istPass.dwNorm[5],   & 
											istPass.dwNorm[2],   &
											istPass.dwNorm[6],   &
											istPass.dwNorm[7],   &
											istPass.dwNorm[8],	&
										   istPass.dwTab[2], 	&
										   Dw_1,						&
											Uo_Refus,				&
											Uo_Onglet,				&
										   istPass.dwNorm[3],   &
											dw_div_det,				&
											istPass.udwTab [ 1 ], &
											istPass.dwNorm [ 9 ], &
											istPass.dwNorm [ 10 ], &
											istPass.udwTab[2] &
								 		) // [VDoc5059] Ajout du dernier param$$HEX1$$e800$$ENDHEX$$tre

/*------------------------------------------------------------------*/
/* On initialise le tableau de DW pour la consultation EURO.        */
/*------------------------------------------------------------------*/
dwNorm [ 1 ] = dw_1
dwNorm [ 2 ] = dw_div_det

Uo_Consult_Euro.Uf_Initialiser ( dwNorm[] )

end event

on ue_retour;call w_8_ancetre_consultation::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_Cd_Sp_Garantie
//* Evenement 		:	Ue_Retour
//* Auteur			:	PLJ
//* Date				:	31/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations $$HEX2$$e0002000$$ENDHEX$$effectuer $$HEX2$$e0002000$$ENDHEX$$la fermeture de la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre 
//* Commentaires	:
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


Wf_Fermer_Consulter_Paragraphe ()
end on

on close;call w_8_ancetre_consultation::close;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_Cd_Sp_Detail
//* Evenement 		:	Close
//* Auteur			:	PLJ
//* Date				:	31/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations $$HEX2$$e0002000$$ENDHEX$$effectuer $$HEX2$$e0002000$$ENDHEX$$la fermeture de la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre 
//* Commentaires	:
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


Destroy iuoConsultation


end on

on w_cd_sp_detail.create
int iCurrent
call super::create
this.uo_bord3d=create uo_bord3d
this.uo_onglet=create uo_onglet
this.dw_1=create dw_1
this.uo_refus=create uo_refus
this.uo_consult_euro=create uo_consult_euro
this.dw_div_det=create dw_div_det
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_bord3d
this.Control[iCurrent+2]=this.uo_onglet
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.uo_refus
this.Control[iCurrent+5]=this.uo_consult_euro
this.Control[iCurrent+6]=this.dw_div_det
end on

on w_cd_sp_detail.destroy
call super::destroy
destroy(this.uo_bord3d)
destroy(this.uo_onglet)
destroy(this.dw_1)
destroy(this.uo_refus)
destroy(this.uo_consult_euro)
destroy(this.dw_div_det)
end on

on we_childactivate;call w_8_ancetre_consultation::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Cd_Sp_Detail
//* Evenement 		: We_ChildActivate
//* Auteur			: PLJ
//* Date				: 29/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
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
end on

event show;call super::show;//*-----------------------------------------------------------------
//*
//* Objet 			: Show
//* Evenement 		: Show
//* Auteur			: Fabry JF
//* Date				: 16/10/2019
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

PostEvent ( "ue_TailleFenetre" )

end event

type cb_debug from w_8_ancetre_consultation`cb_debug within w_cd_sp_detail
end type

type st_titre from w_8_ancetre_consultation`st_titre within w_cd_sp_detail
boolean visible = false
integer x = 2409
integer y = 40
integer width = 297
end type

type pb_retour from w_8_ancetre_consultation`pb_retour within w_cd_sp_detail
integer x = 9
integer y = 8
integer width = 242
integer height = 144
integer taborder = 50
end type

type uo_bord3d from u_bord3d within w_cd_sp_detail
integer x = 1102
integer y = 52
integer width = 338
integer height = 116
integer taborder = 60
end type

on constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Bord3d::Constructor (OVERRIDE)
//* Evenement 		: Constructor
//* Auteur			: PLJ
//* Date				: 29/07/1998
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
This.Width		= 3534
This.Height		= 1340

Call U_Bord3D::Constructor
end on

on uo_bord3d.destroy
call u_bord3d::destroy
end on

type uo_onglet from u_onglets within w_cd_sp_detail
integer x = 9
integer y = 220
integer width = 997
integer height = 116
integer taborder = 40
boolean border = false
end type

type dw_1 from u_datawindow within w_cd_sp_detail
integer x = 59
integer y = 420
integer width = 379
integer height = 408
integer taborder = 20
string dataobject = "d_sp_c_detail"
boolean border = false
end type

type uo_refus from u_tagger within w_cd_sp_detail
integer x = 562
integer y = 428
integer width = 379
integer height = 408
integer taborder = 30
end type

on constructor;call u_tagger::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Refus::Constructor (EXTEND)
//* Evenement 		: Constructor
//* Auteur			: PLJ
//* Date				: 03/08/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* L'objet ne poss$$HEX1$$e800$$ENDHEX$$de pas de titre.                                 */
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
/* On enl$$HEX1$$e800$$ENDHEX$$ve la bordure, qui permet de mieux g$$HEX1$$e900$$ENDHEX$$rer l'objet pendant  */
/* le d$$HEX1$$e900$$ENDHEX$$veloppement.                                                */
/*------------------------------------------------------------------*/
This.Border = False

end on

on ue_dwtrt_rbuttondown;call u_tagger::ue_dwtrt_rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Cd_SP_Detail::Uo_Refus
//* Evenement 		: ue_dwtrt_rButtonDown
//* Auteur			: PLJ
//* Date				: 31/07/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Visualisation du texte associ$$HEX2$$e9002000$$ENDHEX$$au paragraphe
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lLig


String sCol, sIdPara, sCptVer

s_Pass	stPass

/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$termine si on se trouve sur une ligne valide.               */
/*------------------------------------------------------------------*/
lLig = F_GetObjectAtPointer ( This.dw_Trt, sCol )

If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On a besoin d'un objet de transaction. Le seul valide qui        */
/* existe est celui de la fen$$HEX1$$ea00$$ENDHEX$$tre. Il n'y a aucun objet de          */
/* transaction sur les DW.                                          */
/*------------------------------------------------------------------*/
	stPass.trTrans = Parent.itrTrans

	sIdPara				= This.dw_Trt.GetItemString ( lLig, "ID_PARA" )
	sCptVer				= This.dw_Trt.GetItemString ( lLig, "CPT_VER" )

	stPass.sTab[1]	= sIdPara
	stPass.sTab[2] 	= "Paragraphe : " + sIdPara + "." + sCptVer + " - " + This.dw_Trt.GetItemString ( lLig, "LIB_MOTIF" )

	If	IsValid ( W_Consulter_Paragraphe )	Then
		W_Consulter_Paragraphe.Show ()
	Else
		Open ( W_Consulter_Paragraphe )
	End If

	W_Consulter_Paragraphe.Wf_AfficherParagraphe ( stPass )

End If


end on

on uo_refus.destroy
call u_tagger::destroy
end on

type uo_consult_euro from u_consultation_euro within w_cd_sp_detail
integer x = 251
integer y = 8
integer taborder = 70
end type

on uo_consult_euro.destroy
call u_consultation_euro::destroy
end on

type dw_div_det from u_datawindow within w_cd_sp_detail
boolean visible = false
integer x = 1015
integer y = 428
integer width = 393
integer height = 412
integer taborder = 10
boolean enabled = false
string dataobject = "d_lst_div_det"
boolean vscrollbar = true
boolean border = false
end type

