$PBExportHeader$w_cd_sp_inter.srw
forward
global type w_cd_sp_inter from w_8_ancetre_consultation
end type
type uo_onglet from u_onglets within w_cd_sp_inter
end type
type uo_bord3d from u_bord3d within w_cd_sp_inter
end type
type dw_1 from u_datawindow within w_cd_sp_inter
end type
type dw_lst_frais from u_datawindow_detail within w_cd_sp_inter
end type
type p_focus from picture within w_cd_sp_inter
end type
type uo_consult_euro from u_consultation_euro within w_cd_sp_inter
end type
end forward

global type w_cd_sp_inter from w_8_ancetre_consultation
integer x = 0
integer y = 0
integer width = 3598
integer height = 1768
boolean controlmenu = false
boolean minbox = false
event ue_taillefenetre ( )
uo_onglet uo_onglet
uo_bord3d uo_bord3d
dw_1 dw_1
dw_lst_frais dw_lst_frais
p_focus p_focus
uo_consult_euro uo_consult_euro
end type
global w_cd_sp_inter w_cd_sp_inter

type variables
Private:
u_Cs_Sp_Inter		iuoConsultation

String			isDetailConsult


end variables

forward prototypes
private subroutine wf_positionnerobjets ()
public function boolean wf_preparerconsulter ()
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

// This.Height = 1810 // [PB2022_TAILLE_FEN] je commente


end event

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_cd_sp_Inter::Wf_PositionnerObjets (PRIVATE)
//* Auteur			: PLJ
//* Date				: 21/07/1998
//* Libellé			: 
//* Commentaires	: On positionne et on taille tous les objets
//*                 sauf uo_bord3d qui est positionné et taillé
//*                 par son constructor
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//       JFF   30/05/2023 [PMO89_RS4822]
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne tous les objets nécessaires à la gestion, pour     */
/* faciliter le développement. (On peut bouger les objets).         */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Barre Onglet                                                     */
/*------------------------------------------------------------------*/
Uo_Onglet.X			=   10
Uo_Onglet.Y			=  157
Uo_Onglet.Height	=  109

/*------------------------------------------------------------------*/
/* Dw_1  DataWindow : En-tête Interlocuteur                         */
/*------------------------------------------------------------------*/
Dw_1.X				=   51
Dw_1.Y				=  273
Dw_1.Width			= 3440 // 2500 [PMO89_RS4822]
Dw_1.Height			= 1350

/*------------------------------------------------------------------*/
/* Dw_Frais DataWindow : Liste des Frais                            */
/*------------------------------------------------------------------*/
Dw_Lst_Frais.X    		= Dw_1.X	
Dw_Lst_Frais.Y		   	= Dw_1.Y
Dw_Lst_Frais.Width		= Dw_1.Width
Dw_Lst_Frais.Height		= Dw_1.Height


end subroutine

public function boolean wf_preparerconsulter ();//*-----------------------------------------------------------------
//* 
//* Objet			: w_Cd_Sp_Inter
//* Fonction		: wf_PreparerConsulter
//* Auteur			: PLJ
//* Date				: 22/07/1998 
//* Libellé			: Appel de uf_preparer_consulter
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

Return ( bOk )
end function

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_Cd_Sp_Inter
//* Evenement 		:	UE_INITIALISER - Extend
//* Auteur			:	PLJ
//* Date				:	21/07/1998
//* Libellé			:	Initialisation de la fenêtre de consultation  
//*					 	d'Interlocuteur
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date			Modification
//       JFF   05/02/2018 	[PM360-2]
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//DataWindow	dwNorm[2]
DataWindow	dwNorm[]
//Fin Migration PB8-WYNIWYG-03/2006 FM
DataWindowChild dwChild_EF 


/*------------------------------------------------------------------*/
/* Positionnement des objets de la fenêtre                          */
/*------------------------------------------------------------------*/
wf_PositionnerObjets()


/*------------------------------------------------------------------*/
/* Initialisation de l'onglet                                       */
/*------------------------------------------------------------------*/
Uo_Onglet.Uf_Initialiser ( 2, 1 )

Uo_Onglet.Uf_EnregistrerOnglet ( "01", "Interlocuteur", "", Dw_1     , True  )
Uo_Onglet.Uf_EnregistrerOnglet ( "02", "Frais",         "", Dw_Lst_Frais , False )


/*------------------------------------------------------------------*/
/* Déclaration du nvuo liée à la fenêtre                            */
/*------------------------------------------------------------------*/

iuoConsultation = Create u_Cs_Sp_Inter

// [PM360-2] istPass.udwTab[1]
iuoConsultation.uf_Init_Inter (	iTrTrans,				&
											istPass.dwMaster,		&
										   istPass.dwTab[1], 	&
										   istPass.udwTab[1], 	&											
										   istPass.dwNorm[1],	&
										   Dw_1,						&
											Dw_Lst_Frais,			&
										   Uo_Onglet             )

/*------------------------------------------------------------------*/
/* Positionnement du Focus indicator                                */
/*------------------------------------------------------------------*/
dw_Lst_Frais.SetRowFocusIndicator ( p_Focus, 50, 260 )

/*------------------------------------------------------------------*/
/* On initialise le tableau de DW pour la consultation EURO.        */
/*------------------------------------------------------------------*/

dwNorm [ 1 ] = dw_1
dwNorm [ 2 ] = dw_Lst_Frais

Uo_Consult_Euro.Uf_Initialiser ( dwNorm[] )

// 	[PMO89_RS4822]
If F_CLE_A_TRUE ( "PMO89_RS4822" ) Then
	dw_1.GetChild ( "COD_ETAT_CTRLE_INTER", dwChild_EF )
	dwChild_EF.SetTransObject ( SQLCA)
	dwChild_EF.Retrieve ( "-EF")
	dwChild_EF.SetFilter ( "ID_TYP_CODE = '-EF' AND ID_CODE > 0" )
	dwChild_EF.Filter ()
	dwChild_EF.Sort ()
End If
end event

event we_childactivate;call super::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Cd_Sp_Inter
//* Evenement 		: We_ChildActivate
//* Auteur			: PLJ
//* Date				: 22/07/1998
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

on close;call w_8_ancetre_consultation::close;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_Cd_Sp_Inter
//* Evenement 		:	Close
//* Auteur			:	PLJ
//* Date				:	31/07/1998
//* Libellé			:	Opérations à effectuer à la fermeture de la 
//*					 	fenêtre 
//* Commentaires	:
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


Destroy iuoConsultation
end on

on w_cd_sp_inter.create
int iCurrent
call super::create
this.uo_onglet=create uo_onglet
this.uo_bord3d=create uo_bord3d
this.dw_1=create dw_1
this.dw_lst_frais=create dw_lst_frais
this.p_focus=create p_focus
this.uo_consult_euro=create uo_consult_euro
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_onglet
this.Control[iCurrent+2]=this.uo_bord3d
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_lst_frais
this.Control[iCurrent+5]=this.p_focus
this.Control[iCurrent+6]=this.uo_consult_euro
end on

on w_cd_sp_inter.destroy
call super::destroy
destroy(this.uo_onglet)
destroy(this.uo_bord3d)
destroy(this.dw_1)
destroy(this.dw_lst_frais)
destroy(this.p_focus)
destroy(this.uo_consult_euro)
end on

event show;call super::show;
//*-----------------------------------------------------------------
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

type cb_debug from w_8_ancetre_consultation`cb_debug within w_cd_sp_inter
end type

type st_titre from w_8_ancetre_consultation`st_titre within w_cd_sp_inter
boolean visible = false
integer x = 2843
integer y = 44
integer width = 229
end type

type pb_retour from w_8_ancetre_consultation`pb_retour within w_cd_sp_inter
integer x = 9
integer y = 8
integer width = 242
integer height = 144
integer taborder = 40
end type

type uo_onglet from u_onglets within w_cd_sp_inter
integer x = 128
integer y = 204
integer width = 1038
integer height = 116
integer taborder = 30
boolean border = false
end type

type uo_bord3d from u_bord3d within w_cd_sp_inter
integer x = 635
integer y = 20
integer width = 261
integer height = 136
end type

event constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_Bord3d::Constructor (OVERRIDE)
//* Evenement 		: Constructor
//* Auteur			: PLJ
//* Date				: 21/07/1998 
//* Libellé			: Positionnement de de l'objet uo_Bord3d
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

on uo_bord3d.destroy
call u_bord3d::destroy
end on

type dw_1 from u_datawindow within w_cd_sp_inter
integer x = 155
integer y = 456
integer width = 407
integer height = 384
integer taborder = 10
string dataobject = "d_sp_c_interlocuteur"
boolean border = false
end type

type dw_lst_frais from u_datawindow_detail within w_cd_sp_inter
integer x = 654
integer y = 456
integer width = 407
integer height = 384
integer taborder = 20
string dataobject = "d_sp_c_frais"
boolean border = false
end type

on ue_modifiermenu;call u_datawindow_detail::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet 			: 	W_Cd_Sp_Inter::dw_Frais
//* Evenement 		: 	ue_ModifierMenu
//* Auteur			: 	PLJ
//* Date				: 	31/07/1998
//* Libellé			: 	Changement des propriétés du menu contextuel lié
//*						au u_datawindow_detail
//* Commentaires	: 
//*				     
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Uf_Mnu_CacherItem ( 1 )		// creer
Uf_Mnu_CacherItem ( 3 )		// supprimer
Uf_Mnu_ChangerText ( 2, "Consulter" )		// modifier
end on

type p_focus from picture within w_cd_sp_inter
boolean visible = false
integer x = 2606
integer y = 36
integer width = 91
integer height = 76
boolean bringtotop = true
string picturename = "k:\pb4obj\bmp\focus_1.bmp"
boolean focusrectangle = false
end type

type uo_consult_euro from u_consultation_euro within w_cd_sp_inter
integer x = 251
integer y = 8
integer taborder = 50
end type

on uo_consult_euro.destroy
call u_consultation_euro::destroy
end on

