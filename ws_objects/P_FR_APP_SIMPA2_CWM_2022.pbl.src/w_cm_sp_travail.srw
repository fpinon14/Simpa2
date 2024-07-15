HA$PBExportHeader$w_cm_sp_travail.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre de consultation des travaux
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
int Width=3649
int Height=1805
boolean ControlMenu=false
boolean MinBox=false
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

bOk = iuoConsultation.Uf_Preparer_Consulter ( istPass )	

This.Title = iuoConsultation.Uf_Titre ()

Return ( bOk )
end function

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_cm_Sp_Travail::Wf_PositionnerObjets (PRIVATE)
//* Auteur			: Fabry JF
//* Date				: 16/12/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On positionne et on taille tous les objets
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* Dw_1  DataWindow : Dw r$$HEX1$$e800$$ENDHEX$$glement sur Fen$$HEX1$$ea00$$ENDHEX$$tre R$$HEX1$$e800$$ENDHEX$$glement            */
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation du travail
//*	
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* Positionnement des objets de la fen$$HEX1$$ea00$$ENDHEX$$tre                          */
/*------------------------------------------------------------------*/

wf_PositionnerObjets()

/*------------------------------------------------------------------*/
/* D$$HEX1$$e900$$ENDHEX$$claration du nvuo li$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$la fen$$HEX1$$ea00$$ENDHEX$$tre                            */
/*------------------------------------------------------------------*/

iuoConsultation = Create u_Cs_Sp_Travail


/*------------------------------------------------------------------------------*/
/* itrTrans							Objet de transaction										  */	
/* Dw_1								DataWindow principale sur fen$$HEX1$$ea00$$ENDHEX$$tre w_cm_sp_Travail */
/* Dw_dddw_Produit				Dddw des produits sur fen$$HEX1$$ea00$$ENDHEX$$tre w_cm_sp_Travail     */
/* Dw_dddw_Corbeille				Dddw des Corbeille sur fen$$HEX1$$ea00$$ENDHEX$$tre w_cm_sp_Travail    */
/* Dw_dddw_Cod_Etat				Dddw des Codes Etats sur fen$$HEX1$$ea00$$ENDHEX$$tre w_cm_sp_Travail  */
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

on we_childactivate;call w_8_ancetre_consultation::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Cm_Sp_Travail (Extend)
//* Evenement 		: We_ChildActivate
//* Auteur			: JFF
//* Date				: 15/12/1998 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Placement de la fen$$HEX1$$ea00$$ENDHEX$$tre
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

on w_cm_sp_travail.create
int iCurrent
call w_8_ancetre_consultation::create
this.dw_1=create dw_1
this.dw_dddw_produit=create dw_dddw_produit
this.dw_dddw_corbeille=create dw_dddw_corbeille
this.dw_dddw_cod_etat=create dw_dddw_cod_etat
this.dw_dddw_cod_type_recu=create dw_dddw_cod_type_recu
this.dw_dddw_cod_recu=create dw_dddw_cod_recu
this.dw_dddw_cod_i_prov=create dw_dddw_cod_i_prov
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_1
this.Control[iCurrent+2]=dw_dddw_produit
this.Control[iCurrent+3]=dw_dddw_corbeille
this.Control[iCurrent+4]=dw_dddw_cod_etat
this.Control[iCurrent+5]=dw_dddw_cod_type_recu
this.Control[iCurrent+6]=dw_dddw_cod_recu
this.Control[iCurrent+7]=dw_dddw_cod_i_prov
end on

on w_cm_sp_travail.destroy
call w_8_ancetre_consultation::destroy
destroy(this.dw_1)
destroy(this.dw_dddw_produit)
destroy(this.dw_dddw_corbeille)
destroy(this.dw_dddw_cod_etat)
destroy(this.dw_dddw_cod_type_recu)
destroy(this.dw_dddw_cod_recu)
destroy(this.dw_dddw_cod_i_prov)
end on

type st_titre from w_8_ancetre_consultation`st_titre within w_cm_sp_travail
int X=3205
int Y=21
int Width=357
boolean Visible=false
end type

type pb_retour from w_8_ancetre_consultation`pb_retour within w_cm_sp_travail
int X=14
int Y=13
int TabOrder=10
end type

type dw_1 from datawindow within w_cm_sp_travail
int X=51
int Y=165
int Width=508
int Height=453
int TabOrder=20
boolean BringToTop=true
string DataObject="d_sp_c_travail"
boolean Border=false
boolean LiveScroll=true
end type

type dw_dddw_produit from datawindow within w_cm_sp_travail
int X=3283
int Y=269
int Width=275
int Height=165
int TabOrder=30
boolean Visible=false
boolean BringToTop=true
string DataObject="dddw_sp_produit"
end type

type dw_dddw_corbeille from datawindow within w_cm_sp_travail
int X=3283
int Y=497
int Width=275
int Height=165
int TabOrder=40
boolean Visible=false
boolean BringToTop=true
string DataObject="dddw_spb_code"
end type

type dw_dddw_cod_etat from datawindow within w_cm_sp_travail
int X=3283
int Y=725
int Width=275
int Height=165
int TabOrder=50
boolean Visible=false
boolean BringToTop=true
string DataObject="dddw_sp_code_car"
end type

type dw_dddw_cod_type_recu from datawindow within w_cm_sp_travail
int X=3283
int Y=953
int Width=275
int Height=165
int TabOrder=60
boolean Visible=false
boolean BringToTop=true
string DataObject="dddw_sp_code_car"
end type

type dw_dddw_cod_recu from datawindow within w_cm_sp_travail
int X=3283
int Y=1181
int Width=275
int Height=165
int TabOrder=70
boolean Visible=false
boolean BringToTop=true
string DataObject="dddw_sp_code_car"
end type

type dw_dddw_cod_i_prov from datawindow within w_cm_sp_travail
int X=3283
int Y=1409
int Width=275
int Height=165
int TabOrder=80
boolean Visible=false
boolean BringToTop=true
string DataObject="dddw_sp_code_car"
end type

