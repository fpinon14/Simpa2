$PBExportHeader$w_cm_sp_travail.srw
$PBExportComments$---} Fenêtre de consultation des travaux
forward
global type w_cm_sp_travail from w_8_ancetre_consultation
end type
type dw_1 from datawindow within w_cm_sp_travail
end type
type dw_dddw_produit from datawindow within w_cm_sp_travail
end type
type dw_dddw_corbeille from datawindow within w_cm_sp_travail
end type
type dw_dddw_cod_etat from datawindow within w_cm_sp_travail
end type
type dw_dddw_cod_type_recu from datawindow within w_cm_sp_travail
end type
type dw_dddw_cod_recu from datawindow within w_cm_sp_travail
end type
type dw_dddw_cod_i_prov from datawindow within w_cm_sp_travail
end type
end forward

global type w_cm_sp_travail from w_8_ancetre_consultation
integer width = 3648
integer height = 1804
boolean controlmenu = false
boolean minbox = false
dw_1 dw_1
dw_dddw_produit dw_dddw_produit
dw_dddw_corbeille dw_dddw_corbeille
dw_dddw_cod_etat dw_dddw_cod_etat
dw_dddw_cod_type_recu dw_dddw_cod_type_recu
dw_dddw_cod_recu dw_dddw_cod_recu
dw_dddw_cod_i_prov dw_dddw_cod_i_prov
end type
global w_cm_sp_travail w_cm_sp_travail

type variables
Private:
u_Cs_Sp_Travail		iuoConsultation
end variables

forward prototypes
public function boolean wf_preparerconsulter ()
private subroutine wf_positionnerobjets ()
end prototypes

public function boolean wf_preparerconsulter ();//*-----------------------------------------------------------------
//* 
//* Objet			: w_cm_Sp_Travail
//* Fonction		: wf_PreparerConsulter
//* Auteur			: FABRY JF
//* Date				: 16/12/1998 
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

bOk = iuoConsultation.Uf_Preparer_Consulter ( istPass )	

This.Title = iuoConsultation.Uf_Titre ()

Return ( bOk )
end function

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_cm_Sp_Travail::Wf_PositionnerObjets (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 16/12/1998
//* Libellé			: 
//* Commentaires	: On positionne et on taille tous les objets
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* Dw_1  DataWindow : Dw règlement sur Fenêtre Règlement            */
/*------------------------------------------------------------------*/
Dw_1.X				=   71
Dw_1.Y				=  180
Dw_1.Width			= 3443
Dw_1.Height			= 1513


end subroutine

on close;call w_8_ancetre_consultation::close;DESTROY iuoConsultation
end on

on ue_initialiser;call w_8_ancetre_consultation::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_cm_Sp_Travail
//* Evenement 		:	UE_INITIALISER - Extend
//* Auteur			:	Fabry JF
//* Date				:	12/12/1998
//* Libellé			:	Initialisation de la fenêtre de consultation du travail
//*	
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* Positionnement des objets de la fenêtre                          */
/*------------------------------------------------------------------*/

wf_PositionnerObjets()

/*------------------------------------------------------------------*/
/* Déclaration du nvuo liée à la fenêtre                            */
/*------------------------------------------------------------------*/

iuoConsultation = Create u_Cs_Sp_Travail


/*------------------------------------------------------------------------------*/
/* itrTrans							Objet de transaction										  */	
/* Dw_1								DataWindow principale sur fenêtre w_cm_sp_Travail */
/* Dw_dddw_Produit				Dddw des produits sur fenêtre w_cm_sp_Travail     */
/* Dw_dddw_Corbeille				Dddw des Corbeille sur fenêtre w_cm_sp_Travail    */
/* Dw_dddw_Cod_Etat				Dddw des Codes Etats sur fenêtre w_cm_sp_Travail  */
/* Dw_dddw_Cod_Type_Recu		Dddw des Codes Type Recu sur fen. w_cm_sp_Travail */
/* Dw_dddw_CodRecu				Dddw des Codes Recu sur fen. w_cm_sp_Travail 	  */
/* Dw_dddw_CodIProv				Dddw des Codes Inter Provenance sur fen. Idem	  */
/*------------------------------------------------------------------------------*/

iuoConsultation.uf_Init_Travail ( itrTrans, 						&
											 Dw_1,							&
											 Dw_dddw_Produit,				&
											 Dw_dddw_corbeille,			&
											 Dw_dddw_Cod_Etat,			&
											 Dw_dddw_Cod_Type_Recu,		&
											 Dw_dddw_Cod_Recu,			&
											 Dw_dddw_Cod_I_Prov			&
										  )

end on

event we_childactivate;call super::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Cm_Sp_Travail (Extend)
//* Evenement 		: We_ChildActivate
//* Auteur			: JFF
//* Date				: 15/12/1998 
//* Libellé			: Placement de la fenêtre
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

on w_cm_sp_travail.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_dddw_produit=create dw_dddw_produit
this.dw_dddw_corbeille=create dw_dddw_corbeille
this.dw_dddw_cod_etat=create dw_dddw_cod_etat
this.dw_dddw_cod_type_recu=create dw_dddw_cod_type_recu
this.dw_dddw_cod_recu=create dw_dddw_cod_recu
this.dw_dddw_cod_i_prov=create dw_dddw_cod_i_prov
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_dddw_produit
this.Control[iCurrent+3]=this.dw_dddw_corbeille
this.Control[iCurrent+4]=this.dw_dddw_cod_etat
this.Control[iCurrent+5]=this.dw_dddw_cod_type_recu
this.Control[iCurrent+6]=this.dw_dddw_cod_recu
this.Control[iCurrent+7]=this.dw_dddw_cod_i_prov
end on

on w_cm_sp_travail.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_dddw_produit)
destroy(this.dw_dddw_corbeille)
destroy(this.dw_dddw_cod_etat)
destroy(this.dw_dddw_cod_type_recu)
destroy(this.dw_dddw_cod_recu)
destroy(this.dw_dddw_cod_i_prov)
end on

type cb_debug from w_8_ancetre_consultation`cb_debug within w_cm_sp_travail
end type

type st_titre from w_8_ancetre_consultation`st_titre within w_cm_sp_travail
boolean visible = false
integer x = 3205
integer y = 20
integer width = 357
end type

type pb_retour from w_8_ancetre_consultation`pb_retour within w_cm_sp_travail
integer x = 14
integer y = 12
integer width = 242
integer height = 144
integer taborder = 10
end type

type dw_1 from datawindow within w_cm_sp_travail
integer x = 50
integer y = 164
integer width = 507
integer height = 452
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_sp_c_travail"
boolean border = false
boolean livescroll = true
end type

type dw_dddw_produit from datawindow within w_cm_sp_travail
boolean visible = false
integer x = 3282
integer y = 268
integer width = 274
integer height = 164
integer taborder = 30
boolean bringtotop = true
string dataobject = "dddw_sp_produit"
end type

type dw_dddw_corbeille from datawindow within w_cm_sp_travail
boolean visible = false
integer x = 3282
integer y = 496
integer width = 274
integer height = 164
integer taborder = 40
boolean bringtotop = true
string dataobject = "dddw_spb_code"
end type

type dw_dddw_cod_etat from datawindow within w_cm_sp_travail
boolean visible = false
integer x = 3282
integer y = 724
integer width = 274
integer height = 164
integer taborder = 50
boolean bringtotop = true
string dataobject = "dddw_sp_code_car"
end type

type dw_dddw_cod_type_recu from datawindow within w_cm_sp_travail
boolean visible = false
integer x = 3282
integer y = 952
integer width = 274
integer height = 164
integer taborder = 60
boolean bringtotop = true
string dataobject = "dddw_sp_code_car"
end type

type dw_dddw_cod_recu from datawindow within w_cm_sp_travail
boolean visible = false
integer x = 3282
integer y = 1180
integer width = 274
integer height = 164
integer taborder = 70
boolean bringtotop = true
string dataobject = "dddw_sp_code_car"
end type

type dw_dddw_cod_i_prov from datawindow within w_cm_sp_travail
boolean visible = false
integer x = 3282
integer y = 1408
integer width = 274
integer height = 164
integer taborder = 80
boolean bringtotop = true
string dataobject = "dddw_sp_code_car"
end type

